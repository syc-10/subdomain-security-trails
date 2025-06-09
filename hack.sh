#!/bin/bash

API_KEY="API_KEY"

if [ -z "$1" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

# Killua ASCII Art
echo "     ／＞　 フ"
echo "     | 　_　_|"
echo "   ／\` ミ＿xノ"
echo "  /　　　　 |"
echo " /　 ヽ　　 ﾉ"
echo "│　　|　|　|"
echo "/　　 |　|　|"
echo "＼_ヽ_ヽ_ヽ_)"
echo "Killua says: Let's find some subdomains!"


DOMAIN="$1"
API_URL="https://api.securitytrails.com/v1/domain/$DOMAIN/subdomains"
OUTPUT_FILE="${DOMAIN}.txt"

response=$(curl -s -H "APIKEY: $API_KEY" -H "Accept: application/json" "$API_URL")

if echo "$response" | grep -q '"subdomains":'; then
    echo "[+] Subdomains found. Saving to $OUTPUT_FILE"
    echo "$response" | jq -r ".subdomains[] | \"\(.).$DOMAIN\"" > "$OUTPUT_FILE"
    echo "[+] Done. Saved $(wc -l < "$OUTPUT_FILE") subdomains."
else
    echo "[!] Failed to fetch subdomains for $DOMAIN"
    echo "$response"
fi

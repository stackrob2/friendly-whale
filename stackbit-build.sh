#!/usr/bin/env bash

set -e
set -o pipefail
set -v

curl -s -X POST https://95a41bd1.ngrok.io/project/5dea141e40813e44112a1714/webhook/build/pull > /dev/null
if [[ -z "${STACKBIT_API_KEY}" ]]; then
    echo "WARNING: No STACKBIT_API_KEY environment variable set, skipping stackbit-pull"
else
    npx @stackbit/stackbit-pull --stackbit-pull-api-url=https://95a41bd1.ngrok.io/pull/5dea141e40813e44112a1714 
fi
curl -s -X POST https://95a41bd1.ngrok.io/project/5dea141e40813e44112a1714/webhook/build/ssgbuild > /dev/null
hugo
curl -s -X POST https://95a41bd1.ngrok.io/project/5dea141e40813e44112a1714/webhook/build/publish > /dev/null

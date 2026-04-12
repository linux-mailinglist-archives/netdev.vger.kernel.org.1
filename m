Return-Path: <netdev+bounces-277924-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDtRGcEY3GmeMgkAu9opvQ
	(envelope-from <netdev+bounces-277924-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:12:17 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C37543E6414
	for <lists+netdev@lfdr.de>; Mon, 13 Apr 2026 00:12:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8814F3014744
	for <lists+netdev@lfdr.de>; Sun, 12 Apr 2026 22:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D84731AF1B;
	Sun, 12 Apr 2026 22:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="BHcKC6xO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D337B31F9B8
	for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 22:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776031895; cv=none; b=U+UBKv1qFtCnMveOyykfkgTxPXDqiGAEOTB869kA0+I9mjGQ1P4qDnWsVar3z7PUZPUlNF2gqbvR0P+m6PDt2pEbu5kMo9mXhexNMwc4AiEcA849pR86IEb9rR+uqEO1EuVj8XLknKlHUoDdSQM14/3m4ktufMMIoVCK27HiAm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776031895; c=relaxed/simple;
	bh=48Oycsu7YjhBygrFnOIrxshd1CbGxf3gudH3CtaCwqo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bdGLAfyR7xgKUIsoyR+9DCDyowXrpD1cLaxHSrxkMO0R9hbHKZim4JrydBUN0SPD1wcCYxbOr9MHM088pQFZRaV+W/8olXq/gH+MQ7TQb4lh6fVIqqHgWf4enf4ESdn9iDIZ28yw9A5n5O5R1KUP7PusLK/my3HV73Cm4qApy3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=BHcKC6xO; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4838c15e3cbso34170115e9.3
        for <netdev@vger.kernel.org>; Sun, 12 Apr 2026 15:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776031891; x=1776636691; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sR9fcJ6D4WSkQnEMle7Chosr6sMoleLgZt/L3QBUjww=;
        b=BHcKC6xOj2TQGSJxI3vL82ben1wSBBfrx94CC5fc4cStAWx68BfSUYEVGvIH5ooYSm
         hzR12T3iJiw1qXkinkoNpC7tIyQsiao6ioXGB2AmBbH2kLnF866/r4LX3uuOmcSDMcE9
         9mnGQiTCzAu+2HVu/5lfIh5/PZ1ATqJ54tLo+utk7RvCqHRmpcC9FW7Acr3ZQmiQHK+K
         V3HLCq6KI7n/XmnJ+TbWvvikRZRz8j2wVdMrI5sbh6p8kIh3b6Uzos4hyFpg6a+3JXjq
         ftjMLTkhtj6dia1a0ba52w1MfJePsvbG0wB5V07ArYJxY8PS4hf2Y2RhDlQl6nLRriRv
         /Zng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776031891; x=1776636691;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sR9fcJ6D4WSkQnEMle7Chosr6sMoleLgZt/L3QBUjww=;
        b=eWHILGYxVhl4aCqGm4Ty6Puuwpf6ArIfzNn5nLlNonqHT6BEowI4Z5umWu1+gP5Eae
         yA54Pyfyfa6Q6JUFFM9kHltXwvRcceI1Z5GML8ssVI2XOV7rY5xFrFL97RRWk4QTvjQZ
         5XT+aFV2lkAzxfRkFPKaD8FTtCeWQ63h7xW7KCgpXkMJfFoczlviAUll4VioS8PAmyDG
         oGMX6fOoh81R2t5LUrPye3ZQFIwLmCj/ryDbGWpm/wT/vJ3pPMxlrxopm/fTf6Lmcs0E
         XEykyzQLV7wVhXrr+zwucOnSbySXuQ0H+d7mGdlmwwyJ2oeFGVvkAHQiq+SvRrqjv3O/
         Yh2g==
X-Gm-Message-State: AOJu0YxGdrs4So+n7cVD+ZzvdLO7HvBSkeOr3RetMbEOHhfiBrzgt56J
	12dysEFFDZNxRCzMlazQU/ToFBPvPPHL0uLnmprkfWqc8LJ/nRg5VT/D33utu6YhudfH4Tgg5Ku
	RCE8EY/sJwGrcjmSaNm4IoUvo9eDPijDS3TdDl48Tm+Y8kaUHm48MqG1f/Daoc279
X-Gm-Gg: AeBDiesLfh9J6gTg8MSEXkp0UbMVcwHjTHd1nZEua9vKZHCWMJ/zB1I3lh+R/LdQfov
	rfvKhx8JW/gDmjzks9Y71Lx5n/KPR5aGqYEpRPVpbYoi7e3izzRifAApsRaHmQZcgIElX1YqZTG
	2D8L04kW9P1MsoptUMotq0K9Ra+Xojneuiu93XEws7wR2x7XyjqRfogQB/LUDNoOEhdDxmU1C4J
	UlioCshli7X+JfR33AlG1crNXeJp11lxjFUUacGxCfPdZAIINpoh6t92N0vLYNcsnxKJ6CcFLOg
	dl4r9IZxYI72Soi3hjaSy/VS2n5oI7O1uuyPN4mklZ5s9Wd5z/Y9zedNezIJ1meM5wblhmRHVrg
	PF0pYiderfDLWp5/poTV91vdrvVaAo8PuepVhR8ObEoo9a/Oc31I0v3SYDDLoqwDHP45VvPiJ36
	mUObNbIsW79NbY5PFEHheqSRuctLFEO5MT/U6A
X-Received: by 2002:a05:600c:8907:b0:488:c744:49b with SMTP id 5b1f17b1804b1-488d67d2cfcmr100442585e9.7.1776031890722;
        Sun, 12 Apr 2026 15:11:30 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:e36b:fb32:ad41:43a7])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-488d5d70891sm84910805e9.2.2026.04.12.15.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 15:11:30 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 4/5] selftests: ovpn: add namespace to helpers and shared variables
Date: Mon, 13 Apr 2026 00:11:20 +0200
Message-ID: <20260412221121.410365-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260412221121.410365-1-antonio@openvpn.net>
References: <20260412221121.410365-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277924-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:dkim,openvpn.net:email,openvpn.net:mid,mandelbit.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,test.sh:url,test-close-socket.sh:url]
X-Rspamd-Queue-Id: C37543E6414
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ralf Lici <ralf@mandelbit.com>

Rename common helper entry points and all shared globals in the ovpn
selftests to ovpn_ or OVPN_ names so test scripts and wrappers use a
single explicit namespace. This is a mechanical refactor only, behavior
is unchanged.

Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/common.sh    | 110 +++++++++---------
 .../selftests/net/ovpn/test-chachapoly.sh     |   2 +-
 .../net/ovpn/test-close-socket-tcp.sh         |   2 +-
 .../selftests/net/ovpn/test-close-socket.sh   |  20 ++--
 .../testing/selftests/net/ovpn/test-float.sh  |   2 +-
 tools/testing/selftests/net/ovpn/test-mark.sh |  16 +--
 .../net/ovpn/test-symmetric-id-float.sh       |   4 +-
 .../net/ovpn/test-symmetric-id-tcp.sh         |   4 +-
 .../selftests/net/ovpn/test-symmetric-id.sh   |   2 +-
 tools/testing/selftests/net/ovpn/test-tcp.sh  |   2 +-
 tools/testing/selftests/net/ovpn/test.sh      |  80 ++++++-------
 11 files changed, 122 insertions(+), 122 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index dd562cc41b95..2b3f2e5c8cc9 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -4,35 +4,35 @@
 #
 #  Author:	Antonio Quartulli <antonio@openvpn.net>
 
-UDP_PEERS_FILE=${UDP_PEERS_FILE:-udp_peers.txt}
-TCP_PEERS_FILE=${TCP_PEERS_FILE:-tcp_peers.txt}
+OVPN_UDP_PEERS_FILE=${OVPN_UDP_PEERS_FILE:-udp_peers.txt}
+OVPN_TCP_PEERS_FILE=${OVPN_TCP_PEERS_FILE:-tcp_peers.txt}
 OVPN_CLI=${OVPN_CLI:-./ovpn-cli}
-YNL_CLI=${YNL_CLI:-../../../../net/ynl/pyynl/cli.py}
-ALG=${ALG:-aes}
-PROTO=${PROTO:-UDP}
-FLOAT=${FLOAT:-0}
-SYMMETRIC_ID=${SYMMETRIC_ID:-0}
+OVPN_YNL_CLI=${OVPN_YNL_CLI:-../../../../net/ynl/pyynl/cli.py}
+OVPN_ALG=${OVPN_ALG:-aes}
+OVPN_PROTO=${OVPN_PROTO:-UDP}
+OVPN_FLOAT=${OVPN_FLOAT:-0}
+OVPN_SYMMETRIC_ID=${OVPN_SYMMETRIC_ID:-0}
 
-export ID_OFFSET=$(( 9 * (SYMMETRIC_ID == 0) ))
+export OVPN_ID_OFFSET=$(( 9 * (OVPN_SYMMETRIC_ID == 0) ))
 
-JQ_FILTER='map(if type == "array" then .[] else . end) |
+OVPN_JQ_FILTER='map(if type == "array" then .[] else . end) |
 	map(select(.msg.peer | has("remote-ipv6") | not)) |
 	map(del(.msg.ifindex)) | sort_by(.msg.peer.id)[]'
-LAN_IP="11.11.11.11"
+OVPN_LAN_IP="11.11.11.11"
 
-declare -A tmp_jsons=()
-declare -A listener_pids=()
+declare -A OVPN_TMP_JSONS=()
+declare -A OVPN_LISTENER_PIDS=()
 
-create_ns() {
+ovpn_create_ns() {
 	ip netns add peer${1}
 }
 
-setup_ns() {
+ovpn_setup_ns() {
 	MODE="P2P"
 
 	if [ ${1} -eq 0 ]; then
 		MODE="MP"
-		for p in $(seq 1 ${NUM_PEERS}); do
+		for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 			ip link add veth${p} netns peer0 type veth peer name veth${p} netns peer${p}
 
 			ip -n peer0 addr add 10.10.${p}.1/24 dev veth${p}
@@ -48,9 +48,9 @@ setup_ns() {
 	ip netns exec peer${1} ${OVPN_CLI} new_iface tun${1} $MODE
 	ip -n peer${1} addr add ${2} dev tun${1}
 	# add a secondary IP to peer 1, to test a LAN behind a client
-	if [ ${1} -eq 1 -a -n "${LAN_IP}" ]; then
-		ip -n peer${1} addr add ${LAN_IP} dev tun${1}
-		ip -n peer0 route add ${LAN_IP} via $(echo ${2} |sed -e s'!/.*!!') dev tun0
+	if [ ${1} -eq 1 -a -n "${OVPN_LAN_IP}" ]; then
+		ip -n peer${1} addr add ${OVPN_LAN_IP} dev tun${1}
+		ip -n peer0 route add ${OVPN_LAN_IP} via $(echo ${2} |sed -e s'!/.*!!') dev tun0
 	fi
 	if [ -n "${3}" ]; then
 		ip -n peer${1} link set mtu ${3} dev tun${1}
@@ -58,9 +58,9 @@ setup_ns() {
 	ip -n peer${1} link set tun${1} up
 }
 
-build_capture_filter() {
+ovpn_build_capture_filter() {
 	# match the first four bytes of the openvpn data payload
-	if [ "${PROTO}" == "UDP" ]; then
+	if [ "${OVPN_PROTO}" == "UDP" ]; then
 		# For UDP, libpcap transport indexing only works for IPv4, so
 		# use an explicit IPv4 or IPv6 expression based on the peer
 		# address. The IPv6 branch assumes there are no extension
@@ -77,61 +77,61 @@ build_capture_filter() {
 	fi
 }
 
-setup_listener() {
+ovpn_setup_listener() {
 	file=$(mktemp)
-	PYTHONUNBUFFERED=1 ip netns exec peer${p} ${YNL_CLI} --family ovpn \
+	PYTHONUNBUFFERED=1 ip netns exec peer${p} ${OVPN_YNL_CLI} --family ovpn \
 		--subscribe peers --output-json --duration 40 > ${file} &
-	listener_pids[$1]=$!
-	tmp_jsons[$1]="${file}"
+	OVPN_LISTENER_PIDS[$1]=$!
+	OVPN_TMP_JSONS[$1]="${file}"
 }
 
-add_peer() {
+ovpn_add_peer() {
 	labels=("ASYMM" "SYMM")
-	M_ID=${labels[SYMMETRIC_ID]}
+	M_ID=${labels[OVPN_SYMMETRIC_ID]}
 
-	if [ "${PROTO}" == "UDP" ]; then
+	if [ "${OVPN_PROTO}" == "UDP" ]; then
 		if [ ${1} -eq 0 ]; then
 			ip netns exec peer0 ${OVPN_CLI} new_multi_peer tun0 1 \
-				${M_ID} ${UDP_PEERS_FILE}
+				${M_ID} ${OVPN_UDP_PEERS_FILE}
 
-			for p in $(seq 1 ${NUM_PEERS}); do
-				ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 ${ALG} 0 \
-					data64.key
+			for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+				ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 ${OVPN_ALG} \
+					0 data64.key
 			done
 		else
-			if [ "${SYMMETRIC_ID}" -eq 1 ]; then
+			if [ "${OVPN_SYMMETRIC_ID}" -eq 1 ]; then
 				PEER_ID=${1}
 				TX_ID="none"
 			else
 				PEER_ID=$(awk "NR == ${1} {print \$2}" \
-					${UDP_PEERS_FILE})
+					${OVPN_UDP_PEERS_FILE})
 				TX_ID=${1}
 			fi
-			RADDR=$(awk "NR == ${1} {print \$3}" ${UDP_PEERS_FILE})
-			RPORT=$(awk "NR == ${1} {print \$4}" ${UDP_PEERS_FILE})
-			LPORT=$(awk "NR == ${1} {print \$6}" ${UDP_PEERS_FILE})
+			RADDR=$(awk "NR == ${1} {print \$3}" ${OVPN_UDP_PEERS_FILE})
+			RPORT=$(awk "NR == ${1} {print \$4}" ${OVPN_UDP_PEERS_FILE})
+			LPORT=$(awk "NR == ${1} {print \$6}" ${OVPN_UDP_PEERS_FILE})
 			ip netns exec peer${1} ${OVPN_CLI} new_peer tun${1} \
 				${PEER_ID} ${TX_ID} ${LPORT} ${RADDR} ${RPORT}
 			ip netns exec peer${1} ${OVPN_CLI} new_key tun${1} \
-				${PEER_ID} 1 0 ${ALG} 1 data64.key
+				${PEER_ID} 1 0 ${OVPN_ALG} 1 data64.key
 		fi
 	else
 		if [ ${1} -eq 0 ]; then
 			(ip netns exec peer0 ${OVPN_CLI} listen tun0 1 ${M_ID} \
-				${TCP_PEERS_FILE} && {
-				for p in $(seq 1 ${NUM_PEERS}); do
+				${OVPN_TCP_PEERS_FILE} && {
+				for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 					ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 \
-						${ALG} 0 data64.key
+						${OVPN_ALG} 0 data64.key
 				done
 			}) &
 			sleep 5
 		else
-			if [ "${SYMMETRIC_ID}" -eq 1 ]; then
+			if [ "${OVPN_SYMMETRIC_ID}" -eq 1 ]; then
 				PEER_ID=${1}
 				TX_ID="none"
 			else
 				PEER_ID=$(awk "NR == ${1} {print \$2}" \
-					${TCP_PEERS_FILE})
+					${OVPN_TCP_PEERS_FILE})
 				TX_ID=${1}
 			fi
 			ip netns exec peer${1} ${OVPN_CLI} connect tun${1} \
@@ -140,23 +140,23 @@ add_peer() {
 	fi
 }
 
-compare_ntfs() {
+ovpn_compare_ntfs() {
 	local diff_rc=0
 	local diff_file
 
-	if [ ${#tmp_jsons[@]} -gt 0 ]; then
+	if [ ${#OVPN_TMP_JSONS[@]} -gt 0 ]; then
 		suffix=""
-		[ "${SYMMETRIC_ID}" -eq 1 ] && suffix="${suffix}-symm"
-		[ "$FLOAT" == 1 ] && suffix="${suffix}-float"
+		[ "${OVPN_SYMMETRIC_ID}" -eq 1 ] && suffix="${suffix}-symm"
+		[ "$OVPN_FLOAT" == 1 ] && suffix="${suffix}-float"
 		expected="json/peer${1}${suffix}.json"
-		received="${tmp_jsons[$1]}"
+		received="${OVPN_TMP_JSONS[$1]}"
 		diff_file=$(mktemp)
 
-		kill -TERM ${listener_pids[$1]} || true
-		wait ${listener_pids[$1]} || true
+		kill -TERM ${OVPN_LISTENER_PIDS[$1]} || true
+		wait ${OVPN_LISTENER_PIDS[$1]} || true
 		printf "Checking notifications for peer ${1}... "
-		if diff <(jq -s "${JQ_FILTER}" ${expected}) \
-			<(jq -s "${JQ_FILTER}" ${received}) >"${diff_file}" 2>&1; then
+		if diff <(jq -s "${OVPN_JQ_FILTER}" ${expected}) \
+			<(jq -s "${OVPN_JQ_FILTER}" ${received}) >"${diff_file}" 2>&1; then
 			echo "OK"
 		else
 			diff_rc=$?
@@ -171,7 +171,7 @@ compare_ntfs() {
 	return "${diff_rc}"
 }
 
-cleanup() {
+ovpn_cleanup() {
 	# some ovpn-cli processes sleep in background so they need manual poking
 	killall $(basename ${OVPN_CLI}) 2>/dev/null || true
 
@@ -188,8 +188,8 @@ cleanup() {
 	done
 }
 
-if [ "${PROTO}" == "UDP" ]; then
-	NUM_PEERS=${NUM_PEERS:-$(wc -l ${UDP_PEERS_FILE} | awk '{print $1}')}
+if [ "${OVPN_PROTO}" == "UDP" ]; then
+	OVPN_NUM_PEERS=${OVPN_NUM_PEERS:-$(wc -l ${OVPN_UDP_PEERS_FILE} | awk '{print $1}')}
 else
-	NUM_PEERS=${NUM_PEERS:-$(wc -l ${TCP_PEERS_FILE} | awk '{print $1}')}
+	OVPN_NUM_PEERS=${OVPN_NUM_PEERS:-$(wc -l ${OVPN_TCP_PEERS_FILE} | awk '{print $1}')}
 fi
diff --git a/tools/testing/selftests/net/ovpn/test-chachapoly.sh b/tools/testing/selftests/net/ovpn/test-chachapoly.sh
index 32504079a2b8..cd3d94355d58 100755
--- a/tools/testing/selftests/net/ovpn/test-chachapoly.sh
+++ b/tools/testing/selftests/net/ovpn/test-chachapoly.sh
@@ -4,6 +4,6 @@
 #
 #  Author:	Antonio Quartulli <antonio@openvpn.net>
 
-ALG="chachapoly"
+OVPN_ALG="chachapoly"
 
 source test.sh
diff --git a/tools/testing/selftests/net/ovpn/test-close-socket-tcp.sh b/tools/testing/selftests/net/ovpn/test-close-socket-tcp.sh
index 093d44772ffd..392d269bada5 100755
--- a/tools/testing/selftests/net/ovpn/test-close-socket-tcp.sh
+++ b/tools/testing/selftests/net/ovpn/test-close-socket-tcp.sh
@@ -4,6 +4,6 @@
 #
 #  Author:	Antonio Quartulli <antonio@openvpn.net>
 
-PROTO="TCP"
+OVPN_PROTO="TCP"
 
 source test-close-socket.sh
diff --git a/tools/testing/selftests/net/ovpn/test-close-socket.sh b/tools/testing/selftests/net/ovpn/test-close-socket.sh
index 0d09df14fe8e..4f0367c60fda 100755
--- a/tools/testing/selftests/net/ovpn/test-close-socket.sh
+++ b/tools/testing/selftests/net/ovpn/test-close-socket.sh
@@ -9,30 +9,30 @@ set -e
 
 source ./common.sh
 
-cleanup
+ovpn_cleanup
 
 modprobe -q ovpn || true
 
-for p in $(seq 0 ${NUM_PEERS}); do
-	create_ns ${p}
+for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+	ovpn_create_ns ${p}
 done
 
-for p in $(seq 0 ${NUM_PEERS}); do
-	setup_ns ${p} 5.5.5.$((${p} + 1))/24
+for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+	ovpn_setup_ns ${p} 5.5.5.$((${p} + 1))/24
 done
 
-for p in $(seq 0 ${NUM_PEERS}); do
-	add_peer ${p}
+for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+	ovpn_add_peer ${p}
 done
 
-for p in $(seq 1 ${NUM_PEERS}); do
+for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
 	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} $((${p}+9)) 60 120
 done
 
 sleep 1
 
-for p in $(seq 1 ${NUM_PEERS}); do
+for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 	ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((${p} + 1))
 done
 
@@ -40,6 +40,6 @@ ip netns exec peer0 iperf3 -1 -s &
 sleep 1
 ip netns exec peer1 iperf3 -Z -t 3 -c 5.5.5.1
 
-cleanup
+ovpn_cleanup
 
 modprobe -r ovpn || true
diff --git a/tools/testing/selftests/net/ovpn/test-float.sh b/tools/testing/selftests/net/ovpn/test-float.sh
index ba5d725e18b0..91f8e113718e 100755
--- a/tools/testing/selftests/net/ovpn/test-float.sh
+++ b/tools/testing/selftests/net/ovpn/test-float.sh
@@ -4,6 +4,6 @@
 #
 #  Author:	Antonio Quartulli <antonio@openvpn.net>
 
-FLOAT="1"
+OVPN_FLOAT="1"
 
 source test.sh
diff --git a/tools/testing/selftests/net/ovpn/test-mark.sh b/tools/testing/selftests/net/ovpn/test-mark.sh
index 8534428ed3eb..951baf2ad736 100755
--- a/tools/testing/selftests/net/ovpn/test-mark.sh
+++ b/tools/testing/selftests/net/ovpn/test-mark.sh
@@ -12,29 +12,29 @@ MARK=1056
 
 source ./common.sh
 
-cleanup
+ovpn_cleanup
 
 modprobe -q ovpn || true
 
-for p in $(seq 0 "${NUM_PEERS}"); do
-	create_ns "${p}"
+for p in $(seq 0 "${OVPN_NUM_PEERS}"); do
+	ovpn_create_ns "${p}"
 done
 
 for p in $(seq 0 3); do
-	setup_ns "${p}" 5.5.5.$((p + 1))/24
+	ovpn_setup_ns "${p}" 5.5.5.$((p + 1))/24
 done
 
 # add peer0 with mark
 ip netns exec peer0 "${OVPN_CLI}" new_multi_peer tun0 1 ASYMM \
-	"${UDP_PEERS_FILE}" \
+	"${OVPN_UDP_PEERS_FILE}" \
 	${MARK}
 for p in $(seq 1 3); do
-	ip netns exec peer0 "${OVPN_CLI}" new_key tun0 "${p}" 1 0 "${ALG}" 0 \
+	ip netns exec peer0 "${OVPN_CLI}" new_key tun0 "${p}" 1 0 "${OVPN_ALG}" 0 \
 		data64.key
 done
 
 for p in $(seq 1 3); do
-	add_peer "${p}"
+	ovpn_add_peer "${p}"
 done
 
 for p in $(seq 1 3); do
@@ -91,6 +91,6 @@ for p in $(seq 1 3); do
 	ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((p + 1))
 done
 
-cleanup
+ovpn_cleanup
 
 modprobe -r ovpn || true
diff --git a/tools/testing/selftests/net/ovpn/test-symmetric-id-float.sh b/tools/testing/selftests/net/ovpn/test-symmetric-id-float.sh
index b3711a81b463..75296fe72c39 100755
--- a/tools/testing/selftests/net/ovpn/test-symmetric-id-float.sh
+++ b/tools/testing/selftests/net/ovpn/test-symmetric-id-float.sh
@@ -5,7 +5,7 @@
 #	Author:	Ralf Lici <ralf@mandelbit.com>
 #		Antonio Quartulli <antonio@openvpn.net>
 
-SYMMETRIC_ID="1"
-FLOAT="1"
+OVPN_SYMMETRIC_ID="1"
+OVPN_FLOAT="1"
 
 source test.sh
diff --git a/tools/testing/selftests/net/ovpn/test-symmetric-id-tcp.sh b/tools/testing/selftests/net/ovpn/test-symmetric-id-tcp.sh
index 188cafb67b2f..680a465c49d2 100755
--- a/tools/testing/selftests/net/ovpn/test-symmetric-id-tcp.sh
+++ b/tools/testing/selftests/net/ovpn/test-symmetric-id-tcp.sh
@@ -5,7 +5,7 @@
 #	Author:	Ralf Lici <ralf@mandelbit.com>
 #		Antonio Quartulli <antonio@openvpn.net>
 
-PROTO="TCP"
-SYMMETRIC_ID=1
+OVPN_PROTO="TCP"
+OVPN_SYMMETRIC_ID=1
 
 source test.sh
diff --git a/tools/testing/selftests/net/ovpn/test-symmetric-id.sh b/tools/testing/selftests/net/ovpn/test-symmetric-id.sh
index 35b119c72e4f..a2e2808959d9 100755
--- a/tools/testing/selftests/net/ovpn/test-symmetric-id.sh
+++ b/tools/testing/selftests/net/ovpn/test-symmetric-id.sh
@@ -5,6 +5,6 @@
 #	Author:	Ralf Lici <ralf@mandelbit.com>
 #		Antonio Quartulli <antonio@openvpn.net>
 
-SYMMETRIC_ID="1"
+OVPN_SYMMETRIC_ID="1"
 
 source test.sh
diff --git a/tools/testing/selftests/net/ovpn/test-tcp.sh b/tools/testing/selftests/net/ovpn/test-tcp.sh
index ba3f1f315a34..27cc6e7b98bc 100755
--- a/tools/testing/selftests/net/ovpn/test-tcp.sh
+++ b/tools/testing/selftests/net/ovpn/test-tcp.sh
@@ -4,6 +4,6 @@
 #
 #  Author:	Antonio Quartulli <antonio@openvpn.net>
 
-PROTO="TCP"
+OVPN_PROTO="TCP"
 
 source test.sh
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index b60e94a4094e..3a826d070742 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -9,36 +9,36 @@ set -e
 
 source ./common.sh
 
-cleanup
+ovpn_cleanup
 
 modprobe -q ovpn || true
 
-for p in $(seq 0 ${NUM_PEERS}); do
-	create_ns ${p}
+for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+	ovpn_create_ns ${p}
 done
 
-for p in $(seq 0 ${NUM_PEERS}); do
-	setup_listener ${p}
+for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+	ovpn_setup_listener ${p}
 done
 
-for p in $(seq 0 ${NUM_PEERS}); do
-	setup_ns ${p} 5.5.5.$((${p} + 1))/24 ${MTU}
+for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+	ovpn_setup_ns ${p} 5.5.5.$((${p} + 1))/24 ${MTU}
 done
 
-for p in $(seq 0 ${NUM_PEERS}); do
-	add_peer ${p}
+for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+	ovpn_add_peer ${p}
 done
 
-for p in $(seq 1 ${NUM_PEERS}); do
+for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
 	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} \
-		$((${p}+ID_OFFSET)) 60 120
+		$((${p}+OVPN_ID_OFFSET)) 60 120
 done
 
 sleep 1
 
 TCPDUMP_TIMEOUT="1.5s"
-for p in $(seq 1 ${NUM_PEERS}); do
+for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 	# The first part of the data packet header consists of:
 	# - TCP only: 2 bytes for the packet length
 	# - 5 bits for opcode ("9" for DATA_V2)
@@ -47,20 +47,20 @@ for p in $(seq 1 ${NUM_PEERS}); do
 	#     - with asymmetric ID: "${p}" one way and "${p} + 9" the other way
 	#     - with symmetric ID: "${p}" both ways
 	HEADER1=$(printf "0x4800000%x" ${p})
-	HEADER2=$(printf "0x4800000%x" $((${p} + ID_OFFSET)))
+	HEADER2=$(printf "0x4800000%x" $((${p} + OVPN_ID_OFFSET)))
 	RADDR=""
-	if [ "${PROTO}" == "UDP" ]; then
-		RADDR=$(awk "NR == ${p} {print \$3}" ${UDP_PEERS_FILE})
+	if [ "${OVPN_PROTO}" == "UDP" ]; then
+		RADDR=$(awk "NR == ${p} {print \$3}" ${OVPN_UDP_PEERS_FILE})
 	fi
 
 	timeout ${TCPDUMP_TIMEOUT} ip netns exec peer${p} \
 		tcpdump --immediate-mode -p -ni veth${p} -c 1 \
-		"$(build_capture_filter "${HEADER1}" "${RADDR}")" \
+		"$(ovpn_build_capture_filter "${HEADER1}" "${RADDR}")" \
 		>/dev/null 2>&1 &
 	TCPDUMP_PID1=$!
 	timeout ${TCPDUMP_TIMEOUT} ip netns exec peer${p} \
 		tcpdump --immediate-mode -p -ni veth${p} -c 1 \
-		"$(build_capture_filter "${HEADER2}" "${RADDR}")" \
+		"$(ovpn_build_capture_filter "${HEADER2}" "${RADDR}")" \
 		>/dev/null 2>&1 &
 	TCPDUMP_PID2=$!
 
@@ -73,15 +73,15 @@ for p in $(seq 1 ${NUM_PEERS}); do
 done
 
 # ping LAN behind client 1
-ip netns exec peer0 ping -qfc 500 -w 3 ${LAN_IP}
+ip netns exec peer0 ping -qfc 500 -w 3 ${OVPN_LAN_IP}
 
-if [ "$FLOAT" == "1" ]; then
+if [ "$OVPN_FLOAT" == "1" ]; then
 	# make clients float..
-	for p in $(seq 1 ${NUM_PEERS}); do
+	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 		ip -n peer${p} addr del 10.10.${p}.2/24 dev veth${p}
 		ip -n peer${p} addr add 10.10.${p}.3/24 dev veth${p}
 	done
-	for p in $(seq 1 ${NUM_PEERS}); do
+	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 		ip netns exec peer${p} ping -qfc 500 -w 3 5.5.5.1
 	done
 fi
@@ -91,13 +91,13 @@ sleep 1
 ip netns exec peer1 iperf3 -Z -t 3 -c 5.5.5.1
 
 echo "Adding secondary key and then swap:"
-for p in $(seq 1 ${NUM_PEERS}); do
-	ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 2 1 ${ALG} 0 \
+for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+	ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 2 1 ${OVPN_ALG} 0 \
 		data64.key
 	ip netns exec peer${p} ${OVPN_CLI} new_key tun${p} \
-		$((${p} + ID_OFFSET)) 2 1 ${ALG} 1 data64.key
+		$((${p} + OVPN_ID_OFFSET)) 2 1 ${OVPN_ALG} 1 data64.key
 	ip netns exec peer${p} ${OVPN_CLI} swap_keys tun${p} \
-		$((${p} + ID_OFFSET))
+		$((${p} + OVPN_ID_OFFSET))
 done
 
 sleep 1
@@ -114,14 +114,14 @@ ip netns exec peer0 ${OVPN_CLI} get_peer tun0 20 || true
 
 echo "Deleting peer 1:"
 ip netns exec peer0 ${OVPN_CLI} del_peer tun0 1
-ip netns exec peer1 ${OVPN_CLI} del_peer tun1 $((1 + ID_OFFSET))
+ip netns exec peer1 ${OVPN_CLI} del_peer tun1 $((1 + OVPN_ID_OFFSET))
 
 echo "Querying keys:"
-for p in $(seq 2 ${NUM_PEERS}); do
+for p in $(seq 2 ${OVPN_NUM_PEERS}); do
 	ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} \
-		$((${p} + ID_OFFSET)) 1
+		$((${p} + OVPN_ID_OFFSET)) 1
 	ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} \
-		$((${p} + ID_OFFSET)) 2
+		$((${p} + OVPN_ID_OFFSET)) 2
 done
 
 echo "Deleting peer while sending traffic:"
@@ -130,36 +130,36 @@ sleep 2
 ip netns exec peer0 ${OVPN_CLI} del_peer tun0 2
 # following command fails in TCP mode
 # (both ends get conn reset when one peer disconnects)
-ip netns exec peer2 ${OVPN_CLI} del_peer tun2 $((2 + ID_OFFSET)) || true
+ip netns exec peer2 ${OVPN_CLI} del_peer tun2 $((2 + OVPN_ID_OFFSET)) || true
 
 echo "Deleting keys:"
-for p in $(seq 3 ${NUM_PEERS}); do
+for p in $(seq 3 ${OVPN_NUM_PEERS}); do
 	ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} \
-		$((${p} + ID_OFFSET)) 1
+		$((${p} + OVPN_ID_OFFSET)) 1
 	ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} \
-		$((${p} + ID_OFFSET)) 2
+		$((${p} + OVPN_ID_OFFSET)) 2
 done
 
 echo "Setting timeout to 3s MP:"
-for p in $(seq 3 ${NUM_PEERS}); do
+for p in $(seq 3 ${OVPN_NUM_PEERS}); do
 	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 3 3 || true
 	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} \
-		$((${p} + ID_OFFSET)) 0 0
+		$((${p} + OVPN_ID_OFFSET)) 0 0
 done
 # wait for peers to timeout
 sleep 5
 
 echo "Setting timeout to 3s P2P:"
-for p in $(seq 3 ${NUM_PEERS}); do
+for p in $(seq 3 ${OVPN_NUM_PEERS}); do
 	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} \
-		$((${p} + ID_OFFSET)) 3 3
+		$((${p} + OVPN_ID_OFFSET)) 3 3
 done
 sleep 5
 
-for p in $(seq 0 ${NUM_PEERS}); do
-	compare_ntfs ${p}
+for p in $(seq 0 ${OVPN_NUM_PEERS}); do
+	ovpn_compare_ntfs ${p}
 done
 
-cleanup
+ovpn_cleanup
 
 modprobe -r ovpn || true
-- 
2.52.0



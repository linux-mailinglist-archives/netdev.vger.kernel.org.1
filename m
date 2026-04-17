Return-Path: <netdev+bounces-279273-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OHpPMIf34Wn50AAAu9opvQ
	(envelope-from <netdev+bounces-279273-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:04:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 426FF419093
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 11:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4E187305C63C
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 09:03:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E8C63B38A0;
	Fri, 17 Apr 2026 09:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="W7v5HICh"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77F103B2FEC
	for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 09:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776416617; cv=none; b=BBl99hNrustHWqTgb1OjrEmLEjjFN+SVSiJrZadbX5/sUvHeNf8FdHWhAzLkmiF5rFE9qflSVQiXdGjdJKlJLqHT5KdcKoONbfxiScAW4sKUC4TKptQZ/U8v+R4msQclFigWF2uWWfMfP7G5sHL8RJ9KfSq3r2YOd7m/w098sZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776416617; c=relaxed/simple;
	bh=HVB35/Uj0lJIpIoZwCRFixUSjugGXZiWzGCwqBkNRU8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F2qmt7XQiqReXBHb2vZQ4MmxfUjC2Zl4DARp4oGly43POR/U4mG6uS0v4n0olLZHQrtlGtDxTQWiypUEwAoOxg9letEr4KUOifXfcspxMPcvJOlq2yvqYvUNkwFmG04CTxkk3x4LELPJmecY6tTLy9lJzh3C95OqAj2/ak83wug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=W7v5HICh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-43d7213b6ebso270248f8f.3
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 02:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1776416613; x=1777021413; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Df1b0T+2fB0Y8PkuW7suGL3jsO/uWoOAR/no5CcMtic=;
        b=W7v5HIChhg2aBUkwWRjsQkByI+H/IJ/TmDTm27rQRxRhOD1CR4hZg1Ytu5CFd18rXC
         IeZdImshEiYGLLrZlqUKhce+3SYvokcbe1BskmT4vtkLy8cJB/MtwAJoyooNk38rQgUU
         bm7tcNHb745uQ+Efhrx2XhuuR5lMtFY1V63U3lUSm2WOzyocfw7fejbRmojIbXoTax75
         Sn9CZjaYiUaBVipYnMvAXZfWem8rVa0hYKWdKejejMziR1oE7Vtsa8awhA64jkWV4WH5
         wp0oycCXt0+UoUsgeSt2cJMGeBIDLKc8xzdzTeLs+kZmwBZxl1ZUL/jmkeLRJN+GIJu9
         Zb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776416613; x=1777021413;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Df1b0T+2fB0Y8PkuW7suGL3jsO/uWoOAR/no5CcMtic=;
        b=S8VJYkpdzY4ZcTzrJL2T1qxcTjQmhpLexhAuphv8Wf1hHDvKgOy1H7/XSidu0Xpzw1
         C1dH96dhvDnLrVSqo3VSzXjLne8Tc0VOwnuSgTvPFvTjDcps+TOSmtdGrHHWKfTL6kig
         /llWLxIl98uPBwAVvhMkMj7ms6DjK6p69dx3ZmD2+kJAKsB2XQWwoVQjXGLUksoImh6G
         44Q+PCxXtNPgnN02U0MtmzN452WAljDg6WoosGI4Ijdgrxy5I/++0dkgmp9Ugx6uZNc6
         z83kRtHd4iU9Wt+QwYXFAfEtEYxRnEUK0NGbHWIfsw8GNPpBRpXpA+JgQSl7+aeCGHzB
         5VAw==
X-Gm-Message-State: AOJu0Yw2a8jB4Cjqmm2L4wgOp3rsA3gn+qzRA9DAR4lyCP/ypIC/aEho
	OdyiRnDorWZNzMBwCrxazKkqMe63LtblMDiK3Z54oSFxs1HwqiVQNoRI0ZZsI21N+dcr7qthKDv
	e9mbEBR6iLDu8acoGLupSVsB5AWFguc8U3lV9T5JmasjTtXJNjFmQd3fAT8z+QZVr
X-Gm-Gg: AeBDiety5dekB1nUa+LG23Ja9vL7Q9JJjLHd95TvrSMACZ32ygaRkCSq93N3E0TBzW9
	0d5B0vhItZJ3V9hRwW1GcQXmnaF1N9JLUCa15SjQ5vFVRbI+xvxphq1pF4LzaTIdQrAaTrWNJQt
	FBlf+tmsadjLU9nMsmH0i5iA1VfSgjcO7Ys/xTg36H7SU4CjPuJhI0r/cFHazYd51i437N5UW53
	sYVIUlowdvo3hJz1+vPXtXLnG+cAVgr0UDGS6c3zAywM3DhLS0NFoz9b1MOPQNbb7VGDbb/s8Z6
	/iy/u2U3SQ8cDXXjv5ogvTRexvm4797ZULfuapOTjWXEQa6kavbtH9e7qZxQhJ3OBxN6jRY38Gh
	9x0QSjbvzJmSigayX2irYY8IGvAEFbuJL0ewwKd2TV/QrLf8jPS5LTrzZ2zzFLaQRs0C619H+Jk
	/dx56qJlDjAPSTL2B5QeZ2yYUDsKIcvmr12STvF7iSMCu+I7U2ic7gkj2WOw==
X-Received: by 2002:a5d:5d0e:0:b0:43b:4f0c:aefd with SMTP id ffacd0b85a97d-43fe3e073bemr2763339f8f.23.1776416613313;
        Fri, 17 Apr 2026 02:03:33 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:7524:fc82:dee5:4129])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e591cesm4120151f8f.36.2026.04.17.02.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 02:03:32 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	shuah@kernel.org,
	horms@kernel.org,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net 4/6] selftests: ovpn: add prefix to helpers and shared variables
Date: Fri, 17 Apr 2026 11:03:03 +0200
Message-ID: <20260417090305.2775723-5-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260417090305.2775723-1-antonio@openvpn.net>
References: <20260417090305.2775723-1-antonio@openvpn.net>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279273-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-0.997];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[test.sh:url,openvpn.net:email,openvpn.net:dkim,openvpn.net:mid]
X-Rspamd-Queue-Id: 426FF419093
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ralf Lici <ralf@mandelbit.com>

Current naming for shared variables, helpers and netnamespaces is
a bit unfortunate as it doesn't come with a clean prefix.
This showed to be problematic in case of name clashes with external
scripts or in case of abrupt test termination (hanging netns' weren't
easily reconducible to ovpn).

Rename common helper entry points and all shared globals in the ovpn
selftests to ovpn_ or OVPN_ names so test scripts and wrappers use a
single explicit prefix. Also rename the temporary network namespaces
created by the tests from peerN to ovpn_peerN. This makes leaked
namespaces easier to identify.

This is a mechanical refactor only, behavior is unchanged.

Fixes: 959bc330a439 ("testing/selftests: add test tool and scripts for ovpn module")
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/common.sh    | 186 ++++++++++--------
 .../selftests/net/ovpn/test-chachapoly.sh     |   2 +-
 .../net/ovpn/test-close-socket-tcp.sh         |   2 +-
 .../selftests/net/ovpn/test-close-socket.sh   |  32 +--
 .../testing/selftests/net/ovpn/test-float.sh  |   2 +-
 tools/testing/selftests/net/ovpn/test-mark.sh |  45 ++---
 .../net/ovpn/test-symmetric-id-float.sh       |   4 +-
 .../net/ovpn/test-symmetric-id-tcp.sh         |   4 +-
 .../selftests/net/ovpn/test-symmetric-id.sh   |   2 +-
 tools/testing/selftests/net/ovpn/test-tcp.sh  |   2 +-
 tools/testing/selftests/net/ovpn/test.sh      | 139 ++++++-------
 11 files changed, 226 insertions(+), 194 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index d3b322e84fab..38f187b9de23 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -4,63 +4,72 @@
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
+OVPN_YNL=${OVPN_YNL:-../../../../net/ynl/pyynl/cli.py}
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
-	ip netns add peer${1}
+ovpn_create_ns() {
+	ip netns add "ovpn_peer${1}"
 }
 
-setup_ns() {
+ovpn_setup_ns() {
+	local peer="ovpn_peer${1}"
+	local server_ns="ovpn_peer0"
+	local peer_ns
 	MODE="P2P"
 
 	if [ ${1} -eq 0 ]; then
 		MODE="MP"
-		for p in $(seq 1 ${NUM_PEERS}); do
-			ip link add veth${p} netns peer0 type veth peer name veth${p} netns peer${p}
-
-			ip -n peer0 addr add 10.10.${p}.1/24 dev veth${p}
-			ip -n peer0 addr add fd00:0:0:${p}::1/64 dev veth${p}
-			ip -n peer0 link set veth${p} up
-
-			ip -n peer${p} addr add 10.10.${p}.2/24 dev veth${p}
-			ip -n peer${p} addr add fd00:0:0:${p}::2/64 dev veth${p}
-			ip -n peer${p} link set veth${p} up
+		for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+			peer_ns="ovpn_peer${p}"
+			ip link add veth${p} netns "${server_ns}" type veth \
+				peer name veth${p} netns "${peer_ns}"
+
+			ip -n "${server_ns}" addr add 10.10.${p}.1/24 dev \
+				veth${p}
+			ip -n "${server_ns}" addr add fd00:0:0:${p}::1/64 dev \
+				veth${p}
+			ip -n "${server_ns}" link set veth${p} up
+
+			ip -n "${peer_ns}" addr add 10.10.${p}.2/24 dev veth${p}
+			ip -n "${peer_ns}" addr add fd00:0:0:${p}::2/64 dev \
+				veth${p}
+			ip -n "${peer_ns}" link set veth${p} up
 		done
 	fi
 
-	ip netns exec peer${1} ${OVPN_CLI} new_iface tun${1} $MODE
-	ip -n peer${1} addr add ${2} dev tun${1}
+	ip netns exec "${peer}" ${OVPN_CLI} new_iface tun${1} $MODE
+	ip -n "${peer}" addr add ${2} dev tun${1}
 	# add a secondary IP to peer 1, to test a LAN behind a client
-	if [ ${1} -eq 1 -a -n "${LAN_IP}" ]; then
-		ip -n peer${1} addr add ${LAN_IP} dev tun${1}
-		ip -n peer0 route add ${LAN_IP} via $(echo ${2} |sed -e s'!/.*!!') dev tun0
+	if [ ${1} -eq 1 -a -n "${OVPN_LAN_IP}" ]; then
+		ip -n "${peer}" addr add ${OVPN_LAN_IP} dev tun${1}
+		ip -n "${server_ns}" route add ${OVPN_LAN_IP} via \
+			$(echo ${2} |sed -e s'!/.*!!') dev tun0
 	fi
 	if [ -n "${3}" ]; then
-		ip -n peer${1} link set mtu ${3} dev tun${1}
+		ip -n "${peer}" link set mtu ${3} dev tun${1}
 	fi
-	ip -n peer${1} link set tun${1} up
+	ip -n "${peer}" link set tun${1} up
 }
 
-build_capture_filter() {
+ovpn_build_capture_filter() {
 	# match the first four bytes of the openvpn data payload
-	if [ "${PROTO}" == "UDP" ]; then
+	if [ "${OVPN_PROTO}" == "UDP" ]; then
 		# For UDP, libpcap transport indexing only works for IPv4, so
 		# use an explicit IPv4 or IPv6 expression based on the peer
 		# address. The IPv6 branch assumes there are no extension
@@ -77,86 +86,98 @@ build_capture_filter() {
 	fi
 }
 
-setup_listener() {
+ovpn_setup_listener() {
+	local peer_ns="ovpn_peer${p}"
 	file=$(mktemp)
-	PYTHONUNBUFFERED=1 ip netns exec peer${p} ${YNL_CLI} --family ovpn \
-		--subscribe peers --output-json --duration 40 > ${file} &
-	listener_pids[$1]=$!
-	tmp_jsons[$1]="${file}"
+	PYTHONUNBUFFERED=1 ip netns exec "${peer_ns}" "${OVPN_YNL}" --family \
+		ovpn --subscribe peers --output-json --duration 40 > ${file} &
+	OVPN_LISTENER_PIDS[$1]=$!
+	OVPN_TMP_JSONS[$1]="${file}"
 }
 
-add_peer() {
+ovpn_add_peer() {
 	labels=("ASYMM" "SYMM")
-	M_ID=${labels[SYMMETRIC_ID]}
+	local peer_ns
+	local server_ns="ovpn_peer0"
+	M_ID=${labels[OVPN_SYMMETRIC_ID]}
 
-	if [ "${PROTO}" == "UDP" ]; then
+	if [ "${OVPN_PROTO}" == "UDP" ]; then
 		if [ ${1} -eq 0 ]; then
-			ip netns exec peer0 ${OVPN_CLI} new_multi_peer tun0 1 \
-				${M_ID} ${UDP_PEERS_FILE}
+			ip netns exec "${server_ns}" ${OVPN_CLI} \
+				new_multi_peer tun0 1 ${M_ID} \
+				${OVPN_UDP_PEERS_FILE}
 
-			for p in $(seq 1 ${NUM_PEERS}); do
-				ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 ${ALG} 0 \
+			for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+				ip netns exec "${server_ns}" ${OVPN_CLI} \
+					new_key tun0 ${p} 1 0 ${OVPN_ALG} 0 \
 					data64.key
 			done
 		else
-			if [ "${SYMMETRIC_ID}" -eq 1 ]; then
+			peer_ns="ovpn_peer${1}"
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
-			ip netns exec peer${1} ${OVPN_CLI} new_peer tun${1} \
-				${PEER_ID} ${TX_ID} ${LPORT} ${RADDR} ${RPORT}
-			ip netns exec peer${1} ${OVPN_CLI} new_key tun${1} \
-				${PEER_ID} 1 0 ${ALG} 1 data64.key
+			RADDR=$(awk "NR == ${1} {print \$3}" \
+				${OVPN_UDP_PEERS_FILE})
+			RPORT=$(awk "NR == ${1} {print \$4}" \
+				${OVPN_UDP_PEERS_FILE})
+			LPORT=$(awk "NR == ${1} {print \$6}" \
+				${OVPN_UDP_PEERS_FILE})
+			ip netns exec "${peer_ns}" ${OVPN_CLI} new_peer \
+				tun${1} ${PEER_ID} ${TX_ID} ${LPORT} ${RADDR} \
+				${RPORT}
+			ip netns exec "${peer_ns}" ${OVPN_CLI} new_key tun${1} \
+				${PEER_ID} 1 0 ${OVPN_ALG} 1 data64.key
 		fi
 	else
 		if [ ${1} -eq 0 ]; then
-			(ip netns exec peer0 ${OVPN_CLI} listen tun0 1 ${M_ID} \
-				${TCP_PEERS_FILE} && {
-				for p in $(seq 1 ${NUM_PEERS}); do
-					ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 \
-						${ALG} 0 data64.key
+			(ip netns exec "${server_ns}" ${OVPN_CLI} listen tun0 \
+				1 ${M_ID} ${OVPN_TCP_PEERS_FILE} && {
+				for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+					ip netns exec "${server_ns}" \
+						${OVPN_CLI} new_key tun0 ${p} \
+						1 0 ${OVPN_ALG} 0 data64.key
 				done
 			}) &
 			sleep 5
 		else
-			if [ "${SYMMETRIC_ID}" -eq 1 ]; then
+			peer_ns="ovpn_peer${1}"
+			if [ "${OVPN_SYMMETRIC_ID}" -eq 1 ]; then
 				PEER_ID=${1}
 				TX_ID="none"
 			else
 				PEER_ID=$(awk "NR == ${1} {print \$2}" \
-					${TCP_PEERS_FILE})
+					${OVPN_TCP_PEERS_FILE})
 				TX_ID=${1}
 			fi
-			ip netns exec peer${1} ${OVPN_CLI} connect tun${1} \
+			ip netns exec "${peer_ns}" ${OVPN_CLI} connect tun${1} \
 				${PEER_ID} ${TX_ID} 10.10.${1}.1 1 data64.key
 		fi
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
-			<(jq -s "${JQ_FILTER}" ${received}) \
+		if diff <(jq -s "${OVPN_JQ_FILTER}" ${expected}) \
+			<(jq -s "${OVPN_JQ_FILTER}" ${received}) \
 			>"${diff_file}" 2>&1; then
 			echo "OK"
 		else
@@ -172,25 +193,30 @@ compare_ntfs() {
 	return "${diff_rc}"
 }
 
-cleanup() {
+ovpn_cleanup() {
+	local peer_ns
 	# some ovpn-cli processes sleep in background so they need manual poking
 	killall $(basename ${OVPN_CLI}) 2>/dev/null || true
 
 	# netns peer0 is deleted without erasing ifaces first
 	for p in $(seq 1 10); do
-		ip -n peer${p} link set tun${p} down 2>/dev/null || true
-		ip netns exec peer${p} ${OVPN_CLI} del_iface tun${p} 2>/dev/null || true
+		peer_ns="ovpn_peer${p}"
+		ip -n "${peer_ns}" link set tun${p} down 2>/dev/null || true
+		ip netns exec "${peer_ns}" ${OVPN_CLI} del_iface tun${p} \
+			2>/dev/null || true
 	done
 	for p in $(seq 1 10); do
-		ip -n peer0 link del veth${p} 2>/dev/null || true
+		ip -n ovpn_peer0 link del veth${p} 2>/dev/null || true
 	done
 	for p in $(seq 0 10); do
-		ip netns del peer${p} 2>/dev/null || true
+		ip netns del "ovpn_peer${p}" 2>/dev/null || true
 	done
 }
 
-if [ "${PROTO}" == "UDP" ]; then
-	NUM_PEERS=${NUM_PEERS:-$(wc -l ${UDP_PEERS_FILE} | awk '{print $1}')}
+if [ "${OVPN_PROTO}" == "UDP" ]; then
+	OVPN_NUM_PEERS=${OVPN_NUM_PEERS:-$(wc -l ${OVPN_UDP_PEERS_FILE} | \
+		awk '{print $1}')}
 else
-	NUM_PEERS=${NUM_PEERS:-$(wc -l ${TCP_PEERS_FILE} | awk '{print $1}')}
+	OVPN_NUM_PEERS=${OVPN_NUM_PEERS:-$(wc -l ${OVPN_TCP_PEERS_FILE} | \
+		awk '{print $1}')}
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
index 0d09df14fe8e..6bc1b6eab8ac 100755
--- a/tools/testing/selftests/net/ovpn/test-close-socket.sh
+++ b/tools/testing/selftests/net/ovpn/test-close-socket.sh
@@ -8,38 +8,40 @@
 set -e
 
 source ./common.sh
+server_ns="ovpn_peer0"
 
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
-	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
-	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} $((${p}+9)) 60 120
+for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+	ip netns exec "${server_ns}" ${OVPN_CLI} set_peer tun0 ${p} 60 120
+	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} set_peer tun${p} $((${p}+9)) \
+		60 120
 done
 
 sleep 1
 
-for p in $(seq 1 ${NUM_PEERS}); do
-	ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((${p} + 1))
+for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+	ip netns exec "${server_ns}" ping -qfc 500 -w 3 5.5.5.$((${p} + 1))
 done
 
-ip netns exec peer0 iperf3 -1 -s &
+ip netns exec "${server_ns}" iperf3 -1 -s &
 sleep 1
-ip netns exec peer1 iperf3 -Z -t 3 -c 5.5.5.1
+ip netns exec ovpn_peer1 iperf3 -Z -t 3 -c 5.5.5.1
 
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
index 8534428ed3eb..2ee5dc5fc538 100755
--- a/tools/testing/selftests/net/ovpn/test-mark.sh
+++ b/tools/testing/selftests/net/ovpn/test-mark.sh
@@ -11,62 +11,63 @@ set -e
 MARK=1056
 
 source ./common.sh
+server_ns="ovpn_peer0"
 
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
-ip netns exec peer0 "${OVPN_CLI}" new_multi_peer tun0 1 ASYMM \
-	"${UDP_PEERS_FILE}" \
+ip netns exec "${server_ns}" "${OVPN_CLI}" new_multi_peer tun0 1 ASYMM \
+	"${OVPN_UDP_PEERS_FILE}" \
 	${MARK}
 for p in $(seq 1 3); do
-	ip netns exec peer0 "${OVPN_CLI}" new_key tun0 "${p}" 1 0 "${ALG}" 0 \
-		data64.key
+	ip netns exec "${server_ns}" "${OVPN_CLI}" new_key tun0 "${p}" 1 0 \
+		"${OVPN_ALG}" 0 data64.key
 done
 
 for p in $(seq 1 3); do
-	add_peer "${p}"
+	ovpn_add_peer "${p}"
 done
 
 for p in $(seq 1 3); do
-	ip netns exec peer0 "${OVPN_CLI}" set_peer tun0 "${p}" 60 120
-	ip netns exec peer"${p}" "${OVPN_CLI}" set_peer tun"${p}" \
+	ip netns exec "${server_ns}" "${OVPN_CLI}" set_peer tun0 "${p}" 60 120
+	ip netns exec "ovpn_peer${p}" "${OVPN_CLI}" set_peer tun"${p}" \
 		$((p + 9)) 60 120
 done
 
 sleep 1
 
 for p in $(seq 1 3); do
-	ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((p + 1))
+	ip netns exec "${server_ns}" ping -qfc 500 -w 3 5.5.5.$((p + 1))
 done
 
 echo "Adding an nftables drop rule based on mark value ${MARK}"
-ip netns exec peer0 nft flush ruleset
-ip netns exec peer0 nft 'add table inet filter'
-ip netns exec peer0 nft 'add chain inet filter output {
+ip netns exec "${server_ns}" nft flush ruleset
+ip netns exec "${server_ns}" nft 'add table inet filter'
+ip netns exec "${server_ns}" nft 'add chain inet filter output {
 	type filter hook output priority 0;
 	policy accept;
 }'
-ip netns exec peer0 nft add rule inet filter output \
+ip netns exec "${server_ns}" nft add rule inet filter output \
 	meta mark == ${MARK} \
 	counter drop
 
-DROP_COUNTER=$(ip netns exec peer0 nft list chain inet filter output \
+DROP_COUNTER=$(ip netns exec "${server_ns}" nft list chain inet filter output \
 	| sed -n 's/.*packets \([0-9]*\).*/\1/p')
 sleep 1
 
 # ping should fail
 for p in $(seq 1 3); do
-	PING_OUTPUT=$(ip netns exec peer0 ping \
+	PING_OUTPUT=$(ip netns exec "${server_ns}" ping \
 		-qfc 500 -w 1 5.5.5.$((p + 1)) 2>&1) && exit 1
 	echo "${PING_OUTPUT}"
 	LOST_PACKETS=$(echo "$PING_OUTPUT" \
@@ -76,7 +77,7 @@ for p in $(seq 1 3); do
 done
 
 # check if the final nft counter matches our counter
-TOTAL_COUNT=$(ip netns exec peer0 nft list chain inet filter output \
+TOTAL_COUNT=$(ip netns exec "${server_ns}" nft list chain inet filter output \
 	| sed -n 's/.*packets \([0-9]*\).*/\1/p')
 if [ "${DROP_COUNTER}" -ne "${TOTAL_COUNT}" ]; then
 	echo "Expected ${TOTAL_COUNT} drops, got ${DROP_COUNTER}"
@@ -84,13 +85,13 @@ if [ "${DROP_COUNTER}" -ne "${TOTAL_COUNT}" ]; then
 fi
 
 echo "Removing the drop rule"
-ip netns exec peer0 nft flush ruleset
+ip netns exec "${server_ns}" nft flush ruleset
 sleep 1
 
 for p in $(seq 1 3); do
-	ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((p + 1))
+	ip netns exec "${server_ns}" ping -qfc 500 -w 3 5.5.5.$((p + 1))
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
index b60e94a4094e..b766f4842940 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -8,37 +8,38 @@
 set -e
 
 source ./common.sh
+server_ns="ovpn_peer0"
 
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
-	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
-	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} \
-		$((${p}+ID_OFFSET)) 60 120
+for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+	ip netns exec "${server_ns}" ${OVPN_CLI} set_peer tun0 ${p} 60 120
+	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} set_peer tun${p} \
+		$((${p}+OVPN_ID_OFFSET)) 60 120
 done
 
 sleep 1
 
 TCPDUMP_TIMEOUT="1.5s"
-for p in $(seq 1 ${NUM_PEERS}); do
+for p in $(seq 1 ${OVPN_NUM_PEERS}); do
 	# The first part of the data packet header consists of:
 	# - TCP only: 2 bytes for the packet length
 	# - 5 bits for opcode ("9" for DATA_V2)
@@ -47,119 +48,121 @@ for p in $(seq 1 ${NUM_PEERS}); do
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
 
-	timeout ${TCPDUMP_TIMEOUT} ip netns exec peer${p} \
+	timeout ${TCPDUMP_TIMEOUT} ip netns exec "ovpn_peer${p}" \
 		tcpdump --immediate-mode -p -ni veth${p} -c 1 \
-		"$(build_capture_filter "${HEADER1}" "${RADDR}")" \
+		"$(ovpn_build_capture_filter "${HEADER1}" "${RADDR}")" \
 		>/dev/null 2>&1 &
 	TCPDUMP_PID1=$!
-	timeout ${TCPDUMP_TIMEOUT} ip netns exec peer${p} \
+	timeout ${TCPDUMP_TIMEOUT} ip netns exec "ovpn_peer${p}" \
 		tcpdump --immediate-mode -p -ni veth${p} -c 1 \
-		"$(build_capture_filter "${HEADER2}" "${RADDR}")" \
+		"$(ovpn_build_capture_filter "${HEADER2}" "${RADDR}")" \
 		>/dev/null 2>&1 &
 	TCPDUMP_PID2=$!
 
 	sleep 0.3
-	ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((${p} + 1))
-	ip netns exec peer0 ping -qfc 500 -s 3000 -w 3 5.5.5.$((${p} + 1))
+	ip netns exec "${server_ns}" ping -qfc 500 -w 3 5.5.5.$((${p} + 1))
+	ip netns exec "${server_ns}" ping -qfc 500 -s 3000 -w 3 \
+		5.5.5.$((${p} + 1))
 
 	wait ${TCPDUMP_PID1}
 	wait ${TCPDUMP_PID2}
 done
 
 # ping LAN behind client 1
-ip netns exec peer0 ping -qfc 500 -w 3 ${LAN_IP}
+ip netns exec "${server_ns}" ping -qfc 500 -w 3 ${OVPN_LAN_IP}
 
-if [ "$FLOAT" == "1" ]; then
+if [ "$OVPN_FLOAT" == "1" ]; then
 	# make clients float..
-	for p in $(seq 1 ${NUM_PEERS}); do
-		ip -n peer${p} addr del 10.10.${p}.2/24 dev veth${p}
-		ip -n peer${p} addr add 10.10.${p}.3/24 dev veth${p}
+	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+		ip -n "ovpn_peer${p}" addr del 10.10.${p}.2/24 dev veth${p}
+		ip -n "ovpn_peer${p}" addr add 10.10.${p}.3/24 dev veth${p}
 	done
-	for p in $(seq 1 ${NUM_PEERS}); do
-		ip netns exec peer${p} ping -qfc 500 -w 3 5.5.5.1
+	for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+		ip netns exec "ovpn_peer${p}" ping -qfc 500 -w 3 5.5.5.1
 	done
 fi
 
-ip netns exec peer0 iperf3 -1 -s &
+ip netns exec "${server_ns}" iperf3 -1 -s &
 sleep 1
-ip netns exec peer1 iperf3 -Z -t 3 -c 5.5.5.1
+ip netns exec ovpn_peer1 iperf3 -Z -t 3 -c 5.5.5.1
 
 echo "Adding secondary key and then swap:"
-for p in $(seq 1 ${NUM_PEERS}); do
-	ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 2 1 ${ALG} 0 \
-		data64.key
-	ip netns exec peer${p} ${OVPN_CLI} new_key tun${p} \
-		$((${p} + ID_OFFSET)) 2 1 ${ALG} 1 data64.key
-	ip netns exec peer${p} ${OVPN_CLI} swap_keys tun${p} \
-		$((${p} + ID_OFFSET))
+for p in $(seq 1 ${OVPN_NUM_PEERS}); do
+	ip netns exec "${server_ns}" ${OVPN_CLI} new_key tun0 ${p} 2 1 \
+		${OVPN_ALG} 0 data64.key
+	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} new_key tun${p} \
+		$((${p} + OVPN_ID_OFFSET)) 2 1 ${OVPN_ALG} 1 data64.key
+	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} swap_keys tun${p} \
+		$((${p} + OVPN_ID_OFFSET))
 done
 
 sleep 1
 
 echo "Querying all peers:"
-ip netns exec peer0 ${OVPN_CLI} get_peer tun0
-ip netns exec peer1 ${OVPN_CLI} get_peer tun1
+ip netns exec "${server_ns}" ${OVPN_CLI} get_peer tun0
+ip netns exec ovpn_peer1 ${OVPN_CLI} get_peer tun1
 
 echo "Querying peer 1:"
-ip netns exec peer0 ${OVPN_CLI} get_peer tun0 1
+ip netns exec "${server_ns}" ${OVPN_CLI} get_peer tun0 1
 
 echo "Querying non-existent peer 20:"
-ip netns exec peer0 ${OVPN_CLI} get_peer tun0 20 || true
+ip netns exec "${server_ns}" ${OVPN_CLI} get_peer tun0 20 || true
 
 echo "Deleting peer 1:"
-ip netns exec peer0 ${OVPN_CLI} del_peer tun0 1
-ip netns exec peer1 ${OVPN_CLI} del_peer tun1 $((1 + ID_OFFSET))
+ip netns exec "${server_ns}" ${OVPN_CLI} del_peer tun0 1
+ip netns exec ovpn_peer1 ${OVPN_CLI} del_peer tun1 $((1 + OVPN_ID_OFFSET))
 
 echo "Querying keys:"
-for p in $(seq 2 ${NUM_PEERS}); do
-	ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} \
-		$((${p} + ID_OFFSET)) 1
-	ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} \
-		$((${p} + ID_OFFSET)) 2
+for p in $(seq 2 ${OVPN_NUM_PEERS}); do
+	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} get_key tun${p} \
+		$((${p} + OVPN_ID_OFFSET)) 1
+	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} get_key tun${p} \
+		$((${p} + OVPN_ID_OFFSET)) 2
 done
 
 echo "Deleting peer while sending traffic:"
-(ip netns exec peer2 ping -qf -w 4 5.5.5.1)&
+(ip netns exec ovpn_peer2 ping -qf -w 4 5.5.5.1)&
 sleep 2
-ip netns exec peer0 ${OVPN_CLI} del_peer tun0 2
+ip netns exec "${server_ns}" ${OVPN_CLI} del_peer tun0 2
 # following command fails in TCP mode
 # (both ends get conn reset when one peer disconnects)
-ip netns exec peer2 ${OVPN_CLI} del_peer tun2 $((2 + ID_OFFSET)) || true
+ip netns exec ovpn_peer2 ${OVPN_CLI} del_peer tun2 $((2 + OVPN_ID_OFFSET)) || \
+	true
 
 echo "Deleting keys:"
-for p in $(seq 3 ${NUM_PEERS}); do
-	ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} \
-		$((${p} + ID_OFFSET)) 1
-	ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} \
-		$((${p} + ID_OFFSET)) 2
+for p in $(seq 3 ${OVPN_NUM_PEERS}); do
+	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} del_key tun${p} \
+		$((${p} + OVPN_ID_OFFSET)) 1
+	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} del_key tun${p} \
+		$((${p} + OVPN_ID_OFFSET)) 2
 done
 
 echo "Setting timeout to 3s MP:"
-for p in $(seq 3 ${NUM_PEERS}); do
-	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 3 3 || true
-	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} \
-		$((${p} + ID_OFFSET)) 0 0
+for p in $(seq 3 ${OVPN_NUM_PEERS}); do
+	ip netns exec "${server_ns}" ${OVPN_CLI} set_peer tun0 ${p} 3 3 || true
+	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} set_peer tun${p} \
+		$((${p} + OVPN_ID_OFFSET)) 0 0
 done
 # wait for peers to timeout
 sleep 5
 
 echo "Setting timeout to 3s P2P:"
-for p in $(seq 3 ${NUM_PEERS}); do
-	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} \
-		$((${p} + ID_OFFSET)) 3 3
+for p in $(seq 3 ${OVPN_NUM_PEERS}); do
+	ip netns exec "ovpn_peer${p}" ${OVPN_CLI} set_peer tun${p} \
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



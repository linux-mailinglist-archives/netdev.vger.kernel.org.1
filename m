Return-Path: <netdev+bounces-267601-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uIztCQN5tGmOogAAu9opvQ
	(envelope-from <netdev+bounces-267601-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:52:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95624289E98
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 21:52:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A4C21306906A
	for <lists+netdev@lfdr.de>; Fri, 13 Mar 2026 20:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 565DC37FF77;
	Fri, 13 Mar 2026 20:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="QJdQCHrg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49B6E37F8AB
	for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 20:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773435122; cv=none; b=ZMdjKAVsGkLtdcLvAkIxl0jm9C5TDB9Jp5bHTWureJb7xW47N9NyeUH0K15iecQALi/mZW9oIGq+AjcSC3SG3lnPb9zqjBYzICxPOvJm6tXcdncrqITkSod28xXrFUr0bWM8wA+GTM+A4CnS2aDvXLdGgPQi38LlGyrYrHarFNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773435122; c=relaxed/simple;
	bh=AerpDqOOcAMvNjweC9m/kjxZ5pr1ZfNKwuiMnMi3sOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JaDEMhDEzZGCHoAWeHPIfmy/U8kctzL2JklA7RCNqIaPS5Xu0WiTTxSs8cMJR2+FeTOpZQ6PuK5+nTf02SLd4NBNtkxGwGMErNI5YoqMG0RY/fEAp7v7kE9R86U59cMAPP+/cLPI9DmEx7Luuug8L+QE0GV2LBjRqXi/zimeYpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=QJdQCHrg; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439f59dfda2so2099475f8f.2
        for <netdev@vger.kernel.org>; Fri, 13 Mar 2026 13:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773435117; x=1774039917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jPNTcHVXpG3kb6qkQqLJpIpIDntJzON7abSM73uGkg4=;
        b=QJdQCHrg9uarAPoGLaXs0KZv/Iomqd6RqXbxRxvJxeqg8Jv7wog3/jblaXCv19J+li
         9Y9VcrNKC+PIM+ZpCij6F3bf9hIu38fktTctktW0eee0oU9/ow36Ro90n+Tk+M6Te8td
         J1lYhgKvgQm8YYqQXTFzMyzb14AxVWu29mSX+/UDm6jZQeDgo98x5QZQ8eW6p3U/gO/b
         mHiVXuUY3cHUw/wqh+rd+mifj5PsyWi3DvZHnQUiwftX10oPWwdc8Ntj2N+YMfkg0zuA
         JQoOqpYOCJyIF0pkJdquLG96TXAXFf563RyAJjXQY94lFAfnk2RKP2j8d4D8HsPSaeCh
         ncBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773435117; x=1774039917;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jPNTcHVXpG3kb6qkQqLJpIpIDntJzON7abSM73uGkg4=;
        b=XfCc/fY/s275T+cvqMrAiLgKA9l6PHGnXi2FTgwuXhXULmL2wkCMCDRlJPhr8fYZEl
         GqpbLlyoDWgKY68FzK+kvKtg9+odtuER8KRCyu/kUlFde7VOCE58+sY269aPcEKSu4aV
         4Jez2PMsoGFep8YMKJ9JNSQcifCof0oFVfeZeMPJZPvOUcof2lXIVTKwbUkRHFtsDG9k
         djh6c2V6zDM6nOBmWav5U4CFnGxMlkYOzUeT0RwQM1vT6mrn+cBxHoK0CNYZo36javlo
         Vlms3/G95RtnHYJD47wkN//2VGv4m7SBbUqm/XX5yjSSE16GTOPJnfjh6YwNzdRq1b8B
         iupA==
X-Gm-Message-State: AOJu0Yzc8G1k+LwSgzEgiQ7atXd69L7yVBn0KZUXj370T2FhHXfQ/6na
	ULrS175VZiOYafIuSX88N7SLcLZ2D3nQrvYuKIflHD8opPBNmJWm11+cBMXtD3YtX4EGDqaYyno
	GJwmzAefL9xAryLtbn/pf07AYdoBQg5i3sioNCd1AtkTPqxcpzVZI11IJBbgiFpnU
X-Gm-Gg: ATEYQzyRurpHfklCS9qrVL+8hCR5v8TGtr+O2jq1NzYXyiLyOxPP/DLzwRCU+2hTgn9
	DArDcc3PN/Av0gBgYoNj7Q03KPbHW5SKcdcPJGERlptTnzWQXFjK0Tx75oIa1cmd9jRwVmbU+Fx
	M/5m5Gqg0aXqfm/FMcQfPwsQxv/B3mThi8+6U50yuYuSKdK35ngzu44rooKjDrqwN1mN34TFFA8
	B10186PgjOmhzDDG1b/QRAW+Si6GgKzKyl0vpdTASyetgEY7hrkAJ3fWMvo7r8NxRt9HGZgaUh8
	3bq2IT5VBd6wd+4n/+jiuHv0+1QvN0vr11HdKVnkilWf4xiACIvnzjqzEs/duIoHaK7sk2TRb3o
	GSMB/7AXz9MKNM3HwW3efqyoJAYbSPJAQ+XduFF7z+irkI2/6hOS/n3NVbGUld47zsi51mocsmd
	ShIiM+hTFaLj4cUxBXNI0RyoRvAhWNIBiFy3hF
X-Received: by 2002:a05:6000:3108:b0:439:bc0a:4164 with SMTP id ffacd0b85a97d-43a04d81b95mr9291334f8f.19.1773435117042;
        Fri, 13 Mar 2026 13:51:57 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:9684:4355:e76d:6ae9])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439fe2273d9sm23120468f8f.34.2026.03.13.13.51.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 13:51:56 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: ralf@mandelbit.com,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	horms@kernel.org,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 7/9] selftests: ovpn: check asymmetric peer-id
Date: Fri, 13 Mar 2026 21:51:37 +0100
Message-ID: <20260313205139.2950-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260313205139.2950-1-antonio@openvpn.net>
References: <20260313205139.2950-1-antonio@openvpn.net>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267601-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mandelbit.com:email,test-symmetric-id-tcp.sh:url,test-symmetric-id-float.sh:url,test-symmetric-id.sh:url]
X-Rspamd-Queue-Id: 95624289E98
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Ralf Lici <ralf@mandelbit.com>

Extend the base test to verify that the correct peer-id is set in data
packet headers. This is done by capturing ping packets with ngrep during
the initial exchange and matching the first portion of the header
against the expected sequence for every connection.

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: horms@kernel.org
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/Makefile     |   3 +
 tools/testing/selftests/net/ovpn/common.sh    |  69 ++++++++--
 .../net/ovpn/json/peer0-symm-float.json       |   1 +
 .../selftests/net/ovpn/json/peer0-symm.json   |   1 +
 .../net/ovpn/json/peer1-symm-float.json       |   1 +
 .../selftests/net/ovpn/json/peer1-symm.json   |   1 +
 .../selftests/net/ovpn/json/peer1.json        |   2 +-
 .../net/ovpn/json/peer2-symm-float.json       |   1 +
 .../selftests/net/ovpn/json/peer2-symm.json   |   1 +
 .../selftests/net/ovpn/json/peer2.json        |   2 +-
 .../net/ovpn/json/peer3-symm-float.json       |   1 +
 .../selftests/net/ovpn/json/peer3-symm.json   |   1 +
 .../selftests/net/ovpn/json/peer3.json        |   2 +-
 .../net/ovpn/json/peer4-symm-float.json       |   1 +
 .../selftests/net/ovpn/json/peer4-symm.json   |   1 +
 .../selftests/net/ovpn/json/peer4.json        |   2 +-
 .../net/ovpn/json/peer5-symm-float.json       |   1 +
 .../selftests/net/ovpn/json/peer5-symm.json   |   1 +
 .../selftests/net/ovpn/json/peer5.json        |   2 +-
 .../net/ovpn/json/peer6-symm-float.json       |   1 +
 .../selftests/net/ovpn/json/peer6-symm.json   |   1 +
 .../selftests/net/ovpn/json/peer6.json        |   2 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 128 +++++++++++++-----
 .../testing/selftests/net/ovpn/tcp_peers.txt  |  12 +-
 .../selftests/net/ovpn/test-close-socket.sh   |   2 +-
 .../net/ovpn/test-symmetric-id-float.sh       |  11 ++
 .../net/ovpn/test-symmetric-id-tcp.sh         |  11 ++
 .../selftests/net/ovpn/test-symmetric-id.sh   |  10 ++
 tools/testing/selftests/net/ovpn/test.sh      |  68 ++++++++--
 .../testing/selftests/net/ovpn/udp_peers.txt  |  12 +-
 30 files changed, 271 insertions(+), 81 deletions(-)
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer0-symm.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer1-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer1-symm.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer2-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer2-symm.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer3-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer3-symm.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer4-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer4-symm.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer5-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer5-symm.json
 create mode 120000 tools/testing/selftests/net/ovpn/json/peer6-symm-float.json
 create mode 100644 tools/testing/selftests/net/ovpn/json/peer6-symm.json
 create mode 100755 tools/testing/selftests/net/ovpn/test-symmetric-id-float.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-symmetric-id-tcp.sh
 create mode 100755 tools/testing/selftests/net/ovpn/test-symmetric-id.sh

diff --git a/tools/testing/selftests/net/ovpn/Makefile b/tools/testing/selftests/net/ovpn/Makefile
index 88891d9f5c56..ce9f79c4f892 100644
--- a/tools/testing/selftests/net/ovpn/Makefile
+++ b/tools/testing/selftests/net/ovpn/Makefile
@@ -38,6 +38,9 @@ TEST_PROGS := \
 	test-close-socket.sh \
 	test-float.sh \
 	test-large-mtu.sh \
+	test-symmetric-id-float.sh \
+	test-symmetric-id-tcp.sh \
+	test-symmetric-id.sh \
 	test-tcp.sh \
 	test.sh \
 # end of TEST_PROGS
diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index df0a541148fe..4c08f756e63a 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -11,6 +11,9 @@ YNL_CLI=${YNL_CLI:-../../../../net/ynl/pyynl/cli.py}
 ALG=${ALG:-aes}
 PROTO=${PROTO:-UDP}
 FLOAT=${FLOAT:-0}
+SYMMETRIC_ID=${SYMMETRIC_ID:-0}
+
+export ID_OFFSET=$(( 9 * (SYMMETRIC_ID == 0) ))
 
 JQ_FILTER='map(select(.msg.peer | has("remote-ipv6") | not)) |
 	map(del(.msg.ifindex)) | sort_by(.msg.peer.id)[]'
@@ -54,6 +57,25 @@ setup_ns() {
 	ip -n peer${1} link set tun${1} up
 }
 
+build_capture_filter() {
+	# match the first four bytes of the openvpn data payload
+	if [ "${PROTO}" == "UDP" ]; then
+		# For UDP, libpcap transport indexing only works for IPv4, so
+		# use an explicit IPv4 or IPv6 expression based on the peer
+		# address. The IPv6 branch assumes there are no extension
+		# headers in the outer packet.
+		if [[ "${2}" == *:* ]]; then
+			printf "ip6 and ip6[6] = 17 and ip6[48:4] = %s" "${1}"
+		else
+			printf "ip and udp[8:4] = %s" "${1}"
+		fi
+	else
+		# openvpn over TCP prepends a 2-byte packet length ahead of the
+		# DATA_V2 opcode, so skip it before matching the payload header
+		printf "ip and tcp[(((tcp[12] & 0xf0) >> 2) + 2):4] = %s" "${1}"
+	fi
+}
+
 setup_listener() {
 	file=$(mktemp)
 	PYTHONUNBUFFERED=1 ip netns exec peer${p} ${YNL_CLI} --family ovpn \
@@ -63,26 +85,39 @@ setup_listener() {
 }
 
 add_peer() {
+	labels=("ASYMM" "SYMM")
+	M_ID=${labels[SYMMETRIC_ID]}
+
 	if [ "${PROTO}" == "UDP" ]; then
 		if [ ${1} -eq 0 ]; then
-			ip netns exec peer0 ${OVPN_CLI} new_multi_peer tun0 1 ${UDP_PEERS_FILE}
+			ip netns exec peer0 ${OVPN_CLI} new_multi_peer tun0 1 \
+				${M_ID} ${UDP_PEERS_FILE}
 
 			for p in $(seq 1 ${NUM_PEERS}); do
 				ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 ${ALG} 0 \
 					data64.key
 			done
 		else
-			RADDR=$(awk "NR == ${1} {print \$2}" ${UDP_PEERS_FILE})
-			RPORT=$(awk "NR == ${1} {print \$3}" ${UDP_PEERS_FILE})
-			LPORT=$(awk "NR == ${1} {print \$5}" ${UDP_PEERS_FILE})
-			ip netns exec peer${1} ${OVPN_CLI} new_peer tun${1} ${1} ${LPORT} \
-				${RADDR} ${RPORT}
-			ip netns exec peer${1} ${OVPN_CLI} new_key tun${1} ${1} 1 0 ${ALG} 1 \
-				data64.key
+			if [ "${SYMMETRIC_ID}" -eq 1 ]; then
+				PEER_ID=${1}
+				TX_ID="none"
+			else
+				PEER_ID=$(awk "NR == ${1} {print \$2}" \
+					${UDP_PEERS_FILE})
+				TX_ID=${1}
+			fi
+			RADDR=$(awk "NR == ${1} {print \$3}" ${UDP_PEERS_FILE})
+			RPORT=$(awk "NR == ${1} {print \$4}" ${UDP_PEERS_FILE})
+			LPORT=$(awk "NR == ${1} {print \$6}" ${UDP_PEERS_FILE})
+			ip netns exec peer${1} ${OVPN_CLI} new_peer tun${1} \
+				${PEER_ID} ${TX_ID} ${LPORT} ${RADDR} ${RPORT}
+			ip netns exec peer${1} ${OVPN_CLI} new_key tun${1} \
+				${PEER_ID} 1 0 ${ALG} 1 data64.key
 		fi
 	else
 		if [ ${1} -eq 0 ]; then
-			(ip netns exec peer0 ${OVPN_CLI} listen tun0 1 ${TCP_PEERS_FILE} && {
+			(ip netns exec peer0 ${OVPN_CLI} listen tun0 1 ${M_ID} \
+				${TCP_PEERS_FILE} && {
 				for p in $(seq 1 ${NUM_PEERS}); do
 					ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 1 0 \
 						${ALG} 0 data64.key
@@ -90,15 +125,25 @@ add_peer() {
 			}) &
 			sleep 5
 		else
-			ip netns exec peer${1} ${OVPN_CLI} connect tun${1} ${1} 10.10.${1}.1 1 \
-				data64.key
+			if [ "${SYMMETRIC_ID}" -eq 1 ]; then
+				PEER_ID=${1}
+				TX_ID="none"
+			else
+				PEER_ID=$(awk "NR == ${1} {print \$2}" \
+					${TCP_PEERS_FILE})
+				TX_ID=${1}
+			fi
+			ip netns exec peer${1} ${OVPN_CLI} connect tun${1} \
+				${PEER_ID} ${TX_ID} 10.10.${1}.1 1 data64.key
 		fi
 	fi
 }
 
 compare_ntfs() {
 	if [ ${#tmp_jsons[@]} -gt 0 ]; then
-		[ "$FLOAT" == 1 ] && suffix="-float"
+		suffix=""
+		[ "${SYMMETRIC_ID}" -eq 1 ] && suffix="${suffix}-symm"
+		[ "$FLOAT" == 1 ] && suffix="${suffix}-float"
 		expected="json/peer${1}${suffix}.json"
 		received="${tmp_jsons[$1]}"
 
diff --git a/tools/testing/selftests/net/ovpn/json/peer0-symm-float.json b/tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
new file mode 120000
index 000000000000..e31a5bd59863
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer0-symm-float.json
@@ -0,0 +1 @@
+peer0-float.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer0-symm.json b/tools/testing/selftests/net/ovpn/json/peer0-symm.json
new file mode 120000
index 000000000000..57a163048eed
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer0-symm.json
@@ -0,0 +1 @@
+peer0.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer1-symm-float.json b/tools/testing/selftests/net/ovpn/json/peer1-symm-float.json
new file mode 120000
index 000000000000..b3615dcc523d
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer1-symm-float.json
@@ -0,0 +1 @@
+peer1-symm.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer1-symm.json b/tools/testing/selftests/net/ovpn/json/peer1-symm.json
new file mode 100644
index 000000000000..5da4ea9d51fb
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer1-symm.json
@@ -0,0 +1 @@
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer1.json b/tools/testing/selftests/net/ovpn/json/peer1.json
index 5da4ea9d51fb..1009d26dc14a 100644
--- a/tools/testing/selftests/net/ovpn/json/peer1.json
+++ b/tools/testing/selftests/net/ovpn/json/peer1.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 10}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer2-symm-float.json b/tools/testing/selftests/net/ovpn/json/peer2-symm-float.json
new file mode 120000
index 000000000000..28a895cb5170
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer2-symm-float.json
@@ -0,0 +1 @@
+peer2-symm.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer2-symm.json b/tools/testing/selftests/net/ovpn/json/peer2-symm.json
new file mode 100644
index 000000000000..8f6db4f8c2ac
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer2-symm.json
@@ -0,0 +1 @@
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer2.json b/tools/testing/selftests/net/ovpn/json/peer2.json
index 8f6db4f8c2ac..44e9fad2b622 100644
--- a/tools/testing/selftests/net/ovpn/json/peer2.json
+++ b/tools/testing/selftests/net/ovpn/json/peer2.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 11}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer3-symm-float.json b/tools/testing/selftests/net/ovpn/json/peer3-symm-float.json
new file mode 120000
index 000000000000..ee8b9719c2fd
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer3-symm-float.json
@@ -0,0 +1 @@
+peer3-symm.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer3-symm.json b/tools/testing/selftests/net/ovpn/json/peer3-symm.json
new file mode 100644
index 000000000000..bdabd6fa2e64
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer3-symm.json
@@ -0,0 +1 @@
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer3.json b/tools/testing/selftests/net/ovpn/json/peer3.json
index bdabd6fa2e64..d4be8ba130ae 100644
--- a/tools/testing/selftests/net/ovpn/json/peer3.json
+++ b/tools/testing/selftests/net/ovpn/json/peer3.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 12}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer4-symm-float.json b/tools/testing/selftests/net/ovpn/json/peer4-symm-float.json
new file mode 120000
index 000000000000..7d34ff7305da
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer4-symm-float.json
@@ -0,0 +1 @@
+peer4-symm.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer4-symm.json b/tools/testing/selftests/net/ovpn/json/peer4-symm.json
new file mode 100644
index 000000000000..c3734bb9251b
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer4-symm.json
@@ -0,0 +1 @@
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer4.json b/tools/testing/selftests/net/ovpn/json/peer4.json
index c3734bb9251b..67d27e2d48ac 100644
--- a/tools/testing/selftests/net/ovpn/json/peer4.json
+++ b/tools/testing/selftests/net/ovpn/json/peer4.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 13}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer5-symm-float.json b/tools/testing/selftests/net/ovpn/json/peer5-symm-float.json
new file mode 120000
index 000000000000..afc0f5f9f13b
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer5-symm-float.json
@@ -0,0 +1 @@
+peer5-symm.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer5-symm.json b/tools/testing/selftests/net/ovpn/json/peer5-symm.json
new file mode 100644
index 000000000000..46c4a348299d
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer5-symm.json
@@ -0,0 +1 @@
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer5.json b/tools/testing/selftests/net/ovpn/json/peer5.json
index 46c4a348299d..ecd9bd0b2f37 100644
--- a/tools/testing/selftests/net/ovpn/json/peer5.json
+++ b/tools/testing/selftests/net/ovpn/json/peer5.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 14}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer6-symm-float.json b/tools/testing/selftests/net/ovpn/json/peer6-symm-float.json
new file mode 120000
index 000000000000..e39203204d8c
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer6-symm-float.json
@@ -0,0 +1 @@
+peer6-symm.json
\ No newline at end of file
diff --git a/tools/testing/selftests/net/ovpn/json/peer6-symm.json b/tools/testing/selftests/net/ovpn/json/peer6-symm.json
new file mode 100644
index 000000000000..aa30f2cff625
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/json/peer6-symm.json
@@ -0,0 +1 @@
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer6.json b/tools/testing/selftests/net/ovpn/json/peer6.json
index aa30f2cff625..7fded29c5804 100644
--- a/tools/testing/selftests/net/ovpn/json/peer6.json
+++ b/tools/testing/selftests/net/ovpn/json/peer6.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 15}}}
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 7178abae1b2f..085446471397 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -103,7 +103,7 @@ struct ovpn_ctx {
 
 	sa_family_t sa_family;
 
-	unsigned long peer_id;
+	unsigned long peer_id, tx_id;
 	unsigned long lport;
 
 	union {
@@ -133,6 +133,8 @@ struct ovpn_ctx {
 	enum ovpn_key_slot key_slot;
 	int key_id;
 
+	bool asymm_id;
+
 	const char *peers_file;
 };
 
@@ -649,6 +651,8 @@ static int ovpn_new_peer(struct ovpn_ctx *ovpn, bool is_tcp)
 
 	attr = nla_nest_start(ctx->nl_msg, OVPN_A_PEER);
 	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_ID, ovpn->peer_id);
+	if (ovpn->asymm_id)
+		NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_TX_ID, ovpn->tx_id);
 	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_SOCKET, ovpn->socket);
 
 	if (!is_tcp) {
@@ -767,6 +771,10 @@ static int ovpn_handle_peer(struct nl_msg *msg, void (*arg)__always_unused)
 		fprintf(stderr, "* Peer %u\n",
 			nla_get_u32(pattrs[OVPN_A_PEER_ID]));
 
+	if (pattrs[OVPN_A_PEER_TX_ID])
+		fprintf(stderr, "\tTX peer ID %u\n",
+			nla_get_u32(pattrs[OVPN_A_PEER_TX_ID]));
+
 	if (pattrs[OVPN_A_PEER_SOCKET_NETNSID])
 		fprintf(stderr, "\tsocket NetNS ID: %d\n",
 			nla_get_s32(pattrs[OVPN_A_PEER_SOCKET_NETNSID]));
@@ -1657,41 +1665,57 @@ static void usage(const char *cmd)
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 
 	fprintf(stderr,
-		"* listen <iface> <lport> <peers_file> [ipv6]: listen for incoming peer TCP connections\n");
+		"* listen <iface> <lport> <id_type> <peers_file> [ipv6]: listen for incoming peer TCP connections\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr, "\tlport: TCP port to listen to\n");
+	fprintf(stderr, "\tid_type:\n");
+	fprintf(stderr,
+		"\t\t- SYMM for ignoring the TX peer ID from the peers_file\n");
+	fprintf(stderr,
+		"\t\t- ASYMM for using the TX peer ID from the peers_file\n");
 	fprintf(stderr,
 		"\tpeers_file: file containing one peer per line: Line format:\n");
-	fprintf(stderr, "\t\t<peer_id> <vpnaddr>\n");
+	fprintf(stderr, "\t\t<peer_id> <tx_id> <vpnaddr>\n");
 	fprintf(stderr,
 		"\tipv6: whether the socket should listen to the IPv6 wildcard address\n");
 
 	fprintf(stderr,
-		"* connect <iface> <peer_id> <raddr> <rport> [key_file]: start connecting peer of TCP-based VPN session\n");
+		"* connect <iface> <peer_id> <tx_id> <raddr> <rport> [key_file]: start connecting peer of TCP-based VPN session\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
-	fprintf(stderr, "\tpeer_id: peer ID of the connecting peer\n");
+	fprintf(stderr,
+		"\tpeer_id: peer ID found in data packets received from this peer\n");
+	fprintf(stderr,
+		"\ttx_id: peer ID to be used when sending to this peer, 'none' for symmetric peer ID\n");
 	fprintf(stderr, "\traddr: peer IP address to connect to\n");
 	fprintf(stderr, "\trport: peer TCP port to connect to\n");
 	fprintf(stderr,
 		"\tkey_file: file containing the symmetric key for encryption\n");
 
 	fprintf(stderr,
-		"* new_peer <iface> <peer_id> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
+		"* new_peer <iface> <peer_id> <tx_id> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
-	fprintf(stderr, "\tlport: local UDP port to bind to\n");
 	fprintf(stderr,
-		"\tpeer_id: peer ID to be used in data packets to/from this peer\n");
+		"\tpeer_id: peer ID found in data packets received from this peer\n");
+	fprintf(stderr,
+		"\ttx_id: peer ID to be used when sending to this peer, 'none' for symmetric peer ID\n");
+	fprintf(stderr, "\tlport: local UDP port to bind to\n");
 	fprintf(stderr, "\traddr: peer IP address\n");
 	fprintf(stderr, "\trport: peer UDP port\n");
 	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
 
 	fprintf(stderr,
-		"* new_multi_peer <iface> <lport> <peers_file>: add multiple peers as listed in the file\n");
+		"* new_multi_peer <iface> <lport> <id_type> <peers_file>: add multiple peers as listed in the file\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr, "\tlport: local UDP port to bind to\n");
+	fprintf(stderr, "\tid_type:\n");
+	fprintf(stderr,
+		"\t\t- SYMM for ignoring the TX peer ID from the peers_file\n");
+	fprintf(stderr,
+		"\t\t- ASYMM for using the TX peer ID from the peers_file\n");
 	fprintf(stderr,
 		"\tpeers_file: text file containing one peer per line. Line format:\n");
-	fprintf(stderr, "\t\t<peer_id> <raddr> <rport> <vpnaddr>\n");
+	fprintf(stderr,
+		"\t\t<peer_id> <tx_id> <raddr> <rport> <laddr> <lport> <vpnaddr>\n");
 
 	fprintf(stderr,
 		"* set_peer <iface> <peer_id> <keepalive_interval> <keepalive_timeout>: set peer attributes\n");
@@ -1804,15 +1828,23 @@ static int ovpn_parse_remote(struct ovpn_ctx *ovpn, const char *host,
 }
 
 static int ovpn_parse_new_peer(struct ovpn_ctx *ovpn, const char *peer_id,
-			       const char *raddr, const char *rport,
-			       const char *vpnip)
+			       const char *tx_id, const char *raddr,
+			       const char *rport, const char *vpnip)
 {
 	ovpn->peer_id = strtoul(peer_id, NULL, 10);
 	if (errno == ERANGE || ovpn->peer_id > PEER_ID_UNDEF) {
-		fprintf(stderr, "peer ID value out of range\n");
+		fprintf(stderr, "rx peer ID value out of range\n");
 		return -1;
 	}
 
+	if (ovpn->asymm_id) {
+		ovpn->tx_id = strtoul(tx_id, NULL, 10);
+		if (errno == ERANGE || ovpn->tx_id > PEER_ID_UNDEF) {
+			fprintf(stderr, "tx peer ID value out of range\n");
+			return -1;
+		}
+	}
+
 	return ovpn_parse_remote(ovpn, raddr, rport, vpnip);
 }
 
@@ -1939,8 +1971,8 @@ static void ovpn_waitbg(void)
 
 static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 {
-	char peer_id[10], vpnip[INET6_ADDRSTRLEN], laddr[128], lport[10];
-	char raddr[128], rport[10];
+	char peer_id[10], tx_id[10], vpnip[INET6_ADDRSTRLEN], laddr[128];
+	char lport[10], raddr[128], rport[10];
 	int n, ret;
 	FILE *fp;
 
@@ -1967,7 +1999,8 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 
 		int num_peers = 0;
 
-		while ((n = fscanf(fp, "%s %s\n", peer_id, vpnip)) == 2) {
+		while ((n = fscanf(fp, "%s %s %s\n", peer_id, tx_id,
+				   vpnip)) == 3) {
 			struct ovpn_ctx peer_ctx = { 0 };
 
 			if (num_peers == MAX_PEERS) {
@@ -1977,6 +2010,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 
 			peer_ctx.ifindex = ovpn->ifindex;
 			peer_ctx.sa_family = ovpn->sa_family;
+			peer_ctx.asymm_id = ovpn->asymm_id;
 
 			peer_ctx.socket = ovpn_accept(ovpn);
 			if (peer_ctx.socket < 0) {
@@ -1987,8 +2021,8 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 			/* store peer sockets to test TCP I/O */
 			ovpn->cli_sockets[num_peers] = peer_ctx.socket;
 
-			ret = ovpn_parse_new_peer(&peer_ctx, peer_id, NULL,
-						  NULL, vpnip);
+			ret = ovpn_parse_new_peer(&peer_ctx, peer_id, tx_id,
+						  NULL, NULL, vpnip);
 			if (ret < 0) {
 				fprintf(stderr, "error while parsing line\n");
 				return -1;
@@ -2056,16 +2090,17 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 			return -1;
 		}
 
-		while ((n = fscanf(fp, "%s %s %s %s %s %s\n", peer_id, laddr,
-				   lport, raddr, rport, vpnip)) == 6) {
+		while ((n = fscanf(fp, "%s %s %s %s %s %s %s\n", peer_id, tx_id,
+				   laddr, lport, raddr, rport, vpnip)) == 7) {
 			struct ovpn_ctx peer_ctx = { 0 };
 
 			peer_ctx.ifindex = ovpn->ifindex;
 			peer_ctx.socket = ovpn->socket;
 			peer_ctx.sa_family = AF_UNSPEC;
+			peer_ctx.asymm_id = ovpn->asymm_id;
 
-			ret = ovpn_parse_new_peer(&peer_ctx, peer_id, raddr,
-						  rport, vpnip);
+			ret = ovpn_parse_new_peer(&peer_ctx, peer_id, tx_id,
+						  raddr, rport, vpnip);
 			if (ret < 0) {
 				fprintf(stderr, "error while parsing line\n");
 				return -1;
@@ -2161,7 +2196,7 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 	case CMD_DEL_IFACE:
 		break;
 	case CMD_LISTEN:
-		if (argc < 5)
+		if (argc < 6)
 			return -EINVAL;
 
 		ovpn->lport = strtoul(argv[3], NULL, 10);
@@ -2170,55 +2205,67 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 			return -1;
 		}
 
-		ovpn->peers_file = argv[4];
+		if (strcmp(argv[4], "SYMM") == 0) {
+			ovpn->asymm_id = false;
+		} else if (strcmp(argv[4], "ASYMM") == 0) {
+			ovpn->asymm_id = true;
+		} else {
+			fprintf(stderr, "Cannot parse id type: %s\n", argv[4]);
+			return -1;
+		}
+
+		ovpn->peers_file = argv[5];
 
 		ovpn->sa_family = AF_INET;
-		if (argc > 5 && !strcmp(argv[5], "ipv6"))
+		if (argc > 6 && !strcmp(argv[6], "ipv6"))
 			ovpn->sa_family = AF_INET6;
 		break;
 	case CMD_CONNECT:
-		if (argc < 6)
+		if (argc < 7)
 			return -EINVAL;
 
 		ovpn->sa_family = AF_INET;
+		ovpn->asymm_id = strcmp(argv[4], "none");
 
 		ret = ovpn_parse_new_peer(ovpn, argv[3], argv[4], argv[5],
-					  NULL);
+					  argv[6], NULL);
 		if (ret < 0) {
 			fprintf(stderr, "Cannot parse remote peer data\n");
 			return -1;
 		}
 
-		if (argc > 6) {
+		if (argc > 7) {
 			ovpn->key_slot = OVPN_KEY_SLOT_PRIMARY;
 			ovpn->key_id = 0;
 			ovpn->cipher = OVPN_CIPHER_ALG_AES_GCM;
 			ovpn->key_dir = KEY_DIR_OUT;
 
-			ret = ovpn_parse_key(argv[6], ovpn);
+			ret = ovpn_parse_key(argv[7], ovpn);
 			if (ret)
 				return -1;
 		}
 		break;
 	case CMD_NEW_PEER:
-		if (argc < 7)
+		if (argc < 8)
 			return -EINVAL;
 
-		ovpn->lport = strtoul(argv[4], NULL, 10);
+		ovpn->asymm_id = strcmp(argv[4], "none");
+
+		ovpn->lport = strtoul(argv[5], NULL, 10);
 		if (errno == ERANGE || ovpn->lport > 65535) {
 			fprintf(stderr, "lport value out of range\n");
 			return -1;
 		}
 
-		const char *vpnip = (argc > 7) ? argv[7] : NULL;
+		const char *vpnip = (argc > 8) ? argv[8] : NULL;
 
-		ret = ovpn_parse_new_peer(ovpn, argv[3], argv[5], argv[6],
-					  vpnip);
+		ret = ovpn_parse_new_peer(ovpn, argv[3], argv[4], argv[6],
+					  argv[7], vpnip);
 		if (ret < 0)
 			return -1;
 		break;
 	case CMD_NEW_MULTI_PEER:
-		if (argc < 5)
+		if (argc < 6)
 			return -EINVAL;
 
 		ovpn->lport = strtoul(argv[3], NULL, 10);
@@ -2227,7 +2274,16 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 			return -1;
 		}
 
-		ovpn->peers_file = argv[4];
+		if (!strcmp(argv[4], "SYMM")) {
+			ovpn->asymm_id = false;
+		} else if (!strcmp(argv[4], "ASYMM")) {
+			ovpn->asymm_id = true;
+		} else {
+			fprintf(stderr, "Cannot parse id type: %s\n", argv[4]);
+			return -1;
+		}
+
+		ovpn->peers_file = argv[5];
 		break;
 	case CMD_SET_PEER:
 		if (argc < 6)
diff --git a/tools/testing/selftests/net/ovpn/tcp_peers.txt b/tools/testing/selftests/net/ovpn/tcp_peers.txt
index b8f3cb33eaa2..3cb67b560705 100644
--- a/tools/testing/selftests/net/ovpn/tcp_peers.txt
+++ b/tools/testing/selftests/net/ovpn/tcp_peers.txt
@@ -1,6 +1,6 @@
-1 5.5.5.2
-2 5.5.5.3
-3 5.5.5.4
-4 5.5.5.5
-5 5.5.5.6
-6 5.5.5.7
+1 10 5.5.5.2
+2 11 5.5.5.3
+3 12 5.5.5.4
+4 13 5.5.5.5
+5 14 5.5.5.6
+6 15 5.5.5.7
diff --git a/tools/testing/selftests/net/ovpn/test-close-socket.sh b/tools/testing/selftests/net/ovpn/test-close-socket.sh
index 5e48a8b67928..0d09df14fe8e 100755
--- a/tools/testing/selftests/net/ovpn/test-close-socket.sh
+++ b/tools/testing/selftests/net/ovpn/test-close-socket.sh
@@ -27,7 +27,7 @@ done
 
 for p in $(seq 1 ${NUM_PEERS}); do
 	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
-	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} ${p} 60 120
+	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} $((${p}+9)) 60 120
 done
 
 sleep 1
diff --git a/tools/testing/selftests/net/ovpn/test-symmetric-id-float.sh b/tools/testing/selftests/net/ovpn/test-symmetric-id-float.sh
new file mode 100755
index 000000000000..b3711a81b463
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-symmetric-id-float.sh
@@ -0,0 +1,11 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 OpenVPN, Inc.
+#
+#	Author:	Ralf Lici <ralf@mandelbit.com>
+#		Antonio Quartulli <antonio@openvpn.net>
+
+SYMMETRIC_ID="1"
+FLOAT="1"
+
+source test.sh
diff --git a/tools/testing/selftests/net/ovpn/test-symmetric-id-tcp.sh b/tools/testing/selftests/net/ovpn/test-symmetric-id-tcp.sh
new file mode 100755
index 000000000000..188cafb67b2f
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-symmetric-id-tcp.sh
@@ -0,0 +1,11 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 OpenVPN, Inc.
+#
+#	Author:	Ralf Lici <ralf@mandelbit.com>
+#		Antonio Quartulli <antonio@openvpn.net>
+
+PROTO="TCP"
+SYMMETRIC_ID=1
+
+source test.sh
diff --git a/tools/testing/selftests/net/ovpn/test-symmetric-id.sh b/tools/testing/selftests/net/ovpn/test-symmetric-id.sh
new file mode 100755
index 000000000000..35b119c72e4f
--- /dev/null
+++ b/tools/testing/selftests/net/ovpn/test-symmetric-id.sh
@@ -0,0 +1,10 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+# Copyright (C) 2025 OpenVPN, Inc.
+#
+#	Author:	Ralf Lici <ralf@mandelbit.com>
+#		Antonio Quartulli <antonio@openvpn.net>
+
+SYMMETRIC_ID="1"
+
+source test.sh
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index c2904342ec57..b60e94a4094e 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -31,14 +31,45 @@ done
 
 for p in $(seq 1 ${NUM_PEERS}); do
 	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
-	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} ${p} 60 120
+	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} \
+		$((${p}+ID_OFFSET)) 60 120
 done
 
 sleep 1
 
+TCPDUMP_TIMEOUT="1.5s"
 for p in $(seq 1 ${NUM_PEERS}); do
+	# The first part of the data packet header consists of:
+	# - TCP only: 2 bytes for the packet length
+	# - 5 bits for opcode ("9" for DATA_V2)
+	# - 3 bits for key-id ("0" at this point)
+	# - 12 bytes for peer-id:
+	#     - with asymmetric ID: "${p}" one way and "${p} + 9" the other way
+	#     - with symmetric ID: "${p}" both ways
+	HEADER1=$(printf "0x4800000%x" ${p})
+	HEADER2=$(printf "0x4800000%x" $((${p} + ID_OFFSET)))
+	RADDR=""
+	if [ "${PROTO}" == "UDP" ]; then
+		RADDR=$(awk "NR == ${p} {print \$3}" ${UDP_PEERS_FILE})
+	fi
+
+	timeout ${TCPDUMP_TIMEOUT} ip netns exec peer${p} \
+		tcpdump --immediate-mode -p -ni veth${p} -c 1 \
+		"$(build_capture_filter "${HEADER1}" "${RADDR}")" \
+		>/dev/null 2>&1 &
+	TCPDUMP_PID1=$!
+	timeout ${TCPDUMP_TIMEOUT} ip netns exec peer${p} \
+		tcpdump --immediate-mode -p -ni veth${p} -c 1 \
+		"$(build_capture_filter "${HEADER2}" "${RADDR}")" \
+		>/dev/null 2>&1 &
+	TCPDUMP_PID2=$!
+
+	sleep 0.3
 	ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((${p} + 1))
 	ip netns exec peer0 ping -qfc 500 -s 3000 -w 3 5.5.5.$((${p} + 1))
+
+	wait ${TCPDUMP_PID1}
+	wait ${TCPDUMP_PID2}
 done
 
 # ping LAN behind client 1
@@ -61,9 +92,12 @@ ip netns exec peer1 iperf3 -Z -t 3 -c 5.5.5.1
 
 echo "Adding secondary key and then swap:"
 for p in $(seq 1 ${NUM_PEERS}); do
-	ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 2 1 ${ALG} 0 data64.key
-	ip netns exec peer${p} ${OVPN_CLI} new_key tun${p} ${p} 2 1 ${ALG} 1 data64.key
-	ip netns exec peer${p} ${OVPN_CLI} swap_keys tun${p} ${p}
+	ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 2 1 ${ALG} 0 \
+		data64.key
+	ip netns exec peer${p} ${OVPN_CLI} new_key tun${p} \
+		$((${p} + ID_OFFSET)) 2 1 ${ALG} 1 data64.key
+	ip netns exec peer${p} ${OVPN_CLI} swap_keys tun${p} \
+		$((${p} + ID_OFFSET))
 done
 
 sleep 1
@@ -75,17 +109,19 @@ ip netns exec peer1 ${OVPN_CLI} get_peer tun1
 echo "Querying peer 1:"
 ip netns exec peer0 ${OVPN_CLI} get_peer tun0 1
 
-echo "Querying non-existent peer 10:"
-ip netns exec peer0 ${OVPN_CLI} get_peer tun0 10 || true
+echo "Querying non-existent peer 20:"
+ip netns exec peer0 ${OVPN_CLI} get_peer tun0 20 || true
 
 echo "Deleting peer 1:"
 ip netns exec peer0 ${OVPN_CLI} del_peer tun0 1
-ip netns exec peer1 ${OVPN_CLI} del_peer tun1 1
+ip netns exec peer1 ${OVPN_CLI} del_peer tun1 $((1 + ID_OFFSET))
 
 echo "Querying keys:"
 for p in $(seq 2 ${NUM_PEERS}); do
-	ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} ${p} 1
-	ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} ${p} 2
+	ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} \
+		$((${p} + ID_OFFSET)) 1
+	ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} \
+		$((${p} + ID_OFFSET)) 2
 done
 
 echo "Deleting peer while sending traffic:"
@@ -94,25 +130,29 @@ sleep 2
 ip netns exec peer0 ${OVPN_CLI} del_peer tun0 2
 # following command fails in TCP mode
 # (both ends get conn reset when one peer disconnects)
-ip netns exec peer2 ${OVPN_CLI} del_peer tun2 2 || true
+ip netns exec peer2 ${OVPN_CLI} del_peer tun2 $((2 + ID_OFFSET)) || true
 
 echo "Deleting keys:"
 for p in $(seq 3 ${NUM_PEERS}); do
-	ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} ${p} 1
-	ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} ${p} 2
+	ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} \
+		$((${p} + ID_OFFSET)) 1
+	ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} \
+		$((${p} + ID_OFFSET)) 2
 done
 
 echo "Setting timeout to 3s MP:"
 for p in $(seq 3 ${NUM_PEERS}); do
 	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 3 3 || true
-	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} ${p} 0 0
+	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} \
+		$((${p} + ID_OFFSET)) 0 0
 done
 # wait for peers to timeout
 sleep 5
 
 echo "Setting timeout to 3s P2P:"
 for p in $(seq 3 ${NUM_PEERS}); do
-	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} ${p} 3 3
+	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} \
+		$((${p} + ID_OFFSET)) 3 3
 done
 sleep 5
 
diff --git a/tools/testing/selftests/net/ovpn/udp_peers.txt b/tools/testing/selftests/net/ovpn/udp_peers.txt
index e9773ddf875c..93de6465353c 100644
--- a/tools/testing/selftests/net/ovpn/udp_peers.txt
+++ b/tools/testing/selftests/net/ovpn/udp_peers.txt
@@ -1,6 +1,6 @@
-1 10.10.1.1 1 10.10.1.2 1 5.5.5.2
-2 10.10.2.1 1 10.10.2.2 1 5.5.5.3
-3 10.10.3.1 1 10.10.3.2 1 5.5.5.4
-4 fd00:0:0:4::1 1 fd00:0:0:4::2 1 5.5.5.5
-5 fd00:0:0:5::1 1 fd00:0:0:5::2 1 5.5.5.6
-6 fd00:0:0:6::1 1 fd00:0:0:6::2 1 5.5.5.7
+1 10 10.10.1.1 1 10.10.1.2 1 5.5.5.2
+2 11 10.10.2.1 1 10.10.2.2 1 5.5.5.3
+3 12 10.10.3.1 1 10.10.3.2 1 5.5.5.4
+4 13 fd00:0:0:4::1 1 fd00:0:0:4::2 1 5.5.5.5
+5 14 fd00:0:0:5::1 1 fd00:0:0:5::2 1 5.5.5.6
+6 15 fd00:0:0:6::1 1 fd00:0:0:6::2 1 5.5.5.7
-- 
2.52.0



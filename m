Return-Path: <netdev+bounces-266203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAJNJiM7sGmDhQIAu9opvQ
	(envelope-from <netdev+bounces-266203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:39:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id F2C63253BE2
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 16:39:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 493BF329E80C
	for <lists+netdev@lfdr.de>; Tue, 10 Mar 2026 14:51:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28AB130100D;
	Tue, 10 Mar 2026 14:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="fr81Z7Zw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD802FFF90
	for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 14:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773154240; cv=none; b=kespSYJ8bAwBEAG8dbHT+CQYJCqPVN8IM9vH1MHFwtSGrkmnHBbaWeh7ZbZ5qTeQm9ox6ykvtrcsXBEl+O1xbDbCVFsERH3jfdhxDCsOjShxR4FSBhizpjlHnrgnV/vQAxTT3UuDV7BeqCjKdsPt4FS9htJZgHkJJFckDW0DTyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773154240; c=relaxed/simple;
	bh=n0d7Ac210yKM7JkHj5LCEyBfeQS1kp8pm+GRaLQ7qJw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EBiojZiRbYgPnlHS3gIJ4CFX+hKu7VQD2aHyKS2X+KS0qBCMJFAwuqLVvfM0/ifhwCCfcOWGKZcfSX416xRtFOvI7WG7579b00S4plDWlbKq877JgNTp7a0PIVGcvQNLIdr/Cde+Ew+WCSGH6n5WA0zqjidSNhdRTGPRXKkIlqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=fr81Z7Zw; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-439aeed8a5bso10358506f8f.3
        for <netdev@vger.kernel.org>; Tue, 10 Mar 2026 07:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1773154235; x=1773759035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XM62puHPEKfQpQ0UaAaVbiSSJSx06PO6IEMNyTgHfJw=;
        b=fr81Z7Zwa6ZbQPalz1IFHFFA2y8DNcUgw2OtzO1EdyiDWDE7Rh7z8hxcpZcKST/+am
         BHDygnJMNhNV45H7j1I4VNO6U8QI3eiNV+UuZclbS3+LeleSkDiQahzj0rVp/S5fVclH
         RQthYOUYhdUw4f+mTZg+FuYFm4N11RdF4HenGG5U03b62zTKA3zY46bdbm7ATdl6a8qP
         pxPRPnjuU/nTJt0NP3gfPFCVEWZz61DEmcL7t4dB/TeqHUTpGx7+zBaiaBxNGFvL1sDY
         o501zPTiE+Ip4A4JMUSm/ZrdDB304+3324MNHKR67+ZFtoZpGGZYzFeGO/APs48EeAnC
         eKyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773154235; x=1773759035;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XM62puHPEKfQpQ0UaAaVbiSSJSx06PO6IEMNyTgHfJw=;
        b=a/E5JaiJaDn/NyOXg4lECRtnWPzUgc1rniexwyZkCbHxNlZXGGknL8OAGr7caPuQre
         BkTzKwZiYoUYVMphiJzs9xJ5XFv06QuAI3uLwdcNu1Xk6G0yVZJyeFqYcdCizBrsAsBb
         7dANbCc3DBOuJp+Gse2aLlYOxJpInj6QGrcWPnsEwYUtFOUGnAPDBaSNjqTONIcmzIkM
         WfmntGUGdledOB5WF+sYlSR3/Re7DpRs1ofzm3Ss4W1juy/IDlXWu6i9Y2+IzCptxsB4
         TrsLmwYTtt8R03ee5deLWUPIOEC2y9HlTEX1GMKn4mjp2d5moL0FksQiRXM5+qhiqZvp
         pDWA==
X-Gm-Message-State: AOJu0Yxb1dfKcfMVeJhzPonk1kVhc5Goy8BLjQSisCaLsILVU9S4qfe4
	Lg/HMaruTHBn3XwoFEEDyKF/CGfuclaK9DLkRe2FaalKyIXcJDgrMSUKZ6AboxWIp0B01tuMfLr
	rpdTEVog6i7nnYHtsg+SQ1/5mr87KtLcDKsCCLBWW8xtYkEfvoSrlBkbXHRegaQut
X-Gm-Gg: ATEYQzx3UqPpyRaH6ryiNGgRvOVWQPJc+S+lOGT+agaF8MJ0eE5dGbLoTtZWgMkG3xX
	ZAkag/O7eMjIa6JLMxAy+a+DL7gJoOtwZzMcRkmFK7J+NoLXpgNB6df6nkEwBijBCH6NolPKJbr
	yUm7GcnsnQXGfnLtI7cRfAXFBgfXL+ujSwK0OfBIjg25wy9jmQ2Js1ivHGD82q4Zgg8wTDFFmqI
	0qA9nIe9hYvD+QyBUYR+3hoMAMDmTH7vVHFfrUFPj2EUQsMYv69lIRBbeqZJFP5iwHwLHNxQ958
	ItNt/3JXJmBW6E7rGA0+Zjc7JND0KaiY8dcJLMYCVfnM2QDJkR9yJMb4JDeGkQXtT7iEwyjPke5
	DiL/OthX2hty168AI29XgrmQbArsv8DfuFM8fKo44l+fh9ywc1ltmp4JAWHBbaYp02Bk1iAbbtW
	aVhw4+b7JwE1yu2V4F+yxgpR0kqzXXr3aP1XV2
X-Received: by 2002:a05:6000:290d:b0:439:b6ae:5d5f with SMTP id ffacd0b85a97d-439da882118mr27317215f8f.36.1773154235223;
        Tue, 10 Mar 2026 07:50:35 -0700 (PDT)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:5594:94ef:1bd6:89e8])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dad8d968sm35586700f8f.6.2026.03.10.07.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2026 07:50:34 -0700 (PDT)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
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
Date: Tue, 10 Mar 2026 15:50:04 +0100
Message-ID: <20260310145006.30858-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260310145006.30858-1-antonio@openvpn.net>
References: <20260310145006.30858-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F2C63253BE2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266203-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[openvpn.net:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[openvpn.net:dkim,openvpn.net:email,openvpn.net:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,mandelbit.com:email]
X-Rspamd-Action: no action

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
 tools/testing/selftests/net/ovpn/common.sh    | 39 ++++++++---
 .../selftests/net/ovpn/json/peer1.json        |  2 +-
 .../selftests/net/ovpn/json/peer2.json        |  2 +-
 .../selftests/net/ovpn/json/peer3.json        |  2 +-
 .../selftests/net/ovpn/json/peer4.json        |  2 +-
 .../selftests/net/ovpn/json/peer5.json        |  2 +-
 .../selftests/net/ovpn/json/peer6.json        |  2 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 65 ++++++++++++-------
 .../testing/selftests/net/ovpn/tcp_peers.txt  | 12 ++--
 .../selftests/net/ovpn/test-close-socket.sh   |  2 +-
 tools/testing/selftests/net/ovpn/test.sh      | 58 +++++++++++++----
 .../testing/selftests/net/ovpn/udp_peers.txt  | 12 ++--
 12 files changed, 133 insertions(+), 67 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index fff29618fcd2..b02fee1fe643 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -54,6 +54,25 @@ setup_ns() {
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
@@ -72,13 +91,14 @@ add_peer() {
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
+			TX_ID=$(awk "NR == ${1} {print \$2}" ${UDP_PEERS_FILE})
+			RADDR=$(awk "NR == ${1} {print \$3}" ${UDP_PEERS_FILE})
+			RPORT=$(awk "NR == ${1} {print \$4}" ${UDP_PEERS_FILE})
+			LPORT=$(awk "NR == ${1} {print \$6}" ${UDP_PEERS_FILE})
+			ip netns exec peer${1} ${OVPN_CLI} new_peer tun${1} \
+				${TX_ID} ${1} ${LPORT} ${RADDR} ${RPORT}
+			ip netns exec peer${1} ${OVPN_CLI} new_key tun${1} \
+				${TX_ID} 1 0 ${ALG} 1 data64.key
 		fi
 	else
 		if [ ${1} -eq 0 ]; then
@@ -90,8 +110,9 @@ add_peer() {
 			}) &
 			sleep 5
 		else
-			ip netns exec peer${1} ${OVPN_CLI} connect tun${1} ${1} 10.10.${1}.1 1 \
-				data64.key
+			TX_ID=$(awk "NR == ${1} {print \$2}" ${TCP_PEERS_FILE})
+			ip netns exec peer${1} ${OVPN_CLI} connect tun${1} ${TX_ID} ${1} \
+				10.10.${1}.1 1 data64.key
 		fi
 	fi
 }
diff --git a/tools/testing/selftests/net/ovpn/json/peer1.json b/tools/testing/selftests/net/ovpn/json/peer1.json
index 5da4ea9d51fb..1009d26dc14a 100644
--- a/tools/testing/selftests/net/ovpn/json/peer1.json
+++ b/tools/testing/selftests/net/ovpn/json/peer1.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 1}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 10}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer2.json b/tools/testing/selftests/net/ovpn/json/peer2.json
index 8f6db4f8c2ac..44e9fad2b622 100644
--- a/tools/testing/selftests/net/ovpn/json/peer2.json
+++ b/tools/testing/selftests/net/ovpn/json/peer2.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 2}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "userspace", "id": 11}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer3.json b/tools/testing/selftests/net/ovpn/json/peer3.json
index bdabd6fa2e64..d4be8ba130ae 100644
--- a/tools/testing/selftests/net/ovpn/json/peer3.json
+++ b/tools/testing/selftests/net/ovpn/json/peer3.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 3}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 12}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer4.json b/tools/testing/selftests/net/ovpn/json/peer4.json
index c3734bb9251b..67d27e2d48ac 100644
--- a/tools/testing/selftests/net/ovpn/json/peer4.json
+++ b/tools/testing/selftests/net/ovpn/json/peer4.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 4}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 13}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer5.json b/tools/testing/selftests/net/ovpn/json/peer5.json
index 46c4a348299d..ecd9bd0b2f37 100644
--- a/tools/testing/selftests/net/ovpn/json/peer5.json
+++ b/tools/testing/selftests/net/ovpn/json/peer5.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 5}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 14}}}
diff --git a/tools/testing/selftests/net/ovpn/json/peer6.json b/tools/testing/selftests/net/ovpn/json/peer6.json
index aa30f2cff625..7fded29c5804 100644
--- a/tools/testing/selftests/net/ovpn/json/peer6.json
+++ b/tools/testing/selftests/net/ovpn/json/peer6.json
@@ -1 +1 @@
-{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 6}}}
+{"name": "peer-del-ntf", "msg": {"ifindex": 0, "peer": {"del-reason": "expired", "id": 15}}}
diff --git a/tools/testing/selftests/net/ovpn/ovpn-cli.c b/tools/testing/selftests/net/ovpn/ovpn-cli.c
index 7178abae1b2f..5b58aca9366c 100644
--- a/tools/testing/selftests/net/ovpn/ovpn-cli.c
+++ b/tools/testing/selftests/net/ovpn/ovpn-cli.c
@@ -103,7 +103,7 @@ struct ovpn_ctx {
 
 	sa_family_t sa_family;
 
-	unsigned long peer_id;
+	unsigned long peer_id, tx_id;
 	unsigned long lport;
 
 	union {
@@ -649,6 +649,7 @@ static int ovpn_new_peer(struct ovpn_ctx *ovpn, bool is_tcp)
 
 	attr = nla_nest_start(ctx->nl_msg, OVPN_A_PEER);
 	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_ID, ovpn->peer_id);
+	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_TX_ID, ovpn->tx_id);
 	NLA_PUT_U32(ctx->nl_msg, OVPN_A_PEER_SOCKET, ovpn->socket);
 
 	if (!is_tcp) {
@@ -767,6 +768,10 @@ static int ovpn_handle_peer(struct nl_msg *msg, void (*arg)__always_unused)
 		fprintf(stderr, "* Peer %u\n",
 			nla_get_u32(pattrs[OVPN_A_PEER_ID]));
 
+	if (pattrs[OVPN_A_PEER_TX_ID])
+		fprintf(stderr, "\tTX peer ID %u\n",
+			nla_get_u32(pattrs[OVPN_A_PEER_TX_ID]));
+
 	if (pattrs[OVPN_A_PEER_SOCKET_NETNSID])
 		fprintf(stderr, "\tsocket NetNS ID: %d\n",
 			nla_get_s32(pattrs[OVPN_A_PEER_SOCKET_NETNSID]));
@@ -1676,11 +1681,13 @@ static void usage(const char *cmd)
 		"\tkey_file: file containing the symmetric key for encryption\n");
 
 	fprintf(stderr,
-		"* new_peer <iface> <peer_id> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
+		"* new_peer <iface> <peer_id> <tx_id> <lport> <raddr> <rport> [vpnaddr]: add new peer\n");
 	fprintf(stderr, "\tiface: ovpn interface name\n");
 	fprintf(stderr, "\tlport: local UDP port to bind to\n");
 	fprintf(stderr,
-		"\tpeer_id: peer ID to be used in data packets to/from this peer\n");
+		"\tpeer_id: peer ID found in data packets received from this peer\n");
+	fprintf(stderr,
+		"\ttx_id: peer ID to be used when sending to this peer\n");
 	fprintf(stderr, "\traddr: peer IP address\n");
 	fprintf(stderr, "\trport: peer UDP port\n");
 	fprintf(stderr, "\tvpnaddr: peer VPN IP\n");
@@ -1691,7 +1698,8 @@ static void usage(const char *cmd)
 	fprintf(stderr, "\tlport: local UDP port to bind to\n");
 	fprintf(stderr,
 		"\tpeers_file: text file containing one peer per line. Line format:\n");
-	fprintf(stderr, "\t\t<peer_id> <raddr> <rport> <vpnaddr>\n");
+	fprintf(stderr,
+		"\t\t<peer_id> <tx_id> <raddr> <rport> <laddr> <lport> <vpnaddr>\n");
 
 	fprintf(stderr,
 		"* set_peer <iface> <peer_id> <keepalive_interval> <keepalive_timeout>: set peer attributes\n");
@@ -1804,12 +1812,18 @@ static int ovpn_parse_remote(struct ovpn_ctx *ovpn, const char *host,
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
+		return -1;
+	}
+
+	ovpn->tx_id = strtoul(tx_id, NULL, 10);
+	if (errno == ERANGE || ovpn->tx_id > PEER_ID_UNDEF) {
+		fprintf(stderr, "tx peer ID value out of range\n");
 		return -1;
 	}
 
@@ -1939,8 +1953,8 @@ static void ovpn_waitbg(void)
 
 static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 {
-	char peer_id[10], vpnip[INET6_ADDRSTRLEN], laddr[128], lport[10];
-	char raddr[128], rport[10];
+	char peer_id[10], tx_id[10], vpnip[INET6_ADDRSTRLEN], laddr[128];
+	char lport[10], raddr[128], rport[10];
 	int n, ret;
 	FILE *fp;
 
@@ -1967,7 +1981,8 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 
 		int num_peers = 0;
 
-		while ((n = fscanf(fp, "%s %s\n", peer_id, vpnip)) == 2) {
+		while ((n = fscanf(fp, "%s %s %s\n", peer_id, tx_id,
+				   vpnip)) == 3) {
 			struct ovpn_ctx peer_ctx = { 0 };
 
 			if (num_peers == MAX_PEERS) {
@@ -1987,8 +2002,8 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 			/* store peer sockets to test TCP I/O */
 			ovpn->cli_sockets[num_peers] = peer_ctx.socket;
 
-			ret = ovpn_parse_new_peer(&peer_ctx, peer_id, NULL,
-						  NULL, vpnip);
+			ret = ovpn_parse_new_peer(&peer_ctx, peer_id, tx_id,
+						  NULL, NULL, vpnip);
 			if (ret < 0) {
 				fprintf(stderr, "error while parsing line\n");
 				return -1;
@@ -2056,16 +2071,16 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
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
 
-			ret = ovpn_parse_new_peer(&peer_ctx, peer_id, raddr,
-						  rport, vpnip);
+			ret = ovpn_parse_new_peer(&peer_ctx, peer_id, tx_id,
+						  raddr, rport, vpnip);
 			if (ret < 0) {
 				fprintf(stderr, "error while parsing line\n");
 				return -1;
@@ -2177,43 +2192,43 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 			ovpn->sa_family = AF_INET6;
 		break;
 	case CMD_CONNECT:
-		if (argc < 6)
+		if (argc < 7)
 			return -EINVAL;
 
 		ovpn->sa_family = AF_INET;
 
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
diff --git a/tools/testing/selftests/net/ovpn/test.sh b/tools/testing/selftests/net/ovpn/test.sh
index c2904342ec57..8e4f2025d4f6 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -31,14 +31,42 @@ done
 
 for p in $(seq 1 ${NUM_PEERS}); do
 	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
-	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} ${p} 60 120
+	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} $((${p}+9)) 60 120
 done
 
 sleep 1
 
+TCPDUMP_TIMEOUT="1.5s"
 for p in $(seq 1 ${NUM_PEERS}); do
+	# The first part of the data packet header consists of:
+	# - TCP only: 2 bytes for the packet length
+	# - 5 bits for opcode ("9" for DATA_V2)
+	# - 3 bits for key-id ("0" at this point)
+	# - 12 bytes for peer-id ("${p}" one way and "${p} + 9" the other way)
+	HEADER1=$(printf "0x4800000%x" ${p})
+	HEADER2=$(printf "0x4800000%x" $((${p} + 9)))
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
@@ -61,9 +89,11 @@ ip netns exec peer1 iperf3 -Z -t 3 -c 5.5.5.1
 
 echo "Adding secondary key and then swap:"
 for p in $(seq 1 ${NUM_PEERS}); do
-	ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 2 1 ${ALG} 0 data64.key
-	ip netns exec peer${p} ${OVPN_CLI} new_key tun${p} ${p} 2 1 ${ALG} 1 data64.key
-	ip netns exec peer${p} ${OVPN_CLI} swap_keys tun${p} ${p}
+	ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 2 1 ${ALG} 0 \
+		data64.key
+	ip netns exec peer${p} ${OVPN_CLI} new_key tun${p} $((${p} + 9)) 2 1 \
+		${ALG} 1 data64.key
+	ip netns exec peer${p} ${OVPN_CLI} swap_keys tun${p} $((${p} + 9))
 done
 
 sleep 1
@@ -75,17 +105,17 @@ ip netns exec peer1 ${OVPN_CLI} get_peer tun1
 echo "Querying peer 1:"
 ip netns exec peer0 ${OVPN_CLI} get_peer tun0 1
 
-echo "Querying non-existent peer 10:"
-ip netns exec peer0 ${OVPN_CLI} get_peer tun0 10 || true
+echo "Querying non-existent peer 20:"
+ip netns exec peer0 ${OVPN_CLI} get_peer tun0 20 || true
 
 echo "Deleting peer 1:"
 ip netns exec peer0 ${OVPN_CLI} del_peer tun0 1
-ip netns exec peer1 ${OVPN_CLI} del_peer tun1 1
+ip netns exec peer1 ${OVPN_CLI} del_peer tun1 10
 
 echo "Querying keys:"
 for p in $(seq 2 ${NUM_PEERS}); do
-	ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} ${p} 1
-	ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} ${p} 2
+	ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} $((${p} + 9)) 1
+	ip netns exec peer${p} ${OVPN_CLI} get_key tun${p} $((${p} + 9)) 2
 done
 
 echo "Deleting peer while sending traffic:"
@@ -94,25 +124,25 @@ sleep 2
 ip netns exec peer0 ${OVPN_CLI} del_peer tun0 2
 # following command fails in TCP mode
 # (both ends get conn reset when one peer disconnects)
-ip netns exec peer2 ${OVPN_CLI} del_peer tun2 2 || true
+ip netns exec peer2 ${OVPN_CLI} del_peer tun2 11 || true
 
 echo "Deleting keys:"
 for p in $(seq 3 ${NUM_PEERS}); do
-	ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} ${p} 1
-	ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} ${p} 2
+	ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} $((${p} + 9)) 1
+	ip netns exec peer${p} ${OVPN_CLI} del_key tun${p} $((${p} + 9)) 2
 done
 
 echo "Setting timeout to 3s MP:"
 for p in $(seq 3 ${NUM_PEERS}); do
 	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 3 3 || true
-	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} ${p} 0 0
+	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} $((${p} + 9)) 0 0
 done
 # wait for peers to timeout
 sleep 5
 
 echo "Setting timeout to 3s P2P:"
 for p in $(seq 3 ${NUM_PEERS}); do
-	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} ${p} 3 3
+	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} $((${p} + 9)) 3 3
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



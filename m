Return-Path: <netdev+bounces-262012-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uLrxDg0xomke0wQAu9opvQ
	(envelope-from <netdev+bounces-262012-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:04:29 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 916561BF4ED
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 01:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B45B31A1024
	for <lists+netdev@lfdr.de>; Sat, 28 Feb 2026 00:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5936F237713;
	Sat, 28 Feb 2026 00:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="RyTbJXAu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 266D224E4C4
	for <netdev@vger.kernel.org>; Sat, 28 Feb 2026 00:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772236830; cv=none; b=seSLCLZBzd2QdMyqowJ5Y9mC1motXOhvLj0w3ISDBT93q2OZtFIRbLxurme/igOHe/1TM315H7/KdNljwDpPQlJQvdmMxLZlDLUjDpdql4b6fReFLnK52I4lKkl3REg50jliJP/6ohP9jjDErYC5bPriAApzA14J+lu3snPx0HY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772236830; c=relaxed/simple;
	bh=VCtQa5QWV+Lj+TMINcEnWYRUKbzFErxJxm+iRatB9tY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFOCaK7vK1/+3kTncMDWYs97FoPqu3MCHCFWWXFprNkUqd/SRwm5dJkWMV4CR+0BCDL6dGbQqgifFYogqd5NDoss2l58k96uSo6oGDO0pQ/yKjhKO249uGwchGed8uYrYPjPiKfJFWr2xvoGi7ry92K3vxC5wSmU0lmoYbGGZa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=RyTbJXAu; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-48374014a77so29750745e9.3
        for <netdev@vger.kernel.org>; Fri, 27 Feb 2026 16:00:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1772236826; x=1772841626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5Qyy8IY001Euz6XMuaJUG07zfFW20qQCfM2N8ySHe4=;
        b=RyTbJXAufCjv0/sRDp57NwrG9f9kyg8vQvVY3bNmvBtA3Gu1vz5EfcGLG2dhfQVlQR
         fNCUgUOY6RnknGc/wdwgndIC/Dh9UbOvj8S7p6oJr6PT3nQsbXvrvf4u9799O4Vcqq+R
         buh5Ap/RNij84zI4ser5q7j01Tok/NLs33OuEOtBcSrkUoztFqD2ClrN89E3vP08g/Cw
         0buUWswEcvFrwqEgueQgfSn5tWqrE/KIEeSFMkJlAfJpVUhq3maCiPPpf1XaDvz6i+1T
         mSxwYdWJs6j46Erif2GwKqzGCkxBirGyCyPzvq2jaEUlJsq1mbOpQoNX8r8Me1EawQNe
         tQKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772236826; x=1772841626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O5Qyy8IY001Euz6XMuaJUG07zfFW20qQCfM2N8ySHe4=;
        b=s3fOCNby0nsB7NstsIqmtNWPrIJk1Cc7/VBqmY6oORSbof9bNMfHxW6Ftx4Vh7bgJa
         4J/ImR/d3Jow8Oe1ixHPAO8I/jcO8MiQUCLUWzu2nYx/7Hn9Jg8OZA+Qbikn4vFO+aTC
         kllSYm/PDtYWjARmDYhBKLHWJyVos8/AejHvoWbtJv1OxqfBbQRuTUnRS2pqbHuBvF0l
         aQDCpc35RyhTTJF6+rc+Jp+IRwnlUZAjQxoFrJpry3MjtwlGn8lnIBOAJgJ7tBDVVFap
         GqQVe3TD9EevrXceWD6R6B2JqwqlEtdIZaQ0pwEmMeB3Fn60jve3FLnufRR+M+picYye
         tp2Q==
X-Gm-Message-State: AOJu0Yy5fektz2pLC2OF6uO9uH0+zbxtG/eLwYvrXah2+i9UsAqU4h7i
	I6VsZqdkjbIktQYJ6EkgxKqIRiYfIGMfxw1MmyT0I0CIyM0ms+vAm+76gTM8w+eDdwWXQ/GijSS
	Gq+aeybHXSqpy14Ao7wOwLFSX0aYQmdhokCj1sl1n8+QKBmzkCQybyoQWdUNto2O/
X-Gm-Gg: ATEYQzxna1qPSKM5FqwFMroewAU2xWBKCKRTh8erIWPdBU5iZUPHn3/Ohkub7358Ynl
	lEcZvbm/lBTtjA/ZLCi7jetA6pQoZWaBpg9rmaPQ2xaQ5IVfH3IfR5NsZnmWN1BpPA/8a9gLGf3
	zusGtwKqrNBpySAPuCBha3QqY6dDlvsTj8pXDXtfKjYh65EZ73QNgMf9Q85/EF6ajIXRPfija2k
	VNZjF4gkiDvroKZtWkjuexPe2Mk2ciciDvDGmLSlGeK8XYMU5dmotGi4SaXsPrmSwHdoFB4oGk1
	kC8YTfXHpBlg/Hg6M1HJSicogPu7eKrDcyeV8gSxYGvETvBZcZIxCQMxyW74D+LjalRFXIcUS2R
	kHbBAIY1MJBgHGwJmjmiauNRxTu34HEZzmOFJJPV/7qGqviZzIAd0k74zEFlomloNCh0KdTqXul
	YdW/faRoaJOz5W8x1Gvoz/RRodRzTx4fBSdqeF
X-Received: by 2002:a05:600c:c4a6:b0:480:1d0b:2d32 with SMTP id 5b1f17b1804b1-483c9bc0344mr74884915e9.12.1772236826067;
        Fri, 27 Feb 2026 16:00:26 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:d378:d869:cb10:1603])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb77466sm94420695e9.5.2026.02.27.16.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Feb 2026 16:00:24 -0800 (PST)
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
	Antonio Quartulli <antonio@openvpn.net>
Subject: [PATCH net-next 7/9] selftests: ovpn: check asymmetric peer-id
Date: Sat, 28 Feb 2026 00:59:53 +0100
Message-ID: <20260227235955.660-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260227235955.660-1-antonio@openvpn.net>
References: <20260227235955.660-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[openvpn.net,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[openvpn.net:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[antonio@openvpn.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262012-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[openvpn.net:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mandelbit.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,openvpn.net:mid,openvpn.net:dkim,openvpn.net:email]
X-Rspamd-Queue-Id: 916561BF4ED
X-Rspamd-Action: no action

From: Ralf Lici <ralf@mandelbit.com>

Extend the base test to verify that the correct peer-id is set in data
packet headers. This is done by capturing ping packets with ngrep during
the initial exchange and matching the first portion of the header
against the expected sequence for every connection.

Cc: Shuah Khan <shuah@kernel.org>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
---
 tools/testing/selftests/net/ovpn/common.sh    | 20 +++----
 .../selftests/net/ovpn/json/peer1.json        |  2 +-
 .../selftests/net/ovpn/json/peer2.json        |  2 +-
 .../selftests/net/ovpn/json/peer3.json        |  2 +-
 .../selftests/net/ovpn/json/peer4.json        |  2 +-
 .../selftests/net/ovpn/json/peer5.json        |  2 +-
 .../selftests/net/ovpn/json/peer6.json        |  2 +-
 tools/testing/selftests/net/ovpn/ovpn-cli.c   | 53 ++++++++++++-------
 .../testing/selftests/net/ovpn/tcp_peers.txt  | 12 ++---
 .../selftests/net/ovpn/test-close-socket.sh   |  2 +-
 tools/testing/selftests/net/ovpn/test.sh      | 47 +++++++++++-----
 .../testing/selftests/net/ovpn/udp_peers.txt  | 12 ++---
 12 files changed, 97 insertions(+), 61 deletions(-)

diff --git a/tools/testing/selftests/net/ovpn/common.sh b/tools/testing/selftests/net/ovpn/common.sh
index f2b58361255d..d25cbfda15cc 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -76,13 +76,14 @@ add_peer() {
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
+			ip netns exec peer${1} ${OVPN_CLI} new_peer tun${1} ${TX_ID} ${1} \
+				${LPORT} ${RADDR} ${RPORT}
+			ip netns exec peer${1} ${OVPN_CLI} new_key tun${1} ${TX_ID} 1 0 \
+				${ALG} 1 data64.key
 		fi
 	else
 		if [ ${1} -eq 0 ]; then
@@ -94,8 +95,9 @@ add_peer() {
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
index 7178abae1b2f..8c684f61220b 100644
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
@@ -1691,7 +1698,7 @@ static void usage(const char *cmd)
 	fprintf(stderr, "\tlport: local UDP port to bind to\n");
 	fprintf(stderr,
 		"\tpeers_file: text file containing one peer per line. Line format:\n");
-	fprintf(stderr, "\t\t<peer_id> <raddr> <rport> <vpnaddr>\n");
+	fprintf(stderr, "\t\t<peer_id> <tx_id> <raddr> <rport> <laddr> <lport> <vpnaddr>\n");
 
 	fprintf(stderr,
 		"* set_peer <iface> <peer_id> <keepalive_interval> <keepalive_timeout>: set peer attributes\n");
@@ -1804,12 +1811,18 @@ static int ovpn_parse_remote(struct ovpn_ctx *ovpn, const char *host,
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
 
@@ -1939,7 +1952,7 @@ static void ovpn_waitbg(void)
 
 static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 {
-	char peer_id[10], vpnip[INET6_ADDRSTRLEN], laddr[128], lport[10];
+	char peer_id[10], tx_id[10], vpnip[INET6_ADDRSTRLEN], laddr[128], lport[10];
 	char raddr[128], rport[10];
 	int n, ret;
 	FILE *fp;
@@ -1967,7 +1980,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 
 		int num_peers = 0;
 
-		while ((n = fscanf(fp, "%s %s\n", peer_id, vpnip)) == 2) {
+		while ((n = fscanf(fp, "%s %s %s\n", peer_id, tx_id, vpnip)) == 3) {
 			struct ovpn_ctx peer_ctx = { 0 };
 
 			if (num_peers == MAX_PEERS) {
@@ -1987,7 +2000,7 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 			/* store peer sockets to test TCP I/O */
 			ovpn->cli_sockets[num_peers] = peer_ctx.socket;
 
-			ret = ovpn_parse_new_peer(&peer_ctx, peer_id, NULL,
+			ret = ovpn_parse_new_peer(&peer_ctx, peer_id, tx_id, NULL,
 						  NULL, vpnip);
 			if (ret < 0) {
 				fprintf(stderr, "error while parsing line\n");
@@ -2056,15 +2069,15 @@ static int ovpn_run_cmd(struct ovpn_ctx *ovpn)
 			return -1;
 		}
 
-		while ((n = fscanf(fp, "%s %s %s %s %s %s\n", peer_id, laddr,
-				   lport, raddr, rport, vpnip)) == 6) {
+		while ((n = fscanf(fp, "%s %s %s %s %s %s %s\n", peer_id, tx_id, laddr,
+				   lport, raddr, rport, vpnip)) == 7) {
 			struct ovpn_ctx peer_ctx = { 0 };
 
 			peer_ctx.ifindex = ovpn->ifindex;
 			peer_ctx.socket = ovpn->socket;
 			peer_ctx.sa_family = AF_UNSPEC;
 
-			ret = ovpn_parse_new_peer(&peer_ctx, peer_id, raddr,
+			ret = ovpn_parse_new_peer(&peer_ctx, peer_id, tx_id, raddr,
 						  rport, vpnip);
 			if (ret < 0) {
 				fprintf(stderr, "error while parsing line\n");
@@ -2177,25 +2190,25 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 			ovpn->sa_family = AF_INET6;
 		break;
 	case CMD_CONNECT:
-		if (argc < 6)
+		if (argc < 7)
 			return -EINVAL;
 
 		ovpn->sa_family = AF_INET;
 
-		ret = ovpn_parse_new_peer(ovpn, argv[3], argv[4], argv[5],
+		ret = ovpn_parse_new_peer(ovpn, argv[3], argv[4], argv[5], argv[6],
 					  NULL);
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
@@ -2204,15 +2217,15 @@ static int ovpn_parse_cmd_args(struct ovpn_ctx *ovpn, int argc, char *argv[])
 		if (argc < 7)
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
+		ret = ovpn_parse_new_peer(ovpn, argv[3], argv[4], argv[6], argv[7],
 					  vpnip);
 		if (ret < 0)
 			return -1;
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
index 3ec036fd7ebc..7fadf35813bd 100755
--- a/tools/testing/selftests/net/ovpn/test.sh
+++ b/tools/testing/selftests/net/ovpn/test.sh
@@ -33,14 +33,35 @@ done
 
 for p in $(seq 1 ${NUM_PEERS}); do
 	ip netns exec peer0 ${OVPN_CLI} set_peer tun0 ${p} 60 120
-	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} ${p} 60 120
+	ip netns exec peer${p} ${OVPN_CLI} set_peer tun${p} $((${p}+9)) 60 120
 done
 
 sleep 1
 
+NGREP_TIMEOUT="1.5s"
 for p in $(seq 1 ${NUM_PEERS}); do
+	# The first part of the data packet header consists of:
+	# - TCP only: 2 bytes for the packet length
+	# - 5 bits for opcode ("9" for DATA_V2)
+	# - 3 bits for key-id ("0" at this point)
+	# - 12 bytes for peer-id ("${p}" one way and "${p} + 9" the other way)
+	HEADER1=$(printf "0x4800000%x" ${p})
+	HEADER2=$(printf "0x4800000%x" $((${p} + 9)))
+	CAPTURE_LEN=8
+
+	timeout ${NGREP_TIMEOUT} ip netns exec peer${p} ngrep -xqn 1 -X "${HEADER1}" \
+		-S ${CAPTURE_LEN} -d veth${p} 1>/dev/null &
+	NGREP_PID1=$!
+	timeout ${NGREP_TIMEOUT} ip netns exec peer${p} ngrep -xqn 1 -X "${HEADER2}" \
+		-S ${CAPTURE_LEN} -d veth${p} 1>/dev/null &
+	NGREP_PID2=$!
+
+	sleep 0.3
 	ip netns exec peer0 ping -qfc 500 -w 3 5.5.5.$((${p} + 1))
 	ip netns exec peer0 ping -qfc 500 -s 3000 -w 3 5.5.5.$((${p} + 1))
+
+	wait ${NGREP_PID1}
+	wait ${NGREP_PID2}
 done
 
 # ping LAN behind client 1
@@ -64,8 +85,8 @@ ip netns exec peer1 iperf3 -Z -t 3 -c 5.5.5.1
 echo "Adding secondary key and then swap:"
 for p in $(seq 1 ${NUM_PEERS}); do
 	ip netns exec peer0 ${OVPN_CLI} new_key tun0 ${p} 2 1 ${ALG} 0 data64.key
-	ip netns exec peer${p} ${OVPN_CLI} new_key tun${p} ${p} 2 1 ${ALG} 1 data64.key
-	ip netns exec peer${p} ${OVPN_CLI} swap_keys tun${p} ${p}
+	ip netns exec peer${p} ${OVPN_CLI} new_key tun${p} $((${p} + 9)) 2 1 ${ALG} 1 data64.key
+	ip netns exec peer${p} ${OVPN_CLI} swap_keys tun${p} $((${p} + 9))
 done
 
 sleep 1
@@ -77,17 +98,17 @@ ip netns exec peer1 ${OVPN_CLI} get_peer tun1
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
@@ -96,25 +117,25 @@ sleep 2
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



Return-Path: <netdev+bounces-240602-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 017A7C76C05
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 01:22:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C565935E67A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 00:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80BF022A4FC;
	Fri, 21 Nov 2025 00:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="UjL1EndI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EE9B230D14
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 00:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763684471; cv=none; b=t9p+41AQ9r2ZChQiVOkhNia+sMp4qfrqt+nlNhl0nOQdkCubU7slgzOrfB0Tar5nPSB5I2Olh3qZSlg3jrytSeZD8JCwkFFunhQ+ZvC5wOFiRLgAJfsONaFgxBNxFfCcZi/EawS06W5Wvbc8aYW0UGDgBKBJvWoNjgNS9f3CSYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763684471; c=relaxed/simple;
	bh=B3X48z+i0svS6CMrwBWNioi+ZUphCTQJf9tX5jNOs18=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mESZr5prjMokbI6cErTywP6BY+GL583BLSM1Yf85fAXNwMhjIUyiPz5VYyUV4qrW5+jvcSIvwdO25YV97BzO5Aa5zVpLCTCuQrycqKLFhDIsa/a/ftjjS8ZdnII05YC/5AMLfBvSN0S2oNMHuFY9azC+QvnXXmXClKlR8BeOCD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=UjL1EndI; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-47774d3536dso11357675e9.0
        for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 16:21:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763684464; x=1764289264; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=roGumaTxlO3LkQN3tRcQymIFvftupINbZw9aWrWtxuQ=;
        b=UjL1EndIJ2uY59XrWwpLwFUTW0j3qlw8ymmBAZ2BeKAGkPQ6KLMG2wOi/4u3Yfy0Ov
         yMdlCLnP76pmbHbnnm8JXzLWfi9giRKT1I9LFTbXAqRGQSHzRC45x6VA9OkGsBCkhHFj
         PJIv/B0WV1eXka0EHxuFKL9P/nDp9pGaqUJ574kNgTwgw9oXZTnPwl3JhU4Uor2ncsgJ
         gnlfv7WqFQYUBGl+EC5q1NdPgqaQuHMn1QOlCpcmhhjjaEBBkfCj6QXqVRTj29HP25Ka
         lPc2G/Eu//905a+7roEjGm6Hq3Xla88lblkFt9D2GoJIQZ+r4nZ2Ofz4Yu7woJugyYgu
         4u2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763684464; x=1764289264;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=roGumaTxlO3LkQN3tRcQymIFvftupINbZw9aWrWtxuQ=;
        b=lOAlbkgkh3muFHDWHzseB+KtKx73aprNb4Yqy38L2WApSOl9b6lxHcc0yesXm5CIHQ
         15LqojIGlhUWJ3+yMPufXhGBX5bvaVi4CkfShIlOcFrydGsgmMAKTynAemYC0UHZhvE6
         bHzFa9NNMIxxsztYp9VXwLkWWuloQQwNcnlxGw2uZpu8rOrQw40tIPJY9M6gVKGwPeGz
         Tmtr4EXEpzOQR7QhQdrCtFmHCnkbUzpWZGGVToxR5tGySn0NeFCl0GUYd3WPzyUAAH0l
         IraNkE24B2Hm3GSq4pwokh+blpg9On+sJ9OJFHm8URkkUEyVQsWSpyhov7NxAZB8NW5p
         Tveg==
X-Gm-Message-State: AOJu0Yw+zHnbLkffl7M6kB2VdcQixsR7BUa8xhFPrEGSaELEnPKSHhsQ
	JrW3t8SeHZOF/NgqkbZN4KeAs3tRRrVp5ryxoq2jxwv4wdpp3qKfvJ0D7/F0WhQWl7m5MOs6FGX
	G8uLdkOXcUK+GR+xfh3vj8hEWY4ldItlf4mHp+JxczkMWdisx2w3TShnfctucAKym5uk=
X-Gm-Gg: ASbGncu2gGIoWNOjOQmkqaNsyrAi7xVMKdICAbJpWnyUATrjY+Gk3a8gbd3B8VImb7l
	Wpos6qm1Z86mr6noWhQGUAecgasGFLeHxqVo4RHmUd+7VLjIg4w3VioNnZbQV2qxxlooeMn8Oe0
	7CuR0rVcySIi8+dkn7Y9Jj90rtiOjtuDkxxk1FFbKKMb2H7Htyl7Cm+Y4vYgxUQ284JUs/CKHsi
	WCj3CslauwVMq5LooH4hU4+n1FgKFV2RtdmDzLbfN0pN3YbP1uaxNpKTBvPTm7Ga5pgQRD1jN9Z
	e7avRlYRh7XL8eXAwRa2EU07XWZsew3Neae2VbNA+BcY9K4N5km94R1wxjrCRP9OOzosOtq8TCt
	/Fei7A46WdGf0cdq8FN2kKs0yQ+edP1B0KsYXC9z1ERsOaBf9day7onbX8gYSo3PCzcYGrPp0un
	Eax87XtmXLdKlQPddirbKc6wc1
X-Google-Smtp-Source: AGHT+IHt2254stZ6IXicbiytKNwDSWftnHgQKthumXQtZbtXrcKnyYGkn92VGYUSESztDQtRrVqQPQ==
X-Received: by 2002:a05:600c:1e89:b0:477:a1bb:c58e with SMTP id 5b1f17b1804b1-477c04cfddcmr4025895e9.7.1763684463832;
        Thu, 20 Nov 2025 16:21:03 -0800 (PST)
Received: from inifinity.mandelbit.com ([2001:67c:2fbc:1:85ee:9871:b95c:24cf])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bf226bf7sm15287345e9.11.2025.11.20.16.21.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 16:21:02 -0800 (PST)
From: Antonio Quartulli <antonio@openvpn.net>
To: netdev@vger.kernel.org
Cc: Ralf Lici <ralf@mandelbit.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Shuah Khan <shuah@kernel.org>,
	Antonio Quartulli <antonio@openvpn.net>
Subject: [RFC net-next 07/13] selftests: ovpn: check asymmetric peer-id
Date: Fri, 21 Nov 2025 01:20:38 +0100
Message-ID: <20251121002044.16071-8-antonio@openvpn.net>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251121002044.16071-1-antonio@openvpn.net>
References: <20251121002044.16071-1-antonio@openvpn.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
index b91cf17ab01f..d926413c9f16 100644
--- a/tools/testing/selftests/net/ovpn/common.sh
+++ b/tools/testing/selftests/net/ovpn/common.sh
@@ -75,13 +75,14 @@ add_peer() {
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
@@ -93,8 +94,9 @@ add_peer() {
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
index 064453d16fdd..baabb4c9120e 100644
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
2.51.2



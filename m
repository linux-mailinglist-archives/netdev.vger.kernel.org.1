Return-Path: <netdev+bounces-203725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D3CAF6E3E
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:12:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 815DA1C441D8
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 09:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030782D5C74;
	Thu,  3 Jul 2025 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="YigwgpaU"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 363652D5427
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751533934; cv=none; b=tiAvgQDvfvd9iwcQDgqe74KUrNO01InWYuh0cpRwvpRADNU+Y7V7lD0uQP32u94TP69gv/Ovq/sRcMNiGmxa8HRgwkbBZh/ZShrgxvvtvq06fJzJwkT4z3i1TPKZxudpYn7NQ+MmbOzg5SbJf0cADEHXFMiJaVZnLNew+o7/VGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751533934; c=relaxed/simple;
	bh=PsI+wZ8TsbX4fmrrdoWsEfttrEJ/mrZQttHVRg/SqYE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=EFD6tnZl5fVYKH3N92U8UxyvBRpD9jSCj6Ke+2NgWOXRWjdjIzUn283zHZcgGyAAihi+/KixhbqlWAfh7DJAUuBBNwg49iQNYBDmDaTr47DzSYqAu7UNST1txAh7B+9sX2kFsX/0uwxEo93KuJ7qbkVz/g/TRHPJl2MPA2JUOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=YigwgpaU; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751533923;
	bh=My2Ls+teztTV8zbKsOq5d0jRZExIgjB5fOQGv7xisBY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=YigwgpaUGGzMy7/EIsn/qn4gX9VXAMBVYrYhNF5SDD9mdKqZ+Aq7SKx5FtEIIDfT0
	 Rw9wN534bz2t1g7U+OK2VlIVH7RHfKmei75PiU4oBy9MHrei91E4kDvrkbvgPEV9VO
	 St0g+XBY1vtys7te0s8z6oN7Xy9Pv5pUzCs9HjZPDB/9XairYJlimozOzCrZRjnOCA
	 HpTpagJJqFstcWBOtiVazrvor3vFvVI3LYJadY9akjd94dV1T+qAphbGG/kbOc7uTC
	 Z8cLE2aTZVM1BtZr2BXM6OSgX/ug02baa71NxmxkBIDr0gPYGDAqWodMPG/Pt4kl7v
	 6LFfPIpzCPG2A==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id C844F6A8ED; Thu,  3 Jul 2025 17:12:03 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Thu, 03 Jul 2025 17:11:53 +0800
Subject: [PATCH net-next 6/7] net: mctp: Test conflicts of connect() with
 bind()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250703-mctp-bind-v1-6-bb7e97c24613@codeconstruct.com.au>
References: <20250703-mctp-bind-v1-0-bb7e97c24613@codeconstruct.com.au>
In-Reply-To: <20250703-mctp-bind-v1-0-bb7e97c24613@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751533920; l=4852;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=PsI+wZ8TsbX4fmrrdoWsEfttrEJ/mrZQttHVRg/SqYE=;
 b=65MVBITFsq15yFQgE+gtu1Tn880BgFZTVQt07v/jzfFJMuEArygsiYMi0xQ4E7be3stKRB2se
 TdN5x1dtcRLD2Dkbz7fsomvC3rnfMnyyyoiUARiPKo8T5HuEZW8hylF
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

The addition of connect() adds new conflict cases to test.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
 net/mctp/test/route-test.c | 60 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 46f7765d9b5542e652332441761087ea0a416f3d..fa33d44399f14fd019c82fd5182b65b3457825e2 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -1241,6 +1241,10 @@ struct mctp_test_bind_setup {
 	mctp_eid_t bind_addr;
 	int bind_net;
 	u8 bind_type;
+
+	bool have_peer;
+	mctp_eid_t peer_addr;
+	int peer_net;
 };
 
 static const struct mctp_test_bind_setup bind_addrany_netdefault_type1 = {
@@ -1277,12 +1281,18 @@ static const struct mctp_test_bind_setup bind_addrany_net2_type2 = {
 	.bind_addr = MCTP_ADDR_ANY, .bind_net = 2, .bind_type = 2,
 };
 
+static const struct mctp_test_bind_setup bind_addrany_net2_type1_peer9 = {
+	.bind_addr = MCTP_ADDR_ANY, .bind_net = 2, .bind_type = 1,
+	.have_peer = true, .peer_addr = 9, .peer_net = 2,
+};
+
 struct mctp_bind_pair_test {
 	const struct mctp_test_bind_setup *bind1;
 	const struct mctp_test_bind_setup *bind2;
 	int error;
 };
 
+/* Pairs of binds and whether they will conflict */
 static const struct mctp_bind_pair_test mctp_bind_pair_tests[] = {
 	/* Both ADDR_ANY, conflict */
 	{ &bind_addrany_netdefault_type1, &bind_addrany_netdefault_type1, EADDRINUSE },
@@ -1307,14 +1317,29 @@ static const struct mctp_bind_pair_test mctp_bind_pair_tests[] = {
 	 *  vs ADDR_ANY, explicit default net 1, OK
 	 */
 	{ &bind_addrany_netdefault_type1, &bind_addrany_net1_type1, 0 },
+
+	/* specific remote peer doesn't conflict with any-peer bind */
+	{ &bind_addrany_net2_type1_peer9, &bind_addrany_net2_type1, 0 },
+
+	/* bind() NET_ANY is allowed with a connect() net */
+	{ &bind_addrany_net2_type1_peer9, &bind_addrany_netdefault_type1, 0 },
 };
 
 static void mctp_bind_pair_desc(const struct mctp_bind_pair_test *t, char *desc)
 {
+	char peer1[100] = {0}, peer2[100] = {0};
+
+	if (t->bind1->have_peer)
+		snprintf(peer1, sizeof(peer1), ", peer %d net %d",
+			 t->bind1->peer_addr, t->bind1->peer_net);
+	if (t->bind2->have_peer)
+		snprintf(peer2, sizeof(peer2), ", peer %d net %d",
+			 t->bind2->peer_addr, t->bind2->peer_net);
+
 	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
-		 "{bind(addr %d, type %d, net %d)} {bind(addr %d, type %d, net %d)} -> error %d",
-		 t->bind1->bind_addr, t->bind1->bind_type, t->bind1->bind_net,
-		 t->bind2->bind_addr, t->bind2->bind_type, t->bind2->bind_net,
+		 "{bind(addr %d, type %d, net %d%s)} {bind(addr %d, type %d, net %d%s)} -> error %d",
+		 t->bind1->bind_addr, t->bind1->bind_type, t->bind1->bind_net, peer1,
+		 t->bind2->bind_addr, t->bind2->bind_type, t->bind2->bind_net, peer2,
 		 t->error);
 }
 
@@ -1331,6 +1356,19 @@ static void mctp_test_bind_run(struct kunit *test, const struct mctp_test_bind_s
 	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, sock);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
+	/* connect() if requested */
+	if (setup->have_peer) {
+		memset(&addr, 0x0, sizeof(addr));
+		addr.smctp_family = AF_MCTP;
+		addr.smctp_network = setup->peer_net;
+		addr.smctp_addr.s_addr = setup->peer_addr;
+		/* connect() type must match bind() type */
+		addr.smctp_type = setup->bind_type;
+		rc = kernel_connect(*sock, (struct sockaddr *)&addr, sizeof(addr), 0);
+		KUNIT_EXPECT_EQ(test, rc, 0);
+	}
+
+	/* bind() */
 	memset(&addr, 0x0, sizeof(addr));
 	addr.smctp_family = AF_MCTP;
 	addr.smctp_network = setup->bind_net;
@@ -1340,6 +1378,21 @@ static void mctp_test_bind_run(struct kunit *test, const struct mctp_test_bind_s
 	*ret_bind_errno = kernel_bind(*sock, (struct sockaddr *)&addr, sizeof(addr));
 }
 
+static void mctp_test_bind_invalid(struct kunit *test)
+{
+	struct socket *sock;
+	int rc;
+
+	/* bind() fails if the bind() vs connect() networks mismatch. */
+	const struct mctp_test_bind_setup bind_connect_net_mismatch = {
+		.bind_addr = MCTP_ADDR_ANY, .bind_net = 1, .bind_type = 1,
+		.have_peer = true, .peer_addr = 9, .peer_net = 2,
+	};
+	mctp_test_bind_run(test, &bind_connect_net_mismatch, &rc, &sock);
+	KUNIT_EXPECT_EQ(test, -rc, EINVAL);
+	sock_release(sock);
+}
+
 static int mctp_test_bind_conflicts_inner(struct kunit *test,
 					  const struct mctp_test_bind_setup *bind1,
 	const struct mctp_test_bind_setup *bind2)
@@ -1407,6 +1460,7 @@ static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE(mctp_test_route_output_key_create),
 	KUNIT_CASE(mctp_test_route_input_cloned_frag),
 	KUNIT_CASE_PARAM(mctp_test_bind_conflicts, mctp_bind_pair_gen_params),
+	KUNIT_CASE(mctp_test_bind_invalid),
 
 	{ /* terminator */ },
 };

-- 
2.43.0



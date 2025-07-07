Return-Path: <netdev+bounces-204468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D26CAFAB48
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 07:56:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9316F17A6CF
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 05:56:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D23279346;
	Mon,  7 Jul 2025 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="I4sZXuNb"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64A2E270574
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751867732; cv=none; b=U9T9Gl/Vabt+4zbk5SJFyI8SCVLA4joFqeyWyEarILM6ADE8tMJ3DN6266xEL6uVrhEbczk6dtjz/vEi4mD0oF82VV1uhBKnWDj0vrWl8Aghs+Rlw+fK5RhiPT3FrlZ8zx1Ai0/fjvdgozOXqpFYZDjjywOPvmm4ihFc9k2j5vY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751867732; c=relaxed/simple;
	bh=orOoylo3gqii8BHeqLTLq30pGcoVMHGcl0cVVn305sA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SGMqR5Gg0YSsBz/zDe1F96wJ/14QMk4q8YRSjHwPQCpz+1DHzf9l03MeJDuqPZS+yv6Zr5zIx6gUkWWBXYDEohE25zJ9cKnth8DrKdwmGb172vvDyo6FlykiD53KJMDhmyuRsTZkqi97Taq3b+kQVAmE9FmhaQfw4Pe4rcM4Ajg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=I4sZXuNb; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751867721;
	bh=goUJmym6djJ/WJ7KfHk4qpKuSGhFSMc6jiV8vaWv0KQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=I4sZXuNbAeRX8+OEEem5xYpL9iVmMa1EhUv6PtDummySdi50zyudK5Q5Mx8sHdusd
	 OMCtcZZCn5EFXVcS+sJxs4usFkY/LHBJ5doChGmhjqhgFBNWP1ELdh8YhUF+f9E6QO
	 l+zALythjAyiYTZon+r1Dq3Yljj7PVTuPJzB/gIERCvmorxgdlyTYubPsI1CuYsn0q
	 zG4uILb+GmivyEIvF01CulkenofDd8hHsXJrJ49Eh5zYkgEPEcT8dW+rX95fMKpTgN
	 AbNrZVU/P8K52dN7oeZuepDaW3hcuSskmdr8WZzOZ87d9sJxlvRWj8wP5uOR9q6dXN
	 5wBYJ7o7ie7VQ==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 043926AC8D; Mon,  7 Jul 2025 13:55:21 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Mon, 07 Jul 2025 13:55:19 +0800
Subject: [PATCH net-next v2 6/7] net: mctp: Test conflicts of connect()
 with bind()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-mctp-bind-v2-6-fbaed8c1fb4d@codeconstruct.com.au>
References: <20250707-mctp-bind-v2-0-fbaed8c1fb4d@codeconstruct.com.au>
In-Reply-To: <20250707-mctp-bind-v2-0-fbaed8c1fb4d@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751867717; l=4899;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=orOoylo3gqii8BHeqLTLq30pGcoVMHGcl0cVVn305sA=;
 b=AMUezoKFaCrGIEfl2mISZgdO+to36VsYNlJsnAz1cWTCjjN31Q2RgmCyr+Ykl9R5aMigwWcov
 OQcc8hHb9G1BRzw/OO0Fgojsuybv/8+b+D7wnRLwUERMOpCr+aKxHAl
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

The addition of connect() adds new conflict cases to test.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>

---
v2:
- Avoid snprintf truncation warning
- Fix line lengths
---
 net/mctp/test/route-test.c | 64 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 60 insertions(+), 4 deletions(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 51838002a281ba6af5d9ebad5e38b031594a9850..394749defa242fe4339aa56825693dc62b482e7c 100644
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
@@ -1273,12 +1277,18 @@ static const struct mctp_test_bind_setup bind_addrany_net2_type2 = {
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
 	{ &bind_addrany_netdefault_type1, &bind_addrany_netdefault_type1,
@@ -1305,15 +1315,31 @@ static const struct mctp_bind_pair_test mctp_bind_pair_tests[] = {
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
+	char peer1[25] = {0}, peer2[25] = {0};
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
-		 t->error);
+		 "{bind(addr %d, type %d, net %d%s)} {bind(addr %d, type %d, net %d%s)} -> error %d",
+		 t->bind1->bind_addr, t->bind1->bind_type,
+		 t->bind1->bind_net, peer1,
+		 t->bind2->bind_addr, t->bind2->bind_type,
+		 t->bind2->bind_net, peer2, t->error);
 }
 
 KUNIT_ARRAY_PARAM(mctp_bind_pair, mctp_bind_pair_tests, mctp_bind_pair_desc);
@@ -1330,6 +1356,20 @@ static void mctp_test_bind_run(struct kunit *test,
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
+		rc = kernel_connect(*sock, (struct sockaddr *)&addr,
+				    sizeof(addr), 0);
+		KUNIT_EXPECT_EQ(test, rc, 0);
+	}
+
+	/* bind() */
 	memset(&addr, 0x0, sizeof(addr));
 	addr.smctp_family = AF_MCTP;
 	addr.smctp_network = setup->bind_net;
@@ -1340,6 +1380,21 @@ static void mctp_test_bind_run(struct kunit *test,
 		kernel_bind(*sock, (struct sockaddr *)&addr, sizeof(addr));
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
 static int
 mctp_test_bind_conflicts_inner(struct kunit *test,
 			       const struct mctp_test_bind_setup *bind1,
@@ -1410,6 +1465,7 @@ static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE(mctp_test_route_output_key_create),
 	KUNIT_CASE(mctp_test_route_input_cloned_frag),
 	KUNIT_CASE_PARAM(mctp_test_bind_conflicts, mctp_bind_pair_gen_params),
+	KUNIT_CASE(mctp_test_bind_invalid),
 
 	{ /* terminator */ },
 };

-- 
2.43.0



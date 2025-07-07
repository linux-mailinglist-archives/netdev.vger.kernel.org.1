Return-Path: <netdev+bounces-204467-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 395ABAFAB4A
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 07:56:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D754189D8DE
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 05:56:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8868278E44;
	Mon,  7 Jul 2025 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="KPTSNxHm"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3209274FD4
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 05:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751867730; cv=none; b=MrVK2Z44m0B59irQ8/bMEMd6X5pkeIlDizAAZ8AeRVwwXNbFAVoPH3uaH1XPnLU4uYmjb2AK+ZUqU0yhkoz/JMjenkyo2f/q0+h/v1h3cQd6R52bPessQCW86V8uLVu3gpT5M9pk1Nyf+rPqVM01Tc8wZ9j9+5/Ge3O3wmIsfCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751867730; c=relaxed/simple;
	bh=Jex7desYLOpfwxT2zVvDfyr/O9xghHXIcKeHxS0DxJw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RDp2ccqtqTHb9ZfxxpCg1Yl7GGcTxE76u441ftem+w2AgRcqF3xQ9k29OTLJWte9Hp6w7xVaa7rIdkXYgVUppxfLqDnnBbgQ40ngbHnljqYSoK1DwuzGQ3AiHv45+S+tAXpTTEjMs9bVgprfJeATmdWUgq9Ln6QPVmLMOjwp95s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=KPTSNxHm; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751867719;
	bh=S6Jzg2mSq8V7pFW2zEhHVsmCz2FguXNbOcQ3cuQEilo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=KPTSNxHm443ctV6JFrk+yV6Cc8XNQF+qnIGFVY4wHuJi/I/OP/fv/XZYuJv1L0MLD
	 B/RjFot/7flcHVPqGmqT4QLjwsCY//zwb2GT/nLTaW0UbSQpfCf1049Jbcmmu8AFUW
	 YnAv2j4YkDJ5E1j18MF62Cjhu2MFPeZhHUyT3Qx3H6su0bYq0a4hPA6HovWbwsoCDA
	 2VdrB7ec7lkuH106P50CtybgzrWZw55Pljl0QLysgJ0QHqQirWdWFlYh7thlKlJU1W
	 jzm0MbEfqRlJyCvTbKDlEfDPpQjzKf67UmTqjhj9HRZhLqxcEdS7yuMGYEz2/Vfc7S
	 s6Ni8qgEfJ80g==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 9B8556AC88; Mon,  7 Jul 2025 13:55:19 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Mon, 07 Jul 2025 13:55:16 +0800
Subject: [PATCH net-next v2 3/7] net: mctp: Add test for conflicting
 bind()s
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-mctp-bind-v2-3-fbaed8c1fb4d@codeconstruct.com.au>
References: <20250707-mctp-bind-v2-0-fbaed8c1fb4d@codeconstruct.com.au>
In-Reply-To: <20250707-mctp-bind-v2-0-fbaed8c1fb4d@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751867717; l=6372;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=Jex7desYLOpfwxT2zVvDfyr/O9xghHXIcKeHxS0DxJw=;
 b=XVaCUN+m9r+l+Ry2p2W/Wf1dRzqL0zU3rWM/opCkeIfulHMHaMDpjBbMnZTkalkjyeRVzwOkS
 AOVjDyhTOi+DiqKl4Wbn73yXC9cnNKIs+7nSDzds58Bc6bMoRkBaw+9
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

Test pairwise combinations of bind addresses and types.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>

---
v2:
- Remove unused bind test case
- Fix line lengths
---
 net/mctp/test/route-test.c | 160 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 159 insertions(+), 1 deletion(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 06c1897b685a8bdfd6bb4f1bccaacb53b0cd54ba..51838002a281ba6af5d9ebad5e38b031594a9850 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -1237,7 +1237,163 @@ static void mctp_test_route_output_key_create(struct kunit *test)
 	mctp_test_destroy_dev(dev);
 }
 
+struct mctp_test_bind_setup {
+	mctp_eid_t bind_addr;
+	int bind_net;
+	u8 bind_type;
+};
+
+static const struct mctp_test_bind_setup bind_addrany_netdefault_type1 = {
+	.bind_addr = MCTP_ADDR_ANY, .bind_net = MCTP_NET_ANY, .bind_type = 1,
+};
+
+static const struct mctp_test_bind_setup bind_addrany_net2_type1 = {
+	.bind_addr = MCTP_ADDR_ANY, .bind_net = 2, .bind_type = 1,
+};
+
+/* 1 is default net */
+static const struct mctp_test_bind_setup bind_addr8_net1_type1 = {
+	.bind_addr = 8, .bind_net = 1, .bind_type = 1,
+};
+
+static const struct mctp_test_bind_setup bind_addrany_net1_type1 = {
+	.bind_addr = MCTP_ADDR_ANY, .bind_net = 1, .bind_type = 1,
+};
+
+/* 2 is an arbitrary net */
+static const struct mctp_test_bind_setup bind_addr8_net2_type1 = {
+	.bind_addr = 8, .bind_net = 2, .bind_type = 1,
+};
+
+static const struct mctp_test_bind_setup bind_addr8_netdefault_type1 = {
+	.bind_addr = 8, .bind_net = MCTP_NET_ANY, .bind_type = 1,
+};
+
+static const struct mctp_test_bind_setup bind_addrany_net2_type2 = {
+	.bind_addr = MCTP_ADDR_ANY, .bind_net = 2, .bind_type = 2,
+};
+
+struct mctp_bind_pair_test {
+	const struct mctp_test_bind_setup *bind1;
+	const struct mctp_test_bind_setup *bind2;
+	int error;
+};
+
+static const struct mctp_bind_pair_test mctp_bind_pair_tests[] = {
+	/* Both ADDR_ANY, conflict */
+	{ &bind_addrany_netdefault_type1, &bind_addrany_netdefault_type1,
+	  EADDRINUSE },
+	/* Same specific EID, conflict */
+	{ &bind_addr8_netdefault_type1, &bind_addr8_netdefault_type1,
+	  EADDRINUSE },
+	/* ADDR_ANY vs specific EID, OK */
+	{ &bind_addrany_netdefault_type1, &bind_addr8_netdefault_type1, 0 },
+	/* ADDR_ANY different types, OK */
+	{ &bind_addrany_net2_type2, &bind_addrany_net2_type1, 0 },
+	/* ADDR_ANY different nets, OK */
+	{ &bind_addrany_net2_type1, &bind_addrany_netdefault_type1, 0 },
+
+	/* specific EID, NET_ANY (resolves to default)
+	 *  vs specific EID, explicit default net 1, conflict
+	 */
+	{ &bind_addr8_netdefault_type1, &bind_addr8_net1_type1, EADDRINUSE },
+
+	/* specific EID, net 1 vs specific EID, net 2, ok */
+	{ &bind_addr8_net1_type1, &bind_addr8_net2_type1, 0 },
+
+	/* ANY_ADDR, NET_ANY (doesn't resolve to default)
+	 *  vs ADDR_ANY, explicit default net 1, OK
+	 */
+	{ &bind_addrany_netdefault_type1, &bind_addrany_net1_type1, 0 },
+};
+
+static void mctp_bind_pair_desc(const struct mctp_bind_pair_test *t, char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+		 "{bind(addr %d, type %d, net %d)} {bind(addr %d, type %d, net %d)} -> error %d",
+		 t->bind1->bind_addr, t->bind1->bind_type, t->bind1->bind_net,
+		 t->bind2->bind_addr, t->bind2->bind_type, t->bind2->bind_net,
+		 t->error);
+}
+
+KUNIT_ARRAY_PARAM(mctp_bind_pair, mctp_bind_pair_tests, mctp_bind_pair_desc);
+
+static void mctp_test_bind_run(struct kunit *test,
+			       const struct mctp_test_bind_setup *setup,
+			       int *ret_bind_errno, struct socket **sock)
+{
+	struct sockaddr_mctp addr;
+	int rc;
+
+	*ret_bind_errno = -EIO;
+
+	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, sock);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	memset(&addr, 0x0, sizeof(addr));
+	addr.smctp_family = AF_MCTP;
+	addr.smctp_network = setup->bind_net;
+	addr.smctp_addr.s_addr = setup->bind_addr;
+	addr.smctp_type = setup->bind_type;
+
+	*ret_bind_errno =
+		kernel_bind(*sock, (struct sockaddr *)&addr, sizeof(addr));
+}
+
+static int
+mctp_test_bind_conflicts_inner(struct kunit *test,
+			       const struct mctp_test_bind_setup *bind1,
+			       const struct mctp_test_bind_setup *bind2)
+{
+	struct socket *sock1 = NULL, *sock2 = NULL, *sock3 = NULL;
+	int bind_errno;
+
+	/* Bind to first address, always succeeds */
+	mctp_test_bind_run(test, bind1, &bind_errno, &sock1);
+	KUNIT_EXPECT_EQ(test, bind_errno, 0);
+
+	/* A second identical bind always fails */
+	mctp_test_bind_run(test, bind1, &bind_errno, &sock2);
+	KUNIT_EXPECT_EQ(test, -bind_errno, EADDRINUSE);
+
+	/* A different bind, result is returned */
+	mctp_test_bind_run(test, bind2, &bind_errno, &sock3);
+
+	if (sock1)
+		sock_release(sock1);
+	if (sock2)
+		sock_release(sock2);
+	if (sock3)
+		sock_release(sock3);
+
+	return bind_errno;
+}
+
+static void mctp_test_bind_conflicts(struct kunit *test)
+{
+	const struct mctp_bind_pair_test *pair;
+	int bind_errno;
+
+	pair = test->param_value;
+
+	bind_errno =
+		mctp_test_bind_conflicts_inner(test, pair->bind1, pair->bind2);
+	KUNIT_EXPECT_EQ(test, -bind_errno, pair->error);
+
+	/* swapping the calls, the second bind should still fail */
+	bind_errno =
+		mctp_test_bind_conflicts_inner(test, pair->bind2, pair->bind1);
+	KUNIT_EXPECT_EQ(test, -bind_errno, pair->error);
+}
+
+static void mctp_test_assumptions(struct kunit *test)
+{
+	/* check assumption of default net from bind_addr8_net1_type1 */
+	KUNIT_ASSERT_EQ(test, mctp_default_net(&init_net), 1);
+}
+
 static struct kunit_case mctp_test_cases[] = {
+	KUNIT_CASE(mctp_test_assumptions),
 	KUNIT_CASE_PARAM(mctp_test_fragment, mctp_frag_gen_params),
 	KUNIT_CASE_PARAM(mctp_test_rx_input, mctp_rx_input_gen_params),
 	KUNIT_CASE_PARAM(mctp_test_route_input_sk, mctp_route_input_sk_gen_params),
@@ -1253,7 +1409,9 @@ static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE(mctp_test_fragment_flow),
 	KUNIT_CASE(mctp_test_route_output_key_create),
 	KUNIT_CASE(mctp_test_route_input_cloned_frag),
-	{}
+	KUNIT_CASE_PARAM(mctp_test_bind_conflicts, mctp_bind_pair_gen_params),
+
+	{ /* terminator */ },
 };
 
 static struct kunit_suite mctp_test_suite = {

-- 
2.43.0



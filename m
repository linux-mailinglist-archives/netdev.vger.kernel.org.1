Return-Path: <netdev+bounces-205710-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AEEEAFFD02
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:57:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043CD1C86D25
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 08:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB46B28F958;
	Thu, 10 Jul 2025 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="GDWwXQo2"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5A728ECE8
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 08:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137773; cv=none; b=N79meQBU3hUe19gksU2v/+LfTcs/dlrfgYI3gTKfSd2f07ZE7rsaSG6jotuwhsWjZbbm4t0XlaziCs0/wq5z08dRXFKjZzDz4r5NJL5QEGG+aUoVmKfHDFvc5re4NRBTzLOglZTvFOp8HkD2vP6VXepaNOkMMyqzCXrO8llF+lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137773; c=relaxed/simple;
	bh=PkbKI6ZALLSVJc45dsK4mH6vqGL9J+A3AWRmAsNO9U8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uKbQjWUuUJSCbC3kAeXVQcpqFek6SQxBPbrmgXAqwivbywRC5dVQY1tPp3txY74hPRFV+PJq9DIqQvr0dqS/+ptatjDhk3OpBxUkB9OVLD5BYFzCfWEsORadfyRh5lCDWPaUQ0czp/UobnkNxf9A55Fz43oRFapn9t+jxa4D54Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=GDWwXQo2; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752137763;
	bh=WW9WCD072sKjlnvdx7saNey0nmiBiA/c0NjYDwuZb7E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=GDWwXQo2EqGVO8aCLhOV3ytdlzrvMNK78bfhhAmySbXybqF+rVZQan59PrJ+vrxMW
	 25o+pOf0ninE1LF8yPF+nKvPArePtOTsBsCYyNvt3oeQv3EsxeAwJcuVdxJJNN/hGv
	 JflwRYOXhhnMCx2CQFqY/UZGz3ylZP2SD9z3MeLAPxKHTUYs1dqwnpaaAn1T0tPBkm
	 SGNn3N1peIqkiE5LVni8vH/NNu2222dWuQpUBI4HeVkC9BjM9OLuvrXjMb2ly85Hu1
	 eMgwaBRm9NyYC1V3sppgPIKsXg0K/siDduX4qlRpQhTeSzmAHq3nWCPo9vp4YZoJpl
	 PgBTIQT36jMqw==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 8EEB06B23B; Thu, 10 Jul 2025 16:56:03 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Thu, 10 Jul 2025 16:55:57 +0800
Subject: [PATCH net-next v4 4/8] net: mctp: Add test for conflicting
 bind()s
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-mctp-bind-v4-4-8ec2f6460c56@codeconstruct.com.au>
References: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
In-Reply-To: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752137761; l=7375;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=PkbKI6ZALLSVJc45dsK4mH6vqGL9J+A3AWRmAsNO9U8=;
 b=y7ixs62mmR4a31wCervVJsyEbosEx46f6xCxCc00HAq6xQkhpvBMGfdYg6D3zY1TT2+Cpo0F2
 jPDzSAgK7NnAsJKnbCrqdzDO/tjjWaxev9jYlTx+BEVAbQgNsz7Xetp
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

Test pairwise combinations of bind addresses and types.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>

---
v3:
- Moved test code to mctp/test/sock-test.c recently added in
  net-next, common bind test code in mctp/test/utils.c
v2:
- Remove unused bind test case
- Fix line lengths
---
 net/mctp/test/sock-test.c | 130 ++++++++++++++++++++++++++++++++++++++++++++++
 net/mctp/test/utils.c     |  22 ++++++++
 net/mctp/test/utils.h     |  10 ++++
 3 files changed, 162 insertions(+)

diff --git a/net/mctp/test/sock-test.c b/net/mctp/test/sock-test.c
index 4eb3a724dca39eb22615cbfc1201b45ee4c78d16..0cfc337be687e7ad903023d2fae9f12f75628532 100644
--- a/net/mctp/test/sock-test.c
+++ b/net/mctp/test/sock-test.c
@@ -215,9 +215,139 @@ static void mctp_test_sock_recvmsg_extaddr(struct kunit *test)
 	__mctp_sock_test_fini(test, dev, rt, sock);
 }
 
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
+/* Pairs of binds and whether they will conflict */
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
 	KUNIT_CASE(mctp_test_sock_sendmsg_extaddr),
 	KUNIT_CASE(mctp_test_sock_recvmsg_extaddr),
+	KUNIT_CASE_PARAM(mctp_test_bind_conflicts, mctp_bind_pair_gen_params),
 	{}
 };
 
diff --git a/net/mctp/test/utils.c b/net/mctp/test/utils.c
index 01f5af416b814baf812b4352c513ffcdd9939cb2..c971e2c326f3564f95b3f693c450b3e6f3d9c594 100644
--- a/net/mctp/test/utils.c
+++ b/net/mctp/test/utils.c
@@ -258,3 +258,25 @@ struct sk_buff *__mctp_test_create_skb_data(const struct mctp_hdr *hdr,
 
 	return skb;
 }
+
+void mctp_test_bind_run(struct kunit *test,
+			const struct mctp_test_bind_setup *setup,
+			int *ret_bind_errno, struct socket **sock)
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
diff --git a/net/mctp/test/utils.h b/net/mctp/test/utils.h
index f10d1d9066ccde53bbaf471ea79b87b1d94cd755..7dd1a92ab770995db506c24dc805bb9e0839eeef 100644
--- a/net/mctp/test/utils.h
+++ b/net/mctp/test/utils.h
@@ -31,6 +31,12 @@ struct mctp_test_pktqueue {
 	struct sk_buff_head pkts;
 };
 
+struct mctp_test_bind_setup {
+	mctp_eid_t bind_addr;
+	int bind_net;
+	u8 bind_type;
+};
+
 struct mctp_test_dev *mctp_test_create_dev(void);
 struct mctp_test_dev *mctp_test_create_dev_lladdr(unsigned short lladdr_len,
 						  const unsigned char *lladdr);
@@ -61,4 +67,8 @@ struct sk_buff *__mctp_test_create_skb_data(const struct mctp_hdr *hdr,
 #define mctp_test_create_skb_data(h, d) \
 	__mctp_test_create_skb_data(h, d, sizeof(*d))
 
+void mctp_test_bind_run(struct kunit *test,
+			const struct mctp_test_bind_setup *setup,
+			int *ret_bind_errno, struct socket **sock);
+
 #endif /* __NET_MCTP_TEST_UTILS_H */

-- 
2.43.0



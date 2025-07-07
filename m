Return-Path: <netdev+bounces-204470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A06E6AFAB49
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 07:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7D017A739
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 05:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B581A2797AB;
	Mon,  7 Jul 2025 05:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="diGYtx6Q"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02BF27146F
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 05:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751867732; cv=none; b=S8k5WijTaxJHK7hxDMFbg94cnAo7em/CSwn/1CXe7vNlUMrlMKmCsfmgOQ5rNH4gT5c2dXGEUzz+d3OtThumKwR7np2yp0EqDdDG5w1L9xOH+dOZSW441SlDVBATjfZ80M+7dd3fWSvGedpjxVTXD8jnQk7XTOPTJZGCnUXomuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751867732; c=relaxed/simple;
	bh=7xfL1ekn+exXXecuLiCJAE1f2eore63ujEcWNBUqk6s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=BGMCP2kl4pBagv2V7U5cVAflwesB8yRZoaPkIJ5WY5ylVmO8Auw0+g9MhLym5vxrn8E8p/png8T7HlfRhFl/prB7U8WpyVAV3hm6DKLWo5Ae0RKJMklW59uwXSLK5EHBvSf1irRr35wKx2rZb2xNSXUCrpG3HPwoXKkyKRS/pY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=diGYtx6Q; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751867721;
	bh=UyETqOn7aowwFdN0/w3Eejf0xKgwP66p8fKNUayoepw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=diGYtx6Q+janxw23xLZX7ntA5ns7RuS9tfQ5x3lNaJ/TtzkiQ8o1uPHU+CLKX/O/n
	 uB56wnR0iYSVXQVoPxhn8ROzeu7YXDzzrdk2S1LFEyYWcEWK/ITuZBf2JtMk+9R/0R
	 tEZ/UL23xSo60KPQN21MpX5i1oNN9G/1etcYmFS/Ydq6DxvyJsFxCrvlN8E5JnUA7z
	 YVCbFe2D8sm6L05/uf5rqN1kPsnXBUSoxuV2ljQYLUmKpG3pkUXrRBeKF51u8Md6v7
	 YKyeUfHD2IQdK+A0Mf4sXDQ/fMhQAi3zeflCL6cbLlhsOWUlrS5BPkF/itARBrhzWD
	 MGY4480hpIPWQ==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 6C3A36AC8E; Mon,  7 Jul 2025 13:55:21 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Mon, 07 Jul 2025 13:55:20 +0800
Subject: [PATCH net-next v2 7/7] net: mctp: Add bind lookup test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250707-mctp-bind-v2-7-fbaed8c1fb4d@codeconstruct.com.au>
References: <20250707-mctp-bind-v2-0-fbaed8c1fb4d@codeconstruct.com.au>
In-Reply-To: <20250707-mctp-bind-v2-0-fbaed8c1fb4d@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1751867717; l=8970;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=7xfL1ekn+exXXecuLiCJAE1f2eore63ujEcWNBUqk6s=;
 b=Y8u/Jysa6aV297Ojs0YwXrmqCugK+mbreEJ6/Uo+EL+2buFqaGMYqtSSOG6FkiSklTsUbAXlM
 ascBMh9LC6lCN5ndU5YJJfRSpkmSq4mx8Dv6ax4NmACMn3mnf9jp9ND
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

Test the preference order of bound socket matches with a series of test
packets.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>
---
 net/mctp/test/route-test.c | 199 ++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 197 insertions(+), 2 deletions(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 394749defa242fe4339aa56825693dc62b482e7c..57f4210fbee9612ef63ee1f72a6e9e921d74ba5a 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -1245,6 +1245,9 @@ struct mctp_test_bind_setup {
 	bool have_peer;
 	mctp_eid_t peer_addr;
 	int peer_net;
+
+	/* optional name. Used for comparison in "lookup" tests */
+	const char *name;
 };
 
 static const struct mctp_test_bind_setup bind_addrany_netdefault_type1 = {
@@ -1386,11 +1389,17 @@ static void mctp_test_bind_invalid(struct kunit *test)
 	int rc;
 
 	/* bind() fails if the bind() vs connect() networks mismatch. */
-	const struct mctp_test_bind_setup bind_connect_net_mismatch = {
+	const struct mctp_test_bind_setup bind_connect_net_mismatch1 = {
 		.bind_addr = MCTP_ADDR_ANY, .bind_net = 1, .bind_type = 1,
 		.have_peer = true, .peer_addr = 9, .peer_net = 2,
 	};
-	mctp_test_bind_run(test, &bind_connect_net_mismatch, &rc, &sock);
+	const struct mctp_test_bind_setup bind_connect_net_mismatch5 = {
+		.bind_addr = MCTP_ADDR_ANY, .bind_net = 5, .bind_type = 1,
+		.have_peer = true, .peer_addr = 9, .peer_net = 2,
+	};
+
+	mctp_test_bind_run(test, &bind_connect_net_mismatch1, &rc, &sock);
+	mctp_test_bind_run(test, &bind_connect_net_mismatch5, &rc, &sock);
 	KUNIT_EXPECT_EQ(test, -rc, EINVAL);
 	sock_release(sock);
 }
@@ -1441,6 +1450,191 @@ static void mctp_test_bind_conflicts(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, -bind_errno, pair->error);
 }
 
+struct mctp_bind_lookup_test {
+	/* header of incoming message */
+	struct mctp_hdr hdr;
+	u8 ty;
+	/* mctp network of incoming interface (smctp_network) */
+	unsigned int net;
+
+	/* expected socket, matches .name in lookup_binds, NULL for dropped */
+	const char *expect;
+};
+
+/* Single-packet TO-set message */
+#define LK(src, dst) RX_HDR(1, (src), (dst), FL_S | FL_E | FL_TO)
+
+/* Input message test cases for bind lookup tests.
+ *
+ * 10 and 11 are local EIDs.
+ * 20 and 21 are remote EIDs.
+ */
+static const struct mctp_bind_lookup_test mctp_bind_lookup_tests[] = {
+	/* both local-eid and remote-eid binds, remote eid is preferenced */
+	{ .hdr = LK(20, 10),  .ty = 1, .net = 1, .expect = "remote20" },
+
+	{ .hdr = LK(20, 255), .ty = 1, .net = 1, .expect = "remote20" },
+	{ .hdr = LK(20, 0),   .ty = 1, .net = 1, .expect = "remote20" },
+	{ .hdr = LK(0, 255),  .ty = 1, .net = 1, .expect = "any" },
+	{ .hdr = LK(0, 11),   .ty = 1, .net = 1, .expect = "any" },
+	{ .hdr = LK(0, 0),    .ty = 1, .net = 1, .expect = "any" },
+	{ .hdr = LK(0, 10),   .ty = 1, .net = 1, .expect = "local10" },
+	{ .hdr = LK(21, 10),  .ty = 1, .net = 1, .expect = "local10" },
+	{ .hdr = LK(21, 11),  .ty = 1, .net = 1, .expect = "remote21local11" },
+
+	/* both src and dest set to eid=99. unusual, but accepted
+	 * by MCTP stack currently.
+	 */
+	{ .hdr = LK(99, 99),  .ty = 1, .net = 1, .expect = "any" },
+
+	/* unbound smctp_type */
+	{ .hdr = LK(20, 10),  .ty = 3, .net = 1, .expect = NULL },
+
+	/* smctp_network tests */
+
+	{ .hdr = LK(0, 0),    .ty = 1, .net = 7, .expect = "any" },
+	{ .hdr = LK(21, 10),  .ty = 1, .net = 2, .expect = "any" },
+
+	/* remote EID 20 matches, but MCTP_NET_ANY in "remote20" resolved
+	 * to net=1, so lookup doesn't match "remote20"
+	 */
+	{ .hdr = LK(20, 10),  .ty = 1, .net = 3, .expect = "any" },
+
+	{ .hdr = LK(21, 10),  .ty = 1, .net = 3, .expect = "remote21net3" },
+	{ .hdr = LK(21, 10),  .ty = 1, .net = 4, .expect = "remote21net4" },
+	{ .hdr = LK(21, 10),  .ty = 1, .net = 5, .expect = "remote21net5" },
+
+	{ .hdr = LK(21, 10),  .ty = 1, .net = 5, .expect = "remote21net5" },
+
+	{ .hdr = LK(99, 10),  .ty = 1, .net = 8, .expect = "local10net8" },
+
+	{ .hdr = LK(99, 10),  .ty = 1, .net = 9, .expect = "anynet9" },
+	{ .hdr = LK(0, 0),    .ty = 1, .net = 9, .expect = "anynet9" },
+	{ .hdr = LK(99, 99),  .ty = 1, .net = 9, .expect = "anynet9" },
+	{ .hdr = LK(20, 10),  .ty = 1, .net = 9, .expect = "anynet9" },
+};
+
+/* Binds to create during the lookup tests */
+static const struct mctp_test_bind_setup lookup_binds[] = {
+	/* any address and net, type 1 */
+	{ .name = "any", .bind_addr = MCTP_ADDR_ANY,
+		.bind_net = MCTP_NET_ANY, .bind_type = 1, },
+	/* local eid 10, net 1 (resolved from MCTP_NET_ANY) */
+	{ .name = "local10", .bind_addr = 10,
+		.bind_net = MCTP_NET_ANY, .bind_type = 1, },
+	/* local eid 10, net 8 */
+	{ .name = "local10net8", .bind_addr = 10,
+		.bind_net = 8, .bind_type = 1, },
+	/* any EID, net 9 */
+	{ .name = "anynet9", .bind_addr = MCTP_ADDR_ANY,
+		.bind_net = 9, .bind_type = 1, },
+
+	/* remote eid 20, net 1, any local eid */
+	{ .name = "remote20", .bind_addr = MCTP_ADDR_ANY,
+		.bind_net = MCTP_NET_ANY, .bind_type = 1,
+		.have_peer = true, .peer_addr = 20, .peer_net = MCTP_NET_ANY, },
+
+	/* remote eid 20, net 1, local eid 11 */
+	{ .name = "remote21local11", .bind_addr = 11,
+		.bind_net = MCTP_NET_ANY, .bind_type = 1,
+		.have_peer = true, .peer_addr = 21, .peer_net = MCTP_NET_ANY, },
+
+	/* remote eid 21, specific net=3 for connect() */
+	{ .name = "remote21net3", .bind_addr = MCTP_ADDR_ANY,
+		.bind_net = MCTP_NET_ANY, .bind_type = 1,
+		.have_peer = true, .peer_addr = 21, .peer_net = 3, },
+
+	/* remote eid 21, net 4 for bind, specific net=4 for connect() */
+	{ .name = "remote21net4", .bind_addr = MCTP_ADDR_ANY,
+		.bind_net = 4, .bind_type = 1,
+		.have_peer = true, .peer_addr = 21, .peer_net = 4, },
+
+	/* remote eid 21, net 5 for bind, specific net=5 for connect() */
+	{ .name = "remote21net5", .bind_addr = MCTP_ADDR_ANY,
+		.bind_net = 5, .bind_type = 1,
+		.have_peer = true, .peer_addr = 21, .peer_net = 5, },
+};
+
+static void mctp_bind_lookup_desc(const struct mctp_bind_lookup_test *t,
+				  char *desc)
+{
+	snprintf(desc, KUNIT_PARAM_DESC_SIZE,
+		 "{src %d dst %d ty %d net %d expect %s}",
+		 t->hdr.src, t->hdr.dest, t->ty, t->net, t->expect);
+}
+
+KUNIT_ARRAY_PARAM(mctp_bind_lookup, mctp_bind_lookup_tests,
+		  mctp_bind_lookup_desc);
+
+static void mctp_test_bind_lookup(struct kunit *test)
+{
+	const struct mctp_bind_lookup_test *rx;
+	struct socket *socks[ARRAY_SIZE(lookup_binds)];
+	struct sk_buff *skb_pkt = NULL, *skb_sock = NULL;
+	struct mctp_test_route *rt;
+	struct mctp_test_dev *dev;
+	struct socket *sock_ty0, *sock_expect = NULL;
+	int rc;
+
+	rx = test->param_value;
+
+	__mctp_route_test_init(test, &dev, &rt, &sock_ty0, rx->net);
+	/* Create all binds */
+	for (size_t i = 0; i < ARRAY_SIZE(lookup_binds); i++) {
+		mctp_test_bind_run(test, &lookup_binds[i],
+				   &rc, &socks[i]);
+		KUNIT_ASSERT_EQ(test, rc, 0);
+
+		/* Record the expected receive socket */
+		if (rx->expect &&
+		    strcmp(rx->expect, lookup_binds[i].name) == 0) {
+			KUNIT_ASSERT_NULL(test, sock_expect);
+			sock_expect = socks[i];
+		}
+	}
+	KUNIT_ASSERT_EQ(test, !!sock_expect, !!rx->expect);
+
+	/* Create test message */
+	skb_pkt = mctp_test_create_skb_data(&rx->hdr, &rx->ty);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb_pkt);
+	mctp_test_skb_set_dev(skb_pkt, dev);
+
+	rc = mctp_route_input(&rt->rt, skb_pkt);
+	if (rx->expect) {
+		/* Test the message is received on the expected socket */
+		KUNIT_EXPECT_EQ(test, rc, 0);
+		skb_sock = skb_recv_datagram(sock_expect->sk,
+					     MSG_DONTWAIT, &rc);
+		if (!skb_sock) {
+			/* Find which socket received it instead */
+			for (size_t i = 0; i < ARRAY_SIZE(lookup_binds); i++) {
+				skb_sock = skb_recv_datagram(socks[i]->sk,
+							     MSG_DONTWAIT, &rc);
+				if (skb_sock) {
+					KUNIT_FAIL(test,
+						   "received on incorrect socket '%s', expect '%s'",
+						   lookup_binds[i].name,
+						   rx->expect);
+					goto cleanup;
+				}
+			}
+			KUNIT_FAIL(test, "no message received");
+		}
+	} else {
+		KUNIT_EXPECT_NE(test, rc, 0);
+	}
+
+cleanup:
+	kfree_skb(skb_sock);
+	kfree_skb(skb_pkt);
+
+	/* Drop all binds */
+	for (size_t i = 0; i < ARRAY_SIZE(lookup_binds); i++)
+		sock_release(socks[i]);
+
+	__mctp_route_test_fini(test, dev, rt, sock_ty0);
+}
+
 static void mctp_test_assumptions(struct kunit *test)
 {
 	/* check assumption of default net from bind_addr8_net1_type1 */
@@ -1466,6 +1660,7 @@ static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE(mctp_test_route_input_cloned_frag),
 	KUNIT_CASE_PARAM(mctp_test_bind_conflicts, mctp_bind_pair_gen_params),
 	KUNIT_CASE(mctp_test_bind_invalid),
+	KUNIT_CASE_PARAM(mctp_test_bind_lookup, mctp_bind_lookup_gen_params),
 
 	{ /* terminator */ },
 };

-- 
2.43.0



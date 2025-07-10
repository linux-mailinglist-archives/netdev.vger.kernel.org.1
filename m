Return-Path: <netdev+bounces-205713-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EE0D0AFFD04
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 10:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCFEC3AE081
	for <lists+netdev@lfdr.de>; Thu, 10 Jul 2025 08:56:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51746291C1C;
	Thu, 10 Jul 2025 08:56:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="V+zLeg4l"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17529291C0C
	for <netdev@vger.kernel.org>; Thu, 10 Jul 2025 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752137776; cv=none; b=kgY/Wq90fO6IinVh/Rfq+n1IHUw5uiymjaVaLyUcjtnEDkXZIw+T8jKQHK8hQYRDyRG/0PCnCUz/bvjzWaIgpf0SpVAyXc2xl4PpP4/32Kzr/a43REkfzarP/Zfj+BBoI9Fsm3L+WEavGlMUg4J0QgIuzPTkcmXTh1ImXgL/GHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752137776; c=relaxed/simple;
	bh=wkTX24QUeGjoDBX6IuLL7fb1Jrrycfyelw3mkC6fqSw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ioNSiT5RZC7N94jcpSjji6Qsfciu4I0eKbM+SucqDIJAo5CtGSDnYogFdZXkJr5/w+fg4b5J8Zt8zafxfEMgWmVLzAi8RTmWB7j9IqfyU1xbAIBkpS6glC2tZqd1VaJb3ko+5bPxClOc9wZDHRZ3T6osLnOcnfvRooGfdxPFSA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=V+zLeg4l; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1752137765;
	bh=BGc/mGri4LQHmsAQ9MPdTKgLHOxlZHBdUFSasVdGhRc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=V+zLeg4lBi+fvUVA4Hg0vZM1JNHVdXYoilbbDk2DESp23yBYAibNzPN8iCjjCc9Ee
	 ptLQvzpTpXZ0y3MpUyD8w+G8IdhmkpPBhFEaHmxA+ySms667+whPxcCFaHNuDZ1oBz
	 guM+gx/YPHfj6TjEYP3crfEK12scnIQknwwPW4IAqXNJcdtEkVq77m88p1bQifhJhF
	 /YmQk/1NRKiwnZQeqPRTtXzNFE7GrAjnzk2OjIPj8DcZDra49H8Aflt57yu5P0JcUy
	 qQyG2hpk8E0xWxV0z7FADZQEcRTKXaLylUfubVjO11xjFA30axTdONZpUaXvCAXtFC
	 8nWnO7pM+LX4A==
Received: by codeconstruct.com.au (Postfix, from userid 10001)
	id 29E336B24A; Thu, 10 Jul 2025 16:56:05 +0800 (AWST)
From: Matt Johnston <matt@codeconstruct.com.au>
Date: Thu, 10 Jul 2025 16:56:01 +0800
Subject: [PATCH net-next v4 8/8] net: mctp: Add bind lookup test
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250710-mctp-bind-v4-8-8ec2f6460c56@codeconstruct.com.au>
References: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
In-Reply-To: <20250710-mctp-bind-v4-0-8ec2f6460c56@codeconstruct.com.au>
To: Jeremy Kerr <jk@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, Matt Johnston <matt@codeconstruct.com.au>
X-Mailer: b4 0.15-dev-cbbb4
X-Developer-Signature: v=1; a=ed25519-sha256; t=1752137761; l=8413;
 i=matt@codeconstruct.com.au; s=20241018; h=from:subject:message-id;
 bh=wkTX24QUeGjoDBX6IuLL7fb1Jrrycfyelw3mkC6fqSw=;
 b=dsDgHssW9Pucpl7fim+GztBjHkeSpRKXreuJSOFZ2U5hMMj6L9Et9jtLqm7/GvIZVRe59cgM2
 MSfsdPNfvzVCwqIalOOUqwUD/iXg+1sww3YnKmHYdqAbRiLToBkQaoP
X-Developer-Key: i=matt@codeconstruct.com.au; a=ed25519;
 pk=exersTcCYD/pEBOzXGO6HkLd6kKXRuWxHhj+LXn3DYE=

Test the preference order of bound socket matches with a series of test
packets.

Signed-off-by: Matt Johnston <matt@codeconstruct.com.au>

---
v3:
- Updated test code for changes from net-next
---
 net/mctp/test/route-test.c | 188 +++++++++++++++++++++++++++++++++++++++++++++
 net/mctp/test/utils.h      |   3 +
 2 files changed, 191 insertions(+)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 12811032a2696167b4f319cbc9c81fef4cb2d951..fb6b46a952cb432163f6adb40bb395d658745efd 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -1408,6 +1408,193 @@ static void mctp_test_route_gw_output(struct kunit *test)
 	kfree_skb(skb);
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
+	struct socket *sock_ty0, *sock_expect = NULL;
+	struct mctp_test_pktqueue tpq;
+	struct mctp_test_dev *dev;
+	struct mctp_dst dst;
+	int rc;
+
+	rx = test->param_value;
+
+	__mctp_route_test_init(test, &dev, &dst, &tpq, &sock_ty0, rx->net);
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
+	mctp_test_pktqueue_init(&tpq);
+
+	rc = mctp_dst_input(&dst, skb_pkt);
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
+	__mctp_route_test_fini(test, dev, &dst, &tpq, sock_ty0);
+}
+
 static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE_PARAM(mctp_test_fragment, mctp_frag_gen_params),
 	KUNIT_CASE_PARAM(mctp_test_rx_input, mctp_rx_input_gen_params),
@@ -1429,6 +1616,7 @@ static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE(mctp_test_route_gw_loop),
 	KUNIT_CASE_PARAM(mctp_test_route_gw_mtu, mctp_route_gw_mtu_gen_params),
 	KUNIT_CASE(mctp_test_route_gw_output),
+	KUNIT_CASE_PARAM(mctp_test_bind_lookup, mctp_bind_lookup_gen_params),
 	{}
 };
 
diff --git a/net/mctp/test/utils.h b/net/mctp/test/utils.h
index c2aaba5188ab82237cb3bcc00d5abf1942753b9d..06bdb6cb5eff6560c7378cf37a1bb17757938e82 100644
--- a/net/mctp/test/utils.h
+++ b/net/mctp/test/utils.h
@@ -39,6 +39,9 @@ struct mctp_test_bind_setup {
 	bool have_peer;
 	mctp_eid_t peer_addr;
 	int peer_net;
+
+	/* optional name. Used for comparison in "lookup" tests */
+	const char *name;
 };
 
 struct mctp_test_dev *mctp_test_create_dev(void);

-- 
2.43.0



Return-Path: <netdev+bounces-72300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3020F857790
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 09:24:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A4EF2282F3E
	for <lists+netdev@lfdr.de>; Fri, 16 Feb 2024 08:24:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 098B51CD08;
	Fri, 16 Feb 2024 08:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="LKmUozUy"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0942A1CAB0
	for <netdev@vger.kernel.org>; Fri, 16 Feb 2024 08:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708071585; cv=none; b=cPXycD65UdvGDZjrLi1y8iWjWAGTEZ0HzieM2Fmp8Z4KZDPT9pd59fChKuyvnPTr58yEWuCesUSQxlhQT2pfJ9Ol7iN+rcjQII0QdT4glNB0NM1tbyICHb3iUNT3OwRD+jALf/oCk+/5rvRrTew47tXLnT6i1V0wyJZgdcc4UDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708071585; c=relaxed/simple;
	bh=QJATI2aguwiqmQgeQRcxkCRvta6IKiFVqVcnKawZDvA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gA+RDIHq/VdQoZsqum79h0Kf6hUTgRquat5PeiPgXEH0ONSFhuirvRx7FqQvZDdWf/5Ftcx1HDqbWt8TWcItUpAnYPyAD64hzOhPPBSEbI5bJT9KFXWjVa7JFgLdAIa4m9Cc7RqWpUXknFJV/uvmH0rQ+Qr+0CFTxSQTOM/KMyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=LKmUozUy; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 413C12048E; Fri, 16 Feb 2024 16:19:35 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708071575;
	bh=wLWDGLjQuTWJ0HUsskA3jUwi+Wayb/9Q6TO+Ons7whI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LKmUozUycj0ji+u1O5ipajQo7EAOsRgmgWg6KSTS0y2cjOpBjlIdrBslfepxGzt97
	 v1UO1knhQZELtwaKkzPwMHZOCOOkyezdKpm1BYfZRcEybQpsR2X1/Pgg71gD2ORUYE
	 6tcpuWOLu12GJbjcS71XawgVgCUJ2YQU5ZcpbmicFI6Ex5rbJNyBWYmdvAn6QGoTzQ
	 goieQSeY3E1Ew9mWYIpJ3d0d6IayeTsxDiVxV0UeH5kD6httBU93VjpkJvaqQ5i1Cq
	 9tJopebcZvlfbnvW7J0ETE+Z/yxXfMI6ZRB0bvtRgyfVT2QWZCERUjb2bMQ4AMkdlu
	 Nq2Z6KAE0GzHw==
From: Jeremy Kerr <jk@codeconstruct.com.au>
To: netdev@vger.kernel.org
Cc: Matt Johnston <matt@codeconstruct.com.au>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Howells <dhowells@redhat.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Liang Chen <liangchen.linux@gmail.com>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH net-next 10/11] net: mctp: tests: Test that outgoing skbs have flow data populated
Date: Fri, 16 Feb 2024 16:19:20 +0800
Message-Id: <73b3194049ea75649cc22c17f7d11fa6f9487894.1708071380.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708071380.git.jk@codeconstruct.com.au>
References: <cover.1708071380.git.jk@codeconstruct.com.au>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When CONFIG_MCTP_FLOWS is enabled, outgoing skbs should have their
SKB_EXT_MCTP extension set for drivers to consume.

Add two tests for local-to-output routing that check for the flow
extensions: one for the simple single-packet case, and one for
fragmentation.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/test/route-test.c | 136 +++++++++++++++++++++++++++++++++++++
 1 file changed, 136 insertions(+)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index bad084525f17..eb7e9ac95612 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -837,6 +837,140 @@ static void mctp_test_route_input_multiple_nets_key(struct kunit *test)
 	mctp_test_route_input_multiple_nets_key_fini(test, &t2);
 }
 
+#if IS_ENABLED(CONFIG_MCTP_FLOWS)
+
+static void mctp_test_flow_init(struct kunit *test,
+				struct mctp_test_dev **devp,
+				struct mctp_test_route **rtp,
+				struct socket **sock,
+				struct sk_buff **skbp,
+				unsigned int len)
+{
+	struct mctp_test_route *rt;
+	struct mctp_test_dev *dev;
+	struct sk_buff *skb;
+
+	/* we have a slightly odd routing setup here; the test route
+	 * is for EID 8, which is our local EID. We don't do a routing
+	 * lookup, so that's fine - all we require is a path through
+	 * mctp_local_output, which will call rt->output on whatever
+	 * route we provide
+	 */
+	__mctp_route_test_init(test, &dev, &rt, sock, MCTP_NET_ANY);
+
+	/* Assign a single EID. ->addrs is freed on mctp netdev release */
+	dev->mdev->addrs = kmalloc(sizeof(u8), GFP_KERNEL);
+	dev->mdev->num_addrs = 1;
+	dev->mdev->addrs[0] = 8;
+
+	skb = alloc_skb(len + sizeof(struct mctp_hdr) + 1, GFP_KERNEL);
+	KUNIT_ASSERT_TRUE(test, skb);
+	__mctp_cb(skb);
+	skb_reserve(skb, sizeof(struct mctp_hdr) + 1);
+	memset(skb_put(skb, len), 0, len);
+
+	/* take a ref for the route, we'll decrement in local output */
+	refcount_inc(&rt->rt.refs);
+
+	*devp = dev;
+	*rtp = rt;
+	*skbp = skb;
+}
+
+static void mctp_test_flow_fini(struct kunit *test,
+				struct mctp_test_dev *dev,
+				struct mctp_test_route *rt,
+				struct socket *sock)
+{
+	__mctp_route_test_fini(test, dev, rt, sock);
+}
+
+/* test that an outgoing skb has the correct MCTP extension data set */
+static void mctp_test_packet_flow(struct kunit *test)
+{
+	struct sk_buff *skb, *skb2;
+	struct mctp_test_route *rt;
+	struct mctp_test_dev *dev;
+	struct mctp_flow *flow;
+	struct socket *sock;
+	u8 dst = 8;
+	int n, rc;
+
+	mctp_test_flow_init(test, &dev, &rt, &sock, &skb, 30);
+
+	rc = mctp_local_output(sock->sk, &rt->rt, skb, dst, MCTP_TAG_OWNER);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	n = rt->pkts.qlen;
+	KUNIT_ASSERT_EQ(test, n, 1);
+
+	skb2 = skb_dequeue(&rt->pkts);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb2);
+
+	flow = skb_ext_find(skb2, SKB_EXT_MCTP);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, flow);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, flow->key);
+	KUNIT_ASSERT_PTR_EQ(test, flow->key->sk, sock->sk);
+
+	kfree_skb(skb2);
+	mctp_test_flow_fini(test, dev, rt, sock);
+}
+
+/* test that outgoing skbs, after fragmentation, all have the correct MCTP
+ * extension data set.
+ */
+static void mctp_test_fragment_flow(struct kunit *test)
+{
+	struct mctp_flow *flows[2];
+	struct sk_buff *tx_skbs[2];
+	struct mctp_test_route *rt;
+	struct mctp_test_dev *dev;
+	struct sk_buff *skb;
+	struct socket *sock;
+	u8 dst = 8;
+	int n, rc;
+
+	mctp_test_flow_init(test, &dev, &rt, &sock, &skb, 100);
+
+	rc = mctp_local_output(sock->sk, &rt->rt, skb, dst, MCTP_TAG_OWNER);
+	KUNIT_ASSERT_EQ(test, rc, 0);
+
+	n = rt->pkts.qlen;
+	KUNIT_ASSERT_EQ(test, n, 2);
+
+	/* both resulting packets should have the same flow data */
+	tx_skbs[0] = skb_dequeue(&rt->pkts);
+	tx_skbs[1] = skb_dequeue(&rt->pkts);
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tx_skbs[0]);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tx_skbs[1]);
+
+	flows[0] = skb_ext_find(tx_skbs[0], SKB_EXT_MCTP);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, flows[0]);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, flows[0]->key);
+	KUNIT_ASSERT_PTR_EQ(test, flows[0]->key->sk, sock->sk);
+
+	flows[1] = skb_ext_find(tx_skbs[1], SKB_EXT_MCTP);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, flows[1]);
+	KUNIT_ASSERT_PTR_EQ(test, flows[1]->key, flows[0]->key);
+
+	kfree_skb(tx_skbs[0]);
+	kfree_skb(tx_skbs[1]);
+	mctp_test_flow_fini(test, dev, rt, sock);
+}
+
+#else
+static void mctp_test_packet_flow(struct kunit *test)
+{
+	kunit_skip(test, "Requires CONFIG_MCTP_FLOWS=y");
+}
+
+static void mctp_test_fragment_flow(struct kunit *test)
+{
+	kunit_skip(test, "Requires CONFIG_MCTP_FLOWS=y");
+}
+#endif
+
 static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE_PARAM(mctp_test_fragment, mctp_frag_gen_params),
 	KUNIT_CASE_PARAM(mctp_test_rx_input, mctp_rx_input_gen_params),
@@ -847,6 +981,8 @@ static struct kunit_case mctp_test_cases[] = {
 			 mctp_route_input_sk_keys_gen_params),
 	KUNIT_CASE(mctp_test_route_input_multiple_nets_bind),
 	KUNIT_CASE(mctp_test_route_input_multiple_nets_key),
+	KUNIT_CASE(mctp_test_packet_flow),
+	KUNIT_CASE(mctp_test_fragment_flow),
 	{}
 };
 
-- 
2.39.2



Return-Path: <netdev+bounces-241820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 110FFC88BC8
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 09:49:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A693634E332
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 08:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A8CF31A7F0;
	Wed, 26 Nov 2025 08:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="SwRlDBwf"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D3452D5C6C
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 08:49:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764146960; cv=none; b=pKqRiLxYV6PDYuxg63RRZzaMPKKVs8tdzgGplcUV8q7kub0XSSvvRG3k6EIYgPdfn9kLbj/d8WXFyeL0hGaKN3hgLg3KpzeUzZdS5yBGWCOWDz+5HYRZmjiRXwaB7RHAjSdRWnRsHi7NPjFogMhfj8oF0fS4bEnw+wxTuv29cyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764146960; c=relaxed/simple;
	bh=zBqK41wyKDv8b3lZbe/Ebk5TUJ+d5E5hVGajhcWpDpA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qQE78Qc53U/naaKCQV8ZhtttI3rvP//H8VeA17bqb9nngixQPa8+AiEvv6ZNopicrDlpknv4hvwPlkw1GimBKE/+MCu+N+vfgWwbmZ0IFk/MbBjgzVbJlkjueqk8R/mEiEsXg0S5KsEGJFbkaVhe3kB6hESllRSxL0YPNIoCPUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=SwRlDBwf; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1764146948;
	bh=Fo5zMVZAM82pIM8zU3OC22wGvn+CPnYJKtxNdTu2dHE=;
	h=From:Date:Subject:To:Cc;
	b=SwRlDBwf/SvE2VeBZwBHTActDDqfd/5GJk4/4s/QHhu27saqW6vUcAR2QGxLg5mPO
	 n705PUsJ6D3dOOBSL8BWMEJ/v+Ex6EaNwBmdgd5IN2XV5g63rVomeKV7ybIYTbUVC2
	 RXyZdOsnJ1ewWtnZZVAauBKnq2H+NE9asLQWCwUD0CsTfVq6iggBgVmg5q9Ufv9+bk
	 c24lZFDNg8YnXOw0m/jRl8Mj7AJ8YWH9ubMgTJs7xgcfE3IF6s9w65sV/eIpMAEvsM
	 kHpFuvgwiMdidpei+ExYz4OxgOfTadqHVNKKgIGc8AlqiwyQMiQW3IQvk5F/0i/oki
	 iTpYNctI0Q1qg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id E7F5B7BF64; Wed, 26 Nov 2025 16:49:08 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 26 Nov 2025 16:48:54 +0800
Subject: [PATCH net-next v2] net: mctp: test: move TX packetqueue from dst
 to dev
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251126-dev-mctp-test-tx-queue-v2-1-4e5bbd1d6c57@codeconstruct.com.au>
X-B4-Tracking: v=1; b=H4sIAPW+JmkC/3WNQQ6DIBBFr2Jm3TEFtYld9R6NC4SxshAsDMTGe
 PcS022XLy///R0iBUsR7tUOgbKN1rsC8lKBnpV7EVpTGORVdkLIFg1lXDSvyBQZecN3okTYjp0
 R3Sgn3dygjNdAk93O8BMcMTraGIZiZhvZh8/5mMXpf/HuXzwLFNgoYZRqqe9JPLQ3pL2LHJLmW
 vulVgmG4zi+/iB86tEAAAA=
X-Change-ID: 20251124-dev-mctp-test-tx-queue-4b5d15b2fc36
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

To capture TX packets during a test, we are currently intercepting the
dst->output with an implementation that adds the transmitted packet to
a skb queue attached to the test-specific mock dst. The netdev itself is
not involved in the test TX path.

Instead, we can just use our test device to stash TXed packets for later
inspection by the test. This means we can include the actual
mctp_dst_output() implementation in the test (by setting dst.output in
the test case), and don't need to be creating fake dst objects, or their
corresponding skb queues.

We need to ensure that the netdev is up to allow delivery to
ndo_start_xmit, but the tests assume active devices at present anyway.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
Changes in v2:
- also remove now-unused pktqueue_magic const
- Link to v1: https://lore.kernel.org/r/20251125-dev-mctp-test-tx-queue-v1-1-3a1daa4e99e1@codeconstruct.com.au
---
 net/mctp/test/route-test.c | 109 +++++++++++++++++----------------------------
 net/mctp/test/utils.c      |  45 +++++++------------
 net/mctp/test/utils.h      |  13 ++----
 3 files changed, 59 insertions(+), 108 deletions(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index be9149ac79dd28dbe9a191702400fcb1ca0b4185..75ea96c10e497e73b55e20a30934679b7e24fdeb 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -20,7 +20,6 @@ struct mctp_frag_test {
 static void mctp_test_fragment(struct kunit *test)
 {
 	const struct mctp_frag_test *params;
-	struct mctp_test_pktqueue tpq;
 	int rc, i, n, mtu, msgsize;
 	struct mctp_test_dev *dev;
 	struct mctp_dst dst;
@@ -43,13 +42,12 @@ static void mctp_test_fragment(struct kunit *test)
 	dev = mctp_test_create_dev();
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
-	mctp_test_dst_setup(test, &dst, dev, &tpq, mtu);
+	mctp_test_dst_setup(test, &dst, dev, mtu);
 
 	rc = mctp_do_fragment_route(&dst, skb, mtu, MCTP_TAG_OWNER);
 	KUNIT_EXPECT_FALSE(test, rc);
 
-	n = tpq.pkts.qlen;
-
+	n = dev->pkts.qlen;
 	KUNIT_EXPECT_EQ(test, n, params->n_frags);
 
 	for (i = 0;; i++) {
@@ -61,8 +59,7 @@ static void mctp_test_fragment(struct kunit *test)
 		first = i == 0;
 		last = i == (n - 1);
 
-		skb2 = skb_dequeue(&tpq.pkts);
-
+		skb2 = skb_dequeue(&dev->pkts);
 		if (!skb2)
 			break;
 
@@ -99,7 +96,7 @@ static void mctp_test_fragment(struct kunit *test)
 		kfree_skb(skb2);
 	}
 
-	mctp_test_dst_release(&dst, &tpq);
+	mctp_dst_release(&dst);
 	mctp_test_destroy_dev(dev);
 }
 
@@ -130,13 +127,11 @@ struct mctp_rx_input_test {
 static void mctp_test_rx_input(struct kunit *test)
 {
 	const struct mctp_rx_input_test *params;
-	struct mctp_test_pktqueue tpq;
 	struct mctp_test_route *rt;
 	struct mctp_test_dev *dev;
 	struct sk_buff *skb;
 
 	params = test->param_value;
-	test->priv = &tpq;
 
 	dev = mctp_test_create_dev();
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
@@ -147,13 +142,10 @@ static void mctp_test_rx_input(struct kunit *test)
 	skb = mctp_test_create_skb(&params->hdr, 1);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
 
-	mctp_test_pktqueue_init(&tpq);
-
 	mctp_pkttype_receive(skb, dev->ndev, &mctp_packet_type, NULL);
 
-	KUNIT_EXPECT_EQ(test, !!tpq.pkts.qlen, params->input);
+	KUNIT_EXPECT_EQ(test, !!dev->pkts.qlen, params->input);
 
-	skb_queue_purge(&tpq.pkts);
 	mctp_test_route_destroy(test, rt);
 	mctp_test_destroy_dev(dev);
 }
@@ -182,7 +174,6 @@ KUNIT_ARRAY_PARAM(mctp_rx_input, mctp_rx_input_tests,
 static void __mctp_route_test_init(struct kunit *test,
 				   struct mctp_test_dev **devp,
 				   struct mctp_dst *dst,
-				   struct mctp_test_pktqueue *tpq,
 				   struct socket **sockp,
 				   unsigned int netid)
 {
@@ -196,7 +187,7 @@ static void __mctp_route_test_init(struct kunit *test,
 	if (netid != MCTP_NET_ANY)
 		WRITE_ONCE(dev->mdev->net, netid);
 
-	mctp_test_dst_setup(test, dst, dev, tpq, 68);
+	mctp_test_dst_setup(test, dst, dev, 68);
 
 	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
 	KUNIT_ASSERT_EQ(test, rc, 0);
@@ -215,11 +206,10 @@ static void __mctp_route_test_init(struct kunit *test,
 static void __mctp_route_test_fini(struct kunit *test,
 				   struct mctp_test_dev *dev,
 				   struct mctp_dst *dst,
-				   struct mctp_test_pktqueue *tpq,
 				   struct socket *sock)
 {
 	sock_release(sock);
-	mctp_test_dst_release(dst, tpq);
+	mctp_dst_release(dst);
 	mctp_test_destroy_dev(dev);
 }
 
@@ -232,7 +222,6 @@ struct mctp_route_input_sk_test {
 static void mctp_test_route_input_sk(struct kunit *test)
 {
 	const struct mctp_route_input_sk_test *params;
-	struct mctp_test_pktqueue tpq;
 	struct sk_buff *skb, *skb2;
 	struct mctp_test_dev *dev;
 	struct mctp_dst dst;
@@ -241,13 +230,12 @@ static void mctp_test_route_input_sk(struct kunit *test)
 
 	params = test->param_value;
 
-	__mctp_route_test_init(test, &dev, &dst, &tpq, &sock, MCTP_NET_ANY);
+	__mctp_route_test_init(test, &dev, &dst, &sock, MCTP_NET_ANY);
 
 	skb = mctp_test_create_skb_data(&params->hdr, &params->type);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
 
 	mctp_test_skb_set_dev(skb, dev);
-	mctp_test_pktqueue_init(&tpq);
 
 	rc = mctp_dst_input(&dst, skb);
 
@@ -266,7 +254,7 @@ static void mctp_test_route_input_sk(struct kunit *test)
 		KUNIT_EXPECT_NULL(test, skb2);
 	}
 
-	__mctp_route_test_fini(test, dev, &dst, &tpq, sock);
+	__mctp_route_test_fini(test, dev, &dst, sock);
 }
 
 #define FL_S	(MCTP_HDR_FLAG_SOM)
@@ -303,7 +291,6 @@ struct mctp_route_input_sk_reasm_test {
 static void mctp_test_route_input_sk_reasm(struct kunit *test)
 {
 	const struct mctp_route_input_sk_reasm_test *params;
-	struct mctp_test_pktqueue tpq;
 	struct sk_buff *skb, *skb2;
 	struct mctp_test_dev *dev;
 	struct mctp_dst dst;
@@ -313,7 +300,7 @@ static void mctp_test_route_input_sk_reasm(struct kunit *test)
 
 	params = test->param_value;
 
-	__mctp_route_test_init(test, &dev, &dst, &tpq, &sock, MCTP_NET_ANY);
+	__mctp_route_test_init(test, &dev, &dst, &sock, MCTP_NET_ANY);
 
 	for (i = 0; i < params->n_hdrs; i++) {
 		c = i;
@@ -336,7 +323,7 @@ static void mctp_test_route_input_sk_reasm(struct kunit *test)
 		KUNIT_EXPECT_NULL(test, skb2);
 	}
 
-	__mctp_route_test_fini(test, dev, &dst, &tpq, sock);
+	__mctp_route_test_fini(test, dev, &dst, sock);
 }
 
 #define RX_FRAG(f, s) RX_HDR(1, 10, 8, FL_TO | (f) | ((s) << MCTP_HDR_SEQ_SHIFT))
@@ -438,7 +425,6 @@ struct mctp_route_input_sk_keys_test {
 static void mctp_test_route_input_sk_keys(struct kunit *test)
 {
 	const struct mctp_route_input_sk_keys_test *params;
-	struct mctp_test_pktqueue tpq;
 	struct sk_buff *skb, *skb2;
 	struct mctp_test_dev *dev;
 	struct mctp_sk_key *key;
@@ -457,7 +443,7 @@ static void mctp_test_route_input_sk_keys(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 	net = READ_ONCE(dev->mdev->net);
 
-	mctp_test_dst_setup(test, &dst, dev, &tpq, 68);
+	mctp_test_dst_setup(test, &dst, dev, 68);
 
 	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
 	KUNIT_ASSERT_EQ(test, rc, 0);
@@ -497,7 +483,7 @@ static void mctp_test_route_input_sk_keys(struct kunit *test)
 		skb_free_datagram(sock->sk, skb2);
 
 	mctp_key_unref(key);
-	__mctp_route_test_fini(test, dev, &dst, &tpq, sock);
+	__mctp_route_test_fini(test, dev, &dst, sock);
 }
 
 static const struct mctp_route_input_sk_keys_test mctp_route_input_sk_keys_tests[] = {
@@ -572,7 +558,6 @@ KUNIT_ARRAY_PARAM(mctp_route_input_sk_keys, mctp_route_input_sk_keys_tests,
 struct test_net {
 	unsigned int netid;
 	struct mctp_test_dev *dev;
-	struct mctp_test_pktqueue tpq;
 	struct mctp_dst dst;
 	struct socket *sock;
 	struct sk_buff *skb;
@@ -591,20 +576,18 @@ mctp_test_route_input_multiple_nets_bind_init(struct kunit *test,
 
 	t->msg.data = t->netid;
 
-	__mctp_route_test_init(test, &t->dev, &t->dst, &t->tpq, &t->sock,
-			       t->netid);
+	__mctp_route_test_init(test, &t->dev, &t->dst, &t->sock, t->netid);
 
 	t->skb = mctp_test_create_skb_data(&hdr, &t->msg);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, t->skb);
 	mctp_test_skb_set_dev(t->skb, t->dev);
-	mctp_test_pktqueue_init(&t->tpq);
 }
 
 static void
 mctp_test_route_input_multiple_nets_bind_fini(struct kunit *test,
 					      struct test_net *t)
 {
-	__mctp_route_test_fini(test, t->dev, &t->dst, &t->tpq, t->sock);
+	__mctp_route_test_fini(test, t->dev, &t->dst, t->sock);
 }
 
 /* Test that skbs from different nets (otherwise identical) get routed to their
@@ -661,8 +644,7 @@ mctp_test_route_input_multiple_nets_key_init(struct kunit *test,
 
 	t->msg.data = t->netid;
 
-	__mctp_route_test_init(test, &t->dev, &t->dst, &t->tpq, &t->sock,
-			       t->netid);
+	__mctp_route_test_init(test, &t->dev, &t->dst, &t->sock, t->netid);
 
 	msk = container_of(t->sock->sk, struct mctp_sock, sk);
 
@@ -685,7 +667,7 @@ mctp_test_route_input_multiple_nets_key_fini(struct kunit *test,
 					     struct test_net *t)
 {
 	mctp_key_unref(t->key);
-	__mctp_route_test_fini(test, t->dev, &t->dst, &t->tpq, t->sock);
+	__mctp_route_test_fini(test, t->dev, &t->dst, t->sock);
 }
 
 /* test that skbs from different nets (otherwise identical) get routed to their
@@ -738,14 +720,13 @@ static void mctp_test_route_input_multiple_nets_key(struct kunit *test)
 static void mctp_test_route_input_sk_fail_single(struct kunit *test)
 {
 	const struct mctp_hdr hdr = RX_HDR(1, 10, 8, FL_S | FL_E | FL_TO);
-	struct mctp_test_pktqueue tpq;
 	struct mctp_test_dev *dev;
 	struct mctp_dst dst;
 	struct socket *sock;
 	struct sk_buff *skb;
 	int rc;
 
-	__mctp_route_test_init(test, &dev, &dst, &tpq, &sock, MCTP_NET_ANY);
+	__mctp_route_test_init(test, &dev, &dst, &sock, MCTP_NET_ANY);
 
 	/* No rcvbuf space, so delivery should fail. __sock_set_rcvbuf will
 	 * clamp the minimum to SOCK_MIN_RCVBUF, so we open-code this.
@@ -768,7 +749,7 @@ static void mctp_test_route_input_sk_fail_single(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, refcount_read(&skb->users), 1);
 	kfree_skb(skb);
 
-	__mctp_route_test_fini(test, dev, &dst, &tpq, sock);
+	__mctp_route_test_fini(test, dev, &dst, sock);
 }
 
 /* Input route to socket, using a fragmented message, where sock delivery fails.
@@ -776,7 +757,6 @@ static void mctp_test_route_input_sk_fail_single(struct kunit *test)
 static void mctp_test_route_input_sk_fail_frag(struct kunit *test)
 {
 	const struct mctp_hdr hdrs[2] = { RX_FRAG(FL_S, 0), RX_FRAG(FL_E, 1) };
-	struct mctp_test_pktqueue tpq;
 	struct mctp_test_dev *dev;
 	struct sk_buff *skbs[2];
 	struct mctp_dst dst;
@@ -784,7 +764,7 @@ static void mctp_test_route_input_sk_fail_frag(struct kunit *test)
 	unsigned int i;
 	int rc;
 
-	__mctp_route_test_init(test, &dev, &dst, &tpq, &sock, MCTP_NET_ANY);
+	__mctp_route_test_init(test, &dev, &dst, &sock, MCTP_NET_ANY);
 
 	lock_sock(sock->sk);
 	WRITE_ONCE(sock->sk->sk_rcvbuf, 0);
@@ -815,7 +795,7 @@ static void mctp_test_route_input_sk_fail_frag(struct kunit *test)
 	KUNIT_EXPECT_EQ(test, refcount_read(&skbs[1]->users), 1);
 	kfree_skb(skbs[1]);
 
-	__mctp_route_test_fini(test, dev, &dst, &tpq, sock);
+	__mctp_route_test_fini(test, dev, &dst, sock);
 }
 
 /* Input route to socket, using a fragmented message created from clones.
@@ -833,7 +813,6 @@ static void mctp_test_route_input_cloned_frag(struct kunit *test)
 	const size_t data_len = 3; /* arbitrary */
 	u8 compare[3 * ARRAY_SIZE(hdrs)];
 	u8 flat[3 * ARRAY_SIZE(hdrs)];
-	struct mctp_test_pktqueue tpq;
 	struct mctp_test_dev *dev;
 	struct sk_buff *skb[5];
 	struct sk_buff *rx_skb;
@@ -845,7 +824,7 @@ static void mctp_test_route_input_cloned_frag(struct kunit *test)
 
 	total = data_len + sizeof(struct mctp_hdr);
 
-	__mctp_route_test_init(test, &dev, &dst, &tpq, &sock, MCTP_NET_ANY);
+	__mctp_route_test_init(test, &dev, &dst, &sock, MCTP_NET_ANY);
 
 	/* Create a single skb initially with concatenated packets */
 	skb[0] = mctp_test_create_skb(&hdrs[0], 5 * total);
@@ -922,7 +901,7 @@ static void mctp_test_route_input_cloned_frag(struct kunit *test)
 		kfree_skb(skb[i]);
 	}
 
-	__mctp_route_test_fini(test, dev, &dst, &tpq, sock);
+	__mctp_route_test_fini(test, dev, &dst, sock);
 }
 
 #if IS_ENABLED(CONFIG_MCTP_FLOWS)
@@ -930,7 +909,6 @@ static void mctp_test_route_input_cloned_frag(struct kunit *test)
 static void mctp_test_flow_init(struct kunit *test,
 				struct mctp_test_dev **devp,
 				struct mctp_dst *dst,
-				struct mctp_test_pktqueue *tpq,
 				struct socket **sock,
 				struct sk_buff **skbp,
 				unsigned int len)
@@ -944,7 +922,7 @@ static void mctp_test_flow_init(struct kunit *test,
 	 * mctp_local_output, which will call dst->output on whatever
 	 * route we provide
 	 */
-	__mctp_route_test_init(test, &dev, dst, tpq, sock, MCTP_NET_ANY);
+	__mctp_route_test_init(test, &dev, dst, sock, MCTP_NET_ANY);
 
 	/* Assign a single EID. ->addrs is freed on mctp netdev release */
 	dev->mdev->addrs = kmalloc(sizeof(u8), GFP_KERNEL);
@@ -965,16 +943,14 @@ static void mctp_test_flow_init(struct kunit *test,
 static void mctp_test_flow_fini(struct kunit *test,
 				struct mctp_test_dev *dev,
 				struct mctp_dst *dst,
-				struct mctp_test_pktqueue *tpq,
 				struct socket *sock)
 {
-	__mctp_route_test_fini(test, dev, dst, tpq, sock);
+	__mctp_route_test_fini(test, dev, dst, sock);
 }
 
 /* test that an outgoing skb has the correct MCTP extension data set */
 static void mctp_test_packet_flow(struct kunit *test)
 {
-	struct mctp_test_pktqueue tpq;
 	struct sk_buff *skb, *skb2;
 	struct mctp_test_dev *dev;
 	struct mctp_dst dst;
@@ -983,15 +959,15 @@ static void mctp_test_packet_flow(struct kunit *test)
 	u8 dst_eid = 8;
 	int n, rc;
 
-	mctp_test_flow_init(test, &dev, &dst, &tpq, &sock, &skb, 30);
+	mctp_test_flow_init(test, &dev, &dst, &sock, &skb, 30);
 
 	rc = mctp_local_output(sock->sk, &dst, skb, dst_eid, MCTP_TAG_OWNER);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
-	n = tpq.pkts.qlen;
+	n = dev->pkts.qlen;
 	KUNIT_ASSERT_EQ(test, n, 1);
 
-	skb2 = skb_dequeue(&tpq.pkts);
+	skb2 = skb_dequeue(&dev->pkts);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb2);
 
 	flow = skb_ext_find(skb2, SKB_EXT_MCTP);
@@ -1000,7 +976,7 @@ static void mctp_test_packet_flow(struct kunit *test)
 	KUNIT_ASSERT_PTR_EQ(test, flow->key->sk, sock->sk);
 
 	kfree_skb(skb2);
-	mctp_test_flow_fini(test, dev, &dst, &tpq, sock);
+	mctp_test_flow_fini(test, dev, &dst, sock);
 }
 
 /* test that outgoing skbs, after fragmentation, all have the correct MCTP
@@ -1008,7 +984,6 @@ static void mctp_test_packet_flow(struct kunit *test)
  */
 static void mctp_test_fragment_flow(struct kunit *test)
 {
-	struct mctp_test_pktqueue tpq;
 	struct mctp_flow *flows[2];
 	struct sk_buff *tx_skbs[2];
 	struct mctp_test_dev *dev;
@@ -1018,17 +993,17 @@ static void mctp_test_fragment_flow(struct kunit *test)
 	u8 dst_eid = 8;
 	int n, rc;
 
-	mctp_test_flow_init(test, &dev, &dst, &tpq, &sock, &skb, 100);
+	mctp_test_flow_init(test, &dev, &dst, &sock, &skb, 100);
 
 	rc = mctp_local_output(sock->sk, &dst, skb, dst_eid, MCTP_TAG_OWNER);
 	KUNIT_ASSERT_EQ(test, rc, 0);
 
-	n = tpq.pkts.qlen;
+	n = dev->pkts.qlen;
 	KUNIT_ASSERT_EQ(test, n, 2);
 
 	/* both resulting packets should have the same flow data */
-	tx_skbs[0] = skb_dequeue(&tpq.pkts);
-	tx_skbs[1] = skb_dequeue(&tpq.pkts);
+	tx_skbs[0] = skb_dequeue(&dev->pkts);
+	tx_skbs[1] = skb_dequeue(&dev->pkts);
 
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tx_skbs[0]);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, tx_skbs[1]);
@@ -1044,7 +1019,7 @@ static void mctp_test_fragment_flow(struct kunit *test)
 
 	kfree_skb(tx_skbs[0]);
 	kfree_skb(tx_skbs[1]);
-	mctp_test_flow_fini(test, dev, &dst, &tpq, sock);
+	mctp_test_flow_fini(test, dev, &dst, sock);
 }
 
 #else
@@ -1063,7 +1038,6 @@ static void mctp_test_fragment_flow(struct kunit *test)
 static void mctp_test_route_output_key_create(struct kunit *test)
 {
 	const u8 dst_eid = 26, src_eid = 15;
-	struct mctp_test_pktqueue tpq;
 	const unsigned int netid = 50;
 	struct mctp_test_dev *dev;
 	struct mctp_sk_key *key;
@@ -1080,7 +1054,7 @@ static void mctp_test_route_output_key_create(struct kunit *test)
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 	WRITE_ONCE(dev->mdev->net, netid);
 
-	mctp_test_dst_setup(test, &dst, dev, &tpq, 68);
+	mctp_test_dst_setup(test, &dst, dev, 68);
 
 	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
 	KUNIT_ASSERT_EQ(test, rc, 0);
@@ -1127,14 +1101,13 @@ static void mctp_test_route_output_key_create(struct kunit *test)
 	KUNIT_EXPECT_FALSE(test, key->tag & MCTP_TAG_OWNER);
 
 	sock_release(sock);
-	mctp_test_dst_release(&dst, &tpq);
+	mctp_dst_release(&dst);
 	mctp_test_destroy_dev(dev);
 }
 
 static void mctp_test_route_extaddr_input(struct kunit *test)
 {
 	static const unsigned char haddr[] = { 0xaa, 0x55 };
-	struct mctp_test_pktqueue tpq;
 	struct mctp_skb_cb *cb, *cb2;
 	const unsigned int len = 40;
 	struct mctp_test_dev *dev;
@@ -1149,7 +1122,7 @@ static void mctp_test_route_extaddr_input(struct kunit *test)
 	hdr.dest = 8;
 	hdr.flags_seq_tag = FL_S | FL_E | FL_TO;
 
-	__mctp_route_test_init(test, &dev, &dst, &tpq, &sock, MCTP_NET_ANY);
+	__mctp_route_test_init(test, &dev, &dst, &sock, MCTP_NET_ANY);
 
 	skb = mctp_test_create_skb(&hdr, len);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb);
@@ -1178,7 +1151,7 @@ static void mctp_test_route_extaddr_input(struct kunit *test)
 	KUNIT_EXPECT_MEMEQ(test, cb2->haddr, haddr, sizeof(haddr));
 
 	kfree_skb(skb2);
-	__mctp_route_test_fini(test, dev, &dst, &tpq, sock);
+	__mctp_route_test_fini(test, dev, &dst, sock);
 }
 
 static void mctp_test_route_gw_lookup(struct kunit *test)
@@ -1530,14 +1503,13 @@ static void mctp_test_bind_lookup(struct kunit *test)
 	struct socket *socks[ARRAY_SIZE(lookup_binds)];
 	struct sk_buff *skb_pkt = NULL, *skb_sock = NULL;
 	struct socket *sock_ty0, *sock_expect = NULL;
-	struct mctp_test_pktqueue tpq;
 	struct mctp_test_dev *dev;
 	struct mctp_dst dst;
 	int rc;
 
 	rx = test->param_value;
 
-	__mctp_route_test_init(test, &dev, &dst, &tpq, &sock_ty0, rx->net);
+	__mctp_route_test_init(test, &dev, &dst, &sock_ty0, rx->net);
 	/* Create all binds */
 	for (size_t i = 0; i < ARRAY_SIZE(lookup_binds); i++) {
 		mctp_test_bind_run(test, &lookup_binds[i],
@@ -1557,7 +1529,6 @@ static void mctp_test_bind_lookup(struct kunit *test)
 	skb_pkt = mctp_test_create_skb_data(&rx->hdr, &rx->ty);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, skb_pkt);
 	mctp_test_skb_set_dev(skb_pkt, dev);
-	mctp_test_pktqueue_init(&tpq);
 
 	rc = mctp_dst_input(&dst, skb_pkt);
 	if (rx->expect) {
@@ -1591,7 +1562,7 @@ static void mctp_test_bind_lookup(struct kunit *test)
 	for (size_t i = 0; i < ARRAY_SIZE(lookup_binds); i++)
 		sock_release(socks[i]);
 
-	__mctp_route_test_fini(test, dev, &dst, &tpq, sock_ty0);
+	__mctp_route_test_fini(test, dev, &dst, sock_ty0);
 }
 
 static struct kunit_case mctp_test_cases[] = {
diff --git a/net/mctp/test/utils.c b/net/mctp/test/utils.c
index 35f6be8145674b56a72b183402749eb856155424..37f1ba62a2ab0fa5ed93ccf53ecd208ec536793a 100644
--- a/net/mctp/test/utils.c
+++ b/net/mctp/test/utils.c
@@ -13,7 +13,10 @@
 static netdev_tx_t mctp_test_dev_tx(struct sk_buff *skb,
 				    struct net_device *ndev)
 {
-	kfree_skb(skb);
+	struct mctp_test_dev *dev = netdev_priv(ndev);
+
+	skb_queue_tail(&dev->pkts, skb);
+
 	return NETDEV_TX_OK;
 }
 
@@ -26,7 +29,7 @@ static void mctp_test_dev_setup(struct net_device *ndev)
 	ndev->type = ARPHRD_MCTP;
 	ndev->mtu = MCTP_DEV_TEST_MTU;
 	ndev->hard_header_len = 0;
-	ndev->tx_queue_len = DEFAULT_TX_QUEUE_LEN;
+	ndev->tx_queue_len = 0;
 	ndev->flags = IFF_NOARP;
 	ndev->netdev_ops = &mctp_test_netdev_ops;
 	ndev->needs_free_netdev = true;
@@ -51,6 +54,7 @@ static struct mctp_test_dev *__mctp_test_create_dev(unsigned short lladdr_len,
 	dev->ndev = ndev;
 	ndev->addr_len = lladdr_len;
 	dev_addr_set(ndev, lladdr);
+	skb_queue_head_init(&dev->pkts);
 
 	rc = register_netdev(ndev);
 	if (rc) {
@@ -63,6 +67,11 @@ static struct mctp_test_dev *__mctp_test_create_dev(unsigned short lladdr_len,
 	dev->mdev->net = mctp_default_net(dev_net(ndev));
 	rcu_read_unlock();
 
+	/* bring the device up; we want to be able to TX immediately */
+	rtnl_lock();
+	dev_open(ndev, NULL);
+	rtnl_unlock();
+
 	return dev;
 }
 
@@ -79,26 +88,15 @@ struct mctp_test_dev *mctp_test_create_dev_lladdr(unsigned short lladdr_len,
 
 void mctp_test_destroy_dev(struct mctp_test_dev *dev)
 {
+	skb_queue_purge(&dev->pkts);
 	mctp_dev_put(dev->mdev);
 	unregister_netdev(dev->ndev);
 }
 
-static const unsigned int test_pktqueue_magic = 0x5f713aef;
-
-void mctp_test_pktqueue_init(struct mctp_test_pktqueue *tpq)
-{
-	tpq->magic = test_pktqueue_magic;
-	skb_queue_head_init(&tpq->pkts);
-}
-
 static int mctp_test_dst_output(struct mctp_dst *dst, struct sk_buff *skb)
 {
-	struct kunit *test = current->kunit_test;
-	struct mctp_test_pktqueue *tpq = test->priv;
-
-	KUNIT_ASSERT_EQ(test, tpq->magic, test_pktqueue_magic);
-
-	skb_queue_tail(&tpq->pkts, skb);
+	skb->dev = dst->dev->dev;
+	dev_queue_xmit(skb);
 
 	return 0;
 }
@@ -169,11 +167,9 @@ struct mctp_test_route *mctp_test_create_route_gw(struct net *net,
 	return rt;
 }
 
-/* Convenience function for our test dst; release with mctp_test_dst_release()
- */
+/* Convenience function for our test dst; release with mctp_dst_release() */
 void mctp_test_dst_setup(struct kunit *test, struct mctp_dst *dst,
-			 struct mctp_test_dev *dev,
-			 struct mctp_test_pktqueue *tpq, unsigned int mtu)
+			 struct mctp_test_dev *dev, unsigned int mtu)
 {
 	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);
 
@@ -183,15 +179,6 @@ void mctp_test_dst_setup(struct kunit *test, struct mctp_dst *dst,
 	__mctp_dev_get(dst->dev->dev);
 	dst->mtu = mtu;
 	dst->output = mctp_test_dst_output;
-	mctp_test_pktqueue_init(tpq);
-	test->priv = tpq;
-}
-
-void mctp_test_dst_release(struct mctp_dst *dst,
-			   struct mctp_test_pktqueue *tpq)
-{
-	mctp_dst_release(dst);
-	skb_queue_purge(&tpq->pkts);
 }
 
 void mctp_test_route_destroy(struct kunit *test, struct mctp_test_route *rt)
diff --git a/net/mctp/test/utils.h b/net/mctp/test/utils.h
index 06bdb6cb5eff6560c7378cf37a1bb17757938e82..4cc90c9da4d1bfe9c63b2cac5253f9e09be3b147 100644
--- a/net/mctp/test/utils.h
+++ b/net/mctp/test/utils.h
@@ -18,6 +18,8 @@ struct mctp_test_dev {
 
 	unsigned short lladdr_len;
 	unsigned char lladdr[MAX_ADDR_LEN];
+
+	struct sk_buff_head pkts;
 };
 
 struct mctp_test_dev;
@@ -26,11 +28,6 @@ struct mctp_test_route {
 	struct mctp_route	rt;
 };
 
-struct mctp_test_pktqueue {
-	unsigned int magic;
-	struct sk_buff_head pkts;
-};
-
 struct mctp_test_bind_setup {
 	mctp_eid_t bind_addr;
 	int bind_net;
@@ -59,11 +56,7 @@ struct mctp_test_route *mctp_test_create_route_gw(struct net *net,
 						  mctp_eid_t gw,
 						  unsigned int mtu);
 void mctp_test_dst_setup(struct kunit *test, struct mctp_dst *dst,
-			 struct mctp_test_dev *dev,
-			 struct mctp_test_pktqueue *tpq, unsigned int mtu);
-void mctp_test_dst_release(struct mctp_dst *dst,
-			   struct mctp_test_pktqueue *tpq);
-void mctp_test_pktqueue_init(struct mctp_test_pktqueue *tpq);
+			 struct mctp_test_dev *dev, unsigned int mtu);
 void mctp_test_route_destroy(struct kunit *test, struct mctp_test_route *rt);
 void mctp_test_skb_set_dev(struct sk_buff *skb, struct mctp_test_dev *dev);
 struct sk_buff *mctp_test_create_skb(const struct mctp_hdr *hdr,

---
base-commit: e05021a829b834fecbd42b173e55382416571b2c
change-id: 20251124-dev-mctp-test-tx-queue-4b5d15b2fc36

Best regards,
-- 
Jeremy Kerr <jk@codeconstruct.com.au>



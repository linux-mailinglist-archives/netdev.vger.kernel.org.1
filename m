Return-Path: <netdev+bounces-72878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D9D685A04D
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 10:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7DF1C211FF
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 09:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0BAC28DB3;
	Mon, 19 Feb 2024 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="a8j8uBGt"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FDF28684
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 09:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708336441; cv=none; b=qY5O+KHsH/kz+6B1CitQwHNel0azV9g4SzON9gl3olu/M52myVkQqw2chmMpcpOLhaxjuoLZ3PJh+ZbQHmSGhZ+3Wupw1Pg+vXgPeDoGnkEjVyjX+pA4Y9vh8/hP5U2h+O/Wdmvp94h8R0960fa7H2yJjIFkYKtgffaivYv3PxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708336441; c=relaxed/simple;
	bh=x8qAfCK/nh1Br8XAz7HBBr7vf6dTQu+KAfPdSxkHMlM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=PGRu38WJYJIzBceCs0VAV9HFituRzDl0/VPMOL+5gL+bwHrWuCZUvfULohHRqq5V+tGyaznZyrYnc+U+YY8bK6K/oXaGyU+vgSjNu3DIgVoYAzLL9YtqvoXtqg88GHKO/MmJixyNkYIglxODnIqFnC4EH+Mrzpy5PTGdHLuLGU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=a8j8uBGt; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id C27A82048E; Mon, 19 Feb 2024 17:53:56 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1708336436;
	bh=9MzWlU9KsyuboE7LXckQ40MclAUt77y6ECGsbNrqSRk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=a8j8uBGt72+my7O9044lDaCo4zjBURhTuUjHLwq3zlnjt7Bzp9JCbuCMo7VHPzb8/
	 EttMk8G+N+p2gpya1JQC37RMpfC7y8sdfwjTC0U+kVmIVxooT6TD5DDOE9x7wttiG4
	 rE3q2R/KuO+/dzJlgQcTWHgSzNx4lYFud2zlV6OumrqUuPFc29dBxC3YVn9UYI2dHI
	 e1KfYQzpyGBP6KRnt1zuMwqAEB/1gMiJT/PwczcMUZe5T+p9DOZYRUidGazGcIu5Ir
	 JfOKvgYY2CntreU2XMvFhEmOa/hPllSF1UgO2O2vl66tDCL+bfzuAl9UwkXtbziwBr
	 6g4G0Mjyj7ALA==
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
	Johannes Berg <johannes.berg@intel.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH net-next v2 10/11] net: mctp: tests: Test that outgoing skbs have flow data populated
Date: Mon, 19 Feb 2024 17:51:55 +0800
Message-Id: <78236e5c082981e8411188523d40c8841b87622c.1708335994.git.jk@codeconstruct.com.au>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <cover.1708335994.git.jk@codeconstruct.com.au>
References: <cover.1708335994.git.jk@codeconstruct.com.au>
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

We now make MCTP_TEST select MCTP_FLOWS, so we always get coverage of
these flow tests. The tests are skippable if MCTP_FLOWS is (otherwise)
disabled, but that would need manual config tweaking.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>

--
v2:
 - don't skip the flow tests for a kunit all-tests run, based on
   feedback from Jakub Kicinski <kuba@kernel.org>
---
 net/mctp/Kconfig                             |   1 +
 net/mctp/test/route-test.c                   | 136 +++++++++++++++++++
 tools/testing/kunit/configs/all_tests.config |   1 +
 3 files changed, 138 insertions(+)

diff --git a/net/mctp/Kconfig b/net/mctp/Kconfig
index 3a5c0e70da77..d8d3413a37f7 100644
--- a/net/mctp/Kconfig
+++ b/net/mctp/Kconfig
@@ -14,6 +14,7 @@ menuconfig MCTP
 
 config MCTP_TEST
         bool "MCTP core tests" if !KUNIT_ALL_TESTS
+        select MCTP_FLOWS
         depends on MCTP=y && KUNIT=y
         default KUNIT_ALL_TESTS
 
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
 
diff --git a/tools/testing/kunit/configs/all_tests.config b/tools/testing/kunit/configs/all_tests.config
index 3bf506d4a63c..eb5e0ca2b9a8 100644
--- a/tools/testing/kunit/configs/all_tests.config
+++ b/tools/testing/kunit/configs/all_tests.config
@@ -23,6 +23,7 @@ CONFIG_USB4=y
 
 CONFIG_NET=y
 CONFIG_MCTP=y
+CONFIG_MCTP_FLOWS=y
 
 CONFIG_INET=y
 CONFIG_MPTCP=y
-- 
2.39.2



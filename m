Return-Path: <netdev+bounces-200969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0ABFAE78C2
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:37:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F319D7B58A3
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:36:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CF57221D92;
	Wed, 25 Jun 2025 07:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="IQsOdOZN"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C48F21CC44
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 07:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836916; cv=none; b=gPIvnFNZnrXA/7sLc+YeIMEONWdiorN7EPl4c8t3vbdB61mgMEEzZZRPyh90o1qVVA5WMGKNJRqsD37uJtJx9OIrpMUV0zLJlyk+MmiUECuoEK38VgHWS6HValeRwTtAv+v6xbt8ySaAWGDkxpzPRohjzK9XhlzAeTxL+dDXz6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836916; c=relaxed/simple;
	bh=NlHZSSxpP00Y/q7uR+zGfR7vUlsc0JVis9x1GLmqOq4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oPjeU4JPzFeE1KWUfyX5FN71bIKr2eQFDw7fEQzkfgn7v9KcG+doiI0aVYeK/wEV3ELdMgq5h6/6j6KGJQXRgJBEm52jOelHZhYNAavHwL+fsKtTupG5RnvvOGjkzjZ88cWdnLCpX1j7zJrv/Kz/t2O+BKiB8Bk+nnSeAg7xuZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=IQsOdOZN; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750836908;
	bh=bHUFjUj7PVOXyhGSHWo0jgAs7mr6oXVX8+tRCU1K/Os=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IQsOdOZNG362d5Fak/esPQGjMJBy0BJlz0X2jfzSsG0imv5Uv5VcJzw9FUBNwrA+7
	 lZob4PadJzfp+UVciOUC9TZCoLC9cQBkIrDs3ei7Y66x4AYb0Vsm+VQUTuNCH8HEy+
	 s7X5vOm7tC9ZtsBs/+SySuunX8fY9RxzDrGgbGhSomQsg7ihbe56yE/mqZAXnR7aUv
	 6PEiAt/267qDgeJ+IWO5myQh9RHD5oMBcseA44azMFaHY3VsROFJsUEFYMEhztUtaa
	 r4Ii3yNeT5hc9NoyfxklwYIQDAJ1vVYEhf4RRlupRrJ2Q4zMU97t0aKURsjPILsJaM
	 gE85t3hM3RjmA==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 9BF4769A4B; Wed, 25 Jun 2025 15:35:08 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 25 Jun 2025 15:34:52 +0800
Subject: [PATCH net-next v3 14/14] net: mctp: test: Add tests for gateway
 routes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-dev-forwarding-v3-14-2061bd3013b3@codeconstruct.com.au>
References: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
In-Reply-To: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Add a few kunit tests for the gateway routing. Because we have multiple
route types now (direct and gateway), rename mctp_test_create_route to
mctp_test_create_route_direct, and add a _gateway variant too.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
--
v2:
 - static-ify mctp_route_gw_mtu_tests, reported by kernel test robot
---
 net/mctp/test/route-test.c | 233 ++++++++++++++++++++++++++++++++++++++++++++-
 net/mctp/test/sock-test.c  |   2 +-
 net/mctp/test/utils.c      |  33 ++++++-
 net/mctp/test/utils.h      |  13 ++-
 4 files changed, 271 insertions(+), 10 deletions(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 7cd2e3c60364c36f5f1251c25bea7d9617836106..de419461a79f3da0ec7cbdc79517040fdca8b835 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -141,7 +141,7 @@ static void mctp_test_rx_input(struct kunit *test)
 	dev = mctp_test_create_dev();
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
 
-	rt = mctp_test_create_route(&init_net, dev->mdev, 8, 68);
+	rt = mctp_test_create_route_direct(&init_net, dev->mdev, 8, 68);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt);
 
 	skb = mctp_test_create_skb(&params->hdr, 1);
@@ -1183,6 +1183,233 @@ static void mctp_test_route_extaddr_input(struct kunit *test)
 	mctp_test_destroy_dev(dev);
 }
 
+static void mctp_test_route_gw_lookup(struct kunit *test)
+{
+	struct mctp_test_route *rt1, *rt2;
+	struct mctp_dst dst = { 0 };
+	struct mctp_test_dev *dev;
+	int rc;
+
+	dev = mctp_test_create_dev();
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	/* 8 (local) -> 10 (gateway) via 9 (direct) */
+	rt1 = mctp_test_create_route_direct(&init_net, dev->mdev, 9, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt1);
+	rt2 = mctp_test_create_route_gw(&init_net, dev->mdev->net, 10, 9, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt2);
+
+	rc = mctp_route_lookup(&init_net, dev->mdev->net, 10, &dst);
+	KUNIT_EXPECT_EQ(test, rc, 0);
+	KUNIT_EXPECT_PTR_EQ(test, dst.dev, dev->mdev);
+	KUNIT_EXPECT_EQ(test, dst.mtu, dev->ndev->mtu);
+	KUNIT_EXPECT_EQ(test, dst.nexthop, 9);
+	KUNIT_EXPECT_EQ(test, dst.halen, 0);
+
+	mctp_dst_release(&dst);
+
+	mctp_test_route_destroy(test, rt2);
+	mctp_test_route_destroy(test, rt1);
+	mctp_test_destroy_dev(dev);
+}
+
+static void mctp_test_route_gw_loop(struct kunit *test)
+{
+	struct mctp_test_route *rt1, *rt2;
+	struct mctp_dst dst = { 0 };
+	struct mctp_test_dev *dev;
+	int rc;
+
+	dev = mctp_test_create_dev();
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+
+	/* two routes using each other as the gw */
+	rt1 = mctp_test_create_route_gw(&init_net, dev->mdev->net, 9, 10, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt1);
+	rt2 = mctp_test_create_route_gw(&init_net, dev->mdev->net, 10, 9, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt2);
+
+	/* this should fail, rather than infinite-loop */
+	rc = mctp_route_lookup(&init_net, dev->mdev->net, 10, &dst);
+	KUNIT_EXPECT_NE(test, rc, 0);
+
+	mctp_test_route_destroy(test, rt2);
+	mctp_test_route_destroy(test, rt1);
+	mctp_test_destroy_dev(dev);
+}
+
+struct mctp_route_gw_mtu_test {
+	/* working away from the local stack */
+	unsigned int dev, neigh, gw, dst;
+	unsigned int exp;
+};
+
+static void mctp_route_gw_mtu_to_desc(const struct mctp_route_gw_mtu_test *t,
+				      char *desc)
+{
+	sprintf(desc, "dev %d, neigh %d, gw %d, dst %d -> %d",
+		t->dev, t->neigh, t->gw, t->dst, t->exp);
+}
+
+static const struct mctp_route_gw_mtu_test mctp_route_gw_mtu_tests[] = {
+	/* no route-specific MTUs */
+	{ 68, 0, 0, 0, 68 },
+	{ 100, 0, 0, 0, 100 },
+	/* one route MTU (smaller than dev mtu), others unrestricted */
+	{ 100, 68, 0, 0, 68 },
+	{ 100, 0, 68, 0, 68 },
+	{ 100, 0, 0, 68, 68 },
+	/* smallest applied, regardless of order */
+	{ 100, 99, 98, 68, 68 },
+	{ 99, 100, 98, 68, 68 },
+	{ 98, 99, 100, 68, 68 },
+	{ 68, 98, 99, 100, 68 },
+};
+
+KUNIT_ARRAY_PARAM(mctp_route_gw_mtu, mctp_route_gw_mtu_tests,
+		  mctp_route_gw_mtu_to_desc);
+
+static void mctp_test_route_gw_mtu(struct kunit *test)
+{
+	const struct mctp_route_gw_mtu_test *mtus = test->param_value;
+	struct mctp_test_route *rt1, *rt2, *rt3;
+	struct mctp_dst dst = { 0 };
+	struct mctp_test_dev *dev;
+	struct mctp_dev *mdev;
+	unsigned int netid;
+	int rc;
+
+	dev = mctp_test_create_dev();
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	dev->ndev->mtu = mtus->dev;
+	mdev = dev->mdev;
+	netid = mdev->net;
+
+	/* 8 (local) -> 11 (dst) via 10 (gw) via 9 (neigh) */
+	rt1 = mctp_test_create_route_direct(&init_net, mdev, 9, mtus->neigh);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt1);
+
+	rt2 = mctp_test_create_route_gw(&init_net, netid, 10, 9, mtus->gw);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt2);
+
+	rt3 = mctp_test_create_route_gw(&init_net, netid, 11, 10, mtus->dst);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt3);
+
+	rc = mctp_route_lookup(&init_net, dev->mdev->net, 11, &dst);
+	KUNIT_EXPECT_EQ(test, rc, 0);
+	KUNIT_EXPECT_EQ(test, dst.mtu, mtus->exp);
+
+	mctp_dst_release(&dst);
+
+	mctp_test_route_destroy(test, rt3);
+	mctp_test_route_destroy(test, rt2);
+	mctp_test_route_destroy(test, rt1);
+	mctp_test_destroy_dev(dev);
+}
+
+#define MCTP_TEST_LLADDR_LEN 2
+struct mctp_test_llhdr {
+	unsigned int magic;
+	unsigned char src[MCTP_TEST_LLADDR_LEN];
+	unsigned char dst[MCTP_TEST_LLADDR_LEN];
+};
+
+static const unsigned int mctp_test_llhdr_magic = 0x5c78339c;
+
+static int test_dev_header_create(struct sk_buff *skb, struct net_device *dev,
+				  unsigned short type, const void *daddr,
+				  const void *saddr, unsigned int len)
+{
+	struct kunit *test = current->kunit_test;
+	struct mctp_test_llhdr *hdr;
+
+	hdr = skb_push(skb, sizeof(*hdr));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, hdr);
+	skb_reset_mac_header(skb);
+
+	hdr->magic = mctp_test_llhdr_magic;
+	memcpy(&hdr->src, saddr, sizeof(hdr->src));
+	memcpy(&hdr->dst, daddr, sizeof(hdr->dst));
+
+	return 0;
+}
+
+/* Test the dst_output path for a gateway-routed skb: we should have it
+ * lookup the nexthop EID in the neighbour table, and call into
+ * header_ops->create to resolve that to a lladdr. Our mock header_ops->create
+ * will just set a synthetic link-layer header, which we check after transmit.
+ */
+static void mctp_test_route_gw_output(struct kunit *test)
+{
+	const unsigned char haddr_self[MCTP_TEST_LLADDR_LEN] = { 0xaa, 0x03 };
+	const unsigned char haddr_peer[MCTP_TEST_LLADDR_LEN] = { 0xaa, 0x02 };
+	const struct header_ops ops = {
+		.create = test_dev_header_create,
+	};
+	struct mctp_neigh neigh = { 0 };
+	struct mctp_test_llhdr *ll_hdr;
+	struct mctp_dst dst = { 0 };
+	struct mctp_hdr hdr = { 0 };
+	struct mctp_test_dev *dev;
+	struct sk_buff *skb;
+	unsigned char *buf;
+	int i, rc;
+
+	dev = mctp_test_create_dev_lladdr(sizeof(haddr_self), haddr_self);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, dev);
+	dev->ndev->header_ops = &ops;
+
+	dst.dev = dev->mdev;
+	__mctp_dev_get(dst.dev->dev);
+	dst.mtu = 68;
+	dst.nexthop = 9;
+
+	/* simple mctp_neigh_add for the gateway (not dest!) endpoint */
+	INIT_LIST_HEAD(&neigh.list);
+	neigh.dev = dev->mdev;
+	mctp_dev_hold(dev->mdev);
+	neigh.eid = 9;
+	neigh.source = MCTP_NEIGH_STATIC;
+	memcpy(neigh.ha, haddr_peer, sizeof(haddr_peer));
+	list_add_rcu(&neigh.list, &init_net.mctp.neighbours);
+
+	hdr.ver = 1;
+	hdr.src = 8;
+	hdr.dest = 10;
+	hdr.flags_seq_tag = FL_S | FL_E | FL_TO;
+
+	/* construct enough for a future link-layer header, the provided
+	 * mctp header, and 4 bytes of data
+	 */
+	skb = alloc_skb(sizeof(*ll_hdr) + sizeof(hdr) + 4, GFP_KERNEL);
+	skb->dev = dev->ndev;
+	__mctp_cb(skb);
+
+	skb_reserve(skb, sizeof(*ll_hdr));
+
+	memcpy(skb_put(skb, sizeof(hdr)), &hdr, sizeof(hdr));
+	buf = skb_put(skb, 4);
+	for (i = 0; i < 4; i++)
+		buf[i] = i;
+
+	/* extra ref over the dev_xmit */
+	skb_get(skb);
+
+	rc = mctp_dst_output(&dst, skb);
+	KUNIT_EXPECT_EQ(test, rc, 0);
+
+	mctp_dst_release(&dst);
+	list_del_rcu(&neigh.list);
+	mctp_dev_put(dev->mdev);
+
+	/* check that we have our header created with the correct neighbour */
+	ll_hdr = (void *)skb_mac_header(skb);
+	KUNIT_EXPECT_EQ(test, ll_hdr->magic, mctp_test_llhdr_magic);
+	KUNIT_EXPECT_MEMEQ(test, ll_hdr->src, haddr_self, sizeof(haddr_self));
+	KUNIT_EXPECT_MEMEQ(test, ll_hdr->dst, haddr_peer, sizeof(haddr_peer));
+	kfree_skb(skb);
+}
+
 static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE_PARAM(mctp_test_fragment, mctp_frag_gen_params),
 	KUNIT_CASE_PARAM(mctp_test_rx_input, mctp_rx_input_gen_params),
@@ -1200,6 +1427,10 @@ static struct kunit_case mctp_test_cases[] = {
 	KUNIT_CASE(mctp_test_route_output_key_create),
 	KUNIT_CASE(mctp_test_route_input_cloned_frag),
 	KUNIT_CASE(mctp_test_route_extaddr_input),
+	KUNIT_CASE(mctp_test_route_gw_lookup),
+	KUNIT_CASE(mctp_test_route_gw_loop),
+	KUNIT_CASE_PARAM(mctp_test_route_gw_mtu, mctp_route_gw_mtu_gen_params),
+	KUNIT_CASE(mctp_test_route_gw_output),
 	{}
 };
 
diff --git a/net/mctp/test/sock-test.c b/net/mctp/test/sock-test.c
index 5501f7794a8f96f1dcf26e93542bec04ddcfc769..4eb3a724dca39eb22615cbfc1201b45ee4c78d16 100644
--- a/net/mctp/test/sock-test.c
+++ b/net/mctp/test/sock-test.c
@@ -40,7 +40,7 @@ static void __mctp_sock_test_init(struct kunit *test,
 
 	kfree(addrs);
 
-	rt = mctp_test_create_route(dev_net(dev->ndev), dev->mdev, 9, 0);
+	rt = mctp_test_create_route_direct(dev_net(dev->ndev), dev->mdev, 9, 0);
 	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, rt);
 
 	rc = sock_create_kern(&init_net, AF_MCTP, SOCK_DGRAM, 0, &sock);
diff --git a/net/mctp/test/utils.c b/net/mctp/test/utils.c
index 97b05e340586f69d8ba04c970b0ee88391db006a..01f5af416b814baf812b4352c513ffcdd9939cb2 100644
--- a/net/mctp/test/utils.c
+++ b/net/mctp/test/utils.c
@@ -119,10 +119,10 @@ static struct mctp_test_route *mctp_route_test_alloc(void)
 	return rt;
 }
 
-struct mctp_test_route *mctp_test_create_route(struct net *net,
-					       struct mctp_dev *dev,
-					       mctp_eid_t eid,
-					       unsigned int mtu)
+struct mctp_test_route *mctp_test_create_route_direct(struct net *net,
+						      struct mctp_dev *dev,
+						      mctp_eid_t eid,
+						      unsigned int mtu)
 {
 	struct mctp_test_route *rt;
 
@@ -144,6 +144,31 @@ struct mctp_test_route *mctp_test_create_route(struct net *net,
 	return rt;
 }
 
+struct mctp_test_route *mctp_test_create_route_gw(struct net *net,
+						  unsigned int netid,
+						  mctp_eid_t eid,
+						  mctp_eid_t gw,
+						  unsigned int mtu)
+{
+	struct mctp_test_route *rt;
+
+	rt = mctp_route_test_alloc();
+	if (!rt)
+		return NULL;
+
+	rt->rt.min = eid;
+	rt->rt.max = eid;
+	rt->rt.mtu = mtu;
+	rt->rt.type = RTN_UNSPEC;
+	rt->rt.dst_type = MCTP_ROUTE_GATEWAY;
+	rt->rt.gateway.eid = gw;
+	rt->rt.gateway.net = netid;
+
+	list_add_rcu(&rt->rt.list, &net->mctp.routes);
+
+	return rt;
+}
+
 /* Convenience function for our test dst; release with mctp_test_dst_release()
  */
 void mctp_test_dst_setup(struct kunit *test, struct mctp_dst *dst,
diff --git a/net/mctp/test/utils.h b/net/mctp/test/utils.h
index 9405ca89d7032d65fbfb92503fbeb884ebd8bd25..f10d1d9066ccde53bbaf471ea79b87b1d94cd755 100644
--- a/net/mctp/test/utils.h
+++ b/net/mctp/test/utils.h
@@ -36,10 +36,15 @@ struct mctp_test_dev *mctp_test_create_dev_lladdr(unsigned short lladdr_len,
 						  const unsigned char *lladdr);
 void mctp_test_destroy_dev(struct mctp_test_dev *dev);
 
-struct mctp_test_route *mctp_test_create_route(struct net *net,
-					       struct mctp_dev *dev,
-					       mctp_eid_t eid,
-					       unsigned int mtu);
+struct mctp_test_route *mctp_test_create_route_direct(struct net *net,
+						      struct mctp_dev *dev,
+						      mctp_eid_t eid,
+						      unsigned int mtu);
+struct mctp_test_route *mctp_test_create_route_gw(struct net *net,
+						  unsigned int netid,
+						  mctp_eid_t eid,
+						  mctp_eid_t gw,
+						  unsigned int mtu);
 void mctp_test_dst_setup(struct kunit *test, struct mctp_dst *dst,
 			 struct mctp_test_dev *dev,
 			 struct mctp_test_pktqueue *tpq, unsigned int mtu);

-- 
2.39.5



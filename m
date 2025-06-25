Return-Path: <netdev+bounces-200964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 668F3AE78BB
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:37:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD833A520B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0718B219E93;
	Wed, 25 Jun 2025 07:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="jJUuUgCP"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36E8217709
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836912; cv=none; b=jdX5afXLy8BNlhElyCr2VSyzbBaSbIp67vKP8gu0TK7/+4HtX9PpnluvAoqnFS2eDoWZQ9Lu/jS6nX4s33VG/XuA1ZNShabEKU9nQlDeEwczgT2GWSn8CSxws0XQuIAUtbes5snLQ/zyniQLzNac2g+bgyWcerA0JElc7NVMTUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836912; c=relaxed/simple;
	bh=Sfui8/WDxPKY/MTG4TmD1MZNmLUuSc4NIBnTC8RyuNk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p6LrDGCT500zCWyTXAFFf8wn2GkN+LBAiNMQJ4iWdvbKpqopt6b57MtXma7dFydJd27m5tFCZ7PaTrj0X06zgMI+PQ9ovOhusz0SHyxO9yc4qWkOweoa0mGkK3PoyPGJMZ/yEykK7q7U5UDrPYLm9IFV3asHTaDqHfPfN0MFuEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=jJUuUgCP; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750836906;
	bh=MiKd3tgzf9iOkCkLDvZKwF9MlsI7JcGAaVw/pTWD0VM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=jJUuUgCP+xuzkP5Cu85q7U2lrgU5l9GmAHep2lc2PtUJRmjX4xd2KGuRWFiXZ4bFM
	 1B1Zup8HkGlE11aPAzoz0nIhawcfZ2DE7DXxUc3e40INrfxKltV8zUucQa/7AG+IBX
	 RJ49xJUAgE19Wi0BQOAGVv7D03Vv8W905FiydnCMlUmVdzx8aHpezfrOweQPb8hMdD
	 r7as9WcNC1qBI7nK1k6vxG2xZOBgGCo4XgdjTfdXuTBaH6roZX28OgNZY0vi4hYohP
	 4tuZcOWPnqj6f4rrc7EKBsAtVxkj8oD+oSem+pFpuaklgvmJj75cs6IEWCk8vVwHkv
	 USUUtE4B+5xDQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 9E2AD69A3D; Wed, 25 Jun 2025 15:35:06 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 25 Jun 2025 15:34:45 +0800
Subject: [PATCH net-next v3 07/14] net: mctp: test: move functions into
 utils.[ch]
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-dev-forwarding-v3-7-2061bd3013b3@codeconstruct.com.au>
References: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
In-Reply-To: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

A future change will add another mctp test .c file, so move some of the
common test setup from route.c into the utils object.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/test/route-test.c | 163 ---------------------------------------------
 net/mctp/test/utils.c      | 150 +++++++++++++++++++++++++++++++++++++++++
 net/mctp/test/utils.h      |  32 +++++++++
 3 files changed, 182 insertions(+), 163 deletions(-)

diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index 248d28a4a3ddb3ac531e645d806aba6946efc36d..bb3f454525c1b8e3133de2fe3bc3d139f6acd962 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -8,169 +8,6 @@
 
 #include "utils.h"
 
-struct mctp_test_route {
-	struct mctp_route	rt;
-};
-
-static const unsigned int test_pktqueue_magic = 0x5f713aef;
-
-struct mctp_test_pktqueue {
-	unsigned int magic;
-	struct sk_buff_head pkts;
-};
-
-static void mctp_test_pktqueue_init(struct mctp_test_pktqueue *tpq)
-{
-	tpq->magic = test_pktqueue_magic;
-	skb_queue_head_init(&tpq->pkts);
-}
-
-static int mctp_test_dst_output(struct mctp_dst *dst, struct sk_buff *skb)
-{
-	struct kunit *test = current->kunit_test;
-	struct mctp_test_pktqueue *tpq = test->priv;
-
-	KUNIT_ASSERT_EQ(test, tpq->magic, test_pktqueue_magic);
-
-	skb_queue_tail(&tpq->pkts, skb);
-
-	return 0;
-}
-
-/* local version of mctp_route_alloc() */
-static struct mctp_test_route *mctp_route_test_alloc(void)
-{
-	struct mctp_test_route *rt;
-
-	rt = kzalloc(sizeof(*rt), GFP_KERNEL);
-	if (!rt)
-		return NULL;
-
-	INIT_LIST_HEAD(&rt->rt.list);
-	refcount_set(&rt->rt.refs, 1);
-	rt->rt.output = mctp_test_dst_output;
-
-	return rt;
-}
-
-static struct mctp_test_route *mctp_test_create_route(struct net *net,
-						      struct mctp_dev *dev,
-						      mctp_eid_t eid,
-						      unsigned int mtu)
-{
-	struct mctp_test_route *rt;
-
-	rt = mctp_route_test_alloc();
-	if (!rt)
-		return NULL;
-
-	rt->rt.min = eid;
-	rt->rt.max = eid;
-	rt->rt.mtu = mtu;
-	rt->rt.type = RTN_UNSPEC;
-	if (dev)
-		mctp_dev_hold(dev);
-	rt->rt.dev = dev;
-
-	list_add_rcu(&rt->rt.list, &net->mctp.routes);
-
-	return rt;
-}
-
-/* Convenience function for our test dst; release with mctp_test_dst_release()
- */
-static void mctp_test_dst_setup(struct kunit *test, struct mctp_dst *dst,
-				struct mctp_test_dev *dev,
-				struct mctp_test_pktqueue *tpq,
-				unsigned int mtu)
-{
-	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);
-
-	memset(dst, 0, sizeof(*dst));
-
-	dst->dev = dev->mdev;
-	__mctp_dev_get(dst->dev->dev);
-	dst->mtu = mtu;
-	dst->output = mctp_test_dst_output;
-	mctp_test_pktqueue_init(tpq);
-	test->priv = tpq;
-}
-
-static void mctp_test_dst_release(struct mctp_dst *dst,
-				  struct mctp_test_pktqueue *tpq)
-{
-	mctp_dst_release(dst);
-	skb_queue_purge(&tpq->pkts);
-}
-
-static void mctp_test_route_destroy(struct kunit *test,
-				    struct mctp_test_route *rt)
-{
-	unsigned int refs;
-
-	rtnl_lock();
-	list_del_rcu(&rt->rt.list);
-	rtnl_unlock();
-
-	if (rt->rt.dev)
-		mctp_dev_put(rt->rt.dev);
-
-	refs = refcount_read(&rt->rt.refs);
-	KUNIT_ASSERT_EQ_MSG(test, refs, 1, "route ref imbalance");
-
-	kfree_rcu(&rt->rt, rcu);
-}
-
-static void mctp_test_skb_set_dev(struct sk_buff *skb,
-				  struct mctp_test_dev *dev)
-{
-	struct mctp_skb_cb *cb;
-
-	cb = mctp_cb(skb);
-	cb->net = READ_ONCE(dev->mdev->net);
-	skb->dev = dev->ndev;
-}
-
-static struct sk_buff *mctp_test_create_skb(const struct mctp_hdr *hdr,
-					    unsigned int data_len)
-{
-	size_t hdr_len = sizeof(*hdr);
-	struct sk_buff *skb;
-	unsigned int i;
-	u8 *buf;
-
-	skb = alloc_skb(hdr_len + data_len, GFP_KERNEL);
-	if (!skb)
-		return NULL;
-
-	__mctp_cb(skb);
-	memcpy(skb_put(skb, hdr_len), hdr, hdr_len);
-
-	buf = skb_put(skb, data_len);
-	for (i = 0; i < data_len; i++)
-		buf[i] = i & 0xff;
-
-	return skb;
-}
-
-static struct sk_buff *__mctp_test_create_skb_data(const struct mctp_hdr *hdr,
-						   const void *data,
-						   size_t data_len)
-{
-	size_t hdr_len = sizeof(*hdr);
-	struct sk_buff *skb;
-
-	skb = alloc_skb(hdr_len + data_len, GFP_KERNEL);
-	if (!skb)
-		return NULL;
-
-	__mctp_cb(skb);
-	memcpy(skb_put(skb, hdr_len), hdr, hdr_len);
-	memcpy(skb_put(skb, data_len), data, data_len);
-
-	return skb;
-}
-
 #define mctp_test_create_skb_data(h, d) \
 	__mctp_test_create_skb_data(h, d, sizeof(*d))
 
diff --git a/net/mctp/test/utils.c b/net/mctp/test/utils.c
index 26dce14dc7f246f03ff66e5b84274b33c48baf0e..6b4dc40d882c912575e28dfd8f2e730bf346885f 100644
--- a/net/mctp/test/utils.c
+++ b/net/mctp/test/utils.c
@@ -82,3 +82,153 @@ void mctp_test_destroy_dev(struct mctp_test_dev *dev)
 	mctp_dev_put(dev->mdev);
 	unregister_netdev(dev->ndev);
 }
+
+static const unsigned int test_pktqueue_magic = 0x5f713aef;
+
+void mctp_test_pktqueue_init(struct mctp_test_pktqueue *tpq)
+{
+	tpq->magic = test_pktqueue_magic;
+	skb_queue_head_init(&tpq->pkts);
+}
+
+static int mctp_test_dst_output(struct mctp_dst *dst, struct sk_buff *skb)
+{
+	struct kunit *test = current->kunit_test;
+	struct mctp_test_pktqueue *tpq = test->priv;
+
+	KUNIT_ASSERT_EQ(test, tpq->magic, test_pktqueue_magic);
+
+	skb_queue_tail(&tpq->pkts, skb);
+
+	return 0;
+}
+
+/* local version of mctp_route_alloc() */
+static struct mctp_test_route *mctp_route_test_alloc(void)
+{
+	struct mctp_test_route *rt;
+
+	rt = kzalloc(sizeof(*rt), GFP_KERNEL);
+	if (!rt)
+		return NULL;
+
+	INIT_LIST_HEAD(&rt->rt.list);
+	refcount_set(&rt->rt.refs, 1);
+	rt->rt.output = mctp_test_dst_output;
+
+	return rt;
+}
+
+struct mctp_test_route *mctp_test_create_route(struct net *net,
+					       struct mctp_dev *dev,
+					       mctp_eid_t eid,
+					       unsigned int mtu)
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
+	if (dev)
+		mctp_dev_hold(dev);
+	rt->rt.dev = dev;
+
+	list_add_rcu(&rt->rt.list, &net->mctp.routes);
+
+	return rt;
+}
+
+/* Convenience function for our test dst; release with mctp_test_dst_release()
+ */
+void mctp_test_dst_setup(struct kunit *test, struct mctp_dst *dst,
+			 struct mctp_test_dev *dev,
+			 struct mctp_test_pktqueue *tpq, unsigned int mtu)
+{
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, dev);
+
+	memset(dst, 0, sizeof(*dst));
+
+	dst->dev = dev->mdev;
+	__mctp_dev_get(dst->dev->dev);
+	dst->mtu = mtu;
+	dst->output = mctp_test_dst_output;
+	mctp_test_pktqueue_init(tpq);
+	test->priv = tpq;
+}
+
+void mctp_test_dst_release(struct mctp_dst *dst,
+			   struct mctp_test_pktqueue *tpq)
+{
+	mctp_dst_release(dst);
+	skb_queue_purge(&tpq->pkts);
+}
+
+void mctp_test_route_destroy(struct kunit *test, struct mctp_test_route *rt)
+{
+	unsigned int refs;
+
+	rtnl_lock();
+	list_del_rcu(&rt->rt.list);
+	rtnl_unlock();
+
+	if (rt->rt.dev)
+		mctp_dev_put(rt->rt.dev);
+
+	refs = refcount_read(&rt->rt.refs);
+	KUNIT_ASSERT_EQ_MSG(test, refs, 1, "route ref imbalance");
+
+	kfree_rcu(&rt->rt, rcu);
+}
+
+void mctp_test_skb_set_dev(struct sk_buff *skb, struct mctp_test_dev *dev)
+{
+	struct mctp_skb_cb *cb;
+
+	cb = mctp_cb(skb);
+	cb->net = READ_ONCE(dev->mdev->net);
+	skb->dev = dev->ndev;
+}
+
+struct sk_buff *mctp_test_create_skb(const struct mctp_hdr *hdr,
+				     unsigned int data_len)
+{
+	size_t hdr_len = sizeof(*hdr);
+	struct sk_buff *skb;
+	unsigned int i;
+	u8 *buf;
+
+	skb = alloc_skb(hdr_len + data_len, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	__mctp_cb(skb);
+	memcpy(skb_put(skb, hdr_len), hdr, hdr_len);
+
+	buf = skb_put(skb, data_len);
+	for (i = 0; i < data_len; i++)
+		buf[i] = i & 0xff;
+
+	return skb;
+}
+
+struct sk_buff *__mctp_test_create_skb_data(const struct mctp_hdr *hdr,
+					    const void *data, size_t data_len)
+{
+	size_t hdr_len = sizeof(*hdr);
+	struct sk_buff *skb;
+
+	skb = alloc_skb(hdr_len + data_len, GFP_KERNEL);
+	if (!skb)
+		return NULL;
+
+	__mctp_cb(skb);
+	memcpy(skb_put(skb, hdr_len), hdr, hdr_len);
+	memcpy(skb_put(skb, data_len), data, data_len);
+
+	return skb;
+}
diff --git a/net/mctp/test/utils.h b/net/mctp/test/utils.h
index c702f4a6b5ff9f2de06f6a6bfee0c3653abfdefd..9405ca89d7032d65fbfb92503fbeb884ebd8bd25 100644
--- a/net/mctp/test/utils.h
+++ b/net/mctp/test/utils.h
@@ -5,6 +5,9 @@
 
 #include <uapi/linux/netdevice.h>
 
+#include <net/mctp.h>
+#include <net/mctpdevice.h>
+
 #include <kunit/test.h>
 
 #define MCTP_DEV_TEST_MTU	68
@@ -19,9 +22,38 @@ struct mctp_test_dev {
 
 struct mctp_test_dev;
 
+struct mctp_test_route {
+	struct mctp_route	rt;
+};
+
+struct mctp_test_pktqueue {
+	unsigned int magic;
+	struct sk_buff_head pkts;
+};
+
 struct mctp_test_dev *mctp_test_create_dev(void);
 struct mctp_test_dev *mctp_test_create_dev_lladdr(unsigned short lladdr_len,
 						  const unsigned char *lladdr);
 void mctp_test_destroy_dev(struct mctp_test_dev *dev);
 
+struct mctp_test_route *mctp_test_create_route(struct net *net,
+					       struct mctp_dev *dev,
+					       mctp_eid_t eid,
+					       unsigned int mtu);
+void mctp_test_dst_setup(struct kunit *test, struct mctp_dst *dst,
+			 struct mctp_test_dev *dev,
+			 struct mctp_test_pktqueue *tpq, unsigned int mtu);
+void mctp_test_dst_release(struct mctp_dst *dst,
+			   struct mctp_test_pktqueue *tpq);
+void mctp_test_pktqueue_init(struct mctp_test_pktqueue *tpq);
+void mctp_test_route_destroy(struct kunit *test, struct mctp_test_route *rt);
+void mctp_test_skb_set_dev(struct sk_buff *skb, struct mctp_test_dev *dev);
+struct sk_buff *mctp_test_create_skb(const struct mctp_hdr *hdr,
+				     unsigned int data_len);
+struct sk_buff *__mctp_test_create_skb_data(const struct mctp_hdr *hdr,
+					    const void *data, size_t data_len);
+
+#define mctp_test_create_skb_data(h, d) \
+	__mctp_test_create_skb_data(h, d, sizeof(*d))
+
 #endif /* __NET_MCTP_TEST_UTILS_H */

-- 
2.39.5



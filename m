Return-Path: <netdev+bounces-29267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35CE27825A0
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 10:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65FE11C208C6
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 08:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D29E61C10;
	Mon, 21 Aug 2023 08:37:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A2D20EE
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 08:37:44 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4723E7
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 01:37:12 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.55])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RTm2s2TG2zNn6n;
	Mon, 21 Aug 2023 16:33:25 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 21 Aug
 2023 16:36:58 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <steffen.klassert@secunet.com>,
	<herbert@gondor.apana.org.au>, <dsahern@kernel.org>
CC: <eyal.birger@gmail.com>, <paulmck@kernel.org>, <joel@joelfernandes.org>,
	<tglx@linutronix.de>, <mbizon@freebox.fr>, <jmaxwell37@gmail.com>,
	<weiyongjun1@huawei.com>, <yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next] net: remove unnecessary input parameter 'how' in ifdown function
Date: Mon, 21 Aug 2023 16:41:04 +0800
Message-ID: <20230821084104.3812233-1-shaozhengchao@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

When the ifdown function in the dst_ops structure is referenced, the input
parameter 'how' is always true. In the current implementation of the
ifdown interface, ip6_dst_ifdown does not use the input parameter 'how',
xfrm6_dst_ifdown and xfrm4_dst_ifdown functions use the input parameter
'unregister'. But false judgment on 'unregister' in xfrm6_dst_ifdown and
xfrm4_dst_ifdown is false, so remove the input parameter 'how' in ifdown
function.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 include/net/dst_ops.h   |  2 +-
 net/core/dst.c          |  2 +-
 net/ipv4/xfrm4_policy.c | 11 +----------
 net/ipv6/route.c        |  5 ++---
 net/ipv6/xfrm6_policy.c |  6 +-----
 5 files changed, 6 insertions(+), 20 deletions(-)

diff --git a/include/net/dst_ops.h b/include/net/dst_ops.h
index 632086b2f644..6d1c8541183d 100644
--- a/include/net/dst_ops.h
+++ b/include/net/dst_ops.h
@@ -23,7 +23,7 @@ struct dst_ops {
 	u32 *			(*cow_metrics)(struct dst_entry *, unsigned long);
 	void			(*destroy)(struct dst_entry *);
 	void			(*ifdown)(struct dst_entry *,
-					  struct net_device *dev, int how);
+					  struct net_device *dev);
 	struct dst_entry *	(*negative_advice)(struct dst_entry *);
 	void			(*link_failure)(struct sk_buff *);
 	void			(*update_pmtu)(struct dst_entry *dst, struct sock *sk,
diff --git a/net/core/dst.c b/net/core/dst.c
index 79d9306ad1ee..980e2fd2f013 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -152,7 +152,7 @@ void dst_dev_put(struct dst_entry *dst)
 
 	dst->obsolete = DST_OBSOLETE_DEAD;
 	if (dst->ops->ifdown)
-		dst->ops->ifdown(dst, dev, true);
+		dst->ops->ifdown(dst, dev);
 	dst->input = dst_discard;
 	dst->output = dst_discard_out;
 	dst->dev = blackhole_netdev;
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 57ea394ffa8c..c33bca2c3841 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -124,22 +124,13 @@ static void xfrm4_dst_destroy(struct dst_entry *dst)
 	xfrm_dst_destroy(xdst);
 }
 
-static void xfrm4_dst_ifdown(struct dst_entry *dst, struct net_device *dev,
-			     int unregister)
-{
-	if (!unregister)
-		return;
-
-	xfrm_dst_ifdown(dst, dev);
-}
-
 static struct dst_ops xfrm4_dst_ops_template = {
 	.family =		AF_INET,
 	.update_pmtu =		xfrm4_update_pmtu,
 	.redirect =		xfrm4_redirect,
 	.cow_metrics =		dst_cow_metrics_generic,
 	.destroy =		xfrm4_dst_destroy,
-	.ifdown =		xfrm4_dst_ifdown,
+	.ifdown =		xfrm_dst_ifdown,
 	.local_out =		__ip_local_out,
 	.gc_thresh =		32768,
 };
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 6b46abe0b7da..e82bcfde5bf9 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -90,7 +90,7 @@ unsigned int		ip6_mtu(const struct dst_entry *dst);
 static struct dst_entry *ip6_negative_advice(struct dst_entry *);
 static void		ip6_dst_destroy(struct dst_entry *);
 static void		ip6_dst_ifdown(struct dst_entry *,
-				       struct net_device *dev, int how);
+				       struct net_device *dev);
 static void		 ip6_dst_gc(struct dst_ops *ops);
 
 static int		ip6_pkt_discard(struct sk_buff *skb);
@@ -371,8 +371,7 @@ static void ip6_dst_destroy(struct dst_entry *dst)
 	fib6_info_release(from);
 }
 
-static void ip6_dst_ifdown(struct dst_entry *dst, struct net_device *dev,
-			   int how)
+static void ip6_dst_ifdown(struct dst_entry *dst, struct net_device *dev)
 {
 	struct rt6_info *rt = (struct rt6_info *)dst;
 	struct inet6_dev *idev = rt->rt6i_idev;
diff --git a/net/ipv6/xfrm6_policy.c b/net/ipv6/xfrm6_policy.c
index 8f931e46b460..41a680c76d2e 100644
--- a/net/ipv6/xfrm6_policy.c
+++ b/net/ipv6/xfrm6_policy.c
@@ -124,14 +124,10 @@ static void xfrm6_dst_destroy(struct dst_entry *dst)
 	xfrm_dst_destroy(xdst);
 }
 
-static void xfrm6_dst_ifdown(struct dst_entry *dst, struct net_device *dev,
-			     int unregister)
+static void xfrm6_dst_ifdown(struct dst_entry *dst, struct net_device *dev)
 {
 	struct xfrm_dst *xdst;
 
-	if (!unregister)
-		return;
-
 	xdst = (struct xfrm_dst *)dst;
 	if (xdst->u.rt6.rt6i_idev->dev == dev) {
 		struct inet6_dev *loopback_idev =
-- 
2.34.1



Return-Path: <netdev+bounces-32814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E3B079A801
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 14:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F02D1C20433
	for <lists+netdev@lfdr.de>; Mon, 11 Sep 2023 12:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE570F9D3;
	Mon, 11 Sep 2023 12:47:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D0E24432
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 12:47:42 +0000 (UTC)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 292F6CEB
	for <netdev@vger.kernel.org>; Mon, 11 Sep 2023 05:47:40 -0700 (PDT)
Received: from dggpeml500026.china.huawei.com (unknown [172.30.72.57])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RkmdK00zjzTmJf;
	Mon, 11 Sep 2023 20:44:52 +0800 (CST)
Received: from huawei.com (10.175.101.6) by dggpeml500026.china.huawei.com
 (7.185.36.106) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Mon, 11 Sep
 2023 20:47:36 +0800
From: Zhengchao Shao <shaozhengchao@huawei.com>
To: <netdev@vger.kernel.org>, <dev@openvswitch.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<dsahern@kernel.org>, <pshelar@ovn.org>, <jhs@mojatatu.com>,
	<xiyou.wangcong@gmail.com>, <jiri@resnulli.us>,
	<steffen.klassert@secunet.com>, <herbert@gondor.apana.org.au>
CC: <jmaxwell37@gmail.com>, <tglx@linutronix.de>, <mbizon@freebox.fr>,
	<joel@joelfernandes.org>, <eyal.birger@gmail.com>, <weiyongjun1@huawei.com>,
	<yuehaibing@huawei.com>, <shaozhengchao@huawei.com>
Subject: [PATCH net-next] net: dst: remove unnecessary input parameter in dst_alloc and dst_init
Date: Mon, 11 Sep 2023 20:50:45 +0800
Message-ID: <20230911125045.346390-1-shaozhengchao@huawei.com>
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
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500026.china.huawei.com (7.185.36.106)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Since commit 1202cdd66531("Remove DECnet support from kernel") has been
merged, all callers pass in the initial_ref value of 1 when they call
dst_alloc(). Therefore, remove initial_ref when the dst_alloc() is
declared and replace initial_ref with 1 in dst_alloc().
Also when all callers call dst_init(), the value of initial_ref is 1.
Therefore, remove the input parameter initial_ref of the dst_init() and
replace initial_ref with the value 1 in dst_init.

Signed-off-by: Zhengchao Shao <shaozhengchao@huawei.com>
---
 include/net/dst.h         |  4 ++--
 net/core/dst.c            | 10 +++++-----
 net/ipv4/route.c          |  6 +++---
 net/ipv6/route.c          |  4 ++--
 net/openvswitch/actions.c |  4 ++--
 net/sched/sch_frag.c      |  4 ++--
 net/xfrm/xfrm_policy.c    |  2 +-
 7 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/include/net/dst.h b/include/net/dst.h
index 78884429deed..f8b8599a0600 100644
--- a/include/net/dst.h
+++ b/include/net/dst.h
@@ -392,10 +392,10 @@ static inline int dst_discard(struct sk_buff *skb)
 {
 	return dst_discard_out(&init_net, skb->sk, skb);
 }
-void *dst_alloc(struct dst_ops *ops, struct net_device *dev, int initial_ref,
+void *dst_alloc(struct dst_ops *ops, struct net_device *dev,
 		int initial_obsolete, unsigned short flags);
 void dst_init(struct dst_entry *dst, struct dst_ops *ops,
-	      struct net_device *dev, int initial_ref, int initial_obsolete,
+	      struct net_device *dev, int initial_obsolete,
 	      unsigned short flags);
 struct dst_entry *dst_destroy(struct dst_entry *dst);
 void dst_dev_put(struct dst_entry *dst);
diff --git a/net/core/dst.c b/net/core/dst.c
index 980e2fd2f013..6838d3212c37 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -45,7 +45,7 @@ const struct dst_metrics dst_default_metrics = {
 EXPORT_SYMBOL(dst_default_metrics);
 
 void dst_init(struct dst_entry *dst, struct dst_ops *ops,
-	      struct net_device *dev, int initial_ref, int initial_obsolete,
+	      struct net_device *dev, int initial_obsolete,
 	      unsigned short flags)
 {
 	dst->dev = dev;
@@ -66,7 +66,7 @@ void dst_init(struct dst_entry *dst, struct dst_ops *ops,
 	dst->tclassid = 0;
 #endif
 	dst->lwtstate = NULL;
-	rcuref_init(&dst->__rcuref, initial_ref);
+	rcuref_init(&dst->__rcuref, 1);
 	INIT_LIST_HEAD(&dst->rt_uncached);
 	dst->__use = 0;
 	dst->lastuse = jiffies;
@@ -77,7 +77,7 @@ void dst_init(struct dst_entry *dst, struct dst_ops *ops,
 EXPORT_SYMBOL(dst_init);
 
 void *dst_alloc(struct dst_ops *ops, struct net_device *dev,
-		int initial_ref, int initial_obsolete, unsigned short flags)
+		int initial_obsolete, unsigned short flags)
 {
 	struct dst_entry *dst;
 
@@ -90,7 +90,7 @@ void *dst_alloc(struct dst_ops *ops, struct net_device *dev,
 	if (!dst)
 		return NULL;
 
-	dst_init(dst, ops, dev, initial_ref, initial_obsolete, flags);
+	dst_init(dst, ops, dev, initial_obsolete, flags);
 
 	return dst;
 }
@@ -270,7 +270,7 @@ static void __metadata_dst_init(struct metadata_dst *md_dst,
 	struct dst_entry *dst;
 
 	dst = &md_dst->dst;
-	dst_init(dst, &dst_blackhole_ops, NULL, 1, DST_OBSOLETE_NONE,
+	dst_init(dst, &dst_blackhole_ops, NULL, DST_OBSOLETE_NONE,
 		 DST_METADATA | DST_NOCOUNT);
 	memset(dst + 1, 0, sizeof(*md_dst) + optslen - sizeof(*dst));
 	md_dst->type = type;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 66f419e7f9a7..fb3045692b99 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1630,7 +1630,7 @@ struct rtable *rt_dst_alloc(struct net_device *dev,
 {
 	struct rtable *rt;
 
-	rt = dst_alloc(&ipv4_dst_ops, dev, 1, DST_OBSOLETE_FORCE_CHK,
+	rt = dst_alloc(&ipv4_dst_ops, dev, DST_OBSOLETE_FORCE_CHK,
 		       (noxfrm ? DST_NOXFRM : 0));
 
 	if (rt) {
@@ -1658,7 +1658,7 @@ struct rtable *rt_dst_clone(struct net_device *dev, struct rtable *rt)
 {
 	struct rtable *new_rt;
 
-	new_rt = dst_alloc(&ipv4_dst_ops, dev, 1, DST_OBSOLETE_FORCE_CHK,
+	new_rt = dst_alloc(&ipv4_dst_ops, dev, DST_OBSOLETE_FORCE_CHK,
 			   rt->dst.flags);
 
 	if (new_rt) {
@@ -2832,7 +2832,7 @@ struct dst_entry *ipv4_blackhole_route(struct net *net, struct dst_entry *dst_or
 	struct rtable *ort = (struct rtable *) dst_orig;
 	struct rtable *rt;
 
-	rt = dst_alloc(&ipv4_dst_blackhole_ops, NULL, 1, DST_OBSOLETE_DEAD, 0);
+	rt = dst_alloc(&ipv4_dst_blackhole_ops, NULL, DST_OBSOLETE_DEAD, 0);
 	if (rt) {
 		struct dst_entry *new = &rt->dst;
 
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 9c687b357e6a..9d8dfc7423e4 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -341,7 +341,7 @@ struct rt6_info *ip6_dst_alloc(struct net *net, struct net_device *dev,
 			       int flags)
 {
 	struct rt6_info *rt = dst_alloc(&net->ipv6.ip6_dst_ops, dev,
-					1, DST_OBSOLETE_FORCE_CHK, flags);
+					DST_OBSOLETE_FORCE_CHK, flags);
 
 	if (rt) {
 		rt6_info_init(rt);
@@ -2655,7 +2655,7 @@ struct dst_entry *ip6_blackhole_route(struct net *net, struct dst_entry *dst_ori
 	struct net_device *loopback_dev = net->loopback_dev;
 	struct dst_entry *new = NULL;
 
-	rt = dst_alloc(&ip6_dst_blackhole_ops, loopback_dev, 1,
+	rt = dst_alloc(&ip6_dst_blackhole_ops, loopback_dev,
 		       DST_OBSOLETE_DEAD, 0);
 	if (rt) {
 		rt6_info_init(rt);
diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index fd66014d8a76..5f8094acd056 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -873,7 +873,7 @@ static void ovs_fragment(struct net *net, struct vport *vport,
 
 		prepare_frag(vport, skb, orig_network_offset,
 			     ovs_key_mac_proto(key));
-		dst_init(&ovs_rt.dst, &ovs_dst_ops, NULL, 1,
+		dst_init(&ovs_rt.dst, &ovs_dst_ops, NULL,
 			 DST_OBSOLETE_NONE, DST_NOCOUNT);
 		ovs_rt.dst.dev = vport->dev;
 
@@ -890,7 +890,7 @@ static void ovs_fragment(struct net *net, struct vport *vport,
 		prepare_frag(vport, skb, orig_network_offset,
 			     ovs_key_mac_proto(key));
 		memset(&ovs_rt, 0, sizeof(ovs_rt));
-		dst_init(&ovs_rt.dst, &ovs_dst_ops, NULL, 1,
+		dst_init(&ovs_rt.dst, &ovs_dst_ops, NULL,
 			 DST_OBSOLETE_NONE, DST_NOCOUNT);
 		ovs_rt.dst.dev = vport->dev;
 
diff --git a/net/sched/sch_frag.c b/net/sched/sch_frag.c
index a9bd0a235890..ce63414185fd 100644
--- a/net/sched/sch_frag.c
+++ b/net/sched/sch_frag.c
@@ -96,7 +96,7 @@ static int sch_fragment(struct net *net, struct sk_buff *skb,
 		unsigned long orig_dst;
 
 		sch_frag_prepare_frag(skb, xmit);
-		dst_init(&sch_frag_rt.dst, &sch_frag_dst_ops, NULL, 1,
+		dst_init(&sch_frag_rt.dst, &sch_frag_dst_ops, NULL,
 			 DST_OBSOLETE_NONE, DST_NOCOUNT);
 		sch_frag_rt.dst.dev = skb->dev;
 
@@ -112,7 +112,7 @@ static int sch_fragment(struct net *net, struct sk_buff *skb,
 
 		sch_frag_prepare_frag(skb, xmit);
 		memset(&sch_frag_rt, 0, sizeof(sch_frag_rt));
-		dst_init(&sch_frag_rt.dst, &sch_frag_dst_ops, NULL, 1,
+		dst_init(&sch_frag_rt.dst, &sch_frag_dst_ops, NULL,
 			 DST_OBSOLETE_NONE, DST_NOCOUNT);
 		sch_frag_rt.dst.dev = skb->dev;
 
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 113fb7e9cdaf..d33af072df39 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2568,7 +2568,7 @@ static inline struct xfrm_dst *xfrm_alloc_dst(struct net *net, int family)
 	default:
 		BUG();
 	}
-	xdst = dst_alloc(dst_ops, NULL, 1, DST_OBSOLETE_NONE, 0);
+	xdst = dst_alloc(dst_ops, NULL, DST_OBSOLETE_NONE, 0);
 
 	if (likely(xdst)) {
 		memset_after(xdst, 0, u.dst);
-- 
2.34.1



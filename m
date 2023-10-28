Return-Path: <netdev+bounces-44983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CE9D27DA5EA
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 10:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 841AB2826E0
	for <lists+netdev@lfdr.de>; Sat, 28 Oct 2023 08:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ED76C140;
	Sat, 28 Oct 2023 08:43:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11A669476
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 08:43:39 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7F8124
	for <netdev@vger.kernel.org>; Sat, 28 Oct 2023 01:43:38 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id D5E5320758;
	Sat, 28 Oct 2023 10:43:36 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ybOGcBmlLL30; Sat, 28 Oct 2023 10:43:35 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 3338620520;
	Sat, 28 Oct 2023 10:43:33 +0200 (CEST)
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 2767180004A;
	Sat, 28 Oct 2023 10:43:33 +0200 (CEST)
Received: from mbx-essen-02.secunet.de (10.53.40.198) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Sat, 28 Oct 2023 10:43:32 +0200
Received: from gauss2.secunet.de (10.182.7.193) by mbx-essen-02.secunet.de
 (10.53.40.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Sat, 28 Oct
 2023 10:43:31 +0200
Received: by gauss2.secunet.de (Postfix, from userid 1000)
	id 5AA1E3183D8C; Sat, 28 Oct 2023 10:43:31 +0200 (CEST)
From: Steffen Klassert <steffen.klassert@secunet.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
CC: Herbert Xu <herbert@gondor.apana.org.au>, Steffen Klassert
	<steffen.klassert@secunet.com>, <netdev@vger.kernel.org>
Subject: [PATCH 06/10] xfrm: pass struct net to xfrm_decode_session wrappers
Date: Sat, 28 Oct 2023 10:43:24 +0200
Message-ID: <20231028084328.3119236-7-steffen.klassert@secunet.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231028084328.3119236-1-steffen.klassert@secunet.com>
References: <20231028084328.3119236-1-steffen.klassert@secunet.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: cas-essen-01.secunet.de (10.53.40.201) To
 mbx-essen-02.secunet.de (10.53.40.198)
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

From: Florian Westphal <fw@strlen.de>

Preparation patch, extra arg is not used.
No functional changes intended.

This is needed to replace the xfrm session decode functions with
the flow dissector.

skb_flow_dissect() cannot be used as-is, because it attempts to deduce the
'struct net' to use for bpf program fetch from skb->sk or skb->dev, but
xfrm code path can see skbs that have neither sk or dev filled in.

So either flow dissector needs to try harder, e.g. by also trying
skb->dst->dev, or we have to pass the struct net explicitly.

Passing the struct net doesn't look too bad to me, most places
already have it available or can derive it from the output device.

Reported-by: kernel test robot <oliver.sang@intel.com>
Link: https://lore.kernel.org/netdev/202309271628.27fd2187-oliver.sang@intel.com/
Signed-off-by: Florian Westphal <fw@strlen.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
---
 include/net/xfrm.h             | 12 ++++++------
 net/ipv4/icmp.c                |  2 +-
 net/ipv4/ip_vti.c              |  4 ++--
 net/ipv4/netfilter.c           |  2 +-
 net/ipv6/icmp.c                |  2 +-
 net/ipv6/ip6_vti.c             |  4 ++--
 net/ipv6/netfilter.c           |  2 +-
 net/netfilter/nf_nat_proto.c   |  2 +-
 net/xfrm/xfrm_interface_core.c |  4 ++--
 net/xfrm/xfrm_policy.c         | 10 +++++-----
 10 files changed, 22 insertions(+), 22 deletions(-)

diff --git a/include/net/xfrm.h b/include/net/xfrm.h
index 4681ecfb85ac..c9bb0f892f55 100644
--- a/include/net/xfrm.h
+++ b/include/net/xfrm.h
@@ -1207,20 +1207,20 @@ static inline int xfrm6_policy_check_reverse(struct sock *sk, int dir,
 	return __xfrm_policy_check2(sk, dir, skb, AF_INET6, 1);
 }
 
-int __xfrm_decode_session(struct sk_buff *skb, struct flowi *fl,
+int __xfrm_decode_session(struct net *net, struct sk_buff *skb, struct flowi *fl,
 			  unsigned int family, int reverse);
 
-static inline int xfrm_decode_session(struct sk_buff *skb, struct flowi *fl,
+static inline int xfrm_decode_session(struct net *net, struct sk_buff *skb, struct flowi *fl,
 				      unsigned int family)
 {
-	return __xfrm_decode_session(skb, fl, family, 0);
+	return __xfrm_decode_session(net, skb, fl, family, 0);
 }
 
-static inline int xfrm_decode_session_reverse(struct sk_buff *skb,
+static inline int xfrm_decode_session_reverse(struct net *net, struct sk_buff *skb,
 					      struct flowi *fl,
 					      unsigned int family)
 {
-	return __xfrm_decode_session(skb, fl, family, 1);
+	return __xfrm_decode_session(net, skb, fl, family, 1);
 }
 
 int __xfrm_route_forward(struct sk_buff *skb, unsigned short family);
@@ -1296,7 +1296,7 @@ static inline int xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *sk
 {
 	return 1;
 }
-static inline int xfrm_decode_session_reverse(struct sk_buff *skb,
+static inline int xfrm_decode_session_reverse(struct net *net, struct sk_buff *skb,
 					      struct flowi *fl,
 					      unsigned int family)
 {
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index b8607763d113..e63a3bf99617 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -517,7 +517,7 @@ static struct rtable *icmp_route_lookup(struct net *net,
 	} else
 		return rt;
 
-	err = xfrm_decode_session_reverse(skb_in, flowi4_to_flowi(&fl4_dec), AF_INET);
+	err = xfrm_decode_session_reverse(net, skb_in, flowi4_to_flowi(&fl4_dec), AF_INET);
 	if (err)
 		goto relookup_failed;
 
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index d1e7d0ceb7ed..9ab9b3ebe0cd 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -288,11 +288,11 @@ static netdev_tx_t vti_tunnel_xmit(struct sk_buff *skb, struct net_device *dev)
 	switch (skb->protocol) {
 	case htons(ETH_P_IP):
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
-		xfrm_decode_session(skb, &fl, AF_INET);
+		xfrm_decode_session(dev_net(dev), skb, &fl, AF_INET);
 		break;
 	case htons(ETH_P_IPV6):
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
-		xfrm_decode_session(skb, &fl, AF_INET6);
+		xfrm_decode_session(dev_net(dev), skb, &fl, AF_INET6);
 		break;
 	default:
 		goto tx_err;
diff --git a/net/ipv4/netfilter.c b/net/ipv4/netfilter.c
index bd135165482a..591a2737808e 100644
--- a/net/ipv4/netfilter.c
+++ b/net/ipv4/netfilter.c
@@ -62,7 +62,7 @@ int ip_route_me_harder(struct net *net, struct sock *sk, struct sk_buff *skb, un
 
 #ifdef CONFIG_XFRM
 	if (!(IPCB(skb)->flags & IPSKB_XFRM_TRANSFORMED) &&
-	    xfrm_decode_session(skb, flowi4_to_flowi(&fl4), AF_INET) == 0) {
+	    xfrm_decode_session(net, skb, flowi4_to_flowi(&fl4), AF_INET) == 0) {
 		struct dst_entry *dst = skb_dst(skb);
 		skb_dst_set(skb, NULL);
 		dst = xfrm_lookup(net, dst, flowi4_to_flowi(&fl4), sk, 0);
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 8fb4a791881a..f62427097126 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -385,7 +385,7 @@ static struct dst_entry *icmpv6_route_lookup(struct net *net,
 			return dst;
 	}
 
-	err = xfrm_decode_session_reverse(skb, flowi6_to_flowi(&fl2), AF_INET6);
+	err = xfrm_decode_session_reverse(net, skb, flowi6_to_flowi(&fl2), AF_INET6);
 	if (err)
 		goto relookup_failed;
 
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 73c85d4e0e9c..e550240c85e1 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -569,11 +569,11 @@ vti6_tnl_xmit(struct sk_buff *skb, struct net_device *dev)
 			goto tx_err;
 
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
-		xfrm_decode_session(skb, &fl, AF_INET6);
+		xfrm_decode_session(dev_net(dev), skb, &fl, AF_INET6);
 		break;
 	case htons(ETH_P_IP):
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
-		xfrm_decode_session(skb, &fl, AF_INET);
+		xfrm_decode_session(dev_net(dev), skb, &fl, AF_INET);
 		break;
 	default:
 		goto tx_err;
diff --git a/net/ipv6/netfilter.c b/net/ipv6/netfilter.c
index 857713d7a38a..53d255838e6a 100644
--- a/net/ipv6/netfilter.c
+++ b/net/ipv6/netfilter.c
@@ -61,7 +61,7 @@ int ip6_route_me_harder(struct net *net, struct sock *sk_partial, struct sk_buff
 
 #ifdef CONFIG_XFRM
 	if (!(IP6CB(skb)->flags & IP6SKB_XFRM_TRANSFORMED) &&
-	    xfrm_decode_session(skb, flowi6_to_flowi(&fl6), AF_INET6) == 0) {
+	    xfrm_decode_session(net, skb, flowi6_to_flowi(&fl6), AF_INET6) == 0) {
 		skb_dst_set(skb, NULL);
 		dst = xfrm_lookup(net, dst, flowi6_to_flowi(&fl6), sk, 0);
 		if (IS_ERR(dst))
diff --git a/net/netfilter/nf_nat_proto.c b/net/netfilter/nf_nat_proto.c
index 48cc60084d28..c77963517bf8 100644
--- a/net/netfilter/nf_nat_proto.c
+++ b/net/netfilter/nf_nat_proto.c
@@ -668,7 +668,7 @@ static int nf_xfrm_me_harder(struct net *net, struct sk_buff *skb, unsigned int
 	struct flowi fl;
 	int err;
 
-	err = xfrm_decode_session(skb, &fl, family);
+	err = xfrm_decode_session(net, skb, &fl, family);
 	if (err < 0)
 		return err;
 
diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index b86474084690..656f437f5f53 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -538,7 +538,7 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 	switch (skb->protocol) {
 	case htons(ETH_P_IPV6):
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
-		xfrm_decode_session(skb, &fl, AF_INET6);
+		xfrm_decode_session(dev_net(dev), skb, &fl, AF_INET6);
 		if (!dst) {
 			fl.u.ip6.flowi6_oif = dev->ifindex;
 			fl.u.ip6.flowi6_flags |= FLOWI_FLAG_ANYSRC;
@@ -553,7 +553,7 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 		break;
 	case htons(ETH_P_IP):
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
-		xfrm_decode_session(skb, &fl, AF_INET);
+		xfrm_decode_session(dev_net(dev), skb, &fl, AF_INET);
 		if (!dst) {
 			struct rtable *rt;
 
diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index c4c4fc29ccf5..064d1744fa36 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -2853,7 +2853,7 @@ static void xfrm_policy_queue_process(struct timer_list *t)
 	/* Fixup the mark to support VTI. */
 	skb_mark = skb->mark;
 	skb->mark = pol->mark.v;
-	xfrm_decode_session(skb, &fl, dst->ops->family);
+	xfrm_decode_session(net, skb, &fl, dst->ops->family);
 	skb->mark = skb_mark;
 	spin_unlock(&pq->hold_queue.lock);
 
@@ -2889,7 +2889,7 @@ static void xfrm_policy_queue_process(struct timer_list *t)
 		/* Fixup the mark to support VTI. */
 		skb_mark = skb->mark;
 		skb->mark = pol->mark.v;
-		xfrm_decode_session(skb, &fl, skb_dst(skb)->ops->family);
+		xfrm_decode_session(net, skb, &fl, skb_dst(skb)->ops->family);
 		skb->mark = skb_mark;
 
 		dst_hold(xfrm_dst_path(skb_dst(skb)));
@@ -3554,7 +3554,7 @@ decode_session6(struct sk_buff *skb, struct flowi *fl, bool reverse)
 }
 #endif
 
-int __xfrm_decode_session(struct sk_buff *skb, struct flowi *fl,
+int __xfrm_decode_session(struct net *net, struct sk_buff *skb, struct flowi *fl,
 			  unsigned int family, int reverse)
 {
 	switch (family) {
@@ -3618,7 +3618,7 @@ int __xfrm_policy_check(struct sock *sk, int dir, struct sk_buff *skb,
 	reverse = dir & ~XFRM_POLICY_MASK;
 	dir &= XFRM_POLICY_MASK;
 
-	if (__xfrm_decode_session(skb, &fl, family, reverse) < 0) {
+	if (__xfrm_decode_session(net, skb, &fl, family, reverse) < 0) {
 		XFRM_INC_STATS(net, LINUX_MIB_XFRMINHDRERROR);
 		return 0;
 	}
@@ -3774,7 +3774,7 @@ int __xfrm_route_forward(struct sk_buff *skb, unsigned short family)
 	struct dst_entry *dst;
 	int res = 1;
 
-	if (xfrm_decode_session(skb, &fl, family) < 0) {
+	if (xfrm_decode_session(net, skb, &fl, family) < 0) {
 		XFRM_INC_STATS(net, LINUX_MIB_XFRMFWDHDRERROR);
 		return 0;
 	}
-- 
2.34.1



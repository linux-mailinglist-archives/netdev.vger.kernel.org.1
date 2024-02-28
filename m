Return-Path: <netdev+bounces-75754-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB2E86B0F9
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:56:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D2531F21B1C
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D92715A483;
	Wed, 28 Feb 2024 13:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hyMl5jT8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D4F015958C
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 13:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709128511; cv=none; b=CJ4+FzF6Iqkn02lebiu2CIoE5uj/J8EHskk1DbHz0zZFTlEBoXp80GqI83LwgbGUUdsEyacYt8p+T/DYUHK9aV4M0I6ejiRklaWT2jj1yf3PRXfqR4Vdk3VUD1YJkhpPliN33CIgPAk6bdd7qjka4FknmqHcVDjykpxneT4V+gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709128511; c=relaxed/simple;
	bh=wex18Eq7NzjB+1akAKoSLfJsBpyZ5jQHKDwzdMxTm4I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=AtdQI6oTPpeMSeEXqJDZ2ysujnxJyjqMug4rvYO1Ad+zehOM3GCSmVv3RiAV9d0ACuI8ZL26jS/ts1CP6RMdnfL+oc8fDr+LHtzUCdAmlBFQgooVFSx1iA2gEaoZxaySEaKEvJS/IbNCjLmu/Hg767d06Iq/fUfrDR6nePrRJ/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=hyMl5jT8; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-787b8dd3330so146314985a.1
        for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 05:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709128508; x=1709733308; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=PXZ05q2LpzNbtZmOcIx147FbutypgpZF+mMinxnSZgY=;
        b=hyMl5jT88CtjNyL1NAjh3UW4P2HuFP7no/MnqIRA3jfA4bTMT2s6EO4h3ZftlCojO0
         eJlcW5ti9SlNFMcrj5EOhoc+X5+N85Hn2ph4wvL6+1ycqDGqAea4UFPMv5hDeBYIG6Pp
         iZVCWs6y/bsjRpS4P2tEQAcgQ0wFIHJIEZxkh1W0gUaRU58Sl4L9tYANKGQWkDodQyjp
         brL5ilfaDx9QTT53RMgPMqRWSn7zPvAABRHfErKFwWT4NW3ct5m+FTVMC2WmnHG5/3bg
         VyQIGdkOm7cpLqqrfgprZ+pWkJsDiHOqh5R3M5uF1kIBM7wSV8kPIqg8lC78VW2u8JUG
         3vUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709128508; x=1709733308;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PXZ05q2LpzNbtZmOcIx147FbutypgpZF+mMinxnSZgY=;
        b=Ew5Wvhzte3clUsYj0BOj5jkw7tG85KV4wMo9jjFzZCJZIabuBJqWCV6s28ppFyBG3p
         PvyAPMs8Krtx5g28l3kdFs1ysdoPu/d41gzsG8ATT6qDOYMFQRR8sISbmyXmpUJbD7JM
         H2IcCgm8qf1DalX7sXtT38xFZiyfsHnuHREZPLPxZF7lMyAXk+v59mTQZKN15ySUjHal
         GJOTAO4KgjElHZj/EFRZdo2UrXN+cRI0Yx53JX9z7cpu1zZmHbkj7YFBrCT3m8+vYtW1
         +rErZ0CJWye7LpST5LimdvWQlXBBN522iXK65bpKseTjWYbx+bHegn5Nf1zRpanLSPiy
         qFsQ==
X-Gm-Message-State: AOJu0YwUXTE+fOMbzPOk8Jn0KnWTC9pVOzNjIozxD6vxfueIH8gZMNRD
	1U0VGkUoYSe9jIP2boZrJOreNsinPtGcmSD130y2ovB5JkX+RDZglWhSNjj0gopTWYeQ+QTekO0
	JTXYOdMPqbA==
X-Google-Smtp-Source: AGHT+IFWA82Fh6l2ztRrXpP1xUeG7qt7tVpmGqYe/drny4h01+4Kt6Cyn/I0fOX9chFTke/jqfa7/yLcSpQAsg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:ae9:f80f:0:b0:787:f1b3:a77 with SMTP id
 x15-20020ae9f80f000000b00787f1b30a77mr17165qkh.2.1709128508421; Wed, 28 Feb
 2024 05:55:08 -0800 (PST)
Date: Wed, 28 Feb 2024 13:54:38 +0000
In-Reply-To: <20240228135439.863861-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240228135439.863861-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.rc1.240.g4c46232300-goog
Message-ID: <20240228135439.863861-15-edumazet@google.com>
Subject: [PATCH v3 net-next 14/15] ipv6/addrconf: annotate data-races around
 devconf fields (II)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Jiri Pirko <jiri@nvidia.com>, 
	David Ahern <dsahern@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Final (?) round of this series.

Annotate lockless reads on following devconf fields,
because they be changed concurrently from /proc/net/ipv6/conf.

- accept_dad
- optimistic_dad
- use_optimistic
- use_oif_addrs_only
- ra_honor_pio_life
- keep_addr_on_down
- ndisc_notify
- ndisc_evict_nocarrier
- suppress_frag_ndisc
- addr_gen_mode
- seg6_enabled
- ioam6_enabled
- ioam6_id
- ioam6_id_wide
- drop_unicast_in_l2_multicast
- mldv[12]_unsolicited_report_interval
- force_mld_version
- force_tllao
- accept_untracked_na
- drop_unsolicited_na
- accept_source_route

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
---
 net/ipv6/addrconf.c  | 49 +++++++++++++++++++++++---------------------
 net/ipv6/exthdrs.c   | 16 ++++++++-------
 net/ipv6/ioam6.c     |  8 ++++----
 net/ipv6/ip6_input.c |  2 +-
 net/ipv6/mcast.c     | 14 ++++++-------
 net/ipv6/ndisc.c     | 18 ++++++++--------
 net/ipv6/seg6_hmac.c |  8 +++++---
 7 files changed, 61 insertions(+), 54 deletions(-)

diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
index fee5cf69648bc653502df7bfaac7e5c65a43fbf2..b5c627253eb5e30a981dfd23dfc248ea00e3c557 100644
--- a/net/ipv6/addrconf.c
+++ b/net/ipv6/addrconf.c
@@ -1557,15 +1557,17 @@ static inline int ipv6_saddr_preferred(int type)
 	return 0;
 }
 
-static bool ipv6_use_optimistic_addr(struct net *net,
-				     struct inet6_dev *idev)
+static bool ipv6_use_optimistic_addr(const struct net *net,
+				     const struct inet6_dev *idev)
 {
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
 	if (!idev)
 		return false;
-	if (!net->ipv6.devconf_all->optimistic_dad && !idev->cnf.optimistic_dad)
+	if (!READ_ONCE(net->ipv6.devconf_all->optimistic_dad) &&
+	    !READ_ONCE(idev->cnf.optimistic_dad))
 		return false;
-	if (!net->ipv6.devconf_all->use_optimistic && !idev->cnf.use_optimistic)
+	if (!READ_ONCE(net->ipv6.devconf_all->use_optimistic) &&
+	    !READ_ONCE(idev->cnf.use_optimistic))
 		return false;
 
 	return true;
@@ -1574,13 +1576,14 @@ static bool ipv6_use_optimistic_addr(struct net *net,
 #endif
 }
 
-static bool ipv6_allow_optimistic_dad(struct net *net,
-				      struct inet6_dev *idev)
+static bool ipv6_allow_optimistic_dad(const struct net *net,
+				      const struct inet6_dev *idev)
 {
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
 	if (!idev)
 		return false;
-	if (!net->ipv6.devconf_all->optimistic_dad && !idev->cnf.optimistic_dad)
+	if (!READ_ONCE(net->ipv6.devconf_all->optimistic_dad) &&
+	    !READ_ONCE(idev->cnf.optimistic_dad))
 		return false;
 
 	return true;
@@ -1862,7 +1865,7 @@ int ipv6_dev_get_saddr(struct net *net, const struct net_device *dst_dev,
 		idev = __in6_dev_get(dst_dev);
 		if ((dst_type & IPV6_ADDR_MULTICAST) ||
 		    dst.scope <= IPV6_ADDR_SCOPE_LINKLOCAL ||
-		    (idev && idev->cnf.use_oif_addrs_only)) {
+		    (idev && READ_ONCE(idev->cnf.use_oif_addrs_only))) {
 			use_oif_addr = true;
 		}
 	}
@@ -2683,8 +2686,8 @@ int addrconf_prefix_rcv_add_addr(struct net *net, struct net_device *dev,
 		};
 
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
-		if ((net->ipv6.devconf_all->optimistic_dad ||
-		     in6_dev->cnf.optimistic_dad) &&
+		if ((READ_ONCE(net->ipv6.devconf_all->optimistic_dad) ||
+		     READ_ONCE(in6_dev->cnf.optimistic_dad)) &&
 		    !net->ipv6.devconf_all->forwarding && sllao)
 			cfg.ifa_flags |= IFA_F_OPTIMISTIC;
 #endif
@@ -2733,7 +2736,7 @@ int addrconf_prefix_rcv_add_addr(struct net *net, struct net_device *dev,
 		 */
 		update_lft = !create && stored_lft;
 
-		if (update_lft && !in6_dev->cnf.ra_honor_pio_life) {
+		if (update_lft && !READ_ONCE(in6_dev->cnf.ra_honor_pio_life)) {
 			const u32 minimum_lft = min_t(u32,
 				stored_lft, MIN_VALID_LIFETIME);
 			valid_lft = max(valid_lft, minimum_lft);
@@ -3317,8 +3320,8 @@ void addrconf_add_linklocal(struct inet6_dev *idev,
 	struct inet6_ifaddr *ifp;
 
 #ifdef CONFIG_IPV6_OPTIMISTIC_DAD
-	if ((dev_net(idev->dev)->ipv6.devconf_all->optimistic_dad ||
-	     idev->cnf.optimistic_dad) &&
+	if ((READ_ONCE(dev_net(idev->dev)->ipv6.devconf_all->optimistic_dad) ||
+	     READ_ONCE(idev->cnf.optimistic_dad)) &&
 	    !dev_net(idev->dev)->ipv6.devconf_all->forwarding)
 		cfg.ifa_flags |= IFA_F_OPTIMISTIC;
 #endif
@@ -3890,10 +3893,10 @@ static int addrconf_ifdown(struct net_device *dev, bool unregister)
 	 */
 	if (!unregister && !idev->cnf.disable_ipv6) {
 		/* aggregate the system setting and interface setting */
-		int _keep_addr = net->ipv6.devconf_all->keep_addr_on_down;
+		int _keep_addr = READ_ONCE(net->ipv6.devconf_all->keep_addr_on_down);
 
 		if (!_keep_addr)
-			_keep_addr = idev->cnf.keep_addr_on_down;
+			_keep_addr = READ_ONCE(idev->cnf.keep_addr_on_down);
 
 		keep_addr = (_keep_addr > 0);
 	}
@@ -4119,8 +4122,8 @@ static void addrconf_dad_begin(struct inet6_ifaddr *ifp)
 
 	net = dev_net(dev);
 	if (dev->flags&(IFF_NOARP|IFF_LOOPBACK) ||
-	    (net->ipv6.devconf_all->accept_dad < 1 &&
-	     idev->cnf.accept_dad < 1) ||
+	    (READ_ONCE(net->ipv6.devconf_all->accept_dad) < 1 &&
+	     READ_ONCE(idev->cnf.accept_dad) < 1) ||
 	    !(ifp->flags&IFA_F_TENTATIVE) ||
 	    ifp->flags & IFA_F_NODAD) {
 		bool send_na = false;
@@ -4212,8 +4215,8 @@ static void addrconf_dad_work(struct work_struct *w)
 		action = DAD_ABORT;
 		ifp->state = INET6_IFADDR_STATE_POSTDAD;
 
-		if ((dev_net(idev->dev)->ipv6.devconf_all->accept_dad > 1 ||
-		     idev->cnf.accept_dad > 1) &&
+		if ((READ_ONCE(dev_net(idev->dev)->ipv6.devconf_all->accept_dad) > 1 ||
+		     READ_ONCE(idev->cnf.accept_dad) > 1) &&
 		    !idev->cnf.disable_ipv6 &&
 		    !(ifp->flags & IFA_F_STABLE_PRIVACY)) {
 			struct in6_addr addr;
@@ -4352,8 +4355,8 @@ static void addrconf_dad_completed(struct inet6_ifaddr *ifp, bool bump_id,
 
 	/* send unsolicited NA if enabled */
 	if (send_na &&
-	    (ifp->idev->cnf.ndisc_notify ||
-	     dev_net(dev)->ipv6.devconf_all->ndisc_notify)) {
+	    (READ_ONCE(ifp->idev->cnf.ndisc_notify) ||
+	     READ_ONCE(dev_net(dev)->ipv6.devconf_all->ndisc_notify))) {
 		ndisc_send_na(dev, &in6addr_linklocal_allnodes, &ifp->addr,
 			      /*router=*/ !!ifp->idev->cnf.forwarding,
 			      /*solicited=*/ false, /*override=*/ true,
@@ -6540,7 +6543,7 @@ static int addrconf_sysctl_addr_gen_mode(struct ctl_table *ctl, int write,
 		} else if (&net->ipv6.devconf_all->addr_gen_mode == ctl->data) {
 			struct net_device *dev;
 
-			net->ipv6.devconf_dflt->addr_gen_mode = new_val;
+			WRITE_ONCE(net->ipv6.devconf_dflt->addr_gen_mode, new_val);
 			for_each_netdev(net, dev) {
 				idev = __in6_dev_get(dev);
 				if (idev &&
@@ -6552,7 +6555,7 @@ static int addrconf_sysctl_addr_gen_mode(struct ctl_table *ctl, int write,
 			}
 		}
 
-		*((u32 *)ctl->data) = new_val;
+		WRITE_ONCE(*((u32 *)ctl->data), new_val);
 	}
 
 out:
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 727792907d6cb2132d965da4c7cb8447f07b2a68..26f1e4a5ade05175375add7da8da1fde9b204d96 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -379,9 +379,8 @@ static int ipv6_srh_rcv(struct sk_buff *skb)
 
 	idev = __in6_dev_get(skb->dev);
 
-	accept_seg6 = net->ipv6.devconf_all->seg6_enabled;
-	if (accept_seg6 > idev->cnf.seg6_enabled)
-		accept_seg6 = idev->cnf.seg6_enabled;
+	accept_seg6 = min(READ_ONCE(net->ipv6.devconf_all->seg6_enabled),
+			  READ_ONCE(idev->cnf.seg6_enabled));
 
 	if (!accept_seg6) {
 		kfree_skb(skb);
@@ -655,10 +654,13 @@ static int ipv6_rthdr_rcv(struct sk_buff *skb)
 	struct ipv6_rt_hdr *hdr;
 	struct rt0_hdr *rthdr;
 	struct net *net = dev_net(skb->dev);
-	int accept_source_route = net->ipv6.devconf_all->accept_source_route;
+	int accept_source_route;
 
-	if (idev && accept_source_route > idev->cnf.accept_source_route)
-		accept_source_route = idev->cnf.accept_source_route;
+	accept_source_route = READ_ONCE(net->ipv6.devconf_all->accept_source_route);
+
+	if (idev)
+		accept_source_route = min(accept_source_route,
+					  READ_ONCE(idev->cnf.accept_source_route));
 
 	if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
 	    !pskb_may_pull(skb, (skb_transport_offset(skb) +
@@ -919,7 +921,7 @@ static bool ipv6_hop_ioam(struct sk_buff *skb, int optoff)
 		goto drop;
 
 	/* Ignore if IOAM is not enabled on ingress */
-	if (!__in6_dev_get(skb->dev)->cnf.ioam6_enabled)
+	if (!READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_enabled))
 		goto ignore;
 
 	/* Truncated Option header */
diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
index 5fa923f0663214df4783344e0f790b368a2bf1bf..08c929513065772dca3666c92326a47f2dae0631 100644
--- a/net/ipv6/ioam6.c
+++ b/net/ipv6/ioam6.c
@@ -727,7 +727,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (!skb->dev)
 			raw16 = IOAM6_U16_UNAVAILABLE;
 		else
-			raw16 = (__force u16)__in6_dev_get(skb->dev)->cnf.ioam6_id;
+			raw16 = (__force u16)READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_id);
 
 		*(__be16 *)data = cpu_to_be16(raw16);
 		data += sizeof(__be16);
@@ -735,7 +735,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (skb_dst(skb)->dev->flags & IFF_LOOPBACK)
 			raw16 = IOAM6_U16_UNAVAILABLE;
 		else
-			raw16 = (__force u16)__in6_dev_get(skb_dst(skb)->dev)->cnf.ioam6_id;
+			raw16 = (__force u16)READ_ONCE(__in6_dev_get(skb_dst(skb)->dev)->cnf.ioam6_id);
 
 		*(__be16 *)data = cpu_to_be16(raw16);
 		data += sizeof(__be16);
@@ -822,7 +822,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (!skb->dev)
 			raw32 = IOAM6_U32_UNAVAILABLE;
 		else
-			raw32 = __in6_dev_get(skb->dev)->cnf.ioam6_id_wide;
+			raw32 = READ_ONCE(__in6_dev_get(skb->dev)->cnf.ioam6_id_wide);
 
 		*(__be32 *)data = cpu_to_be32(raw32);
 		data += sizeof(__be32);
@@ -830,7 +830,7 @@ static void __ioam6_fill_trace_data(struct sk_buff *skb,
 		if (skb_dst(skb)->dev->flags & IFF_LOOPBACK)
 			raw32 = IOAM6_U32_UNAVAILABLE;
 		else
-			raw32 = __in6_dev_get(skb_dst(skb)->dev)->cnf.ioam6_id_wide;
+			raw32 = READ_ONCE(__in6_dev_get(skb_dst(skb)->dev)->cnf.ioam6_id_wide);
 
 		*(__be32 *)data = cpu_to_be32(raw32);
 		data += sizeof(__be32);
diff --git a/net/ipv6/ip6_input.c b/net/ipv6/ip6_input.c
index 1ba97933c74fbd12e21f273f0aeda2313bd608b7..133610a49da6b8a2a210ad8faf74015c6bdf7038 100644
--- a/net/ipv6/ip6_input.c
+++ b/net/ipv6/ip6_input.c
@@ -236,7 +236,7 @@ static struct sk_buff *ip6_rcv_core(struct sk_buff *skb, struct net_device *dev,
 	if (!ipv6_addr_is_multicast(&hdr->daddr) &&
 	    (skb->pkt_type == PACKET_BROADCAST ||
 	     skb->pkt_type == PACKET_MULTICAST) &&
-	    idev->cnf.drop_unicast_in_l2_multicast) {
+	    READ_ONCE(idev->cnf.drop_unicast_in_l2_multicast)) {
 		SKB_DR_SET(reason, UNICAST_IN_L2_MULTICAST);
 		goto err;
 	}
diff --git a/net/ipv6/mcast.c b/net/ipv6/mcast.c
index 76ee1615ff2a07e1dd496aada377a7feb4703e8c..7ba01d8cfbae839d87e0c85729f7bed9ba328f05 100644
--- a/net/ipv6/mcast.c
+++ b/net/ipv6/mcast.c
@@ -159,9 +159,9 @@ static int unsolicited_report_interval(struct inet6_dev *idev)
 	int iv;
 
 	if (mld_in_v1_mode(idev))
-		iv = idev->cnf.mldv1_unsolicited_report_interval;
+		iv = READ_ONCE(idev->cnf.mldv1_unsolicited_report_interval);
 	else
-		iv = idev->cnf.mldv2_unsolicited_report_interval;
+		iv = READ_ONCE(idev->cnf.mldv2_unsolicited_report_interval);
 
 	return iv > 0 ? iv : 1;
 }
@@ -1202,15 +1202,15 @@ static bool mld_marksources(struct ifmcaddr6 *pmc, int nsrcs,
 
 static int mld_force_mld_version(const struct inet6_dev *idev)
 {
+	const struct net *net = dev_net(idev->dev);
+	int all_force;
+
+	all_force = READ_ONCE(net->ipv6.devconf_all->force_mld_version);
 	/* Normally, both are 0 here. If enforcement to a particular is
 	 * being used, individual device enforcement will have a lower
 	 * precedence over 'all' device (.../conf/all/force_mld_version).
 	 */
-
-	if (dev_net(idev->dev)->ipv6.devconf_all->force_mld_version != 0)
-		return dev_net(idev->dev)->ipv6.devconf_all->force_mld_version;
-	else
-		return idev->cnf.force_mld_version;
+	return all_force ?: READ_ONCE(idev->cnf.force_mld_version);
 }
 
 static bool mld_in_v2_mode_only(const struct inet6_dev *idev)
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index 4114918f12c88f2b74e53d6d726018994feaf213..ae134634c323cab27c03328015b24ae397f97cfc 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -451,7 +451,7 @@ static void ip6_nd_hdr(struct sk_buff *skb,
 
 	rcu_read_lock();
 	idev = __in6_dev_get(skb->dev);
-	tclass = idev ? idev->cnf.ndisc_tclass : 0;
+	tclass = idev ? READ_ONCE(idev->cnf.ndisc_tclass) : 0;
 	rcu_read_unlock();
 
 	skb_push(skb, sizeof(*hdr));
@@ -535,7 +535,7 @@ void ndisc_send_na(struct net_device *dev, const struct in6_addr *daddr,
 		src_addr = solicited_addr;
 		if (ifp->flags & IFA_F_OPTIMISTIC)
 			override = false;
-		inc_opt |= ifp->idev->cnf.force_tllao;
+		inc_opt |= READ_ONCE(ifp->idev->cnf.force_tllao);
 		in6_ifa_put(ifp);
 	} else {
 		if (ipv6_dev_get_saddr(dev_net(dev), dev, daddr,
@@ -974,7 +974,7 @@ static int accept_untracked_na(struct net_device *dev, struct in6_addr *saddr)
 {
 	struct inet6_dev *idev = __in6_dev_get(dev);
 
-	switch (idev->cnf.accept_untracked_na) {
+	switch (READ_ONCE(idev->cnf.accept_untracked_na)) {
 	case 0: /* Don't accept untracked na (absent in neighbor cache) */
 		return 0;
 	case 1: /* Create new entries from na if currently untracked */
@@ -1025,7 +1025,7 @@ static enum skb_drop_reason ndisc_recv_na(struct sk_buff *skb)
 	 * drop_unsolicited_na takes precedence over accept_untracked_na
 	 */
 	if (!msg->icmph.icmp6_solicited && idev &&
-	    idev->cnf.drop_unsolicited_na)
+	    READ_ONCE(idev->cnf.drop_unsolicited_na))
 		return reason;
 
 	if (!ndisc_parse_options(dev, msg->opt, ndoptlen, &ndopts))
@@ -1818,7 +1818,7 @@ static bool ndisc_suppress_frag_ndisc(struct sk_buff *skb)
 	if (!idev)
 		return true;
 	if (IP6CB(skb)->flags & IP6SKB_FRAGMENTED &&
-	    idev->cnf.suppress_frag_ndisc) {
+	    READ_ONCE(idev->cnf.suppress_frag_ndisc)) {
 		net_warn_ratelimited("Received fragmented ndisc packet. Carefully consider disabling suppress_frag_ndisc.\n");
 		return true;
 	}
@@ -1895,8 +1895,8 @@ static int ndisc_netdev_event(struct notifier_block *this, unsigned long event,
 		idev = in6_dev_get(dev);
 		if (!idev)
 			break;
-		if (idev->cnf.ndisc_notify ||
-		    net->ipv6.devconf_all->ndisc_notify)
+		if (READ_ONCE(idev->cnf.ndisc_notify) ||
+		    READ_ONCE(net->ipv6.devconf_all->ndisc_notify))
 			ndisc_send_unsol_na(dev);
 		in6_dev_put(idev);
 		break;
@@ -1905,8 +1905,8 @@ static int ndisc_netdev_event(struct notifier_block *this, unsigned long event,
 		if (!idev)
 			evict_nocarrier = true;
 		else {
-			evict_nocarrier = idev->cnf.ndisc_evict_nocarrier &&
-					  net->ipv6.devconf_all->ndisc_evict_nocarrier;
+			evict_nocarrier = READ_ONCE(idev->cnf.ndisc_evict_nocarrier) &&
+					  READ_ONCE(net->ipv6.devconf_all->ndisc_evict_nocarrier);
 			in6_dev_put(idev);
 		}
 
diff --git a/net/ipv6/seg6_hmac.c b/net/ipv6/seg6_hmac.c
index d43c50a7310d64e3af88657286a431057e9577bd..861e0366f549d523f20dc92c79bef1be8805e0c7 100644
--- a/net/ipv6/seg6_hmac.c
+++ b/net/ipv6/seg6_hmac.c
@@ -241,6 +241,7 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 	struct sr6_tlv_hmac *tlv;
 	struct ipv6_sr_hdr *srh;
 	struct inet6_dev *idev;
+	int require_hmac;
 
 	idev = __in6_dev_get(skb->dev);
 
@@ -248,16 +249,17 @@ bool seg6_hmac_validate_skb(struct sk_buff *skb)
 
 	tlv = seg6_get_tlv_hmac(srh);
 
+	require_hmac = READ_ONCE(idev->cnf.seg6_require_hmac);
 	/* mandatory check but no tlv */
-	if (idev->cnf.seg6_require_hmac > 0 && !tlv)
+	if (require_hmac > 0 && !tlv)
 		return false;
 
 	/* no check */
-	if (idev->cnf.seg6_require_hmac < 0)
+	if (require_hmac < 0)
 		return true;
 
 	/* check only if present */
-	if (idev->cnf.seg6_require_hmac == 0 && !tlv)
+	if (require_hmac == 0 && !tlv)
 		return true;
 
 	/* now, seg6_require_hmac >= 0 && tlv */
-- 
2.44.0.rc1.240.g4c46232300-goog



Return-Path: <netdev+bounces-201911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 396AFAEB646
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:26:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AD9B5613B8
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:26:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96B8A29CB4C;
	Fri, 27 Jun 2025 11:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IgO0Q9eI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420E02BEFF8
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 11:25:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023552; cv=none; b=RwwQGwpmCGU1FidWr9LUJDit+oCbPoainRaNpMD+IQxue1ubuv4Z5NHKr9sU2/HSnUEJ7mgAd3SVNEwfOOJ9gtXJXVGp8KlnD+D6FgmUFyG0Hb9r3OzXsPtKenJEromU2jCAyWXhOLP7AQr9XJlpnGx6A3hjCKB9ydtVkDvqy1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023552; c=relaxed/simple;
	bh=haQEKFP4sMs37XBCUlw6z71sGtxcCOIaKx+D5mSDCzM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LyhouS2CBY5tNYusA88MFkU/Z5kAAR0YkQHk7GzQiu5Nu2ChtTfQCx5UeRyiYkDRN4xhJ84KM10V5nYbjxz7VZGmXTXclvEKwTlA8Juls07eC1MiW9lR898S/P2JZ4Hva1svqsENl5erPSq7adfdorgsioyibl4vyTzTOAQOKD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IgO0Q9eI; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a442d07c5fso37626761cf.3
        for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 04:25:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751023549; x=1751628349; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=R1g/z+M3qgkFoF7NBXmKTDwi1MWzCUQ70X0YJ8i1sgg=;
        b=IgO0Q9eIuoxXiaG4YW2ga2Huvv6JwJnZ5Zi0/c+MH4nlDKVWjQpjVzXPSMhJXJEer1
         d5AgXB5ol8t6RJgU8WAJ3aD6pVYnFIFO5fMao7J6sDQuw0uVI4ZUlk5xEdfzazLPzDe1
         EMLVHkfytMjYEJxNCrfO1iwe1y2YEy5kRhMrpcuyQktRi3lIJe6H5JPr6ApxHhnwM8gZ
         +7nzRIrSw4k+XqHgGJ99kP5dTcHWRm75Lznga8SpZnbsTskrmR595My89BZIZR0fVAWv
         gPL1Ixk4eN+wdO7a+T5lb5cF0L/TPVI/ORK0BqQix11NGp4qTuV0GUNUDSv2yxdT2UT7
         VkHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751023549; x=1751628349;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1g/z+M3qgkFoF7NBXmKTDwi1MWzCUQ70X0YJ8i1sgg=;
        b=m8O+web/bjGSI915aROzO2tHjIyAq/4DZUGsg1bzf0erHUmXZ1MS9CRw5ton3SlNGa
         ribDgTKfedS5DvMTpSaYNA7hSm1n7J8xTYBSM9BtVJUIz/jkMXK+kn0IDeoxSahptN3E
         0k63t5PaaOHGuoIUduNjlCgosvR4Ey4Dr2JZ0IMKlB/FJEsnriSDusbXGA3OvDKJir/m
         tOPTrxCYmrCDIHgUj642MtHhLnRvjbDsMtf3BMmNqX13JiKe9xKoNIDnuFIj6WC1xrFC
         QvHn1fvCE0PyiH/x6Faj5qBA0kBHpIE7ATzYrgh1NcWsw7cNICroxqEaqAk1jM5qFgfi
         2Hjw==
X-Forwarded-Encrypted: i=1; AJvYcCUFfCe6W0Dfl7K2qIaYg4uqBz1CNIUg+1zYfQtDWliZD/qEOeCCvoq/d1dQ8xbw3eXLLodS4k4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsbquKi85snm6KjKd40xACZ61OKyhU1yvf4nPjwTx22CD44ckG
	F6NlOCfPR9eibQ/LHwky/rfMRmDftb+OY/hJM+B0jjOIwNR220aBDoAgPIoNE6od4c5Bo9NPN6i
	znKiOTi4uzTFq/Q==
X-Google-Smtp-Source: AGHT+IF4H8+oi6gzu/UCzWUAJENqc7/ofeOnl9IeBNEXMkT7BAoUVsv1Cr0lw/rQVqbhUJSO4zGITzYtXRM7Qw==
X-Received: from qtbca14.prod.google.com ([2002:a05:622a:1f0e:b0:4a6:ef6d:d60b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:7c44:0:b0:4a3:1b23:2862 with SMTP id d75a77b69052e-4a7fcb181cdmr57716491cf.50.1751023549213;
 Fri, 27 Jun 2025 04:25:49 -0700 (PDT)
Date: Fri, 27 Jun 2025 11:25:24 +0000
In-Reply-To: <20250627112526.3615031-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250627112526.3615031-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250627112526.3615031-9-edumazet@google.com>
Subject: [PATCH net-next 08/10] ipv6: adopt dst_dev() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the new helper as a step to deal with potential dst->dev races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/ip6_route.h          |  4 ++--
 net/ipv6/exthdrs.c               |  2 +-
 net/ipv6/icmp.c                  |  4 +++-
 net/ipv6/ila/ila_lwt.c           |  2 +-
 net/ipv6/ioam6_iptunnel.c        |  4 ++--
 net/ipv6/ip6_gre.c               |  8 +++++---
 net/ipv6/ip6_output.c            | 19 ++++++++++---------
 net/ipv6/ip6_tunnel.c            |  4 ++--
 net/ipv6/ip6_udp_tunnel.c        |  2 +-
 net/ipv6/ip6_vti.c               |  2 +-
 net/ipv6/ndisc.c                 |  6 ++++--
 net/ipv6/netfilter/nf_dup_ipv6.c |  2 +-
 net/ipv6/output_core.c           |  2 +-
 net/ipv6/route.c                 | 20 ++++++++++++--------
 net/ipv6/rpl_iptunnel.c          |  4 ++--
 net/ipv6/seg6_iptunnel.c         | 20 +++++++++++---------
 net/ipv6/seg6_local.c            |  2 +-
 17 files changed, 60 insertions(+), 47 deletions(-)

diff --git a/include/net/ip6_route.h b/include/net/ip6_route.h
index 6dbdf60b342f6d57ddd6288ce5e4476b413bff60..9255f21818ee7b03d2608fd399b082c0098c7028 100644
--- a/include/net/ip6_route.h
+++ b/include/net/ip6_route.h
@@ -274,7 +274,7 @@ static inline unsigned int ip6_skb_dst_mtu(const struct sk_buff *skb)
 	unsigned int mtu;
 
 	if (np && READ_ONCE(np->pmtudisc) >= IPV6_PMTUDISC_PROBE) {
-		mtu = READ_ONCE(dst->dev->mtu);
+		mtu = READ_ONCE(dst_dev(dst)->mtu);
 		mtu -= lwtunnel_headroom(dst->lwtstate, mtu);
 	} else {
 		mtu = dst_mtu(dst);
@@ -337,7 +337,7 @@ static inline unsigned int ip6_dst_mtu_maybe_forward(const struct dst_entry *dst
 
 	mtu = IPV6_MIN_MTU;
 	rcu_read_lock();
-	idev = __in6_dev_get(dst->dev);
+	idev = __in6_dev_get(dst_dev(dst));
 	if (idev)
 		mtu = READ_ONCE(idev->cnf.mtu6);
 	rcu_read_unlock();
diff --git a/net/ipv6/exthdrs.c b/net/ipv6/exthdrs.c
index 457de0745a338ea0cb542694b84140a7d25d467d..1947530fb20ac17dcd6660703e3e94d584d5f688 100644
--- a/net/ipv6/exthdrs.c
+++ b/net/ipv6/exthdrs.c
@@ -306,7 +306,7 @@ static int ipv6_destopt_rcv(struct sk_buff *skb)
 	if (!pskb_may_pull(skb, skb_transport_offset(skb) + 8) ||
 	    !pskb_may_pull(skb, (skb_transport_offset(skb) +
 				 ((skb_transport_header(skb)[1] + 1) << 3)))) {
-		__IP6_INC_STATS(dev_net(dst->dev), idev,
+		__IP6_INC_STATS(dev_net(dst_dev(dst)), idev,
 				IPSTATS_MIB_INHDRERRORS);
 fail_and_free:
 		kfree_skb(skb);
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 3fd19a84b358d169bbdc351c43ede830c60afcf3..44550957fd4e360d78e6cb411c33d6bbf2359e1f 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -196,6 +196,7 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 			       struct flowi6 *fl6, bool apply_ratelimit)
 {
 	struct net *net = sock_net(sk);
+	struct net_device *dev;
 	struct dst_entry *dst;
 	bool res = false;
 
@@ -208,10 +209,11 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 	 * this lookup should be more aggressive (not longer than timeout).
 	 */
 	dst = ip6_route_output(net, sk, fl6);
+	dev = dst_dev(dst);
 	if (dst->error) {
 		IP6_INC_STATS(net, ip6_dst_idev(dst),
 			      IPSTATS_MIB_OUTNOROUTES);
-	} else if (dst->dev && (dst->dev->flags&IFF_LOOPBACK)) {
+	} else if (dev && (dev->flags & IFF_LOOPBACK)) {
 		res = true;
 	} else {
 		struct rt6_info *rt = dst_rt6_info(dst);
diff --git a/net/ipv6/ila/ila_lwt.c b/net/ipv6/ila/ila_lwt.c
index 7d574f5132e2fb893863b0eef7ef1704010a04dd..7bb9edc5c28c5d87b6853ebf28764e032759efd4 100644
--- a/net/ipv6/ila/ila_lwt.c
+++ b/net/ipv6/ila/ila_lwt.c
@@ -70,7 +70,7 @@ static int ila_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 		 */
 
 		memset(&fl6, 0, sizeof(fl6));
-		fl6.flowi6_oif = orig_dst->dev->ifindex;
+		fl6.flowi6_oif = dst_dev(orig_dst)->ifindex;
 		fl6.flowi6_iif = LOOPBACK_IFINDEX;
 		fl6.daddr = *rt6_nexthop(dst_rt6_info(orig_dst),
 					 &ip6h->daddr);
diff --git a/net/ipv6/ioam6_iptunnel.c b/net/ipv6/ioam6_iptunnel.c
index 40df8bdfaacdde4b61db4f9f8fad52ac342918d5..1fe7894f14dd955e666ec6e79b5866e445dfd51e 100644
--- a/net/ipv6/ioam6_iptunnel.c
+++ b/net/ipv6/ioam6_iptunnel.c
@@ -335,7 +335,7 @@ static int ioam6_do_encap(struct net *net, struct sk_buff *skb,
 	if (has_tunsrc)
 		memcpy(&hdr->saddr, tunsrc, sizeof(*tunsrc));
 	else
-		ipv6_dev_get_saddr(net, dst->dev, &hdr->daddr,
+		ipv6_dev_get_saddr(net, dst_dev(dst), &hdr->daddr,
 				   IPV6_PREFER_SRC_PUBLIC, &hdr->saddr);
 
 	skb_postpush_rcsum(skb, hdr, len);
@@ -442,7 +442,7 @@ static int ioam6_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			dst_cache_set_ip6(&ilwt->cache, dst, &fl6.saddr);
 		local_bh_enable();
 
-		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst_dev(dst)));
 		if (unlikely(err))
 			goto drop;
 	}
diff --git a/net/ipv6/ip6_gre.c b/net/ipv6/ip6_gre.c
index 2dc9dcffe2cab48e3f58947b8577e2a30615c04c..a1210fd6404ee3de8f626bbb27ffcaf48a7b3d9e 100644
--- a/net/ipv6/ip6_gre.c
+++ b/net/ipv6/ip6_gre.c
@@ -1085,9 +1085,11 @@ static netdev_tx_t ip6erspan_tunnel_xmit(struct sk_buff *skb,
 			 htonl(atomic_fetch_inc(&t->o_seqno)));
 
 	/* TooBig packet may have updated dst->dev's mtu */
-	if (!t->parms.collect_md && dst && dst_mtu(dst) > dst->dev->mtu)
-		dst->ops->update_pmtu(dst, NULL, skb, dst->dev->mtu, false);
-
+	if (!t->parms.collect_md && dst) {
+		mtu = READ_ONCE(dst_dev(dst)->mtu);
+		if (dst_mtu(dst) > mtu)
+			dst->ops->update_pmtu(dst, NULL, skb, mtu, false);
+	}
 	err = ip6_tnl_xmit(skb, dev, dsfield, &fl6, encap_limit, &mtu,
 			   NEXTHDR_GRE);
 	if (err != 0) {
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 7bd29a9ff0db8d74c79f50afa5c693231e0f82d5..f494b4ece6b7cf08522abd20817c7a37432ab37e 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -60,7 +60,7 @@
 static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 	struct inet6_dev *idev = ip6_dst_idev(dst);
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
 	const struct in6_addr *daddr, *nexthop;
@@ -271,7 +271,7 @@ int ip6_xmit(const struct sock *sk, struct sk_buff *skb, struct flowi6 *fl6,
 	const struct ipv6_pinfo *np = inet6_sk(sk);
 	struct in6_addr *first_hop = &fl6->daddr;
 	struct dst_entry *dst = skb_dst(skb);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 	struct inet6_dev *idev = ip6_dst_idev(dst);
 	struct hop_jumbo_hdr *hop_jumbo;
 	int hoplen = sizeof(*hop_jumbo);
@@ -503,7 +503,8 @@ int ip6_forward(struct sk_buff *skb)
 	struct dst_entry *dst = skb_dst(skb);
 	struct ipv6hdr *hdr = ipv6_hdr(skb);
 	struct inet6_skb_parm *opt = IP6CB(skb);
-	struct net *net = dev_net(dst->dev);
+	struct net *net = dev_net(dst_dev(dst));
+	struct net_device *dev;
 	struct inet6_dev *idev;
 	SKB_DR(reason);
 	u32 mtu;
@@ -591,12 +592,12 @@ int ip6_forward(struct sk_buff *skb)
 		goto drop;
 	}
 	dst = skb_dst(skb);
-
+	dev = dst_dev(dst);
 	/* IPv6 specs say nothing about it, but it is clear that we cannot
 	   send redirects to source routed frames.
 	   We don't send redirects to frames decapsulated from IPsec.
 	 */
-	if (IP6CB(skb)->iif == dst->dev->ifindex &&
+	if (IP6CB(skb)->iif == dev->ifindex &&
 	    opt->srcrt == 0 && !skb_sec_path(skb)) {
 		struct in6_addr *target = NULL;
 		struct inet_peer *peer;
@@ -644,7 +645,7 @@ int ip6_forward(struct sk_buff *skb)
 
 	if (ip6_pkt_too_big(skb, mtu)) {
 		/* Again, force OUTPUT device used as source address */
-		skb->dev = dst->dev;
+		skb->dev = dev;
 		icmpv6_send(skb, ICMPV6_PKT_TOOBIG, 0, mtu);
 		__IP6_INC_STATS(net, idev, IPSTATS_MIB_INTOOBIGERRORS);
 		__IP6_INC_STATS(net, ip6_dst_idev(dst),
@@ -653,7 +654,7 @@ int ip6_forward(struct sk_buff *skb)
 		return -EMSGSIZE;
 	}
 
-	if (skb_cow(skb, dst->dev->hard_header_len)) {
+	if (skb_cow(skb, dev->hard_header_len)) {
 		__IP6_INC_STATS(net, ip6_dst_idev(dst),
 				IPSTATS_MIB_OUTDISCARDS);
 		goto drop;
@@ -666,7 +667,7 @@ int ip6_forward(struct sk_buff *skb)
 	hdr->hop_limit--;
 
 	return NF_HOOK(NFPROTO_IPV6, NF_INET_FORWARD,
-		       net, NULL, skb, skb->dev, dst->dev,
+		       net, NULL, skb, skb->dev, dev,
 		       ip6_forward_finish);
 
 error:
@@ -1093,7 +1094,7 @@ static struct dst_entry *ip6_sk_dst_check(struct sock *sk,
 #ifdef CONFIG_IPV6_SUBTREES
 	    ip6_rt_check(&rt->rt6i_src, &fl6->saddr, np->saddr_cache) ||
 #endif
-	   (fl6->flowi6_oif && fl6->flowi6_oif != dst->dev->ifindex)) {
+	   (fl6->flowi6_oif && fl6->flowi6_oif != dst_dev(dst)->ifindex)) {
 		dst_release(dst);
 		dst = NULL;
 	}
diff --git a/net/ipv6/ip6_tunnel.c b/net/ipv6/ip6_tunnel.c
index a885bb5c98ea8e1e9f8cb5844207767d1fa11c56..535d97b08220c55c356c3032c294534018acfab9 100644
--- a/net/ipv6/ip6_tunnel.c
+++ b/net/ipv6/ip6_tunnel.c
@@ -1179,7 +1179,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 		ndst = dst;
 	}
 
-	tdev = dst->dev;
+	tdev = dst_dev(dst);
 
 	if (tdev == dev) {
 		DEV_STATS_INC(dev, collisions);
@@ -1255,7 +1255,7 @@ int ip6_tnl_xmit(struct sk_buff *skb, struct net_device *dev, __u8 dsfield,
 	/* Calculate max headroom for all the headers and adjust
 	 * needed_headroom if necessary.
 	 */
-	max_headroom = LL_RESERVED_SPACE(dst->dev) + sizeof(struct ipv6hdr)
+	max_headroom = LL_RESERVED_SPACE(tdev) + sizeof(struct ipv6hdr)
 			+ dst->header_len + t->hlen;
 	if (max_headroom > READ_ONCE(dev->needed_headroom))
 		WRITE_ONCE(dev->needed_headroom, max_headroom);
diff --git a/net/ipv6/ip6_udp_tunnel.c b/net/ipv6/ip6_udp_tunnel.c
index 8ebe17a6058ad98d7862d82ec5470844141c4603..0ff547a4bff71d31c3b3323f64aabf4fd1d598d2 100644
--- a/net/ipv6/ip6_udp_tunnel.c
+++ b/net/ipv6/ip6_udp_tunnel.c
@@ -168,7 +168,7 @@ struct dst_entry *udp_tunnel6_dst_lookup(struct sk_buff *skb,
 		netdev_dbg(dev, "no route to %pI6\n", &fl6.daddr);
 		return ERR_PTR(-ENETUNREACH);
 	}
-	if (dst->dev == dev) { /* is this necessary? */
+	if (dst_dev(dst) == dev) { /* is this necessary? */
 		netdev_dbg(dev, "circular route to %pI6\n", &fl6.daddr);
 		dst_release(dst);
 		return ERR_PTR(-ELOOP);
diff --git a/net/ipv6/ip6_vti.c b/net/ipv6/ip6_vti.c
index 40464a88bca6512cef30f8939eedfae1966fb203..2a86de922d42710b110057c23daad2f63fc69fe2 100644
--- a/net/ipv6/ip6_vti.c
+++ b/net/ipv6/ip6_vti.c
@@ -497,7 +497,7 @@ vti6_xmit(struct sk_buff *skb, struct net_device *dev, struct flowi *fl)
 			      (const struct in6_addr *)&x->id.daddr))
 		goto tx_err_link_failure;
 
-	tdev = dst->dev;
+	tdev = dst_dev(dst);
 
 	if (tdev == dev) {
 		DEV_STATS_INC(dev, collisions);
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index ecb5c4b8518fdd72d0e89640641ec917743e9c72..f2299b61221b63cffea34f0fccc88326a2a25e27 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -473,6 +473,7 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 {
 	struct icmp6hdr *icmp6h = icmp6_hdr(skb);
 	struct dst_entry *dst = skb_dst(skb);
+	struct net_device *dev;
 	struct inet6_dev *idev;
 	struct net *net;
 	struct sock *sk;
@@ -507,11 +508,12 @@ void ndisc_send_skb(struct sk_buff *skb, const struct in6_addr *daddr,
 
 	ip6_nd_hdr(skb, saddr, daddr, READ_ONCE(inet6_sk(sk)->hop_limit), skb->len);
 
-	idev = __in6_dev_get(dst->dev);
+	dev = dst_dev(dst);
+	idev = __in6_dev_get(dev);
 	IP6_INC_STATS(net, idev, IPSTATS_MIB_OUTREQUESTS);
 
 	err = NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
-		      net, sk, skb, NULL, dst->dev,
+		      net, sk, skb, NULL, dev,
 		      dst_output);
 	if (!err) {
 		ICMP6MSGOUT_INC_STATS(net, idev, type);
diff --git a/net/ipv6/netfilter/nf_dup_ipv6.c b/net/ipv6/netfilter/nf_dup_ipv6.c
index b903c62c00c9e4e5b3287dd68692c7fd8030dec1..6da3102b7c1b3795a6dec0582ee3e04b7100cc45 100644
--- a/net/ipv6/netfilter/nf_dup_ipv6.c
+++ b/net/ipv6/netfilter/nf_dup_ipv6.c
@@ -38,7 +38,7 @@ static bool nf_dup_ipv6_route(struct net *net, struct sk_buff *skb,
 	}
 	skb_dst_drop(skb);
 	skb_dst_set(skb, dst);
-	skb->dev      = dst->dev;
+	skb->dev      = dst_dev(dst);
 	skb->protocol = htons(ETH_P_IPV6);
 
 	return true;
diff --git a/net/ipv6/output_core.c b/net/ipv6/output_core.c
index 806d4b5dd1e60b27726facbb59bbef97d6fee7f5..90a178dd24aaeb44b69ad4abc9da6fa1c10f46d1 100644
--- a/net/ipv6/output_core.c
+++ b/net/ipv6/output_core.c
@@ -105,7 +105,7 @@ int ip6_dst_hoplimit(struct dst_entry *dst)
 {
 	int hoplimit = dst_metric_raw(dst, RTAX_HOPLIMIT);
 	if (hoplimit == 0) {
-		struct net_device *dev = dst->dev;
+		struct net_device *dev = dst_dev(dst);
 		struct inet6_dev *idev;
 
 		rcu_read_lock();
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 375112a59492ea3654d180c504946d96ed1592cd..dacfe1284918bffc75d1b41745c8873b9132bfc6 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -228,13 +228,13 @@ static struct neighbour *ip6_dst_neigh_lookup(const struct dst_entry *dst,
 	const struct rt6_info *rt = dst_rt6_info(dst);
 
 	return ip6_neigh_lookup(rt6_nexthop(rt, &in6addr_any),
-				dst->dev, skb, daddr);
+				dst_dev(dst), skb, daddr);
 }
 
 static void ip6_confirm_neigh(const struct dst_entry *dst, const void *daddr)
 {
 	const struct rt6_info *rt = dst_rt6_info(dst);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 
 	daddr = choose_neigh_daddr(rt6_nexthop(rt, &in6addr_any), NULL, daddr);
 	if (!daddr)
@@ -2943,7 +2943,7 @@ static void __ip6_rt_update_pmtu(struct dst_entry *dst, const struct sock *sk,
 
 		if (res.f6i->nh) {
 			struct fib6_nh_match_arg arg = {
-				.dev = dst->dev,
+				.dev = dst_dev(dst),
 				.gw = &rt6->rt6i_gateway,
 			};
 
@@ -3238,7 +3238,7 @@ EXPORT_SYMBOL_GPL(ip6_sk_redirect);
 
 static unsigned int ip6_default_advmss(const struct dst_entry *dst)
 {
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 	unsigned int mtu = dst_mtu(dst);
 	struct net *net;
 
@@ -4301,7 +4301,7 @@ static void rt6_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_bu
 
 	if (res.f6i->nh) {
 		struct fib6_nh_match_arg arg = {
-			.dev = dst->dev,
+			.dev = dst_dev(dst),
 			.gw = &rt->rt6i_gateway,
 		};
 
@@ -4587,13 +4587,14 @@ int ipv6_route_ioctl(struct net *net, unsigned int cmd, struct in6_rtmsg *rtmsg)
 static int ip6_pkt_drop(struct sk_buff *skb, u8 code, int ipstats_mib_noroutes)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct net *net = dev_net(dst->dev);
+	struct net_device *dev = dst_dev(dst);
+	struct net *net = dev_net(dev);
 	struct inet6_dev *idev;
 	SKB_DR(reason);
 	int type;
 
 	if (netif_is_l3_master(skb->dev) ||
-	    dst->dev == net->loopback_dev)
+	    dev == net->loopback_dev)
 		idev = __in6_dev_get_safely(dev_get_by_index_rcu(net, IP6CB(skb)->iif));
 	else
 		idev = ip6_dst_idev(dst);
@@ -5844,11 +5845,14 @@ static int rt6_fill_node(struct net *net, struct sk_buff *skb,
 	 * each as a nexthop within RTA_MULTIPATH.
 	 */
 	if (rt6) {
+		struct net_device *dev;
+
 		if (rt6_flags & RTF_GATEWAY &&
 		    nla_put_in6_addr(skb, RTA_GATEWAY, &rt6->rt6i_gateway))
 			goto nla_put_failure;
 
-		if (dst->dev && nla_put_u32(skb, RTA_OIF, dst->dev->ifindex))
+		dev = dst_dev(dst);
+		if (dev && nla_put_u32(skb, RTA_OIF, dev->ifindex))
 			goto nla_put_failure;
 
 		if (lwtunnel_fill_encap(skb, dst->lwtstate, RTA_ENCAP, RTA_ENCAP_TYPE) < 0)
diff --git a/net/ipv6/rpl_iptunnel.c b/net/ipv6/rpl_iptunnel.c
index 7c05ac846646f34e4c075d51612942977707dd5d..1f41f53fbaff1235948b59a957c04b813303e9e2 100644
--- a/net/ipv6/rpl_iptunnel.c
+++ b/net/ipv6/rpl_iptunnel.c
@@ -242,7 +242,7 @@ static int rpl_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 			local_bh_enable();
 		}
 
-		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst_dev(dst)));
 		if (unlikely(err))
 			goto drop;
 	}
@@ -297,7 +297,7 @@ static int rpl_input(struct sk_buff *skb)
 			local_bh_enable();
 		}
 
-		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst_dev(dst)));
 		if (unlikely(err))
 			goto drop;
 	} else {
diff --git a/net/ipv6/seg6_iptunnel.c b/net/ipv6/seg6_iptunnel.c
index 51583461ae29ba37869133f9380f25cb7dd6be34..27918fc0c9721d777965a819863169f3bde5114c 100644
--- a/net/ipv6/seg6_iptunnel.c
+++ b/net/ipv6/seg6_iptunnel.c
@@ -128,7 +128,8 @@ static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
 			       int proto, struct dst_entry *cache_dst)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct net *net = dev_net(dst->dev);
+	struct net_device *dev = dst_dev(dst);
+	struct net *net = dev_net(dev);
 	struct ipv6hdr *hdr, *inner_hdr;
 	struct ipv6_sr_hdr *isrh;
 	int hdrlen, tot_len, err;
@@ -181,7 +182,7 @@ static int __seg6_do_srh_encap(struct sk_buff *skb, struct ipv6_sr_hdr *osrh,
 	isrh->nexthdr = proto;
 
 	hdr->daddr = isrh->segments[isrh->first_segment];
-	set_tun_src(net, dst->dev, &hdr->daddr, &hdr->saddr);
+	set_tun_src(net, dev, &hdr->daddr, &hdr->saddr);
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	if (sr_has_hmac(isrh)) {
@@ -212,7 +213,8 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 {
 	__u8 first_seg = osrh->first_segment;
 	struct dst_entry *dst = skb_dst(skb);
-	struct net *net = dev_net(dst->dev);
+	struct net_device *dev = dst_dev(dst);
+	struct net *net = dev_net(dev);
 	struct ipv6hdr *hdr, *inner_hdr;
 	int hdrlen = ipv6_optlen(osrh);
 	int red_tlv_offset, tlv_offset;
@@ -270,7 +272,7 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 	if (skip_srh) {
 		hdr->nexthdr = proto;
 
-		set_tun_src(net, dst->dev, &hdr->daddr, &hdr->saddr);
+		set_tun_src(net, dev, &hdr->daddr, &hdr->saddr);
 		goto out;
 	}
 
@@ -306,7 +308,7 @@ static int seg6_do_srh_encap_red(struct sk_buff *skb,
 
 srcaddr:
 	isrh->nexthdr = proto;
-	set_tun_src(net, dst->dev, &hdr->daddr, &hdr->saddr);
+	set_tun_src(net, dev, &hdr->daddr, &hdr->saddr);
 
 #ifdef CONFIG_IPV6_SEG6_HMAC
 	if (unlikely(!skip_srh && sr_has_hmac(isrh))) {
@@ -507,7 +509,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 			local_bh_enable();
 		}
 
-		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst_dev(dst)));
 		if (unlikely(err))
 			goto drop;
 	} else {
@@ -518,7 +520,7 @@ static int seg6_input_core(struct net *net, struct sock *sk,
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT,
 			       dev_net(skb->dev), NULL, skb, NULL,
-			       skb_dst(skb)->dev, seg6_input_finish);
+			       skb_dst_dev(skb), seg6_input_finish);
 
 	return seg6_input_finish(dev_net(skb->dev), NULL, skb);
 drop:
@@ -593,7 +595,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 			local_bh_enable();
 		}
 
-		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst->dev));
+		err = skb_cow_head(skb, LL_RESERVED_SPACE(dst_dev(dst)));
 		if (unlikely(err))
 			goto drop;
 	}
@@ -603,7 +605,7 @@ static int seg6_output_core(struct net *net, struct sock *sk,
 
 	if (static_branch_unlikely(&nf_hooks_lwtunnel_enabled))
 		return NF_HOOK(NFPROTO_IPV6, NF_INET_LOCAL_OUT, net, sk, skb,
-			       NULL, skb_dst(skb)->dev, dst_output);
+			       NULL, dst_dev(dst), dst_output);
 
 	return dst_output(net, sk, skb);
 drop:
diff --git a/net/ipv6/seg6_local.c b/net/ipv6/seg6_local.c
index dfa825ee870e6b6c75b688d9aa9512c5bd0f39d8..ffb0d057ce5f248c993fed75f9b1386b70923ce4 100644
--- a/net/ipv6/seg6_local.c
+++ b/net/ipv6/seg6_local.c
@@ -313,7 +313,7 @@ seg6_lookup_any_nexthop(struct sk_buff *skb, struct in6_addr *nhaddr,
 	if (!local_delivery)
 		dev_flags |= IFF_LOOPBACK;
 
-	if (dst && (dst->dev->flags & dev_flags) && !dst->error) {
+	if (dst && (dst_dev(dst)->flags & dev_flags) && !dst->error) {
 		dst_release(dst);
 		dst = NULL;
 	}
-- 
2.50.0.727.gbf7dc18ff4-goog



Return-Path: <netdev+bounces-94115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AA8A8BE26F
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 14:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E5A76287C22
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 12:45:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C00815B137;
	Tue,  7 May 2024 12:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AHGGJRNx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f194.google.com (mail-lj1-f194.google.com [209.85.208.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82528158D9C;
	Tue,  7 May 2024 12:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715085919; cv=none; b=CdhFupgN8TADLkK7YqzXyEZF4I9C0A5APExh8a7kSiLwulsV3/VpAZvqmxMpa0QTbSv+ywUuTcXPO82D9ZyG+AiN5kT2dm0AOEL8vgUwxNzKiMax1sh6TGuzdBYIV9l6eR4iimB6KvLPahjmwO8hGbOOaT8xbTcZyUMQgd7661c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715085919; c=relaxed/simple;
	bh=YN3/mWGuvT+JhJ7JR7zHSioayWmea4yIowhWbMS/Cnc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K/BLPtc0WOjX3C/1uU2rHRHyIW1sZdzoqFOeMJlYEujo0mEwTEV4VoiwG7AOUxnby9Gb1L2dnt9CK3GDGWGvc074IzPg/JfaUibQW1yRa4Lh3e+xRW7euaMuIA5nXDoRw9CA9sqyBWOuWHnN/QbJPCqZf85n0E/1Mt0HYs8iiHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AHGGJRNx; arc=none smtp.client-ip=209.85.208.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f194.google.com with SMTP id 38308e7fff4ca-2e38a7ebdb6so20224041fa.2;
        Tue, 07 May 2024 05:45:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715085915; x=1715690715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hIMeLvgtOJaPGTq4xRu76ebVHmu+7aXjg26c5XHdzoo=;
        b=AHGGJRNxMlguVGdnExvN89zV0Wl6OGtiwxFHSdt5DmESNy05u/CpCR5QZbnPPD3v0a
         d8FLp7YXzRMjdU3gHmCYYpNz6kGZPCwLGytL0sKlf1ovF5qmIKtQhevU08lkraksGT2f
         Di0iLeeMvgkIkrRwRu4/8rX6qEQrEEUERP9tN41PJSWyQSrQk0g5jNTME59oPiFtO90f
         +sa5NUr/SqdF+Tr5OsUpu6tdxu3OoG1atX4H4ob47CEtDdhYFyUiDcnj/mTOS/+FssFM
         7pa74ZhXcFhW4mjHSHpdu93sfkQlVdUUahb9whKMyYrw+aW4gqWb2VRJMm340TVIusJf
         eahw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715085915; x=1715690715;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hIMeLvgtOJaPGTq4xRu76ebVHmu+7aXjg26c5XHdzoo=;
        b=FNNn2TVNfMqd5L3wPo2hUe0/YswxhQ+ilELuegskG4eHxAVZ3gQJtocf8VURl8Xxm8
         FJHB3w263xhwyNThFw0DaJo2ToiJj1GUTcfAJ9MV+Xcy7i1Iu4YRTK/qa+OPvt8bYPN1
         C0l2my5zCi+Yaco9ladqnxB+olIYLAuqpnp7xLIaOwM2plCMdWQnNnn6c0TSRu2r+otw
         PFURLrGOAq4YC3DbEnczfUwYFihDQLjSbN8l+KBdpJ9MnSedlPe3KRPa9g77LTfWBsTs
         qMDhPddNkIJ7fNpZWHI9sFsE7kpkdlGiSoDs/6NTjxaq6G6P33EnoSr9HnWhbKeq7jDj
         jDkg==
X-Forwarded-Encrypted: i=1; AJvYcCWcxcjhlo3eW055fdIAHyCCuZnU3L+0tBSK15NgE1v+BxK9fZ+7E/b2dz/O31yFufpctdH5N67ZN01xuhqHwsVmnY4MayK1cmiYmArgwqF4ZIYZM8an4HHP/W9GPk5Cw62/1868
X-Gm-Message-State: AOJu0Yz9540Wk72IhCjGTUF646bWoliuNpXVyr8yRVxqVeH83oayo19+
	TJXbiDGNO+Ss4U7EloelRFovPZP3ycZXzsfS4UmmnR0qDoHOHl4G
X-Google-Smtp-Source: AGHT+IGJknlOWDT5IDGO4g0Vg0FdOXT2CEmuZn3OgVH7ZbPZIqsVk5ocA1HPsRJkRC1UmsGaqx80tw==
X-Received: by 2002:a05:6512:3709:b0:51b:812:3c82 with SMTP id z9-20020a056512370900b0051b08123c82mr7417480lfr.5.1715085915239;
        Tue, 07 May 2024 05:45:15 -0700 (PDT)
Received: from localhost ([45.130.85.2])
        by smtp.gmail.com with ESMTPSA id j17-20020adfff91000000b00349ac818326sm12914844wrr.43.2024.05.07.05.45.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 May 2024 05:45:14 -0700 (PDT)
From: Leone Fernando <leone4fernando@gmail.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	willemb@google.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Leone Fernando <leone4fernando@gmail.com>
Subject: [PATCH net-next v2 4/4] net: route: replace route hints with input_dst_cache
Date: Tue,  7 May 2024 14:42:29 +0200
Message-Id: <20240507124229.446802-5-leone4fernando@gmail.com>
In-Reply-To: <20240507124229.446802-1-leone4fernando@gmail.com>
References: <20240507124229.446802-1-leone4fernando@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace route hints with cached dsts - ip_rcv_finish_core will first try
to use the cache and only then fall back to the demux or perform a full
lookup.

Only add newly found dsts to the cache after all the checks have passed
successfully to avoid adding a dropped packet's dst to the cache.

Multicast dsts are not added to the dst_cache as it will require additional
checks and multicast packets are rarer and a slower path anyway.

A check was added to ip_route_use_dst_cache that prevents forwarding
packets received by devices for which forwarding is disabled.

Relevant checks were added to ip_route_use_dst_cache to make sure the
dst can be used and to ensure IPCB(skb) flags are correct.

Signed-off-by: Leone Fernando <leone4fernando@gmail.com>
---
 include/net/route.h |  6 ++--
 net/ipv4/ip_input.c | 58 +++++++++++++++++++-----------------
 net/ipv4/route.c    | 72 +++++++++++++++++++++++++++++++++------------
 3 files changed, 88 insertions(+), 48 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 93833cfe9c96..c9433b8b9417 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -202,9 +202,9 @@ int ip_mc_validate_source(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 			  struct in_device *in_dev, u32 *itag);
 int ip_route_input_noref(struct sk_buff *skb, __be32 dst, __be32 src,
 			 u8 tos, struct net_device *devin);
-int ip_route_use_hint(struct sk_buff *skb, __be32 dst, __be32 src,
-		      u8 tos, struct net_device *devin,
-		      const struct sk_buff *hint);
+int ip_route_use_dst_cache(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+			   u8 tos, struct net_device *dev,
+			   struct dst_entry *dst);
 
 static inline int ip_route_input(struct sk_buff *skb, __be32 dst, __be32 src,
 				 u8 tos, struct net_device *devin)
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index d6fbcbd2358a..35c8b122d62f 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -305,30 +305,44 @@ static inline bool ip_rcv_options(struct sk_buff *skb, struct net_device *dev)
 	return true;
 }
 
-static bool ip_can_use_hint(const struct sk_buff *skb, const struct iphdr *iph,
-			    const struct sk_buff *hint)
+static bool ip_can_add_dst_cache(struct sk_buff *skb, __u16 rt_type)
 {
-	return hint && !skb_dst(skb) && ip_hdr(hint)->daddr == iph->daddr &&
-	       ip_hdr(hint)->tos == iph->tos;
+	return skb_valid_dst(skb) &&
+	       rt_type != RTN_BROADCAST &&
+	       rt_type != RTN_MULTICAST &&
+	       !(IPCB(skb)->flags & IPSKB_MULTIPATH);
+}
+
+static bool ip_can_use_dst_cache(const struct net *net, struct sk_buff *skb)
+{
+	return !skb_dst(skb) && !fib4_has_custom_rules(net);
 }
 
 int tcp_v4_early_demux(struct sk_buff *skb);
 int udp_v4_early_demux(struct sk_buff *skb);
 static int ip_rcv_finish_core(struct net *net, struct sock *sk,
-			      struct sk_buff *skb, struct net_device *dev,
-			      const struct sk_buff *hint)
+			      struct sk_buff *skb, struct net_device *dev)
 {
+	struct dst_cache *dst_cache = net_generic(net, dst_cache_net_id);
 	const struct iphdr *iph = ip_hdr(skb);
+	struct dst_entry *dst;
 	int err, drop_reason;
 	struct rtable *rt;
+	bool do_cache;
 
 	drop_reason = SKB_DROP_REASON_NOT_SPECIFIED;
 
-	if (ip_can_use_hint(skb, iph, hint)) {
-		err = ip_route_use_hint(skb, iph->daddr, iph->saddr, iph->tos,
-					dev, hint);
-		if (unlikely(err))
-			goto drop_error;
+	do_cache = ip_can_use_dst_cache(net, skb);
+	if (do_cache) {
+		dst = dst_cache_input_get_noref(dst_cache, skb);
+		if (dst) {
+			err = ip_route_use_dst_cache(skb, iph->daddr,
+						     iph->saddr, iph->tos,
+						     dev, dst);
+			if (unlikely(err))
+				goto drop_error;
+			do_cache = false;
+		}
 	}
 
 	if (READ_ONCE(net->ipv4.sysctl_ip_early_demux) &&
@@ -418,6 +432,9 @@ static int ip_rcv_finish_core(struct net *net, struct sock *sk,
 		}
 	}
 
+	if (do_cache && ip_can_add_dst_cache(skb, rt->rt_type))
+		dst_cache_input_add(dst_cache, skb);
+
 	return NET_RX_SUCCESS;
 
 drop:
@@ -444,7 +461,7 @@ static int ip_rcv_finish(struct net *net, struct sock *sk, struct sk_buff *skb)
 	if (!skb)
 		return NET_RX_SUCCESS;
 
-	ret = ip_rcv_finish_core(net, sk, skb, dev, NULL);
+	ret = ip_rcv_finish_core(net, sk, skb, dev);
 	if (ret != NET_RX_DROP)
 		ret = dst_input(skb);
 	return ret;
@@ -581,21 +598,11 @@ static void ip_sublist_rcv_finish(struct list_head *head)
 	}
 }
 
-static struct sk_buff *ip_extract_route_hint(const struct net *net,
-					     struct sk_buff *skb, int rt_type)
-{
-	if (fib4_has_custom_rules(net) || rt_type == RTN_BROADCAST ||
-	    IPCB(skb)->flags & IPSKB_MULTIPATH)
-		return NULL;
-
-	return skb;
-}
-
 static void ip_list_rcv_finish(struct net *net, struct sock *sk,
 			       struct list_head *head)
 {
-	struct sk_buff *skb, *next, *hint = NULL;
 	struct dst_entry *curr_dst = NULL;
+	struct sk_buff *skb, *next;
 	struct list_head sublist;
 
 	INIT_LIST_HEAD(&sublist);
@@ -610,14 +617,11 @@ static void ip_list_rcv_finish(struct net *net, struct sock *sk,
 		skb = l3mdev_ip_rcv(skb);
 		if (!skb)
 			continue;
-		if (ip_rcv_finish_core(net, sk, skb, dev, hint) == NET_RX_DROP)
+		if (ip_rcv_finish_core(net, sk, skb, dev) == NET_RX_DROP)
 			continue;
 
 		dst = skb_dst(skb);
 		if (curr_dst != dst) {
-			hint = ip_extract_route_hint(net, skb,
-						     dst_rtable(dst)->rt_type);
-
 			/* dispatch old sublist */
 			if (!list_empty(&sublist))
 				ip_sublist_rcv_finish(&sublist);
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 4e6b7a67f177..6d88d1f4969b 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1771,6 +1771,24 @@ static void ip_handle_martian_source(struct net_device *dev,
 #endif
 }
 
+static void ip_route_set_doredirect(struct in_device *in_dev,
+				    struct in_device *out_dev,
+				    struct sk_buff *skb,
+				    u8 gw_family,
+				    __be32 gw4,
+				    __be32 saddr)
+{
+	if (out_dev == in_dev && IN_DEV_TX_REDIRECTS(out_dev) &&
+	    skb->protocol == htons(ETH_P_IP)) {
+		__be32 gw;
+
+		gw = gw_family == AF_INET ? gw4 : 0;
+		if (IN_DEV_SHARED_MEDIA(out_dev) ||
+		    inet_addr_onlink(out_dev, saddr, gw))
+			IPCB(skb)->flags |= IPSKB_DOREDIRECT;
+	}
+}
+
 /* called in rcu_read_lock() section */
 static int __mkroute_input(struct sk_buff *skb,
 			   const struct fib_result *res,
@@ -1803,15 +1821,10 @@ static int __mkroute_input(struct sk_buff *skb,
 	}
 
 	do_cache = res->fi && !itag;
-	if (out_dev == in_dev && err && IN_DEV_TX_REDIRECTS(out_dev) &&
-	    skb->protocol == htons(ETH_P_IP)) {
-		__be32 gw;
-
-		gw = nhc->nhc_gw_family == AF_INET ? nhc->nhc_gw.ipv4 : 0;
-		if (IN_DEV_SHARED_MEDIA(out_dev) ||
-		    inet_addr_onlink(out_dev, saddr, gw))
-			IPCB(skb)->flags |= IPSKB_DOREDIRECT;
-	}
+	if (err)
+		ip_route_set_doredirect(in_dev, out_dev, skb,
+					nhc->nhc_gw_family,
+					nhc->nhc_gw.ipv4, saddr);
 
 	if (skb->protocol != htons(ETH_P_IP)) {
 		/* Not IP (i.e. ARP). Do not create route, if it is
@@ -2141,14 +2154,15 @@ static int ip_mkroute_input(struct sk_buff *skb,
 
 /* Implements all the saddr-related checks as ip_route_input_slow(),
  * assuming daddr is valid and the destination is not a local broadcast one.
- * Uses the provided hint instead of performing a route lookup.
+ * Uses the provided dst from dst_cache instead of performing a route lookup.
  */
-int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
-		      u8 tos, struct net_device *dev,
-		      const struct sk_buff *hint)
+int ip_route_use_dst_cache(struct sk_buff *skb, __be32 daddr, __be32 saddr,
+			   u8 tos, struct net_device *dev,
+			   struct dst_entry *dst)
 {
+	struct in_device *out_dev = __in_dev_get_rcu(dst->dev);
 	struct in_device *in_dev = __in_dev_get_rcu(dev);
-	struct rtable *rt = skb_rtable(hint);
+	struct rtable *rt = (struct rtable *)dst;
 	struct net *net = dev_net(dev);
 	int err = -EINVAL;
 	u32 tag = 0;
@@ -2165,21 +2179,43 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
 	if (ipv4_is_loopback(saddr) && !IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
 		goto martian_source;
 
-	if (rt->rt_type != RTN_LOCAL)
-		goto skip_validate_source;
+	if (ipv4_is_loopback(daddr) && !IN_DEV_NET_ROUTE_LOCALNET(in_dev, net))
+		goto martian_destination;
 
+	if (rt->rt_type != RTN_LOCAL) {
+		if (!IN_DEV_FORWARD(in_dev)) {
+			err = -EHOSTUNREACH;
+			goto out_err;
+		}
+		goto skip_validate_source;
+	}
 	tos &= IPTOS_RT_MASK;
 	err = fib_validate_source(skb, saddr, daddr, tos, 0, dev, in_dev, &tag);
 	if (err < 0)
 		goto martian_source;
 
+	if (err)
+		ip_route_set_doredirect(in_dev, out_dev, skb, rt->rt_gw_family,
+					rt->rt_gw4, saddr);
+
 skip_validate_source:
-	skb_dst_copy(skb, hint);
+	skb_dst_set_noref(skb, dst);
 	return 0;
 
 martian_source:
 	ip_handle_martian_source(dev, in_dev, skb, daddr, saddr);
+out_err:
 	return err;
+
+martian_destination:
+	RT_CACHE_STAT_INC(in_martian_dst);
+#ifdef CONFIG_IP_ROUTE_VERBOSE
+		if (IN_DEV_LOG_MARTIANS(in_dev))
+			net_warn_ratelimited("martian destination %pI4 from %pI4, dev %s\n",
+					     &daddr, &saddr, dev->name);
+#endif
+	err = -EINVAL;
+	goto out_err;
 }
 
 /* get device for dst_alloc with local routes */
@@ -2200,7 +2236,7 @@ static struct net_device *ip_rt_get_dev(struct net *net,
  *	addresses, because every properly looped back packet
  *	must have correct destination already attached by output routine.
  *	Changes in the enforced policies must be applied also to
- *	ip_route_use_hint().
+ *	ip_route_use_dst_cache().
  *
  *	Such approach solves two big problems:
  *	1. Not simplex devices are handled properly.
-- 
2.34.1



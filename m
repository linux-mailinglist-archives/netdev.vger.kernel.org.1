Return-Path: <netdev+bounces-108515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FD6E9240D4
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 16:27:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 287A61F22E9F
	for <lists+netdev@lfdr.de>; Tue,  2 Jul 2024 14:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E1E01BA083;
	Tue,  2 Jul 2024 14:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBwP7JhW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com [209.85.128.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2349C1BA085;
	Tue,  2 Jul 2024 14:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719930409; cv=none; b=YbuRiGtyyV95PEoqmVcvmzVqxKEQfiGONOcsoDVwnckGLv6fHh1gYmOvthxFS9WaZt2BEx78517evArK01PiH0G83/MCWPREl43GuYoMJU4Rkq7EHGnyB0nx8YsE5VIj61rUgI4FptYi+RtIPP10bMwePxkGdNFvLpVci2T4T2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719930409; c=relaxed/simple;
	bh=dl8FkdynMjnA9nS0bhjP2pvFH6zj6J4RYlUU3UzZN6w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TuEdfTQTQ3jlrGPwRUYViUeFACNN42ytBv2UWv2x/y40dzR/SY1US9eQvenOOrxRs47o3J023pigLdcNjAP/hBnjUetzuNXQXD9/ovj7I+AFwvip80dk2MoXxdBnNgxtsjhCLtlHkh4SzlL3EF9/PE9Vp2rc3dvz4KBnRhnLoA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBwP7JhW; arc=none smtp.client-ip=209.85.128.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f68.google.com with SMTP id 5b1f17b1804b1-4256742f67fso30983895e9.3;
        Tue, 02 Jul 2024 07:26:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719930405; x=1720535205; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=svAbMYyhuwz/6U/mPJ02gUEICZnKb4zi0CpoXAVmtgs=;
        b=VBwP7JhWvLUilpggfC5iyOgFMu/r/VHrg51v7GSmm/nt6+/FTCeS/2BDCsAtGDeQMr
         yB5JO5rJeiSY1rmcMfWKXRIdO36Q9AzkhM3rT6Wy+r3OEk6GnW/bmFsN3v1Kqj/ujFIl
         sNhlVzb/6vqBZHJKufVsd4U67SORSl8W3amPmOBKQneIaNT0VTaRN029Puiy1Efx0775
         PyKkqbCrktqq8ftrpPIINwXhV/oO2bIMbiiSy+reCf0emjHrvAVve790NVWGH5vCaV8k
         udx9gweEdYS+GNWc5HBPE2tW7QXIPiukY+faK5UyKYpFq3cw68timIWtOz6/YEYy0Fol
         OTMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719930405; x=1720535205;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=svAbMYyhuwz/6U/mPJ02gUEICZnKb4zi0CpoXAVmtgs=;
        b=ZKUyESZNHyCHGZNTXrEanBz9YDVUmMxhUhDei00c2OSZ4A5gpzkSx2iPJF0OHenHub
         2P1KVxtfSpRDFbhTbyKxFmBdHZ8ng3zCg2GeuWJRRrSGJ1EzWpSnRS3MBQkCaW6Yupcn
         CLEvAg3qPbPOHjgjvZbdCyqROi5uzTTH/FMnpQsihHuoMH4EpB9AtPdg7rpdO1ZdAbo/
         jm7b5YhxTQfRGpKMM6Jelir3TAZd8ZvdlR4TC+qF3XV+61DFUU5JMiWVvyndR7SpujJI
         Ip4gos2peVKWwd9IEd03SNR4+O7vfVXTEk8U5UeXmwQD2caANlkHJHObHDuH2nbeGw+M
         d3+g==
X-Forwarded-Encrypted: i=1; AJvYcCXw2JjoDmMmNUVHgb77eMx4MwGqq+pxRmLCm0pQnw1r8u9w9Sf+LxwbvQeBn9VqCJ65HjKtCDGOtNDjGp458lP+l98qgDsMRSSJqAvle5+9NOoBBf2TVBFEOY/7yUNnLJE1X6KA
X-Gm-Message-State: AOJu0Yyxuhr9rarO4fIwHfpRMW1Ll7iyPuCpZonI6Zd7ppGPv+0viJka
	44RwTdZcPPYSmzceS2Sxp65bCp0363Q97ZvL5veLJfzAI560YmgE
X-Google-Smtp-Source: AGHT+IHjbX8RBidW/fRg1UwjOoD8GR7Or4Bg156RI8xT5xQs4yF7RpodgpTaDdIIRv9SsHdhPLdnqg==
X-Received: by 2002:a05:600c:4e8c:b0:425:6726:ab25 with SMTP id 5b1f17b1804b1-42579fff44emr53513355e9.4.1719930405300;
        Tue, 02 Jul 2024 07:26:45 -0700 (PDT)
Received: from localhost ([45.130.85.5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4256b09a073sm199774075e9.32.2024.07.02.07.26.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Jul 2024 07:26:45 -0700 (PDT)
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
Date: Tue,  2 Jul 2024 16:24:06 +0200
Message-Id: <20240702142406.465415-5-leone4fernando@gmail.com>
In-Reply-To: <20240702142406.465415-1-leone4fernando@gmail.com>
References: <20240702142406.465415-1-leone4fernando@gmail.com>
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
index fd0883da7834..fde37f434d38 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1764,6 +1764,24 @@ static void ip_handle_martian_source(struct net_device *dev,
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
@@ -1796,15 +1814,10 @@ static int __mkroute_input(struct sk_buff *skb,
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
@@ -2134,14 +2147,15 @@ static int ip_mkroute_input(struct sk_buff *skb,
 
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
@@ -2158,21 +2172,43 @@ int ip_route_use_hint(struct sk_buff *skb, __be32 daddr, __be32 saddr,
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
@@ -2193,7 +2229,7 @@ static struct net_device *ip_rt_get_dev(struct net *net,
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



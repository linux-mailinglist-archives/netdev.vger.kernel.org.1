Return-Path: <netdev+bounces-92152-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3658B59F6
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 15:30:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 037F528CBCA
	for <lists+netdev@lfdr.de>; Mon, 29 Apr 2024 13:30:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569E2757E3;
	Mon, 29 Apr 2024 13:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q7A9aw7S"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C5977581A
	for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 13:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714397413; cv=none; b=GI+o/NVVq/9LeBoSBgCrcz2KOZgCMXKFo1Zz9Q0aiw9hFSYrvEZmVe27KtJd6DFc11FDYCBufKT6Mj/9b3hrkNUX+dF2k13BHEDPUGUzvbXahcTISloTSD5yuw0mc0yQn3xwog40Y0TXLJYdRif1loRX0GxqYIH1V+EtpmBzFlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714397413; c=relaxed/simple;
	bh=prSozhHDw4VXm7zfEOh4N7CNEzYCCoqGj3lCDC4kves=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=cRsKMl69UMOJTmta5hKDK6BM0+3F66+7JFem2sSNMbhoAJg+aWMoyvzOlmrG6WErU/rA6AXymFYUmMmDxQrOJwMYCIefemI2E/r6GJ16C7RRv2k5RSAfh2Kb5Rj2hY8t0/kbGMe/BgOsrojaPPUvC6zcEIj+0UkBTlGF6Cbq2nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q7A9aw7S; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbf216080f5so7959621276.1
        for <netdev@vger.kernel.org>; Mon, 29 Apr 2024 06:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714397410; x=1715002210; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=/qPpWSU5A1JxbWsoIL9/icOu0B6ZU/ZLGXEBwznJSEc=;
        b=q7A9aw7SsGXl6rMf/0FXGY+D2+PIFCEc3aEYF50eYmqjKxjrZ+Jr1P5psW8NTap8qA
         OxJFTnY41kdzWRYJDZTJqXerii2z4DrmP1RJskdd01174nZQ5zjT/RrdURODrPQoXwH7
         tJMlF5dgll1eyzTfzujo8RgQWh87OTd93qSLDIUwFY+CeUId/BGU8c2WmbJQ3vGd01ui
         Ixgemo3q57TX4x2uoQ7WyvLLZYU8hIvRJ3NvOJQv063DLi9IPcezSeClsHvn/R/rKaX9
         zUzwwgSkfSdS3vovcMMLlA0Rsg2CBcvlnsPrCxTWa8eLKsPSPj4IkrfBElULXoExIO03
         9guQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714397410; x=1715002210;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/qPpWSU5A1JxbWsoIL9/icOu0B6ZU/ZLGXEBwznJSEc=;
        b=OsVEJpX06InMSFT85kH5LJ0YNMMutUDFDzQI8Oa7ByP3Rqzj4K/diQXR708qCdSyZ3
         onmWi8GtifbYTaPGlJU10a1Ut6kz7ckldCoHULAwlPejiY/t+SbXV+hmGoDsbWsqri9x
         9PpS2tQSPSeCNv08m7Mb4oOYPDC3UDGs1o7EJgQdVRzWEyR7KW4XVwLKHxmDiUL3Ym39
         pScBrffDFk7/bSpjjyjtlzqNUXEQC6Vz+JIVVHMG4Xk5R0nKu8P+ZGhPMeidPZjyp69l
         IIMm897I1dmt1cWiGD9gZWlMSVStHL7bkSAXD6j43Vm7fwwoi2gQ9qq2KQ/fgXPXDEvg
         6IlQ==
X-Forwarded-Encrypted: i=1; AJvYcCVAwyRa9a9gybh8/uGOAi1kCTfs+hGE1N48La9MU8iEgiNeY+vdb8QOTDVlEP29fwiZT6zZHSXm89T2YBR89B4YSzZ9GwM8
X-Gm-Message-State: AOJu0Yx1oU4AQOyIaO10lsSAL1J0oiM8b4k/0WpdAFm/MtY5+lSm9c2G
	tdWSBJJCWqUC90Z3IWzyTFUoa+LARyJOD6jbHZdCsEGiQCe3GftFhlgyjahFphiKBN2PbKCjalq
	viiUtHeziCQ==
X-Google-Smtp-Source: AGHT+IEI8mBZU1A03Cn2rxOWbetKGwQ98ipQI3s6pxL9kfwnpubW97XPsWun3XJXXYUepAxR6q3EzRPjZGufhA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d38d:0:b0:de4:c2d4:e14f with SMTP id
 e135-20020a25d38d000000b00de4c2d4e14fmr3361627ybf.11.1714397410206; Mon, 29
 Apr 2024 06:30:10 -0700 (PDT)
Date: Mon, 29 Apr 2024 13:30:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240429133009.1227754-1-edumazet@google.com>
Subject: [PATCH net-next] inet: introduce dst_rtable() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

I added dst_rt6_info() in commit
e8dfd42c17fa ("ipv6: introduce dst_rt6_info() helper")

This patch does a similar change for IPv4.

Instead of (struct rtable *)dst casts, we can use :

 #define dst_rtable(_ptr) \
             container_of_const(_ptr, struct rtable, dst)

Patch is smaller than IPv6 one, because IPv4 has skb_rtable() helper.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/infiniband/core/addr.c   | 12 +++---------
 drivers/net/vrf.c                |  2 +-
 drivers/s390/net/qeth_core.h     |  5 ++---
 include/linux/skbuff.h           |  9 ---------
 include/net/ip.h                 |  4 ++--
 include/net/route.h              | 11 +++++++++++
 net/atm/clip.c                   |  2 +-
 net/core/dst_cache.c             |  2 +-
 net/core/filter.c                |  3 +--
 net/ipv4/af_inet.c               |  2 +-
 net/ipv4/icmp.c                  | 26 ++++++++++++++------------
 net/ipv4/ip_input.c              |  2 +-
 net/ipv4/ip_output.c             |  8 ++++----
 net/ipv4/route.c                 | 24 +++++++++++-------------
 net/ipv4/udp.c                   |  2 +-
 net/ipv4/xfrm4_policy.c          |  2 +-
 net/l2tp/l2tp_ip.c               |  2 +-
 net/mpls/mpls_iptunnel.c         |  2 +-
 net/netfilter/ipvs/ip_vs_xmit.c  |  2 +-
 net/netfilter/nf_flow_table_ip.c |  4 ++--
 net/netfilter/nft_rt.c           |  2 +-
 net/sctp/protocol.c              |  4 ++--
 net/tipc/udp_media.c             |  2 +-
 23 files changed, 64 insertions(+), 70 deletions(-)

diff --git a/drivers/infiniband/core/addr.c b/drivers/infiniband/core/addr.c
index f20dfe70fa0e4f2f4432e57e6259f756d9a2de49..be0743dac3fff337b3aa59b417068b5edb0e395b 100644
--- a/drivers/infiniband/core/addr.c
+++ b/drivers/infiniband/core/addr.c
@@ -348,16 +348,10 @@ static int dst_fetch_ha(const struct dst_entry *dst,
 
 static bool has_gateway(const struct dst_entry *dst, sa_family_t family)
 {
-	const struct rtable *rt;
-	const struct rt6_info *rt6;
+	if (family == AF_INET)
+		return dst_rtable(dst)->rt_uses_gateway;
 
-	if (family == AF_INET) {
-		rt = container_of(dst, struct rtable, dst);
-		return rt->rt_uses_gateway;
-	}
-
-	rt6 = dst_rt6_info(dst);
-	return rt6->rt6i_flags & RTF_GATEWAY;
+	return dst_rt6_info(dst)->rt6i_flags & RTF_GATEWAY;
 }
 
 static int fetch_ha(const struct dst_entry *dst, struct rdma_dev_addr *dev_addr,
diff --git a/drivers/net/vrf.c b/drivers/net/vrf.c
index 784b9b2d275e9b3c11c57f31750f17a7729c284f..3a252ac5dd28a94bffaeec18ca8a25e85934f4ab 100644
--- a/drivers/net/vrf.c
+++ b/drivers/net/vrf.c
@@ -860,7 +860,7 @@ static int vrf_rt6_create(struct net_device *dev)
 static int vrf_finish_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct rtable *rt = (struct rtable *)dst;
+	struct rtable *rt = dst_rtable(dst);
 	struct net_device *dev = dst->dev;
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
 	struct neighbour *neigh;
diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 5f17a2a5d0e33780f59d85238b14b971b5ab0eda..41fe8a043d61f5ba4569eb54950aff090c08280a 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -970,9 +970,8 @@ static inline struct dst_entry *qeth_dst_check_rcu(struct sk_buff *skb,
 static inline __be32 qeth_next_hop_v4_rcu(struct sk_buff *skb,
 					  struct dst_entry *dst)
 {
-	struct rtable *rt = (struct rtable *) dst;
-
-	return (rt) ? rt_nexthop(rt, ip_hdr(skb)->daddr) : ip_hdr(skb)->daddr;
+	return (dst) ? rt_nexthop(dst_rtable(dst), ip_hdr(skb)->daddr) :
+		       ip_hdr(skb)->daddr;
 }
 
 static inline struct in6_addr *qeth_next_hop_v6_rcu(struct sk_buff *skb,
diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index f76825e5b92a334f7726d7f7c99aa60ec69a8e07..adf75d69770c80c6efce0a59671e737983df6fb6 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -1180,15 +1180,6 @@ static inline bool skb_dst_is_noref(const struct sk_buff *skb)
 	return (skb->_skb_refdst & SKB_DST_NOREF) && skb_dst(skb);
 }
 
-/**
- * skb_rtable - Returns the skb &rtable
- * @skb: buffer
- */
-static inline struct rtable *skb_rtable(const struct sk_buff *skb)
-{
-	return (struct rtable *)skb_dst(skb);
-}
-
 /* For mangling skb->pkt_type from user space side from applications
  * such as nft, tc, etc, we only allow a conservative subset of
  * possible pkt_types to be set.
diff --git a/include/net/ip.h b/include/net/ip.h
index 25cb688bdc62360292e25b0d676f135101a2118c..6d735e00d3f3ec4b01dd8e4fca93432496c0b62c 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -423,7 +423,7 @@ int ip_decrease_ttl(struct iphdr *iph)
 
 static inline int ip_mtu_locked(const struct dst_entry *dst)
 {
-	const struct rtable *rt = (const struct rtable *)dst;
+	const struct rtable *rt = dst_rtable(dst);
 
 	return rt->rt_mtu_locked || dst_metric_locked(dst, RTAX_MTU);
 }
@@ -461,7 +461,7 @@ static inline bool ip_sk_ignore_df(const struct sock *sk)
 static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 						    bool forwarding)
 {
-	const struct rtable *rt = container_of(dst, struct rtable, dst);
+	const struct rtable *rt = dst_rtable(dst);
 	struct net *net = dev_net(dst->dev);
 	unsigned int mtu;
 
diff --git a/include/net/route.h b/include/net/route.h
index 630d1ef6868a58b163fd8de823003680989e2200..93833cfe9c9681252ed490292848b1dc8efb7ecc 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -75,6 +75,17 @@ struct rtable {
 				rt_pmtu:31;
 };
 
+#define dst_rtable(_ptr) container_of_const(_ptr, struct rtable, dst)
+
+/**
+ * skb_rtable - Returns the skb &rtable
+ * @skb: buffer
+ */
+static inline struct rtable *skb_rtable(const struct sk_buff *skb)
+{
+	return dst_rtable(skb_dst(skb));
+}
+
 static inline bool rt_is_input_route(const struct rtable *rt)
 {
 	return rt->rt_is_input != 0;
diff --git a/net/atm/clip.c b/net/atm/clip.c
index 362e8d25a79ec9b90ab30d4ae1832f11bd4bb0ac..42b910cb4e8ee721fb53d3145318138a9c3e8bff 100644
--- a/net/atm/clip.c
+++ b/net/atm/clip.c
@@ -345,7 +345,7 @@ static netdev_tx_t clip_start_xmit(struct sk_buff *skb,
 		dev->stats.tx_dropped++;
 		return NETDEV_TX_OK;
 	}
-	rt = (struct rtable *) dst;
+	rt = dst_rtable(dst);
 	if (rt->rt_gw_family == AF_INET)
 		daddr = &rt->rt_gw4;
 	else
diff --git a/net/core/dst_cache.c b/net/core/dst_cache.c
index b17171345d649b01a96f0eb949c26503479cce1f..0c0bdb058c5b1ab81e14aa48d8612a6253a7c852 100644
--- a/net/core/dst_cache.c
+++ b/net/core/dst_cache.c
@@ -83,7 +83,7 @@ struct rtable *dst_cache_get_ip4(struct dst_cache *dst_cache, __be32 *saddr)
 		return NULL;
 
 	*saddr = idst->in_saddr.s_addr;
-	return container_of(dst, struct rtable, dst);
+	return dst_rtable(dst);
 }
 EXPORT_SYMBOL_GPL(dst_cache_get_ip4);
 
diff --git a/net/core/filter.c b/net/core/filter.c
index 5662464e1abd29230fb72c0db46620153fee7ef9..7c164278ddaa122c1f5de14267b0a69a9174cff3 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2314,8 +2314,7 @@ static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 
 	rcu_read_lock();
 	if (!nh) {
-		struct dst_entry *dst = skb_dst(skb);
-		struct rtable *rt = container_of(dst, struct rtable, dst);
+		struct rtable *rt = skb_rtable(skb);
 
 		neigh = ip_neigh_for_gw(rt, skb, &is_v6gw);
 	} else if (nh->nh_family == AF_INET6) {
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index a7cfeda28bb2fa4f46e5b03423fabd2042c139c0..486a8d4f53b171329ccb529a973f0dbc65897881 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1307,8 +1307,8 @@ static int inet_sk_reselect_saddr(struct sock *sk)
 
 int inet_sk_rebuild_header(struct sock *sk)
 {
+	struct rtable *rt = dst_rtable(__sk_dst_check(sk, 0));
 	struct inet_sock *inet = inet_sk(sk);
-	struct rtable *rt = (struct rtable *)__sk_dst_check(sk, 0);
 	__be32 daddr;
 	struct ip_options_rcu *inet_opt;
 	struct flowi4 *fl4;
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 437e782b9663bb59acb900c0558137ddd401cd02..207482d30dc7edeb8745755916e563acb93bcd1a 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -483,6 +483,7 @@ static struct rtable *icmp_route_lookup(struct net *net,
 					struct icmp_bxm *param)
 {
 	struct net_device *route_lookup_dev;
+	struct dst_entry *dst, *dst2;
 	struct rtable *rt, *rt2;
 	struct flowi4 fl4_dec;
 	int err;
@@ -508,16 +509,17 @@ static struct rtable *icmp_route_lookup(struct net *net,
 	/* No need to clone since we're just using its address. */
 	rt2 = rt;
 
-	rt = (struct rtable *) xfrm_lookup(net, &rt->dst,
-					   flowi4_to_flowi(fl4), NULL, 0);
-	if (!IS_ERR(rt)) {
+	dst = xfrm_lookup(net, &rt->dst,
+			  flowi4_to_flowi(fl4), NULL, 0);
+	rt = dst_rtable(dst);
+	if (!IS_ERR(dst)) {
 		if (rt != rt2)
 			return rt;
-	} else if (PTR_ERR(rt) == -EPERM) {
+	} else if (PTR_ERR(dst) == -EPERM) {
 		rt = NULL;
-	} else
+	} else {
 		return rt;
-
+	}
 	err = xfrm_decode_session_reverse(net, skb_in, flowi4_to_flowi(&fl4_dec), AF_INET);
 	if (err)
 		goto relookup_failed;
@@ -551,19 +553,19 @@ static struct rtable *icmp_route_lookup(struct net *net,
 	if (err)
 		goto relookup_failed;
 
-	rt2 = (struct rtable *) xfrm_lookup(net, &rt2->dst,
-					    flowi4_to_flowi(&fl4_dec), NULL,
-					    XFRM_LOOKUP_ICMP);
-	if (!IS_ERR(rt2)) {
+	dst2 = xfrm_lookup(net, &rt2->dst, flowi4_to_flowi(&fl4_dec), NULL,
+			   XFRM_LOOKUP_ICMP);
+	rt2 = dst_rtable(dst2);
+	if (!IS_ERR(dst2)) {
 		dst_release(&rt->dst);
 		memcpy(fl4, &fl4_dec, sizeof(*fl4));
 		rt = rt2;
-	} else if (PTR_ERR(rt2) == -EPERM) {
+	} else if (PTR_ERR(dst2) == -EPERM) {
 		if (rt)
 			dst_release(&rt->dst);
 		return rt2;
 	} else {
-		err = PTR_ERR(rt2);
+		err = PTR_ERR(dst2);
 		goto relookup_failed;
 	}
 	return rt;
diff --git a/net/ipv4/ip_input.c b/net/ipv4/ip_input.c
index 5e9c8156656a7642acc7a1bb08488b7482e52ce7..d6fbcbd2358a560724e0f107592d25a30e9291d9 100644
--- a/net/ipv4/ip_input.c
+++ b/net/ipv4/ip_input.c
@@ -616,7 +616,7 @@ static void ip_list_rcv_finish(struct net *net, struct sock *sk,
 		dst = skb_dst(skb);
 		if (curr_dst != dst) {
 			hint = ip_extract_route_hint(net, skb,
-					       ((struct rtable *)dst)->rt_type);
+						     dst_rtable(dst)->rt_type);
 
 			/* dispatch old sublist */
 			if (!list_empty(&sublist))
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 1fe794967211e249016df00dc3c2ae230d71dcff..b455bd05a7d5e5e146cb56d4aa0b86462aaed409 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -198,7 +198,7 @@ EXPORT_SYMBOL_GPL(ip_build_and_send_pkt);
 static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-	struct rtable *rt = (struct rtable *)dst;
+	struct rtable *rt = dst_rtable(dst);
 	struct net_device *dev = dst->dev;
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
 	struct neighbour *neigh;
@@ -475,7 +475,7 @@ int __ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl,
 		goto packet_routed;
 
 	/* Make sure we can route this packet. */
-	rt = (struct rtable *)__sk_dst_check(sk, 0);
+	rt = dst_rtable(__sk_dst_check(sk, 0));
 	if (!rt) {
 		__be32 daddr;
 
@@ -971,7 +971,7 @@ static int __ip_append_data(struct sock *sk,
 	bool zc = false;
 	unsigned int maxfraglen, fragheaderlen, maxnonfragsize;
 	int csummode = CHECKSUM_NONE;
-	struct rtable *rt = (struct rtable *)cork->dst;
+	struct rtable *rt = dst_rtable(cork->dst);
 	bool paged, hold_tskey, extra_uref = false;
 	unsigned int wmem_alloc_delta = 0;
 	u32 tskey = 0;
@@ -1390,7 +1390,7 @@ struct sk_buff *__ip_make_skb(struct sock *sk,
 	struct inet_sock *inet = inet_sk(sk);
 	struct net *net = sock_net(sk);
 	struct ip_options *opt = NULL;
-	struct rtable *rt = (struct rtable *)cork->dst;
+	struct rtable *rt = dst_rtable(cork->dst);
 	struct iphdr *iph;
 	u8 pmtudisc, ttl;
 	__be16 df = 0;
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index f89ff2e5a05b06b12861795c1dfb1127f0f05928..0fd9a3d7ac4ab44962c0f254d9fa2a7964143443 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -819,7 +819,7 @@ static void ip_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_buf
 	u32 mark = skb->mark;
 	__u8 tos = iph->tos;
 
-	rt = (struct rtable *) dst;
+	rt = dst_rtable(dst);
 
 	__build_flow_key(net, &fl4, sk, iph, oif, tos, prot, mark, 0);
 	__ip_do_redirect(rt, skb, &fl4, true);
@@ -827,7 +827,7 @@ static void ip_do_redirect(struct dst_entry *dst, struct sock *sk, struct sk_buf
 
 static struct dst_entry *ipv4_negative_advice(struct dst_entry *dst)
 {
-	struct rtable *rt = (struct rtable *)dst;
+	struct rtable *rt = dst_rtable(dst);
 	struct dst_entry *ret = dst;
 
 	if (rt) {
@@ -1044,7 +1044,7 @@ static void ip_rt_update_pmtu(struct dst_entry *dst, struct sock *sk,
 			      struct sk_buff *skb, u32 mtu,
 			      bool confirm_neigh)
 {
-	struct rtable *rt = (struct rtable *) dst;
+	struct rtable *rt = dst_rtable(dst);
 	struct flowi4 fl4;
 
 	ip_rt_build_flow_key(&fl4, sk, skb);
@@ -1115,7 +1115,7 @@ void ipv4_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, u32 mtu)
 
 	__build_flow_key(net, &fl4, sk, iph, 0, 0, 0, 0, 0);
 
-	rt = (struct rtable *)odst;
+	rt = dst_rtable(odst);
 	if (odst->obsolete && !odst->ops->check(odst, 0)) {
 		rt = ip_route_output_flow(sock_net(sk), &fl4, sk);
 		if (IS_ERR(rt))
@@ -1124,7 +1124,7 @@ void ipv4_sk_update_pmtu(struct sk_buff *skb, struct sock *sk, u32 mtu)
 		new = true;
 	}
 
-	__ip_rt_update_pmtu((struct rtable *)xfrm_dst_path(&rt->dst), &fl4, mtu);
+	__ip_rt_update_pmtu(dst_rtable(xfrm_dst_path(&rt->dst)), &fl4, mtu);
 
 	if (!dst_check(&rt->dst, 0)) {
 		if (new)
@@ -1181,7 +1181,7 @@ EXPORT_SYMBOL_GPL(ipv4_sk_redirect);
 INDIRECT_CALLABLE_SCOPE struct dst_entry *ipv4_dst_check(struct dst_entry *dst,
 							 u32 cookie)
 {
-	struct rtable *rt = (struct rtable *) dst;
+	struct rtable *rt = dst_rtable(dst);
 
 	/* All IPV4 dsts are created with ->obsolete set to the value
 	 * DST_OBSOLETE_FORCE_CHK which forces validation calls down
@@ -1516,10 +1516,8 @@ void rt_del_uncached_list(struct rtable *rt)
 
 static void ipv4_dst_destroy(struct dst_entry *dst)
 {
-	struct rtable *rt = (struct rtable *)dst;
-
 	ip_dst_metrics_put(dst);
-	rt_del_uncached_list(rt);
+	rt_del_uncached_list(dst_rtable(dst));
 }
 
 void rt_flush_dev(struct net_device *dev)
@@ -2820,7 +2818,7 @@ static struct dst_ops ipv4_dst_blackhole_ops = {
 
 struct dst_entry *ipv4_blackhole_route(struct net *net, struct dst_entry *dst_orig)
 {
-	struct rtable *ort = (struct rtable *) dst_orig;
+	struct rtable *ort = dst_rtable(dst_orig);
 	struct rtable *rt;
 
 	rt = dst_alloc(&ipv4_dst_blackhole_ops, NULL, DST_OBSOLETE_DEAD, 0);
@@ -2865,9 +2863,9 @@ struct rtable *ip_route_output_flow(struct net *net, struct flowi4 *flp4,
 
 	if (flp4->flowi4_proto) {
 		flp4->flowi4_oif = rt->dst.dev->ifindex;
-		rt = (struct rtable *)xfrm_lookup_route(net, &rt->dst,
-							flowi4_to_flowi(flp4),
-							sk, 0);
+		rt = dst_rtable(xfrm_lookup_route(net, &rt->dst,
+						  flowi4_to_flowi(flp4),
+						  sk, 0));
 	}
 
 	return rt;
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 6e244629508975a58bc58ac0f0b51a45eb9b171d..fe55ff5d379b4d6e7c51f67fbd74746eae3b9b55 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1217,7 +1217,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	}
 
 	if (connected)
-		rt = (struct rtable *)sk_dst_check(sk, 0);
+		rt = dst_rtable(sk_dst_check(sk, 0));
 
 	if (!rt) {
 		struct net *net = sock_net(sk);
diff --git a/net/ipv4/xfrm4_policy.c b/net/ipv4/xfrm4_policy.c
index 1dda59e0aeab60a8c14b8213bf6d960c4376ba43..fccbbd3e1a4b60671e468ef67737f21519aecaf7 100644
--- a/net/ipv4/xfrm4_policy.c
+++ b/net/ipv4/xfrm4_policy.c
@@ -69,7 +69,7 @@ static int xfrm4_get_saddr(struct net *net, int oif,
 static int xfrm4_fill_dst(struct xfrm_dst *xdst, struct net_device *dev,
 			  const struct flowi *fl)
 {
-	struct rtable *rt = (struct rtable *)xdst->route;
+	struct rtable *rt = dst_rtable(xdst->route);
 	const struct flowi4 *fl4 = &fl->u.ip4;
 
 	xdst->u.rt.rt_iif = fl4->flowi4_iif;
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 970af3983d11672325f7e5ee3be3448a4f200808..19c8cc5289d5953559d09c92fc26478dc5412610 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -459,7 +459,7 @@ static int l2tp_ip_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 	fl4 = &inet->cork.fl.u.ip4;
 	if (connected)
-		rt = (struct rtable *)__sk_dst_check(sk, 0);
+		rt = dst_rtable(__sk_dst_check(sk, 0));
 
 	rcu_read_lock();
 	if (!rt) {
diff --git a/net/mpls/mpls_iptunnel.c b/net/mpls/mpls_iptunnel.c
index 606349c8df0e67aab833e375c642303078c9e939..4385fd3b13be30f94b730e3c9b87936aacbbabd0 100644
--- a/net/mpls/mpls_iptunnel.c
+++ b/net/mpls/mpls_iptunnel.c
@@ -81,7 +81,7 @@ static int mpls_xmit(struct sk_buff *skb)
 			ttl = net->mpls.default_ttl;
 		else
 			ttl = ip_hdr(skb)->ttl;
-		rt = (struct rtable *)dst;
+		rt = dst_rtable(dst);
 	} else if (dst->ops->family == AF_INET6) {
 		if (tun_encap_info->ttl_propagate == MPLS_TTL_PROP_DISABLED)
 			ttl = tun_encap_info->default_ttl;
diff --git a/net/netfilter/ipvs/ip_vs_xmit.c b/net/netfilter/ipvs/ip_vs_xmit.c
index 6e8b9d100ad275c8a22d7f6b0c27fade464f045f..3313bceb6cc99d504f9a35ff5b5987c7474930c9 100644
--- a/net/netfilter/ipvs/ip_vs_xmit.c
+++ b/net/netfilter/ipvs/ip_vs_xmit.c
@@ -318,7 +318,7 @@ __ip_vs_get_out_rt(struct netns_ipvs *ipvs, int skb_af, struct sk_buff *skb,
 	if (dest) {
 		dest_dst = __ip_vs_dst_check(dest);
 		if (likely(dest_dst))
-			rt = (struct rtable *) dest_dst->dst_cache;
+			rt = dst_rtable(dest_dst->dst_cache);
 		else {
 			dest_dst = ip_vs_dest_dst_alloc();
 			spin_lock_bh(&dest->dst_lock);
diff --git a/net/netfilter/nf_flow_table_ip.c b/net/netfilter/nf_flow_table_ip.c
index 100887beed314de3c72ca2e7181c72aca02ae165..c2c005234dcd385a1377f3ab34c27f82d9b18b0c 100644
--- a/net/netfilter/nf_flow_table_ip.c
+++ b/net/netfilter/nf_flow_table_ip.c
@@ -434,7 +434,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 		return NF_ACCEPT;
 
 	if (unlikely(tuplehash->tuple.xmit_type == FLOW_OFFLOAD_XMIT_XFRM)) {
-		rt = (struct rtable *)tuplehash->tuple.dst_cache;
+		rt = dst_rtable(tuplehash->tuple.dst_cache);
 		memset(skb->cb, 0, sizeof(struct inet_skb_parm));
 		IPCB(skb)->iif = skb->dev->ifindex;
 		IPCB(skb)->flags = IPSKB_FORWARDED;
@@ -446,7 +446,7 @@ nf_flow_offload_ip_hook(void *priv, struct sk_buff *skb,
 
 	switch (tuplehash->tuple.xmit_type) {
 	case FLOW_OFFLOAD_XMIT_NEIGH:
-		rt = (struct rtable *)tuplehash->tuple.dst_cache;
+		rt = dst_rtable(tuplehash->tuple.dst_cache);
 		outdev = rt->dst.dev;
 		skb->dev = outdev;
 		nexthop = rt_nexthop(rt, flow->tuplehash[!dir].tuple.src_v4.s_addr);
diff --git a/net/netfilter/nft_rt.c b/net/netfilter/nft_rt.c
index 2434c624aafde17dfcbe358328f950540985a8b6..14d88394bcb7f5f4c35bbfe523d0a0a9d5bf5fbb 100644
--- a/net/netfilter/nft_rt.c
+++ b/net/netfilter/nft_rt.c
@@ -73,7 +73,7 @@ void nft_rt_get_eval(const struct nft_expr *expr,
 		if (nft_pf(pkt) != NFPROTO_IPV4)
 			goto err;
 
-		*dest = (__force u32)rt_nexthop((const struct rtable *)dst,
+		*dest = (__force u32)rt_nexthop(dst_rtable(dst),
 						ip_hdr(skb)->daddr);
 		break;
 	case NFT_RT_NEXTHOP6:
diff --git a/net/sctp/protocol.c b/net/sctp/protocol.c
index e849f368ed91348ed0024bed47eb59345bf91d9b..5a7436a13b741525770e941cc0e01c73d7db4704 100644
--- a/net/sctp/protocol.c
+++ b/net/sctp/protocol.c
@@ -552,7 +552,7 @@ static void sctp_v4_get_saddr(struct sctp_sock *sk,
 			      struct flowi *fl)
 {
 	union sctp_addr *saddr = &t->saddr;
-	struct rtable *rt = (struct rtable *)t->dst;
+	struct rtable *rt = dst_rtable(t->dst);
 
 	if (rt) {
 		saddr->v4.sin_family = AF_INET;
@@ -1085,7 +1085,7 @@ static inline int sctp_v4_xmit(struct sk_buff *skb, struct sctp_transport *t)
 	skb_reset_inner_mac_header(skb);
 	skb_reset_inner_transport_header(skb);
 	skb_set_inner_ipproto(skb, IPPROTO_SCTP);
-	udp_tunnel_xmit_skb((struct rtable *)dst, sk, skb, fl4->saddr,
+	udp_tunnel_xmit_skb(dst_rtable(dst), sk, skb, fl4->saddr,
 			    fl4->daddr, dscp, ip4_dst_hoplimit(dst), df,
 			    sctp_sk(sk)->udp_port, t->encap_port, false, false);
 	return 0;
diff --git a/net/tipc/udp_media.c b/net/tipc/udp_media.c
index f892b0903dbaf2c482dee04742a8714769f8a0d1..b849a3d133a01cffe2b6edab7cff17fab37a8eb0 100644
--- a/net/tipc/udp_media.c
+++ b/net/tipc/udp_media.c
@@ -174,7 +174,7 @@ static int tipc_udp_xmit(struct net *net, struct sk_buff *skb,
 	local_bh_disable();
 	ndst = dst_cache_get(cache);
 	if (dst->proto == htons(ETH_P_IP)) {
-		struct rtable *rt = (struct rtable *)ndst;
+		struct rtable *rt = dst_rtable(ndst);
 
 		if (!rt) {
 			struct flowi4 fl = {
-- 
2.44.0.769.g3c40516874-goog



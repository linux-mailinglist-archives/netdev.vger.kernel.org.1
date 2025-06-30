Return-Path: <netdev+bounces-202414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 664E9AEDC97
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 14:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47CB73ABF8E
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 12:19:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BECA028A1F2;
	Mon, 30 Jun 2025 12:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ja3sRvaW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F94289813
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 12:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751285989; cv=none; b=WsEieratBtqh2KyYnOQGliGaieQnglbvAana00CUX63F26RNu4N9pPwJh43YG0U5mAm6AAr3Y0tINzB35TRUwMhI2JSRx0BdM7Zp29GN1gwjFXnN8Fc40nGFv9ZR9f9/ps9COfxQIQds554vaUSBag+xDUMO5q7PobJgE3czlCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751285989; c=relaxed/simple;
	bh=IxUQsOY8Tm2u6NNRUV5CVK7jOyCsWwN/4IIm0laZQOc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=fnb/meClc56WG/Sn2P6Pc19ATNvBr1k7M/n8O+Q24DIpD1jwhjoiMTruF9giFsyR9LNwRZ0czrZkYCFXWAqM+/AhX3mHTSv/VbLtFw7I1yBGm5Max0F+R8dPi+39W/4TpZwkHQo5Kz0Go270+JIH0vKbhllMzoA6DLRscYAIHeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ja3sRvaW; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-4a58f455cdbso28082901cf.3
        for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 05:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1751285987; x=1751890787; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rpQeLedM6jaJteLUUecVGVBgejG9XLQRCwxjmeoRKqw=;
        b=ja3sRvaWcFMWP1y83JrdKmsWxPVZOjbRrfzJJ9D5YHS5OC4KARv0+qhNz12fmH1fly
         Te7UYRZe4JsF3bwqLUkY2GVUAiXPMUnZXT65NdU2OYtEaFFHylPXOoHx+2Y1p3I2BZdp
         wATih9hMvtONeOgs9fkd1xFLBcwYN0GgboKgRw0tfyFeMeeq7qE5ejRb7PO8D87U6Iy0
         mKo9SNtO0jNKb4MkBM19BWaNcvfUHp++TBNzBse3LbntN4L0k3NOU4tDxBS+nLBVEi/F
         TYmQMutsjIXxgjoT7BvWJouZg7rXrE/Y/kix0BdVpqDp9e68KXrn6Ugkf0S1r6+YRseQ
         8uYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751285987; x=1751890787;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rpQeLedM6jaJteLUUecVGVBgejG9XLQRCwxjmeoRKqw=;
        b=orCxd/llsPHaPau/q+tyCnSYj6lblrEYphcIEZ5Hq6vBcUrJhytMv94LX8Lqfoz32i
         nnMSlQGLa/m/0B/E2cZ5hwXQU/ZVtL/X0Y9B0D+bW2LKUYXLknkzAw7um2xyPUQw0YO1
         QefxaTzenIPzXF0Dx9E03qCihIYdCcfTBskclkaQBd3Asc0G9fmmbj2m+3tete4Dafxt
         iH6j9pBn5UmdBB3AAficiN3KoNF949IWwIQ92H1hC2Hgv2TV7Ed3luZpqVElvQF1pkF9
         bNmorxcXubveteJSWxwRXscJqE9Wa6H8y/hdMzTldbddelavHRu9jA91ZFCO/jSqbGJF
         BJzg==
X-Forwarded-Encrypted: i=1; AJvYcCW7ys6jXctBEc4FcRAiSMnAWVsNalJu6DSLCkpGoNJ4U5hSYKDa1IWZ86DNk0FSd8mixJqJPCE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyN+J8JdvAh4642zm/U1oU41lghCuDCOQiTNMKDBjM9SO8qaw5W
	oT5l/CaJrE3XRRF0h7T740kbPNvpgMUgThWN1r+pvtlMHWLyHKzc51bNb01cwlIMazjjlI9Yiff
	aLhksAK432KOURQ==
X-Google-Smtp-Source: AGHT+IFJYXcn7S+HdbUQ/swGJ/u5zXvMyVIOEPyG7xcGnHA8H4fycOmvIWgIDby8688sEJfZ8ZZQmQSnmqA2Cg==
X-Received: from qtbfb17.prod.google.com ([2002:a05:622a:4811:b0:48d:7c07:9ac2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:118c:b0:476:8d3d:adb6 with SMTP id d75a77b69052e-4a7fcae0448mr217505291cf.23.1751285986883;
 Mon, 30 Jun 2025 05:19:46 -0700 (PDT)
Date: Mon, 30 Jun 2025 12:19:31 +0000
In-Reply-To: <20250630121934.3399505-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250630121934.3399505-1-edumazet@google.com>
X-Mailer: git-send-email 2.50.0.727.gbf7dc18ff4-goog
Message-ID: <20250630121934.3399505-8-edumazet@google.com>
Subject: [PATCH v2 net-next 07/10] ipv4: adopt dst_dev, skb_dst_dev and skb_dst_dev_net[_rcu]
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Use the new helpers as a first step to deal with
potential dst->dev races.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 include/net/inet_hashtables.h |  2 +-
 include/net/ip.h              | 11 ++++++-----
 include/net/route.h           |  2 +-
 net/ipv4/icmp.c               | 24 +++++++++++++-----------
 net/ipv4/igmp.c               |  2 +-
 net/ipv4/ip_fragment.c        |  2 +-
 net/ipv4/ip_output.c          |  6 +++---
 net/ipv4/ip_vti.c             |  4 ++--
 net/ipv4/netfilter.c          |  4 ++--
 net/ipv4/route.c              |  8 ++++----
 net/ipv4/tcp_fastopen.c       |  4 +++-
 net/ipv4/tcp_ipv4.c           |  2 +-
 net/ipv4/tcp_metrics.c        |  8 ++++----
 net/ipv4/xfrm4_output.c       |  2 +-
 14 files changed, 43 insertions(+), 38 deletions(-)

diff --git a/include/net/inet_hashtables.h b/include/net/inet_hashtables.h
index ae09e91398a5d3253750547ef4bb100d00b419ef..19dbd9081d5a5e75946c1306e7a63b6fd35434c7 100644
--- a/include/net/inet_hashtables.h
+++ b/include/net/inet_hashtables.h
@@ -481,7 +481,7 @@ static inline struct sock *__inet_lookup_skb(struct inet_hashinfo *hashinfo,
 					     const int sdif,
 					     bool *refcounted)
 {
-	struct net *net = dev_net_rcu(skb_dst(skb)->dev);
+	struct net *net = skb_dst_dev_net_rcu(skb);
 	const struct iphdr *iph = ip_hdr(skb);
 	struct sock *sk;
 
diff --git a/include/net/ip.h b/include/net/ip.h
index 391af454422ebe25ba984398a2226f7ed88abe1d..befcba575129ac436912d9c19740a0a72fe23954 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -472,7 +472,7 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 
 	rcu_read_lock();
 
-	net = dev_net_rcu(dst->dev);
+	net = dev_net_rcu(dst_dev(dst));
 	if (READ_ONCE(net->ipv4.sysctl_ip_fwd_use_pmtu) ||
 	    ip_mtu_locked(dst) ||
 	    !forwarding) {
@@ -486,7 +486,7 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 	if (mtu)
 		goto out;
 
-	mtu = READ_ONCE(dst->dev->mtu);
+	mtu = READ_ONCE(dst_dev(dst)->mtu);
 
 	if (unlikely(ip_mtu_locked(dst))) {
 		if (rt->rt_uses_gateway && mtu > 576)
@@ -506,16 +506,17 @@ static inline unsigned int ip_dst_mtu_maybe_forward(const struct dst_entry *dst,
 static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
 					  const struct sk_buff *skb)
 {
+	const struct dst_entry *dst = skb_dst(skb);
 	unsigned int mtu;
 
 	if (!sk || !sk_fullsock(sk) || ip_sk_use_pmtu(sk)) {
 		bool forwarding = IPCB(skb)->flags & IPSKB_FORWARDED;
 
-		return ip_dst_mtu_maybe_forward(skb_dst(skb), forwarding);
+		return ip_dst_mtu_maybe_forward(dst, forwarding);
 	}
 
-	mtu = min(READ_ONCE(skb_dst(skb)->dev->mtu), IP_MAX_MTU);
-	return mtu - lwtunnel_headroom(skb_dst(skb)->lwtstate, mtu);
+	mtu = min(READ_ONCE(dst_dev(dst)->mtu), IP_MAX_MTU);
+	return mtu - lwtunnel_headroom(dst->lwtstate, mtu);
 }
 
 struct dst_metrics *ip_fib_metrics_init(struct nlattr *fc_mx, int fc_mx_len,
diff --git a/include/net/route.h b/include/net/route.h
index 3d3d6048ffca2b09b7e8885b04dd3f6db7a3e5cb..7ea840daa775b29d88cf7125a9d168599be6545d 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -390,7 +390,7 @@ static inline int ip4_dst_hoplimit(const struct dst_entry *dst)
 		const struct net *net;
 
 		rcu_read_lock();
-		net = dev_net_rcu(dst->dev);
+		net = dev_net_rcu(dst_dev(dst));
 		hoplimit = READ_ONCE(net->ipv4.sysctl_ip_default_ttl);
 		rcu_read_unlock();
 	}
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 717cb7d3607a1c77a3f54b56d2bb98b1064dd878..2ffe73ea644ff71add3911f213735e8ebda590c0 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -311,18 +311,20 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 {
 	struct dst_entry *dst = &rt->dst;
 	struct inet_peer *peer;
+	struct net_device *dev;
 	bool rc = true;
 
 	if (!apply_ratelimit)
 		return true;
 
 	/* No rate limit on loopback */
-	if (dst->dev && (dst->dev->flags&IFF_LOOPBACK))
+	dev = dst_dev(dst);
+	if (dev && (dev->flags & IFF_LOOPBACK))
 		goto out;
 
 	rcu_read_lock();
 	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr,
-			       l3mdev_master_ifindex_rcu(dst->dev));
+			       l3mdev_master_ifindex_rcu(dev));
 	rc = inet_peer_xrlim_allow(peer,
 				   READ_ONCE(net->ipv4.sysctl_icmp_ratelimit));
 	rcu_read_unlock();
@@ -466,13 +468,13 @@ static void icmp_reply(struct icmp_bxm *icmp_param, struct sk_buff *skb)
  */
 static struct net_device *icmp_get_route_lookup_dev(struct sk_buff *skb)
 {
-	struct net_device *route_lookup_dev = NULL;
+	struct net_device *dev = skb->dev;
+	const struct dst_entry *dst;
 
-	if (skb->dev)
-		route_lookup_dev = skb->dev;
-	else if (skb_dst(skb))
-		route_lookup_dev = skb_dst(skb)->dev;
-	return route_lookup_dev;
+	if (dev)
+		return dev;
+	dst = skb_dst(skb);
+	return dst ? dst_dev(dst) : NULL;
 }
 
 static struct rtable *icmp_route_lookup(struct net *net, struct flowi4 *fl4,
@@ -869,7 +871,7 @@ static enum skb_drop_reason icmp_unreach(struct sk_buff *skb)
 	struct net *net;
 	u32 info = 0;
 
-	net = dev_net_rcu(skb_dst(skb)->dev);
+	net = skb_dst_dev_net_rcu(skb);
 
 	/*
 	 *	Incomplete header ?
@@ -1012,7 +1014,7 @@ static enum skb_drop_reason icmp_echo(struct sk_buff *skb)
 	struct icmp_bxm icmp_param;
 	struct net *net;
 
-	net = dev_net_rcu(skb_dst(skb)->dev);
+	net = skb_dst_dev_net_rcu(skb);
 	/* should there be an ICMP stat for ignored echos? */
 	if (READ_ONCE(net->ipv4.sysctl_icmp_echo_ignore_all))
 		return SKB_NOT_DROPPED_YET;
@@ -1182,7 +1184,7 @@ static enum skb_drop_reason icmp_timestamp(struct sk_buff *skb)
 	return SKB_NOT_DROPPED_YET;
 
 out_err:
-	__ICMP_INC_STATS(dev_net_rcu(skb_dst(skb)->dev), ICMP_MIB_INERRORS);
+	__ICMP_INC_STATS(skb_dst_dev_net_rcu(skb), ICMP_MIB_INERRORS);
 	return SKB_DROP_REASON_PKT_TOO_SMALL;
 }
 
diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
index d1769034b6438bb5c994e1660b181e05109ab365..7182f1419c2a4d4ea1e90ef6857f6af895dd2770 100644
--- a/net/ipv4/igmp.c
+++ b/net/ipv4/igmp.c
@@ -427,7 +427,7 @@ static int igmpv3_sendpack(struct sk_buff *skb)
 
 	pig->csum = ip_compute_csum(igmp_hdr(skb), igmplen);
 
-	return ip_local_out(dev_net(skb_dst(skb)->dev), skb->sk, skb);
+	return ip_local_out(skb_dst_dev_net(skb), skb->sk, skb);
 }
 
 static int grec_size(struct ip_mc_list *pmc, int type, int gdel, int sdel)
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 64b3fb3208af65b569f37575467060797acf7002..b2584cce90ae1c14550396de486131b700d4afd7 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -476,7 +476,7 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
 /* Process an incoming IP datagram fragment. */
 int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 {
-	struct net_device *dev = skb->dev ? : skb_dst(skb)->dev;
+	struct net_device *dev = skb->dev ? : skb_dst_dev(skb);
 	int vif = l3mdev_master_ifindex_rcu(dev);
 	struct ipq *qp;
 
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index a2705d454fd645b442b2901833afa51b26512512..414b47a0d513fd4a8acfe1a101b91fad8efcc4d4 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -116,7 +116,7 @@ int __ip_local_out(struct net *net, struct sock *sk, struct sk_buff *skb)
 	skb->protocol = htons(ETH_P_IP);
 
 	return nf_hook(NFPROTO_IPV4, NF_INET_LOCAL_OUT,
-		       net, sk, skb, NULL, skb_dst(skb)->dev,
+		       net, sk, skb, NULL, skb_dst_dev(skb),
 		       dst_output);
 }
 
@@ -199,7 +199,7 @@ static int ip_finish_output2(struct net *net, struct sock *sk, struct sk_buff *s
 {
 	struct dst_entry *dst = skb_dst(skb);
 	struct rtable *rt = dst_rtable(dst);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 	unsigned int hh_len = LL_RESERVED_SPACE(dev);
 	struct neighbour *neigh;
 	bool is_v6gw = false;
@@ -425,7 +425,7 @@ int ip_mc_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 int ip_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
-	struct net_device *dev = skb_dst(skb)->dev, *indev = skb->dev;
+	struct net_device *dev = skb_dst_dev(skb), *indev = skb->dev;
 
 	skb->dev = dev;
 	skb->protocol = htons(ETH_P_IP);
diff --git a/net/ipv4/ip_vti.c b/net/ipv4/ip_vti.c
index 686e4f3d83aa7fd2639e16466a50ed3f257f2a88..95b6bb78fcd274ec38ebda549e91d9cc0b38e3f9 100644
--- a/net/ipv4/ip_vti.c
+++ b/net/ipv4/ip_vti.c
@@ -229,7 +229,7 @@ static netdev_tx_t vti_xmit(struct sk_buff *skb, struct net_device *dev,
 		goto tx_error_icmp;
 	}
 
-	tdev = dst->dev;
+	tdev = dst_dev(dst);
 
 	if (tdev == dev) {
 		dst_release(dst);
@@ -259,7 +259,7 @@ static netdev_tx_t vti_xmit(struct sk_buff *skb, struct net_device *dev,
 xmit:
 	skb_scrub_packet(skb, !net_eq(tunnel->net, dev_net(dev)));
 	skb_dst_set(skb, dst);
-	skb->dev = skb_dst(skb)->dev;
+	skb->dev = skb_dst_dev(skb);
 
 	err = dst_output(tunnel->net, skb->sk, skb);
 	if (net_xmit_eval(err) == 0)
diff --git a/net/ipv4/netfilter.c b/net/ipv4/netfilter.c
index 08bc3f2c0078bbc956f45daab605b287efbd4819..0565f001120dcae8a7f6a552c40bb897b4786abb 100644
--- a/net/ipv4/netfilter.c
+++ b/net/ipv4/netfilter.c
@@ -20,12 +20,12 @@
 /* route_me_harder function, used by iptable_nat, iptable_mangle + ip_queue */
 int ip_route_me_harder(struct net *net, struct sock *sk, struct sk_buff *skb, unsigned int addr_type)
 {
+	struct net_device *dev = skb_dst_dev(skb);
 	const struct iphdr *iph = ip_hdr(skb);
 	struct rtable *rt;
 	struct flowi4 fl4 = {};
 	__be32 saddr = iph->saddr;
 	__u8 flags;
-	struct net_device *dev = skb_dst(skb)->dev;
 	struct flow_keys flkeys;
 	unsigned int hh_len;
 
@@ -74,7 +74,7 @@ int ip_route_me_harder(struct net *net, struct sock *sk, struct sk_buff *skb, un
 #endif
 
 	/* Change in oif may mean change in hh_len. */
-	hh_len = skb_dst(skb)->dev->hard_header_len;
+	hh_len = skb_dst_dev(skb)->hard_header_len;
 	if (skb_headroom(skb) < hh_len &&
 	    pskb_expand_head(skb, HH_DATA_ALIGN(hh_len - skb_headroom(skb)),
 				0, GFP_ATOMIC))
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index ce6aba4f01ff25a8f9238271a7ae2295f7c7bb93..64ba377cd6cc6664626029a325d08572e9d5949d 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -413,7 +413,7 @@ static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
 					   const void *daddr)
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 	struct neighbour *n;
 
 	rcu_read_lock();
@@ -440,7 +440,7 @@ static struct neighbour *ipv4_neigh_lookup(const struct dst_entry *dst,
 static void ipv4_confirm_neigh(const struct dst_entry *dst, const void *daddr)
 {
 	const struct rtable *rt = container_of(dst, struct rtable, dst);
-	struct net_device *dev = dst->dev;
+	struct net_device *dev = dst_dev(dst);
 	const __be32 *pkey = daddr;
 
 	if (rt->rt_gw_family == AF_INET) {
@@ -1026,7 +1026,7 @@ static void __ip_rt_update_pmtu(struct rtable *rt, struct flowi4 *fl4, u32 mtu)
 		return;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst->dev);
+	net = dev_net_rcu(dst_dev(dst));
 	if (mtu < net->ipv4.ip_rt_min_pmtu) {
 		lock = true;
 		mtu = min(old_mtu, net->ipv4.ip_rt_min_pmtu);
@@ -1326,7 +1326,7 @@ static unsigned int ipv4_default_advmss(const struct dst_entry *dst)
 	struct net *net;
 
 	rcu_read_lock();
-	net = dev_net_rcu(dst->dev);
+	net = dev_net_rcu(dst_dev(dst));
 	advmss = max_t(unsigned int, ipv4_mtu(dst) - header_size,
 				   net->ipv4.ip_rt_min_advmss);
 	rcu_read_unlock();
diff --git a/net/ipv4/tcp_fastopen.c b/net/ipv4/tcp_fastopen.c
index 5107121c5e37fa5741ca97d4f79dc8eb958a9fba..f1884f0c9e523d50b2d120175cc94bc40b489dfb 100644
--- a/net/ipv4/tcp_fastopen.c
+++ b/net/ipv4/tcp_fastopen.c
@@ -559,6 +559,7 @@ bool tcp_fastopen_active_should_disable(struct sock *sk)
 void tcp_fastopen_active_disable_ofo_check(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
+	struct net_device *dev;
 	struct dst_entry *dst;
 	struct sk_buff *skb;
 
@@ -576,7 +577,8 @@ void tcp_fastopen_active_disable_ofo_check(struct sock *sk)
 	} else if (tp->syn_fastopen_ch &&
 		   atomic_read(&sock_net(sk)->ipv4.tfo_active_disable_times)) {
 		dst = sk_dst_get(sk);
-		if (!(dst && dst->dev && (dst->dev->flags & IFF_LOOPBACK)))
+		dev = dst ? dst_dev(dst) : NULL;
+		if (!(dev && (dev->flags & IFF_LOOPBACK)))
 			atomic_set(&sock_net(sk)->ipv4.tfo_active_disable_times, 0);
 		dst_release(dst);
 	}
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 56223338bc0f070179efb2ce9996fa7146782adc..9630bfb02e7046856d53f6ba103fe62e00236245 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -787,7 +787,7 @@ static void tcp_v4_send_reset(const struct sock *sk, struct sk_buff *skb,
 	arg.iov[0].iov_base = (unsigned char *)&rep;
 	arg.iov[0].iov_len  = sizeof(rep.th);
 
-	net = sk ? sock_net(sk) : dev_net_rcu(skb_dst(skb)->dev);
+	net = sk ? sock_net(sk) : skb_dst_dev_net_rcu(skb);
 
 	/* Invalid TCP option size or twice included auth */
 	if (tcp_parse_auth_options(tcp_hdr(skb), &md5_hash_location, &aoh))
diff --git a/net/ipv4/tcp_metrics.c b/net/ipv4/tcp_metrics.c
index 4251670e328c83b55eff7bbda3cc3d97d78563a8..03c068ea27b6ad3283b8365f31706c11ecdd07f2 100644
--- a/net/ipv4/tcp_metrics.c
+++ b/net/ipv4/tcp_metrics.c
@@ -166,11 +166,11 @@ static struct tcp_metrics_block *tcpm_new(struct dst_entry *dst,
 					  unsigned int hash)
 {
 	struct tcp_metrics_block *tm;
-	struct net *net;
 	bool reclaim = false;
+	struct net *net;
 
 	spin_lock_bh(&tcp_metrics_lock);
-	net = dev_net_rcu(dst->dev);
+	net = dev_net_rcu(dst_dev(dst));
 
 	/* While waiting for the spin-lock the cache might have been populated
 	 * with this entry and so we have to check again.
@@ -273,7 +273,7 @@ static struct tcp_metrics_block *__tcp_get_metrics_req(struct request_sock *req,
 		return NULL;
 	}
 
-	net = dev_net_rcu(dst->dev);
+	net = dev_net_rcu(dst_dev(dst));
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
@@ -318,7 +318,7 @@ static struct tcp_metrics_block *tcp_get_metrics(struct sock *sk,
 	else
 		return NULL;
 
-	net = dev_net_rcu(dst->dev);
+	net = dev_net_rcu(dst_dev(dst));
 	hash ^= net_hash_mix(net);
 	hash = hash_32(hash, tcp_metrics_hash_log);
 
diff --git a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
index 3cff51ba72bb019d920554fa653937d729469b32..0ae67d537499a247c139a49e83f6f68dbc5114fa 100644
--- a/net/ipv4/xfrm4_output.c
+++ b/net/ipv4/xfrm4_output.c
@@ -31,7 +31,7 @@ static int __xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 int xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 {
 	return NF_HOOK_COND(NFPROTO_IPV4, NF_INET_POST_ROUTING,
-			    net, sk, skb, skb->dev, skb_dst(skb)->dev,
+			    net, sk, skb, skb->dev, skb_dst_dev(skb),
 			    __xfrm4_output,
 			    !(IPCB(skb)->flags & IPSKB_REROUTED));
 }
-- 
2.50.0.727.gbf7dc18ff4-goog



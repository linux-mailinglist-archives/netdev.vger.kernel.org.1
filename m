Return-Path: <netdev+bounces-162114-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AF878A25CDF
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 15:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C668A1886528
	for <lists+netdev@lfdr.de>; Mon,  3 Feb 2025 14:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7F9212F9A;
	Mon,  3 Feb 2025 14:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dZ+Vine3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 099ED212F84
	for <netdev@vger.kernel.org>; Mon,  3 Feb 2025 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738593062; cv=none; b=SRf4GZARSdCYrFIEx21WlE9VzQixsDgyvg+4Wsv3UpfOL3cSAvqKFPSZGYGQ1SpKQY9xv3cXspCN/pHQE5eJY6WZe4yp4OlBV7MG6lx16c9WAmW7cIjfY+N8jAFvl4dbM6VDaxAAYHM9+ndk079gQ3d8jMinKnZiibQ7GloH1nE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738593062; c=relaxed/simple;
	bh=rteRAK8u2cYuSPdsdFOuXbtGScv+u9pINXmSOxOYqEw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jd0r4WDjseclwNmPseJgHtuQjP0klDyqjWzQGsu3SjZBce5b+pPbFDnjC+k187cPLI8+wVPp7aaMUyFw2QkjsXI1b7OZSTIVCIZKoDaUIhfTyxzAwOiuDdVsFMLQ1/f41aotUILsjqcXhjkhtzEdx/VQIf/rRaJVZ3es+yxRbbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dZ+Vine3; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-467a0a6c846so95750941cf.1
        for <netdev@vger.kernel.org>; Mon, 03 Feb 2025 06:31:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1738593060; x=1739197860; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=K75MRH5r6VIew1gMzCEXzzdkS9dRmi/YhLuN/XRo0eE=;
        b=dZ+Vine3dI5zHmn64QL7NsbqHJdRSbjNc06dqiBBmPJ/QTekNjNdo3WDm76eTE+ytR
         eWjXfB1cogPokuvwZIXUQhKO0CduDTOcFJqcVAUyE3MJwDZuMXSxTzMN8R0zOtQUiLw4
         lk3S8/uFphBxHNOmriDo827dxE+sEOx7hwaFUwp0Whufl4sG5F0LN88liaxCZat9lNh7
         xoQs/6ue4OadAa0pwgBRBtQ5AiFj6QA5PiH6EeSSAtBrTFmtywjLeUq9pYiSw0g5z1Mi
         zkZtBjyyLii+dAbzq/ej1PEHuCokrYIhKVqLRNqYXZ6D7NMT2VRXGdqxK5yLgWY2hn1d
         M6RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738593060; x=1739197860;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K75MRH5r6VIew1gMzCEXzzdkS9dRmi/YhLuN/XRo0eE=;
        b=OIFLUwnXJPt3NEU6ipkbbie5EfN74DCFh9dWVxjhE1UTlx0LMmdWoGtrRIl+n/3z3s
         eOw4/zgahSDn92N8jDd0GG/BvcWjl4x2PUpi1acrYmKg9erRwCd4b9fc/8A+uN2PT1ot
         yyqo5dITcZ4WrSS/Rnpm36QyEGwH+HeXQll0GBqT7VH6+SerEfa9UuZNjruUwAotzR9h
         b3WDqua7grkg5YlbggsBprJ4ifhdPsnCUBgW+8mSC7NwwUFZbGPEK6MYGuJimLU1fuV8
         144hmirddXGBZh6w1vYVMCWe9HfZtf6ZJrvuu07t3GKUZB6Hie/G+AXNq2zqoaY2A2PI
         fnVg==
X-Gm-Message-State: AOJu0YyUkdj2GKQ55UCS125HZkhMsxldKduR6umnJzD3pzj4UDLGacSA
	DjjALigTZ0xJgQs0DSVIk1q7EpcSUay7m1EEnOTq8AH/ATNzcD8Qm0HPxw4sKjmIkMKna2cqcXb
	45ZiGUCozVA==
X-Google-Smtp-Source: AGHT+IFvsEloV68HLiN99Vm8eVjrwbH/RUo7TGZYC7PKTLHV5qAksbFWwKXDJ9G4KwWJ+Wf3ksLOjYJOYWXvyg==
X-Received: from qtbfd13.prod.google.com ([2002:a05:622a:4d0d:b0:46f:c959:9b05])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:4a8a:b0:467:5082:74bd with SMTP id d75a77b69052e-46fd0b89816mr321391971cf.34.1738593059957;
 Mon, 03 Feb 2025 06:30:59 -0800 (PST)
Date: Mon,  3 Feb 2025 14:30:38 +0000
In-Reply-To: <20250203143046.3029343-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250203143046.3029343-1-edumazet@google.com>
X-Mailer: git-send-email 2.48.1.362.g079036d154-goog
Message-ID: <20250203143046.3029343-9-edumazet@google.com>
Subject: [PATCH v2 net 08/16] udp: convert to dev_net_rcu()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

UDP uses of dev_net() are safe, change them to dev_net_rcu()
to get LOCKDEP support.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/udp.c | 19 ++++++++++---------
 net/ipv6/udp.c | 18 +++++++++---------
 2 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a9bb9ce5438eaa9f9ceede1e4ac080dc6ab74588..fc1e37eb49190cb7e2671ebd54ac4fca54b77ac2 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -750,7 +750,7 @@ static inline struct sock *__udp4_lib_lookup_skb(struct sk_buff *skb,
 {
 	const struct iphdr *iph = ip_hdr(skb);
 
-	return __udp4_lib_lookup(dev_net(skb->dev), iph->saddr, sport,
+	return __udp4_lib_lookup(dev_net_rcu(skb->dev), iph->saddr, sport,
 				 iph->daddr, dport, inet_iif(skb),
 				 inet_sdif(skb), udptable, skb);
 }
@@ -760,7 +760,7 @@ struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
 {
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct iphdr *iph = (struct iphdr *)(skb->data + offset);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	int iif, sdif;
 
 	inet_get_iif_sdif(skb, &iif, &sdif);
@@ -934,13 +934,13 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 	struct inet_sock *inet;
 	const struct iphdr *iph = (const struct iphdr *)skb->data;
 	struct udphdr *uh = (struct udphdr *)(skb->data+(iph->ihl<<2));
+	struct net *net = dev_net_rcu(skb->dev);
 	const int type = icmp_hdr(skb)->type;
 	const int code = icmp_hdr(skb)->code;
 	bool tunnel = false;
 	struct sock *sk;
 	int harderr;
 	int err;
-	struct net *net = dev_net(skb->dev);
 
 	sk = __udp4_lib_lookup(net, iph->daddr, uh->dest,
 			       iph->saddr, uh->source, skb->dev->ifindex,
@@ -1025,7 +1025,7 @@ int __udp4_lib_err(struct sk_buff *skb, u32 info, struct udp_table *udptable)
 
 int udp_err(struct sk_buff *skb, u32 info)
 {
-	return __udp4_lib_err(skb, info, dev_net(skb->dev)->ipv4.udp_table);
+	return __udp4_lib_err(skb, info, dev_net_rcu(skb->dev)->ipv4.udp_table);
 }
 
 /*
@@ -2466,7 +2466,7 @@ static int udp_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		udp_post_segment_fix_csum(skb);
 		ret = udp_queue_rcv_one_skb(sk, skb);
 		if (ret > 0)
-			ip_protocol_deliver_rcu(dev_net(skb->dev), skb, ret);
+			ip_protocol_deliver_rcu(dev_net_rcu(skb->dev), skb, ret);
 	}
 	return 0;
 }
@@ -2632,12 +2632,12 @@ static int udp_unicast_rcv_skb(struct sock *sk, struct sk_buff *skb,
 int __udp4_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		   int proto)
 {
+	struct net *net = dev_net_rcu(skb->dev);
+	struct rtable *rt = skb_rtable(skb);
 	struct sock *sk = NULL;
 	struct udphdr *uh;
 	unsigned short ulen;
-	struct rtable *rt = skb_rtable(skb);
 	__be32 saddr, daddr;
-	struct net *net = dev_net(skb->dev);
 	bool refcounted;
 	int drop_reason;
 
@@ -2804,7 +2804,7 @@ static struct sock *__udp4_lib_demux_lookup(struct net *net,
 
 int udp_v4_early_demux(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	struct in_device *in_dev = NULL;
 	const struct iphdr *iph;
 	const struct udphdr *uh;
@@ -2873,7 +2873,8 @@ int udp_v4_early_demux(struct sk_buff *skb)
 
 int udp_rcv(struct sk_buff *skb)
 {
-	return __udp4_lib_rcv(skb, dev_net(skb->dev)->ipv4.udp_table, IPPROTO_UDP);
+	return __udp4_lib_rcv(skb, dev_net_rcu(skb->dev)->ipv4.udp_table,
+			      IPPROTO_UDP);
 }
 
 void udp_destroy_sock(struct sock *sk)
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index c6ea438b5c7588edd2971997f21382c26446a45c..d0b8f724e4362ec35352dae547e916c912716cab 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -410,7 +410,7 @@ static struct sock *__udp6_lib_lookup_skb(struct sk_buff *skb,
 {
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
 
-	return __udp6_lib_lookup(dev_net(skb->dev), &iph->saddr, sport,
+	return __udp6_lib_lookup(dev_net_rcu(skb->dev), &iph->saddr, sport,
 				 &iph->daddr, dport, inet6_iif(skb),
 				 inet6_sdif(skb), udptable, skb);
 }
@@ -420,7 +420,7 @@ struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
 {
 	const u16 offset = NAPI_GRO_CB(skb)->network_offsets[skb->encapsulation];
 	const struct ipv6hdr *iph = (struct ipv6hdr *)(skb->data + offset);
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	int iif, sdif;
 
 	inet6_get_iif_sdif(skb, &iif, &sdif);
@@ -702,16 +702,16 @@ int __udp6_lib_err(struct sk_buff *skb, struct inet6_skb_parm *opt,
 		   u8 type, u8 code, int offset, __be32 info,
 		   struct udp_table *udptable)
 {
-	struct ipv6_pinfo *np;
 	const struct ipv6hdr *hdr = (const struct ipv6hdr *)skb->data;
 	const struct in6_addr *saddr = &hdr->saddr;
 	const struct in6_addr *daddr = seg6_get_daddr(skb, opt) ? : &hdr->daddr;
 	struct udphdr *uh = (struct udphdr *)(skb->data+offset);
+	struct net *net = dev_net_rcu(skb->dev);
+	struct ipv6_pinfo *np;
 	bool tunnel = false;
 	struct sock *sk;
 	int harderr;
 	int err;
-	struct net *net = dev_net(skb->dev);
 
 	sk = __udp6_lib_lookup(net, daddr, uh->dest, saddr, uh->source,
 			       inet6_iif(skb), inet6_sdif(skb), udptable, NULL);
@@ -818,7 +818,7 @@ static __inline__ int udpv6_err(struct sk_buff *skb,
 				u8 code, int offset, __be32 info)
 {
 	return __udp6_lib_err(skb, opt, type, code, offset, info,
-			      dev_net(skb->dev)->ipv4.udp_table);
+			      dev_net_rcu(skb->dev)->ipv4.udp_table);
 }
 
 static int udpv6_queue_rcv_one_skb(struct sock *sk, struct sk_buff *skb)
@@ -929,7 +929,7 @@ static int udpv6_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 		udp_post_segment_fix_csum(skb);
 		ret = udpv6_queue_rcv_one_skb(sk, skb);
 		if (ret > 0)
-			ip6_protocol_deliver_rcu(dev_net(skb->dev), skb, ret,
+			ip6_protocol_deliver_rcu(dev_net_rcu(skb->dev), skb, ret,
 						 true);
 	}
 	return 0;
@@ -1071,8 +1071,8 @@ int __udp6_lib_rcv(struct sk_buff *skb, struct udp_table *udptable,
 		   int proto)
 {
 	enum skb_drop_reason reason = SKB_DROP_REASON_NOT_SPECIFIED;
+	struct net *net = dev_net_rcu(skb->dev);
 	const struct in6_addr *saddr, *daddr;
-	struct net *net = dev_net(skb->dev);
 	struct sock *sk = NULL;
 	struct udphdr *uh;
 	bool refcounted;
@@ -1220,7 +1220,7 @@ static struct sock *__udp6_lib_demux_lookup(struct net *net,
 
 void udp_v6_early_demux(struct sk_buff *skb)
 {
-	struct net *net = dev_net(skb->dev);
+	struct net *net = dev_net_rcu(skb->dev);
 	const struct udphdr *uh;
 	struct sock *sk;
 	struct dst_entry *dst;
@@ -1262,7 +1262,7 @@ void udp_v6_early_demux(struct sk_buff *skb)
 
 INDIRECT_CALLABLE_SCOPE int udpv6_rcv(struct sk_buff *skb)
 {
-	return __udp6_lib_rcv(skb, dev_net(skb->dev)->ipv4.udp_table, IPPROTO_UDP);
+	return __udp6_lib_rcv(skb, dev_net_rcu(skb->dev)->ipv4.udp_table, IPPROTO_UDP);
 }
 
 /*
-- 
2.48.1.362.g079036d154-goog



Return-Path: <netdev+bounces-151765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42C6D9F0CE1
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:02:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EE53188B373
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:02:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EB91E00B6;
	Fri, 13 Dec 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QV0eFRUU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2951E0081
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094942; cv=none; b=DOZbF/bJVdj+6FaRAiK5hlhDiHhMTf30LC9/mcfwDcSB9IiZsysoo5KTIU65YOOAaBPFf0hGrZ8qco3UuhVZEJZEl1PJnnK5SXo9yAiSA3gyOw184AIKRzptlvkqUFroiTn4csMkMBJxt2OiBNEBWZdIpdKpLnGssd5slUbQwPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094942; c=relaxed/simple;
	bh=s3MI24GtlqQdp5wNS4PFx7F9BjHZqq3Vm25eZ/KSfcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=g+eoOEBrYBv+oQePyXnPKL0UHTHlWR354K4RUqxU16nA9a/DahPOTevT541Fcm5gjX5vvUy5T3G1sExz2Ql+LksQL7ew9Zvz2NZPudGDuY2SyJiK/ffHoF+m8Mj4WKH2jHIcjYrx6d6IHj3Z3GZodZCE0r52jtf479VQYwIhQcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QV0eFRUU; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-6d8edb40083so56234706d6.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 05:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734094937; x=1734699737; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxiE9o12jvQE0EhYg4DBIO0tfvhpWtc9/ACQybVd+3k=;
        b=QV0eFRUUdnKBUFWl1IGylWrb9M07LZ60edjpxSSWsJbinqu+mPddoFHdPwYeO5y95p
         SY7t92ymO9KEhthEjCcaVxfAnH2KiuIhbmgy5X1Ew5DpQIIcYq/J8oYpwWzMcoqP6zXG
         x450uVkhdqSMrYBdvf+BT4C2M/ZKYLaEdZ3iGIZwI6mY5bNMUIpuvfkpJi7vtM09aV+f
         Aw+FGzVrofcO41EsnkPJPENhoKXD/AzuQ9BI4rKP1djkkqvB9U5VxIkdcOXDfXKV5UuM
         n4QrKSj6z6GIb8ad3JxhJgyxMFanlv/KgzYpfLPogKgpXMWMYhgxypf1nM1J+n6UFn3O
         5wvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734094937; x=1734699737;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxiE9o12jvQE0EhYg4DBIO0tfvhpWtc9/ACQybVd+3k=;
        b=P0VoUVOQfUJy+mznBkgGJbdch6o2gyUMxYatiemNbxOFdr/pIn+Jea0z6d+FN2Lc/5
         hib4WmQPtqV8J8kLnz6FpFfhMNeU/fSegBpCit8ZFJR1UkaAVD1tpSnx/dRVdOICOWB9
         WP7dYNwJoz6HirlhQRKDuTr3lDPaYDDeTgnEO4ehplRRWwkWjoNFBW96w7XFgG0I1GZ9
         UMafSUtjZAp3IgtRxohandKQ+XL+N3T4FZJg+olUI/sAmWnJyhrL7asXIvH3r/apTmsp
         6KX5afFZED6K3lpxnIk637vDPBULvMXyhaXf5k+8UudQqTC4aUBw2cspuOIpUfXVAeoM
         rOsQ==
X-Gm-Message-State: AOJu0YwS9HSW79gWRH1L71SERlR+LO6GvKzCnUZC/JXRm+aVt7ThexDE
	WPkrF9Rd1/irLUdvRWgREKaoVGAHw6uyGvc2mQYIDMkbjwa/uV0oosxRb7Pfn+tJ6LWGWGJRFw6
	5q/qs4j2qJQ==
X-Google-Smtp-Source: AGHT+IHmnov1Q8Nab5/AMD2rs5XW+BayrRvjm1HlW8ijRzQ4cXzEuy8OraRh8VaGmGX2XrNjM1Nn0+bOKcDMYg==
X-Received: from qvab9.prod.google.com ([2002:a05:6214:6109:b0:6d8:9fb4:cdb9])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5949:0:b0:6d9:15c3:42c9 with SMTP id 6a1803df08f44-6db0f3e0cadmr65467126d6.7.1734094937321;
 Fri, 13 Dec 2024 05:02:17 -0800 (PST)
Date: Fri, 13 Dec 2024 13:02:09 +0000
In-Reply-To: <20241213130212.1783302-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213130212.1783302-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213130212.1783302-2-edumazet@google.com>
Subject: [PATCH net-next 1/4] inetpeer: remove create argument of inet_getpeer_v[46]()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

All callers of inet_getpeer_v4() and inet_getpeer_v6()
want to create an inetpeer.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inetpeer.h | 9 ++++-----
 net/ipv4/icmp.c        | 2 +-
 net/ipv4/ip_fragment.c | 2 +-
 net/ipv4/route.c       | 4 ++--
 net/ipv6/icmp.c        | 2 +-
 net/ipv6/ip6_output.c  | 2 +-
 net/ipv6/ndisc.c       | 2 +-
 7 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/include/net/inetpeer.h b/include/net/inetpeer.h
index 74ff688568a0c6559946a9ae763d5c9822f1d112..6f51f81d6cb19c623e9b347dbdbbd8d849848f6e 100644
--- a/include/net/inetpeer.h
+++ b/include/net/inetpeer.h
@@ -101,25 +101,24 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 
 static inline struct inet_peer *inet_getpeer_v4(struct inet_peer_base *base,
 						__be32 v4daddr,
-						int vif, int create)
+						int vif)
 {
 	struct inetpeer_addr daddr;
 
 	daddr.a4.addr = v4daddr;
 	daddr.a4.vif = vif;
 	daddr.family = AF_INET;
-	return inet_getpeer(base, &daddr, create);
+	return inet_getpeer(base, &daddr, 1);
 }
 
 static inline struct inet_peer *inet_getpeer_v6(struct inet_peer_base *base,
-						const struct in6_addr *v6daddr,
-						int create)
+						const struct in6_addr *v6daddr)
 {
 	struct inetpeer_addr daddr;
 
 	daddr.a6 = *v6daddr;
 	daddr.family = AF_INET6;
-	return inet_getpeer(base, &daddr, create);
+	return inet_getpeer(base, &daddr, 1);
 }
 
 static inline int inetpeer_addr_cmp(const struct inetpeer_addr *a,
diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 963a89ae9c26e8b462de57e4af981c6c46061052..5eeb9f569a706cf2766d74bcf1a667c8930804f2 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -322,7 +322,7 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 		goto out;
 
 	vif = l3mdev_master_ifindex(dst->dev);
-	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr, vif, 1);
+	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr, vif);
 	rc = inet_peer_xrlim_allow(peer,
 				   READ_ONCE(net->ipv4.sysctl_icmp_ratelimit));
 	if (peer)
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 07036a2943c19f13f2d6d1d77cb8123867575b50..46e1171299f22ccf0b201eabbff5d3279a0703d8 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -89,7 +89,7 @@ static void ip4_frag_init(struct inet_frag_queue *q, const void *a)
 	q->key.v4 = *key;
 	qp->ecn = 0;
 	qp->peer = q->fqdir->max_dist ?
-		inet_getpeer_v4(net->ipv4.peers, key->saddr, key->vif, 1) :
+		inet_getpeer_v4(net->ipv4.peers, key->saddr, key->vif) :
 		NULL;
 }
 
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 0fbec350961862f76b7eab332539472fed5a5286..297a9939c6e74beffc592dbdd7266281fe842440 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -873,7 +873,7 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 	rcu_read_unlock();
 
 	net = dev_net(rt->dst.dev);
-	peer = inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr, vif, 1);
+	peer = inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr, vif);
 	if (!peer) {
 		icmp_send(skb, ICMP_REDIRECT, ICMP_REDIR_HOST,
 			  rt_nexthop(rt, ip_hdr(skb)->daddr));
@@ -976,7 +976,7 @@ static int ip_error(struct sk_buff *skb)
 	}
 
 	peer = inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr,
-			       l3mdev_master_ifindex(skb->dev), 1);
+			       l3mdev_master_ifindex(skb->dev));
 
 	send = true;
 	if (peer) {
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 071b0bc1179d81b18c340ce415cef21e02a30cd7..4593e3992c67b84e3a10f30be28762974094d21f 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -222,7 +222,7 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 		if (rt->rt6i_dst.plen < 128)
 			tmo >>= ((128 - rt->rt6i_dst.plen)>>5);
 
-		peer = inet_getpeer_v6(net->ipv6.peers, &fl6->daddr, 1);
+		peer = inet_getpeer_v6(net->ipv6.peers, &fl6->daddr);
 		res = inet_peer_xrlim_allow(peer, tmo);
 		if (peer)
 			inet_putpeer(peer);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 3d672dea9f56284e7a8ebabec037e04e7f3d19f4..2cbcfe70654b5cd90c433a24c47ef5496c604d0d 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -613,7 +613,7 @@ int ip6_forward(struct sk_buff *skb)
 		else
 			target = &hdr->daddr;
 
-		peer = inet_getpeer_v6(net->ipv6.peers, &hdr->daddr, 1);
+		peer = inet_getpeer_v6(net->ipv6.peers, &hdr->daddr);
 
 		/* Limit redirects both by destination (here)
 		   and by source (inside ndisc_send_redirect)
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index aba94a34867379000e958538d880799c2d0c1476..f113554d13325453cd04ce4e5686d837943e96ff 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1731,7 +1731,7 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 			  "Redirect: destination is not a neighbour\n");
 		goto release;
 	}
-	peer = inet_getpeer_v6(net->ipv6.peers, &ipv6_hdr(skb)->saddr, 1);
+	peer = inet_getpeer_v6(net->ipv6.peers, &ipv6_hdr(skb)->saddr);
 	ret = inet_peer_xrlim_allow(peer, 1*HZ);
 	if (peer)
 		inet_putpeer(peer);
-- 
2.47.1.613.gc27f4b7a9f-goog



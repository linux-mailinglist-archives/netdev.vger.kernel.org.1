Return-Path: <netdev+bounces-152007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9152A9F2528
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 18:57:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB7FA18861B5
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 086461B532F;
	Sun, 15 Dec 2024 17:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XFUA07IK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A521B21B2
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 17:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734285413; cv=none; b=tmzcEQVjI/AVBlGcqxRg6t6ple8c32G21CjBevtZnvVfsgzja2totV/bR8ptbLN04iN1QVORMDs2KMJZX+5SBIXu7Vb4XJBaiS7ZKonv94n+sfIgTtAzQgvZFc+AwnLCrfwIyQ5h9XhsNAWQbiqO/MygcaPVR0dnpymT9FYxqEg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734285413; c=relaxed/simple;
	bh=s3MI24GtlqQdp5wNS4PFx7F9BjHZqq3Vm25eZ/KSfcA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=YIjRgxLu6BHbP9BDR3qFSPyzok4t4qtUvn9tnLee7fCEDZZVI2n86wCXqhk2dwf8A3YA+cUNYG6+e4x2ZkNpcl5fh604GZnZ4Z96lDAwSaiwpt8gPkRvd1xqi13GxsTZeQMeSdfM/LHUMNgKMBPNt+XchIxtXuZFP33fliyvNVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XFUA07IK; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7b6eeef7cb8so492884385a.2
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 09:56:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734285411; x=1734890211; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=gxiE9o12jvQE0EhYg4DBIO0tfvhpWtc9/ACQybVd+3k=;
        b=XFUA07IK2+wOLixTZJ8H4Y9ez4bRlwkLBPEVTM7GppB/bAtMPv2jGmTZ0BDd9MYBwD
         yXZV37boyb5ZAx4ig1xNIA/FjOir5Cb/T24erZtvrGTXXwkEzGOd8CVqxmHEgcFK3xfY
         8dKFIbV3bJN/p/MepDRlGdkRZ3mHO22qs6M/OmceIFAxSjQEGoLhHYsZdqqOFRFDWtsh
         q5Zyt7u0r2YJm9DraD/CcPpMzfR7IjkVJWTTb0Ubg8pyxc77KcuqJenRiKcL7jOJUqgr
         78seuaJB1/1z1p03YxKlfm5WaZ4v5KC/uS73d6I9HA7Vsxxk/MX5lhWGR7ViR049dMeF
         qr8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734285411; x=1734890211;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gxiE9o12jvQE0EhYg4DBIO0tfvhpWtc9/ACQybVd+3k=;
        b=kXv2JupWIVdf06c2wvJgEOfigSd8AsqUpRerVWDsxE+b5YSNJzX21f2pPobl2lxxfG
         SlSymFDnO8BVLAurUe6JblqtQDXtu/IvrhuoAPP2/lwxgJFkZZZAS1PMVVsLU7RHkSyp
         QHs2S0C0DcEgQbAWscc1ntQJbQkLxGLQWHkKB51ZPSBI5XU7GY56IbBl9cR4408GLsQw
         c/MDKrIiE2uG/TK/0BpDuYIh7//c6nn61aLHyv5N+SWfIyqd55aV0i3R1NRQ7kOkLLi+
         6AVAOpGazPd9DSUIxkS6fogiIpp63uA4+3zALLNEqtOOr1fGcqCoo2ZiufLqoXaMbi7o
         lClw==
X-Gm-Message-State: AOJu0YweWti71QazCsVgW7hwGjNbbV5LmqKQ3ZyjElCCvSrVxNmd2Kxw
	ajilVUTyOzymtbo5c+S1pDcqpNWNy7CmTRLZn9e9mg7HqLvR8VxKJBvb/TrCHsrXMAhKgbsRWXK
	93gJhiFdYNg==
X-Google-Smtp-Source: AGHT+IH8RcAQn8pr7p0s9VXd24/kph3Gysl7EVJ+ms7UxXw7uZhiCXDJKWVjGpxhefJ0imahysqINKqpnFckZQ==
X-Received: from qknvr28.prod.google.com ([2002:a05:620a:55bc:b0:7b6:e98e:956e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2b90:b0:7b1:b216:e2fb with SMTP id af79cd13be357-7b6fbed9d38mr1441418385a.20.1734285411315;
 Sun, 15 Dec 2024 09:56:51 -0800 (PST)
Date: Sun, 15 Dec 2024 17:56:26 +0000
In-Reply-To: <20241215175629.1248773-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241215175629.1248773-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241215175629.1248773-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/4] inetpeer: remove create argument of inet_getpeer_v[46]()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, eric.dumazet@gmail.com, 
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



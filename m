Return-Path: <netdev+bounces-152010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 553D69F252B
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 18:57:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CF66164A60
	for <lists+netdev@lfdr.de>; Sun, 15 Dec 2024 17:57:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 952AB1B5ECB;
	Sun, 15 Dec 2024 17:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nQsD0w5B"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC9B91B4F09
	for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 17:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734285427; cv=none; b=dZ/TYI6sWC/561zfLSJIuYVZfVY0lwKgARyjfG6M8fur9VSTX5JKL7H41NvNu42fHPQcom/r0MjWsHznfIsAf63XsoHvtdAqrvU6qqpiQxh2AqVc4rkOFUVSiZSXATI/jTd5MRPGrHyYtYD90mEDmH9OFDlK9MPb30YXfyzJbu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734285427; c=relaxed/simple;
	bh=7mjwQABpKOUYqcqafn/+erxwARheuqP6yAYNqGU34p8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qyEMp5u+aMfmqcNHBCO4ijVmin67OrQmQdokwp8Rdz8BHLj+ZEx/kT9uAQJzATgYfxtsaUjFFexxY+MtLkgunDVlKjS44EqL3B064Br9lm0TKWktJnJHNTr/fLWy2BFknYfMuHBx7YJwKJ2BOZqJS+rqxdJBUjjI2I/xEmpAj/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nQsD0w5B; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-467b0b0aed4so36845361cf.2
        for <netdev@vger.kernel.org>; Sun, 15 Dec 2024 09:57:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734285424; x=1734890224; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=yajkkgOSci/yBx4bhAcrhwPI10+aWgtKbVI/AsRWZpA=;
        b=nQsD0w5BnJRVE8LyxwiC3GWZIq3bAlw7lPJk3bE3lHbh2+sMCiCcsLH14MpRrGYBj+
         GK+Co7zxHrutd5chLaMGMa4eFg15WU6/tnV6WMyxurFeqQuKJnr+JKQdJ2c/++C0GjEh
         +ZEyH4kHCF1ptjOBkr5N3I790dw0P3ahigQtl1DWT2d7bazajidYoKVq3q5n3I0eRR2M
         deF2xSz71/TfhgLrM4uMSKrgKlFboQ9LIN7TKFXc5QCFqrU4VNL/xG0W3+4Q6vClSvYO
         8TXM8wKpZFyzEPs8cEROv79aWplgc+eG8xP5Z8VDWFRC4BnwrSC/mgEKWnE6CEVRkF0E
         RRXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734285424; x=1734890224;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yajkkgOSci/yBx4bhAcrhwPI10+aWgtKbVI/AsRWZpA=;
        b=PyLyxp2U+PQU1Juy4MJeqJCkIyQbuZhlS5VPW1Z4vzLPc+93OqWtDCwbchEXiKMKKn
         ypdTBYBwfKjSFoYoMdT/FGVMsArjGVUTzBGa3i2fyMqdW0A+PQvJ5h1MkXdm6Dx0FQwl
         lHNJ3XOGN+Lmn/aCWS9dCuLHwTu0VVMSuLrOKBl41+yRkChTCXoqfn68cAEVwdkQPyyh
         bDZ53bDYcRPUpME4j2SLMBiIQshmME5iEdmGgSPktSb5sAsSm8WRPVsb+hKu3tamLBzr
         C8ngBorFfyNyFNyDvEJpkWlUiR+JexlK6gsbBuxKn536ZO1E+sIB18ynI7JINXuZ0qkB
         EIIA==
X-Gm-Message-State: AOJu0Yzcu/+1G852T9VoundftaAgI5UsKL/d4Y0oVVFwE5AShUYaJS0S
	JgKXRXfeP5gj1+sGYxOKoVb/wGb+JYHbCd3xhFQn+CLuCy8LNUAaU1RaQbsuSTTs9Nh5LS0Q929
	He3NO8wS/iw==
X-Google-Smtp-Source: AGHT+IEc+01vUGqJaWTwuAfEodAjXOIps+0cGX+oqPTN4aDTDEDRAFvbmc2Crzaqxsi7tx2B8InjYmJIMG+Xxw==
X-Received: from qtcv13.prod.google.com ([2002:a05:622a:188d:b0:467:aff7:d0c2])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:606:b0:467:53c8:7578 with SMTP id d75a77b69052e-467a577f318mr196749071cf.17.1734285424642;
 Sun, 15 Dec 2024 09:57:04 -0800 (PST)
Date: Sun, 15 Dec 2024 17:56:29 +0000
In-Reply-To: <20241215175629.1248773-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241215175629.1248773-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241215175629.1248773-5-edumazet@google.com>
Subject: [PATCH v2 net-next 4/4] inetpeer: do not get a refcount in inet_getpeer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	Ido Schimmel <idosch@nvidia.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

All inet_getpeer() callers except ip4_frag_init() don't need
to acquire a permanent refcount on the inetpeer.

They can switch to full RCU protection.

Move the refcount_inc_not_zero() into ip4_frag_init(),
so that all the other callers no longer have to
perform a pair of expensive atomic operations on
a possibly contended cache line.

inet_putpeer() no longer needs to be exported.

After this patch, my DUT can receive 8,400,000 UDP packets
per second targetting closed ports, using 50% less cpu cycles
than before.

Also change two calls to l3mdev_master_ifindex() by
l3mdev_master_ifindex_rcu() (Ido ideas)

Fixes: 8c2bd38b95f7 ("icmp: change the order of rate limits")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/icmp.c        |  9 ++++-----
 net/ipv4/inetpeer.c    |  8 ++------
 net/ipv4/ip_fragment.c | 15 ++++++++++-----
 net/ipv4/route.c       | 15 ++++++++-------
 net/ipv6/icmp.c        |  4 ++--
 net/ipv6/ip6_output.c  |  4 ++--
 net/ipv6/ndisc.c       |  6 ++++--
 7 files changed, 32 insertions(+), 29 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 5eeb9f569a706cf2766d74bcf1a667c8930804f2..094084b61bff8a17c4e85c99019b84e9cba21599 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -312,7 +312,6 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 	struct dst_entry *dst = &rt->dst;
 	struct inet_peer *peer;
 	bool rc = true;
-	int vif;
 
 	if (!apply_ratelimit)
 		return true;
@@ -321,12 +320,12 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 	if (dst->dev && (dst->dev->flags&IFF_LOOPBACK))
 		goto out;
 
-	vif = l3mdev_master_ifindex(dst->dev);
-	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr, vif);
+	rcu_read_lock();
+	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr,
+			       l3mdev_master_ifindex_rcu(dst->dev));
 	rc = inet_peer_xrlim_allow(peer,
 				   READ_ONCE(net->ipv4.sysctl_icmp_ratelimit));
-	if (peer)
-		inet_putpeer(peer);
+	rcu_read_unlock();
 out:
 	if (!rc)
 		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index 28c3ae5bc4a0b62030bd190dbe5284632ea23efd..e02484f4d22b8ea47cbaeed46c5fb0a7411462a1 100644
--- a/net/ipv4/inetpeer.c
+++ b/net/ipv4/inetpeer.c
@@ -109,8 +109,6 @@ static struct inet_peer *lookup(const struct inetpeer_addr *daddr,
 		p = rb_entry(parent, struct inet_peer, rb_node);
 		cmp = inetpeer_addr_cmp(daddr, &p->daddr);
 		if (cmp == 0) {
-			if (!refcount_inc_not_zero(&p->refcnt))
-				break;
 			now = jiffies;
 			if (READ_ONCE(p->dtime) != now)
 				WRITE_ONCE(p->dtime, now);
@@ -169,6 +167,7 @@ static void inet_peer_gc(struct inet_peer_base *base,
 	}
 }
 
+/* Must be called under RCU : No refcount change is done here. */
 struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 			       const struct inetpeer_addr *daddr)
 {
@@ -179,10 +178,8 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 	/* Attempt a lockless lookup first.
 	 * Because of a concurrent writer, we might not find an existing entry.
 	 */
-	rcu_read_lock();
 	seq = read_seqbegin(&base->lock);
 	p = lookup(daddr, base, seq, NULL, &gc_cnt, &parent, &pp);
-	rcu_read_unlock();
 
 	if (p)
 		return p;
@@ -200,7 +197,7 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 		if (p) {
 			p->daddr = *daddr;
 			p->dtime = (__u32)jiffies;
-			refcount_set(&p->refcnt, 2);
+			refcount_set(&p->refcnt, 1);
 			atomic_set(&p->rid, 0);
 			p->metrics[RTAX_LOCK-1] = INETPEER_METRICS_NEW;
 			p->rate_tokens = 0;
@@ -228,7 +225,6 @@ void inet_putpeer(struct inet_peer *p)
 	if (refcount_dec_and_test(&p->refcnt))
 		kfree_rcu(p, rcu);
 }
-EXPORT_SYMBOL_GPL(inet_putpeer);
 
 /*
  *	Check transmit rate limitation for given message.
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 46e1171299f22ccf0b201eabbff5d3279a0703d8..7a435746a22dee9f11c0dc732a8b5a7724f4eea3 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -82,15 +82,20 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
 static void ip4_frag_init(struct inet_frag_queue *q, const void *a)
 {
 	struct ipq *qp = container_of(q, struct ipq, q);
-	struct net *net = q->fqdir->net;
-
 	const struct frag_v4_compare_key *key = a;
+	struct net *net = q->fqdir->net;
+	struct inet_peer *p = NULL;
 
 	q->key.v4 = *key;
 	qp->ecn = 0;
-	qp->peer = q->fqdir->max_dist ?
-		inet_getpeer_v4(net->ipv4.peers, key->saddr, key->vif) :
-		NULL;
+	if (q->fqdir->max_dist) {
+		rcu_read_lock();
+		p = inet_getpeer_v4(net->ipv4.peers, key->saddr, key->vif);
+		if (p && !refcount_inc_not_zero(&p->refcnt))
+			p = NULL;
+		rcu_read_unlock();
+	}
+	qp->peer = p;
 }
 
 static void ip4_frag_free(struct inet_frag_queue *q)
diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 297a9939c6e74beffc592dbdd7266281fe842440..9f9d4e6ea1b9287c0d758e9bdf543a92b14974ef 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -870,11 +870,11 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 	}
 	log_martians = IN_DEV_LOG_MARTIANS(in_dev);
 	vif = l3mdev_master_ifindex_rcu(rt->dst.dev);
-	rcu_read_unlock();
 
 	net = dev_net(rt->dst.dev);
 	peer = inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr, vif);
 	if (!peer) {
+		rcu_read_unlock();
 		icmp_send(skb, ICMP_REDIRECT, ICMP_REDIR_HOST,
 			  rt_nexthop(rt, ip_hdr(skb)->daddr));
 		return;
@@ -893,7 +893,7 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 	 */
 	if (peer->n_redirects >= ip_rt_redirect_number) {
 		peer->rate_last = jiffies;
-		goto out_put_peer;
+		goto out_unlock;
 	}
 
 	/* Check for load limit; set rate_last to the latest sent
@@ -914,8 +914,8 @@ void ip_rt_send_redirect(struct sk_buff *skb)
 					     &ip_hdr(skb)->saddr, inet_iif(skb),
 					     &ip_hdr(skb)->daddr, &gw);
 	}
-out_put_peer:
-	inet_putpeer(peer);
+out_unlock:
+	rcu_read_unlock();
 }
 
 static int ip_error(struct sk_buff *skb)
@@ -975,9 +975,9 @@ static int ip_error(struct sk_buff *skb)
 		break;
 	}
 
+	rcu_read_lock();
 	peer = inet_getpeer_v4(net->ipv4.peers, ip_hdr(skb)->saddr,
-			       l3mdev_master_ifindex(skb->dev));
-
+			       l3mdev_master_ifindex_rcu(skb->dev));
 	send = true;
 	if (peer) {
 		now = jiffies;
@@ -989,8 +989,9 @@ static int ip_error(struct sk_buff *skb)
 			peer->rate_tokens -= ip_rt_error_cost;
 		else
 			send = false;
-		inet_putpeer(peer);
 	}
+	rcu_read_unlock();
+
 	if (send)
 		icmp_send(skb, ICMP_DEST_UNREACH, code, 0);
 
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 4593e3992c67b84e3a10f30be28762974094d21f..a6984a29fdb9dd972a11ca9f8d5e794c443bac6f 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -222,10 +222,10 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 		if (rt->rt6i_dst.plen < 128)
 			tmo >>= ((128 - rt->rt6i_dst.plen)>>5);
 
+		rcu_read_lock();
 		peer = inet_getpeer_v6(net->ipv6.peers, &fl6->daddr);
 		res = inet_peer_xrlim_allow(peer, tmo);
-		if (peer)
-			inet_putpeer(peer);
+		rcu_read_unlock();
 	}
 	if (!res)
 		__ICMP6_INC_STATS(net, ip6_dst_idev(dst),
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 2cbcfe70654b5cd90c433a24c47ef5496c604d0d..06cab008b8277f1b6e56541e91fc92f999221ac5 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -613,6 +613,7 @@ int ip6_forward(struct sk_buff *skb)
 		else
 			target = &hdr->daddr;
 
+		rcu_read_lock();
 		peer = inet_getpeer_v6(net->ipv6.peers, &hdr->daddr);
 
 		/* Limit redirects both by destination (here)
@@ -620,8 +621,7 @@ int ip6_forward(struct sk_buff *skb)
 		 */
 		if (inet_peer_xrlim_allow(peer, 1*HZ))
 			ndisc_send_redirect(skb, target);
-		if (peer)
-			inet_putpeer(peer);
+		rcu_read_unlock();
 	} else {
 		int addrtype = ipv6_addr_type(&hdr->saddr);
 
diff --git a/net/ipv6/ndisc.c b/net/ipv6/ndisc.c
index f113554d13325453cd04ce4e5686d837943e96ff..d044c67019de6da1eb29dee875cf8cda30210ceb 100644
--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -1731,10 +1731,12 @@ void ndisc_send_redirect(struct sk_buff *skb, const struct in6_addr *target)
 			  "Redirect: destination is not a neighbour\n");
 		goto release;
 	}
+
+	rcu_read_lock();
 	peer = inet_getpeer_v6(net->ipv6.peers, &ipv6_hdr(skb)->saddr);
 	ret = inet_peer_xrlim_allow(peer, 1*HZ);
-	if (peer)
-		inet_putpeer(peer);
+	rcu_read_unlock();
+
 	if (!ret)
 		goto release;
 
-- 
2.47.1.613.gc27f4b7a9f-goog



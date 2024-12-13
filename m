Return-Path: <netdev+bounces-151767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AD49A9F0CE2
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 14:03:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2674A188B419
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 13:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75B7E1E04A8;
	Fri, 13 Dec 2024 13:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GeWDe/0x"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F38B1E048F
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 13:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734094944; cv=none; b=PaVeGPWLPdVr4MQX+AbwgpnhrcCVMpCxyvRWxVAVmozp6rJA/0X6ER3+ckwEdy6NjUPD3JtXMrGRfoafVuzB/vAicp8YIB4RWyosoTmkrMYWcTcW7oYcJ0U7dN84DlxFQwZS0EczgTF5GDx0aLpK/EZmPswQyauaHnxF7ausFoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734094944; c=relaxed/simple;
	bh=81qm+vACZPmWQqJRBWC75bkQgpMO9+63vWCxZtEAZmA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=oGYzhw1if2aX6Kaj9VfpukkNofEKRBxEVFuhW+Koq6cdhIMcQjYhAMxNbFCajYCl08eun0MRGUwlHd2QvGPtTP05DrEp/QJthERtoPOkq+lhK+Tu3OCvo1TGEaIvdi2bo8yUTkkBAhTlM4V+/J0+ZB5PVN+hae9pO7as70kD6Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GeWDe/0x; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-46686a1565bso38182711cf.0
        for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 05:02:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734094941; x=1734699741; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=dLyiExgbr99lB8vBG1tJUskBis7BB25OpVEzzbb6MxA=;
        b=GeWDe/0xn7aXVjmESSusEqsnA7/8YCCzr6+Z2RbDXXcyC9Pril7POfiIEQidlhqBGn
         QoQ82lwSuOfJQX49HonfXkK1+HkRQOH3qc0VofxmA0rfUOixeSPYT6NsymKwn38Xc664
         m9maqDtZ83TGCOpf8vBFXoq5nPYvNuKddgsUazCyShMb4LgcKc9hY+J/iFDkYjW9CiJa
         k57x9lQRQqzb/JV13qwId+/v/nxqzkYY3EEl+NdWWzLgNJtUTPKP5ot3mk2xV4leDd/V
         MwneetqvCBfyij55Q1aO/dntH5RqUNVe54f+Hheco+Bel2PQTzxULiTdwNuVC2w+Pcf8
         gWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734094941; x=1734699741;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dLyiExgbr99lB8vBG1tJUskBis7BB25OpVEzzbb6MxA=;
        b=qp7OsOt4hu7WQifi37/gXpk7NUWuZ+UCWpCJhmgM5GNvNfxUSJAtq4tPZwxttybd7u
         VG3Vq2FTXQCEiTScQtXOENj0Itl6/cNHSbIDio2XNr2d48xfK+HDBiMLEYiZhy3D8AUn
         9HS29CC5xOkXCyb/SbjhWvFxq6KJ9cjmkhbwEhJWeXhrRz9BJFyOvkdgK9BDrVXVDyIx
         Nl+ht65+lEuS0smMNq1KA9mktKa9zgRWCSHXgKLKq9S1DeXKRf+1M3rJbWnc68m3E7EW
         yhDiPf4Gxp2E16hJFBTpv7eBj2FTX+03J4FoqimLZ/25nFtdE96e6JzYeAFCOHxeNVjS
         p3ZQ==
X-Gm-Message-State: AOJu0YxB/9DEXTLLA9DcwoxK6bG8w8iHva4sXEkdI+lKdPqwFqSs7TAW
	AFYYxUtrUxhpFfw9XYPIFAu6KAGDj3UAjFNXEzFULnHoygOnU5XWg/ITGiCh2ltazK7t48xr4FT
	p8GgHolUcyQ==
X-Google-Smtp-Source: AGHT+IF22Xel41WYPlRCSta3J5yOmGybKDWWA5UmdBCpC3I4/kI3FTyGT31CCshOkTQubl1T/ZRdX+dh6yl9mg==
X-Received: from qtbfe8.prod.google.com ([2002:a05:622a:4d48:b0:466:9f81:8c8c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:c1:b0:466:8f68:a606 with SMTP id d75a77b69052e-467a581d9c9mr48510061cf.40.1734094941474;
 Fri, 13 Dec 2024 05:02:21 -0800 (PST)
Date: Fri, 13 Dec 2024 13:02:12 +0000
In-Reply-To: <20241213130212.1783302-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20241213130212.1783302-1-edumazet@google.com>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20241213130212.1783302-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] inetpeer: do not get a refcount in inet_getpeer()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, Simon Horman <horms@kernel.org>, 
	David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, eric.dumazet@gmail.com, 
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
per second targetting closed ports, using 50% cpu cycles
less than before.

Fixes: 8c2bd38b95f7 ("icmp: change the order of rate limits")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/icmp.c        |  4 ++--
 net/ipv4/inetpeer.c    |  8 ++------
 net/ipv4/ip_fragment.c | 15 ++++++++++-----
 net/ipv4/route.c       | 13 +++++++------
 net/ipv6/icmp.c        |  4 ++--
 net/ipv6/ip6_output.c  |  4 ++--
 net/ipv6/ndisc.c       |  6 ++++--
 7 files changed, 29 insertions(+), 25 deletions(-)

diff --git a/net/ipv4/icmp.c b/net/ipv4/icmp.c
index 5eeb9f569a706cf2766d74bcf1a667c8930804f2..7a1b1af2edcae0b0648ef3c3411b4ef36e6d9b14 100644
--- a/net/ipv4/icmp.c
+++ b/net/ipv4/icmp.c
@@ -322,11 +322,11 @@ static bool icmpv4_xrlim_allow(struct net *net, struct rtable *rt,
 		goto out;
 
 	vif = l3mdev_master_ifindex(dst->dev);
+	rcu_read_lock();
 	peer = inet_getpeer_v4(net->ipv4.peers, fl4->daddr, vif);
 	rc = inet_peer_xrlim_allow(peer,
 				   READ_ONCE(net->ipv4.sysctl_icmp_ratelimit));
-	if (peer)
-		inet_putpeer(peer);
+	rcu_read_unlock();
 out:
 	if (!rc)
 		__ICMP_INC_STATS(net, ICMP_MIB_RATELIMITHOST);
diff --git a/net/ipv4/inetpeer.c b/net/ipv4/inetpeer.c
index 67827c9bf2c8f3ba842ff1dc3b7e1fc2976e6ef1..b025eaba501305635ae46672ff3c7de75c4fcc08 100644
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
@@ -180,11 +179,9 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 	/* Attempt a lockless lookup first.
 	 * Because of a concurrent writer, we might not find an existing entry.
 	 */
-	rcu_read_lock();
 	seq = read_seqbegin(&base->lock);
 	p = lookup(daddr, base, seq, NULL, &gc_cnt, &parent, &pp);
 	invalidated = read_seqretry(&base->lock, seq);
-	rcu_read_unlock();
 
 	if (p)
 		return p;
@@ -202,7 +199,7 @@ struct inet_peer *inet_getpeer(struct inet_peer_base *base,
 		if (p) {
 			p->daddr = *daddr;
 			p->dtime = (__u32)jiffies;
-			refcount_set(&p->refcnt, 2);
+			refcount_set(&p->refcnt, 1);
 			atomic_set(&p->rid, 0);
 			p->metrics[RTAX_LOCK-1] = INETPEER_METRICS_NEW;
 			p->rate_tokens = 0;
@@ -230,7 +227,6 @@ void inet_putpeer(struct inet_peer *p)
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
index 297a9939c6e74beffc592dbdd7266281fe842440..d2086648dcf180375c8d7981dfb72f87e50957f6 100644
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
 			       l3mdev_master_ifindex(skb->dev));
-
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



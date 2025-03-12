Return-Path: <netdev+bounces-174103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AA41A5D80B
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97A973B34F5
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 08:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDEF234962;
	Wed, 12 Mar 2025 08:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4pqQpiKp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411E1233D85
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 08:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767777; cv=none; b=U/N34i3SMEryMIIUSIUz1i0YmjZZoHNTxUKLl2Np840epxNqba9yXzX7anJ9F5J1OmSJB4aMnYPY1silxxzvPuYmufmKXZuLlbYpwexRMc3KELWtaE7lzC1tkk5OWOIztNsCKUh77xhNi6iuLL45NF2cyIdb1E/HdUdKFkj9Gv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767777; c=relaxed/simple;
	bh=c6oUzpprx3XcCbrsjmIS0wMMjBumv2CdGxxtr9uYn1I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B6giMzefDY778UuJ/lqX1ox06PMnSzD1rN6nyyawT6WeCd1SquzxoyxYzf14AB5pn4ehikt8t0ufP0h0RvwFP6jDVmX5MdUXI+bPjy2L9H132t1j+CATJepYL+7iTyuQ/Cllh70Y7uJKOT9qpL7zmZVe+QCiL0FD8SKM3tWP/KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4pqQpiKp; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-7c0c1025adbso525137085a.1
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 01:22:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741767775; x=1742372575; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wxwzBqOgLX+6incBI1V66E1Kx5M1wt4aqapMRW7T+pc=;
        b=4pqQpiKputfqqucaXVrLVaDUQ+r4/R77TupPQWwT4zYS3C9UiJCNxX2x0FWSXe7Y+Y
         HU2jdeRPbHX2ysrwgFS6IzqAKMdHMgjaC+yGyyzubL0XKkd5xTdz7uVlgvIjbA3pD/cF
         9C5HY5v1PShYh+lCO+EtjZB6H/iMktyF6kR7MQnqCC1pIIi596SJwOew7tP6pb1cPSAu
         L18ASqF32E++mcWX+pN0NLf72kRfoyIsoPDQFii3CUYYgmhiPSyOzEG+My6wUc0dqYE+
         HFMXUjarCnOSXgCZPatNuAaQVYExVVLqFWV5upNV3NdF9Q9IBFILFVoSGZM2O3D/hOMX
         yCng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741767775; x=1742372575;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxwzBqOgLX+6incBI1V66E1Kx5M1wt4aqapMRW7T+pc=;
        b=cZ3TeEdVmUL405QwO0KJ5XKHprUsdUYyIEj69CumulImjVeONzmlJqU9zPTvMsErSD
         UFFhw16KOfma8m0NdJsMHFB9BhcFKM5Qdc33jHt5DOEcAHw5/jQjFosuwi25xTA4OvO5
         zfyU/qhhy5yzX9FtVZQ+Qu5w2L64hInGTvi3YKldcVaIwyFa5R2TPquQcuuwJ5HvZGnd
         54pgKaH2RncBLIxKTTnmYVbNCwxsT1fQmi9IUUoh/y5wvcI+6t3U3Li5owH0aiEIcSKA
         soRP1fTDlwZ1ZQOKIpItfYUjAOIBkpw7/gZEtFpL8eSgMKyyoJFGU+wHrTC2ivGhKuDp
         M3sQ==
X-Forwarded-Encrypted: i=1; AJvYcCXCyi3j0r0AsuxyCws6dsbEll3khYuaPEmM4esn8Fu4dwWkW6784bn0u3AB9V68gprNpdJJXXE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx9+AeGEJILjhaEc8KCHvcDFpgIxdLbOehP+CFHL9/6J7NpwnnC
	oLIk/mrzKjqvCSd/eV2DDi/hWe4N/8B0K7lLHdC50xCHrM5JULL5dcpIA8Ddw8ga2m/xJertYMO
	DmNLdAErBfg==
X-Google-Smtp-Source: AGHT+IHJtEGz4lvMLnErei1AfyITN2I/uvhGyAlyd+vZOStr/JpvQ44vYvMPZE36QBxZi5lVXjJPD8RGQnyFZw==
X-Received: from qkpa42.prod.google.com ([2002:a05:620a:43aa:b0:7c5:5ebc:e9ba])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:86cc:b0:7c5:5883:8fb3 with SMTP id af79cd13be357-7c558839118mr1554991285a.8.1741767775102;
 Wed, 12 Mar 2025 01:22:55 -0700 (PDT)
Date: Wed, 12 Mar 2025 08:22:47 +0000
In-Reply-To: <20250312082250.1803501-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250312082250.1803501-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312082250.1803501-2-edumazet@google.com>
Subject: [PATCH v2 net-next 1/4] inet: frags: add inet_frag_putn() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

inet_frag_putn() can release multiple references
in one step.

Use it in inet_frags_free_cb().

Replace inet_frag_put(X) with inet_frag_putn(X, 1)

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_frag.h                 | 4 ++--
 include/net/ipv6_frag.h                 | 3 ++-
 net/ieee802154/6lowpan/reassembly.c     | 7 ++++---
 net/ipv4/inet_fragment.c                | 3 +--
 net/ipv4/ip_fragment.c                  | 2 +-
 net/ipv6/netfilter/nf_conntrack_reasm.c | 3 ++-
 net/ipv6/reassembly.c                   | 4 ++--
 7 files changed, 14 insertions(+), 12 deletions(-)

diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index 5af6eb14c5db1533d559f565deb607934626219d..26687ad0b14142e904b66acee4c98537fa8077c3 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -145,9 +145,9 @@ struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void *key);
 unsigned int inet_frag_rbtree_purge(struct rb_root *root,
 				    enum skb_drop_reason reason);
 
-static inline void inet_frag_put(struct inet_frag_queue *q)
+static inline void inet_frag_putn(struct inet_frag_queue *q, int refs)
 {
-	if (refcount_dec_and_test(&q->refcnt))
+	if (refs && refcount_sub_and_test(refs, &q->refcnt))
 		inet_frag_destroy(q);
 }
 
diff --git a/include/net/ipv6_frag.h b/include/net/ipv6_frag.h
index 7321ffe3a108c159490ae358b8c2cfca958055a4..9d968d7d9fa402a4dd5e0f3d458bacbdcd49da77 100644
--- a/include/net/ipv6_frag.h
+++ b/include/net/ipv6_frag.h
@@ -66,6 +66,7 @@ ip6frag_expire_frag_queue(struct net *net, struct frag_queue *fq)
 {
 	struct net_device *dev = NULL;
 	struct sk_buff *head;
+	int refs = 1;
 
 	rcu_read_lock();
 	/* Paired with the WRITE_ONCE() in fqdir_pre_exit(). */
@@ -109,7 +110,7 @@ ip6frag_expire_frag_queue(struct net *net, struct frag_queue *fq)
 	spin_unlock(&fq->q.lock);
 out_rcu_unlock:
 	rcu_read_unlock();
-	inet_frag_put(&fq->q);
+	inet_frag_putn(&fq->q, refs);
 }
 
 /* Check if the upper layer header is truncated in the first fragment. */
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 867d637d86f08887b8312ebb2c6fc64da42d7df4..2df1a027e68a1a839388ba088d2fb49a10914f91 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -45,6 +45,7 @@ static void lowpan_frag_expire(struct timer_list *t)
 {
 	struct inet_frag_queue *frag = from_timer(frag, t, timer);
 	struct frag_queue *fq;
+	int refs = 1;
 
 	fq = container_of(frag, struct frag_queue, q);
 
@@ -56,7 +57,7 @@ static void lowpan_frag_expire(struct timer_list *t)
 	inet_frag_kill(&fq->q);
 out:
 	spin_unlock(&fq->q.lock);
-	inet_frag_put(&fq->q);
+	inet_frag_putn(&fq->q, refs);
 }
 
 static inline struct lowpan_frag_queue *
@@ -302,13 +303,13 @@ int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
 
 	fq = fq_find(net, cb, &hdr.source, &hdr.dest);
 	if (fq != NULL) {
-		int ret;
+		int ret, refs = 1;
 
 		spin_lock(&fq->q.lock);
 		ret = lowpan_frag_queue(fq, skb, frag_type);
 		spin_unlock(&fq->q.lock);
 
-		inet_frag_put(&fq->q);
+		inet_frag_putn(&fq->q, refs);
 		return ret;
 	}
 
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index d179a2c8422276f99d6e8be599a36b50e1163380..efc4cbee04c272b1afaf5f2d63b11040c22c11e5 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -145,8 +145,7 @@ static void inet_frags_free_cb(void *ptr, void *arg)
 	}
 	spin_unlock_bh(&fq->lock);
 
-	if (refcount_sub_and_test(count, &fq->refcnt))
-		inet_frag_destroy(fq);
+	inet_frag_putn(fq, count);
 }
 
 static LLIST_HEAD(fqdir_free_list);
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index 7a435746a22dee9f11c0dc732a8b5a7724f4eea3..474a26191c89802b7a71212968d89ad2085ae476 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -112,7 +112,7 @@ static void ip4_frag_free(struct inet_frag_queue *q)
 
 static void ipq_put(struct ipq *ipq)
 {
-	inet_frag_put(&ipq->q);
+	inet_frag_putn(&ipq->q, 1);
 }
 
 /* Kill ipq entry. It is not destroyed immediately,
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index 4120e67a8ce6bb44e3396ec6f66e564aae97aeec..fcf969f9fe2ab57b9bdb30434b933b863e3d3369 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -447,6 +447,7 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	struct frag_hdr *fhdr;
 	struct frag_queue *fq;
 	struct ipv6hdr *hdr;
+	int refs = 1;
 	u8 prevhdr;
 
 	/* Jumbo payload inhibits frag. header */
@@ -489,7 +490,7 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	}
 
 	spin_unlock_bh(&fq->q.lock);
-	inet_frag_put(&fq->q);
+	inet_frag_putn(&fq->q, refs);
 	return ret;
 }
 EXPORT_SYMBOL_GPL(nf_ct_frag6_gather);
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index a48be617a8ab5e0ece9b01b427abe410cafef8bc..5d56a8e5166bcb3a5a169a95029bc14180ef9323 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -380,7 +380,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 	fq = fq_find(net, fhdr->identification, hdr, iif);
 	if (fq) {
 		u32 prob_offset = 0;
-		int ret;
+		int ret, refs = 1;
 
 		spin_lock(&fq->q.lock);
 
@@ -389,7 +389,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 				     &prob_offset);
 
 		spin_unlock(&fq->q.lock);
-		inet_frag_put(&fq->q);
+		inet_frag_putn(&fq->q, refs);
 		if (prob_offset) {
 			__IP6_INC_STATS(net, __in6_dev_get_safely(skb->dev),
 					IPSTATS_MIB_INHDRERRORS);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog



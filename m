Return-Path: <netdev+bounces-173349-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 00AB9A5864B
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 18:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8AFE188DD59
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 17:33:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449EE1F4CAF;
	Sun,  9 Mar 2025 17:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rrBk/dFw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2B11F4C96
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 17:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741541523; cv=none; b=oHllksL+HBhcOYogruTZe+qquhOMjBW3ygFMvp+MQYFpUTGT7v0k3HF/r2mSUjHCQA5GV6uXkyBeuwPoaCMrBVGl3qHq8p/8cnj+BdMFmzb95Dak/NfqLZqBp9gllX2K2ZGq9wb5OFureKbf8ugXKIZT+oSHGnURAgvsMLs+zQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741541523; c=relaxed/simple;
	bh=7KQFruVTSWMqtUnm2LkOvad5wHFefefr+MBNoh8ZsSA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ewEx6JxvOVPpM6KrJppiCV3VJOzJn+K9v18XsAFSzgZu9JBPSScYNFqnpaad9U2Z2XB+fauTmCY3x3mQOEUn0GvVxEeYt1fEAb8uk+8OQDwR+zGEjSKsifBezGCJJqD7ayuQIFG9l3smKNQI3VFeN/WiR95ThcH8WM6ey2SU0EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rrBk/dFw; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-47508cfc342so79487011cf.3
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 10:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741541520; x=1742146320; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TNyhXrl3Q3d+M7W/X/xp9odyof0oTnE/2PBvOiRVnZY=;
        b=rrBk/dFwkpaBBGtRnNsfQWEzQVZzljxSxBMdkOQVP5MzkGOnQj5BAYIVKeIfupFGDw
         euUWjLlF6YLhVQ4JJ96hMy+O5Z+GkVv9dRTbZA4QraFInKeYwZCmik1SaVaxSVQWzeDy
         Z8U3RVJmzZMtblrXoI2EI9qG5pUDdg6/GSZp8nrajFbs5JPZYpyWM6nWUDCMCOYyrRx1
         /NJsko9ycKIaVZeB/InnW/StMx4XvQl0TKCZVT1OmbZEjHILJKcgxB1hvbMhby0fngUC
         iwaLIQtG5jVNfSpowkoMaQ5VR25Xw6FMLMVdDtpswB+9nc20uEqooMbyu829V7a2n6VZ
         83zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741541520; x=1742146320;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TNyhXrl3Q3d+M7W/X/xp9odyof0oTnE/2PBvOiRVnZY=;
        b=Fvyf6WuF21ED0lzuO/5fsjRx2i2iiCh2AZn5Xdb1+dR+AT8oMdHnk2UQhL8q7aIafB
         pgHh/3H6lD49r9g9+okDfoO+3z81xvr1c1qaW2Vs46FORvqTpIOBI9OIlzysWBqgSMQO
         +frJf42Iqg9Eh7NStyfw0h15ZbZGEx4UaRh1d1Fa65+wQPgqTdawuKXMkxPRdjZ+I8Sk
         xL7byMbQCj0M6ktHgylSP5cOahSqbJJZx2q11VjEHgL7/enPdauGjflAgAOWPJRbNE9M
         reKbWdiiE362rVffI9GQh/9CVIK1GOhxlmvFc+O/ggci0dg1VlCmnu/ODQGhgTdhG39I
         BVQA==
X-Forwarded-Encrypted: i=1; AJvYcCVGsOlWcyIpSZQEEttQtG3kuzwi4fp08VuCb89U5oVdqzuWehWvIGi/kodruEKD8f46W5J1xgc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxStm4yVuLE6r0XVDRSMYl5Z8DXq9GYr5pPxsLV/BoB5jt4/ic4
	bv+OZ8o1Jwye7Vb1DVVxiTbFD/RKiM/qUI7ZXBj7dwjsK63VEMAoupfaM+WafuYQ1IVeDtD68I9
	z1OjT3Tdo+Q==
X-Google-Smtp-Source: AGHT+IEufIuUzluAhCUkDkyq+hv8TQ3l8CPhgXR5LH1KY5Cq0apFXVhoPNvuPsNxpGvmq+IHmDvJH/aB5TujTA==
X-Received: from qtbhb3.prod.google.com ([2002:a05:622a:2b43:b0:476:6e8b:6971])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5dd2:0:b0:471:bbd5:aff2 with SMTP id d75a77b69052e-476109551a2mr138732111cf.10.1741541520388;
 Sun, 09 Mar 2025 10:32:00 -0700 (PDT)
Date: Sun,  9 Mar 2025 17:31:51 +0000
In-Reply-To: <20250309173151.2863314-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250309173151.2863314-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250309173151.2863314-5-edumazet@google.com>
Subject: [PATCH net-next 4/4] inet: frags: save a pair of atomic operations in reassembly
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

As mentioned in commit 648700f76b03 ("inet: frags:
use rhashtables for reassembly units"):

  A followup patch will even remove the refcount hold/release
  left from prior implementation and save a couple of atomic
  operations.

This patch implements this idea, seven years later.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ieee802154/6lowpan/reassembly.c     |  5 ++++-
 net/ipv4/inet_fragment.c                | 18 ++++++++----------
 net/ipv4/ip_fragment.c                  |  5 ++++-
 net/ipv6/netfilter/nf_conntrack_reasm.c |  5 ++++-
 net/ipv6/reassembly.c                   |  9 ++++-----
 5 files changed, 24 insertions(+), 18 deletions(-)

diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 50c8db80c0ea548e4e68eb8f0023a8aed5c8aece..f68cbbf23df83cf259cbd621230f7a7035b80b22 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -304,17 +304,20 @@ int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
 		goto err;
 	}
 
+	rcu_read_lock();
 	fq = fq_find(net, cb, &hdr.source, &hdr.dest);
 	if (fq != NULL) {
-		int ret, refs = 1;
+		int ret, refs = 0;
 
 		spin_lock(&fq->q.lock);
 		ret = lowpan_frag_queue(fq, skb, frag_type);
 		spin_unlock(&fq->q.lock);
 
+		rcu_read_unlock();
 		inet_frag_putn(&fq->q, refs);
 		return ret;
 	}
+	rcu_read_unlock();
 
 err:
 	kfree_skb(skb);
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index 5eb18605001387e7f23b8661dc9f24a533ab1600..19fae4811ab2803bed2faa4900869f883cb3073c 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -327,7 +327,8 @@ static struct inet_frag_queue *inet_frag_alloc(struct fqdir *fqdir,
 
 	timer_setup(&q->timer, f->frag_expire, 0);
 	spin_lock_init(&q->lock);
-	refcount_set(&q->refcnt, 3);
+	/* One reference for the timer, one for the hash table. */
+	refcount_set(&q->refcnt, 2);
 
 	return q;
 }
@@ -349,7 +350,11 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 	*prev = rhashtable_lookup_get_insert_key(&fqdir->rhashtable, &q->key,
 						 &q->node, f->rhash_params);
 	if (*prev) {
-		int refs = 2;
+		/* We could not insert in the hash table,
+		 * we need to cancel what inet_frag_alloc()
+		 * anticipated.
+		 */
+		int refs = 1;
 
 		q->flags |= INET_FRAG_COMPLETE;
 		inet_frag_kill(q, &refs);
@@ -359,7 +364,6 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 	return q;
 }
 
-/* TODO : call from rcu_read_lock() and no longer use refcount_inc_not_zero() */
 struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void *key)
 {
 	/* This pairs with WRITE_ONCE() in fqdir_pre_exit(). */
@@ -369,17 +373,11 @@ struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void *key)
 	if (!high_thresh || frag_mem_limit(fqdir) > high_thresh)
 		return NULL;
 
-	rcu_read_lock();
-
 	prev = rhashtable_lookup(&fqdir->rhashtable, key, fqdir->f->rhash_params);
 	if (!prev)
 		fq = inet_frag_create(fqdir, key, &prev);
-	if (!IS_ERR_OR_NULL(prev)) {
+	if (!IS_ERR_OR_NULL(prev))
 		fq = prev;
-		if (!refcount_inc_not_zero(&fq->refcnt))
-			fq = NULL;
-	}
-	rcu_read_unlock();
 	return fq;
 }
 EXPORT_SYMBOL(inet_frag_find);
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index c5f3c810706fb328c3d8a4d8501424df0dceaa8e..77f395b28ec748bcd85b8dfa0a8c0b8a74684103 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -483,18 +483,21 @@ int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMREQDS);
 
 	/* Lookup (or create) queue header */
+	rcu_read_lock();
 	qp = ip_find(net, ip_hdr(skb), user, vif);
 	if (qp) {
-		int ret, refs = 1;
+		int ret, refs = 0;
 
 		spin_lock(&qp->q.lock);
 
 		ret = ip_frag_queue(qp, skb, &refs);
 
 		spin_unlock(&qp->q.lock);
+		rcu_read_unlock();
 		inet_frag_putn(&qp->q, refs);
 		return ret;
 	}
+	rcu_read_unlock();
 
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
 	kfree_skb(skb);
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index f33acb730dc5807205811c2675efd27a9ee99222..d6bd8f7079bb74ec99030201163332ed5c6d2eec 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -450,7 +450,7 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	struct frag_hdr *fhdr;
 	struct frag_queue *fq;
 	struct ipv6hdr *hdr;
-	int refs = 1;
+	int refs = 0;
 	u8 prevhdr;
 
 	/* Jumbo payload inhibits frag. header */
@@ -477,9 +477,11 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	hdr = ipv6_hdr(skb);
 	fhdr = (struct frag_hdr *)skb_transport_header(skb);
 
+	rcu_read_lock();
 	fq = fq_find(net, fhdr->identification, user, hdr,
 		     skb->dev ? skb->dev->ifindex : 0);
 	if (fq == NULL) {
+		rcu_read_unlock();
 		pr_debug("Can't find and can't create new queue\n");
 		return -ENOMEM;
 	}
@@ -493,6 +495,7 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 	}
 
 	spin_unlock_bh(&fq->q.lock);
+	rcu_read_unlock();
 	inet_frag_putn(&fq->q, refs);
 	return ret;
 }
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 7560380bd5871217d476f2e0e39332926c458bc1..49740898bc1370ff0ca89928750c6de85a45303f 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -305,9 +305,7 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 	skb_postpush_rcsum(skb, skb_network_header(skb),
 			   skb_network_header_len(skb));
 
-	rcu_read_lock();
 	__IP6_INC_STATS(net, __in6_dev_stats_get(dev, skb), IPSTATS_MIB_REASMOKS);
-	rcu_read_unlock();
 	fq->q.rb_fragments = RB_ROOT;
 	fq->q.fragments_tail = NULL;
 	fq->q.last_run_head = NULL;
@@ -319,9 +317,7 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 out_oom:
 	net_dbg_ratelimited("ip6_frag_reasm: no memory for reassembly\n");
 out_fail:
-	rcu_read_lock();
 	__IP6_INC_STATS(net, __in6_dev_stats_get(dev, skb), IPSTATS_MIB_REASMFAILS);
-	rcu_read_unlock();
 	inet_frag_kill(&fq->q, refs);
 	return -1;
 }
@@ -379,10 +375,11 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 	}
 
 	iif = skb->dev ? skb->dev->ifindex : 0;
+	rcu_read_lock();
 	fq = fq_find(net, fhdr->identification, hdr, iif);
 	if (fq) {
 		u32 prob_offset = 0;
-		int ret, refs = 1;
+		int ret, refs = 0;
 
 		spin_lock(&fq->q.lock);
 
@@ -391,6 +388,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 				     &prob_offset, &refs);
 
 		spin_unlock(&fq->q.lock);
+		rcu_read_unlock();
 		inet_frag_putn(&fq->q, refs);
 		if (prob_offset) {
 			__IP6_INC_STATS(net, __in6_dev_get_safely(skb->dev),
@@ -400,6 +398,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 		}
 		return ret;
 	}
+	rcu_read_unlock();
 
 	__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)), IPSTATS_MIB_REASMFAILS);
 	kfree_skb(skb);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog



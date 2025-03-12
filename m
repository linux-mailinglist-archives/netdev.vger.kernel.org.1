Return-Path: <netdev+bounces-174105-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66BEEA5D80D
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:23:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0308168C5B
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 08:23:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 131BF23535C;
	Wed, 12 Mar 2025 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="IlFdKWfO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05364234988
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 08:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741767781; cv=none; b=bHd7bVO3S1XA7+isM16It6qX8rga9PQw3jNvGUth69ef81Jcwyv1WD32JXwsQYNNkos9BtVgKNFklZlRlzCQfzeKcXjst+rDaI+//ip5APATtZHHkiaCQ2Qf2bJ1p5qCFc5HQnwcs6OGRu2ttpv86+793rDE2mEsue2fvJNfv5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741767781; c=relaxed/simple;
	bh=yForXYj+sEFIAS6YIxZkd3Obm1qzgYxwJuzvRfK0yIE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=WlFR1xHDiopn2+yF31Hshz1cJ6ZBqSTqws96RR1oeM7iJ5fqkgPOXf33ryP/hWxzKf7ZogqyWgiEpB+PP0iX97dWUPWYsd8I3ZbQr12hzNRas6xGyVxrw9NlyZh8kK1Z2gH1Ley2LHXEyMfVoodG2/p3a7aJeFvr/6ZViPrOSxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=IlFdKWfO; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-6e2378169a4so146565766d6.2
        for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 01:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741767778; x=1742372578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=jNBfi1/lbUJlHLjy5IPvPfmEGrTihVHpaTeXQ+Wnfns=;
        b=IlFdKWfOK3W/sGALvZjTs1RhXgC0xlWe+4wGb1e/frHOTP7z5t4k2AJZD3oEHac+qa
         5AC7kIBD8HWZPLGNP1TDPILJs7S/Jk8rnN6jsHaG97ZNAt7dyWwjGSYEZZpp6hs0EejE
         4gAmnf5z2OzmBf3+T435+aSVJc/13frp6w0pRuDz5mnqF50hknO9Rb2eQgicnocvG8Kq
         K8JHGgtq3gBM16uVzsCfDxH/h0X/OEMtB/8Jb1DQ5ljxWyUic4LH9ZOjT7Lmlr96WhIn
         TJwCZMYA1plQXA9a/3eMNLIXzSMQ9z4EGRrhZhOSaR1YkRtl0BfLbrdHQszF4JLYnt2r
         3CNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741767778; x=1742372578;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jNBfi1/lbUJlHLjy5IPvPfmEGrTihVHpaTeXQ+Wnfns=;
        b=c1LXzjFFBogIy/jIPdA3/ZRJZB9K5NT6kpwqpXcjDroQ01EgsgmGC+yspInANi/8fV
         2aIgC6j8Cc73YnjLuD108yATE9aDF34jBqtRjx2vqyo3N77PJkgoRVNsiZ1lw0ivHW9z
         tKYOk0V89AaUAmYeHSMIXadCJUPj9Chw4hiA1vjxVZU5xFg8cj+mSm/iLYCBG4sTQdee
         7TYL9uC7YwleyFqD5QsYyxYddiLBljLYNMnCLPNEFTGhq0X6L1UjQelRZpmdD1SNYKHI
         zDeHqo0fj5L5WVaP5ydFaiefXt9gF2bs/ty4i4oUrp1aWIKtwe06MzlBfwFjJ7xlsvDZ
         iMyg==
X-Forwarded-Encrypted: i=1; AJvYcCWfyHcUfY1rk6uiQAKGwE9Salp5YX2d8jDe0Mf1Rbr2futFIUFo0qZCro8jiuKnuITucnYeM2M=@vger.kernel.org
X-Gm-Message-State: AOJu0YzW3l12fL/fhgAXFMZYmrL+gALDHxdTGzs37OabseZAowSms/pR
	HVwVyfupwYbetu3byzlA2ho9JBU7LCYO7FzTEUM47K/X9JJepY2DG2ld+pWZDnmbz7hk15/VO0V
	jlQ8lZyo2BA==
X-Google-Smtp-Source: AGHT+IEwu1Q+gZgGHajkOI2sml19hYP2U+o0jYJX+w6VSMZKHkmxKfZjoFtysOXZkhuhoDBw1oe6pX7lITkUWg==
X-Received: from qviy2.prod.google.com ([2002:a0c:c542:0:b0:6e4:335e:f744])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:c83:b0:6e6:5efa:4e01 with SMTP id 6a1803df08f44-6e90060fa1amr325399356d6.20.1741767777997;
 Wed, 12 Mar 2025 01:22:57 -0700 (PDT)
Date: Wed, 12 Mar 2025 08:22:49 +0000
In-Reply-To: <20250312082250.1803501-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250312082250.1803501-1-edumazet@google.com>
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250312082250.1803501-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/4] inet: frags: change inet_frag_kill() to defer
 refcount updates
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

In the following patch, we no longer assume inet_frag_kill()
callers own a reference.

Consuming two refcounts from inet_frag_kill() would lead in UAF.

Propagate the pointer to the refs that will be consumed later
by the final inet_frag_putn() call.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/inet_frag.h                 |  2 +-
 include/net/ipv6_frag.h                 |  2 +-
 net/ieee802154/6lowpan/reassembly.c     | 17 ++++++++------
 net/ipv4/inet_fragment.c                | 12 +++++-----
 net/ipv4/ip_fragment.c                  | 30 ++++++++++---------------
 net/ipv6/netfilter/nf_conntrack_reasm.c | 21 +++++++++--------
 net/ipv6/reassembly.c                   | 18 ++++++++-------
 7 files changed, 53 insertions(+), 49 deletions(-)

diff --git a/include/net/inet_frag.h b/include/net/inet_frag.h
index 26687ad0b14142e904b66acee4c98537fa8077c3..0eccd9c3a883fbceb9a0a740237b7245f13c5d26 100644
--- a/include/net/inet_frag.h
+++ b/include/net/inet_frag.h
@@ -137,7 +137,7 @@ static inline void fqdir_pre_exit(struct fqdir *fqdir)
 }
 void fqdir_exit(struct fqdir *fqdir);
 
-void inet_frag_kill(struct inet_frag_queue *q);
+void inet_frag_kill(struct inet_frag_queue *q, int *refs);
 void inet_frag_destroy(struct inet_frag_queue *q);
 struct inet_frag_queue *inet_frag_find(struct fqdir *fqdir, void *key);
 
diff --git a/include/net/ipv6_frag.h b/include/net/ipv6_frag.h
index 9d968d7d9fa402a4dd5e0f3d458bacbdcd49da77..38ef66826939ee561e409f528292ca4af1e29a3b 100644
--- a/include/net/ipv6_frag.h
+++ b/include/net/ipv6_frag.h
@@ -78,7 +78,7 @@ ip6frag_expire_frag_queue(struct net *net, struct frag_queue *fq)
 		goto out;
 
 	fq->q.flags |= INET_FRAG_DROP;
-	inet_frag_kill(&fq->q);
+	inet_frag_kill(&fq->q, &refs);
 
 	dev = dev_get_by_index_rcu(net, fq->iif);
 	if (!dev)
diff --git a/net/ieee802154/6lowpan/reassembly.c b/net/ieee802154/6lowpan/reassembly.c
index 2df1a027e68a1a839388ba088d2fb49a10914f91..c5f86cff06ee7f95556955f994b859c86a315646 100644
--- a/net/ieee802154/6lowpan/reassembly.c
+++ b/net/ieee802154/6lowpan/reassembly.c
@@ -31,7 +31,8 @@ static const char lowpan_frags_cache_name[] = "lowpan-frags";
 static struct inet_frags lowpan_frags;
 
 static int lowpan_frag_reasm(struct lowpan_frag_queue *fq, struct sk_buff *skb,
-			     struct sk_buff *prev,  struct net_device *ldev);
+			     struct sk_buff *prev, struct net_device *ldev,
+			     int *refs);
 
 static void lowpan_frag_init(struct inet_frag_queue *q, const void *a)
 {
@@ -54,7 +55,7 @@ static void lowpan_frag_expire(struct timer_list *t)
 	if (fq->q.flags & INET_FRAG_COMPLETE)
 		goto out;
 
-	inet_frag_kill(&fq->q);
+	inet_frag_kill(&fq->q, &refs);
 out:
 	spin_unlock(&fq->q.lock);
 	inet_frag_putn(&fq->q, refs);
@@ -83,7 +84,8 @@ fq_find(struct net *net, const struct lowpan_802154_cb *cb,
 }
 
 static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
-			     struct sk_buff *skb, u8 frag_type)
+			     struct sk_buff *skb, u8 frag_type,
+			     int *refs)
 {
 	struct sk_buff *prev_tail;
 	struct net_device *ldev;
@@ -144,7 +146,7 @@ static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
 		unsigned long orefdst = skb->_skb_refdst;
 
 		skb->_skb_refdst = 0UL;
-		res = lowpan_frag_reasm(fq, skb, prev_tail, ldev);
+		res = lowpan_frag_reasm(fq, skb, prev_tail, ldev, refs);
 		skb->_skb_refdst = orefdst;
 		return res;
 	}
@@ -163,11 +165,12 @@ static int lowpan_frag_queue(struct lowpan_frag_queue *fq,
  *	the last and the first frames arrived and all the bits are here.
  */
 static int lowpan_frag_reasm(struct lowpan_frag_queue *fq, struct sk_buff *skb,
-			     struct sk_buff *prev_tail, struct net_device *ldev)
+			     struct sk_buff *prev_tail, struct net_device *ldev,
+			     int *refs)
 {
 	void *reasm_data;
 
-	inet_frag_kill(&fq->q);
+	inet_frag_kill(&fq->q, refs);
 
 	reasm_data = inet_frag_reasm_prepare(&fq->q, skb, prev_tail);
 	if (!reasm_data)
@@ -306,7 +309,7 @@ int lowpan_frag_rcv(struct sk_buff *skb, u8 frag_type)
 		int ret, refs = 1;
 
 		spin_lock(&fq->q.lock);
-		ret = lowpan_frag_queue(fq, skb, frag_type);
+		ret = lowpan_frag_queue(fq, skb, frag_type, &refs);
 		spin_unlock(&fq->q.lock);
 
 		inet_frag_putn(&fq->q, refs);
diff --git a/net/ipv4/inet_fragment.c b/net/ipv4/inet_fragment.c
index efc4cbee04c272b1afaf5f2d63b11040c22c11e5..5eb18605001387e7f23b8661dc9f24a533ab1600 100644
--- a/net/ipv4/inet_fragment.c
+++ b/net/ipv4/inet_fragment.c
@@ -225,10 +225,10 @@ void fqdir_exit(struct fqdir *fqdir)
 }
 EXPORT_SYMBOL(fqdir_exit);
 
-void inet_frag_kill(struct inet_frag_queue *fq)
+void inet_frag_kill(struct inet_frag_queue *fq, int *refs)
 {
 	if (del_timer(&fq->timer))
-		refcount_dec(&fq->refcnt);
+		(*refs)++;
 
 	if (!(fq->flags & INET_FRAG_COMPLETE)) {
 		struct fqdir *fqdir = fq->fqdir;
@@ -243,7 +243,7 @@ void inet_frag_kill(struct inet_frag_queue *fq)
 		if (!READ_ONCE(fqdir->dead)) {
 			rhashtable_remove_fast(&fqdir->rhashtable, &fq->node,
 					       fqdir->f->rhash_params);
-			refcount_dec(&fq->refcnt);
+			(*refs)++;
 		} else {
 			fq->flags |= INET_FRAG_HASH_DEAD;
 		}
@@ -349,9 +349,11 @@ static struct inet_frag_queue *inet_frag_create(struct fqdir *fqdir,
 	*prev = rhashtable_lookup_get_insert_key(&fqdir->rhashtable, &q->key,
 						 &q->node, f->rhash_params);
 	if (*prev) {
+		int refs = 2;
+
 		q->flags |= INET_FRAG_COMPLETE;
-		inet_frag_kill(q);
-		inet_frag_destroy(q);
+		inet_frag_kill(q, &refs);
+		inet_frag_putn(q, refs);
 		return NULL;
 	}
 	return q;
diff --git a/net/ipv4/ip_fragment.c b/net/ipv4/ip_fragment.c
index ee953be49b34dd63443e5621e7c2f2b61cf7d914..c5f3c810706fb328c3d8a4d8501424df0dceaa8e 100644
--- a/net/ipv4/ip_fragment.c
+++ b/net/ipv4/ip_fragment.c
@@ -76,7 +76,8 @@ static u8 ip4_frag_ecn(u8 tos)
 static struct inet_frags ip4_frags;
 
 static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
-			 struct sk_buff *prev_tail, struct net_device *dev);
+			 struct sk_buff *prev_tail, struct net_device *dev,
+			 int *refs);
 
 
 static void ip4_frag_init(struct inet_frag_queue *q, const void *a)
@@ -107,14 +108,6 @@ static void ip4_frag_free(struct inet_frag_queue *q)
 		inet_putpeer(qp->peer);
 }
 
-/* Kill ipq entry. It is not destroyed immediately,
- * because caller (and someone more) holds reference count.
- */
-static void ipq_kill(struct ipq *ipq)
-{
-	inet_frag_kill(&ipq->q);
-}
-
 static bool frag_expire_skip_icmp(u32 user)
 {
 	return user == IP_DEFRAG_AF_PACKET ||
@@ -152,7 +145,7 @@ static void ip_expire(struct timer_list *t)
 		goto out;
 
 	qp->q.flags |= INET_FRAG_DROP;
-	ipq_kill(qp);
+	inet_frag_kill(&qp->q, &refs);
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMTIMEOUT);
 
@@ -271,7 +264,7 @@ static int ip_frag_reinit(struct ipq *qp)
 }
 
 /* Add new segment to existing queue. */
-static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
+static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb, int *refs)
 {
 	struct net *net = qp->q.fqdir->net;
 	int ihl, end, flags, offset;
@@ -291,7 +284,7 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 	if (!(IPCB(skb)->flags & IPSKB_FRAG_COMPLETE) &&
 	    unlikely(ip_frag_too_far(qp)) &&
 	    unlikely(err = ip_frag_reinit(qp))) {
-		ipq_kill(qp);
+		inet_frag_kill(&qp->q, refs);
 		goto err;
 	}
 
@@ -375,10 +368,10 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 		unsigned long orefdst = skb->_skb_refdst;
 
 		skb->_skb_refdst = 0UL;
-		err = ip_frag_reasm(qp, skb, prev_tail, dev);
+		err = ip_frag_reasm(qp, skb, prev_tail, dev, refs);
 		skb->_skb_refdst = orefdst;
 		if (err)
-			inet_frag_kill(&qp->q);
+			inet_frag_kill(&qp->q, refs);
 		return err;
 	}
 
@@ -395,7 +388,7 @@ static int ip_frag_queue(struct ipq *qp, struct sk_buff *skb)
 	err = -EINVAL;
 	__IP_INC_STATS(net, IPSTATS_MIB_REASM_OVERLAPS);
 discard_qp:
-	inet_frag_kill(&qp->q);
+	inet_frag_kill(&qp->q, refs);
 	__IP_INC_STATS(net, IPSTATS_MIB_REASMFAILS);
 err:
 	kfree_skb_reason(skb, reason);
@@ -409,7 +402,8 @@ static bool ip_frag_coalesce_ok(const struct ipq *qp)
 
 /* Build a new IP datagram from all its fragments. */
 static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
-			 struct sk_buff *prev_tail, struct net_device *dev)
+			 struct sk_buff *prev_tail, struct net_device *dev,
+			 int *refs)
 {
 	struct net *net = qp->q.fqdir->net;
 	struct iphdr *iph;
@@ -417,7 +411,7 @@ static int ip_frag_reasm(struct ipq *qp, struct sk_buff *skb,
 	int len, err;
 	u8 ecn;
 
-	ipq_kill(qp);
+	inet_frag_kill(&qp->q, refs);
 
 	ecn = ip_frag_ecn_table[qp->ecn];
 	if (unlikely(ecn == 0xff)) {
@@ -495,7 +489,7 @@ int ip_defrag(struct net *net, struct sk_buff *skb, u32 user)
 
 		spin_lock(&qp->q.lock);
 
-		ret = ip_frag_queue(qp, skb);
+		ret = ip_frag_queue(qp, skb, &refs);
 
 		spin_unlock(&qp->q.lock);
 		inet_frag_putn(&qp->q, refs);
diff --git a/net/ipv6/netfilter/nf_conntrack_reasm.c b/net/ipv6/netfilter/nf_conntrack_reasm.c
index fcf969f9fe2ab57b9bdb30434b933b863e3d3369..f33acb730dc5807205811c2675efd27a9ee99222 100644
--- a/net/ipv6/netfilter/nf_conntrack_reasm.c
+++ b/net/ipv6/netfilter/nf_conntrack_reasm.c
@@ -123,7 +123,8 @@ static void __net_exit nf_ct_frags6_sysctl_unregister(struct net *net)
 #endif
 
 static int nf_ct_frag6_reasm(struct frag_queue *fq, struct sk_buff *skb,
-			     struct sk_buff *prev_tail, struct net_device *dev);
+			     struct sk_buff *prev_tail, struct net_device *dev,
+			     int *refs);
 
 static inline u8 ip6_frag_ecn(const struct ipv6hdr *ipv6h)
 {
@@ -167,7 +168,8 @@ static struct frag_queue *fq_find(struct net *net, __be32 id, u32 user,
 
 
 static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,
-			     const struct frag_hdr *fhdr, int nhoff)
+			     const struct frag_hdr *fhdr, int nhoff,
+			     int *refs)
 {
 	unsigned int payload_len;
 	struct net_device *dev;
@@ -221,7 +223,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,
 			 * this case. -DaveM
 			 */
 			pr_debug("end of fragment not rounded to 8 bytes.\n");
-			inet_frag_kill(&fq->q);
+			inet_frag_kill(&fq->q, refs);
 			return -EPROTO;
 		}
 		if (end > fq->q.len) {
@@ -287,7 +289,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,
 		unsigned long orefdst = skb->_skb_refdst;
 
 		skb->_skb_refdst = 0UL;
-		err = nf_ct_frag6_reasm(fq, skb, prev, dev);
+		err = nf_ct_frag6_reasm(fq, skb, prev, dev, refs);
 		skb->_skb_refdst = orefdst;
 
 		/* After queue has assumed skb ownership, only 0 or
@@ -301,7 +303,7 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,
 	return -EINPROGRESS;
 
 insert_error:
-	inet_frag_kill(&fq->q);
+	inet_frag_kill(&fq->q, refs);
 err:
 	skb_dst_drop(skb);
 	return -EINVAL;
@@ -315,13 +317,14 @@ static int nf_ct_frag6_queue(struct frag_queue *fq, struct sk_buff *skb,
  *	the last and the first frames arrived and all the bits are here.
  */
 static int nf_ct_frag6_reasm(struct frag_queue *fq, struct sk_buff *skb,
-			     struct sk_buff *prev_tail, struct net_device *dev)
+			     struct sk_buff *prev_tail, struct net_device *dev,
+			     int *refs)
 {
 	void *reasm_data;
 	int payload_len;
 	u8 ecn;
 
-	inet_frag_kill(&fq->q);
+	inet_frag_kill(&fq->q, refs);
 
 	ecn = ip_frag_ecn_table[fq->ecn];
 	if (unlikely(ecn == 0xff))
@@ -372,7 +375,7 @@ static int nf_ct_frag6_reasm(struct frag_queue *fq, struct sk_buff *skb,
 	return 0;
 
 err:
-	inet_frag_kill(&fq->q);
+	inet_frag_kill(&fq->q, refs);
 	return -EINVAL;
 }
 
@@ -483,7 +486,7 @@ int nf_ct_frag6_gather(struct net *net, struct sk_buff *skb, u32 user)
 
 	spin_lock_bh(&fq->q.lock);
 
-	ret = nf_ct_frag6_queue(fq, skb, fhdr, nhoff);
+	ret = nf_ct_frag6_queue(fq, skb, fhdr, nhoff, &refs);
 	if (ret == -EPROTO) {
 		skb->transport_header = savethdr;
 		ret = 0;
diff --git a/net/ipv6/reassembly.c b/net/ipv6/reassembly.c
index 5d56a8e5166bcb3a5a169a95029bc14180ef9323..7560380bd5871217d476f2e0e39332926c458bc1 100644
--- a/net/ipv6/reassembly.c
+++ b/net/ipv6/reassembly.c
@@ -68,7 +68,8 @@ static u8 ip6_frag_ecn(const struct ipv6hdr *ipv6h)
 static struct inet_frags ip6_frags;
 
 static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
-			  struct sk_buff *prev_tail, struct net_device *dev);
+			  struct sk_buff *prev_tail, struct net_device *dev,
+			  int *refs);
 
 static void ip6_frag_expire(struct timer_list *t)
 {
@@ -105,7 +106,7 @@ fq_find(struct net *net, __be32 id, const struct ipv6hdr *hdr, int iif)
 
 static int ip6_frag_queue(struct frag_queue *fq, struct sk_buff *skb,
 			  struct frag_hdr *fhdr, int nhoff,
-			  u32 *prob_offset)
+			  u32 *prob_offset, int *refs)
 {
 	struct net *net = dev_net(skb_dst(skb)->dev);
 	int offset, end, fragsize;
@@ -220,7 +221,7 @@ static int ip6_frag_queue(struct frag_queue *fq, struct sk_buff *skb,
 		unsigned long orefdst = skb->_skb_refdst;
 
 		skb->_skb_refdst = 0UL;
-		err = ip6_frag_reasm(fq, skb, prev_tail, dev);
+		err = ip6_frag_reasm(fq, skb, prev_tail, dev, refs);
 		skb->_skb_refdst = orefdst;
 		return err;
 	}
@@ -238,7 +239,7 @@ static int ip6_frag_queue(struct frag_queue *fq, struct sk_buff *skb,
 	__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
 			IPSTATS_MIB_REASM_OVERLAPS);
 discard_fq:
-	inet_frag_kill(&fq->q);
+	inet_frag_kill(&fq->q, refs);
 	__IP6_INC_STATS(net, ip6_dst_idev(skb_dst(skb)),
 			IPSTATS_MIB_REASMFAILS);
 err:
@@ -254,7 +255,8 @@ static int ip6_frag_queue(struct frag_queue *fq, struct sk_buff *skb,
  *	the last and the first frames arrived and all the bits are here.
  */
 static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
-			  struct sk_buff *prev_tail, struct net_device *dev)
+			  struct sk_buff *prev_tail, struct net_device *dev,
+			  int *refs)
 {
 	struct net *net = fq->q.fqdir->net;
 	unsigned int nhoff;
@@ -262,7 +264,7 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 	int payload_len;
 	u8 ecn;
 
-	inet_frag_kill(&fq->q);
+	inet_frag_kill(&fq->q, refs);
 
 	ecn = ip_frag_ecn_table[fq->ecn];
 	if (unlikely(ecn == 0xff))
@@ -320,7 +322,7 @@ static int ip6_frag_reasm(struct frag_queue *fq, struct sk_buff *skb,
 	rcu_read_lock();
 	__IP6_INC_STATS(net, __in6_dev_stats_get(dev, skb), IPSTATS_MIB_REASMFAILS);
 	rcu_read_unlock();
-	inet_frag_kill(&fq->q);
+	inet_frag_kill(&fq->q, refs);
 	return -1;
 }
 
@@ -386,7 +388,7 @@ static int ipv6_frag_rcv(struct sk_buff *skb)
 
 		fq->iif = iif;
 		ret = ip6_frag_queue(fq, skb, fhdr, IP6CB(skb)->nhoff,
-				     &prob_offset);
+				     &prob_offset, &refs);
 
 		spin_unlock(&fq->q.lock);
 		inet_frag_putn(&fq->q, refs);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog



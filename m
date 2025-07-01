Return-Path: <netdev+bounces-203057-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 39574AF06F4
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 01:30:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 381CF4A82B6
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 23:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DED306DAB;
	Tue,  1 Jul 2025 23:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UbqCWbnx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F345E302CB3
	for <netdev@vger.kernel.org>; Tue,  1 Jul 2025 23:30:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751412603; cv=none; b=OzMSOHitAaKn30KDNjrcJTQt/JSHaUGRE3VaG4PTeMLKTFGDC63b2IL4zqpHu7coZv+Ub02pTrFFu8MGc6EbbCoAV4L7k7m9g7ITijiV32muVSV+PayAOrspwSnhLk+5eWN9HhjQkzMzmHW2OAmRdEAusTOOf3NPxJENxXQ8aK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751412603; c=relaxed/simple;
	bh=yYYC/sQHf3BrPpRljkPS+R+o7BJm6Yvk4k1gQ84HKMc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DFk1Ksd5PxB1ydO/CUQ+/ErEOU7igK0C0pplBMXyBMI1VxkGPDq0uSgrBV7vImDb9aRDaQX+Xp4GsjvH3Ym2jXImgGstuetIt/emKZDUyhOEXws7q9dgBr4EYZfvdVGIU2nul3OARAOGdNzBgEQfaKHtq5ufpTvSdeMQP9gqFPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UbqCWbnx; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7424ccbef4eso3538700b3a.2
        for <netdev@vger.kernel.org>; Tue, 01 Jul 2025 16:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751412601; x=1752017401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9CFUWXpel4NQBWiA39YeQuDumC2wbW/xXw4eT1S6zu4=;
        b=UbqCWbnxXPInNHAl2N0n5rkr17guTXWs5KlfaLP48zF+xG+ceBEbTgmy/7Nhb4gHyA
         K3vbzTusmkDbgaFGDebaxcZ0NJFThWMHCEvbhthyGknbvvDq//1DPtyZMDqvozzXvhH6
         cXuie4Fe+YniuqfemYBvrHOt8noyM8ErI5XSVIBM5EtNIBzUOyAxG9cxhk5uzaRCPEP1
         /L7GffuARrIXwejWwXohwakj+o5m6gpx+/OyEt8201WV+KNY9Hwf0QzV5/la0XWXFEpO
         3aT/BDyBuxex7F4IUOHskP78uHk4HK6O/WJbtVub1B7j9yUEfMs3syYhCqWSrI7ukG9I
         +OmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751412601; x=1752017401;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9CFUWXpel4NQBWiA39YeQuDumC2wbW/xXw4eT1S6zu4=;
        b=xBzNBHteKV/cigwlg6/HAex+QiANC5RL3Yu0051N8eZTeGXuTVDDH1KVkNyQvOhGvT
         16vbPt5alqgkX8hs2il4P7C2QLPaQlC5sJnEx5+Aj8dXblS2XQo+Orz8iN9usvgewAaU
         weWqBMXYXft2JNLBAmJckGy2OntKu+L1WtFWZ2Pugj3MwMf3vbxKQfsxJZuJPLepiuyy
         7K94YgCtt9dDaBPWYqHyoe/Y5PaVSex7Y/tKvsAosvKq4zo5w/X1LRgWBjiSbPMuGznx
         nzdLwPaNtK0gAhQntuozBdwr0hw2y9OooMLfBHkGtxVOFMhFduyi0Cmx0rq0atIOKA2j
         YYbg==
X-Gm-Message-State: AOJu0Yz8fh18LVCtuDuKRDEJ7AL7dOWT3XZZCZq0zkJYTWQqyU3BTwZ8
	3HfdGxr7GBMlTrfrkY6lL4RQ90FSJTtOO4qXKElvJFdmXULSLM3LrWMTqpP9jw==
X-Gm-Gg: ASbGncuvpl1C5odCu7uAeqamz4g2S/UF2DQ/upDL+NXh2P1XXCgyEKLlOy+VRx7S06h
	GImYatOSqUcnR41tpnjXe0UxNhJ/HOm1V2sU9g4QxLKr6At+eLva1tmMJjYdR1yWNIewvqqOJWr
	diNDt56fjWf7yyr+pL8VD9NwLMGRaFeF0l9G2X2FuK5pjBw8mTl2qwX8fU2oLP4JDKu07Jyad4o
	dx6s0y4rIXnumNCgIwLs2SiHOL2rWRQGQbhyEX1juNCdqkWDagUDljseClTY9wcr2wQWcOK8A2c
	YDghNnJVCoCBXPDiJhSOer11egnHSu5odpotB06OyvpRWhIJGsT01DEJ2IZxiQTPyDfUufS9XP1
	ARa1E9VE=
X-Google-Smtp-Source: AGHT+IFu5oP/awmtqVdCygjFPoheqSffdSFTW1LYI5g5SrMml2IMd3auTT5P9WztuIXWMh3hOSw5aw==
X-Received: by 2002:a05:6a20:7490:b0:220:10e5:825d with SMTP id adf61e73a8af0-222d7db18a1mr1685813637.8.1751412600830;
        Tue, 01 Jul 2025 16:30:00 -0700 (PDT)
Received: from pop-os.scu.edu ([129.210.115.104])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-74af54098a3sm12909269b3a.16.2025.07.01.16.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Jul 2025 16:30:00 -0700 (PDT)
From: Cong Wang <xiyou.wangcong@gmail.com>
To: netdev@vger.kernel.org
Cc: jhs@mojatatu.com,
	jiri@resnulli.us,
	mincho@theori.io,
	victor@mojatatu.com,
	Cong Wang <xiyou.wangcong@gmail.com>
Subject: [RFC Patch net-next 1/2] net_sched: Move GSO segmentation to root qdisc
Date: Tue,  1 Jul 2025 16:29:14 -0700
Message-Id: <20250701232915.377351-2-xiyou.wangcong@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250701232915.377351-1-xiyou.wangcong@gmail.com>
References: <20250701232915.377351-1-xiyou.wangcong@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Currently, GSO segmentation was performed inside classful qdiscs like TBF, which
would then enqueue the resulting segments into their child qdiscs (e.g., QFQ,
Netem). This approach implicitly required atomic (all-or-nothing) enqueue
semantics from the qdisc API, which is not guaranteed. If a partial enqueue
occurred—where some segments were accepted by the child and others were
not—this could leave the parent and child qdiscs in an inconsistent state,
potentially leading to use-after-free vulnerabilities and queue corruption.

This patch moves GSO segmentation to the root qdisc enqueue path. Now,
segmentation is performed before any qdisc enqueues, and each segment is
treated as an independent packet by the entire qdisc hierarchy.

Key advantages:
- No Partial Enqueue: Each segment is enqueued independently. If any enqueue
  fails, only that segment is affected, and there is no need to roll back
  previous enqueues.
- No Transactional Requirement: The qdisc hierarchy no longer needs to provide
  atomic multi-packet enqueue, removing the root cause of the original
  vulnerability.
- Consistent Queue State: Each qdisc always has an accurate view of its queue
  contents, eliminating scenarios where the parent and child disagree about
  which packets are present.
- No Dangling Pointers: Since segments are never enqueued as a group, there is
  no risk of use-after-free due to partial enqueues.

By performing segmentation at the root, the qdisc stack is simplified, more
robust, and less error-prone, with atomicity and rollback issues avoided
entirely.

Reported-by: Mingi Cho <mincho@theori.io>
Signed-off-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 include/net/sch_generic.h |  1 +
 net/core/dev.c            | 38 +++++++++++++++-
 net/sched/sch_api.c       |  7 +++
 net/sched/sch_cake.c      | 93 +++++++++++++--------------------------
 net/sched/sch_netem.c     | 32 +-------------
 net/sched/sch_taprio.c    | 53 +---------------------
 net/sched/sch_tbf.c       | 51 +--------------------
 7 files changed, 80 insertions(+), 195 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 638948be4c50..9c4082ccefb5 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -95,6 +95,7 @@ struct Qdisc {
 #define TCQ_F_INVISIBLE		0x80 /* invisible by default in dump */
 #define TCQ_F_NOLOCK		0x100 /* qdisc does not require locking */
 #define TCQ_F_OFFLOADED		0x200 /* qdisc is offloaded to HW */
+#define TCQ_F_NEED_SEGMENT	0x400 /* requires skb to be segmented before enqueue */
 	u32			limit;
 	const struct Qdisc_ops	*ops;
 	struct qdisc_size_table	__rcu *stab;
diff --git a/net/core/dev.c b/net/core/dev.c
index 7ee808eb068e..95627552488e 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -4061,8 +4061,44 @@ static int dev_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *q,
 			     struct sk_buff **to_free,
 			     struct netdev_queue *txq)
 {
-	int rc;
+	int rc = NET_XMIT_SUCCESS;
+
+	if ((q->flags & TCQ_F_NEED_SEGMENT) && skb_is_gso(skb)) {
+		netdev_features_t features = netif_skb_features(skb);
+		struct sk_buff *segs, *nskb, *next;
+		struct sk_buff *fail_list = NULL;
+		bool any_fail = false;
+		int seg_rc;
+
+		segs = skb_gso_segment(skb, features);
+		if (IS_ERR(segs)) {
+			kfree_skb_reason(skb, SKB_DROP_REASON_NOT_SPECIFIED);
+			return NET_XMIT_DROP;
+		}
+		consume_skb(skb);
+
+		for (nskb = segs; nskb; nskb = next) {
+			next = nskb->next;
+			nskb->next = NULL;
+			seg_rc = q->enqueue(nskb, q, to_free) & NET_XMIT_MASK;
+			if (seg_rc != NET_XMIT_SUCCESS) {
+				/* On failure, drop this and all remaining segments */
+				kfree_skb_reason(nskb, SKB_DROP_REASON_QDISC_DROP);
+				any_fail = true;
+				fail_list = next;
+				break;
+			}
+			trace_qdisc_enqueue(q, txq, nskb);
+		}
+
+		if (any_fail && fail_list) {
+			kfree_skb_list_reason(fail_list, SKB_DROP_REASON_QDISC_DROP);
+			rc = NET_XMIT_DROP;
+		}
+		return rc;
+	}
 
+	/* Non-GSO path: enqueue as usual */
 	rc = q->enqueue(skb, q, to_free) & NET_XMIT_MASK;
 	if (rc == NET_XMIT_SUCCESS)
 		trace_qdisc_enqueue(q, txq, skb);
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index c5e3673aadbe..8a83e55ebc0d 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -1210,6 +1210,13 @@ static int qdisc_graft(struct net_device *dev, struct Qdisc *parent,
 		err = cops->graft(parent, cl, new, &old, extack);
 		if (err)
 			return err;
+		/* Propagate TCQ_F_NEED_SEGMENT to root Qdisc if needed */
+		if (new && (new->flags & TCQ_F_NEED_SEGMENT)) {
+			struct Qdisc *root = qdisc_root(parent);
+
+			if (root)
+				root->flags |= TCQ_F_NEED_SEGMENT;
+		}
 		notify_and_destroy(net, skb, n, classid, old, new, extack);
 	}
 	return 0;
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 48dd8c88903f..cd98db3d3b14 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1784,73 +1784,38 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (unlikely(len > b->max_skblen))
 		b->max_skblen = len;
 
-	if (skb_is_gso(skb) && q->rate_flags & CAKE_FLAG_SPLIT_GSO) {
-		struct sk_buff *segs, *nskb;
-		netdev_features_t features = netif_skb_features(skb);
-		unsigned int slen = 0, numsegs = 0;
-
-		segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
-		if (IS_ERR_OR_NULL(segs))
-			return qdisc_drop(skb, sch, to_free);
-
-		skb_list_walk_safe(segs, segs, nskb) {
-			skb_mark_not_on_list(segs);
-			qdisc_skb_cb(segs)->pkt_len = segs->len;
-			cobalt_set_enqueue_time(segs, now);
-			get_cobalt_cb(segs)->adjusted_len = cake_overhead(q,
-									  segs);
-			flow_queue_add(flow, segs);
-
-			sch->q.qlen++;
-			numsegs++;
-			slen += segs->len;
-			q->buffer_used += segs->truesize;
-			b->packets++;
-		}
-
-		/* stats */
-		b->bytes	    += slen;
-		b->backlogs[idx]    += slen;
-		b->tin_backlog      += slen;
-		sch->qstats.backlog += slen;
-		q->avg_window_bytes += slen;
+	/* not splitting */
+	cobalt_set_enqueue_time(skb, now);
+	get_cobalt_cb(skb)->adjusted_len = cake_overhead(q, skb);
+	flow_queue_add(flow, skb);
+
+	if (q->ack_filter)
+		ack = cake_ack_filter(q, flow);
+
+	if (ack) {
+		b->ack_drops++;
+		sch->qstats.drops++;
+		b->bytes += qdisc_pkt_len(ack);
+		len -= qdisc_pkt_len(ack);
+		q->buffer_used += skb->truesize - ack->truesize;
+		if (q->rate_flags & CAKE_FLAG_INGRESS)
+			cake_advance_shaper(q, b, ack, now, true);
 
-		qdisc_tree_reduce_backlog(sch, 1-numsegs, len-slen);
-		consume_skb(skb);
+		qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(ack));
+		consume_skb(ack);
 	} else {
-		/* not splitting */
-		cobalt_set_enqueue_time(skb, now);
-		get_cobalt_cb(skb)->adjusted_len = cake_overhead(q, skb);
-		flow_queue_add(flow, skb);
-
-		if (q->ack_filter)
-			ack = cake_ack_filter(q, flow);
-
-		if (ack) {
-			b->ack_drops++;
-			sch->qstats.drops++;
-			b->bytes += qdisc_pkt_len(ack);
-			len -= qdisc_pkt_len(ack);
-			q->buffer_used += skb->truesize - ack->truesize;
-			if (q->rate_flags & CAKE_FLAG_INGRESS)
-				cake_advance_shaper(q, b, ack, now, true);
-
-			qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(ack));
-			consume_skb(ack);
-		} else {
-			sch->q.qlen++;
-			q->buffer_used      += skb->truesize;
-		}
-
-		/* stats */
-		b->packets++;
-		b->bytes	    += len;
-		b->backlogs[idx]    += len;
-		b->tin_backlog      += len;
-		sch->qstats.backlog += len;
-		q->avg_window_bytes += len;
+		sch->q.qlen++;
+		q->buffer_used      += skb->truesize;
 	}
 
+	/* stats */
+	b->packets++;
+	b->bytes	    += len;
+	b->backlogs[idx]    += len;
+	b->tin_backlog      += len;
+	sch->qstats.backlog += len;
+	q->avg_window_bytes += len;
+
 	if (q->overflow_timeout)
 		cake_heapify_up(q, b->overflow_idx[idx]);
 
@@ -2690,6 +2655,8 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 	}
 
 	WRITE_ONCE(q->rate_flags, rate_flags);
+	if (q->rate_flags & CAKE_FLAG_SPLIT_GSO)
+		sch->flags |= TCQ_F_NEED_SEGMENT;
 	WRITE_ONCE(q->flow_mode, flow_mode);
 	if (q->tins) {
 		sch_tree_lock(sch);
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index fdd79d3ccd8c..96bb2440ce83 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -419,26 +419,6 @@ static void tfifo_enqueue(struct sk_buff *nskb, struct Qdisc *sch)
 	sch->q.qlen++;
 }
 
-/* netem can't properly corrupt a megapacket (like we get from GSO), so instead
- * when we statistically choose to corrupt one, we instead segment it, returning
- * the first packet to be corrupted, and re-enqueue the remaining frames
- */
-static struct sk_buff *netem_segment(struct sk_buff *skb, struct Qdisc *sch,
-				     struct sk_buff **to_free)
-{
-	struct sk_buff *segs;
-	netdev_features_t features = netif_skb_features(skb);
-
-	segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
-
-	if (IS_ERR_OR_NULL(segs)) {
-		qdisc_drop(skb, sch, to_free);
-		return NULL;
-	}
-	consume_skb(skb);
-	return segs;
-}
-
 /*
  * Insert one skb into qdisc.
  * Note: parent depends on return value to account for queue length.
@@ -496,16 +476,6 @@ static int netem_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	 * do it now in software before we mangle it.
 	 */
 	if (q->corrupt && q->corrupt >= get_crandom(&q->corrupt_cor, &q->prng)) {
-		if (skb_is_gso(skb)) {
-			skb = netem_segment(skb, sch, to_free);
-			if (!skb)
-				goto finish_segs;
-
-			segs = skb->next;
-			skb_mark_not_on_list(skb);
-			qdisc_skb_cb(skb)->pkt_len = skb->len;
-		}
-
 		skb = skb_unshare(skb, GFP_ATOMIC);
 		if (unlikely(!skb)) {
 			qdisc_qstats_drop(sch);
@@ -1075,6 +1045,8 @@ static int netem_change(struct Qdisc *sch, struct nlattr *opt,
 	else
 		q->prng.seed = get_random_u64();
 	prandom_seed_state(&q->prng.prng_state, q->prng.seed);
+	if (q->corrupt)
+		sch->flags |= TCQ_F_NEED_SEGMENT;
 
 unlock:
 	sch_tree_unlock(sch);
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 2b14c81a87e5..6b02a6697378 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -574,47 +574,6 @@ static int taprio_enqueue_one(struct sk_buff *skb, struct Qdisc *sch,
 	return qdisc_enqueue(skb, child, to_free);
 }
 
-static int taprio_enqueue_segmented(struct sk_buff *skb, struct Qdisc *sch,
-				    struct Qdisc *child,
-				    struct sk_buff **to_free)
-{
-	unsigned int slen = 0, numsegs = 0, len = qdisc_pkt_len(skb);
-	netdev_features_t features = netif_skb_features(skb);
-	struct sk_buff *segs, *nskb;
-	int ret;
-
-	segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
-	if (IS_ERR_OR_NULL(segs))
-		return qdisc_drop(skb, sch, to_free);
-
-	skb_list_walk_safe(segs, segs, nskb) {
-		skb_mark_not_on_list(segs);
-		qdisc_skb_cb(segs)->pkt_len = segs->len;
-		slen += segs->len;
-
-		/* FIXME: we should be segmenting to a smaller size
-		 * rather than dropping these
-		 */
-		if (taprio_skb_exceeds_queue_max_sdu(sch, segs))
-			ret = qdisc_drop(segs, sch, to_free);
-		else
-			ret = taprio_enqueue_one(segs, sch, child, to_free);
-
-		if (ret != NET_XMIT_SUCCESS) {
-			if (net_xmit_drop_count(ret))
-				qdisc_qstats_drop(sch);
-		} else {
-			numsegs++;
-		}
-	}
-
-	if (numsegs > 1)
-		qdisc_tree_reduce_backlog(sch, 1 - numsegs, len - slen);
-	consume_skb(skb);
-
-	return numsegs > 0 ? NET_XMIT_SUCCESS : NET_XMIT_DROP;
-}
-
 /* Will not be called in the full offload case, since the TX queues are
  * attached to the Qdisc created using qdisc_create_dflt()
  */
@@ -631,18 +590,8 @@ static int taprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (unlikely(!child))
 		return qdisc_drop(skb, sch, to_free);
 
-	if (taprio_skb_exceeds_queue_max_sdu(sch, skb)) {
-		/* Large packets might not be transmitted when the transmission
-		 * duration exceeds any configured interval. Therefore, segment
-		 * the skb into smaller chunks. Drivers with full offload are
-		 * expected to handle this in hardware.
-		 */
-		if (skb_is_gso(skb))
-			return taprio_enqueue_segmented(skb, sch, child,
-							to_free);
-
+	if (taprio_skb_exceeds_queue_max_sdu(sch, skb))
 		return qdisc_drop(skb, sch, to_free);
-	}
 
 	return taprio_enqueue_one(skb, sch, child, to_free);
 }
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index 4c977f049670..6200a6e70113 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -199,49 +199,6 @@ static void tbf_offload_graft(struct Qdisc *sch, struct Qdisc *new,
 				   TC_SETUP_QDISC_TBF, &graft_offload, extack);
 }
 
-/* GSO packet is too big, segment it so that tbf can transmit
- * each segment in time
- */
-static int tbf_segment(struct sk_buff *skb, struct Qdisc *sch,
-		       struct sk_buff **to_free)
-{
-	struct tbf_sched_data *q = qdisc_priv(sch);
-	struct sk_buff *segs, *nskb;
-	netdev_features_t features = netif_skb_features(skb);
-	unsigned int len = 0, prev_len = qdisc_pkt_len(skb), seg_len;
-	int ret, nb;
-
-	segs = skb_gso_segment(skb, features & ~NETIF_F_GSO_MASK);
-
-	if (IS_ERR_OR_NULL(segs))
-		return qdisc_drop(skb, sch, to_free);
-
-	nb = 0;
-	skb_list_walk_safe(segs, segs, nskb) {
-		skb_mark_not_on_list(segs);
-		seg_len = segs->len;
-		qdisc_skb_cb(segs)->pkt_len = seg_len;
-		ret = qdisc_enqueue(segs, q->qdisc, to_free);
-		if (ret != NET_XMIT_SUCCESS) {
-			if (net_xmit_drop_count(ret))
-				qdisc_qstats_drop(sch);
-		} else {
-			nb++;
-			len += seg_len;
-		}
-	}
-	sch->q.qlen += nb;
-	sch->qstats.backlog += len;
-	if (nb > 0) {
-		qdisc_tree_reduce_backlog(sch, 1 - nb, prev_len - len);
-		consume_skb(skb);
-		return NET_XMIT_SUCCESS;
-	}
-
-	kfree_skb(skb);
-	return NET_XMIT_DROP;
-}
-
 static int tbf_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		       struct sk_buff **to_free)
 {
@@ -249,12 +206,8 @@ static int tbf_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	unsigned int len = qdisc_pkt_len(skb);
 	int ret;
 
-	if (qdisc_pkt_len(skb) > q->max_size) {
-		if (skb_is_gso(skb) &&
-		    skb_gso_validate_mac_len(skb, q->max_size))
-			return tbf_segment(skb, sch, to_free);
+	if (qdisc_pkt_len(skb) > q->max_size)
 		return qdisc_drop(skb, sch, to_free);
-	}
 	ret = qdisc_enqueue(skb, q->qdisc, to_free);
 	if (ret != NET_XMIT_SUCCESS) {
 		if (net_xmit_drop_count(ret))
@@ -493,7 +446,7 @@ static int tbf_init(struct Qdisc *sch, struct nlattr *opt,
 		return -EINVAL;
 
 	q->t_c = ktime_get_ns();
-
+	sch->flags |= TCQ_F_NEED_SEGMENT;
 	return tbf_change(sch, opt, extack);
 }
 
-- 
2.34.1



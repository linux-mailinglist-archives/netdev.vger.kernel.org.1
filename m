Return-Path: <netdev+bounces-151064-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A1EC9ECA26
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 11:17:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78AF5188B925
	for <lists+netdev@lfdr.de>; Wed, 11 Dec 2024 10:17:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4663386330;
	Wed, 11 Dec 2024 10:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LXj0r6Em"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B3D6236FBE
	for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 10:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733912252; cv=none; b=haCB0Rza0sd5zuiBydh1QeMNvC6G54mru6PqCc4bKhkVRvjaaN91fgYQaCl2G624yZpyLNVPx/Ffi6unX92df9hLrVxxCEb5sTbtjub/axUSKZIbzaFPXWnUIrWM1fy12s5Lhv6j/oD/+kJTSwIzWtTzHRLSKUTu9WeZ8CK0i5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733912252; c=relaxed/simple;
	bh=0alu2WejjJ2ScrEhTbxdb4hcYBA/+OFvJTA00lRStGk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pyi2u3wdymOpfjUOYBcPgcwUJesG3CE8L9BofJMDFpP3TqsEYKDA1oYnMC/b7rpVq9XBkOmXdgPSR9noCfjD1ctq+y8IMjzWtZR48GoOcVy4p2dZMMPQ3+gypEvRkXERuOS+QHr5c8zucUot3tzHCPQHY+wNJzgm9q3jPHB1NfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LXj0r6Em; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733912249;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=M9zJVggtTmdu3KzfuhyLWooNUtfdXK1FNoWWOWUupHk=;
	b=LXj0r6EmuJcsFfSYNI8OYDt7Y6VyGy1ZgSZFr1rKxg2sEtI1VYmqo+TVIuL07M7UauCA/4
	Ns/otW68l/VWtRm7RojD6TadlJoNiNO3Nyi5FRDXIFDxwO0eIHVrpWDpg/Y/iIrk5X9wNU
	V3o2ctUZ2bovkjOglAH4Whh7qhqdWv4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-hZXFLNzHNW2gYgwaRu8s1Q-1; Wed, 11 Dec 2024 05:17:27 -0500
X-MC-Unique: hZXFLNzHNW2gYgwaRu8s1Q-1
X-Mimecast-MFC-AGG-ID: hZXFLNzHNW2gYgwaRu8s1Q
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-aa68fd5393cso77055566b.0
        for <netdev@vger.kernel.org>; Wed, 11 Dec 2024 02:17:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733912246; x=1734517046;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M9zJVggtTmdu3KzfuhyLWooNUtfdXK1FNoWWOWUupHk=;
        b=AUuoUIh49F1mm8qTatt8jADAbkna7AARx2XtgQUBS9GiJ25ugbQIOZnWB31BEsWr3f
         chANH239OtbiN6aPQrpSKHaRImcDgVeSo/9FTfkM4+RKI00Lzw3Ok7q9uVKbMt0KK11V
         3bEStsd8urIvJVxJ/17XGrfKdSx/HxEF/fMGJh660BYOI8+0FaolQnLcgrIwC7ZJaGKy
         eXBDiY/GmtaRVPz5pJOpmjImvA9Z3yPqWIQF/hiRt9TBDreZz3MPkcFEocBTic7QHg3i
         RqS4eUJ32opngX7NsK0lQhCYEtMK2+kztWUEQw0wlO54WPBtiNxYIPlCTUo8/EN+N7GX
         40UA==
X-Gm-Message-State: AOJu0YycIgobqLf/35JDk16v0iRz2TvMTCrzr7qugv8tw3+GgGc59pSp
	evzcdfZKH3/AeI1Ew554RuRHPX19WavvhnN5eHFgnQdBQNJHScuZqhMJmOPX3bJ4OlfEz/vRxXs
	sfTnFIe9M6WuvEHSFV5ECuXq78/2kAkka+CUPUIlllmmXeWyM24ql2A==
X-Gm-Gg: ASbGncuSmyCUe/+uCBgU/BvNub2zVYbpac6WFxTRMN0LPei2OTgWQS3yDtPgEkSFMRj
	Nm8nI6Mz/4dR6YZXc0ofypu40wQ4ZSptDfVZdRqmN36n3X9VJ5mqTKhaLar7jkYJpll8QxstiDH
	52eU/Fme7n1fnAnurgWCxPmETFLTv4kGI6ZzpAWwPUCiFOALN/+g6CvJvgSwnRe8gbkaDxW6si3
	jh249+qD1hx9siNO9znCxRTdg2m8k/2co/b8MVl59mlTpbSYtk=
X-Received: by 2002:a17:906:23e1:b0:aa6:9eac:4b83 with SMTP id a640c23a62f3a-aa6b159dce6mr185098366b.12.1733912246469;
        Wed, 11 Dec 2024 02:17:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGSg4lxIpRE0Pgirq1L/Eznuw06rdzIT7ddhWqydGde+0G1kjM0e3Aqvnq5MF6nND5n3qyxEA==
X-Received: by 2002:a17:906:23e1:b0:aa6:9eac:4b83 with SMTP id a640c23a62f3a-aa6b159dce6mr185094966b.12.1733912245974;
        Wed, 11 Dec 2024 02:17:25 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa678f34c68sm528413666b.38.2024.12.11.02.17.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Dec 2024 02:17:25 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 78DA716BDC4D; Wed, 11 Dec 2024 11:17:24 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Wed, 11 Dec 2024 11:17:09 +0100
Subject: [PATCH net-next v2] net_sched: sch_cake: Add drop reasons
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241211-cake-drop-reason-v2-1-920afadf4d1b@redhat.com>
X-B4-Tracking: v=1; b=H4sIAKRmWWcC/2WNwQrCMBBEf6Xs2ZVu0Eg9+R/SQ0w2NohJ2YRQK
 f13Q/Emc3oM82aFzBI4w7VbQbiGHFJsoA4d2MnEJ2NwjUH16kSqP6M1L0YnaUZhk1PEB2lNTHz
 xvYE2m4V9WHblHSIXjLwUGFszhVySfPavSnv/0w7/2krYMrRLrx15Gm7CbjLlaNMbxm3bvnkYl
 qm7AAAA
X-Change-ID: 20241205-cake-drop-reason-b1661e1e7f0a
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, cake@lists.bufferbloat.net, 
 Dave Taht <dave.taht@gmail.com>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

Add three qdisc-specific drop reasons and use them in sch_cake:

 1) SKB_DROP_REASON_QDISC_OVERLIMIT
    Whenever the total queue limit for a qdisc instance is exceeded
    and a packet is dropped to make room.

 2) SKB_DROP_REASON_QDISC_CONGESTED
    Whenever a packet is dropped by the qdisc AQM algorithm because
    congestion is detected.

 3) SKB_DROP_REASON_CAKE_FLOOD
    Whenever a packet is dropped by the flood protection part of the
    CAKE AQM algorithm (BLUE).

Also use the existing SKB_DROP_REASON_QUEUE_PURGE in cake_clear_tin().

Reasons show up as:

perf record -a -e skb:kfree_skb sleep 1; perf script

          iperf3     665 [005]   848.656964: skb:kfree_skb: skbaddr=0xffff98168a333500 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x10f0 reason: QDISC_OVERLIMIT
         swapper       0 [001]   909.166055: skb:kfree_skb: skbaddr=0xffff98168280cee0 rx_sk=(nil) protocol=34525 location=cake_dequeue+0x5ef reason: QDISC_CONGESTED

Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
Acked-by: Dave Taht <dave.taht@gmail.com>
Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
Changes in v2:
- Make CONGESTED and OVERLIMIT qdisc-generic instead of specific to CAKE (Jakub)
- Link to v1: https://lore.kernel.org/r/20241209-cake-drop-reason-v1-1-19205f6d1f19@redhat.com
---
 include/net/dropreason-core.h | 18 ++++++++++++++++++
 net/sched/sch_cake.c          | 43 +++++++++++++++++++++++--------------------
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index c29282fabae6cdf9dd79f698b92b4b8f57156b1e..ead4170a1d0a9d3198876fabf453130bf11953be 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -58,6 +58,9 @@
 	FN(TC_EGRESS)			\
 	FN(SECURITY_HOOK)		\
 	FN(QDISC_DROP)			\
+	FN(QDISC_OVERLIMIT)		\
+	FN(QDISC_CONGESTED)		\
+	FN(CAKE_FLOOD)			\
 	FN(FQ_BAND_LIMIT)		\
 	FN(FQ_HORIZON_LIMIT)		\
 	FN(FQ_FLOW_LIMIT)		\
@@ -314,6 +317,21 @@ enum skb_drop_reason {
 	 * failed to enqueue to current qdisc)
 	 */
 	SKB_DROP_REASON_QDISC_DROP,
+	/**
+	 * @SKB_DROP_REASON_QDISC_OVERLIMIT: dropped by qdisc when a qdisc
+	 * instance exceeds its total buffer size limit.
+	 */
+	SKB_DROP_REASON_QDISC_OVERLIMIT,
+	/**
+	 * @SKB_DROP_REASON_QDISC_CONGESTED: dropped by a qdisc AQM algorithm
+	 * due to congestion.
+	 */
+	SKB_DROP_REASON_QDISC_CONGESTED,
+	/**
+	 * @SKB_DROP_REASON_CAKE_FLOOD: dropped by the flood protection part of
+	 * CAKE qdisc AQM algorithm (BLUE).
+	 */
+	SKB_DROP_REASON_CAKE_FLOOD,
 	/**
 	 * @SKB_DROP_REASON_FQ_BAND_LIMIT: dropped by fq qdisc when per band
 	 * limit is reached.
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 8d8b2db4653c0c9f271f9c1953e8c61175d8f76b..deb0925f536dda69469738e45e1dbf8ed59a6820 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -484,13 +484,14 @@ static bool cobalt_queue_empty(struct cobalt_vars *vars,
 /* Call this with a freshly dequeued packet for possible congestion marking.
  * Returns true as an instruction to drop the packet, false for delivery.
  */
-static bool cobalt_should_drop(struct cobalt_vars *vars,
-			       struct cobalt_params *p,
-			       ktime_t now,
-			       struct sk_buff *skb,
-			       u32 bulk_flows)
+static enum skb_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
+					       struct cobalt_params *p,
+					       ktime_t now,
+					       struct sk_buff *skb,
+					       u32 bulk_flows)
 {
-	bool next_due, over_target, drop = false;
+	enum skb_drop_reason reason = SKB_NOT_DROPPED_YET;
+	bool next_due, over_target;
 	ktime_t schedule;
 	u64 sojourn;
 
@@ -533,7 +534,8 @@ static bool cobalt_should_drop(struct cobalt_vars *vars,
 
 	if (next_due && vars->dropping) {
 		/* Use ECN mark if possible, otherwise drop */
-		drop = !(vars->ecn_marked = INET_ECN_set_ce(skb));
+		if (!(vars->ecn_marked = INET_ECN_set_ce(skb)))
+			reason = SKB_DROP_REASON_QDISC_CONGESTED;
 
 		vars->count++;
 		if (!vars->count)
@@ -556,16 +558,17 @@ static bool cobalt_should_drop(struct cobalt_vars *vars,
 	}
 
 	/* Simple BLUE implementation.  Lack of ECN is deliberate. */
-	if (vars->p_drop)
-		drop |= (get_random_u32() < vars->p_drop);
+	if (vars->p_drop && reason == SKB_NOT_DROPPED_YET &&
+	    get_random_u32() < vars->p_drop)
+		reason = SKB_DROP_REASON_CAKE_FLOOD;
 
 	/* Overload the drop_next field as an activity timeout */
 	if (!vars->count)
 		vars->drop_next = ktime_add_ns(now, p->interval);
-	else if (ktime_to_ns(schedule) > 0 && !drop)
+	else if (ktime_to_ns(schedule) > 0 && reason == SKB_NOT_DROPPED_YET)
 		vars->drop_next = now;
 
-	return drop;
+	return reason;
 }
 
 static bool cake_update_flowkeys(struct flow_keys *keys,
@@ -1528,12 +1531,11 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 
 	flow->dropped++;
 	b->tin_dropped++;
-	sch->qstats.drops++;
 
 	if (q->rate_flags & CAKE_FLAG_INGRESS)
 		cake_advance_shaper(q, b, skb, now, true);
 
-	__qdisc_drop(skb, to_free);
+	qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_QDISC_OVERLIMIT);
 	sch->q.qlen--;
 	qdisc_tree_reduce_backlog(sch, 1, len);
 
@@ -1926,7 +1928,7 @@ static void cake_clear_tin(struct Qdisc *sch, u16 tin)
 	q->cur_tin = tin;
 	for (q->cur_flow = 0; q->cur_flow < CAKE_QUEUES; q->cur_flow++)
 		while (!!(skb = cake_dequeue_one(sch)))
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_QUEUE_PURGE);
 }
 
 static struct sk_buff *cake_dequeue(struct Qdisc *sch)
@@ -1934,6 +1936,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct cake_tin_data *b = &q->tins[q->cur_tin];
 	struct cake_host *srchost, *dsthost;
+	enum skb_drop_reason reason;
 	ktime_t now = ktime_get();
 	struct cake_flow *flow;
 	struct list_head *head;
@@ -2143,12 +2146,12 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 			goto begin;
 		}
 
+		reason = cobalt_should_drop(&flow->cvars, &b->cparams, now, skb,
+					    (b->bulk_flow_count *
+					     !!(q->rate_flags &
+						CAKE_FLAG_INGRESS)));
 		/* Last packet in queue may be marked, shouldn't be dropped */
-		if (!cobalt_should_drop(&flow->cvars, &b->cparams, now, skb,
-					(b->bulk_flow_count *
-					 !!(q->rate_flags &
-					    CAKE_FLAG_INGRESS))) ||
-		    !flow->head)
+		if (reason == SKB_NOT_DROPPED_YET || !flow->head)
 			break;
 
 		/* drop this packet, get another one */
@@ -2162,7 +2165,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 		b->tin_dropped++;
 		qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
 		qdisc_qstats_drop(sch);
-		kfree_skb(skb);
+		kfree_skb_reason(skb, reason);
 		if (q->rate_flags & CAKE_FLAG_INGRESS)
 			goto retry;
 	}

---
base-commit: 7ea2745766d776866cfbc981b21ed3cfdf50124e
change-id: 20241205-cake-drop-reason-b1661e1e7f0a



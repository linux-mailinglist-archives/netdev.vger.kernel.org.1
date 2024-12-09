Return-Path: <netdev+bounces-150155-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA43D9E933A
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 13:03:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A4F8F1886D82
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 12:03:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CD1C21CFF0;
	Mon,  9 Dec 2024 12:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F4Muoyrl"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94206215704
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 12:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733745755; cv=none; b=Tw5haDZgCBHAFVmPmCgC6iBrX0YASpUj4vZnVFFljzAUNtjiJ9UsuFN7vaZSDaWxPBNrHff5iqzqS1qmeKGs7heMMzZzx4mLbygC/qfoBpvTuDLQkzeeJs68uHqP57kmreay0akkSo4aj6ljBZ0AhKZB5V2gig2kiWwOWmyHkog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733745755; c=relaxed/simple;
	bh=+Tjthp6EPaPFXc9emXZp2juJ+hOCTF5QeUcjMpXhC2c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=oSXi1737v86wH6j3WQgdpt0TGJXgQL1+9ZHwE88h5xpqOHfdkJ1rfT++u5PNSJt4jo6iKgu8iFKRBK0NpF1t1nk7jP2oKwdRCnqL/q5qVG0rnEgINw24McsF0fi6igunmCnHmtG8GtZFEHGw13bI8IGuea1Wy5W8S5b25ioVYeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=F4Muoyrl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1733745752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=JPu8ZtYEfgI3Se0DLhvDy3kRU1s9r+TbI1u0L6lWYgs=;
	b=F4Muoyrlj9U6Hz/NAHK9fv9QSb/pOMf+GZBvo4R0tV4m0M1j0/MkUHy8Oy6AzLTsLbc035
	NjJW3LQb0Pwkr/rHRSJ3AWcwAoxhWtHTTwxzoPLLRW5DyFpPrs9pFFDnSMas+cnvA/cPVo
	by5Dyy58aquPrF7JtEtAs20b7QcdDVs=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-giGYTihCO2aYLWa6-_zoog-1; Mon, 09 Dec 2024 07:02:31 -0500
X-MC-Unique: giGYTihCO2aYLWa6-_zoog-1
X-Mimecast-MFC-AGG-ID: giGYTihCO2aYLWa6-_zoog
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-53e1ee761d7so2547264e87.1
        for <netdev@vger.kernel.org>; Mon, 09 Dec 2024 04:02:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733745749; x=1734350549;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JPu8ZtYEfgI3Se0DLhvDy3kRU1s9r+TbI1u0L6lWYgs=;
        b=QLsjnvjLCx6HIdMMJkDHwOOjTKEEbnqQxblNvlgJYnZlLEdSORJ76c7p4fgzjWYh12
         lLZW79Yv3/R793ELUaXsI8AZPzdsV3lQslN832juuoXmM4GNmuN8p/Rci6hMKNou1qBt
         BUmKsVXguXmzwCKhVNxjpgDt5oIKUCm50ReUFfMewoS6KQ55rta4MUaFfwGAR95Rwc0j
         Xx+DPf9+BNTJ5o4VWG8JOTek79tJP0/ul/XYc/q5JutV7vIzac1PiheuikM6QnyGyvTH
         iR234X4x3e5SzVeXUaLt8A2j2lxZRVbH+zoX6Sk3+MLOKnFdIKmyXLuSzLiRAhj2t6Vo
         fR1g==
X-Gm-Message-State: AOJu0YxEqOE5DEwObVfmzlnSCV2ja0yfcKngvvB0c1d07XzNeAxaD23v
	0aMpqKS7cX59ezin8x/dscb0qN5oZ4c5BxTmdcwhAzXrdBYioJPWx8a0HvITVD1UHGjXT9g1kCI
	MG7m1o/MepTJfIFSsroznCjSV2jMZfyEJwnpcV9WIXKUuJ0aQ/TWVkw==
X-Gm-Gg: ASbGnctlRM2O7JwGntl5iwGalTAkFYcAvit+OG2/G3KD6K1a2y7zjOz95Fpd6uNbh2u
	KnneMmrg68d1gm2zrn9LJqFlHk5gkRXx4TlE009ZzgS4R7gnBTB7S4DBxFO2dt0sFjCqk+ETw//
	IHAZS3fADEXznrzASfPls8oFlDDzI9+T6eic3Yt6LxmaOL2Z22dXGxXCXHYTQ/4hTwgDRgwxg/P
	9oZKwOOPxw2CtzmCXgWCoTU7vRb57DbrsCUtn7xhUJYiPI=
X-Received: by 2002:a05:6512:ea0:b0:540:2092:934 with SMTP id 2adb3069b0e04-540240cd264mr78001e87.25.1733745749450;
        Mon, 09 Dec 2024 04:02:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEd61V5p5PPbm/o4+Q38Yd6j/OzvYQPs0saaosW2vQYet0+4SNgjqO4ZW8KL7C2ceBMqjbHpw==
X-Received: by 2002:a05:6512:ea0:b0:540:2092:934 with SMTP id 2adb3069b0e04-540240cd264mr77980e87.25.1733745748949;
        Mon, 09 Dec 2024 04:02:28 -0800 (PST)
Received: from alrua-x1.borgediget.toke.dk ([2a0c:4d80:42:443::2])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aa67cd1e82bsm217712766b.53.2024.12.09.04.02.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Dec 2024 04:02:28 -0800 (PST)
Received: by alrua-x1.borgediget.toke.dk (Postfix, from userid 1000)
	id 2878B16BD8D7; Mon, 09 Dec 2024 13:02:27 +0100 (CET)
From: =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
Date: Mon, 09 Dec 2024 13:02:18 +0100
Subject: [PATCH net-next] net_sched: sch_cake: Add drop reasons
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241209-cake-drop-reason-v1-1-19205f6d1f19@redhat.com>
X-B4-Tracking: v=1; b=H4sIAEncVmcC/x3MQQqDQAxG4atI1gYmQ7XgVUoXU/21QchIRkQQ7
 96hy2/x3kUFrig0NBc5Di2arULahsZvsgWsUzXFEB8SQ8djWsGT540dqWTjj/S9QPCcQ6KabY5
 Zz//yRYadDedO7/v+ATTKwslsAAAA
X-Change-ID: 20241205-cake-drop-reason-b1661e1e7f0a
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, 
 Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
 Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, cake@lists.bufferbloat.net, 
 =?utf-8?q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>
X-Mailer: b4 0.14.2

Add three qdisc-specific drop reasons for sch_cake:

 1) SKB_DROP_REASON_CAKE_CONGESTED
    Whenever a packet is dropped by the CAKE AQM algorithm because
    congestion is detected.

 2) SKB_DROP_REASON_CAKE_FLOOD
    Whenever a packet is dropped by the flood protection part of the
    CAKE AQM algorithm (BLUE).

 3) SKB_DROP_REASON_CAKE_OVERLIMIT
    Whenever the total queue limit for a CAKE instance is exceeded and a
    packet is dropped to make room.

Also use the existing SKB_DROP_REASON_QUEUE_PURGE in cake_clear_tin().

Reasons show up as:

perf record -a -e skb:kfree_skb sleep 1; perf script

          iperf3     665 [005]   848.656964: skb:kfree_skb: skbaddr=0xffff98168a333500 rx_sk=(nil) protocol=34525 location=__dev_queue_xmit+0x10f0 reason: CAKE_OVERLIMIT
         swapper       0 [001]   909.166055: skb:kfree_skb: skbaddr=0xffff98168280cee0 rx_sk=(nil) protocol=34525 location=cake_dequeue+0x5ef reason: CAKE_CONGESTED

Signed-off-by: Toke Høiland-Jørgensen <toke@redhat.com>
---
 include/net/dropreason-core.h | 18 ++++++++++++++++++
 net/sched/sch_cake.c          | 43 +++++++++++++++++++++++--------------------
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/include/net/dropreason-core.h b/include/net/dropreason-core.h
index c29282fabae6cdf9dd79f698b92b4b8f57156b1e..a9be76be11ad67d6cc7175f1a643314a7dcdf0b8 100644
--- a/include/net/dropreason-core.h
+++ b/include/net/dropreason-core.h
@@ -61,6 +61,9 @@
 	FN(FQ_BAND_LIMIT)		\
 	FN(FQ_HORIZON_LIMIT)		\
 	FN(FQ_FLOW_LIMIT)		\
+	FN(CAKE_CONGESTED)		\
+	FN(CAKE_FLOOD)			\
+	FN(CAKE_OVERLIMIT)		\
 	FN(CPU_BACKLOG)			\
 	FN(XDP)				\
 	FN(TC_INGRESS)			\
@@ -329,6 +332,21 @@ enum skb_drop_reason {
 	 * exceeds its limits.
 	 */
 	SKB_DROP_REASON_FQ_FLOW_LIMIT,
+	/**
+	 * @SKB_DROP_REASON_CAKE_CONGESTED: dropped by the CAKE qdisc AQM
+	 * algorithm due to congestion.
+	 */
+	SKB_DROP_REASON_CAKE_CONGESTED,
+	/**
+	 * @SKB_DROP_REASON_CAKE_FLOOD: dropped by the flood protection part of
+	 * CAKE qdisc AQM algorithm (BLUE).
+	 */
+	SKB_DROP_REASON_CAKE_FLOOD,
+	/**
+	 * @SKB_DROP_REASON_CAKE_OVERLIMIT: dropped by CAKE qdisc when a qdisc
+	 * instance exceeds its total buffer size limit.
+	 */
+	SKB_DROP_REASON_CAKE_OVERLIMIT,
 	/**
 	 * @SKB_DROP_REASON_CPU_BACKLOG: failed to enqueue the skb to the per CPU
 	 * backlog queue. This can be caused by backlog queue full (see
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 8d8b2db4653c0c9f271f9c1953e8c61175d8f76b..a57bdc771dd14e81fb0cdf54ca7890ac96f1e311 100644
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
+			reason = SKB_DROP_REASON_CAKE_CONGESTED;
 
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
+	qdisc_drop_reason(skb, sch, to_free, SKB_DROP_REASON_CAKE_OVERLIMIT);
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



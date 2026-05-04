Return-Path: <netdev+bounces-283961-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KPVALpnL+Gma0wIAu9opvQ
	(envelope-from <netdev+bounces-283961-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:38:49 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D1F54C1822
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 18:38:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7F59301DCCC
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 16:38:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF7BD3E0233;
	Mon,  4 May 2026 16:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ed7Jkl6W"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411341F03D9
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 16:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777912726; cv=none; b=XEWA9KA1cyzJ2cU2NOejLy+ypTa2NQ1slaIXtyR+Qx5z3clDenNAnPH3AomKbVYEYpKSjJras0wciGK4qiff9sLl4HM3IvSw7CX17CkSv8Tk6U2x+DIoBpINqE3xbyuTahboZDkVPTjaOMRAEQUmS/buZhVihFP1thZ8cg70idw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777912726; c=relaxed/simple;
	bh=3C99ZLZZUqG6c8FtmHDD90iMzYM2Dvi3n5b2M4YEai8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fXBWIMq9Q0d8wxIoVNHT//o2X7aocNXe4sr8E0QxDyL1Zo/obnubrg8g+mmdD+VCJL6fpsXLhK1kZg+L03AVEaXE3g7kd5ZWi0t0DcQ5v4lZwzohLlj2PGoNpKOXq4eMbHIAuVlmz+BETxYO8PDgR/fCjQxS9R6e8ao780aBnkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ed7Jkl6W; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50fb3c7b989so77670151cf.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 09:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777912724; x=1778517524; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=bk80l6edGoUwGPJNqKMwPGOCrXR0XoXWsECJpOvwTpY=;
        b=Ed7Jkl6W9cH6+arOPHmjPWsdQkmMoKXSjNjMLTg7WByqmS1MdUQ22OUgohzDCOXn0F
         aprz+Re0ukvzuhvynSFUkUkk3RG1I9bk6cn0Eb5aAHiEpKUID944AKbl7uF5g/7HxBE3
         y8hN7/bu61WYe4a7P92pZCTU9TaDqdpnJu3ShqX3/2TohiM1AWxSr/ESEh5j5t72+xYB
         z5a9CIWzvAsGg49sSS5VdxcJIW8Fn/lXBSEmOeTN565BerKdiOIImfknCGjqOPLVd1B7
         WbB7CNlTdvtlrexEprF591hgdkXs9SGQI4RjCRgDrJbOAsE4Uafy4jlGzSWtPQLLwuqf
         LIyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777912724; x=1778517524;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bk80l6edGoUwGPJNqKMwPGOCrXR0XoXWsECJpOvwTpY=;
        b=OQhDlmU95jmuV7V5wZIxbboA7Qch3cMzj64tpTTh6D/LDh74PIxyzDdeYplFLXNKxl
         UvHTr2TW+qtOL4m3CkoPaS/Xdgj+AjGR6tWdN66HWKNSmrsLJlHTomwHP6qq9T3UGUIE
         ZsuPn7ZXLVCff+D44sON3LEMhrc4Vpoodp350kGus/8Auu7bg0CBAj91KZ2MA5WQob5O
         wfULgcmSfdLR3E/HZxVUk4R2oXamMyOqYQHrk8uRzDLJ3nkDSwN4NgYXwQ8rjcT8dno5
         1l9kVmjG6hi4BNuvslHpXenmkwi/a3KumaVXb4rOuMzZhnqRxjrT2Qk+uSOxcAIp/vL9
         YlRg==
X-Forwarded-Encrypted: i=1; AFNElJ+v+ZDYjSSY+/SKEbDQztGL7Xf+fksBd4Oi213+YDvypuFmg+JDe0SFcepdcSk1eouj8ox8H/0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXCMuEdLO0UnP9ab2tjEY6uMXzdkah1O0gpsAEz4ss7EsVOGUp
	r9sgoh/AhIpuHIn2m8qeoYfENkwTDM6GtoIjDOIAeLQ/GBkUfFbAsKyGfMNm2xz+vu4IBd9ZjGx
	Gx0qSS5VN+LvykA==
X-Received: from qtjc8.prod.google.com ([2002:ac8:1108:0:b0:50e:7849:3dae])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:18a9:b0:510:1543:31eb with SMTP id d75a77b69052e-5104bfa4ee3mr156822561cf.53.1777912723967;
 Mon, 04 May 2026 09:38:43 -0700 (PDT)
Date: Mon,  4 May 2026 16:38:42 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504163842.1162001-1-edumazet@google.com>
Subject: [PATCH v2 net] net/sched: sch_fq_codel: annotate data-races from fq_codel_dump_class_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 1D1F54C1822
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283961-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

fq_codel_dump_class_stats() acquires qdisc spinlock only when requested
to follow flow->head chain.

As we did in sch_cake recently, add the missing READ_ONCE()/WRITE_ONCE()
annotations.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
v2: added WRITE_ONCE(flow->cvars.count, flow->cvars.count + i);

 net/sched/sch_fq_codel.c | 39 ++++++++++++++++++++-------------------
 1 file changed, 20 insertions(+), 19 deletions(-)

diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 0664b2f2d6f28041e5250a44fc92311116ae0cf1..24db54684e8a5997b075e0f4072f49779ae45abb 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -117,7 +117,7 @@ static inline struct sk_buff *dequeue_head(struct fq_codel_flow *flow)
 {
 	struct sk_buff *skb = flow->head;
 
-	flow->head = skb->next;
+	WRITE_ONCE(flow->head, skb->next);
 	skb_mark_not_on_list(skb);
 	return skb;
 }
@@ -127,7 +127,7 @@ static inline void flow_queue_add(struct fq_codel_flow *flow,
 				  struct sk_buff *skb)
 {
 	if (flow->head == NULL)
-		flow->head = skb;
+		WRITE_ONCE(flow->head, skb);
 	else
 		flow->tail->next = skb;
 	flow->tail = skb;
@@ -173,8 +173,8 @@ static unsigned int fq_codel_drop(struct Qdisc *sch, unsigned int max_packets,
 	} while (++i < max_packets && len < threshold);
 
 	/* Tell codel to increase its signal strength also */
-	flow->cvars.count += i;
-	q->backlogs[idx] -= len;
+	WRITE_ONCE(flow->cvars.count, flow->cvars.count + i);
+	WRITE_ONCE(q->backlogs[idx], q->backlogs[idx] - len);
 	q->memory_usage -= mem;
 	sch->qstats.drops += i;
 	sch->qstats.backlog -= len;
@@ -204,13 +204,13 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	codel_set_enqueue_time(skb);
 	flow = &q->flows[idx];
 	flow_queue_add(flow, skb);
-	q->backlogs[idx] += qdisc_pkt_len(skb);
+	WRITE_ONCE(q->backlogs[idx], q->backlogs[idx] + qdisc_pkt_len(skb));
 	qdisc_qstats_backlog_inc(sch, skb);
 
 	if (list_empty(&flow->flowchain)) {
 		list_add_tail(&flow->flowchain, &q->new_flows);
 		q->new_flow_count++;
-		flow->deficit = q->quantum;
+		WRITE_ONCE(flow->deficit, q->quantum);
 	}
 	get_codel_cb(skb)->mem_usage = skb->truesize;
 	q->memory_usage += get_codel_cb(skb)->mem_usage;
@@ -263,7 +263,8 @@ static struct sk_buff *dequeue_func(struct codel_vars *vars, void *ctx)
 	flow = container_of(vars, struct fq_codel_flow, cvars);
 	if (flow->head) {
 		skb = dequeue_head(flow);
-		q->backlogs[flow - q->flows] -= qdisc_pkt_len(skb);
+		WRITE_ONCE(q->backlogs[flow - q->flows],
+			   q->backlogs[flow - q->flows] - qdisc_pkt_len(skb));
 		q->memory_usage -= get_codel_cb(skb)->mem_usage;
 		sch->q.qlen--;
 		sch->qstats.backlog -= qdisc_pkt_len(skb);
@@ -296,7 +297,7 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc *sch)
 	flow = list_first_entry(head, struct fq_codel_flow, flowchain);
 
 	if (flow->deficit <= 0) {
-		flow->deficit += q->quantum;
+		WRITE_ONCE(flow->deficit, flow->deficit + q->quantum);
 		list_move_tail(&flow->flowchain, &q->old_flows);
 		goto begin;
 	}
@@ -314,7 +315,7 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc *sch)
 		goto begin;
 	}
 	qdisc_bstats_update(sch, skb);
-	flow->deficit -= qdisc_pkt_len(skb);
+	WRITE_ONCE(flow->deficit, flow->deficit - qdisc_pkt_len(skb));
 
 	if (q->cstats.drop_count) {
 		qdisc_tree_reduce_backlog(sch, q->cstats.drop_count,
@@ -328,7 +329,7 @@ static struct sk_buff *fq_codel_dequeue(struct Qdisc *sch)
 static void fq_codel_flow_purge(struct fq_codel_flow *flow)
 {
 	rtnl_kfree_skbs(flow->head, flow->tail);
-	flow->head = NULL;
+	WRITE_ONCE(flow->head, NULL);
 }
 
 static void fq_codel_reset(struct Qdisc *sch)
@@ -656,21 +657,21 @@ static int fq_codel_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 
 		memset(&xstats, 0, sizeof(xstats));
 		xstats.type = TCA_FQ_CODEL_XSTATS_CLASS;
-		xstats.class_stats.deficit = flow->deficit;
+		xstats.class_stats.deficit = READ_ONCE(flow->deficit);
 		xstats.class_stats.ldelay =
-			codel_time_to_us(flow->cvars.ldelay);
-		xstats.class_stats.count = flow->cvars.count;
-		xstats.class_stats.lastcount = flow->cvars.lastcount;
-		xstats.class_stats.dropping = flow->cvars.dropping;
-		if (flow->cvars.dropping) {
-			codel_tdiff_t delta = flow->cvars.drop_next -
+			codel_time_to_us(READ_ONCE(flow->cvars.ldelay));
+		xstats.class_stats.count = READ_ONCE(flow->cvars.count);
+		xstats.class_stats.lastcount = READ_ONCE(flow->cvars.lastcount);
+		xstats.class_stats.dropping = READ_ONCE(flow->cvars.dropping);
+		if (xstats.class_stats.dropping) {
+			codel_tdiff_t delta = READ_ONCE(flow->cvars.drop_next) -
 					      codel_get_time();
 
 			xstats.class_stats.drop_next = (delta >= 0) ?
 				codel_time_to_us(delta) :
 				-codel_time_to_us(-delta);
 		}
-		if (flow->head) {
+		if (READ_ONCE(flow->head)) {
 			sch_tree_lock(sch);
 			skb = flow->head;
 			while (skb) {
@@ -679,7 +680,7 @@ static int fq_codel_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 			}
 			sch_tree_unlock(sch);
 		}
-		qs.backlog = q->backlogs[idx];
+		qs.backlog = READ_ONCE(q->backlogs[idx]);
 		qs.drops = 0;
 	}
 	if (gnet_stats_copy_queue(d, NULL, &qs, qs.qlen) < 0)
-- 
2.54.0.545.g6539524ca2-goog



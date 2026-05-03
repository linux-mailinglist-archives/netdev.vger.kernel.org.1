Return-Path: <netdev+bounces-283644-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wGslMcd/92lsiQIAu9opvQ
	(envelope-from <netdev+bounces-283644-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 19:03:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 435564B6B9B
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 19:03:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CBDBB3003426
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 17:03:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD681E1024;
	Sun,  3 May 2026 17:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="NW2bsfqs"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631DE5474F
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 17:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777827780; cv=none; b=IrnLKlRhD5TT4LKZp9WaiaAYCdGP1UgoUg449gXEMP0OHlv03vDuJUElwXohUjwD9MSJOXYbs3/3h5j2wCjvi+/9hqSmhU2d5rm1kiZPZ4CVpyILzWaJj+BlHJlzphsGN7D681rBD/Rqvos1y1zSyd2dqYCfqK5ITQgbmE8wZSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777827780; c=relaxed/simple;
	bh=aenn5BDHAQoXLnotUzXQvERM7+FKJl27QLr4NagtSIs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PtNl3P/dIci+qKxm49a2y/gINm3iqNBwU+pcLd3XKEXZCmgRhYmQdSl52MGEFF2Dcvqj/bZ+6kgFnGo7IdBOvkxFMtjtoqXpsakpSth0WOzVNxH5AbB11Yo7tVGxF36WX25l2EnAhVY9hWVjH2rfanPZcfNTDsnaf+90MLhrKE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=NW2bsfqs; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-7bd8cb261c3so4143117b3.1
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 10:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777827778; x=1778432578; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=X547XFg39eEq/Pg370jmyAlzkzhyFMrJOaU/seHyAlU=;
        b=NW2bsfqsbP6ywjJnxCAPBrfJbj38nr1XMDWJ6zByVGqWCDv6tOibiOHkJp/zWrbdu9
         o4xVh13wsU6fI6P5y8y/UfuMFnpZymXcfKxImLD4jpoqXyPfDxfmERXboQyS9/oeRFhk
         eLMJ3zYFhR0IwNuo3mEcnYWEpTMittWrcfm0Mixo5ItXbK2y5jp58Gh+0Lu823aAige8
         H9ajM/P9mFPX/XgrRPJYKFjeH1eYdFLOyrsawurLlpxDjpmSmE3Vrj/5LuzzRfy/+PGt
         OgWe7lV7D7HKURu5YaOCpgQzTMH4v/grjX7RLZSxx4eSCKjFyYII0TanZipYwUznVcdV
         lfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777827778; x=1778432578;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X547XFg39eEq/Pg370jmyAlzkzhyFMrJOaU/seHyAlU=;
        b=jmjp03dBTY4nbM7iQPr8j49bDIZWSfnrj2cqeUcHUQl4n5f36Xgjj9xlMBUJGa+MpI
         4ufbpNO64nAE5+W+C6zky/Zplh/bMifyuiOKOlSKuVY+/9o72EqL3mRRyWRHZTXbv285
         2zOXS5Gw5+4ggMGM7T9kybb1Z2IaOdVJvkiteXM4mFoNDUU9xW6fVrVRpkqAHsrrbHWE
         6CZjB6Jq8NsGwErC8TRSP6sjJ6rFi7DGM7RvyTGWfr/wuZLo5xg0gm5e29ZHdB39UAe7
         vMbkeprCjcgyx9hff13EsXoqXbJLVWoEPvusTfCZIWkR1RCZF06xu36I4WVbd+Fb73BF
         g0mQ==
X-Forwarded-Encrypted: i=1; AFNElJ8qDf6DMmMkpFJMiOvvel5wXkezv0bkAQC1+Inoh0XqnBx1w3BnDCxce8KrrXoqSyNtnvivfOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEMb83R7NkbIZeYPy8VX7hYqs+PLtSmgQ/WzCbMPtDRwpdlVq2
	GWVJiqmXi7J0pN13szQyarwDEPGONWI3+mzeIx6z5EJ0M4/h6nREjMdbY5kZa5uCEX5RtUlOc+Q
	taxOUeaynfGNHOg==
X-Received: from ywad2.prod.google.com ([2002:a05:690c:a742:b0:79d:5f40:6504])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:92:b0:7b4:3d82:bf0 with SMTP id 00721157ae682-7bd76f9f2e9mr69098157b3.11.1777827778078;
 Sun, 03 May 2026 10:02:58 -0700 (PDT)
Date: Sun,  3 May 2026 17:02:57 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260503170257.2782962-1-edumazet@google.com>
Subject: [PATCH net] net/sched: sch_fq_codel: annotate data-races from fq_codel_dump_class_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 435564B6B9B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283644-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

fq_codel_dump_class_stats() acquires qdisc spinlock only when requested
to follow flow->head chain.

As we did in sch_cake recently, add the missing READ_ONCE()/WRITE_ONCE()
annotations.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq_codel.c | 37 +++++++++++++++++++------------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 0664b2f2d6f28041e5250a44fc92311116ae0cf1..f52198ea849b0cc966b455905a62d6c413441260 100644
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
@@ -174,7 +174,7 @@ static unsigned int fq_codel_drop(struct Qdisc *sch, unsigned int max_packets,
 
 	/* Tell codel to increase its signal strength also */
 	flow->cvars.count += i;
-	q->backlogs[idx] -= len;
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



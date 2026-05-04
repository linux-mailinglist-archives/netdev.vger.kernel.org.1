Return-Path: <netdev+bounces-283705-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iD3IHAc1+GmxrQIAu9opvQ
	(envelope-from <netdev+bounces-283705-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 07:56:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D30734B8B72
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 07:56:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8FC6B3008234
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 05:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED2562797AC;
	Mon,  4 May 2026 05:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lXCou6SR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478212874E1
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 05:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777874161; cv=none; b=UV+XBZ3TBXMMgTOwiAc3+a6/Zh4FFJIwEO+1MiMZVjNJ8tV75PIVXMmZ9Do/IP+CY1DLmHx90PMDV3mdexqVFCr50uJN7zjjQchLI3fm+RpU1te272368I1z+nfqNGQlGHR5e+ViZguwoq/LzwrvR8VEp+upbXlmfzrMgMoEqZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777874161; c=relaxed/simple;
	bh=XxUkJoC4qkniet9rm8IFPmA1zychifHtUTOvXXU+dk4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=Oy9JXmsxRt2H6nPnIRHKckrR19Y4ZaqRwa4mmJpbRjR57Ec31r5gZNvLXpQjHWsskk0AUMDlkKyV6T7NASUZAsqutlThQ9rq946sS9XqV82c6PON/m59yF3oqmhf+EXP2Xd2sn6XTY0VcxPTf4fGZv+rftA7IL4ZblXSrx02ebs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=lXCou6SR; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8ed2c173d3bso764915185a.2
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 22:56:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777874159; x=1778478959; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Mo2OYmTF1lOKjLCZCEGRf/gC8F2l3tZ5x0FMurlXEeg=;
        b=lXCou6SRILfKVGnse+ybjGfJDOhEPwAOUQXfbn52/wMI/TxublSdzkOoAPrtRoyEmm
         BnJDBUcOpVlznI6MNaQqLx4ddCUhCH4/uoeWo49E6FtT2tQ8z5iq0KmCtAzPqaIAsVwH
         DwSFDtOuBkzUYWM1QGMmP6rH6YCeXTCssB6KjHO/VEMLKr2q26SZw7JvY1YyqU/bxatY
         97NTGXc249EUD7dg+Z+Ffkq7hTO/4Qo5xq+v0OHYLT1xRDr1TlVLNh/LuuG866DByU6g
         qHH87PgchD9Mj5LKFR+BuP3Nkom4A3CyN1tNNEXFOIHMDVcNbJntCnWk300LQoHUTH16
         ZQWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777874159; x=1778478959;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Mo2OYmTF1lOKjLCZCEGRf/gC8F2l3tZ5x0FMurlXEeg=;
        b=Far02mumQUl9hAijkobHjneRLThAmWTfuHZlfUmkDFa3/vSx1I4bKtu6rQyCWkxv4z
         xQhiEtQuSw/obDyU8BUFj9xqgRAtxJUbMsGnHWVoxrpZszhnEtGIhmBcB2UtgcOtatZS
         the4WSpA6EDiNy0w5d7O+8FKracu+QogmeJ4J9pIhnEEJl8HoNJYE2Jz0avCzGilLaEA
         n0Qr8rrXxQeEq5RZQ6wP8Li+Rmuu2sN80CXJukR26uoB6dOrZkKon56KH+ty8sPcPSBD
         KrSl+vC+5HR7Yac/t5LHmfYt3jbog3i8JNbeqIwKPjV1RbxNDkxB4LxDhNo1Lw+DoiqS
         JaGA==
X-Forwarded-Encrypted: i=1; AFNElJ+1tkeUQgJ4D6A0K4Z2Fx8xfutRbwQDXLafjtETojMgg2ikFNDgWRFvDuqDD18joigruQzOYAI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yym+5DQqLAVQ86popewMsdGUkSDoLsSxtBbm2OjqsWr68l3LHPN
	Hm4FV6Oy/oWow446L3XEoA+7mLKj81IwxrX613Fpf6RSNrQoBAcwsMFxflXvCfoWs9RLovNRLB+
	oBYrqd/Zmaj2NuQ==
X-Received: from qknpa30.prod.google.com ([2002:a05:620a:831e:b0:8ee:421f:675d])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:c54:b0:8fb:186c:7e8a with SMTP id af79cd13be357-8fd15bd8998mr1315695385a.13.1777874158909;
 Sun, 03 May 2026 22:55:58 -0700 (PDT)
Date: Mon,  4 May 2026 05:55:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260504055558.3470994-1-edumazet@google.com>
Subject: [PATCH net] net/sched: sch_sfq: annotate data-races from sfq_dump_class_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: D30734B8B72
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
	TAGGED_FROM(0.00)[bounces-283705-lists,netdev=lfdr.de];
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

sfq_dump_class_stats() runs locklessly, add needed READ_ONCE()
and WRITE_ONCE() annotations.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_sfq.c | 48 +++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index c3f3181dba5424eb9d26362a1628653bb9392e89..bf55e3d71ef4da24eaa5a73444c14d809268ef54 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -225,7 +225,8 @@ static inline void sfq_dec(struct sfq_sched_data *q, sfq_index x)
 
 	sfq_unlink(q, x, n, p);
 
-	d = q->slots[x].qlen--;
+	d = q->slots[x].qlen - 1;
+	WRITE_ONCE(q->slots[x].qlen, d);
 	if (n == p && q->cur_depth == d)
 		q->cur_depth--;
 	sfq_link(q, x);
@@ -238,7 +239,8 @@ static inline void sfq_inc(struct sfq_sched_data *q, sfq_index x)
 
 	sfq_unlink(q, x, n, p);
 
-	d = ++q->slots[x].qlen;
+	d = q->slots[x].qlen + 1;
+	WRITE_ONCE(q->slots[x].qlen, d);
 	if (q->cur_depth < d)
 		q->cur_depth = d;
 	sfq_link(q, x);
@@ -298,7 +300,7 @@ static unsigned int sfq_drop(struct Qdisc *sch, struct sk_buff **to_free)
 drop:
 		skb = q->headdrop ? slot_dequeue_head(slot) : slot_dequeue_tail(slot);
 		len = qdisc_pkt_len(skb);
-		slot->backlog -= len;
+		WRITE_ONCE(slot->backlog, slot->backlog - len);
 		sfq_dec(q, x);
 		sch->q.qlen--;
 		qdisc_qstats_backlog_dec(sch, skb);
@@ -314,7 +316,7 @@ static unsigned int sfq_drop(struct Qdisc *sch, struct sk_buff **to_free)
 			q->tail = NULL; /* no more active slots */
 		else
 			q->tail->next = slot->next;
-		q->ht[slot->hash] = SFQ_EMPTY_SLOT;
+		WRITE_ONCE(q->ht[slot->hash], SFQ_EMPTY_SLOT);
 		goto drop;
 	}
 
@@ -364,10 +366,10 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		x = q->dep[0].next; /* get a free slot */
 		if (x >= SFQ_MAX_FLOWS)
 			return qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_MAXFLOWS);
-		q->ht[hash] = x;
+		WRITE_ONCE(q->ht[hash], x);
 		slot = &q->slots[x];
 		slot->hash = hash;
-		slot->backlog = 0; /* should already be 0 anyway... */
+		WRITE_ONCE(slot->backlog, 0); /* should already be 0 anyway... */
 		red_set_vars(&slot->vars);
 		goto enqueue;
 	}
@@ -426,7 +428,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		head = slot_dequeue_head(slot);
 		delta = qdisc_pkt_len(head) - qdisc_pkt_len(skb);
 		sch->qstats.backlog -= delta;
-		slot->backlog -= delta;
+		WRITE_ONCE(slot->backlog, slot->backlog - delta);
 		qdisc_drop_reason(head, sch, to_free, QDISC_DROP_FLOW_LIMIT);
 
 		slot_queue_add(slot, skb);
@@ -436,7 +438,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 
 enqueue:
 	qdisc_qstats_backlog_inc(sch, skb);
-	slot->backlog += qdisc_pkt_len(skb);
+	WRITE_ONCE(slot->backlog, slot->backlog + qdisc_pkt_len(skb));
 	slot_queue_add(slot, skb);
 	sfq_inc(q, x);
 	if (slot->qlen == 1) {		/* The flow is new */
@@ -452,7 +454,7 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		 */
 		q->tail = slot;
 		/* We could use a bigger initial quantum for new flows */
-		slot->allot = q->quantum;
+		WRITE_ONCE(slot->allot, q->quantum);
 	}
 	if (++sch->q.qlen <= q->limit)
 		return NET_XMIT_SUCCESS;
@@ -489,7 +491,7 @@ sfq_dequeue(struct Qdisc *sch)
 	slot = &q->slots[a];
 	if (slot->allot <= 0) {
 		q->tail = slot;
-		slot->allot += q->quantum;
+		WRITE_ONCE(slot->allot, slot->allot + q->quantum);
 		goto next_slot;
 	}
 	skb = slot_dequeue_head(slot);
@@ -497,10 +499,10 @@ sfq_dequeue(struct Qdisc *sch)
 	qdisc_bstats_update(sch, skb);
 	sch->q.qlen--;
 	qdisc_qstats_backlog_dec(sch, skb);
-	slot->backlog -= qdisc_pkt_len(skb);
+	WRITE_ONCE(slot->backlog, slot->backlog - qdisc_pkt_len(skb));
 	/* Is the slot empty? */
 	if (slot->qlen == 0) {
-		q->ht[slot->hash] = SFQ_EMPTY_SLOT;
+		WRITE_ONCE(q->ht[slot->hash], SFQ_EMPTY_SLOT);
 		next_a = slot->next;
 		if (a == next_a) {
 			q->tail = NULL; /* no more active slots */
@@ -508,7 +510,7 @@ sfq_dequeue(struct Qdisc *sch)
 		}
 		q->tail->next = next_a;
 	} else {
-		slot->allot -= qdisc_pkt_len(skb);
+		WRITE_ONCE(slot->allot, slot->allot - qdisc_pkt_len(skb));
 	}
 	return skb;
 }
@@ -549,9 +551,9 @@ static void sfq_rehash(struct Qdisc *sch)
 			sfq_dec(q, i);
 			__skb_queue_tail(&list, skb);
 		}
-		slot->backlog = 0;
+		WRITE_ONCE(slot->backlog, 0);
 		red_set_vars(&slot->vars);
-		q->ht[slot->hash] = SFQ_EMPTY_SLOT;
+		WRITE_ONCE(q->ht[slot->hash], SFQ_EMPTY_SLOT);
 	}
 	q->tail = NULL;
 
@@ -570,7 +572,7 @@ static void sfq_rehash(struct Qdisc *sch)
 				dropped++;
 				continue;
 			}
-			q->ht[hash] = x;
+			WRITE_ONCE(q->ht[hash], x);
 			slot = &q->slots[x];
 			slot->hash = hash;
 		}
@@ -581,7 +583,7 @@ static void sfq_rehash(struct Qdisc *sch)
 			slot->vars.qavg = red_calc_qavg(q->red_parms,
 							&slot->vars,
 							slot->backlog);
-		slot->backlog += qdisc_pkt_len(skb);
+		WRITE_ONCE(slot->backlog, slot->backlog + qdisc_pkt_len(skb));
 		sfq_inc(q, x);
 		if (slot->qlen == 1) {		/* The flow is new */
 			if (q->tail == NULL) {	/* It is the first flow */
@@ -591,7 +593,7 @@ static void sfq_rehash(struct Qdisc *sch)
 				q->tail->next = x;
 			}
 			q->tail = slot;
-			slot->allot = q->quantum;
+			WRITE_ONCE(slot->allot, q->quantum);
 		}
 	}
 	sch->q.qlen -= dropped;
@@ -905,16 +907,16 @@ static int sfq_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 				struct gnet_dump *d)
 {
 	struct sfq_sched_data *q = qdisc_priv(sch);
-	sfq_index idx = q->ht[cl - 1];
+	sfq_index idx = READ_ONCE(q->ht[cl - 1]);
 	struct gnet_stats_queue qs = { 0 };
 	struct tc_sfq_xstats xstats = { 0 };
 
 	if (idx != SFQ_EMPTY_SLOT) {
 		const struct sfq_slot *slot = &q->slots[idx];
 
-		xstats.allot = slot->allot;
-		qs.qlen = slot->qlen;
-		qs.backlog = slot->backlog;
+		xstats.allot = READ_ONCE(slot->allot);
+		qs.qlen = READ_ONCE(slot->qlen);
+		qs.backlog = READ_ONCE(slot->backlog);
 	}
 	if (gnet_stats_copy_queue(d, NULL, &qs, qs.qlen) < 0)
 		return -1;
@@ -930,7 +932,7 @@ static void sfq_walk(struct Qdisc *sch, struct qdisc_walker *arg)
 		return;
 
 	for (i = 0; i < q->divisor; i++) {
-		if (q->ht[i] == SFQ_EMPTY_SLOT) {
+		if (READ_ONCE(q->ht[i]) == SFQ_EMPTY_SLOT) {
 			arg->count++;
 			continue;
 		}
-- 
2.54.0.545.g6539524ca2-goog



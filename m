Return-Path: <netdev+bounces-286261-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDrEF8hMAGqsGAEAu9opvQ
	(envelope-from <netdev+bounces-286261-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:15:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3A1503479
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 11:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2079B301D061
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 09:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD1536CDF8;
	Sun, 10 May 2026 09:15:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D74mLnuq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20B3236CE14
	for <netdev@vger.kernel.org>; Sun, 10 May 2026 09:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778404503; cv=none; b=j3nj4N//zoB9i2Jl4Nk2lFpRjdQ/iwl+y9XCI+B8auJrfjeAbeGVGz974SKY2Ntoyrq5OMgpllRNYz0CIENE7VjXF53XN9282QGDvJ15fcAVGviR5+LrLnXhJ0xJgd96UL2pVyRBUHXGeTvtmcnBppGrt2owOHYD4ywj8QLKG6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778404503; c=relaxed/simple;
	bh=82HDrM49MaihngFS3eBQSAMjzyh6EGsCNp5dtSGFSwU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GzeNgu6I9aBamh0+Un0nzndqT7xDyG9L6w3oj63/yTQ3maUUTjSdtnaP/b+ooTPdhlUlhaG3YDY+CZx1GI62nsy6ThdYW4OX0U2L1k2Gvr9uL57GNebuJsrC+KtPbQMWqi8A3S9eA3ZRJ4dqXcivy/4QxX7Hb9s3nhXYzMCt+XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D74mLnuq; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50e67a4f642so8429231cf.0
        for <netdev@vger.kernel.org>; Sun, 10 May 2026 02:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778404500; x=1779009300; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=n7zhY40PFKEJXhoIxfq9k2X7U+9026zKBtT5w7ZkeS4=;
        b=D74mLnuqs8pPluNpZqeDU7auJtipL621BfOzOp4zEslhXl0eff86oFEAECpdTeZYEL
         IIBwGtx/CPL5ImRHWH2IcUOjt9YeuDDsWEb2zx1rMfr8Tq+W0ES4laCRdyqz0Ygrgkv0
         8GI8vBQZzquXBq1qTh7w6NPIqabt19OQxwtTBwXtR33oHOnSj3Q+jUkjd9vu+thtCvpS
         Pu2JNQdkB3Q7PNjD8eHtI07EFL5cROc1renJt0TXHRbxdZn1rAof71FqYazVJcxva2mw
         RS7KTBYjiVxGEAym2iHzayNSuMAH6ujoMo7vA+bN9hhR1rnRn/EREBmBtMT2IC1APwgV
         vw+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778404500; x=1779009300;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n7zhY40PFKEJXhoIxfq9k2X7U+9026zKBtT5w7ZkeS4=;
        b=QADsmpgj3WqvyeZf4bE33m5c3DzDtK6DTrBPYp9bu/0/34mndPRRhKWXuMX4TbLUdz
         va+7zVFqje1xzFFMStAUM1JJCSw9FSymrsgbBWTL/5/QX68l4SFRPuEnmhpM6FFfC678
         DBqoaKFHgU05lthZd0K/Yap9MDPY4eWeqzod0QGyTU5gF6TCfBL1GsDoZ4fXM8gPgXKl
         gkcOOtBWW0sZusZWSkvxrKv4/UZ6lCWlpyWb2l65pBNTBNMEgXAA79/dhTnsWJSCX4kV
         WlnQJKHcNQZQgplE67BU+VTWmhPQKOutuufAD+xIgZmA5gKujXTQpxao74KdjQIyylPm
         25lg==
X-Forwarded-Encrypted: i=1; AFNElJ/DUH8jrhAEzX0TdRllMp/ZncMcksvRy5IJ4y1KA3rUk+cyd038iheYBN/cmCrx2jhgNDoG7x4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Op4taB8MZ9OikXN41Qc/yMy+mnLdjaoeJb6evv9pyvtm2tgo
	4h6zTNctAehPRbjnW8EgKE+XSkWqVrfs8bmNrg2Vgc3UDBKVvmKtWU9D7zn8l81IxI/sxbXL8fu
	/3e+PJmcT0TantA==
X-Received: from qtbhg20.prod.google.com ([2002:a05:622a:6114:b0:50f:23ec:d2dc])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:244a:b0:50b:4946:2781 with SMTP id d75a77b69052e-51461f9ee1amr273829321cf.38.1778404499895;
 Sun, 10 May 2026 02:14:59 -0700 (PDT)
Date: Sun, 10 May 2026 09:14:49 +0000
In-Reply-To: <20260510091455.4039245-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260510091455.4039245-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260510091455.4039245-3-edumazet@google.com>
Subject: [PATCH v2 net-next 2/8] net/sched: add qdisc_qlen_inc() and qdisc_qlen_dec()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Victor Nogueira <victor@mojatatu.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: CF3A1503479
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286261-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Helpers to increment or decrement sch->q.qlen, with appropriate
WRITE_ONCE() to prevent store tearing.

Add other WRITE_ONCE() when sch->q.qlen is changed.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h | 32 +++++++++++++++++++++-----------
 net/sched/sch_api.c       |  2 +-
 net/sched/sch_cake.c      |  8 ++++----
 net/sched/sch_cbs.c       |  4 ++--
 net/sched/sch_choke.c     |  8 ++++----
 net/sched/sch_drr.c       |  4 ++--
 net/sched/sch_dualpi2.c   |  6 +++---
 net/sched/sch_etf.c       |  8 ++++----
 net/sched/sch_ets.c       |  4 ++--
 net/sched/sch_fq.c        |  6 +++---
 net/sched/sch_fq_codel.c  |  7 ++++---
 net/sched/sch_fq_pie.c    |  4 ++--
 net/sched/sch_generic.c   | 10 +++++-----
 net/sched/sch_hfsc.c      |  4 ++--
 net/sched/sch_hhf.c       |  7 ++++---
 net/sched/sch_htb.c       |  4 ++--
 net/sched/sch_mq.c        |  5 +++--
 net/sched/sch_mqprio.c    | 18 ++++++++++--------
 net/sched/sch_multiq.c    |  4 ++--
 net/sched/sch_netem.c     | 10 +++++-----
 net/sched/sch_prio.c      |  4 ++--
 net/sched/sch_qfq.c       |  6 +++---
 net/sched/sch_red.c       |  4 ++--
 net/sched/sch_sfb.c       |  4 ++--
 net/sched/sch_sfq.c       |  9 +++++----
 net/sched/sch_skbprio.c   |  4 ++--
 net/sched/sch_taprio.c    |  4 ++--
 net/sched/sch_tbf.c       |  6 +++---
 net/sched/sch_teql.c      |  2 +-
 29 files changed, 107 insertions(+), 91 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index ccfabfac674ef8617faeabd2fcb15daf8a1ea17f..dbb3ba6416e485128c120eb3dacb9b38d8f8ffe6 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -542,6 +542,16 @@ static inline int qdisc_qlen(const struct Qdisc *q)
 	return q->q.qlen;
 }
 
+static inline void qdisc_qlen_inc(struct Qdisc *q)
+{
+	WRITE_ONCE(q->q.qlen, q->q.qlen + 1);
+}
+
+static inline void qdisc_qlen_dec(struct Qdisc *q)
+{
+	WRITE_ONCE(q->q.qlen, q->q.qlen - 1);
+}
+
 static inline int qdisc_qlen_sum(const struct Qdisc *q)
 {
 	__u32 qlen = q->qstats.qlen;
@@ -549,9 +559,9 @@ static inline int qdisc_qlen_sum(const struct Qdisc *q)
 
 	if (qdisc_is_percpu_stats(q)) {
 		for_each_possible_cpu(i)
-			qlen += per_cpu_ptr(q->cpu_qstats, i)->qlen;
+			qlen += READ_ONCE(per_cpu_ptr(q->cpu_qstats, i)->qlen);
 	} else {
-		qlen += q->q.qlen;
+		qlen += READ_ONCE(q->q.qlen);
 	}
 
 	return qlen;
@@ -1068,7 +1078,7 @@ static inline void __qdisc_enqueue_tail(struct sk_buff *skb,
 		qh->tail = skb;
 		qh->head = skb;
 	}
-	qh->qlen++;
+	WRITE_ONCE(qh->qlen, qh->qlen + 1);
 }
 
 static inline int qdisc_enqueue_tail(struct sk_buff *skb, struct Qdisc *sch)
@@ -1086,7 +1096,7 @@ static inline void __qdisc_enqueue_head(struct sk_buff *skb,
 	if (!qh->head)
 		qh->tail = skb;
 	qh->head = skb;
-	qh->qlen++;
+	WRITE_ONCE(qh->qlen, qh->qlen + 1);
 }
 
 static inline struct sk_buff *__qdisc_dequeue_head(struct qdisc_skb_head *qh)
@@ -1095,7 +1105,7 @@ static inline struct sk_buff *__qdisc_dequeue_head(struct qdisc_skb_head *qh)
 
 	if (likely(skb != NULL)) {
 		qh->head = skb->next;
-		qh->qlen--;
+		WRITE_ONCE(qh->qlen, qh->qlen - 1);
 		if (qh->head == NULL)
 			qh->tail = NULL;
 		skb->next = NULL;
@@ -1110,7 +1120,7 @@ static inline struct sk_buff *qdisc_dequeue_internal(struct Qdisc *sch, bool dir
 
 	skb = __skb_dequeue(&sch->gso_skb);
 	if (skb) {
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 		qdisc_qstats_backlog_dec(sch, skb);
 		return skb;
 	}
@@ -1266,7 +1276,7 @@ static inline struct sk_buff *qdisc_peek_dequeued(struct Qdisc *sch)
 			__skb_queue_head(&sch->gso_skb, skb);
 			/* it's still part of the queue */
 			qdisc_qstats_backlog_inc(sch, skb);
-			sch->q.qlen++;
+			qdisc_qlen_inc(sch);
 		}
 	}
 
@@ -1283,7 +1293,7 @@ static inline void qdisc_update_stats_at_dequeue(struct Qdisc *sch,
 	} else {
 		qdisc_qstats_backlog_dec(sch, skb);
 		qdisc_bstats_update(sch, skb);
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 	}
 }
 
@@ -1295,7 +1305,7 @@ static inline void qdisc_update_stats_at_enqueue(struct Qdisc *sch,
 		this_cpu_add(sch->cpu_qstats->backlog, pkt_len);
 	} else {
 		sch->qstats.backlog += pkt_len;
-		sch->q.qlen++;
+		qdisc_qlen_inc(sch);
 	}
 }
 
@@ -1311,7 +1321,7 @@ static inline struct sk_buff *qdisc_dequeue_peeked(struct Qdisc *sch)
 			qdisc_qstats_cpu_qlen_dec(sch);
 		} else {
 			qdisc_qstats_backlog_dec(sch, skb);
-			sch->q.qlen--;
+			qdisc_qlen_dec(sch);
 		}
 	} else {
 		skb = sch->dequeue(sch);
@@ -1332,7 +1342,7 @@ static inline void __qdisc_reset_queue(struct qdisc_skb_head *qh)
 
 		qh->head = NULL;
 		qh->tail = NULL;
-		qh->qlen = 0;
+		WRITE_ONCE(qh->qlen, 0);
 	}
 }
 
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index 6f7847c5536f16e6754954f0a606581e17257361..cefa2d8ac5ec00c78b08b520a11672120d10cdef 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -805,7 +805,7 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 			cl = cops->find(sch, parentid);
 			cops->qlen_notify(sch, cl);
 		}
-		sch->q.qlen -= n;
+		WRITE_ONCE(sch->q.qlen, sch->q.qlen - n);
 		sch->qstats.backlog -= len;
 		__qdisc_qstats_drop(sch, drops);
 	}
diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index d931e8d51f723fdedea9f3f90efceec6e0a070d3..7ab75a52f7d1a46d87fc8f7c099c749a5331ccf6 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1612,7 +1612,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 		cake_advance_shaper(q, b, skb, now, true);
 
 	qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_OVERLIMIT);
-	sch->q.qlen--;
+	qdisc_qlen_dec(sch);
 
 	cake_heapify(q, 0);
 
@@ -1822,7 +1822,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 									  segs);
 			flow_queue_add(flow, segs);
 
-			sch->q.qlen++;
+			qdisc_qlen_inc(sch);
 			numsegs++;
 			slen += segs->len;
 			q->buffer_used += segs->truesize;
@@ -1861,7 +1861,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			qdisc_tree_reduce_backlog(sch, 1, ack_pkt_len);
 			consume_skb(ack);
 		} else {
-			sch->q.qlen++;
+			qdisc_qlen_inc(sch);
 			q->buffer_used      += skb->truesize;
 		}
 
@@ -1987,7 +1987,7 @@ static struct sk_buff *cake_dequeue_one(struct Qdisc *sch)
 		WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
 		sch->qstats.backlog      -= len;
 		q->buffer_used		 -= skb->truesize;
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 
 		if (q->overflow_timeout)
 			cake_heapify(q, b->overflow_idx[q->cur_flow]);
diff --git a/net/sched/sch_cbs.c b/net/sched/sch_cbs.c
index 8c9a0400c8622c652db290796f2dd338eb61799c..a75e58876797952f2218725f6da5cff29f330ae2 100644
--- a/net/sched/sch_cbs.c
+++ b/net/sched/sch_cbs.c
@@ -97,7 +97,7 @@ static int cbs_child_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return err;
 
 	sch->qstats.backlog += len;
-	sch->q.qlen++;
+	qdisc_qlen_inc(sch);
 
 	return NET_XMIT_SUCCESS;
 }
@@ -168,7 +168,7 @@ static struct sk_buff *cbs_child_dequeue(struct Qdisc *sch, struct Qdisc *child)
 
 	qdisc_qstats_backlog_dec(sch, skb);
 	qdisc_bstats_update(sch, skb);
-	sch->q.qlen--;
+	qdisc_qlen_dec(sch);
 
 	return skb;
 }
diff --git a/net/sched/sch_choke.c b/net/sched/sch_choke.c
index 2875bcdb18a413075c795665e95f9dbbaac45962..73d3e673dc7b16cf2b9ac1d622da280c2ceb064a 100644
--- a/net/sched/sch_choke.c
+++ b/net/sched/sch_choke.c
@@ -123,7 +123,7 @@ static void choke_drop_by_idx(struct Qdisc *sch, unsigned int idx,
 	if (idx == q->tail)
 		choke_zap_tail_holes(q);
 
-	--sch->q.qlen;
+	qdisc_qlen_dec(sch);
 	qdisc_qstats_backlog_dec(sch, skb);
 	qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
 	qdisc_drop(skb, sch, to_free);
@@ -271,7 +271,7 @@ static int choke_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (sch->q.qlen < q->limit) {
 		q->tab[q->tail] = skb;
 		q->tail = (q->tail + 1) & q->tab_mask;
-		++sch->q.qlen;
+		qdisc_qlen_inc(sch);
 		qdisc_qstats_backlog_inc(sch, skb);
 		return NET_XMIT_SUCCESS;
 	}
@@ -298,7 +298,7 @@ static struct sk_buff *choke_dequeue(struct Qdisc *sch)
 	skb = q->tab[q->head];
 	q->tab[q->head] = NULL;
 	choke_zap_head_holes(q);
-	--sch->q.qlen;
+	qdisc_qlen_dec(sch);
 	qdisc_qstats_backlog_dec(sch, skb);
 	qdisc_bstats_update(sch, skb);
 
@@ -396,7 +396,7 @@ static int choke_change(struct Qdisc *sch, struct nlattr *opt,
 				}
 				dropped += qdisc_pkt_len(skb);
 				qdisc_qstats_backlog_dec(sch, skb);
-				--sch->q.qlen;
+				qdisc_qlen_dec(sch);
 				rtnl_qdisc_drop(skb, sch);
 			}
 			qdisc_tree_reduce_backlog(sch, oqlen - sch->q.qlen, dropped);
diff --git a/net/sched/sch_drr.c b/net/sched/sch_drr.c
index 01335a49e091444747635ee8bc7e22ded504d571..925fa0cfd730ce72e45e8983ba02eb913afb1235 100644
--- a/net/sched/sch_drr.c
+++ b/net/sched/sch_drr.c
@@ -366,7 +366,7 @@ static int drr_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	sch->qstats.backlog += len;
-	sch->q.qlen++;
+	qdisc_qlen_inc(sch);
 	return err;
 }
 
@@ -399,7 +399,7 @@ static struct sk_buff *drr_dequeue(struct Qdisc *sch)
 			bstats_update(&cl->bstats, skb);
 			qdisc_bstats_update(sch, skb);
 			qdisc_qstats_backlog_dec(sch, skb);
-			sch->q.qlen--;
+			qdisc_qlen_dec(sch);
 			return skb;
 		}
 
diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index 241e6a46bd00e39820f5ba9dc71d559f205a4de0..c6416f09dddd8f170b92e50fb89377a15773c5bf 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -415,7 +415,7 @@ static int dualpi2_enqueue_skb(struct sk_buff *skb, struct Qdisc *sch,
 		dualpi2_skb_cb(skb)->apply_step = skb_apply_step(skb, q);
 
 		/* Keep the overall qdisc stats consistent */
-		++sch->q.qlen;
+		qdisc_qlen_inc(sch);
 		qdisc_qstats_backlog_inc(sch, skb);
 		++q->packets_in_l;
 		if (!q->l_head_ts)
@@ -530,7 +530,7 @@ static struct sk_buff *dequeue_packet(struct Qdisc *sch,
 		qdisc_qstats_backlog_dec(q->l_queue, skb);
 
 		/* Keep the global queue size consistent */
-		--sch->q.qlen;
+		qdisc_qlen_dec(sch);
 		q->memory_used -= skb->truesize;
 	} else if (c_len) {
 		skb = __qdisc_dequeue_head(&sch->q);
@@ -888,7 +888,7 @@ static int dualpi2_change(struct Qdisc *sch, struct nlattr *opt,
 			 * l_queue on enqueue; qdisc_dequeue_internal()
 			 * handled l_queue, so we further account for sch.
 			 */
-			--sch->q.qlen;
+			qdisc_qlen_dec(sch);
 			qdisc_qstats_backlog_dec(sch, skb);
 			q->memory_used -= skb->truesize;
 			rtnl_qdisc_drop(skb, q->l_queue);
diff --git a/net/sched/sch_etf.c b/net/sched/sch_etf.c
index c74d778c32a1eda639650df4d1d103c5338f14e6..ada87a81da6ac4c20e036b5391eb4efe9795ab91 100644
--- a/net/sched/sch_etf.c
+++ b/net/sched/sch_etf.c
@@ -189,7 +189,7 @@ static int etf_enqueue_timesortedlist(struct sk_buff *nskb, struct Qdisc *sch,
 	rb_insert_color_cached(&nskb->rbnode, &q->head, leftmost);
 
 	qdisc_qstats_backlog_inc(sch, nskb);
-	sch->q.qlen++;
+	qdisc_qlen_inc(sch);
 
 	/* Now we may need to re-arm the qdisc watchdog for the next packet. */
 	reset_watchdog(sch);
@@ -222,7 +222,7 @@ static void timesortedlist_drop(struct Qdisc *sch, struct sk_buff *skb,
 		qdisc_qstats_backlog_dec(sch, skb);
 		qdisc_drop(skb, sch, &to_free);
 		qdisc_qstats_overlimit(sch);
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 	}
 
 	kfree_skb_list(to_free);
@@ -247,7 +247,7 @@ static void timesortedlist_remove(struct Qdisc *sch, struct sk_buff *skb)
 
 	q->last = skb->tstamp;
 
-	sch->q.qlen--;
+	qdisc_qlen_dec(sch);
 }
 
 static struct sk_buff *etf_dequeue_timesortedlist(struct Qdisc *sch)
@@ -426,7 +426,7 @@ static void timesortedlist_clear(struct Qdisc *sch)
 
 		rb_erase_cached(&skb->rbnode, &q->head);
 		rtnl_kfree_skbs(skb, skb);
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 	}
 }
 
diff --git a/net/sched/sch_ets.c b/net/sched/sch_ets.c
index a4b07b661b7756a675d22c0f84f8f0a713cdb7eb..c817e0a6c14653a35f5ebb9de1a5ccc44d1a2f98 100644
--- a/net/sched/sch_ets.c
+++ b/net/sched/sch_ets.c
@@ -449,7 +449,7 @@ static int ets_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	sch->qstats.backlog += len;
-	sch->q.qlen++;
+	qdisc_qlen_inc(sch);
 	return err;
 }
 
@@ -458,7 +458,7 @@ ets_qdisc_dequeue_skb(struct Qdisc *sch, struct sk_buff *skb)
 {
 	qdisc_bstats_update(sch, skb);
 	qdisc_qstats_backlog_dec(sch, skb);
-	sch->q.qlen--;
+	qdisc_qlen_dec(sch);
 	return skb;
 }
 
diff --git a/net/sched/sch_fq.c b/net/sched/sch_fq.c
index f2edcf872981fd8181dfb97a3bc665fd4a869115..1e34ac136b15cf24742f2810d201420cf763021a 100644
--- a/net/sched/sch_fq.c
+++ b/net/sched/sch_fq.c
@@ -497,7 +497,7 @@ static void fq_dequeue_skb(struct Qdisc *sch, struct fq_flow *flow,
 	fq_erase_head(sch, flow, skb);
 	skb_mark_not_on_list(skb);
 	qdisc_qstats_backlog_dec(sch, skb);
-	sch->q.qlen--;
+	qdisc_qlen_dec(sch);
 	qdisc_bstats_update(sch, skb);
 }
 
@@ -597,7 +597,7 @@ static int fq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	flow_queue_add(f, skb);
 
 	qdisc_qstats_backlog_inc(sch, skb);
-	sch->q.qlen++;
+	qdisc_qlen_inc(sch);
 
 	return NET_XMIT_SUCCESS;
 }
@@ -801,7 +801,7 @@ static void fq_reset(struct Qdisc *sch)
 	struct fq_flow *f;
 	unsigned int idx;
 
-	sch->q.qlen = 0;
+	WRITE_ONCE(sch->q.qlen, 0);
 	sch->qstats.backlog = 0;
 
 	fq_flow_purge(&q->internal);
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index ed42ce62a17f1de9516af90533d16b65657f86cd..cae8483fbb0c4f62f28dba4c15b4426485390bcf 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -178,7 +178,7 @@ static unsigned int fq_codel_drop(struct Qdisc *sch, unsigned int max_packets,
 	q->memory_usage -= mem;
 	__qdisc_qstats_drop(sch, i);
 	sch->qstats.backlog -= len;
-	sch->q.qlen -= i;
+	WRITE_ONCE(sch->q.qlen, sch->q.qlen - i);
 	return idx;
 }
 
@@ -215,7 +215,8 @@ static int fq_codel_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	get_codel_cb(skb)->mem_usage = skb->truesize;
 	q->memory_usage += get_codel_cb(skb)->mem_usage;
 	memory_limited = q->memory_usage > q->memory_limit;
-	if (++sch->q.qlen <= sch->limit && !memory_limited)
+	qdisc_qlen_inc(sch);
+	if (sch->q.qlen <= sch->limit && !memory_limited)
 		return NET_XMIT_SUCCESS;
 
 	prev_backlog = sch->qstats.backlog;
@@ -266,7 +267,7 @@ static struct sk_buff *dequeue_func(struct codel_vars *vars, void *ctx)
 		WRITE_ONCE(q->backlogs[flow - q->flows],
 			   q->backlogs[flow - q->flows] - qdisc_pkt_len(skb));
 		q->memory_usage -= get_codel_cb(skb)->mem_usage;
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 		sch->qstats.backlog -= qdisc_pkt_len(skb);
 	}
 	return skb;
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 7becbf5362b3165bac4517f32887386b01301612..0a4eca4ab086ebebbdba17784f12370c301bbac6 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -185,7 +185,7 @@ static int fq_pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		q->stats.packets_in++;
 		q->memory_usage += skb->truesize;
 		sch->qstats.backlog += pkt_len;
-		sch->q.qlen++;
+		qdisc_qlen_inc(sch);
 		flow_queue_add(sel_flow, skb);
 		if (list_empty(&sel_flow->flowchain)) {
 			list_add_tail(&sel_flow->flowchain, &q->new_flows);
@@ -263,7 +263,7 @@ static struct sk_buff *fq_pie_qdisc_dequeue(struct Qdisc *sch)
 		skb = dequeue_head(flow);
 		pkt_len = qdisc_pkt_len(skb);
 		sch->qstats.backlog -= pkt_len;
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 		qdisc_bstats_update(sch, skb);
 	}
 
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index 05c250c483f0cbe8ccaf810558d9465073b72699..7b4a5874ed1f612ed1e16f910df30eadce8330fe 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -118,7 +118,7 @@ static inline struct sk_buff *__skb_dequeue_bad_txq(struct Qdisc *q)
 				qdisc_qstats_cpu_qlen_dec(q);
 			} else {
 				qdisc_qstats_backlog_dec(q, skb);
-				q->q.qlen--;
+				qdisc_qlen_dec(q);
 			}
 		} else {
 			skb = SKB_XOFF_MAGIC;
@@ -159,7 +159,7 @@ static inline void qdisc_enqueue_skb_bad_txq(struct Qdisc *q,
 		qdisc_qstats_cpu_qlen_inc(q);
 	} else {
 		qdisc_qstats_backlog_inc(q, skb);
-		q->q.qlen++;
+		qdisc_qlen_inc(q);
 	}
 
 	if (lock)
@@ -188,7 +188,7 @@ static inline void dev_requeue_skb(struct sk_buff *skb, struct Qdisc *q)
 		} else {
 			q->qstats.requeues++;
 			qdisc_qstats_backlog_inc(q, skb);
-			q->q.qlen++;
+			qdisc_qlen_inc(q);
 		}
 
 		skb = next;
@@ -294,7 +294,7 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
 				qdisc_qstats_cpu_qlen_dec(q);
 			} else {
 				qdisc_qstats_backlog_dec(q, skb);
-				q->q.qlen--;
+				qdisc_qlen_dec(q);
 			}
 		} else {
 			skb = NULL;
@@ -1062,7 +1062,7 @@ void qdisc_reset(struct Qdisc *qdisc)
 	__skb_queue_purge(&qdisc->gso_skb);
 	__skb_queue_purge(&qdisc->skb_bad_txq);
 
-	qdisc->q.qlen = 0;
+	WRITE_ONCE(qdisc->q.qlen, 0);
 	qdisc->qstats.backlog = 0;
 }
 EXPORT_SYMBOL(qdisc_reset);
diff --git a/net/sched/sch_hfsc.c b/net/sched/sch_hfsc.c
index 83b2ca2e37fc82cfebf089e6c0e36f18af939887..e71a565100edf60881ca7542faa408c5bb1a0984 100644
--- a/net/sched/sch_hfsc.c
+++ b/net/sched/sch_hfsc.c
@@ -1561,7 +1561,7 @@ hfsc_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	}
 
 	sch->qstats.backlog += len;
-	sch->q.qlen++;
+	qdisc_qlen_inc(sch);
 
 	if (first && !cl_in_el_or_vttree(cl)) {
 		if (cl->cl_flags & HFSC_RSC)
@@ -1650,7 +1650,7 @@ hfsc_dequeue(struct Qdisc *sch)
 
 	qdisc_bstats_update(sch, skb);
 	qdisc_qstats_backlog_dec(sch, skb);
-	sch->q.qlen--;
+	qdisc_qlen_dec(sch);
 
 	return skb;
 }
diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 96021f52d835b56339509565ca03fe796593e231..1e25b75daae2e5de31bd212dfa1f6d7aea927174 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -360,7 +360,7 @@ static unsigned int hhf_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	if (bucket->head) {
 		struct sk_buff *skb = dequeue_head(bucket);
 
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 		qdisc_qstats_backlog_dec(sch, skb);
 		qdisc_drop(skb, sch, to_free);
 	}
@@ -400,7 +400,8 @@ static int hhf_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		}
 		bucket->deficit = weight * q->quantum;
 	}
-	if (++sch->q.qlen <= sch->limit)
+	qdisc_qlen_inc(sch);
+	if (sch->q.qlen <= sch->limit)
 		return NET_XMIT_SUCCESS;
 
 	prev_backlog = sch->qstats.backlog;
@@ -443,7 +444,7 @@ static struct sk_buff *hhf_dequeue(struct Qdisc *sch)
 
 	if (bucket->head) {
 		skb = dequeue_head(bucket);
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 		qdisc_qstats_backlog_dec(sch, skb);
 	}
 
diff --git a/net/sched/sch_htb.c b/net/sched/sch_htb.c
index eb12381795ce1bb0f3b8c5f502e16ad64c4408c8..c22ccd8eae8c73323ccdf425e62857b3b851d74e 100644
--- a/net/sched/sch_htb.c
+++ b/net/sched/sch_htb.c
@@ -651,7 +651,7 @@ static int htb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	sch->qstats.backlog += len;
-	sch->q.qlen++;
+	qdisc_qlen_inc(sch);
 	return NET_XMIT_SUCCESS;
 }
 
@@ -951,7 +951,7 @@ static struct sk_buff *htb_dequeue(struct Qdisc *sch)
 ok:
 		qdisc_bstats_update(sch, skb);
 		qdisc_qstats_backlog_dec(sch, skb);
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 		return skb;
 	}
 
diff --git a/net/sched/sch_mq.c b/net/sched/sch_mq.c
index a0133a7b9d3b09a0d2a6064234c8fdef60dbf955..ec8c91d3fde04e59daec2aecdb14d6bf50715e15 100644
--- a/net/sched/sch_mq.c
+++ b/net/sched/sch_mq.c
@@ -143,10 +143,10 @@ EXPORT_SYMBOL_NS_GPL(mq_attach, "NET_SCHED_INTERNAL");
 void mq_dump_common(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct net_device *dev = qdisc_dev(sch);
+	unsigned int qlen = 0;
 	struct Qdisc *qdisc;
 	unsigned int ntx;
 
-	sch->q.qlen = 0;
 	gnet_stats_basic_sync_init(&sch->bstats);
 	memset(&sch->qstats, 0, sizeof(sch->qstats));
 
@@ -163,10 +163,11 @@ void mq_dump_common(struct Qdisc *sch, struct sk_buff *skb)
 				     &qdisc->bstats, false);
 		gnet_stats_add_queue(&sch->qstats, qdisc->cpu_qstats,
 				     &qdisc->qstats);
-		sch->q.qlen += qdisc_qlen(qdisc);
+		qlen += qdisc_qlen(qdisc);
 
 		spin_unlock_bh(qdisc_lock(qdisc));
 	}
+	WRITE_ONCE(sch->q.qlen, qlen);
 }
 EXPORT_SYMBOL_NS_GPL(mq_dump_common, "NET_SCHED_INTERNAL");
 
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 002add5ce9e0ab04a6260495d1bec02983c2a204..91a92992cd24ab6c30bf7db2288c08cd493c7bc3 100644
--- a/net/sched/sch_mqprio.c
+++ b/net/sched/sch_mqprio.c
@@ -555,10 +555,11 @@ static int mqprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 	struct mqprio_sched *priv = qdisc_priv(sch);
 	struct nlattr *nla = (struct nlattr *)skb_tail_pointer(skb);
 	struct tc_mqprio_qopt opt = { 0 };
+	unsigned int qlen = 0;
 	struct Qdisc *qdisc;
 	unsigned int ntx;
 
-	sch->q.qlen = 0;
+	qlen = 0;
 	gnet_stats_basic_sync_init(&sch->bstats);
 	memset(&sch->qstats, 0, sizeof(sch->qstats));
 
@@ -575,10 +576,11 @@ static int mqprio_dump(struct Qdisc *sch, struct sk_buff *skb)
 				     &qdisc->bstats, false);
 		gnet_stats_add_queue(&sch->qstats, qdisc->cpu_qstats,
 				     &qdisc->qstats);
-		sch->q.qlen += qdisc_qlen(qdisc);
+		qlen += qdisc_qlen(qdisc);
 
 		spin_unlock_bh(qdisc_lock(qdisc));
 	}
+	WRITE_ONCE(sch->q.qlen, qlen);
 
 	mqprio_qopt_reconstruct(dev, &opt);
 	opt.hw = priv->hw_offload;
@@ -663,12 +665,12 @@ static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 	__acquires(d->lock)
 {
 	if (cl >= TC_H_MIN_PRIORITY) {
-		int i;
-		__u32 qlen;
-		struct gnet_stats_queue qstats = {0};
-		struct gnet_stats_basic_sync bstats;
 		struct net_device *dev = qdisc_dev(sch);
 		struct netdev_tc_txq tc = dev->tc_to_txq[cl & TC_BITMASK];
+		struct gnet_stats_queue qstats = {0};
+		struct gnet_stats_basic_sync bstats;
+		u32 qlen = 0;
+		int i;
 
 		gnet_stats_basic_sync_init(&bstats);
 		/* Drop lock here it will be reclaimed before touching
@@ -689,11 +691,11 @@ static int mqprio_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 					     &qdisc->bstats, false);
 			gnet_stats_add_queue(&qstats, qdisc->cpu_qstats,
 					     &qdisc->qstats);
-			sch->q.qlen += qdisc_qlen(qdisc);
+			qlen += qdisc_qlen(qdisc);
 
 			spin_unlock_bh(qdisc_lock(qdisc));
 		}
-		qlen = qdisc_qlen(sch) + qstats.qlen;
+		qlen = qlen + qstats.qlen;
 
 		/* Reclaim root sleeping lock before completing stats */
 		if (d->lock)
diff --git a/net/sched/sch_multiq.c b/net/sched/sch_multiq.c
index 9f822fee113df6562ddac89092357434547a4599..4e465d11e3d75e36b875b66f8c8087c2e15cdad9 100644
--- a/net/sched/sch_multiq.c
+++ b/net/sched/sch_multiq.c
@@ -76,7 +76,7 @@ multiq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	ret = qdisc_enqueue(skb, qdisc, to_free);
 	if (ret == NET_XMIT_SUCCESS) {
-		sch->q.qlen++;
+		qdisc_qlen_inc(sch);
 		return NET_XMIT_SUCCESS;
 	}
 	if (net_xmit_drop_count(ret))
@@ -106,7 +106,7 @@ static struct sk_buff *multiq_dequeue(struct Qdisc *sch)
 			skb = qdisc->dequeue(qdisc);
 			if (skb) {
 				qdisc_bstats_update(sch, skb);
-				sch->q.qlen--;
+				qdisc_qlen_dec(sch);
 				return skb;
 			}
 		}
diff --git a/net/sched/sch_netem.c b/net/sched/sch_netem.c
index bc18e1976b6e07f81f975ceeb35c8b1a5125e8df..57b12cbca45355c69780614fa87aaf37255d64cc 100644
--- a/net/sched/sch_netem.c
+++ b/net/sched/sch_netem.c
@@ -416,7 +416,7 @@ static void tfifo_enqueue(struct sk_buff *nskb, struct Qdisc *sch)
 		rb_insert_color(&nskb->rbnode, &q->t_root);
 	}
 	q->t_len++;
-	sch->q.qlen++;
+	qdisc_qlen_inc(sch);
 }
 
 /* netem can't properly corrupt a megapacket (like we get from GSO), so instead
@@ -751,19 +751,19 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 					if (net_xmit_drop_count(err))
 						qdisc_qstats_drop(sch);
 					sch->qstats.backlog -= pkt_len;
-					sch->q.qlen--;
+					qdisc_qlen_dec(sch);
 					qdisc_tree_reduce_backlog(sch, 1, pkt_len);
 				}
 				goto tfifo_dequeue;
 			}
-			sch->q.qlen--;
+			qdisc_qlen_dec(sch);
 			goto deliver;
 		}
 
 		if (q->qdisc) {
 			skb = q->qdisc->ops->dequeue(q->qdisc);
 			if (skb) {
-				sch->q.qlen--;
+				qdisc_qlen_dec(sch);
 				goto deliver;
 			}
 		}
@@ -776,7 +776,7 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
 	if (q->qdisc) {
 		skb = q->qdisc->ops->dequeue(q->qdisc);
 		if (skb) {
-			sch->q.qlen--;
+			qdisc_qlen_dec(sch);
 			goto deliver;
 		}
 	}
diff --git a/net/sched/sch_prio.c b/net/sched/sch_prio.c
index 9e2b9a490db23d858b27b7fc073b05a06535b05e..fe42ae3d6b696b2fc47f4d397af32e950eeec194 100644
--- a/net/sched/sch_prio.c
+++ b/net/sched/sch_prio.c
@@ -86,7 +86,7 @@ prio_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 	ret = qdisc_enqueue(skb, qdisc, to_free);
 	if (ret == NET_XMIT_SUCCESS) {
 		sch->qstats.backlog += len;
-		sch->q.qlen++;
+		qdisc_qlen_inc(sch);
 		return NET_XMIT_SUCCESS;
 	}
 	if (net_xmit_drop_count(ret))
@@ -119,7 +119,7 @@ static struct sk_buff *prio_dequeue(struct Qdisc *sch)
 		if (skb) {
 			qdisc_bstats_update(sch, skb);
 			qdisc_qstats_backlog_dec(sch, skb);
-			sch->q.qlen--;
+			qdisc_qlen_dec(sch);
 			return skb;
 		}
 	}
diff --git a/net/sched/sch_qfq.c b/net/sched/sch_qfq.c
index 699e45873f86145e96abd0d9ca77a6d0ff763b1b..195c434aae5f7e03d1a1238ed73bb64b3f04e105 100644
--- a/net/sched/sch_qfq.c
+++ b/net/sched/sch_qfq.c
@@ -1152,12 +1152,12 @@ static struct sk_buff *qfq_dequeue(struct Qdisc *sch)
 	if (!skb)
 		return NULL;
 
-	sch->q.qlen--;
+	qdisc_qlen_dec(sch);
 
 	skb = agg_dequeue(in_serv_agg, cl, len);
 
 	if (!skb) {
-		sch->q.qlen++;
+		qdisc_qlen_inc(sch);
 		return NULL;
 	}
 
@@ -1265,7 +1265,7 @@ static int qfq_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	_bstats_update(&cl->bstats, len, gso_segs);
 	sch->qstats.backlog += len;
-	++sch->q.qlen;
+	qdisc_qlen_inc(sch);
 
 	agg = cl->agg;
 	/* if the class is active, then done here */
diff --git a/net/sched/sch_red.c b/net/sched/sch_red.c
index 4d0e44a2e7c664e1599699d21ef482529ee2b119..0719590dfd73b64d21f71ab00621f64ed0eefc89 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -139,7 +139,7 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	ret = qdisc_enqueue(skb, child, to_free);
 	if (likely(ret == NET_XMIT_SUCCESS)) {
 		sch->qstats.backlog += len;
-		sch->q.qlen++;
+		qdisc_qlen_inc(sch);
 	} else if (net_xmit_drop_count(ret)) {
 		WRITE_ONCE(q->stats.pdrop,
 			   q->stats.pdrop + 1);
@@ -166,7 +166,7 @@ static struct sk_buff *red_dequeue(struct Qdisc *sch)
 	if (skb) {
 		qdisc_bstats_update(sch, skb);
 		qdisc_qstats_backlog_dec(sch, skb);
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 	} else {
 		if (!red_is_idling(&q->vars))
 			red_start_of_idle_period(&q->vars);
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index d3ee8e5479b35e38b71b0979e78aeadb40eb1655..efd9251c3add317f3b817f08c732fca0c347bf35 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -416,7 +416,7 @@ static int sfb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	ret = qdisc_enqueue(skb, child, to_free);
 	if (likely(ret == NET_XMIT_SUCCESS)) {
 		sch->qstats.backlog += len;
-		sch->q.qlen++;
+		qdisc_qlen_inc(sch);
 		increment_qlen(&cb, q);
 	} else if (net_xmit_drop_count(ret)) {
 		WRITE_ONCE(q->stats.childdrop,
@@ -446,7 +446,7 @@ static struct sk_buff *sfb_dequeue(struct Qdisc *sch)
 	if (skb) {
 		qdisc_bstats_update(sch, skb);
 		qdisc_qstats_backlog_dec(sch, skb);
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 		decrement_qlen(skb, q);
 	}
 
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index f39822babf88bee9d52cac9f39637d38ec36994f..f9807ee2cf6c72101ce39c4f43bf32c03c0a5f62 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -302,7 +302,7 @@ static unsigned int sfq_drop(struct Qdisc *sch, struct sk_buff **to_free)
 		len = qdisc_pkt_len(skb);
 		WRITE_ONCE(slot->backlog, slot->backlog - len);
 		sfq_dec(q, x);
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 		qdisc_qstats_backlog_dec(sch, skb);
 		qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_OVERLIMIT);
 		return len;
@@ -456,7 +456,8 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		/* We could use a bigger initial quantum for new flows */
 		WRITE_ONCE(slot->allot, q->quantum);
 	}
-	if (++sch->q.qlen <= q->limit)
+	qdisc_qlen_inc(sch);
+	if (sch->q.qlen <= q->limit)
 		return NET_XMIT_SUCCESS;
 
 	qlen = slot->qlen;
@@ -497,7 +498,7 @@ sfq_dequeue(struct Qdisc *sch)
 	skb = slot_dequeue_head(slot);
 	sfq_dec(q, a);
 	qdisc_bstats_update(sch, skb);
-	sch->q.qlen--;
+	qdisc_qlen_dec(sch);
 	qdisc_qstats_backlog_dec(sch, skb);
 	WRITE_ONCE(slot->backlog, slot->backlog - qdisc_pkt_len(skb));
 	/* Is the slot empty? */
@@ -596,7 +597,7 @@ static void sfq_rehash(struct Qdisc *sch)
 			WRITE_ONCE(slot->allot, q->quantum);
 		}
 	}
-	sch->q.qlen -= dropped;
+	WRITE_ONCE(sch->q.qlen, sch->q.qlen - dropped);
 	qdisc_tree_reduce_backlog(sch, dropped, drop_len);
 }
 
diff --git a/net/sched/sch_skbprio.c b/net/sched/sch_skbprio.c
index f485f62ab721ab8cde21230c60514708fb479982..52abfb4015a36408046d96b349497419ab5dacf8 100644
--- a/net/sched/sch_skbprio.c
+++ b/net/sched/sch_skbprio.c
@@ -93,7 +93,7 @@ static int skbprio_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (prio < q->lowest_prio)
 			q->lowest_prio = prio;
 
-		sch->q.qlen++;
+		qdisc_qlen_inc(sch);
 		return NET_XMIT_SUCCESS;
 	}
 
@@ -145,7 +145,7 @@ static struct sk_buff *skbprio_dequeue(struct Qdisc *sch)
 	if (unlikely(!skb))
 		return NULL;
 
-	sch->q.qlen--;
+	qdisc_qlen_dec(sch);
 	qdisc_qstats_backlog_dec(sch, skb);
 	qdisc_bstats_update(sch, skb);
 
diff --git a/net/sched/sch_taprio.c b/net/sched/sch_taprio.c
index 71b690e1974dad8fbab7e12998e03f86a0847a98..d6b981e5df11cba060c9c92212479c0d5a058f5b 100644
--- a/net/sched/sch_taprio.c
+++ b/net/sched/sch_taprio.c
@@ -574,7 +574,7 @@ static int taprio_enqueue_one(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	qdisc_qstats_backlog_inc(sch, skb);
-	sch->q.qlen++;
+	qdisc_qlen_inc(sch);
 
 	return qdisc_enqueue(skb, child, to_free);
 }
@@ -755,7 +755,7 @@ static struct sk_buff *taprio_dequeue_from_txq(struct Qdisc *sch, int txq,
 
 	qdisc_bstats_update(sch, skb);
 	qdisc_qstats_backlog_dec(sch, skb);
-	sch->q.qlen--;
+	qdisc_qlen_dec(sch);
 
 	return skb;
 }
diff --git a/net/sched/sch_tbf.c b/net/sched/sch_tbf.c
index f2340164f579a25431979e12ec3d23ab828edd16..25edf11a7d671fe63878b0995998c5920b86ef74 100644
--- a/net/sched/sch_tbf.c
+++ b/net/sched/sch_tbf.c
@@ -231,7 +231,7 @@ static int tbf_segment(struct sk_buff *skb, struct Qdisc *sch,
 			len += seg_len;
 		}
 	}
-	sch->q.qlen += nb;
+	WRITE_ONCE(sch->q.qlen, sch->q.qlen + nb);
 	sch->qstats.backlog += len;
 	if (nb > 0) {
 		qdisc_tree_reduce_backlog(sch, 1 - nb, prev_len - len);
@@ -264,7 +264,7 @@ static int tbf_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	}
 
 	sch->qstats.backlog += len;
-	sch->q.qlen++;
+	qdisc_qlen_inc(sch);
 	return NET_XMIT_SUCCESS;
 }
 
@@ -309,7 +309,7 @@ static struct sk_buff *tbf_dequeue(struct Qdisc *sch)
 			q->tokens = toks;
 			q->ptokens = ptoks;
 			qdisc_qstats_backlog_dec(sch, skb);
-			sch->q.qlen--;
+			qdisc_qlen_dec(sch);
 			qdisc_bstats_update(sch, skb);
 			return skb;
 		}
diff --git a/net/sched/sch_teql.c b/net/sched/sch_teql.c
index ec4039a201a2c2c502bc649fa5f6a0e4feee8fd5..e7bbc9e5174d0e76252e9091963ddf4fc8fa5557 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -107,7 +107,7 @@ teql_dequeue(struct Qdisc *sch)
 	} else {
 		qdisc_bstats_update(sch, skb);
 	}
-	sch->q.qlen = dat->q.qlen + q->q.qlen;
+	WRITE_ONCE(sch->q.qlen, dat->q.qlen + READ_ONCE(q->q.qlen));
 	return skb;
 }
 
-- 
2.54.0.563.g4f69b47b94-goog



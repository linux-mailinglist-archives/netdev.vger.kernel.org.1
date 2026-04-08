Return-Path: <netdev+bounces-276519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +J4DH4BQ1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:56:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 26F243BC74B
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7A859301A527
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:56:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4453BE146;
	Wed,  8 Apr 2026 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VGzr9dBv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F6E2EA48F
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652983; cv=none; b=kV9jKN78WpZIH5jWmr61/mBpNrvIsPO0HZPyOJ0KUlN+tpIdTWdB+rJEBU1Ka0AJRlxGMAavhw7Nn8dnTvHRx4cFX/RR4BQ32H0IybbyEm2LJzitPFju2+FvsHFKzoGvdl/zizHKLK9+LQECxaLELsvotl3QVEvCgpHw3OVL/44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652983; c=relaxed/simple;
	bh=t0JJVSQ9WDCaRKMvNV8sLI1aeuLYIl/38SidKCcL5M0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=rwgWbOE0qH0+/fU3QSj333jUDIWp/hifo1ZkBMkl3S3CUqs22F165Jq0Ews7BhWv7Z90aqES95kpdMaQcd90b+92we99b05mdvENQhEkkrNyivh1dcy9yQFMQI6paA92d5MsBy4TXnnMhsK2fmQM/4kR4V9wnt3eXQutSHBZ/S4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VGzr9dBv; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8d6061bd722so868788385a.3
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:56:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775652980; x=1776257780; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EPwVUO50yT+fNxhY5NIkRcxeKm8LEhzWhsQd8ii3ZCw=;
        b=VGzr9dBvt6nhdLxDG3QtKifRrfokc4AgnFYAWR/I1okkP4E38/esfBi9Kd0s60xktb
         fvDj2ZT73fDoi9R7RQvfUZg6mrujVeU9A9Z0iqkl+Vi503juGqCRS3OiL6Gd4yrDSt8m
         xGCYTL31hhhM5WzsLn+a7Fz0Ie9TFqznxwzvjNLZbrzEKlUXozN82zYD7qY8kXyx05tp
         bAzCuDLkUGIuVA+WK0fEEGtcfCPQyLbhwebhlDjeh3BC6Fv8c+h+H7JT0V3axpGUwsax
         Ne+DeDlZ0IgDfCXZhzs//NAJMlDHk132CVUP4bBo1YqII55riIFqjyjhLk4Vt8Tlmgug
         kJfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652980; x=1776257780;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EPwVUO50yT+fNxhY5NIkRcxeKm8LEhzWhsQd8ii3ZCw=;
        b=TmLs3/+EqWtNsRBHNrf+JswZJgK8tEDfj9mVl2u/KV1mzNzTGF3xatv7QuhAbEDoEh
         kslVrkvTrl8xTjHI7g1SW75rMSUnNvbSGDo3QLJnX/1GIIAN3/WzAhwwOjPPODEXeLlI
         Baw34dMo7WdpqYPoAh2AW09DCKPKhM19ZkCUN8WtNYJPanFlC/LVmFtk9Usw7d5EhwgG
         IuFrOCkwd0Pu+a3PIDp+V/NPgBnxA9fSmswt55clDyPsPEMWX+c959txRoMfT704n7QG
         Dx+lFVGDX6W6MpbZPOefqUMLFkluAhPfHenJho7RR556Adau2E9DkTNIPutZWd7+J4GA
         3DRQ==
X-Forwarded-Encrypted: i=1; AJvYcCWzXG3Nw5ofmYUp/Dn0n/7KHHiXPc7dvIFKyjC1N+VBR8rOKJtHpkKkAHUp/HphoixbT/qHow8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzepJN5htFhayfJ0c/kCJ9LW6IaRfVaaShxm9rF9pBKPKxPoTIM
	GCQrTi1xi5t1vnpvjDz1WZYMXh9fcNtaCK3yzNJCwinh3q5opCgX4Nt3SrayAxkeH7L4HJSp9iN
	kfbmqsB3VTcy8xQ==
X-Received: from qtbh15.prod.google.com ([2002:ac8:7d4f:0:b0:50d:222c:6202])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:5c15:b0:50d:9cda:70ed with SMTP id d75a77b69052e-50d9cda79cemr125930811cf.35.1775652980254;
 Wed, 08 Apr 2026 05:56:20 -0700 (PDT)
Date: Wed,  8 Apr 2026 12:56:00 +0000
In-Reply-To: <20260408125611.3592751-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408125611.3592751-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408125611.3592751-5-edumazet@google.com>
Subject: [PATCH net-next 04/15] net/sched: add qdisc_qlen_inc() and qdisc_qlen_dec()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276519-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 26F243BC74B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Helpers to increment or decrement sch->q.qlen, with appropriate
WRITE_ONCE() to prevent store tearing.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sch_generic.h | 24 +++++++++++++++++-------
 net/sched/sch_api.c       |  2 +-
 net/sched/sch_cake.c      |  8 ++++----
 net/sched/sch_cbs.c       |  4 ++--
 net/sched/sch_choke.c     |  8 ++++----
 net/sched/sch_drr.c       |  4 ++--
 net/sched/sch_dualpi2.c   |  4 ++--
 net/sched/sch_etf.c       |  8 ++++----
 net/sched/sch_ets.c       |  4 ++--
 net/sched/sch_fq.c        |  4 ++--
 net/sched/sch_fq_codel.c  |  7 ++++---
 net/sched/sch_fq_pie.c    |  4 ++--
 net/sched/sch_generic.c   |  8 ++++----
 net/sched/sch_hfsc.c      |  4 ++--
 net/sched/sch_hhf.c       |  7 ++++---
 net/sched/sch_htb.c       |  4 ++--
 net/sched/sch_mqprio.c    |  6 ++++--
 net/sched/sch_multiq.c    |  4 ++--
 net/sched/sch_netem.c     | 10 +++++-----
 net/sched/sch_prio.c      |  4 ++--
 net/sched/sch_qfq.c       |  6 +++---
 net/sched/sch_red.c       |  4 ++--
 net/sched/sch_sfb.c       |  4 ++--
 net/sched/sch_sfq.c       |  7 ++++---
 net/sched/sch_skbprio.c   |  4 ++--
 net/sched/sch_taprio.c    |  4 ++--
 net/sched/sch_tbf.c       |  6 +++---
 net/sched/sch_teql.c      |  2 +-
 28 files changed, 90 insertions(+), 75 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index b22579671e4b4dd04c5dfa810b714daaac74af2a..84acf7ac42cb5173d151d98fa0ea603e9cc80d69 100644
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
@@ -1110,7 +1120,7 @@ static inline struct sk_buff *qdisc_dequeue_internal(struct Qdisc *sch, bool dir
 
 	skb = __skb_dequeue(&sch->gso_skb);
 	if (skb) {
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 		qdisc_qstats_backlog_dec(sch, skb);
 		return skb;
 	}
@@ -1256,7 +1266,7 @@ static inline struct sk_buff *qdisc_peek_dequeued(struct Qdisc *sch)
 			__skb_queue_head(&sch->gso_skb, skb);
 			/* it's still part of the queue */
 			qdisc_qstats_backlog_inc(sch, skb);
-			sch->q.qlen++;
+			qdisc_qlen_inc(sch);
 		}
 	}
 
@@ -1273,7 +1283,7 @@ static inline void qdisc_update_stats_at_dequeue(struct Qdisc *sch,
 	} else {
 		qdisc_qstats_backlog_dec(sch, skb);
 		qdisc_bstats_update(sch, skb);
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 	}
 }
 
@@ -1285,7 +1295,7 @@ static inline void qdisc_update_stats_at_enqueue(struct Qdisc *sch,
 		this_cpu_add(sch->cpu_qstats->backlog, pkt_len);
 	} else {
 		sch->qstats.backlog += pkt_len;
-		sch->q.qlen++;
+		qdisc_qlen_inc(sch);
 	}
 }
 
@@ -1301,7 +1311,7 @@ static inline struct sk_buff *qdisc_dequeue_peeked(struct Qdisc *sch)
 			qdisc_qstats_cpu_qlen_dec(sch);
 		} else {
 			qdisc_qstats_backlog_dec(sch, skb);
-			sch->q.qlen--;
+			qdisc_qlen_dec(sch);
 		}
 	} else {
 		skb = sch->dequeue(sch);
diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index ed869a5ffc7377b7c19e66ae5fc9788e709488da..0dd3efd86393870e9695dddb4a471c5bf854f81e 100644
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
index ffea9fbd522d8dd3311cbca0a55a3d133eaceae4..0a8b067ba8ecbb85bd6f96ee9e5e959ba5e2efae 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -1605,7 +1605,7 @@ static unsigned int cake_drop(struct Qdisc *sch, struct sk_buff **to_free)
 		cake_advance_shaper(q, b, skb, now, true);
 
 	qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_OVERLIMIT);
-	sch->q.qlen--;
+	qdisc_qlen_dec(sch);
 
 	cake_heapify(q, 0);
 
@@ -1815,7 +1815,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 									  segs);
 			flow_queue_add(flow, segs);
 
-			sch->q.qlen++;
+			qdisc_qlen_inc(sch);
 			numsegs++;
 			slen += segs->len;
 			q->buffer_used += segs->truesize;
@@ -1854,7 +1854,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			qdisc_tree_reduce_backlog(sch, 1, ack_pkt_len);
 			consume_skb(ack);
 		} else {
-			sch->q.qlen++;
+			qdisc_qlen_inc(sch);
 			q->buffer_used      += skb->truesize;
 		}
 
@@ -1980,7 +1980,7 @@ static struct sk_buff *cake_dequeue_one(struct Qdisc *sch)
 		b->tin_backlog		 -= len;
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
index 94df8e741a979191a06885ad3ee813f12650ff3c..cd0785ad8e74314e6d5c88144ffcf64f286e02dd 100644
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
@@ -267,7 +267,7 @@ static int choke_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	if (sch->q.qlen < q->limit) {
 		q->tab[q->tail] = skb;
 		q->tail = (q->tail + 1) & q->tab_mask;
-		++sch->q.qlen;
+		qdisc_qlen_inc(sch);
 		qdisc_qstats_backlog_inc(sch, skb);
 		return NET_XMIT_SUCCESS;
 	}
@@ -294,7 +294,7 @@ static struct sk_buff *choke_dequeue(struct Qdisc *sch)
 	skb = q->tab[q->head];
 	q->tab[q->head] = NULL;
 	choke_zap_head_holes(q);
-	--sch->q.qlen;
+	qdisc_qlen_dec(sch);
 	qdisc_qstats_backlog_dec(sch, skb);
 	qdisc_bstats_update(sch, skb);
 
@@ -392,7 +392,7 @@ static int choke_change(struct Qdisc *sch, struct nlattr *opt,
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
index fe6f5e8896257674b9f175e01428b89e299a7dda..d093d058decbc577f3b311e1e8513260c167bff0 100644
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
index f2edcf872981fd8181dfb97a3bc665fd4a869115..dd553d6f3e8e911e161c1440eb6d9ce94f65385a 100644
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
diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 2a3d758f67ab43d17128442fd8b51c6ba7775d52..183b1ea9d2076d8f709d50a38b39d28a2b14bad8 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -178,7 +178,7 @@ static unsigned int fq_codel_drop(struct Qdisc *sch, unsigned int max_packets,
 	q->memory_usage -= mem;
 	sch->qstats.drops += i;
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
@@ -265,7 +266,7 @@ static struct sk_buff *dequeue_func(struct codel_vars *vars, void *ctx)
 		skb = dequeue_head(flow);
 		q->backlogs[flow - q->flows] -= qdisc_pkt_len(skb);
 		q->memory_usage -= get_codel_cb(skb)->mem_usage;
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 		sch->qstats.backlog -= qdisc_pkt_len(skb);
 	}
 	return skb;
diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 154c70f489f289066db5d61bb51e58aaf328f16e..dba49d44a5d2412b2deb983bf87428ade7944e51 100644
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
index a93321db8fd75d30c61e146c290bbc139c37c913..32ace8659ab86457cd1b1655810e0f4105149c47 100644
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
index 95e5d9bfd9c8c0cac08e080b8f1e0332e722aa3b..69b6f0a5471cb9a3b7b760144683f2b249091d89 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -359,7 +359,7 @@ static unsigned int hhf_drop(struct Qdisc *sch, struct sk_buff **to_free)
 	if (bucket->head) {
 		struct sk_buff *skb = dequeue_head(bucket);
 
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 		qdisc_qstats_backlog_dec(sch, skb);
 		qdisc_drop(skb, sch, to_free);
 	}
@@ -399,7 +399,8 @@ static int hhf_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		}
 		bucket->deficit = weight * q->quantum;
 	}
-	if (++sch->q.qlen <= sch->limit)
+	qdisc_qlen_inc(sch);
+	if (sch->q.qlen <= sch->limit)
 		return NET_XMIT_SUCCESS;
 
 	prev_backlog = sch->qstats.backlog;
@@ -442,7 +443,7 @@ static struct sk_buff *hhf_dequeue(struct Qdisc *sch)
 
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
 
diff --git a/net/sched/sch_mqprio.c b/net/sched/sch_mqprio.c
index 002add5ce9e0ab04a6260495d1bec02983c2a204..d35624e5869a4a6a12612886b2cd9cdac7b0b471 100644
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
index 20df1c08b1e9d04e9495f1a69eff0dd96049f914..4498dd440a02ea7a089c92ebc005d5064b87e2d2 100644
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
@@ -752,19 +752,19 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
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
@@ -777,7 +777,7 @@ static struct sk_buff *netem_dequeue(struct Qdisc *sch)
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
index c8d3d09f15e3919d6468964561130bfc79fb215b..61b9064d39f222bdfe5021e93e8172b7ae60c408 100644
--- a/net/sched/sch_red.c
+++ b/net/sched/sch_red.c
@@ -133,7 +133,7 @@ static int red_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	ret = qdisc_enqueue(skb, child, to_free);
 	if (likely(ret == NET_XMIT_SUCCESS)) {
 		sch->qstats.backlog += len;
-		sch->q.qlen++;
+		qdisc_qlen_inc(sch);
 	} else if (net_xmit_drop_count(ret)) {
 		q->stats.pdrop++;
 		qdisc_qstats_drop(sch);
@@ -159,7 +159,7 @@ static struct sk_buff *red_dequeue(struct Qdisc *sch)
 	if (skb) {
 		qdisc_bstats_update(sch, skb);
 		qdisc_qstats_backlog_dec(sch, skb);
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 	} else {
 		if (!red_is_idling(&q->vars))
 			red_start_of_idle_period(&q->vars);
diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index 01373866212894c57e7de58706ee464879303955..17b6ce223ad3a6f2d289c3ebe27cce8168c66b2b 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -407,7 +407,7 @@ static int sfb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	ret = qdisc_enqueue(skb, child, to_free);
 	if (likely(ret == NET_XMIT_SUCCESS)) {
 		sch->qstats.backlog += len;
-		sch->q.qlen++;
+		qdisc_qlen_inc(sch);
 		increment_qlen(&cb, q);
 	} else if (net_xmit_drop_count(ret)) {
 		q->stats.childdrop++;
@@ -436,7 +436,7 @@ static struct sk_buff *sfb_dequeue(struct Qdisc *sch)
 	if (skb) {
 		qdisc_bstats_update(sch, skb);
 		qdisc_qstats_backlog_dec(sch, skb);
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 		decrement_qlen(skb, q);
 	}
 
diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index c3f3181dba5424eb9d26362a1628653bb9392e89..5eb6d8abd1c334938f72259f5fc41526597e792f 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -300,7 +300,7 @@ static unsigned int sfq_drop(struct Qdisc *sch, struct sk_buff **to_free)
 		len = qdisc_pkt_len(skb);
 		slot->backlog -= len;
 		sfq_dec(q, x);
-		sch->q.qlen--;
+		qdisc_qlen_dec(sch);
 		qdisc_qstats_backlog_dec(sch, skb);
 		qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_OVERLIMIT);
 		return len;
@@ -454,7 +454,8 @@ sfq_enqueue(struct sk_buff *skb, struct Qdisc *sch, struct sk_buff **to_free)
 		/* We could use a bigger initial quantum for new flows */
 		slot->allot = q->quantum;
 	}
-	if (++sch->q.qlen <= q->limit)
+	qdisc_qlen_inc(sch);
+	if (sch->q.qlen <= q->limit)
 		return NET_XMIT_SUCCESS;
 
 	qlen = slot->qlen;
@@ -495,7 +496,7 @@ sfq_dequeue(struct Qdisc *sch)
 	skb = slot_dequeue_head(slot);
 	sfq_dec(q, a);
 	qdisc_bstats_update(sch, skb);
-	sch->q.qlen--;
+	qdisc_qlen_dec(sch);
 	qdisc_qstats_backlog_dec(sch, skb);
 	slot->backlog -= qdisc_pkt_len(skb);
 	/* Is the slot empty? */
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
index 8e375281195061da848fb2bfaf79cf125afccac0..885a9bc859166dfb6d20aa0dfbb8f11194e02ba9 100644
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
index ec4039a201a2c2c502bc649fa5f6a0e4feee8fd5..bd10da46f5ddbc53f914648066dab526c8064e55 100644
--- a/net/sched/sch_teql.c
+++ b/net/sched/sch_teql.c
@@ -107,7 +107,7 @@ teql_dequeue(struct Qdisc *sch)
 	} else {
 		qdisc_bstats_update(sch, skb);
 	}
-	sch->q.qlen = dat->q.qlen + q->q.qlen;
+	WRITE_ONCE(sch->q.qlen, dat->q.qlen + q->q.qlen);
 	return skb;
 }
 
-- 
2.53.0.1213.gd9a14994de-goog



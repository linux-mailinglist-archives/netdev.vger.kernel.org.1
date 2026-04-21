Return-Path: <netdev+bounces-280154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UC6jJH+L52lY9wEAu9opvQ
	(envelope-from <netdev+bounces-280154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:36:47 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D2D43C228
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:36:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F2BD9302D528
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:29:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 574A43D75C5;
	Tue, 21 Apr 2026 14:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iCyDKbVn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F3330E0E5
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781789; cv=none; b=Bb1aHDBXHji6ZuD1jslvGZpnCeIMLPSj9NjCgzX0TCQ9vJSW62uwBeyhyBqUBaTzvQ2iy6lNxBzl2129uGB/F+j49UUmII3gQPwmQu3vGLNFDt2DqeNyMN2GY2571ZfJ1q+S8ZOQ6QxMFwWaZvqbvxCVKBN0uTdhtDGCxPtBbsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781789; c=relaxed/simple;
	bh=0sVBQdXKRDkJSG8meZQ/pBjSftRkZl7LQGy0n05ApBA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=OrWoSfhzpzBvVGWxrYHlWaWPYeFJhpEezb561IxovGON7pfOO8pNiQnlfS3doIHELSRUI0qla0opcVqAvXMnsRek41QdTnqEwTB7/A9RiiXTXIJPxINVBue26hPaAGxR6wr7WLSfXTAJ3mZCQbs9LxCzOpH5HkapSWld2ofvc5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iCyDKbVn; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cb6291d95aso718344185a.1
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776781787; x=1777386587; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jvck/XoB8H/Wh1zgGi1810Si1lrAtzcUaSDMkL0ZmR0=;
        b=iCyDKbVnSZKP44mK/zS7LiAbUlkCX1o+phS1n/fq+aB/DjscTJ/IwYfLT3lE+C2IJu
         7dWW/3EfHUIWX3cEKXkYYHFUVijlOjw8CcDHgLcNjU3TIAvbyTfx77jfcUDUEvgQacer
         vFC/xwCARWv/ByLedR9VK7itsDMrZOUBgLtoo3nsEjni9oM3+93QOMyL08cDpgsDZvuO
         wX2/UROuh0W6TXgi/Sigc+Rv5JQC8aDB0uXyUdEmBfv02YxT7CVGzyj0ee5Z8tZe6r/J
         jtz6ta4TB2op48kW5Xkv0/h/6oQ2EoqJxvSovTHE7T4igjNbp5UtG+EJZE4BPrQK8vch
         XhZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776781787; x=1777386587;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jvck/XoB8H/Wh1zgGi1810Si1lrAtzcUaSDMkL0ZmR0=;
        b=rlQ/jqe6rOovX7F11XvWDQ4A5KP36FA3iu1pSbGptR/13lz3cL04yqsf6f1dlvpxwd
         leehqqTqjVLyMrvEHVFylOs56DOJDX7Fw/xsphB/B5llJtghKlwn29DCgBnmEe/U7v+8
         sT3l5Fl7Qxemg2jIO8O+wG2WIfV6Fh2CVjptacK1D/GKWSxBczusOvaQlV880zNgpZT/
         f4yfCtkoh0QD0/lYQ8JdCYOKFaA3mYDrHTv1NbPOuWDPMUKwmXUnJizbYKr9e9NQMAa0
         xYKnJe4qwp5hC8k4XgMazAFZ/c9YaNzYAsiKiZXMhJDvFEhgcgznGfLv0gF78lnW+iXS
         NXnw==
X-Forwarded-Encrypted: i=1; AFNElJ/Ke7vAwR/nnA8Gd5vlStul52yzWyVgcNgo4W/fBziy/qeFXFEHHYXSFt8tlukQj7mANG+yD9I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzP9cRLXWDHo1nDUx9PM28tWzEa5/A9a+D76ioC+Y1MWZB22V+J
	wM5ml+hq2Mjv69zouCZsO5n8FGu7aTaoaXeyzNLI2HNDrGg8zSbV9kEUPZ3DB28ZF/v2wrnpR+u
	sOjjGE8rhQlhtqg==
X-Received: from qkjw1.prod.google.com ([2002:a05:620a:1481:b0:8cd:8ec2:8228])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3720:b0:8cf:dfc9:c09c with SMTP id af79cd13be357-8e78f253c25mr2697155385a.10.1776781786327;
 Tue, 21 Apr 2026 07:29:46 -0700 (PDT)
Date: Tue, 21 Apr 2026 14:29:44 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421142944.4009941-1-edumazet@google.com>
Subject: [PATCH net] net/sched: sch_pie: annotate data-races in pie_dump_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280154-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 17D2D43C228
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

pie_dump_stats() only runs with RTNL held,
reading fields that can be changed in qdisc fast path.

Add READ_ONCE()/WRITE_ONCE() annotations.

Alternative would be to acquire the qdisc spinlock, but our long-term
goal is to make qdisc dump operations lockless as much as we can.

tc_pie_xstats fields don't need to be latched atomically,
otherwise this bug would have been caught earlier.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
 include/net/pie.h   |  2 +-
 net/sched/sch_pie.c | 38 +++++++++++++++++++-------------------
 2 files changed, 20 insertions(+), 20 deletions(-)

diff --git a/include/net/pie.h b/include/net/pie.h
index 01cbc66825a40bd21c0a044b1180cbbc346785df..1f3db0c355149b41823a891c9156cac625122031 100644
--- a/include/net/pie.h
+++ b/include/net/pie.h
@@ -104,7 +104,7 @@ static inline void pie_vars_init(struct pie_vars *vars)
 	vars->dq_tstamp = DTIME_INVALID;
 	vars->accu_prob = 0;
 	vars->dq_count = DQCOUNT_INVALID;
-	vars->avg_dq_rate = 0;
+	WRITE_ONCE(vars->avg_dq_rate, 0);
 }
 
 static inline struct pie_skb_cb *get_pie_cb(const struct sk_buff *skb)
diff --git a/net/sched/sch_pie.c b/net/sched/sch_pie.c
index 16f3f629cb8e4be71431f7e50a278e3c7fdba8d0..fb53fbf0e328571be72b66ba4e75a938e1963422 100644
--- a/net/sched/sch_pie.c
+++ b/net/sched/sch_pie.c
@@ -90,7 +90,7 @@ static int pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 	bool enqueue = false;
 
 	if (unlikely(qdisc_qlen(sch) >= sch->limit)) {
-		q->stats.overlimit++;
+		WRITE_ONCE(q->stats.overlimit, q->stats.overlimit + 1);
 		goto out;
 	}
 
@@ -104,7 +104,7 @@ static int pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		/* If packet is ecn capable, mark it if drop probability
 		 * is lower than 10%, else drop it.
 		 */
-		q->stats.ecn_mark++;
+		WRITE_ONCE(q->stats.ecn_mark, q->stats.ecn_mark + 1);
 		enqueue = true;
 	}
 
@@ -114,15 +114,15 @@ static int pie_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (!q->params.dq_rate_estimator)
 			pie_set_enqueue_time(skb);
 
-		q->stats.packets_in++;
+		WRITE_ONCE(q->stats.packets_in, q->stats.packets_in + 1);
 		if (qdisc_qlen(sch) > q->stats.maxq)
-			q->stats.maxq = qdisc_qlen(sch);
+			WRITE_ONCE(q->stats.maxq, qdisc_qlen(sch));
 
 		return qdisc_enqueue_tail(skb, sch);
 	}
 
 out:
-	q->stats.dropped++;
+	WRITE_ONCE(q->stats.dropped, q->stats.dropped + 1);
 	q->vars.accu_prob = 0;
 	return qdisc_drop_reason(skb, sch, to_free, reason);
 }
@@ -267,11 +267,11 @@ void pie_process_dequeue(struct sk_buff *skb, struct pie_params *params,
 			count = count / dtime;
 
 			if (vars->avg_dq_rate == 0)
-				vars->avg_dq_rate = count;
+				WRITE_ONCE(vars->avg_dq_rate, count);
 			else
-				vars->avg_dq_rate =
+				WRITE_ONCE(vars->avg_dq_rate,
 				    (vars->avg_dq_rate -
-				     (vars->avg_dq_rate >> 3)) + (count >> 3);
+				     (vars->avg_dq_rate >> 3)) + (count >> 3));
 
 			/* If the queue has receded below the threshold, we hold
 			 * on to the last drain rate calculated, else we reset
@@ -381,7 +381,7 @@ void pie_calculate_probability(struct pie_params *params, struct pie_vars *vars,
 	if (delta > 0) {
 		/* prevent overflow */
 		if (vars->prob < oldprob) {
-			vars->prob = MAX_PROB;
+			WRITE_ONCE(vars->prob, MAX_PROB);
 			/* Prevent normalization error. If probability is at
 			 * maximum value already, we normalize it here, and
 			 * skip the check to do a non-linear drop in the next
@@ -392,7 +392,7 @@ void pie_calculate_probability(struct pie_params *params, struct pie_vars *vars,
 	} else {
 		/* prevent underflow */
 		if (vars->prob > oldprob)
-			vars->prob = 0;
+			WRITE_ONCE(vars->prob, 0);
 	}
 
 	/* Non-linear drop in probability: Reduce drop probability quickly if
@@ -403,7 +403,7 @@ void pie_calculate_probability(struct pie_params *params, struct pie_vars *vars,
 		/* Reduce drop probability to 98.4% */
 		vars->prob -= vars->prob / 64;
 
-	vars->qdelay = qdelay;
+	WRITE_ONCE(vars->qdelay, qdelay);
 	vars->backlog_old = backlog;
 
 	/* We restart the measurement cycle if the following conditions are met
@@ -502,21 +502,21 @@ static int pie_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 	struct pie_sched_data *q = qdisc_priv(sch);
 	struct tc_pie_xstats st = {
 		.prob		= q->vars.prob << BITS_PER_BYTE,
-		.delay		= ((u32)PSCHED_TICKS2NS(q->vars.qdelay)) /
+		.delay		= ((u32)PSCHED_TICKS2NS(READ_ONCE(q->vars.qdelay))) /
 				   NSEC_PER_USEC,
-		.packets_in	= q->stats.packets_in,
-		.overlimit	= q->stats.overlimit,
-		.maxq		= q->stats.maxq,
-		.dropped	= q->stats.dropped,
-		.ecn_mark	= q->stats.ecn_mark,
+		.packets_in	= READ_ONCE(q->stats.packets_in),
+		.overlimit	= READ_ONCE(q->stats.overlimit),
+		.maxq		= READ_ONCE(q->stats.maxq),
+		.dropped	= READ_ONCE(q->stats.dropped),
+		.ecn_mark	= READ_ONCE(q->stats.ecn_mark),
 	};
 
 	/* avg_dq_rate is only valid if dq_rate_estimator is enabled */
 	st.dq_rate_estimating = q->params.dq_rate_estimator;
 
 	/* unscale and return dq_rate in bytes per sec */
-	if (q->params.dq_rate_estimator)
-		st.avg_dq_rate = q->vars.avg_dq_rate *
+	if (st.dq_rate_estimating)
+		st.avg_dq_rate = READ_ONCE(q->vars.avg_dq_rate) *
 				 (PSCHED_TICKS_PER_SEC) >> PIE_SCALE;
 
 	return gnet_stats_copy_app(d, &st, sizeof(st));
-- 
2.54.0.rc2.533.g4f5dca5207-goog



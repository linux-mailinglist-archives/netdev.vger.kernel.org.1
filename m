Return-Path: <netdev+bounces-277516-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SLtBAe9B2WnCnwgAu9opvQ
	(envelope-from <netdev+bounces-277516-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:31:11 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E03803DB75D
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:31:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C56FD300B8C5
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA12B34A3C9;
	Fri, 10 Apr 2026 18:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QdMdZiVK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f74.google.com (mail-oa1-f74.google.com [209.85.160.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE743358A7
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845865; cv=none; b=ow8qyLNZQnRYa4UvbWnG8y7Fay78jpkTmWvwGThC9xn7UEarR9797Dplx3buxN+ITTWH6G6TmwKjbsiGRrM2ljG1gxC86IDd5TtjSQT10DLit6oULUSeNwShdGc21i05hrcwCGVkeEhAYCgVGQrGnx+l2PzuO2fdwbSEAudX1eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845865; c=relaxed/simple;
	bh=0Jv6SGfcpVsacEPF5QjrL9dxNpST2BQZr4Zs+hKmyxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=L6jqDGL+fioSN1Q59prQfoiSlFZ1kaxkaagoOQE8pjVB8kq6ck9AQGULPGtX0cjXEzl9Q5QiYFmH6joDocnI0eI9NvKrbbJ5AGKrXXxadKj6JxFe5KTMsuuGVgBt1y9nBa/tvjEYLDnlYsNB/ULZHwiJoUKQ6fatDGkuXsw/Tck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QdMdZiVK; arc=none smtp.client-ip=209.85.160.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-oa1-f74.google.com with SMTP id 586e51a60fabf-41c4709dd9dso4779662fac.3
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775845863; x=1776450663; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bh5JuSys2IuP+a3de4iHUe+dP0hDPALryouBLYyDnpY=;
        b=QdMdZiVKo/RUwGOQBp24hmHkwR0NQEld+tA8NbHxnJFbZoXmIvQeiGMxuCwrgxXCss
         +yby6GT1jCkWF9xmc+5nO2aNo9QKCvzL/hnI7sIuC8eLv/u7OtPE1qV/kAvhRa71WoLg
         iZJ3gXfA4UE+bJrgSNFJ8ONodfOxIDHJv6MQtdu4SBfRIPnHRaVjjrGESXjvgZ3tsdqt
         Wiy5kqGwSTka2q6DDCB7qxsN88XL8EkcVPrD/IMyLQNzWoMdkml4LxoMvB2I44pGDKTZ
         VIu6/M9pgE5ltzlmo15yowDxeYR19n7drpHuGN9jwvpyusXOhJ7HF7Mwr3/mlVdgvp/B
         eu9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845863; x=1776450663;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bh5JuSys2IuP+a3de4iHUe+dP0hDPALryouBLYyDnpY=;
        b=Q3Q12kdXzDuVOg0aUFdJ31SwljsPnsh50J0s6NEpYb8hOmlAZrhyGHMEfSZr+zazrd
         rPwmT00GhkNXTEyEe000mh4VBIxWWiOxImONU//qC2fpW5vcTGKZg+2Oxzvs6iktzutL
         f0j44fgP98aL/DJrWD0BIKLWwHtfK0YyHRBOpYvUI5KtEZ3xdzDiT1p3ekeF/b1TMZR1
         S1D2m5hDWeu3j4b57ZcR5+y8nJYVGkM3W5E/vx3/MovsKIfmwI7LlrgatvPUFAWZvOyE
         +a3kdb8P1pDBlywiLMuiNKpbv6uYis6lclgrx/gZlAYMe133og5tFpoSACAgTi83/K1C
         PRlw==
X-Forwarded-Encrypted: i=1; AJvYcCUWFpPxUOo7wu+6+Jkq0q2BQ/Ax+3zgcpiZsfd2mQbxkiTKpAZKmbERM+X4FD5NJWoE9+KGNFY=@vger.kernel.org
X-Gm-Message-State: AOJu0YymNWr55GrXRjxv8S9kQPz7FxPWq3VrB2O7mbSg6OLt5lOy6Int
	KcLMQp4ZKrVCN8wYgHjeEHkjMR6mQ0dakDj4lfPSYCr79ZSP0D7ZB9TwO7YEbe258ylig9NS8kC
	phLURa5A0MzAWnA==
X-Received: from qteb8.prod.google.com ([2002:ac8:4f08:0:b0:50d:b612:e1f0])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:134c:b0:50d:7f91:6bd5 with SMTP id d75a77b69052e-50dd5ad88f6mr68631411cf.18.1775845399982;
 Fri, 10 Apr 2026 11:23:19 -0700 (PDT)
Date: Fri, 10 Apr 2026 18:22:51 +0000
In-Reply-To: <20260410182257.774311-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410182257.774311-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410182257.774311-10-edumazet@google.com>
Subject: [PATCH v3 net-next 09/15] net/sched: sch_pie: annotate data-races in pie_dump_stats()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277516-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: E03803DB75D
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
2.53.0.1213.gd9a14994de-goog



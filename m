Return-Path: <netdev+bounces-276524-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UG7yHGBS1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276524-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:04:32 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6033BC8C3
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7FB6A30DF601
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:56:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D51A3C6619;
	Wed,  8 Apr 2026 12:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="t7y1Z+6A"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f73.google.com (mail-qv1-f73.google.com [209.85.219.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6563C6605
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652992; cv=none; b=szEqbfOdAcpjllw3fkgWGyIGr6KEtCo5XCYpwfq59L/0EnMa1X+6jVRelRN3saMwb5LrX88s9z29vUCWvO5Ys1yCz2pfs01Esnf2PyKpJ8cu4svIEhd8u44OmFkEcHJRZRxuAeP69O27ntG1QhtWFj92RC7esfE8/9z5QXHDdWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652992; c=relaxed/simple;
	bh=0Jv6SGfcpVsacEPF5QjrL9dxNpST2BQZr4Zs+hKmyxw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=DhvX4PHO6jsIMlFZkxn9RTzdkcSBj4Gc/QDRdPeXtTlZp39JkDgbW8n3Mr/CtOYnMkJe4Pwct47BdOupZYXqrf8/xrdtXSm116XZoCsLCdLVxLFrpiGKTtbqXI4JDfyTGjKnOKbUPZq3hPBmlBklik/fgNW8fg1ISd8qOCvlH/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=t7y1Z+6A; arc=none smtp.client-ip=209.85.219.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f73.google.com with SMTP id 6a1803df08f44-8a31df1907cso182345616d6.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:56:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775652990; x=1776257790; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bh5JuSys2IuP+a3de4iHUe+dP0hDPALryouBLYyDnpY=;
        b=t7y1Z+6ACiDegacagjpWYFI7zqKDzX6P3FYhEm2OUKNuhbJMuCLgtFfJ/AZdFMbhxW
         9xYdIjEPu1tbZms7e+80Tv9Qe/MVCDZQ10huXlmgye/+sa3ggEqkR25SkkLcjyyQLgYo
         L9riVU1c81VUSI3De69c4a26DmFDXUiLoN1duwZSP4fmTeLBmH+Rdf+f47C5ekTLxooP
         2j4M3nwB9kyeWPhziAvdk3O0k6Xx7tySiG8m0X49rU1mdPFYIsu/b45+Xzex67ngsXt1
         bxZkExr+q+8gVZTUfZQgkU0vIjzoXLurGE8E9ECewEII+ghrwJxDyaFhbkCPILeH2KoL
         nJGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652990; x=1776257790;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bh5JuSys2IuP+a3de4iHUe+dP0hDPALryouBLYyDnpY=;
        b=grhfKUdpYz/p1zLV8TUcyo+sf5E8SItyAb6ssvlFi4uTo9sxwsa9zb1kCpKv3St9Xz
         mjqxeg3vr35kYencowVizksSJ7l/sJr1RaoDJQmd9lYIOFeoZPIffVJNeTFKDOhoBz7o
         EUwYNOihQ67RZjWYnh8/OQtt8n5/mwHcERzeXp4gEw9jqPqNlcqGqXmms3xel3DQwWwx
         FTxmclvfeiMKizG5UtfaPnvS85zBGDAxJ9e/G5QmWWFH4gsesLayxlAUecmGtuwYmYfq
         kwMmo+RCMHwgL1uzqkkgBkHGtXnnhkKUPiNN5gQ47lOgkL1vw867GQhzySOelrqzHVaA
         9gZQ==
X-Forwarded-Encrypted: i=1; AJvYcCUI+x23vjp1q3v+HEOBsjNbiVrj+DhiNPGrBq8uh4Ytkwh+dWXGyCKjmnmOSu1PhTn8MyDDTrk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqDoy5IVHjQ8ZYqaCPBEljxj5u8A055bGKpnOpxCOeDD4asaVt
	BJhL8D30MESfCcXliVPBmt5W5RDUjWPkgyWAV07K2EHMe4PpmayXUN+1AOsoIj9T8lblbbx7Aru
	FUZd7x+K1gFfkWQ==
X-Received: from qvup9.prod.google.com ([2002:ad4:52e9:0:b0:89f:8a0c:fc6])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:5981:b0:8a2:3f80:2a22 with SMTP id 6a1803df08f44-8a704abbe41mr358836866d6.46.1775652989936;
 Wed, 08 Apr 2026 05:56:29 -0700 (PDT)
Date: Wed,  8 Apr 2026 12:56:05 +0000
In-Reply-To: <20260408125611.3592751-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408125611.3592751-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408125611.3592751-10-edumazet@google.com>
Subject: [PATCH net-next 09/15] net/sched: sch_pie: annotate data-races in pie_dump_stats()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276524-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF6033BC8C3
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



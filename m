Return-Path: <netdev+bounces-282668-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO/iOrv08mnNvwEAu9opvQ
	(envelope-from <netdev+bounces-282668-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:20:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F6FA49E024
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 08:20:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0D05D3079229
	for <lists+netdev@lfdr.de>; Thu, 30 Apr 2026 06:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE6E23E330;
	Thu, 30 Apr 2026 06:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PJcjy2HV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD723372B4F
	for <netdev@vger.kernel.org>; Thu, 30 Apr 2026 06:16:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777529782; cv=none; b=nrgfLQaHuGXKTLx4qg+BGhN2IJ09cP4DGnzr6udmv70Oyhq3DCMK4JBe2kZjeNEDk0bJENoEcw2meCBzjgi26INY1N+jcW7kITYHr4FeEBydizXSpKrUtUU3JG6DQ+FuzVApY/86un5BnLr6koggsyETY9zf07eUwTaMfVMg5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777529782; c=relaxed/simple;
	bh=EwKguQHcYVOZf1q+mNWMh0C1GDcuoDfwk1HVTGRUuAg=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XG8fbaL0PktLin7ZlaiOz6vFXmAj1QRc0lWJqwhhONcH6z3IY/b7+NJ2eap6wi64A/yyQFa5irKJQyECQxIOgWZRnsa/+eBn6hus3/2sU4OZlGvekgvCz+ywzpYmOCN8u47zFo4KraK9ziN+xx/kDoc9IfE1T8cPk1dWpVKEc+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PJcjy2HV; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8f9e55c40a5so69678085a.3
        for <netdev@vger.kernel.org>; Wed, 29 Apr 2026 23:16:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1777529780; x=1778134580; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=juFc9ZGJFjBZi/NqWauZ61qvxKz7qoCHSFAnSDasH0g=;
        b=PJcjy2HVALQ3wybPdcI8+W9hDfQuG76su/oSQoMbMKDQKSXEeFLskzRmIwPk3Rvg8T
         QUIQAF5+ya5PoKm9endjeOwetD82F5J07yvz9yq7PaPehJoY7CRARZ0bEpr8p+24YdVE
         UYs1OeliYqwu1MapoGrbc7fVG7brMA97WceUPlXV9zraOZXzZfg8sz10yMNQPrGhF8j0
         387b4qwbGX7eDl0zQQ242xLEZ5bMz8qKmy8UbzBhVC/eSpkdV1tLtEsq/37VO3mTuo0m
         u9qOSa2hnM07pp2Xt2rk5saEey9EHZOkLpMNKV8swaMalrFDVOIOLT+NoVCzUhFyNjEh
         JDoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777529780; x=1778134580;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=juFc9ZGJFjBZi/NqWauZ61qvxKz7qoCHSFAnSDasH0g=;
        b=tMyA/nD5MNpHNp9vI6GW3JUdMqdeUIbUQvA/cfowmkLkh2nuZSisiaFY3ccs6+vpds
         sRG8U0SShOqCnBQ/QoQLLVlNokVTK+jASugdUxTp8WGpb8b6H7RKnnHiQNdP++ydd6pp
         FAEoDHrCzchi4pnFZMIT7L7T2BPibwyc7Ic1UmY7lrsTaLjoNpa88//yP7fVaKqz+2OB
         Q6a7t48RViAFx5Sz22rbLBHR/x/OyJgoXmYllQXAIeWv9LMdDr8GotqzsVWVBtA/16jA
         hK78biRJtstxmNW1ZboTgXKmlb/jAgBPo/4cMgIF8mssvdH2tnuAAnJHC5uIWPCpkfAi
         eSmQ==
X-Forwarded-Encrypted: i=1; AFNElJ+/6DPkCIs23kT4IHKkdGGfFELuyuX+ng2ni1Y1Kq77JqcxqbezCfK+hrYawZq3n7xMNM44C1U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxO+s7krGq/DYD1+hwdGnAnHC7JWDt/183W63A1/kps2Yh4nVX
	M5teUdiWSFuyhUFHRx3qQvcdDTqPqPMm3ssRor4frNy4QskePdYz+ZignRBiPZA7XeidIwBFuRB
	18HVXTBWybrtYQg==
X-Received: from qkbi3.prod.google.com ([2002:a05:620a:5203:b0:8cd:73d8:9b39])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:1a1d:b0:8f4:3a1a:d899 with SMTP id af79cd13be357-8fa8a0de04cmr259734985a.59.1777529779725;
 Wed, 29 Apr 2026 23:16:19 -0700 (PDT)
Date: Thu, 30 Apr 2026 06:16:10 +0000
In-Reply-To: <20260430061610.3503483-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260430061610.3503483-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
Message-ID: <20260430061610.3503483-3-edumazet@google.com>
Subject: [PATCH net 2/2] net/sched: sch_cake: annotate data-races in
 cake_dump_class_stats (II)
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 8F6FA49E024
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
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,toke.dk,resnulli.us,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-282668-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.991];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

cake_dump_class_stats() runs without qdisc spinlock being held.

In this second patch, I add READ_ONCE()/WRITE_ONCE() annotations for:

- flow->deficit
- flow->cvars.dropping
- flow->cvars.count
- flow->cvars.p_drop
- flow->cvars.blue_timer
- flow->cvars.drop_next

Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) qdisc")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_cake.c | 131 +++++++++++++++++++++++--------------------
 1 file changed, 71 insertions(+), 60 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 806eb73d6a05e1a7391e4bef55d6aca5052bb8ab..5862933be8d746bf222e6aa2ad5c9433757c9b07 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -399,14 +399,14 @@ static void cake_configure_rates(struct Qdisc *sch, u64 rate, bool rate_adjust);
  * Here, invsqrt is a fixed point number (< 1.0), 32bit mantissa, aka Q0.32
  */
 
-static void cobalt_newton_step(struct cobalt_vars *vars)
+static void cobalt_newton_step(struct cobalt_vars *vars, u32 count)
 {
 	u32 invsqrt, invsqrt2;
 	u64 val;
 
 	invsqrt = vars->rec_inv_sqrt;
 	invsqrt2 = ((u64)invsqrt * invsqrt) >> 32;
-	val = (3LL << 32) - ((u64)vars->count * invsqrt2);
+	val = (3LL << 32) - ((u64)count * invsqrt2);
 
 	val >>= 2; /* avoid overflow in following multiply */
 	val = (val * invsqrt) >> (32 - 2 + 1);
@@ -414,12 +414,12 @@ static void cobalt_newton_step(struct cobalt_vars *vars)
 	vars->rec_inv_sqrt = val;
 }
 
-static void cobalt_invsqrt(struct cobalt_vars *vars)
+static void cobalt_invsqrt(struct cobalt_vars *vars, u32 count)
 {
-	if (vars->count < REC_INV_SQRT_CACHE)
-		vars->rec_inv_sqrt = inv_sqrt_cache[vars->count];
+	if (count < REC_INV_SQRT_CACHE)
+		vars->rec_inv_sqrt = inv_sqrt_cache[count];
 	else
-		cobalt_newton_step(vars);
+		cobalt_newton_step(vars, count);
 }
 
 static void cobalt_vars_init(struct cobalt_vars *vars)
@@ -449,16 +449,19 @@ static bool cobalt_queue_full(struct cobalt_vars *vars,
 	bool up = false;
 
 	if (ktime_to_ns(ktime_sub(now, vars->blue_timer)) > p->target) {
-		up = !vars->p_drop;
-		vars->p_drop += p->p_inc;
-		if (vars->p_drop < p->p_inc)
-			vars->p_drop = ~0;
-		vars->blue_timer = now;
-	}
-	vars->dropping = true;
-	vars->drop_next = now;
+		u32 p_drop = vars->p_drop;
+
+		up = !p_drop;
+		p_drop += p->p_inc;
+		if (p_drop < p->p_inc)
+			p_drop = ~0;
+		WRITE_ONCE(vars->p_drop, p_drop);
+		WRITE_ONCE(vars->blue_timer, now);
+	}
+	WRITE_ONCE(vars->dropping, true);
+	WRITE_ONCE(vars->drop_next, now);
 	if (!vars->count)
-		vars->count = 1;
+		WRITE_ONCE(vars->count, 1);
 
 	return up;
 }
@@ -475,20 +478,20 @@ static bool cobalt_queue_empty(struct cobalt_vars *vars,
 	if (vars->p_drop &&
 	    ktime_to_ns(ktime_sub(now, vars->blue_timer)) > p->target) {
 		if (vars->p_drop < p->p_dec)
-			vars->p_drop = 0;
+			WRITE_ONCE(vars->p_drop, 0);
 		else
-			vars->p_drop -= p->p_dec;
-		vars->blue_timer = now;
+			WRITE_ONCE(vars->p_drop, vars->p_drop - p->p_dec);
+		WRITE_ONCE(vars->blue_timer, now);
 		down = !vars->p_drop;
 	}
-	vars->dropping = false;
+	WRITE_ONCE(vars->dropping, false);
 
 	if (vars->count && ktime_to_ns(ktime_sub(now, vars->drop_next)) >= 0) {
-		vars->count--;
-		cobalt_invsqrt(vars);
-		vars->drop_next = cobalt_control(vars->drop_next,
-						 p->interval,
-						 vars->rec_inv_sqrt);
+		WRITE_ONCE(vars->count, vars->count - 1);
+		cobalt_invsqrt(vars, vars->count);
+		WRITE_ONCE(vars->drop_next,
+			   cobalt_control(vars->drop_next, p->interval,
+					  vars->rec_inv_sqrt));
 	}
 
 	return down;
@@ -507,6 +510,7 @@ static enum qdisc_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
 	bool next_due, over_target;
 	ktime_t schedule;
 	u64 sojourn;
+	u32 count;
 
 /* The 'schedule' variable records, in its sign, whether 'now' is before or
  * after 'drop_next'.  This allows 'drop_next' to be updated before the next
@@ -528,21 +532,22 @@ static enum qdisc_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
 	over_target = sojourn > p->target &&
 		      sojourn > p->mtu_time * bulk_flows * 2 &&
 		      sojourn > p->mtu_time * 4;
-	next_due = vars->count && ktime_to_ns(schedule) >= 0;
+	count = vars->count;
+	next_due = count && ktime_to_ns(schedule) >= 0;
 
 	vars->ecn_marked = false;
 
 	if (over_target) {
 		if (!vars->dropping) {
-			vars->dropping = true;
-			vars->drop_next = cobalt_control(now,
-							 p->interval,
-							 vars->rec_inv_sqrt);
+			WRITE_ONCE(vars->dropping, true);
+			WRITE_ONCE(vars->drop_next,
+				   cobalt_control(now, p->interval,
+						  vars->rec_inv_sqrt));
 		}
-		if (!vars->count)
-			vars->count = 1;
+		if (!count)
+			count = 1;
 	} else if (vars->dropping) {
-		vars->dropping = false;
+		WRITE_ONCE(vars->dropping, false);
 	}
 
 	if (next_due && vars->dropping) {
@@ -550,23 +555,23 @@ static enum qdisc_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
 		if (!(vars->ecn_marked = INET_ECN_set_ce(skb)))
 			reason = QDISC_DROP_CONGESTED;
 
-		vars->count++;
-		if (!vars->count)
-			vars->count--;
-		cobalt_invsqrt(vars);
-		vars->drop_next = cobalt_control(vars->drop_next,
-						 p->interval,
-						 vars->rec_inv_sqrt);
+		count++;
+		if (!count)
+			count--;
+		cobalt_invsqrt(vars, count);
+		WRITE_ONCE(vars->drop_next,
+			   cobalt_control(vars->drop_next, p->interval,
+					  vars->rec_inv_sqrt));
 		schedule = ktime_sub(now, vars->drop_next);
 	} else {
 		while (next_due) {
-			vars->count--;
-			cobalt_invsqrt(vars);
-			vars->drop_next = cobalt_control(vars->drop_next,
-							 p->interval,
-							 vars->rec_inv_sqrt);
+			count--;
+			cobalt_invsqrt(vars, count);
+			WRITE_ONCE(vars->drop_next,
+				   cobalt_control(vars->drop_next, p->interval,
+						  vars->rec_inv_sqrt));
 			schedule = ktime_sub(now, vars->drop_next);
-			next_due = vars->count && ktime_to_ns(schedule) >= 0;
+			next_due = count && ktime_to_ns(schedule) >= 0;
 		}
 	}
 
@@ -575,11 +580,12 @@ static enum qdisc_drop_reason cobalt_should_drop(struct cobalt_vars *vars,
 	    get_random_u32() < vars->p_drop)
 		reason = QDISC_DROP_FLOOD_PROTECTION;
 
+	WRITE_ONCE(vars->count, count);
 	/* Overload the drop_next field as an activity timeout */
-	if (!vars->count)
-		vars->drop_next = ktime_add_ns(now, p->interval);
+	if (!count)
+		WRITE_ONCE(vars->drop_next, ktime_add_ns(now, p->interval));
 	else if (ktime_to_ns(schedule) > 0 && reason == QDISC_DROP_UNSPEC)
-		vars->drop_next = now;
+		WRITE_ONCE(vars->drop_next, now);
 
 	return reason;
 }
@@ -1924,7 +1930,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		flow->set = CAKE_SET_SPARSE;
 		WRITE_ONCE(b->sparse_flow_count, b->sparse_flow_count + 1);
 
-		flow->deficit = cake_get_flow_quantum(b, flow, q->config->flow_mode);
+		WRITE_ONCE(flow->deficit, cake_get_flow_quantum(b, flow, q->config->flow_mode));
 	} else if (flow->set == CAKE_SET_SPARSE_WAIT) {
 		/* this flow was empty, accounted as a sparse flow, but actually
 		 * in the bulk rotation.
@@ -2166,7 +2172,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 			}
 		}
 
-		flow->deficit += cake_get_flow_quantum(b, flow, q->config->flow_mode);
+		WRITE_ONCE(flow->deficit,
+			   flow->deficit + cake_get_flow_quantum(b, flow, q->config->flow_mode));
 		list_move_tail(&flow->flowchain, &b->old_flows);
 
 		goto retry;
@@ -2232,7 +2239,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 		if (q->config->rate_flags & CAKE_FLAG_INGRESS) {
 			len = cake_advance_shaper(q, b, skb,
 						  now, true);
-			flow->deficit -= len;
+			WRITE_ONCE(flow->deficit, flow->deficit - len);
 			b->tin_deficit -= len;
 		}
 		WRITE_ONCE(flow->dropped, flow->dropped + 1);
@@ -2259,7 +2266,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch)
 			     delay < b->base_delay ? 2 : 8));
 
 	len = cake_advance_shaper(q, b, skb, now, false);
-	flow->deficit -= len;
+	WRITE_ONCE(flow->deficit, flow->deficit - len);
 	b->tin_deficit -= len;
 
 	if (ktime_after(q->time_next_packet, now) && sch->q.qlen) {
@@ -3153,6 +3160,8 @@ static int cake_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 		return -1;
 	if (flow) {
 		ktime_t now = ktime_get();
+		bool dropping;
+		u32 p_drop;
 
 		stats = nla_nest_start_noflag(d->skb, TCA_STATS_APP);
 		if (!stats)
@@ -3167,21 +3176,23 @@ static int cake_dump_class_stats(struct Qdisc *sch, unsigned long cl,
 			goto nla_put_failure;			       \
 	} while (0)
 
-		PUT_STAT_S32(DEFICIT, flow->deficit);
-		PUT_STAT_U32(DROPPING, flow->cvars.dropping);
-		PUT_STAT_U32(COBALT_COUNT, flow->cvars.count);
-		PUT_STAT_U32(P_DROP, flow->cvars.p_drop);
-		if (flow->cvars.p_drop) {
+		PUT_STAT_S32(DEFICIT, READ_ONCE(flow->deficit));
+		dropping = READ_ONCE(flow->cvars.dropping);
+		PUT_STAT_U32(DROPPING, dropping);
+		PUT_STAT_U32(COBALT_COUNT, READ_ONCE(flow->cvars.count));
+		p_drop = READ_ONCE(flow->cvars.p_drop);
+		PUT_STAT_U32(P_DROP, p_drop);
+		if (p_drop) {
 			PUT_STAT_S32(BLUE_TIMER_US,
 				     ktime_to_us(
 					     ktime_sub(now,
-						       flow->cvars.blue_timer)));
+						       READ_ONCE(flow->cvars.blue_timer))));
 		}
-		if (flow->cvars.dropping) {
+		if (dropping) {
 			PUT_STAT_S32(DROP_NEXT_US,
 				     ktime_to_us(
 					     ktime_sub(now,
-						       flow->cvars.drop_next)));
+						       READ_ONCE(flow->cvars.drop_next))));
 		}
 
 		if (nla_nest_end(d->skb, stats) < 0)
-- 
2.54.0.545.g6539524ca2-goog



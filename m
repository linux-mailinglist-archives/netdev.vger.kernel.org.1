Return-Path: <netdev+bounces-276528-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKdBNNpQ1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276528-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:58:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8C43BC7B4
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 14:58:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E6B003021D1E
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:56:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62883C73E1;
	Wed,  8 Apr 2026 12:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLYm4FbH"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DBD63C4540
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775653000; cv=none; b=nwxU+6+E6r2hJRRoBvpOV2ZWjJ1YSbYU8brx0NcJL2kj/eIt+CKkBTOaaHkNijNf4nT0UXYXyatWYFYPQhNytcjhoB/KJFg/C5TQiz+Cl1S0mKP9HZ9Rk8Bnd0jKBQgiSfq0+aks3E+zv0Pbjje4IPaTBSaWz8R9qbk6eOOMlEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775653000; c=relaxed/simple;
	bh=NfOxD0h4CtDAskAa+3TOG7Mwu2U8dxP8+6lZBWHtkmw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bqYq2I4EWHIXdacaKKV7CahPiMx7kN61hgEssVrD84BAFBQhiapJIcWKJmtFI2hHJXSIJcaMdVBrJ4SVbqsa4vnZlUgzP3YaLfChH70wBYYLUltLnUa+l4t9vHyMr2461XG9cmvbwXcILas9u26wJFLWsBmjgnFdZ7STnKrwSNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vLYm4FbH; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8d65190e52fso773748885a.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775652997; x=1776257797; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bY59M7Escasv3T4MEOMnQ941NX/tWYjuY+wUfYgTEI=;
        b=vLYm4FbHDgyxAJjDThs7y/kUu86WESAi0nMhmSZA6IWTyKv479Rtrzgiuzx3KP2IO+
         hJdA2B5hAc+7x8h/qIjmm43jfw98kJXADLsQ5tRSQo5fGKduIeQAtjeYzGs9xIRmPnqc
         SpM//1PXuxDZUfgS9b2hp1AVgq7BoBWJ5QE4IlUoH6LINWHm3fCUOfcZEQmnxECHLt1m
         RSiFwwnH7/8T5cuG9Nzijngm9hvFWiAcjlFntMKbE/oPpQBA5Etw+R5IAtGPEoskoB12
         zRcUA264BTYIa+p7c7rl7lkLG2af/lug/9Vl3qTgZK6a98lzAu+NJVaqqGW8G6uSw/XB
         npVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652997; x=1776257797;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7bY59M7Escasv3T4MEOMnQ941NX/tWYjuY+wUfYgTEI=;
        b=ODXfNmXPplFIjGZ3TvHVfM3/pxJcMdGGNqD658qv7spHWrCjLAjgcupkdBeD1tzVQJ
         hLa6XFBYQA7R8Bds7KdU+JEd6VkCmbMPIzdZq5aJD9s7v0QbBbb454qmjmRIVxW7UPJ9
         0R9JHkw7sTK35L3VhyaoXbf83S9a4NknzfYIg8CuVRfi4rl7h6Z9v0AC2SiO5Pfr8cIW
         RGQpyeJDxNz/DmP3S805bDy+dyYVKmhTvTiiB6zeSKTRwrX65USVDb5gFgLyqiby7hS5
         I+eHrnDO996RL6aYQyLEW7KR6uDiHlk7ASHhsK3SifzW9cSEJdARGpegkSUdLsM4ppkI
         ak1g==
X-Forwarded-Encrypted: i=1; AJvYcCUtn5enTPlr8QowmthEEi+8jIzmT6BWsNBVUi2KjHstSAtNJCHbqiUHMhcZPTO0uwW4s/QGpMY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGqYGTOyt3HqF8KcuSpiN2uDZ6Z4RmrhTRkRpaIY/hgz9hlLqn
	2KET22PRXkQ/gj3Z48sGgLDzQit1nL5j8Pn2ktt5+yblE6eU/B/Gfu+Zcdb7ktLPfC/3MSfE04Z
	S5F8QrqSzZ7GZSQ==
X-Received: from qkjz28.prod.google.com ([2002:a05:620a:101c:b0:8d4:5b2f:b8bb])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:171f:b0:8db:7315:7077 with SMTP id af79cd13be357-8db731572e6mr210558485a.62.1775652997162;
 Wed, 08 Apr 2026 05:56:37 -0700 (PDT)
Date: Wed,  8 Apr 2026 12:56:09 +0000
In-Reply-To: <20260408125611.3592751-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408125611.3592751-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408125611.3592751-14-edumazet@google.com>
Subject: [PATCH net-next 13/15] net/sched: sch_cake: annotate data-races in cake_dump_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com,toke.dk];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276528-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,toke.dk:email]
X-Rspamd-Queue-Id: 4C8C43BC7B4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cake_dump_stats() and cake_dump_class_stats() run without qdisc
spinlock being held.

Add READ_ONCE()/WRITE_ONCE() annotations.

Fixes: 046f6fd5daef ("sched: Add Common Applications Kept Enhanced (cake) q=
disc")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: "Toke H=C3=B8iland-J=C3=B8rgensen" <toke@toke.dk>
---
 net/sched/sch_cake.c | 337 ++++++++++++++++++++++++-------------------
 1 file changed, 189 insertions(+), 148 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 0104c29b20f8e43ffa025f0eb58bfe4e2b801010..fcc3c6b1044f324b399c9e80340=
fea3429e37c16 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -449,14 +449,17 @@ static bool cobalt_queue_full(struct cobalt_vars *var=
s,
 	bool up =3D false;
=20
 	if (ktime_to_ns(ktime_sub(now, vars->blue_timer)) > p->target) {
-		up =3D !vars->p_drop;
-		vars->p_drop +=3D p->p_inc;
-		if (vars->p_drop < p->p_inc)
-			vars->p_drop =3D ~0;
-		vars->blue_timer =3D now;
-	}
-	vars->dropping =3D true;
-	vars->drop_next =3D now;
+		u32 p_drop =3D vars->p_drop;
+
+		up =3D !p_drop;
+		p_drop +=3D p->p_inc;
+		if (p_drop < p->p_inc)
+			p_drop =3D ~0;
+		WRITE_ONCE(vars->p_drop, p_drop);
+		WRITE_ONCE(vars->blue_timer, now);
+	}
+	WRITE_ONCE(vars->dropping, true);
+	WRITE_ONCE(vars->drop_next, now);
 	if (!vars->count)
 		vars->count =3D 1;
=20
@@ -474,21 +477,25 @@ static bool cobalt_queue_empty(struct cobalt_vars *va=
rs,
=20
 	if (vars->p_drop &&
 	    ktime_to_ns(ktime_sub(now, vars->blue_timer)) > p->target) {
-		if (vars->p_drop < p->p_dec)
-			vars->p_drop =3D 0;
+		u32 p_drop =3D vars->p_drop;
+
+		if (p_drop < p->p_dec)
+			p_drop =3D 0;
 		else
-			vars->p_drop -=3D p->p_dec;
-		vars->blue_timer =3D now;
-		down =3D !vars->p_drop;
+			p_drop -=3D p->p_dec;
+		WRITE_ONCE(vars->p_drop, p_drop);
+		WRITE_ONCE(vars->blue_timer, now);
+		down =3D !p_drop;
 	}
-	vars->dropping =3D false;
+	WRITE_ONCE(vars->dropping, false);
=20
 	if (vars->count && ktime_to_ns(ktime_sub(now, vars->drop_next)) >=3D 0) {
 		vars->count--;
 		cobalt_invsqrt(vars);
-		vars->drop_next =3D cobalt_control(vars->drop_next,
-						 p->interval,
-						 vars->rec_inv_sqrt);
+		WRITE_ONCE(vars->drop_next,
+			   cobalt_control(vars->drop_next,
+					  p->interval,
+					  vars->rec_inv_sqrt));
 	}
=20
 	return down;
@@ -534,37 +541,41 @@ static enum qdisc_drop_reason cobalt_should_drop(stru=
ct cobalt_vars *vars,
=20
 	if (over_target) {
 		if (!vars->dropping) {
-			vars->dropping =3D true;
-			vars->drop_next =3D cobalt_control(now,
-							 p->interval,
-							 vars->rec_inv_sqrt);
+			WRITE_ONCE(vars->dropping, true);
+			WRITE_ONCE(vars->drop_next,
+				   cobalt_control(now,
+						  p->interval,
+						  vars->rec_inv_sqrt));
 		}
 		if (!vars->count)
 			vars->count =3D 1;
 	} else if (vars->dropping) {
-		vars->dropping =3D false;
+		WRITE_ONCE(vars->dropping, false);
 	}
=20
 	if (next_due && vars->dropping) {
 		/* Use ECN mark if possible, otherwise drop */
-		if (!(vars->ecn_marked =3D INET_ECN_set_ce(skb)))
+		vars->ecn_marked =3D INET_ECN_set_ce(skb);
+		if (!vars->ecn_marked)
 			reason =3D QDISC_DROP_CONGESTED;
=20
 		vars->count++;
 		if (!vars->count)
 			vars->count--;
 		cobalt_invsqrt(vars);
-		vars->drop_next =3D cobalt_control(vars->drop_next,
-						 p->interval,
-						 vars->rec_inv_sqrt);
+		WRITE_ONCE(vars->drop_next,
+			   cobalt_control(vars->drop_next,
+					  p->interval,
+					  vars->rec_inv_sqrt));
 		schedule =3D ktime_sub(now, vars->drop_next);
 	} else {
 		while (next_due) {
 			vars->count--;
 			cobalt_invsqrt(vars);
-			vars->drop_next =3D cobalt_control(vars->drop_next,
-							 p->interval,
-							 vars->rec_inv_sqrt);
+			WRITE_ONCE(vars->drop_next,
+				   cobalt_control(vars->drop_next,
+						  p->interval,
+						  vars->rec_inv_sqrt));
 			schedule =3D ktime_sub(now, vars->drop_next);
 			next_due =3D vars->count && ktime_to_ns(schedule) >=3D 0;
 		}
@@ -577,9 +588,9 @@ static enum qdisc_drop_reason cobalt_should_drop(struct=
 cobalt_vars *vars,
=20
 	/* Overload the drop_next field as an activity timeout */
 	if (!vars->count)
-		vars->drop_next =3D ktime_add_ns(now, p->interval);
+		WRITE_ONCE(vars->drop_next, ktime_add_ns(now, p->interval));
 	else if (ktime_to_ns(schedule) > 0 && reason =3D=3D QDISC_DROP_UNSPEC)
-		vars->drop_next =3D now;
+		WRITE_ONCE(vars->drop_next, now);
=20
 	return reason;
 }
@@ -813,7 +824,7 @@ static u32 cake_hash(struct cake_tin_data *q, const str=
uct sk_buff *skb,
 		     i++, k =3D (k + 1) % CAKE_SET_WAYS) {
 			if (q->tags[outer_hash + k] =3D=3D flow_hash) {
 				if (i)
-					q->way_hits++;
+					WRITE_ONCE(q->way_hits, q->way_hits + 1);
=20
 				if (!q->flows[outer_hash + k].set) {
 					/* need to increment host refcnts */
@@ -831,7 +842,7 @@ static u32 cake_hash(struct cake_tin_data *q, const str=
uct sk_buff *skb,
 		for (i =3D 0; i < CAKE_SET_WAYS;
 			 i++, k =3D (k + 1) % CAKE_SET_WAYS) {
 			if (!q->flows[outer_hash + k].set) {
-				q->way_misses++;
+				WRITE_ONCE(q->way_misses, q->way_misses + 1);
 				allocate_src =3D cake_dsrc(flow_mode);
 				allocate_dst =3D cake_ddst(flow_mode);
 				goto found;
@@ -841,7 +852,7 @@ static u32 cake_hash(struct cake_tin_data *q, const str=
uct sk_buff *skb,
 		/* With no empty queues, default to the original
 		 * queue, accept the collision, update the host tags.
 		 */
-		q->way_collisions++;
+		WRITE_ONCE(q->way_collisions, q->way_collisions + 1);
 		allocate_src =3D cake_dsrc(flow_mode);
 		allocate_dst =3D cake_ddst(flow_mode);
=20
@@ -875,7 +886,8 @@ static u32 cake_hash(struct cake_tin_data *q, const str=
uct sk_buff *skb,
 			q->flows[reduced_hash].srchost =3D srchost_idx;
=20
 			if (q->flows[reduced_hash].set =3D=3D CAKE_SET_BULK)
-				cake_inc_srchost_bulk_flow_count(q, &q->flows[reduced_hash], flow_mode=
);
+				cake_inc_srchost_bulk_flow_count(q, &q->flows[reduced_hash],
+								 flow_mode);
 		}
=20
 		if (allocate_dst) {
@@ -899,7 +911,8 @@ static u32 cake_hash(struct cake_tin_data *q, const str=
uct sk_buff *skb,
 			q->flows[reduced_hash].dsthost =3D dsthost_idx;
=20
 			if (q->flows[reduced_hash].set =3D=3D CAKE_SET_BULK)
-				cake_inc_dsthost_bulk_flow_count(q, &q->flows[reduced_hash], flow_mode=
);
+				cake_inc_dsthost_bulk_flow_count(q, &q->flows[reduced_hash],
+								 flow_mode);
 		}
 	}
=20
@@ -1379,9 +1392,9 @@ static u32 cake_calc_overhead(struct cake_sched_data =
*qd, u32 len, u32 off)
 		len -=3D off;
=20
 	if (qd->max_netlen < len)
-		qd->max_netlen =3D len;
+		WRITE_ONCE(qd->max_netlen, len);
 	if (qd->min_netlen > len)
-		qd->min_netlen =3D len;
+		WRITE_ONCE(qd->min_netlen, len);
=20
 	len +=3D q->rate_overhead;
=20
@@ -1401,9 +1414,9 @@ static u32 cake_calc_overhead(struct cake_sched_data =
*qd, u32 len, u32 off)
 	}
=20
 	if (qd->max_adjlen < len)
-		qd->max_adjlen =3D len;
+		WRITE_ONCE(qd->max_adjlen, len);
 	if (qd->min_adjlen > len)
-		qd->min_adjlen =3D len;
+		WRITE_ONCE(qd->min_adjlen, len);
=20
 	return len;
 }
@@ -1416,7 +1429,7 @@ static u32 cake_overhead(struct cake_sched_data *q, c=
onst struct sk_buff *skb)
 	u16 segs =3D qdisc_pkt_segs(skb);
 	u32 len =3D qdisc_pkt_len(skb);
=20
-	q->avg_netoff =3D cake_ewma(q->avg_netoff, off << 16, 8);
+	WRITE_ONCE(q->avg_netoff, cake_ewma(q->avg_netoff, off << 16, 8));
=20
 	if (segs =3D=3D 1)
 		return cake_calc_overhead(q, len, off);
@@ -1590,16 +1603,17 @@ static unsigned int cake_drop(struct Qdisc *sch, st=
ruct sk_buff **to_free)
 	}
=20
 	if (cobalt_queue_full(&flow->cvars, &b->cparams, now))
-		b->unresponsive_flow_count++;
+		WRITE_ONCE(b->unresponsive_flow_count,
+			   b->unresponsive_flow_count + 1);
=20
 	len =3D qdisc_pkt_len(skb);
 	q->buffer_used      -=3D skb->truesize;
-	b->backlogs[idx]    -=3D len;
-	b->tin_backlog      -=3D len;
+	WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] - len);
+	WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
 	qstats_backlog_sub(sch, len);
=20
-	flow->dropped++;
-	b->tin_dropped++;
+	WRITE_ONCE(flow->dropped, flow->dropped + 1);
+	WRITE_ONCE(b->tin_dropped, b->tin_dropped + 1);
=20
 	if (q->config->rate_flags & CAKE_FLAG_INGRESS)
 		cake_advance_shaper(q, b, skb, now, true);
@@ -1795,7 +1809,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
 	}
=20
 	if (unlikely(len > b->max_skblen))
-		b->max_skblen =3D len;
+		WRITE_ONCE(b->max_skblen, len);
=20
 	if (qdisc_pkt_segs(skb) > 1 && q->config->rate_flags & CAKE_FLAG_SPLIT_GS=
O) {
 		struct sk_buff *segs, *nskb;
@@ -1819,13 +1833,13 @@ static s32 cake_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
 			numsegs++;
 			slen +=3D segs->len;
 			q->buffer_used +=3D segs->truesize;
-			b->packets++;
 		}
=20
 		/* stats */
-		b->bytes	    +=3D slen;
-		b->backlogs[idx]    +=3D slen;
-		b->tin_backlog      +=3D slen;
+		WRITE_ONCE(b->bytes, b->bytes + slen);
+		WRITE_ONCE(b->packets, b->packets + numsegs);
+		WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + slen);
+		WRITE_ONCE(b->tin_backlog, b->tin_backlog + slen);
 		qstats_backlog_add(sch, slen);
 		q->avg_window_bytes +=3D slen;
=20
@@ -1843,7 +1857,7 @@ static s32 cake_enqueue(struct sk_buff *skb, struct Q=
disc *sch,
 			ack =3D cake_ack_filter(q, flow);
=20
 		if (ack) {
-			b->ack_drops++;
+			WRITE_ONCE(b->ack_drops, b->ack_drops + 1);
 			sch->qstats.drops++;
 			ack_pkt_len =3D qdisc_pkt_len(ack);
 			b->bytes +=3D ack_pkt_len;
@@ -1859,10 +1873,10 @@ static s32 cake_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
 		}
=20
 		/* stats */
-		b->packets++;
-		b->bytes	    +=3D len - ack_pkt_len;
-		b->backlogs[idx]    +=3D len - ack_pkt_len;
-		b->tin_backlog      +=3D len - ack_pkt_len;
+		WRITE_ONCE(b->packets, b->packets + 1);
+		WRITE_ONCE(b->bytes, b->bytes + len - ack_pkt_len);
+		WRITE_ONCE(b->backlogs[idx], b->backlogs[idx] + len - ack_pkt_len);
+		WRITE_ONCE(b->tin_backlog, b->tin_backlog + len - ack_pkt_len);
 		qstats_backlog_add(sch, len - ack_pkt_len);
 		q->avg_window_bytes +=3D len - ack_pkt_len;
 	}
@@ -1917,27 +1931,30 @@ static s32 cake_enqueue(struct sk_buff *skb, struct=
 Qdisc *sch,
 		if (!flow->set) {
 			list_add_tail(&flow->flowchain, &b->new_flows);
 		} else {
-			b->decaying_flow_count--;
+			WRITE_ONCE(b->decaying_flow_count,
+				   b->decaying_flow_count - 1);
 			list_move_tail(&flow->flowchain, &b->new_flows);
 		}
 		flow->set =3D CAKE_SET_SPARSE;
-		b->sparse_flow_count++;
+		WRITE_ONCE(b->sparse_flow_count,
+			   b->sparse_flow_count + 1);
=20
-		flow->deficit =3D cake_get_flow_quantum(b, flow, q->config->flow_mode);
+		WRITE_ONCE(flow->deficit,
+			   cake_get_flow_quantum(b, flow, q->config->flow_mode));
 	} else if (flow->set =3D=3D CAKE_SET_SPARSE_WAIT) {
 		/* this flow was empty, accounted as a sparse flow, but actually
 		 * in the bulk rotation.
 		 */
 		flow->set =3D CAKE_SET_BULK;
-		b->sparse_flow_count--;
-		b->bulk_flow_count++;
+		WRITE_ONCE(b->sparse_flow_count, b->sparse_flow_count - 1);
+		WRITE_ONCE(b->bulk_flow_count, b->bulk_flow_count + 1);
=20
 		cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
 		cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
 	}
=20
 	if (q->buffer_used > q->buffer_max_used)
-		q->buffer_max_used =3D q->buffer_used;
+		WRITE_ONCE(q->buffer_max_used, q->buffer_used);
=20
 	if (q->buffer_used <=3D q->buffer_limit)
 		return NET_XMIT_SUCCESS;
@@ -1976,8 +1993,8 @@ static struct sk_buff *cake_dequeue_one(struct Qdisc =
*sch)
 	if (flow->head) {
 		skb =3D dequeue_head(flow);
 		len =3D qdisc_pkt_len(skb);
-		b->backlogs[q->cur_flow] -=3D len;
-		b->tin_backlog		 -=3D len;
+		WRITE_ONCE(b->backlogs[q->cur_flow], b->backlogs[q->cur_flow] - len);
+		WRITE_ONCE(b->tin_backlog, b->tin_backlog - len);
 		qstats_backlog_sub(sch, len);
 		q->buffer_used		 -=3D skb->truesize;
 		qdisc_qlen_dec(sch);
@@ -2042,7 +2059,7 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch=
)
=20
 		cake_configure_rates(sch, new_rate, true);
 		q->last_checked_active =3D now;
-		q->active_queues =3D num_active_qs;
+		WRITE_ONCE(q->active_queues, num_active_qs);
 	}
=20
 begin:
@@ -2149,8 +2166,10 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sc=
h)
 		 */
 		if (flow->set =3D=3D CAKE_SET_SPARSE) {
 			if (flow->head) {
-				b->sparse_flow_count--;
-				b->bulk_flow_count++;
+				WRITE_ONCE(b->sparse_flow_count,
+					   b->sparse_flow_count - 1);
+				WRITE_ONCE(b->bulk_flow_count,
+					   b->bulk_flow_count + 1);
=20
 				cake_inc_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
 				cake_inc_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
@@ -2165,7 +2184,8 @@ static struct sk_buff *cake_dequeue(struct Qdisc *sch=
)
 			}
 		}
=20
-		flow->deficit +=3D cake_get_flow_quantum(b, flow, q->config->flow_mode);
+		WRITE_ONCE(flow->deficit,
+			   flow->deficit + cake_get_flow_quantum(b, flow, q->config->flow_mode)=
);
 		list_move_tail(&flow->flowchain, &b->old_flows);
=20
 		goto retry;
@@ -2187,16 +2207,22 @@ static struct sk_buff *cake_dequeue(struct Qdisc *s=
ch)
 				list_move_tail(&flow->flowchain,
 					       &b->decaying_flows);
 				if (flow->set =3D=3D CAKE_SET_BULK) {
-					b->bulk_flow_count--;
+					WRITE_ONCE(b->bulk_flow_count,
+						   b->bulk_flow_count - 1);
=20
-					cake_dec_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
-					cake_dec_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
+					cake_dec_srchost_bulk_flow_count(b, flow,
+									 q->config->flow_mode);
+					cake_dec_dsthost_bulk_flow_count(b, flow,
+									 q->config->flow_mode);
=20
-					b->decaying_flow_count++;
+					WRITE_ONCE(b->decaying_flow_count,
+						   b->decaying_flow_count + 1);
 				} else if (flow->set =3D=3D CAKE_SET_SPARSE ||
 					   flow->set =3D=3D CAKE_SET_SPARSE_WAIT) {
-					b->sparse_flow_count--;
-					b->decaying_flow_count++;
+					WRITE_ONCE(b->sparse_flow_count,
+						   b->sparse_flow_count - 1);
+					WRITE_ONCE(b->decaying_flow_count,
+						   b->decaying_flow_count + 1);
 				}
 				flow->set =3D CAKE_SET_DECAYING;
 			} else {
@@ -2204,14 +2230,20 @@ static struct sk_buff *cake_dequeue(struct Qdisc *s=
ch)
 				list_del_init(&flow->flowchain);
 				if (flow->set =3D=3D CAKE_SET_SPARSE ||
 				    flow->set =3D=3D CAKE_SET_SPARSE_WAIT)
-					b->sparse_flow_count--;
+					WRITE_ONCE(b->sparse_flow_count,
+						   b->sparse_flow_count - 1);
 				else if (flow->set =3D=3D CAKE_SET_BULK) {
-					b->bulk_flow_count--;
+					WRITE_ONCE(b->bulk_flow_count,
+						   b->bulk_flow_count - 1);
=20
-					cake_dec_srchost_bulk_flow_count(b, flow, q->config->flow_mode);
-					cake_dec_dsthost_bulk_flow_count(b, flow, q->config->flow_mode);
-				} else
-					b->decaying_flow_count--;
+					cake_dec_srchost_bulk_flow_count(b, flow,
+									 q->config->flow_mode);
+					cake_dec_dsthost_bulk_flow_count(b, flow,
+									 q->config->flow_mode);
+				} else {
+					WRITE_ONCE(b->decaying_flow_count,
+						   b->decaying_flow_count - 1);
+				}
=20
 				flow->set =3D CAKE_SET_NONE;
 			}
@@ -2230,11 +2262,11 @@ static struct sk_buff *cake_dequeue(struct Qdisc *s=
ch)
 		if (q->config->rate_flags & CAKE_FLAG_INGRESS) {
 			len =3D cake_advance_shaper(q, b, skb,
 						  now, true);
-			flow->deficit -=3D len;
+			WRITE_ONCE(flow->deficit, flow->deficit - len);
 			b->tin_deficit -=3D len;
 		}
-		flow->dropped++;
-		b->tin_dropped++;
+		WRITE_ONCE(flow->dropped, flow->dropped + 1);
+		WRITE_ONCE(b->tin_dropped, b->tin_dropped + 1);
 		qdisc_tree_reduce_backlog(sch, 1, qdisc_pkt_len(skb));
 		qdisc_qstats_drop(sch);
 		qdisc_dequeue_drop(sch, skb, reason);
@@ -2242,20 +2274,22 @@ static struct sk_buff *cake_dequeue(struct Qdisc *s=
ch)
 			goto retry;
 	}
=20
-	b->tin_ecn_mark +=3D !!flow->cvars.ecn_marked;
+	WRITE_ONCE(b->tin_ecn_mark, b->tin_ecn_mark + !!flow->cvars.ecn_marked);
 	qdisc_bstats_update(sch, skb);
 	WRITE_ONCE(q->last_active, now);
=20
 	/* collect delay stats */
 	delay =3D ktime_to_ns(ktime_sub(now, cobalt_get_enqueue_time(skb)));
-	b->avge_delay =3D cake_ewma(b->avge_delay, delay, 8);
-	b->peak_delay =3D cake_ewma(b->peak_delay, delay,
-				  delay > b->peak_delay ? 2 : 8);
-	b->base_delay =3D cake_ewma(b->base_delay, delay,
-				  delay < b->base_delay ? 2 : 8);
+	WRITE_ONCE(b->avge_delay, cake_ewma(b->avge_delay, delay, 8));
+	WRITE_ONCE(b->peak_delay,
+		   cake_ewma(b->peak_delay, delay,
+			     delay > b->peak_delay ? 2 : 8));
+	WRITE_ONCE(b->base_delay,
+		   cake_ewma(b->base_delay, delay,
+			     delay < b->base_delay ? 2 : 8));
=20
 	len =3D cake_advance_shaper(q, b, skb, now, false);
-	flow->deficit -=3D len;
+	WRITE_ONCE(flow->deficit, flow->deficit - len);
 	b->tin_deficit -=3D len;
=20
 	if (ktime_after(q->time_next_packet, now) && sch->q.qlen) {
@@ -2329,9 +2363,8 @@ static void cake_set_rate(struct cake_tin_data *b, u6=
4 rate, u32 mtu,
 	u8  rate_shft =3D 0;
 	u64 rate_ns =3D 0;
=20
-	b->flow_quantum =3D 1514;
 	if (rate) {
-		b->flow_quantum =3D max(min(rate >> 12, 1514ULL), 300ULL);
+		WRITE_ONCE(b->flow_quantum, max(min(rate >> 12, 1514ULL), 300ULL));
 		rate_shft =3D 34;
 		rate_ns =3D ((u64)NSEC_PER_SEC) << rate_shft;
 		rate_ns =3D div64_u64(rate_ns, max(MIN_RATE, rate));
@@ -2339,8 +2372,10 @@ static void cake_set_rate(struct cake_tin_data *b, u=
64 rate, u32 mtu,
 			rate_ns >>=3D 1;
 			rate_shft--;
 		}
-	} /* else unlimited, ie. zero delay */
-
+	} else {
+		/* else unlimited, ie. zero delay */
+		WRITE_ONCE(b->flow_quantum, 1514);
+	}
 	b->tin_rate_bps  =3D rate;
 	b->tin_rate_ns   =3D rate_ns;
 	b->tin_rate_shft =3D rate_shft;
@@ -2611,25 +2646,27 @@ static void cake_reconfigure(struct Qdisc *sch)
 {
 	struct cake_sched_data *qd =3D qdisc_priv(sch);
 	struct cake_sched_config *q =3D qd->config;
+	u32 buffer_limit;
=20
 	cake_configure_rates(sch, qd->config->rate_bps, false);
=20
 	if (q->buffer_config_limit) {
-		qd->buffer_limit =3D q->buffer_config_limit;
+		buffer_limit =3D q->buffer_config_limit;
 	} else if (q->rate_bps) {
 		u64 t =3D q->rate_bps * q->interval;
=20
 		do_div(t, USEC_PER_SEC / 4);
-		qd->buffer_limit =3D max_t(u32, t, 4U << 20);
+		buffer_limit =3D max_t(u32, t, 4U << 20);
 	} else {
-		qd->buffer_limit =3D ~0;
+		buffer_limit =3D ~0;
 	}
=20
 	sch->flags &=3D ~TCQ_F_CAN_BYPASS;
=20
-	qd->buffer_limit =3D min(qd->buffer_limit,
-			       max(sch->limit * psched_mtu(qdisc_dev(sch)),
-				   q->buffer_config_limit));
+	WRITE_ONCE(qd->buffer_limit,
+		   min(buffer_limit,
+		       max(sch->limit * psched_mtu(qdisc_dev(sch)),
+			   q->buffer_config_limit)));
 }
=20
 static int cake_config_change(struct cake_sched_config *q, struct nlattr *=
opt,
@@ -2774,10 +2811,10 @@ static int cake_change(struct Qdisc *sch, struct nl=
attr *opt,
 		return ret;
=20
 	if (overhead_changed) {
-		qd->max_netlen =3D 0;
-		qd->max_adjlen =3D 0;
-		qd->min_netlen =3D ~0;
-		qd->min_adjlen =3D ~0;
+		WRITE_ONCE(qd->max_netlen, 0);
+		WRITE_ONCE(qd->max_adjlen, 0);
+		WRITE_ONCE(qd->min_netlen, ~0);
+		WRITE_ONCE(qd->min_adjlen, ~0);
 	}
=20
 	if (qd->tins) {
@@ -2995,15 +3032,15 @@ static int cake_dump_stats(struct Qdisc *sch, struc=
t gnet_dump *d)
 			goto nla_put_failure;			       \
 	} while (0)
=20
-	PUT_STAT_U64(CAPACITY_ESTIMATE64, q->avg_peak_bandwidth);
-	PUT_STAT_U32(MEMORY_LIMIT, q->buffer_limit);
-	PUT_STAT_U32(MEMORY_USED, q->buffer_max_used);
-	PUT_STAT_U32(AVG_NETOFF, ((q->avg_netoff + 0x8000) >> 16));
-	PUT_STAT_U32(MAX_NETLEN, q->max_netlen);
-	PUT_STAT_U32(MAX_ADJLEN, q->max_adjlen);
-	PUT_STAT_U32(MIN_NETLEN, q->min_netlen);
-	PUT_STAT_U32(MIN_ADJLEN, q->min_adjlen);
-	PUT_STAT_U32(ACTIVE_QUEUES, q->active_queues);
+	PUT_STAT_U64(CAPACITY_ESTIMATE64, READ_ONCE(q->avg_peak_bandwidth));
+	PUT_STAT_U32(MEMORY_LIMIT, READ_ONCE(q->buffer_limit));
+	PUT_STAT_U32(MEMORY_USED, READ_ONCE(q->buffer_max_used));
+	PUT_STAT_U32(AVG_NETOFF, ((READ_ONCE(q->avg_netoff) + 0x8000) >> 16));
+	PUT_STAT_U32(MAX_NETLEN, READ_ONCE(q->max_netlen));
+	PUT_STAT_U32(MAX_ADJLEN, READ_ONCE(q->max_adjlen));
+	PUT_STAT_U32(MIN_NETLEN, READ_ONCE(q->min_netlen));
+	PUT_STAT_U32(MIN_ADJLEN, READ_ONCE(q->min_adjlen));
+	PUT_STAT_U32(ACTIVE_QUEUES, READ_ONCE(q->active_queues));
=20
 #undef PUT_STAT_U32
 #undef PUT_STAT_U64
@@ -3029,38 +3066,38 @@ static int cake_dump_stats(struct Qdisc *sch, struc=
t gnet_dump *d)
 		if (!ts)
 			goto nla_put_failure;
=20
-		PUT_TSTAT_U64(THRESHOLD_RATE64, b->tin_rate_bps);
-		PUT_TSTAT_U64(SENT_BYTES64, b->bytes);
-		PUT_TSTAT_U32(BACKLOG_BYTES, b->tin_backlog);
+		PUT_TSTAT_U64(THRESHOLD_RATE64, READ_ONCE(b->tin_rate_bps));
+		PUT_TSTAT_U64(SENT_BYTES64, READ_ONCE(b->bytes));
+		PUT_TSTAT_U32(BACKLOG_BYTES, READ_ONCE(b->tin_backlog));
=20
 		PUT_TSTAT_U32(TARGET_US,
-			      ktime_to_us(ns_to_ktime(b->cparams.target)));
+			ktime_to_us(ns_to_ktime(READ_ONCE(b->cparams.target))));
 		PUT_TSTAT_U32(INTERVAL_US,
-			      ktime_to_us(ns_to_ktime(b->cparams.interval)));
+			ktime_to_us(ns_to_ktime(READ_ONCE(b->cparams.interval))));
=20
-		PUT_TSTAT_U32(SENT_PACKETS, b->packets);
-		PUT_TSTAT_U32(DROPPED_PACKETS, b->tin_dropped);
-		PUT_TSTAT_U32(ECN_MARKED_PACKETS, b->tin_ecn_mark);
-		PUT_TSTAT_U32(ACKS_DROPPED_PACKETS, b->ack_drops);
+		PUT_TSTAT_U32(SENT_PACKETS, READ_ONCE(b->packets));
+		PUT_TSTAT_U32(DROPPED_PACKETS, READ_ONCE(b->tin_dropped));
+		PUT_TSTAT_U32(ECN_MARKED_PACKETS, READ_ONCE(b->tin_ecn_mark));
+		PUT_TSTAT_U32(ACKS_DROPPED_PACKETS, READ_ONCE(b->ack_drops));
=20
 		PUT_TSTAT_U32(PEAK_DELAY_US,
-			      ktime_to_us(ns_to_ktime(b->peak_delay)));
+			      ktime_to_us(ns_to_ktime(READ_ONCE(b->peak_delay))));
 		PUT_TSTAT_U32(AVG_DELAY_US,
-			      ktime_to_us(ns_to_ktime(b->avge_delay)));
+			      ktime_to_us(ns_to_ktime(READ_ONCE(b->avge_delay))));
 		PUT_TSTAT_U32(BASE_DELAY_US,
-			      ktime_to_us(ns_to_ktime(b->base_delay)));
+			      ktime_to_us(ns_to_ktime(READ_ONCE(b->base_delay))));
=20
-		PUT_TSTAT_U32(WAY_INDIRECT_HITS, b->way_hits);
-		PUT_TSTAT_U32(WAY_MISSES, b->way_misses);
-		PUT_TSTAT_U32(WAY_COLLISIONS, b->way_collisions);
+		PUT_TSTAT_U32(WAY_INDIRECT_HITS, READ_ONCE(b->way_hits));
+		PUT_TSTAT_U32(WAY_MISSES, READ_ONCE(b->way_misses));
+		PUT_TSTAT_U32(WAY_COLLISIONS, READ_ONCE(b->way_collisions));
=20
-		PUT_TSTAT_U32(SPARSE_FLOWS, b->sparse_flow_count +
-					    b->decaying_flow_count);
-		PUT_TSTAT_U32(BULK_FLOWS, b->bulk_flow_count);
-		PUT_TSTAT_U32(UNRESPONSIVE_FLOWS, b->unresponsive_flow_count);
-		PUT_TSTAT_U32(MAX_SKBLEN, b->max_skblen);
+		PUT_TSTAT_U32(SPARSE_FLOWS, READ_ONCE(b->sparse_flow_count) +
+					    READ_ONCE(b->decaying_flow_count));
+		PUT_TSTAT_U32(BULK_FLOWS, READ_ONCE(b->bulk_flow_count));
+		PUT_TSTAT_U32(UNRESPONSIVE_FLOWS, READ_ONCE(b->unresponsive_flow_count))=
;
+		PUT_TSTAT_U32(MAX_SKBLEN, READ_ONCE(b->max_skblen));
=20
-		PUT_TSTAT_U32(FLOW_QUANTUM, b->flow_quantum);
+		PUT_TSTAT_U32(FLOW_QUANTUM, READ_ONCE(b->flow_quantum));
 		nla_nest_end(d->skb, ts);
 	}
=20
@@ -3137,13 +3174,15 @@ static int cake_dump_class_stats(struct Qdisc *sch,=
 unsigned long cl,
 			}
 			sch_tree_unlock(sch);
 		}
-		qs.backlog =3D b->backlogs[idx % CAKE_QUEUES];
-		qs.drops =3D flow->dropped;
+		qs.backlog =3D READ_ONCE(b->backlogs[idx % CAKE_QUEUES]);
+		qs.drops =3D READ_ONCE(flow->dropped);
 	}
 	if (gnet_stats_copy_queue(d, NULL, &qs, qs.qlen) < 0)
 		return -1;
 	if (flow) {
 		ktime_t now =3D ktime_get();
+		bool dropping;
+		u32 p_drop;
=20
 		stats =3D nla_nest_start_noflag(d->skb, TCA_STATS_APP);
 		if (!stats)
@@ -3158,21 +3197,23 @@ static int cake_dump_class_stats(struct Qdisc *sch,=
 unsigned long cl,
 			goto nla_put_failure;			       \
 	} while (0)
=20
-		PUT_STAT_S32(DEFICIT, flow->deficit);
-		PUT_STAT_U32(DROPPING, flow->cvars.dropping);
-		PUT_STAT_U32(COBALT_COUNT, flow->cvars.count);
-		PUT_STAT_U32(P_DROP, flow->cvars.p_drop);
-		if (flow->cvars.p_drop) {
+		PUT_STAT_S32(DEFICIT, READ_ONCE(flow->deficit));
+		dropping =3D READ_ONCE(flow->cvars.dropping);
+		PUT_STAT_U32(DROPPING, dropping);
+		PUT_STAT_U32(COBALT_COUNT, READ_ONCE(flow->cvars.count));
+		p_drop =3D READ_ONCE(flow->cvars.p_drop);
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
=20
 		if (nla_nest_end(d->skb, stats) < 0)
@@ -3298,10 +3339,10 @@ static int cake_mq_change(struct Qdisc *sch, struct=
 nlattr *opt,
 		struct cake_sched_data *qd =3D qdisc_priv(chld);
=20
 		if (overhead_changed) {
-			qd->max_netlen =3D 0;
-			qd->max_adjlen =3D 0;
-			qd->min_netlen =3D ~0;
-			qd->min_adjlen =3D ~0;
+			WRITE_ONCE(qd->max_netlen, 0);
+			WRITE_ONCE(qd->max_adjlen, 0);
+			WRITE_ONCE(qd->min_netlen, ~0);
+			WRITE_ONCE(qd->min_adjlen, ~0);
 		}
=20
 		if (qd->tins) {
--=20
2.53.0.1213.gd9a14994de-goog



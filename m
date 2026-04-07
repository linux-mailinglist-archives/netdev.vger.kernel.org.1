Return-Path: <netdev+bounces-276024-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uH6zGpkW1Wm30AcAu9opvQ
	(envelope-from <netdev+bounces-276024-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 16:37:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2B43B026D
	for <lists+netdev@lfdr.de>; Tue, 07 Apr 2026 16:37:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 32E0C30C7631
	for <lists+netdev@lfdr.de>; Tue,  7 Apr 2026 14:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C21F445038;
	Tue,  7 Apr 2026 14:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/8Xm7GF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B522848A8
	for <netdev@vger.kernel.org>; Tue,  7 Apr 2026 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775572263; cv=none; b=aomSWoB5ukQsYNdh2ZKfQORvN9wEYWNx4Ca19d89Rz5coMRJCyyyllgDfEILXCWKzYyBOHwVwYU/50ns+X7I2xkvd+5cNY80IHYDhgzug3+Z6qrAt5TO33WpP0RTKIjE7d2D5HS6U+pKCVocokKjcBIbqKw0H//U+lj6jfFtES0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775572263; c=relaxed/simple;
	bh=72KMiEcFnxMca8Auv8Fdmcd1enayOkAoDLATrVLgePE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=pg2PwZKlWW2+ShcreF+udeA1poFddKYGRVtegepbWd12gq88WLg+Xk9D2mjbGlYIudvVJHoFnIkrUrJtYRP/Z5gEiz3Z10RYuDCyVq9iBiul2XvJt9Z6tdbtAG99V0i3JrbMjLr5bPrQhQdK7twtnfTuvi9xQyefB7Hr1GmbKZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/8Xm7GF; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d8dac6233so47264031cf.2
        for <netdev@vger.kernel.org>; Tue, 07 Apr 2026 07:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775572259; x=1776177059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i0LexFwz4lsg77bJfOkFXREbNvVDof0o7bfA/+2DSFY=;
        b=G/8Xm7GF4d3EZJ841TbzP07aqtfOUGBI8JsjvpKurmDGCVT69JWSBf/znUrK3mbFFz
         F6sHwn1lfOtbiouGM5OVxWUIzSa0Gxh5OK/3gIifdR6DFTMeby8+Utk3MBZri6wQUT15
         +hYymIeDVMsdsMxu9zoZZt37A9Q+A7rqbd0xPbLgn0/h9G10NcpMktxAB8I1BEzRo2cI
         SQzhhXApjAldHg40MfEBtTza47rd9i7FzeF/JcRVSkyzDdnDL+y2C3XYwEYleCXzDt48
         3vs+507SILQDwBVnQQeBAFbXndBoHvS0Zs3vMN+EpxyNS1+Cu5i4RwTti+Ee/Svdj0TX
         Na7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775572259; x=1776177059;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=i0LexFwz4lsg77bJfOkFXREbNvVDof0o7bfA/+2DSFY=;
        b=N0yuqbSpnXLzzWl+10v79mlcI7kA5TEkcs+WzyK49pMBpDp9s68aNl3OQodgRfsSXQ
         8upXNh4bpAK5pt0MN2Ndcvo90jE+Z+gMUMgn+phJ3imfoIKddi5zp84oSqYSBQ48S7Kf
         oc8qgVtL4qA8h1HsHes7rIqXRH6HWvGULDayuwaSc3DaXrNZ/DZnxcp/W/ndzetDN980
         AnOT4kkj3Q31Vb3sgC11Za4BjAhvx1SIIoGOvWYFdtNFUDrWC9vAyfpW1LUJbWWT98r9
         bUsjim4y28bC3Z9kUHqm913p54/1hmasm23WFmIMZnpjwK8H1kh0aJ1Mxb5HSUPvRAyG
         iraQ==
X-Forwarded-Encrypted: i=1; AJvYcCXs+hJOUkBQWFgCsUkvcxSGgLBy1JJPRnM8LzReGSEX1Fcs2m2YIfT/1Gtgiq2id7+bSjlgvro=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOFdsVUgD0qmbRl1HlshrDga9zf2P40cFgPQMZZOKkSt9XqQlL
	KNMJietLMDDKAY84G4Rb1FCKxfpsNJmVI7H5+mCtb518vYUL6Mu3rZ3s+AO2Va2b/ux9E0o/y6K
	yJKrcwYAEsHL4aw==
X-Received: from qtvo19.prod.google.com ([2002:ac8:7c53:0:b0:503:34fa:ca78])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5a09:0:b0:50d:8080:2a7 with SMTP id d75a77b69052e-50d808005f1mr181542401cf.21.1775572255372;
 Tue, 07 Apr 2026 07:30:55 -0700 (PDT)
Date: Tue,  7 Apr 2026 14:30:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260407143053.1570620-1-edumazet@google.com>
Subject: [PATCH net-next] codel: annotate data-races in codel_dump_stats()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, Jiri Pirko <jiri@resnulli.us>, 
	netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
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
	TAGGED_FROM(0.00)[bounces-276024-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C2B43B026D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

codel_dump_stats() only runs with RTNL held,
reading fields that can be changed in qdisc fast path.

Add READ_ONCE()/WRITE_ONCE() annotations.

Alternative would be to acquire the qdisc spinlock, but our long-term
goal is to make qdisc dump operations lockless as much as we can.

tc_codel_xstats fields don't need to be latched atomically,
otherwise this bug would have been caught earlier.

No change in kernel size:

$ scripts/bloat-o-meter -t vmlinux.0 vmlinux
add/remove: 0/0 grow/shrink: 1/1 up/down: 3/-1 (2)
Function                                     old     new   delta
codel_qdisc_dequeue                         2462    2465      +3
codel_dump_stats                             250     249      -1
Total: Before=29739919, After=29739921, chg +0.00%

Fixes: 76e3cc126bb2 ("codel: Controlled Delay AQM")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
net-next tree has been chosen to avoid a merge conflict.
I will handle stable submission, this bug is minor.

 include/net/codel_impl.h | 45 +++++++++++++++++++++-------------------
 net/sched/sch_codel.c    | 22 ++++++++++----------
 2 files changed, 35 insertions(+), 32 deletions(-)

diff --git a/include/net/codel_impl.h b/include/net/codel_impl.h
index b2c359c6dd1b84e3aeb77834272641bac73f8e6a..2c1f0ec309e9fe02e79d377129da6c5c0cbce19b 100644
--- a/include/net/codel_impl.h
+++ b/include/net/codel_impl.h
@@ -120,10 +120,10 @@ static bool codel_should_drop(const struct sk_buff *skb,
 	}
 
 	skb_len = skb_len_func(skb);
-	vars->ldelay = now - skb_time_func(skb);
+	WRITE_ONCE(vars->ldelay, now - skb_time_func(skb));
 
 	if (unlikely(skb_len > stats->maxpacket))
-		stats->maxpacket = skb_len;
+		WRITE_ONCE(stats->maxpacket, skb_len);
 
 	if (codel_time_before(vars->ldelay, params->target) ||
 	    *backlog <= params->mtu) {
@@ -159,7 +159,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
 
 	if (!skb) {
 		vars->first_above_time = 0;
-		vars->dropping = false;
+		WRITE_ONCE(vars->dropping, false);
 		return skb;
 	}
 	now = codel_get_time();
@@ -168,7 +168,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
 	if (vars->dropping) {
 		if (!drop) {
 			/* sojourn time below target - leave dropping state */
-			vars->dropping = false;
+			WRITE_ONCE(vars->dropping, false);
 		} else if (codel_time_after_eq(now, vars->drop_next)) {
 			/* It's time for the next drop. Drop the current
 			 * packet and dequeue the next. The dequeue might
@@ -180,16 +180,18 @@ static struct sk_buff *codel_dequeue(void *ctx,
 			 */
 			while (vars->dropping &&
 			       codel_time_after_eq(now, vars->drop_next)) {
-				vars->count++; /* dont care of possible wrap
-						* since there is no more divide
-						*/
+				/* dont care of possible wrap
+				 * since there is no more divide.
+				 */
+				WRITE_ONCE(vars->count, vars->count + 1);
 				codel_Newton_step(vars);
 				if (params->ecn && INET_ECN_set_ce(skb)) {
-					stats->ecn_mark++;
-					vars->drop_next =
+					WRITE_ONCE(stats->ecn_mark,
+						   stats->ecn_mark + 1);
+					WRITE_ONCE(vars->drop_next,
 						codel_control_law(vars->drop_next,
 								  params->interval,
-								  vars->rec_inv_sqrt);
+								  vars->rec_inv_sqrt));
 					goto end;
 				}
 				stats->drop_len += skb_len_func(skb);
@@ -202,13 +204,13 @@ static struct sk_buff *codel_dequeue(void *ctx,
 						       skb_time_func,
 						       backlog, now)) {
 					/* leave dropping state */
-					vars->dropping = false;
+					WRITE_ONCE(vars->dropping, false);
 				} else {
 					/* and schedule the next drop */
-					vars->drop_next =
+					WRITE_ONCE(vars->drop_next,
 						codel_control_law(vars->drop_next,
 								  params->interval,
-								  vars->rec_inv_sqrt);
+								  vars->rec_inv_sqrt));
 				}
 			}
 		}
@@ -216,7 +218,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
 		u32 delta;
 
 		if (params->ecn && INET_ECN_set_ce(skb)) {
-			stats->ecn_mark++;
+			WRITE_ONCE(stats->ecn_mark, stats->ecn_mark + 1);
 		} else {
 			stats->drop_len += skb_len_func(skb);
 			drop_func(skb, ctx);
@@ -227,7 +229,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
 						 stats, skb_len_func,
 						 skb_time_func, backlog, now);
 		}
-		vars->dropping = true;
+		WRITE_ONCE(vars->dropping, true);
 		/* if min went above target close to when we last went below it
 		 * assume that the drop rate that controlled the queue on the
 		 * last cycle is a good starting point to control it now.
@@ -236,19 +238,20 @@ static struct sk_buff *codel_dequeue(void *ctx,
 		if (delta > 1 &&
 		    codel_time_before(now - vars->drop_next,
 				      16 * params->interval)) {
-			vars->count = delta;
+			WRITE_ONCE(vars->count, delta);
 			/* we dont care if rec_inv_sqrt approximation
 			 * is not very precise :
 			 * Next Newton steps will correct it quadratically.
 			 */
 			codel_Newton_step(vars);
 		} else {
-			vars->count = 1;
+			WRITE_ONCE(vars->count, 1);
 			vars->rec_inv_sqrt = ~0U >> REC_INV_SQRT_SHIFT;
 		}
-		vars->lastcount = vars->count;
-		vars->drop_next = codel_control_law(now, params->interval,
-						    vars->rec_inv_sqrt);
+		WRITE_ONCE(vars->lastcount, vars->count);
+		WRITE_ONCE(vars->drop_next,
+			   codel_control_law(now, params->interval,
+					     vars->rec_inv_sqrt));
 	}
 end:
 	if (skb && codel_time_after(vars->ldelay, params->ce_threshold)) {
@@ -262,7 +265,7 @@ static struct sk_buff *codel_dequeue(void *ctx,
 				   params->ce_threshold_selector));
 		}
 		if (set_ce && INET_ECN_set_ce(skb))
-			stats->ce_mark++;
+			WRITE_ONCE(stats->ce_mark, stats->ce_mark + 1);
 	}
 	return skb;
 }
diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index dc2be90666ffbd715550800790a0091acd28701d..317aae0ec7bd6aedb4bae09b18423c981fed16e7 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -85,7 +85,7 @@ static int codel_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		return qdisc_enqueue_tail(skb, sch);
 	}
 	q = qdisc_priv(sch);
-	q->drop_overlimit++;
+	WRITE_ONCE(q->drop_overlimit, q->drop_overlimit + 1);
 	return qdisc_drop_reason(skb, sch, to_free, QDISC_DROP_OVERLIMIT);
 }
 
@@ -221,18 +221,18 @@ static int codel_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	const struct codel_sched_data *q = qdisc_priv(sch);
 	struct tc_codel_xstats st = {
-		.maxpacket	= q->stats.maxpacket,
-		.count		= q->vars.count,
-		.lastcount	= q->vars.lastcount,
-		.drop_overlimit = q->drop_overlimit,
-		.ldelay		= codel_time_to_us(q->vars.ldelay),
-		.dropping	= q->vars.dropping,
-		.ecn_mark	= q->stats.ecn_mark,
-		.ce_mark	= q->stats.ce_mark,
+		.maxpacket	= READ_ONCE(q->stats.maxpacket),
+		.count		= READ_ONCE(q->vars.count),
+		.lastcount	= READ_ONCE(q->vars.lastcount),
+		.drop_overlimit = READ_ONCE(q->drop_overlimit),
+		.ldelay		= codel_time_to_us(READ_ONCE(q->vars.ldelay)),
+		.dropping	= READ_ONCE(q->vars.dropping),
+		.ecn_mark	= READ_ONCE(q->stats.ecn_mark),
+		.ce_mark	= READ_ONCE(q->stats.ce_mark),
 	};
 
-	if (q->vars.dropping) {
-		codel_tdiff_t delta = q->vars.drop_next - codel_get_time();
+	if (st.dropping) {
+		codel_tdiff_t delta = READ_ONCE(q->vars.drop_next) - codel_get_time();
 
 		if (delta >= 0)
 			st.drop_next = codel_time_to_us(delta);
-- 
2.53.0.1213.gd9a14994de-goog



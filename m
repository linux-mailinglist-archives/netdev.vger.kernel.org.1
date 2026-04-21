Return-Path: <netdev+bounces-280144-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gNWDIduH52kU9wEAu9opvQ
	(envelope-from <netdev+bounces-280144-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:21:15 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id C15FB43BECC
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 16:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AD80530235B1
	for <lists+netdev@lfdr.de>; Tue, 21 Apr 2026 14:17:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AE182C2363;
	Tue, 21 Apr 2026 14:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mHCI2ARF"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9037E3D7D9C
	for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 14:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776781020; cv=none; b=b8PZ0Woc6cihs2QgXzGOZS/MrzGKsjLoqrtzwGh7hhDJzZhCSVtWdUvk0uZiNuOLI1mutPonfUbtf16RcKhsN0a/9bxcTBYHB0ciHMgjaobhToOZDQlzILpFVtL50Ee2jQZgNV1Rtr8T0DeoR55J3MKBPOAsGIrl7tmihoaY5qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776781020; c=relaxed/simple;
	bh=X0z1PpWRInz8mov9MjHkNpAZsYOrxfKe+ps4SGxsAwA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=d4Kx85tewNLxVsf6jFdsHiC9Fl+v9hrafHFXx6SLUFzJF+qLzNYSaPUkOehO1FVRYvd3m14dtoYRHo+0bu6G7og7Z1909EQlC3xCqszJ0v0FZxCcXnKt4nz83HVh5a84fXk1mvCg/x+80hQZtAd2TxGHIg7c8mVmqIs6VEHgHLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mHCI2ARF; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8ed2c173d3bso311856385a.2
        for <netdev@vger.kernel.org>; Tue, 21 Apr 2026 07:16:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776781017; x=1777385817; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rlg4VN1preOqATJ0gOJkjSCVaIyG78aeQd7n1vEREBY=;
        b=mHCI2ARFIj1mOlK1IH1tPR8k8hitiEljfOt/KxePgvpmstx58ROE/hA8z9qcWgPvEE
         wia2eqAnbXfAXUCUucbmPVOUsC5nwEt20NSJTVr4GcaSpp1eg20KLBUgyjSrIxceWyLP
         GdgGLX18MpvMDUbpzWRPVjOzjj/fsYO6orDkk43bn+WhxO8xsHQuO/rO5SJKRdaRU5mT
         sBJbmI8z5nU6sT3meu0YdlGM30PGs8TXjnhxGtJyUSbDlXab8QxEBV2gO7pg9FschtSU
         nRCwfvsildKBi+dYApf25tllT6uNq+S/Bpr3yPqT3EAwsKFcBAWvI4dooWbKpQj8C7ge
         Itxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776781017; x=1777385817;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rlg4VN1preOqATJ0gOJkjSCVaIyG78aeQd7n1vEREBY=;
        b=sYbobks0S5xWME5eDWVE4bYdRGGdJdhQd2/s/d2O0pgtJ8TV6lyVe36Sp33M17ITY3
         1tUn5ZUYSjqN44JrpAcLSkl0FUd/V049ExbCnbZJ7uLrHDxMMk3v5LZseTSKKeKI6P4X
         3nzPQdH0MAconXBmX2jt0z/I2g2vhoKhKjhEZn2ObtZEiJsN45xtQkbbQ7DQCFvqZyS1
         X4nx6wZQ6ehI3Cc9iItuhsSQOLO24Ht1OhBRhU/dgS+su/ACmPBWFeMwZZajzzgP2zzF
         DUdr+ruLrIDwhfs3s0DUaFAJkEU1iQjQZf8kiVFtppUyRUdvUq7ujOhmNveZpET7GmT4
         gAbw==
X-Forwarded-Encrypted: i=1; AFNElJ+d02+UELuhM2LRuJFIxSMI+5/w/9yz79sgAuaL8ZjR2YwjmH1d9WiIvqjVG55XmMPyheelhkM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUHMg46kyfe6X8UbpTzb3CLhdPczZnp5aTGKXLSzlUBVLtyO3i
	MMo9kkM2CZjLz6f2GsyJm0ju6is7nNMpbPeYqr/GCibQU86SBXMg/iTt1QjsGXIk5wTIa/XKPHr
	7YwJYWZNBd6kbHQ==
X-Received: from qkkh13.prod.google.com ([2002:a05:620a:10ad:b0:8eb:c839:80d8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:172a:b0:8d9:5463:132b with SMTP id af79cd13be357-8e792085937mr2625465285a.49.1776781016783;
 Tue, 21 Apr 2026 07:16:56 -0700 (PDT)
Date: Tue, 21 Apr 2026 14:16:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc2.533.g4f5dca5207-goog
Message-ID: <20260421141655.3953721-1-edumazet@google.com>
Subject: [PATCH net] net/sched: sch_sfb: annotate data-races in sfb_dump_stats()
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280144-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C15FB43BECC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sfb_dump_stats() only runs with RTNL held,
reading fields that can be changed in qdisc fast path.

Add READ_ONCE()/WRITE_ONCE() annotations.

Alternative would be to acquire the qdisc spinlock, but our long-term
goal is to make qdisc dump operations lockless as much as we can.

tc_sfb_xstats fields don't need to be latched atomically,
otherwise this bug would have been caught earlier.

Fixes: edb09eb17ed8 ("net: sched: do not acquire qdisc spinlock in qdisc/class stats dump")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_sfb.c | 54 +++++++++++++++++++++++++++------------------
 1 file changed, 32 insertions(+), 22 deletions(-)

diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index 01373866212894c57e7de58706ee464879303955..bd5ef561030fea07aed44b958ebf73e02eae04cf 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
@@ -130,7 +130,7 @@ static void increment_one_qlen(u32 sfbhash, u32 slot, struct sfb_sched_data *q)
 
 		sfbhash >>= SFB_BUCKET_SHIFT;
 		if (b[hash].qlen < 0xFFFF)
-			b[hash].qlen++;
+			WRITE_ONCE(b[hash].qlen, b[hash].qlen + 1);
 		b += SFB_NUMBUCKETS; /* next level */
 	}
 }
@@ -159,7 +159,7 @@ static void decrement_one_qlen(u32 sfbhash, u32 slot,
 
 		sfbhash >>= SFB_BUCKET_SHIFT;
 		if (b[hash].qlen > 0)
-			b[hash].qlen--;
+			WRITE_ONCE(b[hash].qlen, b[hash].qlen - 1);
 		b += SFB_NUMBUCKETS; /* next level */
 	}
 }
@@ -179,12 +179,12 @@ static void decrement_qlen(const struct sk_buff *skb, struct sfb_sched_data *q)
 
 static void decrement_prob(struct sfb_bucket *b, struct sfb_sched_data *q)
 {
-	b->p_mark = prob_minus(b->p_mark, q->decrement);
+	WRITE_ONCE(b->p_mark, prob_minus(b->p_mark, q->decrement));
 }
 
 static void increment_prob(struct sfb_bucket *b, struct sfb_sched_data *q)
 {
-	b->p_mark = prob_plus(b->p_mark, q->increment);
+	WRITE_ONCE(b->p_mark, prob_plus(b->p_mark, q->increment));
 }
 
 static void sfb_zero_all_buckets(struct sfb_sched_data *q)
@@ -202,11 +202,14 @@ static u32 sfb_compute_qlen(u32 *prob_r, u32 *avgpm_r, const struct sfb_sched_da
 	const struct sfb_bucket *b = &q->bins[q->slot].bins[0][0];
 
 	for (i = 0; i < SFB_LEVELS * SFB_NUMBUCKETS; i++) {
-		if (qlen < b->qlen)
-			qlen = b->qlen;
-		totalpm += b->p_mark;
-		if (prob < b->p_mark)
-			prob = b->p_mark;
+		u32 b_qlen = READ_ONCE(b->qlen);
+		u32 b_mark = READ_ONCE(b->p_mark);
+
+		if (qlen < b_qlen)
+			qlen = b_qlen;
+		totalpm += b_mark;
+		if (prob < b_mark)
+			prob = b_mark;
 		b++;
 	}
 	*prob_r = prob;
@@ -295,7 +298,8 @@ static int sfb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	if (unlikely(sch->q.qlen >= q->limit)) {
 		qdisc_qstats_overlimit(sch);
-		q->stats.queuedrop++;
+		WRITE_ONCE(q->stats.queuedrop,
+			   q->stats.queuedrop + 1);
 		goto drop;
 	}
 
@@ -348,7 +352,8 @@ static int sfb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 
 	if (unlikely(minqlen >= q->max)) {
 		qdisc_qstats_overlimit(sch);
-		q->stats.bucketdrop++;
+		WRITE_ONCE(q->stats.bucketdrop,
+			   q->stats.bucketdrop + 1);
 		goto drop;
 	}
 
@@ -374,7 +379,8 @@ static int sfb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		}
 		if (sfb_rate_limit(skb, q)) {
 			qdisc_qstats_overlimit(sch);
-			q->stats.penaltydrop++;
+			WRITE_ONCE(q->stats.penaltydrop,
+				   q->stats.penaltydrop + 1);
 			goto drop;
 		}
 		goto enqueue;
@@ -390,14 +396,17 @@ static int sfb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 			 * In either case, we want to start dropping packets.
 			 */
 			if (r < (p_min - SFB_MAX_PROB / 2) * 2) {
-				q->stats.earlydrop++;
+				WRITE_ONCE(q->stats.earlydrop,
+					   q->stats.earlydrop + 1);
 				goto drop;
 			}
 		}
 		if (INET_ECN_set_ce(skb)) {
-			q->stats.marked++;
+			WRITE_ONCE(q->stats.marked,
+				   q->stats.marked + 1);
 		} else {
-			q->stats.earlydrop++;
+			WRITE_ONCE(q->stats.earlydrop,
+				   q->stats.earlydrop + 1);
 			goto drop;
 		}
 	}
@@ -410,7 +419,8 @@ static int sfb_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		sch->q.qlen++;
 		increment_qlen(&cb, q);
 	} else if (net_xmit_drop_count(ret)) {
-		q->stats.childdrop++;
+		WRITE_ONCE(q->stats.childdrop,
+			   q->stats.childdrop + 1);
 		qdisc_qstats_drop(sch);
 	}
 	return ret;
@@ -599,12 +609,12 @@ static int sfb_dump_stats(struct Qdisc *sch, struct gnet_dump *d)
 {
 	struct sfb_sched_data *q = qdisc_priv(sch);
 	struct tc_sfb_xstats st = {
-		.earlydrop = q->stats.earlydrop,
-		.penaltydrop = q->stats.penaltydrop,
-		.bucketdrop = q->stats.bucketdrop,
-		.queuedrop = q->stats.queuedrop,
-		.childdrop = q->stats.childdrop,
-		.marked = q->stats.marked,
+		.earlydrop = READ_ONCE(q->stats.earlydrop),
+		.penaltydrop = READ_ONCE(q->stats.penaltydrop),
+		.bucketdrop = READ_ONCE(q->stats.bucketdrop),
+		.queuedrop = READ_ONCE(q->stats.queuedrop),
+		.childdrop = READ_ONCE(q->stats.childdrop),
+		.marked = READ_ONCE(q->stats.marked),
 	};
 
 	st.maxqlen = sfb_compute_qlen(&st.maxprob, &st.avgprob, q);
-- 
2.54.0.rc2.533.g4f5dca5207-goog



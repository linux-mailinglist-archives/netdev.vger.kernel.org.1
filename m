Return-Path: <netdev+bounces-277139-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IP9PIv8e2GlaYAgAu9opvQ
	(envelope-from <netdev+bounces-277139-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:49:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 04E033D0036
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 23:49:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5D1463027D97
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 21:49:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9D1035B658;
	Thu,  9 Apr 2026 21:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uzOMHvw0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254ED355F47
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 21:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775771370; cv=none; b=lwhdRaDDC6qia2AKdmI/nEGxsOQ2pgxsgs64oqgxW0OXF9bh5VdAB+YMr7afZNcb1uqPN+iRleCdjop6Hbh/BUyeo8ZvHOZyhuKaYlw+6aThmQ2qg6e03pJRTZNQqRQ0SQAnq9rD69DNdrdW2cJlNa7alEKcinpsnoJxDAew7Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775771370; c=relaxed/simple;
	bh=qi885grWNO0I/828DqZRAAvBEncXQAUCR7+TWVwOBJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=kxbuKfqt4R8ntbePmx7Ksn8vTmVqJxCODjElowBmEqGu0oLEOd96sLIx9angxv3I0MLeG31/cGmHbGfAUsp1a5KtVUsfktyoIzSuSZUl89B/a1VhShkDv+k581FOUTuvBpLABSHh3RhoKXF33ZW6tbBCH/UexX3gsSjjeNpKU6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uzOMHvw0; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50d826ed6f9so32222541cf.1
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 14:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775771368; x=1776376168; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Onmcs3eIuMQgZUkFZbAjp3fMYkpAqyA2QjlGccXOLU=;
        b=uzOMHvw0M9hGEf5nTeNjWpZw9HTbWtca5jqJiTvhc1YBfnMY8JrqhRP6dl5LKzS+c/
         w2w1PW+VsQGtio/iUFl5MVVeawTTUZ+zcmTMZnb+tYs3Jg70cYlsY/IhdLQg27j7uOel
         2i8UL42V3VKfhQjLC3XtHSyrE7PhRaS4U1/74Jxd9tn3QFJ7WW0fLNT6ikJKMEzuUMOK
         Qcj/S1C48Es8kJ2YJKxiEaDwPJNixWYoDP5K8rkAs2BWUlhUMOlRfJf3L6NaRbAkpFxx
         V8+nUIdFqdOCAgE+zpPsFWqb5kRYuUvXlh/16pyK0LXEMUz5Nqb7BD490PJWl+QrckZt
         iofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775771368; x=1776376168;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Onmcs3eIuMQgZUkFZbAjp3fMYkpAqyA2QjlGccXOLU=;
        b=HnEFnyyoiGwiFUJn0GgZUb0TRuZnZPY2HZ3mW8K0jWb93GCGgRx5K5yAnIGP5maN9q
         pXBOMbJimt53O8ut8VbTlLT86xQaRTuhbAv1Wh3XefX3Oc9PN8szcO0TFKNjbMmXZl92
         IFZxUNia+AqyyPHW/e+BWrxoQg+TsSY7KS5+PToF1w/qLsv7jKtUQ3aqUje6zSr6XBdG
         jw+UZvWjOeJWscSMDPd2OoSYOQnwd4dBjOvD2ERDiQBwfCWvl1FFn/YKW+1R6so0UoOW
         H44cE4Nfcr7tkHugA76yT4S4WSE2XO4uLkkil5jJhH+AksfhiEYQfZBoPyN/KayHtjzu
         M8YQ==
X-Forwarded-Encrypted: i=1; AJvYcCWHPf/IsuEiwkyW7GTjrx9/4URwqeH9S5gzNwywfjPSyWEyvi6G1rL9734Xdz97dpQz91vaMQA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwpARq/qkcUawtKri1RAEcOHNRc6sGk7h2TB0ILiQUtMnGoWmSh
	CcKxd7kfpK2hNRE2qeCb3XQiuh9st3gsAZ9Foc8IPlc1SWcSovocOowxezb5wc3FuX5OgywrnvX
	kfRUgRAROXgO33w==
X-Received: from qtbfk12.prod.google.com ([2002:a05:622a:558c:b0:50d:5a52:e33])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:150:b0:50d:af03:c9ca with SMTP id d75a77b69052e-50dc1b86145mr66759281cf.38.1775771367878;
 Thu, 09 Apr 2026 14:49:27 -0700 (PDT)
Date: Thu,  9 Apr 2026 21:49:05 +0000
In-Reply-To: <20260409214914.3072827-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409214914.3072827-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409214914.3072827-7-edumazet@google.com>
Subject: [PATCH v2 net-next 06/15] net/sched: sch_sfb: annotate data-races in sfb_dump_stats()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277139-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 04E033D0036
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
 net/sched/sch_sfb.c | 46 +++++++++++++++++++++++++++------------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/net/sched/sch_sfb.c b/net/sched/sch_sfb.c
index 2258567cbcaf70863eace85d347efda882a00145..315edd7f87fcf1600d69a3a92733ddb9fee55e99 100644
--- a/net/sched/sch_sfb.c
+++ b/net/sched/sch_sfb.c
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
 		qdisc_qlen_inc(sch);
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
2.53.0.1213.gd9a14994de-goog



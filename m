Return-Path: <netdev+bounces-277508-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMZrJHVA2WkHnwgAu9opvQ
	(envelope-from <netdev+bounces-277508-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:24:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 272553DB708
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 20:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A7089303663E
	for <lists+netdev@lfdr.de>; Fri, 10 Apr 2026 18:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05E503E1D1F;
	Fri, 10 Apr 2026 18:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JuEEJQ7k"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f202.google.com (mail-qt1-f202.google.com [209.85.160.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EF63E3DB6
	for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 18:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775845397; cv=none; b=beLX2DRzmXISgACPGX3Q4GG2pZsrHcrk1wYszWUTFHUN7X93W52o84M1fTlLQXMdOicTUX40Foh7piMDAaYN5AfsRhCvggURkdI/8WWwLKETHJaXeL0Igcxm3wJF9xxLiYbGVXrYuOjY+U2vcAAfPP/Mqz0MWKQhF9RdoE7hThE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775845397; c=relaxed/simple;
	bh=qi885grWNO0I/828DqZRAAvBEncXQAUCR7+TWVwOBJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bL9qfE05cNcBZ4ofwUcQgh1A/tVFVjwIvvvssKIyDky9H79iMa4ddfwUX10DD9bL5Yi/0GVh/Ek8FE6oXBYpvzbj/JrcEfPp9e+m7CKlTE2Qcqht+Rlt50G9tu0N0n/WL3AizmztrtXIZoGGtLJ7IKgjLmLZ/m6QfTwpbzxUs5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JuEEJQ7k; arc=none smtp.client-ip=209.85.160.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f202.google.com with SMTP id d75a77b69052e-50b4661881eso27133851cf.0
        for <netdev@vger.kernel.org>; Fri, 10 Apr 2026 11:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775845395; x=1776450195; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Onmcs3eIuMQgZUkFZbAjp3fMYkpAqyA2QjlGccXOLU=;
        b=JuEEJQ7k99Rz7sZx0c6/opG11YTKT3GQ7QIjtRyssxjaYNo+T60Osus/crzU/Ef1fR
         Nk41TnCNJ3PpRTRt4Ubeulp9+7h+oIuF97AoleqrW4SjXaZWHmmnHYyu5M5X6aiF2z0d
         DUiLbWqa/L2XC+vWKAvnAQnfpoNXhH3euBvJOC9LSVxytCTj7L0xA5L7OVeFyWhy2Epc
         qQiJb5rjGv/tMHCu5JsP3Z76m5PqyLepF6svtSOJOzwP+iHKOXgKpkxMg2HktTFAbEEl
         DX+fbAJG6Ww3b6BpojcDMZ1kT+RoK+2fwMcee9pI08/ZdEmP3izNe1ZR8I+SFDMvYVhJ
         kgzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775845395; x=1776450195;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Onmcs3eIuMQgZUkFZbAjp3fMYkpAqyA2QjlGccXOLU=;
        b=G4ubOz8F5+0jg9kSF1eBTzCk/PyLIb4ZPVk6S/JmyfaXgC04J14DOiaBPgMQopHsTZ
         m/hO1e7Cu7E4bjyCw5XP2/kTFJACVIZa7PJHx/DyWtwM61e5LpelozWZ3YIH0aXtVeYb
         W1Wy3WNiXkpPk2qMGrsfqg3s224yXneP+5iMEJQ/neKlqPsTnNPHkgpYA9vaqJw24EEG
         DYJjba90oNw+DOR32ssPup83DandsxKMKxN89WZetMvHh2bFxR29r/Ggu9GzmwyCmiky
         Bc97lU/91klL3hv2ga7CdG34oKYu8R6/KPEY3uQ9Gz05dvpQuMS3ihRQP21R7ZrTULdF
         cDHA==
X-Forwarded-Encrypted: i=1; AJvYcCUWIO6TVLxeiiaVlUDI+j4bjgtvvsBQoFlplBvpRlRs6IoZT1wttFV4//KotopZWuQKI8AoMP8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyk9Z5oYNfZBMwLsIAvi2eLfWCnKTIXw5+xN5aW61BX+bvukYZh
	4MdJKsMBA3ins4dOpt9epcymVf7/JgXZPD2gxuA6SWP0Pj8+d3YUlikBVVL/Vc7TDUYmjT8WuEd
	K+h/Kef3EkBfwTg==
X-Received: from qtb20.prod.google.com ([2002:a05:622a:8d14:b0:50b:b811:abb5])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:622a:a213:b0:50b:2c9f:dee4 with SMTP id d75a77b69052e-50dd5bf0706mr52412311cf.52.1775845395196;
 Fri, 10 Apr 2026 11:23:15 -0700 (PDT)
Date: Fri, 10 Apr 2026 18:22:48 +0000
In-Reply-To: <20260410182257.774311-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260410182257.774311-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260410182257.774311-7-edumazet@google.com>
Subject: [PATCH v3 net-next 06/15] net/sched: sch_sfb: annotate data-races in sfb_dump_stats()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,vger.kernel.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277508-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 272553DB708
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



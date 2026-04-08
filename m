Return-Path: <netdev+bounces-276521-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mL4XN0dS1mm8DQgAu9opvQ
	(envelope-from <netdev+bounces-276521-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:04:07 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6427E3BC8BC
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 15:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E87CA30D695C
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAC883C2799;
	Wed,  8 Apr 2026 12:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cUVpYGkV"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAF93BBA01
	for <netdev@vger.kernel.org>; Wed,  8 Apr 2026 12:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775652987; cv=none; b=OaZtPijgIGr9EjiaA4dK/VKTnf9LBNEBinFF9anMcIR+bRpOl3IsG2a5X5LamkLrTzWb+GkA4pVzEis32PT5o4B9bwaRlTNrrC4mr9XEG4lDB670DbBDzdxCmInd3dyWdsOfbeGXVumj0NIYISu16DS2BYKlg4mpH07RASlWS5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775652987; c=relaxed/simple;
	bh=qi885grWNO0I/828DqZRAAvBEncXQAUCR7+TWVwOBJc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=j+JWme3tvTsSGb8C51iLrrhKPJdxmWggFg5I6do25GqmIvhZqEHfzOtQ01c227rybN+2AwQVb7mTw2kPHtFNQ8u+Z6Pkcqik5w1Jnoitoipr+xxNE/Vk+jP+pQtDmaZhT1kBqDQ6SDrxyUw0mRYMyubXhwzH2V2fwjUSDpmhDh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cUVpYGkV; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cfbfac0e05so70498485a.1
        for <netdev@vger.kernel.org>; Wed, 08 Apr 2026 05:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775652985; x=1776257785; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+Onmcs3eIuMQgZUkFZbAjp3fMYkpAqyA2QjlGccXOLU=;
        b=cUVpYGkVyFWhjPa8fyZrofl0F78yDGAU2z4qYn0uaax/G8Pra0PDN+a3boBcw7RJ7Z
         +kaDfyZ/e07qOEVO5ddV0uDcq/WkKZKsnAfnbG8kjSsrcQ8WA/Iq4jDy07/HrSm6+3Vl
         /wPZozapg57qaE0mrymrXX7ONtV+7TqW0+L6fhFXl6pzMabwXaW5FkFrhtrvV8yXKvP2
         MxKycXsxqkwclqR4m56dmL7o9fg1FxlsRmS+ypIVB7kQQ45NTMgPfv5KHuPeLSa9vfW+
         OUpOrB0aBj3vRppHL1yxcUK+pgNs52e+uO3nFmfy0V4GNkKO4HBqgtKYLFAxGbnTGbJh
         7pVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775652985; x=1776257785;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+Onmcs3eIuMQgZUkFZbAjp3fMYkpAqyA2QjlGccXOLU=;
        b=bHf8awyHHxj9QCZUB6+Kh49P49Bpw+IH41IMJFyzDSE6spxEPEHtJdXGLmVCJ2dh8a
         0MKdZ4/XeZ6fvwHgvZr5E29BRyZes/L7lm9aMOIj+JA3v8vUBuLFPELitZuVdWw3zS2i
         CA174yvL/GJDTmZHJO7/ZUUgEEaUiW80OFGtdw3ojfuJ3ce83iZ8v7j3V7RsLFcg1uRv
         ihR9zvx10Lv21wQFqCUkJcw/QHiTe2l1lni2RpEQBvhOvULu1M3BpUQHYfSuPOEJmACR
         6C8yJ+zmKJ+4wRMs07yC/QRDTSrEQ/vmBofZC4sqd3lksN41CzglqZ3M3pJx5pEMf9z+
         yELw==
X-Forwarded-Encrypted: i=1; AJvYcCV5bIAVJVrNoarCIcrcDfvHX3IOtmuyqjmkctasLnUXZDL0fxIeOpFgwJCJmueFalpxdonO+vc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTo9c0zN9KURwm1bGyVdd2FtajP2tq+UWW+CFG95I//0ghZ0Bf
	Y+yYsCVru6ZVL5EZV06ubYdwEKVNtzBm+ZVYpzEbPi6AhHhkPrF/cOcVBk+V3HjofNkQnGsFNT1
	RQCdgog+gshWBgA==
X-Received: from qkd20.prod.google.com ([2002:a05:620a:a014:b0:8cd:7a74:41f4])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:711c:b0:8cd:e013:bca0 with SMTP id af79cd13be357-8d3038ff7a5mr2885846485a.33.1775652984652;
 Wed, 08 Apr 2026 05:56:24 -0700 (PDT)
Date: Wed,  8 Apr 2026 12:56:02 +0000
In-Reply-To: <20260408125611.3592751-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260408125611.3592751-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260408125611.3592751-7-edumazet@google.com>
Subject: [PATCH net-next 06/15] net/sched: sch_sfb: annotate data-races in sfb_dump_stats()
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,mojatatu.com,resnulli.us,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276521-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6427E3BC8BC
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



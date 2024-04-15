Return-Path: <netdev+bounces-87957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C9EA8A5150
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:29:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E76A4281400
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11AD84A33;
	Mon, 15 Apr 2024 13:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K6qQv5A5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6456C84D2D
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187272; cv=none; b=rRSVNPM3LT2wNK5GewBtDwH/EqwNEzHYY1Jis/ayLzK3LHiW6gAq35tlr9DVo8nH9eyYKzO8i6jwHt31kEyCi2dridO/0uMa+jh2JB1/MfF85gMArBeHiXZMvlgPECYdUziLK7akary0NSc9imDuC5cQZcH2BewkPXYJ7XZz9lI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187272; c=relaxed/simple;
	bh=/of19FzXX03r5e9tp3Y4j/IZFUS4PnQYt6YCu5IkHPY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TrXzgDfLSYbQB2VPeyGnsAObW5GV4wikFrVWzmpj6tAuCUleLa9xcvQ+TKIz6gEQojE+AOADz3JRo2R6GE/hxf9riP5kZJfUrylxE3lRYybYyP7XJJksr9WrlK1Z2ypbhDj92b81pyFqsXY5VysgeaI9ZZLECSBiQb5z1Gh2vio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K6qQv5A5; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-615073c8dfbso68320697b3.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713187270; x=1713792070; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAhtOdfHh8IMtHNXHnfeZAq6fP+T0FBuITQAqtTMUL4=;
        b=K6qQv5A54yLQX6g3RJEoZAN7hwVaDWtFYB5q5sme6VaU1Wynatj77SY5Pz6tGKKW70
         81SnHIWO7dogERfIBmm0b9rB6Jqsi4YUXA6KsHD+GUj6Xwd6ncjJhbluaKRuMtnW7Sfr
         T1Vhl7sfxmlko7VW+HsOOWu/uiizn1PSvVwHAPvO9n2u69n7gRo2QU88hhRhyLYOF4Rb
         7stscErAmf2wj0+MkLxzfRT4CrRGDxKvnhoD4GsauPru8+f+REQjp/Y+sTmfuVvx7B01
         KJCvsafcDVs6hpMwbfuir74D7ywgFkMy3KbsMeEAQ51rWb4rUi7FRrcnCTT9e5oQKyAZ
         0bjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187270; x=1713792070;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAhtOdfHh8IMtHNXHnfeZAq6fP+T0FBuITQAqtTMUL4=;
        b=VRYVvQuCx66Y9lNwt6nhIVPCmMu/4Y7Xv7HLzye5R6mBSM74RMlqVUM9++8mIOj4Gf
         57rbpeTo1BgAqg4RTb/zhSz9logpivbI6eC72Etj8/tHUcGDisYp3irOz3y32n3siQrt
         56pvHU+p4A8W+YvgkyaYfdQrkvKRkRN7MCsec8yLEqv8qXK4Es4jXRHI2+PS/G1gPxI5
         QzQWrcykAE3qS1WH2piuW1IKicvWSVXTACnTqbx7/fHuoADZnEb3D1UeTj9tbF/IHUKQ
         TlqHB7Su6DsgMFkMfVqg/fkoGKlSrA5zrOE1crdE0UUSQzq++7whd6lBUZCaH7EANxVO
         J24g==
X-Forwarded-Encrypted: i=1; AJvYcCXheq83bQ5eyQ0ZBiAbl01EsMtpWeVdoxG7A1WV5/MDae15wdx6FaT9B2uoZ7tCj7OakJq7m3Kwkm9bvdGmRSI7xSChnPLI
X-Gm-Message-State: AOJu0YyxKOUvwy7lOTf83+iLrgEN/tNP4uSMhs3CwNHqJ3WeYCzAAIMV
	myxYgCq667+d41Im2Oc5WQ722bQr55kiOKTU/Csepu8cIOiJQjQcTbjqNwWnq8jH4HtXZ54Svom
	4y2lO0QZldA==
X-Google-Smtp-Source: AGHT+IEsoaJnnJ8S6Ge4B/Sq97N3Jd7PDPqz+/ZK5hNhm1tC3mfu5EQgJbI2YTa/WjwxFuoTqoC/clS26Mlh9A==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:9293:0:b0:618:876d:b881 with SMTP id
 j141-20020a819293000000b00618876db881mr2138269ywg.9.1713187270503; Mon, 15
 Apr 2024 06:21:10 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:20:50 +0000
In-Reply-To: <20240415132054.3822230-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415132054.3822230-11-edumazet@google.com>
Subject: [PATCH net-next 10/14] net_sched: sch_fq_pie: implement lockless fq_pie_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, fq_pie_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in fq_pie_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq_pie.c | 61 +++++++++++++++++++++++-------------------
 1 file changed, 34 insertions(+), 27 deletions(-)

diff --git a/net/sched/sch_fq_pie.c b/net/sched/sch_fq_pie.c
index 358cf304f4c91203749bac10f6e9154eda0a3778..c38f33ff80bde74cfe33de7558f66e5962ffe56b 100644
--- a/net/sched/sch_fq_pie.c
+++ b/net/sched/sch_fq_pie.c
@@ -299,8 +299,8 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 	if (tb[TCA_FQ_PIE_LIMIT]) {
 		u32 limit = nla_get_u32(tb[TCA_FQ_PIE_LIMIT]);
 
-		q->p_params.limit = limit;
-		sch->limit = limit;
+		WRITE_ONCE(q->p_params.limit, limit);
+		WRITE_ONCE(sch->limit, limit);
 	}
 	if (tb[TCA_FQ_PIE_FLOWS]) {
 		if (q->flows) {
@@ -322,39 +322,45 @@ static int fq_pie_change(struct Qdisc *sch, struct nlattr *opt,
 		u32 target = nla_get_u32(tb[TCA_FQ_PIE_TARGET]);
 
 		/* convert to pschedtime */
-		q->p_params.target =
-			PSCHED_NS2TICKS((u64)target * NSEC_PER_USEC);
+		WRITE_ONCE(q->p_params.target,
+			   PSCHED_NS2TICKS((u64)target * NSEC_PER_USEC));
 	}
 
 	/* tupdate is in jiffies */
 	if (tb[TCA_FQ_PIE_TUPDATE])
-		q->p_params.tupdate =
-			usecs_to_jiffies(nla_get_u32(tb[TCA_FQ_PIE_TUPDATE]));
+		WRITE_ONCE(q->p_params.tupdate,
+			usecs_to_jiffies(nla_get_u32(tb[TCA_FQ_PIE_TUPDATE])));
 
 	if (tb[TCA_FQ_PIE_ALPHA])
-		q->p_params.alpha = nla_get_u32(tb[TCA_FQ_PIE_ALPHA]);
+		WRITE_ONCE(q->p_params.alpha,
+			   nla_get_u32(tb[TCA_FQ_PIE_ALPHA]));
 
 	if (tb[TCA_FQ_PIE_BETA])
-		q->p_params.beta = nla_get_u32(tb[TCA_FQ_PIE_BETA]);
+		WRITE_ONCE(q->p_params.beta,
+			   nla_get_u32(tb[TCA_FQ_PIE_BETA]));
 
 	if (tb[TCA_FQ_PIE_QUANTUM])
-		q->quantum = nla_get_u32(tb[TCA_FQ_PIE_QUANTUM]);
+		WRITE_ONCE(q->quantum, nla_get_u32(tb[TCA_FQ_PIE_QUANTUM]));
 
 	if (tb[TCA_FQ_PIE_MEMORY_LIMIT])
-		q->memory_limit = nla_get_u32(tb[TCA_FQ_PIE_MEMORY_LIMIT]);
+		WRITE_ONCE(q->memory_limit,
+			   nla_get_u32(tb[TCA_FQ_PIE_MEMORY_LIMIT]));
 
 	if (tb[TCA_FQ_PIE_ECN_PROB])
-		q->ecn_prob = nla_get_u32(tb[TCA_FQ_PIE_ECN_PROB]);
+		WRITE_ONCE(q->ecn_prob,
+			   nla_get_u32(tb[TCA_FQ_PIE_ECN_PROB]));
 
 	if (tb[TCA_FQ_PIE_ECN])
-		q->p_params.ecn = nla_get_u32(tb[TCA_FQ_PIE_ECN]);
+		WRITE_ONCE(q->p_params.ecn,
+			   nla_get_u32(tb[TCA_FQ_PIE_ECN]));
 
 	if (tb[TCA_FQ_PIE_BYTEMODE])
-		q->p_params.bytemode = nla_get_u32(tb[TCA_FQ_PIE_BYTEMODE]);
+		WRITE_ONCE(q->p_params.bytemode,
+			   nla_get_u32(tb[TCA_FQ_PIE_BYTEMODE]));
 
 	if (tb[TCA_FQ_PIE_DQ_RATE_ESTIMATOR])
-		q->p_params.dq_rate_estimator =
-			nla_get_u32(tb[TCA_FQ_PIE_DQ_RATE_ESTIMATOR]);
+		WRITE_ONCE(q->p_params.dq_rate_estimator,
+			   nla_get_u32(tb[TCA_FQ_PIE_DQ_RATE_ESTIMATOR]));
 
 	/* Drop excess packets if new limit is lower */
 	while (sch->q.qlen > sch->limit) {
@@ -471,22 +477,23 @@ static int fq_pie_dump(struct Qdisc *sch, struct sk_buff *skb)
 		return -EMSGSIZE;
 
 	/* convert target from pschedtime to us */
-	if (nla_put_u32(skb, TCA_FQ_PIE_LIMIT, sch->limit) ||
-	    nla_put_u32(skb, TCA_FQ_PIE_FLOWS, q->flows_cnt) ||
+	if (nla_put_u32(skb, TCA_FQ_PIE_LIMIT, READ_ONCE(sch->limit)) ||
+	    nla_put_u32(skb, TCA_FQ_PIE_FLOWS, READ_ONCE(q->flows_cnt)) ||
 	    nla_put_u32(skb, TCA_FQ_PIE_TARGET,
-			((u32)PSCHED_TICKS2NS(q->p_params.target)) /
+			((u32)PSCHED_TICKS2NS(READ_ONCE(q->p_params.target))) /
 			NSEC_PER_USEC) ||
 	    nla_put_u32(skb, TCA_FQ_PIE_TUPDATE,
-			jiffies_to_usecs(q->p_params.tupdate)) ||
-	    nla_put_u32(skb, TCA_FQ_PIE_ALPHA, q->p_params.alpha) ||
-	    nla_put_u32(skb, TCA_FQ_PIE_BETA, q->p_params.beta) ||
-	    nla_put_u32(skb, TCA_FQ_PIE_QUANTUM, q->quantum) ||
-	    nla_put_u32(skb, TCA_FQ_PIE_MEMORY_LIMIT, q->memory_limit) ||
-	    nla_put_u32(skb, TCA_FQ_PIE_ECN_PROB, q->ecn_prob) ||
-	    nla_put_u32(skb, TCA_FQ_PIE_ECN, q->p_params.ecn) ||
-	    nla_put_u32(skb, TCA_FQ_PIE_BYTEMODE, q->p_params.bytemode) ||
+			jiffies_to_usecs(READ_ONCE(q->p_params.tupdate))) ||
+	    nla_put_u32(skb, TCA_FQ_PIE_ALPHA, READ_ONCE(q->p_params.alpha)) ||
+	    nla_put_u32(skb, TCA_FQ_PIE_BETA, READ_ONCE(q->p_params.beta)) ||
+	    nla_put_u32(skb, TCA_FQ_PIE_QUANTUM, READ_ONCE(q->quantum)) ||
+	    nla_put_u32(skb, TCA_FQ_PIE_MEMORY_LIMIT,
+			READ_ONCE(q->memory_limit)) ||
+	    nla_put_u32(skb, TCA_FQ_PIE_ECN_PROB, READ_ONCE(q->ecn_prob)) ||
+	    nla_put_u32(skb, TCA_FQ_PIE_ECN, READ_ONCE(q->p_params.ecn)) ||
+	    nla_put_u32(skb, TCA_FQ_PIE_BYTEMODE, READ_ONCE(q->p_params.bytemode)) ||
 	    nla_put_u32(skb, TCA_FQ_PIE_DQ_RATE_ESTIMATOR,
-			q->p_params.dq_rate_estimator))
+			READ_ONCE(q->p_params.dq_rate_estimator)))
 		goto nla_put_failure;
 
 	return nla_nest_end(skb, opts);
-- 
2.44.0.683.g7961c838ac-goog



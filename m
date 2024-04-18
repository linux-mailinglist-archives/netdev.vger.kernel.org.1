Return-Path: <netdev+bounces-89027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C0B8A9417
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B0A9C1F215A3
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68D007C6E3;
	Thu, 18 Apr 2024 07:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R0hIawiQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D92EB7BB15
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425589; cv=none; b=f8Q0i+YdiSV7mP3ALexAwjjC2QxJa4bSNbTCosK/OfHj4he/eud8eDMTjvtOz16A32GUOvdxpX2xMOQnQ58tJTLejEt4nNHG2Xwb1keEE4i8E8KN0NwGmmXq9u37yjCpmm8YIuIFtn4uqkxoP5mckBL48leRugTb0Q4cKi+5hJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425589; c=relaxed/simple;
	bh=b9geUwdvrCVApCZ+TDEP6S5A5EH3GkVRnsbA9/mj3W4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=aIESwF9stZxoNM5EM5JPjzjdpjSakXl4c5kGDJUZ1RRn56TzWLRW10hp+sfzVoIEpN1+JrftzHE9NWr/xxRRBr9LzQzKL2AEptpaxC1k1yyOXcbxvZjY2NuSrIL1YsA5TjGnAFSr4RkReB2mN3pbV1we5ydS0xu/0J3YaChtmXc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R0hIawiQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de46620afd7so775770276.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713425587; x=1714030387; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JcvxTE64aBwZTgLCzhIFcmEI8tlRcvvT0NRZ+mhM1Bc=;
        b=R0hIawiQjZLuoe4par7zicOgpTrY14qHbDLCbmtk8CUCWKOsGoqhV5Cu6GByPKfGjH
         q0hqSApVJLK28pb5wt9q4nWi6nrtUlY0ciP9NGx4oG1hpgFKPrsZiyxXCUJrWEXwROgV
         g9vlc1fsALJOSuRs01YeLRED8Iqj8LKdyhmjLLaSF1eXsRg3CuLxhsYXKbnNQG2vLtgD
         0qRdm27NXVUeYjLHo2uhGNmPcTZd9LTWci5PX/ENV88kQmFza3hJckDWRZ4hw0ubjCMK
         tcfCa6AZ55RP/nXULkYqmDPOENxEJxETC9Q4mue88JvF/o6A0ekBNaqeyBjT6sgfRWz0
         AiKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425587; x=1714030387;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JcvxTE64aBwZTgLCzhIFcmEI8tlRcvvT0NRZ+mhM1Bc=;
        b=NCRCdj+fJUiliaHZ10VomAR+ZNYN01Hk0KphLIQkT15w8+BYh2ntD0yjCQIdFjtP8P
         2oUlycC1SJeRD/hBSZU+C9yrDJuAt6qSebULbic/Cwb7G/qoNtNjWVvkanHSqnbZcX+4
         iKjB10aIkp1G7OLwvwaBgQ4bxvISOS6brHfJe54W5xVAcvzehlvYXpl46cmQklGgeWiA
         BEyQwaCPM3xqiwoP7WMMm1xcJfAjURY5TxtpEHOSuzUgx72ojE0/wG1nVMOATf/VUFWU
         E4pKcQm0y8afBh1Mhi7DiXOqdMZVLSgz27JgokYlRET7KnW1shYkoeYpwZUYvF9rCX3l
         0w+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUtYV9UfIl7JlEV2RWZXc5U+Abj6SkFgaZyifGZykc/Fz3ytYKs2/2cYGdbREq3YghvLwL1KrDnD/5MtrIrMP4vxe7566V/
X-Gm-Message-State: AOJu0YxFVoI1v4QmCVH3Lsb86ZwTeGhz9Ifw7s+Rx4qnITsMCPulh9yI
	2iuqbhv81nDneaNeO45uA4msk0XMPSIw4Iw71WId1UL22y5Mji8E6dZNK5GRaEhd628UkpkVEO5
	6PgawmwFU6w==
X-Google-Smtp-Source: AGHT+IELn3i+Y2Ad7iHrb4eX+JhyqQnWx+5HibSai60IL32eTAFN2QkFiqSgLa1BdsUyI4ZaaMhSyABmBj+2Tg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:d352:0:b0:dcd:c091:e86 with SMTP id
 e79-20020a25d352000000b00dcdc0910e86mr197710ybf.13.1713425587057; Thu, 18 Apr
 2024 00:33:07 -0700 (PDT)
Date: Thu, 18 Apr 2024 07:32:44 +0000
In-Reply-To: <20240418073248.2952954-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418073248.2952954-11-edumazet@google.com>
Subject: [PATCH v2 net-next 10/14] net_sched: sch_fq_pie: implement lockless fq_pie_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, fq_pie_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in fq_pie_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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



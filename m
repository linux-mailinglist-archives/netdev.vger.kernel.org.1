Return-Path: <netdev+bounces-178163-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 09D3FA75159
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 21:16:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 981B31737B0
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 20:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E28C1E51F9;
	Fri, 28 Mar 2025 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ykoHCi8/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEEEA1D4356
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 20:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743193001; cv=none; b=IyajSTTYP+2bDIpMUC5LHccvGIzKOIWmUy9W9eeYF9ffii8XSarbFBqqIFf/6CaPPwlFfEB4sWPgXGGmdCjrrioTh5PYVMHKum43N4aT56Em5sdOf9o/Nhs7+10y6RimINLdwL9DdQ/Cwtzc+yHEAnGqUh+Gk89oabGuib+vPos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743193001; c=relaxed/simple;
	bh=4pKDRF2iwqr49H7DZYsTMHDKvX2XkMm1dW7bXSLKeHU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=asFbRS+ZN9ijXa/Pt04AohH5UeGYEsgXu4mZpb+rx95iQJ9FH+Yo3hOZw3t0doSrzrzNeC+zwPJlKDbWIJz8i0K1H8NDI5a5HXzfdwNhqNyAviFcGKTNVGYX53f7hVSBBGPzPgYsuLQgSEIGvUrJ+NQl0B7uUgMSdIegk0nhvm4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ykoHCi8/; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff854a2541so4019328a91.0
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 13:16:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743192999; x=1743797799; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=g84tB6TTtPFwbjWNx+m4WUrR648noFqvtBZRSiUTd+4=;
        b=ykoHCi8/A8Hhigx9nZFuWjJyzI+axln7MhLokrhqj/tC9OMAKKHS1WQw9NPi08buRa
         Q4rjf4x4vulyGB8vNRqa37Ux12N0rbYYjT5B56mHw1Gc5v1ZpRX10GC8Vl933UPAeLTU
         k1gPUpAeZ3+zW7gE0HbEibqssZqEwRh9h1E+AVhpZmfRHLjlIApdp43588aTR2JRTMiT
         la1kUQRkLh45UA8V5+8rI3A9BHJVx/CJ3lsr9wKTBS8UON1s4mLPrfKXG0EGp2kZovFI
         mrKlvUGLSawgjhK+uFshjkA1B1qiOAZCimeYQnAi3W6Ixc4+AmRzX3SfzrbUR1Npo1fh
         YrYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743192999; x=1743797799;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g84tB6TTtPFwbjWNx+m4WUrR648noFqvtBZRSiUTd+4=;
        b=Ea+uZ/hEbsqsCPRya6TYAmv9/DU32OaQLvpb7DLomai0jKeFUPuCCTFR7giGurzyhr
         dZUhVuUt5YN9CrlyUlWEm1xWktB+6qCW65omX7tDyOlOQnuahlb4I2EtsISIMnC98CdF
         +vVH7f1ISvgKfrlF3Df+lc+sKJtR9HXlTa8HxSEbzyVQoYeecsxwEL760+Xxs4nE8dzG
         UdjR631dyDsZpqPRz8A4SlD9WqT7WhWgQciTnxl2ROtowH8l70EhJnD0ms25uAziVScZ
         cvUygrO28GFfssOAgB+fwOPIgdO76fyguZLMncRrUeRiexBj1zuN5HuMgb8sW65LmjQU
         fo1g==
X-Forwarded-Encrypted: i=1; AJvYcCVDAeKk8iypDyH+bRbEbrYdJnmysKjbKMlmkqHfk8pFy+d6OF8G+7Hj6j2fM9A8g8s2n4c/1sc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWxb8H2iOkHYWbccvV/i8aAB5bK9tyz2P+0Kc4kJjGOKM8OUjp
	APN1aIpt12s2xrpRGet6Al3y1Vl+6THegfM5GX3/ktTrsS86TEqH5V60ys2xvEI+K++Nbm+9rg=
	=
X-Google-Smtp-Source: AGHT+IHOeUK7pBfUR/y08vQ+ZDP8bmgMa/wZrE9pwj8UiKL3n16HPSHJ0UE6F6ZKPvOapoIAUMVV9WH4sw==
X-Received: from pjp4.prod.google.com ([2002:a17:90b:55c4:b0:2ea:3a1b:f493])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90a:d007:b0:301:98fc:9b51
 with SMTP id 98e67ed59e1d1-30531f7beebmr856462a91.5.1743192999226; Fri, 28
 Mar 2025 13:16:39 -0700 (PDT)
Date: Fri, 28 Mar 2025 13:16:32 -0700
In-Reply-To: <20250328201634.3876474-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250328201634.3876474-1-tavip@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328201634.3876474-2-tavip@google.com>
Subject: [PATCH net 1/3] net_sched: sch_sfq: use a temporary work area for
 validating configuration
From: Octavian Purdila <tavip@google.com>
To: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>
Content-Type: text/plain; charset="UTF-8"

Many configuration parameters have influence on others (e.g. divisor
-> flows -> limit, depth -> limit) and so it is difficult to correctly
do all of the validation before applying the configuration. And if a
validation error is detected late it is difficult to roll back a
partially applied configuration.

To avoid these issues use a temporary work area to update and validate
the configuration and only then apply the configuration to the
internal state.

Signed-off-by: Octavian Purdila <tavip@google.com>
---
 net/sched/sch_sfq.c | 60 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 48 insertions(+), 12 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 65d5b59da583..027a3fde2139 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -631,6 +631,18 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 	struct red_parms *p = NULL;
 	struct sk_buff *to_free = NULL;
 	struct sk_buff *tail = NULL;
+	/* work area for validating changes before committing them */
+	struct {
+		int limit;
+		unsigned int divisor;
+		unsigned int maxflows;
+		int perturb_period;
+		unsigned int quantum;
+		u8 headdrop;
+		u8 maxdepth;
+		u8 flags;
+	} tmp;
+
 
 	if (opt->nla_len < nla_attr_size(sizeof(*ctl)))
 		return -EINVAL;
@@ -656,36 +668,60 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
 		return -EINVAL;
 	}
+
 	sch_tree_lock(sch);
+
+	/* copy configuration to work area */
+	tmp.limit = q->limit;
+	tmp.divisor = q->divisor;
+	tmp.headdrop = q->headdrop;
+	tmp.maxdepth = q->maxdepth;
+	tmp.maxflows = q->maxflows;
+	tmp.perturb_period = q->perturb_period;
+	tmp.quantum = q->quantum;
+	tmp.flags = q->flags;
+
+	/* update and validate configuration */
 	if (ctl->quantum)
-		q->quantum = ctl->quantum;
-	WRITE_ONCE(q->perturb_period, ctl->perturb_period * HZ);
+		tmp.quantum = ctl->quantum;
+	tmp.perturb_period = ctl->perturb_period * HZ;
 	if (ctl->flows)
-		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
+		tmp.maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
-		q->divisor = ctl->divisor;
-		q->maxflows = min_t(u32, q->maxflows, q->divisor);
+		tmp.divisor = ctl->divisor;
+		tmp.maxflows = min_t(u32, tmp.maxflows, tmp.divisor);
 	}
 	if (ctl_v1) {
 		if (ctl_v1->depth)
-			q->maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
+			tmp.maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
 		if (p) {
-			swap(q->red_parms, p);
-			red_set_parms(q->red_parms,
+			red_set_parms(p,
 				      ctl_v1->qth_min, ctl_v1->qth_max,
 				      ctl_v1->Wlog,
 				      ctl_v1->Plog, ctl_v1->Scell_log,
 				      NULL,
 				      ctl_v1->max_P);
 		}
-		q->flags = ctl_v1->flags;
-		q->headdrop = ctl_v1->headdrop;
+		tmp.flags = ctl_v1->flags;
+		tmp.headdrop = ctl_v1->headdrop;
 	}
 	if (ctl->limit) {
-		q->limit = min_t(u32, ctl->limit, q->maxdepth * q->maxflows);
-		q->maxflows = min_t(u32, q->maxflows, q->limit);
+		tmp.limit = min_t(u32, ctl->limit, tmp.maxdepth * tmp.maxflows);
+		tmp.maxflows = min_t(u32, tmp.maxflows, tmp.limit);
 	}
 
+	/* commit configuration, no return from this point further */
+	q->limit = tmp.limit;
+	q->divisor = tmp.divisor;
+	q->headdrop = tmp.headdrop;
+	q->maxdepth = tmp.maxdepth;
+	q->maxflows = tmp.maxflows;
+	WRITE_ONCE(q->perturb_period, tmp.perturb_period);
+	q->quantum = tmp.quantum;
+	q->flags = tmp.flags;
+	if (p)
+		swap(q->red_parms, p);
+
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > q->limit) {
 		dropped += sfq_drop(sch, &to_free);
-- 
2.49.0.472.ge94155a9ec-goog



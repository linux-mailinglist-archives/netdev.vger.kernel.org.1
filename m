Return-Path: <netdev+bounces-179936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 822A9A7EF2C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00C7A188A000
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:24:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A5119B3EE;
	Mon,  7 Apr 2025 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Iz+xRnNQ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D7F221573
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744057468; cv=none; b=SBpRBUFPWo4s69+vbpTwhQtpEcJIMYqzeopSWyd8VCkBXN5MKBSDRgYQZUgQzSSzYWST5Wl0aoSE38zjDjQ5uOMYe1n69GI8QyR9nvhcl4RlYcp9HEI7EF0QmkYtjPZDAu/80h08gz73nAmHqf5wnXtk5syzeLShHC5/7YBawaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744057468; c=relaxed/simple;
	bh=fWqtWj+j04Dms4+/ZRub37PlDBaty2SGPEcitWbpPfw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Z22HSNFGAHwaLYsAaFWp9Sa53o/xume60Y5fOJ60/hWt75LLWA58BsW1gIhthpVvEHx1H34XFeZ5vV3B2XJtJCnWalTwzYcjj28xdt0q5AWwRg7o8j0nIvn8YRXOtcejcKM9Fj9MYH9tBrDZgy4O3NY2MUGIMXQkl7sP7Uz65Yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Iz+xRnNQ; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-7395095a505so3637963b3a.1
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 13:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744057466; x=1744662266; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=CazHsfgcUUVAR7Dxm9NnwcUVkKIk2KUXSdD7C2MV/Js=;
        b=Iz+xRnNQFTKd9ENld93ecVDhm+6JKi56YZ7KvToxnrudv7Nilu3aERlSv2XcML28Xh
         McZXNIDYVpRIEVUOxM8aCueXT+LZuTVZ/5egjz7M8r5ulSMWAWnQ5yE/c7yR5JNQ6Ox2
         SlhR+6iXxov5/frM3D8PafxYSZr2weSwV3JCdbXyixm4sBgTznoFeRIWJm9qVKBC13HA
         ZJobT1KI1X/TF1f2t3+O1h85+bsYQm7Um4MBYXo7mEkWzyDbwi/Q/spFeAbgZzKEvhyJ
         XxC8AcZU4oXxQp2JXJgq/GW8EfyFxERgBMs1EmAOwJWWu0jSthpg0NvJqqGyefmDQJHR
         Zs3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744057466; x=1744662266;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CazHsfgcUUVAR7Dxm9NnwcUVkKIk2KUXSdD7C2MV/Js=;
        b=vzZ5ZjD0vRMGe5jryQYID6DuT7ziuQOdNnwW+rcP8zQf1LxrLvLHJoqvtT1IwOi2N0
         hfZXzvlILUYk6QpKXKBztQyCOLmhgi5utKuEh7saaPYIILGuNnto+HhtYfiCg1OMzlLj
         ZVYKN0PkwDn3sQxgbLDzP6gG6L4x3HFDrwPGX42nxiizDyWUDdLMnu58NBgl6KJHiiKo
         fm4t4QkCA6gu1iIuUcqclCYh4/reDrg7JdaMA4u+58csvLAuM+byZw7xmv1FMBIJyJYz
         15X1K1eQty7gdYGTmC1H/jC55QPi7KrD/on8nCT6yXTAdezT8HJ/UZ4JuN4JfhEw6o6H
         gQjg==
X-Forwarded-Encrypted: i=1; AJvYcCWUqZ2/xYjjfWoy6Ko31xdkIQPJR2Z4vp7VyKlntCdONw4A8kMlcDc8xS27S8Nb+cViHPVQaew=@vger.kernel.org
X-Gm-Message-State: AOJu0YxM7xL50lIWcdXZ+WTEJiGSDL9MCczA5d2GDPVlQwXZZQ/hTpbQ
	BXPOxJ6oq+gptvuZTtoFhRgalyQ/9alwINCGMZ1/e+yGudnX4COKbR97gduviwiAzJilJCSsPg=
	=
X-Google-Smtp-Source: AGHT+IHpTmHJa69Q9JsamNrC1Hqs5CxMujZYLCVPkmKnfLGWkvlD7SesdOYJbbOrPVCebFVhmxdWojyzyw==
X-Received: from pfbjc3.prod.google.com ([2002:a05:6a00:6c83:b0:736:4313:e6bc])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3906:b0:736:b402:533a
 with SMTP id d2e1a72fcca58-739e48d58admr17875567b3a.1.1744057466185; Mon, 07
 Apr 2025 13:24:26 -0700 (PDT)
Date: Mon,  7 Apr 2025 13:24:07 -0700
In-Reply-To: <20250407202409.4036738-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407202409.4036738-1-tavip@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407202409.4036738-2-tavip@google.com>
Subject: [PATCH net v3 1/3] net_sched: sch_sfq: use a temporary work area for
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
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_sfq.c | 56 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 44 insertions(+), 12 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 65d5b59da583..7714ae94e052 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -631,6 +631,15 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 	struct red_parms *p = NULL;
 	struct sk_buff *to_free = NULL;
 	struct sk_buff *tail = NULL;
+	unsigned int maxflows;
+	unsigned int quantum;
+	unsigned int divisor;
+	int perturb_period;
+	u8 headdrop;
+	u8 maxdepth;
+	int limit;
+	u8 flags;
+
 
 	if (opt->nla_len < nla_attr_size(sizeof(*ctl)))
 		return -EINVAL;
@@ -656,36 +665,59 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
 		return -EINVAL;
 	}
+
 	sch_tree_lock(sch);
+
+	limit = q->limit;
+	divisor = q->divisor;
+	headdrop = q->headdrop;
+	maxdepth = q->maxdepth;
+	maxflows = q->maxflows;
+	perturb_period = q->perturb_period;
+	quantum = q->quantum;
+	flags = q->flags;
+
+	/* update and validate configuration */
 	if (ctl->quantum)
-		q->quantum = ctl->quantum;
-	WRITE_ONCE(q->perturb_period, ctl->perturb_period * HZ);
+		quantum = ctl->quantum;
+	perturb_period = ctl->perturb_period * HZ;
 	if (ctl->flows)
-		q->maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
+		maxflows = min_t(u32, ctl->flows, SFQ_MAX_FLOWS);
 	if (ctl->divisor) {
-		q->divisor = ctl->divisor;
-		q->maxflows = min_t(u32, q->maxflows, q->divisor);
+		divisor = ctl->divisor;
+		maxflows = min_t(u32, maxflows, divisor);
 	}
 	if (ctl_v1) {
 		if (ctl_v1->depth)
-			q->maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
+			maxdepth = min_t(u32, ctl_v1->depth, SFQ_MAX_DEPTH);
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
+		flags = ctl_v1->flags;
+		headdrop = ctl_v1->headdrop;
 	}
 	if (ctl->limit) {
-		q->limit = min_t(u32, ctl->limit, q->maxdepth * q->maxflows);
-		q->maxflows = min_t(u32, q->maxflows, q->limit);
+		limit = min_t(u32, ctl->limit, maxdepth * maxflows);
+		maxflows = min_t(u32, maxflows, limit);
 	}
 
+	/* commit configuration */
+	q->limit = limit;
+	q->divisor = divisor;
+	q->headdrop = headdrop;
+	q->maxdepth = maxdepth;
+	q->maxflows = maxflows;
+	WRITE_ONCE(q->perturb_period, perturb_period);
+	q->quantum = quantum;
+	q->flags = flags;
+	if (p)
+		swap(q->red_parms, p);
+
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > q->limit) {
 		dropped += sfq_drop(sch, &to_free);
-- 
2.49.0.504.g3bcea36a83-goog



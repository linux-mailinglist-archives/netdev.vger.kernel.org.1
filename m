Return-Path: <netdev+bounces-178846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BDCB1A79333
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:33:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E3D25172D29
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:31:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 222311D63D5;
	Wed,  2 Apr 2025 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k+WY7gj6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 909C3191F66
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 16:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611285; cv=none; b=T+cBiszzfvBBmw4hUucQ6DtxA5VJbUWZud5niQrFX1KkyijKcl2tjBVmdh//a5Jj9gq9LfOhdVGRU8hy7rHmdfRSR+D/eEtc3dveCqB4V0wkZOWjrP73zloxZ/4LpUNjxKUZP63xF0o3TDTHRM4ydHJBGBWqwn4HL+zkEVM5MgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611285; c=relaxed/simple;
	bh=0bssNN+MKMwfQMOFSfuZWruweQvD9Vp7pQOxvE9FyAc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=lh9uuV4XwCUYnr/ythvtEEUOXx3ggE3fwtgraqusFhqsTYY2vjEUWmr8eEgRqVnUc97Mq8NmGD9zJeAeNiJ9cPudb1cOaoZ4omkYoLsDyPOJyOyixNbQEPuhL2/FJBlAisNjrbuQf7rGXdJW3H2NLKto5a2wxWwvx/RX7ZZeRaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k+WY7gj6; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-224192ff68bso336205ad.1
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 09:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743611283; x=1744216083; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy9reO5sSke0/0ENYRrqrhCelECLBO3q4PK9Gtebwhs=;
        b=k+WY7gj6CnDH2iJ87OMyjxVDNy4GM59vZJ9WmESdnFdkNMMdBXtuvJVU3KtRXxeU2w
         SEzJ3Kr4tO1d8P3Ixm24x4mRfRv73od4HYJcEE39mKyWLqcDarWskdT+Uv+veYs5FLma
         cyEwqY9mpcYDqFWRo1QD0nZ+avWTAMLJbIRkgCJMuy/N/W/Lr1bZx+xGObkm4KUey1HW
         c8En6NWCcIGjW9tN4NsYsy52cj8MK5JESy1f/bwjs6cr9gEdq01+EnlVyFxR7g+Z20z5
         d+6JfJZ4kxNUA6paZ6BFR2XjDz0j4yAb3Ai+visAsI9SJ8SD45gNaWhQ2/FoYw65265f
         vw0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743611283; x=1744216083;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy9reO5sSke0/0ENYRrqrhCelECLBO3q4PK9Gtebwhs=;
        b=hj2RudErsCsP8yRlNv15Ybo4almPgOJyROBYTwNlrITJJTNorQVGT6RChilAoNRl5D
         rUzkwJqL5kQR13zEbqwvE+voN6Cz3Vk10csJa8okbJVn0lcR6XSOYfTfU4VAhEbnN4nx
         HREHnaA7nxMx8ixrbmhch6lxnkkA2co0UmqXH+RwG7sZcMOd8JQUW4JmzSVbQg/Zqwco
         jxP+PIUXhQ71t4iWt88zyIciA/DSe4upF3YrZJinHbDBp7ZFxZUNd0xoo1WKpPSD9352
         axB43xSQvcA8MUImU359oXD/cQo7rBjI4QyyKiX+QVupdnOWN8p92NJx5Sx60heM2gGf
         oyhw==
X-Forwarded-Encrypted: i=1; AJvYcCVFfqH8nOcc/D8ABxswHBpqBpKzGmtLaA5FyHdM9aarIWYqCjf5qRxFQrDGRXAR54Y29TuKyCw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxeRQVEV+zE+vA7gUnLy5XOPw1F4kdCbDTjdIMG+Pwsrbkypw+1
	erVH2uBlxCHN8j757ZNUlrEF9GppmV89yotEp/fm6BFFdM8gcXMKtgiThTquwH1GN5BMvmus4A=
	=
X-Google-Smtp-Source: AGHT+IEppDEhXNEnJuuguSyXa29zHUAVxWcgUUPya9ABXzsuDn/hla1s/pdM9tUk5JYU8lrMptyQMBiB8Q==
X-Received: from pfbfn20.prod.google.com ([2002:a05:6a00:2fd4:b0:739:8c87:ed18])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:db12:b0:220:c813:dfce
 with SMTP id d9443c01a7336-2296c839967mr40085235ad.39.1743611282821; Wed, 02
 Apr 2025 09:28:02 -0700 (PDT)
Date: Wed,  2 Apr 2025 09:27:48 -0700
In-Reply-To: <20250402162750.1671155-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250402162750.1671155-1-tavip@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250402162750.1671155-2-tavip@google.com>
Subject: [PATCH net v2 1/3] net_sched: sch_sfq: use a temporary work area for
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
 net/sched/sch_sfq.c | 58 +++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 12 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 65d5b59da583..1af06cd5034a 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -631,6 +631,16 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 	struct red_parms *p = NULL;
 	struct sk_buff *to_free = NULL;
 	struct sk_buff *tail = NULL;
+	/* work area for validating changes before committing them */
+	int limit;
+	unsigned int divisor;
+	unsigned int maxflows;
+	int perturb_period;
+	unsigned int quantum;
+	u8 headdrop;
+	u8 maxdepth;
+	u8 flags;
+
 
 	if (opt->nla_len < nla_attr_size(sizeof(*ctl)))
 		return -EINVAL;
@@ -656,36 +666,60 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
 		return -EINVAL;
 	}
+
 	sch_tree_lock(sch);
+
+	/* copy configuration to work area */
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
 
+	/* commit configuration, no return from this point further */
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
2.49.0.472.ge94155a9ec-goog



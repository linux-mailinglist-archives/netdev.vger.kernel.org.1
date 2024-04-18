Return-Path: <netdev+bounces-89022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 830DF8A9412
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E65A281AAF
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9820877F1B;
	Thu, 18 Apr 2024 07:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XBuYwoyn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1369976020
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:32:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425581; cv=none; b=owXWnxXF/8nfwSt8XPWo+Z6VmyjMvhqStzEOUqLF+GBYZXn1e1XMfcT2+VqesNEDIazi3XtbaLpoyJAmvXqKWtYJ9WxGKJGvG5VExOY066cyfKX01O/Soh0J98/Qrk6qDKUJyg/ou+iO3Tbh7UlpKEeg1XXZHP4uqHl+OTF37Uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425581; c=relaxed/simple;
	bh=2hIFyipII8OOWNDZdnuv0t8Itw/RcH+X7pyy715i53g=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bFwZAd12rWF1scP5rqPff4vtAL3p3Bk0SKlUotqPwddnxlBsC4dZ+Y7HwfRGUIze3CQcsr9rrt5jbFOUoKm04sV+OGxfO5uHOA2E2mOWWo/QLPFWFl7lUWKEzN+JdjUlpqaXK+D2IRFPpNgvdNeed7Wkq6qrAhq7FltDhJCtL5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XBuYwoyn; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-de4691a0918so603144276.0
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:32:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713425579; x=1714030379; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=vSEp7O/SdcZldqzKBrdGB5o96F65O2dgiyTSqodJorE=;
        b=XBuYwoynJ3oY4bkj02tuUWtAtCWz6NKRXHk7q/nZIZt0Yk7joWoMMJMk52NNjEtJTt
         qL/tdrZ3O1E6MYPGwNRxXIeK7SqzC2mKdd+MT13okhJ+9nt2OALhg1SiY1jMs9XrWrDm
         canJGzN5CjuLRQebAuGHyx3sfPcpSRlZjWVsK5oV6Z8be/RK/zOjOTnF/rz4KPLy17nA
         1nDttnwcYzOdR9n5716Q66Friltug9u2/UpjJYictBj9iUZLnHDVkgX5jlYS2/q6i5xX
         D934wurUf760Gbbm6XSZLbWFP9sukx7boasJXBgMgOjLswIVadH8IJFLHO6IM6Flsv2y
         jeLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425579; x=1714030379;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vSEp7O/SdcZldqzKBrdGB5o96F65O2dgiyTSqodJorE=;
        b=jR3jxFnFo4Dv0kFMR0IU8TvCIxq7TOFXLuP0uZ46MQGQjq02eOYbw2wO9tt7tTMIxN
         4JQjePln5eBrcaz0f1Bzp54bvp6USSPy4z9EXncC8gmv37MnWD9t2ZG/kA65RMcrBbLn
         0pb87MPF2U6qLng7LDnqRyRlUZuyNaEeQM5LUywllcZw6CAQ4liu5oD//5ijAbzEMdS5
         dK2cTX3o6P3dFrVIQFYptbwY6Dx0BXLnzwXsDFtBAKA8aj9HRBjfWt/4bwSw8n3RPMxi
         06esbfRBBqdmTwUV26ydYf6nnEUVogi+ZvwSQTyBTCUFLOy0PXLR0VGleTMuR8lrDBqf
         44Vg==
X-Forwarded-Encrypted: i=1; AJvYcCWwJTBawR72jeyeUyHfY+HKZK6atO0UKg/One+NA06tr1ZAQcMRoSeCVM4S2j3fHlwbmIZKZ1Wo7oy+YTfClzmfoQOaNByB
X-Gm-Message-State: AOJu0Yw24EDQfLWzVVEXLN8h2RTVMg1KVNLie/u0EQ/RTQRzNKeOesuR
	U0Jfl5Wq0SKdZVnywRKvxasjV2g5SqfRXAZ/v51TiTAhiePN6U/6Sn1CE/97fRF3C0fk/5aR+8r
	Vu3vMB76mWA==
X-Google-Smtp-Source: AGHT+IEE4Wrsyq6gG13/tp9NyaWks54IOzQgWC50CJdH/TFXdbnWB+U6BDHLE9o0vsCfc9YmMQStimNxCLfTAg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:1001:b0:dda:c4ec:7db5 with SMTP
 id w1-20020a056902100100b00ddac4ec7db5mr449151ybt.4.1713425579078; Thu, 18
 Apr 2024 00:32:59 -0700 (PDT)
Date: Thu, 18 Apr 2024 07:32:39 +0000
In-Reply-To: <20240418073248.2952954-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418073248.2952954-6-edumazet@google.com>
Subject: [PATCH v2 net-next 05/14] net_sched: sch_codel: implement lockless codel_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, codel_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in codel_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
 net/sched/sch_codel.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/net/sched/sch_codel.c b/net/sched/sch_codel.c
index ecb3f164bb25b33bd662c8ee07dc1b5945fd882d..3e8d4fe4d91e3ef2b7715640f6675aa5e8e2a326 100644
--- a/net/sched/sch_codel.c
+++ b/net/sched/sch_codel.c
@@ -118,26 +118,31 @@ static int codel_change(struct Qdisc *sch, struct nlattr *opt,
 	if (tb[TCA_CODEL_TARGET]) {
 		u32 target = nla_get_u32(tb[TCA_CODEL_TARGET]);
 
-		q->params.target = ((u64)target * NSEC_PER_USEC) >> CODEL_SHIFT;
+		WRITE_ONCE(q->params.target,
+			   ((u64)target * NSEC_PER_USEC) >> CODEL_SHIFT);
 	}
 
 	if (tb[TCA_CODEL_CE_THRESHOLD]) {
 		u64 val = nla_get_u32(tb[TCA_CODEL_CE_THRESHOLD]);
 
-		q->params.ce_threshold = (val * NSEC_PER_USEC) >> CODEL_SHIFT;
+		WRITE_ONCE(q->params.ce_threshold,
+			   (val * NSEC_PER_USEC) >> CODEL_SHIFT);
 	}
 
 	if (tb[TCA_CODEL_INTERVAL]) {
 		u32 interval = nla_get_u32(tb[TCA_CODEL_INTERVAL]);
 
-		q->params.interval = ((u64)interval * NSEC_PER_USEC) >> CODEL_SHIFT;
+		WRITE_ONCE(q->params.interval,
+			   ((u64)interval * NSEC_PER_USEC) >> CODEL_SHIFT);
 	}
 
 	if (tb[TCA_CODEL_LIMIT])
-		sch->limit = nla_get_u32(tb[TCA_CODEL_LIMIT]);
+		WRITE_ONCE(sch->limit,
+			   nla_get_u32(tb[TCA_CODEL_LIMIT]));
 
 	if (tb[TCA_CODEL_ECN])
-		q->params.ecn = !!nla_get_u32(tb[TCA_CODEL_ECN]);
+		WRITE_ONCE(q->params.ecn,
+			   !!nla_get_u32(tb[TCA_CODEL_ECN]));
 
 	qlen = sch->q.qlen;
 	while (sch->q.qlen > sch->limit) {
@@ -183,6 +188,7 @@ static int codel_init(struct Qdisc *sch, struct nlattr *opt,
 static int codel_dump(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct codel_sched_data *q = qdisc_priv(sch);
+	codel_time_t ce_threshold;
 	struct nlattr *opts;
 
 	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
@@ -190,17 +196,18 @@ static int codel_dump(struct Qdisc *sch, struct sk_buff *skb)
 		goto nla_put_failure;
 
 	if (nla_put_u32(skb, TCA_CODEL_TARGET,
-			codel_time_to_us(q->params.target)) ||
+			codel_time_to_us(READ_ONCE(q->params.target))) ||
 	    nla_put_u32(skb, TCA_CODEL_LIMIT,
-			sch->limit) ||
+			READ_ONCE(sch->limit)) ||
 	    nla_put_u32(skb, TCA_CODEL_INTERVAL,
-			codel_time_to_us(q->params.interval)) ||
+			codel_time_to_us(READ_ONCE(q->params.interval))) ||
 	    nla_put_u32(skb, TCA_CODEL_ECN,
-			q->params.ecn))
+			READ_ONCE(q->params.ecn)))
 		goto nla_put_failure;
-	if (q->params.ce_threshold != CODEL_DISABLED_THRESHOLD &&
+	ce_threshold = READ_ONCE(q->params.ce_threshold);
+	if (ce_threshold != CODEL_DISABLED_THRESHOLD &&
 	    nla_put_u32(skb, TCA_CODEL_CE_THRESHOLD,
-			codel_time_to_us(q->params.ce_threshold)))
+			codel_time_to_us(ce_threshold)))
 		goto nla_put_failure;
 	return nla_nest_end(skb, opts);
 
-- 
2.44.0.683.g7961c838ac-goog



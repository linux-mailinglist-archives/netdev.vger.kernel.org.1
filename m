Return-Path: <netdev+bounces-87952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B54ED8A5148
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09615B23ADC
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0495839FF;
	Mon, 15 Apr 2024 13:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4KeWPlxv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261F78289B
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187265; cv=none; b=l4Dx4Cq72IjzHQRLf2O+I9Y1X4jybaDHD1c8ykJVg+O0EjTdZTE3Su3Nf9OcZDq/H6uWPWwnYapXSH6JfWWGxpwH9jgBVxoMMVbeF28J2IBrNAYKby0KqHrGwF/9w+AbTpn47kJtGNWp53j1QNBVEVmfBazH9C+0CNS8wBbOii8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187265; c=relaxed/simple;
	bh=LYA3bwzFSwWXh7vf+q+2yIEdnY74hIz5IAwuZ+3bA4k=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=r46Twx2LhttrrnaTpEfkS0y9o12AQ395y9yCQly39VM8Al8hzA6Iqt1YtkWf5LdqpSzMWCNOpz5GrkxUU4hvffWoadwrSFog9884LWjAwA/X7DR9w+WX4RyUA6HUYrYof023CrAQPKncn+kDXbfapqdo8XKOzNRNeVRjjz+/5Wg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4KeWPlxv; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6156b93c768so56246107b3.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713187263; x=1713792063; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cmuUPJtBk0bwiZ86MTFxSbeY1/eRlpmjyYithlp1dMc=;
        b=4KeWPlxvy8T3ohz3EoVPNIeQiBu9TeH/VcrHUEQOXrvowGc8kudV/mNivXBq1wHpDn
         hbKxhIcGeK0nb0oFVYXGOQP5POh2KpewVBmbyrSB4rHozgP9Txp3BWu+3V68eH/PjrI1
         eGAh0d5pN9m0Szpou3DyOW/nuWusDW8IjtT8Zfb2IzXgncfGzy49VbdEm/dIMXLH47Rs
         0xMHdMVa4ThjnXVp9ICP9z3T1/tGnfJTRn3FrB1z0gSAzqNu6gfSMLvCXoSYOHyKheDw
         +LB+kWFNeHOlg+3SRqANQX1z5yOVxhXrdZ/DSoxXv/KtJaq8s626M5rBugcBZmj6MFcT
         cTsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187263; x=1713792063;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cmuUPJtBk0bwiZ86MTFxSbeY1/eRlpmjyYithlp1dMc=;
        b=LCgUVzVRUaaoDv1/LqNiXRGjgsfTtOFMbHiREOfOjR0r+e1ngkeSZWwXYu0X+0TuPr
         Xfr0VRZjEMAQ1MxKXt1hBls7ft02ytRd9sGMoOtI9EMIrh0lLCG3qhgwkUC5bhda+Ziw
         0b6YeCoJV+FAKLaxczMb6jzlqTY+72Q6/LlESY3aiPBU9dpTw87U/sKnP8ZW8Pdj6ah6
         EF/RICLPF7W32vUxrQspceoT876eP59g+YMHKbiEOdt7vdGCyUiygnI4ZMd9UEYPvNDs
         FzpoyIc7DS8VWlrQTu8V6BVVVP08lro0j5NBN/zhXQahSR09vrKugXRMv5lYUFcimMDf
         qgjw==
X-Forwarded-Encrypted: i=1; AJvYcCV9YdGg6A3FiP1LcLG6v9aDyt/9KOvhaLS+iYGb7NNIrii5XgFKWg8jWAa/h5TUWDIXzXTvlOMD+xGuBLB/I4/qK7Wxm++0
X-Gm-Message-State: AOJu0YyvESPOIvLQiaZGXR5ehSAsIiEMD/2BkFptGCFAFuxKQ592qm15
	bqeBV0tee0ktsJgglt0SyeozYIWJkiMcbxKzlT9hoFNvGo9LaOfg9Ca+TQ9UJ81fXft7BxOGHS3
	1Hu660B8RAw==
X-Google-Smtp-Source: AGHT+IGty+tnPcOsU5sURA0IQZyM08U+3ZehF8sHkjN6CsvWmUG+IPJseEXRSPk9i5TYzPpjwYiL1NVGaKo6KQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:848b:0:b0:617:d650:11e2 with SMTP id
 u133-20020a81848b000000b00617d65011e2mr2895762ywf.3.1713187263177; Mon, 15
 Apr 2024 06:21:03 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:20:45 +0000
In-Reply-To: <20240415132054.3822230-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415132054.3822230-6-edumazet@google.com>
Subject: [PATCH net-next 05/14] net_sched: sch_codel: implement lockless codel_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, codel_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in codel_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
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



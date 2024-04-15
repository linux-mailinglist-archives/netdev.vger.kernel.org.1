Return-Path: <netdev+bounces-87959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9412F8A5152
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:29:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B783A1C222E7
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:29:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9FE84E0F;
	Mon, 15 Apr 2024 13:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P9Ywngnl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB9B84DFE
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187275; cv=none; b=O/2ReJwKQcVbMtKvrYALAwz70UAAtKZD861VyaPqMJUan9smY53ed3JFIRf6/vGZ5DwpDFi+nBGoTPor2VfWAJk5RNsI3m9Y6BcocIIz2fQ5cuorVrwfkRw5oujTBE3L2/fmctPusAjlglVQ4Xws27yQukMpDCeWOUAIl1N7CuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187275; c=relaxed/simple;
	bh=EQA1BiJY1jBZJPIIc5yC2exh9WrGdW0bhSkZv5Qbajw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pJ99CDFPzY3fzSxdek6AM58sVpZRLCeGDr20qlz8XJ3VMGSWXX4wtWdyuTFqC/R2wmrkXYG60IwLLgxQdhdEYhRghFrGxCQDW3ckdywuQO39KK0j9VGOLiSdYs/EyfZ1NFYfEp1acgJlkA81sDAydAE1dIHsIUi8Oe25ZoC1Nms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P9Ywngnl; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6156b93c768so56247877b3.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713187273; x=1713792073; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ITIRmHhSvZFTMFP25iD5aD7JQsFtRfJxKTY/gI0nHPM=;
        b=P9Ywngnlayb8z2O3btVI43Bcpjw6C4xNXwl6yfFcQ/Q04WZpM4GicmVwhOh10jmqXO
         sym4MWVylgT0PTJIAXyg0plVNnM+1MowUCHTwVU/YiIdWyYtoB7gf2zMF2tcQWC+Okyb
         FUr3icO2FJexqi2AYZZnRDc5wHfCyZbvNXbzDkek1qOO27c2b8ohzv12JI5oJd3NR2yc
         dHXNYdkXK/5+5mbf1sE6R8oCFBvedUpXTiFjE/YTyoj9MDfX9Wh47qDpGmUVKle4uVkG
         tL6V6ieayxWGOpzrYFlEp69tfNzK9I/0BfuViMgTcmyyiWPdSbE6hdGCSHHd/g2gNeqZ
         KZYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187273; x=1713792073;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ITIRmHhSvZFTMFP25iD5aD7JQsFtRfJxKTY/gI0nHPM=;
        b=Fx9RVdRs3AW4+jfmaS3Hp/fOBIhPkFFq6vfD68dwVJkc8REmV7Np7JJym/0Q5Poa6+
         OvMYggJ6zWauMe5daiYZqkEcR8qOA+5gAfB3B+tEtJx0HNaWqYzxhqMAb3880WtQ0lIo
         EgB7fFs8ISvuwJQmZpFVU4xkh0p3BAX4bzITG0HgMLbyI1y27vhn5hr+xaSnvqn3ue4U
         fAIn2Y+0DquDw1WczcYl6mx9/srAoTNFfxbbrMaEvp4Vez9IWqO9pQB+PAD2AaOsNIm2
         kLMqyrnLt2aI/NZTEAX3YYYbJilrHEFvf1M+48mKk541vyEt3h2RQ3tom2urhSuEQDV8
         F/Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVAGSouOeCxfJE6xllMglcUmLB9ioqMcWBnb0AwH/RbAts6VejWjDjZquSKQ/LiU8aZqxcm7D+byhQsXaaCT1IXDtGRLpGU
X-Gm-Message-State: AOJu0Ywi6uhuvivNF7jrd7cKDOCXDmrrkl/SUo5eRvnad5HiE/jWJCle
	bv9Ht8C1zvCWbX9h48SKDqC0XhZ57NXNUCLFiCIZ9HE/RgWreARuJPVfBL5nlM6pcjmUozueQJZ
	XDosG5Lv8Fg==
X-Google-Smtp-Source: AGHT+IHsPG7dTS8BfJJ2t+ufJxJo67vwLNGqT3JtspuzL/dcIx633ixkHiKY8yx0N+/r3P4XLfEaDu9gkWMU9g==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:690c:e:b0:618:9044:4f8b with SMTP id
 bc14-20020a05690c000e00b0061890444f8bmr2535416ywb.7.1713187273113; Mon, 15
 Apr 2024 06:21:13 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:20:52 +0000
In-Reply-To: <20240415132054.3822230-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415132054.3822230-13-edumazet@google.com>
Subject: [PATCH net-next 12/14] net_sched: sch_hhf: implement lockless hhf_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, hhf_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in hhf_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_hhf.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/net/sched/sch_hhf.c b/net/sched/sch_hhf.c
index 3f906df1435b2edea4286ba56bab68066be238b1..44d9efe1a96a89bdb44a6d48071b3eed90fd5554 100644
--- a/net/sched/sch_hhf.c
+++ b/net/sched/sch_hhf.c
@@ -534,27 +534,31 @@ static int hhf_change(struct Qdisc *sch, struct nlattr *opt,
 	sch_tree_lock(sch);
 
 	if (tb[TCA_HHF_BACKLOG_LIMIT])
-		sch->limit = nla_get_u32(tb[TCA_HHF_BACKLOG_LIMIT]);
+		WRITE_ONCE(sch->limit, nla_get_u32(tb[TCA_HHF_BACKLOG_LIMIT]));
 
-	q->quantum = new_quantum;
-	q->hhf_non_hh_weight = new_hhf_non_hh_weight;
+	WRITE_ONCE(q->quantum, new_quantum);
+	WRITE_ONCE(q->hhf_non_hh_weight, new_hhf_non_hh_weight);
 
 	if (tb[TCA_HHF_HH_FLOWS_LIMIT])
-		q->hh_flows_limit = nla_get_u32(tb[TCA_HHF_HH_FLOWS_LIMIT]);
+		WRITE_ONCE(q->hh_flows_limit,
+			   nla_get_u32(tb[TCA_HHF_HH_FLOWS_LIMIT]));
 
 	if (tb[TCA_HHF_RESET_TIMEOUT]) {
 		u32 us = nla_get_u32(tb[TCA_HHF_RESET_TIMEOUT]);
 
-		q->hhf_reset_timeout = usecs_to_jiffies(us);
+		WRITE_ONCE(q->hhf_reset_timeout,
+			   usecs_to_jiffies(us));
 	}
 
 	if (tb[TCA_HHF_ADMIT_BYTES])
-		q->hhf_admit_bytes = nla_get_u32(tb[TCA_HHF_ADMIT_BYTES]);
+		WRITE_ONCE(q->hhf_admit_bytes,
+			   nla_get_u32(tb[TCA_HHF_ADMIT_BYTES]));
 
 	if (tb[TCA_HHF_EVICT_TIMEOUT]) {
 		u32 us = nla_get_u32(tb[TCA_HHF_EVICT_TIMEOUT]);
 
-		q->hhf_evict_timeout = usecs_to_jiffies(us);
+		WRITE_ONCE(q->hhf_evict_timeout,
+			   usecs_to_jiffies(us));
 	}
 
 	qlen = sch->q.qlen;
@@ -657,15 +661,18 @@ static int hhf_dump(struct Qdisc *sch, struct sk_buff *skb)
 	if (opts == NULL)
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, TCA_HHF_BACKLOG_LIMIT, sch->limit) ||
-	    nla_put_u32(skb, TCA_HHF_QUANTUM, q->quantum) ||
-	    nla_put_u32(skb, TCA_HHF_HH_FLOWS_LIMIT, q->hh_flows_limit) ||
+	if (nla_put_u32(skb, TCA_HHF_BACKLOG_LIMIT, READ_ONCE(sch->limit)) ||
+	    nla_put_u32(skb, TCA_HHF_QUANTUM, READ_ONCE(q->quantum)) ||
+	    nla_put_u32(skb, TCA_HHF_HH_FLOWS_LIMIT,
+			READ_ONCE(q->hh_flows_limit)) ||
 	    nla_put_u32(skb, TCA_HHF_RESET_TIMEOUT,
-			jiffies_to_usecs(q->hhf_reset_timeout)) ||
-	    nla_put_u32(skb, TCA_HHF_ADMIT_BYTES, q->hhf_admit_bytes) ||
+			jiffies_to_usecs(READ_ONCE(q->hhf_reset_timeout))) ||
+	    nla_put_u32(skb, TCA_HHF_ADMIT_BYTES,
+			READ_ONCE(q->hhf_admit_bytes)) ||
 	    nla_put_u32(skb, TCA_HHF_EVICT_TIMEOUT,
-			jiffies_to_usecs(q->hhf_evict_timeout)) ||
-	    nla_put_u32(skb, TCA_HHF_NON_HH_WEIGHT, q->hhf_non_hh_weight))
+			jiffies_to_usecs(READ_ONCE(q->hhf_evict_timeout))) ||
+	    nla_put_u32(skb, TCA_HHF_NON_HH_WEIGHT,
+			READ_ONCE(q->hhf_non_hh_weight)))
 		goto nla_put_failure;
 
 	return nla_nest_end(skb, opts);
-- 
2.44.0.683.g7961c838ac-goog



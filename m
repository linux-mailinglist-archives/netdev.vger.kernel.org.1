Return-Path: <netdev+bounces-87949-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 832B48A5145
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0D526284380
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70D8E8289E;
	Mon, 15 Apr 2024 13:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i80ZAl2w"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C647B2B9CE
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187261; cv=none; b=r1jPVeLJv3arBnGE/yfo6x3LKiVuwCA58+/61Y+CyjAyP7/7hgjX1SzScn7KwpMNNwJttXp5WC5Edz7TaHWjEnmRZRZd7Whw1n5DLzMIezdQPi1adpF6+fRen9Z6C+8/DNsWeXmSXpMd4eS+w/qSqivfRoi9ltH2EykbWwRF9Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187261; c=relaxed/simple;
	bh=q6M6Ex39MfrFakJpmp5HooXS3YphEoOikGGulyXu9P0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TT2rvF6zS0Pz/VjjTsNwbgcaUXBlKJkJfhU7YWxeNPV/r6r0aT9CKPkH5H332XmzXb/UVytK3mAstlan4MeXGVx5D4XUg351F+nmY/ipQpg7pIvkE+rIkdIV8WL33GX+e6BuwHBUuXSBZGO8+QxETDYRaahn1kzq1d2+J5I5pPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i80ZAl2w; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b26783b4so3591407276.0
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713187259; x=1713792059; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EmIru7fcJ7rrvTGZ/l5sMATbKyH6SUanCIhRJqeORnQ=;
        b=i80ZAl2wy9Dyl2BRsgPCqBwva3p9pZkX9mZe2n8RQBuLeUiiLAjTEc1JzpeSk2OjvL
         EKFusy17im6YqLhm5HZcHBErmq8w+SL3klmzppFkSJUnxiBlSW7ulnDGaMcMLa2njFrf
         E0p0YyR4t5d8856SsQofJoNmuXaFPLTopLKBYLwZ92ff0ePTVMgipMZwlJQGAgCVyDqv
         LfYxLfoFqoMzB/dwA/K6F9gMDW508aSeTDEipv0O4fpsUeperghnZlA0oT9zOPAs6te/
         e/sozRjBsy2ULyNur3vaX1Z5I7ec8zUbSZ9dG6KXyUwT7rVN0vI7QfRfskPPgYPuNIZf
         3POw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187259; x=1713792059;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EmIru7fcJ7rrvTGZ/l5sMATbKyH6SUanCIhRJqeORnQ=;
        b=nsrXMjhm3umvl/CzYVdGmSQr1tqw7LMG9w+8Bh9qAqeyQqSYVDvybVZoGEnGCZQ5z7
         ylJltk+d/BmQmqOLv8NC8BNOLLH+LsMW0T38v082Zn/iMk9ep5OYQgPODeMA9TxCKbwa
         5foGWv3YCWnwiuiClPGTD58JwK/bFwY94QygcZbEM3gY5PI/SDVGwmqU7NPd554DaK/K
         J/n3tYLocLcF6OPdkBP4ibOK6puqVlFv7i4cUnZ86V3ITGSsjq0bX9MkV3+N1ujO4ZPl
         7rwDdw4m5jd4lrOPrrSewOZWAjm1XijFcktJ8/tmJ51Z18P2b+QGdPLLneIxe9V9ZxAw
         Kotg==
X-Forwarded-Encrypted: i=1; AJvYcCU5bWlu/eIvokZsk8HuVrQ3eTmkW565uifnC0/QcpiPHOaivKJ3gKr4anyp7zhcTK49FyoQmnpbnzxPS1rwm4978qlG9zrE
X-Gm-Message-State: AOJu0Yy+e/pYgmckQNjIrfPQrDaZH4AXPSMBZtT/PNKQMtHcy1IzmHBe
	Kz0U1QV6DT7uLwg6sutwMpcn6l2hpWqsf6lsaglrftoZSABE5N1apS8UQr0Wq0H09QkcVv3GnXi
	Gk6O1CpJAHA==
X-Google-Smtp-Source: AGHT+IGr+yU9JbowwKBNsCn8b5MYWhgZ4gNvM1ySV8O0jtZ8a9u7FgLRzCvG9HbFC9kUiH8zFv9Sk2lzeChBfw==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:102d:b0:dbe:387d:a8ef with SMTP
 id x13-20020a056902102d00b00dbe387da8efmr599455ybt.1.1713187258823; Mon, 15
 Apr 2024 06:20:58 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:20:42 +0000
In-Reply-To: <20240415132054.3822230-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415132054.3822230-3-edumazet@google.com>
Subject: [PATCH net-next 02/14] net_sched: cake: implement lockless cake_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, cake_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in cake_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_cake.c | 98 +++++++++++++++++++++++++-------------------
 1 file changed, 55 insertions(+), 43 deletions(-)

diff --git a/net/sched/sch_cake.c b/net/sched/sch_cake.c
index 2eabc4dc5b79a83ce423f73c9cccec86f14be7cf..bb37a0dedcc1e4b3418f6681d87108aad7ea066f 100644
--- a/net/sched/sch_cake.c
+++ b/net/sched/sch_cake.c
@@ -2572,6 +2572,7 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct nlattr *tb[TCA_CAKE_MAX + 1];
+	u16 rate_flags;
 	int err;
 
 	err = nla_parse_nested_deprecated(tb, TCA_CAKE_MAX, opt, cake_policy,
@@ -2592,16 +2593,19 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 	}
 
 	if (tb[TCA_CAKE_BASE_RATE64])
-		q->rate_bps = nla_get_u64(tb[TCA_CAKE_BASE_RATE64]);
+		WRITE_ONCE(q->rate_bps,
+			   nla_get_u64(tb[TCA_CAKE_BASE_RATE64]));
 
 	if (tb[TCA_CAKE_DIFFSERV_MODE])
-		q->tin_mode = nla_get_u32(tb[TCA_CAKE_DIFFSERV_MODE]);
+		WRITE_ONCE(q->tin_mode,
+			   nla_get_u32(tb[TCA_CAKE_DIFFSERV_MODE]));
 
+	rate_flags = q->rate_flags;
 	if (tb[TCA_CAKE_WASH]) {
 		if (!!nla_get_u32(tb[TCA_CAKE_WASH]))
-			q->rate_flags |= CAKE_FLAG_WASH;
+			rate_flags |= CAKE_FLAG_WASH;
 		else
-			q->rate_flags &= ~CAKE_FLAG_WASH;
+			rate_flags &= ~CAKE_FLAG_WASH;
 	}
 
 	if (tb[TCA_CAKE_FLOW_MODE])
@@ -2610,11 +2614,13 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 					CAKE_FLOW_MASK));
 
 	if (tb[TCA_CAKE_ATM])
-		q->atm_mode = nla_get_u32(tb[TCA_CAKE_ATM]);
+		WRITE_ONCE(q->atm_mode,
+			   nla_get_u32(tb[TCA_CAKE_ATM]));
 
 	if (tb[TCA_CAKE_OVERHEAD]) {
-		q->rate_overhead = nla_get_s32(tb[TCA_CAKE_OVERHEAD]);
-		q->rate_flags |= CAKE_FLAG_OVERHEAD;
+		WRITE_ONCE(q->rate_overhead,
+			   nla_get_s32(tb[TCA_CAKE_OVERHEAD]));
+		rate_flags |= CAKE_FLAG_OVERHEAD;
 
 		q->max_netlen = 0;
 		q->max_adjlen = 0;
@@ -2623,7 +2629,7 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 	}
 
 	if (tb[TCA_CAKE_RAW]) {
-		q->rate_flags &= ~CAKE_FLAG_OVERHEAD;
+		rate_flags &= ~CAKE_FLAG_OVERHEAD;
 
 		q->max_netlen = 0;
 		q->max_adjlen = 0;
@@ -2632,54 +2638,57 @@ static int cake_change(struct Qdisc *sch, struct nlattr *opt,
 	}
 
 	if (tb[TCA_CAKE_MPU])
-		q->rate_mpu = nla_get_u32(tb[TCA_CAKE_MPU]);
+		WRITE_ONCE(q->rate_mpu,
+			   nla_get_u32(tb[TCA_CAKE_MPU]));
 
 	if (tb[TCA_CAKE_RTT]) {
-		q->interval = nla_get_u32(tb[TCA_CAKE_RTT]);
+		u32 interval = nla_get_u32(tb[TCA_CAKE_RTT]);
 
-		if (!q->interval)
-			q->interval = 1;
+		WRITE_ONCE(q->interval, max(interval, 1U));
 	}
 
 	if (tb[TCA_CAKE_TARGET]) {
-		q->target = nla_get_u32(tb[TCA_CAKE_TARGET]);
+		u32 target = nla_get_u32(tb[TCA_CAKE_TARGET]);
 
-		if (!q->target)
-			q->target = 1;
+		WRITE_ONCE(q->target, max(target, 1U));
 	}
 
 	if (tb[TCA_CAKE_AUTORATE]) {
 		if (!!nla_get_u32(tb[TCA_CAKE_AUTORATE]))
-			q->rate_flags |= CAKE_FLAG_AUTORATE_INGRESS;
+			rate_flags |= CAKE_FLAG_AUTORATE_INGRESS;
 		else
-			q->rate_flags &= ~CAKE_FLAG_AUTORATE_INGRESS;
+			rate_flags &= ~CAKE_FLAG_AUTORATE_INGRESS;
 	}
 
 	if (tb[TCA_CAKE_INGRESS]) {
 		if (!!nla_get_u32(tb[TCA_CAKE_INGRESS]))
-			q->rate_flags |= CAKE_FLAG_INGRESS;
+			rate_flags |= CAKE_FLAG_INGRESS;
 		else
-			q->rate_flags &= ~CAKE_FLAG_INGRESS;
+			rate_flags &= ~CAKE_FLAG_INGRESS;
 	}
 
 	if (tb[TCA_CAKE_ACK_FILTER])
-		q->ack_filter = nla_get_u32(tb[TCA_CAKE_ACK_FILTER]);
+		WRITE_ONCE(q->ack_filter,
+			   nla_get_u32(tb[TCA_CAKE_ACK_FILTER]));
 
 	if (tb[TCA_CAKE_MEMORY])
-		q->buffer_config_limit = nla_get_u32(tb[TCA_CAKE_MEMORY]);
+		WRITE_ONCE(q->buffer_config_limit,
+			   nla_get_u32(tb[TCA_CAKE_MEMORY]));
 
 	if (tb[TCA_CAKE_SPLIT_GSO]) {
 		if (!!nla_get_u32(tb[TCA_CAKE_SPLIT_GSO]))
-			q->rate_flags |= CAKE_FLAG_SPLIT_GSO;
+			rate_flags |= CAKE_FLAG_SPLIT_GSO;
 		else
-			q->rate_flags &= ~CAKE_FLAG_SPLIT_GSO;
+			rate_flags &= ~CAKE_FLAG_SPLIT_GSO;
 	}
 
 	if (tb[TCA_CAKE_FWMARK]) {
-		q->fwmark_mask = nla_get_u32(tb[TCA_CAKE_FWMARK]);
-		q->fwmark_shft = q->fwmark_mask ? __ffs(q->fwmark_mask) : 0;
+		WRITE_ONCE(q->fwmark_mask, nla_get_u32(tb[TCA_CAKE_FWMARK]));
+		WRITE_ONCE(q->fwmark_shft,
+			   q->fwmark_mask ? __ffs(q->fwmark_mask) : 0);
 	}
 
+	WRITE_ONCE(q->rate_flags, rate_flags);
 	if (q->tins) {
 		sch_tree_lock(sch);
 		cake_reconfigure(sch);
@@ -2774,68 +2783,71 @@ static int cake_dump(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct cake_sched_data *q = qdisc_priv(sch);
 	struct nlattr *opts;
+	u16 rate_flags;
 
 	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
 	if (!opts)
 		goto nla_put_failure;
 
-	if (nla_put_u64_64bit(skb, TCA_CAKE_BASE_RATE64, q->rate_bps,
-			      TCA_CAKE_PAD))
+	if (nla_put_u64_64bit(skb, TCA_CAKE_BASE_RATE64,
+			      READ_ONCE(q->rate_bps), TCA_CAKE_PAD))
 		goto nla_put_failure;
 
 	if (nla_put_u32(skb, TCA_CAKE_FLOW_MODE,
-			q->flow_mode & CAKE_FLOW_MASK))
+			READ_ONCE(q->flow_mode) & CAKE_FLOW_MASK))
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, TCA_CAKE_RTT, q->interval))
+	if (nla_put_u32(skb, TCA_CAKE_RTT, READ_ONCE(q->interval)))
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, TCA_CAKE_TARGET, q->target))
+	if (nla_put_u32(skb, TCA_CAKE_TARGET, READ_ONCE(q->target)))
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, TCA_CAKE_MEMORY, q->buffer_config_limit))
+	if (nla_put_u32(skb, TCA_CAKE_MEMORY,
+			READ_ONCE(q->buffer_config_limit)))
 		goto nla_put_failure;
 
+	rate_flags = READ_ONCE(q->rate_flags);
 	if (nla_put_u32(skb, TCA_CAKE_AUTORATE,
-			!!(q->rate_flags & CAKE_FLAG_AUTORATE_INGRESS)))
+			!!(rate_flags & CAKE_FLAG_AUTORATE_INGRESS)))
 		goto nla_put_failure;
 
 	if (nla_put_u32(skb, TCA_CAKE_INGRESS,
-			!!(q->rate_flags & CAKE_FLAG_INGRESS)))
+			!!(rate_flags & CAKE_FLAG_INGRESS)))
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, TCA_CAKE_ACK_FILTER, q->ack_filter))
+	if (nla_put_u32(skb, TCA_CAKE_ACK_FILTER, READ_ONCE(q->ack_filter)))
 		goto nla_put_failure;
 
 	if (nla_put_u32(skb, TCA_CAKE_NAT,
-			!!(q->flow_mode & CAKE_FLOW_NAT_FLAG)))
+			!!(READ_ONCE(q->flow_mode) & CAKE_FLOW_NAT_FLAG)))
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, TCA_CAKE_DIFFSERV_MODE, q->tin_mode))
+	if (nla_put_u32(skb, TCA_CAKE_DIFFSERV_MODE, READ_ONCE(q->tin_mode)))
 		goto nla_put_failure;
 
 	if (nla_put_u32(skb, TCA_CAKE_WASH,
-			!!(q->rate_flags & CAKE_FLAG_WASH)))
+			!!(rate_flags & CAKE_FLAG_WASH)))
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, TCA_CAKE_OVERHEAD, q->rate_overhead))
+	if (nla_put_u32(skb, TCA_CAKE_OVERHEAD, READ_ONCE(q->rate_overhead)))
 		goto nla_put_failure;
 
-	if (!(q->rate_flags & CAKE_FLAG_OVERHEAD))
+	if (!(rate_flags & CAKE_FLAG_OVERHEAD))
 		if (nla_put_u32(skb, TCA_CAKE_RAW, 0))
 			goto nla_put_failure;
 
-	if (nla_put_u32(skb, TCA_CAKE_ATM, q->atm_mode))
+	if (nla_put_u32(skb, TCA_CAKE_ATM, READ_ONCE(q->atm_mode)))
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, TCA_CAKE_MPU, q->rate_mpu))
+	if (nla_put_u32(skb, TCA_CAKE_MPU, READ_ONCE(q->rate_mpu)))
 		goto nla_put_failure;
 
 	if (nla_put_u32(skb, TCA_CAKE_SPLIT_GSO,
-			!!(q->rate_flags & CAKE_FLAG_SPLIT_GSO)))
+			!!(rate_flags & CAKE_FLAG_SPLIT_GSO)))
 		goto nla_put_failure;
 
-	if (nla_put_u32(skb, TCA_CAKE_FWMARK, q->fwmark_mask))
+	if (nla_put_u32(skb, TCA_CAKE_FWMARK, READ_ONCE(q->fwmark_mask)))
 		goto nla_put_failure;
 
 	return nla_nest_end(skb, opts);
-- 
2.44.0.683.g7961c838ac-goog



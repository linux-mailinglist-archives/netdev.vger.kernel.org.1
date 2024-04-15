Return-Path: <netdev+bounces-87956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CBBE58A514F
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 15:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A326B21930
	for <lists+netdev@lfdr.de>; Mon, 15 Apr 2024 13:29:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E37384D39;
	Mon, 15 Apr 2024 13:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jk3eBhks"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0444684A33
	for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 13:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713187271; cv=none; b=fcCf/9y1l/zHfOnfVqT/Fgy1EwkrXBY8lMA92pF8IIYfq9py+IBigp914QE3XnlOrwgZYwLMFqzx9Ys7I8XuPR3+uEeCfoo99rOxYz4IULomv4GH8SMp5QxtPFew89/t+U2cK2g68f8WXD89LC3y0muPOUJjuI1ot97FTAwNjyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713187271; c=relaxed/simple;
	bh=q2pf/Q8BK2H67JUn3au0skahLZKNULIFJDuie3swDPs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ACTxnjLd6GddUobjf1zWzFkR2afR9/qSUZCs4CQYgRUVdv+MBnwOnxW7Dl1HSejHOv+vzMXXdrhlHKJ8E97PDImQcCbUILeg/SA4RZleOqXcjN32FSoyV/mRt84CIE+nq9Gqvv2fyd8f3JYcSs3sR259bWGiJmOhROvAUCkOGOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Jk3eBhks; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-615073c8dfbso68320397b3.1
        for <netdev@vger.kernel.org>; Mon, 15 Apr 2024 06:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713187269; x=1713792069; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=wtygv0E7O7SETFeC6r/7sohZugpAD6woKpEovIj2Kds=;
        b=Jk3eBhks8Qg3vQ+y4eEClke6Ium0TGHSC8AIUkSiL6gZmGHdibBoFlPsMHbn25WXWV
         f/UhQz4fhBsL/RBA/EyZud61BKxoY9n5Z/XdqI8vRScNzMV+ba1C77ydB0LLIlj+xd3l
         ktCAdxHPA5rd5ETQSVf9H7YW0HrmcNFTMB4wXbp1JypFP4zQWPJcQJ4P72XT6fRsVZt4
         lC8I9W4WGTlau4QWF8MUBPtTp3x2whucAceTVupA9R5DJSORAeK61uUiKg75RKVfg8c/
         xXrsbJVs9O+RX1bMNljPyqiulRLzm962HiT+1zKvu39PsNZYnCOxY7FfHwcOvlJ/idvy
         9Hog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713187269; x=1713792069;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wtygv0E7O7SETFeC6r/7sohZugpAD6woKpEovIj2Kds=;
        b=NWIn6SUIefmkACGpalFE6kVmqkLLKGpYht6NYJs6t0RTt8nOXl66bBVwsQLgj26czX
         2jzohLocms7XCOA01X5BkwaqqME3UbfZ9uwylU1CfD37a+bFUTWqa96i0OdnaS+ZQNLo
         kZRQc/xyw6A9twmoIXMNPlme+fctCp+z4GxYNYs0Ko0DTtG91gt/Dpw7jEr1l14+M3KU
         VjX7GcavGzb7jFwIzrpnLgh/QeI0FtOw8upT95Sz/4NSExbN9bXWNaecNY4TS0AxfIyL
         UQmxkAbDmGeSIVEmCKaDvWtEHaLNEMRGgy/b8w12dwQdvdS/UxadX00t3QZGBjPRrPJb
         s2+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXpn/qCAjWsuYk5Gfj82xOu8h7OrfqPGLWArSs2FRogJP6V0rVOMFCFfnRiGGEexrqVbwgOf4eDjsHuHeDOIjwBT+/F0V+U
X-Gm-Message-State: AOJu0Ywnj5e1pZqKDuCbQY8wMBis6UnR48InxuuG+S5MdEF3oA1iVTuk
	FvZE3XeNlz0/BEN/X2Qy3JJBhP4btG/jC+nMlVgLLXIrIVTcpfg6tx5szc6noQ8Fo5VTKUxo4Iu
	tojQTHecHlw==
X-Google-Smtp-Source: AGHT+IHCmEZ22WcUXTZxRpkjgy/6qTaoahXzi20/tfJsbt6gkaqAK72fzjavTOmCrf0OclL7yTqDhGXmrEyxzQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:100e:b0:de0:ecc6:4681 with SMTP
 id w14-20020a056902100e00b00de0ecc64681mr1223343ybt.1.1713187269112; Mon, 15
 Apr 2024 06:21:09 -0700 (PDT)
Date: Mon, 15 Apr 2024 13:20:49 +0000
In-Reply-To: <20240415132054.3822230-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240415132054.3822230-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240415132054.3822230-10-edumazet@google.com>
Subject: [PATCH net-next 09/14] net_sched: sch_fq_codel: implement lockless fq_codel_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, fq_codel_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in fq_codel_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/sched/sch_fq_codel.c | 57 ++++++++++++++++++++++++----------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/net/sched/sch_fq_codel.c b/net/sched/sch_fq_codel.c
index 79f9d6de6c852268fa293f8067d029d385b54976..4f908c11ba9528f8f9f3af6752ff10005d6f6511 100644
--- a/net/sched/sch_fq_codel.c
+++ b/net/sched/sch_fq_codel.c
@@ -396,40 +396,49 @@ static int fq_codel_change(struct Qdisc *sch, struct nlattr *opt,
 	if (tb[TCA_FQ_CODEL_TARGET]) {
 		u64 target = nla_get_u32(tb[TCA_FQ_CODEL_TARGET]);
 
-		q->cparams.target = (target * NSEC_PER_USEC) >> CODEL_SHIFT;
+		WRITE_ONCE(q->cparams.target,
+			   (target * NSEC_PER_USEC) >> CODEL_SHIFT);
 	}
 
 	if (tb[TCA_FQ_CODEL_CE_THRESHOLD]) {
 		u64 val = nla_get_u32(tb[TCA_FQ_CODEL_CE_THRESHOLD]);
 
-		q->cparams.ce_threshold = (val * NSEC_PER_USEC) >> CODEL_SHIFT;
+		WRITE_ONCE(q->cparams.ce_threshold,
+			   (val * NSEC_PER_USEC) >> CODEL_SHIFT);
 	}
 
 	if (tb[TCA_FQ_CODEL_CE_THRESHOLD_SELECTOR])
-		q->cparams.ce_threshold_selector = nla_get_u8(tb[TCA_FQ_CODEL_CE_THRESHOLD_SELECTOR]);
+		WRITE_ONCE(q->cparams.ce_threshold_selector,
+			   nla_get_u8(tb[TCA_FQ_CODEL_CE_THRESHOLD_SELECTOR]));
 	if (tb[TCA_FQ_CODEL_CE_THRESHOLD_MASK])
-		q->cparams.ce_threshold_mask = nla_get_u8(tb[TCA_FQ_CODEL_CE_THRESHOLD_MASK]);
+		WRITE_ONCE(q->cparams.ce_threshold_mask,
+			   nla_get_u8(tb[TCA_FQ_CODEL_CE_THRESHOLD_MASK]));
 
 	if (tb[TCA_FQ_CODEL_INTERVAL]) {
 		u64 interval = nla_get_u32(tb[TCA_FQ_CODEL_INTERVAL]);
 
-		q->cparams.interval = (interval * NSEC_PER_USEC) >> CODEL_SHIFT;
+		WRITE_ONCE(q->cparams.interval,
+			   (interval * NSEC_PER_USEC) >> CODEL_SHIFT);
 	}
 
 	if (tb[TCA_FQ_CODEL_LIMIT])
-		sch->limit = nla_get_u32(tb[TCA_FQ_CODEL_LIMIT]);
+		WRITE_ONCE(sch->limit,
+			   nla_get_u32(tb[TCA_FQ_CODEL_LIMIT]));
 
 	if (tb[TCA_FQ_CODEL_ECN])
-		q->cparams.ecn = !!nla_get_u32(tb[TCA_FQ_CODEL_ECN]);
+		WRITE_ONCE(q->cparams.ecn,
+			   !!nla_get_u32(tb[TCA_FQ_CODEL_ECN]));
 
 	if (quantum)
-		q->quantum = quantum;
+		WRITE_ONCE(q->quantum, quantum);
 
 	if (tb[TCA_FQ_CODEL_DROP_BATCH_SIZE])
-		q->drop_batch_size = max(1U, nla_get_u32(tb[TCA_FQ_CODEL_DROP_BATCH_SIZE]));
+		WRITE_ONCE(q->drop_batch_size,
+			   max(1U, nla_get_u32(tb[TCA_FQ_CODEL_DROP_BATCH_SIZE])));
 
 	if (tb[TCA_FQ_CODEL_MEMORY_LIMIT])
-		q->memory_limit = min(1U << 31, nla_get_u32(tb[TCA_FQ_CODEL_MEMORY_LIMIT]));
+		WRITE_ONCE(q->memory_limit,
+			   min(1U << 31, nla_get_u32(tb[TCA_FQ_CODEL_MEMORY_LIMIT])));
 
 	while (sch->q.qlen > sch->limit ||
 	       q->memory_usage > q->memory_limit) {
@@ -522,6 +531,7 @@ static int fq_codel_init(struct Qdisc *sch, struct nlattr *opt,
 static int fq_codel_dump(struct Qdisc *sch, struct sk_buff *skb)
 {
 	struct fq_codel_sched_data *q = qdisc_priv(sch);
+	codel_time_t ce_threshold;
 	struct nlattr *opts;
 
 	opts = nla_nest_start_noflag(skb, TCA_OPTIONS);
@@ -529,30 +539,33 @@ static int fq_codel_dump(struct Qdisc *sch, struct sk_buff *skb)
 		goto nla_put_failure;
 
 	if (nla_put_u32(skb, TCA_FQ_CODEL_TARGET,
-			codel_time_to_us(q->cparams.target)) ||
+			codel_time_to_us(READ_ONCE(q->cparams.target))) ||
 	    nla_put_u32(skb, TCA_FQ_CODEL_LIMIT,
-			sch->limit) ||
+			READ_ONCE(sch->limit)) ||
 	    nla_put_u32(skb, TCA_FQ_CODEL_INTERVAL,
-			codel_time_to_us(q->cparams.interval)) ||
+			codel_time_to_us(READ_ONCE(q->cparams.interval))) ||
 	    nla_put_u32(skb, TCA_FQ_CODEL_ECN,
-			q->cparams.ecn) ||
+			READ_ONCE(q->cparams.ecn)) ||
 	    nla_put_u32(skb, TCA_FQ_CODEL_QUANTUM,
-			q->quantum) ||
+			READ_ONCE(q->quantum)) ||
 	    nla_put_u32(skb, TCA_FQ_CODEL_DROP_BATCH_SIZE,
-			q->drop_batch_size) ||
+			READ_ONCE(q->drop_batch_size)) ||
 	    nla_put_u32(skb, TCA_FQ_CODEL_MEMORY_LIMIT,
-			q->memory_limit) ||
+			READ_ONCE(q->memory_limit)) ||
 	    nla_put_u32(skb, TCA_FQ_CODEL_FLOWS,
-			q->flows_cnt))
+			READ_ONCE(q->flows_cnt)))
 		goto nla_put_failure;
 
-	if (q->cparams.ce_threshold != CODEL_DISABLED_THRESHOLD) {
+	ce_threshold = READ_ONCE(q->cparams.ce_threshold);
+	if (ce_threshold != CODEL_DISABLED_THRESHOLD) {
 		if (nla_put_u32(skb, TCA_FQ_CODEL_CE_THRESHOLD,
-				codel_time_to_us(q->cparams.ce_threshold)))
+				codel_time_to_us(ce_threshold)))
 			goto nla_put_failure;
-		if (nla_put_u8(skb, TCA_FQ_CODEL_CE_THRESHOLD_SELECTOR, q->cparams.ce_threshold_selector))
+		if (nla_put_u8(skb, TCA_FQ_CODEL_CE_THRESHOLD_SELECTOR,
+			       READ_ONCE(q->cparams.ce_threshold_selector)))
 			goto nla_put_failure;
-		if (nla_put_u8(skb, TCA_FQ_CODEL_CE_THRESHOLD_MASK, q->cparams.ce_threshold_mask))
+		if (nla_put_u8(skb, TCA_FQ_CODEL_CE_THRESHOLD_MASK,
+			       READ_ONCE(q->cparams.ce_threshold_mask)))
 			goto nla_put_failure;
 	}
 
-- 
2.44.0.683.g7961c838ac-goog



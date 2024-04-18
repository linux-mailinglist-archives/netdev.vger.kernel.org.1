Return-Path: <netdev+bounces-89026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 50C2B8A9416
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 09:34:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9539B220CC
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 07:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F10EC7C0B0;
	Thu, 18 Apr 2024 07:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KxxAoSF+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67FA57C08C
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 07:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713425587; cv=none; b=CVf3kH/DIAPdq/VOoUPI7lDkHv+KBrybYoY6TvkKcoSL1o2TMNwXanXfE9fsZBMhBKhkekiKA5Xf2RTe0fCwfXrTV3u/c6YP0JDRIe7THWSamEFWxGxTnm0CY4AM6XYVuijBK+1fTa2TUh6Zbbhc+A8j6P0AVcfawT7R4RvWOSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713425587; c=relaxed/simple;
	bh=OJR8GFUO8+pJk0/M0QUGFcusMywbZZPVv+N+t3FyK/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=BtxjyeI/EviGaNWQACOuEN52JQuM9/P5GJwWYxQqRXTStqK/lFtbz1/lEepX8mEZHMWhc13XfQs3GmRDybGXkEZGi8IGaj7Qq3sNIPDhpDdFcFGlDYgU89Ru0GP0nMesIs6mOztIvo/BVKlS4dHt9qitaqDunwYBokYAxVuCTbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KxxAoSF+; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-60a20c33f06so7549847b3.2
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:33:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713425585; x=1714030385; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=1P53Qros0rXXpmScM4sJQZHx9M+c/CX8Dd9IiqSMITA=;
        b=KxxAoSF+HaVJSUkChioNgH8fZKfn750Wuzf9kMX6Rq3vuV/eEMNNvECPJ9/h8Us5gN
         rRp1Y1ik5oV7ush3YKyzx7oRWZnwh1wafsNjffq76EolOtesCKk2YxaVf0J+fS/jmQb5
         SBRE1j9H8l62/vVCmL50LxHmByKQwGXh4JfuXutIGmNBcF5MxbaRAQOzxf676+6zoVHG
         Hyu5DVd2yh35d1J32CeZzGPEXe7alWiw7gXJrWi8m+yjm9DiiQ6HCrNxRo08nObsBDy0
         wioDWDRJN53vwZzyNOygMGl+pkF61pNE5/URFiqktt5KB3cS8J/ruDR3iaQbF+2ZUcsB
         2q0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713425585; x=1714030385;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1P53Qros0rXXpmScM4sJQZHx9M+c/CX8Dd9IiqSMITA=;
        b=sKq01bP0QqdCnk0L3FE0/uTDHnEQijSbpDWdLefaxsBzxG/+nUQd1eyPCMgBx6pf5O
         HM52D40QybKplYzC9Axc/D9y0A9RpK6uToR1iKP8ee3EjThkBF57/E2gJT0l6S1a6y0s
         mX4wb8AP5cPFoHiKrjoaHNzurxjj0ZnIKI4AfkY8Pt/gRTlu4mT1E+GCR6safw5+MGKx
         XeLIzjWJWJDml3cQIPJU94YMgpNKUABFBGAj4tAAFu6W20yYG/uCX3IJobGNAE86OHXx
         di78Jn/sE/qrAzIXLcb/c+tDHrAenC6rhlcM9YylxG0o0G4cElkgcn4QU3a8Mcikvuv7
         0Xxw==
X-Forwarded-Encrypted: i=1; AJvYcCUB2w0fe2H4GMt8bfS0tOL6oWX3Z1aeuKe1D46KU/2AeJk654NsmpHERCaLq8V4jDzSQnugDThFwHzfgX0uRXLIebkgN3r+
X-Gm-Message-State: AOJu0YwfBiohRMqYIXtqASyJtU44crRRH4kNsF169rrAqBLIF6x/8Wpb
	Z7qJ2psyykk9VPuHfaQTjIjjOcOPdF0DGy+cQxjdao/aPOg+2dCzbdNIVMK++aAdtxX7CdKDLmi
	bTdo4ObnrZw==
X-Google-Smtp-Source: AGHT+IFVsSehM5IIMMpaAGTVzuEwav4O+VMwiSf03Uiik3zsuz/+ioFCI+f3z5RCfBHnNXytHuMsT3DeqEg2eA==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:804b:0:b0:de4:71ad:72f5 with SMTP id
 a11-20020a25804b000000b00de471ad72f5mr2118ybn.12.1713425585508; Thu, 18 Apr
 2024 00:33:05 -0700 (PDT)
Date: Thu, 18 Apr 2024 07:32:43 +0000
In-Reply-To: <20240418073248.2952954-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240418073248.2952954-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240418073248.2952954-10-edumazet@google.com>
Subject: [PATCH v2 net-next 09/14] net_sched: sch_fq_codel: implement lockless fq_codel_dump()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Jamal Hadi Salim <jhs@mojatatu.com>, Simon Horman <horms@kernel.org>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@redhat.com>, Cong Wang <xiyou.wangcong@gmail.com>, 
	Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Instead of relying on RTNL, fq_codel_dump() can use READ_ONCE()
annotations, paired with WRITE_ONCE() ones in fq_codel_change().

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Simon Horman <horms@kernel.org>
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



Return-Path: <netdev+bounces-178164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ACA6A7515A
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 21:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 256FB1895740
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 20:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 125481E835F;
	Fri, 28 Mar 2025 20:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rI+CPn9T"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A3821E8358
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 20:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743193004; cv=none; b=dqZlxLIPMsN6cZ70nqoRetgbta2FtDDV1ne8NKXquh3GOuRO01N4bK+Hr2eWBDYIbhTsE6Bv25Tc5VEToqSgUNPPgLytJWcBHpsNi302mAx9hApnVatFVqM6nhysAvr3FSZsdzluUktPUABjMkMX5U4Fwyz/TrqhNB7IPOzxjFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743193004; c=relaxed/simple;
	bh=/d8vO2C1eeO5N9G7Typl2yyUYpz8IbUG8Oa6nkZ1pLA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=bagIsrdqNl/8swekdjQpAc52cQEkU6yI2WKc2a43xUUspO5Bz2QO9yyo/bKACVBYWK0O+sqojRtOpZgw45tVdy0rnFSl/HxH6lIaizzHKwjTRh/8p4W72vmS44CgrbUfG6Mt/PWEN83rZUHQumGfkOLqG+kmOV2CJRRgQUSOKrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rI+CPn9T; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ff581215f7so2695592a91.3
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 13:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743193001; x=1743797801; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=p0YXNUFYQ3sMTWf05xT4CZP2DxoBoh8fB4N7zDXyH2A=;
        b=rI+CPn9TMicLDZFwbVKmcEP3DI45v6sF5vkXDFWROgHBqOeow6rw4tocDvFPE2uBMF
         XfOqkjx6UbmsmwfW9XJA5eDIX5qDc82FyN4homA9/k4ozi3LYpV+g16qxWB278bwxEPj
         tFRxdufNiiZ+h4HaKDCmlDLh6lbZgkCrv066Ho+NfdvHuX2ogdLXTeCwUpGhYyXfArA3
         pzZhaWUS03YtN+xtyYvaPDZBAOUliCHOBMcGORc5ZMqMfVzErRfSKDM8NbqbOHSVCzok
         B6z14vRNBNoJN411sSbnybCdx2HyZ5dgCwu+m0NuRHpKqlnuEgWwf7Yl6/R+fQv74ZeC
         6jsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743193001; x=1743797801;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p0YXNUFYQ3sMTWf05xT4CZP2DxoBoh8fB4N7zDXyH2A=;
        b=BF+Ut2qMFGu+syB2mqeghM9GaM431NFbq6hff3bN2h+iVE9ZHoKANbc0OMkdlbxiHg
         yGBy+MisEz6rRP8epb6BinZVod/frhQWKcsT+3QG920YihVb53B4KBGSLhaLrlFhn0Y6
         HL5ig7YoYi0MVrDeajItTN0AhzI30D7ZzRHV9NR7UmsdE4eJsxei1lkMrsKZ26RzkIVE
         jdKWXj3GiTxQMu3AkbEYyaoNV4+dLMN9fdyUQTXULPDfBjF4Uammb2SBp2Dm62ndJrNe
         vr5CSJUqgykk8tcLyN4HmBndyDXz9FlNwTAXYt+fIA2Is3ynHpQ0aQZ4uJYTCyHSQWkF
         hXhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWarwOzEacIUyKfa8zQ+hgM+3gPzYuT+a0DPtcRaeg+KJ9wslb2ab+mjEehap4rg881VJFS0W0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTR6fw0OK9gLLCGaUhrT3UcYeHTPQ39fOI7/ZYSD4HlbcDz82e
	kxUZh9HbngVO2YQQiErs2YqUqaDknZ4ei0scgv/jvWwT5qdpeynED4H8S6rOkgZU/YNDY+KIrQ=
	=
X-Google-Smtp-Source: AGHT+IH7GsVfne83CdL1W8HGAxpwontSfLjxTtcPqtRYt4mmyeSInURDrqnUPnm1UOYREYHqzai6w/uc0Q==
X-Received: from pjbse5.prod.google.com ([2002:a17:90b:5185:b0:2f5:63a:4513])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:384d:b0:2ff:58e1:2bb4
 with SMTP id 98e67ed59e1d1-30532153742mr619489a91.22.1743193000859; Fri, 28
 Mar 2025 13:16:40 -0700 (PDT)
Date: Fri, 28 Mar 2025 13:16:33 -0700
In-Reply-To: <20250328201634.3876474-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250328201634.3876474-1-tavip@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250328201634.3876474-3-tavip@google.com>
Subject: [PATCH net 2/3] net_sched: sch_sfq: move the limit validation
From: Octavian Purdila <tavip@google.com>
To: jhs@mojatatu.com, xiyou.wangcong@gmail.com, jiri@resnulli.us
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	pabeni@redhat.com, horms@kernel.org, shuah@kernel.org, netdev@vger.kernel.org, 
	Octavian Purdila <tavip@google.com>, syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

It is not sufficient to directly validate the limit on the data that
the user passes as it can be updated based on how the other parameters
are changed.

Move the check at the end of the configuration update process to also
catch scenarios where the limit is indirectly updated, for example
with the following configurations:

tc qdisc add dev dummy0 handle 1: root sfq limit 2 flows 1 depth 1
tc qdisc add dev dummy0 handle 1: root sfq limit 2 flows 1 divisor 1

This fixes the following syzkaller reported crash:

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/sched/sch_sfq.c:203:6
index 65535 is out of range for type 'struct sfq_head[128]'
CPU: 1 UID: 0 PID: 3037 Comm: syz.2.16 Not tainted 6.14.0-rc2-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x201/0x300 lib/dump_stack.c:120
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0xf5/0x120 lib/ubsan.c:429
 sfq_link net/sched/sch_sfq.c:203 [inline]
 sfq_dec+0x53c/0x610 net/sched/sch_sfq.c:231
 sfq_dequeue+0x34e/0x8c0 net/sched/sch_sfq.c:493
 sfq_reset+0x17/0x60 net/sched/sch_sfq.c:518
 qdisc_reset+0x12e/0x600 net/sched/sch_generic.c:1035
 tbf_reset+0x41/0x110 net/sched/sch_tbf.c:339
 qdisc_reset+0x12e/0x600 net/sched/sch_generic.c:1035
 dev_reset_queue+0x100/0x1b0 net/sched/sch_generic.c:1311
 netdev_for_each_tx_queue include/linux/netdevice.h:2590 [inline]
 dev_deactivate_many+0x7e5/0xe70 net/sched/sch_generic.c:1375

Reported-by: syzbot <syzkaller@googlegroups.com>
Fixes: 10685681bafc ("net_sched: sch_sfq: don't allow 1 packet limit")
Signed-off-by: Octavian Purdila <tavip@google.com>
---
 net/sched/sch_sfq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 027a3fde2139..a9f20cc98a1a 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -664,10 +664,6 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		if (!p)
 			return -ENOMEM;
 	}
-	if (ctl->limit == 1) {
-		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
-		return -EINVAL;
-	}
 
 	sch_tree_lock(sch);
 
@@ -709,6 +705,12 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		tmp.limit = min_t(u32, ctl->limit, tmp.maxdepth * tmp.maxflows);
 		tmp.maxflows = min_t(u32, tmp.maxflows, tmp.limit);
 	}
+	if (tmp.limit == 1) {
+		sch_tree_unlock(sch);
+		kfree(p);
+		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
+		return -EINVAL;
+	}
 
 	/* commit configuration, no return from this point further */
 	q->limit = tmp.limit;
-- 
2.49.0.472.ge94155a9ec-goog



Return-Path: <netdev+bounces-179937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBAEA7EF2E
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 22:24:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6772F188AC0B
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 20:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F05221D86;
	Mon,  7 Apr 2025 20:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T57ti7Us"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EECE21ABD4
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 20:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744057470; cv=none; b=pCLDWRZVhW6gWAmUpgZxiNDvLG0jNYMDbSseMsUeIEsF+AUTbioHCvSk0oXHqKboDzYyACRA2JJr9OgRDXa4GY15LA9u6Xb150l7sJMxwOuCPMU9YA0mRDfJNUPmlyGGquJ4Bpvihdo/vrI52FFvMsvvlCAgBdxplrMfeWUH8Z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744057470; c=relaxed/simple;
	bh=so/FIl3m4zGJkUxqfC8y7RpQ+3s0umMeYYytoKT3a38=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=R1FSpGZd4tUXACoQb6G8n6FQOuMJuM3G8U0YxJ/Fmexo6+MkM/fKDbYYg1Uip7cy8VC2jMMOrzZNWKQxieCbwvHTH4kcPXpzWLvxCiXC6J49YCzxi3ZGUl4Uv6AQZmTTuTtnkaJweX6Zgi4409L6KXpNxRDTwjpEq7HeoF0+a/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T57ti7Us; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-73691c75863so6123222b3a.0
        for <netdev@vger.kernel.org>; Mon, 07 Apr 2025 13:24:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1744057468; x=1744662268; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=z3zdYEN3GupTQqYb3MoxUmEoHfApnc7WRa+fBMJu3jg=;
        b=T57ti7UsI5tTXW1NvF4Vu4UmO3S96417R+HGbs49UEFJ4ljJUoA/IM3wyhLDKrVL79
         +I7eJzSKq33I3goV0AVPgHImw+nsbkyvHYjGbQtDQcFTI2eQxvc5YlT3iCzZq/mmQck4
         qmtXhT41OxqXJxp15wrDDc7wtE0XMDIqRiuHy3Cutge3p571+SigSAljpNKsYF/baHjC
         Mh8WGP9lyh/oCTPD7jdrbJEBLyik9rK4CHdvs/pNfCjkNk2DYl8/FvtRISho3PRUETFE
         U23UlkqOA7JnCvoDTlqUoHdXUv5b8APba4K0UXcBHN56x0IgN1/OjE5aOOBK9eKovuNV
         SftA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744057468; x=1744662268;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z3zdYEN3GupTQqYb3MoxUmEoHfApnc7WRa+fBMJu3jg=;
        b=cYotGRAaZF9Kzc6oU3pNhgvJWmqRIDRoryfAf06R9djxr/LI9yCoM/WWBotwGM+3ZB
         J2xPwbvNq/Bsrnl9f0IMZIVRGXuCkL690T9v9QQPKQy4xHFJoWpAwrUMRwPrGhQe0rhp
         FVxy9CUjoPPzyyjPnWKDCsOqbc1ELl6E2Cw/UJXceScEJ6Cjw5a6yByjLmENw/vXNGW6
         ho1SqLlFPhSvXJrCAgsBu5O0MsS4qZRtkp7jNJ+HYgfOcO/hIPnIbAxarqzGjPG3Biwm
         SGdYlSg3+CNlnY56EvTj5xLO8e9ZR2vqCwliOJLXgBC9qxB666eBwdJtGlA0886VNwnL
         +raQ==
X-Forwarded-Encrypted: i=1; AJvYcCUG9fc1RviYDoomNHqE4assFgxs4ccExV2HtwiMDtbxqfTKofHjOLWZxoO7ESmubhal4bpD9lE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgbK6XB4riHj+Wd+8jmcYuqkiNmVK+W+T+9zF13Qij5+vtq0y8
	IrkIDNjyLeiaWtQBvZWPML94dXnkLpyC8tuZ0ZLXyo0Af+eTizFf68bGRvnogHbJud+1tzYS4g=
	=
X-Google-Smtp-Source: AGHT+IESesL/rXojDRtCr23ih8PeGR5Ul7Az1lhsb+Tjn/k8ZtBRDnIUV3VPK9+IXw2XlP4Ahn3Anzj/VA==
X-Received: from pflb6.prod.google.com ([2002:a05:6a00:a86:b0:730:7485:6b59])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:179b:b0:736:baa0:2acd
 with SMTP id d2e1a72fcca58-739e7156defmr20051690b3a.20.1744057467930; Mon, 07
 Apr 2025 13:24:27 -0700 (PDT)
Date: Mon,  7 Apr 2025 13:24:08 -0700
In-Reply-To: <20250407202409.4036738-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250407202409.4036738-1-tavip@google.com>
X-Mailer: git-send-email 2.49.0.504.g3bcea36a83-goog
Message-ID: <20250407202409.4036738-3-tavip@google.com>
Subject: [PATCH net v3 2/3] net_sched: sch_sfq: move the limit validation
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
Acked-by: Cong Wang <xiyou.wangcong@gmail.com>
---
 net/sched/sch_sfq.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/sched/sch_sfq.c b/net/sched/sch_sfq.c
index 7714ae94e052..58b42dcf8f20 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -661,10 +661,6 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		if (!p)
 			return -ENOMEM;
 	}
-	if (ctl->limit == 1) {
-		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
-		return -EINVAL;
-	}
 
 	sch_tree_lock(sch);
 
@@ -705,6 +701,12 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		limit = min_t(u32, ctl->limit, maxdepth * maxflows);
 		maxflows = min_t(u32, maxflows, limit);
 	}
+	if (limit == 1) {
+		sch_tree_unlock(sch);
+		kfree(p);
+		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
+		return -EINVAL;
+	}
 
 	/* commit configuration */
 	q->limit = limit;
-- 
2.49.0.504.g3bcea36a83-goog



Return-Path: <netdev+bounces-178847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 17D33A79337
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 18:33:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D152188E0DD
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 16:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFA2198A11;
	Wed,  2 Apr 2025 16:28:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SIlEvBaS"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 415F91D79A0
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 16:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743611286; cv=none; b=VHSfHEyfMOIWX9Bzi+I/WA2NZjx3Y/u7/bmo/tTSgxraJjqAN0JNJPx//9DRYcZxct+0sqKTxAjDL3/YKkUrHNqUq6AX77UOoCcxOXdJCv+w0IPLMuadVljaN6NIvzFBLPN8imxneH/k6YUIaXQgBZ72us1QU+tiEQwworPdzDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743611286; c=relaxed/simple;
	bh=D7UVCsXvD8YRTDPaHE9hjbe9eGISg4Hv/4Muj760f/w=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=tl6TMz7VnxJVq+kYFABacWk5q1je1s32BGywVdvVBxRUtUBs2S4eZ5gbJriJSf/qw30SK1eXoGurunOJWZnniwwSfCOKVK5QA8oAhW2/foNJXWVzCwGTSshdinseqc/9ajbIXOsBMAEE3ZJ1tYgRtMygoXaQHLPBZJB+VBQHG+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=SIlEvBaS; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tavip.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-736c0306242so350317b3a.1
        for <netdev@vger.kernel.org>; Wed, 02 Apr 2025 09:28:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1743611284; x=1744216084; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=bAsTAjyHyMhUQ0J+FFaMDsSJV48wWPy7H90qasJ9GVk=;
        b=SIlEvBaSZxQP5p/mWGhwPxX5nCdds0pZiHcaS9ZlJKvwMZS5tLviyJZSqTJxigZplJ
         s/wdrQzkMurwlvD69GsKGTdHfdjtnnl6u0/AOmaARsd/D9S1I/RYaThxXXXWcrB3JOF5
         AXAVQeBOwrNiTCv2oKjxzjfl9055JrLPa0ZeOgWsCFcnkiA7gCO5/41C/b4QPKZ6Dh4T
         tohk3+Crj5hSwrStbjeH64ZrtSs4535Xw06r91OPNCT4qNYAINqINSnd0VeD3fHJsbiN
         nO1ka9kHkZov4Dykok6X8Bgw95auMARk1aiyNClY0FTzBbDNjSurSL4IjfmiHUW1Geje
         fIcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743611284; x=1744216084;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bAsTAjyHyMhUQ0J+FFaMDsSJV48wWPy7H90qasJ9GVk=;
        b=pduAmhffvjGEQmy6LZBXibIt/X+MIdPzTqqtuR1quV/8Dr7oNIzoUcasKhhtrO4Xac
         MaJWLTQOt8+WrX0VrPQvjRTIPHO65Vhe3CVdqN/Hhj6Z04ZSia6b7kXww3hJumA0Xjh+
         VmLhB4YPZVHUz4bzNfoJmqmuOsltaTSDgV0pU8ieywDgdSuVmVZFWvXDKVp1rnDqy5ao
         FAk7xpHjrwe5zUb5elnWhr/cGt88AmD1BPhmszAiOT0KvBp7XS2zf1qtWEoVqm7BSYCu
         I/m5w7K4X1LYf8kijxIqkY5K9aM59EORMQHJE6dd7ScPN9t8goTDW6cSte+YdbIxBsiP
         y7Bw==
X-Forwarded-Encrypted: i=1; AJvYcCU+aPgf3CpYCXKWklyHOu8DMvmEoA+w9+3YWHPxFoD4rXdxhIEgE5Y7Z3141rVJljkTEyGhuXg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyFR0F+CsNq++Hk0u9iYX/r4k32fI0f/oTwA+Fpu1h6kSi/1Mk+
	/kteS4wlo/51eKaTe3dRIJEtKZFCRZFksoWCy48o71YHBeE1S8GMtktmXrVDlETTj1b2U0gAkA=
	=
X-Google-Smtp-Source: AGHT+IHVuUf9ItDd/ojh6QPVVLXRawy3hiGZmQM0wy2ZzaXB44gBTR5XArM2P0mjQOrmQBZxU6ZNVN9yHQ==
X-Received: from pfbfb8.prod.google.com ([2002:a05:6a00:2d88:b0:736:adf0:d154])
 (user=tavip job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:3cc9:b0:736:4cde:5c0e
 with SMTP id d2e1a72fcca58-739803923c7mr23251750b3a.10.1743611284536; Wed, 02
 Apr 2025 09:28:04 -0700 (PDT)
Date: Wed,  2 Apr 2025 09:27:49 -0700
In-Reply-To: <20250402162750.1671155-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250402162750.1671155-1-tavip@google.com>
X-Mailer: git-send-email 2.49.0.472.ge94155a9ec-goog
Message-ID: <20250402162750.1671155-3-tavip@google.com>
Subject: [PATCH net v2 2/3] net_sched: sch_sfq: move the limit validation
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
index 1af06cd5034a..d731013ec851 100644
--- a/net/sched/sch_sfq.c
+++ b/net/sched/sch_sfq.c
@@ -662,10 +662,6 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		if (!p)
 			return -ENOMEM;
 	}
-	if (ctl->limit == 1) {
-		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
-		return -EINVAL;
-	}
 
 	sch_tree_lock(sch);
 
@@ -707,6 +703,12 @@ static int sfq_change(struct Qdisc *sch, struct nlattr *opt,
 		limit = min_t(u32, ctl->limit, maxdepth * maxflows);
 		maxflows = min_t(u32, maxflows, limit);
 	}
+	if (limit == 1) {
+		sch_tree_unlock(sch);
+		kfree(p);
+		NL_SET_ERR_MSG_MOD(extack, "invalid limit");
+		return -EINVAL;
+	}
 
 	/* commit configuration, no return from this point further */
 	q->limit = limit;
-- 
2.49.0.472.ge94155a9ec-goog



Return-Path: <netdev+bounces-217375-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 13077B387B4
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 18:24:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D67413620EE
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 16:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AE223C4F1;
	Wed, 27 Aug 2025 16:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mi8JkMPc"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805B8244681
	for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 16:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756311838; cv=none; b=g6JveogxXa41yTqCDpeRPOHI9agdnZFMPkRQh9mcW+sSvMxNjca5VS4FZ2XQFMn9sG4tTqnJ1JQP/XZmARaJx6uE1ik+F/aolalsbSksPUwBLnyouglOB5A/fQuVce6zoInaZtGNI9qKxbKhxQA62lOymKId7uBMct5ClqK+Q4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756311838; c=relaxed/simple;
	bh=1LnkV0MoLAeFUGJZ5Xx8jwPMo6JcxtlA/zTzJ6LypSY=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=s11nzxfPj0q6YgG8OOAJpUToDoT7iM56QMC8C5WHqMhz6iJreECWRwVYZewczwe24XzuuBHxsF1zhJWKvAPMLRSxrmuse6n6ws0Jn88HM12JT9IkqnHSSGJFN62LZKqqO8qybG8yfkS3wMgTsv1sqJX7Jpj/XfMVNsgoYNp4djU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mi8JkMPc; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-70a9f562165so2099176d6.2
        for <netdev@vger.kernel.org>; Wed, 27 Aug 2025 09:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756311835; x=1756916635; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rr94O84BM9fhXi52/nqW6bH2hiw6AvFNrBVUVwuiws8=;
        b=mi8JkMPcP4Vd0erpyETczo4BtV4ExsQax0SftUc9FRJmp/mF86CFr8SzeyMzHwjZ98
         rVpeKabQeTFB6I8fJmMHABmPCsL6PIjGJbDq6lE2Oct+tVM71vADdwXwQApQQTWJ/cIR
         T4d5W6KoF24gzJ1kXzxpmcFSsPcUfQuzrGAe2jqZWVTlWHBRGmJENd3CdLxF6CYeOIfY
         Cr30n9Nq1OuE/ZT0voSKXWLpOBPpp8KkjtqsUQ8LWObBYIar4oSNNKjQ1wAs0apGMqWP
         pZtwFWjaFXxkIGoMauFYrSNNL/E2U9oHSz8FHrHmeuwOI/wtynNuzH5qxQ4IlAy7gGJS
         d08Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756311835; x=1756916635;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rr94O84BM9fhXi52/nqW6bH2hiw6AvFNrBVUVwuiws8=;
        b=IzCBZ63gWL+BY3CYgruh6nny/tonRJSTFN7yioshi9akdjD6shzZ8tW5yFQcZP1sHY
         s0t5oyw18OAAdMz0hNEc1RVltVU4lobssttWNB/e9otcf63ioZQyGoxUtYanN84UcObC
         Mr9BlLvPK0ITL8kH3QRRDTNsKUn1Xo0LHLSsMy06JP8jdc8RX85IRkvwcZ4o1zRPmzPY
         NGvJstdmW49CMElZBhHrAtAoiMLRcxOQCcKUhvU+dZprL3REA82/iefCivMJ5YyJnIl8
         TMalSULYomjSFCX6lQG1lpw7OH4UBs2g/OwNe/kXtdNKrWh0T5mLORJnQzrRkHVrEshC
         0BiQ==
X-Forwarded-Encrypted: i=1; AJvYcCX4i1Is+ooDBOQeuuI97qon9FQwgJZE/hPQSbn6vgGKkYCnlwVpfT/bABII8wbxBr87TfBlezU=@vger.kernel.org
X-Gm-Message-State: AOJu0YywKUhDeyZv+b3O+co1MpVn5dk+rTzpxH2tD924P50ilX3p9Sb2
	TAb+4MYhnP1VEM7jWhvvjFJI7v1Ykenp6evcPiXy1BqyE4tNpxdP1PF+B0a956DJEfDfN1hji0t
	wnTk9sM3k/GekkQ==
X-Google-Smtp-Source: AGHT+IH9VDLjIe19pgnuMdZQJKkwdKSKd9KsvuruqOKnQQdY2D6uLeZ9WIniOVaq0Q0REjn1VQvH/Km3QtOW7Q==
X-Received: from qvbrb23.prod.google.com ([2002:a05:6214:4e17:b0:70d:8c81:df7c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:509d:b0:70d:b645:4ff4 with SMTP id 6a1803df08f44-70db64551ecmr144450946d6.59.1756311835247;
 Wed, 27 Aug 2025 09:23:55 -0700 (PDT)
Date: Wed, 27 Aug 2025 16:23:52 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250827162352.3960779-1-edumazet@google.com>
Subject: [PATCH v2 net] net_sched: gen_estimator: fix est_timer() vs CONFIG_PREEMPT_RT=y
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Jamal Hadi Salim <jhs@mojatatu.com>, 
	Cong Wang <xiyou.wangcong@gmail.com>, Jiri Pirko <jiri@resnulli.us>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot+72db9ee39db57c3fecc5@syzkaller.appspotmail.com, 
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Content-Type: text/plain; charset="UTF-8"

syzbot reported a WARNING in est_timer() [1]

Problem here is that with CONFIG_PREEMPT_RT=y, timer callbacks
can be preempted.

Adopt preempt_disable_nested()/preempt_enable_nested() to fix this.

[1]
 WARNING: CPU: 0 PID: 16 at ./include/linux/seqlock.h:221 __seqprop_assert include/linux/seqlock.h:221 [inline]
 WARNING: CPU: 0 PID: 16 at ./include/linux/seqlock.h:221 est_timer+0x6dc/0x9f0 net/core/gen_estimator.c:93
Modules linked in:
CPU: 0 UID: 0 PID: 16 Comm: ktimers/0 Not tainted syzkaller #0 PREEMPT_{RT,(full)}
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
 RIP: 0010:__seqprop_assert include/linux/seqlock.h:221 [inline]
 RIP: 0010:est_timer+0x6dc/0x9f0 net/core/gen_estimator.c:93
Call Trace:
 <TASK>
  call_timer_fn+0x17e/0x5f0 kernel/time/timer.c:1747
  expire_timers kernel/time/timer.c:1798 [inline]
  __run_timers kernel/time/timer.c:2372 [inline]
  __run_timer_base+0x648/0x970 kernel/time/timer.c:2384
  run_timer_base kernel/time/timer.c:2393 [inline]
  run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2403
  handle_softirqs+0x22c/0x710 kernel/softirq.c:579
  __do_softirq kernel/softirq.c:613 [inline]
  run_ktimerd+0xcf/0x190 kernel/softirq.c:1043
  smpboot_thread_fn+0x53f/0xa60 kernel/smpboot.c:160
  kthread+0x70e/0x8a0 kernel/kthread.c:463
  ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Fixes: d2d6422f8bd1 ("x86: Allow to enable PREEMPT_RT.")
Reported-by: syzbot+72db9ee39db57c3fecc5@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/68adf6fa.a70a0220.3cafd4.0000.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v2: fixed patch title, CC net/sched maintainers.
 net/core/gen_estimator.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/core/gen_estimator.c b/net/core/gen_estimator.c
index 7d426a8e29f30b67655cf706060bfc6c478f3123..f112156db587ba54a995a68ead5a35fe0cb16230 100644
--- a/net/core/gen_estimator.c
+++ b/net/core/gen_estimator.c
@@ -90,10 +90,12 @@ static void est_timer(struct timer_list *t)
 	rate = (b_packets - est->last_packets) << (10 - est->intvl_log);
 	rate = (rate >> est->ewma_log) - (est->avpps >> est->ewma_log);
 
+	preempt_disable_nested();
 	write_seqcount_begin(&est->seq);
 	est->avbps += brate;
 	est->avpps += rate;
 	write_seqcount_end(&est->seq);
+	preempt_enable_nested();
 
 	est->last_bytes = b_bytes;
 	est->last_packets = b_packets;
-- 
2.51.0.261.g7ce5a0a67e-goog



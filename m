Return-Path: <netdev+bounces-217028-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC75B371EA
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 20:05:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 705A9364D22
	for <lists+netdev@lfdr.de>; Tue, 26 Aug 2025 18:05:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 328142356D2;
	Tue, 26 Aug 2025 18:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WUKVFOqT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 979A43208
	for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 18:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756231514; cv=none; b=imyO+bppSl64WqCgaMZn5Zyf5XwaNyoxGXposJYxZpBvLOUAYyLbsvPOlXIb7b1+Oh61QdKxt3lXgoV8C/tW1SZJvHshHz33Tp3P8qAtvbNHhTxzjbWPToOYgf9aojBrjPwwbu0g1kGW9hpYNYf9JmON5Ed6aDCKwssPQDAc3+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756231514; c=relaxed/simple;
	bh=Nix/RWZgodwM6vweB5ErFgNglsA9xiYrHVot2oaGpGk=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oOu4J05HFPv1qRjxHJHDc7ipsOoL+oaIMCsUVdpg7qrQfQ7tky6foviQx5xZ8wvIyNIuaAVS0cmfLeVwmhk55uUp3X88Jst1aTPBPkKXtl+u6yl/i9XhTZI0E+qmFmFndEqNZlU9J8MRmJacwwRPiZfY9wRwZvCtiQO1lGbTK1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=WUKVFOqT; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e9534cfa871so4810419276.2
        for <netdev@vger.kernel.org>; Tue, 26 Aug 2025 11:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1756231510; x=1756836310; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=y3Aii28T9vPldHhclbcbIvp4RFLfuON+MN5ebhgwpcc=;
        b=WUKVFOqT5HkFTFai3Z5YY3znzKXf9d9gPdJCWQ/c3Y3xUI5kKtzewMtue1zF4X0DcM
         001T5dQs3VJucZrycTCSfuO78cLgFOMAS28Z+orU0TkKus0kuzY0/TdoebMA4I1Na7Ec
         aQe+xlxyRI4Ip9MK2kGwMrkcctyWCneinht94iPM64Tm048zpabZCdeE4uvPM2V9vkmf
         MeDdDPeZx9n5C17uUGaeeRjbxjacOWoTpu+WRo56tTgLN0xPyHgXS25ciM3m2hByFiVu
         YGjB2/utvRAwx4q0pYnNbvhxbbsiJDoQrI2p1u055pxQvwvVUn4ENIp37hnE/3uBFYdR
         l3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756231510; x=1756836310;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y3Aii28T9vPldHhclbcbIvp4RFLfuON+MN5ebhgwpcc=;
        b=eVhbYy5BCU5B03Er99y1gd8ulhzSXfvLnk70/9BCL5cIf8ewW0gxrEZhpNwxTRAO0B
         sPvFZzzVCCqkgB32gCAtmMCMGE4XdzA78wUda6dTOUMgg4wPImxLy1XTF3LFf0oBhv6N
         shQlN0hmDjfccFExoDXF3/NZufckoAXbZ8ghXibTQzDauj/X348mJSJN/opnjk+f5u0d
         cvrUIIjXasMbuqWdKlu1PiRFoo65dkE3TapUDV2v1FNAv45HakOPosh78l/CXPgwQSj4
         17FHBl4wUR56wnMo78qzPDJ29ff+PVJY3vHQW5d8BBgEYW8RnXVTqikj5gmpahIMn+6k
         G3GQ==
X-Forwarded-Encrypted: i=1; AJvYcCX88KnoHvsW94WArN3pdJPFlo2pUyX+d8cqobkEstnc2MmgDtb2s8oGw7Mix1HQemhaDPWz53M=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzR0ALECndPSE+njA0XwEyX4woa3NuqHvwq23TauzwLQiEZLPk
	cHSMjJBd/CPpfjgitv42zhIfOB6N1FuvY7sE1Fgcn7kJLZDDw8SgHV8M94vnyDY0xSlP+xtJVKf
	TPEHlfuTj1bvFOA==
X-Google-Smtp-Source: AGHT+IG4CaiIJCUIvCPLzH3Ix5xQv4TcU4/UnUVGG+ftypS5uMbfOfme8pgsVKmu+NeVeFfPewjgQbyvmUs7Tw==
X-Received: from ybex17.prod.google.com ([2002:a25:ce11:0:b0:e96:e93a:7d8])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:1889:b0:e96:94a1:d221 with SMTP id 3f1490d57ef6-e9694a1d39dmr9466455276.24.1756231510517;
 Tue, 26 Aug 2025 11:05:10 -0700 (PDT)
Date: Tue, 26 Aug 2025 18:05:08 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.51.0.261.g7ce5a0a67e-goog
Message-ID: <20250826180508.2141197-1-edumazet@google.com>
Subject: [PATCH net] net_sched: gen_estimator:
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+72db9ee39db57c3fecc5@syzkaller.appspotmail.com, 
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



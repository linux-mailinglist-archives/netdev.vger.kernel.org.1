Return-Path: <netdev+bounces-130070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4974E987FB4
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 09:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCDDF1F236E8
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 07:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F86189514;
	Fri, 27 Sep 2024 07:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vfkdV9Fo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FAD17C98E
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 07:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727423158; cv=none; b=Kt2IBIUtWQ5oDgMNg43psyQH/6p1O8TdLrGFZO8NSDeP4flGRc9Srq4dlIA70xJL6MRdZNLBq2kG2zjbTJNiZrdmEyFM3v+CGACE37LrBZMHwgSlJ8yuvs5rtri1hMS88+cNyO7dXKCEPBc96f3HNrkJPhPiH11Qw8pDROHSJUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727423158; c=relaxed/simple;
	bh=dGHWEFKbK9NV3M7oFRGPIqxu8D9llSJvGCog9SZQu6Q=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=fP7d4Yk7zwtXf6d5p8LHhlxFJsqcz1BKkK4Va8hAV+V1kCsrRc9tDFOpKXYDTJdzOgzRBDCJDioQpTk6R1qdLr5pyUJg7Xli0YpVDSGH9ufOWzwJW/CmWO91zhKcL8xFUB2A16g5mCnrK4cSvrnhnQ2BZj/KzRzHbUxsXurUQDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vfkdV9Fo; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-7acac374c62so320536685a.0
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 00:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727423155; x=1728027955; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pUF4RBI4M79Gi4DYza1gFrabJdISv0HpCIwZl1HdFfE=;
        b=vfkdV9FoyPYXJP43kvc6Mkvm8ZQW99mXiwCeUX0ptgZq8+wvrUYyAh2iLPp1QiFYSN
         hNqlckHWP7ad0OO3DA/BtHAptFApOE6YTxePISOBW0+v2TX6GwNtrLaOModccl/JgBoW
         xsrp0FlyOknmBYkel+Sj9vARDva8K4IGy/ahuDM7ina7x7dw25zxF9r7+5M1UaDLohlt
         XeQ8vAe7IvBd/inJSYRmEOmRiZ21Xaq4MwMgOOPz9h38qpeAYoPQutEzFmT9CSwrsffN
         plK/Rk4FAgnB2rmo9bwwcwMZVlLkbESxhCwWM+kCqvBCxNAhUo10MwLyZ8vKTaK4Gr/2
         ezPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727423155; x=1728027955;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pUF4RBI4M79Gi4DYza1gFrabJdISv0HpCIwZl1HdFfE=;
        b=JrRMDfglrbhUm2EIUk7oE3m23fHbe592sBHD3tq+XVYUpek1EwloyvdCY/LCjDxmWM
         uVsqlm0J8J9Ewwk2G1xCl/jhZdl2VY5sLIgAYvfEjriRsHAfl2jUVYwK2b1fsWyKCC/I
         iLftPBDlY5e8zXopVqsL9xoaRZsYfiv+ORpEljrnRKu5JMvH8fOhqgn2qFB+TMD9SUGb
         frUFsK6OnGxAun4UWki9DhA7E3JDejvoVLvkl287GwgI7fzBzqRZLScTUCcLx+vWNrbK
         XTMWcBCymKyNTwHMXT5B9RQLXhbjfzMhnmPMSMWyD1AHbb2mcu3iiE4pqfJ/a1Nv7KJA
         tB2Q==
X-Gm-Message-State: AOJu0YyVx47CqZ0/4081/Ii5SEVmEQBKlLeArrgUJNnL7vXZwzFMPlC1
	xXE4cScguY4f6iH3HDtaB8S/fgNjSGzUPkgNMRJ5S5IOiH9ntHwsl7mlAkSXceV8P9/Xqr4bxGo
	Sm4KZORMCBQ==
X-Google-Smtp-Source: AGHT+IEweebBqYiy8/7NgifFD1X4JSJ0dea3dkGo3dgtab6WGPHpMIEIEDGFTuyCDzyXNaxWEORAiEetqSlMvQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:f7:ea0b:ac12:11d6])
 (user=edumazet job=sendgmr) by 2002:a05:620a:4b42:b0:7ac:9ce5:82b0 with SMTP
 id af79cd13be357-7ae378b97bfmr159785a.9.1727423155130; Fri, 27 Sep 2024
 00:45:55 -0700 (PDT)
Date: Fri, 27 Sep 2024 07:45:53 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240927074553.341910-1-edumazet@google.com>
Subject: [PATCH net] ppp: do not assume bh is held in ppp_channel_bridge_input()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, syzbot+bd8d55ee2acd0a71d8ce@syzkaller.appspotmail.com, 
	Tom Parkin <tparkin@katalix.com>, James Chapman <jchapman@katalix.com>
Content-Type: text/plain; charset="UTF-8"

Networking receive path is usually handled from BH handler.
However, some protocols need to acquire the socket lock, and
packets might be stored in the socket backlog is the socket was
owned by a user process.

In this case, release_sock(), __release_sock(), and sk_backlog_rcv()
might call the sk->sk_backlog_rcv() handler in process context.

sybot caught ppp was not considering this case in
ppp_channel_bridge_input() :

WARNING: inconsistent lock state
6.11.0-rc7-syzkaller-g5f5673607153 #0 Not tainted
--------------------------------
inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
ksoftirqd/1/24 [HC0[0]:SC1[1]:HE1:SE0] takes:
 ffff0000db7f11e0 (&pch->downl){+.?.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 ffff0000db7f11e0 (&pch->downl){+.?.}-{2:2}, at: ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2272 [inline]
 ffff0000db7f11e0 (&pch->downl){+.?.}-{2:2}, at: ppp_input+0x16c/0x854 drivers/net/ppp/ppp_generic.c:2304
{SOFTIRQ-ON-W} state was registered at:
   lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
   __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
   _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
   spin_lock include/linux/spinlock.h:351 [inline]
   ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2272 [inline]
   ppp_input+0x16c/0x854 drivers/net/ppp/ppp_generic.c:2304
   pppoe_rcv_core+0xfc/0x314 drivers/net/ppp/pppoe.c:379
   sk_backlog_rcv include/net/sock.h:1111 [inline]
   __release_sock+0x1a8/0x3d8 net/core/sock.c:3004
   release_sock+0x68/0x1b8 net/core/sock.c:3558
   pppoe_sendmsg+0xc8/0x5d8 drivers/net/ppp/pppoe.c:903
   sock_sendmsg_nosec net/socket.c:730 [inline]
   __sock_sendmsg net/socket.c:745 [inline]
   __sys_sendto+0x374/0x4f4 net/socket.c:2204
   __do_sys_sendto net/socket.c:2216 [inline]
   __se_sys_sendto net/socket.c:2212 [inline]
   __arm64_sys_sendto+0xd8/0xf8 net/socket.c:2212
   __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
   invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
   el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
   do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
   el0_svc+0x54/0x168 arch/arm64/kernel/entry-common.c:712
   el0t_64_sync_handler+0x84/0xfc arch/arm64/kernel/entry-common.c:730
   el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598
irq event stamp: 282914
 hardirqs last  enabled at (282914): [<ffff80008b42e30c>] __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 hardirqs last  enabled at (282914): [<ffff80008b42e30c>] _raw_spin_unlock_irqrestore+0x38/0x98 kernel/locking/spinlock.c:194
 hardirqs last disabled at (282913): [<ffff80008b42e13c>] __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:108 [inline]
 hardirqs last disabled at (282913): [<ffff80008b42e13c>] _raw_spin_lock_irqsave+0x2c/0x7c kernel/locking/spinlock.c:162
 softirqs last  enabled at (282904): [<ffff8000801f8e88>] softirq_handle_end kernel/softirq.c:400 [inline]
 softirqs last  enabled at (282904): [<ffff8000801f8e88>] handle_softirqs+0xa3c/0xbfc kernel/softirq.c:582
 softirqs last disabled at (282909): [<ffff8000801fbdf8>] run_ksoftirqd+0x70/0x158 kernel/softirq.c:928

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&pch->downl);
  <Interrupt>
    lock(&pch->downl);

 *** DEADLOCK ***

1 lock held by ksoftirqd/1/24:
  #0: ffff80008f74dfa0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x10/0x4c include/linux/rcupdate.h:325

stack backtrace:
CPU: 1 UID: 0 PID: 24 Comm: ksoftirqd/1 Not tainted 6.11.0-rc7-syzkaller-g5f5673607153 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call trace:
  dump_backtrace+0x1b8/0x1e4 arch/arm64/kernel/stacktrace.c:319
  show_stack+0x2c/0x3c arch/arm64/kernel/stacktrace.c:326
  __dump_stack lib/dump_stack.c:93 [inline]
  dump_stack_lvl+0xe4/0x150 lib/dump_stack.c:119
  dump_stack+0x1c/0x28 lib/dump_stack.c:128
  print_usage_bug+0x698/0x9ac kernel/locking/lockdep.c:4000
 mark_lock_irq+0x980/0xd2c
  mark_lock+0x258/0x360 kernel/locking/lockdep.c:4677
  __lock_acquire+0xf48/0x779c kernel/locking/lockdep.c:5096
  lock_acquire+0x240/0x728 kernel/locking/lockdep.c:5759
  __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
  _raw_spin_lock+0x48/0x60 kernel/locking/spinlock.c:154
  spin_lock include/linux/spinlock.h:351 [inline]
  ppp_channel_bridge_input drivers/net/ppp/ppp_generic.c:2272 [inline]
  ppp_input+0x16c/0x854 drivers/net/ppp/ppp_generic.c:2304
  ppp_async_process+0x98/0x150 drivers/net/ppp/ppp_async.c:495
  tasklet_action_common+0x318/0x3f4 kernel/softirq.c:785
  tasklet_action+0x68/0x8c kernel/softirq.c:811
  handle_softirqs+0x2e4/0xbfc kernel/softirq.c:554
  run_ksoftirqd+0x70/0x158 kernel/softirq.c:928
  smpboot_thread_fn+0x4b0/0x90c kernel/smpboot.c:164
  kthread+0x288/0x310 kernel/kthread.c:389
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Fixes: 4cf476ced45d ("ppp: add PPPIOCBRIDGECHAN and PPPIOCUNBRIDGECHAN ioctls")
Reported-by: syzbot+bd8d55ee2acd0a71d8ce@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/netdev/66f661e2.050a0220.38ace9.000f.GAE@google.com/T/#u
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Tom Parkin <tparkin@katalix.com>
Cc: James Chapman <jchapman@katalix.com>
---
 drivers/net/ppp/ppp_generic.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ppp/ppp_generic.c b/drivers/net/ppp/ppp_generic.c
index 4b2971e2bf484a13b5e94ac3b9862224adac4c41..0d5cd705decb1fe19d15848125beabda40edf46b 100644
--- a/drivers/net/ppp/ppp_generic.c
+++ b/drivers/net/ppp/ppp_generic.c
@@ -2269,7 +2269,7 @@ static bool ppp_channel_bridge_input(struct channel *pch, struct sk_buff *skb)
 	if (!pchb)
 		goto out_rcu;
 
-	spin_lock(&pchb->downl);
+	spin_lock_bh(&pchb->downl);
 	if (!pchb->chan) {
 		/* channel got unregistered */
 		kfree_skb(skb);
@@ -2281,7 +2281,7 @@ static bool ppp_channel_bridge_input(struct channel *pch, struct sk_buff *skb)
 		kfree_skb(skb);
 
 outl:
-	spin_unlock(&pchb->downl);
+	spin_unlock_bh(&pchb->downl);
 out_rcu:
 	rcu_read_unlock();
 
-- 
2.46.1.824.gd892dcdcdd-goog



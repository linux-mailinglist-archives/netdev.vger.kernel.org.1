Return-Path: <netdev+bounces-130069-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1B63987F9E
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 09:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C454F1C20D64
	for <lists+netdev@lfdr.de>; Fri, 27 Sep 2024 07:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A6F117C98D;
	Fri, 27 Sep 2024 07:42:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6124717DFFF
	for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 07:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727422948; cv=none; b=ufDIseUrwqmTuV3AzWCc7nbYDpKdu0p38ywm/oe64B63ZBmxZbQ6SEWOeiJPhOInH96UVEcF5gwLJYQqgFHvXNFfvr+2PAh+qqfJ0WL3bHCJZV4tKDdWFACGICfnyqkSm5jp7fnaKe51b/T0WZ4wovdPP1MY2o30KB+MIGNm6xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727422948; c=relaxed/simple;
	bh=Y85+uEMLKyCCsjGCE8+X3WPnq07CyeZ2Xkntji605Pw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=BuJ4pE1FNzgbbCGbAHqYvocJCI0kBqHXzq6bQBOjwgGunV/+D95NIUBI9tn49QTgC/P4THuVfLFK2joV/hQiCnZirP4s5gCXW+86WedCOLfq36dKglTo3SJ6Rm+5bx2HPMlTfV7qlBWyQrezwR3SM+x0bW0ml5xM+/mkw8CDF4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a08c7d4273so20962035ab.1
        for <netdev@vger.kernel.org>; Fri, 27 Sep 2024 00:42:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727422946; x=1728027746;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=njVp7Usi7eU+qsX5ofV6zvIiP/FfZPRnWFIKpJMtD1M=;
        b=e1/nUJ8TiXTHNa0vywRoYaSHeWfgVM3R92CWaRNSQxXJjHGzATBSKALz3Lx8pghx6T
         FPb7oJQ85zHzqav8nRpnVtPJ2HOinjeWW3NrL0eFsyOMqXzaM7pIlRfOx77atD1zH6GQ
         /yEZObvnSzv+qBEMmOIEB5iyqiGDIDYlGck2AG8whg5wySqX5CH4JHhgM0tIfmy7LK+s
         3yN2d0r675qJUPrhsifCPTjcYAaa8MI1xrE/Qn5+LJRf+H50nLT1FBx8ROmvaDg4uEyg
         t0JV7EZmg4vrvSIF6Fro+l32Kjvpo55NOrgDqErSvDNnwMcVg1rGNmee/XAGzWts/nV1
         mhFQ==
X-Forwarded-Encrypted: i=1; AJvYcCXJI82XWr6MmM61fXGOKt80L68ISeYx9gMv922fk2SgEvsXEHpGHHFNSPay+n0xtQ3bFhRNU2I=@vger.kernel.org
X-Gm-Message-State: AOJu0YwtgVB43/xfhnEcPJHRuYdG+zISvZZgYyQJO3n+Hlmgc6bREbFq
	B9azyi/s9ihXOwa65a4jX7lXALdPvqeI0KTHzFwcjGhvR/LqA0RAW4mXGGCd6yw143u5qI8CUyM
	7kbLzDrBBpM6rgfBQ8Kg7khIx9c7n9cdbrwbx3Bk69/pGawf7jh/eTQw=
X-Google-Smtp-Source: AGHT+IHkbvVR1zRnDN6g66btasQuzklpsAJk1gErTEQWtyZu8q3/5LjdIZBSUp20vXHrUSWeqlhspogCCqsuy1z7uS0ssfEgjAbx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ee:b0:3a2:aed1:1285 with SMTP id
 e9e14a558f8ab-3a344fc8e06mr27030935ab.0.1727422946540; Fri, 27 Sep 2024
 00:42:26 -0700 (PDT)
Date: Fri, 27 Sep 2024 00:42:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f661e2.050a0220.38ace9.000f.GAE@google.com>
Subject: [syzbot] [ppp?] inconsistent lock state in ppp_input
From: syzbot <syzbot+bd8d55ee2acd0a71d8ce@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-ppp@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5f5673607153 Merge branch 'for-next/core' into for-kernelci
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=14568c80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=dedbcb1ff4387972
dashboard link: https://syzkaller.appspot.com/bug?extid=bd8d55ee2acd0a71d8ce
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16296107980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14de92a9980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/40172aed5414/disk-5f567360.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58372f305e9d/vmlinux-5f567360.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d2aae6fa798f/Image-5f567360.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+bd8d55ee2acd0a71d8ce@syzkaller.appspotmail.com

================================
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


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


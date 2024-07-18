Return-Path: <netdev+bounces-111984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 130B09345F9
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 04:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 34DA11C21E31
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 02:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ACEAB64C;
	Thu, 18 Jul 2024 02:03:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245D4156CE
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 02:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721268205; cv=none; b=KSKCTlgLjRTmFqJXj8fSziffPC2A1tn/HCwcwhiDhwRrNj6HAvkM6TVaP4rdA8V15R4CtfJIT+cNh7dWYsMbOn4I+87ND9MPMmSXFwEMfW0ix+dfUM2xfilhgGsd9ffIYMTCAmznTSRWcAcwpfxcAm0SAP63oDti1/d6AC+kMOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721268205; c=relaxed/simple;
	bh=6PKGXN0nBxY7ErtJ/aDukPwNVodKVv72RWtidWdFaz4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DeGK8IQBWnFLIJbkHkeceD6OTnicAIyxNwKDd5jmPt1t5nVxFXTdgvupJk1wdIKp5MVpw69fE8Y1Ia146MxJOJ8anHNvZBlBa7Q+7Mdb4ltiUrr02dFHt7jToQoo5f8RBrnC7LCtr0KAsjMcL3XpIegMazG+uBdA6R8gLF+oE00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3815f94dfbeso3665735ab.3
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 19:03:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721268202; x=1721873002;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2zoNBiqiw7wd4dWLPFJKgChR6DhPP4L7PMHeKP4K28Q=;
        b=EOK+V2ZVlc0pxaY9byI4TUgXLRrGzpDGRgOCazie807X6DGEguzytsS0FDjNxCtrxb
         NmPyk1q55e97fhNzxuEKBFkP1NmNbQoHH3VjqIFyV4fuNfOpVkOUbhCANqnUA8jTu380
         sFOV1//KrLvVOfnGNfKlkhs42LCjEaxbgV+tLqYxJ5G+p3txCyf6wnWRaekrW4wT2tRX
         6Xl5qXssJwUyNL6AjQxrXvkvwaNDJCI1GbWM7kOTFf2um33a9HaqduH02CXmwRJGroJc
         CGqhXv7uMlaL8/XMbSXDQK0hGOlyc49fcudawQVNkzIyytMylmUEPDOQFLcEyrrVy9wp
         wLPA==
X-Forwarded-Encrypted: i=1; AJvYcCV1nme77ODTkd/JcZK07xGhXgW2M+DzCMlcUC5KdBfvvze7XEKJ1e/rp18M8m6tXrIX2Jjn9cHyBVPX/E34cxvBBbhEVJis
X-Gm-Message-State: AOJu0YwUmxOubvL207ux7keUxhdHdrc/RnA0Nm2qjcTvYEBC/cBJQgSa
	nsLS+2xuy9UnTQOzVXf2LiVx8pm4uyaVT9OdB4yYpvoAck4oC+oXPMNqnVdF6AjQQuSVX+H8dBk
	yRmUvd73uTJgbneW1kDshwjAQUbzulGvsmZWFWCnj+BxqsSH/v441QVg=
X-Google-Smtp-Source: AGHT+IGPjFZWf3fOkaa/IO35e/QoZDVBZr56JbE3XviU6mtfhlbqV6shRhabbSsZm8KRGU/LihEpw2d18IwYteSi5hYHJKCsnkIv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0b:b0:382:ef85:c3a1 with SMTP id
 e9e14a558f8ab-39558298e30mr2375255ab.6.1721268202300; Wed, 17 Jul 2024
 19:03:22 -0700 (PDT)
Date: Wed, 17 Jul 2024 19:03:22 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000c2f7f2061d7bfb12@google.com>
Subject: [syzbot] [net?] WARNING: suspicious RCU usage in dev_deactivate_queue
From: syzbot <syzbot+ca9ad1d31885c81155b6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    51835949dda3 Merge tag 'net-next-6.11' of git://git.kernel..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=147a6e95980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3bdd09ea2371c89
dashboard link: https://syzkaller.appspot.com/bug?extid=ca9ad1d31885c81155b6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=139998b1980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=170b4f31980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/24fbc1342de2/disk-51835949.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/80cd41210088/vmlinux-51835949.xz
kernel image: https://storage.googleapis.com/syzbot-assets/26bfbd59223a/bzImage-51835949.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ca9ad1d31885c81155b6@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.10.0-syzkaller-04472-g51835949dda3 #0 Not tainted
-----------------------------
net/sched/sch_generic.c:1284 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u8:11/2874:
 #0: ffff888023286148 ((wq_completion)bond0){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888023286148 ((wq_completion)bond0){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90009dc7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90009dc7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 #2: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:839 [inline]
 #2: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x174/0x3170 drivers/net/bonding/bond_main.c:2824

stack backtrace:
CPU: 0 PID: 2874 Comm: kworker/u8:11 Not tainted 6.10.0-syzkaller-04472-g51835949dda3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6711
 dev_deactivate_queue+0x8f/0x160 net/sched/sch_generic.c:1284
 netdev_for_each_tx_queue include/linux/netdevice.h:2513 [inline]
 dev_deactivate_many+0xc8/0xb10 net/sched/sch_generic.c:1357
 dev_deactivate+0x184/0x280 net/sched/sch_generic.c:1397
 linkwatch_do_dev+0x10a/0x170 net/core/link_watch.c:175
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:757
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2826
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

=============================
WARNING: suspicious RCU usage
6.10.0-syzkaller-04472-g51835949dda3 #0 Not tainted
-----------------------------
include/linux/rtnetlink.h:100 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u8:11/2874:
 #0: ffff888023286148 ((wq_completion)bond0){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888023286148 ((wq_completion)bond0){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90009dc7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90009dc7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 #2: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:839 [inline]
 #2: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x174/0x3170 drivers/net/bonding/bond_main.c:2824

stack backtrace:
CPU: 1 PID: 2874 Comm: kworker/u8:11 Not tainted 6.10.0-syzkaller-04472-g51835949dda3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6711
 dev_ingress_queue include/linux/rtnetlink.h:100 [inline]
 dev_deactivate_many+0x18f/0xb10 net/sched/sch_generic.c:1359
 dev_deactivate+0x184/0x280 net/sched/sch_generic.c:1397
 linkwatch_do_dev+0x10a/0x170 net/core/link_watch.c:175
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:757
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2826
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
BUG: sleeping function called from invalid context at net/core/dev.c:11221
in_atomic(): 0, irqs_disabled(): 0, non_block: 0, pid: 2874, name: kworker/u8:11
preempt_count: 0, expected: 0
RCU nest depth: 1, expected: 0
3 locks held by kworker/u8:11/2874:
 #0: ffff888023286148 ((wq_completion)bond0){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888023286148 ((wq_completion)bond0){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90009dc7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90009dc7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 #2: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:839 [inline]
 #2: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x174/0x3170 drivers/net/bonding/bond_main.c:2824
CPU: 1 PID: 2874 Comm: kworker/u8:11 Not tainted 6.10.0-syzkaller-04472-g51835949dda3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 __might_resched+0x5d4/0x780 kernel/sched/core.c:8437
 synchronize_net+0x1b/0x50 net/core/dev.c:11221
 dev_deactivate_many+0x4a7/0xb10 net/sched/sch_generic.c:1371
 dev_deactivate+0x184/0x280 net/sched/sch_generic.c:1397
 linkwatch_do_dev+0x10a/0x170 net/core/link_watch.c:175
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:757
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2826
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

=============================
WARNING: suspicious RCU usage
6.10.0-syzkaller-04472-g51835949dda3 #0 Tainted: G        W         
-----------------------------
kernel/rcu/tree_exp.h:931 Illegal synchronize_rcu_expedited() in RCU read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u8:11/2874:
 #0: ffff888023286148 ((wq_completion)bond0){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888023286148 ((wq_completion)bond0){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90009dc7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90009dc7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 #2: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:839 [inline]
 #2: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x174/0x3170 drivers/net/bonding/bond_main.c:2824

stack backtrace:
CPU: 1 PID: 2874 Comm: kworker/u8:11 Tainted: G        W          6.10.0-syzkaller-04472-g51835949dda3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6711
 synchronize_rcu_expedited+0x12e/0x830 kernel/rcu/tree_exp.h:928
 dev_deactivate_many+0x4a7/0xb10 net/sched/sch_generic.c:1371
 dev_deactivate+0x184/0x280 net/sched/sch_generic.c:1397
 linkwatch_do_dev+0x10a/0x170 net/core/link_watch.c:175
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:757
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2826
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.10.0-syzkaller-04472-g51835949dda3 #0 Tainted: G        W         
-----------------------------
kworker/u8:11/2874 is trying to lock:
ffffffff8e33b3b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:328 [inline]
ffffffff8e33b3b8 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:958
other info that might help us debug this:
context-{4:4}
3 locks held by kworker/u8:11/2874:
 #0: ffff888023286148 ((wq_completion)bond0){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888023286148 ((wq_completion)bond0){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90009dc7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90009dc7d00 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 #2: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:839 [inline]
 #2: ffffffff8e335fe0 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x174/0x3170 drivers/net/bonding/bond_main.c:2824
stack backtrace:
CPU: 1 PID: 2874 Comm: kworker/u8:11 Tainted: G        W          6.10.0-syzkaller-04472-g51835949dda3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: bond0 bond_mii_monitor
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4750 [inline]
 check_wait_context kernel/locking/lockdep.c:4820 [inline]
 __lock_acquire+0x1507/0x1fd0 kernel/locking/lockdep.c:5086
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5753
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
 exp_funnel_lock kernel/rcu/tree_exp.h:328 [inline]
 synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:958
 dev_deactivate_many+0x4a7/0xb10 net/sched/sch_generic.c:1371
 dev_deactivate+0x184/0x280 net/sched/sch_generic.c:1397
 linkwatch_do_dev+0x10a/0x170 net/core/link_watch.c:175
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:757
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2826
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
------------[ cut here ]------------
Voluntary context switch within RCU read-side critical section!
WARNING: CPU: 1 PID: 2874 at kernel/rcu/tree_plugin.h:330 rcu_note_context_switch+0xcf4/0xff0 kernel/rcu/tree_plugin.h:330
Modules linked in:
CPU: 1 PID: 2874 Comm: kworker/u8:11 Tainted: G        W          6.10.0-syzkaller-04472-g51835949dda3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: bond0 bond_mii_monitor
RIP: 0010:rcu_note_context_switch+0xcf4/0xff0 kernel/rcu/tree_plugin.h:330
Code: 00 ba 02 00 00 00 e8 cb 02 fe ff 4c 8b b4 24 80 00 00 00 eb 91 c6 05 98 3f 1b 0e 01 90 48 c7 c7 40 21 cc 8b e8 8d 26 db ff 90 <0f> 0b 90 90 e9 3b f4 ff ff 90 0f 0b 90 45 84 ed 0f 84 00 f4 ff ff
RSP: 0018:ffffc90009dc6fc0 EFLAGS: 00010046
RAX: 129439ac0980bb00 RBX: ffff88802b6c8444 RCX: ffff88802b6c8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90009dc7110 R08: ffffffff815878a2 R09: fffffbfff1c39d94
R10: dffffc0000000000 R11: fffffbfff1c39d94 R12: ffff88802b6c8000
R13: 0000000000000000 R14: 1ffff920013b8e10 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000563178d9e028 CR3: 000000000e134000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __schedule+0x348/0x4a60 kernel/sched/core.c:6417
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 mutex_optimistic_spin kernel/locking/mutex.c:510 [inline]
 __mutex_lock_common kernel/locking/mutex.c:612 [inline]
 __mutex_lock+0x391/0xd70 kernel/locking/mutex.c:752
 exp_funnel_lock kernel/rcu/tree_exp.h:328 [inline]
 synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:958
 dev_deactivate_many+0x4a7/0xb10 net/sched/sch_generic.c:1371
 dev_deactivate+0x184/0x280 net/sched/sch_generic.c:1397
 linkwatch_do_dev+0x10a/0x170 net/core/link_watch.c:175
 ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:757
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2604 [inline]
 bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2826
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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


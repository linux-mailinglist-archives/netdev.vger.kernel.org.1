Return-Path: <netdev+bounces-145555-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5376F9CFD38
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 09:16:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD6D62836F5
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 08:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7FF91925BA;
	Sat, 16 Nov 2024 08:16:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1620618C004
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 08:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731744989; cv=none; b=Yb8jwpl21zwxReerzKWbsdB8H/NKCESs9B3asAn2h3cJBHQQsJxQ4PJQjo5YYzOL+K9D5irnL3KSmV+RAlcvZcN+a1ciiOV8A/cY5lH4q8XBr367VFjlgLO+P5CZPSsRO8geVO7dwwS8IiHlJTnYceaQyPNDQzs7PbB9zNNW19E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731744989; c=relaxed/simple;
	bh=NdCNRt5hseY7XgSrFhM3rvJkKWMJFpMnTxgzT+R6vHA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uIziGbhT7SavRcZ68dTe+dx06AwLh2a7JIf1eL+QX8o0T9lpATDr/nkFc5Yuv5IpNlmE86JNr7cqpaUuKcFztNq0c4qOJ7fQUfqvCz+WySSOEB//VRJO8T+CCOHuR/qiw+zLeHrMqrpQSTcUW4CFNDZBfYULy3yCexhnbDYUF2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a71d04c76dso17108365ab.3
        for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 00:16:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731744987; x=1732349787;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2jbckV7ux3lzXJSR7JR4BmQDcEyddTRVjQlXOwEJaVI=;
        b=soq0G31xqNKw6rU+tNHHGiDgSgG580uhHFG5+QxrO1ps+Y5sOxmT1I4lFXcy7ORvd/
         jW/y4R9hzOSWKAS6hNLLGVQ+DOYNaCgISgWLdR+YjVi4V+sFUxN0H6JXDiBW5VoaRC4u
         Kcsy8ybqOheEo5fSj2Lf969ey7Xj4uf4h4hDUUv2BgUiLaXNVESRnHGeZ+6QaUKTHuWB
         5JBBb/c056wMgc9zDbnLmvprBwK7y4HQIBfrlON14ywmzuLKXOSpciNmNtnHtDKO0kL+
         GHdTqxGv27LjIGMJnhfIpasfUfKQmQjpXjzuD1EKitfPim9ayg+HzSdwXrV9V9ihyR8I
         2zAg==
X-Forwarded-Encrypted: i=1; AJvYcCWYsvTuC/GpEDi1S/l8MRK4yqIKQ7KOBJder/YspXHZ24oORuV8FWWdCVgf4aENr1DkKo5mcDs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxtFmoAwBRVXIa45Pgv5JZp+ZF9YvB2onJ/wtXdlb4Q1SSHjEZV
	jC1UUb23+xqof7L1QhI66jx7Bn5gdLC8bKOV8TDhkAybcc1+62jdhYpX2IowDLd751PKMXJypaf
	DwwCsIkXZuq9/wOxztkKXTkob8el7vv6zFuNoIrehG07GPpOtXpTsYbo=
X-Google-Smtp-Source: AGHT+IH9L6VPPkxwi3Qe5NdR2HEfdsN8Fets2wPPjEmFamGj7SXwc73uB8k38B1TeZwK9V74LE9ui4l4Am0DBHkuzPYYHMdszb70
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b47:b0:3a0:4d1f:519c with SMTP id
 e9e14a558f8ab-3a747ff8c92mr58797555ab.3.1731744987352; Sat, 16 Nov 2024
 00:16:27 -0800 (PST)
Date: Sat, 16 Nov 2024 00:16:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673854db.050a0220.85a0.0011.GAE@google.com>
Subject: [syzbot] [net?] WARNING: suspicious RCU usage in dev_deactivate
From: syzbot <syzbot+8a65ac5be396817eefb3@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2d5404caa8c7 Linux 6.12-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1219335f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=327b6119dd928cbc
dashboard link: https://syzkaller.appspot.com/bug?extid=8a65ac5be396817eefb3
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-2d5404ca.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1bbbfa50cb5f/vmlinux-2d5404ca.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a5bcdede1c8a/bzImage-2d5404ca.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8a65ac5be396817eefb3@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.12.0-rc7-syzkaller #0 Not tainted
-----------------------------
net/sched/sch_generic.c:1290 suspicious rcu_dereference_protected() usage!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u32:18/10870:
 #0: ffff888046b42148 ((wq_completion)bond0#22){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204
 #1: ffffc90004557d80 ((work_completion)(&(&bond->mii_work)->work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3205
 #2: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #2: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #2: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: bond_mii_monitor+0x140/0x2d90 drivers/net/bonding/bond_main.c:2937
stack backtrace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x210/0x3c0 kernel/locking/lockdep.c:6821
 dev_deactivate_queue+0x167/0x190 net/sched/sch_generic.c:1290
 netdev_for_each_tx_queue include/linux/netdevice.h:2504 [inline]
 dev_deactivate_many+0xe7/0xb20 net/sched/sch_generic.c:1363
 dev_deactivate+0xf9/0x1c0 net/sched/sch_generic.c:1403
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2717 [inline]
 bond_mii_monitor+0x3c1/0x2d90 drivers/net/bonding/bond_main.c:2939
-----------------------------
include/linux/rtnetlink.h:100 suspicious rcu_dereference_protected() usage!
other info that might help us debug this:

rcu_scheduler_active = 2, debug_locks = 1

stack backtrace:
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 dev_deactivate+0xf9/0x1c0 net/sched/sch_generic.c:1403
 bond_check_dev_link+0x197/0x490 drivers/net/bonding/bond_main.c:873
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 </TASK>
RCU nest depth: 1, expected: 0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 dev_deactivate_many+0x2a1/0xb20 net/sched/sch_generic.c:1377

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
3 locks held by kworker/u32:18/10870:
 #0: ffff888046b42148 ((wq_completion)bond0#22){+.+.}-{0:0}, at: process_one_work+0x129b/0x1ba0 kernel/workqueue.c:3204

stack backtrace:
Tainted: [W]=WARN
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:120
 lockdep_rcu_suspicious+0x210/0x3c0 kernel/locking/lockdep.c:6821
 dev_deactivate+0xf9/0x1c0 net/sched/sch_generic.c:1403
 ethtool_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:62
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
6.12.0-rc7-syzkaller #0 Tainted: G        W         
-----------------------------
other info that might help us debug this:
context-{4:4}
stack backtrace:
Workqueue: bond0 bond_mii_monitor
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5825
 synchronize_rcu_expedited+0x290/0x450 kernel/rcu/tree_exp.h:976
 synchronize_net+0x3e/0x60 net/core/dev.c:11286
 ethtool_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:62
 bond_check_dev_link+0x197/0x490 drivers/net/bonding/bond_main.c:873
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2717 [inline]
 bond_mii_monitor+0x3c1/0x2d90 drivers/net/bonding/bond_main.c:2939
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
------------[ cut here ]------------
WARNING: CPU: 2 PID: 10870 at kernel/rcu/tree_plugin.h:331 rcu_note_context_switch+0xc5c/0x1ae0 kernel/rcu/tree_plugin.h:331
Tainted: [W]=WARN
RSP: 0018:ffffc900045573b0 EFLAGS: 00010086
RDX: ffff888026c3c880 RSI: ffffffff814e6e86 RDI: 0000000000000001
R10: 0000000000000000 R11: 000000002d2d2d2d R12: ffff888026c3c880
CR2: 00007fd5d2467d60 CR3: 0000000030df0000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 mutex_optimistic_spin kernel/locking/mutex.c:510 [inline]
 __mutex_lock_common kernel/locking/mutex.c:612 [inline]
 __mutex_lock+0x81e/0x9c0 kernel/locking/mutex.c:752
 synchronize_rcu_expedited+0x290/0x450 kernel/rcu/tree_exp.h:976
 dev_deactivate_many+0x2a1/0xb20 net/sched/sch_generic.c:1377
 linkwatch_sync_dev+0x181/0x210 net/core/link_watch.c:263
 ethtool_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:62
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


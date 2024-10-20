Return-Path: <netdev+bounces-137311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AD19A555B
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 19:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 152581F217D7
	for <lists+netdev@lfdr.de>; Sun, 20 Oct 2024 17:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F788194091;
	Sun, 20 Oct 2024 17:31:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAFA320E
	for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 17:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729445495; cv=none; b=INbeIpg6SlCowBzsFcOLCqPgeurmrWgSws0XSrOFzPrwEn/NFgwQSIf3vKKzOd9arbwFncEzWhyHOqZtst9A1js6OaopyDYYgSSkQTQcL+VLfPo5zR+z6iug5hf7LSkjGbhfcijTrNof5blmk0SYuhsfDcuUo7fA3ILR68yegFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729445495; c=relaxed/simple;
	bh=9hKdqgeJDJCuOcBei7hsYCz+qsa7iZAapvAOJwGGIuM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bqjbuHiOTDiLZmwO+qiOEMXlJ8kB08pA5mUX8DqubTdo9QveZu+KCcgI/R/uw6dzQ2eAI0yqSpc0ZIp/z1WiYAV7+69eovLUu0eMkLGcxiJcX7w1ZH3h26z+CFoKwdyrwU6ahS6s2RceLPqjfIZgJXI+BfuzM/4NzM1ZQAK/e7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c8853d76so39516225ab.2
        for <netdev@vger.kernel.org>; Sun, 20 Oct 2024 10:31:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729445492; x=1730050292;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iQIh6BYWEDQVGkT8omPhhBP+AcZOobW8LWB5GcTjMwY=;
        b=r1HPpzhOtwyLZh826fQHi+1J9SesODekFU8cAqy0EBEkmcY8f9iHEYLeiZQ9VFO5Ek
         336OYyyN6UAiLI8DNv1Ax/y0wXuhWaBu1PBamR4WFf+r3NW15dPsOcqOVXTaURzQOfhR
         dhxIwPZYZjwOSbocnEHuLU3Cqw8vPMf6h1Kgc5DMCYUciYiIPBbhIq6XHU9crNrwGVPL
         TZ9aA9S2iMFWEr9MAsySrMiKDDa8HgtiqlHeJpoVweYXubgXX9mQfPosyIVT1GbEsxNF
         srV9oRxlXe9Kac8+DBq/u8Pgj1QttFwCB6L5xO6Bze2v3kP5tIFpx44FQbwo0fijh9iA
         vzXg==
X-Forwarded-Encrypted: i=1; AJvYcCVuRsVP7HwHQWhVHAlnPpgnbZAupB6HrUbzlFO1zyQHO3Ckw0i2EQlnhxIOB664yKb6TWnQPYA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1slns7Grpt1QPrYUWQfBCEAw2W9bZKKdQfvKWK03mxaOnCQR8
	bdy90PziQiM+61BWvZWuHg/imh4fNz4/7tiFt2mG+Qx0iX1GJOkILnUMGZRu1R8R9EBwx62sgkv
	Cur2zGp01XS8fUANSl7s+fukNmf4XHMBK6b8awD6PKLbURRPtRD6X2Jw=
X-Google-Smtp-Source: AGHT+IE+30P0kfox4ZfqTO46KDXioj/OiMVWC/USDwWvtOpKEVp+dOA+nxcE8Dk/yOhulJUX17+SIs/XGM77vWL31TpPueNKW8rv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a83:b0:3a0:c23f:9647 with SMTP id
 e9e14a558f8ab-3a3f4046c67mr76366855ab.1.1729445492417; Sun, 20 Oct 2024
 10:31:32 -0700 (PDT)
Date: Sun, 20 Oct 2024 10:31:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67153e74.050a0220.3d9749.000c.GAE@google.com>
Subject: [syzbot] [netfilter?] INFO: task hung in do_arpt_get_ctl (2)
From: syzbot <syzbot+47dcc37219cf4421eec6@syzkaller.appspotmail.com>
To: coreteam@netfilter.org, davem@davemloft.net, edumazet@google.com, 
	kadlec@netfilter.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, pabeni@redhat.com, 
	pablo@netfilter.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2f87d0916ce0 Merge tag 'trace-ringbuffer-v6.12-rc3' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13d23887980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=cfbd94c114a3d407
dashboard link: https://syzkaller.appspot.com/bug?extid=47dcc37219cf4421eec6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=103b7727980000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-2f87d091.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2704ba6867a8/vmlinux-2f87d091.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9f7121fd532b/bzImage-2f87d091.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+47dcc37219cf4421eec6@syzkaller.appspotmail.com

INFO: task syz-executor:5236 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc3-syzkaller-00044-g2f87d0916ce0 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:20608 pid:5236  tgid:5236  ppid:5230   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5322 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6682
 __schedule_loop kernel/sched/core.c:6759 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6774
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6831
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 xt_find_table_lock+0x4c/0x3b0 net/netfilter/x_tables.c:1243
 xt_request_find_table_lock+0x26/0x100 net/netfilter/x_tables.c:1285
 get_info net/ipv4/netfilter/arp_tables.c:808 [inline]
 do_arpt_get_ctl+0x904/0x16b0 net/ipv4/netfilter/arp_tables.c:1452
 nf_getsockopt+0x299/0x2c0 net/netfilter/nf_sockopt.c:116
 ip_getsockopt+0x222/0x2e0 net/ipv4/ip_sockglue.c:1777
 tcp_getsockopt+0x163/0x1c0 net/ipv4/tcp.c:4670
 do_sock_getsockopt+0x3c4/0x7e0 net/socket.c:2396
 __sys_getsockopt+0x267/0x330 net/socket.c:2425
 __do_sys_getsockopt net/socket.c:2435 [inline]
 __se_sys_getsockopt net/socket.c:2432 [inline]
 __x64_sys_getsockopt+0xb5/0xd0 net/socket.c:2432
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f766ed7fd3a
RSP: 002b:00007ffc9412c6b8 EFLAGS: 00000246 ORIG_RAX: 0000000000000037
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007f766ed7fd3a
RDX: 0000000000000060 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007ffc9412c6d0 R08: 00007ffc9412c6cc R09: 00007ffc9412cab7
R10: 00007ffc9412c6d0 R11: 0000000000000246 R12: 00007ffc9412c6cc
R13: 00000000000481ce R14: 00000000000481a7 R15: 00007ffc9412cdf0
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/25:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
1 lock held by kswapd0/79:
1 lock held by klogd/4585:
 #0: ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3907 [inline]
 #0: ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim+0xd4/0x3c0 mm/page_alloc.c:3932
1 lock held by dhcpcd/4810:
 #0: ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3907 [inline]
 #0: ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim+0xd4/0x3c0 mm/page_alloc.c:3932
2 locks held by getty/4897:
 #0: ffff88801ebb90a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000039b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
2 locks held by syz-execprog/5134:
 #0: ffff88803e1ae8a8 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_invalidate_lock_shared include/linux/fs.h:870 [inline]
 #0: ffff88803e1ae8a8 (mapping.invalidate_lock){++++}-{3:3}, at: filemap_fault+0xd54/0x1950 mm/filemap.c:3350
 #1: ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3907 [inline]
 #1: ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim+0xd4/0x3c0 mm/page_alloc.c:3932
1 lock held by syz-executor/5126:
 #0: ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3907 [inline]
 #0: ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim+0xd4/0x3c0 mm/page_alloc.c:3932
2 locks held by syz-executor/5231:
 #0: ffff8880006f29b8 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:704 [inline]
 #0: ffff8880006f29b8 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x34b/0x790 mm/memory.c:6228
 #1: ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3907 [inline]
 #1: ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim+0xd4/0x3c0 mm/page_alloc.c:3932
1 lock held by syz-executor/5232:
 #0: ffff88801bba2458 (&xt[i].mutex){+.+.}-{3:3}, at: xt_find_table_lock+0x4c/0x3b0 net/netfilter/x_tables.c:1243
2 locks held by syz-executor/5233:
 #0: ffff88801198f220 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:704 [inline]
 #0: ffff88801198f220 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x34b/0x790 mm/memory.c:6228
 #1: ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3907 [inline]
 #1: ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim+0xd4/0x3c0 mm/page_alloc.c:3932
2 locks held by syz-executor/5234:
 #0: ffff88801bba2458 (&xt[i].mutex){+.+.}-{3:3}, at: xt_find_table_lock+0x4c/0x3b0 net/netfilter/x_tables.c:1243
 #1: ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3907 [inline]
 #1: ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim+0xd4/0x3c0 mm/page_alloc.c:3932
2 locks held by syz-executor/5235:
 #0: ffff88803c3ac808 (&vma->vm_lock->lock){++++}-{3:3}, at: vma_start_read include/linux/mm.h:704 [inline]
 #0: ffff88803c3ac808 (&vma->vm_lock->lock){++++}-{3:3}, at: lock_vma_under_rcu+0x34b/0x790 mm/memory.c:6228
 #1: ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: __perform_reclaim mm/page_alloc.c:3907 [inline]
 #1: ffffffff8ea37160 (fs_reclaim){+.+.}-{0:0}, at: __alloc_pages_direct_reclaim+0xd4/0x3c0 mm/page_alloc.c:3932
1 lock held by syz-executor/5236:
 #0: ffff88801bba2458 (&xt[i].mutex){+.+.}-{3:3}, at: xt_find_table_lock+0x4c/0x3b0 net/netfilter/x_tables.c:1243

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 25 Comm: khungtaskd Not tainted 6.12.0-rc3-syzkaller-00044-g2f87d0916ce0 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
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


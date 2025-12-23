Return-Path: <netdev+bounces-245913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EC4BCDAA74
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 22:01:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0F08730A65CF
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 20:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC49306B06;
	Tue, 23 Dec 2025 20:48:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f79.google.com (mail-ot1-f79.google.com [209.85.210.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0D9030E843
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 20:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766522901; cv=none; b=XhbzXVLpjXOAGP4p0nlVx6tr3OqsWejSPiobD6Ubdgweo8wdMHl18LSNXXAVt6uWGgfmmVarBWsZl6UwZMlLMVYEmQvTwnJ4ewX9qbBvEbr7K8syfZQM/XRf9pQqNUdDXh036U7N6GKvzKsPxpqglvf5h3laevZ3G6PW+7MEf/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766522901; c=relaxed/simple;
	bh=EKWrPy/mOSZVdHoH/yp3LGI2heAE1YKzhSeKAgIX66U=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AbXZPCfEzIuOvFwB7js7mYXNBzAloiLQLDE0syWZDgEShUfcR0qVFTY6jK5EiS7zCJulJRmnKxm159vSNEpa8Aj9HkvO4SL17GsiAuf/hJ6KBVDIGfU75bnaqlcf+1DT/8eiKiI/U9UcI8pHgmk8et163BHt+J7/uM4HiSPZ9fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f79.google.com with SMTP id 46e09a7af769-7c7046514a2so4384895a34.0
        for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 12:48:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766522897; x=1767127697;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uznCQH7MQzMAGIrzCXvGIpI2tMS4A9t1YfGZXdqund8=;
        b=nKSGJnGl+wrmrj68/c2ZysFUqofyeHvYUsHNYsEwPd8bV/O8eVptl+w2KghWf9/slf
         DI92rJFG70lT0lHPmQ8o6FsMphqXjmvLjr4EGAhfhEb6vZmTXy2m4RxTYuDpng5rQ++V
         g0BqPr0ryDMPxq1yHfYVJo7pFJFeX+4zeApA25YL3IjHQeWw/GNbyr/kY4tgyvwJ1Pt/
         DdbOCLJO+TWwP6yyaq9jXNodsXzKKU1DGXYisq78yAW3oA2qONp8cXvG9Y5sh1KZQw31
         0VE2FvNqCA/CPY0rRVmX1o6zoYhEJ1lPZCAuodd5CuqEqKktv6EEw/8kfh5hEXJfLAQl
         TWaA==
X-Forwarded-Encrypted: i=1; AJvYcCU5oxZ1b0sw3ytpOGLgwWEVTkKl6T+3tjmoBAbQPihQaTrdxxuqElVrVDvEjM1LskzUo4SbMNU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYGl6D8igQxFadYj+b6HFVK/so5jdIEqh65Af7aqePR5fYciK/
	gBBxCoj84l/H97shVDjnlEMlEjLmIdXFL+v1CpIcq5mY8a2ETS5TWCWmCCuohwaLJF7w+lyWv3D
	/4kuxRrHXhlK6L8Au8RHiGa3QdwOGshRYU7amdCLVUFMdL3Fo9t5+oTUVZj0=
X-Google-Smtp-Source: AGHT+IF9+Ei827XQgu+EVgkYPk816T1Eoj3W4oIMRCUiB1isKmsDOBqX9rRWHC+vlfl2fjki0PMVCS1XHmUohmh5CfbJm7J1Ebp+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:f028:b0:659:9a49:8dd5 with SMTP id
 006d021491bc7-65d0ea47292mr6759466eaf.23.1766522897558; Tue, 23 Dec 2025
 12:48:17 -0800 (PST)
Date: Tue, 23 Dec 2025 12:48:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694b0011.050a0220.35954c.0007.GAE@google.com>
Subject: [syzbot] [net?] [afs?] INFO: task hung in rxrpc_destroy_all_calls (4)
From: syzbot <syzbot+1c21ab751f6531a595d6@syzkaller.appspotmail.com>
To: davem@davemloft.net, dhowells@redhat.com, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-afs@lists.infradead.org, 
	linux-kernel@vger.kernel.org, marc.dionne@auristor.com, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    765b233a9b94 Merge tag 'i2c-for-6.19-rc2' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12bbddb4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f2b6fe1fdf1a00b
dashboard link: https://syzkaller.appspot.com/bug?extid=1c21ab751f6531a595d6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/94f8b9ce4f8d/disk-765b233a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/90d85072752b/vmlinux-765b233a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/df80434a0580/bzImage-765b233a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1c21ab751f6531a595d6@syzkaller.appspotmail.com

INFO: task kworker/u8:5:78 blocked for more than 143 seconds.
      Tainted: G             L      syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:5    state:D stack:21144 pid:78    tgid:78    ppid:2      task_flags:0x4208160 flags:0x00080000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x145f/0x5070 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 rxrpc_destroy_all_calls+0x564/0x660 net/rxrpc/call_object.c:757
 rxrpc_exit_net+0x6f/0xc0 net/rxrpc/net_ns.c:112
 ops_exit_list net/core/net_namespace.c:199 [inline]
 ops_undo_list+0x49a/0x990 net/core/net_namespace.c:252
 cleanup_net+0x4de/0x7b0 net/core/net_namespace.c:696
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>

Showing all locks held in the system:
4 locks held by rcuc/1/28:
1 lock held by khungtaskd/38:
 #0: ffffffff8d5ae940 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8d5ae940 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8d5ae940 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x2e/0x180 kernel/locking/lockdep.c:6775
3 locks held by kworker/u8:5/78:
 #0: ffff888019ad4938 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3232 [inline]
 #0: ffff888019ad4938 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x1770 kernel/workqueue.c:3340
 #1: ffffc9000159fbc0 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3233 [inline]
 #1: ffffc9000159fbc0 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x1770 kernel/workqueue.c:3340
 #2: ffffffff8e898680 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xf7/0x7b0 net/core/net_namespace.c:670
2 locks held by getty/5560:
 #0: ffff8880304990a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90003e762e0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x44f/0x1460 drivers/tty/n_tty.c:2211
3 locks held by syz-executor/18773:
3 locks held by kworker/0:17/18981:
 #0: ffff88813ff55138 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3232 [inline]
 #0: ffff88813ff55138 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x1770 kernel/workqueue.c:3340
 #1: ffffc90005907bc0 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3233 [inline]
 #1: ffffc90005907bc0 ((work_completion)(&data->fib_event_work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x1770 kernel/workqueue.c:3340
 #2: ffff8880599a8260 (&data->fib_lock){+.+.}-{4:4}, at: nsim_fib_event_work+0x224/0x3e0 drivers/net/netdevsim/fib.c:1490
3 locks held by kworker/u8:19/19046:
 #0: ffff88802f91b938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3232 [inline]
 #0: ffff88802f91b938 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x9b4/0x1770 kernel/workqueue.c:3340
 #1: ffffc90005357bc0 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3233 [inline]
 #1: ffffc90005357bc0 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x9ef/0x1770 kernel/workqueue.c:3340
 #2: ffffffff8e8a57b8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #2: ffffffff8e8a57b8 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_dad_work+0x119/0x15a0 net/ipv6/addrconf.c:4194
1 lock held by syz-executor/19745:
1 lock held by syz.0.3626/19917:
 #0: ffff8880341f00e8 (&kvm->slots_lock){+.+.}-{4:4}, at: class_mutex_constructor include/linux/mutex.h:253 [inline]
 #0: ffff8880341f00e8 (&kvm->slots_lock){+.+.}-{4:4}, at: kvm_vm_ioctl_set_memory_region+0x67/0xe0 virt/kvm/kvm_main.c:2169
1 lock held by syz.3.3627/19921:
2 locks held by syz.1.3628/19923:
 #0: ffff88803b5b6480 (sb_writers#13){.+.+}-{0:0}, at: mnt_want_write+0x41/0x90 fs/namespace.c:499
 #1: ffff88803db0dc38 (&type->i_mutex_dir_key#8){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:1027 [inline]
 #1: ffff88803db0dc38 (&type->i_mutex_dir_key#8){+.+.}-{4:4}, at: vfs_utimes+0x396/0x570 fs/utimes.c:65

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 38 Comm: khungtaskd Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0xe8/0x150 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x274/0x2d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x17a/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x135/0x170 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
 watchdog+0xf95/0xfe0 kernel/hung_task.c:515
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 18773 Comm: syz-executor Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:check_kcov_mode kernel/kcov.c:183 [inline]
RIP: 0010:__sanitizer_cov_trace_pc+0x2d/0x80 kernel/kcov.c:217
Code: fa 48 8b 04 24 65 48 8b 0c 25 08 10 b3 91 65 8b 35 28 66 f3 0f 81 e6 00 00 ff 00 ba 00 01 00 00 23 91 7c 0b 00 00 89 d7 09 f7 <74> 11 85 f6 75 39 85 d2 74 35 83 b9 3c 16 00 00 00 74 2c 8b 91 18
RSP: 0018:ffffc90004c17388 EFLAGS: 00000246
RAX: ffffffff8228a7d7 RBX: ffff88801aa80000 RCX: ffff88801abe1e40
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: dffffc0000000000 R11: fffff940003ee241 R12: 000000000007dc48
R13: dffffc0000000000 R14: ffff88813fffa901 R15: 0000000000001000
FS:  000055557e510500(0000) GS:ffff888126def000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7a7ca056c0 CR3: 000000004b7b6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 000000000000000e DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 get_entry mm/page_ext.c:154 [inline]
 lookup_page_ext mm/page_ext.c:263 [inline]
 page_ext_lookup+0x127/0x180 mm/page_ext.c:509
 page_ext_iter_begin include/linux/page_ext.h:132 [inline]
 page_table_check_set+0x239/0x610 mm/page_table_check.c:113
 page_table_check_ptes_set include/linux/page_table_check.h:76 [inline]
 set_ptes include/linux/pgtable.h:292 [inline]
 __copy_present_ptes mm/memory.c:1102 [inline]
 copy_present_ptes mm/memory.c:1181 [inline]
 copy_pte_range mm/memory.c:1304 [inline]
 copy_pmd_range+0x49e2/0x7980 mm/memory.c:1392
 copy_pud_range mm/memory.c:1429 [inline]
 copy_p4d_range mm/memory.c:1453 [inline]
 copy_page_range+0xae6/0x1130 mm/memory.c:1535
 dup_mmap+0xf56/0x1b40 mm/mmap.c:1827
 dup_mm kernel/fork.c:1529 [inline]
 copy_mm+0x13c/0x4b0 kernel/fork.c:1581
 copy_process+0x1665/0x3960 kernel/fork.c:2221
 kernel_clone+0x21d/0x7a0 kernel/fork.c:2651
 __do_sys_clone kernel/fork.c:2792 [inline]
 __se_sys_clone kernel/fork.c:2776 [inline]
 __x64_sys_clone+0x18b/0x1e0 kernel/fork.c:2776
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7a7bc75e93
Code: 1f 84 00 00 00 00 00 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 35 89 c2 85 c0 75 2c 64 48 8b 04 25 10 00 00
RSP: 002b:00007ffe8f686868 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f7a7bc75e93
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000001
R10: 000055557e5107d0 R11: 0000000000000246 R12: 0000000000000000
R13: 00000000000927c0 R14: 00000000001c4127 R15: 00007ffe8f686a00
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


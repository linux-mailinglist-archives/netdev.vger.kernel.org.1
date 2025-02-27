Return-Path: <netdev+bounces-170090-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 770C6A473F7
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 05:11:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6AEE03AD667
	for <lists+netdev@lfdr.de>; Thu, 27 Feb 2025 04:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A73F61B78F3;
	Thu, 27 Feb 2025 04:11:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0361194A44
	for <netdev@vger.kernel.org>; Thu, 27 Feb 2025 04:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740629485; cv=none; b=RSXuPFjRHepI0qhukeohPCvL6QlT+C3eQ+sbET+DY7+EDQlgheaWr9/i2l3gWD4z2XgiQ0E4LnZh05kppS22y58aKWi63/XKekQzsVqTaS7k4c74tE87xI4nesGzFQOrHgd+cUhCYonTqyOV6gndC4galUU63BpgKvqHNI1tgKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740629485; c=relaxed/simple;
	bh=RVOTWMxwgeZZicbgE1yIpXIdNDlt2s8g90dlOf01w/c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MXG19m4Sk4bxM6SX5DIgy3tw00y2v4uNUfqGGBFZoFw2RZ27uQsQ0BkreI3HsMYiBVMdi/wU4t6FcGbQaQxU+GxKjksP60ZGhV00IifAqc9darLRhvGrjbOggTrn9AHzVCIGDfba1IWdS629SuJGuxnXLzDGkZpYo0b18HxeOeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d2a6b4b2d4so14789485ab.2
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 20:11:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740629481; x=1741234281;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=reflnbTIL+6q5w7h0+TiiN5yeVw9KqB7gLrxNZSgjyQ=;
        b=QD4sENsMGVl1DN72EKqgyxv0cUUoRBtyKltmXgYiYJoxuWpA9+EQ+F9AukHTPgEBrw
         XhXBBLFkQDRaqoysdvbfvPU4VbQKmrwhwK0U2c72k3cY5nYF0nyLFd4P8iFpYIalWQdB
         L0bQN+etyFxHq6DKMOB7TVhNW6I1Qz7aONEHcdBR3QXCECnPYY0prK3foIiA2Kx+X68x
         7v6NzACPPAwTLGNKbzqPe3sGRr0sRkYjVtp5gLM65izuBt7g8CofSvvvbmZXkFnojFOV
         WbAtyPxxvmjpXpR8sxT4fF1tGvFSVujSKzqP666UtMjFp2kfU9NkZv0RqZm+W/JxnwMm
         R7dw==
X-Forwarded-Encrypted: i=1; AJvYcCWAxzgt1jCOCHcrBRe93lXGY5JlMNHojCcYXMHGDHl2zU39dZ7+WKlX/h3M7VaWjQu3f5MmYNA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZsg/W0IET7Hxm20QOffhTuN3DLIlgTaJ8dqyczEEuHcRJNuPS
	4V8ztteIaZXH/agIN0/s0icqsrW2vSkOJ1Hv42EyW+33c7QfuoMQOUj8y4AGR1bClSObhtZBqr2
	+figtYOhC1iJUl9x4CordLFO6FWZl/vzdjF7/iJSJwYpYECl5qBTEu1A=
X-Google-Smtp-Source: AGHT+IFkbSnOXLvEu8RWSqW09u+sQTpK5vA0I5ukP7RFfQbj6D5WSxofYSt97o/tqK3Oz/QxUYNsvF9O87Op5VjyG0AI33K/pUsj
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1b06:b0:3d0:443d:a5a4 with SMTP id
 e9e14a558f8ab-3d2fc0c5499mr96487245ab.2.1740629480953; Wed, 26 Feb 2025
 20:11:20 -0800 (PST)
Date: Wed, 26 Feb 2025 20:11:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bfe5e8.050a0220.222324.0001.GAE@google.com>
Subject: [syzbot] [net?] INFO: rcu detected stall in call_timer_fn (5)
From: syzbot <syzbot+03dd0f0cbfcf5c5c24f1@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    5cf80612d3f7 Merge tag 'x86-urgent-2025-02-22' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166c57f8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b50606b738b9b4cc
dashboard link: https://syzkaller.appspot.com/bug?extid=03dd0f0cbfcf5c5c24f1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15365fdf980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16654db0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-5cf80612.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cc16d06d7057/vmlinux-5cf80612.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1539167000d9/bzImage-5cf80612.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+03dd0f0cbfcf5c5c24f1@syzkaller.appspotmail.com

 #1: ffffc9000019b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x616/0x1770 drivers/tty/n_tty.c:2211
1 lock held by udevd/5345:
=============================================
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-0): P4733/1:b..l P52
rcu: 	(detected by 0, t=12230 jiffies, g=19065, q=65 ncpus=1)
task:kworker/u4:4    state:R  running task     stack:20472 pid:52    tgid:52    ppid:2      task_flags:0x4208160 flags:0x00004008
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <IRQ>
 sched_show_task+0x509/0x720 kernel/sched/core.c:7720
 rcu_print_detail_task_stall_rnp kernel/rcu/tree_stall.h:234 [inline]
 print_other_cpu_stall+0x120d/0x15c0 kernel/rcu/tree_stall.h:623
 check_cpu_stall kernel/rcu/tree_stall.h:795 [inline]
 rcu_pending kernel/rcu/tree.c:3597 [inline]
 rcu_sched_clock_irq+0xa26/0x10e0 kernel/rcu/tree.c:2647
 update_process_times+0x242/0x2f0 kernel/time/timer.c:2515
 tick_sched_handle kernel/time/tick-sched.c:276 [inline]
 tick_nohz_handler+0x37c/0x500 kernel/time/tick-sched.c:297
 __run_hrtimer kernel/time/hrtimer.c:1801 [inline]
 __hrtimer_run_queues+0x551/0xd30 kernel/time/hrtimer.c:1865
 hrtimer_interrupt+0x403/0xa40 kernel/time/hrtimer.c:1927
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1049
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 5e e3 1d f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> e3 4c 84 f5 65 8b 05 84 c1 f8 73 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc90000007ba0 EFLAGS: 00000206
RAX: d1ecd434209f7200 RBX: 1ffff92000000f78 RCX: ffffffff819d29ca
RDX: dffffc0000000000 RSI: ffffffff8c2aa440 RDI: 0000000000000001
RBP: ffffc90000007c30 R08: ffffffff94549947 R09: 1ffffffff28a9328
R10: dffffc0000000000 R11: fffffbfff28a9329 R12: dffffc0000000000
R13: 1ffff92000000f74 R14: ffffc90000007bc0 R15: 0000000000000246
 call_timer_fn+0x187/0x650 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2445
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 do_softirq+0x11b/0x1e0 kernel/softirq.c:462
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:389
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 rt6_uncached_list_add net/ipv6/route.c:146 [inline]
 icmp6_dst_alloc+0x3aa/0x420 net/ipv6/route.c:3298
 ndisc_send_skb+0x3f9/0x1530 net/ipv6/ndisc.c:493
 addrconf_dad_completed+0x76c/0xcd0 net/ipv6/addrconf.c:4356
 addrconf_dad_work+0xdbc/0x16a0
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:udevd           state:R  running task     stack:23904 pid:4733  tgid:4733  ppid:1      task_flags:0x400140 flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6944
 preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6968
 preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x130/0x140 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 __wake_up_common_lock+0x18c/0x1e0 kernel/sched/wait.c:108
 sock_def_readable+0x20f/0x5a0 net/core/sock.c:3476
 __netlink_sendskb net/netlink/af_netlink.c:1268 [inline]
 netlink_sendskb+0x9e/0x140 net/netlink/af_netlink.c:1274
 netlink_unicast+0x39d/0x990 net/netlink/af_netlink.c:1363
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1892
 sock_sendmsg_nosec net/socket.c:718 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:733
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2573
 ___sys_sendmsg net/socket.c:2627 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2659
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f2ec0524a4b
RSP: 002b:00007ffea3fc7618 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000556e7d0069e0 RCX: 00007f2ec0524a4b
RDX: 0000000000000000 RSI: 00007ffea3fc7628 RDI: 0000000000000004
RBP: 0000556e7d006500 R08: 0000000000000001 R09: 713e060499b8cc8f
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 00000000000000c0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread starved for 12230 jiffies! g19065 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26608 pid:17    tgid:17    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2024
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2226
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 52 Comm: kworker/u4:4 Not tainted 6.14.0-rc3-syzkaller-00293-g5cf80612d3f7 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: ipv6_addrconf addrconf_dad_work
RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
RIP: 0010:_raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
Code: 9c 8f 44 24 20 42 80 3c 23 00 74 08 4c 89 f7 e8 5e e3 1d f6 f6 44 24 21 02 75 52 41 f7 c7 00 02 00 00 74 01 fb bf 01 00 00 00 <e8> e3 4c 84 f5 65 8b 05 84 c1 f8 73 85 c0 74 43 48 c7 04 24 0e 36
RSP: 0018:ffffc90000007ba0 EFLAGS: 00000206
RAX: d1ecd434209f7200 RBX: 1ffff92000000f78 RCX: ffffffff819d29ca
RDX: dffffc0000000000 RSI: ffffffff8c2aa440 RDI: 0000000000000001
RBP: ffffc90000007c30 R08: ffffffff94549947 R09: 1ffffffff28a9328
R10: dffffc0000000000 R11: fffffbfff28a9329 R12: dffffc0000000000
R13: 1ffff92000000f74 R14: ffffc90000007bc0 R15: 0000000000000246
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000556e7d016f78 CR3: 0000000011cf6000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 call_timer_fn+0x187/0x650 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2445
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 do_softirq+0x11b/0x1e0 kernel/softirq.c:462
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:389
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 rt6_uncached_list_add net/ipv6/route.c:146 [inline]
 icmp6_dst_alloc+0x3aa/0x420 net/ipv6/route.c:3298
 ndisc_send_skb+0x3f9/0x1530 net/ipv6/ndisc.c:493
 addrconf_dad_completed+0x76c/0xcd0 net/ipv6/addrconf.c:4356
 addrconf_dad_work+0xdbc/0x16a0
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:init            state:S stack:17776 pid:1     tgid:1     ppid:0      task_flags:0x400100 flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 schedule_hrtimeout_range_clock+0x223/0x320 kernel/time/sleep_timeout.c:207
 do_sigtimedwait+0x408/0x720 kernel/signal.c:3784
 __do_sys_rt_sigtimedwait kernel/signal.c:3828 [inline]
 __se_sys_rt_sigtimedwait+0x1ef/0x2e0 kernel/signal.c:3806
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6a39b7b23c
RSP: 002b:00007ffd12a1ab20 EFLAGS: 00000246 ORIG_RAX: 0000000000000080
RAX: ffffffffffffffda RBX: 00007f6a39db113c RCX: 00007f6a39b7b23c
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 00007f6a39db64a8
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000000
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffd12a1ab88 R14: 000056394b900169 R15: 00007f6a39deda80
 </TASK>
task:kthreadd        state:S stack:25488 pid:2     tgid:2     ppid:0      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 kthreadd+0x45d/0x810 kernel/kthread.c:835
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:pool_workqueue_ state:S stack:28560 pid:3     tgid:3     ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 kthread_worker_fn+0x491/0xb70 kernel/kthread.c:1017
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-rcu_g state:I stack:29584 pid:4     tgid:4     ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-sync_ state:I stack:29432 pid:5     tgid:5     ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-slub_ state:I stack:29584 pid:6     tgid:6     ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-netns state:I stack:29176 pid:7     tgid:7     ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:0     state:R  running task     stack:23864 pid:8     tgid:8     ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: events nsim_fib_event_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 schedule_timeout_uninterruptible kernel/time/sleep_timeout.c:158 [inline]
 msleep+0x9b/0xe0 kernel/time/sleep_timeout.c:318
 nsim_fib4_rt_add drivers/net/netdevsim/fib.c:369 [inline]
 nsim_fib4_rt_insert drivers/net/netdevsim/fib.c:432 [inline]
 nsim_fib4_event drivers/net/netdevsim/fib.c:464 [inline]
 nsim_fib_event drivers/net/netdevsim/fib.c:884 [inline]
 nsim_fib_event_work+0x209c/0x3f00 drivers/net/netdevsim/fib.c:1493
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:1     state:R  running task     stack:19056 pid:9     tgid:9     ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue: events console_callback
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7087
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x264/0x550 kernel/locking/lockdep.c:5855
Code: 2b 00 74 08 4c 89 f7 e8 8a 45 8c 00 f6 44 24 61 02 0f 85 85 01 00 00 41 f7 c7 00 02 00 00 74 01 fb 48 c7 44 24 40 0e 36 e0 45 <4b> c7 44 25 00 00 00 00 00 43 c7 44 25 09 00 00 00 00 43 c7 44 25
RSP: 0018:ffffc900001b79c0 EFLAGS: 00000206
RAX: 0000000000000001 RBX: 1ffff92000036f44 RCX: ffff88801cafd368
RDX: dffffc0000000000 RSI: ffffffff8c2ab6a0 RDI: ffffffff8c80eec0
RBP: ffffc900001b7b08 R08: ffffffff96de87df R09: 1ffffffff2dbd0fb
R10: dffffc0000000000 R11: fffffbfff2dbd0fc R12: 1ffff92000036f40
R13: dffffc0000000000 R14: ffffc900001b7a20 R15: 0000000000000246
 process_one_work kernel/workqueue.c:3212 [inline]
 process_scheduled_works+0x9e4/0x18e0 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:0H    state:I stack:27152 pid:10    tgid:10    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (events_highpri)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 worker_thread+0xa30/0xd30 kernel/workqueue.c:3413
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/u4:0    state:I stack:22800 pid:11    tgid:11    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 worker_thread+0xa30/0xd30 kernel/workqueue.c:3413
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-mm_pe state:I stack:29584 pid:12    tgid:12    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/u4:1    state:I stack:25392 pid:13    tgid:13    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 worker_thread+0xa30/0xd30 kernel/workqueue.c:3413
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:rcu_tasks_kthre state:I stack:27736 pid:14    tgid:14    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rcu_tasks_one_gp+0x897/0xe10 kernel/rcu/tasks.h:610
 rcu_tasks_kthread+0x180/0x1b0 kernel/rcu/tasks.h:657
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:rcu_tasks_trace state:I stack:27736 pid:15    tgid:15    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rcu_tasks_one_gp+0x897/0xe10 kernel/rcu/tasks.h:610
 rcu_tasks_kthread+0x180/0x1b0 kernel/rcu/tasks.h:657
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:ksoftirqd/0     state:R  running task     stack:21136 pid:16    tgid:16    ppid:2      task_flags:0x4208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 smpboot_thread_fn+0x61e/0xa30 kernel/smpboot.c:160
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:rcu_preempt     state:R  running task     stack:26608 pid:17    tgid:17    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2024
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2226
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:rcu_exp_par_gp_ state:S stack:29808 pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 kthread_worker_fn+0x491/0xb70 kernel/kthread.c:1017
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:rcu_exp_gp_kthr state:S stack:28272 pid:19    tgid:19    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 kthread_worker_fn+0x491/0xb70 kernel/kthread.c:1017
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:migration/0     state:R  running task     stack:29168 pid:20    tgid:20    ppid:2      task_flags:0x4208040 flags:0x00004000
Stopper: 0x0 <- 0x0
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 smpboot_thread_fn+0x61e/0xa30 kernel/smpboot.c:160
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:cpuhp/0         state:S stack:25296 pid:21    tgid:21    ppid:2      task_flags:0x4208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 smpboot_thread_fn+0x61e/0xa30 kernel/smpboot.c:160
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kdevtmpfs       state:S stack:25040 pid:22    tgid:22    ppid:2      task_flags:0x208140 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 devtmpfs_work_loop+0x1018/0x1040 drivers/base/devtmpfs.c:408
 devtmpfsd+0x4c/0x50 drivers/base/devtmpfs.c:441
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-inet_ state:I stack:29584 pid:23    tgid:23    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kauditd         state:S stack:28528 pid:24    tgid:24    ppid:2      task_flags:0x200040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 kauditd_thread+0x89c/0x9b0 kernel/audit.c:911
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:khungtaskd      state:S stack:28440 pid:25    tgid:25    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 watchdog+0x93/0x10a0 kernel/hung_task.c:403
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:oom_reaper      state:S stack:29680 pid:26    tgid:26    ppid:2      task_flags:0x200040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 oom_reaper+0x10d/0xb00 mm/oom_kill.c:650
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-write state:I stack:29584 pid:27    tgid:27    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/u4:2    state:I stack:25104 pid:28    tgid:28    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 worker_thread+0xa30/0xd30 kernel/workqueue.c:3413
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kcompactd0      state:R  running task     stack:23160 pid:29    tgid:29    ppid:2      task_flags:0x200040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 kcompactd+0xd40/0x14b0 mm/compaction.c:3199
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kcompactd1      state:R  running task     stack:27800 pid:30    tgid:30    ppid:2      task_flags:0x200040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 kcompactd+0xd40/0x14b0 mm/compaction.c:3199
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/u4:3    state:I stack:22064 pid:31    tgid:31    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (events_unbound)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 worker_thread+0xa30/0xd30 kernel/workqueue.c:3413
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:ksmd            state:S stack:29200 pid:32    tgid:32    ppid:2      task_flags:0x200040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 ksm_scan_thread+0x3b0/0x490 mm/ksm.c:2685
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:khugepaged      state:S stack:28688 pid:33    tgid:33    ppid:2      task_flags:0x200040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 khugepaged_wait_work mm/khugepaged.c:2595 [inline]
 khugepaged+0x16e9/0x1950 mm/khugepaged.c:2607
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-pencr state:I stack:29584 pid:34    tgid:34    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-pdecr state:I stack:29584 pid:35    tgid:35    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-crypt state:I stack:29584 pid:36    tgid:36    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-kinte state:I stack:29584 pid:37    tgid:37    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:1H    state:R  running task     stack:25552 pid:38    tgid:38    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (kblockd)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 worker_thread+0xa30/0xd30 kernel/workqueue.c:3413
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-kbloc state:I stack:29584 pid:39    tgid:39    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-blkcg state:I stack:29584 pid:40    tgid:40    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:irq/9-acpi      state:S stack:29680 pid:41    tgid:41    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 irq_wait_for_interrupt kernel/irq/manage.c:1125 [inline]
 irq_thread+0x4dd/0x640 kernel/irq/manage.c:1314
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-tpm_d state:I stack:29584 pid:42    tgid:42    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-ata_s state:I stack:29584 pid:43    tgid:43    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-md    state:I stack:29584 pid:44    tgid:44    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-md_bi state:I stack:29584 pid:45    tgid:45    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-edac- state:I stack:29584 pid:46    tgid:46    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-ib-co state:I stack:29584 pid:47    tgid:47    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/u5:0    state:I stack:28048 pid:48    tgid:48    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (hci0)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 worker_thread+0xa30/0xd30 kernel/workqueue.c:3413
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-ib-co state:I stack:29584 pid:49    tgid:49    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-ib_mc state:I stack:29584 pid:50    tgid:50    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-ib_nl state:I stack:29584 pid:51    tgid:51    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/u4:4    state:R  running task     stack:20472 pid:52    tgid:52    ppid:2      task_flags:0x4208160 flags:0x00004008
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <IRQ>
 sched_show_task+0x509/0x720 kernel/sched/core.c:7720
 show_state_filter+0x19e/0x270 kernel/sched/core.c:7765
 kbd_keycode drivers/tty/vt/keyboard.c:1522 [inline]
 kbd_event+0x30fa/0x4910 drivers/tty/vt/keyboard.c:1541
 input_handle_events_default+0x107/0x1c0 drivers/input/input.c:2575
 input_pass_values+0x268/0x890 drivers/input/input.c:127
 input_event_dispose drivers/input/input.c:341 [inline]
 input_handle_event drivers/input/input.c:369 [inline]
 input_repeat_key+0x449/0x6d0 drivers/input/input.c:2262
 call_timer_fn+0x187/0x650 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x66a/0x8e0 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2445
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:561
 do_softirq+0x11b/0x1e0 kernel/softirq.c:462
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:389
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 rt6_uncached_list_add net/ipv6/route.c:146 [inline]
 icmp6_dst_alloc+0x3aa/0x420 net/ipv6/route.c:3298
 ndisc_send_skb+0x3f9/0x1530 net/ipv6/ndisc.c:493
 addrconf_dad_completed+0x76c/0xcd0 net/ipv6/addrconf.c:4356
 addrconf_dad_work+0xdbc/0x16a0
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xabe/0x18e0 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-rpcio state:I stack:29584 pid:53    tgid:53    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-xprti state:I stack:29584 pid:54    tgid:54    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-cfg80 state:I stack:29584 pid:55    tgid:55    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/0:2     state:I stack:22000 pid:57    tgid:57    ppid:2      task_flags:0x4208060 flags:0x00004000
Workqueue:  0x0 (mld)
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 worker_thread+0xa30/0xd30 kernel/workqueue.c:3413
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kswapd0         state:S stack:26200 pid:74    tgid:74    ppid:2      task_flags:0x220840 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 kswapd_try_to_sleep mm/vmscan.c:7176 [inline]
 kswapd+0x803/0x3b10 mm/vmscan.c:7234
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kswapd1         state:S stack:28528 pid:81    tgid:81    ppid:2      task_flags:0x220840 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 kswapd_try_to_sleep mm/vmscan.c:7176 [inline]
 kswapd+0x803/0x3b10 mm/vmscan.c:7234
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:ecryptfs-kthrea state:S stack:29744 pid:86    tgid:86    ppid:2      task_flags:0x200040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 ecryptfs_threadfn+0x316/0x3e0 fs/ecryptfs/kthread.c:48
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nfsio state:I stack:29584 pid:89    tgid:89    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-cifsi state:I stack:29584 pid:90    tgid:90    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-smb3d state:I stack:29584 pid:91    tgid:91    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-cifsf state:I stack:29584 pid:92    tgid:92    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-cifso state:I stack:29584 pid:93    tgid:93    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-defer state:I stack:29584 pid:94    tgid:94    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-serve state:I stack:29584 pid:95    tgid:95    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-cfid_ state:I stack:29584 pid:96    tgid:96    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-cifs- state:I stack:29584 pid:97    tgid:97    ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:jfsIO           state:S stack:29936 pid:104   tgid:104   ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 jfsIOWait+0x102/0x240 fs/jfs/jfs_logmgr.c:2331
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:jfsCommit       state:S stack:29424 pid:105   tgid:105   ppid:2      task_flags:0x200040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 jfs_lazycommit+0x95c/0xb80 fs/jfs/jfs_txnmgr.c:2761
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:jfsSync         state:S stack:29808 pid:106   tgid:106   ppid:2      task_flags:0x200040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 jfs_sync+0x52e/0x6b0 fs/jfs/jfs_txnmgr.c:2948
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-xfsal state:I stack:29584 pid:107   tgid:107   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-xfs_m state:I stack:29584 pid:108   tgid:108   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-user_ state:I stack:29584 pid:110   tgid:110   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-gfs2_ state:I stack:29584 pid:112   tgid:112   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-kthro state:I stack:29584 pid:116   tgid:116   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:irq/26-aerdrv   state:S stack:29680 pid:135   tgid:135   ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 irq_wait_for_interrupt kernel/irq/manage.c:1125 [inline]
 irq_thread+0x4dd/0x640 kernel/irq/manage.c:1314
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-acpi_ state:I stack:29584 pid:156   tgid:156   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nfit  state:I stack:29584 pid:159   tgid:159   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:hwrng           state:R  running task     stack:28888 pid:753   tgid:753   ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 hwrng_fillfn+0x306/0x410 drivers/char/hw_random/core.c:515
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:card1-crtc0     state:S stack:29808 pid:775   tgid:775   ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 kthread_worker_fn+0x491/0xb70 kernel/kthread.c:1017
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nbd0- state:I stack:29584 pid:837   tgid:837   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nbd1- state:I stack:29584 pid:840   tgid:840   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nbd2- state:I stack:29584 pid:843   tgid:843   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nbd3- state:I stack:29584 pid:846   tgid:846   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nbd4- state:I stack:29584 pid:849   tgid:849   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nbd5- state:I stack:29584 pid:852   tgid:852   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nbd6- state:I stack:29584 pid:855   tgid:855   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nbd7- state:I stack:29584 pid:858   tgid:858   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nbd8- state:I stack:29584 pid:861   tgid:861   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nbd9- state:I stack:29584 pid:864   tgid:864   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nbd10 state:I stack:29584 pid:866   tgid:866   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nbd11 state:I stack:29584 pid:870   tgid:870   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nbd12 state:I stack:29584 pid:873   tgid:873   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nbd13 state:I stack:29584 pid:876   tgid:876   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
task:kworker/R-nbd14 state:I stack:29584 pid:879   tgid:879   ppid:2      task_flags:0x4208060 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x190e/0x4c90 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 rescuer_thread+0xe23/0xf90 kernel/workqueue.c:3548
 kthread+0x7a9/0x920 ker

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


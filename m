Return-Path: <netdev+bounces-246552-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62E60CEE081
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 10:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C99A13003F6B
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 09:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 894F31DF748;
	Fri,  2 Jan 2026 09:02:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f80.google.com (mail-ot1-f80.google.com [209.85.210.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 699BEAD5A
	for <netdev@vger.kernel.org>; Fri,  2 Jan 2026 09:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767344542; cv=none; b=CN6ZuXcpO9PoZA8Nf6ixY0iJAY4OHm+g2BktNgnYvCH9Kj47Wpq1sEt3Ci5iNaqer0vIIHlir9rXT3ah/rog2KWZuarKKW2RWVLWdF7Hs1c7NBtp4KWO+Rwebl32CTGpHRQcjAGzlded0fGY50v0DD/bC0hbNpfuwkekSJmYDqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767344542; c=relaxed/simple;
	bh=i9oU3H4w9otYWLZVCqRqcI7+W1R0KYUzzRSaT2QrHI4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IORcBWCDsWecHU6P7OPFMBtvovVQUX7Ngs0tOsz8CI+djC57uzo7o9hS7Y2IvtIi6EIkMy6xTOZug2qK22I3vmO1Lk3wJPE8TAnpA9Maixoaxio+v+KnbkLkR7v5PDs1KK7NVxWu5krv6k3dGTD6jyY9YL7lAPJ/2jDPB4JiSIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f80.google.com with SMTP id 46e09a7af769-7c75b4d04acso31782886a34.2
        for <netdev@vger.kernel.org>; Fri, 02 Jan 2026 01:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767344539; x=1767949339;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CuRMDnn3hd2+Z/2SKg5tzOUmVdHPfhpn626ZGITQ4c8=;
        b=Y2w3Mhbs5sYxE6uIdh+M5Nhm7lZV/QFWOHl92SHKXKd0STfhPlGLwVjcUyQvyFKi4Z
         eGHai5RGEFOTO0CkZc00cOKR3qVbZ0c1m0nP3RXQFgNOjmjDJX8kLHP2e2cpibiYrIbL
         bp6Cwqr0K+VtwKdOvuLPSPn9f62fLOr1kaftWAxZ+Ua8FfsAvMbOsXSpwvuai6vCyfzU
         5u9iQdnS4XtaTqPpVQUwZZCH3dQ2hoNS8K4OsS3mdxOvtR9ZA6nVFfjuVRk4OYUxi+A4
         wrsarj5n7G2zFUWJlhXSFZfjjPY6Swg0kChhZu+PiLQq8QMBXSaBkrkEA13/wpIVbpjV
         asdA==
X-Forwarded-Encrypted: i=1; AJvYcCXKGiSRpzn3Ufb6G1NIXWl4NHsJZSk7GT787tp6E2RY8GMqFBe2re3DThHeaiZVVXweFKct01c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwM+FuTVT00W0d4XTwIBQH1dApzoKeqGfykmjXs6q9GKnMKUNYe
	C7RSBsvVvCSP50tj5L4T2bpN09Vj++z1vIUAQZQJA7p5xuIztENe4RdlsXAyyyMHlsenPOjupG5
	ZIdlu+6Kh2gsJDdNBSey9xB3zT20VigMSdwcEryDxWLxy968NdbX7YxY0MAs=
X-Google-Smtp-Source: AGHT+IHWFWxF9Ar5L2Dmnw2RQ+r8B/eO1MrbSFpfAvLfpXBsnyVgpMauRdN3u52QGZzUv34BgSATQoFK1s42OqTYlQvhIxiBDlKh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ba02:0:b0:659:9a49:8fc8 with SMTP id
 006d021491bc7-65d0eb95d36mr13069892eaf.65.1767344539378; Fri, 02 Jan 2026
 01:02:19 -0800 (PST)
Date: Fri, 02 Jan 2026 01:02:19 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6957899b.050a0220.a1b6.0355.GAE@google.com>
Subject: [syzbot] [net?] INFO: rcu detected stall in neigh_periodic_work (5)
From: syzbot <syzbot+6e75ed7b520de921c7a7@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c875a6c32467 Merge tag 'usb-6.19-rc3' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1796c12a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a11e0f726bfb6765
dashboard link: https://syzkaller.appspot.com/bug?extid=6e75ed7b520de921c7a7
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14366bda580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d6805e78608c/disk-c875a6c3.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4220ba556100/vmlinux-c875a6c3.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4061ae28765c/bzImage-c875a6c3.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e75ed7b520de921c7a7@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (1 GPs behind) idle=05c4/1/0x4000000000000000 softirq=16587/16591 fqs=0
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5837/2:b..l
rcu: 	(detected by 0, t=10512 jiffies, g=9065, q=562 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6088 Comm: kworker/1:7 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Workqueue: events_power_efficient neigh_periodic_work
RIP: 0010:lock_acquire+0x2b/0x330 kernel/locking/lockdep.c:5828
Code: 0f 1e fa 41 57 4d 89 cf 41 56 41 89 f6 41 55 41 89 d5 41 54 45 89 c4 55 89 cd 53 48 89 fb 48 83 ec 38 65 48 8b 05 7d b4 18 12 <48> 89 44 24 30 31 c0 66 90 65 8b 05 99 b4 18 12 83 f8 07 0f 87 a2
RSP: 0000:ffffc90000a08d18 EFLAGS: 00000096
RAX: 0ff401f7067e1f00 RBX: ffffffff8e3c96a0 RCX: 0000000000000002
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8e3c96a0
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: ffff8880765032ab R11: ffff888031870b30 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881249f5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffdeb874218 CR3: 0000000022f14000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:867 [inline]
 advance_sched+0x699/0xc80 net/sched/sch_taprio.c:991
 __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
 __hrtimer_run_queues+0x202/0xc40 kernel/time/hrtimer.c:1841
 hrtimer_interrupt+0x397/0x8e0 kernel/time/hrtimer.c:1903
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1045 [inline]
 __sysvec_apic_timer_interrupt+0x10b/0x3c0 arch/x86/kernel/apic/apic.c:1062
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0x9f/0xc0 arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:lockdep_enabled kernel/locking/lockdep.c:124 [inline]
RIP: 0010:lock_acquire kernel/locking/lockdep.c:5844 [inline]
RIP: 0010:lock_acquire+0x127/0x330 kernel/locking/lockdep.c:5825
Code: 0d 12 e9 ee 0e 85 c9 0f 84 b1 00 00 00 65 8b 05 d7 fa 18 12 85 c0 0f 85 a2 00 00 00 65 48 8b 05 97 b3 18 12 8b 90 2c 0b 00 00 <85> d2 0f 85 8c 00 00 00 9c 8f 04 24 fa 48 c7 c7 2a e5 bb 8d e8 d0
RSP: 0000:ffffc90003117430 EFLAGS: 00000246
RAX: ffff888031870000 RBX: ffffffff8e3c96a0 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff816cb681 RDI: fffffbfff1c792d4
RBP: 0000000000000002 R08: 0000000000000000 R09: 0000000000000000
R10: ffffc90003117568 R11: 0000000000002ba1 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:867 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1195 [inline]
 unwind_next_frame+0xd1/0x20b0 arch/x86/kernel/unwind_orc.c:495
 __unwind_start+0x45f/0x7f0 arch/x86/kernel/unwind_orc.c:773
 unwind_start arch/x86/include/asm/unwind.h:64 [inline]
 arch_stack_walk+0x73/0x100 arch/x86/kernel/stacktrace.c:24
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:56
 kasan_save_track+0x14/0x30 mm/kasan/common.c:77
 unpoison_slab_object mm/kasan/common.c:339 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:365
 kasan_slab_alloc include/linux/kasan.h:252 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5263 [inline]
 kmem_cache_alloc_node_noprof+0x298/0x800 mm/slub.c:5315
 kmalloc_reserve+0x18b/0x2c0 net/core/skbuff.c:586
 __alloc_skb+0x186/0x410 net/core/skbuff.c:690
 alloc_skb include/linux/skbuff.h:1383 [inline]
 nlmsg_new include/net/netlink.h:1055 [inline]
 __neigh_notify+0xe6/0x380 net/core/neighbour.c:3544
 neigh_cleanup_and_release+0x97/0x280 net/core/neighbour.c:120
 neigh_periodic_work+0x6b6/0xc10 net/core/neighbour.c:1030
 process_one_work+0x9ba/0x1b20 kernel/workqueue.c:3257
 process_scheduled_works kernel/workqueue.c:3340 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3421
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
task:syz-executor    state:R  running task     stack:22872 pid:5837  tgid:5837  ppid:5832   task_flags:0x400100 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1139/0x6150 kernel/sched/core.c:6863
 preempt_schedule_common+0x44/0xc0 kernel/sched/core.c:7047
 preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0x61/0x80 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 unlock_task_sighand include/linux/sched/signal.h:756 [inline]
 do_send_sig_info kernel/signal.c:1270 [inline]
 group_send_sig_info+0x2d5/0x300 kernel/signal.c:1419
 kill_pid_info_type+0x92/0x2a0 kernel/signal.c:1459
 kill_pid_info kernel/signal.c:1473 [inline]
 kill_proc_info+0x6f/0x1b0 kernel/signal.c:1480
 kill_something_info+0x2a2/0x310 kernel/signal.c:1577
 __do_sys_kill kernel/signal.c:3953 [inline]
 __se_sys_kill kernel/signal.c:3947 [inline]
 __x64_sys_kill+0xd7/0x140 kernel/signal.c:3947
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdcb212ba37
RSP: 002b:00007ffcb7ad7048 EFLAGS: 00000206 ORIG_RAX: 000000000000003e
RAX: ffffffffffffffda RBX: 00007ffcb7ad7590 RCX: 00007fdcb212ba37
RDX: 0000000000000003 RSI: 0000000000000009 RDI: 0000000000001736
RBP: 000055556c55c660 R08: 0000000000000007 R09: 00007fdcb2fe8000
R10: 0000000000000001 R11: 0000000000000206 R12: 00007ffcb7ad705c
R13: 000055556c558290 R14: 000055556c55c618 R15: 00007ffcb7ad70f0
 </TASK>
rcu: rcu_preempt kthread starved for 10512 jiffies! g9065 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27720 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1139/0x6150 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6960
 schedule_timeout+0x123/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x1ea/0xaf0 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x26d/0x380 kernel/rcu/tree.c:2285
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 5944 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:82
Code: c6 5f 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 13 49 12 00 fb f4 <e9> cc 35 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffc90000007598 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 0000000000000002
RDX: ffff888031370000 RSI: ffffffff816bdc71 RDI: ffffffff8bf2b400
RBP: ffffffff90333c20 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff9088b4d7 R11: 0000000000000001 R12: 0000000000000003
R13: 0000000000000003 R14: ffff8880b843bbc0 R15: fffffbfff2066784
FS:  0000000000000000(0000) GS:ffff8881248f5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdcb2fe7ff8 CR3: 000000000e184000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 kvm_wait arch/x86/kernel/kvm.c:1085 [inline]
 kvm_wait+0x186/0x1f0 arch/x86/kernel/kvm.c:1067
 pv_wait arch/x86/include/asm/paravirt.h:569 [inline]
 pv_wait_head_or_lock kernel/locking/qspinlock_paravirt.h:466 [inline]
 __pv_queued_spin_lock_slowpath+0x4e1/0xcf0 kernel/locking/qspinlock.c:325
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:557 [inline]
 queued_spin_lock_slowpath arch/x86/include/asm/qspinlock.h:51 [inline]
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 do_raw_spin_lock+0x20e/0x2b0 kernel/locking/spinlock_debug.c:116
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 ___neigh_create+0x9eb/0x2920 net/core/neighbour.c:690
 ip6_finish_output2+0x11aa/0x1cf0 net/ipv6/ip6_output.c:128
 __ip6_finish_output+0x3cd/0x1010 net/ipv6/ip6_output.c:209
 ip6_finish_output net/ipv6/ip6_output.c:220 [inline]
 NF_HOOK_COND include/linux/netfilter.h:307 [inline]
 ip6_output+0x253/0x710 net/ipv6/ip6_output.c:247
 dst_output include/net/dst.h:464 [inline]
 NF_HOOK include/linux/netfilter.h:318 [inline]
 ndisc_send_skb+0xa85/0x1f50 net/ipv6/ndisc.c:512
 ndisc_send_rs+0x129/0x670 net/ipv6/ndisc.c:722
 addrconf_rs_timer+0x40d/0x870 net/ipv6/addrconf.c:4037
 call_timer_fn+0x19a/0x5a0 kernel/time/timer.c:1748
 expire_timers kernel/time/timer.c:1799 [inline]
 __run_timers+0x74a/0xae0 kernel/time/timer.c:2373
 __run_timer_base kernel/time/timer.c:2385 [inline]
 __run_timer_base kernel/time/timer.c:2377 [inline]
 run_timer_base+0x114/0x190 kernel/time/timer.c:2394
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2404
 handle_softirqs+0x219/0x950 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:csd_lock_wait kernel/smp.c:342 [inline]
RIP: 0010:smp_call_function_many_cond+0xe02/0x15e0 kernel/smp.c:877
Code: 10 4c 89 74 24 10 49 89 d5 48 89 d5 48 89 54 24 18 49 c1 ed 03 83 e5 07 4d 01 e5 83 c5 03 e8 35 5b 0c 00 f3 90 41 0f b6 45 00 <40> 38 c5 7c 08 84 c0 0f 85 b6 05 00 00 8b 43 08 31 ff 83 e0 01 41
RSP: 0018:ffffc9000434f6d0 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff8880b8540cc0 RCX: ffffffff81b28bb1
RDX: ffff888031370000 RSI: ffffffff81b28b8b RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: ffff888031370b30 R12: dffffc0000000000
R13: ffffed10170a8199 R14: 0000000000000001 R15: 0000000000000001
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1043
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:1382 [inline]
 flush_tlb_mm_range+0x2f0/0x12c0 arch/x86/mm/tlb.c:1472
 tlb_flush arch/x86/include/asm/tlb.h:23 [inline]
 tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:490 [inline]
 tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:480 [inline]
 tlb_flush_mmu mm/mmu_gather.c:403 [inline]
 tlb_finish_mmu+0x3c9/0x7c0 mm/mmu_gather.c:497
 exit_mmap+0x3f9/0xb60 mm/mmap.c:1290
 __mmput+0x12a/0x410 kernel/fork.c:1173
 mmput+0x62/0x70 kernel/fork.c:1196
 exit_mm kernel/exit.c:581 [inline]
 do_exit+0x7d7/0x2bd0 kernel/exit.c:959
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1112
 get_signal+0x2671/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x7e0 arch/x86/kernel/signal.c:337
 __exit_to_user_mode_loop kernel/entry/common.c:41 [inline]
 exit_to_user_mode_loop+0x8c/0x540 kernel/entry/common.c:75
 __exit_to_user_mode_prepare include/linux/irq-entry-common.h:226 [inline]
 syscall_exit_to_user_mode_prepare include/linux/irq-entry-common.h:256 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:159 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:194 [inline]
 do_syscall_64+0x4ee/0xf80 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb3707c2005
Code: Unable to access opcode bytes at 0x7fb3707c1fdb.
RSP: 002b:00007ffdeb8742b0 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: fffffffffffffdfc RBX: 0000000000000020 RCX: 00007fb3707c2005
RDX: 00007ffdeb8742f0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007ffdeb87435c R08: 0000000000000000 R09: 00007fb37166a000
R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000000e
R13: 00000000000927c0 R14: 000000000004575f R15: 00007ffdeb8743b0
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


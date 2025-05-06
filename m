Return-Path: <netdev+bounces-188361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C85AAC774
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 16:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 208013BCB89
	for <lists+netdev@lfdr.de>; Tue,  6 May 2025 14:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04618281512;
	Tue,  6 May 2025 14:06:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD1427979F
	for <netdev@vger.kernel.org>; Tue,  6 May 2025 14:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540402; cv=none; b=KqzidaP7m6+CMQkuAHbw9Nd2gYKPPs/RJMtjZ7RwEmzzASobOeBN3x1Z9F/w8/dEmS21qrc7vCvwGvGOFiHOt+kfECdYDSGDiz6JHHkTx78jed7WXSE65RZKkjOuwc3Q1QdZ6wgiOsmNX7yjp92ZR3p8mSssEdrXT36SM7YnzO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540402; c=relaxed/simple;
	bh=7DqWL3xPwZjzGc6iyrJyXnAjgOn0T0gdUDID/jD7zzI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=sI5sKFIj72QJVy+bv/r5rcal6HlD9o1RvFQNhUrpibeBhLz2714gxJe10ikuHxSdTNyy9YF11yQoUPuTHEZX4OZwPIk1RSl7u37qEmH+V0nDmmdCAfEsulTyJhk6GyEfsesi1ONlrpzZ3oe8A/cK22llB7AfHXWriA6lwTMLje0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-85b3a6c37e2so591708839f.0
        for <netdev@vger.kernel.org>; Tue, 06 May 2025 07:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746540400; x=1747145200;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BkoWNmadE1F1tRDTje4gKHNFMx4m5xeUfDErgLJmpMM=;
        b=BPe19Obf+6l505PD6c/fkjSf0ZYNQt2emERg3tMODUWv99p98ikI2q1Fc0KrkqRPAD
         OCIosV49s8Kga1g9XXEJXn+PJ+0LlSxTltvdTa9IE+7BM8FoYx8HZaZvjI5OhNjIpnzx
         1Rcv+915KvegIjdqexj1FiaTBnmuFYnTbb68xUR60IEAp78v/9AdVT/r6Ma3oLj+YEGY
         mLJyKvI/3nQPQPXTMijzwdqXfDYhXdO0kRt86atG6W0qboF7AJ8QFxxQ7ndzconSdJ1Z
         MmT33E83vSE7pnpPU4n2KFWB0Ba+U2AeDqmKJ6+mh6UvdLs6lTJ+8Am+r2Xd0n0XgwLs
         TB7A==
X-Forwarded-Encrypted: i=1; AJvYcCW4Ro+5lqpwhFOH3Kr+NpfYoqHaF8QUpGmOd/sMl67JJBGz8JLpvGXE0ggsNfx3SlRRNG4NQRI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrbpFCwRFYFhYRugcphH18JwBf3zOkKQlr+erAByoJ6FTmQHyS
	YXwe8dIzSHZg5/yt82r0NZZ/KRyCbRCwM5giBurM5TkGLbvbdnCJI1tQ2Sy/ZF91IXJrdIEsOel
	eMzCfTlapzKZwOFgivbdPU2hiiqjpjL9bBgufoJ/vAqju/Q2hMtptnBM=
X-Google-Smtp-Source: AGHT+IEPx/QglHdUWMpzC4h8uE4W0zIyY+dpcpvsrg7A0blgYvENcCMHvadkPOwQQBoEUZoOgXF9nEKjCZUXPi4coSvW2iBfZjsZ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1908:b0:3d3:dd32:73d5 with SMTP id
 e9e14a558f8ab-3da5b23bd53mr112709665ab.4.1746540400213; Tue, 06 May 2025
 07:06:40 -0700 (PDT)
Date: Tue, 06 May 2025 07:06:40 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681a1770.050a0220.a19a9.000d.GAE@google.com>
Subject: [syzbot] [net?] INFO: rcu detected stall in inet_rtm_newaddr (2)
From: syzbot <syzbot+51cd74c5dfeafd65e488@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    01f95500a162 Merge tag 'uml-for-linux-6.15-rc6' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1347702f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b39cb28b0a399ed3
dashboard link: https://syzkaller.appspot.com/bug?extid=51cd74c5dfeafd65e488
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16cd49b3980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18300d795306/disk-01f95500.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6d358d59c6dc/vmlinux-01f95500.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bcdf944974fd/bzImage-01f95500.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51cd74c5dfeafd65e488@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (1 GPs behind) idle=530c/1/0x4000000000000000 softirq=17280/17282 fqs=3
rcu: 	(detected by 1, t=10506 jiffies, g=8293, q=1787 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5923 Comm: syz-executor Not tainted 6.15.0-rc5-syzkaller-00022-g01f95500a162 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
RIP: 0010:pv_queued_spin_unlock arch/x86/include/asm/paravirt.h:577 [inline]
RIP: 0010:queued_spin_unlock arch/x86/include/asm/qspinlock.h:57 [inline]
RIP: 0010:do_raw_spin_unlock+0x172/0x230 kernel/locking/spinlock_debug.c:142
Code: 48 ba 00 00 00 00 00 fc ff df 48 c1 e8 03 80 3c 10 00 0f 85 ba 00 00 00 48 83 3d 28 ba 89 0c 00 74 4e 48 89 df e8 0e 15 d7 09 <90> 5b 5d 41 5c c3 cc cc cc cc 48 c7 c6 e0 6c 8d 8b 48 89 df e8 45
RSP: 0018:ffffc90000007ce8 EFLAGS: 00000046
RAX: 0000000000000001 RBX: ffffffff9ad4e378 RCX: ffffffff81985ed3
RDX: dffffc0000000000 RSI: 0000000000000004 RDI: ffffffff9ad4e378
RBP: ffffffff9ad4e380 R08: 0000000000000000 R09: fffffbfff35a9c6f
R10: ffffffff9ad4e37b R11: ffffffff9ad4e378 R12: ffffffff9ad4e388
R13: ffff88807bc05340 R14: dffffc0000000000 R15: 1ffff92000000fa8
FS:  0000555577c53500(0000) GS:ffff8881249df000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555562d75808 CR3: 000000005fb8a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:150 [inline]
 _raw_spin_unlock_irqrestore+0x22/0x80 kernel/locking/spinlock.c:194
 debug_object_activate+0x2ec/0x4c0 lib/debugobjects.c:836
 debug_hrtimer_activate kernel/time/hrtimer.c:445 [inline]
 debug_activate kernel/time/hrtimer.c:484 [inline]
 enqueue_hrtimer+0x23/0x3b0 kernel/time/hrtimer.c:1088
 __run_hrtimer kernel/time/hrtimer.c:1778 [inline]
 __hrtimer_run_queues+0x8ff/0xad0 kernel/time/hrtimer.c:1825
 hrtimer_interrupt+0x397/0x8e0 kernel/time/hrtimer.c:1887
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x108/0x3f0 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0x9f/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:unwind_next_frame+0x671/0x20a0 arch/x86/kernel/unwind_orc.c:581
Code: 84 f7 0f 85 a4 15 00 00 83 e0 07 38 c2 40 0f 9e c6 84 d2 0f 95 c0 40 84 c6 0f 85 8d 15 00 00 4c 0f bf 31 4d 01 fe 0f b6 41 05 <83> e0 07 3c 03 0f 84 bd 08 00 00 3c 04 0f 84 f6 07 00 00 3c 02 0f
RSP: 0018:ffffc9000477ec48 EFLAGS: 00000292
RAX: 0000000000000002 RBX: 0000000000000001 RCX: ffffffff91275258
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000001
RBP: ffffc9000477ed00 R08: ffffffff9127525c R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000012081 R12: ffffc9000477ed08
R13: ffffc9000477ecb8 R14: ffffc9000477f040 R15: ffffc9000477f018
 arch_stack_walk+0x94/0x100 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:47
 kasan_save_track+0x14/0x30 mm/kasan/common.c:68
 unpoison_slab_object mm/kasan/common.c:319 [inline]
 __kasan_slab_alloc+0x89/0x90 mm/kasan/common.c:345
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4147 [inline]
 slab_alloc_node mm/slub.c:4196 [inline]
 kmem_cache_alloc_node_noprof+0x1d5/0x3b0 mm/slub.c:4248
 __alloc_skb+0x2b2/0x380 net/core/skbuff.c:658
 alloc_skb include/linux/skbuff.h:1340 [inline]
 nlmsg_new include/net/netlink.h:1019 [inline]
 rtmsg_fib+0x13e/0x520 net/ipv4/fib_semantics.c:552
 fib_table_insert+0xbaf/0x1c40 net/ipv4/fib_trie.c:1380
 fib_magic+0x4d4/0x5c0 net/ipv4/fib_frontend.c:1133
 fib_add_ifaddr+0x3a1/0x580 net/ipv4/fib_frontend.c:1170
 fib_inetaddr_event+0x147/0x270 net/ipv4/fib_frontend.c:1469
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
 blocking_notifier_call_chain kernel/notifier.c:380 [inline]
 blocking_notifier_call_chain+0x69/0xa0 kernel/notifier.c:368
 __inet_insert_ifa+0x925/0xcd0 net/ipv4/devinet.c:567
 inet_rtm_newaddr+0xd87/0x1540 net/ipv4/devinet.c:1002
 rtnetlink_rcv_msg+0x95b/0xe90 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x16a/0x440 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53a/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 __sys_sendto+0x495/0x510 net/socket.c:2180
 __do_sys_sendto net/socket.c:2187 [inline]
 __se_sys_sendto net/socket.c:2183 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2183
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f87d9f907fc
Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
RSP: 002b:00007fff248eaf20 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f87dace4620 RCX: 00007f87d9f907fc
RDX: 0000000000000028 RSI: 00007f87dace4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fff248eaf74 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f87dace4670 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread starved for 10490 jiffies! g8293 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27704 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x116f/0x5de0 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6860
 schedule_timeout+0x123/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x1ea/0xb00 kernel/rcu/tree.c:2046
 rcu_gp_kthread+0x270/0x380 kernel/rcu/tree.c:2248
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
CPU: 1 UID: 101 PID: 5480 Comm: dhcpcd Not tainted 6.15.0-rc5-syzkaller-00022-g01f95500a162 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/29/2025
RIP: 0010:write_comp_data+0x8b/0x90 kernel/kcov.c:272
Code: 00 00 4a 8d 34 dd 28 00 00 00 48 39 f2 72 1b 48 83 c7 01 48 89 38 4c 89 44 30 e0 4c 89 4c 30 e8 4c 89 54 30 f0 4a 89 4c d8 20 <c3> cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc90002ea77b0 EFLAGS: 00000293
RAX: 0000000000000000 RBX: ffff8880b8441720 RCX: ffffffff81af1bb9
RDX: ffff88802577c880 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 0000000000000003 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffed10170882e5
R13: 0000000000000001 R14: dffffc0000000000 R15: ffff8880b853b040
FS:  00007fe629d36740(0000) GS:ffff888124adf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b10a151068 CR3: 0000000025463000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 csd_lock_wait kernel/smp.c:340 [inline]
 smp_call_function_many_cond+0x4c9/0x1290 kernel/smp.c:885
 on_each_cpu_cond_mask+0x40/0x90 kernel/smp.c:1052
 __flush_tlb_multi arch/x86/include/asm/paravirt.h:91 [inline]
 flush_tlb_multi arch/x86/mm/tlb.c:1275 [inline]
 flush_tlb_mm_range+0x322/0x1780 arch/x86/mm/tlb.c:1365
 tlb_flush arch/x86/include/asm/tlb.h:23 [inline]
 tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:480 [inline]
 tlb_flush_mmu_tlbonly include/asm-generic/tlb.h:470 [inline]
 tlb_flush_mmu mm/mmu_gather.c:403 [inline]
 tlb_finish_mmu+0x3c9/0x7b0 mm/mmu_gather.c:496
 vms_clear_ptes+0x55e/0x770 mm/vma.c:1191
 vms_complete_munmap_vmas+0x1ca/0x970 mm/vma.c:1233
 do_vmi_align_munmap+0x43b/0x7d0 mm/vma.c:1492
 __do_sys_brk+0x8d3/0xaa0 mm/mmap.c:176
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe629e04c7c
Code: 1a 64 c7 03 01 00 00 00 eb 11 64 44 89 23 31 f6 5b 31 ff 5d 41 5c e9 41 ff ff ff 5b 83 c8 ff 5d 41 5c c3 b8 0c 00 00 00 0f 05 <48> 8b 15 d5 61 0d 00 45 31 c0 48 89 02 48 39 c7 76 12 48 8b 05 73
RSP: 002b:00007fffc7ef0748 EFLAGS: 00000206 ORIG_RAX: 000000000000000c
RAX: ffffffffffffffda RBX: fffffffffffdf000 RCX: 00007fe629e04c7c
RDX: 0000558eaa832990 RSI: 0000558eaa6f2010 RDI: 0000558eaa853000
RBP: 0000000000041670 R08: 0000000000000000 R09: ba568e78e099c46f
R10: 00007fffc7ef06a8 R11: 0000000000000206 R12: 0000558eaa874000
R13: 0000558eaa863f20 R14: 00007fe629edbaa0 R15: 00007fffc7ef0978
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


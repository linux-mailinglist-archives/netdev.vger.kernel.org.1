Return-Path: <netdev+bounces-187376-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 25FD7AA6BC0
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 09:37:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A641C1BA1D0F
	for <lists+netdev@lfdr.de>; Fri,  2 May 2025 07:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 514A92676DF;
	Fri,  2 May 2025 07:37:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DF642673A9
	for <netdev@vger.kernel.org>; Fri,  2 May 2025 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746171444; cv=none; b=Tl2F52wMksNp5+H2+BbG0Vhoqud+RK4uxH3GRX2HlGWS7cupPxge+80Lr+jjVah5Rt+7z4GMAVyVDOd4ipYpxWSO5nHLcHRu9Hj3u5V58Dj3ulHDU8Z0OwcoQVAvPAQkrseiOt9pwYl5Na29UH5FiCjaA6pdhsIY5t8Q0PPmigk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746171444; c=relaxed/simple;
	bh=yw2kr8qoJgTuo0OlcCpqsXASmAmWDLCSNVYi22Rfxxg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RT0MH/BkoWVgUL+17xQn7D1deMbAPlcaC4/zO7xe9SEvN8++dF68GFS+8eL+UVZgPVI5ANkybO6s5SnZCqfVSoRS4HJ+KMSuwmZzkJSIdn+Du6pjimiv4OyyZOOFikjm9UnicQA9NoAkyNhkHUMx8GC6L1VNex5pVA5ap60dx+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d922570570so25558345ab.3
        for <netdev@vger.kernel.org>; Fri, 02 May 2025 00:37:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746171441; x=1746776241;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FGrdew00+8l59Fo/xofXWgYCISSbTLhRTgi361OmL7A=;
        b=ETXoA9Guj+/1yUjnzPwTmr3xkhQOHi0ZQy726tfJogDGjZqoltZQo4r819BUQD5TLY
         HE3wYtAWopgtKdKbi+D8JvyNNQ8zYafxbAaOmcNG+tb3wOq3OYohF32PtV+UGYEXeB+q
         LT9Mpogo5pb9hHwZorO3PDTPeeqvbN9Y8Vg1lO+aLGMKB1R9ekmBGCCpBgMX90vv6EtG
         fi8+g6yskkaeEkdaYoNpV0Xh6ztr2mSeyP0GShajp6pQpubk8Xr6OH7zrJJBTgKnSCnr
         1vhDePxYF1DDki2L/zjqFwaTWOk46Xd9PA9AHrEWdVGYEoopJmsI6okCNBFgF13nIicH
         su5w==
X-Forwarded-Encrypted: i=1; AJvYcCVa6dlzYCbBVDYe08RNcPvkoBJwD7EYUbmr+pF1m489+++YnHAUk9Um8GsOdtpanITw9xx4C8M=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1kUfoEdG9oAPVj5KRJcq5FsYgOrk1/bSjE9CnhqpYGnECw3HO
	BHsF4GhUffUZozdhbDWMSu1jgRVus+quNcTtdkBjRpJvSbzQc2Ric+eSPUbrs5OSejeVXZwyfuU
	zDEq/TeyhlzoWkz1Zs5fnGZLF12X8/1YyMJJ3hTxEq9TA/jj4FeyJN4k=
X-Google-Smtp-Source: AGHT+IG0GhLNoOAjn8WkDr5PHpgkC96ThCEXH/xYd6yz3+9o6IVPYNKMNMedyFtK5hplrNXK+++132BclH8OPHRwiNTKO0eJaKnH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1609:b0:3d9:36bd:8c5f with SMTP id
 e9e14a558f8ab-3d97c1acb86mr18088725ab.11.1746171441478; Fri, 02 May 2025
 00:37:21 -0700 (PDT)
Date: Fri, 02 May 2025 00:37:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68147631.050a0220.53db9.0006.GAE@google.com>
Subject: [syzbot] [net?] BUG: soft lockup in sctp_generate_timeout_event
From: syzbot <syzbot+7d36dbfae4115f887499@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b4432656b36e Linux 6.15-rc4
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=13fee39b980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a9a25b7a36123454
dashboard link: https://syzkaller.appspot.com/bug?extid=7d36dbfae4115f887499
compiler:       Debian clang version 20.1.2 (++20250402124445+58df0ef89dd6-1~exp1~20250402004600.97), Debian LLD 20.1.2

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c9ea4f1822ea/disk-b4432656.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c5effc66ca81/vmlinux-b4432656.xz
kernel image: https://storage.googleapis.com/syzbot-assets/49364ea611a8/bzImage-b4432656.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7d36dbfae4115f887499@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#1 stuck for 123s! [syz.0.827:8572]
Modules linked in:
irq event stamp: 19239949
hardirqs last  enabled at (19239948): [<ffffffff8b55e3c4>] irqentry_exit+0x74/0x90 kernel/entry/common.c:357
hardirqs last disabled at (19239949): [<ffffffff8b55cdbe>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1049
softirqs last  enabled at (2908914): [<ffffffff8185c3fa>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last  enabled at (2908914): [<ffffffff8185c3fa>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last  enabled at (2908914): [<ffffffff8185c3fa>] __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
softirqs last disabled at (2908917): [<ffffffff8185c3fa>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last disabled at (2908917): [<ffffffff8185c3fa>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last disabled at (2908917): [<ffffffff8185c3fa>] __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
CPU: 1 UID: 0 PID: 8572 Comm: syz.0.827 Not tainted 6.15.0-rc4-syzkaller-gb4432656b36e #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
RIP: 0010:rcu_read_lock include/linux/rcupdate.h:842 [inline]
RIP: 0010:ip6_pol_route+0x19e/0x1180 net/ipv6/route.c:2264
Code: c0 45 31 c9 41 57 e8 f1 d2 90 f7 48 83 c4 08 e8 78 a5 48 01 41 89 c6 31 ff 89 c6 e8 2c 8a b2 f7 45 85 f6 74 10 e8 12 ad 99 f7 <84> c0 74 0e e8 d9 85 b2 f7 eb 58 e8 d2 85 b2 f7 eb 51 e8 4b a5 48
RSP: 0018:ffffc90000a07ce0 EFLAGS: 00000202
RAX: 0000000000000001 RBX: 0000000000000002 RCX: 9f9af6a53f4fb200
RDX: ffff888025f61e00 RSI: ffffffff8bc1cdc0 RDI: ffffffff8bc1cd80
RBP: ffffc90000a07e00 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8a0d38b2 R12: ffffc90000a08380
R13: 0000000000000000 R14: 0000000000000001 R15: ffffffff8a0d38b2
FS:  00007f576e13d6c0(0000) GS:ffff8881261cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000309e2000 CR4: 00000000003526f0
DR0: 0000200000000300 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 pol_lookup_func include/net/ip6_fib.h:616 [inline]
 __fib6_rule_action net/ipv6/fib6_rules.c:237 [inline]
 fib6_rule_action+0x206/0x7d0 net/ipv6/fib6_rules.c:275
 fib_rules_lookup+0x767/0xe90 net/core/fib_rules.c:339
 fib6_rule_lookup+0x18e/0x6f0 net/ipv6/fib6_rules.c:112
 ip6_route_output_flags_noref net/ipv6/route.c:2674 [inline]
 ip6_route_output_flags+0x364/0x5d0 net/ipv6/route.c:2686
 ip6_dst_lookup_tail+0x299/0x1500 net/ipv6/ip6_output.c:1156
 ip6_dst_lookup_flow+0x47/0xe0 net/ipv6/ip6_output.c:1259
 sctp_v6_get_dst+0xffa/0x1bc0 net/sctp/ipv6.c:384
 sctp_transport_route+0x115/0x2f0 net/sctp/transport.c:457
 sctp_packet_config+0x478/0xd90 net/sctp/output.c:103
 sctp_packet_singleton+0x158/0x330 net/sctp/outqueue.c:777
 sctp_outq_flush_ctrl net/sctp/outqueue.c:914 [inline]
 sctp_outq_flush+0x4f0/0x3140 net/sctp/outqueue.c:1212
 sctp_cmd_interpreter net/sctp/sm_sideeffect.c:-1 [inline]
 sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
 sctp_do_sm+0x5332/0x5a20 net/sctp/sm_sideeffect.c:1169
 sctp_generate_timeout_event+0x22e/0x360 net/sctp/sm_sideeffect.c:295
 call_timer_fn+0x17b/0x5f0 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x61a/0x860 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2445
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:preempt_schedule_irq+0xb0/0x150 kernel/sched/core.c:7090
Code: 24 20 f6 44 24 21 02 74 0c 90 0f 0b 48 f7 03 08 00 00 00 74 64 bf 01 00 00 00 e8 eb c3 39 f6 e8 86 43 70 f6 fb bf 01 00 00 00 <e8> 4b ab ff ff 48 c7 44 24 40 00 00 00 00 9c 8f 44 24 40 8b 44 24
RSP: 0018:ffffc90003777800 EFLAGS: 00000286
RAX: 9f9af6a53f4fb200 RBX: 0000000000000000 RCX: 9f9af6a53f4fb200
RDX: 0000000000000000 RSI: ffffffff8d749f78 RDI: 0000000000000001
RBP: ffffc900037778b0 R08: ffffffff8f7ed377 R09: 1ffffffff1efda6e
R10: dffffc0000000000 R11: fffffbfff1efda6f R12: 0000000000000000
R13: 0000000000000000 R14: dffffc0000000000 R15: 1ffff920006eef00
 irqentry_exit+0x6f/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_is_held_type+0x137/0x190 kernel/locking/lockdep.c:5943
Code: 01 75 44 48 c7 04 24 00 00 00 00 9c 8f 04 24 f7 04 24 00 02 00 00 75 4c 41 f7 c4 00 02 00 00 74 01 fb 65 48 8b 05 89 64 1f 07 <48> 3b 44 24 08 75 43 89 d8 48 83 c4 10 5b 41 5c 41 5d 41 5e 41 5f
RSP: 0018:ffffc90003777978 EFLAGS: 00000206
RAX: 9f9af6a53f4fb200 RBX: 0000000000000000 RCX: 9f9af6a53f4fb200
RDX: 0000000000000000 RSI: ffffffff8d9350da RDI: ffffffff8bc1cde0
RBP: 00000000ffffffff R08: ffffc90003777c5f R09: 0000000000000000
R10: ffffc90003777c30 R11: fffff520006eef8c R12: 0000000000000246
R13: ffff888025f61e00 R14: ffffffff8df3b8c0 R15: 0000000000000000
 lock_is_held include/linux/lockdep.h:249 [inline]
 __might_resched+0xa6/0x610 kernel/sched/core.c:8780
 __might_fault+0x77/0x130 mm/memory.c:7149
 __copy_from_user include/linux/uaccess.h:106 [inline]
 check_xstate_in_sigframe arch/x86/kernel/fpu/signal.c:33 [inline]
 __fpu_restore_sig arch/x86/kernel/fpu/signal.c:344 [inline]
 fpu__restore_sig+0x1a4/0x10a0 arch/x86/kernel/fpu/signal.c:489
 restore_sigcontext arch/x86/kernel/signal_64.c:95 [inline]
 __ia32_sys_rt_sigreturn+0x661/0x7b0 arch/x86/kernel/signal_64.c:266
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf6/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f576d38e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f576e13d0e8 EFLAGS: 00000246
RAX: fffffffffffffffc RBX: 00007f576d5b5fa8 RCX: 00007f576d38e969
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f576d5b5fa8
RBP: 00007f576d5b5fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f576d5b5fac
R13: 0000000000000000 R14: 00007ffeaf203f10 R15: 00007ffeaf203ff8
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 2912 Comm: kworker/u8:8 Not tainted 6.15.0-rc4-syzkaller-gb4432656b36e #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:340 [inline]
RIP: 0010:smp_call_function_many_cond+0xe69/0x11c0 kernel/smp.c:885
Code: 00 45 8b 2f 44 89 ee 83 e6 01 31 ff e8 20 6d 0b 00 41 83 e5 01 49 bd 00 00 00 00 00 fc ff df 75 07 e8 cb 68 0b 00 eb 37 f3 90 <43> 0f b6 04 2c 84 c0 75 10 41 f7 07 01 00 00 00 74 1e e8 b0 68 0b
RSP: 0018:ffffc9000bc8f700 EFLAGS: 00000293
RAX: ffffffff81b45620 RBX: ffff8880b883ad40 RCX: ffff88802f0d9e00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc9000bc8f860 R08: ffffffff8f7ed377 R09: 1ffffffff1efda6e
R10: dffffc0000000000 R11: fffffbfff1efda6f R12: 1ffff11017127e99
R13: dffffc0000000000 R14: 0000000000000001 R15: ffff8880b893f4c8
FS:  0000000000000000(0000) GS:ffff8881260cc000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffffa814fb0 CR3: 000000000dd36000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000600
Call Trace:
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1052
 on_each_cpu include/linux/smp.h:71 [inline]
 text_poke_sync arch/x86/kernel/alternative.c:2455 [inline]
 text_poke_bp_batch+0x319/0x940 arch/x86/kernel/alternative.c:2665
 text_poke_flush arch/x86/kernel/alternative.c:2856 [inline]
 text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2863
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x128/0x250 kernel/jump_label.c:210
 static_key_enable+0x1a/0x20 kernel/jump_label.c:223
 toggle_allocation_gate+0xad/0x240 mm/kfence/core.c:850
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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


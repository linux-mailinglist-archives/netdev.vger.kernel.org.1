Return-Path: <netdev+bounces-245810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0C6FCD81FE
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 06:23:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3C48630169BF
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 05:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB61E2EDD70;
	Tue, 23 Dec 2025 05:23:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D32082D6E4B
	for <netdev@vger.kernel.org>; Tue, 23 Dec 2025 05:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766467400; cv=none; b=fmnSdEa1CZaw+w6DGAiRa7/hj1ZC2tLknFUzistxqQ/8WYmfv3wGh6kwMaA7/VOwoXfrOH/i2cQapHvpXanoLnFWzoeBSXb6e9ZTN2j4/E4r8arHIAUlW15GAr0FrXFv1ylQrQgIBZpJMfslEFGqb3C5Zoawke8Gp5Ce5zaVOqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766467400; c=relaxed/simple;
	bh=c+SjijWJGJT6j7AiZb/xOMbPPuqHy5oJJnVkEJFHPyg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=DSF9mNwQvISR8emqHIvRfiFdgySQ3lhTDICbV+QRlDbHRTyuDB1QwbXjvksJA6UVv2twAOJTQ+XPcIZXOQnI7XMg0+hnxgNP9uHgh27oSjpE1PWS7QG48dThHLubvGTEKLIMoQhsXjAgmD9sG2W3KPeZjNxFav6E20CFtrw6zvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-3f578b8136fso6682695fac.0
        for <netdev@vger.kernel.org>; Mon, 22 Dec 2025 21:23:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766467398; x=1767072198;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q1aOsLw3I58HnFNZEQBPz+V4uOgcrIt0w7/Sr1Mf/hA=;
        b=b3/fFR7qIQBjmHYVi/adhJCMD3vAUziGcmGRwP/WO+6H+mOrr/+zVcj78z9Csi9BZm
         IjqVGxE7F3ssbd1CQx1Yb/jLWfzgmXCULhynVk0AavEASx292iIqn4DhBG0DaYfdFKOZ
         T8c0CHLCVJA4Ycg7NKm8H0wNJoGJd90NlHHYjchDX2WJ058urlPw7VNtGC0uspMSxvA5
         w3fzQEZJ2Y1XKM6IlrAOWtlF9VBfXYrI0Up9KCMC+HrC7PvWosK6JZXRUd3UhMiytkKs
         F1PQC7pkE+RWgR2G7xCskt49BtsBqKn+3uRVbcTP9DNElvgt7CgsDmerctrcqA2NeN4r
         NBaQ==
X-Forwarded-Encrypted: i=1; AJvYcCU07PZCsFq4Zr+sMVjTlvH2TgjgSD/xOpQhW4z7AMCLJGsZ7F3tvefiKrnA3jPgkYB3+WvznEc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkRcpPQHYEqAvHg5OyuQNbazTyePfh/QyAmWNWzmAevl35HQg9
	FzdlzKuDeOrR/E1f9LTQJOXfJlOt8z+KRcsdOVeYg+cKh56kVYA3nS2+091z6YjgEIl66pH/bjt
	llp7WljUV9bHtSzaBh385TqxCJ7i2bIfg9iGSsy/8mtJhlAizDq6joVCfSNk=
X-Google-Smtp-Source: AGHT+IHZSi/bYLqdI0lyooxENsGlvhhAM7UdCtWt4gaQrmHcdEL+qtS2B7u180p0n2vHInN8JKwDe4jGnG5p1hRs/G5uKH6XEZmD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2305:b0:65c:fb01:71af with SMTP id
 006d021491bc7-65ea0345582mr1718985eaf.5.1766467397792; Mon, 22 Dec 2025
 21:23:17 -0800 (PST)
Date: Mon, 22 Dec 2025 21:23:17 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694a2745.050a0220.19928e.0016.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: rcu detected stall in watchdog (2)
From: syzbot <syzbot+085983798339fb1b6e51@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, lance.yang@linux.dev, 
	linux-kernel@vger.kernel.org, mhiramat@kernel.org, netdev@vger.kernel.org, 
	pmladek@suse.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7b8e9264f55a Merge tag 'net-6.19-rc2' of git://git.kernel...
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1207562a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=085983798339fb1b6e51
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=174cab1a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122e777c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8974d9d662d1/disk-7b8e9264.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/127f2bb7aa37/vmlinux-7b8e9264.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2dc3e335ca80/bzImage-7b8e9264.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+085983798339fb1b6e51@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	(detected by 0, t=10502 jiffies, g=18609, q=500 ncpus=2)
rcu: All QSes seen, last rcu_preempt kthread activity 10502 (4294978752-4294968250), jiffies_till_next_fqs=1, root ->qsmask 0x0
rcu: rcu_preempt kthread starved for 10502 jiffies! g18609 f0x2 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:27272 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:check_kcov_mode kernel/kcov.c:183 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:246 [inline]
RIP: 0010:__sanitizer_cov_trace_switch+0x97/0x130 kernel/kcov.c:351
Code: 54 53 48 8b 54 24 20 65 4c 8b 04 25 08 b0 7e 92 45 31 c9 eb 08 49 ff c1 4c 39 c8 74 77 4e 8b 54 ce 10 65 44 8b 1d c9 f7 bc 10 <41> 81 e3 00 01 ff 00 74 13 41 81 fb 00 01 00 00 75 d9 41 83 b8 6c
RSP: 0018:ffffc90000a082e0 EFLAGS: 00000016
RAX: 0000000000000020 RBX: 0000000000000004 RCX: 0000000000000005
RDX: ffffffff81c39275 RSI: ffffffff8df9a280 RDI: 0000000000000004
RBP: 0000006100d347d2 R08: ffff88801e2b0000 R09: 000000000000001b
R10: 000000000000001b R11: 0000000080010005 R12: dffffc0000000000
R13: ffff88801bed6010 R14: ffff88801bed64c0 R15: 00000000000667c4
FS:  0000000000000000(0000) GS:ffff888125f35000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055d3cfba3a38 CR3: 00000000727a4000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 rb_event_length+0x45/0x400 kernel/trace/ring_buffer.c:222
 rb_read_data_buffer+0x438/0x580 kernel/trace/ring_buffer.c:1858
 check_buffer+0x28a/0x750 kernel/trace/ring_buffer.c:4410
 __rb_reserve_next+0x592/0xdb0 kernel/trace/ring_buffer.c:4509
 rb_reserve_next_event kernel/trace/ring_buffer.c:4646 [inline]
 ring_buffer_lock_reserve+0xbb5/0x1010 kernel/trace/ring_buffer.c:4705
 __trace_buffer_lock_reserve kernel/trace/trace.c:1079 [inline]
 trace_event_buffer_lock_reserve+0x1d0/0x6f0 kernel/trace/trace.c:2808
 trace_event_buffer_reserve+0x248/0x340 kernel/trace/trace_events.c:672
 do_trace_event_raw_event_bpf_trace_printk kernel/trace/bpf_trace.h:11 [inline]
 trace_event_raw_event_bpf_trace_printk+0x100/0x260 kernel/trace/bpf_trace.h:11
 __do_trace_bpf_trace_printk kernel/trace/bpf_trace.h:11 [inline]
 trace_bpf_trace_printk+0x153/0x1b0 kernel/trace/bpf_trace.h:11
 ____bpf_trace_printk kernel/trace/bpf_trace.c:379 [inline]
 bpf_trace_printk+0x11e/0x190 kernel/trace/bpf_trace.c:362
 bpf_prog_b1367f0be6c54012+0x39/0x3f
 bpf_dispatcher_nop_func include/linux/bpf.h:1378 [inline]
 __bpf_prog_run include/linux/filter.h:723 [inline]
 bpf_prog_run include/linux/filter.h:730 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2075 [inline]
 bpf_trace_run1+0x27f/0x4c0 kernel/trace/bpf_trace.c:2115
 __bpf_trace_rcu_utilization+0xa1/0xf0 include/trace/events/rcu.h:27
 __traceiter_rcu_utilization+0x7a/0xb0 include/trace/events/rcu.h:27
 __do_trace_rcu_utilization include/trace/events/rcu.h:27 [inline]
 trace_rcu_utilization+0x191/0x1c0 include/trace/events/rcu.h:27
 rcu_sched_clock_irq+0xd3/0x1280 kernel/rcu/tree.c:2693
 update_process_times+0x23c/0x2f0 kernel/time/timer.c:2474
 tick_sched_handle kernel/time/tick-sched.c:298 [inline]
 tick_nohz_handler+0x3e9/0x710 kernel/time/tick-sched.c:319
 __run_hrtimer kernel/time/hrtimer.c:1777 [inline]
 __hrtimer_run_queues+0x4d0/0xc30 kernel/time/hrtimer.c:1841
 hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1903
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1045 [inline]
 __sysvec_apic_timer_interrupt+0x102/0x3e0 arch/x86/kernel/apic/apic.c:1062
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:console_trylock_spinning kernel/printk/printk.c:2037 [inline]
RIP: 0010:vprintk_emit+0x4d0/0x5f0 kernel/printk/printk.c:2425
Code: 0f 84 34 ff ff ff e8 cf 62 20 00 fb eb 44 e8 c7 62 20 00 e8 82 72 ba 09 4d 85 f6 74 94 e8 b8 62 20 00 fb 48 c7 c7 e0 58 f3 8d <31> f6 ba 01 00 00 00 31 c9 41 b8 01 00 00 00 45 31 c9 53 e8 28 26
RSP: 0018:ffffc90000a77a80 EFLAGS: 00000293
RAX: ffffffff81a14f98 RBX: ffffffff81a14df1 RCX: ffff88801e2b0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff8df358e0
RBP: ffffc90000a77b90 R08: ffffffff8f822077 R09: 1ffffffff1f0440e
R10: dffffc0000000000 R11: fffffbfff1f0440f R12: 0000000000000000
R13: 0000000000000040 R14: 0000000000000200 R15: 1ffff9200014ef54
 _printk+0xcf/0x120 kernel/printk/printk.c:2451
 check_hung_task kernel/hung_task.c:255 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:331 [inline]
 watchdog+0xb35/0xfe0 kernel/hung_task.c:515
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
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


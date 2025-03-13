Return-Path: <netdev+bounces-174486-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22417A5EF8E
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 10:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F2983AC58C
	for <lists+netdev@lfdr.de>; Thu, 13 Mar 2025 09:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C59F263C8A;
	Thu, 13 Mar 2025 09:29:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8C8C261398
	for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 09:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741858170; cv=none; b=aoIBETj5hgerRCTdGMJ42FdVODxeDPpf9gRCZHfN/GsBKixo6dT7gqBdPCCyB6035NNp+zLTbap8wX1algpCyCEMxtcO8LDzb2GjZtod6o9qVtsJ1SwvISXCIApTHJ6xiXH9E4f9rTPko8Uc/9z0L/y8NRbvnTpvHA13Q4MaEOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741858170; c=relaxed/simple;
	bh=X07Dr5YTrE+ik76yEp3e+sPk1vabBcDfiG0+uoAqrPk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=TM/c2/+PpuPaGzZzsKkPkrXmlwp4hLxR1MXtabIhd44qAkajmVgSd1TjhNifiXqEGDihd5Kzs3b7RrKdtsX41lKfIoboWt2AZe/NomkB5N58kpB0kf7nyOOKWfltgabhGQeFzhduqsCRDRVGbDVfRsxLmliwoLBm+qmxnCiibzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d4423d0c49so6929405ab.0
        for <netdev@vger.kernel.org>; Thu, 13 Mar 2025 02:29:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741858167; x=1742462967;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=viy/4e5/tkRmqIl0/bd+PpMHIOtd9aijnoLlS018ryk=;
        b=u+4KowWKCu0eCGlECj2R+QvUUbKwePvhbbvjqgZIGVegU6UHT8jWbPyomyXgxcV5l0
         cIlDyCs0U0NRztYeZBE9R+TP7BMPejKBnGQftkV/DbgufCPIVq1cwPVIt3BUn89Ngk3q
         bzCUNQ/EtRiW6tL+nklcfE8wDSOsVRwaMtvKXWBj96u3g2Sg2lKjbTMNNQu0omOGJ9ww
         ZeLw1DJDwQQirCxUx2yFgFowmdasZmc+gTaOV2SAZ7BsJsORJnsVtOMUdwSo6DsC+R3I
         Yv6jI+kI4sCdx2f+zU3eGIFKVDMlsMVSV/bIm2WTWWUCcnQET+PKn/48vriwM3sLvG/u
         8rSA==
X-Forwarded-Encrypted: i=1; AJvYcCVO8e2oi8Hqma8aEyIZUqeWzJyWOoFEItes0C51B5xEsRd1NwL563oP/dFApSAHh7MHs8iS9Jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwifoLFFiCXJrLDVQUsg6Vv7yUYe4Uh0y/uUoY2GNdDR3ErpoXK
	4LDXMvigNSmADS0Y9sJ5r3A5sHg6JG++Q/HPy+GrJY1n3W+GHQeZ8CZbdoNN5WhxnBmqrnzw89F
	6HiYVfo3OyOWsb93ltD85vyq9wKnpwvQlSkOSfGgjuww3YwuG8duCK80=
X-Google-Smtp-Source: AGHT+IGhihn7HEUTu3yXf7l9h8HcZIThlJeq0PnkKrkTx20SYIlbqZszWbGg81hurR3DMd11lBJWi7F+ZLTaaU35M5kyXwHg/PYV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8a:0:b0:3d3:e2a1:1f23 with SMTP id
 e9e14a558f8ab-3d441a46fa4mr241548925ab.20.1741858166911; Thu, 13 Mar 2025
 02:29:26 -0700 (PDT)
Date: Thu, 13 Mar 2025 02:29:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d2a576.050a0220.14e108.0030.GAE@google.com>
Subject: [syzbot] [kernel?] INFO: rcu detected stall in kthread_worker_fn (2)
From: syzbot <syzbot+2ea3f3959d6a151d0865@syzkaller.appspotmail.com>
To: bp@alien8.de, dave.hansen@linux.intel.com, davem@davemloft.net, 
	hpa@zytor.com, jhs@mojatatu.com, jiri@resnulli.us, 
	linux-kernel@vger.kernel.org, mingo@redhat.com, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de, vinicius.gomes@intel.com, 
	x86@kernel.org, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b7c90e3e717a Merge tag 'x86-urgent-2025-03-08' of git://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=110bf3a8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=523d3ff8e053340a
dashboard link: https://syzkaller.appspot.com/bug?extid=2ea3f3959d6a151d0865
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d81fa0580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f57e200ffcd6/disk-b7c90e3e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c6ab88f8b93e/vmlinux-b7c90e3e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/02dd888a913e/bzImage-b7c90e3e.xz

The issue was bisected to:

commit 5a781ccbd19e4664babcbe4b4ead7aa2b9283d22
Author: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Date:   Sat Sep 29 00:59:43 2018 +0000

    tc: Add support for configuring the taprio scheduler

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17000654580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10800654580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2ea3f3959d6a151d0865@syzkaller.appspotmail.com
Fixes: 5a781ccbd19e ("tc: Add support for configuring the taprio scheduler")

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	1-...!: (1 ticks this GP) idle=eaac/1/0x4000000000000000 softirq=14535/14535 fqs=0
rcu: 	(detected by 0, t=10506 jiffies, g=9453, q=274 ncpus=2)
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 20 Comm: rcu_exp_gp_kthr Not tainted 6.14.0-rc5-syzkaller-00234-gb7c90e3e717a #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:kasan_mem_to_shadow include/linux/kasan.h:64 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x37/0x290 mm/kasan/generic.c:189
Code: 01 48 85 f6 0f 84 a0 01 00 00 4c 8d 04 37 49 39 f8 0f 82 56 02 00 00 48 89 fd 48 c1 ed 2f 81 fd fe ff 01 00 0f 86 43 02 00 00 <48> 89 fb 48 c1 eb 03 49 ba 00 00 00 00 00 fc ff df 4e 8d 1c 13 49
RSP: 0018:ffffc90000a28ad0 EFLAGS: 00000002
RAX: 0000000000000001 RBX: 0000000000000001 RCX: ffffffff819cd274
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff903bcd70
RBP: 000000000001ffff R08: ffffffff903bcd78 R09: 0000000000000000
R10: dffffc0000000000 R11: ffffffff89fcfe20 R12: 1ffff92000145168
R13: dffffc0000000000 R14: 0000000000000000 R15: ffff88801d6ce4d8
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fa29cf13f98 CR3: 0000000034486000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 cpumask_test_cpu include/linux/cpumask.h:570 [inline]
 cpu_online include/linux/cpumask.h:1116 [inline]
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0xd4/0x550 kernel/locking/lockdep.c:5822
 __raw_spin_lock include/linux/spinlock_api_smp.h:133 [inline]
 _raw_spin_lock+0x2e/0x40 kernel/locking/spinlock.c:154
 spin_lock include/linux/spinlock.h:351 [inline]
 advance_sched+0xab/0xca0 net/sched/sch_taprio.c:924
 __run_hrtimer kernel/time/hrtimer.c:1801 [inline]
 __hrtimer_run_queues+0x59b/0xd30 kernel/time/hrtimer.c:1865
 hrtimer_interrupt+0x403/0xa40 kernel/time/hrtimer.c:1927
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:finish_task_switch+0x1ea/0x870 kernel/sched/core.c:5252
Code: c9 50 e8 69 2d 0c 00 48 83 c4 08 4c 89 f7 e8 fd 39 00 00 0f 1f 44 00 00 4c 89 f7 e8 e0 0f 73 0a e8 7b 07 39 00 fb 48 8b 5d c0 <48> 8d bb 08 16 00 00 48 89 f8 48 c1 e8 03 49 be 00 00 00 00 00 fc
RSP: 0018:ffffc90000197ae8 EFLAGS: 00000282
RAX: 834d0290e8134100 RBX: ffff88801d6cda00 RCX: ffffffff9a61b903
RDX: dffffc0000000000 RSI: ffffffff8c2ab2a0 RDI: ffffffff8c802ae0
RBP: ffffc90000197b30 R08: ffffffff903bcd77 R09: 1ffffffff20779ae
R10: dffffc0000000000 R11: fffffbfff20779af R12: 1ffff110170e7ebe
R13: dffffc0000000000 R14: ffff8880b873e7c0 R15: ffff8880b873f5f0
 context_switch kernel/sched/core.c:5381 [inline]
 __schedule+0x18c4/0x4c40 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 kthread_worker_fn+0x491/0xb70 kernel/kthread.c:1017
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10505 jiffies! g9453 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=1 timer-softirq=2864
rcu: rcu_preempt kthread starved for 10506 jiffies! g9453 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:26104 pid:18    tgid:18    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5378 [inline]
 __schedule+0x18bc/0x4c40 kernel/sched/core.c:6765
 __schedule_loop kernel/sched/core.c:6842 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6857
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2024
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2226
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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


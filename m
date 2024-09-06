Return-Path: <netdev+bounces-125999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 04A1E96F865
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 17:36:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BA1872867F3
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 15:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B421D2F7A;
	Fri,  6 Sep 2024 15:36:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95303381C2
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 15:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725636986; cv=none; b=cr7kzkLwEIRXbLQd6h7wMUI2dB1m5Vdov4a8XRWVUcRdkf4tFfyRgSgySd9H9pOmmjau2IoWJ09ys/STmk6jYLJ8kvIadZcYd3pnxV9qd6DHrGYN47i8dLmjpAj5cuLn9VbE0EqWAF0cwFq04/ZHJq3Lc57kWmZG/noKLtqwAmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725636986; c=relaxed/simple;
	bh=OPS4iqFe5GeDdMC+ARtPuhitFOoVsPVpAtChQq2pA68=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Httb9nsP7U0tl4tfC0W+ISaULFpxnBLZuQVWLfFl4YLU9B+145nehPGQldtpL+YIyPAXemz5hZ8noWrGGly4jfoQol1b/XWOMYVUTNTnIiPycFGvKLI8lvtdSwWLta0MMS6xhLigQ9a9sosrojBBudJLtc1Eq1CoKdv0NQ69hEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-82a72792dacso500166639f.1
        for <netdev@vger.kernel.org>; Fri, 06 Sep 2024 08:36:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725636984; x=1726241784;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Qhsxrzk59M5RAnR+rkQ1MqCY64GC8DWn1ca0TgksBAE=;
        b=r/mqfKM95UDFumq3f46b6nqp6SkKAVu3pwFle8cok4qWQx5K5/O2I/sPdsf8BAfgEm
         3MzLaOHtF2VrOfeumKvswOadrDLY8e4vYgGIeCEzxhjxJPhFwpNb0HGHTD/+lNeFi7hh
         b4CX49HyqUI+P2pyE7DpqbDw1Y0CLpF0dvYuoAcWkRA5GNRh/LpuZe6xs/luX06RIPTZ
         qKhRXdM+GDD3qAzwTaAaQ+xivf3JLoJBKYnO26dELCOCrn9+Ny9n6c6OrnpJIGQWAhmh
         TFLvXuNUDghpy4h/xmUdVixg9QBaC6CYVMveuVm3U7SrK9fkvfZhE05dclEehmBI2mTa
         H5jQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAuQ8UsLCf3RL96CWTrBlzrKkpJ9DreYq7ybHT9Xg6Ja6fLmZ0in4t3vguv1kYOrCnoDgTJuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXDQHoTpD14bcDWoJMmRFzuw82kaGb2+tdkXP3XM9ybHvRd76M
	g720gWH5agQrFLuO8WBjnQdpxuNdfJxgRkQn360Ts8WT35uNWuex/vEZuJfTTRgnSi/ec1OP1V4
	u47REM1+rVqIF3/XATsrTuB07xl7VSYlbsoNIMn75HrS1wHDM5Nlxhuk=
X-Google-Smtp-Source: AGHT+IFsa7dSgy+gYYFbGqogO7QYYXiSIyCZHXGU3yVLz8vt/+QZ5/hVp/jHhj0LC1z4mlFw9vdh2JlULasCXWlRRNnW5D2F+xx1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2710:b0:4ce:928f:adb1 with SMTP id
 8926c6da1cb9f-4d084eafe28mr250282173.2.1725636983718; Fri, 06 Sep 2024
 08:36:23 -0700 (PDT)
Date: Fri, 06 Sep 2024 08:36:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000006d27bb0621752b84@google.com>
Subject: [syzbot] [kernel?] possible deadlock in __run_timer_base
From: syzbot <syzbot+b3f9c9d700eadf2be3a9@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, luto@kernel.org, netdev@vger.kernel.org, 
	peterz@infradead.org, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b408473ea01b bpf: Fix a crash when btf_parse_base() return..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=10840739980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=eb19570bf3f0c14f
dashboard link: https://syzkaller.appspot.com/bug?extid=b3f9c9d700eadf2be3a9
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/64d6ccd089c0/disk-b408473e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d1d0d9431630/vmlinux-b408473e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fb7ddb3b7b95/bzImage-b408473e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b3f9c9d700eadf2be3a9@syzkaller.appspotmail.com

------------[ cut here ]------------
======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc4-syzkaller-gb408473ea01b #0 Not tainted
------------------------------------------------------
syz.2.317/6997 is trying to acquire lock:
ffffffff8e813cb8 ((console_sem).lock){-.-.}-{2:2}, at: down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139

but task is already holding lock:
ffff8880b892a718 (&base->lock){-.-.}-{2:2}, at: expire_timers kernel/time/timer.c:1839 [inline]
ffff8880b892a718 (&base->lock){-.-.}-{2:2}, at: __run_timers kernel/time/timer.c:2417 [inline]
ffff8880b892a718 (&base->lock){-.-.}-{2:2}, at: __run_timer_base+0x69d/0x8e0 kernel/time/timer.c:2428

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&base->lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       lock_timer_base+0x112/0x240 kernel/time/timer.c:1051
       __mod_timer+0x1ca/0xeb0 kernel/time/timer.c:1132
       queue_delayed_work_on+0x1ca/0x390 kernel/workqueue.c:2554
       psi_task_change+0xfd/0x280 kernel/sched/psi.c:913
       psi_enqueue kernel/sched/stats.h:143 [inline]
       enqueue_task+0x2aa/0x300 kernel/sched/core.c:1975
       activate_task kernel/sched/core.c:2009 [inline]
       wake_up_new_task+0x563/0xc30 kernel/sched/core.c:4689
       kernel_clone+0x4ee/0x8f0 kernel/fork.c:2831
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2878
       rest_init+0x23/0x300 init/main.c:712
       start_kernel+0x47a/0x500 init/main.c:1103
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #2 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560
       raw_spin_rq_lock kernel/sched/sched.h:1415 [inline]
       rq_lock kernel/sched/sched.h:1714 [inline]
       task_fork_fair+0x61/0x1e0 kernel/sched/fair.c:12710
       sched_cgroup_fork+0x37c/0x410 kernel/sched/core.c:4633
       copy_process+0x224f/0x3e10 kernel/fork.c:2502
       kernel_clone+0x226/0x8f0 kernel/fork.c:2800
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2878
       rest_init+0x23/0x300 init/main.c:712
       start_kernel+0x47a/0x500 init/main.c:1103
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
       try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4051
       up+0x72/0x90 kernel/locking/semaphore.c:191
       __up_console_sem kernel/printk/printk.c:340 [inline]
       __console_unlock kernel/printk/printk.c:2801 [inline]
       console_unlock+0x22f/0x4d0 kernel/printk/printk.c:3120
       vprintk_emit+0x5dc/0x7c0 kernel/printk/printk.c:2348
       dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4912
       dev_printk_emit+0xdd/0x120 drivers/base/core.c:4923
       _dev_warn+0x122/0x170 drivers/base/core.c:4979
       firmware_fallback_sysfs+0x4cf/0x9e0 drivers/base/firmware_loader/fallback.c:233
       _request_firmware+0xcf5/0x12b0 drivers/base/firmware_loader/main.c:914
       request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1165
       process_one_work kernel/workqueue.c:3231 [inline]
       process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
       worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((console_sem).lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
       __down_trylock_console_sem+0x109/0x250 kernel/printk/printk.c:323
       console_trylock kernel/printk/printk.c:2754 [inline]
       console_trylock_spinning kernel/printk/printk.c:1958 [inline]
       vprintk_emit+0x2aa/0x7c0 kernel/printk/printk.c:2347
       _printk+0xd5/0x120 kernel/printk/printk.c:2373
       __report_bug lib/bug.c:195 [inline]
       report_bug+0x346/0x500 lib/bug.c:219
       handle_bug+0x3e/0x70 arch/x86/kernel/traps.c:239
       exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:260
       asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
       expire_timers kernel/time/timer.c:1830 [inline]
       __run_timers kernel/time/timer.c:2417 [inline]
       __run_timer_base+0x6f4/0x8e0 kernel/time/timer.c:2428
       run_timer_base kernel/time/timer.c:2437 [inline]
       run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
       handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
       __do_softirq kernel/softirq.c:588 [inline]
       invoke_softirq kernel/softirq.c:428 [inline]
       __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
       irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
       instr_sysvec_irq_work arch/x86/kernel/irq_work.c:17 [inline]
       sysvec_irq_work+0xa3/0xc0 arch/x86/kernel/irq_work.c:17
       asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:738
       preempt_schedule_irq+0xf6/0x1c0 kernel/sched/core.c:6851
       irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
       asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
       check_kcov_mode kernel/kcov.c:182 [inline]
       write_comp_data kernel/kcov.c:245 [inline]
       __sanitizer_cov_trace_const_cmp4+0x2f/0x90 kernel/kcov.c:313
       number+0x134/0xf90 lib/vsprintf.c:473
       vsnprintf+0x1542/0x1da0 lib/vsprintf.c:2890
       vscnprintf+0x42/0x90 lib/vsprintf.c:2930
       bpf_verifier_vlog+0x41/0x860 kernel/bpf/log.c:66
       verbose+0x110/0x190 kernel/bpf/verifier.c:361
       print_bpf_insn+0xd6a/0x2400 kernel/bpf/disasm.c:320
       backtrack_insn kernel/bpf/verifier.c:3615 [inline]
       __mark_chain_precision+0x1a9b/0x7520 kernel/bpf/verifier.c:4272
       mark_chain_precision kernel/bpf/verifier.c:4375 [inline]
       check_cond_jmp_op+0x26c6/0x3c50 kernel/bpf/verifier.c:15212
       do_check+0x9a63/0x104f0 kernel/bpf/verifier.c:18110
       do_check_common+0x14bd/0x1dd0 kernel/bpf/verifier.c:20916
       do_check_main kernel/bpf/verifier.c:21007 [inline]
       bpf_check+0x144e1/0x19630 kernel/bpf/verifier.c:21681
       bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2908
       __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5710
       __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
       __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
       __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5815
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  (console_sem).lock --> &rq->__lock --> &base->lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&base->lock);
                               lock(&rq->__lock);
                               lock(&base->lock);
  lock((console_sem).lock);

 *** DEADLOCK ***

1 lock held by syz.2.317/6997:
 #0: ffff8880b892a718 (&base->lock){-.-.}-{2:2}, at: expire_timers kernel/time/timer.c:1839 [inline]
 #0: ffff8880b892a718 (&base->lock){-.-.}-{2:2}, at: __run_timers kernel/time/timer.c:2417 [inline]
 #0: ffff8880b892a718 (&base->lock){-.-.}-{2:2}, at: __run_timer_base+0x69d/0x8e0 kernel/time/timer.c:2428

stack backtrace:
CPU: 1 UID: 0 PID: 6997 Comm: syz.2.317 Not tainted 6.11.0-rc4-syzkaller-gb408473ea01b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
 __down_trylock_console_sem+0x109/0x250 kernel/printk/printk.c:323
 console_trylock kernel/printk/printk.c:2754 [inline]
 console_trylock_spinning kernel/printk/printk.c:1958 [inline]
 vprintk_emit+0x2aa/0x7c0 kernel/printk/printk.c:2347
 _printk+0xd5/0x120 kernel/printk/printk.c:2373
 __report_bug lib/bug.c:195 [inline]
 report_bug+0x346/0x500 lib/bug.c:219
 handle_bug+0x3e/0x70 arch/x86/kernel/traps.c:239
 exc_invalid_op+0x1a/0x50 arch/x86/kernel/traps.c:260
 asm_exc_invalid_op+0x1a/0x20 arch/x86/include/asm/idtentry.h:621
RIP: 0010:expire_timers kernel/time/timer.c:1830 [inline]
RIP: 0010:__run_timers kernel/time/timer.c:2417 [inline]
RIP: 0010:__run_timer_base+0x6f4/0x8e0 kernel/time/timer.c:2428
Code: 24 38 42 80 3c 30 00 74 08 4c 89 ef e8 85 90 7a 00 4d 8b 7d 00 4d 85 ff 74 33 e8 87 46 13 00 e9 dd fe ff ff e8 7d 46 13 00 90 <0f> 0b 90 eb ae 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 25 ff ff ff
RSP: 0018:ffffc90000a18cc0 EFLAGS: 00010046
RAX: ffffffff818044c3 RBX: ffff8880331e7c28 RCX: ffff888061e71e00
RDX: 0000000000000100 RSI: ffffffff8c608aa0 RDI: ffffffff8c608a60
RBP: ffffc90000a18e10 R08: ffffffff818080f4 R09: 1ffffffff2030c3d
R10: dffffc0000000000 R11: fffffbfff2030c3e R12: 0000000000000000
R13: ffffc90000a18d60 R14: dffffc0000000000 R15: ffff8880331e7c10
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_irq_work arch/x86/kernel/irq_work.c:17 [inline]
 sysvec_irq_work+0xa3/0xc0 arch/x86/kernel/irq_work.c:17
 </IRQ>
 <TASK>
 asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:738
RIP: 0010:preempt_schedule_irq+0xf6/0x1c0 kernel/sched/core.c:6851
Code: 89 f5 49 c1 ed 03 eb 0d 48 f7 03 08 00 00 00 0f 84 8b 00 00 00 bf 01 00 00 00 e8 a5 61 a1 f5 e8 30 50 d9 f5 fb bf 01 00 00 00 <e8> 55 ad ff ff 43 80 7c 3d 00 00 74 08 4c 89 f7 e8 85 36 39 f6 48
RSP: 0018:ffffc900033c6340 EFLAGS: 00000286
RAX: 4be1ae6c97110f00 RBX: 1ffff92000678c70 RCX: ffffffff9a337903
RDX: dffffc0000000000 RSI: ffffffff8c0ad560 RDI: 0000000000000001
RBP: ffffc900033c63f0 R08: ffffffff901861ef R09: 1ffffffff2030c3d
R10: dffffc0000000000 R11: fffffbfff2030c3e R12: 1ffff92000678c68
R13: 1ffff92000678c6c R14: ffffc900033c6360 R15: dffffc0000000000
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:check_kcov_mode kernel/kcov.c:184 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:245 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x2f/0x90 kernel/kcov.c:313
Code: 8b 04 24 65 48 8b 14 25 00 d7 03 00 65 8b 05 70 47 70 7e 25 00 01 ff 00 74 10 3d 00 01 00 00 75 5b 83 ba 1c 16 00 00 00 74 52 <8b> 82 f8 15 00 00 83 f8 03 75 47 48 8b 8a 00 16 00 00 44 8b 8a fc
RSP: 0018:ffffc900033c64b8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff10300000020f RCX: ffff888061e71e00
RDX: ffff888061e71e00 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900033c65d0 R08: ffffffff8bb28764 R09: 0000000000000000
R10: ffffc900033c6540 R11: fffff52000678cab R12: 00000000ffff1030
R13: 0000000000000018 R14: ffff10300000020f R15: ffff8880686f869d
 number+0x134/0xf90 lib/vsprintf.c:473
 vsnprintf+0x1542/0x1da0 lib/vsprintf.c:2890
 vscnprintf+0x42/0x90 lib/vsprintf.c:2930
 bpf_verifier_vlog+0x41/0x860 kernel/bpf/log.c:66
 verbose+0x110/0x190 kernel/bpf/verifier.c:361
 print_bpf_insn+0xd6a/0x2400 kernel/bpf/disasm.c:320
 backtrack_insn kernel/bpf/verifier.c:3615 [inline]
 __mark_chain_precision+0x1a9b/0x7520 kernel/bpf/verifier.c:4272
 mark_chain_precision kernel/bpf/verifier.c:4375 [inline]
 check_cond_jmp_op+0x26c6/0x3c50 kernel/bpf/verifier.c:15212
 do_check+0x9a63/0x104f0 kernel/bpf/verifier.c:18110
 do_check_common+0x14bd/0x1dd0 kernel/bpf/verifier.c:20916
 do_check_main kernel/bpf/verifier.c:21007 [inline]
 bpf_check+0x144e1/0x19630 kernel/bpf/verifier.c:21681
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2908
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5710
 __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5815
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8d12379eb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8d130e8038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f8d12515f80 RCX: 00007f8d12379eb9
RDX: 0000000000000023 RSI: 0000000020000300 RDI: 0000000000000005
RBP: 00007f8d123e793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8d12515f80 R15: 00007fff44c41278
 </TASK>
WARNING: CPU: 1 PID: 6997 at kernel/time/timer.c:1830 expire_timers kernel/time/timer.c:1830 [inline]
WARNING: CPU: 1 PID: 6997 at kernel/time/timer.c:1830 __run_timers kernel/time/timer.c:2417 [inline]
WARNING: CPU: 1 PID: 6997 at kernel/time/timer.c:1830 __run_timer_base+0x6f4/0x8e0 kernel/time/timer.c:2428
Modules linked in:
CPU: 1 UID: 0 PID: 6997 Comm: syz.2.317 Not tainted 6.11.0-rc4-syzkaller-gb408473ea01b #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:expire_timers kernel/time/timer.c:1830 [inline]
RIP: 0010:__run_timers kernel/time/timer.c:2417 [inline]
RIP: 0010:__run_timer_base+0x6f4/0x8e0 kernel/time/timer.c:2428
Code: 24 38 42 80 3c 30 00 74 08 4c 89 ef e8 85 90 7a 00 4d 8b 7d 00 4d 85 ff 74 33 e8 87 46 13 00 e9 dd fe ff ff e8 7d 46 13 00 90 <0f> 0b 90 eb ae 44 89 f1 80 e1 07 80 c1 03 38 c1 0f 8c 25 ff ff ff
RSP: 0018:ffffc90000a18cc0 EFLAGS: 00010046
RAX: ffffffff818044c3 RBX: ffff8880331e7c28 RCX: ffff888061e71e00
RDX: 0000000000000100 RSI: ffffffff8c608aa0 RDI: ffffffff8c608a60
RBP: ffffc90000a18e10 R08: ffffffff818080f4 R09: 1ffffffff2030c3d
R10: dffffc0000000000 R11: fffffbfff2030c3e R12: 0000000000000000
R13: ffffc90000a18d60 R14: dffffc0000000000 R15: ffff8880331e7c10
FS:  00007f8d130e86c0(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000140 CR3: 00000000667c4000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000600
Call Trace:
 <IRQ>
 run_timer_base kernel/time/timer.c:2437 [inline]
 run_timer_softirq+0xb7/0x170 kernel/time/timer.c:2447
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_irq_work arch/x86/kernel/irq_work.c:17 [inline]
 sysvec_irq_work+0xa3/0xc0 arch/x86/kernel/irq_work.c:17
 </IRQ>
 <TASK>
 asm_sysvec_irq_work+0x1a/0x20 arch/x86/include/asm/idtentry.h:738
RIP: 0010:preempt_schedule_irq+0xf6/0x1c0 kernel/sched/core.c:6851
Code: 89 f5 49 c1 ed 03 eb 0d 48 f7 03 08 00 00 00 0f 84 8b 00 00 00 bf 01 00 00 00 e8 a5 61 a1 f5 e8 30 50 d9 f5 fb bf 01 00 00 00 <e8> 55 ad ff ff 43 80 7c 3d 00 00 74 08 4c 89 f7 e8 85 36 39 f6 48
RSP: 0018:ffffc900033c6340 EFLAGS: 00000286
RAX: 4be1ae6c97110f00 RBX: 1ffff92000678c70 RCX: ffffffff9a337903
RDX: dffffc0000000000 RSI: ffffffff8c0ad560 RDI: 0000000000000001
RBP: ffffc900033c63f0 R08: ffffffff901861ef R09: 1ffffffff2030c3d
R10: dffffc0000000000 R11: fffffbfff2030c3e R12: 1ffff92000678c68
R13: 1ffff92000678c6c R14: ffffc900033c6360 R15: dffffc0000000000
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:check_kcov_mode kernel/kcov.c:184 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:245 [inline]
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x2f/0x90 kernel/kcov.c:313
Code: 8b 04 24 65 48 8b 14 25 00 d7 03 00 65 8b 05 70 47 70 7e 25 00 01 ff 00 74 10 3d 00 01 00 00 75 5b 83 ba 1c 16 00 00 00 74 52 <8b> 82 f8 15 00 00 83 f8 03 75 47 48 8b 8a 00 16 00 00 44 8b 8a fc
RSP: 0018:ffffc900033c64b8 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffff10300000020f RCX: ffff888061e71e00
RDX: ffff888061e71e00 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900033c65d0 R08: ffffffff8bb28764 R09: 0000000000000000
R10: ffffc900033c6540 R11: fffff52000678cab R12: 00000000ffff1030
R13: 0000000000000018 R14: ffff10300000020f R15: ffff8880686f869d
 number+0x134/0xf90 lib/vsprintf.c:473
 vsnprintf+0x1542/0x1da0 lib/vsprintf.c:2890
 vscnprintf+0x42/0x90 lib/vsprintf.c:2930
 bpf_verifier_vlog+0x41/0x860 kernel/bpf/log.c:66
 verbose+0x110/0x190 kernel/bpf/verifier.c:361
 print_bpf_insn+0xd6a/0x2400 kernel/bpf/disasm.c:320
 backtrack_insn kernel/bpf/verifier.c:3615 [inline]
 __mark_chain_precision+0x1a9b/0x7520 kernel/bpf/verifier.c:4272
 mark_chain_precision kernel/bpf/verifier.c:4375 [inline]
 check_cond_jmp_op+0x26c6/0x3c50 kernel/bpf/verifier.c:15212
 do_check+0x9a63/0x104f0 kernel/bpf/verifier.c:18110
 do_check_common+0x14bd/0x1dd0 kernel/bpf/verifier.c:20916
 do_check_main kernel/bpf/verifier.c:21007 [inline]
 bpf_check+0x144e1/0x19630 kernel/bpf/verifier.c:21681
 bpf_prog_load+0x1667/0x20f0 kernel/bpf/syscall.c:2908
 __sys_bpf+0x4ee/0x810 kernel/bpf/syscall.c:5710
 __do_sys_bpf kernel/bpf/syscall.c:5817 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5815 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5815
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8d12379eb9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f8d130e8038 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 00007f8d12515f80 RCX: 00007f8d12379eb9
RDX: 0000000000000023 RSI: 0000000020000300 RDI: 0000000000000005
RBP: 00007f8d123e793e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f8d12515f80 R15: 00007fff44c41278
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 f5                	mov    %esi,%ebp
   2:	49 c1 ed 03          	shr    $0x3,%r13
   6:	eb 0d                	jmp    0x15
   8:	48 f7 03 08 00 00 00 	testq  $0x8,(%rbx)
   f:	0f 84 8b 00 00 00    	je     0xa0
  15:	bf 01 00 00 00       	mov    $0x1,%edi
  1a:	e8 a5 61 a1 f5       	call   0xf5a161c4
  1f:	e8 30 50 d9 f5       	call   0xf5d95054
  24:	fb                   	sti
  25:	bf 01 00 00 00       	mov    $0x1,%edi
* 2a:	e8 55 ad ff ff       	call   0xffffad84 <-- trapping instruction
  2f:	43 80 7c 3d 00 00    	cmpb   $0x0,0x0(%r13,%r15,1)
  35:	74 08                	je     0x3f
  37:	4c 89 f7             	mov    %r14,%rdi
  3a:	e8 85 36 39 f6       	call   0xf63936c4
  3f:	48                   	rex.W


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


Return-Path: <netdev+bounces-128471-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C90C979ABE
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 07:27:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91A20281AE5
	for <lists+netdev@lfdr.de>; Mon, 16 Sep 2024 05:27:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF932209F;
	Mon, 16 Sep 2024 05:27:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D29C200A3
	for <netdev@vger.kernel.org>; Mon, 16 Sep 2024 05:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726464446; cv=none; b=SSkZ9s0lfiJk9AV9f27G8Ek2R0CgIthSpVXzRJabEwM5yDh+terosI11UhI48ul6NkKO70P9aiuxY9kAoRiVay6hWgPQnjBAm9DrKzWjWgwMSEDvlUAd8bW2C4SNZMh3MYNix4JrU9T2LIYi8ycH4p1PTdNZGsFJqebwHPt9yvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726464446; c=relaxed/simple;
	bh=TsTXms7Oaem88xMbZkhnJUWIscJd+QE/qIKPYMcNNuY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=kv8qLBMpyMTltrGta65I3AfYplqyHMNViK+7fwxWGU/Ofj+WT626hsj7JDjBa3RyDFIo9xE3h+0NqcVZdRHzrEzwx0v4Upv90zM3vUFExOnXd7zYEX61HwB1bsRsesN8NGE0wi+1jP9g66SMmSTAZfIqF75ak7B5+tT2eg6BqpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a099015de4so33651705ab.1
        for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 22:27:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726464444; x=1727069244;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VAkV9PjxebjmDBJ8IWui3MW5TyFqC24e/YDUGMyA/PQ=;
        b=mq8LUAU9Ss7n03fQpTzFTNEVQzi4pXRwYnxLzOGpudoJ/l7PmgyUIy4+GmOX5VcJf+
         TOmIGYRNjDk+Pio1oY7U2kjKW8WPyigz9ozBJU8R1NyHVcrP8nONauAPJEgNYSuVQQst
         4AChT2179jOCOZHcDuW2Ex9js63MNliqjPV7GY0suKwqIx7XEraaV6TIhVuv2/FgFb26
         aFv8Fq1MSF+6PjMOnhXFRJqajeynKqKUyrlcv8LgkdaV1Tbkbk18EjKW/uRjNhX8CLbn
         Y9yUspZ8IPKc+ti1snKgRAhgjLGOe/GgTtEct13bzCGhlC5jgNPUlZhp6ea44rTzHHX9
         CD1Q==
X-Forwarded-Encrypted: i=1; AJvYcCXMeJweLu+ywGfTxllwjBC8NNGfUZEDQoVN7E7SlHh7qQgsE0Mk5Twf/G9OFI7r4TFt5ViIGpI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNZKxNlirdbliwbzQ3h2uIxvvp2geF6QkKYL3yQGzlyKvBKeBr
	qMEpzxJt/DLrEHRTexfsckAoDirA/2aKMDR6KFtcf/9YbAEHv9VtC6FuzMRUnpWVRleQauqwi1N
	vmgEo5EK0XekY6Z0sPy4l+iN7q352Rul6+vr70mK2VbECxac7JHOqMek=
X-Google-Smtp-Source: AGHT+IHXMSmZigDem6EyJCy/a2rFy3is3EZTeyCUrO7fgLeR7n9rYjqeMubWG1jx7iXns3zDJgw+NiJ7hhghnTmPiSsqby97DpZ3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:505:b0:3a0:9c04:8047 with SMTP id
 e9e14a558f8ab-3a09c048195mr30261255ab.6.1726464443649; Sun, 15 Sep 2024
 22:27:23 -0700 (PDT)
Date: Sun, 15 Sep 2024 22:27:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e1a626062235d385@google.com>
Subject: [syzbot] [kernel?] possible deadlock in __schedule (3)
From: syzbot <syzbot+7202b8bae7c5b11493e7@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b831f83e40a2 Merge tag 'bpf-6.11-rc7' of git://git.kernel...
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=12c2a0a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=660f6eb11f9c7dc5
dashboard link: https://syzkaller.appspot.com/bug?extid=7202b8bae7c5b11493e7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c7085e50cff6/disk-b831f83e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/19c50c855380/vmlinux-b831f83e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/80936012b998/bzImage-b831f83e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7202b8bae7c5b11493e7@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name fail_usercopy, interval 1, probability 0, space 0, times 0
======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc6-syzkaller-00183-gb831f83e40a2 #0 Not tainted
------------------------------------------------------
syz.3.84/5592 is trying to acquire lock:
ffffffff8e92c400 (console_owner){-...}-{0:0}, at: console_trylock_spinning kernel/printk/printk.c:1997 [inline]
ffffffff8e92c400 (console_owner){-...}-{0:0}, at: vprintk_emit+0x405/0x7c0 kernel/printk/printk.c:2347

but task is already holding lock:
ffff8880b8828948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: __schedule+0x8f1/0x4a60 kernel/sched/core.c:6523

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #5 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       do_write_seqcount_begin_nested include/linux/seqlock.h:469 [inline]
       do_write_seqcount_begin include/linux/seqlock.h:495 [inline]
       psi_group_change+0x1c3/0x11c0 kernel/sched/psi.c:791
       psi_task_change+0xfd/0x280 kernel/sched/psi.c:913
       psi_enqueue kernel/sched/stats.h:143 [inline]
       enqueue_task+0x2aa/0x300 kernel/sched/core.c:1975
       activate_task kernel/sched/core.c:2009 [inline]
       wake_up_new_task+0x563/0xc30 kernel/sched/core.c:4689
       kernel_clone+0x4ee/0x8f0 kernel/fork.c:2812
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2859
       rest_init+0x23/0x300 init/main.c:712
       start_kernel+0x47a/0x500 init/main.c:1103
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #4 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560
       raw_spin_rq_lock kernel/sched/sched.h:1415 [inline]
       rq_lock kernel/sched/sched.h:1714 [inline]
       task_fork_fair+0x61/0x1e0 kernel/sched/fair.c:12710
       sched_cgroup_fork+0x37c/0x410 kernel/sched/core.c:4633
       copy_process+0x2217/0x3dc0 kernel/fork.c:2483
       kernel_clone+0x226/0x8f0 kernel/fork.c:2781
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2859
       rest_init+0x23/0x300 init/main.c:712
       start_kernel+0x47a/0x500 init/main.c:1103
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #3 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
       try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4051
       __wake_up_common kernel/sched/wait.c:89 [inline]
       __wake_up_common_lock+0x130/0x1e0 kernel/sched/wait.c:106
       tty_port_default_wakeup+0xa6/0xf0 drivers/tty/tty_port.c:69
       serial8250_tx_chars+0x6e2/0x930 drivers/tty/serial/8250/8250_port.c:1821
       serial8250_handle_irq+0x558/0x710 drivers/tty/serial/8250/8250_port.c:1929
       serial8250_default_handle_irq+0xd1/0x1f0 drivers/tty/serial/8250/8250_port.c:1949
       serial8250_interrupt+0xa9/0x1f0 drivers/tty/serial/8250/8250_core.c:86
       __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
       handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
       generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
       handle_irq arch/x86/kernel/irq.c:247 [inline]
       call_irq_handler arch/x86/kernel/irq.c:259 [inline]
       __common_interrupt+0x136/0x230 arch/x86/kernel/irq.c:285
       common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:278
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
       native_safe_halt arch/x86/include/asm/irqflags.h:48 [inline]
       arch_safe_halt arch/x86/include/asm/irqflags.h:106 [inline]
       acpi_safe_halt+0x21/0x30 drivers/acpi/processor_idle.c:111
       acpi_idle_enter+0xe4/0x140 drivers/acpi/processor_idle.c:702
       cpuidle_enter_state+0x112/0x480 drivers/cpuidle/cpuidle.c:267
       cpuidle_enter+0x5d/0xa0 drivers/cpuidle/cpuidle.c:388
       call_cpuidle kernel/sched/idle.c:155 [inline]
       cpuidle_idle_call kernel/sched/idle.c:230 [inline]
       do_idle+0x375/0x5d0 kernel/sched/idle.c:326
       cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:424
       __pfx_ap_starting+0x0/0x10 arch/x86/kernel/smpboot.c:313
       common_startup_64+0x13e/0x147

-> #2 (
&tty->write_wait){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       __wake_up_common_lock+0x25/0x1e0 kernel/sched/wait.c:105
       tty_port_default_wakeup+0xa6/0xf0 drivers/tty/tty_port.c:69
       serial8250_tx_chars+0x6e2/0x930 drivers/tty/serial/8250/8250_port.c:1821
       serial8250_handle_irq+0x558/0x710 drivers/tty/serial/8250/8250_port.c:1929
       serial8250_default_handle_irq+0xd1/0x1f0 drivers/tty/serial/8250/8250_port.c:1949
       serial8250_interrupt+0xa9/0x1f0 drivers/tty/serial/8250/8250_core.c:86
       __handle_irq_event_percpu+0x29a/0xa80 kernel/irq/handle.c:158
       handle_irq_event_percpu kernel/irq/handle.c:193 [inline]
       handle_irq_event+0x89/0x1f0 kernel/irq/handle.c:210
       handle_edge_irq+0x25f/0xc20 kernel/irq/chip.c:831
       generic_handle_irq_desc include/linux/irqdesc.h:173 [inline]
       handle_irq arch/x86/kernel/irq.c:247 [inline]
       call_irq_handler arch/x86/kernel/irq.c:259 [inline]
       __common_interrupt+0x136/0x230 arch/x86/kernel/irq.c:285
       common_interrupt+0xa5/0xd0 arch/x86/kernel/irq.c:278
       asm_common_interrupt+0x26/0x40 arch/x86/include/asm/idtentry.h:693
       __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
       _raw_spin_unlock_irqrestore+0xd8/0x140 kernel/locking/spinlock.c:194
       spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
       uart_port_unlock_irqrestore include/linux/serial_core.h:669 [inline]
       uart_write+0x15d/0x380 drivers/tty/serial/serial_core.c:634
       process_output_block drivers/tty/n_tty.c:574 [inline]
       n_tty_write+0xd6a/0x1230 drivers/tty/n_tty.c:2389
       iterate_tty_write drivers/tty/tty_io.c:1021 [inline]
       file_tty_write+0x54f/0x9c0 drivers/tty/tty_io.c:1096
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa72/0xc90 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&port_lock_key){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       uart_port_lock_irqsave include/linux/serial_core.h:618 [inline]
       serial8250_console_write+0x1a8/0x1770 drivers/tty/serial/8250/8250_port.c:3352
       console_emit_next_record kernel/printk/printk.c:2983 [inline]
       console_flush_all+0x867/0xfd0 kernel/printk/printk.c:3049
       console_unlock+0x13b/0x4d0 kernel/printk/printk.c:3118
       vprintk_emit+0x5dc/0x7c0 kernel/printk/printk.c:2348
       _printk+0xd5/0x120 kernel/printk/printk.c:2373
       register_console+0x727/0xcf0 kernel/printk/printk.c:3654
       univ8250_console_init+0x52/0x90 drivers/tty/serial/8250/8250_core.c:513
       console_init+0x1b8/0x6f0 kernel/printk/printk.c:3800
       start_kernel+0x2d3/0x500 init/main.c:1038
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #0 (console_owner){-...}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       console_trylock_spinning kernel/printk/printk.c:1997 [inline]
       vprintk_emit+0x422/0x7c0 kernel/printk/printk.c:2347
       _printk+0xd5/0x120 kernel/printk/printk.c:2373
       fail_dump lib/fault-inject.c:45 [inline]
       should_fail_ex+0x391/0x4e0 lib/fault-inject.c:153
       strncpy_from_user+0x36/0x2e0 lib/strncpy_from_user.c:118
       strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
       bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:216 [inline]
       ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:311 [inline]
       bpf_probe_read_compat_str+0xe9/0x180 kernel/trace/bpf_trace.c:307
       bpf_prog_29e826963d3c3848+0x40/0x44
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:691 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       bpf_prog_run_array include/linux/bpf.h:2104 [inline]
       trace_call_bpf+0x369/0x8a0 kernel/trace/bpf_trace.c:147
       perf_trace_run_bpf_submit+0x82/0x180 kernel/events/core.c:10304
       perf_trace_lock+0x388/0x490 include/trace/events/lock.h:50
       trace_lock_release include/trace/events/lock.h:69 [inline]
       lock_release+0x9cc/0xa30 kernel/locking/lockdep.c:5770
       do_write_seqcount_end include/linux/seqlock.h:515 [inline]
       psi_account_irqtime+0x49f/0x750 kernel/sched/psi.c:1032
       __schedule+0x8f1/0x4a60 kernel/sched/core.c:6523
       preempt_schedule_notrace+0x100/0x140 kernel/sched/core.c:6801
       preempt_schedule_notrace_thunk+0x1a/0x30 arch/x86/entry/thunk.S:13
       trace_lock_release include/trace/events/lock.h:69 [inline]
       lock_release+0x9f0/0xa30 kernel/locking/lockdep.c:5770
       rcu_lock_release include/linux/rcupdate.h:336 [inline]
       rcu_read_unlock include/linux/rcupdate.h:869 [inline]
       __fget_files+0x3f1/0x470 fs/file.c:1033
       __fget_light fs/file.c:1147 [inline]
       __fdget+0x16c/0x1e0 fs/file.c:1155
       fdget include/linux/file.h:66 [inline]
       sockfd_lookup_light net/socket.c:555 [inline]
       __sys_sendmsg+0xe7/0x3a0 net/socket.c:2676
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  console_owner --> &rq->__lock --> &per_cpu_ptr(group->pcpu, cpu)->seq

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&per_cpu_ptr(group->pcpu, cpu)->seq);
                               lock(&rq->__lock);
                               lock(&per_cpu_ptr(group->pcpu, cpu)->seq);
  lock(console_owner);

 *** DEADLOCK ***

4 locks held by syz.3.84/5592:
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: __fget_files+0x29/0x470 fs/file.c:1031
 #1: ffff8880b883e9d8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:560
 #2: ffff8880b8828948 (&per_cpu_ptr(group->pcpu, cpu)->seq){-.-.}-{0:0}, at: __schedule+0x8f1/0x4a60 kernel/sched/core.c:6523
 #3: ffffffff8e938320 (rcu_read_lock){....}-{1:2}, at: trace_call_bpf+0xbc/0x8a0

stack backtrace:
CPU: 0 UID: 0 PID: 5592 Comm: syz.3.84 Not tainted 6.11.0-rc6-syzkaller-00183-gb831f83e40a2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 console_trylock_spinning kernel/printk/printk.c:1997 [inline]
 vprintk_emit+0x422/0x7c0 kernel/printk/printk.c:2347
 _printk+0xd5/0x120 kernel/printk/printk.c:2373
 fail_dump lib/fault-inject.c:45 [inline]
 should_fail_ex+0x391/0x4e0 lib/fault-inject.c:153
 strncpy_from_user+0x36/0x2e0 lib/strncpy_from_user.c:118
 strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
 bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:216 [inline]
 ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:311 [inline]
 bpf_probe_read_compat_str+0xe9/0x180 kernel/trace/bpf_trace.c:307
 bpf_prog_29e826963d3c3848+0x40/0x44
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 bpf_prog_run_array include/linux/bpf.h:2104 [inline]
 trace_call_bpf+0x369/0x8a0 kernel/trace/bpf_trace.c:147
 perf_trace_run_bpf_submit+0x82/0x180 kernel/events/core.c:10304
 perf_trace_lock+0x388/0x490 include/trace/events/lock.h:50
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x9cc/0xa30 kernel/locking/lockdep.c:5770
 do_write_seqcount_end include/linux/seqlock.h:515 [inline]
 psi_account_irqtime+0x49f/0x750 kernel/sched/psi.c:1032
 __schedule+0x8f1/0x4a60 kernel/sched/core.c:6523
 preempt_schedule_notrace+0x100/0x140 kernel/sched/core.c:6801
 preempt_schedule_notrace_thunk+0x1a/0x30 arch/x86/entry/thunk.S:13
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x9f0/0xa30 kernel/locking/lockdep.c:5770
 rcu_lock_release include/linux/rcupdate.h:336 [inline]
 rcu_read_unlock include/linux/rcupdate.h:869 [inline]
 __fget_files+0x3f1/0x470 fs/file.c:1033
 __fget_light fs/file.c:1147 [inline]
 __fdget+0x16c/0x1e0 fs/file.c:1155
 fdget include/linux/file.h:66 [inline]
 sockfd_lookup_light net/socket.c:555 [inline]
 __sys_sendmsg+0xe7/0x3a0 net/socket.c:2676
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1432b7def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f14339b6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f1432d35f80 RCX: 00007f1432b7def9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000009
RBP: 00007f14339b6090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f1432d35f80 R15: 00007ffef36b3a38
 </TASK>
CPU: 0 UID: 0 PID: 5592 Comm: syz.3.84 Not tainted 6.11.0-rc6-syzkaller-00183-gb831f83e40a2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 fail_dump lib/fault-inject.c:52 [inline]
 should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:153
 strncpy_from_user+0x36/0x2e0 lib/strncpy_from_user.c:118
 strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
 bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:216 [inline]
 ____bpf_probe_read_compat_str kernel/trace/bpf_trace.c:311 [inline]
 bpf_probe_read_compat_str+0xe9/0x180 kernel/trace/bpf_trace.c:307
 bpf_prog_29e826963d3c3848+0x40/0x44
 bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
 __bpf_prog_run include/linux/filter.h:691 [inline]
 bpf_prog_run include/linux/filter.h:698 [inline]
 bpf_prog_run_array include/linux/bpf.h:2104 [inline]
 trace_call_bpf+0x369/0x8a0 kernel/trace/bpf_trace.c:147
 perf_trace_run_bpf_submit+0x82/0x180 kernel/events/core.c:10304
 perf_trace_lock+0x388/0x490 include/trace/events/lock.h:50
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x9cc/0xa30 kernel/locking/lockdep.c:5770
 do_write_seqcount_end include/linux/seqlock.h:515 [inline]
 psi_account_irqtime+0x49f/0x750 kernel/sched/psi.c:1032
 __schedule+0x8f1/0x4a60 kernel/sched/core.c:6523
 preempt_schedule_notrace+0x100/0x140 kernel/sched/core.c:6801
 preempt_schedule_notrace_thunk+0x1a/0x30 arch/x86/entry/thunk.S:13
 trace_lock_release include/trace/events/lock.h:69 [inline]
 lock_release+0x9f0/0xa30 kernel/locking/lockdep.c:5770
 rcu_lock_release include/linux/rcupdate.h:336 [inline]
 rcu_read_unlock include/linux/rcupdate.h:869 [inline]
 __fget_files+0x3f1/0x470 fs/file.c:1033
 __fget_light fs/file.c:1147 [inline]
 __fdget+0x16c/0x1e0 fs/file.c:1155
 fdget include/linux/file.h:66 [inline]
 sockfd_lookup_light net/socket.c:555 [inline]
 __sys_sendmsg+0xe7/0x3a0 net/socket.c:2676
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1432b7def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f14339b6038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f1432d35f80 RCX: 00007f1432b7def9
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000009
RBP: 00007f14339b6090 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007f1432d35f80 R15: 00007ffef36b3a38
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


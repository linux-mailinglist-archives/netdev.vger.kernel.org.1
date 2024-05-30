Return-Path: <netdev+bounces-99520-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E5778D51DD
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 20:36:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42F1E28472F
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 18:36:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 981684D9E3;
	Thu, 30 May 2024 18:36:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C882C4C3C3
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 18:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717094194; cv=none; b=ftmwr8YfUK163CWHMeM531i6NoHuxg3GP+snCaX8hyYrxgOxoBJPvq21iNXZtYt78CKyopA5GvNL5JciWuzsKTBa/h3regFeMJvr/xYbnjw+SNvzPWLDI03IoZhjgIoC1w6zyBXvMuVKtSXimrqFwEU/wWJc4DfC28IxxB+neEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717094194; c=relaxed/simple;
	bh=i3Pc/CviSAhHjormskhMKUif8ESk5MiMeWzZjwjN/mA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=hrl/O7snOr79O4DF8hNFLBCDX8IoQRGXGEpi5SVpnhcOfiX9835+k6/5SjG27Ms1ux8ZcFRh+f3fbqJxYDiFFN2YfcOJVNfgwvgdvQXdnkGEbztaxXd+8j3tFf45zPJoRI28qnaQkvBd1iaQhtngjfQ3S36LrM9XCv4DNv0mjBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7e212ee8008so155216439f.0
        for <netdev@vger.kernel.org>; Thu, 30 May 2024 11:36:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717094192; x=1717698992;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RFSm7dVTf6uWq0rBom+Q5nS1FnZS70bDYMkL075o/WU=;
        b=oGHlT9fHMXqR+ENW6rVVV+EzcGSrDtwZwxqQFpq1BBKxyvrCS0JlHBAnGG6d92hEWz
         oNuxsQ0O2BN5IQOeqGPRQ37JOmw3o5RzZF875IDinBarJ1NzD8r2LuxaeIWq+qhlNCMG
         sVYQPwwrg2+HQGM0dGS4AgP2Zcj1O38VXRmz3pxLzCLnt0zIxD6HYotNJFu873NR6zHz
         4tJpN5WGXkZRFCmITHTvPZL2IKldNPrKdi1wvYMi3o+FDuNk0U/buCmXtfAdu+DDH5ol
         f4PwfnySiu/KG5BdEoIeZ9TmNYsiXKGaQYJ8K6I6Ip7XJydetYmyLvrW8z0ZCrZqK/ka
         7Vdw==
X-Forwarded-Encrypted: i=1; AJvYcCWHKD54OSMKWa3i9G0Exav7YT4OHTy6uKgamjza/kqzhptEUtwgJCS5P8z/iRNs1gAciNsw6OPM1XgctRq7yYmHPKGdK75N
X-Gm-Message-State: AOJu0Ywq/mouzs42BbGdM7Ifw8wntCkjTItfoNOHXu85weVksTlG+QNF
	St8mI3N7P14HgR4DTnh+7Uaw23jL6hWUU+Ln0SY/f0NJv8sBVBF1zAJqW9icmU1QKhs57oWnJIk
	qTBkLFiYCPmQg9f17Rot489p50SM4BmOhP9TBAI47/ytgwEuVTReSYXw=
X-Google-Smtp-Source: AGHT+IHeL0AzcXNDKZXGqRxetDsb+6LW9UgeXRP+dayZVaQ3Mi9K6ohw0eUzNBpesSpEj/j16PUFrg1afksj13T5TZZsPno+BL1R
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1307:b0:488:75e3:f3c5 with SMTP id
 8926c6da1cb9f-4b1da6452d7mr153260173.0.1717094192016; Thu, 30 May 2024
 11:36:32 -0700 (PDT)
Date: Thu, 30 May 2024 11:36:32 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005c8adb0619b025aa@google.com>
Subject: [syzbot] [mm?] possible deadlock in try_to_wake_up (5)
From: syzbot <syzbot+4970d08867f5a5b0bb78@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, 
	linux-mm@kvack.org, netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    95348e463eab selftests/bpf: Add netkit test for pkt_type
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=11646be0980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=4970d08867f5a5b0bb78
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/45aceeb3f8f5/disk-95348e46.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ff3ff3033939/vmlinux-95348e46.xz
kernel image: https://storage.googleapis.com/syzbot-assets/fdfb9e139fb3/bzImage-95348e46.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4970d08867f5a5b0bb78@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.9.0-syzkaller-08570-g95348e463eab #0 Not tainted
------------------------------------------------------
syz-executor.0/8491 is trying to acquire lock:
ffff8880176f0a18 (&p->pi_lock){-.-.}-{2:2}, at: class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:553 [inline]
ffff8880176f0a18 (&p->pi_lock){-.-.}-{2:2}, at: try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4262

but task is already holding lock:
ffff8880b9538828 (lock#10){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
ffff8880b9538828 (lock#10){+.+.}-{2:2}, at: __mmap_lock_do_trace_acquire_returned+0x8f/0x630 mm/mmap_lock.c:237

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (lock#10){+.+.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
       __mmap_lock_do_trace_acquire_returned+0xa8/0x630 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_read_trylock include/linux/mmap_lock.h:166 [inline]
       stack_map_get_build_id_offset+0x9b2/0x9d0 kernel/bpf/stackmap.c:141
       __bpf_get_stack+0x4ad/0x5a0 kernel/bpf/stackmap.c:449
       ____bpf_get_stack_raw_tp kernel/trace/bpf_trace.c:1994 [inline]
       bpf_get_stack_raw_tp+0x1a3/0x240 kernel/trace/bpf_trace.c:1984
       0xffffffffa0001b6a
       bpf_dispatcher_nop_func include/linux/bpf.h:1243 [inline]
       __bpf_prog_run include/linux/filter.h:682 [inline]
       bpf_prog_run include/linux/filter.h:698 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2403 [inline]
       bpf_trace_run2+0x47d/0x540 kernel/trace/bpf_trace.c:2444
       trace_tlb_flush+0x118/0x140 include/trace/events/tlb.h:38
       switch_mm_irqs_off+0x7cb/0xae0
       context_switch kernel/sched/core.c:5392 [inline]
       __schedule+0x1066/0x4a50 kernel/sched/core.c:6745
       preempt_schedule_common+0x84/0xd0 kernel/sched/core.c:6924
       preempt_schedule+0xe1/0xf0 kernel/sched/core.c:6948
       preempt_schedule_thunk+0x1a/0x30 arch/x86/entry/thunk.S:12
       __raw_spin_unlock include/linux/spinlock_api_smp.h:143 [inline]
       _raw_spin_unlock+0x3e/0x50 kernel/locking/spinlock.c:186
       spin_unlock include/linux/spinlock.h:391 [inline]
       __text_poke+0xa6b/0xd30 arch/x86/kernel/alternative.c:1944
       text_poke arch/x86/kernel/alternative.c:1968 [inline]
       text_poke_bp_batch+0x265/0xb30 arch/x86/kernel/alternative.c:2276
       text_poke_flush arch/x86/kernel/alternative.c:2470 [inline]
       text_poke_finish+0x30/0x50 arch/x86/kernel/alternative.c:2477
       arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
       static_key_enable_cpuslocked+0x136/0x260 kernel/jump_label.c:205
       static_key_enable+0x1a/0x20 kernel/jump_label.c:218
       tracepoint_add_func+0x953/0x9e0 kernel/tracepoint.c:361
       tracepoint_probe_register_prio kernel/tracepoint.c:511 [inline]
       tracepoint_probe_register+0x105/0x160 kernel/tracepoint.c:531
       perf_trace_event_reg kernel/trace/trace_event_perf.c:129 [inline]
       perf_trace_event_init+0x478/0x910 kernel/trace/trace_event_perf.c:202
       perf_trace_init+0x243/0x2e0 kernel/trace/trace_event_perf.c:226
       perf_tp_event_init+0x8d/0x110 kernel/events/core.c:10210
       perf_try_init_event+0x139/0x3f0 kernel/events/core.c:11685
       perf_init_event kernel/events/core.c:11755 [inline]
       perf_event_alloc+0x1018/0x20b0 kernel/events/core.c:12033
       __do_sys_perf_event_open kernel/events/core.c:12540 [inline]
       __se_sys_perf_event_open+0xb43/0x38d0 kernel/events/core.c:12431
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:559
       raw_spin_rq_lock kernel/sched/sched.h:1406 [inline]
       rq_lock kernel/sched/sched.h:1702 [inline]
       task_fork_fair+0x61/0x1e0 kernel/sched/fair.c:12709
       sched_cgroup_fork+0x37c/0x410 kernel/sched/core.c:4844
       copy_process+0x2217/0x3dc0 kernel/fork.c:2499
       kernel_clone+0x226/0x8f0 kernel/fork.c:2797
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2875
       rest_init+0x23/0x300 init/main.c:707
       start_kernel+0x47a/0x500 init/main.c:1084
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x99/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #0 (&p->pi_lock){-.-.}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3134 [inline]
       check_prevs_add kernel/locking/lockdep.c:3253 [inline]
       validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
       __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:553 [inline]
       try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4262
       rcu_read_unlock_special+0x3db/0x550 kernel/rcu/tree_plugin.h:655
       __rcu_read_unlock+0xa1/0x110 kernel/rcu/tree_plugin.h:426
       __mmap_lock_do_trace_acquire_returned+0x1f9/0x630 mm/mmap_lock.c:237
       __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
       mmap_read_trylock include/linux/mmap_lock.h:166 [inline]
       get_mmap_lock_carefully mm/memory.c:5628 [inline]
       lock_mm_and_find_vma+0x213/0x2f0 mm/memory.c:5688
       do_user_addr_fault arch/x86/mm/fault.c:1355 [inline]
       handle_page_fault arch/x86/mm/fault.c:1475 [inline]
       exc_page_fault+0x1a9/0x8a0 arch/x86/mm/fault.c:1533
       asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
       fault_in_readable+0x165/0x2b0
       fault_in_iov_iter_readable+0x229/0x280 lib/iov_iter.c:94
       generic_perform_write+0x220/0x640 mm/filemap.c:3964
       ext4_buffered_write_iter+0xc6/0x350 fs/ext4/file.c:299
       ext4_file_write_iter+0x1de/0x1a10
       call_write_iter include/linux/fs.h:2120 [inline]
       new_sync_write fs/read_write.c:497 [inline]
       vfs_write+0xa2d/0xc50 fs/read_write.c:590
       ksys_write+0x1a0/0x2c0 fs/read_write.c:643
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  &p->pi_lock --> &rq->__lock --> lock#10

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(lock#10);
                               lock(&rq->__lock);
                               lock(lock#10);
  lock(&p->pi_lock);

 *** DEADLOCK ***

5 locks held by syz-executor.0/8491:
 #0: ffff888057b239c8 (&f->f_pos_lock){+.+.}-{3:3}, at: __fdget_pos+0x259/0x320 fs/file.c:1191
 #1: ffff88802f3aa420 (sb_writers#4){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2871 [inline]
 #1: ffff88802f3aa420 (sb_writers#4){.+.+}-{0:0}, at: vfs_write+0x227/0xc50 fs/read_write.c:586
 #2: ffff88805e14ac00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: inode_lock include/linux/fs.h:791 [inline]
 #2: ffff88805e14ac00 (&sb->s_type->i_mutex_key#8){++++}-{3:3}, at: ext4_buffered_write_iter+0x97/0x350 fs/ext4/file.c:294
 #3: ffff88807b0b81a0 (&mm->mmap_lock){++++}-{3:3}, at: mmap_read_trylock include/linux/mmap_lock.h:165 [inline]
 #3: ffff88807b0b81a0 (&mm->mmap_lock){++++}-{3:3}, at: get_mmap_lock_carefully mm/memory.c:5628 [inline]
 #3: ffff88807b0b81a0 (&mm->mmap_lock){++++}-{3:3}, at: lock_mm_and_find_vma+0x32/0x2f0 mm/memory.c:5688
 #4: ffff8880b9538828 (lock#10){+.+.}-{2:2}, at: local_lock_acquire include/linux/local_lock_internal.h:29 [inline]
 #4: ffff8880b9538828 (lock#10){+.+.}-{2:2}, at: __mmap_lock_do_trace_acquire_returned+0x8f/0x630 mm/mmap_lock.c:237

stack backtrace:
CPU: 1 PID: 8491 Comm: syz-executor.0 Not tainted 6.9.0-syzkaller-08570-g95348e463eab #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:114
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2187
 check_prev_add kernel/locking/lockdep.c:3134 [inline]
 check_prevs_add kernel/locking/lockdep.c:3253 [inline]
 validate_chain+0x18cb/0x58e0 kernel/locking/lockdep.c:3869
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:553 [inline]
 try_to_wake_up+0xb0/0x1470 kernel/sched/core.c:4262
 rcu_read_unlock_special+0x3db/0x550 kernel/rcu/tree_plugin.h:655
 __rcu_read_unlock+0xa1/0x110 kernel/rcu/tree_plugin.h:426
 __mmap_lock_do_trace_acquire_returned+0x1f9/0x630 mm/mmap_lock.c:237
 __mmap_lock_trace_acquire_returned include/linux/mmap_lock.h:36 [inline]
 mmap_read_trylock include/linux/mmap_lock.h:166 [inline]
 get_mmap_lock_carefully mm/memory.c:5628 [inline]
 lock_mm_and_find_vma+0x213/0x2f0 mm/memory.c:5688
 do_user_addr_fault arch/x86/mm/fault.c:1355 [inline]
 handle_page_fault arch/x86/mm/fault.c:1475 [inline]
 exc_page_fault+0x1a9/0x8a0 arch/x86/mm/fault.c:1533
 asm_exc_page_fault+0x26/0x30 arch/x86/include/asm/idtentry.h:623
RIP: 0010:fault_in_readable+0x165/0x2b0 mm/gup.c:2009
Code: b5 ff 4c 8d b3 ff 0f 00 00 48 89 d8 4d 01 e6 49 81 e6 00 f0 ff ff 49 39 c6 72 6b e8 85 80 b5 ff 4c 39 f3 74 6e 4c 89 64 24 10 <44> 8a 23 43 0f b6 04 2f 84 c0 75 18 44 88 64 24 40 48 81 c3 00 10
RSP: 0018:ffffc90002e4f860 EFLAGS: 00050287
RAX: ffffffff81e0b14b RBX: 000000002008e000 RCX: 0000000000040000
RDX: ffffc90009789000 RSI: 00000000000311f0 RDI: 00000000000311f1
RBP: ffffc90002e4f918 R08: ffffffff81e0b0e8 R09: ffffffff84ad9419
R10: 0000000000000002 R11: ffff888022843c00 R12: 0000000000001000
R13: dffffc0000000000 R14: 000000002008f000 R15: 1ffff920005c9f14
 fault_in_iov_iter_readable+0x229/0x280 lib/iov_iter.c:94
 generic_perform_write+0x220/0x640 mm/filemap.c:3964
 ext4_buffered_write_iter+0xc6/0x350 fs/ext4/file.c:299
 ext4_file_write_iter+0x1de/0x1a10
 call_write_iter include/linux/fs.h:2120 [inline]
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0xa2d/0xc50 fs/read_write.c:590
 ksys_write+0x1a0/0x2c0 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd1f167cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fd1f23c40c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007fd1f17abf80 RCX: 00007fd1f167cee9
RDX: 00000000fffffd26 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007fd1f16c949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fd1f17abf80 R15: 00007ffdbacf9b68
 </TASK>
----------------
Code disassembly (best guess):
   0:	b5 ff                	mov    $0xff,%ch
   2:	4c 8d b3 ff 0f 00 00 	lea    0xfff(%rbx),%r14
   9:	48 89 d8             	mov    %rbx,%rax
   c:	4d 01 e6             	add    %r12,%r14
   f:	49 81 e6 00 f0 ff ff 	and    $0xfffffffffffff000,%r14
  16:	49 39 c6             	cmp    %rax,%r14
  19:	72 6b                	jb     0x86
  1b:	e8 85 80 b5 ff       	call   0xffb580a5
  20:	4c 39 f3             	cmp    %r14,%rbx
  23:	74 6e                	je     0x93
  25:	4c 89 64 24 10       	mov    %r12,0x10(%rsp)
* 2a:	44 8a 23             	mov    (%rbx),%r12b <-- trapping instruction
  2d:	43 0f b6 04 2f       	movzbl (%r15,%r13,1),%eax
  32:	84 c0                	test   %al,%al
  34:	75 18                	jne    0x4e
  36:	44 88 64 24 40       	mov    %r12b,0x40(%rsp)
  3b:	48                   	rex.W
  3c:	81                   	.byte 0x81
  3d:	c3                   	ret
  3e:	00 10                	add    %dl,(%rax)


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


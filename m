Return-Path: <netdev+bounces-129881-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55147986BD4
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 06:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A46A1C20B18
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 04:46:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B466A1BF2B;
	Thu, 26 Sep 2024 04:46:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AABB91D5AA2
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 04:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727325989; cv=none; b=VPRh1KvS8htykyyWG7vNKBI8kNI9atEBvWyrJliu96tiqq1hNJe7g16d4hEDQKJ2NjyWFfWU0BGDRn8nlaDpSS5CukG5RxP5+PxeVnCfZCRZ4MegFc9B3gF5HIVh88f0qq27IQVZ7s9psrQxF2KjYqF1bl7IDHsA+WulG1AqKaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727325989; c=relaxed/simple;
	bh=WApdhbPwGf0o+V2YZ5hJNCAkZ4ZlCY7nWkPbZ4zy0Hc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=E+gymNGvOk4mrMw2Y9NJkJ9qsDgMr842/Uta/t1a5RE/mUb1hyqlYO+f73LvlptDTfdPBtnrpwNxens24dFFJBTxuzp5zVZbBGbh92ekPRBOkSBDiMCqDmgSK1DNFLIYoron4gsVP2P44Vd/BzYSGOQqtReMRpWFmCVkaa+fHOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a0cd6a028bso6183705ab.0
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 21:46:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727325987; x=1727930787;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C2IQvdemoO9XECzbM4nM3MJZEc4Dqfpv95Y7jq3RMOc=;
        b=iOX7GBPvZlbJJ5kpj3tWiw6xzI1ZpBzipSFwDJiWgUhMZms6ybFmVd2MCVpG0N36Xp
         X5QYIQ67fxP3zDy04H81G8Fqji7a4y5sRS1myOKTDWIC+Z79VwL5M5jwPoYfFlUZ6eK8
         ardOvWcml2tzIhbe3dlUe45nFRP5a+mn3O1yojW0/iW0/cDfTmf6gcNdQeLm2FV2EII6
         vWkjx8y9ILvBOQzQNFNrmsEyJVZk7X31whBnam7WYZDqb2rOHstCKVt5bqcsBRklsBRI
         C6q+y+dsgEUXJZY/mQWdguZbl2WEjFWtAlLXwavMI1+r/vuCkvMmZH0YFrF0+1Ra+RMA
         UWeQ==
X-Forwarded-Encrypted: i=1; AJvYcCU/m9FLHBu8Oob8yt+ysDLtZKzRuLxoEZVXHW7EsfLtiFdr9IP5Rk9eXyweFKN927e6N69ZXXo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzocfXC1Mka7zsD7CZ597OoGoyoTFgU2ssP0vFMAU9BZ8CSoaqH
	jIxXBHm1yN7+F6liz0TDh5eVDm2ljvSXQFF/EQUFC+N3bHJW89kzAS45NWOoiYHhmHd6FJ2ohvK
	5MCfbX5z3FmOpwTHUbJG5+uyyXSvfkXIax1zFLajdOrDcq7dnr/geak4=
X-Google-Smtp-Source: AGHT+IHDHypmyv01bskZOHcng03/aTGwGiyJzO5ZkcAoCDwv5tETyqvB9VOHNykJa08YTMrTIw1PAUynl7YwTpuszuI4c1D5ZW3S
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:18cb:b0:3a0:bc6f:c45a with SMTP id
 e9e14a558f8ab-3a26d7e4a80mr49655465ab.24.1727325986666; Wed, 25 Sep 2024
 21:46:26 -0700 (PDT)
Date: Wed, 25 Sep 2024 21:46:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f4e722.050a0220.211276.003b.GAE@google.com>
Subject: [syzbot] [kernel?] possible deadlock in hrtimer_start_range_ns (3)
From: syzbot <syzbot+f949cea3aaf2c22b5e7e@syzkaller.appspotmail.com>
To: anna-maria@linutronix.de, frederic@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    88264981f208 Merge tag 'sched_ext-for-6.12' of git://git.k..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=1580b080580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e851828834875d6f
dashboard link: https://syzkaller.appspot.com/bug?extid=f949cea3aaf2c22b5e7e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d770dd8854c/disk-88264981.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/45f6f124e691/vmlinux-88264981.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1ce55044a519/bzImage-88264981.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f949cea3aaf2c22b5e7e@syzkaller.appspotmail.com

FAULT_INJECTION: forcing a failure.
name fail_usercopy, interval 1, probability 0, space 0, times 0
======================================================
WARNING: possible circular locking dependency detected
6.11.0-syzkaller-g88264981f208 #0 Not tainted
------------------------------------------------------
syz.0.575/7708 is trying to acquire lock:
ffffffff8e813558 ((console_sem).lock){-...}-{2:2}, at: down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139

but task is already holding lock:
ffff8880b872c898 (hrtimer_bases.lock){-.-.}-{2:2}, at: lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
ffff8880b872c898 (hrtimer_bases.lock){-.-.}-{2:2}, at: hrtimer_start_range_ns+0x109/0xca0 kernel/time/hrtimer.c:1300

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (hrtimer_bases.lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
       hrtimer_start_range_ns+0x109/0xca0 kernel/time/hrtimer.c:1300
       hrtimer_start include/linux/hrtimer.h:275 [inline]
       start_dl_timer+0x36a/0x4d0 kernel/sched/deadline.c:1170
       enqueue_dl_entity+0x10ed/0x1d60 kernel/sched/deadline.c:2053
       dl_server_start+0xc9/0x240 kernel/sched/deadline.c:1650
       enqueue_task_fair+0xb5c/0xea0 kernel/sched/fair.c:7040
       enqueue_task+0x1a5/0x300 kernel/sched/core.c:2020
       activate_task kernel/sched/core.c:2062 [inline]
       wake_up_new_task+0x566/0xc30 kernel/sched/core.c:4816
       kernel_clone+0x4ee/0x8f0 kernel/fork.c:2818
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2865
       rest_init+0x23/0x300 init/main.c:712
       start_kernel+0x47f/0x500 init/main.c:1105
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #2 (&rq->__lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
       raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:593
       raw_spin_rq_lock kernel/sched/sched.h:1503 [inline]
       task_rq_lock+0xc6/0x360 kernel/sched/core.c:695
       cgroup_move_task+0x92/0x2d0 kernel/sched/psi.c:1161
       css_set_move_task+0x72e/0x950 kernel/cgroup/cgroup.c:898
       cgroup_post_fork+0x256/0x880 kernel/cgroup/cgroup.c:6692
       copy_process+0x39e9/0x3d50 kernel/fork.c:2601
       kernel_clone+0x226/0x8f0 kernel/fork.c:2787
       user_mode_thread+0x132/0x1a0 kernel/fork.c:2865
       rest_init+0x23/0x300 init/main.c:712
       start_kernel+0x47f/0x500 init/main.c:1105
       x86_64_start_reservations+0x2a/0x30 arch/x86/kernel/head64.c:507
       x86_64_start_kernel+0x9f/0xa0 arch/x86/kernel/head64.c:488
       common_startup_64+0x13e/0x147

-> #1 (&p->pi_lock){-.-.}-{2:2}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       class_raw_spinlock_irqsave_constructor include/linux/spinlock.h:551 [inline]
       try_to_wake_up+0xb0/0x1480 kernel/sched/core.c:4154
       up+0x72/0x90 kernel/locking/semaphore.c:191
       __up_console_sem kernel/printk/printk.c:343 [inline]
       __console_unlock+0x123/0x1f0 kernel/printk/printk.c:2844
       __console_flush_and_unlock kernel/printk/printk.c:3241 [inline]
       console_unlock+0x18f/0x3b0 kernel/printk/printk.c:3279
       vprintk_emit+0x730/0xa10 kernel/printk/printk.c:2407
       dev_vprintk_emit+0x2ae/0x330 drivers/base/core.c:4912
       dev_printk_emit+0xdd/0x120 drivers/base/core.c:4923
       _dev_warn+0x122/0x170 drivers/base/core.c:4979
       firmware_fallback_sysfs+0x4cf/0x9e0 drivers/base/firmware_loader/fallback.c:233
       _request_firmware+0xcf5/0x12b0 drivers/base/firmware_loader/main.c:914
       request_firmware_work_func+0x12a/0x280 drivers/base/firmware_loader/main.c:1165
       process_one_work kernel/workqueue.c:3229 [inline]
       process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
       worker_thread+0x870/0xd30 kernel/workqueue.c:3391
       kthread+0x2f0/0x390 kernel/kthread.c:389
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 ((console_sem).lock){-...}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:3158 [inline]
       check_prevs_add kernel/locking/lockdep.c:3277 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
       __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
       __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
       _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
       down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
       __down_trylock_console_sem+0x109/0x250 kernel/printk/printk.c:326
       console_trylock kernel/printk/printk.c:2827 [inline]
       console_trylock_spinning kernel/printk/printk.c:1990 [inline]
       vprintk_emit+0x3d7/0xa10 kernel/printk/printk.c:2406
       _printk+0xd5/0x120 kernel/printk/printk.c:2432
       fail_dump lib/fault-inject.c:46 [inline]
       should_fail_ex+0x391/0x4e0 lib/fault-inject.c:154
       strncpy_from_user+0x36/0x2e0 lib/strncpy_from_user.c:118
       strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
       bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:215 [inline]
       ____bpf_probe_read_user_str kernel/trace/bpf_trace.c:224 [inline]
       bpf_probe_read_user_str+0x2a/0x70 kernel/trace/bpf_trace.c:221
       bpf_prog_99b56f93a3ca5fea+0x4b/0x4d
       bpf_dispatcher_nop_func include/linux/bpf.h:1257 [inline]
       __bpf_prog_run include/linux/filter.h:701 [inline]
       bpf_prog_run include/linux/filter.h:708 [inline]
       __bpf_trace_run kernel/trace/bpf_trace.c:2318 [inline]
       bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2359
       __traceiter_hrtimer_start+0x76/0xd0 include/trace/events/timer.h:222
       trace_hrtimer_start include/trace/events/timer.h:222 [inline]
       debug_activate kernel/time/hrtimer.c:479 [inline]
       enqueue_hrtimer+0x35a/0x3c0 kernel/time/hrtimer.c:1085
       __hrtimer_start_range_ns kernel/time/hrtimer.c:1260 [inline]
       hrtimer_start_range_ns+0xac8/0xca0 kernel/time/hrtimer.c:1302
       hrtimer_start include/linux/hrtimer.h:275 [inline]
       perf_swevent_start_hrtimer kernel/events/core.c:11254 [inline]
       cpu_clock_event_start kernel/events/core.c:11312 [inline]
       cpu_clock_event_add+0x180/0x1a0 kernel/events/core.c:11324
       event_sched_in+0x832/0xe90 kernel/events/core.c:2620
       group_sched_in kernel/events/core.c:2653 [inline]
       merge_sched_in kernel/events/core.c:3931 [inline]
       visit_groups_merge+0x1521/0x2fd0 kernel/events/core.c:3876
       pmu_groups_sched_in kernel/events/core.c:3958 [inline]
       __pmu_ctx_sched_in+0x1aa/0x230 kernel/events/core.c:3970
       ctx_sched_in+0x4c2/0x600 kernel/events/core.c:4021
       ctx_resched+0x560/0x900 kernel/events/core.c:2807
       __perf_install_in_context+0x647/0x850 kernel/events/core.c:2882
       remote_function+0xef/0x170 kernel/events/core.c:92
       csd_do_func kernel/smp.c:134 [inline]
       generic_exec_single+0x336/0x9b0 kernel/smp.c:433
       smp_call_function_single+0x3fa/0x1990 kernel/smp.c:676
       task_function_call kernel/events/core.c:120 [inline]
       perf_install_in_context+0x71a/0xb20 kernel/events/core.c:2985
       __do_sys_perf_event_open kernel/events/core.c:13006 [inline]
       __se_sys_perf_event_open+0x31c5/0x38d0 kernel/events/core.c:12658
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  (console_sem).lock --> &rq->__lock --> hrtimer_bases.lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(hrtimer_bases.lock);
                               lock(&rq->__lock);
                               lock(hrtimer_bases.lock);
  lock((console_sem).lock);

 *** DEADLOCK ***

6 locks held by syz.0.575/7708:
 #0: ffff88802960b9d8 (&sig->exec_update_lock){++++}-{3:3}, at: __do_sys_perf_event_open kernel/events/core.c:12797 [inline]
 #0: ffff88802960b9d8 (&sig->exec_update_lock){++++}-{3:3}, at: __se_sys_perf_event_open+0xe64/0x38d0 kernel/events/core.c:12658
 #1: ffff88802fa6bca8 (&ctx->mutex){+.+.}-{3:3}, at: __do_sys_perf_event_open kernel/events/core.c:12821 [inline]
 #1: ffff88802fa6bca8 (&ctx->mutex){+.+.}-{3:3}, at: __se_sys_perf_event_open+0x13f9/0x38d0 kernel/events/core.c:12658
 #2: ffff8880b87376c8 (&cpuctx_lock){-.-.}-{2:2}, at: __perf_install_in_context+0xdc/0x850 kernel/events/core.c:2843
 #3: ffff88802fa6bc18 (&ctx->lock){-.-.}-{2:2}, at: __perf_install_in_context+0x110/0x850 kernel/events/core.c:2845
 #4: ffff8880b872c898 (hrtimer_bases.lock){-.-.}-{2:2}, at: lock_hrtimer_base kernel/time/hrtimer.c:175 [inline]
 #4: ffff8880b872c898 (hrtimer_bases.lock){-.-.}-{2:2}, at: hrtimer_start_range_ns+0x109/0xca0 kernel/time/hrtimer.c:1300
 #5: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #5: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #5: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2317 [inline]
 #5: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run2+0x1fc/0x540 kernel/trace/bpf_trace.c:2359

stack backtrace:
CPU: 1 UID: 0 PID: 7708 Comm: syz.0.575 Not tainted 6.11.0-syzkaller-g88264981f208 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2203
 check_prev_add kernel/locking/lockdep.c:3158 [inline]
 check_prevs_add kernel/locking/lockdep.c:3277 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3901
 __lock_acquire+0x1384/0x2050 kernel/locking/lockdep.c:5199
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 down_trylock+0x20/0xa0 kernel/locking/semaphore.c:139
 __down_trylock_console_sem+0x109/0x250 kernel/printk/printk.c:326
 console_trylock kernel/printk/printk.c:2827 [inline]
 console_trylock_spinning kernel/printk/printk.c:1990 [inline]
 vprintk_emit+0x3d7/0xa10 kernel/printk/printk.c:2406
 _printk+0xd5/0x120 kernel/printk/printk.c:2432
 fail_dump lib/fault-inject.c:46 [inline]
 should_fail_ex+0x391/0x4e0 lib/fault-inject.c:154
 strncpy_from_user+0x36/0x2e0 lib/strncpy_from_user.c:118
 strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
 bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:215 [inline]
 ____bpf_probe_read_user_str kernel/trace/bpf_trace.c:224 [inline]
 bpf_probe_read_user_str+0x2a/0x70 kernel/trace/bpf_trace.c:221
 bpf_prog_99b56f93a3ca5fea+0x4b/0x4d
 bpf_dispatcher_nop_func include/linux/bpf.h:1257 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2318 [inline]
 bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2359
 __traceiter_hrtimer_start+0x76/0xd0 include/trace/events/timer.h:222
 trace_hrtimer_start include/trace/events/timer.h:222 [inline]
 debug_activate kernel/time/hrtimer.c:479 [inline]
 enqueue_hrtimer+0x35a/0x3c0 kernel/time/hrtimer.c:1085
 __hrtimer_start_range_ns kernel/time/hrtimer.c:1260 [inline]
 hrtimer_start_range_ns+0xac8/0xca0 kernel/time/hrtimer.c:1302
 hrtimer_start include/linux/hrtimer.h:275 [inline]
 perf_swevent_start_hrtimer kernel/events/core.c:11254 [inline]
 cpu_clock_event_start kernel/events/core.c:11312 [inline]
 cpu_clock_event_add+0x180/0x1a0 kernel/events/core.c:11324
 event_sched_in+0x832/0xe90 kernel/events/core.c:2620
 group_sched_in kernel/events/core.c:2653 [inline]
 merge_sched_in kernel/events/core.c:3931 [inline]
 visit_groups_merge+0x1521/0x2fd0 kernel/events/core.c:3876
 pmu_groups_sched_in kernel/events/core.c:3958 [inline]
 __pmu_ctx_sched_in+0x1aa/0x230 kernel/events/core.c:3970
 ctx_sched_in+0x4c2/0x600 kernel/events/core.c:4021
 ctx_resched+0x560/0x900 kernel/events/core.c:2807
 __perf_install_in_context+0x647/0x850 kernel/events/core.c:2882
 remote_function+0xef/0x170 kernel/events/core.c:92
 csd_do_func kernel/smp.c:134 [inline]
 generic_exec_single+0x336/0x9b0 kernel/smp.c:433
 smp_call_function_single+0x3fa/0x1990 kernel/smp.c:676
 task_function_call kernel/events/core.c:120 [inline]
 perf_install_in_context+0x71a/0xb20 kernel/events/core.c:2985
 __do_sys_perf_event_open kernel/events/core.c:13006 [inline]
 __se_sys_perf_event_open+0x31c5/0x38d0 kernel/events/core.c:12658
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe33e17def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe33ef63038 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007fe33e335f80 RCX: 00007fe33e17def9
RDX: bfffffffffffffff RSI: 0000000000000000 RDI: 0000000020000180
RBP: 00007fe33ef63090 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007fe33e335f80 R15: 00007ffc48ab6e58
 </TASK>
CPU: 1 UID: 0 PID: 7708 Comm: syz.0.575 Not tainted 6.11.0-syzkaller-g88264981f208 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 fail_dump lib/fault-inject.c:53 [inline]
 should_fail_ex+0x3b0/0x4e0 lib/fault-inject.c:154
 strncpy_from_user+0x36/0x2e0 lib/strncpy_from_user.c:118
 strncpy_from_user_nofault+0x71/0x140 mm/maccess.c:186
 bpf_probe_read_user_str_common kernel/trace/bpf_trace.c:215 [inline]
 ____bpf_probe_read_user_str kernel/trace/bpf_trace.c:224 [inline]
 bpf_probe_read_user_str+0x2a/0x70 kernel/trace/bpf_trace.c:221
 bpf_prog_99b56f93a3ca5fea+0x4b/0x4d
 bpf_dispatcher_nop_func include/linux/bpf.h:1257 [inline]
 __bpf_prog_run include/linux/filter.h:701 [inline]
 bpf_prog_run include/linux/filter.h:708 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2318 [inline]
 bpf_trace_run2+0x2ec/0x540 kernel/trace/bpf_trace.c:2359
 __traceiter_hrtimer_start+0x76/0xd0 include/trace/events/timer.h:222
 trace_hrtimer_start include/trace/events/timer.h:222 [inline]
 debug_activate kernel/time/hrtimer.c:479 [inline]
 enqueue_hrtimer+0x35a/0x3c0 kernel/time/hrtimer.c:1085
 __hrtimer_start_range_ns kernel/time/hrtimer.c:1260 [inline]
 hrtimer_start_range_ns+0xac8/0xca0 kernel/time/hrtimer.c:1302
 hrtimer_start include/linux/hrtimer.h:275 [inline]
 perf_swevent_start_hrtimer kernel/events/core.c:11254 [inline]
 cpu_clock_event_start kernel/events/core.c:11312 [inline]
 cpu_clock_event_add+0x180/0x1a0 kernel/events/core.c:11324
 event_sched_in+0x832/0xe90 kernel/events/core.c:2620
 group_sched_in kernel/events/core.c:2653 [inline]
 merge_sched_in kernel/events/core.c:3931 [inline]
 visit_groups_merge+0x1521/0x2fd0 kernel/events/core.c:3876
 pmu_groups_sched_in kernel/events/core.c:3958 [inline]
 __pmu_ctx_sched_in+0x1aa/0x230 kernel/events/core.c:3970
 ctx_sched_in+0x4c2/0x600 kernel/events/core.c:4021
 ctx_resched+0x560/0x900 kernel/events/core.c:2807
 __perf_install_in_context+0x647/0x850 kernel/events/core.c:2882
 remote_function+0xef/0x170 kernel/events/core.c:92
 csd_do_func kernel/smp.c:134 [inline]
 generic_exec_single+0x336/0x9b0 kernel/smp.c:433
 smp_call_function_single+0x3fa/0x1990 kernel/smp.c:676
 task_function_call kernel/events/core.c:120 [inline]
 perf_install_in_context+0x71a/0xb20 kernel/events/core.c:2985
 __do_sys_perf_event_open kernel/events/core.c:13006 [inline]
 __se_sys_perf_event_open+0x31c5/0x38d0 kernel/events/core.c:12658
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe33e17def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe33ef63038 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007fe33e335f80 RCX: 00007fe33e17def9
RDX: bfffffffffffffff RSI: 0000000000000000 RDI: 0000000020000180
RBP: 00007fe33ef63090 R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000000 R14: 00007fe33e335f80 R15: 00007ffc48ab6e58
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


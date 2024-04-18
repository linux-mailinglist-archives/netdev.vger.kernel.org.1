Return-Path: <netdev+bounces-89395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B04FC8AA36B
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 21:53:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A6732874E0
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 19:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4415219DF55;
	Thu, 18 Apr 2024 19:49:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B01184127
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 19:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713469764; cv=none; b=VTG3UGpkh1iCNqANOJFT0Ro7sYZP7I/C+wmKiqrqghSwHkhuwyfNLPZSI+4Pawnae+GoSGyJT7H3iIHtyvLNty6Te7cqwNPRcM8rr0H5TpeDpYkSHmaA3cLrKTQCAHDoCbbWZB+x0llHiMSPl3L45fhrK+p4iFXsLq27XQP+UxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713469764; c=relaxed/simple;
	bh=z19mW6qTZfZbfrbyLqR6xWcNYaNFAHqFswaD+QTI1Mk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=MoGnYSAOYosmQiOBVbLqF5bHy1ulvRP3A4lh0Mgvwxk6Zc1sIRZqeGoI30xZed+Nygul+tfVbgtw+yGvqS5zZnbDcZtMajJfNMbEDAfKbeDXatn2Fxn1JA1L9oMP2KhQOTXYgEztGFtYgDTE9dWoPLQfj/GDEUAKoI4IIeBoLZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7da42b980e9so40014339f.1
        for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 12:49:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713469762; x=1714074562;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lx2lfu92VvlIcFboRX1aSCjCk1LvRsraXbwJor+JgDQ=;
        b=tdX15ts6xeezrFIklGduyyJBWzQaxriNkEiqBT6jCI/Bvn8GOG/zJ2eUUPIwGc7KI1
         4wEKEn/gV0dYAht2hYLxJHIHq5dsv3m9hZGpx86XDy6twhP7P82e3gQEDwunDnDI8Vf8
         EpWz/hyG5Drsc5JyzN5TRUBDCWzGHU/rzqo1zmKitTT8XqZGiF154C/JKHFuEfrHrHfL
         41WM9J43m5rSJQl/5sfI9e9B8a/l/1bk4bbfWbqqbUKGzt3QGuKkEDLyfJmAkhGVkZli
         HceSlws9Rqk6+/SLRNj0zwbW2xiNcOUXnZOqOqd/AH/SvDHMQKeDt2rfI3f0aJ/23riT
         IxGQ==
X-Forwarded-Encrypted: i=1; AJvYcCXZQ7XSqhKx8lnd1Q//aLXuMVwlOuFW6F4k1xZQNyCQOOqLH2hb+huWJSnwxBICCE6SLWwo6Y6R51yfPgCOGDJcKjLdAklI
X-Gm-Message-State: AOJu0YzM4Li9MUla/8wD6WVZUBexZGpVRVJ2sUIfWMdw1nFhxLlRpB7s
	DYzA/BqhHZzCU4OX7vtBLSadkxbLJNaql9Fcwi5+rk0j2DC18UglxjyMqRrigX1WdokELRV4mpB
	rErjpD0w8VbyP5Ivjyd6Td7a+F/k23XFJy8yuzOIkZFqwllyq+e8Yab0=
X-Google-Smtp-Source: AGHT+IH7qEWStHARNkfjepKJJvCl717mn6Sf/GDHsz0AauSM3xT4RTr5N9918wgnz1EwOEAKPksUQn2IpOuDHiY2UJ4J1WtxY3Tg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:8726:b0:482:fcbc:c131 with SMTP id
 iw38-20020a056638872600b00482fcbcc131mr252814jab.0.1713469761924; Thu, 18 Apr
 2024 12:49:21 -0700 (PDT)
Date: Thu, 18 Apr 2024 12:49:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007e3fd2061664443e@google.com>
Subject: [syzbot] [perf?] WARNING: suspicious RCU usage in __schedule (2)
From: syzbot <syzbot+ae891a39094db8049d6c@syzkaller.appspotmail.com>
To: acme@kernel.org, adrian.hunter@intel.com, 
	alexander.shishkin@linux.intel.com, irogers@google.com, jolsa@kernel.org, 
	linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	mark.rutland@arm.com, mingo@redhat.com, namhyung@kernel.org, 
	netdev@vger.kernel.org, peterz@infradead.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
git tree:       bpf
console output: https://syzkaller.appspot.com/x/log.txt?x=1348ceb3180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=ae891a39094db8049d6c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3f355021a085/disk-443574b0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/44cf4de7472a/vmlinux-443574b0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a99a36c7ad65/bzImage-443574b0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ae891a39094db8049d6c@syzkaller.appspotmail.com

=============================
WARNING: suspicious RCU usage
6.8.0-syzkaller-05236-g443574b03387 #0 Not tainted
-----------------------------
kernel/sched/core.c:5982 Illegal context switch in RCU-bh read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor.4/5285:
 #0: ffffffff94511910 (&pmus_srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:116 [inline]
 #0: ffffffff94511910 (&pmus_srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:215 [inline]
 #0: ffffffff94511910 (&pmus_srcu){.+.+}-{0:0}, at: perf_init_event kernel/events/core.c:11698 [inline]
 #0: ffffffff94511910 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc+0xacf/0x2130 kernel/events/core.c:12018

stack backtrace:
CPU: 1 PID: 5285 Comm: syz-executor.4 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
 schedule_debug kernel/sched/core.c:5982 [inline]
 __schedule+0x23b/0x4a20 kernel/sched/core.c:6629
 preempt_schedule_notrace+0x100/0x140 kernel/sched/core.c:7008
 preempt_schedule_notrace_thunk+0x1a/0x30 arch/x86/entry/thunk_64.S:13
 trace_contention_end+0x108/0x120 include/trace/events/lock.h:122
 __pv_queued_spin_lock_slowpath+0x939/0xc60 kernel/locking/qspinlock.c:560
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 lockdep_lock+0x1b0/0x2b0 kernel/locking/lockdep.c:144
 graph_lock+0x5/0x60 kernel/locking/lockdep.c:170
 mark_lock+0x15c/0x350 kernel/locking/lockdep.c:4659
 mark_usage kernel/locking/lockdep.c:4587 [inline]
 __lock_acquire+0x112d/0x1fd0 kernel/locking/lockdep.c:5091
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 percpu_down_write+0x57/0x320 kernel/locking/percpu-rwsem.c:229
 bp_constraints_lock+0xdd/0x1c0 kernel/events/hw_breakpoint.c:133
 reserve_bp_slot kernel/events/hw_breakpoint.c:600 [inline]
 register_perf_hw_breakpoint+0x90/0x250 kernel/events/hw_breakpoint.c:718
 hw_breakpoint_event_init+0x8d/0x110 kernel/events/hw_breakpoint.c:958
 perf_try_init_event+0x139/0x3f0 kernel/events/core.c:11668
 perf_init_event kernel/events/core.c:11738 [inline]
 perf_event_alloc+0xeed/0x2130 kernel/events/core.c:12018
 __do_sys_perf_event_open kernel/events/core.c:12525 [inline]
 __se_sys_perf_event_open+0x7f9/0x38d0 kernel/events/core.c:12416
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f1ad6e7de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1ad7c780c8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007f1ad6fabf80 RCX: 00007f1ad6e7de69
RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000020000180
RBP: 00007f1ad6eca47a R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f1ad6fabf80 R15: 00007fff0dbffce8
 </TASK>

=============================
WARNING: suspicious RCU usage
6.8.0-syzkaller-05236-g443574b03387 #0 Not tainted
-----------------------------
kernel/sched/core.c:5982 Illegal context switch in RCU-sched read-side critical section!

other info that might help us debug this:


rcu_scheduler_active = 2, debug_locks = 1
1 lock held by syz-executor.4/5285:
 #0: ffffffff94511910 (&pmus_srcu){.+.+}-{0:0}, at: srcu_lock_acquire include/linux/srcu.h:116 [inline]
 #0: ffffffff94511910 (&pmus_srcu){.+.+}-{0:0}, at: srcu_read_lock include/linux/srcu.h:215 [inline]
 #0: ffffffff94511910 (&pmus_srcu){.+.+}-{0:0}, at: perf_init_event kernel/events/core.c:11698 [inline]
 #0: ffffffff94511910 (&pmus_srcu){.+.+}-{0:0}, at: perf_event_alloc+0xacf/0x2130 kernel/events/core.c:12018

stack backtrace:
CPU: 1 PID: 5285 Comm: syz-executor.4 Not tainted 6.8.0-syzkaller-05236-g443574b03387 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 lockdep_rcu_suspicious+0x221/0x340 kernel/locking/lockdep.c:6712
 schedule_debug kernel/sched/core.c:5982 [inline]
 __schedule+0x28a/0x4a20 kernel/sched/core.c:6629
 preempt_schedule_notrace+0x100/0x140 kernel/sched/core.c:7008
 preempt_schedule_notrace_thunk+0x1a/0x30 arch/x86/entry/thunk_64.S:13
 trace_contention_end+0x108/0x120 include/trace/events/lock.h:122
 __pv_queued_spin_lock_slowpath+0x939/0xc60 kernel/locking/qspinlock.c:560
 pv_queued_spin_lock_slowpath arch/x86/include/asm/paravirt.h:584 [inline]
 queued_spin_lock_slowpath+0x42/0x50 arch/x86/include/asm/qspinlock.h:51
 queued_spin_lock include/asm-generic/qspinlock.h:114 [inline]
 lockdep_lock+0x1b0/0x2b0 kernel/locking/lockdep.c:144
 graph_lock+0x5/0x60 kernel/locking/lockdep.c:170
 mark_lock+0x15c/0x350 kernel/locking/lockdep.c:4659
 mark_usage kernel/locking/lockdep.c:4587 [inline]
 __lock_acquire+0x112d/0x1fd0 kernel/locking/lockdep.c:5091
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 percpu_down_write+0x57/0x320 kernel/locking/percpu-rwsem.c:229
 bp_constraints_lock+0xdd/0x1c0 kernel/events/hw_breakpoint.c:133
 reserve_bp_slot kernel/events/hw_breakpoint.c:600 [inline]
 register_perf_hw_breakpoint+0x90/0x250 kernel/events/hw_breakpoint.c:718
 hw_breakpoint_event_init+0x8d/0x110 kernel/events/hw_breakpoint.c:958
 perf_try_init_event+0x139/0x3f0 kernel/events/core.c:11668
 perf_init_event kernel/events/core.c:11738 [inline]
 perf_event_alloc+0xeed/0x2130 kernel/events/core.c:12018
 __do_sys_perf_event_open kernel/events/core.c:12525 [inline]
 __se_sys_perf_event_open+0x7f9/0x38d0 kernel/events/core.c:12416
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f1ad6e7de69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f1ad7c780c8 EFLAGS: 00000246 ORIG_RAX: 000000000000012a
RAX: ffffffffffffffda RBX: 00007f1ad6fabf80 RCX: 00007f1ad6e7de69
RDX: 0000000000000000 RSI: ffffffffffffffff RDI: 0000000020000180
RBP: 00007f1ad6eca47a R08: 0000000000000000 R09: 0000000000000000
R10: ffffffffffffffff R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f1ad6fabf80 R15: 00007fff0dbffce8
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


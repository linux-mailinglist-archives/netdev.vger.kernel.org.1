Return-Path: <netdev+bounces-185871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1618DA9BF62
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 09:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 197441B64B49
	for <lists+netdev@lfdr.de>; Fri, 25 Apr 2025 07:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABEC222F395;
	Fri, 25 Apr 2025 07:09:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEBFA22F3BE
	for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 07:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745564980; cv=none; b=UrIwVd5nsMrB1mX8RpMc679pKe0TNyJESB1pfmwUsRF+zjuhRvknzsG4MrCCnKOLEDm0KujjSadtOZhL+GPPJZfhAwMxbTB0sAjHQCbrFqW838CbNoDyrUzC403/wYn7ylnLVPltLBieUHMcmfcZRq8+whAxPagbAeHHUff20TU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745564980; c=relaxed/simple;
	bh=xx4FggphWlc5tildOMi3gmGwn1EpWCfAqq6rlD0XiyI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=EU+BWvqJdbQ68lthWKU5i84OJ7oW2SfmVKkaOTcB2PFO9um+A/5Hqj7pMOEs8wB8d1TBCgfA31WrDibXOG3QWNWoKqmGA2sPD/vrpqPk3HBFk26DUOA7e0uvoqXIHvViGoLE/cb/ll7HtTi385knYKy0As0C/PCkBejWwj8L3Tk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d43d333855so19164925ab.0
        for <netdev@vger.kernel.org>; Fri, 25 Apr 2025 00:09:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745564978; x=1746169778;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=JuMGdO7tj9pfcgeSkM1hIOwSR02/KINreWPYKsu6KZ4=;
        b=oPqAeljujBiLGANgsF/X+Xdh4ZNBNVH1opWP0G9VouW4Wlru6aoXgjKYLNdSbvvuci
         jKMmLoM8saNail8ol0AlflYEOVbcaBzihRxPCKbgwwsGNIeRSUd9oeQZ8rPckc54kcTd
         ch8xR9b3rfNTc1hAnLLgvYhef5UzVGAVQTc4DYWEy19/R3Tgaio6kqahjWoAwjS7BRuI
         tLEh+403d7BDZq9O9kVwsrzpsWOLayXn+kij27e0lIoXeAojX0iPwRnFbbiRPpCToese
         wqf+AvUix5ebzjF2/7Xmm+7xI5Q0kia6ALD3tI4w981FepczxQervb7u169U+h43nkx+
         Ci7A==
X-Forwarded-Encrypted: i=1; AJvYcCWEw+sFjzM/2Qcc9c/BzLPwEoIB2HBV9ag5z6BLwksdbSL926dhbyJP1uOffZ4PtXW+hoeYomI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMg3PGTsQF5q/U8+u83Tax5oYbTiApDItoUS27Agk1dBAqWTnn
	8OQa9DdGP0h4vJb9tq9pZUn66ybJafDHkxAJDADfq2X2tT3mkeCpUt8uwNVjZPxqd0EdQm+8NR5
	Zw9kj22uM8qR8Lw9pFnr+vWDTSqz7p/XznF4l5zxaRoTHl6xmtRzFdk4=
X-Google-Smtp-Source: AGHT+IEywZEMj7N5BOdWQpG2Ine7Jd8YZEo11eImJbUohPlO28ID38004mXuXo4StVPj8Xr+MeGDiNTbfHGFNR3DfvYrAClKte/z
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:221b:b0:3d8:1d2d:60ab with SMTP id
 e9e14a558f8ab-3d93b3c15c1mr12219745ab.3.1745564977827; Fri, 25 Apr 2025
 00:09:37 -0700 (PDT)
Date: Fri, 25 Apr 2025 00:09:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <680b3531.050a0220.10d98e.0011.GAE@google.com>
Subject: [syzbot] [mm?] INFO: task hung in exit_mmap (2)
From: syzbot <syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com>
To: Liam.Howlett@oracle.com, akpm@linux-foundation.org, andrii@kernel.org, 
	ast@kernel.org, dvyukov@google.com, eddyz87@gmail.com, elver@google.com, 
	glider@google.com, jannh@google.com, kasan-dev@googlegroups.com, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, lorenzo.stoakes@oracle.com, 
	netdev@vger.kernel.org, sdf@google.com, syzkaller-bugs@googlegroups.com, 
	vbabka@suse.cz
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    750d0ac001e8 MAINTAINERS: Add entry for Socfpga DWMAC ethe..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15580ccc580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2a31f7155996562
dashboard link: https://syzkaller.appspot.com/bug?extid=cdd6c0925e12b0af60cc
compiler:       Debian clang version 15.0.6, Debian LLD 15.0.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1082263f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10809ccc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/61fe708710bd/disk-750d0ac0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7e7cb0c4c97b/vmlinux-750d0ac0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/93c49eac7367/bzImage-750d0ac0.xz

The issue was bisected to:

commit 68ca5d4eebb8c4de246ee5f634eee26bc689562d
Author: Andrii Nakryiko <andrii@kernel.org>
Date:   Tue Mar 19 23:38:50 2024 +0000

    bpf: support BPF cookie in raw tracepoint (raw_tp, tp_btf) programs

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=17849a6f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14449a6f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=10449a6f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+cdd6c0925e12b0af60cc@syzkaller.appspotmail.com
Fixes: 68ca5d4eebb8 ("bpf: support BPF cookie in raw tracepoint (raw_tp, tp_btf) programs")

INFO: task syz-executor253:8529 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc2-syzkaller-00258-g750d0ac001e8 #0
      Blocked by coredump.
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor253 state:D stack:24424 pid:8529  tgid:8527  ppid:5850   task_flags:0x40054c flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x1b88/0x5240 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0x163/0x360 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 rwsem_down_write_slowpath+0xedd/0x1420 kernel/locking/rwsem.c:1176
 __down_write_common kernel/locking/rwsem.c:1304 [inline]
 __down_write kernel/locking/rwsem.c:1313 [inline]
 down_write+0x1da/0x220 kernel/locking/rwsem.c:1578
 mmap_write_lock include/linux/mmap_lock.h:128 [inline]
 exit_mmap+0x305/0xde0 mm/mmap.c:1292
 __mmput+0x115/0x420 kernel/fork.c:1379
 exit_mm+0x221/0x310 kernel/exit.c:589
 do_exit+0x994/0x27f0 kernel/exit.c:940
 do_group_exit+0x207/0x2c0 kernel/exit.c:1102
 get_signal+0x1696/0x1730 kernel/signal.c:3034
 arch_do_signal_or_restart+0x98/0x810 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xce/0x340 kernel/entry/common.c:218
 do_syscall_64+0x100/0x210 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0e7faaa6e9
RSP: 002b:00007f0e7fa42218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f0e7fb34338 RCX: 00007f0e7faaa6e9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f0e7fb34338
RBP: 00007f0e7fb34330 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f0e7fb01074
R13: 0000200000000040 R14: 00002000000002c0 R15: 00002000000002c8
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff8ed3df20 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x30/0x180 kernel/locking/lockdep.c:6764
2 locks held by dhcpcd/5506:
 #0: ffffffff8edf61b0 (dup_mmap_sem){.+.+}-{0:0}, at: dup_mm kernel/fork.c:1733 [inline]
 #0: ffffffff8edf61b0 (dup_mmap_sem){.+.+}-{0:0}, at: copy_mm+0x1d6/0x22c0 kernel/fork.c:1786
 #1: ffff88805a8a3de0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:146 [inline]
 #1: ffff88805a8a3de0 (&mm->mmap_lock){++++}-{4:4}, at: dup_mmap kernel/fork.c:620 [inline]
 #1: ffff88805a8a3de0 (&mm->mmap_lock){++++}-{4:4}, at: dup_mm kernel/fork.c:1734 [inline]
 #1: ffff88805a8a3de0 (&mm->mmap_lock){++++}-{4:4}, at: copy_mm+0x2a8/0x22c0 kernel/fork.c:1786
2 locks held by getty/5594:
 #0: ffff8880319c50a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x5bb/0x1700 drivers/tty/n_tty.c:2222
1 lock held by syz-executor253/8529:
 #0: ffff88807b09bde0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock include/linux/mmap_lock.h:128 [inline]
 #0: ffff88807b09bde0 (&mm->mmap_lock){++++}-{4:4}, at: exit_mmap+0x305/0xde0 mm/mmap.c:1292
1 lock held by dhcpcd/8530:
 #0: ffff8880253947e0 (&mm->mmap_lock){++++}-{4:4}, at: mmap_write_lock_killable include/linux/mmap_lock.h:146 [inline]
 #0: ffff8880253947e0 (&mm->mmap_lock){++++}-{4:4}, at: __vm_munmap+0x213/0x520 mm/vma.c:3010

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 31 Comm: khungtaskd Not tainted 6.15.0-rc2-syzkaller-00258-g750d0ac001e8 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x4ab/0x4e0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:274 [inline]
 watchdog+0x1058/0x10a0 kernel/hung_task.c:437
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted 6.15.0-rc2-syzkaller-00258-g750d0ac001e8 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:pv_native_safe_halt+0x13/0x20 arch/x86/kernel/paravirt.c:81
Code: cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 73 8f 18 00 f3 0f 1e fa fb f4 <c3> cc cc cc cc cc cc cc cc cc cc cc cc 90 90 90 90 90 90 90 90 90
RSP: 0018:ffffc90000197dc0 EFLAGS: 000002c2
RAX: 330d1d9510403d00 RBX: ffffffff8197272e RCX: ffffffff8c2fa93c
RDX: 0000000000000001 RSI: ffffffff8e6499b7 RDI: ffffffff8ca1b5a0
RBP: ffffc90000197f20 R08: ffff8880b8732b5b R09: 1ffff110170e656b
R10: dffffc0000000000 R11: ffffed10170e656c R12: 1ffff92000032fd2
R13: 1ffff11003ad9b40 R14: 0000000000000001 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88812509a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6b30e296c0 CR3: 000000000eb38000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:748
 default_idle_call+0x74/0xb0 kernel/sched/idle.c:117
 cpuidle_idle_call kernel/sched/idle.c:185 [inline]
 do_idle+0x22e/0x5d0 kernel/sched/idle.c:325
 cpu_startup_entry+0x42/0x60 kernel/sched/idle.c:423
 start_secondary+0xfe/0x100 arch/x86/kernel/smpboot.c:315
 common_startup_64+0x13e/0x147
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


Return-Path: <netdev+bounces-193390-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 811D2AC3BFD
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 10:50:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 280A47A8CFA
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 08:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF47F1E9B0B;
	Mon, 26 May 2025 08:50:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2984E1E32D3
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 08:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748249431; cv=none; b=h8hlIbRtw02t/Zn0nL5qe6BQKvS4zpyab8/IKeeMlqpHObsdyvyyCb7eQK8zqHEu17ZJFfk/Lmq/4fhB5fd3c9Ug1lYjHFW5jZdAz5CFWXypyYuoxQK6JGCbMxcYO1Dux1ZvH6d0o5wUcLhyu6mAP+87BoXVHZc1jLonh79Dlvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748249431; c=relaxed/simple;
	bh=ES/5VMJTP0/Z8pCLa0ZMn49fZz2+QHoH8ccAMIZSAvM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HwBWz/vWSM8/rsbGE9wodgRNY0BsyT45CtH4CYFRBb7ivjvIn3CVrlQfBK1YEWiBSE+P+RP6fFvIJ35X+FF5iLQGQUX8LLvKl7OQwBlfvJCY3OvyDx3sf1nEiLL5MXGPVcRwy+FdTvq/cucig6pHatbjdDsqfcEIJgHu5o/46VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-85e318dc464so359107739f.1
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 01:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748249429; x=1748854229;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w9c7v6E+/GQRM3UlZ2T/jgFX7EYWeznAGMdtx6v4y64=;
        b=gxS1sHRW1s+HuVQZlw8NTFefOHhQPOR06OKTOVsqK8OuFTJ5E6mw+CdEGLH3+bv8fo
         yA7jH8T4RxY9nAWhPxbL8/IcAgp8HouVnO9YZUDHv/T5VHHoBzUT9mDYcnU328M2/yEc
         ntjFqJ+TyN6UC6K+PThx5qhM3Ad0zd1na1Dg0+xO8NayUppODPk2N0Sf7Ku+YVNL2Meq
         knsrIp4gbjo66oVmyn8UiBQxRvsMUoNz8MBu3TZzFIey4iUjcvvOkRogvOG12kkl0t6E
         OHXL18dwjWC377Qa8BRk6lhdAMZBrZ8m7KRWU0dBe1BQY3fEAyfBvMsDQxyNNp8Nk0M9
         rAEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXrMujJoiDV43VUU0MGdbADLwXolnn5m0JcKfvSk+6/tbNfG4IjYihgNrwlZOy5N2y4+Hs6UW0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzF/mSYz6XEBVT4Rb3FlXZQMWkySLNLtVtZLobney/GF6i0LeG+
	zuXQFDcqBqpsAmvQ//rfLbUNQNE1zIQoSdTgKDWkLED8/ooW1aeUSaJDo0EUMXyxzD4NVxhHRiE
	HHen94ur0jG34hPi4sRPe+hJrfOnRhrh7EqVZIjmGoI2FR4OzPaPw2EGO//s=
X-Google-Smtp-Source: AGHT+IGvIUT1xTNpT2S4TzLOsjICT6VfN3kGiDfl4z4bFL9GGjdt2D0AnhMoDSq8jPM5Zp0BG/b77PAQqHdAho7pF93TUN66OS1n
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:3817:b0:85d:f316:fabc with SMTP id
 ca18e2360f4ac-86cbb8a2d4amr767738939f.8.1748249429183; Mon, 26 May 2025
 01:50:29 -0700 (PDT)
Date: Mon, 26 May 2025 01:50:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68342b55.a70a0220.253bc2.0091.GAE@google.com>
Subject: [syzbot] [tipc?] WARNING: refcount bug in tipc_crypto_xmit
From: syzbot <syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jmaloy@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, wangliang74@huawei.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b1427432d3b6 Merge tag 'iommu-fixes-v6.15-rc7' of git://gi..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17ba35f4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9fd1c9848687d742
dashboard link: https://syzkaller.appspot.com/bug?extid=f0c4a4aba757549ae26c
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=161ee170580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=164328e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/48a582dac9f0/disk-b1427432.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/94ad5463a7f5/vmlinux-b1427432.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4d0af31b0b08/bzImage-b1427432.xz

The issue was bisected to:

commit e279024617134c94fd3e37470156534d5f2b3472
Author: Wang Liang <wangliang74@huawei.com>
Date:   Tue May 20 10:14:04 2025 +0000

    net/tipc: fix slab-use-after-free Read in tipc_aead_encrypt_done

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10018df4580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=12018df4580000
console output: https://syzkaller.appspot.com/x/log.txt?x=14018df4580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f0c4a4aba757549ae26c@syzkaller.appspotmail.com
Fixes: e27902461713 ("net/tipc: fix slab-use-after-free Read in tipc_aead_encrypt_done")

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: CPU: 1 PID: 36 at lib/refcount.c:25 refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:25
Modules linked in:
CPU: 1 UID: 0 PID: 36 Comm: kworker/u8:2 Not tainted 6.15.0-rc7-syzkaller-00144-gb1427432d3b6 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Workqueue: netns cleanup_net
RIP: 0010:refcount_warn_saturate+0xfa/0x1d0 lib/refcount.c:25
Code: 00 00 e8 79 f6 06 fd 5b 41 5e e9 81 6c a0 06 cc e8 6b f6 06 fd c6 05 06 3c b0 0a 01 90 48 c7 c7 80 aa c1 8b e8 e7 52 cb fc 90 <0f> 0b 90 90 eb d7 e8 4b f6 06 fd c6 05 e7 3b b0 0a 01 90 48 c7 c7
RSP: 0018:ffffc90000a08668 EFLAGS: 00010246
RAX: bb5b0788a28fc300 RBX: 0000000000000002 RCX: ffff888142681e00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000002
RBP: ffffc90000a087e8 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bba984 R12: ffff88807df80000
R13: dffffc0000000000 R14: ffff88807df8016c R15: ffff888033397800
FS:  0000000000000000(0000) GS:ffff8881261c2000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555569a1e878 CR3: 000000007b8fc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 __refcount_add include/linux/refcount.h:-1 [inline]
 __refcount_inc include/linux/refcount.h:366 [inline]
 refcount_inc include/linux/refcount.h:383 [inline]
 get_net include/net/net_namespace.h:268 [inline]
 tipc_aead_encrypt net/tipc/crypto.c:821 [inline]
 tipc_crypto_xmit+0x1820/0x22c0 net/tipc/crypto.c:1761
 tipc_crypto_clone_msg+0x90/0x170 net/tipc/crypto.c:1656
 tipc_crypto_xmit+0x1998/0x22c0 net/tipc/crypto.c:1717
 tipc_bearer_xmit_skb+0x245/0x400 net/tipc/bearer.c:572
 tipc_disc_timeout+0x580/0x6d0 net/tipc/discover.c:338
 call_timer_fn+0x17b/0x5f0 kernel/time/timer.c:1789
 expire_timers kernel/time/timer.c:1840 [inline]
 __run_timers kernel/time/timer.c:2414 [inline]
 __run_timer_base+0x61a/0x860 kernel/time/timer.c:2426
 run_timer_base kernel/time/timer.c:2435 [inline]
 run_timer_softirq+0xb7/0x180 kernel/time/timer.c:2445
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x175/0x360 kernel/locking/lockdep.c:5870
Code: 00 00 00 00 9c 8f 44 24 30 f7 44 24 30 00 02 00 00 0f 85 cd 00 00 00 f7 44 24 08 00 02 00 00 74 01 fb 65 48 8b 05 8b 9f d7 10 <48> 3b 44 24 58 0f 85 f2 00 00 00 48 83 c4 60 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc90000ad7378 EFLAGS: 00000206
RAX: bb5b0788a28fc300 RBX: 0000000000000000 RCX: bb5b0788a28fc300
RDX: 0000000000000000 RSI: ffffffff8d939072 RDI: ffffffff8bc1f600
RBP: ffffffff8171ca05 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: ffffffff8171ca05 R12: 0000000000000002
R13: ffffffff8df3dee0 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:841 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1155 [inline]
 unwind_next_frame+0xc2/0x2390 arch/x86/kernel/unwind_orc.c:479
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack+0x3e/0x60 mm/kasan/common.c:47
 kasan_record_aux_stack+0xbc/0xd0 mm/kasan/generic.c:548
 __call_rcu_common kernel/rcu/tree.c:3082 [inline]
 call_rcu+0x142/0x990 kernel/rcu/tree.c:3202
 inet_release+0x187/0x210 net/ipv4/af_inet.c:435
 __sock_release net/socket.c:647 [inline]
 sock_release+0x85/0x150 net/socket.c:675
 wg_netns_pre_exit+0xd6/0x1d0 drivers/net/wireguard/device.c:423
 ops_pre_exit_list net/core/net_namespace.c:162 [inline]
 cleanup_net+0x594/0xbd0 net/core/net_namespace.c:634
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xadb/0x17a0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	9c                   	pushf
   5:	8f 44 24 30          	pop    0x30(%rsp)
   9:	f7 44 24 30 00 02 00 	testl  $0x200,0x30(%rsp)
  10:	00
  11:	0f 85 cd 00 00 00    	jne    0xe4
  17:	f7 44 24 08 00 02 00 	testl  $0x200,0x8(%rsp)
  1e:	00
  1f:	74 01                	je     0x22
  21:	fb                   	sti
  22:	65 48 8b 05 8b 9f d7 	mov    %gs:0x10d79f8b(%rip),%rax        # 0x10d79fb5
  29:	10
* 2a:	48 3b 44 24 58       	cmp    0x58(%rsp),%rax <-- trapping instruction
  2f:	0f 85 f2 00 00 00    	jne    0x127
  35:	48 83 c4 60          	add    $0x60,%rsp
  39:	5b                   	pop    %rbx
  3a:	41 5c                	pop    %r12
  3c:	41 5d                	pop    %r13
  3e:	41 5e                	pop    %r14


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


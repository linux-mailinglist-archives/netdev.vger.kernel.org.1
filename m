Return-Path: <netdev+bounces-248637-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 85661D0C8C9
	for <lists+netdev@lfdr.de>; Sat, 10 Jan 2026 00:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D212B301F8C6
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 23:32:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3178933A033;
	Fri,  9 Jan 2026 23:32:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f77.google.com (mail-ot1-f77.google.com [209.85.210.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 686FF321F5E
	for <netdev@vger.kernel.org>; Fri,  9 Jan 2026 23:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768001544; cv=none; b=BJOpL5Y2VGETIY5LnV6ceU2qJCVSdZ5h+1lkDd2SALcY36lSiYIzM9u3MhTOp12BxIiFSB8V1YjPANwOeDjOyib6rWJnPU6b1aaPt61YzNR/YbbGYc6HIXDrWWdbF9tyvAlaq0Ay+OP9wQk4AwCLptrMFxDPyRMuuF+KkpA1LU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768001544; c=relaxed/simple;
	bh=HT/OtEk9SXQUo8ufs/xWknbLOcqp/zJBJS1BitICWu0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZqsgKPL09ejAjq0Yv3ip6H9cKmcrKdEtolBslUrjly5ZUNOij9PtYz3qT8uwTAh00DXDh6ID1PN+6Z/1lhJiMg4ldXdjRVueELMuI/Vu5quv7tJ+c9DV+Wv7WXskbdE4gecbFgIbYunnBFalpeUIyYg1kF/Yl7SFSlJglFWhAXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.210.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-ot1-f77.google.com with SMTP id 46e09a7af769-7c6d329f19cso12516687a34.1
        for <netdev@vger.kernel.org>; Fri, 09 Jan 2026 15:32:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768001541; x=1768606341;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4p0HdwK9I6S08khA1DAWn7KBs8VzTZvXnU2UwAgX6gk=;
        b=SFCZe8fTDAc6Lc6b6sMXeJxsodXeHeiX8R0T+ij2PXK4boWO4Pt7ITxa6sii9PdlwK
         6Hc0rtsnqnedGiJyYqRZN5k5xE7PFpRGy+Dp3HtMjolhszwEs+3NTp5Cw+8/Om3uu0HB
         C8qygSD5gFqqPX6XmDBZgNVNTf+KmxJSK6UBviFmm14WejfPtDcGSvZak5Lsbs+dNRTO
         Qg0p3Gmf8iTLpmcItuvr7X+SBstgVB2HHOEfKIcd+9BVZr8F1DAEd+lTdTYbsuCJ/oUQ
         vu/sGIM3K+9DcUz3l6pf2Lm86s7GtTcZ+XM5ynqV4JvRoH4u0pxLdgHCl77+3k23RO5t
         oWiA==
X-Forwarded-Encrypted: i=1; AJvYcCUSj5U38T5QsqWf1X1kxyTlPPCw6YLRRr0qGTHvqA/yJ/70xjcsZxCgYqF4yrQy7+6bKvcgmik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8wrVr+Jw/tbhyPAoucT9Lo0sQpVKOBi6oKb10ntKXh6m+Omsj
	N4YDODEHe2W+ojGlTthg/qY6g07RTh8ki+Rfocghm179EplAT9/iccPY0CxmgIQ/IpG8pokfAnU
	NLeV8mZp6RwmgOErEyy8ruAVe8w9VKuDUy2ZbP0P+PSHa6QAIkZckF7k+VVk=
X-Google-Smtp-Source: AGHT+IGpQIy+UV5LuEisb8pAel1caQp33fxZ1avwdgjAvyYetKkYTrJRwNrjWZZP+k3d9Zu21IWlguvV0+p6dzOcWCJW95TxX4hT
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1ca3:b0:65f:706c:72f2 with SMTP id
 006d021491bc7-65f706c7437mr360866eaf.37.1768001541108; Fri, 09 Jan 2026
 15:32:21 -0800 (PST)
Date: Fri, 09 Jan 2026 15:32:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69619005.050a0220.1c677c.03d8.GAE@google.com>
Subject: [syzbot] [net?] INFO: rcu detected stall in netlink_recvmsg (5)
From: syzbot <syzbot+3ad87d519fc52afbb1d5@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3609fa95fb0f Merge tag 'devicetree-fixes-for-6.19-2' of gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15552f92580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a11e0f726bfb6765
dashboard link: https://syzkaller.appspot.com/bug?extid=3ad87d519fc52afbb1d5
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13552f92580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1394ae9a580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/92a7817c3585/disk-3609fa95.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b0243ba76e7b/vmlinux-3609fa95.xz
kernel image: https://storage.googleapis.com/syzbot-assets/61a47c574b87/bzImage-3609fa95.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ad87d519fc52afbb1d5@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5191/1:b.el
rcu: 	(detected by 1, t=10502 jiffies, g=11677, q=274 ncpus=2)
task:udevd           state:R  running task     stack:26472 pid:5191  tgid:5191  ppid:1      task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1139/0x6150 kernel/sched/core.c:6863
 preempt_schedule_irq+0x51/0x90 kernel/sched/core.c:7190
 irqentry_exit+0x1d8/0x8c0 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:kasan_byte_accessible+0x18/0x30 mm/kasan/generic.c:212
Code: 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 48 b8 00 00 00 00 00 fc ff df 48 c1 ef 03 48 01 c7 0f b6 07 <3c> 07 0f 96 c0 c3 cc cc cc cc 66 66 2e 0f 1f 84 00 00 00 00 00 0f
RSP: 0018:ffffc90003a474a0 EFLAGS: 00000286
RAX: 0000000000000000 RBX: ffffffff8e3c96a0 RCX: 0000000000000002
RDX: 0000000000000000 RSI: ffffffff816cb681 RDI: fffffbfff1c792d4
RBP: ffffffff8e3c96a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000083b41 R12: ffffffff816cb681
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 __kasan_check_byte+0x13/0x50 mm/kasan/common.c:573
 kasan_check_byte include/linux/kasan.h:402 [inline]
 lock_acquire kernel/locking/lockdep.c:5842 [inline]
 lock_acquire+0xfc/0x330 kernel/locking/lockdep.c:5825
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:867 [inline]
 class_rcu_constructor include/linux/rcupdate.h:1195 [inline]
 unwind_next_frame+0xd1/0x20b0 arch/x86/kernel/unwind_orc.c:495
 arch_stack_walk+0x94/0x100 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x8e/0xc0 kernel/stacktrace.c:122
 kasan_save_stack+0x33/0x60 mm/kasan/common.c:57
 kasan_save_track+0x14/0x30 mm/kasan/common.c:78
 kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:584
 poison_slab_object mm/kasan/common.c:253 [inline]
 __kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
 kasan_slab_free include/linux/kasan.h:235 [inline]
 slab_free_hook mm/slub.c:2540 [inline]
 slab_free mm/slub.c:6670 [inline]
 kmem_cache_free+0x2d8/0x770 mm/slub.c:6781
 kfree_skbmem+0x1a4/0x1f0 net/core/skbuff.c:1130
 __kfree_skb net/core/skbuff.c:1197 [inline]
 consume_skb net/core/skbuff.c:1428 [inline]
 consume_skb+0xcc/0x100 net/core/skbuff.c:1422
 netlink_recvmsg+0x5b9/0xa90 net/netlink/af_netlink.c:1972
 sock_recvmsg_nosec net/socket.c:1078 [inline]
 sock_recvmsg+0x1f9/0x250 net/socket.c:1100
 ____sys_recvmsg+0x218/0x6b0 net/socket.c:2812
 ___sys_recvmsg+0x114/0x1a0 net/socket.c:2854
 __sys_recvmsg+0x16a/0x220 net/socket.c:2887
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd6b22a7407
RSP: 002b:00007fff89341350 EFLAGS: 00000202 ORIG_RAX: 000000000000002f
RAX: ffffffffffffffda RBX: 00007fd6b2aae880 RCX: 00007fd6b22a7407
RDX: 0000000000000000 RSI: 00007fff893413e0 RDI: 0000000000000004
RBP: 0000000000000001 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 000055ce9df56d80
R13: 00007fff893414a0 R14: 00007fff893413ec R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread starved for 10547 jiffies! g11677 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28584 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1139/0x6150 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6960
 schedule_timeout+0x123/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x1ea/0xaf0 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x26d/0x380 kernel/rcu/tree.c:2285
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x983/0xb10 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:82
Code: c6 5f 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 13 49 12 00 fb f4 <e9> cc 35 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0000:ffffffff8e007df8 EFLAGS: 000002c6
RAX: 0000000000138781 RBX: 0000000000000000 RCX: ffffffff8b7816d9
RDX: 0000000000000000 RSI: ffffffff8dace4f3 RDI: ffffffff8bf2b480
RBP: fffffbfff1c12f68 R08: 0000000000000001 R09: ffffed101708673d
R10: ffff8880b84339eb R11: ffffffff8e098670 R12: 0000000000000000
R13: ffffffff8e097b40 R14: ffffffff9088b9d0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8881248f5000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 000000001f76b000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000410
DR3: 0000000000000000 DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x38d/0x510 kernel/sched/idle.c:332
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
 rest_init+0x16b/0x2b0 init/main.c:757
 start_kernel+0x3ef/0x4d0 init/main.c:1206
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x130/0x190 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x148
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


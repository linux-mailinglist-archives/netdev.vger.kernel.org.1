Return-Path: <netdev+bounces-247851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 081CDCFF3B1
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 18:57:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E9013300856B
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 17:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 063FF361643;
	Wed,  7 Jan 2026 17:45:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D88C35EDAF
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 17:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767807938; cv=none; b=iAwD9VDXG3YZARAHCYxaw7CDKpN3bXEH8oqzud0UTg8QK2cdP1q5cvkxGhVhTvz+7drrwmQgbJH4EqJwkgFZVvoYghHqJkOWai7EZN9ZbC1ajD9g7Yi7uNCkYK79sPLXz+M4d8wcao1LrTmgBIN3SkwVmpANhgz8PYsC9JWLiFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767807938; c=relaxed/simple;
	bh=y7qlgi5FCfIg5h8R6G4wRvLYQ/GwBQvRAno9WcefIHA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fXY9dMnJNjseCrnJNqctVMN6i+IDKIXht/cT7PoOUwzSOGWaDPM/mYB7dhwaikVQhjYVQ2VhyglH+11dz3gC20WxtU0tl6cWY3UmGs+CXZgmm0QMKC9aPBoIhNgcAeeDTZOj2hbwZ1kcO4KWVe5ZIgoL2bdVZeOSQKxPA+PhwHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-65742f8c565so2794131eaf.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 09:45:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767807925; x=1768412725;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fhBZE90pN1WPps0XB/9jQq0y6KKN9THlceXQEv89BFI=;
        b=eflxM4efidBQVt2SFKlbBAWVbcadarmGBr1L+oZMkn3mmT8l4RsPNByWn7BeMYceXq
         sfk85V0nziM6HYe//x/FRzSMoQvQei4F+WfHuUaza/CV8XulbosBiToOsXUN/sOjwKtp
         6FcF5T+dQVk/Xjod738A/f6xj/oliCrtTREPHPw5/5TcSy7Iqe9gnxza3PRKXHR7HkjT
         7TVZN7YjMLimfJVQdMVYh0mD1wOdj6P944emOUrRIpl/d/QNokD36+qDWBeHLLQgbkku
         bvZrVefKqOuCF2XzrPjEw14H+oBCVWJlhNrud0rbO1l9oGX9WukwYIBuzSkA3oJ2bEFl
         ECpQ==
X-Forwarded-Encrypted: i=1; AJvYcCUKJSYMVTs/kc+8fAPG1NDX1+hw3lN5PXYZiRGpXCN1AOwBC069CVtqrvzXj+hkuD7Aoj2XG5A=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyuqr+vWAPTPe1efXMxRW7hj0spMrqpUbVRT97vCO8kZaBEIB86
	+C16tJqu+u2t0A3efUrDDmkg3AnSn/oRqW1Chj9vs9Fqt8RzGMV1Y8JYZ67BWiveXxjXX34N6Vv
	hzrOAl0apgY5UiVgLVKNH6IrvxED2koALkH+pIsywWGcWnGhcaZ6VZurjxEE=
X-Google-Smtp-Source: AGHT+IFOvEzLl68hqGMt8op0Z1up3rXV+tNZBFbEdezcspZ8HikeTq2OQL3AOAi0re28qUJm3yVI30s1oLplT3wRQ0FHNevowjp/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:812:b0:65c:fa23:2cfa with SMTP id
 006d021491bc7-65f54eea4bemr1339831eaf.3.1767807925172; Wed, 07 Jan 2026
 09:45:25 -0800 (PST)
Date: Wed, 07 Jan 2026 09:45:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695e9bb5.050a0220.1c677c.0372.GAE@google.com>
Subject: [syzbot] [net?] INFO: rcu detected stall in kernfs_fop_write_iter (3)
From: syzbot <syzbot+10b515098afdcfc455c7@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f8f97927abf7 Add linux-next specific files for 20260105
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=171a9e9a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a0672dd8d69c3235
dashboard link: https://syzkaller.appspot.com/bug?extid=10b515098afdcfc455c7
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14315efc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1837bbc8e23e/disk-f8f97927.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/07390717f7e4/vmlinux-f8f97927.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8f4a72ec80dc/bzImage-f8f97927.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10b515098afdcfc455c7@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5196/1:b..l
rcu: 	(detected by 1, t=10503 jiffies, g=30937, q=540 ncpus=2)
task:udevd           state:R  running task     stack:25016 pid:5196  tgid:5196  ppid:1      task_flags:0x400140 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5258 [inline]
 __schedule+0x14ed/0x5040 kernel/sched/core.c:6866
 preempt_schedule_irq+0x4d/0xa0 kernel/sched/core.c:7193
 irqentry_exit+0x5e3/0x670 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:__orc_find arch/x86/kernel/unwind_orc.c:103 [inline]
RIP: 0010:orc_find arch/x86/kernel/unwind_orc.c:238 [inline]
RIP: 0010:unwind_next_frame+0x530/0x23d0 arch/x86/kernel/unwind_orc.c:510
Code: b9 00 00 00 00 00 fc ff df 0f b6 04 08 84 c0 75 27 49 63 07 4c 01 f8 49 8d 4f 04 4c 39 e0 48 0f 46 e9 49 8d 47 fc 48 0f 47 d8 <4d> 0f 46 ef 48 39 dd 76 a2 e9 76 fd ff ff 44 89 f9 80 e1 07 80 c1
RSP: 0018:ffffc90002fd7398 EFLAGS: 00000202
RAX: ffffffff8fe5d87c RBX: ffffffff8fe5d87c RCX: ffffffff8fe5d884
RDX: ffffffff8fe5d87c RSI: ffffffff9067beb4 RDI: ffffffff8be25080
RBP: ffffffff8fe5d87c R08: 0000000000000003 R09: ffffffff8e33f2e0
R10: ffffc90002fd74b8 R11: ffffffff81aceae0 R12: ffffffff82390804
R13: ffffffff8fe5d87c R14: ffffc90002fd7468 R15: ffffffff8fe5d880
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:57 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:78
 unpoison_slab_object mm/kasan/common.c:340 [inline]
 __kasan_slab_alloc+0x6c/0x80 mm/kasan/common.c:366
 kasan_slab_alloc include/linux/kasan.h:253 [inline]
 slab_post_alloc_hook mm/slub.c:4953 [inline]
 slab_alloc_node mm/slub.c:5267 [inline]
 kmem_cache_alloc_noprof+0x37d/0x710 mm/slub.c:5274
 skb_clone+0x212/0x3a0 net/core/skbuff.c:2087
 do_one_broadcast net/netlink/af_netlink.c:1455 [inline]
 netlink_broadcast_filtered+0x6ae/0x1000 net/netlink/af_netlink.c:1533
 netlink_broadcast+0x37/0x50 net/netlink/af_netlink.c:1557
 uevent_net_broadcast_untagged lib/kobject_uevent.c:331 [inline]
 kobject_uevent_net_broadcast+0x378/0x560 lib/kobject_uevent.c:410
 kobject_uevent_env+0x55c/0x9f0 lib/kobject_uevent.c:608
 kobject_synth_uevent+0x527/0xb00 lib/kobject_uevent.c:207
 uevent_store+0x26/0x70 drivers/base/core.c:2773
 kernfs_fop_write_iter+0x3af/0x540 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f133aca7407
RSP: 002b:00007ffe24984120 EFLAGS: 00000202 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f133b437880 RCX: 00007f133aca7407
RDX: 0000000000000007 RSI: 0000564480d619e0 RDI: 000000000000000c
RBP: 0000564480d619e0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 0000000000000007
R13: 0000564480c80730 R14: 00007f133adefea0 R15: 00007ffe24984470
 </TASK>
rcu: rcu_preempt kthread starved for 10524 jiffies! g30937 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28248 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5258 [inline]
 __schedule+0x14ed/0x5040 kernel/sched/core.c:6866
 __schedule_loop kernel/sched/core.c:6948 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6963
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x11b0 kernel/rcu/tree.c:2095
 rcu_gp_kthread+0x9b/0x2d0 kernel/rcu/tree.c:2297
 kthread+0x389/0x480 kernel/kthread.c:467
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 11808 Comm: syz.3.2836 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:cpu_max_bits_warn include/linux/cpumask.h:138 [inline]
RIP: 0010:cpumask_check include/linux/cpumask.h:145 [inline]
RIP: 0010:cpumask_test_cpu include/linux/cpumask.h:649 [inline]
RIP: 0010:cpu_online include/linux/cpumask.h:1231 [inline]
RIP: 0010:trace_x86_fpu_regs_activated arch/x86/include/asm/trace/fpu.h:47 [inline]
RIP: 0010:fpregs_activate+0x33/0x1c0 arch/x86/kernel/fpu/context.h:50
Code: e8 62 22 57 00 48 c7 c7 00 a0 85 8b e8 66 a8 fc 09 65 48 89 1d ee 5f 5c 11 0f 1f 44 00 00 e8 44 22 57 00 65 8b 1d f1 2a 5c 11 <bf> 07 00 00 00 89 de e8 71 26 57 00 83 fb 07 77 5d e8 27 22 57 00
RSP: 0018:ffffc900043bfa90 EFLAGS: 00000293
RAX: ffffffff8169d53c RBX: 0000000000000000 RCX: ffff888024fadac0
RDX: 0000000000000000 RSI: ffffffff8b85a000 RDI: ffffffff8be250e0
RBP: 0000000000000000 R08: ffff888024fadac7 R09: 1ffff110049f5b58
R10: dffffc0000000000 R11: ffffed10049f5b59 R12: ffffffff816a0cdb
R13: dffffc0000000000 R14: ffff888024faf440 R15: dffffc0000000000
FS:  00007fe31cefa6c0(0000) GS:ffff8881259c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000058 CR3: 0000000076344000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 fpregs_mark_activate+0x64/0xe0 arch/x86/kernel/fpu/core.c:903
 restore_fpregs_from_user arch/x86/kernel/fpu/signal.c:317 [inline]
 __fpu_restore_sig arch/x86/kernel/fpu/signal.c:346 [inline]
 fpu__restore_sig+0x95b/0x10d0 arch/x86/kernel/fpu/signal.c:480
 restore_sigcontext arch/x86/kernel/signal_64.c:95 [inline]
 __ia32_sys_rt_sigreturn+0x704/0x860 arch/x86/kernel/signal_64.c:268
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe31bf8f747
Code: ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 <0f> 05 48 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89
RSP: 002b:00007fe31cefa0e8 EFLAGS: 00000246
RAX: 00000000000000ca RBX: 00007fe31c1e5fa8 RCX: 00007fe31bf8f749
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fe31c1e5fa8
RBP: 00007fe31c1e5fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fe31c1e6038 R14: 00007fffd135ad30 R15: 00007fffd135ae18
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


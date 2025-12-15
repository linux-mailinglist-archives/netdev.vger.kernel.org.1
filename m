Return-Path: <netdev+bounces-244833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8284DCBF89D
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 20:27:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1AAEE3019D05
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 19:27:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15AFB330B05;
	Mon, 15 Dec 2025 19:27:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f78.google.com (mail-oo1-f78.google.com [209.85.161.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E48327790
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 19:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765826852; cv=none; b=KYekGi5DQIGqJYsP2jWgma0g9SeaR0XVeHOq4TyE/9Y73Tc/QQXwoFBnw/tpC3kGtRJOLLbsMEZ7J9rNIYZziKtUpDzFhrEiiQguK5cdoEL97M7gtCekB5y/0u96aIHD1C0wnbchcPqWPX90LUdM+DNSAWbuzoXg5gjDbRQvht0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765826852; c=relaxed/simple;
	bh=mPLTD7PpWjEKl0jd1qi6Si2UiYoQzTB4owpo9VMt5H4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YSCcl5PwN8U57IP4XL+tnY55Qk64sBPStOWEtvbTUExnkYMMNk95/cIhd9H8IoIe1DSKKnxlD8JuhGCzOfQ2Il9K9xwIP+ED7BopdmC9LZq/mVJjt1vWj6q58e3rOSxHlYUvgLKE6T8hVSeBey/H1qRFqo0h4apBFHSbFz2s19U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f78.google.com with SMTP id 006d021491bc7-6576fd62dffso5554816eaf.2
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 11:27:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765826849; x=1766431649;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5Fl+D8efnNL5bxbx7e53ARiPdpxbQVRmWTwvpsZJzuk=;
        b=A+xET/XsRKJYBBA0geK0DIxPWYFs+GuqcOmHaBAiqoHMIpAPQ6rVnp3S+GDZ3aJwan
         vgn3gR+y3kfV42jXcKaVbLtfmb6GpC/XejhiiMDsIG25w3zD9S3Gi0FGCvYQhKfefRUs
         CbB65v0/mPCduHLP+eivJdfgXCwwsjsO1kBfqMObxggNg3BkpwUZ1d7LScb2cGz+3lVp
         8bRL6vPK8teUsdHZKV+tfu63Ezmli4h+zsGzXCt3vrOx0t21YKVhZiA5WTax/rJfchOk
         ZIDbzdCxu6UoSuCMSacMZmQfE0nmPvGUuk7+e1Iw7z6SrMRecsl+yZJbGHDM7IdGpY7X
         Ai+Q==
X-Forwarded-Encrypted: i=1; AJvYcCU2eGVqHHhHqGT+v5dJcNK6ZaLkJ5nTmWSnOfegmvLPENZYv75r8BgxnNoHv/+8NVTHYuotOcM=@vger.kernel.org
X-Gm-Message-State: AOJu0YyyOWXd1yiU1S88eMcje1CUticE8hPlgSQWLU0Y6/wvUAnxoEth
	MjcOlk7erEVx2Ksrxe9WfuIDZFty3FJtB61Q2utDNn/cM4aukCHCNJitjhQr7l/FRS0lICSFgFQ
	temX2HvDZiFD84/AOoBLEAx3T7SaLAuQQk/EkHp8OAn1uiOenHKfh6wyNxus=
X-Google-Smtp-Source: AGHT+IGHoX6wRWJXGeCesAWSdNxXVJzgieQtRGIPaFAHJDiUt6iatyiLciauCH56AltUPSWq4tNFj2FTIZp+SophYMdq2GxcKtEU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:22a9:b0:659:9a49:8f62 with SMTP id
 006d021491bc7-65b457054a5mr5373943eaf.39.1765826849363; Mon, 15 Dec 2025
 11:27:29 -0800 (PST)
Date: Mon, 15 Dec 2025 11:27:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69406121.a70a0220.104cf0.0340.GAE@google.com>
Subject: [syzbot] [net?] INFO: rcu detected stall in rtnl_getlink (2)
From: syzbot <syzbot+106c54b7b120976392e6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f0b4cce4481 Linux 6.19-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10e3c11a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=106c54b7b120976392e6
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12682d92580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=121039c2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2b5022055115/disk-8f0b4cce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/17c3669e328d/vmlinux-8f0b4cce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7e72b5dbef4f/bzImage-8f0b4cce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+106c54b7b120976392e6@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5822/1:b..l
rcu: 	(detected by 0, t=10502 jiffies, g=9529, q=101 ncpus=2)
task:syz-executor290 state:R  running task     stack:23608 pid:5822  tgid:5822  ppid:5819   task_flags:0x400140 flags:0x00080800
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7190
 irqentry_exit+0x5d8/0x660 kernel/entry/common.c:216
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:unwind_next_frame+0xc98/0x2390 arch/x86/kernel/unwind_orc.c:-1
Code: 8b 5c 24 70 4c 8b 6c 24 50 4c 8b 64 24 10 74 08 48 89 df e8 5a bd b3 00 4c 89 23 ba 10 00 00 00 4c 89 ef 31 f6 e8 28 bf b3 00 <48> 8b 14 24 e9 c5 04 00 00 4c 89 7c 24 28 48 89 5c 24 78 4d 8d 66
RSP: 0018:ffffc90003226a78 EFLAGS: 00000202
RAX: ffffc90003226b98 RBX: ffffc90003226b80 RCX: 0000000000000000
RDX: 0000000000000010 RSI: 0000000000000000 RDI: ffffc90003226ba8
RBP: dffffc0000000000 R08: ffffc90003226ba7 R09: ffffc90003226b98
R10: dffffc0000000000 R11: fffff52000644d75 R12: ffffc90003227260
R13: ffffc90003226b98 R14: ffffc90003226b48 R15: ffffc90003226b90
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x9c/0xe0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:56 [inline]
 kasan_save_track+0x3e/0x80 mm/kasan/common.c:77
 poison_kmalloc_redzone mm/kasan/common.c:397 [inline]
 __kasan_kmalloc+0x93/0xb0 mm/kasan/common.c:414
 kasan_kmalloc include/linux/kasan.h:262 [inline]
 __do_kmalloc_node mm/slub.c:5657 [inline]
 __kmalloc_node_track_caller_noprof+0x575/0x820 mm/slub.c:5764
 kmalloc_reserve+0x136/0x290 net/core/skbuff.c:608
 pskb_expand_head+0x19d/0x1160 net/core/skbuff.c:2282
 netlink_trim+0x1b3/0x2c0 net/netlink/af_netlink.c:1299
 netlink_broadcast_filtered+0xd6/0x1000 net/netlink/af_netlink.c:1512
 nlmsg_multicast_filtered include/net/netlink.h:1165 [inline]
 nlmsg_multicast include/net/netlink.h:1184 [inline]
 nlmsg_notify+0xf0/0x1a0 net/netlink/af_netlink.c:2593
 netif_state_change+0x289/0x380 net/core/dev.c:1586
 linkwatch_do_dev+0x117/0x170 net/core/link_watch.c:186
 linkwatch_sync_dev+0x27f/0x390 net/core/link_watch.c:289
 rtnl_getlink+0x920/0xcd0 net/core/rtnetlink.c:4188
 rtnetlink_rcv_msg+0x77c/0xb70 net/core/rtnetlink.c:6967
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1318 [inline]
 netlink_unicast+0x82f/0x9e0 net/netlink/af_netlink.c:1344
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1894
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:742
 __sys_sendto+0x3bd/0x520 net/socket.c:2206
 __do_sys_sendto net/socket.c:2213 [inline]
 __se_sys_sendto net/socket.c:2209 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2209
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa2a690ff9c
RSP: 002b:00007ffcfdfcc780 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fa2a690ff9c
RDX: 0000000000000020 RSI: 00007fa2a69972f0 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007ffcfdfcc7c4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 00007ffcfdfcc910
R13: 0000000000000010 R14: 0000000000000000 R15: 00007fa2a69972f0
 </TASK>
rcu: rcu_preempt kthread starved for 10560 jiffies! g9529 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=1
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26136 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x14bc/0x5000 kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:6960
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x599/0xb30 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5860 Comm: syz-executor290 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:check_kcov_mode kernel/kcov.c:183 [inline]
RIP: 0010:write_comp_data kernel/kcov.c:246 [inline]
RIP: 0010:__sanitizer_cov_trace_cmp4+0x26/0x90 kernel/kcov.c:288
Code: 90 90 90 90 f3 0f 1e fa 48 8b 04 24 65 48 8b 14 25 08 b0 7e 92 65 8b 0d 58 fd bc 10 81 e1 00 01 ff 00 74 11 81 f9 00 01 00 00 <75> 5b 83 ba 6c 16 00 00 00 74 52 8b 8a 48 16 00 00 83 f9 03 75 47
RSP: 0018:ffffc90000a08e20 EFLAGS: 00000006
RAX: ffffffff81afcf46 RBX: 0000000000000003 RCX: 0000000000010000
RDX: ffff88802e7b5b80 RSI: 0000000000000003 RDI: 0000000000000003
RBP: 0000000000000003 R08: ffffffff81afce27 R09: ffffffff998e3508
R10: dffffc0000000000 R11: ffffffff8168e910 R12: 0000002d4f5ab498
R13: 0000000027e6dd95 R14: ffff8880b87284a0 R15: 0000000000009034
FS:  00007fa2a60ba6c0(0000) GS:ffff888125f35000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000001c0 CR3: 000000002743c000 CR4: 0000000000350ef0
Call Trace:
 <IRQ>
 ktime_get_update_offsets_now+0x186/0x3d0 kernel/time/timekeeping.c:2576
 hrtimer_update_base kernel/time/hrtimer.c:633 [inline]
 hrtimer_interrupt+0x132/0xaa0 kernel/time/hrtimer.c:1885
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1045 [inline]
 __sysvec_apic_timer_interrupt+0x102/0x3e0 arch/x86/kernel/apic/apic.c:1062
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:__sanitizer_cov_trace_const_cmp4+0x4/0x90 kernel/kcov.c:315
Code: 89 74 11 18 48 89 44 11 20 e9 e3 8b 4e ff cc 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <48> 8b 04 24 65 48 8b 14 25 08 b0 7e 92 65 8b 0d d8 fa bc 10 81 e1
RSP: 0018:ffffc900030d7838 EFLAGS: 00000246
RAX: 0000000000000008 RBX: 0000000000000004 RCX: 0000000000000002
RDX: ffff88802e7b5b80 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900030d7978 R08: 0000000000000000 R09: ffff88802e7b5b80
R10: dffffc0000000000 R11: fffff5200061af65 R12: dffffc0000000000
R13: 00007fa2a69971a8 R14: 0000000000000002 R15: 0000000000000000
 get_futex_key+0x10a/0x1660 kernel/futex/core.c:562
 futex_wait_setup+0x4f/0x590 kernel/futex/waitwake.c:617
 __futex_wait+0x148/0x3d0 kernel/futex/waitwake.c:682
 futex_wait+0x104/0x360 kernel/futex/waitwake.c:715
 do_futex+0x333/0x420 kernel/futex/syscalls.c:130
 __do_sys_futex kernel/futex/syscalls.c:207 [inline]
 __se_sys_futex+0x36f/0x400 kernel/futex/syscalls.c:188
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa2a690e589
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 1d 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa2a60ba178 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007fa2a69971a8 RCX: 00007fa2a690e589
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007fa2a69971a8
RBP: 00007fa2a69971a0 R08: 00007fa2a60ba6c0 R09: 00007fa2a60ba6c0
R10: 0000000000000000 R11: 0000000000000246 R12: 00007fa2a69971ac
R13: 0000000000000010 R14: 00007ffcfdfcc440 R15: 00007ffcfdfcc528
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.742 msecs


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


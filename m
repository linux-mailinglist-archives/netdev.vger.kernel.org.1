Return-Path: <netdev+bounces-182026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD74A876EB
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 06:26:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BD5316B128
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 04:26:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3961991B8;
	Mon, 14 Apr 2025 04:26:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8828038DF9
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 04:26:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744604790; cv=none; b=pHkqHdzK4hKwxdg2l44ekDhb2W3MwG4K7gtK9Xa3Hq4GGemUfX7OfhPJ5IMHfNARtVYItnwqLXNvGnoWPHLupl+mrpQiZi1XB+gjYpukLbD6BHEV2GIeT0KbYrifpPnEeJsxcFsx1VfKFYosnk89DDWoJ0XsKrfYDVzXMhdhj7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744604790; c=relaxed/simple;
	bh=OcxrT3FwBohBvYbWT+U9MgChzTedsmSJ0AxociaEk1A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=GcwFM4R3HeqbCStj3RdNkZiLsgxp4n504jqe9hVtCTrKdKzoisyGd8hlpWTWqUEeQ46ur8C6BarF+btr+aQF8bsepY8CHFjxiVGlVm/b8sf5LHX/w4w42TZB2LsLizmWvEBDlWSzbPbK/6k9NtagQSn/F5gw92KS3ittY7O6A28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d44ba1c2b5so36803545ab.2
        for <netdev@vger.kernel.org>; Sun, 13 Apr 2025 21:26:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744604787; x=1745209587;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ulx62r+VTkh6mo2I9nwz1UJuPNMczbwWj7F6PqZ+G24=;
        b=fKLV0j8erHZzYxWdLM1kjKBLQctPVUqtN/3wAB+2CimWNzXuLOJ45e/Bpbgd6Mehpl
         dBNj6S2EaYkbbHnEzmdU4Y+19qcEeakgnuMomQnDNgYDmOxV2GqDcfs32Nk8oXRPTQqp
         soXSy5f+4HkgtpvHsOmHY3n5ktTiiwYh5bhjFLtsMZRqTmSwygCGIYLYAvAVzJegIKMp
         IkL0/GnXI7R3zSrku4DYdh9AbzeYaJWwun8XUGgs51cCGwyQHC2Tq4zEn40gnwdkmCRT
         Vl3OMTlPEqF3zGpca04Rl/QK+xT1VyOKl66wirYOR1zjoTbPWtPBrXpH8gYfUl37Thm5
         8XvQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQhZnQ2U4rbQzLXjEQ0NFJH76WQYCA9sC5guTsqttk4VC58x+b3UBVrUsOwjS5W2kWR5+MGHU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzizEwhJV4f4Tl/tT/EidNKg/ceENk997RwXXc68Miabyy0xWDB
	A0cFeNtvP+tA1mD7rSkmT4RuhyN2KPED+KqbGXQ+7mpfyyH0RKxE3/2iM0iy5gVjUm2ezkK91xu
	iyuYpxEZW/9Er3JGerV2Vg/6GZeQU9wzcEkxAI0r5xjUYyxBbaFXoHyI=
X-Google-Smtp-Source: AGHT+IGnkEt/8Fc2iGdYA3NRHPwLStGX0SpGz4y+m4AeM7tFBBrSJd3bfAaS66i/SCn/yzKi2cye43rVmgn2/YmJdHOQFT3hy4BP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2f:b0:3d3:f19c:77c7 with SMTP id
 e9e14a558f8ab-3d7ec26b64bmr95270995ab.16.1744604787519; Sun, 13 Apr 2025
 21:26:27 -0700 (PDT)
Date: Sun, 13 Apr 2025 21:26:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fc8e73.050a0220.2970f9.03bf.GAE@google.com>
Subject: [syzbot] [batman?] INFO: rcu detected stall in rtnl_newlink (5)
From: syzbot <syzbot+2e90866706ad999df132@syzkaller.appspotmail.com>
To: a@unstable.cc, antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org, 
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com, 
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0bc21e701a6f MAINTAINERS: Remove Olof from SoC maintainers
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15496418580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1c541fa8af5c9cc7
dashboard link: https://syzkaller.appspot.com/bug?extid=2e90866706ad999df132
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13ac8edf980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6990abb5f3fd/disk-0bc21e70.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8ac1e086ff34/vmlinux-0bc21e70.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a651c0a21f54/bzImage-0bc21e70.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e90866706ad999df132@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (3 ticks this GP) idle=50a4/1/0x4000000000000000 softirq=13521/13521 fqs=0
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5941
rcu: 	(detected by 1, t=10503 jiffies, g=9229, q=1722 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5941 Comm: syz-executor Not tainted 6.13.0-rc5-syzkaller-00012-g0bc21e701a6f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:210
Code: 89 fb e8 23 00 00 00 48 8b 3d 84 ef 8e 0c 48 89 de 5b e9 73 f7 5a 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 04 24 65 48 8b 0c 25 00 d6 03 00 65 8b 15 10 62
RSP: 0018:ffffc90000007c08 EFLAGS: 00000097
RAX: 0000000000010000 RBX: 0000000000000cb2 RCX: ffff888031ac1e00
RDX: 0000000000010000 RSI: 0000000000000cb2 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff89cdbe94 R09: 1ffff11006591a90
R10: dffffc0000000000 R11: ffffed1006591a91 R12: 0000000000000004
R13: ffff888032c8d408 R14: ffff888032c8d400 R15: 0000000000000001
FS:  000055557bfba500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558e0f8a4d88 CR3: 000000007c3fc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 taprio_set_budgets+0x17d/0x370 net/sched/sch_taprio.c:666
 advance_sched+0x98d/0xca0 net/sched/sch_taprio.c:977
 __run_hrtimer kernel/time/hrtimer.c:1739 [inline]
 __hrtimer_run_queues+0x59b/0xd30 kernel/time/hrtimer.c:1803
 hrtimer_interrupt+0x403/0xa40 kernel/time/hrtimer.c:1865
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:console_flush_all+0x996/0xeb0
Code: 48 21 c3 0f 85 16 02 00 00 e8 f6 ad 20 00 4c 8b 7c 24 10 4d 85 f6 75 07 e8 e7 ad 20 00 eb 06 e8 e0 ad 20 00 fb 48 8b 5c 24 18 <48> 8b 44 24 30 42 80 3c 28 00 74 08 48 89 df e8 c6 15 87 00 4c 8b
RSP: 0018:ffffc90003226740 EFLAGS: 00000293
RAX: ffffffff817ec600 RBX: ffffffff8f174fd8 RCX: ffff888031ac1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900032268f0 R08: ffffffff817ec5d7 R09: 1ffffffff2854910
R10: dffffc0000000000 R11: fffffbfff2854911 R12: ffffffff8f174f80
R13: dffffc0000000000 R14: 0000000000000200 R15: ffffc90003226940
 __console_flush_and_unlock kernel/printk/printk.c:3269 [inline]
 console_unlock+0x14f/0x3b0 kernel/printk/printk.c:3309
 vprintk_emit+0x730/0xa10 kernel/printk/printk.c:2432
 _printk+0xd5/0x120 kernel/printk/printk.c:2457
 batadv_check_known_mac_addr+0x2b1/0x410 net/batman-adv/hard-interface.c:526
 batadv_hard_if_event+0x3a5/0x1810 net/batman-adv/hard-interface.c:998
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 dev_set_mac_address+0x3d9/0x510 net/core/dev.c:9212
 dev_set_mac_address_user+0x31/0x50 net/core/dev.c:9226
 do_setlink+0x74b/0x4210 net/core/rtnetlink.c:3064
 rtnl_changelink net/core/rtnetlink.c:3723 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3875 [inline]
 rtnl_newlink+0x1bb6/0x2210 net/core/rtnetlink.c:4012
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6922
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 __sys_sendto+0x363/0x4c0 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f47d6587bbc
Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
RSP: 002b:00007f47d689f630 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f47d72a4620 RCX: 00007f47d6587bbc
RDX: 000000000000002c RSI: 00007f47d72a4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007f47d689f684 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f47d72a4670 R15: 0000000000000000
 </TASK>
task:syz-executor    state:R  running task     stack:19216 pid:5941  tgid:5941  ppid:5926   flags:0x0000400a
Call Trace:
 <TASK>
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10502 jiffies! g9229 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=0 timer-softirq=5557
rcu: rcu_preempt kthread starved for 10503 jiffies! g9229 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:25880 pid:17    tgid:17    ppid:2      flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 schedule_timeout+0x15a/0x290 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x2df/0x1330 kernel/rcu/tree.c:2045
 rcu_gp_kthread+0xa7/0x3b0 kernel/rcu/tree.c:2247
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5941 Comm: syz-executor Not tainted 6.13.0-rc5-syzkaller-00012-g0bc21e701a6f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:hlock_class kernel/locking/lockdep.c:228 [inline]
RIP: 0010:mark_lock+0xa2/0x360 kernel/locking/lockdep.c:4727
Code: 00 8b 1b 81 e3 ff 1f 00 00 48 89 d8 48 c1 e8 06 48 8d 3c c5 80 48 2a 94 be 08 00 00 00 e8 06 b7 8a 00 48 0f a3 1d 2e 21 af 12 <73> 10 48 69 c3 c8 00 00 00 48 8d 98 40 c7 c1 93 eb 68 48 c7 c0 c0
RSP: 0018:ffffc900000078e8 EFLAGS: 00000057
RAX: 0000000000000001 RBX: 0000000000000000 RCX: ffffffff817b274a
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff942a4880
RBP: 0000000000000008 R08: ffffffff942a4887 R09: 1ffffffff2854910
R10: dffffc0000000000 R11: fffffbfff2854911 R12: ffff888031ac28c4
R13: dffffc0000000000 R14: 0000000000000100 R15: ffff888031ac29d0
FS:  000055557bfba500(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000558e0f8a4d88 CR3: 000000007c3fc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 mark_usage kernel/locking/lockdep.c:4670 [inline]
 __lock_acquire+0xc3e/0x2100 kernel/locking/lockdep.c:5180
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 debug_object_deactivate+0x158/0x390 lib/debugobjects.c:873
 debug_hrtimer_deactivate kernel/time/hrtimer.c:433 [inline]
 debug_deactivate+0x1b/0x220 kernel/time/hrtimer.c:475
 __run_hrtimer kernel/time/hrtimer.c:1707 [inline]
 __hrtimer_run_queues+0x305/0xd30 kernel/time/hrtimer.c:1803
 hrtimer_interrupt+0x403/0xa40 kernel/time/hrtimer.c:1865
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x110/0x420 arch/x86/kernel/apic/apic.c:1055
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:console_flush_all+0x996/0xeb0
Code: 48 21 c3 0f 85 16 02 00 00 e8 f6 ad 20 00 4c 8b 7c 24 10 4d 85 f6 75 07 e8 e7 ad 20 00 eb 06 e8 e0 ad 20 00 fb 48 8b 5c 24 18 <48> 8b 44 24 30 42 80 3c 28 00 74 08 48 89 df e8 c6 15 87 00 4c 8b
RSP: 0018:ffffc90003226740 EFLAGS: 00000293
RAX: ffffffff817ec600 RBX: ffffffff8f174fd8 RCX: ffff888031ac1e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900032268f0 R08: ffffffff817ec5d7 R09: 1ffffffff2854910
R10: dffffc0000000000 R11: fffffbfff2854911 R12: ffffffff8f174f80
R13: dffffc0000000000 R14: 0000000000000200 R15: ffffc90003226940
 __console_flush_and_unlock kernel/printk/printk.c:3269 [inline]
 console_unlock+0x14f/0x3b0 kernel/printk/printk.c:3309
 vprintk_emit+0x730/0xa10 kernel/printk/printk.c:2432
 _printk+0xd5/0x120 kernel/printk/printk.c:2457
 batadv_check_known_mac_addr+0x2b1/0x410 net/batman-adv/hard-interface.c:526
 batadv_hard_if_event+0x3a5/0x1810 net/batman-adv/hard-interface.c:998
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2034 [inline]
 call_netdevice_notifiers net/core/dev.c:2048 [inline]
 dev_set_mac_address+0x3d9/0x510 net/core/dev.c:9212
 dev_set_mac_address_user+0x31/0x50 net/core/dev.c:9226
 do_setlink+0x74b/0x4210 net/core/rtnetlink.c:3064
 rtnl_changelink net/core/rtnetlink.c:3723 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3875 [inline]
 rtnl_newlink+0x1bb6/0x2210 net/core/rtnetlink.c:4012
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6922
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2542
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:726
 __sys_sendto+0x363/0x4c0 net/socket.c:2197
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f47d6587bbc
Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
RSP: 002b:00007f47d689f630 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f47d72a4620 RCX: 00007f47d6587bbc
RDX: 000000000000002c RSI: 00007f47d72a4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007f47d689f684 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007f47d72a4670 R15: 0000000000000000
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


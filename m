Return-Path: <netdev+bounces-151379-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DC49EE79E
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 14:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA84E165735
	for <lists+netdev@lfdr.de>; Thu, 12 Dec 2024 13:26:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF9A2144A6;
	Thu, 12 Dec 2024 13:26:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E9DC21421C
	for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 13:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734009986; cv=none; b=M4fOeaJFwRB8pxhsDKmbp5xpeRVW9uwB/uLLUd8OTObK4uHI/2XKuLX37bLymSNq6XRoSKh0EJBHUMK2bQDgFRcO5+kejfIej4/ly0+d7z3qzMNUqLpBRZcs7nxci1K/wjo60tHb16EHRem07908MQstEZnadkmTMnqHSSJ6CqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734009986; c=relaxed/simple;
	bh=4WKjM0YCU1ryRsxZqZhJhgb/kAJAXFJYdP4u+jPOTR0=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=qO7waL1+wKpEKsTx21fMpsgLMSGLVwkTEt8aW++LybjKjbJxRH2Dduz3ncliuuYtzyQrZDtauSomlVD82PBtqJB9Lw325JGEmnD6q9Z7W7sPrSpQMiKk7HGU3pmDh0gkkvo/uHkRDcJjsHAJNn07uZosxi6xgmIsNjJrFstV0sk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a9cbe8fea1so5682715ab.3
        for <netdev@vger.kernel.org>; Thu, 12 Dec 2024 05:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734009984; x=1734614784;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=La3SwTLXd23xcLjmAIEQwU3xDgck5dQ5nGFxAetk1Ys=;
        b=ZFmBkWNeG6xVHan86wRy+YRNs9GcYwzcMuvRPsQiMLHaSUGnlZckM2vW4isT8usaA9
         7h2nHYnpkP/0d88rmbk5M0h0xirWBjKsuv0PTOboDw8p4YN9HKtncoNMcpyw9u6x6snj
         6gwI7zwNfTO64HewN+lhFLegYo7JBIG9tP5WU01BnvrfB4Ely90bxstF1DacdjF1PICd
         SteU7KIRv3QGk13X9+KDv4cjAe153NJ/JffRC1zV42sMru3F2o7KrKgVXlSBlQbDBl7y
         jKc3pIq0QZWM3s5OjSlAFIKx/sAHn6WbtLAclQM+kPr8LU6BLTL3ZLnOHftjObhf1MtN
         mNOQ==
X-Forwarded-Encrypted: i=1; AJvYcCVNNk6VRjnUro7Qz6xdGQt39a2bwGVZwqE6ZuRS9fK8dA/Ax4D4E4NDTe+1DIXqAKDSTnNn2vw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaZehJJPNY3Pcmslh2frKz8MHtDDjcDdAbr9BZr7H6FM+r6AtB
	PvsN1yudqk8RAarVFv70wYrxcZmHeBTFjLs8DA4WqqGwjCUk0kgf/tZpYl5hg4uTlst1gjAu+9i
	fjOIy8uQHge/FZ4ZNij3wihz5tkQsN79JxmMlu1PxbNZW+l58GrKdVTg=
X-Google-Smtp-Source: AGHT+IGRHLC60fQf8/zJ/MkVF77Z5fihl4zUZUqoINqI6CIbbZRopvcHYLBjHQgrjLMBa0CDEaGWyWKdoVbCKNPICXPzotb+WYDf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd84:0:b0:3a7:e800:7d36 with SMTP id
 e9e14a558f8ab-3ae55e0f7d1mr2341125ab.10.1734009984220; Thu, 12 Dec 2024
 05:26:24 -0800 (PST)
Date: Thu, 12 Dec 2024 05:26:24 -0800
In-Reply-To: <67443b01.050a0220.1cc393.0070.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <675ae480.050a0220.60f0a.0034.GAE@google.com>
Subject: Re: [syzbot] [mm?] INFO: rcu detected stall in sys_setsockopt (4)
From: syzbot <syzbot+6e61d59e9d2150c8492b@syzkaller.appspotmail.com>
To: akpm@linux-foundation.org, bigeasy@linutronix.de, davem@davemloft.net, 
	edumazet@google.com, kerneljasonxing@gmail.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, tglx@linutronix.de
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    15bfb14727bc MAINTAINERS: Add ethtool.h to NETWORKING [GEN..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=17041be8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1362a5aee630ff34
dashboard link: https://syzkaller.appspot.com/bug?extid=6e61d59e9d2150c8492b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13cc0730580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11824d44580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1a049b6d3107/disk-15bfb147.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6ec93447ce2e/vmlinux-15bfb147.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3c68a69f3efe/bzImage-15bfb147.xz

The issue was bisected to:

commit d15121be7485655129101f3960ae6add40204463
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Mon May 8 06:17:44 2023 +0000

    Revert "softirq: Let ksoftirqd do its job"

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=121d5ee8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=111d5ee8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=161d5ee8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6e61d59e9d2150c8492b@syzkaller.appspotmail.com
Fixes: d15121be7485 ("Revert "softirq: Let ksoftirqd do its job"")

bridge0: received packet on bridge_slave_1 with own address as source address (addr:aa:aa:aa:aa:aa:1c, vlan:0)
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1):
 P5828/1:b..l
rcu: 	(detected by 0, t=10504 jiffies, g=8057, q=701 ncpus=2)
task:syz-executor346 state:R  running task     stack:18864 pid:5828  tgid:5828  ppid:5827   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 preempt_schedule_irq+0xfb/0x1c0 kernel/sched/core.c:7078
 irqentry_exit+0x5e/0x90 kernel/entry/common.c:354
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:preempt_count_add+0x16/0x190 kernel/sched/core.c:5843
Code: 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 41 57 41 56 53 89 fb 48 c7 c0 c0 f9 3b 9a 48 c1 e8 03 <49> bf 00 00 00 00 00 fc ff df 42 0f b6 04 38 84 c0 0f 85 ed 00 00
RSP: 0018:ffffc90003f0eeb0 EFLAGS: 00000a02
RAX: 1ffffffff3477f38 RBX: 0000000000000001 RCX: ffffc90003f0f368
RDX: dffffc0000000000 RSI: ffffffff81fe9b6b RDI: 0000000000000001
RBP: ffffc90003f0efd8 R08: 0000000000000001 R09: ffffc90003f0f090
R10: ffffc90003f0eff0 R11: ffffffff818b36f0 R12: dffffc0000000000
R13: ffffc90003f0efa0 R14: ffffffff81fe9b6b R15: 0000000000000000
 unwind_next_frame+0xb0/0x22d0 arch/x86/kernel/unwind_orc.c:479
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 save_stack+0xfb/0x1f0 mm/page_owner.c:156
 __reset_page_owner+0x76/0x430 mm/page_owner.c:297
 reset_page_owner include/linux/page_owner.h:25 [inline]
 free_pages_prepare mm/page_alloc.c:1127 [inline]
 free_unref_page+0xdef/0x1130 mm/page_alloc.c:2657
 discard_slab mm/slub.c:2673 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3142
 put_cpu_partial+0x17c/0x250 mm/slub.c:3217
 __slab_free+0x2ea/0x3d0 mm/slub.c:4468
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:250 [inline]
 slab_post_alloc_hook mm/slub.c:4104 [inline]
 slab_alloc_node mm/slub.c:4153 [inline]
 kmem_cache_alloc_node_noprof+0x1d9/0x380 mm/slub.c:4205
 alloc_vmap_area+0x24f/0x2400 mm/vmalloc.c:1986
 __get_vm_area_node+0x1c8/0x2d0 mm/vmalloc.c:3137
 __vmalloc_node_range_noprof+0x344/0x1380 mm/vmalloc.c:3804
 __vmalloc_node_noprof mm/vmalloc.c:3909 [inline]
 vzalloc_noprof+0x79/0x90 mm/vmalloc.c:3982
 __do_replace+0xc8/0xa50 net/ipv6/netfilter/ip6_tables.c:1063
 do_replace net/ipv6/netfilter/ip6_tables.c:1158 [inline]
 do_ip6t_set_ctl+0xf11/0x1270 net/ipv6/netfilter/ip6_tables.c:1644
 nf_setsockopt+0x295/0x2c0 net/netfilter/nf_sockopt.c:101
 do_sock_setsockopt+0x3af/0x720 net/socket.c:2313
 __sys_setsockopt net/socket.c:2338 [inline]
 __do_sys_setsockopt net/socket.c:2344 [inline]
 __se_sys_setsockopt net/socket.c:2341 [inline]
 __x64_sys_setsockopt+0x1ee/0x280 net/socket.c:2341
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f014ef6d63a
RSP: 002b:00007fff22ff02d8 EFLAGS: 00000282 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007fff22ff0300 RCX: 00007f014ef6d63a
RDX: 0000000000000040 RSI: 0000000000000029 RDI: 0000000000000003
RBP: 0000000000000003 R08: 00000000000002e8 R09: 0079746972756365
R10: 00007f014efe3fe0 R11: 0000000000000282 R12: 00007f014efe3fe0
R13: 00007f014efe4d60 R14: 00007fff22ff02fc R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread starved for 10547 jiffies! g8057 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:26072 pid:17    tgid:17    ppid:2      flags:0x00004000
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
rcu: Stack dump where RCU GP kthread last ran:
CPU: 0 UID: 0 PID: 16 Comm: ksoftirqd/0 Not tainted 6.13.0-rc1-syzkaller-00230-g15bfb14727bc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:console_flush_all+0x996/0xeb0
Code: 48 21 c3 0f 85 16 02 00 00 e8 16 af 20 00 4c 8b 7c 24 10 4d 85 f6 75 07 e8 07 af 20 00 eb 06 e8 00 af 20 00 fb 48 8b 5c 24 18 <48> 8b 44 24 30 42 80 3c 28 00 74 08 48 89 df e8 b6 96 8b 00 4c 8b
RSP: 0018:ffffc900001568a0 EFLAGS: 00000246
RAX: ffffffff817ec320 RBX: ffffffff8f172418 RCX: ffff88801cecda00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000156a50 R08: ffffffff817ec2f7 R09: 1ffffffff20328c6
R10: dffffc0000000000 R11: fffffbfff20328c7 R12: ffffffff8f1723c0
R13: dffffc0000000000 R14: 0000000000000200 R15: ffffc90000156aa0
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f014efe3974 CR3: 000000000e736000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 </IRQ>
 <TASK>
 __console_flush_and_unlock kernel/printk/printk.c:3269 [inline]
 console_unlock+0x14f/0x3b0 kernel/printk/printk.c:3309
 vprintk_emit+0x730/0xa10 kernel/printk/printk.c:2432
 _printk+0xd5/0x120 kernel/printk/printk.c:2457
 br_fdb_update+0x6ce/0x740 net/bridge/br_fdb.c:897
 br_handle_frame_finish+0x739/0x1fe0 net/bridge/br_input.c:141
 br_nf_hook_thresh+0x472/0x590
 br_nf_pre_routing_finish_ipv6+0xaa0/0xdd0
 NF_HOOK include/linux/netfilter.h:314 [inline]
 br_nf_pre_routing_ipv6+0x379/0x770 net/bridge/br_netfilter_ipv6.c:184
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_bridge_pre net/bridge/br_input.c:277 [inline]
 br_handle_frame+0x9fd/0x1530 net/bridge/br_input.c:424
 __netif_receive_skb_core+0x14eb/0x4690 net/core/dev.c:5566
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x12f/0x650 net/core/dev.c:5785
 process_backlog+0x662/0x15b0 net/core/dev.c:6117
 __napi_poll+0xcb/0x490 net/core/dev.c:6883
 napi_poll net/core/dev.c:6952 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:7074
 handle_softirqs+0x2d4/0x9b0 kernel/softirq.c:554
 run_ksoftirqd+0xca/0x130 kernel/softirq.c:943
 smpboot_thread_fn+0x544/0xa30 kernel/smpboot.c:164
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
net_ratelimit: 25184 callbacks suppressed
bridge0: received packet on bridge_slave_1 with own address as source address (addr:aa:aa:aa:aa:aa:1c, vlan:0)
bridge0: received packet on bridge_slave_1 with own address as source address (addr:aa:aa:aa:aa:aa:1c, vlan:0)
bridge0: received packet on bridge_slave_1 with own address as source address (addr:aa:aa:aa:aa:aa:1c, vlan:0)
bridge0: received packet on bridge_slave_1 with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_1 with own address as source address (addr:aa:aa:aa:aa:aa:1c, vlan:0)
net_ratelimit: 28992 callbacks suppressed
bridge0: received packet on veth1_to_bridge with own address as source address (addr:aa:aa:aa:aa:aa:0c, vlan:0)
bridge0: received packet on bridge_slave_1 with own address as source address (addr:aa:aa:aa:aa:aa:1c, vlan:0)


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


Return-Path: <netdev+bounces-212699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7062B21A04
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 03:07:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D361F1A206B6
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:07:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 991DD2D6638;
	Tue, 12 Aug 2025 01:07:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B8D610B
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 01:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754960851; cv=none; b=VLraZZO7i9BMQ0hji27EG3r3T8SfgwVKMKynnwqbERQRXy2LeizPBOCh5Ty6AuAnQQz3rgGYWSql9FoKg5n2bxSFuWil+JMsoQtKhCYJz982mP/CcrD9FeSuJGnrGJD9q+Ew/K/s55i5baUhxQ7YwS8iAkpDFtgFiSgtEh/jv0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754960851; c=relaxed/simple;
	bh=o5D7b32aMX3edLrpK16KBljsOvrwxXuI+KSlv22VGIA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=YSbxBaXPJa7xZt+uQVz2iamD7bzcYH1jLbQf4hWvzz+GZIEibHt85Pk+9D4vmx9h9ZJtQ409smyBJDUbHpQ11wR0zgz16W5X26tImGJ9SJbGl2DE6OHov+RfDNf6UvoLwo8ZjXuW6SVue+8+ex3puwREPqMXtX9r2ayhggbvbHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-88177d99827so480530939f.3
        for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 18:07:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754960849; x=1755565649;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMSG0mRNDG1/2SwYtkvZDyde9l5Hz4ok38hgjt8Vi3I=;
        b=jVeFuvQ7QBll6XPa3sggEi6siX8V9hKdevlK7uCoXBwfJCQDPoLeU2/v+gIt6FvebE
         TMP3QDzMwYce1eiHFPesHxqLTr2GeJHDhCUd06X0Ur/I00Fgp1Df6iewzCjzjnIckc9O
         9+PnlWe1Bv9etocRkQEP047UIwNYRjcO+Hcm+qn5o4K6QE3aSSxINJP2+XJvAb3edhP8
         ufdM48tr9ndjyzCNT6Sris+VAESAJOzSrHxc0FhP1vJd+rLMcLm7ZoP2D2R1uflTzyjS
         GF5m/2MC7+hrf2xgrUN4IlPn28cTUBk46LdO4cAdESSwxwYKg6RmWeawwdCRy0NhudNL
         f+QQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8VKwA9k42nFzq5zxWawvD6dtCdNuBUXrEGZcN4G/+vEA/OOQb097Mwrgo6n0ftdvRvyVY33Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfLfdo3IUF2hYWDuCKs7PDpOoOPxDk1NGM0ffyJyPHOXXYSFq3
	UCN6YsWF4JUm30+D2k6a/4u9FsAONclhVKQTshUz7T67QUiWJFaPPoD+cBW2ZoOkb921tO5WzDZ
	eMzuezt9d1HqTUKApDIe926wP11gVyBeFUshLFI8qvPsFR6k2EfbMkXgl49w=
X-Google-Smtp-Source: AGHT+IHyjeCeDOBMBo3jW0FkCpJx7sRh0Zp/qhyXf95y4QnzvES9V9b5A9l02B8iiUKFHugPHdP4GV9xuq7YmPp1ogLUl1qvYVmv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:158e:b0:881:962e:3169 with SMTP id
 ca18e2360f4ac-8841be43bfamr338830639f.3.1754960848718; Mon, 11 Aug 2025
 18:07:28 -0700 (PDT)
Date: Mon, 11 Aug 2025 18:07:28 -0700
In-Reply-To: <67fc8e73.050a0220.2970f9.03bf.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689a93d0.050a0220.7f033.0103.GAE@google.com>
Subject: Re: [syzbot] [batman?] INFO: rcu detected stall in rtnl_newlink (5)
From: syzbot <syzbot+2e90866706ad999df132@syzkaller.appspotmail.com>
To: a@unstable.cc, antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org, 
	mareklindner@neomailbox.ch, netdev@vger.kernel.org, pabeni@redhat.com, 
	sven@narfation.org, sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=145f0c34580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=412ee2f8b704a5e6
dashboard link: https://syzkaller.appspot.com/bug?extid=2e90866706ad999df132
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=116f85a2580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1654e9a2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/0330552fdba5/disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ab55a11ca649/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/977f0cc190dc/bzImage-8f5ae30d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2e90866706ad999df132@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...!: (2 ticks this GP) idle=d27c/1/0x4000000000000000 softirq=18726/18726 fqs=0
rcu: 	(detected by 1, t=10502 jiffies, g=13421, q=1638 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 6007 Comm: syz-executor Not tainted 6.17.0-rc1-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:210
Code: 89 fb e8 23 00 00 00 48 8b 3d 44 49 fe 0b 48 89 de 5b e9 53 9c 58 00 cc cc cc 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 04 24 65 48 8b 0c 25 08 40 a0 92 65 8b 15 68 94
RSP: 0018:ffffc90000007d00 EFLAGS: 00000002
RAX: 0000000000000001 RBX: ffff888021bb1340 RCX: 3001483dc61ee300
RDX: ffff8880333b0000 RSI: ffffffff8be332e0 RDI: ffffffff8be332a0
RBP: 0000000000000001 R08: ffffffff8fa37e37 R09: 1ffffffff1f46fc6
R10: dffffc0000000000 R11: fffffbfff1f46fc7 R12: dffffc0000000000
R13: 0000000000000000 R14: ffff8880b8627b80 R15: 0000000000000000
FS:  0000555563c03500(0000) GS:ffff888125c1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562a8b76e950 CR3: 0000000077430000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 trace_hrtimer_start include/trace/events/timer.h:222 [inline]
 debug_activate kernel/time/hrtimer.c:485 [inline]
 enqueue_hrtimer+0xa6/0x3a0 kernel/time/hrtimer.c:1088
 __run_hrtimer kernel/time/hrtimer.c:1778 [inline]
 __hrtimer_run_queues+0x656/0xc60 kernel/time/hrtimer.c:1825
 hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1887
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1039 [inline]
 __sysvec_apic_timer_interrupt+0x108/0x410 arch/x86/kernel/apic/apic.c:1056
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:console_flush_all+0x7f7/0xc40 kernel/printk/printk.c:3227
Code: 48 21 c3 0f 85 e9 01 00 00 e8 35 49 1f 00 48 8b 5c 24 20 4d 85 f6 75 07 e8 26 49 1f 00 eb 06 e8 1f 49 1f 00 fb 48 8b 44 24 28 <42> 80 3c 20 00 74 08 48 89 df e8 3a b6 82 00 48 8b 1b 48 8b 44 24
RSP: 0018:ffffc900045ee5c0 EFLAGS: 00000293
RAX: 1ffffffff1d36747 RBX: ffffffff8e9b3a38 RCX: ffff8880333b0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900045ee710 R08: ffffffff8fa37e37 R09: 1ffffffff1f46fc6
R10: dffffc0000000000 R11: fffffbfff1f46fc7 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000200 R15: ffffffff8e9b39e0
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0xc4/0x270 kernel/printk/printk.c:3325
 vprintk_emit+0x5b7/0x7a0 kernel/printk/printk.c:2450
 _printk+0xcf/0x120 kernel/printk/printk.c:2475
 netdev_info+0x10a/0x160 net/core/dev.c:12635
 __dev_set_promiscuity+0x307/0x740 net/core/dev.c:9344
 __dev_set_rx_mode+0x17c/0x260 net/core/dev.c:-1
 dev_uc_add+0xc8/0x120 net/core/dev_addr_lists.c:693
 macvlan_open+0x446/0x8e0 drivers/net/macvlan.c:647
 __dev_open+0x470/0x880 net/core/dev.c:1682
 __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9532
 netif_change_flags+0x88/0x1a0 net/core/dev.c:9595
 do_setlink+0xc55/0x41c0 net/core/rtnetlink.c:3143
 rtnl_changelink net/core/rtnetlink.c:3761 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3920 [inline]
 rtnl_newlink+0x160b/0x1c70 net/core/rtnetlink.c:4057
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd5f6d90a7c
Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
RSP: 002b:00007fff1e7a72d0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fd5f7ae4620 RCX: 00007fd5f6d90a7c
RDX: 000000000000002c RSI: 00007fd5f7ae4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fff1e7a7324 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007fd5f7ae4670 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread timer wakeup didn't happen for 10501 jiffies! g13421 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402
rcu: 	Possible timer handling issue on cpu=0 timer-softirq=8016
rcu: rcu_preempt kthread starved for 10502 jiffies! g13421 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x402 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:I stack:27160 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
watchdog: BUG: soft lockup - CPU#1 stuck for 233s! [kworker/u8:5:1096]
Modules linked in:
irq event stamp: 1283920
hardirqs last  enabled at (1283919): [<ffffffff8b794234>] irqentry_exit+0x74/0x90 kernel/entry/common.c:200
hardirqs last disabled at (1283920): [<ffffffff8b792e6e>] sysvec_apic_timer_interrupt+0xe/0xc0 arch/x86/kernel/apic/apic.c:1050
softirqs last  enabled at (1283918): [<ffffffff8184f4da>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last  enabled at (1283918): [<ffffffff8184f4da>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last  enabled at (1283918): [<ffffffff8184f4da>] __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
softirqs last disabled at (1283899): [<ffffffff8184f4da>] __do_softirq kernel/softirq.c:613 [inline]
softirqs last disabled at (1283899): [<ffffffff8184f4da>] invoke_softirq kernel/softirq.c:453 [inline]
softirqs last disabled at (1283899): [<ffffffff8184f4da>] __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
CPU: 1 UID: 0 PID: 1096 Comm: kworker/u8:5 Not tainted 6.17.0-rc1-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:csd_lock_wait kernel/smp.c:342 [inline]
RIP: 0010:smp_call_function_many_cond+0xd33/0x12d0 kernel/smp.c:877
Code: 45 8b 2c 24 44 89 ee 83 e6 01 31 ff e8 b6 62 0b 00 41 83 e5 01 49 bd 00 00 00 00 00 fc ff df 75 07 e8 61 5e 0b 00 eb 38 f3 90 <42> 0f b6 04 2b 84 c0 75 11 41 f7 04 24 01 00 00 00 74 1e e8 45 5e
RSP: 0018:ffffc90003c1f660 EFLAGS: 00000293
RAX: ffffffff81b44d6b RBX: 1ffff110170c8341 RCX: ffff8880267f8000
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90003c1f7e0 R08: ffffffff8fa37e37 R09: 1ffffffff1f46fc6
R10: dffffc0000000000 R11: fffffbfff1f46fc7 R12: ffff8880b8641a08
R13: dffffc0000000000 R14: ffff8880b873b1c0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888125d1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fcb72ffda10 CR3: 000000000df36000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 on_each_cpu_cond_mask+0x3f/0x80 kernel/smp.c:1044
 on_each_cpu include/linux/smp.h:71 [inline]
 smp_text_poke_sync_each_cpu arch/x86/kernel/alternative.c:2653 [inline]
 smp_text_poke_batch_finish+0x5f9/0x1130 arch/x86/kernel/alternative.c:2863
 arch_jump_label_transform_apply+0x1c/0x30 arch/x86/kernel/jump_label.c:146
 static_key_enable_cpuslocked+0x128/0x250 kernel/jump_label.c:210
 static_key_enable+0x1a/0x20 kernel/jump_label.c:223
 toggle_allocation_gate+0xad/0x240 mm/kfence/core.c:850
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 6007 Comm: syz-executor Not tainted 6.17.0-rc1-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:__lock_is_held kernel/locking/lockdep.c:5598 [inline]
RIP: 0010:lock_is_held_type+0xaf/0x190 kernel/locking/lockdep.c:5940
Code: 00 00 00 7e 48 4c 89 eb 48 81 c3 f0 0a 00 00 45 31 ff 49 83 ff 31 73 24 48 89 df 4c 89 f6 e8 78 02 00 00 85 c0 75 2a 49 ff c7 <49> 63 85 e8 0a 00 00 48 83 c3 28 49 39 c7 7c d8 eb 11 48 c7 c7 b0
RSP: 0018:ffffc90000007cf8 EFLAGS: 00000002
RAX: 0000000000000000 RBX: ffff8880333b0b18 RCX: 3001483dc61ee300
RDX: ffff8880333b0000 RSI: ffff8880b8627a98 RDI: ffff8880333b0b18
RBP: 00000000ffffffff R08: ffff888021bb1357 R09: 0000000000000000
R10: ffff888021bb1340 R11: ffffed100437626b R12: 0000000000000046
R13: ffff8880333b0000 R14: ffff8880b8627a98 R15: 0000000000000002
FS:  0000555563c03500(0000) GS:ffff888125c1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000562a8b76e950 CR3: 0000000077430000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 lock_is_held include/linux/lockdep.h:249 [inline]
 __run_hrtimer kernel/time/hrtimer.c:1727 [inline]
 __hrtimer_run_queues+0x284/0xc60 kernel/time/hrtimer.c:1825
 hrtimer_interrupt+0x45b/0xaa0 kernel/time/hrtimer.c:1887
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1039 [inline]
 __sysvec_apic_timer_interrupt+0x108/0x410 arch/x86/kernel/apic/apic.c:1056
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa1/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:console_flush_all+0x7f7/0xc40 kernel/printk/printk.c:3227
Code: 48 21 c3 0f 85 e9 01 00 00 e8 35 49 1f 00 48 8b 5c 24 20 4d 85 f6 75 07 e8 26 49 1f 00 eb 06 e8 1f 49 1f 00 fb 48 8b 44 24 28 <42> 80 3c 20 00 74 08 48 89 df e8 3a b6 82 00 48 8b 1b 48 8b 44 24
RSP: 0018:ffffc900045ee5c0 EFLAGS: 00000293
RAX: 1ffffffff1d36747 RBX: ffffffff8e9b3a38 RCX: ffff8880333b0000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc900045ee710 R08: ffffffff8fa37e37 R09: 1ffffffff1f46fc6
R10: dffffc0000000000 R11: fffffbfff1f46fc7 R12: dffffc0000000000
R13: 0000000000000001 R14: 0000000000000200 R15: ffffffff8e9b39e0
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0xc4/0x270 kernel/printk/printk.c:3325
 vprintk_emit+0x5b7/0x7a0 kernel/printk/printk.c:2450
 _printk+0xcf/0x120 kernel/printk/printk.c:2475
 netdev_info+0x10a/0x160 net/core/dev.c:12635
 __dev_set_promiscuity+0x307/0x740 net/core/dev.c:9344
 __dev_set_rx_mode+0x17c/0x260 net/core/dev.c:-1
 dev_uc_add+0xc8/0x120 net/core/dev_addr_lists.c:693
 macvlan_open+0x446/0x8e0 drivers/net/macvlan.c:647
 __dev_open+0x470/0x880 net/core/dev.c:1682
 __dev_change_flags+0x1ea/0x6d0 net/core/dev.c:9532
 netif_change_flags+0x88/0x1a0 net/core/dev.c:9595
 do_setlink+0xc55/0x41c0 net/core/rtnetlink.c:3143
 rtnl_changelink net/core/rtnetlink.c:3761 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3920 [inline]
 rtnl_newlink+0x160b/0x1c70 net/core/rtnetlink.c:4057
 rtnetlink_rcv_msg+0x7cc/0xb70 net/core/rtnetlink.c:6946
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2552
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 __sys_sendto+0x3bd/0x520 net/socket.c:2228
 __do_sys_sendto net/socket.c:2235 [inline]
 __se_sys_sendto net/socket.c:2231 [inline]
 __x64_sys_sendto+0xde/0x100 net/socket.c:2231
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd5f6d90a7c
Code: 2a 5f 02 00 44 8b 4c 24 2c 4c 8b 44 24 20 89 c5 44 8b 54 24 28 48 8b 54 24 18 b8 2c 00 00 00 48 8b 74 24 10 8b 7c 24 08 0f 05 <48> 3d 00 f0 ff ff 77 34 89 ef 48 89 44 24 08 e8 70 5f 02 00 48 8b
RSP: 002b:00007fff1e7a72d0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007fd5f7ae4620 RCX: 00007fd5f6d90a7c
RDX: 000000000000002c RSI: 00007fd5f7ae4670 RDI: 0000000000000003
RBP: 0000000000000000 R08: 00007fff1e7a7324 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 0000000000000000 R14: 00007fd5f7ae4670 R15: 0000000000000000
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


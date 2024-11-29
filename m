Return-Path: <netdev+bounces-147820-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DFF79DC0E8
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 09:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2CD5282114
	for <lists+netdev@lfdr.de>; Fri, 29 Nov 2024 08:55:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8561E16B75C;
	Fri, 29 Nov 2024 08:55:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8C26AD23
	for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 08:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732870530; cv=none; b=c1VNcV35eG1Dz0VeKu8O1E69tGvG2mkwJGNmkA3i1kWySeNdXfyEsxJiZMFPzmTtoH0lNkps3wuAHR3mq3olQTW3RLZgLr+0f3I12o7eco0YH7hghiD1tNz8CiYzhOPTRVJhD1T9jsB7GtCtuV4apPJ0Fuzzx3H9b3r+aUYolCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732870530; c=relaxed/simple;
	bh=qM20KHn5jAFgUZLCV2Slj4cu5IQfmkKXuvbqSICjsN0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=j3vUp8BUcGDysvEj+bYo3vN9qvyElNzspCH5b7bT4544hmVCTnanQF9GxHB5EEYNnDmF5Lnp47w/ngudUiu2oWuf7/HLTl5CcYNcDUxFRl4CXPq4/Ze7YRPDiJ1J1VGEU2yRF+gszS4NHjM7tTW3chFS8SWCcAiHNlnai+mnZ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a7807feadfso15087835ab.2
        for <netdev@vger.kernel.org>; Fri, 29 Nov 2024 00:55:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732870528; x=1733475328;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lR+p6NE3/ylb/sNtXOnSWDpXj/jDLqlspCqpCJsrYUs=;
        b=Y+kX2taqYO4fL796jo2ZtbucfJNfe+D/hgiX9vFRG6xXyXqVwesAhNlqyNiM/ihnIo
         0KMOHHe3TOADhyd7Ia9tSI+LYKNsI5zEuGGbGP8henL2QoDnkKL2Ib6Ht+ap47tI3yO1
         Zp6CGnimmX7GBlDkSWtVYiuBk63lshRi6NIPi0aAc0uyN0PnRigemjaI3qTvqOX5HIaH
         GHpSOxsKwUZraRQGPyf+3q0wzs7d0Xokl00fwOuRrBd4aXY3WOUIYh3lu6eFiNJiOb17
         4hgb+Dj9OPdOisKBJB5OlT5al4f8fa6VfN/Gf7V6guNeq86qKUvrx6XP+n1uXu5x4/Ub
         lqQA==
X-Forwarded-Encrypted: i=1; AJvYcCUjU7mKKJjgunTjuGGVoCtwgcnjgi9eX3F0zKDC6AHymteg/zXotYCCnYV0qc/3DgQvW9iGHWM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyz8JU1ybQH7maEk+0GNHOybUxjUpCOHhVN5Q6vEuevVDEq2Mw
	XNIFs+VR6FpUT46JX6AE9kqGmZzpoA2rAl73sWzIYv4fdJH/l71ZF3dGqiUWpUgks2fMjOp7ud0
	OVE6l8yL/dYj1xNuD6+bCWspiz2fpFIdge/OR/cnWu8d486YpTonLvfs=
X-Google-Smtp-Source: AGHT+IHPLcB/b9JLed7OoEV9zLx/4zMeKD0hmJ9n6HKfcyCZnnQp2qTsoSXlfpciYJsd/Oys+DOBVQfxG3BTz4+2ITnH/IXZBwZH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a02:b0:3a7:9347:5465 with SMTP id
 e9e14a558f8ab-3a7c5523826mr116629975ab.3.1732870528021; Fri, 29 Nov 2024
 00:55:28 -0800 (PST)
Date: Fri, 29 Nov 2024 00:55:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6749817f.050a0220.253251.00a8.GAE@google.com>
Subject: [syzbot] [net?] BUG: soft lockup in sctp_generate_t1_init_event
From: syzbot <syzbot+64802c9d544a016044ac@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    28eb75e178d3 Merge tag 'drm-next-2024-11-21' of https://gi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1576a530580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba7dd83119eb53b6
dashboard link: https://syzkaller.appspot.com/bug?extid=64802c9d544a016044ac
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-28eb75e1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4600137dc19a/vmlinux-28eb75e1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/307506ce5736/zImage-28eb75e1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+64802c9d544a016044ac@syzkaller.appspotmail.com

watchdog: BUG: soft lockup - CPU#0 stuck for 23s! [kworker/u8:6:779]
Modules linked in:
irq event stamp: 875487
hardirqs last  enabled at (875486): [<ffff80008525de50>] __exit_to_kernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
hardirqs last  enabled at (875486): [<ffff80008525de50>] exit_to_kernel_mode+0x38/0x118 arch/arm64/kernel/entry-common.c:95
hardirqs last disabled at (875487): [<ffff80008525fff8>] __el1_irq arch/arm64/kernel/entry-common.c:557 [inline]
hardirqs last disabled at (875487): [<ffff80008525fff8>] el1_interrupt+0x24/0x54 arch/arm64/kernel/entry-common.c:575
softirqs last  enabled at (836530): [<ffff800082d402d8>] spin_unlock_bh include/linux/spinlock.h:396 [inline]
softirqs last  enabled at (836530): [<ffff800082d402d8>] nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
softirqs last  enabled at (836530): [<ffff800082d402d8>] nsim_dev_trap_report_work+0x6c4/0xa9c drivers/net/netdevsim/dev.c:851
softirqs last disabled at (836531): [<ffff800080010758>] __do_softirq+0x14/0x20 kernel/softirq.c:588
CPU: 0 UID: 0 PID: 779 Comm: kworker/u8:6 Not tainted 6.12.0-syzkaller-07749-g28eb75e178d3 #0
Hardware name: linux,dummy-virt (DT)
Workqueue: events_unbound nsim_dev_trap_report_work
pstate: 10000005 (nzcV daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
pc : __percpu_read_32+0x0/0x58 arch/arm64/include/asm/percpu.h:125
lr : lockdep_enabled kernel/locking/lockdep.c:119 [inline]
lr : lock_is_held_type+0x68/0x1b4 kernel/locking/lockdep.c:5914
sp : ffff800080006a60
x29: ffff800080006a60 x28: ffff00001ac99050 x27: 0000000000000003
x26: 00000000ffffffff x25: 1ffff00010000d79 x24: ffff800086c84448
x23: 0000000000000000 x22: ffff800080006bc0 x21: ffff800086ed8960
x20: dfff800000000000 x19: ffff000011d8bf00 x18: 0000000032b43c88
x17: 00000000000080fe x16: 0000000000000000 x15: 1fffe0000273a514
x14: 1ffff000110ce4fc x13: ffff0000139d28c0 x12: ffff700010000d7e
x11: 1ffff00010000d7d x10: ffff700010000d7d x9 : dfff800000000000
x8 : ffff800080006bf0 x7 : 0000000000000000 x6 : ffff700010000d78
x5 : ffff800080006bc4 x4 : ffff800080007488 x3 : 1fffe0000273a3c9
x2 : 0000000000000000 x1 : ffff800086c84448 x0 : ffff000069f74448
Call trace:
 __percpu_read_32+0x0/0x58 arch/arm64/include/asm/percpu.h:47 (P)
 lockdep_enabled kernel/locking/lockdep.c:119 [inline] (L)
 lock_is_held_type+0x68/0x1b4 kernel/locking/lockdep.c:5914 (L)
 lock_is_held include/linux/lockdep.h:249 [inline]
 rcu_read_lock_held kernel/rcu/update.c:351 [inline]
 rcu_read_lock_held+0x54/0x70 kernel/rcu/update.c:345
 fib6_node_lookup_1+0x284/0x6c4 net/ipv6/ip6_fib.c:1620
 fib6_node_lookup+0xc0/0x14c net/ipv6/ip6_fib.c:1649
 fib6_table_lookup+0xbc/0x70c net/ipv6/route.c:2191
 ip6_pol_route+0x164/0xbcc net/ipv6/route.c:2231
 ip6_pol_route_output+0x50/0x7c net/ipv6/route.c:2606
 pol_lookup_func include/net/ip6_fib.h:616 [inline]
 fib6_rule_lookup+0xf8/0x560 net/ipv6/fib6_rules.c:117
 ip6_route_output_flags_noref net/ipv6/route.c:2639 [inline]
 ip6_route_output_flags+0x158/0x4b0 net/ipv6/route.c:2651
 ip6_dst_lookup_tail.constprop.0+0xcc8/0x1b68 net/ipv6/ip6_output.c:1156
 ip6_dst_lookup_flow+0x90/0x16c net/ipv6/ip6_output.c:1259
 sctp_v6_get_dst+0x854/0x144c net/sctp/ipv6.c:384
 sctp_transport_route+0xf8/0x2b8 net/sctp/transport.c:455
 sctp_packet_config+0x7b8/0xa88 net/sctp/output.c:103
 sctp_outq_select_transport+0x16c/0x59c net/sctp/outqueue.c:869
 sctp_outq_flush_ctrl net/sctp/outqueue.c:903 [inline]
 sctp_outq_flush+0x234/0x2540 net/sctp/outqueue.c:1212
 sctp_outq_uncork+0x54/0x74 net/sctp/outqueue.c:764
 sctp_cmd_interpreter net/sctp/sm_sideeffect.c:1818 [inline]
 sctp_side_effects net/sctp/sm_sideeffect.c:1198 [inline]
 sctp_do_sm+0x1604/0x4b70 net/sctp/sm_sideeffect.c:1169
 sctp_generate_timeout_event+0x154/0x2c8 net/sctp/sm_sideeffect.c:295
 sctp_generate_t1_init_event+0x18/0x24 net/sctp/sm_sideeffect.c:321
 call_timer_fn+0x1b0/0x7b4 kernel/time/timer.c:1793
 expire_timers kernel/time/timer.c:1844 [inline]
 __run_timers+0x50c/0x71c kernel/time/timer.c:2418
 __run_timer_base kernel/time/timer.c:2430 [inline]
 __run_timer_base kernel/time/timer.c:2422 [inline]
 run_timer_base+0x110/0x180 kernel/time/timer.c:2439
 run_timer_softirq+0x1c/0x44 kernel/time/timer.c:2449
 handle_softirqs+0x2e8/0xd44 kernel/softirq.c:554
 __do_softirq+0x14/0x20 kernel/softirq.c:588
 ____do_softirq+0x10/0x1c arch/arm64/kernel/irq.c:81
 call_on_irq_stack+0x24/0x4c arch/arm64/kernel/entry.S:891
 do_softirq_own_stack+0x1c/0x2c arch/arm64/kernel/irq.c:86
 do_softirq kernel/softirq.c:455 [inline]
 do_softirq+0x12c/0x150 kernel/softirq.c:442
 __local_bh_enable_ip+0x414/0x4a4 kernel/softirq.c:382
 __raw_spin_unlock_bh include/linux/spinlock_api_smp.h:167 [inline]
 _raw_spin_unlock_bh+0x44/0x54 kernel/locking/spinlock.c:210
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
 nsim_dev_trap_report_work+0x6c4/0xa9c drivers/net/netdevsim/dev.c:851
 process_one_work+0x7b8/0x189c kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x730/0xb74 kernel/workqueue.c:3391
 kthread+0x27c/0x300 kernel/kthread.c:389
 ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:862
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5489 Comm: syz.2.701 Not tainted 6.12.0-syzkaller-07749-g28eb75e178d3 #0
Hardware name: linux,dummy-virt (DT)
pstate: 20000010 (nzCv q A32 LE aif -DIT -SSBS)
pc : 0000000000018b8c
lr : 0000000000018b8c
sp : 0000000020000370
x12: 0000000020000370
x11: 00000000f76b10bc x10: 00000000003d0f00 x9 : 0000000000006364
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
x2 : 00000000000001e4 x1 : 0000000000000004 x0 : 00000000ffffffff


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


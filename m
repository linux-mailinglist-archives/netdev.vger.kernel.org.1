Return-Path: <netdev+bounces-218990-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50ED6B3F3C4
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 06:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1126A16A911
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 04:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1204A25EFBB;
	Tue,  2 Sep 2025 04:28:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49E2A1DE4CD
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 04:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756787312; cv=none; b=CDsQ+jcG5pnVLd+2qKKNEu/iSeIiW8QMhnblj8SXbXgsRE1oWwFNaBMY1qvDiZ4U3VVMcrhlNxFjzsh+3dckd2oCUbFoK/rzqTO3R3tmlZVr+ntLnQ886TOfhrkDBSHI2J5WpJ6u+ClHnM6Zd3zK8KAY09kRZVCt4mVAtXWOMzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756787312; c=relaxed/simple;
	bh=dUz9NTPwPT9N8uvcFUvfixCQN4t/EG6LGyGJlpew+JI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=UIadqyYYzN+AMaMAaDAt6jgc+49OBMyWPNuHSCNXv7JZ6fcHJAiRgnAMLQuaGdSsS2lXEjb6XhghHl368+dlJEIftybPOHWmKLS6LkG1ryo6q2rECozjFLCEKFfOZPXZXfEywZKAlm9dVoK6GApj9sc/vjG6690IYQX9KxZd7kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3f20528fe92so96190795ab.2
        for <netdev@vger.kernel.org>; Mon, 01 Sep 2025 21:28:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756787309; x=1757392109;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J0b/c8OqJR/lh71Qiq/TDGznf5dadAves7tGSrZU+T0=;
        b=KcHXmEGixpbJVwITdPRteLNsvQeghOYmj5RtcwTrpsCOS49r68/a95pcSgbyYjyaUc
         rKedIU/YxnqFHwHcP4VFtNOrWaTiA2EaMj/3k1i9Liqe13cGTMJIHkDQiPJIViuTKgce
         Wc5XhGZqEW0+1HrUi5PjnNSa/dWSLjkZz1CGhcHhM+nrJSc/d/BOBiIhr/I5ltKePFZL
         qFlxE/aUh8sMZJP5QizVyUzXsRoEKTKsoPqLikfhR89ubXpjvWshX5U8Mda/ItKPRA8Z
         ZqYy2wDyrI5dmqmaSlpTvMpO7Yuu2dATJfeDKr2O3h/yjlKmoO0qejOxXWxq0txta5AI
         98nQ==
X-Forwarded-Encrypted: i=1; AJvYcCUtOQbV25MhWj6H4TaW4pmGv8q9/L5tLR2sGdjK7MU0of4Ut1ApFpg5NAWMPDFtSc/HYerDPeQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBUJ80sQhNzFswOs+AYGcsBuKqPRiM04nbg1XQxrIoyw7pJfMJ
	BKw4snN/6MSJq4YY2FdgDw7BCJ2wgD673v6XtIJD2rmSmy0VStYf70PHGaqRUa0AXrpfM9h6Kpd
	9p01W79D7tk3N/zTtxQT7ghuflBQXTZ452YsHu3nyhik6W0GsdqM7CVfjEbw=
X-Google-Smtp-Source: AGHT+IEAtNjKimBcWz7ySWIB2PtJ4rX2e2H0p9tHig7aJeO1pJS8UfNQgu4O+NBCy5rTzYhp+qiflmCbIJ4yQzMKj5q1QVTqsgfh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c22:b0:3f0:af3f:e9e4 with SMTP id
 e9e14a558f8ab-3f3ffda4bb8mr185935275ab.3.1756787309568; Mon, 01 Sep 2025
 21:28:29 -0700 (PDT)
Date: Mon, 01 Sep 2025 21:28:29 -0700
In-Reply-To: <6840fdc4.a00a0220.68b4a.000d.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68b6726d.a70a0220.1c57d1.0594.GAE@google.com>
Subject: Re: [syzbot] [net?] BUG: soft lockup in sys_sendmsg (2)
From: syzbot <syzbot+4032319a6a907f69e985@syzkaller.appspotmail.com>
To: axboe@kernel.dk, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-scsi@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    7fa4d8dc380f Add linux-next specific files for 20250821
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16094a42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ae76068823a236b3
dashboard link: https://syzkaller.appspot.com/bug?extid=4032319a6a907f69e985
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=15990312580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/63178c6ef3f8/disk-7fa4d8dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/c5c27b0841e0/vmlinux-7fa4d8dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a8832715cca/bzImage-7fa4d8dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4032319a6a907f69e985@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	Tasks blocked on level-0 rcu_node (CPUs 0-1): P5234/1:b..l
rcu: 	(detected by 1, t=10503 jiffies, g=7533, q=653 ncpus=2)
task:udevd           state:R  running task     stack:26096 pid:5234  tgid:5234  ppid:1      task_flags:0x400140 flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 preempt_schedule_irq+0xb5/0x150 kernel/sched/core.c:7288
 irqentry_exit+0x6f/0x90 kernel/entry/common.c:197
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:constant_test_bit arch/x86/include/asm/bitops.h:206 [inline]
RIP: 0010:arch_test_bit arch/x86/include/asm/bitops.h:238 [inline]
RIP: 0010:tif_test_bit include/linux/thread_info.h:192 [inline]
RIP: 0010:tif_need_resched include/linux/thread_info.h:208 [inline]
RIP: 0010:need_resched include/linux/sched.h:2211 [inline]
RIP: 0010:preempt_schedule_common+0x11/0xd0 kernel/sched/core.c:7153
Code: 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 57 41 56 53 49 bf 00 00 00 00 00 fc ff df eb 0d <48> f7 03 08 00 00 00 0f 84 9b 00 00 00 65 ff 05 0b 76 5e 07 65 8b
RSP: 0018:ffffc900030c7540 EFLAGS: 00000246
RAX: 1ffff11008494b40 RBX: ffff8880424a5a00 RCX: aa2a76cb3742ae00
RDX: 0000000000000000 RSI: ffffffff8c04e5e0 RDI: ffffffff8c04e5a0
RBP: ffffc900030c75d8 R08: ffffffff8fe52d37 R09: 1ffffffff1fca5a6
R10: dffffc0000000000 R11: fffffbfff1fca5a7 R12: dffffc0000000000
R13: ffff88807da4ce80 R14: ffff8880424a6ee0 R15: dffffc0000000000
 preempt_schedule+0xae/0xc0 kernel/sched/core.c:7169
 preempt_schedule_thunk+0x16/0x30 arch/x86/entry/thunk.S:12
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:152 [inline]
 _raw_spin_unlock_irqrestore+0xfd/0x110 kernel/locking/spinlock.c:194
 spin_unlock_irqrestore include/linux/spinlock.h:406 [inline]
 __wake_up_common_lock+0x190/0x1f0 kernel/sched/wait.c:127
 sock_def_readable+0x1fb/0x550 net/core/sock.c:3564
 __netlink_sendskb net/netlink/af_netlink.c:1265 [inline]
 netlink_sendskb+0xa1/0x140 net/netlink/af_netlink.c:1271
 netlink_unicast+0x397/0x9e0 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa3432a7407
RSP: 002b:00007ffded507800 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fa343a95880 RCX: 00007fa3432a7407
RDX: 0000000000000000 RSI: 00007ffded507860 RDI: 0000000000000004
RBP: 0000562320cd2f40 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00000000000000b2
R13: 0000562320cb09e0 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
rcu: rcu_preempt kthread starved for 10543 jiffies! g7533 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
rcu: RCU grace-period kthread stack dump:
task:rcu_preempt     state:R  running task     stack:28008 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00004000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x1798/0x4cc0 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 schedule_timeout+0x12b/0x270 kernel/time/sleep_timeout.c:99
 rcu_gp_fqs_loop+0x301/0x1540 kernel/rcu/tree.c:2083
 rcu_gp_kthread+0x99/0x390 kernel/rcu/tree.c:2285
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x47c/0x820 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
rcu: Stack dump where RCU GP kthread last ran:
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 6072 Comm: syz.2.32 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:list_empty include/linux/list.h:381 [inline]
RIP: 0010:plist_del+0x88/0x3f0 lib/plist.c:126
Code: 5e f0 3f f6 48 89 df e8 56 07 00 00 4d 8d 7e 08 4c 89 fd 48 c1 ed 03 42 80 7c 25 00 00 74 08 4c 89 ff e8 0b 9a a3 f6 4d 8b 2f <4d> 39 fd 74 6d 4d 8d 66 18 4c 89 e0 48 c1 e8 03 48 b9 00 00 00 00
RSP: 0018:ffffc900030d76d0 EFLAGS: 00000046
RAX: ffffffff8b80e8df RBX: ffff8880b863a8e8 RCX: ffff888027c59e00
RDX: 0000000000000000 RSI: ffff8880b863a8e8 RDI: ffff8880b863a8e8
RBP: 1ffff11004f8b464 R08: ffff888140a911f7 R09: 1ffff1102815223e
R10: dffffc0000000000 R11: ffffed102815223f R12: dffffc0000000000
R13: ffff888027c5a320 R14: ffff888027c5a318 R15: ffff888027c5a320
FS:  00007ffbb84b56c0(0000) GS:ffff8881257c4000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000058 CR3: 000000007dd24000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 dequeue_pushable_task+0x2e/0x2d0 kernel/sched/rt.c:415
 dequeue_task_rt+0x25e/0x790 kernel/sched/rt.c:1457
 block_task kernel/sched/core.c:2155 [inline]
 try_to_block_task kernel/sched/core.c:6585 [inline]
 __schedule+0x5f1/0x4cc0 kernel/sched/core.c:6896
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0x165/0x360 kernel/sched/core.c:7058
 futex_do_wait kernel/futex/waitwake.c:358 [inline]
 __futex_wait+0x1c3/0x3e0 kernel/futex/waitwake.c:687
 futex_wait+0x104/0x360 kernel/futex/waitwake.c:715
 do_futex+0x333/0x420 kernel/futex/syscalls.c:102
 __do_sys_futex kernel/futex/syscalls.c:179 [inline]
 __se_sys_futex+0x36f/0x400 kernel/futex/syscalls.c:160
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ffbb758ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffbb84b50e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: ffffffffffffffda RBX: 00007ffbb77c5fa8 RCX: 00007ffbb758ebe9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007ffbb77c5fa8
RBP: 00007ffbb77c5fa0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffbb77c6038 R14: 00007ffea00f5430 R15: 00007ffea00f5518
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


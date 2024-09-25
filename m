Return-Path: <netdev+bounces-129872-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B035C98695C
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 01:05:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63D15281C85
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 23:05:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27D7A188912;
	Wed, 25 Sep 2024 23:05:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC183188907
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 23:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727305530; cv=none; b=t3gpI7hNUSZxHQRHkM1H9FccZXvSlVt20Lc7HjAkuFmDIdg5T8B+FCpPysac3Zl4Q1yyoUPd8eJZcgdFeeP6woG7XhCXdz8G3YTDTqh56v7WPZFs4RT+MZjyULr+k0VSAEDZfJE+3XbmCG3JUPwbfGR1Ztqp9cRRBgtwC5UJsro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727305530; c=relaxed/simple;
	bh=c8Xab8j95dk91DL+MGhoauuDlGQkh7P1PIs4kksmOwc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=iwMbKcqCg6rSf58YtWRoNJpsCzaN5qeIBgCguB3a0nflZUBviTmXUB7yIjLMrWPo9FAP7sRgKYzE50IEM7Q4xD7GU5BNff5lPxdRy2obXtTRANddKJ7KtQGjMLl9NO+nKr2K9eMmrIBcdiYGfAOIMwV9p1FnPqngzGsFClkWvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a1a2af837dso13392015ab.1
        for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 16:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727305527; x=1727910327;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c8rq/Yylaq+Jt3mYtdKx+FsyQHNrgUG6gtCA5/jzsRk=;
        b=SqtzvkuNpNig7VDAOmTGTvEMEuU3+KDX/LCE6rHSkowpRdlMcUyz82jMkCy621wW6M
         GEMMbRa3ON0oLZKrK8zATQiLUWk7nX2dpCA+/t0ROv51D31AM5rdUp1QP8gTpfvJdnWb
         ksyoLOsJ2uKI8u/Rs53kcFXbLFTMkazCN4DSqSwohQEM1I2UnOfmbBAh3RoLPdL6DW+h
         75C1fFhgns8MmQDrG2YyDr0KAGmkTbPe1x4HnH3C9rKyDMqhwGOla553JX9mpmEa+6oM
         W892zmkcpoNYBc94T5xgt0uCmfdeZXg/7lVfK0teVRpl8BwU5uhc9UMBAy2AUIyH4q5w
         LOSA==
X-Forwarded-Encrypted: i=1; AJvYcCXzYx9UOE3czvcYKnJxkOTLszPcECekZ5lcLRqAtAmFj77tyzeAXVdyb7517TGu8OON9fmhmwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwODvAfbpIvK9EvZldxiNO1S++KzYc5QTbek6m7qDilbWI9hjjt
	zmylJuZixE+42XNhfJPebpw3cD5gB/fiM0+WAJOnOLUHQHHq0zYvMMZ5yAyWZSUHk+ntaLIxQHw
	XSt/cdZnK5enrGKe0sR/ggbOM7506bUPWEr7PvwAXbBeZolTI0emb+tA=
X-Google-Smtp-Source: AGHT+IGU8JqYg+gjk9Y5XjpxGs9415nT24ZrYKSxzEUzBC4ICiGI3X5wva3Of6Ki2XLw4GVA9Gf58njLvG7LsvqSZdStHL2xmMSx
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cf:b0:3a2:762b:faf0 with SMTP id
 e9e14a558f8ab-3a2768bf4d0mr10616725ab.11.1727305526802; Wed, 25 Sep 2024
 16:05:26 -0700 (PDT)
Date: Wed, 25 Sep 2024 16:05:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f49736.050a0220.211276.0036.GAE@google.com>
Subject: [syzbot] [wireguard?] INFO: task hung in wg_netns_pre_exit (5)
From: syzbot <syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    aa486552a110 Merge tag 'memblock-v6.12-rc1' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10795907980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6c71bad3e6ab6955
dashboard link: https://syzkaller.appspot.com/bug?extid=f2fbf7478a35a94c8b7c
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7c6beec63de3/disk-aa486552.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/fa35efb3dd39/vmlinux-aa486552.xz
kernel image: https://storage.googleapis.com/syzbot-assets/537d8ff45d85/bzImage-aa486552.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f2fbf7478a35a94c8b7c@syzkaller.appspotmail.com

INFO: task kworker/u8:4:62 blocked for more than 147 seconds.
      Not tainted 6.11.0-syzkaller-10622-gaa486552a110 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:4    state:D stack:22032 pid:62    tgid:62    ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 wg_netns_pre_exit+0x1f/0x1e0 drivers/net/wireguard/device.c:414
 ops_pre_exit_list net/core/net_namespace.c:163 [inline]
 cleanup_net+0x615/0xcc0 net/core/net_namespace.c:606
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:6:5282 blocked for more than 148 seconds.
      Not tainted 6.11.0-syzkaller-10622-gaa486552a110 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:6     state:D stack:20280 pid:5282  tgid:5282  ppid:2      flags:0x00004000
Workqueue: events_power_efficient reg_check_chans_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 reg_check_chans_work+0x99/0xfd0 net/wireless/reg.c:2480
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz.3.199:5864 blocked for more than 149 seconds.
      Not tainted 6.11.0-syzkaller-10622-gaa486552a110 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.199       state:D stack:26112 pid:5864  tgid:5864  ppid:5247   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 tun_detach drivers/net/tun.c:698 [inline]
 tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x176f/0x1810 kernel/signal.c:2936
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5630baffe5
RSP: 002b:00007f5631a32f80 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: fffffffffffffdfc RBX: 00007f5630d35f80 RCX: 00007f5630baffe5
RDX: 00007f5631a32fc0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007f5630bf0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f5630d35f80 R15: 00007f5630e5fa28
 </TASK>
INFO: task syz-executor:7290 blocked for more than 149 seconds.
      Not tainted 6.11.0-syzkaller-10622-gaa486552a110 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:20696 pid:7290  tgid:7290  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 tun_detach drivers/net/tun.c:698 [inline]
 tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 get_signal+0x176f/0x1810 kernel/signal.c:2936
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fef8cf7c93c
RSP: 002b:00007fef8d25fd90 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: 0000000000000000 RBX: 0000000000000003 RCX: 00007fef8cf7c93c
RDX: 0000000000000028 RSI: 00007fef8d25fe40 RDI: 00000000000000f9
RBP: 00007fef8d25fdec R08: 0000000000000000 R09: 0079746972756365
R10: 00007fef8d1087e0 R11: 0000000000000246 R12: 0000000000000032
R13: 000000000002d01e R14: 000000000002c93a R15: 00007fef8d25fe40
 </TASK>
INFO: task syz-executor:7963 blocked for more than 150 seconds.
      Not tainted 6.11.0-syzkaller-10622-gaa486552a110 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:26512 pid:7963  tgid:7963  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
 ops_init+0x31e/0x590 net/core/net_namespace.c:139
 setup_net+0x287/0x9e0 net/core/net_namespace.c:356
 copy_net_ns+0x33f/0x570 net/core/net_namespace.c:494
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x619/0xc10 kernel/fork.c:3315
 __do_sys_unshare kernel/fork.c:3386 [inline]
 __se_sys_unshare kernel/fork.c:3384 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3384
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f0fcc97f6f7
RSP: 002b:00007f0fccc5ffa8 EFLAGS: 00000206 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f0fcc9f22ec RCX: 00007f0fcc97f6f7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 0000000000000000 R08: 00007f0fcd667d60 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 000000000000000c
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:7964 blocked for more than 150 seconds.
      Not tainted 6.11.0-syzkaller-10622-gaa486552a110 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:26520 pid:7964  tgid:7964  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
 ops_init+0x31e/0x590 net/core/net_namespace.c:139
 setup_net+0x287/0x9e0 net/core/net_namespace.c:356
 copy_net_ns+0x33f/0x570 net/core/net_namespace.c:494
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x619/0xc10 kernel/fork.c:3315
 __do_sys_unshare kernel/fork.c:3386 [inline]
 __se_sys_unshare kernel/fork.c:3384 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3384
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f73df37f6f7
RSP: 002b:00007f73df65ffa8 EFLAGS: 00000206 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007f73df3f22ec RCX: 00007f73df37f6f7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 0000000000000000 R08: 00007f73e0067d60 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 000000000000000c
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:7967 blocked for more than 151 seconds.
      Not tainted 6.11.0-syzkaller-10622-gaa486552a110 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:26400 pid:7967  tgid:7967  ppid:1      flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
 ops_init+0x31e/0x590 net/core/net_namespace.c:139
 setup_net+0x287/0x9e0 net/core/net_namespace.c:356
 copy_net_ns+0x33f/0x570 net/core/net_namespace.c:494
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x619/0xc10 kernel/fork.c:3315
 __do_sys_unshare kernel/fork.c:3386 [inline]
 __se_sys_unshare kernel/fork.c:3384 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3384
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb3ccf7f6f7
RSP: 002b:00007fb3cd25ffa8 EFLAGS: 00000206 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007fb3ccff22ec RCX: 00007fb3ccf7f6f7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 0000000000000000 R08: 00007fb3cdc67d60 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 000000000000000c
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:7968 blocked for more than 151 seconds.
      Not tainted 6.11.0-syzkaller-10622-gaa486552a110 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:26736 pid:7968  tgid:7968  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
 ops_init+0x31e/0x590 net/core/net_namespace.c:139
 setup_net+0x287/0x9e0 net/core/net_namespace.c:356
 copy_net_ns+0x33f/0x570 net/core/net_namespace.c:494
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x619/0xc10 kernel/fork.c:3315
 __do_sys_unshare kernel/fork.c:3386 [inline]
 __se_sys_unshare kernel/fork.c:3384 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3384
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe1cc77f6f7
RSP: 002b:00007fe1cca5ffa8 EFLAGS: 00000206 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007fe1cc7f22ec RCX: 00007fe1cc77f6f7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 0000000000000000 R08: 00007fe1cd467d60 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 000000000000000c
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>
INFO: task syz-executor:7970 blocked for more than 151 seconds.
      Not tainted 6.11.0-syzkaller-10622-gaa486552a110 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:26592 pid:7970  tgid:7970  ppid:1      flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
 ops_init+0x31e/0x590 net/core/net_namespace.c:139
 setup_net+0x287/0x9e0 net/core/net_namespace.c:356
 copy_net_ns+0x33f/0x570 net/core/net_namespace.c:494
 create_new_namespaces+0x425/0x7b0 kernel/nsproxy.c:110
 unshare_nsproxy_namespaces+0x124/0x180 kernel/nsproxy.c:228
 ksys_unshare+0x619/0xc10 kernel/fork.c:3315
 __do_sys_unshare kernel/fork.c:3386 [inline]
 __se_sys_unshare kernel/fork.c:3384 [inline]
 __x64_sys_unshare+0x38/0x40 kernel/fork.c:3384
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fed4d37f6f7
RSP: 002b:00007fed4d65ffa8 EFLAGS: 00000206 ORIG_RAX: 0000000000000110
RAX: ffffffffffffffda RBX: 00007fed4d3f22ec RCX: 00007fed4d37f6f7
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000040000000
RBP: 0000000000000000 R08: 00007fed4e067d60 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 000000000000000c
R13: 0000000000000003 R14: 0000000000000009 R15: 0000000000000000
 </TASK>

Showing all locks held in the system:
4 locks held by kworker/0:1/9:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6701
3 locks held by kworker/u8:2/35:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000ab7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000ab7d00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
4 locks held by kworker/u8:4/62:
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900015d7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900015d7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc4dd0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:580
 #3: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1f/0x1e0 drivers/net/wireguard/device.c:414
3 locks held by kworker/u8:5/742:
 #0: ffff88802e0c8948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88802e0c8948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc900035bfd00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc900035bfd00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4736
3 locks held by kworker/0:2/939:
 #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003cb7d00 (deferred_process_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003cb7d00 (deferred_process_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
2 locks held by kworker/u8:7/2511:
2 locks held by getty/4983:
 #0: ffff88814ce900a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by kworker/1:6/5282:
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90004497d00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90004497d00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x99/0xfd0 net/wireless/reg.c:2480
1 lock held by syz.3.199/5864:
 #0: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
2 locks held by syz-executor/6709:
 #0: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
 #1: ffffffff8e7d1dd0 (cpu_hotplug_lock){++++}-{0:0}, at: flush_all_backlogs net/core/dev.c:6021 [inline]
 #1: ffffffff8e7d1dd0 (cpu_hotplug_lock){++++}-{0:0}, at: unregister_netdevice_many_notify+0x5ea/0x1da0 net/core/dev.c:11380
1 lock held by syz-executor/7290:
 #0: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b/0x1b0 drivers/net/tun.c:3517
2 locks held by syz-executor/7963:
 #0: ffffffff8fcc4dd0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/7964:
 #0: ffffffff8fcc4dd0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/7967:
 #0: ffffffff8fcc4dd0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/7968:
 #0: ffffffff8fcc4dd0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/7970:
 #0: ffffffff8fcc4dd0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/7987:
 #0: ffffffff8fcc4dd0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/7989:
 #0: ffffffff8fcc4dd0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/7993:
 #0: ffffffff8fcc4dd0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/7995:
 #0: ffffffff8fcc4dd0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/7996:
 #0: ffffffff8fcc4dd0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/8007:
 #0: ffffffff8fcc4dd0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/8009:
 #0: ffffffff8fcc4dd0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/8011:
 #0: ffffffff8fcc4dd0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/8016:
 #0: ffffffff8fcc4dd0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885
2 locks held by syz-executor/8020:
 #0: ffffffff8fcc4dd0 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fcd18c8 (rtnl_mutex){+.+.}-{3:3}, at: register_nexthop_notifier+0x84/0x290 net/ipv4/nexthop.c:3885

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-syzkaller-10622-gaa486552a110 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 9 Comm: kworker/0:1 Not tainted 6.11.0-syzkaller-10622-gaa486552a110 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: events_power_efficient neigh_periodic_work
RIP: 0010:unwind_next_frame+0x4c0/0x22d0 arch/x86/kernel/unwind_orc.c:512
Code: e8 03 42 0f b6 04 20 84 c0 0f 85 8a 16 00 00 41 0f b7 1f c1 eb 0b 80 e3 01 48 8b 44 24 28 42 0f b6 04 20 84 c0 4c 8b 74 24 78 <0f> 85 8d 16 00 00 48 8b 04 24 88 18 41 0f b7 1f 83 e3 0f 83 fb 05
RSP: 0018:ffffc90000006c70 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff9035b3dc
RDX: ffffffff90af2768 RSI: ffffffff90af273e RDI: 0000000000000001
RBP: ffffc90000006d90 R08: 000000000000000b R09: ffffc90000006e30
R10: ffffc90000006d90 R11: ffffffff81806870 R12: dffffc0000000000
R13: ffffc90000006d40 R14: ffffc90000006d78 R15: ffffffff90af276c
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f41d2cab1cb CR3: 000000000e734000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 arch_stack_walk+0x11c/0x150 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 kasan_save_free_info+0x40/0x50 mm/kasan/generic.c:579
 poison_slab_object mm/kasan/common.c:247 [inline]
 __kasan_slab_free+0x59/0x70 mm/kasan/common.c:264
 kasan_slab_free include/linux/kasan.h:230 [inline]
 slab_free_hook mm/slub.c:2343 [inline]
 slab_free mm/slub.c:4580 [inline]
 kmem_cache_free+0x1a2/0x420 mm/slub.c:4682
 nft_synproxy_eval_v4+0x3d2/0x610 net/netfilter/nft_synproxy.c:60
 nft_synproxy_do_eval+0x362/0xa60 net/netfilter/nft_synproxy.c:141
 expr_call_ops_eval net/netfilter/nf_tables_core.c:240 [inline]
 nft_do_chain+0x4ad/0x1da0 net/netfilter/nf_tables_core.c:288
 nft_do_chain_inet+0x418/0x6b0 net/netfilter/nft_chain_filter.c:161
 nf_hook_entry_hookfn include/linux/netfilter.h:154 [inline]
 nf_hook_slow+0xc3/0x220 net/netfilter/core.c:626
 nf_hook include/linux/netfilter.h:269 [inline]
 NF_HOOK+0x29e/0x450 include/linux/netfilter.h:312
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5662 [inline]
 __netif_receive_skb+0x2bf/0x650 net/core/dev.c:5775
 process_backlog+0x662/0x15b0 net/core/dev.c:6107
 __napi_poll+0xcb/0x490 net/core/dev.c:6771
 napi_poll net/core/dev.c:6840 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6962
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 neigh_periodic_work+0xb35/0xd50 net/core/neighbour.c:1019
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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


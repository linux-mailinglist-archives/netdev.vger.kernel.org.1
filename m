Return-Path: <netdev+bounces-128441-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5872497989D
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 21:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0EFAB21251
	for <lists+netdev@lfdr.de>; Sun, 15 Sep 2024 19:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DB9D1C9ECA;
	Sun, 15 Sep 2024 19:59:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FF11C9DDE
	for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 19:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726430369; cv=none; b=SE20qQJMhSWZtxwMjOOmSXcU0mfHPLr1KB5tDizjrvghPkVbixpdkmKJRBDX3Ct7rOO+t92SoXjyWZ21C7D2DvU3aUrGPV0Wd4g3l0yGCJhSipfUbYnI0Yfm4y+0JU0ZAy19w8qrM45qyhP/h/E2yLaYtWj0SIWfXV+EjVmLxQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726430369; c=relaxed/simple;
	bh=EAtdUd/bODgaGMnBQFDTfdmPWq8uuLS/MUbI9F2sZII=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N4VENKX0lcT2EhLtV1tv3saAVF5cqUBMUSU9koTQCq3emICCeMKizQzQ4bl+gK09G6eVWfD2z+FbrOzEFezD4US7HWn6FGWu3gbf9l3yu0pQSfTf0CSOXTZZAf3s7wp9+nTsKwdbehxcmUJVOkC/b22Zl+eefHNqgXyZAsaG+7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-82ce92f8779so589884939f.3
        for <netdev@vger.kernel.org>; Sun, 15 Sep 2024 12:59:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726430367; x=1727035167;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=r+R46sj0H/ECJLW7wH8uaFfa8zNjK2RSDJLcygibxVA=;
        b=jT5XVuEl8FAfmb1mx2rbBwEaUU7N5/VYGnLuka8IRxtO+AWeF+qovHaDA2MmFkjv9l
         7QvRIXqyGiwzoh0qCbdVJ1R5sh0A2Pz7bo/zKwCjuLJ3DOA3rPqGicSkN1i4RQay+GUK
         ZEUibNGC+RiR2FzP25KbP8eD8yEXurRw0eASzC7/3Q3dqjWhD4tIDki7/t1LmxZJOumU
         RMjfnbUuK1b30Z/8rmXbV4dmd6qd4dXXR1lgRDnky8HKTOa1q+YeGWJsBRO/m0ujNfKr
         dQxluNc+nHv/r1Wu6J/SU9YUywMtDTbZN8d2JtUmKOSm4JdLbZnqjAnRn1SjhmROLjpS
         3e9g==
X-Forwarded-Encrypted: i=1; AJvYcCUcH4NSMCJR/+zYgq1tWD8ckxJVg0hX1xiBh6yYhnPt2RLwLGnz6qoeNJl7a6JepqPDvZkkI+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YykZY8KUoclKnCNcM8YY+bS5qWOnnkbFwzWHMz+w5RCdFQmlHMx
	/n9qbN08nG+t4lTpvRx+Pk8NOLeHPXAm/r8LbXSD3aOr7K7S1jqENH7F0Sk4hsNMzeHGuDFd1Kd
	ZkYoK1TUrYGHmi+Yj7vvinetuRX5amjytENMuAV3RTP0i3eIK4q+TaWs=
X-Google-Smtp-Source: AGHT+IEp3HvOQmQs1z8FNNGe24MblIC1ocazuM84Ta50vr+h7lVmC579ik8Zk3vFgY7Ztfs6xpuWtC6h0VtgvLeH2jw+GNNHGqqP
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1cad:b0:3a0:9fc6:5437 with SMTP id
 e9e14a558f8ab-3a09fc656cfmr15932415ab.18.1726430366748; Sun, 15 Sep 2024
 12:59:26 -0700 (PDT)
Date: Sun, 15 Sep 2024 12:59:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000bd671b06222de427@google.com>
Subject: [syzbot] [wireguard?] INFO: task hung in tun_chr_close (5)
From: syzbot <syzbot+b0ae8f1abf7d891e0426@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7c6a3a65ace7 minmax: reduce min/max macro expansion in ato..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=140a20a9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=28869f34c32848cf
dashboard link: https://syzkaller.appspot.com/bug?extid=b0ae8f1abf7d891e0426
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/57e94d370ef7/disk-7c6a3a65.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ce7cfa54ff9/vmlinux-7c6a3a65.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bfe1c98724fe/bzImage-7c6a3a65.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0ae8f1abf7d891e0426@syzkaller.appspotmail.com

INFO: task syz-executor:5223 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc7-syzkaller-00021-g7c6a3a65ace7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21792 pid:5223  tgid:5223  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 tun_detach drivers/net/tun.c:698 [inline]
 tun_chr_close+0x3e/0x230 drivers/net/tun.c:3510
 __fput+0x408/0xbb0 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2bb0 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6f4917c93c
RSP: 002b:00007ffd64f1bea0 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 0000000000000003 RCX: 00007f6f4917c93c
RDX: 0000000000000028 RSI: 00007ffd64f1bf50 RDI: 00000000000000f9
RBP: 00007ffd64f1befc R08: 0000000000000000 R09: 0079746972756365
R10: 00007f6f493087e0 R11: 0000000000000246 R12: 000000000000005f
R13: 00000000000529a3 R14: 000000000005292a R15: 00007ffd64f1bf50
 </TASK>
INFO: task syz-executor:5234 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc7-syzkaller-00021-g7c6a3a65ace7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:23040 pid:5234  tgid:5234  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 tun_detach drivers/net/tun.c:698 [inline]
 tun_chr_close+0x3e/0x230 drivers/net/tun.c:3510
 __fput+0x408/0xbb0 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xaa3/0x2bb0 kernel/exit.c:882
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1031
 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4023d7fdea
RSP: 002b:00007ffcbd595968 EFLAGS: 00000206 ORIG_RAX: 0000000000000036
RAX: 0000000000000000 RBX: 00007ffcbd5959f0 RCX: 00007f4023d7fdea
RDX: 0000000000000040 RSI: 0000000000000029 RDI: 0000000000000003
RBP: 0000000000000003 R08: 0000000000000558 R09: 0079746972756365
R10: 00007f4023f07a60 R11: 0000000000000206 R12: 00007f4023f07a00
R13: 00007ffcbd59598c R14: 0000000000000000 R15: 00007f4023f08e40
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/0:1/9:
3 locks held by kworker/u8:0/11:
 #0: ffff88801ac89148 ((wq_completion)events_unbound){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90000107d80 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8fa35ca8 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0x51/0xc0 net/core/link_watch.c:276
4 locks held by kworker/1:0/25:
1 lock held by khungtaskd/30:
 #0: ffffffff8ddb9fe0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8ddb9fe0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8ddb9fe0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6626
4 locks held by kworker/u8:5/63:
 #0: ffff88801bae3148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc900015e7d80 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8fa20290 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0xbb/0xbb0 net/core/net_namespace.c:594
 #3: ffffffff8fa35ca8 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1b/0x230 drivers/net/wireguard/device.c:414
2 locks held by kworker/u8:8/2961:
2 locks held by getty/4978:
 #0: ffff88823bd5c8a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2211
1 lock held by syz-executor/5223:
 #0: ffffffff8fa35ca8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fa35ca8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3e/0x230 drivers/net/tun.c:3510
1 lock held by syz-executor/5225:
 #0: ffffffff8fa35ca8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fa35ca8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3e/0x230 drivers/net/tun.c:3510
1 lock held by syz-executor/5234:
 #0: ffffffff8fa35ca8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers/net/tun.c:698 [inline]
 #0: ffffffff8fa35ca8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3e/0x230 drivers/net/tun.c:3510
1 lock held by syz-executor/5233:
2 locks held by kworker/1:5/5281:
2 locks held by kworker/1:6/5283:
5 locks held by kworker/0:4/5312:
3 locks held by kworker/0:5/5313:
3 locks held by kworker/0:6/5320:
3 locks held by kworker/0:7/5321:
 #0: ffff88801ac80948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc900040a7d80 ((work_completion)(&w->work)#2){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8fae8fe8 (nf_conntrack_mutex){+.+.}-{3:3}, at: nf_ct_iterate_cleanup+0x4b/0x500 net/netfilter/nf_conntrack_core.c:2403
3 locks held by kworker/1:9/10282:
2 locks held by syz-executor/10298:
1 lock held by syz-executor/10299:

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc7-syzkaller-00021-g7c6a3a65ace7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf0c/0x1240 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5312 Comm: kworker/0:4 Not tainted 6.11.0-rc7-syzkaller-00021-g7c6a3a65ace7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:__sanitizer_cov_trace_pc+0x18/0x70 kernel/kcov.c:212
Code: 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 65 48 8b 15 a4 0a 78 7e 65 8b 05 a5 0a 78 7e a9 00 01 ff 00 <48> 8b 34 24 74 1d f6 c4 01 74 43 a9 00 00 0f 00 75 3c a9 00 00 f0
RSP: 0018:ffffc90000007978 EFLAGS: 00000206
RAX: 0000000000000102 RBX: 0000000000000001 RCX: ffffffff88f20744
RDX: ffff888032b89e00 RSI: 0000000000000000 RDI: 0000000000000001
RBP: ffff88806b965500 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90000007c00
R13: 000000000003db0c R14: ffffffff88f244f1 R15: 000000000000001b
FS:  0000000000000000(0000) GS:ffff8880b8800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fb6cf5ffd00 CR3: 00000000693da000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 __netif_receive_skb_core.constprop.0+0x139/0x4330 net/core/dev.c:5463
 __netif_receive_skb_one_core+0xb1/0x1e0 net/core/dev.c:5659
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:5775
 process_backlog+0x443/0x15f0 net/core/dev.c:6108
 __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6772
 napi_poll net/core/dev.c:6841 [inline]
 net_rx_action+0xa92/0x1010 net/core/dev.c:6963
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 do_softirq kernel/softirq.c:455 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:442
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
 nsim_dev_trap_report_work+0x870/0xc80 drivers/net/netdevsim/dev.c:850
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xed0 kernel/workqueue.c:3389
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
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


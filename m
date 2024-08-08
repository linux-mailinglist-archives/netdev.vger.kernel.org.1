Return-Path: <netdev+bounces-117026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0478A94C636
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 23:14:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 27EAF1C213D7
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 21:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A504156887;
	Thu,  8 Aug 2024 21:14:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62BA1494CF
	for <netdev@vger.kernel.org>; Thu,  8 Aug 2024 21:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723151668; cv=none; b=H6X0wSXEia8V/aGTmuj6e99jeAyIWug251b/BkDdntM5/Imjv67lqVxnGxJ9bRQUvICt+/ih750mNix1HNt+wWHTgvg6T2mcAl4+CASBq47Jq7uMnQb8kS8uxLT96siTGAiiul4EIOrUl9GWmBCemPGchZSVPSpP4cGENAMmKzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723151668; c=relaxed/simple;
	bh=tSNZKgsc3kPXSya+NIOXyjf6yjqOBaxjOhce6sf5NyI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UXUe4t4ZZe3r6cUiJ3AAlBBHhrR77LP5Bow7hlmbpv3o6XIJUoNWLvfGOp+Fzi9YdIrIe+IcNEN2eqW4fdmRiOLhF2lNBPxwC5EyHS6urZrIHDb2JcSpoLV6zcAqU9vRe35Mu9EulHSowx/0pjQr9bfLFhJ0UPTcdtwgqJqztKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f7fa42463so155013539f.0
        for <netdev@vger.kernel.org>; Thu, 08 Aug 2024 14:14:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723151666; x=1723756466;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hkdamuIrmwQomvVS+feR+rIn/1MqhTDzxGSyh/B+yWg=;
        b=G1GQcjTL8lXPTuWXIuQ8W/txWy+Ye8DXhEcKculg01SbCPyqamTbTRX77DFcUeZ5eD
         C0xF0rJvonH/JL97fO9M8itwy8/GP0YZT39csn+ZrGsJ6Jh5P8vBepn372BoUPXqjgp8
         p+RKZj0Ep1Tbs+3Xl3QiMyU2igLxPv7Xv2sglbriL7QhnYuxcPV0sAjuIOAfQM7SvuGO
         eH2YuQn7dfQERVDkETCCMHl2F5PEEa7+nI8JsCpmBhuBWAngdNBcaI41lU0N6nkXwtuE
         xgj07jOL3z7I4PoZkNecKK9dsDGsnwxmYJ1++XzSPYKo4IMhzsiewJZV1BkVkopMia1q
         fzmQ==
X-Forwarded-Encrypted: i=1; AJvYcCVGhJD9a+EXbZOFdUf12UOmAomCRrJPx4BzH1xpJ3pZG7oKATlN5zUY113U7LSoxNQAXkMC8zc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxp75q7hJ7/bI5jNtYVsZsnTroFAZv4+FVlj6YMP4pdX+hYz8Vy
	5g3Qv5TTKUxWnnrvdIojUqB4y2lqel6rnO1ptuHSLALFMwJyzi1b7M5mHM5F/WdeFgUtFsjqX1j
	XplBdNFwSDyTDCTVZIRkBYy4dPjcuShxdUCxLmRwTOxaFUuns2i/8S+k=
X-Google-Smtp-Source: AGHT+IG4UzEzC+Dbj0ew52idNZjIE3mdlxQqJajT3ESZqARfvfLGisC8EIQ2fA5gpWy87zhzVlU09DJH4o4qB0q/hJjZQrTp//9/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d05:b0:81f:8a37:ba7d with SMTP id
 ca18e2360f4ac-8225464b3aamr9816339f.2.1723151665814; Thu, 08 Aug 2024
 14:14:25 -0700 (PDT)
Date: Thu, 08 Aug 2024 14:14:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000ef73a7061f328276@google.com>
Subject: [syzbot] [net?] INFO: task hung in switchdev_deferred_process_work (3)
From: syzbot <syzbot+d6bbe0f5705cb8a5aa2b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, ivecera@redhat.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6a0e38264012 Merge tag 'for-6.11-rc2-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10a743bd980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e8a2eef9745ade09
dashboard link: https://syzkaller.appspot.com/bug?extid=d6bbe0f5705cb8a5aa2b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/f1018acfe5a8/disk-6a0e3826.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/37710edcbb1b/vmlinux-6a0e3826.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9841884ce0f2/bzImage-6a0e3826.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6bbe0f5705cb8a5aa2b@syzkaller.appspotmail.com

INFO: task kworker/1:6:5286 blocked for more than 143 seconds.
      Not tainted 6.11.0-rc2-syzkaller-00027-g6a0e38264012 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:6     state:D stack:19696 pid:5286  tgid:5286  ppid:2      flags:0x00004000
Workqueue: events switchdev_deferred_process_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/1:0:14193 blocked for more than 144 seconds.
      Not tainted 6.11.0-rc2-syzkaller-00027-g6a0e38264012 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/1:0     state:D stack:24112 pid:14193 tgid:14193 ppid:2      flags:0x00004000
Workqueue: events linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 linkwatch_event+0xe/0x60 net/core/link_watch.c:276
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2e/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz.3.2878:15189 blocked for more than 145 seconds.
      Not tainted 6.11.0-rc2-syzkaller-00027-g6a0e38264012 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.2878      state:D stack:27392 pid:15189 tgid:15188 ppid:14102  flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 vlan_ioctl_handler+0x112/0x9d0 net/8021q/vlan.c:553
 sock_ioctl+0x685/0x8e0 net/socket.c:1305
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa1a89779f9
RSP: 002b:00007fa1a976a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa1a8b05f80 RCX: 00007fa1a89779f9
RDX: 0000000020000300 RSI: 0000000000008982 RDI: 0000000000000003
RBP: 00007fa1a89e58ee R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa1a8b05f80 R15: 00007ffc6accc348
 </TASK>
INFO: task syz.3.2878:15192 blocked for more than 146 seconds.
      Not tainted 6.11.0-rc2-syzkaller-00027-g6a0e38264012 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.2878      state:D stack:27392 pid:15192 tgid:15188 ppid:14102  flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0x1800/0x4a60 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a4/0xd70 kernel/locking/mutex.c:752
 sock_ioctl+0x664/0x8e0 net/socket.c:1303
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfe/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa1a89779f9
RSP: 002b:00007fa1a9749038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa1a8b06058 RCX: 00007fa1a89779f9
RDX: 0000000020000000 RSI: 0000000000008983 RDI: 0000000000000003
RBP: 00007fa1a89e58ee R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007fa1a8b06058 R15: 00007ffc6accc348
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e9382a0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 #0: ffffffff8e9382a0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:838 [inline]
 #0: ffffffff8e9382a0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6620
1 lock held by khugepaged/37:
 #0: ffffffff8e9f21a8 (lock#3){+.+.}-{3:3}, at: __lru_add_drain_all+0x66/0x560 mm/swap.c:875
2 locks held by kworker/1:1/51:
3 locks held by kworker/u8:3/52:
4 locks held by kworker/u8:8/1100:
 #0: ffff8880166e5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff8880166e5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc900041cfd00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc900041cfd00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fc74e90 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:594
 #3: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: cleanup_net+0x6af/0xcc0 net/core/net_namespace.c:630
3 locks held by kworker/u8:9/1105:
 #0: ffff88802aab5948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88802aab5948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90003dcfd00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90003dcfd00 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x19/0x30 net/ipv6/addrconf.c:4734
6 locks held by kworker/u9:1/4615:
 #0: ffff88805d2d7148 ((wq_completion)hci12){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff88805d2d7148 ((wq_completion)hci12){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000d397d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000d397d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff8880478f8d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
 #3: ffff8880478f8078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5512
 #4: ffffffff8fded328 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1962 [inline]
 #4: ffffffff8fded328 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x185/0x340 net/bluetooth/hci_conn.c:1265
 #5: ffffffff8e93d678 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:296 [inline]
 #5: ffffffff8e93d678 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:958
2 locks held by getty/4977:
 #0: ffff8880291580a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000311b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6ac/0x1e00 drivers/tty/n_tty.c:2211
5 locks held by kworker/1:5/5285:
3 locks held by kworker/1:6/5286:
 #0: ffff888015878948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015878948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90002f97d00 (deferred_process_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90002f97d00 (deferred_process_work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
3 locks held by kworker/1:0/14193:
 #0: ffff888015878948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff888015878948 ((wq_completion)events){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc9000491fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc9000491fd00 ((linkwatch_work).work){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: linkwatch_event+0xe/0x60 net/core/link_watch.c:276
5 locks held by kworker/u9:0/14681:
 #0: ffff8880308a7948 ((wq_completion)hci11){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3206 [inline]
 #0: ffff8880308a7948 ((wq_completion)hci11){+.+.}-{0:0}, at: process_scheduled_works+0x90a/0x1830 kernel/workqueue.c:3312
 #1: ffffc90009f4fd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3207 [inline]
 #1: ffffc90009f4fd00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x945/0x1830 kernel/workqueue.c:3312
 #2: ffff8880409ccd80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
 #3: ffff8880409cc078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5512
 #4: ffffffff8e93d678 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:328 [inline]
 #4: ffffffff8e93d678 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:958
2 locks held by syz.3.2878/15189:
 #0: ffffffff8fc66648 (vlan_ioctl_mutex){+.+.}-{3:3}, at: sock_ioctl+0x664/0x8e0 net/socket.c:1303
 #1: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: vlan_ioctl_handler+0x112/0x9d0 net/8021q/vlan.c:553
1 lock held by syz.3.2878/15192:
 #0: ffffffff8fc66648 (vlan_ioctl_mutex){+.+.}-{3:3}, at: sock_ioctl+0x664/0x8e0 net/socket.c:1303
1 lock held by syz-executor/15196:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
7 locks held by syz.2.2883/15200:
4 locks held by syz.1.2886/15210:
 #0: ffffffff8fce7170 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffff888051270678 (nlk_cb_mutex-GENERIC){+.+.}-{3:3}, at: __netlink_dump_start+0x119/0x780 net/netlink/af_netlink.c:2404
 #2: ffffffff8fce7028 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #2: ffffffff8fce7028 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #2: ffffffff8fce7028 (genl_mutex){+.+.}-{3:3}, at: genl_dumpit+0xd6/0x1a0 net/netlink/genetlink.c:1026
 #3: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: nl802154_prepare_wpan_dev_dump+0x4b/0x460 net/ieee802154/nl802154.c:262
2 locks held by syz.5.2897/15236:
 #0: ffffffff8fce7170 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8fce7028 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8fce7028 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8fce7028 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x121/0xec0 net/netlink/genetlink.c:1209
1 lock held by syz-executor/15240:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
2 locks held by syz.4.2900/15244:
 #0: ffff88805bb600e0 (&type->s_umount_key#54/1){+.+.}-{3:3}, at: alloc_super+0x221/0x9d0 fs/super.c:344
 #1: ffffffff8e9f21a8 (lock#3){+.+.}-{3:3}, at: __lru_add_drain_all+0x66/0x560 mm/swap.c:875
1 lock held by syz-executor/15245:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/15248:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/15251:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/15254:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/15258:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/15261:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/15264:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/15267:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/15270:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/15273:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/15276:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/15279:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/15282:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/15285:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/15290:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644
1 lock held by syz-executor/15293:
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc81a08 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6644

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-rc2-syzkaller-00027-g6a0e38264012 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xfee/0x1030 kernel/hung_task.c:379
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 15200 Comm: syz.2.2883 Not tainted 6.11.0-rc2-syzkaller-00027-g6a0e38264012 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/27/2024
RIP: 0010:unwind_next_frame+0x192d/0x2a00
Code: 24 48 74 08 4c 89 f7 e8 11 81 b9 00 49 89 1e 42 0f b6 44 2d 00 84 c0 0f 85 61 0e 00 00 48 8b 44 24 20 c6 00 00 4c 8b 74 24 48 <48> 8b 6c 24 28 48 8b 44 24 38 42 0f b6 04 28 84 c0 0f 85 ea 0b 00
RSP: 0018:ffffc90000a17d48 EFLAGS: 00000002
RAX: ffffc90000a17e70 RBX: ffffc90000a17e58 RCX: 0000000000000000
RDX: 0000000000000010 RSI: 0000000000000000 RDI: ffffc90000a17e80
RBP: ffffc90000a17e68 R08: ffffc90000a17e7f R09: ffffc90000a17e70
R10: dffffc0000000000 R11: fffff52000142fd0 R12: ffffc90000a182b8
R13: dffffc0000000000 R14: ffffc90000a17e70 R15: 1ffff92000142fc4
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c295cfe CR3: 000000000e734000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 arch_stack_walk+0x151/0x1b0 arch/x86/kernel/stacktrace.c:25
 stack_trace_save+0x118/0x1d0 kernel/stacktrace.c:122
 kasan_save_stack mm/kasan/common.c:47 [inline]
 kasan_save_track+0x3f/0x80 mm/kasan/common.c:68
 poison_kmalloc_redzone mm/kasan/common.c:370 [inline]
 __kasan_kmalloc+0x98/0xb0 mm/kasan/common.c:387
 kasan_kmalloc include/linux/kasan.h:211 [inline]
 __kmalloc_cache_noprof+0x19c/0x2c0 mm/slub.c:4189
 kmalloc_noprof include/linux/slab.h:681 [inline]
 dummy_urb_enqueue+0x7d/0x760 drivers/usb/gadget/udc/dummy_hcd.c:1271
 usb_hcd_submit_urb+0x36e/0x1e80 drivers/usb/core/hcd.c:1533
 ath9k_hif_usb_reg_in_cb+0x472/0x650 drivers/net/wireless/ath/ath9k/hif_usb.c:792
 __usb_hcd_giveback_urb+0x42e/0x6e0 drivers/usb/core/hcd.c:1650
 dummy_timer+0x830/0x45a0 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x59d/0xd50 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x396/0x990 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x112/0x3f0 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x52/0xc0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:note_gp_changes+0x4/0x360 kernel/rcu/tree.c:1304
Code: 90 90 90 90 90 90 f3 0f 1e fa e9 42 9a 75 0a 0f 1f 80 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <55> 48 89 e5 41 57 41 56 41 55 41 54 53 48 83 e4 e0 48 81 ec a0 00
RSP: 0018:ffffc90000a18bf8 EFLAGS: 00000202
RAX: 0000000000000000 RBX: ffff888027624044 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff8c0c2480 RDI: ffff8880b933f940
RBP: ffffc90000a18e30 R08: ffffffff9017c4ef R09: 1ffffffff202f89d
R10: dffffc0000000000 R11: fffffbfff202f89e R12: ffff888027623c00
R13: 1ffffffff1cc1421 R14: 0000000000000009 R15: ffff8880b933f940
 rcu_check_quiescent_state kernel/rcu/tree.c:2453 [inline]
 rcu_core+0x2e4/0x1830 kernel/rcu/tree.c:2827
 handle_softirqs+0x2c6/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:arch_atomic_read arch/x86/include/asm/atomic.h:23 [inline]
RIP: 0010:raw_atomic_read include/linux/atomic/atomic-arch-fallback.h:457 [inline]
RIP: 0010:rcu_dynticks_curr_cpu_in_eqs include/linux/context_tracking.h:122 [inline]
RIP: 0010:rcu_is_watching+0x5a/0xb0 kernel/rcu/tree.c:726
Code: f0 48 c1 e8 03 42 80 3c 38 00 74 08 4c 89 f7 e8 cc fe 80 00 48 c7 c3 78 7c 03 00 49 03 1e 48 89 d8 48 c1 e8 03 42 0f b6 04 38 <84> c0 75 22 8b 03 65 ff 0d 71 25 8a 7e 74 10 83 e0 04 c1 e8 02 5b
RSP: 0018:ffffc9000939f120 EFLAGS: 00000212
RAX: 0000000000000000 RBX: ffff8880b9337c78 RCX: ffffffff816fbbe4
RDX: 0000000000000000 RSI: ffffffff8c605ee0 RDI: ffffffff8c605ea0
RBP: ffffc9000939f298 R08: ffffffff9017c4ef R09: 1ffffffff202f89d
R10: dffffc0000000000 R11: fffffbfff202f89e R12: 1ffff92001273e30
R13: dffffc0000000000 R14: ffffffff8e293a48 R15: dffffc0000000000
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0xe3/0x550 kernel/locking/lockdep.c:5730
 rcu_lock_acquire include/linux/rcupdate.h:326 [inline]
 rcu_read_lock include/linux/rcupdate.h:838 [inline]
 page_ext_get+0x3d/0x2a0 mm/page_ext.c:535
 page_table_check_clear+0x4b/0x550 mm/page_table_check.c:74
 get_and_clear_full_ptes include/linux/pgtable.h:678 [inline]
 zap_present_folio_ptes mm/memory.c:1493 [inline]
 zap_present_ptes mm/memory.c:1576 [inline]
 zap_pte_range mm/memory.c:1618 [inline]
 zap_pmd_range mm/memory.c:1736 [inline]
 zap_pud_range mm/memory.c:1765 [inline]
 zap_p4d_range mm/memory.c:1786 [inline]
 unmap_page_range+0x2b48/0x42c0 mm/memory.c:1807
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1897
 exit_mmap+0x264/0xc80 mm/mmap.c:3412
 __mmput+0x115/0x390 kernel/fork.c:1345
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x27f0 kernel/exit.c:869
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 get_signal+0x16a1/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd95bf77a33
Code: Unable to access opcode bytes at 0x7fd95bf77a09.
RSP: 002b:00007fff84fc0cf8 EFLAGS: 00000246 ORIG_RAX: 0000000000000009
RAX: 00007fd95cd0f000 RBX: 00007fd95a2006c0 RCX: 00007fd95bf77a33
RDX: 0000000000000000 RSI: 0000000000021000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000020022 R11: 0000000000000246 R12: 00007fff84fc0e50
R13: ffffffffffffffc0 R14: 0000000000001000 R15: 0000000000000000
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


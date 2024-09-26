Return-Path: <netdev+bounces-130003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4F519878C3
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 19:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 886A2280EF3
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 17:58:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E642163A9B;
	Thu, 26 Sep 2024 17:58:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F65615CD6E
	for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 17:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727373517; cv=none; b=E2chdaVqNCIeYl8FCW23VLHRFmhoJI04U4zkzEWoy2qEzSXiDsH9qnzfXHvXjPae9ms9oCOu2h1+aHfFoTjIW7klYPJqZ2Lhb5W7MWfTFnbetVdXggBNl4zlR5PDaDwxPsooV6Uh/JnDK9ydf/fRLERn4XVH4/W17kQkVn+Elr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727373517; c=relaxed/simple;
	bh=mYoZfJ7rJHTLWz7Jrz6fUKhfw5Od/bwZrikzUZ3YxM0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QELLKDdAlL7UoVrr4Nt4Yi4ykG6giBjQTqQQYerYCj8QAzALZ6KQL1RH6xVpNqF3/W5VbHE9IaQPqL5SA8KVjMkPD/3qWSP4w9Eu11IjiHbNOoP5JImQ7XaBqdoCnqU2sVMVyhz2jNlD3Tl0Sd/+yBG/r32vGrmxC9JWkPLs0AQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a04af50632so14992085ab.2
        for <netdev@vger.kernel.org>; Thu, 26 Sep 2024 10:58:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727373514; x=1727978314;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mqbg/G1Qqb3SDuRBHnL7UJAlvnqCWO97kX/Z1hwQYMA=;
        b=Zp/L8cN0QCh3jfcUu8dKJUgK2ulFug6IUvz87Z64efS9rumADJq+GNxD4g1ynoYsGy
         /ynW6w6a/4/7iV4Mw58foiOetHuCcduDKvHu048uxlCa+XhH+coQgkZkLXfsqOMh4J2T
         7JzncFLpnEMxeooPrmQEimrZMi2wNKtNoOXgFvJqWfECVGvHhhpEAxmAZhGgKAr8FKzT
         UxoaEh3eKlBgkAUGKw9tD7J6oVxhpiujxBC9kGRldFOOS31BxxxqmENYLg5JXSHkPKiK
         c8WokaBFpTWUslo6ojWT2zrTbyKrEmeeJ3On9FwhkrjDY1tdNl2UrDQxvzRiapK20TKs
         gAyw==
X-Forwarded-Encrypted: i=1; AJvYcCUTOi1Y+TgDfo7c18EiDOcaZ2KUAQebl8Rvjd/VUrUD4M9SztRoDqJRhSYeKZCL9tCUbdSfnfg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5lIAexkfA0QYs8KvoHZoY7ljb1CE7KJ13CJqvdPuV3P1f3T55
	hswoC5+umVRDOQZzPYCvfO5FdlAW5cI/0FVSIWARAlCDlU+P3rjtE5rKdTrjsPbAM9dep5nSoM1
	emNeLXkGhvol5/kAH+bxp1BCxsXNn6qwn+9DIG1L030kGaSAas/KVmr0=
X-Google-Smtp-Source: AGHT+IH0qkzCt/10y9uap+fcCWi0ObxOHycvujtCG2TODIHkOKg5Dp9Hq9qcTHvv5wgg0QmUdBRu4qp/Xd9ItoxisX1gjPssUeQs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca8:b0:3a0:be93:e8d5 with SMTP id
 e9e14a558f8ab-3a3451787cfmr2804925ab.11.1727373514661; Thu, 26 Sep 2024
 10:58:34 -0700 (PDT)
Date: Thu, 26 Sep 2024 10:58:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f5a0ca.050a0220.46d20.0002.GAE@google.com>
Subject: [syzbot] [net?] INFO: task hung in new_device_store (5)
From: syzbot <syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    97d8894b6f4c Merge tag 'riscv-for-linus-6.12-mw1' of git:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12416a27980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=bc30a30374b0753
dashboard link: https://syzkaller.appspot.com/bug?extid=05f9cecd28e356241aba
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bd119f4fdc08/disk-97d8894b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4d0bfed66f93/vmlinux-97d8894b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0f9223ac9bfb/bzImage-97d8894b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com

INFO: task syz-executor:9916 blocked for more than 143 seconds.
      Not tainted 6.11.0-syzkaller-10045-g97d8894b6f4c #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21104 pid:9916  tgid:9916  ppid:1      flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6674
 __schedule_loop kernel/sched/core.c:6751 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6766
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6823
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 new_device_store+0x1b4/0x890 drivers/net/netdevsim/bus.c:166
 kernfs_fop_write_iter+0x3a2/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6f/0xc90 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8310d7c9df
RSP: 002b:00007ffe830a52e0 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f8310d7c9df
RDX: 0000000000000003 RSI: 00007ffe830a5330 RDI: 0000000000000005
RBP: 00007f8310df1c39 R08: 0000000000000000 R09: 00007ffe830a5137
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 00007ffe830a5330 R14: 00007f8311a64620 R15: 0000000000000003
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937ee0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6701
2 locks held by dhcpcd/4889:
 #0: ffffffff8fcb2768 (vlan_ioctl_mutex){+.+.}-{3:3}, at: sock_ioctl+0x661/0x8e0 net/socket.c:1309
 #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: vlan_ioctl_handler+0x112/0x9d0 net/8021q/vlan.c:553
2 locks held by getty/4987:
 #0: ffff88802e9670a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by kworker/u9:3/5233:
 #0: ffff888056ad8948 ((wq_completion)hci11){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888056ad8948 ((wq_completion)hci11){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003ea7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003ea7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff88807d3c8d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
3 locks held by kworker/u9:7/5244:
 #0: ffff88806a282148 ((wq_completion)hci8){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88806a282148 ((wq_completion)hci8){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003dd7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003dd7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff88807da48d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
3 locks held by kworker/0:5/5288:
5 locks held by kworker/u8:22/5927:
 #0: ffff88801bae5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801bae5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003f87d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003f87d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:580
 #3: ffff88805dd75428 (&wg->device_update_lock){+.+.}-{3:3}, at: wg_destruct+0x110/0x2e0 drivers/net/wireguard/device.c:249
 #4: ffffffff8e93d478 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:329 [inline]
 #4: ffffffff8e93d478 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x451/0x830 kernel/rcu/tree_exp.h:976
2 locks held by kworker/u8:25/6021:
2 locks held by syz.1.563/8002:
4 locks held by syz-executor/9916:
 #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2930 [inline]
 #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #1: ffff88802e71e488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff888144ff5968 (kn->active#50){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f56d3e8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: new_device_store+0x1b4/0x890 drivers/net/netdevsim/bus.c:166
7 locks held by syz-executor/9976:
 #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2930 [inline]
 #0: ffff88807ca86420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #1: ffff88807abc2888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff888144ff5a58 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f56d3e8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 #4: ffff888060f5a0e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff888060f5a0e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff888060f5a0e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
 #5: ffff888060f5b250 (&devlink->lock_key#40){+.+.}-{3:3}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x71/0x5c0 drivers/net/netdevsim/netdev.c:773
2 locks held by syz-executor/10321:
 #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: cangw_pernet_exit_batch+0x20/0x90 net/can/gw.c:1257
2 locks held by syz-executor/10324:
 #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: mpls_net_exit+0x7d/0x2a0 net/mpls/af_mpls.c:2706
2 locks held by syz-executor/10327:
 #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: mpls_net_exit+0x7d/0x2a0 net/mpls/af_mpls.c:2706
2 locks held by syz-executor/10333:
 #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: default_device_exit_batch+0xe9/0xaa0 net/core/dev.c:11930
2 locks held by syz-executor/10354:
 #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: ppp_exit_net+0xe3/0x3d0 drivers/net/ppp/ppp_generic.c:1146
1 lock held by syz-executor/10357:
 #0: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: __tun_chr_ioctl+0x48c/0x2400 drivers/net/tun.c:3121
2 locks held by syz-executor/10362:
 #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1f/0x1e0 drivers/net/wireguard/device.c:414
2 locks held by syz-executor/10366:
 #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1f/0x1e0 drivers/net/wireguard/device.c:414
2 locks held by syz-executor/10368:
 #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1f/0x1e0 drivers/net/wireguard/device.c:414
2 locks held by syz-executor/10371:
 #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+0x1f/0x1e0 drivers/net/wireguard/device.c:414
5 locks held by kworker/u9:0/10373:
 #0: ffff888056f3b948 ((wq_completion)hci9){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888056f3b948 ((wq_completion)hci9){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90004127d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90004127d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff88806eb10d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
 #3: ffff88806eb10078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5567
 #4: ffffffff8fe3a428 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff8fe3a428 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1262
2 locks held by syz-executor/10378:
 #0: ffffffff8fcc1150 (pernet_ops_rwsem){++++}-{3:3}, at: copy_net_ns+0x328/0x570 net/core/net_namespace.c:490
 #1: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: ip_tunnel_init_net+0x20e/0x720 net/ipv4/ip_tunnel.c:1159
1 lock held by syz-executor/10386:
 #0: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fccdc48 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.11.0-syzkaller-10045-g97d8894b6f4c #0
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
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 5288 Comm: kworker/0:5 Not tainted 6.11.0-syzkaller-10045-g97d8894b6f4c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Workqueue: events_power_efficient neigh_periodic_work
RIP: 0010:check_preemption_disabled+0x19/0x120 lib/smp_processor_id.c:14
Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 41 57 41 56 41 54 53 48 83 ec 10 65 48 8b 04 25 28 00 00 00 48 89 44 24 08 <65> 8b 1d 4c 35 40 74 65 8b 05 41 35 40 74 a9 ff ff ff 7f 74 26 65
RSP: 0018:ffffc90000007948 EFLAGS: 00000086
RAX: 8ad5e30e88cbef00 RBX: 0000000000000000 RCX: ffffffff81701614
RDX: 0000000000000000 RSI: ffffffff8c60efa0 RDI: ffffffff8c60ef60
RBP: ffffc90000007ae8 R08: ffffffff901ca4af R09: 1ffffffff2039495
R10: dffffc0000000000 R11: fffffbfff2039496 R12: 1ffff92000000f3c
R13: dffffc0000000000 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2fb1bff8 CR3: 000000000e734000 CR4: 0000000000350ef0
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 rcu_is_watching_curr_cpu include/linux/context_tracking.h:128 [inline]
 rcu_is_watching+0x15/0xb0 kernel/rcu/tree.c:737
 trace_lock_acquire include/trace/events/lock.h:24 [inline]
 lock_acquire+0xe3/0x550 kernel/locking/lockdep.c:5793
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 debug_object_active_state+0x15d/0x360 lib/debugobjects.c:936
 debug_rcu_head_unqueue kernel/rcu/rcu.h:233 [inline]
 rcu_do_batch kernel/rcu/tree.c:2559 [inline]
 rcu_core+0xa21/0x17a0 kernel/rcu/tree.c:2823
 handle_softirqs+0x2c7/0x980 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 neigh_periodic_work+0xb35/0xd50 net/core/neighbour.c:1019
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa65/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f2/0x390 kernel/kthread.c:389
 ret_from_fork+0x4d/0x80 arch/x86/kernel/process.c:147
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


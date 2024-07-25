Return-Path: <netdev+bounces-112984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAC9493C1CC
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 14:21:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C75E61C20402
	for <lists+netdev@lfdr.de>; Thu, 25 Jul 2024 12:21:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1951993BA;
	Thu, 25 Jul 2024 12:20:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ADA2199E82
	for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721910028; cv=none; b=ZhgUvIFzqSRzrVkase2YGICbCsJE/e1pWVI+3NpUmo5hQ9bMnA8tjLQugv3pRC7rwICCpxrVmMFpIVTzMQiB6n6sP37gkqU4Zrn97ynCvK8YlfSz5UpxUzn+ZcDJnl64cQmLxlQ2b9zMuyCrHrb+cBlqJDecZJDEB/fseSO48yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721910028; c=relaxed/simple;
	bh=OBFKRRdhLyBIvhr35qJxQorj4lGlGTvlOImr3ljcwaE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=CUXmqNpwoXhnF+Mlx9kK0EsMctJnYCus7IPBpzsAthwHOpiUJwK8C+K+wTGa5lhgJY8ih+QzEdphmraiCTdOsZY5yQqx48Ahghs2ofNkq2Ehs1HUy+YReqqyUCsb9yJkmRYL8xCpY1vYBxZ6LNEuDORRizpuTQmfGydzlHRcCD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-81f7fb0103fso9903439f.0
        for <netdev@vger.kernel.org>; Thu, 25 Jul 2024 05:20:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721910025; x=1722514825;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oLI4ea8uXs8eFHkMaXY2ykLmJWefLbCipou9S8Jf06s=;
        b=Td9qc6AUR2ObXYpuzDllmTaSEr3bFxuhykB6cmaLlNzmx8b3MmwILqANxN2n5wHw6H
         AcTuDHm06y0DszT6N/8SX0cEnPNdaY0nHZFFeXKNcjYrLBV+AXtQdeJAk7/AUrOPOvzM
         D5pKo4wN6xMU5kTD7PTz6eKtpn4AbNznIdHIpP61ZD379/pxC7ywqLHjc0ejAEvfnXsl
         TNOYrOrkG0TNh2B89u4oWIRGQXo9zC5JpB44SK77jSI63o4CBXHULghV7XOLU+siqLdz
         Y9q4/9jPYkfT5KtieW2LFuB7ajKCEFZsypwr6awdNiW1kWq4zb4Ja9wsoOwe/A1MwA9w
         IYUg==
X-Forwarded-Encrypted: i=1; AJvYcCXhMqrByOURfdWjHgd/4DgHoP8Ot9tuBgK1Ai0clncEHbocimz0RQS07SgRlxyj/Y5N6tbr5iVJ7JD+ISCXHWl5JFg7ktmA
X-Gm-Message-State: AOJu0YxH39Uvmr4AmlpqFHBtghViCNtiwAnmJeH6jknpUUoIO/SFFlpM
	UaG+3/xGSmGu+FmkzX76uGMw7jt4oW3+A30a3Ih55AUl6dTgMgQrg6/RAxNmW8uhZyYnrQyLOaW
	zYyFv/tHHHaZqi4saKJ7bH7uV4b+bdPmwTDTazFIYdB2XvixHzkk6syk=
X-Google-Smtp-Source: AGHT+IGmoGbe0/j2YTBblEeaMjqCpUQJrPGqrgvVLBKuaxUC3kayCrowJ9xWNNQy9HYXjcBsMIN4R0yc+5TeC3lV/S2PH3Mai0YR
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:37a9:b0:4ba:f3bd:3523 with SMTP id
 8926c6da1cb9f-4c29b0c5904mr135175173.2.1721910025578; Thu, 25 Jul 2024
 05:20:25 -0700 (PDT)
Date: Thu, 25 Jul 2024 05:20:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000068fd36061e116bef@google.com>
Subject: [syzbot] [net?] INFO: task hung in netlink_dump (5)
From: syzbot <syzbot+7937cbec3c095875f389@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    43db1e03c086 Merge tag 'for-6.10/dm-fixes-2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=109e2c31980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3456bae478301dc8
dashboard link: https://syzkaller.appspot.com/bug?extid=7937cbec3c095875f389
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2d56c55ecb57/disk-43db1e03.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/dcec4d04848d/vmlinux-43db1e03.xz
kernel image: https://storage.googleapis.com/syzbot-assets/59fa15daa99c/bzImage-43db1e03.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7937cbec3c095875f389@syzkaller.appspotmail.com

INFO: task dhcpcd:4748 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc7-syzkaller-00141-g43db1e03c086 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:dhcpcd          state:D
 stack:23352 pid:4748  tgid:4748  ppid:4747   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 netlink_dump+0x58c/0xe00 net/netlink/af_netlink.c:2336
 __netlink_dump_start+0x6d7/0x9b0 net/netlink/af_netlink.c:2454
 netlink_dump_start include/linux/netlink.h:340 [inline]
 rtnetlink_dump_start net/core/rtnetlink.c:6524 [inline]
 rtnetlink_rcv_msg+0xb40/0xea0 net/core/rtnetlink.c:6591
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x542/0x820 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2192
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3fbe777ad7
RSP: 002b:00007ffc66505068 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007ffc66506190 RCX: 00007f3fbe777ad7
RDX: 0000000000000014 RSI: 00007ffc665060b0 RDI: 0000000000000019
RBP: 00007ffc66506120 R08: 00007ffc66506094 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000012
R13: 00007ffc66506094 R14: 00007ffc665060b0 R15: 0000000000000105
 </TASK>
INFO: task udevd:10063 blocked for more than 144 seconds.
      Not tainted 6.10.0-rc7-syzkaller-00141-g43db1e03c086 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:udevd           state:D stack:25680 pid:10063 tgid:10063 ppid:4534   flags:0x00000002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1009 [inline]
 uevent_show+0x188/0x3b0 drivers/base/core.c:2743
 dev_attr_show+0x53/0xe0 drivers/base/core.c:2437
 sysfs_kf_seq_show+0x23e/0x410 fs/sysfs/file.c:59
 seq_read_iter+0x4fa/0x12c0 fs/seq_file.c:230
 kernfs_fop_read_iter+0x41a/0x590 fs/kernfs/file.c:279
 new_sync_read fs/read_write.c:395 [inline]
 vfs_read+0x869/0xbd0 fs/read_write.c:476
 ksys_read+0x12f/0x260 fs/read_write.c:619
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa24d716b6a
RSP: 002b:00007ffde3d9d1d8 EFLAGS: 00000246
 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 000055b4c4e12080 RCX: 00007fa24d716b6a
RDX: 0000000000001000 RSI: 000055b4c4e13960 RDI: 0000000000000008
RBP: 000055b4c4e12080 R08: 0000000000000008 R09: 0000000000000000
R10: 000000000000010f R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000003fff R14: 00007ffde3d9d6b8 R15: 000000000000000a
 </TASK>
INFO: task syz-executor:13215 blocked for more than 145 seconds.
      Not tainted 6.10.0-rc7-syzkaller-00141-g43db1e03c086 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D
 stack:24880 pid:13215 tgid:13215 ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_timeout+0x258/0x2a0 kernel/time/timer.c:2557
 do_wait_for_common kernel/sched/completion.c:95 [inline]
 __wait_for_common+0x3de/0x5f0 kernel/sched/completion.c:116
 __flush_work+0x5bd/0xc60 kernel/workqueue.c:4227
 flush_all_backlogs net/core/dev.c:6000 [inline]
 unregister_netdevice_many_notify+0x12c1/0x19f0 net/core/dev.c:11201
 unregister_netdevice_many net/core/dev.c:11277 [inline]
 unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11156
 bpq_device_event+0x76e/0xaf0 drivers/net/hamradio/bpqether.c:552
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1992
 call_netdevice_notifiers_extack net/core/dev.c:2030 [inline]
 call_netdevice_notifiers net/core/dev.c:2044 [inline]
 unregister_netdevice_many_notify+0x8a1/0x19f0 net/core/dev.c:11219
 unregister_netdevice_many net/core/dev.c:11277 [inline]
 unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11156
 unregister_netdevice include/linux/netdevice.h:3119 [inline]
 nsim_destroy+0x107/0x6a0 drivers/net/netdevsim/netdev.c:778
 __nsim_dev_port_del+0x189/0x240 drivers/net/netdevsim/dev.c:1425
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1437 [inline]
 nsim_dev_reload_destroy+0x108/0x4d0 drivers/net/netdevsim/dev.c:1658
 nsim_drv_remove+0x52/0x1d0 drivers/net/netdevsim/dev.c:1673
 device_remove+0xc8/0x170 drivers/base/dd.c:566
 __device_release_driver drivers/base/dd.c:1270 [inline]
 device_release_driver_internal+0x44a/0x610 drivers/base/dd.c:1293
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:574
 device_del+0x396/0x9f0 drivers/base/core.c:3868
 device_unregister+0x1d/0xc0 drivers/base/core.c:3909
 nsim_bus_dev_del drivers/net/netdevsim/bus.c:462 [inline]
 del_device_store+0x346/0x4b0 drivers/net/netdevsim/bus.c:226
 bus_attr_store+0x76/0xa0 drivers/base/bus.c:170
 sysfs_kf_write+0x117/0x170 fs/sysfs/file.c:136
 kernfs_fop_write_iter+0x343/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:497 [inline]
 vfs_write+0x6b6/0x1140 fs/read_write.c:590
 ksys_write+0x12f/0x260 fs/read_write.c:643
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fef1e17475f
RSP: 002b:00007ffccf96fe80 EFLAGS: 00000293
 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fef1e17475f
RDX: 0000000000000001 RSI: 00007ffccf96fed0 RDI: 0000000000000005
RBP: 00007fef1e1e45a0 R08: 0000000000000000 R09: 00007ffccf96fcd7
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 00007ffccf96fed0 R14: 00007fef1ee34620 R15: 0000000000000003
 </TASK>
INFO: task syz.2.2136:13517 blocked for more than 146 seconds.
      Not tainted 6.10.0-rc7-syzkaller-00141-g43db1e03c086 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.2136      state:D
 stack:28384 pid:13517 tgid:13516 ppid:11206  flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x542/0x820 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab5/0xc90 net/socket.c:2585
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2639
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2668
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1dbcf75bd9
RSP: 002b:00007f1dbdd0e048 EFLAGS: 00000246
 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f1dbd103f60 RCX: 00007f1dbcf75bd9
RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000003
RBP: 00007f1dbcfe4e60 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f1dbd103f60 R15: 00007ffda3b34608
 </TASK>

Showing all locks held in the system:
3 locks held by kworker/0:0/8:
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3223
 #1: ffffc900000d7d80 (deferred_process_work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3224
 #2: ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
1 lock held by khungtaskd/30:
 #0: 
ffffffff8dbb1620
 (
rcu_read_lock
){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:781 [inline]
){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6614
6 locks held by kworker/1:1/51:
3 locks held by kworker/u8:7/2410:
 #0: 
ffff888029db3148
 ((wq_completion)ipv6_addrconf
){+.+.}-{0:0}
, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3223
 #1: 
ffffc900095f7d80
 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)
){+.+.}-{0:0}
, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3224
 #2: 
ffffffff8f74bd28
 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_verify_work+0x12/0x30 net/ipv6/addrconf.c:4733
5 locks held by kworker/u8:8/2423:
2 locks held by kworker/u8:10/4360:
 #0: ffff8880b923ebd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested kernel/sched/core.c:567 [inline]
 #0: ffff8880b923ebd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x7e/0x130 kernel/sched/core.c:552
 #1: 
ffff8880b9228a08
 (
&per_cpu_ptr(group->pcpu, cpu)->seq
){-.-.}-{0:0}
, at: psi_task_switch+0x2d9/0x900 kernel/sched/psi.c:988
2 locks held by dhcpcd/4748:
 #0: 
ffff888023574678 (
nlk_cb_mutex-ROUTE
){+.+.}-{3:3}
, at: __netlink_dump_start+0x154/0x9b0 net/netlink/af_netlink.c:2418
 #1: 
ffffffff8f74bd28
 (
rtnl_mutex
){+.+.}-{3:3}
, at: netlink_dump+0x58c/0xe00 net/netlink/af_netlink.c:2336
2 locks held by getty/4840:
 #0: 
ffff88802aa330a0
 (
&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: 
ffffc90002f062f0 (
&ldata->atomic_read_lock
){+.+.}-{3:3}
, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2211
3 locks held by kworker/0:6/5142:
 #0: 
ffff888015481948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3223
 #1: 
ffffc9000326fd80 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3224
 #2: ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x7d/0x10e0 net/wireless/reg.c:2478
4 locks held by udevd/10063:
 #0: ffff888059eb3b08 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0xde/0x12c0 fs/seq_file.c:182
 #1: ffff888075355088 (&of->mutex#2){+.+.}-{3:3}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff88805a45ad28
 (
kn->active
#5
){++++}-{0:0}
, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: 
ffff88801b2ae190
 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 (&dev->mutex){....}-{3:3}, at: uevent_show+0x188/0x3b0 drivers/base/core.c:2743
8 locks held by syz-executor/13215:
 #0: 
ffff88802f3d2420
 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:643
 #1: 
ffff88806c13c888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x281/0x500 fs/kernfs/file.c:325
 #2: ffff8880221123c8 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2a4/0x500 fs/kernfs/file.c:326
 #3: 
ffffffff8ed86da8
 (
nsim_bus_dev_list_lock
){+.+.}-{3:3}
, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
 #4: 
ffff88807b20e0e8
 (
&dev->mutex
){....}-{3:3}
, at: device_lock include/linux/device.h:1009 [inline]
, at: __device_driver_lock drivers/base/dd.c:1093 [inline]
, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1290
 #5: ffff88807b208250 (&devlink->lock_key#29){+.+.}-{3:3}, at: nsim_drv_remove+0x4a/0x1d0 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: nsim_destroy+0x6f/0x6a0 drivers/net/netdevsim/netdev.c:773
 #7: ffffffff8da555d0 (cpu_hotplug_lock){++++}-{0:0}, at: flush_all_backlogs net/core/dev.c:5984 [inline]
 #7: ffffffff8da555d0 (cpu_hotplug_lock){++++}-{0:0}, at: unregister_netdevice_many_notify+0x531/0x19f0 net/core/dev.c:11201
8 locks held by syz.1.2133/13507:
1 lock held by syz.2.2136/13517:
 #0: ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
1 lock held by syz.4.2137/13520:
 #0: 
ffffffff8f74bd28
 (
rtnl_mutex
){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
1 lock held by syz.4.2137/13521:
 #0: 
ffffffff8f74bd28
 (
rtnl_mutex
){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
1 lock held by syz-executor/13523:
 #0: 
ffffffff8f74bd28
 (
rtnl_mutex
){+.+.}-{3:3}
, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
1 lock held by syz-executor/13527:
 #0: 
ffffffff8f74bd28
 (
rtnl_mutex
){+.+.}-{3:3}
, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
1 lock held by syz-executor/13530:
 #0: 
ffffffff8f74bd28
 (
rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
1 lock held by syz-executor/13533:
 #0: ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
1 lock held by syz-executor/13536:
 #0: ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
1 lock held by syz-executor/13539:
 #0: 
ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
1 lock held by syz-executor/13542:
 #0: 
ffffffff8f74bd28
 (
rtnl_mutex
){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
1 lock held by syz-executor/13545:
 #0: 
ffffffff8f74bd28
 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
1 lock held by syz-executor/13548:
 #0: 
ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
1 lock held by syz-executor/13551:
 #0: 
ffffffff8f74bd28
 (
rtnl_mutex
){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
1 lock held by syz-executor/13554:
 #0: 
ffffffff8f74bd28
 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
1 lock held by syz-executor/13557:
 #0: 
ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
1 lock held by syz-executor/13560:
 #0: ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8f74bd28 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632
1 lock held by syz-executor/13563:
 #0: 
ffffffff8f74bd28
 (
rtnl_mutex
){+.+.}-{3:3}
, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6632

=============================================

NMI backtrace for cpu 0
CPU: 0 PID: 30 Comm: khungtaskd Not tainted 6.10.0-rc7-syzkaller-00141-g43db1e03c086 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf86/0x1240 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
NMI backtrace for cpu 1
CPU: 1 PID: 13507 Comm: syz.1.2133 Not tainted 6.10.0-rc7-syzkaller-00141-g43db1e03c086 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
RIP: 0010:number+0x172/0xb80 lib/vsprintf.c:473
Code: e0 b4 f6 8b 44 24 70 31 ff 89 44 24 08 c1 f8 08 89 44 24 18 0f bf 44 24 76 89 44 24 30 44 89 f8 83 e0 20 88 44 24 36 44 89 f8 <83> e0 02 89 c5 89 c6 88 44 24 1f e8 1e db b4 f6 40 84 ed 0f 85 8f
RSP: 0018:ffffc90000a17978 EFLAGS: 00000046
RAX: 0000000000000000 RBX: ffffc90000a17d51 RCX: ffffffff8ad9043a
RDX: ffff888024ebbc00 RSI: ffffffff8ad9046b RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 00000000001c1748 R12: ffffffff8b2d8445
R13: 000000000000000a R14: ffffc90080a17d4f R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b9300000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055556f0c3808 CR3: 000000000d97a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 vsnprintf+0x92a/0x1880 lib/vsprintf.c:2890
 sprintf+0xcd/0x110 lib/vsprintf.c:3028
 print_time kernel/printk/printk.c:1330 [inline]
 info_print_prefix+0x25c/0x350 kernel/printk/printk.c:1356
 record_print_text+0x141/0x400 kernel/printk/printk.c:1405
 printk_get_next_message+0x2a6/0x670 kernel/printk/printk.c:2840
 console_emit_next_record kernel/printk/printk.c:2880 [inline]
 console_flush_all+0x3b2/0xd70 kernel/printk/printk.c:2979
 console_unlock+0xae/0x290 kernel/printk/printk.c:3048
 vprintk_emit kernel/printk/printk.c:2348 [inline]
 vprintk_emit+0x11a/0x5a0 kernel/printk/printk.c:2303
 dev_vprintk_emit drivers/base/core.c:4909 [inline]
 dev_printk_emit+0xfb/0x140 drivers/base/core.c:4920
 __dev_printk+0xf5/0x270 drivers/base/core.c:4932
 _dev_err+0xe5/0x120 drivers/base/core.c:4975
 urb_irq_callback+0x454/0x700 drivers/input/misc/yealink.c:416
 __usb_hcd_giveback_urb+0x389/0x6e0 drivers/usb/core/hcd.c:1650
 usb_hcd_giveback_urb+0x396/0x450 drivers/usb/core/hcd.c:1734
 dummy_timer+0x17f6/0x3900 drivers/usb/gadget/udc/dummy_hcd.c:1987
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x20c/0xcc0 kernel/time/hrtimer.c:1753
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1815
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1032 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x450 arch/x86/kernel/apic/apic.c:1049
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x43/0xb0 arch/x86/kernel/apic/apic.c:1043
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:memset_orig+0x3a/0xb0 arch/x86/lib/memset_64.S:69
Code: 01 01 01 01 01 48 0f af c1 41 89 f9 41 83 e1 07 75 70 48 89 d1 48 c1 e9 06 74 35 0f 1f 44 00 00 48 ff c9 48 89 07 48 89 47 08 <48> 89 47 10 48 89 47 18 48 89 47 20 48 89 47 28 48 89 47 30 48 89
RSP: 0018:ffffc90000a18968 EFLAGS: 00000206
RAX: 0000000000000000 RBX: 0000000000000280 RCX: 0000000000000005
RDX: 0000000000000280 RSI: 0000000000000000 RDI: ffff88806eec0400
RBP: ffffc90000a189c0 R08: 0000000000000007 R09: 0000000000000000
R10: ffff88806eec0300 R11: 0000000000000006 R12: 0000000000082820
R13: 00000000ffffffff R14: 0000000000000001 R15: ffff8880192a5a00
 slab_post_alloc_hook mm/slub.c:3943 [inline]
 slab_alloc_node mm/slub.c:4002 [inline]
 kmem_cache_alloc_node_noprof+0x16e/0x310 mm/slub.c:4045
 kmalloc_reserve+0x18b/0x2c0 net/core/skbuff.c:575
 __alloc_skb+0x164/0x380 net/core/skbuff.c:666
 skb_copy+0x17a/0x340 net/core/skbuff.c:2124
 mac80211_hwsim_tx_frame_no_nl.isra.0+0xb97/0x1310 drivers/net/wireless/virtual/mac80211_hwsim.c:1857
 mac80211_hwsim_tx_frame+0x1eb/0x2a0 drivers/net/wireless/virtual/mac80211_hwsim.c:2206
 __mac80211_hwsim_beacon_tx drivers/net/wireless/virtual/mac80211_hwsim.c:2223 [inline]
 mac80211_hwsim_beacon_tx+0x592/0xa00 drivers/net/wireless/virtual/mac80211_hwsim.c:2306
 __iterate_interfaces+0x2d2/0x580 net/mac80211/util.c:772
 ieee80211_iterate_active_interfaces_atomic+0x71/0x1b0 net/mac80211/util.c:808
 mac80211_hwsim_beacon+0x105/0x200 drivers/net/wireless/virtual/mac80211_hwsim.c:2336
 __run_hrtimer kernel/time/hrtimer.c:1689 [inline]
 __hrtimer_run_queues+0x20c/0xcc0 kernel/time/hrtimer.c:1753
 hrtimer_run_softirq+0x17d/0x350 kernel/time/hrtimer.c:1770
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x1f2/0x560 kernel/locking/lockdep.c:5722
Code: c1 05 da ac 96 7e 83 f8 01 0f 85 ea 02 00 00 9c 58 f6 c4 02 0f 85 d5 02 00 00 48 85 ed 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc9000353f548 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff920006a7eab RCX: 00000000092c356c
RDX: 0000000000000001 RSI: ffffffff8b2cb200 RDI: ffffffff8b903940
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff284d858
R10: ffffffff9426c2c7 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000000 R14: ffffffff8dbb1620 R15: 0000000000000000
 rcu_lock_acquire include/linux/rcupdate.h:329 [inline]
 rcu_read_lock include/linux/rcupdate.h:781 [inline]
 __lruvec_stat_mod_folio+0xb4/0x260 mm/memcontrol.c:1061
 __folio_remove_rmap mm/rmap.c:1556 [inline]
 folio_remove_rmap_ptes+0x363/0x400 mm/rmap.c:1595
 zap_present_folio_ptes mm/memory.c:1505 [inline]
 zap_present_ptes mm/memory.c:1564 [inline]
 zap_pte_range mm/memory.c:1606 [inline]
 zap_pmd_range mm/memory.c:1724 [inline]
 zap_pud_range mm/memory.c:1753 [inline]
 zap_p4d_range mm/memory.c:1774 [inline]
 unmap_page_range+0x1a0b/0x3f20 mm/memory.c:1795
 unmap_single_vma+0x194/0x2b0 mm/memory.c:1841
 unmap_vmas+0x22f/0x490 mm/memory.c:1885
 exit_mmap+0x1b8/0xb20 mm/mmap.c:3341
 __mmput+0x12a/0x4d0 kernel/fork.c:1346
 mmput+0x62/0x70 kernel/fork.c:1368
 exit_mm kernel/exit.c:567 [inline]
 do_exit+0x9b7/0x2ba0 kernel/exit.c:863
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1025
 get_signal+0x2616/0x2710 kernel/signal.c:2909
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x14a/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5e31d75bd9
Code: Unable to access opcode bytes at 0x7f5e31d75baf.
RSP: 002b:00007ffda528d268 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: 0000000000000001 RBX: 0000000000000000 RCX: 00007f5e31d75bd9
RDX: 00000000000f4240 RSI: 0000000000000081 RDI: 00007f5e31f03f68
RBP: 0000000000000c03 R08: 0000000000000008 R09: 00000004a528d58f
R10: 00007f5e31c00000 R11: 0000000000000246 R12: 00007f5e31f03f6c
R13: 0000000000000000 R14: 00007f5e31f03f60 R15: 00007f5e31f03f60
 </TASK>
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71
yealink 5-1:36.0: urb_irq_callback - urb status -71
yealink 5-1:36.0: unexpected response 0
yealink 5-1:36.0: urb_ctl_callback - urb status -71


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


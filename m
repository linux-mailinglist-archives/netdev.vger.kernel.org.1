Return-Path: <netdev+bounces-132561-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739239921BC
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 23:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 043261F22351
	for <lists+netdev@lfdr.de>; Sun,  6 Oct 2024 21:38:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B34C170A3E;
	Sun,  6 Oct 2024 21:38:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877381552E0
	for <netdev@vger.kernel.org>; Sun,  6 Oct 2024 21:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728250705; cv=none; b=FcBLjyM697ovZXMAi0abRd7Bgh8FaxDrdejT1G/8Ig88jOOVzZ5e5il7MJyAUgfxNCOFHFPtibxV9DgIIIxmf36DfOjG7DCVYlQJJ2UNjkbLhfnAAeJOvJCQ6jJtYRRq0t+LWPm1EGu3sdJw/jVxdEslvOhNPgUgRbE0/PiLCd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728250705; c=relaxed/simple;
	bh=CY8wDAFU6U/UmQl4YTxJ8N8joDeaC8OHUz4aYJWLXM8=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=dmPDmoi/7iDon5VyWK1HpQapl23ENGzdwxGNNWOjb1SI5i4+IbOiK7Q9x30kIhet43o2t9QwfoZLIkpM8YhNPt52z9hB0y6lZpUcE8NEmMY/2d0DwQSGT8IG49jcRp8sN50EaF/ey4+juvi5ofc9yAz4AiILCNNFDWa+fNJhUhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f70.google.com with SMTP id ca18e2360f4ac-82d0daa1b09so533513739f.3
        for <netdev@vger.kernel.org>; Sun, 06 Oct 2024 14:38:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728250703; x=1728855503;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oi8HXwVoGMWmKJ99ATvsuDSStDmlC32JS4dpqckZqhk=;
        b=qTs/W7WLmyQ4Em1Kj/Gi+0wd2tjTL2xB0yDz6ZPbnansFkboXSZQkPEVR6CgfCnP9U
         ogQ9tcQ/U2BaAKCb+a2rnEfISGZEV6JZQIEDAUQGB1Tx5/M8P/34f8daSbCzobCAW3YA
         8cx6vsPzp/vZ1r3JEr3lkts2IB7qONSEHiOmq6Jft6Dno5ogqxRx8ejT25kQqJdIX3S+
         xQo10iKvN2YwAx5nfmwAiFVKEwD9dMEOhMC4BV9S8NKyi51CJrTzCLOqouggrpUoxaQR
         SXdzCduMRPYeBaAuwEmY34LhC6POvJjB0siJZ4+x1fH27tcOhAqzopEX4PeZY9MT9T68
         GjiQ==
X-Forwarded-Encrypted: i=1; AJvYcCWx4xqOetYuVBxcFkOe/u0hNXPP49XVruvkhhK8ibcHD2C75J+pVd9rfiKd8ClgErl9ddIzBCU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZSqQ0pcJtc1Jja5TBcrO6nv+OIRZ8aReu7tahRSWvalBqrLSS
	XHaIU7VR6ZzAGfnib3URvwodUmU8Tr/0P1orVdPMVFaULpZZ0FXASaW77g82QBiB1LMDYxf+VLU
	lvl5GrWKFcsPFJwlGe6dmR2b8nHtsNYCduGgvOul9QOtsNLImXTmA3Rk=
X-Google-Smtp-Source: AGHT+IFrv3dWZzOVoApIIE1kw9yRu1PADtpFNJmZaD7sXaDBeRVrCwWDvkIYFIgbyjfzvFGwT+UsPPpZCzQ8ZxGwLtBko48ZI3h/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:c26e:0:b0:39f:93a7:e788 with SMTP id
 e9e14a558f8ab-3a3759780efmr86855765ab.2.1728250702839; Sun, 06 Oct 2024
 14:38:22 -0700 (PDT)
Date: Sun, 06 Oct 2024 14:38:22 -0700
In-Reply-To: <000000000000ef73a7061f328276@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6703034e.050a0220.49194.04e5.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in switchdev_deferred_process_work
 (3)
From: syzbot <syzbot+d6bbe0f5705cb8a5aa2b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, ivecera@redhat.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8f602276d390 Merge tag 'bcachefs-2024-10-05' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14199b80580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ba92623fdea824c9
dashboard link: https://syzkaller.appspot.com/bug?extid=d6bbe0f5705cb8a5aa2b
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10ea8327980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/147c6aceaf24/disk-8f602276.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a61d9ce38120/vmlinux-8f602276.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4ffc70f580e6/bzImage-8f602276.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d6bbe0f5705cb8a5aa2b@syzkaller.appspotmail.com

INFO: task kworker/0:0:8 blocked for more than 150 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:0     state:D stack:21392 pid:8     tgid:8     ppid:2      flags:0x00004000
Workqueue: events switchdev_deferred_process_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 switchdev_deferred_process_work+0xe/0x20 net/switchdev/switchdev.c:104
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u8:0:11 blocked for more than 154 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:0    state:D stack:17144 pid:11    tgid:11    ppid:2      flags:0x00004000
Workqueue: ipv6_addrconf addrconf_dad_work
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task kworker/u8:5:928 blocked for more than 155 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:5    state:D stack:22352 pid:928   tgid:928   ppid:2      flags:0x00004000
Workqueue: events_unbound linkwatch_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 linkwatch_event+0xe/0x60 net/core/link_watch.c:276
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor:5329 blocked for more than 156 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21728 pid:5329  tgid:5329  ppid:5324   flags:0x00004002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 nsim_destroy+0x71/0x5c0 drivers/net/netdevsim/netdev.c:773
 __nsim_dev_port_del+0x14b/0x1b0 drivers/net/netdevsim/dev.c:1425
 nsim_dev_port_del_all drivers/net/netdevsim/dev.c:1437 [inline]
 nsim_dev_reload_destroy+0x28a/0x490 drivers/net/netdevsim/dev.c:1658
 nsim_drv_remove+0x58/0x160 drivers/net/netdevsim/dev.c:1673
 device_remove drivers/base/dd.c:567 [inline]
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x4a9/0x7c0 drivers/base/dd.c:1296
 bus_remove_device+0x34f/0x420 drivers/base/bus.c:576
 device_del+0x57a/0x9b0 drivers/base/core.c:3864
 device_unregister+0x20/0xc0 drivers/base/core.c:3905
 nsim_bus_dev_del drivers/net/netdevsim/bus.c:462 [inline]
 del_device_store+0x363/0x480 drivers/net/netdevsim/bus.c:226
 kernfs_fop_write_iter+0x3a0/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6d/0xc90 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdc0217cadf
RSP: 002b:00007fdc0245f220 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fdc0217cadf
RDX: 0000000000000001 RSI: 00007fdc0245f270 RDI: 0000000000000005
RBP: 00007fdc021f13ae R08: 0000000000000000 R09: 00007fdc0245f077
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 00007fdc0245f270 R14: 00007fdc02e64620 R15: 0000000000000003
 </TASK>
INFO: task syz-executor:5341 blocked for more than 159 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:19824 pid:5341  tgid:5341  ppid:1      flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 kernfs_fop_write_iter+0x3a0/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6d/0xc90 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fba4d57cadf
RSP: 002b:00007fba4d85f220 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007fba4d57cadf
RDX: 0000000000000001 RSI: 00007fba4d85f270 RDI: 0000000000000005
RBP: 00007fba4d5f13ae R08: 0000000000000000 R09: 00007fba4d85f077
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 00007fba4d85f270 R14: 00007fba4e264620 R15: 0000000000000003
 </TASK>
INFO: task syz-executor:5344 blocked for more than 160 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:20912 pid:5344  tgid:5344  ppid:5330   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 kernfs_fop_write_iter+0x3a0/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6d/0xc90 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4619b7cadf
RSP: 002b:00007f4619e5f220 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f4619b7cadf
RDX: 0000000000000001 RSI: 00007f4619e5f270 RDI: 0000000000000005
RBP: 00007f4619bf13ae R08: 0000000000000000 R09: 00007f4619e5f077
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000001
R13: 00007f4619e5f270 R14: 00007f461a864620 R15: 0000000000000003
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


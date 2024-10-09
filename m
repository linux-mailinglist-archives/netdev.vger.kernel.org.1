Return-Path: <netdev+bounces-133882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 930B3997567
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 21:06:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B75791C226C5
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 19:06:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A6D81E1C01;
	Wed,  9 Oct 2024 19:06:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CC291E1037
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 19:06:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728500785; cv=none; b=gqFBBfBNB69aeuS3n5bkIZjXz7YdH7fer6eozadMXLt5B1DVWdCKl3+8Y5sRCXj20ydNbqv1jIiu69lHKGCPUaZP0StRLmDr3KFT9NOsILvlassFenmQfFPRb35m9AWn72Js54YJunfD8RKOKKcezsSRL4+tIUYVotY17i/it/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728500785; c=relaxed/simple;
	bh=RwDWayxMpiWzjPsG/Epvb75JdlcrlYEu9vnh7sGeRiA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qHDZD24+UvR2Mi06fgZOXoQ872Fy97AAKx33/Hn2OmOQwX/Q3lPpbDh/YgoXBzHZOIFNoOD+vF8XhpROpF5hNewkvO7+D7All7wuzaXP1DPNfiNSZhPVPQIG5WjUXCN49B1xCUgCJemQlIQjx8ycz6QZZ3lS5sokfoE9pgpl4hQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a345a02c23so1867695ab.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 12:06:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728500782; x=1729105582;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YR7Z1s+3Lbc3Lav04Kjx0A8bhZRRHtmclmqXXkgvjG4=;
        b=bd4TLMQtbuHnuXRp78VEw/9C3Y4MAJ57zHBeRzUe5QZilnqi7WyvA5+IiWxdjbt6ud
         4n0A/6r3OgQ+mZPahy2Gteg6nDElu4mIONXnMqa8UU91OlvZM6pAcnRPesXXVH5YFAp8
         xUJ0eW36cVD3iT878t8ZlDhQHDyqOfQPQY1hwfakrF9elBR1v1e4WwvlFNK5+VnMQIcA
         JWIVf9IAABkVjRvowoAGiYH8gl0i2JpgUb5eC32DzzcZwDO5mPSN2DmaaB8XNooOoOlm
         OEpQubmRHD4JG8IvY0seqfjJcZ0JuAbKYOku7fGpIoJqFe/Xj0V2TeFhSKnMXrxglLzw
         hrYQ==
X-Forwarded-Encrypted: i=1; AJvYcCV2hfpxDq33j3Pmk6HYZKBTeTQU7uKDy1B7zgnMugppjn6f524vae0K5kFKh3luKpwYJP2PGSc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTyUmO/2XBe8jFY3q0zgRVikJ7HnYHFly+jZk+av93llQy8qTB
	GFmvWO6Yxkm8f5WcDADN1nVhs8xLpUh1jiEp6zM41+mTMjCkhzjfERl6ipJCBfUBcKlOqf1F8xr
	aCkE4gV6tE++95j1ytqDfgtXu1ITiYL5z/0c26qJtjhLaTt1Kpk8VKdE=
X-Google-Smtp-Source: AGHT+IGd11404X1KNl31U/QcuY2+t//Fc53ybJ2MIBzp9pu6nE6FQuZAL+0ZLwdPxXy/m7jd11vw9BGTY+SmksA5GeNKm83DsKo3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:138a:b0:3a0:9f85:d74f with SMTP id
 e9e14a558f8ab-3a397d0fc3emr33207535ab.16.1728500780500; Wed, 09 Oct 2024
 12:06:20 -0700 (PDT)
Date: Wed, 09 Oct 2024 12:06:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6706d42c.050a0220.1139e6.000c.GAE@google.com>
Subject: [syzbot] [net?] INFO: task hung in netdev_run_todo (4)
From: syzbot <syzbot+894cca71fa925aabfdb2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f602276d390 Merge tag 'bcachefs-2024-10-05' of git://evil..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11f2679f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=747b82ac005aa269
dashboard link: https://syzkaller.appspot.com/bug?extid=894cca71fa925aabfdb2
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/7d4ca09136a9/disk-8f602276.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a20897eb481c/vmlinux-8f602276.xz
kernel image: https://storage.googleapis.com/syzbot-assets/81626661c482/bzImage-8f602276.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+894cca71fa925aabfdb2@syzkaller.appspotmail.com

INFO: task syz-executor:6638 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:23024 pid:6638  tgid:6638  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 rcu_barrier+0x48/0x700 kernel/rcu/tree.c:4562
 netdev_run_todo+0x2eb/0x12d0 net/core/dev.c:10782
 tun_detach drivers/net/tun.c:704 [inline]
 tun_chr_close+0xea/0x230 drivers/net/tun.c:3517
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xadd/0x2d70 kernel/exit.c:939
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f907717ff17
RSP: 002b:00007fff18d17f48 EFLAGS: 00000206 ORIG_RAX: 0000000000000029
RAX: 0000000000000003 RBX: 0000000000000003 RCX: 00007f907717ff17
RDX: 0000000000000006 RSI: 0000000000000001 RDI: 000000000000000a
RBP: 00007fff18d1866c R08: 00000000000002d8 R09: 0079746972756365
R10: 00007f907730a9a0 R11: 0000000000000206 R12: 00007f9077306c80
R13: 00005555561a1590 R14: 000000000005fb55 R15: 00007f9077308e40
 </TASK>
INFO: task syz-executor:6641 blocked for more than 144 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:23920 pid:6641  tgid:6641  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 rcu_barrier+0x48/0x700 kernel/rcu/tree.c:4562
 netdev_run_todo+0x2eb/0x12d0 net/core/dev.c:10782
 tun_detach drivers/net/tun.c:704 [inline]
 tun_chr_close+0xea/0x230 drivers/net/tun.c:3517
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xadd/0x2d70 kernel/exit.c:939
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd0bb37ca3c
RSP: 002b:00007ffcf2cabbd0 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 0000000000000003 RCX: 00007fd0bb37ca3c
RDX: 0000000000000028 RSI: 00007ffcf2cabc80 RDI: 00000000000000f9
RBP: 00007ffcf2cabc2c R08: 0000000000000000 R09: 0079746972756365
R10: 00007fd0bb5087e0 R11: 0000000000000246 R12: 0000555575f9c5eb
R13: 0000555575f9c590 R14: 000000000005f482 R15: 00007ffcf2cabc80
 </TASK>
INFO: task syz-executor:6707 blocked for more than 145 seconds.
      Not tainted 6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:23440 pid:6707  tgid:6707  ppid:1      flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0xef5/0x5750 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 rcu_barrier+0x48/0x700 kernel/rcu/tree.c:4562
 netdev_run_todo+0x2eb/0x12d0 net/core/dev.c:10782
 tun_detach drivers/net/tun.c:704 [inline]
 tun_chr_close+0xea/0x230 drivers/net/tun.c:3517
 __fput+0x3f6/0xb60 fs/file_table.c:431
 task_work_run+0x14e/0x250 kernel/task_work.c:228
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xadd/0x2d70 kernel/exit.c:939
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1088
 get_signal+0x25fb/0x2770 kernel/signal.c:2917
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd24977ca3c
RSP: 002b:00007ffe8e4fbc50 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffe00 RBX: 0000000000000003 RCX: 00007fd24977ca3c
RDX: 0000000000000028 RSI: 00007ffe8e4fbd00 RDI: 00000000000000f9
RBP: 00007ffe8e4fbcac R08: 0000000000000000 R09: 0079746972756365
R10: 00007fd2499087e0 R11: 0000000000000246 R12: 0000000000000023
R13: 000000000005fb28 R14: 000000000005fb28 R15: 00007ffe8e4fbd00
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e1b8340 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x7f/0x390 kernel/locking/lockdep.c:6720
4 locks held by kworker/1:2/4634:
2 locks held by getty/4984:
 #0: ffff88802ebf20a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfba/0x1480 drivers/tty/n_tty.c:2211
4 locks held by kworker/1:6/5277:
3 locks held by kworker/u8:12/5406:
1 lock held by syz-executor/6616:
 #0: ffffffff8e1c3b00 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x48/0x700 kernel/rcu/tree.c:4562
1 lock held by syz-executor/6638:
 #0: ffffffff8e1c3b00 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x48/0x700 kernel/rcu/tree.c:4562
1 lock held by syz-executor/6641:
 #0: ffffffff8e1c3b00 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x48/0x700 kernel/rcu/tree.c:4562
1 lock held by syz-executor/6707:
 #0: ffffffff8e1c3b00 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x48/0x700 kernel/rcu/tree.c:4562
1 lock held by syz.0.436/7392:
 #0: ffffffff8e1c3b00 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x48/0x700 kernel/rcu/tree.c:4562
1 lock held by syz-executor/7407:
 #0: ffffffff8e1c3b00 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x48/0x700 kernel/rcu/tree.c:4562
1 lock held by syz-executor/7409:
 #0: ffffffff8e1c3b00 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x48/0x700 kernel/rcu/tree.c:4562
1 lock held by syz-executor/7411:
 #0: ffffffff8e1c3b00 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x48/0x700 kernel/rcu/tree.c:4562
1 lock held by syz-executor/7412:
 #0: ffffffff8e1c3b00 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x48/0x700 kernel/rcu/tree.c:4562
1 lock held by syz-executor/7416:
 #0: ffffffff8e1c3b00 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x48/0x700 kernel/rcu/tree.c:4562
4 locks held by syz-executor/7446:
 #0: ffff88802e66e420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff88802d755888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffff888027367e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f47aba8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/7454:
 #0: ffff88802e66e420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff88805e27bc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffff888027367e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f47aba8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
7 locks held by syz-executor/7456:
 #0: ffff88802e66e420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff88807effbc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffff888027367e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f47aba8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
 #4: ffff88806755b0e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88806755b0e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88806755b0e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xa4/0x610 drivers/base/dd.c:1293
 #5: ffff88806755c250 (&devlink->lock_key#9){+.+.}-{3:3}, at: nsim_drv_remove+0x4a/0x1d0 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8e1c3b00 (rcu_state.barrier_mutex){+.+.}-{3:3}, at: rcu_barrier+0x48/0x700 kernel/rcu/tree.c:4562
4 locks held by syz-executor/7458:
 #0: ffff88802e66e420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff88803267a488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffff888027367e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f47aba8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/7460:
 #0: ffff88802e66e420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff88807c8f9888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffff888027367e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f47aba8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/7498:
 #0: ffff88802e66e420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff88808704b888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffff888027367e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f47aba8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/7499:
 #0: ffff88802e66e420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff88808a980088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffff888027367e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f47aba8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/7504:
 #0: ffff88802e66e420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff8880889a7088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffff888027367e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f47aba8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/7509:
 #0: ffff88802e66e420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff88803720f488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffff888027367e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f47aba8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/7511:
 #0: ffff88802e66e420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff88803066cc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffff888027367e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f47aba8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/7550:
 #0: ffff88802e66e420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff88807ba3dc88 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffff888027367e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f47aba8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/7558:
 #0: ffff88802e66e420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff88807b54c488 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffff888027367e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f47aba8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/7566:
 #0: ffff88802e66e420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff888091b34088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffff888027367e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f47aba8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/7570:
 #0: ffff88802e66e420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff88806b3d0088 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffff888027367e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f47aba8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216
4 locks held by syz-executor/7572:
 #0: ffff88802e66e420 (sb_writers#9){.+.+}-{0:0}, at: ksys_write+0x12f/0x260 fs/read_write.c:736
 #1: ffff88808c63f888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x27b/0x500 fs/kernfs/file.c:325
 #2: ffff888027367e18 (kn->active#49){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x29e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f47aba8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xd2/0x4b0 drivers/net/netdevsim/bus.c:216

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf0c/0x1240 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 5277 Comm: kworker/1:6 Not tainted 6.12.0-rc1-syzkaller-00349-g8f602276d390 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:rcu_read_lock_held_common kernel/rcu/update.c:105 [inline]
RIP: 0010:rcu_read_lock_held+0x4/0x50 kernel/rcu/update.c:349
Code: 04 24 e8 5f 57 7c 00 48 8b 54 24 08 48 8b 04 24 e9 06 fe ff ff 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa <e8> 27 21 af 09 ba 01 00 00 00 85 c0 75 07 89 d0 c3 cc cc cc cc e8
RSP: 0018:ffffc90000a18a68 EFLAGS: 00000246
RAX: 0000000000000000 RBX: 1ffff92000143151 RCX: ffffffff8981dc88
RDX: ffff88802e903c00 RSI: ffffffff8981df01 RDI: 0000000000000005
RBP: 0000000000000002 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: ffff88805a6bd940
R13: 0000000000000001 R14: ffff8880282ce000 R15: ffff888073f70600
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c365ac7 CR3: 000000000df7c000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 nf_hook.constprop.0+0x646/0x750 include/linux/netfilter.h:241
 NF_HOOK include/linux/netfilter.h:312 [inline]
 ip_local_deliver+0x169/0x1f0 net/ipv4/ip_input.c:254
 dst_input include/net/dst.h:460 [inline]
 ip_rcv_finish net/ipv4/ip_input.c:449 [inline]
 NF_HOOK include/linux/netfilter.h:314 [inline]
 NF_HOOK include/linux/netfilter.h:308 [inline]
 ip_rcv+0x2c3/0x5d0 net/ipv4/ip_input.c:569
 __netif_receive_skb_one_core+0x199/0x1e0 net/core/dev.c:5666
 __netif_receive_skb+0x1d/0x160 net/core/dev.c:5779
 process_backlog+0x443/0x15f0 net/core/dev.c:6111
 __napi_poll.constprop.0+0xb7/0x550 net/core/dev.c:6775
 napi_poll net/core/dev.c:6844 [inline]
 net_rx_action+0xa92/0x1010 net/core/dev.c:6966
 handle_softirqs+0x213/0x8f0 kernel/softirq.c:554
 do_softirq kernel/softirq.c:455 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:442
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:382
 spin_unlock_bh include/linux/spinlock.h:396 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:820 [inline]
 nsim_dev_trap_report_work+0x870/0xc80 drivers/net/netdevsim/dev.c:850
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3229
 process_scheduled_works kernel/workqueue.c:3310 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3391
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


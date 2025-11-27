Return-Path: <netdev+bounces-242414-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 069F0C9038A
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 22:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F1E6B3517CE
	for <lists+netdev@lfdr.de>; Thu, 27 Nov 2025 21:43:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF3A328278;
	Thu, 27 Nov 2025 21:42:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C8D2324B2C
	for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 21:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764279750; cv=none; b=uLZUDFZfGmvKMrjHF67jBB5VzMCpjWlwGzyn43KryapQQPKpsI6wU8FJ8TQrt0B7nRZgU9qf/X9PdNKJT36HSOWrbvjpzhAv3ps8hFim5e1J1YZYTjBHdtsUs7hbX4cUQKNbkLzUtTA1sARW8C7sFKi+PH0RSqkyhDuiE6lNV30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764279750; c=relaxed/simple;
	bh=rp3yD+DQQWIEzlpm4JkNsYYS67b5Ixzfdz/QTnMnkJc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ctkN9xR/mVNb3d+MDzYFxea8KxR79QMZXmIkkjJFfSqQMFamd/yXuEvdLgQlvJSYBukkqkZ8OoNtpoasHiCY6sJDy6BOVS7e/rz5JHsATJcFIe5qnSXWbpQ9IQ6e8LgF1SlcZvMwizCmiz6yZ5oyAMVoSsETftADYEpHYeACP/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-9498573d465so69463839f.0
        for <netdev@vger.kernel.org>; Thu, 27 Nov 2025 13:42:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764279747; x=1764884547;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qfatckQ1oRQgO++vYsfNzKm2+IDDmW3f/++XrQm6+3g=;
        b=HkLX5BmLRePeS3Vh8XiKdaKY5W/2IeT3Fd12I4ijnRNutdAKNZnIs60qO68tqc257C
         7GAQNqf3yRzFUbLtufdu3tMHPZw7HZtpV2cglK39WrRUOk/LEXUQgC5akzioX93bFIR0
         OEEWa3Xc1jeWUEVM+ETedxL0Nj1W9IvchUE5wMk6+Y/lUGxhBRHjdLBtA4diDYHuctSl
         JeAAW1qWRnxhDbsTFJwwxWKwYSEgtBBn24cH5cZCPOZmFmgVqrfqHf3xqdkUfYHP4oV9
         829S51PN5qGmAqJMJ3xrOSKoo6oQuoOptZmN2WSiAQaFa8P6vp9+NgrsSGyqPp28e2AB
         DK6A==
X-Forwarded-Encrypted: i=1; AJvYcCWjguFCeoNNAMtsPzMGMqyKo88969CYdyYjZTptm6+tWaaWH5rZCbUkHUlKqyYmzHfoVYSWBNM=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywf67jxRt28RED6V5h/BK7oWpoCGMSRAgNGr+8bDuREDEGD75KZ
	mTojaVolYnYrjKagHFz2ktxYDMLc60/GkGp0amJg2s1AkBaHSJupCTRMa39cecBHO2j616YoZe1
	a1Re0AkOlXCymzdMxXJONFBP8qDXP/6L8WCdUP+b+XgXn2pAkk2pJElVd2C0=
X-Google-Smtp-Source: AGHT+IE5/lxm1epDXA3tdwt6mHmqJV9zoF3arRpNIIrAtzfSm8ILTHLiDXV+dvnEbm2CQwDgDxbTcbHZPUxZNNnpOAOOWXpsUozV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:dc3:b0:433:2499:92f8 with SMTP id
 e9e14a558f8ab-435aa880f52mr221243945ab.5.1764279747486; Thu, 27 Nov 2025
 13:42:27 -0800 (PST)
Date: Thu, 27 Nov 2025 13:42:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6928c5c3.a70a0220.d98e3.011b.GAE@google.com>
Subject: [syzbot] [net?] INFO: task hung in devlink_health_report (3)
From: syzbot <syzbot+11d9554b851e6081de70@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4941a17751c9 Merge tag 'trace-ringbuffer-v6.18-rc7' of git..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17e444b4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1cd7f786c0f5182f
dashboard link: https://syzkaller.appspot.com/bug?extid=11d9554b851e6081de70
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=172fde12580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d63ef75e324b/disk-4941a177.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9a0e19952989/vmlinux-4941a177.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c932cb5b2f37/bzImage-4941a177.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+11d9554b851e6081de70@syzkaller.appspotmail.com

INFO: task syz.0.3521:9693 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.3521      state:D stack:27624 pid:9693  tgid:9693  ppid:8480   task_flags:0x400040 flags:0x00080002
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5325 [inline]
 __schedule+0x1190/0x5de0 kernel/sched/core.c:6929
 __schedule_loop kernel/sched/core.c:7011 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:7026
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:7083
 __mutex_lock_common kernel/locking/mutex.c:676 [inline]
 __mutex_lock+0x818/0x1060 kernel/locking/mutex.c:760
 devlink_health_report+0x6b4/0xb00 net/devlink/health.c:680
 nsim_dev_health_break_write+0x166/0x210 drivers/net/netdevsim/health.c:162
 full_proxy_write+0x131/0x1a0 fs/debugfs/file.c:388
 vfs_write+0x2a0/0x11d0 fs/read_write.c:684
 ksys_write+0x12a/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efd5d18f7c9
RSP: 002b:00007fff34f08518 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007efd5d3e5fa0 RCX: 00007efd5d18f7c9
RDX: 0000000000000006 RSI: 0000200000005900 RDI: 0000000000000003
RBP: 00007efd5d213f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007efd5d3e5fa0 R14: 00007efd5d3e5fa0 R15: 0000000000000003
 </TASK>

Showing all locks held in the system:
6 locks held by kworker/u8:0/12:
 #0: ffff88801ba9f148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3238
 #1: ffffc90000117d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3239
 #2: ffffffff900d4ed0 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xad/0x8b0 net/core/net_namespace.c:669
 #3: ffff8880323e90e8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:914 [inline]
 #3: ffff8880323e90e8 (&dev->mutex){....}-{4:4}, at: devl_dev_lock net/devlink/devl_internal.h:108 [inline]
 #3: ffff8880323e90e8 (&dev->mutex){....}-{4:4}, at: devlink_pernet_pre_exit+0x12c/0x2b0 net/devlink/core.c:506
 #4: ffff8880323ea250 (&devlink->lock_key#4){+.+.}-{4:4}, at: devl_lock net/devlink/core.c:276 [inline]
 #4: ffff8880323ea250 (&devlink->lock_key#4){+.+.}-{4:4}, at: devl_dev_lock net/devlink/devl_internal.h:109 [inline]
 #4: ffff8880323ea250 (&devlink->lock_key#4){+.+.}-{4:4}, at: devlink_pernet_pre_exit+0x136/0x2b0 net/devlink/core.c:506
 #5: ffff88805a336480 (&sb->s_type->i_mutex_key#3/2){+.+.}-{4:4}, at: inode_lock_nested include/linux/fs.h:1025 [inline]
 #5: ffff88805a336480 (&sb->s_type->i_mutex_key#3/2){+.+.}-{4:4}, at: __simple_recursive_removal+0x354/0x610 fs/libfs.c:627
1 lock held by khungtaskd/31:
 #0: ffffffff8e3c45e0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff8e3c45e0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:867 [inline]
 #0: ffffffff8e3c45e0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6775
2 locks held by getty/5591:
 #0: ffff88814dee10a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc9000332b2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222
5 locks held by syz-executor/9680:
 #0: ffff88807da82420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #1: ffff888022f7a088 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x570 fs/kernfs/file.c:343
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ff/0x570 fs/kernfs/file.c:344
 #3: ffffffff8f66d0e8 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x4a0 drivers/net/netdevsim/bus.c:234
 #4: ffff8880323e90e8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:914 [inline]
 #4: ffff8880323e90e8 (&dev->mutex){....}-{4:4}, at: device_del+0xa0/0x9f0 drivers/base/core.c:3840
2 locks held by syz.0.3521/9693:
 #0: ffff888140eea420 (sb_writers#8){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #1: ffff8880323ea250 (&devlink->lock_key#4){+.+.}-{4:4}, at: devlink_health_report+0x6b4/0xb00 net/devlink/health.c:680
2 locks held by syz.3.3545/9717:
 #0: ffff888140eea420 (sb_writers#8){.+.+}-{0:0}, at: open_last_lookups fs/namei.c:3884 [inline]
 #0: ffff888140eea420 (sb_writers#8){.+.+}-{0:0}, at: path_openat+0x1ec8/0x2cb0 fs/namei.c:4131
 #1: ffff88805a336480 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:995 [inline]
 #1: ffff88805a336480 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: open_last_lookups fs/namei.c:3894 [inline]
 #1: ffff88805a336480 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: path_openat+0x818/0x2cb0 fs/namei.c:4131
2 locks held by syz.1.3544/9718:
 #0: ffff888140eea420 (sb_writers#8){.+.+}-{0:0}, at: open_last_lookups fs/namei.c:3884 [inline]
 #0: ffff888140eea420 (sb_writers#8){.+.+}-{0:0}, at: path_openat+0x1ec8/0x2cb0 fs/namei.c:4131
 #1: ffff88805a336480 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: inode_lock_shared include/linux/fs.h:995 [inline]
 #1: ffff88805a336480 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: open_last_lookups fs/namei.c:3894 [inline]
 #1: ffff88805a336480 (&sb->s_type->i_mutex_key#3){++++}-{4:4}, at: path_openat+0x818/0x2cb0 fs/namei.c:4131
4 locks held by syz-executor/9725:
 #0: ffff88807da82420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #1: ffff88805c466c88 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x570 fs/kernfs/file.c:343
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ff/0x570 fs/kernfs/file.c:344
 #3: ffffffff8f66d0e8 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x4a0 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9736:
 #0: ffff88807da82420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #1: ffff88814cd6b088 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x570 fs/kernfs/file.c:343
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ff/0x570 fs/kernfs/file.c:344
 #3: ffffffff8f66d0e8 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x4a0 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9738:
 #0: ffff88807da82420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #1: ffff88805d4ba088 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x570 fs/kernfs/file.c:343
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ff/0x570 fs/kernfs/file.c:344
 #3: ffffffff8f66d0e8 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x4a0 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9762:
 #0: ffff88807da82420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #1: ffff88805e519088 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x570 fs/kernfs/file.c:343
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ff/0x570 fs/kernfs/file.c:344
 #3: ffffffff8f66d0e8 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x4a0 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9773:
 #0: ffff88807da82420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #1: ffff88807e784888 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x570 fs/kernfs/file.c:343
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ff/0x570 fs/kernfs/file.c:344
 #3: ffffffff8f66d0e8 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x4a0 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9784:
 #0: ffff88807da82420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #1: ffff888060f92488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x570 fs/kernfs/file.c:343
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ff/0x570 fs/kernfs/file.c:344
 #3: ffffffff8f66d0e8 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x4a0 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9786:
 #0: ffff88807da82420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #1: ffff88805f988c88 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x570 fs/kernfs/file.c:343
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ff/0x570 fs/kernfs/file.c:344
 #3: ffffffff8f66d0e8 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x4a0 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9809:
 #0: ffff88807da82420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #1: ffff888031007c88 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x570 fs/kernfs/file.c:343
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ff/0x570 fs/kernfs/file.c:344
 #3: ffffffff8f66d0e8 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x4a0 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9819:
 #0: ffff88807da82420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #1: ffff888031eefc88 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x570 fs/kernfs/file.c:343
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ff/0x570 fs/kernfs/file.c:344
 #3: ffffffff8f66d0e8 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x4a0 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9831:
 #0: ffff88807da82420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #1: ffff88802d27b488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x570 fs/kernfs/file.c:343
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ff/0x570 fs/kernfs/file.c:344
 #3: ffffffff8f66d0e8 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x4a0 drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/9832:
 #0: ffff88807da82420 (sb_writers#7){.+.+}-{0:0}, at: ksys_write+0x12a/0x250 fs/read_write.c:738
 #1: ffff888028813888 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x28f/0x570 fs/kernfs/file.c:343
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff888027e4a968 (kn->active#58){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x2ff/0x570 fs/kernfs/file.c:344
 #3: ffffffff8f66d0e8 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd1/0x4a0 drivers/net/netdevsim/bus.c:234

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 31 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:160 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:332 [inline]
 watchdog+0xf3f/0x1170 kernel/hung_task.c:495
 kthread+0x3c5/0x780 kernel/kthread.c:463
 ret_from_fork+0x675/0x7d0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:82
Code: 67 6f 02 c3 cc cc cc cc 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d 23 74 2c 00 fb f4 <e9> 3c 0a 03 00 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffffff8e007df8 EFLAGS: 000002c6
RAX: 00000000001a05c3 RBX: 0000000000000000 RCX: ffffffff8b5db2a9
RDX: 0000000000000000 RSI: ffffffff8da292ea RDI: ffffffff8bf078c0
RBP: fffffbfff1c12f40 R08: 0000000000000001 R09: ffffed1017086655
R10: ffff8880b84332ab R11: 0000000000000001 R12: 0000000000000000
R13: ffffffff8e097a00 R14: ffffffff90824ad0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888124a0d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055b6bb661a30 CR3: 000000000e182000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:107 [inline]
 default_idle+0x13/0x20 arch/x86/kernel/process.c:767
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:190 [inline]
 do_idle+0x38d/0x500 kernel/sched/idle.c:330
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:428
 rest_init+0x16b/0x2b0 init/main.c:757
 start_kernel+0x3f6/0x4e0 init/main.c:1111
 x86_64_start_reservations+0x18/0x30 arch/x86/kernel/head64.c:310
 x86_64_start_kernel+0x130/0x190 arch/x86/kernel/head64.c:291
 common_startup_64+0x13e/0x148
 </TASK>


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


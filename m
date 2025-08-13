Return-Path: <netdev+bounces-213206-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD248B241D5
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 08:46:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EC07622F12
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 06:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A632D3A71;
	Wed, 13 Aug 2025 06:45:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7A42C2AB2
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 06:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755067535; cv=none; b=rIYH05kLofNRi/fefdGBHwhvHXjbAHQa8ucniMll5pn3oCSWuz3WRM9zAxRkxi+b4OS0Px1D1PYtuImvgFUBQXvnZ8Lmqi12mT6340poIX88rgDqWzw4k6F0F7qIjzZbYWUxKzm+anLM73/HpktyfNLZb/X3DjEWxRxaKiWUMVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755067535; c=relaxed/simple;
	bh=huLVWDRNke8xg5Kjvlx5WsSzQGvnQrsipQTdrsMCIwc=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=IuXo4ivgwt9/XYxqtvbvEDtjuiitiiX628XKXhmwVS3yLuzntnfofGZZO5oWG6FqqmzEKDF9QjAXKj8FndgYbwrXwf3L1RSu9nXzgqBXVgidX1H4/+5T7O8L1BSdiQVcbX0YNvhAPonf4olfmp3Sd3oLF/X6SV+elytAeUcFE7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-88177a20e0fso1276638739f.0
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 23:45:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755067533; x=1755672333;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1SZwkHD3CyNnXHRjhcNe6yr2ggQojGsRPamjq0xLWlU=;
        b=DUDCOOuybIXSPKDRZ1nJj2Tm1Ws6d4gz1ioHBoBYzLf0eM01e+7XyEWcXQ8+pxAHSh
         hi5ayQSaFqy1kGwQ3/zudvOxLBBAAQB4USbqMCsYNQFckserlxkdF8mr96Vgm9H+6jau
         4mGnqdssxYTUJIXvCvq/YCVqnoio7cm7tCjEqEMlz2Oh9L4v5S7+5D/o4LtmY7NM0FnW
         Bq708R+yFoBNWjMF6UFlrHTPkZyUYUUwdHdFXkPDOoqbLCl86OAhdwGWTyenafKPin2v
         hpZHG2vObNm8MZIRywsrGgWVRbWnPOmG8LA0R2rCuyElvOKwWVMB25wDhGAPhPEgpnxx
         lMfw==
X-Forwarded-Encrypted: i=1; AJvYcCWqr/ctGhTzDwl8llLu0E+CHaVS3AYzc1HMXDjRq6+RmMEyL3ylWQWBI172S2XZvZcPb3hNzqU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoT2pg8V4/bFM9xpLNNSTVxO0FIsci/S9k05s8haixML2OM45A
	U0jKpSYIE6QpxViX/CcRBz0FrJtpaILnqaMczIrC54MXQPIlvF1/Z07fVXUPHLc9qyGsxJvs8TM
	7UbXyu3WAwEay11wk6F5eaqs705C1MU2YFzAycDji+tMfqhZhmKy6C6OnzcY=
X-Google-Smtp-Source: AGHT+IEHWcspNnFTr4GWBjfpAB9Iv4IRNOQOrPha43esbjqDXv4Z/MlF90qA+Jc1oB5yER+ksLvLVEE1N0odNjFf5ZZm0Rafph73
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:6201:0:b0:884:1cc9:9b9b with SMTP id
 ca18e2360f4ac-884296a5492mr322440139f.13.1755067532844; Tue, 12 Aug 2025
 23:45:32 -0700 (PDT)
Date: Tue, 12 Aug 2025 23:45:32 -0700
In-Reply-To: <000000000000750a0205f62abbf1@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689c348c.050a0220.7f033.0141.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in del_device_store
From: syzbot <syzbot+6d10ecc8a97cc10639f9@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=15704da2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8c5ac3d8b8abfcb
dashboard link: https://syzkaller.appspot.com/bug?extid=6d10ecc8a97cc10639f9
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12702af0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15816842580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/18a2e4bd0c4a/disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3b5395881b25/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e875f4e3b7ff/Image-8f5ae30d.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6d10ecc8a97cc10639f9@syzkaller.appspotmail.com

INFO: task syz-executor:6692 blocked for more than 144 seconds.
      Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:0     pid:6692  tgid:6692  ppid:1      task_flags:0x400140 flags:0x00000001
Call trace:
 __switch_to+0x418/0x87c arch/arm64/kernel/process.c:741 (T)
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x13b0/0x2864 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xb4/0x230 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:7115
 __mutex_lock_common+0xca0/0x24ac kernel/locking/mutex.c:676
 __mutex_lock kernel/locking/mutex.c:760 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:812
 del_device_store+0xd4/0x31c drivers/net/netdevsim/bus.c:234
 bus_attr_store+0x80/0xa4 drivers/base/bus.c:172
 sysfs_kf_write+0x1a8/0x23c fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x314/0x488 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x540/0xa3c fs/read_write.c:686
 ksys_write+0x120/0x210 fs/read_write.c:738
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:746
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
INFO: task syz-executor:6698 blocked for more than 144 seconds.
      Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:0     pid:6698  tgid:6698  ppid:6696   task_flags:0x400140 flags:0x00800000
Call trace:
 __switch_to+0x418/0x87c arch/arm64/kernel/process.c:741 (T)
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x13b0/0x2864 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xb4/0x230 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:7115
 __mutex_lock_common+0xca0/0x24ac kernel/locking/mutex.c:676
 __mutex_lock kernel/locking/mutex.c:760 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:812
 device_lock include/linux/device.h:911 [inline]
 device_del+0xa4/0x808 drivers/base/core.c:3840
 device_unregister+0x2c/0xcc drivers/base/core.c:3919
 nsim_bus_dev_del drivers/net/netdevsim/bus.c:483 [inline]
 del_device_store+0x27c/0x31c drivers/net/netdevsim/bus.c:244
 bus_attr_store+0x80/0xa4 drivers/base/bus.c:172
 sysfs_kf_write+0x1a8/0x23c fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x314/0x488 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x540/0xa3c fs/read_write.c:686
 ksys_write+0x120/0x210 fs/read_write.c:738
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:746
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
INFO: task syz-executor:6701 blocked for more than 144 seconds.
      Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:0     pid:6701  tgid:6701  ppid:6699   task_flags:0x400140 flags:0x00800000
Call trace:
 __switch_to+0x418/0x87c arch/arm64/kernel/process.c:741 (T)
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x13b0/0x2864 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xb4/0x230 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:7115
 __mutex_lock_common+0xca0/0x24ac kernel/locking/mutex.c:676
 __mutex_lock kernel/locking/mutex.c:760 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:812
 del_device_store+0xd4/0x31c drivers/net/netdevsim/bus.c:234
 bus_attr_store+0x80/0xa4 drivers/base/bus.c:172
 sysfs_kf_write+0x1a8/0x23c fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x314/0x488 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x540/0xa3c fs/read_write.c:686
 ksys_write+0x120/0x210 fs/read_write.c:738
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:746
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
INFO: task syz-executor:6706 blocked for more than 144 seconds.
      Not tainted 6.17.0-rc1-syzkaller-g8f5ae30d69d7 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:0     pid:6706  tgid:6706  ppid:6705   task_flags:0x400140 flags:0x00800000
Call trace:
 __switch_to+0x418/0x87c arch/arm64/kernel/process.c:741 (T)
 context_switch kernel/sched/core.c:5357 [inline]
 __schedule+0x13b0/0x2864 kernel/sched/core.c:6961
 __schedule_loop kernel/sched/core.c:7043 [inline]
 schedule+0xb4/0x230 kernel/sched/core.c:7058
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:7115
 __mutex_lock_common+0xca0/0x24ac kernel/locking/mutex.c:676
 __mutex_lock kernel/locking/mutex.c:760 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:812
 del_device_store+0xd4/0x31c drivers/net/netdevsim/bus.c:234
 bus_attr_store+0x80/0xa4 drivers/base/bus.c:172
 sysfs_kf_write+0x1a8/0x23c fs/sysfs/file.c:145
 kernfs_fop_write_iter+0x314/0x488 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x540/0xa3c fs/read_write.c:686
 ksys_write+0x120/0x210 fs/read_write.c:738
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:746
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x2b8 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0x130/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x58/0x180 arch/arm64/kernel/entry-common.c:879
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:898
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Showing all locks held in the system:
1 lock held by khungtaskd/32:
 #0: ffff80008f9a9060 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48 include/linux/rcupdate.h:330
3 locks held by kworker/u8:2/41:
3 locks held by pr/ttyAMA-1/43:
2 locks held by kworker/u8:5/1987:
7 locks held by kworker/u8:7/2184:
5 locks held by kworker/u8:8/2656:
5 locks held by kworker/u8:9/4759:
1 lock held by klogd/6155:
3 locks held by udevd/6166:
1 lock held by dhcpcd/6220:
3 locks held by dhcpcd/6221:
2 locks held by getty/6308:
 #0: ffff0000d73b90a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff80009bbbb2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x34c/0xfa4 drivers/tty/n_tty.c:2222
4 locks held by syz-executor/6692:
 #0: ffff0000d802a428 (sb_writers#6){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3107 [inline]
 #0: ffff0000d802a428 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x24c/0xa3c fs/read_write.c:682
 #1: ffff0000dc4fb888 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1b4/0x488 fs/kernfs/file.c:325
 #2: ffff0000c6c77e18 (kn->active#55){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x1d0/0x488 fs/kernfs/file.c:326
 #3: ffff800091a98908 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd4/0x31c drivers/net/netdevsim/bus.c:234
5 locks held by kworker/0:4/6694:
5 locks held by syz-executor/6698:
 #0: ffff0000d802a428 (sb_writers#6){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3107 [inline]
 #0: ffff0000d802a428 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x24c/0xa3c fs/read_write.c:682
 #1: ffff0000d9789088 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1b4/0x488 fs/kernfs/file.c:325
 #2: ffff0000c6c77e18 (kn->active#55){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x1d0/0x488 fs/kernfs/file.c:326
 #3: ffff800091a98908 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd4/0x31c drivers/net/netdevsim/bus.c:234
 #4: ffff0000de8af0e8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:911 [inline]
 #4: ffff0000de8af0e8 (&dev->mutex){....}-{4:4}, at: device_del+0xa4/0x808 drivers/base/core.c:3840
4 locks held by syz-executor/6701:
 #0: ffff0000d802a428 (sb_writers#6){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3107 [inline]
 #0: ffff0000d802a428 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x24c/0xa3c fs/read_write.c:682
 #1: ffff0000c6553088 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1b4/0x488 fs/kernfs/file.c:325
 #2: ffff0000c6c77e18 (kn->active#55){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x1d0/0x488 fs/kernfs/file.c:326
 #3: ffff800091a98908 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd4/0x31c drivers/net/netdevsim/bus.c:234
4 locks held by syz-executor/6706:
 #0: ffff0000d802a428 (sb_writers#6){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:3107 [inline]
 #0: ffff0000d802a428 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x24c/0xa3c fs/read_write.c:682
 #1: ffff0000d7a2c488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1b4/0x488 fs/kernfs/file.c:325
 #2: ffff0000c6c77e18 (kn->active#55){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x1d0/0x488 fs/kernfs/file.c:326
 #3: ffff800091a98908 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd4/0x31c drivers/net/netdevsim/bus.c:234
3 locks held by syz-executor/6770:
3 locks held by kworker/u8:12/6772:
2 locks held by syz-executor/6776:

=============================================



---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


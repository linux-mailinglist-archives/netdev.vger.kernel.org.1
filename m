Return-Path: <netdev+bounces-246061-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 08D3CCDDE9A
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 17:24:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8AEA3300A84D
	for <lists+netdev@lfdr.de>; Thu, 25 Dec 2025 16:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB211A9F8D;
	Thu, 25 Dec 2025 16:24:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB47260A
	for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 16:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766679862; cv=none; b=X1EiYJDZE2FXQ7gfsD1L95pbZ7AkPWW3DI38hRRWi7e8LgyMUuGyz31FBOp+OpNd8Fh6yoV2iWcr9eS/I4CR8+y5ikw8PL346tsGqoAQ8Xg/jkVN6cvCjvva7uOK3Tq9UkzctYDaHyWcuCKVIL13plE/HouIPNRc1Z67Z6Gq26Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766679862; c=relaxed/simple;
	bh=a+trIjjwOXWo2EHIsT8ZyfJ+6TjwbIsC+DuhQuUvh08=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=W1yi2DRQlVO2tTW3XI6qdLUbYZCn03qBlp3h39vQv90SoMf1Pfj4giiSah0HvQ27R8b+e45Y3Q7NhH9oXD7mkctw3xpRMN2Vv+JKdDnKKaoS1RiJ/oW5F61r60Te6WknxcoSuJ/rAZ0APVjYIc5u4hOszP990H2854Buj4UQjx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-6573d873f92so5639932eaf.2
        for <netdev@vger.kernel.org>; Thu, 25 Dec 2025 08:24:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766679860; x=1767284660;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PYVWaF1acHrICGlsHHTHWFpr//agu3uMvBpctUgqhSM=;
        b=OLISLhor1aPVj4GMy0QI5Go4ICjPKpD+yqjMewWc3s+TTqwDv4xh7o8ZgPyEe4SeCG
         jhCxGY8n/+fbOFpiSSpV11si356fanOp7TXDjew3Z9EcfwrukPQU/WraOwCZ1Q5TKHxz
         BZJ+hFztqJPF8du4KiA/k3uJGsYSun/K4Rp5K/LTNIXON6sDf0FsDMZOQH9Bcsr7Ez4L
         U6vQ9YcDdTUojD2n2PkZztXYwptpUI+Gxop4tOGbc8tjXcJcNTjPLomzUh1g5wGNGLmG
         RtZUOc4yCPJ88qqrBzWVEyVsvZtLrpjfxsjCjI/xG2Ie+PiABcwThHpFeS7ajA9QnqP7
         bz7g==
X-Forwarded-Encrypted: i=1; AJvYcCVr2ngyUcQ/AYhicSlZbOG5vKE12f4XEtcuLi4M2F2jM4YlOdI8X9JvxRL6o/a4hIMfsQuaGQA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz+HjU78sbRG1t3MKsZboz3Q3FsAd/cbLL1aq/NM4ARC5TdSCui
	wOihPV7KmS2xkcwei5uYdaAVTPFrDMGZv2GRRzBDaFpL4BRqShfpRrR5C7l5kumZhhqP8hqpKzD
	MtaUKaz7DO4W8713RMewDNiOCIiwh4ozIbrMwJP3xA+2LAdV7q8LwYr6R/jo=
X-Google-Smtp-Source: AGHT+IFodL2xw6fES8XMKgGCSMWL/CAERr4G/SmgyL0XJP30NDJywMQWaNixJt41n6J13N9G3I+GA6OCMryeC1LKfM/kWzD8BKJl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:608:b0:657:56ba:7455 with SMTP id
 006d021491bc7-65d0e9e7d19mr8871088eaf.1.1766679859758; Thu, 25 Dec 2025
 08:24:19 -0800 (PST)
Date: Thu, 25 Dec 2025 08:24:19 -0800
In-Reply-To: <66f5a0ca.050a0220.46d20.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694d6533.050a0220.35954c.0047.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in new_device_store (5)
From: syzbot <syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, boqun.feng@gmail.com, davem@davemloft.net, 
	edumazet@google.com, hdanton@sina.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	penguin-kernel@i-love.sakura.ne.jp, syzkaller-bugs@googlegroups.com, 
	torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8f0b4cce4481 Linux 6.19-rc1
git tree:       git://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-kernelci
console output: https://syzkaller.appspot.com/x/log.txt?x=156eb09a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8a8594efdc14f07a
dashboard link: https://syzkaller.appspot.com/bug?extid=05f9cecd28e356241aba
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: arm64
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=177f9758580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14b2ab92580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/cd4f5f43efc8/disk-8f0b4cce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aafb35ac3a3c/vmlinux-8f0b4cce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d221fae4ab17/Image-8f0b4cce.gz.xz

Bisection is inconclusive: the first bad commit could be any of:

949090eaf0a3 sched/eevdf: Remove min_vruntime_copy
8e2e13ac6122 sched/fair: Cleanup pick_task_fair() vs throttle

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=10491fd0580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com

INFO: task syz-executor:6714 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:0     pid:6714  tgid:6714  ppid:1      task_flags:0x400140 flags:0x00000001
Call trace:
 __switch_to+0x418/0x87c arch/arm64/kernel/process.c:741 (T)
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1250/0x2a7c kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0xb4/0x230 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:7017
 __mutex_lock_common+0xd04/0x2678 kernel/locking/mutex.c:692
 __mutex_lock kernel/locking/mutex.c:776 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:828
 new_device_store+0x128/0x594 drivers/net/netdevsim/bus.c:184
 bus_attr_store+0x80/0xa4 drivers/base/bus.c:172
 sysfs_kf_write+0x1a8/0x23c fs/sysfs/file.c:142
 kernfs_fop_write_iter+0x33c/0x4d0 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x540/0xa3c fs/read_write.c:686
 ksys_write+0x120/0x210 fs/read_write.c:738
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:746
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
INFO: task syz-executor:6720 blocked for more than 144 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:0     pid:6720  tgid:6720  ppid:1      task_flags:0x400140 flags:0x00000011
Call trace:
 __switch_to+0x418/0x87c arch/arm64/kernel/process.c:741 (T)
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1250/0x2a7c kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0xb4/0x230 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:7017
 __mutex_lock_common+0xd04/0x2678 kernel/locking/mutex.c:692
 __mutex_lock kernel/locking/mutex.c:776 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:828
 device_lock include/linux/device.h:895 [inline]
 device_del+0xa4/0x808 drivers/base/core.c:3840
 device_unregister+0x2c/0xf4 drivers/base/core.c:3919
 nsim_bus_dev_del drivers/net/netdevsim/bus.c:483 [inline]
 del_device_store+0x27c/0x31c drivers/net/netdevsim/bus.c:244
 bus_attr_store+0x80/0xa4 drivers/base/bus.c:172
 sysfs_kf_write+0x1a8/0x23c fs/sysfs/file.c:142
 kernfs_fop_write_iter+0x33c/0x4d0 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x540/0xa3c fs/read_write.c:686
 ksys_write+0x120/0x210 fs/read_write.c:738
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:746
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596
INFO: task syz-executor:6724 blocked for more than 146 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:0     pid:6724  tgid:6724  ppid:6719   task_flags:0x400140 flags:0x00800000
Call trace:
 __switch_to+0x418/0x87c arch/arm64/kernel/process.c:741 (T)
 context_switch kernel/sched/core.c:5256 [inline]
 __schedule+0x1250/0x2a7c kernel/sched/core.c:6863
 __schedule_loop kernel/sched/core.c:6945 [inline]
 schedule+0xb4/0x230 kernel/sched/core.c:6960
 schedule_preempt_disabled+0x18/0x2c kernel/sched/core.c:7017
 __mutex_lock_common+0xd04/0x2678 kernel/locking/mutex.c:692
 __mutex_lock kernel/locking/mutex.c:776 [inline]
 mutex_lock_nested+0x2c/0x38 kernel/locking/mutex.c:828
 del_device_store+0xd4/0x31c drivers/net/netdevsim/bus.c:234
 bus_attr_store+0x80/0xa4 drivers/base/bus.c:172
 sysfs_kf_write+0x1a8/0x23c fs/sysfs/file.c:142
 kernfs_fop_write_iter+0x33c/0x4d0 fs/kernfs/file.c:352
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x540/0xa3c fs/read_write.c:686
 ksys_write+0x120/0x210 fs/read_write.c:738
 __do_sys_write fs/read_write.c:749 [inline]
 __se_sys_write fs/read_write.c:746 [inline]
 __arm64_sys_write+0x7c/0x90 fs/read_write.c:746
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x98/0x254 arch/arm64/kernel/syscall.c:49
 el0_svc_common+0xe8/0x23c arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x48/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x5c/0x26c arch/arm64/kernel/entry-common.c:724
 el0t_64_sync_handler+0x84/0x12c arch/arm64/kernel/entry-common.c:743
 el0t_64_sync+0x198/0x19c arch/arm64/kernel/entry.S:596

Showing all locks held in the system:
3 locks held by kworker/u8:1/13:
2 locks held by kworker/1:1/26:
1 lock held by khungtaskd/32:
 #0: ffff80008fa5b520 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire+0x4/0x48 include/linux/rcupdate.h:330
3 locks held by kworker/u8:2/41:
1 lock held by pr/ttyAMA-1/43:
6 locks held by kworker/u8:5/155:
3 locks held by kworker/u8:7/713:
 #0: ffff0000d55b1948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x63c/0x1558 kernel/workqueue.c:3231
 #1: ffff80009d0f7be0 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work+0x6d0/0x1558 kernel/workqueue.c:3231
 #2: ffff800092ae4168 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x20/0x2c net/core/rtnetlink.c:80
2 locks held by kworker/u8:8/1023:
6 locks held by kworker/u8:9/1342:
 #0: ffff0000c1843148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x63c/0x1558 kernel/workqueue.c:3231
 #1: ffff80009ed07be0 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x6d0/0x1558 kernel/workqueue.c:3231
 #2: ffff800092ad71f0 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xf0/0x638 net/core/net_namespace.c:670
 #3: ffff0000da33f0e8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:895 [inline]
 #3: ffff0000da33f0e8 (&dev->mutex){....}-{4:4}, at: devl_dev_lock net/devlink/devl_internal.h:108 [inline]
 #3: ffff0000da33f0e8 (&dev->mutex){....}-{4:4}, at: devlink_pernet_pre_exit+0xe4/0x380 net/devlink/core.c:506
 #4: ffff0000c7b48250 (&devlink->lock_key){+.+.}-{4:4}, at: devl_lock net/devlink/core.c:276 [inline]
 #4: ffff0000c7b48250 (&devlink->lock_key){+.+.}-{4:4}, at: devl_dev_lock net/devlink/devl_internal.h:109 [inline]
 #4: ffff0000c7b48250 (&devlink->lock_key){+.+.}-{4:4}, at: devlink_pernet_pre_exit+0xf0/0x380 net/devlink/core.c:506
 #5: ffff800092ae4168 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x20/0x2c net/core/rtnetlink.c:80
3 locks held by kworker/u8:10/1512:
2 locks held by kworker/0:2/3988:
3 locks held by kworker/u8:14/4835:
3 locks held by kworker/u8:15/5060:
 #0: ffff0000c0031948 ((wq_completion)events_unbound#2){+.+.}-{0:0}, at: process_one_work+0x63c/0x1558 kernel/workqueue.c:3231
 #1: ffff8000a4817be0 ((linkwatch_work).work){+.+.}-{0:0}, at: process_one_work+0x6d0/0x1558 kernel/workqueue.c:3231
 #2: ffff800092ae4168 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock+0x20/0x2c net/core/rtnetlink.c:80
3 locks held by kworker/u8:16/5722:
3 locks held by udevd/6209:
3 locks held by dhcpcd/6265:
2 locks held by getty/6351:
 #0: ffff0000d5dd30a0 (&tty->ldisc_sem){++++}-{0:0}, at: ldsem_down_read+0x3c/0x4c drivers/tty/tty_ldsem.c:340
 #1: ffff800099f1e2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x34c/0xfc8 drivers/tty/n_tty.c:2211
2 locks held by kworker/1:3/6704:
4 locks held by syz-executor/6714:
 #0: ffff0000dc442420 (sb_writers#6){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2681 [inline]
 #0: ffff0000dc442420 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x24c/0xa3c fs/read_write.c:682
 #1: ffff0000d4d40888 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1b4/0x4d0 fs/kernfs/file.c:343
 #2: ffff0000ce348878 (kn->active#56){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff0000ce348878 (kn->active#56){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x1f4/0x4d0 fs/kernfs/file.c:344
 #3: ffff800091bf3648 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: new_device_store+0x128/0x594 drivers/net/netdevsim/bus.c:184
5 locks held by syz-executor/6720:
 #0: ffff0000dc442420 (sb_writers#6){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2681 [inline]
 #0: ffff0000dc442420 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x24c/0xa3c fs/read_write.c:682
 #1: ffff0000d6511488 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1b4/0x4d0 fs/kernfs/file.c:343
 #2: ffff0000ce348968 (kn->active#55){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff0000ce348968 (kn->active#55){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x1f4/0x4d0 fs/kernfs/file.c:344
 #3: ffff800091bf3648 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd4/0x31c drivers/net/netdevsim/bus.c:234
 #4: ffff0000da33f0e8 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:895 [inline]
 #4: ffff0000da33f0e8 (&dev->mutex){....}-{4:4}, at: device_del+0xa4/0x808 drivers/base/core.c:3840
4 locks held by syz-executor/6724:
 #0: ffff0000dc442420 (sb_writers#6){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2681 [inline]
 #0: ffff0000dc442420 (sb_writers#6){.+.+}-{0:0}, at: vfs_write+0x24c/0xa3c fs/read_write.c:682
 #1: ffff0000d6512888 (&of->mutex){+.+.}-{4:4}, at: kernfs_fop_write_iter+0x1b4/0x4d0 fs/kernfs/file.c:343
 #2: ffff0000ce348968 (kn->active#55){.+.+}-{0:0}, at: kernfs_get_active_of fs/kernfs/file.c:80 [inline]
 #2: ffff0000ce348968 (kn->active#55){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x1f4/0x4d0 fs/kernfs/file.c:344
 #3: ffff800091bf3648 (nsim_bus_dev_list_lock){+.+.}-{4:4}, at: del_device_store+0xd4/0x31c drivers/net/netdevsim/bus.c:234
4 locks held by kworker/0:4/6772:
 #0: ffff0000c0029948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x63c/0x1558 kernel/workqueue.c:3231
 #1: ffff8000a3f67be0 ((work_completion)(&helper->damage_work)){+.+.}-{0:0}, at: process_one_work+0x6d0/0x1558 kernel/workqueue.c:3231
 #2: ffff0000ca9f5280 (&helper->lock){+.+.}-{4:4}, at: drm_fb_helper_fb_dirty drivers/gpu/drm/drm_fb_helper.c:333 [inline]
 #2: ffff0000ca9f5280 (&helper->lock){+.+.}-{4:4}, at: drm_fb_helper_damage_work+0xa8/0x568 drivers/gpu/drm/drm_fb_helper.c:369
 #3: ffff0000caeb8128 (&dev->master_mutex){+.+.}-{4:4}, at: drm_master_internal_acquire+0x24/0x78 drivers/gpu/drm/drm_auth.c:435
2 locks held by syz.0.17/6788:
4 locks held by kworker/0:8/6796:
 #0: ffff0000d54fcd48 ((wq_completion)mld){+.+.}-{0:0}, at: process_one_work+0x63c/0x1558 kernel/workqueue.c:3231
 #1: ffff8000a3ef7be0 ((work_completion)(&(&idev->mc_ifc_work)->work)){+.+.}-{0:0}, at: process_one_work+0x6d0/0x1558 kernel/workqueue.c:3231
 #2: ffff0000dcc68538 (&idev->mc_lock){+.+.}-{4:4}, at: mld_ifc_work+0x38/0xc38 net/ipv6/mcast.c:2692
 #3: ffff80008f916b20 (sched_map-wait-type-override){+.+.}-{3:3}, at: sched_submit_work+0x14/0x144 kernel/sched/core.c:6893
5 locks held by syz-executor/6797:
2 locks held by syz-executor/6802:
2 locks held by syz-executor/6804:

=============================================



---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


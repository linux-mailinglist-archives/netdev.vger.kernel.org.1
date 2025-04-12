Return-Path: <netdev+bounces-181932-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CFA4A86FC9
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 23:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 92C9919E088E
	for <lists+netdev@lfdr.de>; Sat, 12 Apr 2025 21:20:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF74A22FE10;
	Sat, 12 Apr 2025 21:20:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F9819C558
	for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 21:20:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744492826; cv=none; b=hRgTJ4tT2o3H73dP0bRBO8giOQI/IlU/CJ+wnPtvjE2GJvqXDgK1a9TThytkz/6AHWhAmBLO7RkM2ins6YGDTffZf9XJhMc2mAu7xsaC59lSU9FgOEhSoBX9QDZbjN+0DHal6GlVZEARa8oWHhn6dMVJOoN4KaJoMv3ScIZRQ70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744492826; c=relaxed/simple;
	bh=EmeNt+k1QMgSJ+cFNyJV6f3zyl3kiUzKwN2y2Uiv+XY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NMfQCaxbIsnXYT8+0vj4rv+27W++nbTXi7SnZ0coqVhOBfynhTnbfsZznbGPJf5OQvBhpAPyzhL1JyPGE4oziBxLbU0o/3OF+1Ihr7BrUxDjgMlIAmYXk+/l4EkLtKmfk4sOLCshUn50XHb9utq7XfDog+DxeRs3ZGTCOwER7Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d6e10f8747so30416015ab.3
        for <netdev@vger.kernel.org>; Sat, 12 Apr 2025 14:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744492824; x=1745097624;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PCb9XP7p0T7OrM0O4Wd1Ziuw+OQ27R1oZ4msvjdVWVk=;
        b=E6hhhVWmf911AhNnauaoqBo7mA0hOPUyy/w9Ke/oRaFgR0HDkvOcJLqUgi2/1FTgnn
         EKCixomOXQ9DskZKtJEDJkJrqSpwbUqkT5aV2ReAkNrc6nbyVytp7jqMUiA56jrVIfU1
         M3RxmgHcSNBwf3f1DAiJsXVI7jngg79Hrt02s7aABQUgrvX9RfB/J5NdJqhD4dnMYsfH
         PGV4kYe6JBigSl0QSh97F9X0/mC7eo+cUhw1A0MeN2ZYsMKZXUL0lGVxC6j4/CbF998W
         I4oAaPq9Q79p56c5j1FA1QSyA01+IpnqydDBnwTeDjUBvVm8hwc2x+OQsFtvqwHdaKUV
         NMKg==
X-Forwarded-Encrypted: i=1; AJvYcCX3R3HZ0Ge7TyWMCGcER3Mzno/Nz0386V0dOFMNnbysrRkbUYfCPAD2nFg6SBiiN/rJY/FDlEQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCooJM+F9liS5VhWt27dmm/TMyR9ZnptqXTfT9mor8vyb0Rq6t
	UWZmeFJTM3wqb1VwtfoBjnQtLAUi+0BIYE5oWfQMqUyFqkiM0DfSSiNsY30vpE4S43n20hXALeq
	JGOtD1Yu9UIIRB83vgDWA+A6dV+vcz1XmmRxDWhXyQF29tTrFG/tcluc=
X-Google-Smtp-Source: AGHT+IEJ0DnQyXGwBWL5V63O2r8oKE3tFT9sWT8dXogWM1FljqNuOfbbokjn3K9mvCTwj9LlqCIxv2H2CPmP2f6NiBW+52OxysJr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3497:b0:3d4:3ab3:daf0 with SMTP id
 e9e14a558f8ab-3d7ec1f38a9mr80354015ab.7.1744492823829; Sat, 12 Apr 2025
 14:20:23 -0700 (PDT)
Date: Sat, 12 Apr 2025 14:20:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67fad917.050a0220.2c5fcf.0012.GAE@google.com>
Subject: [syzbot] [net?] [usb?] INFO: task hung in usbnet_disconnect (3)
From: syzbot <syzbot+361b9ca28e718288de20@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0af2f6be1b42 Linux 6.15-rc1
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1637a7e4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42c250ab10de03ed
dashboard link: https://syzkaller.appspot.com/bug?extid=361b9ca28e718288de20
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8392cf904762/disk-0af2f6be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/742ce214269c/vmlinux-0af2f6be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/47fcdc35136e/bzImage-0af2f6be.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+361b9ca28e718288de20@syzkaller.appspotmail.com

INFO: task kworker/0:7:5815 blocked for more than 143 seconds.
      Not tainted 6.15.0-rc1-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:7     state:D stack:21976 pid:5815  tgid:5815  ppid:2      task_flags:0x4288060 flags:0x00004000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5382 [inline]
 __schedule+0x132a/0x3b00 kernel/sched/core.c:6767
 __schedule_loop kernel/sched/core.c:6845 [inline]
 schedule+0xe7/0x3a0 kernel/sched/core.c:6860
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6917
 __mutex_lock_common kernel/locking/mutex.c:678 [inline]
 __mutex_lock+0x6c7/0xb90 kernel/locking/mutex.c:746
 rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 rtnl_net_dev_lock+0x146/0x360 net/core/dev.c:2096
 unregister_netdev+0x15/0x60 net/core/dev.c:12061
 usbnet_disconnect+0x109/0x500 drivers/net/usb/usbnet.c:1648
 usb_unbind_interface+0x1da/0x9a0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:569 [inline]
 device_remove+0x122/0x170 drivers/base/dd.c:561
 __device_release_driver drivers/base/dd.c:1273 [inline]
 device_release_driver_internal+0x44b/0x620 drivers/base/dd.c:1296
 bus_remove_device+0x22f/0x420 drivers/base/bus.c:579
 device_del+0x396/0x9f0 drivers/base/core.c:3855
 usb_disable_device+0x355/0x7d0 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e1/0x920 drivers/usb/core/hub.c:2316
 hub_port_connect drivers/usb/core/hub.c:5371 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5671 [inline]
 port_event drivers/usb/core/hub.c:5831 [inline]
 hub_event+0x1aa0/0x5030 drivers/usb/core/hub.c:5913
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
INFO: task kworker/0:7:5815 is blocked on a mutex likely owned by task dhcpcd:2887.
task:dhcpcd          state:R  running task     stack:25704 pid:2887  tgid:2887  ppid:2886   task_flags:0x400140 flags:0x0000400a
Call Trace:
 <TASK>
 </TASK>

Showing all locks held in the system:
6 locks held by kworker/1:0/23:
 #0: ffff8881066ab948
 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: ffffc9000018fd18 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: ffff88810afb9198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:922 [inline]
 #2: ffff88810afb9198 (&dev->mutex){....}-{4:4}, at: hub_event+0x1be/0x5030 drivers/usb/core/hub.c:5859
 #3: ffff888116ce1198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:922 [inline]
 #3: ffff888116ce1198 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4b0 drivers/base/dd.c:1005
 #4: ffff88811160f160 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:922 [inline]
 #4: ffff88811160f160 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8a3bdaa8 (rtnl_mutex){+.+.}-{4:4}, at: wpan_phy_register+0x27/0x160 net/ieee802154/core.c:145
1 lock held by khungtaskd/30:
 #0: ffffffff890c1a00 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 #0: ffffffff890c1a00 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:841 [inline]
 #0: ffffffff890c1a00 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x36/0x1c0 kernel/locking/lockdep.c:6764
7 locks held by kworker/1:1/38:
6 locks held by kworker/1:2/2507:
 #0: ffff8881066ab948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: ffffc90003bbfd18 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: ffff88810afc9198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:922 [inline]
 #2: ffff88810afc9198 (&dev->mutex){....}-{4:4}, at: hub_event+0x1be/0x5030 drivers/usb/core/hub.c:5859
 #3: ffff888106a84198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:922 [inline]
 #3: ffff888106a84198 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4b0 drivers/base/dd.c:1005
 #4: ffff888118766160 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:922 [inline]
 #4: ffff888118766160 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8a3bdaa8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock_killable include/linux/rtnetlink.h:145 [inline]
 #5: ffffffff8a3bdaa8 (rtnl_mutex){+.+.}-{4:4}, at: register_netdev+0x18/0x50 net/core/dev.c:11130
2 locks held by getty/2907:
 #0: ffff8881121230a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x41b/0x14f0 drivers/tty/n_tty.c:2222
6 locks held by kworker/1:3/5229:
 #0: 
ffff8881066ab948 ((wq_completion)usb_hub_wq
){+.+.}-{0:0}
, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: ffffc900021bfd18 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: ffff8881160f4198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:922 [inline]
 #2: ffff8881160f4198 (&dev->mutex){....}-{4:4}, at: hub_event+0x1be/0x5030 drivers/usb/core/hub.c:5859
 #3: ffff88810afa4508 (&port_dev->status_lock){+.+.}-{4:4}, at: usb_lock_port drivers/usb/core/hub.c:3220 [inline]
 #3: ffff88810afa4508 (&port_dev->status_lock){+.+.}-{4:4}, at: usb_reset_device+0x559/0xa90 drivers/usb/core/hub.c:6357
 #4: ffff888107bb6568 (hcd->address0_mutex){+.+.}-{4:4}, at: usb_reset_and_verify_device+0x335/0x1120 drivers/usb/core/hub.c:6163
 #5: ffffffff89bedfd0 (ehci_cf_port_reset_rwsem){.+.+}-{4:4}, at: hub_port_reset+0x1a1/0x1e00 drivers/usb/core/hub.c:3035
4 locks held by kworker/1:4/5236:
 #0: ffff8881066ab948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: 
ffffc900021dfd18
 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: ffff88810afa1198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:922 [inline]
 #2: ffff88810afa1198 (&dev->mutex){....}-{4:4}, at: hub_event+0x1be/0x5030 drivers/usb/core/hub.c:5859
 #3: ffff88810afa4508 (&port_dev->status_lock){+.+.}-{4:4}, at: usb_lock_port drivers/usb/core/hub.c:3220 [inline]
 #3: ffff88810afa4508 (&port_dev->status_lock){+.+.}-{4:4}, at: hub_event+0x5c3/0x5030 drivers/usb/core/hub.c:5912
4 locks held by udevd/5237:
 #0: ffff88811382a0a0 (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0xe1/0x12b0 fs/seq_file.c:182
 #1: ffff8881198f4888 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff888118ad45a8 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff888116ce1198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:922 [inline]
 #3: ffff888116ce1198 (&dev->mutex){....}-{4:4}, at: uevent_show+0x187/0x3b0 drivers/base/core.c:2730
4 locks held by udevd/5242:
 #0: ffff888102af4668 (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0xe1/0x12b0 fs/seq_file.c:182
 #1: 
ffff88811be0dc88 (&of->mutex
#2){+.+.}-{4:4}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff8881209f5e18 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff888106a84198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:922 [inline]
 #3: ffff888106a84198 (&dev->mutex){....}-{4:4}, at: uevent_show+0x187/0x3b0 drivers/base/core.c:2730
4 locks held by udevd/5275:
 #0: ffff88811c43ab08 (&p->lock){+.+.}-{4:4}, at: seq_read_iter+0xe1/0x12b0 fs/seq_file.c:182
 #1: ffff8881311e7488 (&of->mutex#2){+.+.}-{4:4}, at: kernfs_seq_start+0x4d/0x240 fs/kernfs/file.c:154
 #2: ffff888109365b48 (kn->active#5){++++}-{0:0}, at: kernfs_seq_start+0x71/0x240 fs/kernfs/file.c:155
 #3: ffff88810b351198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:922 [inline]
 #3: ffff88810b351198 (&dev->mutex){....}-{4:4}, at: uevent_show+0x187/0x3b0 drivers/base/core.c:2730
6 locks held by kworker/1:6/5525:
 #0: ffff8881066ab948 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: ffffc90004257d18
 (
(work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: ffff88810b351198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:922 [inline]
 #2: ffff88810b351198 (&dev->mutex){....}-{4:4}, at: hub_event+0x1be/0x5030 drivers/usb/core/hub.c:5859
 #3: ffff8881173bf198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:922 [inline]
 #3: ffff8881173bf198 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4b0 drivers/base/dd.c:1005
 #4: ffff88811368c160 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:922 [inline]
 #4: ffff88811368c160 (&dev->mutex){....}-{4:4}, at: __device_attach+0x7e/0x4b0 drivers/base/dd.c:1005
 #5: ffffffff8a3bdaa8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock_killable include/linux/rtnetlink.h:145 [inline]
 #5: ffffffff8a3bdaa8 (rtnl_mutex){+.+.}-{4:4}, at: register_netdev+0x18/0x50 net/core/dev.c:11130
7 locks held by kworker/0:7/5815:
3 locks held by kworker/u8:1/9183:
 #0: ffff8881120a0948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work+0x12a2/0x1b70 kernel/workqueue.c:3213
 #1: ffffc90001c4fd18 ((work_completion)(&(&net->ipv6.addr_chk_work)->work)){+.+.}-{0:0}, at: process_one_work+0x929/0x1b70 kernel/workqueue.c:3214
 #2: ffffffff8a3bdaa8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #2: ffffffff8a3bdaa8 (rtnl_mutex){+.+.}-{4:4}, at: addrconf_verify_work+0x12/0x30 net/ipv6/addrconf.c:4734

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.15.0-rc1-syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:158 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:274 [inline]
 watchdog+0x11c4/0x15d0 kernel/hung_task.c:437
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 6797 Comm: kworker/1:7 Not tainted 6.15.0-rc1-syzkaller #0 PREEMPT(voluntary) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events legacy_dvb_usb_read_remote_control
RIP: 0010:printk_get_next_message+0x2d4/0x6d0 kernel/printk/printk.c:3027
Code: 00 45 84 e4 0f 85 c0 00 00 00 e8 c7 20 20 00 8b 35 a1 cb 17 12 0f b6 15 fa b5 a0 07 4c 89 f7 83 e6 01 e8 4f 91 ff ff 89 04 24 <e8> a7 20 20 00 48 8d 7d 08 8b 04 24 48 ba 00 00 00 00 00 fc ff df
RSP: 0018:ffffc90014337680 EFLAGS: 00000286
RAX: 000000000000002f RBX: 1ffff92002866ed5 RCX: fffff52002866eb5
RDX: ffff8881129e9d40 RSI: ffffffff815bcd5f RDI: 0000000000000007
RBP: ffffc900143378b0 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000800 R11: 205d303354202020 R12: 0000000000000000
R13: 0000000000000001 R14: ffffc900143376c8 R15: ffffc90014337708
FS:  0000000000000000(0000) GS:ffff8882692bf000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c381204 CR3: 000000011727a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 console_emit_next_record kernel/printk/printk.c:3092 [inline]
 console_flush_all+0x6ea/0xc60 kernel/printk/printk.c:3226
 __console_flush_and_unlock kernel/printk/printk.c:3285 [inline]
 console_unlock+0xd8/0x210 kernel/printk/printk.c:3325
 vprintk_emit+0x418/0x6d0 kernel/printk/printk.c:2450
 _printk+0xc7/0x100 kernel/printk/printk.c:2475
 m920x_read drivers/media/usb/dvb-usb/m920x.c:40 [inline]
 m920x_rc_query+0x496/0x770 drivers/media/usb/dvb-usb/m920x.c:193
 legacy_dvb_usb_read_remote_control+0x109/0x4f0 drivers/media/usb/dvb-usb/dvb-usb-remote.c:123
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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


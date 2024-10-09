Return-Path: <netdev+bounces-133509-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4652D99624C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 10:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5FEB71C22248
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 08:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D13671891A8;
	Wed,  9 Oct 2024 08:20:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9706188A3A
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 08:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462030; cv=none; b=uvC0HX1SXU7kzTWKicIwyNcZgCrqalvH+7OisEkxhqmhg3vCKJSVkiDgQZ2RtmtSupRIYucKnI6bSeeHRQJ6EmlcH7moUBteHz/IfxhgefVF0YhgV7tw1q5sGup6Ftr1F1z0sxB/ZEgWGdhpD9CU029cRIJ2BDOggDJ/0ao4cfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462030; c=relaxed/simple;
	bh=m1OUkGtvY+Hi0BWH+KBTwbhRWSdoHHGqgTc+v6OOJ1I=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=PEKV7MdtNwLniF9cFaj/rGzAQn1opFC4gyfDkwRYTOr7pd+o79LBRyjzEAel3RnzFeLQcOw+ZHjlnz2rgeImQL2Ryi+BZy+meRuO1useBA8UsLdHF0mgE7yzQIFG+72Cyu84GvtJ6xh8rIWfJzIABGE21WlRedZoUAenhRjvUyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-832160abde4so55734539f.1
        for <netdev@vger.kernel.org>; Wed, 09 Oct 2024 01:20:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728462028; x=1729066828;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aKtYnZpLW00TayaO42hrnKURGmLYf8kT1tzKb4ZE8jw=;
        b=D4FMImyJfjd3CfEkM38iTtZC9qSq52AApTwR9VfO3dyyoHpgGwfOA0Qju4IGyxYCL6
         hhg9Ch0JY5cP/RUipT5ZIh2FgtBPHgIhEG38SmVQT2tu16ojkcJVKALEoduy2h1kvjbC
         eojXYQW/o674YS1MC5VA831mUgyjVM2lEu1vKNIWhlc//wn0kBcj4rR3eQX7/Qv+kHUS
         T/offseRB4rAuJeVM+2BCF8/T9p10RYulcbu89zqOQ0RVZyUijjq2QTIdKer5hAlrqPJ
         fQktN6GyrjyIa9sRIQIYQwAsNutKsWCIe38ZswKT4K+2eLQXXrONpvU6TM89qhxnp6Ce
         /oww==
X-Forwarded-Encrypted: i=1; AJvYcCX1qzoroVWFobi3YgcO1cR/DqSJG0XOAinCaornERyRPUxx3H8r+SNK4Op+uBiQkd95ynEfH78=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxKFCvWU6Ddl86sjLPv3f75E7LSgag8ML4fIbciFwpZ/3bzohI
	fgeZekmIFMRD7+yZIu54HQwKyQ18qeO8l69O4uAG/JbyR8TgkKPtdDrdPpTiRzgFtksjvLzySm4
	xqyY5G4FHptb8LqeEb3w++qpv+OfKJCpabujOMqDuo3go/MFqxABeGxg=
X-Google-Smtp-Source: AGHT+IEVORNLYt3OfC+xyLzRjpMveDCSW7DOnfRYhg2wzA0byMjAxtWK2BjrsPriYp+BCpSnObQbdd67HFxYZ7pMQ/nruGIOgZ9h
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2161:b0:3a2:763b:c83e with SMTP id
 e9e14a558f8ab-3a3974efe24mr13838755ab.5.1728462027851; Wed, 09 Oct 2024
 01:20:27 -0700 (PDT)
Date: Wed, 09 Oct 2024 01:20:27 -0700
In-Reply-To: <66f5a0ca.050a0220.46d20.0002.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67063ccb.050a0220.22840d.0010.GAE@google.com>
Subject: Re: [syzbot] [net?] INFO: task hung in new_device_store (5)
From: syzbot <syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com>
To: boqun.feng@gmail.com, davem@davemloft.net, edumazet@google.com, 
	hdanton@sina.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, penguin-kernel@i-love.sakura.ne.jp, 
	syzkaller-bugs@googlegroups.com, torvalds@linux-foundation.org
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    5b7c893ed5ed Merge tag 'ntfs3_for_6.12' of https://github...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11c09f9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7cd9e7e4a8a0a15b
dashboard link: https://syzkaller.appspot.com/bug?extid=05f9cecd28e356241aba
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1635f707980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/508d25adbdbb/disk-5b7c893e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ecd795cf996e/vmlinux-5b7c893e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d5433a3025f3/bzImage-5b7c893e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+05f9cecd28e356241aba@syzkaller.appspotmail.com

INFO: task syz-executor:5469 blocked for more than 143 seconds.
      Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor    state:D stack:21680 pid:5469  tgid:5469  ppid:5459   flags:0x00000000
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5315 [inline]
 __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
 __schedule_loop kernel/sched/core.c:6752 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6767
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
 new_device_store+0x1b4/0x890 drivers/net/netdevsim/bus.c:166
 kernfs_fop_write_iter+0x3a0/0x500 fs/kernfs/file.c:334
 new_sync_write fs/read_write.c:590 [inline]
 vfs_write+0xa6d/0xc90 fs/read_write.c:683
 ksys_write+0x183/0x2b0 fs/read_write.c:736
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f5edcf7cadf
RSP: 002b:00007f5edd25f220 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 00007f5edcf7cadf
RDX: 0000000000000003 RSI: 00007f5edd25f270 RDI: 0000000000000005
RBP: 00007f5edcff13d2 R08: 0000000000000000 R09: 00007f5edd25f077
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000003
R13: 00007f5edd25f270 R14: 00007f5eddc64620 R15: 0000000000000003
 </TASK>

Showing all locks held in the system:
2 locks held by kworker/u8:0/11:
2 locks held by kworker/u8:1/12:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
3 locks held by kworker/u8:3/52:
5 locks held by kworker/u9:0/54:
 #0: ffff888218331148 ((wq_completion)hci6){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888218331148 ((wq_completion)hci6){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90000bf7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90000bf7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff88802a7b0d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
 #3: ffff88802a7b0078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5567
 #4: ffffffff8fe3e668 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff8fe3e668 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1262
1 lock held by kswapd1/89:
3 locks held by kworker/u8:5/1060:
 #0: ffff88814b89a948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88814b89a948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003ee7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003ee7d00 ((work_completion)(&(&ifa->dad_work)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+0xd0/0x16f0 net/ipv6/addrconf.c:4196
3 locks held by kworker/1:2/1852:
3 locks held by kworker/u8:8/2936:
4 locks held by kworker/u8:12/3063:
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801baed948 ((wq_completion)netns){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90009ce7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90009ce7d00 (net_cleanup_work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcc52d0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+0x16a/0xcc0 net/core/net_namespace.c:580
 #3: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: wg_destruct+0x25/0x2e0 drivers/net/wireguard/device.c:246
1 lock held by klogd/4679:
2 locks held by udevd/4690:
1 lock held by dhcpcd/4903:
2 locks held by getty/4995:
 #0: ffff88802e5950a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc900031332f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
3 locks held by kworker/1:3/5284:
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003fc7d00 ((crda_timeout).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003fc7d00 ((crda_timeout).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: crda_timeout_work+0x15/0x50 net/wireless/reg.c:540
5 locks held by kworker/u9:5/5333:
 #0: ffff888175b57948 ((wq_completion)hci8){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888175b57948 ((wq_completion)hci8){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003da7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003da7d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff88807caccd80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
 #3: ffff88807cacc078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5567
 #4: ffffffff8fe3e668 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff8fe3e668 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1262
6 locks held by kworker/u9:6/5335:
 #0: ffff888219140948 ((wq_completion)hci7){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888219140948 ((wq_completion)hci7){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003c27d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003c27d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff88804a2e4d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
 #3: ffff88804a2e4078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5567
 #4: ffffffff8fe3e668 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff8fe3e668 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1262
 #5: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: exp_funnel_lock kernel/rcu/tree_exp.h:297 [inline]
 #5: ffffffff8e93d378 (rcu_state.exp_mutex){+.+.}-{3:3}, at: synchronize_rcu_expedited+0x381/0x830 kernel/rcu/tree_exp.h:976
5 locks held by kworker/u9:7/5337:
 #0: ffff888218333948 ((wq_completion)hci5){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff888218333948 ((wq_completion)hci5){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc90003c07d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc90003c07d00 ((work_completion)(&hdev->cmd_sync_work)){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffff88807edc8d80 (&hdev->req_lock){+.+.}-{3:3}, at: hci_cmd_sync_work+0x1ec/0x400 net/bluetooth/hci_sync.c:327
 #3: ffff88807edc8078 (&hdev->lock){+.+.}-{3:3}, at: hci_abort_conn_sync+0x1ea/0xde0 net/bluetooth/hci_sync.c:5567
 #4: ffffffff8fe3e668 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_connect_cfm include/net/bluetooth/hci_core.h:1957 [inline]
 #4: ffffffff8fe3e668 (hci_cb_list_lock){+.+.}-{3:3}, at: hci_conn_failed+0x15d/0x300 net/bluetooth/hci_conn.c:1262
3 locks held by kworker/1:5/5405:
4 locks held by kworker/0:5/5438:
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
 #0: ffff88801ac81948 ((wq_completion)events_power_efficient){+.+.}-{0:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
 #1: ffffc9000360fd00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
 #1: ffffc9000360fd00 ((reg_check_chans).work){+.+.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
 #2: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_work+0x99/0xfd0 net/wireless/reg.c:2480
 #3: ffff8880787d0768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock include/net/cfg80211.h:6014 [inline]
 #3: ffff8880787d0768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: reg_leave_invalid_chans net/wireless/reg.c:2468 [inline]
 #3: ffff8880787d0768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: reg_check_chans_work+0x164/0xfd0 net/wireless/reg.c:2483
1 lock held by syz-executor/5463:
 #0: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
1 lock held by syz-executor/5464:
 #0: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643
3 locks held by syz-executor/5465:
4 locks held by syz-executor/5469:
 #0: ffff8880322e8420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline]
 #0: ffff8880322e8420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #1: ffff888085516888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff8880272140f8 (kn->active#56){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f56fea8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: new_device_store+0x1b4/0x890 drivers/net/netdevsim/bus.c:166
7 locks held by syz-executor/5470:
 #0: ffff8880322e8420 (sb_writers#8){.+.+}-{0:0}, at: file_start_write include/linux/fs.h:2931 [inline]
 #0: ffff8880322e8420 (sb_writers#8){.+.+}-{0:0}, at: vfs_write+0x224/0xc90 fs/read_write.c:679
 #1: ffff888084d7e888 (&of->mutex){+.+.}-{3:3}, at: kernfs_fop_write_iter+0x1ea/0x500 fs/kernfs/file.c:325
 #2: ffff8880272141e8 (kn->active#55){.+.+}-{0:0}, at: kernfs_fop_write_iter+0x20e/0x500 fs/kernfs/file.c:326
 #3: ffffffff8f56fea8 (nsim_bus_dev_list_lock){+.+.}-{3:3}, at: del_device_store+0xfc/0x480 drivers/net/netdevsim/bus.c:216
 #4: ffff88807fb830e8 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1014 [inline]
 #4: ffff88807fb830e8 (&dev->mutex){....}-{3:3}, at: __device_driver_lock drivers/base/dd.c:1095 [inline]
 #4: ffff88807fb830e8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0xce/0x7c0 drivers/base/dd.c:1293
 #5: ffff88807fb84250 (&devlink->lock_key#4){+.+.}-{3:3}, at: nsim_drv_remove+0x50/0x160 drivers/net/netdevsim/dev.c:1672
 #6: ffffffff8fcd1dc8 (rtnl_mutex){+.+.}-{3:3}, at: unregister_nexthop_notifier+0x17/0x40 net/ipv4/nexthop.c:3913

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xff4/0x1040 kernel/hung_task.c:379
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 4690 Comm: udevd Not tainted 6.12.0-rc2-syzkaller-00050-g5b7c893ed5ed #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:mark_lock+0x3/0x360 kernel/locking/lockdep.c:4686
Code: 04 ff ff ff e8 9e b9 54 0a 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 55 41 57 <41> 56 41 55 41 54 53 48 83 ec 10 49 89 f7 48 89 3c 24 49 bd 00 00
RSP: 0018:ffffc9000305f2c8 EFLAGS: 00000006
RAX: 000000000005054b RBX: ffff88807eb664e0 RCX: ffffffff9a3cc903
RDX: 0000000000000003 RSI: ffff88807eb664e0 RDI: ffff88807eb65a00
RBP: ffffc9000305f388 R08: ffffffff901cee2f R09: 1ffffffff2039dc5
R10: dffffc0000000000 R11: fffffbfff2039dc6 R12: ffff88807eb66500
R13: 0000000000000000 R14: ffff88807eb664d8 R15: 1ffff1100fd6cc9b
FS:  00007efdac2c9c80(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000c00091d660 CR3: 000000007e158000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 mark_held_locks kernel/locking/lockdep.c:4321 [inline]
 __trace_hardirqs_on_caller kernel/locking/lockdep.c:4339 [inline]
 lockdep_hardirqs_on_prepare+0x282/0x780 kernel/locking/lockdep.c:4406
 trace_hardirqs_on+0x28/0x40 kernel/trace/trace_preemptirq.c:61
 __raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:151 [inline]
 _raw_spin_unlock_irqrestore+0x8f/0x140 kernel/locking/spinlock.c:194
 __debug_check_no_obj_freed lib/debugobjects.c:998 [inline]
 debug_check_no_obj_freed+0x561/0x580 lib/debugobjects.c:1019
 free_pages_prepare mm/page_alloc.c:1115 [inline]
 free_unref_page+0x41b/0xf20 mm/page_alloc.c:2638
 discard_slab mm/slub.c:2677 [inline]
 __put_partials+0xeb/0x130 mm/slub.c:3145
 put_cpu_partial+0x17c/0x250 mm/slub.c:3220
 __slab_free+0x2ea/0x3d0 mm/slub.c:4449
 qlink_free mm/kasan/quarantine.c:163 [inline]
 qlist_free_all+0x9a/0x140 mm/kasan/quarantine.c:179
 kasan_quarantine_reduce+0x14f/0x170 mm/kasan/quarantine.c:286
 __kasan_slab_alloc+0x23/0x80 mm/kasan/common.c:329
 kasan_slab_alloc include/linux/kasan.h:247 [inline]
 slab_post_alloc_hook mm/slub.c:4085 [inline]
 slab_alloc_node mm/slub.c:4134 [inline]
 kmem_cache_alloc_noprof+0x135/0x2a0 mm/slub.c:4141
 anon_vma_chain_alloc mm/rmap.c:143 [inline]
 anon_vma_fork+0x1fa/0x580 mm/rmap.c:365
 dup_mmap kernel/fork.c:713 [inline]
 dup_mm kernel/fork.c:1674 [inline]
 copy_mm+0xd7c/0x1f40 kernel/fork.c:1723
 copy_process+0x1845/0x3d50 kernel/fork.c:2372
 kernel_clone+0x226/0x8f0 kernel/fork.c:2784
 __do_sys_clone kernel/fork.c:2927 [inline]
 __se_sys_clone kernel/fork.c:2911 [inline]
 __x64_sys_clone+0x258/0x2a0 kernel/fork.c:2911
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7efdabefca12
Code: 41 5d 41 5e 41 5f c3 64 48 8b 04 25 10 00 00 00 45 31 c0 31 d2 31 f6 bf 11 00 20 01 4c 8d 90 d0 02 00 00 b8 38 00 00 00 0f 05 <48> 3d 00 f0 ff ff 76 10 48 8b 15 e7 43 0f 00 f7 d8 64 89 02 48 83
RSP: 002b:00007ffde4edde98 EFLAGS: 00000246 ORIG_RAX: 0000000000000038
RAX: ffffffffffffffda RBX: 0000559c91bf0801 RCX: 00007efdabefca12
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000001200011
RBP: 0000000000000003 R08: 0000000000000000 R09: 0000559c91be0910
R10: 00007efdac2c9f50 R11: 0000000000000246 R12: 0000559c91c06ae0
R13: 0000000000000000 R14: 0000000000000000 R15: 0000559c91be0910
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


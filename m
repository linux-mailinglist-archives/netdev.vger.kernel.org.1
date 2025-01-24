Return-Path: <netdev+bounces-160761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4463BA1B39D
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 11:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E83B73ABE5C
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 10:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D849B207A06;
	Fri, 24 Jan 2025 10:39:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B0A1D47A6
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 10:39:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737715164; cv=none; b=iqRdaCaxDJ4BffjR9V3iUEjRx9EO+1pz84XpArL1kk9+IMKhU8cB0BteJ9NAsCdiHIyzOUbNcldo8gLa9aHxblGis5xzHvLPZq7wbKWoqR1pBw4nC7rGffOFtbldBH9HLVsPyJ+uiz8hiYGbLgQBLe3A9PdbRXWfJZXF0FQ9wZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737715164; c=relaxed/simple;
	bh=/B0rsYfsHp+rUuckiWQ2hG8MNexA1mWGMgJcxB0HMtY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=uITn1l9n5uADp/RAb6KMYb+GKPxg6zYES99HHoeydqU8QQscICk4bNBS3VNLbhQoajLZlT/T2UYZAcT6602UJctOs+op5JidKISBntAhKbyh2h5+Uni2x9VpwDAG1FLd9iRTRWFFxNUclJHz4/wa2koEUiAEXHa/elwO+spTy58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3cf6ceaccdbso13339595ab.1
        for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 02:39:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737715162; x=1738319962;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MxNno5zxws6mVLutsOZuLJl70rmf4QucjPZ72NaJpVU=;
        b=qCVOetrVKoer33wOs09mTiwVSv6cIKjd8fMRsUsXiv5+oYDjoB466miuU6eyNHVxx9
         2TdOql8MKcVV9P65OSvZV6YxzimNcarlUN2b5Kp8Rt+blUajTDgBPK/6Xt8fXWA6Uahy
         vpCP+cDjyaoRIJUMmNXjL/BMhO6KyVhx6pKsZF8Er+csaPPJ77hvsbA9um+WgkjzxcwF
         hQyjlVVXwMlbxOSb2Ewd8N7WQj8Utip4juIkxDvWAqxsGqCpYJTxzjLSXDGrTai7evSy
         4Lv3WrYr2kmraDJLCVm4i/FvwuZd7psAwmWe7yacl25EaVGTXP3sVfdfLKq00igtFSE3
         WZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCXfniVdNWBccX0jgzaDfrz4RHxdwjtZNnzwtU08qCLFVsy8srKV+BA3EmI3mpCkZbmrC1ejFCw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz/wz8VR+B3KfBQjMNLRSOnmvffIqyU1dU5gREJ/mfpAVGGLAsn
	TCgLj/PYVg+ku4KmPdynOYzFkSHDU1Ji15a9yW4FhjpcimWUxQMX7CVs81oRXK44WumzizBFRLG
	rmtz9oRbxQN3+Xv4vAPKy35Kp2MiQ0o7rbHgHtPGqiICf/VIp4ZlXwFI=
X-Google-Smtp-Source: AGHT+IF9RIbfEBZs5LOB/BqjJeDz7F91pWHnGrAWyvjrhd2NHlelTAfHKOryXlD5pyBmGpDJO6h+KDSNammzjNzCAJxS9/EFDwfd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa3:b0:3cf:cc8d:48a1 with SMTP id
 e9e14a558f8ab-3cfcc8d4d81mr4893475ab.18.1737715161695; Fri, 24 Jan 2025
 02:39:21 -0800 (PST)
Date: Fri, 24 Jan 2025 02:39:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67936dd9.050a0220.2eae65.001a.GAE@google.com>
Subject: [syzbot] [wireless?] upstream test error: possible deadlock in ieee80211_remove_interfaces
From: syzbot <syzbot+f64ec90806724c999178@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bc8198dc7ebc Merge tag 'sched_ext-for-6.14' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=10763ab0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=faaefa8d73d72fff
dashboard link: https://syzkaller.appspot.com/bug?extid=f64ec90806724c999178
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3af0795be8e4/disk-bc8198dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/630156792aa7/vmlinux-bc8198dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f2c5067dd705/bzImage-bc8198dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f64ec90806724c999178@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.13.0-syzkaller-05252-gbc8198dc7ebc #0 Not tainted
------------------------------------------------------
kworker/u8:5/318 is trying to acquire lock:
ffffffff8fef6fa8 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_acquire_if_cleanup_net net/core/dev.c:10272 [inline]
ffffffff8fef6fa8 (rtnl_mutex){+.+.}-{4:4}, at: unregister_netdevice_many_notify+0x1a51/0x21a0 net/core/dev.c:11792

but task is already holding lock:
ffff888073480768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6061 [inline]
ffff888073480768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_remove_interfaces+0xf1/0x720 net/mac80211/iface.c:2280

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #1 (&rdev->wiphy.mtx){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       wiphy_lock include/net/cfg80211.h:6046 [inline]
       wiphy_register+0x1c9c/0x2860 net/wireless/core.c:1006
       ieee80211_register_hw+0x2455/0x4060 net/mac80211/main.c:1587
       mac80211_hwsim_new_radio+0x304e/0x54d0 drivers/net/wireless/virtual/mac80211_hwsim.c:5558
       init_mac80211_hwsim+0x432/0x8c0 drivers/net/wireless/virtual/mac80211_hwsim.c:6910
       do_one_initcall+0x128/0x700 init/main.c:1267
       do_initcall_level init/main.c:1329 [inline]
       do_initcalls init/main.c:1345 [inline]
       do_basic_setup init/main.c:1364 [inline]
       kernel_init_freeable+0x5c7/0x900 init/main.c:1578
       kernel_init+0x1c/0x2b0 init/main.c:1467
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (rtnl_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain kernel/locking/lockdep.c:3906 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       rtnl_acquire_if_cleanup_net net/core/dev.c:10272 [inline]
       unregister_netdevice_many_notify+0x1a51/0x21a0 net/core/dev.c:11792
       unregister_netdevice_many net/core/dev.c:11875 [inline]
       unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11741
       unregister_netdevice include/linux/netdevice.h:3329 [inline]
       _cfg80211_unregister_wdev+0x64b/0x830 net/wireless/core.c:1251
       ieee80211_remove_interfaces+0x34f/0x720 net/mac80211/iface.c:2305
       ieee80211_unregister_hw+0x55/0x3a0 net/mac80211/main.c:1681
       mac80211_hwsim_del_radio drivers/net/wireless/virtual/mac80211_hwsim.c:5664 [inline]
       hwsim_exit_net+0x3ad/0x7d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6544
       ops_exit_list+0xb0/0x180 net/core/net_namespace.c:172
       cleanup_net+0x5c6/0xbf0 net/core/net_namespace.c:652
       process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
       process_scheduled_works kernel/workqueue.c:3317 [inline]
       worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
       kthread+0x3af/0x750 kernel/kthread.c:464
       ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&rdev->wiphy.mtx);
                               lock(rtnl_mutex);
                               lock(&rdev->wiphy.mtx);
  lock(rtnl_mutex);

 *** DEADLOCK ***

4 locks held by kworker/u8:5/318:
 #0: ffff88801beeb148 ((wq_completion)netns){+.+.}-{0:0}, at: process_one_work+0x1293/0x1ba0 kernel/workqueue.c:3211
 #1: ffffc90003017d18 (net_cleanup_work){+.+.}-{0:0}, at: process_one_work+0x921/0x1ba0 kernel/workqueue.c:3212
 #2: ffffffff8fee1390 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0xca/0xbf0 net/core/net_namespace.c:606
 #3: ffff888073480768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_constructor include/net/cfg80211.h:6061 [inline]
 #3: ffff888073480768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_remove_interfaces+0xf1/0x720 net/mac80211/iface.c:2280

stack backtrace:
CPU: 0 UID: 0 PID: 318 Comm: kworker/u8:5 Not tainted 6.13.0-syzkaller-05252-gbc8198dc7ebc #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 12/27/2024
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x490/0x760 kernel/locking/lockdep.c:2076
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain kernel/locking/lockdep.c:3906 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
 rtnl_acquire_if_cleanup_net net/core/dev.c:10272 [inline]
 unregister_netdevice_many_notify+0x1a51/0x21a0 net/core/dev.c:11792
 unregister_netdevice_many net/core/dev.c:11875 [inline]
 unregister_netdevice_queue+0x307/0x3f0 net/core/dev.c:11741
 unregister_netdevice include/linux/netdevice.h:3329 [inline]
 _cfg80211_unregister_wdev+0x64b/0x830 net/wireless/core.c:1251
 ieee80211_remove_interfaces+0x34f/0x720 net/mac80211/iface.c:2305
 ieee80211_unregister_hw+0x55/0x3a0 net/mac80211/main.c:1681
 mac80211_hwsim_del_radio drivers/net/wireless/virtual/mac80211_hwsim.c:5664 [inline]
 hwsim_exit_net+0x3ad/0x7d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6544
 ops_exit_list+0xb0/0x180 net/core/net_namespace.c:172
 cleanup_net+0x5c6/0xbf0 net/core/net_namespace.c:652
 process_one_work+0x9c5/0x1ba0 kernel/workqueue.c:3236
 process_scheduled_works kernel/workqueue.c:3317 [inline]
 worker_thread+0x6c8/0xf00 kernel/workqueue.c:3398
 kthread+0x3af/0x750 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
bond0 (unregistering): Released all slaves


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


Return-Path: <netdev+bounces-194568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E9FFACAAF4
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 10:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45251189BC9F
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 08:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A97B21CAA7D;
	Mon,  2 Jun 2025 08:57:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1C12C3240
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 08:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748854657; cv=none; b=SxSESLbZ4SINANG3/fEAopSUxf0Z2A/QqqoKcR88vqhKIbTdonII9wRDEu8c8oTaC8aGyCzkvEReOY2+KJwYOAQdX4Sj1bkt/bctT5+O2AYktmqEgJLyxDJ8hGjc6UYMsixabjqavExqL+FzX+oRwiTkK8S639u7DhiNl4gN5T8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748854657; c=relaxed/simple;
	bh=WIyR3Re7+up+kS0orF/kj11dYKuFT2G96GA7uxPW2yg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FluUrB/+IE+ZTKGsUzOBcbQ731XYTBvwpGdQDBOkB3qENjsfnunRRHbVTXFOVQkG58hGavFArOCpueDW24z61sqkt7+UBsrLVaU9mTqEsT6L/+QRKyMzwYEYWo/hh++hf0G82O8nQoHSJIPjgbhE8qiHaLZu0BiAOzCRID/FK84=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3dd74e0f5c7so28745625ab.0
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 01:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748854655; x=1749459455;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2+Brcn+wYWsVRkhj6nrhn1xtDtEP8u0MO8YrU6mHoho=;
        b=YStPbmzIAVM/bEB6FpkSgIn1INVvqSl9wG/CuvAsZlwOA+ZFxSqaSFaU8OgR+L5tJB
         mlPT7xPtoTGOn6hV23ebplHBP4UMb+WGVLrdP+JVg/OQRG02D0jtM8290upydEnZL45u
         +MhvNQN8pkIrQyFbNa0VMnqJQkdXvaWt2aWgxxgPMWCaXSQdwPQQybvmodn/hH6adZPh
         Sebr+0685O2fbScAjuiCNQ42gBuibXtR5F8bQYnw9pIPRDRwcDjQQFghdLkhnKHg21ud
         XCCv9ijwcvm3a3fm17qbm07ubVBRPtIkuE4cHcdQH41usKRzrdOVM/d1OL6/shTT0s9A
         SC2A==
X-Forwarded-Encrypted: i=1; AJvYcCW40/OjVz3mikp6Zy3EtPsTrYLK7Grp6z/c08X6USBodOTQRw/weTC1NeZGFAOibgep8/9Hgfc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8VH0W6gcPT3GXhY2HTYIyuBISiJe7rdgOaqgGwVDN5SpXRhEe
	PQETi/njUP1R4nki6Hk09VswXZbA+fFvc1xuIvT0JiM8soAaBTKAd0RaUsrTttckRdYIRM9U3vT
	fwhQARlIR3m44A4227akflORLAGaIQJi32xxmHpQTJlbM9Vlx8o3X8QMT3WE=
X-Google-Smtp-Source: AGHT+IHK0k+47ZR/TMNO3T6BWt795DGnNcgyXBSxD6tIApSqlzaFasTtvBoNjyO2TaLiiD8DxZzJRSgsPdw2hoAQqoX5787xpZXt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:250c:b0:3dd:8724:aa93 with SMTP id
 e9e14a558f8ab-3dd9cc159bdmr125747955ab.22.1748854655016; Mon, 02 Jun 2025
 01:57:35 -0700 (PDT)
Date: Mon, 02 Jun 2025 01:57:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683d677f.a00a0220.d8eae.004b.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in __netdev_update_features
From: syzbot <syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7d4e49a77d99 Merge tag 'mm-nonmm-stable-2025-05-31-15-28' ..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1298600c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2ea0d63949bc4278
dashboard link: https://syzkaller.appspot.com/bug?extid=7e0f89fb6cae5d002de0
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eb4b617767b5/disk-7d4e49a7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d0be53c5da74/vmlinux-7d4e49a7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9a5769a0ff61/bzImage-7d4e49a7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com

netdevsim netdevsim1 netdevsim0: unset [0, 0] type 1 family 0 port 8472 - 0
netdevsim netdevsim1 netdevsim0: unset [1, 0] type 2 family 0 port 6081 - 0
============================================
WARNING: possible recursive locking detected
6.15.0-syzkaller-10769-g7d4e49a77d99 #0 Not tainted
--------------------------------------------
syz.1.2750/15558 is trying to acquire lock:
ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_sync_lower_features net/core/dev.c:10549 [inline]
ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __netdev_update_features+0xcb1/0x1a20 net/core/dev.c:10719

but task is already holding lock:
ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __dev_ethtool net/ethtool/ioctl.c:3227 [inline]
ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_ethtool+0x716/0x1990 net/ethtool/ioctl.c:3490
and the lock comparison function returns 0:

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev_instance_lock_key#20);
  lock(&dev_instance_lock_key#20);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.1.2750/15558:
 #0: ffffffff8f50b248 (rtnl_mutex){+.+.}-{4:4}, at: dev_ethtool+0x1d0/0x1990 net/ethtool/ioctl.c:3489
 #1: ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2756 [inline]
 #1: ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 #1: ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __dev_ethtool net/ethtool/ioctl.c:3227 [inline]
 #1: ffff88805a35cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_ethtool+0x716/0x1990 net/ethtool/ioctl.c:3490

stack backtrace:
CPU: 0 UID: 0 PID: 15558 Comm: syz.1.2750 Not tainted 6.15.0-syzkaller-10769-g7d4e49a77d99 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_deadlock_bug+0x28b/0x2a0 kernel/locking/lockdep.c:3044
 check_deadlock kernel/locking/lockdep.c:3096 [inline]
 validate_chain+0x1a3f/0x2140 kernel/locking/lockdep.c:3898
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5240
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5871
 __mutex_lock_common kernel/locking/mutex.c:602 [inline]
 __mutex_lock+0x182/0xe80 kernel/locking/mutex.c:747
 netdev_lock include/linux/netdevice.h:2756 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 netdev_sync_lower_features net/core/dev.c:10549 [inline]
 __netdev_update_features+0xcb1/0x1a20 net/core/dev.c:10719
 netdev_change_features+0x72/0xd0 net/core/dev.c:10791
 bond_compute_features+0x615/0x680 drivers/net/bonding/bond_main.c:1614
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:4112 [inline]
 bond_netdev_event+0x72e/0xe80 drivers/net/bonding/bond_main.c:4157
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2268 [inline]
 call_netdevice_notifiers net/core/dev.c:2282 [inline]
 netdev_features_change+0x85/0xc0 net/core/dev.c:1571
 __dev_ethtool net/ethtool/ioctl.c:3457 [inline]
 dev_ethtool+0x1520/0x1990 net/ethtool/ioctl.c:3490
 dev_ioctl+0x392/0x1150 net/core/dev_ioctl.c:758
 sock_do_ioctl+0x22c/0x300 net/socket.c:1204
 sock_ioctl+0x576/0x790 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fa86e38e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fa86b98f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fa86e5b6320 RCX: 00007fa86e38e969
RDX: 0000200000000080 RSI: 0000000000008946 RDI: 0000000000000006
RBP: 00007fa86e410ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fa86e5b6320 R15: 00007fa86e6dfa28
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


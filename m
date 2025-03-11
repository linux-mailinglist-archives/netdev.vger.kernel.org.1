Return-Path: <netdev+bounces-174022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BE84DA5D074
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 21:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E1A23A2CA4
	for <lists+netdev@lfdr.de>; Tue, 11 Mar 2025 20:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15918264625;
	Tue, 11 Mar 2025 20:10:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB882641CF
	for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 20:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741723838; cv=none; b=cePa2xK/0aHFgTw8WE1AuESBR27zzcxzk3CPPP/lNvFlV6SnzAiY9NMmAv9UVDTXXXd/rqpkvqaEnqk4AAHQwuz5DtpE/udatiyoDPdnpXJBxda0HepfyzpAaz5gSUoVqw/FUlg1uWNHPbP7bWt4LX++rdrlM7XWzoJu6qPo5L0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741723838; c=relaxed/simple;
	bh=aFKCZfdFsIRkZFINLV3BJZd9xCFjDiAUkZlsIIwzK+g=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XR5ccHha3vWuCKLSzN+LRy3QVuJ5vG0NsYeLVTT0XLkIPiwZRFWX7prL8BGMyjD5ZLR6RfdGryjPApeiS2ZpAuB9fiOy+TlmV9khu5I1C0RsvQsODRNPNCiFs7vY2yRJJfiRLpZXwHU9nHRoplIvpRrLQk8Xf86vTCyXLD5cMTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d2a40e470fso46076835ab.3
        for <netdev@vger.kernel.org>; Tue, 11 Mar 2025 13:10:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741723835; x=1742328635;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fAbR6M7N3OQb11wp6aQIDILnV5A7+sMu1XUbDZI3luU=;
        b=jRjBDXjk7cYZDgPSbn/B7oTK504mGF9/M8C1Cqf+lfzW2+S9LMkHj29sIYZQjZymKo
         beQsAqy74ffFZGEYM+PcAjwz4+Dfn0chIW+CqUwZLvk/52C+xCvCFdJp3lpozESQc5pL
         vRMJJGMphcxy59hjQGkYpq4SlW8+uvW+OmRNVKOTR8M4qji4VVcFwadspZtRt5Oo6jjm
         njB8TpcjJTFgUhmZ13EyOMXvK9Uez2os3icqGgg0/NcEJvAUMMFMZbaVFHcEkjRcf+mb
         RCGRcbcPRy3adT4daiFHhrvJHiqSxCaU8FxLxb7QlUKEkn+5TFDv6bAWkdxfxbZ+jSB3
         Dnew==
X-Forwarded-Encrypted: i=1; AJvYcCXJZfd+I/pPf6VFUx+OTJd5SV/zC5uJ38gUdKoe6u5aNhMoZ/hDhVQ9hk5G/NfyfGOYjdDacJw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrqjsoU9WflgMxyOS/cohQE0WYQa+Te+xZnepjKGUSQEsYOIjI
	4+kxjyg2YghyjtLcaEyoJuTs30IVIMermtWKMWqdX+2o4FwBNWjMMpYmcEbLhoL6AbpwSIOlUoT
	p9UPKKXl5pLEDG2l2TDh2C/A9TC8CgS3gNrgPM1m+bq6MtleJgugau3E=
X-Google-Smtp-Source: AGHT+IF5s4PMrGgLsIT1nPJQVuQQlu1V9L+gjvWcCgskMjLrTbU4svnxxi5cKdFVTtX2DVp+uruNWwnHbgPYqx+CMrpHZgFEFwQK
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:11:b0:3d1:79a1:5b85 with SMTP id
 e9e14a558f8ab-3d441a470aemr271006985ab.21.1741723835443; Tue, 11 Mar 2025
 13:10:35 -0700 (PDT)
Date: Tue, 11 Mar 2025 13:10:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67d098bb.050a0220.14e108.001c.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in dev_set_allmulti
From: syzbot <syzbot+b0c03d76056ef6cd12a6@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    40587f749df2 Merge branch 'enic-enable-32-64-byte-cqes-and..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=128b1f8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca99d9d1f4a8ecfa
dashboard link: https://syzkaller.appspot.com/bug?extid=b0c03d76056ef6cd12a6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6d02993a9211/disk-40587f74.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2c8b300bf362/vmlinux-40587f74.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2d5be21882cf/bzImage-40587f74.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b0c03d76056ef6cd12a6@syzkaller.appspotmail.com

netlink: 'syz.4.478': attribute type 10 has an invalid length.
netdevsim netdevsim4 netdevsim0: left allmulticast mode
============================================
WARNING: possible recursive locking detected
6.14.0-rc5-syzkaller-01183-g40587f749df2 #0 Not tainted
--------------------------------------------
syz.4.478/7361 is trying to acquire lock:
ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2731 [inline]
ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:40 [inline]
ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: dev_set_allmulti+0x11c/0x270 net/core/dev_api.c:279

but task is already holding lock:
ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2731 [inline]
ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:40 [inline]
ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: dev_open+0x11c/0x260 net/core/dev_api.c:190

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev->lock);
  lock(&dev->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.4.478/7361:
 #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xc4c/0x1d90 net/core/rtnetlink.c:4054
 #1: ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2731 [inline]
 #1: ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:40 [inline]
 #1: ffff88807b5e4d28 (&dev->lock){+.+.}-{4:4}, at: dev_open+0x11c/0x260 net/core/dev_api.c:190

stack backtrace:
CPU: 1 UID: 0 PID: 7361 Comm: syz.4.478 Not tainted 6.14.0-rc5-syzkaller-01183-g40587f749df2 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3039
 check_deadlock kernel/locking/lockdep.c:3091 [inline]
 validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3893
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
 netdev_lock include/linux/netdevice.h:2731 [inline]
 netdev_lock_ops include/net/netdev_lock.h:40 [inline]
 dev_set_allmulti+0x11c/0x270 net/core/dev_api.c:279
 vlan_dev_open+0x2be/0x8a0 net/8021q/vlan_dev.c:278
 __dev_open+0x45a/0x8a0 net/core/dev.c:1644
 __dev_change_flags+0x1e2/0x6f0 net/core/dev.c:9375
 netif_change_flags+0x8b/0x1a0 net/core/dev.c:9438
 dev_change_flags+0x146/0x270 net/core/dev_api.c:68
 vlan_device_event+0x1b81/0x1de0 net/8021q/vlan.c:469
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2244 [inline]
 call_netdevice_notifiers net/core/dev.c:2258 [inline]
 netif_open+0x13a/0x1b0 net/core/dev.c:1672
 dev_open+0x13e/0x260 net/core/dev_api.c:191
 bond_enslave+0x103c/0x3910 drivers/net/bonding/bond_main.c:2135
 do_set_master+0x579/0x730 net/core/rtnetlink.c:2943
 do_setlink+0xfee/0x40f0 net/core/rtnetlink.c:3149
 rtnl_changelink net/core/rtnetlink.c:3759 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3918 [inline]
 rtnl_newlink+0x15a6/0x1d90 net/core/rtnetlink.c:4055
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6945
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f191f98d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f192081c038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f191fba5fa0 RCX: 00007f191f98d169
RDX: 0000000000000000 RSI: 0000400000000680 RDI: 0000000000000003
RBP: 00007f191fa0e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f191fba5fa0 R15: 00007ffc4fecad18
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


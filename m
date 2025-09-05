Return-Path: <netdev+bounces-220481-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EF6B464A7
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 22:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E51DA05FF4
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 20:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395D82D0616;
	Fri,  5 Sep 2025 20:38:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 767842C237E
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 20:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757104714; cv=none; b=Z8AkyT0jSTB+YGUidrWkgh5UnDYGUnWQRq2xBMTTiTDjeFaKUpf/Mxk90TBYoOHTMs0FBalzT+/lZIF4qgb3gf6e+q352eLf+KuzahLfmQ6LwK7Sj36ZFduFJxr9P1qd1ETfLzBgYUI4pTUXwcn4tEesN/nVXPP6b94B3T2CXks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757104714; c=relaxed/simple;
	bh=9dorNw5jr4FBw8MkC+mwzxxCuwfiFEKuQOXDCLquBZw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=nreF+Zjf0VGKNR696Bj9wEWEpgQZcJ9HAHUt8U2iFILOfJh3+OKwDbnhBqii32Fm5fmzP5+2r6/no0wSi7laSgYD6TrNtlWL/6SRb0WadiJ5n2KnTYTrxljKUqpF9AR9H3/+YeS32RcLbkU1w/HTqXH7BQLu2XJWH0bilRmZUjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3f66898cc14so28792985ab.3
        for <netdev@vger.kernel.org>; Fri, 05 Sep 2025 13:38:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757104711; x=1757709511;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WRbZrxqubglPD7W9p4Azl0oNpWCe0BcsXik3ULMlO1A=;
        b=s2rNC5f/EL3rYhm6WtmkeAYXbNvyJv2Jc4qpSIebc1n8RHaDBKmOKIlACZYqgq3iyD
         bP45tKFYWxOaKFgxBOdTRCcBvSAbSwLoEQox7F4vi6hi97SR9I/AKC0TxF/9jH29Rk3P
         NrOS4LB/+9WzFi4vjuW2Fd5bHNhKeyqTHqPmhrFne8lGbn66goqQA8zIqUIY8FquXOKn
         q53/0ITlF0HzEPtcocF9amNsCNbqqXVLUaAe1qVVtcGEvOHqflif5rtbcz2Yu7KWy7rc
         a3rIJgsqN8bX2p5qVmy0g8G+HN6MW9XXfPiAMmSEEOC+ZXHeIVCuOlgjY50fcfunL44D
         niPw==
X-Forwarded-Encrypted: i=1; AJvYcCVjLa9AWjYeKWQu5dc3i6IT0qH6Br4IM8Pb1vbk5rwwQexQEcfBd472jDtpKw1RKrBeP6XzUWk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3HNPERBN8n2Odxtk2NCjFfVfriRywHqWffP5JnZJj4lMK7i8Q
	CipK+e0g/eq83bdcDBvFxo5MaKBfQwQtqPOwj104ewcbhuzN9ZRsr7qlLOF0lD7K9bzo6uBxwr1
	fJTNG7ps0n+eTwtgEpwDg0DzNVoLz/yyeQ/5tll46lSs2ZTHKHfWl/FfAXzY=
X-Google-Smtp-Source: AGHT+IF26XOIwoqn7XoCgF2pbJnVnnS+jDcvBdg3uxxLuPFgYOz1TlJqcCqSPMhUW3+f05h5FdkCaH6S5O5185rDhP3cbWb3cm95
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168e:b0:3f6:69ec:ea1e with SMTP id
 e9e14a558f8ab-3fd963dc775mr4244575ab.23.1757104711604; Fri, 05 Sep 2025
 13:38:31 -0700 (PDT)
Date: Fri, 05 Sep 2025 13:38:31 -0700
In-Reply-To: <683d677f.a00a0220.d8eae.004b.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68bb4a47.a00a0220.eb3d.001a.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in __netdev_update_features
From: syzbot <syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, stfomichev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    d69eb204c255 Merge tag 'net-6.17-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13a2f162580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9c302bcfb26a48af
dashboard link: https://syzkaller.appspot.com/bug?extid=7e0f89fb6cae5d002de0
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12942962580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16942962580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d2a8d25d4378/disk-d69eb204.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/4574714ede3c/vmlinux-d69eb204.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e5bae1ec81fb/bzImage-d69eb204.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+7e0f89fb6cae5d002de0@syzkaller.appspotmail.com

netlink: 8 bytes leftover after parsing attributes in process `syz.0.17'.
netdevsim netdevsim0 netdevsim0: entered promiscuous mode
macsec1: entered allmulticast mode
netdevsim netdevsim0 netdevsim0: entered allmulticast mode
============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.0.17/6023 is trying to acquire lock:
ffff88802911cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2761 [inline]
ffff88802911cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff88802911cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_sync_lower_features net/core/dev.c:10649 [inline]
ffff88802911cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __netdev_update_features+0xcb1/0x1be0 net/core/dev.c:10819

but task is already holding lock:
ffff88802911cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2761 [inline]
ffff88802911cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff88802911cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __dev_ethtool net/ethtool/ioctl.c:3235 [inline]
ffff88802911cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_ethtool+0x716/0x19b0 net/ethtool/ioctl.c:3502
and the lock comparison function returns 0:

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev_instance_lock_key#20);
  lock(&dev_instance_lock_key#20);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.0.17/6023:
 #0: ffffffff8f539288 (rtnl_mutex){+.+.}-{4:4}, at: dev_ethtool+0x1d0/0x19b0 net/ethtool/ioctl.c:3501
 #1: ffff88802911cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2761 [inline]
 #1: ffff88802911cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 #1: ffff88802911cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __dev_ethtool net/ethtool/ioctl.c:3235 [inline]
 #1: ffff88802911cd30 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_ethtool+0x716/0x19b0 net/ethtool/ioctl.c:3502

stack backtrace:
CPU: 1 UID: 0 PID: 6023 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 print_deadlock_bug+0x28b/0x2a0 kernel/locking/lockdep.c:3041
 check_deadlock kernel/locking/lockdep.c:3093 [inline]
 validate_chain+0x1a3f/0x2140 kernel/locking/lockdep.c:3895
 __lock_acquire+0xab9/0xd20 kernel/locking/lockdep.c:5237
 lock_acquire+0x120/0x360 kernel/locking/lockdep.c:5868
 __mutex_lock_common kernel/locking/mutex.c:598 [inline]
 __mutex_lock+0x187/0x1350 kernel/locking/mutex.c:760
 netdev_lock include/linux/netdevice.h:2761 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 netdev_sync_lower_features net/core/dev.c:10649 [inline]
 __netdev_update_features+0xcb1/0x1be0 net/core/dev.c:10819
 netdev_update_features+0x6d/0xe0 net/core/dev.c:10876
 macsec_notify+0x2f5/0x660 drivers/net/macsec.c:4533
 notifier_call_chain+0x1b3/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 netdev_features_change+0x85/0xc0 net/core/dev.c:1570
 __dev_ethtool net/ethtool/ioctl.c:3469 [inline]
 dev_ethtool+0x1536/0x19b0 net/ethtool/ioctl.c:3502
 dev_ioctl+0x392/0x1150 net/core/dev_ioctl.c:759
 sock_do_ioctl+0x22c/0x300 net/socket.c:1252
 sock_ioctl+0x576/0x790 net/socket.c:1359
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:598 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:584
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f08c1f8ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff0a699878 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007f08c21c5fa0 RCX: 00007f08c1f8ebe9
RDX: 0000200000000080 RSI: 0000000000008946 RDI: 0000000000000006
RBP: 00007f08c2011e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f08c21c5fa0 R14: 00007f08c21c5fa0 R15: 0000000000000003
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


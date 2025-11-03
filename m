Return-Path: <netdev+bounces-235109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A61CEC2C1B3
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 14:34:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C6273A9A53
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 13:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2595826ED5F;
	Mon,  3 Nov 2025 13:29:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6570926F2AD
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 13:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762176575; cv=none; b=AWfsYdrN3Aj6eWcafUaBeDgGePDUUVbKef3GYw+XUb8ric3ofXCc0xnmUc9TNd+SDZmLXeKx/I6o48JzpwZTzBu6iboaccnX8LFXpH3Xm47aJxR4SBO/JmJLgzb7eU9liFmnK57+SgsIvNRntWxA5zqyuElHnAvXR0bNrrzRbW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762176575; c=relaxed/simple;
	bh=nL4Enrsj6XIoiKW42Qd2q2iyP/xMDQnjnqR1eEr95U0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=jD+ekWw63+hr2Y9ZY99tpLb4a0w8MAGBtyINNBeyWAXVEiwBIeh6oZP7CXLyowtoGvR2fhWhm7yRCbyhIFIGv9UMIhl4xxW8DCmXXeaOm2+D2OFrdW4sg1ZFjAPp418kL3LFUMIZLO3wyqdkrMbETSGSaCWKdEEqZ3PxPoQIKPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-433299e5160so11056535ab.3
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 05:29:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762176572; x=1762781372;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zqiq2pFuvImBAREJJUY/vzISXNjcGWyY/zRuQ8Cth60=;
        b=hVfV87bzaAqZSpKGCTp9NnW+SJ8Qr9AT0OHLI3OQQVxAar4JgmYDWz4f/JPhfhZQL5
         P9P8hi7vlpqEjxyzJk//yVsFtxJnlRZJbuYZ1zQUCoj03UzuzdFW9V9JmFY3708fpVnQ
         td3FMKLx8lsfdT/D2nEkxnYK0Yl+lS7Q2gGUbMX7ES/ngEHIRNULpiRx4jMSGkE1uiDK
         3DTQGcIyF3gkzfmmMwlQemm4XV5L93uCsOjALpeMY/maPlrR2Hr1nm3iYUQBj4zykaXi
         sS7G0l4hraRtyfGwTOIkk5PBLmG0kicAvIW69s3DSSCziufseMB3YApYHL6XVaIrp/pI
         qESg==
X-Forwarded-Encrypted: i=1; AJvYcCXcdJajSfIwkdvy1Swx8xlmeZtLPffT+ifL7jT97uPd08oen8pweeQt8uEoS5OPaj9FUtha668=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1Bqvt1fbV9QEkvg/kJbLeqHdNO1vFyIyDNLaB24YQIcvhkx6i
	FIZQg95wJNSotUGnLSy3neY0Z6BKtty3GTr72mE79KPdrAQ7Sw181SUtob6iskZY3f8AA+9pCjo
	T7bKfvEdGm8QL9cnTLQrPYdVZL/ZfBSY45g+yT3z/GT6EHv+zYzfgVxHK/oY=
X-Google-Smtp-Source: AGHT+IG2Ta/xKw8mDF5MxXL7PEC6/jFhZNveCmW39DdpHE5LxYHjnbYRJV+pvxt3Ezx7ctafIAhYUOIW/+FgPpy50X692sVjQbLY
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a28:b0:430:c17c:5082 with SMTP id
 e9e14a558f8ab-4330d125b63mr172004405ab.6.1762176572541; Mon, 03 Nov 2025
 05:29:32 -0800 (PST)
Date: Mon, 03 Nov 2025 05:29:32 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6908ae3c.050a0220.29fc44.004b.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in __netdev_update_features (2)
From: syzbot <syzbot+f900128d760321f31225@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6146a0f1dfae Linux 6.18-rc4
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17b18012580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e46b8a1c645465a9
dashboard link: https://syzkaller.appspot.com/bug?extid=f900128d760321f31225
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c84c238d0311/disk-6146a0f1.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9ce2b6a4b897/vmlinux-6146a0f1.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3e9c6bea4a10/bzImage-6146a0f1.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f900128d760321f31225@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
syzkaller #0 Not tainted
--------------------------------------------
syz.1.3525/19446 is trying to acquire lock:
ffff888070d30d38 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2765 [inline]
ffff888070d30d38 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff888070d30d38 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_sync_lower_features net/core/dev.c:10737 [inline]
ffff888070d30d38 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __netdev_update_features+0xcb1/0x1be0 net/core/dev.c:10907

but task is already holding lock:
ffff888070d30d38 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2765 [inline]
ffff888070d30d38 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
ffff888070d30d38 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __dev_ethtool net/ethtool/ioctl.c:3285 [inline]
ffff888070d30d38 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_ethtool+0x716/0x19c0 net/ethtool/ioctl.c:3554
and the lock comparison function returns 0:

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev_instance_lock_key#20);
  lock(&dev_instance_lock_key#20);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.1.3525/19446:
 #0: ffffffff8f2cb648 (rtnl_mutex){+.+.}-{4:4}, at: dev_ethtool+0x1d0/0x19c0 net/ethtool/ioctl.c:3553
 #1: ffff888070d30d38 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2765 [inline]
 #1: ffff888070d30d38 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 #1: ffff888070d30d38 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: __dev_ethtool net/ethtool/ioctl.c:3285 [inline]
 #1: ffff888070d30d38 (&dev_instance_lock_key#20){+.+.}-{4:4}, at: dev_ethtool+0x716/0x19c0 net/ethtool/ioctl.c:3554

stack backtrace:
CPU: 0 UID: 0 PID: 19446 Comm: syz.1.3525 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/02/2025
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
 netdev_lock include/linux/netdevice.h:2765 [inline]
 netdev_lock_ops include/net/netdev_lock.h:42 [inline]
 netdev_sync_lower_features net/core/dev.c:10737 [inline]
 __netdev_update_features+0xcb1/0x1be0 net/core/dev.c:10907
 netdev_change_features+0x72/0xd0 net/core/dev.c:10981
 bond_compute_features+0x615/0x680 drivers/net/bonding/bond_main.c:1559
 bond_slave_netdev_event drivers/net/bonding/bond_main.c:4030 [inline]
 bond_netdev_event+0x72e/0xe80 drivers/net/bonding/bond_main.c:4075
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2267 [inline]
 call_netdevice_notifiers net/core/dev.c:2281 [inline]
 netdev_features_change+0x85/0xc0 net/core/dev.c:1570
 __dev_ethtool net/ethtool/ioctl.c:3521 [inline]
 dev_ethtool+0x1541/0x19c0 net/ethtool/ioctl.c:3554
 dev_ioctl+0x392/0x1150 net/core/dev_ioctl.c:773
 sock_do_ioctl+0x22c/0x300 net/socket.c:1268
 sock_ioctl+0x576/0x790 net/socket.c:1375
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:597 [inline]
 __se_sys_ioctl+0xfc/0x170 fs/ioctl.c:583
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc1a3f8efc9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc1a4e6f038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc1a41e5fa0 RCX: 00007fc1a3f8efc9
RDX: 0000200000000000 RSI: 0000000000008946 RDI: 0000000000000004
RBP: 00007fc1a4011f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007fc1a41e6038 R14: 00007fc1a41e5fa0 R15: 00007fc1a430fa28
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


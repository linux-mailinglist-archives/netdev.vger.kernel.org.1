Return-Path: <netdev+bounces-173242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E348BA582B7
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 10:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BBCB13AA864
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 09:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8671A8F71;
	Sun,  9 Mar 2025 09:36:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42EE1A5BBC
	for <netdev@vger.kernel.org>; Sun,  9 Mar 2025 09:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741512991; cv=none; b=clfZ4s6P6Gr7lEP1/WSGp93qQC/1Frk88ZEHW33it8qU34eh2stXnIosDW2fRWQxjM+OGxyq2tD8n1YXa/xO+DjsmhOditUKW5/+fWPJSILy0MxRtserPoBRG12Kmpia2D1ARmlIOciaH46MHiGwGIajNRasjbzG0R+kGtYwzDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741512991; c=relaxed/simple;
	bh=Us8rGbmPFV8r9kILQZkJiRMErAO862YWq8zDsrOKbkI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qqWuMHDGXd99S6rGHF1gMD6CwlJb1455Ky9ntgcsTOxgcUmR47pJiP4KWmKiiklq5wvFasKCM/QT8F0U/YdHR252esm1tbHqYq49typj6GS86C3KBAdjOR1q4f66sS9Cj+7Sz2WJxOtdoGwj7HfI8ZF6g66K3dy7qGwe/cMS5/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-85ad875acccso768678839f.3
        for <netdev@vger.kernel.org>; Sun, 09 Mar 2025 01:36:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741512989; x=1742117789;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VXiY6N7OSU76pQp1Pi3Phz+uoYFFIUVn9s/PtSgWyek=;
        b=dWHbCTdjLra7nx/77dblxYE5/s9Tx09ZbbmYhZhybY7nAqXIibtluYvR+g7fa+Er/j
         HWKmeSN+j0aCuzo+H58PbtAUs0TN8pVikTSXC53BBpDkB/CQg+dXAyiyTJzh5HKu3gho
         tW99MF5YhAwzt6RPY9zklyEpEFH1kqoO9SvVSZFUWV/DlgAdGwWO72RDL85r2WT8/3Gz
         XoNfCpygpze2YkPRT+iSsdzA26S7+LOGnCX8MGyE9v3HjbmeyaEfxEpEp0jLL/pjakqa
         goqJjfFS2uH0mIjwQEQ7ok6+fLkBEOS3tDrgw1EACtJynmQr6Qyy3/fTMlhoT50mopqo
         lLFA==
X-Forwarded-Encrypted: i=1; AJvYcCWy7zMeQmme2JhULfoN+pPE5SB1QNhz1e4ZCnka9P2Gq8bf9EQwYDcng5I2z80dBvX8SQWZlt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzry8rcEQtk9UwgKADYTzl++u7PO+UMwaQdu7J4n/XweohD9Q/a
	rUsFb3rnf54wkKE7TYwFvd4UxQsJx/5QLR/V/8xBtlipz4oae7IsxXlgUFwMem4FY78XDD5Elcr
	jmIS8Xcp3UT++IHJa1Qu92O/8+043KH3Wkma18bfBZV/utpWYTnDznLY=
X-Google-Smtp-Source: AGHT+IFV+ki/og+ynEYa3x+hrLV2cKzsvxHzX28vc/Gong4u9ZA9/KBYgHozqiuX5HtOfa7I7NHKPQUrWMhUoBdhCEKPTcWehmtm
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c0b:b0:3d3:d4f0:271d with SMTP id
 e9e14a558f8ab-3d44196ff85mr126243005ab.12.1741512988912; Sun, 09 Mar 2025
 01:36:28 -0800 (PST)
Date: Sun, 09 Mar 2025 01:36:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cd611c.050a0220.14db68.0073.GAE@google.com>
Subject: [syzbot] [x25?] possible deadlock in lapbeth_device_event
From: syzbot <syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-x25@vger.kernel.org, 
	ms@dev.tdt.de, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8ef890df4031 net: move misc netdev_lock flavors to a separ..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=149cd878580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ca99d9d1f4a8ecfa
dashboard link: https://syzkaller.appspot.com/bug?extid=377b71db585c9c705f8e
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1054d4b7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ed25b0258c8e/disk-8ef890df.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2989aa28823e/vmlinux-8ef890df.xz
kernel image: https://storage.googleapis.com/syzbot-assets/0e040be79a3d/bzImage-8ef890df.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+377b71db585c9c705f8e@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.14.0-rc5-syzkaller-01147-g8ef890df4031 #0 Not tainted
--------------------------------------------
dhcpcd/5500 is trying to acquire lock:
ffff888031330d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2731 [inline]
ffff888031330d28 (&dev->lock){+.+.}-{4:4}, at: netif_napi_add_weight include/linux/netdevice.h:2763 [inline]
ffff888031330d28 (&dev->lock){+.+.}-{4:4}, at: lapbeth_new_device drivers/net/wan/lapbether.c:415 [inline]
ffff888031330d28 (&dev->lock){+.+.}-{4:4}, at: lapbeth_device_event+0x766/0xa20 drivers/net/wan/lapbether.c:460

but task is already holding lock:
ffff88806408cd28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2731 [inline]
ffff88806408cd28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:40 [inline]
ffff88806408cd28 (&dev->lock){+.+.}-{4:4}, at: dev_change_flags+0x120/0x270 net/core/dev_api.c:67

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev->lock);
  lock(&dev->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by dhcpcd/5500:
 #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
 #0: ffffffff8fed6908 (rtnl_mutex){+.+.}-{4:4}, at: devinet_ioctl+0x34c/0x1d80 net/ipv4/devinet.c:1121
 #1: ffff88806408cd28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2731 [inline]
 #1: ffff88806408cd28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/net/netdev_lock.h:40 [inline]
 #1: ffff88806408cd28 (&dev->lock){+.+.}-{4:4}, at: dev_change_flags+0x120/0x270 net/core/dev_api.c:67

stack backtrace:
CPU: 0 UID: 0 PID: 5500 Comm: dhcpcd Not tainted 6.14.0-rc5-syzkaller-01147-g8ef890df4031 #0
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
 netif_napi_add_weight include/linux/netdevice.h:2763 [inline]
 lapbeth_new_device drivers/net/wan/lapbether.c:415 [inline]
 lapbeth_device_event+0x766/0xa20 drivers/net/wan/lapbether.c:460
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 __dev_notify_flags+0x207/0x400
 netif_change_flags+0xf0/0x1a0 net/core/dev.c:9443
 dev_change_flags+0x146/0x270 net/core/dev_api.c:68
 devinet_ioctl+0xea2/0x1d80 net/ipv4/devinet.c:1200
 inet_ioctl+0x3d7/0x4f0 net/ipv4/af_inet.c:1001
 sock_do_ioctl+0x158/0x460 net/socket.c:1190
 sock_ioctl+0x626/0x8e0 net/socket.c:1309
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fcdbbcb2d49
Code: 5c c3 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <41> 89 c0 3d 00 f0 ff ff 76 10 48 8b 15 ae 60 0d 00 f7 d8 41 83 c8
RSP: 002b:00007ffecf47b768 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fcdbbbe46c0 RCX: 00007fcdbbcb2d49
RDX: 00007ffecf48b958 RSI: 0000000000008914 RDI: 000000000000000c
RBP: 00007ffecf49bb18 R08: 00007ffecf48b918 R09: 00007ffecf48b8c8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffecf48b958 R14: 0000000000000028 R15: 0000000000008914
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


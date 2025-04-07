Return-Path: <netdev+bounces-179512-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC0FA7D3B2
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 07:57:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C73C16DB16
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 05:57:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38526224889;
	Mon,  7 Apr 2025 05:57:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 882B3217F33
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 05:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744005458; cv=none; b=eYWjMsb2i1gi0/eNmrZ4tTF8Nh7wZM46y7BJgxSLCpnImkkkhbuL3rRpGHDP30CEfvxZGmxwil9CRmjbVmZSn9SrFIaMUUJa48vc9pJLtRdJL/3K/KUGbSPmB6j1iUi49s+20QhqZjis3qQSi6HsKq9p62L7euayPbxkcbmUFLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744005458; c=relaxed/simple;
	bh=wZAMtio00tnUuSRSg/jkrGfC/Ckh0CfPtvW1/gueJpY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lYbJiAQ7cX/0gSawyRPAr64+jPG7UWbAh/i4+tRRWIihMtOJaMxvXAKwW+QgY2hu4PQh4Pbh4Kq99KhEpVRrOPcHwd7wIorHMTacy5ujbSjz8G76JwILRUemLA0AR6orW9UvQKukxwMmJH4AV16M7kQMPJ/U3C/W68yMN4D0pRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d443811f04so38192995ab.1
        for <netdev@vger.kernel.org>; Sun, 06 Apr 2025 22:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744005455; x=1744610255;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UbXv63Z5SodXmnzGNid3nOXLflCaUgInyA1mKi5VpG0=;
        b=vHOQFDzeirvqdWCm7cEk/Rkemwa8rufmU62nrDPSGpq5oDKi+16EAXzG/xtM022L7W
         OkQsjFpglJLgAn6lpDzdcO+cQ1Q/PXHmYD653VejmQxaJ9/bikaG0KxPmRM04DlNdrGg
         X3wL/Gt5ROouYi06SLw8V0hXTrV+m3jtdLvLVDyoLxZESPgIp0kULoL65cbRGmt5U5z/
         ADvQRhCxMZSBQypl1nKLBkuWhGEbLSVp2l2aFJFYPsgjfsQQ2Kkc9HloCdJOb6X7JGKt
         GarRZMbNLUq9g2oyyR4LSZrKrYi2j1E6jaaF3Nmzkz5I1wMoe4dkxyyBzzkXH/bEz994
         ru7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWzK8A4Qn534u5vfHvZWQyPxuf5vif7elGPdoYDqMorrIw7YVDCyd6xqIzXMVMIH8tGI8FvIU8=@vger.kernel.org
X-Gm-Message-State: AOJu0YzAwLv+RG+4qN21bIpXTN8n9JiGPtjqpA/84UA/eUBboDdk5b5y
	5+O9Of61WdXNPyaYukodaTZilaJ0DWSoTQcUL1Ady5hhZA+EeoCOsW2ixRVBw5+AYnqoOXKIXfV
	GMFOPWP90zmocPzgQw4+KDYUxySNwqXffWLPOiyPeNg2beBWSm3k03Ww=
X-Google-Smtp-Source: AGHT+IGRqD5cJZF9ygr76vAKi3FWlUuVDK8xSls7kcTsvW9STK/rP4Qnv7cI/j/0WZWnEmZJHd8vQc111Gie30xiV3tz2gJ1JOwq
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:19cf:b0:3d6:cd54:ba53 with SMTP id
 e9e14a558f8ab-3d6e3f98641mr106950155ab.22.1744005455659; Sun, 06 Apr 2025
 22:57:35 -0700 (PDT)
Date: Sun, 06 Apr 2025 22:57:35 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f3694f.050a0220.0a13.0280.GAE@google.com>
Subject: [syzbot] [net?] WARNING: bad unlock balance in do_setlink
From: syzbot <syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8bc251e5d874 Merge tag 'nf-25-04-03' of git://git.kernel.o..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1133afb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=24f9c4330e7c0609
dashboard link: https://syzkaller.appspot.com/bug?extid=45016fe295243a7882d3
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1040823f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=151d194c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a500d5daba83/disk-8bc251e5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2459c792199a/vmlinux-8bc251e5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/558655fb055e/bzImage-8bc251e5.xz

The issue was bisected to:

commit dbfc99495d960134bfe1a4f13849fb0d5373b42c
Author: Stanislav Fomichev <sdf@fomichev.me>
Date:   Tue Apr 1 16:34:47 2025 +0000

    net: dummy: request ops lock

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=13233998580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10a33998580000
console output: https://syzkaller.appspot.com/x/log.txt?x=17233998580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+45016fe295243a7882d3@syzkaller.appspotmail.com
Fixes: dbfc99495d96 ("net: dummy: request ops lock")

=====================================
WARNING: bad unlock balance detected!
6.14.0-syzkaller-12504-g8bc251e5d874 #0 Not tainted
-------------------------------------
syz-executor814/5834 is trying to release lock (&dev_instance_lock_key) at:
[<ffffffff89f41f56>] netdev_unlock include/linux/netdevice.h:2756 [inline]
[<ffffffff89f41f56>] netdev_unlock_ops include/net/netdev_lock.h:48 [inline]
[<ffffffff89f41f56>] do_setlink+0xc26/0x43a0 net/core/rtnetlink.c:3406
but there are no more locks to release!

other info that might help us debug this:
1 lock held by syz-executor814/5834:
 #0: ffffffff900fc408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_lock net/core/rtnetlink.c:80 [inline]
 #0: ffffffff900fc408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_nets_lock net/core/rtnetlink.c:341 [inline]
 #0: ffffffff900fc408 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_newlink+0xd68/0x1fe0 net/core/rtnetlink.c:4064

stack backtrace:
CPU: 0 UID: 0 PID: 5834 Comm: syz-executor814 Not tainted 6.14.0-syzkaller-12504-g8bc251e5d874 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_unlock_imbalance_bug+0x185/0x1a0 kernel/locking/lockdep.c:5296
 __lock_release kernel/locking/lockdep.c:5535 [inline]
 lock_release+0x1ed/0x3e0 kernel/locking/lockdep.c:5887
 __mutex_unlock_slowpath+0xee/0x800 kernel/locking/mutex.c:907
 netdev_unlock include/linux/netdevice.h:2756 [inline]
 netdev_unlock_ops include/net/netdev_lock.h:48 [inline]
 do_setlink+0xc26/0x43a0 net/core/rtnetlink.c:3406
 rtnl_group_changelink net/core/rtnetlink.c:3783 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3937 [inline]
 rtnl_newlink+0x1619/0x1fe0 net/core/rtnetlink.c:4065
 rtnetlink_rcv_msg+0x80f/0xd70 net/core/rtnetlink.c:6955
 netlink_rcv_skb+0x208/0x480 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f8/0x9a0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8c3/0xcd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:727
 ____sys_sendmsg+0x523/0x860 net/socket.c:2566
 ___sys_sendmsg net/socket.c:2620 [inline]
 __sys_sendmsg+0x271/0x360 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8427b614a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff9b59f3a8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fff9b59f578 RCX: 00007f8427b614a9
RDX: 0000000000000000 RSI: 0000200000000300 RDI: 0000000000000004
RBP: 00007f8427bd4610 R08: 000000000000000c R09: 00007fff9b59f578
R10: 000000000000001b R11: 0000000000000246 R12: 0000000000000001
R13:


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

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


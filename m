Return-Path: <netdev+bounces-139346-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 40F0C9B1904
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 17:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE7CE28297A
	for <lists+netdev@lfdr.de>; Sat, 26 Oct 2024 15:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9684E1CD0C;
	Sat, 26 Oct 2024 15:16:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f200.google.com (mail-il1-f200.google.com [209.85.166.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEF612E7F
	for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 15:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729955804; cv=none; b=jT2iKyk2x9VzUA338ETBMkmcGv83xCI7gOEkvyUm3Lt4zKre+TdXCUB6eUheWkNNQayC7jkT7dtyGX2z+Q4ZX9NoE+2zSGqiQNkBEU8ysOxJpIdMl17xqq7AAYaEa+D+n6aihc3dOHSfrmo4YBaCiOiEwQRGciQZh+Bwp76RKPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729955804; c=relaxed/simple;
	bh=+nz5RGliBDXdyGlTPnx5tEoP5B634LEwMtbaEY2hKtI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=SdEQUq9DvVuV/MKEJ4reqWvFFLfXqpiVpkcGmWlVwX2XyBKAMlyR4meM12JpDxRchYR6MYjS03GNeWjAbVFAVjYQ+653P5jY7zMKnwfD5yk/3LMRqxx5znJPBy0ZiysLrJ5iYNmDjfat0hnhoGh2d3UPY5IGGnInajxdaR/T2L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f200.google.com with SMTP id e9e14a558f8ab-3a3c5a6c5e1so27858615ab.2
        for <netdev@vger.kernel.org>; Sat, 26 Oct 2024 08:16:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729955801; x=1730560601;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zj/TXT0peYcbVWtL1V2i3O4IbyqgcXzUK4CK4R5SwBg=;
        b=KBOGhOio47s/drGzxnIcB/sn1eVtTo1+3Qx//uOH2A0Mdo3QxNXoa1XSs6A6QOHnGt
         gWjZxkCiqQXQ1/bHS+wLtjdWegYoqXWPlSDzBQLJTtqp99vanly8etrixhCw9ACMbaH5
         MxIp/iui7/mbg17uX7LmQumkgZWO6niYQMXBLq4NdSl8OJSDGJrxc4EbMUtcgigvJzY0
         ZNPvV2Y15RmDDg0MmZUk+hngwB6+eapaOpRiKviDPFmgBGIKsY5WRuxVLMzTYu7unQpz
         f4BU7utfZPop67V05ixR5h7Fg3OAqhE1PVqtD//+svF4ZqrZH+kJgYCxffHEX50K/+dP
         m1AA==
X-Forwarded-Encrypted: i=1; AJvYcCWdzkfqt7pm4cFh3tmXPnf9tbE9Z38D/uiI4qttnrKt6MYseiPVS++m2XdFkrfR2i9JAgBfll8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhD85413XYc8KdGmNo4rFAdBZuKo687Bvaimcqe3XuRGg6AdEh
	hGE2MvdadijPMYJmykpK+PUAvkueoSJUhEqiZBiP/gSS3cvq5IQty62i6u6LEh9PRiGKXN3H8Ht
	dbhjlRw7W1+cLt4aAxBml8UXav+hPxybHKPlPrqfu9UxaAFHjvThxYwQ=
X-Google-Smtp-Source: AGHT+IHU2ZGBOsrvtWpUYLXvP+7OqfG36dutsBmc0AnypkK3ZbSK85fy3TshdFu4FXZLCyt5EqUN+B0DjlBjv7vUG/I23FpaqTjf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d85:b0:3a3:445d:f711 with SMTP id
 e9e14a558f8ab-3a4ed1c2ea6mr26731905ab.0.1729955801683; Sat, 26 Oct 2024
 08:16:41 -0700 (PDT)
Date: Sat, 26 Oct 2024 08:16:41 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <671d07d9.050a0220.2fdf0c.022b.GAE@google.com>
Subject: [syzbot] [net?] WARNING in rtnl_dellink (4)
From: syzbot <syzbot+e1153ace01ff073581b7@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6d858708d465 Merge branch 'net-ethernet-freescale-use-pa-t..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15ce50a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e7f0cac6eaefe81d
dashboard link: https://syzkaller.appspot.com/bug?extid=e1153ace01ff073581b7
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/88c678a36ec8/disk-6d858708.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/b19b4fbbd593/vmlinux-6d858708.xz
kernel image: https://storage.googleapis.com/syzbot-assets/18fef9c3fe20/bzImage-6d858708.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e1153ace01ff073581b7@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 31309 at net/core/dev.c:9526 dev_xdp_uninstall net/core/dev.c:9526 [inline]
WARNING: CPU: 1 PID: 31309 at net/core/dev.c:9526 unregister_netdevice_many_notify+0x18c8/0x1da0 net/core/dev.c:11468
Modules linked in:
CPU: 1 UID: 0 PID: 31309 Comm: syz.4.12366 Not tainted 6.12.0-rc2-syzkaller-00631-g6d858708d465 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:dev_xdp_uninstall net/core/dev.c:9526 [inline]
RIP: 0010:unregister_netdevice_many_notify+0x18c8/0x1da0 net/core/dev.c:11468
Code: 00 f8 90 0f 0b 90 e9 4f ff ff ff e8 42 25 00 f8 90 0f 0b 90 eb 9d e8 37 25 00 f8 90 0f 0b 90 e9 e8 f1 ff ff e8 29 25 00 f8 90 <0f> 0b 90 e9 5a f3 ff ff e8 1b 25 00 f8 90 0f 0b 90 e9 cd f4 ff ff
RSP: 0018:ffffc9000efd6fc0 EFLAGS: 00010283
RAX: ffffffff8994c227 RBX: 00000000ffffffa1 RCX: 0000000000040000
RDX: ffffc9000a0a1000 RSI: 0000000000000dad RDI: 0000000000000dae
RBP: ffffc9000efd71b0 R08: ffffffff8994b57d R09: ffffffff8667d4c8
R10: 0000000000000004 R11: ffff8880619cda00 R12: ffffc90004cdd000
R13: 1ffff1100f056986 R14: ffff8880782b4c30 R15: ffff8880782b4c28
FS:  00007fe4187436c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f5ea6d0cfce CR3: 0000000027e0a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 rtnl_delete_link net/core/rtnetlink.c:3355 [inline]
 rtnl_dellink+0x50b/0x8d0 net/core/rtnetlink.c:3407
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6749
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2607
 ___sys_sendmsg net/socket.c:2661 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe41797dff9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fe418743038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe417b35f80 RCX: 00007fe41797dff9
RDX: 0000000020004010 RSI: 0000000020000000 RDI: 0000000000000004
RBP: 00007fe4179f0296 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe417b35f80 R15: 00007ffd07629398
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


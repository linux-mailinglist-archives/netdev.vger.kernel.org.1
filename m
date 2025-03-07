Return-Path: <netdev+bounces-172811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA21A56295
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 09:33:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44EDE172346
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 08:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0E7C1ACEDF;
	Fri,  7 Mar 2025 08:33:36 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8711A9B34
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 08:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741336416; cv=none; b=bD4TvED23HvGIzTK6uEvmq/iGOARuRfAOjTOEnqoxl4FrBaZwO5GsZEmU0D+K6cd3iU5IHoF6XmPd0L6lal1EJ16aMkovpHr4aQP8vB/Mvz+r024Ei9dpYCoXlyVk9mNRSbVPWWygCQ4/MAotngELvt2Lgm8HbRZvx21bqZQH2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741336416; c=relaxed/simple;
	bh=mGCLj5UDQ2mTgXBIEQlVo05abERo6x8S7LlEK/fWlOk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=rQrGwJbN24oImllH8iW1QJt8EwCNnEkeiuMp8yYLFVLZpuwGq1Tx79wPqXC5ERzi4PME7L3yo7D8EQ70yuVYX7Yc/3wGDI2sTLIOPJUNJ24QJi82QYNd1YqQEllBYJH9XY4AQz6V3/s/Xt0sjgybk3mAQt5CjWbsE5mIItonScU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-84cdb5795b0so120962039f.2
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 00:33:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741336414; x=1741941214;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v5fd+fDoJI9kJwRFWLEJpIru+csBskZYU3W+KIJyP/Y=;
        b=qjqBAFm6m32NZ/2zr6ZNjql/5lFnW0qOrLVUiub32kVwqysUt94McWMzBPofj8WxDr
         0hTyuw2VEWbSFbcHqbM5kurD6S81cxAFZbqMMEWmaLgqW9f+vT5SWhxagCpzPgR1Shn8
         yuKLuJXWYeKf8b3zRCOqdJaWtJl7Z04a0Fr4CbhdYEWytGnK4hO2jfIBwl8mAMsflGwY
         1c2Ec7H74IDW1dPZ2X8hBhiEEMrdEPXRtYgXmPvaoQjnWntKZVKM39GR/AZnA32U534O
         4B6TfnamHIKEF6DD2fxpqrIAAYml6Yal5bXyUgI9sdvqt+3ETiCRWnzqzpxie4yx8OPw
         YccQ==
X-Forwarded-Encrypted: i=1; AJvYcCXY/TIs/XpdrTXa5Mt0VDWxskgJfMfnTNNocrT42XcwTRuEDbDp5ARvkD/BNMXsmrHiVUWwCzk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyQlW+u0xCCj7Df/W2T5aQeMGf/ZmTUG5FRihqFf9gHWwNztGIC
	m1R32RtAjAsRPaRqvSO09AGA2SqSQ0ls+YC9RZLKyYbyu62fr+s6x9T2geHgzKOXx7cz+GFlkwY
	VYe0YgB/Wa6NZf8LjE43PMgaibkr+z/88czYCGXn8y7QZnEQt2RXaCb4=
X-Google-Smtp-Source: AGHT+IHlE3RweCd+bsTDabwH87CjBua7+QYT8ShQ1f2aiovwYup1UO6GYWGuXIfaJ9e4BfseCgR9lzYwbl7xB28zVYpPa7bhXOwA
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cdad:0:b0:3d3:faad:7c6f with SMTP id
 e9e14a558f8ab-3d441933118mr27893335ab.5.1741336414339; Fri, 07 Mar 2025
 00:33:34 -0800 (PST)
Date: Fri, 07 Mar 2025 00:33:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67caaf5e.050a0220.15b4b9.007a.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in ethnl_default_dumpit
From: syzbot <syzbot+3da2442641f0c6a705a2@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2525e16a2bae Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=147cca64580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbc61e4c6e816b7b
dashboard link: https://syzkaller.appspot.com/bug?extid=3da2442641f0c6a705a2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bae047feb57e/disk-2525e16a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f10529c6bdd/vmlinux-2525e16a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8dcb6d0a6029/bzImage-2525e16a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3da2442641f0c6a705a2@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000197: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000cb8-0x0000000000000cbf]
CPU: 0 UID: 0 PID: 6809 Comm: syz.2.378 Not tainted 6.14.0-rc5-syzkaller-01064-g2525e16a2bae #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:netdev_need_ops_lock include/linux/netdevice.h:2792 [inline]
RIP: 0010:netdev_lock_ops include/linux/netdevice.h:2803 [inline]
RIP: 0010:ethnl_default_dump_one net/ethtool/netlink.c:557 [inline]
RIP: 0010:ethnl_default_dumpit+0x447/0xd40 net/ethtool/netlink.c:593
Code: 49 8b 1f 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 ca e6 17 f8 4c 8b 3b 49 8d 9f bd 0c 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 0f 85 4b 07 00 00 0f b6 1b 31 ff 89 de e8 f0
RSP: 0018:ffffc900036370d8 EFLAGS: 00010203
RAX: 0000000000000197 RBX: 0000000000000cbd RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8c80fdc0 RDI: 0000000000000001
RBP: ffff8880285b3780 R08: ffffffff903d0b77 R09: 1ffffffff207a16e
R10: dffffc0000000000 R11: fffffbfff207a16f R12: ffff888062f58600
R13: ffff888058d3b140 R14: dffffc0000000000 R15: 0000000000000000
FS:  00007fae91f066c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000400000001ac0 CR3: 0000000028682000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 genl_dumpit+0x10d/0x1b0 net/netlink/genetlink.c:1027
 netlink_dump+0x64d/0xe10 net/netlink/af_netlink.c:2309
 __netlink_dump_start+0x5a2/0x790 net/netlink/af_netlink.c:2424
 genl_family_rcv_msg_dumpit net/netlink/genetlink.c:1076 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
 genl_rcv_msg+0x894/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
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
RIP: 0033:0x7fae9118d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fae91f06038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fae913a5fa0 RCX: 00007fae9118d169
RDX: 0000000000000800 RSI: 0000400000001ac0 RDI: 0000000000000007
RBP: 00007fae9120e2a0 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fae913a5fa0 R15: 00007ffee7419f28
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:netdev_need_ops_lock include/linux/netdevice.h:2792 [inline]
RIP: 0010:netdev_lock_ops include/linux/netdevice.h:2803 [inline]
RIP: 0010:ethnl_default_dump_one net/ethtool/netlink.c:557 [inline]
RIP: 0010:ethnl_default_dumpit+0x447/0xd40 net/ethtool/netlink.c:593
Code: 49 8b 1f 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 ca e6 17 f8 4c 8b 3b 49 8d 9f bd 0c 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 0f 85 4b 07 00 00 0f b6 1b 31 ff 89 de e8 f0
RSP: 0018:ffffc900036370d8 EFLAGS: 00010203
RAX: 0000000000000197 RBX: 0000000000000cbd RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8c80fdc0 RDI: 0000000000000001
RBP: ffff8880285b3780 R08: ffffffff903d0b77 R09: 1ffffffff207a16e
R10: dffffc0000000000 R11: fffffbfff207a16f R12: ffff888062f58600
R13: ffff888058d3b140 R14: dffffc0000000000 R15: 0000000000000000
FS:  00007fae91f066c0(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000400000b64000 CR3: 0000000028682000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	49 8b 1f             	mov    (%r15),%rbx
   3:	48 89 d8             	mov    %rbx,%rax
   6:	48 c1 e8 03          	shr    $0x3,%rax
   a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
   f:	74 08                	je     0x19
  11:	48 89 df             	mov    %rbx,%rdi
  14:	e8 ca e6 17 f8       	call   0xf817e6e3
  19:	4c 8b 3b             	mov    (%rbx),%r15
  1c:	49 8d 9f bd 0c 00 00 	lea    0xcbd(%r15),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 4b 07 00 00    	jne    0x782
  37:	0f b6 1b             	movzbl (%rbx),%ebx
  3a:	31 ff                	xor    %edi,%edi
  3c:	89 de                	mov    %ebx,%esi
  3e:	e8                   	.byte 0xe8
  3f:	f0                   	lock


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


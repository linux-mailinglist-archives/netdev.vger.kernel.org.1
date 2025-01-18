Return-Path: <netdev+bounces-159575-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BE08A15E7C
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 19:29:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 312A7165F7F
	for <lists+netdev@lfdr.de>; Sat, 18 Jan 2025 18:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E7B1A2C27;
	Sat, 18 Jan 2025 18:29:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95ADA95C
	for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 18:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737224966; cv=none; b=S8G7rHa5dJz4x2mK7lxUkpSSmGmatz8Alnlo/XTJR0N77Wq5DzVrZdmVq1wsYieIJ/Jfc0fDcpGU6P2JJIzcJ9r5B79YrX0KbGl4LHAGnsIf8k0CM+N53X/f1BMOSRq5ib9a5zbTny+iu1JnuRu/v6ZyiaPz6clKIWG/aCNXFCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737224966; c=relaxed/simple;
	bh=icLG5B4PUiXbdzGYA/MNxhips8CnPLmgSsTeSMic3jc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XyP5xbSFnno2ZOHdsWbl7Je/gV+yNPOgh+r8haDo6EAfv6RA7/Uz9k3f4m2F3O+BbR3LZ8XK2HsBAiSAdIDsYqImFNsYo59VM2wdFtRYKPvTXEL9NdHAX5Aa3DWYP19uqiu+wD/dJNVfl4BUnZr2dp1hMiGLB3L20a8zWeOs3qw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ce8aa6723bso52511625ab.3
        for <netdev@vger.kernel.org>; Sat, 18 Jan 2025 10:29:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737224964; x=1737829764;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FeKLZX+9yfGUgUFinaHiwnqca2rgge7GvqnBUCnaYM0=;
        b=R6CGoT7+J0wKDLKfWaJJHsk7i2wD906+VR3rng+2/Y3fhR4yNmumfRx7aST3S27JDD
         cYaozdkGG+JMO/fQ6yChuAd6Dw2faOUivzL7y5bc98bCSEnKAJuKKS0E4UF4LwBVoRFv
         iSS33ToaIG7puj3mv5HLY/IciVO06J1C8BUA4Zn67HaEXyH7WRg9BpesT1KJRr6m3k/5
         VlHMqID09H0v4EONhviWFq2YK/y3hpXHG2Ozi2dZ8qFDC6TwhsEKd5Z8MhfH/RkaOWVH
         N+ApAm2R2PiwXh5ztrpGzpX+RMdlD27jm8/Pg1p1DpzlZKhq5fiSye8raje4WA9s89oE
         Q3jA==
X-Forwarded-Encrypted: i=1; AJvYcCV20JdCP1hqHzkks4R6/bJnH7AurOjDsWMgg4fw2sMumcR0wO9+D3PNFZc9Z+dNRb7FteZFX6Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzJGwl/6oA5/hatpglgullBhfzFCIj45bMHzsrlIK3Smcp2b+kg
	OYm7JnL6wcvNJK7f2refwWqIZr4bWLf2rP5vvXSCF+/R/33Ua68qox0zfWzW7nUDOQB1r/XIJh8
	IIIy7mdmKHxkgQS/A8UcQWOGWP62vKPithrtq5B80qyDpchfngNQbZLs=
X-Google-Smtp-Source: AGHT+IH3/Ro/4dsPi5I4ji8F/qTQ35hSlkMZf/G8K2bn9ZXo44vWPjwsJuxeOMnophFiEsuDjkKueOlxXs8T1evMsyDtwKbz18Mz
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:b4c:b0:3a7:e86a:e803 with SMTP id
 e9e14a558f8ab-3cf743f8834mr60158015ab.8.1737224964068; Sat, 18 Jan 2025
 10:29:24 -0800 (PST)
Date: Sat, 18 Jan 2025 10:29:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <678bf304.050a0220.303755.002d.GAE@google.com>
Subject: [syzbot] [net?] WARNING in __xfrm_state_destroy
From: syzbot <syzbot+ffa848883c52a4422348@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, herbert@gondor.apana.org.au, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, steffen.klassert@secunet.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c45323b7560e Merge tag 'mm-hotfixes-stable-2025-01-13-00-0..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14dc3cb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d1cb4a1f148c0861
dashboard link: https://syzkaller.appspot.com/bug?extid=ffa848883c52a4422348
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-c45323b7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d162460a6713/vmlinux-c45323b7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f905e34cb8b4/bzImage-c45323b7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ffa848883c52a4422348@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 2 PID: 8241 at net/xfrm/xfrm_state.c:727 __xfrm_state_destroy+0x178/0x1c0 net/xfrm/xfrm_state.c:727
Modules linked in:
CPU: 2 UID: 0 PID: 8241 Comm: syz.3.651 Not tainted 6.13.0-rc7-syzkaller-00019-gc45323b7560e #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:__xfrm_state_destroy+0x178/0x1c0 net/xfrm/xfrm_state.c:727
Code: 48 48 8b 35 4a 5f dc 03 48 c7 c2 e0 f8 09 90 bf 08 00 00 00 e8 39 0b 98 f7 5b 5d 41 5c 41 5d e9 fe fe ce f7 e8 f9 fe ce f7 90 <0f> 0b 90 e9 dc fe ff ff e8 3b ab 31 f8 e9 b3 fe ff ff 4c 89 e7 e8
RSP: 0018:ffffc9000752ef58 EFLAGS: 00010287
RAX: 00000000000005bd RBX: ffff888029cd8440 RCX: ffffc90007602000
RDX: 0000000000080000 RSI: ffffffff89cb25a7 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000005
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000001
R13: 0000000000000000 R14: ffff888029cd84f4 R15: ffff888029cd8440
FS:  00007fb8552256c0(0000) GS:ffff88806a800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000096 CR3: 000000004e246000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 xfrm_state_put include/net/xfrm.h:866 [inline]
 xfrm_state_put include/net/xfrm.h:863 [inline]
 xfrm_state_migrate+0x43e/0x1d70 net/xfrm/xfrm_state.c:2038
 xfrm_migrate+0x763/0x1820 net/xfrm/xfrm_policy.c:4658
 xfrm_do_migrate+0xc0c/0xf10 net/xfrm/xfrm_user.c:3022
 xfrm_user_rcv_msg+0x585/0xbf0 net/xfrm/xfrm_user.c:3373
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2542
 xfrm_netlink_rcv+0x71/0x90 net/xfrm/xfrm_user.c:3395
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2583
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2637
 __sys_sendmsg+0x16e/0x220 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb854385d29
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb855225038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fb854575fa0 RCX: 00007fb854385d29
RDX: 0000000020000000 RSI: 00000000200004c0 RDI: 0000000000000005
RBP: 00007fb854401b08 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb854575fa0 R15: 00007ffe34dcdec8
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


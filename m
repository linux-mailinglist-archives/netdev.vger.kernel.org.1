Return-Path: <netdev+bounces-152676-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7719F558C
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 19:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E8721897F92
	for <lists+netdev@lfdr.de>; Tue, 17 Dec 2024 18:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FF51F8909;
	Tue, 17 Dec 2024 17:58:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085E51F866E
	for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 17:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734458303; cv=none; b=hTlcXahzBHqfA9j+eeEzeupNBh17rtI1L7JTyz/hj8HmS5pYydn8X4zuRNIOgtLn6v/rgHS/2FFZ/lg3dKF3CZuCun5teDYMzOGLJ8hq/+QAiaYF6PI7uzXg7XxSSbJti0uKWPtBKgQ3YregsdVj8ERPbEUX5QDcf2DC9NbRdE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734458303; c=relaxed/simple;
	bh=IMFJGvdnCl7Cy437PRWNUPzrElbv/wa+d1pqZNQsiwU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bklS0Qkve1CYQT0gGgMlosdcB4UTD5+kZ+/CaKRN41PYIvBzIgGFPL7r1ypv7h4vp3SF9VvYsQGqg9IPpEuMQ2VhAo2c4omutgWdqBArtkzMQ79OhlUiTCHilG5xfjKljB205r/zELEe8XYhrPBjyVoBjQBMtlj6zPTwQ3JL19A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a78421a2e1so100388885ab.2
        for <netdev@vger.kernel.org>; Tue, 17 Dec 2024 09:58:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734458301; x=1735063101;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eMxmngXnHLH0uegUvli7RGsn//Gkb+ECuRY9sUiNxME=;
        b=Knrr56MGcAlNQ4MJyyWblPb3UiXAX3yL5qX9eZBGmBe88edUC1B4C4glnk1CNfBeva
         VdjdNySwwTAjdmfHJwlzengaXF6fBJEY4JFbRQ10C9HtWSpuPtbr0DAJZUalIzbllXEC
         uAxMVD9lLowBCqP9trlfFXaURjVo4IOeJeUJOcvZQ8t4SfCVLTNoBPCVf6YFKm3+7q/P
         XKi3yS/xmkcpn3i7ibUP+EMYjBic/l5pG345uos1cliejpzu5HUYDbwBIDbqakC3K1A9
         l0mWIo8J6KA8NWnn5LRSf6eWuiNtk4bAgdra2omdSW6g4OK9VKLP6ekNBZRNL8lwmKWy
         W+cw==
X-Forwarded-Encrypted: i=1; AJvYcCUZO1e9mEH6dmibTJgHwNMZp07e3zZ1bEoJg+DUDw45Eoy+CO3oKtzsR9HZAD6BVLJLHu2YRs8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaUwpub97MHrVTuHVgBTlhwMJT7gARKiHhNzj/Y/YYwRC4Yapn
	T198Z6cf+k9IMP33VAPdQhdHk4VVQdAH9oHCaJjgYkboID2fjGwZilWgDmkzGrELEZx0/t1jMml
	gPHW6RihseJcpINm85nyiN2+JVLvdmKse1iPS9R02C40FIrBGFY/sv4Q=
X-Google-Smtp-Source: AGHT+IFVTW30nwR9n2x0FBGndwuUDSKqTUlcUznYpCEY4DqyCsF9UDJA/xEOVytUf+PmMD9etY/tfRLXYCD7uphKhQyv76d/9Kmr
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1607:b0:3a7:66e0:a98a with SMTP id
 e9e14a558f8ab-3bd860f9cfcmr4317845ab.9.1734458301279; Tue, 17 Dec 2024
 09:58:21 -0800 (PST)
Date: Tue, 17 Dec 2024 09:58:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6761bbbd.050a0220.29fcd0.0074.GAE@google.com>
Subject: [syzbot] [net?] WARNING in __dev_queue_xmit (5)
From: syzbot <syzbot+0a884bc2d304ce4af70f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c2ee9f594da8 KVM: selftests: Fix build on on non-x86 archi..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16d2aa5f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1673a5aaa7e19b23
dashboard link: https://syzkaller.appspot.com/bug?extid=0a884bc2d304ce4af70f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12ee4c30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16443640580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/df7d94abc0db/disk-c2ee9f59.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/1945eac19921/vmlinux-c2ee9f59.xz
kernel image: https://storage.googleapis.com/syzbot-assets/19b610273055/bzImage-c2ee9f59.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0a884bc2d304ce4af70f@syzkaller.appspotmail.com

netdevsim netdevsim0 netdevsim1: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim2: set [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim0 netdevsim3: set [1, 0] type 2 family 0 port 6081 - 0
------------[ cut here ]------------
skb_assert_len
WARNING: CPU: 0 PID: 5230 at include/linux/skbuff.h:2679 skb_assert_len include/linux/skbuff.h:2679 [inline]
WARNING: CPU: 0 PID: 5230 at include/linux/skbuff.h:2679 __dev_queue_xmit+0x22cf/0x4350 net/core/dev.c:4345
Modules linked in:
CPU: 0 UID: 0 PID: 5230 Comm: syz-executor319 Not tainted 6.12.0-rc4-syzkaller-00047-gc2ee9f594da8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:skb_assert_len include/linux/skbuff.h:2679 [inline]
RIP: 0010:__dev_queue_xmit+0x22cf/0x4350 net/core/dev.c:4345
Code: 27 31 9c f8 40 84 ed 75 25 e8 3d 2f 9c f8 c6 05 a6 22 15 07 01 90 48 c7 c6 40 dc 7a 8c 48 c7 c7 60 ab 7a 8c e8 f2 ad 5d f8 90 <0f> 0b 90 90 e8 18 2f 9c f8 0f b6 2d 80 22 15 07 31 ff 89 ee e8 e8
RSP: 0018:ffffc900034df188 EFLAGS: 00010286
RAX: 0000000000000000 RBX: ffff88807fcdba00 RCX: ffffffff814e38b9
RDX: ffff88801cb09e00 RSI: ffffffff814e38c6 RDI: 0000000000000001
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88807fcdba10
R13: 0000000000000000 R14: 0000000000000000 R15: ffff888074776000
FS:  000055555dc25380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000180 CR3: 000000007444e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dev_queue_xmit include/linux/netdevice.h:3094 [inline]
 __netlink_deliver_tap_skb net/netlink/af_netlink.c:307 [inline]
 __netlink_deliver_tap net/netlink/af_netlink.c:325 [inline]
 netlink_deliver_tap+0xa8a/0xcf0 net/netlink/af_netlink.c:338
 __netlink_sendskb net/netlink/af_netlink.c:1275 [inline]
 netlink_sendskb net/netlink/af_netlink.c:1284 [inline]
 netlink_unicast+0x6b4/0x7f0 net/netlink/af_netlink.c:1372
 nlmsg_unicast include/net/netlink.h:1158 [inline]
 genlmsg_unicast include/net/genetlink.h:549 [inline]
 genlmsg_reply include/net/genetlink.h:559 [inline]
 netdev_nl_queue_get_doit+0x37f/0x6a0 net/core/netdev-genl.c:405
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x165/0x410 net/netlink/af_netlink.c:2551
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg net/socket.c:744 [inline]
 ____sys_sendmsg+0x9ae/0xb40 net/socket.c:2607
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2661
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2690
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f22f09cf9b9
Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 44 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc0ffdccf8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f22f0a1d482 RCX: 00007f22f09cf9b9
RDX: 0000000000000810 RSI: 0000000020001640 RDI: 0000000000000004
RBP: 00007f22f0a1d460 R08: 0000555500000000 R09: 0000555500000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f22f0a1d3e5
R13: 0000000000000001 R14: 00007ffc0ffdcd40 R15: 0000000000000003
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


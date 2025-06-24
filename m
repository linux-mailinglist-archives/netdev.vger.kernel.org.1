Return-Path: <netdev+bounces-200833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ECBAE70BC
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 22:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4836D16619C
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 20:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65282E9EB4;
	Tue, 24 Jun 2025 20:30:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 152142EBDC6
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 20:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750797031; cv=none; b=X3Rlajh7xpYTEtuZ9kBeL5Os06Ux/KaTZU00DxAsUtrVTZilB5RSjiZiMUDwHbIzFHw0sKRz5fRXQoSh0G0DOH1aBQSmWiYPKPKF3cD6v00I733sS7wp4mgBzyXB5Z+hJhT7CB5AwVIHL8WNeRZ92UPn3HQn1CmYpmZJOlc3ZUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750797031; c=relaxed/simple;
	bh=htQEQ/BzUbGDReOf5LAHoRmRPlTzuA///0KC3V4lOFc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aRmfWsJLOHzIR2Cn7b4UF533h9S0iKdqiAoe0XPUvOG52ogjugz4IkHDs3Tk36Z/hywO6kDs/+iORW0uLTGzJw9DCSu3Jf6vAMsSGx4yidyA8TK5kubL5+MrBEe7vs1WASXzX/UdH1LvBVVWad4dsixmnFiYLAUtMfpv3CZsDCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3df33827a8cso399425ab.1
        for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 13:30:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750797029; x=1751401829;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6knl0xaS3L51AM1ZsG9RmXp7O5QA7TblObdipk/GWaI=;
        b=jYlLP77r2LRcpgti1ZnZ6l7vypy+Le7tsdD/1k6NKta1uUVBFm7/h+dZN0hpyB3A60
         dE8QKMXuNvFD2O6olay+UVEB+ZT8T6L5cMuQvv1mXfCE8GSnc3ce3MnHsaYBZvqo47YF
         WVYRREgxlsbhlRAXd/6jYqnd1QOMbkt45D5+rMQrfDnyXcY27K5x6/G6dZOuZKvnf0Yj
         D+gkPE8OBxefCZsQDFlMDR4z6e5DKDFdnL4la0YLqXwEx2T7ySFH+24cq09zCkgPPmEV
         2DaKL9FwwqIWG3qX8C86yolY9JKJUTSJs9UZ9jRX2NIYwiXJPZ/dgnJtqX1l/84G72fr
         EGhQ==
X-Forwarded-Encrypted: i=1; AJvYcCVTLq1jNHvCaOWBl+zv8RHmXnoa2xx/sX1nSoacowv/U6YC4TwsVg63Lmsw6kr39/b50W+kZfE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsQU3pGxnqUilKZeC4PgXaQNY+gq5K0JJQJSD+gt5naAAwFu8r
	oRX1+hM0TUnOPXTznVzikKRtHSKB7vDPOAq0Vvhp0OVIR95rxK+p9LszlZML475Pi5Px7NCrbkD
	sb7B0TmdslErUNJgvoSG+n89QGVIysMsbyYqDtRCg2LsA8PzIb1+OiYBrq6g=
X-Google-Smtp-Source: AGHT+IH5de4d25y6CNlVfsK+tP43zSWrtYw23gCA5QZDONUigQy1STLCYjJtal9wLts9ebxBnXhWSL8kr7WxPmyE5pg4p7yHjyyC
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156c:b0:3dc:87c7:a5b9 with SMTP id
 e9e14a558f8ab-3df329a5a46mr4971615ab.10.1750797029291; Tue, 24 Jun 2025
 13:30:29 -0700 (PDT)
Date: Tue, 24 Jun 2025 13:30:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <685b0ae5.a00a0220.2e5631.009a.GAE@google.com>
Subject: [syzbot] [wpan?] WARNING in lowpan_xmit (2)
From: syzbot <syzbot+5b74e0e96f12e3728ec8@syzkaller.appspotmail.com>
To: alex.aring@gmail.com, davem@davemloft.net, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wpan@vger.kernel.org, miquel.raynal@bootlin.com, netdev@vger.kernel.org, 
	pabeni@redhat.com, stefan@datenfreihafen.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4f4040ea5d3e net: ti: icssg-prueth: Add prp offload suppor..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11630dd4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fab0bcec5be1995b
dashboard link: https://syzkaller.appspot.com/bug?extid=5b74e0e96f12e3728ec8
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170cd370580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/64e76754e788/disk-4f4040ea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/58f25c6cca53/vmlinux-4f4040ea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/f700f89884c1/bzImage-4f4040ea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b74e0e96f12e3728ec8@syzkaller.appspotmail.com

ieee802154 phy0 wpan0: encryption failed: -22
ieee802154 phy1 wpan1: encryption failed: -22
------------[ cut here ]------------
WARNING: CPU: 1 PID: 1302 at ./include/linux/skbuff.h:3157 skb_network_header_len include/linux/skbuff.h:3157 [inline]
WARNING: CPU: 1 PID: 1302 at ./include/linux/skbuff.h:3157 lowpan_header net/ieee802154/6lowpan/tx.c:236 [inline]
WARNING: CPU: 1 PID: 1302 at ./include/linux/skbuff.h:3157 lowpan_xmit+0xde9/0x1340 net/ieee802154/6lowpan/tx.c:282
Modules linked in:
CPU: 1 UID: 0 PID: 1302 Comm: aoe_tx0 Not tainted 6.16.0-rc2-syzkaller-00591-g4f4040ea5d3e #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:skb_network_header_len include/linux/skbuff.h:3157 [inline]
RIP: 0010:lowpan_header net/ieee802154/6lowpan/tx.c:236 [inline]
RIP: 0010:lowpan_xmit+0xde9/0x1340 net/ieee802154/6lowpan/tx.c:282
Code: 48 85 c0 0f 84 38 02 00 00 49 89 c6 e8 00 77 a0 f6 e9 69 f5 ff ff e8 f6 76 a0 f6 90 0f 0b 90 e9 5c f6 ff ff e8 e8 76 a0 f6 90 <0f> 0b 90 e9 2c f7 ff ff e8 da 76 a0 f6 e9 12 fc ff ff 90 0f 0b 90
RSP: 0018:ffffc9000437f640 EFLAGS: 00010293
RAX: ffffffff8b1fe568 RBX: ffff8880312e6140 RCX: ffff888027989e00
RDX: 0000000000000000 RSI: 000000000000ffff RDI: 000000000000ffff
RBP: ffffc9000437f830 R08: 0000000000000003 R09: 0000000000000000
R10: ffffc9000437f4f0 R11: fffff5200086fea4 R12: 1ffff1100625cc36
R13: 0000000000000020 R14: ffff8880312e6140 R15: 000000000000ffff
FS:  0000000000000000(0000) GS:ffff888125d4f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe947dbbf98 CR3: 000000007a4dc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __netdev_start_xmit include/linux/netdevice.h:5225 [inline]
 netdev_start_xmit include/linux/netdevice.h:5234 [inline]
 xmit_one net/core/dev.c:3828 [inline]
 dev_hard_start_xmit+0x2d4/0x830 net/core/dev.c:3844
 __dev_queue_xmit+0x1adf/0x3a70 net/core/dev.c:4711
 dev_queue_xmit include/linux/netdevice.h:3365 [inline]
 tx+0x6b/0x190 drivers/block/aoe/aoenet.c:62
 kthread+0x1d0/0x3e0 drivers/block/aoe/aoecmd.c:1237
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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


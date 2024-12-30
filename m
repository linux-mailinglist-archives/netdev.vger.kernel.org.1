Return-Path: <netdev+bounces-154548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC459FE8DD
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 17:04:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63009161745
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 16:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 756E91AB6E2;
	Mon, 30 Dec 2024 16:04:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80131A4E98
	for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 16:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735574664; cv=none; b=mrPnowXfTQBvCgwP83z/s3DX4byfdoZoSbJUC4RWkNX5qZT1D18FN59An+oA9BggejRHjluRTLRdao+u581AwbPVHanhU+7z++zZKNMnlpYd5R2ybmrPnQBhAJhWI58bYQeGLuUMkkRlBGDvBhlD2+O5Fs/YGUnnzyQnRQUqeW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735574664; c=relaxed/simple;
	bh=YDDEY9B06kchVvoBzFd6efkgmaPSvdLvivzeaV/5JaU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=n/RwDqWLeLgchI5CBnzH0XmM16vtKTplLOww20SoRv83oo/7hE+hz17lNvmthZvC2Nfi+nu+qAfE00oQiGnzcTIu3BufPp9WAgo0SQr0T/6316D4vu4shThRYqTbORwovwuYNu37El/TkR+s6efBC++fPs0X/N8mnGzYxHIKDZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3a7e39b48a2so195063675ab.0
        for <netdev@vger.kernel.org>; Mon, 30 Dec 2024 08:04:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735574662; x=1736179462;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e4fsEga2/AkRAk+dZiGMoXfZ/rg3UqASi/ikezv0teY=;
        b=sRWDJ3w/tU9M6RUB/+fb30ZKMzfgeKZTAwAHgfFNZI/MLxyuYGUqepVNsk0IXvbY8N
         iARkLqolBJbTl07k5stVhcZNKBumZW+EN40P0llZf83RypcjQlbtb5hnLeCKPndCUNXe
         MhgZSjNdpWu7gJPAMhQEg90hwUm4WUiFGeMk6lL3vWRbzenRQQ1SEoR9Hr5CaD0m3LdG
         Crz90ziYpuwTmxPn3Znajn/07LfTiKlMz7xGSJKbM04E/LeD0dQGHYjj0f/nGNqZFv45
         7Xe0WevFBHma95BYveuo58cBnMrs4iKATx121rUDSCrU2fkp6OuLu0h+iTjO9qkoRzTH
         REAw==
X-Forwarded-Encrypted: i=1; AJvYcCVZoDQcygVmjQ0DFQA1o9GUoR26iCT04Xb16FbvQk9x8e17qUZhJydDsOZpJ+VLdlrhvZdiQTM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyd5fTxp3mOioOxBsLLCd5JL9n7RnlGTKGt/lcoHBrO/UkvDJ/u
	U74niZLnd0DGAYeh9lfQUuh/ULun0oNL/kPYkaizEs2K8712WHCLW1JD8P82trQtzb/9Kp9/k0L
	mt7ZG/nx09ayCMtQUAIk84oQg6GUXTaf0F3Uv5n8kYqB5NWhWbUY4W8c=
X-Google-Smtp-Source: AGHT+IE1DHOxbZ7HCYOaCX5fNYEM6h+LbHbQdDdn2OlMQPMaTopXsoxzPr1YlYmvd7IUWDqbLdd85lLmVHAHFWIQMAKVSXCd4dPQ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:8748:0:b0:3cc:b7e4:6264 with SMTP id
 e9e14a558f8ab-3ccb7e464b3mr31808025ab.0.1735574661934; Mon, 30 Dec 2024
 08:04:21 -0800 (PST)
Date: Mon, 30 Dec 2024 08:04:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6772c485.050a0220.2f3838.04c6.GAE@google.com>
Subject: [syzbot] [net?] kernel BUG in vlan_get_tci
From: syzbot <syzbot+8400677f3fd43f37d3bc@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9268abe611b0 Merge branch 'net-lan969x-add-rgmii-support'
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15adaac4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b087c24b921cdc16
dashboard link: https://syzkaller.appspot.com/bug?extid=8400677f3fd43f37d3bc
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12e1a6df980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13adaac4580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8274f60b0163/disk-9268abe6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f7b3fde537e7/vmlinux-9268abe6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/db4cccf7caae/bzImage-9268abe6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8400677f3fd43f37d3bc@syzkaller.appspotmail.com

skbuff: skb_under_panic: text:ffffffff8a8da482 len:4 put:14 head:ffff88804ff34f00 data:ffff88804ff34f10 tail:0x14 end:0x140 dev:<NULL>
------------[ cut here ]------------
kernel BUG at net/core/skbuff.c:206!
Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 UID: 0 PID: 5839 Comm: syz-executor403 Not tainted 6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:skb_panic net/core/skbuff.c:206 [inline]
RIP: 0010:skb_under_panic+0x14b/0x150 net/core/skbuff.c:216
Code: 0b 8d 48 c7 c6 9e 6c 26 8e 48 8b 54 24 08 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 41 54 41 57 41 56 e8 3a 5a 79 f7 48 83 c4 20 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc900039275b8 EFLAGS: 00010286
RAX: 0000000000000086 RBX: dffffc0000000000 RCX: 562c0de467bbe000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff8880283eca10 R08: ffffffff817f0a4c R09: 1ffff92000724e50
R10: dffffc0000000000 R11: fffff52000724e51 R12: 0000000000000140
R13: ffff88804ff34f00 R14: ffff88804ff34f10 R15: 0000000000000014
FS:  00007f67013ab6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f670138ad58 CR3: 0000000011ed0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 skb_push+0xe5/0x100 net/core/skbuff.c:2636
 vlan_get_tci+0x272/0x550 net/packet/af_packet.c:565
 packet_recvmsg+0x13c9/0x1ef0 net/packet/af_packet.c:3616
 sock_recvmsg_nosec net/socket.c:1044 [inline]
 sock_recvmsg+0x22f/0x280 net/socket.c:1066
 ____sys_recvmsg+0x1c6/0x480 net/socket.c:2814
 ___sys_recvmsg net/socket.c:2856 [inline]
 do_recvmmsg+0x426/0xab0 net/socket.c:2951
 __sys_recvmmsg net/socket.c:3025 [inline]
 __do_sys_recvmmsg net/socket.c:3048 [inline]
 __se_sys_recvmmsg net/socket.c:3041 [inline]
 __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3041
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f67013f05a9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f67013ab238 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007f670147a348 RCX: 00007f67013f05a9
RDX: 0000000000000001 RSI: 0000000020000480 RDI: 0000000000000003
RBP: 00007f670147a340 R08: 0000000000000000 R09: 00007f67013ab6c0
R10: 0000000000010022 R11: 0000000000000246 R12: 00007f6701447074
R13: 0000000000000000 R14: 00007ffea4c13700 R15: 00007ffea4c137e8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_panic net/core/skbuff.c:206 [inline]
RIP: 0010:skb_under_panic+0x14b/0x150 net/core/skbuff.c:216
Code: 0b 8d 48 c7 c6 9e 6c 26 8e 48 8b 54 24 08 8b 0c 24 44 8b 44 24 04 4d 89 e9 50 41 54 41 57 41 56 e8 3a 5a 79 f7 48 83 c4 20 90 <0f> 0b 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
RSP: 0018:ffffc900039275b8 EFLAGS: 00010286
RAX: 0000000000000086 RBX: dffffc0000000000 RCX: 562c0de467bbe000
RDX: 0000000000000000 RSI: 0000000080000000 RDI: 0000000000000000
RBP: ffff8880283eca10 R08: ffffffff817f0a4c R09: 1ffff92000724e50
R10: dffffc0000000000 R11: fffff52000724e51 R12: 0000000000000140
R13: ffff88804ff34f00 R14: ffff88804ff34f10 R15: 0000000000000014
FS:  00007f67013ab6c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f670138ad58 CR3: 0000000011ed0000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400


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


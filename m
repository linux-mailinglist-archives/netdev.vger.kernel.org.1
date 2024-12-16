Return-Path: <netdev+bounces-152314-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B41E9F3683
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:48:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CA8077A4E16
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 797952063F6;
	Mon, 16 Dec 2024 16:42:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9323B2063E7
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 16:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734367347; cv=none; b=GtLiCuLM9a+B3Vashos1azcb//kEga6vnyoYiE4W+DoKVUxCpdtUj9/f/1+JCaZzA6lt/6CCyOPnJKw8tmGLvw05MXZwUcniWCZGulTXnP+qeSIxnjW99Zjtga+/OWIIwtl4rFEFJrpnAORkO62K3HY2fIg+Ct84aHtnDWp+SYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734367347; c=relaxed/simple;
	bh=+2A5q8NooEqm05JzMq3tUoF04pXhbxQmr813UKPX0G4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=QHjpy/r6tCr7ltFq/crf+wl8snXQ4BI9v30uJuJFtnyw9+BlMxHqyrXQpPQVBTkhdT2EYbsnIA7aH/aWbDsqYbTS2Z0EmSOGhup8mlqAVyk5n/ctYTtIOwKR8mnzGDfEbAszZVChzTLf43C20aMPYy0puLdJArj/PZKReiD5YtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3a812f562bbso87779955ab.1
        for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 08:42:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734367344; x=1734972144;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xQWogq1JLSCeTRuMywH+apCWqE09emlrsEIy9hrKPMQ=;
        b=hiSzjA8zhWByDVqF1MBolG4TqmQk0G4Lqg8vORkGRf/Q2Mm8bCGheuQtKnJ+yujPrP
         kHm32EXV9Su4KGO/a5/gdo72LLr4FCv/UBgXwB6uUogAvz17FQrH5sE0PpZOLw75rq9y
         pTPt5BIUn3BNtuEbVhigPAL2YaV81/iIZ1djKzFgqpaz7HV5SoxHb9wWNyQLD4ApLpk/
         S5OUWTyTAqo4QT5GCAtvyJ/BrPDbsWIeZ5pYsGnU2ZUTDeRr1Uec4wRs9btKwxVvh/B1
         wDbmVWnnzTyBELgcHvPyIh+ntddPEN55HQIL9sb//uZL6pHUpohlGsjg04brHfehjJPu
         RJLw==
X-Forwarded-Encrypted: i=1; AJvYcCXwJ94FkpP5+RHtHs1gLneq+5lXx1quY1ZV6O49YSMdxPE8sUT04TY7d1QRXXsErooolj2bH6E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmj8N2DSjd3RThHyfzXFe5JA3R3+6LBNyrBLx3PSsDYnLV89aq
	AZRh+6k2tPIa9vokomOKMCXuocdxQM4MlILjbfyj0npslQbYG88DAfYHvd1RBYjVms02ULbhnlJ
	dSRLJIJwQiMb8R36HnSl/PHg2pjFx9hdP9COWUhlr1OdEqsZ+akVfYiY=
X-Google-Smtp-Source: AGHT+IFvubeG006//sC4Q12Uq2eaVtr0/8+9odVPr3h15PHP6y8s2Yy1O5KqFXGIVHN5toRZdy7ELj+A/+Wg2RMBT2m3Bn6Tqee5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:156e:b0:3a7:9860:d7e5 with SMTP id
 e9e14a558f8ab-3aff8aa31c7mr134936625ab.23.1734367344278; Mon, 16 Dec 2024
 08:42:24 -0800 (PST)
Date: Mon, 16 Dec 2024 08:42:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67605870.050a0220.37aaf.0137.GAE@google.com>
Subject: [syzbot] [mptcp?] WARNING in __mptcp_clean_una (2)
From: syzbot <syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, geliang.tang@linux.dev, 
	geliang@kernel.org, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, martineau@kernel.org, matttbe@kernel.org, 
	mptcp@lists.linux.dev, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    00a5acdbf398 bpf: Fix configuration-dependent BTF function..
git tree:       bpf-next
console output: https://syzkaller.appspot.com/x/log.txt?x=148de730580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fee25f93665c89ac
dashboard link: https://syzkaller.appspot.com/bug?extid=ebc0b8ae5d3590b2c074
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16d82344580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179654f8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/fc306c95490c/disk-00a5acdb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e17d5125ee77/vmlinux-00a5acdb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/65f791a7fd14/bzImage-00a5acdb.xz

The issue was bisected to:

commit 3f83d8a77eeeb47011b990fd766a421ee64f1d73
Author: Paolo Abeni <pabeni@redhat.com>
Date:   Thu Feb 8 18:03:51 2024 +0000

    mptcp: fix more tx path fields initialization

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12d2c7e8580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=11d2c7e8580000
console output: https://syzkaller.appspot.com/x/log.txt?x=16d2c7e8580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ebc0b8ae5d3590b2c074@syzkaller.appspotmail.com
Fixes: 3f83d8a77eee ("mptcp: fix more tx path fields initialization")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 9846 at net/mptcp/protocol.c:1024 __mptcp_clean_una+0xddb/0xff0 net/mptcp/protocol.c:1024
Modules linked in:
CPU: 0 UID: 0 PID: 9846 Comm: syz-executor351 Not tainted 6.13.0-rc2-syzkaller-00059-g00a5acdbf398 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/25/2024
RIP: 0010:__mptcp_clean_una+0xddb/0xff0 net/mptcp/protocol.c:1024
Code: fa ff ff 48 8b 4c 24 18 80 e1 07 fe c1 38 c1 0f 8c 8e fa ff ff 48 8b 7c 24 18 e8 e0 db 54 f6 e9 7f fa ff ff e8 e6 80 ee f5 90 <0f> 0b 90 4c 8b 6c 24 40 4d 89 f4 e9 04 f5 ff ff 44 89 f1 80 e1 07
RSP: 0018:ffffc9000c0cf400 EFLAGS: 00010293
RAX: ffffffff8bb0dd5a RBX: ffff888033f5d230 RCX: ffff888059ce8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc9000c0cf518 R08: ffffffff8bb0d1dd R09: 1ffff110170c8928
R10: dffffc0000000000 R11: ffffed10170c8929 R12: 0000000000000000
R13: ffff888033f5d220 R14: dffffc0000000000 R15: ffff8880592b8000
FS:  00007f6e866496c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f6e86f491a0 CR3: 00000000310e6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __mptcp_clean_una_wakeup+0x7f/0x2d0 net/mptcp/protocol.c:1074
 mptcp_release_cb+0x7cb/0xb30 net/mptcp/protocol.c:3493
 release_sock+0x1aa/0x1f0 net/core/sock.c:3640
 inet_wait_for_connect net/ipv4/af_inet.c:609 [inline]
 __inet_stream_connect+0x8bd/0xf30 net/ipv4/af_inet.c:703
 mptcp_sendmsg_fastopen+0x2a2/0x530 net/mptcp/protocol.c:1755
 mptcp_sendmsg+0x1884/0x1b10 net/mptcp/protocol.c:1830
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg+0x1a6/0x270 net/socket.c:726
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
 ___sys_sendmsg net/socket.c:2637 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6e86ebfe69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 b1 1f 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6e86649168 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f6e86f491b8 RCX: 00007f6e86ebfe69
RDX: 0000000030004001 RSI: 0000000020000080 RDI: 0000000000000003
RBP: 00007f6e86f491b0 R08: 00007f6e866496c0 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6e86f491bc
R13: 000000000000006e R14: 00007ffe445d9420 R15: 00007ffe445d9508
 </TASK>


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


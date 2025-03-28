Return-Path: <netdev+bounces-178135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EAC21A74DA0
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 16:21:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E4FE176D3E
	for <lists+netdev@lfdr.de>; Fri, 28 Mar 2025 15:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 910F61CD1E0;
	Fri, 28 Mar 2025 15:21:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D7DDDC5
	for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 15:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743175287; cv=none; b=FRBknpgY5dfxYL1v2bIG6Dzm2z1btaaaIvSyL9W42mJSCIoVmXbIvSB0MuCDpn1Qx8QToCZIZA544J+heXfu2Gj2mykpVb3YKFUUhevkooTVUc0xujdBPl1Zlp+dhApwyzInbvAV0a/dz8TXQuHibBKWbj7HfCS1hzDMiftv9t0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743175287; c=relaxed/simple;
	bh=/DJcgoepLrhBqIykp56qvvhQGBS88i2BdgFsikmpXQI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HuRHIrQS8jFJxJS7933bmp0RJPkDyWClsoDM8hoM0xdHlprtZANIPSCET/ZG3Gp3nl2TfcR1aLbpQ7aoCOzHUiHrhVK+IH8KOth+rC8OwZJSwAHFQGmwdMscC7Cw/ZJtz4A9z9Pnz/x2JhwjhpKlufogbMoc40OkowZ+vp6bCQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3d585d76b79so19918335ab.1
        for <netdev@vger.kernel.org>; Fri, 28 Mar 2025 08:21:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743175285; x=1743780085;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/rEQe0yVISN2xBFeCkIqt/cInxyTeq/ldI8FyDfMB8w=;
        b=gqXdMLpT9ePMTrBRIsBpVBXcw8qriA0E8II7QlvCZaCCGk4shy5nhplZcR9RkFoxnP
         pKp+IfCrX3hLZ2rTQ6awNjMImpipinBnXt4avO9VWLG2o6cP8k6Uf1FjgK6OwpEOE/9t
         efZC7ZAM3+qwBDrud5pviER/uLTgKl8Qjb4RqCM0Q8RseNYD2cTXN6J9LyTDO6N9jIH6
         02F8Vw4rfySxYAmcAt5I1uQ1nI8q+Y7YoC4m5Rh1GoE6rOgEup9LnpwyPeLY57NDPsqA
         /Vf0HZ4NBy9D5XQOyMGOztvtTuYcC9ES/1Kj/UD2BB4dza+1WQvgIh32lrZ0fJu6f4X+
         9uJg==
X-Forwarded-Encrypted: i=1; AJvYcCWvFaM4e2kjJikgsFwob/c2YA6D+v8U6/6XF+v2eub65Yc8u8ttdXmahePBOIzYAnOO/5mK5lM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3oRaEUQodxO6S6UgGxGDlOqT7vPkv2NDaToRcS2qfwbGaG3FE
	t1mA1KwMSI/EKHVZ5aD0IvI1XNlidrpvcly+3XLvauOK214SUsX5bwzLmJxYJtypeAUtbDxv3o+
	917CYA2ZJr1+PjfjKIHv9e5/d4MSsky9Rjg4KrDWK1ysbj0lA1N0GhZc=
X-Google-Smtp-Source: AGHT+IGtTduv27dw2iXD86Lo3CIKLQBYjSpbC4tosT+BE9iiUMBTYFGsYRLmktEgwtwuySlKclT5Fltw5WkQatTg95WaokB1DVA0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1689:b0:3d4:28c0:1692 with SMTP id
 e9e14a558f8ab-3d5ccdc1e0bmr89764765ab.5.1743175284806; Fri, 28 Mar 2025
 08:21:24 -0700 (PDT)
Date: Fri, 28 Mar 2025 08:21:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67e6be74.050a0220.2f068f.007e.GAE@google.com>
Subject: [syzbot] [net?] WARNING in tls_strp_msg_load
From: syzbot <syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com>
To: borisp@nvidia.com, davem@davemloft.net, dhowells@redhat.com, 
	dsahern@kernel.org, edumazet@google.com, horms@kernel.org, 
	john.fastabend@gmail.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ccc2f5a436fb net: dsa: mt7530: Fix traffic flooding for MM..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17494a64580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5b4c41bdaeea1964
dashboard link: https://syzkaller.appspot.com/bug?extid=b4cd76826045a1eb93c1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=141203a8580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131e24b7980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3aefdb8b7ff7/disk-ccc2f5a4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/96e0fd0ea0ad/vmlinux-ccc2f5a4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7c4310217a6/bzImage-ccc2f5a4.xz

The issue was bisected to:

commit c5c37af6ecad955acad82a440b812eb9cd73f77f
Author: David Howells <dhowells@redhat.com>
Date:   Mon May 22 12:11:14 2023 +0000

    tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=15cf8878580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=17cf8878580000
console output: https://syzkaller.appspot.com/x/log.txt?x=13cf8878580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4cd76826045a1eb93c1@syzkaller.appspotmail.com
Fixes: c5c37af6ecad ("tcp: Convert do_tcp_sendpages() to use MSG_SPLICE_PAGES")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5834 at net/tls/tls_strp.c:486 tls_strp_msg_load+0x72e/0xa80 net/tls/tls_strp.c:486
Modules linked in:
CPU: 0 UID: 0 PID: 5834 Comm: syz-executor412 Not tainted 6.14.0-rc4-syzkaller-00210-gccc2f5a436fb #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:tls_strp_msg_load+0x72e/0xa80 net/tls/tls_strp.c:486
Code: 5c 24 18 e9 72 fc ff ff e8 cf b8 31 f7 90 0f 0b 90 e9 91 f9 ff ff e8 c1 b8 31 f7 90 0f 0b 90 e9 be f9 ff ff e8 b3 b8 31 f7 90 <0f> 0b 90 eb 84 e8 a8 b8 31 f7 90 0f 0b 90 e9 8c fe ff ff 89 d9 80
RSP: 0018:ffffc90003e7f700 EFLAGS: 00010293
RAX: ffffffff8a90068d RBX: ffff88802a9f24dc RCX: ffff888034e0bc00
RDX: 0000000000000000 RSI: 000000000000001f RDI: 0000000000000000
RBP: ffffc90003e7f7f0 R08: ffffffff8a9002fe R09: 1ffff110062bf36c
R10: dffffc0000000000 R11: ffffed10062bf36d R12: ffff88802a9f24d0
R13: dffffc0000000000 R14: 0000000000000000 R15: 000000000000001f
FS:  0000555585cc3480(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000400000000218 CR3: 00000000347a8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tls_rx_rec_wait+0x280/0xa60 net/tls/tls_sw.c:1363
 tls_sw_recvmsg+0x85c/0x1c30 net/tls/tls_sw.c:2043
 inet6_recvmsg+0x2c9/0x730 net/ipv6/af_inet6.c:678
 sock_recvmsg_nosec net/socket.c:1023 [inline]
 sock_recvmsg+0x109/0x280 net/socket.c:1045
 __sys_recvfrom+0x202/0x380 net/socket.c:2237
 __do_sys_recvfrom net/socket.c:2252 [inline]
 __se_sys_recvfrom net/socket.c:2248 [inline]
 __x64_sys_recvfrom+0xde/0x100 net/socket.c:2248
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f382a3c83a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe3fe269d8 EFLAGS: 00000246 ORIG_RAX: 000000000000002d
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f382a3c83a9
RDX: 0000000000001ff4 RSI: 0000400000000100 RDI: 0000000000000003
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000040 R11: 0000000000000246 R12: 0000000000000000
R13: 00007ffe3fe26c58 R14: 0000000000000001 R15: 0000000000000001
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


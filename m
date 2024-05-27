Return-Path: <netdev+bounces-98173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ABEBD8CFE79
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 12:59:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 24403B22F02
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 10:59:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AF5813B7A9;
	Mon, 27 May 2024 10:59:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0DE126AFA
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 10:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716807568; cv=none; b=Z0zJFWMJ0QqYQ871uYLyPumFnuDevrA+FSv+bcJXhiV71wquT++PZknqsSOtzlQKXkxb29EYtWuQQ3ovclHlXRR+g4JGWirPJGkAPUdfK387vpA4N2lO90GaeLlwRGngeOxj9Ef87CcGub6lji2eMw0B8keFc0Hc7/D1fPV1VjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716807568; c=relaxed/simple;
	bh=94YhgNzljuvU7uRcV7vtpb7xMFTqrqVEIqZc1oHhq5k=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=bIDZZY/It70YNROU7C0SEKT0CzEdXc/KUwciOFJ9ZBjaBIXQVPV+1+dmH220tSpKC1aWM33WgtFlLNALvoiQY0Tvzb5E63bxM3Xw3HkT8nnNkWf26YqA0lImbryrNwQJn7PnrOOMZjGJQHZP5UXs23en5dnqcM96MVWGYwJz1yY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e8e2ea7b4bso428558039f.0
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 03:59:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716807566; x=1717412366;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QlarJWCrMY/qWkUS+Linikag5znfwaOPRNlhqnwBFnM=;
        b=TcLQ54XgzJJv9lcOK/hFf2GhY2E929cxuGiOPp3qT5vxgT3Rn8msfWO3aSdJmt4TAj
         LIDTWtHtOXm5pNR3FRzhJTEtRCE7ePcgCKxB04k23Roj4lvY36Uu8mnP3S7YUhDloaYu
         448HOFAQJnyy3qVEj2OQhc5ZpzCEmCZ8c4PrOR8Qx9FWKHGfASDFF8P+hwcs92PCjPXn
         tVqRnrarPy7XjYiZavdmyFCcAFcmRdZkX3hYmG5JDgT+PCqbxvfwGbHH35AOCSdDtUew
         heiL2qHt9KwyMXj2ay2fduEzf2BYI0tEQ14vPn1IILvATH9v3g15hg/rgdtbgYAtGJ5Q
         kguQ==
X-Forwarded-Encrypted: i=1; AJvYcCXdoFBy5Zl81UC7BRvfMCu+sVkTCKDzdeA+WKHl8KozQ0qeTqItMQHdiEwD7bBi0kkuttyfm7O2zKZGWDEyivJN2uxCMGBL
X-Gm-Message-State: AOJu0Yz5AbcGGtelNp3csctnrjcw9jccPHvu4YuQ70fzjod0TN5hmhbX
	2GyeSbQLmCDQL+n5eBDNyiI4rHlH+QSINYoNOPrxjxSYqHP6AzWH/IvY81wCAiFbdYliOI9FQ8t
	OkkpQeiWiq2Q+hKMi5FZurOKcLUm0HeFmip9vah69USv4JDzIOuYm7qc=
X-Google-Smtp-Source: AGHT+IG/QPXR4IHrIJSsY3j5x3NB2UWwan6p1oCg29ULQe8EmqX4ej73KmFSMr8Cwbz+35hp1kPPkB7xZPmkVIr9S+0YeWylvL6d
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:832a:b0:4b0:a7f3:fc21 with SMTP id
 8926c6da1cb9f-4b0a7f3fe55mr241332173.3.1716807566156; Mon, 27 May 2024
 03:59:26 -0700 (PDT)
Date: Mon, 27 May 2024 03:59:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000020f77306196d696c@google.com>
Subject: [syzbot] [net?] WARNING in __ip6_make_skb (2)
From: syzbot <syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, quic_abchauha@quicinc.com, 
	syzkaller-bugs@googlegroups.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c1713a8f1c9 bpf: constify member bpf_sysctl_kern:: Table
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1056ba0c980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=d7b227731ec589e7f4f0
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1050742c980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14fd6b1a980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2cad2c60a177/disk-2c1713a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c8a5f440db5/vmlinux-2c1713a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/53bcec8870e5/bzImage-2c1713a8.xz

The issue was bisected to:

commit 1693c5db6ab8262e6f5263f9d211855959aa5acd
Author: Abhishek Chauhan <quic_abchauha@quicinc.com>
Date:   Thu May 9 21:18:33 2024 +0000

    net: Add additional bit to support clockid_t timestamp type

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=14eeacb2980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=16eeacb2980000
console output: https://syzkaller.appspot.com/x/log.txt?x=12eeacb2980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d7b227731ec589e7f4f0@syzkaller.appspotmail.com
Fixes: 1693c5db6ab8 ("net: Add additional bit to support clockid_t timestamp type")

------------[ cut here ]------------
WARNING: CPU: 1 PID: 5089 at include/linux/skbuff.h:4226 skb_set_delivery_type_by_clockid include/linux/skbuff.h:4226 [inline]
WARNING: CPU: 1 PID: 5089 at include/linux/skbuff.h:4226 __ip6_make_skb+0x14f8/0x2470 net/ipv6/ip6_output.c:1930
Modules linked in:
CPU: 1 PID: 5089 Comm: syz-executor227 Not tainted 6.9.0-syzkaller-08561-g2c1713a8f1c9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:skb_set_delivery_type_by_clockid include/linux/skbuff.h:4226 [inline]
RIP: 0010:__ip6_make_skb+0x14f8/0x2470 net/ipv6/ip6_output.c:1930
Code: c0 0f 85 94 0a 00 00 41 8b 5d 00 4d 85 f6 74 0d e8 dd 50 6e f7 83 e3 fc 44 09 e3 eb 79 e8 d0 50 6e f7 eb 6f e8 c9 50 6e f7 90 <0f> 0b 90 48 8b 5c 24 08 48 8d 7b 20 48 89 f8 48 c1 e8 03 42 80 3c
RSP: 0018:ffffc9000345f400 EFLAGS: 00010293
RAX: ffffffff8a27e107 RBX: 00000000000000ff RCX: ffff888025a99e00
RDX: 0000000000000000 RSI: ffffffff8f6e8f20 RDI: 00000000000000ff
RBP: ffffc9000345f610 R08: 0000000000000001 R09: ffffffff8a27e049
R10: 0000000000000003 R11: ffff888025a99e00 R12: ffff88807ab76730
R13: dffffc0000000000 R14: 0000000000000000 R15: ffffc9000345f6a0
FS:  000055556e2a2380(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 000000007e9e2000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ip6_make_skb+0x48b/0x530 net/ipv6/ip6_output.c:2046
 udpv6_sendmsg+0x237f/0x3270 net/ipv6/udp.c:1584
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xef/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe6cfe18ab9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe2f15e328 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fe6cfe18ab9
RDX: 0000000000000000 RSI: 0000000020000400 RDI: 0000000000000003
RBP: 00007fe6cfe8b5f0 R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000001
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
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


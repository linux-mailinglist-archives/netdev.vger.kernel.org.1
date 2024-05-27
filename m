Return-Path: <netdev+bounces-98260-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5858D8D05E7
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 17:21:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAC9E1F217AC
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 15:21:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23C8515A870;
	Mon, 27 May 2024 15:12:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A0671667D3
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 15:12:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716822753; cv=none; b=hzZOFzxjQhLwzxgqKKkGdnLTYI+lGTbvgmXiXIOtrcB8f2AYIzQSI8HsDWCnLsFwqsRtgLUyNG4xpVRSRTMsZIWHv0cfMWWuyACQ2H7aO+Pc5vVnJmP6lbSoExE2ccbCjf3JX/0fl1Zefw9WZJgVpXY5BmGJ3Nk7lAfzFCvftNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716822753; c=relaxed/simple;
	bh=KlZwRsQNJK2hOB94x2y9ot/P68UdywTYR1ByKZYB8io=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=P87KWyGQ1+p7b7qhvchBPTMR9JD/LmqFTkGwfSVCqxsPcKEZn4c4V9nkoyDO8mLu6NaEkNugJfQcm6JFTGPKJzjDqO1M57vu/QxSlz9NwmtEuMESno6xwpYtbX4Tv+nN9V4gpO7jkNQ+M/dm0rcOhjFxDYz2QcwKCSB2+kKDREI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-7eaa9ddad99so193756939f.2
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 08:12:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716822750; x=1717427550;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t82Nsr/opGFzH3gJ7ALxMC7JxSPpHTp8y47yXxtkNBU=;
        b=A7mjc5gGjaUPinlmpMpZORjiut5639NbtUwwHhKX1ZpCTCDMWUqbcPAMSvb6rpj62Q
         SW25/g3l5f7lGbY+NZ16y5xoSa4NT0Qda1XchcRhRHRTFZwGaLv6lkNb+g3zoxWj7KqO
         8h6NoDABaMFKWmHxkeJxLF72SEJ27EpKev2RLsRssKCuZhSZb6hO/7IFdUliWj0VdJC2
         R90Sfc7s1wziAW2jT68IST6dSxLttAmSoxDzTP6XiVz+ra+wEJ1e0BtCHNYoofYzAvJe
         ZnC4Jc0MeYpN7cBMpgDG+Aj647Ztm7fLABi+sYAvsszSiHvNkvOd5yFjPNsDGbkBZPLo
         +5eA==
X-Forwarded-Encrypted: i=1; AJvYcCX9gXZ4KGO1fo8Qg5KXOcf/LE+WXGZzmIsA1F2agklIKopuO8kgGDrKGJxODzTOUdY++gx3lVI3LFG14GyVF0xNr7aioREK
X-Gm-Message-State: AOJu0YyNfZgVSit0NTxex7VOnQS+JuhPC3uoy8Wjy7qBopKwBFNEs4z6
	+ARDu517kO8Y/sbZTv6HgONx9h2e31V40fYp68SSaZIKObDOer72lV8wZ+XgVSUFNHAfXToBBbN
	mvJMBXtV9WXhZmXtG8PUBu0BAKSnME6+1+JkKFO/7jSGFI2fHK83OWaI=
X-Google-Smtp-Source: AGHT+IEX7Wqft478xEv5ag44NwzLq1UAljo8u5tIF9UF2fNKOLgtFqEwk70BYv7WfCuiQioa1l9aOQtBtXJoqmBOzyqJoLKt7ofl
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:27ca:b0:7de:e182:ddf1 with SMTP id
 ca18e2360f4ac-7e8c0f3cfd2mr39310739f.0.1716822750541; Mon, 27 May 2024
 08:12:30 -0700 (PDT)
Date: Mon, 27 May 2024 08:12:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000304918061970f2a2@google.com>
Subject: [syzbot] [net?] WARNING in __ip_make_skb
From: syzbot <syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, martin.lau@kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, quic_abchauha@quicinc.com, 
	syzkaller-bugs@googlegroups.com, willemb@google.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c1713a8f1c9 bpf: constify member bpf_sysctl_kern:: Table
git tree:       bpf-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15e5d544980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=30a35a2e9c5067cc43fa
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=130bc18a980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=132a223c980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2cad2c60a177/disk-2c1713a8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/0c8a5f440db5/vmlinux-2c1713a8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/53bcec8870e5/bzImage-2c1713a8.xz

The issue was bisected to:

commit 1693c5db6ab8262e6f5263f9d211855959aa5acd
Author: Abhishek Chauhan <quic_abchauha@quicinc.com>
Date:   Thu May 9 21:18:33 2024 +0000

    net: Add additional bit to support clockid_t timestamp type

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=168c3ae8980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=158c3ae8980000
console output: https://syzkaller.appspot.com/x/log.txt?x=118c3ae8980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+30a35a2e9c5067cc43fa@syzkaller.appspotmail.com
Fixes: 1693c5db6ab8 ("net: Add additional bit to support clockid_t timestamp type")

------------[ cut here ]------------
WARNING: CPU: 0 PID: 5088 at include/linux/skbuff.h:4226 skb_set_delivery_type_by_clockid include/linux/skbuff.h:4226 [inline]
WARNING: CPU: 0 PID: 5088 at include/linux/skbuff.h:4226 __ip_make_skb+0x1283/0x1eb0 net/ipv4/ip_output.c:1463
Modules linked in:
CPU: 0 PID: 5088 Comm: syz-executor398 Not tainted 6.9.0-syzkaller-08561-g2c1713a8f1c9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:skb_set_delivery_type_by_clockid include/linux/skbuff.h:4226 [inline]
RIP: 0010:__ip_make_skb+0x1283/0x1eb0 net/ipv4/ip_output.c:1463
Code: 00 00 00 00 fc ff df 4c 8b 64 24 20 eb 7d e8 b4 c8 af f7 49 bf 00 00 00 00 00 fc ff df 4c 8b 64 24 20 eb 64 e8 9e c8 af f7 90 <0f> 0b 90 49 8d 7c 24 20 48 89 f8 48 c1 e8 03 42 80 3c 38 00 74 05
RSP: 0018:ffffc900034f7248 EFLAGS: 00010293
RAX: ffffffff89e66932 RBX: 00000000000000ff RCX: ffff888022079e00
RDX: 0000000000000000 RSI: ffffffff8f6a3c10 RDI: 00000000000000ff
RBP: 0000000000000000 R08: 0000000000000001 R09: ffffffff89e66851
R10: 0000000000000003 R11: ffff888022079e00 R12: ffff88801f9f3780
R13: 1ffff110044d3802 R14: 0000000000000000 R15: dffffc0000000000
FS:  0000555579628380(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020001a00 CR3: 000000007740e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ip_make_skb+0x304/0x420 net/ipv4/ip_output.c:1569
 udp_sendmsg+0x1bef/0x2a60 net/ipv4/udp.c:1263
 udpv6_sendmsg+0x1383/0x3270 net/ipv6/udp.c:1399
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0xef/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f001e015369
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd03f53f78 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffd03f54148 RCX: 00007f001e015369
RDX: 0000000000000004 RSI: 0000000020001a00 RDI: 0000000000000003
RBP: 00007f001e088610 R08: 00007ffd03f54148 R09: 00007ffd03f54148
R10: 0000000000000008 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd03f54138 R14: 0000000000000001 R15: 0000000000000001
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


Return-Path: <netdev+bounces-63229-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0AC82BE21
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 11:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D123D1F21BE1
	for <lists+netdev@lfdr.de>; Fri, 12 Jan 2024 10:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E485D8FB;
	Fri, 12 Jan 2024 10:10:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B4D85D757
	for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7bedda4c4dfso282097039f.0
        for <netdev@vger.kernel.org>; Fri, 12 Jan 2024 02:10:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705054228; x=1705659028;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Euu7bu6YWRVOm3+DN9txsl6HaM+CK5i+lJP0EdvbHOw=;
        b=MCR5qXWp0jxL11ngfjm0orifzTAZz2leZaX+SxEoggWoxe8mQYoy94vI5SO0lS+a76
         8wh4SgjXWkdYOIt9gTmkfZEns2J9xX+fUUCzU27zvShFvEoU7C5+RcUduKEEbNgJrTop
         40+uZ/JCf2iGiYQd2LTsOxMKPj8Sde0OgSwVGQ0O0sibsRnE52kD69UwHuNxuwJHIJtd
         t4ZDW1QwhF2dBe1HjPy3m1lyal/p5zFAdoyYwjPCE59Mq2aATxLnSiro/7RaGWMFmc2r
         B1DqrqVrGc2rZWCfKc2Up+1Ozkpj82FwJ64o6UGrDvyc3cdz5W5jWg6e39iegYw5gi6E
         bFAQ==
X-Gm-Message-State: AOJu0Yz/dIae5PamQKAXU+GmFd0I81OvyCeQgXG1XI3Urk6h42vaKLyb
	A5Oaew/QOeaGsCjT6US6oww/j/cu54TVVoX0iuvxIwfH9Jf5
X-Google-Smtp-Source: AGHT+IGodp0l2JaVAyCi7GqIrafB7tYlXZ/nL630GRF5+Es3ScU9XkkgNQwju2qzQzPDo4N+yaLP3hZpEZN3muYxgIlZVOr0/3wN
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:1345:b0:46e:5639:8eeb with SMTP id
 u5-20020a056638134500b0046e56398eebmr81551jad.1.1705054228593; Fri, 12 Jan
 2024 02:10:28 -0800 (PST)
Date: Fri, 12 Jan 2024 02:10:28 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009e46c3060ebcdffd@google.com>
Subject: [syzbot] [net?] KCSAN: data-race in udpv6_sendmsg / udpv6_sendmsg (6)
From: syzbot <syzbot+8d482d0e407f665d9d10@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0dd3ee311255 Linux 6.7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1713a06de80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1bb2daade28c90a5
dashboard link: https://syzkaller.appspot.com/bug?extid=8d482d0e407f665d9d10
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/b3bdaecbc4f5/disk-0dd3ee31.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6656b77ef58a/vmlinux-0dd3ee31.xz
kernel image: https://storage.googleapis.com/syzbot-assets/85fa7f08c720/bzImage-0dd3ee31.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8d482d0e407f665d9d10@syzkaller.appspotmail.com

==================================================================
BUG: KCSAN: data-race in udpv6_sendmsg / udpv6_sendmsg

write to 0xffff88814e5eadf0 of 4 bytes by task 15547 on cpu 1:
 udpv6_sendmsg+0x1405/0x1530 net/ipv6/udp.c:1596
 inet6_sendmsg+0x63/0x80 net/ipv6/af_inet6.c:657
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x257/0x310 net/socket.c:2192
 __do_sys_sendto net/socket.c:2204 [inline]
 __se_sys_sendto net/socket.c:2200 [inline]
 __x64_sys_sendto+0x78/0x90 net/socket.c:2200
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

read to 0xffff88814e5eadf0 of 4 bytes by task 15551 on cpu 0:
 udpv6_sendmsg+0x22c/0x1530 net/ipv6/udp.c:1373
 inet6_sendmsg+0x63/0x80 net/ipv6/af_inet6.c:657
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0x37c/0x4d0 net/socket.c:2586
 ___sys_sendmsg net/socket.c:2640 [inline]
 __sys_sendmmsg+0x269/0x500 net/socket.c:2726
 __do_sys_sendmmsg net/socket.c:2755 [inline]
 __se_sys_sendmmsg net/socket.c:2752 [inline]
 __x64_sys_sendmmsg+0x57/0x60 net/socket.c:2752
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b

value changed: 0x00000000 -> 0x0000000a

Reported by Kernel Concurrency Sanitizer on:
CPU: 0 PID: 15551 Comm: syz-executor.1 Tainted: G        W          6.7.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
==================================================================


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


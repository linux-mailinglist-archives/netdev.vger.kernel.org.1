Return-Path: <netdev+bounces-194759-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8236AACC4F8
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 13:08:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9D38D7A39AD
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 11:07:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 250A522A7F2;
	Tue,  3 Jun 2025 11:08:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73FAA22B8A9
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 11:08:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748948914; cv=none; b=jr4bu8UMLqJr2XO3dwhhYuqH7SEzNDTYLBwsxXZ9OEtU+Og4PMnGOQ8BNeHyiPM8C2dgt8IXHgyBrHcmdWywsLhmBC8alhtsR0QIU6inGZcgh3VYL8A6eXm6cnEVGVEHVo4KS9IrmBSQTneBP58DY8+V0yHaaDy2KrTJVlVgb2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748948914; c=relaxed/simple;
	bh=2Kx1GWjW6U0CGH7l5TaSZn+mXFI4oOy34e1aGHejjYQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cqZzTy6GRNLFBqVZoUbKgDO8B5xonpHR/JXxDdJYdX9JrhR1B7AOUF2ILaTwVYyPqjFhuKsl0PxMtM69/1M5uQ0z0qzl95jvJcm355q0KiRW99t4DK0069WXMADVXl7sY2Oh1pxM1a4wHkRaZel592jC/KhVWXffkqN/kF4D9jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3dca1268a57so67805695ab.2
        for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 04:08:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748948911; x=1749553711;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5/nHsQLvpfzxpV76AdA4ehHL3uw7J7szSF26Al6AlNA=;
        b=JnBrspApevZzySkZ+vqOx0Ep8lNl3qZ12CPP8eUbF0lL4Tjr7OjLHe5+BF/wy+14Cm
         OkoDM+bRr9LhlRXUh0zXW+HVqrRrdYyWry7FmOECDyHAxGrhRZ/LykkvlqPpMQm9Mn5L
         zA/l61Lqx2j4HjENkJP+JITyRIt+LF2TD+VGSO1DB9Z8qcxvclzeINbv/lH2HGOhCtrh
         78KZv173XiKiRZn3+BjZ+sReHa6Hhpornw60WMAd5elwcKjFOXnuv2DORcbLKi5qUSQY
         E5W50UEcUCtH3e6KGGl3avxxctp06CI8RXUutVUNzPIPwoTdCXNzxtpAyYSa6rPMdIWl
         q5Ag==
X-Forwarded-Encrypted: i=1; AJvYcCWIloMEH5F6l/myDI77Efion2CP81sJDOkPLX0/+kDT/6y7YXEykKDQcZhmdBT4EISeSLYkWPY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhZqYuRbyLPMWhQ11kl69YOAD9DKXIBu5OsW+g59tPNU/RnCH9
	VWTynOCwcPwxL1Bnor5w50QeM8MuOY/J6AsAZBOOOnaczYDIZucmeP9CnRZG0GPr0Jl3yKyCnZL
	bW0NNRCRhwsXx2otBnx2eX9qPqUcreucTcFW9NRsBuoN8JrRJUPTzAIbHFsk=
X-Google-Smtp-Source: AGHT+IH2x9LqNtnz9cIy+uW9Swspw1k7Qx62eqgRB5NalqMWt9wSMw71fW+IrETZcSFPUS3EwFzcRzphNnhivvqmGWJwYARjyWw3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fef:b0:3dd:792d:ce42 with SMTP id
 e9e14a558f8ab-3dd9c738eb3mr162757535ab.0.1748948911543; Tue, 03 Jun 2025
 04:08:31 -0700 (PDT)
Date: Tue, 03 Jun 2025 04:08:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683ed7af.a00a0220.d8eae.0068.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in ip_mc_up
From: syzbot <syzbot+89affbc8a292a442d4cb@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    feacb1774bd5 Merge tag 'sched_ext-for-6.16' of git://git.k..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16ace6d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d4c7a3e8691d5cf
dashboard link: https://syzkaller.appspot.com/bug?extid=89affbc8a292a442d4cb
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/73deb6840db8/disk-feacb177.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/5908317c8cf4/vmlinux-feacb177.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4ab4d0c65d47/bzImage-feacb177.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+89affbc8a292a442d4cb@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000021: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000108-0x000000000000010f]
CPU: 1 UID: 0 PID: 5482 Comm: dhcpcd Not tainted 6.15.0-syzkaller-03589-gfeacb1774bd5 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:read_pnet include/net/net_namespace.h:409 [inline]
RIP: 0010:dev_net include/linux/netdevice.h:2708 [inline]
RIP: 0010:ip_mc_reset net/ipv4/igmp.c:1846 [inline]
RIP: 0010:ip_mc_up+0x76/0x300 net/ipv4/igmp.c:1879
Code: 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 3f a7 3e f8 41 be 08 01 00 00 4c 03 33 e8 b1 1e 75 01 4c 89 f0 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 f7 e8 1b a7 3e f8 4d 8b 36 48 8d bb 98
RSP: 0018:ffffc90003bcf6d0 EFLAGS: 00010206
RAX: 0000000000000021 RBX: ffff8880330a5800 RCX: ffff88802eae5a00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff8f2f36a7 R09: 1ffffffff1e5e6d4
R10: dffffc0000000000 R11: fffffbfff1e5e6d5 R12: dffffc0000000000
R13: dffffc0000000000 R14: 0000000000000108 R15: 0000000000000001
FS:  00007f84ecda4740(0000) GS:ffff8881261c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f9187e00000 CR3: 00000000217ac000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inetdev_event+0xfb3/0x15b0 net/ipv4/devinet.c:1631
 notifier_call_chain+0x1b6/0x3e0 kernel/notifier.c:85
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 __dev_notify_flags+0x18d/0x2e0 net/core/dev.c:-1
 netif_change_flags+0xe8/0x1a0 net/core/dev.c:9422
 dev_change_flags+0x130/0x260 net/core/dev_api.c:68
 devinet_ioctl+0xbb4/0x1b50 net/ipv4/devinet.c:1200
 inet_ioctl+0x3c0/0x4c0 net/ipv4/af_inet.c:1001
 sock_do_ioctl+0xd9/0x300 net/socket.c:1190
 sock_ioctl+0x576/0x790 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f84ecea4378
Code: 00 00 48 8d 44 24 08 48 89 54 24 e0 48 89 44 24 c0 48 8d 44 24 d0 48 89 44 24 c8 b8 10 00 00 00 c7 44 24 b8 10 00 00 00 0f 05 <89> c2 3d 00 f0 ff ff 77 07 89 d0 c3 0f 1f 40 00 48 8b 15 49 3a 0d
RSP: 002b:00007ffd5c4009c8 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 000000000000001a RCX: 00007f84ecea4378
RDX: 00007ffd5c410bc0 RSI: 0000000000008914 RDI: 000000000000001a
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd5c420d60
R13: 00007f84ecda46c8 R14: 0000000000000028 R15: 0000000000008914
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:read_pnet include/net/net_namespace.h:409 [inline]
RIP: 0010:dev_net include/linux/netdevice.h:2708 [inline]
RIP: 0010:ip_mc_reset net/ipv4/igmp.c:1846 [inline]
RIP: 0010:ip_mc_up+0x76/0x300 net/ipv4/igmp.c:1879
Code: 89 d8 48 c1 e8 03 42 80 3c 20 00 74 08 48 89 df e8 3f a7 3e f8 41 be 08 01 00 00 4c 03 33 e8 b1 1e 75 01 4c 89 f0 48 c1 e8 03 <42> 80 3c 20 00 74 08 4c 89 f7 e8 1b a7 3e f8 4d 8b 36 48 8d bb 98
RSP: 0018:ffffc90003bcf6d0 EFLAGS: 00010206
RAX: 0000000000000021 RBX: ffff8880330a5800 RCX: ffff88802eae5a00
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: ffffffff8f2f36a7 R09: 1ffffffff1e5e6d4
R10: dffffc0000000000 R11: fffffbfff1e5e6d5 R12: dffffc0000000000
R13: dffffc0000000000 R14: 0000000000000108 R15: 0000000000000001
FS:  00007f84ecda4740(0000) GS:ffff8881261c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31206ff8 CR3: 00000000217ac000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 d8                	mov    %ebx,%eax
   2:	48 c1 e8 03          	shr    $0x3,%rax
   6:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1)
   b:	74 08                	je     0x15
   d:	48 89 df             	mov    %rbx,%rdi
  10:	e8 3f a7 3e f8       	call   0xf83ea754
  15:	41 be 08 01 00 00    	mov    $0x108,%r14d
  1b:	4c 03 33             	add    (%rbx),%r14
  1e:	e8 b1 1e 75 01       	call   0x1751ed4
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	4c 89 f7             	mov    %r14,%rdi
  34:	e8 1b a7 3e f8       	call   0xf83ea754
  39:	4d 8b 36             	mov    (%r14),%r14
  3c:	48                   	rex.W
  3d:	8d                   	.byte 0x8d
  3e:	bb                   	.byte 0xbb
  3f:	98                   	cwtl


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


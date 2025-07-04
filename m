Return-Path: <netdev+bounces-204101-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 395E0AF8E87
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 11:27:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F93D1C8289B
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 09:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D47592E7F05;
	Fri,  4 Jul 2025 09:27:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 181EB2D3A66
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 09:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751621252; cv=none; b=jUvB1rt7H0OiroueVnmcS0GB/cjZ1GNEPM95tnvXIZcwNLVgGLg+sAMHfqSanN7R1P105PI6b146TCQjNZmFUWnDMJmQl7RUJFBHq4c6M1Y9dd/AnQO2g7VIK6w4tHFG+jUPYv4Yg5I7pdpd2CYad2h2C4/QfkWIzHQ/hUYIm60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751621252; c=relaxed/simple;
	bh=vJmRxvt5IjJvJLikyAZ61MuBwjllp4Iz/jKtV4ZDZv4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=IJFSTjdqTG117wlCA0yUGL5MciMTjMdJBsMg67YFefHcIDSA4mbPTTEQYPWAFvp+/ehvtK78hiQ0qMKENgqRF61Xq66wIMa0w/Z/1ZFlJk9vvNsk599IoMXQS2KQCqusfg5ORMuunIloNrQL1aP9kbkI5hvTfCSlYyYu1ErM7V4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-86cfccca327so160478939f.2
        for <netdev@vger.kernel.org>; Fri, 04 Jul 2025 02:27:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751621250; x=1752226050;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=b18G2rPqWbI95khyrG3L6Ov9rjrXsFNqNwmdeoc/jfs=;
        b=DkQQr4FblRQ0SSNo7LspCdG4sL5ai2QA87XGYGkQZybdmEzj1n1ojyj3VC9b02pAbG
         QTUjICH12XrkCbZ1hDbBsD0ocIG3VxKhrvqFUh1N+K1JxKF1nxcyAHgb1mNqhuPyPRsk
         n6sESd9ail0sGT9W0GYfsBIqi8GJ1JCLdeeYtqIZCHIKLM1v8aNOHgbqGwRyTHV4FtlC
         BEJsg0YZy84fgwK6bZnqVr1etOPH6WuAxaKBP+w4V5z4Gfl/zktRvWrkx8+D61YAmwNJ
         kH5Vs5/3FAg0w7PaZnkpZLsKRza9A03r7C/I1k9V/vDKBQ00GwfC/MTZXGHQ12/OkHbr
         W3Pg==
X-Forwarded-Encrypted: i=1; AJvYcCWGU2bDPDcL6A2pNB1BvRQM8IAnvPtRqgwn5zyBUGTpqu3d7oEnflp4h4+/oGtmBv2aJPaIGSc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7UUEzeItC5VcSgvQ7UdsubezqUKTj56VHyU9VYgoIYD6tN+PH
	mjRZ4gm6zTqNSCEdyEFV3r4sRdgkW95c9XFa0QkC5Cs5fylix+uKD3N6jacu6B5TKKFSIM9yL7d
	6Bt+nXolQCbwhQtgcHoV8RqEF9m7zhnuUuQWxrrmvz1QgV7LvzA/Z4/Q0SBw=
X-Google-Smtp-Source: AGHT+IH/3kwB+gIcPOEvk6chq9FpuZ5NabBEmzsw1+Q5nqpukL/TSIM+IWz4qwlWVxLxzdFNKsSLstn/HAd+pk8hobNw41wgZKlg
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:380c:b0:3df:154d:aa5b with SMTP id
 e9e14a558f8ab-3e135465292mr15826895ab.5.1751621249723; Fri, 04 Jul 2025
 02:27:29 -0700 (PDT)
Date: Fri, 04 Jul 2025 02:27:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68679e81.a70a0220.29cf51.0016.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in qfq_qlen_notify
From: syzbot <syzbot+4dadc5aecf80324d5a51@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    17bbde2e1716 Merge tag 'net-6.16-rc5' of git://git.kernel...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1774b3d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a6dba31fc9bb876c
dashboard link: https://syzkaller.appspot.com/bug?extid=4dadc5aecf80324d5a51
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/224153e195ae/disk-17bbde2e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/790493022e09/vmlinux-17bbde2e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/67c6b016f914/bzImage-17bbde2e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4dadc5aecf80324d5a51@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 1 UID: 0 PID: 21481 Comm: syz.0.4721 Not tainted 6.16.0-rc4-syzkaller-00108-g17bbde2e1716 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:list_empty include/linux/list.h:373 [inline]
RIP: 0010:qfq_qlen_notify+0x29/0x70 net/sched/sch_qfq.c:1422
Code: 90 f3 0f 1e fa 41 57 41 56 53 48 89 f3 49 89 fe e8 ac 6b 3f f8 4c 8d 7b 58 4c 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 ff e8 59 ee a2 f8 49 8b 07 4c 39 f8 74 1c
RSP: 0018:ffffc9000468efc8 EFLAGS: 00010202
RAX: 000000000000000b RBX: 0000000000000000 RCX: dffffc0000000000
RDX: ffffc9000c37b000 RSI: 0000000000000b34 RDI: 0000000000000b35
RBP: dffffc0000000000 R08: ffff88802c5f8000 R09: 0000000000000002
R10: 00000000ffffffff R11: ffffffff8980e2e0 R12: 0000000000000000
R13: ffff888036988000 R14: ffff888036988000 R15: 0000000000000058
FS:  0000000000000000(0000) GS:ffff888125d50000(0063) knlGS:00000000f50aeb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000030117ff8 CR3: 000000007cd72000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 000000000000000e DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 qdisc_tree_reduce_backlog+0x299/0x480 net/sched/sch_api.c:811
 fq_change+0x1519/0x1f50 net/sched/sch_fq.c:1147
 fq_init+0x699/0x960 net/sched/sch_fq.c:1201
 qdisc_create+0x7a9/0xea0 net/sched/sch_api.c:1324
 __tc_modify_qdisc net/sched/sch_api.c:1749 [inline]
 tc_modify_qdisc+0x1426/0x2010 net/sched/sch_api.c:1813
 rtnetlink_rcv_msg+0x77c/0xb70 net/core/rtnetlink.c:6953
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x758/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg+0x164/0x220 net/socket.c:2652
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0xb6/0x2b0 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x34/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf70be539
Code: 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90
RSP: 002b:00000000f50ae55c EFLAGS: 00000206 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000005 RCX: 0000000080000200
RDX: 0000000004008000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000206 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:list_empty include/linux/list.h:373 [inline]
RIP: 0010:qfq_qlen_notify+0x29/0x70 net/sched/sch_qfq.c:1422
Code: 90 f3 0f 1e fa 41 57 41 56 53 48 89 f3 49 89 fe e8 ac 6b 3f f8 4c 8d 7b 58 4c 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 ff e8 59 ee a2 f8 49 8b 07 4c 39 f8 74 1c
RSP: 0018:ffffc9000468efc8 EFLAGS: 00010202
RAX: 000000000000000b RBX: 0000000000000000 RCX: dffffc0000000000
RDX: ffffc9000c37b000 RSI: 0000000000000b34 RDI: 0000000000000b35
RBP: dffffc0000000000 R08: ffff88802c5f8000 R09: 0000000000000002
R10: 00000000ffffffff R11: ffffffff8980e2e0 R12: 0000000000000000
R13: ffff888036988000 R14: ffff888036988000 R15: 0000000000000058
FS:  0000000000000000(0000) GS:ffff888125d50000(0063) knlGS:00000000f50aeb40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: 0000000030117ff8 CR3: 000000007cd72000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 000000000000000e DR6: 00000000ffff0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	f3 0f 1e fa          	endbr64
   5:	41 57                	push   %r15
   7:	41 56                	push   %r14
   9:	53                   	push   %rbx
   a:	48 89 f3             	mov    %rsi,%rbx
   d:	49 89 fe             	mov    %rdi,%r14
  10:	e8 ac 6b 3f f8       	call   0xf83f6bc1
  15:	4c 8d 7b 58          	lea    0x58(%rbx),%r15
  19:	4c 89 f8             	mov    %r15,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 ff             	mov    %r15,%rdi
  33:	e8 59 ee a2 f8       	call   0xf8a2ee91
  38:	49 8b 07             	mov    (%r15),%rax
  3b:	4c 39 f8             	cmp    %r15,%rax
  3e:	74 1c                	je     0x5c


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


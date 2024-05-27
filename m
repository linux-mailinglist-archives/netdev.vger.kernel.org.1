Return-Path: <netdev+bounces-98189-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 286B58D0142
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 15:22:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B7381F21803
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 13:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84C3315ECFF;
	Mon, 27 May 2024 13:22:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E495C43AC1
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 13:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716816150; cv=none; b=HGVKmfulQ7zKxvh0KLPaqjRW9EfCI8A8D75tACKsUqIdOfEuNC6J3qw4tb9nmFUS0pfxhWg39jKsC+u7v1mIg56dUgTBF+dCf4sXyEC94/DYDUePG2OKiChBO094FPLGfjgFV+Xf8lS60GdBFbt1gGfzX+NACdO2GHHLzjo4HoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716816150; c=relaxed/simple;
	bh=JWtt6Abdjck7XIpEK9UwFhE+Pqmzep9TYpawW/MOpSA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Q3T9s67oCwE1rKxp3O/9aEC0Kwx6EwIoOnTO1a+0ACNXlkl+MmKboScwU0Ze7C4dxaW0ZSMbpuO5gR8ImvZ2zZweeHfQkqNrxWAnQpPKgPOEq7AWVuaEc4UOXLrmJQt7Gdz+9NgIo2faWcVcX9u7tWBXyUiykv9UQHaK+7tjU80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3745fb76682so3644255ab.2
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 06:22:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716816148; x=1717420948;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7WZIq4G9PtxcmkzMzsJUrrOotpdeCmbsOBz+DCbbDC4=;
        b=VfoMw1ve+foo6r/GoLD3HHm0NOufOW/0qnfxjAUrXgdL5lupgZcoAu5tVvCtZuxMLC
         XwEuQkwN08zp7DfnokQTzjBWfR63bfk0HFDFyPUDQvI/KGg52DrIX/PNk7Rogw+Fz4SO
         qoe1cs4QXK+AdByqdO/mZiDMnV0VWuOfbNOZ0fNKJRDVVkH2WUg4Lx4uviPB5vntilEO
         dmLIUiMGBKcb0j3CtDFucxP3SQfQ034TqeM/eMF99vBdNX8sPXU9LBOdBVHxp+Iv+mRL
         5HayROStGC2QyQVa8U7haasfVjM6KZj3VqBXpDrM9QBz0YcY0BRSb/5st5sA22DP/ac+
         Z/sg==
X-Forwarded-Encrypted: i=1; AJvYcCUyBbadU2ZICndIH6SLXs6WGN3KmEgnhEfzq+XTW0RkWz59D/bXDU56VsTMOY+bOIzRQX6KDouRrS8Juov+bMWtWK4XmXIT
X-Gm-Message-State: AOJu0Ywkoj9oB4TLid0Gqo/xs3pN52p6uaJ59n1re90d8rUDAmT7Acmn
	U+uVtnz+iFSlbvA9jorej1TCMTAr0F3Y749WhyIO8yXvqNCqZAW09/aKLT9UJMd0MSsB8qQ1tjX
	l2hoJjZNGU6CZo6Gp7kPK27GbMwV92E4ZViyNM1II2/zzAQrM0oADi/U=
X-Google-Smtp-Source: AGHT+IFiWnPYmjdm2RumhlqnAvIc6i8X7o4JX9hPFntNVse2StehRurPUlpwZ49d6cXFfVIK/zrPQ8sqyhs59oml4q1WMusuwZZH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a41:b0:36d:d38e:3520 with SMTP id
 e9e14a558f8ab-3737b33d769mr8047805ab.4.1716816148086; Mon, 27 May 2024
 06:22:28 -0700 (PDT)
Date: Mon, 27 May 2024 06:22:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000a6d9f506196f6826@google.com>
Subject: [syzbot] [net?] divide error in taprio_update_queue_max_sdu
From: syzbot <syzbot+233e6e0ea2ba2c86fa79@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jhs@mojatatu.com, 
	jiri@resnulli.us, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	vinicius.gomes@intel.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4b377b4868ef kprobe/ftrace: fix build error due to bad fun..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=11ab31a4980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=17ffd15f654c98ba
dashboard link: https://syzkaller.appspot.com/bug?extid=233e6e0ea2ba2c86fa79
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6f4c61bc9252/disk-4b377b48.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/841f1b24d3a1/vmlinux-4b377b48.xz
kernel image: https://storage.googleapis.com/syzbot-assets/017b655dca3d/bzImage-4b377b48.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+233e6e0ea2ba2c86fa79@syzkaller.appspotmail.com

Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 1 PID: 15391 Comm: syz-executor.0 Not tainted 6.9.0-syzkaller-08544-g4b377b4868ef #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
RIP: 0010:div_u64_rem include/linux/math64.h:29 [inline]
RIP: 0010:div_u64 include/linux/math64.h:130 [inline]
RIP: 0010:duration_to_length net/sched/sch_taprio.c:259 [inline]
RIP: 0010:taprio_update_queue_max_sdu+0x287/0x870 net/sched/sch_taprio.c:288
Code: be 08 00 00 00 e8 99 5b 6a f8 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 13 59 6a f8 48 8b 03 89 c1 48 89 e8 31 d2 <48> f7 f1 48 89 c5 48 83 7c 24 50 00 4c 8b 74 24 30 74 47 e8 c1 19
RSP: 0018:ffffc9000506eb38 EFLAGS: 00010246
RAX: 0000000000001f40 RBX: ffff88802f3562e0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88802f3562e0
RBP: 0000000000001f40 R08: ffff88802f3562e7 R09: 1ffff11005e6ac5c
R10: dffffc0000000000 R11: ffffed1005e6ac5d R12: 00000000ffffffff
R13: dffffc0000000000 R14: ffff88801ef59400 R15: 00000000003f0008
FS:  00007fee340bf6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b2c524000 CR3: 0000000024a52000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 taprio_change+0x2dce/0x42d0 net/sched/sch_taprio.c:1911
 taprio_init+0x9da/0xc80 net/sched/sch_taprio.c:2112
 qdisc_create+0x9d4/0x11a0 net/sched/sch_api.c:1355
 tc_modify_qdisc+0xa26/0x1e40 net/sched/sch_api.c:1777
 rtnetlink_rcv_msg+0x89b/0x10d0 net/core/rtnetlink.c:6595
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x7ea/0x980 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8e1/0xcb0 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2584
 ___sys_sendmsg net/socket.c:2638 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2667
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf5/0x240 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fee3327cee9
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fee340bf0c8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fee333abf80 RCX: 00007fee3327cee9
RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 000000000000000e
RBP: 00007fee332c949e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fee333abf80 R15: 00007fff3d596598
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:div_u64_rem include/linux/math64.h:29 [inline]
RIP: 0010:div_u64 include/linux/math64.h:130 [inline]
RIP: 0010:duration_to_length net/sched/sch_taprio.c:259 [inline]
RIP: 0010:taprio_update_queue_max_sdu+0x287/0x870 net/sched/sch_taprio.c:288
Code: be 08 00 00 00 e8 99 5b 6a f8 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df e8 13 59 6a f8 48 8b 03 89 c1 48 89 e8 31 d2 <48> f7 f1 48 89 c5 48 83 7c 24 50 00 4c 8b 74 24 30 74 47 e8 c1 19
RSP: 0018:ffffc9000506eb38 EFLAGS: 00010246
RAX: 0000000000001f40 RBX: ffff88802f3562e0 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffff88802f3562e0
RBP: 0000000000001f40 R08: ffff88802f3562e7 R09: 1ffff11005e6ac5c
R10: dffffc0000000000 R11: ffffed1005e6ac5d R12: 00000000ffffffff
R13: dffffc0000000000 R14: ffff88801ef59400 R15: 00000000003f0008
FS:  00007fee340bf6c0(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b31424000 CR3: 0000000024a52000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	be 08 00 00 00       	mov    $0x8,%esi
   5:	e8 99 5b 6a f8       	call   0xf86a5ba3
   a:	48 89 d8             	mov    %rbx,%rax
   d:	48 c1 e8 03          	shr    $0x3,%rax
  11:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  16:	74 08                	je     0x20
  18:	48 89 df             	mov    %rbx,%rdi
  1b:	e8 13 59 6a f8       	call   0xf86a5933
  20:	48 8b 03             	mov    (%rbx),%rax
  23:	89 c1                	mov    %eax,%ecx
  25:	48 89 e8             	mov    %rbp,%rax
  28:	31 d2                	xor    %edx,%edx
* 2a:	48 f7 f1             	div    %rcx <-- trapping instruction
  2d:	48 89 c5             	mov    %rax,%rbp
  30:	48 83 7c 24 50 00    	cmpq   $0x0,0x50(%rsp)
  36:	4c 8b 74 24 30       	mov    0x30(%rsp),%r14
  3b:	74 47                	je     0x84
  3d:	e8                   	.byte 0xe8
  3e:	c1                   	.byte 0xc1
  3f:	19                   	.byte 0x19


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


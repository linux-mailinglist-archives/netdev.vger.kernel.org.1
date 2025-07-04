Return-Path: <netdev+bounces-203999-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AB4ABAF872B
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 07:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 587304A052C
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 05:20:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 139601EF38C;
	Fri,  4 Jul 2025 05:20:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C5591D95A3
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751606440; cv=none; b=A1gVekUz3Ia45IqjLzrLK5c+vrsiMfaqzlVwAgHrsxx/JGGgLuAdZeeNF0cCa5sdWu7+9bzZZwcRQZIBwuRnic0Fc+0A80FOd0Z0kP2Kg9PR7++Afvrti9QBEWwq8NSu0O6IN8nsgTeuUnn4xnFmJcvJKUqE6/6PNNZHYEYMnJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751606440; c=relaxed/simple;
	bh=0pOsgtsTo4ckHDpTYcuNPhkYno5xKl2ahM4BAGNhQcY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=W1koYzQxfpbOsg6bpXRc84kuxgrKOwWW9ce2USXvdwHJMRe9moWZ15yDeuSOVkP/hC4Vs0Aj/gElBMbpF7jhPWVP3C0WNpU8XCjWaqjrOk0DHNGIS8KFyeyTZrdcQEl1wtSKoCXgERDoy/FtceBe2s1RD+3xpQscPFRKKkfyne4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86cff1087deso134306139f.2
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 22:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751606437; x=1752211237;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=18/sKOicE2f7Ggx1undsXQNvrnSH762Hho/UUhpZCcA=;
        b=NincWZ7YoHplCAaChh9yuwERddFbtyj2JUXsYaPG0uvzWTRO+RlfaRBLCrFlA42Y0a
         ZftzvlDxvEX3kMhJA0bAtaRWp5dD86XrJz5lYWhNTMWLIgRLCe/DKDX6bXkK7gIq73uY
         2vUwAcPEpTuLY6+pVor5p/PqXELXdJF96f8i8qtWvPA09Vf6H/ZJIZziPlnczF5HX6YS
         CcmnQBpyjEdWVIykECqogjdkwPCiwv0gxLWCHo0qn3PxVfa4kEoLs0HKVYa8tRkHIRDa
         xxpbZxfx2u5fbDFhGNnpOpFA4iXsAxeVRWipqSH7XJ73ERs+cwID2vZDnrtLpoB/kmN3
         Hs7Q==
X-Forwarded-Encrypted: i=1; AJvYcCW/NxWVRscGtD+nmzv1mi9wqqjoAnvNIYQ7WyI1nhVVHMmk0B4L5O3XKMrodo8LQfhbOFIok5Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzA9VRfIZ3q9wMJJ1/gagqnETY/tMzfl2NtbLGFiMP106MV72iT
	ZrKpdCs8hwQHkJ6MhafJwrlbIEFOC31/XB+7FIpUSxlHkpfx/gfDDS/DQr3KpviKFANpXh3hIM2
	MVWm3MFqBFMU6GvRThNMPBfSiaTAzJpATfTJd8aqXBUxGgXdZtV+f44DtEac=
X-Google-Smtp-Source: AGHT+IG2RVhiGN+n9hq1Ug6fUL9AKll7f+7HBi2SyveCtTq/KLhYBck4RbdtT+kHBtLzABmCAuLoCBjX5sMRh8vyQZ2yColPwLD/
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12c3:b0:3d6:cbad:235c with SMTP id
 e9e14a558f8ab-3e13548bc4dmr10693475ab.6.1751606437444; Thu, 03 Jul 2025
 22:20:37 -0700 (PDT)
Date: Thu, 03 Jul 2025 22:20:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686764a5.a00a0220.c7b3.0013.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in qdisc_tree_reduce_backlog
From: syzbot <syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bd475eeaaf3c Merge branch '200GbE' of git://git.kernel.org..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12f0b3d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36b0e72cad5298f8
dashboard link: https://syzkaller.appspot.com/bug?extid=1261670bbdefc5485a06
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=164d8c8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14839ebc580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d59bc82a55e0/disk-bd475eea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a83759fceb6/vmlinux-bd475eea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/07576fd8e432/bzImage-bd475eea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000004: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
CPU: 0 UID: 0 PID: 5835 Comm: syz-executor374 Not tainted 6.16.0-rc3-syzkaller-00144-gbd475eeaaf3c #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:qdisc_tree_reduce_backlog+0x223/0x480 net/sched/sch_api.c:806
Code: 89 ef e8 40 80 b3 f8 4d 89 ef 85 db 74 0d e8 74 fc 4f f8 4c 89 f5 e9 88 00 00 00 48 8b 6d 00 48 8d 45 20 48 89 c3 48 c1 eb 03 <42> 80 3c 33 00 48 89 04 24 74 0d 48 8b 3c 24 e8 09 80 b3 f8 48 8b
RSP: 0018:ffffc900040bf0a8 EFLAGS: 00010202
RAX: 0000000000000020 RBX: 0000000000000004 RCX: 0000000000000000
RDX: ffff888031da3c00 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff888031da3c00 R09: 0000000000000002
R10: 00000000ffffffff R11: 0000000000000000 R12: 00000000000afff2
R13: ffff88802875a000 R14: dffffc0000000000 R15: ffff88802875a000
FS:  000055555b6b1380(0000) GS:ffff888125c50000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000240 CR3: 00000000726c2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 fq_codel_change+0xa96/0xef0 net/sched/sch_fq_codel.c:450
 fq_codel_init+0x355/0x960 net/sched/sch_fq_codel.c:487
 qdisc_create+0x7ac/0xea0 net/sched/sch_api.c:1324
 __tc_modify_qdisc net/sched/sch_api.c:1749 [inline]
 tc_modify_qdisc+0x1426/0x2010 net/sched/sch_api.c:1813
 rtnetlink_rcv_msg+0x779/0xb70 net/core/rtnetlink.c:6953
 netlink_rcv_skb+0x208/0x470 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x75b/0x8d0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:727
 ____sys_sendmsg+0x505/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2655
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f79d710a6a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff2ee70668 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fff2ee70838 RCX: 00007f79d710a6a9
RDX: 0000000000000800 RSI: 0000200000000100 RDI: 0000000000000003
RBP: 00007f79d717d610 R08: 0000000000000004 R09: 00007fff2ee70838
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fff2ee70828 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:qdisc_tree_reduce_backlog+0x223/0x480 net/sched/sch_api.c:806
Code: 89 ef e8 40 80 b3 f8 4d 89 ef 85 db 74 0d e8 74 fc 4f f8 4c 89 f5 e9 88 00 00 00 48 8b 6d 00 48 8d 45 20 48 89 c3 48 c1 eb 03 <42> 80 3c 33 00 48 89 04 24 74 0d 48 8b 3c 24 e8 09 80 b3 f8 48 8b
RSP: 0018:ffffc900040bf0a8 EFLAGS: 00010202
RAX: 0000000000000020 RBX: 0000000000000004 RCX: 0000000000000000
RDX: ffff888031da3c00 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff888031da3c00 R09: 0000000000000002
R10: 00000000ffffffff R11: 0000000000000000 R12: 00000000000afff2
R13: ffff88802875a000 R14: dffffc0000000000 R15: ffff88802875a000
FS:  000055555b6b1380(0000) GS:ffff888125c50000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000000240 CR3: 00000000726c2000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	89 ef                	mov    %ebp,%edi
   2:	e8 40 80 b3 f8       	call   0xf8b38047
   7:	4d 89 ef             	mov    %r13,%r15
   a:	85 db                	test   %ebx,%ebx
   c:	74 0d                	je     0x1b
   e:	e8 74 fc 4f f8       	call   0xf84ffc87
  13:	4c 89 f5             	mov    %r14,%rbp
  16:	e9 88 00 00 00       	jmp    0xa3
  1b:	48 8b 6d 00          	mov    0x0(%rbp),%rbp
  1f:	48 8d 45 20          	lea    0x20(%rbp),%rax
  23:	48 89 c3             	mov    %rax,%rbx
  26:	48 c1 eb 03          	shr    $0x3,%rbx
* 2a:	42 80 3c 33 00       	cmpb   $0x0,(%rbx,%r14,1) <-- trapping instruction
  2f:	48 89 04 24          	mov    %rax,(%rsp)
  33:	74 0d                	je     0x42
  35:	48 8b 3c 24          	mov    (%rsp),%rdi
  39:	e8 09 80 b3 f8       	call   0xf8b38047
  3e:	48                   	rex.W
  3f:	8b                   	.byte 0x8b


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


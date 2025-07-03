Return-Path: <netdev+bounces-203699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2BEAF6C9B
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 10:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9AF4A494A
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 08:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94922C3262;
	Thu,  3 Jul 2025 08:17:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F397F29A9D3
	for <netdev@vger.kernel.org>; Thu,  3 Jul 2025 08:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751530646; cv=none; b=UPfFk/5R4MfLY5+qTm47nVUIQuOF4uGTkV2NBuwSVTqz8LYzAS5VvawJbvz+LZ/iy458LM68hSKUQj/JQKiM95WIWR3ahQlCkNmcfBSqNEE829AyE6ZJoKdxQS7s3kQtgk8RlPwHUSJynsZAZSxwPxCbPOx0Z4THs5PBl9x1Zf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751530646; c=relaxed/simple;
	bh=0tqfQcdcQKvuybNYYmd7zqhw/ToCZ5BO8caAXPV5fps=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RAaMp2q0w8yHIjHbNHqv42BZNYF9n0JB08+Xx2ja9XfYoBXsXEdsm4SI1P8ITxD4so1s0koSwD/wC0MpWjVYz77nv0xKZxKgLWcneI9Ts/3aKLC2MIbojbp6CzlF3OC3DwHX0cj/Q2AtJkvuOA2VlOh26kTD3D/0EyV45tNg2sc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-86d07944f29so1040785339f.0
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 01:17:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751530644; x=1752135444;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tP8fSrrWw+c6oVlbKpv1/K9lt7NV7UPwWnh/sxdbK/k=;
        b=WgEKl3H1LRDQQi9hbUUTJbZg7xobA8dnU5Vtx+aSLRXkRyXdhcS9UKcs0+YKMEVZSk
         HksvA9YFdjVs5rVnR27ACRcjsMmoo76+o8IBobvdIcc2iF7fyi2O4FTGCjg3AeQQXyY6
         mrg0t6/RO2/V/Ipm8Hn790XFxNnZ31oqje5DfScD5PMLZjApceuLTjkhYbafyEbkjZ4p
         d8W9SPa8NqrA/3OQbuAOWfi7XMzZQvT0H5JxgT/xZg2fSUsDdKfvlxHOD1j8Dcmo7s58
         9Pf1tZNxnNxARarMs9U8b1fEMb1sKtiJCI9wi6cdn8BI2JDyzk81+BuKaH/JAHA5epi5
         4OIA==
X-Forwarded-Encrypted: i=1; AJvYcCXH6DVqYggp8PTDZQAvOOJB9ZSgJrWfLSpjNWyIHL3S3Aa3eHwo+gX5x2pEMdMqiMPD7GXyc+E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8YyBoIkQdfdH/2N9TEYzgRU+M9CE1dq5ovYubzQeW1V4Y1yPH
	0GnOzC3MCsHo7fTcqxUSOoJOUaOM6TM6k+dUmpJPKOPG8GIzSqrKxC1dXf9TjBUX768ElxbhYVQ
	rbYpey/ywIqti9p/fFe2masXEnns+r5+bTqaH2jR/fmeKwSACpvjmlF4xPJI=
X-Google-Smtp-Source: AGHT+IFOZtOW8lab3M0KveD6JB+xB55jCeWVZWok95T1ybd9U5+90wzOI5xdlMgBLaLI8WNjjxGiRaN/pL4TlllEyOLbZEnV1N7G
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a6b:fc03:0:b0:876:b8a0:6a16 with SMTP id
 ca18e2360f4ac-876c6a8a90cmr653146239f.13.1751530644171; Thu, 03 Jul 2025
 01:17:24 -0700 (PDT)
Date: Thu, 03 Jul 2025 01:17:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68663c94.a70a0220.5d25f.0858.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in hfsc_qlen_notify
From: syzbot <syzbot+5eccb463fa89309d8bdc@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    bd475eeaaf3c Merge branch '200GbE' of git://git.kernel.org..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=16510c8c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=36b0e72cad5298f8
dashboard link: https://syzkaller.appspot.com/bug?extid=5eccb463fa89309d8bdc
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d59bc82a55e0/disk-bd475eea.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2a83759fceb6/vmlinux-bd475eea.xz
kernel image: https://storage.googleapis.com/syzbot-assets/07576fd8e432/bzImage-bd475eea.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5eccb463fa89309d8bdc@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000005d: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x00000000000002e8-0x00000000000002ef]
CPU: 0 UID: 0 PID: 13767 Comm: syz.0.2184 Not tainted 6.16.0-rc3-syzkaller-00144-gbd475eeaaf3c #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:hfsc_qlen_notify+0x2e/0x160 net/sched/sch_hfsc.c:1238
Code: 55 41 57 41 56 41 55 41 54 53 48 89 f3 49 bc 00 00 00 00 00 fc ff df e8 d0 ef 45 f8 4c 8d b3 ec 02 00 00 4c 89 f0 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 e8 00 00 00 41 8b 2e 31 ff 89 ee e8 e9
RSP: 0018:ffffc90003d2f070 EFLAGS: 00010203
RAX: 000000000000005d RBX: 0000000000000000 RCX: 0000000000080000
RDX: ffffc9000c0e9000 RSI: 0000000000000323 RDI: 0000000000000324
RBP: dffffc0000000000 R08: ffff88802c831e00 R09: 0000000000000002
R10: 00000000ffffffff R11: ffffffff897a5e80 R12: dffffc0000000000
R13: ffff888053eaa000 R14: 00000000000002ec R15: ffff888053eaa000
FS:  00007f783fff36c0(0000) GS:ffff888125c50000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8d435e1e9c CR3: 000000005e97a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 qdisc_tree_reduce_backlog+0x29c/0x480 net/sched/sch_api.c:811
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
RIP: 0033:0x7f783f18e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f783fff3038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f783f3b5fa0 RCX: 00007f783f18e929
RDX: 0000000000000800 RSI: 0000200000000100 RDI: 0000000000000005
RBP: 00007f783f210b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007f783f3b5fa0 R15: 00007ffd53451d68
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:hfsc_qlen_notify+0x2e/0x160 net/sched/sch_hfsc.c:1238
Code: 55 41 57 41 56 41 55 41 54 53 48 89 f3 49 bc 00 00 00 00 00 fc ff df e8 d0 ef 45 f8 4c 8d b3 ec 02 00 00 4c 89 f0 48 c1 e8 03 <42> 0f b6 04 20 84 c0 0f 85 e8 00 00 00 41 8b 2e 31 ff 89 ee e8 e9
RSP: 0018:ffffc90003d2f070 EFLAGS: 00010203
RAX: 000000000000005d RBX: 0000000000000000 RCX: 0000000000080000
RDX: ffffc9000c0e9000 RSI: 0000000000000323 RDI: 0000000000000324
RBP: dffffc0000000000 R08: ffff88802c831e00 R09: 0000000000000002
R10: 00000000ffffffff R11: ffffffff897a5e80 R12: dffffc0000000000
R13: ffff888053eaa000 R14: 00000000000002ec R15: ffff888053eaa000
FS:  00007f783fff36c0(0000) GS:ffff888125c50000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f8d435e1e9c CR3: 000000005e97a000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	55                   	push   %rbp
   1:	41 57                	push   %r15
   3:	41 56                	push   %r14
   5:	41 55                	push   %r13
   7:	41 54                	push   %r12
   9:	53                   	push   %rbx
   a:	48 89 f3             	mov    %rsi,%rbx
   d:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
  14:	fc ff df
  17:	e8 d0 ef 45 f8       	call   0xf845efec
  1c:	4c 8d b3 ec 02 00 00 	lea    0x2ec(%rbx),%r14
  23:	4c 89 f0             	mov    %r14,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 e8 00 00 00    	jne    0x11f
  37:	41 8b 2e             	mov    (%r14),%ebp
  3a:	31 ff                	xor    %edi,%edi
  3c:	89 ee                	mov    %ebp,%esi
  3e:	e8                   	.byte 0xe8
  3f:	e9                   	.byte 0xe9


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


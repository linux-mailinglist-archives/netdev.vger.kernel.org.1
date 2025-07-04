Return-Path: <netdev+bounces-204000-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F5EEAF872C
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 07:20:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F0BF8189D756
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 05:21:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471CB1F418D;
	Fri,  4 Jul 2025 05:20:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B3761DF256
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 05:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751606440; cv=none; b=eJvh7mNxoe3tnd5RUCd93SbB2AjV6L5h+qtMxDuwlGi4RpCFHFN0V/SXnaOgTmEpJqJhavmwp+qUfnKCly96vjfZiaJJ3X3mA8hZAqxDdXaYozP7ChWLTmMc+sklOqCNCC5xQjPO5qnNmkSO+/4kK2woPkKXhvrlb/Qo8yuC0ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751606440; c=relaxed/simple;
	bh=C0HL7rXhTPzkfX1xuF+FUHrAJ2KFyKuHkopqsiYOV0Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=felyw2g6GL2EJ9GaK8jrvdUN+yP4hT4VW2GBsBCGIm6eV1sA6G+ziEa0Bw3bO/B0mwv1RkJsGojTutgGyFg13tdMqyncs/EJr6bIiZ31ZbCB/Fj6iBRvuf4dPBifO5+pnEWhIGhxsbklnsJlrXYLOa9/ozknWgiJki160z3Gk5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-87326a81ceaso141415939f.1
        for <netdev@vger.kernel.org>; Thu, 03 Jul 2025 22:20:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751606437; x=1752211237;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lt9Y79Nk4LiSf2GgssT6uA7q78x7mgqpEHX9ixLmMzc=;
        b=kmun4f7y3bwnvZgi2j1uOFPemTUyyLi5XgBfZmnHhd+1gXgfrw15/ZdHpncsq5jto3
         Vi1FsODYVmv37C584PEbVkkMhlnx/gSQrw7uvfDbcatRVLv0gMYxnwveKZocj+S8CllC
         4cRZy7B/IKI2qzTuwdHlyeJq3IisAk2KAKe9MUZKy8/9Cw787THeVdbXHHM4l04mIqK5
         3EYcpZOAqecZ3NWV5qQxoXGbq5R/iJCmnI21E+WwS6kcQknmAoYbCjCV8z9a1FrIRfHG
         hOSrcQgNGm0CmrDKKwWrcGjG+/DUVJqneECrv4FUQ390QUZUtDVHx03/NaMMEsfZC5WM
         QzOg==
X-Forwarded-Encrypted: i=1; AJvYcCXlqz8OMhhP9HqrsM5KOnJT9P2y/sk0SvLqQL/YkDoXPmx6t7pUwWwMT7W+US+BgwhAFfFXVsY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy5w4aYXR1eD6DXfdf3r0rszOPBBFwXkgmsqmUFtFKWQk9wengu
	YfjEZEm/ukA1ABjh+8akJJi8WbpKX83RpTEJmiV9Pyu1I5mKdzrcO/UJxmTBbTlf439IrYZVjEi
	8AWgv66fGUE73zxjNV4hBKL0lPc7Pu83omtcj2S7WBQxiO4XyoWgUwKfD+2E=
X-Google-Smtp-Source: AGHT+IFF1c4jMnaZLD2CuyKx2+YFZWYALwSa06aMHpXZj51UMHBHDBkR9SGNwuehb7iMIMXY4YgoYJG6+8Bqt3pAssdWU43q/3Nd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:349f:b0:3dc:7b3d:6a45 with SMTP id
 e9e14a558f8ab-3e13457dbaamr17061185ab.0.1751606437671; Thu, 03 Jul 2025
 22:20:37 -0700 (PDT)
Date: Thu, 03 Jul 2025 22:20:37 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <686764a5.a00a0220.c7b3.0014.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in drr_qlen_notify
From: syzbot <syzbot+15b96fc3aac35468fe77@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jhs@mojatatu.com, jiri@resnulli.us, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, xiyou.wangcong@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    17bbde2e1716 Merge tag 'net-6.16-rc5' of git://git.kernel...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1533f770580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8b0724e6945b4773
dashboard link: https://syzkaller.appspot.com/bug?extid=15b96fc3aac35468fe77
compiler:       gcc (Debian 12.2.0-14+deb12u1) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14044c8c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=14840c8c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/62107140ac32/disk-17bbde2e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/72e5df2d1649/vmlinux-17bbde2e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e906bf8ebf5c/bzImage-17bbde2e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+15b96fc3aac35468fe77@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 1 UID: 0 PID: 5817 Comm: syz-executor457 Not tainted 6.16.0-rc4-syzkaller-00108-g17bbde2e1716 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:__list_del_entry_valid_or_report+0x20/0x200 lib/list_debug.c:49
Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 41 54 55 53 48 89 fb 48 83 c7 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 8b 01 00 00 48 89 da 48 8b 6b 08 48 b8 00 00 00
RSP: 0018:ffffc9000410f2e8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000050 RCX: 1ffff1100f97af5c
RDX: 000000000000000b RSI: ffffffff898bef4c RDI: 0000000000000058
RBP: 0000000000000050 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000000a0000 R11: 0000000000000001 R12: ffffffff8ce802e0
R13: 0000000000000058 R14: ffffffff8ce802c0 R15: ffff88807cbd7800
FS:  000055557a6d4380(0000) GS:ffff888124852000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001fc0 CR3: 00000000721d4000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __list_del_entry_valid include/linux/list.h:124 [inline]
 __list_del_entry include/linux/list.h:215 [inline]
 list_del_init include/linux/list.h:287 [inline]
 drr_qlen_notify+0x24/0x150 net/sched/sch_drr.c:238
 qdisc_tree_reduce_backlog+0x221/0x500 net/sched/sch_api.c:811
 pie_change+0x86e/0xe70 net/sched/sch_pie.c:204
 pie_init+0x364/0x470 net/sched/sch_pie.c:456
 qdisc_create+0x454/0xfc0 net/sched/sch_api.c:1324
 __tc_modify_qdisc net/sched/sch_api.c:1749 [inline]
 tc_modify_qdisc+0x12bb/0x2130 net/sched/sch_api.c:1813
 rtnetlink_rcv_msg+0x3c6/0xe90 net/core/rtnetlink.c:6953
 netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2534
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x53d/0x7f0 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg net/socket.c:727 [inline]
 ____sys_sendmsg+0xa98/0xc70 net/socket.c:2566
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2620
 __sys_sendmsg+0x16d/0x220 net/socket.c:2652
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x4c0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f9cedcdb669
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffd67f881b8 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ffd67f88388 RCX: 00007f9cedcdb669
RDX: 0000000000004000 RSI: 0000200000000280 RDI: 0000000000000006
RBP: 00007f9cedd4e610 R08: 0000000000000004 R09: 00007ffd67f88388
R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffd67f88378 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__list_del_entry_valid_or_report+0x20/0x200 lib/list_debug.c:49
Code: 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 48 b8 00 00 00 00 00 fc ff df 41 54 55 53 48 89 fb 48 83 c7 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 8b 01 00 00 48 89 da 48 8b 6b 08 48 b8 00 00 00
RSP: 0018:ffffc9000410f2e8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000050 RCX: 1ffff1100f97af5c
RDX: 000000000000000b RSI: ffffffff898bef4c RDI: 0000000000000058
RBP: 0000000000000050 R08: 0000000000000005 R09: 0000000000000000
R10: 00000000000a0000 R11: 0000000000000001 R12: ffffffff8ce802e0
R13: 0000000000000058 R14: ffffffff8ce802c0 R15: ffff88807cbd7800
FS:  000055557a6d4380(0000) GS:ffff888124852000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000200000001fc0 CR3: 00000000721d4000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	90                   	nop
   a:	f3 0f 1e fa          	endbr64
   e:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  15:	fc ff df
  18:	41 54                	push   %r12
  1a:	55                   	push   %rbp
  1b:	53                   	push   %rbx
  1c:	48 89 fb             	mov    %rdi,%rbx
  1f:	48 83 c7 08          	add    $0x8,%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 8b 01 00 00    	jne    0x1bf
  34:	48 89 da             	mov    %rbx,%rdx
  37:	48 8b 6b 08          	mov    0x8(%rbx),%rbp
  3b:	48                   	rex.W
  3c:	b8                   	.byte 0xb8
  3d:	00 00                	add    %al,(%rax)


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


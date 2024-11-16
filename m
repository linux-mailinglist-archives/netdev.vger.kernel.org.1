Return-Path: <netdev+bounces-145551-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 092BF9CFCE6
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 07:37:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 825AB1F21A45
	for <lists+netdev@lfdr.de>; Sat, 16 Nov 2024 06:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF3F190685;
	Sat, 16 Nov 2024 06:37:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 365B918C004
	for <netdev@vger.kernel.org>; Sat, 16 Nov 2024 06:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731739059; cv=none; b=QXDuo3KW8xyW6ezheMFjPh0i1mNtLHu+Tr9mrxVYL/77ddIByV7uDqxCJZETOBoPeZ0/h4DnmXsnekXP0iChgEPZKhUv8dfrnrBjsYXVBS94AEbZxuvwV8+GsN8Y+x73jnqFsclbNS3A8GjJstjk9RD/1maLut/Y+/W4ixxaLN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731739059; c=relaxed/simple;
	bh=Ck68tQPdvnIuA5/4Z9IWdU3phhAhwllxAbrgvISPpy8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Wf9Itw4ysAUm/CfmXhyPrD6+95/5lE9ThA9+asHRrbe+ZoXFRuHvpdVM+LyaHDoCMVf8svR/13z+YJgAGcVL+qUsG3KD2dH1ely74d+Qczoqu0hd6Hep0oPwC2xTqlvvp6lWDXXp0amp4yuKR/k+v541N92nDx3qL9Kr67wm9D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a753606bbcso1950875ab.1
        for <netdev@vger.kernel.org>; Fri, 15 Nov 2024 22:37:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731739057; x=1732343857;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OYO6fy/yAOPEBTr5iXKStG5hCr8eX/ccSp7+gS/GZds=;
        b=Aq5yqI0uqGVwriQ4+aB4JWDPU8B2ESnDDUFITw38iSbRAv9E5xojelulZO6ZJ1iXtj
         f16ilFKs67TgIceioGOaPhvdXaVNgcjxOEOxAzzLb8clCqPQnI5m1lSmsoI7hnARoU1N
         4f0gSa0EGN1qTF3XZoM4ftKg17EVF1m6Stcs4ssG8MY6m2+IUvbbWGnXoxih2PPbZwGx
         nTQPktfc/UDj0nlmfbdaVkqZcUHqkpInREcetuUkjU0ixuUfu8WbbJsjOyTicyqQkcCD
         EZsUA94N2p9aEwgn2F8sox+9zHnYvSkEs836MxVmsbiGJOKSDTWYGcpyy8peEZvRwd7L
         fNEg==
X-Forwarded-Encrypted: i=1; AJvYcCV+OM9/qx7PZV3Vr7yDnw2dfeEgrXhqcEdkwUivSKplANZRu1ypdURnx+zbvCboELFFXpP0mcw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1/hSki88QyMfH1eP2mMXfGBbmuz54Y09OXV/0PiJnxGjo8VNk
	cur9IV9L+Fop/eHwnO9qkSwKinXjtpOoUonlSBQeOyY8ouuFmerb2/LJWRMEuKqYsKp0cZaPzp4
	Tf5BJP76QZWE8sWyMbpfYsj0Em7hXzIy3wSK+R06NU3pe+GM+r+cyIBw=
X-Google-Smtp-Source: AGHT+IGINyvMBQPURN/YiDCs4J65gbCKDZBVTWDAsdnkgxIxhGVbEfRrWm8ETKflwDFS9hCnsgKwL15hvFEQwBdRkHnUJ1TyKj5A
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d1c:b0:3a7:2b12:78dd with SMTP id
 e9e14a558f8ab-3a7480234f3mr48582975ab.11.1731739057156; Fri, 15 Nov 2024
 22:37:37 -0800 (PST)
Date: Fri, 15 Nov 2024 22:37:37 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67383db1.050a0220.85a0.000e.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in dev_prep_valid_name
From: syzbot <syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, csander@purestorage.com, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, parav@nvidia.com, 
	saeedm@nvidia.com, syzkaller-bugs@googlegroups.com, tariqt@nvidia.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    80b6f094756f Merge branch 'suspend-irqs-during-application..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16b80ce8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=ea5200d154f868aa
dashboard link: https://syzkaller.appspot.com/bug?extid=21ba4d5adff0b6a7cfc6
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=107dfe30580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=147dfe30580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1460e7e4f91a/disk-80b6f094.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9375c3c40003/vmlinux-80b6f094.xz
kernel image: https://storage.googleapis.com/syzbot-assets/33f29f155ac1/bzImage-80b6f094.xz

The issue was bisected to:

commit 0ac20437412bfc48d67d33eb4be139eafa4a0800
Author: Caleb Sander Mateos <csander@purestorage.com>
Date:   Tue Nov 5 20:39:59 2024 +0000

    mlx5/core: Schedule EQ comp tasklet only if necessary

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=12a981a7980000
console output: https://syzkaller.appspot.com/x/log.txt?x=16a981a7980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+21ba4d5adff0b6a7cfc6@syzkaller.appspotmail.com
Fixes: 0ac20437412b ("mlx5/core: Schedule EQ comp tasklet only if necessary")

Oops: general protection fault, probably for non-canonical address 0xdffffc000000004c: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000260-0x0000000000000267]
CPU: 0 UID: 0 PID: 5944 Comm: syz-executor276 Not tainted 6.12.0-rc6-syzkaller-01329-g80b6f094756f #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:dev_prep_valid_name+0x3e3/0xa40 net/core/dev.c:1165
Code: 20 08 00 00 e8 6e 50 27 fb 48 85 c0 0f 84 8f 04 00 00 48 89 44 24 38 48 8b 5c 24 30 48 81 c3 68 02 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 ce d4 6b f8 48 8b 03 48 89 5c 24
RSP: 0018:ffffc90004266940 EFLAGS: 00010203
RAX: 000000000000004c RBX: 0000000000000265 RCX: 0000000000002000
RDX: 0000000000001000 RSI: ffffffff8c610a80 RDI: ffffffff8c610a40
RBP: ffffc90004266a50 R08: 0000000000000920 R09: 00000000ffffffff
R10: dffffc0000000000 R11: fffffbfff203ac56 R12: dffffc0000000000
R13: 1ffff9200084cd38 R14: ffff88802172e126 R15: 1ffff9200084cd34
FS:  00007ff6558636c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff655821d58 CR3: 0000000012380000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 dev_get_valid_name net/core/dev.c:1199 [inline]
 register_netdevice+0x542/0x1b00 net/core/dev.c:10509
 veth_newlink+0x455/0xc10 drivers/net/veth.c:1819
 rtnl_newlink_create+0x2df/0xa30 net/core/rtnetlink.c:3774
 __rtnl_newlink net/core/rtnetlink.c:3891 [inline]
 rtnl_newlink+0x17dd/0x24f0 net/core/rtnetlink.c:4001
 rtnetlink_rcv_msg+0x791/0xcf0 net/core/rtnetlink.c:6903
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2551
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:729 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:744
 ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2609
 ___sys_sendmsg net/socket.c:2663 [inline]
 __sys_sendmsg+0x292/0x380 net/socket.c:2692
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff6558ea759
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 51 18 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ff655863218 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007ff655974368 RCX: 00007ff6558ea759
RDX: 0000000000000000 RSI: 0000000020000000 RDI: 0000000000000006
RBP: 00007ff655974360 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000009 R11: 0000000000000246 R12: 00007ff65597436c
R13: 00007ff655941074 R14: 006e75742f74656e R15: 74656e2f7665642f
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dev_prep_valid_name+0x3e3/0xa40 net/core/dev.c:1165
Code: 20 08 00 00 e8 6e 50 27 fb 48 85 c0 0f 84 8f 04 00 00 48 89 44 24 38 48 8b 5c 24 30 48 81 c3 68 02 00 00 48 89 d8 48 c1 e8 03 <42> 80 3c 20 00 74 08 48 89 df e8 ce d4 6b f8 48 8b 03 48 89 5c 24
RSP: 0018:ffffc90004266940 EFLAGS: 00010203
RAX: 000000000000004c RBX: 0000000000000265 RCX: 0000000000002000
RDX: 0000000000001000 RSI: ffffffff8c610a80 RDI: ffffffff8c610a40
RBP: ffffc90004266a50 R08: 0000000000000920 R09: 00000000ffffffff
R10: dffffc0000000000 R11: fffffbfff203ac56 R12: dffffc0000000000
R13: 1ffff9200084cd38 R14: ffff88802172e126 R15: 1ffff9200084cd34
FS:  00007ff6558636c0(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ff655821d58 CR3: 0000000012380000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	20 08                	and    %cl,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	e8 6e 50 27 fb       	call   0xfb275077
   9:	48 85 c0             	test   %rax,%rax
   c:	0f 84 8f 04 00 00    	je     0x4a1
  12:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
  17:	48 8b 5c 24 30       	mov    0x30(%rsp),%rbx
  1c:	48 81 c3 68 02 00 00 	add    $0x268,%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 80 3c 20 00       	cmpb   $0x0,(%rax,%r12,1) <-- trapping instruction
  2f:	74 08                	je     0x39
  31:	48 89 df             	mov    %rbx,%rdi
  34:	e8 ce d4 6b f8       	call   0xf86bd507
  39:	48 8b 03             	mov    (%rbx),%rax
  3c:	48                   	rex.W
  3d:	89                   	.byte 0x89
  3e:	5c                   	pop    %rsp
  3f:	24                   	.byte 0x24


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


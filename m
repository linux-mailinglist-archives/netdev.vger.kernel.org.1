Return-Path: <netdev+bounces-147494-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F07BA9D9DF3
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 20:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 834B91637B9
	for <lists+netdev@lfdr.de>; Tue, 26 Nov 2024 19:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F0E31DE4C0;
	Tue, 26 Nov 2024 19:20:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF311DE3A3
	for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732648833; cv=none; b=CgcpK7eR+BjO1C6pUzJTV5tkbdAEKV37dq8qdcXL/0ROx3u5sEnnQuQduIFmI5JVMnJ/RN5RPUBNt98PowEFy0Eb7KkO5zE9fqCsPCRFLzMpIUhcjWoaPC3UGwO7FEmyfZj4v85k7drBdYuXMBve3e0/FGjLtCi17yGg/VSwmOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732648833; c=relaxed/simple;
	bh=jFyZwsGMCU8FrvPZWoFpE+DRWymecF9cykm/vJJKUuc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Um0yU6J6ZAyxSuEHSIgUIc80a0eil9P/yJ73/l63dJMbICQp5m1CamE6tIFdqo7JHD6cg9Egq/8hG8u04VBcuMsCxwM51FUm5W8VPj8a4/hJdiPulysRu43bA14ZZi+W/kTYJVJ7uMgSXMYGiofCBGOgruOsYsvoBSHPzUxnweA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-843eb4505e7so54258939f.0
        for <netdev@vger.kernel.org>; Tue, 26 Nov 2024 11:20:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732648831; x=1733253631;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1S8FvUc7VFQlT6fVHyI7KjfQfQED//ewUahkBiaLpU=;
        b=f6ZvzXACNM0FZmVsMaQM5pt049yUzVEEoIhfUksueC83pK8RFF3Rg8N70l85EeRwNK
         4lqPnimxWOEYZJbN6fFo+gwRpfEK1CPW6EDhOtjeIXZkC2OI1C1ucJJac+NBej9QYAmj
         jMhzpNz/9RZ7Ue7QSFTjFq1eHHzG7fsz3CZGWXB4asZdjWereVxlPH9VzNUoe5pkKfOg
         GjYwoXSrZA7XDLjwM5vmTugSPl2+yuJfRjcbPgAbLFnIjHMlJCP7N5/ZYKqGYw2l+AU5
         enYf/0o+qYaWE4CSt/WG32h+jG5/Uw8rLQMk2o9pcY04I43LtDsnc1CkF61joRXSZTQd
         I9+A==
X-Forwarded-Encrypted: i=1; AJvYcCUYGvKD85FIB4uXZeaxbxRVFZcRBKnnsjiWWQGKqmBpuk+MffB0SZLzsgl7ig1Y21L5kibmmEE=@vger.kernel.org
X-Gm-Message-State: AOJu0YynyDvzZzZlNUEDaL39UM8JEYqxrz1/qZdvxs2az46Uk1z+Vcu6
	B6Lr+8OC+DMz2pDp+hpZaA0kxEL6w0b/+va48H7wl7HZCfLelkFsiQH3UD6tXqNSIgGtcgiAFAl
	v3y6134bZ3c4D26l2AVCpPS7flXM1bvaim39dTZi5PYkGNjjn7Co8hpU=
X-Google-Smtp-Source: AGHT+IFNW3dg0ifccr/8C83+Wzy+xf77E2fHLFU6G9uJNr38nFIEFwUfwR+rwz0nb8o5Uv15WMfLvwdc/fvzWxSbUU70F1Lg744u
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a87:b0:3a7:7ec0:a3dc with SMTP id
 e9e14a558f8ab-3a7c557d4abmr2159745ab.14.1732648831107; Tue, 26 Nov 2024
 11:20:31 -0800 (PST)
Date: Tue, 26 Nov 2024 11:20:31 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67461f7f.050a0220.1286eb.0021.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in modify_prefix_route
From: syzbot <syzbot+1de74b0794c40c8eb300@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    7eef7e306d3c Merge tag 'for-6.13/dm-changes' of git://git...
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=12f4d778580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3c44a32edb32752c
dashboard link: https://syzkaller.appspot.com/bug?extid=1de74b0794c40c8eb300
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=142375c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=146f1530580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9177dd9a0902/disk-7eef7e30.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f090c1d25c15/vmlinux-7eef7e30.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1a031b77d55e/bzImage-7eef7e30.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1de74b0794c40c8eb300@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000006: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000030-0x0000000000000037]
CPU: 1 UID: 0 PID: 5837 Comm: syz-executor888 Not tainted 6.12.0-syzkaller-09567-g7eef7e306d3c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
RIP: 0010:__lock_acquire+0xe4/0x3c40 kernel/locking/lockdep.c:5089
Code: 08 84 d2 0f 85 15 14 00 00 44 8b 0d ca 98 f5 0e 45 85 c9 0f 84 b4 0e 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 96 2c 00 00 49 8b 04 24 48 3d a0 07 7f 93 0f 84
RSP: 0018:ffffc900035d7268 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000006 RSI: 1ffff920006bae5f RDI: 0000000000000030
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff90608e17 R11: 0000000000000001 R12: 0000000000000030
R13: ffff888036334880 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555579e90380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc59cc4278 CR3: 0000000072b54000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 __raw_spin_lock_bh include/linux/spinlock_api_smp.h:126 [inline]
 _raw_spin_lock_bh+0x33/0x40 kernel/locking/spinlock.c:178
 spin_lock_bh include/linux/spinlock.h:356 [inline]
 modify_prefix_route+0x30b/0x8b0 net/ipv6/addrconf.c:4831
 inet6_addr_modify net/ipv6/addrconf.c:4923 [inline]
 inet6_rtm_newaddr+0x12c7/0x1ab0 net/ipv6/addrconf.c:5055
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6920
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2541
 netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
 netlink_unicast+0x53c/0x7f0 net/netlink/af_netlink.c:1347
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1891
 sock_sendmsg_nosec net/socket.c:711 [inline]
 __sock_sendmsg net/socket.c:726 [inline]
 ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2583
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2637
 __sys_sendmsg+0x16e/0x220 net/socket.c:2669
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fd1dcef8b79
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 c1 17 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc59cc4378 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007fd1dcef8b79
RDX: 0000000000040040 RSI: 0000000020000140 RDI: 0000000000000004
RBP: 00000000000113fd R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 00007ffc59cc438c
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xe4/0x3c40 kernel/locking/lockdep.c:5089
Code: 08 84 d2 0f 85 15 14 00 00 44 8b 0d ca 98 f5 0e 45 85 c9 0f 84 b4 0e 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 96 2c 00 00 49 8b 04 24 48 3d a0 07 7f 93 0f 84
RSP: 0018:ffffc900035d7268 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000006 RSI: 1ffff920006bae5f RDI: 0000000000000030
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff90608e17 R11: 0000000000000001 R12: 0000000000000030
R13: ffff888036334880 R14: 0000000000000000 R15: 0000000000000000
FS:  0000555579e90380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffc59cc4278 CR3: 0000000072b54000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	08 84 d2 0f 85 15 14 	or     %al,0x1415850f(%rdx,%rdx,8)
   7:	00 00                	add    %al,(%rax)
   9:	44 8b 0d ca 98 f5 0e 	mov    0xef598ca(%rip),%r9d        # 0xef598da
  10:	45 85 c9             	test   %r9d,%r9d
  13:	0f 84 b4 0e 00 00    	je     0xecd
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	4c 89 e2             	mov    %r12,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 96 2c 00 00    	jne    0x2cca
  34:	49 8b 04 24          	mov    (%r12),%rax
  38:	48 3d a0 07 7f 93    	cmp    $0xffffffff937f07a0,%rax
  3e:	0f                   	.byte 0xf
  3f:	84                   	.byte 0x84


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


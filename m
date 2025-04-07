Return-Path: <netdev+bounces-179511-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A356BA7D3AF
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 07:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BB433AD21C
	for <lists+netdev@lfdr.de>; Mon,  7 Apr 2025 05:56:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5840224898;
	Mon,  7 Apr 2025 05:56:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB97D224889
	for <netdev@vger.kernel.org>; Mon,  7 Apr 2025 05:56:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744005387; cv=none; b=Dmj8IpdcMBEO87qhggG8ECKMnGkO814TZ/BaSGDQljmWzevLTVoaJNEwnNMJpARwHHxr4gj2/jKTzTIYQQ4CV+UO39K5iY8hnuv1YivB+0AuI+ls8jHgUJusd0w17ok91QqQedokhSIfAugUzPayHPhhe0c2TJ3Hok9LK1nOwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744005387; c=relaxed/simple;
	bh=oPE/v4Ou6YdLTqzu51Pe3x8Wz1KWV5ob1OqG4ZfB60c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=tKNtBNPW7VZBtWk1cMkRlr6h3rWa47DZILKHbL8jbIvmDQRD5d1uEYpDb7TE6pYhDRe2soQGicgzn1FsJQnrImnVmZcEHIKuIA0ngbkgnEkxn/TPV//pt5rJLZM9UffzCImI8yZYtYhroAWoP4MHxHfEmYyWwtsAd34VwhDLY4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3d43541a706so40604595ab.1
        for <netdev@vger.kernel.org>; Sun, 06 Apr 2025 22:56:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744005385; x=1744610185;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XZIIP6HgLWh/MexcNyctpVK2wOOuoNDXpmATMayLrJs=;
        b=AHh/ineGEndb4kezCifbLDrGbh0+Oe+gT1Pc3be/5cHwBu0eZNltLf123Vnh3rkflg
         wc76fu8ygW1FqSu0tF3P17+YmU4K+rw4weBo2KoPcCf1DSu5+zzsMIcpxOULbpTYYcgy
         5I+tnMOqU7btlcLpVrtgYJ3g6xN/EiTBREIu/fwiNW/uiceora21/lKyO1MsaxaO9KO7
         DwsR8dmbmaMFfF7ali/42fMvX/6W05X5ktsKmhCbPoEnmvubviPL2DZCS69x2/Tqkyz/
         idoGE6fNVA2aDZSR+fYQ7EWQsebWauK7VGM48jVrGMVip+CU/fc6GaeEWKl2Lunm92+R
         j88w==
X-Forwarded-Encrypted: i=1; AJvYcCUGFt/mIMZs6amvi/OzMt43FU2RuYqsTd6awmw9HdEZJfSQa1lJ1hKHE9/5vo7FXmWcPa03nqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YysS5c2vxNCaakrY+qV/X95+8XZNhbsjQxoPexUQtnVBRaQpXuF
	dX5wB3w+R1Q1tOVNQUAWCduH0y9HLGLw/vPwQn7PVguwi+4NCoqwT9cijoOzjBS/nz4Gk1RQTzk
	lf7vAMLWB088VqmXj/1RCTwO0zmYnyhelYnAulHuQWzR4crg3Uk47DgU=
X-Google-Smtp-Source: AGHT+IHrstZnxPfOP/Zm6VKqxLPsrSAQq01qEn+nvdoVGiCvA1UYC6Fw+eDfXigZWAcRHOcgA5JWDx00btuPjBkyXyTBY3h4qC1U
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:198b:b0:3d5:8922:77a0 with SMTP id
 e9e14a558f8ab-3d6e576be5bmr111201205ab.18.1744005384913; Sun, 06 Apr 2025
 22:56:24 -0700 (PDT)
Date: Sun, 06 Apr 2025 22:56:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f36908.050a0220.0a13.027f.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in addrconf_add_ifaddr
From: syzbot <syzbot+10d145ea96fc91185445@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, kuniyu@amazon.com, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8bc251e5d874 Merge tag 'nf-25-04-03' of git://git.kernel.o..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=14981178580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=24f9c4330e7c0609
dashboard link: https://syzkaller.appspot.com/bug?extid=10d145ea96fc91185445
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=120f023f980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e5c94c580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/a500d5daba83/disk-8bc251e5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/2459c792199a/vmlinux-8bc251e5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/558655fb055e/bzImage-8bc251e5.xz

The issue was bisected to:

commit 8965c160b8f7333df895321c8aa6bad4a7175f2b
Author: Stanislav Fomichev <sdf@fomichev.me>
Date:   Tue Apr 1 16:34:44 2025 +0000

    net: use netif_disable_lro in ipv6_add_dev

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=1334423f980000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=10b4423f980000
console output: https://syzkaller.appspot.com/x/log.txt?x=1734423f980000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+10d145ea96fc91185445@syzkaller.appspotmail.com
Fixes: 8965c160b8f7 ("net: use netif_disable_lro in ipv6_add_dev")

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000198: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000cc0-0x0000000000000cc7]
CPU: 1 UID: 0 PID: 5850 Comm: syz-executor155 Not tainted 6.14.0-syzkaller-12504-g8bc251e5d874 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:netdev_need_ops_lock include/net/netdev_lock.h:30 [inline]
RIP: 0010:netdev_lock_ops include/net/netdev_lock.h:41 [inline]
RIP: 0010:addrconf_add_ifaddr+0x23e/0x590 net/ipv6/addrconf.c:3157
Code: 03 00 00 8b b4 24 c4 00 00 00 48 8b 7c 24 18 e8 18 a3 25 ff 49 89 c5 48 8d 98 c5 0c 00 00 48 89 d8 48 c1 e8 03 48 89 44 24 38 <42> 0f b6 04 20 84 c0 0f 85 03 03 00 00 48 89 5c 24 28 0f b6 1b 31
RSP: 0018:ffffc90003f3fa00 EFLAGS: 00010203
RAX: 0000000000000198 RBX: 0000000000000cc5 RCX: ffff88807bf51e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9ac50c80
RBP: ffffc90003f3fb50 R08: ffffffff905fc777 R09: 1ffffffff20bf8ee
R10: dffffc0000000000 R11: fffffbfff20bf8ef R12: dffffc0000000000
R13: 0000000000000000 R14: 00002000000000c0 R15: 1ffff920007e7f48
FS:  0000555559d6c380(0000) GS:ffff888125099000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000000c2 CR3: 000000003508e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 inet6_ioctl+0x148/0x280 net/ipv6/af_inet6.c:580
 sock_do_ioctl+0x15a/0x490 net/socket.c:1190
 sock_ioctl+0x644/0x900 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl+0xf1/0x160 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7ff0337e62e9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffdf3f7f118 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007ffdf3f7f2e8 RCX: 00007ff0337e62e9
RDX: 00002000000000c0 RSI: 0000000000008916 RDI: 0000000000000003
RBP: 00007ff033859610 R08: 0000000000000000 R09: 00007ffdf3f7f2e8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffdf3f7f2d8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:netdev_need_ops_lock include/net/netdev_lock.h:30 [inline]
RIP: 0010:netdev_lock_ops include/net/netdev_lock.h:41 [inline]
RIP: 0010:addrconf_add_ifaddr+0x23e/0x590 net/ipv6/addrconf.c:3157
Code: 03 00 00 8b b4 24 c4 00 00 00 48 8b 7c 24 18 e8 18 a3 25 ff 49 89 c5 48 8d 98 c5 0c 00 00 48 89 d8 48 c1 e8 03 48 89 44 24 38 <42> 0f b6 04 20 84 c0 0f 85 03 03 00 00 48 89 5c 24 28 0f b6 1b 31
RSP: 0018:ffffc90003f3fa00 EFLAGS: 00010203
RAX: 0000000000000198 RBX: 0000000000000cc5 RCX: ffff88807bf51e00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9ac50c80
RBP: ffffc90003f3fb50 R08: ffffffff905fc777 R09: 1ffffffff20bf8ee
R10: dffffc0000000000 R11: fffffbfff20bf8ef R12: dffffc0000000000
R13: 0000000000000000 R14: 00002000000000c0 R15: 1ffff920007e7f48
FS:  0000555559d6c380(0000) GS:ffff888124f99000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000004585c0 CR3: 000000003508e000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	03 00                	add    (%rax),%eax
   2:	00 8b b4 24 c4 00    	add    %cl,0xc424b4(%rbx)
   8:	00 00                	add    %al,(%rax)
   a:	48 8b 7c 24 18       	mov    0x18(%rsp),%rdi
   f:	e8 18 a3 25 ff       	call   0xff25a32c
  14:	49 89 c5             	mov    %rax,%r13
  17:	48 8d 98 c5 0c 00 00 	lea    0xcc5(%rax),%rbx
  1e:	48 89 d8             	mov    %rbx,%rax
  21:	48 c1 e8 03          	shr    $0x3,%rax
  25:	48 89 44 24 38       	mov    %rax,0x38(%rsp)
* 2a:	42 0f b6 04 20       	movzbl (%rax,%r12,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 03 03 00 00    	jne    0x33a
  37:	48 89 5c 24 28       	mov    %rbx,0x28(%rsp)
  3c:	0f b6 1b             	movzbl (%rbx),%ebx
  3f:	31                   	.byte 0x31


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


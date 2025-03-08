Return-Path: <netdev+bounces-173115-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4916BA57664
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 01:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 753F9178988
	for <lists+netdev@lfdr.de>; Sat,  8 Mar 2025 00:00:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF6D137E;
	Sat,  8 Mar 2025 00:00:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBE5C196
	for <netdev@vger.kernel.org>; Sat,  8 Mar 2025 00:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741392026; cv=none; b=fnDaDoul1loFHBoeZI+5pccjX9CYU0qBSSL7USp4gKCatQeceCJy2VP3sD2QtnJxgdCwY6cWQnofecQfeSnecjHtYV9oYbvoqzmDzkUhsRjoWLyVZLOEBaeH/N0jhZHnW0Zcx2EmWsJvslY6foM8OwVYxCQbSWYF9iOZb+LerLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741392026; c=relaxed/simple;
	bh=v6slMHCYLzPdcLMFd2g5nZGhK9UmQ+tT7FnDRGrFyPw=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=pQHRZ5RYYYMRmLCIvVth2+jzU3qj/s3wbBuw12wu61zdfowWAzagmfD1zao+na+9YCWAkaeTB6I6k4Qz9I/OEXoFCyKoi4WX3KYPPzKIBoKLv0JBWup5t8HwEc3z18/o1uEVXRXjIfmMXK+BlTpHWFiuzjYbWN4V+zgvl/qTW0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-85ae7173dc2so178924239f.3
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 16:00:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741392024; x=1741996824;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xBXX9MfaAjMFm+uUXLqcw3Ll98usKwdrx7VRig+czK4=;
        b=iMlNbo4LZUH+D+EURLzMuZiuGJOPoKnQX8t8iWGkmhV8MJbVMgursNiyhe7H9P8iWM
         quH7dSlruMSzYgymIrJnbUl6OuMiwDIhoSQwSYNU4bXZCksrSxbTXLzw/w3Be7pHnBmT
         FS7WFoIEJxJRxRArl14rhMKRvy9Zd6v5Jlb3S1kI2Ws2L2uZf8gXj2i+8wQrVnRHb3j1
         eoAK2LwvoVhC8QaSZSJ3RLI6GNXpwZiNebzZxU79P9mscf+/WZynxkWyLPe6m93jibjq
         ayCxyf3bYmnvVCN13ItyNvAdkDRPMa63KVPXgLFYdiRCSL70lZzRYjrafXJB4Ftsu1ZK
         7IEQ==
X-Forwarded-Encrypted: i=1; AJvYcCXVdeKR2Fj9Md2Fio3lSkfN1XTcAh3bg+eDti2mZisxsXFa8RPi4O89ddkWMrD9wj3bJrDq/Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy36ydToom+UsptAQ/PjIn1uRQQLKbjNWIHKW8KoVWEDiVXazMy
	VCE5H6qgP8kd/EK4lqrVrgkHQb1bbca4z7NTvUpSwF7w/NtLUE5P4vPxe3MrKLum3NfYT47pY3Y
	SYTisLd0EMcgmSj1sPj/9JsxgwGhyV4c6m+qYYKA+djjQ1cYRuYoSlM8=
X-Google-Smtp-Source: AGHT+IFsCt5/96+A7g4F0+REEz4Hpa0jmUnIJQBU6D5Tm4/3jsv1E8JlRjlGeyHaWid99WT/wdXgLIo8xR8P/vHHZ0R/Dq9QfiK1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:378d:b0:3d3:ddb3:fe4e with SMTP id
 e9e14a558f8ab-3d441973568mr47435175ab.13.1741392023918; Fri, 07 Mar 2025
 16:00:23 -0800 (PST)
Date: Fri, 07 Mar 2025 16:00:23 -0800
In-Reply-To: <67caaf5e.050a0220.15b4b9.007a.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67cb8897.050a0220.d8275.0228.GAE@google.com>
Subject: Re: [syzbot] [net?] general protection fault in ethnl_default_dumpit
From: syzbot <syzbot+3da2442641f0c6a705a2@syzkaller.appspotmail.com>
To: andrew@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	eric.dumazet@gmail.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	sdf@fomichev.me, stfomichev@gmail.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    2525e16a2bae Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17d9a4b7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=fbc61e4c6e816b7b
dashboard link: https://syzkaller.appspot.com/bug?extid=3da2442641f0c6a705a2
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14b2aa54580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=178283a8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bae047feb57e/disk-2525e16a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9f10529c6bdd/vmlinux-2525e16a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/8dcb6d0a6029/bzImage-2525e16a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3da2442641f0c6a705a2@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000197: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000cb8-0x0000000000000cbf]
CPU: 1 UID: 0 PID: 5830 Comm: syz-executor357 Not tainted 6.14.0-rc5-syzkaller-01064-g2525e16a2bae #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
RIP: 0010:netdev_need_ops_lock include/linux/netdevice.h:2792 [inline]
RIP: 0010:netdev_lock_ops include/linux/netdevice.h:2803 [inline]
RIP: 0010:ethnl_default_dump_one net/ethtool/netlink.c:557 [inline]
RIP: 0010:ethnl_default_dumpit+0x447/0xd40 net/ethtool/netlink.c:593
Code: 49 8b 1f 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 ca e6 17 f8 4c 8b 3b 49 8d 9f bd 0c 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 0f 85 4b 07 00 00 0f b6 1b 31 ff 89 de e8 f0
RSP: 0018:ffffc9000400f0d8 EFLAGS: 00010203
RAX: 0000000000000197 RBX: 0000000000000cbd RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8c80fdc0 RDI: 0000000000000001
RBP: ffff888033e5ac00 R08: ffffffff903d0b77 R09: 1ffffffff207a16e
R10: dffffc0000000000 R11: fffffbfff207a16f R12: ffff888144ad0600
R13: ffff88802fd3e140 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000555584194380(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000400000000a40 CR3: 00000000352bc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 genl_dumpit+0x10d/0x1b0 net/netlink/genetlink.c:1027
 netlink_dump+0x64d/0xe10 net/netlink/af_netlink.c:2309
 __netlink_dump_start+0x5a2/0x790 net/netlink/af_netlink.c:2424
 genl_family_rcv_msg_dumpit net/netlink/genetlink.c:1076 [inline]
 genl_family_rcv_msg net/netlink/genetlink.c:1192 [inline]
 genl_rcv_msg+0x894/0xec0 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x206/0x480 net/netlink/af_netlink.c:2534
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1313 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1339
 netlink_sendmsg+0x8de/0xcb0 net/netlink/af_netlink.c:1883
 sock_sendmsg_nosec net/socket.c:709 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:724
 ____sys_sendmsg+0x53a/0x860 net/socket.c:2564
 ___sys_sendmsg net/socket.c:2618 [inline]
 __sys_sendmsg+0x269/0x350 net/socket.c:2650
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdb90304329
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffa4264738 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fffa4264908 RCX: 00007fdb90304329
RDX: 0000000000000000 RSI: 0000400000000a40 RDI: 0000000000000003
RBP: 00007fdb90377610 R08: 0000000000000000 R09: 00007fffa4264908
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007fffa42648f8 R14: 0000000000000001 R15: 0000000000000001
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:netdev_need_ops_lock include/linux/netdevice.h:2792 [inline]
RIP: 0010:netdev_lock_ops include/linux/netdevice.h:2803 [inline]
RIP: 0010:ethnl_default_dump_one net/ethtool/netlink.c:557 [inline]
RIP: 0010:ethnl_default_dumpit+0x447/0xd40 net/ethtool/netlink.c:593
Code: 49 8b 1f 48 89 d8 48 c1 e8 03 42 80 3c 30 00 74 08 48 89 df e8 ca e6 17 f8 4c 8b 3b 49 8d 9f bd 0c 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 30 84 c0 0f 85 4b 07 00 00 0f b6 1b 31 ff 89 de e8 f0
RSP: 0018:ffffc9000400f0d8 EFLAGS: 00010203
RAX: 0000000000000197 RBX: 0000000000000cbd RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffffff8c80fdc0 RDI: 0000000000000001
RBP: ffff888033e5ac00 R08: ffffffff903d0b77 R09: 1ffffffff207a16e
R10: dffffc0000000000 R11: fffffbfff207a16f R12: ffff888144ad0600
R13: ffff88802fd3e140 R14: dffffc0000000000 R15: 0000000000000000
FS:  0000555584194380(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000000045ad50 CR3: 00000000352bc000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	49 8b 1f             	mov    (%r15),%rbx
   3:	48 89 d8             	mov    %rbx,%rax
   6:	48 c1 e8 03          	shr    $0x3,%rax
   a:	42 80 3c 30 00       	cmpb   $0x0,(%rax,%r14,1)
   f:	74 08                	je     0x19
  11:	48 89 df             	mov    %rbx,%rdi
  14:	e8 ca e6 17 f8       	call   0xf817e6e3
  19:	4c 8b 3b             	mov    (%rbx),%r15
  1c:	49 8d 9f bd 0c 00 00 	lea    0xcbd(%r15),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 30       	movzbl (%rax,%r14,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 4b 07 00 00    	jne    0x782
  37:	0f b6 1b             	movzbl (%rbx),%ebx
  3a:	31 ff                	xor    %edi,%edi
  3c:	89 de                	mov    %ebx,%esi
  3e:	e8                   	.byte 0xe8
  3f:	f0                   	lock


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


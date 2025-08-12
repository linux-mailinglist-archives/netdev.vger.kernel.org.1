Return-Path: <netdev+bounces-212842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE0DB223EF
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 12:01:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C0F1B6408B
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 10:00:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB4F2EBDD7;
	Tue, 12 Aug 2025 09:58:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3263F2EBBBE
	for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 09:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754992710; cv=none; b=OQaM97d4i2CFbWTbP6AephwFVRP+LeiWUsFHKtxwAaViDzf/87ga3jB0ORmu0pd0hrkiU2E/YmLTD5oWYAxXuFxhnRmaiKVvY/0mLESoclsRUAGnlMunHusRXFOYMJS+/tdTBlaFy9JRsJguSeUz/OMeuO4PRYQBFTrAT3rlpa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754992710; c=relaxed/simple;
	bh=r7mSyQ0z7nMO70bmb3MpBR16S5UNgKsvw+Xc27+uH+s=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=Nt8f9VdSUENo5QR8W+4tWiAHpab/bWGxEyPVMPbmFLEZT8sfGudCDtmm9OMua8Cajhc4zjVKgaoTm+r9dRFPCh5YGRg8AMFTYX5SlNRHogML83T5lIdiKFCKR4HiCumRmzA+bIXynUqT4WP1OLlEenedLJQkbg7gkEQQ18166/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-8818b1512c2so501189739f.2
        for <netdev@vger.kernel.org>; Tue, 12 Aug 2025 02:58:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754992708; x=1755597508;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ysq6mlzJlJJ+l6x4h2XtmTrPsIa/W821Kc60OZ5M50=;
        b=sc+ebMsxgK4tn5T8qw+pbkg2aXDHSp7v4PWwLbQV9bJhiNDPVRtLcXwPKdscl++ZXS
         1hwSOQHnRZpZ3t4vUyrKNF09WEpo1ZVdqEOJ7OyBhzjZZkDcXLpVE7JzMvXU+fIpCWrT
         nPZs4h+uLxBNt8aMne2errWumSwkf1EzMG5Op0buWgWL48lrHXIvaVjuVtieFq5tRarj
         2/aepWlUfQIoeHw/OIm7vpvfKfX7XZXpogptBxWa3+etk2YkqU2QOiVk6JG0pE/9HtnP
         8by+bHS3hgnkTS4IAsdJJhIe2IqLJfKAPmowmi4E1Zv0M9ogfg8Lj8JeqrMjgsqJsygB
         Uhkw==
X-Forwarded-Encrypted: i=1; AJvYcCWw8Bou19m7ujOQqxVsEyz8hIZULwCj8KopbigozshOKn5hZeiOov4sRVD7yIMW6p7SIdcU0Ps=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhlIc/N5+Dmx1iAyyQ+6lOsLVHkhGRJ6K4/HhO2PKiAn+tmDoa
	A8NelExyaabLyvS7DRMTatH62ISg2koqcsWltSoN/sLo6H9toDrjU6TBm4tq/T8/Ra2ximspPMh
	qgY8tqueuM9Ij0fLNbVBZrHwRko0n4l3kvvNEYEa29C916CqkX8aW+y8KxKc=
X-Google-Smtp-Source: AGHT+IEniMM95uiwFvRb3CXKdVnQTkxGt6VdyOxeRBfQLHcmCpGXuYSd8J2TaxuInx/hVmwb5uznGxY25Leur3Zfqi9+F+8wU+IS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:158e:b0:881:962e:3169 with SMTP id
 ca18e2360f4ac-8841be43bfamr519349739f.3.1754992708426; Tue, 12 Aug 2025
 02:58:28 -0700 (PDT)
Date: Tue, 12 Aug 2025 02:58:28 -0700
In-Reply-To: <688bb9ca.a00a0220.26d0e1.0050.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689b1044.050a0220.7f033.011b.GAE@google.com>
Subject: Re: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_queue_free
From: syzbot <syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, andrew@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, kuni1840@gmail.com, kuniyu@google.com, 
	leitao@debian.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    53e760d89498 Merge tag 'nfsd-6.17-1' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16c415a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d67d3af29f50297e
dashboard link: https://syzkaller.appspot.com/bug?extid=8aa80c6232008f7b957d
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151be9a2580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-53e760d8.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7f26eabe958a/vmlinux-53e760d8.xz
kernel image: https://storage.googleapis.com/syzbot-assets/60128fb74c23/bzImage-53e760d8.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: ffff88808d211020
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 1a201067 P4D 1a201067 PUD 0 
Oops: Oops: 0002 [#1] SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 6665 Comm: syz.1.416 Not tainted 6.17.0-rc1-syzkaller-00004-g53e760d89498 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:local_add arch/x86/include/asm/local.h:33 [inline]
RIP: 0010:u64_stats_add include/linux/u64_stats_sync.h:89 [inline]
RIP: 0010:dev_dstats_rx_dropped_add include/linux/netdevice.h:3027 [inline]
RIP: 0010:nsim_queue_free+0xdc/0x150 drivers/net/netdevsim/netdev.c:714
Code: 10 1d be 8d 4c 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 4c 89 ff e8 db 1a 0d fb 49 8b 07 48 8b 0c 24 <4a> 01 4c 28 20 4c 89 f7 be 00 02 00 00 e8 72 5a 6d fa 4c 89 e7 be
RSP: 0018:ffffc9000d7bede0 EFLAGS: 00010246
RAX: ffff88808d211000 RBX: ffff888044417000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 0000000000000000 R08: ffffffff8e1e6327 R09: 1ffffffff1c3cc64
R10: dffffc0000000000 R11: fffffbfff1c3cc65 R12: ffff888044417218
R13: 0000000000000000 R14: ffffffff87178ba3 R15: ffffffff8dbe1d10
FS:  00007f7dce64a6c0(0000) GS:ffff88808d211000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88808d211020 CR3: 0000000059d35000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 nsim_queue_uninit drivers/net/netdevsim/netdev.c:993 [inline]
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1049 [inline]
 nsim_create+0xbbf/0xf10 drivers/net/netdevsim/netdev.c:1101
 __nsim_dev_port_add+0x6b6/0xb10 drivers/net/netdevsim/dev.c:1438
 nsim_dev_port_add_all+0x37/0xf0 drivers/net/netdevsim/dev.c:1494
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1546 [inline]
 nsim_dev_reload_up+0x451/0x780 drivers/net/netdevsim/dev.c:1003
 devlink_reload+0x4e9/0x8d0 net/devlink/dev.c:474
 devlink_nl_reload_doit+0xb35/0xd50 net/devlink/dev.c:584
 genl_family_rcv_msg_doit+0x215/0x300 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x60e/0x790 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x205/0x470 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x82c/0x9e0 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x805/0xb30 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg+0x21c/0x270 net/socket.c:729
 ____sys_sendmsg+0x505/0x830 net/socket.c:2614
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2668
 __sys_sendmsg net/socket.c:2700 [inline]
 __do_sys_sendmsg net/socket.c:2705 [inline]
 __se_sys_sendmsg net/socket.c:2703 [inline]
 __x64_sys_sendmsg+0x19b/0x260 net/socket.c:2703
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f7dcd78ebe9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f7dce64a038 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007f7dcd9b5fa0 RCX: 00007f7dcd78ebe9
RDX: 0000000000000000 RSI: 0000200000000080 RDI: 0000000000000003
RBP: 00007f7dcd811e19 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f7dcd9b6038 R14: 00007f7dcd9b5fa0 R15: 00007ffc4b525678
 </TASK>
Modules linked in:
CR2: ffff88808d211020
---[ end trace 0000000000000000 ]---
RIP: 0010:local_add arch/x86/include/asm/local.h:33 [inline]
RIP: 0010:u64_stats_add include/linux/u64_stats_sync.h:89 [inline]
RIP: 0010:dev_dstats_rx_dropped_add include/linux/netdevice.h:3027 [inline]
RIP: 0010:nsim_queue_free+0xdc/0x150 drivers/net/netdevsim/netdev.c:714
Code: 10 1d be 8d 4c 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 80 3c 08 00 74 08 4c 89 ff e8 db 1a 0d fb 49 8b 07 48 8b 0c 24 <4a> 01 4c 28 20 4c 89 f7 be 00 02 00 00 e8 72 5a 6d fa 4c 89 e7 be
RSP: 0018:ffffc9000d7bede0 EFLAGS: 00010246
RAX: ffff88808d211000 RBX: ffff888044417000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000008
RBP: 0000000000000000 R08: ffffffff8e1e6327 R09: 1ffffffff1c3cc64
R10: dffffc0000000000 R11: fffffbfff1c3cc65 R12: ffff888044417218
R13: 0000000000000000 R14: ffffffff87178ba3 R15: ffffffff8dbe1d10
FS:  00007f7dce64a6c0(0000) GS:ffff88808d211000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff88808d211020 CR3: 0000000059d35000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	10 1d be 8d 4c 89    	adc    %bl,-0x76b37242(%rip)        # 0x894c8dc4
   6:	f8                   	clc
   7:	48 c1 e8 03          	shr    $0x3,%rax
   b:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  12:	fc ff df
  15:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1)
  19:	74 08                	je     0x23
  1b:	4c 89 ff             	mov    %r15,%rdi
  1e:	e8 db 1a 0d fb       	call   0xfb0d1afe
  23:	49 8b 07             	mov    (%r15),%rax
  26:	48 8b 0c 24          	mov    (%rsp),%rcx
* 2a:	4a 01 4c 28 20       	add    %rcx,0x20(%rax,%r13,1) <-- trapping instruction
  2f:	4c 89 f7             	mov    %r14,%rdi
  32:	be 00 02 00 00       	mov    $0x200,%esi
  37:	e8 72 5a 6d fa       	call   0xfa6d5aae
  3c:	4c 89 e7             	mov    %r12,%rdi
  3f:	be                   	.byte 0xbe


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


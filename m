Return-Path: <netdev+bounces-211258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1825FB1762B
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 20:45:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0BA651AA65EF
	for <lists+netdev@lfdr.de>; Thu, 31 Jul 2025 18:45:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F4E23D298;
	Thu, 31 Jul 2025 18:45:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232FE15383A
	for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 18:45:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753987532; cv=none; b=XehJ2Yi0Wf0u/WVI/0/46UiNcume9jeC1RC/2q3R8ME8tYti8iar7unp07zO5OGI3n2wBHN0nESmk9LsUX1qnyqWU0Xa6WAzCFBH8Ef5nUfZUBcvGnvIsHlIAZ8SCQZxo05QyNG2Z0bQaghJspZIPTcuojkUZKGIHJM7NSE7yqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753987532; c=relaxed/simple;
	bh=WybObofEF6nvFywm2tz4HM5DS96jOaiXrn8n6S/LZZw=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=pC88Cy2yH50TQw0foF2PrVc9XO5eAVDrivwkaNZVhbEzNffmxs0tLzuEFQxZ+iTeiip+F5WC5TIcTkY4uXb7Ov+UhRcwqESE4BNq6shaxww10jZp+Jxq8vLAQdEi51Qg7Ff2h1sHTY5WP75PLeNMd5cEGfBD3kAgsJFQkfuq/IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-8814b2524c6so8745539f.1
        for <netdev@vger.kernel.org>; Thu, 31 Jul 2025 11:45:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753987530; x=1754592330;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jnMBY5RRXxi/8Sj7uoCzysAg7Y+uKqRraxHA6vwK1s0=;
        b=FRycYIddDCHzLkhbo3v150HhmR50kYs9frABmlZC37dhyeWS+5aB9BY5553DOGLDV1
         yw/BVyFuThV1Et6ERgUCktfVNOBRW28ZFknQN2109QUXSIWvNsSQSCE7vBTNWMY8HdnI
         sMokXfguwm1fo0HvbxOaIqxFmkJg0iEIwnUl7/m20IZb9m9nPWJYDJ3cbSkfEPG5aLC5
         hfz2+SnB58YRjjPHjIgkVmi4+eLDT1rEW10cDMf6C/amjGjG8JC6Y0STBrI33/BxHxXW
         u2U3Hd69Qmsu3ntySsPI3joJ4JX3+99fUIh/utwvVVybdv+xs+Exn4BMu64CjUTC9gfL
         XZTQ==
X-Forwarded-Encrypted: i=1; AJvYcCVtiH27aB+kmJDZY3pbeHwJzCTJh88eVf+nMDokJDWz2rFTzQDRk/0Zl4n4KvO6U9I+WYGczfU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpO+p/6BxDOkDdIWxo9g6bgI5MY2c5h7mjgOVVNBfJMA2zHEAg
	5PPRzBf8/JCXTuQCOE9VNuCqXJrX9wm6LMOyRVO3wUZ/mADVOzD8glGF4tdDEKLs8vU2c2DK1Z1
	bowBrbzjJKgHDObfYPu+DssZdQfFQyvircljLdT88G3KTqKeiDuHhdDUCsQg=
X-Google-Smtp-Source: AGHT+IGLcMun3G9jTmEapcqDIt8ajWP0D/9/CUplr4C2dNL9i7tLTD9mx1FjQhoNydTZ47Ibb+lGZ0ez2iP+gbpo6cVrjZnxO2KX
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:440c:20b0:3e3:d5f1:9019 with SMTP id
 e9e14a558f8ab-3e3f62a7e18mr96486075ab.16.1753987530301; Thu, 31 Jul 2025
 11:45:30 -0700 (PDT)
Date: Thu, 31 Jul 2025 11:45:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <688bb9ca.a00a0220.26d0e1.0050.GAE@google.com>
Subject: [syzbot] [net?] BUG: unable to handle kernel paging request in nsim_queue_free
From: syzbot <syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e8d780dcd957 Merge tag 'slab-for-6.17' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14382cf0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=c99a414773e8e8dd
dashboard link: https://syzkaller.appspot.com/bug?extid=8aa80c6232008f7b957d
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-e8d780dc.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9d67cb9a6476/vmlinux-e8d780dc.xz
kernel image: https://storage.googleapis.com/syzbot-assets/5b160fb5034b/bzImage-e8d780dc.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8aa80c6232008f7b957d@syzkaller.appspotmail.com

netdevsim netdevsim1 netdevsim2 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim1 netdevsim1 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
netdevsim netdevsim1 netdevsim0 (unregistering): unset [1, 0] type 2 family 0 port 6081 - 0
BUG: unable to handle page fault for address: ffff88809782c020
#PF: supervisor write access in kernel mode
#PF: error_code(0x0002) - not-present page
PGD 1b401067 P4D 1b401067 PUD 0 
Oops: Oops: 0002 [#1] SMP KASAN NOPTI
CPU: 3 UID: 0 PID: 8476 Comm: syz.1.251 Not tainted 6.16.0-syzkaller-06699-ge8d780dcd957 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:local_add arch/x86/include/asm/local.h:33 [inline]
RIP: 0010:u64_stats_add include/linux/u64_stats_sync.h:89 [inline]
RIP: 0010:dev_dstats_rx_dropped_add include/linux/netdevice.h:3027 [inline]
RIP: 0010:nsim_queue_free+0xba/0x120 drivers/net/netdevsim/netdev.c:714
Code: 07 77 6c 4a 8d 3c ed 20 7e f1 8d 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 46 4a 03 1c ed 20 7e f1 8d <4c> 01 63 20 be 00 02 00 00 48 8d 3d 00 00 00 00 e8 61 2f 58 fa 48
RSP: 0018:ffffc900044af150 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: ffff88809782c000 RCX: 00000000000079c3
RDX: 1ffffffff1be2fc7 RSI: ffffffff8c15f380 RDI: ffffffff8df17e38
RBP: ffff88805f59d000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000003 R14: ffff88806ceb3d00 R15: ffffed100dfd308e
FS:  0000000000000000(0000) GS:ffff88809782c000(0063) knlGS:00000000f505db40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffff88809782c020 CR3: 000000006fc6a000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 nsim_queue_uninit drivers/net/netdevsim/netdev.c:993 [inline]
 nsim_init_netdevsim drivers/net/netdevsim/netdev.c:1049 [inline]
 nsim_create+0xd0a/0x1260 drivers/net/netdevsim/netdev.c:1101
 __nsim_dev_port_add+0x435/0x7d0 drivers/net/netdevsim/dev.c:1438
 nsim_dev_port_add_all drivers/net/netdevsim/dev.c:1494 [inline]
 nsim_dev_reload_create drivers/net/netdevsim/dev.c:1546 [inline]
 nsim_dev_reload_up+0x5b8/0x860 drivers/net/netdevsim/dev.c:1003
 devlink_reload+0x322/0x7c0 net/devlink/dev.c:474
 devlink_nl_reload_doit+0xe31/0x1410 net/devlink/dev.c:584
 genl_family_rcv_msg_doit+0x206/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x55c/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x155/0x420 net/netlink/af_netlink.c:2552
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1320 [inline]
 netlink_unicast+0x5aa/0x870 net/netlink/af_netlink.c:1346
 netlink_sendmsg+0x8d1/0xdd0 net/netlink/af_netlink.c:1896
 sock_sendmsg_nosec net/socket.c:714 [inline]
 __sock_sendmsg net/socket.c:729 [inline]
 ____sys_sendmsg+0xa95/0xc70 net/socket.c:2614
 ___sys_sendmsg+0x134/0x1d0 net/socket.c:2668
 __sys_sendmsg+0x16d/0x220 net/socket.c:2700
 do_syscall_32_irqs_on arch/x86/entry/syscall_32.c:83 [inline]
 __do_fast_syscall_32+0x7c/0x3a0 arch/x86/entry/syscall_32.c:306
 do_fast_syscall_32+0x32/0x80 arch/x86/entry/syscall_32.c:331
 entry_SYSENTER_compat_after_hwframe+0x84/0x8e
RIP: 0023:0xf708e579
Code: b8 01 10 06 03 74 b4 01 10 07 03 74 b0 01 10 08 03 74 d8 01 00 00 00 00 00 00 00 00 00 00 00 00 00 51 52 55 89 e5 0f 34 cd 80 <5d> 5a 59 c3 90 90 90 90 8d b4 26 00 00 00 00 8d b4 26 00 00 00 00
RSP: 002b:00000000f505d55c EFLAGS: 00000296 ORIG_RAX: 0000000000000172
RAX: ffffffffffffffda RBX: 0000000000000007 RCX: 0000000080000080
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000296 R12: 0000000000000000
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000000
 </TASK>
Modules linked in:
CR2: ffff88809782c020
---[ end trace 0000000000000000 ]---
RIP: 0010:local_add arch/x86/include/asm/local.h:33 [inline]
RIP: 0010:u64_stats_add include/linux/u64_stats_sync.h:89 [inline]
RIP: 0010:dev_dstats_rx_dropped_add include/linux/netdevice.h:3027 [inline]
RIP: 0010:nsim_queue_free+0xba/0x120 drivers/net/netdevsim/netdev.c:714
Code: 07 77 6c 4a 8d 3c ed 20 7e f1 8d 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 80 3c 02 00 75 46 4a 03 1c ed 20 7e f1 8d <4c> 01 63 20 be 00 02 00 00 48 8d 3d 00 00 00 00 e8 61 2f 58 fa 48
RSP: 0018:ffffc900044af150 EFLAGS: 00010286
RAX: dffffc0000000000 RBX: ffff88809782c000 RCX: 00000000000079c3
RDX: 1ffffffff1be2fc7 RSI: ffffffff8c15f380 RDI: ffffffff8df17e38
RBP: ffff88805f59d000 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000001 R12: 0000000000000000
R13: 0000000000000003 R14: ffff88806ceb3d00 R15: ffffed100dfd308e
FS:  0000000000000000(0000) GS:ffff88809782c000(0063) knlGS:00000000f505db40
CS:  0010 DS: 002b ES: 002b CR0: 0000000080050033
CR2: ffff88809782c020 CR3: 000000006fc6a000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	77 6c                	ja     0x6e
   2:	4a 8d 3c ed 20 7e f1 	lea    -0x720e81e0(,%r13,8),%rdi
   9:	8d
   a:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  11:	fc ff df
  14:	48 89 fa             	mov    %rdi,%rdx
  17:	48 c1 ea 03          	shr    $0x3,%rdx
  1b:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
  1f:	75 46                	jne    0x67
  21:	4a 03 1c ed 20 7e f1 	add    -0x720e81e0(,%r13,8),%rbx
  28:	8d
* 29:	4c 01 63 20          	add    %r12,0x20(%rbx) <-- trapping instruction
  2d:	be 00 02 00 00       	mov    $0x200,%esi
  32:	48 8d 3d 00 00 00 00 	lea    0x0(%rip),%rdi        # 0x39
  39:	e8 61 2f 58 fa       	call   0xfa582f9f
  3e:	48                   	rex.W


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


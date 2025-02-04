Return-Path: <netdev+bounces-162613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 79ACCA275FD
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 16:35:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA2B518872E3
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73FBE21517F;
	Tue,  4 Feb 2025 15:34:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFA4212FA6
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 15:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738683268; cv=none; b=J55hT7Y0N9KGkoOE2goUMX1mYvl/tqMfnDpkbs6186NAgBouzJG8M3hciHvhwnhGpvaxjaleUxiusFczxyTQpNk4I2jD2Vr7bQ8Pb94kds0n8aDBc+avIP1iI4geVyg2+nR9oy+r94dOkaQyqQcXVa7vF73pd5Lc2eKK9RhgT6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738683268; c=relaxed/simple;
	bh=rUNmJfFjrvjH0k8NaLQl/mzIysHOcbVxpQtX9E26t70=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=G5EuZ4nsgD1FUpf4tUMk1vpi0o6wTjFtunH4UIzFIoJweM0rYllECfVSJ3Mmdiieo+iFrnu69GFZCCS8e4VseR627UEdJ21Ayy8AXLk9LqPVRjCoHhE1J1ucrMq1x0NL8Qxzls4ALlzupvs0KC71eozgsEmztocUJyvLeKD9mK0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3cde3591dbfso35841045ab.0
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 07:34:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738683266; x=1739288066;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=K+9elCslkuUd43cJRucxkW8XJc/qzTw0sB9huIEM9CA=;
        b=ERSSgXgAFylMTs6Fi3CJHdC/TSwAl21x5JLJbDQOVOIReigTIc80j/Q+BSDGXvIaDO
         KdM8uQE1UkYgZfFVoNkuzrUIAnxGifzd1GmPmghysHXs0iFr0lXsfv3Dy1KGqrENt69J
         2I+BkdafPTQbQ1wM5d2NXymiGin+MewDC6jJRoWWTBO+wq8srnaESBdG4Y05Wl8QPQEW
         QpNz/uF4xnOAs3DWADmyl3Mj1/Tw2tmwqN7QNN5Dej1gL9WhSfH3cJQ/KAUrWbf1mDgP
         S4Fi1TavbtpeohaapI8/aL0ztAOeMZZYypdL+KexI6e3K7llAfKoNxaLCymQGsVoPIEu
         +F9g==
X-Forwarded-Encrypted: i=1; AJvYcCXkD1JV5F1UUWSYem9gcUELEEbSG/i6QfOlj6mMuHqdiEhwYAE1WNzr54Abda1M43KAFegRS+Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyaR/qO8jqlj+DhUEehtynU4PzrMvP1B28M9LYdCgx8T2LEN+Nu
	e+onFW39qBQEQ1cNIG58cq00cSFvdTUu3eD8ARmA3fRnpcdxtHLIz4k5Ns6oCKb7UeaLeNkY1sr
	gKuqgG+flFGD2wmTMyQ2FJEiRw+vTVA2rJhW8FWWwEJBmurO6PUn2x5w=
X-Google-Smtp-Source: AGHT+IEY7EbFaoqgFMrAA3vftkEMeUpyS4C2dT07tOVvAFLSzcLdkmO+Y4df5yNNiK321yhOCXJ3bpXwBMwtBI5hm+Hd9wS+GI7m
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:d782:0:b0:3d0:ba6:1b4b with SMTP id
 e9e14a558f8ab-3d03f508636mr29042795ab.7.1738683265949; Tue, 04 Feb 2025
 07:34:25 -0800 (PST)
Date: Tue, 04 Feb 2025 07:34:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a23381.050a0220.d7c5a.00bb.GAE@google.com>
Subject: [syzbot] [net?] [bcachefs?] general protection fault in __alloc_skb
From: syzbot <syzbot+095590432e94610ef0e5@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kent.overstreet@linux.dev, kuba@kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    69e858e0b8b2 Merge tag 'uml-for-linus-6.14-rc1' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16f4dddf980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d033b14aeef39158
dashboard link: https://syzkaller.appspot.com/bug?extid=095590432e94610ef0e5
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17974518580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-69e858e0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a53b888c1f3f/vmlinux-69e858e0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/6b5e17edafc0/bzImage-69e858e0.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/f903aea5a6cc/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+095590432e94610ef0e5@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0x76a030f00000485: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 0 UID: 0 PID: 1077 Comm: kworker/u4:10 Not tainted 6.13.0-syzkaller-09760-g69e858e0b8b2 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound nsim_dev_trap_report_work
RIP: 0010:get_freepointer mm/slub.c:504 [inline]
RIP: 0010:get_freepointer_safe mm/slub.c:532 [inline]
RIP: 0010:__slab_alloc_node mm/slub.c:3993 [inline]
RIP: 0010:slab_alloc_node mm/slub.c:4152 [inline]
RIP: 0010:kmem_cache_alloc_node_noprof+0xec/0x380 mm/slub.c:4216
Code: 0f 84 8a 01 00 00 41 83 f8 ff 74 1a 48 8b 03 48 83 f8 ff 0f 84 8f 02 00 00 48 c1 e8 3a 41 39 c0 0f 85 6a 01 00 00 41 8b 46 28 <4a> 8b 1c 28 49 8d 4c 24 08 49 8b 36 4c 89 e8 4c 89 e2 65 48 0f c7
RSP: 0018:ffffc900026ef908 EFLAGS: 00010246
RAX: 0000000000000078 RBX: ffffea0000f49540 RCX: 0000000000046a30
RDX: 0000000000000000 RSI: 00000000000000f0 RDI: ffffffff8ea52d00
RBP: 00000000ffffffff R08: 00000000ffffffff R09: fffff520004ddf38
R10: dffffc0000000000 R11: fffff520004ddf38 R12: 00000000000d7b48
R13: 076a030f0000040d R14: ffff88801b7a18c0 R15: 0000000000000820
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f4588978ab8 CR3: 0000000059eac000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 __alloc_skb+0x1c3/0x440 net/core/skbuff.c:668
 alloc_skb include/linux/skbuff.h:1331 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x261/0xb50 drivers/net/netdevsim/dev.c:851
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
 worker_thread+0x870/0xd30 kernel/workqueue.c:3398
 kthread+0x7a9/0x920 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
----------------
Code disassembly (best guess):
   0:	0f 84 8a 01 00 00    	je     0x190
   6:	41 83 f8 ff          	cmp    $0xffffffff,%r8d
   a:	74 1a                	je     0x26
   c:	48 8b 03             	mov    (%rbx),%rax
   f:	48 83 f8 ff          	cmp    $0xffffffffffffffff,%rax
  13:	0f 84 8f 02 00 00    	je     0x2a8
  19:	48 c1 e8 3a          	shr    $0x3a,%rax
  1d:	41 39 c0             	cmp    %eax,%r8d
  20:	0f 85 6a 01 00 00    	jne    0x190
  26:	41 8b 46 28          	mov    0x28(%r14),%eax
* 2a:	4a 8b 1c 28          	mov    (%rax,%r13,1),%rbx <-- trapping instruction
  2e:	49 8d 4c 24 08       	lea    0x8(%r12),%rcx
  33:	49 8b 36             	mov    (%r14),%rsi
  36:	4c 89 e8             	mov    %r13,%rax
  39:	4c 89 e2             	mov    %r12,%rdx
  3c:	65                   	gs
  3d:	48                   	rex.W
  3e:	0f                   	.byte 0xf
  3f:	c7                   	.byte 0xc7


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


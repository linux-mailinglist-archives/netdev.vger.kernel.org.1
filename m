Return-Path: <netdev+bounces-208383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16CBBB0B368
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 05:58:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93BE518964D5
	for <lists+netdev@lfdr.de>; Sun, 20 Jul 2025 03:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F5FA199FAB;
	Sun, 20 Jul 2025 03:58:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0F4EAC6
	for <netdev@vger.kernel.org>; Sun, 20 Jul 2025 03:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752983913; cv=none; b=Jz4JoNOlkKZVSWZ0Udt1JTu+zde3ee1OCLrP62bpO4kP0mrin/ai5Q8stdd+LBPFGgB1ThonBZ8znt5QfquJkd1/Oz8uVtBoEZYjwjMyutkGjqZC8X2bMrVa5RCz7/CANx0MJ3I2tgspqYv3MIYPClUj/VIKYn5uzU4xYqiyiQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752983913; c=relaxed/simple;
	bh=zGlIAF72GsmmqUagODzql493q6S6/9XTSnYhNRZd1yM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZYSUJjKHcrzB/xXHPiw0ZKznHL93PU8thfY89ptWNMeIe2l5KtGtAg8rxb1E1Z3h0aUaE8IeDtmmJfiZl0IHHOWtdpFg4z2atSkek64TslZSRJbxXRgbx68pOfT8Ugx/USODDSDtDQuGZ4ebvS8yhPccnpBrWdUzXLTT2y2n43I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3e2a16160adso20598425ab.3
        for <netdev@vger.kernel.org>; Sat, 19 Jul 2025 20:58:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752983911; x=1753588711;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nsB/sJ4gSr2fJI4/dFbAf1S8MuXj/JkzbDKyQagJ6mM=;
        b=npleqgsCuJRMT4gCok12/pO+8l/bk83mH+I3e6wGxsONTSYSlhQi4enGuiEaCc2cPd
         Eh6df6c+z7ENPtYsgKOYMjTX4DTwZmV15AkDQGojsFJdMJF0ZMIYcatWcNIWLc1HTywR
         7bCt9OwjRBaiO54zkNInsxO77Abr5SLBndEqq46XKOykcCIuGqA0Fj5ARtYHyNt2ajaw
         XRjPJxzI0bzlHWEScp04B1xHcZ6X/8YkZ+QZ5eSxaS1EAeW9NYBZpG2Dkvr9qsLla5an
         +VHGdd9xQg92Jc5YvQ3q1n53fCzaYU3eV5KYP6Go6SCfYmxjbDjIX/f1q6J5rWgSp7Rr
         2m+w==
X-Forwarded-Encrypted: i=1; AJvYcCV16yeH2qumd3BweAbln1ptmmxuf6hD7axBvSmMICfiimEgIfDVWuKeyr2N/MtyRMng537XzLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsjwF8rzf8Jjcx0uMpjaEa57zX/ix0mMG8BqTFGkBUv+h0q446
	foTMiyVnbRJRaUpIdWjVZKYErDHCgvZX0Ppgh4ORPE9QZ5Rp6rhN+ejKwtL/6W0KbkXZSyD8M55
	xEMXmIz21+CyDa0jkN/4T7sqRYhE+abT5dg6YhrWCyiZa+G2N4wTofmigOc0=
X-Google-Smtp-Source: AGHT+IFGAFiMw9YIVJMIiBQBD//oXG8QJzQ09OC3S1b/UVKd8I6+E/40rK60gAOedDi0tfy1r9r765N6lPuGYzNnSBk2MXhaUKT3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:178c:b0:3e2:9b51:bfc5 with SMTP id
 e9e14a558f8ab-3e29b51cf0bmr54362225ab.14.1752983910730; Sat, 19 Jul 2025
 20:58:30 -0700 (PDT)
Date: Sat, 19 Jul 2025 20:58:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <687c6966.a70a0220.693ce.00a5.GAE@google.com>
Subject: [syzbot] [bluetooth] stack segment fault in kernfs_rename_ns
From: syzbot <syzbot+d1db96f72a452dc9cbd2@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, luiz.dentz@gmail.com, marcel@holtmann.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com, tj@kernel.org
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b9fd9888a565 bnxt_en: eliminate the compile warning in bnx..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=118ce582580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b29b1a0d7330d4a8
dashboard link: https://syzkaller.appspot.com/bug?extid=d1db96f72a452dc9cbd2
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/01ea776e1c9e/disk-b9fd9888.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bba0c9444631/vmlinux-b9fd9888.xz
kernel image: https://storage.googleapis.com/syzbot-assets/810cd37cc085/bzImage-b9fd9888.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+d1db96f72a452dc9cbd2@syzkaller.appspotmail.com

Oops: stack segment: 0000 [#1] SMP KASAN PTI
CPU: 0 UID: 0 PID: 6246 Comm: syz.3.81 Not tainted 6.16.0-rc4-syzkaller-00109-gb9fd9888a565 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:kernfs_rename_ns+0x3a/0x7a0 fs/kernfs/dir.c:1747
Code: ec 48 48 89 cb 48 89 54 24 10 49 89 f5 49 89 fe 49 bc 00 00 00 00 00 fc ff df e8 d1 5b 62 ff 4d 8d 7e 30 4c 89 fd 48 c1 ed 03 <42> 80 7c 25 00 00 74 08 4c 89 ff e8 86 de c5 ff 49 83 3f 00 0f 84
RSP: 0018:ffffc90003ecf9c0 EFLAGS: 00010206
RAX: ffffffff825e02cf RBX: 0000000000000000 RCX: 0000000000080000
RDX: ffffc9000cbbb000 RSI: 0000000000000873 RDI: 0000000000000874
RBP: 0000000000000006 R08: ffff88801c7e9e00 R09: 0000000000000008
R10: 0000000000000007 R11: 0000000000000002 R12: dffffc0000000000
R13: ffff888143acf960 R14: 0000000000000000 R15: 0000000000000030
FS:  00007fb14932a6c0(0000) GS:ffff888125c1d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000020000009e000 CR3: 000000007d24a000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 kobject_move+0x3a5/0x4f0 lib/kobject.c:569
 device_move+0xe0/0x700 drivers/base/core.c:4609
 hci_conn_del_sysfs+0xb8/0x170 net/bluetooth/hci_sysfs.c:75
 hci_conn_cleanup net/bluetooth/hci_conn.c:175 [inline]
 hci_conn_del+0x8ff/0xcb0 net/bluetooth/hci_conn.c:1173
 hci_conn_hash_flush+0x191/0x230 net/bluetooth/hci_conn.c:2561
 hci_dev_do_reset net/bluetooth/hci_core.c:566 [inline]
 hci_dev_reset+0x44b/0x6b0 net/bluetooth/hci_core.c:610
 sock_do_ioctl+0xd9/0x300 net/socket.c:1190
 sock_ioctl+0x576/0x790 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:907 [inline]
 __se_sys_ioctl+0xf9/0x170 fs/ioctl.c:893
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fb14858e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fb14932a038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fb1487b5fa0 RCX: 00007fb14858e929
RDX: 0000000000000000 RSI: 00000000400448cb RDI: 0000000000000006
RBP: 00007fb148610b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fb1487b5fa0 R15: 00007ffd3f5b1588
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:kernfs_rename_ns+0x3a/0x7a0 fs/kernfs/dir.c:1747
Code: ec 48 48 89 cb 48 89 54 24 10 49 89 f5 49 89 fe 49 bc 00 00 00 00 00 fc ff df e8 d1 5b 62 ff 4d 8d 7e 30 4c 89 fd 48 c1 ed 03 <42> 80 7c 25 00 00 74 08 4c 89 ff e8 86 de c5 ff 49 83 3f 00 0f 84
RSP: 0018:ffffc90003ecf9c0 EFLAGS: 00010206
RAX: ffffffff825e02cf RBX: 0000000000000000 RCX: 0000000000080000
RDX: ffffc9000cbbb000 RSI: 0000000000000873 RDI: 0000000000000874
RBP: 0000000000000006 R08: ffff88801c7e9e00 R09: 0000000000000008
R10: 0000000000000007 R11: 0000000000000002 R12: dffffc0000000000
R13: ffff888143acf960 R14: 0000000000000000 R15: 0000000000000030
FS:  00007fb14932a6c0(0000) GS:ffff888125c1d000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000002a0fb8 CR3: 000000007d24a000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	ec                   	in     (%dx),%al
   1:	48                   	rex.W
   2:	48 89 cb             	mov    %rcx,%rbx
   5:	48 89 54 24 10       	mov    %rdx,0x10(%rsp)
   a:	49 89 f5             	mov    %rsi,%r13
   d:	49 89 fe             	mov    %rdi,%r14
  10:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
  17:	fc ff df
  1a:	e8 d1 5b 62 ff       	call   0xff625bf0
  1f:	4d 8d 7e 30          	lea    0x30(%r14),%r15
  23:	4c 89 fd             	mov    %r15,%rbp
  26:	48 c1 ed 03          	shr    $0x3,%rbp
* 2a:	42 80 7c 25 00 00    	cmpb   $0x0,0x0(%rbp,%r12,1) <-- trapping instruction
  30:	74 08                	je     0x3a
  32:	4c 89 ff             	mov    %r15,%rdi
  35:	e8 86 de c5 ff       	call   0xffc5dec0
  3a:	49 83 3f 00          	cmpq   $0x0,(%r15)
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

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup


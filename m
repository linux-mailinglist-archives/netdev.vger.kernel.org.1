Return-Path: <netdev+bounces-180191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 215E5A80373
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 13:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A2FA67A7D8D
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 11:52:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0394F2690CC;
	Tue,  8 Apr 2025 11:53:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2466922257E
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 11:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744113217; cv=none; b=Vs/OLXs/NqLLHFlGxdLtZiaEH8qrGNF37/F8TzJwyXIDDaONnQlyIykOlSWlp7zSm9lZWt85Hu9IKhZwZANI0Z9YaSVilwMB5DDPnr2lXOPrgYFONxYSl91rde8ClLUnPr8Y67YeP0NLnd1mK45qQ8p/6QdKEPSK6tCGK/6yWJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744113217; c=relaxed/simple;
	bh=30THijzDCW8+66lPVvkoM3syMpW+vUvCqZuAoTbI73s=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=LOAdLiI1iXezr9RyP4Raj38IomBxwHpyALJxCiNrF3LJpgzUCn3FzmL2V7q6s6fh5LsuoGKlSVPYSiBP0qMi/Mb5GACIFVvydCOS2skdGdUnzhaNmvrypKhQoPkNYCazt8Hs39j13/ejNAAMIEA78EL8tTH6Hi9xRZ2i0mzGv74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d43c0dbe6aso118646925ab.1
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 04:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744113215; x=1744718015;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AI0o2WdZpjL1nB4AG/WVSQtJ8vhfG8kYbKtHGUAbqBs=;
        b=JG7nYPmTXq2PVoIlaHUrqN8ltG3dyObgCPClxSLyySi7ATau5DfBQr/UX7rJ0tIqft
         +JO8gjwc/52yCN6rYiWPIdEjpvk0GeWnTA4UQhi4jPI74zk/cY3mtpm00F8AuEvkT2u0
         PBGPg79xexdMO7ws9m4+XKwTlGMm5jc/JTIYlj7Nv+B+cTcd9CSn41Cz0Ff6x1BC3u0n
         m7A09h0zGhFkITfXdA0bJwjS/7rbfA6u9tTQcfgKxnol1IPob2mQZVLyzKMa6MAP21v7
         CttCmfA6D2e0zXf3WL+z82XmijehPpTQV5P4dTU72YTQ312tGQtI10ici492d/Z+WA+E
         jPbg==
X-Forwarded-Encrypted: i=1; AJvYcCX6DUK6bzJMV3FZG/4ZCuqGXivMd/mc8+q6ryyF2J79OYuuCkSEBVHZHV/03Jk0MtHyZL9PwWk=@vger.kernel.org
X-Gm-Message-State: AOJu0YxqRDOGVf8vXIySDAgAK/jAx5yFsMa5SxquJL76TPpq86/A/v+D
	Bsm0hgBrutEInUxEHWrXIsd8xvMpQETdDvsrP6e23KjNy13ZD5kSy0ZtqCJSZ3KoUuXAxTWbjDy
	EqKePrS5NIl0XtIojjwdhzPmLZXrP+ryNapXorQZh4pqw6gk6pNjYo7g=
X-Google-Smtp-Source: AGHT+IHmg4wlze6QGiItlM7J+FUsxRzgjmOlQgYeT56KsSFGrIrTnzWb3BUOsL6I8KKNqld4x+n6Oq7upXkBd863OwsyuWmzHinD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cda7:0:b0:3a7:88f2:cfa9 with SMTP id
 e9e14a558f8ab-3d6e3f193f8mr155054905ab.11.1744113214979; Tue, 08 Apr 2025
 04:53:34 -0700 (PDT)
Date: Tue, 08 Apr 2025 04:53:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f50e3e.050a0220.396535.0561.GAE@google.com>
Subject: [syzbot] [wireless?] general protection fault in cfg80211_mlme_deauth
From: syzbot <syzbot+00778a9a557a2a5e1a33@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0af2f6be1b42 Linux 6.15-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1284523f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66996a2350ef05e0
dashboard link: https://syzkaller.appspot.com/bug?extid=00778a9a557a2a5e1a33
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13c9eb4c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=179bbd98580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-0af2f6be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3fcfb8eefe4d/vmlinux-0af2f6be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e06a39be2bd8/bzImage-0af2f6be.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+00778a9a557a2a5e1a33@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 4854 Comm: kworker/0:3 Not tainted 6.15.0-rc1-syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events cfg80211_conn_work
RIP: 0010:ether_addr_equal include/linux/etherdevice.h:355 [inline]
RIP: 0010:cfg80211_mlme_deauth+0x35a/0x940 net/wireless/mlme.c:514
Code: 8d 9c 24 b0 00 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 28 84 c0 4c 8b 7c 24 28 0f 85 25 03 00 00 44 8b 23 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 2b 03 00 00 45 8b 37 48 8b 44 24 20 48
RSP: 0018:ffffc90002cdf180 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888045820e40 RCX: ffff888000b5c880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002cdf268 R08: ffffffff8b8395d8 R09: 0000000000000003
R10: 0000000000000009 R11: ffff888000b5c880 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000003 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88808c596000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f25d8438198 CR3: 000000001f4b4000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 cfg80211_conn_do_work+0x369/0xed0 net/wireless/sme.c:229
 cfg80211_conn_work+0x2c2/0x530 net/wireless/sme.c:273
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd50 kernel/workqueue.c:3400
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ether_addr_equal include/linux/etherdevice.h:355 [inline]
RIP: 0010:cfg80211_mlme_deauth+0x35a/0x940 net/wireless/mlme.c:514
Code: 8d 9c 24 b0 00 00 00 48 89 d8 48 c1 e8 03 42 0f b6 04 28 84 c0 4c 8b 7c 24 28 0f 85 25 03 00 00 44 8b 23 4c 89 f8 48 c1 e8 03 <42> 0f b6 04 28 84 c0 0f 85 2b 03 00 00 45 8b 37 48 8b 44 24 20 48
RSP: 0018:ffffc90002cdf180 EFLAGS: 00010246
RAX: 0000000000000000 RBX: ffff888045820e40 RCX: ffff888000b5c880
RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc90002cdf268 R08: ffffffff8b8395d8 R09: 0000000000000003
R10: 0000000000000009 R11: ffff888000b5c880 R12: 0000000000000000
R13: dffffc0000000000 R14: 0000000000000003 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88808c596000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f25d8438198 CR3: 000000001f4b4000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8d 9c 24 b0 00 00 00 	lea    0xb0(%rsp),%ebx
   7:	48 89 d8             	mov    %rbx,%rax
   a:	48 c1 e8 03          	shr    $0x3,%rax
   e:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax
  13:	84 c0                	test   %al,%al
  15:	4c 8b 7c 24 28       	mov    0x28(%rsp),%r15
  1a:	0f 85 25 03 00 00    	jne    0x345
  20:	44 8b 23             	mov    (%rbx),%r12d
  23:	4c 89 f8             	mov    %r15,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 28       	movzbl (%rax,%r13,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 2b 03 00 00    	jne    0x362
  37:	45 8b 37             	mov    (%r15),%r14d
  3a:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  3f:	48                   	rex.W


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


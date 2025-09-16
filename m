Return-Path: <netdev+bounces-223524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A215BB5965D
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 14:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622933203F6
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 12:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA59D30C61A;
	Tue, 16 Sep 2025 12:39:34 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B242D7803
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 12:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758026374; cv=none; b=HhNcjuOavLk8DbN67Yay9Ru5cSZzXtfIiYdj1gwwJ+JbhcYnSRX6lnWArRlZZWhapcGzjBKMzZoe5M9VqcQLd9PN82kVIIt8xG4s+xKhjyGwsdu60pp4x2BX4EfYe9hi9i3AQyxLL20i06gqB3iqb4Geifm85h97qxsQcstkdxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758026374; c=relaxed/simple;
	bh=QnaAg1bLGcETNswOB8njO+r16+K8dbnzNG95X21FNTg=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=XPVdEG87Fb4Iarpcp2Hue/c0vMqrTxkteAS89eU9UT/HAtQwb0Fs0+ZKelWSBAhCB9FbDKddf2jRImHyCqqQLazqxiW7G6CTtsqSuYdmMFrLnuRcC25cgS313OEXVWJFmfeXseoNangxsIMPGfC7QJ1InyPBKl20t0KPQLad33g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-4133da01bdcso91628795ab.0
        for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 05:39:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758026372; x=1758631172;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=64U5E7gIzbva7KDlrC7FVt5MKnXcg0Dmzp+8PIgeta0=;
        b=Wm3bj4bLL0YGv5zXPCAHxXnDb/sCnNveADovfB4/GdRzFUg1NZGZwHhZMpl52FyrPW
         Z0uTATdvzaZovjXO845IJQpNgTEWQoq2CYdQtOkoPqk6Ii62Gvf6Q1Nt0wvAmDTLr+oz
         SNcHrz2O7qJsXhZYM8kWhbRwdVgQ58AZO1SKmTOsLAgR2iWOqAWRMNCjKg5/TsTGShmH
         kCtzILtJxbPaXMuMuILF64q/hRMW1HuVC6hAglhCWrjoUympBJVL4CkRHGEe0N+YYhIh
         POQhDqsWnbW0qTvkT/scAxUe3Hp+N7wmzYxh4t0yTTpxgfLVkEOJVyS6M+sZC5NlBBp3
         E25g==
X-Forwarded-Encrypted: i=1; AJvYcCULaKwVtzb6X9Zlfo5F/pInLp0oRaNPl5LR768KEoXUdrkQC8Opv7V1+QhIzLWEgeBX0sZ5NDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YynJdJfz/bgTJtWovQ6jPIywv+kouOLf7oA0y9Me62SaghV/mMk
	IgTlCqYy4wiZq1su1Wh1O3Tqc7NIAmKigJeYAK9bWOE+O5cSts3JkBhsxUEB/WBaPbC/5K+SXcE
	AQ6fGBuaEngaMeNQgeNWXqBootKiGqWTm6WOdiQWCRxjCMSy5X57HdtrLEak=
X-Google-Smtp-Source: AGHT+IHH8YPBRYC4cnO7g8hl4hrLcnrJaC3pfiMamEolxPE6s6cC642aOx+nPkjK55+AGtz89+f9uP1FrZkrhT6y9tGqF0uUrYqI
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1707:b0:41e:c3da:57c0 with SMTP id
 e9e14a558f8ab-424114f1f18mr15123005ab.12.1758026371854; Tue, 16 Sep 2025
 05:39:31 -0700 (PDT)
Date: Tue, 16 Sep 2025 05:39:31 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c95a83.050a0220.3c6139.0e5c.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in lec_arp_clear_vccs
From: syzbot <syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2690cb089502 dpaa2-switch: fix buffer pool seeding for con..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=106c1934580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4d8792ecb6308d0f
dashboard link: https://syzkaller.appspot.com/bug?extid=72e3ea390c305de0e259
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bd85e520a303/disk-2690cb08.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/10d3787341cc/vmlinux-2690cb08.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c1556e02902a/bzImage-2690cb08.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+72e3ea390c305de0e259@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 0 UID: 0 PID: 27966 Comm: syz.1.7437 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/18/2025
RIP: 0010:lec_arp_clear_vccs+0xad/0x380 net/atm/lec.c:1263
Code: e8 03 80 3c 28 00 74 08 4c 89 e7 e8 9d e0 76 f7 4c 89 74 24 18 49 8b 2c 24 4c 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 ef e8 75 e0 76 f7 4d 8b 75 00 4d 8d a7 18
RSP: 0018:ffffc9001c217bd0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8880528ad400 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff8be33be0 RDI: ffff8880528ad400
RBP: ffff88802e2c2000 R08: ffffffff8e8e2db3 R09: 1ffffffff1d1c5b6
R10: dffffc0000000000 R11: fffffbfff1d1c5b7 R12: ffff88807df10638
R13: 0000000000000000 R14: ffff8880528ad430 R15: ffff88807df10000
FS:  000055555dcab500(0000) GS:ffff888125c15000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2733b056c0 CR3: 000000007e312000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lec_vcc_close net/atm/lec.c:2183 [inline]
 lec_push+0x3cb/0x1860 net/atm/lec.c:594
 vcc_destroy_socket net/atm/common.c:183 [inline]
 vcc_release+0x157/0x460 net/atm/common.c:205
 svc_release+0x6b/0xb0 net/atm/svc.c:95
 __sock_release net/socket.c:649 [inline]
 sock_close+0xc3/0x240 net/socket.c:1439
 __fput+0x449/0xa70 fs/file_table.c:468
 task_work_run+0x1d1/0x260 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop+0xec/0x110 kernel/entry/common.c:43
 exit_to_user_mode_prepare include/linux/irq-entry-common.h:225 [inline]
 syscall_exit_to_user_mode_work include/linux/entry-common.h:175 [inline]
 syscall_exit_to_user_mode include/linux/entry-common.h:210 [inline]
 do_syscall_64+0x2bd/0x3b0 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f114b78eba9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fff6f7d2028 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00007f114b9d7da0 RCX: 00007f114b78eba9
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f114b9d7da0 R08: 0000000000000000 R09: 0000000d6f7d231f
R10: 000000000003fd58 R11: 0000000000000246 R12: 00000000000a243d
R13: 00007fff6f7d2120 R14: ffffffffffffffff R15: 00007fff6f7d2140
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:lec_arp_clear_vccs+0xad/0x380 net/atm/lec.c:1263
Code: e8 03 80 3c 28 00 74 08 4c 89 e7 e8 9d e0 76 f7 4c 89 74 24 18 49 8b 2c 24 4c 89 e8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 08 4c 89 ef e8 75 e0 76 f7 4d 8b 75 00 4d 8d a7 18
RSP: 0018:ffffc9001c217bd0 EFLAGS: 00010046
RAX: 0000000000000000 RBX: ffff8880528ad400 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: ffffffff8be33be0 RDI: ffff8880528ad400
RBP: ffff88802e2c2000 R08: ffffffff8e8e2db3 R09: 1ffffffff1d1c5b6
R10: dffffc0000000000 R11: fffffbfff1d1c5b7 R12: ffff88807df10638
R13: 0000000000000000 R14: ffff8880528ad430 R15: ffff88807df10000
FS:  000055555dcab500(0000) GS:ffff888125c15000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f2733b056c0 CR3: 000000007e312000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	e8 03 80 3c 28       	call   0x283c8008
   5:	00 74 08 4c          	add    %dh,0x4c(%rax,%rcx,1)
   9:	89 e7                	mov    %esp,%edi
   b:	e8 9d e0 76 f7       	call   0xf776e0ad
  10:	4c 89 74 24 18       	mov    %r14,0x18(%rsp)
  15:	49 8b 2c 24          	mov    (%r12),%rbp
  19:	4c 89 e8             	mov    %r13,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 08                	je     0x38
  30:	4c 89 ef             	mov    %r13,%rdi
  33:	e8 75 e0 76 f7       	call   0xf776e0ad
  38:	4d 8b 75 00          	mov    0x0(%r13),%r14
  3c:	4d                   	rex.WRB
  3d:	8d                   	.byte 0x8d
  3e:	a7                   	cmpsl  %es:(%rdi),%ds:(%rsi)
  3f:	18                   	.byte 0x18


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


Return-Path: <netdev+bounces-129495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D36ED9841F4
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 11:22:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 306E3B28469
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 09:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF4E1154C07;
	Tue, 24 Sep 2024 09:22:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com [209.85.166.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C76C153812
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 09:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727169745; cv=none; b=Jf6bwMYcAFpnc2eLRZoeyREeWoscPb4MTgQDz0msTJTum/Bw/m53OMLQqb8HfuSAVFObbQcjFDuobX+vVLB03Jk/De2wxTNAJeswV/4IvSLM/0heTbCGgsJZdfglrgXRZd2ECMYJv1nEi+/pSNbZjDzE7JyU+4AsCPI5GO+i/OI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727169745; c=relaxed/simple;
	bh=O+2h/gyclxOqfVSQVHLtJElx6w7RYBUophTNfQo0veo=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NQlICuT8+Kra410YRbuVU17Aych3THgDuQmU53iXfYqaD9spNNWtaJZ4IwklG/41OeRYblHI1xQzQ1KXdW/zHpeZfOXgGeJXz+6s3ZsuRFPmeG/3KGmL4DCsN+yH7839OYZbkax6kvFzYYjN7maB2wxL8Yn9cjPAqviKnAbyCLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f198.google.com with SMTP id e9e14a558f8ab-3a05311890bso64215565ab.1
        for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 02:22:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727169743; x=1727774543;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljPaTEdcLQZpY9JQ2ZfDsBrXBURMa/3HCT2lU3cqgwc=;
        b=JAAkdjJ1Kd6ARkzkoajaPd91TrBs2LuF/J2AGC5niPkjTxHqP5xK5twIusybDrASa/
         aupGrLtr/Z1vmrJY1CnAmxiYfSj866A4BSmz+Ma2JaAtdkl38pJU1EBGMXby+xeCzRdJ
         sWMXkqU7DO2sNMQeCBjfY09pomu2+zcUtCm23E0gJUQ4SsB4RfomeOEA5ou3AEFQ5chL
         xsN2HoZNUo6tUT7I2QeDIWeSJXj6KnI1v4nHb5jmJVKC9XdUiqJQKlTpFtflnFULL83N
         QQ2ASTfGknkz3kqtGh529woWy5YCG68GmM3R5Ly8c75i4ZyBo1d5e5OavjZDS4IZ2m2U
         uE1Q==
X-Forwarded-Encrypted: i=1; AJvYcCX9tx1/ePzWn1vUKbZvY+L42C7ypDab7mHN9qFgiXpqZECsjFXFB+R2z7leYIXMmzpeQIMHumc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwdW0zw3EnaBXmYpwFtuV0GTZdFo524ZOPTboLW0YRe8mg45Szt
	FQu/Gi2tSX0XqZoo64w+5hG7BTzlno+q/zBGh6/zkCvy/dX18oUfLqlKAcG0QVDTPjvKbgWzPkz
	J6uHDHHWDdTTWFdkXYCh9UCARhkGPkA/OMPLEHk69yQJatqQtTAoFZUk=
X-Google-Smtp-Source: AGHT+IHzxnCBsEVhoC4luupSAyrZvqemDVoz8bzFXU1TwEvgVdIUtGWPABvi488e192+TwGSWxtf+A5rFQ4rQ7i1VA1QoemgXibo
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1d01:b0:3a0:ab86:9293 with SMTP id
 e9e14a558f8ab-3a0c8d7408fmr110380955ab.26.1727169743343; Tue, 24 Sep 2024
 02:22:23 -0700 (PDT)
Date: Tue, 24 Sep 2024 02:22:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f284cf.050a0220.c23dd.0025.GAE@google.com>
Subject: [syzbot] [net?] BUG: unable to handle kernel paging request in __task_rq_lock
From: syzbot <syzbot+5c756f98a0b65d89e058@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1868f9d0260e Merge tag 'for-linux-6.12-ofs1' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16cf0080580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d0b35925215243c6
dashboard link: https://syzkaller.appspot.com/bug?extid=5c756f98a0b65d89e058
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/33fe6e091b43/disk-1868f9d0.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/204ed295990c/vmlinux-1868f9d0.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1b85324d921e/bzImage-1868f9d0.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5c756f98a0b65d89e058@syzkaller.appspotmail.com

BUG: unable to handle page fault for address: fffffbfff35395f2
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 23ffe4067 P4D 23ffe4067 PUD 23ffe3067 PMD 13fff0067 PTE 0
Oops: Oops: 0000 [#1] PREEMPT SMP KASAN NOPTI
CPU: 1 UID: 0 PID: 5890 Comm: syz.4.41 Not tainted 6.11.0-syzkaller-07462-g1868f9d0260e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x82/0x290 mm/kasan/generic.c:189
Code: 01 00 00 00 00 fc ff df 4f 8d 3c 31 4c 89 fd 4c 29 dd 48 83 fd 10 7f 29 48 85 ed 0f 84 3e 01 00 00 4c 89 cd 48 f7 d5 48 01 dd <41> 80 3b 00 0f 85 c9 01 00 00 49 ff c3 48 ff c5 75 ee e9 1e 01 00
RSP: 0018:ffffc900034ff200 EFLAGS: 00010086
RAX: 0000000000cef701 RBX: 1ffffffff35395f2 RCX: ffffffff81703cdb
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff9a9caf90
RBP: ffffffffffffffff R08: ffffffff9a9caf97 R09: 1ffffffff35395f2
R10: dffffc0000000000 R11: fffffbfff35395f2 R12: ffff8880207e3c00
R13: ffff8880207e46d8 R14: dffffc0000000001 R15: fffffbfff35395f3
FS:  00007f01a5cf36c0(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff35395f2 CR3: 0000000068d60000 CR4: 0000000000350ef0
Call Trace:
 <TASK>
 instrument_atomic_read include/linux/instrumented.h:68 [inline]
 _test_bit include/asm-generic/bitops/instrumented-non-atomic.h:141 [inline]
 __lock_acquire+0xc8b/0x2050 kernel/locking/lockdep.c:5169
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5822
 _raw_spin_lock_nested+0x31/0x40 kernel/locking/spinlock.c:378
 raw_spin_rq_lock_nested+0x2a/0x140 kernel/sched/core.c:585
 raw_spin_rq_lock kernel/sched/sched.h:1423 [inline]
 __task_rq_lock+0xdf/0x3e0 kernel/sched/core.c:663
 ttwu_runnable kernel/sched/core.c:3710 [inline]
 try_to_wake_up+0x182/0x1480 kernel/sched/core.c:4153
 autoremove_wake_function+0x16/0x110 kernel/sched/wait.c:384
 __wake_up_common kernel/sched/wait.c:89 [inline]
 __wake_up_common_lock+0x132/0x1e0 kernel/sched/wait.c:106
 __unix_dgram_recvmsg+0x5f4/0x12f0 net/unix/af_unix.c:2462
 sock_recvmsg_nosec+0x190/0x1d0 net/socket.c:1052
 ____sys_recvmsg+0x3cd/0x480 net/socket.c:2820
 ___sys_recvmsg net/socket.c:2864 [inline]
 do_recvmmsg+0x46e/0xad0 net/socket.c:2958
 __sys_recvmmsg net/socket.c:3037 [inline]
 __do_sys_recvmmsg net/socket.c:3060 [inline]
 __se_sys_recvmmsg net/socket.c:3053 [inline]
 __x64_sys_recvmmsg+0x199/0x250 net/socket.c:3053
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f01a4f7def9
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f01a5cf3038 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007f01a5136058 RCX: 00007f01a4f7def9
RDX: 0000000000010106 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 00007f01a4ff0b76 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000001 R14: 00007f01a5136058 R15: 00007ffd3423d908
 </TASK>
Modules linked in:
CR2: fffffbfff35395f2
---[ end trace 0000000000000000 ]---
RIP: 0010:bytes_is_nonzero mm/kasan/generic.c:87 [inline]
RIP: 0010:memory_is_nonzero mm/kasan/generic.c:104 [inline]
RIP: 0010:memory_is_poisoned_n mm/kasan/generic.c:129 [inline]
RIP: 0010:memory_is_poisoned mm/kasan/generic.c:161 [inline]
RIP: 0010:check_region_inline mm/kasan/generic.c:180 [inline]
RIP: 0010:kasan_check_range+0x82/0x290 mm/kasan/generic.c:189
Code: 01 00 00 00 00 fc ff df 4f 8d 3c 31 4c 89 fd 4c 29 dd 48 83 fd 10 7f 29 48 85 ed 0f 84 3e 01 00 00 4c 89 cd 48 f7 d5 48 01 dd <41> 80 3b 00 0f 85 c9 01 00 00 49 ff c3 48 ff c5 75 ee e9 1e 01 00
RSP: 0018:ffffc900034ff200 EFLAGS: 00010086
RAX: 0000000000cef701 RBX: 1ffffffff35395f2 RCX: ffffffff81703cdb
RDX: 0000000000000000 RSI: 0000000000000008 RDI: ffffffff9a9caf90
RBP: ffffffffffffffff R08: ffffffff9a9caf97 R09: 1ffffffff35395f2
R10: dffffc0000000000 R11: fffffbfff35395f2 R12: ffff8880207e3c00
R13: ffff8880207e46d8 R14: dffffc0000000001 R15: fffffbfff35395f3
FS:  00007f01a5cf36c0(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: fffffbfff35395f2 CR3: 0000000068d60000 CR4: 0000000000350ef0
----------------
Code disassembly (best guess), 7 bytes skipped:
   0:	df 4f 8d             	fisttps -0x73(%rdi)
   3:	3c 31                	cmp    $0x31,%al
   5:	4c 89 fd             	mov    %r15,%rbp
   8:	4c 29 dd             	sub    %r11,%rbp
   b:	48 83 fd 10          	cmp    $0x10,%rbp
   f:	7f 29                	jg     0x3a
  11:	48 85 ed             	test   %rbp,%rbp
  14:	0f 84 3e 01 00 00    	je     0x158
  1a:	4c 89 cd             	mov    %r9,%rbp
  1d:	48 f7 d5             	not    %rbp
  20:	48 01 dd             	add    %rbx,%rbp
* 23:	41 80 3b 00          	cmpb   $0x0,(%r11) <-- trapping instruction
  27:	0f 85 c9 01 00 00    	jne    0x1f6
  2d:	49 ff c3             	inc    %r11
  30:	48 ff c5             	inc    %rbp
  33:	75 ee                	jne    0x23
  35:	e9                   	.byte 0xe9
  36:	1e                   	(bad)
  37:	01 00                	add    %eax,(%rax)


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


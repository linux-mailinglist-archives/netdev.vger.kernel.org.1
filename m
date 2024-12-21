Return-Path: <netdev+bounces-153945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BD0E9FA243
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 20:34:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 267121657BC
	for <lists+netdev@lfdr.de>; Sat, 21 Dec 2024 19:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9F516130C;
	Sat, 21 Dec 2024 19:34:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD7E2746C
	for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 19:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734809666; cv=none; b=sSI8H/TRCpwEwO2K/AveYPaWaCChRC0Ll+LYD+Mw9FyEXAmpZCVRrieHstWogbFrnbgn7PdLEN+wiGNBkK2iDuLCrVd51SU/X4IXnZk3czIEP38Wprg39r2Ys3tcsk+uxUJYJO6ZU30fovSoy/JMjAeBK8PnZe2PyN/KdPeQ13I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734809666; c=relaxed/simple;
	bh=3Ptlq6oFXsYLyRnWIix/VDdhOdbfJ2J2WfJgtUFoHKQ=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=aahTiCZcdbtKjhyEooZRuMhrIMqgcHj4FLOzRyqBah4GwI05C43gy9T4fgcTk0FpXuIc97E4az2RjRfrHvRWzJz9vrSOggFMCcczTZ21n2w+MB3UfdR4J6V4/r6hvXUbObhPfmFRRjdB1SJtJiu/Zr+ExPwxPy1Mzlys9z0vHOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3a9d195e6e5so27427655ab.2
        for <netdev@vger.kernel.org>; Sat, 21 Dec 2024 11:34:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734809663; x=1735414463;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R1kU7nL0JmfVZYbv/Ib6AHVrnRSRUQc20gIFQ5Gp1f4=;
        b=n1/CaniB+DpEwHyAP3afo3SnikxYnRtI9uUsCqAC3Sm8j5kpNQKOlLyCWQoa+9nb7b
         7potPguUFS3UhnCX/ajdmiE3zTZ6M7YKHQEE+BwQPoOQL2T02Q2RR5RVbfw0ll8JY1RC
         nm89liuIyJU+dUV4BxN54D7sjqDHA9jn6zloC3UaVQ6MtkUXl4+r+hMcywIDWf+kQhZU
         A7NEFADmeyZKi3TbHWVdgWyrrhENltOz+Yh9MWnFqnXi0cU/w1EXuUkYKDOmpqWx1Q0H
         c2Tr6Rm3paQq3XnqYIZqX3IPh0igUjPoGZ3I23B4WomItdlJG3hU26lyf60KmXlzB928
         Y+Pw==
X-Forwarded-Encrypted: i=1; AJvYcCVdZ7C+Tat5v2j4nEjfH25uv4G1pgE74/I16kynWUqiWIteINd/3iY584FdRAW/eS/JR84UJ+M=@vger.kernel.org
X-Gm-Message-State: AOJu0YybQ78x6M3ugm5l8wruSFhiIrKuPGwGnMuccFz2E5/YMmWB/6mm
	ybiscxYEiwMg9Vywh3C4IWhbErz65BCtEcmfEBv8WcUKMtovOiiVGHIoMZPTyV0M+Z6ok+Y7S5F
	98xbaWn8UbY9G2R6+y6jYuRTCKfjA13s2iJjER6u86f/9B+41RqKAnJQ=
X-Google-Smtp-Source: AGHT+IEB6GOF6BhPIYfeuG2O6VhjvebcQKd832Ju6SsvjoenT5XqMxHbUfhtBVSyNg2ibYpTJ3YHsqXqQxn1CU0Z9pSzuOdH/yIJ
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:188b:b0:3a7:a4ec:6cfc with SMTP id
 e9e14a558f8ab-3c2d1f75083mr73007825ab.8.1734809663505; Sat, 21 Dec 2024
 11:34:23 -0800 (PST)
Date: Sat, 21 Dec 2024 11:34:23 -0800
In-Reply-To: <673e3029.050a0220.363a1b.0024.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6767183f.050a0220.226966.0014.GAE@google.com>
Subject: Re: [syzbot] [kernel?] general protection fault in device_move
From: syzbot <syzbot+1f4e278e8e1a9b01f95f@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    499551201b5f Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14c81fe8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=4f1586bab1323870
dashboard link: https://syzkaller.appspot.com/bug?extid=1f4e278e8e1a9b01f95f
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=12c81fe8580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-49955120.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/43341c129049/vmlinux-49955120.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7a854e2daaae/bzImage-49955120.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f4e278e8e1a9b01f95f@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 0 UID: 0 PID: 6777 Comm: syz.7.38 Not tainted 6.13.0-rc3-syzkaller-00209-g499551201b5f #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:klist_put+0x4d/0x1b0 lib/klist.c:212
Code: c1 ea 03 80 3c 02 00 0f 85 5f 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 23 49 83 e4 fe 49 8d 7c 24 58 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 2e 01 00 00 4c 89 e7 4d 8b 74 24 58 e8 7c ce 0c
RSP: 0018:ffffc9000448f6d0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880302eb060 RCX: 0000000000000000
RDX: 000000000000000b RSI: ffffffff8b1f62c5 RDI: 0000000000000058
RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff2085610
R10: ffffffff9042b083 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000001 R14: 1ffff92000891ee2 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557dd40787d8 CR3: 000000003095e000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 klist_del lib/klist.c:230 [inline]
 klist_remove+0x140/0x2b0 lib/klist.c:249
 device_move+0x12d/0x10b0 drivers/base/core.c:4636
 hci_conn_del_sysfs+0x81/0x170 net/bluetooth/hci_sysfs.c:75
 hci_conn_cleanup net/bluetooth/hci_conn.c:174 [inline]
 hci_conn_del+0x54e/0xdb0 net/bluetooth/hci_conn.c:1164
 hci_conn_hash_flush+0x4bf/0x790 net/bluetooth/hci_conn.c:2699
 hci_dev_close_sync+0x603/0x11a0 net/bluetooth/hci_sync.c:5212
 hci_dev_do_close+0x2e/0x90 net/bluetooth/hci_core.c:482
 hci_unregister_dev+0x213/0x620 net/bluetooth/hci_core.c:2697
 vhci_release+0x79/0xf0 drivers/bluetooth/hci_vhci.c:664
 __fput+0x3f8/0xb60 fs/file_table.c:450
 task_work_run+0x14e/0x250 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xad8/0x2d70 kernel/exit.c:938
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1087
 get_signal+0x24ed/0x26c0 kernel/signal.c:3017
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe5b7bb85e5
Code: Unable to access opcode bytes at 0x7fe5b7bb85bb.
RSP: 002b:00007fe5b8974f80 EFLAGS: 00000293 ORIG_RAX: 00000000000000e6
RAX: fffffffffffffdfc RBX: 00007fe5b7d75fa0 RCX: 00007fe5b7bb85e5
RDX: 00007fe5b8974fc0 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 00007fe5b7c01aa8 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fe5b7d75fa0 R15: 00007ffda9a5cfa8
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:klist_put+0x4d/0x1b0 lib/klist.c:212
Code: c1 ea 03 80 3c 02 00 0f 85 5f 01 00 00 48 b8 00 00 00 00 00 fc ff df 4c 8b 23 49 83 e4 fe 49 8d 7c 24 58 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 2e 01 00 00 4c 89 e7 4d 8b 74 24 58 e8 7c ce 0c
RSP: 0018:ffffc9000448f6d0 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: ffff8880302eb060 RCX: 0000000000000000
RDX: 000000000000000b RSI: ffffffff8b1f62c5 RDI: 0000000000000058
RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff2085610
R10: ffffffff9042b083 R11: 0000000000000003 R12: 0000000000000000
R13: 0000000000000001 R14: 1ffff92000891ee2 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88806a600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000557dd40787d8 CR3: 0000000029cf2000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	c1 ea 03             	shr    $0x3,%edx
   3:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1)
   7:	0f 85 5f 01 00 00    	jne    0x16c
   d:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  14:	fc ff df
  17:	4c 8b 23             	mov    (%rbx),%r12
  1a:	49 83 e4 fe          	and    $0xfffffffffffffffe,%r12
  1e:	49 8d 7c 24 58       	lea    0x58(%r12),%rdi
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 2e 01 00 00    	jne    0x162
  34:	4c 89 e7             	mov    %r12,%rdi
  37:	4d 8b 74 24 58       	mov    0x58(%r12),%r14
  3c:	e8                   	.byte 0xe8
  3d:	7c ce                	jl     0xd
  3f:	0c                   	.byte 0xc


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


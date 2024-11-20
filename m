Return-Path: <netdev+bounces-146542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4BF9D423F
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 19:53:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1C9F1F21920
	for <lists+netdev@lfdr.de>; Wed, 20 Nov 2024 18:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E26D1A7259;
	Wed, 20 Nov 2024 18:53:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BC0D19F13B
	for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 18:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732128812; cv=none; b=CP1fpklo1zzm/YF/qnZQk3m8LgwLeiAiDd4Hw+yOpLHCBA1+v9F8sDQpvu93EYMdpsz/oyw5uPJBCLfUaH8wYrFcyF+5XCxyardMpWiz7iHXiZj5E1+dqWEIP34TpcPSTG2k9g3ACRYwTpmzD3DhvA4UMD9LaV488DsN492Po8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732128812; c=relaxed/simple;
	bh=c6ig68unAR21zMdFvzejjatneJBpr7tq3DLOMZITG2Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gZFJxQausqcposCzjHVTdD4XtV3nfweDlhxgqd/viSLg7gOxDsH8ONTOQp1kZIQ39xoZbL8fqw9qtt79UAZZ71VL+THWQHMF6fOJb6LcfBDY8zuOsb0ZXGDGAtqm54tBuIVSDIlSh+yHvp8r2tcQVjZkl6CqPQZVmfjnYOdcXOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a77de12c48so290255ab.0
        for <netdev@vger.kernel.org>; Wed, 20 Nov 2024 10:53:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732128810; x=1732733610;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pBfTw/RMwktv2neywATU9VAiByUlJz2SeD/AgwNqRMI=;
        b=JLpsueZMDVuWITaEXBJmQHv5SYao50tvxvop8SDGH0tixKPhLPV6c6aPN5OJ0IA98D
         LvRA6f8SSHMx/Lh3tnsPX6t2LfxLChhwc/Oc9i4MaFPnbxPYH0qDaNVYhkzLRycayeMF
         KTdy/n7mTvRBZFt15yiJe0iF59qRCvG30bR/JMsGtKKpyL/agKv1F/mW1VUh9xBL1ExQ
         M2wIstvHX8zs+reJJE7koMQtYB6UTSf2n+/D98C7bRvpjOE0I+d+4Vq4TwA2YXLcIUiv
         u0ir5XXJbiqQzyHowk6aFf06vPMUOUAU4LOUr3gCWmMJ/gAqF4wVY1CiVGjmTht3/Ao2
         bihQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6X0Ds0mYBAgrHzA3tc0SpjJUpJHL0C9rE68nKZQLMWuSR4pmsyHr0T7G74OZbM3UOHAI43QA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUVYvTc91uW57aEaj+LmENx4j05oXIgt5ToL6t/IKNuGgEMTUe
	o9mDFDU8mAz/OeU8P1cf+a2Xh6moZnKEI77NgOq6qLHydicr3GDuTUVgsMGRCGn3c/1/MncfuW8
	PEJXpzSN7gamQHSzvwoiAjL8ePGApNNjQ5BtwTqSngJ2SrhdzrAP6R8k=
X-Google-Smtp-Source: AGHT+IHM5swEvxiEdnh2/hUEzNEDMCW/nELMOsybDCxySB1RF2dD/achksVacyjv8PgZ6TuCq1tfIi41Tko1KlP+kx4eMnUjv0KH
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca4b:0:b0:3a3:b5ba:bfba with SMTP id
 e9e14a558f8ab-3a7865732bdmr40362885ab.15.1732128809873; Wed, 20 Nov 2024
 10:53:29 -0800 (PST)
Date: Wed, 20 Nov 2024 10:53:29 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <673e3029.050a0220.363a1b.0024.GAE@google.com>
Subject: [syzbot] [kernel?] general protection fault in device_move
From: syzbot <syzbot+1f4e278e8e1a9b01f95f@syzkaller.appspotmail.com>
To: gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, rafael@kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dd7207838d38 Merge git://git.kernel.org/pub/scm/linux/kern..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=17f7c6c0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e6d63a300b6a84a4
dashboard link: https://syzkaller.appspot.com/bug?extid=1f4e278e8e1a9b01f95f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d2e97bd9853a/disk-dd720783.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/02b4c391d07a/vmlinux-dd720783.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eaa4c64e1e50/bzImage-dd720783.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1f4e278e8e1a9b01f95f@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000b: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000058-0x000000000000005f]
CPU: 0 UID: 0 PID: 7855 Comm: syz-executor Not tainted 6.12.0-rc7-syzkaller-01770-gdd7207838d38 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/30/2024
RIP: 0010:klist_put lib/klist.c:212 [inline]
RIP: 0010:klist_del lib/klist.c:230 [inline]
RIP: 0010:klist_remove+0x1e8/0x480 lib/klist.c:249
Code: 3c 06 00 74 08 4c 89 ff e8 65 a6 40 f6 4d 8b 27 49 83 e4 fe 49 8d 7c 24 58 48 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 05 e8 3d a6 40 f6 4d 8b 6c 24 58 4c 89 e7 e8 10 a5
RSP: 0018:ffffc9000ad178c0 EFLAGS: 00010202
RAX: 000000000000000b RBX: ffffffff9003e3c8 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000058
RBP: ffffc9000ad179b0 R08: ffffffff9003e363 R09: 1ffffffff2007c6c
R10: dffffc0000000000 R11: fffffbfff2007c6d R12: 0000000000000000
R13: ffffffff9003e3c0 R14: 1ffff11029a9c40c R15: ffff88814d4e2060
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fffa5b58fd8 CR3: 0000000031058000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 device_move+0x1b4/0x710 drivers/base/core.c:4643
 hci_conn_del_sysfs+0xac/0x160 net/bluetooth/hci_sysfs.c:75
 hci_conn_cleanup net/bluetooth/hci_conn.c:174 [inline]
 hci_conn_del+0x8c4/0xc40 net/bluetooth/hci_conn.c:1164
 hci_conn_hash_flush+0x18e/0x240 net/bluetooth/hci_conn.c:2699
 hci_dev_close_sync+0xa42/0x11c0 net/bluetooth/hci_sync.c:5212
 hci_dev_do_close net/bluetooth/hci_core.c:483 [inline]
 hci_unregister_dev+0x20b/0x510 net/bluetooth/hci_core.c:2698
 vhci_release+0x80/0xd0 drivers/bluetooth/hci_vhci.c:664
 __fput+0x23f/0x880 fs/file_table.c:431
 task_work_run+0x24f/0x310 kernel/task_work.c:239
 exit_task_work include/linux/task_work.h:43 [inline]
 do_exit+0xa2f/0x28e0 kernel/exit.c:939
 do_group_exit+0x207/0x2c0 kernel/exit.c:1088
 __do_sys_exit_group kernel/exit.c:1099 [inline]
 __se_sys_exit_group kernel/exit.c:1097 [inline]
 __x64_sys_exit_group+0x3f/0x40 kernel/exit.c:1097
 x64_sys_call+0x2634/0x2640 arch/x86/include/generated/asm/syscalls_64.h:232
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3121d7e819
Code: Unable to access opcode bytes at 0x7f3121d7e7ef.
RSP: 002b:00007ffcf8975c18 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7
RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 00007f3121d7e819
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000043
RBP: 00007f3121dde5b0 R08: 00007ffcf89739b7 R09: 0000000000000003
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 0000000000000003 R14: 00000000ffffffff R15: 00007ffcf8975dc0
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:klist_put lib/klist.c:212 [inline]
RIP: 0010:klist_del lib/klist.c:230 [inline]
RIP: 0010:klist_remove+0x1e8/0x480 lib/klist.c:249
Code: 3c 06 00 74 08 4c 89 ff e8 65 a6 40 f6 4d 8b 27 49 83 e4 fe 49 8d 7c 24 58 48 89 f8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df <80> 3c 08 00 74 05 e8 3d a6 40 f6 4d 8b 6c 24 58 4c 89 e7 e8 10 a5
RSP: 0018:ffffc9000ad178c0 EFLAGS: 00010202
RAX: 000000000000000b RBX: ffffffff9003e3c8 RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000004 RDI: 0000000000000058
RBP: ffffc9000ad179b0 R08: ffffffff9003e363 R09: 1ffffffff2007c6c
R10: dffffc0000000000 R11: fffffbfff2007c6d R12: 0000000000000000
R13: ffffffff9003e3c0 R14: 1ffff11029a9c40c R15: ffff88814d4e2060
FS:  0000000000000000(0000) GS:ffff8880b8700000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000000 CR3: 00000000607f8000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	3c 06                	cmp    $0x6,%al
   2:	00 74 08 4c          	add    %dh,0x4c(%rax,%rcx,1)
   6:	89 ff                	mov    %edi,%edi
   8:	e8 65 a6 40 f6       	call   0xf640a672
   d:	4d 8b 27             	mov    (%r15),%r12
  10:	49 83 e4 fe          	and    $0xfffffffffffffffe,%r12
  14:	49 8d 7c 24 58       	lea    0x58(%r12),%rdi
  19:	48 89 f8             	mov    %rdi,%rax
  1c:	48 c1 e8 03          	shr    $0x3,%rax
  20:	48 b9 00 00 00 00 00 	movabs $0xdffffc0000000000,%rcx
  27:	fc ff df
* 2a:	80 3c 08 00          	cmpb   $0x0,(%rax,%rcx,1) <-- trapping instruction
  2e:	74 05                	je     0x35
  30:	e8 3d a6 40 f6       	call   0xf640a672
  35:	4d 8b 6c 24 58       	mov    0x58(%r12),%r13
  3a:	4c 89 e7             	mov    %r12,%rdi
  3d:	e8                   	.byte 0xe8
  3e:	10                   	.byte 0x10
  3f:	a5                   	movsl  %ds:(%rsi),%es:(%rdi)


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


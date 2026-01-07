Return-Path: <netdev+bounces-247808-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A1097CFEB0F
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 16:51:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E8DB3053395
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 15:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3936337F741;
	Wed,  7 Jan 2026 15:44:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f208.google.com (mail-oi1-f208.google.com [209.85.167.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1ED37F73E
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767800666; cv=none; b=GZ9tgLvS0YbmfBYXtlAFgfmAfCV1vTTVxGwtWESMdxfEDLJdzF9dX2TRUHFIgNICpzjAlpKkC3ylGkmg/CmBfUvdVtjfbTlM5lterEICLAWku7vHg/0SeH0X0RIwqtR9l6bY6OFSOkRZgZJJ9BUpxjirH0pTa/JcPbK4uu4CVw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767800666; c=relaxed/simple;
	bh=WO1564Ykb41trgvyAO2JS4X1tQNn2QdoLHhJ1Csvrao=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=fHDwQoDha4XiXe7P9/AKNmFe3nU+08Rnr98pkju7KCjH9XWd/QEtGK2lbTEL6V/v1WIWVMi3H0leVb8wuXorrq4U7vr/8g3bCHjLYCvGmm9EK/ivp1TbDNUkxd+YtIyFs0vKvVy+tHrYhehVz0PCZ1aHQ/ednIW15aDVQdEEK+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f208.google.com with SMTP id 5614622812f47-459bcc4d8bcso2777835b6e.1
        for <netdev@vger.kernel.org>; Wed, 07 Jan 2026 07:44:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767800662; x=1768405462;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gcjd/LFVweR/hgLXJ78SKHVFtJprh20I5fqcQLT0jgk=;
        b=KrurMKtYpKhucGO299bYi80v+lJsHNXACxBL0vco58NInfisyFijAM3Nz0jBJULQ/j
         qXhHX5+N7KIlTKz5M+tCvXk38pIM6HucpjO9kEVvCqPv6oGyqQu0QiaFd47ACAsp497d
         dwUgmnNagRvxBXHNc/19+ljjlEFjnHDs5ODdoWoCkVT/6i69ZUH2bVKZhkvBDv2otQAC
         EOP4rln+GLj51thAd5eIU+lsh0HOqHe4cLbx35mKVjkxIGfLINuph8SdbINr2gkZbZ8d
         OO26Ta7aGOCmx3s+QytVjXCv/onzsTv5hn6ICdh7770/X4gwBRKbcHlydQUFHmEaF6pQ
         s/zg==
X-Forwarded-Encrypted: i=1; AJvYcCXnygvdBGce3uYbbE5IBazOLjsoFbxXpDs8G6FCFeQ5JlCVc6+ZtLZdmJSaLMEdDEHb9dkq1Js=@vger.kernel.org
X-Gm-Message-State: AOJu0YzBaz30Stc0FuCCzM13q7nA1rASSs1ZZsr7napfAeQfjmgjWgiz
	3OQpm1mThvhtFgouo6p8XgVjJCOim8/i5Ku/f7IBEcD2/sXuYA+aCY6He9bfSnyy+8kQkCcbrGD
	+UAblQ17+nFba+lh+7PmvLdkbFnre6mQtzrXlYIrFRjz+zoKd68t4ITvUrMk=
X-Google-Smtp-Source: AGHT+IFdV4ZIGwks3eQ9jBrW++CfUWYS8g6wXep79BMiChW5OgoOxRJUVpiv3mo6mqDvcdLAi0lJo5genOdb9AFal/YzTfo8btN+
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:5292:b0:65c:fa23:2d00 with SMTP id
 006d021491bc7-65f54ed1b57mr776379eaf.9.1767800662423; Wed, 07 Jan 2026
 07:44:22 -0800 (PST)
Date: Wed, 07 Jan 2026 07:44:22 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <695e7f56.050a0220.1c677c.036c.GAE@google.com>
Subject: [syzbot] [net?] [nfc?] WARNING: locking bug in nci_close_device (3)
From: syzbot <syzbot+f9c5fd1a0874f9069dce@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	krzk@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    dbf8fe85a16a Merge tag 'net-6.19-rc4' of git://git.kernel...
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=109dffb4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a94030c847137a18
dashboard link: https://syzkaller.appspot.com/bug?extid=f9c5fd1a0874f9069dce
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9dc5ccb3a40b/disk-dbf8fe85.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b9d75d2c0c2/vmlinux-dbf8fe85.xz
kernel image: https://storage.googleapis.com/syzbot-assets/37f71f0365c9/bzImage-dbf8fe85.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f9c5fd1a0874f9069dce@syzkaller.appspotmail.com

Bluetooth: hci1: Opcode 0x0c1a failed: -4
Bluetooth: hci1: Error when powering off device on rfkill (-4)
Bluetooth: hci2: Opcode 0x0c1a failed: -4
Bluetooth: hci2: Error when powering off device on rfkill (-4)
------------[ cut here ]------------
DEBUG_LOCKS_WARN_ON(1)
WARNING: kernel/locking/lockdep.c:238 at hlock_class kernel/locking/lockdep.c:238 [inline], CPU#1: syz.6.5778/26216
WARNING: kernel/locking/lockdep.c:238 at check_wait_context kernel/locking/lockdep.c:4854 [inline], CPU#1: syz.6.5778/26216
WARNING: kernel/locking/lockdep.c:238 at __lock_acquire+0x39e/0x2cf0 kernel/locking/lockdep.c:5187, CPU#1: syz.6.5778/26216
Modules linked in:
CPU: 1 UID: 0 PID: 26216 Comm: syz.6.5778 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:hlock_class kernel/locking/lockdep.c:238 [inline]
RIP: 0010:check_wait_context kernel/locking/lockdep.c:4854 [inline]
RIP: 0010:__lock_acquire+0x3a5/0x2cf0 kernel/locking/lockdep.c:5187
Code: 17 00 4c 8b 74 24 08 75 27 90 e8 e6 94 ec 02 85 c0 74 1c 83 3d 2f 5d e4 0d 00 75 13 48 8d 3d 42 72 e7 0d 48 c7 c6 3a 0c 87 8d <67> 48 0f b9 3a 90 31 c0 0f b6 98 c4 00 00 00 41 8b 45 20 25 ff 1f
RSP: 0018:ffffc9000c037680 EFLAGS: 00010046
RAX: 0000000000000001 RBX: 0000000000040000 RCX: 0000000000080000
RDX: ffffc90004e52000 RSI: ffffffff8d870c3a RDI: ffffffff8f8567c0
RBP: 0000000000000003 R08: ffffffff8f8252a3 R09: 1ffffffff1f04a54
R10: dffffc0000000000 R11: fffffbfff1f04a55 R12: 00000000000011bb
R13: ffff888052a6aa28 R14: ffff888052a69e80 R15: ffff888052a6a9b0
FS:  00007f462b1636c0(0000) GS:ffff888125f1f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00002000000028c0 CR3: 00000000765dc000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 lock_acquire+0x107/0x340 kernel/locking/lockdep.c:5868
 touch_wq_lockdep_map+0xcb/0x180 kernel/workqueue.c:3940
 __flush_workqueue+0x121/0x14b0 kernel/workqueue.c:3982
 nci_close_device+0x2e5/0x610 net/nfc/nci/core.c:567
 nci_dev_down+0x3b/0x50 net/nfc/nci/core.c:639
 nfc_dev_down+0x152/0x290 net/nfc/core.c:161
 nfc_rfkill_set_block+0x2d/0x100 net/nfc/core.c:179
 rfkill_set_block+0x1d2/0x440 net/rfkill/core.c:346
 rfkill_fop_write+0x44b/0x570 net/rfkill/core.c:1301
 vfs_write+0x27e/0xb30 fs/read_write.c:684
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xec/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f462a38f749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f462b163038 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f462a5e6090 RCX: 00007f462a38f749
RDX: 0000000000000008 RSI: 0000200000000080 RDI: 0000000000000006
RBP: 00007f462a413f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f462a5e6128 R14: 00007f462a5e6090 R15: 00007ffea1921d88
 </TASK>
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	00 4c 8b 74          	add    %cl,0x74(%rbx,%rcx,4)
   4:	24 08                	and    $0x8,%al
   6:	75 27                	jne    0x2f
   8:	90                   	nop
   9:	e8 e6 94 ec 02       	call   0x2ec94f4
   e:	85 c0                	test   %eax,%eax
  10:	74 1c                	je     0x2e
  12:	83 3d 2f 5d e4 0d 00 	cmpl   $0x0,0xde45d2f(%rip)        # 0xde45d48
  19:	75 13                	jne    0x2e
  1b:	48 8d 3d 42 72 e7 0d 	lea    0xde77242(%rip),%rdi        # 0xde77264
  22:	48 c7 c6 3a 0c 87 8d 	mov    $0xffffffff8d870c3a,%rsi
* 29:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2e:	90                   	nop
  2f:	31 c0                	xor    %eax,%eax
  31:	0f b6 98 c4 00 00 00 	movzbl 0xc4(%rax),%ebx
  38:	41 8b 45 20          	mov    0x20(%r13),%eax
  3c:	25                   	.byte 0x25
  3d:	ff 1f                	lcall  *(%rdi)


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


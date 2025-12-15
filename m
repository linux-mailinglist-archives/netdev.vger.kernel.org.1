Return-Path: <netdev+bounces-244740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E7E8CBDDDD
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 13:45:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1035C304791A
	for <lists+netdev@lfdr.de>; Mon, 15 Dec 2025 12:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8AAF42E8B67;
	Mon, 15 Dec 2025 12:40:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f77.google.com (mail-oo1-f77.google.com [209.85.161.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D774D2E7165
	for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 12:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765802426; cv=none; b=SNEAmo0H+CqA9ZH8n1c95Cm44CQVp5texOHKYAmTtDKN0UOQQL/+eUxrIEf6x4K0lKarMX4MB8WkKTJf8IIT+HcWF1hK8/mBimUBSh6Gs9Lz8C3FqNQ10608LsLj52bH/45RZ+uxAcQ10mrwCkesjdPPmvjZhsDo3KvZYgP9iIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765802426; c=relaxed/simple;
	bh=3CPdRh+DSPcWkL5B287+4dDfky9y9J9gWX+DML4syFI=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UKkUXZAvDx2qFj7Pc9p8qzWBQBPL6S27dBEqYyZlzoty7x35or3VZi39PabgqmPkNfTOmszel4VAK+KstuE2oksoV+Q6qXmwHZt5BeWOl8EcQ/nyy+9wTa3xrDhjvsJhf1xjowlyV8dE01ROrH8QUB6avKugTQ420CdouhPYxjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f77.google.com with SMTP id 006d021491bc7-656cc4098f3so5494466eaf.2
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 04:40:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765802424; x=1766407224;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=721ApvIRAkzgHp/32/uXvf7MfR1jB3CQJmaTqNw/QVU=;
        b=u9jVri9SvZCF625q1deofjcFnaSF/s8137GSobQPC+NIe1Ij+y3UTnZdFgLcaD6Po3
         NlOhBL7DjyFniF7OnPQs1N9NYOQGq3yuTpbeCI4NeG1T06yev/lmWAn0iTMTIH5NatRa
         8TuKNW620bICMRkgsSsGgB0A63dwOFxDq4bJFx6oFwo2GQnjLMFm+TE/CfRndms5fUj1
         myzzSyBb34j7nIXQQ+vjWqDpLANUHhKTYEbYh7YcUXCkd3eA8MApwzirEo8e3v8gD5+D
         lGAn+59UUdHuv9S70kBXJiBzcI5r+VpJP9PWrzVuphH44ozFG3tEYJDBkFyqFbNvjjYj
         TSBA==
X-Forwarded-Encrypted: i=1; AJvYcCWLhUCbtlSz96rdraFR8lTdrbSa0857gz1XZViECm4lAkcxRLKaZtS/6+EK1Gz5YzH5yRlzJ08=@vger.kernel.org
X-Gm-Message-State: AOJu0YxF8K0/Yc5A/kSz7hDveqYwusKzcCL/2R9JWTC7EXR7MmZKG2AG
	rvpvYIPKiwP6G13yMNOU/ftRBhtZafm/PSRnevgLG1Q6BbpsZv0PpVPmISNPDQWj0AZKbAiMyFq
	CFFh7avLiyxLSsPbCIVsyYJ0iO9pgAy8Y+lqEPzjP8Egew5v0+zUSmjIy01g=
X-Google-Smtp-Source: AGHT+IGOIpYbkTOe9NZHmJo3UxxNa14DJrFG1Q0iHldnoZFznb6K02avz6Ns/NNSI6BNiH6ULDsNARHxCImgRY6lQvp/U/PQAJxh
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:16a3:b0:65b:3857:b82d with SMTP id
 006d021491bc7-65b451b3519mr4701277eaf.27.1765802424074; Mon, 15 Dec 2025
 04:40:24 -0800 (PST)
Date: Mon, 15 Dec 2025 04:40:24 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <694001b8.a70a0220.33cd7b.00fe.GAE@google.com>
Subject: [syzbot] [net?] [nfc?] WARNING in nfc_dev_down
From: syzbot <syzbot+4ef89409a235d804c6c2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	krzk@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d358e5254674 Merge tag 'for-6.19/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=13b2961a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f315601b98a91c0b
dashboard link: https://syzkaller.appspot.com/bug?extid=4ef89409a235d804c6c2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/def5abdae246/disk-d358e525.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/171af6e9cc68/vmlinux-d358e525.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2342dcd05182/bzImage-d358e525.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ef89409a235d804c6c2@syzkaller.appspotmail.com

------------[ cut here ]------------
rtmutex deadlock detected
WARNING: kernel/locking/rtmutex.c:1674 at 0x0, CPU#1: syz.4.2932/13586
Modules linked in:
CPU: 1 UID: 0 PID: 13586 Comm: syz.4.2932 Tainted: G             L      syzkaller #0 PREEMPT_{RT,(full)} 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:rt_mutex_handle_deadlock+0x21/0xb0 kernel/locking/rtmutex.c:1674
Code: 90 90 90 90 90 90 90 90 90 41 57 41 56 41 55 41 54 53 83 ff dd 0f 85 86 00 00 00 48 89 f7 e8 66 3b 01 00 48 8d 3d cf eb 08 04 <67> 48 0f b9 3a 4c 8d 3d 00 00 00 00 65 48 8b 1c 25 08 a0 b1 91 4c
RSP: 0018:ffffc900040d78b0 EFLAGS: 00010286
RAX: 0000000080000000 RBX: ffffc900040d7940 RCX: 0000000000000000
RDX: 0000000000000006 RSI: ffffffff8ce093ac RDI: ffffffff8ede2bf0
RBP: ffffc900040d7a58 R08: ffffffff8edb0977 R09: 1ffffffff1db612e
R10: dffffc0000000000 R11: fffffbfff1db612f R12: 1ffff9200081af24
R13: ffffffff8ad53b09 R14: ffff8880382f9098 R15: dffffc0000000000
FS:  00007f35de10c6c0(0000) GS:ffff888126e06000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055558f47b588 CR3: 0000000063c72000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 __rt_mutex_slowlock kernel/locking/rtmutex.c:1734 [inline]
 __rt_mutex_slowlock_locked kernel/locking/rtmutex.c:1760 [inline]
 rt_mutex_slowlock+0x666/0x6b0 kernel/locking/rtmutex.c:1800
 __rt_mutex_lock kernel/locking/rtmutex.c:1815 [inline]
 __mutex_lock_common kernel/locking/rtmutex_api.c:534 [inline]
 mutex_lock_nested+0x16a/0x1d0 kernel/locking/rtmutex_api.c:552
 device_lock include/linux/device.h:895 [inline]
 nfc_dev_down+0x3b/0x290 net/nfc/core.c:143
 nfc_rfkill_set_block+0x2d/0x100 net/nfc/core.c:179
 rfkill_set_block+0x1e5/0x450 net/rfkill/core.c:346
 rfkill_fop_write+0x44e/0x580 net/rfkill/core.c:1301
 do_loop_readv_writev fs/read_write.c:850 [inline]
 vfs_writev+0x4bf/0x970 fs/read_write.c:1059
 do_writev+0x153/0x2d0 fs/read_write.c:1103
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f35dfeef749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f35de10c038 EFLAGS: 00000246 ORIG_RAX: 0000000000000014
RAX: ffffffffffffffda RBX: 00007f35e0146180 RCX: 00007f35dfeef749
RDX: 0000000000000001 RSI: 0000200000000500 RDI: 0000000000000004
RBP: 00007f35dff73f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f35e0146218 R14: 00007f35e0146180 R15: 00007ffd7e110468
 </TASK>
----------------
Code disassembly (best guess):
   0:	90                   	nop
   1:	90                   	nop
   2:	90                   	nop
   3:	90                   	nop
   4:	90                   	nop
   5:	90                   	nop
   6:	90                   	nop
   7:	90                   	nop
   8:	90                   	nop
   9:	41 57                	push   %r15
   b:	41 56                	push   %r14
   d:	41 55                	push   %r13
   f:	41 54                	push   %r12
  11:	53                   	push   %rbx
  12:	83 ff dd             	cmp    $0xffffffdd,%edi
  15:	0f 85 86 00 00 00    	jne    0xa1
  1b:	48 89 f7             	mov    %rsi,%rdi
  1e:	e8 66 3b 01 00       	call   0x13b89
  23:	48 8d 3d cf eb 08 04 	lea    0x408ebcf(%rip),%rdi        # 0x408ebf9
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	4c 8d 3d 00 00 00 00 	lea    0x0(%rip),%r15        # 0x36
  36:	65 48 8b 1c 25 08 a0 	mov    %gs:0xffffffff91b1a008,%rbx
  3d:	b1 91
  3f:	4c                   	rex.WR


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


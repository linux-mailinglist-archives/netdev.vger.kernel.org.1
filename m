Return-Path: <netdev+bounces-244890-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7B4CC0F2B
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 05:58:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D11DC301CD1B
	for <lists+netdev@lfdr.de>; Tue, 16 Dec 2025 04:58:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44AFB317715;
	Tue, 16 Dec 2025 04:58:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6C88330B1D
	for <netdev@vger.kernel.org>; Tue, 16 Dec 2025 04:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765861123; cv=none; b=VJiJsv764rdOxtaDjVTBIL9skpVQwbRGReiOhry7i8fp3W3ssuA7ZCmvDiUOu6/YT7tCMBQeIPP4Q7LOMkcsLP5i5vKC9fChtcY94Y1sA8MEuQOaKBc5dLfkwwlnZ9StsP4qa7njWFU1zR/5wInPiYq1dreM5i108K2R+9XfsuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765861123; c=relaxed/simple;
	bh=aZk1EHRGxaEL9/vrGqHv62SBWmLu3vwA443KWlQpbJY=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=T9DtHeh3fehHArXifXdXZWpKjQYOvgkshTXUgXHqVaZYdEmTm4+U0bETIpOnpiSAL4UzXyIwXPoBqRXlZLti+j+ZcQ/4t6gix5CmR3g8G99POpIVB86GMHQ+bAel19MmyKraZrB81SFKAc2gWEza+mqKQSN49cS1+zBrl/2ssY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-6574d3d44f9so6949337eaf.3
        for <netdev@vger.kernel.org>; Mon, 15 Dec 2025 20:58:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765861111; x=1766465911;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=A9VJ2NjuLHAb4xBKj6JiMynK6+8wfONvXDjZG6Z5Uzg=;
        b=JLHEII8YjO22p3LJjzHEtFTql5z+78FwL2WNMxkYLo8RotaLPgoOekdXJPhG0Efe29
         ZobJXwQsefzXnHRpvSRqpNs5OdSbMq5ylwtB7r8X0KUvxjHDnA/dcSBAPyETnZiLqS0T
         zr3qv50GDeWVNjyH1/Z04tSqGwSBDMkvnRWz3Cm1Ku5+UcadrYBSjCAPl3Lo+08aiUjE
         mLAJ3hH1aUb7Lf228MEWtUKu7ABErxWsii92sJJ0SYMpR/dad3YDfyCEOSdjU40QLMT4
         thgT3KzQrZ/2Lp1xx/SZWTHs1q7t2ShIvSEjQHTJJW0Xc+HVnKkBXMKUiBCIJHNV8DlE
         9RUA==
X-Forwarded-Encrypted: i=1; AJvYcCU5nhBvZ927SI0Penq5oXNvN2CnT+bmZmjYJN7K6qmpmBSYIhdtj3uhDjB2sSBl/B7vYn04zrg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEZGnYDrqTlZgJjwu8kICDe3mlL3C3l2jbF2en8qeUPLFXB7hl
	QiyDJxWB9Gdlda/K5jSbOTx1fIZYbV7nilPKmRJFOAJy+NBCv2oUL/MNepdgVXRCetepM5ii0T7
	BNrMiLbNhLAEGgt/5MFlKa8ZQi8Cgwzlhg9qR0y+62fSMeO8JOjgDpL5rejw=
X-Google-Smtp-Source: AGHT+IE4CRdIxLZXnKMCACcPdimYF6ytn3cR0bwSBEUFU6igp132iUYNVvCwU/V9lOE/ATEBseE4+QjnBrr45Fnchcfbo3jBH/Oy
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2224:b0:659:9a49:9027 with SMTP id
 006d021491bc7-65b452c8e73mr5077427eaf.84.1765861111505; Mon, 15 Dec 2025
 20:58:31 -0800 (PST)
Date: Mon, 15 Dec 2025 20:58:31 -0800
In-Reply-To: <694001b8.a70a0220.33cd7b.00fe.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6940e6f7.a70a0220.33cd7b.0134.GAE@google.com>
Subject: Re: [syzbot] [net?] [nfc?] WARNING in nfc_dev_down
From: syzbot <syzbot+4ef89409a235d804c6c2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	krzk@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    8f0b4cce4481 Linux 6.19-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=102035c2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1f2b6fe1fdf1a00b
dashboard link: https://syzkaller.appspot.com/bug?extid=4ef89409a235d804c6c2
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1101b91a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=142035c2580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ea3b19e4d883/disk-8f0b4cce.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bd7c115820ba/vmlinux-8f0b4cce.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e5813cc1963f/bzImage-8f0b4cce.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4ef89409a235d804c6c2@syzkaller.appspotmail.com

------------[ cut here ]------------
rtmutex deadlock detected
WARNING: kernel/locking/rtmutex.c:1674 at rt_mutex_handle_deadlock+0x21/0xb0 kernel/locking/rtmutex.c:1674, CPU#1: syz.3.31/6310
Modules linked in:
CPU: 1 UID: 0 PID: 6310 Comm: syz.3.31 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:rt_mutex_handle_deadlock+0x21/0xb0 kernel/locking/rtmutex.c:1674
Code: 90 90 90 90 90 90 90 90 90 41 57 41 56 41 55 41 54 53 83 ff dd 0f 85 86 00 00 00 48 89 f7 e8 66 3b 01 00 48 8d 3d 6f 83 08 04 <67> 48 0f b9 3a 4c 8d 3d 00 00 00 00 65 48 8b 1c 25 08 d0 b1 91 4c
RSP: 0018:ffffc90004d97930 EFLAGS: 00010286
RAX: 0000000080000000 RBX: ffffc90004d979c0 RCX: 0000000000000000
RDX: 0000000000000006 RSI: ffffffff8ce0bc0c RDI: ffffffff8ede53f0
RBP: ffffc90004d97ad8 R08: ffffffff8edb3177 R09: 1ffffffff1db662e
R10: dffffc0000000000 R11: fffffbfff1db662f R12: 1ffff920009b2f34
R13: ffffffff8ad5cb69 R14: ffff888037dc6098 R15: dffffc0000000000
FS:  000055557d26b500(0000) GS:ffff888126e03000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffcf0a37f52 CR3: 00000000329d0000 CR4: 00000000003526f0
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
 vfs_write+0x287/0xb40 fs/read_write.c:684
 ksys_write+0x14b/0x260 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f28f61cf749
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffd96926f8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f28f6425fa0 RCX: 00007f28f61cf749
RDX: 0000000000000008 RSI: 0000200000000080 RDI: 0000000000000004
RBP: 00007f28f6253f91 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 00007f28f6425fa0 R14: 00007f28f6425fa0 R15: 0000000000000003
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
  23:	48 8d 3d 6f 83 08 04 	lea    0x408836f(%rip),%rdi        # 0x4088399
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	4c 8d 3d 00 00 00 00 	lea    0x0(%rip),%r15        # 0x36
  36:	65 48 8b 1c 25 08 d0 	mov    %gs:0xffffffff91b1d008,%rbx
  3d:	b1 91
  3f:	4c                   	rex.WR


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


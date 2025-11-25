Return-Path: <netdev+bounces-241600-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F17C8672C
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 19:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 9AC8734F09F
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 18:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C57432B9AD;
	Tue, 25 Nov 2025 17:59:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 301DF32ABFB
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 17:59:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764093549; cv=none; b=RmJ/IeFJSJ/znSeE1nztYUUEXJbe7Czah8Bm+EjCETNjhiXm1AkRISDvqJtVb0/OKqi3oUvPd3RsFgNDlvOLIirH9yq1aq5oIIBh4TQOlOSRaYMLYBy1ljHOgL1oK5N3rbcpQ5MtX5wazQtR/4yXw1z5vewWpJmf9kt3Lc00FBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764093549; c=relaxed/simple;
	bh=IIes42UdLwrn9QfRBUcxvfM50BPwxOedYAlohgyGik4=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=X7LbErBkraCpKuywVy8B/dAN7rd5ffA4pUiGa21PLzh7ch/t4XddECXMzb0tfmpADUGteQExKj7AUj3IeAfMFl+040Ds8pZK9O2FB2I+H839a95IjIeT5YsLMP9SYOkt/1IABsX9nP2Gy9bWDjix6aLskm3fIwgZbRqp1XPFx6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-43373024b5eso50985725ab.1
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 09:59:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764093546; x=1764698346;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSchwOz8P9k1LqadtNBQ62VkrfER4j90b3eaczudhR4=;
        b=fiBFgu7YaCKtNCar8OK7L18pMB79gI8AXXNhlO6G7tNCdqC4gs99xFNheqjW3kTj4d
         ExW27NC1vBLTdUqQbfYNXa0mtoBQDQVYIORdFD80be+me4wWRnzmnMKQKB9WDlxxEgUM
         9woRgEzUmivxZU/9qcu/9R27H1jaIhq+trRWcAcBW0YLG9ZjSv5A1aCLQ+gD2QLUIZ+l
         At3uZX04G2sYaXGPzqn0meHiXyHKYRk/TMHuttYll3hDp3Zt4l4gdO6bwTbuGrlV+Ug7
         0w71Siikjrbi0MvTuL2sEG5dmmmqURUoyGaX9Aum8V/Kd4UKp5aa2LgZ8HFa8BRXl0QR
         digA==
X-Forwarded-Encrypted: i=1; AJvYcCV+DWbN5utp1Dd1HKhTzHk3HdmZJBre8oBGdkeLkdLwWLfnKBvqI/yk4ZdJTeaOPZ2vVjGF9G4=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywx/PF+u09l+RkPszFmgOt+rZAm1Z5ZiTl20H9fw7N/AyP3hXML
	fv3Ue4dEj9BCptSDYxAj9PCdSEzq1z3RT0tEF0IJ0ruOl1Bjuo/5QkXddCGexvjzy/NZEGliDvw
	h/h3d8lYMDJbVaWdm5uFeodQqNOLuogAQnppGhrsLhfa/owHfDkCpukmh9mg=
X-Google-Smtp-Source: AGHT+IEo1ssy1yosF4O/BUpMb69gpBGShe5S9zM3xc60lLi4xodueKVuh+w9+7EnLuXnZctucBPRDid3uGzIAEjuRFppA0Nw4TT6
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a83:b0:433:6943:6c70 with SMTP id
 e9e14a558f8ab-435dd0691admr24239755ab.16.1764093546319; Tue, 25 Nov 2025
 09:59:06 -0800 (PST)
Date: Tue, 25 Nov 2025 09:59:06 -0800
In-Reply-To: <3e74d313-99df-4aeb-87b3-612f4f3634f0@gmail.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6925ee6a.a70a0220.2ea503.008e.GAE@google.com>
Subject: Re: [syzbot] [batman?] KMSAN: uninit-value in skb_clone
From: syzbot <syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, ssranevjti@gmail.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
general protection fault in skb_clone

Oops: general protection fault, probably for non-canonical address 0xdffffc000000000f: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
CPU: 0 UID: 0 PID: 6008 Comm: syz.0.23 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:skb_clone+0xd7/0x3a0 net/core/skbuff.c:2041
Code: 03 42 80 3c 20 00 74 08 4c 89 f7 e8 f3 28 05 f9 49 83 3e 00 0f 85 a0 01 00 00 e8 94 dd 9d f8 48 8d 6b 7e 49 89 ee 49 c1 ee 03 <43> 0f b6 04 26 84 c0 0f 85 d1 01 00 00 44 0f b6 7d 00 41 83 e7 0c
RSP: 0018:ffffc9000d67f200 EFLAGS: 00010207
RAX: ffffffff89223591 RBX: 0000000000000000 RCX: ffff88803362c900
RDX: 0000000000000000 RSI: 0000000000000820 RDI: 0000000000000000
RBP: 000000000000007e R08: ffffffff8f7d0f77 R09: 1ffffffff1efa1ee
R10: dffffc0000000000 R11: fffffbfff1efa1ef R12: dffffc0000000000
R13: 0000000000000820 R14: 000000000000000f R15: ffff888049098f00
FS:  00007f65d4fbc6c0(0000) GS:ffff88808d72f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f65d4fbbfc8 CR3: 0000000056473000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 hsr_forward_do net/hsr/hsr_forward.c:-1 [inline]
 hsr_forward_skb+0x1013/0x2860 net/hsr/hsr_forward.c:745
 hsr_handle_frame+0x6ce/0xa70 net/hsr/hsr_slave.c:84
 __netif_receive_skb_core+0x10b9/0x4380 net/core/dev.c:5966
 __netif_receive_skb_one_core net/core/dev.c:6077 [inline]
 __netif_receive_skb+0x72/0x380 net/core/dev.c:6192
 netif_receive_skb_internal net/core/dev.c:6278 [inline]
 netif_receive_skb+0x1cb/0x790 net/core/dev.c:6337
 tun_rx_batched+0x1b9/0x730 drivers/net/tun.c:1485
 tun_get_user+0x2b65/0x3e90 drivers/net/tun.c:1953
 tun_chr_write_iter+0x113/0x200 drivers/net/tun.c:1999
 new_sync_write fs/read_write.c:593 [inline]
 vfs_write+0x5c9/0xb30 fs/read_write.c:686
 ksys_write+0x145/0x250 fs/read_write.c:738
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f65d598e1ff
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
RSP: 002b:00007f65d4fbc000 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f65d5be6180 RCX: 00007f65d598e1ff
RDX: 000000000000003e RSI: 0000200000000500 RDI: 00000000000000c8
RBP: 00007f65d4fbc090 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000003e R11: 0000000000000293 R12: 0000000000000001
R13: 00007f65d5be6218 R14: 00007f65d5be6180 R15: 00007ffeb6e64a58
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_clone+0xd7/0x3a0 net/core/skbuff.c:2041
Code: 03 42 80 3c 20 00 74 08 4c 89 f7 e8 f3 28 05 f9 49 83 3e 00 0f 85 a0 01 00 00 e8 94 dd 9d f8 48 8d 6b 7e 49 89 ee 49 c1 ee 03 <43> 0f b6 04 26 84 c0 0f 85 d1 01 00 00 44 0f b6 7d 00 41 83 e7 0c
RSP: 0018:ffffc9000d67f200 EFLAGS: 00010207
RAX: ffffffff89223591 RBX: 0000000000000000 RCX: ffff88803362c900
RDX: 0000000000000000 RSI: 0000000000000820 RDI: 0000000000000000
RBP: 000000000000007e R08: ffffffff8f7d0f77 R09: 1ffffffff1efa1ee
R10: dffffc0000000000 R11: fffffbfff1efa1ef R12: dffffc0000000000
R13: 0000000000000820 R14: 000000000000000f R15: ffff888049098f00
FS:  00007f65d4fbc6c0(0000) GS:ffff88808d72f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f65d4fbbfc8 CR3: 0000000056473000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	03 42 80             	add    -0x80(%rdx),%eax
   3:	3c 20                	cmp    $0x20,%al
   5:	00 74 08 4c          	add    %dh,0x4c(%rax,%rcx,1)
   9:	89 f7                	mov    %esi,%edi
   b:	e8 f3 28 05 f9       	call   0xf9052903
  10:	49 83 3e 00          	cmpq   $0x0,(%r14)
  14:	0f 85 a0 01 00 00    	jne    0x1ba
  1a:	e8 94 dd 9d f8       	call   0xf89dddb3
  1f:	48 8d 6b 7e          	lea    0x7e(%rbx),%rbp
  23:	49 89 ee             	mov    %rbp,%r14
  26:	49 c1 ee 03          	shr    $0x3,%r14
* 2a:	43 0f b6 04 26       	movzbl (%r14,%r12,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 d1 01 00 00    	jne    0x208
  37:	44 0f b6 7d 00       	movzbl 0x0(%rbp),%r15d
  3c:	41 83 e7 0c          	and    $0xc,%r15d


Tested on:

commit:         30f09200 Merge tag 'arm64-fixes' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=15e6cf42580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1db0fea040c2a9f
dashboard link: https://syzkaller.appspot.com/bug?extid=2fa344348a579b779e05
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
patch:          https://syzkaller.appspot.com/x/patch.diff?x=1281a612580000



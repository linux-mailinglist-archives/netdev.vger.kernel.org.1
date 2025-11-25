Return-Path: <netdev+bounces-241577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D5FEC85FC1
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 17:32:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C90433491E0
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 16:32:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABAD328B7E;
	Tue, 25 Nov 2025 16:32:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f77.google.com (mail-io1-f77.google.com [209.85.166.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F291487E9
	for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 16:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764088349; cv=none; b=AerSMHmCy7C3W5kU5os1Kg+ZrReCBp/zO+BEi3c9yIE2/qzxaTy++Ls+12urC4tLQciPneGqlIiAbs1rOgjoNj+ma7xjLdfa2/t3MdAx+u4YgjHTiYwcZQESjNGrROjxksfs1rdMu8Sy6VuKI/EsYJHz+rIa0BFfgjDGjDk84E4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764088349; c=relaxed/simple;
	bh=Y3wLPY+uCiEM4l894Ef2EjxL3MevAEmxkX0ksr2indk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=NK6NSjnTXbfi6W76iDBBCbYaEKL97j28jI23FkkhDcZzXOuGGAgY/9jvjbtzajTSYlVVUYNpFx9qCgMYhoX2LPwO74fKNDjS3yxnPCkgV13ewjKuL+ppem7JvQQxzlz+c3mxdylWTaf60mgtyPajNIej05nBj97S45xAdSFZO8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f77.google.com with SMTP id ca18e2360f4ac-9486ebd1e4dso421291239f.3
        for <netdev@vger.kernel.org>; Tue, 25 Nov 2025 08:32:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764088347; x=1764693147;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gfXZ3XK6DpHsWJXameHSeCP+SGhHaEw9qBBrLcmfyvg=;
        b=vxwaVy3DijQp54rf7DSEFLKq5iFHfWBYGDJjn5JRzv0xq6grIBoTjux9/uNMwgvkL7
         hYzsNx2Q4EgvoJ/Yruj0gvPzk4KB1I9yGT77IP9DVSSHQ7eXZlbnNa33BiGFE2VLdDvZ
         fAUShGL/WiqlPxmjNjIjfBbPTpXWuOsuk5Y8elQT8O9FL+JdpFc3H90w+AIW76LiJ//D
         CH8aQV/FxauEMGcoM+VsDHQuW+0Nm36snzekRZNc13AOtfNOWthQWpjkYUagF/bC8o9B
         hpH8wNm9jHxbbsBqfFR15oe4/39csMP8eLsmD9tu5JXpzq0BA/tKHpBFiR5bYbQkZoeh
         2hBQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhdqvSlUYOPcBvxFgquVxzkP4OKWwRJ6sLuskzG/b5bg6GvQ/CimNLa6x396qt/s+L9+2ZHgU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzinB6CpmanTSJPsUfG6ri9wvlbSJ8iQslEF0YMG9yX/L5Qmfyn
	uXA5xtj3H6glyqY9wkW5AdP+jziqXkYzNqQu8+gB0rSB28mK6MV0Nf1t/k3q2dvk5XaTkauyFiR
	05023iWvBRkDOUSR2u2rjGMCtVWNLVxdP1ckmR+1LVmZE5409MjpXyF+l+Ok=
X-Google-Smtp-Source: AGHT+IEccsvlKZG5dGvuqW554f73GUIIAi74tnh3xbg+OxgkYwfplJaWHZY/8jm+IZPasDtwCYQ1exmkziXTC4idi/IYLkAVb/Nn
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:349d:b0:433:258e:5a92 with SMTP id
 e9e14a558f8ab-435b8ec96e8mr178679055ab.32.1764088347179; Tue, 25 Nov 2025
 08:32:27 -0800 (PST)
Date: Tue, 25 Nov 2025 08:32:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6925da1b.a70a0220.d98e3.00af.GAE@google.com>
Subject: [syzbot] [batman?] KMSAN: uninit-value in skb_clone
From: syzbot <syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com>
To: antonio@mandelbit.com, b.a.t.m.a.n@lists.open-mesh.org, 
	davem@davemloft.net, edumazet@google.com, horms@kernel.org, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, marek.lindner@mailbox.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, sven@narfation.org, 
	sw@simonwunderlich.de, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d13f3ac64efb Merge tag 'mips-fixes_6.18_1' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16333a12580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1db0fea040c2a9f
dashboard link: https://syzkaller.appspot.com/bug?extid=2fa344348a579b779e05
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=123f4e92580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15418612580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-d13f3ac6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7a7fb613c712/vmlinux-d13f3ac6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ea4e1a2bb3be/bzImage-d13f3ac6.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2fa344348a579b779e05@syzkaller.appspotmail.com

syz_tun: entered promiscuous mode
bond0: (slave syz_tun): Enslaving as an active interface with an up link
Oops: general protection fault, probably for non-canonical address 0xdffffc000000000f: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000078-0x000000000000007f]
CPU: 0 UID: 0 PID: 5625 Comm: syz.1.18 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:skb_clone+0xd7/0x3a0 net/core/skbuff.c:2041
Code: 03 42 80 3c 20 00 74 08 4c 89 f7 e8 23 29 05 f9 49 83 3e 00 0f 85 a0 01 00 00 e8 94 dd 9d f8 48 8d 6b 7e 49 89 ee 49 c1 ee 03 <43> 0f b6 04 26 84 c0 0f 85 d1 01 00 00 44 0f b6 7d 00 41 83 e7 0c
RSP: 0018:ffffc9000d00f200 EFLAGS: 00010207
RAX: ffffffff892235a1 RBX: 0000000000000000 RCX: ffff88803372a480
RDX: 0000000000000000 RSI: 0000000000000820 RDI: 0000000000000000
RBP: 000000000000007e R08: ffffffff8f7d0f77 R09: 1ffffffff1efa1ee
R10: dffffc0000000000 R11: fffffbfff1efa1ef R12: dffffc0000000000
R13: 0000000000000820 R14: 000000000000000f R15: ffff88805144cc00
FS:  0000555557f6d500(0000) GS:ffff88808d72f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555581d35808 CR3: 000000005040e000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 hsr_forward_do net/hsr/hsr_forward.c:-1 [inline]
 hsr_forward_skb+0x1013/0x2860 net/hsr/hsr_forward.c:741
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
RIP: 0033:0x7f0449f8e1ff
Code: 89 54 24 18 48 89 74 24 10 89 7c 24 08 e8 f9 92 02 00 48 8b 54 24 18 48 8b 74 24 10 41 89 c0 8b 7c 24 08 b8 01 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 31 44 89 c7 48 89 44 24 08 e8 4c 93 02 00 48
RSP: 002b:00007ffd7ad94c90 EFLAGS: 00000293 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 00007f044a1e5fa0 RCX: 00007f0449f8e1ff
RDX: 000000000000003e RSI: 0000200000000500 RDI: 00000000000000c8
RBP: 00007ffd7ad94d20 R08: 0000000000000000 R09: 0000000000000000
R10: 000000000000003e R11: 0000000000000293 R12: 0000000000000001
R13: 00007f044a1e5fa0 R14: 00007f044a1e5fa0 R15: 0000000000000003
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:skb_clone+0xd7/0x3a0 net/core/skbuff.c:2041
Code: 03 42 80 3c 20 00 74 08 4c 89 f7 e8 23 29 05 f9 49 83 3e 00 0f 85 a0 01 00 00 e8 94 dd 9d f8 48 8d 6b 7e 49 89 ee 49 c1 ee 03 <43> 0f b6 04 26 84 c0 0f 85 d1 01 00 00 44 0f b6 7d 00 41 83 e7 0c
RSP: 0018:ffffc9000d00f200 EFLAGS: 00010207
RAX: ffffffff892235a1 RBX: 0000000000000000 RCX: ffff88803372a480
RDX: 0000000000000000 RSI: 0000000000000820 RDI: 0000000000000000
RBP: 000000000000007e R08: ffffffff8f7d0f77 R09: 1ffffffff1efa1ee
R10: dffffc0000000000 R11: fffffbfff1efa1ef R12: dffffc0000000000
R13: 0000000000000820 R14: 000000000000000f R15: ffff88805144cc00
FS:  0000555557f6d500(0000) GS:ffff88808d72f000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555581d35808 CR3: 000000005040e000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	03 42 80             	add    -0x80(%rdx),%eax
   3:	3c 20                	cmp    $0x20,%al
   5:	00 74 08 4c          	add    %dh,0x4c(%rax,%rcx,1)
   9:	89 f7                	mov    %esi,%edi
   b:	e8 23 29 05 f9       	call   0xf9052933
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


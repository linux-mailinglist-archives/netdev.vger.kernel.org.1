Return-Path: <netdev+bounces-194604-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ADF6ACAEDF
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 15:22:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C9623A8C57
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 13:21:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210F0221297;
	Mon,  2 Jun 2025 13:21:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f205.google.com (mail-yb1-f205.google.com [209.85.219.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 541C51EFF8B
	for <netdev@vger.kernel.org>; Mon,  2 Jun 2025 13:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748870509; cv=none; b=TyNgK0BmPX/9y8FhbUwzuFRbR4xiNF1QQLeYmC65UV3adG3Ppnv0OgsqbaicyLIZ2ZJD0ZLYDF83nd7xnmDb6hS5O7IKv58FyY+CEAQNmPgD6ttSPd8AZAcnz70mlbhWN8E7XK5ix31+Pi7zsarR5ZzSLVJEONJUcHfFvd/Psg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748870509; c=relaxed/simple;
	bh=SO+lLuo6bpH8NB9jUUNH3nIpqmaGlvRpVU+v+2k+2Ik=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=J90u07NiEe7uCMarlVhYhs5ocYMzd5O6+IxJR3wxGwwqVp0EXR6C2Vv/P/N3OqJSEUp6Zl/1JyfLD8CVy7txvvrEFOUc9LFgWFt1YNqd8hxyUYSc63mVbzD6g2+EA4GmJ1Dxf55ZFVOMk3FUllHKd+lnIyK4CWWBS1xWoxQy/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.219.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-yb1-f205.google.com with SMTP id 3f1490d57ef6-e7dabc0305dso6103959276.2
        for <netdev@vger.kernel.org>; Mon, 02 Jun 2025 06:21:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748870506; x=1749475306;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HUxnwz0MGqaQx/zzJuI4xbyeSwmPEWwIYhs+1mkMIT8=;
        b=jT2ACgsnz5iVR+aOpPenOfWBJPqq7Ct7lXL3LkFxRTgFyBkNdtEzdzpvD7AQmGZ4JF
         wYFaX64xk3caBgFinydnplbF/6OjMqqtt0rOdA95mgXGRxKZ7seFMq/jaM1cf6tLEhOH
         /OsIuM8QKx1alNdAXUg8CAdykpDxWYiRTJ+OIjg3cJLsiUjA8Me22+BdDi7LkLoczb8t
         6eeWgT1ZvZSMKm1U+dyp4QHa2uzRnMiZjwvnOfRWpMlubIwImC4dOEWjDIiXMz/3JBrR
         zV0Z5/bqW+OuPy7X4N+gJwbuckAUz6GD8sTB+Iw0QOmBTFQAxAq0L1+llY0G9mEjn0SO
         /S7A==
X-Forwarded-Encrypted: i=1; AJvYcCWN6wTFIK4RHLJ7aJVGfCFkTYQh86W6HR+zVnOq6kgs6gqleW8Nwkv0kDNYnCzV11RIa7NOOs0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxnFe8b2CtdzmAMa/8X9qkONkOSC4Q0ydSM2dzzIVbv+b5MnBAx
	HxFW0qCFJ47BT069lYb3J8Hlbsim2CVTrp+Wvk6/n50rpQVZw14pRFoNbTWH7SM7/8pmpuDj8ge
	8tWebvq10/2GXiq7+ISN1vzZdQV/S2/mQv1MhR1VqdBuyNm5Ca87UaJqbOKM=
X-Google-Smtp-Source: AGHT+IEh3nfkVLswdHnJS8ur7GuATtva0rua850ix/lTROv5zWXN/jjUZkJz7/vW14hs16b5xIOW7gtzQrm24KrNeMlkL6Gv7a0y
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:154e:b0:3dd:75fe:9d68 with SMTP id
 e9e14a558f8ab-3dd9cc02bf8mr114767705ab.17.1748870494212; Mon, 02 Jun 2025
 06:21:34 -0700 (PDT)
Date: Mon, 02 Jun 2025 06:21:34 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <683da55e.a00a0220.d8eae.0052.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in veth_xdp_rcv
From: syzbot <syzbot+c4c7bf27f6b0c4bd97fe@syzkaller.appspotmail.com>
To: Jason@zx2c4.com, andrew+netdev@lunn.ch, davem@davemloft.net, 
	edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	wireguard@lists.zx2c4.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    4cb6c8af8591 selftests/filesystems: Fix build of anon_inod..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=11e8300c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5319177d225a42f1
dashboard link: https://syzkaller.appspot.com/bug?extid=c4c7bf27f6b0c4bd97fe
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-4cb6c8af.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/bc0e5dfdd686/vmlinux-4cb6c8af.xz
kernel image: https://storage.googleapis.com/syzbot-assets/2cdd323de6ca/bzImage-4cb6c8af.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c4c7bf27f6b0c4bd97fe@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000098: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x00000000000004c0-0x00000000000004c7]
CPU: 1 UID: 0 PID: 5975 Comm: kworker/1:4 Not tainted 6.15.0-syzkaller-10402-g4cb6c8af8591 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: wg-kex-wg0 wg_packet_handshake_receive_worker
RIP: 0010:netdev_get_tx_queue include/linux/netdevice.h:2636 [inline]
RIP: 0010:veth_xdp_rcv.constprop.0+0x142/0xda0 drivers/net/veth.c:912
Code: 54 d9 31 fb 45 85 e4 0f 85 db 08 00 00 e8 06 de 31 fb 48 8d bd c0 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 18 0c 00 00 44 8b a5 c0 04 00
RSP: 0018:ffffc900006a09b8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff868a1686
RDX: 0000000000000098 RSI: ffffffff868a0d9a RDI: 00000000000004c0
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: ffffc900006a0ff8 R12: 0000000000000001
R13: 1ffff920000d4145 R14: ffffc900006a0e58 R15: ffff8880503d0000
FS:  0000000000000000(0000) GS:ffff8880d686e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe5e3a6ad58 CR3: 000000000e382000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 veth_poll+0x19c/0x9c0 drivers/net/veth.c:979
 __napi_poll.constprop.0+0xba/0x550 net/core/dev.c:7414
 napi_poll net/core/dev.c:7478 [inline]
 net_rx_action+0xa9f/0xfe0 net/core/dev.c:7605
 handle_softirqs+0x219/0x8e0 kernel/softirq.c:579
 do_softirq kernel/softirq.c:480 [inline]
 do_softirq+0xb2/0xf0 kernel/softirq.c:467
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x100/0x120 kernel/softirq.c:407
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 fpregs_unlock arch/x86/include/asm/fpu/api.h:77 [inline]
 kernel_fpu_end+0x5e/0x70 arch/x86/kernel/fpu/core.c:476
 blake2s_compress+0x7f/0xe0 arch/x86/lib/crypto/blake2s-glue.c:46
 blake2s_final+0xc9/0x150 lib/crypto/blake2s.c:54
 hmac.constprop.0+0x335/0x420 drivers/net/wireguard/noise.c:333
 kdf.constprop.0+0x122/0x280 drivers/net/wireguard/noise.c:360
 mix_dh+0xe8/0x150 drivers/net/wireguard/noise.c:413
 wg_noise_handshake_consume_initiation+0x265/0x880 drivers/net/wireguard/noise.c:608
 wg_receive_handshake_packet+0x219/0xbf0 drivers/net/wireguard/receive.c:144
 wg_packet_handshake_receive_worker+0x17f/0x3a0 drivers/net/wireguard/receive.c:213
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:netdev_get_tx_queue include/linux/netdevice.h:2636 [inline]
RIP: 0010:veth_xdp_rcv.constprop.0+0x142/0xda0 drivers/net/veth.c:912
Code: 54 d9 31 fb 45 85 e4 0f 85 db 08 00 00 e8 06 de 31 fb 48 8d bd c0 04 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <0f> b6 04 02 84 c0 74 08 3c 03 0f 8e 18 0c 00 00 44 8b a5 c0 04 00
RSP: 0018:ffffc900006a09b8 EFLAGS: 00010202
RAX: dffffc0000000000 RBX: 0000000000000000 RCX: ffffffff868a1686
RDX: 0000000000000098 RSI: ffffffff868a0d9a RDI: 00000000000004c0
RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
R10: 0000000000000001 R11: ffffc900006a0ff8 R12: 0000000000000001
R13: 1ffff920000d4145 R14: ffffc900006a0e58 R15: ffff8880503d0000
FS:  0000000000000000(0000) GS:ffff8880d686e000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe5e3a6ad58 CR3: 000000000e382000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	54                   	push   %rsp
   1:	d9 31                	fnstenv (%rcx)
   3:	fb                   	sti
   4:	45 85 e4             	test   %r12d,%r12d
   7:	0f 85 db 08 00 00    	jne    0x8e8
   d:	e8 06 de 31 fb       	call   0xfb31de18
  12:	48 8d bd c0 04 00 00 	lea    0x4c0(%rbp),%rdi
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	48 89 fa             	mov    %rdi,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	0f b6 04 02          	movzbl (%rdx,%rax,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 08                	je     0x3a
  32:	3c 03                	cmp    $0x3,%al
  34:	0f 8e 18 0c 00 00    	jle    0xc52
  3a:	44                   	rex.R
  3b:	8b                   	.byte 0x8b
  3c:	a5                   	movsl  %ds:(%rsi),%es:(%rdi)
  3d:	c0                   	.byte 0xc0
  3e:	04 00                	add    $0x0,%al


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


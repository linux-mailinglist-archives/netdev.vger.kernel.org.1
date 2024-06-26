Return-Path: <netdev+bounces-106929-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD021918265
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 15:29:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E3F01C20992
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 13:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB87A181BB8;
	Wed, 26 Jun 2024 13:29:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5609A16190C
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 13:29:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719408563; cv=none; b=P74ldYk9jgmkKk1GmWzvGxyVj9riYLVMLKYdW52xYJWTDrwPeZ8Ks5BHee/GitjKKbjNsNZLKEe3/1j1wI4viDSVTJRmaR9Tp+NAfzcTCd4vvagu7ihgLVDcjTA0s1/A0Kpmm4dezNMTrvmyPhzxbBNh/ztOrGocgVNv4NVOG04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719408563; c=relaxed/simple;
	bh=m3A54rNj/ABm02WsaHZTKTWcdo3Gge+5OqiRvEOav60=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AuyRbLJPqtZF87rM3TE8l1SUAeTSclZZG0+U0+PVru4Vst8O2clkCo2CrkGx4zMj6IVBZGsW7voYC97lK9MMsE7RWIAZn70spbqpL+jw3/1M5JDPG0uxZclcuGPcye9YELkMzn4qUz4OdgupxfDC2t+mrceKiDyzaBLw5L65X9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-376282b0e2bso82024405ab.1
        for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 06:29:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719408561; x=1720013361;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=808FpBkpDsOyTMQG/Wc5jK3cn9vL1Kq3xpMCaflc4Wk=;
        b=EeXOTFxaq+2o4ThZjD2X0uPc4mS1sWuMicNLvyKtAZALxjFzYA6cGzFCELRGC8QKZc
         ansY8AY+2niyjUlBNvdywHnsAPcBRYs2gpdYjX9cP+RbMpea64wjjgMLFm2pRF4KDPsT
         GnevCg59IrpfEjOe8ixcBB9L0sRkFQ5Q0BDHG4OetUcQbgXfgf+7mhwcgU+4bo+J3kN4
         JXZCikHNHxJPEWoT+rJfbPXPUrrn5c7ovx5L9m+iK1eNu3sqIt/oJffqUSipg0CUPv2p
         VDTyPaw955gBH9hy2SnxCyKKvfRpAka4b55XDII/5WQuLXsYJ1tfItIWshLc8q/8iHO9
         qqmQ==
X-Forwarded-Encrypted: i=1; AJvYcCWJqqQ14djlNFP9uFzFqfDKEYn4Bh9bsnuwZXq/91wFQiwcUjhNw//83GhOV4Ura3+qXJMifI0pO9dS3zN6jReczmTN7mF3
X-Gm-Message-State: AOJu0YztZt53B8/FB5UMVh0Y39SDGnV4QPA7vZdRSZYsAXVE7xKrAe6V
	il7tqZA8KZYu8hxs8xKgimD8KNqPnwzqnojDim+CDywgUIKyGG8ObCsnGeAn570u/2QrxTutumh
	P9LcUgOtK1WXW420mA+iwWbTsHBkrW0+jZaVfNBLqJMs0vsHG6fQKklc=
X-Google-Smtp-Source: AGHT+IG73d/Yo7Cev6LSACw0jNK9nc1EnrU//U4Z6S/kFpnUfXoRgWj9gHpp8rtt4pXtx7ysvdJp9VE+iJ92k6WDTeBnfuILXD8X
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a21:b0:376:4cc6:66bc with SMTP id
 e9e14a558f8ab-3764cc668edmr8010995ab.2.1719408561527; Wed, 26 Jun 2024
 06:29:21 -0700 (PDT)
Date: Wed, 26 Jun 2024 06:29:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000088b5bc061bcb0009@google.com>
Subject: [syzbot] [tipc?] general protection fault in tipc_mon_reinit_self (2)
From: syzbot <syzbot+c13de708dc9a3bb8e9aa@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, jmaloy@redhat.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net, ying.xue@windriver.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b947cc5bf6d7 Merge tag 'erofs-for-6.9-rc7-fixes' of git://..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=147780a7180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3310e643b6ef5d69
dashboard link: https://syzkaller.appspot.com/bug?extid=c13de708dc9a3bb8e9aa
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/e05b77341eca/disk-b947cc5b.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ad295493d850/vmlinux-b947cc5b.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7c8f23427a9/bzImage-b947cc5b.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c13de708dc9a3bb8e9aa@syzkaller.appspotmail.com

tipc: Node number set to 10005162
general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN PTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 1 PID: 927 Comm: kworker/1:2 Not tainted 6.9.0-rc6-syzkaller-00005-gb947cc5bf6d7 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Workqueue: events tipc_net_finalize_work
RIP: 0010:tipc_mon_reinit_self+0x112/0x1e0 net/tipc/monitor.c:719
Code: e4 ba ff ff 48 8d 78 10 48 89 f9 48 c1 e9 03 0f b6 0c 29 84 c9 74 09 80 f9 03 0f 8e a9 00 00 00 8b 48 10 4c 89 f0 48 c1 e8 03 <0f> b6 04 28 84 c0 74 04 3c 03 7e 7e 41 89 0e 4c 89 ff e8 67 55 6e
RSP: 0018:ffffc900045cfbd8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000098aaaa
RDX: 1ffff110041af159 RSI: ffffffff8b0cb100 RDI: ffff88801f92c010
RBP: dffffc0000000000 R08: 0000000000000000 R09: fffffbfff1f3e922
R10: ffffffff8f9f4917 R11: 0000000000000003 R12: 0000000000000007
R13: fffffbfff1f4293b R14: 0000000000000000 R15: ffff88802dc05010
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3133f000 CR3: 000000005e626000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tipc_net_finalize+0x10c/0x180 net/tipc/net.c:140
 process_one_work+0x9a9/0x1ac0 kernel/workqueue.c:3254
 process_scheduled_works kernel/workqueue.c:3335 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3416
 kthread+0x2c1/0x3a0 kernel/kthread.c:388
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:tipc_mon_reinit_self+0x112/0x1e0 net/tipc/monitor.c:719
Code: e4 ba ff ff 48 8d 78 10 48 89 f9 48 c1 e9 03 0f b6 0c 29 84 c9 74 09 80 f9 03 0f 8e a9 00 00 00 8b 48 10 4c 89 f0 48 c1 e8 03 <0f> b6 04 28 84 c0 74 04 3c 03 7e 7e 41 89 0e 4c 89 ff e8 67 55 6e
RSP: 0018:ffffc900045cfbd8 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000000098aaaa
RDX: 1ffff110041af159 RSI: ffffffff8b0cb100 RDI: ffff88801f92c010
RBP: dffffc0000000000 R08: 0000000000000000 R09: fffffbfff1f3e922
R10: ffffffff8f9f4917 R11: 0000000000000003 R12: 0000000000000007
R13: fffffbfff1f4293b R14: 0000000000000000 R15: ffff88802dc05010
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000001b3133f000 CR3: 000000005e626000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 1 bytes skipped:
   0:	ba ff ff 48 8d       	mov    $0x8d48ffff,%edx
   5:	78 10                	js     0x17
   7:	48 89 f9             	mov    %rdi,%rcx
   a:	48 c1 e9 03          	shr    $0x3,%rcx
   e:	0f b6 0c 29          	movzbl (%rcx,%rbp,1),%ecx
  12:	84 c9                	test   %cl,%cl
  14:	74 09                	je     0x1f
  16:	80 f9 03             	cmp    $0x3,%cl
  19:	0f 8e a9 00 00 00    	jle    0xc8
  1f:	8b 48 10             	mov    0x10(%rax),%ecx
  22:	4c 89 f0             	mov    %r14,%rax
  25:	48 c1 e8 03          	shr    $0x3,%rax
* 29:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax <-- trapping instruction
  2d:	84 c0                	test   %al,%al
  2f:	74 04                	je     0x35
  31:	3c 03                	cmp    $0x3,%al
  33:	7e 7e                	jle    0xb3
  35:	41 89 0e             	mov    %ecx,(%r14)
  38:	4c 89 ff             	mov    %r15,%rdi
  3b:	e8                   	.byte 0xe8
  3c:	67 55                	addr32 push %rbp
  3e:	6e                   	outsb  %ds:(%rsi),(%dx)


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


Return-Path: <netdev+bounces-183142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEFEA8B231
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 09:33:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 77154169E19
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3ACFB1AD41F;
	Wed, 16 Apr 2025 07:33:30 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C49422D7BF
	for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 07:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744788810; cv=none; b=ShSBgGfD3gCuK2/Wci1geogYS4qJUgs6TH22lGh8BrGbzF1XOK496uv13frW3ALQIwxAZn0qzUNVX+CeNrzrqxDvPe1eBq8RIYkiZhXre9RCw1qc9MXHE8Zcf0W/JbRiYzIqHBixoic/VoXgaSnxy5teZo3lDUvPyYJm/6W16rQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744788810; c=relaxed/simple;
	bh=lf0sVW6jYtUgT2o2RkcbFjDNES+AjyvQndO/InJa+q0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=gI1KHX/mvIrvAXuS0a44j7Pk1hZWX8xe/EKlGgcE0AVSfSxkIvfadlEhxcDDHzLxAkiworF7A9d8RLRNAVzURcZ/FC6Eo6lK4jzbEzUwdMROEPcCNXsmXBkT5MmhAJt65bq9+y0ojBrON/wMiWOT9A0FqNYT2C7q2wf9xGMmgzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3d5d6c997d2so61387465ab.0
        for <netdev@vger.kernel.org>; Wed, 16 Apr 2025 00:33:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744788807; x=1745393607;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MEN/lEkUULtvsqo0YKjptRWEju8Ni+JhCO35ItlQcUY=;
        b=G6DKdbxe7XCp/+XXRNcGKoNXWxRkRd6M0DxDE5saWa/yBEnuucOQVwekbkhvZFLM0y
         ZttqcFHO7+2V4RjsysDKd+Afcvh2IOwPTWNURd6wzytJAPk2znSFp9EIhRMM+DKote8j
         p8sRNexbJeWKItKtGFPl4lkNNF98BXqNslmn+J5IqNVyzTVWlCLeKT0Qt76HcieCvrc4
         cohA54vYEJcQ/3MQpga3nd9rsO79yyaXdt8zYQCZ4wcR7gTgbdE6HFzdeKcgBH5nG9UN
         CIwMrH6ZECHdFQIKo/+j8Vr6XXbZdLeIsooZk51jbZd7BeIpFZAhnWM7MWKhzl5SOPBZ
         IvyQ==
X-Forwarded-Encrypted: i=1; AJvYcCWn4OE5ptnb0R1/Rb/GLbJA0/7G76J5WU/h+4pAyQojlSFt2SGcDiVab2iwjuLB7cUGcMW8Vq4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUsJ6x9BQo1TfTf2GviL8wu7dEBuLit0fznciT/OTBZTfmi4Fq
	b5cOZechp+d+iF0YmRYB2EZjxdY0idLA49YpDNNEaQPp2trS++UzDg3hhJmtmM6P5jqZWiv7BFl
	q6mY5gbZE1h+XGv9HHX1XGVOll0JaAmZL6a8bSnk1xeDLl9O0iwyH614=
X-Google-Smtp-Source: AGHT+IFT/w9xUUFTSf9LA7wrJS7PggyZBn3ezGVMeRtu8n8Crv724JttqOfuTQszH2uDxIWi5RE8UG4kPVJXUVHWqUYAFzGD0fU3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:184e:b0:3d4:3d63:e070 with SMTP id
 e9e14a558f8ab-3d815b63b22mr7131685ab.16.1744788807531; Wed, 16 Apr 2025
 00:33:27 -0700 (PDT)
Date: Wed, 16 Apr 2025 00:33:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67ff5d47.050a0220.5cdb3.0002.GAE@google.com>
Subject: [syzbot] [tipc?] general protection fault in tipc_mon_reinit_self (3)
From: syzbot <syzbot+ed60da8d686dc709164c@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	jmaloy@redhat.com, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com, 
	tipc-discussion@lists.sourceforge.net
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    900241a5cc15 Merge tag 'drm-fixes-2025-04-11-1' of https:/..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16128870580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7a4e108575159039
dashboard link: https://syzkaller.appspot.com/bug?extid=ed60da8d686dc709164c
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-900241a5.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/792caadc5fb3/vmlinux-900241a5.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c386404e8ac9/bzImage-900241a5.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ed60da8d686dc709164c@syzkaller.appspotmail.com

tipc: Node number set to 1055423674
Oops: general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
CPU: 3 UID: 0 PID: 6017 Comm: kworker/3:5 Not tainted 6.15.0-rc1-syzkaller-00246-g900241a5cc15 #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events tipc_net_finalize_work
RIP: 0010:tipc_mon_reinit_self+0x11c/0x210 net/tipc/monitor.c:719
Code: 8b 54 24 08 48 8d 78 10 48 89 f9 48 c1 e9 03 0f b6 0c 29 84 c9 74 09 80 f9 03 0f 8e b2 00 00 00 8b 48 10 48 89 d0 48 c1 e8 03 <0f> b6 04 28 84 c0 74 04 3c 03 7e 7d 89 0a 4c 89 ff e8 ce c1 65 00
RSP: 0018:ffffc9000356fb68 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000003ee87cba
RDX: 0000000000000000 RSI: ffffffff8dbc56a7 RDI: ffff88804c2cc010
RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000007
R13: fffffbfff2111097 R14: ffff88804ead8000 R15: ffff88804ead9010
FS:  0000000000000000(0000) GS:ffff888097ab9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f720eb00 CR3: 000000000e182000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 tipc_net_finalize+0x10b/0x180 net/tipc/net.c:140
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:tipc_mon_reinit_self+0x11c/0x210 net/tipc/monitor.c:719
Code: 8b 54 24 08 48 8d 78 10 48 89 f9 48 c1 e9 03 0f b6 0c 29 84 c9 74 09 80 f9 03 0f 8e b2 00 00 00 8b 48 10 48 89 d0 48 c1 e8 03 <0f> b6 04 28 84 c0 74 04 3c 03 7e 7d 89 0a 4c 89 ff e8 ce c1 65 00
RSP: 0018:ffffc9000356fb68 EFLAGS: 00010246
RAX: 0000000000000000 RBX: 0000000000000000 RCX: 000000003ee87cba
RDX: 0000000000000000 RSI: ffffffff8dbc56a7 RDI: ffff88804c2cc010
RBP: dffffc0000000000 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000000007
R13: fffffbfff2111097 R14: ffff88804ead8000 R15: ffff88804ead9010
FS:  0000000000000000(0000) GS:ffff888097ab9000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f720eb00 CR3: 000000000e182000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	8b 54 24 08          	mov    0x8(%rsp),%edx
   4:	48 8d 78 10          	lea    0x10(%rax),%rdi
   8:	48 89 f9             	mov    %rdi,%rcx
   b:	48 c1 e9 03          	shr    $0x3,%rcx
   f:	0f b6 0c 29          	movzbl (%rcx,%rbp,1),%ecx
  13:	84 c9                	test   %cl,%cl
  15:	74 09                	je     0x20
  17:	80 f9 03             	cmp    $0x3,%cl
  1a:	0f 8e b2 00 00 00    	jle    0xd2
  20:	8b 48 10             	mov    0x10(%rax),%ecx
  23:	48 89 d0             	mov    %rdx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	0f b6 04 28          	movzbl (%rax,%rbp,1),%eax <-- trapping instruction
  2e:	84 c0                	test   %al,%al
  30:	74 04                	je     0x36
  32:	3c 03                	cmp    $0x3,%al
  34:	7e 7d                	jle    0xb3
  36:	89 0a                	mov    %ecx,(%rdx)
  38:	4c 89 ff             	mov    %r15,%rdi
  3b:	e8 ce c1 65 00       	call   0x65c20e


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


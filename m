Return-Path: <netdev+bounces-162573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F072A2740E
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 15:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E54941625CB
	for <lists+netdev@lfdr.de>; Tue,  4 Feb 2025 14:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56DBD211A0D;
	Tue,  4 Feb 2025 14:07:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f208.google.com (mail-il1-f208.google.com [209.85.166.208])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C098211493
	for <netdev@vger.kernel.org>; Tue,  4 Feb 2025 14:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.208
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738678057; cv=none; b=kAIs5tmUyXmggEzPUW3UcNlvqk/hPw29dIfF6ASdfUr4i0QSxm7rTBZKnaRhvjFvMUf2t/hWTdqf4Ni3IO6mZzkEqZ8idgNO/8WlnJGp+r7bvDhY7bwSs3BK3yzVdJRUXy+BArg0mpc8uuiaM2nvhvOEUPTMSPOQnjEIA0lwKv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738678057; c=relaxed/simple;
	bh=TmoNHdpEv7nlLqST0v5v0DbeY6Qb8nbdrRZJQ3mzryU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=qVwMbLJ2DpzdTyzvEFvmoHvQpG9vK2m8jjaokf1IWwXtRvf0/uOya98xUbJfGO9ctNoOunWe7ulsP+ZFhxL+gXjWU1VVwoNWMhrgpW+K6/lwZXWnQk8yRImN5Ze7KJgRifAzZ1FtEOdOFZ8SHDzN6xXzuKG83XONo9MSvslSlr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.208
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f208.google.com with SMTP id e9e14a558f8ab-3ce8dadfb67so29954295ab.1
        for <netdev@vger.kernel.org>; Tue, 04 Feb 2025 06:07:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738678054; x=1739282854;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rk9Sed/HgXVVcsxad6rbeMqpe8B9YVm2glHH1VweY4Q=;
        b=C6+XMEi+KQ8VVD995pL+HccGIyqs26S6WqLrezmVvK34t6rnVJIGE/+rjihYatiIJa
         pBRae8+wmw07p3AUn5Q3Ebr1b4MuQA53Qf1nIqcmwfVu8LfgNxEL6jGXd0KZevrU65u0
         VVxmqxx9YFzTzeMCXsLg+N4bTdnhh5WjGXHqzfYBkBxSMBr8etGLPjGPMRTud7dFoyVD
         FK1HNe9yrmw4D6Rl6l9FYv9VffBxAFWkdyVwHwDgpjLDKUn6Q1pMlx4zrxoUPzqKnmMt
         EEINCJKxn1E4SjlR0b52BP5l82gwIGNAD/TPVM8oLkQHXhx9IiyViFNe+8wxkOVmAlYB
         G9oQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoBkZBTiXu9C8z0Hy+KixRqC/Ym7xVaUXflSYd4aVp24dEilPTYRmC/OYU1BRUNGuvL5nEQp0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsNWL7ulqx/PjCDfbMyXHOk4Bik1CBfuNK42pE3Z6Oddti+pzm
	FMxhy0tSLL5PJqjnIUCMW2ElBL6KYoZnL6rWSirHbfEFpApZRwFEYcH9N8supgWG/In8iT9a/WW
	o5Bosa/5bmFRC+QvDmGkIqkBfwdeoCiso/XUIq7hMFsvWV3Opt6kB0fc=
X-Google-Smtp-Source: AGHT+IHUGgD5KY+WVQA6hJY6SqVBkOjOjpCxU4Emjl8CwqO2hEa/kdGz+upWKuX69NVeWhbt0tAFrLysc4TlWX+wWWKXzX8ESCmf
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1fc3:b0:3cf:e76b:3937 with SMTP id
 e9e14a558f8ab-3cffe2da9e4mr223121065ab.0.1738678054381; Tue, 04 Feb 2025
 06:07:34 -0800 (PST)
Date: Tue, 04 Feb 2025 06:07:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67a21f26.050a0220.163cdc.0068.GAE@google.com>
Subject: [syzbot] [net?] general protection fault in ip6_pol_route (3)
From: syzbot <syzbot+3201be560ebfa39bc6bd@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    f1b785f4c787 Merge tag 'for_linus' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100bc1a7980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2aeec8c0b2e420c
dashboard link: https://syzkaller.appspot.com/bug?extid=3201be560ebfa39bc6bd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1209e4c0580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-f1b785f4.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/3d6bd514fd25/vmlinux-f1b785f4.xz
kernel image: https://storage.googleapis.com/syzbot-assets/bf9273b213e1/bzImage-f1b785f4.xz
mounted in repro: https://storage.googleapis.com/syzbot-assets/d332161a8efa/mount_0.gz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3201be560ebfa39bc6bd@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000013: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000098-0x000000000000009f]
CPU: 0 UID: 0 PID: 24 Comm: kworker/u4:2 Not tainted 6.12.0-rc7-syzkaller-00042-gf1b785f4c787 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound macvlan_process_broadcast
RIP: 0010:rt6_get_pcpu_route net/ipv6/route.c:1408 [inline]
RIP: 0010:ip6_pol_route+0x4d1/0x15d0 net/ipv6/route.c:2264
Code: 93 f7 48 8b 03 65 4c 8b 30 31 ff 4c 89 f6 e8 86 b4 29 f7 4d 85 f6 0f 84 da 00 00 00 49 8d 9e 98 00 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 12 0f 00 00 44 8b 3b 31 ff 44 89 fe e8
RSP: 0018:ffffc900000073a0 EFLAGS: 00010202
RAX: 0000000000000013 RBX: 0000000000000099 RCX: ffff88801bb0c880
RDX: 0000000000000100 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900000074f0 R08: ffffffff8a6b3a6a R09: ffff888012677b40
R10: dffffc0000000000 R11: fffffbfff203a13e R12: ffffc90000007470
R13: 1ffff92000000e8e R14: 0000000000000001 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7b9a67e000 CR3: 000000003ea02000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 pol_lookup_func include/net/ip6_fib.h:616 [inline]
 fib6_rule_lookup+0x58c/0x790 net/ipv6/fib6_rules.c:117
 ip6_route_input_lookup net/ipv6/route.c:2300 [inline]
 ip6_route_input+0x859/0xd90 net/ipv6/route.c:2596
 ip6_rcv_finish+0x144/0x180 net/ipv6/ip6_input.c:77
 NF_HOOK+0x3a4/0x450 include/linux/netfilter.h:314
 __netif_receive_skb_one_core net/core/dev.c:5670 [inline]
 __netif_receive_skb+0x1ea/0x650 net/core/dev.c:5783
 process_backlog+0x662/0x15b0 net/core/dev.c:6115
 __napi_poll+0xcb/0x490 net/core/dev.c:6779
 napi_poll net/core/dev.c:6848 [inline]
 net_rx_action+0x89b/0x1240 net/core/dev.c:6970
 handle_softirqs+0x2c5/0x980 kernel/softirq.c:554
 do_softirq+0x11b/0x1e0 kernel/softirq.c:455
 </IRQ>
 <TASK>
 __local_bh_enable_ip+0x1bb/0x200 kernel/softirq.c:382
 local_bh_enable include/linux/bottom_half.h:33 [inline]
 netif_rx+0x83/0x90 net/core/dev.c:5255
 macvlan_broadcast+0x3c4/0x670 drivers/net/macvlan.c:290
 macvlan_process_broadcast+0x50e/0x7f0 drivers/net/macvlan.c:338
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:rt6_get_pcpu_route net/ipv6/route.c:1408 [inline]
RIP: 0010:ip6_pol_route+0x4d1/0x15d0 net/ipv6/route.c:2264
Code: 93 f7 48 8b 03 65 4c 8b 30 31 ff 4c 89 f6 e8 86 b4 29 f7 4d 85 f6 0f 84 da 00 00 00 49 8d 9e 98 00 00 00 48 89 d8 48 c1 e8 03 <42> 0f b6 04 38 84 c0 0f 85 12 0f 00 00 44 8b 3b 31 ff 44 89 fe e8
RSP: 0018:ffffc900000073a0 EFLAGS: 00010202
RAX: 0000000000000013 RBX: 0000000000000099 RCX: ffff88801bb0c880
RDX: 0000000000000100 RSI: 0000000000000001 RDI: 0000000000000000
RBP: ffffc900000074f0 R08: ffffffff8a6b3a6a R09: ffff888012677b40
R10: dffffc0000000000 R11: fffffbfff203a13e R12: ffffc90000007470
R13: 1ffff92000000e8e R14: 0000000000000001 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff88801fc00000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f7b9a67e000 CR3: 000000003ea02000 CR4: 0000000000352ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	93                   	xchg   %eax,%ebx
   1:	f7 48 8b 03 65 4c 8b 	testl  $0x8b4c6503,-0x75(%rax)
   8:	30 31                	xor    %dh,(%rcx)
   a:	ff 4c 89 f6          	decl   -0xa(%rcx,%rcx,4)
   e:	e8 86 b4 29 f7       	call   0xf729b499
  13:	4d 85 f6             	test   %r14,%r14
  16:	0f 84 da 00 00 00    	je     0xf6
  1c:	49 8d 9e 98 00 00 00 	lea    0x98(%r14),%rbx
  23:	48 89 d8             	mov    %rbx,%rax
  26:	48 c1 e8 03          	shr    $0x3,%rax
* 2a:	42 0f b6 04 38       	movzbl (%rax,%r15,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 12 0f 00 00    	jne    0xf49
  37:	44 8b 3b             	mov    (%rbx),%r15d
  3a:	31 ff                	xor    %edi,%edi
  3c:	44 89 fe             	mov    %r15d,%esi
  3f:	e8                   	.byte 0xe8


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


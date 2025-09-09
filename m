Return-Path: <netdev+bounces-221465-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3755AB5092D
	for <lists+netdev@lfdr.de>; Wed, 10 Sep 2025 01:22:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D89804E557F
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 23:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC1528640E;
	Tue,  9 Sep 2025 23:22:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274982797B5
	for <netdev@vger.kernel.org>; Tue,  9 Sep 2025 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757460151; cv=none; b=e+eBAOJV2PHEepwTz2iel7oU9VguG3gZ9+uPIfTwkp+bBvDxLp8DOORZz0yDbskKo6m+SBXhn9lkmPz33AcbPCyV4TnYbhhpsKnSKcvBzAXZV/0hopjolxLcD0Dz6YkHTB56CfyVzfjWuy2QQM2xiq2oSCtcaYBPfworE+kqhrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757460151; c=relaxed/simple;
	bh=Fu1rEVnZku0+ocOnDrCEunwXnwZHmr5nIqTtw54aRkc=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=YTTf5Txsmng7r2bOQ3Q/pVSl51N+pKS81qanwy2he8rI2P69KwY8aqUXk8Zu0+VRR+eJJGfCfJba5N2SaGw8xvdotQbifCBPNcWVHO0g8b3sAGPryc37fSGZA6Eb+DpLzzS4jyDfaJkobF5T6W6UHRunvuYV2xf42D4g6ybkHfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3f90a583e07so42388885ab.3
        for <netdev@vger.kernel.org>; Tue, 09 Sep 2025 16:22:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757460149; x=1758064949;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jnEBjzXXCnEN9Z4xXeCe3IAYlAgM7d2+V3mhV5V+1+A=;
        b=kYKdiHMOg6SZZso7Od6tH6raBfQz3MAkh960ejAx45I54BeOjGDxkTXVjgLUIXuQjc
         Q3aEyncOEs37vUzak4xBrayv2rvGvCypUpywiQZvP2FMcXnEMLepesVFUVJ0HkaGrFKO
         dc8J+q1sd68Hzi6pfzKdw1S+gcrUjNXbsfBrpCC8ZyMjlaoj8bdyfcQGxNSdtlknFV8n
         dfCTK+kW3++W4N1TvwPWmqbJj0Wz5GtnWUKZn1wZrCfIG3GUQnMgW0ccNYVE66lLsMJT
         Cbm1cRgdwkaR9KXU5F6FD4bAxE78JxpqdF7S5ECXJebDd6YCnU9EGbOoCGbqBONO3phs
         8W9A==
X-Forwarded-Encrypted: i=1; AJvYcCUo/fFp1oPdABvGfOFspczUB0dJMkVnvXbzoLqExGSEEqwcYadg7YddAg5Odg45mECYRZTI+2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz24c1VBA1oW2soBs/ZNO/RWWNEEjVkPZJa/YguHLQm+Fpr65fT
	uk6r5kpJksXqIbfYkSpMc4aNNdLy45cotsluVFeQme7R1SGPcqtuzAEW5q++a8h+HsBwA1bNp/T
	xRWbxaPa1ddGLzATFvnkYvbvWnayjacOT6AdCbF0TaZ4uVwlkZST8kK1X/2k=
X-Google-Smtp-Source: AGHT+IEd798XZ99STM1eZw9Ep+jgK0MUgN7fq7ITzB6MDp1Fnz8NRVo+DDKGC3UMliGvH2e1S1GHFOeEhIgLiYFuAZPzgZIWQ5M3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:16cc:b0:3fc:733b:326 with SMTP id
 e9e14a558f8ab-3fd887c6538mr208877545ab.32.1757460149187; Tue, 09 Sep 2025
 16:22:29 -0700 (PDT)
Date: Tue, 09 Sep 2025 16:22:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68c0b6b5.050a0220.3c6139.0013.GAE@google.com>
Subject: [syzbot] [net?] WARNING in inet_sock_destruct (5)
From: syzbot <syzbot+4cabd1d2fa917a456db8@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3e8e5822146b Add linux-next specific files for 20250908
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=111b4642580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=69cfefa929ab96f7
dashboard link: https://syzkaller.appspot.com/bug?extid=4cabd1d2fa917a456db8
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=151b4642580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=131b4642580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/eaa87d8bc6ca/disk-3e8e5822.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6640e70f5002/vmlinux-3e8e5822.xz
kernel image: https://storage.googleapis.com/syzbot-assets/40f622291050/bzImage-3e8e5822.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+4cabd1d2fa917a456db8@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: net/ipv4/af_inet.c:156 at inet_sock_destruct+0x623/0x730 net/ipv4/af_inet.c:156, CPU#1: syz-executor/5983
Modules linked in:
CPU: 1 UID: 0 PID: 5983 Comm: syz-executor Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
RIP: 0010:inet_sock_destruct+0x623/0x730 net/ipv4/af_inet.c:156
Code: 0f 0b 90 e9 62 fe ff ff e8 7a db b5 f7 90 0f 0b 90 e9 95 fe ff ff e8 6c db b5 f7 90 0f 0b 90 e9 bb fe ff ff e8 5e db b5 f7 90 <0f> 0b 90 e9 e1 fe ff ff 89 f9 80 e1 07 80 c1 03 38 c1 0f 8c 9f fc
RSP: 0018:ffffc90000a08b48 EFLAGS: 00010246
RAX: ffffffff8a09d0b2 RBX: dffffc0000000000 RCX: ffff888024a23c80
RDX: 0000000000000100 RSI: 0000000000000fff RDI: 0000000000000000
RBP: 0000000000000fff R08: ffff88807e07c627 R09: 1ffff1100fc0f8c4
R10: dffffc0000000000 R11: ffffed100fc0f8c5 R12: ffff88807e07c380
R13: dffffc0000000000 R14: ffff88807e07c60c R15: 1ffff1100fc0f872
FS:  00005555604c4500(0000) GS:ffff888125af1000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00005555604df5c8 CR3: 0000000032b06000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 __sk_destruct+0x86/0x660 net/core/sock.c:2339
 rcu_do_batch kernel/rcu/tree.c:2605 [inline]
 rcu_core+0xca8/0x1770 kernel/rcu/tree.c:2861
 handle_softirqs+0x286/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1052 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1052
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:lock_acquire+0x175/0x360 kernel/locking/lockdep.c:5872
Code: 00 00 00 00 9c 8f 44 24 30 f7 44 24 30 00 02 00 00 0f 85 cd 00 00 00 f7 44 24 08 00 02 00 00 74 01 fb 65 48 8b 05 4b a0 25 11 <48> 3b 44 24 58 0f 85 f2 00 00 00 48 83 c4 60 5b 41 5c 41 5d 41 5e
RSP: 0018:ffffc90003bbfc58 EFLAGS: 00000206
RAX: 1b6cca55ab161300 RBX: 0000000000000000 RCX: 1b6cca55ab161300
RDX: 0000000000000001 RSI: ffffffff8ddabb49 RDI: ffffffff8c035e00
RBP: ffffffff81b797f6 R08: 0000000000000000 R09: ffffffff81b797f6
R10: dffffc0000000000 R11: ffffed1004fb251d R12: 0000000000000002
R13: ffffffff8e33c560 R14: 0000000000000000 R15: 0000000000000246
 rcu_lock_acquire include/linux/rcupdate.h:331 [inline]
 rcu_read_lock include/linux/rcupdate.h:841 [inline]
 cgroup_sk_alloc+0x42/0x3c0 kernel/cgroup/cgroup.c:7166
 sk_alloc+0x236/0x370 net/core/sock.c:2319
 inet_create+0x7a0/0x1000 net/ipv4/af_inet.c:326
 __sock_create+0x4b3/0x9f0 net/socket.c:1589
 sock_create net/socket.c:1647 [inline]
 __sys_socket_create net/socket.c:1684 [inline]
 __sys_socket+0xd7/0x1b0 net/socket.c:1731
 __do_sys_socket net/socket.c:1745 [inline]
 __se_sys_socket net/socket.c:1743 [inline]
 __x64_sys_socket+0x7a/0x90 net/socket.c:1743
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc298d90b07
Code: f0 ff ff 77 06 c3 0f 1f 44 00 00 48 c7 c2 a8 ff ff ff f7 d8 64 89 02 b8 ff ff ff ff c3 66 0f 1f 44 00 00 b8 29 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fffa1cc9538 EFLAGS: 00000202 ORIG_RAX: 0000000000000029
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fc298d90b07
RDX: 0000000000000006 RSI: 0000000000000001 RDI: 0000000000000002
RBP: 00007fffa1cc9c2c R08: 0000000000000000 R09: 00007fffa1cc9937
R10: 0000000000000000 R11: 0000000000000202 R12: 000000000000000a
R13: 00000000000927c0 R14: 0000000000015b9e R15: 00007fffa1cc9c80
 </TASK>
----------------
Code disassembly (best guess):
   0:	00 00                	add    %al,(%rax)
   2:	00 00                	add    %al,(%rax)
   4:	9c                   	pushf
   5:	8f 44 24 30          	pop    0x30(%rsp)
   9:	f7 44 24 30 00 02 00 	testl  $0x200,0x30(%rsp)
  10:	00
  11:	0f 85 cd 00 00 00    	jne    0xe4
  17:	f7 44 24 08 00 02 00 	testl  $0x200,0x8(%rsp)
  1e:	00
  1f:	74 01                	je     0x22
  21:	fb                   	sti
  22:	65 48 8b 05 4b a0 25 	mov    %gs:0x1125a04b(%rip),%rax        # 0x1125a075
  29:	11
* 2a:	48 3b 44 24 58       	cmp    0x58(%rsp),%rax <-- trapping instruction
  2f:	0f 85 f2 00 00 00    	jne    0x127
  35:	48 83 c4 60          	add    $0x60,%rsp
  39:	5b                   	pop    %rbx
  3a:	41 5c                	pop    %r12
  3c:	41 5d                	pop    %r13
  3e:	41 5e                	pop    %r14


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


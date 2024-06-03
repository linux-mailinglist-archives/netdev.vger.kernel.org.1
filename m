Return-Path: <netdev+bounces-100299-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C50BD8D86CB
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 17:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 018471C21656
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 15:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 873DA133291;
	Mon,  3 Jun 2024 15:59:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3489132126
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 15:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717430363; cv=none; b=aQzdbnqWtVi8CcrOjSC0ET4AM3eN/dmuG6OvjErpU0UQdWXDG79Ps1oKCYyzeHlSyf/LBcyY+hH2OMaA4lo+II3x9kSjgWQhha96SzqMfNN6euNk7FMKg/Uzmo07Xw/JcDAqpKMjO+KZ2kzicHb1mbXDohwecC00ervKb9QL0cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717430363; c=relaxed/simple;
	bh=ZS8XNDDIwqbPQNlOt0M8zUcP5ClXieEXFN6pdZB3NGE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=HrRcw+GlZMgnEmhw11t/xs9Jb3kJdUVQGnqZDlTud5TC6PP4dGilBK+tVslU6mwp23YLsTCDTUJMNBqLAVYBJFoFLFShD0opU4mMwl+zEroDU1ehgzcVM0DAs/aLjEguVY5CXEaG7w/DVwwTPlr6SFkTFfTr7rPB4iZBTz+YseQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e8e2ea7b4bso605117139f.0
        for <netdev@vger.kernel.org>; Mon, 03 Jun 2024 08:59:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717430361; x=1718035161;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rOknuMVBkACSavYBD9q8M++Rf/C5mn6knDTAqar4USA=;
        b=Hy8zk1ZG5scBQbHqH/mbmHw8DC+gSjHXjV3IKdLpRWidhV8Oy25TIEtRKECCPxbXlj
         iLor20UYP1JUhZqU3DemBjSNJ5XbcOpBOWB1pHNqUKcPi8HZVVr06to8rUcQJeTD1abt
         mlvoO7nnSzdryzktnEpYZ5jM0Adm+LKy2ljTQKF6hPQozZo7uIW8t2dewq2zdseEsJXA
         fPjmwucztMVlZ1bq+CrLMWzyq7O/lh+X3OYRJfzdxiINwFxiZ5UUKjKXdihk90ApfpYx
         B6YF1Y9nr3B42AlLPERAg/UIs0FmqnqCdn+P6ICBq05Nk9762v7IgM9BUZ8BqMUMm6mr
         SDKg==
X-Forwarded-Encrypted: i=1; AJvYcCVjDHAlFdMUJj+qwA/9X//ceWpvFNfOLty8XPav3OHXGxFHKbSicx9VGw6tvanKZvXmAmcKZdEj5bOqBdmAU80YJu+k9fBX
X-Gm-Message-State: AOJu0YwH8l5YeiS+6Nw1BXnKZLnDO8JNmi57qAiuJVmnXUI+nsq8H6sz
	LCdKwTrk8sUp1XpHCS5MMWzPVxzXbwUUHl7Zob5MRvsFZ5w0ADITl1z4mh1ilK4fr3YzGqfg8bZ
	Ddy7LojENAcMWY+D6UKrPFmvPi9wQ6HztXB9x5gyvoEE+bZB5yH4W7T4=
X-Google-Smtp-Source: AGHT+IGrseyfw7x6vaspKxO0tzZ7g3R4HV8zpSbRtzpepiBtuepTOnVDnPO6UtAowck+qrCh1gb8dkwnx2txh8QCaWrp+RXw6d60
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:6d0b:b0:7de:d6a0:d9c4 with SMTP id
 ca18e2360f4ac-7eafff3deecmr69850139f.2.1717430360954; Mon, 03 Jun 2024
 08:59:20 -0700 (PDT)
Date: Mon, 03 Jun 2024 08:59:20 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000009767ec0619fe6a1d@google.com>
Subject: [syzbot] [net?] UBSAN: array-index-out-of-bounds in
 llc_conn_state_process (2)
From: syzbot <syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    6d7ddd805123 Merge tag 'soc-fixes-6.9-3' of git://git.kern..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12596604980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=7144b4fe7fbf5900
dashboard link: https://syzkaller.appspot.com/bug?extid=628f93722c08dc5aabe0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/4d60cb47fbb1/disk-6d7ddd80.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3ff90de7db5/vmlinux-6d7ddd80.xz
kernel image: https://storage.googleapis.com/syzbot-assets/d452970444cd/bzImage-6d7ddd80.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+628f93722c08dc5aabe0@syzkaller.appspotmail.com

------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/llc/llc_conn.c:694:24
index -1 is out of range for type 'int [12][5]'
CPU: 0 PID: 15346 Comm: syz-executor.4 Not tainted 6.9.0-rc7-syzkaller-00023-g6d7ddd805123 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/02/2024
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x16c/0x1f0 lib/dump_stack.c:114
 ubsan_epilogue lib/ubsan.c:231 [inline]
 __ubsan_handle_out_of_bounds+0x110/0x150 lib/ubsan.c:429
 llc_find_offset net/llc/llc_conn.c:694 [inline]
 llc_qualify_conn_ev net/llc/llc_conn.c:401 [inline]
 llc_conn_service net/llc/llc_conn.c:366 [inline]
 llc_conn_state_process+0x1381/0x14e0 net/llc/llc_conn.c:72
 llc_process_tmr_ev net/llc/llc_c_ac.c:1445 [inline]
 llc_conn_tmr_common_cb+0x450/0x8e0 net/llc/llc_c_ac.c:1331
 call_timer_fn+0x1a0/0x610 kernel/time/timer.c:1793
 expire_timers kernel/time/timer.c:1844 [inline]
 __run_timers+0x74b/0xaf0 kernel/time/timer.c:2418
 __run_timer_base kernel/time/timer.c:2429 [inline]
 __run_timer_base kernel/time/timer.c:2422 [inline]
 run_timer_base+0x111/0x190 kernel/time/timer.c:2438
 run_timer_softirq+0x1a/0x40 kernel/time/timer.c:2448
 handle_softirqs+0x216/0x8f0 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu kernel/softirq.c:637 [inline]
 irq_exit_rcu+0xbb/0x120 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0x95/0xb0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lock_acquire+0x1f2/0x560 kernel/locking/lockdep.c:5722
Code: c1 05 0a 93 96 7e 83 f8 01 0f 85 ea 02 00 00 9c 58 f6 c4 02 0f 85 d5 02 00 00 48 85 ed 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01 c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24
RSP: 0018:ffffc900033df5e0 EFLAGS: 00000206
RAX: dffffc0000000000 RBX: 1ffff9200067bebe RCX: ffffffff816b01de
RDX: 0000000000000001 RSI: ffffffff8b0cb100 RDI: ffffffff8b6f57a0
RBP: 0000000000000200 R08: 0000000000000000 R09: fffffbfff27bba45
R10: ffffffff93ddd22f R11: 0000000000000000 R12: 0000000000000001
R13: 0000000000000000 R14: ffff888073a52d80 R15: 0000000000000000
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 __unix_dgram_recvmsg+0x267/0x1000 net/unix/af_unix.c:2426
 unix_dgram_recvmsg+0xd0/0x110 net/unix/af_unix.c:2531
 sock_recvmsg_nosec net/socket.c:1046 [inline]
 ____sys_recvmsg+0x5fe/0x6b0 net/socket.c:2801
 ___sys_recvmsg+0x115/0x1a0 net/socket.c:2845
 do_recvmmsg+0x2ba/0x750 net/socket.c:2939
 __sys_recvmmsg net/socket.c:3018 [inline]
 __do_sys_recvmmsg net/socket.c:3041 [inline]
 __se_sys_recvmmsg net/socket.c:3034 [inline]
 __x64_sys_recvmmsg+0x239/0x290 net/socket.c:3034
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcf/0x260 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6eefa7dd69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 e1 20 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007f6ef08350c8 EFLAGS: 00000246 ORIG_RAX: 000000000000012b
RAX: ffffffffffffffda RBX: 00007f6eefbac050 RCX: 00007f6eefa7dd69
RDX: 0000000000010106 RSI: 00000000200000c0 RDI: 0000000000000005
RBP: 00007f6eefaca49e R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000002 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007f6eefbac050 R15: 00007ffeec7fdc18
 </TASK>
---[ end trace ]---
----------------
Code disassembly (best guess):
   0:	c1 05 0a 93 96 7e 83 	roll   $0x83,0x7e96930a(%rip)        # 0x7e969311
   7:	f8                   	clc
   8:	01 0f                	add    %ecx,(%rdi)
   a:	85 ea                	test   %ebp,%edx
   c:	02 00                	add    (%rax),%al
   e:	00 9c 58 f6 c4 02 0f 	add    %bl,0xf02c4f6(%rax,%rbx,2)
  15:	85 d5                	test   %edx,%ebp
  17:	02 00                	add    (%rax),%al
  19:	00 48 85             	add    %cl,-0x7b(%rax)
  1c:	ed                   	in     (%dx),%eax
  1d:	74 01                	je     0x20
  1f:	fb                   	sti
  20:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  27:	fc ff df
* 2a:	48 01 c3             	add    %rax,%rbx <-- trapping instruction
  2d:	48 c7 03 00 00 00 00 	movq   $0x0,(%rbx)
  34:	48 c7 43 08 00 00 00 	movq   $0x0,0x8(%rbx)
  3b:	00
  3c:	48                   	rex.W
  3d:	8b                   	.byte 0x8b
  3e:	84                   	.byte 0x84
  3f:	24                   	.byte 0x24


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


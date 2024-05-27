Return-Path: <netdev+bounces-98183-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB63B8CFFC3
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 14:16:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 411AC1F22DFD
	for <lists+netdev@lfdr.de>; Mon, 27 May 2024 12:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747F015E5A4;
	Mon, 27 May 2024 12:16:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8DD015DBCB
	for <netdev@vger.kernel.org>; Mon, 27 May 2024 12:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716812188; cv=none; b=NguEXrEpFzq2Qp5EsWBEwjHWHn+P43Ns7k9CL0mqN4kuPwoLuaut/dQ/DvtlaNh6MsFkdU1g6HOwUvbq8WpoeFkrAIJCssTRqjsznQkvNfxcqDA2BW9j3i4IBc9t4HPq7b43NeWmMBpZ4UcSArPamMQgKdTuJSb3CnL3NPCl2M8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716812188; c=relaxed/simple;
	bh=0Xs6Jd3sV9IGvWRWFj/rI967zIXNhZpxXuAOEA36Q0I=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eUyov4kb89Q0j+vml9QSNwm7yleLva2jgSIKyRqFqW1AX+rbc48T9deAlh9mvuz8lm2gf+KF/SfsCOcXwzu4bfJPxTzbwvRuctSuHKjaERLmTeB7g3002AhTrNLjcGpzlvpWKm8IfFsKJrUjU6tZv5E+JMvQGMrXIW6O+wXTc0U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-7e92491e750so259408639f.1
        for <netdev@vger.kernel.org>; Mon, 27 May 2024 05:16:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716812186; x=1717416986;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/z4Omj5RIg/QQhNMDZEBFYzhotZe3ou1j3ini6fq1e0=;
        b=Fgwg4znI9P+30z33/IJqN/Invm66A117pezkn1RMpSlICyxUEorxp9izC73oDqNW3P
         eUTl4/XgUrkXMQqvgyyWfMJA5FQyYmFCmAqGcBNG48S+PyR+N/dwZSaRHTwlmiDJF8wC
         yl4DOvgZ+7+wa1hX5MEmfFjnBp2Yic1q6DSlBnjAziGNf+Nd/XJ2cfILD1K6vNbl2+H6
         iYE2JYzZURGlKW+I2ZsYinhKYIVP9dIezJPCoAOufAA5t8R3PXttp/y9VjOHmobJsRDo
         /uSLaGtRgZb62KYWKesVEV0s8xQ650BFi7r9dqrOk3qewFU6lWG7UUYHUqx5oLy8ibWX
         kP6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZcNSiV3gnmlTdm/+gQ11Gqsj1n0wAWbli365OFRNUQ60ZHmryDBFaHKHPumMp/OzeRTpwWXMLruUCIogrSr0rilD5WD1/
X-Gm-Message-State: AOJu0YwacwBBkCKnK5eP2mc+9ODAqutvSmOdoRNfp4vCIKSRIZ2r8ZRg
	MfGlYkE5DAwR8QYU+VRZwgbyd61qUjWhNTqMct1cMPakmc16B17Or8DkWdZz3Won5bcEV0sVYZb
	IY7PjCK8dCWPfHA+Qijmwbjgqw8a66sxv3tNJYqfVY4BEKnBDe4KuS/0=
X-Google-Smtp-Source: AGHT+IGy3mC2FuqII7Tcaafs7cXrNrQfFT7DdiZRNCdCixgECR2fdJBRjhMtIRsf+Lt/vFNXuUK/3OxzWhuPjEuPE5FcaZhU/rqS
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:60c4:b0:7e2:2f0e:5a65 with SMTP id
 ca18e2360f4ac-7e8c636bf0dmr56512039f.2.1716812185949; Mon, 27 May 2024
 05:16:25 -0700 (PDT)
Date: Mon, 27 May 2024 05:16:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000007d66bc06196e7c66@google.com>
Subject: [syzbot] [net?] INFO: rcu detected stall in packet_release
From: syzbot <syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com, willemdebruijn.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    3ab5720881a9 net: phy: at803x: replace msleep(1) with usle..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=16ac8a6ee80000
kernel config:  https://syzkaller.appspot.com/x/.config?x=8f565e10f0b1e1fc
dashboard link: https://syzkaller.appspot.com/bug?extid=a7d2b1d5d1af83035567
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1086b376e80000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16760ccee80000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/ab97503560c5/disk-3ab57208.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca56b0dccaf8/vmlinux-3ab57208.xz
kernel image: https://storage.googleapis.com/syzbot-assets/03161a7d4885/bzImage-3ab57208.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+a7d2b1d5d1af83035567@syzkaller.appspotmail.com

rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
rcu: 	0-...0: (1 GPs behind) idle=38bc/1/0x4000000000000000 softirq=6131/6133 fqs=5249
rcu: 	         hardirqs   softirqs   csw/system
rcu: 	 number:        0          0            0
rcu: 	cputime:        0          0            0   ==> 52510(ms)
rcu: 	(detected by 1, t=10502 jiffies, g=7301, q=303 ncpus=2)
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5101 Comm: syz-executor577 Not tainted 6.7.0-rc5-syzkaller-01533-g3ab5720881a9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
RIP: 0010:arch_atomic64_read arch/x86/include/asm/atomic64_64.h:15 [inline]
RIP: 0010:raw_atomic64_read include/linux/atomic/atomic-arch-fallback.h:2569 [inline]
RIP: 0010:atomic64_read include/linux/atomic/atomic-instrumented.h:1597 [inline]
RIP: 0010:taprio_set_budgets+0x144/0x310 net/sched/sch_taprio.c:681
Code: e8 03 48 89 44 24 28 e9 c1 00 00 00 e8 25 f6 e4 f8 48 8b 7c 24 20 be 08 00 00 00 e8 06 f7 3b f9 48 8b 44 24 28 42 80 3c 38 00 <0f> 85 6a 01 00 00 4c 63 64 24 08 48 8b 44 24 18 49 83 fc 0f 4c 8b
RSP: 0018:ffffc90000007d20 EFLAGS: 00000046
RAX: 1ffff110035e3e5c RBX: ffff8880152ecc84 RCX: ffffffff88a2a78a
RDX: ffffed10035e3e5d RSI: 0000000000000008 RDI: ffff88801af1f2e0
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffed10035e3e5c
R10: ffff88801af1f2e7 R11: 0000000000000002 R12: 0000000004000000
R13: ffff8880152ecc08 R14: 0000000000000008 R15: dffffc0000000000
FS:  0000555556770380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000020000600 CR3: 0000000072c1b000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <IRQ>
 advance_sched+0x5e1/0xc60 net/sched/sch_taprio.c:988
 __run_hrtimer kernel/time/hrtimer.c:1688 [inline]
 __hrtimer_run_queues+0x203/0xc20 kernel/time/hrtimer.c:1752
 hrtimer_interrupt+0x31b/0x800 kernel/time/hrtimer.c:1814
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1065 [inline]
 __sysvec_apic_timer_interrupt+0x105/0x400 arch/x86/kernel/apic/apic.c:1082
 sysvec_apic_timer_interrupt+0x90/0xb0 arch/x86/kernel/apic/apic.c:1076
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:649
RIP: 0010:queue_work_on+0x92/0x110 kernel/workqueue.c:1836
Code: ff 48 89 ee e8 9f c4 31 00 48 85 ed 75 3b e8 05 c9 31 00 9c 5b 81 e3 00 02 00 00 31 ff 48 89 de e8 83 c4 31 00 48 85 db 75 66 <e8> e9 c8 31 00 44 89 e8 5b 5d 41 5c 41 5d 41 5e 41 5f c3 e8 d6 c8
RSP: 0018:ffffc9000430f9d8 EFLAGS: 00000293
RAX: 0000000000000000 RBX: 0000000000000000 RCX: ffffffff8155d4ed
RDX: ffff888072d5d940 RSI: ffffffff8155d4f7 RDI: 0000000000000007
RBP: 0000000000000200 R08: 0000000000000007 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000008
R13: 0000000000000001 R14: ffff888013072800 R15: ffff888076207200
 queue_work include/linux/workqueue.h:562 [inline]
 synchronize_rcu_expedited_queue_work kernel/rcu/tree_exp.h:519 [inline]
 synchronize_rcu_expedited+0x5a2/0x800 kernel/rcu/tree_exp.h:1006
 synchronize_rcu+0x2f5/0x3b0 kernel/rcu/tree.c:3568
 synchronize_net+0x4e/0x60 net/core/dev.c:10989
 packet_release+0xb2c/0xdd0 net/packet/af_packet.c:3167
 __sock_release+0xae/0x260 net/socket.c:659
 sock_close+0x1c/0x20 net/socket.c:1419
 __fput+0x270/0xbb0 fs/file_table.c:394
 __fput_sync+0x47/0x50 fs/file_table.c:475
 __do_sys_close fs/open.c:1590 [inline]
 __se_sys_close fs/open.c:1575 [inline]
 __x64_sys_close+0x87/0xf0 fs/open.c:1575
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0x40/0x110 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fd03423c0c0
Code: ff f7 d8 64 89 02 48 c7 c0 ff ff ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 80 3d e1 df 07 00 00 74 17 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c
RSP: 002b:00007ffc9b2872b8 EFLAGS: 00000202 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fd03423c0c0
RDX: 0000000000000000 RSI: 00000000200007c0 RDI: 0000000000000003
RBP: 00000000000f4240 R08: 0000000000000000 R09: 0000000100000000
R10: 0000000000000000 R11: 0000000000000202 R12: 00007ffc9b287310
R13: 0000000000030165 R14: 00007ffc9b2872dc R15: 0000000000000003
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 2.242 msecs


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


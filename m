Return-Path: <netdev+bounces-189907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C6EAB47DC
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 01:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E48A11B41599
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 23:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BC1526739E;
	Mon, 12 May 2025 23:22:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DEE262FD9
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747092147; cv=none; b=mHMhO+8d+fJfDgktFooF4PpG78WIFw/PgekPzzIXreCvctlnEkiiuVO8YqW2bV4HdMRbKSMraH9HYt323oIIs4ZByYsBDSq/nr9FODc2UxqoZalTgGa1a3HHTxqmSzLu8g/5FyP+3KWKoaUccyXAF6Yad5dykBxPBJPbj5DaveQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747092147; c=relaxed/simple;
	bh=mVpt63udtk6/AFzIGNSEy4WNg2GM9eyFsu4e5iEmnVU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=d/+n83yx+Xx7mhaU67RMSv3yHdNEnMy2pGM8tdayBNHTc1PxdacjzVG/1hJf2t+0PGf8jBpBeVvtu4TJtWktdYxmf3KZpH5n3H2fcCMs8ApsJubDOZHJIwho+ITMVoxWkQ3GFgK2MhCOWE7B1ncJ4ax8faQmRz+ScTJarOljoGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-3da720e0c93so118820865ab.2
        for <netdev@vger.kernel.org>; Mon, 12 May 2025 16:22:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747092145; x=1747696945;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RRpdss/wPX8+GTs3i2u5ajN2oMTMbZjUVLxllbstDOI=;
        b=VHQ26Bc6/TKiCe3pO+/X4/nqgvcYNzaPoTSgIBYsavhadDKb16AaAWxyqQyUMWOHTe
         NvJnek+j2gUPGjDic3C/hhd7bsn8I+CAw9Q5vxy0FEodWhs9UfdEUI1Jlk0d8MVPCgQ1
         ZiJSKljyzyLaMK72bddz68UaGJzgO4xvkUyuzK0sUGEyZAvffEN5NcGx1j0VZCBJPjzK
         iMa9JuLIp64OdJXa/g0sP8ubp/wjtXOjdYHFG+u5wF/X7811OFY18ECiYcft4eqSEpm3
         4xX3j52ebHq4Vu9ivD67FU0ySeQ/EnBIn2dmxIIxrCEUtZCpNZHMdrCDmekvyTDMWTFv
         iUkA==
X-Forwarded-Encrypted: i=1; AJvYcCW07JXMT5N3/UATx5n76peErqIDEtKz0mTSdkyahEG+QwVIWS6vsVwxO+nK5C0McliwS2zrvBc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzL17UFqKAOn4uQVeVjr/H/RhsSdDlZmZ56jKwIsI/74xe+Xicq
	a8qDVnZEZNnK6V72cBA8Oh96GlNYLX5g2MHqDW87y/8ghkUreIkT0Lxp8n0x5R2ei1KTdT6POm9
	9Tpz3GpulMD3Xlod8tBRmwzUabSNOtGNgcDlghA9sccQ5AhesHTrOWXI=
X-Google-Smtp-Source: AGHT+IGTMOugB4Utp3Gn6N3dI0Mzhp6j9VTw5k+IewZulu6M38eLTHh+hTnP/9clDE1JdNJMEcyHqwrFNm0G5F77Yj9hkeIY2q3Z
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:cd8f:0:b0:3d9:668c:a702 with SMTP id
 e9e14a558f8ab-3da7e1eef9bmr167134355ab.9.1747092144754; Mon, 12 May 2025
 16:22:24 -0700 (PDT)
Date: Mon, 12 May 2025 16:22:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <682282b0.050a0220.f2294.00bc.GAE@google.com>
Subject: [syzbot] [net?] KASAN: global-out-of-bounds Read in in_dev_finish_destroy
From: syzbot <syzbot+dd3b9802ae13f63906d7@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    92a09c47464d Linux 6.15-rc5
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1238f8d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b39cb28b0a399ed3
dashboard link: https://syzkaller.appspot.com/bug?extid=dd3b9802ae13f63906d7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-92a09c47.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/9dd31988ea97/vmlinux-92a09c47.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4b4e78abb078/bzImage-92a09c47.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dd3b9802ae13f63906d7@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in ref_tracker_free+0x562/0x830 lib/ref_tracker.c:244
Read of size 1 at addr ffffffff9af9a490 by task kworker/u32:1/13

CPU: 3 UID: 0 PID: 13 Comm: kworker/u32:1 Not tainted 6.15.0-rc5-syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: netns cleanup_net
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 ref_tracker_free+0x562/0x830 lib/ref_tracker.c:244
 netdev_tracker_free include/linux/netdevice.h:4351 [inline]
 netdev_put include/linux/netdevice.h:4368 [inline]
 netdev_put include/linux/netdevice.h:4364 [inline]
 in_dev_finish_destroy+0xae/0x1d0 net/ipv4/devinet.c:258
 in_dev_put include/linux/inetdevice.h:290 [inline]
 inet_rcu_free_ifa+0x93/0xb0 net/ipv4/devinet.c:228
 rcu_do_batch kernel/rcu/tree.c:2568 [inline]
 rcu_core+0x799/0x14e0 kernel/rcu/tree.c:2824
 handle_softirqs+0x216/0x8e0 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0x109/0x170 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1049 [inline]
 sysvec_apic_timer_interrupt+0xa4/0xc0 arch/x86/kernel/apic/apic.c:1049
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:lockdep_unregister_key+0xdd/0x130 kernel/locking/lockdep.c:6613
Code: 48 89 ef e8 b5 fe ff ff 48 89 ef e8 cd e5 ff ff 89 c3 e8 f6 ee ff ff 9c 58 f6 c4 02 75 52 41 f7 c4 00 02 00 00 74 01 fb 84 db <75> 1b 5b 5d 41 5c e9 58 5d 0a 00 8b 05 06 83 ed 0e 31 db 85 c0 74
RSP: 0018:ffffc90000107808 EFLAGS: 00000246
RAX: 0000000000000046 RBX: 0000000000000000 RCX: 0000000000000001
RDX: 0000000000000000 RSI: ffffffff8dcd20c4 RDI: ffffffff8bf48260
RBP: ffffffff972ac028 R08: 000000000000c64e R09: ffffffff95c54c5c
R10: 0000000000000004 R11: 0000000000000000 R12: 0000000000000246
R13: ffff88804eaa8000 R14: ffff88804eaa84c0 R15: 0000000000000001
 __qdisc_destroy+0x11a/0x4a0 net/sched/sch_generic.c:1080
 qdisc_put+0xab/0xe0 net/sched/sch_generic.c:1106
 dev_shutdown+0x1d0/0x430 net/sched/sch_generic.c:1494
 unregister_netdevice_many_notify+0xad1/0x26f0 net/core/dev.c:11969
 unregister_netdevice_many net/core/dev.c:12046 [inline]
 default_device_exit_batch+0x853/0xaf0 net/core/dev.c:12538
 ops_exit_list+0x128/0x180 net/core/net_namespace.c:177
 cleanup_net+0x5c1/0xb30 net/core/net_namespace.c:654
 process_one_work+0x9cc/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3319 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3400
 kthread+0x3c2/0x780 kernel/kthread.c:464
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:153
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

The buggy address belongs to the variable:
 binder_devices+0x10/0x40

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1af9a
flags: 0xfff00000002000(reserved|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002000 ffffea00006be688 ffffea00006be688 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff9af9a380: 00 f9 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
 ffffffff9af9a400: 00 f9 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
>ffffffff9af9a480: 00 f9 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
                         ^
 ffffffff9af9a500: 00 00 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
 ffffffff9af9a580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9
==================================================================
----------------
Code disassembly (best guess):
   0:	48 89 ef             	mov    %rbp,%rdi
   3:	e8 b5 fe ff ff       	call   0xfffffebd
   8:	48 89 ef             	mov    %rbp,%rdi
   b:	e8 cd e5 ff ff       	call   0xffffe5dd
  10:	89 c3                	mov    %eax,%ebx
  12:	e8 f6 ee ff ff       	call   0xffffef0d
  17:	9c                   	pushf
  18:	58                   	pop    %rax
  19:	f6 c4 02             	test   $0x2,%ah
  1c:	75 52                	jne    0x70
  1e:	41 f7 c4 00 02 00 00 	test   $0x200,%r12d
  25:	74 01                	je     0x28
  27:	fb                   	sti
  28:	84 db                	test   %bl,%bl
* 2a:	75 1b                	jne    0x47 <-- trapping instruction
  2c:	5b                   	pop    %rbx
  2d:	5d                   	pop    %rbp
  2e:	41 5c                	pop    %r12
  30:	e9 58 5d 0a 00       	jmp    0xa5d8d
  35:	8b 05 06 83 ed 0e    	mov    0xeed8306(%rip),%eax        # 0xeed8341
  3b:	31 db                	xor    %ebx,%ebx
  3d:	85 c0                	test   %eax,%eax
  3f:	74                   	.byte 0x74


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


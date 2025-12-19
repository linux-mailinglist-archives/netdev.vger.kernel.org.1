Return-Path: <netdev+bounces-245532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DF0CD0555
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 15:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0D01430335AD
	for <lists+netdev@lfdr.de>; Fri, 19 Dec 2025 14:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9962324700;
	Fri, 19 Dec 2025 14:42:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f80.google.com (mail-oa1-f80.google.com [209.85.160.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1072C279358
	for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 14:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766155346; cv=none; b=oSKwz2PBGqJWA3lVOg9O7c/dkwmsi5LGvCswXJ3UwdcCzgV8QGC4gFwe49iAANjmU7465Yq5TWaIvi3iiUfwoAJdVy6pKNqB0rnowWNbs33FJ8txyiE8w+aCT7Zf5bmh9I0Jmqr7DbAreOf/p4tvqV00nVfHa5bhmZkgbXqWebY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766155346; c=relaxed/simple;
	bh=6B4MyvS1hNUCMEQCMxIvsv5fBOybaaqj2n49TeA3h6Y=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=UCsX3q7AJmKsDeotDGUuKYnBJbUog1zxzT9nwm0VE3nFf+0csVhb3+gnS1EhefElULaGPWFOIugp11VkjfWwf5PJhuRm9p61G36y5mGHFD3Syl5RL7n80j4VTJc5qrg/ffidaJgRG9aU1152jMW4hKQee5lloER5x2vMaiePPjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f80.google.com with SMTP id 586e51a60fabf-3ec31d72794so5602126fac.0
        for <netdev@vger.kernel.org>; Fri, 19 Dec 2025 06:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766155344; x=1766760144;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SVj2wIEZZjG0CS/zcv2WjJgasxf2+VT5dyS4d3f0uVc=;
        b=kaVl9QFI5+V+z3YhCLkNROr21XIiU7G95vgKW+iHL2EB/JXjDZYGB7U5vQxJZyNwp2
         +tjkDvSIONqg1WbBKdUMaqYDp8Ed+2A4xgoXrVTZ5oB+lrn54NAg3ZBxnGSYYJmZVepY
         3P3Q38xJqLewDKzb4a9u6cwwjxouVdPlpXzeyHb4T4G+ske4AqEs/n7w/5JLvMGpxQvj
         HP2pEqUp6O0bpFxup1w6zHorujfC9hltwgIO9JFbmpUc/889eGC2KbH4KVmaIHZRy07u
         YHfSiFqXEim6QQn3P7j2RIV303ocr8E35/6YGA5nqNuzD2Unw16LXse+H0J0rqFioY/o
         adbw==
X-Forwarded-Encrypted: i=1; AJvYcCU/X0Jg4N9kOW0XyPLr3GEu9yybtemsXbmRf6u6MyEPEXkG5CiCDfPUCM5vUPaU0qsq9nnMcyw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz95s/N/dPZ7nUSR4FsVbIIwq5WbK6k8YQVePbQa2SXBpHfx0T/
	3oL/w82fcDsBZz18PfT67RcXUe0W4IeFjuYHjOVh7ejf/HiH3Pk5aGoCrDgCyHvDLzPN9KtPhQP
	sBJg9+yHHFDTPN3CGwLA0BWS1Xuk5/6pl9e8mbMHkBOa6DYndp3gsOtJU9bs=
X-Google-Smtp-Source: AGHT+IHb29t8haQdVrH3Nj2h5m4tc30WKXaZQWALhg109mgIzQRUeYOm8f2M9hniN/DXeHX6BTZlA0rlKJFLt/dM8V5B6rcrP/sM
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:328c:b0:659:7cb2:78b1 with SMTP id
 006d021491bc7-65cfe666db9mr2213580eaf.4.1766155343957; Fri, 19 Dec 2025
 06:42:23 -0800 (PST)
Date: Fri, 19 Dec 2025 06:42:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6945644f.a70a0220.207337.0113.GAE@google.com>
Subject: [syzbot] [net?] [usb?] kernel BUG in dql_completed
From: syzbot <syzbot+5b55e49f8bbd84631a9c@syzkaller.appspotmail.com>
To: andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	netdev@vger.kernel.org, oneukum@suse.com, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    d358e5254674 Merge tag 'for-6.19/dm-changes' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1191799c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=b60f8d9470fe9d28
dashboard link: https://syzkaller.appspot.com/bug?extid=5b55e49f8bbd84631a9c
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/6023f764316a/disk-d358e525.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7d83b86d067e/vmlinux-d358e525.xz
kernel image: https://storage.googleapis.com/syzbot-assets/7fa17a04a4c5/bzImage-d358e525.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5b55e49f8bbd84631a9c@syzkaller.appspotmail.com

------------[ cut here ]------------
kernel BUG at lib/dynamic_queue_limits.c:99!
Oops: invalid opcode: 0000 [#1] SMP KASAN PTI
CPU: 1 UID: 0 PID: 5197 Comm: udevd Tainted: G             L      syzkaller #0 PREEMPT(full) 
Tainted: [L]=SOFTLOCKUP
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
RIP: 0010:dql_completed+0xbe1/0xbf0 lib/dynamic_queue_limits.c:99
Code: 93 61 fd e9 ae fc ff ff 89 d9 80 e1 07 fe c1 38 c1 0f 8c c2 fc ff ff 48 89 df e8 8a 92 61 fd e9 b5 fc ff ff e8 d0 40 fb fc 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90000a08a70 EFLAGS: 00010246
RAX: ffffffff84c66fe0 RBX: 00000000000000f1 RCX: ffff88807df58000
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 00000000000000f1
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000141154 R12: 1ffff1100fc56520
R13: 1ffff1100fc56519 R14: ffff88807e2b2904 R15: ffff88807e2b28c0
FS:  00007fdf0904e880(0000) GS:ffff888125f3a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000080159018 CR3: 000000007e786000 CR4: 00000000003526f0
Call Trace:
 <IRQ>
 netdev_tx_completed_queue include/linux/netdevice.h:3864 [inline]
 netdev_completed_queue include/linux/netdevice.h:3894 [inline]
 usbnet_bh+0x793/0x1020 drivers/net/usb/usbnet.c:1601
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 bh_worker+0x2b1/0x600 kernel/workqueue.c:3611
 tasklet_action+0xc/0x70 kernel/softirq.c:952
 handle_softirqs+0x27d/0x850 kernel/softirq.c:622
 __do_softirq kernel/softirq.c:656 [inline]
 invoke_softirq kernel/softirq.c:496 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:723
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:739
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1056 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1056
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:697
RIP: 0010:mas_wr_append lib/maple_tree.c:3718 [inline]
RIP: 0010:mas_wr_store_entry+0xe25/0x27b0 lib/maple_tree.c:3758
Code: 24 40 48 8b 4c 24 48 48 8d 1c c1 48 89 d8 48 c1 e8 03 42 80 3c 28 00 44 0f b6 7c 24 1c 74 08 48 89 df e8 3e 39 d5 f6 4c 89 33 <49> 8d 5c 24 48 48 89 d8 48 c1 e8 03 42 80 3c 28 00 74 08 48 89 df
RSP: 0018:ffffc90003106fe0 EFLAGS: 00000246
RAX: ffffc900031077cd RBX: 1ffff92000620ebd RCX: dffffc0000000000
RDX: 0000000000000000 RSI: 0000000000000009 RDI: 0000000000000008
RBP: ffffc90003107570 R08: ffff88807df58000 R09: 000000000000000a
R10: 0000000000000009 R11: 0000000000000000 R12: ffffc900031075c0
R13: dffffc0000000000 R14: ffff88807e776640 R15: 0000000000000009
 mas_insert+0x375/0x550 lib/maple_tree.c:4002
 mas_alloc_cyclic+0x207/0x700 lib/maple_tree.c:4048
 mtree_alloc_cyclic+0x181/0x220 lib/maple_tree.c:6092
 simple_offset_add+0xdc/0x190 fs/libfs.c:297
 shmem_mknod+0x232/0x360 mm/shmem.c:3884
 lookup_open fs/namei.c:4440 [inline]
 open_last_lookups fs/namei.c:4540 [inline]
 path_openat+0x18bb/0x3dd0 fs/namei.c:4784
 do_filp_open+0x1fa/0x410 fs/namei.c:4814
 do_sys_openat2+0x121/0x200 fs/open.c:1430
 do_sys_open fs/open.c:1436 [inline]
 __do_sys_openat fs/open.c:1452 [inline]
 __se_sys_openat fs/open.c:1447 [inline]
 __x64_sys_openat+0x138/0x170 fs/open.c:1447
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0xf80 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fdf088a7407
Code: 48 89 fa 4c 89 df e8 38 aa 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
RSP: 002b:00007fff05e7f490 EFLAGS: 00000202 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fdf0904e880 RCX: 00007fdf088a7407
RDX: 0000000000080141 RSI: 000055fcaafb702e RDI: ffffffffffffff9c
RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
R10: 00000000000001a4 R11: 0000000000000202 R12: 00000000ffffffff
R13: 00000000ffffffff R14: ffffffffffffffff R15: 0000000000000000
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:dql_completed+0xbe1/0xbf0 lib/dynamic_queue_limits.c:99
Code: 93 61 fd e9 ae fc ff ff 89 d9 80 e1 07 fe c1 38 c1 0f 8c c2 fc ff ff 48 89 df e8 8a 92 61 fd e9 b5 fc ff ff e8 d0 40 fb fc 90 <0f> 0b 66 66 66 66 2e 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90
RSP: 0018:ffffc90000a08a70 EFLAGS: 00010246
RAX: ffffffff84c66fe0 RBX: 00000000000000f1 RCX: ffff88807df58000
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 00000000000000f1
RBP: 0000000000000000 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffff52000141154 R12: 1ffff1100fc56520
R13: 1ffff1100fc56519 R14: ffff88807e2b2904 R15: ffff88807e2b28c0
FS:  00007fdf0904e880(0000) GS:ffff888125f3a000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000080159018 CR3: 000000007e786000 CR4: 00000000003526f0
----------------
Code disassembly (best guess):
   0:	24 40                	and    $0x40,%al
   2:	48 8b 4c 24 48       	mov    0x48(%rsp),%rcx
   7:	48 8d 1c c1          	lea    (%rcx,%rax,8),%rbx
   b:	48 89 d8             	mov    %rbx,%rax
   e:	48 c1 e8 03          	shr    $0x3,%rax
  12:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  17:	44 0f b6 7c 24 1c    	movzbl 0x1c(%rsp),%r15d
  1d:	74 08                	je     0x27
  1f:	48 89 df             	mov    %rbx,%rdi
  22:	e8 3e 39 d5 f6       	call   0xf6d53965
  27:	4c 89 33             	mov    %r14,(%rbx)
* 2a:	49 8d 5c 24 48       	lea    0x48(%r12),%rbx <-- trapping instruction
  2f:	48 89 d8             	mov    %rbx,%rax
  32:	48 c1 e8 03          	shr    $0x3,%rax
  36:	42 80 3c 28 00       	cmpb   $0x0,(%rax,%r13,1)
  3b:	74 08                	je     0x45
  3d:	48 89 df             	mov    %rbx,%rdi


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


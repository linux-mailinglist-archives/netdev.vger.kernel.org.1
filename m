Return-Path: <netdev+bounces-154446-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2DE79FDDA3
	for <lists+netdev@lfdr.de>; Sun, 29 Dec 2024 07:40:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A23E616194B
	for <lists+netdev@lfdr.de>; Sun, 29 Dec 2024 06:40:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5158626AEC;
	Sun, 29 Dec 2024 06:40:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBE326ACC
	for <netdev@vger.kernel.org>; Sun, 29 Dec 2024 06:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735454423; cv=none; b=mLoNyyuVvOkKihzaONtKLwVMafaKKlQlQ6daKv7J2rLpTDCzQLQXGI0Gxx6y4HM9yk0LywRULAs4PJspKGH5sDV64mUxwlPKi9O5yf2MiqPSp7fMLsJtyw5oFV5N9/ZmGIwfzQ8ctEGxBIis9zVLSvG4gxQRsm8HDZPmCUwvyW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735454423; c=relaxed/simple;
	bh=DpV2uZoLNRoHOBlqG37M4k3aa8Doeg8cXMuJ+ngPwZU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mU6m9UBvLXayZTrszNa3d9CDH/BwTMM+5z+WsvbIxT2btlNH5jGvIV9TZR1OR9pE10BH1JvgWWk1NE7CKG4cQwrh3fWqpTZS1ShBNPZnrVJd435FmiKqhVRY4X3Pi5fiV0xBWehHXLq+I11/WRWKi1wTJer7yqb+9ej2T7xeT1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3a9d075bdc3so149678185ab.3
        for <netdev@vger.kernel.org>; Sat, 28 Dec 2024 22:40:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735454421; x=1736059221;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WC4LwJpiHLySxeikMUCGptJ19A77oQDptYHxDG8RCBg=;
        b=dVqxmCT1l4E0zXnAYx7bYNOTBs4u2RdgIjOBeSC7tB7xZlPKotomfkWFbfjCHhG7fG
         2ypf9U/jd97DzeZGNih6RNuWWwrW5YC2KkcNEa/X0Ek/Xy3EK3kNimU36dFpNhtcjrkC
         SLmzwmNrXTBV6Diyo6a6tX74fUQC5xXEdIBHyZSvE9txRPOJYoXoWYt/h9Z+bdzQ+41k
         Ch337DXg46e11ZXIJ2TRepSY3Kl12vN0RHkJlfl3hoGHA53q8LbmtVGFw09DgxShG8MM
         TGHSVfLgn3gUrALvlKS4GwfYCyAKTn4eMJLXMH6KUQxsxJqnQ5mNHL47YpM6NrKpD+iD
         vcJQ==
X-Forwarded-Encrypted: i=1; AJvYcCXgDn8Adnybs7ZQAXt/N3GHdPkCX+yFyeIYXJGpcSSl80N3DHSUooA4s6mYu5Qp3K0Qln4Eq3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQaPeBg1vZc4xA8JIpfZe0hjer8GrduHN9OsK+MMLm9YCU6tdq
	YttIeKMsCBnwX8YFZhGd55eVtVdJiPcjW1wPG+8bv/+yqoyO5YijOvgDdE3Y+q2xqSmiwm0+fAB
	QDDEVyypoCd0tDZs4jKWvx16RtTJ/n3yTbSds3Os6T9bhzaB8EfhfAsc=
X-Google-Smtp-Source: AGHT+IEVm6+czO3IssVqmwV03dYa/SwQFz14zsbfBHCifKJ95orrHBegUw9qau28jhg1/R84aockky7DlRYvnuktvIQ0u3IFBHa4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1ca7:b0:3a7:1a65:2fbd with SMTP id
 e9e14a558f8ab-3c2d533ef0amr251732295ab.17.1735454420789; Sat, 28 Dec 2024
 22:40:20 -0800 (PST)
Date: Sat, 28 Dec 2024 22:40:20 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6770eed4.050a0220.2f3838.04a6.GAE@google.com>
Subject: [syzbot] [net?] WARNING: locking bug in task_tick_fair
From: syzbot <syzbot+0c4dbc3a5494dbdf1200@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9b2ffa6148b1 Merge tag 'mtd/fixes-for-6.13-rc5' of git://g..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=117fffe8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=aa8dc22aa6de51f5
dashboard link: https://syzkaller.appspot.com/bug?extid=0c4dbc3a5494dbdf1200
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-9b2ffa61.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/cd632c833a3f/vmlinux-9b2ffa61.xz
kernel image: https://storage.googleapis.com/syzbot-assets/25241b47c08c/bzImage-9b2ffa61.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0c4dbc3a5494dbdf1200@syzkaller.appspotmail.com

=============================
[ BUG: Invalid wait context ]
6.13.0-rc4-syzkaller-00012-g9b2ffa6148b1 #0 Not tainted
-----------------------------
syz-executor/5922 is trying to lock:
ffff88807ffd8298 (&zone->lock){-.-.}-{3:3}, at: rmqueue_bulk mm/page_alloc.c:2309 [inline]
ffff88807ffd8298 (&zone->lock){-.-.}-{3:3}, at: __rmqueue_pcplist+0x6bb/0x1600 mm/page_alloc.c:3003
other info that might help us debug this:
context-{2:2}
4 locks held by syz-executor/5922:
 #0: ffff888028dc8f18 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1623 [inline]
 #0: ffff888028dc8f18 (sk_lock-AF_INET){+.+.}-{0:0}, at: tcp_sendmsg+0x20/0x50 net/ipv4/tcp.c:1357
 #1: ffffffff8e1bb900 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #1: ffffffff8e1bb900 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #1: ffffffff8e1bb900 (rcu_read_lock){....}-{1:3}, at: __ip_queue_xmit+0x73/0x1970 net/ipv4/ip_output.c:471
 #2: ffff88806a63ebd8 (&rq->__lock){-.-.}-{2:2}, at: raw_spin_rq_lock_nested+0x29/0x130 kernel/sched/core.c:598
 #3: ffff88806a644c58 (&pcp->lock){+.+.}-{3:3}, at: spin_trylock include/linux/spinlock.h:361 [inline]
 #3: ffff88806a644c58 (&pcp->lock){+.+.}-{3:3}, at: rmqueue_pcplist mm/page_alloc.c:3032 [inline]
 #3: ffff88806a644c58 (&pcp->lock){+.+.}-{3:3}, at: rmqueue mm/page_alloc.c:3076 [inline]
 #3: ffff88806a644c58 (&pcp->lock){+.+.}-{3:3}, at: get_page_from_freelist+0x350/0x2f80 mm/page_alloc.c:3473
stack backtrace:
CPU: 0 UID: 0 PID: 5922 Comm: syz-executor Not tainted 6.13.0-rc4-syzkaller-00012-g9b2ffa6148b1 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <IRQ>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4826 [inline]
 check_wait_context kernel/locking/lockdep.c:4898 [inline]
 __lock_acquire+0x878/0x3c40 kernel/locking/lockdep.c:5176
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5849
 kasan_save_stack+0x42/0x60 mm/kasan/common.c:48
 task_tick_numa kernel/sched/fair.c:3616 [inline]
 task_tick_fair+0x524/0x8e0 kernel/sched/fair.c:13101
 local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1038 [inline]
 __sysvec_apic_timer_interrupt+0x10f/0x400 arch/x86/kernel/apic/apic.c:1055
R13: 000000000000ffff R14: 0000000000000000 R15: ffff888032c8e6c8


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


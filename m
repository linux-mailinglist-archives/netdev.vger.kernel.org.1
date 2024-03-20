Return-Path: <netdev+bounces-80746-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CB765880D4A
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 09:42:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 572AA1F23C24
	for <lists+netdev@lfdr.de>; Wed, 20 Mar 2024 08:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2804374C3;
	Wed, 20 Mar 2024 08:42:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com [209.85.166.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0722F38F84
	for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 08:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710924143; cv=none; b=W2HfqvQJcRQ/cG3qikh84G3+4DFAUXOc1QW9+Z5oBT9dZOyZ9WMqViQ0ZN+d2Q6ScSHNj6sWD/9hkfTLsy4GpdPMCpmbzv3eRJ2oc3SWYK4tJGuNe8TfjEsn/xqZumTwCv6WWIKH0V7PNvQk207Kj8cXEmNxY5P+oqVPNVfFqmU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710924143; c=relaxed/simple;
	bh=8R+8pHHqfT6dtAXr0gKaDFBoW2z/4w8pmg1sze2cRDE=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=e80Xh6R39LJIFwJQONdEAm1u+4D6TAp94jN4YNYMCnhG9FGepNEKzLZEV1Mq1xBr4ycOLRjaqqUSvZyVNK/ZZ2L34zG/Whwt7ATx4xH/pDmYXyiDZZLfhsnjpjHZxXzUr+bLtDmwTHX8QZ8LnGW9QnKECAcr38DspQq0s690Mks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f69.google.com with SMTP id ca18e2360f4ac-7cbf1ea053cso565033339f.1
        for <netdev@vger.kernel.org>; Wed, 20 Mar 2024 01:42:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710924141; x=1711528941;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NJo9BSMocNALtvqQ2QnVDTeK7qub3h9dTxH7whp8/KQ=;
        b=V7WdNeqtZk1Yxneo1ZqCiN8ql+mTRZJu24c0wb65H36id0b7XMeFY8Of+INUVlhHaF
         tlaq+7qlu9KUCleczaxrMHxI2xMuFuw8CvADUuLOhI6MGKhcbDgKHNvnaOxL1h2uelkb
         Y1mUxORw+m8Z5laHr2VcHOOvVxQzJf5VdffoHaJICOMYi5iIR+is/IzEbHvKVT05+pQ6
         x+F/7uEcl48okw1CgxMiIxtP+7buuKM8t4vrcw4uZPyrjsMx0s1Pvq9ZzOtz0Z46c1DW
         StBQTTp3xgFIPMKZ1IkRDYBLzNDROrJm1+ogk5vw0FxJrHaS4exG9c8w1kIRpBYIWAMt
         XB+g==
X-Forwarded-Encrypted: i=1; AJvYcCXRQOF04S/A2xAYqOJgnDWUfbWmbHIOLz8j6B78ynSVNZEWA3kWHlYp5iUTk1yIMwDFHzuwuYk9XU9xPFKmpAq8U4qMEtXZ
X-Gm-Message-State: AOJu0YybwFb2ERvWhdgniduhup6kxehcqdCt+iyKQzzbTLvoEJE2mMpv
	E8jRwzA4NbY+yJ8VZUhlw6ZyCZ2czzd11wwb+fQy/aA6qGP//CKknKfSnDztT8IfDLwjtjuJXzs
	GttNRYtBD4+Kqf2OmoJe0xpyW5xEVoSZEN9vUETDLrJ6ggZPScfUo3fE=
X-Google-Smtp-Source: AGHT+IE8rm6ifnv6lm3IfjiUY9+6ygJXGx10rSs/4NCR1KNIV2sbKI51XbpmOF1XIjF0HS4Vh23mGFNbU5io2OjBIySQZJemnvJd
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:13c3:b0:474:fce1:3f8c with SMTP id
 i3-20020a05663813c300b00474fce13f8cmr259145jaj.6.1710924141272; Wed, 20 Mar
 2024 01:42:21 -0700 (PDT)
Date: Wed, 20 Mar 2024 01:42:21 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000adb08b061413919e@google.com>
Subject: [syzbot] [bpf?] possible deadlock in trie_delete_elem
From: syzbot <syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com>
To: andrii@kernel.org, ast@kernel.org, bpf@vger.kernel.org, 
	daniel@iogearbox.net, eddyz87@gmail.com, haoluo@google.com, 
	john.fastabend@gmail.com, jolsa@kernel.org, kpsingh@kernel.org, 
	linux-kernel@vger.kernel.org, martin.lau@linux.dev, netdev@vger.kernel.org, 
	sdf@google.com, song@kernel.org, syzkaller-bugs@googlegroups.com, 
	yonghong.song@linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    32fa4366cc4d net: phy: fix phy_read_poll_timeout argument ..
git tree:       net
console+strace: https://syzkaller.appspot.com/x/log.txt?x=16f5d769180000
kernel config:  https://syzkaller.appspot.com/x/.config?x=6fb1be60a193d440
dashboard link: https://syzkaller.appspot.com/bug?extid=9d95beb2a3c260622518
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=14572985180000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1676fc6e180000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/bb05871df8fc/disk-32fa4366.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/a774323fb6ec/vmlinux-32fa4366.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1742ae20d76c/bzImage-32fa4366.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+9d95beb2a3c260622518@syzkaller.appspotmail.com

============================================
WARNING: possible recursive locking detected
6.8.0-syzkaller-05242-g32fa4366cc4d #0 Not tainted
--------------------------------------------
syz-executor217/5072 is trying to acquire lock:
ffff88802a0fd9f8 (&trie->lock){....}-{2:2}, at: trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:451

but task is already holding lock:
ffff88802a0fc9f8 (&trie->lock){....}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&trie->lock);
  lock(&trie->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

3 locks held by syz-executor217/5072:
 #0: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #0: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #0: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_map_update_value+0x3c4/0x540 kernel/bpf/syscall.c:202
 #1: ffff88802a0fc9f8 (&trie->lock){....}-{2:2}, at: trie_update_elem+0xcb/0xc10 kernel/bpf/lpm_trie.c:324
 #2: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:298 [inline]
 #2: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:750 [inline]
 #2: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: __bpf_trace_run kernel/trace/bpf_trace.c:2380 [inline]
 #2: ffffffff8e131920 (rcu_read_lock){....}-{1:2}, at: bpf_trace_run4+0x16e/0x490 kernel/trace/bpf_trace.c:2422

stack backtrace:
CPU: 0 PID: 5072 Comm: syz-executor217 Not tainted 6.8.0-syzkaller-05242-g32fa4366cc4d #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/29/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2e0 lib/dump_stack.c:106
 check_deadlock kernel/locking/lockdep.c:3062 [inline]
 validate_chain+0x15c1/0x58e0 kernel/locking/lockdep.c:3856
 __lock_acquire+0x1346/0x1fd0 kernel/locking/lockdep.c:5137
 lock_acquire+0x1e4/0x530 kernel/locking/lockdep.c:5754
 __raw_spin_lock_irqsave include/linux/spinlock_api_smp.h:110 [inline]
 _raw_spin_lock_irqsave+0xd5/0x120 kernel/locking/spinlock.c:162
 trie_delete_elem+0x96/0x6a0 kernel/bpf/lpm_trie.c:451
 bpf_prog_2c29ac5cdc6b1842+0x42/0x46
 bpf_dispatcher_nop_func include/linux/bpf.h:1234 [inline]
 __bpf_prog_run include/linux/filter.h:657 [inline]
 bpf_prog_run include/linux/filter.h:664 [inline]
 __bpf_trace_run kernel/trace/bpf_trace.c:2381 [inline]
 bpf_trace_run4+0x25a/0x490 kernel/trace/bpf_trace.c:2422
 trace_mm_page_alloc include/trace/events/kmem.h:177 [inline]
 __alloc_pages+0x657/0x680 mm/page_alloc.c:4591
 __alloc_pages_node include/linux/gfp.h:238 [inline]
 alloc_pages_node include/linux/gfp.h:261 [inline]
 __kmalloc_large_node+0x91/0x1f0 mm/slub.c:3926
 __do_kmalloc_node mm/slub.c:3969 [inline]
 __kmalloc_node+0x33c/0x4e0 mm/slub.c:3988
 kmalloc_node include/linux/slab.h:610 [inline]
 bpf_map_kmalloc_node+0xd3/0x1c0 kernel/bpf/syscall.c:422
 lpm_trie_node_alloc kernel/bpf/lpm_trie.c:291 [inline]
 trie_update_elem+0x1d3/0xc10 kernel/bpf/lpm_trie.c:333
 bpf_map_update_value+0x4d3/0x540 kernel/bpf/syscall.c:203
 map_update_elem+0x53a/0x6f0 kernel/bpf/syscall.c:1641
 __sys_bpf+0x76f/0x810 kernel/bpf/syscall.c:5619
 __do_sys_bpf kernel/bpf/syscall.c:5738 [inline]
 __se_sys_bpf kernel/bpf/syscall.c:5736 [inline]
 __x64_sys_bpf+0x7c/0x90 kernel/bpf/syscall.c:5736
 do_syscall_64+0xfb/0x240
 entry_SYSCALL_64_after_hwframe+0x6d/0x75
RIP: 0033:0x7f933485e7a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffc8852b528 EFLAGS: 00000246 ORIG_RAX: 0000000000000141
RAX: ffffffffffffffda RBX: 


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


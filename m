Return-Path: <netdev+bounces-214275-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 47AC4B28B6A
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 09:29:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8794A17832B
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 07:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2CB822A4D5;
	Sat, 16 Aug 2025 07:28:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7CD227EAA
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 07:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755329315; cv=none; b=liS5641aNpJiWo/rJGQkvwxj6Dz7ftb8da8JKHnHPnnPxO63q2IKca3llnWm5eTpJ9xQ6wYbKO6KErfFF6QwvUUyLjv5aquZWxm/I3oi7Z4yBbc49zqXQsZK/Eyf8QVPG5LYB6xEnav4qSkxq1c8vj3SJW9mpAt1MxCSIPhA0xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755329315; c=relaxed/simple;
	bh=JrB5cSg+IpZYdHhFkUFjjmDDAEPGVnUgwy59mGK2wy0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KIaR3byRddb0giPbrxcn8rkG+J9gQL04Rus0DM3gpgsbZ7RRUhIPdEisWDhBjvDJKCumjqxKttK07IjnbI/8Pnl/SnDxKzaa62rmrh7twWoxIvcvDy0mn2tixTeqWJDvz+/RDxHLLdgbqWb42IjsjRIHCAelpWJo6zXNnCJWG40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3e6649d783bso1007715ab.3
        for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 00:28:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755329313; x=1755934113;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9h/w0PHHXlYPVWDRA7UJ7b2X9Ic0+ZisyHghCWLnk+U=;
        b=rrib52MXL1or3uXeIExt2f+7KDcnck9ZaBs3a7EUUmYFoUyRbe9UGf+mZruSG7XVwY
         wC8iPymZz+1R1k8T8pQmV3qjiKwizB6CmmEWnWUj008Yt9oQAUse0KtnBU0n5UNpN9Or
         w5HsJ4XfCpSnglQD43XEaJ7fp3GhMu/K23QwhQ9fvdGNICegfXZjGf4lb9LiyNZLBEAt
         I3bBE9p6y31QOit1bPLWIY6keydGfTKchN/xQNihic8Ye0Pctqbm7M35k27bgftqjUBy
         xIqE0TWcvkDvkYTt+L5HKBBLOmXGg2NSiGwuPzpUUwDsi8rYjS0XSxEBkiu+DLMoZW5H
         XViw==
X-Forwarded-Encrypted: i=1; AJvYcCWsUJc/dfbafkjXOEsHRF2l/niauSR1hkSt6gmRze2+Ha+xBwICjEEK2IVnCCEJ2/CzvBCpXwU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLSr9LLlMa9aLJL+OfipuJcv5du/B/zaOKkwQlFlrcjFpGDW8H
	Bv9yM+DG7bIqzsUqgCnZFtWqbtRdKZUIRGKT2u2BqC8G8eR0duBG+rXc4+tu9hceVLlfkD+ktka
	is/TuhXO4+BaK9BJJzCeYud1PzslnGpX/sntZORLQnDohdD7RvPkNa6VHYTA=
X-Google-Smtp-Source: AGHT+IGGVfZ/cSBX7xevD4EgqL66lj5U0cKpIgKn0q98EKvNleK+tpRh4KatIlNYl/ohq+ZWEzOAbW1baqpHZgQKNE51iQy+TW/Q
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1889:b0:3e5:6313:4562 with SMTP id
 e9e14a558f8ab-3e57e8a7d35mr83025195ab.14.1755329313307; Sat, 16 Aug 2025
 00:28:33 -0700 (PDT)
Date: Sat, 16 Aug 2025 00:28:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68a03321.050a0220.e29e5.0040.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING: ODEBUG bug in bss_free
From: syzbot <syzbot+266cecacfaabc2ca17d0@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    8f5ae30d69d7 Linux 6.17-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12be85a2580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=412ee2f8b704a5e6
dashboard link: https://syzkaller.appspot.com/bug?extid=266cecacfaabc2ca17d0
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/005a27f2fde5/disk-8f5ae30d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/eedc3e5b0288/vmlinux-8f5ae30d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/400079450339/bzImage-8f5ae30d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+266cecacfaabc2ca17d0@syzkaller.appspotmail.com

------------[ cut here ]------------
ODEBUG: activate active (active state 1) object: ffff888057456e00 object type: rcu_head hint: 0x0
WARNING: CPU: 0 PID: 11283 at lib/debugobjects.c:615 debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Modules linked in:
CPU: 0 UID: 0 PID: 11283 Comm: kworker/u8:13 Not tainted 6.17.0-rc1-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 07/12/2025
Workqueue: netns cleanup_net
RIP: 0010:debug_print_object+0x16b/0x1e0 lib/debugobjects.c:612
Code: 4c 89 ff e8 57 19 53 fd 4d 8b 0f 48 c7 c7 a0 3c e3 8b 48 8b 34 24 4c 89 ea 89 e9 4d 89 f0 41 54 e8 8a 4a b3 fc 48 83 c4 08 90 <0f> 0b 90 90 ff 05 c7 af d3 0a 48 83 c4 08 5b 41 5c 41 5d 41 5e 41
RSP: 0018:ffffc9000b7674f8 EFLAGS: 00010282
RAX: 109ab45e96de0500 RBX: dffffc0000000000 RCX: ffff88806a35bc00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000002
RBP: 0000000000000001 R08: 0000000000000003 R09: 0000000000000004
R10: dffffc0000000000 R11: fffffbfff1bfa1ec R12: 0000000000000000
R13: ffffffff8be33e20 R14: ffff888057456e00 R15: ffffffff8b8bd3c0
FS:  0000000000000000(0000) GS:ffff888125c1c000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000080186000 CR3: 0000000078eae000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 00000000e08e800c DR6: 00000000ffff0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 debug_object_activate+0x26a/0x420 lib/debugobjects.c:842
 debug_rcu_head_queue kernel/rcu/rcu.h:236 [inline]
 kvfree_call_rcu+0x4f/0x410 mm/slab_common.c:1953
 bss_free+0xb9/0x250 net/wireless/scan.c:89
 bss_ref_put net/wireless/scan.c:143 [inline]
 cfg80211_put_bss+0x1e2/0x230 net/wireless/scan.c:3353
 cfg80211_dev_free+0x257/0x2d0 net/wireless/core.c:1226
 device_release+0x99/0x1c0 drivers/base/core.c:-1
 kobject_cleanup lib/kobject.c:689 [inline]
 kobject_release lib/kobject.c:720 [inline]
 kref_put include/linux/kref.h:65 [inline]
 kobject_put+0x22b/0x480 lib/kobject.c:737
 mac80211_hwsim_del_radio+0x2de/0x460 drivers/net/wireless/virtual/mac80211_hwsim.c:5677
 hwsim_exit_net+0x584/0x640 drivers/net/wireless/virtual/mac80211_hwsim.c:6554
 ops_exit_list net/core/net_namespace.c:198 [inline]
 ops_undo_list+0x497/0x990 net/core/net_namespace.c:251
 cleanup_net+0x4c5/0x800 net/core/net_namespace.c:682
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3f9/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>


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


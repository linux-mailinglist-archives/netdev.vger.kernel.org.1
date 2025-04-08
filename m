Return-Path: <netdev+bounces-180315-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F1ACCA80EA1
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 16:44:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7EF491BA8123
	for <lists+netdev@lfdr.de>; Tue,  8 Apr 2025 14:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA9F227EA8;
	Tue,  8 Apr 2025 14:39:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE83E2288C6
	for <netdev@vger.kernel.org>; Tue,  8 Apr 2025 14:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744123169; cv=none; b=V9wVtzFqh64S9iHOPAXKTgaFTVYafj6eDIdxguPO8au0ROpBuGRbg5R4N1VlWSTuilSNp7CcFjkJOGyaxq4l15OJMIHkPlDA+3hLsyQ/Mer6UeM7gZSL2Aqk3Gx5KxxI1Yy/OT2WDMwWCXBtqpJO9P3ldEaU3gGI5dOq52DIeIY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744123169; c=relaxed/simple;
	bh=rEJHiz1sxCyB6URKhlm9KiLdaxYkc91JehuW5IXtfEU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=lO0VZBfMDAfCBJ8XVRodho2IhigXSY9pDAFvPcFzI6YRDHHfHNxo/5O9tUOcTNCFbtrxk3fkGWXptPdRZIqjuysHNyCqEs+UVx2zuOw/g7wjQh8g0mvgyhR+U0J4rGtooWBWpjLhN0e0fjRaF3UX242FoyOr2Gvq0EiJGUVymUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ce843b51c3so131050525ab.0
        for <netdev@vger.kernel.org>; Tue, 08 Apr 2025 07:39:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744123167; x=1744727967;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HNvMevr6gqQGlgM9Y2LdUIkOQuIOUwVInna4Pr6J5Gg=;
        b=S6c47XEILLjDEO46Kztv3p0hGxtXj3s+zjffksLkiIjY8am89zFRnwFeBQtCImUOdl
         pndcr4r3ZEl2G3+C0Tx5/8E0+h29hW9E0wq0gZZbcN5dec+vJLxmi8fhVe4fVottQ0T1
         QecrAdcXaUJPC8ePb11nr4Z1SPeZ5HP1MJp7g8q/iclDMUOtdd29hRJXWKNYnU39hpfo
         L3gA+XDe4OZqqUSLxCE8tS+i4eurXIPzT3vKXHcJ29Ellg9b+cMCaJmS7oulkSF/o2Ut
         oMx21UQD5nSOlBduWe/58aAFGcQotfOGNPFdufmKRMlD8WYRvQf7OIlcpGTNFV3rR3o+
         R4kA==
X-Forwarded-Encrypted: i=1; AJvYcCXVfQ3d6gJaXEzfyjPyjzTBtQOHO2mYLGLff/XrcYP/pLTXvA1DouOCSKiWqKCJGW+YupfZMjY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl1e2CdI8BJ9y0BuIi71Uw4u5/zottUGxksTfIZpZpYV7V+aYI
	GXzYquA6yU/4iVERlG7HivhkmOSp4d1cVQ0FB1Wl0h7r65nQzKxMqnOo0O5fkeuFYQ6eEnGLWCj
	YQpQgoH4JZ5CT0kJH0UjdsFG1pKhYC6UAvfhDCASrGNH18P79K57ZLCQ=
X-Google-Smtp-Source: AGHT+IHO9cThJf3jioEpSNG9a3QwObAnt9qLh+VQ1A0OhP4Bvz+yJKF0MAkZVivC0zb9d5VFh8fW6DYDGNixBW1EZE8ipCVAiOqc
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2590:b0:3d3:de8a:630e with SMTP id
 e9e14a558f8ab-3d6ec57f03cmr126059585ab.16.1744123167102; Tue, 08 Apr 2025
 07:39:27 -0700 (PDT)
Date: Tue, 08 Apr 2025 07:39:27 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67f5351f.050a0220.12542b.0001.GAE@google.com>
Subject: [syzbot] [net?] WARNING in ipv6_add_dev
From: syzbot <syzbot+3ab016dc5f28b32452c1@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    0af2f6be1b42 Linux 6.15-rc1
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=166dffb0580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=66996a2350ef05e0
dashboard link: https://syzkaller.appspot.com/bug?extid=3ab016dc5f28b32452c1
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2bd38b4e51ec/disk-0af2f6be.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/928b4d433463/vmlinux-0af2f6be.xz
kernel image: https://storage.googleapis.com/syzbot-assets/9c0fa5febc31/bzImage-0af2f6be.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+3ab016dc5f28b32452c1@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 813 at ./include/net/netdev_lock.h:54 netdev_ops_assert_locked include/net/netdev_lock.h:54 [inline]
WARNING: CPU: 1 PID: 813 at ./include/net/netdev_lock.h:54 ipv6_add_dev+0x104c/0x1430 net/ipv6/addrconf.c:381
Modules linked in:
CPU: 1 UID: 0 PID: 813 Comm: kworker/u8:1 Not tainted 6.15.0-rc1-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Workqueue: events_unbound linkwatch_event
RIP: 0010:netdev_ops_assert_locked include/net/netdev_lock.h:54 [inline]
RIP: 0010:ipv6_add_dev+0x104c/0x1430 net/ipv6/addrconf.c:381
Code: ff ff e8 67 5d fe f6 48 bd 00 00 00 00 00 fc ff df 48 8b 3c 24 4c 8b 6c 24 18 4c 8b 64 24 28 e9 7f fc ff ff e8 45 5d fe f6 90 <0f> 0b 90 e9 64 f1 ff ff e8 37 5d fe f6 c6 05 16 e3 84 05 01 90 48
RSP: 0018:ffffc9001cbbf3d8 EFLAGS: 00010293
RAX: ffffffff8ac4f7db RBX: 0000000000000000 RCX: ffff88807a275a00
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffffffff8ac4e8fb R09: 1ffffffff201fa64
R10: dffffc0000000000 R11: fffffbfff201fa65 R12: ffff88805d942000
R13: ffff88805d942000 R14: dffffc0000000000 R15: ffff88805d942000
FS:  0000000000000000(0000) GS:ffff888125096000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000f5045ffc CR3: 0000000032240000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 ipv6_find_idev+0xc2/0x1e0 net/ipv6/addrconf.c:496
 addrconf_add_dev+0xbe/0x530 net/ipv6/addrconf.c:2560
 addrconf_dev_config net/ipv6/addrconf.c:3479 [inline]
 addrconf_init_auto_addrs+0x8f1/0xfe0 net/ipv6/addrconf.c:3567
 addrconf_notify+0xaff/0x1020 net/ipv6/addrconf.c:3740
 notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 netdev_state_change+0x123/0x1a0 net/core/dev.c:1536
 linkwatch_do_dev+0x112/0x170 net/core/link_watch.c:186
 __linkwatch_run_queue+0x451/0x6c0 net/core/link_watch.c:243
 linkwatch_event+0x4c/0x60 net/core/link_watch.c:286
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xac3/0x18e0 kernel/workqueue.c:3319
 worker_thread+0x870/0xd50 kernel/workqueue.c:3400
 kthread+0x7b7/0x940 kernel/kthread.c:464
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:153
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


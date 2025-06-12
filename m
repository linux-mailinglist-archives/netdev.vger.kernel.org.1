Return-Path: <netdev+bounces-197252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23638AD7F17
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 01:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC3A53B72B2
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 23:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B3522E7F01;
	Thu, 12 Jun 2025 23:41:29 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B7CE2E765D
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 23:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749771689; cv=none; b=V4DxnhIdeGUNp9srF4LpzpapwOrTN1iirZ99hr4egT2DNOYS5pe4IimS8ULBxlcSlHMUMZKYyjNpGlXjcxcYGC2YFbBh/F1ywY12NA/RpdXRFjH1uvYsDo29OLuf1MiM8SqQOUS2KI3ig6c7ibVKL+EKTrRokAod7MS5G+1GCzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749771689; c=relaxed/simple;
	bh=uBY7xNQg+tNA03tvbkiMqws3tHpqhv0Lp7Ij1/nnI+M=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cc1d493V8NA2oIQYiYiU06ZWmjrSzLnMmo5znp5vraJTPloEV5qbQm2inqIbQ3Z2wrmbzvIQscRjEsMmt7L39Cj1Gn8rspunZKGh1r7JW7Gp+AwqQ0wq9vt+LZoP6p0uEyBLZ5SIt4/ca65XUxbYLh4Yln/sDH7M30zug8zOeBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-3ddbd339f3dso16870605ab.0
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 16:41:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749771686; x=1750376486;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/v3lXQnQAInhUGFEhB4ef/LPPi0XF9azlmNMfdlDeDc=;
        b=wBjHDEDydFZQtvoOxtI6RDucjT2kyiXf+dQDCGMEWfb5aq7XemZto4aX0MJ+GcKZVH
         PyLEmCnHWCjm8UVBTiK9jm/PkvSJcQ6nu3DwbhgYASi6mb1e3tNrS7YE4Zg1WNn1BRnG
         JXvqfg3AFnT/S9CEfGIZysJL5n97f5wvJHiT2m/96R5Q2cJOqbSvv9xXNQ9tyRbbAPrg
         iev/VeIc2qYZBpX16MKZcDac+dq68HiXXtUbvumL7qrvQ/MTKW+a6PFNVn/h+AjgiPW/
         vTh4lzfKV5KV2nSCsdPKTvyB8kBQd8o8rNlbO4iBXEY1UA61xLWwh1RJkAVz+PJpT7Ty
         wRxw==
X-Forwarded-Encrypted: i=1; AJvYcCWbodgr6p10SwpgAk41wfao/2CT5daV/167URkqxXZ0ZlY6KF41W458YJ4bbDysv28xoxU9mwc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwT+jfCQRTNqjGcfZlywwCYWQ2nt4m9L/lxI/fo2oU/GLZnFXmh
	yrACJfR/XbV4fROn68LFPjYtyDv46Uq3k2Tbdkmm6471cr0yNO9T/NkH/fXR0c1qX2a7Vn01nZA
	eCf0f4dEMTLHEhUCGGJX94EpZvmu/7mNVOoedPHeES2XaXW2Hwppxj5sZJqc=
X-Google-Smtp-Source: AGHT+IHNW1jYIesUGOjqdbDQy35MMrSQ++myxvFepafLZ7BQnCBxgqG/kCFgc7gR9FKInPo6fjOE/kP3dpmUBb+Oo/BdaWuvO4Gv
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:12ee:b0:3dc:8423:5440 with SMTP id
 e9e14a558f8ab-3de00a151f1mr9928625ab.0.1749771686333; Thu, 12 Jun 2025
 16:41:26 -0700 (PDT)
Date: Thu, 12 Jun 2025 16:41:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <684b65a6.050a0220.be214.0295.GAE@google.com>
Subject: [syzbot] [atm?] KMSAN: uninit-value in atmtcp_c_send
From: syzbot <syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com>
To: 3chas3@gmail.com, linux-atm-general@lists.sourceforge.net, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2c4a1f3fe03e Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1787d9d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=42d51b7b9f9e61d
dashboard link: https://syzkaller.appspot.com/bug?extid=1d3c235276f62963e93a
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1195ed70580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=16187682580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/1313b3ad2bf4/disk-2c4a1f3f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/15f719cfdf88/vmlinux-2c4a1f3f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e7f531b0bef6/bzImage-2c4a1f3f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+1d3c235276f62963e93a@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in atmtcp_c_send+0x255/0xed0 drivers/atm/atmtcp.c:294
 atmtcp_c_send+0x255/0xed0 drivers/atm/atmtcp.c:294
 vcc_sendmsg+0xd7c/0xff0 net/atm/common.c:644
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2566
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2655
 x64_sys_call+0x32fb/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4154 [inline]
 slab_alloc_node mm/slub.c:4197 [inline]
 kmem_cache_alloc_node_noprof+0x818/0xf00 mm/slub.c:4249
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1336 [inline]
 vcc_sendmsg+0xb40/0xff0 net/atm/common.c:628
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x330/0x3d0 net/socket.c:727
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2566
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2620
 __sys_sendmsg net/socket.c:2652 [inline]
 __do_sys_sendmsg net/socket.c:2657 [inline]
 __se_sys_sendmsg net/socket.c:2655 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2655
 x64_sys_call+0x32fb/0x3db0 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0x210 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 1 UID: 0 PID: 5798 Comm: syz-executor192 Not tainted 6.16.0-rc1-syzkaller-00010-g2c4a1f3fe03e #0 PREEMPT(undef) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
=====================================================


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


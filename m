Return-Path: <netdev+bounces-242545-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4108C91EE1
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 13:04:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4356B3B08AD
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 12:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D7A30FF10;
	Fri, 28 Nov 2025 11:59:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f205.google.com (mail-il1-f205.google.com [209.85.166.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984D730F934
	for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 11:59:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764331168; cv=none; b=g6+UPG3iAhQ0oTmJptljLnJuuLFCV37h0xvLO6+ZJWSBDi4TOWaCkvg/cVAPEhk4P+EdkRDvQqieBlBl8DLOxCU0vwWGGbIpdPnH0bDDC3TCCLABle4j/yY0tbUZB5DNUwiZ1M5/Id/SiQAXU0gvIwOyZ86MfpT9AImQiO0cOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764331168; c=relaxed/simple;
	bh=df2qwGCmumY7BYhBZcGd5xjdK4qragLRJEszidDvsLQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=aGC2UqVndkARYyqWOthBl7XyL+dfNATe0sce/R31e6mTs4xqGphyQK2PauWYoew6MzTIW6R1i/QqUXMoF07Vt2u1JykBi9AZZgJFeIsFugR8c671ahgxjt2j/0LANc9oyF+6Oe+Oti2XaFS9GvMwT/0xV9ifqr127DwxGVM/SHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f205.google.com with SMTP id e9e14a558f8ab-43329b607e0so11778825ab.2
        for <netdev@vger.kernel.org>; Fri, 28 Nov 2025 03:59:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764331165; x=1764935965;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z2OOCyJkAxV+nB5fabSi6yCFVar1a9cOhGlfLzmWwTI=;
        b=YeH5v+XqdoQg6rGwwet9AgxBUvEj0VJGfPM+L97ryaEHM5+huHPXWnSWFevfKSAt9v
         27uE/+Btq7D/ov+FJE5qS6tsAHyzCH+/WMgUCCY+f6wCW9DnCzmJ6PVZo79u3jfQ0iUY
         TfYxaCx0cletghDN5STnXA3IlYrpm0elICzwKu4KLJsGWXBT9X+xHiPrWzJetDRj3CX0
         zVvVD5KADKGPeIOmeBJtxrrIPpI2H2qO3qG31U+6WAjnsK8VHyhKB+vRVreJOQrH4Z8z
         YEADbrsyp0u5Qa4YLJCv8rEzxwprkf69p7ypLPkYcCQuDRX/t9xGntfZ0xS+teyBAYpg
         LVTA==
X-Forwarded-Encrypted: i=1; AJvYcCVlqA0BHgj6qDz/bImDuYM7em8h2PXVg7Y3GHhbhh/7XU6bJpS1K9LK4avGUZAVMO/YEPn+UDY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwPe0IMaGNQLIlfjTaLEcAD3iBJZfq1mB9qJtjq5SVVjHr6BPmH
	kJHHpBW6bmB//w6YkD2bm70VgX7cFmljk8jshHub0D3gI2d5O/DTlk9TmWtbatfXS7UEqk5N6DR
	eQUh/nd2F8E0eSBs2Oequl5yoaiOqM/m/8BqjYJ64rKdLETRFbMLJMALZqxw=
X-Google-Smtp-Source: AGHT+IE+pj8HxWzSaXbI0SzfT0bEp0JkiBJLWb/+1hCkcuoF1blP8RtnWH0W6IBoejnPUROPCIZd1S4pXCmO2Q9/HqPVs8CjYLOt
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:3992:b0:433:308c:19a6 with SMTP id
 e9e14a558f8ab-435b8c2b893mr198281925ab.12.1764331165715; Fri, 28 Nov 2025
 03:59:25 -0800 (PST)
Date: Fri, 28 Nov 2025 03:59:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69298e9d.a70a0220.d98e3.013a.GAE@google.com>
Subject: [syzbot] [net?] KMSAN: uninit-value in lec_atm_send
From: syzbot <syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, horms@kernel.org, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ac3fd01e4c1e Linux 6.18-rc7
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=139a1612580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=61a9bf3cc5d17a01
dashboard link: https://syzkaller.appspot.com/bug?extid=5dd615f890ddada54057
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=10f4b8b4580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=129d0e58580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/227434a45737/disk-ac3fd01e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/d8117003dbb5/vmlinux-ac3fd01e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/a13125fb7a7d/bzImage-ac3fd01e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+5dd615f890ddada54057@syzkaller.appspotmail.com

=====================================================
BUG: KMSAN: uninit-value in lec_arp_update net/atm/lec.c:1845 [inline]
BUG: KMSAN: uninit-value in lec_atm_send+0x2b02/0x55b0 net/atm/lec.c:385
 lec_arp_update net/atm/lec.c:1845 [inline]
 lec_atm_send+0x2b02/0x55b0 net/atm/lec.c:385
 vcc_sendmsg+0x1052/0x1190 net/atm/common.c:650
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x333/0x3d0 net/socket.c:742
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2630
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2719
 x64_sys_call+0x1dfd/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Uninit was created at:
 slab_post_alloc_hook mm/slub.c:4985 [inline]
 slab_alloc_node mm/slub.c:5288 [inline]
 kmem_cache_alloc_node_noprof+0x989/0x16b0 mm/slub.c:5340
 kmalloc_reserve+0x13c/0x4b0 net/core/skbuff.c:579
 __alloc_skb+0x347/0x7d0 net/core/skbuff.c:670
 alloc_skb include/linux/skbuff.h:1383 [inline]
 vcc_sendmsg+0x602/0x1190 net/atm/common.c:628
 sock_sendmsg_nosec net/socket.c:727 [inline]
 __sock_sendmsg+0x333/0x3d0 net/socket.c:742
 ____sys_sendmsg+0x7e0/0xd80 net/socket.c:2630
 ___sys_sendmsg+0x271/0x3b0 net/socket.c:2684
 __sys_sendmsg net/socket.c:2716 [inline]
 __do_sys_sendmsg net/socket.c:2721 [inline]
 __se_sys_sendmsg net/socket.c:2719 [inline]
 __x64_sys_sendmsg+0x211/0x3e0 net/socket.c:2719
 x64_sys_call+0x1dfd/0x3e30 arch/x86/include/generated/asm/syscalls_64.h:47
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xd9/0xfa0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

CPU: 0 UID: 0 PID: 6068 Comm: syz.0.17 Not tainted syzkaller #0 PREEMPT(none) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 10/25/2025
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


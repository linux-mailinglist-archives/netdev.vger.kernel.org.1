Return-Path: <netdev+bounces-187642-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE3CAAA8815
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 18:41:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D1281895782
	for <lists+netdev@lfdr.de>; Sun,  4 May 2025 16:41:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62C351C6FE9;
	Sun,  4 May 2025 16:41:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f78.google.com (mail-io1-f78.google.com [209.85.166.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B79E1C84B7
	for <netdev@vger.kernel.org>; Sun,  4 May 2025 16:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746376892; cv=none; b=kwrgrQzYhr+JLy03S3hBgRdhY6Afscs8Aj8OQKpPDRbFxWUZ9NNI3wpAgO+3RT7gKifTLIOQbVv2wAQxJ+38d5UR8bMyNDQsrSd8Bih4/fYWzLjPtVfiC+V55GJBA0c5TtvC0RS8zGAvfG3dQ94FPfL2b2ovcI0mYnaP53cqhQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746376892; c=relaxed/simple;
	bh=kIUoSPeRICPPvmJitOqBEIjVzlnGAWmggQxNwCLJQLk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=Qz9WvnD97Rgjx3Gu4DsfIh5yilIcUmVbec9FFwG2N0+doJ12ckLuC+WMNy1d904wQr6k0TBProyoTdR6pdeaYheo11EaURW9rSZ9CaJZml6GQeAASJE0lgtJCLYRmDQRDrZSqf7wD8aQI6MwsCSeHIuaVOXHc39QRDjb7pVF9P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f78.google.com with SMTP id ca18e2360f4ac-86463467dddso357991439f.3
        for <netdev@vger.kernel.org>; Sun, 04 May 2025 09:41:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746376889; x=1746981689;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=1y7mLr6LB7Kg0wjeAns0ppO15euW50CxesN3waBZcYw=;
        b=RDFWu6uB5GnelCk4uII78l/wQSFhlppBVzjB+xKxYV35OK/wJDEK4ifVAmw39pRK70
         akYRd5Apts3RiLkgx/T6U8HzL4rc3u4pgkF7FqZoFjFjN5vQ8eRqdarCMLgy+fgU7CE7
         JZSOkthy4KOTjq9QhzDRN+s2ZDWWTa5qDJGHSnNCETIdm3d6y0CXrwCVUR+yh22IXLFW
         C8Te7kVaYKwSxZCMqBkJyOsTMsqpkQbQA4eYdyEukSpyrIoItdhbX61Zn7notxLSRnHv
         NF0vlj7Qq20Zi0shjoGqGqnlUj2Z8xnpMsiKfU0upxKsxJ0WVamo6fLw+UlTzFy6F5F3
         1F8w==
X-Forwarded-Encrypted: i=1; AJvYcCWkLdkOOlgSKu33Oj9aRabf/zVCiDVYHYRtrWJFRwfSOq/tTC93Nd0gvV/1e8P8E7tJnWnvr4E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw37lSzPD6CJ2qVB4tBMxG5ZMCscfePZl8jsHJv9WiWYyUEs9oX
	g/dYTvpM5EsIiP0vhP8J5OZHIRb2RNhM1E/Qeg+DgvVEFcqFxO6AYqd6fkjD52Zk6YRz9E5Zu28
	MWDsh6OhbFqsoA4DbUvFl0gCiBzc87xnNiN7uF/SItzZEyM/SSIuD0G8=
X-Google-Smtp-Source: AGHT+IH2mfTcU2xhZamann+fvbXzJfBSRHknCn9vWW10+/vvVzt14dkZ/XWiw1C4x2FlAH+ddznLf1tNaKuf70rLwpdE9E4gEcrD
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:2147:b0:3d6:cbed:3305 with SMTP id
 e9e14a558f8ab-3da5b27501cmr35921425ab.10.1746376889493; Sun, 04 May 2025
 09:41:29 -0700 (PDT)
Date: Sun, 04 May 2025 09:41:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681798b9.050a0220.11da1b.0032.GAE@google.com>
Subject: [syzbot] [net?] KASAN: global-out-of-bounds Read in fib6_ifup
From: syzbot <syzbot+0ea39a434b610c03f7ea@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2a239ffbebb5 Merge tag 'sound-6.15-rc5' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=12f8d8d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=541aa584278da96c
dashboard link: https://syzkaller.appspot.com/bug?extid=0ea39a434b610c03f7ea
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9b278a43c30b/disk-2a239ffb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6643e08be3ea/vmlinux-2a239ffb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/c8acd8502009/bzImage-2a239ffb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+0ea39a434b610c03f7ea@syzkaller.appspotmail.com

tipc: Started in network mode
tipc: Node identity 56b07f7dae81, cluster identity 4711
tipc: Enabled bearer <eth:syzkaller0>, priority 0
syzkaller0: entered promiscuous mode
syzkaller0: entered allmulticast mode
==================================================================
BUG: KASAN: global-out-of-bounds in fib6_ifup+0x257/0x2a0 net/ipv6/route.c:4815
Read of size 8 at addr ffffffff9af9a530 by task syz.5.7046/29528

CPU: 0 UID: 0 PID: 29528 Comm: syz.5.7046 Not tainted 6.15.0-rc4-syzkaller-00291-g2a239ffbebb5 #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/19/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 fib6_ifup+0x257/0x2a0 net/ipv6/route.c:4815
 fib6_clean_node+0x2a4/0x5b0 net/ipv6/ip6_fib.c:2199
 fib6_walk_continue+0x44f/0x8d0 net/ipv6/ip6_fib.c:2124
 fib6_walk+0x182/0x370 net/ipv6/ip6_fib.c:2172
 fib6_clean_tree+0xd4/0x110 net/ipv6/ip6_fib.c:2252
 __fib6_clean_all+0x107/0x2d0 net/ipv6/ip6_fib.c:2268
 rt6_sync_up+0xc9/0x170 net/ipv6/route.c:4837
 addrconf_notify+0x73d/0x19e0 net/ipv6/addrconf.c:3748
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2176
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 __dev_notify_flags+0x12c/0x2e0 net/core/dev.c:9405
 netif_change_flags+0x108/0x160 net/core/dev.c:9434
 dev_change_flags+0xba/0x250 net/core/dev_api.c:68
 dev_ifsioc+0x1498/0x1f70 net/core/dev_ioctl.c:565
 dev_ioctl+0x223/0x10e0 net/core/dev_ioctl.c:821
 sock_do_ioctl+0x19d/0x280 net/socket.c:1204
 sock_ioctl+0x227/0x6b0 net/socket.c:1311
 vfs_ioctl fs/ioctl.c:51 [inline]
 __do_sys_ioctl fs/ioctl.c:906 [inline]
 __se_sys_ioctl fs/ioctl.c:892 [inline]
 __x64_sys_ioctl+0x190/0x200 fs/ioctl.c:892
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xcd/0x260 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc72c38e969
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc72d1fc038 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
RAX: ffffffffffffffda RBX: 00007fc72c5b5fa0 RCX: 00007fc72c38e969
RDX: 0000200000002280 RSI: 0000000000008914 RDI: 0000000000000004
RBP: 00007fc72c410ab1 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fc72c5b5fa0 R15: 00007ffcaefaed28
 </TASK>

The buggy address belongs to the variable:
 __key.0+0x30/0x40

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1af9a
flags: 0xfff00000002000(reserved|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002000 ffffea00006be688 ffffea00006be688 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff9af9a400: 00 f9 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
 ffffffff9af9a480: 00 f9 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
>ffffffff9af9a500: 00 00 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
                                     ^
 ffffffff9af9a580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9
 ffffffff9af9a600: f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9 00 00 f9 f9
==================================================================


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


Return-Path: <netdev+bounces-187615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1D70AA8167
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 17:26:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B916A1B61C6D
	for <lists+netdev@lfdr.de>; Sat,  3 May 2025 15:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A6D2522AC;
	Sat,  3 May 2025 15:26:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 079101AA1E8
	for <netdev@vger.kernel.org>; Sat,  3 May 2025 15:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746285987; cv=none; b=YFnEM9wswVIzHygj1FCxIwxhS+YOUpu9GLZxIrOrjPLv2Q6R6mrouAmgynYmHiyw5QDPNTOagtqb9a83jOgkneHmVdr0dcu9H74C7FgcqPjcuiaHyZ7SNyp1gQH1hdTVzF5s7NW9xL4kKz9Ze3vCQFjmpyNfyfYKF5xPoy0o+6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746285987; c=relaxed/simple;
	bh=r11E+HpnRZYCNiloV1sknkTKk2/42qd15cojiZBEXf0=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=ZEXumkY5lXvQGJIoipaTqxVJ5MnuKVqqioYgsuMNp9id/tRThKZOnsShvbbgpdvtkB9kcE7iQ7oGcxwCCT6nRmJ+an+ZqidGQI6+oMqv5HSHBZ7p/M+O4yVqr5AdaELKukZFU0VgbON8R6hxMaSQkvvRqAL2wkczHmLBWL/uB3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d8eda6c48cso41889795ab.0
        for <netdev@vger.kernel.org>; Sat, 03 May 2025 08:26:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746285985; x=1746890785;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FjEQiCQ1advZTEcLfEU1Q4dTXCIr3UpII6DXMN8vdK8=;
        b=dovmfYN65Imf7V5EkbQgmIj8e4Ua0H0b3J5LQxjbV6fgeakMzOY15YsX7Xk/QNB4T7
         HMAGozsFKyM7uUKQx4gO+aNXEI37cLdYTC+o1MlEZ5pTgYlukOxvtSuq4rmCfZjSeaZR
         r6/gvvHdwWCSJPCMLKhQWfr7QDkLX/WOok4T5Fk8fRZhAT42gqBzjinopJt31uwkaSly
         orQMuWNU7WpAdOlaOWF06CkBUZIkU7IIfb8FdTzoCO0nN53iWdF8qeW/pm6UOB6pPIWx
         v2GH5XI76rPfqwrZVur0yYmD3k9Vd/fHn/fkVm0f0TY9mBoj0MMEbHGCIt2tNDNWmQjs
         RL0Q==
X-Forwarded-Encrypted: i=1; AJvYcCVYATQjYHEkGO+T7lAuW0LkPGQ3a6Xq6pSwXUtdTaw8+VvRyqMo6bBtNkDjjZowZJigTKKL1bk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2K1eQuTIBAyAurXk2NqPNfR7XWDT8UO2qWq6M+zJ2LL7nbpVK
	Xv2+7gfwWoKMrycm8k0E/DZeu3arurBzKyCpnf/v1VB3Ztb5RRVU8cnJVtK9oFExLi4LcTPSJu6
	Kwd9dS9b9IOTrBJQ0HalcJDgSeKZRvqTP3frwc4f6DQJpL2gvPT3gtPU=
X-Google-Smtp-Source: AGHT+IEwI6B+dlKHv/y/aEPxt0aVvx7ZJ7WD6o5hHU84RsVaN6gwX/WD2oCD2wet+VskTJ0A07Ju6JKY057qQT4hNakRZV6worUV
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:17c7:b0:3d9:6d60:709e with SMTP id
 e9e14a558f8ab-3d97ada9f06mr73351205ab.4.1746285985151; Sat, 03 May 2025
 08:26:25 -0700 (PDT)
Date: Sat, 03 May 2025 08:26:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <681635a1.a70a0220.254cdc.001e.GAE@google.com>
Subject: [syzbot] [net?] KASAN: global-out-of-bounds Read in fib6_ifdown (2)
From: syzbot <syzbot+ba503006f24effba2ba0@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    95d3481af6dc Merge tag 'spi-fix-v6.15-rc4' of git://git.ke..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=16fe6a70580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=541aa584278da96c
dashboard link: https://syzkaller.appspot.com/bug?extid=ba503006f24effba2ba0
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13bca0f4580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7feb34a89c2a/non_bootable_disk-95d3481a.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/6ece5d5205be/vmlinux-95d3481a.xz
kernel image: https://storage.googleapis.com/syzbot-assets/eba7ece24cf0/bzImage-95d3481a.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba503006f24effba2ba0@syzkaller.appspotmail.com

==================================================================
BUG: KASAN: global-out-of-bounds in fib6_ifdown+0x7f5/0x8f0 net/ipv6/route.c:4901
Read of size 8 at addr ffffffff9af98530 by task syz-executor/19807

CPU: 3 UID: 0 PID: 19807 Comm: syz-executor Not tainted 6.15.0-rc4-syzkaller-00256-g95d3481af6dc #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_address_description mm/kasan/report.c:408 [inline]
 print_report+0xc3/0x670 mm/kasan/report.c:521
 kasan_report+0xe0/0x110 mm/kasan/report.c:634
 fib6_ifdown+0x7f5/0x8f0 net/ipv6/route.c:4901
 fib6_clean_node+0x2a4/0x5b0 net/ipv6/ip6_fib.c:2199
 fib6_walk_continue+0x44f/0x8d0 net/ipv6/ip6_fib.c:2124
 fib6_walk+0x182/0x370 net/ipv6/ip6_fib.c:2172
 fib6_clean_tree+0xd4/0x110 net/ipv6/ip6_fib.c:2252
 __fib6_clean_all+0x107/0x2d0 net/ipv6/ip6_fib.c:2268
 rt6_sync_down_dev net/ipv6/route.c:4951 [inline]
 rt6_disable_ip+0x2ec/0x990 net/ipv6/route.c:4956
 addrconf_ifdown.isra.0+0x11d/0x1a90 net/ipv6/addrconf.c:3854
 addrconf_notify+0x220/0x19e0 net/ipv6/addrconf.c:3777
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:85
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:2176
 call_netdevice_notifiers_extack net/core/dev.c:2214 [inline]
 call_netdevice_notifiers net/core/dev.c:2228 [inline]
 dev_close_many+0x319/0x630 net/core/dev.c:1731
 unregister_netdevice_many_notify+0x578/0x26f0 net/core/dev.c:11952
 unregister_netdevice_many net/core/dev.c:12046 [inline]
 unregister_netdevice_queue+0x305/0x3f0 net/core/dev.c:11889
 unregister_netdevice include/linux/netdevice.h:3374 [inline]
 __tun_detach+0x1249/0x1540 drivers/net/tun.c:620
 tun_detach drivers/net/tun.c:636 [inline]
 tun_chr_close+0xc2/0x230 drivers/net/tun.c:3390
 __fput+0x3ff/0xb70 fs/file_table.c:465
 task_work_run+0x14d/0x240 kernel/task_work.c:227
 exit_task_work include/linux/task_work.h:40 [inline]
 do_exit+0xafb/0x2c30 kernel/exit.c:953
 do_group_exit+0xd3/0x2a0 kernel/exit.c:1102
 get_signal+0x2673/0x26d0 kernel/signal.c:3034
 arch_do_signal_or_restart+0x8f/0x7d0 arch/x86/kernel/signal.c:337
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x260 arch/x86/entry/syscall_64.c:100
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fae80990887
Code: Unable to access opcode bytes at 0x7fae8099085d.
RSP: 002b:00007ffc98e694b8 EFLAGS: 00000206 ORIG_RAX: 0000000000000029
RAX: 0000000000000003 RBX: 0000000000000003 RCX: 00007fae80990887
RDX: 0000000000000006 RSI: 0000000000000001 RDI: 000000000000000a
RBP: 00007ffc98e69bec R08: 00007ffc98e694dc R09: 0079746972756365
R10: 00007ffc98e69540 R11: 0000000000000206 R12: 00007fae80b7ec80
R13: 00000000000927c0 R14: 000000000003d637 R15: 00007fae80b80e40
 </TASK>

The buggy address belongs to the variable:
 __key.0+0x30/0x40

The buggy address belongs to the physical page:
page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x1af98
flags: 0xfff00000002000(reserved|node=0|zone=1|lastcpupid=0x7ff)
raw: 00fff00000002000 ffffea00006be608 ffffea00006be608 0000000000000000
raw: 0000000000000000 0000000000000000 00000001ffffffff 0000000000000000
page dumped because: kasan: bad access detected
page_owner info is not present (never set?)

Memory state around the buggy address:
 ffffffff9af98400: 00 f9 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
 ffffffff9af98480: 00 f9 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
>ffffffff9af98500: 00 00 f9 f9 f9 f9 f9 f9 00 f9 f9 f9 f9 f9 f9 f9
                                     ^
 ffffffff9af98580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 f9
 ffffffff9af98600: f9 f9 f9 f9 00 00 f9 f9 f9 f9 f9 f9 00 00 f9 f9
==================================================================


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


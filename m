Return-Path: <netdev+bounces-51052-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 048D97F8CCC
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 18:33:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E6BF1C20ABC
	for <lists+netdev@lfdr.de>; Sat, 25 Nov 2023 17:33:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B8D2CCAD;
	Sat, 25 Nov 2023 17:33:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C32B8E
	for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 09:33:09 -0800 (PST)
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-5be39ccc2e9so3957673a12.3
        for <netdev@vger.kernel.org>; Sat, 25 Nov 2023 09:33:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700933589; x=1701538389;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KJ/lJwJ9V8LGwXeSxUY6Bh74FRjOczfLYNMObLeTU0s=;
        b=OJ1XPyic+bhsUaFw0iSy0MxVwOihyB8xqF5fO8utfZiEJXJd5tha0M9lsgWbx/unlp
         HOV8tGVyMkOKoNyzgdt6SJfO5/6GXxaaolm0dgdQS87Ach+4SqW0JfS4be3QPA749A/r
         u6bAnRtCsHQp4W/DkCyQB0Uf/SAXEl0Oi4isoEhQmPMoYKetH7UB0eaSgIGNnlPII0cQ
         kl1Dg5jnNBiSaZzbGF/xVOmwScdSZh9RHsSFLDw3KhC11VKZEJUIM2119xHXoBTSkgCO
         IFWIA778rIF0eCmwfP0wV1Pbi+t3YMlULUAWGQt1vHEe/Cc8ffdHGqn8UXYNVdVWjKRw
         C0Hg==
X-Gm-Message-State: AOJu0Yyv3R+3pg/I6EsHGrL191aEF2AgZanl8aL8xvgxwCo4DfflHOvi
	+KxBruWEp2NRHjK7hb9w0Q/jdhSb+Xn42qcSyUmWQ8ZStnGH
X-Google-Smtp-Source: AGHT+IH9QCmG5am2wMlm0N4WzERSxGZC1RohWc0XXc1spCdVI1M0xOx2QZAXMQ54cAgwrTQweshwGy6HaPJAwsnxgG7O75zGNYJ4
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a63:1049:0:b0:5bd:3a19:e5ab with SMTP id
 9-20020a631049000000b005bd3a19e5abmr1004663pgq.7.1700933588924; Sat, 25 Nov
 2023 09:33:08 -0800 (PST)
Date: Sat, 25 Nov 2023 09:33:08 -0800
In-Reply-To: <8aa60891-cd52-42c0-b9a2-594d69b133fd@siddh.me>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000005abf1f060afd76bd@google.com>
Subject: Re: [syzbot] [net?] [nfc?] KASAN: slab-use-after-free Read in nfc_alloc_send_skb
From: syzbot <syzbot+bbe84a4010eeea00982d@syzkaller.appspotmail.com>
To: code@siddh.me, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot has tested the proposed patch but the reproducer is still triggering an issue:
BUG: sleeping function called from invalid context in nfc_llcp_socket_release

BUG: sleeping function called from invalid context at kernel/locking/mutex.c:580
in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 5478, name: syz-executor.0
preempt_count: 2, expected: 0
RCU nest depth: 0, expected: 0
2 locks held by syz-executor.0/5478:
 #0: ffff88806cd22468 (&local->sockets.lock){++++}-{2:2}, at: nfc_llcp_socket_release+0x56/0xb90 net/nfc/llcp_core.c:90
 #1: ffff88806cd5c0b0 (slock-AF_NFC){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #1: ffff88806cd5c0b0 (slock-AF_NFC){+.+.}-{2:2}, at: nfc_llcp_socket_release+0xcb/0xb90 net/nfc/llcp_core.c:95
Preemption disabled at:
[<0000000000000000>] 0x0
CPU: 0 PID: 5478 Comm: syz-executor.0 Not tainted 6.7.0-rc2-syzkaller-00198-g7ac1c88a5daa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 __might_resched+0x5cf/0x780 kernel/sched/core.c:10151
 __mutex_lock_common kernel/locking/mutex.c:580 [inline]
 __mutex_lock+0xc1/0xd60 kernel/locking/mutex.c:747
 nfc_llcp_sock_close net/nfc/llcp_core.c:33 [inline]
 nfc_llcp_socket_release+0x498/0xb90 net/nfc/llcp_core.c:120
 local_cleanup+0x28/0xe0 net/nfc/llcp_core.c:161
 nfc_llcp_unregister_device+0x160/0x240 net/nfc/llcp_core.c:1655
 nfc_unregister_device+0x167/0x2a0 net/nfc/core.c:1179
 virtual_ncidev_close+0x59/0x90 drivers/nfc/virtual_ncidev.c:163
 __fput+0x3cc/0xa10 fs/file_table.c:394
 __do_sys_close fs/open.c:1590 [inline]
 __se_sys_close+0x15f/0x220 fs/open.c:1575
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fe8ddc7b9da
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007fffdaf3d080 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe8ddc7b9da
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fe8ddd9d980 R08: 0000001b2e060000 R09: 00007fffdaf810b0
R10: 00007fffdaf81080 R11: 0000000000000293 R12: 00000000000151df
R13: ffffffffffffffff R14: 00007fe8dd800000 R15: 0000000000014e9e
 </TASK>

=============================
[ BUG: Invalid wait context ]
6.7.0-rc2-syzkaller-00198-g7ac1c88a5daa #0 Tainted: G        W         
-----------------------------
syz-executor.0/5478 is trying to lock:
ffff88806cd5c590 (&llcp_sock->lock){+.+.}-{3:3}, at: nfc_llcp_sock_close net/nfc/llcp_core.c:33 [inline]
ffff88806cd5c590 (&llcp_sock->lock){+.+.}-{3:3}, at: nfc_llcp_socket_release+0x498/0xb90 net/nfc/llcp_core.c:120
other info that might help us debug this:
context-{4:4}
2 locks held by syz-executor.0/5478:
 #0: ffff88806cd22468 (&local->sockets.lock){++++}-{2:2}, at: nfc_llcp_socket_release+0x56/0xb90 net/nfc/llcp_core.c:90
 #1: ffff88806cd5c0b0 (slock-AF_NFC){+.+.}-{2:2}, at: spin_lock include/linux/spinlock.h:351 [inline]
 #1: ffff88806cd5c0b0 (slock-AF_NFC){+.+.}-{2:2}, at: nfc_llcp_socket_release+0xcb/0xb90 net/nfc/llcp_core.c:95
stack backtrace:
CPU: 0 PID: 5478 Comm: syz-executor.0 Tainted: G        W          6.7.0-rc2-syzkaller-00198-g7ac1c88a5daa #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x1e7/0x2d0 lib/dump_stack.c:106
 print_lock_invalid_wait_context kernel/locking/lockdep.c:4750 [inline]
 check_wait_context kernel/locking/lockdep.c:4820 [inline]
 __lock_acquire+0x1825/0x7f70 kernel/locking/lockdep.c:5086
 lock_acquire+0x1e3/0x520 kernel/locking/lockdep.c:5753
 __mutex_lock_common kernel/locking/mutex.c:603 [inline]
 __mutex_lock+0x136/0xd60 kernel/locking/mutex.c:747
 nfc_llcp_sock_close net/nfc/llcp_core.c:33 [inline]
 nfc_llcp_socket_release+0x498/0xb90 net/nfc/llcp_core.c:120
 local_cleanup+0x28/0xe0 net/nfc/llcp_core.c:161
 nfc_llcp_unregister_device+0x160/0x240 net/nfc/llcp_core.c:1655
 nfc_unregister_device+0x167/0x2a0 net/nfc/core.c:1179
 virtual_ncidev_close+0x59/0x90 drivers/nfc/virtual_ncidev.c:163
 __fput+0x3cc/0xa10 fs/file_table.c:394
 __do_sys_close fs/open.c:1590 [inline]
 __se_sys_close+0x15f/0x220 fs/open.c:1575
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x44/0x110 arch/x86/entry/common.c:82
 entry_SYSCALL_64_after_hwframe+0x63/0x6b
RIP: 0033:0x7fe8ddc7b9da
Code: 48 3d 00 f0 ff ff 77 48 c3 0f 1f 80 00 00 00 00 48 83 ec 18 89 7c 24 0c e8 03 7f 02 00 8b 7c 24 0c 89 c2 b8 03 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 36 89 d7 89 44 24 0c e8 63 7f 02 00 8b 44 24
RSP: 002b:00007fffdaf3d080 EFLAGS: 00000293 ORIG_RAX: 0000000000000003
RAX: ffffffffffffffda RBX: 0000000000000004 RCX: 00007fe8ddc7b9da
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000003
RBP: 00007fe8ddd9d980 R08: 0000001b2e060000 R09: 00007fffdaf810b0
R10: 00007fffdaf81080 R11: 0000000000000293 R12: 00000000000151df
R13: ffffffffffffffff R14: 00007fe8dd800000 R15: 0000000000014e9e
 </TASK>


Tested on:

commit:         7ac1c88a lock
git tree:       https://github.com/siddhpant/linux.git lock
console output: https://syzkaller.appspot.com/x/log.txt?x=11f333af680000
kernel config:  https://syzkaller.appspot.com/x/.config?x=1e6a76f6c7029ca2
dashboard link: https://syzkaller.appspot.com/bug?extid=bbe84a4010eeea00982d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Note: no patches were applied.


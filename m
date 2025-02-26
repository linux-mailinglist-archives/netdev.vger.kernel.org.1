Return-Path: <netdev+bounces-169912-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B86CA46696
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 17:30:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A912419C5D5C
	for <lists+netdev@lfdr.de>; Wed, 26 Feb 2025 16:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59EF721D3EF;
	Wed, 26 Feb 2025 16:14:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9038D21CC50
	for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 16:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740586464; cv=none; b=cmeFbJdOtWbcU3UAsATz3tRqbJyRrX05nf8USWTxLkJwE0udxpYYfOlFIj/KDbZ911d01E5Q8xZwgveOTMEhloI3FvMLN0MjCryd3ZGwG8Xht575QIC9QNrHMedJJEL5wCv0ETBDQjMwUu+75unLORrRJrve98IAgjTrsC0gYD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740586464; c=relaxed/simple;
	bh=5DcLEnh6vcZAD2MZ5E1WYCKntW1wrJLiKqEgaqmxs7A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=eKTx5jsciuxGNDYikH7tRYVAaVnkoMGi6rAQxhWDFYdQliwDgj/vatFo6xF2M6QHJqPMwPn+WPJxW4vnCVsCFRs49jiiAvUTcbsbO7ES61oloCb2zOEYNN8ERqI+NxRSjbO6Xelg7yg21xgTPl23kXdmC39aX07b31WfNBJQgP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3d2aba48f44so8818785ab.0
        for <netdev@vger.kernel.org>; Wed, 26 Feb 2025 08:14:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740586461; x=1741191261;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VlzWfcGYfPaJ9SldeHNlm2qmsZkBArfdEBidikYP3No=;
        b=b0lJAD8HYpGjKY824hX5dTYRnyWdIJuYn0QAGSJwtqvm3/xMXV8xeNvtydc+SAHWGg
         OD6cWvytX8iAHN1RHTBi1DYwnZv+fZ1DaT7Vu3rIuPfFUT2/hU1rlQMWXdNIGhST3fL7
         E89lYNyKVC6e54u1b1B3PFV6TNineAINhOb+FxD4aYA8IfPcWoIEEllIYOsXWxra2suv
         U6bfx64mE4uQE21m+BnRz0iyuz+bOH8r4B7snwO7eLpOGuYFxGbfcx8srz/is9fWLIph
         M2yb9856VyD6fJZV4Bwlr9Hdu6R6OxQwZT64u7QWriyudgCC73lPf8dxGpFTEsV9Ljk/
         hFnA==
X-Forwarded-Encrypted: i=1; AJvYcCX9/YAgy9w26U3f/7cpltj4rRiyOMF36u0QsbQbbIV1tm9bc0JkWsjE5wNC3PrhNrpTNIfTKQ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzw57zpmfi6ySwOLdadICpwNMFlTmq3YfN/symtCZZol+a5zT/H
	CXQxo+H2wJnls7YFqEFXR6XMNg2j+BpyluVOaxML/6lyMAGjEzff+QvZrlb598sEINKMKPukUXF
	kKANiMEkUnHoHQDKh175231k/j9blxS0EzcLZwCPvbVZpGlgNXaLF2Dk=
X-Google-Smtp-Source: AGHT+IGMHfipWMis7WHKcdsyYkLSXA5wIVcN2zDDQ7XOouFzSbURpVAI/x2L0V2ztxrmOxrhpgwkkCUH6lx1E3ZmEZ+2WC+IxKF0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1945:b0:3cf:c7bc:4523 with SMTP id
 e9e14a558f8ab-3d2cad31ac7mr187462735ab.6.1740586461665; Wed, 26 Feb 2025
 08:14:21 -0800 (PST)
Date: Wed, 26 Feb 2025 08:14:21 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67bf3ddd.050a0220.1ebef.002d.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in ipv6_sock_ac_close (4)
From: syzbot <syzbot+be6f4b383534d88989f7@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ff202c5028a1 Merge tag 'soc-fixes-6.14' of git://git.kerne..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=173863b8580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=9658857a9163f824
dashboard link: https://syzkaller.appspot.com/bug?extid=be6f4b383534d88989f7
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c24121709a3f/disk-ff202c50.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e11874557832/vmlinux-ff202c50.xz
kernel image: https://storage.googleapis.com/syzbot-assets/78e2b0b48168/bzImage-ff202c50.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+be6f4b383534d88989f7@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.14.0-rc3-syzkaller-00267-gff202c5028a1 #0 Not tainted
------------------------------------------------------
syz.4.1528/11571 is trying to acquire lock:
ffffffff8fef8de8 (rtnl_mutex){+.+.}-{4:4}, at: ipv6_sock_ac_close+0xd9/0x110 net/ipv6/anycast.c:220

but task is already holding lock:
ffff888027f596a8 (&smc->clcsock_release_lock){+.+.}-{4:4}, at: smc_clcsock_release+0x75/0xe0 net/smc/smc_close.c:30

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&smc->clcsock_release_lock){+.+.}-{4:4}:
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       smc_switch_to_fallback+0x2d/0xa00 net/smc/af_smc.c:903
       smc_sendmsg+0x13d/0x520 net/smc/af_smc.c:2781
       sock_sendmsg_nosec net/socket.c:718 [inline]
       __sock_sendmsg net/socket.c:733 [inline]
       ____sys_sendmsg+0xaaf/0xc90 net/socket.c:2573
       ___sys_sendmsg+0x135/0x1e0 net/socket.c:2627
       __sys_sendmsg+0x16e/0x220 net/socket.c:2659
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (sk_lock-AF_INET6){+.+.}-{0:0}:
       lock_sock_nested+0x3a/0xf0 net/core/sock.c:3645
       lock_sock include/net/sock.h:1624 [inline]
       sockopt_lock_sock net/core/sock.c:1133 [inline]
       sockopt_lock_sock+0x54/0x70 net/core/sock.c:1124
       do_ipv6_setsockopt+0x2160/0x4520 net/ipv6/ipv6_sockglue.c:567
       ipv6_setsockopt+0xcb/0x170 net/ipv6/ipv6_sockglue.c:993
       udpv6_setsockopt+0x7d/0xd0 net/ipv6/udp.c:1850
       do_sock_setsockopt+0x222/0x480 net/socket.c:2303
       __sys_setsockopt+0x1a0/0x230 net/socket.c:2328
       __do_sys_setsockopt net/socket.c:2334 [inline]
       __se_sys_setsockopt net/socket.c:2331 [inline]
       __x64_sys_setsockopt+0xbd/0x160 net/socket.c:2331
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (rtnl_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3163 [inline]
       check_prevs_add kernel/locking/lockdep.c:3282 [inline]
       validate_chain kernel/locking/lockdep.c:3906 [inline]
       __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
       lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
       ipv6_sock_ac_close+0xd9/0x110 net/ipv6/anycast.c:220
       inet6_release+0x47/0x70 net/ipv6/af_inet6.c:485
       __sock_release net/socket.c:647 [inline]
       sock_release+0x8e/0x1d0 net/socket.c:675
       smc_clcsock_release+0xb7/0xe0 net/smc/smc_close.c:34
       __smc_release+0x5c2/0x880 net/smc/af_smc.c:301
       smc_release+0x1fc/0x5f0 net/smc/af_smc.c:344
       __sock_release+0xb0/0x270 net/socket.c:647
       sock_close+0x1c/0x30 net/socket.c:1398
       __fput+0x3ff/0xb70 fs/file_table.c:464
       task_work_run+0x14e/0x250 kernel/task_work.c:227
       resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
       exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
       exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
       __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
       syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
       do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  rtnl_mutex --> sk_lock-AF_INET6 --> &smc->clcsock_release_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&smc->clcsock_release_lock);
                               lock(sk_lock-AF_INET6);
                               lock(&smc->clcsock_release_lock);
  lock(rtnl_mutex);

 *** DEADLOCK ***

2 locks held by syz.4.1528/11571:
 #0: ffff888077e88208 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: inode_lock include/linux/fs.h:877 [inline]
 #0: ffff888077e88208 (&sb->s_type->i_mutex_key#10){+.+.}-{4:4}, at: __sock_release+0x86/0x270 net/socket.c:646
 #1: ffff888027f596a8 (&smc->clcsock_release_lock){+.+.}-{4:4}, at: smc_clcsock_release+0x75/0xe0 net/smc/smc_close.c:30

stack backtrace:
CPU: 0 UID: 0 PID: 11571 Comm: syz.4.1528 Not tainted 6.14.0-rc3-syzkaller-00267-gff202c5028a1 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:120
 print_circular_bug+0x490/0x760 kernel/locking/lockdep.c:2076
 check_noncircular+0x31a/0x400 kernel/locking/lockdep.c:2208
 check_prev_add kernel/locking/lockdep.c:3163 [inline]
 check_prevs_add kernel/locking/lockdep.c:3282 [inline]
 validate_chain kernel/locking/lockdep.c:3906 [inline]
 __lock_acquire+0x249e/0x3c40 kernel/locking/lockdep.c:5228
 lock_acquire.part.0+0x11b/0x380 kernel/locking/lockdep.c:5851
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x19b/0xb10 kernel/locking/mutex.c:730
 ipv6_sock_ac_close+0xd9/0x110 net/ipv6/anycast.c:220
 inet6_release+0x47/0x70 net/ipv6/af_inet6.c:485
 __sock_release net/socket.c:647 [inline]
 sock_release+0x8e/0x1d0 net/socket.c:675
 smc_clcsock_release+0xb7/0xe0 net/smc/smc_close.c:34
 __smc_release+0x5c2/0x880 net/smc/af_smc.c:301
 smc_release+0x1fc/0x5f0 net/smc/af_smc.c:344
 __sock_release+0xb0/0x270 net/socket.c:647
 sock_close+0x1c/0x30 net/socket.c:1398
 __fput+0x3ff/0xb70 fs/file_table.c:464
 task_work_run+0x14e/0x250 kernel/task_work.c:227
 resume_user_mode_work include/linux/resume_user_mode.h:50 [inline]
 exit_to_user_mode_loop kernel/entry/common.c:114 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:329 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x27b/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f8b4b38d169
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe4efd22d8 EFLAGS: 00000246 ORIG_RAX: 00000000000001b4
RAX: 0000000000000000 RBX: 00000000000b14a3 RCX: 00007f8b4b38d169
RDX: 0000000000000000 RSI: 000000000000001e RDI: 0000000000000003
RBP: 00007f8b4b5a7ba0 R08: 0000000000000001 R09: 000000114efd25cf
R10: 00007f8b4b200000 R11: 0000000000000246 R12: 00007f8b4b5a5fac
R13: 00007f8b4b5a5fa0 R14: ffffffffffffffff R15: 00007ffe4efd23f0
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


Return-Path: <netdev+bounces-119532-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6E095617B
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 05:49:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F556B2126F
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 03:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E97133EA69;
	Mon, 19 Aug 2024 03:49:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com [209.85.166.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 358151804E
	for <netdev@vger.kernel.org>; Mon, 19 Aug 2024 03:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724039368; cv=none; b=GgtUVfMeq9levVMVdgE7+EIV9cW6GS6Xkg7kViFrQ0b/qUefF8VN+t54UZR6AiiwTCNQhOcucCxSg/rydWBPOwJjUgoq/1yp1Rd6l7dE3l18rZNwp5DTAiKlE/Nnj20f96qzXL1GuytwhI80jT9irf5IWYgX1XtoVM0wJ5iUoMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724039368; c=relaxed/simple;
	bh=GKcip3kqBcX9sez0+sT2WsE576GsjlhS8PrcR++m1TU=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=N/AN/pxPjjRZrhdMttpUEJX3s8JKj9NHCETQh45iSbWEUgqDSQ0up9eFvWmxueinfrc9vUhDRgPqLdY+ZPs/GaYHIHnNtJOFqQ6NvDbn9k4n1vsST0NGco6C0iQtTGVHppNm3M8Yrza67I17T7PulGWlaL5j50kOWTnxfRLnjz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f72.google.com with SMTP id ca18e2360f4ac-824d69be8f7so370680239f.0
        for <netdev@vger.kernel.org>; Sun, 18 Aug 2024 20:49:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724039366; x=1724644166;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jdeZn6NHMH0T9WrkZ6buH4AV+etLAlaZ3gnjhbUDDEo=;
        b=hvma/4+bJ6VCaQWhMbo7i9wPzrbsZWRQbvbdpixaPNgVzRlCjDANridAgrA2lnC4n7
         G2H3xJWfIwwMvFpcUmuFR0GT23SrhLUogsjeHWkuxlbcY7wiBe6+JlD8uz1KRqznQq7x
         uiA2pZvVsvjIV0U4hQ2/u+AnVPoKoGicfvPxDe/H6q4d4fYG6LjVPLsNOexBIJZVNo2M
         z5I9/hoYVe9PJzd8iRPbPRgdrrTWZ+XzbvF8K1j5A4p5ars9d6KfyzWf/ggFadySykx2
         QGw8aZeuI13ui5zPIvXElxffXLQ0kDzRKHv8ZWjUgzPV2Dwa+Wmj8Zrv0q/vEQVdHXSW
         YQsA==
X-Forwarded-Encrypted: i=1; AJvYcCXI1ok940zwVrM4XDU+OXGcoXbJV/LyeE84FKdve4UILShr85Z8h2nE9efNizCk8F3dHhXu+qGj6XnhAa3SmKyGIylUS6mR
X-Gm-Message-State: AOJu0Yx6sj48z+Sluxp8ypBBiRkyDuDcQuTntx4nHcp1J/iA4wHTT+G5
	c23utT7WOhrnZH+E0mFTzLFzFrmoOP/uXW8LkxPtDZ1yYecMUx5530HibGztsAUST49D9qhVg0T
	UeFv8FVMnhZqyAxmp//r2/jvof+CBARfMu74nsgd68UQ7TE8ejSx5fVQ=
X-Google-Smtp-Source: AGHT+IHNiqMz6BLwWNzsQ117kr+pqA4JM9l0PynBoRPsMklvAg021lX2U97Dd0Cp3iH3axY70VrU5IsoD1MPhgwPcnStsEWBFllG
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:3593:b0:4bd:4861:d7f8 with SMTP id
 8926c6da1cb9f-4cce16a2b41mr571868173.4.1724039366377; Sun, 18 Aug 2024
 20:49:26 -0700 (PDT)
Date: Sun, 18 Aug 2024 20:49:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <0000000000000311430620013217@google.com>
Subject: [syzbot] [net?] possible deadlock in rtnl_lock (8)
From: syzbot <syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    1fb918967b56 Merge tag 'for-6.11-rc3-tag' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=129dd7d9980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=804764788c03071f
dashboard link: https://syzkaller.appspot.com/bug?extid=51cf7cc5f9ffc1006ef2
compiler:       aarch64-linux-gnu-gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: arm64

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/384ffdcca292/non_bootable_disk-1fb91896.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7b8fac7b5b8b/vmlinux-1fb91896.xz
kernel image: https://storage.googleapis.com/syzbot-assets/676950a147e6/Image-1fb91896.gz.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+51cf7cc5f9ffc1006ef2@syzkaller.appspotmail.com

======================================================
WARNING: possible circular locking dependency detected
6.11.0-rc3-syzkaller-00066-g1fb918967b56 #0 Not tainted
------------------------------------------------------
syz.0.5481/17612 is trying to acquire lock:
ffff8000880033a8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock+0x1c/0x28 net/core/rtnetlink.c:79

but task is already holding lock:
ffff000010332b50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsockopt+0xd8/0xcec net/smc/af_smc.c:3064

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (&smc->clcsock_release_lock){+.+.}-{3:3}:
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x134/0x840 kernel/locking/mutex.c:752
       mutex_lock_nested+0x24/0x30 kernel/locking/mutex.c:804
       smc_switch_to_fallback+0x34/0x80c net/smc/af_smc.c:902
       smc_sendmsg+0xe4/0x8f8 net/smc/af_smc.c:2779
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0xc8/0x168 net/socket.c:745
       __sys_sendto+0x1a8/0x254 net/socket.c:2204
       __do_sys_sendto net/socket.c:2216 [inline]
       __se_sys_sendto net/socket.c:2212 [inline]
       __arm64_sys_sendto+0xc0/0x134 net/socket.c:2212
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:49
       el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x50/0x180 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

-> #1 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_sock_nested+0x38/0xe8 net/core/sock.c:3543
       lock_sock include/net/sock.h:1607 [inline]
       sockopt_lock_sock net/core/sock.c:1061 [inline]
       sockopt_lock_sock+0x58/0x74 net/core/sock.c:1052
       do_ip_setsockopt+0xe0/0x2358 net/ipv4/ip_sockglue.c:1078
       ip_setsockopt+0x34/0x9c net/ipv4/ip_sockglue.c:1417
       raw_setsockopt+0x7c/0x2e0 net/ipv4/raw.c:845
       sock_common_setsockopt+0x70/0xe0 net/core/sock.c:3735
       do_sock_setsockopt+0x17c/0x354 net/socket.c:2324
       __sys_setsockopt+0xdc/0x178 net/socket.c:2347
       __do_sys_setsockopt net/socket.c:2356 [inline]
       __se_sys_setsockopt net/socket.c:2353 [inline]
       __arm64_sys_setsockopt+0xa4/0x100 net/socket.c:2353
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:49
       el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x50/0x180 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

-> #0 (rtnl_mutex){+.+.}-{3:3}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain kernel/locking/lockdep.c:3868 [inline]
       __lock_acquire+0x2aa4/0x6340 kernel/locking/lockdep.c:5142
       lock_acquire kernel/locking/lockdep.c:5759 [inline]
       lock_acquire+0x48c/0x7a4 kernel/locking/lockdep.c:5724
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x134/0x840 kernel/locking/mutex.c:752
       mutex_lock_nested+0x24/0x30 kernel/locking/mutex.c:804
       rtnl_lock+0x1c/0x28 net/core/rtnetlink.c:79
       do_ipv6_setsockopt+0x1a04/0x3814 net/ipv6/ipv6_sockglue.c:566
       ipv6_setsockopt+0xc8/0x140 net/ipv6/ipv6_sockglue.c:993
       tcp_setsockopt+0x90/0xcc net/ipv4/tcp.c:3768
       sock_common_setsockopt+0x70/0xe0 net/core/sock.c:3735
       smc_setsockopt+0x150/0xcec net/smc/af_smc.c:3072
       do_sock_setsockopt+0x17c/0x354 net/socket.c:2324
       __sys_setsockopt+0xdc/0x178 net/socket.c:2347
       __do_sys_setsockopt net/socket.c:2356 [inline]
       __se_sys_setsockopt net/socket.c:2353 [inline]
       __arm64_sys_setsockopt+0xa4/0x100 net/socket.c:2353
       __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
       invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:49
       el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:132
       do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:151
       el0_svc+0x50/0x180 arch/arm64/kernel/entry-common.c:712
       el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
       el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598

other info that might help us debug this:

Chain exists of:
  rtnl_mutex --> sk_lock-AF_INET --> &smc->clcsock_release_lock

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&smc->clcsock_release_lock);
                               lock(sk_lock-AF_INET);
                               lock(&smc->clcsock_release_lock);
  lock(rtnl_mutex);

 *** DEADLOCK ***

1 lock held by syz.0.5481/17612:
 #0: ffff000010332b50 (&smc->clcsock_release_lock){+.+.}-{3:3}, at: smc_setsockopt+0xd8/0xcec net/smc/af_smc.c:3064

stack backtrace:
CPU: 1 UID: 0 PID: 17612 Comm: syz.0.5481 Not tainted 6.11.0-rc3-syzkaller-00066-g1fb918967b56 #0
Hardware name: linux,dummy-virt (DT)
Call trace:
 dump_backtrace+0x9c/0x11c arch/arm64/kernel/stacktrace.c:317
 show_stack+0x18/0x24 arch/arm64/kernel/stacktrace.c:324
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0xa4/0xf4 lib/dump_stack.c:119
 dump_stack+0x1c/0x28 lib/dump_stack.c:128
 print_circular_bug+0x420/0x6f8 kernel/locking/lockdep.c:2059
 check_noncircular+0x2dc/0x364 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain kernel/locking/lockdep.c:3868 [inline]
 __lock_acquire+0x2aa4/0x6340 kernel/locking/lockdep.c:5142
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x48c/0x7a4 kernel/locking/lockdep.c:5724
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x134/0x840 kernel/locking/mutex.c:752
 mutex_lock_nested+0x24/0x30 kernel/locking/mutex.c:804
 rtnl_lock+0x1c/0x28 net/core/rtnetlink.c:79
 do_ipv6_setsockopt+0x1a04/0x3814 net/ipv6/ipv6_sockglue.c:566
 ipv6_setsockopt+0xc8/0x140 net/ipv6/ipv6_sockglue.c:993
 tcp_setsockopt+0x90/0xcc net/ipv4/tcp.c:3768
 sock_common_setsockopt+0x70/0xe0 net/core/sock.c:3735
 smc_setsockopt+0x150/0xcec net/smc/af_smc.c:3072
 do_sock_setsockopt+0x17c/0x354 net/socket.c:2324
 __sys_setsockopt+0xdc/0x178 net/socket.c:2347
 __do_sys_setsockopt net/socket.c:2356 [inline]
 __se_sys_setsockopt net/socket.c:2353 [inline]
 __arm64_sys_setsockopt+0xa4/0x100 net/socket.c:2353
 __invoke_syscall arch/arm64/kernel/syscall.c:35 [inline]
 invoke_syscall+0x6c/0x258 arch/arm64/kernel/syscall.c:49
 el0_svc_common.constprop.0+0xac/0x230 arch/arm64/kernel/syscall.c:132
 do_el0_svc+0x40/0x58 arch/arm64/kernel/syscall.c:151
 el0_svc+0x50/0x180 arch/arm64/kernel/entry-common.c:712
 el0t_64_sync_handler+0x100/0x12c arch/arm64/kernel/entry-common.c:730
 el0t_64_sync+0x190/0x194 arch/arm64/kernel/entry.S:598


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


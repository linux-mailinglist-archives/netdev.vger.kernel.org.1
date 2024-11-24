Return-Path: <netdev+bounces-147117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44BC79D792B
	for <lists+netdev@lfdr.de>; Mon, 25 Nov 2024 00:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C8787162B8C
	for <lists+netdev@lfdr.de>; Sun, 24 Nov 2024 23:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5558918B483;
	Sun, 24 Nov 2024 23:45:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com [209.85.166.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4558C17E472
	for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 23:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732491919; cv=none; b=qkJsyuJrcQFkLdY8FiN/JF1DoKW7TIGFrQNvqJeyo97jKzXJtoL0X3eGQI3RmQ8B1pWlT1XCAU5JEtQGPmtvx50ciyhujEY1JoGRl8+ZZsc9e3JmhIAm0Iolso73W1chyvRQ5q7PygpRwvg2Rd6E3lUTlbhpiJgGxkoR6eXV2yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732491919; c=relaxed/simple;
	bh=smUYyrCLkdRDH2mpiUzMLMC2V22OoaIyqVr45fM1iqA=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=p1PnDY8gfddW/srYKS2Y3enJY1YDsJ27g52aWUFPzYmwec8MiMZPks9TGHE3WUuCEtEd6tLFD0YCXaNTXOsKymsvsrchsH4e39bshIAun6AhVxpwMeYzVZ1DW3aRMmo+CoLTn87vPmiwILI69DvgIJuDf8CCZOe/xmoM0txQpJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-3a7b3c63c3aso4500825ab.0
        for <netdev@vger.kernel.org>; Sun, 24 Nov 2024 15:45:17 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732491916; x=1733096716;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Oat+2qA7Q0ufZ/Dd4W5pvvZZ0PL3NirgEemK1HNiSh4=;
        b=QMUFWtex6ccBL4tZriQO8MMRkpbTKezgqde+PDPVCJcV+Wv8c/mw6I1CFoIIabhXAd
         SoJT8B4Jg0GY6JefnQ9sFUEGdn1nWzjKTV6KHVDCPJhMIccKJkQp775MPVP6c/hMyazM
         Ypv6Ehbm+6n0UBKxGlHt+rMJth52cENPl7XzPJSybuFZnlDtvomAMylOgzLd46wKfAZb
         CZqn2RVXeS/qy9Ma5dDxWLEqCtw4WkkwcuTPlEHsDv+KOPk+H0owFrzI6qb728b/Avk4
         zuug3BoFHioF/t0Brhmu2kunCE2kR9e40o7kB/tf1ZSvBHq88nmJ0BSSATzGMOk55pOm
         Dj7A==
X-Forwarded-Encrypted: i=1; AJvYcCUZ25LQHE9t0P0ipzdXybJnKqHVN/7aiwK7VwsKXvL669gmDlR4lswhn/oeQ22cgxJQLLhhgZA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMVFl9i9kTbflPEDyGkCxXAE1ICxs8F+4bE4klL4L5jR0la4bb
	brpFjiNE4GAfnoUuqBha+YTzYyKQZdnVDOWD5Qw2qvl2RdpEZyEkPojGOyGNRCAeyAZ5cASQgpR
	yJ3zBdm/cexumCQ74skQbk/ZgFg126qhzSq3l7/uEtUYeZShsFA5krhI=
X-Google-Smtp-Source: AGHT+IFGv2R9mgy6Z0LQT28/VmegRk01/POPe38adyGOopSedS1tGj6fliea1AZXNEzxz4H5KgS6qL2Wr0yHo1s2i+JxuAgIH0q7
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:168c:b0:3a7:8cdd:c0d2 with SMTP id
 e9e14a558f8ab-3a79ab76051mr110215815ab.0.1732491916441; Sun, 24 Nov 2024
 15:45:16 -0800 (PST)
Date: Sun, 24 Nov 2024 15:45:16 -0800
In-Reply-To: <00000000000009ff2e061ce633d7@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6743ba8c.050a0220.1cc393.0050.GAE@google.com>
Subject: Re: [syzbot] [net?] possible deadlock in ip_mroute_setsockopt
From: syzbot <syzbot+e227429f6fa77945d7e4@syzkaller.appspotmail.com>
To: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com, 
	horms@kernel.org, kuba@kernel.org, linux-kernel@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

syzbot has found a reproducer for the following issue on:

HEAD commit:    fcc79e1714e8 Merge tag 'net-next-6.13' of git://git.kernel..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=1448b75f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=275de99a754927af
dashboard link: https://syzkaller.appspot.com/bug?extid=e227429f6fa77945d7e4
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175459c0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10dc0ee8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/8b723ddc7543/disk-fcc79e17.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ca8fd756cdfc/vmlinux-fcc79e17.xz
kernel image: https://storage.googleapis.com/syzbot-assets/778b3623fb8d/bzImage-fcc79e17.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e227429f6fa77945d7e4@syzkaller.appspotmail.com

lo speed is unknown, defaulting to 1000
lo speed is unknown, defaulting to 1000
iwpm_register_pid: Unable to send a nlmsg (client = 2)
infiniband syz0: RDMA CMA: cma_listen_on_dev, error -98
======================================================
WARNING: possible circular locking dependency detected
6.12.0-syzkaller-05480-gfcc79e1714e8 #0 Not tainted
------------------------------------------------------
syz-executor233/5845 is trying to acquire lock:
ffffffff8fce2348 (rtnl_mutex){+.+.}-{4:4}, at: ip_mroute_setsockopt+0x15b/0x1190 net/ipv4/ipmr.c:1370

but task is already holding lock:
ffff88807cfc0aa8 (&smc->clcsock_release_lock){+.+.}-{4:4}, at: smc_setsockopt+0x1c3/0xe50 net/smc/af_smc.c:3056

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #3 (&smc->clcsock_release_lock){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       smc_switch_to_fallback+0x35/0xdb0 net/smc/af_smc.c:902
       smc_sendmsg+0x11f/0x530 net/smc/af_smc.c:2771
       sock_sendmsg_nosec net/socket.c:711 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:726
       __sys_sendto+0x363/0x4c0 net/socket.c:2197
       __do_sys_sendto net/socket.c:2204 [inline]
       __se_sys_sendto net/socket.c:2200 [inline]
       __x64_sys_sendto+0xde/0x100 net/socket.c:2200
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #2 (sk_lock-AF_INET){+.+.}-{0:0}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       lock_sock_nested+0x48/0x100 net/core/sock.c:3622
       lock_sock include/net/sock.h:1617 [inline]
       sock_set_reuseaddr+0x17/0x60 net/core/sock.c:781
       siw_create_listen+0x196/0xfe0 drivers/infiniband/sw/siw/siw_cm.c:1776
       iw_cm_listen+0x15e/0x230 drivers/infiniband/core/iwcm.c:585
       cma_iw_listen drivers/infiniband/core/cma.c:2668 [inline]
       rdma_listen+0x941/0xd60 drivers/infiniband/core/cma.c:3953
       cma_listen_on_dev+0x3e3/0x6f0 drivers/infiniband/core/cma.c:2727
       cma_add_one+0x7d7/0xcd0 drivers/infiniband/core/cma.c:5357
       add_client_context+0x536/0x8b0 drivers/infiniband/core/device.c:727
       enable_device_and_get+0x1e6/0x440 drivers/infiniband/core/device.c:1338
       ib_register_device+0x10d4/0x13e0 drivers/infiniband/core/device.c:1449
       siw_device_register drivers/infiniband/sw/siw/siw_main.c:72 [inline]
       siw_newlink+0x9d9/0xe50 drivers/infiniband/sw/siw/siw_main.c:452
       nldev_newlink+0x5c0/0x640 drivers/infiniband/core/nldev.c:1795
       rdma_nl_rcv_skb drivers/infiniband/core/netlink.c:239 [inline]
       rdma_nl_rcv+0x6dd/0x9e0 drivers/infiniband/core/netlink.c:259
       netlink_unicast_kernel net/netlink/af_netlink.c:1321 [inline]
       netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1347
       netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1891
       sock_sendmsg_nosec net/socket.c:711 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:726
       ____sys_sendmsg+0x52a/0x7e0 net/socket.c:2583
       ___sys_sendmsg net/socket.c:2637 [inline]
       __sys_sendmsg+0x269/0x350 net/socket.c:2669
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (lock#7){+.+.}-{4:4}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       cma_init+0x1e/0x140 drivers/infiniband/core/cma.c:5438
       do_one_initcall+0x248/0x880 init/main.c:1266
       do_initcall_level+0x157/0x210 init/main.c:1328
       do_initcalls+0x3f/0x80 init/main.c:1344
       kernel_init_freeable+0x435/0x5d0 init/main.c:1577
       kernel_init+0x1d/0x2b0 init/main.c:1466
       ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
       ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244

-> #0 (rtnl_mutex){+.+.}-{4:4}:
       check_prev_add kernel/locking/lockdep.c:3161 [inline]
       check_prevs_add kernel/locking/lockdep.c:3280 [inline]
       validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
       __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
       __mutex_lock_common kernel/locking/mutex.c:585 [inline]
       __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
       ip_mroute_setsockopt+0x15b/0x1190 net/ipv4/ipmr.c:1370
       do_ip_setsockopt+0x129f/0x3cd0 net/ipv4/ip_sockglue.c:948
       ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
       smc_setsockopt+0x275/0xe50 net/smc/af_smc.c:3064
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2313
       __sys_setsockopt net/socket.c:2338 [inline]
       __do_sys_setsockopt net/socket.c:2344 [inline]
       __se_sys_setsockopt net/socket.c:2341 [inline]
       __x64_sys_setsockopt+0x1ee/0x280 net/socket.c:2341
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

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

1 lock held by syz-executor233/5845:
 #0: ffff88807cfc0aa8 (&smc->clcsock_release_lock){+.+.}-{4:4}, at: smc_setsockopt+0x1c3/0xe50 net/smc/af_smc.c:3056

stack backtrace:
CPU: 0 UID: 0 PID: 5845 Comm: syz-executor233 Not tainted 6.12.0-syzkaller-05480-gfcc79e1714e8 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
 check_prev_add kernel/locking/lockdep.c:3161 [inline]
 check_prevs_add kernel/locking/lockdep.c:3280 [inline]
 validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
 __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
 __mutex_lock_common kernel/locking/mutex.c:585 [inline]
 __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
 ip_mroute_setsockopt+0x15b/0x1190 net/ipv4/ipmr.c:1370
 do_ip_setsockopt+0x129f/0x3cd0 net/ipv4/ip_sockglue.c:948
 ip_setsockopt+0x63/0x100 net/ipv4/ip_sockglue.c:1417
 smc_setsockopt+0x275/0xe50 net/smc/af_smc.c:3064
 do_sock_setsockopt+0x3af/0x720 net/socket.c:2313
 __sys_setsockopt net/socket.c:2338 [inline]
 __do_sys_setsockopt net/socket.c:2344 [inline]
 __se_sys_setsockopt net/socket.c:2341 [inline]
 __x64_sys_setsockopt+0x1ee/0x280 net/socket.c:2341
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f018ec824a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe0c6806e8 EFLAGS: 00000246 ORIG_RAX: 0000000000000036
RAX: ffffffffffffffda RBX: 00007ffe0c6808b8 RCX: 00007f018ec824a9
RDX: 00000000000000d2 RSI: 0000000000000000 RDI: 0000000000000005
RBP: 00007f018ecf5610 R08: 0000000000000000 R09: 00007ffe0c6808b8
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
R13: 00007ffe0c6808a8 R14: 0000000000000001 R15: 0


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.


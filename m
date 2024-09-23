Return-Path: <netdev+bounces-129333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DD3B97EE70
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 17:46:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82A5F1F2267D
	for <lists+netdev@lfdr.de>; Mon, 23 Sep 2024 15:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DCC197A9B;
	Mon, 23 Sep 2024 15:46:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com [209.85.166.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B52702747D
	for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 15:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727106387; cv=none; b=MatyMQxxbwuYihQSNcQdncOhsrXZmjLOLb/yLOlKiJFcwEGomagFxhhFR/6AI889KQMCqYrF7eP0opULbCr3B/NNfIwePkx707dCo9bgofA9qXXo67V2l55XK6Y5yp4nqSv37IIc+MAGsOGN33loq09qyNojGWjs8duDeNCoM50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727106387; c=relaxed/simple;
	bh=LGYCPQ0qMntw/zBmXpJAtB2lzURz8DXm9+Idp1B2B0A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=exLd6zKzagKNQ5a1f2oSiHF+epyBygr9/i3+KFCSBsXW2udUuYqb5Q3e4J5HGMUedbXWo/lJV7p8foFxOhiWrG8mbXFolF8GTEMghSnrBlGTiGgZy/wE9qEAlaxBfCL3nUvKrl9y0OBkhH7fr7cShVF4S1fjihNb3Yguhxa0V80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f199.google.com with SMTP id e9e14a558f8ab-3a0a54fb476so63315755ab.2
        for <netdev@vger.kernel.org>; Mon, 23 Sep 2024 08:46:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727106385; x=1727711185;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=prPVt5cguf8d01sLaNgmGgS8NpJHgZ878V5tnotzEpg=;
        b=f/s3YZRiKd9oU/V+tn4yyU9VenejMZN/uPJNWPVkOGaQW6Y8Cwr0d5w0UiymS8G61Z
         FkQNbTe9B6LYiYAgh2fJ1ggmXxPjt7Oi294mn6yNfoQ+ytIPz0FIid3Wev5PzTznr+bu
         hEftruxVYLnSlvzzhRacHPINNYF+uv+wEbdsFTPMx5hVDlESjo4ZU0VmvJFDaheKYD4L
         8fGfOe2Rlf/8cAkxPpf5zamQIvUi9h+E7FArDYWvft/I6sFIF5CsrayzJZlvc+YyuMWU
         56WITf4KFa1kMGkG5uRD55nNXqvp1pFDFoWHoKhXsNVyHLi964u5ETNij54jQN44quIw
         HF0g==
X-Forwarded-Encrypted: i=1; AJvYcCUTQpM2v0vGVS0MOZPIFyiETAHbZPcyL3aP1ujiKNAhtG9mGzskXbnqResgoVtEcEi4ymDP2eA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbGPsdLHjMiF1MzwczRjRWry0iHTjrQqC2yTSHaqEszpw9GYqP
	VMMRwr+DNhVrpyWwBtXgaAvhGeiuJh3V8l7n+/IILXBfYUmrEbP+o7vKZ65nGH2yq/Jn+4SN3K0
	tD/CPeiVteuZJpDwI4MvZy4mCTMOQnl2lKpCtWeHmvYsXU5krrB8bEO4=
X-Google-Smtp-Source: AGHT+IFzJbuikFWCJ31F6HFTXZgdwvxKzbj2BuXXfQeUx1+VxdLNDg/Rk8vlVjgdTJnT4hNWmooyde52lN0AfF8hmnJ2OwdZD9eU
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca47:0:b0:39b:3894:9298 with SMTP id
 e9e14a558f8ab-3a0c9b82e20mr104292805ab.0.1727106384915; Mon, 23 Sep 2024
 08:46:24 -0700 (PDT)
Date: Mon, 23 Sep 2024 08:46:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <66f18d50.050a0220.c23dd.0012.GAE@google.com>
Subject: [syzbot] [net?] possible deadlock in gtp_encap_enable_socket
From: syzbot <syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org, 
	laforge@gnumonks.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org, 
	osmocom-net-gprs@lists.osmocom.org, pabeni@redhat.com, pablo@netfilter.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    9410645520e9 Merge tag 'net-next-6.12' of git://git.kernel..
git tree:       net-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=15d39e9f980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=37c006d80708398d
dashboard link: https://syzkaller.appspot.com/bug?extid=e953a8f3071f5c0a28fd
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=16215ca9980000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=110c6c27980000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/80466d230dfb/disk-94106455.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/ba253eabab42/vmlinux-94106455.xz
kernel image: https://storage.googleapis.com/syzbot-assets/569982fb6c88/bzImage-94106455.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+e953a8f3071f5c0a28fd@syzkaller.appspotmail.com

IPVS: Unknown mcast interface: macvlan0
netlink: 8 bytes leftover after parsing attributes in process `syz-executor297'.
netlink: 24 bytes leftover after parsing attributes in process `syz-executor297'.
======================================================
WARNING: possible circular locking dependency detected
6.11.0-syzkaller-01458-g9410645520e9 #0 Not tainted
------------------------------------------------------
syz-executor297/5243 is trying to acquire lock:
ffff88801cf99158 (sk_lock-AF_INET){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1609 [inline]
ffff88801cf99158 (sk_lock-AF_INET){+.+.}-{0:0}, at: gtp_encap_enable_socket+0x2ce/0x5c0 drivers/net/gtp.c:1674

but task is already holding lock:
ffffffff8fc88588 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
ffffffff8fc88588 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643

which lock already depends on the new lock.


the existing dependency chain (in reverse order) is:

-> #2 (rtnl_mutex){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       start_sync_thread+0xdc/0x2dc0 net/netfilter/ipvs/ip_vs_sync.c:1761
       do_ip_vs_set_ctl+0x442/0x13d0 net/netfilter/ipvs/ip_vs_ctl.c:2732
       nf_setsockopt+0x295/0x2c0 net/netfilter/nf_sockopt.c:101
       smc_setsockopt+0x275/0xe50 net/smc/af_smc.c:3064
       do_sock_setsockopt+0x3af/0x720 net/socket.c:2330
       __sys_setsockopt+0x1ae/0x250 net/socket.c:2353
       __do_sys_setsockopt net/socket.c:2362 [inline]
       __se_sys_setsockopt net/socket.c:2359 [inline]
       __x64_sys_setsockopt+0xb5/0xd0 net/socket.c:2359
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #1 (&smc->clcsock_release_lock){+.+.}-{3:3}:
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       __mutex_lock_common kernel/locking/mutex.c:608 [inline]
       __mutex_lock+0x136/0xd70 kernel/locking/mutex.c:752
       smc_switch_to_fallback+0x35/0xdb0 net/smc/af_smc.c:902
       smc_sendmsg+0x11f/0x530 net/smc/af_smc.c:2771
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       ____sys_sendmsg+0x525/0x7d0 net/socket.c:2603
       ___sys_sendmsg net/socket.c:2657 [inline]
       __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2686
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

-> #0 (sk_lock-AF_INET){+.+.}-{0:0}:
       check_prev_add kernel/locking/lockdep.c:3133 [inline]
       check_prevs_add kernel/locking/lockdep.c:3252 [inline]
       validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
       __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
       lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
       lock_sock_nested+0x48/0x100 net/core/sock.c:3611
       lock_sock include/net/sock.h:1609 [inline]
       gtp_encap_enable_socket+0x2ce/0x5c0 drivers/net/gtp.c:1674
       gtp_encap_enable drivers/net/gtp.c:1707 [inline]
       gtp_newlink+0x589/0xf30 drivers/net/gtp.c:1511
       rtnl_newlink_create net/core/rtnetlink.c:3510 [inline]
       __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
       rtnl_newlink+0x1591/0x20a0 net/core/rtnetlink.c:3743
       rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6646
       netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
       netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
       netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
       netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
       sock_sendmsg_nosec net/socket.c:730 [inline]
       __sock_sendmsg+0x221/0x270 net/socket.c:745
       ____sys_sendmsg+0x525/0x7d0 net/socket.c:2603
       ___sys_sendmsg net/socket.c:2657 [inline]
       __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2686
       do_syscall_x64 arch/x86/entry/common.c:52 [inline]
       do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
       entry_SYSCALL_64_after_hwframe+0x77/0x7f

other info that might help us debug this:

Chain exists of:
  sk_lock-AF_INET --> &smc->clcsock_release_lock --> rtnl_mutex

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(rtnl_mutex);
                               lock(&smc->clcsock_release_lock);
                               lock(rtnl_mutex);
  lock(sk_lock-AF_INET);

 *** DEADLOCK ***

1 lock held by syz-executor297/5243:
 #0: ffffffff8fc88588 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fc88588 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x6e6/0xcf0 net/core/rtnetlink.c:6643

stack backtrace:
CPU: 0 UID: 0 PID: 5243 Comm: syz-executor297 Not tainted 6.11.0-syzkaller-01458-g9410645520e9 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:119
 check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2186
 check_prev_add kernel/locking/lockdep.c:3133 [inline]
 check_prevs_add kernel/locking/lockdep.c:3252 [inline]
 validate_chain+0x18e0/0x5900 kernel/locking/lockdep.c:3868
 __lock_acquire+0x137a/0x2040 kernel/locking/lockdep.c:5142
 lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5759
 lock_sock_nested+0x48/0x100 net/core/sock.c:3611
 lock_sock include/net/sock.h:1609 [inline]
 gtp_encap_enable_socket+0x2ce/0x5c0 drivers/net/gtp.c:1674
 gtp_encap_enable drivers/net/gtp.c:1707 [inline]
 gtp_newlink+0x589/0xf30 drivers/net/gtp.c:1511
 rtnl_newlink_create net/core/rtnetlink.c:3510 [inline]
 __rtnl_newlink net/core/rtnetlink.c:3730 [inline]
 rtnl_newlink+0x1591/0x20a0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x73f/0xcf0 net/core/rtnetlink.c:6646
 netlink_rcv_skb+0x1e3/0x430 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x7f6/0x990 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8e4/0xcb0 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg+0x221/0x270 net/socket.c:745
 ____sys_sendmsg+0x525/0x7d0 net/socket.c:2603
 ___sys_sendmsg net/socket.c:2657 [inline]
 __sys_sendmsg+0x2b0/0x3a0 net/socket.c:2686
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fed198844a9
Code: 48 83 c4 28 c3 e8 37 17 00 00 0f 1f 80 00 00 00 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RS


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


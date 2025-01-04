Return-Path: <netdev+bounces-155132-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B544A012D9
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 07:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D627163E48
	for <lists+netdev@lfdr.de>; Sat,  4 Jan 2025 06:59:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DE501494AD;
	Sat,  4 Jan 2025 06:59:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EwZg6T/j"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AD2137742
	for <netdev@vger.kernel.org>; Sat,  4 Jan 2025 06:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735973980; cv=none; b=eat4kY/hVE+58ZuoZn7H0oSsb5jUFA5/wwp658fHKIoeJaetstrR35A4Iw4v0razdyuQvzTMwxmv3qrXAJuiIGyx3md1V1cYbdICIMi7oMegTNMXCQLYKD35fl5gjoEegdgEEKlyz+kpaoBjryTYGMHwLUtX0YYhr/UhE6PFZ5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735973980; c=relaxed/simple;
	bh=k+udYg0sBqjczaPyHi0f3ORjOtLaRm7z4VPDloTPRq4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5kbcQWi8Enj4JMj3BOC9BgOXb5vYLW8pKvNFd7vdhtvpiSU6BK6qZSj7NNL7a1BxvZl79m0g8ZR621CEl6ctSfdtllWx76lW7FfUNnyjmyG3PRlhcnSpvgThIdFrR4TD0RWZQ+smveelv+vPJYxIq6zU67WndVPdvux6+QbLpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EwZg6T/j; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1735973976; x=1767509976;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=w8IRhRXNKgF4H4yCZQqnEzlQLYIeQv+A6MVg9aj+5pM=;
  b=EwZg6T/jhQJCbe9C4nBKgrt2kPeJ+xAGZnQBugVWTX9VMB32Lwl40888
   oY9C0+13vhZa6EhGwu7xB26cZFimjySxzOkn/pGx7WeWUtRP3nrhX38qW
   OcypSwebnbQT54dL3o2fN/XnTVMz5w3g2E2GvEGo6g2iZ5+JUtR+UFlk7
   k=;
X-IronPort-AV: E=Sophos;i="6.12,288,1728950400"; 
   d="scan'208";a="451646892"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Jan 2025 06:59:32 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:58219]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.39.3:2525] with esmtp (Farcaster)
 id 66853eff-ffda-4b76-8d5b-58adf11c2c74; Sat, 4 Jan 2025 06:59:34 +0000 (UTC)
X-Farcaster-Flow-ID: 66853eff-ffda-4b76-8d5b-58adf11c2c74
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 06:59:33 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.9.250) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sat, 4 Jan 2025 06:59:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <edumazet@google.com>
CC: <davem@davemloft.net>, <eric.dumazet@gmail.com>, <horms@kernel.org>,
	<kuba@kernel.org>, <kuniyu@amazon.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <syzkaller@googlegroups.com>
Subject: Re: [PATCH net-next] ax25: rcu protect dev->ax25_ptr
Date: Sat, 4 Jan 2025 15:59:11 +0900
Message-ID: <20250104065911.39876-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250103210514.87290-1-edumazet@google.com>
References: <20250103210514.87290-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB003.ant.amazon.com (10.13.139.168) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Eric Dumazet <edumazet@google.com>
Date: Fri,  3 Jan 2025 21:05:14 +0000
> syzbot found a lockdep issue [1].
> 
> We should remove ax25 RTNL dependency in ax25_setsockopt()
> 
> This should also fix a variety of possible UAF in ax25.
> 
> [1]
> 
> WARNING: possible circular locking dependency detected
> 6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0 Not tainted
> ------------------------------------------------------
> syz.5.1818/12806 is trying to acquire lock:
>  ffffffff8fcb3988 (rtnl_mutex){+.+.}-{4:4}, at: ax25_setsockopt+0xa55/0xe90 net/ax25/af_ax25.c:680
> 
> but task is already holding lock:
>  ffff8880617ac258 (sk_lock-AF_AX25){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1618 [inline]
>  ffff8880617ac258 (sk_lock-AF_AX25){+.+.}-{0:0}, at: ax25_setsockopt+0x209/0xe90 net/ax25/af_ax25.c:574
> 
> which lock already depends on the new lock.
> 
> the existing dependency chain (in reverse order) is:
> 
> -> #1 (sk_lock-AF_AX25){+.+.}-{0:0}:
>         lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>         lock_sock_nested+0x48/0x100 net/core/sock.c:3642
>         lock_sock include/net/sock.h:1618 [inline]
>         ax25_kill_by_device net/ax25/af_ax25.c:101 [inline]
>         ax25_device_event+0x24d/0x580 net/ax25/af_ax25.c:146
>         notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
>        __dev_notify_flags+0x207/0x400
>         dev_change_flags+0xf0/0x1a0 net/core/dev.c:9026
>         dev_ifsioc+0x7c8/0xe70 net/core/dev_ioctl.c:563
>         dev_ioctl+0x719/0x1340 net/core/dev_ioctl.c:820
>         sock_do_ioctl+0x240/0x460 net/socket.c:1234
>         sock_ioctl+0x626/0x8e0 net/socket.c:1339
>         vfs_ioctl fs/ioctl.c:51 [inline]
>         __do_sys_ioctl fs/ioctl.c:906 [inline]
>         __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
>         do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>         do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> -> #0 (rtnl_mutex){+.+.}-{4:4}:
>         check_prev_add kernel/locking/lockdep.c:3161 [inline]
>         check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>         validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>         __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
>         lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>         __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>         __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
>         ax25_setsockopt+0xa55/0xe90 net/ax25/af_ax25.c:680
>         do_sock_setsockopt+0x3af/0x720 net/socket.c:2324
>         __sys_setsockopt net/socket.c:2349 [inline]
>         __do_sys_setsockopt net/socket.c:2355 [inline]
>         __se_sys_setsockopt net/socket.c:2352 [inline]
>         __x64_sys_setsockopt+0x1ee/0x280 net/socket.c:2352
>         do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>         do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>        entry_SYSCALL_64_after_hwframe+0x77/0x7f
> 
> other info that might help us debug this:
> 
>  Possible unsafe locking scenario:
> 
>        CPU0                    CPU1
>        ----                    ----
>   lock(sk_lock-AF_AX25);
>                                lock(rtnl_mutex);
>                                lock(sk_lock-AF_AX25);
>   lock(rtnl_mutex);
> 
>  *** DEADLOCK ***
> 
> 1 lock held by syz.5.1818/12806:
>   #0: ffff8880617ac258 (sk_lock-AF_AX25){+.+.}-{0:0}, at: lock_sock include/net/sock.h:1618 [inline]
>   #0: ffff8880617ac258 (sk_lock-AF_AX25){+.+.}-{0:0}, at: ax25_setsockopt+0x209/0xe90 net/ax25/af_ax25.c:574
> 
> stack backtrace:
> CPU: 1 UID: 0 PID: 12806 Comm: syz.5.1818 Not tainted 6.13.0-rc3-syzkaller-00762-g9268abe611b0 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> Call Trace:
>  <TASK>
>   __dump_stack lib/dump_stack.c:94 [inline]
>   dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>   print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
>   check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
>   check_prev_add kernel/locking/lockdep.c:3161 [inline]
>   check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>   validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>   __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
>   lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>   __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>   __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
>   ax25_setsockopt+0xa55/0xe90 net/ax25/af_ax25.c:680
>   do_sock_setsockopt+0x3af/0x720 net/socket.c:2324
>   __sys_setsockopt net/socket.c:2349 [inline]
>   __do_sys_setsockopt net/socket.c:2355 [inline]
>   __se_sys_setsockopt net/socket.c:2352 [inline]
>   __x64_sys_setsockopt+0x1ee/0x280 net/socket.c:2352
>   do_syscall_x64 arch/x86/entry/common.c:52 [inline]
>   do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
>  entry_SYSCALL_64_after_hwframe+0x77/0x7f
> RIP: 0033:0x7f7b62385d29
> 
> Fixes: c433570458e4 ("ax25: fix a use-after-free in ax25_fillin_cb()")
> Reported-by: syzbot <syzkaller@googlegroups.com>
> Signed-off-by: Eric Dumazet <edumazet@google.com>

Not sure if net-next is intentional, but whichever is fine to me :)

Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>


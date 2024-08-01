Return-Path: <netdev+bounces-114896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5917B9449DE
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 12:58:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DAE231F23521
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 10:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B617188016;
	Thu,  1 Aug 2024 10:58:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b="xnSXWQVT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71730187FE5
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722509915; cv=none; b=uGoD0T2LP/rdDCzSHsPBicBKaL/dRUFUP56Mgzijynwe7QWb/a2OjA/qjIGlmfg6OzNHgIGyaVNfBzrjwVZgDGwxf4WbH5gvpq4za7vDFiH9qeylfUngzQVhMq3iuGYCC6oAydTpOgWjG4CXEsi3CXePoRTXYSuuWsvPUzDQQa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722509915; c=relaxed/simple;
	bh=d6O/vDMuzNKaTopgE2ZOD/6qCo4XxgOI6o9iAjPxGRo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=ZegCBgPbDBofZ5kXlcI6oyqHe8oBgl66of7IpdqpOXLssdBO+oReaV2b9hk2RHC4yJFzsGb413iFd1qHKvWAxHt7wz9Z05DgfyNks/T3/u51aEAiYFkHZkkc0pkIhNag3zvP/TCoX1CGe+Rvg2xaz//+/TogKm/MwwcMD5SqZ4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com; spf=fail smtp.mailfrom=infogain.com; dkim=pass (2048-bit key) header.d=infogain-com.20230601.gappssmtp.com header.i=@infogain-com.20230601.gappssmtp.com header.b=xnSXWQVT; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=infogain.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=infogain.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-428e1915e18so3800355e9.1
        for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 03:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=infogain-com.20230601.gappssmtp.com; s=20230601; t=1722509911; x=1723114711; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kVrtk1m5zgFdtHnwDb+mrV04TZqiuqA+XJN3Mt0Abio=;
        b=xnSXWQVTc17s6oGdnhCjHfnTkg1GluBiKOTjo7AWaLkIMkwxQ4yo86gJized/WzAdj
         WWEQhRfMdld0bTTV2fp1L/5YcIgESu/zpgl90gYU9ZPCbbDGXIiN1qIUL/x+HGiYDXmq
         wZDrRPb48CWrISclbmeIxPH3mymkF1j1BPUtsfBkMbPAsVYgeS6d0VM6QDtslOa9vDA2
         HbaGP2J0ctfTnNd0v/IDiod8YSZpIRMZuyhUVrA8lhVONajjpfIy/Vy26Enr9/sMYZnt
         mHSVE/pVrDtSbLW7vCE7X84m5HJbhpXSOU2IIoJdvZa/IJp5lU/cu7FA///jOjikdHaW
         G8+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722509911; x=1723114711;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kVrtk1m5zgFdtHnwDb+mrV04TZqiuqA+XJN3Mt0Abio=;
        b=A3DfzoY6ZEhXxx12VbX0aU7QN4wWp7iny6HYf1P1E4DMsPlvqy1tODyOZOU1zOMT/T
         WqELpjffph1fkn6UjuKQK/fxwkrBRFTyvgA/A7MhYtxV1oQHQHnHgfwsklrfiB4oGFEN
         a0ypEfDP8MjkVVeO9DtDTGOXyletyYJLqXLxUDaTSwGooXf/RwcBhgNRhXfkjvfItYat
         pJbcDV3w9HpaOc08wb8+yGaaHHZ9GpGB+6GcLbKT3Hx+UhDAKcWr0vYYkEMyRm/DujwL
         d1kSXevzqLInpKcx27tpbXvyHGCzcvu1CICOOaNcby0/Gn1/il4/T7dt4KbITzJP55dt
         Stuw==
X-Forwarded-Encrypted: i=1; AJvYcCVLPDoQ31A2ZQ7Rk3leRihBgLie2Xr31UkUhkmg/OcVsmiA5bbwksg2eAmX8ASSYDE6HvtjQwuEgwr3nvxZiKHj7K9cD0KR
X-Gm-Message-State: AOJu0Yz7WH9/NHcQR+BAgxhbRPn13Qpq7gv5zSdetfd93yzZaCQHmqpr
	KlEkgzp4qGEWF5nqzH1OC/jg9LIIslhpissUk2XivOETEV0nXRB0EVgzaZFu1nA=
X-Google-Smtp-Source: AGHT+IG7Mtd6BUWrGEZm919JuKDJtWA+bv/kCh1P/ohmijr2X71oJRpSFqS1TX0vV0dVl0ZhfSemXg==
X-Received: by 2002:a05:600c:358c:b0:426:5416:67d7 with SMTP id 5b1f17b1804b1-428b030cca0mr14005695e9.27.1722509909833;
        Thu, 01 Aug 2024 03:58:29 -0700 (PDT)
Received: from localhost.localdomain (apn-31-0-3-137.dynamic.gprs.plus.pl. [31.0.3.137])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b36861b29sm19068960f8f.93.2024.08.01.03.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 03:58:29 -0700 (PDT)
From: =?UTF-8?q?Wojciech=20G=C5=82adysz?= <wojciech.gladysz@infogain.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jhs@mojatatu.com,
	xiyou.wangcong@gmail.com,
	jiri@resnulli.us,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Wojciech=20G=C5=82adysz?= <wojciech.gladysz@infogain.com>
Subject: [PATCH] kernel/net: missused TCQ_F_NOLOCK flag
Date: Thu,  1 Aug 2024 12:57:07 +0200
Message-Id: <20240801105707.30021-1-wojciech.gladysz@infogain.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

TCQ_F_NOLOCK yields no locking option for a qdisc. At some places in the
code the testing for the flag seems logically reverted. The change fixes
the following lockdep issue.

======================================================
WARNING: possible circular locking dependency detected
5.10.0-syzkaller #0 Not tainted
------------------------------------------------------
syz-executor372/2662 is trying to acquire lock:
ffff888028151218 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#2){+...}-{2:2}, at: spin_lock include/linux/spinlock.h:357 [inline]
ffff888028151218 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#2){+...}-{2:2}, at: __dev_xmit_skb net/core/dev.c:3689 [inline]
ffff888028151218 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#2){+...}-{2:2}, at: __dev_queue_xmit+0x1e02/0x32b0 net/core/dev.c:4053

but task is already holding lock:
ffff88801016d0d8 (&qdisc_xmit_lock_key){+...}-{2:2}, at: spin_lock include/linux/spinlock.h:357 [inline]
ffff88801016d0d8 (&qdisc_xmit_lock_key){+...}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4077 [inline]
ffff88801016d0d8 (&qdisc_xmit_lock_key){+...}-{2:2}, at: sch_direct_xmit+0x19c/0x9c0 net/sched/sch_generic.c:341

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #1 (&qdisc_xmit_lock_key){+...}-{2:2}:
       lock_acquire+0x197/0x480 kernel/locking/lockdep.c:5566
       __raw_spin_lock include/linux/spinlock_api_smp.h:144 [inline]
       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
       spin_lock include/linux/spinlock.h:357 [inline]
       __netif_tx_lock include/linux/netdevice.h:4077 [inline]
       sch_direct_xmit+0x19c/0x9c0 net/sched/sch_generic.c:341
       __dev_xmit_skb net/core/dev.c:3663 [inline]
       __dev_queue_xmit+0x158e/0x32b0 net/core/dev.c:4053
       dev_queue_xmit+0x17/0x20 net/core/dev.c:4121
       neigh_resolve_output+0x644/0x750 net/core/neighbour.c:1508
       neigh_output include/net/neighbour.h:528 [inline]
       ip6_finish_output2+0x150b/0x1ea0 net/ipv6/ip6_output.c:151
       __ip6_finish_output+0x4b6/0x620 net/ipv6/ip6_output.c:224
       ip6_finish_output+0x34/0x280 net/ipv6/ip6_output.c:234
       NF_HOOK_COND include/linux/netfilter.h:298 [inline]
       ip6_output+0x2c4/0x3d0 net/ipv6/ip6_output.c:257
       dst_output include/net/dst.h:444 [inline]
       NF_HOOK+0x166/0x550 include/linux/netfilter.h:309
       mld_sendpack+0x823/0xd90 net/ipv6/mcast.c:1817
       mld_send_cr net/ipv6/mcast.c:2118 [inline]
       mld_ifc_work+0x814/0xcc0 net/ipv6/mcast.c:2649
       process_one_work+0x857/0xfd0 kernel/workqueue.c:2282
       worker_thread+0xafa/0x1550 kernel/workqueue.c:2428
       kthread+0x374/0x3f0 kernel/kthread.c:349
       ret_from_fork+0x3a/0x50 arch/x86/entry/entry_64.S:306

-> #0 (dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#2){+...}-{2:2}:
       check_prev_add kernel/locking/lockdep.c:2988 [inline]
       check_prevs_add kernel/locking/lockdep.c:3113 [inline]
       validate_chain+0x1695/0x58f0 kernel/locking/lockdep.c:3729
       __lock_acquire+0x12fd/0x20d0 kernel/locking/lockdep.c:4955
       lock_acquire+0x197/0x480 kernel/locking/lockdep.c:5566
       __raw_spin_lock include/linux/spinlock_api_smp.h:144 [inline]
       _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
       spin_lock include/linux/spinlock.h:357 [inline]
       __dev_xmit_skb net/core/dev.c:3689 [inline]
       __dev_queue_xmit+0x1e02/0x32b0 net/core/dev.c:4053
       dev_queue_xmit+0x17/0x20 net/core/dev.c:4121
       neigh_resolve_output+0x644/0x750 net/core/neighbour.c:1508
       neigh_output include/net/neighbour.h:528 [inline]
       ip6_finish_output2+0x150b/0x1ea0 net/ipv6/ip6_output.c:151
       __ip6_finish_output+0x4b6/0x620 net/ipv6/ip6_output.c:224
       ip6_finish_output+0x34/0x280 net/ipv6/ip6_output.c:234
       NF_HOOK_COND include/linux/netfilter.h:298 [inline]
       ip6_output+0x2c4/0x3d0 net/ipv6/ip6_output.c:257
       dst_output include/net/dst.h:444 [inline]
       NF_HOOK include/linux/netfilter.h:309 [inline]
       ndisc_send_skb+0xaaa/0x1370 net/ipv6/ndisc.c:508
       ndisc_solicit+0x3ea/0x660 net/ipv6/ndisc.c:666
       neigh_probe net/core/neighbour.c:1021 [inline]
       __neigh_event_send+0xec0/0x1460 net/core/neighbour.c:1182
       neigh_event_send include/net/neighbour.h:457 [inline]
       neigh_resolve_output+0x1cf/0x750 net/core/neighbour.c:1492
       neigh_output include/net/neighbour.h:528 [inline]
       ip6_finish_output2+0x150b/0x1ea0 net/ipv6/ip6_output.c:151
       __ip6_finish_output+0x4b6/0x620 net/ipv6/ip6_output.c:224
       ip6_finish_output+0x34/0x280 net/ipv6/ip6_output.c:234
       NF_HOOK_COND include/linux/netfilter.h:298 [inline]
       ip6_output+0x2c4/0x3d0 net/ipv6/ip6_output.c:257
       dst_output include/net/dst.h:444 [inline]
       ip6_local_out+0x10f/0x140 net/ipv6/output_core.c:161
       ip6_send_skb+0x127/0x220 net/ipv6/ip6_output.c:2015
       ip6_push_pending_frames+0xb4/0xe0 net/ipv6/ip6_output.c:2035
       icmpv6_push_pending_frames+0x2f4/0x4b0 net/ipv6/icmp.c:304
       icmp6_send+0x160c/0x20d0 net/ipv6/icmp.c:627
       __icmpv6_send include/linux/icmpv6.h:28 [inline]
       icmpv6_send include/linux/icmpv6.h:49 [inline]
       ip6_link_failure+0x3b/0x4c0 net/ipv6/route.c:2801
       dst_link_failure include/net/dst.h:423 [inline]
       ip_tunnel_xmit+0x1b76/0x2b40 net/ipv4/ip_tunnel.c:856
       __gre_xmit net/ipv4/ip_gre.c:471 [inline]
       erspan_xmit+0xb22/0x1380 net/ipv4/ip_gre.c:728
       __netdev_start_xmit include/linux/netdevice.h:4657 [inline]
       netdev_start_xmit include/linux/netdevice.h:4671 [inline]
       xmit_one net/core/dev.c:3455 [inline]
       dev_hard_start_xmit+0x36a/0x880 net/core/dev.c:3471
       sch_direct_xmit+0x2a0/0x9c0 net/sched/sch_generic.c:343
       qdisc_restart net/sched/sch_generic.c:408 [inline]
       __qdisc_run+0xae6/0x1cb0 net/sched/sch_generic.c:416
       __dev_xmit_skb net/core/dev.c:3722 [inline]
       __dev_queue_xmit+0xdd5/0x32b0 net/core/dev.c:4053
       dev_queue_xmit+0x17/0x20 net/core/dev.c:4121
       neigh_resolve_output+0x644/0x750 net/core/neighbour.c:1508
       neigh_output include/net/neighbour.h:528 [inline]
       ip6_finish_output2+0x150b/0x1ea0 net/ipv6/ip6_output.c:151
       __ip6_finish_output+0x4b6/0x620 net/ipv6/ip6_output.c:224
       ip6_finish_output+0x34/0x280 net/ipv6/ip6_output.c:234
       NF_HOOK_COND include/linux/netfilter.h:298 [inline]
       ip6_output+0x2c4/0x3d0 net/ipv6/ip6_output.c:257
       dst_output include/net/dst.h:444 [inline]
       NF_HOOK include/linux/netfilter.h:309 [inline]
       rawv6_send_hdrinc+0xd16/0x1930 net/ipv6/raw.c:669
       rawv6_sendmsg+0x15e5/0x2100 net/ipv6/raw.c:929
       inet_sendmsg+0x149/0x310 net/ipv4/af_inet.c:854
       sock_sendmsg_nosec net/socket.c:702 [inline]
       __sock_sendmsg net/socket.c:714 [inline]
       sock_write_iter+0x3a0/0x520 net/socket.c:1088
       call_write_iter include/linux/fs.h:1986 [inline]
       new_sync_write fs/read_write.c:518 [inline]
       vfs_write+0x9c0/0xc30 fs/read_write.c:605
       ksys_write+0x17e/0x2a0 fs/read_write.c:658
       __do_sys_write fs/read_write.c:670 [inline]
       __se_sys_write fs/read_write.c:667 [inline]
       __x64_sys_write+0x7b/0x90 fs/read_write.c:667
       do_syscall_64+0x6d/0xa0 arch/x86/entry/common.c:62
       entry_SYSCALL_64_after_hwframe+0x61/0xcb

other info that might help us debug this:

 Possible unsafe locking scenario:

       CPU0                    CPU1
       ----                    ----
  lock(&qdisc_xmit_lock_key);
                               lock(dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#2);
                               lock(&qdisc_xmit_lock_key);
  lock(dev->qdisc_tx_busylock ?: &qdisc_tx_busylock#2);

 *** DEADLOCK ***

11 locks held by syz-executor372/2662:
 #0: ffffffff8806ed80 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x9/0x40 include/linux/rcupdate.h:272
 #1: ffffffff8806ed80 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x9/0x40 include/linux/rcupdate.h:272
 #2: ffffffff8806ede0 (rcu_read_lock_bh){....}-{1:2}, at: rcu_lock_acquire+0xd/0x40 include/linux/rcupdate.h:273
 #3: ffff888028151148 (dev->qdisc_running_key ?: &qdisc_running_key){+...}-{0:0}, at: dev_queue_xmit+0x17/0x20 net/core/dev.c:4121
 #4: ffff88801016d0d8 (&qdisc_xmit_lock_key){+...}-{2:2}, at: spin_lock include/linux/spinlock.h:357 [inline]
 #4: ffff88801016d0d8 (&qdisc_xmit_lock_key){+...}-{2:2}, at: __netif_tx_lock include/linux/netdevice.h:4077 [inline]
 #4: ffff88801016d0d8 (&qdisc_xmit_lock_key){+...}-{2:2}, at: sch_direct_xmit+0x19c/0x9c0 net/sched/sch_generic.c:341
 #5: ffff88801691a218 (k-slock-AF_INET6){+...}-{2:2}, at: spin_trylock include/linux/spinlock.h:367 [inline]
 #5: ffff88801691a218 (k-slock-AF_INET6){+...}-{2:2}, at: icmpv6_xmit_lock net/ipv6/icmp.c:109 [inline]
 #5: ffff88801691a218 (k-slock-AF_INET6){+...}-{2:2}, at: icmp6_send+0xa79/0x20d0 net/ipv6/icmp.c:545
 #6: ffffffff8806ed80 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x9/0x40 include/linux/rcupdate.h:272
 #7: ffffffff8806ed80 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x9/0x40 include/linux/rcupdate.h:272
 #8: ffffffff8806ed80 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x9/0x40 include/linux/rcupdate.h:272
 #9: ffffffff8806ed80 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire+0x9/0x40 include/linux/rcupdate.h:272
 #10: ffffffff8806ede0 (rcu_read_lock_bh){....}-{1:2}, at: rcu_lock_acquire+0xd/0x40 include/linux/rcupdate.h:273

stack backtrace:
CPU: 1 PID: 2662 Comm: syz-executor372 Not tainted 5.10.0-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 03/27/2024
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x177/0x211 lib/dump_stack.c:118
 print_circular_bug+0x146/0x1b0 kernel/locking/lockdep.c:2002
 check_noncircular+0x2cc/0x390 kernel/locking/lockdep.c:2123
 check_prev_add kernel/locking/lockdep.c:2988 [inline]
 check_prevs_add kernel/locking/lockdep.c:3113 [inline]
 validate_chain+0x1695/0x58f0 kernel/locking/lockdep.c:3729
 __lock_acquire+0x12fd/0x20d0 kernel/locking/lockdep.c:4955
 lock_acquire+0x197/0x480 kernel/locking/lockdep.c:5566
 __raw_spin_lock include/linux/spinlock_api_smp.h:144 [inline]
 _raw_spin_lock+0x2a/0x40 kernel/locking/spinlock.c:151
 spin_lock include/linux/spinlock.h:357 [inline]
 __dev_xmit_skb net/core/dev.c:3689 [inline]
 __dev_queue_xmit+0x1e02/0x32b0 net/core/dev.c:4053
 dev_queue_xmit+0x17/0x20 net/core/dev.c:4121
 neigh_resolve_output+0x644/0x750 net/core/neighbour.c:1508
 neigh_output include/net/neighbour.h:528 [inline]
 ip6_finish_output2+0x150b/0x1ea0 net/ipv6/ip6_output.c:151
 __ip6_finish_output+0x4b6/0x620 net/ipv6/ip6_output.c:224
 ip6_finish_output+0x34/0x280 net/ipv6/ip6_output.c:234
 NF_HOOK_COND include/linux/netfilter.h:298 [inline]
 ip6_output+0x2c4/0x3d0 net/ipv6/ip6_output.c:257
 dst_output include/net/dst.h:444 [inline]
 NF_HOOK include/linux/netfilter.h:309 [inline]
 ndisc_send_skb+0xaaa/0x1370 net/ipv6/ndisc.c:508
 ndisc_solicit+0x3ea/0x660 net/ipv6/ndisc.c:666
 neigh_probe net/core/neighbour.c:1021 [inline]
 __neigh_event_send+0xec0/0x1460 net/core/neighbour.c:1182
 neigh_event_send include/net/neighbour.h:457 [inline]
 neigh_resolve_output+0x1cf/0x750 net/core/neighbour.c:1492
 neigh_output include/net/neighbour.h:528 [inline]
 ip6_finish_output2+0x150b/0x1ea0 net/ipv6/ip6_output.c:151
 __ip6_finish_output+0x4b6/0x620 net/ipv6/ip6_output.c:224
 ip6_finish_output+0x34/0x280 net/ipv6/ip6_output.c:234
 NF_HOOK_COND include/linux/netfilter.h:298 [inline]
 ip6_output+0x2c4/0x3d0 net/ipv6/ip6_output.c:257
 dst_output include/net/dst.h:444 [inline]
 ip6_local_out+0x10f/0x140 net/ipv6/output_core.c:161
 ip6_send_skb+0x127/0x220 net/ipv6/ip6_output.c:2015
 ip6_push_pending_frames+0xb4/0xe0 net/ipv6/ip6_output.c:2035
 icmpv6_push_pending_frames+0x2f4/0x4b0 net/ipv6/icmp.c:304
 icmp6_send+0x160c/0x20d0 net/ipv6/icmp.c:627
 __icmpv6_send include/linux/icmpv6.h:28 [inline]
 icmpv6_send include/linux/icmpv6.h:49 [inline]
 ip6_link_failure+0x3b/0x4c0 net/ipv6/route.c:2801
 dst_link_failure include/net/dst.h:423 [inline]
 ip_tunnel_xmit+0x1b76/0x2b40 net/ipv4/ip_tunnel.c:856
 __gre_xmit net/ipv4/ip_gre.c:471 [inline]
 erspan_xmit+0xb22/0x1380 net/ipv4/ip_gre.c:728
 __netdev_start_xmit include/linux/netdevice.h:4657 [inline]
 netdev_start_xmit include/linux/netdevice.h:4671 [inline]
 xmit_one net/core/dev.c:3455 [inline]
 dev_hard_start_xmit+0x36a/0x880 net/core/dev.c:3471
 sch_direct_xmit+0x2a0/0x9c0 net/sched/sch_generic.c:343
 qdisc_restart net/sched/sch_generic.c:408 [inline]
 __qdisc_run+0xae6/0x1cb0 net/sched/sch_generic.c:416
 __dev_xmit_skb net/core/dev.c:3722 [inline]
 __dev_queue_xmit+0xdd5/0x32b0 net/core/dev.c:4053
 dev_queue_xmit+0x17/0x20 net/core/dev.c:4121
 neigh_resolve_output+0x644/0x750 net/core/neighbour.c:1508
 neigh_output include/net/neighbour.h:528 [inline]
 ip6_finish_output2+0x150b/0x1ea0 net/ipv6/ip6_output.c:151
 __ip6_finish_output+0x4b6/0x620 net/ipv6/ip6_output.c:224
 ip6_finish_output+0x34/0x280 net/ipv6/ip6_output.c:234
 NF_HOOK_COND include/linux/netfilter.h:298 [inline]
 ip6_output+0x2c4/0x3d0 net/ipv6/ip6_output.c:257
 dst_output include/net/dst.h:444 [inline]
 NF_HOOK include/linux/netfilter.h:309 [inline]
 rawv6_send_hdrinc+0xd16/0x1930 net/ipv6/raw.c:669
 rawv6_sendmsg+0x15e5/0x2100 net/ipv6/raw.c:929
 inet_sendmsg+0x149/0x310 net/ipv4/af_inet.c:854
 sock_sendmsg_nosec net/socket.c:702 [inline]
 __sock_sendmsg net/socket.c:714 [inline]
 sock_write_iter+0x3a0/0x520 net/socket.c:1088
 call_write_iter include/linux/fs.h:1986 [inline]
 new_sync_write fs/read_write.c:518 [inline]
 vfs_write+0x9c0/0xc30 fs/read_write.c:605
 ksys_write+0x17e/0x2a0 fs/read_write.c:658
 __do_sys_write fs/read_write.c:670 [inline]
 __se_sys_write fs/read_write.c:667 [inline]
 __x64_sys_write+0x7b/0x90 fs/read_write.c:667
 do_syscall_64+0x6d/0xa0 arch/x86/entry/common.c:62
 entry_SYSCALL_64_after_hwframe+0x61/0xcb
RIP: 0033:0x7fd7b2201c69
Code: 28 00 00 00 75 05 48 83 c4 28 c3 e8 d1 19 00 00 90 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007ffe960e0cb8 EFLAGS: 00000246 ORIG_RAX: 0000000000000001
RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 00007fd7b2201c69
RDX: 0000000000000028 RSI: 0000000020000140 RDI: 0000000000000006
RBP: 00000000000f4240 R08: 0000000100000000 R09: 0000000100000000
R10: 0000000100000000 R11: 0000000000000246 R12: 00007ffe960e0d10
R13: 0000000000000001 R14: 00007ffe960e0d10 R15: 0000000000000003

Signed-off-by: Wojciech Gładysz <wojciech.gladysz@infogain.com>
---
 include/net/sch_generic.h |  6 +++---
 net/sched/sch_generic.c   | 12 ++++++------
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/include/net/sch_generic.h b/include/net/sch_generic.h
index 79edd5b5e3c9..35a747e3c00a 100644
--- a/include/net/sch_generic.h
+++ b/include/net/sch_generic.h
@@ -166,7 +166,7 @@ static inline struct Qdisc *qdisc_refcount_inc_nz(struct Qdisc *qdisc)
  */
 static inline bool qdisc_is_running(struct Qdisc *qdisc)
 {
-	if (qdisc->flags & TCQ_F_NOLOCK)
+	if (!(qdisc->flags & TCQ_F_NOLOCK))
 		return spin_is_locked(&qdisc->seqlock);
 	return test_bit(__QDISC_STATE2_RUNNING, &qdisc->state2);
 }
@@ -193,7 +193,7 @@ static inline bool qdisc_is_empty(const struct Qdisc *qdisc)
  */
 static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 {
-	if (qdisc->flags & TCQ_F_NOLOCK) {
+	if (!(qdisc->flags & TCQ_F_NOLOCK)) {
 		if (spin_trylock(&qdisc->seqlock))
 			return true;
 
@@ -216,7 +216,7 @@ static inline bool qdisc_run_begin(struct Qdisc *qdisc)
 
 static inline void qdisc_run_end(struct Qdisc *qdisc)
 {
-	if (qdisc->flags & TCQ_F_NOLOCK) {
+	if (!(qdisc->flags & TCQ_F_NOLOCK)) {
 		spin_unlock(&qdisc->seqlock);
 
 		/* spin_unlock() only has store-release semantic. The unlock
diff --git a/net/sched/sch_generic.c b/net/sched/sch_generic.c
index e22ff003d52e..db24f477e310 100644
--- a/net/sched/sch_generic.c
+++ b/net/sched/sch_generic.c
@@ -76,7 +76,7 @@ static inline struct sk_buff *__skb_dequeue_bad_txq(struct Qdisc *q)
 	spinlock_t *lock = NULL;
 	struct sk_buff *skb;
 
-	if (q->flags & TCQ_F_NOLOCK) {
+	if (!(q->flags & TCQ_F_NOLOCK)) {
 		lock = qdisc_lock(q);
 		spin_lock(lock);
 	}
@@ -121,7 +121,7 @@ static inline void qdisc_enqueue_skb_bad_txq(struct Qdisc *q,
 {
 	spinlock_t *lock = NULL;
 
-	if (q->flags & TCQ_F_NOLOCK) {
+	if (!(q->flags & TCQ_F_NOLOCK)) {
 		lock = qdisc_lock(q);
 		spin_lock(lock);
 	}
@@ -144,7 +144,7 @@ static inline void dev_requeue_skb(struct sk_buff *skb, struct Qdisc *q)
 {
 	spinlock_t *lock = NULL;
 
-	if (q->flags & TCQ_F_NOLOCK) {
+	if (!(q->flags & TCQ_F_NOLOCK)) {
 		lock = qdisc_lock(q);
 		spin_lock(lock);
 	}
@@ -236,7 +236,7 @@ static struct sk_buff *dequeue_skb(struct Qdisc *q, bool *validate,
 	if (unlikely(!skb_queue_empty(&q->gso_skb))) {
 		spinlock_t *lock = NULL;
 
-		if (q->flags & TCQ_F_NOLOCK) {
+		if (!(q->flags & TCQ_F_NOLOCK)) {
 			lock = qdisc_lock(q);
 			spin_lock(lock);
 		}
@@ -1300,14 +1300,14 @@ static void dev_reset_queue(struct net_device *dev,
 
 	nolock = qdisc->flags & TCQ_F_NOLOCK;
 
-	if (nolock)
+	if (!nolock)
 		spin_lock_bh(&qdisc->seqlock);
 	spin_lock_bh(qdisc_lock(qdisc));
 
 	qdisc_reset(qdisc);
 
 	spin_unlock_bh(qdisc_lock(qdisc));
-	if (nolock) {
+	if (!nolock) {
 		clear_bit(__QDISC_STATE_MISSED, &qdisc->state);
 		clear_bit(__QDISC_STATE_DRAINING, &qdisc->state);
 		spin_unlock_bh(&qdisc->seqlock);
-- 
2.35.3



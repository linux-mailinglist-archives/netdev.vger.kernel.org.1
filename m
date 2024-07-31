Return-Path: <netdev+bounces-114618-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C81BB9432F4
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 17:18:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E951AB2B099
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 15:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C36A1BD4ED;
	Wed, 31 Jul 2024 15:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CSnG2aTi"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5D5717552;
	Wed, 31 Jul 2024 15:10:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722438654; cv=none; b=qD3+b9QSzZVfsV8VUTeYni9hu8VuIFCKhZGXEblFQL0GJMyYWMF/TnvjechL/eCICaRCLCnwu27j3CPKEXkQ6ceWbLwKX6jAbGOFrq5VFph3huApIqTsjmqUQPC9BmORzimi3abjoqC1YHZwHbodesSWQhPpptozTk29zgT2ypg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722438654; c=relaxed/simple;
	bh=Xt+mb5hIBYa4aoADZVAEEXbmVtyCi1kCj04mH9kCKPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f8EeIOU/r9jxwvECR8v0HEQV67Tog6y0ebobad3mmgNAS5Pp+7AqXDqfskVC5E5GuPxnUwmbv754kVmzzfxAcHg4hTkNMnXPPBzoemyvxEJ6C9yuD31GyNKbrdZ8XBfm9fU2mhRhlhewB4qMQME5xoxv4/XhBNdXt/saUw1MWVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CSnG2aTi; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1fd90c2fc68so45291375ad.1;
        Wed, 31 Jul 2024 08:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722438652; x=1723043452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FAMngMCa2HAFboRJYmZVtugYfv6PWexcdwffsm2pQ28=;
        b=CSnG2aTiNkufkAp54gyfQY+8jsH+iTWaWDUJWRtqbF5U4H3N3rYEsgkw1cC/PAKNLs
         XJF5hLRfMYyFbmUXzvMLZjpiKFkAmg7JspeQ5Pq78ODOCU0AAyq4cf6xPQHza29JRNoZ
         KzvOZ29hCyfjQgTj2onEPVGLM/685y4S8Wfn3iTWWhZVe6iLfYDzE40ZZ3TMAxmSlw4k
         tW8wNImPdErWWKGjJ2cOCXUk/FdeVW/BrjSs0GMVm4bxwRj+SmVWU6RPa4IudFk88q6v
         RVevB0vNt86fKfYhUoCqG2+NMkZ+owIH56fehV+Y3XQOKtP2IUoKd7AqJPxGhLW2+6yc
         J2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722438652; x=1723043452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FAMngMCa2HAFboRJYmZVtugYfv6PWexcdwffsm2pQ28=;
        b=Zzs1IxioPtcVvykCc+oIJyO7vQh/vJeXY//YGLeWOq1A6Dnxk2RFRpY9ZqgfExONo2
         7pFdiux21i18xyYFGqV4xq8TlV3/MDatKRZ91QiUWqY5iSkd6ITOUK1ZZ51IyVI2aXHP
         4I+/6uhS7Vp0NNmz5TlNxGm3o5bfa4MvG2k6u9LZ11UQ62kT9KtuiX0iygxUBr+21t9O
         TsXm53ZDOcijHGJgFpjbBNyHpDgTQl+czySW2a7dpNbUOIs7FK++++OTWPkfJk0DeDjS
         Z3BZFDFEwvabQaNJqoITbxpmZ7fmqbm49fCl+1I/HSyJ7tS+2tC2xWbDxUkogCn+R1lX
         sMRQ==
X-Forwarded-Encrypted: i=1; AJvYcCUJby0LywN0i1ucxvodqIuF438/7fPkCcdeUgQYv/b6i5DLkHjOJTq3tFmwiBiuWy01tkToEWkiua+bDWkAbS4Nlr1Se5zYag5WgFe0BQHb4acj2cXo8qytX7g8CAa2ROHcJQGX
X-Gm-Message-State: AOJu0YzxilCSIfDfnxdJC2SuFb+VfZnM/ybZG2muRoSapk1wV4PaF9L2
	CI5imWmIcJhh8PXgYRdKzD2jlNCyRyu4/QSp3hQzJ+DiynIorI8WGeGE0nQzY48=
X-Google-Smtp-Source: AGHT+IGn3zRosNfD+5PBLu5X9lqbDgN8DXQmPHfrvofJJ9jXYr5NhRn4fzYFkefxSMaUoros5PDI4g==
X-Received: by 2002:a17:903:1387:b0:1fd:aa8d:ad00 with SMTP id d9443c01a7336-1ff0482ba5cmr107135245ad.18.1722438651745;
        Wed, 31 Jul 2024 08:10:51 -0700 (PDT)
Received: from localhost.localdomain ([121.185.186.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fed7c7fbe1sm121377195ad.45.2024.07.31.08.10.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 08:10:51 -0700 (PDT)
From: Jeongjun Park <aha310510@gmail.com>
To: jiri@resnulli.us
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	nicolas.dichtel@6wind.com,
	liuhangbin@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+44623300f057a28baf1e@syzkaller.appspotmail.com,
	syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com,
	Jeongjun Park <aha310510@gmail.com>
Subject: [PATCH net,v2] rtnetlink: fix possible deadlock in team_port_change_check
Date: Thu,  1 Aug 2024 00:09:40 +0900
Message-Id: <20240731150940.14106-1-aha310510@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In do_setlink() , do_set_master() is called when dev->flags does not have
the IFF_UP flag set, so 'team->lock' is acquired and dev_open() is called,
which generates the NETDEV_UP event. This causes a deadlock as it tries to
acquire 'team->lock' again.

To solve this, we need to unlock 'team->lock' before calling dev_open()
in team_port_add() and then reacquire the lock when dev_open() returns.
Since the implementation acquires the lock in advance when the team
structure is used inside dev_open(), data races will not occur even if it
is briefly unlocked.

============================================
WARNING: possible recursive locking detected
6.11.0-rc1-syzkaller-ge4fc196f5ba3-dirty #0 Not tainted
--------------------------------------------
syz.0.15/5889 is trying to acquire lock:
ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_port_change_check drivers/net/team/team_core.c:2950 [inline]
ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_device_event+0x2c7/0x770 drivers/net/team/team_core.c:2973

but task is already holding lock:
ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1975

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(team->team_lock_key#2);
  lock(team->team_lock_key#2);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by syz.0.15/5889:
 #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core/rtnetlink.c:79 [inline]
 #0: ffffffff8fa1f4e8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+0x372/0xea0 net/core/rtnetlink.c:6644
 #1: ffff8880231e4d40 (team->team_lock_key#2){+.+.}-{3:3}, at: team_add_slave+0x9c/0x20e0 drivers/net/team/team_core.c:1975

stack backtrace:
CPU: 1 UID: 0 PID: 5889 Comm: syz.0.15 Not tainted 6.11.0-rc1-syzkaller-ge4fc196f5ba3-dirty #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:93 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:119
 check_deadlock kernel/locking/lockdep.c:3061 [inline]
 validate_chain kernel/locking/lockdep.c:3855 [inline]
 __lock_acquire+0x2167/0x3cb0 kernel/locking/lockdep.c:5142
 lock_acquire kernel/locking/lockdep.c:5759 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5724
 __mutex_lock_common kernel/locking/mutex.c:608 [inline]
 __mutex_lock+0x175/0x9c0 kernel/locking/mutex.c:752
 team_port_change_check drivers/net/team/team_core.c:2950 [inline]
 team_device_event+0x2c7/0x770 drivers/net/team/team_core.c:2973
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 __dev_notify_flags+0x12d/0x2e0 net/core/dev.c:8876
 dev_change_flags+0x10c/0x160 net/core/dev.c:8914
 vlan_device_event+0xdfc/0x2120 net/8021q/vlan.c:468
 notifier_call_chain+0xb9/0x410 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x140 net/core/dev.c:1994
 call_netdevice_notifiers_extack net/core/dev.c:2032 [inline]
 call_netdevice_notifiers net/core/dev.c:2046 [inline]
 dev_open net/core/dev.c:1515 [inline]
 dev_open+0x144/0x160 net/core/dev.c:1503
 team_port_add drivers/net/team/team_core.c:1216 [inline]
 team_add_slave+0xacd/0x20e0 drivers/net/team/team_core.c:1976
 do_set_master+0x1bc/0x230 net/core/rtnetlink.c:2701
 do_setlink+0x306d/0x4060 net/core/rtnetlink.c:2907
 __rtnl_newlink+0xc35/0x1960 net/core/rtnetlink.c:3696
 rtnl_newlink+0x67/0xa0 net/core/rtnetlink.c:3743
 rtnetlink_rcv_msg+0x3c7/0xea0 net/core/rtnetlink.c:6647
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab5/0xc90 net/socket.c:2597
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc07ed77299
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fc07fb7f048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fc07ef05f80 RCX: 00007fc07ed77299
RDX: 0000000000000000 RSI: 0000000020000600 RDI: 0000000000000012
RBP: 00007fc07ede48e6 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fc07ef05f80 R15: 00007ffeb5c0d528

Reported-by: syzbot+b668da2bc4cb9670bf58@syzkaller.appspotmail.com
Fixes: ec4ffd100ffb ("Revert "net: rtnetlink: Enslave device before bringing it up"")
Signed-off-by: Jeongjun Park <aha310510@gmail.com>
---
 drivers/net/team/team_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/team/team_core.c b/drivers/net/team/team_core.c
index ab1935a4aa2c..ee595c3c6624 100644
--- a/drivers/net/team/team_core.c
+++ b/drivers/net/team/team_core.c
@@ -1212,8 +1212,9 @@ static int team_port_add(struct team *team, struct net_device *port_dev,
 			   portname);
 		goto err_port_enter;
 	}
-
+	mutex_unlock(&team->lock);
 	err = dev_open(port_dev, extack);
+	mutex_lock(&team->lock);
 	if (err) {
 		netdev_dbg(dev, "Device %s opening failed\n",
 			   portname);
--


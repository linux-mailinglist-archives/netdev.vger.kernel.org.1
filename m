Return-Path: <netdev+bounces-173004-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40526A56D0C
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 17:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 557D77A3056
	for <lists+netdev@lfdr.de>; Fri,  7 Mar 2025 16:03:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812062206B6;
	Fri,  7 Mar 2025 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="g5I7Rbq5"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D43221554
	for <netdev@vger.kernel.org>; Fri,  7 Mar 2025 16:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741363443; cv=none; b=tdeN9LvXxvryzuWFG/FMnn1IYTL32RkusfmV6nsz/fZEhxCb3j9TJCDCk4bQGU7xPRWyfYKAbSKjsiE2PIIk549GqTn6lcLbVHduk+KEdVIzQ912m9uFJyS/2tCncCFIUe13z9BzwVCj2tvdDI3c9gc/RVi5LDrEs9EzhxSmkqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741363443; c=relaxed/simple;
	bh=gZylsrGsU2+QM46lUHsO7rxhzSBqbTb5NnU8Clo/Mz4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=q+VmXsjD/kknG/S/iskF51ATKNvyp0js4akR3ViE6sjwLdusFrtt5AoQ0UMzZb3T+X3emIJIBzei+NMLUAefLhgMF8IsP+mFC6RvnW5ye6PoX43HJys57SZduroZ/KpClL+AER/Qmm/eQwBkAAVMcOY4JYymmOrk5GdPHS2Fa7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=g5I7Rbq5; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-474fc025985so42354411cf.1
        for <netdev@vger.kernel.org>; Fri, 07 Mar 2025 08:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1741363440; x=1741968240; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=siolQ1RF2fCbfSB3es0raHpPHOWn51foXq/8jtvUiCU=;
        b=g5I7Rbq5ZZ+mCuZOo+SN8eiexwEgpe8UV1WA154QoWIfSJUPICTcyQi3P4wlB3s7BJ
         sJUoEr1qdpMOE0amPQ7ttdxpJgH2kFxqmBOjl90AUxoaGWnc9YaJZjnslbyafSgNbm7z
         t11YqkEjzHDXx2wiHJBJku45xrSF/ICAwNRqat2INQWNAtMASHhlx2ZHymceVwGmJMlt
         ccXZ+uDOMWgfYyLegkthOET3/yopIYIuGrN+lcltW5pbBx8ihAUkyfh5BeTeZu61htNF
         Tp2XSfgS83qBx6Fnn42pAn3w0HgLOqYhW73kSs/e78FLAOac8Hbu/c/L7jjCewLQKT2m
         Yl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741363440; x=1741968240;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=siolQ1RF2fCbfSB3es0raHpPHOWn51foXq/8jtvUiCU=;
        b=AFBQD2GMtYT4a4FTsN6x+cxqXw43N5gcbRwSSaduW+1BJH+AioQoZRjHQQ4kZXAosN
         yLCtiKoM8JFMAtGJRW0jAxjAUNsb7KIrXZ6TQhkEdv0wuCzyoO+NHHQ2qllF9DS8xbh0
         Bs+wzCwkAneagc8IgROQcBV+Vpj9j+p1wbp0P1HFOby73uFf4ebr8IZdSxZkBvK9yzkY
         vRvoIBVutoqEKyqR+/YA2npIoO00HH6y1XWYtBt6rrPj2W1dcDpc0UOSfBwysUnJ5MmI
         MvQaW/MK376UA7irikIs2CsVbPChdBHSGArWsOw0n8EmZmdGWxMBWP2GaD7ijHcTf1pg
         t0mw==
X-Forwarded-Encrypted: i=1; AJvYcCXLsxfNBQH1oPBBoTpi95giLJ81f9uOVW7RnSvldTsYQDdR4ekk7yqVaS9f+66yhTPWq9V6sG8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnPLEzntPsFbgvkvJFTLudk3vvR5ys7yB0ndiWDsQBmDXzkPcw
	Yh598w5nj7uTayTBJM7Ee0cUZu9m7i1g3vbQFZ78N27yCyJgzJvG272dpu4TXzCYzayyEmPLgrA
	u2JXgw+DnNA==
X-Google-Smtp-Source: AGHT+IEX0QsmaHRzdXXWpiOHEssJDXlcZyhYlHVBHCMUqKbAYQud2Ech1gyX0JKxepb1aoRf8FAZijN/ByjnfA==
X-Received: from qtbie20.prod.google.com ([2002:a05:622a:6994:b0:476:60b7:a431])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:5aca:0:b0:471:cfa9:2612 with SMTP id d75a77b69052e-47618add8dbmr56309931cf.32.1741363440634;
 Fri, 07 Mar 2025 08:04:00 -0800 (PST)
Date: Fri,  7 Mar 2025 16:03:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.49.0.rc0.332.g42c0ae87b1-goog
Message-ID: <20250307160358.3153859-1-edumazet@google.com>
Subject: [PATCH net-next] hamradio: use netdev_lockdep_set_classes() helper
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Stanislav Fomichev <sdf@fomichev.me>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	syzbot <syzkaller@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"

It is time to use netdev_lockdep_set_classes() in bpqether.c

List of related commits:

0bef512012b1 ("net: add netdev_lockdep_set_classes() to virtual drivers")
c74e1039912e ("net: bridge: use netdev_lockdep_set_classes()")
9a3c93af5491 ("vlan: use netdev_lockdep_set_classes()")
0d7dd798fd89 ("net: ipvlan: call netdev_lockdep_set_classes()")
24ffd752007f ("net: macvlan: call netdev_lockdep_set_classes()")
78e7a2ae8727 ("net: vrf: call netdev_lockdep_set_classes()")
d3fff6c443fe ("net: add netdev_lockdep_set_classes() helper")

syzbot reported:

WARNING: possible recursive locking detected
6.14.0-rc5-syzkaller-01064-g2525e16a2bae #0 Not tainted

dhcpcd/5501 is trying to acquire lock:
 ffff8880797e2d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2765 [inline]
 ffff8880797e2d28 (&dev->lock){+.+.}-{4:4}, at: register_netdevice+0x12d8/0x1b70 net/core/dev.c:11008

but task is already holding lock:
 ffff88802e530d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2765 [inline]
 ffff88802e530d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/linux/netdevice.h:2804 [inline]
 ffff88802e530d28 (&dev->lock){+.+.}-{4:4}, at: dev_change_flags+0x120/0x270 net/core/dev_api.c:65

other info that might help us debug this:
 Possible unsafe locking scenario:

       CPU0
       ----
  lock(&dev->lock);
  lock(&dev->lock);

 *** DEADLOCK ***

 May be due to missing lock nesting notation

2 locks held by dhcpcd/5501:
  #0: ffffffff8fed6848 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_net_lock include/linux/rtnetlink.h:130 [inline]
  #0: ffffffff8fed6848 (rtnl_mutex){+.+.}-{4:4}, at: devinet_ioctl+0x34c/0x1d80 net/ipv4/devinet.c:1121
  #1: ffff88802e530d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock include/linux/netdevice.h:2765 [inline]
  #1: ffff88802e530d28 (&dev->lock){+.+.}-{4:4}, at: netdev_lock_ops include/linux/netdevice.h:2804 [inline]
  #1: ffff88802e530d28 (&dev->lock){+.+.}-{4:4}, at: dev_change_flags+0x120/0x270 net/core/dev_api.c:65

stack backtrace:
CPU: 1 UID: 0 PID: 5501 Comm: dhcpcd Not tainted 6.14.0-rc5-syzkaller-01064-g2525e16a2bae #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2025
Call Trace:
 <TASK>
  __dump_stack lib/dump_stack.c:94 [inline]
  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
  print_deadlock_bug+0x483/0x620 kernel/locking/lockdep.c:3039
  check_deadlock kernel/locking/lockdep.c:3091 [inline]
  validate_chain+0x15e2/0x5920 kernel/locking/lockdep.c:3893
  __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5228
  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5851
  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
  __mutex_lock+0x19c/0x1010 kernel/locking/mutex.c:730
  netdev_lock include/linux/netdevice.h:2765 [inline]
  register_netdevice+0x12d8/0x1b70 net/core/dev.c:11008
  bpq_new_device drivers/net/hamradio/bpqether.c:499 [inline]
  bpq_device_event+0x4b1/0x8d0 drivers/net/hamradio/bpqether.c:542
  notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
 __dev_notify_flags+0x207/0x400
  netif_change_flags+0xf0/0x1a0 net/core/dev.c:9442
  dev_change_flags+0x146/0x270 net/core/dev_api.c:66
  devinet_ioctl+0xea2/0x1d80 net/ipv4/devinet.c:1200
  inet_ioctl+0x3d7/0x4f0 net/ipv4/af_inet.c:1001
  sock_do_ioctl+0x158/0x460 net/socket.c:1190
  sock_ioctl+0x626/0x8e0 net/socket.c:1309
  vfs_ioctl fs/ioctl.c:51 [inline]
  __do_sys_ioctl fs/ioctl.c:906 [inline]
  __se_sys_ioctl+0xf5/0x170 fs/ioctl.c:892
  do_syscall_x64 arch/x86/entry/common.c:52 [inline]
  do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fixes: 7e4d784f5810 ("net: hold netdev instance lock during rtnetlink operations")
Reported-by: syzbot <syzkaller@googlegroups.com>
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 drivers/net/hamradio/bpqether.c | 24 ++----------------------
 1 file changed, 2 insertions(+), 22 deletions(-)

diff --git a/drivers/net/hamradio/bpqether.c b/drivers/net/hamradio/bpqether.c
index bac1bb69d63a11922d73a57d69a97eb4cb53c98b..f6b0bfbbc753f6c69d47d9fdd3af0ebcabb21ead 100644
--- a/drivers/net/hamradio/bpqether.c
+++ b/drivers/net/hamradio/bpqether.c
@@ -107,27 +107,6 @@ struct bpqdev {
 
 static LIST_HEAD(bpq_devices);
 
-/*
- * bpqether network devices are paired with ethernet devices below them, so
- * form a special "super class" of normal ethernet devices; split their locks
- * off into a separate class since they always nest.
- */
-static struct lock_class_key bpq_netdev_xmit_lock_key;
-static struct lock_class_key bpq_netdev_addr_lock_key;
-
-static void bpq_set_lockdep_class_one(struct net_device *dev,
-				      struct netdev_queue *txq,
-				      void *_unused)
-{
-	lockdep_set_class(&txq->_xmit_lock, &bpq_netdev_xmit_lock_key);
-}
-
-static void bpq_set_lockdep_class(struct net_device *dev)
-{
-	lockdep_set_class(&dev->addr_list_lock, &bpq_netdev_addr_lock_key);
-	netdev_for_each_tx_queue(dev, bpq_set_lockdep_class_one, NULL);
-}
-
 /* ------------------------------------------------------------------------ */
 
 
@@ -454,6 +433,8 @@ static const struct net_device_ops bpq_netdev_ops = {
 
 static void bpq_setup(struct net_device *dev)
 {
+	netdev_lockdep_set_classes(dev);
+
 	dev->netdev_ops	     = &bpq_netdev_ops;
 	dev->needs_free_netdev = true;
 
@@ -499,7 +480,6 @@ static int bpq_new_device(struct net_device *edev)
 	err = register_netdevice(ndev);
 	if (err)
 		goto error;
-	bpq_set_lockdep_class(ndev);
 
 	/* List protected by RTNL */
 	list_add_rcu(&bpq->bpq_list, &bpq_devices);
-- 
2.49.0.rc0.332.g42c0ae87b1-goog



Return-Path: <netdev+bounces-198175-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D48ADB7B0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 19:22:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17EAD188D94B
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 17:22:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C81D02877C3;
	Mon, 16 Jun 2025 17:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQNzei1N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B192BF017;
	Mon, 16 Jun 2025 17:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750094537; cv=none; b=eWQhUh7V7kBXVlgh7XRoUUmI879dgpOx1gXcI3V84AHDpXW1nuokyGhK7CEX1buepHjd8jdmdGL2bmWkjaqOAZdDWQWxn+mGWvQVrTpPLyKlOq0ZFcneTvwUMxSiHRMfOQcmrp1Ab6reqPueePHj6NUAHI2fkgZ99GnrBmcdbT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750094537; c=relaxed/simple;
	bh=P+SSue73N4lAs0qB3b4VM8Xkfxno5zBJHyIJqBse+wo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cgXjpp0tmnNc9RpaSx61o52e07GcrgAhTCdCgxMY43riMj2WL05Is8PoqY8KUklZhp0Fskr8DPE86RjPQjfJZ81SlisZGJno3jfwhO5kysLOB5ZCY2MRBa38og3SYHpuJ0MtvqZML7o/sCLKkQLDQsorK1K9kT1+mgZk2td59G4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQNzei1N; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-234b440afa7so47977345ad.0;
        Mon, 16 Jun 2025 10:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750094535; x=1750699335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G1485tA8GgfFcfzz2MsCdOclvlrLtL+++u0j91aiOZ8=;
        b=ZQNzei1Nt8RE5kmpAXy6fZgwgX1jwcieizIdyNnvyLi5h4eGCNmswD18CZvfPLR/ZJ
         w+FJ6RhkbmncQUvN18hKVIEqdnx0mbNSLM12eXbT2kwJbJMeYd/jw5iFjI8TCRjewXYg
         Xd/9971GQJ/Oif3DhYTDF4n2oOaYnbfI+yAQIYwMLzriygNSeNSPNJlbVl8kJ9abOjj9
         C0CP4pjTZ0e+pucKucmFgdLbq2C2OF97luFXqjzo5RCsi0tq3kK2SPwF9QROJRXtyhHq
         XPiSsDbmZQGRVtpLRawLEfI4o1OZmJ7iERTrRvekRwO87tm13knP94tsvbgtsjfZcNL5
         vnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750094535; x=1750699335;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G1485tA8GgfFcfzz2MsCdOclvlrLtL+++u0j91aiOZ8=;
        b=LaLCKqTglI2mLjMaQ60kniw8SIAUvHzKXYaNnAJg+DGNgjj3cNPhltf5na349L/+S2
         RP9iSe9U+psABG8AB1kEbS7KPchRwzWCuGbeV0Cc+QUuJ/7u6w2G+OGq8RJz+V4F8kBF
         fYdawS2rTV7HdxWKhkpo82L/AnY0gH7hAXzvZEsAiytgTM2tZYsKFlipHkCbO5nbdu2F
         Famcp5Bk5B8frIrKtdQ+7UelOx60rx5slKJTJEPQOBBiqLpWNves4Rn1lNaZYsNbWRL9
         8EszLvu73WcyssjxaLTO7jULk5+wO2GMb45ZgmfYqjBtWHUrTOqPpUeUkqrzyjNpUkiz
         n7mQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5mM1+BwAwMnIXZr9rxlVTe0IoCWf1OLJy8sSSdH5kaMqxMJvmWFMVUHZEpkfmVpgWaE3amJULz03byWQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywk//KiCSL9LwgPKD1beodak6+sXmsbk3cWxWHlSxVlIgxuebZp
	/Qpd2eCw/xLKClmJK0uIyesgUsf3Z0LlncvuOqgTK4stucmX7aDOy9r1nLb+
X-Gm-Gg: ASbGncsOrQqr+L9nszWU/3Pp7D4mLGN+NR3cB70XgnKsQrHX4QFAjvo6Ii3is0+CH5Q
	ajxJhp+5F5PLAZ6Vk6d0poN0YqFp1y/bhecr9n/kmacgt8nh2jae4Z2vI1/MiuVtYdlwYLtUVqI
	tThGydArV0g+8OUJ2p+INxA1MudlLHCN80ImfxgehgaFpjU3yA2K6UJ4lXu6GD4gDTi0SxFmSn4
	6SyKcsqHT3gKZ4IBrLXZe59lqjGdz5NIeHuhg3sgedLa1UpIsHxwNSZsYywskj949eQBaFh4Pzn
	jORY2YNNFJMLCwXHp2pMfMyK/pJtjE2EzWjv6MP+5aQSr43PQoMtteJdsNM1Dgl1UdkC55S1zqk
	U9K0BEzWjcmXNLlsaktA7bhQ=
X-Google-Smtp-Source: AGHT+IEwHn9PP+yunLgpuZIxZZXjUSR/YE46VZUktC0AKteUOAbi6+3q4leQnmNqSCrmFYUiSvfS0g==
X-Received: by 2002:a17:902:c404:b0:235:c9ef:c9e1 with SMTP id d9443c01a7336-2366b337dfbmr150977425ad.5.1750094534981;
        Mon, 16 Jun 2025 10:22:14 -0700 (PDT)
Received: from localhost (c-73-158-218-242.hsd1.ca.comcast.net. [73.158.218.242])
        by smtp.gmail.com with UTF8SMTPSA id d9443c01a7336-2365dfc56a7sm64049785ad.233.2025.06.16.10.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jun 2025 10:22:14 -0700 (PDT)
From: Stanislav Fomichev <stfomichev@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jv@jvosburgh.net,
	andrew+netdev@lunn.ch,
	sdf@fomichev.me,
	liuhangbin@gmail.com,
	linux-kernel@vger.kernel.org,
	syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
Subject: [PATCH net] bonding: switch bond_miimon_inspect to rtnl lock
Date: Mon, 16 Jun 2025 10:22:13 -0700
Message-ID: <20250616172213.475764-1-stfomichev@gmail.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Syzkaller reports the following issue:

 RTNL: assertion failed at ./include/net/netdev_lock.h (72)
 WARNING: CPU: 0 PID: 1141 at ./include/net/netdev_lock.h:72 netdev_ops_assert_locked include/net/netdev_lock.h:72 [inline]
 WARNING: CPU: 0 PID: 1141 at ./include/net/netdev_lock.h:72 __linkwatch_sync_dev+0x1ed/0x230 net/core/link_watch.c:279

 ethtool_op_get_link+0x1d/0x70 net/ethtool/ioctl.c:63
 bond_check_dev_link+0x3f9/0x710 drivers/net/bonding/bond_main.c:863
 bond_miimon_inspect drivers/net/bonding/bond_main.c:2745 [inline]
 bond_mii_monitor+0x3c0/0x2dc0 drivers/net/bonding/bond_main.c:2967
 process_one_work+0x9cf/0x1b70 kernel/workqueue.c:3238
 process_scheduled_works kernel/workqueue.c:3321 [inline]
 worker_thread+0x6c8/0xf10 kernel/workqueue.c:3402
 kthread+0x3c5/0x780 kernel/kthread.c:464
 ret_from_fork+0x5d4/0x6f0 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245

As discussed in [0], the report is a bit bogus, but it exposes
the fact that bond_miimon_inspect might sleep while its being
called under RCU read lock. Convert bond_miimon_inspect callers
(bond_mii_monitor) to rtnl lock.

Reported-by: syzbot+b8c48ea38ca27d150063@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=b8c48ea38ca27d150063
Link: http://lore.kernel.org/netdev/aEt6LvBMwUMxmUyx@mini-arch [0]
Fixes: f7a11cba0ed7 ("bonding: hold ops lock around get_link")
Signed-off-by: Stanislav Fomichev <stfomichev@gmail.com>
---
 drivers/net/bonding/bond_main.c | 34 +++++++++++++--------------------
 1 file changed, 13 insertions(+), 21 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index c4d53e8e7c15..ab40f0828680 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2720,7 +2720,6 @@ static int bond_slave_info_query(struct net_device *bond_dev, struct ifslave *in
 
 /*-------------------------------- Monitoring -------------------------------*/
 
-/* called with rcu_read_lock() */
 static int bond_miimon_inspect(struct bonding *bond)
 {
 	bool ignore_updelay = false;
@@ -2729,17 +2728,17 @@ static int bond_miimon_inspect(struct bonding *bond)
 	struct slave *slave;
 
 	if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP) {
-		ignore_updelay = !rcu_dereference(bond->curr_active_slave);
+		ignore_updelay = !rtnl_dereference(bond->curr_active_slave);
 	} else {
 		struct bond_up_slave *usable_slaves;
 
-		usable_slaves = rcu_dereference(bond->usable_slaves);
+		usable_slaves = rtnl_dereference(bond->usable_slaves);
 
 		if (usable_slaves && usable_slaves->count == 0)
 			ignore_updelay = true;
 	}
 
-	bond_for_each_slave_rcu(bond, slave, iter) {
+	bond_for_each_slave(bond, slave, iter) {
 		bond_propose_link_state(slave, BOND_LINK_NOCHANGE);
 
 		link_state = bond_check_dev_link(bond, slave->dev, 0);
@@ -2962,35 +2961,28 @@ static void bond_mii_monitor(struct work_struct *work)
 	if (!bond_has_slaves(bond))
 		goto re_arm;
 
-	rcu_read_lock();
+	/* Race avoidance with bond_close cancel of workqueue */
+	if (!rtnl_trylock()) {
+		delay = 1;
+		should_notify_peers = false;
+		goto re_arm;
+	}
+
 	should_notify_peers = bond_should_notify_peers(bond);
 	commit = !!bond_miimon_inspect(bond);
 	if (bond->send_peer_notif) {
-		rcu_read_unlock();
-		if (rtnl_trylock()) {
-			bond->send_peer_notif--;
-			rtnl_unlock();
-		}
-	} else {
-		rcu_read_unlock();
+		bond->send_peer_notif--;
 	}
 
 	if (commit) {
-		/* Race avoidance with bond_close cancel of workqueue */
-		if (!rtnl_trylock()) {
-			delay = 1;
-			should_notify_peers = false;
-			goto re_arm;
-		}
-
 		bond_for_each_slave(bond, slave, iter) {
 			bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
 		}
 		bond_miimon_commit(bond);
-
-		rtnl_unlock();	/* might sleep, hold no other locks */
 	}
 
+	rtnl_unlock();	/* might sleep, hold no other locks */
+
 re_arm:
 	if (bond->params.miimon)
 		queue_delayed_work(bond->wq, &bond->mii_work, delay);
-- 
2.49.0



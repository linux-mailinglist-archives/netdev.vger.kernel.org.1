Return-Path: <netdev+bounces-112123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56B98935216
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 21:20:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87EB71C2194C
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 19:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E32D71459EE;
	Thu, 18 Jul 2024 19:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="pKxxsQ7d"
X-Original-To: netdev@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BDE144D18
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 19:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721330434; cv=none; b=dF7WTeIX3IHUx+qfW5Y3FLYGCbr32/xEu7aJyKCuIrF43x7cdOCoaJ0q6PsQyfI0XqAhSDF4Abe9Jf6SFsN8mMoExblDqiZjr8rgUwddRxFrWZfmHDXI+j3xKEQ+pZDmbch2fQEaSHqwI9r000pK64E2TDnTOj93zImTakuBNTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721330434; c=relaxed/simple;
	bh=C/cgGiKvIEShFbhEZr0UQndy2ssyqpxL31XTJ2Nizng=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uKhrWllz9IO8ES1nJpNXvlLAYFr+7tIVYLtQAmerLIyqvHU8lMV4tFDaAkRW+ZyYF4gJ4NHHjvl2t5zBi/AFYbdzX7YZBPnhOGVT8Y2u7rB+37Ywctl2CMW454dKLmfIH15edX3eofK0gLlJSmatRF7VQwFORhOjfxRHiRWFXIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=pKxxsQ7d; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=swAOe8liAW3pIRgiEg9MR3BqneweulID0oJQH2NBw/c=;
	t=1721330432; x=1722540032; b=pKxxsQ7d/rga0kpmcyk4zdSjQuXjjjsHaLWyzgMHD67H/mk
	0fWty2/4bK2XTCtlc8ZANoLvzgEwnA6RtV9Vhswz2z2+uiDl6cUyu48lgj7vxJWJKtCLIy1Cs4MAi
	zG1Z9xgLDKvC9R7NOQ18bBNnwwA5SXIS5RtkqTTJxq0DVwsass+ltPwv+M2kRoFTrqG9jvNHPIoMH
	F13ir2YLFK08gg/SUtO1xjRSFkY8PojeWkX72/BJts8TG92BeQZmy+sLIG+BoRxpWXxXCcLn7pSZm
	f2BDSOKZm+6loV9vBpbRRcVIZg3kdgVUqmNh7ymU1nhT/dS9LoHb8aAka83pqlAQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1sUWfz-00000001wv4-2zGd;
	Thu, 18 Jul 2024 21:20:28 +0200
From: Johannes Berg <johannes@sipsolutions.net>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Johannes Berg <johannes.berg@intel.com>,
	syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com
Subject: [RFC PATCH 2/2] net: bonding: don't call ethtool methods under RCU
Date: Thu, 18 Jul 2024 12:20:17 -0700
Message-ID: <20240718122017.d2e33aaac43a.I10ab9c9ded97163aef4e4de10985cd8f7de60d28@changeid>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240718122017.b1051af4e7f7.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
References: <20240718122017.b1051af4e7f7.I68eb9c0f02545b364b79a59f2110f2cf5682a8e2@changeid>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Currently, bond_miimon_inspect() is called under RCU, but it
calls ethtool ops. Since my earlier commit facd15dfd691
("net: core: synchronize link-watch when carrier is queried")
this is no longer permitted in the general ethtool case, but
it was already not permitted for many drivers such as USB in
which it can sleep to do MDIO register accesses etc.

Therefore, it's better to simply not do this. Change bonding
to acquire the RTNL for the MII monitor work directly to call
the bond_miimon_inspect() function and thus ethtool ops.

Reported-by: syzbot+2120b9a8f96b3fa90bad@syzkaller.appspotmail.com
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 drivers/net/bonding/bond_main.c | 49 +++++++++++----------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 2ed0da068490..6a635c23b00e 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2576,7 +2576,6 @@ static int bond_slave_info_query(struct net_device *bond_dev, struct ifslave *in
 
 /*-------------------------------- Monitoring -------------------------------*/
 
-/* called with rcu_read_lock() */
 static int bond_miimon_inspect(struct bonding *bond)
 {
 	bool ignore_updelay = false;
@@ -2585,17 +2584,17 @@ static int bond_miimon_inspect(struct bonding *bond)
 	struct slave *slave;
 
 	if (BOND_MODE(bond) == BOND_MODE_ACTIVEBACKUP) {
-		ignore_updelay = !rcu_dereference(bond->curr_active_slave);
+		ignore_updelay = !rcu_access_pointer(bond->curr_active_slave);
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
@@ -2807,8 +2806,7 @@ static void bond_mii_monitor(struct work_struct *work)
 {
 	struct bonding *bond = container_of(work, struct bonding,
 					    mii_work.work);
-	bool should_notify_peers = false;
-	bool commit;
+	bool should_notify_peers;
 	unsigned long delay;
 	struct slave *slave;
 	struct list_head *iter;
@@ -2818,45 +2816,30 @@ static void bond_mii_monitor(struct work_struct *work)
 	if (!bond_has_slaves(bond))
 		goto re_arm;
 
-	rcu_read_lock();
-	should_notify_peers = bond_should_notify_peers(bond);
-	commit = !!bond_miimon_inspect(bond);
-	if (bond->send_peer_notif) {
-		rcu_read_unlock();
-		if (rtnl_trylock()) {
-			bond->send_peer_notif--;
-			rtnl_unlock();
-		}
-	} else {
-		rcu_read_unlock();
+	/* deadlock avoidance with bond_close cancel of workqueue */
+	if (!rtnl_trylock()) {
+		delay = 1;
+		goto re_arm;
 	}
 
-	if (commit) {
-		/* Race avoidance with bond_close cancel of workqueue */
-		if (!rtnl_trylock()) {
-			delay = 1;
-			should_notify_peers = false;
-			goto re_arm;
-		}
+	should_notify_peers = bond_should_notify_peers(bond);
 
+	if (bond_miimon_inspect(bond)) {
 		bond_for_each_slave(bond, slave, iter) {
 			bond_commit_link_state(slave, BOND_SLAVE_NOTIFY_LATER);
 		}
 		bond_miimon_commit(bond);
-
-		rtnl_unlock();	/* might sleep, hold no other locks */
 	}
 
+	if (bond->send_peer_notif)
+		bond->send_peer_notif--;
+	if (should_notify_peers)
+		call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
+	rtnl_unlock();	/* might sleep, hold no other locks */
+
 re_arm:
 	if (bond->params.miimon)
 		queue_delayed_work(bond->wq, &bond->mii_work, delay);
-
-	if (should_notify_peers) {
-		if (!rtnl_trylock())
-			return;
-		call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
-		rtnl_unlock();
-	}
 }
 
 static int bond_upper_dev_walk(struct net_device *upper,
-- 
2.45.2



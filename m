Return-Path: <netdev+bounces-232956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5250EC0A5AF
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 10:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1705E3A218A
	for <lists+netdev@lfdr.de>; Sun, 26 Oct 2025 09:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 292FF2580CA;
	Sun, 26 Oct 2025 09:56:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B367F1DD525
	for <netdev@vger.kernel.org>; Sun, 26 Oct 2025 09:56:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761472610; cv=none; b=qlJUORrgNrK+e5ech2wEOfFoSGr8g3ditqvFQfHV+58Uktr7Ekfb2HuAF4Uop3+C5XisD8qHVrEPHnmLzqVWJAuvq6q3RneBWIKBe50prkKMXZ/TuJKdAf5djIlkcT6i2ub66cEjcMMhV3AKkYTwaSYNQoqL1WxJkkaVPcizvTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761472610; c=relaxed/simple;
	bh=iEsuqULAJPEuF2OrnYs/omAnpA0zp96HI1C4PZtLoM8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=GQn5sUFh8WnXkdMKrzrdPsONOLSxltPsygw4LYBKqz3VBsmwTAtZqEtKjvQbuC8dw/02Et3ozBzEo78BXS0gbafMhcQCkrUMYsczNc5TyFfkNjZCVBtu6D9Afyoi4msdIOymmRnL7mlAlzcNrduz55TK8DqEtLrVA9pibE7ie0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz7t1761472590t38536fc8
X-QQ-Originating-IP: 8SWbL+UsvuLouDnNFrSsUalQ5hhwB2i41sOjQk7JtvM=
Received: from MacBook-Pro-022.xiaojukeji.com ( [183.241.14.145])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 26 Oct 2025 17:56:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9624659621215045846
EX-QQ-RecipientCnt: 12
From: Tonghao Zhang <tonghao@bamaicloud.com>
To: netdev@vger.kernel.org
Cc: Tonghao Zhang <tonghao@bamaicloud.com>,
	Jay Vosburgh <jv@jvosburgh.net>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Hangbin Liu <liuhangbin@gmail.com>
Subject: [PATCH net-next] net: bonding: use atomic instead of rtnl_mutex, to make sure peer notify updated
Date: Sun, 26 Oct 2025 17:56:14 +0800
Message-Id: <20251026095614.48833-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: M/uR2EdOV2H4r2afIdNkkw8nkoSxPGUfup54rvyXGVUfSoDXBF3p1IkV
	5kKtVb0aOVQM/qtf2gLUQXdluIwFqCuam1FqeUlujrGDhGEqsCl6uPDkFhKLRRsHTIz+gO3
	dATPk+K3sYaQqmJVW+ty/SxY0NwA93bZayc0oNm1wcSm+wcCnNenFKZahyuX3OZFwUv8Qgc
	e1nX3ZARfcM0OR/f4d3CmlULXiCVNpQhGYLD5h4chNvNZK+HRq8AXupAAlXklPDK1dJ/KS7
	gEhCd3Uh5tXPKSb2MgIZshXsLtPT/H+yE7F6PCdSor1M4Dfuei2idJgmN/tUnfX/gtAZ3If
	cWzCOW4dkV9J1u2tlfS1BOYbyaXAKpmScYvqR9mlfa3UpxHVxszX1YlcE/n6zs8/FGvEfxi
	D3zSFtqp0HDoZtbFDYDwGlrjfLhtwKmLCv43jMWg8Bfd+acjp9C2vfHbRsZJnEya0wII5+4
	QeuqhvpXMNZ5VGwnMRTa1wFz+N17e/5CQrgqt2mwmBDn7TbcSrhzmz3/vDIWLoXLiEIl9h+
	PxOfJfQfmJd/MFldzS/4WkinnekUxMioW8SVh1w5ShyKQRY279lmeIIbx+kEFpk6Ya218HW
	GKKDLkaNOdjHN/j80g7xWKkU8XGu5d0tnE5I8vWnZdD2frW8DiHe4jKyOaV7mmC7tlbbYlt
	cQ4UhHv8dKTKPQVz7F3qM0LUpH+qmsWavrx22UuZVvMKtGcK/2ya432UIKLpCbq7P4Zy2Es
	/voWF7zY6nYogcbofB8fxqZ/krI0s2RPiJ4FaT1DtZ8QaAyiNOMjhz0k2qploXB8ysmqlfG
	sVQsH5nEFoqaVMgL9VRL1gOHoIIa6ip7UeNhr6PyyLlzuDb2+EFaw6MLzO0U3PaxrLt0Rnf
	rLkLHnSh0GSCx7FgEYPE8EdbOmi/K70SPgZjm6THTRrW7yWsvd9MNR/57yAE7l6NPWK5j1c
	pEq2Yv2H34Jp5bH3qvtKFGwyFsrHAy+7z4MQz+pByxITJtvhiswAzIFHI
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

Using atomic to protect the send_peer_notif instead of rtnl_mutex.
This approach allows safe updates in both interrupt and process
contexts, while avoiding code complexity.

In LACP mode, the RTNL might be locked, preventing ad_cond_set_peer_notif
from acquiring the lock and updating send_peer_notif. This patch addresses
the issue by using a atomic. Since updating send_peer_notif does not
require high real-time performance, such atomic updates are acceptable.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
Cc: Hangbin Liu <liuhangbin@gmail.com>
Suggested-by: Jay Vosburgh <jv@jvosburgh.net>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
---
 drivers/net/bonding/bond_3ad.c  |  7 ++---
 drivers/net/bonding/bond_main.c | 45 +++++++++++++++------------------
 include/net/bonding.h           |  9 ++++++-
 3 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 49717b7b82a2..05c573e45450 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -999,11 +999,8 @@ static void ad_cond_set_peer_notif(struct port *port)
 {
 	struct bonding *bond = port->slave->bond;
 
-	if (bond->params.broadcast_neighbor && rtnl_trylock()) {
-		bond->send_peer_notif = bond->params.num_peer_notif *
-			max(1, bond->params.peer_notif_delay);
-		rtnl_unlock();
-	}
+	if (bond->params.broadcast_neighbor)
+		bond_peer_notify_reset(bond);
 }
 
 /**
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 8e592f37c28b..c3841e6a1b97 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1167,10 +1167,11 @@ static bool bond_should_notify_peers(struct bonding *bond)
 {
 	struct bond_up_slave *usable;
 	struct slave *slave = NULL;
+	int send_peer_notif;
 
-	if (!bond->send_peer_notif ||
-	    bond->send_peer_notif %
-	    max(1, bond->params.peer_notif_delay) != 0 ||
+	send_peer_notif = atomic_read(&bond->send_peer_notif);
+	if (!send_peer_notif ||
+	    send_peer_notif % max(1, bond->params.peer_notif_delay) != 0 ||
 	    !netif_carrier_ok(bond->dev))
 		return false;
 
@@ -1270,8 +1271,6 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 						      BOND_SLAVE_NOTIFY_NOW);
 
 		if (new_active) {
-			bool should_notify_peers = false;
-
 			bond_set_slave_active_flags(new_active,
 						    BOND_SLAVE_NOTIFY_NOW);
 
@@ -1280,19 +1279,17 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 						      old_active);
 
 			if (netif_running(bond->dev)) {
-				bond->send_peer_notif =
-					bond->params.num_peer_notif *
-					max(1, bond->params.peer_notif_delay);
-				should_notify_peers =
-					bond_should_notify_peers(bond);
+				bond_peer_notify_reset(bond);
+
+				if (bond_should_notify_peers(bond))
+					call_netdevice_notifiers(
+							NETDEV_NOTIFY_PEERS,
+							bond->dev);
+
+				atomic_dec_if_positive(&bond->send_peer_notif);
 			}
 
 			call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
-			if (should_notify_peers) {
-				bond->send_peer_notif--;
-				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
-							 bond->dev);
-			}
 		}
 	}
 
@@ -2801,7 +2798,7 @@ static void bond_mii_monitor(struct work_struct *work)
 
 	rcu_read_unlock();
 
-	if (commit || bond->send_peer_notif) {
+	if (commit || atomic_read(&bond->send_peer_notif)) {
 		/* Race avoidance with bond_close cancel of workqueue */
 		if (!rtnl_trylock()) {
 			delay = 1;
@@ -2816,12 +2813,10 @@ static void bond_mii_monitor(struct work_struct *work)
 			bond_miimon_commit(bond);
 		}
 
-		if (bond->send_peer_notif) {
-			bond->send_peer_notif--;
-			if (should_notify_peers)
-				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
-							 bond->dev);
-		}
+		atomic_dec_if_positive(&bond->send_peer_notif);
+
+		if (should_notify_peers)
+			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
 
 		rtnl_unlock();	/* might sleep, hold no other locks */
 	}
@@ -3773,7 +3768,7 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 			return;
 
 		if (should_notify_peers) {
-			bond->send_peer_notif--;
+			atomic_dec_if_positive(&bond->send_peer_notif);
 			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
 						 bond->dev);
 		}
@@ -4267,6 +4262,8 @@ static int bond_open(struct net_device *bond_dev)
 			queue_delayed_work(bond->wq, &bond->alb_work, 0);
 	}
 
+	atomic_set(&bond->send_peer_notif, 0);
+
 	if (bond->params.miimon)  /* link check interval, in milliseconds. */
 		queue_delayed_work(bond->wq, &bond->mii_work, 0);
 
@@ -4300,7 +4297,7 @@ static int bond_close(struct net_device *bond_dev)
 	struct slave *slave;
 
 	bond_work_cancel_all(bond);
-	bond->send_peer_notif = 0;
+	atomic_set(&bond->send_peer_notif, 0);
 	if (bond_is_lb(bond))
 		bond_alb_deinitialize(bond);
 	bond->recv_probe = NULL;
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 49edc7da0586..afdfcb5bfaf0 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -236,7 +236,7 @@ struct bonding {
 	 */
 	spinlock_t mode_lock;
 	spinlock_t stats_lock;
-	u32	 send_peer_notif;
+	atomic_t send_peer_notif;
 	u8       igmp_retrans;
 #ifdef CONFIG_PROC_FS
 	struct   proc_dir_entry *proc_entry;
@@ -814,4 +814,11 @@ static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *s
 	return NET_XMIT_DROP;
 }
 
+static inline void bond_peer_notify_reset(struct bonding *bond)
+{
+	atomic_set(&bond->send_peer_notif,
+		bond->params.num_peer_notif *
+		max(1, bond->params.peer_notif_delay));
+}
+
 #endif /* _NET_BONDING_H */
-- 
2.34.1



Return-Path: <netdev+bounces-237119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 38EB4C458CE
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 10:14:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D502A188F582
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 09:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 462ED2FE059;
	Mon, 10 Nov 2025 09:14:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB6A2620D2
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 09:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762766053; cv=none; b=LrrQZbJc0pt2QBipA5dc5nvCg3j53CiC/NCsAmMwiEZbs22TmQqIIu8YeNIjt+xan1VX3YGKud4yM/m3jon2/Icg4yeQNeyDa7F3fsnzlqX7WG/8TIuci7eVRY3J7ImXnUVkrQCEnMMRGe1JyvtQZ5xDGqDrFlX1j9lSv2z11w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762766053; c=relaxed/simple;
	bh=n0f/j+AHNa7atUB26fr1DKQdnNinkoyaNxejrTHEoRc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZkS5geJV6yVupfXnV4uYz1K4mVtUzG5s4yxZaoKYZpJYTQ+RTFsQm6pfX1ZP1hLe75T34s6MdgDynMqEQuOO2ElX29RIRN7i3YsnZZUlmg5CHSS29VKA6KHZOfs549ed7bgpYyz2pHRSacKxCVkv3WTJRqRAEEO142tMwqDxYXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz8t1762766029tb20b8ffe
X-QQ-Originating-IP: s/SUhuYfhfm1BNZ30y4fPu2soN9QytQUZKDpbHZUCm8=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 10 Nov 2025 17:13:47 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6516140205555507445
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
Subject: [PATCH net-next v4] net: bonding: use atomic instead of rtnl_mutex, to make sure peer notify updated
Date: Mon, 10 Nov 2025 17:13:37 +0800
Message-Id: <20251110091337.43517-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: M3uTjkO5QXGx/x7YjkezqlX2VszPcML6hAi5AdL9X9YUe2uKTe4TrKPY
	/TApyGbkVoMys+Ixylw+ouz4D3Ljj1Rb3Zdwxdp5Oq5BF98Oton8xOEkBx/Z1vRg/EU78Eq
	rpK8tjikshvFAlj2FjH9P7ZDHbx1Q/NCgxpvxsAec8z9AH9DlGO2ItMIIS1kVwnCgBznURo
	Q8D/+LCfnTu3ZyJzaCf6WCbjxQ5CO/SlIgx9Ioqg+gxwM+wAMq2F1FC/QR3VussExoCPkSG
	mY5P8ZDd0bAWPoYZUUWSMMdO70geVu7tSemkMnU/p+CmBCn8E+Rlk76MJLTstL1/bFYmL55
	gSz2jDFYKJvc0hQozXYYnK7ucs6jDfpIHHXopW8VNndFMEevjYz5pT5CEqyPssHplYyLoQL
	EtnHHQP9xqsi04LgHKomjY1dMH8shIDzxqmvmXffhrxBdIiaRoYSlpReOca4c4N75qFJBtT
	BhGdbnsgfUbTexrSUc+I0kxt76ttUDHOj9YYHKU3znJIqPpkNpcKkMTvvdrsl4aYrnX83fO
	FbFGmXINyVcpWg4OYUG5EV6CfJbwZ8J+JEf+kKwjZ9TMW12ZeIwC1Qui8IY88ohzV67v5y8
	8jolq5vtYEkwvR4zMLqoxJZOhiFPhupI52cMPQ1nuyZev44kXwpPW5BsmDmDKOz0mIyJyUS
	Lre33UH9EfjRbQUKfKUgYC1eRtMpki1rCNqKddqzBF7Ja2vVb33AtoOldbDpBwZ8Pw4ab0c
	4405K4Gy26FSaN4ztNsoej3dElbxEj6IjvVdOstuNENrqrfe4NLsK7irwaTHrQ7DBFKy04l
	QKm9bj+1lZCUVwnjqbqMYhCX6VYfl4Azmg0v4uZSnvFtHcdrWQ6ROFOq5ad/8LjBsR1gFxD
	/maY2xZMU4Qz0r42GNnBsq1NBH/o0bf7np3Pf9pBEwrJzN2w7Ek4JcLO1Sgbiuuw2QpRY7F
	N2ndHhGGuQBesv4RbYALxin1HhycojtZx3j2n7fKxauMZJ1OkkSQJWRKLiwMufUnWKP/vnW
	gEF2Xsc9mAuu90LbdIPxG2M/u8DhLGO8RdD5hzupo/cpRessI2TpjG0n8tS1sOhtVS3Rabw
	T0/NedKRBCSRNkO0cuHC/6rlq8eIyOVM3WXPg/49Q7WL1uzfJx3TaQ=
X-QQ-XMRINFO: NI4Ajvh11aEj8Xl/2s1/T8w=
X-QQ-RECHKSPAM: 0

Using atomic to protect the send_peer_notif instead of rtnl_mutex.
This approach allows safe updates in both interrupt and process
contexts, while avoiding code complexity.

In lacp mode, the rtnl might be locked, preventing ad_cond_set_peer_notif()
from acquiring the lock and updating send_peer_notif. This patch addresses
the issue by using a atomic. Since updating send_peer_notif does not
require high real-time performance, such atomic updates are acceptable.

By the way, send_peer_notif is reset atomically. For avoiding peer notify
event loss, we should invoke bond_should_notify_peers() to check whether
to send peer notify in bond_mii_monitor() and bond_activebackup_arp_mon().

More importantly, send_peer_notif-- should be placed with send_peer_notif
*if* block [2]. Otherwise [1], if atomic_dec is executed immediately after
resetting the send_peer_notif, it is very likely that the event will be lost.
- [1]:
	if (send_peer_notif) {
		...
	}
	// if reset and then atomic_dec, event will be lost.
	atomic_dec()

- [2] should be changed:
	if (send_peer_notif) {
		...
		// if reset and then atomic_dec, event may be lost.
		// but we are already in notify context.
		atomic_dec()
	}

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
v4:
- fix race in bond_activebackup_arp_mon()
- check send_peer_notif instead of should_notify_peers.
- move send_peer_notif-- in if block.
v3:
- add the comment, *_dec_if_positive is safe.
v2:
- refine the codes
- check bond_should_notify_peers again in bond_mii_monitor(), to avoid event loss.
v1:
- https://patchwork.kernel.org/project/netdevbpf/patch/20251026095614.48833-1-tonghao@bamaicloud.com/
---
 drivers/net/bonding/bond_3ad.c  |  7 +---
 drivers/net/bonding/bond_main.c | 71 +++++++++++++++++----------------
 include/net/bonding.h           |  9 ++++-
 3 files changed, 47 insertions(+), 40 deletions(-)

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
index 8e592f37c28b..386efac3bc64 100644
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
+				if (bond_should_notify_peers(bond)) {
+					atomic_dec(&bond->send_peer_notif);
+					call_netdevice_notifiers(
+							NETDEV_NOTIFY_PEERS,
+							bond->dev);
+				}
 			}
 
 			call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
-			if (should_notify_peers) {
-				bond->send_peer_notif--;
-				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
-							 bond->dev);
-			}
 		}
 	}
 
@@ -2783,11 +2780,11 @@ static void bond_mii_monitor(struct work_struct *work)
 {
 	struct bonding *bond = container_of(work, struct bonding,
 					    mii_work.work);
-	bool should_notify_peers;
-	bool commit;
-	unsigned long delay;
-	struct slave *slave;
 	struct list_head *iter;
+	struct slave *slave;
+	unsigned long delay;
+	int send_peer_notif;
+	bool commit;
 
 	delay = msecs_to_jiffies(bond->params.miimon);
 
@@ -2796,12 +2793,12 @@ static void bond_mii_monitor(struct work_struct *work)
 
 	rcu_read_lock();
 
-	should_notify_peers = bond_should_notify_peers(bond);
+	send_peer_notif = atomic_read(&bond->send_peer_notif);
 	commit = !!bond_miimon_inspect(bond);
 
 	rcu_read_unlock();
 
-	if (commit || bond->send_peer_notif) {
+	if (commit || send_peer_notif) {
 		/* Race avoidance with bond_close cancel of workqueue */
 		if (!rtnl_trylock()) {
 			delay = 1;
@@ -2816,11 +2813,13 @@ static void bond_mii_monitor(struct work_struct *work)
 			bond_miimon_commit(bond);
 		}
 
-		if (bond->send_peer_notif) {
-			bond->send_peer_notif--;
-			if (should_notify_peers)
+		if (send_peer_notif) {
+			if (bond_should_notify_peers(bond))
 				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
 							 bond->dev);
+
+			/* It's safe even when send_peer_notif was reset. */
+			atomic_dec_if_positive(&bond->send_peer_notif);
 		}
 
 		rtnl_unlock();	/* might sleep, hold no other locks */
@@ -3732,8 +3731,8 @@ static bool bond_ab_arp_probe(struct bonding *bond)
 
 static void bond_activebackup_arp_mon(struct bonding *bond)
 {
-	bool should_notify_peers = false;
 	bool should_notify_rtnl = false;
+	int send_peer_notif = 0;
 	int delta_in_ticks;
 
 	delta_in_ticks = msecs_to_jiffies(bond->params.arp_interval);
@@ -3743,15 +3742,12 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 
 	rcu_read_lock();
 
-	should_notify_peers = bond_should_notify_peers(bond);
-
 	if (bond_ab_arp_inspect(bond)) {
 		rcu_read_unlock();
 
 		/* Race avoidance with bond_close flush of workqueue */
 		if (!rtnl_trylock()) {
 			delta_in_ticks = 1;
-			should_notify_peers = false;
 			goto re_arm;
 		}
 
@@ -3762,21 +3758,26 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 	}
 
 	should_notify_rtnl = bond_ab_arp_probe(bond);
+	send_peer_notif = atomic_read(&bond->send_peer_notif);
+
 	rcu_read_unlock();
 
 re_arm:
 	if (bond->params.arp_interval)
 		queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
 
-	if (should_notify_peers || should_notify_rtnl) {
+	if (send_peer_notif || should_notify_rtnl) {
 		if (!rtnl_trylock())
 			return;
 
-		if (should_notify_peers) {
-			bond->send_peer_notif--;
-			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
-						 bond->dev);
+		if (send_peer_notif) {
+			if (bond_should_notify_peers(bond))
+				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
+							 bond->dev);
+			/* It's safe even when send_peer_notif was reset. */
+			atomic_dec_if_positive(&bond->send_peer_notif);
 		}
+
 		if (should_notify_rtnl) {
 			bond_slave_state_notify(bond);
 			bond_slave_link_notify(bond);
@@ -4267,6 +4268,8 @@ static int bond_open(struct net_device *bond_dev)
 			queue_delayed_work(bond->wq, &bond->alb_work, 0);
 	}
 
+	atomic_set(&bond->send_peer_notif, 0);
+
 	if (bond->params.miimon)  /* link check interval, in milliseconds. */
 		queue_delayed_work(bond->wq, &bond->mii_work, 0);
 
@@ -4300,7 +4303,7 @@ static int bond_close(struct net_device *bond_dev)
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



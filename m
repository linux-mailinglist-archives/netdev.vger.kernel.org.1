Return-Path: <netdev+bounces-235818-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B67C3611E
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 15:31:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D85B1425AA8
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 14:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CC82F5332;
	Wed,  5 Nov 2025 14:28:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FE86236A73
	for <netdev@vger.kernel.org>; Wed,  5 Nov 2025 14:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762352899; cv=none; b=Z1YwRzkVPibSgr8J4TX/irKUNvrYvNbZKv//mP9QnADoKgMDyML97y6Ow5sTrZNfyn9EP54WwMx7jvakhcrhtTgIVOBLm/XQGyVW3mKY9VAnIM0xQ0aIFCOa06zVOb3+aL3HLaJIxpPwV1VSvUD1r6uWSil69SeHK2YEs6VgU4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762352899; c=relaxed/simple;
	bh=a/wrqBrYHV3tHgmtp2HTOPqmTBedAumtAvHrFNZaHl8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TZFYhsm4IlxPEBKy6+an1OcPr4EsTy7j94jK6e+9ffu/a0oW80De9CUMiu2ky7JBQbFqkX73zpXQtD2kxjLtqgSug1HiJepcwD5e4p8HRA7xIDIIAzByhFCODtNKQ8ktDBummDf6YYjjuAK+K3HnCbob4NanbCZPRZ8wRX9q+NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz11t1762352881ta93aba55
X-QQ-Originating-IP: tatxyh4ipgbgeExdvlvv96CwOghrPefyUpntT9RSeHo=
Received: from MacBook-Pro-022.xiaojukeji.com ( [183.241.14.145])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 05 Nov 2025 22:27:59 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13932988905202351556
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
Subject: [PATCH net-next v3] net: bonding: use atomic instead of rtnl_mutex, to make sure peer notify updated
Date: Wed,  5 Nov 2025 22:27:39 +0800
Message-Id: <20251105142739.41833-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MX2TrL0qDY4ja92GiicZnPSjGr5Bf6FAt/PaDqfsb7e5gPjQ7aut3P3C
	69RfhGpDTUJjuZkZPuUe8jDAh0sYVekUJ2TDXiZjzDzwN8dBsmTunCe6TxSGLWlmwvM/69+
	Z1tejhgJz7LRoli3V2zTOzueDa+bfcPdjr2f4mwiJqS2nADcs0/WPe0HnUeSmdDJS97yDLS
	a6LimtLwFoXBySZDw3aCm5G35vvKxUJJQwWI5KQIEooGeHWPpUYBR9nEUEPFAsfV5hFOaXS
	uQaOhsBsPaKxg3C1PHxYuyj5fzqm0fYUA68P4v83T0tfBzHhmUMt4Mi5X+WFxRTaNPeUQjS
	H19k4pNKmoZHcWZFglpcUWsPHBSUQLd/00mR7+iO9InKnlnIESdZVxsE6l0TtJrmlm5zNpR
	rxgCykteZCVX7rT3VZqPM8i3/sDtwQR1ET/Rsr1w4tgicYMvbi2CH09oAHBai7mzm+3JhDj
	fo0KRlsFex5N8nkEyc6VvgHfMIasjlqHUUEHUxb+NH2pxzbV9hGCioTmWJEVDp/gmVu46Qd
	PQV2EoUvZhOMEbmaN7TwTzFISU+xWKIyqRXRYDg9lOFgNrLPPEb9fgorUWn1idL1cfr1e5o
	P9vOosEVHpSmWGDtR4QqXRSR92hl5orhdf60a3kdSUH7sN/I8YPOfdxNoOtzZD+lv0zDfmo
	iwpZN+bI16WFu7RnsorruW7XrbgknyWk1NDDODko2nYSlY6ifPRxPN5VfyANeX4CMqHxYK7
	kevjTpPvjDvXQ/z7jlnY1avTceiZYzZWkjf8KEJMbI+OwP3UpRq9o8Mja0C7+UDxWy9M9Wb
	YQzX7Uv7EOx0CyUsYfyNLsgDHlL/E8bjSKPex4OhhjOA0WChjzWEaaLSCG5ZS8Ez5t0C3UD
	Em+I0/bvjFI9AgvZ4LKDi/ddoyLVmoazuuayqfTtECrWNtwKZ2ZOsLzL40ZcpvEe9Tk0VRX
	zG0eDUay374yfGvdFXTXzxE6dHz3tDfqvtKEqpQmp43jZpbbHnCSZKcX+mk/WGyyIHCeFbh
	3xH8x9Ogc3Ntatu5bX
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
X-QQ-RECHKSPAM: 0

Using atomic to protect the send_peer_notif instead of rtnl_mutex.
This approach allows safe updates in both interrupt and process
contexts, while avoiding code complexity.

In lacp mode, the rtnl might be locked, preventing ad_cond_set_peer_notif()
from acquiring the lock and updating send_peer_notif. This patch addresses
the issue by using a atomic. Since updating send_peer_notif does not
require high real-time performance, such atomic updates are acceptable.

After coverting the rtnl lock for send_peer_notif to atomic, in bond_mii_monitor(),
we should check the should_notify_peers (rtnllock required) instead of
send_peer_notif. By the way, to avoid peer notify event loss, we check
again whether to send peer notify, such as active-backup mode failover.

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
v3:
- add the comment, *_dec_if_positive is safe.
v2:
- refine the codes
- check bond_should_notify_peers again in bond_mii_monitor(), to avoid event loss.
v1:
- https://patchwork.kernel.org/project/netdevbpf/patch/20251026095614.48833-1-tonghao@bamaicloud.com/
---
 drivers/net/bonding/bond_3ad.c  |  7 ++---
 drivers/net/bonding/bond_main.c | 47 ++++++++++++++++-----------------
 include/net/bonding.h           |  9 ++++++-
 3 files changed, 33 insertions(+), 30 deletions(-)

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
index 8e592f37c28b..4da92f3b129c 100644
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
 
@@ -2801,7 +2798,7 @@ static void bond_mii_monitor(struct work_struct *work)
 
 	rcu_read_unlock();
 
-	if (commit || bond->send_peer_notif) {
+	if (commit || should_notify_peers) {
 		/* Race avoidance with bond_close cancel of workqueue */
 		if (!rtnl_trylock()) {
 			delay = 1;
@@ -2816,16 +2813,16 @@ static void bond_mii_monitor(struct work_struct *work)
 			bond_miimon_commit(bond);
 		}
 
-		if (bond->send_peer_notif) {
-			bond->send_peer_notif--;
-			if (should_notify_peers)
-				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
-							 bond->dev);
-		}
+		/* check again to avoid send_peer_notif has been changed. */
+		if (bond_should_notify_peers(bond))
+			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
 
 		rtnl_unlock();	/* might sleep, hold no other locks */
 	}
 
+	/* this's safe to *_dec_if_positive, even when peer notify disabled. */
+	atomic_dec_if_positive(&bond->send_peer_notif);
+
 re_arm:
 	if (bond->params.miimon)
 		queue_delayed_work(bond->wq, &bond->mii_work, delay);
@@ -3773,7 +3770,7 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 			return;
 
 		if (should_notify_peers) {
-			bond->send_peer_notif--;
+			atomic_dec(&bond->send_peer_notif);
 			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
 						 bond->dev);
 		}
@@ -4267,6 +4264,8 @@ static int bond_open(struct net_device *bond_dev)
 			queue_delayed_work(bond->wq, &bond->alb_work, 0);
 	}
 
+	atomic_set(&bond->send_peer_notif, 0);
+
 	if (bond->params.miimon)  /* link check interval, in milliseconds. */
 		queue_delayed_work(bond->wq, &bond->mii_work, 0);
 
@@ -4300,7 +4299,7 @@ static int bond_close(struct net_device *bond_dev)
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



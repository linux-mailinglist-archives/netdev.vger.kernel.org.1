Return-Path: <netdev+bounces-248864-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A376ED105E3
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 47EB0305EE5B
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 02:43:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA54F304BB2;
	Mon, 12 Jan 2026 02:43:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEFCC3043BD
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 02:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768185793; cv=none; b=LWL30ZjqRZtFNCK8hhZwqHfnVpowwK49X7ZvHke3UJzEhGz7V2Y0KDR/blf970MWo3HceGjv4j08vM01oAafQ65AW2qZKlNftbxNTgOYD7uxFg60pw/4qvCyGCtVvACi4cQp/7b7v6wdbEtiJN/6yyO/b0z/ZNcC/Pa+OIUky34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768185793; c=relaxed/simple;
	bh=dfjrraVZF+UGu+oC9KCnFMQUqa1ETjxAIK2WpQoVr2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=vB878gcdav/wNua4SPNvG5tHRupfckxIfzzctw9LYYRA2BUw+HDQ8uH8qrRq4y7NFZaP/CuClxc3JW3OaOwjanvX9EfDuN9g3p30jA2dok/FbgQbdIqsPNdS/dPmn6//sRuvdo9MWu511AZitUHMANq3GfRuhQsl0w11bUTAJQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz13t1768185771t47e9b1b9
X-QQ-Originating-IP: 2Sjq2Xf9lHHA/iVo7YNOW0Cvz52mwMRgXWMP2MV1to4=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 Jan 2026 10:42:48 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13203207531478247873
EX-QQ-RecipientCnt: 13
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
	Hangbin Liu <liuhangbin@gmail.com>,
	Jason Xing <kerneljasonxing@gmail.com>
Subject: [PATCH RESEND net-next v4 1/4] net: bonding: use workqueue to make sure peer notify updated in lacp mode
Date: Mon, 12 Jan 2026 10:40:48 +0800
Message-Id: <895aa5609ef5be99150b4f3579ac0aa96ed083a7.1768184929.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1768184929.git.tonghao@bamaicloud.com>
References: <cover.1768184929.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NWLpwLZrMWrIxUuzifz2erdHj4HRC+cjN47EqCkmR6Xr7MiAD0ljmV1R
	LaKLBgQ6QIitjmA4h4SqpiM7lkMkrABBT4nBZyAt/hVy3QjpfnCk5VF8oNmQ9pFQjOKIW4g
	JNQKuRbytaGJ7Tc1Mh4ZmH+Ib/rsY0KU+q4kwakwaI6/hPP5uSUyZzgNKABeByrykOt+vt/
	XNmcQE1YHZ1QN4fROhrXTFxwAKAoNFAzDMSjv70repskmnSgwTWHY9gOb+e1zFxtDBoaqlD
	6oWYj7qnvG0qBzaR5/Y8Tp8nTPf4EIfJBJT0e5adOgYIO9+oKVrbip9hYe9lwvQUPFqlpal
	sKBkeYkH11cp1pjH5YvwtchPOorrnFrNetF9JlK8UJRxOlbJv7vAfmRbOkr+TzBlEgTCoaD
	qfUXbs0G28ADelFX0zNQOaUGzC/e3VAzvMydBGGf0uMiU7NSYqrgve0n1YVkJtdpfaL2ryH
	OlP5feSbW1aKaCnwTyP7QIXOQ3gLQP/iulKa992z4Kx69Z3EnX3V3CMPUvjj6FKMCCqLhq3
	0q5Od+TUpJVdEtfCM/0HWfPSgNbKGSMkeSPTYkv4TufZWkEq45Ro74BK1VaKjm3cks7WafT
	Xl2vC7NWlCK0NazoW1WNdAYMHxmmk2yEl3BMmOQJeumTsmOkkZEc92AKaY9/fX5xW9jUMxu
	ZdH7uXpinevrg0YfDidHv5DMdfqp8GrGgkz5lmjVGA6Ub/vV58xTUqvJd4LXFJZtcBzXczr
	YnAOU4vAZPzgufdwgE9iaGlow/DmQwSu/duUcBtLSKlltYH7uAQhs3yQMyRxEozHr8Hw7E+
	jZIW6sHj2LG5hBMtzYD+DSN/w/dp0Yq6c+PD61t2iYQ3yOMf5Py2k0e01X7zbCN+S9atf9p
	pLRuOlIvauaHGOkHPEFguJdZo9xY0obRUt/LkiXNQbZSjDvQFTqm1Nm/XsWMmeVzdsnjGA3
	GG0VGNiAFwHaIpQKQvpBHbw0wLUtA8sAc7oPfGG/vDfeDxViS6h9jIabOeDRNjg6AYBz0Ak
	jPDPbSxqGZ4MLwgPFj8MJU7bJqVQc8UmviX2mg5Q==
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

The rtnl lock might be locked, preventing ad_cond_set_peer_notif() from
acquiring the lock and updating send_peer_notif. This patch addresses
the issue by using a workqueue. Since updating send_peer_notif does
not require high real-time performance, such delayed updates are entirely
acceptable.

In fact, checking this value and using it in multiple places, all operations
are protected at the same time by rtnl lock, such as
- read send_peer_notif
- send_peer_notif--
- bond_should_notify_peers

By the way, rtnl lock is still required, when accessing bond.params.* for
updating send_peer_notif. In lacp mode, resetting send_peer_notif in
workqueue is safe, simple and effective way.

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
Cc: Jason Xing <kerneljasonxing@gmail.com>
Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
---
v4:
- keep the netdevice notifier order.
v2/3:
- no change
v1:
- This patch is actually version v3, https://patchwork.kernel.org/project/netdevbpf/patch/20251118090305.35558-1-tonghao@bamaicloud.com/
- add a comment why we use the trylock.
- add this patch to series
---
 drivers/net/bonding/bond_3ad.c  |  7 ++--
 drivers/net/bonding/bond_main.c | 57 +++++++++++++++++++++++++--------
 include/net/bonding.h           |  2 ++
 3 files changed, 48 insertions(+), 18 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 1a8de2bf8655..01ae0269a138 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -1008,11 +1008,8 @@ static void ad_cond_set_peer_notif(struct port *port)
 {
 	struct bonding *bond = port->slave->bond;
 
-	if (bond->params.broadcast_neighbor && rtnl_trylock()) {
-		bond->send_peer_notif = bond->params.num_peer_notif *
-			max(1, bond->params.peer_notif_delay);
-		rtnl_unlock();
-	}
+	if (bond->params.broadcast_neighbor)
+		bond_peer_notify_work_rearm(bond, 0);
 }
 
 /**
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 3d56339a8a10..edf6dac8a98f 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1195,6 +1195,35 @@ static bool bond_should_notify_peers(struct bonding *bond)
 	return true;
 }
 
+/* Use this to update send_peer_notif when RTNL may be held in other places. */
+void bond_peer_notify_work_rearm(struct bonding *bond, unsigned long delay)
+{
+	queue_delayed_work(bond->wq, &bond->peer_notify_work, delay);
+}
+
+/* Peer notify update handler. Holds only RTNL */
+static void bond_peer_notify_reset(struct bonding *bond)
+{
+	bond->send_peer_notif = bond->params.num_peer_notif *
+		max(1, bond->params.peer_notif_delay);
+}
+
+static void bond_peer_notify_handler(struct work_struct *work)
+{
+	struct bonding *bond = container_of(work, struct bonding,
+					    peer_notify_work.work);
+
+	if (!rtnl_trylock()) {
+		bond_peer_notify_work_rearm(bond, 1);
+		return;
+	}
+
+	bond_peer_notify_reset(bond);
+
+	rtnl_unlock();
+	return;
+}
+
 /**
  * bond_change_active_slave - change the active slave into the specified one
  * @bond: our bonding struct
@@ -1270,8 +1299,6 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 						      BOND_SLAVE_NOTIFY_NOW);
 
 		if (new_active) {
-			bool should_notify_peers = false;
-
 			bond_set_slave_active_flags(new_active,
 						    BOND_SLAVE_NOTIFY_NOW);
 
@@ -1279,19 +1306,17 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 				bond_do_fail_over_mac(bond, new_active,
 						      old_active);
 
+			call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
+
 			if (netif_running(bond->dev)) {
-				bond->send_peer_notif =
-					bond->params.num_peer_notif *
-					max(1, bond->params.peer_notif_delay);
-				should_notify_peers =
-					bond_should_notify_peers(bond);
-			}
+				bond_peer_notify_reset(bond);
 
-			call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
-			if (should_notify_peers) {
-				bond->send_peer_notif--;
-				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
-							 bond->dev);
+				if (bond_should_notify_peers(bond)) {
+					bond->send_peer_notif--;
+					call_netdevice_notifiers(
+							NETDEV_NOTIFY_PEERS,
+							bond->dev);
+				}
 			}
 		}
 	}
@@ -4213,6 +4238,10 @@ static u32 bond_xmit_hash_xdp(struct bonding *bond, struct xdp_buff *xdp)
 
 void bond_work_init_all(struct bonding *bond)
 {
+	/* ndo_stop, bond_close() will try to flush the work under
+	 * the rtnl lock. The workqueue must not block on rtnl lock
+	 * to avoid deadlock.
+	 */
 	INIT_DELAYED_WORK(&bond->mcast_work,
 			  bond_resend_igmp_join_requests_delayed);
 	INIT_DELAYED_WORK(&bond->alb_work, bond_alb_monitor);
@@ -4220,6 +4249,7 @@ void bond_work_init_all(struct bonding *bond)
 	INIT_DELAYED_WORK(&bond->arp_work, bond_arp_monitor);
 	INIT_DELAYED_WORK(&bond->ad_work, bond_3ad_state_machine_handler);
 	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
+	INIT_DELAYED_WORK(&bond->peer_notify_work, bond_peer_notify_handler);
 }
 
 void bond_work_cancel_all(struct bonding *bond)
@@ -4230,6 +4260,7 @@ void bond_work_cancel_all(struct bonding *bond)
 	cancel_delayed_work_sync(&bond->ad_work);
 	cancel_delayed_work_sync(&bond->mcast_work);
 	cancel_delayed_work_sync(&bond->slave_arr_work);
+	cancel_delayed_work_sync(&bond->peer_notify_work);
 }
 
 static int bond_open(struct net_device *bond_dev)
diff --git a/include/net/bonding.h b/include/net/bonding.h
index 49edc7da0586..63d08056a4a4 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -254,6 +254,7 @@ struct bonding {
 	struct   delayed_work ad_work;
 	struct   delayed_work mcast_work;
 	struct   delayed_work slave_arr_work;
+	struct   delayed_work peer_notify_work;
 #ifdef CONFIG_DEBUG_FS
 	/* debugging support via debugfs */
 	struct	 dentry *debug_dir;
@@ -709,6 +710,7 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 					      int level);
 int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave);
 void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay);
+void bond_peer_notify_work_rearm(struct bonding *bond, unsigned long delay);
 void bond_work_init_all(struct bonding *bond);
 void bond_work_cancel_all(struct bonding *bond);
 
-- 
2.34.1



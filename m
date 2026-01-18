Return-Path: <netdev+bounces-250805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE14D392AA
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 05:22:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1D1A8300F720
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 04:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA81531B131;
	Sun, 18 Jan 2026 04:22:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from bg1.exmail.qq.com (bg1.exmail.qq.com [114.132.62.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92C411DB54C
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 04:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.132.62.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768710122; cv=none; b=Kpy6+FHTZOwkKbtEI8G+34US+LA6K6zVqb7Aiw0OiuT5dOhes7klSGOSM162U1OqhqEyz01CcSlFooRFIgpf9VE+zQGzvUWtb7x4GAY5g2CQmxn+KI7Ab8yfVrZalF1p8FuMka6yEdk/b/doWG0bl4OqEaNnwYBe75haK/7NwM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768710122; c=relaxed/simple;
	bh=W16YtV+KdqmexJRxoDKMn+4XAt3CPc2Igmse487Wl9o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jcAoRfpAI3sAAuuvCWNsWXwQndkdHFFCBsyqexi/nklV2HwTlMS0rhcPrMjDK12QVNTNe1BPjaV5MOcbCf3TKIZe/M+TqGXjE3kRBxfhvoWYsux9DNE9NaYImf5+IwtxkUlQ/p57NLItZbqe093fzorQz//138XQ7AHlVXhxPMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=114.132.62.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz3t1768710095ta9a7c32e
X-QQ-Originating-IP: T2p4mDXCRNRlw/GZFkjwmDnzjyZVr69opgZqVc7VDi8=
Received: from MacBook-Pro-022.xiaojukeji.com ( [183.241.15.52])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 18 Jan 2026 12:21:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4697800451536146156
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
Subject: [PATCH net-next v5 1/4] net: bonding: use workqueue to make sure peer notify updated in lacp mode
Date: Sun, 18 Jan 2026 12:21:11 +0800
Message-Id: <f95accb5db0b10ce3ed2f834fc70f716c9abbb9c.1768709239.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1768709239.git.tonghao@bamaicloud.com>
References: <cover.1768709239.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MjqaYNLY8QZGE04Rtsd4vKbz4pIJE5FTEXJlytDUbtTnQQwq+1YSBwyp
	PMRNcwtZY5ZPgaYT41XEmYfhGoZPWgSMPZW6Gn/rXyCnUPGwBAvJ5PVZhLfB/FAGN0RKAFt
	9uD66zvp5/ly6htHUTk3qc80EWKmHpg381QsvnSY6s+YFodW75XvGbg/4UlVyr2rGnLdQHH
	ReXtYpefrmOFFdZz6+sLPojjvqewp4S+/0IlsMV8oh9Ym3SQxF3QBsUyxNbkavoJc5C4+xq
	PQL9SQjmZCW4EBMKJ58uXQBsRLEoS3SjGCgKMiGYF6rG1Qb+Ib6eUf8xGyU1QYWnO9+9TEr
	MkpIaMNb0vblTWbMlBN25wOEv+UK2zXYJgLdeIwC5XdfyUS3QtPJs8a38+1sorZW9eLT2xx
	3kSB/MQzquN8W+CK7bQWz/xQIjt0AFQ1jEJoO+l7Nmyh1Vep6T1kqWkxFEW9OeY5O76VnMr
	dTrdE31lDX8WJqZmHiLKYmCnnCaAmbZyEbdlZiPw16aQs4G5yh3cE1qib2OfsuqDcGrwTz9
	lBgF4ahazJ4gM9xrQwFlHJWmwIB3noGI4PvT/0pXgoYreW/yW90bIk4JG4YoMaQ8X0M8AdZ
	kxx8g7FB2jeyhD5UwqKCEZm501CZeHEdCvrjzlVzxXjpTFDGJpbVAFMiBTI5+u5rhwuPXUw
	Tkoz7f+WGefELlFWSDoyNOL4c2lqQpH6UJeKEvaDj0sJxyj9+eX8qmogDFVsKlrn3t7rEJS
	2FZIxmU7pRpjolHOUi8JZn1Mlj49zZXK4j68vB7TPKghpLdWjHJ9jDZosMyI0a2OS84dT4+
	vd2oK4trqsHw1TFQkm5obaYVwD6rwyxj9Na3lbcz/ttLUZBsJh4JiA5fFJKlLAXFDrwxskg
	maFWQdDqiOenJMfRqqsPR5FZvJ2rJAcKn+VaWM8202yILNW7e9Z9tu/6Q/D5JaPgm7Jpsto
	nHhU42Bt5rIAGWiBcVemb/X711Y5O1bChFzxhIy8+XBrOIbaDCZ4pKoIh+MFK56b6L9/jtC
	tH299hijpkU30z3PAtYtb6nbLAl3vGgiiOslEZMwhj1t1Y/FR5
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

Additionally, this patch introduces bond_peer_notify_may_events(), which
is used to check whether an event should be sent. This function will be
used in both patch 1 and 2.

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
v5:
- introduce the common bond_peer_notify_may_events used in patch 1 and 2.
v4:
- keep the netdevice notifier order.
v2/3:
- no change
v1:
- This patch is actually version v3, https://patchwork.kernel.org/project/netdevbpf/patch/20251118090305.35558-1-tonghao@bamaicloud.com/
- add a comment why we use the trylock.
- add this patch to series
---
 drivers/net/bonding/bond_3ad.c  |  7 +---
 drivers/net/bonding/bond_main.c | 66 ++++++++++++++++++++++++++-------
 include/net/bonding.h           |  2 +
 3 files changed, 56 insertions(+), 19 deletions(-)

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
index 3d56339a8a10..353b0c8a0ca7 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1195,6 +1195,48 @@ static bool bond_should_notify_peers(struct bonding *bond)
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
+}
+
+/* Peer notify events post. Holds only RTNL */
+static void bond_peer_notify_may_events(struct bonding *bond, bool force)
+{
+	bool notified = false;
+
+	if (bond_should_notify_peers(bond)) {
+		notified = true;
+		call_netdevice_notifiers(NETDEV_NOTIFY_PEERS, bond->dev);
+	}
+
+	if (notified || force)
+		bond->send_peer_notif--;
+}
+
 /**
  * bond_change_active_slave - change the active slave into the specified one
  * @bond: our bonding struct
@@ -1270,8 +1312,6 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 						      BOND_SLAVE_NOTIFY_NOW);
 
 		if (new_active) {
-			bool should_notify_peers = false;
-
 			bond_set_slave_active_flags(new_active,
 						    BOND_SLAVE_NOTIFY_NOW);
 
@@ -1279,19 +1319,11 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 				bond_do_fail_over_mac(bond, new_active,
 						      old_active);
 
-			if (netif_running(bond->dev)) {
-				bond->send_peer_notif =
-					bond->params.num_peer_notif *
-					max(1, bond->params.peer_notif_delay);
-				should_notify_peers =
-					bond_should_notify_peers(bond);
-			}
-
 			call_netdevice_notifiers(NETDEV_BONDING_FAILOVER, bond->dev);
-			if (should_notify_peers) {
-				bond->send_peer_notif--;
-				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
-							 bond->dev);
+
+			if (netif_running(bond->dev)) {
+				bond_peer_notify_reset(bond);
+				bond_peer_notify_may_events(bond, false);
 			}
 		}
 	}
@@ -4213,6 +4245,10 @@ static u32 bond_xmit_hash_xdp(struct bonding *bond, struct xdp_buff *xdp)
 
 void bond_work_init_all(struct bonding *bond)
 {
+	/* ndo_stop, bond_close() will try to flush the work under
+	 * the rtnl lock. The workqueue must not block on rtnl lock
+	 * to avoid deadlock.
+	 */
 	INIT_DELAYED_WORK(&bond->mcast_work,
 			  bond_resend_igmp_join_requests_delayed);
 	INIT_DELAYED_WORK(&bond->alb_work, bond_alb_monitor);
@@ -4220,6 +4256,7 @@ void bond_work_init_all(struct bonding *bond)
 	INIT_DELAYED_WORK(&bond->arp_work, bond_arp_monitor);
 	INIT_DELAYED_WORK(&bond->ad_work, bond_3ad_state_machine_handler);
 	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
+	INIT_DELAYED_WORK(&bond->peer_notify_work, bond_peer_notify_handler);
 }
 
 void bond_work_cancel_all(struct bonding *bond)
@@ -4230,6 +4267,7 @@ void bond_work_cancel_all(struct bonding *bond)
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



Return-Path: <netdev+bounces-242770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A837EC94C2B
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 08:49:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A7264E196C
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 07:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 607F823E356;
	Sun, 30 Nov 2025 07:49:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAA223C39A
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 07:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764488965; cv=none; b=p6U447+sc2W3o1py6UjIlHQ2f2hIKjzyY5p8htVnTxGvwcYVNFjnxuy7OlNSZhwtsuY1ZGNAPasoC+i86EEkm9QDvmp2NYq1ycBIEVGIUG1IlCZjEiNTGp+uio2p/lON8Lw3E4urXBllp6HMkrXuBl7TC/YhZ3CFO7fVgu4Cjzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764488965; c=relaxed/simple;
	bh=8vEsK/XbZ2MJRpQuHS4XQXwzf5SUGVIRFtaOkxgT2LY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XIKuc7pZWiUePhEEQ0I8pGQCIKg4d611E0/tEVoMu6AVcpw8ppL8yGtuHpLCcz3oGDbi9bo3gmD4+sENWLatmY49ATokYdSsoOLCI9RLleq9LA93vFVBCFqi5D8+52omYKZtqUvQ1EqYSoHr3sJDFPlVbX3Zi65iKtRwHYTz1mA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz20t1764488934tec0ee2c9
X-QQ-Originating-IP: LNOty+hlswd9Q74lexwp68gzV7ECCaMLDg8VF0aHkK8=
Received: from MacBook-Pro-022.xiaojukeji.com ( [183.241.14.219])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 30 Nov 2025 15:48:53 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6046624825331481328
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
Subject: [PATCH net-next v3 1/4] net: bonding: use workqueue to make sure peer notify updated in lacp mode
Date: Sun, 30 Nov 2025 15:48:43 +0800
Message-Id: <20251130074846.36787-2-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251130074846.36787-1-tonghao@bamaicloud.com>
References: <20251130074846.36787-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: MOfwHzgDpc8ILM8KD/PYw+xt/RluraSRUS/7skYKt41xT2kqLnyeaS+h
	mKtan85KpXbhBBYomPFUtlXnP7qMw7qhsDDKD08+Tj/bd53mnuOXhRGYmyZCgXm4N3A9Fhk
	IYkdUbAKxMQgtdJP9dh7gpwW+R/8KjPZ0w5yWYUUjkMO4HGcdaqtc8hsjwfUHk9mHc9JNja
	XjMNp8wejw3HDydwPrnZ8r0XLv+2r4stjx4Ei1Mau/otRlNLUgLis9nrsXa5YfzaqtyTe6O
	sPStu38x6owAcg6ZL5UU5TLjWHzVbRNKmozv5vzg0qPmsIGa1F2uu3FlD+F55PlDzk549lG
	g+5gNyxFkUh+KQ3vErrlxrzkJdCq8AETsA9Y58g4V+F3kkYE8To0GjIlnZKNoTlhUP8LEai
	zeXF2ueMZa660YhzzeHVY2llRTlmjGnmKmTPT9bHTPF5BCELLe7nCy38mo3eAxdg8Zg+CN7
	q6aZH6WL6yufHbQtVigQqK/WbieRrLGWfee3Ld6jnmksUSZPnb8umVK4dN3IRD0rMCs2oOy
	IEUoQgkNh9P4F3vyPNXS8XoJmPFo2HtgFJJ/wRcRzvZ9bvai4HhRdamdBpO534c5Px58Six
	twJKbYT+Us8HN+V1K1EbAhP+tvcx1Anog/hhENbpArguFcl3s/C2HzJ1UmVvavzkNrPRFNm
	QlCgsWtN1CKBSsjrJwM77ZZ4O2hTjHMoXIqy8Jaa2yQsvXf8r++4lP5NPgR1C9JeqFXuTKv
	5lAHXOBG0ZFlj5Z4+6lZpws/lvMRdGo+43PVLOWAuiZe5JT3dClOh4HyOazOtVPn2+Y50zW
	lpBAi5dxURSR3471Bk4MclhppXBf+QqSMk6U5sjtj3LQo6rm/00Bk5D/RzK0g2jCZinygJy
	tbaOpzx5fpgFzQHtKoXhxJoqiKnLk/GWEtp3772bj9Lhhbt1j4e4R8Z5145LHVR7XFaewuI
	jwNRO8tNvjYW0Ydy1OC7ZBcp3DRMiAXjeN7kh1ERF3wvvL6bPThNMP6wJvcWvjmr5V3CmSh
	dtwxakUIdYvRrYvui0dKS/jXKZJBMsDzkEV/Qrjw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
v1:
- This patch is actually version v3, https://patchwork.kernel.org/project/netdevbpf/patch/20251118090305.35558-1-tonghao@bamaicloud.com/
- add a comment why we use the trylock.
- add this patch to series
---
 drivers/net/bonding/bond_3ad.c  |  7 ++---
 drivers/net/bonding/bond_main.c | 55 ++++++++++++++++++++++++++-------
 include/net/bonding.h           |  2 ++
 3 files changed, 47 insertions(+), 17 deletions(-)

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
index 3d56339a8a10..811ced7680c1 100644
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
 
@@ -1280,19 +1307,17 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
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
+					bond->send_peer_notif--;
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
 
@@ -4213,6 +4238,10 @@ static u32 bond_xmit_hash_xdp(struct bonding *bond, struct xdp_buff *xdp)
 
 void bond_work_init_all(struct bonding *bond)
 {
+	/* .ndo_stop(), bond_close() will try to flush the work under
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



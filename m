Return-Path: <netdev+bounces-239442-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 21306C68696
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:03:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 99D872A5C4
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D730A27146A;
	Tue, 18 Nov 2025 09:03:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E4535CBA5
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:03:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456607; cv=none; b=HP7xnGrj11UNT5OMbigpohiLZYnyou+UBAa7TAgBB2o+Ueh+Cv2m3TMO2zBC2W75JfVFD5/1UaBLd9K9LJwyYdCr8Gk/c7myW8gEw5+HGpC+vUJNvJ0NitVxvpyjGXnPNajpj0pswiM8iREG57c/G3NFwNSd9X+vRdJjPK/XF5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456607; c=relaxed/simple;
	bh=Xeuwdxvy4ozefCeNQK1LFYJySntI8B57Cf7rRcWsomE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R9KvDt4X++36gAJrdjYLr2PF4X+U7sE3fQ38fl12lE2aXjIgs6BAFWEAzEahx8hwaoOUk/b989JM5CiCl72fwdPLCfY7FHvoYngba4CwhOmgLaLrdHCxdsTp66rxdCXXkVZ88oqslmCMmS7T+y9l31pmIbxzr2dydUNcDiNUrDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz8t1763456596ta1a0ca12
X-QQ-Originating-IP: bfw1uZ1ORjkw3inHxvXG85qNd5QEdAfm2Wf12RH0e9o=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Nov 2025 17:03:14 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11688511292222874173
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
Subject: [PATCH net-next v2] net: bonding: use workqueue to make sure peer notify updated in lacp mode
Date: Tue, 18 Nov 2025 17:03:05 +0800
Message-Id: <20251118090305.35558-1-tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: MShfLn39PbN2WZzgTdjTL8k3Eyb8IHm2U4diKhLohSKf0Uwkk56slEhE
	h4wMvRa0ryOec6ibvpGLwcxTuSKtj4lD6OZErEjeqLEZiNF0y55hv5nlp7+GY6X1dbJ4d1b
	HcZE6UOmJXOsIIiye8IDg/FS4+sQ8RYK6LvzfkwJwnEo0NfCUBCvL8iNjEZSjOKjATxipQz
	eBmg8cCgIMGZftWhRgX8rjewEZTt5BjvbYQKnoxGJ83KO0XYOzKeU521IhoTz7OChJMRSjW
	6/szhBRSJuRVfDklUWBl8EVXK1y6VPdDrbUqkToy6j2zJJXK1WnCaFJORLq3dklLZfNXRGD
	BkLDozQb+mHlM6IFuonOKxlDcC7E1C3K8lw3qp6TBOWfatajyApGsbN6VSezXFsqq8ddDiq
	lcYl2OS1vynPVxoq0Fl7caKYe5YSeiP1gEGBl1cl9TZq1w8GJVZbhIh+ChZ3wjlUWKIvjJN
	mvq3/kvo/n5qflGyoUTCAsEGFmyq7EgO6GY4S7YMTM8Pus+hjm6TNtnrYsUNv6aqqqRejTw
	WRQhvRtCCgVVHGAQqIdnIpXWSuxuyM3/hMFOBZobmnOQ51gRQh280QskxXSHaklGViQ5Gqc
	Yt5uF3H5x+nMrdVVJ7iNvBJf9/Nffm0I/mnIvaVUE3OJmWZPSIDF8U+jqwDPUL5913Ld7Gk
	/url8xBrnqB3stdRqe9b37sJ5qSs9N6KVjb5wrlSnxJXU13J64BOchtXG+jOicz5d5QqX32
	Ns6TZE7qq7YlFPg5kbrJFs6Km+ziqvm5O08Lt15haS5DUR90TQmoHVcg9EocCmKX3SGHzmM
	7Ttsaksu+Yw8rGsWLAlquuorfe05p3aX0Oyd1glK4L2SpVJYwb+/L/6zj0PVNh8431h5a7/
	/h1gTETCd1rWp9oYijCg08b4qAqwy7dv1jgphq55/0nlbGyE8Icy+t7jbqhCY/VGjiBlN5g
	N7RExCQkJ5CAYsU8qH65LCuUk9vrMpI0hxRzPOA3mVzcfm2lzkK0mlLtxOkAnvYrhBesRhQ
	XOCIIa9g==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
X-QQ-RECHKSPAM: 0

The rtnl lock might be locked, preventing ad_cond_set_peer_notif() from
acquiring the lock and updating send_peer_notif. This patch addresses
the issue by using a workqueue. Since updating send_peer_notif does
not require high real-time performance, such delayed updates are entirely
acceptable.

In fact, checking send_peer_notif value and using it in multiple places,
all operations are protected at the same time by rtnl lock, such as
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
Suggested-by: Hangbin Liu <liuhangbin@gmail.com>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
---
v1:
https://patchwork.kernel.org/project/netdevbpf/patch/20251021052249.47250-1-tonghao@bamaicloud.com/
v2:
- add more commit message
- the origin patch, which using atomic
- https://patchwork.kernel.org/project/netdevbpf/patch/20251110091337.43517-1-tonghao@bamaicloud.com/
---
 drivers/net/bonding/bond_3ad.c  |  7 ++---
 drivers/net/bonding/bond_main.c | 52 +++++++++++++++++++++++++--------
 include/net/bonding.h           |  2 ++
 3 files changed, 44 insertions(+), 17 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 49717b7b82a2..d2b324200604 100644
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
+		bond_peer_notify_work_rearm(bond, 0);
 }
 
 /**
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 3d56339a8a10..b7370c918978 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1195,6 +1195,36 @@ static bool bond_should_notify_peers(struct bonding *bond)
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
+	if (!rtnl_trylock())
+		goto rearm;
+
+	bond_peer_notify_reset(bond);
+
+	rtnl_unlock();
+	return;
+
+rearm:
+	bond_peer_notify_work_rearm(bond, 1);
+}
+
 /**
  * bond_change_active_slave - change the active slave into the specified one
  * @bond: our bonding struct
@@ -1270,8 +1300,6 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
 						      BOND_SLAVE_NOTIFY_NOW);
 
 		if (new_active) {
-			bool should_notify_peers = false;
-
 			bond_set_slave_active_flags(new_active,
 						    BOND_SLAVE_NOTIFY_NOW);
 
@@ -1280,19 +1308,17 @@ void bond_change_active_slave(struct bonding *bond, struct slave *new_active)
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
 
@@ -4220,6 +4246,7 @@ void bond_work_init_all(struct bonding *bond)
 	INIT_DELAYED_WORK(&bond->arp_work, bond_arp_monitor);
 	INIT_DELAYED_WORK(&bond->ad_work, bond_3ad_state_machine_handler);
 	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
+	INIT_DELAYED_WORK(&bond->peer_notify_work, bond_peer_notify_handler);
 }
 
 void bond_work_cancel_all(struct bonding *bond)
@@ -4230,6 +4257,7 @@ void bond_work_cancel_all(struct bonding *bond)
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



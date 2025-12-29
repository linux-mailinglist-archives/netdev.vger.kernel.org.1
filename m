Return-Path: <netdev+bounces-246224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CF9CE652B
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 10:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4EB923000DC2
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 09:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73AB8284883;
	Mon, 29 Dec 2025 09:53:02 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BEF221F12
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 09:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767001982; cv=none; b=qFBIPCcVExKUF1PSfgyN35F3lR2DftiB+IPa2fA/u4GTP2FsEAFTlrYM1l/EnToB8iuFUrBh5S1cTiG9L7tywFu+81LNBbubwVLfuo/ZKEYqh4sT7zr8pfifqjy3JPKwhDy0Rjmfex958B9vsUX4Ue7Q0S+gHM5+smdnFrJwKbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767001982; c=relaxed/simple;
	bh=dfjrraVZF+UGu+oC9KCnFMQUqa1ETjxAIK2WpQoVr2k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=boPuZ3ZpP9qxUkZVZKLbAx3+TMlnIEJ2FLiTU5Id9JbNmja0U5OJKbW0V6tzOOhD+exie3a3XcW1idabv5XGpSPY0z5sKVSCwfe0XsgrC8m0/fOOuFU76oj7hPAkIiWSFQ28XmQvMnTENaLJDLWfs2YOaRelUDgVt0OO+XGpf4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz1t1767001964t8dd48c06
X-QQ-Originating-IP: BnDnMs5Gi9Xo5d3u9it0ov/xPg+pjkjPnM7MPovDeAY=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Dec 2025 17:52:42 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 2643950768761619577
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
Subject: [PATCH net-next v4 1/4] net: bonding: use workqueue to make sure peer notify updated in lacp mode
Date: Mon, 29 Dec 2025 17:50:15 +0800
Message-Id: <2483768cf621cc845922f8a2a1c8dd4b9401ab99.1767000122.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1767000122.git.tonghao@bamaicloud.com>
References: <cover.1767000122.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Nc4Sv39/e83WoB2ObdJoru8MXG74eA25OQf1qFJ5A0dN/dFonHXp1815
	mStW7qtiBYzG1/AX51GO2eJDCuqJlAYwMOzgy9Ym51YH8oLY8pVLsWIzsEvihSMT4YCxCXy
	VHm6GQfvYDEp8DJ2EPAlSbtIUd7Bkho+UW/FHLp1w9Vh7FVG6LRZXUgrsaQ5358cLcJaSdL
	SSGTx4wKoziYXcf05GwIWzkHUKujuZPTabwCgOf6fk2txCNmz4ObLYLWM9aiu2O2aPu/bSu
	qJLqbq7NHKVb0unooWYOxvLcFl1E6Z4Gw92DP6aUhZ7XcvAJiSr7dDTgwvzQXGePdChnJaG
	tq2lzVxID3x0s/hTgxAbKLpScfneOnKbYFO/pdjE32ZaVK0LFGaFh9RU3pIXzFmVPbPGSB9
	VHpduc6h2JxM8+MGIX73gBcgqI0oxNScvORdx55IjjQqurh2ljfdVtZR7iLWZEj9XO34ubD
	R5HW0OapFMp7/4rlBOVZr/TvoSQNIyBUB7RQSHMLKUSdR2G0TLa0nWgzzDlzHlYVnoVA2S9
	Mrrf3+ZkcPxhJEbllE6feDoplwgpDvj2a8HsjPE7kWloTjd9x+6DBrO6U+kGIlmA/02J/34
	rdCpeqtW+HZDsnjj4usNo2AFjvEr+MPaYgZLKz1czpQ+wQ+EjA2lr252o5Ie0rTVcunil0L
	Cye4v0sIm/XWRkXEY1qIc146g/hfmkTdjngxW20Li/yCuPVHPc19dG395gTgBQ6U2OREymb
	eU4HBFdjGZ0xPKwVkf990yGeO5OcDi0ytT1ke6jvbNcRtNwwhhiJi3vcdEAMZidDs1L98NZ
	Hqw/9XdlmDt76JhvGIbgI/xP0uxL0C/v+TGuzFHoEFbWinQOU/2DrSRIFLLJfQkjTSXck/0
	emODm6VXNGd2e8Ki3EApDOiEbJI0XKXNoJoHzMFnkCYT8AXS4pM1wZ074E4OXEqSmKwXYiH
	LbQX+B07mg0HJeOjwy+FgcSpEolkixSjBs8Hg1j+tXphE7dD1DfZDJXtqlmC9vD/w2r5sgD
	jSv/YH1LsS6Gm3oKln+QG+iJSmizU=
X-QQ-XMRINFO: MPJ6Tf5t3I/ylTmHUqvI8+Wpn+Gzalws3A==
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



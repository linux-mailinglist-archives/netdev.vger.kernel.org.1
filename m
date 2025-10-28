Return-Path: <netdev+bounces-233418-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C6C2C12CDC
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 04:46:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 44EBD1AA737F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 03:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A3603597B;
	Tue, 28 Oct 2025 03:46:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ADFD23ABA7
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761623181; cv=none; b=judxJy7A+0bE9zR7NjIqulq4qKIoJa6HCsf+I6IKk6fUNuuxQPn6ROgJJz3+D+nNbbqpS+b1f4yMU5s9404bYE5wPUOoqrtUdibKYOXuFMG8+xQ0ScrBXIld0KwoPpvb86QnjhchmPWF93bYQD7ICpwOFdjuBY81HEE/x4FJMnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761623181; c=relaxed/simple;
	bh=Kieg+KDHvXT6D4Mi9aR42htL17eW8D7KLvbg/KL/yHI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=nmDnyqQq7lSlIRf94MN+6y5Dze0GAGp3DOjNosr/XvGmiRl4CvgipHZZcwaz7Djx4twFMcEOnuo+ObLsC/oY4vb3KQRBudtT3qf5Iow1r7L0VtoTZFickThrBPmCb1hreNSawDYz8xkpEJChBTarfbU6MkB8CSJMVT6Sh+nyeM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz10t1761623159t154560dd
X-QQ-Originating-IP: 8e5nqLj3oD0GvOICa2GgsHE/kmsUU3p0f1GbnIAcKas=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 28 Oct 2025 11:45:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7920514311363021417
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
Subject: [PATCH v2] net: bonding: use atomic instead of rtnl_mutex, to make sure peer notify updated
Date: Tue, 28 Oct 2025 11:45:47 +0800
Message-Id: <20251028034547.78830-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MowohnWo6wX7+CGINs4gkS/dFX+SmNPkQCNKVbcHuktijtQHZTp+pJil
	twzQmMFDZuSzeeuMsgbih3FC3V2WnztJ9Gl/Mwb2gGWwpJvmDwvPQ6u3JO74Dv3a329/dqk
	nQ3/h2skrA+mvOg6iaKvfSBtnxr4JbMcoiV8nE3ggdG2DJniguYE+2nTNysV6SinyXzZfbJ
	7cPglyhB3FFWgMb2nlF/P6twJnUuXdPDcgAwe1wfGYwaVVxaQw63bY0/srLoJvSl16ZvcH/
	605w7wOFBEEDnAu5n3asMrJexuOrJRmAVznF3U9q0f1Ig0HTmauFEtP9Ut84yQv4lWtNhR9
	sBsFX4wXbDubc7SuMpHglqJED4yKly4f48nKllP9RzkNGvd4ZMDCS25P8DlgRbJ/+vfNYOy
	DRt1crEZeQk9fYHM7vYYrcpozVZs8jsRfsf1z1Bi18R7/lmeeUPA5OBYXEYZ+THhM5NihzI
	LwjXWjbAHzyRgeSoeRHlS+BEebw2xkxuFRxcQFRlMew5kY7VN+5++8mpJh2y/s8S2Fek5uv
	o6eIcAnMab7UiqFWVQ8ljwDa5OOMnQF9isTDBNtcc+r4oCGl4DPL6dz8j99l3MzqGUQdh2U
	hWJjZGDg7bvM4dgk9C0cmWdhYM/lHkOqlkV+nmI5hN5rAXvJ6KvTcAt8HjMj0mtJz9VzRCq
	CoSkpxwa5DIuhpVJq3mNfX6E14i4Romr5KcdCEYBlR2HX71fgGhTM1SKRw51hGMwXdmaSPs
	20ziQBfQTKoUejLBdkF7IFaUtgJGrs78bET02L4h2uiOj3wnuRP7DNu2Wag01HPOJx7TyC8
	SrpeOcIbSBBGV3ECtKiGn451B5SsyP/G2NBFppZp/1Upumm2UAWA1osUfwBHLAQ1cEdYLwo
	oWW7VcHpTAZFxqeHEx2J9TR1RjLkqUI1rrH8Bi/hc/wqLhUikLrln45Py9yx+Z0T+KdN045
	NeD09JfGjUR8eie4usF96t8eEq7XWKw0XZDuJj/x+OUkfWWFwJQNCsuK9j4/nZgUEvY2Rx5
	6/qC9QQA==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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
v2:
- refine the codes
- check bond_should_notify_peers again in bond_mii_monitor(), to avoid
  event loss. 
- v1 https://patchwork.kernel.org/project/netdevbpf/patch/20251026095614.48833-1-tonghao@bamaicloud.com/
---
 drivers/net/bonding/bond_3ad.c  |  7 ++---
 drivers/net/bonding/bond_main.c | 46 ++++++++++++++++-----------------
 include/net/bonding.h           |  9 ++++++-
 3 files changed, 32 insertions(+), 30 deletions(-)

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
index 8e592f37c28b..ae90221838d4 100644
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
@@ -2816,16 +2813,15 @@ static void bond_mii_monitor(struct work_struct *work)
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
 
+	atomic_dec_if_positive(&bond->send_peer_notif);
+
 re_arm:
 	if (bond->params.miimon)
 		queue_delayed_work(bond->wq, &bond->mii_work, delay);
@@ -3773,7 +3769,7 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 			return;
 
 		if (should_notify_peers) {
-			bond->send_peer_notif--;
+			atomic_dec(&bond->send_peer_notif);
 			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
 						 bond->dev);
 		}
@@ -4267,6 +4263,8 @@ static int bond_open(struct net_device *bond_dev)
 			queue_delayed_work(bond->wq, &bond->alb_work, 0);
 	}
 
+	atomic_set(&bond->send_peer_notif, 0);
+
 	if (bond->params.miimon)  /* link check interval, in milliseconds. */
 		queue_delayed_work(bond->wq, &bond->mii_work, 0);
 
@@ -4300,7 +4298,7 @@ static int bond_close(struct net_device *bond_dev)
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



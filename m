Return-Path: <netdev+bounces-241734-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B18C87DAB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:39:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2A14D355572
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 02:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B9D530BF70;
	Wed, 26 Nov 2025 02:39:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6FC530AD05
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 02:39:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764124777; cv=none; b=AjHznIKGSPL0ds6fo2CrjVg6AWAijEmfbJwDhPSFyqg2ddfl19jrP1t6Ry5fKAr89pZioJwny1t3sJTvLi5s72nT6YQXObDu/jzsuOsNeBLwrcHnEzyzxeDlGRE6ZL3WMJDHNgf4K2O2RCXo0oYWS1ojjslD9wiSlMqonEdA8NY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764124777; c=relaxed/simple;
	bh=kSeoiUFDGYzkbZ2AsOIYJyA7FOzPAM58zrTM5nI/7UU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ooZ67Ph5M2VNp3rFOLGE2SqqufMadDDcPxKLkjVqvE23x0PTdif6zSU7pPfliXX1ge03/MTQKy6ud73gMuAkMHNYuzPC/zPVbVkh21Z9LU+bt4wR19zPdDIw6j7teEIuv8FsQLCV8xs0sEHDnjIa40zZIK01yWtZl0WEQNHZ22w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz1t1764124760tae4a3e89
X-QQ-Originating-IP: RjH1F8MnjG7kD38p5+xaNbRixA3+d1QQS6YzchigsMc=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Nov 2025 10:39:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11687169672556170676
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
Subject: [PATCH net-next v2 2/5] net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block
Date: Wed, 26 Nov 2025 10:38:26 +0800
Message-Id: <20251126023829.44946-3-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20251126023829.44946-1-tonghao@bamaicloud.com>
References: <20251126023829.44946-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NMKjA2Hc7A4+B9IJ8tv0FrcUcr2p3YXSH3xgYrlsTlRL/1Vb6dTL5GYJ
	DxfG4UBDtfrVeW5pBzAnhWWoubnjCzRiM/PX7SojvulI0NrZAkzy7j10nGvNUT7WmJXkmkz
	PKxvzzvRBCjNDe7qy1r1Q1AX+kS1yc5XYtkaOfdke9Cbk/DCN6x7/stDcnck6q3w09zjpdn
	2491qbC+EambDq+43r99HIjU9TeODEYgsEJgvOXKd+B8U9mnSzj/4e1ac+6jHkcglRE2HKa
	ioPz+xNq+KK1Ovkq6Iz7e8bjkIi+jidvztQDGyVsX25k8Ri9cE4Cr6IcPup9m5JX7DZhf2M
	d5LLuABtY4MbUvwrvRTOCWBRK6wRKroduBk7eJReUIJiGewlAkEJCuH1J7HW9/wdtZC4n+N
	4EBAV9+/pdzGD44VlQylyvmqxFXD+yyhqd81Nsgr8pEGT+gOstWjfUqxwU0IdBchPoTeo6g
	CZoviB5Y2gYQonkw6vQIZyyMlClBgtISdLq0LfxXBhTWZBa8UIMF7rdPdGHZWdSc/WNuUk4
	5B1kBus3NfWc9zonaSorDaxYoJ6KC0tIufX7Vl8JnHVSADKbAORikAJtFwN+yLLAqjRkPiJ
	vXAeSWVHjmYyT7Jd/N5VGmLD4b57v+M/PkgAtPkicavn/n7YKNvc8gYLGsCoHqGkXUjKHcl
	N13Yb7aaXPBYi6TZGzdk4GzizlwYvh9OOBULNVaVmmZPrAJqktY6quWO9G3phRHs/FrhBbP
	KtBfPRclVR0wgr9f4wOyJdtklfOjd0QmL1pdmJgmyAo3y/Z94u1L+ZBl17ui7S0eVbyQrTq
	Y6MS5evEbh0meTkH15H88ivXxiP9PBvfp1rBmyn4uinv7GJ4YdT0KFmaAxZj7JXGkU/XL4s
	i++5KkqElJTk+V0XikoZNW948KTMfQ65MrWW1fMj5suxkICmHvbcWSdRwH6Oqx5znpoe/Uu
	9okmDyTuM4m4e3t4UHea91GdZGyh6BbcV+cYEWKO8NFbPZBjcRkp6zTuKcVwR9IjblvzAEo
	Ae7mDy4m+GKueJPtQ1tQI/dE3lMn6/F1RBl1MLvy1F8iUffaB56L906Of3u3UUfgm7FmCvj
	g==
X-QQ-XMRINFO: NS+P29fieYNw95Bth2bWPxk=
X-QQ-RECHKSPAM: 0

This patch trys to fix the possible peer notify event loss.

In bond_mii_monitor()/bond_activebackup_arp_mon(), when we hold the rtnl lock:
- check send_peer_notif again to avoid unconditionally reducing this value.
- send_peer_notif may have been reset. Therefore, it is necessary to check
  whether to send peer notify via bond_should_notify_peers() to avoid the
  loss of notification events.

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
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
---
v1:
- splitted from: https://patchwork.kernel.org/project/netdevbpf/patch/20251118090431.35654-1-tonghao@bamaicloud.com/
- this patch only move the bond_should_notify_peers to rtnl lock.
- add this patch to series
---
 drivers/net/bonding/bond_main.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 811ced7680c1..1b16c4cd90e0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2809,11 +2809,10 @@ static void bond_mii_monitor(struct work_struct *work)
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
+	bool commit;
 
 	delay = msecs_to_jiffies(bond->params.miimon);
 
@@ -2822,7 +2821,6 @@ static void bond_mii_monitor(struct work_struct *work)
 
 	rcu_read_lock();
 
-	should_notify_peers = bond_should_notify_peers(bond);
 	commit = !!bond_miimon_inspect(bond);
 
 	rcu_read_unlock();
@@ -2843,10 +2841,10 @@ static void bond_mii_monitor(struct work_struct *work)
 		}
 
 		if (bond->send_peer_notif) {
-			bond->send_peer_notif--;
-			if (should_notify_peers)
+			if (bond_should_notify_peers(bond))
 				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
 							 bond->dev);
+			bond->send_peer_notif--;
 		}
 
 		rtnl_unlock();	/* might sleep, hold no other locks */
@@ -3758,7 +3756,6 @@ static bool bond_ab_arp_probe(struct bonding *bond)
 
 static void bond_activebackup_arp_mon(struct bonding *bond)
 {
-	bool should_notify_peers = false;
 	bool should_notify_rtnl = false;
 	int delta_in_ticks;
 
@@ -3769,15 +3766,12 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 
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
 
@@ -3794,14 +3788,15 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 	if (bond->params.arp_interval)
 		queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
 
-	if (should_notify_peers || should_notify_rtnl) {
+	if (bond->send_peer_notif || should_notify_rtnl) {
 		if (!rtnl_trylock())
 			return;
 
-		if (should_notify_peers) {
+		if (bond->send_peer_notif) {
+			if (bond_should_notify_peers(bond))
+				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
+							 bond->dev);
 			bond->send_peer_notif--;
-			call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
-						 bond->dev);
 		}
 		if (should_notify_rtnl) {
 			bond_slave_state_notify(bond);
-- 
2.34.1



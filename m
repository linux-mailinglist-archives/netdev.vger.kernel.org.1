Return-Path: <netdev+bounces-239443-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id C6CA7C686AF
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 10:05:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id AF34C4E2389
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 09:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE33287243;
	Tue, 18 Nov 2025 09:04:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C535E23F429
	for <netdev@vger.kernel.org>; Tue, 18 Nov 2025 09:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763456689; cv=none; b=Lt2tY9xnJCNO+KHckYX3b9XL2wxXoH8cAZhQHjA5ojC59h7W1fcJalNb4COlFM8AIjDVZsq6rr5YnM5GzJib7cBmt5JPVtJ7O6hpQVht7NfEmCG+ETZLjUuoRyz+FWPVDm20rpvvP4ZByRaXH1SSSZVPAky2GnsaQoDsvjzMCRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763456689; c=relaxed/simple;
	bh=jWVnSsJjEVBomPepEWJzEivM0/r/KsnMYqZ3/85tUBE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E/7j3SlaJkp9Z8QR0+04RNJ69uqqWU9R4V5cerQezaD3H1pgFPH/GYX8BUxelse7p6bXD074L6m0bC8NG2RRtRJoJUqUSFt+fk9ExTcQsw08QDFXExabMYoVaBQMUIuHhRjJyUSRD3R5XnwHxDisBKuanLaW+DamLMTnCCe+gk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz7t1763456675tdbc3a96a
X-QQ-Originating-IP: FT8O7Ez7u86708GH/IhNXVeCRB1lUr9SUxHNKFDAnlI=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 18 Nov 2025 17:04:33 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8494190856986743115
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
Subject: [PATCH net-next v1] net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block
Date: Tue, 18 Nov 2025 17:04:31 +0800
Message-Id: <20251118090431.35654-1-tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: OT1af/FwY+++wA/SU5RYmc0kGWTS+8Vlgkdv2VZZ1i7mrY7yTy5amoaN
	Cw/uh+KjSeIfWfK0sChF3Y7dQs92IDrGbtRrfqjiF39ZlPdAvJ8CuAG7kH9N166cBd/yPyx
	YZpcWomgzHGcRglLJmu7CDZqNwpqkc/S2c2/vOsJowve72k6/VXJHHcV6FJdobirTxqDQiy
	n1bLbaoqA79MVeQHN52gAkaNjyq1T23xroon2OVaKu6CwS+n7pGi6I6o9VoEC3ZHWAINdgF
	jnp19URXgO1NfFh3EFhPN6I5r7FkXAJF8vMB5E3G4hiuOY1Z/eocZVtdzRV+q+UgHrZGk65
	eKo3+zhZZzSqZ1PhycrnY7njq92yZVT+GPzqejfWyuC8snMkZEATh/PHGX9Lfg48sKs3JZh
	KGHitsmFZIeAyJx5jYvIhtBge3O0KdJi5HocMDsqV/c4oSiSzuNFBsHV0c3/G+0XMx/1Vjz
	4mroxGBBUHfBizieokneKXMFCV7MsqT3zPGHSztfwb79p4b31hYzD1emC2+P/OlOXF6FDyr
	2trfR4yowMk16t69cT5GiKCYaYarwWQ8mI9y/IpG4SqwkW6ml5mXnNGIva/ZMZCIjEJrnf6
	41YC099/NVOvERhElwc7LWQAknN1NRuwSGTM5doKw0+fnMSMMD2W/ZeWHqMv+9ZJevoe21C
	LgGOuidSHBYxd0Tbnh/NCr8aIAQpv93b4PbQOvfYMp0rDv0G0yapN0IV4kVnrqo9lcrE/cG
	q/QFJ7RKc3DyDEAdnFpSG1tndB+lhPEplgvL66wSr19zxfPNl9Jw/jyfjGmbrgsKhYMRkui
	HjpFIUgDBgk+sOOUfPCS4Nao7X0C8HCDuG9WdP4ww3OGgiyl0TdAG4UCkIICcuX3VyIvbfG
	nYjMHWA0t2DMBUKqCZK3/DbzhDS3Qt85j9HyXz+1ENXHDLKFV8N0LDq8xei4ZU3mIztYLNJ
	EbQDqVGtytYW8sr/S7n3voAYucp8Zl3jaWgBkquzHE9PcPzKh6zEnXTeHcNFKowBC5Mhmsa
	PkNVDVAXr3iiDnyP43PtcUV6fKT9C4VUXOs4TL6dzVG5eZ9YvpMWzZ2qjgCyE=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

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
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
---
 drivers/net/bonding/bond_main.c | 35 ++++++++++++++-------------------
 1 file changed, 15 insertions(+), 20 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index b7370c918978..6f0fa78fa3f3 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -2810,11 +2810,10 @@ static void bond_mii_monitor(struct work_struct *work)
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
 
@@ -2823,7 +2822,6 @@ static void bond_mii_monitor(struct work_struct *work)
 
 	rcu_read_lock();
 
-	should_notify_peers = bond_should_notify_peers(bond);
 	commit = !!bond_miimon_inspect(bond);
 
 	rcu_read_unlock();
@@ -2844,10 +2842,10 @@ static void bond_mii_monitor(struct work_struct *work)
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
@@ -3759,8 +3757,7 @@ static bool bond_ab_arp_probe(struct bonding *bond)
 
 static void bond_activebackup_arp_mon(struct bonding *bond)
 {
-	bool should_notify_peers = false;
-	bool should_notify_rtnl = false;
+	bool should_notify_rtnl;
 	int delta_in_ticks;
 
 	delta_in_ticks = msecs_to_jiffies(bond->params.arp_interval);
@@ -3770,15 +3767,12 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 
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
 
@@ -3791,18 +3785,15 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 	should_notify_rtnl = bond_ab_arp_probe(bond);
 	rcu_read_unlock();
 
-re_arm:
-	if (bond->params.arp_interval)
-		queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
-
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
@@ -3811,6 +3802,10 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 
 		rtnl_unlock();
 	}
+
+re_arm:
+	if (bond->params.arp_interval)
+		queue_delayed_work(bond->wq, &bond->arp_work, delta_in_ticks);
 }
 
 static void bond_arp_monitor(struct work_struct *work)
-- 
2.34.1



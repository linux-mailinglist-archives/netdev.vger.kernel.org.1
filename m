Return-Path: <netdev+bounces-248862-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 92149D105E0
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 03:43:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A98A23026847
	for <lists+netdev@lfdr.de>; Mon, 12 Jan 2026 02:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8A02F5319;
	Mon, 12 Jan 2026 02:43:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgjp3.qq.com (smtpbgjp3.qq.com [54.92.39.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82C81E98FF
	for <netdev@vger.kernel.org>; Mon, 12 Jan 2026 02:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.92.39.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768185789; cv=none; b=b6uxA/+kaf/aVx+LUVSXeHnCpWn1tXHS5APA8eZVaEga94WvR9OY/a4bMT3wzukG+KZXr7zeCtDS0Sb3LnKRxmyntSyzJ+0Vsy9V/XA5I3+l9v2fsXNjs80jHXcrsderxjy18CxQCZiZU9KXIFy+B0Ngx4Gsw7TvLmJmQ4SFK/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768185789; c=relaxed/simple;
	bh=0nxX+Ada4xYpvIdhVZQKdcuOPmLRVCKk8oK5wjxqEpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ayTcBYZFkB64fqaXOq6ob6mjQ5WgLnp+J4k1OVv3wa6b91XemXntQEJMwfjsgsry+inHhYj6D4qgLb74lZE38J0cxaFSYXEwFERv8O6YqU5PVIFUqQTxUzDw/h6TClZkTbgE5iopZXlcDLGzsqyz/8476U4RnBWri8gCKmMrvq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.92.39.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz13t1768185774t2291be22
X-QQ-Originating-IP: 8Hi9e3aAsY3reVkKjIp66hs5SE4rp4eZwF0a0kN2EEo=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 12 Jan 2026 10:42:52 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 14203754028566432893
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
Subject: [PATCH RESEND net-next v4 2/4] net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block
Date: Mon, 12 Jan 2026 10:40:49 +0800
Message-Id: <27e284c5ae6b08dc990c54ed8fb5b4fbd72960c6.1768184929.git.tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: NhIN2Vt8iz3RoAfS73PQuBO/Tj4DhQNqppF/jveRsSwHQkY5dpKVnTTd
	HhOEZizOEyzXW5zFR80da8HCToj83UCQBEglQNapWU4dEYUSP1FpOk3ngIZaLZDISepDJmB
	tZbqbsLbhoo6i6vmnFrgGY+Mgr4uVB7NGU8P5JQqm60+o97G6P4j7+EYe+5UrIUG+dSwmJJ
	wqIOyVyzD76KFiZRtpAjM4eoad2bfdGZlFwwxrXULxXk+1TiaLwSnchRJ+Y3q6jJVLoto9b
	AI8/y7esoyvAqsqZyq2O72KniwkETtXUj9MxaEQOWfX2EC6NxbiOo3R5oQ7oaV53pAUxZMA
	wN5UKLjt96wgTpnqo3pj64C6fsgkf8uufzacCZoFlTjPQAzClSkf7JgDvucHyBW0WV3s7x6
	FvycLvtzeEUKVSbWRrq87J6QlN+0ymBSgX/i2SIGyuyN2BepGUfEUvUMgkjXS3K4TvkeIvF
	QdjwESorXS6WGHKiHcbUsn0IFqeDHBQ7JaXcZTWFEj4dZz2d6FcNBK/uuZSwVMa7SmSDYNF
	O9HAPhIVuJBuChuMh/xxOO+ZjlbnbP/3Az/sZBybxuFzTOJNktgGrpo08lNHFISqcymGHpw
	SmGIW31QjWqpMNplhxxFyGZnPM6DqIObgC9qsvPzaBWKqbXtA8QZsz36TbRNYNK+Ii0Gvqt
	HUqVCrp1TGprrvdyqhokRxlwLvUtclAZ9oAMU2RDMDtskD77EwM+zYtX/CPwS4eQ4keTgLb
	Y54JODpX4o9VSAM6pdkjPmfgmjDgVqVVU/9rQs5sNVxHBIgpuy+z/L0cMW4C44SHPs2Z7a6
	L0aLb2F2DhIOAB4Xtjsbxzl5eXsg9Lln/MLZTbcapzINfkv38KpK+n3P++8OD68zxs5nrRi
	ghFwTpifmDypRde5zD7hJXM5Fj3h/qZBAlh7HzUN9tXK8OnbvKtQOdP65z9SnD2zf+Fa0uA
	JxZkp30WULsDODb7YlOWiSAxnzK3ptOs/jvoqmCa6HYDd5PTfNVarQMkyLxeHgnQj21/MRY
	fuaq2TiX/XNsp7kvpv9ZbaMc3GEcxI5vSblQ9OUaB884vh+Hbl5lhdmuD/GUaKD4ReUVDOd
	TSj3XB9y3p1
X-QQ-XMRINFO: Nq+8W0+stu50tPAe92KXseR0ZZmBTk3gLg==
X-QQ-RECHKSPAM: 0

This patch tries to avoid the possible peer notify event loss.

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
Reviewed-by: Hangbin Liu <liuhangbin@gmail.com>
---
v2-4:
- no change
v1:
- splitted from: https://patchwork.kernel.org/project/netdevbpf/patch/20251118090431.35654-1-tonghao@bamaicloud.com/
- this patch only move the bond_should_notify_peers to rtnl lock.
- add this patch to series
---
 drivers/net/bonding/bond_main.c | 25 ++++++++++---------------
 1 file changed, 10 insertions(+), 15 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index edf6dac8a98f..8be7f52e847c 100644
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



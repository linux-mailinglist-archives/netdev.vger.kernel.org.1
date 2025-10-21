Return-Path: <netdev+bounces-231085-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DC42BBF4A26
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 07:23:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BF3724E1616
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 05:23:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 446881624DF;
	Tue, 21 Oct 2025 05:23:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F9A48460
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 05:23:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=15.184.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761024207; cv=none; b=i5wGIC+jMaDBWknvBWBwX/PzuBelrkUfqMdAnudJ3FNk3C/RXJiimVr+Xw2LwWNy1YoEBWUXceJPpVCDdv992dXZvHXbtnYcIVmv+dOHfiHgbaVTDcCps9aaivUSLf793puU8VFFKWSxsCZW7dKRVqaM7fRhvsHFmQ3z5cBYMgE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761024207; c=relaxed/simple;
	bh=cMReNKYic3fRU8MEQJfh+UivFvksDWzZt3pgPnr2iZU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=g7RmBoKj3nQfmtDhy7e7kHoNLiNZ5Ua9JZrYYDmGsa79wBysME4NXhNO5o1dgSxHfuYfdHnxGP6i7A/ffR0n7nrITgpnYUFbUX1agENRdkDI3nxNccJxlrUIImS7YF0yWjVIaVGhcxs55vH/isVjwIDtTX5pMyeoqtbQ0UuVeLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=15.184.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz4t1761024188t44100cc8
X-QQ-Originating-IP: wY/o5ZLtmHHI1f1gHfBuQSQ8XrasAHwzxh2dCuU/O+Q=
Received: from localhost.localdomain ( [111.204.182.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 21 Oct 2025 13:23:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5903473549653684005
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
Subject: [PATCH net-next] net: bonding: use workqueue to make sure peer notify updated
Date: Tue, 21 Oct 2025 13:22:49 +0800
Message-Id: <20251021052249.47250-1-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MsL7hwqo9bYsw2x48MdnWGTQPSXoutfFTwiFRnrkIXfbkx7aPTsaOND2
	j4/73ErbqL4OCeVb6loSfMfth1h1/Y9avxdc6WIZnB4Samw0YKYXYd10zMulECCTKNG93m4
	PogYzyr/4pqjPKlxHiUSnXV+gEZJ6VS7lKB+Dk1UscUdMQS0hg6grNcGIULDjIiI9zFV6x2
	dIks2PKv8C5HEjRYGh0UidKT/roxDZp0tW0Lvdubzhe33jOghfXvU2ndMyxKC6TKzNqu0q+
	HawBTuO2p3WSVMwsUlsVQV/SjLEpfTxcbhXjcZDmVpdit5RNVGFZN/ePnzDg80nyTxmdHvk
	QhqvUuW7TYashPAzo0naHpqF6O9EQpSqCCd0+0c6e+vukajnAY/fOaQEYAIUCa21UYzXpE2
	4MBasjTYwVjpQebLKFXZc88ARN3qLVmEhYz1AuHi93xGxAWSr5KLX9UbYTRqEmz5nKJdOB4
	KNSJSTQvmihk9d3LviwRAdESTnw06twOodIivbuhh0Own2VovT8+fmyqnK3wkZla+cr7Yk2
	aZrDF9HJcSv79oMm3Rrv56tI41+0rJ0ETBaKLXybU+kS9amqGhcZ+GA4n0XzoiUVZlEbAMC
	TIkMZh+05lxNW3H3XVlJKLYZI6275DbbV4M0C3e9Hs72ocHzyFOO/97eB20e70BalvQZ74u
	PCf4JzalFtwui7FqERCd55tHM2esv1cT/WMiZiiAymPGzzFFjHX/pePprX2YXG3kQHQed7S
	bH8AKudpF6lidH1eDDZQ2ZoShwZYG5wg2JoHI1b0/GdIJwF51WV+WgyxIR6VvNA8RpzQTOC
	BjHty1VL8skT/TO6q5zMjJV2RkL+hGa6o5T6wpj9JXtm2hDOkMy6/cYzVvoaxAhyRVuJDtI
	DYs+6I8tZfVi1XiHOFkrfXAJUo6UYURZ09ViQhg8QECKkaBGvgOrAAHwJAsUsEq5UQ8qswO
	QXN/AumEHwg4+LbEpA0GwONTJCJ64sFvVSkfCQZYgWq76+ECiiZ5iD0NEIq0HzLVNc2qray
	QmgizaTiJbBAUtP6bg
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
X-QQ-RECHKSPAM: 0

The RTNL might be locked, preventing ad_cond_set_peer_notif from acquiring
the lock and updating send_peer_notif. This patch addresses the issue by
using a workqueue. Since updating send_peer_notif does not require high
real-time performance, such delayed updates are entirely acceptable.

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
 drivers/net/bonding/bond_3ad.c  |  7 ++-----
 drivers/net/bonding/bond_main.c | 27 +++++++++++++++++++++++++++
 include/net/bonding.h           |  2 ++
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index 2fca8e84ab10..1db2e34a351f 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -986,11 +986,8 @@ static void ad_cond_set_peer_notif(struct port *port)
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
index 2d6883296e32..5791c3e39baa 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3990,6 +3990,31 @@ static void bond_arp_monitor(struct work_struct *work)
 		bond_loadbalance_arp_mon(bond);
 }
 
+/* Use this to update send_peer_notif when RTNL may be held in other places. */
+void bond_peer_notify_work_rearm(struct bonding *bond, unsigned long delay)
+{
+	queue_delayed_work(bond->wq, &bond->peer_notify_work, delay);
+}
+
+/* Peer notify update handler. Holds only RTNL */
+static void bond_peer_notify_handler(struct work_struct *work)
+{
+	struct bonding *bond = container_of(work, struct bonding,
+					    peer_notify_work.work);
+
+	if (!rtnl_trylock())
+		goto rearm;
+
+	bond->send_peer_notif = bond->params.num_peer_notif *
+		max(1, bond->params.peer_notif_delay);
+
+	rtnl_unlock();
+	return;
+
+rearm:
+	bond_peer_notify_work_rearm(bond, 1);
+}
+
 /*-------------------------- netdev event handling --------------------------*/
 
 /* Change device name */
@@ -4412,6 +4437,7 @@ void bond_work_init_all(struct bonding *bond)
 	INIT_DELAYED_WORK(&bond->arp_work, bond_arp_monitor);
 	INIT_DELAYED_WORK(&bond->ad_work, bond_3ad_state_machine_handler);
 	INIT_DELAYED_WORK(&bond->slave_arr_work, bond_slave_arr_handler);
+	INIT_DELAYED_WORK(&bond->peer_notify_work, bond_peer_notify_handler);
 }
 
 static void bond_work_cancel_all(struct bonding *bond)
@@ -4422,6 +4448,7 @@ static void bond_work_cancel_all(struct bonding *bond)
 	cancel_delayed_work_sync(&bond->ad_work);
 	cancel_delayed_work_sync(&bond->mcast_work);
 	cancel_delayed_work_sync(&bond->slave_arr_work);
+	cancel_delayed_work_sync(&bond->peer_notify_work);
 }
 
 static int bond_open(struct net_device *bond_dev)
diff --git a/include/net/bonding.h b/include/net/bonding.h
index e06f0d63b2c1..4ce530371416 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -255,6 +255,7 @@ struct bonding {
 	struct   delayed_work ad_work;
 	struct   delayed_work mcast_work;
 	struct   delayed_work slave_arr_work;
+	struct   delayed_work peer_notify_work;
 #ifdef CONFIG_DEBUG_FS
 	/* debugging support via debugfs */
 	struct	 dentry *debug_dir;
@@ -710,6 +711,7 @@ struct bond_vlan_tag *bond_verify_device_path(struct net_device *start_dev,
 					      int level);
 int bond_update_slave_arr(struct bonding *bond, struct slave *skipslave);
 void bond_slave_arr_work_rearm(struct bonding *bond, unsigned long delay);
+void bond_peer_notify_work_rearm(struct bonding *bond, unsigned long delay);
 void bond_work_init_all(struct bonding *bond);
 
 #ifdef CONFIG_PROC_FS
-- 
2.34.1



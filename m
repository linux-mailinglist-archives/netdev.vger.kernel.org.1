Return-Path: <netdev+bounces-242768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08BB4C94C25
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 08:49:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A6FA3A54CC
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 07:49:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D5B123D28C;
	Sun, 30 Nov 2025 07:49:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D05EE224AF1
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 07:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764488962; cv=none; b=NcyIK1QAqve3Q6CM50YgBVPSZbX3+wsgwxA3pdlIVYTSO7qJhIgeC0upSddo6nZRj9xSeBYFfLCEK4G5RlgVashpGhaNc0ln0atstv8cQzzCMbtsprXn0WF0mVPltDHgb8ru2iDja9K4N8xdvmA+pkN1xofuh5e0eWpZVTURLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764488962; c=relaxed/simple;
	bh=kSeoiUFDGYzkbZ2AsOIYJyA7FOzPAM58zrTM5nI/7UU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jw10+qgiFrEVn4U5jPL/I/RbRhjNHS/YXO432NtJU4Mx4A5JmDIZk1j1uNZr2VWxWySPOvL995CXb7A8UYSVKf5ydrGs9YpYPCAh1jHNSUD9JMC6qtzKUsoCko1uoebtgC04oIB/toiY+D2zbK3WSLI0yQIiGDaFuAr9z3YJsjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz20t1764488938tef4d18ec
X-QQ-Originating-IP: 9tJZBBHEo1Grm0DjKUybFKGX2iHqlnsop7fDJIEvj54=
Received: from MacBook-Pro-022.xiaojukeji.com ( [183.241.14.219])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 30 Nov 2025 15:48:56 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5384480754258997514
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
Subject: [PATCH net-next v3 2/4] net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block
Date: Sun, 30 Nov 2025 15:48:44 +0800
Message-Id: <20251130074846.36787-3-tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: NImvdRhE6fHp0IdhJSktB5xT+g8xDw0/yE8k10EkDyRAZsCiwZ0iCGSb
	D9La7zfGqtKpxVdxZnahpuvLTnBraHiqQ9Xfmqes/KygMDuno82AOwreT/QzyAhSXqkaGTU
	xuxAKUtML5kUXgdeb0ziMNyyWCY0c4NIMTh2XOpev7HmpN2ccgMBx1iCRDQajEkPw5bie+c
	5rk861sqNC1teXO20WqIXfsXB3E0PyMnv2JUM9Ut5ItdyID6tGRf2eCH7XnigRd6RmeLqlF
	569FYx29GTd/t8LxqZsVoYU9mjb7Iyqwmk8P2Dihf7WSPjZtbaJm9fl4PXXcPx62I4/6btz
	rEed46DanF1ZDVcc7igVenGpz+remR0EXnkSgR6Zyk07eXBXyL8jqEp0onRroXi3yeWq7xt
	wHTJmqPZXp4E3Z0HRunG2DOmeXEIfDjmcZWvUsK/dGqf0edarkgrfP2dDoTUm3lhZvXHFSZ
	IMJ+CNDiQiCqTXiH1vsiatolYntJv8W1qX0XSWziVOk9/sE66B505EVtxdytMVRZIQRf2GI
	8EB+uEKQSh8f17L9VYit22I6dE9f42qUtT+XAGtDu/x0CMdDPrNiSuZhYdPiU7ZSuFfHBoR
	T72ETnRnGlxyxIx6SwshdYGkpw7NMrBqIlFQjNFdQiHDJHwyZe7iwAdP4NEmHJrhU3JJKbM
	m/Mci069KnEWvo1/YoLl3mMyuX6N7jo5zrGIhBYnKOsC4vQUopF7Rk/f+0SJbsQJYWOUaXM
	37HELTFPYGiOnrGMWWQMyWvXVdR2Lqrgq8dK3a1nqM1vTj674dJtSZFwrIU7w/C41V54kGj
	RfbZQBOWsX1OFMFIsrQ3bgMimXWIwbMbLOuHAoUS3vl9A/x7CQOWualX09ySMAclAdT9aO/
	F8+ItyplZFBZR6Ce3AXCT6P7QFL0fWWHrKCQXPqUCXslaZJNtDcU29GjdeZqsJpnKJfAUgo
	HXwoJviuBcGl5Ko4fbHcrTOzzuTgWADLzboqedSAWaya3zPicwo6hTw8+77nr2GOWASNB0z
	N6qOTgTvl5bCpc7hi9eXUeuGvYaXp0sl5pEMyUayizlNwzc99v
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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



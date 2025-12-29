Return-Path: <netdev+bounces-246225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 25359CE6531
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 10:53:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C15D23006F5D
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 09:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A80092765DC;
	Mon, 29 Dec 2025 09:53:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8503284693
	for <netdev@vger.kernel.org>; Mon, 29 Dec 2025 09:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767001985; cv=none; b=eyALR3X7Yc3QXigFaXSict7ROAqDUiAtkMkxhudSdZg6v8UE79jQXYaweLByJbGu5C7srPd3DrRBuMb10Hi6zRR/CxypbqqgVfpC47mXgPnRYRXC7AIBhlHsDvr7XWfcGsglVPHM721kj63irdik5uW1BMpq/ZTetBJ1x1i05RY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767001985; c=relaxed/simple;
	bh=0nxX+Ada4xYpvIdhVZQKdcuOPmLRVCKk8oK5wjxqEpo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TR6YL6BnbagKNIK14tpXqat6K+cwpcdQgrDN7sch/MfYs9dXbSPrht9BAcI7Rf6C4yIpzO2Y7OZnfKX+3cZRTy2XYBdGVFBuUevVFuY9HNq3eA649hxnmZLcQpfYG0J3tVSq17mNyjMe4+D2bkWiiw4hI6cLM9XX1Po02X+ewnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz1t1767001967t15befcfb
X-QQ-Originating-IP: hfjU6T+O6mYB7RSZX0OGWOjMap7ya8YWv3BxQpHtXvQ=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 29 Dec 2025 17:52:45 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10847979969175321747
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
Subject: [PATCH net-next v4 2/4] net: bonding: move bond_should_notify_peers, e.g. into rtnl lock block
Date: Mon, 29 Dec 2025 17:50:16 +0800
Message-Id: <f90e095be3df4c1649bbb46b5fd8d00cdabe0afe.1767000122.git.tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: MeAFQZezdMSLr/f8Qu8Pig4/N1ZSq6KoxwPxRmkyKJKbv9fHoOWYyOKz
	QE9Psg1oRLBqigAOzbI4nSShmKMKt3JhIattHVaUS7V9ejjUZmR/jgw3W3qR6WqXo2q0jZT
	29D43wGxnY0QvW03AU0kai1zCn6E07y3U3CWfntUq1rpKzZ/hGczldeJ0GA1aTeV/Q3mPKU
	0GoBy6g25JpIgbZVxlWXF7n1PgZO3Cgn1SrSkVvK+n67MIUKh4VnYzGt3uX5y/bXGrfgr9v
	2OWEyZHHDtNZEoQHs3fXXGHiBheIrc7vSvK3RPCTcqr3o5mxhLikM2w6hSmoTkK8r9N9U6S
	mgh4fFFhu95rJpRbe79/De+CI70rrN/FlDnRccH+J5GEoZeo363mLXUMsvhTngEUO2It3wY
	wmsRxomkZmp/aN27sMcu7bWJWPFSzYB58VkXATmmEWjlNfSqeKqLD8CE3W8aUGVC9txSD/i
	759i8jdSfithF4Eo+u3H+LBhg6hfOvZwpsa1u/9+L8salKljHNxY0lub9bHBNoamrACxR6c
	pwU7rThXEGYQrgbKcoP9RWwbF7nr1Tgyc+iPjTkuMAtHYpJPa5e2lhGRKWQS8GHVq+VLbAL
	q22I/FPjp8Jrv5kTO1PSHNWPQSSj2F0v7OR4J6/Z6W8aspqlxNmXhbnyXMzBRKrHQ8VYmDA
	MaDTWtyqBppSVDdMmpnmOFhpVdUxwmkhGFXTNwiH5sfFx2xuBV9AmBP1oBK9o1eJTQ6CYQF
	bEw2uJVylLZN6G7MkvdE/idI8v5xWj8q39o9hMX3kY9ZLFpV5A8QdVdDxAKSb760gXSU8i7
	Gsm43xOaCcekjvSNlpQbkmO6waQagIMWdw82hn09u7Ut6JCrroqVC6Yj+7IIwLGkLjfEwS5
	B651B7ptczwZLtpAXQYfbQzfE0FMIClamecXIs7ybgXUG02xcXzFN2/gS/qJ+m8te8WJ1EL
	QNMsM57wo9uKmuVXlzwEt2drECDPf1NwNgFXY/AAMu2FsirQe923t6b76X3/jDIhkdkxFI5
	Fe4jyRyUJ5zdy5+YpgKKd/LM9qxLT13WffJ4Rzfydg92glrwQR3HRb+AtuY2mpayCp4Yt3Y
	lcqftflpOSN
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



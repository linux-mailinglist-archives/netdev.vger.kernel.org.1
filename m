Return-Path: <netdev+bounces-241736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 816E4C87DAC
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 03:40:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D29C93AF3FB
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 02:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC03530B515;
	Wed, 26 Nov 2025 02:39:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DABA3081AB
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 02:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764124782; cv=none; b=qFn0f/VntmFARiFGXv2DvpAyV+YuuVVZ/+MOJi/eH7PT0hYmtYoDPhMfmNm82zRB2hCCHhhiYy977omI84ROzYxlwx+fL+zHOxQwm103dYO0T1Tw2BPWeAIPjU0jxXrf/BVfU1RkmrKO5T5O+NatxtVGh+kuj/J8zMcXHG8wEqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764124782; c=relaxed/simple;
	bh=zDyTgfxIPkdBTyQUqwcldfvtlQnuhS3qeGcanb9FDc4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HuKuSfcYLtRc43MQPzUmEKk9RnRmeiWCsa1sw8XDy/X6fNN7KMGWDlyzpqnntC0/SUYCgEfpJld+TW0BTvN2VhRKbo2Lg7HgzLUcLdNztEJDfvoph2XhPc1h4McyE+ukuNLqV3uSLGVWBwfGisp7BNQo38DZFYlZnFeB1gA8s1U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpgz1t1764124769t72516d15
X-QQ-Originating-IP: QGjTb0P1gKZuNUBEl8HW+usnk/nODLxXJtA2c2+jTlM=
Received: from localhost.localdomain ( [111.204.182.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 26 Nov 2025 10:39:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16654287111525162691
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
Subject: [PATCH net-next v2 5/5] net: bonding: combine rtnl lock block for arp monitor in activebackup mode
Date: Wed, 26 Nov 2025 10:38:29 +0800
Message-Id: <20251126023829.44946-6-tonghao@bamaicloud.com>
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
X-QQ-XMAILINFO: OeLwzUnLeZjMgbJJjxFEBxZzEb8Pa47fCUTD8KmKiIBolOEVwfidecp4
	b1zhKscqkyB11e1Lwt4irKTwbbeL1erjJIfZXOMwqhM9Y8aZxqID2BiIl2QwMLEvfz4XNUa
	smUoae0KvAT39IR7CcNQzTNk6/hVpbWJdjRrHNwm9hgufVM5X46S8GZPOLjC8Y9Z6qdNsc4
	SIRfJMHm1dcQkZnmiON8y69F+MFS0yHuPP7sWuoa7tXOeHwXpJnW1EC8h2wm8cJj00BIUxw
	GbRZKFchZQIgGsOY0MkbNS6dsbAUwsGxn66foao4xrukyJggzspY96sU2gcXvAtoVMD+Srx
	OC3yEfdPOiG9j6V3W4+4m+CkI5fBvF3ubJ0rCwxYFx0/Lfs5B8V5OhTT8iwLpVWeDRBEOb7
	0kl1zazNcLJYQQ2OvSft4i+xhZdzLtWZgcQ2Dp6LsBSoyY2OEmDRC9gRN4myDESt2OXzJcI
	Yy3SZ/QfamU8B2cfA0JgpbkDdaG85wZoRTotNVBignM4aZGL9yVZRSeVPb2ZE1Y2ap6ACTo
	9i3ZHwUfjV1o3O9gLuA62K4g8klLiN8dJ4CdNN32cXdOHjldJ+xUI51Wn1wj6Ls5HFw9qJw
	fId/Zh3w8iqT+F2k+NwYQk+heDjRLJb5cCxAZxcptWWmM5Vmb7dKx2O9yJedFZzLuDMUM61
	28eHABlC60LSNSZuRKT116NiTUWAaGvODODRLiLmoQAILyVj/X0v8e7um9utkfyX2Cp533v
	vmtgQdYEcceELMEFlQxJfxXH24nh3ewEXiRqJ44IPr5IhqrZGnQ/BOA/DqoDODM07iZf9HZ
	4wL2CGZWbltUl/FfPr3sEis8MK7ckIxuYnNr8aKtTlZEvCUIOdAlTmsT5XgpmDDMRPc4i2U
	yQMdKxd9XGnBenOdj5hULEXt+xyg4eQUI2XygpO9C8FguNRDQi2mpB/ERVsnRe5c+FWkNfx
	+ctsFy5kGuyd7fvpCbKUnLC0TF0cu1w2mPKNWn6++GBvrHvSxuW3W30acwniAdz2cLLiJJv
	fuJuzj4u1PZtKjiUclnrdGkaqjEXY=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
X-QQ-RECHKSPAM: 0

Place all the arp monitor in a common critical section, to avoid requesting
rtnl lock frequently. Note that mii monitor also use the common critical
section. It should be noted that the bond_ab_arp_probe() sending probe arp
may be lost in this cycle, when committing link changed state. It is acceptable.

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
 drivers/net/bonding/bond_main.c | 26 +++++++++-----------------
 1 file changed, 9 insertions(+), 17 deletions(-)

diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index 14396e39b1f0..2cfaac3edde0 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -3757,7 +3757,7 @@ static bool bond_ab_arp_probe(struct bonding *bond)
 
 static void bond_activebackup_arp_mon(struct bonding *bond)
 {
-	bool should_notify_rtnl;
+	bool should_notify_rtnl, commit;
 	int delta_in_ticks;
 
 	delta_in_ticks = msecs_to_jiffies(bond->params.arp_interval);
@@ -3767,36 +3767,28 @@ static void bond_activebackup_arp_mon(struct bonding *bond)
 
 	rcu_read_lock();
 
-	if (bond_ab_arp_inspect(bond)) {
-		rcu_read_unlock();
-
-		/* Race avoidance with bond_close flush of workqueue */
-		if (!rtnl_trylock()) {
-			delta_in_ticks = 1;
-			goto re_arm;
-		}
-
-		bond_ab_arp_commit(bond);
-
-		rtnl_unlock();
-		rcu_read_lock();
-	}
-
+	commit = !!bond_ab_arp_inspect(bond);
 	should_notify_rtnl = bond_ab_arp_probe(bond);
+
 	rcu_read_unlock();
 
-	if (READ_ONCE(bond->send_peer_notif) || should_notify_rtnl) {
+	if (commit || READ_ONCE(bond->send_peer_notif) || should_notify_rtnl) {
+		/* Race avoidance with bond_close flush of workqueue */
 		if (!rtnl_trylock()) {
 			delta_in_ticks = 1;
 			goto re_arm;
 		}
 
+		if (commit)
+			bond_ab_arp_commit(bond);
+
 		if (bond->send_peer_notif) {
 			if (bond_should_notify_peers(bond))
 				call_netdevice_notifiers(NETDEV_NOTIFY_PEERS,
 							 bond->dev);
 			bond->send_peer_notif--;
 		}
+
 		if (should_notify_rtnl) {
 			bond_slave_state_notify(bond);
 			bond_slave_link_notify(bond);
-- 
2.34.1



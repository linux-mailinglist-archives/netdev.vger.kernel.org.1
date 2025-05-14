Return-Path: <netdev+bounces-190330-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F27AB63EB
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:16:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BAD77ABE86
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 07:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E9F1A2381;
	Wed, 14 May 2025 07:15:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30FD8E55B
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 07:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747206953; cv=none; b=ShOztvUg0835v89kfh9RIu7mJkIQshn+nvZGqtKbLX9S0PQClRxKJmw0DW7qg2YTmMgryiriFcDlT4ZZm2bPAVJtQsgkS5BJLXWYZVaJdTmYipKIZjisdC1YHPYPBeaMuue7YwZaJw7eX2LbXRzo7NPGaQs92kZHbdk0m0xwdMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747206953; c=relaxed/simple;
	bh=vlpM3OlkchgY9StG/SnV3lYGq3u93kyrmPRdkahMe9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RPfVMonPeqIwKNU+ydzkQMjFoXPDnY+353vQwD5HaAnlWxILXJTWV+aBFPKBCRvfW5zyX8KZb22AP8Qy6HoYSLE4SlFenMDiqma7qijXCWKAyLZDqJQmyB8I3bVs7G7yHzDxKixUiSRP4l4mHjMDQcR6yxdnTaZ46tkm4e5pfZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz11t1747206846tcefcf409
X-QQ-Originating-IP: JLpZz+qvU0WpaPVa8AL2Au44eg3KPcbS/N8UwrXX9dY=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 14 May 2025 15:14:03 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 12745230458652632465
EX-QQ-RecipientCnt: 11
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
	Zengbing Tu <tuzengbing@didiglobal.com>
Subject: [PATCH net-next v3 3/4] net: bonding: send peer notify when failure recovery
Date: Wed, 14 May 2025 15:13:38 +0800
Message-ID: <28FE0EC9922CB9A3+20250514071339.40803-4-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514071339.40803-1-tonghao@bamaicloud.com>
References: <20250514071339.40803-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MrY0q4FYDxnuJMblMh4pDGAyCkmJT8MCss7yuKxaFIQ/QFTPQ06+0AmL
	AXaqvTP67Wid7b0JOmLWqqXGCN39J65oHW5s2wRMRA3jJ3fAvg1ZyD104pUGKeVZXG8yMRZ
	NpngElnkyAfwtlYF8OlzJtvSwgOGdEXZnCzijyjczkmOCn9psVqeBAKrDMcD9s1+SR6ffhB
	F+Fk7lBvAL/TB4is9jeyS9RmFmveDV9iBiz9M0PVtEe3dsvSVB/ZWw2dycnXnXioqmQpdAY
	szKEycQu5V7lOuAgeFg1f1vBV6huhEfXnou6Tg8b8PWaPu19/RzBz5oyVv2pyq0O4JP+HYw
	t1q/Hcker/dXcPLQ/8dO3ezoZ+eNzNZG7f+8T2z5OYhFskDR7kzrGWKV28Y9Rc8Epoudvxb
	+K9VLSt0C8Wwt8BL0aXPU3wnSO4eFUErVbfTgm45KNNNyiZ75k1hkQ7shU9/jEna5BzyPD6
	T9p9bo6yoccQSyPzZAnW/1+NIcHP/yxvv8jUHNsxCanDebpxiTu8uUgWMat5VSXL9BziPAu
	dLGmy2A+zeniBGZf/HZ110bMA6jCCIPi1sY867Bno7UIDYzDnUkLlZJJTzrgn+wJkMgaMpw
	Lx0CqHv6nl4Brde7CwrS1CICcPfoAzr49r0o9rCYtnNeYboIQnfYOwEtTMLufp3G25EfNmi
	k8HJdWaRb77S0CYAp/qUIRWWMcezzljal5yQ65ir3PlStb/5jG2ZBUXjCv2uKeuhc3OYI3l
	Bw3z+lUQv6aHHDtGRx/EAzCs04hTGAHBxgFp2MHZOeWVr1Dh6zWzxuyp7lNfNhoWr1tmSVx
	Df5Wf6lXuf3ztXzSkLMYqER8Lo21pCqGEnp1GjiDBOKtI7m3fw7HCy9MufEZGX5BnaixEip
	406GOywjNm0UcA9GF0yuoJyoBDIKUSme6vyvcYLdzp2O5CewR9TFrBW/wpkeykLiA2wME/9
	iQx+Xryb+pZCQYBG+iBCpB00lhwK3TU/YeacVHNoAdg4jMvW61mm0voPOvrzqZ1bvK0hsRY
	S5FjNEN66/q2jNCArV7QP4lJ4LlvVaTVJDRTxj2ipShM2jjcTBpX/k983Ti0o=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

After LACP protocol recovery, the port can transmit packets.
However, if the bond port doesn't send gratuitous ARP/ND
packets to the switch, the switch won't return packets through
the current interface. This causes traffic imbalance. To resolve
this issue, when LACP protocol recovers, send ARP/ND packets.

Cc: Jay Vosburgh <jv@jvosburgh.net>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Signed-off-by: Tonghao Zhang <tonghao@bamaicloud.com>
Signed-off-by: Zengbing Tu <tuzengbing@didiglobal.com>
---
 Documentation/networking/bonding.rst |  5 +++--
 drivers/net/bonding/bond_3ad.c       | 13 +++++++++++++
 drivers/net/bonding/bond_main.c      | 21 ++++++++++++++++-----
 3 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index 14f7593d888d..f8f5766703d4 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -773,8 +773,9 @@ num_unsol_na
 	greater than 1.
 
 	The valid range is 0 - 255; the default value is 1.  These options
-	affect only the active-backup mode.  These options were added for
-	bonding versions 3.3.0 and 3.4.0 respectively.
+	affect the active-backup or 802.3ad (broadcast_neighbor enabled) mode.
+	These options were added for bonding versions 3.3.0 and 3.4.0
+	respectively.
 
 	From Linux 3.0 and bonding version 3.7.1, these notifications
 	are generated by the ipv4 and ipv6 code and the numbers of
diff --git a/drivers/net/bonding/bond_3ad.c b/drivers/net/bonding/bond_3ad.c
index c6807e473ab7..d1c2d416ac87 100644
--- a/drivers/net/bonding/bond_3ad.c
+++ b/drivers/net/bonding/bond_3ad.c
@@ -982,6 +982,17 @@ static int ad_marker_send(struct port *port, struct bond_marker *marker)
 	return 0;
 }
 
+static void ad_cond_set_peer_notif(struct port *port)
+{
+	struct bonding *bond = port->slave->bond;
+
+	if (bond->params.broadcast_neighbor && rtnl_trylock()) {
+		bond->send_peer_notif = bond->params.num_peer_notif *
+			max(1, bond->params.peer_notif_delay);
+		rtnl_unlock();
+	}
+}
+
 /**
  * ad_mux_machine - handle a port's mux state machine
  * @port: the port we're looking at
@@ -2061,6 +2072,8 @@ static void ad_enable_collecting_distributing(struct port *port,
 		__enable_port(port);
 		/* Slave array needs update */
 		*update_slave_arr = true;
+		/* Should notify peers if possible */
+		ad_cond_set_peer_notif(port);
 	}
 }
 
diff --git a/drivers/net/bonding/bond_main.c b/drivers/net/bonding/bond_main.c
index db6a9c8db47c..84fdc9baac9a 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1242,17 +1242,28 @@ static struct slave *bond_find_best_slave(struct bonding *bond)
 /* must be called in RCU critical section or with RTNL held */
 static bool bond_should_notify_peers(struct bonding *bond)
 {
-	struct slave *slave = rcu_dereference_rtnl(bond->curr_active_slave);
+	struct bond_up_slave *usable;
+	struct slave *slave = NULL;
 
-	if (!slave || !bond->send_peer_notif ||
+	if (!bond->send_peer_notif ||
 	    bond->send_peer_notif %
 	    max(1, bond->params.peer_notif_delay) != 0 ||
-	    !netif_carrier_ok(bond->dev) ||
-	    test_bit(__LINK_STATE_LINKWATCH_PENDING, &slave->dev->state))
+	    !netif_carrier_ok(bond->dev))
 		return false;
 
+	if (BOND_MODE(bond) == BOND_MODE_8023AD) {
+		usable = rcu_dereference_rtnl(bond->usable_slaves);
+		if (!usable || !READ_ONCE(usable->count))
+			return false;
+	} else {
+		slave = rcu_dereference_rtnl(bond->curr_active_slave);
+		if (!slave || test_bit(__LINK_STATE_LINKWATCH_PENDING,
+				       &slave->dev->state))
+			return false;
+	}
+
 	netdev_dbg(bond->dev, "bond_should_notify_peers: slave %s\n",
-		   slave ? slave->dev->name : "NULL");
+		   slave ? slave->dev->name : "all");
 
 	return true;
 }
-- 
2.34.1



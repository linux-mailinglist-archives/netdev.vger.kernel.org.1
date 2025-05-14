Return-Path: <netdev+bounces-190357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CECA3AB677E
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 11:27:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A3A11B621C5
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 09:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A151A225765;
	Wed, 14 May 2025 09:27:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7082A225A34
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 09:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747214831; cv=none; b=VjeDBCS1yMkqTynhQPev4aI6xzrqyANqcP4nyBasbXjjQZb96icSV2RwTTCFwc340lsT5wPkmp2YapFl6kkBf9BYGN0XGA1Qg0pzpt3sdTv4e0Catmwvbprw1w4Go6y+xx3dtg00fOc90LvHXd/58wqF3/+heBcSSq8A/Sl/3uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747214831; c=relaxed/simple;
	bh=cesrM2qLdmTdsfSA7TMewuQ1Y0YYHOF8/zEPUEQS3VY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I/DlzcI8ihCWSJPQOABqAObPsu1dQ3w0rgBBFKcJ21Vwy7BxxX+jx36/lQirvXuYJf19e4J9aLJrrGHP7QTJWyz2eOSLyj9aok62BaNV65saTlYv6gGL08FhFDyq5/9Z4xGymi1jg7jX1GVwdtKfOTkwwIFGb6JjCa3E4i1ioo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz7t1747214767t76084f78
X-QQ-Originating-IP: ETzsnfgtSQ2u7wJW+0yivbzFjr8KielMxqL3h38ELCQ=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 14 May 2025 17:26:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 15844397742163813519
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
Subject: [PATCH net-next v4 3/4] net: bonding: send peer notify when failure recovery
Date: Wed, 14 May 2025 17:25:33 +0800
Message-ID: <FC4C7403A5BC95AD+20250514092534.27472-4-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514092534.27472-1-tonghao@bamaicloud.com>
References: <20250514092534.27472-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MrY0q4FYDxnuJMblMh4pDGCy09+t97Vq3PZhA1oFEt3Ijou4nCkcOObf
	Qg89gL4ovciMi9d6YHeZDYnpJAfNlzY5qtQPh5gwa3U82IuOQHAW8DN2hZbS+3eK7Xvf/cy
	4XXELevhSCBhJnc467pX7iomhUJz2avy/sb+SleBGcq351aHWzmbVS3LHRfhHQsIi0qy7S4
	qUAMUsPMzIbvz9SbXy73I3m337axpicHqljWoqrBwrMkNL1BWk2/QGGU1rTdgY+sEgLpSP9
	WqB4VWiI83qqzq3RsHNGKNPd1Lx7+ATgNzMLQBfArdoUDCjfc8Rzpz+6yY8kCavZgPVKDtl
	YGLUjE7YvPHsT1fnrD+O0XlVIrfYsWqT1szfUEPMkxk6bUfG6P9OQY7/LOr9AcqtlVNIk0F
	jxtrtvBeGiYyU59aSlJx5sPghc2WqXXfJE99f1MNL518g9k7vj60kelCWqKFefBOWFPjsea
	J/FEFqjo3d0PesrlgLm4hAC5vuSh9T8w9AQ2lNUhDDDxRns059G3yy6NofR34twbD0MGhat
	9KbUyDPXuHbtZJnvAEjhmwk7VUJj5YqECSYlljygAKXEnlJxvfUIxgCsUeplaFtBMOajOXU
	NK9vbKJJnOuEm6DUr3yw6Mvu9CaB1CUcQrd4qaFrOgTKiJjIn4lVQ8IJcLo31bUlPdVrjJh
	P0ZhpwXS3gEss/BTfmvR4/sSCXIhLfldV02jMSQGD3UPNjEN//lM3zeScrVxJUhW0eXamG7
	aqAFdvzZ4DoXj94O/4E6WJlDv3eYkv3wTkd1Gvj75PIVwLZTp0dpbWDSxIWzhSjSdHx3gLQ
	PMbqbrQHFmvjGEye6+wzd422AAWu6JpDNWj2RLLqUwtU/DbEVU3hSEc5DPhshVhfJuNlsy4
	vCAgI3jg9EH9w0oKNiieDJu29GdHbvsXebmC3hT0owoLXJIwrQDI1IBa3u6FuXepQtqi0Iv
	BHJ93/JDMotS4xnFi4Iz8CBH7y4LEOFC2IXCwMPGXhAWQRHY+389wkOOYGEg23a7y3E0lf0
	+AGC7o2I1nPWtiGw1mN6yUaRfKZEGq9aSbPw63uQ==
X-QQ-XMRINFO: MPJ6Tf5t3I/ycC2BItcBVIA=
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
index 37340db6512b..21acde5309fb 100644
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
+		usable = rtnl_dereference(bond->usable_slaves);
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



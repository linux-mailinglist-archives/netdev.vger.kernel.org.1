Return-Path: <netdev+bounces-190026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28E69AB5046
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 11:50:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAAB11682EF
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 09:49:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3ED523814A;
	Tue, 13 May 2025 09:49:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3A31E9B03
	for <netdev@vger.kernel.org>; Tue, 13 May 2025 09:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747129750; cv=none; b=b/TF/024Wu0RDAANXSIMPGIHE9k8uMTodhGIAekpMCudDpjKctRzZfVJUYqdrFWQOC59tFDNaV72/dUBHayzMe1VSm00Bloo8CZBCmws0ZrOlJOPNyda2wNuTcQYCVAEHODpTo7RcMxgC29E8bKZ0rpgK2U0nWLrhDVi3c16USI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747129750; c=relaxed/simple;
	bh=WsNdMP9RGFUNTFL7D88iKTuikdHxobB2st873qfzTGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hl8ZCTUkDK6LPPhxKFssALPokPps+PEIFRcGgpx/TZ0AVvcByOR22A25A8I2j396DawANcjFOt6GKUJukfSL03+H8B9MUG6snJjdAcKDYNlm0gA62QiMBxb7jTMGZcujVuKEyHFQv2DIyMHRBRH0+Bxkf5iY85/jQ3UqSkrZMuA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz4t1747129689t235a012e
X-QQ-Originating-IP: LdJvciXUCVoCXm4XejvGQxI5VlnaX5ndfzAr+w2K3tc=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 13 May 2025 17:48:06 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 480561675779206270
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
Subject: [PATCH net-next v2 3/4] net: bonding: send peer notify when failure recovery
Date: Tue, 13 May 2025 17:47:49 +0800
Message-ID: <F5D495B5C2A94D9F+20250513094750.23387-4-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250513094750.23387-1-tonghao@bamaicloud.com>
References: <20250513094750.23387-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: McfvTdNTSvcBtPi1SyhSYzL2AyCUXo8PD/9KY+WsGln+TBK9z798IfIa
	pr+3D4jtx5Thtvqr0uYWWKo3SeXGjhkL2P1q5H2c05f6QGCuRnYQyqJi6Cy+JBUTwR/CbJX
	I4+ct25TfLvCP5Vcu+3a5uQ2lHYbUIOKYDfwWSx20QtH6Pnfx/ZoC/j3HEVEjZNN6G0MTex
	sgRuhHUTQmUuYuCns3iqxvqBJFUU8y0mxCK4FP2fheRHsIgSMrtVy9Jvmc+LFBxXWNan8g7
	zFJkx5xibDHLUCtSSBqe/rO0FmhIV15bbcsJu6HS0is890NtQKRYk994Y5xnH695FXLpxS3
	HhhE7zFjmYZIuJcx5nbPon3I0V7cn0ohnkSvWBbQ8jHYT5LTtWtFpRRivRnl2oMy0Z/5Fd8
	h9bWIzwmuoZ9zxN1FNNpJYg8lFNqCiDulmPBw8wh1o1xTnxiDc/rvyl7V/0KBfAQ0GIVPBm
	xqA35lDrVrTZohNUUkX2JwBxiXBBk58AD+C1uSf1PrBCuWZ3UiJx4wEi+79BrsbQZRqZXnc
	Rn/UuI0lPtu5xadDjHT5Ourin6AwFf3O3mUh5n+9RVrkV/koWeKLwzMF8FXc+qer9ijv9Vb
	96FrwBnSQK2WB2wPHSAxW/klSbf4FhN/C4P7W9iyCWEgveK9zZLiUhoEHbnwPFxO3EFbbwA
	tDhLyhnFo/HYQ8L5qBLjOD2j3SbHltpyT2gNQqvLO2HhWMJDxgv4dtq2Qhvm34Q/P2nuUXW
	jMar3/XPcJAHE1Ap9F9rljTeV5vdSeva7dFZ+6rWAwS1XIl2WVp5pluez45Kx5+P3YQun9B
	TLqsH+g7M7KxeywyblWM2cC+ra2+INAtZMa9bvIzzfVB0pQBZsW/Lr5U2PLndMW/eaXBpO2
	IaM3Ci7SLgOTC8m+/gvfZgqMiyTSi1f+7s3uYMOHUbB6AProLpi6w1sVOACZn82CIwZPKig
	dCJx/s/8oHwjs/JUw2zRjZu5YS9PAmkLbZkNINn1/Nw4dbQi32ZMrHUgY0Faxi9cDTayq4Q
	xb1aPP78fmIjsogCJPaJY+yU7MlzU=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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
index 8ee26ddddbc8..70bb1e33cee2 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1243,17 +1243,28 @@ static struct slave *bond_find_best_slave(struct bonding *bond)
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



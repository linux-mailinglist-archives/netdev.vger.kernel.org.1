Return-Path: <netdev+bounces-191436-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC59ABB7CD
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 10:49:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B72DC188E894
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 08:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30EFB26A1D5;
	Mon, 19 May 2025 08:44:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgbr2.qq.com (smtpbgbr2.qq.com [54.207.22.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82519433A6
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 08:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.22.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747644291; cv=none; b=Ry3wpx/Hz9cKAKLBDk32ZWf56PEcxleoG6+jK1YNQnIS9gPwQ+zdPCr53f/Jjf1wyZmvGbTr5WGSIhTMO1kNUZtfbbzHjOHfatbklks8d39P+s0ZiGLByoKGtr++LTnNMar43Q0bRHJdjUmZgKe9QEgkuH1dRZjpv4olt9UjOIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747644291; c=relaxed/simple;
	bh=1PH/+W062yUFCtPmGmMbjPsfcyxp3t3lXjmPmXtVNQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rfn1M3z1jHyZWvtTwr+DU/aq3bRI6t2SzNsaZt+11xHl/lgPKPVaL1B1YQqLpZtB3VzCqaE4y9Oj862aIKsA/mBMxA+Hmp1cXCIVrS6Su9IJSvtaPL/5avniPF54dhAeaj63J2ZaYmXikxJxQrXDQtM1DPuueh1wvBvliuPXpA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.207.22.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz15t1747644220tf5c6d91b
X-QQ-Originating-IP: EeeiP6wynfzSMN9TEpQMK7iJRuY6jdIZe22322XiCOg=
Received: from localhost.localdomain ( [111.202.70.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Mon, 19 May 2025 16:43:37 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4737436519499999248
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
	Zengbing Tu <tuzengbing@didiglobal.com>,
	Nikolay Aleksandrov <razor@blackwall.org>
Subject: [PATCH net-next v5 3/4] net: bonding: send peer notify when failure recovery
Date: Mon, 19 May 2025 16:43:14 +0800
Message-ID: <5266F4959C1A30AA+20250519084315.57693-4-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519084315.57693-1-tonghao@bamaicloud.com>
References: <20250519084315.57693-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: OezpMYl8oadHcuy/ECE42pSE2BTxXqKIwF+tdzKB7Ue1w0AIRlj55k2U
	s3cqfgmFnkPepldrtwe3Lq/9bS9knCCQpUVXcpCz4iEh0KDRi5LxwJLdbloDp7C1/xN1DKK
	D7W4hSH+1nrg7vueA5C/lCc7IVN1uF9ca02PHlRCoOlRayXUvvX/tcRGiOaVSbOmDk2tJLC
	KSxsWbRQN0z365wrf46Si9NdgK0lGEjHOXrDbLBitL6dU/kRGHAOUfk1H30NMVh281DYS6N
	RJQp82sM32JMmG5dL+sfA+NR1eoWngVE7p5pAyy4AG+lRh8UZJ7JipK55Ped3s3qLzKYdWG
	OHMC77qDSQKRu5Sf43pwH3Q7HztiP1OOGoZgOz/znb8R7S/Ee6vHVMsUpz8E7B/EkmhlL4n
	/eQUSgU1pAfzSl8Fasz6TpBaotRdkNiEk9V/Uvj0iYGbTD+1JDhhUgi9TcUMhX9NpjZj3NL
	iaQBkwnZ/wsd27nFZwC1y9YnNEoLCAnkZgA7xxemeMCFhVzixWdaffOlbgducqpdfU2kUOR
	onohmEv3ObpdZiLbHof6y1XmSMmbVmwO091hg43RrZE+qfojuI7y+oC87EnILngFc2BIl4b
	dPl2pKOYV1LAFyN5E2GwboYQTv4uxM4y7ljhRFdNMYprzwOW48NMC4N+K796N5I2C8fnz/N
	ceAUNtbEDasNcnjxFrB7EdNg9RodTEAlSqtBxzNObSSSwe5iZtCZ9DS66e0cgL8jmn9Q6Hd
	Yk2Ab3c+YvjPeMmgK/wjnPgOcfYoYI5/jP0NofLQH/kI0Np4mO9F+5iASGMff2KeQ+MzkNk
	pDb+4IInLC/VVbQ1jnN90kcbUyN/flguG4ihPcDbtAPy56u0X/1+NJY2Dlobeed2lUwM88F
	5p/TZAnhKTW79Dctb5JdsHn3AOZUnJSR5gnYc5ia+CZwtD1KdLNS30N0tY+Rb7L8sAjsV+j
	NgjVSTou+mBkRS6t0lCvKVPmwAsLnRrpYcE8kNzUbr91ew2PPWMf46hZ9wUmOKtWB30DXm8
	87ZvQgbWbP73yyzJ1TPOk2pT0x1l4=
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
Reviewed-by: Nikolay Aleksandrov <razor@blackwall.org>
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
index e26295c5278e..627c025a2076 100644
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



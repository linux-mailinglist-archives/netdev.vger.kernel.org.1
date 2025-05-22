Return-Path: <netdev+bounces-192613-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB195AC07ED
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 10:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 07FDF1BC467C
	for <lists+netdev@lfdr.de>; Thu, 22 May 2025 08:57:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A62288C82;
	Thu, 22 May 2025 08:56:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF5B288C9B
	for <netdev@vger.kernel.org>; Thu, 22 May 2025 08:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747904177; cv=none; b=WBakaMjWcnsNazDO9kNs4xnAEdS+25+JMgsuvjyfpv645TVAXhlECWEwQowPOxatQt3I5lSWB40XJndoIN0VulZoC1jh0/vVVrtRTtrBzUs107X/yFA+7ctJyRcWHJoN6RbOfhconXGn1bJIIzTBt9v+Hx/sO6rxrxT0QSNHtpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747904177; c=relaxed/simple;
	bh=idYOCz2wgudLKK03gAoWu62iLlPSVpxTpSp78oBKl4Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fAc9K0BIoCAAuL3co++jrXeYSwaMLUJhJKENgAtGuSZKpZUlucm/uMVP4Gv8/mYDByA2mcC4GtfhbePkfdXrHf+95weagxBDhv92o37N97cue3ZSJIE93iWMTcXGC1yLnMKb5IRuWjZLU/Ssp1QbuPsgpuEuM325OVcUWCL8L/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz17t1747904146ta9ab4925
X-QQ-Originating-IP: vlEjUFTjuFyGW/5wHwyLnuYmQBDJINVuXWNqMJ7ZMlg=
Received: from localhost.localdomain ( [111.202.70.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 22 May 2025 16:55:43 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 9060089470092902751
EX-QQ-RecipientCnt: 15
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
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nikolay Aleksandrov <razor@blackwall.org>,
	Zengbing Tu <tuzengbing@didiglobal.com>
Subject: [PATCH RESEND net-next v5 3/4] net: bonding: send peer notify when failure recovery
Date: Thu, 22 May 2025 16:55:15 +0800
Message-Id: <20250522085516.16355-4-tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250522085516.16355-1-tonghao@bamaicloud.com>
References: <20250522085516.16355-1-tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MOfwHzgDpc8ILM8KD/PYw+xunmuEDaDUGXiY6qW8T+l5X6+TIT4b3r/R
	lHlQgVQNb41ooQuNKT6OLNheegUYiJfFP6ibGwuLA8nfdgSdz/KNWjqJrjLMg9jV1+zP27d
	odjHpW6GHkuciRsYn3G6GAZmdJ2EJNsOPin1KMpKtECiVh1FVHsrp0rkcwygcbJWATmcaZa
	we+fUd2RarwqI7ZfoaAGXh+jbkie681xHbJLWBgHvNs0DNmzVibO2hyAfY8/Tqp4Ij+rMPw
	g6FzuvtouKirlRsjdznpPLSLwRHeIm4uZ/K3jj4xkEGVrfU9albQYvaiR+IJX6RkXozt/Ec
	E58kS083pmAVQqYTUDr/XU80ggyUSNEQsgRnbaCdr/Vl3l+14vdYyRtLBXX5ztMg2ufHzDH
	ozdfopbnwA9YmCkVbDiJqkm6qKFriJIwH2HTev7RpVCc+HQzKGbOVhDBh6f10Q/crDrgvwq
	iCxQrzJKWta9Qn7YRakXw3WrgakFkSQMte3DWRCq8127kfslTOXzB4u5poKIY5utsJTnh20
	6ZXOjkdozsGWZg2VJbxMVI5ulXcCWQcZ9zQPWvgHM/eX3tfmnKe9eRuC7WGRumZhNVG8sSt
	XuHYzcav02RBb47/dkp1pWL4ibrNGhEsO11nSFPn/TFwKnjKKhyg/NvM+1n2syNkzGjVrQ5
	CRUmr3ssDiQxTg59JVBog4Q+EXYIRd9DUxjkeEPVJGjMuBznrPgjGrQiaTVt0k8fTg+kWPO
	LUrF3fwFjPl6w6ew4IF6rYacu5vyyrzUt0mcMdgmlV1xCANn/OeY7LwT/NQTQocAndRpbVV
	hLChJOwjGJP/soHSIfSYGndr2TF66NZShJI4sp7lwUEk8KOxb+3raVQM0irS4vozLC6EJh+
	ea/XlKAmJhx/1Qr50tMT6Kx8Cdb0DMP9r9bjtkmE9iUlql99ir9eDvLnISJdrAFHCLYZj4d
	B4xox466v4d2r/k9iwGBSZ9qj1rgwMJ63PCouYi4dePSLm7b9lvrslfdoDPUovV49oJU=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
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
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Nikolay Aleksandrov <razor@blackwall.org>
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
index b5c34d7f126c..7f03ca9bcbba 100644
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



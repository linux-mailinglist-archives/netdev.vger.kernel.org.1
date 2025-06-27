Return-Path: <netdev+bounces-201958-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2106BAEB93E
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 15:51:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E891561C02
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:51:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E6752D9EDE;
	Fri, 27 Jun 2025 13:51:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030DA283FFD
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.254.200.92
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751032283; cv=none; b=DCMzltwB/jMjIMMy2hKQ2d/a4qkTX+D0E9NvYa7v+oLy8edA/k7WR5LlL+A5ch5dmAEvaoS63E8yYlRsqWb22oQ9Ef/z0YOIgKjW7fP+xQgCBDP3NkoDe7d73TQCJX4oUWRx/VBDXRRX414mt/RA1F/I/oL5fytCuPt70FdnwJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751032283; c=relaxed/simple;
	bh=Jj88Lq3jXOZlEpJb28Li4fhZ0jKf4K3pl9cX+85TMkg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K9j7ddLPFfCJwInZNnqBeEJYMRA4WVCJPAra1FYQ4jpINPc77lnACkece83nGFDfP9ChC1YBJ0SyjsjC/d2o5PD9ttvthhFl8mmhCcwnEvTWvMy60oBw1Dm6HIOvGjfi3Comvqezv3BdD9LvUKbelQmMhlf0t4LMzzO5DRUiVTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=54.254.200.92
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpgz10t1751032260t38622fa4
X-QQ-Originating-IP: ScJCIuVKQDY/kcn5wi97KXBXw09Kb4cDlRpZpzg469c=
Received: from localhost.localdomain ( [111.202.70.99])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Fri, 27 Jun 2025 21:50:57 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6887009036528513807
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
Subject: [net-next v8 3/3] net: bonding: send peer notify when failure recovery
Date: Fri, 27 Jun 2025 21:49:30 +0800
Message-Id: <3993652dc093fffa9504ce1c2448fb9dea31d2d2.1751031306.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1751031306.git.tonghao@bamaicloud.com>
References: <cover.1751031306.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NfykWmRlrd2o66oTK+7s84eMhff7NgLwOyqM2Ueh8K1FVBWXPep981GR
	FGqs2InpMiImlaR15tZzMuYaobn3NXPY5H20QceJQWHQfqbaDXVG/Qld0pwhNOsvaHUkF07
	npOMDepNiVbbIXJoFBmf6A7kQtYPgHXWpgeB8PXfaJhHsPPe4UZVEOecFHdnsbAKuup1R5n
	XW6vQjDtsVx8sh6GKWi8L/T0Yy7DER4VegSCjpvoL7tv8+lZ4HQ6GPZcudYkwagoHxLtGyc
	OMFCYv9KuzE5kCIMdIdfxsWiFTd5OmLYzVThQSR0tM2z3h/17w8NzQsYB8gRA8YLx05ZuJP
	cn3dqIUgQ9iPfG2+7XYos75zBtbvhdnhNqe+PNCf45qJd66YAyHG0CAVfCDgOr0D4EnqO9d
	SM5Csxh6nQHLWt/asYy8cVYVdAJEwq9RffMHZlzefb+RTCBW/TtC2LLr188kjn85fbMM1uE
	eBrAYDswGQu0+fGwe80oh/gKyOFGjXk0WPdKFMCM9DG5zBaTzr7zLb40fSqBy+029gG68f7
	DM93eZtnMoLw1V6XDH4i9H4R7X+nkcoYFhy4levVh1RzXcDFC1eF/5Yg03FokCyJgFJwhPi
	TBvwStSK+3tLCRPMkeWfAcoA6ls+I5xgW0gZT0IIH5L9ATs7QSNUMEBuEKYmZxmSI0wL+Lg
	uWHEr9C7taGg97veCXc9WUBv5if60SGKiY6ctwJnImAaiYqXS2lEyDOxZSyzXlYAgggSypH
	1+rxie1RybeRrOfmH/SuRZY3+GTVjiOnJrkOhnXx+B/Y1BKrsDrnKomUsYL0tEWn9va+mdq
	0D96n40yBwO6XUJKGc+BtaK/6w2LIomDtf0SIQ0P3R1IYWXi+KOhwTEJlPhI6s1Qb7rg+jv
	J080Dym1THih84cc8lqfBNaZxZcGUgPY20Pk4gi9bw1+zm1QjyzN1u1hveIPQH+iGw/2zdV
	yFRyp/CI4o7qR94BoPvYDLxy74+6jPJD1xKSJNlSQqu3eHnglr6mJ50yRFfGmS48JUtjbad
	qd/xXKPceVXqyyMiRD
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

In LACP mode with broadcast_neighbor enabled, after LACP protocol
recovery, the port can transmit packets. However, if the bond port
doesn't send gratuitous ARP/ND packets to the switch, the switch
won't return packets through the current interface. This causes
traffic imbalance. To resolve this issue, when LACP protocol recovers,
send ARP/ND packets if broadcast_neighbor is enabled.

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
v8: add comments info in bond_should_notify_peers, explain why we can
check only the mode even through mode is changed.
---
 Documentation/networking/bonding.rst |  5 +++--
 drivers/net/bonding/bond_3ad.c       | 13 +++++++++++++
 drivers/net/bonding/bond_main.c      | 25 ++++++++++++++++++++-----
 3 files changed, 36 insertions(+), 7 deletions(-)

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
index 12046ef51569..17c7542be6a5 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1237,17 +1237,32 @@ static struct slave *bond_find_best_slave(struct bonding *bond)
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
 
+	/* The send_peer_notif is set by active-backup or 8023ad
+	 * mode, and cleared in bond_close() when changing mode.
+	 * It is safe to only check bond mode here.
+	 */
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



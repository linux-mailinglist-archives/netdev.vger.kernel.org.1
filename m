Return-Path: <netdev+bounces-195928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1290AD2C3A
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 05:47:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4A317A8393
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 03:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9038525DCFF;
	Tue, 10 Jun 2025 03:46:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9282F33985
	for <netdev@vger.kernel.org>; Tue, 10 Jun 2025 03:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749527195; cv=none; b=RYYVyj1hxJpgTJEDybKCrD8gXWXh1AMmxJxEcA/TSmVaF6UnqZKtaItvmuz+fF8zLbhUqXF/KecjNzIbBLdvib1zalxqa6EGIA5ti8RAPuk/+wwMlPPaTXhDfflKlzvOlHKAZohpw4zjRzz31gB6rr4LSsNXTMkujd9K9hd/wzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749527195; c=relaxed/simple;
	bh=2ZGi94tMoIWR0+UROYhU6I5IxlA+QqathFUUEDbuG0I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EgodJ8M4b+VHA/3iG8E+POwtYbzhi1NbivHFpMcdCYJovQFJurrftZweEMoeIy6+DNSY4CV5fb9gouFS5b3NrCw7fkDHK0NFlvI3rXRClcMusOCaZOSYJVCIwrC94F1euTqJTgzo6H7GRQvh2UoPGuyrf5oeLawmzUhGUos/GhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=none smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bamaicloud.com
X-QQ-mid: esmtpsz18t1749527170ta949d520
X-QQ-Originating-IP: r8AH0oOJlPqDJNxRwIm2xbJ793Pj7a3deiDxXeu/su0=
Received: from localhost.localdomain ( [111.202.70.101])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 10 Jun 2025 11:46:01 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 16349489029027878949
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
Subject: [net-next v6 3/4] net: bonding: send peer notify when failure recovery
Date: Tue, 10 Jun 2025 11:44:44 +0800
Message-Id: <81185ef7f9227cff906903fe8e74258727529491.1749525581.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1749525581.git.tonghao@bamaicloud.com>
References: <cover.1749525581.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MKzYG8XJzx27oJ+SOxK6WF8G9SBBqwqVXfIL/AFTR+wEtvrGoIpRarkU
	bM5OCQDxZvSHQVLFXW2h96PTcSRNcmusqUldTvKAW9fUvQtecbglNdZjgAGMvgU4xBpTSV+
	Ed9V9p23KWNUTI3XfnsgvqxeByXDp45iX9hDyIUJS/hYO3CSOgfNz1urdPs1nQf/kzp8e6M
	dJsTd6ZSQj5JkdkhBYD6s11ZDN5W41HgReFsReH1NOYvtGUagXgWkYl8WfYdCkptYV/h7F4
	iY/hjQnKz/uvNc05p5Lp0TAUVp5AHdf9KZxPDkhlhWf7FQ4geCz4R0yvIoB3qeshmR2gecq
	iO9XeOR/E2766fePS0ZtEZTXPU1yHomGZEsYzyIaEYnJeJdp2Dd07sdy9duQprzh3ning/h
	rTrrHKnJ/xlptk+/nrQBbcTBCgnBZONCAc7QhaDufIuyMqXV8wvGm87j0iuM0uqvQSZ0Gne
	UwDLrxq5FrDxZ3TJMx/IcZRc5x+S2vPCOiD+RlBcXhEgL06OK27iL/NZ3b+Ad3GUh9itDDG
	Vv8uxpR+jaAuUU690dHT6xYxQHG6kidZZM2l13bhnAsAZzwr/q2w/MVkN3I/9iN2TE7rGIm
	tGJcrU5rrBiu5D2ul44C/xbd0RHIqTklMc7rB12eb3oWg9pt4TQo1SruXzXeed0BVHPuE/2
	YV9BU7QFwmFjMau8eElycgpZ8J58KOMO0poGSYwhJ4eKvCm+iX5aW6Q0Honrl9kEZNBHGBG
	bZqvOjHTGNbeWFUwuLNG5PGrWqBWO4AB+4YR0zakyaNDVTWSM4U/7gzMTIFxvi5ZDPYydEx
	bBkFlp+caRgqi3mdsoeQWzyAav8JAgHI6fn46YerFhY9SCv8DgMqgDBe9BBD5sR2+3phbsj
	GHzIBtcS5vW4HspbBiA8P4zR3rhTtOQT48ffhR7NF+GZKaElAizTlWQzwtoBZcWe3j/z+6s
	VMmve+KkzZqQdAX40efYypV6xTWUxcYJeu89kQwPrq4yEQKgMhYy8Myja0u+mZXyoR8s=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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
index 12046ef51569..0acece55d9cb 100644
--- a/drivers/net/bonding/bond_main.c
+++ b/drivers/net/bonding/bond_main.c
@@ -1237,17 +1237,28 @@ static struct slave *bond_find_best_slave(struct bonding *bond)
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



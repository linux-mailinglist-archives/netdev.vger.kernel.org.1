Return-Path: <netdev+bounces-200489-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76A4EAE59C4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 04:21:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 885943B9E9A
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 02:21:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B27514B08A;
	Tue, 24 Jun 2025 02:21:35 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgeu2.qq.com (smtpbgeu2.qq.com [18.194.254.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3874487BF
	for <netdev@vger.kernel.org>; Tue, 24 Jun 2025 02:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.194.254.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750731695; cv=none; b=BM8XPurOY+NpXDcvYqwYQfcmlaxTLguQXKYqvhLX4VoSb6FATclFKwKC5ca2GhjQcsGCicryIccj6nkmYoqdgFQdhNSljDk72tp7l7Tb/Fqky4yBr3KeS3XtpS0uPiYCE940BiSgBM6fqU7QldfEIE1OAR5zqtKaHVhhmkQabZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750731695; c=relaxed/simple;
	bh=IpCUK2aon/mTNLEYtOOPEQobqJInHVdKlZcY2v27Hbw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Hyp4cKD8F2xd9rT5Wxt8SLn2IF5CPcSbaUntrhnoAT9RJJ3NaSHTAiWwOxBM6WVOHl3yKq0fuHo42KEW7luL44q90gNa7ZKyOrK+6OvUU3LUBDyeJdNBAh4in5o6KAkilkPMLv8+ypM0S3JyQRr1mOr8Xlz85XrGil75KUhBkUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com; spf=pass smtp.mailfrom=bamaicloud.com; arc=none smtp.client-ip=18.194.254.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bamaicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bamaicloud.com
X-QQ-mid: zesmtpsz9t1750731670t30677bc6
X-QQ-Originating-IP: sWEkX+CJdbhQA/pHcxdU3kDGtr45/evdkq93QdNk4Tg=
Received: from localhost.localdomain ( [111.202.70.102])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 24 Jun 2025 10:21:08 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4961617999830747113
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
Subject: [net-next v7 3/3] net: bonding: send peer notify when failure recovery
Date: Tue, 24 Jun 2025 10:18:05 +0800
Message-Id: <6965bf859a08214da53cad17ea6ed1be841618fa.1750642573.git.tonghao@bamaicloud.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <cover.1750642572.git.tonghao@bamaicloud.com>
References: <cover.1750642572.git.tonghao@bamaicloud.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:bamaicloud.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: MAu4Ycv3XufaalfzZH9QpYoWgj0Vvn8d5oP8HwuEu46Sj+gfo/SMAyau
	Y6UEO5v5zYPp9ruFbpqxgxLZ0X7s8Sh7C5/2LQLyXB/QZHVugwy7lQBlIg6IZiE1rOyr0yI
	nJoi677cnsa1/nhSWqdIrCXchtp/J+wXmD1nLzsTzUY0swswlAI9Tq3DXYQ/WugAmEXZ34m
	QRbw6QF2XAuVLWe3BncwVmpqiRAQ9rOBYrZHv3ZpgyPA2QV16XvbjAkAlFQ5DS5zRTUivNn
	qVlA8DR9ktihtJa5DwFaXEUV5+PEvz3/bTW2ex60DweOWZp/SaNfmjypV/BURouVKXW9bbw
	nmNCW5+GY+t7fm7Hd/AVyw3PQZw8vt0wmEa3qt2k2UONnR2xQXyEDc9eLEDLeUiSmq+9pKA
	H1Ftnqr3rQ3wfHmy2gD0qynlRNPHUPUC49MG7l40lJsYHA4NqZGRaWvh5jnBIjrV8+73s7u
	hfebdpTASE2ugf0IRsSxy3L3FnEH/47M/zwpEhIDBdFfw+TA26Bw51VAoia89Y87Xh1TMxV
	MYsha5WtCOVGFI2hyMFLfIBuj2vcADdlf9X1f1oxQSPV8BfEQi26ugxvo6/iwqQVmmhfjTJ
	9q6r1DqKsmRowM/zOlVmBYCWTu+qjleNn98bPd7259xDN9ClAVoFQZCMFsnZ0Ya+rMmujvE
	YW9VSRmk8dXc9bfD3//xY2WR+OKhDdzfF6zpq0CarPU/WCyIsLsWCsIV6057kfvRwlytesO
	yxFtNRX0jT64qbFr/UdNFtrI/Iopr+fZoaBUUh+QK07Y54+PXEXJjGO+lV4XPbxSOkYvDsz
	ckoBaQe+6OWyJgN99E9zXEo5ly7lVEsyY+jSEjA1ZCWI1stjItau1ACWtfUC9gkCB2xiBsD
	s2tmOZrPnUluBeoRMsoI1LhRr3Lt0Djf4EZbAhv7aMCpUpdK/AXupgV4CMaaZTqML40pZAR
	3rDaGQ9xLLMK/R8my8AlZn2a+vDiBrELMRUWBItYrdHHoMQ0Eed4bSS+3Ypy9+tuux9aoxa
	Bgq5DRMIZslJphhcqy21KC/Nmutsc=
X-QQ-XMRINFO: M/715EihBoGSf6IYSX1iLFg=
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



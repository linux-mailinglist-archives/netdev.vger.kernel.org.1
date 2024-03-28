Return-Path: <netdev+bounces-82953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 75FD0890490
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 17:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A4AFD1C2902E
	for <lists+netdev@lfdr.de>; Thu, 28 Mar 2024 16:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1029137759;
	Thu, 28 Mar 2024 16:05:41 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C050F82870
	for <netdev@vger.kernel.org>; Thu, 28 Mar 2024 16:05:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711641941; cv=none; b=s4flSpta0IwrUVBswUsj21HK0vmQv4He2PxD+h4nOJ3ijZrnPZm80dWlzIlySJ4VWzrmTjaVV3P1hsIVXQgC+wkuuxMijb0BKi0FzYnaZOM5UlkD8PiWiNEgBASd7H9N+PWtHZHnNDH+SaeCxmMvKWaNJINMxnLBZL9bExtKCGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711641941; c=relaxed/simple;
	bh=oDLvPsuazzH8hrGu4tA/9DBRUKW3BMutpKwJ+YpYx1c=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=eIS+ysXyqFThC+dGNZ8sDxwghXu6r4OLl9OLkBrt4xDHKkSEt6GF0stYX0W3q4HMJvb1/wnInciL8PPA4s2gGIq9tr4N5aKFKzTRGUcwXeQytsRsaGWVA/rQsvG6gp0GSa9Lok4Dz8DYcNcZL7uINWA4f2wWfB6nYbqZB0n1LLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <ore@pengutronix.de>)
	id 1rpsFm-00058m-N4; Thu, 28 Mar 2024 17:05:22 +0100
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <ore@pengutronix.de>)
	id 1rpsFj-0092JS-Hn; Thu, 28 Mar 2024 17:05:19 +0100
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1rpsFj-00A3PP-1T;
	Thu, 28 Mar 2024 17:05:19 +0100
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: "David S. Miller" <davem@davemloft.net>,
	Andrew Lunn <andrew@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Vladimir Oltean <olteanv@gmail.com>,
	Woojung Huh <woojung.huh@microchip.com>,
	Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	kernel@pengutronix.de,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	UNGLinuxDriver@microchip.com,
	David Ahern <dsahern@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Willem de Bruijn <willemb@google.com>,
	=?UTF-8?q?S=C3=B8ren=20Andersen?= <san@skov.dk>
Subject: [PATCH net-next v1 8/9] net: dsa: microchip: init predictable IPV to queue mapping for all non KSZ8xxx variants
Date: Thu, 28 Mar 2024 17:05:17 +0100
Message-Id: <20240328160518.2396238-9-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240328160518.2396238-1-o.rempel@pengutronix.de>
References: <20240328160518.2396238-1-o.rempel@pengutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: netdev@vger.kernel.org

Init priority to queue mapping in the way as it shown in IEEE 802.1Q
mapping example.

Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
---
 drivers/net/dsa/microchip/ksz_common.c | 53 ++++++++++++++------------
 1 file changed, 29 insertions(+), 24 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 08426f85f7707..78e9610044ea8 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -24,6 +24,7 @@
 #include <linux/of_net.h>
 #include <linux/micrel_phy.h>
 #include <net/dsa.h>
+#include <net/ieee8021q.h>
 #include <net/pkt_cls.h>
 #include <net/switchdev.h>
 
@@ -2692,9 +2693,29 @@ static int ksz_port_mdb_del(struct dsa_switch *ds, int port,
 	return dev->dev_ops->mdb_del(dev, port, mdb, db);
 }
 
+static int ksz_set_default_prio_queue_mapping(struct ksz_device *dev, int port)
+{
+	u32 queue_map = 0;
+	int ipv;
+
+	for (ipv = 0; ipv < dev->info->max_ipvs; ipv++) {
+		int queue;
+
+		/* Traffic Type (TT) is corresponding to the Internal Priority
+		 * Value (IPV) in the switch. Traffic Class (TC) is
+		 * corresponding to the queue in the switch.
+		 */
+		queue = ieee8021q_tt_to_tc(ipv, dev->info->num_tx_queues);
+		queue_map |= queue << (ipv * KSZ9477_PORT_TC_MAP_S);
+	}
+
+	return ksz_pwrite32(dev, port, KSZ9477_PORT_MRI_TC_MAP__4, queue_map);
+}
+
 static int ksz_port_setup(struct dsa_switch *ds, int port)
 {
 	struct ksz_device *dev = ds->priv;
+	int ret;
 
 	if (!dsa_is_user_port(ds, port))
 		return 0;
@@ -2702,6 +2723,12 @@ static int ksz_port_setup(struct dsa_switch *ds, int port)
 	/* setup user port */
 	dev->dev_ops->port_setup(dev, port, false);
 
+	if (!is_ksz8(dev)) {
+		ret = ksz_set_default_prio_queue_mapping(dev, port);
+		if (ret)
+			return ret;
+	}
+
 	/* port_stp_state_set() will be called after to enable the port so
 	 * there is no need to do anything.
 	 */
@@ -3566,8 +3593,7 @@ static int ksz_tc_ets_add(struct ksz_device *dev, int port,
 
 static int ksz_tc_ets_del(struct ksz_device *dev, int port)
 {
-	int ret, queue, tc_prio, s;
-	u32 queue_map = 0;
+	int ret, queue;
 
 	/* To restore the default chip configuration, set all queues to use the
 	 * WRR scheduler with a weight of 1.
@@ -3579,31 +3605,10 @@ static int ksz_tc_ets_del(struct ksz_device *dev, int port)
 			return ret;
 	}
 
-	switch (dev->info->num_tx_queues) {
-	case 2:
-		s = 2;
-		break;
-	case 4:
-		s = 1;
-		break;
-	case 8:
-		s = 0;
-		break;
-	default:
-		return -EINVAL;
-	}
-
 	/* Revert the queue mapping for TC-priority to its default setting on
 	 * the chip.
 	 */
-	for (tc_prio = 0; tc_prio < dev->info->max_ipvs; tc_prio++) {
-		int queue;
-
-		queue = tc_prio >> s;
-		queue_map |= queue << (tc_prio * KSZ9477_PORT_TC_MAP_S);
-	}
-
-	return ksz_pwrite32(dev, port, KSZ9477_PORT_MRI_TC_MAP__4, queue_map);
+	return ksz_set_default_prio_queue_mapping(dev, port);
 }
 
 static int ksz_tc_ets_validate(struct ksz_device *dev, int port,
-- 
2.39.2



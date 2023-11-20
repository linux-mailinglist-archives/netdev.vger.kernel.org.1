Return-Path: <netdev+bounces-49258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD0D87F1514
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 15:02:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 86785282590
	for <lists+netdev@lfdr.de>; Mon, 20 Nov 2023 14:02:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5194D1BDDF;
	Mon, 20 Nov 2023 14:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FtVrLqVD"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33ADD1BDC2
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 14:02:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CFE5C433CC;
	Mon, 20 Nov 2023 14:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700488925;
	bh=h1+hBG+HHVwQ0RwXweK1TgqeGFms2NK6HBD0zLnfwwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FtVrLqVDoRQZNMQ9wVx0WnuGJ6M2ZsME1xhmJXuK0bQOBParodvp4xe8/8XZP1aAG
	 WzaSG0KmquppWOblUpUtC8v0Ugq3EjSbanIfL3I+5GJl6DwBmMmncdJjkFvXP0Dhxv
	 K17fRcCzwIO9AQFeue1CMitW6qPZ2cL7BZAmVyy2Yj6X4W/PtExKIVbacsVr243vE9
	 XeNCAYKv0B63iMUN1O89DiuNjYEmnoJUhbU+9BR6iFD/3qSAtpVaxJvKKCdAoyMU7E
	 c+DDguVXakZdb86IGmxP5ThzTQ6V/2kgfkp7H8+ZIkAidJ6NAY9w0XBGex6hY8cApt
	 8tIzHT5TMrFbA==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: vladimir.oltean@nxp.com,
	s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	horms@kernel.org,
	p-varis@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Roger Quadros <rogerq@kernel.org>
Subject: [PATCH v6 net-next 3/7] net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
Date: Mon, 20 Nov 2023 16:01:43 +0200
Message-Id: <20231120140147.78726-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231120140147.78726-1-rogerq@kernel.org>
References: <20231120140147.78726-1-rogerq@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move this code to the end to avoid forward declaration.
No functional change.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 66 ++++++++++++-------------
 1 file changed, 33 insertions(+), 33 deletions(-)

v6: no change
v5: no change
v4: initial commit

diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 3539fb31541b..2d083eaea442 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -772,39 +772,6 @@ static int am65_cpsw_qos_setup_tc_block(struct net_device *ndev, struct flow_blo
 					  port, port, true);
 }
 
-int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
-			       void *type_data)
-{
-	switch (type) {
-	case TC_QUERY_CAPS:
-		return am65_cpsw_tc_query_caps(ndev, type_data);
-	case TC_SETUP_QDISC_TAPRIO:
-		return am65_cpsw_setup_taprio(ndev, type_data);
-	case TC_SETUP_BLOCK:
-		return am65_cpsw_qos_setup_tc_block(ndev, type_data);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
-void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
-{
-	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
-
-	am65_cpsw_est_link_up(ndev, link_speed);
-	port->qos.link_down_time = 0;
-}
-
-void am65_cpsw_qos_link_down(struct net_device *ndev)
-{
-	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
-
-	if (!port->qos.link_down_time)
-		port->qos.link_down_time = ktime_get();
-
-	port->qos.link_speed = SPEED_UNKNOWN;
-}
-
 static u32
 am65_cpsw_qos_tx_rate_calc(u32 rate_mbps, unsigned long bus_freq)
 {
@@ -916,3 +883,36 @@ void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common)
 		       host->port_base + AM65_CPSW_PN_REG_PRI_CIR(tx_ch));
 	}
 }
+
+int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
+			       void *type_data)
+{
+	switch (type) {
+	case TC_QUERY_CAPS:
+		return am65_cpsw_tc_query_caps(ndev, type_data);
+	case TC_SETUP_QDISC_TAPRIO:
+		return am65_cpsw_setup_taprio(ndev, type_data);
+	case TC_SETUP_BLOCK:
+		return am65_cpsw_qos_setup_tc_block(ndev, type_data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+
+	am65_cpsw_est_link_up(ndev, link_speed);
+	port->qos.link_down_time = 0;
+}
+
+void am65_cpsw_qos_link_down(struct net_device *ndev)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+
+	if (!port->qos.link_down_time)
+		port->qos.link_down_time = ktime_get();
+
+	port->qos.link_speed = SPEED_UNKNOWN;
+}
-- 
2.34.1



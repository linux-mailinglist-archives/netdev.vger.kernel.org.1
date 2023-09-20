Return-Path: <netdev+bounces-35234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CB917A7E32
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 14:16:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17DBE2817E9
	for <lists+netdev@lfdr.de>; Wed, 20 Sep 2023 12:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1CD31A68;
	Wed, 20 Sep 2023 12:15:40 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FA6C15AE7
	for <netdev@vger.kernel.org>; Wed, 20 Sep 2023 12:15:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFAF2C433C8;
	Wed, 20 Sep 2023 12:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695212139;
	bh=1oPS4RXR1qRlYTWkwg8XCNynAbh4/P2cvwtE58r78yY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOroctKLy1ic9YAW/t8Jr7+dtcE7JjAxchTjScAhKpFa5fcjrkyc/8mKUJie6Pjaf
	 E/HkBMVKG1/1YYkdcKY4drxzyl1vmjadq0kz1ToSDQmsp/0epBgMAVPFks9bbThiKW
	 Q7ko0Zhy21eqRyBtIXvvmGz0DiQTfrZq4dvid1RAUVxdCwKIlh+ozcvk9uKH52MRQC
	 431yqxU2kXZPU3YMXR5ZDsl4BT1BcDxrzlAKxJ6VzU3381lZTzPxb7LC75RuxiXbHf
	 F6jdCkbkw5ifMQtxQSkwBL+ktLsjTzCuTF12MKNGJIhQVhaCQWT970PGcbHKOoiaob
	 EQRqs5zw5VIew==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com
Cc: horms@kernel.org,
	s-vadapalli@ti.com,
	srk@ti.com,
	vigneshr@ti.com,
	p-varis@ti.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	rogerq@kernel.org
Subject: [PATCH net-next v4 1/3] net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
Date: Wed, 20 Sep 2023 15:15:28 +0300
Message-Id: <20230920121530.4710-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230920121530.4710-1-rogerq@kernel.org>
References: <20230920121530.4710-1-rogerq@kernel.org>
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
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 78 ++++++++++++-------------
 1 file changed, 39 insertions(+), 39 deletions(-)

Changelog:
v4: initial commit

diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 9ac2ff05d501..f91137d8e73b 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -787,45 +787,6 @@ static int am65_cpsw_qos_setup_tc_block(struct net_device *ndev, struct flow_blo
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
-	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
-		return;
-
-	am65_cpsw_est_link_up(ndev, link_speed);
-	port->qos.link_down_time = 0;
-}
-
-void am65_cpsw_qos_link_down(struct net_device *ndev)
-{
-	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
-
-	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
-		return;
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
@@ -937,3 +898,42 @@ void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common)
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
+	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
+		return;
+
+	am65_cpsw_est_link_up(ndev, link_speed);
+	port->qos.link_down_time = 0;
+}
+
+void am65_cpsw_qos_link_down(struct net_device *ndev)
+{
+	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
+
+	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
+		return;
+
+	if (!port->qos.link_down_time)
+		port->qos.link_down_time = ktime_get();
+
+	port->qos.link_speed = SPEED_UNKNOWN;
+}
-- 
2.34.1



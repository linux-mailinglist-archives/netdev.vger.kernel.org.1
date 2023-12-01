Return-Path: <netdev+bounces-52935-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5748D800CB1
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 14:58:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9C1BB21311
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 13:58:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD6F33C69B;
	Fri,  1 Dec 2023 13:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NGT/ZaKZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A14C43C687
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 13:58:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18047C433CC;
	Fri,  1 Dec 2023 13:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701439099;
	bh=EH8S4/qvgFCbuF7wfNq/md/Ks8pZhk0rH0rxRMxbmZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NGT/ZaKZ/4DM6dVAGQdky5dVwLYezpCphiuUMezcM0lneJ3+8k5TbT1XmzNq5v0rM
	 bDAaZ0ugN8Frm/n0CHeyd/nCT5Kqy25tdIqbb/deKcSGFMK1yBFzoJ6Yaupc91xu2f
	 +xD1Kc6/er0GJxQldOBGRhXRNhSQMnmgsTSVZ1UK3D2XGzQVTFchCZYqKkDlieGevR
	 9FVBut8XiaLw0Z++vVVOlxga6Ssp7gdr9+kboJelv6/dKD1orYqksOXp187MvvvRXC
	 Uv/BFm59tR8uECqQ/qmC+AzztfrjfxeBqPKxCkMEVzH3uVW/AfSrUq96aZkJSdTMOD
	 Are+bvcDOQD6w==
From: Roger Quadros <rogerq@kernel.org>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vladimir.oltean@nxp.com
Cc: s-vadapalli@ti.com,
	r-gunasekaran@ti.com,
	vigneshr@ti.com,
	srk@ti.com,
	horms@kernel.org,
	p-varis@ti.com,
	netdev@vger.kernel.org,
	rogerq@kernel.org
Subject: [PATCH v7 net-next 3/8] net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
Date: Fri,  1 Dec 2023 15:57:57 +0200
Message-Id: <20231201135802.28139-4-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231201135802.28139-1-rogerq@kernel.org>
References: <20231201135802.28139-1-rogerq@kernel.org>
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
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 86 ++++++++++++-------------
 1 file changed, 43 insertions(+), 43 deletions(-)

Changelog

v7: move am65_cpsw_qos_tx_rate_calc()
v6: no change
v5: no change
v4: initial commit

diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 3d4773af783a..d468a6856a85 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -56,6 +56,16 @@ enum timer_act {
 	TACT_SKIP_PROG,		/* just buffer can be updated */
 };
 
+static u32
+am65_cpsw_qos_tx_rate_calc(u32 rate_mbps, unsigned long bus_freq)
+{
+	u32 ir;
+
+	bus_freq /= 1000000;
+	ir = DIV_ROUND_UP(((u64)rate_mbps * 32768),  bus_freq);
+	return ir;
+}
+
 static int am65_cpsw_port_est_enabled(struct am65_cpsw_port *port)
 {
 	return port->qos.est_oper || port->qos.est_admin;
@@ -772,49 +782,6 @@ static int am65_cpsw_qos_setup_tc_block(struct net_device *ndev, struct flow_blo
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
-static u32
-am65_cpsw_qos_tx_rate_calc(u32 rate_mbps, unsigned long bus_freq)
-{
-	u32 ir;
-
-	bus_freq /= 1000000;
-	ir = DIV_ROUND_UP(((u64)rate_mbps * 32768),  bus_freq);
-	return ir;
-}
-
 static void
 am65_cpsw_qos_tx_p0_rate_apply(struct am65_cpsw_common *common,
 			       int tx_ch, u32 rate_mbps)
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



Return-Path: <netdev+bounces-36428-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5FE7AFC0C
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 09:27:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 2DCFD281C8B
	for <lists+netdev@lfdr.de>; Wed, 27 Sep 2023 07:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E179714AA4;
	Wed, 27 Sep 2023 07:27:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D215E1C2B2
	for <netdev@vger.kernel.org>; Wed, 27 Sep 2023 07:27:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 679A6C433CA;
	Wed, 27 Sep 2023 07:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695799671;
	bh=zf7X1VsM2p6DLshh21G/x4EyyUc9kf8AVM6Iw7AWlMM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jebzA6NNsRVeCxS5xU4oegqaX41KTORzsmRaXa/ZOq3WFga7T3Iu8d8nLifKHqOWD
	 BWNqk5VdgD6w058hDo8bMSZp0ZBbBzahvFY8wDiNs3BXLg8GI6ngEDEecWHVt4dZHH
	 42ghehZ8Rc3lEGF5aiD0BdVOJIEXupddz0gdekkHioz4qqfHs4JV3M9UZ4cNxZrXJo
	 ZyenBb1qjXDedkPxwtL9MXmVdDDys08q2YK1FMaL6aKiW5bnzjGcjD3GjCxVfn5UEP
	 EtG8T6/WZqlxqtlGBuQlKBhosjG3WwCxi5DoEEd79kv12iJxGByhhdLjRnkt52UnsD
	 iMug78dcxuzHA==
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
Subject: [PATCH v5 net-next 1/4] net: ethernet: ti: am65-cpsw: Move code to avoid forward declaration
Date: Wed, 27 Sep 2023 10:27:38 +0300
Message-Id: <20230927072741.21221-2-rogerq@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927072741.21221-1-rogerq@kernel.org>
References: <20230927072741.21221-1-rogerq@kernel.org>
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
v5: no change
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



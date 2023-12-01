Return-Path: <netdev+bounces-52933-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B24E6800CAE
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 14:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E425D1C20FFE
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 13:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C723C475;
	Fri,  1 Dec 2023 13:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BCgMFohY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A3653B2B5
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 13:58:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06717C433CD;
	Fri,  1 Dec 2023 13:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701439092;
	bh=hBEaP5cqPwHBKpUjg2xhkI6CSCwL+6TCFQvZrrXCSag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BCgMFohY8LdL7uYOtE683uWQcKwV+Osf1WdV5+tsHYQn6TamB4KC4eTji2dr7MHOE
	 zm/tEzT4k3sONVIx2Ks6fk5M8RQFtovl/6KeNHsDuFIaWRV1zdDDfvSPIfAqb6RinJ
	 wQV3BzycjVjDJqc5qITJhwAtYMoBd0FSajTvAFoDKXzZBkP3c3R+GaJQEzfnMeYNXG
	 9YwRFHnRBou2KGKEp4EEkEiBCjOJgmSJVfqcrja/W1X5Apfra+QkQKc79E7ABrEg3R
	 vAB5s0LtFBqNLTXOn8oObOeC3XAaplNPbg2rH+tK8yY+AFzm5BbJrELp7tUuKLl9u8
	 fO6rXKeVjBJvA==
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
Subject: [PATCH v7 net-next 1/8] net: ethernet: am65-cpsw: Build am65-cpsw-qos only if required
Date: Fri,  1 Dec 2023 15:57:55 +0200
Message-Id: <20231201135802.28139-2-rogerq@kernel.org>
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

Build am65-cpsw-qos only if CONFIG_TI_AM65_CPSW_TAS is enabled.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/net/ethernet/ti/Makefile        |  3 ++-
 drivers/net/ethernet/ti/am65-cpsw-qos.c | 12 ------------
 drivers/net/ethernet/ti/am65-cpsw-qos.h | 26 +++++++++++++++++++++++++
 3 files changed, 28 insertions(+), 13 deletions(-)

Changelog:

v7: no change
v6: initial commit

diff --git a/drivers/net/ethernet/ti/Makefile b/drivers/net/ethernet/ti/Makefile
index 27de1d697134..9d7cd84d1e2d 100644
--- a/drivers/net/ethernet/ti/Makefile
+++ b/drivers/net/ethernet/ti/Makefile
@@ -26,7 +26,8 @@ keystone_netcp_ethss-y := netcp_ethss.o netcp_sgmii.o netcp_xgbepcsr.o cpsw_ale.
 obj-$(CONFIG_TI_K3_CPPI_DESC_POOL) += k3-cppi-desc-pool.o
 
 obj-$(CONFIG_TI_K3_AM65_CPSW_NUSS) += ti-am65-cpsw-nuss.o
-ti-am65-cpsw-nuss-y := am65-cpsw-nuss.o cpsw_sl.o am65-cpsw-ethtool.o cpsw_ale.o am65-cpsw-qos.o
+ti-am65-cpsw-nuss-y := am65-cpsw-nuss.o cpsw_sl.o am65-cpsw-ethtool.o cpsw_ale.o
+ti-am65-cpsw-nuss-$(CONFIG_TI_AM65_CPSW_TAS) += am65-cpsw-qos.o
 ti-am65-cpsw-nuss-$(CONFIG_TI_K3_AM65_CPSW_SWITCHDEV) += am65-cpsw-switchdev.o
 obj-$(CONFIG_TI_K3_AM65_CPTS) += am65-cpts.o
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.c b/drivers/net/ethernet/ti/am65-cpsw-qos.c
index 9ac2ff05d501..4bc611cc4aad 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.c
@@ -571,9 +571,6 @@ static int am65_cpsw_setup_taprio(struct net_device *ndev, void *type_data)
 	    taprio->cmd != TAPRIO_CMD_DESTROY)
 		return -EOPNOTSUPP;
 
-	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
-		return -ENODEV;
-
 	if (!netif_running(ndev)) {
 		dev_err(&ndev->dev, "interface is down, link speed unknown\n");
 		return -ENETDOWN;
@@ -599,9 +596,6 @@ static int am65_cpsw_tc_query_caps(struct net_device *ndev, void *type_data)
 	case TC_SETUP_QDISC_TAPRIO: {
 		struct tc_taprio_caps *caps = base->caps;
 
-		if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
-			return -EOPNOTSUPP;
-
 		caps->gate_mask_per_txq = true;
 
 		return 0;
@@ -806,9 +800,6 @@ void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 
-	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
-		return;
-
 	am65_cpsw_est_link_up(ndev, link_speed);
 	port->qos.link_down_time = 0;
 }
@@ -817,9 +808,6 @@ void am65_cpsw_qos_link_down(struct net_device *ndev)
 {
 	struct am65_cpsw_port *port = am65_ndev_to_port(ndev);
 
-	if (!IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS))
-		return;
-
 	if (!port->qos.link_down_time)
 		port->qos.link_down_time = ktime_get();
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-qos.h b/drivers/net/ethernet/ti/am65-cpsw-qos.h
index 0cc2a3b3d7f9..898f13a4a112 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-qos.h
+++ b/drivers/net/ethernet/ti/am65-cpsw-qos.h
@@ -31,11 +31,37 @@ struct am65_cpsw_qos {
 	struct am65_cpsw_ale_ratelimit ale_mc_ratelimit;
 };
 
+#if IS_ENABLED(CONFIG_TI_AM65_CPSW_TAS)
 int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev, enum tc_setup_type type,
 			       void *type_data);
 void am65_cpsw_qos_link_up(struct net_device *ndev, int link_speed);
 void am65_cpsw_qos_link_down(struct net_device *ndev);
 int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev, int queue, u32 rate_mbps);
 void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common);
+#else
+static inline int am65_cpsw_qos_ndo_setup_tc(struct net_device *ndev,
+					     enum tc_setup_type type,
+					     void *type_data)
+{
+	return -EOPNOTSUPP;
+}
+
+static inline void am65_cpsw_qos_link_up(struct net_device *ndev,
+					 int link_speed)
+{ }
+
+static inline void am65_cpsw_qos_link_down(struct net_device *ndev)
+{ }
+
+static inline int am65_cpsw_qos_ndo_tx_p0_set_maxrate(struct net_device *ndev,
+						      int queue,
+						      u32 rate_mbps)
+{
+	return 0;
+}
+
+static inline void am65_cpsw_qos_tx_p0_rate_init(struct am65_cpsw_common *common)
+{ }
+#endif
 
 #endif /* AM65_CPSW_QOS_H_ */
-- 
2.34.1



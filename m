Return-Path: <netdev+bounces-223852-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B34F4B7DD53
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 14:35:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FA263AB43B
	for <lists+netdev@lfdr.de>; Wed, 17 Sep 2025 04:15:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE1E22F5495;
	Wed, 17 Sep 2025 04:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="kLEzSw6i"
X-Original-To: netdev@vger.kernel.org
Received: from lelvem-ot02.ext.ti.com (lelvem-ot02.ext.ti.com [198.47.23.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC7E2D662D;
	Wed, 17 Sep 2025 04:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758082516; cv=none; b=s3k5dLP9sFVnVF2fQApJmxTgIr4Z+X6guAKY0XjBPgCfY/zO3rDnzodKMELh3UzQW3H17J/AjM0pnCe9jJtZcq/UCC3ZtDiBQXQEWoc2zyevUl7EmMQIw/fVjo5QDFESeAjrObpUmKdId33ZfZlD0YI14MF7XR6NqnYbyWfGXos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758082516; c=relaxed/simple;
	bh=W+jjZRFUvAU5+On/hbnS9NnJUaN7fu/EYz8ycWU05Dw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A2gM+yWyENZS3P4gY/lCQ3q0si2q2UGNjO3WLAZJM8F8NmI4wVfbPQUy6Np6HMaeuN924juE7iliL56k5MMU+hthCY6nrcGhZt1GEM9fj6GsUi9anQ6NqDDA63xSv7DSvtazs7V28JTPKpG0pXklUYUwMAk3PRtGXbjMjbhIey8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=kLEzSw6i; arc=none smtp.client-ip=198.47.23.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by lelvem-ot02.ext.ti.com (8.15.2/8.15.2) with ESMTP id 58H4F11U165346;
	Tue, 16 Sep 2025 23:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1758082501;
	bh=+uv/YTCnVFZa15zdIfCTleWfru33UCe5C/1jjCWuVtY=;
	h=From:To:CC:Subject:Date;
	b=kLEzSw6iAfma2SwBkvFWQVw/rY1GTetXtPpTADs/IgglrdhUEFpluGQb8Tc4fuES1
	 2Q1qhnJ5VlSuq7FlDHoBT+MqA5bXaiFu3xF/trz5oMzuo34EWIpDfxmOkdR+ht0J1Y
	 A8+nGTPXsMzM2XADzct6g5ZEK9au8tmTUNuAO95g=
Received: from DLEE115.ent.ti.com (dlee115.ent.ti.com [157.170.170.26])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 58H4F1Mb1035787
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Tue, 16 Sep 2025 23:15:01 -0500
Received: from DLEE210.ent.ti.com (157.170.170.112) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Tue, 16
 Sep 2025 23:15:00 -0500
Received: from lelvem-mr05.itg.ti.com (10.180.75.9) by DLEE210.ent.ti.com
 (157.170.170.112) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Sep 2025 23:15:00 -0500
Received: from uda0513920.dhcp.ti.com (uda0513920.dhcp.ti.com [10.24.69.90])
	by lelvem-mr05.itg.ti.com (8.18.1/8.18.1) with ESMTP id 58H4Euvt2685334;
	Tue, 16 Sep 2025 23:14:56 -0500
From: vishnu singh <v-singh1@ti.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <richardcochran@gmail.com>,
        <rogerq@kernel.org>, <horms@kernel.org>, <mwalle@kernel.org>,
        <alexander.sverdlin@gmail.com>, <npitre@baylibre.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <c-vankar@ti.com>
Subject: [PATCH] net: ti: am65-cpsw: Update hw timestamping filter for PTPv1 RX packets
Date: Wed, 17 Sep 2025 09:44:55 +0530
Message-ID: <20250917041455.1815579-1-v-singh1@ti.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Vishnu Singh <v-singh1@ti.com>

CPTS module of CPSW supports hardware timestamping of PTPv1 packets.Update
the "hwtstamp_rx_filters" of CPSW driver to enable timestamping of received
PTPv1 packets. Also update the advertised capability to include PTPv1.

Signed-off-by: Vishnu Singh <v-singh1@ti.com>
---
 drivers/net/ethernet/ti/am65-cpsw-ethtool.c | 27 ++++++++++++---------
 drivers/net/ethernet/ti/am65-cpsw-nuss.c    |  9 ++++---
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
index 9032444435e9..c57497074ae6 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-ethtool.c
@@ -694,17 +694,20 @@ static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
 					 struct kernel_ethtool_ts_info *info)
 {
 	struct am65_cpsw_common *common = am65_ndev_to_common(ndev);
-	unsigned int ptp_v2_filter;
-
-	ptp_v2_filter = BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT)	 |
-			BIT(HWTSTAMP_FILTER_PTP_V2_L4_SYNC)	 |
-			BIT(HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ) |
-			BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT)	 |
-			BIT(HWTSTAMP_FILTER_PTP_V2_L2_SYNC)	 |
-			BIT(HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ) |
-			BIT(HWTSTAMP_FILTER_PTP_V2_EVENT)	 |
-			BIT(HWTSTAMP_FILTER_PTP_V2_SYNC)	 |
-			BIT(HWTSTAMP_FILTER_PTP_V2_DELAY_REQ);
+	unsigned int ptp_filter;
+
+	ptp_filter = BIT(HWTSTAMP_FILTER_PTP_V2_L4_EVENT)	|
+		     BIT(HWTSTAMP_FILTER_PTP_V2_L4_SYNC)	|
+		     BIT(HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ)	|
+		     BIT(HWTSTAMP_FILTER_PTP_V2_L2_EVENT)	|
+		     BIT(HWTSTAMP_FILTER_PTP_V2_L2_SYNC)	|
+		     BIT(HWTSTAMP_FILTER_PTP_V2_L2_DELAY_REQ)	|
+		     BIT(HWTSTAMP_FILTER_PTP_V2_EVENT)		|
+		     BIT(HWTSTAMP_FILTER_PTP_V2_SYNC)		|
+		     BIT(HWTSTAMP_FILTER_PTP_V2_DELAY_REQ)	|
+		     BIT(HWTSTAMP_FILTER_PTP_V1_L4_EVENT)	|
+		     BIT(HWTSTAMP_FILTER_PTP_V1_L4_SYNC)	|
+		     BIT(HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ);
 
 	if (!IS_ENABLED(CONFIG_TI_K3_AM65_CPTS))
 		return ethtool_op_get_ts_info(ndev, info);
@@ -716,7 +719,7 @@ static int am65_cpsw_get_ethtool_ts_info(struct net_device *ndev,
 		SOF_TIMESTAMPING_RAW_HARDWARE;
 	info->phc_index = am65_cpts_phc_index(common->cpts);
 	info->tx_types = BIT(HWTSTAMP_TX_OFF) | BIT(HWTSTAMP_TX_ON);
-	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | ptp_v2_filter;
+	info->rx_filters = BIT(HWTSTAMP_FILTER_NONE) | ptp_filter;
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 8b2364f5f731..110eb2da8dbc 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -1813,6 +1813,9 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 	case HWTSTAMP_FILTER_NONE:
 		port->rx_ts_enabled = false;
 		break;
+	case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
+	case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
+	case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 	case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
 	case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
@@ -1823,7 +1826,7 @@ static int am65_cpsw_nuss_hwtstamp_set(struct net_device *ndev,
 	case HWTSTAMP_FILTER_PTP_V2_SYNC:
 	case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 		port->rx_ts_enabled = true;
-		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+		cfg.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT | HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 		break;
 	case HWTSTAMP_FILTER_ALL:
 	case HWTSTAMP_FILTER_SOME:
@@ -1884,8 +1887,8 @@ static int am65_cpsw_nuss_hwtstamp_get(struct net_device *ndev,
 	cfg.flags = 0;
 	cfg.tx_type = port->tx_ts_enabled ?
 		      HWTSTAMP_TX_ON : HWTSTAMP_TX_OFF;
-	cfg.rx_filter = port->rx_ts_enabled ?
-			HWTSTAMP_FILTER_PTP_V2_EVENT : HWTSTAMP_FILTER_NONE;
+	cfg.rx_filter = port->rx_ts_enabled ? HWTSTAMP_FILTER_PTP_V2_EVENT |
+			HWTSTAMP_FILTER_PTP_V1_L4_EVENT : HWTSTAMP_FILTER_NONE;
 
 	return copy_to_user(ifr->ifr_data, &cfg, sizeof(cfg)) ? -EFAULT : 0;
 }
-- 
2.50.1



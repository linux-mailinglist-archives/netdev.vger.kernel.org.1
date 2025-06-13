Return-Path: <netdev+bounces-197580-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 794B9AD93E0
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:43:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D2071BC06B3
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:43:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 785B82253BC;
	Fri, 13 Jun 2025 17:43:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DLLlyY/O"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED9492135DE;
	Fri, 13 Jun 2025 17:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749836583; cv=fail; b=TnfSlIeEnPBNe7PZeKKZe4ugGc3HvHDGpxJ6gqdIQXn4jLbm9I7ZqgdbLDQwHhWVO9WV1N1Na9b8qbo5ZWL71IRmnz+uZIBCi1YkXWvL9f6e0Db0TxZUGe43+gNSOFR6hU5WrKvXzkcvMY+TYI68Z4KJG3xZIm+RSlRL25kqnmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749836583; c=relaxed/simple;
	bh=KS0tM/JNpYysYqDT6jQrluChajYtZiDgFE2nJoMBZa0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GNjJZ1WSa2haZT2PNAnwaJWstPCvP29aWoPMpkCHYbAkRWJMT1jqawOl+RwSDCYX4bLX9iYiotua8/+BfInuOpG3Mlr9qLc+oGF9mdSbdgARrPdC0emG2qpVj38pFjO/v5E838RxChG4JPV+5kqGPFAXfOuk2TxPiq5H3IpAKf0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DLLlyY/O; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=whkxjh1z5IAmvUINPJPrmdhLNXpQSGPHko5i4jA/WhcLUEqrU37Rq80g6nHq53O1j78wBZLiir3Q34rtMh2bSN7zeyIGPEZG19JkvJ/LDiY0KIRt3S5Xiui0q9CJOzR9N6QxXx+9QLYOeHIDJ/eibJHIf+HxpvRJTmbFEWJFnOuGBGWKqYVsIb3wf5OG/l3UZA6HSnqc39OzwpL1CgC+qk4vOFDRieHV5BQwipXWvuuGum6biEI3u7ODZk1DBeQyZbNZHyL/RelHvBqE6mjP821yeG1lnIC52NlH6smQqZvfjGIPYu29HeV/w7J8pb70bVtruzk/oVAHye2ET8PPFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6SVS+FUXLE26ysfJHzcb/LMI27WpBl37ZHmlvHHMyqs=;
 b=HTI90980VE4zQwyXZdlHiGCU8qG0ajrVK3ynCRp2B8vvOh0daQZXY/huvvEg7tvK16D5pJi6bm3wHvhnL/xZPBwnpsbmbeXU/icseeEDDJt8EmTYdvrsw2mOMexVW1b2iW7adp4hCsASQ3fTLCw5B2OiiMDpaEr/yzAkD/2xVOUZAltYl9pAmMoKkibq2LzHkECwi+tKEmlWT2ZCI6ujCGo5dW+slXJahoR/n97w3GIH2Fsbx8TRpPIoXrdGO30BRhoqA6//fdd7nQrSKOpSgNPNB+wNhz+Gm1U8OdEkCGvpOFeTq58SGXBlxfyXiOk2rmlIIs8Fa7A5Y94uoo0WSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=lunn.ch smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6SVS+FUXLE26ysfJHzcb/LMI27WpBl37ZHmlvHHMyqs=;
 b=DLLlyY/OvqgtETUIl1cjR0PAqy2bMSVhoyTxP1RfYq82rYt7l0vEqIusoC/gcJUINFn0MQQrPp9+0LYN18ZmNZaGzhIh87ll9rVTisE1FGwqZwvObA9jwFTsKHr+lxs5ZQJpbIASLajLgFICFz93flREHT93mT8OK/xaw/cj3Zyl/Ypo60WXPfm1U2QU+rUlGFVMYnGlrZwcm89NsDPyCHIQh+Wv3uzOTd8L5Cl93y/57rYaKNeGi6dZOgjHCrR7PbrLX9qapWZQc3WaptW1zdJcr7nreN0HT2elgB3sSwf4BCLr5ESiE7SbtmGMc70PALHjOJMjmO1XsmRN4/gUSQ==
Received: from MN2PR22CA0025.namprd22.prod.outlook.com (2603:10b6:208:238::30)
 by SJ2PR12MB9161.namprd12.prod.outlook.com (2603:10b6:a03:566::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.23; Fri, 13 Jun
 2025 17:42:59 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:208:238:cafe::69) by MN2PR22CA0025.outlook.office365.com
 (2603:10b6:208:238::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.22 via Frontend Transport; Fri,
 13 Jun 2025 17:42:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.15 via Frontend Transport; Fri, 13 Jun 2025 17:42:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 13 Jun
 2025 10:42:37 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 13 Jun
 2025 10:42:36 -0700
Received: from vdi.nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Fri, 13
 Jun 2025 10:42:36 -0700
From: David Thompson <davthompson@nvidia.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <asmaa@nvidia.com>,
	<u.kleine-koenig@baylibre.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, David Thompson
	<davthompson@nvidia.com>
Subject: [PATCH net-next v1] mlxbf_gige: emit messages during open and probe failures
Date: Fri, 13 Jun 2025 17:42:28 +0000
Message-ID: <20250613174228.1542237-1-davthompson@nvidia.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|SJ2PR12MB9161:EE_
X-MS-Office365-Filtering-Correlation-Id: a455ef26-276a-42be-ef03-08ddaaa1bc7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/WW0BmZucBrexG7ScXFfqt7lVe4KQD/bMIbMIkFBy71blji54LMJ15SV4Aae?=
 =?us-ascii?Q?fmRp2qGdTSq3KK+NgqiV/pq3AqIegVXsaWrbz8HqyQtE+tNiZ/pMzZB7FeWR?=
 =?us-ascii?Q?sUNK4m/Vpaw0SlCTjaBMhmTw22HXPlzTi3PwV16IRpzkR97ST2xb/7mLsUeq?=
 =?us-ascii?Q?/du08nuH1D19wB1n0dTTOgHa5ruTXI+lWQfbG2N09G0rskxLtr+kcz1PE5Vk?=
 =?us-ascii?Q?h+cf/NK3i5q713fJzk3JO4ZrfM6FuPI8ICpXmfRYbqaWxUj6tm7xHMqEHwMb?=
 =?us-ascii?Q?t35krBGCYB3nKf6EXlEXRlscKJhS4ZsfORyxQ0venFT15fuqoWivknZCkEYD?=
 =?us-ascii?Q?JewGJtmbKFG5nJSWxrV8x7M5KSssqri94te69Abf1bnQPW/xcXyVak84bxKX?=
 =?us-ascii?Q?m5ZRpjv8GcyoHOKo7BazykLRTVGTdESubsFdoOY+IdXprqD/A8xzzE5iTNVs?=
 =?us-ascii?Q?SSmH6jIsEEJqSi2OdZnS4NDXA/WwFm43mSe5Hd506iU36bdN/vRNt29Wm4Zo?=
 =?us-ascii?Q?DTunxXAPYz7/fLJNM/30hlQmVVvgKA51k2hnh1j3JFsug6XgndDfYL2X5KXh?=
 =?us-ascii?Q?UXnjxXaN7DdhUfeUAfdJP3f8wAo55nIV1CIZJgg3Q4oJVPtNxTTC545XN5GP?=
 =?us-ascii?Q?P8n44VMoFINyonESS3U6Obrxcv8KMo5Waqb9XtftpVlbQixpAmhOaiKlJxdb?=
 =?us-ascii?Q?pLjY6HWxgaxhODD7rt9HaKAcI3LXlWDmo3sPZcHAHBFfcMoY4uYd+Zbs8cL/?=
 =?us-ascii?Q?g91RmHFxMAjrQL2At2MWxj1DbYOC4j8xNJJZrWv+PqtjO22G6RkHSHUkRyDm?=
 =?us-ascii?Q?s0VPMFqCy5Px1eFjJD1HoZLJ8iRTBM3qZ5Gdj4XbQ3Bo3zNNSFyG6BHIJ983?=
 =?us-ascii?Q?6srrUOoVo8aSM5M7PP9cXKms52xv980PTPfj4KS3JSKbQ/Gl80Jxin+fsNUO?=
 =?us-ascii?Q?mwQ7uaQwtiOVPv7d5WLfLsuctCpU5ZdVebISRGo6hmOVsd/B0lTCKBt9gVuN?=
 =?us-ascii?Q?maM3Oa8PJuFC0RaQFk/JfR2MlcqIN8sXdTMY3WeopRHasWwbWuBCIi//sfJD?=
 =?us-ascii?Q?odjvLxnzrxL30+QiAm4oT2Gq4N0niuNKz7vrtn3V2OVSSbAQQpkEZ73cQo5O?=
 =?us-ascii?Q?1ZJoVTIWAbwrEas+hX494dQc12F4hOb1gTidxDDb/nQjrDN9n3lQxopICx9U?=
 =?us-ascii?Q?sVmtzOb8fFF20OYBM0VPMIAXYTk3Bgea+bHSa4+eeD5TCcqqcD9sVRRxukc+?=
 =?us-ascii?Q?SsP93s7nU/jy/nGNwHEUYRPzsBqWYPfvYTeK/P3RaA5a+iScjXdre6j40QFv?=
 =?us-ascii?Q?p8nm2yoH2SjhpOw+WUsy91UIPYV24JrLNRNZ631159Ab8511G+KaXr5Ec6Dv?=
 =?us-ascii?Q?SaSZvslbSTPquEHvWgUJQ5Xtkw7LdL6sCENf9Xllsr1nvdgsihGdcrHZExGk?=
 =?us-ascii?Q?/N8epI61JP5l/M/lRFrZkjoUqnTeTxWaQ3IbvZyX9CXOGk76JZwhg1HeYQzP?=
 =?us-ascii?Q?k/RrfU/b/e6iiFF66VJIhZLjp8WBcuCG06Xw?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 17:42:58.3300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a455ef26-276a-42be-ef03-08ddaaa1bc7d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9161

The open() and probe() functions of the mlxbf_gige driver
check for errors during initialization, but do not provide
details regarding the errors. The mlxbf_gige driver should
provide error details in the kernel log, noting what step
of initialization failed.

Signed-off-by: David Thompson <davthompson@nvidia.com>
---
 .../mellanox/mlxbf_gige/mlxbf_gige_main.c     | 20 ++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
index fb2e5b844c15..ba0ed4170b82 100644
--- a/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
+++ b/drivers/net/ethernet/mellanox/mlxbf_gige/mlxbf_gige_main.c
@@ -142,8 +142,10 @@ static int mlxbf_gige_open(struct net_device *netdev)
 
 	mlxbf_gige_cache_stats(priv);
 	err = mlxbf_gige_clean_port(priv);
-	if (err)
+	if (err) {
+		dev_err(priv->dev, "open: clean_port failed, err=0x%x\n", err);
 		return err;
+	}
 
 	/* Clear driver's valid_polarity to match hardware,
 	 * since the above call to clean_port() resets the
@@ -154,19 +156,25 @@ static int mlxbf_gige_open(struct net_device *netdev)
 	phy_start(phydev);
 
 	err = mlxbf_gige_tx_init(priv);
-	if (err)
+	if (err) {
+		dev_err(priv->dev, "open: tx_init failed, err=0x%x\n", err);
 		goto phy_deinit;
+	}
 	err = mlxbf_gige_rx_init(priv);
-	if (err)
+	if (err) {
+		dev_err(priv->dev, "open: rx_init failed, err=0x%x\n", err);
 		goto tx_deinit;
+	}
 
 	netif_napi_add(netdev, &priv->napi, mlxbf_gige_poll);
 	napi_enable(&priv->napi);
 	netif_start_queue(netdev);
 
 	err = mlxbf_gige_request_irqs(priv);
-	if (err)
+	if (err) {
+		dev_err(priv->dev, "open: request_irqs failed, err=0x%x\n", err);
 		goto napi_deinit;
+	}
 
 	mlxbf_gige_enable_mac_rx_filter(priv, MLXBF_GIGE_BCAST_MAC_FILTER_IDX);
 	mlxbf_gige_enable_mac_rx_filter(priv, MLXBF_GIGE_LOCAL_MAC_FILTER_IDX);
@@ -418,8 +426,10 @@ static int mlxbf_gige_probe(struct platform_device *pdev)
 
 	/* Attach MDIO device */
 	err = mlxbf_gige_mdio_probe(pdev, priv);
-	if (err)
+	if (err) {
+		dev_err(priv->dev, "probe: mdio_probe failed, err=0x%x\n", err);
 		return err;
+	}
 
 	priv->base = base;
 	priv->llu_base = llu_base;
-- 
2.43.2



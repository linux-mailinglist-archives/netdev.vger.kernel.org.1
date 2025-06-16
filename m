Return-Path: <netdev+bounces-198027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A558ADADA0
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 12:43:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 864903A1AA5
	for <lists+netdev@lfdr.de>; Mon, 16 Jun 2025 10:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF9325E813;
	Mon, 16 Jun 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J1nzufOG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1C273806;
	Mon, 16 Jun 2025 10:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750070582; cv=fail; b=iefAk+GRnGigDrEvXgusIk9aJVhmavx5NqP8FwTmppPttSN2M00T16bPEj9xNIfo88RzOj0x6XXG7nR0Zes1ezFUIrrD9YatKclJQPd7sdjAww1HAMfG7XS5MLh2o6oHRlIaCxmcjbvRZ+RFsX2AocQbcVJ75gvaBSwl2nDWd+c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750070582; c=relaxed/simple;
	bh=ELvd/u+TY8JejsRGEsjR6jo3LNOnPL83TS18dON8zjA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EJD3QZ+enKrV08qDtFZgkJgXxZXhwhK6klUTrjoVo1nSSgNcvjPdRsQ+dBUJVQXzekPdawPQyH+r2bvfPg3ztjRDRLApaECELh/lT9/qubVpSKA2PEnCFZzwr2vF4FGYhVpyjUAo5PWDqIoDJsDK9TX32e2jzDs1Bban+xnuKBg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J1nzufOG; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jlvp3sVDg+lw+RRVqGl1YOWqGviDOyV6IlPK90lZcXiK+8SRcFsWScJ3Wg7zAhUauCkwKaLNN4woab1R5YYKu4QA35YoRoppsUPAMbVEzp/rg4pdVHg/ROPfWjhTfYIR5JgLkHelReu1XlGBZTS00OYUKqJbwiEWbv3snamrLpNCPX0ZjxC4+eSvJeWOuzrHBthm0azOzJiZIoFdHqbw8AXa8nW0gDoPlvo/pzBclDJY9O/0lN6khXWUlvIWoqNhBWfo+lKrKELYLs53jgROBjStX93Osrra67BqEBBCIdADgFqO3u3myPNUUeWkz1dCgkJ3BL7FGdZTDc+Vr0A/LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX+AC5+Or0u6pBqjdb6N2b+GBct+chKwl4YvpIx+34A=;
 b=XOeq+e6ImuAJ+dCCYj8DHP48962QBXJJuBQ3kQhDkR72WkJmCKCJ5NUpmoYWvRGi700Qg0f0tHnSNPfAw3skTKYom7nj5DVEEASfWNPAgltAoaZeBKf2EI/Z9rQRB58W4+3Ba+J7Ashkvam40bnfUJfkZ8uOUQkvFWVvvvGqQrzK/pEXqh7JsZ3MXOSTlxpv7DcHrfQqC+fGTesnwQLR5pIzlc3zOg+/Z1PM63Z8scZO74d2SBno/r6DYnBwR1yOLiaQZsnIIVANt3BY6ioqGgNoplPYnZt4XlESAK79mG+N1rg82wNt62N4exxetv82oOeKS7fhvhHy/ute4qU7RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX+AC5+Or0u6pBqjdb6N2b+GBct+chKwl4YvpIx+34A=;
 b=J1nzufOGa9ZOB6eHFiqwB0GRQJ67LMN5jF+acBkUE+hv75R5c7JNvXOaL/YGQ2NWk5Jq1Q/I0bj9EDZegcQ+EaGoCM8loutYDEYdMVAZlhlxUW41rBgi7BxTHh1UD1+f7ewjWy9xPPRtI/GdLZ0Q+jRI94XjBYLAs2Q683bBDiY=
Received: from SN6PR08CA0021.namprd08.prod.outlook.com (2603:10b6:805:66::34)
 by LV8PR12MB9619.namprd12.prod.outlook.com (2603:10b6:408:2a1::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.30; Mon, 16 Jun
 2025 10:42:56 +0000
Received: from SN1PEPF0002636E.namprd02.prod.outlook.com
 (2603:10b6:805:66:cafe::8e) by SN6PR08CA0021.outlook.office365.com
 (2603:10b6:805:66::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.19 via Frontend Transport; Mon,
 16 Jun 2025 10:42:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636E.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8835.15 via Frontend Transport; Mon, 16 Jun 2025 10:42:55 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Jun
 2025 05:42:52 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Vishal Badole <Vishal.Badole@amd.com>
Subject: [PATCH net-next] amd-xgbe: Configure and retrieve 'tx-usecs' for Tx coalescing
Date: Mon, 16 Jun 2025 16:12:32 +0530
Message-ID: <20250616104232.973813-1-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636E:EE_|LV8PR12MB9619:EE_
X-MS-Office365-Filtering-Correlation-Id: d0edf8d8-6f33-4dbe-69fb-08ddacc28dd9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fi6qOl6V20DDp9U+vbsV5bENBK84mM28QcaNw0diZOdfcogOrV54x3soJnpZ?=
 =?us-ascii?Q?meblPMFuo/eVBobk8hn+cLbIcGL0MdH4kjeaUN8/2bkPX/BvPgei8UD+AB5Q?=
 =?us-ascii?Q?BM4kkPK+SIEcKIIQZICZiXks3av5vQ448Gst2GEKUCkjTVNkNnMHZGxh6Ws/?=
 =?us-ascii?Q?pXZOeQamhLL1XGn0R68YYy0T6C4b3dGR1nIa55nMJbJsZf+0wYooOzn6yrOv?=
 =?us-ascii?Q?Vf1+B5ef/9iC9JOiJjjjeJrThvPMKZDX+65VlqqttB/HERu7s9kfFOW7VT6s?=
 =?us-ascii?Q?ooDJE/aMqkxF6uV+0k1TgMpo7waP3dRw0jIMGzSGjlJqHGJSHYjzkP4eSev0?=
 =?us-ascii?Q?obCRO7K557A2n610qnCWWaySXBbxEtyt3Sbm4UHDUW76+IsVU4ubXdcJgXlv?=
 =?us-ascii?Q?Jv3ThfY+efaVG0IWO5QZzD+nvdl3wY54ipIwWXxPZh3OoxXqZFB5RKV8FT5f?=
 =?us-ascii?Q?73D5R68KCg7cYn0qrTAhpMGdbdenPMQ57LjQ1PV+RHConMHtBX5fTMfZvG3N?=
 =?us-ascii?Q?qD6ArnX0H7s8cgBe+u5Rpe4mFMwihc1NXJ2fP2lFj8787SVln8ue/vo/+PHd?=
 =?us-ascii?Q?e7kh6CpfBlU4klPvjvguCd4ODKFYMvAkyZzX62kBevyZ1m9t2vVQ/n5tI/I5?=
 =?us-ascii?Q?UYz7tk99ShsH8avYjev+XANIoANDGLOT3zyOPMBRvzWreTZKIo9635VaFSH1?=
 =?us-ascii?Q?KjWk5rBuWMX/guKtjY4nnaHIOPOg/3Xk5Q5eiCp31vQKe2vqMcS2qYI2f1sE?=
 =?us-ascii?Q?VrZU7pvuUbroSDTOa16qnhBilBgiLx1m3eXqXUC1Mn5zXAr1WDyB5/X3euCD?=
 =?us-ascii?Q?1tv/sO/rCi3CMHQVS/okFyqKipPx9pdbBvDImSkG6Z/2m1MoSGeL2Ie2ww0j?=
 =?us-ascii?Q?S5bywWT8gfuiXvxuBu3TJihlEnDeXCKwL0Fh6448cBWoINqUKycJzzcCVzLR?=
 =?us-ascii?Q?B0u29i5zfvDN5wwEc58fjLfCZ8h3ri9LWJsjUShtJnDfULYJJT2ljV9+zdQp?=
 =?us-ascii?Q?O/VraH2+b4CIdx3Jc3Tuif5KAH6296uQSR77lvFDkZCOD9NuXm7zbwYF9JfX?=
 =?us-ascii?Q?u9fzYq3uSutstcg/ALQvOrPYAbLRBkVk4u8bn+wIT1tV4dfgxmeVDUu8d/+3?=
 =?us-ascii?Q?IuR7bcPU7Anky+M49Ly/3KcXT5MMnkyckPLj2dB/1qijd6V0rMXtqsx6SBk7?=
 =?us-ascii?Q?hJ+bgSuIbAwzzgPkckSNVxc/OF16mCAk3zQ7dTkiFBtKn/467QYFnIEMIN89?=
 =?us-ascii?Q?mS+3OipJJ8nZGdzt7g4HZQoaJGr0Wbxq53cHnlorXTQHNrFpqKMbwjsiOgoy?=
 =?us-ascii?Q?Az3CImMIG0YW+FmUlmZYcfB8pVEV12IteD9CqYypSJ4UiCxDbtVK82GRjiOr?=
 =?us-ascii?Q?vS+G/q49kLNZyNP0WUm4GzFWs96IyQu/89ODuHI1eWdAbQfTxUmimc8NTdFN?=
 =?us-ascii?Q?PqjET295GtmdSJha6neVhSrlTLMXF2DX6PKElG405s3teJiAfhiae6bC2gry?=
 =?us-ascii?Q?jeqPJ7iLWTnBDUskwqsA3ZlzdyMBNg0DTZHx?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2025 10:42:55.9213
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0edf8d8-6f33-4dbe-69fb-08ddacc28dd9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9619

Ethtool has advanced with additional configurable options, but the
current driver does not support tx-usecs configuration.

Add support to configure and retrieve 'tx-usecs' using ethtool, which
specifies the wait time before servicing an interrupt for Tx coalescing.

Signed-off-by: Vishal Badole <Vishal.Badole@amd.com>
Acked-by: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c | 19 +++++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe.h         |  1 +
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
index 12395428ffe1..362f8623433a 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c
@@ -450,6 +450,7 @@ static int xgbe_get_coalesce(struct net_device *netdev,
 	ec->rx_coalesce_usecs = pdata->rx_usecs;
 	ec->rx_max_coalesced_frames = pdata->rx_frames;
 
+	ec->tx_coalesce_usecs = pdata->tx_usecs;
 	ec->tx_max_coalesced_frames = pdata->tx_frames;
 
 	return 0;
@@ -463,7 +464,7 @@ static int xgbe_set_coalesce(struct net_device *netdev,
 	struct xgbe_prv_data *pdata = netdev_priv(netdev);
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
 	unsigned int rx_frames, rx_riwt, rx_usecs;
-	unsigned int tx_frames;
+	unsigned int tx_frames, tx_usecs;
 
 	rx_riwt = hw_if->usec_to_riwt(pdata, ec->rx_coalesce_usecs);
 	rx_usecs = ec->rx_coalesce_usecs;
@@ -485,9 +486,22 @@ static int xgbe_set_coalesce(struct net_device *netdev,
 		return -EINVAL;
 	}
 
+	tx_usecs = ec->tx_coalesce_usecs;
 	tx_frames = ec->tx_max_coalesced_frames;
 
+	/* Check if both tx_usecs and tx_frames are set to 0 simultaneously */
+	if (!tx_usecs && !tx_frames) {
+		netdev_err(netdev,
+			   "tx_usecs and tx_frames must not be 0 together\n");
+		return -EINVAL;
+	}
+
 	/* Check the bounds of values for Tx */
+	if (tx_usecs > XGMAC_MAX_COAL_TX_TICK) {
+		netdev_err(netdev, "tx-usecs is limited to %d usec\n",
+			   XGMAC_MAX_COAL_TX_TICK);
+		return -EINVAL;
+	}
 	if (tx_frames > pdata->tx_desc_count) {
 		netdev_err(netdev, "tx-frames is limited to %d frames\n",
 			   pdata->tx_desc_count);
@@ -499,6 +513,7 @@ static int xgbe_set_coalesce(struct net_device *netdev,
 	pdata->rx_frames = rx_frames;
 	hw_if->config_rx_coalesce(pdata);
 
+	pdata->tx_usecs = tx_usecs;
 	pdata->tx_frames = tx_frames;
 	hw_if->config_tx_coalesce(pdata);
 
@@ -830,7 +845,7 @@ static int xgbe_set_channels(struct net_device *netdev,
 }
 
 static const struct ethtool_ops xgbe_ethtool_ops = {
-	.supported_coalesce_params = ETHTOOL_COALESCE_RX_USECS |
+	.supported_coalesce_params = ETHTOOL_COALESCE_USECS |
 				     ETHTOOL_COALESCE_MAX_FRAMES,
 	.get_drvinfo = xgbe_get_drvinfo,
 	.get_msglevel = xgbe_get_msglevel,
diff --git a/drivers/net/ethernet/amd/xgbe/xgbe.h b/drivers/net/ethernet/amd/xgbe/xgbe.h
index 42fa4f84ff01..e330ae9ea685 100755
--- a/drivers/net/ethernet/amd/xgbe/xgbe.h
+++ b/drivers/net/ethernet/amd/xgbe/xgbe.h
@@ -272,6 +272,7 @@
 /* Default coalescing parameters */
 #define XGMAC_INIT_DMA_TX_USECS		1000
 #define XGMAC_INIT_DMA_TX_FRAMES	25
+#define XGMAC_MAX_COAL_TX_TICK		100000
 
 #define XGMAC_MAX_DMA_RIWT		0xff
 #define XGMAC_INIT_DMA_RX_USECS		30
-- 
2.34.1



Return-Path: <netdev+bounces-208311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 653DCB0AE68
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 09:26:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 97B0B581AE8
	for <lists+netdev@lfdr.de>; Sat, 19 Jul 2025 07:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BE8522A813;
	Sat, 19 Jul 2025 07:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="lMgv/b8s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2067.outbound.protection.outlook.com [40.107.92.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555A71EB3D;
	Sat, 19 Jul 2025 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752910010; cv=fail; b=Y9dtt1h95tb38R25FQRjWGH3ec03ZyDoO+Lm9HYBNqq6NjKUaU260QEIx4AQ+cJX4xo+82X1lpeUFZlVSoRJFST6XZG/7GFqwYqXFb2prkQXm32lJWfsKE/Zw2pBoAHOqv8ACglpvGLiQnXBegidamme85a4T/juTECvFP6F91w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752910010; c=relaxed/simple;
	bh=ELvd/u+TY8JejsRGEsjR6jo3LNOnPL83TS18dON8zjA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B1+gbxP4w+uMz3jMCn4rmM1aCuIUnZUDSXancjUcgWfGNfFHAEDOtDfc5TFFQFetAs3J91pEKxR2XZ6+PXao9ykd5UxkzhKhOjaPFRN8IZyTks16YggCxBYPHj3p0mIQh1u70Ndsz6S7v02qmhtphiEj2/45fBp4ouwoDAUZyns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=lMgv/b8s; arc=fail smtp.client-ip=40.107.92.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uvXZ2BbKB+2iEE/1TM0PL+3+iRzPXa+x3qBj7gMhSQ4QzJeCniXx7ef+tDVQqrbA6gpK5Z+6yuXn9ylV034HH/ltmntufBsS6xLdqnZ2DovAxCe4DhIMovypSdWRC97J2D07n4dT3iijqCoy0Myyh0G1V6kQezhFjWSm1Y+1QA4RWtOqIyELWeOjMOMSjNrhP1fHWLe9BIXKh/j4WSF13jr2j4QNFwabEiW7MtAh9oTgYEVtplS6qpqhrZ/2IFVSE6oGkhmV8sG4onWtO2b0ou5OH2mHkOqXwOcg0dD0MtdFvsrZ1CTiHCwrCOVNyU947h9YpwoSazGAFnQn3ZMS3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WX+AC5+Or0u6pBqjdb6N2b+GBct+chKwl4YvpIx+34A=;
 b=EH3W1EXT7IyPWLbNn5uEDu2runEXQ8VJN2efPJ6dMZbm1ePg5EoI6zsLBlSGG+snE3p8D6c/CD24KyDVfyhvEFp5P9nBAmBy3MW7edgbozE4qgLdQ4kCRiYJdIt0EQHp3yNBU3s6VJD4M52B5M30Fmm5jxLmYxax531P0pssv2YBKadQxPs2cNYNe1J0PLzdaHI6zklA+LFf4d+SHz+nHUyetTWisjzpFOmos3FUan4GgsouGcIUsymwElzbi2GKgkLcj/3jcY7GwRZMMiatSlh9KD898wHqn+r8awE+w0cGzlnRn5Aswl4veYOrB8mxynhdfa+IUeBWCa3gwjrJyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WX+AC5+Or0u6pBqjdb6N2b+GBct+chKwl4YvpIx+34A=;
 b=lMgv/b8se7FZ7opAEAea2MMjuGEHn4MmntF0S8RC5opG7omhXxBAJroBIGWhxOtK8/eiZoVmZ6XnKysbQeUxbIEwjxYJgvu3swchm4CzTFhO4VgvWq+/v9IzGUjeFW72qA0d7fs3JJjnIOg38aBj0VNnXZZfs3ARfE3o1Ak7r0M=
Received: from CH0PR03CA0002.namprd03.prod.outlook.com (2603:10b6:610:b0::7)
 by DS4PR12MB9708.namprd12.prod.outlook.com (2603:10b6:8:278::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.28; Sat, 19 Jul
 2025 07:26:41 +0000
Received: from CH3PEPF0000000C.namprd04.prod.outlook.com
 (2603:10b6:610:b0:cafe::ad) by CH0PR03CA0002.outlook.office365.com
 (2603:10b6:610:b0::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.21 via Frontend Transport; Sat,
 19 Jul 2025 07:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH3PEPF0000000C.mail.protection.outlook.com (10.167.244.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8964.20 via Frontend Transport; Sat, 19 Jul 2025 07:26:41 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 19 Jul
 2025 02:26:38 -0500
From: Vishal Badole <Vishal.Badole@amd.com>
To: <Shyam-sundar.S-k@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Vishal Badole <Vishal.Badole@amd.com>
Subject: [RESEND PATCH net-next] amd-xgbe: Configure and retrieve 'tx-usecs' for Tx coalescing
Date: Sat, 19 Jul 2025 12:56:08 +0530
Message-ID: <20250719072608.4048494-1-Vishal.Badole@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000C:EE_|DS4PR12MB9708:EE_
X-MS-Office365-Filtering-Correlation-Id: dc8a58ad-ffc5-4dd2-1553-08ddc6959b67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hgvn5JK4m+IPWG8bP+CIx+OKzdAfrL8GwU0nKDLwK1/79GSmIDj5StHGk1K5?=
 =?us-ascii?Q?LfbdWxRoSmirsIsm7yW2k5nOHmllytHZRmvX29E33kxAAY8j+ZQnViJYEkOD?=
 =?us-ascii?Q?0Oicgp8QIFYsx3Lmb4ajIHqsLL6Vau+svpT2ml+4S5SlnPRl77kp7+qwd8ZB?=
 =?us-ascii?Q?cCZwLbcSer+Yn6JvoTL0DprU2gfmtbNAxe9kz7VzU7W+oyPdibfBByhNdPmj?=
 =?us-ascii?Q?v+mHIeo+kzwABnFoYU5ZhLuI6oQXq0UhzE2tsVolc/I/kq57/eScvgUdp1n6?=
 =?us-ascii?Q?4QZH9uc7NIOAiw2c87C6ceDoh/HassC2ab5GspDifxHmpevx5F0MMyAZNGpF?=
 =?us-ascii?Q?5rqDT5MK5nhG5mcMjkjTRGp1kUdlZxdm/d85yI0+VQJwBlNbiI0y/R3VLXJO?=
 =?us-ascii?Q?k6MCSe7gN+gCfDJRXUuWDsw0+ZRxgRFi1LBKvE9Nbq2JRQ2QOOt26pw3NhX7?=
 =?us-ascii?Q?xGJxCMqUEJoVdrDWgAsKOVbcmuGnL7osf/VgwmakpHqvP1/O3jTa7mqV6U0d?=
 =?us-ascii?Q?Ycngt6eUU6JI7HYOIel2lGWScExdXXlrd0yil3PwMoMrEIbGHPZUil8cOM/X?=
 =?us-ascii?Q?LjJiUNcQ7iDjxQjcIlhpSgYq1sCbdgTw5t6Mq8C7AL96I+jPBSadTuCpHxNb?=
 =?us-ascii?Q?cQjJ1UhCxKzt/eUZ1R0/VxR41ERycQm0IhHr2skXm+T39jJWrG4PaYakYjfg?=
 =?us-ascii?Q?N902fMZf2bZSVOWkJkXJdvYoewIa7E2x6WvHDjFRxCnhg6kgTcosNyEkJeu7?=
 =?us-ascii?Q?vhOfNe3yD+tP72S7TeoNNff0xI2/zetxftDZfW0CeA2HkP9sJQeVIK/3XWGT?=
 =?us-ascii?Q?1De0sZeebSEQxZ+pk5Th0jEEdIjF7UG7I9ui6V9THnm4cV/ixgYFQO4QGPWA?=
 =?us-ascii?Q?wCxb3kcfxCTPBAj0G5Y4caHgoGdbCV7V3V3PQ/bn+6M+8JWADANn76XXYJE/?=
 =?us-ascii?Q?bWIFRcklyty1nmhTDKvicemyuKgnKu1chLgbqQZqvQ7tmZCWbtGcinf6M4JX?=
 =?us-ascii?Q?YRSDuiOjh5DqTQaTvZQQtgauC1beOVtgBt6vmN6HCWfj9YWlVvW/fBDeNQx5?=
 =?us-ascii?Q?SIBvJqiWQDCFcMSOPvyY+yklDdpH0cuVDUDk2vLlDg4yrLqeX0jiYpOdHLoD?=
 =?us-ascii?Q?ZJENM10awBEivtObtsIU/AwE0LcUCs9gLZSxPIufSToEoO88VzANZHICrMZj?=
 =?us-ascii?Q?fIoHur/c1k5B6MLQ/6IyBg1s028/ZxPfExBRBkhM94y4xmMg0XFpKu6aIBRj?=
 =?us-ascii?Q?dJyR802/rKXeDSLimP7OsSrWO8PTxuxzqlnh6MjCPXJCB4URjitm8+YbXyx2?=
 =?us-ascii?Q?ASLLftBlnOad6ZpEbDLR+cLgg19H4kyB8EQDTf4Bj1GqJzzSU5SLpByFlWxM?=
 =?us-ascii?Q?DG3x/aA+9H7sROJS/GaSGMKiaOUA5+nxwAMet44HHVdUHm5iL+EoZraljA2Q?=
 =?us-ascii?Q?Oc2SNVuvHwWm2IEp53vK/QSHNBICjmv3xqoJmhRFm09ToNauXB3p4S/mCsIC?=
 =?us-ascii?Q?nFuFqlQaWVWNlpntqZrL2N9IWhJRaRFI5Zyn?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2025 07:26:41.5538
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc8a58ad-ffc5-4dd2-1553-08ddc6959b67
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9708

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



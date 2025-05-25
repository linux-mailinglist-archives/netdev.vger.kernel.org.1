Return-Path: <netdev+bounces-193251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD867AC33D3
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 12:22:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 808353B26CB
	for <lists+netdev@lfdr.de>; Sun, 25 May 2025 10:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 763E01EF0B0;
	Sun, 25 May 2025 10:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="5dDoNA25"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9ABC63A9;
	Sun, 25 May 2025 10:22:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748168550; cv=fail; b=OeqO7/GydyBVnXguhqJ+2V3UcGSbiWeCyIbq37PaceHxJusl37jjP6Pk+lq7XXt3w+kOzgfbRSp3A0eqFXjUNDd/5NjVWvJPKXLYZ0ovmFleepE3ITCF/OjmdJZmVvJTVP+KtOh23y0sYWyDSEzlyJ6b401VbLOHL7SoXgXAdLI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748168550; c=relaxed/simple;
	bh=qoXJt/Yh9qWq5kuZzAHqeLWRJA3aEKBgMPqeucPjNJg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z7bDmfG3N+HzynCW0wArXmYcfgkKikA9Qq0o96eorRn1jo3cw76Z8VQRo2Pl1JC0op9HhksyG9BwhOZ7DWzs2bGNFngo/wsAxMBeBY6U68R8FIC9hJXeVrWvJEdASx/dgNOnd4hnQvDlklgggU4fULH/ef+MUzBaK3fw/ED6HBE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=5dDoNA25; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pmFMD6APkVyJZKysjY1Q2t9Eea44F2MZsBCi9WaE1rNHi5EryIPZ2zqPOZS84ILGedt+uyps5BouKxOcLE0B88FtMTY4/SrzcDAGVxhIj6sfEO9PKRuy6zI8dSyGAaGHhrqSUVwHjngsjn2rdugBf8mBGZ97pbwOt+Hbh8lZ5qWAMK9xjJZv9HXKOSz5NsdMC6xEdupzW1PsOWThLlC/KsJwmyvhad7OMi4ob0n6ZLMcPCIBsKEs8v+uR7rj4y+2UZkWypPd1JP9y4TLvNN884R16FDBFgZ4MkkxOWOWG55Nu6dweQdZHl6vXxDjsiweFqu8QQ2MMkjF0CheynTCsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MHoY9NprZrhMoOj31geuDIZSaDHcm4VQ+TXX3keKbuE=;
 b=OrFqQzam3OlabLm82mptHO0FTt9SOuKkr/1FrOdI5gFUGMWjZoWrOIMv1nbyGYR3zsl85CWGlq9JJV50rwV9JEsPzrnNgb6bGRaAMoi4HhQ6Yci8fuHAr0P3VLeEdNBq4wOhijdcpM7l9Wnsu6+MwHxe0tucHr+YhmECrzFvrjvJI8S6v05dYPLa8Znrbhv+i7a6UauOcOXnCOOYyJ0irVZiY73uZELLE7gT/Eb8SVMLdjKWJccWJglSMekXRC7APWKI4wgQMu9oSZ2OwlBHrK8Q81UqAQG47Fo+tICXoxilFp1OSfs0gHLgVOONgk+wRAN9zh2DlhUmZcTu+awWmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MHoY9NprZrhMoOj31geuDIZSaDHcm4VQ+TXX3keKbuE=;
 b=5dDoNA25h2xKlHOkW3rtHjtEAdCXrbCdzIn8G1KuVJtrLL1eAgoFI3ufwDjKQRx7tHzr/Axqu8yHjijhB+DlLgXI+DWCQlRs/D829Rpe+HY1Q1t2cbFEoM1r0hEPzAzAMy8X4DRhsIQklSiG3z8IBbvmZOuIfyczQ0L4ZpfHioA=
Received: from BN0PR04CA0184.namprd04.prod.outlook.com (2603:10b6:408:e9::9)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.25; Sun, 25 May
 2025 10:22:23 +0000
Received: from BN2PEPF000055DD.namprd21.prod.outlook.com
 (2603:10b6:408:e9:cafe::97) by BN0PR04CA0184.outlook.office365.com
 (2603:10b6:408:e9::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8746.31 via Frontend Transport; Sun,
 25 May 2025 10:22:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000055DD.mail.protection.outlook.com (10.167.245.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8813.0 via Frontend Transport; Sun, 25 May 2025 10:22:23 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sun, 25 May
 2025 05:22:21 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Sun, 25 May 2025 05:22:18 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <vkoul@kernel.org>,
	<michal.simek@amd.com>, <sean.anderson@linux.dev>,
	<radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, <harini.katakam@amd.com>
Subject: [PATCH net-next] net: xilinx: axienet: Configure and report coalesce parameters in DMAengine flow
Date: Sun, 25 May 2025 15:52:17 +0530
Message-ID: <20250525102217.1181104-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055DD:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: 0aaf7649-f0b1-474e-8ccb-08dd9b7609f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|82310400026|1800799024|13003099007|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+/TOwM90wuftVXJZHiRUbBCqZfZVK4NJHLR7olsWtDlgq8Y+mhHa2AoOU4vU?=
 =?us-ascii?Q?3/243E/diEWGmHo04II+EYaV3QQKJqRlWWjqLn7lKxxw0li3GiZjjVYk0QMH?=
 =?us-ascii?Q?rqIEYmI+o3cANtL6lDtptRvZVSqtPEnQ6D7dV1cTVoWFjclj637EGAmBvZzt?=
 =?us-ascii?Q?i1PDpKhk3YF0Z3xCOtKYdXlnjciyQX+1F+iDEtbJ4tQo6yuhhB94NQKe4SWd?=
 =?us-ascii?Q?iWU1aktbqehKPKMa3R2QbSpa++k82uBUSOueArT5hnr/B0w1W6w4Emu0aKHW?=
 =?us-ascii?Q?FRNoH4mA73yaA/+gNv5zsKsppq5IUNAnUwyHIPBy2YhPPwlFyUK+ovZ0oe2M?=
 =?us-ascii?Q?uQkL3EqciTgS4GPcsGM0udrMpbz5Zc4GIME5KA1EMG4MjelWFR+LQkyFOO0B?=
 =?us-ascii?Q?lcc10qqtprD9ZYOfIMBo56vyic1QtRdJ5LasSU+M/YIdBAG7TigFJnSl/Pvb?=
 =?us-ascii?Q?jMrcz+CiQqqKm+m/sO1QT9KLlOX7vKXdrkUSrADwkAZy1x2FqG6gn7Kqgd89?=
 =?us-ascii?Q?7jeR7xEZCXE+nuGLKPCjQIXXvdLFaqWGRApwT3Vh5qoCHCYJnUnzqqxCqE4e?=
 =?us-ascii?Q?7WlbHBBeyQf/u5dSeJIfCJHoElolxjusGC6nx9Nuo6KbZGEOM8DNxTNtT0rf?=
 =?us-ascii?Q?YtqdEGe1vTrc8ZbnSu/+Xw/o+uV/e5KXgLeXTsel3OxV9JD8fKEhDKGTlOHE?=
 =?us-ascii?Q?k5yfJuFbTHE1JlfnUJIr2nceKsGwKni6XwyM9mO14AzdPEIBElEHMJwj80hL?=
 =?us-ascii?Q?dbGkUNgRiWS1Ma3teKDUQhUSGUAitoYF4AGaSNoGWEFnLmA4wYkMtVhUUWlI?=
 =?us-ascii?Q?YimYypMwRXbql4QYaO0perATZ3FMmsUaV39j+/NZtatEaYSSRSjOLTCO0wMW?=
 =?us-ascii?Q?H8bJFqx2+znn9UbAGgqN5VWqpnrKK7DbT4vKnK84WoOOrUdl6YQtOuar7Z+U?=
 =?us-ascii?Q?TAyQQjB4IrYKiZLb9oYiWHmtvnVbBzf3zHC2CUoE5JjNLxz9jdAVBWaYSx+L?=
 =?us-ascii?Q?AJUsBI5lOv88+mPjF6z9wIJGkWK9pOY5c6c4ZtIhNjh+1jR4mpSGQQoeqvGG?=
 =?us-ascii?Q?zXYhOUiW5pfiWYx2+jimMeIq0PmAyP/WvlRcljfStSTwOEXnaNDB+7t7cDyg?=
 =?us-ascii?Q?X10SbfpM7E0pu7dVGiLserYRQu0FgXY+1yLBHLIwG8AJ9uJcXv/pkkEa7B1R?=
 =?us-ascii?Q?mZs6qN0f1EDiEzRr/iFE1z5onGxyyXRrYTefctnOz1bxlu5AScdWYi2HfPpt?=
 =?us-ascii?Q?YTAVYjQ3ATNR+jc4zGADMjiqEKrVS0ndAz0fVwSPdsJ/bbEK0VdWNC5Pos3D?=
 =?us-ascii?Q?Qmd/vj2pd9FCbHx8z4GFgR0SWK1TmPljj9uK4HjeNgn3/bV6LvDiEggVEwfS?=
 =?us-ascii?Q?ab8Ob6wSV9lF+WZoAcU09XMxiEN0NyVosXTwuYzclgf2Lgj25nCi4/ZZ5u2T?=
 =?us-ascii?Q?4n1xqrYk9vRDSmsBM4Pz5pFyjZEFTV0KpZjOe/Q1KOA43Vi1SNVoCOuOOeX7?=
 =?us-ascii?Q?nXiEyqJD7hq1rK0o/cHtSIH0k598tSxwc6XTBAErHP3N0PMXGA+1wnUhgw?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(82310400026)(1800799024)(13003099007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 May 2025 10:22:23.1724
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0aaf7649-f0b1-474e-8ccb-08dd9b7609f7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000055DD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900

Add support to configure / report interrupt coalesce count and delay via
ethtool in DMAEngine flow.
Netperf numbers are not good when using non-dmaengine default values,
so tuned coalesce count and delay and defined separate default
values in dmaengine flow.

Netperf numbers and CPU utilisation change in DMAengine flow after
introducing coalescing with default parameters:
coalesce parameters:
   Transfer type	  Before(w/o coalescing)  After(with coalescing)
TCP Tx, CPU utilisation%	925, 27			941, 22
TCP Rx, CPU utilisation%	607, 32			741, 36
UDP Tx, CPU utilisation%	857, 31			960, 28
UDP Rx, CPU utilisation%	762, 26			783, 18

Above numbers are observed with 4x Cortex-a53.

Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
This patch depend on following AXI DMA dmengine driver changes sent to
dmaengine mailing list as pre-requisit series:
https://lore.kernel.org/all/20250525101617.1168991-1-suraj.gupta2@amd.com/ 
---
 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  6 +++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 53 +++++++++++++++++++
 2 files changed, 59 insertions(+)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet.h b/drivers/net/ethernet/xilinx/xilinx_axienet.h
index 5ff742103beb..cdf6cbb6f2fd 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet.h
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet.h
@@ -126,6 +126,12 @@
 #define XAXIDMA_DFT_TX_USEC		50
 #define XAXIDMA_DFT_RX_USEC		16
 
+/* Default TX/RX Threshold and delay timer values for SGDMA mode with DMAEngine */
+#define XAXIDMAENGINE_DFT_TX_THRESHOLD	16
+#define XAXIDMAENGINE_DFT_TX_USEC	5
+#define XAXIDMAENGINE_DFT_RX_THRESHOLD	24
+#define XAXIDMAENGINE_DFT_RX_USEC	16
+
 #define XAXIDMA_BD_CTRL_TXSOF_MASK	0x08000000 /* First tx packet */
 #define XAXIDMA_BD_CTRL_TXEOF_MASK	0x04000000 /* Last tx packet */
 #define XAXIDMA_BD_CTRL_ALL_MASK	0x0C000000 /* All control bits */
diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 1b7a653c1f4e..f9c7d90d4ecb 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1505,6 +1505,7 @@ static int axienet_init_dmaengine(struct net_device *ndev)
 {
 	struct axienet_local *lp = netdev_priv(ndev);
 	struct skbuf_dma_descriptor *skbuf_dma;
+	struct dma_slave_config tx_config, rx_config;
 	int i, ret;
 
 	lp->tx_chan = dma_request_chan(lp->dev, "tx_chan0");
@@ -1520,6 +1521,22 @@ static int axienet_init_dmaengine(struct net_device *ndev)
 		goto err_dma_release_tx;
 	}
 
+	tx_config.coalesce_cnt = XAXIDMAENGINE_DFT_TX_THRESHOLD;
+	tx_config.coalesce_usecs = XAXIDMAENGINE_DFT_TX_USEC;
+	rx_config.coalesce_cnt = XAXIDMAENGINE_DFT_RX_THRESHOLD;
+	rx_config.coalesce_usecs =  XAXIDMAENGINE_DFT_RX_USEC;
+
+	ret = dmaengine_slave_config(lp->tx_chan, &tx_config);
+	if (ret) {
+		dev_err(lp->dev, "Failed to configure Tx coalesce parameters\n");
+		goto err_dma_release_tx;
+	}
+	ret = dmaengine_slave_config(lp->rx_chan, &rx_config);
+	if (ret) {
+		dev_err(lp->dev, "Failed to configure Rx coalesce parameters\n");
+		goto err_dma_release_tx;
+	}
+
 	lp->tx_ring_tail = 0;
 	lp->tx_ring_head = 0;
 	lp->rx_ring_tail = 0;
@@ -2170,6 +2187,19 @@ axienet_ethtools_get_coalesce(struct net_device *ndev,
 	struct axienet_local *lp = netdev_priv(ndev);
 	u32 cr;
 
+	if (lp->use_dmaengine) {
+		struct dma_slave_caps tx_caps, rx_caps;
+
+		dma_get_slave_caps(lp->tx_chan, &tx_caps);
+		dma_get_slave_caps(lp->rx_chan, &rx_caps);
+
+		ecoalesce->tx_max_coalesced_frames = tx_caps.coalesce_cnt;
+		ecoalesce->tx_coalesce_usecs = tx_caps.coalesce_usecs;
+		ecoalesce->rx_max_coalesced_frames = rx_caps.coalesce_cnt;
+		ecoalesce->rx_coalesce_usecs = rx_caps.coalesce_usecs;
+		return 0;
+	}
+
 	ecoalesce->use_adaptive_rx_coalesce = lp->rx_dim_enabled;
 
 	spin_lock_irq(&lp->rx_cr_lock);
@@ -2233,6 +2263,29 @@ axienet_ethtools_set_coalesce(struct net_device *ndev,
 		return -EINVAL;
 	}
 
+	if (lp->use_dmaengine)	{
+		struct dma_slave_config tx_cfg, rx_cfg;
+		int ret;
+
+		tx_cfg.coalesce_cnt = ecoalesce->tx_max_coalesced_frames;
+		tx_cfg.coalesce_usecs = ecoalesce->tx_coalesce_usecs;
+		rx_cfg.coalesce_cnt = ecoalesce->rx_max_coalesced_frames;
+		rx_cfg.coalesce_usecs = ecoalesce->rx_coalesce_usecs;
+
+		ret = dmaengine_slave_config(lp->tx_chan, &tx_cfg);
+		if (ret) {
+			NL_SET_ERR_MSG(extack, "failed to set tx coalesce parameters");
+			return ret;
+		}
+
+		ret = dmaengine_slave_config(lp->rx_chan, &rx_cfg);
+		if (ret) {
+			NL_SET_ERR_MSG(extack, "failed to set rx coalesce parameters");
+			return ret;
+		}
+		return 0;
+	}
+
 	if (new_dim && !old_dim) {
 		cr = axienet_calc_cr(lp, axienet_dim_coalesce_count_rx(lp),
 				     ecoalesce->rx_coalesce_usecs);
-- 
2.25.1



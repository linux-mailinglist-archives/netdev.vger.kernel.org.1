Return-Path: <netdev+bounces-130564-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB3FA98AD90
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 21:56:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 39DA01F23D97
	for <lists+netdev@lfdr.de>; Mon, 30 Sep 2024 19:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BFE19F431;
	Mon, 30 Sep 2024 19:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HUiBC9Rr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2069.outbound.protection.outlook.com [40.107.95.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234D219F42D;
	Mon, 30 Sep 2024 19:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727726165; cv=fail; b=p/JsW9Cj0JgTjzKhmS9FrNX09fJsUqiMUG06bw/rCEApCPMOGI0mVBQ4fbBZd1F99yEM35JfkY83tcVMBg7FFe0gPphIY7KSSIZqFYueXVsmZet6IcRWqEUiRhi93KrVxB4OYr/eg9gT/15Cvo9QTP82bfOz76Vx6BZfQkv7R4w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727726165; c=relaxed/simple;
	bh=4uhsFsqKM7BzjQZmEH/x9eDBKVBaAN5cX+PM8P/HpFA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wmn1FaC5bf66k6brp7RUgaFhAnQVUBIFrRtJxW+KGNwV0uhk7qaPrqOXfYl9z9Ghgvbwb+rL/BOpTm9eJ1/E69RFg8zt3Uo9HOBANwoPLZdtK618/wEWa86wdOhgwH4paunROOa2aFSOsb9sjG7IPGQ3Q7y6F+Xwh4CEw6771O8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HUiBC9Rr; arc=fail smtp.client-ip=40.107.95.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YIojR53za43x9nRonz0f1PiB0o6eKK3PsFEy0QJzyK+yl+zOOw2c1isz8vXOOyNRy7TbcjIkjL81itfwDwqDo6uDjTxgyLqDrtUOQZz6K8EJeaj7UvtfMPC7qCq/tV4N5EpCFlGCvaXyj0IzN+XWCLI230Svd7xQ4k2s1TlBuIHsPFs1gQ1foOtVNHgE68fEhnIYIwMejmSVT3BA2zKN58lm19/7NJ7qUnDicSrlpq3OmhmE4E3Qwxe2nRBWUHFTdE4DPe2Q+J73RKZxT3JvQbXswTKV1Iob9xknNApzHsb+IfWE4bH7kLzNir9XufyT52C3OyUZT31pdm4HIDV6oQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nN+EUTaWKCx5wQeb7lALfqRE5J2a72aZCutITCGyb30=;
 b=qQe7NejqJGQfTbc4v+C3u/YsjTSPd1jh8GifAiaXW5eZDUWJUGQtQA3x/8E72QoQYagQxQJxFGYPlYmJw2JxdN2nZQrYZAL5Q15NbeRioEkbwQ/FgMLOgoJZYkoYCcy9fOEfX215MeEbb9YtYMbNCWbzb/3M4LNxvvuE4y+vMqhetlM1DEFPiM76EeGzrf9v5vlspkBF8poq7QYz0Tt5RvP1tZ1e5iagaBXWwm2Uh4pbgXUd/YgbA5SMfcZu03qF6WK5mKz44lDrx1D/aX7oKYt3DUpIrhG68lUWg9PTT4xWxVkdPo5DL5tnPht1oINaMBScAljFWGM/YAfd3yjnjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nN+EUTaWKCx5wQeb7lALfqRE5J2a72aZCutITCGyb30=;
 b=HUiBC9Rrj2+Vu5o9BC4X13aSO5prZwCwPTT5rH63LJXL4ONIj5O5hVaVf5T7LCdxRN5vdZ8RsD9W96xq2SYxcVnvNVkJxYE/1R66bD0m4pThTrmFBqWWA/BctRYBoSArqfMbQtITIZeu8c7hHPhRrB6LoUlptfvjyoRp3evDTMg=
Received: from BLAPR05CA0038.namprd05.prod.outlook.com (2603:10b6:208:335::19)
 by CY5PR12MB6034.namprd12.prod.outlook.com (2603:10b6:930:2e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8005.26; Mon, 30 Sep
 2024 19:56:00 +0000
Received: from BL6PEPF00022571.namprd02.prod.outlook.com
 (2603:10b6:208:335:cafe::4f) by BLAPR05CA0038.outlook.office365.com
 (2603:10b6:208:335::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Mon, 30 Sep 2024 19:55:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00022571.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8026.11 via Frontend Transport; Mon, 30 Sep 2024 19:55:59 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 14:55:58 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Sep
 2024 14:55:57 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 30 Sep 2024 14:55:53 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <michal.simek@amd.com>, <radhey.shyam.pandey@amd.com>,
	<abin.joseph@amd.com>, <u.kleine-koenig@pengutronix.de>,
	<elfring@users.sourceforge.net>, <harini.katakam@amd.com>
CC: <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<git@amd.com>
Subject: [PATCH net-next 2/3] net: emaclite: Replace alloc_etherdev() with devm_alloc_etherdev()
Date: Tue, 1 Oct 2024 01:25:37 +0530
Message-ID: <1727726138-2203615-3-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1727726138-2203615-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1727726138-2203615-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: radhey.shyam.pandey@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022571:EE_|CY5PR12MB6034:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ae51b6f-db3c-4eb6-39c1-08dce189e7bf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EBvXEjKjT0rx9S981XorwBCHejP1XYoQ1DT4hOZdnVxKNeVPPBiSDeMiq2i6?=
 =?us-ascii?Q?4t0jTGm1qg5p3srdDoZOwMGRehx+cOBnlDjlfTKMn+b5KAHbqE+DR46Ac1Rc?=
 =?us-ascii?Q?yfWxR9iTy1lylQElb/4sHvCT0dgQXkZ4aXQQTE4IpYjjtXl1rWR2lXIMzP39?=
 =?us-ascii?Q?gzcm6t00Nx7YgHHm0qDKmjLBXd1fH47DvNdLQb4E4/JG2L/fxZ7Hku6sPl/h?=
 =?us-ascii?Q?5OZPF9z/Uqy6GDacog8k1/YIbWYFLsq5SGV7H5U1iZ+fxnSquzNapdDlOzJu?=
 =?us-ascii?Q?XfSbwxoVr7V1mEZvr8XprEOG4bwJ2YpoiT5XImY5ORkXXB5Aq1iuOB0/4YhY?=
 =?us-ascii?Q?qAmTcSdSjn0e4WhCZ33xKSm/7DjhCRp4DAXvSiwYNA9Rg1RfDfPwa3QuqqvJ?=
 =?us-ascii?Q?j1KYHZpKL8IXPn9KxRngxo8P6oJAEwwmU7lPjdBc+/rIluzJRfaukwxL/B4L?=
 =?us-ascii?Q?Sgafbo9sEg6Uo1HYa4ATsMzaouGdDsF7HGpZz6lRazRsfLfM2KzxNGA4Wz7C?=
 =?us-ascii?Q?c6djaPc3Te4PO5quNr4LAUnvsn5mEaURRnJJfmnd6Paa9hGXKmnuTdTOQOjG?=
 =?us-ascii?Q?QHTDUjrlJacdi9nAFXHuhpXXUc0fyVgngEB8Q+G97nmafi63HJDCP4UQrAJf?=
 =?us-ascii?Q?F0Vs1uxFX+RI3nsl6Z3udKyzu19nlR5VITXDLkxHEfQdQEVxPUcGZHsVTKFQ?=
 =?us-ascii?Q?K0P3TsLVHVsJaw6ygbahBs2RuTYi3OoTny392K3T9Lu/gq2k16M/2wkjASO1?=
 =?us-ascii?Q?Fe+0wpIg4ieGpB5IAZESUQ2h9Sc+Rx8wuSJNrWtzVLr07jmnH/q0OqDVCmLQ?=
 =?us-ascii?Q?2G/gvOawVdTravpHU8soeoMNiMIkq8IrukjxOS1M908EMx8cDQ1n04KEI2aW?=
 =?us-ascii?Q?2RbVnQe78oYCzUDgg8+iwxhYWAZg/JhgEGONG4gYFKS+J004rhGriuDKJoNF?=
 =?us-ascii?Q?VOXaEFrt1c6YpoFKDjPsQ21u23wdRErxHn+DRw8ispPm0W+ApEpJyQirgBck?=
 =?us-ascii?Q?FtDH98wYLAR8Ypt1ZaZenOC7Afsc0BTFCtlFvkX+j6D0+ondkMdjfcK6y//e?=
 =?us-ascii?Q?kE3LvjUa1XPfTgDaiU5LbRbh1W//nLsAwXF/CuaGEPfpTie30SlN35XoMbZi?=
 =?us-ascii?Q?ofcCD2F8wNdvsH5KCaLYOJol+urbgqfkjkoSox4qvdLg/W5+UOUD55QGSgoT?=
 =?us-ascii?Q?cdzkjPm7c7x2VxnLqhqW+HZg+46k1sASyicAVdNxx6IPhNWIvY3E96RZglhB?=
 =?us-ascii?Q?9cLGTvTMLm4O7T4lwWIpnB12w88F5ybjJBvcunu/9t9hI92OBK9xo/SSIVIQ?=
 =?us-ascii?Q?cbYgV8nSgKiFjVk49+Rw/k3k6Fb+Sn5zkWeNwlfp8WhX8vYmj/invQm6A6+r?=
 =?us-ascii?Q?0FdNEdbwjygnr5e1YpmnDTdoojj6tlFMwZOP3kinAkTlyCt4gnsFL30uwXZ8?=
 =?us-ascii?Q?oYq788zb4BmbqB8hM7vhLNvkpjvaoNZDryP+05wmV7tF8uQ2iZzdcg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Sep 2024 19:55:59.3981
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ae51b6f-db3c-4eb6-39c1-08dce189e7bf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022571.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6034

From: Abin Joseph <abin.joseph@amd.com>

Use device managed ethernet device allocation to simplify the error
handling logic. No functional change.

Signed-off-by: Abin Joseph <abin.joseph@amd.com>
Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
 drivers/net/ethernet/xilinx/xilinx_emaclite.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_emaclite.c b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
index 940452d0a4d2..13ac619df273 100644
--- a/drivers/net/ethernet/xilinx/xilinx_emaclite.c
+++ b/drivers/net/ethernet/xilinx/xilinx_emaclite.c
@@ -1097,7 +1097,7 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 	dev_info(dev, "Device Tree Probing\n");
 
 	/* Create an ethernet device instance */
-	ndev = alloc_etherdev(sizeof(struct net_local));
+	ndev = devm_alloc_etherdev(dev, sizeof(struct net_local));
 	if (!ndev)
 		return -ENOMEM;
 
@@ -1110,15 +1110,13 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 	/* Get IRQ for the device */
 	rc = platform_get_irq(ofdev, 0);
 	if (rc < 0)
-		goto error;
+		return rc;
 
 	ndev->irq = rc;
 
 	lp->base_addr = devm_platform_get_and_ioremap_resource(ofdev, 0, &res);
-	if (IS_ERR(lp->base_addr)) {
-		rc = PTR_ERR(lp->base_addr);
-		goto error;
-	}
+	if (IS_ERR(lp->base_addr))
+		return PTR_ERR(lp->base_addr);
 
 	ndev->mem_start = res->start;
 	ndev->mem_end = res->end;
@@ -1167,8 +1165,6 @@ static int xemaclite_of_probe(struct platform_device *ofdev)
 
 put_node:
 	of_node_put(lp->phy_node);
-error:
-	free_netdev(ndev);
 	return rc;
 }
 
@@ -1197,8 +1193,6 @@ static void xemaclite_of_remove(struct platform_device *of_dev)
 
 	of_node_put(lp->phy_node);
 	lp->phy_node = NULL;
-
-	free_netdev(ndev);
 }
 
 #ifdef CONFIG_NET_POLL_CONTROLLER
-- 
2.34.1



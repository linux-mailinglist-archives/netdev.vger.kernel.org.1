Return-Path: <netdev+bounces-250617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A88BD385D5
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:29:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 673DD303967F
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C6334EF0E;
	Fri, 16 Jan 2026 19:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="a7iYQ7bL"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013059.outbound.protection.outlook.com [40.107.201.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B10F3A0E8B;
	Fri, 16 Jan 2026 19:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591677; cv=fail; b=m1VhtN6rwHyB1kMiJLpU8cKOwbj3D61CQGgeLgGY2CzBF+5EJF+8nJwGgVL0SDRKAOgHzIi1tiUq4/23U2dEoomoI+GHygr08/oOZr5dK3kg2iwaPevpZhbgLb99X9LlGxTKU4KpDjkEVKq7GX7O8663Fm6okiB6hAGapWp/El8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591677; c=relaxed/simple;
	bh=D71eyvQE6h67pES+eJnRBEEEk65C5WCtug0DI4CXz6A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iN8d2wCZPhSQL/1g2Ok82YZeNOBTXCaxT9pw4ythaOcP1YXkHzlIDuXzyHnFhGoUMZJXEG0IKU1XF3A1yx1yqpiyTrCrJebCDetzAYAJQJilUmWygcfIbagLtkxCyLZvzaVXmwJ7TsabDbjBPVn1CB7vrRz2gHrrRLSHMPKmfjM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=a7iYQ7bL; arc=fail smtp.client-ip=40.107.201.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oEbmx4pP0MrY8jAbjkEXvMySzrSKvhhKYiZo59t8GzB1W2tN3TwOBCV2fwuDlN1AWVZ4lvLj1rx147vEINDRgUAgRBoGA4yPAV2X7CCScXdrJtqSebR93uLjtvwLZGFjXW6+v4QPLjtXUdR4ZRW1uJhcBOtO58bgxtXJGebhqB4BqnFw01JBLIBBauqzBbBajWiPKS5BWnWUSD90XmosW5kycJScOHK45Z6mW5ypvEr8WIPORa0OiuoTVhwrAzToSPt09uheDKn9sngI/ycFEdUfJpM6TMeGyLhg0RUUYtvHsQniZ0SrLJMcnA44E+o+c51TbE5NRxWc0cBJ701Tog==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sRDXY4J/uFGB1yQXyfnnJwWjtcJGqG541JFygF+15PI=;
 b=jNNkg0GM5XqgfhwUTc9m46JvnHsdwCUgN9Y03TBuTBlc3Tf4jMrj4imKnBuAuaPjaW+Lk/Q6b3s3wpbZMlEyKfCf2CQ7J8xtR3qqZC3vZ/mdT+oINp5RNKhOzloNsHOHX+IupQ+KXB7yxgI38+/mhqAH7bRDil3Q1Y1FVbLiJUDAvA9r5E5cpK2A8Kj8aEJupsU6NJ1upidwzAS1edP6X5oXkzwNEfUM87VUv9Ro682RaMWcyxjF3dndZIB++49cels7hq5se6acCf6ewvhZJ5xCh/BmLl96gXp8zq6JyPTsVspje0GOXl/JlGR/Plj4RWVwsMu+RlxTWM5+WQWy3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sRDXY4J/uFGB1yQXyfnnJwWjtcJGqG541JFygF+15PI=;
 b=a7iYQ7bLCmPkg1uC3xD8B6PFXLmexYvpfzn6JaFaM5bdC8w2U88d9tcfGRo36RGd7C7XFMANibBA2QlY+8ZKp2YR/3J0lso6Nxv4XFm1gtYYpYPUqj2Wy7yAnRoe7quqgFoVJOML7Qypdg+7Ofs2WdkbK3Ofj5vXFSZel8XPVnc=
Received: from BN9PR03CA0455.namprd03.prod.outlook.com (2603:10b6:408:139::10)
 by CH1PR12MB9600.namprd12.prod.outlook.com (2603:10b6:610:2ae::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.7; Fri, 16 Jan
 2026 19:27:48 +0000
Received: from BN1PEPF0000468A.namprd05.prod.outlook.com
 (2603:10b6:408:139:cafe::99) by BN9PR03CA0455.outlook.office365.com
 (2603:10b6:408:139::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.8 via Frontend Transport; Fri,
 16 Jan 2026 19:27:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468A.mail.protection.outlook.com (10.167.243.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 19:27:44 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 13:27:43 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 16 Jan
 2026 11:27:43 -0800
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 16 Jan 2026 11:27:39 -0800
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>
CC: <sean.anderson@linux.dev>, <linux@armlinux.org.uk>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<bmasney@redhat.com>
Subject: [PATCH V3 2/2] net: xilinx: axienet:  Use devres for resource management in probe path
Date: Sat, 17 Jan 2026 00:57:24 +0530
Message-ID: <20260116192725.972966-3-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.49.1
In-Reply-To: <20260116192725.972966-1-suraj.gupta2@amd.com>
References: <20260116192725.972966-1-suraj.gupta2@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468A:EE_|CH1PR12MB9600:EE_
X-MS-Office365-Filtering-Correlation-Id: 012f6e78-ded2-48ad-af32-08de553552bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?/GYMisNUQG/hNSjmjcTnN1v05ZRydEI+UffXILuceajjLGVCbpdanKfKZJlb?=
 =?us-ascii?Q?Zmi5dIVTYtnwyRwbfoZX2rpunuSRwoU7o5Df0PbBLgUz1KzT2Hjwnd1m1Bz4?=
 =?us-ascii?Q?tF/BurExSsbxYlCREgPbVO1sTpD6RNFfst2v0f7ffvTcyGTsMJ0Jkpz0HyiK?=
 =?us-ascii?Q?GEKeTc8StIyJCBHwjz2SBZKQmheTx4IqQU5XZjSzFUshAsN8qkbxtSGqUO0g?=
 =?us-ascii?Q?aGAyksbmS0AOj7X8gQz41jNDklNhAqBBKDWxmvEoJfDSgQVqG8Mcm668eNUL?=
 =?us-ascii?Q?in64c3R1CbPoGRzeiWSpJWteqbyWUObZV1vtdrmVMUqvlpRhUfGu0Y3LVYE/?=
 =?us-ascii?Q?loKHXNULKTWhNtcSa2PsjK2Wjk0etKETDVvDYSQHLKhA1qhbI470hrGbsXIC?=
 =?us-ascii?Q?Uah5P+doI/PIgy4zpCrhVVe7zu2rwaTyikswdTnh/IS4Z0NAsvgOr21Vb84u?=
 =?us-ascii?Q?1iJRkqxrd9O+bJZ1G0A+uqRHrwtrIpg6uv7MndhsJNeSdz2GnUXI9Nptmx7y?=
 =?us-ascii?Q?rbdmILoNSlFPsm8yDsdCB19vX17qoVkrWAjbmB3n0gzbualVTcEfGCDZ4V3Z?=
 =?us-ascii?Q?1/Z2VMHIb85rWnIc05UQ1fqEgbDB5peQUySDWiZfv8rSJ2aEzhwW6EJsq6ww?=
 =?us-ascii?Q?yCcB5g569+sDRK3WSGh1Ly2U1eItai8Q7cBFZ29QP4NitPxHcNBGYlFPQAm3?=
 =?us-ascii?Q?WdKul4iC4v8YV8ObjzJCKbSC3nU8r//12tFbdnJY6+WaJxK4jQSZtUGq0sEJ?=
 =?us-ascii?Q?qfDl2YKJGBePZf0bjiLEZ+IRHBJh2D3rcQu068ptKBPVjIt+2ALcNS94XL/b?=
 =?us-ascii?Q?UtCAMe10dRT0UmyR1x3CEynWbpPpbm2/nH+2JI7/kuvuLBsiXnDhFzwGWpp5?=
 =?us-ascii?Q?xx2bGX7YZo09SwTxLtEx/LRkWgkZuLbIYk2M4eo1BeVGl+dz1QJOIlMM78OX?=
 =?us-ascii?Q?KKStPUnVGf/fWsoGQzRnnu5i+WTT2hCKM6p+/lnjjXLZf3UaLpS0c+XLe6zS?=
 =?us-ascii?Q?kezu9q/TouPm1WEkiB2+K4kSiCoFfaQ+sxbfk5bSObMT00zDnuap8MEe8Gtu?=
 =?us-ascii?Q?6KEfVrWXSJ5/rfTW3tq2Kq0vzsekL12wdV0WwdcyA7pv96cgW3XRtzUf76Sf?=
 =?us-ascii?Q?MWGIG5mOHL91NffH8zf3uuVVhhJUq9+NkEefGrPyFfFRhGsdsR9sklezkhA2?=
 =?us-ascii?Q?O5jDjvYpwQzb18lv+QpPWAaDY8xQXdEBJpp5CELWYeifwsuJH3L6Zpx5QCZL?=
 =?us-ascii?Q?i1okuOIVfuYW+/Cii3/gAaoCmYt74ifw73vBsmCACh7YRHeo2NdcxSEv9FsP?=
 =?us-ascii?Q?d5HuHANr4lRyOnYy5U9kxZpNNEYDslyfgmI/UfaUnFLENXb9yoihpJfSHHt2?=
 =?us-ascii?Q?hiY30BvAfOCehHWsU9K8M9UjXy2bV4Lzyc9fLDiA5tplGz0EBwFBLe+3PcKN?=
 =?us-ascii?Q?F9ipwbtVz/l+VodSMB7iQ5redit+WPiEIS4/oV3hAIHjtevjHQm8c6qFmwqD?=
 =?us-ascii?Q?UI1bJXtHon61P4Dh0xdaGqyynT3v71H+fC4B7vsWScUqA9dKcthP/c6/lKKT?=
 =?us-ascii?Q?e7L+5SU04DTyR9grSHBWFeQH2f1j1N3lG1xaWk/lMCzGwWEMmLt+h1wc0GoH?=
 =?us-ascii?Q?guepPdOb1iA3DJ4IbRSbYLMQkF+My/EtYEj0nFJ7+EojI2b8T8eBhIKr8ywK?=
 =?us-ascii?Q?eq2JaQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 19:27:44.2428
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 012f6e78-ded2-48ad-af32-08de553552bb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468A.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9600

From: Sean Anderson <sean.anderson@linux.dev>

Transition axienet_probe() to managed resource allocation using devm_*
APIs for network device and clock handling, while improving error paths
with dev_err_probe(). This eliminates the need for manual resource
cleanup during probe failures and streamlines the remove() function.

Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
Co-developed-by: Suraj Gupta <suraj.gupta2@amd.com>
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 83 ++++++-------------
 1 file changed, 27 insertions(+), 56 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 284031fb2e2c..998bacd508b8 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -2787,7 +2787,7 @@ static int axienet_probe(struct platform_device *pdev)
 	int addr_width = 32;
 	u32 value;
 
-	ndev = alloc_etherdev(sizeof(*lp));
+	ndev = devm_alloc_etherdev(&pdev->dev, sizeof(*lp));
 	if (!ndev)
 		return -ENOMEM;
 
@@ -2815,41 +2815,32 @@ static int axienet_probe(struct platform_device *pdev)
 	seqcount_mutex_init(&lp->hw_stats_seqcount, &lp->stats_lock);
 	INIT_DEFERRABLE_WORK(&lp->stats_work, axienet_refresh_stats);
 
-	lp->axi_clk = devm_clk_get_optional(&pdev->dev, "s_axi_lite_clk");
+	lp->axi_clk = devm_clk_get_optional_enabled(&pdev->dev,
+						    "s_axi_lite_clk");
 	if (!lp->axi_clk) {
 		/* For backward compatibility, if named AXI clock is not present,
 		 * treat the first clock specified as the AXI clock.
 		 */
-		lp->axi_clk = devm_clk_get_optional(&pdev->dev, NULL);
-	}
-	if (IS_ERR(lp->axi_clk)) {
-		ret = PTR_ERR(lp->axi_clk);
-		goto free_netdev;
-	}
-	ret = clk_prepare_enable(lp->axi_clk);
-	if (ret) {
-		dev_err(&pdev->dev, "Unable to enable AXI clock: %d\n", ret);
-		goto free_netdev;
+		lp->axi_clk = devm_clk_get_optional_enabled(&pdev->dev, NULL);
 	}
+	if (IS_ERR(lp->axi_clk))
+		return dev_err_probe(&pdev->dev, PTR_ERR(lp->axi_clk),
+				     "could not get AXI clock\n");
 
 	lp->misc_clks[0].id = "axis_clk";
 	lp->misc_clks[1].id = "ref_clk";
 	lp->misc_clks[2].id = "mgt_clk";
 
-	ret = devm_clk_bulk_get_optional(&pdev->dev, XAE_NUM_MISC_CLOCKS, lp->misc_clks);
-	if (ret)
-		goto cleanup_clk;
-
-	ret = clk_bulk_prepare_enable(XAE_NUM_MISC_CLOCKS, lp->misc_clks);
+	ret = devm_clk_bulk_get_optional_enable(&pdev->dev, XAE_NUM_MISC_CLOCKS,
+						lp->misc_clks);
 	if (ret)
-		goto cleanup_clk;
+		return dev_err_probe(&pdev->dev, ret,
+				     "could not get/enable misc. clocks\n");
 
 	/* Map device registers */
 	lp->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &ethres);
-	if (IS_ERR(lp->regs)) {
-		ret = PTR_ERR(lp->regs);
-		goto cleanup_clk;
-	}
+	if (IS_ERR(lp->regs))
+		return PTR_ERR(lp->regs);
 	lp->regs_start = ethres->start;
 
 	/* Setup checksum offload, but default to off if not specified */
@@ -2918,19 +2909,17 @@ static int axienet_probe(struct platform_device *pdev)
 			lp->phy_mode = PHY_INTERFACE_MODE_1000BASEX;
 			break;
 		default:
-			ret = -EINVAL;
-			goto cleanup_clk;
+			return -EINVAL;
 		}
 	} else {
 		ret = of_get_phy_mode(pdev->dev.of_node, &lp->phy_mode);
 		if (ret)
-			goto cleanup_clk;
+			return ret;
 	}
 	if (lp->switch_x_sgmii && lp->phy_mode != PHY_INTERFACE_MODE_SGMII &&
 	    lp->phy_mode != PHY_INTERFACE_MODE_1000BASEX) {
 		dev_err(&pdev->dev, "xlnx,switch-x-sgmii only supported with SGMII or 1000BaseX\n");
-		ret = -EINVAL;
-		goto cleanup_clk;
+		return -EINVAL;
 	}
 
 	if (!of_property_present(pdev->dev.of_node, "dmas")) {
@@ -2945,7 +2934,7 @@ static int axienet_probe(struct platform_device *pdev)
 				dev_err(&pdev->dev,
 					"unable to get DMA resource\n");
 				of_node_put(np);
-				goto cleanup_clk;
+				return ret;
 			}
 			lp->dma_regs = devm_ioremap_resource(&pdev->dev,
 							     &dmares);
@@ -2962,19 +2951,17 @@ static int axienet_probe(struct platform_device *pdev)
 		}
 		if (IS_ERR(lp->dma_regs)) {
 			dev_err(&pdev->dev, "could not map DMA regs\n");
-			ret = PTR_ERR(lp->dma_regs);
-			goto cleanup_clk;
+			return PTR_ERR(lp->dma_regs);
 		}
 		if (lp->rx_irq <= 0 || lp->tx_irq <= 0) {
 			dev_err(&pdev->dev, "could not determine irqs\n");
-			ret = -ENOMEM;
-			goto cleanup_clk;
+			return -ENOMEM;
 		}
 
 		/* Reset core now that clocks are enabled, prior to accessing MDIO */
 		ret = __axienet_device_reset(lp);
 		if (ret)
-			goto cleanup_clk;
+			return ret;
 
 		/* Autodetect the need for 64-bit DMA pointers.
 		 * When the IP is configured for a bus width bigger than 32 bits,
@@ -3001,14 +2988,13 @@ static int axienet_probe(struct platform_device *pdev)
 		}
 		if (!IS_ENABLED(CONFIG_64BIT) && lp->features & XAE_FEATURE_DMA_64BIT) {
 			dev_err(&pdev->dev, "64-bit addressable DMA is not compatible with 32-bit architecture\n");
-			ret = -EINVAL;
-			goto cleanup_clk;
+			return -EINVAL;
 		}
 
 		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(addr_width));
 		if (ret) {
 			dev_err(&pdev->dev, "No suitable DMA available\n");
-			goto cleanup_clk;
+			return ret;
 		}
 		netif_napi_add(ndev, &lp->napi_rx, axienet_rx_poll);
 		netif_napi_add(ndev, &lp->napi_tx, axienet_tx_poll);
@@ -3018,15 +3004,12 @@ static int axienet_probe(struct platform_device *pdev)
 
 		lp->eth_irq = platform_get_irq_optional(pdev, 0);
 		if (lp->eth_irq < 0 && lp->eth_irq != -ENXIO) {
-			ret = lp->eth_irq;
-			goto cleanup_clk;
+			return lp->eth_irq;
 		}
 		tx_chan = dma_request_chan(lp->dev, "tx_chan0");
-		if (IS_ERR(tx_chan)) {
-			ret = PTR_ERR(tx_chan);
-			dev_err_probe(lp->dev, ret, "No Ethernet DMA (TX) channel found\n");
-			goto cleanup_clk;
-		}
+		if (IS_ERR(tx_chan))
+			return dev_err_probe(lp->dev, PTR_ERR(tx_chan),
+					     "No Ethernet DMA (TX) channel found\n");
 
 		cfg.reset = 1;
 		/* As name says VDMA but it has support for DMA channel reset */
@@ -3034,7 +3017,7 @@ static int axienet_probe(struct platform_device *pdev)
 		if (ret < 0) {
 			dev_err(&pdev->dev, "Reset channel failed\n");
 			dma_release_channel(tx_chan);
-			goto cleanup_clk;
+			return ret;
 		}
 
 		dma_release_channel(tx_chan);
@@ -3139,13 +3122,6 @@ static int axienet_probe(struct platform_device *pdev)
 		put_device(&lp->pcs_phy->dev);
 	if (lp->mii_bus)
 		axienet_mdio_teardown(lp);
-cleanup_clk:
-	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, lp->misc_clks);
-	clk_disable_unprepare(lp->axi_clk);
-
-free_netdev:
-	free_netdev(ndev);
-
 	return ret;
 }
 
@@ -3163,11 +3139,6 @@ static void axienet_remove(struct platform_device *pdev)
 		put_device(&lp->pcs_phy->dev);
 
 	axienet_mdio_teardown(lp);
-
-	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, lp->misc_clks);
-	clk_disable_unprepare(lp->axi_clk);
-
-	free_netdev(ndev);
 }
 
 static void axienet_shutdown(struct platform_device *pdev)
-- 
2.25.1



Return-Path: <netdev+bounces-114451-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 92AFC942A1D
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 11:18:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D9F31F2554E
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 09:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F12891AD408;
	Wed, 31 Jul 2024 09:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xOF84qCh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2059.outbound.protection.outlook.com [40.107.243.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA94D1AC43A;
	Wed, 31 Jul 2024 09:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722417399; cv=fail; b=adl7lvMY6keoTWdS1kilDhyGY2LYaFnVvg7ZqGL0AEbp/+bA8JyY+ePLD1qEaDNVG56+QFJ0eHxIQOScZA/w/8mnpdkHVLLc/guS07SPtzijNW9vh5ywEDf7zFe8t+BfbXXy/U/4xiTMNGwzogqKo/2OjR1CgNSTeqjUQUtPkKc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722417399; c=relaxed/simple;
	bh=nEJxcsk3z/+w7zN0PGKDwUPVkinSBftSMY4JGUUbfTU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d6lxwfMk1E4rpBPyyWW8prA7vwmN9q/tkWhFY6Weq0WUsfA+7/7AC+W9jRLF3X+RMefAB1b+pALgLjn5ofGCI1h+93S/2STk8AFvhj/t5pFkcqZsZhCBfQrlu8E8eFOwH/FLjFaij5HuG9RQtDZkvAMHMrEnwfaEqaPBWUREnVs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xOF84qCh; arc=fail smtp.client-ip=40.107.243.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GEMs86WPB4076jMgoHuKbLu3FC/GpZ/zidOZrn6GUhOMiKTOJIrs3QJWHGKnuXuOhSbpuoq9+8YrmVtCXw11BaruzgOrrARTpqvmfjbaMdoQPjazB42XcdDkcnKR2ennYALbu/SdghMTMD9kh9YSjz/nAXi3aanroSmb+BTZO/VLmMMPOWIYNsIa82c3hSZjqc2I6C8O1yC5q9W/txsY0GpLERk350UMWaZ0ObD9wveAH2t7ITJq82EobgdTvV9x7nx6N6AN4FgFr3HncfYACGVGaalf9Vz7vAFoq0RXf9GDSnvRPulQr2N+4fIEDx5ziKCVqUrt7ud7QjL2z9+dNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bXELZViAFrOZ9hnA7vBmpL7uxyEmPDETiSR2rIar47A=;
 b=rV0JaKNSA0hkOVmE8yzZ1qy9k/owTKig6ppqIejJaaxnXCNG9kg2fYSRSyMLQQXSVNeSiHozn3wxCu90w5RmmkQc03DDH37eDK0faKHEdbVMqHfpfRkAu5SZZhY8SvyP0NYm9s3s7154F69cMohqrc5W8k0WJ4/VMoqtZoFq2hEkgl1SPqUoY8A1lUcry+z1dnRc0CUu3nxW+/b2f2o7uWGS0kkSHjdS7TdYAylTEWMfI/VaNjKKHP/sU7wcWY6noAsnPsYs6czJPjfpf8jx2MhTCuaVNkAY2vxyZcPEx18h0AGiLD6eHeHRq7UtDK3MlTio0vvj30A6+wSaWjC4zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bXELZViAFrOZ9hnA7vBmpL7uxyEmPDETiSR2rIar47A=;
 b=xOF84qChYgbCBN6Von2GEqJZunmc1QBTGuaS7NdjqJL3xHwuFFuwXK52uTet/ddDSWGLbSoc6rfftMl1tonRdDrJHgr34FW0YDlE0gg9zbITmajvH/8t+qwn1FR1aySAODFGajWmMGogobdlvSN3PfKAp5m5xz0QrmMyDbdOwmM=
Received: from PH8PR22CA0007.namprd22.prod.outlook.com (2603:10b6:510:2d1::12)
 by CH3PR12MB9284.namprd12.prod.outlook.com (2603:10b6:610:1c7::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.19; Wed, 31 Jul
 2024 09:16:32 +0000
Received: from SN1PEPF000252A1.namprd05.prod.outlook.com
 (2603:10b6:510:2d1:cafe::85) by PH8PR22CA0007.outlook.office365.com
 (2603:10b6:510:2d1::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21 via Frontend
 Transport; Wed, 31 Jul 2024 09:16:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000252A1.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7828.19 via Frontend Transport; Wed, 31 Jul 2024 09:16:32 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 04:16:31 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 31 Jul
 2024 04:16:30 -0500
Received: from xhdradheys41.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 31 Jul 2024 04:16:28 -0500
From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>, <andrew@lunn.ch>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <git@amd.com>, Radhey Shyam Pandey
	<radhey.shyam.pandey@amd.com>
Subject: [PATCH net-next v2 3/4] net: axienet: remove unnecessary ftrace-like logging
Date: Wed, 31 Jul 2024 14:46:06 +0530
Message-ID: <1722417367-4113948-4-git-send-email-radhey.shyam.pandey@amd.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1722417367-4113948-1-git-send-email-radhey.shyam.pandey@amd.com>
References: <1722417367-4113948-1-git-send-email-radhey.shyam.pandey@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A1:EE_|CH3PR12MB9284:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcd3968-e68e-442a-522e-08dcb14177d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?xFdxGSDksUvFTrFZ2o/L9eHbov4xPAQwQ6BURKjJX0W6+QWHhFMPSHYROUis?=
 =?us-ascii?Q?pOttNixbnfftOttWeTRxHAfPnx3/7Eebbc+B6xC7Qnb9XfmbKR/UxjIHckVB?=
 =?us-ascii?Q?WI/1w8ZmOSSUJPh1746MLZLkEKXff+x4JHmOv5oaNlromeEGzPgYCq4eIFYo?=
 =?us-ascii?Q?TQd47c3sTg3kMbO+Dz3OqFKgVk5aXHFGlI6+nTJtrXJjpseHUY5IlSMbzfae?=
 =?us-ascii?Q?QVT4KapZ3e0Rdg85ut1Li2iTSX//c2uXyGTq7buhBCERmjQ0LoRR71Q6OepX?=
 =?us-ascii?Q?WucWdg+BBkoVmg+onK8Lx2Gzrnk8oVUGd5I3tch01M617EqoGFoA7PTZmkeU?=
 =?us-ascii?Q?Vs4ucquyiM0ygXghqoJqibUdYaaPFoecWqnwx25WdP0sKnGxhJHIVQPpbkD9?=
 =?us-ascii?Q?cE99jve4ecxC921rv71IyVGwmRaVHL+yg09R1bSJbsyD9snAo79ZiSJoAUfk?=
 =?us-ascii?Q?Q4f5NFp+ZmiRofJ4/YwwEMONAbSRRX94Rb/yQaMuYgX1Xr2BMv4g2VB1Uz1P?=
 =?us-ascii?Q?8XajCoNwkej/tEYNhspYxIiF9u367FgpTLEds8wHZJrd90odZ1erk2KdxDAb?=
 =?us-ascii?Q?e53EC3vYx2VrIs8oIgUncCrfM1E7dhSvw6ruTZtk0iw8Ezom6O0nOerK4jgh?=
 =?us-ascii?Q?4MNn2Ojnqfx4iJ9hmJVXRFJQNO+LWwUqm8FNLno5Iwipkxgq863Ga1fF+y8/?=
 =?us-ascii?Q?qpwfXYrgfzokMUs7JN8fYYLNZutZ/uF2hkvwVRWk3b0BB/PWNxT/XIdRav2m?=
 =?us-ascii?Q?NjU7BVXgwNEebUKuwp/XGVu3S/ZWFVfIymQ2Ywen9rGmSxmUhHENFZxODX3y?=
 =?us-ascii?Q?fOdLQB+wOzIRgGb4VQHxm4c4MyhDxeF662fHcgP9ANy5vId67ftcPdrT2bDk?=
 =?us-ascii?Q?4K7sCh12cy5+wB0rDB17bznFjkDKP6kKcnrJTDv3gS7DtwR+DwrbFnxL37w5?=
 =?us-ascii?Q?SqJjC398Bko8pMBGAAZxsBj5Obd80abd1wvUzktRM4zHVqdHM/5jtWUDrMzv?=
 =?us-ascii?Q?H6zqNRT+/YzZYSacxKDG6eH5BA26GmhSXmVR5ZEPxZq1m3DGmAIAomAT8HAY?=
 =?us-ascii?Q?a6cNJdCK3h78ZWwGF9aVwLw/w891aNcYLnqr19myIAlqSz/Tei0TIgYCcwNt?=
 =?us-ascii?Q?pnlh0mbt9PyHPHNNusk98UD2HVZ60UVTw3NRs4/ourW8UBQwR004o1LOeZD0?=
 =?us-ascii?Q?dzj1TZljOKcKPr0uyy+UNv+6b3B96Zp4ygkeX+c+EE6k4eC2LQjZ3Cf5p9BV?=
 =?us-ascii?Q?ulfrQyBQ1DaNSYO57Jy2kjhUKntAGcgLSuE691vufUgNld5f3y1PDVW2HdW1?=
 =?us-ascii?Q?tCxoYucZ6Y+OcyvgVzevx0eQwMMO+BodS4fElt3cc6hY6QDg3ztgvtFLCMFe?=
 =?us-ascii?Q?3hFhM2rOibtP8xEI0ErxG3R13EI0WDynIo8eTWffxUZVlGlz1tkSrxKhv86T?=
 =?us-ascii?Q?jaj7xRFDiKuzB1hvw8oP3oJq8CfNLAC5?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2024 09:16:32.0420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcd3968-e68e-442a-522e-08dcb14177d7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9284

remove unnecessary ftrace-like logging. Also fixes below
checkpatch WARNING.

WARNING: Unnecessary ftrace-like logging - prefer using ftrace
+       dev_dbg(&ndev->dev, "%s\n", __func__);

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
---
Changes for v2:
- Split each coding style change into separate patch.
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 7a89d4fbc884..f8381a56eae6 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1515,8 +1515,6 @@ static int axienet_open(struct net_device *ndev)
 	int ret;
 	struct axienet_local *lp = netdev_priv(ndev);
 
-	dev_dbg(&ndev->dev, "%s\n", __func__);
-
 	/* When we do an Axi Ethernet reset, it resets the complete core
 	 * including the MDIO. MDIO must be disabled before resetting.
 	 * Hold MDIO bus lock to avoid MDIO accesses during the reset.
@@ -1577,8 +1575,6 @@ static int axienet_stop(struct net_device *ndev)
 	struct axienet_local *lp = netdev_priv(ndev);
 	int i;
 
-	dev_dbg(&ndev->dev, "axienet_close()\n");
-
 	if (!lp->use_dmaengine) {
 		napi_disable(&lp->napi_tx);
 		napi_disable(&lp->napi_rx);
-- 
2.34.1



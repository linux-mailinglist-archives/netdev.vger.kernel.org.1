Return-Path: <netdev+bounces-241130-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4D9C7FD1D
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 11:11:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BCCA1342DF9
	for <lists+netdev@lfdr.de>; Mon, 24 Nov 2025 10:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A8312F744B;
	Mon, 24 Nov 2025 10:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E5biixTb"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010064.outbound.protection.outlook.com [52.101.201.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FD6523BD1A
	for <netdev@vger.kernel.org>; Mon, 24 Nov 2025 10:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763979114; cv=fail; b=mfQTVoOHQA97xfGEoSS5R5ZEgpvpNzRTjvSKS2c8vw40KANnJfExhDbkA/wkqHUNPtJIZQJDhjIRu36OHUyrKnUdBMvZJumwWQkjrSMRgxQeD3BZ5DiA0BWMbyXcxGNPluonGnYhHGiC+V++P4yanq3HI3Yz6MzAltPgFlqLqlQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763979114; c=relaxed/simple;
	bh=ojLsIKskDZ+Ujdv/6la0fPCNI2oYxx3CcE370U1ByKY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pYIYshwdIcbi/bwSDXMMnXkDLT1GD5jFgz6GjPePn/9nkU4ll9iayzI3iKgMYHZPDmRXD0xykzveiX+BwZYCOkZzHn4aVpzSzh46+7/zvfCD2iqCvTGyu9vs5g88nDm5IensgRO9VzAmy/oX4LiNI+lFUzhz4SHreN9xBprTXW8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E5biixTb; arc=fail smtp.client-ip=52.101.201.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pAzso4UtbVeiArfbpLPo4iTuhkBy+84N8PB+ELp4ubogenVuNMfA2MflUpN39G8L3QvBNMwvxboO0OYgZ3xksAzdznS1zsJGdWIev/4PZ+X4AFfAnNxPqOgbeFeg65A81GMatCVe9dg4oQnLyFZGUXCXPhkEJI+tlKFSdwGUvdzbIH4XnOLL/WXcJmdlphgViOQFlzaXNPdAZZczmNoqX+6gPhHADe73oxC9d5iEKqUJVM4QkyguHT1nqdOEN4t1PtP51LGT0+bIKhrtGzxUI0OnV7CVrcl+SPcQzPskNRIQQhteJOR+xvJ1FKQ0BYTGy97OIun1+x3xlqyPNMWwkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AHHxl3VDPHiq3Bg1POqWNihjvCZ86FEi8xommpZ2I+Y=;
 b=VS+qGiB/N59Ph48F3WQjxo9AHe3q22SUidarbJSTRFPx6zLrob32J7fcP9l7OF2LjLrIcO8XC59EpTmjdvs4sn4b9KrcKTA4stBFR8l6sBXzpI0KRXQbwSy4Ti7e97B83S1dmUqI88NB6ceF6XHeCIZ2LgrApU1sxJxgG2jidOGs+Zpgr9UMbdrfa2qfTxJdHGOkQbxu0QCAK1MCMM1xyumGf2dc2UYt2mDylIbJnwT5li8O/wxhIDCEKiIgKKo4/aNtLHXx7Yyd61zq1DVUpH7sSTqVMII1zGaDpCcSjXAtAYoouBnGEAL14BtwS/Jvw/g4EZIi0jiWTBRQhgI/ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AHHxl3VDPHiq3Bg1POqWNihjvCZ86FEi8xommpZ2I+Y=;
 b=E5biixTb6P0TEYIe63rXzWF1to9wXNa5QECAyVIFNqskOTqsWGqYFP40SnTt4+6RQRwk5ebFEAkmDpCnc++c3EnTzVXbFTMXrK+MuegtDKnsjh0BB4XyCOxm5dAE1RBvUDtA5E4OC57b8RjXS/MMy3nQFFuxGykaURLaxKC2abc=
Received: from CH0PR03CA0363.namprd03.prod.outlook.com (2603:10b6:610:119::32)
 by CY5PR12MB6480.namprd12.prod.outlook.com (2603:10b6:930:33::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Mon, 24 Nov
 2025 10:11:48 +0000
Received: from CH2PEPF0000009A.namprd02.prod.outlook.com
 (2603:10b6:610:119:cafe::cc) by CH0PR03CA0363.outlook.office365.com
 (2603:10b6:610:119::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.17 via Frontend Transport; Mon,
 24 Nov 2025 10:11:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF0000009A.mail.protection.outlook.com (10.167.244.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Mon, 24 Nov 2025 10:11:48 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 24 Nov
 2025 04:11:46 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next] amd-xgbe: schedule NAPI on Rx Buffer Unavailable to prevent RX stalls
Date: Mon, 24 Nov 2025 15:41:11 +0530
Message-ID: <20251124101111.1268731-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009A:EE_|CY5PR12MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 6b4c77ac-6f4a-4802-85c5-08de2b41e161
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?4Kx1RnEkStqbP16/lk0Tq5/V/UieuzFBWNDjp+gTmf6Rd7qC/qpmj0Vg4CCP?=
 =?us-ascii?Q?PC7Oqr4HXqnWdVwUYELQaALwIS7rtDIl3+QZO5w8YuBH42AYRANPrvk6jqQP?=
 =?us-ascii?Q?5r+qr0U8hFMwOyutmpDU0HmfJ1JVWEU/FzgTpiaLn8MilA1/VU57tyiaCp3u?=
 =?us-ascii?Q?xQ7Fvc4FugGMpxj53I4Qrv1A/06mig5KXx6tncHh6AH6Px6v2xHXIlGYSrg+?=
 =?us-ascii?Q?6Y7m2PvSHTRzUHCJ1cU7BJc/vp7s/U7rGJ8W+bW8DCJ93KJw6qfNiOSCcUyD?=
 =?us-ascii?Q?JoAWfV86sN+t1xOJOgKNNLa6fgnpwXCrP+11pHO+wDXihDYPu8rrYztusZEY?=
 =?us-ascii?Q?oKP9WgGO5OGKpYEMFp6mNhSfbijjFDcS+pAARKShGkNyJ2PkBT/9JBSFdeJG?=
 =?us-ascii?Q?9MGkxW8j97fKJfrttp4OhUGOh1P+O3/v2XaVZH7J+Eb73+uUgF/CwA106XwB?=
 =?us-ascii?Q?86BDnu8TrW7JBkCrcjdje445/J02Cz7WqyYB/hDuCydVI0g/Pg5McHGaKxAt?=
 =?us-ascii?Q?a+58Gtt+dXK++Ky3DBS9wjEFY84cQAJ52FDFIcc2sUMaTHOsAoByzxARa5ci?=
 =?us-ascii?Q?PX7fVo16mexrLU8Rlj4GGJh5sPykjGoLelk3dFz1FgIXbjkjul1jVNzp9+4Q?=
 =?us-ascii?Q?KWcHYTP+q5SXghmgrEsvr2sz4zbT1Df6rqDDrWwNoxDqtldRetunTqZkmWTx?=
 =?us-ascii?Q?3CqhDq9SHgQvh8szkThOSsqrVkJIlI91xZ/4EOIpXfq1yciGAhCFCRMKIZAi?=
 =?us-ascii?Q?K/Uj8xQvvb2ODtx/CznHOY+E6dL+WWLeoLTqB8/8LeYG8f8LaYt+UOcw7QBk?=
 =?us-ascii?Q?vO0FrWGwCUzRhqFHhj3baBxRTWP4jSaDtzTLiWn1IN+A931OaWFZl8h76s73?=
 =?us-ascii?Q?Y9w2l2MfVODwQOrnf+KrbNmNl3aij9GiSQgJBuZo0Elx3H+MrXNtE/2Ah8Ag?=
 =?us-ascii?Q?I+lakeK+CTzfKlFpWMmKhlMOEuBP2Zwaon+D1sREmKObJE5M5qtFQ+2CqlSX?=
 =?us-ascii?Q?cTRRLkBbruCBlKpe7g9UMchhlv0l3yEQXeadGKGZW3Umbg3MUs5DDACxRmVt?=
 =?us-ascii?Q?Wo7Qq1u+81AjRFmTW4bNyRSMl49/xr2PM0Qitv1iXgvSEYfyGJA+FiQKysdp?=
 =?us-ascii?Q?QrIs8wZb5q8uUsmyiMYMZn4JCFGnv4DHWlmVSqxVNGK6N1/ksdssCCccGwm4?=
 =?us-ascii?Q?kYdSLmK6azzGeh/dI6L4NmW/A2hZwzvo1xVTuPDgaQi6hslJ3oZrrWWXvTOp?=
 =?us-ascii?Q?RPAFDEojHq28AlrjG2y4QoHDyZft3GVTKIwLoyR9S8nlhG8AaH4WU+TNYuGB?=
 =?us-ascii?Q?4Z6knSxtj21YAWsXSrgwlByaPI+L9f39kXVw5P8SFL7JdQW4i1Mk/aCUNlOh?=
 =?us-ascii?Q?G6HKPrR7LnvE52YvSCfXNf4l9DbFDNyuIfRiQ6KcFuxDkMesSF8uTIr3IjGR?=
 =?us-ascii?Q?yHsKpO+Uu4Ihb9ipORh76uoXPv7P8+R0qFfpGyXKUlnmXmYGBOBcZphqxjX0?=
 =?us-ascii?Q?3uXN29WoLN+Sy6rQPUe8+pUEhvNFeRI+ZsYiL2b1tb1bEPzd6+8ohSei4IQ/?=
 =?us-ascii?Q?vKw0mgE5U1G8y0ikuAs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Nov 2025 10:11:48.6765
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6b4c77ac-6f4a-4802-85c5-08de2b41e161
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6480

When Rx Buffer Unavailable (RBU) interrupt is asserted, the device can
stall under load and suffer prolonged receive starvation if polling is
not initiated. Treat RBU as a wakeup source and schedule the appropriate
NAPI instance (per-channel or global) to promptly recover from buffer
shortages and refill descriptors.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 73 +++++++++++++++++-------
 1 file changed, 53 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 0653e69f0ef7..ec030198b710 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -367,10 +367,11 @@ static irqreturn_t xgbe_ecc_isr(int irq, void *data)
 static void xgbe_isr_bh_work(struct work_struct *work)
 {
 	struct xgbe_prv_data *pdata = from_work(pdata, work, dev_bh_work);
+	unsigned int mac_isr, mac_tssr, mac_mdioisr;
 	struct xgbe_hw_if *hw_if = &pdata->hw_if;
-	struct xgbe_channel *channel;
+	bool per_ch_irq, ti, ri, rbu, fbe;
 	unsigned int dma_isr, dma_ch_isr;
-	unsigned int mac_isr, mac_tssr, mac_mdioisr;
+	struct xgbe_channel *channel;
 	unsigned int i;
 
 	/* The DMA interrupt status register also reports MAC and MTL
@@ -384,43 +385,75 @@ static void xgbe_isr_bh_work(struct work_struct *work)
 	netif_dbg(pdata, intr, pdata->netdev, "DMA_ISR=%#010x\n", dma_isr);
 
 	for (i = 0; i < pdata->channel_count; i++) {
+		bool schedule_napi = false;
+		struct napi_struct *napi;
+
 		if (!(dma_isr & (1 << i)))
 			continue;
 
 		channel = pdata->channel[i];
 
 		dma_ch_isr = XGMAC_DMA_IOREAD(channel, DMA_CH_SR);
+		/* Precompute flags once */
+		ti  = !!XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, TI);
+		ri  = !!XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, RI);
+		rbu = !!XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, RBU);
+		fbe = !!XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, FBE);
+
 		netif_dbg(pdata, intr, pdata->netdev, "DMA_CH%u_ISR=%#010x\n",
 			  i, dma_ch_isr);
 
-		/* The TI or RI interrupt bits may still be set even if using
-		 * per channel DMA interrupts. Check to be sure those are not
-		 * enabled before using the private data napi structure.
+		per_ch_irq = pdata->per_channel_irq;
+
+		/*
+		 * Decide which NAPI to use and whether to schedule:
+		 * - When not using per-channel IRQs: schedule on global NAPI
+		 *   if TI or RI are set.
+		 * - RBU should also trigger NAPI (either per-channel or global)
+		 *   to allow refill.
 		 */
-		if (!pdata->per_channel_irq &&
-		    (XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, TI) ||
-		     XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, RI))) {
-			if (napi_schedule_prep(&pdata->napi)) {
-				/* Disable Tx and Rx interrupts */
-				xgbe_disable_rx_tx_ints(pdata);
+		if (!per_ch_irq && (ti || ri))
+			schedule_napi = true;
 
-				/* Turn on polling */
-				__napi_schedule(&pdata->napi);
+		if (rbu) {
+			schedule_napi = true;
+			pdata->ext_stats.rx_buffer_unavailable++;
+			netif_dbg(pdata, intr, pdata->netdev,
+				  "RBU on DMA_CH %u, scheduling %s NAPI\n",
+				  i, per_ch_irq ? "per-channel" : "global");
+		}
+
+		napi = per_ch_irq ? &channel->napi : &pdata->napi;
+
+		if (schedule_napi && napi_schedule_prep(napi)) {
+			/* Disable interrupts appropriately before polling */
+			if (per_ch_irq) {
+				if (pdata->channel_irq_mode)
+					xgbe_disable_rx_tx_int(pdata, channel);
+				else
+					disable_irq_nosync(channel->dma_irq);
+			} else {
+				xgbe_disable_rx_tx_ints(pdata);
 			}
+
+			/* Turn on polling */
+			__napi_schedule(napi);
 		} else {
-			/* Don't clear Rx/Tx status if doing per channel DMA
-			 * interrupts, these will be cleared by the ISR for
-			 * per channel DMA interrupts.
+			/*
+			 * Don't clear Rx/Tx status if doing per-channel DMA
+			 * interrupts; those bits will be serviced/cleared by
+			 * the per-channel ISR/NAPI. In non-per-channel mode
+			 * when we're not scheduling NAPI here, ensure we don't
+			 * accidentally clear TI/RI in HW: zero them in the
+			 * local copy so that the eventual write-back does not
+			 * clear TI/RI.
 			 */
 			XGMAC_SET_BITS(dma_ch_isr, DMA_CH_SR, TI, 0);
 			XGMAC_SET_BITS(dma_ch_isr, DMA_CH_SR, RI, 0);
 		}
 
-		if (XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, RBU))
-			pdata->ext_stats.rx_buffer_unavailable++;
-
 		/* Restart the device on a Fatal Bus Error */
-		if (XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, FBE))
+		if (fbe)
 			schedule_work(&pdata->restart_work);
 
 		/* Clear interrupt signals */
-- 
2.34.1



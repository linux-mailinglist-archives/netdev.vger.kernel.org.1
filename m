Return-Path: <netdev+bounces-242735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 9385CC9460D
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 18:51:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0ABC5345664
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 17:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3604722D792;
	Sat, 29 Nov 2025 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="zk/Eym3r"
X-Original-To: netdev@vger.kernel.org
Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013029.outbound.protection.outlook.com [40.107.201.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 852AB1DE8AD
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 17:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764438661; cv=fail; b=d5PPku8L69O9AGnXp3gXLo8VQThNp7Yt2cu/9iFYLihwMlgZeFvHY+ajpNSA14v3CUjUkUzpyrHQgpCseSD7yQ8g/svnKT0BMU4h6et28GwQhRvR1wgzg4Xdf7r4zievra+ADuPG8dvi3DN2iw4gVKMr/Af5/wy0gOjgwrR5q6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764438661; c=relaxed/simple;
	bh=VlL8usTz1W6BmgBYd88AVMkF/IWejW42YiYDHsOmRl4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OPKm4DVaoCDzjZTERWO69ARMUX8HXkvXWMJU9v+nbhzP5ugD9ra1kuxo0x9jroTSFW1VlolFmwDiF0OyoA9om4R4QtwSJz9YpGwQj7WdfBrnPLFevLUulq6P3fNQdsjDzCvPoCJb+6EGxAAeOu9bEEz7T3tJgmdSjIDWjyaXIJI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=zk/Eym3r; arc=fail smtp.client-ip=40.107.201.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NIZoaVwqSae0EP0I45Wt54aFbi54gwWhKklYvOTxRsGP9P9k3NSb0fi9Ie9AzWhNNl+4rntu1kqQp61N/plTd7gVO/5od3SabaTgY++bBzDm9vEBbMbpB2VCKIk5VJ9FBU/PPTOREaUpHlQkgO56329LiU3gfbucO8/f9LY93+HiBdsWFyVAWTOG0/GE8nyxT4jVsqQTLEFGsNeeUB3gN+g527Gq1W7wEkzlJ4o+qkAPLLEEhn18AMsSWkbm+O98AOVW1O8p3z2WFgh1DreLuUTQ03iV7OzPF8hAj/DWFXn3tBfm801nGDa9tj7wyqrj9RSe+9OqrbE0djsr2jWc9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4cpvTnCy7VF5c5rDIIx2huD8hZtcLQ9a6gZoZEgxrG4=;
 b=Ua8K796HE/zShrdiGYQCgKzsqJkYX658P+zJ6ea9w0YmM75xnQ0wempkwfxglnLbHaG6m/1BroDKkf5uga0pNc7MA2dyl1p0xlr1AjZKuDQaBSoywjZWolQsJVZih+obH7vO0AMXCGzaSJc7ns4SwK61bzhTAJOQkEh0eEuCXKVmKWCHOPh0/CbrX9OZ0zp665aZGSOQmH2C/DzXJ5sxGypQivD9W27R6BcC3+cEH+SkoZ464cVb5i92Qp00agAM9+JoRlIrxMbM4/Rm09GrR0uT6DfARsMuvrgBOmlB3Twkz6S7qASS5ce1d2U382siSqtzEcgU14sbsQ7jeubokw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4cpvTnCy7VF5c5rDIIx2huD8hZtcLQ9a6gZoZEgxrG4=;
 b=zk/Eym3rbTmZjwKPcsf4irQWaUTxF6ZeFfFC8ij3x8GKv8mvviwsve/DJZLo+ypbzqLP1cB6KMaP04QWqVFCbQFrxUnqc2Z4VmfbTmgirkvzvFIDdIiXM/ScG3f29zIL6IEJMExOXhVJFgxKecJlLwuj3qK+bNmfP2NzrEQ7NKo=
Received: from SJ0PR03CA0253.namprd03.prod.outlook.com (2603:10b6:a03:3a0::18)
 by IA0PR12MB8351.namprd12.prod.outlook.com (2603:10b6:208:40e::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 17:50:55 +0000
Received: from MWH0EPF000A6731.namprd04.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::94) by SJ0PR03CA0253.outlook.office365.com
 (2603:10b6:a03:3a0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Sat,
 29 Nov 2025 17:50:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6731.mail.protection.outlook.com (10.167.249.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sat, 29 Nov 2025 17:50:54 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 29 Nov
 2025 11:50:51 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 1/2] amd-xgbe: refactor the dma IRQ handling code path
Date: Sat, 29 Nov 2025 23:20:15 +0530
Message-ID: <20251129175016.3034185-2-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251129175016.3034185-1-Raju.Rangoju@amd.com>
References: <20251129175016.3034185-1-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6731:EE_|IA0PR12MB8351:EE_
X-MS-Office365-Filtering-Correlation-Id: 603e34fd-6928-4ca1-0228-08de2f6fd7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zNSGsY6wHU+k49mik14G7FBVNJdmswLrgzwEfKJlEWit4mU4LQh4W5WUGOHn?=
 =?us-ascii?Q?d6bodjQkzo8fkpmNXByIudW1aRMldYHWsjDol5VR9Ezi7qHNLPDKz58Klk1N?=
 =?us-ascii?Q?OKMtqWqAK/zfea/BUUCkj5IoZEYW8V2Fsg3Ylq9pED+VKi4javsKvW9Sn5v9?=
 =?us-ascii?Q?V718i4Zj6yv6nwU2Qi2zjetpZsRw7M/miM9UOrTu6OE6MTLF/c+2sX7AwttD?=
 =?us-ascii?Q?Tx7OuN5qqIqvLnjwGVcl3x74PjhfHRrBf2+4KnWgHMKzA0mPX/ah3NB9+zIN?=
 =?us-ascii?Q?calkV38zXPwxtVsHQ/iKjUpflhhYYbLW1MobY+TSA2Qbm6QR+RqWnTre17az?=
 =?us-ascii?Q?SKg5pKBAJ+fgMe1PeyI0f/fSwiQbZCBicY28bAHQApNrFMQ3qPQtD1ov8qF9?=
 =?us-ascii?Q?JfG6WerrJv5wB97DZo0vGhMZnPCPnxd7X3WCfBE/e+f4XnsHOTj8y8NhE+Cx?=
 =?us-ascii?Q?WY+eYICKx6tphAfn0lEDP3I4bSQvfs+aela1auq0gwHD8cvIbfmD315vgDxb?=
 =?us-ascii?Q?SmKQuLskwk3APIty+TKbIoCVIZeF1nLmNgrBxBiWatEYLCcvR3jP3lSB5TIM?=
 =?us-ascii?Q?CzDlGOypa/81zJYgQ1nfVTENsWh5cvLuRvL6vu7dg+Npeq1S2mTCtNrMFasJ?=
 =?us-ascii?Q?8+6wufZSR6xCzrQ+IE44i8o4/psikPJSOfgUYXhSylEAn9vaoxy+24Xu/u+l?=
 =?us-ascii?Q?HoeW1/uoylQWGHfyLpjYwdJBEHFf4AoF2x86vBD1MCkR6xrvL1eqVpLLmNVw?=
 =?us-ascii?Q?bDRhcrHWcr3iHqUljesvCr0KQ1bK5uBgpou1c0T7kute72Wt8DBKTQ0Yi1a7?=
 =?us-ascii?Q?wwpff74t6Ov8qM5H7OWcuFJsRPKbQiXMrNgDYhx/tVexWGDzeCS19oHMc7FB?=
 =?us-ascii?Q?jb130H2d0C6E/6gF7Yw6oj//WQsEMfJx0tXp0PKqXJj/IJOy6R04KjLcrkBn?=
 =?us-ascii?Q?UWFnismgx1XhRK1H53LF1WvLa85Dds4+3loRmOVWYwEPFK7ryCJR9VSlnIRw?=
 =?us-ascii?Q?cYndFueh/p8PPTT9mD4tdcYj3lkAfnGxCCvd7KFad2j77iClkU2NLKvEl2Th?=
 =?us-ascii?Q?MIQp4Cci2HpJuUnpZCw8CFL9s8nGuB53vd8YQaLAxwBqiOKBcwlTCeBZOdfR?=
 =?us-ascii?Q?T8fJo/6pdBF0qDKOeKSj8fnV15KiImRtEj0av34Fm3TEOXw/wnXBfnD5qwhR?=
 =?us-ascii?Q?jLx4jfuGKqheTjmufF0Y2hDWZEotmitYVkTAjsRLl9DPnnBWuHLrCfGrE2Y5?=
 =?us-ascii?Q?MggUWWLLNcFpw6D4ZUvaRJOZQeHCppiuH9s5qWArsGBUBdpwPlh3BgilVRJD?=
 =?us-ascii?Q?hM4+NP7BPmcPJXeyr06Rc+AAN6HrKPO9L5Bb3FReisUu44Vt4wsqlqJ4iSL1?=
 =?us-ascii?Q?sSMijpYXrj0BVTDQKWk+xn5fCMBrT0bzbtayR1Xo7wr5Y8FRNL2ss6g4TjSE?=
 =?us-ascii?Q?y+sI5hT14gTHZtBn2VDszZtWkW+3RNYdny6jnIw+ULWGN0y3WB284QOYMc4O?=
 =?us-ascii?Q?XMVtnwaL80ng8OT5uit7f1qSlN808LjxrpmTBp05Uf9B+fn87I3/iFFA3s+u?=
 =?us-ascii?Q?tIeJfts0kt2xcnnYAnM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 17:50:54.3154
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 603e34fd-6928-4ca1-0228-08de2f6fd7f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6731.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8351

Refactor the DMA interrupt bottom-half handling to improve the
readability, maintainability, without changing the intended behavior.

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 60 ++++++++++++++++--------
 1 file changed, 40 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index 0653e69f0ef7..aca1c57554d7 100644
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
@@ -384,43 +385,62 @@ static void xgbe_isr_bh_work(struct work_struct *work)
 	netif_dbg(pdata, intr, pdata->netdev, "DMA_ISR=%#010x\n", dma_isr);
 
 	for (i = 0; i < pdata->channel_count; i++) {
+		bool schedule_napi = false;
+		struct napi_struct *napi;
+
 		if (!(dma_isr & (1 << i)))
 			continue;
 
 		channel = pdata->channel[i];
 
 		dma_ch_isr = XGMAC_DMA_IOREAD(channel, DMA_CH_SR);
+
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
 		 */
-		if (!pdata->per_channel_irq &&
-		    (XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, TI) ||
-		     XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, RI))) {
-			if (napi_schedule_prep(&pdata->napi)) {
-				/* Disable Tx and Rx interrupts */
-				xgbe_disable_rx_tx_ints(pdata);
-
-				/* Turn on polling */
-				__napi_schedule(&pdata->napi);
-			}
+		if (!per_ch_irq && (ti || ri))
+			schedule_napi = true;
+
+		napi = per_ch_irq ? &channel->napi : &pdata->napi;
+
+		if (schedule_napi && napi_schedule_prep(napi)) {
+			/* Disable interrupts appropriately before polling */
+			xgbe_disable_rx_tx_ints(pdata);
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
+		if (rbu)
 			pdata->ext_stats.rx_buffer_unavailable++;
 
 		/* Restart the device on a Fatal Bus Error */
-		if (XGMAC_GET_BITS(dma_ch_isr, DMA_CH_SR, FBE))
+		if (fbe)
 			schedule_work(&pdata->restart_work);
 
 		/* Clear interrupt signals */
-- 
2.34.1



Return-Path: <netdev+bounces-242736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id BE8E5C94610
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 18:51:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 44A1E3455AC
	for <lists+netdev@lfdr.de>; Sat, 29 Nov 2025 17:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164CD22D792;
	Sat, 29 Nov 2025 17:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0YwLvqMW"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010027.outbound.protection.outlook.com [52.101.201.27])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 830F2238C3A
	for <netdev@vger.kernel.org>; Sat, 29 Nov 2025 17:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.27
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764438669; cv=fail; b=nPILBhWono/XfFgI87adtRFySCSS/ARNGd0Dh6hd8TarmFyz2UWR7WX1G4tTD+SEUWW8a2jJMcOt0wJ8S/Gmbduy6ZvCmrBVHg3TzkCGEIBY6ATF5GfETBMj5SEDeEaTv71vzHa7RyjsevFhYPfHnVqrKc6fBEqoKia+Tqcu/pA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764438669; c=relaxed/simple;
	bh=M6/Ztl3RapLGonOZfiFUcecr+7QjPpH8ih8n7yeRHyM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRsua/LGEirCjn4sjXMhJdEqYOyy+VdOh/juUuiYMSRfQpP/KnbuXsO6EFg8wBMaDCqutXtGYuDgXOCoH7JmKRiL3G2YjPExtYBd4GPoPkKWhyK6zdqlAGd03SP8aP8idOCCNsKNxKhJLvdLSiiALS3BDdvzaQ9OGDQcv6Sj+7U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0YwLvqMW; arc=fail smtp.client-ip=52.101.201.27
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iBYLXhKuh24RNPWS47csTmlMuwd7oIw2Fsp24+EbVRfkLSE7ExkeSk1WLR4crhld/pe1uzgo60yKIl7Y6hKSyA7TajPlGDVONW/lXLv5/LM7sRIBX+6swhYlxRKQHqbku4mF+F15kQRzp/SlY8IjGvIzPN8mZIM9tKjisHjDSm/swZpUIETEtcnhe8KmhGv0jhCYDmWLXm28qzyaI0uhZHN+XQ7RkABoawKG8lCmCfFXnk6dQYrkepAeAltA+1534NGS7SnUqtlvUHRRkIeCGmIBI4U+Pl2ZMWf8NxUr6Lgg0PDKtoL6WVxsQxCn6iSNq+4ZXUaj9MOA6zikMLiREw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z+6YRHJsd2fJPGaFoQF4DcZlRGcmqdJrNwrEHhjflE0=;
 b=omea8y4PmS/3GsN2cxHBxpdbI2Yvw12Qezn1xUumrhNE9Yl47Piy1yWGon/JUP8eU8amLP5ViW+5pIYUIvXUeyIguinKPOfUfLxzHoNkXhpQQH0jIJNE5PnJtiVGpQSB4w/FmzOixh5Db2y1sCbEdDWEuykI7RorjUG/iJTUuoMOCqXwGA5oaV4NIesgwt6ILhAYkC3neS+B5iHlwy7aiQPMkfZTXUkptF4ljkMAWihhrVQPflFivljwIfWNQWFNfKlV7RzBlixLv7HwsgiLXr3uRpH9DePOEa8t8f0+h0KUU/W9n2a1MBHsxS4PxgCEopc1NOZ8TrQCQdWI6caqJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z+6YRHJsd2fJPGaFoQF4DcZlRGcmqdJrNwrEHhjflE0=;
 b=0YwLvqMWkYMmsZqsPfeQT7v2V7xuwScf9CmUQORkJGgEx5RaHrN1PpInC9q+CyR+wbzyd3a89kdO/6MBC3RxkJKkt8NpxnPXnQrx5lW52m4Pluj9r4OAIJ8jpL4SRvWhPj9jm9saBkYP5R1ny7hUp/DIEbG0eWBSPHccbCLY5+g=
Received: from SJ2PR07CA0015.namprd07.prod.outlook.com (2603:10b6:a03:505::28)
 by IA1PR12MB6234.namprd12.prod.outlook.com (2603:10b6:208:3e6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sat, 29 Nov
 2025 17:51:02 +0000
Received: from MWH0EPF000A6734.namprd04.prod.outlook.com
 (2603:10b6:a03:505:cafe::67) by SJ2PR07CA0015.outlook.office365.com
 (2603:10b6:a03:505::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.17 via Frontend Transport; Sat,
 29 Nov 2025 17:50:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MWH0EPF000A6734.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.8 via Frontend Transport; Sat, 29 Nov 2025 17:51:01 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 29 Nov
 2025 11:50:57 -0600
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 2/2] amd-xgbe: schedule NAPI on Rx Buffer Unavailable (RBU)
Date: Sat, 29 Nov 2025 23:20:16 +0530
Message-ID: <20251129175016.3034185-3-Raju.Rangoju@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6734:EE_|IA1PR12MB6234:EE_
X-MS-Office365-Filtering-Correlation-Id: a94b9f97-a940-45b2-40ba-08de2f6fdc04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Somafi1lBuOeK2Z2uexeSVuAfJ5xphL4rtf23Q01QfHlXqD2/rzEOt1m2h1H?=
 =?us-ascii?Q?hoQPGbYPDalI7BccaBjDMX5MC6VYx4+i6IWBVBOgUwteXxBwL1bnKioURNk1?=
 =?us-ascii?Q?atRh0/jo+g4KO85r+LRpSE0O/TaY5KM5fX3VpmZb2ohIzuu/k3nN05X3OSjS?=
 =?us-ascii?Q?+is9dPdvnKRY18X1tpu0Y5AMOmJ2nYIDtAMScySZXx3ZO7a2IJCQSRug33Yu?=
 =?us-ascii?Q?Z4VJgIgquVpSmR1QJfWq8S6hIIZvb+xgMCMxQwCdedLpBc42aP8qb1Nrgbzr?=
 =?us-ascii?Q?erkI/doxeQcxyk6TY5/9Lz5Thqzj72F4NDq1Vetw7K12cz35RoThpqIYRysD?=
 =?us-ascii?Q?ZcRsMrERDgpFUfoDN3P+f3TgiRJju/Y+aBUFcIDotV+oC2+CCItRsRdAlkcp?=
 =?us-ascii?Q?tLf6OjmTbA5OGGyvRrbzOUl5UH9QzNAtkME1RMg5BXGCVyEo3oQ5pDMCjoKD?=
 =?us-ascii?Q?RSLFDGIT2Mg+kK4pRTrF4njOZ5Fc/PzxoDGtL3stwY24hfvdOVIgv0/M0FUX?=
 =?us-ascii?Q?AKIOYVmelqq2seBRnEITEjqXMmhYNqH5FiaRpcmbuUxCZ0OQ7ahrUjWLaTnb?=
 =?us-ascii?Q?uh0pbn0vemyXoSH30r39OJL95CHFqWw0HeXaf52n3I33TbPuqIa9KBFKji/W?=
 =?us-ascii?Q?tydQJTQjyBglLC3Pz5lDUeZTd1GUNFh6ydpIEg0j0jeLsuHjLjnW6H6LuBx7?=
 =?us-ascii?Q?MZ0OuZbCi+Ma8nV8tY5OX7mdn6ZGyf+p9UepEbKMqRKDHZUm+QMdp6Hbhdcx?=
 =?us-ascii?Q?mqKA7jTZOx5rXgcColBLGJ7+TEdL5s45xOVf1hQ+5rmVK0t8ld4hTp4zk48Z?=
 =?us-ascii?Q?XSujdS9Bpn1dj9+TSRWhQ7rdAvNhak8ow36Z6Vp46ovaOtpMKBuo+lr4efjc?=
 =?us-ascii?Q?4wnBPdUuFzVQVFbgMXHnlfDGwJZIx03Rw+iZjxiIO6A7s3oYvYZRF9lPWE9R?=
 =?us-ascii?Q?2oZS/ggppbdMcVIdfCBAU6JAKg5ReZcjescU0A0OefnleihVIt2dlFmKXcOc?=
 =?us-ascii?Q?jhS15VGahrbEU2bfESZsmU4HlCLHRJhHdeAxb9WAZeFZkjDAhXGG6s3Z79k5?=
 =?us-ascii?Q?8zGASXAL4t7BaFp2O6vTrGl6B9OBT0KPeYcIq4EYoaYTcuyLrDR7p9nnMNPu?=
 =?us-ascii?Q?Cqk978gsvqnvWhJC1pYVRH5ynBxsHN9weBMkAFU5q5ikYuMK+RoKZ3F1tzk9?=
 =?us-ascii?Q?FXN8v25H6MngUhNEQ08Ci9LdgoLfhBwDcpk99AuYtQ197R2wQYzkiMZ1rAk9?=
 =?us-ascii?Q?xIbiS48dIEwMtiHHReyXccDtCwtzeUjqL0WynBMMzLvxS+EfeHKzkn41ZRXL?=
 =?us-ascii?Q?yvHCGSfbkAvp3958It9SlAr+7yiXa9qrsw1HwLggEGrAc4f7iDB2LlzIwhYK?=
 =?us-ascii?Q?p5hJae+hSa38pmwT67b48fL+aFd4Hu9UGA4EqmFTHVRGjaZ+4KdP4vlx/aez?=
 =?us-ascii?Q?2+dGAUTRRtKyR+HgXe0CWjPANUYrlG9g9kO5MJoPCkqyEydnd1RsDevGKtj/?=
 =?us-ascii?Q?yCHMnU3r+pcoIpjWexm+k34d691tKRz64dr675x/5mJmfEX9q/zU1pSDkGEn?=
 =?us-ascii?Q?0B7MEJGI2XIPVyqDPI8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2025 17:51:01.1000
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a94b9f97-a940-45b2-40ba-08de2f6fdc04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6734.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6234

Under heavy load, Rx Buffer Unavailable (RBU) can occur if Rx processing
is slower than network. When an RBU is signaled, try to schedule NAPI to
help recover from such situation (including cases where an IRQ may be
missed or such)

Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
index aca1c57554d7..3ddd896d6987 100644
--- a/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
+++ b/drivers/net/ethernet/amd/xgbe/xgbe-drv.c
@@ -410,15 +410,29 @@ static void xgbe_isr_bh_work(struct work_struct *work)
 		 * Decide which NAPI to use and whether to schedule:
 		 * - When not using per-channel IRQs: schedule on global NAPI
 		 *   if TI or RI are set.
+		 * - RBU should also trigger NAPI (either per-channel or global)
+		 *   to allow refill.
 		 */
 		if (!per_ch_irq && (ti || ri))
 			schedule_napi = true;
 
+		if (rbu) {
+			schedule_napi = true;
+			pdata->ext_stats.rx_buffer_unavailable++;
+		}
+
 		napi = per_ch_irq ? &channel->napi : &pdata->napi;
 
 		if (schedule_napi && napi_schedule_prep(napi)) {
 			/* Disable interrupts appropriately before polling */
-			xgbe_disable_rx_tx_ints(pdata);
+			if (per_ch_irq) {
+				if (pdata->channel_irq_mode)
+					xgbe_disable_rx_tx_int(pdata, channel);
+				else
+					disable_irq_nosync(channel->dma_irq);
+			} else {
+				xgbe_disable_rx_tx_ints(pdata);
+			}
 
 			/* Turn on polling */
 			__napi_schedule(napi);
@@ -436,9 +450,6 @@ static void xgbe_isr_bh_work(struct work_struct *work)
 			XGMAC_SET_BITS(dma_ch_isr, DMA_CH_SR, RI, 0);
 		}
 
-		if (rbu)
-			pdata->ext_stats.rx_buffer_unavailable++;
-
 		/* Restart the device on a Fatal Bus Error */
 		if (fbe)
 			schedule_work(&pdata->restart_work);
-- 
2.34.1



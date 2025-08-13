Return-Path: <netdev+bounces-213353-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB259B24B65
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 16:01:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 280BC1886670
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 13:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C444C2EACFB;
	Wed, 13 Aug 2025 13:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FzpMFYMo"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2082.outbound.protection.outlook.com [40.107.92.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3067F2EAB9D;
	Wed, 13 Aug 2025 13:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755093371; cv=fail; b=DvR9y/r5KKWeRdW2DJi37RWGSIf7xNQJDd+wREXlsCbhM2aH6LOIQRR8xqy0s9HvH0P1bmtlMjkJf8p49T/XPSbL+vO+wbtFHscfxvvY8QIZje0WyUBAwqbchNgBRhz4LR0qdDbUprw69Y8S22i+U8l2HKGBGJE075hhMDe8AeA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755093371; c=relaxed/simple;
	bh=SQ/mvG9C8DOTIG2Cswj03Bu2fl0eZfI+KNErQvCjSHw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Rx1A0jsnbkyVGWmuuEnBNBazqBt2rGfL1EP1UYsx+lsDULBU6WQhAZNkEQ3DnyiUb/pL+fzcKfk90tVqPAjhftUgt/0WmANdCxjMHCwQvJtCgGJJfdQ5IxOL0jpuyQnVf888kVZmgmDRJqJmxSkDrdTQm0NFV/PlpQnjY3VHeBQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FzpMFYMo; arc=fail smtp.client-ip=40.107.92.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1bw9ApJDujHPEjMlA1AHVtu/6FQ9ehstqErbkxMGnNi/ptHJaEVleM4pJ95u0e0FcSzr8AI8FXMbjXDB4XRXP9FxLD0PKjQyjxm7gWt5UFe83Xi61NjakFAyztGR4kjZTrBIzblmLatj86F5S0pVgqYQgUeqkNnDnCdxS2WXNqjBliu23oVgNsIx1VDHkXWc6gyu8lBn2BNCiJfMa9kdQNqORJNe+Q3Kyjo6aI6yHFrZUfgjRqs0MFHltxmMrDU/fPTqWF1475+3CNl/0R5b0a6BNw7/Hcm8RtxGVu5ebfIWLWXFPxAH7T1oU18xOaNe6zt8ilkFGM8lPyr8mj7Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P9HDrqSl4eAGAcQQtTWAZCB6ff/9x8DN76oajFwBjts=;
 b=fKaoQU8lIK+tbp+LqANJNvy+Jr44KNrE8M8VHPjI7mQcaDAgnXwpAzQb1ryFA5m54uTcAf96na8XRsMWipE038ACO5bKKTLUm2r/buMLtkyyos1QrDVcS+hFaml1ke++vgYhA8Ji+nPzhIeKUxNG3qbZrSZaOHzkzzxVtfEXR/MDcP3DdlfOeHjTZn0ofgUPwUaiX3oa43eEJY/u/eCy95jOa7LuwLVRef4muW33TdRg13Iyd8V3yNhr21bovwC2by1bV62fsybgY75fHQCEDB5sxcn63J7LxV31dRA7h+ByAYwvgNYtL0QNH20JH/bKTC+WYUPE4u0Djb+w0BsohQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P9HDrqSl4eAGAcQQtTWAZCB6ff/9x8DN76oajFwBjts=;
 b=FzpMFYMo1+PdQRNHdWo98K1wQk9sMw/EsudDFHnX4LtA6H9c2LYthu18SbwCHUhQKEKIpUGf8PGwBzWTPcfsDwsM2hVqPwJZhld4d9jETT/S5reai76WDvu+JRsqqplt7f6sbw3w3ziG1aAgMvf5ilU/SRkP/bbtpGL9d4iWcmM=
Received: from SJ0PR05CA0034.namprd05.prod.outlook.com (2603:10b6:a03:33f::9)
 by BL1PR12MB5900.namprd12.prod.outlook.com (2603:10b6:208:398::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9009.22; Wed, 13 Aug
 2025 13:56:06 +0000
Received: from SJ1PEPF0000231F.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::cc) by SJ0PR05CA0034.outlook.office365.com
 (2603:10b6:a03:33f::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.14 via Frontend Transport; Wed,
 13 Aug 2025 13:56:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF0000231F.mail.protection.outlook.com (10.167.242.235) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9031.11 via Frontend Transport; Wed, 13 Aug 2025 13:56:05 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 08:56:03 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 13 Aug
 2025 08:56:03 -0500
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Wed, 13 Aug 2025 08:56:00 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<sean.anderson@linux.dev>, <radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <harini.katakam@amd.com>
Subject: [PATCH net V2] net: xilinx: axienet: Fix RX skb ring management in DMAengine mode
Date: Wed, 13 Aug 2025 19:25:59 +0530
Message-ID: <20250813135559.1555652-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.25.1
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231F:EE_|BL1PR12MB5900:EE_
X-MS-Office365-Filtering-Correlation-Id: bd1cd7cb-b106-4ccd-8acb-08ddda71257e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|7416014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?CD3NWvFyx/cXv/c0n5a8yMPQoQKbA+rw+RyF9fjG3hlwY7Z5yRSJz15Pg1Kq?=
 =?us-ascii?Q?GPB1nPIbPCAJAtc5vlmSeNe1Xt2oVcl42DL5ivWH8k8XXBRZmh3k7oM/uVlL?=
 =?us-ascii?Q?FFCjOYftGBr1ax6mGyA/w4Wrhxq+FAGS3ezbWx6JQ2Lwm9wOlcpF/0O6XzXR?=
 =?us-ascii?Q?kM4VfZFHTXRYKhGZ5jlgXhj73EzdFreh67j7BtmKQ7cBKEkewwWvrF+XMP/7?=
 =?us-ascii?Q?b+2mZfenzzcX1gAWouPji6qbBISamwfrYQwHK2t27Pp8Q36mcH78rFk0uIE6?=
 =?us-ascii?Q?NdsUUWjHV8E+TofXm+sqC26DEV1p7ETNd7fJEcu3Nws2Uo3seg8yIjhGtOpo?=
 =?us-ascii?Q?QMVXkzc0k0jtLaHy1hphBsBjKIY6K5MYZ4UwNH2H6UP9G2z8A2BgKYHsXJtI?=
 =?us-ascii?Q?Z6mTUZeF6hBxyww6vYkaiJGawS0Tpdfm3wPY5AFGjhV3rFgVURVuRqOoDSrS?=
 =?us-ascii?Q?gNr5NOzAai7Wtbkwr2NIEVn8Dtw09N9K3yGcH4aVViDbKXSB1HnZX+Gk45so?=
 =?us-ascii?Q?C9VABWWS/5ETj7IbCGAJILahdC0RKGS0SP33xg8ZjL964oK4F86zThZJmR9i?=
 =?us-ascii?Q?LXLDG/lG/7sr5clQeIlEEbyK24WRK7/lUxiGZxKh483Y4mEMRAGWdytFpDiB?=
 =?us-ascii?Q?x2x+EPeJQ0qnfNMQtDMlyC2vSrQ3tRaXo22gJWzeFxNy354hei+unJp/S5UP?=
 =?us-ascii?Q?V59rXOV5PonBRimlRL50pTdT1Z0FutnHWjy+Y3fZXaWm7ba0oo/iMgDgc/yT?=
 =?us-ascii?Q?71tJapjKIRwy2Eruma0J2bm7QWJfWyZGrRRF8zAL3C0fjbuHI+8jh8ORa2Ux?=
 =?us-ascii?Q?8fheB7eaP7g3ITR8rwHXT7QmIBlyUf8jAx3/4PywmU1wrJFv2wMu8l1IMYC6?=
 =?us-ascii?Q?PUZ2z1oacB/t7gaiHoK1hv2XEMRgL8ExYR+MsFMRouh4xaPGqKUKwq9jQSVk?=
 =?us-ascii?Q?hy793kzX6RP3QtSANtym6xV4WKouePesv6FkBK2aSmkQgh6VIKPzj5JyCfjv?=
 =?us-ascii?Q?ONI5oMPe8oMjLXgKeypLwcdP0Y+mAuGCBAwxAZe9zclm3slW6PO3XE7GByxo?=
 =?us-ascii?Q?v/LxULyMqiH9gJLgQENdivyimfgkr+GvqKwIXoGoxQRdc+u9hUOOAlSvIiYP?=
 =?us-ascii?Q?QNbTYOYYQTy2sQtdIqw6Yx3+HBp/zXK5uBhGXzdVt5IlHdF9zjXAhJjOpEfA?=
 =?us-ascii?Q?ZUG/6pf6PIgesFOJRlJUM2JI2ucyfLZ9cQoCOztLfDorkjTqJsVRXkyqFdE8?=
 =?us-ascii?Q?5Y7TdrRsEOZBqQtTIowtDArsibxg/r4rCXq+3Qrw2hzoDz1+KgLE1GqXfNO1?=
 =?us-ascii?Q?DXHXfBZHvUJPVnoP+UGzD8qGjTZ5rn2mT8XtItUf39QbKnQGOroIfJLb69/D?=
 =?us-ascii?Q?idvOvjGdAAQd7ShtNGpAzUIxEcNcXoe0RLylylhsi85tDrteBwv0Nq1M1tEb?=
 =?us-ascii?Q?y7RFfWYWOeKVT6SGNMrAMVT4TZ+GZ2JlfL+hE0IDOONfqgl5PQMB2bHABkGa?=
 =?us-ascii?Q?byohBzQ011YBk3qMT2VtTgLbMJrrBNfMC0IY?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(7416014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Aug 2025 13:56:05.0335
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd1cd7cb-b106-4ccd-8acb-08ddda71257e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF0000231F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5900

Submit multiple descriptors in axienet_rx_cb() to fill Rx skb ring. This
ensures the ring "catches up" on previously missed allocations.

Increment Rx skb ring head pointer after BD is successfully allocated.
Previously, head pointer was incremented before verifying if descriptor is
successfully allocated and has valid entries, which could lead to ring
state inconsistency if descriptor setup failed.

These changes improve reliability by maintaining adequate descriptor
availability and ensuring proper ring buffer state management.

Fixes: 6a91b846af85 ("net: axienet: Introduce dmaengine support")
Signed-off-by: Suraj Gupta <suraj.gupta2@amd.com>
---
Changes in V2:
- Submit multiple descriptors in axienet_rx_cb().
- Modify commit subject and description.
---
 drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
index 6011d7eae0c7..0d8a05fe541a 100644
--- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
+++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
@@ -1160,6 +1160,7 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	struct axienet_local *lp = data;
 	struct sk_buff *skb;
 	u32 *app_metadata;
+	int i;
 
 	skbuf_dma = axienet_get_rx_desc(lp, lp->rx_ring_tail++);
 	skb = skbuf_dma->skb;
@@ -1178,7 +1179,10 @@ static void axienet_dma_rx_cb(void *data, const struct dmaengine_result *result)
 	u64_stats_add(&lp->rx_packets, 1);
 	u64_stats_add(&lp->rx_bytes, rx_len);
 	u64_stats_update_end(&lp->rx_stat_sync);
-	axienet_rx_submit_desc(lp->ndev);
+
+	for (i = 0; i < CIRC_SPACE(lp->rx_ring_head, lp->rx_ring_tail,
+				   RX_BUF_NUM_DEFAULT); i++)
+		axienet_rx_submit_desc(lp->ndev);
 	dma_async_issue_pending(lp->rx_chan);
 }
 
@@ -1457,7 +1461,6 @@ static void axienet_rx_submit_desc(struct net_device *ndev)
 	if (!skbuf_dma)
 		return;
 
-	lp->rx_ring_head++;
 	skb = netdev_alloc_skb(ndev, lp->max_frm_size);
 	if (!skb)
 		return;
@@ -1482,6 +1485,7 @@ static void axienet_rx_submit_desc(struct net_device *ndev)
 	skbuf_dma->desc = dma_rx_desc;
 	dma_rx_desc->callback_param = lp;
 	dma_rx_desc->callback_result = axienet_dma_rx_cb;
+	lp->rx_ring_head++;
 	dmaengine_submit(dma_rx_desc);
 
 	return;
-- 
2.25.1



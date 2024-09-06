Return-Path: <netdev+bounces-126117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 629AA96FE76
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FDE91C22A4A
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D15D15CD41;
	Fri,  6 Sep 2024 23:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JXk4uzWA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2040.outbound.protection.outlook.com [40.107.92.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0DE815B559
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 23:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725665205; cv=fail; b=S6QX4T6P7+RB8083znw/ZsWa8XRBFLUmUd1ItycwFS+EpO7E4l/lUm41+B2CLnNSrZ5ALzABLo+AtnPyThccg1ghBPrTDd4wDtuniUIznSHpOsgfRf7tTu3dapz8RL22dqki18NpzEUGHQ/UTTsVbWfT6Wp3n9kdgOf6aO+kfD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725665205; c=relaxed/simple;
	bh=2UaVosjwKBuHzvjsWnkMsgpBJihegPBQ8SLhoV15+es=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UW2rUgcUSqmql95nm1cj2qYUL29zb7Wt7IsBdxLBrPpceaxxYjBJal6O1NBAh7yoDzhBrsoxhsUTjB3dy4xFUdxxCIqJABc8Hb+5YO9ldxEb0t04GjriuXEsy1q3h53npKovVGN7f6tWDNRNAWZ6W7J2iboYIXI5u66n5SNcsF4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JXk4uzWA; arc=fail smtp.client-ip=40.107.92.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vLFaknY0Gw7C44gzwQxs/nJ/WZRzSPeukiCJ925o36imGLCZ1OjBTlnglyJTWkZBxybrN/bKoVAR3QsnbwJc2PRECowHkj9MM4qgXqipiob+DwgM9nq088OCeo+3A1PjcPHlxBREYxnraRcBumveqpr8i2wR9vqnWmmGWLyNtQoAE+eYZG6Ku2kF6wiMhnXGULo7Q6uT4fAVTAVbfHrfPu4Vpfee9/MDJGzjAmPY8vGh+2bH5jfcovrGgjdQlHeNSGdGXcDGsyChy+bNBMNAN+8WtqRhd2RPegFtrc90wBTitvutCnJOvtAOlDcHhO6QOJpM6Qb118qwEGkcD1LzYA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PuJUawiH3ZS/MZ9sfmV1cu8RCe5V6iRRkd8pPYSRBCU=;
 b=BQwUNN/EoDV7cqV15n8Oex18CEGG/Jw+ok4uUMHFbEVYVVyr+E3RVLyuZneCeddbtR42p+LAqNhyU2AApDwkfa1DF/Jj10Br0UqUzr9FQH04uemoNQDrmkB3lneHfVGo3QSeGzbCP4qGMStBOm9YTZ5QP6U80rHK2wiH9d3ukcyVdlnFx1rvViSETAt8piF6+ZD6+qCBGt0xxagzi1k+XnVK0Q/1avrLjt8AI13s+o6H+Ya14lGpkN2jTyrhlsYYKWsjCcha05VgbFtlqGKe43WeKEkC6B58b/6QI1S3HqDke6TXT7FLyy985Cm2tUPmPvj5L/Mg71jExyjD5aie8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PuJUawiH3ZS/MZ9sfmV1cu8RCe5V6iRRkd8pPYSRBCU=;
 b=JXk4uzWASgTdwtTwm8Df7g86kZD0eubBfCIQil1K52xBKsmf//2XnY1glMlsPJ/MpLEs0kSq8G4sT9HJ5x8esBAKEmVW0b8+ECPVxPhQBDD0SWHesyTt4eaLcKSzsV1RMazLAdUlKm/rxhsxAwmdWJldyk/MgKun1v0xu0TPEp8=
Received: from PH7PR17CA0069.namprd17.prod.outlook.com (2603:10b6:510:325::29)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 6 Sep
 2024 23:26:37 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::68) by PH7PR17CA0069.outlook.office365.com
 (2603:10b6:510:325::29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27 via Frontend
 Transport; Fri, 6 Sep 2024 23:26:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 23:26:37 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 18:26:35 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v3 net-next 3/7] ionic: use per-queue xdp_prog
Date: Fri, 6 Sep 2024 16:26:19 -0700
Message-ID: <20240906232623.39651-4-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240906232623.39651-1-brett.creeley@amd.com>
References: <20240906232623.39651-1-brett.creeley@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB03.amd.com
 (10.181.40.144)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 2995a128-2e16-418e-205d-08dccecb5a97
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700013|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?TfxReoEyhBkoxTg3awLvpA/WZWP7pNMvt7B5AQV/RMs0cxtatqAzg8qIaRfm?=
 =?us-ascii?Q?mfzHBq5FJf9/xrE6X1DxnZ6EEqbxQUswjNWV/1IJfqtjt+YL4OrgbJov6/T+?=
 =?us-ascii?Q?6DiEoOKyCa9wMB/mGaqqPsYTv4dpuxdZmmoSpW4qMjsDLMmTAFHQHsAfy3Cn?=
 =?us-ascii?Q?iAtgwrd7YL+6hJS7WlGAD7aBiyKN2wkpcDMU1tUnC/bdMJMi+4ftfobw+QL3?=
 =?us-ascii?Q?xLDXOTaTYV3EMP1JuPc9KkKbSkuCOI38EbVVzKVkr6X664UaTefnnbw68Ugl?=
 =?us-ascii?Q?AO3yrjIe1oYdwj8ck5oOrsPXMN8GLUpnbaoIXVF6eJN2HkbqXNBLZHXhsd6+?=
 =?us-ascii?Q?WskDaCy9MlfmEk+CEKOs+EvmBb/hdhbqVHLoLwuLp4fEOcCxAhNr7tBE7qsv?=
 =?us-ascii?Q?F5bfpYBpEszjFqtQ1va2bjUXhjhJglDHSHndBUu1KCiigf5JTPLnSB02f1LY?=
 =?us-ascii?Q?bny4RZ3T6najaEcVVg4EoMNxEBCO36mH6MvDFLvQd6HXG0pibg/mMoDy6A8B?=
 =?us-ascii?Q?bYY40lS3tfgAGVKxO8hC5clXTrT/3+pXi7I8qsZj2hXxABlkG03pR2ayj2oe?=
 =?us-ascii?Q?6RKPWrhF2xmBl5ZF60PbJ1z2c6C/kBGfjndHmqiOresO7AVDe2IzmsC9ACCB?=
 =?us-ascii?Q?7LkXTPLFsLbvpRazCjx3j5WiP7xiPyl7WhRDoBHchVfhcoQnRjuz7VIJyPZZ?=
 =?us-ascii?Q?9o8niId1eGnyZJOqLrO6l5KoqUW1KEMi7hc2sgOtX8XfspXRT4k7OrBM+DVF?=
 =?us-ascii?Q?ohx1AChPDXXdwrG1vPh50TwDt/eso8ZF01Mqk+udO5xyB0xx9hl0xvJEfI7r?=
 =?us-ascii?Q?jgpxOAxCpz8V5aOnIPSaGBLWe+2QURgPuxoT4Hoyu1kDnJhA85F0lVFOrUui?=
 =?us-ascii?Q?zmdHxFi6V0j6nYkulti1yyUuCaNLFl5ndWB3oS+FT2FIwiyfTgdlVDreU7B2?=
 =?us-ascii?Q?Z1GuRsbxizy+eDyWjx84k04nIhoZZfr7LtblIt+JEGvht/eH3Uzfu5v3/ZSd?=
 =?us-ascii?Q?PCMFB7+BIwcMWdBoIcypdMK0mQMYo8ttaMsCrUp2zbOcXMJaxBIa57dlF60Q?=
 =?us-ascii?Q?rrIb2evVuN57eOb/Ho9Z/7lLZZY/CRZTLbPPmfHFAAuID3ZKTaoHgxBgy9De?=
 =?us-ascii?Q?dStSSQnLzs8vuQgFf2/FnWoLJ1KtKOtxoJrFttgkqHboPwj9ugOWwJzqEBjw?=
 =?us-ascii?Q?ebMwc/pFO6kawpgVkIIm0MNd1d4o/G196or8CXaOJ0h1LZHBqu20wCDGrsfv?=
 =?us-ascii?Q?Pgz+wudUHHNz3tfcVsk6IJPaAD4pkN6xAFnCNX/gNc1jYGcPID8ftl1Uw66G?=
 =?us-ascii?Q?g0qccOgwA2THlefiTiQc9UQ5LdE68JLS6iKYZA2YkOHzdsP/wP4TtdgUuNis?=
 =?us-ascii?Q?Nqp6KPC0aVKw2CYIgxxAPSP5IetDOhfpYaGZZoY92KRrJz/1hrWAohPPE+0x?=
 =?us-ascii?Q?atwjUp+dKrxoLmZ2/nRlQgt9Z8+QyUlZ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 23:26:37.2366
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2995a128-2e16-418e-205d-08dccecb5a97
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614

From: Shannon Nelson <shannon.nelson@amd.com>

We originally were using a per-interface xdp_prog variable to track
a loaded XDP program since we knew there would never be support for a
per-queue XDP program.  With that, we only built the per queue rxq_info
struct when an XDP program was loaded and removed it on XDP program unload,
and used the pointer as an indicator in the Rx hotpath to know to how build
the buffers.  However, that's really not the model generally used, and
makes a conversion to page_pool Rx buffer cacheing a little problematic.

This patch converts the driver to use the more common approach of using
a per-queue xdp_prog pointer to work out buffer allocations and need
for bpf_prog_run_xdp().  We jostle a couple of fields in the queue struct
in order to keep the new xdp_prog pointer in a warm cacheline.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  7 +++-
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 37 ++++++++++---------
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 21 +++++------
 3 files changed, 34 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index c647033f3ad2..19ae68a86a0b 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -238,9 +238,8 @@ struct ionic_queue {
 	unsigned int index;
 	unsigned int num_descs;
 	unsigned int max_sg_elems;
+
 	u64 features;
-	unsigned int type;
-	unsigned int hw_index;
 	unsigned int hw_type;
 	bool xdp_flush;
 	union {
@@ -261,7 +260,11 @@ struct ionic_queue {
 		struct ionic_rxq_sg_desc *rxq_sgl;
 	};
 	struct xdp_rxq_info *xdp_rxq_info;
+	struct bpf_prog *xdp_prog;
 	struct ionic_queue *partner;
+
+	unsigned int type;
+	unsigned int hw_index;
 	dma_addr_t base_pa;
 	dma_addr_t cmb_base_pa;
 	dma_addr_t sg_base_pa;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index aa0cc31dfe6e..79eda0ca82a1 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -46,7 +46,7 @@ static int ionic_start_queues(struct ionic_lif *lif);
 static void ionic_stop_queues(struct ionic_lif *lif);
 static void ionic_lif_queue_identify(struct ionic_lif *lif);
 
-static int ionic_xdp_queues_config(struct ionic_lif *lif);
+static int ionic_xdp_rxqs_update(struct ionic_lif *lif);
 static void ionic_xdp_unregister_rxq_info(struct ionic_queue *q);
 
 static void ionic_dim_work(struct work_struct *work)
@@ -2143,7 +2143,7 @@ static int ionic_txrx_enable(struct ionic_lif *lif)
 	int derr = 0;
 	int i, err;
 
-	err = ionic_xdp_queues_config(lif);
+	err = ionic_xdp_rxqs_update(lif);
 	if (err)
 		return err;
 
@@ -2192,7 +2192,7 @@ static int ionic_txrx_enable(struct ionic_lif *lif)
 		derr = ionic_qcq_disable(lif, lif->rxqcqs[i], derr);
 	}
 
-	ionic_xdp_queues_config(lif);
+	ionic_xdp_rxqs_update(lif);
 
 	return err;
 }
@@ -2698,35 +2698,35 @@ static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_
 	return err;
 }
 
-static int ionic_xdp_queues_config(struct ionic_lif *lif)
+static int ionic_xdp_rxqs_update(struct ionic_lif *lif)
 {
+	struct bpf_prog *xdp_prog;
 	unsigned int i;
 	int err;
 
 	if (!lif->rxqcqs)
 		return 0;
 
-	/* There's no need to rework memory if not going to/from NULL program.
-	 * If there is no lif->xdp_prog, there should also be no q.xdp_rxq_info
-	 * This way we don't need to keep an *xdp_prog in every queue struct.
-	 */
-	if (!lif->xdp_prog == !lif->rxqcqs[0]->q.xdp_rxq_info)
-		return 0;
-
+	xdp_prog = READ_ONCE(lif->xdp_prog);
 	for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++) {
 		struct ionic_queue *q = &lif->rxqcqs[i]->q;
 
-		if (q->xdp_rxq_info) {
+		if (q->xdp_prog) {
 			ionic_xdp_unregister_rxq_info(q);
-			continue;
+			q->xdp_prog = NULL;
 		}
 
-		err = ionic_xdp_register_rxq_info(q, lif->rxqcqs[i]->napi.napi_id);
-		if (err) {
-			dev_err(lif->ionic->dev, "failed to register RX queue %d info for XDP, err %d\n",
-				i, err);
-			goto err_out;
+		if (xdp_prog) {
+			unsigned int napi_id = lif->rxqcqs[i]->napi.napi_id;
+
+			err = ionic_xdp_register_rxq_info(q, napi_id);
+			if (err) {
+				dev_err(lif->ionic->dev, "failed to register RX queue %d info for XDP, err %d\n",
+					i, err);
+				goto err_out;
+			}
 		}
+		q->xdp_prog = xdp_prog;
 	}
 
 	return 0;
@@ -2878,6 +2878,7 @@ static void ionic_swap_queues(struct ionic_qcq *a, struct ionic_qcq *b)
 	swap(a->q.base,       b->q.base);
 	swap(a->q.base_pa,    b->q.base_pa);
 	swap(a->q.info,       b->q.info);
+	swap(a->q.xdp_prog,   b->q.xdp_prog);
 	swap(a->q.xdp_rxq_info, b->q.xdp_rxq_info);
 	swap(a->q.partner,    b->q.partner);
 	swap(a->q_base,       b->q_base);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index d62b2b60b133..858ab4fd9218 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -190,7 +190,7 @@ static bool ionic_rx_buf_recycle(struct ionic_queue *q,
 	if (page_to_nid(buf_info->page) != numa_mem_id())
 		return false;
 
-	size = ALIGN(len, q->xdp_rxq_info ? IONIC_PAGE_SIZE : IONIC_PAGE_SPLIT_SZ);
+	size = ALIGN(len, q->xdp_prog ? IONIC_PAGE_SIZE : IONIC_PAGE_SPLIT_SZ);
 	buf_info->page_offset += size;
 	if (buf_info->page_offset >= IONIC_PAGE_SIZE)
 		return false;
@@ -639,8 +639,7 @@ static void ionic_rx_clean(struct ionic_queue *q,
 	struct net_device *netdev = q->lif->netdev;
 	struct ionic_qcq *qcq = q_to_qcq(q);
 	struct ionic_rx_stats *stats;
-	struct bpf_prog *xdp_prog;
-	unsigned int headroom;
+	unsigned int headroom = 0;
 	struct sk_buff *skb;
 	bool synced = false;
 	bool use_copybreak;
@@ -664,14 +663,13 @@ static void ionic_rx_clean(struct ionic_queue *q,
 	stats->pkts++;
 	stats->bytes += len;
 
-	xdp_prog = READ_ONCE(q->lif->xdp_prog);
-	if (xdp_prog) {
-		if (ionic_run_xdp(stats, netdev, xdp_prog, q, desc_info->bufs, len))
+	if (q->xdp_prog) {
+		if (ionic_run_xdp(stats, netdev, q->xdp_prog, q, desc_info->bufs, len))
 			return;
 		synced = true;
+		headroom = XDP_PACKET_HEADROOM;
 	}
 
-	headroom = q->xdp_rxq_info ? XDP_PACKET_HEADROOM : 0;
 	use_copybreak = len <= q->lif->rx_copybreak;
 	if (use_copybreak)
 		skb = ionic_rx_copybreak(netdev, q, desc_info,
@@ -814,7 +812,7 @@ void ionic_rx_fill(struct ionic_queue *q)
 	len = netdev->mtu + VLAN_ETH_HLEN;
 
 	for (i = n_fill; i; i--) {
-		unsigned int headroom;
+		unsigned int headroom = 0;
 		unsigned int buf_len;
 
 		nfrags = 0;
@@ -835,11 +833,12 @@ void ionic_rx_fill(struct ionic_queue *q)
 		 * XDP uses space in the first buffer, so account for
 		 * head room, tail room, and ip header in the first frag size.
 		 */
-		headroom = q->xdp_rxq_info ? XDP_PACKET_HEADROOM : 0;
-		if (q->xdp_rxq_info)
+		if (q->xdp_prog) {
 			buf_len = IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN;
-		else
+			headroom = XDP_PACKET_HEADROOM;
+		} else {
 			buf_len = ionic_rx_buf_size(buf_info);
+		}
 		frag_len = min_t(u16, len, buf_len);
 
 		desc->addr = cpu_to_le64(ionic_rx_buf_pa(buf_info) + headroom);
-- 
2.17.1



Return-Path: <netdev+bounces-106218-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D4749155D6
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 19:51:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7EEE21C22D0D
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 17:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBCEB19F477;
	Mon, 24 Jun 2024 17:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NKcv+kvq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2058.outbound.protection.outlook.com [40.107.236.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F06011A00CE
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 17:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.58
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719251449; cv=fail; b=LrUOnqs62iCo+iAS2nKMZZkeUVqdHPZVxgVEws2nIUjw6nVh+pUHnLSf4iIQnZzXuiZx1AqB5jE6qhPQdyn9lnxqoC+2lX8p9575ckhu57j1BYwNAoFlQ/Fe6O+YwPjRWjM499sUtUlwUKbvr1oPjFrzTFKD/uqN9GoUIHgBJ7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719251449; c=relaxed/simple;
	bh=P405HqJidw3WGpYPGfV6RvKWcfVyuUeFyg/zc163SLU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dC/KPixyfQHFidGkNJFKCfqPKnBsfDuUrAwDWZkMJO5pMCnEFM2v1DfeCqrWl0HGlg6WYKRcMXBpx/GKha9J027iJ7mURxZuHRNT5WzpzPAeQGQuqYu1R1Bpq9vM7Z7rFQmUpH4+lu8WCUpogMjMsu9+r2g/dEt0LG/1KLpCy4k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NKcv+kvq; arc=fail smtp.client-ip=40.107.236.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Pum/n82wfVhlZRrUmTeJDs3mMoI5NK8whBhMGWSohHFFAXYC+qtYgTT8yatee0IXp5wovediVmGzh1Z2+E8tNcDNt//hRIlQOKM6WxAZ//RzykDG0oJ/+in+yvKxTsFcO0JZ16yvtd2QXONa3O0PaQ9fqO/R8X1WDxXt36OGXQxVpIJWELKJ0TUORDPLmgIpXMtGhQDTAKJkWkXpkps0+wy4B7P7cilyo4JBWqdDqzC7FZlpuq/bdCLzYaDlLrc5JgvE+GOkozACKNPlNG94OMgF+UyaCz9oI1OEYvUmtgaRwYV87gvPOGdiVQOlcKuyU1hD+4mVIXvoz1oc1GN/KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hluAowpkiA1ykIkGT8bSsUY5pc9Y5mNHD6HSIFj6lAs=;
 b=MjefWpW7wu8xck6H2kGnB1gslNU/FjSHQeQuQmnR+pB8X3/piw507mTCBk9tujdqaSVowadiX73qSHLsdUZPuJt7NJFB3WIbLfZD2kolDjXgU5K/LxmuE+jUIoxVmmSyTU0+PKfR8Fc/aUp+7W9vrLJCQjXYy/Iyorf6YNmoUrTPvRhkV6lNoSyzt7eoy0Ys8BR9w/Yk0MgQb0aqpr4ZfgTW4jkj1uEf71qq9LbIsGhcpPrreOzwusM1D4fGfrCKwU9HOFMk8+DlmiEj9G8LbBFTZrEhVbnG71Y31XBbEqY/tkrEupO+yA8IRwXUMhw+3YQ2xCQpYLS0dGSM8afV5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hluAowpkiA1ykIkGT8bSsUY5pc9Y5mNHD6HSIFj6lAs=;
 b=NKcv+kvqGMZra1Ph6nneU4rYKvXiVnzDUEUGuplNb37Dmb6L+sUG7ciAFKdBH3OcrQVf0KnkZfNmHPs5eY4nzgPXxkA3Qil0zgRTblkcTsqhiMVzUOUX9argF9KeE35Zk+c5xAK8RyR8+lk7bZfm5Gd5yQewB1rhLTxk1oQMmMs=
Received: from BN1PR12CA0020.namprd12.prod.outlook.com (2603:10b6:408:e1::25)
 by DS7PR12MB8290.namprd12.prod.outlook.com (2603:10b6:8:d8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.28; Mon, 24 Jun
 2024 17:50:44 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::91) by BN1PR12CA0020.outlook.office365.com
 (2603:10b6:408:e1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Mon, 24 Jun 2024 17:50:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 17:50:43 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Jun
 2024 12:50:42 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH v3 net] ionic: use dev_consume_skb_any outside of napi
Date: Mon, 24 Jun 2024 10:50:15 -0700
Message-ID: <20240624175015.4520-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|DS7PR12MB8290:EE_
X-MS-Office365-Filtering-Correlation-Id: 6a1ca902-4b41-4860-2124-08dc94762ba4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|36860700010|82310400023|376011|1800799021;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rHnoh2Tt9MJslNuAtGu480hu/CPDNMYLShY9QiQmUOKqcXLzxnW/zZYFGc3D?=
 =?us-ascii?Q?03CuqLTFRPKMWwqFfUi/UWS5iCL6ML3ILPvtxnOBtdc3+vGgC1LZqZoghFeN?=
 =?us-ascii?Q?TsyleNxgaRcAWd6ftX689lmLL3Q5PYCYngy+mNublNi37jyGKihonUz9mfQa?=
 =?us-ascii?Q?cLH3FsKmlfOHh4OLRQT70LQhHtXkTLcO0k+Ybp9kx3DpMkaoHAf1DTns47U0?=
 =?us-ascii?Q?9Gmr8c90/TrIHwYXDuxKYFupy4YmK7hMJutszVX2DBfU/b5zdk07wh7YOSCl?=
 =?us-ascii?Q?x6KSUoCtw51liKvxVrLW+AXsgVT5Vqh9KRBHxkSgB6eODns9IJ/YI30m6Vb6?=
 =?us-ascii?Q?GczDKjeuDGw/gsRtg1kwdxyGZRC8bTHiycZhZyo/V+/8QvB9m9Wn4/f+b+ti?=
 =?us-ascii?Q?F/pz6L4sIzxz/ZNli3v527S5fiRpPTfBtBw5OZn7iLXfqHFsAjbdA3SQYE6u?=
 =?us-ascii?Q?3U4LQRFtELWKIxp4fFrqzPQsRCcvxGVCF7LQjGov8mrJasrSue3x2POtj+W7?=
 =?us-ascii?Q?Cv3u50MdTmkPOlwQxBrs16XCauHMJKz+A05WxtN8Jh/tNe/izs/6vG2gbUWf?=
 =?us-ascii?Q?qcz+qa8ATXtSKhM3oMZzouSMOlS1RAS8lpYBJ9W/z1Y5DJDooUaCUXC+Lli1?=
 =?us-ascii?Q?S1OhfcJLZZOfr8aQL/s/DBTc1f0bRGrC5OH/Z5dpM5TPjq25zLQvXdrKPRxv?=
 =?us-ascii?Q?vuvj7HheN9jEkoJm9RbmR4E2YB5kglpJ8k+9ggYYAC2ythYHkmlxyX9zyMRA?=
 =?us-ascii?Q?6RQ/Y4UQyx96lJ5rRJ1qooTy5cfDmEFvAyKnuTQfhCo38gCsPSXFSpAb+rCL?=
 =?us-ascii?Q?2dUYKiOwdL9pIt6RyksSObw+Sb1hpPAxrUwOwhw3600BM2+rTFtUoVI1LsEr?=
 =?us-ascii?Q?6OQlZBZ5VW6WnVfJbdtZUUxQmdsYUk4h1aSLxQJwH1nCNgUfo1AMgs2eHB82?=
 =?us-ascii?Q?NurTA6gRdwWaLgSapsGIIbuBwgWDPA57WJRNIuG9yWAyMRdq9Y1l55k9NNvn?=
 =?us-ascii?Q?WRX7CMf77K2xxUXrFbMUkrxjFLQK5JQrSiO6hGVIIxXot8AxIEF9wQbD+bR/?=
 =?us-ascii?Q?Nq2pDDSsodVY2X+LSSmzV2Th23Ha/EGsNPdTos5cGmMZS2y4hecWZD++0Ai8?=
 =?us-ascii?Q?cnBhTVjYZvBZEtekwUV1RbIHDVDlc4/K5rhmNa8qjc5qFFQXQaOajZahFwfO?=
 =?us-ascii?Q?+XtF31dC74TCmJCi/dQThfXHMyATxPU1+KXylwbkjVMzZVY2fWktAxrvSPIz?=
 =?us-ascii?Q?Q8CrTY6vW5ape8Y0ObvrsiQ9M3VQeNiPxrV8vW2VxaiOJhpYeuV2t/o7+0M6?=
 =?us-ascii?Q?JaSGflVp7OQyVeJxObyNzd+hsBnCfFzc7O0H4tKRrIIEMVrhB0oWmuDF/6Ye?=
 =?us-ascii?Q?ew/ayyM=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(36860700010)(82310400023)(376011)(1800799021);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 17:50:43.8371
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a1ca902-4b41-4860-2124-08dc94762ba4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB8290

If we're not in a NAPI softirq context, we need to be careful
about how we call napi_consume_skb(), specifically we need to
call it with budget==0 to signal to it that we're not in a
safe context.

This was found while running some configuration stress testing
of traffic and a change queue config loop running, and this
curious note popped out:

[ 4371.402645] BUG: using smp_processor_id() in preemptible [00000000] code: ethtool/20545
[ 4371.402897] caller is napi_skb_cache_put+0x16/0x80
[ 4371.403120] CPU: 25 PID: 20545 Comm: ethtool Kdump: loaded Tainted: G           OE      6.10.0-rc3-netnext+ #8
[ 4371.403302] Hardware name: HPE ProLiant DL360 Gen10/ProLiant DL360 Gen10, BIOS U32 01/23/2021
[ 4371.403460] Call Trace:
[ 4371.403613]  <TASK>
[ 4371.403758]  dump_stack_lvl+0x4f/0x70
[ 4371.403904]  check_preemption_disabled+0xc1/0xe0
[ 4371.404051]  napi_skb_cache_put+0x16/0x80
[ 4371.404199]  ionic_tx_clean+0x18a/0x240 [ionic]
[ 4371.404354]  ionic_tx_cq_service+0xc4/0x200 [ionic]
[ 4371.404505]  ionic_tx_flush+0x15/0x70 [ionic]
[ 4371.404653]  ? ionic_lif_qcq_deinit.isra.23+0x5b/0x70 [ionic]
[ 4371.404805]  ionic_txrx_deinit+0x71/0x190 [ionic]
[ 4371.404956]  ionic_reconfigure_queues+0x5f5/0xff0 [ionic]
[ 4371.405111]  ionic_set_ringparam+0x2e8/0x3e0 [ionic]
[ 4371.405265]  ethnl_set_rings+0x1f1/0x300
[ 4371.405418]  ethnl_default_set_doit+0xbb/0x160
[ 4371.405571]  genl_family_rcv_msg_doit+0xff/0x130
	[...]

I found that ionic_tx_clean() calls napi_consume_skb() which calls
napi_skb_cache_put(), but before that last call is the note
    /* Zero budget indicate non-NAPI context called us, like netpoll */
and
    DEBUG_NET_WARN_ON_ONCE(!in_softirq());

Those are pretty big hints that we're doing it wrong.  We can pass a
context hint down through the calls to let ionic_tx_clean() know what
we're doing so it can call napi_consume_skb() correctly.

Fixes: 386e69865311 ("ionic: Make use napi_consume_skb")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  4 ++-
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  2 +-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 28 +++++++++++--------
 3 files changed, 21 insertions(+), 13 deletions(-)

v3: use budget for the hint where we can (Jakub)

v2: replace softirq_count() with a napi context hint (Jakub)
    https://lore.kernel.org/netdev/20240620192519.35395-1-shannon.nelson@amd.com/

v1: https://lore.kernel.org/netdev/20240619212022.30700-1-shannon.nelson@amd.com/

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index f30eee4a5a80..b6c01a88098d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -375,7 +375,9 @@ typedef void (*ionic_cq_done_cb)(void *done_arg);
 unsigned int ionic_cq_service(struct ionic_cq *cq, unsigned int work_to_do,
 			      ionic_cq_cb cb, ionic_cq_done_cb done_cb,
 			      void *done_arg);
-unsigned int ionic_tx_cq_service(struct ionic_cq *cq, unsigned int work_to_do);
+unsigned int ionic_tx_cq_service(struct ionic_cq *cq,
+				 unsigned int work_to_do,
+				 bool in_napi);
 
 int ionic_q_init(struct ionic_lif *lif, struct ionic_dev *idev,
 		 struct ionic_queue *q, unsigned int index, const char *name,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 1934e9d6d9e4..1837a30ba08a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -1189,7 +1189,7 @@ static int ionic_adminq_napi(struct napi_struct *napi, int budget)
 					   ionic_rx_service, NULL, NULL);
 
 	if (lif->hwstamp_txq)
-		tx_work = ionic_tx_cq_service(&lif->hwstamp_txq->cq, budget);
+		tx_work = ionic_tx_cq_service(&lif->hwstamp_txq->cq, budget, !!budget);
 
 	work_done = max(max(n_work, a_work), max(rx_work, tx_work));
 	if (work_done < budget && napi_complete_done(napi, work_done)) {
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 2427610f4306..995d7f7d96d0 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -23,7 +23,8 @@ static void ionic_tx_desc_unmap_bufs(struct ionic_queue *q,
 
 static void ionic_tx_clean(struct ionic_queue *q,
 			   struct ionic_tx_desc_info *desc_info,
-			   struct ionic_txq_comp *comp);
+			   struct ionic_txq_comp *comp,
+			   bool in_napi);
 
 static inline void ionic_txq_post(struct ionic_queue *q, bool ring_dbell)
 {
@@ -935,7 +936,7 @@ int ionic_tx_napi(struct napi_struct *napi, int budget)
 	u32 work_done = 0;
 	u32 flags = 0;
 
-	work_done = ionic_tx_cq_service(cq, budget);
+	work_done = ionic_tx_cq_service(cq, budget, !!budget);
 
 	if (unlikely(!budget))
 		return budget;
@@ -1019,7 +1020,7 @@ int ionic_txrx_napi(struct napi_struct *napi, int budget)
 	txqcq = lif->txqcqs[qi];
 	txcq = &lif->txqcqs[qi]->cq;
 
-	tx_work_done = ionic_tx_cq_service(txcq, IONIC_TX_BUDGET_DEFAULT);
+	tx_work_done = ionic_tx_cq_service(txcq, IONIC_TX_BUDGET_DEFAULT, !!budget);
 
 	if (unlikely(!budget))
 		return budget;
@@ -1152,7 +1153,8 @@ static void ionic_tx_desc_unmap_bufs(struct ionic_queue *q,
 
 static void ionic_tx_clean(struct ionic_queue *q,
 			   struct ionic_tx_desc_info *desc_info,
-			   struct ionic_txq_comp *comp)
+			   struct ionic_txq_comp *comp,
+			   bool in_napi)
 {
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
 	struct ionic_qcq *qcq = q_to_qcq(q);
@@ -1204,11 +1206,13 @@ static void ionic_tx_clean(struct ionic_queue *q,
 	desc_info->bytes = skb->len;
 	stats->clean++;
 
-	napi_consume_skb(skb, 1);
+	napi_consume_skb(skb, likely(in_napi) ? 1 : 0);
 }
 
 static bool ionic_tx_service(struct ionic_cq *cq,
-			     unsigned int *total_pkts, unsigned int *total_bytes)
+			     unsigned int *total_pkts,
+			     unsigned int *total_bytes,
+			     bool in_napi)
 {
 	struct ionic_tx_desc_info *desc_info;
 	struct ionic_queue *q = cq->bound_q;
@@ -1230,7 +1234,7 @@ static bool ionic_tx_service(struct ionic_cq *cq,
 		desc_info->bytes = 0;
 		index = q->tail_idx;
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
-		ionic_tx_clean(q, desc_info, comp);
+		ionic_tx_clean(q, desc_info, comp, in_napi);
 		if (desc_info->skb) {
 			pkts++;
 			bytes += desc_info->bytes;
@@ -1244,7 +1248,9 @@ static bool ionic_tx_service(struct ionic_cq *cq,
 	return true;
 }
 
-unsigned int ionic_tx_cq_service(struct ionic_cq *cq, unsigned int work_to_do)
+unsigned int ionic_tx_cq_service(struct ionic_cq *cq,
+				 unsigned int work_to_do,
+				 bool in_napi)
 {
 	unsigned int work_done = 0;
 	unsigned int bytes = 0;
@@ -1253,7 +1259,7 @@ unsigned int ionic_tx_cq_service(struct ionic_cq *cq, unsigned int work_to_do)
 	if (work_to_do == 0)
 		return 0;
 
-	while (ionic_tx_service(cq, &pkts, &bytes)) {
+	while (ionic_tx_service(cq, &pkts, &bytes, in_napi)) {
 		if (cq->tail_idx == cq->num_descs - 1)
 			cq->done_color = !cq->done_color;
 		cq->tail_idx = (cq->tail_idx + 1) & (cq->num_descs - 1);
@@ -1279,7 +1285,7 @@ void ionic_tx_flush(struct ionic_cq *cq)
 {
 	u32 work_done;
 
-	work_done = ionic_tx_cq_service(cq, cq->num_descs);
+	work_done = ionic_tx_cq_service(cq, cq->num_descs, false);
 	if (work_done)
 		ionic_intr_credits(cq->idev->intr_ctrl, cq->bound_intr->index,
 				   work_done, IONIC_INTR_CRED_RESET_COALESCE);
@@ -1296,7 +1302,7 @@ void ionic_tx_empty(struct ionic_queue *q)
 		desc_info = &q->tx_info[q->tail_idx];
 		desc_info->bytes = 0;
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
-		ionic_tx_clean(q, desc_info, NULL);
+		ionic_tx_clean(q, desc_info, NULL, false);
 		if (desc_info->skb) {
 			pkts++;
 			bytes += desc_info->bytes;
-- 
2.17.1



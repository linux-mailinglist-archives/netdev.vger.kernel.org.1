Return-Path: <netdev+bounces-122017-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA6E95F921
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:45:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 421491C21C03
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 554C1199243;
	Mon, 26 Aug 2024 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ALP1/6D6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2046.outbound.protection.outlook.com [40.107.236.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1C31991A5
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 18:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697894; cv=fail; b=fiQBwdeCk4B/Ca7ZwsbPXmVEzZs9kfQRrp4Vn1o+z5tqDii9Xr2+1ei2Sfh69NaRIFlo2dvrxi3CFdrKFo+cIEZ8Ge1RpofpSWHfUVEbD59vIZYoIk6KXiPo12Dk/YG/FCioMCpsoMzg0wl8copctWDhIwC57JZNeLIF789KtYQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697894; c=relaxed/simple;
	bh=E7nGSTIYofQ4uaqoNSOaojJkHZk55mPgu83tTpIOVKM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dr6sZymX6V5/loKw3kFyy1S28M8T/2kruCyRsU9SFODEDXrHBTTx0taN2QyLvy4JSysqLhbO1s6JkS8gohVwhxvpClcfXFf5At8gN7Ivd7j/ZPqwyYZ63lyA12STnwgj5jfHgEnLAkUJbMUh2Gh4GFmFXs5bvyLOCDfqm7TIt5M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ALP1/6D6; arc=fail smtp.client-ip=40.107.236.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MokkCFytNl8UjniDmlWIcjE9c0iWPbq7+VkwJtSvj2V5H6QIXcZZQPYfYUIcSMTHOjpOQ7jAdHQUipNUw6KkE+obDm0kD4JtFk7NZRCEOahjrBi/lWPBX1ri6AyNbI6Rk8YiU4BgLyQ2gnp3eSzVVp61j05zyPMhcSizt+c+DMi+XOEzGsgvhPjdbtjwxjUOedJhURtOY9DsVVD7axzjRqPSAzDhveMeP70yJnS5FJMEYfxUqwQKw33oqy+3lvQsHyM8cOHrHNva+8Wz9OrnaScDZQTGwLrh8DskyOu+k8yw6BaYmFwj5/tllZ5SxjVyGV7ZXw3nGya8ha2vRuh3Lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8yYNLV5AGIkzhlVfqN1f8uRXJHSHNWy6R3zRh3OgFc=;
 b=vO1HvPW9wi8IDKwLeHAVbTIzPIzAJPrUcb+VL6Fl8PqXih4ZdHQpRiGN3KoF8uJeJi3xPzYqBqhBLE7GWjqz/nGz7J36UwWzBFvtUuxP96DFDn7wdLE93M31UXcgx0+uPymQP3cHg8qOlp5VNeiQb31a+GotRlDaMVxrNagH79TXyYNose1ILXkS6va+HVdiTKWci9kFFwGYPrMjrxOhgpKM8Fj2nBdWU8Mkkdqr0mu9jY0l9noGCl79y+dq65h1ly7o4Q7O3f6OjdeMycfrQfyueJ/zSdCYc4jeJHP9PKXcxweKTcqBU7eHKrcjFeOscqUDvsYw4/+OnVCptnUWyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d8yYNLV5AGIkzhlVfqN1f8uRXJHSHNWy6R3zRh3OgFc=;
 b=ALP1/6D6E86EpvvK0EeTh4AHZI6nEQUWJyfThAmPH2X6GWqpDU6Li2zEEktYw8JCkpnqA59e61NQjjRm5Qmlx+gRrViCxslsRxl4rlgfemirLYQw7aRGZaA9AnsFPi5FwoTslqZ6OklnMh6pyPk3Z5BU1Lr0cC2ohMuq/ojSb0w=
Received: from CH0PR04CA0067.namprd04.prod.outlook.com (2603:10b6:610:74::12)
 by SJ0PR12MB6736.namprd12.prod.outlook.com (2603:10b6:a03:47a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 18:44:44 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::e0) by CH0PR04CA0067.outlook.office365.com
 (2603:10b6:610:74::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Mon, 26 Aug 2024 18:44:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 18:44:43 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 Aug
 2024 13:44:40 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 3/5] ionic: use per-queue xdp_prog
Date: Mon, 26 Aug 2024 11:44:20 -0700
Message-ID: <20240826184422.21895-4-brett.creeley@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240826184422.21895-1-brett.creeley@amd.com>
References: <20240826184422.21895-1-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|SJ0PR12MB6736:EE_
X-MS-Office365-Filtering-Correlation-Id: 818f752e-80f0-49a5-0f40-08dcc5ff26c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IvrV1Iro3EH3AKLu+akILbHP4VK/yWgOwFIlNZhrGN5D+dYd2D0Kx37qGS78?=
 =?us-ascii?Q?68KJDKbiHZAPt/G7dLM6/wUq743vmt4UqrLjFtk4SMic46+Ry69FpMiqiZ6f?=
 =?us-ascii?Q?03t2rr5oETXEDlQaIiKZNFWfdAwyw1kLbFvGREu7qXHTzzb+YxYHR91bPLR0?=
 =?us-ascii?Q?mFEEBPsQ9XJK+6HeSg6PifKog+zPpLKP3no8qk+UbL2mlIKFbb0evKJ/TQjy?=
 =?us-ascii?Q?kKikSa5vGiwxB7QWMg5yQmHXJLsVEN2o728CJJjw/Uo1j9o9bFJJzYUGs8Gd?=
 =?us-ascii?Q?M8Z8IoqrkqQZxEi5VarSI82KrVSugCVKlZ8meQvn08s+1DqRZdFLXl9zYMVc?=
 =?us-ascii?Q?3/ekjQ5nE6ZyLhB/oZN6UDezcNHRf/fBoaB4qwdhcFAGMEshk7TQL+puoeND?=
 =?us-ascii?Q?zCRhohjZUoqK/33B2pZysYgU+JvkQNtObZpu2xYk1J9Ir2MLqV7/ZipB1prL?=
 =?us-ascii?Q?Kt0j8qykq/LyafAvu2yUm7QMH7rtpOsRFZhQFDNAa7jPtlGLs3hWnHxPK+Y1?=
 =?us-ascii?Q?VqaLfeS9PyZaLYyzB0P7VhJAUdJ462nTZEz83oRYs0hsHsWRbOfIgArwYnVX?=
 =?us-ascii?Q?56bI/t1yUEUNchMU9rbOMDCnUZ6mocJXu8Us5oq+Ebnj+avyQlvOzW681wDJ?=
 =?us-ascii?Q?S96b+tRBf7m9DAuYskB9KDj/FEt9rE5wTFKDena9CzXIdST3skwUkk8iwBFx?=
 =?us-ascii?Q?F9WOtvNwECrAjQUnPDsblWwHeEc7Ujn4xqQ/HxNPfBsAEYxdd178duw78fMV?=
 =?us-ascii?Q?v0xUbLni/tJZVSHNSX9yNUY0VjGoB9XA+avoU9+c9WtOB6WY+ckSxjfPQkez?=
 =?us-ascii?Q?VkE+qc69loEpP2U/hrjDb5Yb5ydDIB6h4PeQmGd8tll7JjewbdsD+vhH4Z3c?=
 =?us-ascii?Q?JdEDdGUlDuYIDgVuKgSfnsfjo3AZbnWd1EPm1tN5RjlVMrhD1GpyIbe4cSDf?=
 =?us-ascii?Q?K1Ib1qpNCWem8nmLHxOATMOjnum221Q2w2SvF0gZn9RIJnCeAhsEUcbZxplZ?=
 =?us-ascii?Q?9T+ReH0Sh6+mDvejzEvhvWm3MtP1wLc7yTZCuqpYvogQ5TPAp+mEeBxYAEOb?=
 =?us-ascii?Q?ldxTlz/VMFR347VVk676d9Tn9V4Kz69OJCyRhBVOlqnl8eiixh0Pq8ELuNyY?=
 =?us-ascii?Q?z65+8chIjtQRALlZoFmQBV4ovWcuehsjnaa3RCyvI4wzPNMKTh50fL9s9Sas?=
 =?us-ascii?Q?Tv7ujwbCZtpEV8wcWicy7kILiu1ZrMyhzObRsIFeulIIpQeNM42U1Gtdso7R?=
 =?us-ascii?Q?X5QoWxxmj3Z+qCOqhz80+1OcZiv8AxOQCKcYaw0OqMeh88iYZG56D+87+aXw?=
 =?us-ascii?Q?4RYtDFKELLvlfRefbDMCBmPb3VY/PIvxhCwbjaqddsqA1uP5Wk2QQ5UC8oIC?=
 =?us-ascii?Q?jYTqVftOF93iC/2JTH8TpSpjHG/8YJlqoHhXW/0/byA6q9bFLxR3856bmZ9e?=
 =?us-ascii?Q?oQlTOz4v7CwQFeWmLeZm+1ewxxKYd93/?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 18:44:43.6545
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 818f752e-80f0-49a5-0f40-08dcc5ff26c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6736

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
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  7 +++++--
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 14 +++++++------
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 21 +++++++++----------
 3 files changed, 23 insertions(+), 19 deletions(-)

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
index aa0cc31dfe6e..0fba2df33915 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -2700,24 +2700,24 @@ static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_
 
 static int ionic_xdp_queues_config(struct ionic_lif *lif)
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
+	/* There's no need to rework memory if not going to/from NULL program.  */
+	xdp_prog = READ_ONCE(lif->xdp_prog);
+	if (!xdp_prog == !lif->rxqcqs[0]->q.xdp_prog)
 		return 0;
 
 	for (i = 0; i < lif->ionic->nrxqs_per_lif && lif->rxqcqs[i]; i++) {
 		struct ionic_queue *q = &lif->rxqcqs[i]->q;
 
-		if (q->xdp_rxq_info) {
+		if (q->xdp_prog) {
 			ionic_xdp_unregister_rxq_info(q);
+			q->xdp_prog = NULL;
 			continue;
 		}
 
@@ -2727,6 +2727,7 @@ static int ionic_xdp_queues_config(struct ionic_lif *lif)
 				i, err);
 			goto err_out;
 		}
+		q->xdp_prog = xdp_prog;
 	}
 
 	return 0;
@@ -2878,6 +2879,7 @@ static void ionic_swap_queues(struct ionic_qcq *a, struct ionic_qcq *b)
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



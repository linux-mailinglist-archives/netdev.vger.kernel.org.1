Return-Path: <netdev+bounces-122016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA4C95F922
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 20:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 149C4B21D3C
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 18:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21ACA1991B0;
	Mon, 26 Aug 2024 18:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oAffj6ii"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2088.outbound.protection.outlook.com [40.107.102.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C00C419923A
	for <netdev@vger.kernel.org>; Mon, 26 Aug 2024 18:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724697894; cv=fail; b=B6GpLxJvrLurKoaCMoEJTmZR/aNqkqg6mx2/Qo0k9wErBjsjj8G69cu2B7MqimTzmajJwXIWNxaYKyIfTPVvELNfCHgrorBbZ/DHgxouiRpVe9fTBGWavpor/SYRF3+xqQPYVFBE6Sgk23jYIigTAOr0JVbHRwwW1Q5oTfbR8iE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724697894; c=relaxed/simple;
	bh=4vaDTsU4DbGjlm01nZ6OcOdhxKnQ7lm1q/PtT+tD9Dg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rh/VBMcJYJaDthqj8V/nxK8K12g72/yMLL2Y1xO55OqyfuLYNnwkFVh132VVwviIdguC9Edzgx5BRKqeptFsPO/DnBvB0dWiAYqInsAMsickBJIWEG466psiJFXPzDxgdU2zP3ykUN5hyqSyXi6g3unCStL6MpSqKR0D2yGbVqU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oAffj6ii; arc=fail smtp.client-ip=40.107.102.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o9e1/ZvOgVePAUo/KmrbDTT8zf0niByC5eGcUAJyeX5oKbYn3lWvf+gAdlwX2eera1UItRbWdwp+P6smyqzAYuYsv1J7lvv8IHc2+G+MrrA/Y5jXzZ1N9HMM2/Pcq9NFa2rj+8mL0AKC5L9UBr6Kq5Mf+NLadltT7/fNpZZJkFa7Trhon0TW/VMXkwH1/DQ1WWBDAW4B7bNq6NAahNBLVQBGopevNWNaaQOnBrUBmbYcBx1BCHu8HWE851r/3XMEx3FqMlZALolxzq7Vqs0f33tLENOP4ZMizWC4OgIsVHxTDUtYrx1ljd4VhpiNdA0/DzCZ43ZbiWUTEOS2xUSMLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8+/O3dsDeVs9DE9yomml/Sc0Pq2WT9cVXrmLZbt3dPU=;
 b=ZY+cGcYeI9i2tZBiC4OEpgl0Wyi1byCOkTCAXhXxKt1MHvKY5BENv+2V1FsUKd0nYl3b683zMgt6/2CHGpwFAelQ8VxSZIN+WJWMw4QidHseKb6ybXJ4CLZa6QjiMCk8w3zGZ39V135i2bvc19EIDixA7BWQDGy2RS87Yb7AWsBXrSZk3FaNAMSUoCNaWC84aJTbD8ZzrZZnlru7FiaKvBH3PrF9Dvlf4B8FgRaK+TUaxuQtbe2O89S9tQsdBDObnXGGntbiCtfOEaSUxae4jx1WCIBVM37oAaANnQE/zDRfHlCAtr455xn+eJ5tsd5ZtYZ/R0bjkPpjhoZIDFVJLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8+/O3dsDeVs9DE9yomml/Sc0Pq2WT9cVXrmLZbt3dPU=;
 b=oAffj6iijcsbTHQQs9K7HF4mbOb9xTDmN2al8cOnNmZpnkW0uMbcxjOqHdL8fkr/hdlIa7xzGFk/aFTnE3u/eBtzNVWA8NYOAAPchDlKD/OgtmzZYJq6dQkhKZIo7XWdUAH1PpZjvW+mgyFYL0LvaNzSHnipifWGWBh/KJ0hnoo=
Received: from CH0PR04CA0083.namprd04.prod.outlook.com (2603:10b6:610:74::28)
 by MW3PR12MB4474.namprd12.prod.outlook.com (2603:10b6:303:2e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 18:44:45 +0000
Received: from CH1PEPF0000AD75.namprd04.prod.outlook.com
 (2603:10b6:610:74:cafe::26) by CH0PR04CA0083.outlook.office365.com
 (2603:10b6:610:74::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25 via Frontend
 Transport; Mon, 26 Aug 2024 18:44:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH1PEPF0000AD75.mail.protection.outlook.com (10.167.244.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Mon, 26 Aug 2024 18:44:45 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 26 Aug
 2024 13:44:41 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v2 net-next 5/5] ionic: convert Rx queue buffers to use page_pool
Date: Mon, 26 Aug 2024 11:44:22 -0700
Message-ID: <20240826184422.21895-6-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD75:EE_|MW3PR12MB4474:EE_
X-MS-Office365-Filtering-Correlation-Id: c38ab498-317f-49fd-ddf8-08dcc5ff2795
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LzM3tnxbqcy0AHh53GbZ1r/8tVs0zgvIXZqobLqufbSQMuD5hJViduGgm8NR?=
 =?us-ascii?Q?odeiW87vv9Z8aQiq+7GyNf9GCoRFSu0woN4SyLu0IlUBEgTGj3/XuFtHy/WY?=
 =?us-ascii?Q?mzoy6nyhKBDCsx0fGqr8C8KKopMUsSYZ2qhzP0fWS6lENmm4Kvvh2XHdm0LL?=
 =?us-ascii?Q?tYhU7nsGsHtm+M2dgJIvMgTgbNpshjiJXm3/JJcH1CPFW1qv4/Yns9tK5Q4V?=
 =?us-ascii?Q?9a6VIqiQuvHQLcoXwzXu4XRCSovxMsmqHHBZL/tXvm397aBbAndlbhzZml9H?=
 =?us-ascii?Q?rQ0W5FcvViqM0qdkB1L6u1eE1mhSu2t9iGQewZoY+BPvmoyx2h6qRRIIDBlz?=
 =?us-ascii?Q?f88RPdF7PNtpnbI+xKl78PqA31FO142mMwDX33Vkq+dedDOC6A+hVVnJ26jN?=
 =?us-ascii?Q?f+PET8TeiGaK0GVfp/y9mzOx5JZYkDUyeeTBfP+jt2aWNh8PW6oKiYPX56ta?=
 =?us-ascii?Q?Y3GC+yCIwQWeRl9n+Tf5oWYahBRHWwtdCbiEUXqlwzaEexnaUdLDbHZ9i2cY?=
 =?us-ascii?Q?9xQLEoXkLKdWYamX5qp5jZv+pe1lA0Fuw5t7IS3xGJvBb83lKcz+1yBxJgXA?=
 =?us-ascii?Q?o0vHV/5DM8jQIzrswI3Bb/bL9TNnAcIO2IZYJqGeVfIcBGL6Y4t1wUtvoKvL?=
 =?us-ascii?Q?c24hQ/ghbONKcfnGd+b0lzRIWiNSITrqJ8U3YLXT6m0yzDDlBrsk+CgkN1ns?=
 =?us-ascii?Q?7UfstUFylHNvsS3jjsIg1BDCspLGT4Fyt0Jt0woI2AOvc4KtXoaB1hPM9hYs?=
 =?us-ascii?Q?j6+mBihEWQlRsfC+q8wdLPblCjuqZNSn02ENJZ7WgNFZhcsz8Vj190tQfAAa?=
 =?us-ascii?Q?chRdsT98zbysA8bV9m/1Q4N4WpaA4TwO3BNXm5iU9GYSRCJTyZCZgxG3XNBw?=
 =?us-ascii?Q?qJ+ag+/Q11sRUUIVWeb9e4uO31ZojQWXxIIpqUCO1wvE6isoMeFh3y1frpad?=
 =?us-ascii?Q?qi8uiwhq/Rlea5jHk/IWp4tvWqlzaxpTQcnUH77DyhMjOgSdls4P3bQLvdKH?=
 =?us-ascii?Q?hikpnX7UdXAiGGVzNEqI4B19Tv7lH0Ar5i+PCnzbammrwTQGLuKq2El2IZ8b?=
 =?us-ascii?Q?d8xMHHonNt9gqogPyIArcGcOh62woG2t4cBZJ+YHvtkMB8Lz1I94HPcqD65O?=
 =?us-ascii?Q?aGTVWrH1VympeiRfcGQc+5T6KANEI4f7Hve+/vWTDTvPKjBpN9E8EA/uaMFi?=
 =?us-ascii?Q?tsEJ1SelfceftqtBt6PEk2z7nDxQVRRCk36o8ytssY9hZgabhvwf4J8ziXGU?=
 =?us-ascii?Q?wpV77N9bN6IYiobQOG/uwkrgKbuIexBSqOgcjFuXGO9vwCIBF4gzE8Ovdcx9?=
 =?us-ascii?Q?nWfqG6Ct+CQ88jdsQgQ+/DqkWBxIt73XaeFPCC9CLkoEhTtTieQSe09GyU+R?=
 =?us-ascii?Q?25aLIdmZ5cadcsxzwNI5Wd6rlRcJW4xUz0SOiXP6T+RH3sabmtOTJ9gd53Jh?=
 =?us-ascii?Q?h9Enn3xaBfaOE3Xz6XtjRhlLDaK5VY0v?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 18:44:45.0295
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c38ab498-317f-49fd-ddf8-08dcc5ff2795
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD75.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4474

From: Shannon Nelson <shannon.nelson@amd.com>

Our home-grown buffer management needs to go away and we need
to be playing nicely with the page_pool infrastructure.  This
converts the Rx traffic queues to use page_pool.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/Kconfig         |   1 +
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  14 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  58 ++-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 344 +++++++++---------
 4 files changed, 221 insertions(+), 196 deletions(-)

diff --git a/drivers/net/ethernet/pensando/Kconfig b/drivers/net/ethernet/pensando/Kconfig
index 3f7519e435b8..01fe76786f77 100644
--- a/drivers/net/ethernet/pensando/Kconfig
+++ b/drivers/net/ethernet/pensando/Kconfig
@@ -23,6 +23,7 @@ config IONIC
 	depends on PTP_1588_CLOCK_OPTIONAL
 	select NET_DEVLINK
 	select DIMLIB
+	select PAGE_POOL
 	help
 	  This enables the support for the Pensando family of Ethernet
 	  adapters.  More specific information on this driver can be
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 19ae68a86a0b..fc93c5c4dbe6 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -182,9 +182,6 @@ struct ionic_qcq;
 
 #define IONIC_MAX_BUF_LEN			((u16)-1)
 #define IONIC_PAGE_SIZE				PAGE_SIZE
-#define IONIC_PAGE_SPLIT_SZ			(PAGE_SIZE / 2)
-#define IONIC_PAGE_GFP_MASK			(GFP_ATOMIC | __GFP_NOWARN |\
-						 __GFP_COMP | __GFP_MEMALLOC)
 
 #define IONIC_XDP_MAX_LINEAR_MTU	(IONIC_PAGE_SIZE -	\
 					 (VLAN_ETH_HLEN +	\
@@ -248,11 +245,6 @@ struct ionic_queue {
 		struct ionic_rxq_desc *rxq;
 		struct ionic_admin_cmd *adminq;
 	};
-	union {
-		void __iomem *cmb_base;
-		struct ionic_txq_desc __iomem *cmb_txq;
-		struct ionic_rxq_desc __iomem *cmb_rxq;
-	};
 	union {
 		void *sg_base;
 		struct ionic_txq_sg_desc *txq_sgl;
@@ -261,8 +253,14 @@ struct ionic_queue {
 	};
 	struct xdp_rxq_info *xdp_rxq_info;
 	struct bpf_prog *xdp_prog;
+	struct page_pool *page_pool;
 	struct ionic_queue *partner;
 
+	union {
+		void __iomem *cmb_base;
+		struct ionic_txq_desc __iomem *cmb_txq;
+		struct ionic_rxq_desc __iomem *cmb_rxq;
+	};
 	unsigned int type;
 	unsigned int hw_index;
 	dma_addr_t base_pa;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 4a7763ec061f..879f2e25ec31 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -13,6 +13,7 @@
 #include <linux/cpumask.h>
 #include <linux/crash_dump.h>
 #include <linux/vmalloc.h>
+#include <net/page_pool/helpers.h>
 
 #include "ionic.h"
 #include "ionic_bus.h"
@@ -439,6 +440,9 @@ static void ionic_qcq_free(struct ionic_lif *lif, struct ionic_qcq *qcq)
 		qcq->sg_base_pa = 0;
 	}
 
+	page_pool_destroy(qcq->q.page_pool);
+	qcq->q.page_pool = NULL;
+
 	ionic_qcq_intr_free(lif, qcq);
 	vfree(qcq->q.info);
 	qcq->q.info = NULL;
@@ -579,6 +583,33 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 		goto err_out_free_qcq;
 	}
 
+	if (type == IONIC_QTYPE_RXQ) {
+		struct page_pool_params pp_params = {
+			.flags = PP_FLAG_DMA_MAP | PP_FLAG_DMA_SYNC_DEV,
+			.order = 0,
+			.pool_size = num_descs,
+			.nid = NUMA_NO_NODE,
+			.dev = lif->ionic->dev,
+			.napi = &new->napi,
+			.dma_dir = DMA_FROM_DEVICE,
+			.max_len = PAGE_SIZE,
+			.netdev = lif->netdev,
+		};
+		struct bpf_prog *xdp_prog;
+
+		xdp_prog = READ_ONCE(lif->xdp_prog);
+		if (xdp_prog)
+			pp_params.dma_dir = DMA_BIDIRECTIONAL;
+
+		new->q.page_pool = page_pool_create(&pp_params);
+		if (IS_ERR(new->q.page_pool)) {
+			netdev_err(lif->netdev, "Cannot create page_pool\n");
+			err = PTR_ERR(new->q.page_pool);
+			new->q.page_pool = NULL;
+			goto err_out_free_q_info;
+		}
+	}
+
 	new->q.type = type;
 	new->q.max_sg_elems = lif->qtype_info[type].max_sg_elems;
 
@@ -586,12 +617,12 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 			   desc_size, sg_desc_size, pid);
 	if (err) {
 		netdev_err(lif->netdev, "Cannot initialize queue\n");
-		goto err_out_free_q_info;
+		goto err_out_free_page_pool;
 	}
 
 	err = ionic_alloc_qcq_interrupt(lif, new);
 	if (err)
-		goto err_out_free_q_info;
+		goto err_out_free_page_pool;
 
 	err = ionic_cq_init(lif, &new->cq, &new->intr, num_descs, cq_desc_size);
 	if (err) {
@@ -712,6 +743,8 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 		devm_free_irq(dev, new->intr.vector, &new->napi);
 		ionic_intr_free(lif->ionic, new->intr.index);
 	}
+err_out_free_page_pool:
+	page_pool_destroy(new->q.page_pool);
 err_out_free_q_info:
 	vfree(new->q.info);
 err_out_free_qcq:
@@ -2677,15 +2710,15 @@ static int ionic_register_rxq_info(struct ionic_queue *q, unsigned int napi_id)
 
 	err = xdp_rxq_info_reg(rxq_info, q->lif->netdev, q->index, napi_id);
 	if (err) {
-		dev_err(q->dev, "Queue %d xdp_rxq_info_reg failed, err %d\n",
-			q->index, err);
+		netdev_err(q->lif->netdev, "q%d xdp_rxq_info_reg failed, err %d\n",
+			   q->index, err);
 		goto err_out;
 	}
 
-	err = xdp_rxq_info_reg_mem_model(rxq_info, MEM_TYPE_PAGE_ORDER0, NULL);
+	err = xdp_rxq_info_reg_mem_model(rxq_info, MEM_TYPE_PAGE_POOL, q->page_pool);
 	if (err) {
-		dev_err(q->dev, "Queue %d xdp_rxq_info_reg_mem_model failed, err %d\n",
-			q->index, err);
+		netdev_err(q->lif->netdev, "q%d xdp_rxq_info_reg_mem_model failed, err %d\n",
+			   q->index, err);
 		xdp_rxq_info_unreg(rxq_info);
 		goto err_out;
 	}
@@ -2855,7 +2888,16 @@ static int ionic_cmb_reconfig(struct ionic_lif *lif,
 
 static void ionic_swap_queues(struct ionic_qcq *a, struct ionic_qcq *b)
 {
-	/* only swapping the queues, not the napi, flags, or other stuff */
+	/* only swapping the queues and napi, not flags or other stuff */
+	swap(a->napi,         b->napi);
+
+	if (a->q.type == IONIC_QTYPE_RXQ) {
+		swap(a->q.page_pool, b->q.page_pool);
+		a->q.page_pool->p.napi = &a->napi;
+		if (b->q.page_pool)  /* is NULL when increasing queue count */
+			b->q.page_pool->p.napi = &b->napi;
+	}
+
 	swap(a->q.features,   b->q.features);
 	swap(a->q.num_descs,  b->q.num_descs);
 	swap(a->q.desc_size,  b->q.desc_size);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 858ab4fd9218..35e3751dd5a7 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -6,6 +6,7 @@
 #include <linux/if_vlan.h>
 #include <net/ip6_checksum.h>
 #include <net/netdev_queues.h>
+#include <net/page_pool/helpers.h>
 
 #include "ionic.h"
 #include "ionic_lif.h"
@@ -118,108 +119,57 @@ static void *ionic_rx_buf_va(struct ionic_buf_info *buf_info)
 
 static dma_addr_t ionic_rx_buf_pa(struct ionic_buf_info *buf_info)
 {
-	return buf_info->dma_addr + buf_info->page_offset;
+	return page_pool_get_dma_addr(buf_info->page) + buf_info->page_offset;
 }
 
-static unsigned int ionic_rx_buf_size(struct ionic_buf_info *buf_info)
+static void __ionic_rx_put_buf(struct ionic_queue *q,
+			       struct ionic_buf_info *buf_info,
+			       bool recycle_direct)
 {
-	return min_t(u32, IONIC_MAX_BUF_LEN, IONIC_PAGE_SIZE - buf_info->page_offset);
-}
-
-static int ionic_rx_page_alloc(struct ionic_queue *q,
-			       struct ionic_buf_info *buf_info)
-{
-	struct device *dev = q->dev;
-	dma_addr_t dma_addr;
-	struct page *page;
-
-	page = alloc_pages(IONIC_PAGE_GFP_MASK, 0);
-	if (unlikely(!page)) {
-		net_err_ratelimited("%s: %s page alloc failed\n",
-				    dev_name(dev), q->name);
-		q_to_rx_stats(q)->alloc_err++;
-		return -ENOMEM;
-	}
-
-	dma_addr = dma_map_page(dev, page, 0,
-				IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
-	if (unlikely(dma_mapping_error(dev, dma_addr))) {
-		__free_pages(page, 0);
-		net_err_ratelimited("%s: %s dma map failed\n",
-				    dev_name(dev), q->name);
-		q_to_rx_stats(q)->dma_map_err++;
-		return -EIO;
-	}
-
-	buf_info->dma_addr = dma_addr;
-	buf_info->page = page;
-	buf_info->page_offset = 0;
-
-	return 0;
-}
-
-static void ionic_rx_page_free(struct ionic_queue *q,
-			       struct ionic_buf_info *buf_info)
-{
-	struct device *dev = q->dev;
-
-	if (unlikely(!buf_info)) {
-		net_err_ratelimited("%s: %s invalid buf_info in free\n",
-				    dev_name(dev), q->name);
-		return;
-	}
-
 	if (!buf_info->page)
 		return;
 
-	dma_unmap_page(dev, buf_info->dma_addr, IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
-	__free_pages(buf_info->page, 0);
+	page_pool_put_full_page(q->page_pool, buf_info->page, recycle_direct);
 	buf_info->page = NULL;
+	buf_info->len = 0;
+	buf_info->page_offset = 0;
 }
 
-static bool ionic_rx_buf_recycle(struct ionic_queue *q,
-				 struct ionic_buf_info *buf_info, u32 len)
-{
-	u32 size;
-
-	/* don't re-use pages allocated in low-mem condition */
-	if (page_is_pfmemalloc(buf_info->page))
-		return false;
-
-	/* don't re-use buffers from non-local numa nodes */
-	if (page_to_nid(buf_info->page) != numa_mem_id())
-		return false;
-
-	size = ALIGN(len, q->xdp_prog ? IONIC_PAGE_SIZE : IONIC_PAGE_SPLIT_SZ);
-	buf_info->page_offset += size;
-	if (buf_info->page_offset >= IONIC_PAGE_SIZE)
-		return false;
 
-	get_page(buf_info->page);
+static void ionic_rx_put_buf(struct ionic_queue *q,
+			     struct ionic_buf_info *buf_info)
+{
+	__ionic_rx_put_buf(q, buf_info, false);
+}
 
-	return true;
+static void ionic_rx_put_buf_direct(struct ionic_queue *q,
+				    struct ionic_buf_info *buf_info)
+{
+	__ionic_rx_put_buf(q, buf_info, true);
 }
 
 static void ionic_rx_add_skb_frag(struct ionic_queue *q,
 				  struct sk_buff *skb,
 				  struct ionic_buf_info *buf_info,
-				  u32 off, u32 len,
+				  u32 headroom, u32 len,
 				  bool synced)
 {
 	if (!synced)
-		dma_sync_single_range_for_cpu(q->dev, ionic_rx_buf_pa(buf_info),
-					      off, len, DMA_FROM_DEVICE);
+		page_pool_dma_sync_for_cpu(q->page_pool,
+					   buf_info->page,
+					   buf_info->page_offset + headroom,
+					   len);
 
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
-			buf_info->page, buf_info->page_offset + off,
-			len,
-			IONIC_PAGE_SIZE);
+			buf_info->page, buf_info->page_offset + headroom,
+			len, buf_info->len);
 
-	if (!ionic_rx_buf_recycle(q, buf_info, len)) {
-		dma_unmap_page(q->dev, buf_info->dma_addr,
-			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
-		buf_info->page = NULL;
-	}
+	/* napi_gro_frags() will release/recycle the
+	 * page_pool buffers from the frags list
+	 */
+	buf_info->page = NULL;
+	buf_info->len = 0;
+	buf_info->page_offset = 0;
 }
 
 static struct sk_buff *ionic_rx_build_skb(struct ionic_queue *q,
@@ -244,12 +194,13 @@ static struct sk_buff *ionic_rx_build_skb(struct ionic_queue *q,
 		q_to_rx_stats(q)->alloc_err++;
 		return NULL;
 	}
+	skb_mark_for_recycle(skb);
 
 	if (headroom)
 		frag_len = min_t(u16, len,
 				 IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN);
 	else
-		frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
+		frag_len = min_t(u16, len, IONIC_PAGE_SIZE);
 
 	if (unlikely(!buf_info->page))
 		goto err_bad_buf_page;
@@ -260,7 +211,7 @@ static struct sk_buff *ionic_rx_build_skb(struct ionic_queue *q,
 	for (i = 0; i < num_sg_elems; i++, buf_info++) {
 		if (unlikely(!buf_info->page))
 			goto err_bad_buf_page;
-		frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
+		frag_len = min_t(u16, len, buf_info->len);
 		ionic_rx_add_skb_frag(q, skb, buf_info, 0, frag_len, synced);
 		len -= frag_len;
 	}
@@ -277,11 +228,13 @@ static struct sk_buff *ionic_rx_copybreak(struct net_device *netdev,
 					  struct ionic_rx_desc_info *desc_info,
 					  unsigned int headroom,
 					  unsigned int len,
+					  unsigned int num_sg_elems,
 					  bool synced)
 {
 	struct ionic_buf_info *buf_info;
 	struct device *dev = q->dev;
 	struct sk_buff *skb;
+	int i;
 
 	buf_info = &desc_info->bufs[0];
 
@@ -292,54 +245,52 @@ static struct sk_buff *ionic_rx_copybreak(struct net_device *netdev,
 		q_to_rx_stats(q)->alloc_err++;
 		return NULL;
 	}
-
-	if (unlikely(!buf_info->page)) {
-		dev_kfree_skb(skb);
-		return NULL;
-	}
+	skb_mark_for_recycle(skb);
 
 	if (!synced)
-		dma_sync_single_range_for_cpu(dev, ionic_rx_buf_pa(buf_info),
-					      headroom, len, DMA_FROM_DEVICE);
+		page_pool_dma_sync_for_cpu(q->page_pool,
+					   buf_info->page,
+					   buf_info->page_offset + headroom,
+					   len);
+
 	skb_copy_to_linear_data(skb, ionic_rx_buf_va(buf_info) + headroom, len);
-	dma_sync_single_range_for_device(dev, ionic_rx_buf_pa(buf_info),
-					 headroom, len, DMA_FROM_DEVICE);
 
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, netdev);
 
+	/* recycle the Rx buffer now that we're done with it */
+	ionic_rx_put_buf_direct(q, buf_info);
+	buf_info++;
+	for (i = 0; i < num_sg_elems; i++, buf_info++)
+		ionic_rx_put_buf_direct(q, buf_info);
+
 	return skb;
 }
 
 static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
-				    struct ionic_tx_desc_info *desc_info)
+				    struct ionic_tx_desc_info *desc_info,
+				    bool in_napi)
 {
-	unsigned int nbufs = desc_info->nbufs;
-	struct ionic_buf_info *buf_info;
-	struct device *dev = q->dev;
-	int i;
+	struct xdp_frame_bulk bq;
 
-	if (!nbufs)
+	if (!desc_info->nbufs)
 		return;
 
-	buf_info = desc_info->bufs;
-	dma_unmap_single(dev, buf_info->dma_addr,
-			 buf_info->len, DMA_TO_DEVICE);
-	if (desc_info->act == XDP_TX)
-		__free_pages(buf_info->page, 0);
-	buf_info->page = NULL;
+	xdp_frame_bulk_init(&bq);
+	rcu_read_lock(); /* need for xdp_return_frame_bulk */
 
-	buf_info++;
-	for (i = 1; i < nbufs + 1 && buf_info->page; i++, buf_info++) {
-		dma_unmap_page(dev, buf_info->dma_addr,
-			       buf_info->len, DMA_TO_DEVICE);
-		if (desc_info->act == XDP_TX)
-			__free_pages(buf_info->page, 0);
-		buf_info->page = NULL;
+	if (desc_info->act == XDP_TX) {
+		if (likely(in_napi))
+			xdp_return_frame_rx_napi(desc_info->xdpf);
+		else
+			xdp_return_frame(desc_info->xdpf);
+	} else if (desc_info->act == XDP_REDIRECT) {
+		ionic_tx_desc_unmap_bufs(q, desc_info);
+		xdp_return_frame_bulk(desc_info->xdpf, &bq);
 	}
 
-	if (desc_info->act == XDP_REDIRECT)
-		xdp_return_frame(desc_info->xdpf);
+	xdp_flush_frame_bulk(&bq);
+	rcu_read_unlock();
 
 	desc_info->nbufs = 0;
 	desc_info->xdpf = NULL;
@@ -363,9 +314,17 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 	buf_info = desc_info->bufs;
 	stats = q_to_tx_stats(q);
 
-	dma_addr = ionic_tx_map_single(q, frame->data, len);
-	if (!dma_addr)
-		return -EIO;
+	if (act == XDP_TX) {
+		dma_addr = page_pool_get_dma_addr(page) +
+			   off + XDP_PACKET_HEADROOM;
+		dma_sync_single_for_device(q->dev, dma_addr,
+					   len, DMA_TO_DEVICE);
+	} else /* XDP_REDIRECT */ {
+		dma_addr = ionic_tx_map_single(q, frame->data, len);
+		if (!dma_addr)
+			return -EIO;
+	}
+
 	buf_info->dma_addr = dma_addr;
 	buf_info->len = len;
 	buf_info->page = page;
@@ -387,10 +346,21 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 		frag = sinfo->frags;
 		elem = ionic_tx_sg_elems(q);
 		for (i = 0; i < sinfo->nr_frags; i++, frag++, bi++) {
-			dma_addr = ionic_tx_map_frag(q, frag, 0, skb_frag_size(frag));
-			if (!dma_addr) {
-				ionic_tx_desc_unmap_bufs(q, desc_info);
-				return -EIO;
+			if (act == XDP_TX) {
+				struct page *pg = skb_frag_page(frag);
+
+				dma_addr = page_pool_get_dma_addr(pg) +
+					   skb_frag_off(frag);
+				dma_sync_single_for_device(q->dev, dma_addr,
+							   skb_frag_size(frag),
+							   DMA_TO_DEVICE);
+			} else {
+				dma_addr = ionic_tx_map_frag(q, frag, 0,
+							     skb_frag_size(frag));
+				if (dma_mapping_error(q->dev, dma_addr)) {
+					ionic_tx_desc_unmap_bufs(q, desc_info);
+					return -EIO;
+				}
 			}
 			bi->dma_addr = dma_addr;
 			bi->len = skb_frag_size(frag);
@@ -488,8 +458,6 @@ static void ionic_xdp_rx_unlink_bufs(struct ionic_queue *q,
 	int i;
 
 	for (i = 0; i < nbufs; i++) {
-		dma_unmap_page(q->dev, buf_info->dma_addr,
-			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
 		buf_info->page = NULL;
 		buf_info++;
 	}
@@ -516,11 +484,9 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 	frag_len = min_t(u16, len, IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN);
 	xdp_prepare_buff(&xdp_buf, ionic_rx_buf_va(buf_info),
 			 XDP_PACKET_HEADROOM, frag_len, false);
-
-	dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(buf_info),
-				      XDP_PACKET_HEADROOM, frag_len,
-				      DMA_FROM_DEVICE);
-
+	page_pool_dma_sync_for_cpu(rxq->page_pool, buf_info->page,
+				   buf_info->page_offset + XDP_PACKET_HEADROOM,
+				   frag_len);
 	prefetchw(&xdp_buf.data_hard_start);
 
 	/*  We limit MTU size to one buffer if !xdp_has_frags, so
@@ -542,15 +508,16 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		do {
 			if (unlikely(sinfo->nr_frags >= MAX_SKB_FRAGS)) {
 				err = -ENOSPC;
-				goto out_xdp_abort;
+				break;
 			}
 
 			frag = &sinfo->frags[sinfo->nr_frags];
 			sinfo->nr_frags++;
 			bi++;
-			frag_len = min_t(u16, remain_len, ionic_rx_buf_size(bi));
-			dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(bi),
-						      0, frag_len, DMA_FROM_DEVICE);
+			frag_len = min_t(u16, remain_len, bi->len);
+			page_pool_dma_sync_for_cpu(rxq->page_pool, bi->page,
+						   buf_info->page_offset,
+						   frag_len);
 			skb_frag_fill_page_desc(frag, bi->page, 0, frag_len);
 			sinfo->xdp_frags_size += frag_len;
 			remain_len -= frag_len;
@@ -569,14 +536,16 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		return false;  /* false = we didn't consume the packet */
 
 	case XDP_DROP:
-		ionic_rx_page_free(rxq, buf_info);
+		ionic_rx_put_buf_direct(rxq, buf_info);
 		stats->xdp_drop++;
 		break;
 
 	case XDP_TX:
 		xdpf = xdp_convert_buff_to_frame(&xdp_buf);
-		if (!xdpf)
-			goto out_xdp_abort;
+		if (!xdpf) {
+			err = -ENOSPC;
+			break;
+		}
 
 		txq = rxq->partner;
 		nq = netdev_get_tx_queue(netdev, txq->index);
@@ -588,7 +557,8 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 					  ionic_q_space_avail(txq),
 					  1, 1)) {
 			__netif_tx_unlock(nq);
-			goto out_xdp_abort;
+			err = -EIO;
+			break;
 		}
 
 		err = ionic_xdp_post_frame(txq, xdpf, XDP_TX,
@@ -598,19 +568,17 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		__netif_tx_unlock(nq);
 		if (unlikely(err)) {
 			netdev_dbg(netdev, "tx ionic_xdp_post_frame err %d\n", err);
-			goto out_xdp_abort;
+			break;
 		}
 		ionic_xdp_rx_unlink_bufs(rxq, buf_info, nbufs);
 		stats->xdp_tx++;
-
-		/* the Tx completion will free the buffers */
 		break;
 
 	case XDP_REDIRECT:
 		err = xdp_do_redirect(netdev, &xdp_buf, xdp_prog);
 		if (unlikely(err)) {
 			netdev_dbg(netdev, "xdp_do_redirect err %d\n", err);
-			goto out_xdp_abort;
+			break;
 		}
 		ionic_xdp_rx_unlink_bufs(rxq, buf_info, nbufs);
 		rxq->xdp_flush = true;
@@ -619,15 +587,15 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 
 	case XDP_ABORTED:
 	default:
-		goto out_xdp_abort;
+		err = -EIO;
+		break;
 	}
 
-	return true;
-
-out_xdp_abort:
-	trace_xdp_exception(netdev, xdp_prog, xdp_action);
-	ionic_rx_page_free(rxq, buf_info);
-	stats->xdp_aborted++;
+	if (err) {
+		ionic_rx_put_buf_direct(rxq, buf_info);
+		trace_xdp_exception(netdev, xdp_prog, xdp_action);
+		stats->xdp_aborted++;
+	}
 
 	return true;
 }
@@ -673,7 +641,8 @@ static void ionic_rx_clean(struct ionic_queue *q,
 	use_copybreak = len <= q->lif->rx_copybreak;
 	if (use_copybreak)
 		skb = ionic_rx_copybreak(netdev, q, desc_info,
-					 headroom, len, synced);
+					 headroom, len,
+					 comp->num_sg_elems, synced);
 	else
 		skb = ionic_rx_build_skb(q, desc_info, headroom, len,
 					 comp->num_sg_elems, synced);
@@ -794,6 +763,9 @@ void ionic_rx_fill(struct ionic_queue *q)
 	struct ionic_buf_info *buf_info;
 	unsigned int fill_threshold;
 	struct ionic_rxq_desc *desc;
+	unsigned int first_frag_len;
+	unsigned int first_buf_len;
+	unsigned int headroom = 0;
 	unsigned int remain_len;
 	unsigned int frag_len;
 	unsigned int nfrags;
@@ -811,35 +783,42 @@ void ionic_rx_fill(struct ionic_queue *q)
 
 	len = netdev->mtu + VLAN_ETH_HLEN;
 
-	for (i = n_fill; i; i--) {
-		unsigned int headroom = 0;
-		unsigned int buf_len;
+	if (q->xdp_prog) {
+		/* Always alloc the full size buffer, but only need
+		 * the actual frag_len in the descriptor
+		 * XDP uses space in the first buffer, so account for
+		 * head room, tail room, and ip header in the first frag size.
+		 */
+		headroom = XDP_PACKET_HEADROOM;
+		first_buf_len = IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN + headroom;
+		first_frag_len = min_t(u16, len + headroom, first_buf_len);
+	} else {
+		/* Use MTU size if smaller than max buffer size */
+		first_frag_len = min_t(u16, len, IONIC_PAGE_SIZE);
+		first_buf_len = first_frag_len;
+	}
 
+	for (i = n_fill; i; i--) {
+		/* fill main descriptor - buf[0] */
 		nfrags = 0;
 		remain_len = len;
 		desc = &q->rxq[q->head_idx];
 		desc_info = &q->rx_info[q->head_idx];
 		buf_info = &desc_info->bufs[0];
 
-		if (!buf_info->page) { /* alloc a new buffer? */
-			if (unlikely(ionic_rx_page_alloc(q, buf_info))) {
-				desc->addr = 0;
-				desc->len = 0;
-				return;
-			}
-		}
-
-		/* fill main descriptor - buf[0]
-		 * XDP uses space in the first buffer, so account for
-		 * head room, tail room, and ip header in the first frag size.
-		 */
-		if (q->xdp_prog) {
-			buf_len = IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN;
-			headroom = XDP_PACKET_HEADROOM;
-		} else {
-			buf_len = ionic_rx_buf_size(buf_info);
+		buf_info->len = first_buf_len;
+		frag_len = first_frag_len - headroom;
+
+		/* get a new buffer if we can't reuse one */
+		if (!buf_info->page)
+			buf_info->page = page_pool_alloc(q->page_pool,
+							 &buf_info->page_offset,
+							 &buf_info->len,
+							 GFP_ATOMIC);
+		if (unlikely(!buf_info->page)) {
+			buf_info->len = 0;
+			return;
 		}
-		frag_len = min_t(u16, len, buf_len);
 
 		desc->addr = cpu_to_le64(ionic_rx_buf_pa(buf_info) + headroom);
 		desc->len = cpu_to_le16(frag_len);
@@ -850,16 +829,26 @@ void ionic_rx_fill(struct ionic_queue *q)
 		/* fill sg descriptors - buf[1..n] */
 		sg_elem = q->rxq_sgl[q->head_idx].elems;
 		for (j = 0; remain_len > 0 && j < q->max_sg_elems; j++, sg_elem++) {
-			if (!buf_info->page) { /* alloc a new sg buffer? */
-				if (unlikely(ionic_rx_page_alloc(q, buf_info))) {
-					sg_elem->addr = 0;
-					sg_elem->len = 0;
+			frag_len = min_t(u16, remain_len, IONIC_PAGE_SIZE);
+
+			/* Recycle any leftover buffers that are too small to reuse */
+			if (unlikely(buf_info->page && buf_info->len < frag_len))
+				ionic_rx_put_buf_direct(q, buf_info);
+
+			/* Get new buffer if needed */
+			if (!buf_info->page) {
+				buf_info->len = frag_len;
+				buf_info->page = page_pool_alloc(q->page_pool,
+								 &buf_info->page_offset,
+								 &buf_info->len,
+								 GFP_ATOMIC);
+				if (unlikely(!buf_info->page)) {
+					buf_info->len = 0;
 					return;
 				}
 			}
 
 			sg_elem->addr = cpu_to_le64(ionic_rx_buf_pa(buf_info));
-			frag_len = min_t(u16, remain_len, ionic_rx_buf_size(buf_info));
 			sg_elem->len = cpu_to_le16(frag_len);
 			remain_len -= frag_len;
 			buf_info++;
@@ -889,17 +878,12 @@ void ionic_rx_fill(struct ionic_queue *q)
 void ionic_rx_empty(struct ionic_queue *q)
 {
 	struct ionic_rx_desc_info *desc_info;
-	struct ionic_buf_info *buf_info;
 	unsigned int i, j;
 
 	for (i = 0; i < q->num_descs; i++) {
 		desc_info = &q->rx_info[i];
-		for (j = 0; j < ARRAY_SIZE(desc_info->bufs); j++) {
-			buf_info = &desc_info->bufs[j];
-			if (buf_info->page)
-				ionic_rx_page_free(q, buf_info);
-		}
-
+		for (j = 0; j < ARRAY_SIZE(desc_info->bufs); j++)
+			ionic_rx_put_buf(q, &desc_info->bufs[j]);
 		desc_info->nbufs = 0;
 	}
 
@@ -1172,7 +1156,7 @@ static void ionic_tx_clean(struct ionic_queue *q,
 	struct sk_buff *skb;
 
 	if (desc_info->xdpf) {
-		ionic_xdp_tx_desc_clean(q->partner, desc_info);
+		ionic_xdp_tx_desc_clean(q->partner, desc_info, in_napi);
 		stats->clean++;
 
 		if (unlikely(__netif_subqueue_stopped(q->lif->netdev, q->index)))
-- 
2.17.1



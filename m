Return-Path: <netdev+bounces-106581-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17E79916E99
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 18:57:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B2C91C22F53
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 16:57:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7A7176247;
	Tue, 25 Jun 2024 16:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Pvo80Q9v"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2066.outbound.protection.outlook.com [40.107.237.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3565F17623E
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719334649; cv=fail; b=cMS8nGqUJPTw4ltCdPsn3jpWpU0/YMWbGSukhuB8XPKm69j2ga/Ytv9M6AbaQ+TeFBjMGUy/Dvp0vay/8B+WUR5pIyewDygpYBE837tL1LyarciojpvXMM5y/GgCExIv5nPaSV9Gao7rt3XyXUikffXufg9A71wbX6lCV9/dz2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719334649; c=relaxed/simple;
	bh=viodcoU7MWht5YztuJL8Fw5l9mANrTV4i3mpgbUeskg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=k4xjNQGdHQUsvkfaXKcIUoESv5kHYobt2Xex2i+2zabZ0O9rasOpos7BrvSP2d8XNpNI9iMHyIvDiYn/I0SSgwwA5uR+N2Kdzv/brRDN7jM8kRL383/m5Scilnh72P8S0IdQDcvVFFhz/TfViurZe7zuWJAczGG9Up08fVGxrVQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Pvo80Q9v; arc=fail smtp.client-ip=40.107.237.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kvOk0wqdkM6yCQ9dNVcnk976XqceelzIgyHK6mlTIcZuQLeOJBxc+QhZ5pTKIbnWx5N2BFxDXwPMltaX1WTWC4Q8EBz0XHvHY40Q7MPFe3UaGU6y9ffhpFgg4F6joZCYoDXyUM2Xpml2SXoR+CPIkiV7ly7l/oscE+Cb3tz5bi+OQ8otxlxFujDxrpARqyE4dF7w8fqXdeC0oMzJHq+pud9UabfsQEyS20mvIi4gprqpwme96bVYoR+Qp+fetjWhwwqyxwbWytTE1xcnmvTH777gQUUsxLLjNduC1LnBkE469V0dtDrOIUDNTxFUX//PTueGX68aJq5A9sXkBbR93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s7N4pdD30ua9JdNWh0pev1xDmdGGzVXihk+dOt29R98=;
 b=YjthIhYICpKf7BfWl/x/XrRLhz2rYym6Pj4TNZZN3jDRnNU83AddWRB3uRpJ5ddtbepqvE4QLTYZFAOUk9J5bQVOJB4LR6QaC6EuGpq3nbhRlXW3mqLTXZMIHO9WyGEFz0Is8iWETQPCLmG5I7n36QQ1gB884G8kHzHZKYSaE+c8qjKppKUui9QJyivZhbGlhFryYC2QlRjcm48a9SOFEhgnMspaAZc4F+0oBbFmOfA5xDWy3+5Bl4XAxB865qmWl2x46UV3DZXQLMjenesbFjgvheQmuQJQtcSQPLAgfu4BZl9KJ3grZRjVIoyKue4f6AxhykXRxAqqeXaXXYVN4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s7N4pdD30ua9JdNWh0pev1xDmdGGzVXihk+dOt29R98=;
 b=Pvo80Q9vQh1hWzeaoxIDfJ+cM3XJ7Fr1DliazQVs8+fee3OYPM5k9JsW88w7NBWObAg6cwo6EYFMeAdzXKZ6qJgF9z/BNOctQwJIe20/dhbVwStbzsqv2lZLUCJWBajxb+bqJYzejswo+h394s/FSFdrFd6YcdYkSVK9yVty5Aw=
Received: from DS7PR03CA0337.namprd03.prod.outlook.com (2603:10b6:8:55::25) by
 SN7PR12MB7855.namprd12.prod.outlook.com (2603:10b6:806:343::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Tue, 25 Jun
 2024 16:57:22 +0000
Received: from DS3PEPF0000C380.namprd04.prod.outlook.com
 (2603:10b6:8:55:cafe::1a) by DS7PR03CA0337.outlook.office365.com
 (2603:10b6:8:55::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.38 via Frontend
 Transport; Tue, 25 Jun 2024 16:57:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF0000C380.mail.protection.outlook.com (10.167.23.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 25 Jun 2024 16:57:22 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Jun
 2024 11:57:19 -0500
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [RFC PATCH net-next] ionic: convert Rx queue buffers to use page_pool
Date: Tue, 25 Jun 2024 09:56:58 -0700
Message-ID: <20240625165658.34598-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C380:EE_|SN7PR12MB7855:EE_
X-MS-Office365-Filtering-Correlation-Id: 7eca9f51-e91d-4815-ad94-08dc9537e1c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230038|1800799022|82310400024|36860700011|376012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?7UcHd6QIamkQTinVk7ALT84itr4QPI68t4kmwpZN4znjQK/QFCF4aoOkRLfe?=
 =?us-ascii?Q?GycgDgAE4UWArwTvCLpxyr1ioS2WYr1MYPdRcb5PMnxBmeFDrYnGNfcdBCo4?=
 =?us-ascii?Q?t4OINb+sQpgBCM8S4uzmFe1vo3d2uMQnke9qiJyqRLlRglwi/+9ru1soW8mo?=
 =?us-ascii?Q?5dBpGk/C07rJu0OnIJR4HfWs0f2uSephH0RTFkANSLt6ksvxLmiLjht0d/ue?=
 =?us-ascii?Q?5ycJzJkbxW48pqyML0ESSrD9b5j47wHgCh2sBUL0vCfo1jZfr8O5YS9fhFhU?=
 =?us-ascii?Q?4qqse/hRBuzMVkrenRbq5fRsYc7z1pByqKnwIakqkeJxkrTjJAPCCnpSCDxh?=
 =?us-ascii?Q?pZpkL7fe75gAlM34mjpBju+uKi4H9iRWFFA4syLVNPEvJftBtx+Ctbo8aAuv?=
 =?us-ascii?Q?4b86Nh5wMALNzUftRe384x+zeAc/R5bjGPIeWmC0LfNuUuI5iitEYa8yBbs4?=
 =?us-ascii?Q?eXUZZlBbsT0IEpi0BodsSsh+Nv64ees3yKv3dbpcbvY7V2jb/B32I1Nmnli6?=
 =?us-ascii?Q?0fj5zisfteU2mJB3hJGZ3W0H2Dil1Ams/7kOB3PNfefyCCcbgavFAwC1dxbE?=
 =?us-ascii?Q?a7qLo6e1mnGfie39+p8gmATZd5JIMQvPlPigJ+07oUsJOUtJViGSDCNMO/fc?=
 =?us-ascii?Q?pCmpiTG/SyqI/gcEZesNlcwgEuOm9QiS1pQgXu719OXLvDFGGre7vVylkAt7?=
 =?us-ascii?Q?i/Wn0jUg7zHK6i1V+HVGd8GgqBe+IYOfyzumv1FONqh+zg4z06b/TN6T+4PY?=
 =?us-ascii?Q?HgX3hdIu21WWNNyGX61vuTbs06AZxgda5K9/UiODatHPNbZdZnxOsEXYNAX1?=
 =?us-ascii?Q?KoCYrfNhek6xpL2WXCO1TXcnNPBj7cLXjz2FckKUkfXmAXAbfsRWUixpx/ck?=
 =?us-ascii?Q?LQCkuAGYsEB0ewOJnbvY4+7PizFaqCZZ5i11isMYugFjnwYv9FKGG7jUfmEJ?=
 =?us-ascii?Q?v+a8xkVCH/Zy2MKhmwem6WyNX2U/AiXPl65ErnKEbld4OjnP0ESoCuCOyn5o?=
 =?us-ascii?Q?mGeuFqL+DXC3cIkiG7Mg//NGkMfmu/U+iUD4Ssr0l54nWB/EQx7zahIZ2Kbz?=
 =?us-ascii?Q?K+IftKEC2ljyZV9xo+S9/NmR0kCiiHJMArhMlhSij0S2pi1lCzgvdgqPPQBu?=
 =?us-ascii?Q?T+yscRvoDEBJn41qOifM63FnlI9FARP0/vzGTNr3IPrd4zFoV5pN6HKreTF5?=
 =?us-ascii?Q?oKjKCpjjxU8D+U+Q/Xc41KpSE21Ah3pTnoykLRyMR/hokcgNZdF9Pal9fVaG?=
 =?us-ascii?Q?S1YtpMHNheV4mMj8OXBN1+N/sL67pd4PEsGbjV6+gJlajB/2py6XifZod/Gr?=
 =?us-ascii?Q?EOHlaAhj54gDmAtiMEBHpelKuV2C9CjDLJvZjRjMQlCEwZVDvybDZlTCxHdw?=
 =?us-ascii?Q?DmXAgTHgNCgxovLU2BraaemFjnWs7rvTXl9+sGHfRkZ9U9SRyA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230038)(1800799022)(82310400024)(36860700011)(376012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2024 16:57:22.2308
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7eca9f51-e91d-4815-ad94-08dc9537e1c6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF0000C380.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7855

Our home-grown buffer management needs to go away and we need
to be playing nicely with the page_pool infrastructure.  This
converts the Rx traffic queues to use page_pool.

RFC: This is still being tweaked and tested, but has passed some
     basic testing for both normal and jumbo frames going through
     normal paths as well as XDP PASS, DROP, ABORTED, TX, and
     REDIRECT paths.  It has not been under any performance test
     runs, but a quicky iperf3 test shows similar numbers.

     This patch seems far enough along that a look-over by some
     page_pool experienced reviewers would be appreciated.

     Thanks!
     sln

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/Kconfig         |   1 +
 .../net/ethernet/pensando/ionic/ionic_dev.h   |   2 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  43 ++-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 318 ++++++++----------
 4 files changed, 189 insertions(+), 175 deletions(-)

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
index 92f16b6c5662..45ad2bf1e1e7 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -177,7 +177,6 @@ struct ionic_dev {
 	struct ionic_devinfo dev_info;
 };
 
-struct ionic_queue;
 struct ionic_qcq;
 
 #define IONIC_MAX_BUF_LEN			((u16)-1)
@@ -262,6 +261,7 @@ struct ionic_queue {
 	};
 	struct xdp_rxq_info *xdp_rxq_info;
 	struct ionic_queue *partner;
+	struct page_pool *page_pool;
 	dma_addr_t base_pa;
 	dma_addr_t cmb_base_pa;
 	dma_addr_t sg_base_pa;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 38ce35462737..e1cd5982bb2e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -13,6 +13,7 @@
 #include <linux/cpumask.h>
 #include <linux/crash_dump.h>
 #include <linux/vmalloc.h>
+#include <net/page_pool/helpers.h>
 
 #include "ionic.h"
 #include "ionic_bus.h"
@@ -440,6 +441,8 @@ static void ionic_qcq_free(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	ionic_xdp_unregister_rxq_info(&qcq->q);
 	ionic_qcq_intr_free(lif, qcq);
 
+	page_pool_destroy(qcq->q.page_pool);
+	qcq->q.page_pool = NULL;
 	vfree(qcq->q.info);
 	qcq->q.info = NULL;
 }
@@ -579,6 +582,36 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
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
+			.offset = 0,
+			.netdev = lif->netdev,
+		};
+		struct bpf_prog *xdp_prog;
+
+		xdp_prog = READ_ONCE(lif->xdp_prog);
+		if (xdp_prog) {
+			pp_params.dma_dir = DMA_BIDIRECTIONAL;
+			pp_params.offset = XDP_PACKET_HEADROOM;
+		}
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
 
@@ -586,12 +619,12 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
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
@@ -712,6 +745,8 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 		devm_free_irq(dev, new->intr.vector, &new->napi);
 		ionic_intr_free(lif->ionic, new->intr.index);
 	}
+err_out_free_page_pool:
+	page_pool_destroy(new->q.page_pool);
 err_out_free_q_info:
 	vfree(new->q.info);
 err_out_free_qcq:
@@ -2681,7 +2716,8 @@ static int ionic_xdp_register_rxq_info(struct ionic_queue *q, unsigned int napi_
 		goto err_out;
 	}
 
-	err = xdp_rxq_info_reg_mem_model(rxq_info, MEM_TYPE_PAGE_ORDER0, NULL);
+	err = xdp_rxq_info_reg_mem_model(rxq_info, MEM_TYPE_PAGE_POOL,
+					 q->page_pool);
 	if (err) {
 		dev_err(q->dev, "Queue %d xdp_rxq_info_reg_mem_model failed, err %d\n",
 			q->index, err);
@@ -2878,6 +2914,7 @@ static void ionic_swap_queues(struct ionic_qcq *a, struct ionic_qcq *b)
 	swap(a->q.base,       b->q.base);
 	swap(a->q.base_pa,    b->q.base_pa);
 	swap(a->q.info,       b->q.info);
+	swap(a->q.page_pool,  b->q.page_pool);
 	swap(a->q.xdp_rxq_info, b->q.xdp_rxq_info);
 	swap(a->q.partner,    b->q.partner);
 	swap(a->q_base,       b->q_base);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 5bf13a5d411c..ffef3d66e0df 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -6,6 +6,7 @@
 #include <linux/if_vlan.h>
 #include <net/ip6_checksum.h>
 #include <net/netdev_queues.h>
+#include <net/page_pool/helpers.h>
 
 #include "ionic.h"
 #include "ionic_lif.h"
@@ -117,86 +118,19 @@ static void *ionic_rx_buf_va(struct ionic_buf_info *buf_info)
 
 static dma_addr_t ionic_rx_buf_pa(struct ionic_buf_info *buf_info)
 {
-	return buf_info->dma_addr + buf_info->page_offset;
+	return page_pool_get_dma_addr(buf_info->page) + buf_info->page_offset;
 }
 
-static unsigned int ionic_rx_buf_size(struct ionic_buf_info *buf_info)
+static void ionic_rx_put_buf(struct ionic_queue *q,
+			     struct ionic_buf_info *buf_info)
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
+	page_pool_put_full_page(q->page_pool, buf_info->page, false);
 	buf_info->page = NULL;
-}
-
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
-	size = ALIGN(len, q->xdp_rxq_info ? IONIC_PAGE_SIZE : IONIC_PAGE_SPLIT_SZ);
-	buf_info->page_offset += size;
-	if (buf_info->page_offset >= IONIC_PAGE_SIZE)
-		return false;
-
-	get_page(buf_info->page);
-
-	return true;
+	buf_info->len = 0;
+	buf_info->page_offset = 0;
 }
 
 static void ionic_rx_add_skb_frag(struct ionic_queue *q,
@@ -207,18 +141,19 @@ static void ionic_rx_add_skb_frag(struct ionic_queue *q,
 {
 	if (!synced)
 		dma_sync_single_range_for_cpu(q->dev, ionic_rx_buf_pa(buf_info),
-					      off, len, DMA_FROM_DEVICE);
+					      off, len,
+					      page_pool_get_dma_dir(q->page_pool));
 
 	skb_add_rx_frag(skb, skb_shinfo(skb)->nr_frags,
 			buf_info->page, buf_info->page_offset + off,
-			len,
-			IONIC_PAGE_SIZE);
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
@@ -243,12 +178,13 @@ static struct sk_buff *ionic_rx_build_skb(struct ionic_queue *q,
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
@@ -259,7 +195,7 @@ static struct sk_buff *ionic_rx_build_skb(struct ionic_queue *q,
 	for (i = 0; i < num_sg_elems; i++, buf_info++) {
 		if (unlikely(!buf_info->page))
 			goto err_bad_buf_page;
-		frag_len = min_t(u16, len, ionic_rx_buf_size(buf_info));
+		frag_len = min_t(u16, len, buf_info->len);
 		ionic_rx_add_skb_frag(q, skb, buf_info, 0, frag_len, synced);
 		len -= frag_len;
 	}
@@ -276,11 +212,14 @@ static struct sk_buff *ionic_rx_copybreak(struct net_device *netdev,
 					  struct ionic_rx_desc_info *desc_info,
 					  unsigned int headroom,
 					  unsigned int len,
+					  unsigned int num_sg_elems,
 					  bool synced)
 {
 	struct ionic_buf_info *buf_info;
+	enum dma_data_direction dma_dir;
 	struct device *dev = q->dev;
 	struct sk_buff *skb;
+	int i;
 
 	buf_info = &desc_info->bufs[0];
 
@@ -291,54 +230,58 @@ static struct sk_buff *ionic_rx_copybreak(struct net_device *netdev,
 		q_to_rx_stats(q)->alloc_err++;
 		return NULL;
 	}
+	skb_mark_for_recycle(skb);
 
-	if (unlikely(!buf_info->page)) {
-		dev_kfree_skb(skb);
-		return NULL;
-	}
-
+	dma_dir = page_pool_get_dma_dir(q->page_pool);
 	if (!synced)
 		dma_sync_single_range_for_cpu(dev, ionic_rx_buf_pa(buf_info),
-					      headroom, len, DMA_FROM_DEVICE);
+					      headroom, len, dma_dir);
 	skb_copy_to_linear_data(skb, ionic_rx_buf_va(buf_info) + headroom, len);
-	dma_sync_single_range_for_device(dev, ionic_rx_buf_pa(buf_info),
-					 headroom, len, DMA_FROM_DEVICE);
 
 	skb_put(skb, len);
 	skb->protocol = eth_type_trans(skb, netdev);
 
+	/* recycle the Rx buffer now that we're done with it */
+	ionic_rx_put_buf(q, buf_info);
+	buf_info++;
+	for (i = 0; i < num_sg_elems; i++, buf_info++)
+		ionic_rx_put_buf(q, buf_info);
+
 	return skb;
 }
 
+static void ionic_xdp_rx_put_bufs(struct ionic_queue *q,
+				  struct ionic_buf_info *buf_info,
+				  int nbufs)
+{
+	int i;
+
+	for (i = 0; i < nbufs; i++) {
+		buf_info->page = NULL;
+		buf_info++;
+	}
+}
+
 static void ionic_xdp_tx_desc_clean(struct ionic_queue *q,
 				    struct ionic_tx_desc_info *desc_info)
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
+		xdp_return_frame_rx_napi(desc_info->xdpf);
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
@@ -362,9 +305,15 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 	buf_info = desc_info->bufs;
 	stats = q_to_tx_stats(q);
 
-	dma_addr = ionic_tx_map_single(q, frame->data, len);
-	if (!dma_addr)
-		return -EIO;
+	if (act == XDP_TX) {
+		dma_addr = page_pool_get_dma_addr(page) + off;
+		dma_sync_single_for_device(q->dev, dma_addr, len, DMA_TO_DEVICE);
+	} else /* XDP_REDIRECT */ {
+		dma_addr = ionic_tx_map_single(q, frame->data, len);
+		if (dma_mapping_error(q->dev, dma_addr))
+			return -EIO;
+	}
+
 	buf_info->dma_addr = dma_addr;
 	buf_info->len = len;
 	buf_info->page = page;
@@ -386,10 +335,19 @@ static int ionic_xdp_post_frame(struct ionic_queue *q, struct xdp_frame *frame,
 		frag = sinfo->frags;
 		elem = ionic_tx_sg_elems(q);
 		for (i = 0; i < sinfo->nr_frags; i++, frag++, bi++) {
-			dma_addr = ionic_tx_map_frag(q, frag, 0, skb_frag_size(frag));
-			if (!dma_addr) {
-				ionic_tx_desc_unmap_bufs(q, desc_info);
-				return -EIO;
+			if (act == XDP_TX) {
+				dma_addr = page_pool_get_dma_addr(skb_frag_page(frag));
+				dma_addr += skb_frag_off(frag);
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
@@ -493,6 +451,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 	struct netdev_queue *nq;
 	struct xdp_frame *xdpf;
 	int remain_len;
+	int nbufs = 1;
 	int frag_len;
 	int err = 0;
 
@@ -526,13 +485,13 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
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
+			frag_len = min_t(u16, remain_len, bi->len);
 			dma_sync_single_range_for_cpu(rxq->dev, ionic_rx_buf_pa(bi),
 						      0, frag_len, DMA_FROM_DEVICE);
 			skb_frag_fill_page_desc(frag, bi->page, 0, frag_len);
@@ -542,6 +501,7 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 			if (page_is_pfmemalloc(bi->page))
 				xdp_buff_set_frag_pfmemalloc(&xdp_buf);
 		} while (remain_len > 0);
+		nbufs += sinfo->nr_frags;
 	}
 
 	xdp_action = bpf_prog_run_xdp(xdp_prog, &xdp_buf);
@@ -552,14 +512,15 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		return false;  /* false = we didn't consume the packet */
 
 	case XDP_DROP:
-		ionic_rx_page_free(rxq, buf_info);
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
@@ -571,12 +532,10 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 					  ionic_q_space_avail(txq),
 					  1, 1)) {
 			__netif_tx_unlock(nq);
-			goto out_xdp_abort;
+			err = -EIO;
+			break;
 		}
 
-		dma_unmap_page(rxq->dev, buf_info->dma_addr,
-			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
-
 		err = ionic_xdp_post_frame(txq, xdpf, XDP_TX,
 					   buf_info->page,
 					   buf_info->page_offset,
@@ -584,40 +543,35 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		__netif_tx_unlock(nq);
 		if (unlikely(err)) {
 			netdev_dbg(netdev, "tx ionic_xdp_post_frame err %d\n", err);
-			goto out_xdp_abort;
+			break;
 		}
-		buf_info->page = NULL;
+		ionic_xdp_rx_put_bufs(rxq, buf_info, nbufs);
 		stats->xdp_tx++;
 
-		/* the Tx completion will free the buffers */
 		break;
 
 	case XDP_REDIRECT:
-		/* unmap the pages before handing them to a different device */
-		dma_unmap_page(rxq->dev, buf_info->dma_addr,
-			       IONIC_PAGE_SIZE, DMA_FROM_DEVICE);
-
 		err = xdp_do_redirect(netdev, &xdp_buf, xdp_prog);
 		if (unlikely(err)) {
 			netdev_dbg(netdev, "xdp_do_redirect err %d\n", err);
-			goto out_xdp_abort;
+			break;
 		}
-		buf_info->page = NULL;
+
 		rxq->xdp_flush = true;
+		ionic_xdp_rx_put_bufs(rxq, buf_info, nbufs);
 		stats->xdp_redirect++;
 		break;
 
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
+		trace_xdp_exception(netdev, xdp_prog, xdp_action);
+		stats->xdp_aborted++;
+	}
 
 	return true;
 }
@@ -639,6 +593,15 @@ static void ionic_rx_clean(struct ionic_queue *q,
 	stats = q_to_rx_stats(q);
 
 	if (comp->status) {
+		struct ionic_rxq_desc *desc = &q->rxq[q->head_idx];
+
+		/* Most likely status==2 and the pkt received was bigger
+		 * than the buffer available: comp->len will show the
+		 * pkt size received that didn't fit the advertised desc.len
+		 */
+		dev_dbg(q->dev, "q%d drop comp->status %d comp->len %d desc.len %d\n",
+			q->index, comp->status, comp->len, desc->len);
+
 		stats->dropped++;
 		return;
 	}
@@ -658,7 +621,8 @@ static void ionic_rx_clean(struct ionic_queue *q,
 	use_copybreak = len <= q->lif->rx_copybreak;
 	if (use_copybreak)
 		skb = ionic_rx_copybreak(netdev, q, desc_info,
-					 headroom, len, synced);
+					 headroom, len,
+					 comp->num_sg_elems, synced);
 	else
 		skb = ionic_rx_build_skb(q, desc_info, headroom, len,
 					 comp->num_sg_elems, synced);
@@ -798,32 +762,38 @@ void ionic_rx_fill(struct ionic_queue *q)
 
 	for (i = n_fill; i; i--) {
 		unsigned int headroom;
-		unsigned int buf_len;
 
 		nfrags = 0;
 		remain_len = len;
 		desc = &q->rxq[q->head_idx];
 		desc_info = &q->rx_info[q->head_idx];
 		buf_info = &desc_info->bufs[0];
-
-		if (!buf_info->page) { /* alloc a new buffer? */
-			if (unlikely(ionic_rx_page_alloc(q, buf_info))) {
-				desc->addr = 0;
-				desc->len = 0;
-				return;
-			}
-		}
+		ionic_rx_put_buf(q, buf_info);
 
 		/* fill main descriptor - buf[0]
 		 * XDP uses space in the first buffer, so account for
 		 * head room, tail room, and ip header in the first frag size.
 		 */
 		headroom = q->xdp_rxq_info ? XDP_PACKET_HEADROOM : 0;
-		if (q->xdp_rxq_info)
-			buf_len = IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN;
-		else
-			buf_len = ionic_rx_buf_size(buf_info);
-		frag_len = min_t(u16, len, buf_len);
+		if (q->xdp_rxq_info) {
+			/* Always alloc the full size buffer, but only need
+			 * the actual frag_len in the descriptor
+			 */
+			buf_info->len = IONIC_XDP_MAX_LINEAR_MTU + VLAN_ETH_HLEN;
+			frag_len = min_t(u16, len, buf_info->len);
+		} else {
+			/* Start with max buffer size, then use
+			 * the frag size for the actual size to alloc
+			 */
+			frag_len = min_t(u16, len, IONIC_PAGE_SIZE);
+			buf_info->len = frag_len;
+		}
+
+		buf_info->page = page_pool_alloc(q->page_pool,
+						 &buf_info->page_offset,
+						 &buf_info->len, GFP_ATOMIC);
+		if (unlikely(!buf_info->page))
+			return;
 
 		desc->addr = cpu_to_le64(ionic_rx_buf_pa(buf_info) + headroom);
 		desc->len = cpu_to_le16(frag_len);
@@ -833,20 +803,31 @@ void ionic_rx_fill(struct ionic_queue *q)
 
 		/* fill sg descriptors - buf[1..n] */
 		sg_elem = q->rxq_sgl[q->head_idx].elems;
-		for (j = 0; remain_len > 0 && j < q->max_sg_elems; j++, sg_elem++) {
-			if (!buf_info->page) { /* alloc a new sg buffer? */
-				if (unlikely(ionic_rx_page_alloc(q, buf_info))) {
-					sg_elem->addr = 0;
-					sg_elem->len = 0;
+		for (j = 0; remain_len > 0 && j < q->max_sg_elems; j++) {
+			frag_len = min_t(u16, remain_len, IONIC_PAGE_SIZE);
+
+			/* Recycle any "wrong" sized buffers */
+			if (unlikely(buf_info->page && buf_info->len != frag_len))
+				ionic_rx_put_buf(q, buf_info);
+
+			/* Get new buffer if needed */
+			if (!buf_info->page) {
+				buf_info->len = frag_len;
+				buf_info->page = page_pool_alloc(q->page_pool,
+								 &buf_info->page_offset,
+								 &buf_info->len, GFP_ATOMIC);
+				if (unlikely(!buf_info->page)) {
+					buf_info->len = 0;
 					return;
 				}
 			}
 
 			sg_elem->addr = cpu_to_le64(ionic_rx_buf_pa(buf_info));
-			frag_len = min_t(u16, remain_len, ionic_rx_buf_size(buf_info));
 			sg_elem->len = cpu_to_le16(frag_len);
+
 			remain_len -= frag_len;
 			buf_info++;
+			sg_elem++;
 			nfrags++;
 		}
 
@@ -873,17 +854,12 @@ void ionic_rx_fill(struct ionic_queue *q)
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
 
-- 
2.17.1



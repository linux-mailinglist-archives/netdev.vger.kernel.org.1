Return-Path: <netdev+bounces-126119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D57C696FE78
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 01:27:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E0FA289AB5
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 23:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30AFB15E5D4;
	Fri,  6 Sep 2024 23:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y7r9UbVh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2041.outbound.protection.outlook.com [40.107.244.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12ED15B14D
	for <netdev@vger.kernel.org>; Fri,  6 Sep 2024 23:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725665207; cv=fail; b=L7ooR7LioHE0mr9miR9EHPr3XuJCst7kIfYWTHTsTEddTdQ9e4ASn3fo7uvdAgFRqTudiIfG8aYFt4WA1pbXqW6cmfkKsnPbFFedF7/x4QjE5j6fPFWxL9PnS8nC7p/Ptdy4x8il2pilw/SgyzN6Ck8U1n2GDO4iRp9RGp2SaCc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725665207; c=relaxed/simple;
	bh=7xTmUvW54Dbm1rUtf2gJeYWUiL/L/oiBBGBmCuYhRXI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lk3BuDrYPXtCiMRppgoyj28H+xpFieQJW92LALTD23riZ6ypy40VS536ZhNSivL+C/5j2jQD6OAc0KJdlFGsMqtEfeXOnj1NmS/LrMcaQLMvgsQ5JmJlzKHuugFaOSgRzLTeQp1b8qzYG0XENKJCGbNDIlPWBNIHN+5oC01eEqE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y7r9UbVh; arc=fail smtp.client-ip=40.107.244.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/r8XWrchRUGT/xo1TUXz5n2o2EXG57mK8kbr2pXyKxg6QNTNKbv8jU2+i1skIRDGrmzbedGDBXFVbIqSQ208r0DFMfzBnIm9zJAaZKtpTg4h3owONmFvEf8Gi+7/ncYN2TojPcnKmUz6PHRl2Oo7vuSqhvcCqyv3ejW8wEax3ClA4bgra6IV+Ty7Vku4yD8aWDbbZLhGi33yWt/ffG14SJUKeqv9SFZL1hKhpPhSFA/w1MIX8KrYmF+9Co2G93OrhDdcZl6/ZyxSUcqUEinaPFutqG/pgLMYuOoYKKPq2K1QEC8PNO2HGM+ZDPI9ffPpQ23nSsGFKT8GcE2zU8SYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F7lHOh7aZPiZhYWO9BZ+ywBAF2oHj0aIPOrO/T1X9Oc=;
 b=kqY86jDdO5qxprfSJ+KzR+UYNIxCeW2E9UhKEE8WuabNEX9C1LSo0qiAAOemjHTByyhcBiEg8XQ8S4ERVJu251cFrect80BTGRZAdV1InD7lwtUQJ71WXyeVfqdsyWgwjTZgUuJksaRUrsdBsOTdycEL67nvdYTpK5N7X4VZsr4uSGfLwWj5uVRD6sjhM36yExsxvHj1j+c8mxmMFOVO5GbzhcMNypS+0E5/n2/EVh+PuQ6iepryv1Ci6mYolA+ElmiHFhQcMSlw72BhvdxXlej4F4h2MM07YtaBkq1Mzm/zeldssZq1GvJ+ywiN7BM7a/9uBHPG/x07KYZpitXLnA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F7lHOh7aZPiZhYWO9BZ+ywBAF2oHj0aIPOrO/T1X9Oc=;
 b=Y7r9UbVhVKkMgkpUHQrypIRbzq36OuYDgQ8LxIXkouLDUwh+7VLsvWKtgffNotCj6t54umHnfzjWwbo3lGm32TZVeOn7qNpvyu1ls92fp7Or/7Nq9s34tlhrRcKWfFP7yIBu941RjObw5q57NB7OFJb91MjvmOE45XwZCBE5dhk=
Received: from PH7PR17CA0050.namprd17.prod.outlook.com (2603:10b6:510:325::22)
 by PH7PR12MB6417.namprd12.prod.outlook.com (2603:10b6:510:1ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.25; Fri, 6 Sep
 2024 23:26:40 +0000
Received: from SN1PEPF000397B4.namprd05.prod.outlook.com
 (2603:10b6:510:325:cafe::67) by PH7PR17CA0050.outlook.office365.com
 (2603:10b6:510:325::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Fri, 6 Sep 2024 23:26:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SN1PEPF000397B4.mail.protection.outlook.com (10.167.248.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Fri, 6 Sep 2024 23:26:39 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Sep
 2024 18:26:37 -0500
From: Brett Creeley <brett.creeley@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <shannon.nelson@amd.com>, <brett.creeley@amd.com>
Subject: [PATCH v3 net-next 6/7] ionic: convert Rx queue buffers to use page_pool
Date: Fri, 6 Sep 2024 16:26:22 -0700
Message-ID: <20240906232623.39651-7-brett.creeley@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B4:EE_|PH7PR12MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1e8c4b-7019-4570-d41b-08dccecb5c0f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?62PlrQjKtjcG3TfB9MvLwynm5JDV2ylvkDfgHBqLe3yofg1j2Nli+jafbfV2?=
 =?us-ascii?Q?5tasKcLWvSimRMTGkDBmZFbo84CbhKlEUZ59SyplkIflcwVA24s94XMk2Oh6?=
 =?us-ascii?Q?D4PM/l3t1/sX4Sd10AZbbwm7u6A9W6ZA0O2dTbfqD9DwS7Zs9/rMJ3BG9oZY?=
 =?us-ascii?Q?Fs4JJ/8foUuhXTr+6FcasjNc/dZ+6IrK89rxD3GX+NSWB2XJQPatigL6EZy8?=
 =?us-ascii?Q?G+6ERH8RQKZGFFAPR8d+Jvcn45p7O3MmC/wXs8xS4LQOn9JH6ZfJTCconuZ4?=
 =?us-ascii?Q?pr13+AbMhnu0YS0GT2lNKbu3e1UBQX9whgZYOHMKeOtZofa91mLzQyuZPm0O?=
 =?us-ascii?Q?dGz2iqAjvhvymJvkk5/SamAymt0TyVuupaStbglbqcgm4tXqT9rDgSb4EtCE?=
 =?us-ascii?Q?bd7lxIgIPx8rre+JUB3F1uHKI4pvbwV9yfS5W8VoVU1FurilcLVSccb1tAC4?=
 =?us-ascii?Q?8Sn+ZQGRwOLTv1oAJJHLWYtaJH+AnLcpZmDvydwZ2aMSXcJPXWjaZdwSUuOL?=
 =?us-ascii?Q?+8t19kb322+Ri0r3aEqpvFjSkAk8Yr4t4fNoRYE98P0atxVIx91Imfd0Z6XX?=
 =?us-ascii?Q?IDVgzWTnNjr9gWT6AHO2AiVv3b3jHV4MY5iWSk8DyheCS6g6VqWPLsa1FQZp?=
 =?us-ascii?Q?VAU3BMBB+BD3QSYyHiWWZiLA8kyT4T9OoFSNUflD+XhfyEVxJ0pU0T5P06m4?=
 =?us-ascii?Q?lbHC3y0USgI6II85Ej/ANkVVzu31XOmIlkLun/3EcODMXJrhmQ4hMnI4aDHK?=
 =?us-ascii?Q?Zey6xn9HkjT62p3HCvTEA/1UXqAXEuprqpKMvJV+9AFknOykHnlsAKhACnyt?=
 =?us-ascii?Q?n8taQrdiEC/KkSRksiLu0aWpGrl+Y+8YBuyyn5joBEzLQ/5lmwjpCk5XcfIZ?=
 =?us-ascii?Q?e5BfRl9iwwie+VWZpBOrJAEJC6E0/+wceILiujPo/moeK8+aMHcih0jY8N5i?=
 =?us-ascii?Q?uDBv7FOIHtlnoum7BXwzWB4O2BGgWqlJIaiVP3/2r0JRmpC06hsUCfeqIJSF?=
 =?us-ascii?Q?V64920yBrMsjeWP6U68KONDs+IczM023pZhyQAC1Qon/BhpmcRX0Zw/ryqUl?=
 =?us-ascii?Q?02hNC8XZkdWrL7mIr2wd7CMHhBcC1T0s/BkQDwLXG1dPwK+b/81S64Auu3KC?=
 =?us-ascii?Q?Bw08HMhqU0B9LuExaAHBW55uEEzVzSLW4/xvAGZpiIWHe2AOrIIPTVsY/i+/?=
 =?us-ascii?Q?L6KKET2yY/n+L7Mhigt5OSDFfCrPkzICX6wpuYVHLGpNroOKcGQPo1X05GwN?=
 =?us-ascii?Q?rPJBz9KGoraTQvjONVLW8aFSx0CQVK+n3+UHhy1sFzjlMymLkVHsGgoTbNfC?=
 =?us-ascii?Q?GuOtx87/Z02BgbPg5lQy9CLEjM15eY3hVSjwL2HkveL7Nck8l/yonFZI8I3y?=
 =?us-ascii?Q?lRi5hO0v6qmU7KbI50Mx6wzYALhizT0zxFMBJbxK6RjZoKsLvTTAz9HKiWow?=
 =?us-ascii?Q?8ZrgfHKRJK9dIrEsLyTeOt4wrn0DuBOB?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2024 23:26:39.7210
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1e8c4b-7019-4570-d41b-08dccecb5c0f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6417

From: Shannon Nelson <shannon.nelson@amd.com>

Our home-grown buffer management needs to go away and we need
to be playing nicely with the page_pool infrastructure.  This
converts the Rx traffic queues to use page_pool.

Also, since ionic_rx_buf_size() was removed, redefine
IONIC_PAGE_SIZE to account for IONIC_MAX_BUF_LEN being the
largest allowed buffer to prevent overflowing u16 variables,
which could happen when PAGE_SIZE is defined as >= 64KB.

include/linux/minmax.h:93:37: warning: conversion from 'long unsigned int' to 'u16' {aka 'short unsigned int'} changes value from '65536' to '0' [-Woverflow]

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Signed-off-by: Brett Creeley <brett.creeley@amd.com>
---
 drivers/net/ethernet/pensando/Kconfig         |   1 +
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  16 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  80 +++-
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 344 +++++++++---------
 4 files changed, 233 insertions(+), 208 deletions(-)

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
index 19ae68a86a0b..6f9a9843b87e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -181,10 +181,7 @@ struct ionic_queue;
 struct ionic_qcq;
 
 #define IONIC_MAX_BUF_LEN			((u16)-1)
-#define IONIC_PAGE_SIZE				PAGE_SIZE
-#define IONIC_PAGE_SPLIT_SZ			(PAGE_SIZE / 2)
-#define IONIC_PAGE_GFP_MASK			(GFP_ATOMIC | __GFP_NOWARN |\
-						 __GFP_COMP | __GFP_MEMALLOC)
+#define IONIC_PAGE_SIZE				MIN(PAGE_SIZE, IONIC_MAX_BUF_LEN)
 
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
index 1146ff160039..59d3eea2c0bc 100644
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
@@ -553,7 +557,8 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 			   unsigned int cq_desc_size,
 			   unsigned int sg_desc_size,
 			   unsigned int desc_info_size,
-			   unsigned int pid, struct ionic_qcq **qcq)
+			   unsigned int pid, struct bpf_prog *xdp_prog,
+			   struct ionic_qcq **qcq)
 {
 	struct ionic_dev *idev = &lif->ionic->idev;
 	struct device *dev = lif->ionic->dev;
@@ -579,6 +584,31 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
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
+
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
 
@@ -586,12 +616,12 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
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
@@ -712,6 +742,8 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 		devm_free_irq(dev, new->intr.vector, &new->napi);
 		ionic_intr_free(lif->ionic, new->intr.index);
 	}
+err_out_free_page_pool:
+	page_pool_destroy(new->q.page_pool);
 err_out_free_q_info:
 	vfree(new->q.info);
 err_out_free_qcq:
@@ -734,7 +766,7 @@ static int ionic_qcqs_alloc(struct ionic_lif *lif)
 			      sizeof(struct ionic_admin_comp),
 			      0,
 			      sizeof(struct ionic_admin_desc_info),
-			      lif->kern_pid, &lif->adminqcq);
+			      lif->kern_pid, NULL, &lif->adminqcq);
 	if (err)
 		return err;
 	ionic_debugfs_add_qcq(lif, lif->adminqcq);
@@ -747,7 +779,7 @@ static int ionic_qcqs_alloc(struct ionic_lif *lif)
 				      sizeof(union ionic_notifyq_comp),
 				      0,
 				      sizeof(struct ionic_admin_desc_info),
-				      lif->kern_pid, &lif->notifyqcq);
+				      lif->kern_pid, NULL, &lif->notifyqcq);
 		if (err)
 			goto err_out;
 		ionic_debugfs_add_qcq(lif, lif->notifyqcq);
@@ -965,7 +997,7 @@ int ionic_lif_create_hwstamp_txq(struct ionic_lif *lif)
 	err = ionic_qcq_alloc(lif, IONIC_QTYPE_TXQ, txq_i, "hwstamp_tx", flags,
 			      num_desc, desc_sz, comp_sz, sg_desc_sz,
 			      sizeof(struct ionic_tx_desc_info),
-			      lif->kern_pid, &txq);
+			      lif->kern_pid, NULL, &txq);
 	if (err)
 		goto err_qcq_alloc;
 
@@ -1025,7 +1057,7 @@ int ionic_lif_create_hwstamp_rxq(struct ionic_lif *lif)
 	err = ionic_qcq_alloc(lif, IONIC_QTYPE_RXQ, rxq_i, "hwstamp_rx", flags,
 			      num_desc, desc_sz, comp_sz, sg_desc_sz,
 			      sizeof(struct ionic_rx_desc_info),
-			      lif->kern_pid, &rxq);
+			      lif->kern_pid, NULL, &rxq);
 	if (err)
 		goto err_qcq_alloc;
 
@@ -2051,7 +2083,7 @@ static int ionic_txrx_alloc(struct ionic_lif *lif)
 		err = ionic_qcq_alloc(lif, IONIC_QTYPE_TXQ, i, "tx", flags,
 				      num_desc, desc_sz, comp_sz, sg_desc_sz,
 				      sizeof(struct ionic_tx_desc_info),
-				      lif->kern_pid, &lif->txqcqs[i]);
+				      lif->kern_pid, NULL, &lif->txqcqs[i]);
 		if (err)
 			goto err_out;
 
@@ -2083,7 +2115,8 @@ static int ionic_txrx_alloc(struct ionic_lif *lif)
 		err = ionic_qcq_alloc(lif, IONIC_QTYPE_RXQ, i, "rx", flags,
 				      num_desc, desc_sz, comp_sz, sg_desc_sz,
 				      sizeof(struct ionic_rx_desc_info),
-				      lif->kern_pid, &lif->rxqcqs[i]);
+				      lif->kern_pid, lif->xdp_prog,
+				      &lif->rxqcqs[i]);
 		if (err)
 			goto err_out;
 
@@ -2679,15 +2712,15 @@ static int ionic_register_rxq_info(struct ionic_queue *q, unsigned int napi_id)
 
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
@@ -2853,7 +2886,16 @@ static int ionic_cmb_reconfig(struct ionic_lif *lif,
 
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
@@ -2943,7 +2985,7 @@ int ionic_reconfigure_queues(struct ionic_lif *lif,
 				err = ionic_qcq_alloc(lif, IONIC_QTYPE_TXQ, i, "tx", flags,
 						      4, desc_sz, comp_sz, sg_desc_sz,
 						      sizeof(struct ionic_tx_desc_info),
-						      lif->kern_pid, &lif->txqcqs[i]);
+						      lif->kern_pid, NULL, &lif->txqcqs[i]);
 				if (err)
 					goto err_out;
 			}
@@ -2952,7 +2994,7 @@ int ionic_reconfigure_queues(struct ionic_lif *lif,
 			err = ionic_qcq_alloc(lif, IONIC_QTYPE_TXQ, i, "tx", flags,
 					      num_desc, desc_sz, comp_sz, sg_desc_sz,
 					      sizeof(struct ionic_tx_desc_info),
-					      lif->kern_pid, &tx_qcqs[i]);
+					      lif->kern_pid, NULL, &tx_qcqs[i]);
 			if (err)
 				goto err_out;
 		}
@@ -2974,7 +3016,7 @@ int ionic_reconfigure_queues(struct ionic_lif *lif,
 				err = ionic_qcq_alloc(lif, IONIC_QTYPE_RXQ, i, "rx", flags,
 						      4, desc_sz, comp_sz, sg_desc_sz,
 						      sizeof(struct ionic_rx_desc_info),
-						      lif->kern_pid, &lif->rxqcqs[i]);
+						      lif->kern_pid, NULL, &lif->rxqcqs[i]);
 				if (err)
 					goto err_out;
 			}
@@ -2983,7 +3025,7 @@ int ionic_reconfigure_queues(struct ionic_lif *lif,
 			err = ionic_qcq_alloc(lif, IONIC_QTYPE_RXQ, i, "rx", flags,
 					      num_desc, desc_sz, comp_sz, sg_desc_sz,
 					      sizeof(struct ionic_rx_desc_info),
-					      lif->kern_pid, &rx_qcqs[i]);
+					      lif->kern_pid, qparam->xdp_prog, &rx_qcqs[i]);
 			if (err)
 				goto err_out;
 
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



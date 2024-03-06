Return-Path: <netdev+bounces-78173-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 670CF8743EB
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:31:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53A181C217F2
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136671D52C;
	Wed,  6 Mar 2024 23:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Lui7R3ti"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2063.outbound.protection.outlook.com [40.107.96.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4F911D537
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767826; cv=fail; b=IJ4vSa5q5f98gqn42MRrW6bgWWyxH/7tUynzcUEymJGfNwulzE0qtKiyuaAokZk13iEAZS+0HUso3dK3wd2psG/ETJRuO16OIwL9X/0oF4oDAUhHdig0AOuk2USJxb70++mD+xuor+MZrEzN2spdXTD4KV1+QILevDIJ7M6RqJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767826; c=relaxed/simple;
	bh=luYPPxKdiscW2Emju1GNNbwcplY91WHQBhmehv7RG74=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S2yEIAQ8Zk8KWoeS+MbcrqSHJxalwn951u6bUST/MbUBmTWQOVX1eFjaa/UvDA0jlY1LAN4WMRVV8gxD/bajkSujMhAx/Zjd66+JPKlfqrqvORCFSk4LGCt1NBeb8kJ5Ji2/MvzKuhwx3pDZBss/82pjXFfZ9mYKAoNcmKDZql8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Lui7R3ti; arc=fail smtp.client-ip=40.107.96.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OBsm20ZyLTNll665BBmTeNfQhNZozluFgocBNvagXQVLtmfQ9u4nSFqCyh/oUuRdsM+H5VB4j8Nb/yJy74b0ExEww0EU9E6D1IgteJ4ckR4YcQ1RFXuzCwhv4El0AArIjoE3gsVaoNXlHPxC5dHCJLGA2eemQdTohMw6XOiSRI/hnXjPtPWvpWxKPSNFboQSfDed57x5/S04DW3PWDPMjTFZaq42evj6b7fV/v6XaVCjvnqRf9werJ5xFdeCjGVxLlp6pITc2Ot/YfDSp0IiZZJziNnyeIaZrarRf1DuuHxBvECXrR6YbkP8uyLnXR1dPP/QcDCUvjM6cf7lDHzX2g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYkVo5/nB6Rqy8/0myiWlGAlZXVfmDr19pTODfD4FoA=;
 b=bwGAannBqmkO9gB2KW0TXFUHUptBFT+XIz9zVUvRc3wdFm57CcuT53MENSd8xTswZLnJ4zRUi8NicL2Vzy3tKG+NunMAQLlabP2K0ldqvrVyg1P6Uu3Uibh/AiMte5YCnp/vVv2rlrOsGSeLja9o/p6g9Vr9Fy8P90/j/AZz/SNnZ0f39ltrei2l2fmebxzedzAd06DShlfC+hC/300Ctu1dcsdqR6y4DJt20P4mtxJvFCdRifnRGplDsCR8LqpiU8rkdwRQ1Fawd5wsqewh9jbTZn8rJkGr4ZxEn7OSqMeKfMmhppOuS26KlbpDVFiOl+/RRwGVZIbPwHEXUU34Ig==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYkVo5/nB6Rqy8/0myiWlGAlZXVfmDr19pTODfD4FoA=;
 b=Lui7R3timNUQw5f6+4BANnRJFy52FyWjxMe9WhvUyg3rNV4hMOmkNVxpNb5PClHribjwBKx3EUmNbKjUM5iiAiMPL4Z+tDwBic+XjFiAlSZ67UYO+CqDyyImREl5oleYmN1VInKFgMbBxYLtiJKq6zmQmwZh0j9w9zziKBCsP1U=
Received: from SN7PR04CA0058.namprd04.prod.outlook.com (2603:10b6:806:120::33)
 by IA1PR12MB7735.namprd12.prod.outlook.com (2603:10b6:208:421::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.24; Wed, 6 Mar
 2024 23:30:21 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:120:cafe::6a) by SN7PR04CA0058.outlook.office365.com
 (2603:10b6:806:120::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Wed, 6 Mar 2024 23:30:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:30:20 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 17:30:19 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 05/14] ionic: remove the cq_info to save more memory
Date: Wed, 6 Mar 2024 15:29:50 -0800
Message-ID: <20240306232959.17316-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240306232959.17316-1-shannon.nelson@amd.com>
References: <20240306232959.17316-1-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|IA1PR12MB7735:EE_
X-MS-Office365-Filtering-Correlation-Id: 93bc72d4-6886-4fca-1707-08dc3e3563bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	W3Xax4zjcerCvAv9/NM/HKSC7/tqe6uAfZd3uPRGt9laDuGaDpmXuiS6IciEb/sUlFshIpJhRWIgoyhHcgQH7+29L18JMoUWaSEGvBtTOJIh0elIwcFeui8Rb3jwFmVAQXS7Sjjd5s9qlY57jXjEMMexO9yxkqcvpN10kVfTxHlklZQt5By8za134lGN2wOch1McltgZrGNTbvPMlCzHmMwhkeoyzzvWca/LD9RyXqrKGvu5IMqwW4Y/R8XpdHmlOvmSIq5/ddlf2vtJnBHxcG9bsP6m64qSAe+M7he8v2+AFM+HYtcg4kUAQChXP0pSVS9QRb7Vs9t+zu+EQUvCjQEt+hgm1eefUuhMvbm7SsK5aVoXe+Hyhm5qsl0uGgHDeSNKaDf/dFvbm1Fp1dpnMz4Ns5AGkoPZkLwAePbMU1VIKAoUoxx0RttC7axKyXFobffasuhyN8pDHAkzz5BmwId73SveWFwSdQdPKMYk5At5wMse4MYCbBuGrNMG8AFB8n6kIXg+lCPpGPhsDpE6K+S8szBw+cAynhSRIw2I+55tU0+jcu38YwcoUIoWrfx0zZkvYG1yZtw6BVf3qSDpLaG13gBm6bbILSvejzsFiX+cFN8b4y2xhjhwZWwoNr+wk7NjV8gprY8rAsL33cFDYkgPPNL65nrX3pBMsRJloXxu+MmzM5KVPtm8O4dfrsksawA7jXwrwmk3hxszZ/mYqvhM5gGfAkopJvNzJRNoCw4o+wnyjPUWc0m7js0E5T4J
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:30:20.6668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 93bc72d4-6886-4fca-1707-08dc3e3563bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7735

With a little simple math we don't need another struct array to
find the completion structs, so we can remove the ionic_cq_info
altogether.  This doesn't really save anything in the ionic_cq
since it gets padded out to the cacheline, but it does remove
the parallel array allocation of 8 * num_descriptors, or about
8 Kbytes per queue in a default configuration.

Suggested-by: Neel Patel <npatel2@amd.com>
Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic.h   |  4 +-
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 23 +-----------
 .../net/ethernet/pensando/ionic/ionic_dev.h   | 11 +-----
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 37 ++++++-------------
 .../net/ethernet/pensando/ionic/ionic_main.c  | 18 ++++-----
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 32 +++++++---------
 .../net/ethernet/pensando/ionic/ionic_txrx.h  |  2 +-
 7 files changed, 38 insertions(+), 89 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
index 946c8ae1548f..2ccc2c2a06e3 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic.h
@@ -76,8 +76,8 @@ int ionic_adminq_post_wait(struct ionic_lif *lif, struct ionic_admin_ctx *ctx);
 int ionic_adminq_post_wait_nomsg(struct ionic_lif *lif, struct ionic_admin_ctx *ctx);
 void ionic_adminq_netdev_err_print(struct ionic_lif *lif, u8 opcode,
 				   u8 status, int err);
-bool ionic_notifyq_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info);
-bool ionic_adminq_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info);
+bool ionic_notifyq_service(struct ionic_cq *cq);
+bool ionic_adminq_service(struct ionic_cq *cq);
 
 int ionic_dev_cmd_wait(struct ionic *ionic, unsigned long max_wait);
 int ionic_dev_cmd_wait_nomsg(struct ionic *ionic, unsigned long max_wait);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index 94bd0db34473..594e65a52010 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -633,39 +633,20 @@ int ionic_cq_init(struct ionic_lif *lif, struct ionic_cq *cq,
 	return 0;
 }
 
-void ionic_cq_map(struct ionic_cq *cq, void *base, dma_addr_t base_pa)
-{
-	struct ionic_cq_info *cur;
-	unsigned int i;
-
-	cq->base = base;
-	cq->base_pa = base_pa;
-
-	for (i = 0, cur = cq->info; i < cq->num_descs; i++, cur++)
-		cur->cq_desc = base + (i * cq->desc_size);
-}
-
-void ionic_cq_bind(struct ionic_cq *cq, struct ionic_queue *q)
-{
-	cq->bound_q = q;
-}
-
 unsigned int ionic_cq_service(struct ionic_cq *cq, unsigned int work_to_do,
 			      ionic_cq_cb cb, ionic_cq_done_cb done_cb,
 			      void *done_arg)
 {
-	struct ionic_cq_info *cq_info;
 	unsigned int work_done = 0;
 
 	if (work_to_do == 0)
 		return 0;
 
-	cq_info = &cq->info[cq->tail_idx];
-	while (cb(cq, cq_info)) {
+	while (cb(cq)) {
 		if (cq->tail_idx == cq->num_descs - 1)
 			cq->done_color = !cq->done_color;
+
 		cq->tail_idx = (cq->tail_idx + 1) & (cq->num_descs - 1);
-		cq_info = &cq->info[cq->tail_idx];
 
 		if (++work_done >= work_to_do)
 			break;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index 2096aae1ef71..3ed4eaea9315 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -177,14 +177,6 @@ struct ionic_dev {
 	struct ionic_devinfo dev_info;
 };
 
-struct ionic_cq_info {
-	union {
-		void *cq_desc;
-		struct ionic_admin_comp *admincq;
-		struct ionic_notifyq_event *notifyq;
-	};
-};
-
 struct ionic_queue;
 struct ionic_qcq;
 struct ionic_desc_info;
@@ -282,7 +274,6 @@ struct ionic_intr_info {
 
 struct ionic_cq {
 	struct ionic_lif *lif;
-	struct ionic_cq_info *info;
 	struct ionic_queue *bound_q;
 	struct ionic_intr_info *bound_intr;
 	u16 tail_idx;
@@ -365,7 +356,7 @@ int ionic_cq_init(struct ionic_lif *lif, struct ionic_cq *cq,
 		  unsigned int num_descs, size_t desc_size);
 void ionic_cq_map(struct ionic_cq *cq, void *base, dma_addr_t base_pa);
 void ionic_cq_bind(struct ionic_cq *cq, struct ionic_queue *q);
-typedef bool (*ionic_cq_cb)(struct ionic_cq *cq, struct ionic_cq_info *cq_info);
+typedef bool (*ionic_cq_cb)(struct ionic_cq *cq);
 typedef void (*ionic_cq_done_cb)(void *done_arg);
 unsigned int ionic_cq_service(struct ionic_cq *cq, unsigned int work_to_do,
 			      ionic_cq_cb cb, ionic_cq_done_cb done_cb,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 4cc879955d21..afac48427af8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -433,8 +433,6 @@ static void ionic_qcq_free(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	ionic_xdp_unregister_rxq_info(&qcq->q);
 	ionic_qcq_intr_free(lif, qcq);
 
-	vfree(qcq->cq.info);
-	qcq->cq.info = NULL;
 	vfree(qcq->q.info);
 	qcq->q.info = NULL;
 }
@@ -542,9 +540,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 {
 	struct ionic_dev *idev = &lif->ionic->idev;
 	struct device *dev = lif->ionic->dev;
-	dma_addr_t cq_base_pa = 0;
 	struct ionic_qcq *new;
-	void *cq_base;
 	int err;
 
 	*qcq = NULL;
@@ -578,19 +574,12 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 
 	err = ionic_alloc_qcq_interrupt(lif, new);
 	if (err)
-		goto err_out;
-
-	new->cq.info = vcalloc(num_descs, sizeof(*new->cq.info));
-	if (!new->cq.info) {
-		netdev_err(lif->netdev, "Cannot allocate completion queue info\n");
-		err = -ENOMEM;
-		goto err_out_free_irq;
-	}
+		goto err_out_free_q_info;
 
 	err = ionic_cq_init(lif, &new->cq, &new->intr, num_descs, cq_desc_size);
 	if (err) {
 		netdev_err(lif->netdev, "Cannot initialize completion queue\n");
-		goto err_out_free_cq_info;
+		goto err_out_free_irq;
 	}
 
 	if (flags & IONIC_QCQ_F_NOTIFYQ) {
@@ -608,15 +597,15 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 		if (!new->q_base) {
 			netdev_err(lif->netdev, "Cannot allocate qcq DMA memory\n");
 			err = -ENOMEM;
-			goto err_out_free_cq_info;
+			goto err_out_free_irq;
 		}
 		new->q.base = PTR_ALIGN(new->q_base, PAGE_SIZE);
 		new->q.base_pa = ALIGN(new->q_base_pa, PAGE_SIZE);
 
-		cq_base = PTR_ALIGN(new->q_base + q_size, PAGE_SIZE);
-		cq_base_pa = ALIGN(new->q_base_pa + q_size, PAGE_SIZE);
-		ionic_cq_map(&new->cq, cq_base, cq_base_pa);
-		ionic_cq_bind(&new->cq, &new->q);
+		/* Base the NotifyQ cq.base off of the ALIGNed q.base */
+		new->cq.base = PTR_ALIGN(new->q.base + q_size, PAGE_SIZE);
+		new->cq.base_pa = ALIGN(new->q_base_pa + q_size, PAGE_SIZE);
+		new->cq.bound_q = &new->q;
 	} else {
 		/* regular DMA q descriptors */
 		new->q_size = PAGE_SIZE + (num_descs * desc_size);
@@ -625,7 +614,7 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 		if (!new->q_base) {
 			netdev_err(lif->netdev, "Cannot allocate queue DMA memory\n");
 			err = -ENOMEM;
-			goto err_out_free_cq_info;
+			goto err_out_free_irq;
 		}
 		new->q.base = PTR_ALIGN(new->q_base, PAGE_SIZE);
 		new->q.base_pa = ALIGN(new->q_base_pa, PAGE_SIZE);
@@ -666,10 +655,9 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 			err = -ENOMEM;
 			goto err_out_free_q;
 		}
-		cq_base = PTR_ALIGN(new->cq_base, PAGE_SIZE);
-		cq_base_pa = ALIGN(new->cq_base_pa, PAGE_SIZE);
-		ionic_cq_map(&new->cq, cq_base, cq_base_pa);
-		ionic_cq_bind(&new->cq, &new->q);
+		new->cq.base = PTR_ALIGN(new->cq_base, PAGE_SIZE);
+		new->cq.base_pa = ALIGN(new->cq_base_pa, PAGE_SIZE);
+		new->cq.bound_q = &new->q;
 	}
 
 	if (flags & IONIC_QCQ_F_SG) {
@@ -700,8 +688,6 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 		ionic_put_cmb(lif, new->cmb_pgid, new->cmb_order);
 	}
 	dma_free_coherent(dev, new->q_size, new->q_base, new->q_base_pa);
-err_out_free_cq_info:
-	vfree(new->cq.info);
 err_out_free_irq:
 	if (flags & IONIC_QCQ_F_INTR) {
 		devm_free_irq(dev, new->intr.vector, &new->napi);
@@ -2889,7 +2875,6 @@ static void ionic_swap_queues(struct ionic_qcq *a, struct ionic_qcq *b)
 	swap(a->cq.desc_size, b->cq.desc_size);
 	swap(a->cq.base,      b->cq.base);
 	swap(a->cq.base_pa,   b->cq.base_pa);
-	swap(a->cq.info,      b->cq.info);
 	swap(a->cq_base,      b->cq_base);
 	swap(a->cq_base_pa,   b->cq_base_pa);
 	swap(a->cq_size,      b->cq_size);
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_main.c b/drivers/net/ethernet/pensando/ionic/ionic_main.c
index 023c2c37056e..2c092858bc0d 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_main.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_main.c
@@ -249,16 +249,13 @@ static int ionic_adminq_check_err(struct ionic_lif *lif,
 
 static void ionic_adminq_clean(struct ionic_queue *q,
 			       struct ionic_desc_info *desc_info,
-			       struct ionic_cq_info *cq_info)
+			       struct ionic_admin_comp *comp)
 {
 	struct ionic_admin_ctx *ctx = desc_info->arg;
-	struct ionic_admin_comp *comp;
 
 	if (!ctx)
 		return;
 
-	comp = cq_info->cq_desc;
-
 	memcpy(&ctx->comp, comp, sizeof(*comp));
 
 	dev_dbg(q->dev, "comp admin queue command:\n");
@@ -268,16 +265,17 @@ static void ionic_adminq_clean(struct ionic_queue *q,
 	complete_all(&ctx->work);
 }
 
-bool ionic_notifyq_service(struct ionic_cq *cq,
-			   struct ionic_cq_info *cq_info)
+bool ionic_notifyq_service(struct ionic_cq *cq)
 {
-	union ionic_notifyq_comp *comp = cq_info->cq_desc;
 	struct ionic_deferred_work *work;
+	union ionic_notifyq_comp *comp;
 	struct net_device *netdev;
 	struct ionic_queue *q;
 	struct ionic_lif *lif;
 	u64 eid;
 
+	comp = &((union ionic_notifyq_comp *)cq->base)[cq->tail_idx];
+
 	q = cq->bound_q;
 	lif = q->info[0].arg;
 	netdev = lif->netdev;
@@ -320,14 +318,14 @@ bool ionic_notifyq_service(struct ionic_cq *cq,
 	return true;
 }
 
-bool ionic_adminq_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info)
+bool ionic_adminq_service(struct ionic_cq *cq)
 {
 	struct ionic_queue *q = cq->bound_q;
 	struct ionic_desc_info *desc_info;
 	struct ionic_admin_comp *comp;
 	u16 index;
 
-	comp = cq_info->cq_desc;
+	comp = &((struct ionic_admin_comp *)cq->base)[cq->tail_idx];
 
 	if (!color_match(comp->color, cq->done_color))
 		return false;
@@ -341,7 +339,7 @@ bool ionic_adminq_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info)
 		index = q->tail_idx;
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
 		if (likely(desc_info->arg))
-			ionic_adminq_clean(q, desc_info, cq_info);
+			ionic_adminq_clean(q, desc_info, comp);
 		desc_info->arg = NULL;
 	} while (index != le16_to_cpu(comp->comp_index));
 
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index fcd6a2fe31d2..e7ebd2df1e23 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -23,7 +23,7 @@ static void ionic_tx_desc_unmap_bufs(struct ionic_queue *q,
 
 static void ionic_tx_clean(struct ionic_queue *q,
 			   struct ionic_desc_info *desc_info,
-			   struct ionic_cq_info *cq_info);
+			   struct ionic_txq_comp *comp);
 
 static inline void ionic_txq_post(struct ionic_queue *q, bool ring_dbell,
 				  void *arg)
@@ -635,19 +635,16 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 
 static void ionic_rx_clean(struct ionic_queue *q,
 			   struct ionic_desc_info *desc_info,
-			   struct ionic_cq_info *cq_info)
+			   struct ionic_rxq_comp *comp)
 {
 	struct net_device *netdev = q->lif->netdev;
 	struct ionic_qcq *qcq = q_to_qcq(q);
 	struct ionic_rx_stats *stats;
-	struct ionic_rxq_comp *comp;
 	struct bpf_prog *xdp_prog;
 	unsigned int headroom;
 	struct sk_buff *skb;
 	u16 len;
 
-	comp = cq_info->cq_desc + qcq->cq.desc_size - sizeof(*comp);
-
 	stats = q_to_rx_stats(q);
 
 	if (comp->status) {
@@ -722,7 +719,7 @@ static void ionic_rx_clean(struct ionic_queue *q,
 		u64 hwstamp;
 
 		cq_desc_hwstamp =
-			cq_info->cq_desc +
+			(void *)comp +
 			qcq->cq.desc_size -
 			sizeof(struct ionic_rxq_comp) -
 			IONIC_HWSTAMP_CQ_NEGOFFSET;
@@ -743,13 +740,13 @@ static void ionic_rx_clean(struct ionic_queue *q,
 		napi_gro_frags(&qcq->napi);
 }
 
-bool ionic_rx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info)
+bool ionic_rx_service(struct ionic_cq *cq)
 {
 	struct ionic_queue *q = cq->bound_q;
 	struct ionic_desc_info *desc_info;
 	struct ionic_rxq_comp *comp;
 
-	comp = cq_info->cq_desc + cq->desc_size - sizeof(*comp);
+	comp = &((struct ionic_rxq_comp *)cq->base)[cq->tail_idx];
 
 	if (!color_match(comp->pkt_type_color, cq->done_color))
 		return false;
@@ -765,7 +762,7 @@ bool ionic_rx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info)
 	q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
 
 	/* clean the related q entry, only one per qc completion */
-	ionic_rx_clean(q, desc_info, cq_info);
+	ionic_rx_clean(q, desc_info, comp);
 
 	desc_info->arg = NULL;
 
@@ -1181,7 +1178,7 @@ static void ionic_tx_desc_unmap_bufs(struct ionic_queue *q,
 
 static void ionic_tx_clean(struct ionic_queue *q,
 			   struct ionic_desc_info *desc_info,
-			   struct ionic_cq_info *cq_info)
+			   struct ionic_txq_comp *comp)
 {
 	struct ionic_tx_stats *stats = q_to_tx_stats(q);
 	struct ionic_qcq *qcq = q_to_qcq(q);
@@ -1204,13 +1201,13 @@ static void ionic_tx_clean(struct ionic_queue *q,
 		return;
 
 	if (unlikely(ionic_txq_hwstamp_enabled(q))) {
-		if (cq_info) {
+		if (comp) {
 			struct skb_shared_hwtstamps hwts = {};
 			__le64 *cq_desc_hwstamp;
 			u64 hwstamp;
 
 			cq_desc_hwstamp =
-				cq_info->cq_desc +
+				(void *)comp +
 				qcq->cq.desc_size -
 				sizeof(struct ionic_txq_comp) -
 				IONIC_HWSTAMP_CQ_NEGOFFSET;
@@ -1236,7 +1233,7 @@ static void ionic_tx_clean(struct ionic_queue *q,
 	napi_consume_skb(skb, 1);
 }
 
-static bool ionic_tx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info,
+static bool ionic_tx_service(struct ionic_cq *cq,
 			     unsigned int *total_pkts, unsigned int *total_bytes)
 {
 	struct ionic_queue *q = cq->bound_q;
@@ -1246,7 +1243,7 @@ static bool ionic_tx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info,
 	unsigned int pkts = 0;
 	u16 index;
 
-	comp = cq_info->cq_desc + cq->desc_size - sizeof(*comp);
+	comp = &((struct ionic_txq_comp *)cq->base)[cq->tail_idx];
 
 	if (!color_match(comp->color, cq->done_color))
 		return false;
@@ -1259,7 +1256,7 @@ static bool ionic_tx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info,
 		desc_info->bytes = 0;
 		index = q->tail_idx;
 		q->tail_idx = (q->tail_idx + 1) & (q->num_descs - 1);
-		ionic_tx_clean(q, desc_info, cq_info);
+		ionic_tx_clean(q, desc_info, comp);
 		if (desc_info->arg) {
 			pkts++;
 			bytes += desc_info->bytes;
@@ -1275,7 +1272,6 @@ static bool ionic_tx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info,
 
 unsigned int ionic_tx_cq_service(struct ionic_cq *cq, unsigned int work_to_do)
 {
-	struct ionic_cq_info *cq_info;
 	unsigned int work_done = 0;
 	unsigned int bytes = 0;
 	unsigned int pkts = 0;
@@ -1283,12 +1279,10 @@ unsigned int ionic_tx_cq_service(struct ionic_cq *cq, unsigned int work_to_do)
 	if (work_to_do == 0)
 		return 0;
 
-	cq_info = &cq->info[cq->tail_idx];
-	while (ionic_tx_service(cq, cq_info, &pkts, &bytes)) {
+	while (ionic_tx_service(cq, &pkts, &bytes)) {
 		if (cq->tail_idx == cq->num_descs - 1)
 			cq->done_color = !cq->done_color;
 		cq->tail_idx = (cq->tail_idx + 1) & (cq->num_descs - 1);
-		cq_info = &cq->info[cq->tail_idx];
 
 		if (++work_done >= work_to_do)
 			break;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.h b/drivers/net/ethernet/pensando/ionic/ionic_txrx.h
index 68228bb8c119..9e73e324e7a1 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.h
@@ -14,7 +14,7 @@ int ionic_tx_napi(struct napi_struct *napi, int budget);
 int ionic_txrx_napi(struct napi_struct *napi, int budget);
 netdev_tx_t ionic_start_xmit(struct sk_buff *skb, struct net_device *netdev);
 
-bool ionic_rx_service(struct ionic_cq *cq, struct ionic_cq_info *cq_info);
+bool ionic_rx_service(struct ionic_cq *cq);
 
 int ionic_xdp_xmit(struct net_device *netdev, int n, struct xdp_frame **xdp, u32 flags);
 #endif /* _IONIC_TXRX_H_ */
-- 
2.17.1



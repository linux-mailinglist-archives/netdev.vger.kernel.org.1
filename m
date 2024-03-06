Return-Path: <netdev+bounces-78169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10FCE8743E7
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:30:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F552B23A57
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B4BB1CD2D;
	Wed,  6 Mar 2024 23:30:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="RpNWj85p"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A71321CAA7
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709767821; cv=fail; b=J3k6WLLBA6b5jNRNnXDIutqS5ePi4tGBil8NYgtToLQVBhNDqxuJoHeCj+l0SsePBIDu/95Vqu6/2NbYeqMwhQmZHM0c2ObZUfXUJBsC9jGv5UEjEGYanV0blGN8Fc5n7tW91J4EZUbIgSP5+7hhATJ9H07Wb+C59Pq/PmcL0rA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709767821; c=relaxed/simple;
	bh=e8suX+BgmECEmV20MtFVW95UTBIxkKg9hwul3f89jdI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l8vvnN0kc853QnUy9WhYK/gh0j5H3xqHrlWP1L6ZSXBQ4EYNOHInh3tlryhP9oxdCj6UzVch1Az1nFFLBAOMx94uQ3QChC99/pFyA+sUEjHfLEMwvmV63srup26cQf1MeHWxTsc4wM/q6g5Ty/NYi+Vzz/ibsHZWbvLmCXOipYw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=RpNWj85p; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WccIeO9oFCDHeND/EEUF+4AG/tKZUCLGQFnInDXrus+UDy4l0A5ij20UtKVxSh6kw3gaz/KQRuaQRrIl9co40+iJqOaMKcR1lT+Sno4mjgGYI97sypwuXKSD1CCsrgueBR6bYotqbYKYVqmdeutpavw2NqvgEZZviaC2e5NHcQs/yn+qPPk7rO/dcGbzA/jf/5vs2njBTLu0Qqbm3jc4rAPdG2S8jKZxP5xfGAnH1CViQ0k+PnPdX+H9rP0RLkDgouG784KdvW65Q0uniH9dBXM8nW+jGDnA8bdLiOLNkD+cheMpk9s3QDeTAKGQmaVNXk7yHS8uUzsaUC0pBwK/NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/2RwTA8CZB6X4tNs4yVrXpzxAIXdU9OGAKGVGVxrkzw=;
 b=e4QnTgQfiM2dGrBLYaoSFLGA0DBni3MoN7NSnfZPj0N8KMPXdSSNlgp0mSgZBRMUlidS+p8gqFYScDqplv7hf+XWvck76CvPDDUPXzt9roaBk7pkuWvwJy3eNQzl/otmUb+yue4tVNWeMf7Zas134WgzWmujPI4Zrh9aYO6Yg/tf1L/iLrcu5d0y8EgjUsPhjZFnBZ3FsHlQTI/cmk7gpMU/1a8RqAKhbCHJ0oVbC4VJDMp/iHvVA70dz7cr2jL2l2YPLEEtwyT0AgXsW04/g4r0dF2yJc30QlJtNocypVQ23+9xnxBxXXEjki7E11k3CKe1BgqEuWYYhUlZogQvAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/2RwTA8CZB6X4tNs4yVrXpzxAIXdU9OGAKGVGVxrkzw=;
 b=RpNWj85pDIBioS7zMA0ghcxT2DLkPdYr0yTNTFWEKjFo9oHAcz8Q/L0pElgu0NWkiTniecs29iQuxMQmB6D4lYGvbgpcGKUC8AtDCisXHu6AYtH91vvgGg+BK6kz2fXGXjRrZmp9LxhZk8JEpL5wWPE3qWJu36s4ELuYBUnCgKY=
Received: from SN7PR04CA0056.namprd04.prod.outlook.com (2603:10b6:806:120::31)
 by PH0PR12MB8176.namprd12.prod.outlook.com (2603:10b6:510:290::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Wed, 6 Mar
 2024 23:30:17 +0000
Received: from SA2PEPF000015C7.namprd03.prod.outlook.com
 (2603:10b6:806:120:cafe::b6) by SN7PR04CA0056.outlook.office365.com
 (2603:10b6:806:120::31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Wed, 6 Mar 2024 23:30:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF000015C7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 23:30:17 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 6 Mar
 2024 17:30:15 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH net-next 02/14] ionic: drop q mapping
Date: Wed, 6 Mar 2024 15:29:47 -0800
Message-ID: <20240306232959.17316-3-shannon.nelson@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C7:EE_|PH0PR12MB8176:EE_
X-MS-Office365-Filtering-Correlation-Id: fd695b96-ef18-4ba1-2f1d-08dc3e35618f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1SRyq4wRL+CXpbiikFqq2WLWH65UuJJf4oxdw/Uda7qGlEQjmPdBjAl17XkrR7kNUXroYBU1TW9ObKRWGG56u844+Q8F1/cagxHQ3MVavHQwpgUPF+K+9EakKElFZoAJ5+L8WXO35CMJlFQLGNgG18d9eSiGoviaQp+UB5Ee2JjKaPhkq7ZsJJLovrpbBL5G7AkvgYjMSd3hg7PDh+voOMJ0urEAJqjt1KXHsnR2F7h9uB+ykCMFGwZBEJyZBj6Y2W6I7hVuVO1a7z0g7wl0TidwAB89o+csDhpJPngMNDO2fXLVeaDY4wn52aBoEvl37xrLbEh/GtdexTZimGn4kTY8MoNUBc80Uyt67XMGAbty3VYMbt4GBSUraEz4QktaPK2fS21vSysoWvxGXsoDrwNIVvGwtwrLwPdHzde3NqenuNXKKPgj7VpZ9NxmLrdmLceCzZbjZMdEF8mZfZJMPfx9a6WLrIabDH5N+XMHtHh5LyWQYynqsOTNnmHHltnWOcYWVg9eeNjUStwdn28FZgIUBklI3qwRUVcapRf9vQ5fh2Ok+AAORyxIEWq2Lamajk/z+/fh+ds0OYCDWB2Lt9pW7dlqE++5JhZtGIaugjuAROTL8BxJoMq/uzYfZJKH/WOo+eZKa/oB1FDaXRVus7tr9qkzLjCeTFo8x4JByWhY37acjYl576681WSZJ2TB/NCXJc04EFHjtpdxpI+yYdYB45at5X/iCpR+S7TVFZcMzeePtD24zilcFo6dGxtm
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:30:17.0261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fd695b96-ef18-4ba1-2f1d-08dc3e35618f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C7.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8176

Now that we're not using desc_info pointers mapped in every q
we can simplify and drop the unnecessary utility functions.

Reviewed-by: Brett Creeley <brett.creeley@amd.com>
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 .../net/ethernet/pensando/ionic/ionic_dev.c   | 18 --------------
 .../net/ethernet/pensando/ionic/ionic_dev.h   |  3 ---
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 24 ++++++++-----------
 3 files changed, 10 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.c b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
index fc83f80fba00..b4889f8c14d8 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.c
@@ -706,24 +706,6 @@ int ionic_q_init(struct ionic_lif *lif, struct ionic_dev *idev,
 	return 0;
 }
 
-void ionic_q_map(struct ionic_queue *q, void *base, dma_addr_t base_pa)
-{
-	q->base = base;
-	q->base_pa = base_pa;
-}
-
-void ionic_q_cmb_map(struct ionic_queue *q, void __iomem *base, dma_addr_t base_pa)
-{
-	q->cmb_base = base;
-	q->cmb_base_pa = base_pa;
-}
-
-void ionic_q_sg_map(struct ionic_queue *q, void *base, dma_addr_t base_pa)
-{
-	q->sg_base = base;
-	q->sg_base_pa = base_pa;
-}
-
 void ionic_q_post(struct ionic_queue *q, bool ring_doorbell, ionic_desc_cb cb,
 		  void *cb_arg)
 {
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_dev.h b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
index d38c909478ea..c70576be3714 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_dev.h
+++ b/drivers/net/ethernet/pensando/ionic/ionic_dev.h
@@ -381,9 +381,6 @@ int ionic_q_init(struct ionic_lif *lif, struct ionic_dev *idev,
 		 struct ionic_queue *q, unsigned int index, const char *name,
 		 unsigned int num_descs, size_t desc_size,
 		 size_t sg_desc_size, unsigned int pid);
-void ionic_q_map(struct ionic_queue *q, void *base, dma_addr_t base_pa);
-void ionic_q_cmb_map(struct ionic_queue *q, void __iomem *base, dma_addr_t base_pa);
-void ionic_q_sg_map(struct ionic_queue *q, void *base, dma_addr_t base_pa);
 void ionic_q_post(struct ionic_queue *q, bool ring_doorbell, ionic_desc_cb cb,
 		  void *cb_arg);
 void ionic_q_service(struct ionic_queue *q, struct ionic_cq_info *cq_info,
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 33b1691a4ee5..eb9ba683d635 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -542,11 +542,9 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 {
 	struct ionic_dev *idev = &lif->ionic->idev;
 	struct device *dev = lif->ionic->dev;
-	void *q_base, *cq_base, *sg_base;
 	dma_addr_t cq_base_pa = 0;
-	dma_addr_t sg_base_pa = 0;
-	dma_addr_t q_base_pa = 0;
 	struct ionic_qcq *new;
+	void *cq_base;
 	int err;
 
 	*qcq = NULL;
@@ -612,11 +610,10 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 			err = -ENOMEM;
 			goto err_out_free_cq_info;
 		}
-		q_base = PTR_ALIGN(new->q_base, PAGE_SIZE);
-		q_base_pa = ALIGN(new->q_base_pa, PAGE_SIZE);
-		ionic_q_map(&new->q, q_base, q_base_pa);
+		new->q.base = PTR_ALIGN(new->q_base, PAGE_SIZE);
+		new->q.base_pa = ALIGN(new->q_base_pa, PAGE_SIZE);
 
-		cq_base = PTR_ALIGN(q_base + q_size, PAGE_SIZE);
+		cq_base = PTR_ALIGN(new->q_base + q_size, PAGE_SIZE);
 		cq_base_pa = ALIGN(new->q_base_pa + q_size, PAGE_SIZE);
 		ionic_cq_map(&new->cq, cq_base, cq_base_pa);
 		ionic_cq_bind(&new->cq, &new->q);
@@ -630,9 +627,8 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 			err = -ENOMEM;
 			goto err_out_free_cq_info;
 		}
-		q_base = PTR_ALIGN(new->q_base, PAGE_SIZE);
-		q_base_pa = ALIGN(new->q_base_pa, PAGE_SIZE);
-		ionic_q_map(&new->q, q_base, q_base_pa);
+		new->q.base = PTR_ALIGN(new->q_base, PAGE_SIZE);
+		new->q.base_pa = ALIGN(new->q_base_pa, PAGE_SIZE);
 
 		if (flags & IONIC_QCQ_F_CMB_RINGS) {
 			/* on-chip CMB q descriptors */
@@ -657,7 +653,8 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 			}
 
 			new->cmb_q_base_pa -= idev->phy_cmb_pages;
-			ionic_q_cmb_map(&new->q, new->cmb_q_base, new->cmb_q_base_pa);
+			new->q.cmb_base = new->cmb_q_base;
+			new->q.cmb_base_pa = new->cmb_q_base_pa;
 		}
 
 		/* cq DMA descriptors */
@@ -684,9 +681,8 @@ static int ionic_qcq_alloc(struct ionic_lif *lif, unsigned int type,
 			err = -ENOMEM;
 			goto err_out_free_cq;
 		}
-		sg_base = PTR_ALIGN(new->sg_base, PAGE_SIZE);
-		sg_base_pa = ALIGN(new->sg_base_pa, PAGE_SIZE);
-		ionic_q_sg_map(&new->q, sg_base, sg_base_pa);
+		new->q.sg_base = PTR_ALIGN(new->sg_base, PAGE_SIZE);
+		new->q.sg_base_pa = ALIGN(new->sg_base_pa, PAGE_SIZE);
 	}
 
 	INIT_WORK(&new->dim.work, ionic_dim_work);
-- 
2.17.1



Return-Path: <netdev+bounces-43863-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FD357D506D
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 14:56:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59716B20FBC
	for <lists+netdev@lfdr.de>; Tue, 24 Oct 2023 12:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F1DC273D4;
	Tue, 24 Oct 2023 12:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ekSiRwKW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5F4B1804A
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 12:56:19 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2060.outbound.protection.outlook.com [40.107.243.60])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D2D2DD
	for <netdev@vger.kernel.org>; Tue, 24 Oct 2023 05:56:17 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nKZMODpsvgHuBofXSVefeZYT13OR3Usx5dWGZJlu5OIxJ+Ag6rAjpeRbWsE/EorYD13+egxd4s9eph2TbS7adS68/f2GfDV/TlN1usOFVFukkyqrgDvhAtur6vu3Pm/jagYATAZjt9/Yl7TWW4NzJiy5tcyJsY5KdNHotMYV1rw1wGLpc4ks8ZBuT7onj9q0qB3nPb4K9zDYGOa/l0ApBvCoN+C0TQZ80I3Gl9BuecgtW6ib/jFQEvUXn75ZrKNJWPGRsIVP2WWxzRkjoXagNNDkfcEdbL/PJ4o5aDZgpjCibbQzVrjvyKaNgO/sQSZc/DfvXSnu9KSbVgNEjB87nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LxyIWau7Gr315ex751iHEXiqHn2MEORxQZzxMvEbM/s=;
 b=FBPvnK6brtBVVOHC6dC/EcawKPOCGUtWRTj35f1cz+71anXErXRniX6S74C1InAvzy3pkcVSsXcRu0L4kLZRdSNboKVm5bTbvagiL8eVXedXwA/nXPx6SaKDjKVIx4OHNkWbqrTQYPegYIOY+BYDjP+MMnCvXBtZTvjXmWyGLpsVdBusDj+GcnLpH8/ve8nqng2pnTSpb2xpsJ1AXjgAWIpD+afKTwrRkLY4Q5063Pyg6VjHbxX9ht7V1SlYs2S3eH4Ksn9MQ+pHu9Afif8NBaY37SfI53cPUJWpCUa0x08WesLMDGD6SF1HlZCsBmxM5mIvtKPuaipNCIpSUJOEpw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LxyIWau7Gr315ex751iHEXiqHn2MEORxQZzxMvEbM/s=;
 b=ekSiRwKWr4Kb/uGI1FGUWI3Xpyoo66o1RcbEl1J3wcIO2GQ+ZS44onLljeAeqvPsnJhBsVXL7jrFPGgAFbxJWL8ADVs7pKuJtvd0OZw8V9gIZxcrhrlvXlS7/Di3FnEe9f0KJUWGbwPnpr3rcc3rIGLUT0J7l4d3Jt0Y0b5FeCi67L6vOOEYsHhFxWweGiLJWfo+uIkDG57FkAf7M0J+RkUlzHfKRt2VHDnUPc6Il7t8tjWUzM3kUq/htDcGUTxkyGYjpKSLs4bt4eZ/Y6QXY3L4RaZoWXzcCA0BpvdCP/kOTcs0ETJ591WUcdAYkbtD6S1yIL5vo51zHVyus9dc/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by PH8PR12MB7256.namprd12.prod.outlook.com (2603:10b6:510:223::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Tue, 24 Oct
 2023 12:56:15 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%6]) with mapi id 15.20.6907.030; Tue, 24 Oct 2023
 12:56:15 +0000
From: Aurelien Aptel <aaptel@nvidia.com>
To: linux-nvme@lists.infradead.org,
	netdev@vger.kernel.org,
	sagi@grimberg.me,
	hch@lst.de,
	kbusch@kernel.org,
	axboe@fb.com,
	chaitanyak@nvidia.com,
	davem@davemloft.net,
	kuba@kernel.org
Cc: Ben Ben-Ishay <benishay@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v17 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Tue, 24 Oct 2023 12:54:40 +0000
Message-Id: <20231024125445.2632-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231024125445.2632-1-aaptel@nvidia.com>
References: <20231024125445.2632-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0065.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2af::19) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|PH8PR12MB7256:EE_
X-MS-Office365-Filtering-Correlation-Id: b97dcd6d-a325-4507-1177-08dbd4909b52
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sGq3tBbRKHioxWYhI8MNYV5VUXIptvPRmNSf+J17BCsWqNBx8qn1OpZT6e5vy+r0V7RRmjK+yYLvnYrBeid1xwRCid/PZyGQyGiwGdFftFpjDI/7DQrcSCSZNegJg+Qil08TlynZ/gdNvv9BmhqhTXRcNZiAdXyLTfKA96ZWqVquw01ylaNV0FWJV/hqwIK6dvdMQvGod1AakjeO2/LnNIxx6frQ4MfUyGV7F1TIanabAuL8JrgulgkGvAQn54bzDq4+WdNQ2SZRbU9KggSKlFT+T3syxhJ+BrBvp6lHPer2uU7qTQ9aRqRGSxgJuD1a0nkL4eFL1jvK+JlHNMiWwLEqBlBmdSh1jXx3pOCKvs6Hc1lDuT+fABEBfjWXza0wvFEzlaI2BKPNUXE1zJP7zSKjGn36i6Kl3dD++jrU8XjB7IHZTv1owmyJJNvA/dgYz4puvJEh98U7IJ8MaIPPuC1dIMgVkkYmNSCuyE9MYx0WW0pgHVMkok0qRlDo7wZaEKLMOFnAmuzDyf1yYvnuxEaBOPMoaxEKIntNdA1wStx8Qg637beSuXXT96JXPV4p
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(366004)(39860400002)(136003)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(26005)(36756003)(66946007)(316002)(66556008)(66476007)(86362001)(38100700002)(83380400001)(1076003)(6506007)(107886003)(2616005)(6512007)(6666004)(8936002)(2906002)(478600001)(6486002)(8676002)(41300700001)(7416002)(5660300002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?nL8mQWDZhU2FImrJhA3TZ7dlO9wf9QeWFPCqoEXtZxqyeSx2maWIIURZuNw3?=
 =?us-ascii?Q?FkdvcKSHrWmzzzVBAL3W/zU6sR/vTbhQEHUqnW7jdK/sM4YqCVIsLv9IG2rA?=
 =?us-ascii?Q?Rkl3JIvf3QVx1pUsQyLEqIV8ssEBg3N4RiMRX0jJ3NCSvG97fbIFDeQLE/tg?=
 =?us-ascii?Q?Q+gZ2KurgXc3sSW3xBKaqETcD+fReH1SNGtWKvPbqJe2MonAM/wzhJH/uwoI?=
 =?us-ascii?Q?KAH58W2vBG4n9S4TBh9/feHEFzhTrUAw7ljTdafKBNuZRHbGVj5QFueNZTaF?=
 =?us-ascii?Q?wYLHSZEjV3pzuTdaIYMfi9Aoh1dRh0mizZMXv7lEEcR1mk2Z70dWkNHMpT+B?=
 =?us-ascii?Q?j7VTkN9IbSn22fADyeneAjlsa9QkA/RG1WcNo0SByt2XrOW0MsBc0TBI2YjU?=
 =?us-ascii?Q?xtFe2v11lcuXhQ98ELSpsprFSvze3BT+5tSsqOoMlBkPl8UzOV3QXsRJoKFJ?=
 =?us-ascii?Q?BstAlJxzS/VZqP14Q/93tcpsiiykRmZpvOoTBxCVFE1iPPYVm28JQJJlOZht?=
 =?us-ascii?Q?k6U2U4pccxEmpfhmcZNei4i9wtI9ETxYVJvu5boQui0bquxMf2AaGdsIt9Ml?=
 =?us-ascii?Q?ACJMKZGnq40zBe9YvpK+J7hICsXSMB5hkZFfxEikfzB8hZXP7Oai7LWO9nJq?=
 =?us-ascii?Q?BfjyJo5q97FYL5SR2ccV3BSaO3eWAZOX3sqouGlRqt4k+1CCQtfqVBB047+C?=
 =?us-ascii?Q?vGu1RR/oM9HlHzGG1U4WIZHNsl1l5tomY8mgtFjcSAjWdGn4uAihF9W8I+Of?=
 =?us-ascii?Q?ZesRheK5APYyz1ohuGBaunvqtFsPnEHhtJDgtXRKBPUXVhvF+lAX1u2dYoYN?=
 =?us-ascii?Q?I8xZWUMDOUsH7IcGX+ak/Y7DZcHiWYmPwq+2egJCZglKA9pWY9gyqEFTO/bT?=
 =?us-ascii?Q?5WMWT9vEdAB8F/itRetZllhicstfAI1extEf1ngm8HEpsCwRJVZKqrISHwQg?=
 =?us-ascii?Q?TQPvtiGIpdSWeEcP1MNVKq6u5UPNtYyXFjVKr2aacDVYrmPcYRBnzpqX3Ff4?=
 =?us-ascii?Q?INR1OB7M3MQt9508UrezsnN+2oUqOqYmuKaYC2AUjCTqdK21tYxbL8krUelc?=
 =?us-ascii?Q?49Ospy99RMtchrn8YjQq9K2GZT7QiGS9zgfDIwDxIjOcKzYxZTw9Z2DBOuFW?=
 =?us-ascii?Q?g5nSw3cSZgh6BzTFcBGc89XsTQ5a4+Hy8L4FEiSHqB5dR+wMwyuCw7nlgYwZ?=
 =?us-ascii?Q?vHVagsWTrkVdZeBwFOmkr59DCGwXT/j5AzGtmWs370JEjkC2U5svBKL4UeiS?=
 =?us-ascii?Q?r42mP/WnO89OMr//cWe096a9Uvb8sMZXz3uOJTWc/uc4rWpnikBiNY9Rlnn7?=
 =?us-ascii?Q?anGFo8MkVdWfDOE/MuccmKLpyrxCa9A5HYcXEDXGLbjppqbrKMlzh+sPhCzo?=
 =?us-ascii?Q?DuEnDXMEZVPQD4c520FrsnOwNUUWDs2IcgXF6zlO0U3miIB2KrRg8emiE/Ei?=
 =?us-ascii?Q?dmJeLMNr1uSKCOLr3w5Wbe9CvinKVjJhq3/3vuMTOAZK1D9jrIzqhK2Cs6nq?=
 =?us-ascii?Q?WfoKdF2/+StV3nCqPao68aycXrhNYsvqUaaTD8exImGDLkF1TnIn3p0KMAfd?=
 =?us-ascii?Q?SrnH6FklMOYbdb0n4px4l+DZiqh5qpAw4PiCFTdL?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b97dcd6d-a325-4507-1177-08dbd4909b52
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2023 12:56:15.1049
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Et/IoF57gvde/w7MmTZJz+DwVv8+tdkozB7o4a2fpjYQjEiSgeySdrRjMZq+EbZoRM9aL52iHzBwGV9cLsvwCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7256

From: Ben Ben-Ishay <benishay@nvidia.com>

NVMEoTCP offload uses buffer registration for ddp operation.
Every request comprises from SG list that might consist from elements
with multiple combination sizes, thus the appropriate way to perform
buffer registration is with KLM UMRs.

UMR stands for user-mode memory registration, it is a mechanism to alter
address translation properties of MKEY by posting WorkQueueElement
aka WQE on send queue.

MKEY stands for memory key, MKEY are used to describe a region in memory
that can be later used by HW.

KLM stands for {Key, Length, MemVa}, KLM_MKEY is indirect MKEY that
enables to map multiple memory spaces with different sizes in unified MKEY.
KLM UMR is a UMR that use to update a KLM_MKEY.

Nothing needs to be done on memory registration completion and this
notification is expensive so we add a wrapper to be able to ring the
doorbell without generating any.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  16 ++-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 123 ++++++++++++++++++
 .../mlx5/core/en_accel/nvmeotcp_utils.h       |  25 ++++
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   4 +
 4 files changed, 165 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index cdd7fbf218ae..294fdcdb0f6c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -50,6 +50,9 @@ enum mlx5e_icosq_wqe_type {
 	MLX5E_ICOSQ_WQE_SET_PSV_TLS,
 	MLX5E_ICOSQ_WQE_GET_PSV_TLS,
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP,
+#endif
 };
 
 /* General */
@@ -256,10 +259,10 @@ static inline u16 mlx5e_icosq_get_next_pi(struct mlx5e_icosq *sq, u16 size)
 }
 
 static inline void
-mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
-		struct mlx5_wqe_ctrl_seg *ctrl)
+__mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		  struct mlx5_wqe_ctrl_seg *ctrl, u8 cq_update)
 {
-	ctrl->fm_ce_se |= MLX5_WQE_CTRL_CQ_UPDATE;
+	ctrl->fm_ce_se |= cq_update;
 	/* ensure wqe is visible to device before updating doorbell record */
 	dma_wmb();
 
@@ -273,6 +276,13 @@ mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
 	mlx5_write64((__be32 *)ctrl, uar_map);
 }
 
+static inline void
+mlx5e_notify_hw(struct mlx5_wq_cyc *wq, u16 pc, void __iomem *uar_map,
+		struct mlx5_wqe_ctrl_seg *ctrl)
+{
+	__mlx5e_notify_hw(wq, pc, uar_map, ctrl, MLX5_WQE_CTRL_CQ_UPDATE);
+}
+
 static inline void mlx5e_cq_arm(struct mlx5e_cq *cq)
 {
 	struct mlx5_core_cq *mcq;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 9ddee04a1327..0fba80b1bb4c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -4,6 +4,7 @@
 #include <linux/netdevice.h>
 #include <linux/idr.h>
 #include "en_accel/nvmeotcp.h"
+#include "en_accel/nvmeotcp_utils.h"
 #include "en_accel/fs_tcp.h"
 #include "en/txrx.h"
 
@@ -19,6 +20,120 @@ static const struct rhashtable_params rhash_queues = {
 	.max_size = MAX_NUM_NVMEOTCP_QUEUES,
 };
 
+static void
+fill_nvmeotcp_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe *wqe, u16 ccid,
+		      u32 klm_entries, u16 klm_offset)
+{
+	struct scatterlist *sgl_mkey;
+	u32 lkey, i;
+
+	lkey = queue->priv->mdev->mlx5e_res.hw_objs.mkey;
+	for (i = 0; i < klm_entries; i++) {
+		sgl_mkey = &queue->ccid_table[ccid].sgl[i + klm_offset];
+		wqe->inline_klms[i].bcount = cpu_to_be32(sg_dma_len(sgl_mkey));
+		wqe->inline_klms[i].key = cpu_to_be32(lkey);
+		wqe->inline_klms[i].va = cpu_to_be64(sgl_mkey->dma_address);
+	}
+
+	for (; i < ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT); i++) {
+		wqe->inline_klms[i].bcount = 0;
+		wqe->inline_klms[i].key = 0;
+		wqe->inline_klms[i].va = 0;
+	}
+}
+
+static void
+build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe *wqe,
+		       u16 ccid, int klm_entries, u32 klm_offset, u32 len,
+		       enum wqe_type klm_type)
+{
+	u32 id = (klm_type == KLM_UMR) ? queue->ccid_table[ccid].klm_mkey :
+		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT);
+	u8 opc_mod = (klm_type == KLM_UMR) ? MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR :
+		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
+	u32 ds_cnt = MLX5E_KLM_UMR_DS_CNT(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
+	struct mlx5_wqe_ctrl_seg *cseg = &wqe->ctrl;
+	struct mlx5_mkey_seg *mkc = &wqe->mkc;
+	u32 sqn = queue->sq.sqn;
+	u16 pc = queue->sq.pc;
+
+	cseg->opmod_idx_opcode = cpu_to_be32((pc << MLX5_WQE_CTRL_WQE_INDEX_SHIFT) |
+					     MLX5_OPCODE_UMR | (opc_mod) << 24);
+	cseg->qpn_ds = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) | ds_cnt);
+	cseg->general_id = cpu_to_be32(id);
+
+	if (klm_type == KLM_UMR && !klm_offset) {
+		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
+					       MLX5_MKEY_MASK_LEN | MLX5_MKEY_MASK_FREE);
+		mkc->xlt_oct_size = cpu_to_be32(ALIGN(len, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+		mkc->len = cpu_to_be64(queue->ccid_table[ccid].size);
+	}
+
+	ucseg->flags = MLX5_UMR_INLINE | MLX5_UMR_TRANSLATION_OFFSET_EN;
+	ucseg->xlt_octowords = cpu_to_be16(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	ucseg->xlt_offset = cpu_to_be16(klm_offset);
+	fill_nvmeotcp_klm_wqe(queue, wqe, ccid, klm_entries, klm_offset);
+}
+
+static void
+mlx5e_nvmeotcp_fill_wi(struct mlx5e_icosq *sq, u32 wqebbs, u16 pi)
+{
+	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
+
+	memset(wi, 0, sizeof(*wi));
+
+	wi->num_wqebbs = wqebbs;
+	wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP;
+}
+
+static u32
+post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
+	     enum wqe_type wqe_type,
+	     u16 ccid,
+	     u32 klm_length,
+	     u32 klm_offset)
+{
+	struct mlx5e_icosq *sq = &queue->sq;
+	u32 wqebbs, cur_klm_entries;
+	struct mlx5e_umr_wqe *wqe;
+	u16 pi, wqe_sz;
+
+	cur_klm_entries = min_t(int, queue->max_klms_per_wqe, klm_length - klm_offset);
+	wqe_sz = MLX5E_KLM_UMR_WQE_SZ(ALIGN(cur_klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
+	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
+	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
+	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
+	mlx5e_nvmeotcp_fill_wi(sq, wqebbs, pi);
+	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
+			       klm_length, wqe_type);
+	sq->pc += wqebbs;
+	sq->doorbell_cseg = &wqe->ctrl;
+	return cur_klm_entries;
+}
+
+static void
+mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, enum wqe_type wqe_type,
+			    u16 ccid, u32 klm_length)
+{
+	struct mlx5e_icosq *sq = &queue->sq;
+	u32 klm_offset = 0, wqes, i;
+
+	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+
+	spin_lock_bh(&queue->sq_lock);
+
+	for (i = 0; i < wqes; i++)
+		klm_offset += post_klm_wqe(queue, wqe_type, ccid, klm_length, klm_offset);
+
+	if (wqe_type == KLM_UMR) /* not asking for completion on ddp_setup UMRs */
+		__mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, sq->doorbell_cseg, 0);
+	else
+		mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, sq->doorbell_cseg);
+
+	spin_unlock_bh(&queue->sq_lock);
+}
+
 static int
 mlx5e_nvmeotcp_offload_limits(struct net_device *netdev,
 			      struct ulp_ddp_limits *limits)
@@ -45,6 +160,14 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct sock *sk,
 			 struct ulp_ddp_io *ddp)
 {
+	struct mlx5e_nvmeotcp_queue *queue;
+
+	queue = container_of(ulp_ddp_get_ctx(sk),
+			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+
+	/* Placeholder - map_sg and initializing the count */
+
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, 0);
 	return 0;
 }
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
new file mode 100644
index 000000000000..6ef92679c5d0
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_utils.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB */
+/* Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES. */
+#ifndef __MLX5E_NVMEOTCP_UTILS_H__
+#define __MLX5E_NVMEOTCP_UTILS_H__
+
+#include "en.h"
+
+#define MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi) \
+	((struct mlx5e_umr_wqe *)\
+	 mlx5e_fetch_wqe(&(sq)->wq, pi, sizeof(struct mlx5e_umr_wqe)))
+
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_NVMEOTCP_TIR_PROGRESS_PARAMS 0x4
+
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_TIR_PARAMS 0x2
+#define MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR 0x0
+
+enum wqe_type {
+	KLM_UMR,
+	BSF_KLM_UMR,
+	SET_PSV_UMR,
+	BSF_UMR,
+	KLM_INV_UMR,
+};
+
+#endif /* __MLX5E_NVMEOTCP_UTILS_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index addf8905fc35..204a8137c1a0 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -1061,6 +1061,10 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 			case MLX5E_ICOSQ_WQE_GET_PSV_TLS:
 				mlx5e_ktls_handle_get_psv_completion(wi, sq);
 				break;
+#endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP:
+				break;
 #endif
 			default:
 				netdev_WARN_ONCE(cq->netdev,
-- 
2.34.1



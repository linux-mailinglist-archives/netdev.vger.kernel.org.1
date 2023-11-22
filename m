Return-Path: <netdev+bounces-50065-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1BE27F4836
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:50:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 134AEB21248
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98859584DB;
	Wed, 22 Nov 2023 13:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HcHYzpdm"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2044.outbound.protection.outlook.com [40.107.243.44])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4884BD4A
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 05:49:57 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=axjIY/DDnsmO/4j2tL40L8h4bAtJfiABnGQG1XUdhBgzTUmdd/i8TpItc+01ArvdC/8L84rEfb9g2wKf7gjSakckKnZSSCNqHSHYHrN0/7UYFH1hSyFSdYqHRH8yV0YybCKflrBSAMmmwIaR4WoNqEPYkuU3T2jkXIzSQB415RUOYufycsLqSwl+PBR86rljZoVxJnsY3ZB5IgBEBGYAitHon4xIf55AeGd3UMZrrjXggm5zCj4kFqJBpGED7HzXwiOmFSBIQ1elQxlXZKt9UkCo3ZHr9x9JgkVFodoGM7pVpTvdu2KMDdjpJRX9mlp9DAUTyPo0p7GC2q2QxV5iVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9f9wo7q1N4LBRai4Nj2wbo6zIznzFZVgTLxXBbGDdbI=;
 b=dpJZNc9+P6DAiZd9W9K/u9VWeYGcnrevyp6vpZ1cE+ml9DAqPYNrt/wl0Bt4EclpkZqaBF6TZZ/EGSC9rGgyJ+NvVYkFokK4PT8ncNVkerjdUMioF0Zx0W9afG8YLseiSh+0hHoksY+CK9A/DokIWjpPgGAvRsqEvev3jR9KFuAejQOSl4QOHtRPJ6GkUaYamTYjuSV93yD+lb79grNdrfyJihz9sKmeIlgpMoKdAjkIdmkaYdOQEWbhnO/W+tATJj8zz0BjKh02dKVXy1rgQtzD9cmn66SOMx31/f+B+QmUHlu/AmXoj+XBp7U2rgstwLCVXS/Umy4bw0VciI5a4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9f9wo7q1N4LBRai4Nj2wbo6zIznzFZVgTLxXBbGDdbI=;
 b=HcHYzpdmi1Ee3hLBm30HGN8vtaP3NhMiW1J/HE2flk+dH3C9SerOeiwGP3K8tV+GRQTBNf/q+LoxD7WBt8RjQpGyWOdxLaBPFprrS77OzdoibpvdNzXgmwuMssKlTz7yyy81TS+QU5TDDHZ4msOgljrXcuOQ3baZUb+/YukAb8jAXiE0tHbYRM1I+8DtnUOqYkSBd0teBwLAnwlAiHsiEInCFnx3XvlqM7s1Pp5fePFPnoLw65z2boElAu9jkpq+Lzp/UEhbfF6oucFYvfovizGQ4Z+5n8ZkzYNlv2IYxMb230wIn9Yo+bPWn3D742+K84RFvs9WY8WROCVXRNzxYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:49:54 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 13:49:54 +0000
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
Cc: aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v20 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Wed, 22 Nov 2023 13:48:28 +0000
Message-Id: <20231122134833.20825-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122134833.20825-1-aaptel@nvidia.com>
References: <20231122134833.20825-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0125.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::13) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ecf01bc-2cdd-450c-1e5a-08dbeb61e7fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aCH+BHVg6lb6C1AWY5zPEKoaRMOkWLsoKwKU8gxl2IDbQ6vPhl4YQIWyeczgTGj9MIIQU0M8JWYBXEZklt3i6k7dSBSjanInz6ZrEkPA0jklI/5rmv46cD1/cWNvt4ZjDKNbO3w19hKqU6mO3RLQv1e5hdqPr0WjA+91u3lDlUQUtmXVqBy98H4EzVg/znyLk6ZN3lRqV9O5pT5smG1m365UuqmW+0GyA3Q1xxgRrRt2BDIX+Y1f/NtawpF7moprITSmh9NjvfoF64EhYmWjHSF0fP+kGxoW0FDk0nHh+tQrK27N+cG1tqEUUBLVjsYCEHuuYINqBLsanMWo1DGIKhKWGDyUXs4UiOFYMzRmH/bH4Ajh+cQ7UiFZKwj14aw+vKpAf81iJzSOTwTCQYZLB9+EGVu6vMdU/oj79nPDLKfFqbvqTMd6nrlr45Ivuf1/LBsBDabXPNGGg8mga7AU+6dZNfbI+uGC9lZvRLOpquvI56eDWrkpdWc6W/yJ2pE5i1UDhUcCLlZXn2zQ9O8Ao9EX27QaDwOJyZ8/tuY/+2Dk98c7huIv7pBPkeT476dl
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66556008)(66476007)(66946007)(2616005)(38100700002)(36756003)(86362001)(26005)(83380400001)(1076003)(6506007)(6512007)(107886003)(6666004)(7416002)(6486002)(478600001)(2906002)(316002)(5660300002)(8676002)(8936002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AjXQHhp+x9W+otqCA/tDlrHUAXVzjxKuqiPqYrViV4s5PvWGLwBPKriMiN0Y?=
 =?us-ascii?Q?8XfsVBySHHxbzjwy8gSmlORC4//Q5E29QNE83t6d4VKRy1lhzVTguZ79wPpL?=
 =?us-ascii?Q?raYvk9NuiA+RQKTk1aTIfFGVK9W28n9XYG1f5HCM0QlxYLdbg4cmp5eLIjB1?=
 =?us-ascii?Q?fFuz1z+WP9ibzkibMt9oBZCjImz+fc0kOHH1WMdsuTGBf0rW7zO3VWu5VVWa?=
 =?us-ascii?Q?430XN68NVeacGXzEipjKaJYouQm0oxTpOoKEHGCdtlsQ7W7rA2jRtPeQowP1?=
 =?us-ascii?Q?EOBMUqKOhw4G5MEr3qJICPpawqQK2QCk6yCM87XGkuiMFvivHL4abqYMTpht?=
 =?us-ascii?Q?To/10VqKASBsrdFpTL+WfkBziqlhTG9vkLBUYq9n4E0NkAu1DmuQ42SEWl1o?=
 =?us-ascii?Q?SG3Sx5mao/wfYs/b4SiJYh+oQQInuAmQnhFDOkre8/2cKqtA3PQpWK7o04PR?=
 =?us-ascii?Q?ubKmUacubUXHP4QdFINRBLh/6oZaP8rupmCfH1ZIjKWpFtnQxhNfkdqoZuG6?=
 =?us-ascii?Q?oWfGRiT3tkFKgrwv0BqJ2epp+imPXxoPtf7Mkm0sAZRkis/XIm7z+vl8N0wS?=
 =?us-ascii?Q?OmCEO3sl3Y50woWNmiMTHUTTbxJLqI0oIl2XxMSvXireIW9FaRXtEp7N1oNq?=
 =?us-ascii?Q?Z6Iu/plxqrw709T06WtptJqevorZPZU01hnxJXxiuZRlLnF5i1tRL9AtN6TI?=
 =?us-ascii?Q?oVMtYcUa0z1zupJUn6VExYCirtUuO5p1MFamjTWvFmZyJdM4FKSWuwa/fcsB?=
 =?us-ascii?Q?vA2MASQwshdruvlJkXlHO+GJLqQ7agwmSSLQhTE0lqGX9ZHiB8pSVqB0/h+y?=
 =?us-ascii?Q?lPVs6SVntHZM5xTGe+KQIRA9KRU+q6G3qrWzMO63dMr9e4rtxV/Yz4+Cz7QZ?=
 =?us-ascii?Q?luOKJMItH4KzZPQUVCFBSXxYI8Qw2UW8M2G2Bd/03sgeA17CzVsTxgCsV6D2?=
 =?us-ascii?Q?+xNUQeU40ccX3kliXSVHf2Kra+9f7M931Vu5d62S4A1w1YSy9+OlCTIctkqM?=
 =?us-ascii?Q?IMGKfukTO4y+EHOUwEgALdPyg619UYxvkZQtYK5ujQMUCob+SVT90oQUw9PU?=
 =?us-ascii?Q?6COqOjK8YOisDnhr8/sau7C/0j21rb2aUNfgEy16CV+pmLsvZ8sfrfn57UBW?=
 =?us-ascii?Q?6Ariinw5IjeCfl5CPdrT7S03z549B4c6B6S2lmliwrDKir/Tn5IMU22jtJ/Q?=
 =?us-ascii?Q?O8UwHysvy0UcKnujXpgsZz5t7gwVHLOuANKWS1fddaMTpZmbzNFA5hbZuklJ?=
 =?us-ascii?Q?1EPe1xJm5EUn8cCCnmITkKVMhrW6zbUuPUPBLcchJB8KALMNt8JdJtUvtlp0?=
 =?us-ascii?Q?OvrEFzLB6hKu5w9hrXigQ8DiVKrM1M05Pz2mrUnfroag+2ecOD6F76P1cHSq?=
 =?us-ascii?Q?SOiMbDMN3ycVduedx8+/Vv+yHHXZknw6bzPVbHEARYIIwTjChgloCeBEBR2k?=
 =?us-ascii?Q?Gzl5UljOI78hC9NHIIp1EhLRND/s2aLUAdXuh88Us5qzC6BulJczxIuXastW?=
 =?us-ascii?Q?qBpWosbSqT0WYnyLm3pbePmrB7EY8HlAVl2qdP8xr9PkxjhSo0zx1SPzkmWE?=
 =?us-ascii?Q?w4q4ZnUaOR99qvbCVBMQZNgPCR7gSokxNXEZMS8R?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ecf01bc-2cdd-450c-1e5a-08dbeb61e7fa
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:49:54.0638
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YrqGUll0jTgm/IfwJfM8ZRx36nimfO+qwNXJw89Dvdbq11jgSw5i5KPB874DsYV4ZFT5QNfmKKEkyKofptbbwA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800

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
index 8f99534430f0..a9392f88bef5 100644
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



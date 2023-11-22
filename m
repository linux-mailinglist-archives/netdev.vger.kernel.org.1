Return-Path: <netdev+bounces-50066-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E15D7F4837
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 14:50:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95B1CB20EF3
	for <lists+netdev@lfdr.de>; Wed, 22 Nov 2023 13:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B78664D5AB;
	Wed, 22 Nov 2023 13:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="RNhEDPx7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2053.outbound.protection.outlook.com [40.107.243.53])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3144D52
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 05:50:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iV6rln8v8V3bmPKN33vZbFvkx9sk9v81EArKtQyMXxqz4mgc9Vo0NfyBVrctieP7vMfpfsawAJ1DTe2ygWuJSFEpv3GFAyXHT5PCCoBAqzwGu653MEftfyMrphIwW3acpjFc3jrbCE8xbCll7gyyiG3xLi+xOUXJAGMKXl0a5c/j/tGUOiSTB/5k4eV/j0xh273Q/smDjJGbyN5ZNIrjDR1wpYQY3U6QfsxJ2WPAHZTj6NzaErC82iOofR476YgJpxDXi/5E8bHDaSCm8iUEn95C++t6k3KdkGEPcInz1nI5mpgtP+xvkvyFq9QqrkCoELVEJxac3uTc+o3YJiv+aA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QOlZDxSyHsLEZF97yXuUaM5RscokUivVILbVgtgH0yI=;
 b=k8RRv2gp6WKvcypl/MoL2N7AhJRHAGm5k4/6Rp2PHcc65m7nMF9saeSYZ29m40OiIF0cUY4PFGXEceMHdAM/llBcojwnP1sErrgsdJNUHTi2J7fE92ULWJNCo4K/IFo8n4CQRVhDQIcKZd5i0IZZsyWhbL8XMo9bjaIs1ri7J7Ffwu70eimBJ8+B/BuUvmp7Rupg7x4c/PVsIyK6z4aSBAMQssF7KhN1zp1TqHypT7SfANIlPF3EI0z8QpXY2p0KrGTvNgHk5dNZFBfnW2Ur2TkMkQQl6JfD8KVs/xhbKn5Af9SamrpIEs3ICVNbXb/ytE5plA7ZY2I0QRTSPcbMkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QOlZDxSyHsLEZF97yXuUaM5RscokUivVILbVgtgH0yI=;
 b=RNhEDPx7ZCYhlOx82KAxL5DWstnbe9rwv4ZcdUPM1qhLGx6V0QA38jN6734UrvwSXU5asM91+O9p4T1M+285D1/s7hYNPYaenNvtRGfeJSs6JYw5KuXu8Td+Y2gXZHtslIFvT1i76r08PA3vv82AGZ1wrlRQQOQBn/Nje7UVW86HgZdwH3ofa+12TT77E0Db1ujZmylC3ghqzAMtjyACZm3SFHvBzDXX0t8l5nhWBeYNVqOgaiNoGMyDxmkff0Wy0mKcWjPhndHRjeBn8CAuFK8rxc+AjXqJQmlbbn16Q0o02GQuw4d0P5fm3Wm76ep1SCGcslFtKhLZz+j89+6VKg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by LV2PR12MB5800.namprd12.prod.outlook.com (2603:10b6:408:178::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.18; Wed, 22 Nov
 2023 13:50:08 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7002.028; Wed, 22 Nov 2023
 13:50:08 +0000
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
Subject: [PATCH v20 18/20] net/mlx5e: NVMEoTCP, async ddp invalidation
Date: Wed, 22 Nov 2023 13:48:31 +0000
Message-Id: <20231122134833.20825-19-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231122134833.20825-1-aaptel@nvidia.com>
References: <20231122134833.20825-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0134.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::8) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|LV2PR12MB5800:EE_
X-MS-Office365-Filtering-Correlation-Id: 0d88f7c1-da22-4c0f-d101-08dbeb61f0c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	cFVOH0k5dCjR5BXF7P11O2MSExPunSBrWkCfuw21N5dZk5rolGF2Xu5NEb3/eQ0eJyucOCOcVMvY0o8b8LLAFkPn+iZtnyYY9Umm+1y/xitTEjhI3G3VF5NCbAzPSU9NgF30IuwwStK37JhOW8MUReKp2AnOnTu3Lmd3hbQQrS/F53dagEV9TNdisR9Ot8ifvo/Fr9cLr5+knhnHLSAz0FglVm7Wj81ImrSV3GCuYnQqshZ23dvvICI+HuOwehURAddqmUglZjITTXGdXTFvxY7FWvpbX9fBDfeGKyXeQXMm10zNgGPXAmz+ZQeFT1V1+1Nmm1/IE0pNSQwCwNn9Jl7oqA3I94Rs4psk7j6nnQcDltTPrLm4FPTBUChlOg91Xmwi6GoouqBKSm4z8dcTKFKS/j3vF0yNSGkN9WaIiPiZgSodcBiEkq1X3QprJ+fkOGcByUcnO0KcaU6fKg4mNA6zIEycu45StGKdyiJp39O5kG3ycOgaJ1F4rpkd4q2PoiKheUyD6Ei6pnZxB4xvovv9PrWtOlQQk6yb3rEmLzOD4zZuzWtf77zTk2CQBQiO
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(66556008)(66476007)(66946007)(2616005)(38100700002)(36756003)(86362001)(26005)(83380400001)(1076003)(6506007)(6512007)(107886003)(6666004)(7416002)(6486002)(478600001)(2906002)(316002)(5660300002)(8676002)(8936002)(4326008)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2CSnhzujPel+1cWBjBUjK2RCgoyhySETlm4dFCKxhuJJa2456czKF40daJEL?=
 =?us-ascii?Q?OeC61YT/xIBFO8QZUIlwbc/MKal1K4IhCgdkKwmvP4unIJaCP8kqvENsQF/r?=
 =?us-ascii?Q?LQWVyF3VSwpAiJV3LQqhzWMKAfdMkXzftY71BN2MTgRGnbKmN9/XX17KDQfn?=
 =?us-ascii?Q?IAy/BH9DUdO995NEE/hkou1nfS9mqkdDn3EyruX4zmCRGo4BJAGpGk6FRGOY?=
 =?us-ascii?Q?VrRKqWAx6fIA5eaiugDtWKgcqPWgz6+k2JqTX53sfxW3vBgqYyfWwtqkOcuQ?=
 =?us-ascii?Q?vE8yt6yLoaK3JD5Yocwvz/9UbeDELbTwGlg420t0sey5w2Elrqv5opZqmk+P?=
 =?us-ascii?Q?pqNUwZn0D0DW3FNFqKhEx/rrAicfRImxcVBLdfZV2nm7LozjMU0NweIWwUyy?=
 =?us-ascii?Q?L56X5pj7gMAnvramNdu7fCvoBuij2D6B1aHjzAVsNOdrGpk1xFGP7dEdrT7X?=
 =?us-ascii?Q?jyFj502HseeGVzbX+gcQJJcclS03NwxqETiB6/DRNzshw7REQO17LRV+zKfP?=
 =?us-ascii?Q?9mpjXrHvLlTIrMxloXnbTqmsGU2tkTkpACsut7J237PRD082ouUnphtsPpfS?=
 =?us-ascii?Q?6QzPDVMu7JUacRN9goxt+NZdxnmmo+KuSq1IyAIPTAE1nHJLIXODQubxF60b?=
 =?us-ascii?Q?0J/bAfafe7k6aHq/7bsr8pTA6u82l+xeDV9Gf5qBmfw+DI42b5I6V0efMH4Y?=
 =?us-ascii?Q?PKc7W6Ehy/6XInnhg9WN5TWZUyejsKNHAr5jxMIpqQ5fiH/dIp5tPmIn9s/9?=
 =?us-ascii?Q?1Uq8Ac4hiAgsTUE9LGFJ8sh8xI2Zlw0cVWZbXqL85Y+B0sh6dzTdpZfYhEk9?=
 =?us-ascii?Q?0Vo96LfDlEL475LQhGfV3XaKPAz2YdO/dQQX8+skedEdvlZEti/g6KWQGbK0?=
 =?us-ascii?Q?7B9AidQtSl1IwfBQdhwdcJleRLa+yyZsuBoSem/BOuAariqtz8iOpQTMlduF?=
 =?us-ascii?Q?FmDzlZIqWvkSPOEx359KoqHqzQBUcMg9nTWLVhMltj+TrOCPXYoRwbHhLwa+?=
 =?us-ascii?Q?1CPjHnymauMtPluFXXIDI6wB2aYw9XP/NHprgjpervjLEluAVjC9Ou6cJMus?=
 =?us-ascii?Q?Ds+vsqbZQJbYDc1s6mJ9J/9pzfjtH4iPg+gz7+Klli5X00m85eaT1qJY5STY?=
 =?us-ascii?Q?VlM0ipsHCs7zY1LLu/taG7GeaR1MQJeM+ZLOaXdNcOLaj47+5B+Zi3YxIO5T?=
 =?us-ascii?Q?jCetYDv0IS9Wk7655h2/I+SXTc5LmDqrT+6p6nWPlRVYUytN5qP1BKRMc8Uq?=
 =?us-ascii?Q?cvipA4zKI+CU10lRY5HMqL5hNcFIwfmecKO94uKucEb4x8CNkgHcDLGaQsIi?=
 =?us-ascii?Q?00FjqI9rmxTLmWP1DMjt4QOBot5TuFp2ctzATuKy/JRPrTrYw5aztKejBF4a?=
 =?us-ascii?Q?RdhUtCM9kENxk6jySKYovxQBzc4dgL0UJeVOflr3R3SYdg6HWLDfolcGAaYT?=
 =?us-ascii?Q?3V3RabxtIpHKso+eJwd2kO0Z24JafAsDUO5X6QEKX7jsZOqjipiCLbjtiEDy?=
 =?us-ascii?Q?lAl0ohuJUxNrKmt6FHq0ZWIsayG9ACLM9xebktLvFeEkXtVfZOaptW2jGMPV?=
 =?us-ascii?Q?XHP08E/1eU4MlcQRi/w1LYvJqqcgmgSw69PJZh7I?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d88f7c1-da22-4c0f-d101-08dbeb61f0c4
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2023 13:50:08.7996
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: skQmU4TUcU8XL66bSCtUISpYfGZuwifDtBPtBgtu1PAqIfXPTIQxeJ37ZsZDq9pf2QcsjIr6ddziFmXftqo3LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5800

From: Ben Ben-Ishay <benishay@nvidia.com>

After the ULP consumed the buffers of the offloaded request, it calls the
ddp_teardown op to release the NIC mapping for them and allow the NIC to
reuse the HW contexts associated with offloading this IO. We do a
fast/async un-mapping via UMR WQE. In this case, the ULP does holds off
with completing the request towards the upper/application layers until the
HW unmapping is done.

When the corresponding CQE is received, a notification is done via the
the teardown_done ddp callback advertised by the ULP in the ddp context.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/txrx.h |  4 ++
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 66 ++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    |  1 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |  6 ++
 4 files changed, 67 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index c87dca17d5c8..3c124f708afc 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -52,6 +52,7 @@ enum mlx5e_icosq_wqe_type {
 #endif
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
 	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP,
+	MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE,
 	MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP,
 #endif
 };
@@ -230,6 +231,9 @@ struct mlx5e_icosq_wqe_info {
 		struct {
 			struct mlx5e_nvmeotcp_queue *queue;
 		} nvmeotcp_q;
+		struct {
+			struct mlx5e_nvmeotcp_queue_entry *entry;
+		} nvmeotcp_qe;
 #endif
 	};
 };
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 8644021b8996..462e0d97f82c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -142,10 +142,11 @@ build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe
 		       u16 ccid, int klm_entries, u32 klm_offset, u32 len,
 		       enum wqe_type klm_type)
 {
-	u32 id = (klm_type == KLM_UMR) ? queue->ccid_table[ccid].klm_mkey :
-		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT);
-	u8 opc_mod = (klm_type == KLM_UMR) ? MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR :
-		MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS;
+	u32 id = (klm_type == BSF_KLM_UMR) ?
+		 (mlx5e_tir_get_tirn(&queue->tir) << MLX5_WQE_CTRL_TIR_TIS_INDEX_SHIFT) :
+		 queue->ccid_table[ccid].klm_mkey;
+	u8 opc_mod = (klm_type == BSF_KLM_UMR) ? MLX5_OPC_MOD_TRANSPORT_TIR_STATIC_PARAMS :
+		     MLX5_CTRL_SEGMENT_OPC_MOD_UMR_UMR;
 	u32 ds_cnt = MLX5E_KLM_UMR_DS_CNT(ALIGN(klm_entries, MLX5_UMR_KLM_NUM_ENTRIES_ALIGNMENT));
 	struct mlx5_wqe_umr_ctrl_seg *ucseg = &wqe->uctrl;
 	struct mlx5_wqe_ctrl_seg *cseg = &wqe->ctrl;
@@ -158,6 +159,13 @@ build_nvmeotcp_klm_umr(struct mlx5e_nvmeotcp_queue *queue, struct mlx5e_umr_wqe
 	cseg->qpn_ds = cpu_to_be32((sqn << MLX5_WQE_CTRL_QPN_SHIFT) | ds_cnt);
 	cseg->general_id = cpu_to_be32(id);
 
+	if (!klm_entries) { /* this is invalidate */
+		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_FREE);
+		ucseg->flags = MLX5_UMR_INLINE;
+		mkc->status = MLX5_MKEY_STATUS_FREE;
+		return;
+	}
+
 	if (klm_type == KLM_UMR && !klm_offset) {
 		ucseg->mkey_mask = cpu_to_be64(MLX5_MKEY_MASK_XLT_OCT_SIZE |
 					       MLX5_MKEY_MASK_LEN | MLX5_MKEY_MASK_FREE);
@@ -259,8 +267,8 @@ build_nvmeotcp_static_params(struct mlx5e_nvmeotcp_queue *queue,
 
 static void
 mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
-		       struct mlx5e_icosq *sq, u32 wqebbs, u16 pi,
-		       enum wqe_type type)
+		       struct mlx5e_icosq *sq, u32 wqebbs,
+		       u16 pi, u16 ccid, enum wqe_type type)
 {
 	struct mlx5e_icosq_wqe_info *wi = &sq->db.wqe_info[pi];
 
@@ -272,6 +280,10 @@ mlx5e_nvmeotcp_fill_wi(struct mlx5e_nvmeotcp_queue *nvmeotcp_queue,
 		wi->wqe_type = MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP;
 		wi->nvmeotcp_q.queue = nvmeotcp_queue;
 		break;
+	case KLM_INV_UMR:
+		wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE;
+		wi->nvmeotcp_qe.entry = &nvmeotcp_queue->ccid_table[ccid];
+		break;
 	default:
 		/* cases where no further action is required upon completion, such as ddp setup */
 		wi->wqe_type = MLX5E_ICOSQ_WQE_UMR_NVMEOTCP;
@@ -290,7 +302,7 @@ mlx5e_nvmeotcp_rx_post_static_params_wqe(struct mlx5e_nvmeotcp_queue *queue, u32
 	wqebbs = MLX5E_TRANSPORT_SET_STATIC_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_TRANSPORT_FETCH_SET_STATIC_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqebbs, pi, BSF_UMR);
+	mlx5e_nvmeotcp_fill_wi(NULL, sq, wqebbs, pi, 0, BSF_UMR);
 	build_nvmeotcp_static_params(queue, wqe, resync_seq, queue->crc_rx);
 	sq->pc += wqebbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -307,7 +319,7 @@ mlx5e_nvmeotcp_rx_post_progress_params_wqe(struct mlx5e_nvmeotcp_queue *queue, u
 	wqebbs = MLX5E_NVMEOTCP_PROGRESS_PARAMS_WQEBBS;
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_PROGRESS_PARAMS_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, SET_PSV_UMR);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, 0, SET_PSV_UMR);
 	build_nvmeotcp_progress_params(queue, wqe, seq);
 	sq->pc += wqebbs;
 	mlx5e_notify_hw(&sq->wq, sq->pc, sq->uar_map, &wqe->ctrl);
@@ -330,7 +342,7 @@ post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue,
 	wqebbs = DIV_ROUND_UP(wqe_sz, MLX5_SEND_WQE_BB);
 	pi = mlx5e_icosq_get_next_pi(sq, wqebbs);
 	wqe = MLX5E_NVMEOTCP_FETCH_KLM_WQE(sq, pi);
-	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, wqe_type);
+	mlx5e_nvmeotcp_fill_wi(queue, sq, wqebbs, pi, ccid, wqe_type);
 	build_nvmeotcp_klm_umr(queue, wqe, ccid, cur_klm_entries, klm_offset,
 			       klm_length, wqe_type);
 	sq->pc += wqebbs;
@@ -345,7 +357,10 @@ mlx5e_nvmeotcp_post_klm_wqe(struct mlx5e_nvmeotcp_queue *queue, enum wqe_type wq
 	struct mlx5e_icosq *sq = &queue->sq;
 	u32 klm_offset = 0, wqes, i;
 
-	wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
+	if (wqe_type == KLM_INV_UMR)
+		wqes = 1;
+	else
+		wqes = DIV_ROUND_UP(klm_length, queue->max_klms_per_wqe);
 
 	spin_lock_bh(&queue->sq_lock);
 
@@ -844,12 +859,43 @@ void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi)
 	complete(&queue->static_params_done);
 }
 
+void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi)
+{
+	struct mlx5e_nvmeotcp_queue_entry *q_entry = wi->nvmeotcp_qe.entry;
+	struct mlx5e_nvmeotcp_queue *queue = q_entry->queue;
+	struct mlx5_core_dev *mdev = queue->priv->mdev;
+	struct ulp_ddp_io *ddp = q_entry->ddp;
+	const struct ulp_ddp_ulp_ops *ulp_ops;
+
+	dma_unmap_sg(mdev->device, ddp->sg_table.sgl,
+		     q_entry->sgl_length, DMA_FROM_DEVICE);
+
+	q_entry->sgl_length = 0;
+
+	ulp_ops = inet_csk(queue->sk)->icsk_ulp_ddp_ops;
+	if (ulp_ops && ulp_ops->ddp_teardown_done)
+		ulp_ops->ddp_teardown_done(q_entry->ddp_ctx);
+}
+
 static void
 mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
 			    struct sock *sk,
 			    struct ulp_ddp_io *ddp,
 			    void *ddp_ctx)
 {
+	struct mlx5e_nvmeotcp_queue_entry *q_entry;
+	struct mlx5e_nvmeotcp_queue *queue;
+
+	queue = container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	q_entry  = &queue->ccid_table[ddp->command_id];
+	WARN_ONCE(q_entry->sgl_length == 0,
+		  "Invalidation of empty sgl (CID 0x%x, queue 0x%x)\n",
+		  ddp->command_id, queue->id);
+
+	q_entry->ddp_ctx = ddp_ctx;
+	q_entry->queue = queue;
+
+	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_INV_UMR, ddp->command_id, 0);
 }
 
 static void
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
index 8b29f3fde7f2..13817d8a0aae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -109,6 +109,7 @@ void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv);
 struct mlx5e_nvmeotcp_queue *
 mlx5e_nvmeotcp_get_queue(struct mlx5e_nvmeotcp *nvmeotcp, int id);
 void mlx5e_nvmeotcp_put_queue(struct mlx5e_nvmeotcp_queue *queue);
+void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi);
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi);
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 1ed206b9d189..b0dabb349b7b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -968,6 +968,9 @@ void mlx5e_free_icosq_descs(struct mlx5e_icosq *sq)
 			break;
 #endif
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
+		case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE:
+			mlx5e_nvmeotcp_ddp_inv_done(wi);
+			break;
 		case MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP:
 			mlx5e_nvmeotcp_ctx_complete(wi);
 			break;
@@ -1073,6 +1076,9 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 #ifdef CONFIG_MLX5_EN_NVMEOTCP
 			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP:
 				break;
+			case MLX5E_ICOSQ_WQE_UMR_NVMEOTCP_INVALIDATE:
+				mlx5e_nvmeotcp_ddp_inv_done(wi);
+				break;
 			case MLX5E_ICOSQ_WQE_SET_PSV_NVMEOTCP:
 				mlx5e_nvmeotcp_ctx_complete(wi);
 				break;
-- 
2.34.1



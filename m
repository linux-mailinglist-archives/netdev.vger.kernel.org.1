Return-Path: <netdev+bounces-75723-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CAA0C86AFAA
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE7C51C2510F
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F6F514DFE1;
	Wed, 28 Feb 2024 12:59:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lDvklN/I"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2082.outbound.protection.outlook.com [40.107.243.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EED514C582
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125147; cv=fail; b=Jg17B5Y32FsA+svGcewCQCoDwffA3uQDJoaif/dLnV7E5XY6GLBlq60YuqzSW5+yX1V7zBQhwP7yhZXCo+2XNFwIJAL/mIVSmlcnOYmwTHnnReCUHfobmexaosjLYrS3sszYBNqAzsQQEft6u32f3zoKgugwiNhwrRV0tpTJ0n0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125147; c=relaxed/simple;
	bh=UbuMSkfuehEgiCZ9Z0NquzvRHU/9lpW/wuvIH8yNlpA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r5FG86+65nwezG6ao8kDqa0JGeQCwuDVLtWy8Q5J5+sfQ2O1hioDhvuKNgHlhQqDhgoEnBVoITmQJ1iyLLyjEtm5g0Ta8yQe1pGcDlKhTWtwtXf2PPudctixYPZAOyOJVh9AgT4jIlXp+MKQvOj6zlgdlULwEcRmoqgGC+Eb7ZY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lDvklN/I; arc=fail smtp.client-ip=40.107.243.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ear+io0J6JCbpg+/BN7lNuDLfzkrG01SYAgcHf607LYbciRm+nif25HHz18fo8Iwn+rzg2G9HQYolyCme+NTmBRxZA9nfeoHeI1gGfnWWokuobPwTuFzG3gm8Pd6MJes427CzbnfxuWG3mVoMPA67UQ9I3XXJLD/8WETFyKrTvSFg+GJGSxvT4cVBer37xzmhW8gER4gbbX/lTiSwhKvflc8PGUce8Wh2XOcruksILdjvxwKeiE55G5Ms9PNjyETKBk0V8tKd+UaK4AvL45ub133ArYPfRJyhYYg8lwm3xhGJvV0rfc9MsPl5x+SVrOr1k+NgJ3YpUM1RLpWgLlddg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7gG2+nSmQ4j+/cg6MJGtX5WqvxLjWmgRwM9wwAH0gY=;
 b=fVNvGI12EeRc1UmQ6YlNeBFke4aiNBV8KA85MmgSHlPs3AYy/KeAFgfEe3d2VCgQuFvdCoRk5sMt1sw5ZC6w/LIdYuZfnEEqqzpY12IfokVVtjmM7vI+RxDCnESuZpn0rZGkTzfWjR3D6oU8SIdUzsJetCn9RDho/M92KX6UQH/iAiCfN6kb3vkjHkcZtegNiSfuvYd9GSybRgx+/XBABvf9XvsNhFTjYrVCpzfIhVKgPjpbWs49E97XzgPvd5PQqE2QIqoaHSsAmTMp9RatZ6nW0VW3M754qTGN513eMLaK6T2zWLyLKNYLVEFTrzgBKyaTzzCDaNmQVhqrRIXDBw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D7gG2+nSmQ4j+/cg6MJGtX5WqvxLjWmgRwM9wwAH0gY=;
 b=lDvklN/IUgcHSBcMjZSd5NY1Vf5Mq6jNp8NgQB7youlEpi349YRFwAV7uo1RAmJxjH4D6nDIo+3Xwrw9J45fnCasBUtOMR5+iKNySzazvpJ1Pk2zhQP6GdBnQ82vcEt1cDtDghxs//+YN14Xb4UWGZg30UjPYulcfAqG0D3dzneTx5hSlaecuqSS9y/NdQH3s7dCwKGQBr3jr4tiBQNfoVDZALboNmGUKpLRRb9fopXQ4nbbEI9hJ8lSNIuAxzy1ECbnqE99uzmsVWU00bTL70czdyd1tZQ+ClbTzTNB2fjRyO4/CE6n9i6BmkYjAaiT7hvOZ9D8zdTVWuSORxZRpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 12:59:02 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 12:59:02 +0000
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
Subject: [PATCH v23 15/20] net/mlx5e: NVMEoTCP, use KLM UMRs for buffer registration
Date: Wed, 28 Feb 2024 12:57:28 +0000
Message-Id: <20240228125733.299384-16-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228125733.299384-1-aaptel@nvidia.com>
References: <20240228125733.299384-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0041.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:92::12) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f6451e5-070c-4c97-6970-08dc385d097d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	PzDnjdYEl0msPyncYkCJldkvgAIHg3HDRH0LhMdaopLc37yThqrZ0SL8OfyJ0et5PSkXSs1y9glCrbIinBI2BD+V/Jmf91IKTD8D16c5TcAX2P/nX06P/h1SQs5sDIXnjWICcj3FZ5vd2RB/ACEczQsfE4evkKMkfdEafc7HuDiJODjj7r8gX0VuHpj4KmT6st5jLsOhlmqvPr9cuvetCZ3lzQNUw+d6iz1O91dL9MwUOXcxuoPhNJgt2xfjjOtAvHjbtWracXHn1ctSDQGqDKWD/pLKaL1SKXQwsaZ18HIA9icIyk8A0MHc/JU+MSsZVt0kqUl1mQzAdP1vmlbaA8yXKOwm02HgoBGUyTFTX2c7elDI4n6hB6GSIWq589uxOTiEAyBWbqZdRuDZsioJIcyzFPNuaKLrnT/rqyGCfBsrpOmUq4PwdARV7dVur6CKFaihq18vHIyGVmg4wbConFs24WfoJJVNl3IfTIfPupGbIJtl79LKDNGNk1UzTZ+uKN0CVeztIUUX8H6dHNaPlZX81I0Ez3jtBeM5Jlf6XEfIU5XlztHQcR+zydxuz+FftS921ur5ZTdw7ZOVlG0uoWU0Eb1WpOnJR68Tfm7GIuKw3PAHz74jAsKSm/yKTHyf3kwDHDMEosMUVGm/AHSA+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7wSLW7OxqZFunfM5AffjmklE7mebR3LWQ7xaDbFd4MwnmlJO+0hz9N71yuF2?=
 =?us-ascii?Q?W9lYxoYBm068zYlwNVKXRtaN0DOgoCuN7y/R2kXIIwomHCO14tPjsy8J4vtw?=
 =?us-ascii?Q?BsB/YrfIfsA4sJzlw9P0StwsW0SG9/Q5fc6sTj85oCa+y5HmJZSClBfuYuk2?=
 =?us-ascii?Q?9e8R+jtxrtmGjQU3hIUJFoehsO71TBvwe0mK0zUsUSLoXmYv+1BuYo4IR5Du?=
 =?us-ascii?Q?fP/QufIq+lZ4Qnh+RcYDgsWSHedoa/Kr0fsdrGgP/j8KeFmzTR3+tsRKMqe4?=
 =?us-ascii?Q?uj+APLQsKvAsDHR55+16rMt6RK6v4JP2vrTmPEf1KPuzNqUrhMapvayjOT7J?=
 =?us-ascii?Q?K4aKL3LlFQ8iVaardrICrNticeaWHuHjg2rq1KKoIbt2ATgWpVQl9M2Tku0z?=
 =?us-ascii?Q?5dx7WC+IJ9Ms5U2/C5BNqiwzSiwkHLUDi+IePE3a9Xwubv00Aq7jpA8ENtUi?=
 =?us-ascii?Q?T0+hgjSEKZv0hByv25VNcufWH5dU9ZpmGnulemYGPCnqUm/8SbvzlX7zFLpq?=
 =?us-ascii?Q?ZTbJR8svdoo2xtBmn/RWp3yrj+m3cyryjwUY3IRffLGmhSPzJ9GRNtXaOknt?=
 =?us-ascii?Q?D2LHbxfHsj3d4yNQlZbTDKUAKOK4H1x/xT1sZmnWbb+24pWiNt331MsLemqU?=
 =?us-ascii?Q?eZB22kHM4EgsGKeNzMNSC0c60NGnoOJuU3IAdEgb1JpEDkBxJurrfXV35oLo?=
 =?us-ascii?Q?K2VBToZK72Pp6k85jmEIMPdMn7dCdEDB3XiypbAMsfe+rTdWem+hrqt3lH8O?=
 =?us-ascii?Q?JFD4L/MoIrSnnd+urt43Iv3RAlRpw3taMsnirofQfX/3ri266byWUdQPf5y2?=
 =?us-ascii?Q?zqhCHEf8BtgObdNOQhFwZbOELIoa89Q4SF3dwwitzMXUp1wD63oT1pLEiQ1t?=
 =?us-ascii?Q?pRWr2GvjiioK/EwOPyVRX9S3wshJB0Av7RaHS4HkDNpb8WI5ClwUhPNw0uKZ?=
 =?us-ascii?Q?pdf3NhJxf3DM9yaE10FM8DOO5dSeJhjdaEuMKc9w9CxmWYnYlmNjiAcpfA8T?=
 =?us-ascii?Q?xNcPw20opihvNE73Ud+9MS35ESfPL+KFjzUk2BnlBRNh19TSIUzEy3wLtyBc?=
 =?us-ascii?Q?7ILi5cZLAiTSmG7fZE7+44fLsFjBjqwcrjWZ6qCx6IfsCoCfhlDGGc3CoC9K?=
 =?us-ascii?Q?CGFpqIgmVs3ylPwKawzVa+dcO+ZY1oLCbcFOSuO9CPfhPsxWc5NZZLtHdj6C?=
 =?us-ascii?Q?yT3dEbrfBJmJBRnWdiyOtD367nTGCWWo6jTPp3cs44aqem1N14EyWMKKCg/o?=
 =?us-ascii?Q?6f5v51+bmirRx33hvTOhSN2XdrzT0fbeM86k9gpQ/Smk2YBJfN4h1+jGVcEq?=
 =?us-ascii?Q?XwsN8jqyHa9ywzH69XEmPSHfFuPhe0r7JlhLrHq6V7tZ3JLRlB1A1tDVKBS1?=
 =?us-ascii?Q?NwvXAP/+W8psn4lvZiGREDy2KG7GH9OeGfajbwqA2fQhkFXPA4qeUrFh10PQ?=
 =?us-ascii?Q?AcTbKaXISnGleV6cr/9/ZokRr7GTgtxkWc1mgvXC1+IP7w6wwJSAjSvdVPVY?=
 =?us-ascii?Q?uwttwzSntdChuyRqSJLSq1sGLVFleb791gQPbb/MRXtx/hgTjuWomPW3vAH5?=
 =?us-ascii?Q?KJyggSDii+hvxVup0wPHW/aAn2pVYr38sMODhWLE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f6451e5-070c-4c97-6970-08dc385d097d
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:59:02.3677
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: s3bCPnJdHDrY+dQpbOFQtU0iPmWaDGwFBAvHCUHySN0iTaSB0xnCMkAb97ui8003mw1DmknvuSZ5/ky6xp4sXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859

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
index 780902f63823..ff8b648534db 100644
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



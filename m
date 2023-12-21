Return-Path: <netdev+bounces-59773-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B9BA81C040
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 22:35:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFD1B1C24AC2
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 21:35:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AA277762B;
	Thu, 21 Dec 2023 21:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="CumQ57Cx"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F13477628
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 21:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eH23HJtKb2n2we/cxDkA+Xix8SWk9YA5XJl/mcoEIrUYF0c0xXncF56qQoV8YqZSyi9wQLjSHlLpjZXkJSi943/YZo3zSr9XoNcPbcGv8XQd8pEYp/wtmZWeoG3TE6rVZQB3eOVrYZyjFHzFNq2sYeC6V00+JO1pmWIeEzmdfXCiIteESiBNfyuF5ipHxMTczf3BHgG/9mci4nr/CdlBfp4iumxmR3x95GN+1sfwc2z/DLRZlzleA6Jt+rPI8djbpT0wZLcOQegiSwSTTUeOpzzWOyhdYP0JWD35ZIP2aLcsKIPw2KbZx22vMyZqQMO8xow9eB192VCa/9qCb0DoQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R4vFytacI0akD5fbZ1CgExCmkcknh3sDQSfZMK1L8/M=;
 b=hVs/Cm4f0N/FeWE92V30SlaT7pk2f/cEsn9Woz6jkalzryIazBVLOX/kw5ttZQI5LTx/bG0R21sWGSundGRHDjxkTV+kkS40BSW2tF6Zou//OJaVBQuns8KWUdXnHhsiy1n37gWmH00g2xnK/5QARWrh3C0/hImfFH32O8sk7Xxot2PUM9Rfe7kyMfCHiLb3cVFG7tIy0a1zuy/cHRE17lQR5nfQ8hfkXgQvjVBWuMenj3G7y1PBe8cFl/o98F1nLhp2c0s/HQAWgFfIxyUn0y9D+xazbhNVvEeLZQopS93L02cU5Ku2UZC6pkdTtkz3wYAh452Dj+x6AfGa9op4aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R4vFytacI0akD5fbZ1CgExCmkcknh3sDQSfZMK1L8/M=;
 b=CumQ57Cxkzu+Cz3cBiEd79huEi1whUHV16UdV9KyiGA3zoqde0fmQvSpK33TN9HBV39gj4XZcMjtwdJ57Bd5tZtVAN0s2YKZrZ+WhNF7zoZnpMr67InrHHbvP6EoYDSVMPcbReYopoTWsDl9ZHD3ZcE04LVyRoGBnQBfqoBkgrO8yPcuyvOo2ZzZKMAfKtgZf2BpOYooVWY7DBoRBHkc6akT8EMkN+tq7K5XsAKk0ew2BrS4m0a5j45RRLPrYu9malVqJFJdg0Evf4fRXWZwRgtTRqeA2cqlL+qZ+z6NuWqsJ3LcE8U2HRSVd+hkmACw3AuBdYuvPSCs6JgvMjNUZQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by MW4PR12MB7481.namprd12.prod.outlook.com (2603:10b6:303:212::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.19; Thu, 21 Dec
 2023 21:34:58 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::eb39:938e:7503:c21e%3]) with mapi id 15.20.7113.019; Thu, 21 Dec 2023
 21:34:58 +0000
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
Cc: Or Gerlitz <ogerlitz@nvidia.com>,
	aaptel@nvidia.com,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v22 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Thu, 21 Dec 2023 21:33:49 +0000
Message-Id: <20231221213358.105704-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221213358.105704-1-aaptel@nvidia.com>
References: <20231221213358.105704-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO6P265CA0025.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ff::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|MW4PR12MB7481:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d2c7f15-bafa-4d70-0ba5-08dc026cae5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tCC0H4x5c8PXqnmvc25CwAoXLQI7I8w4PgCbkXjjVPy7fuD+Nz2yCPaB1BrdLkmZ1H+aQEDc7eDjZLhX4c5Inhyd0m84pdA+IgDPBtZBaHdb6TFWBrVsCp6eqkP/uIT4IN1gnvp1de68PIkAxcT3U3I+7ptLQj11ORnTRlq+VDC6WVWoQmeTtVBJUPAiy8R5HNxAFEL9gYHsXE0IEjYCU2HYVVWXgLAABKPwPtni5bOMH/RbAkrjfg5EReaRwsPvZvAK/p8qZllocEYDxDbkZxx6WUymLBGwFEeR7aGOjL8Oa+tJggOkuw7iblgMDmYdN4hz+eKKScrZs3HAeYNmWwTQXpVh1p3Vf9DMxPqWX9QUNkF3ZnBIA//F3sBAyJRfozrqsVzpp8F+EUzul3vjCCs5Wv5GRUjCY1tjwWtS2OdiVyHEJlx4bsJ2vCHuDShazT+7hRcJUfarni1J8JcUkHP57WkQAnqxz0rfg71N1BG5PeNGJmXKUoATmmm0j9VCy/dRf7/I+0Xbgwr+WVNhwNKBQSSNX2K34wPy0RiqMd+OukDq+BhMf5i3GQWzkiHhKqtsVTXxSoVLM2SDylveFvz9T1J4bO6kri9sPCRUZP0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(39860400002)(366004)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(66946007)(8676002)(8936002)(66556008)(478600001)(66476007)(83380400001)(316002)(6666004)(7416002)(4326008)(6506007)(6512007)(6486002)(2906002)(2616005)(107886003)(26005)(1076003)(41300700001)(36756003)(5660300002)(86362001)(38100700002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Qf+hu/G6BNpmuXORNTzajXXGL+FsIJ28RoQ2opaEYUGyOyHEyXnryEmMuEEj?=
 =?us-ascii?Q?B1uJVlk7KQZNG3okUaDLSyR8icp+Ko5nRfhKoFnnf5ceXGkvdEm7Y/b20kHi?=
 =?us-ascii?Q?qo6rCC5fQiHlBruAyF88Mu8lqWXFZd45GaMh31dn/67CNheEhAgJnj2h+Sbx?=
 =?us-ascii?Q?SLaUc7LdF9lvf5m9jHtf4/rV/uvhK/WCDqY6kT+yZpXPBtPqTYyOsh2/rx9a?=
 =?us-ascii?Q?0xO0HZxdQ8UsWnJXCut7YjCGUEaZyrHtRbnRQkumk0G3tV4aJNiiSp+8e746?=
 =?us-ascii?Q?WhZiO6G5fuy7jFkh64OB6gQKxtbWN9FO+xIYd1gE8PpoQse/1mxqf7WFZwZG?=
 =?us-ascii?Q?WlyEbaZOStyLWtAFliEFepJZukxZr1vjVffgaxK7mXJD+XdVYAi+t0CBV9h8?=
 =?us-ascii?Q?eCbUvSw7DklohI+i8YcQOgTDAI0UPkAr2HuhG9Ik8OzIaA6lOwCXZjGVypwc?=
 =?us-ascii?Q?RVJ60218O3Q4RUhQQzghuhb6QWw4cAxxuh5cVUfVpyldRquGA/9tulcabq4H?=
 =?us-ascii?Q?p8f0Sx/CYRYrU4hZeacV160U1TpzFJkJNI6j7xYVif6YAq2WKEk8RVP2i2hL?=
 =?us-ascii?Q?VfBmj/zsyevGUyP7ynPMdeYRdKDoRGYF4zzO16iA9//YSEjVMIsCQ/AMJvL2?=
 =?us-ascii?Q?aQJXBatW4TUMim76/D+UOGd7Uo17wmk2R+vpH23r2BD4jgwnK23AsRG/pnbh?=
 =?us-ascii?Q?CiB3oSfCqm0Ojh71lEkjPmJ1R+YCxc2HV4R+tHTfW3e6xR+27VwJLKK8Dz57?=
 =?us-ascii?Q?4D+zQEghnXDY+24fHiRPCMbBNZGUx5lMLdmL9yfXv0M9h7H9Tq80UxHNpSFB?=
 =?us-ascii?Q?3h+rYBojGZtrlnkN5lReFM8O3Fs/p8tvxRr4qLbm3GjENGbehKuublzj9Tb2?=
 =?us-ascii?Q?hs3xkOxYnvmjEI1Jm7Haox3HU6S1pOw7UVjl1kr7UdFDlyIxRZp0n+JbbwmV?=
 =?us-ascii?Q?+Zybm3oRkRabYukkddd/wGhXSZoLDB1c+0AkrlOrCTA8U5Cwd4X2S7SH/sOE?=
 =?us-ascii?Q?B/ZdJZayyrtAqZJvnO5+7U9mdM7WYKW5JV2IlWmfSmnS5msMumCvLwMOuLS4?=
 =?us-ascii?Q?y/81EwRdr5yuwT6rB+qo0WAaR5SQuPVSkzuk4KBjL1jSehlbxuDy0U/MJtMw?=
 =?us-ascii?Q?V6uudPUxznR1pgvLgAVJkYn5TpzCDthWSomd9E2KUzDdjE9gRgtzBLGVciL3?=
 =?us-ascii?Q?Ev5SDSItBHri2m4J+GeUf5ewFamarDuTK/OoYIMx7POv1iqwJaULXu6fih6v?=
 =?us-ascii?Q?3OLDxj7EedpB2iMCbE1CBBsjRDxGyBgA/Y5KIIef32SrpHqlbUdJ/pWhHNn3?=
 =?us-ascii?Q?m7W3Ubzs6shxcmgAJzBm4QDnjQv2MpDZBBa/DqAX9PLcSrGitZDY/e/INuXL?=
 =?us-ascii?Q?8ANfsB/cuaS4OgT8hQWZg/01UfFw5J7HtpseHQ3zianiW/hJNFFQqhZqK3ht?=
 =?us-ascii?Q?JgxNHcrDAO0wQDkDkaCylXEgW5AWjS9z1BVxQnL3t9oxJ/QedwIAyqVbCbuG?=
 =?us-ascii?Q?HqTNSYcYa7vN14jAthTINukGQyENMzjBFXa4xf8N8hosj8/JOytjagv1qcpq?=
 =?us-ascii?Q?IHYG7zsa3GhIKWbYPZ+5KBHhEenElS3tlFQpPv/3?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d2c7f15-bafa-4d70-0ba5-08dc026cae5e
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 21:34:58.6688
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mXa+ZgVa3i7GRIc6UzqnWhzVIo7QbdDTtAtoyYTqYka8POFncrz3buNwd1ONOmm0uHL9F9v0HQ8qD19idKfGWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7481

From: Or Gerlitz <ogerlitz@nvidia.com>

The mlx5e driver uses ICO SQs for internal control operations which
are not visible to the network stack, such as UMR mapping for striding
RQ (MPWQ) and etc more cases.

The upcoming nvmeotcp offload uses ico sq for umr mapping as part of the
offload. As a pre-step for nvmeotcp ico sqs which have their own napi and
need to comply with budget, add the budget as parameter to the polling of
cqs related to ico sqs.

The polling already stops after a limit is reached, so just have the
caller to provide this limit as the budget.

Additionnaly, we move the mdev pointer directly on the icosq structure.
This provides better separation between channels to ICO SQs for use-cases
where they are not tightly coupled (such as the upcoming nvmeotcp code).

No functional change here.

Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h               | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c   | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h          | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c          | 5 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c            | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c          | 4 ++--
 7 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 43f027bf2da3..34be754f712c 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -557,6 +557,7 @@ struct mlx5e_icosq {
 	/* control path */
 	struct mlx5_wq_ctrl        wq_ctrl;
 	struct mlx5e_channel      *channel;
+	struct mlx5_core_dev      *mdev;
 
 	struct work_struct         recover_work;
 } ____cacheline_aligned_in_smp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index 4358798d6ce1..9cde6ce17992 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
@@ -46,7 +46,7 @@ static int mlx5e_query_rq_state(struct mlx5_core_dev *dev, u32 rqn, u8 *state)
 
 static int mlx5e_wait_for_icosq_flush(struct mlx5e_icosq *icosq)
 {
-	struct mlx5_core_dev *dev = icosq->channel->mdev;
+	struct mlx5_core_dev *dev = icosq->mdev;
 	unsigned long exp_time;
 
 	exp_time = jiffies + msecs_to_jiffies(mlx5_tout_ms(dev, FLUSH_ON_ERROR));
@@ -91,7 +91,7 @@ static int mlx5e_rx_reporter_err_icosq_cqe_recover(void *ctx)
 	rq = &icosq->channel->rq;
 	if (test_bit(MLX5E_RQ_STATE_ENABLED, &icosq->channel->xskrq.state))
 		xskrq = &icosq->channel->xskrq;
-	mdev = icosq->channel->mdev;
+	mdev = icosq->mdev;
 	dev = icosq->channel->netdev;
 	err = mlx5_core_query_sq_state(mdev, icosq->sqn, &state);
 	if (err) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
index 879d698b6119..cdd7fbf218ae 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h
@@ -62,7 +62,7 @@ void mlx5e_trigger_irq(struct mlx5e_icosq *sq);
 void mlx5e_completion_event(struct mlx5_core_cq *mcq, struct mlx5_eqe *eqe);
 void mlx5e_cq_error_event(struct mlx5_core_cq *mcq, enum mlx5_event event);
 int mlx5e_napi_poll(struct napi_struct *napi, int budget);
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq);
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget);
 
 /* RX */
 INDIRECT_CALLABLE_DECLARE(bool mlx5e_post_rx_wqes(struct mlx5e_rq *rq));
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
index 20994773056c..3c6c5a4692a3 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c
@@ -267,7 +267,7 @@ resync_post_get_progress_params(struct mlx5e_icosq *sq,
 		goto err_out;
 	}
 
-	pdev = mlx5_core_dma_dev(sq->channel->priv->mdev);
+	pdev = mlx5_core_dma_dev(sq->mdev);
 	buf->dma_addr = dma_map_single(pdev, &buf->progress,
 				       PROGRESS_PARAMS_PADDED_SIZE, DMA_FROM_DEVICE);
 	if (unlikely(dma_mapping_error(pdev, buf->dma_addr))) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 26a98cfb0a59..5740772a7b10 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1501,6 +1501,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -1899,11 +1900,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
 static void mlx5e_close_icosq(struct mlx5e_icosq *sq)
 {
-	struct mlx5e_channel *c = sq->channel;
-
 	if (sq->ktls_resync)
 		mlx5e_ktls_rx_resync_destroy_resp_list(sq->ktls_resync);
-	mlx5e_destroy_sq(c->mdev, sq->sqn);
+	mlx5e_destroy_sq(sq->mdev, sq->sqn);
 	mlx5e_free_icosq_descs(sq);
 	mlx5e_free_icosq(sq);
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
index 8d9743a5e42c..addf8905fc35 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_rx.c
@@ -993,7 +993,7 @@ static void mlx5e_handle_shampo_hd_umr(struct mlx5e_shampo_umr umr,
 	shampo->ci = (shampo->ci + umr.len) & (shampo->hd_per_wq - 1);
 }
 
-int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
+int mlx5e_poll_ico_cq(struct mlx5e_cq *cq, int budget)
 {
 	struct mlx5e_icosq *sq = container_of(cq, struct mlx5e_icosq, cq);
 	struct mlx5_cqe64 *cqe;
@@ -1068,7 +1068,7 @@ int mlx5e_poll_ico_cq(struct mlx5e_cq *cq)
 						 wi->wqe_type);
 			}
 		} while (!last_wqe);
-	} while ((++i < MLX5E_TX_CQ_POLL_BUDGET) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
+	} while ((++i < budget) && (cqe = mlx5_cqwq_get_cqe(&cq->wq)));
 
 	sq->cc = sqcc;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index a7d9b7cb4297..fd52311aada9 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -178,8 +178,8 @@ int mlx5e_napi_poll(struct napi_struct *napi, int budget)
 
 	busy |= work_done == budget;
 
-	mlx5e_poll_ico_cq(&c->icosq.cq);
-	if (mlx5e_poll_ico_cq(&c->async_icosq.cq))
+	mlx5e_poll_ico_cq(&c->icosq.cq, MLX5E_TX_CQ_POLL_BUDGET);
+	if (mlx5e_poll_ico_cq(&c->async_icosq.cq, MLX5E_TX_CQ_POLL_BUDGET))
 		/* Don't clear the flag if nothing was polled to prevent
 		 * queueing more WQEs and overflowing the async ICOSQ.
 		 */
-- 
2.34.1



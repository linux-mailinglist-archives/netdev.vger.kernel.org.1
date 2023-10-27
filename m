Return-Path: <netdev+bounces-44751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5237F7D982D
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 14:31:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14444B2133E
	for <lists+netdev@lfdr.de>; Fri, 27 Oct 2023 12:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 114172AB47;
	Fri, 27 Oct 2023 12:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="D6ZEpLiW"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A03B1EB2A
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 12:28:57 +0000 (UTC)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58D6B1B1
	for <netdev@vger.kernel.org>; Fri, 27 Oct 2023 05:28:55 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=f/c8YLAjA+ZUnos80Uy+swY6Tev1IcrZ4MxE96ZaRSpPo+VE63+7N5D4dXiJTnlYOX/bbYHoGm+dFupDuWgUmreE8X/xkV21h/7fqTF1n0Qlx36NosTtEgZHlxh5iWFV4AZCfAqeqbGMgBCMmIJ+zbMCHi1BsQmIYlpRdALqNo0cOLLd/PS6L6ifzyfvgj10Wvt6euzgTMuefhQ3nV4yovHIYHfAuZ0X/qKLmmaGoqMEGHKSYP/1E47/6KV/SLzip4h10VOtm9U7rBIdq42BPMk3ceSihwD2RRZ7fTou77LWPjpfyGEYlmgiFDoKAlsLVj4LMIoSAuHPsT5sIOennw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yrfBrm71oCXSvhCL0E4JO2MlegGvxnrMPPGQly7sBdM=;
 b=lBiLzL4JzHdim37WPTbSU4qGuGqV4FQHiUuAvdmAZDksnCcYAcnYnO4VbvJdrfTv9V7iA8d8w5SSASHm3JNImHKHbR3Al204ZxLOEUYRNESQ95wlNElmR6RAFI/OR73imNejPxLPbdvM9BlsYFsSg4tk1JD0aLjB6N2I8dQVOu6fZBwnKSOXg16xOtxUjEdG7PjCY+mSGnE3Aup42HWM0iGLl8uArL9J1y9+eWAIa+gkghHJSggNT7u1ZadIB3EqPJCq09nY1QP3BFM7Io6g+17GcHaWLEDRrcrzKqW+d/aWrKx+cgOIIllsX82HgYEY27Mt7KFLgkIrCHjjbW69tQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yrfBrm71oCXSvhCL0E4JO2MlegGvxnrMPPGQly7sBdM=;
 b=D6ZEpLiWTJxL1A0Y8Je9PBdZbgWrI0YrbXY63jqFTEJRJKP3PLFdPLq0bv+db3X4ES4Y2U68WGUAZnIC1LHeshPsaE0JA9IAYITqSxKqSjZYlWJWMSMZaTgOAhrWLnph6A5yMOKLRCG5+Jq17U5dHjedaVqsSTEHtsQNpIIxIu7egs0Vk/9eRVQiZXVIp0RLw741oYS7PFkTzf9i9DZzkeGTduuZoCl1CXDVlgJZaBLtfr8eWmDNmZNEeTJHI+gr7Pv64PhY1tjcPKW72Op6T4+y5P85frSPgNzZt5navTrsOWH1wzqubCwaqKknkjojw78Lu21bAlb3czQax1oDAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SN7PR12MB7131.namprd12.prod.outlook.com (2603:10b6:806:2a3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 27 Oct
 2023 12:28:53 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::42b4:7f1:b049:39b2%7]) with mapi id 15.20.6933.024; Fri, 27 Oct 2023
 12:28:53 +0000
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
Subject: [PATCH v18 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Fri, 27 Oct 2023 12:27:46 +0000
Message-Id: <20231027122755.205334-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231027122755.205334-1-aaptel@nvidia.com>
References: <20231027122755.205334-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P265CA0143.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c4::19) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SN7PR12MB7131:EE_
X-MS-Office365-Filtering-Correlation-Id: 8747e795-2ab7-4cf9-8616-08dbd6e847e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rv1llT9rttM1tKIN2m8+2H9rH1BPl0fNO1hR4wq2II+Gd2NkwKfomMGPkYv0pY+yMA251GmbdCEU5Fw/A+jE5JNv1vDKjjBTSoKLZ5JphKKLjOH6QR+xmlvtAE7Oxi3KNfuw3KYu8vvwuDGLZyZH/wTs3QPLmgNjKG3vVwOqgfSkTYIQA2cbabEaBHZaeELHI2enWXLto2ldj3HTh2vPFmjhN67ex1Cx8o0ghk9X3MTHppBZjEG1jbTM5vfkNegO6djJGvc5/5yn4cxZz89VaiBqwoIqo67tqx2b5xNnFiQk+9pilTccs+DK02pqpvCJ/8pXorLupg/8qUOXfgyycPtrEihDdUWIwvlhf3gjB9Ll2FsOO/cfyqdjxRKjm8DNpi6Mm28rwt5DO6Sibiiuj25lWIFliEEVhDbwr0S5laeSRZnXL6ndvIp5c9t/fkU2LEEJKzeYjee8uz7zWjmrIoD4p2Ie04j+XQ1uaS7cvlcVXHmNY2GVI0hOe+RIVsvfaYyhOt5wMknORNy5oJGLuJVbaCG3I0l0FU6mGYcyrPP4UUhnYLJwUZEO6EqVuZOS
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(346002)(136003)(366004)(39860400002)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(7416002)(8676002)(66946007)(66476007)(316002)(6486002)(66556008)(6666004)(107886003)(8936002)(2906002)(478600001)(6506007)(5660300002)(83380400001)(1076003)(38100700002)(2616005)(6512007)(86362001)(36756003)(41300700001)(4326008)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?5Ja+n4Q4ZS1K78XastEjf+nfy+9MbyxLkrfto8VRXX1i4937ezpXBpUtPRd+?=
 =?us-ascii?Q?OX0lYdZPkxMffdR3oUoFGiAo3uOeq0/neulLAT62pZZw3EVePnNysLSigeg3?=
 =?us-ascii?Q?Q9TaBOWjTnnWI6frfiIwgzKsIcNVSm801AtfD9ut/dIAwP8Jw1CLNOs+b+Cy?=
 =?us-ascii?Q?vzkMvf6ggvqiGctiPn5Q5vUTUMNJbck5aXBMKhFEFco2TacYWDCnFsvqpPr6?=
 =?us-ascii?Q?A9763wTfY8VYwZ3kJjVULvwj9iTagFgh1gMdFxx/kmEEEs7VGy4PtJj9BdO4?=
 =?us-ascii?Q?9OI462NA8ZSg132MUSpl0jnns3ugcRU7atpAE1lBwG5iReUpKuML40espbXm?=
 =?us-ascii?Q?bFwXZBZsgXwcVKns67CkrLyoYcCK2ghgn1Ff+pyf0lWFoe68FlkVjQ7Sr0Te?=
 =?us-ascii?Q?MUxqIz82qJrkyConUqVCXvc1AlY5Ki/DP2YQjUwjNL3nYRp2N88Gq/0n8KCX?=
 =?us-ascii?Q?c4z/fHck/AvWVVM95AsXEchpU35IW/3fxTNNcxu3VzFD1NzWa3hszRS5Nh1X?=
 =?us-ascii?Q?7/r8vdkaQwt3VuGeDHBgJPf0lU9gFLl8144ybiaUmbzsSKTsx7fKiBbAxj2U?=
 =?us-ascii?Q?Yi/4a3c4rJVCM0qvyDNKTwFPYit5dC7vDyhlKJo3YhpsKshiLre99xNhiyeQ?=
 =?us-ascii?Q?+XFUESe/nbYCBpW0phffb+8CvX1h7r03CDEI7twmCaOc6qGERy2v2DXRmyWO?=
 =?us-ascii?Q?lhuntZZsFb7yrhU+2nQmyJmJA89KSNpSepN3ZB/XTyrsHQmrWSrv0rTn7S4B?=
 =?us-ascii?Q?BmQbN9zqTv7bsR/Z+ZRiSrazOsgT26GcpBpYzaOloxqz39/Uz8xnw9aPf+jH?=
 =?us-ascii?Q?gn/X9lJvSxa+ImqjCCQtGZSH4U3w2DleMJtVTeHPdm6lGAnb8mUyoWUwnoKN?=
 =?us-ascii?Q?cwbGBvhEv7vYyxQcwz19nUcO07uptMuZLyv4eGWmQ89aXSZY4B9tCSKD/xgg?=
 =?us-ascii?Q?NtHxgzBaHoLW2QPF/B5SNSt4X/VRYjw9hiRWh/tUKv+lT3xptDzxi9MjVMir?=
 =?us-ascii?Q?H1jpnhrmgHqVrkdKswf/3O2qE8yScINjZefGVnUuVvzNfetw80QNHVwRQLAq?=
 =?us-ascii?Q?ucmrUKh4kpuDg+56zw3xLcpgjPKK4lNovPxpxyDHyItdc0rzscCPYOQnJptA?=
 =?us-ascii?Q?Q0VR+HIthcwPCzNzMfgCE/dgn7OiUajF2qK165uAU59DFdhY4h2YkpAhXEK8?=
 =?us-ascii?Q?gm3J3gaQQIb96kFEAsj+VLCFLGyij8TvjP6BHClI4srQs2eb5T60ZAmHbsaB?=
 =?us-ascii?Q?0qVZh7YHy9YuXYjHeV07SZCrRZUPXtKiQ72wZhpDedTXKLS2VYZrq/T4hGky?=
 =?us-ascii?Q?Q1yfX1HbS/lztQeU16w9VlNX3dAoBEyuegwVkGShwF+EtGG2mSi+L+te8r6l?=
 =?us-ascii?Q?X6pIwhTfRbEAtGa9mFNINRvMDjdeXWEFxUp4DeJcD37gRAmCSHUbnbHjH/KS?=
 =?us-ascii?Q?PNF37CHkyHpK5TuL2sKwqacrimEwRzc3kCcMAQObxwPRHMzh86RuKSPhC+2X?=
 =?us-ascii?Q?SmCgtUuSM0Jo1CFx2jyr4NCb/7ejkw3RI/GjCIA5c2FealQtpQMqM7aq9TU7?=
 =?us-ascii?Q?oNVOTISSKQ0Z5bukBfR/AZB/vyQxUNMI8QpthhvH?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8747e795-2ab7-4cf9-8616-08dbd6e847e9
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Oct 2023 12:28:53.1458
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lOdnXykqx+6MXRkxTJuE1/iaSBlMk4TKm+rk4olWz0ylJwJb6Z5Zs+aaLudWd6KnQLcyaVzgJ2vS5I94tkHKOQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7131

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
index b2a5da9739d2..1e1d8f3d2b24 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -555,6 +555,7 @@ struct mlx5e_icosq {
 	/* control path */
 	struct mlx5_wq_ctrl        wq_ctrl;
 	struct mlx5e_channel      *channel;
+	struct mlx5_core_dev      *mdev;
 
 	struct work_struct         recover_work;
 } ____cacheline_aligned_in_smp;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c b/drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c
index fc5a9fdd06db..9ab0b036ce92 100644
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
index ea58c6917433..9ae4c4213db7 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1500,6 +1500,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -1898,11 +1899,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
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



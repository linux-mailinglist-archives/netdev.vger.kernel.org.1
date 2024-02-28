Return-Path: <netdev+bounces-75719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A80EB86AFA6
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:59:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D5F72893C3
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:59:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60F0414AD24;
	Wed, 28 Feb 2024 12:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Z/culZm1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8425814A081
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125129; cv=fail; b=nbIb63QPoih0/Vzs0FW1vZgCoyaePpPk7hPAgu/stIKtPO0ibRND4VsZt3ZBCtZ6kv7Lu92MC4CRjzGQXbvEOX/n/7PyEnvMFnLS/f2gxwXVozDfyY+6uKjW7PFXXNDmVlmf+xy9EpxH407dOg7igY9P8S/O5EwmSbzzMbhlkI8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125129; c=relaxed/simple;
	bh=G4tg3p0PhmlQGKSKIsiKfoQ6Qi/0TG8zc84ii8dgLS4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JkcVa8lZg1XefNmxlMmjuZHBR5237PSqHUSHpcY+nyLE0RDth6ZEpV5ijuPiuCMqcmZJb3jSFrCsG8hjk2oNIyTXkqh7bBzF1mKdsdfH8KfeqC+1lXHtljfOde+RBFjPRiOcDL1CH2PId3KGCMRN2yzU6alolTpIh9aH8aEy27c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Z/culZm1; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eQbwHXB/NOFCLE3u11i4LBlGUQoxVNVEcRaCxfoTrOOjyno/41UoqdHaKRpBkjJvhWfOVl+nkgseAu0woJX2GaUW6qIkoqmatZx4ujbGPrMt/W0e5+UechZq/sQIkdaNz62PHPNNddDoDLe5cmJS6VvmJzXclh2Y3anDdiJ73z4lTCIH6+38urjDYA/lfXQtgeFqg3QJPA4XU115BYA007JTg2/UAMz3Q3QX6i9jYIf6Jbgqz8Kw2SqZ7yBB/4veZXLO1lm8jwiuGXJNx/krNuqfvhzU3Jequub6eOptFkmBJKUhDBmuVl75pFrCzVFnLIgwJq1UusFyrI8GwjzjoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OuGh3Cu/0s5UODkQpuU5t6sxs9SmT8bXd3q3YxzoiVU=;
 b=ZDkp+Ssvzj87w6cT+hMGkersyMV+Uv0lM4cYvLtBMSAlJ0kayRczYSJeOWy+6k4TBx3oQJIRMReXVfrXqW2Gv/FU0cDAs53ia4utB7dGNzfC4IJUrU4ppaY0fBFXog7SsvF8MtaxZOZjyZ4dUT1ie8287cdbuh6vwAJMt1lTASnTb8REzI0FjBNjqChLG/V/WpXf7T4hxU0S4buBfro8tYqvfAeVoGc0ePQ9Es+33FI/RG8liIlZnwmJQXT5NXt8vPrX2Vib1lSuJYEe/B6jIUZXfMVwH764NuN50FlL1IS9+1/7ZMhJM4NNGKZVENdDNxDh9UIY9nsMRltfuLVECw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OuGh3Cu/0s5UODkQpuU5t6sxs9SmT8bXd3q3YxzoiVU=;
 b=Z/culZm1gP5D/p0HhOzwO/eNCH2tykbcvVJKdcWBqy7carwJEMGJMciqonBc9AKRYhyh/om072aYjYNYijFFuny0kExxhXSUmSzbG6VP44Z1QgKMbSZAih7b7RPAlXopSDELy5HWzkkKw4YdKMDETwO8+yMq+9IP6xIJW7mbjFcz6p0tHnQnfm8f1grNV6L2eCdV1Dm45N+VTGCBC50emOFUDxKujl3m4/uIM60ugeONrVCCPqGTynO50QQUcXCzJ8t+AQ0O4XiYjn1Ne2l6u1CFhfdK5chxzyQjSaNRQyA8t/eU7eo7/KcA9yFvpSc1i2i0zpI8P4pet68Oh1/WNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by SA3PR12MB7859.namprd12.prod.outlook.com (2603:10b6:806:305::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 12:58:44 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 12:58:44 +0000
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
Subject: [PATCH v23 11/20] net/mlx5e: Refactor ico sq polling to get budget
Date: Wed, 28 Feb 2024 12:57:24 +0000
Message-Id: <20240228125733.299384-12-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228125733.299384-1-aaptel@nvidia.com>
References: <20240228125733.299384-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR4P281CA0321.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:eb::13) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|SA3PR12MB7859:EE_
X-MS-Office365-Filtering-Correlation-Id: 88648672-15f2-4f7d-6b13-08dc385cfeb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Phm6Dm038yWq95i1kIo8oVhqdXiGFi186+99yrwf4qYKo+7dDaoSPtu9XNPnt3Vn1CMuRV3nwk4CkVyJOgJPt9wVtXAna0ky0kHSu1NdKqWD5O1b4yrEqITyFYmyCeTsNBMjLL3gm6Sz5AnLqDZ9hp5HXyIgTcmCLkeinBi0ssBbnh0TolhoazcZJWZwBb61LTPMAe2Vdk/cKCuhvPRx06Q4oc4mp2Z6sFoNu3HG4buVDjLBY6YQn4EpKurItloAyLMEXdfBU1WOh5PPqZvDClWx2evBXGwRxj2DCOJXyQ/LUCZb1nS3IGts9sqiEC9IbibkXFFVsTgbdshaD/oyCYD96mnbkN6yjilPg3veumUQOyradQEI7E06fkRG/+Ogx8dQ4a2+IMi1YU9EQcCx3CnVWQ3q9iXPDf92yTVnIafkEYoEEpjxWuABsIH1AIW2tGJm/AYhxDlG24PZfkgZrxV6NcoTcwgnu0kr/ETy0KnZnjU3tggAiS97wkkVzXDWw9kmU7/HxU1cl3KIpRYfSR3m+/EvhMyhdVlNlNCSFr6DmN7dderjxXY+jA8Tssy5VfMmwIzSf09uHwqi36AnwDqOl3panZFaFWrkCSrmDwWDC1PRJnRberL9A2v+EfUDL0XblScr4bVNZOZJ4dQqYg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UMcMlUfr43g/x+Oc8OgsN4Ckrz9pU2LbJ5qx35NCrAPPFo0mPq6n8ycgLNot?=
 =?us-ascii?Q?GKvYJmE2tfHVTdzH1fuWEED6y9z6EfaUlUvPYn5UovseVo0m40ahnwjqIfpf?=
 =?us-ascii?Q?BNgYtId8yzptAuHELfOhaRydTTQY1p5r/5DXoQXrVsDuRVL0FiQRbDwFPd8i?=
 =?us-ascii?Q?HHHfpUas0XcQZeD5wlEjJq3txQLdHsEaUw4hTS1iHD2tmYOSEXZ0KcQue8Fn?=
 =?us-ascii?Q?83W/QZ54Em0+EmMCUJ714CCau7nS5GOthlROXeJyhsSbxvHkMhgOrpHx04x+?=
 =?us-ascii?Q?LeZsQ+A3supqzbjxy+tKHEM2VyXP0l8rimCz7pdaD4kHs/dzq3d8g5jxyZ2q?=
 =?us-ascii?Q?yeOiBD//v97OV3abhmOFu3gf1v+qypToSgDnrnAtUPOtlNEX1TumdM9FcUOa?=
 =?us-ascii?Q?qNEScHwSDCW0skHkRx/rjHuSHMzB3whwVuhp/YvZgeCzsYJFMzj/bf2NL8Vk?=
 =?us-ascii?Q?pYHJyprttW1H/KFddPJPoSgjqxR+1nBoThzBsYOXW6njCIYWK5+VaJtpcCvs?=
 =?us-ascii?Q?b5HZdjBXH6oGwN1BVd2hwWGjbA+A2DQOTcGLKHa3GfyAWW61aJJF53oQyQDg?=
 =?us-ascii?Q?TOqlKfbEPHsKJt7zxxvxkgAwzp/8HCpWuEzAzuc7gvrw+j+R+hlyxJ2Maael?=
 =?us-ascii?Q?LT7nNbUeBhu4wbG5ZMTYWfaZNErN4RueJIT9ENnSf+L83i72JdjvmGD0CvWq?=
 =?us-ascii?Q?ON2ET2mHtLRfuh5/s6SzutyLnz8KzxTs2yHlsL+oL7uE2F9cqAosM5Dxqey7?=
 =?us-ascii?Q?rZeT9Weua75zQitodjvG16PGbxPp0fLmbn8Dml7nmd6EfakrYJragwO87fSp?=
 =?us-ascii?Q?fWRLt+nsGGXAqT7iwaOWYm6t8sosfkO0OSGsUU8AZpOj3R+HhtKCXOQI4p4+?=
 =?us-ascii?Q?QarGTrch8KIzfkge2nyAyHhPvVxZBAW9seAzB4lh98vnRl77KoVJEoMtEDWg?=
 =?us-ascii?Q?wrA7hMYrBdwvLjpG2LX73aP9zLcL7MuL42K2npzzzEvyST6CIaLmuuSlzUIU?=
 =?us-ascii?Q?wlcDb/cU6MCRxmmQX++01uw/JRKsuPYexS+Ywns3Wji3VabbtwKSNMF0KU9k?=
 =?us-ascii?Q?LlrI0PpEt8HbKutUVsqKlDjCPhYoKOoYfQfAIiy9cMXrCZJGEd82PM9m/ukx?=
 =?us-ascii?Q?Jx6ZuNjImth+ZBvBBRDu5md2IaX6Ma1nw+XPJ47uUcBOvn16PHW38iKDOx6X?=
 =?us-ascii?Q?qTWRMyXWA/3NIqErspI4usH7pzYXaZhDZwCstJmN0ERT06Q6Smya/hXDQcKB?=
 =?us-ascii?Q?0cP2xKAtWVJRQ/DMFOq4cCM2mUWdY4n5fvxpKcGgV9i170xBbeUllSCZz0kx?=
 =?us-ascii?Q?s0vKpw6MPLci/6FGxx+/EG14+Bhy3WEQOmgdByTqOGe3uSeBgU2uP79Nc6Kq?=
 =?us-ascii?Q?iXmmcWHUfYDF8YAM0+uLUVbej2fzAVSY+gZUPB3UsWbV4T11bCWbWRC2aLBR?=
 =?us-ascii?Q?2CdTva++tOlXhqOvpeAV5X8ia/f4sjyATpiZ2TBTGmIECKs81n6dXn1FhgqT?=
 =?us-ascii?Q?ko83r244K7ZL6wzQk9+Creydp9S6kwhIHyNsj05bKdDIhidvaDnCCE8MIaxg?=
 =?us-ascii?Q?UJZE/HFpjGIWAQQSDK8ane+Vnidui346CXTc3TNE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88648672-15f2-4f7d-6b13-08dc385cfeb6
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:58:44.2310
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q1v3Izde5kTqJW4m2rvHEKzcTrSH6OZ0EvEIx+Cs8bsO21w/dcDNGtOzNCDJBZQpy5kzAiUmPXT9sqP7aZrJeQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7859

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
 drivers/net/ethernet/mellanox/mlx5/core/en.h             | 1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/reporter_rx.c | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en/txrx.h        | 2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c        | 5 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c          | 4 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c        | 4 ++--
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 55c6ace0acd5..714af3a451fd 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -556,6 +556,7 @@ struct mlx5e_icosq {
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
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index be809556b2e1..039fe9252c4d 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -1512,6 +1512,7 @@ static int mlx5e_alloc_icosq(struct mlx5e_channel *c,
 	int err;
 
 	sq->channel   = c;
+	sq->mdev      = mdev;
 	sq->uar_map   = mdev->mlx5e_res.hw_objs.bfreg.map;
 	sq->reserved_room = param->stop_room;
 
@@ -1912,11 +1913,9 @@ void mlx5e_deactivate_icosq(struct mlx5e_icosq *icosq)
 
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
index d601b5faaed5..780902f63823 100644
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



Return-Path: <netdev+bounces-75728-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FEF86AFB0
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 14:00:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CF98B227BE
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B4FA14A4FB;
	Wed, 28 Feb 2024 12:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JrAPVVxg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3607149DE0
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709125172; cv=fail; b=hb2RhluqNmW34YkAKbmvElVWkWi3zJU4TZ0DyYy4gar9ULpIFO5MATRx4jjbbMQ6IKjb47r/NrEQp2tgaAnhDFnAXTAub+FSLdDp0Mxsp11A7llzmEWZ6df3tJOd3nJ8BqHEDUfktjq8YreTvbzrV6HWbM5SqVRYg86k2E7xqWs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709125172; c=relaxed/simple;
	bh=um3H+6mFJfNTRqDQGlZW5iGjeEESZNQPApZdKLjpORk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=VrP9Kb1a0Srcm8qyoDUx/B5sd0gJzGndG1Za4CsRjYeS+89PLWuZa5iOfd9tGcizxbymXcVZNw1sO3E57HP98jPnTStRQS3kyi8o0+VVMMmcIEQZLPGszz0pUpeQGiNJ9MA5Y7L3aM2F4CH3uLFVR9HQESAO3OmDV5UWZ2Waico=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JrAPVVxg; arc=fail smtp.client-ip=40.107.236.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IfsA8yAz/PmaFJYC9Ln/8/9+a+khFP5OapBvFSEQ2WuPF+enO4UTl7gvV9sM0EEIz4JZKJ5oLzu6a+W2XZA1+/PbXDGe+/noVLinp0EYZxUFkFrmmQTJeGp4nh2zon2+9VvWzXX+TBmKxccNXLLqX4ziVWQeTV5YxMPGEoa5OwXba24ruzksebHOMuVxsWxHvSRSKH/66BkxpxeUeNRZPmYorAjTCDv1lH/X1ix9AFX9i6qbD4uw1j/EFWtqImhkfyOMTvqFrG/OBwuFDUvfAPlDGYQvDfPxf11llh2ThxhtFVuNFp0tnM3mgFDYLnwmvKC7NIh4vQnPW4SZrwMXhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W/cMAj4fCG8px+KutbWnaID12s/o9F0USET3ZHcJNfs=;
 b=YX1JFw256LRwRR0pj3ySo6O3of78QWUqZJCLjorFps5YmmbIMl7S5iguj2BD0syvzcZ0CzCAnPg8rciJ4Fa8kSfHTriCu0UNPcmDQCqlKAf92til7q2Z6SSOtavvMb2BuYdKdJWEEIiwo37d4s98VKdB+A/IyTX3NGo+qngMezLT4owUIKamYOLzHcDZQS//se2Al7dXNxgbGFv4kvWnXLb6a1lZAWdJmX+ajOUth3asqDJa+XderrDMHHXb6TYuG0Rd991xd1Vek8b2M19Hr0uf4TGSwf368YNW70JxkCePLOOUw4yVgEbm1kgSPna5wD1PtUsS0U1LEFGFQ/T62A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W/cMAj4fCG8px+KutbWnaID12s/o9F0USET3ZHcJNfs=;
 b=JrAPVVxgWFnYedOWApXIGynmg/EGt57vy+uwRzrSI0/MBmz2ru+1uq6v6mCce1uUZjhBXwt/+C+5uBaUYMWNbVBRTnFIea8J5buuwM5sCqiBlC7whh6RhZAKGw7bTU4nTaqPfkrVJEEKg2VB/qreVrTcb6J3h652piUJ7PyDuRAJXkHfyNI3+vN1yckdf3YtcA6SAbsVCgppHCX8Y+F14q/gZ8ps2GEKcmF/TOK+I4gsa3UWWama3hfJoY1+xAhXx9aXqc0fTixJ2qrRWLsQARbWl6KcozyH6WoqdHScMXMbYbl1/m4f93iMwkKQcUqklYgxGoRxVLS1bzG6Qn0OJg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com (2603:10b6:a03:45e::8)
 by CH3PR12MB9218.namprd12.prod.outlook.com (2603:10b6:610:19f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.36; Wed, 28 Feb
 2024 12:59:26 +0000
Received: from SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463]) by SJ1PR12MB6075.namprd12.prod.outlook.com
 ([fe80::aa05:b8a0:7d5:b463%3]) with mapi id 15.20.7316.032; Wed, 28 Feb 2024
 12:59:26 +0000
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
Cc: Aurelien Aptel <aaptel@nvidia.com>,
	aurelien.aptel@gmail.com,
	smalin@nvidia.com,
	malin1024@gmail.com,
	ogerlitz@nvidia.com,
	yorayz@nvidia.com,
	borisp@nvidia.com,
	galshalom@nvidia.com,
	mgurtovoy@nvidia.com
Subject: [PATCH v23 20/20] net/mlx5e: NVMEoTCP, statistics
Date: Wed, 28 Feb 2024 12:57:33 +0000
Message-Id: <20240228125733.299384-21-aaptel@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228125733.299384-1-aaptel@nvidia.com>
References: <20240228125733.299384-1-aaptel@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR2P281CA0144.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:98::18) To SJ1PR12MB6075.namprd12.prod.outlook.com
 (2603:10b6:a03:45e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PR12MB6075:EE_|CH3PR12MB9218:EE_
X-MS-Office365-Filtering-Correlation-Id: f47e5f90-a5c0-4ef0-3175-08dc385d17ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ofV122dRqm0+vsKny5VId0qxr90SgVBI5yebeIKNqhyJLGTv8A25LpmpJK6qucbevj7gAb2O1fPc6u/DjudGO3aisTIGVT9F0OTZE3ybIiQ+b9dBcDjuToq+gkuwTbs9SBydQ271IM7ESt0v7SLxzgaARhZtU17va+eDtfCNGJZjUb0wmA7qwWbN+1l0F3yQlfFyzX2TaFpaJkbbQbfEV4K80xqRe45RnO1qtjx+rQjdpD67cqdGzQiTk6gDKZcdjQM+8MNl4blwYoh0kyJ1e8emy3/nrqrGFX57ubVaEuaN8Df/4zbRGlVQ3TGEVYvrlX6k57f87sKPxXBR83G1pJo3LSdZxuAm9pYHgB9hXGJLwS750lj37mQs0xdzuI+vuhXBY29H68yKcSRDq/Fk3xpGAwmUt74ynNOwo7O0BXn13RUyNV0hRj7N1DwhzJ/sjqumXqTlJUMYH9i0BzLSzq/RgqdsRNCiUKTku3bxQdtI9gsvonT1wLFglSnGlqYHYb6V5KSLGIJTDUx+Iu5/Zk8DFvDXmOSppx2EAsPvDj7PuNru5xwIGMLYBaLCkUv8fgktXbbkTOi4QbzziwpDT+L4QicExjWrtrYR2uujSKIXJFH7OnxYcfTZ6rtwPDv+nCYIvOiKvTd091T4/DdxFA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ1PR12MB6075.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?NOyqYssilAFW7O6K+niTX8NQ40iYQahf9LaWXUfTb2aH6fDMZ9cznFfI4tS5?=
 =?us-ascii?Q?b+NOoJU0VtZuzoXhqULx/Mkr0CliX42mGgEyurnvK0oRdE306/SH12c2SlVs?=
 =?us-ascii?Q?nYEG0a8luajaT3Oj3K2X9tvUCAOm1+fEseAJfy1ZjHFbEUm3QIVbRK2sFxyx?=
 =?us-ascii?Q?VcO6hKqYVB2w4IRe9P4b0sNssZ6i4GRfbLih/dOhbBce2bIAoKfuC29B+Z5p?=
 =?us-ascii?Q?0O1hbg35v0uIIKOHzm4BxYIYLdtUcTVaqBT4kPcgm3vvmtFoiplsiJwR0482?=
 =?us-ascii?Q?h1f8F3dYCpMsRGO/iX55naXW3lCBqTgvQK1DEZpANrspil5s5pVPI2ykmBCV?=
 =?us-ascii?Q?B/GHU2+QVVQIXJy2ifPDgBNoqNwHUnUGtWOhfbzS7WTDC9WLB4erQmwJh8d0?=
 =?us-ascii?Q?34lcDu3mA4G5dXfHIt/bzXGp02KFACBDVpIZcUTVQoqZSJkhLZi9tTLukEkd?=
 =?us-ascii?Q?xT6r3dhnyojNnaXTpEfQrN3/QViY/n8aJXo+tGyvKeFQUGOTr/4ry8IJWFQ4?=
 =?us-ascii?Q?8cbslMojz45NR8WVi6mAizitNkQ+35d47ofdPpiQ2XSGxehu3aB0Shj+dQEu?=
 =?us-ascii?Q?sO5M6fRShw+6XWDbIQ8TBmNqoNvkMkYGWJv8WhG/kagZPPiI7Jl8lOeN/M5n?=
 =?us-ascii?Q?L0gw3Os2pvXrbXwJRxxvwd450V3thdzp3Vn3nlWt6DsttQCi9ofHiJxNKYFH?=
 =?us-ascii?Q?a2J4B/HfeYFo4qcULyV1H0A522DMxxsyJhfXgE+XWW9EofGcFsYkrVnb9gOx?=
 =?us-ascii?Q?vnYDmFE4NRKKOOr6Ijh2zHcXD1kdoopNKxT/xMWI3qNM0wYcQJBudTUY6uZT?=
 =?us-ascii?Q?/aYSsDgjzs4eR/VHlBTPWzx2k7kRXy4wfSVg/By9DTSe3pFP6cYaMLyrT9As?=
 =?us-ascii?Q?4KR481wYL7xZ0+HuuLnyWaLUh4pDaYxCTc5d3LQPbImyWka3b6NQMpRqqowI?=
 =?us-ascii?Q?Q8dyOmOtWtUnkCSLDY9VMSmspnCTRb0IcQuOgrJ4sIDUAaLIXb6+WnHq7EpF?=
 =?us-ascii?Q?VLXDTqxcNvy6GPoIUc/xAYgMu+2QNsN7Vf5H9UsHgPM5zeLFviMhde+Iqe9j?=
 =?us-ascii?Q?iqZ05qhOhlpc12Io7E3YBW+R7IOTuOQIx45Wh+YeyLMJaQzPrRZjyEy7L3nr?=
 =?us-ascii?Q?Ski9AyJjUE2fCzorq1TvaK0h0F07ir1OqupHZS4KM2MvuP2wP/Fd680P4jPm?=
 =?us-ascii?Q?MuPVSG5A4lQ67a7Uyng/EH2r3gt3ydnx1lXOgyr5YGn/aRdSm7U2vvXzvotx?=
 =?us-ascii?Q?lYR9fAqGv/va0hZwWUksze8w88IkPqZd/wQqVfHux77Oc89vzyMnByXdPxgb?=
 =?us-ascii?Q?O2FuqTAVlFpp/xsy/e7tAPC8LzjT7/P0SQ7FH9J/qLyNk22uJQnIqohvLWLL?=
 =?us-ascii?Q?VPXv71uP0lmuL+bi3xDPepoO9NbcLrqm4ebFxXAibTc4Djyun21wSgxH1NLL?=
 =?us-ascii?Q?hMuTnHVex5YxvAiDJfRM96f/w+oauQtXFx5C/ZWO62fEGOkKMmhXtgZi0AMK?=
 =?us-ascii?Q?3NEaFcYRnrd38DL1gnRQvLLTOd+8aK4cn/Rk9qp8BoEaCoAz+DN/35jxwhMx?=
 =?us-ascii?Q?FhAQjdZecxeaD9TxR3Rft32bDmpmt45+4sIIM5g7?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47e5f90-a5c0-4ef0-3175-08dc385d17ea
X-MS-Exchange-CrossTenant-AuthSource: SJ1PR12MB6075.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 12:59:26.6776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ImlWKkrtts10gaunMNS7ym6CiLbzrU59Wh/Oul7pScA49wW73OKZo+cN015GIhpG3C66i4ptzMu4NDYMk/bn9w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9218

NVMEoTCP offload statistics include both control and data path
statistic: counters for the netdev ddp ops, offloaded packets/bytes,
resync and dropped packets.

Expose the statistics using ulp_ddp_ops->get_stats()
instead of the regular statistics flow.

Signed-off-by: Ben Ben-Ishay <benishay@nvidia.com>
Signed-off-by: Boris Pismenny <borisp@nvidia.com>
Signed-off-by: Or Gerlitz <ogerlitz@nvidia.com>
Signed-off-by: Yoray Zack <yorayz@nvidia.com>
Signed-off-by: Shai Malin <smalin@nvidia.com>
Signed-off-by: Aurelien Aptel <aaptel@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/Makefile  |  3 +-
 .../mellanox/mlx5/core/en_accel/nvmeotcp.c    | 52 ++++++++++++---
 .../mellanox/mlx5/core/en_accel/nvmeotcp.h    | 16 +++++
 .../mlx5/core/en_accel/nvmeotcp_rxtx.c        | 11 +++-
 .../mlx5/core/en_accel/nvmeotcp_stats.c       | 66 +++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/en_stats.h    |  8 +++
 6 files changed, 145 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/Makefile b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
index 2db0bd83d517..3c4e9a242131 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/Makefile
+++ b/drivers/net/ethernet/mellanox/mlx5/core/Makefile
@@ -109,7 +109,8 @@ mlx5_core-$(CONFIG_MLX5_EN_TLS) += en_accel/ktls_stats.o \
 				   en_accel/fs_tcp.o en_accel/ktls.o en_accel/ktls_txrx.o \
 				   en_accel/ktls_tx.o en_accel/ktls_rx.o
 
-mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o en_accel/nvmeotcp_rxtx.o
+mlx5_core-$(CONFIG_MLX5_EN_NVMEOTCP) += en_accel/fs_tcp.o en_accel/nvmeotcp.o \
+					en_accel/nvmeotcp_rxtx.o en_accel/nvmeotcp_stats.o
 
 mlx5_core-$(CONFIG_MLX5_SW_STEERING) += steering/dr_domain.o steering/dr_table.o \
 					steering/dr_matcher.o steering/dr_rule.o \
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
index 4c49ff9a7999..4695993e128f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.c
@@ -616,9 +616,15 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 {
 	struct nvme_tcp_ddp_config *nvme_config = &config->nvmeotcp;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	struct mlx5_core_dev *mdev = priv->mdev;
 	struct mlx5e_nvmeotcp_queue *queue;
 	int queue_id, err;
+	u32 channel_ix;
+
+	channel_ix = mlx5e_get_channel_ix_from_io_cpu(&priv->channels.params,
+						      config->io_cpu);
+	sw_stats = &priv->nvmeotcp->sw_stats;
 
 	if (config->type != ULP_DDP_NVME) {
 		err = -EOPNOTSUPP;
@@ -645,11 +651,11 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 	queue->id = queue_id;
 	queue->dgst = nvme_config->dgst;
 	queue->pda = nvme_config->cpda;
-	queue->channel_ix = mlx5e_get_channel_ix_from_io_cpu(&priv->channels.params,
-							     config->io_cpu);
+	queue->channel_ix = channel_ix;
 	queue->size = nvme_config->queue_size;
 	queue->max_klms_per_wqe = MLX5E_MAX_KLM_PER_WQE(mdev);
 	queue->priv = priv;
+	queue->sw_stats = sw_stats;
 	init_completion(&queue->static_params_done);
 
 	err = mlx5e_nvmeotcp_queue_rx_init(queue, config, netdev);
@@ -661,6 +667,7 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 	if (err)
 		goto destroy_rx;
 
+	atomic64_inc(&sw_stats->rx_nvmeotcp_sk_add);
 	write_lock_bh(&sk->sk_callback_lock);
 	ulp_ddp_set_ctx(sk, queue);
 	write_unlock_bh(&sk->sk_callback_lock);
@@ -674,6 +681,7 @@ mlx5e_nvmeotcp_queue_init(struct net_device *netdev,
 free_queue:
 	kfree(queue);
 out:
+	atomic64_inc(&sw_stats->rx_nvmeotcp_sk_add_fail);
 	return err;
 }
 
@@ -687,6 +695,8 @@ mlx5e_nvmeotcp_queue_teardown(struct net_device *netdev,
 
 	queue = container_of(ulp_ddp_get_ctx(sk), struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
 
+	atomic64_inc(&queue->sw_stats->rx_nvmeotcp_sk_del);
+
 	WARN_ON(refcount_read(&queue->ref_count) != 1);
 	mlx5e_nvmeotcp_destroy_rx(priv, queue, mdev);
 
@@ -818,25 +828,34 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 			 struct ulp_ddp_io *ddp)
 {
 	struct scatterlist *sg = ddp->sg_table.sgl;
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	struct mlx5e_nvmeotcp_queue_entry *nvqt;
 	struct mlx5e_nvmeotcp_queue *queue;
 	struct mlx5_core_dev *mdev;
 	int i, size = 0, count = 0;
+	int ret = 0;
 
 	queue = container_of(ulp_ddp_get_ctx(sk),
 			     struct mlx5e_nvmeotcp_queue, ulp_ddp_ctx);
+	sw_stats = queue->sw_stats;
 	mdev = queue->priv->mdev;
 	count = dma_map_sg(mdev->device, ddp->sg_table.sgl, ddp->nents,
 			   DMA_FROM_DEVICE);
 
-	if (count <= 0)
-		return -EINVAL;
+	if (count <= 0) {
+		ret = -EINVAL;
+		goto ddp_setup_fail;
+	}
 
-	if (WARN_ON(count > mlx5e_get_max_sgl(mdev)))
-		return -ENOSPC;
+	if (WARN_ON(count > mlx5e_get_max_sgl(mdev))) {
+		ret = -ENOSPC;
+		goto ddp_setup_fail;
+	}
 
-	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu)))
-		return -EOPNOTSUPP;
+	if (!mlx5e_nvmeotcp_validate_sgl(sg, count, READ_ONCE(netdev->mtu))) {
+		ret = -EOPNOTSUPP;
+		goto ddp_setup_fail;
+	}
 
 	for (i = 0; i < count; i++)
 		size += sg_dma_len(&sg[i]);
@@ -848,8 +867,13 @@ mlx5e_nvmeotcp_ddp_setup(struct net_device *netdev,
 	nvqt->ccid_gen++;
 	nvqt->sgl_length = count;
 	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_UMR, ddp->command_id, count);
-
+	atomic64_inc(&sw_stats->rx_nvmeotcp_ddp_setup);
 	return 0;
+
+ddp_setup_fail:
+	dma_unmap_sg(mdev->device, ddp->sg_table.sgl, count, DMA_FROM_DEVICE);
+	atomic64_inc(&sw_stats->rx_nvmeotcp_ddp_setup_fail);
+	return ret;
 }
 
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi)
@@ -896,6 +920,7 @@ mlx5e_nvmeotcp_ddp_teardown(struct net_device *netdev,
 	q_entry->queue = queue;
 
 	mlx5e_nvmeotcp_post_klm_wqe(queue, KLM_INV_UMR, ddp->command_id, 0);
+	atomic64_inc(&queue->sw_stats->rx_nvmeotcp_ddp_teardown);
 }
 
 static void
@@ -929,6 +954,14 @@ void mlx5e_nvmeotcp_put_queue(struct mlx5e_nvmeotcp_queue *queue)
 	}
 }
 
+static int mlx5e_ulp_ddp_get_stats(struct net_device *dev,
+				   struct ulp_ddp_stats *stats)
+{
+	struct mlx5e_priv *priv = netdev_priv(dev);
+
+	return mlx5e_nvmeotcp_get_stats(priv, stats);
+}
+
 int set_ulp_ddp_nvme_tcp(struct net_device *netdev, bool enable)
 {
 	struct mlx5e_priv *priv = netdev_priv(netdev);
@@ -1028,6 +1061,7 @@ const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops = {
 	.resync = mlx5e_nvmeotcp_ddp_resync,
 	.set_caps = mlx5e_ulp_ddp_set_caps,
 	.get_caps = mlx5e_ulp_ddp_get_caps,
+	.get_stats = mlx5e_ulp_ddp_get_stats,
 };
 
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv)
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
index 13817d8a0aae..41b5b304e598 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp.h
@@ -9,6 +9,15 @@
 #include "en.h"
 #include "en/params.h"
 
+struct mlx5e_nvmeotcp_sw_stats {
+	atomic64_t rx_nvmeotcp_sk_add;
+	atomic64_t rx_nvmeotcp_sk_add_fail;
+	atomic64_t rx_nvmeotcp_sk_del;
+	atomic64_t rx_nvmeotcp_ddp_setup;
+	atomic64_t rx_nvmeotcp_ddp_setup_fail;
+	atomic64_t rx_nvmeotcp_ddp_teardown;
+};
+
 struct mlx5e_nvmeotcp_queue_entry {
 	struct mlx5e_nvmeotcp_queue *queue;
 	u32 sgl_length;
@@ -52,6 +61,7 @@ struct mlx5e_nvmeotcp_queue_handler {
  *	@sk: The socket used by the NVMe-TCP queue
  *	@crc_rx: CRC Rx offload indication for this queue
  *	@priv: mlx5e netdev priv
+ *	@sw_stats: Global software statistics for nvmeotcp offload
  *	@static_params_done: Async completion structure for the initial umr mapping
  *	synchronization
  *	@sq_lock: Spin lock for the icosq
@@ -88,6 +98,7 @@ struct mlx5e_nvmeotcp_queue {
 	u8 crc_rx:1;
 	/* for ddp invalidate flow */
 	struct mlx5e_priv *priv;
+	struct mlx5e_nvmeotcp_sw_stats *sw_stats;
 	/* end of data-path section */
 
 	struct completion static_params_done;
@@ -97,6 +108,7 @@ struct mlx5e_nvmeotcp_queue {
 };
 
 struct mlx5e_nvmeotcp {
+	struct mlx5e_nvmeotcp_sw_stats sw_stats;
 	struct ida queue_ids;
 	struct rhashtable queue_hash;
 	struct ulp_ddp_dev_caps ddp_caps;
@@ -113,6 +125,7 @@ void mlx5e_nvmeotcp_ddp_inv_done(struct mlx5e_icosq_wqe_info *wi);
 void mlx5e_nvmeotcp_ctx_complete(struct mlx5e_icosq_wqe_info *wi);
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv);
+int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv, struct ulp_ddp_stats *stats);
 extern const struct ulp_ddp_dev_ops mlx5e_nvmeotcp_ops;
 #else
 
@@ -121,5 +134,8 @@ static inline void mlx5e_nvmeotcp_cleanup(struct mlx5e_priv *priv) {}
 static inline int set_ulp_ddp_nvme_tcp(struct net_device *dev, bool en) { return -EOPNOTSUPP; }
 static inline void mlx5e_nvmeotcp_init_rx(struct mlx5e_priv *priv) {}
 static inline void mlx5e_nvmeotcp_cleanup_rx(struct mlx5e_priv *priv) {}
+static inline int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv,
+					   struct ulp_ddp_stats *stats)
+{ return 0; }
 #endif
 #endif /* __MLX5E_NVMEOTCP_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
index 269d8075f3c2..6ed9acdec376 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_rxtx.c
@@ -140,6 +140,7 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq, struct sk_buff *skb
 	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
 	struct net_device *netdev = rq->netdev;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_rq_stats *stats = rq->stats;
 	struct mlx5e_nvmeotcp_queue_entry *nqe;
 	skb_frag_t org_frags[MAX_SKB_FRAGS];
 	struct mlx5e_nvmeotcp_queue *queue;
@@ -151,12 +152,14 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq, struct sk_buff *skb
 	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
 	if (unlikely(!queue)) {
 		dev_kfree_skb_any(skb);
+		stats->nvmeotcp_drop++;
 		return false;
 	}
 
 	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
 	if (cqe_is_nvmeotcp_resync(cqe)) {
 		nvmeotcp_update_resync(queue, cqe128);
+		stats->nvmeotcp_resync++;
 		mlx5e_nvmeotcp_put_queue(queue);
 		return true;
 	}
@@ -230,7 +233,8 @@ mlx5e_nvmeotcp_rebuild_rx_skb_nonlinear(struct mlx5e_rq *rq, struct sk_buff *skb
 						 org_nr_frags,
 						 frag_index);
 	}
-
+	stats->nvmeotcp_packets++;
+	stats->nvmeotcp_bytes += cclen;
 	mlx5e_nvmeotcp_put_queue(queue);
 	return true;
 }
@@ -242,6 +246,7 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 	int ccoff, cclen, hlen, ccid, remaining, fragsz, to_copy = 0;
 	struct net_device *netdev = rq->netdev;
 	struct mlx5e_priv *priv = netdev_priv(netdev);
+	struct mlx5e_rq_stats *stats = rq->stats;
 	struct mlx5e_nvmeotcp_queue_entry *nqe;
 	struct mlx5e_nvmeotcp_queue *queue;
 	struct mlx5e_cqe128 *cqe128;
@@ -251,12 +256,14 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 	queue = mlx5e_nvmeotcp_get_queue(priv->nvmeotcp, queue_id);
 	if (unlikely(!queue)) {
 		dev_kfree_skb_any(skb);
+		stats->nvmeotcp_drop++;
 		return false;
 	}
 
 	cqe128 = container_of(cqe, struct mlx5e_cqe128, cqe64);
 	if (cqe_is_nvmeotcp_resync(cqe)) {
 		nvmeotcp_update_resync(queue, cqe128);
+		stats->nvmeotcp_resync++;
 		mlx5e_nvmeotcp_put_queue(queue);
 		return true;
 	}
@@ -330,6 +337,8 @@ mlx5e_nvmeotcp_rebuild_rx_skb_linear(struct mlx5e_rq *rq, struct sk_buff *skb,
 				       hlen + cclen, remaining);
 	}
 
+	stats->nvmeotcp_packets++;
+	stats->nvmeotcp_bytes += cclen;
 	mlx5e_nvmeotcp_put_queue(queue);
 	return true;
 }
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c
new file mode 100644
index 000000000000..af1838154bf8
--- /dev/null
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_accel/nvmeotcp_stats.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0 OR Linux-OpenIB
+// Copyright (c) 2023, NVIDIA CORPORATION & AFFILIATES.
+
+#include "en_accel/nvmeotcp.h"
+
+struct ulp_ddp_counter_map {
+	size_t eth_offset;
+	size_t mlx_offset;
+};
+
+#define DECLARE_ULP_SW_STAT(fld) \
+	{ offsetof(struct ulp_ddp_stats, fld), \
+	  offsetof(struct mlx5e_nvmeotcp_sw_stats, fld) }
+
+#define DECLARE_ULP_RQ_STAT(fld) \
+	{ offsetof(struct ulp_ddp_stats, rx_ ## fld), \
+	  offsetof(struct mlx5e_rq_stats, fld) }
+
+#define READ_CTR_ATOMIC64(ptr, dsc, i) \
+	atomic64_read((atomic64_t *)((char *)(ptr) + (dsc)[i].mlx_offset))
+
+#define READ_CTR(ptr, desc, i) \
+	(*((u64 *)((char *)(ptr) + (desc)[i].mlx_offset)))
+
+#define SET_ULP_STAT(ptr, desc, i, val) \
+	(*(u64 *)((char *)(ptr) + (desc)[i].eth_offset) = (val))
+
+/* Global counters */
+static const struct ulp_ddp_counter_map sw_stats_desc[] = {
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_sk_add),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_sk_del),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_setup),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_setup_fail),
+	DECLARE_ULP_SW_STAT(rx_nvmeotcp_ddp_teardown),
+};
+
+/* Per-rx-queue counters */
+static const struct ulp_ddp_counter_map rq_stats_desc[] = {
+	DECLARE_ULP_RQ_STAT(nvmeotcp_drop),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_resync),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_packets),
+	DECLARE_ULP_RQ_STAT(nvmeotcp_bytes),
+};
+
+int mlx5e_nvmeotcp_get_stats(struct mlx5e_priv *priv, struct ulp_ddp_stats *stats)
+{
+	unsigned int i, ch, n = 0;
+
+	if (!priv->nvmeotcp)
+		return 0;
+
+	for (i = 0; i < ARRAY_SIZE(sw_stats_desc); i++, n++)
+		SET_ULP_STAT(stats, sw_stats_desc, i,
+			     READ_CTR_ATOMIC64(&priv->nvmeotcp->sw_stats, sw_stats_desc, i));
+
+	for (i = 0; i < ARRAY_SIZE(rq_stats_desc); i++, n++) {
+		u64 sum = 0;
+
+		for (ch = 0; ch < priv->stats_nch; ch++)
+			sum += READ_CTR(&priv->channel_stats[ch]->rq, rq_stats_desc, i);
+
+		SET_ULP_STAT(stats, rq_stats_desc, i, sum);
+	}
+
+	return n;
+}
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
index 12b3607afecd..929a0723812f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_stats.h
@@ -128,6 +128,8 @@ void mlx5e_stats_rmon_get(struct mlx5e_priv *priv,
 			  const struct ethtool_rmon_hist_range **ranges);
 void mlx5e_get_link_ext_stats(struct net_device *dev,
 			      struct ethtool_link_ext_stats *stats);
+struct ulp_ddp_stats;
+void mlx5e_stats_ulp_ddp_get(struct mlx5e_priv *priv, struct ulp_ddp_stats *stats);
 
 /* Concrete NIC Stats */
 
@@ -396,6 +398,12 @@ struct mlx5e_rq_stats {
 	u64 tls_resync_res_skip;
 	u64 tls_err;
 #endif
+#ifdef CONFIG_MLX5_EN_NVMEOTCP
+	u64 nvmeotcp_drop;
+	u64 nvmeotcp_resync;
+	u64 nvmeotcp_packets;
+	u64 nvmeotcp_bytes;
+#endif
 };
 
 struct mlx5e_sq_stats {
-- 
2.34.1



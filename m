Return-Path: <netdev+bounces-78142-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1716287436D
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 00:05:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3A9A11C21C82
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 23:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793831C6A6;
	Wed,  6 Mar 2024 23:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="hkJvFC6s"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2085.outbound.protection.outlook.com [40.107.92.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFE51CA96
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 23:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709766299; cv=fail; b=IkISOiwYXUbIdNCuLbIQHqNLXEHgD6tPcezhXRbEQysTve0FVHLLC1cD1LaRqqoPWbo1wayKfqPh61LtCNK4gcxHh0DadKsXhLRsPW00vAGzlxa/zwvOZ4pRfwzQBL2clpt69bWa5vbAq5HHX7SWCExYwdyHhlsys0ypzGTA2+U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709766299; c=relaxed/simple;
	bh=dGMXc2EGlCuusDQ7/UTTb855573XczH1ASYO2jOSv0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=FV0aBdYvugQeyxlbrefYBFbgdFfLLmFnK34PhVe3A+YQRe+i+Zby29AzteR1ufyJLKu/bVgasXKotnT5MhSAgGtBWPn3qXvVfd80qTD0TDG8GkmVilb+plAcLJlZ5uPT8/AYnWczB9k6r+nJtu+0RqO88l/RM5aeWOQoORfUkPo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=hkJvFC6s; arc=fail smtp.client-ip=40.107.92.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L1tLIlju1Kz8jIgodmOQdfB4InW64xayRuOYIJmsktZA97nYHUtMVQG97tY3goUSk8NNFyzxj6tGcxD5EOlc5Xfm88UqtxgMzRWHoF/sqc6RpIqf5Gv93ZQTFrK/N4uhbGGg2bc1O5j9Sfg2CEKh8dWpab/Aa4Y/UBHNrmOf/KFiBCbNnDqyFE9bAFcsbTzyB2c8IGR3e9LmY8xVpjM1cIA3j/BcLqcoJTcRSDP/Fz678EbhI3fg3JJd5YPsW2tzvaxg2FLqQlhPlUFt4go9XkJwAoUXt9zLWJJi8NbH5xkEwVkYAw+wa+XzSzHkjUrw3tkT1G9XqsqnXDzsh7dVKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Pofbf4qFSuK9ta4wBiGdh/WrpEW6IAQOo6rDxXdBzKw=;
 b=I7sham8LD4aGzYsIucyDfo/tlci+66P169v4SdyGu+iLDlDXuAJy+CTcc0/25oZ+QF2X1AIxvvO0V6K3EDuZf3EPam/Y+LxpPHZ3gpc7bn/DoMngypQQE6B3n6ZaEAYcKeVhu8BdMPEpV6kTDVTWtzjJO8B4I47UtySYxu2oOyJiU566cNhpK0OYOct2Vagcw2yT2cIz3Du6oy1MWQoQr66l4+GZMAA0gNQO99d45Tt/CS409Z0OYWQ8e4/xAc/0zD+/3WRExaeqYKe7kyZQlWAZVttx9zzV7Sf5mmnpTKuDGNveecAYqwztudX2I/U/T6w1UEp3M+snMB4idE+mTw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Pofbf4qFSuK9ta4wBiGdh/WrpEW6IAQOo6rDxXdBzKw=;
 b=hkJvFC6s3VHhZF1BXLpf4EoJaRQ3KIKL7wfoebLYByXM5ZfNIX6NHpJFxBef/Fl8QIN7wuoocMvrn8XYu+m3iBl/yThZ0RdQiQgfQxA63vQzYdSQVmHN3hdhw82gN+KrhRV1HgiCIXZy1F1n3VizfHynUN/Yg3a1Yp+dop5ORcls9DtcDN/LOWD171BVzNI35FkUTvakmPNwjS93k4ZquANOZ1Zf2YnjXxzlyDaUbwUagGTquGYPqjPZKD/LLHOpciEpQgsLmAiJqAXkXl66Wqy+FzUWw7PNU9C3pO3/YXgW408u0X219UaiyO6lb8N6Is7+WFYAVoPB3yTmCgIcdQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB2743.namprd12.prod.outlook.com (2603:10b6:a03:61::28)
 by DS0PR12MB8317.namprd12.prod.outlook.com (2603:10b6:8:f4::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26; Wed, 6 Mar
 2024 23:04:48 +0000
Received: from BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf]) by BYAPR12MB2743.namprd12.prod.outlook.com
 ([fe80::459b:b6fe:a74c:5fbf%6]) with mapi id 15.20.7362.019; Wed, 6 Mar 2024
 23:04:48 +0000
From: Rahul Rameshbabu <rrameshbabu@nvidia.com>
To: netdev@vger.kernel.org
Cc: Gal Pressman <gal@nvidia.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	"Nabil S . Alramli" <dev@nalramli.com>,
	Joe Damato <jdamato@fastly.com>,
	Rahul Rameshbabu <rrameshbabu@nvidia.com>
Subject: [PATCH RFC 3/6] net/mlx5e: Dynamically allocate DIM structure for SQs/RQs
Date: Wed,  6 Mar 2024 15:04:19 -0800
Message-ID: <20240306230439.647123-4-rrameshbabu@nvidia.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240306230439.647123-1-rrameshbabu@nvidia.com>
References: <20240306230439.647123-1-rrameshbabu@nvidia.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0178.namprd03.prod.outlook.com
 (2603:10b6:a03:338::33) To BYAPR12MB2743.namprd12.prod.outlook.com
 (2603:10b6:a03:61::28)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR12MB2743:EE_|DS0PR12MB8317:EE_
X-MS-Office365-Filtering-Correlation-Id: 048ce333-ef34-451f-b0eb-08dc3e31d167
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	WoQJ08jC6lnyJn/KOsrbP6Gtuys1DzHosWeb25/aDLScNCCdOSTqPOXaOhWFcMqoCmtvmdTbQ9FGjXW7gawSJCNUvBJK+vlToM7gtn+RdfY/RPMoPa91Tf6SoBZFO77kkPAmzlYl6iVhShj+xmxYVblfvNaUgbCJrr5QFD5Zv/8RBaJGEEn+E/XpvBqUfhrNgfDQXAmiWKbT8Oq53H0RAihC643fOF9SJv4VWi5mSCru09UVVPOgnX5jepuE4IW9a4tdNIkAtsw6S3lUj3BWC4BLxC857tOrPoobrr0F9EHqWaySWKQEH7T5OJK8CN7bIfOQGU8Tzc1oBviFWxm0HSFOGYcWXr532g79CEdDeXGfYqQGW6OW5Y/M50cpUNYGr6OIoMZ9BsVKBxpywypWYXaf0o5fRMidqmPzwueYlPm9EQLVs9QNEHYm0FEZMCe9YJR3JRKT6710h1fZSRYgf7ySveFBNK0oO/Do952LdKHbA1dmIKSFojwfzf9i5VCkAdKdv9bWjUxr2EtBUA05dcfcDW7mbnyyG0uV6c0MwbXYF+Ndyz6BIMhOJZqxP7C/smg83tUROd5d9YBdwcWnqhPqbmTg4bfLNnX3tlkQELLUC1QYdD0gHttqpfEU76JhMok6o04qeFDGC33c03lpuVVb6ONRVmSLBUGIJciBbnA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB2743.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7VbuEcerqM7BodqkPYRD2UHoK1WrXoVqJcg0S1dpkH2UdmX/upHi9XkOLpeA?=
 =?us-ascii?Q?GGB1De4kPr5AIs/k7mEN9iKTCgEBkXUE852FC1K/aw6HZa0RDEjrZaSFCnl4?=
 =?us-ascii?Q?FBux79FM9a+MjztyRBumNG8c3gjCV+OKAjSzc7SO+pVToMUh3kck/oqYyOfB?=
 =?us-ascii?Q?aWqBl16yCd28Bv62U6ECSHpIVvKHnbeKM/03vSvIkx/G90mN+KHCW4g1HKzD?=
 =?us-ascii?Q?o+LA9se3g6VrsaGHWgdKD/M7kPaChIFs5t83+bMVWskSI/6VDzOg0c7ICxHM?=
 =?us-ascii?Q?UcKUUjKFZr5ok1cHDBCJosQiD659SaiZsCY0ZNAlncrpAyusGRUj2Ygq1vm8?=
 =?us-ascii?Q?fNvxoFLHGRx9gzqQwlqur5gTGjLOCKXYaDMSt/4+dSWacCQbGeDZ2wPT+a8q?=
 =?us-ascii?Q?yL3DUg6uS7+gbinEcMo5+YtaU9ImI3G098vRi4xsoW8pLVgZRnfMu/reiGCf?=
 =?us-ascii?Q?m+/yCBBhx3zKjYD3dPf6opDcldbl4qAKKkgQnmdnm+2gZyVV8GjcFJPuFrly?=
 =?us-ascii?Q?59/5ctr5t9NCTLQZwNybOld7SSnC0x1WJFmqwDoZEwQbsZ69v0ziAsrsEm8f?=
 =?us-ascii?Q?ylvXIRGMl5bDmEYsEwpQII5tgx3I8igOXB2T7MjYDZzYzhsEBvHpYRxHolP6?=
 =?us-ascii?Q?xutWpyKKAaZEyOM9vJyTyrWjqbnq3i8tYdDOerKatRME4MPBTmMp1CSW8scp?=
 =?us-ascii?Q?DM/q0yo2/5NU4rhGRpKe/cwb7dUb7xKfDpyDGEdP5bZwPhP+gOgftA3Yapm6?=
 =?us-ascii?Q?2vNLUhhzegDkZbE/0u96aC9DkfJw5YnsfL74pgZDuFhnLXiQYkT3qcoy1umi?=
 =?us-ascii?Q?9fxJQrCmunnuxXHCh0oV6Y9L2YXY0csy11BiWdsVXv+fZ8vOulPIF44AsQlH?=
 =?us-ascii?Q?xWMJsXAKibvuamND5Hzh7vo8x+40VCWqAGFRC7lxiyYLkgATjO4lNKjM2HMu?=
 =?us-ascii?Q?fE5Xit7RWsrUhUgqvPppe8XsEW9HTC3kBrklpBNrtII/bL66z9BqYEfzgiC6?=
 =?us-ascii?Q?K6H3jfPgqczaZmf3//IczRImeFX43uHFiEV+p6xW/CUdJAEkoVzbr2fZFDmz?=
 =?us-ascii?Q?izqKr/1qGjTDUqGs+kWEtPeeZo6Q7jMlDgmXmzUtdeKivp/xDX3CE9mA5LsA?=
 =?us-ascii?Q?+Me9i8loXnTYEjmWA2FhfbP+B8mnrLkcEscsPjXnDHTAjZe0cHal2i7sUZAl?=
 =?us-ascii?Q?glMmz0G35WO28bXouo5tcyF81YcadCo9lN/GqWFMA5kSIhzK6Uauvq5kqobv?=
 =?us-ascii?Q?6/WoRq2zVVq3ox4ZqK/VD5EzkCf7YkzFHB8nVdN/nQHjDvV+qfWUmnieEvHk?=
 =?us-ascii?Q?PCDE5X4nWqCVk/r7D2RSIWXLCyeDyslciXQdEo02S+iYW/gaicP6ocXtir1f?=
 =?us-ascii?Q?Xb9zUt6CwnxbBvGUtkbDyOc5UoxtC5uUcgk3ji5kPAOud5jge2NfRfoW5B+x?=
 =?us-ascii?Q?2mOIaF4HDPI3ad/WxfZTezsERYXBnbIbUEU7huhcnK/exZMfA/n+IfDlPeer?=
 =?us-ascii?Q?z070XeG8M4X0v+UdbY3Z8wx8hevZZ38I3qvDqGSP0UEKLau1aFU/VBVxrWuR?=
 =?us-ascii?Q?80z/71mR9kg49mEn5i8LMByXqt5m6eWLdjYwqd+ymMRLNMTabgi0KDmu7MQM?=
 =?us-ascii?Q?Fw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 048ce333-ef34-451f-b0eb-08dc3e31d167
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB2743.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 23:04:46.8303
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GwqGyNp5/v/Q54zlp7kLxmB4OJzzb1kPCQ/FCFZVd39KI0+ToPq0oTtv4DWU0k4OzcAnYZwAXXv/GIsC0bduUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8317

Make it possible for the DIM structure to be torn down while an SQ or RQ is
still active. Changing the CQ period mode is an example where the previous
sampling done with the DIM structure would need to be invalidated.

Co-developed-by: Nabil S. Alramli <dev@nalramli.com>
Co-developed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Rahul Rameshbabu <rrameshbabu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |  4 +--
 .../net/ethernet/mellanox/mlx5/core/en_dim.c  |  4 +--
 .../net/ethernet/mellanox/mlx5/core/en_main.c | 31 +++++++++++++++----
 .../net/ethernet/mellanox/mlx5/core/en_txrx.c |  4 +--
 4 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en.h b/drivers/net/ethernet/mellanox/mlx5/core/en.h
index 2df222348323..b6b7e02069b8 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en.h
@@ -429,7 +429,7 @@ struct mlx5e_txqsq {
 	u16                        cc;
 	u16                        skb_fifo_cc;
 	u32                        dma_fifo_cc;
-	struct dim                 dim; /* Adaptive Moderation */
+	struct dim                *dim; /* Adaptive Moderation */
 
 	/* dirtied @xmit */
 	u16                        pc ____cacheline_aligned_in_smp;
@@ -721,7 +721,7 @@ struct mlx5e_rq {
 	int                    ix;
 	unsigned int           hw_mtu;
 
-	struct dim         dim; /* Dynamic Interrupt Moderation */
+	struct dim            *dim; /* Dynamic Interrupt Moderation */
 
 	/* XDP */
 	struct bpf_prog __rcu *xdp_prog;
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
index df692e29ab8a..106a1f70dd9a 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_dim.c
@@ -44,7 +44,7 @@ mlx5e_complete_dim_work(struct dim *dim, struct dim_cq_moder moder,
 void mlx5e_rx_dim_work(struct work_struct *work)
 {
 	struct dim *dim = container_of(work, struct dim, work);
-	struct mlx5e_rq *rq = container_of(dim, struct mlx5e_rq, dim);
+	struct mlx5e_rq *rq = dim->priv;
 	struct dim_cq_moder cur_moder =
 		net_dim_get_rx_moderation(dim->mode, dim->profile_ix);
 
@@ -54,7 +54,7 @@ void mlx5e_rx_dim_work(struct work_struct *work)
 void mlx5e_tx_dim_work(struct work_struct *work)
 {
 	struct dim *dim = container_of(work, struct dim, work);
-	struct mlx5e_txqsq *sq = container_of(dim, struct mlx5e_txqsq, dim);
+	struct mlx5e_txqsq *sq = dim->priv;
 	struct dim_cq_moder cur_moder =
 		net_dim_get_tx_moderation(dim->mode, dim->profile_ix);
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index f871498a1427..2ce87f918d3b 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -961,11 +961,20 @@ static int mlx5e_alloc_rq(struct mlx5e_params *params,
 		}
 	}
 
-	INIT_WORK(&rq->dim.work, mlx5e_rx_dim_work);
-	rq->dim.mode = params->rx_cq_moderation.cq_period_mode;
+	rq->dim = kvzalloc_node(sizeof(*rq->dim), GFP_KERNEL, node);
+	if (!rq->dim) {
+		err = -ENOMEM;
+		goto err_unreg_xdp_rxq_info;
+	}
+
+	rq->dim->priv = rq;
+	INIT_WORK(&rq->dim->work, mlx5e_rx_dim_work);
+	rq->dim->mode = params->rx_cq_moderation.cq_period_mode;
 
 	return 0;
 
+err_unreg_xdp_rxq_info:
+	xdp_rxq_info_unreg(&rq->xdp_rxq);
 err_destroy_page_pool:
 	page_pool_destroy(rq->page_pool);
 err_free_by_rq_type:
@@ -1013,6 +1022,7 @@ static void mlx5e_free_rq(struct mlx5e_rq *rq)
 		mlx5e_free_wqe_alloc_info(rq);
 	}
 
+	kvfree(rq->dim);
 	xdp_rxq_info_unreg(&rq->xdp_rxq);
 	page_pool_destroy(rq->page_pool);
 	mlx5_wq_destroy(&rq->wq_ctrl);
@@ -1339,7 +1349,7 @@ void mlx5e_deactivate_rq(struct mlx5e_rq *rq)
 
 void mlx5e_close_rq(struct mlx5e_rq *rq)
 {
-	cancel_work_sync(&rq->dim.work);
+	cancel_work_sync(&rq->dim->work);
 	cancel_work_sync(&rq->recover_work);
 	mlx5e_destroy_rq(rq);
 	mlx5e_free_rx_descs(rq);
@@ -1614,12 +1624,20 @@ static int mlx5e_alloc_txqsq(struct mlx5e_channel *c,
 	err = mlx5e_alloc_txqsq_db(sq, cpu_to_node(c->cpu));
 	if (err)
 		goto err_sq_wq_destroy;
+	sq->dim = kvzalloc_node(sizeof(*sq->dim), GFP_KERNEL, cpu_to_node(c->cpu));
+	if (!sq->dim) {
+		err = -ENOMEM;
+		goto err_free_txqsq_db;
+	}
 
-	INIT_WORK(&sq->dim.work, mlx5e_tx_dim_work);
-	sq->dim.mode = params->tx_cq_moderation.cq_period_mode;
+	sq->dim->priv = sq;
+	INIT_WORK(&sq->dim->work, mlx5e_tx_dim_work);
+	sq->dim->mode = params->tx_cq_moderation.cq_period_mode;
 
 	return 0;
 
+err_free_txqsq_db:
+	mlx5e_free_txqsq_db(sq);
 err_sq_wq_destroy:
 	mlx5_wq_destroy(&sq->wq_ctrl);
 
@@ -1628,6 +1646,7 @@ static int mlx5e_alloc_txqsq(struct mlx5e_channel *c,
 
 void mlx5e_free_txqsq(struct mlx5e_txqsq *sq)
 {
+	kvfree(sq->dim);
 	mlx5e_free_txqsq_db(sq);
 	mlx5_wq_destroy(&sq->wq_ctrl);
 }
@@ -1839,7 +1858,7 @@ void mlx5e_close_txqsq(struct mlx5e_txqsq *sq)
 	struct mlx5_core_dev *mdev = sq->mdev;
 	struct mlx5_rate_limit rl = {0};
 
-	cancel_work_sync(&sq->dim.work);
+	cancel_work_sync(&sq->dim->work);
 	cancel_work_sync(&sq->recover_work);
 	mlx5e_destroy_sq(mdev, sq->sqn);
 	if (sq->rate_limit) {
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
index a7d9b7cb4297..5873fde65c2e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_txrx.c
@@ -55,7 +55,7 @@ static void mlx5e_handle_tx_dim(struct mlx5e_txqsq *sq)
 		return;
 
 	dim_update_sample(sq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
-	net_dim(&sq->dim, dim_sample);
+	net_dim(sq->dim, dim_sample);
 }
 
 static void mlx5e_handle_rx_dim(struct mlx5e_rq *rq)
@@ -67,7 +67,7 @@ static void mlx5e_handle_rx_dim(struct mlx5e_rq *rq)
 		return;
 
 	dim_update_sample(rq->cq.event_ctr, stats->packets, stats->bytes, &dim_sample);
-	net_dim(&rq->dim, dim_sample);
+	net_dim(rq->dim, dim_sample);
 }
 
 void mlx5e_trigger_irq(struct mlx5e_icosq *sq)
-- 
2.42.0



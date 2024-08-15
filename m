Return-Path: <netdev+bounces-118744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1BB39529BF
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 09:18:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D07771C21D4C
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 07:18:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3BF017ADFC;
	Thu, 15 Aug 2024 07:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Re173xIN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2042.outbound.protection.outlook.com [40.107.92.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C58B145B2C
	for <netdev@vger.kernel.org>; Thu, 15 Aug 2024 07:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706312; cv=fail; b=oC8zWM6nDdbtgiY7HAS4xNwim6UobbLX5NOimaZW1EV+ajsOd5lPLFKIg1aIeqMIJLe0JYwChYn58p9rvasqbkrrSALnbnyI9k1oT1+gshNxwcMLcD+mhUaTHxS1zs38NxMryFroz9aZBko4cTOGbrC3rXk3ia7wJF1H1Qlrvms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706312; c=relaxed/simple;
	bh=wAWFwdtSzO2dzcA+qYwuTphMtsRkLqojwDeb5rXCxsE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aBDnGzGm4DxYIxDkOY25JB285ritw0m24FlQOVByDlYFksSFq92bPXU4zAIgxx2iCeKKZaRlnTwfO/Nb7Hj2P8WI61i1G7u51r3EiigvUE90qgJWC9ypeOXdFXOzlb5Kr85lqvomT+/diNT9p7cjYvTwOzuWg91FFrUhNaeI6jA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Re173xIN; arc=fail smtp.client-ip=40.107.92.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rvsS1wXHweseYIJWVwzHTTMEJBYJxJgwW9tvtWLKFsca+BzlM5G8DEcsgwcCqUc4gRdwOIU7w399J0U6aiEBd6ktJXtmHtBCGWmRtvCXzjf2JZLfPI1aunbYiJm0tpGNAkUW0e9InEzPQiivqh32lLFrV5qt2/7bgah/bAAIXKa9va+gw6t5+K+QXmP9XfwG2YBGnkT8eULD1WKB65Kih22RlsMsyLZ4N9o6ljt8Nzrh+qFPWajV831lInmtFBf7+0MBdol5gh/MrlSDSw0ZKoL2XH9B0cQPy53XFkcFXiugJDlsKX10ZFZeOcXX/DtBqsA8b/fZXDMkiwi3LSyOuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S93kHUrAfiCRjig3Ql4+VKh0RcfvbWkpmwWvy+eWAIA=;
 b=p8OVlZ6gL92b1tocXGvSdOFdXb2r9mLkp1KsY91IW9SxvnYw5YhApWpCPRKbl0R4F4WxKY291QUquAVi+jHYHl7qjrbtKredSw2IKPz5cAgCdlGpBpDa/CjSEN1efqbDGjjgiTsTKHNm+q+LRU79b3luvoGCU9uBEy2UPlhnS9UJ8ANBlLPoDd2LPNC19bCi7bkmMVUW/QVSeee5bpwl6Hdwcc0t62RyTKM/tSJsqY80JDLEYvDUbO6ukEzQPbX/v4KsZfJdOhM5NzmXtNXIL8406rn2++Ql9gsqcIINRJ2WwojVAzfgbJl2RDXq8qgq6Unxy1QX8iTNkA8JEc72rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S93kHUrAfiCRjig3Ql4+VKh0RcfvbWkpmwWvy+eWAIA=;
 b=Re173xIN4oiCz+gpnffq3bsMvnO5GUrpuJv+H/EApTQqafmGqMN/PEKhx03BvC4A2JhZsE4NW2FgvebON91LhuSBpxwD1TlhTcU9Mcpt0qLrEt3+QbK2oDQO5Tm/Rr6iKszv9Z9DkX+00VSy7X4X7+N65NngD2eW8ajwiVjG7uYe5L1IAjk1TYNIJDf/uLAIS4W4vm4Bwy1bTTsk8yddyBhOqaBxQR5RuG8pUpTv7+08SGdJL1F3hxSG1SJGeZK5U/LnloOEayZ8tLoEgJxLhhAE6mhZNmX2ShsdeECq9fMTTzCowCcYMBXaeqD91ROTL2EVZQTZIjW22iEzRiCx8w==
Received: from SA0PR13CA0010.namprd13.prod.outlook.com (2603:10b6:806:130::15)
 by SJ1PR12MB6364.namprd12.prod.outlook.com (2603:10b6:a03:452::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Thu, 15 Aug
 2024 07:18:28 +0000
Received: from SA2PEPF00003AE7.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::f9) by SA0PR13CA0010.outlook.office365.com
 (2603:10b6:806:130::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.22 via Frontend
 Transport; Thu, 15 Aug 2024 07:18:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003AE7.mail.protection.outlook.com (10.167.248.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.8 via Frontend Transport; Thu, 15 Aug 2024 07:18:27 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 00:18:16 -0700
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 15 Aug
 2024 00:18:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.6)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 15 Aug
 2024 00:18:13 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 3/4] net/mlx5e: XPS, Fix oversight of Multi-PF Netdev changes
Date: Thu, 15 Aug 2024 10:16:10 +0300
Message-ID: <20240815071611.2211873-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240815071611.2211873-1-tariqt@nvidia.com>
References: <20240815071611.2211873-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE7:EE_|SJ1PR12MB6364:EE_
X-MS-Office365-Filtering-Correlation-Id: 03e54ef7-031c-4e98-5e79-08dcbcfa751e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?EBZWfZix1JXaUfPpW0+OBUa4ApSA5DyI1nxKqp4nuktyqNtu+F/D+Ycq2Wmh?=
 =?us-ascii?Q?w5h9etCWE5/S8OG1EG2A7O5mxLjCXGF3op9vIk38Br+z1apUIs5ujJXMf45K?=
 =?us-ascii?Q?UKH3/xJOKtz5fVfrp8CjIgmaEonR1erhSfYNw4tP9Lm6wsR4S2OhkoZd1wMA?=
 =?us-ascii?Q?blnKDLVikRw/zJYN8hfdQjOPM8nplul6vz6+5CumJoCmvoqU7QJn26wUOLXJ?=
 =?us-ascii?Q?y18AyiA0EKfmvFCeeTre/6/On4o69wxXWK7LLRl/h8Pfp28mqtxa9Xq0CVo0?=
 =?us-ascii?Q?hOPgKaMKIz5+nOYrfRTtxeHYkptPTqBhOEpdi8SLZTA6NkQ9TbbMglepJlsW?=
 =?us-ascii?Q?NVbHT+gOwPxGZMyO6Qo1kLeJoTvHw0eECLtF4PGiNA5Jm0iN+Pn3rMLzHxDY?=
 =?us-ascii?Q?0/7JVfsuQPT9M0SYgnsbR7cH53cwXu27jhPEhaCEiaGMR+CS2bZX1RqWRfSu?=
 =?us-ascii?Q?/ihy3hI+Ksj+Mw4zP6ugM72IAGxg0+X46oSVsr8owIe4OLdURF+W4UtxYIGa?=
 =?us-ascii?Q?P0QZ00z7A4OOavPSXZr7TkunozGwpr+5lQ3o2GQmgU9ybazt2T0G6pu7DWqs?=
 =?us-ascii?Q?KcikfPZwEqN26bPE3rlw/wWEKKW89gLxOzCiufnRGcNSjE//0e+Gr5IwEyLc?=
 =?us-ascii?Q?KpBA1XQSTjM3AjluukfMu8rF7XLDEZZh09lIY6vs2UdURoh4XZfTZ/O7RnBa?=
 =?us-ascii?Q?bqxKqYnBoxoPc4kj1DYLYfK0gU5FVDJi7Hex3vy6pbI7a56qGw6FwKW0UNS9?=
 =?us-ascii?Q?1dOFcYDzSQ9liPKa9kQmTuqx0LionNHBxL8khn6YAlvvHQmp+AGlyqT3hJoH?=
 =?us-ascii?Q?Wl4KiUUc6ZFtM/kXouDHbhu9h0lPkmk0PI8nCMV8+ZfsY6I3/ePLMzqqXMzn?=
 =?us-ascii?Q?NgQ4TTHsDknsBExd7IVXEgGsy388V5uIbW/rB489j+N7dVUFd3oru9VV1tM8?=
 =?us-ascii?Q?xhfqd5LHoA8AICzs2FyhLRytLfwWC1HfuS7Y4c6rRJgilHnxIfFTr2k+O2pS?=
 =?us-ascii?Q?NONV8unKOP2Rw0be1KG0A8xsfnqz/JW8VKSafElSPoza1DHYsnN9VpFzXN80?=
 =?us-ascii?Q?qF06s/8ctqnswWEKG9RPMAgEkq2PNODMPJvIDGJHMqo+ALLhyZUDNdAji9VX?=
 =?us-ascii?Q?pIZZ0PRPbx0xSb56oRbjHhUgEDMgrJXPWCNfeqHE3bWrHh8M7Z5DWA2JKval?=
 =?us-ascii?Q?e68pNjN85C6hTWRb2xsKw2vvBXlTwLdlocSBvo/5SkXChTcBp6S3WaX7BC01?=
 =?us-ascii?Q?apPYxHG1+QxXivoiCr58fm1kaJXB2XHHy1Oy9r5IkVq4tHXTI7aht6Xd/t1B?=
 =?us-ascii?Q?xYshHDyI1XNz9lpPrkAjdwGw0n411eZSLc8p5nMJaVYe0qHHezqnTV7ZEy51?=
 =?us-ascii?Q?Zv7xXuL0Eyu3YJo0kR36hkbv2XE274qQ2DkgSjRidmRcfOLXUVYTPrpeO4iK?=
 =?us-ascii?Q?wqFqPwFr86bBTXpb3RqSIZit1cjlIBdo?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 07:18:27.0975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03e54ef7-031c-4e98-5e79-08dcbcfa751e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6364

From: Carolina Jubran <cjubran@nvidia.com>

The offending commit overlooked the Multi-PF Netdev changes.

Revert mlx5e_set_default_xps_cpumasks to incorporate Multi-PF Netdev
changes.

Fixes: bcee093751f8 ("net/mlx5e: Modifying channels number and updating TX queues")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
index 583fa24a7ae9..16b67c457b60 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_main.c
@@ -3028,15 +3028,18 @@ int mlx5e_update_tx_netdev_queues(struct mlx5e_priv *priv)
 static void mlx5e_set_default_xps_cpumasks(struct mlx5e_priv *priv,
 					   struct mlx5e_params *params)
 {
-	struct mlx5_core_dev *mdev = priv->mdev;
-	int num_comp_vectors, ix, irq;
-
-	num_comp_vectors = mlx5_comp_vectors_max(mdev);
+	int ix;
 
 	for (ix = 0; ix < params->num_channels; ix++) {
+		int num_comp_vectors, irq, vec_ix;
+		struct mlx5_core_dev *mdev;
+
+		mdev = mlx5_sd_ch_ix_get_dev(priv->mdev, ix);
+		num_comp_vectors = mlx5_comp_vectors_max(mdev);
 		cpumask_clear(priv->scratchpad.cpumask);
+		vec_ix = mlx5_sd_ch_ix_get_vec_ix(mdev, ix);
 
-		for (irq = ix; irq < num_comp_vectors; irq += params->num_channels) {
+		for (irq = vec_ix; irq < num_comp_vectors; irq += params->num_channels) {
 			int cpu = mlx5_comp_vector_get_cpu(mdev, irq);
 
 			cpumask_set_cpu(cpu, priv->scratchpad.cpumask);
-- 
2.44.0



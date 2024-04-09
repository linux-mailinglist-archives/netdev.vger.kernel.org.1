Return-Path: <netdev+bounces-86252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A5489E319
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:12:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCBD7B22BE4
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 19:12:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC6F3157E7B;
	Tue,  9 Apr 2024 19:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jmYfA65z"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2077.outbound.protection.outlook.com [40.107.212.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AAB3157E78
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 19:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689784; cv=fail; b=mPkP5ER1dFB4TP7IT+BwtlyJGADbGg93q/13rnJ4X4tZj0tL9JUAqRgoPeJo+avxg1Y4g3Xm079toYFA8e4wiZb08Q4y+cWR2RFjutl3DOQjhb+qO/Pr8Ea1B6nS9jMIneScs6dnldbae396ONfdWRPh+UF3pwoSIpdQ9aZQTvc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689784; c=relaxed/simple;
	bh=BbWEOlKhG1WNIfZiKHn8H+LrWwtAboEi+XniGsTqvhE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t2RclLR4BGOs6DS8xhSTDBOyaQrUqvID1hb3XIbA6YpOcTPDWlDCgkGn6e2najITEmIq6jt48Qzx/I+eDbG7ebAGLGKY2GY/qQZ7THxzBnUMGVFX0YJVAxQULj0TAaIohwvudRYKsHvnk8PcOgynsXd9Xmfhoimt3Dv7EqfiOJc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jmYfA65z; arc=fail smtp.client-ip=40.107.212.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PG907Vg7Kx4J+2gjzX5/rQKAnUQx1fHcZLFyqxCGVrnefSdYrkxLQjFTE2LoEMPBoypLgl0S9ee0w+vxRZvjFI4Ym1MjClsNkqklNRSmVqxmwATatrYsCCTuVWShLOpnlUU0u/j7aOF1T8a8tf6oi8A2R8XxJpntrO6ngrqvgiuM5wZuSc6RPTUHiTqv8ptjEPQYkrSPD7WZHxyytaZfJf1s2U/EZ4gupK0usyzBRIi+7h11/njIbrZ6+OmW/oXtnWwnWX4Y1iayhH+s8eRv12QLF+pONnBe42Ffh+H3T8OwdypE7sqh7X/6hH5YJ9mxgm89cejUxHCNaU7Qy779Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+GVdnVS/JjAOrgCywukcyKXjoUktu16htUsYUtDwoE0=;
 b=bIEEJk/pHwI9057GTosIJp5s2rk25U0BKiLOaPwVV0Ijqpk/UVvl4KAiikdJDoXOjlVR+lXSjXkgewBEXAH0zwdBz0CwmI60cfnpbclwf95O3YDuioqJ+q0b3GOLb+86lpq39Ebkr0AhXtQXVDq44vRO8MwmEzklVcW72lMS2JsfHaOm5zP3+ytCc+7mf5o0PRJ2gUIt+mS3x2kkupP80jC+VjziS+ijfFtsKqGm019STuFdC+A92sQeqceWdk9qjjXY+CFEiN8itZeiSfLq5hD9HMMjxH0+7k53S/uvZneXTg0Iqp37GcDM2+daZuczw0iyHU/nnzEBE5w7O3Abwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+GVdnVS/JjAOrgCywukcyKXjoUktu16htUsYUtDwoE0=;
 b=jmYfA65zUWGtLTPirZl5M4fD/Ib2C/ijwqd3lKx3sqXl8/QQNmNcOhVfcI4bZ91WTmLrgXhZVP94JERI3Ij0dszWoGQH5RX7QGeZ41si2d391RIUqkaWAmWF6CMJ2IHQsoWzGuycRFz/FDgDKBIN/Ix3KtOocIbhhomnu88TaQLvEtUUadH/QJn/o3LAifAqD3SigZUHLvu7kzp0aeqjNWziUDO5NCVDVm2EvxU4cmTxrHysjikxSMmRiIgSGls2T3vt0VGrZfUVmgYoDOfX4HKrdZkHN6rbkw9Lroo8gciWWnLSCLnHRoPk3g35qWgfvBQYS3BxhnLRvp9toD2Xcw==
Received: from MW4PR04CA0362.namprd04.prod.outlook.com (2603:10b6:303:81::7)
 by SA0PR12MB4429.namprd12.prod.outlook.com (2603:10b6:806:73::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.46; Tue, 9 Apr
 2024 19:09:38 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:303:81:cafe::de) by MW4PR04CA0362.outlook.office365.com
 (2603:10b6:303:81::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Tue, 9 Apr 2024 19:09:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 19:09:37 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Apr 2024
 12:09:09 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 9 Apr
 2024 12:09:08 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 9 Apr
 2024 12:09:05 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Carolina Jubran
	<cjubran@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Dragos Tatulea
	<dtatulea@nvidia.com>
Subject: [PATCH net V2 08/12] net/mlx5e: HTB, Fix inconsistencies with QoS SQs number
Date: Tue, 9 Apr 2024 22:08:16 +0300
Message-ID: <20240409190820.227554-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409190820.227554-1-tariqt@nvidia.com>
References: <20240409190820.227554-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SA0PR12MB4429:EE_
X-MS-Office365-Filtering-Correlation-Id: f9585fb8-8bcf-431f-57ea-08dc58c899bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qSCwIA7QSWcSnq992ech6k9fkb9zTMqrdOPRYhmQ/fCUPhn03XhirT48rOZF4wk+MdKVlRWjrgpH//j8Nsvh1lfG8DMSKBalvc9dnNEvvLRS3j2XkrLrCgBpnoEqPLBJ0HQA6U6UFFwlndyHSFZA/gPpbbcXnv4QcZQ2b0Z/UpkWCqZYc7PH/nlmJiha5cAh4ovWkaYJBmT1o0KEIdKkkYxy0tLe6t2nO1BZJbB3qAOo8U16sS96pCNtWex0kKdV8ydNdAPgzv69+76C7SnDRJELVFztntHuPJVsotQcLyd+o+9PXUjdlkZYc+y9FIyfhy0L6S7ekw8wZg73/9DTA+CP5gjibzOloOz5i9w7v6D8N20+v4QOFEYKuskRwKvt9x1ejxLwLg0HJpR+9ygfjo5SnGdYYZTJdH+rAUx+rXoUgsENsepomKk4vhH6ssukvMelN58X3n86kBAUIXbOCJBSaiQHVFlE+Afn3uGmV2MIMgKJoJNlobFZMhuu0/LH19NARfgdujBBIQnVm5K/faFugxoaEJmWvxrqVLgLyhEIF3IcTHqzuZhWBH32z+ovzrHkvGolOnr8krPLKRnoJq7Dww97WyWX26qBaC4FUtNWqeEluEV67+EZfw/GXvn8HrgzYIVQwH8nz1waABy7/7vaMQGM09K5qBSAJP9XOw+FnVUuDRcjxXMS0W+QXjuOrlK1LxlAwrhxlMtj8MHf2xqmFU6bL9fOWMtynS9rG9wZmfwRAC8wRGrI4QH2OMZF
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 19:09:37.4231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f9585fb8-8bcf-431f-57ea-08dc58c899bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4429

From: Carolina Jubran <cjubran@nvidia.com>

When creating a new HTB class while the interface is down,
the variable that follows the number of QoS SQs (htb_max_qos_sqs)
may not be consistent with the number of HTB classes.

Previously, we compared these two values to ensure that
the node_qid is lower than the number of QoS SQs, and we
allocated stats for that SQ when they are equal.

Change the check to compare the node_qid with the current
number of leaf nodes and fix the checking conditions to
ensure allocation of stats_list and stats for each node.

Fixes: 214baf22870c ("net/mlx5e: Support HTB offload")
Signed-off-by: Carolina Jubran <cjubran@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Dragos Tatulea <dtatulea@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/en/qos.c  | 33 ++++++++++---------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
index e87e26f2c669..6743806b8480 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/qos.c
@@ -83,24 +83,25 @@ int mlx5e_open_qos_sq(struct mlx5e_priv *priv, struct mlx5e_channels *chs,
 
 	txq_ix = mlx5e_qid_from_qos(chs, node_qid);
 
-	WARN_ON(node_qid > priv->htb_max_qos_sqs);
-	if (node_qid == priv->htb_max_qos_sqs) {
-		struct mlx5e_sq_stats *stats, **stats_list = NULL;
-
-		if (priv->htb_max_qos_sqs == 0) {
-			stats_list = kvcalloc(mlx5e_qos_max_leaf_nodes(priv->mdev),
-					      sizeof(*stats_list),
-					      GFP_KERNEL);
-			if (!stats_list)
-				return -ENOMEM;
-		}
+	WARN_ON(node_qid >= mlx5e_htb_cur_leaf_nodes(priv->htb));
+	if (!priv->htb_qos_sq_stats) {
+		struct mlx5e_sq_stats **stats_list;
+
+		stats_list = kvcalloc(mlx5e_qos_max_leaf_nodes(priv->mdev),
+				      sizeof(*stats_list), GFP_KERNEL);
+		if (!stats_list)
+			return -ENOMEM;
+
+		WRITE_ONCE(priv->htb_qos_sq_stats, stats_list);
+	}
+
+	if (!priv->htb_qos_sq_stats[node_qid]) {
+		struct mlx5e_sq_stats *stats;
+
 		stats = kzalloc(sizeof(*stats), GFP_KERNEL);
-		if (!stats) {
-			kvfree(stats_list);
+		if (!stats)
 			return -ENOMEM;
-		}
-		if (stats_list)
-			WRITE_ONCE(priv->htb_qos_sq_stats, stats_list);
+
 		WRITE_ONCE(priv->htb_qos_sq_stats[node_qid], stats);
 		/* Order htb_max_qos_sqs increment after writing the array pointer.
 		 * Pairs with smp_load_acquire in en_stats.c.
-- 
2.44.0



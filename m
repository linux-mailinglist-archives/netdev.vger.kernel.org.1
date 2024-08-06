Return-Path: <netdev+bounces-116103-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C56CA9491BD
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:39:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8089D2833EF
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADA11D2F42;
	Tue,  6 Aug 2024 13:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="YXl0tbwG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2072.outbound.protection.outlook.com [40.107.244.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3FD71C4622
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722951591; cv=fail; b=eHJ16wDq/+/OgSiEqCZ+odBygOivOaeT4coKVt72MPcQoJEjGtMDysIhjdacGM9v8XA/8ZlvEZuu9eDTsA6GQIu/RDCqMcCdsPZ9Pgz2ORLJCPVd9qPP7qV63gyLv9cEukfSukf+U5AyGrhWv7gzkZiI4HjOZHIIrT+Unqx/oC8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722951591; c=relaxed/simple;
	bh=z+q/98TlRTNP1zaPcRclkWOKlR/mc6owl8qieAY7mME=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JFNO3zOsIwsvprLlCpTRFxzrvOW9ktZTTmrAgZyz8Fy+NVDfMGtbSH2RgPXH7NRHnhf1yklmQ6CV/dgOikIT+sqXaGcsuc6dFXVuWctpBkDxOqmtpJZUFHvOtorJ1CiN5ssnr4qH+05RtC0STeQarQNOlwQtv55IMKbU0v6+eKM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=YXl0tbwG; arc=fail smtp.client-ip=40.107.244.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zVRocsovcE2c1IQEfBmo9YZKRMLOX4W85bppKoV8BcP8/l5Q58SlNEqhZUagGsRMpNBLyhnMTbJH24xS8F8Bu9qfos6IOUjWIH0nzHEM+LqDC7N4/3qQGSEAWnDceIHg7MHB/5nrS9FdNB1zLjL9bAcx4REGJIaLKzUZYK9bWrFB/IYtEfg+XPqelkhgdiS6FbA4nvLki1dmX57ZVZwYh3Djs/NX6tXUAs2pqe1LVi5FynG8kTTYHT62yPeoP4AZ/8sE5ykLK2bBRtC1ONZA2g76+PAZwd90pbJxTlxKHcKQamuVOPOK6MrIsu8/ZEO81tdaIYFmWUIUyDXOvk84NQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MOYddmxJGlCVQY3fZHuF9ufsO9BGC0FYHRXxsWXHv0g=;
 b=WUgZSQI1NTLrYbHfFj38uJbvL5lrhyv3ztwbam0xEOq7XT8SG94SG/qOGOG6rGNbDCnz92p1iCjeGiKORSH2jmueCY6mvGb+hQoUNAkrG9kPjJK1SX8UWF9Hao2cIwkdvsMzI9lh7BMsPWOlY/C0wc2GmSVytAJcFUcGuR7jqoUqstA3m7zp/+tGvOeBXV3Pqmd85oo2TVIcotlxs9RkTz8QRuYGKTikvu3QCwJku4/r9pFzTnuug4OWxX3wQmuYQB664ia1r9d/EwAwSXK7XT9MjiTCisn1TPJ5lzks730xGUs38AzIRUiRVUDctxGLwp38uBf+hjDU1Ag99tA4sQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MOYddmxJGlCVQY3fZHuF9ufsO9BGC0FYHRXxsWXHv0g=;
 b=YXl0tbwGaj513I4KfEFk8tN5iY43tqURbfYvhx38CnIsCaN2KvGhNzY40Mlfj3HF+VbGpvFCkhRM4CUgAmIepM3yw00ZJ1eYnCoo4nfC+8P2zkoZ8DCzypql/xgN4yRDskKdGjYGfNy4mrUk8s1T8p/i0AccPNdnna1bdN39508dN3LIRsSDjTby/yOLaKEHlaStflqD1sZ5v8ASLYs0yaWdip5/yDRzWXXzpEqL8wpixz6DDyicChAV3WUw3BlQvItt2NU2Jda7bqpJBqFsxTrNU6QzjnAdUDH+LksAPkgDE9CPqa51F6G+rlyAMft1R9DwkJY0wLrTTtXDrS2lkw==
Received: from CY5PR15CA0209.namprd15.prod.outlook.com (2603:10b6:930:82::27)
 by PH7PR12MB7819.namprd12.prod.outlook.com (2603:10b6:510:27f::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.24; Tue, 6 Aug
 2024 13:39:46 +0000
Received: from CY4PEPF0000EE39.namprd03.prod.outlook.com
 (2603:10b6:930:82:cafe::17) by CY5PR15CA0209.outlook.office365.com
 (2603:10b6:930:82::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.13 via Frontend
 Transport; Tue, 6 Aug 2024 13:39:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000EE39.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 6 Aug 2024 13:39:45 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 6 Aug 2024
 06:00:02 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 6 Aug 2024 06:00:01 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.181) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 6 Aug 2024 05:59:59 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 08/11] net/mlx5e: Use extack in set coalesce callback
Date: Tue, 6 Aug 2024 15:58:01 +0300
Message-ID: <20240806125804.2048753-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240806125804.2048753-1-tariqt@nvidia.com>
References: <20240806125804.2048753-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE39:EE_|PH7PR12MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c7fa7b-c317-4a37-72e4-08dcb61d3bec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P6gPn+y8OECS+ePsXWRp6oz2lQutu4d4KFxj/IlFphCzStcRHW3/g7OPmt7D?=
 =?us-ascii?Q?SQEQqoZM8312KllvGWHJF0/NYyYSQJR3txVgUUEVniJoe8UyxdLmOtr/zYGf?=
 =?us-ascii?Q?Ro3Q/wRJEQgMpG0NcXP6RtaXfvcolBSTgu7yhSiUf9vhyXJn2UETB/vjyoCO?=
 =?us-ascii?Q?Inl0oZud2e7r5GBlYthU0aZ6hVYvz1e62gVgjgQrKMIkXCYf384L09Qwt2VM?=
 =?us-ascii?Q?EjpSfdLs6SBh5BfsBe2XK9B4MRYk/pnTXtHCoTESbWeKYo5wWZfRbbLmo/bw?=
 =?us-ascii?Q?ArrmOdOQsPpC8Y+tJe6CyjPRUr57or3f2nLlYVMhwpqxyMI1F2dSxkywoWUY?=
 =?us-ascii?Q?ffjC2YqHwx32TpCbtc7KtUc8tpAO7S6AolrOwSEwNgaAS75wd598nP1lngeo?=
 =?us-ascii?Q?8vTvkwgjUaQoNVksF9ql1FHRjeiwXYmSy4lAPWA0VCklHLtQIkpupQ4Ha2/3?=
 =?us-ascii?Q?cU6cUYH3Fro+NT3NRfwXkfD0vsU8bmZ0RwKUBbLqqFlg+sjdmrf/3D2S/rxI?=
 =?us-ascii?Q?hlJbyWS77xzdVjmEFjctoIO2nDVy0zHpd3v4hYL3ZfRjC5cxFnaDKT7HWG5M?=
 =?us-ascii?Q?HAjg+4DB4pnviz6lFzUjuy7P4t6l9uLaQZYWIdkuVqCYgvcCuoisTyT+giAb?=
 =?us-ascii?Q?fqkxhSQX7sElz7QPxC0lyhVRX5YsepA6khWop70DyWPjwz7z/4SDu266YMS2?=
 =?us-ascii?Q?H9N9lhW2+aDPrceORQCh2vuQhYaw7GACVA4BCyuPg1dfH/j8j/z882dDUVsy?=
 =?us-ascii?Q?AejoTAekAksp6UVKfF3ReN6Q9+M/xj0dkwtxlpv0AxW44GvsmoHPl6iJMgYR?=
 =?us-ascii?Q?0yhaVfkeZfoWpmXAa/KuWtJ1ct7j0DVAW36kdljxRwNlTOyP1aKX7aGhwHLQ?=
 =?us-ascii?Q?Xdmzoq+Zrn23b98sxIC3EL1JkK6raar8swgHBndWsmIwXEmp7Vz23NMIrKK/?=
 =?us-ascii?Q?hrapgFNaVRPEnOVk16LAEk163B465Z+f3WP+jceXoG3dqmUcJYQ0a3v6Rc7C?=
 =?us-ascii?Q?jthbjS8+ug0SfNZQMLmYQExhbg38fPe6brY9A5OYbOQpb0MMZ4YXJocpynsM?=
 =?us-ascii?Q?3Omc+krLOWswatm2OJrHNSN6GURGK/imOLGZ2OmEtcHQzb2Ee0aFBRLk1uei?=
 =?us-ascii?Q?0TXqfQwv1bOeTGHrgKlBEnoQsQiCG6hol8bGo9QZdmD9EyLcXH/WBY3EmNVg?=
 =?us-ascii?Q?Ey0oilQVQeeZTfCI6iRAyAtxXbT+pXxXbrG1fJswJCGbjenFpcz1z9TbCRng?=
 =?us-ascii?Q?q+HTfzpWL4sNqx9Wx8KvHrJsVxXiePAq9AWrMdjVE6JPeCNNvj1+cUSF4fjT?=
 =?us-ascii?Q?AhSug6dseGz2/wNzKHimbEEv49IdM9d4zPIVsGbkdCzd6hJBqIbKQSkIKErN?=
 =?us-ascii?Q?j7KvPCP4cMVdlrY+hKcqYRwdFEqwsTJRk2lzhnZW0Y+UCyhArvs18aSSvJss?=
 =?us-ascii?Q?tSd4YxdXSjlRhJvz+TQ6FuiX2u810Neu?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Aug 2024 13:39:45.4488
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c7fa7b-c317-4a37-72e4-08dcb61d3bec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE39.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7819

From: Gal Pressman <gal@nvidia.com>

In case of errors in set coalesce, reflect it through extack instead of
a dmesg print.
While at it, make the messages more human friendly.

Signed-off-by: Gal Pressman <gal@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 20 +++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
index 66fc1d12b5ee..455d6ef15d07 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en_ethtool.c
@@ -708,26 +708,34 @@ int mlx5e_ethtool_set_coalesce(struct mlx5e_priv *priv,
 	int err = 0;
 
 	if (!MLX5_CAP_GEN(mdev, cq_moderation) ||
-	    !MLX5_CAP_GEN(mdev, cq_period_mode_modify))
+	    !MLX5_CAP_GEN(mdev, cq_period_mode_modify)) {
+		NL_SET_ERR_MSG_MOD(extack, "CQ moderation not supported");
 		return -EOPNOTSUPP;
+	}
 
 	if (coal->tx_coalesce_usecs > MLX5E_MAX_COAL_TIME ||
 	    coal->rx_coalesce_usecs > MLX5E_MAX_COAL_TIME) {
-		netdev_info(priv->netdev, "%s: maximum coalesce time supported is %lu usecs\n",
-			    __func__, MLX5E_MAX_COAL_TIME);
+		NL_SET_ERR_MSG_FMT_MOD(
+			extack,
+			"Max coalesce time %lu usecs, tx-usecs (%u) rx-usecs (%u)",
+			MLX5E_MAX_COAL_TIME, coal->tx_coalesce_usecs,
+			coal->rx_coalesce_usecs);
 		return -ERANGE;
 	}
 
 	if (coal->tx_max_coalesced_frames > MLX5E_MAX_COAL_FRAMES ||
 	    coal->rx_max_coalesced_frames > MLX5E_MAX_COAL_FRAMES) {
-		netdev_info(priv->netdev, "%s: maximum coalesced frames supported is %lu\n",
-			    __func__, MLX5E_MAX_COAL_FRAMES);
+		NL_SET_ERR_MSG_FMT_MOD(
+			extack,
+			"Max coalesce frames %lu, tx-frames (%u) rx-frames (%u)",
+			MLX5E_MAX_COAL_FRAMES, coal->tx_max_coalesced_frames,
+			coal->rx_max_coalesced_frames);
 		return -ERANGE;
 	}
 
 	if ((kernel_coal->use_cqe_mode_rx || kernel_coal->use_cqe_mode_tx) &&
 	    !MLX5_CAP_GEN(priv->mdev, cq_period_start_from_cqe)) {
-		NL_SET_ERR_MSG_MOD(extack, "cqe_mode_rx/tx is not supported on this device");
+		NL_SET_ERR_MSG_MOD(extack, "cqe-mode-rx/tx is not supported on this device");
 		return -EOPNOTSUPP;
 	}
 
-- 
2.44.0



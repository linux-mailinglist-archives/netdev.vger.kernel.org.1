Return-Path: <netdev+bounces-106018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 168549143BA
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 09:31:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0E4A281EE4
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 07:31:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2443F9CC;
	Mon, 24 Jun 2024 07:31:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="euTPm3wD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2062.outbound.protection.outlook.com [40.107.237.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1983944C7E
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719214291; cv=fail; b=tpcQtOz9ARQpHBmPvoj1J4x1AKTI9SybTctQo2OsTv1DJMULSdMd44xmJNXyFZf/cs18Jd3Qz34ikCPQ2SR4agnn9r8hyaUEawvXp1WnSug/BMGg09uqaeO7GESYk4ovpu9zY7bTmEsv7rWTfM/tS0mMhpALFJ9Mgna1gZ+lP6w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719214291; c=relaxed/simple;
	bh=kmT7ytZO+/KgbmmtdA/VbzVojfVaE3Fk0xK5Xy+kPP4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jGkTLaaI/6YHOVNkkyxLfXbYSg4CDodEEmz/8S5rcExIK1eEAZKWNcVwuV1XEfYZz/ROzm5IBPsqcwlPcYokVj/C5v1TQrYg2fC53jBmDPpYSdklqo9Yupi052VGelsOO2Gzh+PsnpeWxVgH1J8jO1SWpdSju6j/sL9FmNqOUXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=euTPm3wD; arc=fail smtp.client-ip=40.107.237.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KBgsratX2CQ4v41u+Bg1Afe4nKTEux2Q/gtcOQHvJ7N4E23Cn/NsWzLZdljrlziS0Mf0dvNQgwwHx2nMStvntyLePSXELzOzMznFdCGYvLTaZhgymwQlWVtkSONN0bpXzW9RzOAWdsUbaopl75A4IBXoa6mPq6mVOETWxjawRg121q/cZ9DX84VdSu62Y63AqT2nDBPFh9AGjvBfoaxPDcizhPGS4ItAoBr4wwLWFfLnM9bsb06J5bwG6b0sIyqat6tw3f+iAX6yXZ4daRAzWPfA5v4IWVbvrs8TIJ18HxcrzpsWzQjrPI8fJEdSTozs2dzKPzOV/zdPJsAtFTjd+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ws6SU4j2kUTyyd0n2Empvl9Lqh4uwAzAcWENXzTg070=;
 b=fUIXsYdaxovps/DqTckowVsMp+vVG5xQISeahr1J5EtEJuS5ZeTG+IXsWKawXwdFmHySj0Wc7KeGSE9Kf5TuTiRnOB5SkaNvFUjdOXU8obkMd8XSEzjjXrawxQu2aS9OC2bGXc1AfjkfG0vpye8c18lgLS6br7R0e4qCcCffaXwkSojltbQhwz8Iad27x6wG58wHy6Dg6yJTDrUf8qA59q4RPJzPibscOVxVUfbR2dUjuKrOCpvj5/o3Q6RZB23cM1gwdY2dVB3BNA7TO9d6SgI/kXiajUW0ona+wo7NAuhXPJR8lZj/J+FjF2lh1VeHyPFUbWhK7jJI52LJq7Xp8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ws6SU4j2kUTyyd0n2Empvl9Lqh4uwAzAcWENXzTg070=;
 b=euTPm3wDl73roa1DAQe0AACwkoVVk+giMfHj+dgTOHWUvlJfdhJaz9HMa+X42zoNga6vEi6qBArzIGQtGaaeSf5L2J2hkqoE2Ac24U6JLrhSoeusnXP8Ap6j4fRTkNUkNHQWWWUMRcva067o17bgHyzGVX6RF2kISkgVNhaHqln3j3ScwrDHnXuVf+D/SIGgRQ5bVCzznA0oEUdAcOcnUR1gSRallUETqZuXda230fHMfSHVbuEHCIEsUmWYyjxYAFAstwb/QqGfAqHCyPBtIQwXpPkbtfUTi73k2eTb5YG6zVfllh3pE6o2TS6DrUjEdMXp3+T4WxI4EHR+jJt6Vw==
Received: from BYAPR05CA0094.namprd05.prod.outlook.com (2603:10b6:a03:e0::35)
 by DS7PR12MB5742.namprd12.prod.outlook.com (2603:10b6:8:71::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.26; Mon, 24 Jun
 2024 07:31:27 +0000
Received: from MWH0EPF000971E5.namprd02.prod.outlook.com
 (2603:10b6:a03:e0:cafe::27) by BYAPR05CA0094.outlook.office365.com
 (2603:10b6:a03:e0::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7719.19 via Frontend
 Transport; Mon, 24 Jun 2024 07:31:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E5.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.15 via Frontend Transport; Mon, 24 Jun 2024 07:31:26 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 24 Jun
 2024 00:31:17 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 24 Jun 2024 00:31:16 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.182) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 24 Jun 2024 00:31:14 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Daniel Jurgens
	<danielj@nvidia.com>, Parav Pandit <parav@nvidia.com>, William Tu
	<witu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net 2/7] net/mlx5: Use max_num_eqs_24b capability if set
Date: Mon, 24 Jun 2024 10:29:56 +0300
Message-ID: <20240624073001.1204974-3-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240624073001.1204974-1-tariqt@nvidia.com>
References: <20240624073001.1204974-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E5:EE_|DS7PR12MB5742:EE_
X-MS-Office365-Filtering-Correlation-Id: a5df0691-71aa-40a5-990d-08dc941fa858
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|1800799021|82310400023|36860700010;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?72Zr9i4pjeAd8M9TI8jy0wps6g4EiCIV5SySNBAjyUGOWWjqQS4nrhmdbyYG?=
 =?us-ascii?Q?ODyPUCRHsHg2NJtp5V78gzVn+4Jlr+F8AOSEaiaqUssaDMzfWCoJLkWE7ZdB?=
 =?us-ascii?Q?TveDvSroRqDMKdeqKVmtiwSmybOsOCjv1qc4HTNIQ/mj0hpA7Q96TkYAJMxu?=
 =?us-ascii?Q?qcKDYpuhZP2G1lLgcJPqADy4W+n2UHOVwtz7UCPPlOQBafJf1hvRbe5UQT1r?=
 =?us-ascii?Q?xSVEwmyAkv81TuM9BlbrJ5EAZmcCqLZjZbJUBn2uZUqTBSDoFPmQZKy5Etia?=
 =?us-ascii?Q?Rx+NBZv9NuuGghwrI8b8hd2EDRmUCiik8XuFTYK0Mv33uWTrOZwQVW+NLlVk?=
 =?us-ascii?Q?JUhlw5RgM+8LTgcc0Q5ECpW7G9qkXU7q1NBen7+skxMXWbzX0Od8Sd3WIa7U?=
 =?us-ascii?Q?9ga/5qZDK7cEmr0ULUcxVoavPD8OL46hfwxlHXFq6wmX5RosfrDQRKOccfXK?=
 =?us-ascii?Q?wQ95FlBvT0Ev3aA0C2FJnEtvBBNKo6PyyTbSz7KRQ/IYez9hFvs/JS6ESg74?=
 =?us-ascii?Q?wC17AXmvzh0j0mOoyWLdPp6/6x2TH6EvAwXwTRcguvGuT/UWYzreO7VEeRhq?=
 =?us-ascii?Q?jIRJdar7xFDweYSSgfR3uC0/og6S4aGf1l9W2mpOqw/Jjj+T1CPzHwBF2/Ey?=
 =?us-ascii?Q?8JUoXpIHlu6sn82cZcBywBnQiNptzOBGf2RA4d/mRVZBvohSp4rpYLtqxQJv?=
 =?us-ascii?Q?RnS/rgByUSJq1euwaYlp0724NdfcsuOlA6Wk91UwBqk6dwTe6t+hIUlp5hFd?=
 =?us-ascii?Q?JXtaT69u2U4ZNAc2mVPYIrQoNmowkWv5m/qlmj/MiG2R7S7xkSG7wpoXTUyy?=
 =?us-ascii?Q?dCLb/S4StM90q0+sDukI6R+hWn4uT0YJkZkbxrash7gdGphNGIHRODiT/NT9?=
 =?us-ascii?Q?OpQ2ud8DzkpXHIj4jTLfTyOdfzJpObtBrK6QPqiA5rav+nypqhcJqRwhq2A8?=
 =?us-ascii?Q?nIxF/2VhF30y79RwN5orvtP6aW6/2ZVmMSWScuDMtiPms04OdM1lE4YJ9V3m?=
 =?us-ascii?Q?903ftzo67glYhrIOUAmNAF1K+PjLaqD5wfGyyULTOLDmNKPTm4tEciLm6tlV?=
 =?us-ascii?Q?VtJxB8nmEPMYOH0USyI2o67rIWjbIe4j0gHO3ngQWlyQAoiB4n1mqABZNrve?=
 =?us-ascii?Q?6NM8Y/rDQedCVZtZTpLrL3Z2q+Uy0aUjSd0YIjZHH7MNESFNZmdr8Mum9ZKs?=
 =?us-ascii?Q?iFIXWqz2thaIKJKNQfBVUpLgaSbZfHIWiIg1oBo+BDzLavb/X7rBvxItzqJi?=
 =?us-ascii?Q?Baob8HvGiTogXXNeiB9AAVXZrP4xiwlpKC+6Lf1wOIResPBm/OKK8ouWn0BQ?=
 =?us-ascii?Q?+llv8rLGyDNlSmNceveBVswBmPXzo+bs15iJK0ezCfE1bKsnAqOjPOcFCm6d?=
 =?us-ascii?Q?74hoGpD12nrq2KZc2lLxCVIlzXBo4H94xecf1mh7gX8XhSleoQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230037)(376011)(1800799021)(82310400023)(36860700010);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2024 07:31:26.8262
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5df0691-71aa-40a5-990d-08dc941fa858
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5742

From: Daniel Jurgens <danielj@nvidia.com>

A new capability with more bits is added. If it's set use that value as
the maximum number of EQs available.

This cap is also writable by the vhca_resource_manager to allow limiting
the number of EQs available to SFs and VFs.

Fixes: 93197c7c509d ("mlx5/core: Support max_io_eqs for a function")
Signed-off-by: Daniel Jurgens <danielj@nvidia.com>
Reviewed-by: Parav Pandit <parav@nvidia.com>
Reviewed-by: William Tu <witu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/eq.c        |  4 +---
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h | 10 ++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c   |  4 +---
 3 files changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/eq.c b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
index 5693986ae656..ac1565c0c8af 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/eq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/eq.c
@@ -1197,9 +1197,7 @@ static int get_num_eqs(struct mlx5_core_dev *dev)
 	if (!mlx5_core_is_eth_enabled(dev) && mlx5_eth_supported(dev))
 		return 1;
 
-	max_dev_eqs = MLX5_CAP_GEN(dev, max_num_eqs) ?
-		      MLX5_CAP_GEN(dev, max_num_eqs) :
-		      1 << MLX5_CAP_GEN(dev, log_max_eq);
+	max_dev_eqs = mlx5_max_eq_cap_get(dev);
 
 	num_eqs = min_t(int, mlx5_irq_table_get_num_comp(eq_table->irq_table),
 			max_dev_eqs - MLX5_MAX_ASYNC_EQS);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
index c38342b9f320..a7fd18888b6e 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/mlx5_core.h
@@ -383,4 +383,14 @@ static inline int mlx5_vport_to_func_id(const struct mlx5_core_dev *dev, u16 vpo
 			  : vport;
 }
 
+static inline int mlx5_max_eq_cap_get(const struct mlx5_core_dev *dev)
+{
+	if (MLX5_CAP_GEN_2(dev, max_num_eqs_24b))
+		return MLX5_CAP_GEN_2(dev, max_num_eqs_24b);
+
+	if (MLX5_CAP_GEN(dev, max_num_eqs))
+		return MLX5_CAP_GEN(dev, max_num_eqs);
+
+	return 1 << MLX5_CAP_GEN(dev, log_max_eq);
+}
 #endif /* __MLX5_CORE_H__ */
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
index fb8787e30d3f..401d39069680 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c
@@ -711,9 +711,7 @@ int mlx5_irq_table_get_num_comp(struct mlx5_irq_table *table)
 
 int mlx5_irq_table_create(struct mlx5_core_dev *dev)
 {
-	int num_eqs = MLX5_CAP_GEN(dev, max_num_eqs) ?
-		      MLX5_CAP_GEN(dev, max_num_eqs) :
-		      1 << MLX5_CAP_GEN(dev, log_max_eq);
+	int num_eqs = mlx5_max_eq_cap_get(dev);
 	int total_vec;
 	int pcif_vec;
 	int req_vec;
-- 
2.31.1



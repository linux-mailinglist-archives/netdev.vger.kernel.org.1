Return-Path: <netdev+bounces-158493-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 966A5A122DA
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:41:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE4263A94C0
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:41:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C8E23F294;
	Wed, 15 Jan 2025 11:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="cdKvu4R+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2080.outbound.protection.outlook.com [40.107.243.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26592139C6
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 11:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941277; cv=fail; b=BJIx0iMWJghMz7R4ZI2bNZx+2+K0OvpSVK3WrDwQCJ50V4Yme6QW0urg6CdYJ2cHbZPAnjAGpPX9QAZDy9TxcVbAeKBMvJ3qPdJivmu1yXajki2dT6ASylegUIutEYefRgEOOUTlX+l46j4CIpyPS7B55RrRvE81lwFNwipcLkk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941277; c=relaxed/simple;
	bh=Fn1gZZhyPxRc+Zz9NhWZW0Np+eskxeTWbX6FPeAOv6I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHN2DYZ2Sy3VLOaYWTWH0KhY0LVZf0cu1DpKo5gj8PVMYcAWbvisFYks6JD/MWiybiqUhhS6tu74PJGHzVRI9pjnPwMV39DKbR0R7dOpQp+HURRs7JLMUNEagj35r5hRl+GYkoLzrDfenHxs4NwrPQpJXMWFVLmPcg7JMy7Nd/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=cdKvu4R+; arc=fail smtp.client-ip=40.107.243.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K4+nANGyNrBgyLT/rbZa69zG/hLVo7YRIuKwxfSOFb6bvsxim2Falsa1tkTJVwS+QAoQxAZ0cKk/qo3YsJhotW2KD/7YHSphUlndywk+4WWCza/ddvB6naUR8N9nANWJv6JBWklkjknQvmfZ3326kA6ljT1vQlUBpEQ2vppmq8Iv745cL51+XXR82S5GKq3O+e6njqtoIEghMlrhEN0kb69CchrXY4JiafDU+ld3+6XWIn+gG1iRM6swIGYw9ScWnPqJcjmRgQCU+dxv71EtT/CZHCtrMjj4bNmU0LDa+qsDZjZRfk7+tDItCuiyrqxcxqkrEJQVl3EhYo82LO/GXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wj9XCA32A16uO05bPSmruMG0FcA7fgeqnBt+1pV+mzM=;
 b=CUUCMeTY54NyAGoIyoqoBFjA0zeidYFQwuMdgOMHk8njvs3KONIR5QR3HDaOZ38vkfZcAMpDBgvq4UwusSeojB9XQoeigm8UzjYh7NAx0E+B7dxAJ44RDtqZpg8w1Br7Ihcd4C/OoV/qzwXW/buqJgEYT0pyZKD8Xr+ofcMYcSwi1HF8AfZap//U8JHbRDoV0pQl8tOyCneOvag0TTmWXec8LtalobPpsFOwEnhFrSChSW2B/cXbeBxWvmydDUAW85rkoQ/qzvpdgYHDfLFfFbHJwXxHPfx7efePDLZ5TSmFbuA8zpY4uSTNovgMoE4JELSR8iRwMmHgcRTzVe0yqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wj9XCA32A16uO05bPSmruMG0FcA7fgeqnBt+1pV+mzM=;
 b=cdKvu4R+fTsEiqLXGsrb638weLLhVFMfHtv9vrQ8favk7PVYZzi1ZHE4A6fYNyN4RGVOJvV/4Y1+UZi/1MIonEsG2x9euEsluyIS+jY32hlg5GyYCGAcdBLnKhiPOX1mLzWdAb6RDjFcHzI3Coa58gdbssYiw4Vo/9TeJvvhDbh1QPvSz0B97R7Ssy+gF6he1C8Um/TcA+t4WUSaUDmDRZHCv8Khe+vENHuuuw3XD9OAB7IJFWD7ZOrpiBzejqxQv7p081iSDEImZ/22tNDWpiLW/qFcTOt9ivTeJSGWeCs4Vw9mfdbll3R6Vytco67uR38FMGlWTYTbcp2Wlqphpg==
Received: from PH7P220CA0101.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:32d::17)
 by BY5PR12MB4242.namprd12.prod.outlook.com (2603:10b6:a03:203::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 11:41:12 +0000
Received: from CY4PEPF0000E9D4.namprd03.prod.outlook.com
 (2603:10b6:510:32d:cafe::b) by PH7P220CA0101.outlook.office365.com
 (2603:10b6:510:32d::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.12 via Frontend Transport; Wed,
 15 Jan 2025 11:41:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000E9D4.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 11:41:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 03:40:55 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 03:40:54 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 15 Jan
 2025 03:40:51 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Patrisious Haddad
	<phaddad@nvidia.com>, Jacob Keller <jacob.e.keller@intel.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net V2 1/7] net/mlx5: Fix RDMA TX steering prio
Date: Wed, 15 Jan 2025 13:39:04 +0200
Message-ID: <20250115113910.1990174-2-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250115113910.1990174-1-tariqt@nvidia.com>
References: <20250115113910.1990174-1-tariqt@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D4:EE_|BY5PR12MB4242:EE_
X-MS-Office365-Filtering-Correlation-Id: cb21db51-dd5c-4446-3500-08dd3559827c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Uvw1nCOShjKcIU0G5GqvQY833t1SfY7Ovj7AVpX3rW8scxzblAx6Tw5DdFYp?=
 =?us-ascii?Q?cqOcFQdWELpRw5IPUmmURKpiBNPwC88Cgra3OLhW+yr3auVuUy3c8PqtryyZ?=
 =?us-ascii?Q?ctqrUKpsPqHn4sod0N9IOe/W/igQnuN2uEjrdf487ggOngQyFCdKNWbpxulV?=
 =?us-ascii?Q?BOr2mqReyVJkvQUqz4mtu5xlSkFASfm080XqcYKQ1l/UG/3ioM9Cq7DPQatk?=
 =?us-ascii?Q?jCOfohRwvlVJ+7aiOMMHeTZ3J+CiHFF0Cj+Yor7OIMdYKGMjSOHiyQbYg6BE?=
 =?us-ascii?Q?qa9SbKL9/eXFYQ8DFlAiUGDoqe+HcJgkGfDCOvMjQ1AFQT9if7Zyzr/r3JK1?=
 =?us-ascii?Q?rZ0YUJ6q7Z04HlrmExNMkER2uRgm4+Cl99MtZcfPOZBXDUvGoMsoiIV8x5D9?=
 =?us-ascii?Q?QTNkyEqNzEEufBPE45UYH81d2C4xTDPg+4UqrIg/raRg085LNiVN5+UfnPep?=
 =?us-ascii?Q?4LMLhDRlgqM9+vVUwnSV9biWzftv6Kpjz5w1FUSxxIs+jOUBNnYtSL+I09eL?=
 =?us-ascii?Q?8QbjYkGCBCDWE6NeGxsCpt/qdX1Q4OBH7SMCKMNKjFXaJBkEVPlwwI6rXK/I?=
 =?us-ascii?Q?9RMwDn+cMSZsxNF19by/bXONG1z9nMNGve1CdcH7HMMMd9gbnGB+lgiTkKnD?=
 =?us-ascii?Q?YR9tfbG4v8jfhd+cx3gkHxmrPyGNhX8KBJqm8STE5Iy+hvEzq04xsdN6dRYF?=
 =?us-ascii?Q?T8T+StcHVp/jlUkpvwceDbPkmvx8VrW+ZDsWdknIiJK36y2d7HeLD8Sf7eJj?=
 =?us-ascii?Q?/6WqDX2sX5S831aKeuvhUpwSTzmK7fzQEHfQ/j1G4dqVSa5J4JRKZDIGNwGE?=
 =?us-ascii?Q?jBU+3S5CTjXajg8LJ9PmTmZJ5cUach44P7yKvtjFtAR9l6ZyT+hI2sgZjxux?=
 =?us-ascii?Q?/m3o2rlasOo0Px10jrXjLYSl1Rev6jI1r/D6pzQIbQU42RcdRaWwy+Un6QdK?=
 =?us-ascii?Q?iQ9+t355cGBJ8+8aRA9El+8WaSs9t/hSZ13SoN13WOp8xKX0hDFJAaa2eFOO?=
 =?us-ascii?Q?DtTr/Cx98Y4VA1K2y6lwb0IIoLvcLJXpoFsRWdzRcHezYmopaYUe3SyZvjx2?=
 =?us-ascii?Q?pVwYtk41usSplqToUELh9LWzcNB+bBI78qj2Fg1pDtOW1qn1DDZTFe6r3fqL?=
 =?us-ascii?Q?oXOiRz6NdwCo0ujXpWPcJ4t52Q1RheU9SUfivvGPov37J+yJkofB78y23o8y?=
 =?us-ascii?Q?GqPYXsPc6vHE3QQlhi6W9YMAhfEVqxTqHyBIG8jx+2ZqKFIck08gdqlZUEB/?=
 =?us-ascii?Q?RY57NAzxfe2UWc3xXzMt3IQuJ+Z9YGb8ZIaOo4Oh9qv6hGaKfpm8GeRVMBl+?=
 =?us-ascii?Q?yZoK39uWzFLc+K6EL6NcwtScNw3kh3sNQQK6Zbk97FuIAk7VUvJqXOBx7IpU?=
 =?us-ascii?Q?eAEBdl7vzOpaNjniECn4FMDHakj20Uu7wFFi0Gdl02hCUPTfIDRbN6byxuF9?=
 =?us-ascii?Q?K7q/wOrG7nmb/LCGgS6axt/LF+Bx82wUuv7hOENjLwVU0IxwzTwrVg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 11:41:11.2455
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cb21db51-dd5c-4446-3500-08dd3559827c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9D4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4242

From: Patrisious Haddad <phaddad@nvidia.com>

User added steering rules at RDMA_TX were being added to the first prio,
which is the counters prio.
Fix that so that they are correctly added to the BYPASS_PRIO instead.

Fixes: 24670b1a3166 ("net/mlx5: Add support for RDMA TX steering")
Signed-off-by: Patrisious Haddad <phaddad@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index 2eabfcc247c6..0ce999706d41 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -2709,6 +2709,7 @@ struct mlx5_flow_namespace *mlx5_get_flow_namespace(struct mlx5_core_dev *dev,
 		break;
 	case MLX5_FLOW_NAMESPACE_RDMA_TX:
 		root_ns = steering->rdma_tx_root_ns;
+		prio = RDMA_TX_BYPASS_PRIO;
 		break;
 	case MLX5_FLOW_NAMESPACE_RDMA_RX_COUNTERS:
 		root_ns = steering->rdma_rx_root_ns;
-- 
2.45.0



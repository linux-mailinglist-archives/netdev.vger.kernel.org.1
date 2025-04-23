Return-Path: <netdev+bounces-185158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 551E1A98BED
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:54:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF4727A3AAA
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF951A9B3D;
	Wed, 23 Apr 2025 13:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Q3VM7fTJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 325921CAA96
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416413; cv=fail; b=hnJqf3MBqxmNjYNaK626Z8BhBGMxp9jgIyTnRgVATN8+JAd4Mh8fpbJ8pg4nXb5QEagwu1xo8X7MJMag6NegmpUkgWigRs5ZMsEVIznZ4BKVnpsUAKMrJL36rGafr5EqsCEF42M8kiayQ9QCeiRH6MOi05YXl6K4mEWnjWJYzCE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416413; c=relaxed/simple;
	bh=0CwSehzamSk6+RqKqVn3R2KIJCxukx/+oh1GktIb5t4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fM6i6cnOEsqnPAsiz6rlbb8m8o6PKKFw/kkXDyl5jj6Po5RSlrv88PObYZgSc1Rqt94z4S7NT+0RvNcwUopjkeLBzQXtOd1C+YDDJnHc8g0mmMKQZovKIvaRB7IoXy1BOl8kDIgQtH06v1LFTwGg9PMOnPQ0x96z4SEg+QtUg2A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Q3VM7fTJ; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OsJiJBzDoaXXVYJQftBtwwKZwnubmwnt1K7Qnh4SWStsm1FyvvoZWLRhOIDNW+VCZVqrdtbRceLoh/bvnxAShyVjrq/UmTCH6/TtO2OQCX2swa4jHmg+2cZxKFZeOSTCMKvoyZDT4baCOTTBVjEpXPV8ukrROL4esCop0FJssZaNUb82INnQrs5eGwyE7dFw7DfiIsq1nI9tqZ1QZgo9LzDhpz9AzpgE+tkuIEO3GSxzitao/evWROEkALDbKzu5CHsSoMliNPe+UEETbVSvJTUiWBZ3+S1DdkZkDgDRIaAsGF3B1iuQ2pHyavz8cRktpFaJkWIsHCRk8BV71kzIaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lDd3O98WE3De9vokapGoq2oAje3TK+i2ULMMVTmg3Bg=;
 b=xMQIh/vrZlzhUtLZCvWSLLOoYKVdsKdbkFtyL+YrLRAeYT0rBiSSwKRhfwUO8TnzPCCb5ZpO/ZqgMrUkhzj1jJfDdhcW7aIoTUJ4z5X7R8I0L0U0TU6urXEtCT5HbtApDVNvGUXhNDom6jFTZYcPGJfTfwuGJ9OJUL7Sebkv9CCT6KwEX3rN6pswddGjYvXKwvFLpHaJdHmNjG7Fx+MWuKK5w0lFoSvysmgdE6e26Koi//uZvJ6uex6Pag44SRmQZYCHqf5Dg9RxfCVU3S6GlyY34vuLIhIZvl40Nxt0FG/xln0vmWCSFAeDT2jGpH1NwBq11w7FA3O15M+fCbg2Nw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lDd3O98WE3De9vokapGoq2oAje3TK+i2ULMMVTmg3Bg=;
 b=Q3VM7fTJnx0W96Ge06ek4VfFO115eWwiGcPigHgnAhRoZsDobfzXJBwj2yj2HO4PtOrfiWs8BpSgyE6mQldJ5Lv5lFkFlUBmpeBgax+zbyQF1IIZz0XIBxdwPCUoAjdr6e18AWLMJUeB5pNaHYcriwhmovijser8OpnsMJs/mFHDEC+MNUweX5aVp6iIfeEyLtOZ3gWgZ0eZ9DuEnjS3c7MeSjRrjEl99pqBO0tqKCNxAGOzVvzfX5vijNI0CUOLcCm7aihfwYDaeNQhAnjNJp1ur4eN3QDv/6LJXsoESEKtYzpR3s8FnUdtBKw9guU8cV0RT/3DC9iDfvfuJxaO0Q==
Received: from SJ0PR03CA0090.namprd03.prod.outlook.com (2603:10b6:a03:331::35)
 by LV3PR12MB9268.namprd12.prod.outlook.com (2603:10b6:408:216::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.38; Wed, 23 Apr
 2025 13:53:26 +0000
Received: from CY4PEPF0000EE31.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::7f) by SJ0PR03CA0090.outlook.office365.com
 (2603:10b6:a03:331::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Wed,
 23 Apr 2025 13:53:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE31.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 13:53:25 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 06:53:06 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Apr
 2025 06:53:06 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 23
 Apr 2025 06:53:02 -0700
From: Moshe Shemesh <moshe@nvidia.com>
To: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
	<donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"Leon Romanovsky" <leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Avihai
 Horon <avihaih@nvidia.com>
Subject: [RFC net-next 4/5] net/mlx5: Add define for max VUID string size
Date: Wed, 23 Apr 2025 16:50:41 +0300
Message-ID: <1745416242-1162653-5-git-send-email-moshe@nvidia.com>
X-Mailer: git-send-email 1.8.4.3
In-Reply-To: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
References: <1745416242-1162653-1-git-send-email-moshe@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE31:EE_|LV3PR12MB9268:EE_
X-MS-Office365-Filtering-Correlation-Id: f201fc53-c27f-4175-1878-08dd826e37ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LroOHVRAhGC/9y0UVzq6Q4Q57XF5sP6xsuHzK8J6H5Z5ABENGCtgsdKU3JEG?=
 =?us-ascii?Q?zdhuU+Zhe0vUSAUJb5N/DzwadCFmNJrVd2ym6psTrWy25k2iMGHCuNH1BDHb?=
 =?us-ascii?Q?nTQI6syVjHBEt/XzCrHoxumZh33Ta+6Me6GVetxp5g/q5uclBbovebcMBXqd?=
 =?us-ascii?Q?uGHw7OZcpAnwlMRV1jssKpTkWEPPGra2eQrMXuOI7XRWtKg/ZqLLUMFxgtXw?=
 =?us-ascii?Q?QQhfFNuhQGwo1aiY/BHdXI/j8ilCTJY2zhMs5lXu2NKke0lDxS9y0W1W3r0/?=
 =?us-ascii?Q?k3ZnUuRP7FT+1+CjbUy0M+DCnMZ00I77qU/afXnj6cFyrB8KA0d/OfrpFtj9?=
 =?us-ascii?Q?gvcaFD3Hi/eoMEuqILe/Ddd3UHa/Ud/B1sj24NtlGAibmG+1jdXRQtNa6gM+?=
 =?us-ascii?Q?1SqrOvzSo2kF4YDMf/S6+wxzPlj6dKZv05/JhJznXWEAR1YJ5+H/YaIwnIY+?=
 =?us-ascii?Q?FAhCr1a4800MMzq2OLsoLwmdAwT/90h1mqSLv45jQFqKoEEFKMqurQIFxzgr?=
 =?us-ascii?Q?TwvWM8l8WVpGgxzxmwrLTPQHxBjZPAWM60b+HYzZis+iOWF8iay6omk4TYJ2?=
 =?us-ascii?Q?QpSZbk/yCbpbyZZeG2pGihdJ3MRx1dP0XzTlNSMpTS8tZ6zDkqZBo0FsCO6D?=
 =?us-ascii?Q?3X9ttoj9hIpsPIealZiXMz6YkGLj6RAN/gYaqc4W4aYKb9L/Gn9Vru6ZRqiQ?=
 =?us-ascii?Q?VRb7sN7XXq16RwPKZ+ZuWnmPeAKPvukumaBUFwwQVWlESJkNGWRKtaVuwFWw?=
 =?us-ascii?Q?YCR6HefqFMSPpz5PhYJwRapo268tFzioLN4DTlsQ8A8j1yX2KlQaVSRFF0kh?=
 =?us-ascii?Q?qXbzFsS+t52s3JrRxGVLgEzS3Y1d9yitPW3/pyyXrjDHzp56dk0krYWfmfgn?=
 =?us-ascii?Q?EDr3AQG6JLOPT22jGg0AE7xsASQxs2Zp1TnvsBnfE0MlEBAi0WjtANi6klf0?=
 =?us-ascii?Q?6vDCbneLdceC9Yn1Tfm/ELTOaVGdOcdtTmD9rJEgRyYOH4f3Uvo+Zy5re65b?=
 =?us-ascii?Q?CZdYQLo7tvt5uI4w6U0uOdlaaqYDE75hcbfpi2O2brvAHygHhbO5gD3uP48x?=
 =?us-ascii?Q?wSX1jMmEDMeYlkuKm3ADKt0PxLUhlE8QsmGzSiaFo4zDHpGrsScFfRLZGtQF?=
 =?us-ascii?Q?jjEOPxzUTHjjmf9eSKw7eUbAuEEFHUWJNhl21uDahjwshHCAdXxKGeuGH63y?=
 =?us-ascii?Q?c0qIRxsj/MCQbWC/3eNXvtJQtxDLRtKdWaNfF3T0DltBsVHthQk+1B4p2oDB?=
 =?us-ascii?Q?e5ft0UfutuKZ/o8F7JEAk3KChlGWoTDiXwERH+GudTjGPDt4c9cABvLH7lGp?=
 =?us-ascii?Q?QfR3EvdEYKr0C+FyMphPl690LZHhp7ffPRSYRFSnL/jDVSmSfk2qTTumw9PK?=
 =?us-ascii?Q?Nyq32di294eFQkFtk8bsvVu3Evp1wiTOpZxTYmfoiDp5E1oWXtxLxOG65CGV?=
 =?us-ascii?Q?iNwuBBiuo14JpmU8lSbtr/1TZ9xjKB+XlmlvAc2BBUDWXb2H9tOZv9WZps9r?=
 =?us-ascii?Q?Us622iNDI8FL6pdJadzAJN12DLRg0gDsWyON5B0qT7mGZLnIsTHZvB2T3A?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:53:25.1839
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f201fc53-c27f-4175-1878-08dd826e37ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE31.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9268

From: Avihai Horon <avihaih@nvidia.com>

mlx5_core_query_vuid() puts the queried VUID in a user provided buffer
without setting a null terminating byte at the end. Thus, users that use
the VUID as a string calculate the extra byte themselves.

To make it clearer, add a define for the max VUID string size that
includes the null terminating byte.

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c | 2 +-
 include/linux/mlx5/driver.h       | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index 5ebf97475ba9..b759707f5218 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3587,7 +3587,7 @@ static bool mlx5_ib_bind_slave_port(struct mlx5_ib_dev *ibdev,
 
 static int mlx5_ib_data_direct_init(struct mlx5_ib_dev *dev)
 {
-	char vuid[MLX5_ST_SZ_BYTES(array1024_auto) + 1] = {};
+	char vuid[MLX5_VUID_STR_MAX_SIZE] = {};
 	int ret;
 
 	if (!MLX5_CAP_GEN(dev->mdev, data_direct) ||
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 575b1401c018..e636f60a6392 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1127,6 +1127,7 @@ int mlx5_blocking_notifier_call_chain(struct mlx5_core_dev *dev, unsigned int ev
 				      void *data);
 
 int mlx5_core_query_vendor_id(struct mlx5_core_dev *mdev, u32 *vendor_id);
+#define MLX5_VUID_STR_MAX_SIZE (MLX5_ST_SZ_BYTES(array1024_auto) + 1)
 int mlx5_core_query_vuid(struct mlx5_core_dev *dev, u16 vhca_id,
 			 bool data_direct, char *out_vuid);
 
-- 
2.27.0



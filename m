Return-Path: <netdev+bounces-158495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3CDA122DC
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 12:41:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77FF87A3F86
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5B723F28C;
	Wed, 15 Jan 2025 11:41:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tyd0qHoX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2074.outbound.protection.outlook.com [40.107.237.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F12241690
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 11:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736941285; cv=fail; b=ABoLZnx3H81CjHt7KIwctQKvdD113sXmXX1EXYIP8nAqSKZCJAwItbiMgwyF6fslO7jb2hWQjBl7myl5kPQvNnPnyx7Mc92Jcsnq5W9LpXiDtlzkKWYbOPYJemz+9Tw4uD+SXwDBK/e6Gq7P2I+tcrBQdrxulKr56leTbTXvnKA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736941285; c=relaxed/simple;
	bh=2aaeRmBQe13ckPuMSV7Hnn17flfJyd7xknEOMVKvzng=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lc2Y74EzwylI47ppZpF3nQOr6UQ0zaV7Nu39WkjwzoA/hx1EYJZ6DUMx+wTR+gdvtNdvH3dxr93FpHRAk7JZnGCsx/fElYkZWSNIcEsY3kUAdhrnbdJ/lOsLICXJGwWnxsmXxKAhQ3ZWikjKlS37IyyV6nC16W5/xnMuXVzDbKc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tyd0qHoX; arc=fail smtp.client-ip=40.107.237.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hob3uvMYpG6O3bWABAuAD3bT2vytzyyMYCDbrAqZ0NmUe/UqWos5qm4FcemYacJvw4vprMZmu0PcLvfLj0zleDBkIRkmRc8PJ2Siv7SA7HIFPWUFi7jfDW916lvy1P681qnq+q65eVwUVRLWTxaAN51PsVKAd+OAEItglg9gwLVstrg9rNVoOYTinrhqfbedFE9HCMfrM0ML2aIdEo161eF8wZ7S//f5fjKbZdzcOFEzr9i4TYnnOmr8shQAfRPPojgmszE0wKOjM56Fo72g0zPKlcbptGBTcoHzpYdrEOae88/dKzIACfDdIPiw2le5dagKfloZfcOGQu+d+rd3Zg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eUdxjSSlC+UpVmIrrjuBNbrT3vS3utdtk0deQLlhSU8=;
 b=bCa5O0A5Rv8fMFk/IBsMJ+Q6iQfrDcLqCCpCh2MsqVkn2ldRtWuClQwNkZqCaXZfMlJVcfNp23BuPSZ3uHiUKIKGtHrG7Z7p4VGHrQNI47KrRxZOOYCXU2zXpwEFGre+d4WG9n9Aff5e1Mvy+YPqihVA3v3M01mD350jVD5PWFcawmgf079dpy6yiuAIrnYnnbiVRv/j2RIHpfMtdCwfJMkfrBWbgD/8W0CgqJOLpwg+rbu4FiWIfIUyHiM5vWeas/Qw5wlVHrC05sjg7NWxJqJ57q2TvHRB9d+BbzxcMy6Yjo7cUPA+5HRHHb6u3q1baW8JyX7YVed0AiOkQbzBFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eUdxjSSlC+UpVmIrrjuBNbrT3vS3utdtk0deQLlhSU8=;
 b=tyd0qHoX1EouFygLasW6XRceY60IZ8w5HmUPDWMTnh5qi0tgCpuJV5tn5vSQn+PO9r2wM5Xch4dCxcURfS7d9sepNS+PT3nqahll8j6azCXtRkLhyVLT66DgvfeQWfKKeXk9E5YhjVcrRbwxb2Vd4dfDVh0lbVHx1/82838quRMEkfCPIwt59EYr6Kie64dNEVkjQf7nU9nyM5HiEE/opBYURZloyEgFwxJpHq32qAD/77CklMx2PPjZr3WdIJABD0P5V7T2rWNeqaIsnyjUwuSjqM1sdbwgimhcApo4lG4JInZMr3qo2qKOQq4q2KXb/vm16JGC7Cr5OpuLm239rA==
Received: from BY3PR10CA0026.namprd10.prod.outlook.com (2603:10b6:a03:255::31)
 by SJ0PR12MB6902.namprd12.prod.outlook.com (2603:10b6:a03:484::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.13; Wed, 15 Jan
 2025 11:41:18 +0000
Received: from SJ1PEPF00001CE6.namprd03.prod.outlook.com
 (2603:10b6:a03:255:cafe::4d) by BY3PR10CA0026.outlook.office365.com
 (2603:10b6:a03:255::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8356.13 via Frontend Transport; Wed,
 15 Jan 2025 11:41:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF00001CE6.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8356.11 via Frontend Transport; Wed, 15 Jan 2025 11:41:18 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 03:41:03 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 15 Jan
 2025 03:41:02 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Wed, 15 Jan
 2025 03:40:59 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Chris Mi
	<cmi@nvidia.com>, Shay Drori <shayd@nvidia.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net V2 3/7] net/mlx5: SF, Fix add port error handling
Date: Wed, 15 Jan 2025 13:39:06 +0200
Message-ID: <20250115113910.1990174-4-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE6:EE_|SJ0PR12MB6902:EE_
X-MS-Office365-Filtering-Correlation-Id: 759fb06f-1773-434d-7f2d-08dd355986d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IdEo4LG4PA+BiS4kBaZJNJ2GK8OXqxOtCkkWtx4xqXxExWpFytflBLeb7dxf?=
 =?us-ascii?Q?Tsor17vmRHXSf4IxSxWC0kAM5jKQYrrR2j01r2Muvom9sxMT+xqdKYM/wOcD?=
 =?us-ascii?Q?1amRIAnubdI6WLFCnC4CF7BekhbJW5tQIZ+dOqx716O9VOBRi9OCpqe/FQ7y?=
 =?us-ascii?Q?t/KDklDTPgchxPsc+BdiY4hFRGyL0HkYp69pBbELg2rC2s64Modu/i1o+jA2?=
 =?us-ascii?Q?Zue4FEHC1zP3xA7OtYgD2vbVWE49Brk4OykPC9yru+VBkaPYSXorI5dm+X2R?=
 =?us-ascii?Q?hclmEt/R+/YhhE6HhyaHNkHga/zAiDkJDy06zuWef4GTdHt4soQzBhxG9SeP?=
 =?us-ascii?Q?kMKbBuvq1zJzXNmKo2t4yLr8iQKfzltnepZ/4GLFTRjB1FDs1gKpZTgL/T1z?=
 =?us-ascii?Q?sL6Skzbm3/nm2ASXTkNUTOcK7NlQ5FFFnpJp1uhLQ4p7O1y8xg46J2RQ/z7d?=
 =?us-ascii?Q?V1VWdkXYBOs8LWcoUAm9UcJfKBHXYM6RFeyr9GRmRVtiFNz6ifPVmzNBT+zt?=
 =?us-ascii?Q?1mE7ZfgNoKj22gwro9fSIUKf6azyTYg4B6nmfgyGHn796/KZX30jjQLjVV5K?=
 =?us-ascii?Q?O4S3EbOTjsD2mY+U83Z109TFbTyuAvB+tQsVJFchMyn0Suh18hZL9mIB9ErG?=
 =?us-ascii?Q?HOgJHXtwv+kgp1474U1g6Z4i2Nn6scPRImUt7m7LqRJ2x9oz+tE4vkEE2/sq?=
 =?us-ascii?Q?6MgYrnwp18Hf9eiVsTQ48aho9GWI4JAMk4/1ryhMLGZAeGOTEJDhn2rUAgE/?=
 =?us-ascii?Q?dTIoErnlnKQGXX36ynb65RkkA23AQRlqWxAsJJwNI+ThWspEmy1xt6octbzb?=
 =?us-ascii?Q?2bbhQXWoFlGRofBm7EmsEKHu1notx80ibNVkjQfH9QFUDXJr1yYRLvfSNBRj?=
 =?us-ascii?Q?12nXh3QRXkd2NJ2kJi0+cU8AEMm769Tm+5BNP1Qnu+kyu6db/G2XDQ6e+jXS?=
 =?us-ascii?Q?3YCI6wUALwt5aNDbcWuI7LrzHT8wLaIiu3f5HgVEEfF7N/MHx5oBoJtlcdvO?=
 =?us-ascii?Q?b0BqZ5jwPHIEht7FevIC2Cpo0HU+4zjtE6Vw6D7LH+7DECBOaxEGEvy/KGrw?=
 =?us-ascii?Q?YHi7nsuB2M5mdazuVp2WoXdGfEKObXUuC6j2TqEjptAzono+udZ8yCDMIRRk?=
 =?us-ascii?Q?jX4ilKnoYnUnW1LNYyWwWH8XyrJEAVd/aAyySQ4Q0FBqff7wgyE0KVKcBIwY?=
 =?us-ascii?Q?0La21t5YZ91D/1HNruwI53Oqh7BOfVhFUS7OpNIjpvSQUGl/CbJ+paT3Miit?=
 =?us-ascii?Q?iQDJ2pcVwmwxcfNm5Goc7KFdlK2HV1Itb+EcprTQtMZqQsq1jVy7CutQs2Zv?=
 =?us-ascii?Q?8lKcUmG4WXuSFWeigQOWfFJBJbkSyxMk54T7YjVG+C/GPh/xBvtJ1BRTZzKd?=
 =?us-ascii?Q?aCV3xbSjFR949ZKMDSOqMnaMtaPaXIuMoTykaK0MOtpx2bvKkk3VHk0J+b5e?=
 =?us-ascii?Q?MzlaYLxQhcPqFTypPp/m52vxeBaojlgBCfg9j4Lc7pGntHvnQskoY09EZiuz?=
 =?us-ascii?Q?7d/+FGnBosH0J78=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jan 2025 11:41:18.5859
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 759fb06f-1773-434d-7f2d-08dd355986d7
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6902

From: Chris Mi <cmi@nvidia.com>

If failed to add SF, error handling doesn't delete the SF from the
SF table. But the hw resources are deleted. So when unload driver,
hw resources will be deleted again. Firmware will report syndrome
0x68def3 which means "SF is not allocated can not deallocate".

Fix it by delete SF from SF table if failed to add SF.

Fixes: 2597ee190b4e ("net/mlx5: Call mlx5_sf_id_erase() once in mlx5_sf_dealloc()")
Signed-off-by: Chris Mi <cmi@nvidia.com>
Reviewed-by: Shay Drori <shayd@nvidia.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
index a96be98be032..b96909fbeb12 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/sf/devlink.c
@@ -257,6 +257,7 @@ static int mlx5_sf_add(struct mlx5_core_dev *dev, struct mlx5_sf_table *table,
 	return 0;
 
 esw_err:
+	mlx5_sf_function_id_erase(table, sf);
 	mlx5_sf_free(table, sf);
 	return err;
 }
-- 
2.45.0



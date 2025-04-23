Return-Path: <netdev+bounces-185156-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB57CA98BEC
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 15:54:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 420ED5A066D
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:53:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 732A41C6FE7;
	Wed, 23 Apr 2025 13:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tl9DU2B4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2056.outbound.protection.outlook.com [40.107.102.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1411BD9C8
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 13:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745416404; cv=fail; b=HLsFsn21C5zTBkGMptVJx8X6jpWvHneCG3Rk+MAYxY4W4rKVlvIHVhqzUvx5lf9YAzOJe5jQMZAIiP+AFkuwrB+MtU9QKW0i+wWVJnknO8SANZDnRXoY/vAnBAi11/5NVsk+fMJ0eEATcFBXK37+npvihzM5bviilMHYkiju9Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745416404; c=relaxed/simple;
	bh=u0Al83brZWsC96PBh4HGk6IG0kF3dUE8ZWuBn4d0reU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dP6aSJF4m659VPwKO07l4Oj+h3ReIPYh0ctUNBfPzkJRC1zCk9MvaUAuhkpeCkPOIi0uN7hHJrcGilfY6JyGiQVsVIT9ZDY3sAGa9a4o3md1s9xgo6RY3hPwiwaNSK1UKu/CptERhsiQGl8ttpaJzKTjS9XmquipSs6QnskuIDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tl9DU2B4; arc=fail smtp.client-ip=40.107.102.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HNL8gkzggUr1U9PgQ6RK+CwlUPTt1BHwaa8H4ohISsWBfgm010K9RwRBLDOj23cWTMGCiWOY2qflyslm0Ng8xRhzPTr4M55GUr90W0URNUb/9HOL9ZHZ9WZurpaAApF9uvBTHmwtUfjRxilE8jsoOdLtLsBRt8/RV/CwMrnCXshrrFVZLWQcEzywxgsuD5ezURxPmF+1Pdi5MsUaNobuO3ntvdyCgxf3y/vV5b5KIFOPkZ6sFAf4Gp5pATNErYx0Goer6jO1DEmkiYJ8/MT347kDrS6os5+KSj3zhNRUnXlT43HuShSo4MGrFJXKtBrzJtb4ASiRPHECJdR4wnM+pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6FmwvK/J8d9QBoirxqDgKh0SfbqGJTAU3mxE2Y14oLg=;
 b=Z03THaC6vFMeTHlPVlkVdTx6X47n+9GwjfvEQxtlPuMsa/Gu3iMmTWsLMp9+FiMeCyrmA+E7vr8wKw7yhR9kNK1zlaV64IWmWno4qSIuiPC6pQr/NDJ1hD+gFuWkGZHJDTH0007+szIqnnjufnZ48KaSMozK9v6WkTch8nNzBoRIXlpBBjxBU3gpksW6ZQps+WH1sKfQ/UCuCSyNKrCiPM8CwRJPSLALqP6OY9gXwVJaVdeVj+CSP/WkE3jIBIaLhWNALljb4wqxUB7oFfw03uhQYY/LZAEtMc2KeyA/GyjPFqG7tBsBq70IxRVJ40DtMe5VD1K6w8Lk0FQhTXM/9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6FmwvK/J8d9QBoirxqDgKh0SfbqGJTAU3mxE2Y14oLg=;
 b=tl9DU2B498y25/srizwZP+w5gzhs//Rqa9J16HEZrHMBN/OWPmjcpyJXgqaX0YkoooEFpMmJZs9Z7lCNKOyRnwk2zP14gsgJvWDbGwoL1Ojb8WWEWzZXNlmAZAeqWPqTPkyVm/SUOZjLaHvwbeCZI8RHrVGy293c0meJSGgyAWglvpOOwKdEkoVQEMpXXtWpEStDoFOuImUxoEmDmCoK6mYzUb1k+ZyxVqQ5jfZSR/V+/IG3+l+fDhK5eLnQBfba63DVzsCGgPYgTMJoLqU6ROjbbTUA8VIspD4rvHRuhknQc+byyPS9SlvcQ4LVvwnr/ER8zLypJIOCK/Tkjhy8HQ==
Received: from DSZP220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::10) by
 DS0PR12MB8293.namprd12.prod.outlook.com (2603:10b6:8:f3::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.35; Wed, 23 Apr 2025 13:53:17 +0000
Received: from CY4PEPF0000EE35.namprd05.prod.outlook.com
 (2603:10b6:5:280:cafe::d1) by DSZP220CA0012.outlook.office365.com
 (2603:10b6:5:280::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.38 via Frontend Transport; Wed,
 23 Apr 2025 13:53:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000EE35.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8655.12 via Frontend Transport; Wed, 23 Apr 2025 13:53:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 23 Apr
 2025 06:53:02 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 23 Apr
 2025 06:53:01 -0700
Received: from vdi.nvidia.com (10.127.8.12) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Wed, 23
 Apr 2025 06:52:57 -0700
From: Moshe Shemesh <moshe@nvidia.com>
To: <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Donald Hunter
	<donald.hunter@gmail.com>, Jiri Pirko <jiri@resnulli.us>, Jonathan Corbet
	<corbet@lwn.net>, Andrew Lunn <andrew+netdev@lunn.ch>
CC: Tariq Toukan <tariqt@nvidia.com>, Saeed Mahameed <saeedm@nvidia.com>,
	"Leon Romanovsky" <leonro@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Avihai
 Horon <avihaih@nvidia.com>
Subject: [RFC net-next 3/5] net/mlx5: Add vhca_id argument to mlx5_core_query_vuid()
Date: Wed, 23 Apr 2025 16:50:40 +0300
Message-ID: <1745416242-1162653-4-git-send-email-moshe@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE35:EE_|DS0PR12MB8293:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e67f891-31d7-4076-be47-08dd826e32ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|7416014|376014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1hPJsdwc7T62TitNVPTFYW/gax/NkXkygmrDRmxUYtO/F3+YaD2OOJmLb9/t?=
 =?us-ascii?Q?jVIGSjkZRTlt6Cm8TeRSvWhRyGF8JIrmXX7GAN/qq8EZ9HREwe9luazj2cAW?=
 =?us-ascii?Q?aGqwOLEkjoDNXLeoSQDbyn+Oy3lUcVrmtnY7s/sin0dPVo5SSvT/HS1cdMx+?=
 =?us-ascii?Q?We+MxukhLPW+7jBXTHvGxN2Ck+fjQfZS02RLhZnWQMAh3BoK+8ROTCNAnRuX?=
 =?us-ascii?Q?gh8FjcMXACLTFIFyMaIaVUcs6mde1BXBoQ24gyxCTmkSY8S/1LbxkYc9d+Fm?=
 =?us-ascii?Q?Nbp2BdqZLDOsZkWdHTaLyD9qZjnE8fqSrS4zkzam9MMCffOpPmxD264/SxrA?=
 =?us-ascii?Q?fsiC47z3Mcj8BnhGjP5FZNm5PRkPTGTEmLUudyDeUmkQNw+0idoLA4GgM1+1?=
 =?us-ascii?Q?R9ExqnwvbZb2RFHiOpWZf7iWv1CdCm9O9TsetQuUwHLGYeEkZTVEXs5PKY7Y?=
 =?us-ascii?Q?kHqBwjZjEqZpsjGEJpWTnAZg9ZG/s7u+3EBZIh/QU84kAhY6qgKneGnvaLa8?=
 =?us-ascii?Q?A2tvloEBr8xMR/+357owcIs7LDj7GS4fh0yYO3gEAUoXt+9vEPqyOWBzGtMz?=
 =?us-ascii?Q?t/0A/2BVmhAX+sO+0AkRc50EYC6L68VEpBoNMtkM0LqRldBImR2W9927mcS5?=
 =?us-ascii?Q?/j3Qs5NuKDUjnm8ICgDAa8IMdt+kNraLCH4qOrqWlgasHVb57Bt+hzr5/kfh?=
 =?us-ascii?Q?YiXYB8e9LTukUDwV48GLTChYC0kUW2teIhW7zNU1anMn3rBXijpgSu4J/quo?=
 =?us-ascii?Q?S3UkGGbwT/P4fTjSyfO2gMXt9x5Og8zNR1cNN9Xt510BmnB/CpPctCZkFmw8?=
 =?us-ascii?Q?Y+45XYNIt8fBbTbjfl7OpAnV5CDgU34zxzeMdwKTTSFWGShctj6GbYnyjwF3?=
 =?us-ascii?Q?L25Znx59ZnRbQzaxdVmAmp2HRsoZ2L55MussrF+C00MtDRSBdmorjG1VUe2m?=
 =?us-ascii?Q?l40XISDB4A6ldr7sA8S4nMhDS4VbOVPE/w/3rujW4JXJDGJHZxYFY7nIq//Q?=
 =?us-ascii?Q?mP4haGQiDk7UhCb8t1geyAgrE+mz1P0avFBWH9OBc4j73dXm5Tpr3sNNDBkO?=
 =?us-ascii?Q?/ruxTa5gXK+MDjWIWXjDVRbJTeOvqnXhbHB/BhbCBDBZNBc+w/K1Gj58MltT?=
 =?us-ascii?Q?OPWMpjJ7tiQ0QCIcKylynEv23ReN7+KuJFh+a7xIIPYukkjdc8dn7qXZEGqV?=
 =?us-ascii?Q?5wns7r+f0bqVEc537LQzv53/WRi1l9PlhG1GoBtIG2q3al/o2bXXW1y+JLue?=
 =?us-ascii?Q?mGJO3P7xBHnID8hPrpIdXt1BHkxG07w0uT9/1SVuEMLw6zY0S2ewvwCsKBCT?=
 =?us-ascii?Q?nUxNj0Jo7hbq/ZMQTrY4fyk5FEeO6Ld2yOr/N+X1tGaEjjdz3eh7ObQuaQ/p?=
 =?us-ascii?Q?okIbf92IxU75vCGXft1PA2g7O2wn+lkOI8QI3NqlQkDbQyJV+lAFXtH8eUhW?=
 =?us-ascii?Q?k0KTSksXiYTJcRo4hps6tQFNzHtVZJ3+jaCaBl5IzwnhNyGDT755HmNnAGhH?=
 =?us-ascii?Q?PtRSQRhuFSFnj+hXY6U5RXHNelDHZ96pz/YhkWMt0DykXK977y1OtlUh/Q?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(7416014)(376014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 13:53:16.7527
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e67f891-31d7-4076-be47-08dd826e32ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE35.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8293

From: Avihai Horon <avihaih@nvidia.com>

Querying VUID of a specific vhca_id will be needed in the following
patches. To accommodate it, add vhca_id argument to
mlx5_core_query_vuid().

Signed-off-by: Avihai Horon <avihaih@nvidia.com>
---
 drivers/infiniband/hw/mlx5/main.c            | 3 ++-
 drivers/net/ethernet/mellanox/mlx5/core/fw.c | 6 +++---
 include/linux/mlx5/driver.h                  | 4 ++--
 3 files changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/infiniband/hw/mlx5/main.c b/drivers/infiniband/hw/mlx5/main.c
index d051c9d9a07d..5ebf97475ba9 100644
--- a/drivers/infiniband/hw/mlx5/main.c
+++ b/drivers/infiniband/hw/mlx5/main.c
@@ -3594,7 +3594,8 @@ static int mlx5_ib_data_direct_init(struct mlx5_ib_dev *dev)
 	    !MLX5_CAP_GEN_2(dev->mdev, query_vuid))
 		return 0;
 
-	ret = mlx5_core_query_vuid(dev->mdev, true, vuid);
+	ret = mlx5_core_query_vuid(dev->mdev, MLX5_CAP_GEN(dev->mdev, vhca_id),
+				   true, vuid);
 	if (ret)
 		return ret;
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fw.c b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
index beef8a279001..a5e56380d3ea 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fw.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fw.c
@@ -118,8 +118,8 @@ int mlx5_core_query_vendor_id(struct mlx5_core_dev *mdev, u32 *vendor_id)
 }
 EXPORT_SYMBOL(mlx5_core_query_vendor_id);
 
-int mlx5_core_query_vuid(struct mlx5_core_dev *dev, bool data_direct,
-			 char *out_vuid)
+int mlx5_core_query_vuid(struct mlx5_core_dev *dev, u16 vhca_id,
+			 bool data_direct, char *out_vuid)
 {
 	u8 out[MLX5_ST_SZ_BYTES(query_vuid_out) +
 		MLX5_ST_SZ_BYTES(array1024_auto)] = {};
@@ -128,7 +128,7 @@ int mlx5_core_query_vuid(struct mlx5_core_dev *dev, bool data_direct,
 	int err;
 
 	MLX5_SET(query_vuid_in, in, opcode, MLX5_CMD_OPCODE_QUERY_VUID);
-	MLX5_SET(query_vuid_in, in, vhca_id, MLX5_CAP_GEN(dev, vhca_id));
+	MLX5_SET(query_vuid_in, in, vhca_id, vhca_id);
 	MLX5_SET(query_vuid_in, in, data_direct, data_direct);
 	err = mlx5_cmd_exec(dev, in, sizeof(in), out, sizeof(out));
 	if (err)
diff --git a/include/linux/mlx5/driver.h b/include/linux/mlx5/driver.h
index 424090e62917..575b1401c018 100644
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@ -1127,8 +1127,8 @@ int mlx5_blocking_notifier_call_chain(struct mlx5_core_dev *dev, unsigned int ev
 				      void *data);
 
 int mlx5_core_query_vendor_id(struct mlx5_core_dev *mdev, u32 *vendor_id);
-int mlx5_core_query_vuid(struct mlx5_core_dev *dev, bool data_direct,
-			 char *out_vuid);
+int mlx5_core_query_vuid(struct mlx5_core_dev *dev, u16 vhca_id,
+			 bool data_direct, char *out_vuid);
 
 int mlx5_cmd_create_vport_lag(struct mlx5_core_dev *dev);
 int mlx5_cmd_destroy_vport_lag(struct mlx5_core_dev *dev);
-- 
2.27.0



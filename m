Return-Path: <netdev+bounces-90188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0AAF8AD0B8
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 67DDC28B38A
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF680153560;
	Mon, 22 Apr 2024 15:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="mSbwq1gl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2056.outbound.protection.outlook.com [40.107.95.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02CB315350C
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799754; cv=fail; b=GHYLF6HKSOyeTehpZA+hj8sNfswYYaHrc+POuT5dYDUgym0tSv1E+W4d+wMAzPPj4C0JAF4XDHhtZgW6qKnqd2+2x2p+2NKtO04lO1k+gZoh6WOfm8Zdtk2IoIeowcFpKzNPghT0P9z1tkrSnHEFPkRSjQhhwwjZq7wkteUtBr8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799754; c=relaxed/simple;
	bh=a4S4Ri0swmwO2O4rKAuTXHYYewl/nlZ3DTU3KE7ni0w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCc6OzifYI6IrnIwx2rwyfrDro0mxDdDMkiqD31shGxyaod4mcxbmwtd0PwZ3FwKAzcnI7G+H+K9KRe8X4NhanJ7zrHJowfHxCpVMiDkYf6ksnSU2ijkkbSfEMsHeThZ3i7Q1vccRZ6kadWtABJA9Csl8yRhipWfOjputfuN6ng=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=mSbwq1gl; arc=fail smtp.client-ip=40.107.95.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZoDRN42jUGyKBw8uAfeJk9/89ky0779D/gDqiHzOD+nShQFEmXlwWHRTwPn54aRNFZK9Lt6RFqJy5Vw5ZaZmEekC9AEJfIc4iDPVYqnB2w69Nw3LFr9WiZvTxGx1uNVFIFOvHh7LnBCBb9g+IjbIZL9x1zrgjqkdcJdGr+nftzCqrpNTcwAdd7M23Zn+hlzTjt3Plx5A4qg+m14BzzMuqBY5SSCKpNI5ZkmdaKk/psuoKmtrqh9Abwc75zw5guRKFQvYYKlksxytNGCZtyRzB/dsml3Yf1u/z2r2V6pjJPT7wkHxRKLduPvNADB9xi5A63WaiLBN+xicIaDFaQ0nLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BSrp069sawwfwVnbgBJlTWQHFARtI0rPuo7xKXhOrjU=;
 b=i1WuS9BKfPWF12nSozKZxiDoiz5IT0KoS4FgQOpGZxFtvd3iAjp4c5YRKKJuFV7fhowm3Ga9T0+LVW+/j1DnspQt2LIQDU+wkDCia6V5GiRLpzics2aWcOQLnptANW0jF7x+tUDlHWTBOQAFH69aTHNpSbmQhSSQjwh7p4oDFXMOy3UIZD/9Fxqqrba1EAgrYbjMxv+530bY/mSwVyr6aBHrcJdUxOsRSGajOzplqeuquzD6hcJC83OzsX8HelSokk4kAWgHvPPA9zzOHqhysUgnLCQv2CqNlod0bmrMtYInoJc+eDJbXu1DPmlHBd5se8zDbVeM67sVGgy8pGtsHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BSrp069sawwfwVnbgBJlTWQHFARtI0rPuo7xKXhOrjU=;
 b=mSbwq1gl/Eoel2nGbLh2teEiUX5tl4xbpXcHiQOGXCgZDW6gRMiPojunigNMlYaxsYhLofoF+zehV9b5nyjRRObWOtEcRkrmmcdeH8DWQ3tHTasN7nsr3MDvWgYS61Mrqwf+QFOwzPyRLfS1RBa5TQh4zgPMDjsQvlpxV6KNZRrYF10ja0I0givu9wI+poqDP6BHJ706t9w17AuYQVwIN7+2PgXXwjCzijtbSOgSy1MyacIYbfwSlOzgxZzsL07cRI92U+kuaTOlUr6PwV2jQtJMgthZ35S4lFymGTJRGjTwVVRgBNtrqsMI5Dw/BHrVDssSNyydEc9MzbcwGqMjFA==
Received: from BN0PR03CA0046.namprd03.prod.outlook.com (2603:10b6:408:e7::21)
 by MW3PR12MB4380.namprd12.prod.outlook.com (2603:10b6:303:5a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:09 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:e7:cafe::c7) by BN0PR03CA0046.outlook.office365.com
 (2603:10b6:408:e7::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:28:50 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:28:46 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, "Petr
 Machata" <petrm@nvidia.com>, Alexander Zubkov <green@qrator.net>,
	<mlxsw@nvidia.com>, Amit Cohen <amcohen@nvidia.com>
Subject: [PATCH net 1/9] mlxsw: spectrum_acl_tcam: Fix race in region ID allocation
Date: Mon, 22 Apr 2024 17:25:54 +0200
Message-ID: <ce494b7940cadfe84f3e18da7785b51ef5f776e3.1713797103.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.1713797103.git.petrm@nvidia.com>
References: <cover.1713797103.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|MW3PR12MB4380:EE_
X-MS-Office365-Filtering-Correlation-Id: da6e7469-101b-494e-7326-08dc62e0f45f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Tu3FrgDxpqC2SuJPuxTWqa/um7hbKKd9IxclkxUEFRwe2sPh/cdyaXL0mk72?=
 =?us-ascii?Q?/TM5uoUHScbF8xeccaaEb7DcBPrvORlA8e4aEawWwj/TDvxMBzmiCodJarI/?=
 =?us-ascii?Q?7PAn4lNjV3awviSjQ53+Xza/EkoD/xx5ZkeAx0a9CvFI+3EmeR2kKf60M4JT?=
 =?us-ascii?Q?QWDHQ+vA52FlVChjFEYeNvq0W38M0i9351jzQjvpopJNNn8LmwPfejETb8Te?=
 =?us-ascii?Q?z9xH7l8PoHty0ksQL/lAR1j3RL0TBFkAem0vI4J/fs7wJ/yZHrjsVJM0msr4?=
 =?us-ascii?Q?NciL5cOU2KTl9W7eG7EZqZ9q3+IR7Uki78564M2hAtwNtC6YTcW8OJIslMd3?=
 =?us-ascii?Q?1SSEmkWE7eyfuBgXTeUyf/Q6aGO+iDPE/nMozzfiFJqVzS7K6wgfyA7g4Wad?=
 =?us-ascii?Q?iqmUzrhGSwSRQHtdw56pXcsemOsOEKlZC4krG+8bVwswQh7HFZwiMZI8FeNe?=
 =?us-ascii?Q?KrA0puNODgewiayT7IewKfTWDh8IbmCnrr7AvFkeIUdlquXnuwu/wWADcaAt?=
 =?us-ascii?Q?tuYMxW3JneZGgyEl2R0CBiQI8UkvRW3B3sYhw30+urODpDCfS1TPO0oj/BCs?=
 =?us-ascii?Q?zFvCHRoGJ5JcIhP1mHCKhKaO5kQkXvCrd9GF3qm7uZkf1BR+i4sFUUYHXkyJ?=
 =?us-ascii?Q?aSqRYv3R7NX8n0UQqtpikKYDGXzisbumzp1HxlZbgFR+AlkMvJki6RUwKQdn?=
 =?us-ascii?Q?dscuBTwVjYUouKygDvsOX9QQo9aRplUkYWuaU4SM/xooQU/1hJSKO3usiVmn?=
 =?us-ascii?Q?nSzK2m2xFimkQfxOHLSnbXGBsUlsSuVNussHY5T70j3Sm5qhCDhKFk94CfZJ?=
 =?us-ascii?Q?cemarHa/HVCy5RsPAONSzhnUjo+ghIjj8DKcxg+sTodH1Nzz/9SaUOCWcuvF?=
 =?us-ascii?Q?QAq8bq5BDPGXKLF3wzTedlCf95tCsmbo8/SnVjVXb0EJR5oSiupW2s73nJh8?=
 =?us-ascii?Q?XRXe4p769jlq/czVKueT1S0s7UQ6veGNfnqjsGE7Jtqjaq5RlOa6N5n87ogh?=
 =?us-ascii?Q?4DcPYhwMAjSddJFYor7tBjZK2whpy45DIrUoxBFyQZsWvAb/264hwMZ3vw87?=
 =?us-ascii?Q?WftDXXdbuuttdOfFBTl9Svu6SApXc6JePTjoE3Dt+CUo4e2Y3qEgfTv5c/o5?=
 =?us-ascii?Q?Jx+31Oe/npE7J065B2ELEKLqwp7YZcx/X+OyqwGYY299Lvk/K/blKBSlWy0+?=
 =?us-ascii?Q?EwhJiWBUiTbh8USNQTxD1YxbKnF6SX+HvaBK6QZOEwLL3Hds2lRi23tRZs7r?=
 =?us-ascii?Q?dq1q6/ALGzLelNfrUAZO0Lv1lZvpKCaoIS6+wOyBbioFQoZO9z7uIJdQQEFR?=
 =?us-ascii?Q?AleB2ny5rivxGmBJoIzcp1Z06ZbVNtfN8nj7ymyMD1CmdvkXwZoK6Jc0B9qZ?=
 =?us-ascii?Q?W4m6AWTHM4yqvB1unIiDf7ah7eRY?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:08.9828
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: da6e7469-101b-494e-7326-08dc62e0f45f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4380

From: Ido Schimmel <idosch@nvidia.com>

Region identifiers can be allocated both when user space tries to insert
a new tc filter and when filters are migrated from one region to another
as part of the rehash delayed work.

There is no lock protecting the bitmap from which these identifiers are
allocated from, which is racy and leads to bad parameter errors from the
device's firmware.

Fix by converting the bitmap to IDA which handles its own locking. For
consistency, do the same for the group identifiers that are part of the
same structure.

Fixes: 2bffc5322fd8 ("mlxsw: spectrum_acl: Don't take mutex in mlxsw_sp_acl_tcam_vregion_rehash_work()")
Reported-by: Amit Cohen <amcohen@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 .../mellanox/mlxsw/spectrum_acl_tcam.c        | 61 ++++++++-----------
 .../mellanox/mlxsw/spectrum_acl_tcam.h        |  5 +-
 2 files changed, 30 insertions(+), 36 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index f20052776b3f..b6a4652a6475 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -10,6 +10,7 @@
 #include <linux/netdevice.h>
 #include <linux/mutex.h>
 #include <linux/refcount.h>
+#include <linux/idr.h>
 #include <net/devlink.h>
 #include <trace/events/mlxsw.h>
 
@@ -58,41 +59,43 @@ int mlxsw_sp_acl_tcam_priority_get(struct mlxsw_sp *mlxsw_sp,
 static int mlxsw_sp_acl_tcam_region_id_get(struct mlxsw_sp_acl_tcam *tcam,
 					   u16 *p_id)
 {
-	u16 id;
+	int id;
 
-	id = find_first_zero_bit(tcam->used_regions, tcam->max_regions);
-	if (id < tcam->max_regions) {
-		__set_bit(id, tcam->used_regions);
-		*p_id = id;
-		return 0;
-	}
-	return -ENOBUFS;
+	id = ida_alloc_max(&tcam->used_regions, tcam->max_regions - 1,
+			   GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	*p_id = id;
+
+	return 0;
 }
 
 static void mlxsw_sp_acl_tcam_region_id_put(struct mlxsw_sp_acl_tcam *tcam,
 					    u16 id)
 {
-	__clear_bit(id, tcam->used_regions);
+	ida_free(&tcam->used_regions, id);
 }
 
 static int mlxsw_sp_acl_tcam_group_id_get(struct mlxsw_sp_acl_tcam *tcam,
 					  u16 *p_id)
 {
-	u16 id;
+	int id;
 
-	id = find_first_zero_bit(tcam->used_groups, tcam->max_groups);
-	if (id < tcam->max_groups) {
-		__set_bit(id, tcam->used_groups);
-		*p_id = id;
-		return 0;
-	}
-	return -ENOBUFS;
+	id = ida_alloc_max(&tcam->used_groups, tcam->max_groups - 1,
+			   GFP_KERNEL);
+	if (id < 0)
+		return id;
+
+	*p_id = id;
+
+	return 0;
 }
 
 static void mlxsw_sp_acl_tcam_group_id_put(struct mlxsw_sp_acl_tcam *tcam,
 					   u16 id)
 {
-	__clear_bit(id, tcam->used_groups);
+	ida_free(&tcam->used_groups, id);
 }
 
 struct mlxsw_sp_acl_tcam_pattern {
@@ -1549,19 +1552,11 @@ int mlxsw_sp_acl_tcam_init(struct mlxsw_sp *mlxsw_sp,
 	if (max_tcam_regions < max_regions)
 		max_regions = max_tcam_regions;
 
-	tcam->used_regions = bitmap_zalloc(max_regions, GFP_KERNEL);
-	if (!tcam->used_regions) {
-		err = -ENOMEM;
-		goto err_alloc_used_regions;
-	}
+	ida_init(&tcam->used_regions);
 	tcam->max_regions = max_regions;
 
 	max_groups = MLXSW_CORE_RES_GET(mlxsw_sp->core, ACL_MAX_GROUPS);
-	tcam->used_groups = bitmap_zalloc(max_groups, GFP_KERNEL);
-	if (!tcam->used_groups) {
-		err = -ENOMEM;
-		goto err_alloc_used_groups;
-	}
+	ida_init(&tcam->used_groups);
 	tcam->max_groups = max_groups;
 	tcam->max_group_size = MLXSW_CORE_RES_GET(mlxsw_sp->core,
 						  ACL_MAX_GROUP_SIZE);
@@ -1575,10 +1570,8 @@ int mlxsw_sp_acl_tcam_init(struct mlxsw_sp *mlxsw_sp,
 	return 0;
 
 err_tcam_init:
-	bitmap_free(tcam->used_groups);
-err_alloc_used_groups:
-	bitmap_free(tcam->used_regions);
-err_alloc_used_regions:
+	ida_destroy(&tcam->used_groups);
+	ida_destroy(&tcam->used_regions);
 	mlxsw_sp_acl_tcam_rehash_params_unregister(mlxsw_sp);
 err_rehash_params_register:
 	mutex_destroy(&tcam->lock);
@@ -1591,8 +1584,8 @@ void mlxsw_sp_acl_tcam_fini(struct mlxsw_sp *mlxsw_sp,
 	const struct mlxsw_sp_acl_tcam_ops *ops = mlxsw_sp->acl_tcam_ops;
 
 	ops->fini(mlxsw_sp, tcam->priv);
-	bitmap_free(tcam->used_groups);
-	bitmap_free(tcam->used_regions);
+	ida_destroy(&tcam->used_groups);
+	ida_destroy(&tcam->used_regions);
 	mlxsw_sp_acl_tcam_rehash_params_unregister(mlxsw_sp);
 	mutex_destroy(&tcam->lock);
 }
diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
index 462bf448497d..79a1d8606512 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.h
@@ -6,15 +6,16 @@
 
 #include <linux/list.h>
 #include <linux/parman.h>
+#include <linux/idr.h>
 
 #include "reg.h"
 #include "spectrum.h"
 #include "core_acl_flex_keys.h"
 
 struct mlxsw_sp_acl_tcam {
-	unsigned long *used_regions; /* bit array */
+	struct ida used_regions;
 	unsigned int max_regions;
-	unsigned long *used_groups;  /* bit array */
+	struct ida used_groups;
 	unsigned int max_groups;
 	unsigned int max_group_size;
 	struct mutex lock; /* guards vregion list */
-- 
2.43.0



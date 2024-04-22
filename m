Return-Path: <netdev+bounces-90191-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 07A9E8AD0BD
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 17:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 678A1B249DE
	for <lists+netdev@lfdr.de>; Mon, 22 Apr 2024 15:30:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2867715357E;
	Mon, 22 Apr 2024 15:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="T7nVr9mw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2061.outbound.protection.outlook.com [40.107.220.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C850153503
	for <netdev@vger.kernel.org>; Mon, 22 Apr 2024 15:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713799771; cv=fail; b=akrjwDp3zfYWoZbFPZKbhOZwY6G+dpZHBn+Q+hpz1Cj6l2ENy3ZnN8fVQ0rZ4qV5Amgag9r0BAqeLoiHUKXfOolYDB0ZoQgQMFyLkJ4UeJlnXctsGlkyYqR5qvvmzCiJmtxU2PJPVlW9GwCmfDcxoCCUII9SRYKUaFdCBrBtn6Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713799771; c=relaxed/simple;
	bh=Y7Z5EoeVZCqtlXj2ln+Jl8DvaG8afwfAVTOYdE+ep6U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GLay0M2uPXL9E6tN9Tl7SMO6mXrqGuvich2hA6J9156YaXxRfzN4rvbWYouUYIKnHcsefyeu0wKNpm3fE8dD7R3722sj4TvnfeVKZPtrInJd8crR2cGYmCRHCcetsH4uusA7GydybpVu/FlBkC4Z8c4Vm9UVrwYDCTx8Y+5QcwQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=T7nVr9mw; arc=fail smtp.client-ip=40.107.220.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKZX2S0ULGY/FVRLMxryFbq5JbqP3FiSCMAcyMONOdIKAneWM6wX7RCRNB9eaoFORX84ODQ2VKq+3HxsIQh+HWcQDIFOe+VMMH6X1rt7+XVQnaKV0cE2fC81dEkhN7jJlfxuzud2KUBVfIGvMIDc45IikLTo8D9QcGjF3WBXZIWoekNKIfkrcVQZwaUEfkRleIGx8AjHMylhhvjMUfGRb09aFsyOxY6Ptr2QUgb8tnnD7D7MZFmd+0wrWwmUEapVXPG9K+drgOQBbJKPhf58YKFwHlvuGqTIvLvmCBLHCB+iIu0Cz9/ogACiiU/sQ4XlALmvJW39UqA8YoSE2FgdFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sctuDcEJLQnxwZdOoVs2WOmWvQwyvvEClGVRjiPf65g=;
 b=aSkHswHsUPsfKAVC7MAyVjdjV90yPASw06frvf1oJ6yZuHtT24BuaYMs3+0d/OsB5v34P3FsSHYJtjI03g7hgoEpYhuTmTQTj/VHO0UG4cHRCuz2oqrc3Kv9vWmj892RTOtYRKFRYcrX2F1cV3YWSoQOG5/p7n1xshO5781Hrb8NgXG8uVByq23KYs7lPphBBdvfJmsrRNGf+mWKh3aCgNRGcV8DOo0pyOtjqTCSa754lExEGvvSnVEE1x21Ah7PYbVqdinXpBV2YPsyEh6/qLASOI2Z+r+oymd/n7lDBAIWU75AhgtJvkmMGXF7eBPqrtkv1AuGe/tTUdAKP7w9lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sctuDcEJLQnxwZdOoVs2WOmWvQwyvvEClGVRjiPf65g=;
 b=T7nVr9mwSckDihOXSKSBTE3S0Pp09xNgA6jURCQYKpvvmu7iPyC3OhAr9Clq5555I1eWQyZCSfxQkXT7q1imoRNHfANUyw1gyukar03uESLfQsmhPMtuod+ImE4/PFIOPvz/0frlMn2wf0+1duIL8qTC0kI/7V4vI/LrhLd5tICx73MH12+UcdMR5L05efiYIaEv6ehCu3D681WXTYUEc9qkORiBIvSf4T7hbUsP6RzH7FaVG1uCXN6fAgWL6h4tYiEns+/tZ8GSdYbMMSFRwNHeajsO7RRRt90j4iK9Ws4Ym/JZkl/wVxREVnCE3PK1KfAuL8v1gmvwLrYT0y5tzQ==
Received: from CH0PR04CA0002.namprd04.prod.outlook.com (2603:10b6:610:76::7)
 by DS0PR12MB8246.namprd12.prod.outlook.com (2603:10b6:8:de::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Mon, 22 Apr
 2024 15:29:26 +0000
Received: from CH2PEPF00000148.namprd02.prod.outlook.com
 (2603:10b6:610:76:cafe::29) by CH0PR04CA0002.outlook.office365.com
 (2603:10b6:610:76::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Mon, 22 Apr 2024 15:29:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000148.mail.protection.outlook.com (10.167.244.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.19 via Frontend Transport; Mon, 22 Apr 2024 15:29:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:29:09 -0700
Received: from localhost.localdomain (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 22 Apr
 2024 08:29:04 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Jiri Pirko <jiri@resnulli.us>, "Petr
 Machata" <petrm@nvidia.com>, Alexander Zubkov <green@qrator.net>,
	<mlxsw@nvidia.com>
Subject: [PATCH net 5/9] mlxsw: spectrum_acl_tcam: Rate limit error message
Date: Mon, 22 Apr 2024 17:25:58 +0200
Message-ID: <c510763b2ebd25e7990d80183feff91cde593145.1713797103.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF00000148:EE_|DS0PR12MB8246:EE_
X-MS-Office365-Filtering-Correlation-Id: b4e22d39-ac32-4a8b-968f-08dc62e0fe79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?j6r0RluA3Gw91sdhMhJtr/a+jn3wE8R0N9BPILG+EunQLEhERa/uDItuL56M?=
 =?us-ascii?Q?4INp4TvUrZdg1QpSMDsykP7J2xaVXnCBZwi2WFE65HIz1DJZH0qzjGfpHFig?=
 =?us-ascii?Q?Oq5fNHWVHlNTZxb8jpks8VZm/e4zBbNHRAoMH2OWtCK3HyL+LHK6jj4ec9TO?=
 =?us-ascii?Q?j7rGnE50LMoah/36ceO7sxKt4V//O16pEH16s7kyhB6YPq26g9GbFSHM9gRB?=
 =?us-ascii?Q?83xNjjxGPntbTYYp2T1Sy4gsTbmgyAmCTgrmu0SsrSsaGUtcqmftZMs+iUaX?=
 =?us-ascii?Q?Wnkp0VTJgiKfXlAOtf8tE2MPj713vKMjPc5iie5hCzcVVvZlec1bmWVjTXpN?=
 =?us-ascii?Q?DUehdhRU40Zfj2AtjcLB46P8apyLMhd6DuHOvPYFDpep+7XVOOpVGXTdjLKH?=
 =?us-ascii?Q?lbaILAZDb9FWmW0e/g83VAn6QoUCbk4OVw57igqxNnK+KB7LZGvceDOF+lWl?=
 =?us-ascii?Q?gVo1mVqDGhuxQMiDX1CPttDttTr7zse9/nWMGyUG+Mj2/7WgOEuiewDoT/mm?=
 =?us-ascii?Q?oj/kTMvoJjr59GBL8ASZ6jXU5Ka8KcXZHms0l5KWtZ9jMdsbOr+rjnIMfPat?=
 =?us-ascii?Q?lijAdTcZR8i1CIxcXKdNhkFKMsONoU4eqzjwM1iOVSw7bUfrN2AGlMrsER0K?=
 =?us-ascii?Q?dmC7qLTdXVQd6CLqm5gyWp8eCypKnwxT1B70M1hiamE6zao2jfnzlSSla6jB?=
 =?us-ascii?Q?DJrSMXe3A1KGvuFu5AcvS0TgpF1EdMvx+tcpEN7wi3cQtFaKqo3dMUVOPKBG?=
 =?us-ascii?Q?B8lnm55g0GK3xpVlGkSQb0Nr+H7kxDxp6U+z2kDQAuSvyGdk9MSUQrAbGB4+?=
 =?us-ascii?Q?c5BrxOdUuN9LTtrIrh0wBoW+tQk1YtWPymJZmJqit2JDdkGbal6WcBj7kQ5A?=
 =?us-ascii?Q?tTLePRFu4hTBxGlfzpRzZ0v9rEQW+YOGRWj9WcwKohoaWia3MwfwZs5bO2TH?=
 =?us-ascii?Q?YpGCr7N0WCnWLQdhdgiCBTylmzmUKU4y4OfGcPLTVMNtVsNhlLTZiNQKImx6?=
 =?us-ascii?Q?eRu6sjUCi/3bdKeXfQiONoIb7QBZg6kXuOx48jPjTDXdadqvaAqdyBGqUimQ?=
 =?us-ascii?Q?Iv8aEFlCa8sEEtM+rFAaaEUeHZ5iQQPyblZlEMpBWoRBWezptDwjOLOjcd/i?=
 =?us-ascii?Q?ufoXgoeawHveSyKVJkpDEOCnRQgFml2CQ1mxtkPglY35voqvxRMHe8K8nTg/?=
 =?us-ascii?Q?tgcWOZalxq2h48bGPbGue20YQDmkRpqb6CtW9C8putQ/BfIYCCf3Up5F52DZ?=
 =?us-ascii?Q?aC3v6iLZebc5Ai7y34ZZ1wH6ObST5qMiCXwixC8f+T11FaRB4Prieo6iVFc8?=
 =?us-ascii?Q?mbQoqj1odEOp9d3E1nOwqLtgeKanmxVPE3psaoQxCo//XHOeGwD2L1rA52Ez?=
 =?us-ascii?Q?3QhYfB6TesF0CdifYGScLEHE6wOk?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(1800799015)(36860700004)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2024 15:29:25.9782
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4e22d39-ac32-4a8b-968f-08dc62e0fe79
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000148.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8246

From: Ido Schimmel <idosch@nvidia.com>

In the rare cases when the device resources are exhausted it is likely
that the rehash delayed work will fail. An error message will be printed
whenever this happens which can be overwhelming considering the fact
that the work is per-region and that there can be hundreds of regions.

Fix by rate limiting the error message.

Fixes: e5e7962ee5c2 ("mlxsw: spectrum_acl: Implement region migration according to hints")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Tested-by: Alexander Zubkov <green@qrator.net>
Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
index 1ff0b2c7c11d..568ae7092fe0 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/spectrum_acl_tcam.c
@@ -1450,7 +1450,7 @@ mlxsw_sp_acl_tcam_vregion_rehash(struct mlxsw_sp *mlxsw_sp,
 	err = mlxsw_sp_acl_tcam_vregion_migrate(mlxsw_sp, vregion,
 						ctx, credits);
 	if (err) {
-		dev_err(mlxsw_sp->bus_info->dev, "Failed to migrate vregion\n");
+		dev_err_ratelimited(mlxsw_sp->bus_info->dev, "Failed to migrate vregion\n");
 		return;
 	}
 
-- 
2.43.0



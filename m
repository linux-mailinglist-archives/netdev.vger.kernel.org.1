Return-Path: <netdev+bounces-114177-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B09B69413D5
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 16:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B7B61F24AC8
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 14:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEB221A0B11;
	Tue, 30 Jul 2024 14:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="GDl6DvhM"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2075.outbound.protection.outlook.com [40.107.237.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34A4A1A2C38
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 14:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722348007; cv=fail; b=g6w4KFVJS9K22I5SuPCp3oSATbnjIpSx9u1awhfEljycioNH2oY/pRC693W66K+xzei+ZvwkgO4LZzp8+2HvdmiplLOiiORqralSVNpjQxXGH3XPZebvd8duSGjCWou2tlKQSpba1qVkFOZn68CRh63UPofIcuAf40bBisk+EGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722348007; c=relaxed/simple;
	bh=ikt5hmK5nU/IZi5sgSc3KktoiRHD4+hM4F+WXDkOS/Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OTgHfLkdaGg70mG6uxM/ilWZkHv+ThNv/s3+4IJQDgmG1P/ESv9Bd9JtUHHkhQAOmz9k1KmCbuuImmckEcM9AdUEPa2JBp0YlDcjzxMnhap2DxCGkd+XF4YGeN2aEo9ul0fLEpIhClTp7Pqq9dMMW8pFAzt09inlbprvAagvMN8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=GDl6DvhM; arc=fail smtp.client-ip=40.107.237.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P6wDvHN40fHnXbpWpoSwWQbRLLntGU1ebxXN4NU82dR6pbX+wlts4xiFFefXwqDacXdQzROnMfzXinD9glGMr4dUwX/NN15M95NEg+EP8fQedpH6HktZ16WY1QN8AxBwJSkqrdQUk0EyCxZXnovuY4+vhJ/9gbH4bvwFPN3VxqEmHJsnCsxhn5AJK+CtTSVhbo0ZPpWCUNnDctUCNFsv4+1/bTRmMV1k7UdWTe/1+RhW9kUCpAYBVnqXjUC35WlKUykpect8MebaMUoVvqvWaO96vsCPPJ1+x/upl6v40oUWDNtPohlJEVAs9EbdeA+Xt/bN/nPtm8kzTrqJpT5zKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IlpqeaXhlnBNL1/UCThPvFKxEWR58+K1IKswpOAlhes=;
 b=bI/Iu/3N9r12Sc3Lw3ZMgR0/Jinn2rypEUvQUkn6kfP/RCbtfrg37UZgVDGGTXD4AG9pRzurha1TW07jVW5oTflJ6dPagpbf16i5qPj6QiXGcO67rnxzriKOh5MFbe4E9gVqHyiljgnHubV3EC2erWXmiVjWOxNLIs2T0B73eRwvqVov54siP2GIHvnwVr6pDGjwabBkMZ4PxLK11AxAFYGLGCufl90vdRlbpiIaGLTqt0BkM6PLWhlTB8iS0YNqHhB1/eMN/Uur2W9zYe/tOZJRebMIbl6SMZ4uruyJBV8NES10xEUiVvwtlfuDqNzcGFeiTuQ5gui1xJNpNpT0dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IlpqeaXhlnBNL1/UCThPvFKxEWR58+K1IKswpOAlhes=;
 b=GDl6DvhMuow+qKUTwQEVS2XU6nNLM1iNcsAapXSVI2f0NgZSEarBiIhuxFmc0QrX644LDCajMO2pRUaC4H0DccuuUGfFZ/2D1pki0OPRfDA97+JYxWCwYmFGxxyeaNoUbEAlyrAqO4cBWTctXVQ4Vx5IqIZZ0+KJ5BHiyc81a6ZWTP6VV1F82QSYgvYubXDTFcM4qK2PwKwFvJ9F/g4x5EfCmMysupTsxQK6VCLYtclpbHvr6F6vdrbwnbvKE008jWE9wgI4HJ4NjB0+LKgi3AnYYXqDlmrW1LlbLNbGaboAIP02xtcH9J9SCCgD8xXQJzjWTnOarerhng2/4Wjupw==
Received: from PH8PR20CA0008.namprd20.prod.outlook.com (2603:10b6:510:23c::18)
 by CYYPR12MB8752.namprd12.prod.outlook.com (2603:10b6:930:b9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.28; Tue, 30 Jul
 2024 14:00:01 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:23c:cafe::86) by PH8PR20CA0008.outlook.office365.com
 (2603:10b6:510:23c::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 14:00:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Tue, 30 Jul 2024 14:00:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:45 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Jul
 2024 06:59:40 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Vadim Pasternak <vadimp@nvidia.com>, Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 07/10] mlxsw: core_thermal: Simplify rollback
Date: Tue, 30 Jul 2024 15:58:18 +0200
Message-ID: <905bebc45f6e246031f0c5c177bba8efe11e05f5.1722345311.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722345311.git.petrm@nvidia.com>
References: <cover.1722345311.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|CYYPR12MB8752:EE_
X-MS-Office365-Filtering-Correlation-Id: bbd8e942-44a8-4e98-696a-08dcb09fe7bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|376014|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?hAqVaDGWuBbpirkMEdAu/KuhPELposCJnvXjglZhkOb1ud9my5mMAXM4OcER?=
 =?us-ascii?Q?3aKeoK+l3RBknnkzU74D11n2hQWsJlsKQ8bPz4kNqzIte5ZBYZ5a+9LF2cVw?=
 =?us-ascii?Q?mM6trjyIPEs0mZMG4Aj6PYczwoSQMJkVSodgdE0xyOzYlEcK5IksBhBtthip?=
 =?us-ascii?Q?OTKjuPeGI2Y45JbdjuT8F1rd+n0ozxdMoLOk6Syh0NQwTdxHDqIKL48ABA/A?=
 =?us-ascii?Q?NkfO66DfXCI8VKQikVxdN2wEDqWPiX8ebJK9E1o9zDtp6FTwQlb1blRmXx2v?=
 =?us-ascii?Q?6BhF4FdKaxmSKwA2YnS3XNxTVQfrN7J1BDvXNPLe69Sl64en/bnkVU3I5mUv?=
 =?us-ascii?Q?MqVZIK+hb26LgbZogK96BaR9ScAb/8VYQi/hUGMF4x0tBSThTQKfNxmxSrzH?=
 =?us-ascii?Q?FGE+oEgaQFqx/xzpHzwZKDdTp30284pPx9ZqksBjFNUbLj2m06jWnsw3IFfT?=
 =?us-ascii?Q?sni52jAj7FwoVKukfMyc8txS9fo5413iO3foB7xrcEMHHBcYUGdcrVx4edoM?=
 =?us-ascii?Q?+e3HBV2tZ/L9X/03EBsij6tToGMRWSiKzHofJ6RPPi39OdgJAJ6vIEikwEJY?=
 =?us-ascii?Q?h+7JK3QJMq8tnGit5WWcYrszoMfZSWQsgkWJsCAARC/XbpBsFpOkApjLGe10?=
 =?us-ascii?Q?tkGolsyhkCpPBw89kOr8O7ED8miYxlSkzRqDrcNUbjQ+Bp0EbXGzVUqbEKgD?=
 =?us-ascii?Q?FT6V6oPUONJOhlXgVKNOREJd9rSe5BF5Wtv0lM7Gd0ydKkEhFOQnSQzmgw9P?=
 =?us-ascii?Q?pastcFREbCiOhJmg4AvDdIoXLN+I+fsU00MS4xkoPpROY+7OWRpcDaI7Tt7+?=
 =?us-ascii?Q?IvUZrjNX+UNfo7vJQr/GdrkF4e+LGcwZLfIx0+B1m0VukJdfwXg1X3LaKvOH?=
 =?us-ascii?Q?BT87nZ/wIXdEdxfePB1jmwEm+Nl+BBmmfZjDEkZLjamzlhQveZuSZm28qi0q?=
 =?us-ascii?Q?ufFb0HIrKJI5LJNFPOJCGlOzdozYHkzrZF7CqDlxEic5RWPM3uDJJaovtmYL?=
 =?us-ascii?Q?Z8U6QwDO/VwLfRxU1mvzuYUkPYcDOYBNMNyfNfhq/XimILJIZE9oBjhmfa6q?=
 =?us-ascii?Q?U4RPIrtPQHWvzUBshUftVFYhwt+dVraVOJKwMjSuuCxGbhJA4tpzL7TM8wZo?=
 =?us-ascii?Q?9PwxZibOisvanUqEK70qOejWa0XsUlr6WfEYVjQTUPVh5GikYpTizqGo843f?=
 =?us-ascii?Q?0wFfu6t+NViwg2HaGE5ZRm623y516dGRYKXRWufKllK9ZiVLymHy6L+NBA+o?=
 =?us-ascii?Q?SvDAku+4RYSO5qSti1+X4H49/PQOEoAUgG4aT4/Tb/u2/96go9Zsviw0OFfX?=
 =?us-ascii?Q?nEQ3dLXCtJBUAVovOx6bt9N8v7aXuNKQ4fjcgpbtcxeRE3mV97FjpqTB1ldt?=
 =?us-ascii?Q?YFfGe5Ucw+MeH77TnCNDu8vT+xw52IryBSY4tBR9dqKXoK9I9raXp2fn/NGY?=
 =?us-ascii?Q?eAsUnCl9kff+Ysz6+znF1iJeRbaUiNi6?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 14:00:01.2600
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbd8e942-44a8-4e98-696a-08dcb09fe7bd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8752

From: Ido Schimmel <idosch@nvidia.com>

During rollback, instead of calling mlxsw_thermal_module_fini() for all
the modules, only call it for modules that were successfully
initialized. This is not a bug fix since mlxsw_thermal_module_fini()
first checks that the module was initialized.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: Vadim Pasternak <vadimp@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlxsw/core_thermal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
index 36b883a7ee60..e9bf11a38ae9 100644
--- a/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
+++ b/drivers/net/ethernet/mellanox/mlxsw/core_thermal.c
@@ -509,7 +509,7 @@ mlxsw_thermal_modules_init(struct device *dev, struct mlxsw_core *core,
 	return 0;
 
 err_thermal_module_init:
-	for (i = area->tz_module_num - 1; i >= 0; i--)
+	for (i--; i >= 0; i--)
 		mlxsw_thermal_module_fini(&area->tz_module_arr[i]);
 	kfree(area->tz_module_arr);
 	return err;
-- 
2.45.0



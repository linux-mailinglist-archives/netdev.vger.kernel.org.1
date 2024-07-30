Return-Path: <netdev+bounces-113986-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A1667940830
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 08:19:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4451F2342E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 06:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389ED18F2E7;
	Tue, 30 Jul 2024 06:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="fPOmrV++"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2046.outbound.protection.outlook.com [40.107.94.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACC2618FC66
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 06:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722320319; cv=fail; b=FuxkNaECkPHGLj+0/UZU2/Ii8oqp21mmQsS/NPm1miZxx7LBL+rofls/26u8Ph4BqECxQFW54afZVGwefsPwC7ToFnzVTd6v8U22Vmq9V0UDDLaJKrM2sLK96wNf5zODOGnn6vRMyfta3+2tbZpziZYrpxuBftqUUdbQoIRWzkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722320319; c=relaxed/simple;
	bh=9PN5FyYi1QQPVMbDFQT2aL8X9HPzMK3HOQeiflvxrF8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FpsyZDKxMlUkJgYwtSHPb6ArYOoijvxnMtN9NGDVnU435VQndOhDTXl+cFwOO7qpSgte5DNODbs64OGxdXOqxKPc59zVbexc3Z4bMhaYFChm0bwK19CsUr95/0033dESBXaQ6eN6kTnYh3kdMcAru5iQdu2zwhufHYHwdTS121Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=fPOmrV++; arc=fail smtp.client-ip=40.107.94.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NPo2j9jAYC5abfEVC0KsTTr6ue//jaUVvA0qJZZ+fPSM66+85iA5cvA957dB+NCpQWPkMe7W2xsoFo7W1FZpmtrKnl6/HmDcAk7ZNHz66lFoxDwQb9ZizEh6VOz1cM0kop+KuOQJayqh1M9THBDc4vV5sfDO8tEcMH+qomiX+fT9MH991xaJkeHkM8gUjv6sCBkyQiUU0TQaxuikc+ojO0ev3hWnMoqUjloK6vgDDHEIbQU3Yi7DzrKk2LhyIkmHBUsC7nZbyOhzmMP5Nk13Jji6uN4Jj4NH32mrASfuofz9Y9DLyclM7MhA6VEvDdZLDaA+BpQx8t3Mb7lB3hy6+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q8mYPWN0bly6RkdUOm0LorwVgF32dwyg2nh0kYCWhAM=;
 b=GTc2UI8V1D1gRiEf8V6PVSdHGML0hWaEVhHkX6azMzNJahF65ujVfLhWpC7YMTdMKxmXADuyCSWTwrUyWa5wuCCWnOERWgC8QY53SBH9jk1g9duh5sj5Rdo0xIPJYXheqBVzOCfNMDbDDZOGh0Qi+D9uglcMRFKdc00WJeBnEibufCmgHvnblhvCiAdaV5aED9tNNImS95OEJEDKF7WIRhAWGxLK2j0dwl3hMep7HvBn4mhBMUymg9CvPyF8uobBUbVTSt9W85t5NMYOZGBOHiJJyQLUQT1Qea+WluVQW0quBu6iwATPz0iMDfhHsT7a33ujUSA5k+J5CbmaQ+Aflw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q8mYPWN0bly6RkdUOm0LorwVgF32dwyg2nh0kYCWhAM=;
 b=fPOmrV++qOcGSHJ84B4eBS3zMnopsCGRogR+FNRV4fZa9cbaiUwFncMKJ7FSWGimgsMnR4szwA+nKoWUYoliPzwt3iT6/7HetMWRxruVwRVXp7iOwOGz95YvOPyGT5N9iwTwtMPQg0+OF+xOWW9lLrr20T+hPpsBYMM1GA/mOSSCowvJYfxgSKE9Mb9LH72w6CMGqaJDcenx9dTFkadNbnIRxRcpdtmtBlcy+ObWC3CB9+uQuFYWbQF7zq/GsHbAIRD1GeRyJlDpFIfAO8yOvDRmW/jlgTYvb+PWgUARZtrwRpYgfbp+rxi7NAcFhmKDqbenijXH6BKKXYNYb4CcdA==
Received: from CH0P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:11c::27)
 by CY8PR12MB7684.namprd12.prod.outlook.com (2603:10b6:930:87::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7807.27; Tue, 30 Jul
 2024 06:18:34 +0000
Received: from CH3PEPF00000013.namprd21.prod.outlook.com
 (2603:10b6:610:11c:cafe::51) by CH0P221CA0001.outlook.office365.com
 (2603:10b6:610:11c::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.34 via Frontend
 Transport; Tue, 30 Jul 2024 06:18:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000013.mail.protection.outlook.com (10.167.244.118) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7849.0 via Frontend Transport; Tue, 30 Jul 2024 06:18:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:19 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 29 Jul
 2024 23:18:19 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 29 Jul
 2024 23:18:16 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Alex Vesker <valex@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net 3/8] net/mlx5: DR, Fix 'stack guard page was hit' error in dr_rule
Date: Tue, 30 Jul 2024 09:16:32 +0300
Message-ID: <20240730061638.1831002-4-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240730061638.1831002-1-tariqt@nvidia.com>
References: <20240730061638.1831002-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000013:EE_|CY8PR12MB7684:EE_
X-MS-Office365-Filtering-Correlation-Id: 74b89a35-0c86-4dcd-4540-08dcb05f7080
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oDioGFIoOxIFKfWstcwgmlIJ15CEioeBfOCKmpC+1dBMahVrplXBRwH3xfBT?=
 =?us-ascii?Q?wRJpDEtfquX7NhYxCCF6+xGpyA1bwAojOW6GYnuJGgGD9hFoksPRIkaE6r/d?=
 =?us-ascii?Q?EzDBvliYc5yvr92lYRUlPi9KS4nsHuSU1qXm5ISf2yqtHdctgtNeXVlZd/8I?=
 =?us-ascii?Q?5+C63ZtiZx7lwHy5FZGm7Phn6iSXZOxANQzyJtaVuGW1c83GPhRrc7mowPuu?=
 =?us-ascii?Q?J+PBoP8iXA9RfiZwjmpEA7BthoqYb7ijQEYmqn2WMVqk4qLZlOYeePJrvFfI?=
 =?us-ascii?Q?1PHiLO3pRzqG2jMj0MoSSu6Fq1LxhSKCgY0EvbuE3/8VKsT66AWyzl4QCHL+?=
 =?us-ascii?Q?7dfPuzBIxZU+FR3zPubYBs4z6CPF/0oRwaShqKmR0nNlESSCrNV+jtKcTKOm?=
 =?us-ascii?Q?K9bmbG8qbxJkuHGv6Hvww1VSFZLG3WQ93pMMaAWrWFyC2pmsSCL876vnKpfY?=
 =?us-ascii?Q?ONIlPLjpDGlO0Mz81dL6zI+euez8biEEeav69mfHZw4QFs45/SMrbnOEpPOL?=
 =?us-ascii?Q?p3xeXjeLH2MGRP8Z2aMnZYTMvJlbO95Q81IHEC8ekt5HRnQe8MJakc8yRz6B?=
 =?us-ascii?Q?WBp/k4nQ2wCbT8yLbLKgbTnoPVnanlYftArHdFXaa9zbkhzSxltbDJa1fg8q?=
 =?us-ascii?Q?4CR3GO0rX1MKZiPQIgqgBGXYWVxaZuClvEOApe4lUVcvC0T/eMgFppps1qpP?=
 =?us-ascii?Q?d7KcWEetK5XrUprrDucAevxTKDH/5D2/7LAjzFqWrYwgLFmS3s7yWErEkf3n?=
 =?us-ascii?Q?nsPCsQYH/ZXTO4f+8iZh8jqRAEsbx6+uqhG7YXtZ6+cZdQX9bNjd8/lVyruE?=
 =?us-ascii?Q?30zR5uk4Fi07CNTGsEcWlGiPdzq2Z5WvT5zghY15GUah+dNIxUFGUrZPCI+L?=
 =?us-ascii?Q?0urWQ65vLkpR5ob+qEmW/4db6jGw/dOt6bjGVMIgeuE5SOu52OMYojZbvJDi?=
 =?us-ascii?Q?8/4zA1i45FAcNkzpJGY4N6kVKDwopWtGJWvDlOJsT+EuaFlhxVyPjI5gszAs?=
 =?us-ascii?Q?3A5aktBljNnkA9/73V0Fa5b3JEivyB1Zy7BQCGglZojBUUByA7hVJO7UTN1Z?=
 =?us-ascii?Q?lbuj7EBlr62Hh+tXr5/+u+LEUdiPhKRj0OJu8hfi4+f8DpVZ3s193r8PKgEw?=
 =?us-ascii?Q?Qi4cYNLKmMWQ9M8C1Zo3+fLgwECQVvFjA0zrBA4HDdtd5PFvdTmWpKd6xgVW?=
 =?us-ascii?Q?S0ZMhLlq2cPC6NOtTrwk2iPVh72s4EC83PZ2KF+ZaPnMXF4zXMzxngGXuCWZ?=
 =?us-ascii?Q?QtCoQAcs+UQDkRM11FG/i2kryZFOlTnlBSCjEDC/wcqiCQJh+79CiL71kk9l?=
 =?us-ascii?Q?R/lup1GaIUj+O3yV7zm3sSIgTDHz8MF2Icg7vlk2MQxEVSPnml+rqoyQXX+k?=
 =?us-ascii?Q?9kSITlg8iu6pT8mQY8xlH+fHN1HkQGFMxohpGhRBLe5yOjQTZM28e+d3ORAQ?=
 =?us-ascii?Q?XQCnbNiesaZ2X+4Mh7xZ4Nxtisv7rl1Y?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 06:18:33.4510
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74b89a35-0c86-4dcd-4540-08dcb05f7080
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000013.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7684

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

This patch reduces the size of hw_ste_arr_optimized array that is
allocated on stack from 640 bytes (5 match STEs + 5 action STES)
to 448 bytes (2 match STEs + 5 action STES).
This fixes the 'stack guard page was hit' issue, while still fitting
majority of the usecases (up to 2 match STEs).

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Alex Vesker <valex@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
index 042ca0349124..d1db04baa1fa 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_rule.c
@@ -7,7 +7,7 @@
 /* don't try to optimize STE allocation if the stack is too constaraining */
 #define DR_RULE_MAX_STES_OPTIMIZED 0
 #else
-#define DR_RULE_MAX_STES_OPTIMIZED 5
+#define DR_RULE_MAX_STES_OPTIMIZED 2
 #endif
 #define DR_RULE_MAX_STE_CHAIN_OPTIMIZED (DR_RULE_MAX_STES_OPTIMIZED + DR_ACTION_MAX_STES)
 
-- 
2.44.0



Return-Path: <netdev+bounces-154817-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C389FFD9F
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:16:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9264E162C60
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:16:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA1121B3F30;
	Thu,  2 Jan 2025 18:15:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MVa5SMl8"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2088.outbound.protection.outlook.com [40.107.92.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445141925AF
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841759; cv=fail; b=QpRFrbSfZukrTFt4nNlK79lGcizQ31hYstwKQ+LYVl7l5QQU+YKAsus1wrrpbX9GCWq9KT4zrGWHtYUj8FzOTJGMR8QgZ0oMJVhddCgzwv+9OJrjOcXiEcjIkoB1uMJyqpC85KBpWvSKvOaTJbPsgnTc0RR8R+NKc5B8aYSnNBs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841759; c=relaxed/simple;
	bh=xzD+YWMDg6q2R0Y8BTI2fFP7MLMo5lb+eX+A5N7LY+s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G6b39YDyEYiBATbyLK41CtdFnfJseKEMeXeVmkJ2++jMbX95XUvG85A/VXj/P42Bxj7IXoi7aF1B7lW2N61o2T27TKbHmTPfS2OEvHCmPMmuwPl3YyhR1Eb6tq6R7vBQ2e99SwW6HQrE20kdfRpSlsPoW8MnnkSarwG8G3WBRHs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MVa5SMl8; arc=fail smtp.client-ip=40.107.92.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u4/HRFEHc7zbIhCrGuQCQqJdbX9eVpR+YA7NQeOCWU68UZXtV8OjcgGN2Uh5rrFM+OdtvuvbKkfnYh2ypLRbfmcrE6ugW7uvwlj4mXEQeMIPd10VF9D5vMW6gs3rUY2iCAXz0yI/jKdQBmpIMgDA/Ux0EpZ/oAJnU5HfL8np3g8rkYpkceukY1os46d2sUGjs3StuOwOZLB2pFWqvrSeVXLkvLOfAuH1fneC63lSaNvIjDoJpbKt4elHGPayaAEv5UtOWh+hCmeosNA4PnckaxjbhoEveXFVs0/quu3ortldzbmQWTzLvECV4H+PF02+/4gkGdQMqT07/imrLAvLOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OhMKMl7GknZaWuRrCjRwqbO9bhDZbKMvDZgYLnEDYzg=;
 b=b1Ytq4EQeNVQjFgB3fZlIljjdkDfYZe26Q+0qLIdS8OTf2O4k/96dJCfoyFn0msOx6QY/b8QsUBotrN9rRQZmxQStIgJC9ZSpgiKJdH/+4OTymyjY1VWXd6qbbzAWGyz7/n4B4uGP7g5jT8iLart1Tg7m2zHkbT86LsPgW4EuM5fxw8WdA1+nIh39QMvuIapfbMrtBSzFrjDnWkzy1+RhfMR5ExybSrs8rkixlDhuaOXWGrK3mgduBcgwaPCoMeR/SBzzcC8G4/onEskbNsOO4YTgZy9VfdZk85stXgX+TsjYAIzRuouqIv5ZuqvUl/uI46wvJ6SxfK9oHkMo1jNPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OhMKMl7GknZaWuRrCjRwqbO9bhDZbKMvDZgYLnEDYzg=;
 b=MVa5SMl8a7sWKOEHaqN1fVmk0xzKYxwAhzmWQOcVbg8/buuQEDHJyIROBlORqk8nbmV9b5NsO1whRU+VajUQzdyn8VG+MsSkDyYLJ1ns+5Y+wdUJbHlVnAyY2eN2GyTv5eVU5gICNqso50Yrmpy8TjuLZjlsFb7WIk/KRRqabiNohql8Jhz6x+sC2WAgNRR1D3JllBdsvWL2thFYAr3uYcdc3DjcdICQsPEOjo5Vl6dS198ykDf+3SPWrGl0M3QGIHbRa3/BKK1/vOav9Gs95jqlgg5OIqDUnXfjwBQyLEWjDmX5Svw9sxjq2wmlLMT8IfUPbtyWfQ+DchrdZecDCQ==
Received: from CH5PR02CA0017.namprd02.prod.outlook.com (2603:10b6:610:1ed::19)
 by CY8PR12MB7145.namprd12.prod.outlook.com (2603:10b6:930:5f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.12; Thu, 2 Jan
 2025 18:15:48 +0000
Received: from CH2PEPF0000013E.namprd02.prod.outlook.com
 (2603:10b6:610:1ed:cafe::ff) by CH5PR02CA0017.outlook.office365.com
 (2603:10b6:610:1ed::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.13 via Frontend Transport; Thu,
 2 Jan 2025 18:15:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH2PEPF0000013E.mail.protection.outlook.com (10.167.244.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:15:47 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:30 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:30 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 Jan
 2025 10:15:26 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Erez Shitrit
	<erezsh@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 08/15] net/mlx5: HWS, reduce memory consumption of a matcher struct
Date: Thu, 2 Jan 2025 20:14:07 +0200
Message-ID: <20250102181415.1477316-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250102181415.1477316-1-tariqt@nvidia.com>
References: <20250102181415.1477316-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH2PEPF0000013E:EE_|CY8PR12MB7145:EE_
X-MS-Office365-Filtering-Correlation-Id: a5c658e9-508f-4a07-6495-08dd2b597b49
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1PlE1E7dRvcXO8HROPNu+7lxPqZnpt2Bf9wfRrJySe/rBGaT66pykR3GIxmD?=
 =?us-ascii?Q?1DwkNY6Wpc3MT/H4yiXvd+B1BxkDMmKZ9KrK1lIjAL1mQdl3kFApC5MNYjSl?=
 =?us-ascii?Q?vlROy227pzl6dN3dHYyhgmMerHAlyiA6aJVQUs6tlxV65rI7qiGMKXc2Q6su?=
 =?us-ascii?Q?a5oXv7gLjcIwANWWqkUaqGPfGfbKeXABzJIWkuAtW87JbWU0IyJ/Squ4uHpV?=
 =?us-ascii?Q?HbkqhPP/HXPjhpWyir0ZhM+RtW1Pl5q1UixNkqgnv21eCRBZ9LTef94KH8LH?=
 =?us-ascii?Q?M3gQvUcNUUT8ucttF7DV8CohSf/WNihWHTD7KI6AQIVRxXlSBkbWaeGONR16?=
 =?us-ascii?Q?QqASc2XzX4LF8if3AA0sTuY68Z/dgTY4ZPamAIQ2PrARkTmMLlNp4n7LvRG8?=
 =?us-ascii?Q?qLXqtw5Mj0+uxEawm4wWVswPfaZaeatcIrNrTqYI80mev5u12z1IU0/8LfnQ?=
 =?us-ascii?Q?ZIfjwt8fzRqONi6HZra8tp0HEa3zcL1dG18GpCHgJDALe5ub2LFVpB04hfmW?=
 =?us-ascii?Q?O4c8hgRyYx8Osir+qaRlBRN27rl8hSoSKxAtttwnFWuEi9PvwQv0WshpLd3L?=
 =?us-ascii?Q?vXc4Pl5qt6ctEslS/kxPIlYQSxkVrHMSn3veFzxqpHvktXXVh+1/1/msWJAg?=
 =?us-ascii?Q?VKQqznREKg9k83yqBH8hz6cUbpB+GswXp9V6X1VO2G5L5/qFGs+6RMA6IL55?=
 =?us-ascii?Q?Zg5EtLY6U/r6tgoNmFA6KaCB3Z/6HgWEVRPdyv0bkNYFst2i/lQuvxi+6WQs?=
 =?us-ascii?Q?IpcgX/+htPlq87MdDixF/xLqV0l1Zn8AzqBtVKOIe69VvE0lnSR+t9gZUCnP?=
 =?us-ascii?Q?1OA+fejn/tyliRkHim+sbCCUI9U+xlMD0yVBqhccsfDTXlCNFzIKgW0UbbLK?=
 =?us-ascii?Q?XElnijaPNjUS0V5qL/O1o6X8IT2/tsOsNzHaRi1xb4+sa1qrE+WZPEZMUB+J?=
 =?us-ascii?Q?drRA4L4Rkyql1f4tPpvnNSd9Zq7RK6TPe9L57crtY/bB1UIu7xDEoEpPQwy5?=
 =?us-ascii?Q?v9mmI8OC03izx6gZrrOvlw2WbTSvCrYE4YNso9VjeY20+eSBQ8zpTYCNEuZy?=
 =?us-ascii?Q?X/KwWJO+JUhPRP+/IV0cQLCdZMlr9DbuSpRWBntZzaWi0fWumDTGgkbPZfNT?=
 =?us-ascii?Q?2G0dTQIs2zPgRs/F7vAgJo60J4IbXaok1SMD45j+bImAg9iLJ/TmJb+WfKLO?=
 =?us-ascii?Q?Xq41H9w1gNQNy8zPNVkMTNmi9xE1efWTlgLl+P921v1Jelg6ZfytT8SQS3oN?=
 =?us-ascii?Q?yjTWDOKzYX8Jtl7TmELpN/lNcjNJ0HH7Xg8o6/51QZMxOT3tDynSnTb3Xdro?=
 =?us-ascii?Q?fwzWdOm0IiXrhjIeI6c+8k5kcuAJlieZgSC7ugLAeAWHrLONUhTfyuCuPtYq?=
 =?us-ascii?Q?I28B6Ap+6++oJqwOKzzxeB2/fS1X1OHyL1gd0JA6z2r67qS7vH7k/GPodBWA?=
 =?us-ascii?Q?DsUs/uG1gI8Dd+W0cr0d+/aTyDJb6w+XTzBNvEe7Ftrp267RAldgi+uAyE1Z?=
 =?us-ascii?Q?BIDY3bVRFQ2opCI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:15:47.5407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a5c658e9-508f-4a07-6495-08dd2b597b49
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000013E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7145

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

Instead of having a large array of action templates allocated with
kmalloc, have smaller array and allocate it with kvmalloc.

The size of the array represents the max number of AT attach
operations for the same matcher. This number is not expected
to be very high. In any case, when the limit is reached, the
next attempt to attach new AT will result in creation of a new
matcher and moving all the rules to this matcher.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Erez Shitrit <erezsh@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h    | 8 +++++++-
 .../ethernet/mellanox/mlx5/core/steering/hws/matcher.c    | 8 ++++----
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
index 3d4965213b01..1d27638fa171 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/bwc.h
@@ -8,7 +8,13 @@
 #define MLX5HWS_BWC_MATCHER_SIZE_LOG_STEP 1
 #define MLX5HWS_BWC_MATCHER_REHASH_PERCENT_TH 70
 #define MLX5HWS_BWC_MATCHER_REHASH_BURST_TH 32
-#define MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM 255
+
+/* Max number of AT attach operations for the same matcher.
+ * When the limit is reached, next attempt to attach new AT
+ * will result in creation of a new matcher and moving all
+ * the rules to this matcher.
+ */
+#define MLX5HWS_BWC_MATCHER_ATTACH_AT_NUM 8
 
 #define MLX5HWS_BWC_MAX_ACTS 16
 
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
index fea2a945b0db..4419c72ad314 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/matcher.c
@@ -999,9 +999,9 @@ hws_matcher_set_templates(struct mlx5hws_matcher *matcher,
 	if (!matcher->mt)
 		return -ENOMEM;
 
-	matcher->at = kcalloc(num_of_at + matcher->attr.max_num_of_at_attach,
-			      sizeof(*matcher->at),
-			      GFP_KERNEL);
+	matcher->at = kvcalloc(num_of_at + matcher->attr.max_num_of_at_attach,
+			       sizeof(*matcher->at),
+			       GFP_KERNEL);
 	if (!matcher->at) {
 		mlx5hws_err(ctx, "Failed to allocate action template array\n");
 		ret = -ENOMEM;
@@ -1027,7 +1027,7 @@ hws_matcher_set_templates(struct mlx5hws_matcher *matcher,
 static void
 hws_matcher_unset_templates(struct mlx5hws_matcher *matcher)
 {
-	kfree(matcher->at);
+	kvfree(matcher->at);
 	kfree(matcher->mt);
 }
 
-- 
2.45.0



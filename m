Return-Path: <netdev+bounces-109372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2542D928294
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A73A41F24AF3
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 07:16:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F71144D31;
	Fri,  5 Jul 2024 07:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pxPTcO40"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2062.outbound.protection.outlook.com [40.107.102.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00EE013A26F
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 07:16:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720163763; cv=fail; b=m8PFLcXSKh3fOrvlXAlGZieCStr7ECvM5IdeFOl1VnCrwwbD5FIeahNQU33UIOYfSzc02xYseIcwEA/vuIM2tm6s0zsqEw/AJmncV5SQIkil41gZ+W96tRapGmcnp6rLsSLhfAwgZxnpVL1RdJwEzwXYyi9A+WcVK0+JjRNDMp0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720163763; c=relaxed/simple;
	bh=NKU+ozA/j3V2qsOhMj13F1QAPvRE3Mpw29u1+5IAfp8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lzj02jxAcrl7RM1iPGPAc1IKp3Q62NBlQuQ9g7i4upSl5oLHQdl9f6Zw/rViD9wWE9ST7F1yTSXbra7SFTTyGbXO3f8FvNfzFTUQpdvwsX60Cute8qM0Tt2Db3DsKOioV/1g0pcMh9VmZFW8MnuSHvRkApYh3sChJ8lwi7D/G+Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pxPTcO40; arc=fail smtp.client-ip=40.107.102.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GT20SQgvbwxO0fsQMgvPCM97bLPndKkkzkyHE7XOEv8YINuiA4cxd+l5Tw+G1MUR+Kuh+qqRKeDb6dtfLX4GBWudyeUeqacmTxxsqdad4ZItnm46RexdN6ZKhkuL5CWv6uywZJcmikEnvYGZnmZa4sZSEypwqjYBkpxAPnwZFSnZMa6oeUd4ppHq8WM5/chfIJARp20TSY87FZCXgNUCZDMoDR6Jp9+yGDj9wZj+AoPqFA/Z1J/eJ4dj5SLW0YfNwVk7sw8rLNJJSnwW0tGuu0TGa5a+Uw7OHMM7S5KZ3FKM4wPqwhuydGxClmhEaapvJGFCpk3UbBtUHMjsEvXeWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kDKjQgsgGUgtLC5rq26bxue9O9tIgvgEIScJ+yDV7T4=;
 b=m05p9gICMC6EZ8VaQNkvBWYAv/SRHf7FKTULh+sI4Dirvzr3LqksLdF3axx7B56CefKc4dQS3fhxViYpJCaDFqjYR5b4aBEwR67Tf7KIPLRkXtrD9HnDfBkyhPmk5U+p46o0lK7mWKqPSonhpjTazwi7tjb3oeJ0vbxEOVb34qanNbxrJhgVcztSEXO6P1sybXrd447DUtey0knuiUkw5EZ8uuIfIIrxRGGNvp3U+/gvpODCor3EPRNRvirGDLm1t/ubeBTlmvvWOKsDaDvTQWFQC2jpLXyPB3qd/4OsvH7pRjEc+De1Fd+e+xlv8fBRX5F1EnmXS8/Qds/7QypXdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kDKjQgsgGUgtLC5rq26bxue9O9tIgvgEIScJ+yDV7T4=;
 b=pxPTcO401UrHP6WmkEBpLGuS6eOZCRAnWLtW0NdD+nCQqEMH/j8caVM+UxJhQLL178i7+FPlKVfSoMD0+SWAq/+8gkpTGC8MFH0pRfYAnh4VHKGB2an8X73r0QYajQ8Lw48znRqs9LKCwGQNHp0WNIC+ov3kIRZLq8OX56j7WCzZRnozKtLn11rWQSmbDlEZ066gowVLZX9RHJ4dJN7BQaNIcOFkRRcDC+1daubTWKYsTNXxN5pgv7ufZI9/RLEG+EYBxZCHffnEq1+ZAGTFE9fqVRs+U4V+yyQSFLDErMcXOxfdx+Bxd5FWJ7NQ0E25Je+pm2Nhfy+J3OmS/iamug==
Received: from SN4PR0501CA0068.namprd05.prod.outlook.com
 (2603:10b6:803:41::45) by SA1PR12MB7102.namprd12.prod.outlook.com
 (2603:10b6:806:29f::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Fri, 5 Jul
 2024 07:15:59 +0000
Received: from SN1PEPF0002529E.namprd05.prod.outlook.com
 (2603:10b6:803:41:cafe::bd) by SN4PR0501CA0068.outlook.office365.com
 (2603:10b6:803:41::45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.12 via Frontend
 Transport; Fri, 5 Jul 2024 07:15:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002529E.mail.protection.outlook.com (10.167.242.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7741.18 via Frontend Transport; Fri, 5 Jul 2024 07:15:58 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:44 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 5 Jul 2024
 00:15:44 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Fri, 5 Jul
 2024 00:15:41 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>
Subject: [PATCH net-next 10/10] net/mlx5e: CT: Initialize err to 0 to avoid warning
Date: Fri, 5 Jul 2024 10:13:57 +0300
Message-ID: <20240705071357.1331313-11-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240705071357.1331313-1-tariqt@nvidia.com>
References: <20240705071357.1331313-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002529E:EE_|SA1PR12MB7102:EE_
X-MS-Office365-Filtering-Correlation-Id: 51c3da88-3e89-425b-2a48-08dc9cc251a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?9Zo34RDzrc7e7Ggem/g4VzS1qoDyh02qA67t6oxofKr+qAS237ZqE93ExfGY?=
 =?us-ascii?Q?oSnO5RJiJkGlhT1YX2cR+kq+ooSCeO0tTgY8O2DvGxkdGoII8+UH7Aq8NaXP?=
 =?us-ascii?Q?uzuInmPIhxkXDGBVj4xdLu2oDr7gaqBbpXg+rZLfzchmaIdi5qNKCcG35Uyp?=
 =?us-ascii?Q?QuTMU/G28JRy+oXBWXI5BApFPEXnPeMmTrVGfrJ2i+eO7AvDMStGgKC+r5ZN?=
 =?us-ascii?Q?ePnMhP0RNTuFywHsrAxBAc1CqLPj1gmjGX0kDIYlrxftjHeUqD+b9lWkgkRd?=
 =?us-ascii?Q?TeKRC1Dmgp4KuLkPYgriFW126MgBelGWe8Xj2YzLAfvboneyVOBF3Aa4TBnP?=
 =?us-ascii?Q?JmbbSJEIwqNTD6IqRXlT18unxkZ7N/VKEWwMXiQs3NQb1IZiz2GboWzaVHhe?=
 =?us-ascii?Q?CKNIA7pVKCahh1MX/KO63lV5UAkj7bzFSTbUftnGebrfntlhJnkP6gLP75Wu?=
 =?us-ascii?Q?sgfhrwQXzswNRCocaeXI1Uzh65RYp3MfhjYcL4+wlK/sUSybnqqrW/zNHY+M?=
 =?us-ascii?Q?2friVFd1Dx5U3aZ5RSG3fkkwZi+Fb1QG8TXygp99bCaPqH/vBAXJo6+TUpHd?=
 =?us-ascii?Q?E17ZABbnHe4P21fD1we7pQBXQkdp4vKdtYR79KxsnPzh9w6G/9ZYjHjb+3Xn?=
 =?us-ascii?Q?poZUx2uitfUjaVCaGT3UaPDZSNqkjuMv7xGUPz9c3W7Pn3CxgPfZxQfJAisO?=
 =?us-ascii?Q?wVnD+WJaKNuCBKUl+w/KSBwntEU3m7misaSBlx6P/PMqxFjZE6NRVzSpRhmd?=
 =?us-ascii?Q?c6ownXXq7XHjjQB4CObtDspvIBMWFKrL9Pyot0C9n+YeNv1qfEpo/PGALotK?=
 =?us-ascii?Q?tKW2Uoe/hQhP1LoCMTlJLrZoQq3va0KdoQ7T9D9RUQd2w3lLyHYAj8G9kgyY?=
 =?us-ascii?Q?IxxZoXMH0j+6ADpS6Z7J3IfDiAGsL+7zu479jUOyry2syneUkVI04z6umXqg?=
 =?us-ascii?Q?QiR43OsGlGjKXvgL7e63vUSN8jrVEWSgYPofMqsW366UvYTwSDMJ/CsGPmoi?=
 =?us-ascii?Q?5fX/y7LlCo/34ssoeQzuwTYdDv2lOvbaisDsVI/OcwJzZGFI9BrmWKpyyn1j?=
 =?us-ascii?Q?7CzpRhj0hHoehLXW0iW6m3yLT5ABqq/7uM2aqHT8VG0ybtwHyqFf82c8uTZc?=
 =?us-ascii?Q?f/zgBQFBoLtVQkhEv5EaYMJYHM9BB3ygFj1URyDY2QJaqLLWURtXwHPsuiol?=
 =?us-ascii?Q?aPWryklIqhchNLPyh5JNOlkLFGd5z4I3W9AAeHbklhs4Zhtj3cupVuX8Bd+q?=
 =?us-ascii?Q?u6wOsd4SQpMUq2UoyCIuiZYiImH+pYbOE4pDYDOpFrlP5gCpJeRcSoak7GfK?=
 =?us-ascii?Q?6P0vZqoQqKB8qTWxgCJBf4Z0oeLOxeBqHu4sjZah2onJG42huWrVD+FpmCTB?=
 =?us-ascii?Q?oOaaF2B5Ekpm5OoTq3l45A0LLx6Qi9WzItTFDSjC5driZsar2vYjrFuqQrYO?=
 =?us-ascii?Q?FEtMmIfU/6iftsb48I4YKBqWy9uZ4mcX?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jul 2024 07:15:58.5466
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 51c3da88-3e89-425b-2a48-08dc9cc251a1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002529E.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7102

From: Cosmin Ratiu <cratiu@nvidia.com>

It is theoretically possible to return bogus uninitialized values from
mlx5_tc_ct_entry_replace_rules, even though in practice this will never
be the case as the flow rule will be part of at least the regular ct
table or the ct nat table, if not both.

But to reduce noise, initialize err to 0.

Fixes: 49d37d05f216 ("net/mlx5: CT: Separate CT and CT-NAT tuple entries")
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
index b49d87a51f21..8cf8ba2622f2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/en/tc_ct.c
@@ -1145,7 +1145,7 @@ mlx5_tc_ct_entry_replace_rules(struct mlx5_tc_ct_priv *ct_priv,
 			       struct mlx5_ct_entry *entry,
 			       u8 zone_restore_id)
 {
-	int err;
+	int err = 0;
 
 	if (mlx5_tc_ct_entry_in_ct_table(entry)) {
 		err = mlx5_tc_ct_entry_replace_rule(ct_priv, flow_rule, entry, false,
-- 
2.44.0



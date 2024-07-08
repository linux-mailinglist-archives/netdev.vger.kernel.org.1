Return-Path: <netdev+bounces-109767-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6EE6929DE7
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31ACA1F23265
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 08:02:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1517C3BBE9;
	Mon,  8 Jul 2024 08:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SrdLNdFr"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2068.outbound.protection.outlook.com [40.107.101.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F6163BBEB
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 08:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720425740; cv=fail; b=XMxMa82KVbHe+eSuyBE1/BILYHPCnVbhbMCR4LTK67ImV5RF3WUU21O7FUdd0qGzUr231mlj/1H/3C0FMojqi33CSzIuALdxro0VI0YwadJTG4AheTBBIepgQ++Voq+IJnLHRqBrSKQv9GD7lUsEXqX39dSvEGp1mVQ5uKfq6wY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720425740; c=relaxed/simple;
	bh=E+w8KXjvWeIa2V8vROs1111Qp46vuhWTtD0K6oKo2wE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifTw8a1AdBsxcYUA+Dd5oKu04JehL4QFD1gvKaCt2U4lFhnzL9/s9OL+2Ra09l7r5sKp1sj5bGc3BlBY92jxcgA58rTnkah+GlgZ4NgGo9N6AzeoKnkpTnS5AbOuzsu355wp/yEqu070vfrDaZsaGcpbdFKYzWdQEoJWy2O1Urc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SrdLNdFr; arc=fail smtp.client-ip=40.107.101.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Y4gu1qzKl3tFIrwrSWpqrQhOnXCcGSOHgP1X0Tx5jthWo6IC1pYlVBuR0ki6HNjOtWfJBGPTo6rR0uVwrBRruQgtumdnlaW1fwJaxTJUl7vljDfhjEfwuvSIUlPK/HORgxux47937qiq9zkCOZY1dTPt/xUnFEgBbWZouXXLIg19xDUZ2SJWLQmqM3cLH2tsgxqc/tvAESzBeonQFv7O6KV7xsK7dkZBWGY4nimZWUGDfSdXokVVLTpHi/YhvOtxpxcxT1TNnzj8gkDixkE79GX7n8x13lfEwAxdGSUtjMlXVWevgKvrGEpgf+mlEu+E2usBxty0/h06Y/7klyLZhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Gw8ZiEzx3HHRbMRgB0Qs3f+4Km3q7TmsmWGNBiTcK6M=;
 b=N1MxccWbZJFHqVy2+5UvtECvDwONoWAJ3G2px/yzvj6P28ZbN43EZ9kv1K+DtcswVql9iijVD3lr9PPgXeHT5NvJdpcbKKMHcqN5jYsHLBqaORf3koKO7uTkHxQ4y8rrDADwE7wgoBUN7SwYJQF/QsPZD0XzydsCNPz4+idI3mLXac7AaSnknipga5I6xl0nDd4G/VWEDn1b/0wn17ZDAN30iiXzFvIEGNOP6YOSZEUL0BKYpY9SIzNV+Re9YdwatW4ffV8YkbMvk+z7WVOWtv87e8NHJAam1weHYZ/js9S/WKR0picO8G3kYRiyzgMqhdz9ha8OEdWB/iBUdJu9sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Gw8ZiEzx3HHRbMRgB0Qs3f+4Km3q7TmsmWGNBiTcK6M=;
 b=SrdLNdFrxfYIm2PLwGhxppnanJTnoorFdcYAtHEKSSxc+Sd+pYH8JkGNok/x/3F6E6MZ6XaREmDzqNhZKFa4t+XQjIX28gaWuTJnEMFBMpbP0uIn6uMz2go7COpMK++9R//zf9RsXdHOT1KOkRHP205Dn46PlBS5lkOZ3L1tWUoNatUBTpTpAjDbuOk/IQdwUj7VIFLw5gdjiqyllakIhQ/6r33CPtQ0aUPDxGTR+iSYbIjOzNqJsFSopLt1BKh9O1NmIlImoJdREo/KdwJNtx/KMJ1gk5lvcKLuU7DcLe8PnwMHcvlP+YNRd64NGbZaadNX2tU2lJxNMAOarSbk5g==
Received: from BL0PR1501CA0021.namprd15.prod.outlook.com
 (2603:10b6:207:17::34) by SJ2PR12MB9085.namprd12.prod.outlook.com
 (2603:10b6:a03:564::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.34; Mon, 8 Jul
 2024 08:02:15 +0000
Received: from BL6PEPF00020E61.namprd04.prod.outlook.com
 (2603:10b6:207:17:cafe::e6) by BL0PR1501CA0021.outlook.office365.com
 (2603:10b6:207:17::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.35 via Frontend
 Transport; Mon, 8 Jul 2024 08:02:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00020E61.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 08:02:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:59 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 8 Jul 2024
 01:01:58 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Mon, 8 Jul
 2024 01:01:55 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Alex Vesker <valex@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 08/10] net/mlx5: DR, Remove definer functions from SW Steering API
Date: Mon, 8 Jul 2024 11:00:23 +0300
Message-ID: <20240708080025.1593555-9-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240708080025.1593555-1-tariqt@nvidia.com>
References: <20240708080025.1593555-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E61:EE_|SJ2PR12MB9085:EE_
X-MS-Office365-Filtering-Correlation-Id: 8b0b380a-8d75-4ea0-0378-08dc9f2447d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qUiAWU10tUfM3z8sD54jpokvhh6hkO/b102beSBG872mD9mB97aFM+/FpX29?=
 =?us-ascii?Q?f+snDxlKiAT1tn8lFvjrSZKncgO53OtRGG6hx0UTKzkJdr/MqKn7izhazifS?=
 =?us-ascii?Q?EJbUbvwYNLbKrEdfZnxjESBMt8LEItyqC9YIgqW922hgaVP7amN59BUyul6G?=
 =?us-ascii?Q?s2x1rHL7HBYQTjvOXHtHfAJJiU8x57yBsD9aV7ZEbdQNOO06ceqN1z0IA1OX?=
 =?us-ascii?Q?EY0BRfIRWuei9+mgaq0lwcdVOu9OK23kg2Z70ETCsHfDGr6mH+3IxvLBvzF3?=
 =?us-ascii?Q?zFta8WrLd09owJsbbAa+Ao4cFJSCGN1go2+BQjCd7Hzx6SXfbntiCIVbR1MI?=
 =?us-ascii?Q?NAPkSMMG9zstiiRP8GRMDHhOZbTJe1EhlbWY6qEpBV7+9dk7P49c68FBNPBH?=
 =?us-ascii?Q?QOcen+mnfVNhbffWD60Nu6naBeAcfUY9P/PJccctxZqbx7CERhQ55C012+7I?=
 =?us-ascii?Q?tg8RWZe3/yThgDyrxhqG/QYQ1U9X88bYrGbTzm0SKDEItj8vNLOfwKjyYHui?=
 =?us-ascii?Q?55ePSMC4em9cxvizF36KMXScAq1Ha12h8iSdk6GUlNOALVoDEtLsLkKY3Iu3?=
 =?us-ascii?Q?6tfMK6nx6kvAJgeJdm0j476+kTk8syRR9kI66v/1FTTmhrWSYZeoaqCaY7R9?=
 =?us-ascii?Q?nBsdLw625r8Ik7z+BpsUZT1oaOtnVhOh2vXlAReA8Dlltaxj/aPXwPReIA/A?=
 =?us-ascii?Q?oAzMlcCJMz03+ql0LZ+b5gy3wiNzaiI/yxFL72XjjwivQ9hqULMQoptszv+W?=
 =?us-ascii?Q?kkeRKO9V3/n/A8CVLxYg9lEzjhX/xVFGgpcuircCTy7YlnvUyhrwc3BnxW1b?=
 =?us-ascii?Q?Kegv+5jIc8dcY+4l6MMX8/MPCOuX2GyzMpMUsgsIsSBd1uqqdReT1V6wBnLZ?=
 =?us-ascii?Q?VYEwvWwDCTScODFZheDtxHlH2Td98I/x29/WN0Cyw6ZIfAysrIIX5fk1dMHC?=
 =?us-ascii?Q?Ld+6cWNspWDm9yrDb/UqGufvwD6Hhen6RDd/LAnNRy2SgUEOakclu+L6K74s?=
 =?us-ascii?Q?iRlz8/3qtAdaMefLxsFHi0d7GUK8rspvuSQE1O2Wg5FajZYLxvZt729DUFij?=
 =?us-ascii?Q?JMFFof8BFAC2NGZ7iFw0jFg9cagFkAMHX29uzm25VtoTIIMVV4IG1t40tka5?=
 =?us-ascii?Q?HcspCYH/lesgkjz6usGklHWRi2tA0AztiGIsa5F8eqcaDjF+YS+NidwKbWP8?=
 =?us-ascii?Q?ALlqLzbyD85HPQ4jyH8qtCa0+qL6ERoBM705wOyIz476Op3zOESPchc21gM9?=
 =?us-ascii?Q?ZDez4OX9nLUFDmmTWb5vz7FMR5ytKjQ2XFFLZGi24Wbo2DovAiasxzS2yDi7?=
 =?us-ascii?Q?hjQD4iIZUNZNe0fECWN0zzpQBwHTc2rOCLv6UkWMS28G2/DPfBtqPb4xK8Lm?=
 =?us-ascii?Q?rFQGKruagw+eMJ2jNDQ6nO1XTcsrq6x98FLyVIGRfPQJhZp3zbdOSeVTOuZr?=
 =?us-ascii?Q?oSKlr/8fIdy3WPUJtRkLKHsXyWz/5FWp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 08:02:15.0518
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8b0b380a-8d75-4ea0-0378-08dc9f2447d5
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E61.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9085

From: Yevgeny Kliteynik <kliteyn@nvidia.com>

No need to expose definer get/put functions as part of
SW Steering API - they are internal functions.

Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Alex Vesker <valex@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h | 5 +++++
 drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5dr.h   | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
index 81eff6c410ce..7618c6147f86 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/dr_types.h
@@ -1379,6 +1379,11 @@ int mlx5dr_cmd_create_modify_header_arg(struct mlx5_core_dev *dev,
 void mlx5dr_cmd_destroy_modify_header_arg(struct mlx5_core_dev *dev,
 					  u32 obj_id);
 
+int mlx5dr_definer_get(struct mlx5dr_domain *dmn, u16 format_id,
+		       u8 *dw_selectors, u8 *byte_selectors,
+		       u8 *match_mask, u32 *definer_id);
+void mlx5dr_definer_put(struct mlx5dr_domain *dmn, u32 definer_id);
+
 struct mlx5dr_icm_pool *mlx5dr_icm_pool_create(struct mlx5dr_domain *dmn,
 					       enum mlx5dr_icm_type icm_type);
 void mlx5dr_icm_pool_destroy(struct mlx5dr_icm_pool *pool);
diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5dr.h b/drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5dr.h
index 89fced86936f..3ac7dc67509f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5dr.h
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/mlx5dr.h
@@ -153,11 +153,6 @@ int mlx5dr_action_destroy(struct mlx5dr_action *action);
 
 u32 mlx5dr_action_get_pkt_reformat_id(struct mlx5dr_action *action);
 
-int mlx5dr_definer_get(struct mlx5dr_domain *dmn, u16 format_id,
-		       u8 *dw_selectors, u8 *byte_selectors,
-		       u8 *match_mask, u32 *definer_id);
-void mlx5dr_definer_put(struct mlx5dr_domain *dmn, u32 definer_id);
-
 static inline bool
 mlx5dr_is_supported(struct mlx5_core_dev *dev)
 {
-- 
2.44.0



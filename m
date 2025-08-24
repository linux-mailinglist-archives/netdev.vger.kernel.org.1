Return-Path: <netdev+bounces-216276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B860B32E37
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 10:40:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480321B24976
	for <lists+netdev@lfdr.de>; Sun, 24 Aug 2025 08:40:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EEEC25B2FC;
	Sun, 24 Aug 2025 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="QEsc8/p+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A808125A640;
	Sun, 24 Aug 2025 08:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756024819; cv=fail; b=entzuV6+sMYnHoY81fo8E6hB6h7xNlJcUlv6M68KTRdsM5O50+ojtu/JWAG/imAza4wNKYn5LnB9ExwvgbLtQKoSDcnoQ8/7k2wmV0BV98qvyzvZT398znWCgqHysDCxaCENoAgHqHqjltHVTrFraDMDmfvBFo7vtkR7qUytctc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756024819; c=relaxed/simple;
	bh=BuZh93THeyQs5xqcYPmOlpgjuZGTV57DFBzRGiH5Ne8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ORg4Fcyv2DuHd+aaLdBWdEvwCzB/pvkZPnEyiZgO5v9n5NNwGAO8CvoW0VPP3H9LX4lKIxrv0JizyIR2dNHWeSgtnPI4KNUMgb9Tbp1JAIl0lbcg//mwBUSUoAM8w1agY6RBbf/rsXUUv6zLg586zRBtd0JgF0OiLvm3derGqL8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=QEsc8/p+; arc=fail smtp.client-ip=40.107.223.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oac8F726Oo+DtqSDUFel5c04BKYdtwi+U1qc8Dzxq0T+IHVzHcFqkWCnM7l4TPKVVHa8LBs+IJtoKGU+JcwweTXVIItCJrS/4Cx7zwBQiufNA8Fn5/M+DwwI2p7NoU4AFDGanj61CMw7w3gSwAMHbma9MEGlE01cgSZUr7igWWuUqo0mi9zvV9pi8jDFwiNoH3FMX1SPfEpkM7mBhToksP+vKV9wbSRUi551Xn0qS82CLv4GCpz0zGFh0x5fwrEDLW2iSgi+REb07o5e7zL2A6TTdr2SJReP3shjrxqx5rDD9yGEC1b32l7egFFAZnFRe2etHMWP0AMhRiTJwCCdFw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xu1Y+5QkdiK0Xoyelf4Nc6ETXfDa+kPiz86iUZo6ndk=;
 b=gXHjL0zLRxydy/RO5H53nZpLhCfyG14zjc6shGdHbcLo04BsfET2RR9s+DdKQ22ZwHrhWa3R6liTrUbYSrK2Vq4iY5N8mor5fI5AD1LMgNP17M5sdy/u/hX1yMMW9pbgXY+i2SQen8ThHHR4TL+cHHG4T/a07KVUkZ51hImZCZFAbzekGwqbi/qWn9ZHuRngI5h39myFq+jjViMF66peLJAJBrMhJCsl3Nohrq6tuZsbZ7+Qsb+5mdMn6xclaj4t15ezVCT+ckaLpr6XNiXY0WDTlFlL1dx0pes53namyqm3bFI97Xy8dpYsS1hZ+Qeti17HyRzpImZgdzUL9q2mag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=google.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xu1Y+5QkdiK0Xoyelf4Nc6ETXfDa+kPiz86iUZo6ndk=;
 b=QEsc8/p+VLFo3k/v+ZlFbltckb9hTFCEdstK7tw+UhlzIconswRMe12Vitvacz6mBCCZJDYWBwF5t4eVh1EMVjBI8srqmTjGD4J6cAVz7v1EbbNIoU6ccwkMzSZIdWKFJ807tqus5CS+/pmYFq/fI4uhQO0Js5c40+fnMMz84pL94KrUNFS5tBoLE8HFPLs20/6qYkN97a6IG7OWYZIALYoKC7kzWg3pAf0Rkvo2yJ9OURQ6BcBSroxzvPWtsy4P7i2ApmKlEvtIywgWuMdu8LdlttZMYP+JXjdii1oF1ia8QSYGOEOaBOuuGhmBGi+OyFbfaWtVbTo8NdUew0gj2g==
Received: from CH5PR03CA0017.namprd03.prod.outlook.com (2603:10b6:610:1f1::12)
 by IA1PR12MB6628.namprd12.prod.outlook.com (2603:10b6:208:3a0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Sun, 24 Aug
 2025 08:40:12 +0000
Received: from CH1PEPF0000AD82.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::3f) by CH5PR03CA0017.outlook.office365.com
 (2603:10b6:610:1f1::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.21 via Frontend Transport; Sun,
 24 Aug 2025 08:40:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD82.mail.protection.outlook.com (10.167.244.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Sun, 24 Aug 2025 08:40:11 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:39:55 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Sun, 24 Aug
 2025 01:39:54 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1544.14 via Frontend Transport; Sun, 24
 Aug 2025 01:39:51 -0700
From: Mark Bloch <mbloch@nvidia.com>
To: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>
CC: Tariq Toukan <tariqt@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
	"Saeed Mahameed" <saeedm@nvidia.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Gal Pressman <gal@nvidia.com>, Lama Kayal
	<lkayal@nvidia.com>, Mark Bloch <mbloch@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Itamar Gozlan <igozlan@nvidia.com>
Subject: [PATCH net 01/11] net/mlx5: HWS, Fix memory leak in hws_pool_buddy_init error path
Date: Sun, 24 Aug 2025 11:39:34 +0300
Message-ID: <20250824083944.523858-2-mbloch@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250824083944.523858-1-mbloch@nvidia.com>
References: <20250824083944.523858-1-mbloch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD82:EE_|IA1PR12MB6628:EE_
X-MS-Office365-Filtering-Correlation-Id: d13a21e7-2eba-4bc3-0d70-08dde2e9d70a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?n3woIPlf7FfBpUQ9Dur6eEFrSHKn3DpIvZOdttpncVA54/UBNxq42Y+8qktL?=
 =?us-ascii?Q?q9nwrBxwDHZAB7htZl0W9O7MDlLQ8QmsNNiFN5z/Gk9ftHWQcZQcg9d7j0Xr?=
 =?us-ascii?Q?lCUDMkdp+K1rYBgGIk1XoHXuGWMldswmRFkNnf8ERN3ziA/nv+DaPG38rEc9?=
 =?us-ascii?Q?br+0edGdfd7W0X3v1hLndcbJaOqVxVzAxPAvYtawgE7oSAnuvOHOJ8c1ECqQ?=
 =?us-ascii?Q?har0uoqmmJw6KUP8TVKGPIRr91fRQgcBiZE8ORt86JEkyD37HN/wK1AhxRUP?=
 =?us-ascii?Q?VvaMtEq9Nk/Q1TT0AcqIUZ4lsMpLafgQd9Y+Y6XmiWsdF2WHeivZ+lpKTLYl?=
 =?us-ascii?Q?kpl8aZ0ZgRz145/JtquK5zTwbbgOZmfKDh8aG07TQJp9DHJOYItgFSyYOQxt?=
 =?us-ascii?Q?spUibtjBi3AxIaztVMVdTWiuZevExbM8cZbnwq05HMN6UK71AvClmf196DNW?=
 =?us-ascii?Q?6ov6R6X4jume/Iz4FCLF9KYGfak1/XnpS9Id6k6evnbEgT9ihDHksU6NErwL?=
 =?us-ascii?Q?ed9mDLCbVSlmwo06QOQBtl2Z20jNwFpAqr5o/26MlZ8lhZH0x8Jf+fFbTrYX?=
 =?us-ascii?Q?nVhTa/31YKK+kOb19MwwzgPPNms7iINX2Ncl2bGfqO/MVkZ8vhEUMAcEj5dL?=
 =?us-ascii?Q?Z+3y4k644ePVcovCjms2KwGokMXqm4cwZxxvSJmP6EjSi+WVwuWYC0B/dMJy?=
 =?us-ascii?Q?z8nIaut3QQWCR8yr9aHZTYb4hueWRsqbk5Kg0fCs6J4o0R4kRJDOK2VZjL/v?=
 =?us-ascii?Q?CoMfZtk1YpVn71gHXeKzUSqdOsquJ/vLs3ex3BfN9aInGj2SdX4JrLOy0MtI?=
 =?us-ascii?Q?8ifaxluD5pmRBMLIX3Kfq2INVZWZlzYUjhR9SRWF7pc14gebtR6b3uxR1SW9?=
 =?us-ascii?Q?5uVvt+QN16T/okc9V2spvzqtIgCUWLIM0MggehQzczPTdYFta6NarchWdgvj?=
 =?us-ascii?Q?g1O9VzHUbCCscYxFF38S3uGGyXizzHaEY8J/jXooH8H7TCAADOlWvc0S3QhI?=
 =?us-ascii?Q?ZQw+jIj4FuSXG/BkeyPv8xX0jvAgty/vPVenNTOvKZDQYUhcdW7hUtQa3Gux?=
 =?us-ascii?Q?M38uk9TIuEzm7ZciaHNnWL5mAKjmfFwPx9Rsp7uxlYtc/ro4/y9uuI+VXgYd?=
 =?us-ascii?Q?2Jvl65nsr31AWtsc55XeM8spHKsI/WvF2g4LAZoYM/28z4tsBntaEzwnsAfR?=
 =?us-ascii?Q?tBv+ixA5X8kfwdaeeWRMgVfn7xRwm5yb1sH1Z5QXadVeXCg0s/fwk++X95Nw?=
 =?us-ascii?Q?NDek84Mp17sItIbvQu0x+4fuzY2dKf9QvEcg6rxv1nmgvefWkgfi9t+DxmuO?=
 =?us-ascii?Q?XqBu7IuErSWgQgeTzR3jxPvGT+xeXvB/wrozSMAxXaIl7pkBiRRSUIYQCZJV?=
 =?us-ascii?Q?VFipe8kZiMjcg2R1MtpTkuzck2FqbT+dAZs+xQYkoqZvW+KzRK3wf5kckYrZ?=
 =?us-ascii?Q?eyYb7Pl+/Dr6uG/Ykim0B7Tlm1yXvecRYh+Awh4SYd6dEvPqt/5IsYVTRDnz?=
 =?us-ascii?Q?Mh5+VoCAdadvSku0nw+f8+hgDbyoLS6T/8U3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Aug 2025 08:40:11.7313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d13a21e7-2eba-4bc3-0d70-08dde2e9d70a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD82.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6628

From: Lama Kayal <lkayal@nvidia.com>

In the error path of hws_pool_buddy_init(), the buddy allocator cleanup
doesn't free the allocator structure itself, causing a memory leak.

Add the missing kfree() to properly release all allocated memory.

Fixes: c61afff94373 ("net/mlx5: HWS, added memory management handling")
Signed-off-by: Lama Kayal <lkayal@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Signed-off-by: Mark Bloch <mbloch@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
index 7e37d6e9eb83..7b5071c3df36 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
@@ -124,6 +124,7 @@ static int hws_pool_buddy_init(struct mlx5hws_pool *pool)
 		mlx5hws_err(pool->ctx, "Failed to create resource type: %d size %zu\n",
 			    pool->type, pool->alloc_log_sz);
 		mlx5hws_buddy_cleanup(buddy);
+		kfree(buddy);
 		return -ENOMEM;
 	}
 
-- 
2.34.1



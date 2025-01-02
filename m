Return-Path: <netdev+bounces-154821-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAB069FFDA5
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 19:16:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0E84F7A12A4
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 18:16:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D392C1B0F0B;
	Thu,  2 Jan 2025 18:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G00QIVsQ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2053.outbound.protection.outlook.com [40.107.100.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7453613AA5D
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 18:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735841775; cv=fail; b=TIFQr/PS5dMrPPblATW+B/8Mwh8wBNO5PHLPmvf+PDXZFIJbwsX5G67lv8/PR6Dq2ofOxSv3Q/Grs2vPGEOmMseRMlk9/Vpj8Y9a4b+Q/4TjOsb9u/RCgh0Erfj+WyZNLKJ59TamJ7AT6+kFURUursRady7Ousq5gQaXgAL7pIo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735841775; c=relaxed/simple;
	bh=7N2HagnzyILetca8262jCZvzlZgYWxJ0JjnfcjDNs6c=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QIm/8Vz/gdCqFs2oPtJcZ1De5hfEOSN8JYcFuPD+QG5s9HJQY8xgp35Ve9HWdjOM7x3VcQqGWXa+3mHpQ8/JAcaDzTqfEAytIvlmTvUqQUseuhvgyGtCHW0CX2bAwzCvktJO1p8agkoiKMYWFrHCB20LAy1k3b+nrUd7xEvC9CM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G00QIVsQ; arc=fail smtp.client-ip=40.107.100.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/VLhIudK8u11FxntUOl6fenEZUlKRuoe/8Hb1wBXIBhy5O7ZSLcocxjnWoj3G8NShwWTeoNe/sxgCbofzrYRKu2qneNzgMPaSYE6Gb8G3SsnI6dFRMhtzWvVYYyY8ar4YSN7et1+OIXnLDcyINp3f2PMjh6l05B196Wu31EoxdvrLlIkQ2wEubH0WBgJFbMR8eapSq1hk3nuKWjAhyY3cgjDyGzrGXnasP+1WJsdQez4ROSBpyPfr9Y+JB2sVv+M/zGy3O2zMUKH//xbyPaf/fF2MToF1xT/AAoVIjV9CY6G4CgWQaoWwk3ZsAcPKyq+XkIZgp2YR4d8neajf8sSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l+i8KiSUNaWLa+aBhhKcipW9Zmlpx9DrOx+8c7N3YW8=;
 b=PLsnOUXClgLmmzSjUGqVdcSdHYk1nEt5r0TEY6SECsub+LQuFT5hN+9MtAeyBQDP/vWwvfegI+nyh7RYFUJwJ70g8hfiqr+pWKQX5Az9AVSnYh8y2ijO4UC1+N12Plua7qP7QeAh50pylwIlL+s3O8V08BVKxxcgs2LsqyOpNHDje6KbxZCrjRUEM0qqHkPVgFFcmSt6U0ZTuGxiT24y7jFJv3b8n2ntbSw7r9N8IUF8GRTVhnQaR9iX62VlSiwU8JyLR4Zd5V28m7dsfpPfq1B1VdVTeSZ4q50125Z1NfxkXyzHgG9PGgiA+oWmym92WIdVFgt2t/4DJ2FzwISsiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l+i8KiSUNaWLa+aBhhKcipW9Zmlpx9DrOx+8c7N3YW8=;
 b=G00QIVsQPD2eRrl7YGc4kXoTgccF6WkfspUpE+BoPKzOLAvPBLr7M7Bc3jY+HcBM8CtXnWBbtnamrFJF39hnF0dW0H3GsrStrP5DNpVw0EUVHdW691P3DWhQp9MluAB4kSHqdwAqhhAMSlCE7/gVIst9VyI8LKPM5TFE6VGbkT0QzEDX41u0Fpr1c5IPfLfowG/A43+ZrrhkNwnTb0Atk1IEOsrWUZtNP586AlRDyvP0jUDmF5DIYBqJMfRuZPCO4T0X7+wPuTItlU81/kX0TJZioNGapPR9JjOPXh2eIy2xM/1pKafIkKUOOVf2LEEb+pXzfrwB4gWT34sI4OZlDg==
Received: from MN0PR03CA0012.namprd03.prod.outlook.com (2603:10b6:208:52f::25)
 by PH0PR12MB8174.namprd12.prod.outlook.com (2603:10b6:510:298::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.11; Thu, 2 Jan
 2025 18:16:02 +0000
Received: from MN1PEPF0000F0E0.namprd04.prod.outlook.com
 (2603:10b6:208:52f:cafe::d2) by MN0PR03CA0012.outlook.office365.com
 (2603:10b6:208:52f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.12 via Frontend Transport; Thu,
 2 Jan 2025 18:16:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000F0E0.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8314.11 via Frontend Transport; Thu, 2 Jan 2025 18:16:00 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:47 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 2 Jan 2025
 10:15:47 -0800
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.9)
 with Microsoft SMTP Server id 15.2.1544.4 via Frontend Transport; Thu, 2 Jan
 2025 10:15:43 -0800
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>, "Andrew
 Lunn" <andrew+netdev@lunn.ch>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>, Yevgeny Kliteynik
	<kliteyn@nvidia.com>, Vlad Dogaru <vdogaru@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next 12/15] net/mlx5: HWS, handle returned error value in pool alloc
Date: Thu, 2 Jan 2025 20:14:11 +0200
Message-ID: <20250102181415.1477316-13-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E0:EE_|PH0PR12MB8174:EE_
X-MS-Office365-Filtering-Correlation-Id: ffb06548-6e03-482c-64c5-08dd2b598354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jNrw+yvXxbQ/BcSUltHMJuouDadHHi3mXAyGvty9EF207ww28q8QezBbeW7N?=
 =?us-ascii?Q?9YpGeF3++G+ESrdFYvYaCTbY4hepmIInHANZ1/vH8NgQxjKupHxLMSm/bKaU?=
 =?us-ascii?Q?V6bVPIlwTctwza/0Le4yHg3ITowNBiM6GFdDsixAGGa88qTNklHQ1OOMLwhF?=
 =?us-ascii?Q?ANBr01qxFBXbBi6eAObKdV34GcBeuB0/0TFw5tCs31FC8Q2P8Ysrpjlvsnhe?=
 =?us-ascii?Q?3wfXipKQSPkk/bPmiOGnCaWgQcf42T38YubDazajTjvbL72XSSglf3tjCujS?=
 =?us-ascii?Q?enKe0RzBeaEcrCtaDW1KzPmzq1e98n9rywszPZzhrid1WR0Nt/5n/7w3+BbL?=
 =?us-ascii?Q?S15vGbokk9QyZAHl4OazQotxV674uqtokSg4sLK1UZ59dQaysqAo11mTIaCb?=
 =?us-ascii?Q?BIz0xHvDYOFOUbTidggdvtd9hog+2JC7vTRp0VKZrpHl32f7zVA1d96AvjKO?=
 =?us-ascii?Q?ncOZ2hVa5bhSIEmosBdpWrCOY7czJA5dJAdHj9oWZGdt6/OvhycU/hK9RNgw?=
 =?us-ascii?Q?1Fu5B8mKyBSXBmd1kWTiqRJ7uJIaIOQWoiv73YQDLM7qoFILkhqYfk1qxo/H?=
 =?us-ascii?Q?zeWzPA3Xrgyq2Odhnhw/ThaXAJ4f2MKJIe4PjCS37yQucYE2EvCT/v/hvdzb?=
 =?us-ascii?Q?/illlnetIbJltoUOjU9EKLCOnpXGfJvR8v/ygrOCmikQqwk/h6WCwz3lii1H?=
 =?us-ascii?Q?MU68zTXHEkI/rG+FiRvIe/AFe8I1RAlB0RwITwxrbM6PTpRvGHKsgvZ3P2EN?=
 =?us-ascii?Q?LOPXM97NkpZwPKhQYPJdf+3X4OfDn9iaQJgjjK8MFMIkDRZbWM+ForN9B7Jv?=
 =?us-ascii?Q?e3yY52ivmE8Ij1SVf8yqYzWMTKsJnSsKlBWDzJFOxFmqhKa1+gyGan9Drww0?=
 =?us-ascii?Q?bSAyecgvpvgr/WNpYe4GiYnfCupet2KPnEbWmEMkmZGaMo5/kGUGhaN/9tnH?=
 =?us-ascii?Q?b1IHcz7pBJ5KzseWLewC9ZUMv/Xc1Q5DigEDKNfnUB9WHP6FELGy67tbp2tC?=
 =?us-ascii?Q?D/0EMIPnqH0EwQnAtCkQlV8ufATRrYoFXhwK4YTGmXS/0TWXzsERlhaQ04ez?=
 =?us-ascii?Q?zT+enR2cUhzHtJVbupcbbeYy9/dFXTN9+S6haprvdo8iIKWnQKchzrC+HQrk?=
 =?us-ascii?Q?Vv946SSA8kbapMU30Vmcr3UpEG/RePYz7ii1ARZ7ldrna2szHarUdItoyqKw?=
 =?us-ascii?Q?5r2/MOIxHUmU4uIy3eub9HQNSc0XFRv5fCMBlvWXSwehL8vm+gFlYPBfYF1b?=
 =?us-ascii?Q?wBNHT5z/TWqXMO3IlBep7OY6X+UjpdUEhmOPrNmUfwhRbIw/Ks2LzlKLrxfx?=
 =?us-ascii?Q?DMXac3hK6Uon4A/0r+Gjn9s5l7Pp17axUnCaA3TeLWuCuEdU1GQMqV1ZD/TJ?=
 =?us-ascii?Q?hvRm5z8EyPKmAzCpyuLh8VZkGwhFjAn/XKQyguYiLARZ8UizleCgv6K/HFCP?=
 =?us-ascii?Q?HfUhrL4D2mTDH/lEAK7CiEKaZiulgZx0GnzON2d5LYrxOSTP2ksvKY4dMU1w?=
 =?us-ascii?Q?wFh/yPESUtbvFLg=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2025 18:16:00.9877
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb06548-6e03-482c-64c5-08dd2b598354
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E0.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8174

From: Vlad Dogaru <vdogaru@nvidia.com>

Handle all negative return values as errors, not just -1.
The code previously treated -ENOMEM (and potentially other negative
values) as valid segment numbers, leading to incorrect behavior.
This fix ensures that any negative return value is treated as an error.

Signed-off-by: Vlad Dogaru <vdogaru@nvidia.com>
Signed-off-by: Yevgeny Kliteynik <kliteyn@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
index fed2d913f3b8..50a81d360bb2 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/steering/hws/pool.c
@@ -183,7 +183,7 @@ static int hws_pool_buddy_get_mem_chunk(struct mlx5hws_pool *pool,
 	*seg = -1;
 
 	/* Find the next free place from the buddy array */
-	while (*seg == -1) {
+	while (*seg < 0) {
 		for (i = 0; i < MLX5HWS_POOL_RESOURCE_ARR_SZ; i++) {
 			buddy = hws_pool_buddy_get_next_buddy(pool, i,
 							      order,
@@ -194,7 +194,7 @@ static int hws_pool_buddy_get_mem_chunk(struct mlx5hws_pool *pool,
 			}
 
 			*seg = mlx5hws_buddy_alloc_mem(buddy, order);
-			if (*seg != -1)
+			if (*seg >= 0)
 				goto found;
 
 			if (pool->flags & MLX5HWS_POOL_FLAGS_ONE_RESOURCE) {
-- 
2.45.0



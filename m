Return-Path: <netdev+bounces-86246-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5ED89E30E
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 21:11:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 02A2A287017
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 19:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD82D157A6D;
	Tue,  9 Apr 2024 19:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sJbxA3QI"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2061.outbound.protection.outlook.com [40.107.94.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFDC1157A5D
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 19:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712689764; cv=fail; b=Eyb2aOYE54Gb6HXN2CwBit9FO0wE0htnc5p6x+LS0mtu5m5YfizocNBZ5bXYb/E0YnMj0olCLVhtqRyxUNZQ++QGiQWEfBfhoOKi/8B8mhVY2TtN4S9G2tWq8iNVqEDdDvpsysQX4zVvOsWUf2xhH7RGkoUuQkYeuhRJLH4dEMY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712689764; c=relaxed/simple;
	bh=/v5JlDkbKzZpQYBBah2ju3dJc0+cBFhGdCbVzrfEgXs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qHrNCpiFYOVVfSOk/RIwAwQI7kVt4C/ahC0aKuSwqOY4cIcWY6gn9sYWwN8yAD6RI9c9VPHmdJWqRhsiHEVW6yIQArY9tO7hUh8kgIOmwRq+4AHcPqx1/EwAElxRQEZKH4/vQZ0lX+iJUTYAhoainnXIAwkH7RtGISTxHRcqtTE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sJbxA3QI; arc=fail smtp.client-ip=40.107.94.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=baMPv/i3bxHL/HeWZwE3lC0tEghWdu+4Es9Xe2yJO+MVm+6xwZlPrGaemn84B3wBelvOCMfzJuzuDUG2SKJY1T85IRzCYAq9kras9FXRiuF2qrbucbzHhX0Na0yXD2zPSiWTTuZ+j42P4DofsU1qWWxe7r9a799bVy0EzeUZ/EVag6x9l5r6+PEtrMn5YkBRYoVPfGOOy9zwLlhrYzM4Z+Vc7wh94rLjd3PiybCpmHyh/NfPP18u5IUOEkVq7CNfyM5YxTJeY81VrGBQwu8RE3fxGabxCVq54aOYGX5u4hmFfqvOZ9QnqH4+9WJYb5Y7Po61aZkH7Rerr9i+QtDp1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y+/xu5NGzBnA2//hXU95MBjVfDa2Rwco1BeMV2CEHCA=;
 b=MV7reuMYY3JAgDUokBuwob1FIkCTMfd8XsJMY8YFyhJ3Kx7gn6V6OBvQUtllkeXBSq69iExmWjw4wB+fY9HRcuXq4GcNrpyGW8Kb1RK7tHioD4MhECMZnSXTHq29/ibQgrHdnhpN6qaUlVgv1PKep0AmDk2KklpOTfGpxKeHUuZrfI+liz9A9WYy31s/33cAlD03OSCwlUtN9WIXUw9wI9jk1lBb8rvN54ZOztUCtreBY2e+lDLx6CFIujULtQf789wuNmONjFyzRF7VGpGefBjoVs5GRPIo45Dk6eqdSJr5Jhd12OBPxCQ6C6dv26i2DvMh3DOYYFKmMSKK0mwwqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y+/xu5NGzBnA2//hXU95MBjVfDa2Rwco1BeMV2CEHCA=;
 b=sJbxA3QIUN9OtdPt6ZAlrzCCUtpHlGHw7oUBXpJ7tej7c032ltJdthk7vvmdZMQfeQATCn9jt6fAsleo3ZSO1KpTXh50ddmOVPqtGsnvJW3Jiae+jGf8h9e7oO4rjXpfTk4MecTZayKrpu+St48/oLy8YeNu3t1LpnRosownhWysOEJF9TSMOy7TWHeogJjxZPAOI0lKfNIuxhuyWt9wSscsx/VItaGQWkCBCMCIdRM8gncYMOjby2SHtVVle8+lcm0IinHWeEkUVab/ohDpAY192AMi3sPiursZwUwxEg3Bj40yBujjapbsVy5BHWRKRiTCrK6+Lcr0xbrBzkrT8A==
Received: from DS7P222CA0017.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::26) by
 SA1PR12MB5659.namprd12.prod.outlook.com (2603:10b6:806:236::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7409.46; Tue, 9 Apr 2024 19:09:19 +0000
Received: from CH3PEPF00000014.namprd21.prod.outlook.com
 (2603:10b6:8:2e:cafe::88) by DS7P222CA0017.outlook.office365.com
 (2603:10b6:8:2e::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Tue, 9 Apr 2024 19:09:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF00000014.mail.protection.outlook.com (10.167.244.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7495.0 via Frontend Transport; Tue, 9 Apr 2024 19:09:18 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 9 Apr 2024
 12:08:55 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 9 Apr
 2024 12:08:55 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server id 15.2.1258.12 via Frontend Transport; Tue, 9 Apr
 2024 12:08:52 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Cosmin Ratiu
	<cratiu@nvidia.com>, Tariq Toukan <tariqt@nvidia.com>, Mark Bloch
	<mbloch@nvidia.com>
Subject: [PATCH net V2 04/12] net/mlx5: Properly link new fs rules into the tree
Date: Tue, 9 Apr 2024 22:08:12 +0300
Message-ID: <20240409190820.227554-5-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240409190820.227554-1-tariqt@nvidia.com>
References: <20240409190820.227554-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000014:EE_|SA1PR12MB5659:EE_
X-MS-Office365-Filtering-Correlation-Id: 527f3c45-d83e-4ef7-aba6-08dc58c88e7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	2vsQ9siXsCZJ8qEHjMCRwMNrHlXq4myT8DVcUMXEU7OC4ogRHUU2N/aub0jS4sV2KKPEtFNkvabV91Im+P4wcxeBSJYQDsQzMAsRstgIw1wTGHRlF4JgCR30yJx7WXlHoG7AcoqpBZfE7BcmlRAc4DX8MBxWXhZNZ3gH/wqSYvqHJBTpEGrK6taFltCI5oUM7Hykzbs3QaPpvPf3KIaPeILqifjoJ7kXcK1pdQozdNkxFmkP44NGHVIGT7aJgfmQCPc1Klryb2S4jtu5CCgEbApxe+x4IaT+vBp0TX2OyjiZ9TgsRVDz1RwzmPs9aSX7VL2cKtWxI8CepJiUBOfGKqRKcFHAkfqlTz8+tMyfr39k0L58v2SUYAC2eTsfmqMkqvC1/5O1nRJJ5eYrqrRJI2AGry8zjds7SNRlXNXyzZ+7khSx1toV1IkUnghfKc6sIWYg5fh801dD+GHq4jO3u9kroSLTJImDaeL1yaySovpSCVwU+3ZfO1i3OqDKgFG4Iw+sfbeMsEK7bsFRrQiyNfNCunhs9XDQGY0KPBgaQrWUT48b3TL1D2t3c2IuIzPP1vX60rsvTxsP/NWm8Dtpvb+gAC6jvtgWkq7DJ3PtNuq8QOYHh4ODuYEeZF4yU3PLmvZBl/g1awMHEjLIPFoHNt1bdnvfZeSeTwwsMidzaUnEfKeg0QxgT+WvZ7pldSEBaUnjTeMJbP2jDFy9KnqBjQ==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 19:09:18.5378
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 527f3c45-d83e-4ef7-aba6-08dc58c88e7b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000014.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB5659

From: Cosmin Ratiu <cratiu@nvidia.com>

Previously, add_rule_fg would only add newly created rules from the
handle into the tree when they had a refcount of 1. On the other hand,
create_flow_handle tries hard to find and reference already existing
identical rules instead of creating new ones.

These two behaviors can result in a situation where create_flow_handle
1) creates a new rule and references it, then
2) in a subsequent step during the same handle creation references it
   again,
resulting in a rule with a refcount of 2 that is not linked into the
tree, will have a NULL parent and root and will result in a crash when
the flow group is deleted because del_sw_hw_rule, invoked on rule
deletion, assumes node->parent is != NULL.

This happened in the wild, due to another bug related to incorrect
handling of duplicate pkt_reformat ids, which lead to the code in
create_flow_handle incorrectly referencing a just-added rule in the same
flow handle, resulting in the problem described above. Full details are
at [1].

This patch changes add_rule_fg to add new rules without parents into
the tree, properly initializing them and avoiding the crash. This makes
it more consistent with how rules are added to an FTE in
create_flow_handle.

Fixes: 74491de93712 ("net/mlx5: Add multi dest support")
Link: https://lore.kernel.org/netdev/ea5264d6-6b55-4449-a602-214c6f509c1e@163.com/T/#u [1]
Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Reviewed-by: Tariq Toukan <tariqt@nvidia.com>
Reviewed-by: Mark Bloch <mbloch@nvidia.com>
Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
index e6bfa7e4f146..2a9421342a50 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_core.c
@@ -1808,8 +1808,9 @@ static struct mlx5_flow_handle *add_rule_fg(struct mlx5_flow_group *fg,
 	}
 	trace_mlx5_fs_set_fte(fte, false);
 
+	/* Link newly added rules into the tree. */
 	for (i = 0; i < handle->num_rules; i++) {
-		if (refcount_read(&handle->rule[i]->node.refcount) == 1) {
+		if (!handle->rule[i]->node.parent) {
 			tree_add_node(&handle->rule[i]->node, &fte->node);
 			trace_mlx5_fs_add_rule(handle->rule[i]);
 		}
-- 
2.44.0



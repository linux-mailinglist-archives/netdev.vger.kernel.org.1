Return-Path: <netdev+bounces-130805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3608A98B9D1
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 12:38:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B4B0E1F237AF
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 10:38:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C6951A08CA;
	Tue,  1 Oct 2024 10:38:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bmUPWHTk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2084.outbound.protection.outlook.com [40.107.100.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B721A2653
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727779087; cv=fail; b=S49FpGZHAIZmgA294qIp6wH2rXr4ycAU+usyaj7vvrV5cPRlNzYeu3h8PyQK1BE4y21I8Iuas6HquTfO1ljWEq3swyqki3cmp4kMmDs8JfDGOabBRS8/eUdmYMptM4Zf4nMlKnsfjnuns9Erc3v0azh79IpcW3hOdwpAfaXvZ34=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727779087; c=relaxed/simple;
	bh=2jypo7DGpI8g0wA9U8X8BmO5SBEhWXsYOAXjBc5/h3Q=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cUCPJWd8M6TGxex9DXtdiIUAWEW6/5ocpA3ueXlbk0tHGeVm7ggVsUevFM7v+H4MCfVqPkbdDLDUvp8hf1LEKzzTDuQ1RI3FfnauOZ9SJkFFWrGLylrEBCRElZPyYxeMdlHOrrIuGmZUKl8jjxRV/OQCSQIHWLv4+3DOyhNPzlk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bmUPWHTk; arc=fail smtp.client-ip=40.107.100.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ujfzK14tr07HfuxUbw+jhz6oLH70UZeWmrnWsU8YN56kbZbMjMeEdvJ6YGx8bBtq4jXZvDUSi9SNTEKR/Vg/Gwjiysd8yaz87gHFl5JABWmwXlEQg1pUFqOUYchY1J60+gCPFJa4E7t8QfWm+jMgVjRlfljyXzWtUPKqikiO5tzo5jP9P9EiVHRGPG8UKVP8dVYdUdfeP4VLmfoNXoivJzDb4txL+e9uCViYp7rf9pdo3a6lWjFEjwi8Ihv1dzxAzK7ptOTsb7lkwhpqZOR6y+P544EnXVV1HyHe7VKFtcWcXBMbLB3nFKSQGa9FuVubNtp/2o+vsjDqV5KeLn5biQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lRX3CrtQll6TLsWQLDqiZ188Kb1dwWlFcTPrC/ac9uI=;
 b=xM1SJMi1KI6vbj4iMf9kwjzjtqzqFgIBSjEViiHfW8htISP1Y+ruHzVTLNyZ8fzNRJCuGFgjWDvxFWVZaw53pGtc8sJImKdGr9HeWrmjSXVaiUIbcz2Dd9AH2eLVTXujOtLyak9hiSAO591YLz2p3zfn659rzOG/fqDYeA8+gByhyw8vtY7VnilX3N0TnZnmxsZDymxJ3toZKxnEL3wA96t2HPAu/2EDJkShtYZ0QnJwbPWkM/xSt7hYZc2/yD7jL2rOogXFvNyamrfiuVpm8SOeyt1aowGh7+cM0ZlEcCVMTZhFnI4A98anYem5S/cVLJOd/N22eSYItygiZecrEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lRX3CrtQll6TLsWQLDqiZ188Kb1dwWlFcTPrC/ac9uI=;
 b=bmUPWHTkNGd7CbR2aMKj58N6I+Iz+JgpIOLMuzE8k6gUPNI/ywXNgoVqYz8KB3VyY7C2tr9Ng6fmLX0iYN5kGJhUmzJyw9GNhV3EaDd8NzudIfewtn8DDNnqWECsVES4/hgNwak/y7CN0Bzko5FrDlzN8CrnK0W/1W/BFA3zwjVWpLpAFjxFJRD4itrV3a5i7ndYNrN8r/1Es7/6mQmFsAIVzrYk38mCQiaf6K/TiBkveVPvlIB0jbEOKIoxPX9tXiaf6WOpVNsKVj2RYG4W3/Vbe9Qu/W3jPCJTuHimJBsNez6lZvQbJMTa+8QjBrttV0r0mdTV1RDO6fKuOycoPg==
Received: from SJ0PR13CA0099.namprd13.prod.outlook.com (2603:10b6:a03:2c5::14)
 by MW4PR12MB7264.namprd12.prod.outlook.com (2603:10b6:303:22e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15; Tue, 1 Oct
 2024 10:38:01 +0000
Received: from SJ1PEPF000023CD.namprd02.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::61) by SJ0PR13CA0099.outlook.office365.com
 (2603:10b6:a03:2c5::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.15 via Frontend
 Transport; Tue, 1 Oct 2024 10:38:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023CD.mail.protection.outlook.com (10.167.244.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8026.11 via Frontend Transport; Tue, 1 Oct 2024 10:38:01 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 1 Oct 2024
 03:37:51 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 1 Oct 2024 03:37:51 -0700
Received: from vdi.nvidia.com (10.127.8.10) by mail.nvidia.com
 (10.126.190.180) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 1 Oct 2024 03:37:48 -0700
From: Tariq Toukan <tariqt@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
CC: <netdev@vger.kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Gal Pressman
	<gal@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>, Simon Horman
	<horms@kernel.org>, Cosmin Ratiu <cratiu@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>
Subject: [PATCH net-next V2 5/6] net/mlx5: hw counters: Don't maintain a counter count
Date: Tue, 1 Oct 2024 13:37:08 +0300
Message-ID: <20241001103709.58127-6-tariqt@nvidia.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20241001103709.58127-1-tariqt@nvidia.com>
References: <20241001103709.58127-1-tariqt@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CD:EE_|MW4PR12MB7264:EE_
X-MS-Office365-Filtering-Correlation-Id: 327a934f-0338-47b4-ce32-08dce2051fdd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nVofaiySbFObn85frBroEa90ZzhTTPIi1F+Ca/d25sIpGtccIL3LWz8bm8Rj?=
 =?us-ascii?Q?PyyfpxMOiMFq6asfasHxHtT2FUifOqbF5OtZk+toYX/bVL+MtJ925W50PECM?=
 =?us-ascii?Q?muO4Om+YqusMOrNc/USifS1Netz1flkQB4O5tDRu+OL8RnmJ/yPqB3gCtdTZ?=
 =?us-ascii?Q?9QdF1aOjNXyRny8+m3clqMZqs8SwkcW0RW8SaAYYplyLnsKwXGNLR8To8SZf?=
 =?us-ascii?Q?BVhVoa1MTMIhQ3y4l3oBQocs4SN9P/W0fsgSTuXb73vBQK7gbISI7DVyTOfj?=
 =?us-ascii?Q?WiJ/IfkmHzVNjf3RE18CMNcVPqODcDFTsLB3ftmquwjhqT2xuGwKw8WbDkfm?=
 =?us-ascii?Q?A0/3HXrshr6HvP2eaeTs6YWqo6szfPQucoyqbXe6XrNLAcXRpyHMkEJ9R5AE?=
 =?us-ascii?Q?zrgPfmSU93sYAyFK1sfDh2pJHPmDrFrVYHngligtziF3BmlENd6f18yWtFH3?=
 =?us-ascii?Q?GAuk32Fintk9kfQ/HAGIH84RfaZc5iMSXoADF0F1R+OU9k3vmc7wcf9DCa2M?=
 =?us-ascii?Q?6lSLUuAnO39M7IPRLFcbxV7cKf18Tj3fM5smIsRne1ZEmG6uxaFJ1+g9hstN?=
 =?us-ascii?Q?tc1zr5BLxH5tx0HkVlg5LXl/ZrcX7XpFilC3cvGIaU+ybYsgVAJiwtFfkvDz?=
 =?us-ascii?Q?U4Io015Se51JXlUu2DWt+gZt+zJEWm0av1hgOwa5tGZ9/LSnoHHrHtuync9r?=
 =?us-ascii?Q?hqIeUntW8o8gkk7Bq/6oCUdXMCN38gn1g2amUhXu2L5jxA7J2I6+/uC7IJNm?=
 =?us-ascii?Q?OEgvXU6AOa8bag8slvip4ALMW0k+666jY6gaLB87kLz7LE8RWld84lpWq/06?=
 =?us-ascii?Q?wrugw4WZn3Q9wCpG6Fu4WbxQkR4uA5e6AmFC/XblomnfatGAV7kPHLFB8cF1?=
 =?us-ascii?Q?vpaBgDdE+j7MzRAOr8x2qevnbXBC8hhBy8oanzhTCGi+qkJK+1BcKhZrpmIg?=
 =?us-ascii?Q?dH7nJMqkUwrCFeqzHOlNg3TVSlnmmzAXwVwIoyInWHuRuy9FquZT/PQq+2SU?=
 =?us-ascii?Q?jwTlKo+2g6iKZwSX19Im7vyWYrSoMpBfAJB5VTdFZnCu3w0mEzVtzsOd/ktC?=
 =?us-ascii?Q?edqJGZm8Pn6ZBDpmu0UeisTZjxWt+QCvExcHSOji5IkUcQgHyGRcH5SSDbAm?=
 =?us-ascii?Q?x4Q04zalYItGdYGC+YAACQ1d1oO9yMRJwnWdc1R9CrNyy71/rOOsgPaUWtNt?=
 =?us-ascii?Q?lMQSUKIrGsX1to78Vl/+3IIBgIZ6jb0Q9/uQz29lax+4ntweB9YVhBDdNfDl?=
 =?us-ascii?Q?ayEvCFbUuzHMQcpekEfZedKU5S03c5vn1W9DLzy70NglCQq53sJwA6B9pjht?=
 =?us-ascii?Q?u4zyZSS6odkY2ujuOlJkewK/idBTwV9bgdHmQDTZp1NTelxJGeHzWKUey26l?=
 =?us-ascii?Q?i5VJjX0tZrknS7bVsrR1m3GIJA7b2Sz+YE7xbnNmc0QiMOvcpg8WPALiL0Wp?=
 =?us-ascii?Q?ZE3w2mImqN4rrjMo6PdBPM7VtENEWdRp?=
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2024 10:38:01.6799
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 327a934f-0338-47b4-ce32-08dce2051fdd
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023CD.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7264

From: Cosmin Ratiu <cratiu@nvidia.com>

num_counters is only used for deciding whether to grow the bulk query
buffer, which is done once more counters than a small initial threshold
are present. After that, maintaining num_counters serves no purpose.

This commit replaces that with an actual xarray traversal to count the
counters. This appears expensive at first sight, but is only done when
the number of counters is less than the initial threshold (8) and only
once every sampling interval. Once the number of counters goes above the
threshold, the bulk query buffer is grown to max size and the xarray
traversal is never done again.

Signed-off-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Tariq Toukan <tariqt@nvidia.com>
---
 .../ethernet/mellanox/mlx5/core/fs_counters.c | 40 +++++++++----------
 1 file changed, 18 insertions(+), 22 deletions(-)

diff --git a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
index ef13941e55c2..0b80c33cba5f 100644
--- a/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
+++ b/drivers/net/ethernet/mellanox/mlx5/core/fs_counters.c
@@ -78,7 +78,6 @@ struct mlx5_fc_stats {
 	unsigned long sampling_interval; /* jiffies */
 	u32 *bulk_query_out;
 	int bulk_query_len;
-	size_t num_counters;  /* Also protected by xarray->xa_lock. */
 	bool bulk_query_alloc_failed;
 	unsigned long next_bulk_query_alloc;
 	struct mlx5_fc_pool fc_pool;
@@ -217,21 +216,28 @@ static void mlx5_fc_stats_bulk_query_buf_realloc(struct mlx5_core_dev *dev,
 		       bulk_query_len);
 }
 
+static int mlx5_fc_num_counters(struct mlx5_fc_stats *fc_stats)
+{
+	struct mlx5_fc *counter;
+	int num_counters = 0;
+	unsigned long id;
+
+	xa_for_each(&fc_stats->counters, id, counter)
+		num_counters++;
+	return num_counters;
+}
+
 static void mlx5_fc_stats_work(struct work_struct *work)
 {
 	struct mlx5_fc_stats *fc_stats = container_of(work, struct mlx5_fc_stats,
 						      work.work);
 	struct mlx5_core_dev *dev = fc_stats->fc_pool.dev;
-	int num_counters;
 
 	queue_delayed_work(fc_stats->wq, &fc_stats->work, fc_stats->sampling_interval);
 
-	/* num_counters is only needed for determining whether to increase the buffer. */
-	xa_lock(&fc_stats->counters);
-	num_counters = fc_stats->num_counters;
-	xa_unlock(&fc_stats->counters);
-	if (fc_stats->bulk_query_len < get_max_bulk_query_len(dev) &&
-	    num_counters > get_init_bulk_query_len(dev))
+	/* Grow the bulk query buffer to max if not maxed and enough counters are present. */
+	if (unlikely(fc_stats->bulk_query_len < get_max_bulk_query_len(dev) &&
+		     mlx5_fc_num_counters(fc_stats) > get_init_bulk_query_len(dev)))
 		mlx5_fc_stats_bulk_query_buf_realloc(dev, get_max_bulk_query_len(dev));
 
 	mlx5_fc_stats_query_all_counters(dev);
@@ -287,15 +293,9 @@ struct mlx5_fc *mlx5_fc_create_ex(struct mlx5_core_dev *dev, bool aging)
 		counter->lastbytes = counter->cache.bytes;
 		counter->lastpackets = counter->cache.packets;
 
-		xa_lock(&fc_stats->counters);
-
-		err = xa_err(__xa_store(&fc_stats->counters, id, counter, GFP_KERNEL));
-		if (err != 0) {
-			xa_unlock(&fc_stats->counters);
+		err = xa_err(xa_store(&fc_stats->counters, id, counter, GFP_KERNEL));
+		if (err != 0)
 			goto err_out_alloc;
-		}
-		fc_stats->num_counters++;
-		xa_unlock(&fc_stats->counters);
 	}
 
 	return counter;
@@ -324,12 +324,8 @@ void mlx5_fc_destroy(struct mlx5_core_dev *dev, struct mlx5_fc *counter)
 	if (!counter)
 		return;
 
-	if (counter->aging) {
-		xa_lock(&fc_stats->counters);
-		fc_stats->num_counters--;
-		__xa_erase(&fc_stats->counters, counter->id);
-		xa_unlock(&fc_stats->counters);
-	}
+	if (counter->aging)
+		xa_erase(&fc_stats->counters, counter->id);
 	mlx5_fc_release(dev, counter);
 }
 EXPORT_SYMBOL(mlx5_fc_destroy);
-- 
2.44.0



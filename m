Return-Path: <netdev+bounces-77225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7668870BE1
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:52:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 173D31C20D5E
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 20:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301C2101FA;
	Mon,  4 Mar 2024 20:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="FfOQUNqA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2068.outbound.protection.outlook.com [40.107.244.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96AACE54D
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 20:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585557; cv=fail; b=odIdeeqANfcldg34PyIrzDbz7SXIZAV9fRheU8V5MvtHYPzsM4ABglksF6Pfite6scJA0vUlZWgJ2hhFtQGAfgmxNNQYBdb/51YB1pPPctXuZM50nTXFwI0XFBxvJ/zJT/279LaNuQ/9snnCFRcWEn78DXbkytEOuHXsRRlLOhc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585557; c=relaxed/simple;
	bh=hs1b5NN6gANbDd8xHOzS3g8RgH20v5KiXmMpoBAZEV4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZlAaKgtfqU+dyFM+p4VIqzOKG0tSIKx7s+iZNucUYnNaJF3Vm4rXFSQa2Vix/VkLw6YLPXdLBy7kbfABet8W9lSqnTXl/8oMPIrofuxqnWPGukR3N36pN7wB7hIz2g6IfKxwNfgcHyIQltqFOGnMR4kJrjrX7yVIxRi0uzdpiQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=FfOQUNqA; arc=fail smtp.client-ip=40.107.244.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aSUBLDiX0LWXqDDk0SjYJoWKaX0vqrAd9Wzq+nd9UUng/QlFUIICWkjCF1g9bjQq8R509KZ1PPLUI8z7x2zgErCbKIJhDicdQqUoVlBnXxPQmx2pN97IW7DTlfvqQTJyy4cFw0lzr4h94WNzrW5rOsUxW/zRM1tFz80nKdNaRZmouoe6lcUA+UXaA8QHqjmGpCieDfMg9FEcN2gtM7LG2vDHILjr3Qm3sY2gFXMvNhnE6aFJnuMNrHFlZdZXycAc3wSU5Ta9G1NL+2J8zJnf6dBuk0txcU1Cx93Ady9wZIjRH0z6YgLYTTo8SoBBuNWp+uQDStCjccrVbB2S7gvpBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aFQC7Xfxcx1JxmvXv/62NNWug6jyA9fPBDoLD6NFe6o=;
 b=MTqrCp8tztwU3o1YdndnbNEipGmEZTzNk3LaJ1fmPYHMrLHALBTsEH4Q5M19r8qvSYiqoP23C/GtgKPQ6XjcKvhXBrwZU5Xu1pdnt68ZDpndU18NvyKQqAbIgdOFqA4J3Sk2rUYISy1jGtY6LJPXQzsNIPIIYr+3DvNoFYaUGVEJewh+VjBXMcwHZMW7BXeaPa7KI4fGITIT27sd0QVkfVA/CDj9XbwqorApVr8r+we4yDuyGY8WNGBl3tgIXzbIB08X1ewGwZD9XJyqQROaiARFuDYa7/YdtzrckUOrnDgXciBqKJBJ4gWKiIE7Xaah1pK2mFz0PAtz8rt/9sNOSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aFQC7Xfxcx1JxmvXv/62NNWug6jyA9fPBDoLD6NFe6o=;
 b=FfOQUNqAgqhJ/mKNusC+FU0zrLu0nt4jxLxxAkCWDbpFfKCnyccp6S3TTRgTYpTD5NxKLlTq7dO+Ifz7vjax4Ut/cfkph4kX3OHnhscfGbTYDUpHbbbvcN3Y2tmmVStB93Yf0Ga2WcqYnwSoCDeqwUYrK4yCAYxy42tNF2UC/s0BsizYkMCvLJ6go02DTjwL0wWNKSRatdU51+r1edvO1A9ZV5ri8TXeh51oJRft43W2q8ltxfWqrD3Htlw0DS0d0AlxFoB6ThMosIsYVV+5SF8Rytz4jksyB7GQArcPvX59JmXBiD4VUexeYU0PoHixrXKy7+jGXAQULKtv76HooQ==
Received: from MN2PR22CA0008.namprd22.prod.outlook.com (2603:10b6:208:238::13)
 by MW3PR12MB4476.namprd12.prod.outlook.com (2603:10b6:303:2d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39; Mon, 4 Mar
 2024 20:52:32 +0000
Received: from BL6PEPF0001AB78.namprd02.prod.outlook.com
 (2603:10b6:208:238:cafe::ed) by MN2PR22CA0008.outlook.office365.com
 (2603:10b6:208:238::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.39 via Frontend
 Transport; Mon, 4 Mar 2024 20:52:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB78.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 20:52:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 12:52:10 -0800
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 4 Mar
 2024 12:52:06 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v3 5/7] net: nexthop: Add hardware statistics notifications
Date: Mon, 4 Mar 2024 21:51:18 +0100
Message-ID: <c290f6ec434bf940c3cbeac7e0c43ec7b271608c.1709560395.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709560395.git.petrm@nvidia.com>
References: <cover.1709560395.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB78:EE_|MW3PR12MB4476:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c971465-e93d-4b77-5132-08dc3c8d031f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	riTvoT/Xvh8VjTkhy86aCjE+MsW/V04IkDN3t7a2xZPTwxBuM6w4Gh8UHLlo4PoVKt8RBO6XX9jwMxSjcIO8B7TUxwY4gBGxJE6x2ieUuANOGLMVATlbk2QqlVuf3U+zuGC3pmQ5OBjEUPG3ecXVfI5VXnseXvCYCI37VQTNYsKgVhSlnv97g09ykHzU/Ra4G67bR3ZUtj5DDnmrlPgiSMv3d1lKHDw1snKxI3NTpu3+o/fS57ZblM7JgLTFA8mi8iMvnRkA8BcQpHX4CQgaR5x/Y4ZPaFhKyoXU7YPRXjz+S+I4T+B6m2ag4Q/JCSIrjxRQdDdPGodEGEUKqjlCM1ZnwLHWsd9G0WrL8Z0WDDasdyPUpoYxILvKTtA1XCWmHbOxuGeg5/T/rjR4JoCijFEb1+sHen6/MhV289lGjZaqv/zyv//m46ZqNF9RmXjmGRA0IJ4BNHahaeyvncPpXE2EMIHSlXiRx2IjHCzwGLYkFAYipkUsgSkO5KuMPuK/SoNiMQOeK7odbHIcoqIbWNohUKzY+Q5qub4CBdT9TEgTuaTUEQ7fUb3C5C4qJtLBnFVvmGUXC1CAJh0PrVYbMkHIgnxzmmSAblU7Ac1tawA3lhKH7IY6mvVna9Xi2KKEitZ1EkWW6eRVWKeszYnuT+yJV/8YbyOKpN9ebMTL2jOGgfh2TmDi6XRuJ6keMnhBG6EirkjttHW8WOQxxBwYperO5XvGRrTaQ1NLjFh2URpgMANwT7jL2BiPwNxO1PmD
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:52:31.8175
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c971465-e93d-4b77-5132-08dc3c8d031f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB78.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4476

From: Ido Schimmel <idosch@nvidia.com>

Add hw_stats field to several notifier structures to communicate to the
drivers that HW statistics should be configured for nexthops within a given
group.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 include/net/nexthop.h | 3 +++
 net/ipv4/nexthop.c    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 6e6a36fee51e..584c37120c20 100644
--- a/include/net/nexthop.h
+++ b/include/net/nexthop.h
@@ -130,6 +130,7 @@ struct nh_group {
 	bool			resilient;
 	bool			fdb_nh;
 	bool			has_v4;
+	bool			hw_stats;
 
 	struct nh_res_table __rcu *res_table;
 	struct nh_grp_entry	nh_entries[] __counted_by(num_nh);
@@ -193,6 +194,7 @@ struct nh_notifier_grp_entry_info {
 struct nh_notifier_grp_info {
 	u16 num_nh;
 	bool is_fdb;
+	bool hw_stats;
 	struct nh_notifier_grp_entry_info nh_entries[] __counted_by(num_nh);
 };
 
@@ -206,6 +208,7 @@ struct nh_notifier_res_bucket_info {
 
 struct nh_notifier_res_table_info {
 	u16 num_nh_buckets;
+	bool hw_stats;
 	struct nh_notifier_single_info nhs[] __counted_by(num_nh_buckets);
 };
 
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 68ba60a1bad9..22efb7d11179 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -141,6 +141,7 @@ static int nh_notifier_mpath_info_init(struct nh_notifier_info *info,
 
 	info->nh_grp->num_nh = num_nh;
 	info->nh_grp->is_fdb = nhg->fdb_nh;
+	info->nh_grp->hw_stats = nhg->hw_stats;
 
 	for (i = 0; i < num_nh; i++) {
 		struct nh_grp_entry *nhge = &nhg->nh_entries[i];
@@ -172,6 +173,7 @@ static int nh_notifier_res_table_info_init(struct nh_notifier_info *info,
 		return -ENOMEM;
 
 	info->nh_res_table->num_nh_buckets = num_nh_buckets;
+	info->nh_res_table->hw_stats = nhg->hw_stats;
 
 	for (i = 0; i < num_nh_buckets; i++) {
 		struct nh_res_bucket *bucket = &res_table->nh_buckets[i];
-- 
2.43.0



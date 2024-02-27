Return-Path: <netdev+bounces-75440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0144B869EF4
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 19:22:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FE01F23F4D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 18:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E159B14AD3A;
	Tue, 27 Feb 2024 18:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="TDeQYAYh"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2056.outbound.protection.outlook.com [40.107.243.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1749914AD1E
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 18:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709057910; cv=fail; b=JNe+6Fq8JoU4t3kPbMoovQ6Elz0/XS/KeTY0llsRQsOWP3G4qBvqB0SGTIIYsrg3ujOK7YIdzBb9eMlNmlWQGGNF2gbcbrvQ6mFwSn53Sjd4YxdY6WfDHsty/9gkl66THCD8ygtJGrGOaVR+wQG64g0DMHHXRbbfZIwho17Q4m0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709057910; c=relaxed/simple;
	bh=wAfcksJakYsQvFpa7+LTWKCV68jyYaJA0QvKQp7uVRA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pQwnl3HHTX1IRIBEnjpdThGlu8Ui629+LD+xAZJv4W+3VU5wuUGMXnDc58nD4yBSd8wkvPEXd7yBy1fRZ4vFg2b6OqXgEUdWRhq54DGhpV1M4z0xpHY2dZO286omyfdRehuZBp0dwT3NNKqI5wlkEIp6mEZkQ87L/8BiVRkF/rY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=TDeQYAYh; arc=fail smtp.client-ip=40.107.243.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iX/mR2WyXpcWxBQ4lf7o5jH2MfUt4DQD/8RzJA15jPTZo44IsM+YbvXKL20oyopdl0kpU/JDioDHJfBr600SAzqpiDxOm2g72vojRuM9H1VgZBQJisk57835aDNzIMigzKLw4jg06vXtVkEg9XUG5WLUwOpbdR/o1XMSLdUFVnsN5z4/89ky5n7K5U/yxUmPbUuQajCXaPWlsQJQBGHKgmd8JoZ5i9RNCpWsFwxBBxzcfCSPC5i7EqK4vpUmByd5rQhMH1RZti3+KIJECAg9G6Q1uOqQT5MtDvHl3JWvntnVT7ylZKPz7IT+qi6dSMsZp36QjPsniK/gEEMUNIG7iA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cZR8LtrFBiQI+GnFDuSdsib3iklnV0zpPs5Gb5yWvwo=;
 b=GFOj/DYvIAMpzhqN9QqcPFXau9OHxWM2WYJj3WCgHCvmX7P7hO3OlRI0XDXKDE1E+1PFBNRnlO0N10+/VThmiIFppEZIuWKop8ryQdxlzliTzarLGQZYm4LJ+K0r+BFbD1tpccUUHS4JaJNjoJ4ob61IpTNgNW+8OhyijTWUA/GgQ6zIM4/z5oxbEf5OOdBbIvy/y6JfAAiCWnMQ0l0yPK56da1eWZR5Se8dXV9dTemuDVWkpn4VSyEjgD22Ra0IIjHQA0BkyBK7b01SRHR4Y2Oy3TGBHSL+/B9BAN+13328cx32ru/t3giP/rftkgCwf/GBdT+PsGIGOquvUjLdVg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cZR8LtrFBiQI+GnFDuSdsib3iklnV0zpPs5Gb5yWvwo=;
 b=TDeQYAYhyWqPZoRHDuscQJ0XCsrUc9C7e9orP3SDkC7npIcy9j0BG7nPmXGho3CCv9sKgh9snaHVN6RiFNzbWhhFTqK6XoSW42sroRtQ0+w2Zn9sKk2fKYCyu/lizCzTpS3VG/+SQrsxvYkTysJFPE2qLz5OKx/Hxl+dBe6VWMOE6fU2NU+gJp9lpR58Ad/UzwH+4l2JxOEWjtmNaU22loqDUKrNhqKYzWbovv9JQp1eLKyzhNBEuN/cShVz7l6Kfgg1SFvWAa7RostU7QOEs00S4SgooWivUSE6Bad53SsIlB3WvAr6ryF+CC3Gf6u9G2tMzHg7EGvVyOT0n8UqYg==
Received: from SA1P222CA0156.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::19)
 by SA3PR12MB9106.namprd12.prod.outlook.com (2603:10b6:806:37e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 18:18:26 +0000
Received: from SN1PEPF0002BA4D.namprd03.prod.outlook.com
 (2603:10b6:806:3c3:cafe::a) by SA1P222CA0156.outlook.office365.com
 (2603:10b6:806:3c3::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.49 via Frontend
 Transport; Tue, 27 Feb 2024 18:18:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA4D.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Tue, 27 Feb 2024 18:18:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Tue, 27 Feb
 2024 10:18:08 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Tue, 27 Feb
 2024 10:18:02 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, <mlxsw@nvidia.com>
Subject: [PATCH net-next 5/7] net: nexthop: Add hardware statistics notifications
Date: Tue, 27 Feb 2024 19:17:30 +0100
Message-ID: <26df18fdd78e2110bebca9e17e8ee0d2bb3f2bf2.1709057158.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709057158.git.petrm@nvidia.com>
References: <cover.1709057158.git.petrm@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA4D:EE_|SA3PR12MB9106:EE_
X-MS-Office365-Filtering-Correlation-Id: 27b2a63a-fff4-444e-3e34-08dc37c07d83
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	7R6frELm71Z5ypAnvN1Sl5kFbxJHiEgp144jQa+RNxG+snUuX1xG69CbJZJEUIXuSKsHxl7IUxUi7sQggCUU4rBkR8GRf2pVkqnsPWkR3zNJ9QSwqzafJI8+x0NL8/rLXwUvj4cAqRklYvl9/qV7rIpbku7W17jX8HiQppjhrsxSecTTRyL8G9QzjnqmegKYfIQoixp8uk/lszVlDwaZ1klnh/hgxJ66c1JplPmPmCj1Xogn4KXwoIEh4aAtns0F3dqmJvCwdTwx78w23GBYmHqQ9+p5+uVzl/ZOuFrPk5KrcjwzoWlRgUgFFunuYx5BglTTD56JV0X7jNDiHUdRDU/lekUkg4IlLPI+hGXgHS34+AUkSt4yAbHNkpO0hcdpla7RCpyxxp0sygk1+IkpGYlxxDEzKXQfWxYdrpNwbi746kJWoICroKutWUAJvVh6iMTdwr/CLK5ACaA0xYhdje1rfksWMEb+oaXXmkiiiQcaHG+J/vgpmFnm8VUU7uGlNLfDMHCZi7PRvOw1rB7S3JnFtet2StACTRww0M0/9I085ezw1OIv/4QBuVXUsfnM+xsBLkGKSv/u5dG/NDOfNEt4GNyBcxIzRwbANoqgQz4GRw35LrNQvTSrSmfSbbafRl+kgFqkZQgnNOwNud6ebQLy1dmmUC8sj4qYJJqXNXG1Yvq2qc9x7lvwWewubAkstpgwJkAYQm6nNgajOIKRW03Jzjeppkcba0oL/WM6X+SZsm08g8lcf7/VBO6UErGB
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 18:18:25.5956
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 27b2a63a-fff4-444e-3e34-08dc37c07d83
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA4D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9106

From: Ido Schimmel <idosch@nvidia.com>

Add hw_stats field to several notifier structures to communicate to the
drivers that HW statistics should be configured for nexthops within a given
group.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 include/net/nexthop.h | 3 +++
 net/ipv4/nexthop.c    | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/include/net/nexthop.h b/include/net/nexthop.h
index 4bf1875445d8..a8dad8f48ca8 100644
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
index 9c7ec9f15f55..0e983be431d6 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -137,6 +137,7 @@ static int nh_notifier_mpath_info_init(struct nh_notifier_info *info,
 
 	info->nh_grp->num_nh = num_nh;
 	info->nh_grp->is_fdb = nhg->fdb_nh;
+	info->nh_grp->hw_stats = nhg->hw_stats;
 
 	for (i = 0; i < num_nh; i++) {
 		struct nh_grp_entry *nhge = &nhg->nh_entries[i];
@@ -168,6 +169,7 @@ static int nh_notifier_res_table_info_init(struct nh_notifier_info *info,
 		return -ENOMEM;
 
 	info->nh_res_table->num_nh_buckets = num_nh_buckets;
+	info->nh_res_table->hw_stats = nhg->hw_stats;
 
 	for (i = 0; i < num_nh_buckets; i++) {
 		struct nh_res_bucket *bucket = &res_table->nh_buckets[i];
-- 
2.43.0



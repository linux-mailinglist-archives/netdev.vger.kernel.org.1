Return-Path: <netdev+bounces-76281-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5073886D1EE
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5167B22E4D
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6EA37A147;
	Thu, 29 Feb 2024 18:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="jFyoqesB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2063.outbound.protection.outlook.com [40.107.220.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E9567829C
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 18:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230835; cv=fail; b=Z2KmhEeaknzrCHpzVbNevlB2lF3fyy+EFmKhm1zNlQp49HCdj/D4zZJTXGiYg9XoQ8g7TNCMA1r/gEoVF5Z1+1MipVKc0ZfGekobN73l09TPALkk0MLNDpRxClvzTOIagjoJwH3IqmuPhds6DfXyX6gvlBOERUhUbIw6ArHdDgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230835; c=relaxed/simple;
	bh=oMol7ZPh4TW8ywgq6cE3aO78LQOn6yzeZWVfYU+71pg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VGcZuFOjAku5DJ6qioyD29sug+Cy7Pg4JgD/hWEfO6rEP/9eVDmyv9EaEH//ThBw3fqGj7Q1u9PZnQySdcK9U6B0PSkslxsCeb30Q3puvqRThkDE8eFy98E5qIhjMw6CgsPdKquqKXy+CwPkuTc5I5Kmobf5eZHbbIkmdSSoT0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=jFyoqesB; arc=fail smtp.client-ip=40.107.220.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SnOxUNOUB/8iytRX3p3TqxxsiF7X9Fbbx3HZtIMLelqBBz1aN5x4aMbWif/qO+xHL6mu7NMcrXCL7ia8QQ9A8l1sY45C9z0u5yU2vUqlEEJ5uzR1u9hjwveCwx1FSquyu/r+6cuAE9Ohu8J+FhXxbAZG3zpCnfYU7MIAMGVh9+f/D9k/p7OMLvcGBSC4N4hCYhmKz7AzLvswMqw5/1QXBC3WFR+Lplbyen2Van6yV9mBEKuTMX3PEQgo8ziNC7mcDKLDJAjmcvq4Rpf/MxB5F9dIObW5cxNvnB0TWiKXCbrstDWpS1o7Ij/wka1zPoxX3J8aVR6mjACDwe5QZpsewA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=497krsbvHFHYkp+FPPg+VoxQBPyND7HmcIpbBC3KGAM=;
 b=LPyGiBUPPplIz6UWrjt+OOhVwAI9ZliLXMhjOfyNcaUmZ/UyJ1jn/1UyY5DH6vjoX5XOYzqR3VcDfeKpBf9p0/SXEXjz1sR+NVN30d37oQXn4BI4QuRidT4gVL3UtWbNI9Jem0LC+5NCnwM9Z0x+q6OWTp2afYEQGPJUXQUjzCul62rrz8sEiXQejpbhwMzltE/3KgJo0pbytQV6tJgbCxIyaBoe7RBSlus8a9cQDzCc08ZP34Q/zyZREnopUl4+1a71luU8sqh95ai0fkkv2McRqRv6hd9FdQELsjfbybOAMAhw56CISBPRL6vdHk0c/zh88i8KqDbOryt7vE4RzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=497krsbvHFHYkp+FPPg+VoxQBPyND7HmcIpbBC3KGAM=;
 b=jFyoqesBcf7nM1nq3tAe4KVvy262zMaAVZxSER8jDcbHPw+1UiTNHx5M/9rQ8/EQafU/fh6YkXdYaEgwIlyDAzkMuLb9J/EifU0iWnoQptIhT0DPc1m6kQEkh9kAYIGNbfvKdUlelhVkStBwezEvPf6ZMg8w+0mXuzOQ52DMikC/UauwDNqeP46DnzJ+ZLVa3AFyemCMYtofrPzVajUvzH9eepYEN+gKHFA6vAx22/AR8fWrnve59jMpHdmBhXlhDAaqkQO7nJk48zS3SsSkAnDDkwgBoHEquesDIu0HpLVpc1sKuGvoXPgxhRcSJSNQWYgjp+dPPd7Ej3AcY7IRuA==
Received: from BN9PR03CA0532.namprd03.prod.outlook.com (2603:10b6:408:131::27)
 by MN2PR12MB4110.namprd12.prod.outlook.com (2603:10b6:208:1dd::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Thu, 29 Feb
 2024 18:20:31 +0000
Received: from BN1PEPF0000468C.namprd05.prod.outlook.com
 (2603:10b6:408:131:cafe::a4) by BN9PR03CA0532.outlook.office365.com
 (2603:10b6:408:131::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.30 via Frontend
 Transport; Thu, 29 Feb 2024 18:20:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF0000468C.mail.protection.outlook.com (10.167.243.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 18:20:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 29 Feb
 2024 10:20:12 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 29 Feb
 2024 10:20:04 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 5/7] net: nexthop: Add hardware statistics notifications
Date: Thu, 29 Feb 2024 19:16:38 +0100
Message-ID: <91689768570fd58a973e1be388d2ebdc62438d29.1709217658.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709217658.git.petrm@nvidia.com>
References: <cover.1709217658.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468C:EE_|MN2PR12MB4110:EE_
X-MS-Office365-Filtering-Correlation-Id: d130a44d-8aaa-49d4-5137-08dc39531c99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	6yMQvkrg7ZaV9AkYHndkKa6bgAC/EQVNbg1yB3BB74fDzCQUfopu+JvHCD4hEL2HfHpMDRYQOCNQ4s5vGyE7ueDkAwxAGVAgvqpJbKaU8TBBRDuF60MhvT3z5zpUrZ8rcfqLFNyubDKt9Ym3k39F2J1Of2KJh9MvoyjUkQd4RGePXpFGxwpNRcif/ZF4fjxW2P0I4h9gOJmdYL+aVdFAnDA1lzyN+Ks2I0s/g62iCMi7Hw9WRTxJkBucyVsC07YjLintaWyHwUuia8ZKMbfIrlUGx4Hw3yDoNQsfxpJiiBBQ5IkYuj2tUzkFZgHYT5M6Cb4HkDXAPNrbTCTLvxENs43kCgSZKuSOtorswebVfhC3rwTBYPH83jGS//nIZXAZHOHplPjyujLeROAK2dsFjdoAI31XxDcSBiqCYrMmvMsvGHZY2PqJb3wfyWbqckhmbR5Whz31yomYVsUjKGwjzYSmi6tGxqE8BuC1nkVxEDL7h9Evt+xpZbYK4BgF06SqSoaobn8jvJGFKZ49l3k5isVNfeETpv1ZEwGVOmx8lAAFqb1oBeOO6YVIsejJ/oqcjh4IdyhEdB3bEjVYOn2MiP7v3rCq5qw0UP9Y2sZh/Cab3ib9oWfQgDtlzwKiCENUKXl87UqYCIzsILg2PQ6Aba0bwGIpII2kHcC8fmPwy2edX/Fclp8n10trI5/43WT+SUGj4znIjRqUHHdPmfL+qJP4y1pmHxccaNhhdzoAGx94fJz/hp8dlwfr4PYPeBx/
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 18:20:30.2458
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d130a44d-8aaa-49d4-5137-08dc39531c99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468C.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4110

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
index 0ede8777bd66..02629ba7a75d 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -139,6 +139,7 @@ static int nh_notifier_mpath_info_init(struct nh_notifier_info *info,
 
 	info->nh_grp->num_nh = num_nh;
 	info->nh_grp->is_fdb = nhg->fdb_nh;
+	info->nh_grp->hw_stats = nhg->hw_stats;
 
 	for (i = 0; i < num_nh; i++) {
 		struct nh_grp_entry *nhge = &nhg->nh_entries[i];
@@ -170,6 +171,7 @@ static int nh_notifier_res_table_info_init(struct nh_notifier_info *info,
 		return -ENOMEM;
 
 	info->nh_res_table->num_nh_buckets = num_nh_buckets;
+	info->nh_res_table->hw_stats = nhg->hw_stats;
 
 	for (i = 0; i < num_nh_buckets; i++) {
 		struct nh_res_bucket *bucket = &res_table->nh_buckets[i];
-- 
2.43.0



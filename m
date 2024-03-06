Return-Path: <netdev+bounces-77904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D98C8736E5
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 13:50:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19E7D1F22E7F
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 12:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3958986AE9;
	Wed,  6 Mar 2024 12:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="l/t3Yxut"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2053.outbound.protection.outlook.com [40.107.244.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8105C604A7
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 12:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709729455; cv=fail; b=K/lxJRubUXdUVLWfFFqK3WD8Oe7VnvFRXxFQsSeke7GAGIz9MEMpUnksfrQryNM+sN3IpciJUiAuqYHEwjDZXyCM34ntQaCfnOig1wdzbDRKpjeS8ROTpTFFed//1oLzqUHdpG4zyaFOQmN5OduVxxqlbv+UKsyq5IqE/QObfXg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709729455; c=relaxed/simple;
	bh=9SkaErDpWDYqsZMglQl0Kda5QemHo8mRnHiqxYteHBc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kGXMvta1HFJlqOiraJlAh5ZtZgKGYXNSk53ZVTnQok6DssZl0OP91n/AwGu9CXHY8sZnajN+JiFjEel6GUJwMawrLRQh59DLlvaKr6M6N9XfGUijNqetqVUkrRQAtEwaSVYQS+q6DLOX62J13hqslue09I8A+JPrv8zFT7HQAHE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=l/t3Yxut; arc=fail smtp.client-ip=40.107.244.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DNR6B559xcED3ckWNDUoesqaocx8N/JfXeWKnH7jcRDBl4JRTGYW1YzD+5TkBxxNcV9tFxc33+KVIFOT6FRjQHg+NnhkfCIx4sVfSoZleyHVleBk1/2GxOD5bfZBxubMPZRkN6zGDFSwbdNunYDI1hRMPr1o61CxTbWPRI4VMyC032xkQYQXt8YK0mz0cu5uOERRze68lqDc4PsLO6kIGAOcKpJ7Z/EAJLJzM+1URCGTY6DCp2zLYah3abMboqrvLqo6x1Zh9MnTpjjcA5nb6YY+/u1bdlX5BexapbrA+aknAUl0EZYK4Blj1uBWPOo2b6S+0TfXI+yo/txO2sODBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nw+sJLXBem5bwAFtxWPhmXemlktfcLhpEH53vRfdOaI=;
 b=SvaelNN4rziufJJP5MvrK/NaaJ8FUSDqKhO2PaC0CuUhodLBJmBdx3co6OoevHKFbpo4pGDlQMUK3WxWJGNP/A84m8spCN9n26RIOX9oTdyNrXPI2kM7UXZziwL2ZFPJWL3cJxisS/4hN+hkBBe9bJ0UB1Kt/dT/NT3eqvqcH2TL1uN7cebuqX8jTdXw5D34AIoomXc4pOMOumcjLMwMPpKm9WvMP5AZSyyNXDDUxVBvD/KZLBUW7FXPDpTk7h8ZcQyu1TZ7KkEuKl6dp/F4b3Frdqa8dTMPYqfkXl3wJHrNF3JT82qwR719YYDhy6aZq9zvI5/yvvy2mnvJrGiQUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nw+sJLXBem5bwAFtxWPhmXemlktfcLhpEH53vRfdOaI=;
 b=l/t3YxutlZ6rErQvbqtwSdGIv/C4KSTrHHpx05EQ5bxPkqsR9ZlyMR13iE9y0EpgMugHdwunEMkxzybqTkrjMl2LX1VFNFLGAMqJ3HrbdOoN+33uu3wxnol+AM5NgR6aVb0dYejI7IZDIArjNTnopcflkoAW2LFrOsmp67W2aRwKet0RKS85rCHwXeJERmnN67dJexnmP4Untt6t9TqfNXGxbqvzDHvWKEWFmt0BA1FeoYrYpSEJ/jo+zXo+UK1p0O/f5osTUya99O+xLhoQHqvR9Nd8ipx/QrZhlBTSP0vGCihuuIOyH56zK50Oub0BfXuMzU+KFniNGxpN8lBEbw==
Received: from SA9PR13CA0179.namprd13.prod.outlook.com (2603:10b6:806:28::34)
 by CH3PR12MB8912.namprd12.prod.outlook.com (2603:10b6:610:169::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 12:50:51 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:28:cafe::c5) by SA9PR13CA0179.outlook.office365.com
 (2603:10b6:806:28::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.26 via Frontend
 Transport; Wed, 6 Mar 2024 12:50:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Wed, 6 Mar 2024 12:50:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Wed, 6 Mar 2024
 04:50:29 -0800
Received: from yaviefel.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Wed, 6 Mar
 2024 04:50:24 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v4 5/7] net: nexthop: Add hardware statistics notifications
Date: Wed, 6 Mar 2024 13:49:19 +0100
Message-ID: <de53c114bb80a998b6ecac76f57c9c9106b4b5a4.1709727981.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <cover.1709727981.git.petrm@nvidia.com>
References: <cover.1709727981.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|CH3PR12MB8912:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e428847-6807-4553-bb0c-08dc3ddc0d6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	nLHooKKdJejg0E4vV+bVOtrDWOETHjQW6IC1vvg3A9rSnHCsQNZaGLP/PQtpPzZZzvwSDpiPl+Kk6ac1bgki1wcY5ebFtpwfxW/SiIsFcTkaQq8bEpLGIysrDklolzV5i/ogKlrgnzseOsq/gOiuipruhw3l7XuZ+0F4t2j9BIKI7C/x6gc6uCEn/Mw5ayag6/IgzcrT4aG8PG0G+FgD73TEzjMVJ3W3y8d0o76EadpRSwAUudvVB1B5ALNbLjHdYLfJOfVxqhG37hPc5rPzqGhmKVsr3/c3SYY/jtqj34pejVAezs9zKMNlAP7f/XkmwLYkn1pc+UpBSgS6ktS4tpjXSQF5RmRIx0IuMxuRCh6lPeYNRYvtkzYcCYbXGUvc12Gfii5GNLBq048BLIelvEK1KgQ+7uiFSENY+ehM/ty2g0kcaBZQD4i09hbuuZxtRHCIlFUbHgNw1AtTKfvSAfodNnJ6P3bGY0XR5JT/80OAK7Dc0LccgDVDVixrHatihUtgHr3DUMwjJJssOYri1acmIpZvyvWthkqsCZeeGFaLnAJtMj5tnwayOb/l1mhanSRPzWEiSq6HY5wt8t38igF5oWYB9BB+JFH4GWCXSMUv5WrVd4KFh/KRuXRsIemZRaLwYzAKT2T5oWjpycij4yJ14S662AKCSf6DkvzdhRHwvQo/AoeYYhZuhxlPaiTJDwc1w1YstPH6/owka5Xh0cNmZcKh4zsCjGSoRWdbaOwNjjKbnUFdpkCpCPiiIyx8
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(376005)(82310400014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 12:50:50.5781
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e428847-6807-4553-bb0c-08dc3ddc0d6b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8912

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
index 3365c41eee9a..c0d14e16e9c8 100644
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



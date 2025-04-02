Return-Path: <netdev+bounces-178770-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FB40A78D64
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 13:45:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E84D3B3CF5
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A2123875A;
	Wed,  2 Apr 2025 11:43:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="innOBg98"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2083.outbound.protection.outlook.com [40.107.94.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75F52238D2B
	for <netdev@vger.kernel.org>; Wed,  2 Apr 2025 11:43:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743594210; cv=fail; b=jwwFwK8UQygarQswWdrK03Oblo/UouTF5md82ox/eSGUIB7AVX05iZzE9vAIPNvM0VrEpt4OkoGvZYQuCpwyUQyX08bTUnBxoxT2oDp6/ggX+TmzentS+9Zq6CmWQdtJLDQ3eh1K69NzV1qHG47j7k/b0gYfziWYedWj7lSjix8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743594210; c=relaxed/simple;
	bh=CygDM79pUDXNWNF3CaOYB3RT8SMk3k8A5lhR1cf74AM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mbN9TpPyH9YkyhaaBY/rJZx9BkqEXQcvqLAaK++/ShKUYBPd2ibJDeafbortHHy7ai10xWsU4Ppr65L7r3wiCH0EvQjGHr4iThibC8EM/1bZIgg8GEC5YnI8xWIAHWqOpzFupkWY79t2xitsLhDcmJM6DZR/m71RavpRFL67GyE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=innOBg98; arc=fail smtp.client-ip=40.107.94.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JgAsbHGqTu3Dbn/0Z9yjUf8XI73Q1ehmEQmWi25mzCijdKUsnLnJdQwh8CxsSpZQfYd1SvLtdIO96nbI1ACdETfdCN2ukncN1D2VrzNT/NQEIoDeGoNJeb7WLu81DLh1FZLEv8wzoPh3+UoktyCp5acLc73vcKgyPzu76jiWPCUmqRZkDlW6vwkBH8YxxsSiIPzKPlpLRgKxI71RamVZ+orX6FH8s9pOMj4EUL2LOBobUaq6Mop2NYo9FjkoRHwypSD2oETQHlQFs8dnmahQr2g1XzfRke0K6/HItmam4M/BRa9SqxOlyn5AsFboTwfyNOKO3sWi5pKeDhoWY6l/Iw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eN3jmMqGQE2oyVnznPDwtJWc7QK7U+Qi1+P6MaEe6Wc=;
 b=kWpONvQ2xrcygdQqoSv0Bt/aKxX2PU4CtWt7hLz/oB+fRrjTyOyXsIcrRjdPUFbw6g1F8ivtnCwC2x/km3vwe4T+B2399tBriOSn4zum4sUZKQL0rFt3Hixehl1QV6tWSV8oYaOaTkaEgyp/AfpqRvuNWwOVIZMc4LwzGGulXlyd48xXY0Jf3MkzRYmDRv8TFm15UKcAy34e2O4fA3MNLyxJbpNHAobmpp0pdxMpAl9d0ZU+MKftCe4Ynk4jV5apMJLJpDFZoIdwx5AUXFu1wF17OnbGUbUJZn6W5fpHBolQ1OqqxsytkvPltDDw0RZDa0Cno1oSgtVxOT9IFkut1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eN3jmMqGQE2oyVnznPDwtJWc7QK7U+Qi1+P6MaEe6Wc=;
 b=innOBg98c+oUonrsac2QY4oZ5CNn80QyTla0ZHiIbKSGDGmH5jidPOu4K12/XgBSHmVmzuSYLz2gc/dGZsbW04jv3qnpuc8lWbGcGtXEsHWd7gCb5BEPTZzSsybg61DYqPMNRiv9g3avYc+VU6RgzryiU9sgCMSgAXljOXUDLjaeExDE4/CLrvSALUXvvz93tWafJ4hnudoG5iE5KhCdDyFScLRhibcx7PFU0/REY7gKNEeKANndWpocQa411WROrm2Z8//pALEPlhhTPwkXPBiXm3t2DZhFNpsZUh/4FwodHw4wO5LikCmCyB0IzlwJilb7rRF8k75+mhPk9ieijQ==
Received: from SN7PR04CA0089.namprd04.prod.outlook.com (2603:10b6:806:121::34)
 by SJ0PR12MB6710.namprd12.prod.outlook.com (2603:10b6:a03:44c::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.50; Wed, 2 Apr
 2025 11:43:23 +0000
Received: from SN1PEPF000397AF.namprd05.prod.outlook.com
 (2603:10b6:806:121:cafe::a4) by SN7PR04CA0089.outlook.office365.com
 (2603:10b6:806:121::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.54 via Frontend Transport; Wed,
 2 Apr 2025 11:43:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF000397AF.mail.protection.outlook.com (10.167.248.53) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8606.22 via Frontend Transport; Wed, 2 Apr 2025 11:43:23 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 2 Apr 2025
 04:43:05 -0700
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 2 Apr
 2025 04:43:02 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dsahern@kernel.org>, <horms@kernel.org>, <gnault@redhat.com>,
	<stfomichev@gmail.com>, Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net 2/2] ipv6: Do not consider link down nexthops in path selection
Date: Wed, 2 Apr 2025 14:42:24 +0300
Message-ID: <20250402114224.293392-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250402114224.293392-1-idosch@nvidia.com>
References: <20250402114224.293392-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397AF:EE_|SJ0PR12MB6710:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a64a9ba-6ced-4b0f-161c-08dd71db9334
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Zpzz5kxEHRucPHfnJpiZPOf6knylAQqdDqRtGH4O/1fTYl/AX3SZOXqDjdso?=
 =?us-ascii?Q?RWdKy7M0pknwmHzJVa8Y72/hOmyeMIl1eNzUQjZYtsV71il9BUdnAFsgNL0H?=
 =?us-ascii?Q?q8H0H+YvQ9bik34dRnGFoE4rHT1kXOg1MgDDk3OvIl1T0+Q+tl8AZn2s62r/?=
 =?us-ascii?Q?SY6hTjGFh/++fEMDoWJixgNOtkDLqOE0TnXVMcFQiM+ZOMqJ632x92Bonpq/?=
 =?us-ascii?Q?BZQZMN4rvMFKNdZmhtiebHTY2HoqVZcF0wSQob2jVBzK/ZITFkok0W/4i763?=
 =?us-ascii?Q?VdOcTlXyunU3ONXKv4SWcvthytiGdgeqlpMQo1lJtWLPSPO2phPC62ox3H6u?=
 =?us-ascii?Q?2xuFMNccfit9PEkxlTzaI82UpaKsTtP14Rc2gCOjGnDjnjWDnNUK/4zyiyL5?=
 =?us-ascii?Q?J4jEu5gXRiy7jHlkKT2uYHGUMxSuFjvrvPqkCswi8vYlGQNERbeEMdNtPVHN?=
 =?us-ascii?Q?l/VfdEZsfp6Myl4b2nET5JVaJvoH2yCNkS8yyix8jBQ2SXkZTJ/G6hw2WzsZ?=
 =?us-ascii?Q?iY/CGOSKmSpjOqyZPBOdr4Ll8Ogvb2o65Npuk1HhREka4WaWzsxSIBdSzGuX?=
 =?us-ascii?Q?oHIUaYI6TmTF4dEJKQFifO8xmHRI2fHnMU32nBp7lY/ED95WdwK7cPz2OOAj?=
 =?us-ascii?Q?PrcToLDijsVGfyUrWRhEJP4eIy7tCTBBxC1koK8GMu6NqgK4WR4xhfVN3vZc?=
 =?us-ascii?Q?cRGe5i8AHoaepUUqksrTxIaiUZlLxb/YHdC2Q5UNtvv9tpVFXYJTwCJNeKkj?=
 =?us-ascii?Q?mBwTW0x9zzOqtBFA4OWXbXqP1dg32drKhzaNcEX0T0wsF3hmN2PspAsQhQ6B?=
 =?us-ascii?Q?b9pBoZQnIhKRYziq4T/dedL0c+REG2sQJrBqbW1qpEkVPNXBxlaXwvMcL9ao?=
 =?us-ascii?Q?Q3hi2bctOv5Z5VScrZy6aH4A6g727sF712OwK0VIWdW4uSkCeRpDVT1KHXlk?=
 =?us-ascii?Q?UGALJWbnvFzO994m8KKtKplCCRzTa0q8x/WGodtOAhnCOOXVLW2mBX17GF5F?=
 =?us-ascii?Q?ffmFSS/TQlsr/7rznFORmb7hUIcmKhhmsMlR8JuDseL1qfm85oF/ER1HPUYk?=
 =?us-ascii?Q?CmzqY8BqEO2F65P3JPHSY3U7gke5fh8b/CHn/PfeMt0xNO0qLC3QXe/msg7Z?=
 =?us-ascii?Q?wFYin1jUgQNduB410OIQGK0YNZ3WTs39rzQk+ncX+I/X8LLKkO5pPtNySmuR?=
 =?us-ascii?Q?ulJKb0oo18zbSXUDuOZF5F4DLjekhigPaMDr0dl0BJ1qfXzJlcxd1lCDHwRY?=
 =?us-ascii?Q?R/7yLpt1wi6TMyr1HqDloB/QKFNnHeXl3WTFWnTGChgnc/qCMbxf44EgvDEq?=
 =?us-ascii?Q?XVFwhdeT7ga/kGt2H94ANqV5P4TqOb/+Sewx0iC9blPbGONQQrxFAVNoUE/a?=
 =?us-ascii?Q?592l68dqB04y6lCLyoVvcbcIVIWDTcy68CwUb3JkI3zkUVlCgICw6Tv+Y558?=
 =?us-ascii?Q?NbbLJknI/TssX5dcv+X7QcisuHjqe0SfCJYcEuGxnSOcyYsnovvjNKywVVTr?=
 =?us-ascii?Q?7E6yjMBFBi1DURk=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2025 11:43:23.6513
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a64a9ba-6ced-4b0f-161c-08dd71db9334
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397AF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6710

Nexthops whose link is down are not supposed to be considered during
path selection when the "ignore_routes_with_linkdown" sysctl is set.
This is done by assigning them a negative region boundary.

However, when comparing the computed hash (unsigned) with the region
boundary (signed), the negative region boundary is treated as unsigned,
resulting in incorrect nexthop selection.

Fix by treating the computed hash as signed. Note that the computed hash
is always in range of [0, 2^31 - 1].

Fixes: 3d709f69a3e7 ("ipv6: Use hash-threshold instead of modulo-N")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/route.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index 864f0002034b..ab12b816ab94 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -442,6 +442,7 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 {
 	struct fib6_info *first, *match = res->f6i;
 	struct fib6_info *sibling;
+	int hash;
 
 	if (!match->nh && (!match->fib6_nsiblings || have_oif_match))
 		goto out;
@@ -468,7 +469,8 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 	if (!first)
 		goto out;
 
-	if (fl6->mp_hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
+	hash = fl6->mp_hash;
+	if (hash <= atomic_read(&first->fib6_nh->fib_nh_upper_bound) &&
 	    rt6_score_route(first->fib6_nh, first->fib6_flags, oif,
 			    strict) >= 0) {
 		match = first;
@@ -481,7 +483,7 @@ void fib6_select_path(const struct net *net, struct fib6_result *res,
 		int nh_upper_bound;
 
 		nh_upper_bound = atomic_read(&nh->fib_nh_upper_bound);
-		if (fl6->mp_hash > nh_upper_bound)
+		if (hash > nh_upper_bound)
 			continue;
 		if (rt6_score_route(nh, sibling->fib6_flags, oif, strict) < 0)
 			break;
-- 
2.49.0



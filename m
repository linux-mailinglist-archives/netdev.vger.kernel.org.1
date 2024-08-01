Return-Path: <netdev+bounces-115074-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 05576945078
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 18:25:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 811311F237E3
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 16:25:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C01B1B372D;
	Thu,  1 Aug 2024 16:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="pw49L3lq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2049.outbound.protection.outlook.com [40.107.223.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68871B4C37
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722529505; cv=fail; b=rgpW2hnJlmVq0ari7k3kGCvy7eyjZCUl8qObKMPYbVqHbriJsgeF0WFpaeNvbk+eDcO4FGCLCvkqN5Y8G0osKbQP2080/RddK+JOCQ7XlrTezudSgv3bynsAaSoL1BvBWrdI87LpdLOzmnHWlyhysCjmeuYarkUwDulGCles+zQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722529505; c=relaxed/simple;
	bh=UP7+hzEsoGeIw3Z43MJJ1vGt4LvRwtbv1lOzaCtf7ec=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sf5kWk+2mBA5Sz6VGqgV1oCNWInkoFUOrjz/fAauCk8Hhg+4bjLx9CQ7VEMf8KLedJrXyvmMyIGkGnOU3YKKtsIIu3u4pGTDntiu84YBZjDmm6vzQz3JEM5EnjQN+aVd4Bkbwk8kvUyUqCBaaFjrkzzfzS0fRswBgLkevyg6Yq0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=pw49L3lq; arc=fail smtp.client-ip=40.107.223.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wH+rYDLc6a5QB7kOwURd5TFK4xSi7Lm0iYqaxobkST7vo4/BjWJ4bl72dnF9GMa1jMIqRU1/DdfjXKXIxHVYmVOB4EvVP57qdaR6YhCd13M3znbOXQ+EZjCE3dTPRQRYhtLJ6/tBHP4zk/QMyiJeQYnGtixAwrhazHyo+iZLJXJxAB3HCu4pxlqQY8seKNDTrYkTbcIApO0o2m+K0vGXDPO727TYpDdMhMeJy/v45fpCn0uxG212UzYqKfw+Xj7mKPAZbtZTO8brIdxmT0p5iLN0Pf6n/qH7725Mrddu7S7LsKLtIrnwlisbFhLbn8OB/raLuaKypkB7PRSTfcBoGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GWrhXmjwn2El5DrfBWqnQGgTP8kpW3yQcyluqLJVDu0=;
 b=okjfS3EMvu6WFS3ObzWTPUbxX+z2d3o4TKul4GnRN6VqnTx8Jx+tctRybECqXn/Oh8eyxjjEsWL/BCFJ+ieSw93ISRQpkvrubBozwgAbWo7YqlWrKt0uP0Fmv23I+PYMDN2mOkoQ604jmqSL1jtNVRetqclCrxwPqJxff3A6WxJei5bb70VWAZqHVGZ4VoaIly6G3/fggmMiDTnmDKUaY/3uBO72HGeGyJpU207qusH8ocgwqn4EFYrrc++aj1GATSATOfCYuxS7BzD2AVwL7dNipgDntPO1nB11NHQH8Zsj7GdaMhvgFm8aqhONPjBVojNZLxs7SIqaaE76T8f96w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GWrhXmjwn2El5DrfBWqnQGgTP8kpW3yQcyluqLJVDu0=;
 b=pw49L3lqLN/Z2EvhLitXb8W0QIIjvrk+GSifemaUzBTUZyRR93fTozlFCh87BzpCTMxtfe65unC9G6Qjj/vTyCtxcaTYDmxTGrSHpvhvffyXcv9h7hRRmhaAIBCe0XGBqnQ/9HyG62ZUZPNeB2dWHimgDmLY0iyFIkAOYYGBsLGGTVBw2I/1/hUS7sakYk1UUfrFgWw498ekmg64JN/fRJ9dGr/tZ4hcEss4fNkIRwjjW3I7fIomD/LCCBIDJaNNovIPy9/WpWu8Scs4V4/KWdNfvuM6r879HcgF75omN2J/Z7+dYSa5BtqIpkU1MBCd4vqFntQNmUWSgSdcZSbKMg==
Received: from SJ0PR13CA0092.namprd13.prod.outlook.com (2603:10b6:a03:2c5::7)
 by LV8PR12MB9269.namprd12.prod.outlook.com (2603:10b6:408:1fe::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.22; Thu, 1 Aug
 2024 16:24:59 +0000
Received: from SJ5PEPF000001E8.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::a) by SJ0PR13CA0092.outlook.office365.com
 (2603:10b6:a03:2c5::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.7 via Frontend
 Transport; Thu, 1 Aug 2024 16:24:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001E8.mail.protection.outlook.com (10.167.242.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7828.19 via Frontend Transport; Thu, 1 Aug 2024 16:24:58 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 09:24:42 -0700
Received: from fedora.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 1 Aug 2024
 09:24:37 -0700
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Donald Sharp <sharpd@nvidia.com>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next 1/6] net: nexthop: Add flag to assert that NHGRP reserved fields are zero
Date: Thu, 1 Aug 2024 18:23:57 +0200
Message-ID: <ba50a38cbf211cc98bdbebfda53226a1785f73e7.1722519021.git.petrm@nvidia.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <cover.1722519021.git.petrm@nvidia.com>
References: <cover.1722519021.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E8:EE_|LV8PR12MB9269:EE_
X-MS-Office365-Filtering-Correlation-Id: 31532ded-e89a-4af3-3920-08dcb2467ccf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jstTiUAb2RlSPviUDBdEF4GbRA0XVstLDrRs9Hqcl3+fC/tiYYzSdDR0d7Ek?=
 =?us-ascii?Q?XI+8qZtoSvZn0VcrAg/1TocANrdIXxfiytd/xdwHT6AZ9MODH/e8u1qMLB/N?=
 =?us-ascii?Q?HThtwGrH0Oos4GS+BEsIKIZTbAA3KZrxEkekW+Tn8JjQGK2pQdWd7ZQQ4tW5?=
 =?us-ascii?Q?Uq5z6r83fIbDtR0F+Tl4av3n0yXBeS8cWGVC6KVLQDtTi28N6ont6u36OcMB?=
 =?us-ascii?Q?7jy0NBz4FLBWQnkSk30Bde+snqxb/yWnmY6w7SSHg8TNwnFvePZU+pXRpPfW?=
 =?us-ascii?Q?Jm3v89K7PFKrGNYhNy7oiZLRh+BlJ+twSMsklwGHJoL0AXrutprxcBinuwTZ?=
 =?us-ascii?Q?eESO0hxqx8+RTe0ioozK7SKiCD7NhB/BWjK6xHbVRZkDJUk5Wy6GRRoa+QQv?=
 =?us-ascii?Q?J6v++lTz90VV7Tlq3w1x/s8WD4n8/O2rVTGUeWIXCsEuKWScnY8KYc5IkTPM?=
 =?us-ascii?Q?/L28BcoTl68POxCiDVM0+ipJv6u4TA5pSeuEsdcWCnz1yfacrTTVbovr4UIr?=
 =?us-ascii?Q?EBL1QSH2lOchGCtTPEp2BduAD940MDOlojkCykPDalQqYFibPYC9u32LZtr/?=
 =?us-ascii?Q?/GT2wQladD+aUAdgC5XpWUdzJY76lVl3+g4gNhQS0xMrWw/+Y0JVf0YrEoE1?=
 =?us-ascii?Q?FJ6jw8G1L8oeblLHDOgbVCLrY8L6RVOdGaRrAp47mkhCr4MXquna7KgZRQo6?=
 =?us-ascii?Q?NZMbhW1bixTNsBfrJLqsLVt33Sc0CZNlNy74dP/Op11xkEAjHhS7ERU9ysIZ?=
 =?us-ascii?Q?8XNdwAMoL/TrBVyjDHaDRljRFHqgJf4Q++tmKM5aquKkyRI36Kyt4Zspg46Q?=
 =?us-ascii?Q?UZgd3OEdZ7jppBzsXaRdM1+sDAfdDo6dttXzOyO8uOQguvvsvBMity4BbF+J?=
 =?us-ascii?Q?KSA2pyhldr9F/Yz5w5THiiiZAIXyiZoN5ZaWpuAmghNvJu7g0mXvckYqmIz9?=
 =?us-ascii?Q?CfqfYgDIKJhdbQozzBArp/0un6GsoTsHUWfVfc96U1bTYu5WJ4RIPlSRWa6G?=
 =?us-ascii?Q?sI0CFUYGSmC6Uq5rsHzTcgJGmzyfGQmCfK3S1moQ9yISgjsYcJ2IIUPmbWoL?=
 =?us-ascii?Q?3WxkhnL/12aD2MJ2ACbqi1HqSrQh/Alfjqwa+LYOntacG3NI8tB/FiiruMUI?=
 =?us-ascii?Q?OK3fjVEr+GaQa1+Ig0DSI3W5QVKiI9lq5XAqiKv6+nZxTt4IgZNmtIzVoKj4?=
 =?us-ascii?Q?oWV34lVRVZfYOnD7AQQlsD45u4mdLzgeRe5BIS2gjcSSMpoyQ8+c1mmXzU+y?=
 =?us-ascii?Q?VdTE+EgYX4pa3MXejZ+/DrarlOyTatjCztqjILU+BRiDBskottxDi6928k8g?=
 =?us-ascii?Q?juzWCbPYbRUAwFrW6YrlQ7sNwIDUCw6spvKyUi8aBHsPBBfK43+VHoLScTI4?=
 =?us-ascii?Q?pTaHhRvb/UXTzIPyg4ZZCjcVxRxkTWvp90VZTT2K82HvbAIBv6oyFeyrQCfW?=
 =?us-ascii?Q?E4TNpcWaR8enUdMzcuVJDX8MxTOsKVFF?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Aug 2024 16:24:58.9927
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 31532ded-e89a-4af3-3920-08dcb2467ccf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9269

There are many unpatched kernel versions out there that do not initialize
the reserved fields of struct nexthop_grp. The issue with that is that if
those fields were to be used for some end (i.e. stop being reserved), old
kernels would still keep sending random data through the field, and a new
userspace could not rely on the value.

In this patch, use the existing NHA_OP_FLAGS, which is currently inbound
only, to carry flags back to the userspace. Add a flag to indicate that the
reserved fields in struct nexthop_grp are zeroed before dumping. This is
reliant on the actual fix from commit 6d745cd0e972 ("net: nexthop:
Initialize all fields in dumped nexthops").

Signed-off-by: Petr Machata <petrm@nvidia.com>
Reviewed-by: Ido Schimmel <idosch@nvidia.com>
---
 include/uapi/linux/nexthop.h |  3 +++
 net/ipv4/nexthop.c           | 12 +++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
index dd8787f9cf39..2ed643207847 100644
--- a/include/uapi/linux/nexthop.h
+++ b/include/uapi/linux/nexthop.h
@@ -33,6 +33,9 @@ enum {
 #define NHA_OP_FLAG_DUMP_STATS		BIT(0)
 #define NHA_OP_FLAG_DUMP_HW_STATS	BIT(1)
 
+/* Response OP_FLAGS. */
+#define NHA_OP_FLAG_RESP_GRP_RESVD_0	BIT(0)
+
 enum {
 	NHA_UNSPEC,
 	NHA_ID,		/* u32; id for nexthop. id == 0 means auto-assign */
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 6b9787ee8601..23caa13bf24d 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -865,7 +865,7 @@ static int nla_put_nh_group_stats(struct sk_buff *skb, struct nexthop *nh,
 }
 
 static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
-			    u32 op_flags)
+			    u32 op_flags, u32 *resp_op_flags)
 {
 	struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
 	struct nexthop_grp *p;
@@ -874,6 +874,8 @@ static int nla_put_nh_group(struct sk_buff *skb, struct nexthop *nh,
 	u16 group_type = 0;
 	int i;
 
+	*resp_op_flags |= NHA_OP_FLAG_RESP_GRP_RESVD_0;
+
 	if (nhg->hash_threshold)
 		group_type = NEXTHOP_GRP_TYPE_MPATH;
 	else if (nhg->resilient)
@@ -934,10 +936,12 @@ static int nh_fill_node(struct sk_buff *skb, struct nexthop *nh,
 
 	if (nh->is_group) {
 		struct nh_group *nhg = rtnl_dereference(nh->nh_grp);
+		u32 resp_op_flags = 0;
 
 		if (nhg->fdb_nh && nla_put_flag(skb, NHA_FDB))
 			goto nla_put_failure;
-		if (nla_put_nh_group(skb, nh, op_flags))
+		if (nla_put_nh_group(skb, nh, op_flags, &resp_op_flags) ||
+		    nla_put_u32(skb, NHA_OP_FLAGS, resp_op_flags))
 			goto nla_put_failure;
 		goto out;
 	}
@@ -1050,7 +1054,9 @@ static size_t nh_nlmsg_size(struct nexthop *nh)
 	sz += nla_total_size(4); /* NHA_ID */
 
 	if (nh->is_group)
-		sz += nh_nlmsg_size_grp(nh);
+		sz += nh_nlmsg_size_grp(nh) +
+		      nla_total_size(4) +	/* NHA_OP_FLAGS */
+		      0;
 	else
 		sz += nh_nlmsg_size_single(nh);
 
-- 
2.45.0



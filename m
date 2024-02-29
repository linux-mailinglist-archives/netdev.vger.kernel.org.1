Return-Path: <netdev+bounces-76277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 384E386D1E9
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E04F01F2261D
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 297E47829C;
	Thu, 29 Feb 2024 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="aIp8EZs4"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2059.outbound.protection.outlook.com [40.107.94.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74FB670AD9
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 18:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230818; cv=fail; b=kXm+RYn09JF9cjvAJd46NPNYPAzuR/JPmB6x99+hLwFRJ1rUL4eg4fHmAOrD6C4Rcs7N4yMMhAWEDfa1eQrVh4B7qVo+GI5dxQGhu5XH4mgxo/lnz0ryi7Hj8XybWKxXRo+EXlsqa/1elscLJM7JXTusSsCN5o2+q3jsj6ivLUM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230818; c=relaxed/simple;
	bh=w4MhmrSRMwWDJxa3Tu4LEoQcqiPeRWLSwzn63vA4Als=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LCAELaG1KcGMkTx0XBak5qPcPT7J7b2uv5ms1KPYUofANzsC9UTb+p6Wx1Us8JTbBFwFX6ZT2VxyQkrezRvleBoF63tQBNJo/3/+HrWGswOFuNa0oRkaccFBuDct8SOmnjZPUYBwk7E4NEGcf/tsp8enJx3BYHqyod/nAMfpHDQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=aIp8EZs4; arc=fail smtp.client-ip=40.107.94.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bMqSkdyHyjxND+LriOfCe4vdwamL28Y/VlbRnzgLQC1gWSJS8LCZaTUCmEZHt6KAXtvh8+zfPAdCOmeIISLDdsZtZcvN7DrCK7zEchavl9G5p+fV6FHqVV8huEC/2zCHLwViRhrfNW8qhU9Zp45orbELVm8azDhuEzpf6gIDxooSzlDZykYxyd+NKujcBMTiZ1guadJKlHbEc0nQ+v0PGUFMOdZSx5Rgw0p6P7+UqeAheDsthpv9grCdZoJH2mQl2Qt08+LvFiL1dhr97CqUTa37kjZDQArtAR4VAwuPdYx9dCfwTTwXEPcPJ5hVCfeC4ojC/5SXZ1Zgtdjek7HRGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d24wMTkB4u1gW66C+ptM52WAY90TJulmmW8ZN3nU32k=;
 b=GXd67Rwz6D2GrQDj0ql3xYkEhQ15nvfzonlOz1ETbmA6S5JoASb8syjZkkAk9dBd0HsRs4V+JBQm5DOkIYMp5+oNSj+uQ7iowyyOyzXAbBNIbiGbBv9riGSrCPlji+Wk/ePMY63pji5jBXfx8iUPjCwbM5pZAllFyYVoqOIgUq5uD/pOxMrSF+pucLG2kxmiYD2Qgcnz1rW6+B4qDXW8lf7TODkWRjOYMLm+eCz8SJGcdMxa9MXdC97bOmto9binoEUgYZ1iBpJz/7ia9mBSazEqDdgnUxiV5RpfIBReTh2iY9cpMARs73d62Fahx+0zwucJkIB27DFNji5lOfazXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d24wMTkB4u1gW66C+ptM52WAY90TJulmmW8ZN3nU32k=;
 b=aIp8EZs48hYULKsvP7gzp9kHiMlPcHYdXQJPKZNpmcECB1sp7oxH3wA/PfcMCdAeTTcJgk/uBE/nFQADJaLwIMCMthyNdo6K8TbXdkoPI7RhCiMrz4TrJdNJD2UM81079dBFMyIDd28eqck/WpHvmO1fIUhfqF3NU+WeJYZ8a4gxscyWtxsCqK5rctwW/XPSTTyy6vbgJdBxAigDTyrzMV600h9JKcR7L4mnJJyghEkmKNNPDjJGIe5H7bBOHqcqfbjjLuhBRKpy+trqC7j16guCRhGVlH2MW7+WFECPbOr0Por+5zNtOJzxd9irkKqFX62w6TnYjRvLXVwKj4Hjbg==
Received: from BN1PR12CA0016.namprd12.prod.outlook.com (2603:10b6:408:e1::21)
 by MN0PR12MB5737.namprd12.prod.outlook.com (2603:10b6:208:370::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 18:20:10 +0000
Received: from BN1PEPF00004687.namprd05.prod.outlook.com
 (2603:10b6:408:e1:cafe::a7) by BN1PR12CA0016.outlook.office365.com
 (2603:10b6:408:e1::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Thu, 29 Feb 2024 18:20:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004687.mail.protection.outlook.com (10.167.243.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 18:20:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 29 Feb
 2024 10:19:50 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 29 Feb
 2024 10:19:46 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 1/7] net: nexthop: Adjust netlink policy parsing for a new attribute
Date: Thu, 29 Feb 2024 19:16:34 +0100
Message-ID: <410a56b273484e34ece228e9aec0008ece6b96b3.1709217658.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00004687:EE_|MN0PR12MB5737:EE_
X-MS-Office365-Filtering-Correlation-Id: 01b8d514-8148-48be-e69b-08dc395310c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ugMRcv9KItZ/liSgeKN519LIscy0V4aXgceEQbwZkoUs6nWQk1KFZKiVAsoTOV/jDvtMNViULeMDfmZR1HAQmmqY6bln3l1x15p9F/NT92zvpCS/YGWdiaM9je3CQfSZe+TRl8NX5OZM6DCwK/KGxWvpyCYv5+QEtm3lnelIaN4n2Ce4eT2536z3vaBAkq1XQXS4znOXd4hxAA5tkDp+n7S4oxspCE9ZHNwM+5zgGpRQ2Ab6YOqkCn1A8mtonHBBNvoVIJvtxZ783bs7XqrycDjKsnZftfYeJSwl3cAx65qLr2Lsfja1+Z3vS6NLyYzgs/d5QZeggfWb//2gU8RYgMN1Kb8NXhmNHmO5nbrClEPgbpRYygL4369dSEG6zQTtGtADCyHFpMAxFej5yRc7AXfPkOHZyhopda/bwETzeS2QhV/ptCzkwAaeQWKTw9osAgCofG4SW/bjG0yzcm0CPPhfUsLPChmZSUqHRLSuiTKtuYz/vcMjh5fl8+47jbn+wZtphzhg8xPTAe999IORKznqCgnnik9nVD4wcxIafepsrgsaIkxsKcrrlFrvVJog4psC8IvYSW4G6tpfscQZD/g/dNsm/B88MDclLdERrQD9tnHtegOX60MxyUbqQZxGtL/hVluv5KKpkNOw2pWpgBCrhF12+jiCS6LcAkXzfgzjAarKXNu4SJ1w62qi/bSHjz/LdWIYBrRhe8wsUJObxWqoN4/22zlqALEBEmR6ZBU1d13OxkUbka6oos3ebavi
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 18:20:10.3519
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 01b8d514-8148-48be-e69b-08dc395310c4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004687.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5737

A following patch will introduce a new attribute, op-specific flags to
adjust the behavior of an operation. Different operations will recognize
different flags.

- To make the differentiation possible, stop sharing the policies for get
  and del operations.

- To allow querying for presence of the attribute, have all the attribute
  arrays sized to NHA_MAX, regardless of what is permitted by policy, and
  pass the corresponding value to nlmsg_parse() as well.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---
 net/ipv4/nexthop.c | 58 ++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 30 deletions(-)

diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index 70509da4f080..bcd4df2f1cad 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -43,6 +43,10 @@ static const struct nla_policy rtm_nh_policy_get[] = {
 	[NHA_ID]		= { .type = NLA_U32 },
 };
 
+static const struct nla_policy rtm_nh_policy_del[] = {
+	[NHA_ID]		= { .type = NLA_U32 },
+};
+
 static const struct nla_policy rtm_nh_policy_dump[] = {
 	[NHA_OIF]		= { .type = NLA_U32 },
 	[NHA_GROUPS]		= { .type = NLA_FLAG },
@@ -2966,9 +2970,9 @@ static int rtm_new_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 	return err;
 }
 
-static int __nh_valid_get_del_req(const struct nlmsghdr *nlh,
-				  struct nlattr **tb, u32 *id,
-				  struct netlink_ext_ack *extack)
+static int nh_valid_get_del_req(const struct nlmsghdr *nlh,
+				struct nlattr **tb, u32 *id,
+				struct netlink_ext_ack *extack)
 {
 	struct nhmsg *nhm = nlmsg_data(nlh);
 
@@ -2991,26 +2995,12 @@ static int __nh_valid_get_del_req(const struct nlmsghdr *nlh,
 	return 0;
 }
 
-static int nh_valid_get_del_req(const struct nlmsghdr *nlh, u32 *id,
-				struct netlink_ext_ack *extack)
-{
-	struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_get)];
-	int err;
-
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
-			  ARRAY_SIZE(rtm_nh_policy_get) - 1,
-			  rtm_nh_policy_get, extack);
-	if (err < 0)
-		return err;
-
-	return __nh_valid_get_del_req(nlh, tb, id, extack);
-}
-
 /* rtnl */
 static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 			   struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(skb->sk);
+	struct nlattr *tb[NHA_MAX + 1];
 	struct nl_info nlinfo = {
 		.nlh = nlh,
 		.nl_net = net,
@@ -3020,7 +3010,12 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 	int err;
 	u32 id;
 
-	err = nh_valid_get_del_req(nlh, &id, extack);
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
+			  rtm_nh_policy_del, extack);
+	if (err < 0)
+		return err;
+
+	err = nh_valid_get_del_req(nlh, tb, &id, extack);
 	if (err)
 		return err;
 
@@ -3038,12 +3033,18 @@ static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 			   struct netlink_ext_ack *extack)
 {
 	struct net *net = sock_net(in_skb->sk);
+	struct nlattr *tb[NHA_MAX + 1];
 	struct sk_buff *skb = NULL;
 	struct nexthop *nh;
 	int err;
 	u32 id;
 
-	err = nh_valid_get_del_req(nlh, &id, extack);
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
+			  rtm_nh_policy_get, extack);
+	if (err < 0)
+		return err;
+
+	err = nh_valid_get_del_req(nlh, tb, &id, extack);
 	if (err)
 		return err;
 
@@ -3157,11 +3158,10 @@ static int nh_valid_dump_req(const struct nlmsghdr *nlh,
 			     struct nh_dump_filter *filter,
 			     struct netlink_callback *cb)
 {
-	struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_dump)];
+	struct nlattr *tb[NHA_MAX + 1];
 	int err;
 
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
-			  ARRAY_SIZE(rtm_nh_policy_dump) - 1,
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
 			  rtm_nh_policy_dump, cb->extack);
 	if (err < 0)
 		return err;
@@ -3300,11 +3300,10 @@ static int nh_valid_dump_bucket_req(const struct nlmsghdr *nlh,
 				    struct netlink_callback *cb)
 {
 	struct nlattr *res_tb[ARRAY_SIZE(rtm_nh_res_bucket_policy_dump)];
-	struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_dump_bucket)];
+	struct nlattr *tb[NHA_MAX + 1];
 	int err;
 
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
-			  ARRAY_SIZE(rtm_nh_policy_dump_bucket) - 1,
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
 			  rtm_nh_policy_dump_bucket, NULL);
 	if (err < 0)
 		return err;
@@ -3474,16 +3473,15 @@ static int nh_valid_get_bucket_req(const struct nlmsghdr *nlh,
 				   u32 *id, u16 *bucket_index,
 				   struct netlink_ext_ack *extack)
 {
-	struct nlattr *tb[ARRAY_SIZE(rtm_nh_policy_get_bucket)];
+	struct nlattr *tb[NHA_MAX + 1];
 	int err;
 
-	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb,
-			  ARRAY_SIZE(rtm_nh_policy_get_bucket) - 1,
+	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
 			  rtm_nh_policy_get_bucket, extack);
 	if (err < 0)
 		return err;
 
-	err = __nh_valid_get_del_req(nlh, tb, id, extack);
+	err = nh_valid_get_del_req(nlh, tb, id, extack);
 	if (err)
 		return err;
 
-- 
2.43.0



Return-Path: <netdev+bounces-76278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD98886D1EA
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 19:20:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F2F1B21890
	for <lists+netdev@lfdr.de>; Thu, 29 Feb 2024 18:20:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008A57827A;
	Thu, 29 Feb 2024 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Gmaaz3Sl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2075.outbound.protection.outlook.com [40.107.102.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900EC7A124
	for <netdev@vger.kernel.org>; Thu, 29 Feb 2024 18:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.75
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230820; cv=fail; b=d4CV80uphdmFzsSZslASuGwaTb/DEm3rSsJE3P5Ey6tiU4nhV7ieBgQ4Mx9PMZb4zV8dBv7DuBIZ7POrX3P+XNgKnP7lBjNvGnia7B/S5v9Bgy/zFVDnKRaTZG7acNACSJxYp5tOhmnCZfJUBuvuos1vUGsRoXR4THRCq1HgraM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230820; c=relaxed/simple;
	bh=PQKle3U0+edSxspTEEJGtqwlSNRVMRkIddBuPe6R7SU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MXG2j5x3PxvEd/gwLeg7nc2jZbGECUItPpIKwAC+6FtWuUK7y0LZ/0w/sO7KdGUvdwkNzE+KV6DN/ibUvl9u7zFf949zSTz7c3zhap1dWyICjjLHiru5ifw/nvqMwpXDT4FqYTj59++D67S6/3vzZt8o5wTV+tOifEVzJWl46uE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Gmaaz3Sl; arc=fail smtp.client-ip=40.107.102.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=S6+t1sNb60LXOjy58iz9PJO8UeuW2k0g0lYK3fdtDGNqoyEJE0NYCmXZlywxMPJ107NrN2K0eZ4uTjPgCDifcfg8eRoorW8zzEyveC9LrB8hM7lc4KduuDkbw62cLGyQF2tdtgaHT1dcvKETQOGf1uyAoLB+e76KLkSzeWxM0whfZf6q95KJkKX29j63QLs2nJZBMaCcqurCxYYIftYrw5zxZwopRYDBnu/umT2CptKf4GVVCwwq/XXXbqgetEpyJXmeioc5Fag3MzxLRObFpcvL8tYoBk4bLXxq+GSt3DLZmrLPoDvdDZTfqFFGPgpTjVDj4zPLvNibwiD9QeYfqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jQE+iwVEmpiJ3lU38lH8fkutr0EoST8pwu6NRyKGhg0=;
 b=NqwaZZOKe6jvua0a+K9yRrNMN8QhE1AyKlhfjGiNQN3ND7fuyLZW/jTFWNwAILUKd8iPJSo+fK4lY/J01LJZ44sXGxZcu6OkdlOjZj1AYKTnEmU/HTFhKd4zs+MzH1A04Af3S+UDmzDeLYsUBd3Xn23O4RktW3ke9G9EDDcipiBlGH3ihYexxTlRw1vvSWuGvHUXTYPdqbhluZVFtbe1MkXCbsz0DGk9o+UX8Plg+4BjTaPGKY+fHfJP5sUIxW9SAuetTddv9Z/Py854etwh4vBACRmifyyBCJ5jh+9Rmwh+huHtCug0fx+0AauCSgmRj9pGXgQW5EXiXQQ9fhYskw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jQE+iwVEmpiJ3lU38lH8fkutr0EoST8pwu6NRyKGhg0=;
 b=Gmaaz3Sl4qzbXcONH0NX9aYpqvXZSD9usfDvmjBAX94fJOQZbvbWobQOlGNsuUrBnQQ8U3Y3h2yLhdwKq81g6M0jDDpOclQLDHTBNdxRs/VviCxr7NTX1nyYjdktZQklgp7r0aBpBEtehWAjxbiWJ+trYEzzLz+U3YpLlnDM1CzMrPe19qYC3DPyWAjSo764/HRA3zqYDpAc+HQYSmINiwrFWae4XiCu+/8vain5oFkmuzhfh87gFXbUpyEbihg1S6LtVDRZJvuQTFKCuIzcPkiNP6e7Mzru+v8avpodHm338EcQzyZtHxYlYaFQkpUZgCHyV23BQfqKWZxLlemKEw==
Received: from BY3PR10CA0027.namprd10.prod.outlook.com (2603:10b6:a03:255::32)
 by PH8PR12MB6961.namprd12.prod.outlook.com (2603:10b6:510:1bc::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.41; Thu, 29 Feb
 2024 18:20:11 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:255:cafe::53) by BY3PR10CA0027.outlook.office365.com
 (2603:10b6:a03:255::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.32 via Frontend
 Transport; Thu, 29 Feb 2024 18:20:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7292.25 via Frontend Transport; Thu, 29 Feb 2024 18:20:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Thu, 29 Feb
 2024 10:19:55 -0800
Received: from localhost.localdomain (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Thu, 29 Feb
 2024 10:19:50 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v2 2/7] net: nexthop: Add NHA_OP_FLAGS
Date: Thu, 29 Feb 2024 19:16:35 +0100
Message-ID: <0aa48cb15c1dbece33b6d090ff47f444852900e1.1709217658.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|PH8PR12MB6961:EE_
X-MS-Office365-Filtering-Correlation-Id: e1c35cc4-f9f0-4486-0424-08dc39531111
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0UeBsMd9TbWztn6nC/glfVBCT99jdBv4DfiFAFwEXDUeUnRDHm3kGRV06+/4YqxzKqxt1OZ1HwGxPT8AZfEFF+D5HpiTWPeIasakPRvKeZ9A9X1DDA5uT1ARFeJYq2t2L3UAjF9n1ob36J40fcGISI/MnMkmVkZ62+qLQ3/Fp4DQX3lJtFHMYhKIBoFpKcYRnm+pvsL9kMgK9Ee2ksShXSX5On9EHrWKfqW4+Z+Ows7PFw8ZGst26iyAIFWGQY4oKPYVNkInzlfiWlhJKAOwtivDJk/dWEqmnWRaYuVPbOcuBhcidID583xx+VReU08TDI0l8NCuOWgvReGHcMTOHBx3vPlN8SJ9p18dM8PVxDjxtgYPrNsOnEMPIW6bD3cpTy3RVE4IqNVjI/qQUVHNoCH1WbHN7heUtBwLa9TDGznNPh8MuhDPuuDVwEb9LbOhbQ6IiVH/PK5HHx87H7fVLTs1Ykhb96OJ79oDEBdloBZYqrlzVU/I+y9/2n2JvbTFpLX89hPoz9Ql2j7pGqHnaL510xNBb3ctPoXPis194nomBYD/rEMERA1ZHy/JaHMtzlM0i6b7lrg+0mDf964BXZ3yaS8WXWki8loXmZo5FS7EcAoMsWWRLxJqSTPECscam3FOIAv7wj2mef46z9bxvsEvPni91knwxkfQevKvE4h6TfqVbuJKJMd3TCFL1wBcmSmVSO/C08Loz+kiDqGu+i3SQG7+3ajAVbHfvC+dOO9MIhIxrtL9vKgbpvfttNfK
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Feb 2024 18:20:11.0070
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1c35cc4-f9f0-4486-0424-08dc39531111
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6961

In order to add per-nexthop statistics, but still not increase netlink
message size for consumers that do not care about them, there needs to be a
toggle through which the user indicates their desire to get the statistics.
To that end, add a new attribute, NHA_OP_FLAGS. The idea is to be able to
use the attribute for carrying of arbitrary operation-specific flags, i.e.
not make it specific for get / dump.

Add the new attribute to get and dump policies, but do not actually allow
any flags yet -- those will come later as the flags themselves are defined.
Add the necessary parsing code.

Signed-off-by: Petr Machata <petrm@nvidia.com>
---

Notes:
    v2:
    - Change OP_FLAGS to u32, enforce through NLA_POLICY_MASK

 include/uapi/linux/nexthop.h |  3 +++
 net/ipv4/nexthop.c           | 24 ++++++++++++++++++++----
 2 files changed, 23 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/nexthop.h b/include/uapi/linux/nexthop.h
index d8ffa8c9ca78..086444e2946c 100644
--- a/include/uapi/linux/nexthop.h
+++ b/include/uapi/linux/nexthop.h
@@ -60,6 +60,9 @@ enum {
 	/* nested; nexthop bucket attributes */
 	NHA_RES_BUCKET,
 
+	/* u32; operation-specific flags */
+	NHA_OP_FLAGS,
+
 	__NHA_MAX,
 };
 
diff --git a/net/ipv4/nexthop.c b/net/ipv4/nexthop.c
index bcd4df2f1cad..816ae8ee3e06 100644
--- a/net/ipv4/nexthop.c
+++ b/net/ipv4/nexthop.c
@@ -41,6 +41,7 @@ static const struct nla_policy rtm_nh_policy_new[] = {
 
 static const struct nla_policy rtm_nh_policy_get[] = {
 	[NHA_ID]		= { .type = NLA_U32 },
+	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32, 0),
 };
 
 static const struct nla_policy rtm_nh_policy_del[] = {
@@ -52,6 +53,7 @@ static const struct nla_policy rtm_nh_policy_dump[] = {
 	[NHA_GROUPS]		= { .type = NLA_FLAG },
 	[NHA_MASTER]		= { .type = NLA_U32 },
 	[NHA_FDB]		= { .type = NLA_FLAG },
+	[NHA_OP_FLAGS]		= NLA_POLICY_MASK(NLA_U32, 0),
 };
 
 static const struct nla_policy rtm_nh_res_policy_new[] = {
@@ -2971,7 +2973,7 @@ static int rtm_new_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 }
 
 static int nh_valid_get_del_req(const struct nlmsghdr *nlh,
-				struct nlattr **tb, u32 *id,
+				struct nlattr **tb, u32 *id, u32 *op_flags,
 				struct netlink_ext_ack *extack)
 {
 	struct nhmsg *nhm = nlmsg_data(nlh);
@@ -2992,6 +2994,11 @@ static int nh_valid_get_del_req(const struct nlmsghdr *nlh,
 		return -EINVAL;
 	}
 
+	if (tb[NHA_OP_FLAGS])
+		*op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
+	else
+		*op_flags = 0;
+
 	return 0;
 }
 
@@ -3007,6 +3014,7 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 		.portid = NETLINK_CB(skb).portid,
 	};
 	struct nexthop *nh;
+	u32 op_flags;
 	int err;
 	u32 id;
 
@@ -3015,7 +3023,7 @@ static int rtm_del_nexthop(struct sk_buff *skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	err = nh_valid_get_del_req(nlh, tb, &id, extack);
+	err = nh_valid_get_del_req(nlh, tb, &id, &op_flags, extack);
 	if (err)
 		return err;
 
@@ -3036,6 +3044,7 @@ static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	struct nlattr *tb[NHA_MAX + 1];
 	struct sk_buff *skb = NULL;
 	struct nexthop *nh;
+	u32 op_flags;
 	int err;
 	u32 id;
 
@@ -3044,7 +3053,7 @@ static int rtm_get_nexthop(struct sk_buff *in_skb, struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	err = nh_valid_get_del_req(nlh, tb, &id, extack);
+	err = nh_valid_get_del_req(nlh, tb, &id, &op_flags, extack);
 	if (err)
 		return err;
 
@@ -3080,6 +3089,7 @@ struct nh_dump_filter {
 	bool group_filter;
 	bool fdb_filter;
 	u32 res_bucket_nh_id;
+	u32 op_flags;
 };
 
 static bool nh_dump_filtered(struct nexthop *nh,
@@ -3151,6 +3161,11 @@ static int __nh_valid_dump_req(const struct nlmsghdr *nlh, struct nlattr **tb,
 		return -EINVAL;
 	}
 
+	if (tb[NHA_OP_FLAGS])
+		filter->op_flags = nla_get_u32(tb[NHA_OP_FLAGS]);
+	else
+		filter->op_flags = 0;
+
 	return 0;
 }
 
@@ -3474,6 +3489,7 @@ static int nh_valid_get_bucket_req(const struct nlmsghdr *nlh,
 				   struct netlink_ext_ack *extack)
 {
 	struct nlattr *tb[NHA_MAX + 1];
+	u32 op_flags;
 	int err;
 
 	err = nlmsg_parse(nlh, sizeof(struct nhmsg), tb, NHA_MAX,
@@ -3481,7 +3497,7 @@ static int nh_valid_get_bucket_req(const struct nlmsghdr *nlh,
 	if (err < 0)
 		return err;
 
-	err = nh_valid_get_del_req(nlh, tb, id, extack);
+	err = nh_valid_get_del_req(nlh, tb, id, &op_flags, extack);
 	if (err)
 		return err;
 
-- 
2.43.0



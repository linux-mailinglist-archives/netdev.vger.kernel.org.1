Return-Path: <netdev+bounces-77222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5BB1870BDE
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 21:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CEFB2832E1
	for <lists+netdev@lfdr.de>; Mon,  4 Mar 2024 20:52:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B952210965;
	Mon,  4 Mar 2024 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="qSqAZgoB"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022EC101C1
	for <netdev@vger.kernel.org>; Mon,  4 Mar 2024 20:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709585537; cv=fail; b=gpUtbVbGy8yOVoppcyUdD9u53FJmW26M/abkqanUB9rGVB9F8hFeoTGjoBcVBMTQmUlWH306ACJSBcfeHDhb3UvsGmrWy4VFlMIyYjzq0np4cMLfHDJYWpz46l6JJD2lTOmQrAVnRI/em7C0q9ltV35LzyByZvlto5B8AbC2SdE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709585537; c=relaxed/simple;
	bh=Ey3eHc3XhgWFhKSGSj04WNITJTf+pqhOkuueOO4/cL4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lZvy8FAuQ9GGYKh+yCk9xMLUVZ4l6USYBIHFbXcnalVK+lGRk/kkM+eRpvMyYmsdAG8hTcJCXdY5oNNzZWn5mj1iL2P7akR2rVCaDPXoa/kEar6YAWTRePfvz/mvNpy4Ti61ttq4LMLhuRhXzetvGWra4EKUSngXxMOo7X3eroQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=qSqAZgoB; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=C2NLMH0zKR2m3QvylKQLmdEDP7AMbtCscZmUxKaNDIlwv0zcnW7GJpzFnGutm/XcX0t57LZhJf68D7YWKarbCx33h2e53Z0oFi8YMdU5pidMtuCc/hz6zpMohcCpT1EOR/+4081u7buMl+Jk4NDE53NR3uzp0o+2c4Cw6Ha64/5M2MqbdDqJi4IL82FtD3hBB2aki/xJnXuCZPZU1mpX3Zy3gYBTMEa2SD31iH58oOvog0GKBeZRiY7xLf0kqfkpGIYNILOeiLIyYpnpA8EBnpLUuOEwfOnsA//XOc5GKm1umdAGOjYgVRpKv3jtAT1mPnIb1HpKlDNvPnHg69pJ+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NgqXMJMqFi8zGqcDN4D8q9rzy6s2LjxCp5LuxKnw+bg=;
 b=KmVpI56l4v8ZqMWzzGuH0rPtq4H/7HflhWnUQlEGF9FzYXh0REf17vlQWH+h2Aj7ku/hw3YmnT+xfIwoDientm7IcvM3940eHd3G8HkNuQILPShHY+mgwZVgH0EDEFku1pWWT0CLXoyEDq6dxWOwSZexq7HoBdB/6D03ZFBuLlPwGv9nxPkRruOET4WJrg7SdvKy1UFoOl/zTSF3lgUVgw5wAZYEdymo9ffBdwLXMzykV4KYz/OYSibf5n/RepKY2B0Hb++NA7EuutBVfW0Wo5fvd3NxfkHu7SMfhDczAKBXJK+rBNNVoWXUA4YGIi3dUTQbBN7dBCy5n6vyuE+mlw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=davemloft.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NgqXMJMqFi8zGqcDN4D8q9rzy6s2LjxCp5LuxKnw+bg=;
 b=qSqAZgoBh4Jkx4YbLQKeOT/UNg6uyqJ3td416QuTW52/MasYoj3XyVM4KL9BRMTKmMfjI62e8sgzFWyntBRTREXCI2YunqWbma/X++UfgjOsmz17IkN92iF6u85lAnod+ND+GIJtHTVzqjl9L29oVJmglgsLmVdVw+bXwFNFWjWgeKo4yu0MbdA9FlmCHDbDZGx34T/pqG5Cg+0I+VVfD+TUhcq5/iuwv5xIvdoha5s8OHlqqsxckRFxzozWkeBNAGkYSVp4dy9mvG9FqbL0Kwq8AlawKxgFTC5sxoJQmHvoVIfpCZyNXd1Nnr909iZ+cfpAK/bLkOe7SI7KyiFTsg==
Received: from DS7PR03CA0248.namprd03.prod.outlook.com (2603:10b6:5:3b3::13)
 by SJ1PR12MB6267.namprd12.prod.outlook.com (2603:10b6:a03:456::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Mon, 4 Mar
 2024 20:52:12 +0000
Received: from DS2PEPF0000343E.namprd02.prod.outlook.com
 (2603:10b6:5:3b3:cafe::55) by DS7PR03CA0248.outlook.office365.com
 (2603:10b6:5:3b3::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38 via Frontend
 Transport; Mon, 4 Mar 2024 20:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 DS2PEPF0000343E.mail.protection.outlook.com (10.167.18.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.11 via Frontend Transport; Mon, 4 Mar 2024 20:52:11 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.41; Mon, 4 Mar 2024
 12:51:57 -0800
Received: from yaviefel.mtl.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.12; Mon, 4 Mar
 2024 12:51:52 -0800
From: Petr Machata <petrm@nvidia.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <netdev@vger.kernel.org>
CC: Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>, "David
 Ahern" <dsahern@kernel.org>, Simon Horman <horms@kernel.org>,
	<mlxsw@nvidia.com>
Subject: [PATCH net-next v3 2/7] net: nexthop: Add NHA_OP_FLAGS
Date: Mon, 4 Mar 2024 21:51:15 +0100
Message-ID: <46fd3a32ea411c65a66193b7e25833ecf8141326.1709560395.git.petrm@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS2PEPF0000343E:EE_|SJ1PR12MB6267:EE_
X-MS-Office365-Filtering-Correlation-Id: 42401518-f0e7-4596-2402-08dc3c8cf6ef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	lmn4UMMG5TGmirHqYsBrDzeohu4SlvEoqAQKQJc+J/rNtylfbZkY4GOnUxRPoqT5oD0N/IdALX+0DWgBY+A3quzqemjSn2wcJJ1Axcm7U0i1N91sMaQfMSzQVjrltXLyHsj0gHXSzTxthpIpZ6Z7QsB+grITzLRfOtAT2aMZuXLR84Awry9jG3abzkFD0vrQW66SXqX2cvlIQnzrugGt9aHO7xPipED5qHiMrlZOZ8zvSaX2ZnZjrCQRRmQ0V9U8rCg8nSO8anZTCRpyd1ZIP1iFTQc03bpOPRueRZOLu8dQtfHCICkqTs/62s2NuS7DruxOdEM86+aZZqs6tqGVPLHz7p+nJTi0DDfi+OuYRALmOnaIKxw2+aIKPXj9OkT8AopTlD84dmaeQ1/vlshFEI0HRohJU58LQ+XdXXByma5lasEz0vg+PQVHN3I3Qsp9aUZNWQIRvrQgZBqj9gVbO2i5AJeQJvwOMfqyOl6EUtJ3BYx/pHz2vxDA2YxhTPB7hVQnSSDxtctYQvkeeQ5PAq7ne9qJc8xqcIxnBHZWEpC7rgCKGalaWODoPA306R+/qDpvnn7TkwzA+KdKsYLJ2y7tav4o2kTxY8A1x1x24E1AMtNKb6pGNun1SteNKJZjs3kHN1NtmloPtHpZSAGSE20RD+zYnPdudsFUOnbqPUiY+QbaAAu0zhgqst/lPLI/2+DgQMKJC1D20nuf+7+47BZp8tAeke3FPhLawVTrqIGvd1b4HBVAc/lrqXBxrO8Z
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2024 20:52:11.4160
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42401518-f0e7-4596-2402-08dc3c8cf6ef
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF0000343E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6267

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
Reviewed-by: David Ahern <dsahern@kernel.org>
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
+		filter->op_flags = nla_get_bitfield32(tb[NHA_OP_FLAGS]).value;
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



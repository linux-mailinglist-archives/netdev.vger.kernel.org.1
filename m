Return-Path: <netdev+bounces-168036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CF3A3D2CE
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:07:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 517833A396A
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290891E5B78;
	Thu, 20 Feb 2025 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="uB0XWdqq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2068.outbound.protection.outlook.com [40.107.212.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59B0C1BE238
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 08:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038816; cv=fail; b=ZtWfJ7CeAWOUC68icHaCEpvVYXudJbgb/C/eImMAfxzUe5r6jiKm6pmshEQno2gBwj5BsinLDzjLiOXEgeEggJReUnaku0jZNVLwGEzgqry20MbKMh03QGhxap746OsBFPbS4+B9FWgfU8Tpfgf7YhyzpOoLjmBCUdCRzMprVag=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038816; c=relaxed/simple;
	bh=618uMF+xtM1wYQHlWts3LPazV5Ps9wNUvR0veIxI0Bk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E5rTdP69z4TEYz6X3x8tOVaKrh4ZJCQBYDOaipqpmTN+K63jX5D8t1QigIMv8PaeizIDXGUUZshldqmI/WnVpZ9aEa5W4VCp3UjCyWHnQRrn1FGEW48Iuq3tUM5d/8lZNXR7ilPRoICkELm1NF7UA4TBFaJMqiUPX6CD4JKS5+4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=uB0XWdqq; arc=fail smtp.client-ip=40.107.212.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tEOEEzhSG0KYXTZCn4Iqhk1PSsrGce2byz/EvXIFgr8GvPylqXmdAbo1GrgZO9GT5ZyywaJKa7ovNdfsGqS/NIN1s+5Mhx0FwwdIC3T1PhMQQiTOkaBWJ1okNHPMFLzrOrATXiNXTiiokg933hVVHOTFAF+0EnrttOCmhApS/ypvsFnDoEkR/puTf1/xVu1Xuj5TYfgW1FJNQLt787kqoyAyFykJ1ihTYo/AGh4/e12BexEgZa7QkUomqyhU/DgUE/fegsr7FXSg+4CVJhcchwC1DW3KEJGLLsXyEYSCREtrvUlYwYKvLiKaH4gGIl6DqbtKKq4+hBRao/AlhxIbJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FNcWh/s95+6MkRMzQG5RzUtMfy+syLFlGq3ML1YBMzM=;
 b=FdSktkP1ytkAwjIjF25l09i7rGa0PrtqtU7+fE9KKvRrZZrQ8yFfIV3ad+0+zxzi81dvhIBr0xaw0HQPPqlpQPsum59DH5KBi0DXIzrPf0ILGgxyWF5RNGw2cbC75Nevo5Lj0wUFbOaaU/d9wIFiwJ0xybNe4/x97gMTvgyhkVqugwnSywaPL3+3weP4CuY3hGM2YquL5QVDGNwFR9muqpOb52HypotyD8Iey45Z/NJHDjDVt9xPOdmOFnDdncQ40uvXOndSCD+TbdpQ4z6eKoPGm8HqbJ47f12uVQ5X8PaO4uxext80wmn8VGSABPutvz9n6cdqjZnEyGzZJi5WJw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FNcWh/s95+6MkRMzQG5RzUtMfy+syLFlGq3ML1YBMzM=;
 b=uB0XWdqqDwO83zYe6Zc40tBVZFWJLbNEgJMnbCbwzaF+DZiuNG9BXLNnfkX/4J7yOH6yiA7LuQV+WVjsPxSJ3LN/ETC1egC+J5+pX0nAD4A44zSx5vKt6jYhTVJs2YGvTDMVUUG26wjvsfMbHSLtff6vVeedLn+y39dyEh1qFKFSe0zSI5u1RF2fRB3D/JHkO0unuhdnpF+ssp62Um3NwmhqEUp3gnZvOlNzyNKHECYzjj3JwUzMOSwIi43QuCrLrSUn+wJbUE3ufEIPQGwLnKls2UG/PjMhF9nibv3l3UrOQvYkBi354GfVfJ0yCehMVUmrp4jtjWsesMCFICXf0g==
Received: from BL1PR13CA0327.namprd13.prod.outlook.com (2603:10b6:208:2c1::32)
 by MW6PR12MB9020.namprd12.prod.outlook.com (2603:10b6:303:240::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 08:06:48 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::84) by BL1PR13CA0327.outlook.office365.com
 (2603:10b6:208:2c1::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 08:06:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:06:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 00:06:34 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 00:06:30 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 2/6] ipv4: fib_rules: Add DSCP mask matching
Date: Thu, 20 Feb 2025 10:05:21 +0200
Message-ID: <20250220080525.831924-3-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250220080525.831924-1-idosch@nvidia.com>
References: <20250220080525.831924-1-idosch@nvidia.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|MW6PR12MB9020:EE_
X-MS-Office365-Filtering-Correlation-Id: ac2bed4f-2a07-4f1f-f89f-08dd518585dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?jWNmwC1z2x65T1a9uSZvMK2jW2INyAqc0sfZgt4udIBJJWTLlfbea2t2ELKU?=
 =?us-ascii?Q?CapD6Lr+ByfnfxlsLDFo5hu5KcYW8+L6WeYrXlx6K4p8GxzEn11OxOWufzz0?=
 =?us-ascii?Q?dB/qlKGxnGwZyFMSFPdLwH0cQGpQEPE0qnfYSsUbrK4kNW7BH8cCHM/DLrjb?=
 =?us-ascii?Q?8sgITPGQy+E/T0HabNN9M3ZXmInYkY3SaOs7/Vl6YQl0SYMB/uJrHDDf2Cjb?=
 =?us-ascii?Q?5UqIeUkNTfixuuLbO7AokiJfX9/N3EefA7nVLhZ0orxZ1Z62KqGTZ7MtOH1r?=
 =?us-ascii?Q?RJyAKW5puqaHm1vtuVpVe69M6wWi1vWpCkHDwPhuAddMSUeSRpn3wdfdKOWX?=
 =?us-ascii?Q?xaClH1g2xr9Vc0BqOYrbxMw+dRXuswhR/Id6BbGfMUOvnTlUvYUGYiPVR2hP?=
 =?us-ascii?Q?jo++JgKF8Cp9d8vwuyz3deGT09Tf9ut+O/SeOW3lYukrvHJG7dhnGMGZdLE7?=
 =?us-ascii?Q?rd5BetuCGdd+W1R1HuWWS7ijDQnqPTZFYSgZc1cE6tJYxH+/mYofx+rqNoJ3?=
 =?us-ascii?Q?IBofMPA/zVas5l0VAGPxZNGA6XqNPGaTeF/O6FN5RIAQg6Quw3+BJQ/fUk5F?=
 =?us-ascii?Q?+4vhrQ9d6xKsnJiJRJpozEubIJRtMADCBd5pUNbrd6sGd8T2M5BfP+Ux33A+?=
 =?us-ascii?Q?vjYfkg8JH56V+sOcMt8cqPZtUZNtSvE4Oto/54xzAOiOmMmcWTkKT0tiMk3K?=
 =?us-ascii?Q?fLbYMqhZfz2QeIvdYxGBHk/t6IUcIJY4KX8+vuXNCuSHTtkA2JzVTKcKr+rh?=
 =?us-ascii?Q?PIL0p0AfEpRDf4LrwdMwK9e0BUHjt2S3vYG8QHApdsMlgOE+PyqFNPMinKpy?=
 =?us-ascii?Q?wGPdVQ2gXvEggs73YzFJjv9diXc1SCg3f1dTagRST4wphxb2JfzlfrFTzDUy?=
 =?us-ascii?Q?PQ2m+rKXieSajEPb18yVIsmlKrH/Za8NzdteJ3z+OE9JWkk/YJgnL9fPrR+7?=
 =?us-ascii?Q?9a/VuKQ4a9IwynjbpB3VfjlZ+4+fWj5o4lKYyNV8EZpUprQM+Q6ZshhAxMdA?=
 =?us-ascii?Q?9O029RdvapTK2uqxLreTmAqEQlW4OxO8a1Ik058Or7qwUSOb1wCdJTFMFUH3?=
 =?us-ascii?Q?eNfBQ2C4Bt2p0le/fkEv1JZ+ohlQAWnFN7W1xonn9Luc97ZL6ecm1LjHeRGr?=
 =?us-ascii?Q?pPFPBqASAF4CZ58sRAeA5nnANlmi0atvg2BMHAJnjPDeWDV4JWfsbc6M8RWN?=
 =?us-ascii?Q?YezDNnOyCUvWIbkVajBB2fFXWyZmfuXfXbV17+X3AGaZNCMu0FSpdAUCmI7M?=
 =?us-ascii?Q?Wi2ZMwr7upjv9fL15w01RUSaOybq+mi0Yhnzx0OUbW2qn5wP84yfOxGfP+z6?=
 =?us-ascii?Q?v1Zv9xZZfoLj4TxF3v5TZ11VcUkNSWaO7ay+6y26vFpNQR/qVkbgnw+yTtWo?=
 =?us-ascii?Q?IYff6orjaM/vCYFj8dMKXX9KE0BNu3zxeTQQfuYf2BpQwokVjWUjUhU26UiZ?=
 =?us-ascii?Q?TH7tF28oS0ysF1qDbDXQc5DqKuSyNj8D24j9ugk8YLs084OJ1SdvPyZd1sPn?=
 =?us-ascii?Q?P8byNEULk363pso=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:06:47.2798
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ac2bed4f-2a07-4f1f-f89f-08dd518585dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW6PR12MB9020

Extend IPv4 FIB rules to match on DSCP using a mask. The mask is only
set in rules that match on DSCP (not TOS) and initialized to cover the
entire DSCP field if the mask attribute is not specified.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/fib_rules.c | 47 +++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 6b3d6a957822..fa58d6620ed6 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -37,6 +37,7 @@ struct fib4_rule {
 	u8			dst_len;
 	u8			src_len;
 	dscp_t			dscp;
+	dscp_t			dscp_mask;
 	u8			dscp_full:1;	/* DSCP or TOS selector */
 	__be32			src;
 	__be32			srcmask;
@@ -192,7 +193,8 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_match(struct fib_rule *rule,
 	 * to mask the upper three DSCP bits prior to matching to maintain
 	 * legacy behavior.
 	 */
-	if (r->dscp_full && r->dscp != inet_dsfield_to_dscp(fl4->flowi4_tos))
+	if (r->dscp_full &&
+	    (r->dscp ^ inet_dsfield_to_dscp(fl4->flowi4_tos)) & r->dscp_mask)
 		return 0;
 	else if (!r->dscp_full && r->dscp &&
 		 !fib_dscp_masked_match(r->dscp, fl4))
@@ -235,11 +237,35 @@ static int fib4_nl2rule_dscp(const struct nlattr *nla, struct fib4_rule *rule4,
 	}
 
 	rule4->dscp = inet_dsfield_to_dscp(nla_get_u8(nla) << 2);
+	rule4->dscp_mask = inet_dsfield_to_dscp(INET_DSCP_MASK);
 	rule4->dscp_full = true;
 
 	return 0;
 }
 
+static int fib4_nl2rule_dscp_mask(const struct nlattr *nla,
+				  struct fib4_rule *rule4,
+				  struct netlink_ext_ack *extack)
+{
+	dscp_t dscp_mask;
+
+	if (!rule4->dscp_full) {
+		NL_SET_ERR_MSG_ATTR(extack, nla,
+				    "Cannot specify DSCP mask without DSCP value");
+		return -EINVAL;
+	}
+
+	dscp_mask = inet_dsfield_to_dscp(nla_get_u8(nla) << 2);
+	if (rule4->dscp & ~dscp_mask) {
+		NL_SET_ERR_MSG_ATTR(extack, nla, "Invalid DSCP mask");
+		return -EINVAL;
+	}
+
+	rule4->dscp_mask = dscp_mask;
+
+	return 0;
+}
+
 static int fib4_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 			       struct fib_rule_hdr *frh,
 			       struct nlattr **tb,
@@ -271,6 +297,10 @@ static int fib4_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 	    fib4_nl2rule_dscp(tb[FRA_DSCP], rule4, extack) < 0)
 		goto errout;
 
+	if (tb[FRA_DSCP_MASK] &&
+	    fib4_nl2rule_dscp_mask(tb[FRA_DSCP_MASK], rule4, extack) < 0)
+		goto errout;
+
 	/* split local/main if they are not already split */
 	err = fib_unmerge(net);
 	if (err)
@@ -366,6 +396,14 @@ static int fib4_rule_compare(struct fib_rule *rule, struct fib_rule_hdr *frh,
 			return 0;
 	}
 
+	if (tb[FRA_DSCP_MASK]) {
+		dscp_t dscp_mask;
+
+		dscp_mask = inet_dsfield_to_dscp(nla_get_u8(tb[FRA_DSCP_MASK]) << 2);
+		if (!rule4->dscp_full || rule4->dscp_mask != dscp_mask)
+			return 0;
+	}
+
 #ifdef CONFIG_IP_ROUTE_CLASSID
 	if (tb[FRA_FLOW] && (rule4->tclassid != nla_get_u32(tb[FRA_FLOW])))
 		return 0;
@@ -391,7 +429,9 @@ static int fib4_rule_fill(struct fib_rule *rule, struct sk_buff *skb,
 	if (rule4->dscp_full) {
 		frh->tos = 0;
 		if (nla_put_u8(skb, FRA_DSCP,
-			       inet_dscp_to_dsfield(rule4->dscp) >> 2))
+			       inet_dscp_to_dsfield(rule4->dscp) >> 2) ||
+		    nla_put_u8(skb, FRA_DSCP_MASK,
+			       inet_dscp_to_dsfield(rule4->dscp_mask) >> 2))
 			goto nla_put_failure;
 	} else {
 		frh->tos = inet_dscp_to_dsfield(rule4->dscp);
@@ -418,7 +458,8 @@ static size_t fib4_rule_nlmsg_payload(struct fib_rule *rule)
 	return nla_total_size(4) /* dst */
 	       + nla_total_size(4) /* src */
 	       + nla_total_size(4) /* flow */
-	       + nla_total_size(1); /* dscp */
+	       + nla_total_size(1) /* dscp */
+	       + nla_total_size(1); /* dscp mask */
 }
 
 static void fib4_rule_flush_cache(struct fib_rules_ops *ops)
-- 
2.48.1



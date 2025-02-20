Return-Path: <netdev+bounces-168038-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18968A3D2CA
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:07:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00DD71898BEE
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:07:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26CC51EA7E8;
	Thu, 20 Feb 2025 08:06:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="I2crY0RX"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7416A1E9B12
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 08:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038818; cv=fail; b=GY0OnymTKroE1EAvymCDKuR74vWXZwxrTEwveeF2SrMcu7Ds1aEk2KkHebCKG/Il5H+NDI1ozf2iw6IPM3y9eHhOXJrFsGs8SBAE9T7XEgxet5TA3buw/MPYY58H8oJry7tdqChxBF+yhnnLjtA29fc398DJK8MLr0pqT8EGk/c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038818; c=relaxed/simple;
	bh=qX7nlDxRNhXn/pVbxpd4X1B5pz38of0PW4XUBCaIXmI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nlafZP9buWombPMap7wweMb1KvWT37mNDI3EuVR4bV0B5YsKbZOItaDawyKg9zP0dWht/A0e3wAO/dDp8PKB0vUdLkFNqNHFddV0Bu9QXaDdVuoIK51ioheHBfHR3ywYTnc3m8VHWtOO3ajBwO39umeJuHmltbM0NXIT4zv9/y0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=I2crY0RX; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YFq0v0GbtNXitx9ziai1CSfKBnWTmfLQacvsdUFE1vZ3TlDowNNPu2Cv52s7eJzU8n0sss5djUQoWPeT1Z42N2drZcfcF/Zs7Mop+L2WtGo9YknHGkOxGdd45Al8h1ClMsBz2/v6l9Xp+mBykSKnnrc0HjzPR3+CRZY9rOmdlKRn5YlKm+wi8b457o5K98NXuVZiKOoht1sH/Ag6Zhy0acrUtX71y4ZLd1ZoCyR8vsXB/AKwtSs0BExQE2ZhntAdksbsP+2+/DbpiU05iWInylQyJRbesu9SE7wOH7Ou/Se/9XnOfV1XT84Jme3ZkUSY7omBW8UfMYuFjSv74qyfyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HTEDS9tVGAFJnsupOUTTrjaaZV8GiTdK8VJTqXQVQk8=;
 b=w5HXYtoWmesiFUWhWvf2Cx8dMqFJpinBVcZ1pRVg/X41sw5uanP9hTH2VkTGNyRBISocaQegIq1lqAWQElUiNNSyHGdOUgKdF/cl7wTeVcmDxR9ziBSJyaKvUxUH0B5cXURm3BXfM0hf3tGC0rwum1L5yBi5DQzjn/J65VF86gC+GMWkA3PR3WCP6OJTSeilk946p5qz5WfQ1uHyTg9HqEZs3LbEg22NQDQ4T3SPleYEFl//3ho929Fp5WOVlPZki6f+spMPHqmOVlS1TNBtuRMWWfnyUYNy9kfb3dC38th101XibcO7ugULCmCx7ftkHxW4SSPyY7ttUs54ihdXOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HTEDS9tVGAFJnsupOUTTrjaaZV8GiTdK8VJTqXQVQk8=;
 b=I2crY0RX9Oxn8JozSgZ/GqJ9xcnDhQNXZzbR44mYAGGcrL+IYN89wVICdwYtZaoTM8erIPyWFjMgMQQork981Uo1kJ9QNfbac0I0oGoxDP10u87xSQFUNqkBARIqo/s54AIVBSeIz4Uue3A7rHf9uSLvjaWFBXWZI3gx+GS4J9dZequqGb/dTNzzjnnUAakkv7V+aL3kH2FcIbPu28zCBcH9zFJvlkv4ZnL28TxGmaLPQzOXIzSLfe1H+tfahWdL4nmZ2xQIp4eUIdGYiGvFOiMU+Y7cn4SL5JKplLuTSKfQDMMAdqTQMCITz0q1OAqYTjRi1aOoUESH/+1kSiFEBQ==
Received: from BL1PR13CA0308.namprd13.prod.outlook.com (2603:10b6:208:2c1::13)
 by CY5PR12MB6348.namprd12.prod.outlook.com (2603:10b6:930:f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 08:06:53 +0000
Received: from BL6PEPF00022570.namprd02.prod.outlook.com
 (2603:10b6:208:2c1:cafe::a8) by BL1PR13CA0308.outlook.office365.com
 (2603:10b6:208:2c1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.14 via Frontend Transport; Thu,
 20 Feb 2025 08:06:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF00022570.mail.protection.outlook.com (10.167.249.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:06:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 00:06:37 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 00:06:34 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 3/6] ipv6: fib_rules: Add DSCP mask matching
Date: Thu, 20 Feb 2025 10:05:22 +0200
Message-ID: <20250220080525.831924-4-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00022570:EE_|CY5PR12MB6348:EE_
X-MS-Office365-Filtering-Correlation-Id: be70cff4-4108-4590-0e12-08dd518588fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?5aHzw7FHtk7NK+vmO+p7iljz7AH/YEU5ziNA9jYHKirfFywr2ULt0eSVCpxz?=
 =?us-ascii?Q?QOZI16uizcLl/Dj2xGBr+PoTw+XewfJu+ABNEq5TfeuGdQIQRWbzLdC6OyDG?=
 =?us-ascii?Q?oex8K+QivdW4gsEB6wCVzvbZf5Dmzb1K9myVtaHloAWz96jKQbQlCbvNqB2y?=
 =?us-ascii?Q?X5Jvrdmt2aZ9mlBb8YwnsyW88gBKopQ7UKjmTI3q/LNbRXeEzUn2PethI2Xx?=
 =?us-ascii?Q?DquaklNGE+LJQ/rr0hPheD+A+i5KBKBcdDRCYsNQEzeTsJlslQQRqCd9AHiA?=
 =?us-ascii?Q?7l9UXY5hjw+kQthP4BM7b/981rIaLBTRByviB+jSiZ1Ix1HovHRkQKklS6kY?=
 =?us-ascii?Q?/hsf3vMcGDF78DGbK5OzUxqSVwIB6iwlkQtPY+bEV0i4LmKCwddmA+MiHGO+?=
 =?us-ascii?Q?gryHtfNdUqrYfEQ9p6SBdFEBizxZG6HTPhmjpwz7j+mOjgoA+wAlPDWeuNtO?=
 =?us-ascii?Q?qTacRPIKvIewpQwNGR4WkZttahzi4915ZMjOIOJWpkSEtSGSjDdqoUDYtN4J?=
 =?us-ascii?Q?G8TRTlavFcdlCuT7EsmlErgHwKRtXxa+idAkJQU+FFI5XDcbaDGhq4AdLy0J?=
 =?us-ascii?Q?0SNeLToSPbwHZI/kb9OXoAIRVfs+NhM7NYpPbSnL0GOKEZwLwUxGbmG+dxbp?=
 =?us-ascii?Q?DCgCfSWpuwu4gpbqWhq75uldt01glzewmkzf5P0MfERHZyV941nBQv0TIHa6?=
 =?us-ascii?Q?QEwdHUB0Hy/tJDGwdSul4YXFqpJs+YTghXb2r8805AxwXQrukwRv2laH34F/?=
 =?us-ascii?Q?TFljtIogD4NMyszwi70gs4AygsNIkV7e59U7GhXJ1sFa0CTlh0UZ6A1ODCEp?=
 =?us-ascii?Q?1X1VNmgVFGcdvEIMIjKrxpk7qkBkX+4TXoCakcnHP1SREiKpKflHCTSafZvO?=
 =?us-ascii?Q?AuXi9Bs9OJCKqqw/IBrque/aHrDOhbSJj2SbEtS0ik5NfjmT6z0x6Y+/69bG?=
 =?us-ascii?Q?dzmihDGWSPlDIoEmkR9fR0Lrf0HCcy/v8+pxvEcKVAjn4yhdlhlfPVyA3N5F?=
 =?us-ascii?Q?dEDjGmwbAND9SiJhRkBKaTbrMcW/ZWzTwJVXSfcXVtuxJFajFMIuBl1Ug3/F?=
 =?us-ascii?Q?xVhXct+3MBJBddx2m5MRRJC88isHdZl7owLDBzoqBcck6Tku9STc+LA5g9Yn?=
 =?us-ascii?Q?ioCRxU1BbPaZTk81gshjZ+YtzGMwf2Metf9EATazemL5FfjWL5OjbWdaXcy+?=
 =?us-ascii?Q?l6ZNjqvUuIxmrL7ruANL5qU0dT3n2fHAb1h+aMuLzAVkOHQwrkfI5/ts/Cli?=
 =?us-ascii?Q?CfnkiWmY7342cpG3bswhH2CDC2HlmKrYsPBTbgIVAs3fAZIUtCw0ZJMSacsz?=
 =?us-ascii?Q?JIOaf9LEaYHUhOXxA2lR9o/Ijdb82JdqaURAWkEh8rPoHyv3RaCx7SQvmzPv?=
 =?us-ascii?Q?xTegPhXTOexvcXyQub7/NXpVA7SFFThYsv4YxjAJ/+uUPboBmKV3XQLaPW3l?=
 =?us-ascii?Q?HS6qiBUDJTFvdPLBV/drZEJuUNkCCxBKHc6DG8Pnn/uzKePvugto1vBE0k/r?=
 =?us-ascii?Q?TFg/KIp76XWa/DY=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:06:52.5298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be70cff4-4108-4590-0e12-08dd518588fe
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00022570.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6348

Extend IPv6 FIB rules to match on DSCP using a mask. Unlike IPv4, also
initialize the DSCP mask when a non-zero 'tos' is specified as there is
no difference in matching between 'tos' and 'dscp'. As a side effect,
this makes it possible to match on 'dscp 0', like in IPv4.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/fib6_rules.c | 45 +++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 43 insertions(+), 2 deletions(-)

diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 0144d01417d9..fd5f7112a51f 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -29,6 +29,7 @@ struct fib6_rule {
 	__be32			flowlabel;
 	__be32			flowlabel_mask;
 	dscp_t			dscp;
+	dscp_t			dscp_mask;
 	u8			dscp_full:1;	/* DSCP or TOS selector */
 };
 
@@ -331,7 +332,7 @@ INDIRECT_CALLABLE_SCOPE int fib6_rule_match(struct fib_rule *rule,
 			return 0;
 	}
 
-	if (r->dscp && r->dscp != ip6_dscp(fl6->flowlabel))
+	if ((r->dscp ^ ip6_dscp(fl6->flowlabel)) & r->dscp_mask)
 		return 0;
 
 	if ((r->flowlabel ^ flowi6_get_flowlabel(fl6)) & r->flowlabel_mask)
@@ -360,11 +361,35 @@ static int fib6_nl2rule_dscp(const struct nlattr *nla, struct fib6_rule *rule6,
 	}
 
 	rule6->dscp = inet_dsfield_to_dscp(nla_get_u8(nla) << 2);
+	rule6->dscp_mask = inet_dsfield_to_dscp(INET_DSCP_MASK);
 	rule6->dscp_full = true;
 
 	return 0;
 }
 
+static int fib6_nl2rule_dscp_mask(const struct nlattr *nla,
+				  struct fib6_rule *rule6,
+				  struct netlink_ext_ack *extack)
+{
+	dscp_t dscp_mask;
+
+	if (!rule6->dscp_full) {
+		NL_SET_ERR_MSG_ATTR(extack, nla,
+				    "Cannot specify DSCP mask without DSCP value");
+		return -EINVAL;
+	}
+
+	dscp_mask = inet_dsfield_to_dscp(nla_get_u8(nla) << 2);
+	if (rule6->dscp & ~dscp_mask) {
+		NL_SET_ERR_MSG_ATTR(extack, nla, "Invalid DSCP mask");
+		return -EINVAL;
+	}
+
+	rule6->dscp_mask = dscp_mask;
+
+	return 0;
+}
+
 static int fib6_nl2rule_flowlabel(struct nlattr **tb, struct fib6_rule *rule6,
 				  struct netlink_ext_ack *extack)
 {
@@ -409,10 +434,15 @@ static int fib6_rule_configure(struct fib_rule *rule, struct sk_buff *skb,
 		goto errout;
 	}
 	rule6->dscp = inet_dsfield_to_dscp(frh->tos);
+	rule6->dscp_mask = frh->tos ? inet_dsfield_to_dscp(INET_DSCP_MASK) : 0;
 
 	if (tb[FRA_DSCP] && fib6_nl2rule_dscp(tb[FRA_DSCP], rule6, extack) < 0)
 		goto errout;
 
+	if (tb[FRA_DSCP_MASK] &&
+	    fib6_nl2rule_dscp_mask(tb[FRA_DSCP_MASK], rule6, extack) < 0)
+		goto errout;
+
 	if ((tb[FRA_FLOWLABEL] || tb[FRA_FLOWLABEL_MASK]) &&
 	    fib6_nl2rule_flowlabel(tb, rule6, extack) < 0)
 		goto errout;
@@ -482,6 +512,14 @@ static int fib6_rule_compare(struct fib_rule *rule, struct fib_rule_hdr *frh,
 			return 0;
 	}
 
+	if (tb[FRA_DSCP_MASK]) {
+		dscp_t dscp_mask;
+
+		dscp_mask = inet_dsfield_to_dscp(nla_get_u8(tb[FRA_DSCP_MASK]) << 2);
+		if (!rule6->dscp_full || rule6->dscp_mask != dscp_mask)
+			return 0;
+	}
+
 	if (tb[FRA_FLOWLABEL] &&
 	    nla_get_be32(tb[FRA_FLOWLABEL]) != rule6->flowlabel)
 		return 0;
@@ -512,7 +550,9 @@ static int fib6_rule_fill(struct fib_rule *rule, struct sk_buff *skb,
 	if (rule6->dscp_full) {
 		frh->tos = 0;
 		if (nla_put_u8(skb, FRA_DSCP,
-			       inet_dscp_to_dsfield(rule6->dscp) >> 2))
+			       inet_dscp_to_dsfield(rule6->dscp) >> 2) ||
+		    nla_put_u8(skb, FRA_DSCP_MASK,
+			       inet_dscp_to_dsfield(rule6->dscp_mask) >> 2))
 			goto nla_put_failure;
 	} else {
 		frh->tos = inet_dscp_to_dsfield(rule6->dscp);
@@ -539,6 +579,7 @@ static size_t fib6_rule_nlmsg_payload(struct fib_rule *rule)
 	return nla_total_size(16) /* dst */
 	       + nla_total_size(16) /* src */
 	       + nla_total_size(1) /* dscp */
+	       + nla_total_size(1) /* dscp mask */
 	       + nla_total_size(4) /* flowlabel */
 	       + nla_total_size(4); /* flowlabel mask */
 }
-- 
2.48.1



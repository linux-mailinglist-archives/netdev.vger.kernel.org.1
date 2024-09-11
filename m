Return-Path: <netdev+bounces-127311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 18FAC974ECB
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 385621C22589
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA41D17C21B;
	Wed, 11 Sep 2024 09:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ripSTK0K"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2086.outbound.protection.outlook.com [40.107.92.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F82417C7CA
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047518; cv=fail; b=pwrTgQWYePgoAY6XCxXpIifZAVAr79I6ssv8a0HCKiXjQB7HIqpxDeMinVOzURuoh3dTZLlfthKIrhLY5pjPsXS4HfdqR0GbEpgJ8FUL+ZAhBSXl3tsfU7eexHsaTPfpMTOqJY5Qo+XLXYIdGmi3/gUvZfkT1HwX0ZD6IYFOavU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047518; c=relaxed/simple;
	bh=460hLHpl9Zz7UNh2JtjQGjqothUXaYVB6xDvr3qC7No=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lejhjDFuSX1hWVQaa7i9wfFEMuSBKs03Ld+9bl+v8NG6914XMJr7L19rTmZe+rYU1uyVJdkLFuo30T5OexjgEqfe3fC1xxaGYSdUBI2XJg24zNAEjxFAA419RuJ6qCX6+O/hz/8GECiusx96EpLeIYfLvl/RbdtpSNNDHb4uqXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ripSTK0K; arc=fail smtp.client-ip=40.107.92.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Sl0hDYifyuK2IaA3rwJbryP7MBX9VjWQMe1+xR18x+Mfep0XmNNlPN12JYpFqcnzWTq2h4elT1A8c9xRYCPX2czaHdIQRNwZY8ghd8YxyMC9XA2fsOfO9Iy72yLph/118V4n/UYpOjQCykCBEQluJe+hR9VPJWNE4fO+GcitA+uUj1/zSNa4jKn9v6m6gzTmFtN6a3l0r2382joSlNHUYOUNAknSSrya7MlQjXQQzPNuonjLSrXMlCo2SyVckZcoxSdbVoBrEpDDQCdClSLupWSibjQ+Vq1b1FpV3zZ6O8IQ2JW7raNyrhw7ZvXq+gr74V1Reha4mkZhbHFgMey4+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yHHOF5VS+8rv4qPrXstPPcwy4PYrsM+LX6piabpaCLE=;
 b=d2Byp5pWDKTYvHKtOpIJv18udnJ7CUxyMlDB2kiRjN5I71qWEToVwuDdNpJinlTgyoD8hS53GIotLYQoS2V8+mNyj0bUVCC9HuHKYJO8QZ255VRa27v5o0fwIk/v3KrT65QS2andPvHjrwI+ipJYtdRcWeKC+UodP00pD7QLAWWrCvm4+zTyv80USPD1zHKjb/MDKlecnHOIB2zm28tcCUQG9BcAB2hmh5Z2pd3/A9XLUCL+0rn0S2c7Jk2MC+YpBNvU5crngUprYjy2cgnVecdWo/y5bXSzHdy56IxsstJce96BDCzIEy54yJJrkf0zOHLzTuhiJhJJ5yP87YAnvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yHHOF5VS+8rv4qPrXstPPcwy4PYrsM+LX6piabpaCLE=;
 b=ripSTK0K66gtD1hcpgJh99dcCQ9blZMKN5IVnAVnISbyG33edbroA5lk9ZXXI+A8cP6v64pKLwz6I5//tQTdwlo1aduLqXo02WZC8WJlvhR+PgK+/pdHVZeYjXGXvN0Nnz9GSvsDMI+4aBX5Q7f84wkWT35BtSRR/PSyYJ0r1cOhpetqP2J8V1VB1PHOHY95MGBDnDH8SpqpWrwTYyCfUWwXEqwu1JAJDRsxPR/ONxwTeR+vbc9hePRvvhxXpbc1SkBAwp+0YPFVGj1UVPOgXknfch97AEKHMmUeZ2YczW7R6+70qoIdA2D8uBaOpxEnfi5G0p0a9bw0a5NXUPz3tw==
Received: from MW4PR04CA0298.namprd04.prod.outlook.com (2603:10b6:303:89::33)
 by CYXPR12MB9337.namprd12.prod.outlook.com (2603:10b6:930:d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.20; Wed, 11 Sep
 2024 09:38:30 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:303:89:cafe::23) by MW4PR04CA0298.outlook.office365.com
 (2603:10b6:303:89::33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.24 via Frontend
 Transport; Wed, 11 Sep 2024 09:38:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 09:38:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 02:38:14 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 02:38:10 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next 1/6] net: fib_rules: Add DSCP selector attribute
Date: Wed, 11 Sep 2024 12:37:43 +0300
Message-ID: <20240911093748.3662015-2-idosch@nvidia.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240911093748.3662015-1-idosch@nvidia.com>
References: <20240911093748.3662015-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|CYXPR12MB9337:EE_
X-MS-Office365-Filtering-Correlation-Id: b6079ca1-45fb-4d08-1fe9-08dcd2457f09
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cXChPQ6zK0Qw5cZgqHY6uti+F0fx+yVhUr8x+EUracLYMJP37xhLmi7/y8DI?=
 =?us-ascii?Q?3ueera4x8UPyeBHLI7EvUWjTt56FxNe3vQBw/TC7YTFN45eAUfPv+CrU8Yox?=
 =?us-ascii?Q?pXc/TkbjXgO/5uTpRcr19w7e7sfKc13Mt56tL2BQF5dPW4HrOOlWiwpQLf71?=
 =?us-ascii?Q?I/TZ70FC+s3QMGzj0iggHkHZriAU5gEei/5MsKZcF3bTFl+11fmu2ZeXVx1K?=
 =?us-ascii?Q?NsqsEt93KgzOKYE2tIh2HcjG0ycPG7yOgbi95guH42HjSxsDwrkX93LUPyhQ?=
 =?us-ascii?Q?mpPaAnjYJ1vQ5uG9VyX7GXKLiGQ8Fu1EAZcS3N5WGTe6AJ9DAbhJ24jyvz4o?=
 =?us-ascii?Q?8sko5rUPUK4s0feLW+NjwboPgQLx4YzgC7PDRgENGZqtAqDbpIADfSFlBfUP?=
 =?us-ascii?Q?TI3NQ2kMDqdB7cm18EJZhWFiHGc5EqZ+d6Ut/vIlSs7XbA1fm980veMybXmx?=
 =?us-ascii?Q?eipGaI8R0YF+AgjMcd6BTlogx5YD5HxaTuuIO77RiiEMEotfdcDSUU/2FPmi?=
 =?us-ascii?Q?jue3CpxssDS3IQwXLG5B11ibkS28BH0YDN8wBy4VsTomhcyv/VkaD1BJ1mwD?=
 =?us-ascii?Q?laJk58XxKBrGftSHso+xtihWYVtqttEOTfkGlDAZuAtGIG71k26W2lCpcwwR?=
 =?us-ascii?Q?vEdCg2f07Lm01OB4P6h1A5Yn1u2ICQOO1AGyg+LrendLmDkgXVo6pLIGx/Qq?=
 =?us-ascii?Q?erxmtqk0ZTyzDsd7HqkwaPzO+e43CHoAFUVVk8vm03oyGhD3MH/TiiXeF4df?=
 =?us-ascii?Q?3FjkLL6HQ+ae5npRGuby080e9eXW3G5VSOsA9eDV83z3s9hupzkXqhooqn7J?=
 =?us-ascii?Q?BLmmZh4KkhtTUlGbiKw8EYi9Ym/+spRZ/dKjKt4DVnNaJWy8kNr7517BOFvT?=
 =?us-ascii?Q?TRMHP6ruhgVHTsdmvHx7F9qZ62Ohmibiu4CGEvqqBGcPbx7ayboEBoWeJxQe?=
 =?us-ascii?Q?Db3h+5ww5BqX7haqeyw68PfeJCHVK4O4pjAEzKeKxcfIi+r2oUov3pGQiVw8?=
 =?us-ascii?Q?JrQdaQN3wPrAWs5DR8w5m8pEH9K5821i/vUDArIc3M9ZjktScN4Xq33hy3N8?=
 =?us-ascii?Q?vOBs6BFTojFekU9N4aCaXinlRrT8BjfiddmP20z+oFHjHle8+71qGmIbiqpN?=
 =?us-ascii?Q?+/K12ZvDI45rSUvlmczXF7tYiP+bvyYsiISuxagMjSpC7rHZFUT0Rhv1xQw+?=
 =?us-ascii?Q?EFsQJaPrsM7N/rOnA65CA2as//HeF4UC88kAHYxkct07vuRpQcqu2yVAsLko?=
 =?us-ascii?Q?k7jakUfJl6JcunGF+mMn49/vGVv+4RNkGOcRaleGSAF3/c8VDC1/PzhjxIuP?=
 =?us-ascii?Q?daLwHcBLqZ6UwJv1GevHzUpamSFote2RMeN9MHjSBgwPEmexGfakRUz0FJat?=
 =?us-ascii?Q?lkDQCfy4v0Q9ptjNB3cAxSfH98StUsm/JIs9IlEZhcoF0NTZh7a/+J3udv/B?=
 =?us-ascii?Q?y8EnzUKNBIAjNtyZ9QhnowSdV0XnxkNs?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 09:38:30.4711
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6079ca1-45fb-4d08-1fe9-08dcd2457f09
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9337

The FIB rule TOS selector is implemented differently between IPv4 and
IPv6. In IPv4 it is used to match on the three "Type of Services" bits
specified in RFC 791, while in IPv6 is it is used to match on the six
DSCP bits specified in RFC 2474.

Add a new FIB rule attribute to allow matching on DSCP. The attribute
will be used to implement a 'dscp' selector in ip-rule with a consistent
behavior between IPv4 and IPv6.

For now, set the type of the attribute to 'NLA_REJECT' so that user
space will not be able to configure it. This restriction will be lifted
once both IPv4 and IPv6 support the new attribute.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/uapi/linux/fib_rules.h | 1 +
 net/core/fib_rules.c           | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/fib_rules.h b/include/uapi/linux/fib_rules.h
index 232df14e1287..a6924dd3aff1 100644
--- a/include/uapi/linux/fib_rules.h
+++ b/include/uapi/linux/fib_rules.h
@@ -67,6 +67,7 @@ enum {
 	FRA_IP_PROTO,	/* ip proto */
 	FRA_SPORT_RANGE, /* sport */
 	FRA_DPORT_RANGE, /* dport */
+	FRA_DSCP,	/* dscp */
 	__FRA_MAX
 };
 
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 5a4eb744758c..df41c05f7234 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -766,7 +766,8 @@ static const struct nla_policy fib_rule_policy[FRA_MAX + 1] = {
 	[FRA_PROTOCOL]  = { .type = NLA_U8 },
 	[FRA_IP_PROTO]  = { .type = NLA_U8 },
 	[FRA_SPORT_RANGE] = { .len = sizeof(struct fib_rule_port_range) },
-	[FRA_DPORT_RANGE] = { .len = sizeof(struct fib_rule_port_range) }
+	[FRA_DPORT_RANGE] = { .len = sizeof(struct fib_rule_port_range) },
+	[FRA_DSCP]	= { .type = NLA_REJECT },
 };
 
 int fib_nl_newrule(struct sk_buff *skb, struct nlmsghdr *nlh,
-- 
2.46.0



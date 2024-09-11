Return-Path: <netdev+bounces-127313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23B8C974ECF
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 11:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 488D51C216F7
	for <lists+netdev@lfdr.de>; Wed, 11 Sep 2024 09:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1B314D2A6;
	Wed, 11 Sep 2024 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nX5a9UV9"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2061.outbound.protection.outlook.com [40.107.237.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28717181BA8
	for <netdev@vger.kernel.org>; Wed, 11 Sep 2024 09:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726047528; cv=fail; b=PiHAVUHZ7Jc8w2zaaC9e1mEwqlqklhthfKJ0O4LwhpP3aKNWaj0+Tqd3ACHYjJ6Yx1eHvQPkS/ImM+kLJBRWVoxlKMJjk0sr2wdVTqD9+5H16MDIb0tquCg6SVBxRZh1OFzYwYL5yMk5YKS0qMUOUQppcB06djMl4MBw/O+fFpw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726047528; c=relaxed/simple;
	bh=jOAiT0XhZuZlUVZZ+2lwK6oKrzLcZKoAMWa/1aBE6cQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aHeAvpQRaCuXAjoaEpi+9K/90DmTiz0DcniOHv5q2dzZFbBN+n74J16kqxlZUWHYLfXzWfohjput8qI11FZF36cDuQOagGwoG7Sv5t8WnRKn/0H6bqSb/cl9ogRZM19q4L+GBOmwT5I1ukWDJ/PL+uhZvyfDNobv06S16i4kZhU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nX5a9UV9; arc=fail smtp.client-ip=40.107.237.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evLDvebyVQflUwcg7aEMMYhih/m2ChfdaMZU/Xs5sfckLqzIACxBAdDcusvKmESufZpNSPF4kh+0X/JdLVKkm3LAFFJ4JkeXxWlUw0eFsQp4LToBZbeWtp/VkkKepinQFkIfQ/k44ZouDzz9E50CjCMuWOYrmyFBZhwmUJVYD+7bEV3ZBg7/SLfWibk+2VE41MVP8+qVXOLoGYFXlJng6peDt6lQ1d6acnSzjH6BlKQ1eSPM0q+ZQwKMXF5OTq+B/k7URgfFlLKgXPIwik+TczSL8/ZhiBIW0ee9npf/crzTMgziYyip/Phiaha30o1DqG/lKftpT2bPt3qp6a447g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ceLCkuHWInp6FzsVDZszeherwXuiU1lsIkyYtYZlX+k=;
 b=sZo7UmWPT/URiXAZuJ+K3hu/eP+yKOcattjGAvg5QQEIsYfVzXjs0yvhy0WcSOOiIkc8ufTH4EOclcGlA8vvqxnY8qbll3FUtsYmjqmO/3KwQKAbELe+hhb+XhZWxcsE0JDjy0gq6Csf+Lduozy4Oz0M5LM/+Oz9t2HIy+1u5n7NkJeUxPf53fIMyiB2pn20eiPf8QXWNDm+VCQsg/7Yf6lEX9LSApyOakFOnxdCLnQtQyncbaHkICpp5YwG0xIYDZKbOrS+c+PR26rNeZWGZKwg2QmiLyguv6DSbTdgRGDDi2PZLr9hk5esKW540OX189QB8hPmcST8r3J+zE1WAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ceLCkuHWInp6FzsVDZszeherwXuiU1lsIkyYtYZlX+k=;
 b=nX5a9UV9Rdm5lcECwdtrIW0MfQJ+lBH7w86T3L+yzDThK0UbLFffO1uCmffSz87zcTKWvsk98rVG9pF+V/43wwJqeeihacLTiXmYq9+ikxbNmjgBuEZoD8lJ2MXSsFXWpY4xlX2Oe7Z8QuVdw6kcRedxDYQpz1NK8gC2q73/x6xh/Rd3el3IJTqGkU7dygjW71PZNdNv06cpJmU2FXA2AI2+62O7GINieecUDuwEaySACDjAjuT88un+YaYh0gkqrRPCT+0WT64Tk7/Y+wrmbyw9XABFXZnbNB87WnB31KmMHBjQA0P4gp5HdiNDsCJm4JATugA3/f79P1G1geZEzw==
Received: from PH2PEPF00003857.namprd17.prod.outlook.com (2603:10b6:518:1::79)
 by CH3PR12MB9079.namprd12.prod.outlook.com (2603:10b6:610:1a1::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.17; Wed, 11 Sep
 2024 09:38:40 +0000
Received: from MWH0EPF000A6732.namprd04.prod.outlook.com
 (2a01:111:f403:c91d::1) by PH2PEPF00003857.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.24 via Frontend
 Transport; Wed, 11 Sep 2024 09:38:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A6732.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.13 via Frontend Transport; Wed, 11 Sep 2024 09:38:40 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 02:38:25 -0700
Received: from shredder.lan (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 11 Sep
 2024 02:38:20 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net-next 4/6] net: fib_rules: Enable DSCP selector usage
Date: Wed, 11 Sep 2024 12:37:46 +0300
Message-ID: <20240911093748.3662015-5-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6732:EE_|CH3PR12MB9079:EE_
X-MS-Office365-Filtering-Correlation-Id: b2dfe5b7-26f6-47a1-e855-08dcd24584d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?wWwrDEz7OyhMv6lykXKQQy7E0V4dLDELz6hdnFknLismuFMBCpLCR3ml5JJV?=
 =?us-ascii?Q?waKA0x3uSpvTP5zkJx1J4DsTg22prqOrQPOtdqT6cSTnxt8xJc7Mcx2o9qLw?=
 =?us-ascii?Q?9cneD9ZfQoaCwuKQ7hH4iHxZO/he82iLLFMJWbAB9CMLDZ8DRW7l1sFGHqdh?=
 =?us-ascii?Q?fZGir5yCOs3fiarCP0sThD1lE0FYmtDUu0uZOG90rRFL0DPrer5TtI3kvMW1?=
 =?us-ascii?Q?xmzJX4PL0Q3G3JM5Hj+2r8DZmneFdYooD2jyYBEjlJ+sGDAbKJhzBohzc41T?=
 =?us-ascii?Q?cuUsgksubpuz6Gv9Bjt4ZBYns0W1SMR3qnzmxFDZbjgCFFR2IjcdYbUMPgly?=
 =?us-ascii?Q?pXYZcV8JrfnQHCo5JRyXzRo1011xxlUL6N9APxekQq26kdAmC5OvDCDQZytY?=
 =?us-ascii?Q?876WW7mfCREDjOUshrWTgSJh1hyqmQ80IIWT5GmSbNoMzdA7mV+vnGpqCtPt?=
 =?us-ascii?Q?55gZ7csDLnnbebXc8A0VDz+gxwY3sv+RFID29GxMbrzL20s4brf79bBxqetQ?=
 =?us-ascii?Q?VDAdYt6QUCfimk3svWL7a2Q3rMaHWPMDAlISBGxlLd356pSKzbiLrS7n9n3F?=
 =?us-ascii?Q?FVL/oxtpP1iNxOuEPpO0RmY1kaIAM+O/IfW3zcfZ21KAZsQe9vYyQeMM7COH?=
 =?us-ascii?Q?Zdn/CMHlb6Ac2ABT14mSTxBv9J31QT6ZWmr2CH23hR79ox19UaBTMdmWFXMy?=
 =?us-ascii?Q?g2aKG5jIJR6vS4d/Bggp9GRFRek+nLoXmFful2F5EmEKyqpLspgwS8z8dFFm?=
 =?us-ascii?Q?lyEStWZm/92CQ1l7AY/UbMFUY9xpPz4WzqSB8Hlm+daRAgmO9ioG5UuyCBmI?=
 =?us-ascii?Q?YWoUSTXElNzoXggVjn4mZ25lEaFuIDnlBxPQLBgeazMykGAp68LAWY7doXup?=
 =?us-ascii?Q?i/3wn6dtdwL+GaWG1bZLnb1KcZ5pQL5vQnS21sV72xCDICUQVngEUkr4jNHF?=
 =?us-ascii?Q?YThYj1i6CRP+gMWPCizC1Z9qwckJIxtv9la+GnSokkETkZsUPwWNeg+mH65/?=
 =?us-ascii?Q?nAD4v8YopwxCWQqPl6D/ZvAN9B3xvWljgtGygDBwWs5diNp0JgZUUZ2bhWc1?=
 =?us-ascii?Q?JZPjgNl4Bu9fMpaVGVDdF3bxO43aJIkLvTCWVjOfygIw5At6AP0mRWoSYoS3?=
 =?us-ascii?Q?L6e8/kCFKmLnthibhBspwuywaOjQeHNHuL+EoxG5TIXQVFE9HzWrLUCqGEMt?=
 =?us-ascii?Q?977N1VeLZECKEA7YNzTLG/WiL4+rknO/fSsXU5cYt7VE4g5hQ7gKOB7csfSd?=
 =?us-ascii?Q?+0Z5NAzaLEZfRqWt3PTnT3IpLC1B/ITOv62WN05NX+gQ+mnkScd9lb7TPKzf?=
 =?us-ascii?Q?VBx8wB26aQJ28DZI9DQzWc383AiYj2LC2Yu8mEgRDg1jD2QVgw8Y0m5k8k5n?=
 =?us-ascii?Q?HnJaHZgSqDJqxjzu8XF6rQd64Gwa2hfxBNgZiyV8BAuTB8EWCy055fHDl+jO?=
 =?us-ascii?Q?rr6gQcXqOUqlm5XsM6xAW3M5d+TuPunc?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2024 09:38:40.2108
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2dfe5b7-26f6-47a1-e855-08dcd24584d4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A6732.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9079

Now that both IPv4 and IPv6 support the new DSCP selector, enable user
space to configure FIB rules that make use of it by changing the policy
of the new DSCP attribute so that it accepts values in the range of [0,
63].

Use NLA_U8 rather than NLA_UINT as the field is of fixed size.

Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/fib_rules.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index df41c05f7234..154a2681f55c 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -11,6 +11,7 @@
 #include <linux/list.h>
 #include <linux/module.h>
 #include <net/net_namespace.h>
+#include <net/inet_dscp.h>
 #include <net/sock.h>
 #include <net/fib_rules.h>
 #include <net/ip_tunnels.h>
@@ -767,7 +768,7 @@ static const struct nla_policy fib_rule_policy[FRA_MAX + 1] = {
 	[FRA_IP_PROTO]  = { .type = NLA_U8 },
 	[FRA_SPORT_RANGE] = { .len = sizeof(struct fib_rule_port_range) },
 	[FRA_DPORT_RANGE] = { .len = sizeof(struct fib_rule_port_range) },
-	[FRA_DSCP]	= { .type = NLA_REJECT },
+	[FRA_DSCP]	= NLA_POLICY_MAX(NLA_U8, INET_DSCP_MASK >> 2),
 };
 
 int fib_nl_newrule(struct sk_buff *skb, struct nlmsghdr *nlh,
-- 
2.46.0



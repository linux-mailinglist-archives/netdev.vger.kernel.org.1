Return-Path: <netdev+bounces-167014-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86CB6A3850A
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:47:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D72683B373D
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F7A21CC7B;
	Mon, 17 Feb 2025 13:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VpmCZYBg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2047.outbound.protection.outlook.com [40.107.92.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9308521CC73
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 13:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799740; cv=fail; b=PsN1XsUPd26+KkPt+K2Ylt5kRL3pZlPiuooXwZYoZOiMnn3XyrTSwkn4Yy1+t8rlcNUNZWGINNoX5XYphjQ7Xg0xcCNwUF7natSJfkpyvja6jsmGFxmJj44fg99lyrX3TMOD/eoSTMGz319hYPc9NMVE9x4veozwpQ9oqChEp0w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799740; c=relaxed/simple;
	bh=npiFWyl6xuwZGT2Nuhl7nBiQsF+Ksll3AD05WxG4oCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G9xDB+RBU0w9cRcEQg4Amiv/NjwmCJe1eS4IpQvQjxjRXdIkKQvQFy+piCY+ZHB32pay0h5rB06F7wdmHwCVALHMLw5J9DWzJOIP9NxwzIjO10bNqQWCunS0hmTpjW0oZjO9yRh8HY8DChhQZ3l2MuCvcizFIe9NK4mH9pscC4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VpmCZYBg; arc=fail smtp.client-ip=40.107.92.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MOUJAoorvWU59XXYp5W+vMwGg+QDAtzfTa+EN5yL2usOkw79ZzbJr7dIhp++yZFuywoNujQ8sm9HmViUCQHPLvDvoylMdMldXs0LE4N8Q0pnQ76VjfQOSIczs5/3R1QedlU5ASbJZsMj1JIadjyAHXwqCAn4W2LcSgtj0QxafggfF6kgoINu8LLsiKIYhebqh89Acd+HbHJwGNfr9SpVOQTEjLIBXCxpwkLVAoaAGHcSlB4XTOQIud0/40Qnk4Vm4xYSpMf08s2FNKl/uiQwK3+A4F9jtzqO3K/8zSKVcR4Muo64qVSz0teFA0nNarG6YclLNAA747xDWWLgDObgOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m4LXOoPCj1Yd0stAH0ToM+9J8yTKsScrB/64DWxI6yI=;
 b=wUlLOclXYYCClh/OAvIWPLPyvLVaHaON+QRDtNct4+NNIES7h4CvZx0vtxGo0MUQ8HSWbeOcn3dpSyrFppt4Gyr6XLPpRRSmQFMy0facIHVI25Ey5jAi4YpGHjuk62yxNL/jQJGR5/ighBE6ofyKxF8xtnIQQ88z1gUy8GtyPn0BPPpQ09IxzT35hFL8DqthObCi5w7UrVchWI0CAH3AoqBoJhcwD87a/vjdLDHr1mKtLqjeKECQTWXmqKHpMSH1CYpyo3uboE/Ul7G6BgrURw52ye+uojRpj0CkcolWajDH2uxCRtwlupKmMch5H0c+IKpgNLgTbwtXNoW9M4TC4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m4LXOoPCj1Yd0stAH0ToM+9J8yTKsScrB/64DWxI6yI=;
 b=VpmCZYBgcaFn3s+21ds3HyUNWVeHfkzoyQqvPrmHoUt3d5YktFlVKK6K0j3wVEM1HfmsWmCP+p02xh3UyI5v1xUfzaLcwrYF6uFxwbxU4L83slbAqMAa6LNqPTJaaz2T980uA4fx39PAHcrhS2XDybsJ5+IKJaYtnS/qZtL7AxxNbOEdnDew5NRoo9QUOdjNRDdIQzacPzQ5dTkdYNh4BLkkgDfRIm5VG2xkA0FDd4o62JFTqb3gROwydElHzIv+079mIxoCrVaqLiMwdEJhlkgQ1HeJPKSVV49VNX/Axl6OIIXsHpqiLe5Txq/+Fnqy8HAbYYt2wRyzKKeVsELr4A==
Received: from DS2PEPF00004564.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::51c) by DS0PR12MB8197.namprd12.prod.outlook.com
 (2603:10b6:8:f1::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.14; Mon, 17 Feb
 2025 13:42:13 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:7) by DS2PEPF00004564.outlook.office365.com
 (2603:10b6:f:fc00::51c) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.12 via Frontend Transport; Mon,
 17 Feb 2025 13:42:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 13:42:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Feb
 2025 05:42:04 -0800
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 05:42:01 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 5/8] net: fib_rules: Enable port mask usage
Date: Mon, 17 Feb 2025 15:41:06 +0200
Message-ID: <20250217134109.311176-6-idosch@nvidia.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250217134109.311176-1-idosch@nvidia.com>
References: <20250217134109.311176-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: b1752168-5023-4e1d-bbb9-08dd4f58e2a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?nFCWywjyFFgOye3TTDpMMscB6dDB3LB4iH5kY+8o10HBSVa+C+yQ72ep47gQ?=
 =?us-ascii?Q?hA2u9lTmhZhfmI5Y7bl+0CZ/5EkyFi/lvvMIGYfqIB81iktKYZvdjFAM5W3W?=
 =?us-ascii?Q?NYB0Nbzx0fusJPTZBdRfjPdZ9zC7xZOrR9uJJBJWouhOxvZ4Ct9TbsFtktW+?=
 =?us-ascii?Q?zqD1HmwYuZwQzM40YDpItN7Qe335uc1KMmILxYjDluBRRkfkm29LxBACwTEk?=
 =?us-ascii?Q?JzIOGO5BOBlLDfJt5Da/i6vXbFArXSYxcWzks9d/nzuAJKHPmPz6XagA43CD?=
 =?us-ascii?Q?hTiNWmOnUnZyx7m7txuEnGKVbo3xap5Io5+1p2867WrS15tbrPyN9J8I/T/W?=
 =?us-ascii?Q?lBJyAB287DqrcS1uJPst5OXgjV8iib9BqVGBn/5KwmpwGTzgZxtzap4KyCpR?=
 =?us-ascii?Q?YAX38ZWcj11GAGj6kLkT5rZm/Rqb9XCo8Nnyz4jvR+9XEZ/ShRk81D4ZU6pb?=
 =?us-ascii?Q?ggsYDOrvOk8tP6Vafth1+/boBAF5Gml97rqj9M8p9LzXHXGIidpjwA1wQfq9?=
 =?us-ascii?Q?tqePdK+hzowzsnTm1Cc++fRTad/XtktIsvE5jLi7mT84DHkBYSKvXDIR3y7Y?=
 =?us-ascii?Q?qF/7GXfpJoFD8xECnu4K06YkRSm3TOlWgduoi0GPVOWKvxuht0JKtCimQTzm?=
 =?us-ascii?Q?Ya9Bi9hlvqxrGMd8CuhRaa38yJ1SzIpzls/+Ajq3ELNhK7I5djBE4cWf1zXC?=
 =?us-ascii?Q?Z9vOQbb5G1/wwBRgU2RTkhdYpM0gv3ZD3j7AFO2cozvuqu6IbWFFvciGfOsy?=
 =?us-ascii?Q?VZml45BRVz1DxTSiFfo7CmnqjL7mLzZFw7dXf1Jt/aJp9SHUQpQXhw6t5dj8?=
 =?us-ascii?Q?LTGjzQhom+WPuKehOxmbhYi/FoJXpK2bOm/NSBBup+oiLR3jCrDTSz4uxkYh?=
 =?us-ascii?Q?5EQjVZxPyuv+FT+SYP7DQuqZdj7qk6nxnQpQi6yj9Ij6jb4sHcF8aAlziTf6?=
 =?us-ascii?Q?AtepzVArqVr6RTxqezcNsrwQeCCBlQAyDA9RD7AMx4DJcTNfLpyWOfNC0VTT?=
 =?us-ascii?Q?UVvfAtWKjW1YzWQyWHWYUojM+xt5f9tDCfLouctfUrwBGLLYmtU0RaIJi1CE?=
 =?us-ascii?Q?bJEbW0APsmDZ90x21THYZalz4lhVrSHgZOFtDrvjWI6/mjhky6Gs1VyenywU?=
 =?us-ascii?Q?9kPMg46iKQYv5+awAp/vTdcE2KiSEpgeBPP6YkD9xFRqjdO8IAtUTU72n7ia?=
 =?us-ascii?Q?tRm00XfrtcxNZuY3I7YNkEEklxHqjcvMyXdZVEguHI/9kVROsIpsi+a8PELU?=
 =?us-ascii?Q?gnnVtaRhao7O7smfOsjjEFwwE/8sjMYstbo3lvIAanM0+a8jJri9laUlfyjk?=
 =?us-ascii?Q?20uZ+RH6P6KnmPkh5zarWfef2rNtRHFNX3QOIXh5JXzl3dpEPxe0lBb2jP1l?=
 =?us-ascii?Q?vLCdrzZzrgVqYuAik6/gBrj+0LEAvsww6jA6YCCjgst20aLgwNldAIQHK73M?=
 =?us-ascii?Q?SX9P+5imrZ7XnzBB4DkC4LD29ciVoPDmhTY4R4lJ45x6xZ1UAGR85K6rmwaH?=
 =?us-ascii?Q?bqFub7GQEuyZdfA=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:42:13.3809
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b1752168-5023-4e1d-bbb9-08dd4f58e2a8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197

Allow user space to configure FIB rules that match on the source and
destination ports with a mask, now that support has been added to the
FIB rule core and the IPv4 and IPv6 address families.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/fib_rules.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index ba6beaa63f44..5ddd34cbe7f6 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -843,8 +843,8 @@ static const struct nla_policy fib_rule_policy[FRA_MAX + 1] = {
 	[FRA_DSCP]	= NLA_POLICY_MAX(NLA_U8, INET_DSCP_MASK >> 2),
 	[FRA_FLOWLABEL] = { .type = NLA_BE32 },
 	[FRA_FLOWLABEL_MASK] = { .type = NLA_BE32 },
-	[FRA_SPORT_MASK] = { .type = NLA_REJECT },
-	[FRA_DPORT_MASK] = { .type = NLA_REJECT },
+	[FRA_SPORT_MASK] = { .type = NLA_U16 },
+	[FRA_DPORT_MASK] = { .type = NLA_U16 },
 };
 
 int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
-- 
2.48.1



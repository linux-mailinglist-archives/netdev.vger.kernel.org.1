Return-Path: <netdev+bounces-152324-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C91659F3723
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15AFE16D74E
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:14:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302F320628F;
	Mon, 16 Dec 2024 17:13:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VxOpjzcV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2084.outbound.protection.outlook.com [40.107.93.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C6920551E
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369194; cv=fail; b=d29zIX/4thwLQtot3AfcoaguCf77EdWsmNhBc0na4yi9evP+r9Hw/yDauYanwSKrvb5tbM8LfvzTFFr35Rs37CF/Fup5AZvR3I87V/olvLalVAdAtoAVcNmoeBAA/d6AlgldMDn4A3t4YPCFDCJkJ5D6VZcdk8NCY0a9C3/UZgs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369194; c=relaxed/simple;
	bh=Zd2yHjDl3VqqiqcW3sonpFU7J1OnCaUt5IXlSOYclLg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QlB8QI9pJF3YWprmybCOEGfEFHwd10snLG1Ew/IWXDZObZuSX4uevgQDn9k/0Awm0RkZiqZI7dls+OaRZ5qfvrKEE58XpqToOL2QhOwd2kZmJekQanWqAtSMHYychULqLhvjAm3a7DeFN7U1SWFO/jMDCUh65zQRshzqVXm4jro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VxOpjzcV; arc=fail smtp.client-ip=40.107.93.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PgYh0h1wTEkbVIUQzonhl5Ucz9umJK015dW7c2io4CG8kjmv3q7ZHEY9TiO8jZUpzGBDnFx626ibRGEXW/rfzp5pKW5kWMwNH/mXV4hE8h26rVpfwguTiqCC2p1PFTJr9o9u0sTsbiLAKXs3lCwHcB/n1HEAOutzzfD8xub8ggHOMZjXD3/XE7DumMdl3r5UyTk9nlqGUY11rbddxTGL97x6FlS9/Q6GOX9UXZx1ueN47K27Sy2Z3nHZW64Td8s4gqqd+db/0UwDaHDbF3yPFCsukdH4yMFy1wVBvauxO0p+9sgu84trqfGzfJSPTX/UXzFRIsTciu4SWvPm5rqtJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RN67QOF2tqa1YG70cgKzXkTreT/BZPJQrkhvCsTtl9E=;
 b=dGiX0/nHzuRhLHoq6RANg1Zplk3xgWFb6WKGPqDFTG5e5tF7VFWsiyEAAa0kDBDZgYVaVP82OtZio1S97v1qBYe+S+cyNAb8z12jBmX5fjZhb0Ub4My/h38vjEFLwQpPHmlzQVlLMxPplDjzwFxpmWGqUkVxWWELCyTXoq0ksyVcbUZefWBAHsUnMBxS9bCru3ZWA+moQQMckRVbezeaATl4wU/2pJydr6mhalBg14LZNrIrF64ofaRXngtJ1+FdY4EW26kgkQecdObcSiHFM00jwhyddKzNcqhvRqGRvpuejqME1YyvTuVGWfyHf2Rn2gOjeoJb0pmRgKim7wFIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RN67QOF2tqa1YG70cgKzXkTreT/BZPJQrkhvCsTtl9E=;
 b=VxOpjzcVnQ7yOKwxs3oJ1NcR6y7GlS4pNKl63kqfS9QBX5YpTJu4yy7iU+TxwBZw/UXQKegY3HKXvjUbWhDC/NHVYyfTbKcyn+eAKskdcrKR8VuJGPOHAYCFepNR8zcuV9Od6MUqwUpLCOuqC7A6K+HB4rQEgaMqeUpaX4Tzucn7PcOe8+DK5tViGuqtUGio9KVy9xyaFAgCs7aAYl2QYMvZYgw93eX1DwFcjGAE0b6yQmFhfVlUM8yRrh4Bpqym+5qSMmrHj0J40dpQQgP37rWxYoKe3X72b1KP7u+L4v59LN4Y9GMwNQxB/nTaSpO1pOMG/SJgKj9RjCQSRteReg==
Received: from SJ0PR13CA0122.namprd13.prod.outlook.com (2603:10b6:a03:2c6::7)
 by PH7PR12MB6658.namprd12.prod.outlook.com (2603:10b6:510:211::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 17:13:09 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:a03:2c6:cafe::7) by SJ0PR13CA0122.outlook.office365.com
 (2603:10b6:a03:2c6::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 17:13:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8272.0 via Frontend Transport; Mon, 16 Dec 2024 17:13:09 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:12:54 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:12:50 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <donald.hunter@gmail.com>,
	<horms@kernel.org>, <gnault@redhat.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>, <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 4/9] net: fib_rules: Enable flow label selector usage
Date: Mon, 16 Dec 2024 19:11:56 +0200
Message-ID: <20241216171201.274644-5-idosch@nvidia.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241216171201.274644-1-idosch@nvidia.com>
References: <20241216171201.274644-1-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|PH7PR12MB6658:EE_
X-MS-Office365-Filtering-Correlation-Id: 36e2d9e7-b2b3-4774-c0aa-08dd1df4ea1f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?q/5jNf7sYM+EF7i6VwpCp9qtL9ImkTueLu9qRJAFX9s2p3wd5+9Mob2KQWve?=
 =?us-ascii?Q?TmrqtDRTXiVephdRWgnCuRCQn6EJb1zhbDBks0KOKEccLQ2ABMtpmgdOyc/D?=
 =?us-ascii?Q?xkWXgLAwI0jeCVTnA8Vyz54TU8PYF4MuSy7JqoRcpgQqvp4/kZFE1bZ0P7ix?=
 =?us-ascii?Q?lYsYHFMU999xTGHAO3O0MrNJpu9QqXyXyoqx71H8UbuDy5dBd8Bj2FaESbHV?=
 =?us-ascii?Q?D5aqsbYujDX5XjBXeg3s+i01QDs30ghTNAEfdwYo+2uAP2yaNht877TFzkuE?=
 =?us-ascii?Q?QCojcoiLWLRBtnoUTPrkpnYb62IdJqMRH7Y5AzlixIknlf6vzblfcdS3Axdf?=
 =?us-ascii?Q?35h53/dNs5Ajat2PLJzMrmKJI4Dz7jupOH2Bd25aKf6HMmUBSGNf7ml4xC96?=
 =?us-ascii?Q?YAowSP6Am6DCdwuXqS0/c28U0zfirpsri3NCcA1zRYnMaHMJ5171OOpuKSRL?=
 =?us-ascii?Q?hyhPY+gnxhJYrY1hRVm1LR55QmM0D5PvieUZqzO5qAMXpc7b/+uk72egx7LB?=
 =?us-ascii?Q?9nxuQQOz97LBitm1oxFN4zFGY5X1trCbmdxW6oG4AU23y8E0Er7ln6n2jqRY?=
 =?us-ascii?Q?tCtBhpSsKPmbwTi2WSo/up8Iwqz3D/gmMT23arqHjAHcGLWn4YVkU08c6Upl?=
 =?us-ascii?Q?mJeiVpAvPI89ZeE6zjrJSzMAGAeLQP0C3rOLWzkYr8ykoDudhMZgD3/RKDms?=
 =?us-ascii?Q?TRq67AW07bQBQVwO9+T5sADizh030KBckvWLBWWUcy5Vj0lBzGeHAjHkgCkW?=
 =?us-ascii?Q?iyKkkLtR8ylMJ2KgfNHUMvB8Z/PdZlfrj4HeTgszSyZobDanaTgU+X5QKPzW?=
 =?us-ascii?Q?62P5oYjDfuiIncWg6vdpCvZEx1cPl9peFHQyAC36T2/n3d/fNeMIvTH9+quN?=
 =?us-ascii?Q?HGGcD0LkmD8o/CgqJk1qUZyZtRQZbGL8h1BClblaACvV8ABmLhfZmzeEKrBQ?=
 =?us-ascii?Q?sACqWflWq6UPJLRaL8DBIBfq3Mit9aAp/EVXf8zGScpV42AlyvkVnXbiqT8s?=
 =?us-ascii?Q?Qh7MZzWQaYAImg6A6ecEA00RL657S/4ASJSpWJDrD+dhk4HfvPz7J11KxREo?=
 =?us-ascii?Q?4v1h+r3DtKrU+o2ZFmhVrA1hcFieiNdmYq+jK7kQ6UF5oe9ikWb73rJe//Ug?=
 =?us-ascii?Q?sACB61ZdK0Ky/0OfxHA+BK7z8wPZ+uq/RboTp7ehiO83WVdkzSCZnbeukXym?=
 =?us-ascii?Q?D+kXwEq2AuQ71W+2tJ9mYNrs/Ivmmi8NRI4NGhLPwANKIIhjGogW/19IanjQ?=
 =?us-ascii?Q?dKuu868d3kuFH4S8FFQV0K18a47g/3bhJ44cAm2QX+p1oUtpp2qGTV6BGncn?=
 =?us-ascii?Q?HF2XGNEyNLejoe71tKQyUVAMhCse7eIeK0A06rkI3G5mmfPYLe1Fr93CeIoP?=
 =?us-ascii?Q?cXeXnDFgXhdop92/cIZBHauZNajMGfouhd4ne+fUYtHZ/8Q6l5KG7pyFEOxw?=
 =?us-ascii?Q?5ah5ZW2Hldloi2U0zhOgawkDcVxeVrB1XwRBsjcsQIdqS9aPC4Hh6uNYEFuN?=
 =?us-ascii?Q?J+G6g5so3bkrWJI=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:13:09.2716
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36e2d9e7-b2b3-4774-c0aa-08dd1df4ea1f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6658

Now that both IPv4 and IPv6 correctly handle the new flow label
attributes, enable user space to configure FIB rules that make use of
the flow label by changing the policy to stop rejecting them and
accepting 32 bit values in big-endian byte order.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/fib_rules.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 153b14aade42..e684ba3ebb38 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -770,8 +770,8 @@ static const struct nla_policy fib_rule_policy[FRA_MAX + 1] = {
 	[FRA_SPORT_RANGE] = { .len = sizeof(struct fib_rule_port_range) },
 	[FRA_DPORT_RANGE] = { .len = sizeof(struct fib_rule_port_range) },
 	[FRA_DSCP]	= NLA_POLICY_MAX(NLA_U8, INET_DSCP_MASK >> 2),
-	[FRA_FLOWLABEL] = { .type = NLA_REJECT },
-	[FRA_FLOWLABEL_MASK] = { .type = NLA_REJECT },
+	[FRA_FLOWLABEL] = { .type = NLA_BE32 },
+	[FRA_FLOWLABEL_MASK] = { .type = NLA_BE32 },
 };
 
 int fib_nl_newrule(struct sk_buff *skb, struct nlmsghdr *nlh,
-- 
2.47.1



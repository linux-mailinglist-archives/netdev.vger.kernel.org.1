Return-Path: <netdev+bounces-112073-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A35F2934D47
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 14:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E7741B2113C
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 12:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B39351386A7;
	Thu, 18 Jul 2024 12:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JrtkIjeg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2076.outbound.protection.outlook.com [40.107.236.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0303D40875
	for <netdev@vger.kernel.org>; Thu, 18 Jul 2024 12:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721306122; cv=fail; b=cQoIAa/ui9sAMyUKdhT8D/nCmzbSLB2rPPgB/cCdpmuA5iobROlHVyLZq4YYi6+pz2KBz3ME2gYpu9aGEcAx35JImTorC2NuEhjXqGkryhW+JlQJNyRXLFsu6Te6udkOUbHvzSWgTHSuPBAUcN2EQjXg/0e8YCckUl6HZuMGUxs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721306122; c=relaxed/simple;
	bh=RMCppnaFWJxnALZR/kTTWS8RrvkZg8iTb3dSv6Ft9eQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GhHow8Mgd09Aq1HEg7c34Eedp7yPxqD5Gi2+R5l0lPgDIpSMgIbWuAIs/u7tqPlWFl6Yh0giHAh1zXzSMQuMsNqi3/w6sfD3u0V7hLMekYG3YwdRYLzTUkvQnjbkqVb9dZ3BqoCgtt/iOeNwL9UHrp3XH5AtkmaHGFCbWSwcV1I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JrtkIjeg; arc=fail smtp.client-ip=40.107.236.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bv1W7/wwMpbjQDZmJqYFWRNg3NEpU2fcDmjiOqba76W40Rou0Orc9FpTYKLtARyr4S6kCn+ugfW0LJyU+lVVKu+KrQnqfE5OI+H1eFJPjACzEdwzFaBC9K8hiP3AD85o6cRIRGsydnm/97/2DFrxoEjiKWpXKNO5EnTxOx/xQxbJsvovbIFV3mOm0H90aEFvOZ0UdB2yrDWB+VLSc3CYvNng0bi3KPNYhC3MQmFx7UZ5mLjrN7zo/EolXt0ApccNSlBrfZSC0C6W6JwsjqtUCowcvo7yIvtnPEf5ssxj9xPgbg6jYsCUdRK43WpnEOSnt+2GDVguFvu0JuE/9Z8wXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93Xsn+en5tv1hdh9j1nMzAYLPOQw6pE+wqbnMl6YaJM=;
 b=kRnCtjSKr5NyRumfMg4JlBnkRbR7zcXnIWm+ajN6O03vNyHhYBocaRafqmNuM4s8xRhQSZJT8Z31ErMdUl8NI4g7cj0VmzGkB7vNMV+DT6KGxSjOAC3p8piiaFGO55dplg+/xKj3uIl+XBhtcMSYvQ6yVqUoXjQzB06NOi9++Lj/7R42wXcREsPui34rgAq3aKPkXgmSE7VzU3FcA26beb0AX9Q4SkLgzRrD+dMRXODQgYX+MrlJYx5WEaFcMHRrN5N9Aff7Q9c40ppNEDPMvsIOBJHwRVbrYBRwJH69+6FB/fQGcOKhCzF+abLSHw4u/dhQjHcoMIL+erBKzev/cA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=93Xsn+en5tv1hdh9j1nMzAYLPOQw6pE+wqbnMl6YaJM=;
 b=JrtkIjegyZjGfcEgDeIIDnlNPe5PPQAGkBRvfwJqygEnnoc4UevQJ0/xoQ+bKDPdmvqopx9Q1mMFXbAjnyOkhNLL9Iaqia5PjwEtMULJotiO8fo8jfhgkMpIWwSpfSaYlIgIoDTqCpCB90odbzfP+xsKaTt1jf4tvJE0tZ5aMoff1XeoT96brPVV+Jkf5DU9h7kug9qmQpV/4M1JDWsFWXhOrKsGURNgf2K8uwq33NN1WzXDYcOkkhPYW27E+GqoN8Min4lyKEqf7u4v8JvvHPTrPcOSmswQMrMl3Hg6MtPOpLJd+pzrv9VIexm8EAZs3sspcwpI1ZXxg+iRCz089g==
Received: from SJ0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:a03:33b::14)
 by MN2PR12MB4253.namprd12.prod.outlook.com (2603:10b6:208:1de::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17; Thu, 18 Jul
 2024 12:35:13 +0000
Received: from SJ5PEPF000001CB.namprd05.prod.outlook.com
 (2603:10b6:a03:33b:cafe::ed) by SJ0PR05CA0009.outlook.office365.com
 (2603:10b6:a03:33b::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.17 via Frontend
 Transport; Thu, 18 Jul 2024 12:35:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001CB.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.11 via Frontend Transport; Thu, 18 Jul 2024 12:35:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 18 Jul
 2024 05:35:00 -0700
Received: from dev-r-vrt-155.mtr.labs.mlnx (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 18 Jul 2024 05:34:57 -0700
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <gnault@redhat.com>, "Ido
 Schimmel" <idosch@nvidia.com>
Subject: [PATCH net] ipv4: Fix incorrect source address in Record Route option
Date: Thu, 18 Jul 2024 15:34:07 +0300
Message-ID: <20240718123407.434778-1-idosch@nvidia.com>
X-Mailer: git-send-email 2.45.1
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CB:EE_|MN2PR12MB4253:EE_
X-MS-Office365-Filtering-Correlation-Id: 6c759fbd-af47-4da7-2fb2-08dca7261246
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?0gAmnSWo0euwLzrJ4Vv82qWnfbHYstm7nZN8TBro3WAKSUHQ53DIyNxDFIc5?=
 =?us-ascii?Q?JUJ1F9WwBZ8+pJ4d0zvaRc1q7UO8TJVrPemgTfn7EgkMgzXataXGd2q2OmnH?=
 =?us-ascii?Q?zi0H/gG5kX8MuU73472opouuZs9IQN0mq6UwR5xjMNJFk9eg1KeMzdmXp21B?=
 =?us-ascii?Q?lam341iIZUDgfMjcK8g9N1CPGxiki8Cl65rI/PROrRtxE/NekdVtfwQt9+lE?=
 =?us-ascii?Q?ojlX1MF+UV4p8MC0m3r126fwS7BDuyUzFmSK4XRh0oly8zivMgt0KAqoualI?=
 =?us-ascii?Q?965Is1TZoIbXZdnjkFKHNpIzan7kkp+5NhDNHakmTv4R1THHef9pAanKowCq?=
 =?us-ascii?Q?Vh+7O954PG2KtzzEpNYGnMHvIDLog5gkDMCYHYE9O+eoJqfPhnus8JZAYX45?=
 =?us-ascii?Q?OXZmvkaWFa5SwC/pq2vIFafXO4zoLX8skFY0Ez7gbzuvRRFjfTPU4G5KbEsu?=
 =?us-ascii?Q?e/mfFr31ZixkWqgkob9qxe6ctqPtKq6mGIiffshPohtgIFQg4mX7O4Lbkaio?=
 =?us-ascii?Q?MMMqrS/ET/gN77KNi4+Rf4jCGFn9lCURBUBMRA5O50LD0hRePkJZnfNCerGp?=
 =?us-ascii?Q?WVwVvEyHXc1xPb47FydTDO1PbS46GQPLHI3XdIDy26eP+EOdEosUNKop6Mbp?=
 =?us-ascii?Q?SUUS+BF2VI9bFTNBfH7n0s6qS/6Q6BCOW+6sVqCRzZ74atFuDo/v8/jsT1Oh?=
 =?us-ascii?Q?5mrMSebebzYrcXklWe7WEqcTZnM1nhU5HXR58BAMfKCX1LH3h1/WldpZ2re1?=
 =?us-ascii?Q?Qp2Op3lUaDx86PgAqpEyv+Tcu8OCpYHNwfX6lRGqRgndOAUbzMwAps3t7mP5?=
 =?us-ascii?Q?ftYBMUOSbf241V5Dan46eeQg+571upLn6mdl0VHpomb3DPvebmiazKb8J3HL?=
 =?us-ascii?Q?MvY0sTeF7TN7W3NQbTDXwjnikTnVcWpuEF+faUJa1qcglwX/iWtINtrpC6sF?=
 =?us-ascii?Q?0o2MnjDQhbXOyYz/OfDISnjBVD748Tc4E6SdcwSSB0607xZh8QP7YwuWLb3l?=
 =?us-ascii?Q?lTldV2x5CIfcJGfOO/Dfi/jAdiht1+sg+1WiVLT4ph6xtjfUoWnrNue72gkc?=
 =?us-ascii?Q?QOr/WfWCd1qCqJpR8YziaVDArIJWWfhYpuB670SktWEx1i+7gJ1HEHgsMdc8?=
 =?us-ascii?Q?RYHyVyZoKNsSBclAq6yANkXLn5QqKrFtucFSQ78OhLqW9cACdcblznp59cmu?=
 =?us-ascii?Q?dpkUja3RXsvNa1A0P5Hf2KcNd/sG1VD6ccaA62ML7W9aFp7Hfzl0rhLOcUn3?=
 =?us-ascii?Q?FiR2sxS8MqDBlEj3DVPNEnR5nZvVGQG3uoCw8cGGcn8VIUx73+MiUHQ9NKM5?=
 =?us-ascii?Q?acfMEfti7uhmKZvkUvhvhcUDbfXOpFs5EJZaBt8LSZpdylrSefT6VAN0mNsg?=
 =?us-ascii?Q?nxC99l5fe/cPD1ykDZjFBODoEdOgOM1v/tZxRGXI5I/ThFLACcuIumKko11M?=
 =?us-ascii?Q?OHo/34DnJDfZNt9uRP+v1WmDW/J4rBH3?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 12:35:13.5703
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6c759fbd-af47-4da7-2fb2-08dca7261246
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001CB.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4253

The Record Route IP option records the addresses of the routers that
routed the packet. In the case of forwarded packets, the kernel performs
a route lookup via fib_lookup() and fills in the preferred source
address of the matched route.

The lookup is performed with the DS field of the forwarded packet, but
using the RT_TOS() macro which only masks one of the two ECN bits. If
the packet is ECT(0) or CE, the matched route might be different than
the route via which the packet was forwarded as the input path masks
both of the ECN bits, resulting in the wrong address being filled in the
Record Route option.

Fix by masking both of the ECN bits.

Fixes: 8e36360ae876 ("ipv4: Remove route key identity dependencies in ip_rt_get_source().")
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv4/route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv4/route.c b/net/ipv4/route.c
index 5090912533d6..1110f69bf9bc 100644
--- a/net/ipv4/route.c
+++ b/net/ipv4/route.c
@@ -1263,7 +1263,7 @@ void ip_rt_get_source(u8 *addr, struct sk_buff *skb, struct rtable *rt)
 		struct flowi4 fl4 = {
 			.daddr = iph->daddr,
 			.saddr = iph->saddr,
-			.flowi4_tos = RT_TOS(iph->tos),
+			.flowi4_tos = iph->tos & IPTOS_RT_MASK,
 			.flowi4_oif = rt->dst.dev->ifindex,
 			.flowi4_iif = skb->dev->ifindex,
 			.flowi4_mark = skb->mark,
-- 
2.45.1



Return-Path: <netdev+bounces-152322-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D8B9F371F
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 18:14:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E7E5416CD40
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:14:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CAB204573;
	Mon, 16 Dec 2024 17:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DqkFTlZy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2081.outbound.protection.outlook.com [40.107.93.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F2BD1FF7D4
	for <netdev@vger.kernel.org>; Mon, 16 Dec 2024 17:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369179; cv=fail; b=Js54AANdsMmif3S4m7PK+GNHnNcuNJg65k8IEbRJddkhIHML3Ibv/762WsU6hlDiu4yyafXsYj5L1k1VAVzuvNQqQvKZ6xSYNHylhFTMAiIosVZLmW4MYUDcmq8SYF8yC4T1bSJouqs47IpvHJXtpoj6HlRh2a0LFyMn/dY8NSc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369179; c=relaxed/simple;
	bh=1k5EHXAscOilEABI3bzdr6KtS+4sguw2c31lnLr64UM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PbX/xEuF74RTD7H/JXFM0BgTOz6E2DHpCaCmd6KMm2QGF2gWvpIaT2ZZ+3XAcUxNTmcuP4FWrLroZHiWgOk4hIC4gqHQtUwiIx1jsvJZ8eUEvByeZQ4ah9Pbpyu33nXRD0nnXZU2XI+B2kp11TPTvsxw/GYbv0LRAG6P/h0xUmY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DqkFTlZy; arc=fail smtp.client-ip=40.107.93.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jUVkMEqrh5OUFntg5CJP8SsrgGBys7dNA8cXEH+Hc+XAMKjno9sejxjnnjfr/OYuQY3h9f9mQXxeXsrgMMx6yGNEqLQXBujknc7bgdDd5zgEZ2l9XNIxyKbKXeEjKOrKTYTd5tFSbubVy0CeMwn+6EDfUjhuotZPldQU83AzuZHclV3BzHb3jczXqMk9xhQmzd5V2e7aGIM2KwC0v9+19X4p3N/bdWqMPfUDLqk8XqzexNJOU6MGUGALWi2U5wwFIJspCvbaepw6AByuORo8D9ooJoe4YfxgS11/Z/l66n9mzhWPW4TVghj/2yOOBb0lYn5T0Q7PtVdylRdlS0/zmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWar1/f3iSB6PipeA8ggdFg0wEL/x67uVZ8WpKHFHvs=;
 b=Gmtjjh60gQ/iIUaynA9XpqUtqRIK2++7Ecm/YOKRib2LwI4d1+2IHJN8S4dPbBbKWrKVldG4gSk08+tt3/DQp/r3rTzrU8S88e7Jwaw/yI7C5zGOO/LpKuaNAUgefhAsCBHaJdqW0x0OWaLcewtdN1XVtYZW8xSdhzHaIwXHZVT6+Tc31L0PRx5lAsCSzMJ/cJIHxV3EEWMHukCpaRRoVqOpDTGOfDhLFRQUK5vWVLWvdYru1mFl+8QPKj9b9bAvLU2U2LK+rPVIrs835YGbzaeD8U8UNOfWXy+YF5nIhFWVSJksxMe6Q6T/Upk+jQj23QAafuIGs19r68b04C4cKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWar1/f3iSB6PipeA8ggdFg0wEL/x67uVZ8WpKHFHvs=;
 b=DqkFTlZylmj/AsaTGEw+Szr528BhQS+PBteIxGsowgX56gLU0ZS4AlYYOlaICbu3dB8C90spzA1NACmScNUvyQi1Ccz3nhX8xoF/2KumOjdZdI46v0mBRnteGksrXFlTEqCQu4MRScURSFLDWo0YnFXf/KMiaEX+ofmDdQto0os7JEGGH+ys+FNrhhIWeAh2yQP8dJBCxp5K4cuHklvgbyTlOOkqy2ll//g4mN9gCC6/BuV4Ok/JJUAyl/u0zxCZKSWLmMrT5i8RkQBQUY3k9kNPLj8PT7b0jhnrqK2meocL1HJog/+rlBoXAQ67AEv4VTqsQ0Ko4sW/jPFZ0X3AwA==
Received: from CY5PR19CA0062.namprd19.prod.outlook.com (2603:10b6:930:69::9)
 by IA1PR12MB7733.namprd12.prod.outlook.com (2603:10b6:208:423::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.19; Mon, 16 Dec
 2024 17:12:53 +0000
Received: from CY4PEPF0000E9CE.namprd03.prod.outlook.com
 (2603:10b6:930:69:cafe::2) by CY5PR19CA0062.outlook.office365.com
 (2603:10b6:930:69::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.21 via Frontend Transport; Mon,
 16 Dec 2024 17:12:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9CE.mail.protection.outlook.com (10.167.241.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 17:12:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:12:42 -0800
Received: from shredder.nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 16 Dec
 2024 09:12:39 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <dsahern@kernel.org>, <donald.hunter@gmail.com>,
	<horms@kernel.org>, <gnault@redhat.com>, <rostedt@goodmis.org>,
	<mhiramat@kernel.org>, <mathieu.desnoyers@efficios.com>, <petrm@nvidia.com>,
	Ido Schimmel <idosch@nvidia.com>
Subject: [PATCH net-next 1/9] net: fib_rules: Add flow label selector attributes
Date: Mon, 16 Dec 2024 19:11:53 +0200
Message-ID: <20241216171201.274644-2-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9CE:EE_|IA1PR12MB7733:EE_
X-MS-Office365-Filtering-Correlation-Id: a764d77c-eabd-41ee-1a8e-08dd1df4df5d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iOvd4K+nQKHSnMhsc5R03sN5Ar3eslWCsq/VsE+fwat82mrRysSDQFgvBJRI?=
 =?us-ascii?Q?Lq3sGrstuOFDbanuotqb2ErIRrs7qwtuZmGpHtAzdUa3O/cOQlZgE77L4QXA?=
 =?us-ascii?Q?/0ot8OuAn7gYr59EYn+8PvP7u6rtAtyuiav/6ct1wH32I3FBpFB3dG7R4Gzu?=
 =?us-ascii?Q?h2Ec9E++3ZS85g61X3jqUoNd5On9BZbo/FamQE2/PBoZbB6shJozyiZ/TOVA?=
 =?us-ascii?Q?q0X/i2fHVOZoB76Yw32CG97QIaCZADw8l8GgNia4Gsa69bjq1EgOCkRezk3N?=
 =?us-ascii?Q?ASfTomDyDX91PvDamYCQv6rlelXdBhML8Mc25rLOQioWyJOtYUdBjjx50gMt?=
 =?us-ascii?Q?fDW49i3CqDRHVAk+eiGVv5iQ5pymH0FZ2igjPbYMu/eR5CUGwR6Czrveqdy+?=
 =?us-ascii?Q?J72RU6sBVKoaHPh+gaCGTkeIXtKJ8OQ3KdY/u0Nb+EnfzNwpBjI6i00mfmyW?=
 =?us-ascii?Q?JRJqIwPNTvmZ3ZY3lXtBP2RUh7MVn3JH9xTtwejbhYI2srnWwj2/qFnUyiA7?=
 =?us-ascii?Q?WvLKpb2SR+4N8g/ybvi0wGxjJVEU95NDT9HVIAnQ0OrnyMZBgh4GSDZPFHvq?=
 =?us-ascii?Q?n0//OFsV/9KzzGtmJCcZ5gGPj9PuDikPGzuR3kr2e47NlsM6FQxTb5A0KnOv?=
 =?us-ascii?Q?U5rv2SoxwKu3BdawHob49dLqowSxhNRLW+0e8YOP1Tj57PxkLdcZq2qrAIeH?=
 =?us-ascii?Q?K/eXWg3nPr2jLR/6f3/3NPZlAtj8PbCtXcWMXD2AvCj8PVETbrERFqpopteT?=
 =?us-ascii?Q?ngLJFnkVjdI71V1Y6I/8/x1gHFlRe6B62Ssjn+Pxkeyl+aWRd5PXp4Mp/KiT?=
 =?us-ascii?Q?UaaDgnnRFcZTyZnckmQzdfVsOfwqbrbNEevVl+3GuIpLcfgKxV/j7Cu+YZbf?=
 =?us-ascii?Q?INf7tiiS2xFP+Uxy49YQMwT3vD0i7fPx1aPznXaMNnSAM1j3+2CFxwTh621N?=
 =?us-ascii?Q?lQBG1NZSPl1yVXH460MMiqU+021+GB2ptiTqsXZzIeO09Fo0s0iGh2Gc8VCq?=
 =?us-ascii?Q?VF+2p3o2mePd8WYF86A3a4IUSeg0vzGuqPfV9D5U3jETfC5Cu+kK01zwrVPI?=
 =?us-ascii?Q?oSWfVg53OwCwNeAXfMsAvNJxb5uTWzyQv1OMkqO99tVn3xfBlKzGuCDFQwSh?=
 =?us-ascii?Q?f1W8oCdw/mzBOgUWezZ6r8Cy0+/0AGVnPTksltuQAqliT/43/gz5NBRhhmjE?=
 =?us-ascii?Q?MoRFZk4TRMtQP5Z6FUFkFynB8pQ5SkjvA6GNA07367MJCBty2SaJcV5WrXwL?=
 =?us-ascii?Q?Qb92B8slWVDOlewAZgZdFLrjGBnvO/QBeJ1Dd/HRHuLjooVT0jVrLMeXFo6k?=
 =?us-ascii?Q?b8Ia+Bs5yDbTMv7tyTCzDIoJ+SL/K/tFS7U9VU11uIFJkqiWQvmCRFEusb0N?=
 =?us-ascii?Q?/xxkms0EFshPo+XNvJyg/dm2KOlafQ8xgmAS1RUCibOkuyhZFkSjv5blah4P?=
 =?us-ascii?Q?Ft/u6Nnm/Y65FVQNqrxa9gMPNl0dxTcKlaACT2S/se4YlQZ/9whdjuV5C+A+?=
 =?us-ascii?Q?OrSfvXNrt9A+V2o=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 17:12:51.2031
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a764d77c-eabd-41ee-1a8e-08dd1df4df5d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000E9CE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7733

Add new FIB rule attributes which will allow user space to match on the
IPv6 flow label with a mask. Temporarily set the type of the attributes
to 'NLA_REJECT' while support is being added in the IPv6 code.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/uapi/linux/fib_rules.h | 2 ++
 net/core/fib_rules.c           | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/uapi/linux/fib_rules.h b/include/uapi/linux/fib_rules.h
index a6924dd3aff1..00e9890ca3c0 100644
--- a/include/uapi/linux/fib_rules.h
+++ b/include/uapi/linux/fib_rules.h
@@ -68,6 +68,8 @@ enum {
 	FRA_SPORT_RANGE, /* sport */
 	FRA_DPORT_RANGE, /* dport */
 	FRA_DSCP,	/* dscp */
+	FRA_FLOWLABEL,	/* flowlabel */
+	FRA_FLOWLABEL_MASK,	/* flowlabel mask */
 	__FRA_MAX
 };
 
diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 34185d138c95..153b14aade42 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -770,6 +770,8 @@ static const struct nla_policy fib_rule_policy[FRA_MAX + 1] = {
 	[FRA_SPORT_RANGE] = { .len = sizeof(struct fib_rule_port_range) },
 	[FRA_DPORT_RANGE] = { .len = sizeof(struct fib_rule_port_range) },
 	[FRA_DSCP]	= NLA_POLICY_MAX(NLA_U8, INET_DSCP_MASK >> 2),
+	[FRA_FLOWLABEL] = { .type = NLA_REJECT },
+	[FRA_FLOWLABEL_MASK] = { .type = NLA_REJECT },
 };
 
 int fib_nl_newrule(struct sk_buff *skb, struct nlmsghdr *nlh,
-- 
2.47.1



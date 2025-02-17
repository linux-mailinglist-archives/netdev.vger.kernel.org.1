Return-Path: <netdev+bounces-167013-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B825A384F3
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A5A416C99E
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:42:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628FC21D3E5;
	Mon, 17 Feb 2025 13:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="lq0BId6f"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59B721D58B
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 13:42:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799733; cv=fail; b=iMreaZqLu/p0Wqon8VMt4j3gveYOsDClJ5PRg3d+epB7p+Qyk5AMLlatbIG4SjDFvd7zvaaWjf6lCnHwBLmxr/kmJpL7HDn0K7A1KPsxgOgFWKOk4uVGrSr4CgZidTHHgH7wV8rTCXyVBOpRMPnH/bpmMys9yfPXu4nmcAp6jg4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799733; c=relaxed/simple;
	bh=C4j+1/X8NGz+FKujazjzXAdZK/ZAU4y1dmN+f/4EmAE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lo/GGZTokX+sZLbtAVcKVu4kOFqfzCNARpoy/wD+Wzfl5A5dStr+DczJQq/CFzCE3KamOD7uLbNgIDA5eyvPR3hCQ1eYU12phyrjAFYaOkI6qlX4SBLqfy4TJqW403sD+8eIPR9kSuzI0o+4MgZDBPU5FWAMVwm0Fhr9nNvLA6c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=lq0BId6f; arc=fail smtp.client-ip=40.107.92.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uMZYPe9R1auhQUkjL/buIc3QYb41lNVaGe7S6R08+4GZKS0sA8lqgnwnIRxupxX7KUjfsuLU4Vebi6ESFy0175jv8JPzSu+QAwIi+7PNT2K7P5KKJfL8PrjUZB4qPb4/bHi212T/4OFpFLzorM8QNftGdKDY+T5XmVtzePJ+HuEKLsRA5YLCesXXnf05DZQkHvkgRMZvptJDXOS9BJwp6taPXvz+gH11hMZqpoeU2MDqk5RZWimIjAcwxiXsr7u3ggI8q+b0zE5suDJ2R2Pa3YmwteLIgHQ3/G5QYP7qTG19+SBFzGXLgtQUBJmhnaRqixuj81gzoVsOeInr8ExLiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbL+SUZJyw6E+5Rlt/tpL50K3gZ/K5lyZzfIp36h8W0=;
 b=EQtqHgomQxhOlBpY+aU9cNSgvoLjzGYQ92ce6+NiKw4SS6KSzAAvuWlj9XQPndGOQ7w/hfDfjG9QNaEk6dpv0jrLMAFg8TKHfXOacXLs+YEtsF26BqsGcUhRXxsIKbreNrMzIdGaCPUBFO7QQXk6c7vbx99fY/MHjbChDDC8yc8iySQi9i33JQDWcJosqILmvxFbLkodLObT1Rohba0EKpE97Sf/lRr+73Zq5ZUMuHmkGGjaCrHWgiPxMrOMJGqhiOVE0hJhK+4b8O83a1SVFDVV6htwYX/QX4UZ1X5QGUafrc44fTcIZXMjNGSEGTHH1UU0AK+V3epfFBmnIkPrAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbL+SUZJyw6E+5Rlt/tpL50K3gZ/K5lyZzfIp36h8W0=;
 b=lq0BId6fs64dUT5RuAQ8ODtjyEHWcI4ws3i9+P0keOz0UI517V3RcTzH/k1CrY6xuO0RTWYJUs/PhbkOrhcf4wkr+TLd1ap4QKlk2SqhoV7fQ63Ulcro9a3lAW3sfK8FpKFVQNjaKuzyPUO5ONxL+s6Tyko9wDhsB6NimL6mZq2ZE5EmjHk5flyvBFJCBiszWrbfoDq3+IiL5o3w0hqn03C1JOkKzO+lxPDPqx1MedL/s9VbYuXk7At+tJ1Hso46wA0mwhipAHLbzhEf14P251He3ClUac8HB+ra93eXL0rdMHTX33G/cqwsgIj2VpxyhUHLzzQXVoxZFtMqkQHQpw==
Received: from DS2PEPF00004553.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::51b) by SA1PR12MB8858.namprd12.prod.outlook.com
 (2603:10b6:806:385::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.18; Mon, 17 Feb
 2025 13:42:09 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:2c:400:0:1007:0:7) by DS2PEPF00004553.outlook.office365.com
 (2603:10b6:f:fc00::51b) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.10 via Frontend Transport; Mon,
 17 Feb 2025 13:42:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 13:42:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Feb
 2025 05:42:01 -0800
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 05:41:57 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 4/8] ipv6: fib_rules: Add port mask matching
Date: Mon, 17 Feb 2025 15:41:05 +0200
Message-ID: <20250217134109.311176-5-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|SA1PR12MB8858:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b5e6f5e-fbb7-4c61-ef08-08dd4f58dff2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?APZaoaDHtVIabEEFzdMggotZ3tthRdofse8roQ449sZCt5Er5RhMs6q0NP5w?=
 =?us-ascii?Q?0XMEgsm73DextdEmhc0N9KWmg0qgUGg8Ql1SIJ7BzTDkzIxGnTrSm/RNK2ug?=
 =?us-ascii?Q?5qPdXxrXfEq2/NbggdHPvZTj3A1XBEbEDKCK2pKtEijdMMl4OvdU4OXyy8S6?=
 =?us-ascii?Q?ZZkH79Rz2J4vqRqNfGDgmUMYK5r3hxGV/XKWJl8jYwIr/6kLvW6hTGa5jrQa?=
 =?us-ascii?Q?i33hWAslIkdEYZw+U12qanKVAbq5cWaDqZtNl/JTwn9jhDQXj2P7nA+fZKzC?=
 =?us-ascii?Q?1m/rT9JB4P81cm7ISAdBG4oG0N8lGrFzPMYfAqZO+fnmfrRhMCamJkR/igyh?=
 =?us-ascii?Q?ql1BJaPju8yhqOb5Lg8GezwsrYQrzeesDLgVLBv+RCSX4LqQmhVvU5bMqhTw?=
 =?us-ascii?Q?ojWIETwT0qZCfX0EIOiX2aVlMFEUXUF0OAEH8EPYbUJPuCHVJcCBRchN4FSV?=
 =?us-ascii?Q?zv0awI55M6UIKEsq5uMyeXwlllvNMAjvHEIYoAMq1KzTSNlOR8LQxIu8+G4U?=
 =?us-ascii?Q?HUP4HzXW4BcocP8yUr0xC0qp1fDPrrCR9slW0s7v+h8zCFJHiGEhuexYyX6u?=
 =?us-ascii?Q?0jd7TeaTJGDwq6r8U8oG/vtQ+Ewg3tuCAtAzRkhLATedRLxCv5V/i/i3R2VL?=
 =?us-ascii?Q?rnbl5TGDtWsq/vgUijECanpLFFsM/1Fk4Npr9ZUMMOdMX0hin6r+UezTPI/D?=
 =?us-ascii?Q?blVbTsOUBY5MUv3SLP2oLmgCxwDmocgHGbHNMSh8RRmAsb5+/VSyeMDj0hTg?=
 =?us-ascii?Q?YEInQAArOpFHvGCmTxfjuLoPTj9NLxP1j9jRwSITKYvaRiASEMkls71NLl78?=
 =?us-ascii?Q?Vbgn0psw/UvYo93eApApA6U5Tpn8u0kgs5n53OYdjJmRwHj+Z+QYPyL7mH37?=
 =?us-ascii?Q?MgQOZU0IiafTZP+uFiFdzH8gJygKe47xjtw3QTbAKoDZMNLH3rdk6F7zatj3?=
 =?us-ascii?Q?MbnxDjiWxwoXgyUJ1UQfjuCxgi9ojhfhe/lKKXQAnHrgawFx3Qv0cS9NXdKW?=
 =?us-ascii?Q?c/RYpBUOwMMBV2Qnm6hbseFHgZF44i7xzTSCfWzQYBdDm2WJHNfvA4GaLmUq?=
 =?us-ascii?Q?V9OqRKCRPeOo+wlAA/JEEwAVUoWFGWyHi2msC3GMcupqRTC4RoUaUfZOPgPB?=
 =?us-ascii?Q?tthhrzte0ae62oLy9PjwYogf+6OZEymC3E5fZUn9V31M/Ij+DzOJazTS7wdR?=
 =?us-ascii?Q?co6YPYniV7xsCa7EEkgXWJ3WmcGAltfdIZRHRgfb6/+tq+NaxWwGMdRF2zfl?=
 =?us-ascii?Q?PPXJGAo22MYxWnjGYG1awsb8VW9pPdzzCxBZwxGm0NanPQOIxjSy6AGLxNRC?=
 =?us-ascii?Q?WeCJg8md8PuBVkahzooDN4a6noGVIE2qyujbaV+qPJbz/0TU0pFz2TUtXLti?=
 =?us-ascii?Q?IC+rrgHrVTEtHIaVwtPTY+lc9ImtKEu1zWt0Ksops3RZ4VwnRWEf/abDZNJ7?=
 =?us-ascii?Q?UFcABUOjTJud3PZSIGBolNybqyFIGSVmhG5lfld089DpFgfcvAKmXX8KVAp6?=
 =?us-ascii?Q?ix7p+4WkQqlu4zw=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:42:08.8028
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b5e6f5e-fbb7-4c61-ef08-08dd4f58dff2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8858

Extend IPv6 FIB rules to match on source and destination ports using a
mask. Note that the mask is only set when not matching on a range.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/ipv6/fib6_rules.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/net/ipv6/fib6_rules.c b/net/ipv6/fib6_rules.c
index 40af8fd6efa7..0144d01417d9 100644
--- a/net/ipv6/fib6_rules.c
+++ b/net/ipv6/fib6_rules.c
@@ -340,12 +340,12 @@ INDIRECT_CALLABLE_SCOPE int fib6_rule_match(struct fib_rule *rule,
 	if (rule->ip_proto && (rule->ip_proto != fl6->flowi6_proto))
 		return 0;
 
-	if (fib_rule_port_range_set(&rule->sport_range) &&
-	    !fib_rule_port_inrange(&rule->sport_range, fl6->fl6_sport))
+	if (!fib_rule_port_match(&rule->sport_range, rule->sport_mask,
+				 fl6->fl6_sport))
 		return 0;
 
-	if (fib_rule_port_range_set(&rule->dport_range) &&
-	    !fib_rule_port_inrange(&rule->dport_range, fl6->fl6_dport))
+	if (!fib_rule_port_match(&rule->dport_range, rule->dport_mask,
+				 fl6->fl6_dport))
 		return 0;
 
 	return 1;
-- 
2.48.1



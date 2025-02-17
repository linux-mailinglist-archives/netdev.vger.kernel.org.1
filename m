Return-Path: <netdev+bounces-167011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ECC2A384EF
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 14:42:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1472816C903
	for <lists+netdev@lfdr.de>; Mon, 17 Feb 2025 13:42:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A72BA21CC68;
	Mon, 17 Feb 2025 13:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="sAvTaCSq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2066.outbound.protection.outlook.com [40.107.236.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC2DE21D3CF
	for <netdev@vger.kernel.org>; Mon, 17 Feb 2025 13:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739799730; cv=fail; b=mV5eFkfo6p+OMqGmuCLq2BVL4ZJHK9d2ZssZCZivCEXTGNEAc53+YoNILgYjw1qH68SI8mSsgrRzj863MwsbGS75MCtz8Bw2p15xPqrBtN9WVspdIE3qE09gPzVwepg0k0iLx+cNszSsWj9HLwignoqN8WLY/wjmrx9n92QBVnE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739799730; c=relaxed/simple;
	bh=pKPNZFR63za6lTSg9URIv8KEVYyksq1gClF5TnIpE1M=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ggTVOa6Px/3XkOp2nkUvzfYiMtUVu2Ak7Q5iWqwYOkyWDv7thTwpTGdiPlvln+997Q1Jme+VPMDMvQ+z3XUKQdQXYUTHNHYtoAJXn1mgLSXMBfcC6yMaId0ogTzLxQ6Aaa00oe4ZXzXcdq91zyulzfB5wLrjg5Rsj/IQFG9kXVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=sAvTaCSq; arc=fail smtp.client-ip=40.107.236.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zH/hj0KQevPwINApo0zE2tJsuN5W8ybckX/Hu6LHzN8Q5N8AvRBUEC3qPo/vSTUv7ekIuZoAuiUOWnVdyMmiQUZwVicRb9RLHCZVJobju1sNx6D9CFXcafjKKnRx3yOX6zhYbteFULixLvTMDX4GzrcXM30+WVk8bpT/Kf5YwgOz52yKoqg18BuQiFiI5uEaw7jICC3OctpjlQfUnNi5I1+GLcvdpF+Cu3vq7AhJIb/kgtsLZfJ330xfqz6Kk7kEN5QXFhPmhE0UpTL11lsZFzVWQg1+4FqGkTh9f6VaFh7ZZR2ymcQ6L8W7/qmNeGALJgZa2C3bwmUmqiE6Q3HB0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bu0R2o5cH9t1XN5XN5XaQm5Vqka9S+kFxaMuc2vpzpU=;
 b=cdkXAHqQx6r5KmvRfe0Mel7LohkvGPOI+yXd2QARFAfCktryj6Yqic4wY91zW/YrtnzFS7DHxp4hhruzeuKSPiqgqjDX28XhCOvArj1R8QZSyQSbaQSEEk4bd6YuOzQjxgbMfr3rlD9VTFpHRakkNZ4pRAqh6L6YJvoS/pfmJHMvH+DUW4Xo5OkwlXVu8fGwXBUvGJDOoMw7GTeVXO44am9jrIVBbXcOemBnoY2EyKWb83y/sFd6DIj5zwjpuAv2zDqucNLXaI6DO4HvuI1SXuxcbfUu2VdkwncChh8tx5gqf6ekQPRCPaFW2mlkewXdHgwfhA12Hd3vuIfOKzdQ0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bu0R2o5cH9t1XN5XN5XaQm5Vqka9S+kFxaMuc2vpzpU=;
 b=sAvTaCSqDM5Tc46lxnr3pISR/2oHuibAsPHfzDgA6WOES9eKh3FUeSojW2zjEHzql2Sws9eATj/5CwbzxODGqjMSCDu2EGVfWEzSjFPvLjdsea0sqaXmrBxUXYbgLekIgq88QdGPvN3FzFE7K8Z2Ag3rCBE6Z/GP+Uco9rWHcHHdXCO10AKbZGszmRN7ew6N9bmW7A6uH5VT7FJz2Hdvagy67T/3oe5ROEkTWBr/schpGIhi+KJL0RNGF2LrH2d7/QSXtr/yusYKikO2bwRXqtJ6IaMQ7jw9hWguBTj5+DXX2sqgWExj+Ju3eYIvdiuS+/p/566Ib3mYhDub5lHctA==
Received: from BY3PR05CA0006.namprd05.prod.outlook.com (2603:10b6:a03:254::11)
 by SN7PR12MB8001.namprd12.prod.outlook.com (2603:10b6:806:340::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Mon, 17 Feb
 2025 13:42:04 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::35) by BY3PR05CA0006.outlook.office365.com
 (2603:10b6:a03:254::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.9 via Frontend Transport; Mon,
 17 Feb 2025 13:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Mon, 17 Feb 2025 13:42:03 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Mon, 17 Feb
 2025 05:41:57 -0800
Received: from shredder.nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Mon, 17 Feb
 2025 05:41:54 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 3/8] ipv4: fib_rules: Add port mask matching
Date: Mon, 17 Feb 2025 15:41:04 +0200
Message-ID: <20250217134109.311176-4-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|SN7PR12MB8001:EE_
X-MS-Office365-Filtering-Correlation-Id: af45783c-7465-47c5-0cd9-08dd4f58dcff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kTm6MSMpGt+qZbwoCpKb8zdN2fQOK8GT+njbKuSFdI1ENT4JWFHH0iVkWAaX?=
 =?us-ascii?Q?BFNv8Lz9LWHhRQLh4ISkgYlflrr6279RKoxnHzfT9gaBS1hJgwhkaVXM/d0J?=
 =?us-ascii?Q?gVAZUOwL+Sd4izoPBF6fRCD20ZYKlhYGzdzhFXK7Ci56Tqa+UTMO6PKo9m6i?=
 =?us-ascii?Q?Sz8Mc1Ui9CGzIqJTyuSazUFGjodbHXSZFtAMnZFtid9UayeivPli3ZpZCY5A?=
 =?us-ascii?Q?ouDm+AgL4xqD9kK+kB2JBhuT7Z3+iOvhH2/Pi2qckZZBItM8Dpc8zEA+ngBI?=
 =?us-ascii?Q?iMJdW/NPF7fgmsp2EcckRDAso58RcrtdNPFVvCu+XnBB3YfaJ22cqMlpeBBI?=
 =?us-ascii?Q?HwguuIajtv1NwyW27WMIuzTLDbMOm56KPwMZ7ylMw9ix/aho2wciAAIXYJ/f?=
 =?us-ascii?Q?hcJ11DdAuCcrMq1voGOVr0AX02J0aMRZ9ZXPjTv2ssZZyrbjxwEXRds2bFHR?=
 =?us-ascii?Q?5Ucm4SxACDd75vegkmCWJPE77dozCn/YzBbl/Uf49lmLRnrvYQBilA0tVkJS?=
 =?us-ascii?Q?tBwAqHwE8LQGFuO81aK00WHnlvyNZ2rUrcs/mK2lRbUVkra8ynV4x+9egeC1?=
 =?us-ascii?Q?FmtE3SR7o+Ta10M2iFJijiHaBFrTdxn8WFZ/jmXQTmxWcdQWAxmiqo1n4sEq?=
 =?us-ascii?Q?E9mDrHgZK9KglbGD5dLRm/B3dIhg0sUewrTzEfnt6aiqjZx0znCggzE4NUqu?=
 =?us-ascii?Q?fFRGIYcDrfm4M9tHL2bXHhfS8hzsMDzWGvTu+AjMf9H2o53IfLMi9Q5oFzce?=
 =?us-ascii?Q?PROu7li55ifhVhowQ1kSiT8MlwXuHnZLOc4WeQ5kVJ2U22p1H/eGL/oVxK0m?=
 =?us-ascii?Q?UQofLs16QFi3SiRQuADksrxu5IoYdRghlEU7Iong/FJR3yJYa60dj+/VpZR6?=
 =?us-ascii?Q?sTUCPhwOTdYVn/ISKDB1g5x3TNF77fNLTn9H3uVKIA7wyctLssjxdfa5buix?=
 =?us-ascii?Q?xaDsjpjMLCnhfPO2Vr202ECzZptMWYCQAQrBmbpQyb60eute2CGNeqCmDLEm?=
 =?us-ascii?Q?hNw/JKDU2L1rW7G8jqEdD/KDhHcb78z6Z+xBjRFLGVnyP0unqOKR7lxU5GeR?=
 =?us-ascii?Q?KnzuWE9IJkaUkMHye12XRUMj++MlOhdOqcTkA9Ep/AX/NIH7XyuwXihbaFCe?=
 =?us-ascii?Q?HjwbW+efm36ZjaQvFgJBXcJrPjCCofnq4bvYJnz1d3y0Y7iIImDNdVpl53pO?=
 =?us-ascii?Q?cr8ykHNz2V4/mSYxKNpkFyFV5H3Dbcc1U8ZApISPCRA4jqjexHC+WWhRg/2V?=
 =?us-ascii?Q?NoGAmao3r4xYBF7AaT+9jdBUHbLkzFJBhB7xCMaHR9IO2B09PztyA4OV1NqJ?=
 =?us-ascii?Q?tOQKjJvS+eGIdl1trBKgzZ13h0a95OsbHhkmGhHg4TKVBqLlNo0epb+oOsI5?=
 =?us-ascii?Q?JuaU0nR268hIJo47/cu/fxhE66q7gh1GSn46t+H6llCTG2w4QoTkXaprIgf3?=
 =?us-ascii?Q?J+y/L4ZqF5NzgWTR1YlabJvxt61i3dxHLp1s5bL1LyRORnCHnqDFN0DXL0q9?=
 =?us-ascii?Q?WIas5AptcS3AIh4=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2025 13:42:03.9584
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: af45783c-7465-47c5-0cd9-08dd4f58dcff
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8001

Extend IPv4 FIB rules to match on source and destination ports using a
mask. Note that the mask is only set when not matching on a range.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 include/net/fib_rules.h | 11 +++++++++++
 net/ipv4/fib_rules.c    |  8 ++++----
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/include/net/fib_rules.h b/include/net/fib_rules.h
index cfeb2fd0f5db..5927910ec06e 100644
--- a/include/net/fib_rules.h
+++ b/include/net/fib_rules.h
@@ -148,6 +148,17 @@ static inline bool fib_rule_port_inrange(const struct fib_rule_port_range *a,
 		ntohs(port) <= a->end;
 }
 
+static inline bool fib_rule_port_match(const struct fib_rule_port_range *range,
+				       u16 port_mask, __be16 port)
+{
+	if ((range->start ^ ntohs(port)) & port_mask)
+		return false;
+	if (!port_mask && fib_rule_port_range_set(range) &&
+	    !fib_rule_port_inrange(range, port))
+		return false;
+	return true;
+}
+
 static inline bool fib_rule_port_range_valid(const struct fib_rule_port_range *a)
 {
 	return a->start != 0 && a->end != 0 && a->end < 0xffff &&
diff --git a/net/ipv4/fib_rules.c b/net/ipv4/fib_rules.c
index 041c46787d94..6b3d6a957822 100644
--- a/net/ipv4/fib_rules.c
+++ b/net/ipv4/fib_rules.c
@@ -201,12 +201,12 @@ INDIRECT_CALLABLE_SCOPE int fib4_rule_match(struct fib_rule *rule,
 	if (rule->ip_proto && (rule->ip_proto != fl4->flowi4_proto))
 		return 0;
 
-	if (fib_rule_port_range_set(&rule->sport_range) &&
-	    !fib_rule_port_inrange(&rule->sport_range, fl4->fl4_sport))
+	if (!fib_rule_port_match(&rule->sport_range, rule->sport_mask,
+				 fl4->fl4_sport))
 		return 0;
 
-	if (fib_rule_port_range_set(&rule->dport_range) &&
-	    !fib_rule_port_inrange(&rule->dport_range, fl4->fl4_dport))
+	if (!fib_rule_port_match(&rule->dport_range, rule->dport_mask,
+				 fl4->fl4_dport))
 		return 0;
 
 	return 1;
-- 
2.48.1



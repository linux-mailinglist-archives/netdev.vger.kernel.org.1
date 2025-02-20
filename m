Return-Path: <netdev+bounces-168037-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AB9A3D2C9
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 09:07:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1187617A614
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 08:07:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0A31EA7C1;
	Thu, 20 Feb 2025 08:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="W/VRJFn6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2082.outbound.protection.outlook.com [40.107.101.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC50C1E4110
	for <netdev@vger.kernel.org>; Thu, 20 Feb 2025 08:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740038817; cv=fail; b=chMRrxpYnJgvusoppV/5AdvPrKfruwp/Y9gyxvP8tq/4VkT3CKUdgjrOiCIgr4gWpLvTnodicbqSXqdEXAzLsdJ8ZaHJ+BwQTHCfMtbzsujC7XDDrEHV8CkFRh19X8je+I0Oef/EYNMd0Fz2H2OWBf/v58zETw0gpD4p4mbH8rc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740038817; c=relaxed/simple;
	bh=WBuig4FiL0EWWiUYvcBsWE1+Bo8bly5YJzdzTG8qBVY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dbAXJokYizhhus9YCLLJqnNOdyHSxQAtCCSnyLKdwS1NE13QoYACjrjfEk/6HDo3V28iee5T+aGA3gqBc5THSNHcVypiI6XOFOd6uA8oaMjsv4yT8VeZL49UVH3Ivw6Y620LZ2ENLWKMCV5o00Cr7GKXLU/v5EfbMZgTuxyPnyY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=W/VRJFn6; arc=fail smtp.client-ip=40.107.101.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kn9OHBZ0xP8Gkhalnc/owEvhWEi/fMuRYHrXAWi66Cvozvlim/KcTsKSULWgSaJvWBGorJk8xafx82KJspmT1+vYam9wT6Hi+NQfnmZLt51WwT2psnLLl1I7SD8vkaqSGw94/qTrABajEivE2vaFHNsuDHsX/eCdtgViNFPzH2K/yh7TstfMttjq2yypgkHSWa9B2RK200CEv4eQuqzKcyljKeK2d36v4ngp8vdk7xhNK6RjDUn265UskbgcwtHVbNH8sWx/p1jP9QO0DEGA9vN/PHfhBS3bKAewmEphYYVuQi8UX+ZKKXQ0HdlhNOl3M44qS7mdA3wtbDGWooX96w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UMO70sBjxYZCUFVuzP00XEqpP0ew5r2Zxtx5qn4hlbI=;
 b=kt4dO/qWSU0QZZCX0KCENVddV8unvR2D/LaGBtLeA/Jvgclb9ZIneSD+iQzZoYhutX1ku1PUZ8hDqZE+j7u0aOlWpIK0lHGWTPBj2k4pJVeaVbNp4Nh4OMsysmKiM8P3UDXmGOYlsLQDx9Yoe+tdlg+/LilBa8eWVvcFbjka7QPI6GtftgMNy0/dkauqJMCInU2nCwcrIPrSu7pnwUsR1G4aRjQE0DIeXDU9y3uiefZds58Dtb/NAYEtLeymjaQmfSd+84WQ07T3E0ISA5efKzJFm5xexk2eEV1HCB9OLWvmsgSTlhkJAJA9o6TpSes+q4XXtu+kOzjHhzpL2NA/XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UMO70sBjxYZCUFVuzP00XEqpP0ew5r2Zxtx5qn4hlbI=;
 b=W/VRJFn6KLWmg0Pse9fDUmuBpsUjDBrsCc6pTGM3Af3QmAhT+PcSYGfeLT9swmPXsiGvhzs+AUn6tWQmurX1hynDy1JYmMR5+qrG0po7qXUfA6OVqRG62s8Gl2FPPLAnnszEAclzFtLKr2X1X1vIL70waUpDwl6RLGBV1thpjuusK0m/t6w9ujCbrX/dPqEUjJo1sYwM6ErRJtPOxJpDbOaSB5J7iynUUDHfqLLovDGFidwb4PjrfbZchthreBLeErpc2wmVPUbukvPev3R/c8CrVBJN17REmpvqmH9Ek8pUe0k0cdYKPpL/dFYwrwarZDW8sSeiqfXvKhS372PBSQ==
Received: from SN1PR12CA0085.namprd12.prod.outlook.com (2603:10b6:802:21::20)
 by CY5PR12MB6058.namprd12.prod.outlook.com (2603:10b6:930:2d::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 08:06:52 +0000
Received: from SA2PEPF00003AE8.namprd02.prod.outlook.com
 (2603:10b6:802:21:cafe::54) by SN1PR12CA0085.outlook.office365.com
 (2603:10b6:802:21::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 08:06:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00003AE8.mail.protection.outlook.com (10.167.248.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 08:06:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 20 Feb
 2025 00:06:41 -0800
Received: from shredder.mtl.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 20 Feb
 2025 00:06:37 -0800
From: Ido Schimmel <idosch@nvidia.com>
To: <netdev@vger.kernel.org>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <horms@kernel.org>, <donald.hunter@gmail.com>,
	<dsahern@kernel.org>, <petrm@nvidia.com>, <gnault@redhat.com>, Ido Schimmel
	<idosch@nvidia.com>
Subject: [PATCH net-next 4/6] net: fib_rules: Enable DSCP mask usage
Date: Thu, 20 Feb 2025 10:05:23 +0200
Message-ID: <20250220080525.831924-5-idosch@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE8:EE_|CY5PR12MB6058:EE_
X-MS-Office365-Filtering-Correlation-Id: f605b98a-79f0-40a5-a540-08dd51858901
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?rDshpq94zrXxf7Fj/qWwUm5JlgtAnGl4sg/4f8XyOEL2pG+rhlM+1jGX++vA?=
 =?us-ascii?Q?E+9gp61sCpNPMbfbkzsMjPH3EC1xgxx2nbt8Y/H5KRwr4HwHfCrWojV4JK88?=
 =?us-ascii?Q?qk1FN7yGmTKBYrXcRSCqIUG3QKeCHp/2VWOEhNwl9v9TtduXTkcPDhINtPe2?=
 =?us-ascii?Q?HNRSFHahZsAdHCCWGHvbeHAuGue64qz+m+IwUOJYp+ruwEVEfbw3dXhWkRRC?=
 =?us-ascii?Q?ZYrQK+/21BfOqS31VmHh4xz+tBQwsIrWSm2b7m5pFepeabPjS9BuSDH3ZuSN?=
 =?us-ascii?Q?TyZRuL7V2c05QWjCqEROTIUnCMBbZoRtb+lU2DVFyI0sCedB0fAcrvgaByxS?=
 =?us-ascii?Q?vhgr8nXmbjvJZLZkUt5h4W2Ee0NE45YiQZZpHxnwsN1VfikSBRmbhQZ8mVf3?=
 =?us-ascii?Q?4Ri5p0kzPssSif+kyXoDaR6Ov1arlIdu65OCKv09CnoZ1LVDvHlHkOprK1n9?=
 =?us-ascii?Q?jWU12MfOvN8EaGy6ZxImkQh/7X4K2gtpPZszwhxORbC+dqWdsHOtdAAQatil?=
 =?us-ascii?Q?oiM8W+RXZsMA84QDQXvnZV6d/a/EccKp/p85QoYVqjsj35fjQatf6uByLRKa?=
 =?us-ascii?Q?n7CRJLbHLibwSmaWtgWuourKI0fRdIAr/reQ6GkRYOhJHOePmC4frDIIDYLV?=
 =?us-ascii?Q?ftNcd9wzE/YIZL8uCQVyIFvcVYVsK/2SdyeZcFLSMrjsSIsdKPp8RnYppyAM?=
 =?us-ascii?Q?IR7CGB6tFH7Ez+lqvsuOWa2jHVoti2kNAge8tuUR/B4A3n4wmIoTExuGOvEO?=
 =?us-ascii?Q?5zp6Ryc5ZctTcWm54lslxf9stWKh2qtcAo9Z5hV9xsQ6STgCW12PPQo6m8a5?=
 =?us-ascii?Q?i5l1H5fjQhmMceZYrEjPmmttVU/fJgQIiBnhTR0XGRIKl1iL7UxWeHE2UlDk?=
 =?us-ascii?Q?iOSqvVIy964Dcew/AZ9T7oeK7mZ1txbVSe7MCgxc7r1TRuJZ308DpTGi+RKl?=
 =?us-ascii?Q?XEYRNEnjh8pcVgJV9nI6KSJkxalftcGj5EprBSVAg8c2dtoknVK169nKHSJc?=
 =?us-ascii?Q?Clj/xRcvpSg6xhfWru0zYTMLfbqGfZMl1ac2A1boCeM18riMDjv7zs+ZM+d5?=
 =?us-ascii?Q?jLVEFvIPQzXVIyjqFdap/zBNLZn9NJpIFP09i+iYtLgOX+5kc6MPWi59sUX7?=
 =?us-ascii?Q?H8kqid6pMJbp22Jblx9c2XNeUcUzwKZaJd1kG0n7KKU9JGuvjhCoLAQ0jtVJ?=
 =?us-ascii?Q?2VgfS6ZiLuTGs2IxEp2T8IUB3MAGsyhiaLyZy/Euow1KEtTBQI0tUDohbNp7?=
 =?us-ascii?Q?1+W1J/7SxvEmdDoXatVecw0TdRW9D5E9X7ikxUwL8W8zk13H2kY5eowKJk09?=
 =?us-ascii?Q?LuTMtUJlm4Y1Zd67qx9/XK7ZxUHUVtQcQNfycG7pbHYzk36HRQd5kWTaI+dG?=
 =?us-ascii?Q?HFLRYRghxcTBLCz6Pmw0fWaRnIqivEkTguZYxCdlEQvNI9PXqEUf06kKL8XI?=
 =?us-ascii?Q?Jz+273JFjJz1NM0muiO5hl18UQqieHXRldF31URSL8i44uUi+9C5+Y3OqVjF?=
 =?us-ascii?Q?cdI1qtiYSzzLi+M=3D?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 08:06:52.6002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f605b98a-79f0-40a5-a540-08dd51858901
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6058

Allow user space to configure FIB rules that match on DSCP with a mask,
now that support has been added to the IPv4 and IPv6 address families.

Reviewed-by: Petr Machata <petrm@nvidia.com>
Signed-off-by: Ido Schimmel <idosch@nvidia.com>
---
 net/core/fib_rules.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/fib_rules.c b/net/core/fib_rules.c
index 00e6fe79ecba..4bc64d912a1c 100644
--- a/net/core/fib_rules.c
+++ b/net/core/fib_rules.c
@@ -845,7 +845,7 @@ static const struct nla_policy fib_rule_policy[FRA_MAX + 1] = {
 	[FRA_FLOWLABEL_MASK] = { .type = NLA_BE32 },
 	[FRA_SPORT_MASK] = { .type = NLA_U16 },
 	[FRA_DPORT_MASK] = { .type = NLA_U16 },
-	[FRA_DSCP_MASK] = { .type = NLA_REJECT },
+	[FRA_DSCP_MASK] = NLA_POLICY_MASK(NLA_U8, INET_DSCP_MASK >> 2),
 };
 
 int fib_newrule(struct net *net, struct sk_buff *skb, struct nlmsghdr *nlh,
-- 
2.48.1



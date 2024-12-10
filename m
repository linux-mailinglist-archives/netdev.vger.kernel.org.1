Return-Path: <netdev+bounces-150800-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1DA9EB959
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 19:31:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 023C9167D8C
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 18:31:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08091195808;
	Tue, 10 Dec 2024 18:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kUPL+lgu"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2085.outbound.protection.outlook.com [40.107.93.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162F1531C0
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 18:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.85
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733855473; cv=fail; b=n8caZyWhhcy1HC12vCqQk9qlF+janDgNYGlqEDXDkjVIQ02lL9X3BfK+z143ih4UJocJC0Dz4F08Ptq2QF/H2J8qyhJwgpFWPbl21lh4ikDmygBYv6VDlmUbPzIn+LVerMhx7cUhKSCsjMr5o4AODM3DImCjx0dcvbt2ZAktumA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733855473; c=relaxed/simple;
	bh=apslMalCxX+7en8NfwrbZcBYJuX9nsk9l5a38joEILQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uiIwfL0Zafql629Ag4eM9Xw00VDepzLIBVBEOZx+ah2dk2CPTpr7wLBUMPg34gEEaA85gpeJchpTUUUZfZIQLBxPrbbEMN2bnsoDLfdfqgjS4+JXOZa5g1uNsrUcaQb2viCLKgmwO5954685MYjK2zKAn6Tkky58GhY1OXButr8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kUPL+lgu; arc=fail smtp.client-ip=40.107.93.85
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZXJ7AayppeWCfcyRK6B9f4kzXu4ssaPTpIWLGzlwrhjCV7GyGJITfRdZkRocUdgIh86Me9XjALq7sFq231UzHha8H6nppBPvlreUz+PozbRuN6E3d5BzIqPFW5GG4PbTDKKWZTlZRpmJr3ofptE6+QMAeeCGU4y/ZI8rXafprjNjxkPsFU/R3auxUUquoMOWvsdYeFaUgbMaj6FjIbunPQBc0d3XTzpizfmjuhH+zq41lzPj41KL/n4cVPhvufrAOPtxBeTyOaH9QriEcL3z4o8JEvhkT7BF3uCRPyy12I3ncBcqjDGsJPwR5vxOTGZnc4fH6NITLtifF7Ptr9SLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9/wopi0RvUHOqAZgydu08ThbFPq2RQVc/aY4JT3vtAU=;
 b=Og+2bnGVDNzR7iYI4hikSNQ2qHdzoYivSJCY/bfbHx3cceiRei9KcKdWpXk5ZqW5WdvypJveXd6ouzY+4o7l/ttfIhRP6rabdOuIijddlmgSRqPKs9JplMhqismPooyinQyY8cxPlVqbP0JA7Y6ofP/UyeSg7NltGkLRfMW8NlgOj/Nd2AFQIX/Qbm52WubM5xAM1Ech4DlgqDoCcsKiWjnEPVhnekHF9nMIqOBZimL4q7KSMzFj2PSm2aDPrF50sIoOchF1kM4qftgFaSPBMukAv6I+YJjNtfPjtxKacKrNOxEALJ9M0Meguf+bbHbEsL9qM2ExDTF4ohWG1dkLWg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9/wopi0RvUHOqAZgydu08ThbFPq2RQVc/aY4JT3vtAU=;
 b=kUPL+lgutce7qzPZDSWqp9yawrqhOcfHRmhy8bZ0+056EAjWf+jitnEvyZLSLtF9Xer0WMl2HXo/Qsj4LAWNlQ/NabRcHCJH7xLI3jaFdlQKpT9YfzJ+0Gra6wnUr35SLTH5ktZeonryUJl2vOY8ipo805+L1TTDqpl6vklAtSs=
Received: from DM6PR13CA0010.namprd13.prod.outlook.com (2603:10b6:5:bc::23) by
 DM6PR12MB4483.namprd12.prod.outlook.com (2603:10b6:5:2a2::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8251.15; Tue, 10 Dec 2024 18:31:06 +0000
Received: from DS1PEPF00017098.namprd05.prod.outlook.com
 (2603:10b6:5:bc:cafe::3c) by DM6PR13CA0010.outlook.office365.com
 (2603:10b6:5:bc::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.11 via Frontend Transport; Tue,
 10 Dec 2024 18:31:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017098.mail.protection.outlook.com (10.167.18.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Tue, 10 Dec 2024 18:31:05 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Dec
 2024 12:31:04 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>, <andrew+netdev@lunn.ch>,
	<jacob.e.keller@intel.com>
CC: <brett.creeley@amd.com>, Shannon Nelson <shannon.nelson@amd.com>
Subject: [PATCH net-next 5/5] ionic: add support for QSFP_PLUS_CMIS
Date: Tue, 10 Dec 2024 10:30:45 -0800
Message-ID: <20241210183045.67878-6-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20241210183045.67878-1-shannon.nelson@amd.com>
References: <20241210183045.67878-1-shannon.nelson@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB03.amd.com (10.181.40.144) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017098:EE_|DM6PR12MB4483:EE_
X-MS-Office365-Filtering-Correlation-Id: 80e22b18-558d-496f-cc2a-08dd1948cf22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ASUAS3Jsl8ZgQFTvK7L7IENXGoOG08lyntzL2BMQeUCmyXW5E70S2r3Q14GO?=
 =?us-ascii?Q?BiASyEyfHba0isspcG0Vu0YAv0G53X4Rq5clTadZcxm2cHw5ZpELKHtJK9/F?=
 =?us-ascii?Q?dm8ueKNSwUOLRJsNxqrd7dP9l0cWVpkux5aLyMwPFnyrbqI//L2cqPXap97m?=
 =?us-ascii?Q?7uAUFf1Evo2D+zc14hW3EaC5e7r/7yClcukwwQ0LH2X8EJHahoxkCj27ikWb?=
 =?us-ascii?Q?yB3nBNhw52J0oQWV+PjXl/FPjryoCRZuIj7SjyqjXUtJ7ziDxGwDXDzs3PLh?=
 =?us-ascii?Q?6rIYtnHBcDz0Q3ah23drvyBmbBWPQLLZcZxb0plIiMWTNZGkNSLRsaC8YFHP?=
 =?us-ascii?Q?hTQk1vMPeOUXSI6XrSaQbDm2IPPHcpjWR8qf/imH3pZ0ey+KG4zvsXOHwfje?=
 =?us-ascii?Q?p8gzkYMT5/XqhyMWGIV9/wD9Gsn2DlqyUgULiQHbZQg0buzyTZLO9ncdODO3?=
 =?us-ascii?Q?am9iIdDddFniMqg88jpaL5qIhEL5bLEy4odjhoNg44EEs7H1b/yqkjRjU/P6?=
 =?us-ascii?Q?BQIK9v0Kk56iayrkpEnPI2rRxoh6di/dPBFZmuVq5x85kADlcQSfN2k77O3X?=
 =?us-ascii?Q?tszwLpmxy3oPnBwqWod06KMSSbS7nrGJ0bDKYmlxuty7hol3pLfDfHlmg6DB?=
 =?us-ascii?Q?4eCz14kFyD5Y2NVjPKMAqaZAg54QCCkrxDBcZpYBldFeYlbtvjP6oaWcyAQb?=
 =?us-ascii?Q?SRsLr95tkYA0XhFJ48QaJgCmgAIucGm/CysGqRqXlKXo5Eq+I8Gttul0wkmA?=
 =?us-ascii?Q?qMvPV4PwKoEI89Tjp8rGSWHh5ZAEVAibVELCXKZN/9WbtooaoIUqbMzeMzQf?=
 =?us-ascii?Q?WPX5wWzAVYoi9bp/1KnhebKyEtcLtzjQt9o/jODWyxEdFJr6zNGOkdCEwle8?=
 =?us-ascii?Q?bWVH6ZFTUsHr60bVNuy+g/0BYYtvbKvFkFp5s7YpZ0+2o3B1lH3tXRS1sH0H?=
 =?us-ascii?Q?5rpRa7ceO87y/N0jv0+Zq6JZUxVXGgykWAZ2Sg9EhyqxrAidD67D6hSkX7ZX?=
 =?us-ascii?Q?q6FpKCpjsDvLm7BRUqK0VSGN33qk5CRJl/x3YJpru/DP/wHur4PJOLmP4Xtt?=
 =?us-ascii?Q?SBMlIRD94xw7kFtxTTWrmk3cE37fWiU50amMT48TLBcOYYHsArtEDmK39nfp?=
 =?us-ascii?Q?nt4QDLubyJ9/GDY41WV0tUk3a4d+uflH1AXk8TNv2UjB9hopDuq24wHi/tOH?=
 =?us-ascii?Q?FlrQ5dV8RMjkgNcLkVL9sQuZRGFOKkTq25GYzoofiC204QVqiQeX1WK2SVku?=
 =?us-ascii?Q?NiuR+LVOO9rmo6AGs3+1imV50u7fMp8Q51wHe+kxXc9E0G6h9Rb/hDWM3fX2?=
 =?us-ascii?Q?hsUGkMbHr18yplWByEU1/Z4i8xd34dXyJQVsbeYwWkatfc7kMYHDpHImlfzt?=
 =?us-ascii?Q?LbZMQH+pa8fXEaTiHUUv46DosR1UXnEX+nmzhcWeXotsxHaiuzxD/HOdsqng?=
 =?us-ascii?Q?p0CnBZi5a1jSXblTE3JE/vpBv5e+HS1k?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 18:31:05.8888
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80e22b18-558d-496f-cc2a-08dd1948cf22
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017098.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4483

Teach the driver to recognize and decode the sfp pid
SFF8024_ID_QSFP_PLUS_CMIS correctly.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
---
 drivers/net/ethernet/pensando/ionic/ionic_ethtool.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
index 272317048cb9..720092b1633a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_ethtool.c
@@ -968,6 +968,7 @@ static int ionic_get_module_info(struct net_device *netdev,
 		break;
 	case SFF8024_ID_QSFP_8436_8636:
 	case SFF8024_ID_QSFP28_8636:
+	case SFF8024_ID_QSFP_PLUS_CMIS:
 		modinfo->type = ETH_MODULE_SFF_8436;
 		modinfo->eeprom_len = ETH_MODULE_SFF_8436_LEN;
 		break;
-- 
2.17.1



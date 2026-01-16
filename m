Return-Path: <netdev+bounces-250615-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 63807D385CC
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 20:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A21673061DDB
	for <lists+netdev@lfdr.de>; Fri, 16 Jan 2026 19:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0FABB34DB5C;
	Fri, 16 Jan 2026 19:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZZgx8W2L"
X-Original-To: netdev@vger.kernel.org
Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011006.outbound.protection.outlook.com [52.101.62.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD2734CFB4;
	Fri, 16 Jan 2026 19:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768591663; cv=fail; b=UW2BQ6wkWhxLYqGXjoD8q/9ZTrpMHgk4bY8deIiB+mJnN7E1PUNnnSs0wIoXJgPDeVSRv3OUdsl7rZms171oqgrImvOquRBOIKqeQd4hyA/rHFkizDq9Tw7fiPlsWHadfbxpchY82oY1ZpkJKOn+pp32oxOANQ+FFN7gXnuELbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768591663; c=relaxed/simple;
	bh=GN5QhWANprc0Ng1hD/PV9kFir2S0+5pfNstfKj5uRGc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MC62SmvyQTXo9kL6S3UTr77cXeUw5C6AaOUmaXkMRD3Ec0QBPhYJZ0U5sn1CLtfRxqtubBJZ3WK2RdiUjKuFe2GBItlUU1Y8Ws1R21yslUW3r2VM7r8O7bydRg/D0y7gHAr8lDHe479lQmGujfu1jUmeUgork0SEhP8PJM+iLIU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZZgx8W2L; arc=fail smtp.client-ip=52.101.62.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hDU5CdUYfvM779rqJhcbv7IcskVPcmlnksaOIJ1sLv5BR3HhR7SkpnxmmiuTn8GIqjDnIR4d6geyD8R2iWK0CvqEMtYflg1Uk65HKHWBgv+LCJN6d7itUNTgXb2SJTxace7mg0CjrrpvnrJsJRyCxR9W46UV+g4GzpWWUVJ/j+TOreiKZT4OQ1MpUAvwsZlV7HOzGIhfAC6Jn1M0DPrn9DA5jxGh69JOLXQwcnVeL0YC5Vn7KZgEcRHCntME5ofWMVJmCKY65FzJuM40KOS8F7CytUQixZZRHjTA8wbOXWMuifJlNF0FsGzUdPXS6aw2EAagmd0uytGpaMfhqbUYMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LOZsR9wD7hRY1wsccByStwxXmomHMxSESH5uMuO/bAQ=;
 b=NWvgYPFYQYfFavcLdQwcjs6P205AmaE3gQxguO/5p+MDQ21Rue6fawf6YGRIHooHjBILWtvy2iIT1aITBwfS8uPatSsGPdgDGKsxxMhNf3ymtUGxXjCF8f1i5izR+dSsL7cgeOt0MsJLafymY17R6HZi3vpTSr+gkevu7Cix/5fmvNuctwURkQujzZ8tTOR9pR755F1za1PeqFwe56CPcDykRR1t9zJo9ipxMY5sy55X5/YHKP+UWunvc3OfBOiM41+sy5wFqt73GpJMUD+uLBBNdT0gquMRdvccAqlILEuit1o4ypREheFo111Gk8wyxrELvzvBiGMF9+N3sDERZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LOZsR9wD7hRY1wsccByStwxXmomHMxSESH5uMuO/bAQ=;
 b=ZZgx8W2L3yXeYcufjNSEBvfNdROnhpBazZVKs6lq0UsRm+qvRhh6yGAz7uOhvq9Ekbc6dc7+v4fBGRlzuba75FreofWdE3f+74kV+inIzPkVRuvyjwqFpD8wv9VlYia+xscuYZ1Dib2LQu2lnvCexNY998aXhQYqNFJ0mOrXX4Q=
Received: from SJ0PR05CA0138.namprd05.prod.outlook.com (2603:10b6:a03:33d::23)
 by IA1PR12MB9524.namprd12.prod.outlook.com (2603:10b6:208:596::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9520.8; Fri, 16 Jan
 2026 19:27:36 +0000
Received: from SJ1PEPF00002314.namprd03.prod.outlook.com
 (2603:10b6:a03:33d:cafe::76) by SJ0PR05CA0138.outlook.office365.com
 (2603:10b6:a03:33d::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9542.4 via Frontend Transport; Fri,
 16 Jan 2026 19:27:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00002314.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.4 via Frontend Transport; Fri, 16 Jan 2026 19:27:36 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Fri, 16 Jan
 2026 13:27:35 -0600
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 16 Jan
 2026 13:27:34 -0600
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 16 Jan 2026 11:27:30 -0800
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>
CC: <sean.anderson@linux.dev>, <linux@armlinux.org.uk>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<bmasney@redhat.com>
Subject: [PATCH V3 0/2] Add devm_clk_bulk_get_optional_enable() helper and use in AXI Ethernet driver
Date: Sat, 17 Jan 2026 00:57:22 +0530
Message-ID: <20260116192725.972966-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: suraj.gupta2@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002314:EE_|IA1PR12MB9524:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f004987-2f8a-418d-4aa3-08de55354de6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|7416014|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?LLoUNtOVcIfGQ/hXHDQRXSirOfdOA5O6v7nWpDjj27w/VBT2T9qw1JHMsGuA?=
 =?us-ascii?Q?lvM8YE4EMaujg8SrTeJDxXNoORjQJk+Fyv1qQcxr3gNWdZEEVELtxsZpM3PC?=
 =?us-ascii?Q?D4rOPmdfH5RWo7fmAN3wlDfzzBwkt40RF+blZolkJNbHJfvVbYCFE3kxoSbS?=
 =?us-ascii?Q?Gsqqn0omygO4h2Kh7o+s0TuAn12Mbefsih9lnRnUJnpVzIpRDAJhYBDQPqfT?=
 =?us-ascii?Q?mg7JUOEVyIgJG5RofGXMN2PGfIocxg4pvjR/niNTUVqBcJI1bJPw/Y7rsat7?=
 =?us-ascii?Q?r+DYE1f/eh4J/IUQggxAXWLSVSckV/aQgZljz27eICdStJ5bYjDuZwE+Rfmy?=
 =?us-ascii?Q?mPvQHHZvpiAQ3ssD9t4KV40121pOLv3N3V4pAOl4SXy8tjEcOkZ7QxeOIpqe?=
 =?us-ascii?Q?Bk/pv0veoMutLsf1LdKUt8aexK29DQGcbscXmJFGxwCRvmz/Wy2C5soPhOdK?=
 =?us-ascii?Q?Oykh8tG4Xzem6FTFpwbmPlBXpkTidafOJe4u0nNmPNU6xsxx3XNM3qKtx87K?=
 =?us-ascii?Q?nZwD4/3vx40PC/JtPUCts8v2sBs5a5+es6q2QTEatqoFokUouZcc1IIs7Rob?=
 =?us-ascii?Q?m8/gP17mY8ehsPHpXvRHtBRwcW114yu8d7oZV2Emf190EcG/kSelQ+M6dVEW?=
 =?us-ascii?Q?FjOCHH9F5tdLO8W+o+dOV1RM27yQEnrAOEWyKRKSZ7eb5s6qwafzpGgLYD7M?=
 =?us-ascii?Q?Psxmp7IUJvmR6LWFDijeNV3RaMECnGy67YTzqx0J3BGCYaexR84MzvvHHD3R?=
 =?us-ascii?Q?PjaTWyj0RZK8e8hJ3T83IlDPt1So8+auHf+OZeOL+dKshHuw8tGxqdYhKk7q?=
 =?us-ascii?Q?Rls9imDnRpJMue/vtAeaTkahFSfOQm1I1jAxTcNEPToLn8zoob42bRns2nMO?=
 =?us-ascii?Q?OLdpBk8WwNATF3vp1uM6XTCDj9Bl6AdpMDVEOonsFRA7Sx53UOrlhR+rKGdj?=
 =?us-ascii?Q?XUbU3Xi/aWJvhTZK/9gHUzVp5lpUfFsSTt8RNYanfIJcEh3tn3ig5jwyD3v+?=
 =?us-ascii?Q?l1OQ2AEIKsbA3bnz00YDzsQon3kfbBazxYzsEHDpKCfvp4rXrqNAZ0ehBMTp?=
 =?us-ascii?Q?iOZGPjsju3sULRpAWgKkgyGB0Hxr9qBMhCBlnOUq/TKbxLowxEMbDgO3QST4?=
 =?us-ascii?Q?x52vP3/SQ685xiKkC9JnC2xDG7JyrA4Q4Q+BAdpcFqDeD/EbND2ljaV3WYAh?=
 =?us-ascii?Q?EIgV3OVxmiOodTETPfYNWp8pIrrmWRXRPQTu5DIAjfWka9g/wT4RzBZhehAI?=
 =?us-ascii?Q?k8MKSVolYHTIRANM+YoCf02o5FDZmdcUeaThHB9vk8ti5zk74MFk46yJDHi+?=
 =?us-ascii?Q?uWMDuVXH2NxUkYwQQgcrN8PvQ7NT+3MN33vBWmk2Y6XLJNhXvLcOWDf3aXL2?=
 =?us-ascii?Q?sbXAyiFH68tz2xtZZvkm035U6eUUWFYGrR44xripKtpB8oV4/Dq/n8jIpOf0?=
 =?us-ascii?Q?nnNbvMeOJWZ3Osi46xVBKwaf8V8Wifvgy+nwbP2AAgQdKYW+oJs+s9CscZTm?=
 =?us-ascii?Q?vOXKXncHSP4nN6yJMg2byp98rlPjhJkp+uDsB2OENMXkcgZvEbRLtQYP6CbI?=
 =?us-ascii?Q?+BYXABjwkd7JlTUwgC/ys/z1qkJ7wZUbYJQ1Wfz6VyVoXheSTOk3liMliXnC?=
 =?us-ascii?Q?j/0jkRFctMQEKQyT+pNmYdi3mrwThlIs7+E0CNlHVvu2sGQGmt8copxwngaP?=
 =?us-ascii?Q?ord/+GlJC/T9sWMhEmtdNBjfu+o=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(7416014)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jan 2026 19:27:36.0936
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f004987-2f8a-418d-4aa3-08de55354de6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00002314.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9524

This patch series introduces a new managed clock framework helper function
and demonstrates its usage in AXI ethernet driver.

Device drivers frequently need to get optional bulk clocks, prepare them,
and enable them during probe, while ensuring automatic cleanup on device
unbind. Currently, this requires three separate operations with manual
cleanup handling.

The new devm_clk_bulk_get_optional_enable() helper combines these
operations into a single managed call, eliminating boilerplate code and
following the established pattern of devm_clk_bulk_get_all_enabled().

Changes in V3:
- Correct 'Return' format in documentation of
devm_clk_bulk_get_optional_enable() in patch 1/2.

Changes in V2:
- Modified commit descriptio and subject of patch 2/2

Note:
Prepared this series as per mainline discussion here:
https://lore.kernel.org/all/540737b2-f155-4c55-ab95-b18f113e0031@linux.dev

RFC patch link:
https://lore.kernel.org/all/20260102085454.3439195-1-suraj.gupta2@amd.com/


Sean Anderson (1):
  net: axienet: Fix resource release ordering

Suraj Gupta (1):
  clk: Add devm_clk_bulk_get_optional_enable() helper

 drivers/clk/clk-devres.c                      | 50 +++++++++++
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 83 ++++++-------------
 include/linux/clk.h                           | 23 +++++
 3 files changed, 100 insertions(+), 56 deletions(-)

-- 
2.25.1



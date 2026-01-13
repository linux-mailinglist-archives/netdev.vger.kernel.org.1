Return-Path: <netdev+bounces-249544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB0CD1ACCA
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 19:10:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40CCD3025333
	for <lists+netdev@lfdr.de>; Tue, 13 Jan 2026 18:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78847321456;
	Tue, 13 Jan 2026 18:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mPwLRpf6"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013024.outbound.protection.outlook.com [40.93.196.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEE01F461D;
	Tue, 13 Jan 2026 18:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768327816; cv=fail; b=sewbwX/5ojDBLY33eb0vKvEXd9KBcFMqV76hwzNIIAyhJdkwldwpiit/Vwogl6J0kETp8MUP/5VZ4JdDkBpsH/nTwwxweoR5eB0nYNwpy42o7LglDf4UbxE0EHamof45FKZSSSSQT0uIPJBiHfO7Ooj8icvBJY8hccr1IRR3b+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768327816; c=relaxed/simple;
	bh=5mQMClB2jO8YxFb/MBi6E8rbsN3pHOEIt7B0tz/GwFs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IwmsigAI2uDWXj//iVsFWpvrxL7K15jn20X2SBQotveK2Wbz1rN7yLHTS3lCHryQr8fM/WWf8vdVD7eoxSTviAkqIA3ZlfKChay3SyX43QgZ5b9Xx6vH0qLvCMqM6Oy3KWa08NeHTLfMOtgSbWL55t680Pzr+M7Tz9DRjHPmk7Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mPwLRpf6; arc=fail smtp.client-ip=40.93.196.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t0LxcIvKhu7nvt8HSlcQUyVKy4SueVwkwFE9AqEPW4k39+hNn7tVkiqW8H7mx2o5QzaGzilWnHCg68F5cLaGvooNFHLUDN3+OkuDBCu9b7WJt4QH5jlPULCgWbO4J4UWImT277w5ykAzw2V1uKFquv6oQGjUJF0/RzrhKRhJmxUMKHT4X4ZIs7IM2BHF7zsgEq+nn7BAXAzDVvZ9HQMlWM2NnFmi9mqJc/P6UAQAHyDICxtBaIWTzU2SP+PMxq9GRbiyWntVk/KnX9B3DuSVrq0pnDuHsjAqewb1RymMWGKbheN9edyylra1iof9fa0mxjiDC7R6VjVielj+CwPYhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYdVtIoIUhtRzaa3YOSc1dtWbxGdqf/oaQR3iH7dKZw=;
 b=twbIngZVKZDopat2dcygnchtgOh7be6XQqDFHcKrTWF7iVkIq1n46hy/DC7SwJ8SJHHMyRopknF3oCkiTt3zgjyzauSeMTVSedbBYEN/GJJBtLQr6OejjIOsMK+z/gjE86WXWvZK2adMHuFKzUf/9pOGb9RXYP82t9mamwbZ6BdaKXF93/XwTXBrueB1JTFTbUtZx0e/6wbbUTnwZn4ZBPBj1u10JKiH9Y3xVoJ7pIJAucQGn/7BWlRbZnUEbB+cry+1EPl43u8vAIeo6l2i4JrVfAht0uPbASKyl60QvDT6y4guMDHxF+L0l1wFtyFSyTNzDdiEQ24eKPwsNYasrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYdVtIoIUhtRzaa3YOSc1dtWbxGdqf/oaQR3iH7dKZw=;
 b=mPwLRpf6v1jOERmBeQQfLIVcYQUL6PQ1LIffblG/JV1vMG4Moi0kB+HKmDn9dE4lt5mM2NqsfQoIyyrLGJtoPP58vXW98DGtzfNVJeoVXGnZFA0tQAc50gH8UwJjHxaE2w7MW5WgeKOeaQ/nUytScbjtqWZz1ABZmgsZ38G+jGw=
Received: from SN7PR04CA0215.namprd04.prod.outlook.com (2603:10b6:806:127::10)
 by PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Tue, 13 Jan
 2026 18:10:11 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::e5) by SN7PR04CA0215.outlook.office365.com
 (2603:10b6:806:127::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Tue,
 13 Jan 2026 18:10:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Tue, 13 Jan 2026 18:10:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 13 Jan
 2026 12:10:07 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 13 Jan
 2026 10:10:07 -0800
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Tue, 13 Jan 2026 12:10:03 -0600
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>
CC: <sean.anderson@linux.dev>, <linux@armlinux.org.uk>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<bmasney@redhat.com>
Subject: [PATCH V2 0/2] Add devm_clk_bulk_get_optional_enable() helper and use in AXI Ethernet driver
Date: Tue, 13 Jan 2026 23:40:00 +0530
Message-ID: <20260113181002.200544-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 17288d1d-cfd7-4680-7340-08de52cefdcf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|82310400026|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?XUClwlZ9FsBTEiaYWAIBTRlgKQ0eaoUOMp+Mql+LnoBnja/RVXZXG1PbYw11?=
 =?us-ascii?Q?Pxm1nHgeZxyQAQOjYmORgVc3vmeXMjXAVQJYTOxQbeWLmLBaoVzbZJwJAOhH?=
 =?us-ascii?Q?A5fkbjuh5UIEt6UQFRceTsaMJJ/dsBNP0uhx/XuXefJj+BAv2p3szL7GBzPL?=
 =?us-ascii?Q?BImR1NW65VN9S6W2GKY2rS6DGK2Zeo56jO3ka2yFbN69yReTFQTJUOjDRw/H?=
 =?us-ascii?Q?xQ4E1aJPn+dluItMu6CtN1ODIOG/xwOMggs1qM0m5i4QwPaTbq+l2DDLD9IM?=
 =?us-ascii?Q?rnsYwj+wOxGLRAfkMWVtY522/MCw3ZiieG9Ft8kA8nIC9IJi/APrZ1DFeHMQ?=
 =?us-ascii?Q?fNpNPQyGZLWwBpTUp3y+mLYVAfZ0CoJcibNmtDCy4CD7aFFUOo4yFkVjebGA?=
 =?us-ascii?Q?vYFOipKSYE795Visy+KEKbmk2XdjV9Y+G76XiZWLhWRcOTgK1ilp6pC+h5K3?=
 =?us-ascii?Q?Gb0zBk6SjxhLGx6QILal2KT+qyEMyI5OF3ajQSU4BMvqly02hBLhzkem73hF?=
 =?us-ascii?Q?GqCM9uaxJ19gCZQexPuF5Gg44Rz/sKLWcBg/ZZd5oRxhRnuMtfroofRN666/?=
 =?us-ascii?Q?Bv4pIeMi2BJ3KHGPQeBIp0qY/NS/UsDnG6kMGSv2R+OMFBEuuAqpQISu9Nu2?=
 =?us-ascii?Q?G2MZanrOvmBOSe2YG1+WPq5WMsBhxPD3VORJqCJmg7Hp5dVzzh44DxjRAf+i?=
 =?us-ascii?Q?ZQNddE0GZqsYsBpXtTkplNluZ0wPvzfIkTQyHSPHY4u6DdOOIfAL59IgjO4X?=
 =?us-ascii?Q?QVSpfjySwYfpF8DkwdQWzs2YKvf82ukQ2c2jERfmfzuxvJimwLfynOasxqCx?=
 =?us-ascii?Q?wwW3uQiV8kRy9y+0Rsv/OIahKOQNPV5LnYWt8tiMVw9aYhQ4Y/keYvOW0ly+?=
 =?us-ascii?Q?ePMaaazWw7+QoblSseujC1gGrV+nQCCttKpoZQSaziWjIY0M7kyzfa0EGNzt?=
 =?us-ascii?Q?Qlmcwq9ryQC6CIgsMwCBXCjSraB582xn073/K+sDFmfob2ZU7WzjzC43+BW+?=
 =?us-ascii?Q?XNvKkleSl9oCK9tlCsbb46buwKBeyZwpsasCznaCzRSrWu9sH9pkwnbuYtF3?=
 =?us-ascii?Q?OqwrRsgwc+nas0woKNsJXeZ0xruFFreN07hMoE9Ih9bu9TLoi6MCYTw2TSYt?=
 =?us-ascii?Q?k2QRXLayhbz5zvAR1joVd88YyG0fclb8uDx8ULIWw9PAMMseD5SdklT7x8jf?=
 =?us-ascii?Q?Ijl33H42ITfjrXifzdAyZQyno5pWzk7BIgzAjww8yJeTqAHrXNftydPzqKaO?=
 =?us-ascii?Q?Pe9NRNhc0K0xeyPbJrXJcyPriHeFMVc5eUwsE+FVBNyI/wagQkSL5JRT5Wh+?=
 =?us-ascii?Q?w1jV9EsOT2d2d/N70y60rgCNTxy+REAyb8aQAx1Y4zvwpABeH/4yvw6F0yS0?=
 =?us-ascii?Q?jeJFS+zn+VMU38LoNqJr+kSYmupa6PrFgqiS5Jwsq0MSppavPrJChGPzwgxA?=
 =?us-ascii?Q?OWjoOj+lq1dqw2uJZJvu6IhUNYHQCPMWn0hTH04dl/NKJ45+9RE2a/b9P6Hv?=
 =?us-ascii?Q?nJNttL9GiwBASENj0pWlYBvVMjjvDmZM9Tz4JUjsLvOlprcyox7qdpHqHPig?=
 =?us-ascii?Q?wYDq6torfUW8/r6d4Spma2qxlPBKME8q0q0mtjQs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(82310400026)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jan 2026 18:10:10.7552
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 17288d1d-cfd7-4680-7340-08de52cefdcf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127

This patch series introduces a new managed clock framework helper function
and demonstrates its usage in AXI ethernet driver.

Device drivers frequently need to get optional bulk clocks, prepare them,
and enable them during probe, while ensuring automatic cleanup on device
unbind. Currently, this requires three separate operations with manual
cleanup handling.

The new devm_clk_bulk_get_optional_enable() helper combines these
operations into a single managed call, eliminating boilerplate code and
following the established pattern of devm_clk_bulk_get_all_enabled().

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



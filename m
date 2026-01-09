Return-Path: <netdev+bounces-248378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 19322D0783F
	for <lists+netdev@lfdr.de>; Fri, 09 Jan 2026 08:11:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 675F33013D5E
	for <lists+netdev@lfdr.de>; Fri,  9 Jan 2026 07:11:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FE832DA756;
	Fri,  9 Jan 2026 07:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wby+XHR9"
X-Original-To: netdev@vger.kernel.org
Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010001.outbound.protection.outlook.com [52.101.46.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D0991C3C08;
	Fri,  9 Jan 2026 07:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767942663; cv=fail; b=oHmXcMXOhu0kGJrw57eZRotZ0Dp7Iv9wPy9IMuAjlSr0sZ1MBvCFRjjaldeGWv0y8b6CuFVVmiMxJ41PzLUide6EAa3KdBY2J9oTODuEFuDZE5hY6p/MPKBQpFn0CqJI5RI9WMdScq49uMqYhqXtbMzaPQ9MKpI5S2VA20ZAjjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767942663; c=relaxed/simple;
	bh=KKCt2Lk1xDAPqOeuSadw0ByU6r7SY8KZmyuYbWTuuys=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tRDiDBJA3V3GBrzbgrujxHkN8KMUABBQfQM50LK5mdsqORVS8+UEEpMBllJ0LSfZE9DpymhB/74yxYHrgUsUUc6iA7LrPNuJF/6MifGqJfFq4BxCm1wZjULj9cDSr3C9G+9aSA035wErFJfgF0NQM6cnOBASvzbSpcfPMX/1nDE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wby+XHR9; arc=fail smtp.client-ip=52.101.46.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XMge9qD199qvsx8L3UhXSNEz8UlSFr2DSVaJ/gqxM0B0FgUgy4fzAj5NFw5AtszcRQ/tOdY2vwPnzlfbXSyiok9Bsl/cNdsew/qLqQUS/naE05IFkDK5jMqGSTSaMGKAL2Otn4k5rDS7Nko9AWr6j9x4tnO5Agcs69KfIWqMn39ZqhMTLFY7hQPlAiXeNtG6Cin5Nf6J2y/hKfZ3ZEjBBu6UOuutdQDrjHIa/gAcS9O0KyKB8xD1+KNTFpEVoYEvl16cmMB5550g9Dhgd/tZdXbbs6M8kFR92h27ZGMXb5zbobL7jQdZ7O5S3QKfkrmFQFImvx4Wb6nZl5PeLKur8g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=USGkS9OPe7f150ZLY+4BkT2+mZ+ReeiNtImrgSEwO+Q=;
 b=hxy24Pgb5CiNB47wJv1bXqR178JUFRO0G8IBJT4k8PkqiQJQyls454kGjjM9cDaDnIdv+T1rluFZHOWclpkLN8YYdC4IyLrZozr6JA0XFWsfy9T0Nvo4fM66oZ91oaQNXasZjsPRnf4amF6Biig7I5b2fjb8Txv4qaXQPIA2wiSu4RhLuw0Ok0i4wkQNl9V1KKd0K07zvIeLge648SfJaQOL3H1one/1DpdHTj+6m8RuAEbJNtoV1G9CAVJgOaW9uYdoWNIFCNUlohp8GwhhZgaJS38biEQOeg023/ANH7DeOxfTAJ9Z0nNTxNJzX8ZYHWCH1nCvv08EWHHxc30O9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=USGkS9OPe7f150ZLY+4BkT2+mZ+ReeiNtImrgSEwO+Q=;
 b=wby+XHR9sVpccY1cn9kWwTiwzGT/K4IdKUyuvzhGOeZQ9/c9/8bNvUEimCL1OsfIg1ID4lU6EYXpvu98X66YPuHpnBXJ4cDeMPDtE+gW6sqp+An3iCrbxdHrmwtpMX8kDeTbDTqRkMdpVNfOkROBL1Kbco4gkEydLvNHV1BYJw8=
Received: from BL1PR13CA0146.namprd13.prod.outlook.com (2603:10b6:208:2bb::31)
 by CYXPR12MB9279.namprd12.prod.outlook.com (2603:10b6:930:d5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 9 Jan
 2026 07:10:58 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::3d) by BL1PR13CA0146.outlook.office365.com
 (2603:10b6:208:2bb::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9520.0 via Frontend Transport; Fri, 9
 Jan 2026 07:10:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Fri, 9 Jan 2026 07:10:57 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 9 Jan
 2026 01:10:56 -0600
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 8 Jan
 2026 23:10:56 -0800
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 9 Jan 2026 01:10:52 -0600
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>
CC: <sean.anderson@linux.dev>, <linux@armlinux.org.uk>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<bmasney@redhat.com>
Subject: [PATCH 0/2] Add devm_clk_bulk_get_optional_enable() helper and use in AXI Ethernet driver
Date: Fri, 9 Jan 2026 12:40:49 +0530
Message-ID: <20260109071051.4101460-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|CYXPR12MB9279:EE_
X-MS-Office365-Filtering-Correlation-Id: d07f00bd-ee58-4e76-6db5-08de4f4e3ca3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|36860700013|1800799024|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bOeZKBvEgryEJZpe7YeB/BdfIqw+yJuZ7QihvY8Lj53NVp+7Ho/LAldG3cBH?=
 =?us-ascii?Q?xBGkQaCQDxC9liRwuWZ1E3XTHhabwn/xIVJCmCp6g0eQb9vhgEu18xKaNrQu?=
 =?us-ascii?Q?y2yaHDkQiXSx/1uFBTbIF+XiNVWx2npImQMnWNi5kMqEoZyPaZGhVBRb4W/O?=
 =?us-ascii?Q?GFtTFbGT4QPtxOpdbLR9noWfXi2dwLk6iwuFUj6cTz6tBEUgyzjGc12QdntD?=
 =?us-ascii?Q?Sf6wBgZoUjCDFC5Xyul1pQk9wBfSR9OEDPjGtYeh3J/ArE47Ba58MIvzux+E?=
 =?us-ascii?Q?hYppXcCDDbYcbTfthRyvVZ9EZ/46in6XUWliROjhEAmCzeKUUE9d9mkcmRa2?=
 =?us-ascii?Q?ZKBlHMWqVesbjOw6D5mpdg/hN03A8HgVGzVzgAzP16ce+Pxeots6qA7mawoK?=
 =?us-ascii?Q?u/NhNgxwnyupopIjInWzyG8cjFpVqO0SAJigrGvlyyEC3KYNeA05pFv6QY9Z?=
 =?us-ascii?Q?yd2gym+KpfGW7VnVTOzoxomqrcb5077GtXbWeQeblPw5RKPGJL3hAVuNvHiB?=
 =?us-ascii?Q?SxbAhbIuhENeu3del2Z3IHXNKWCoafHOz8W9CjEn6ILphQvQSS6Obg0CVtFm?=
 =?us-ascii?Q?JoDdm4hq0rfoTwZhcaVPjyBFooT5puFECshs0APmYqW2cD+7DkrdOaUY4Fe2?=
 =?us-ascii?Q?Bk+Uon3dwYk0wImp9OePP2EFWyx/J6B1EslWQA/9pWc8h07qkVDcyVF9wE4c?=
 =?us-ascii?Q?/AtcsjaGqggtEzTVO3DvOZYWQY5eJY7Hm3a7/mevxnZ1jJGbvfkaAZScqrjw?=
 =?us-ascii?Q?idNaBB5kTUfvdnfbjptwBJnJYlEHMrJQNFRNmTkdg02ulLN+rEj+fLtIvIYP?=
 =?us-ascii?Q?sdcAKa8m+MExEOrf5nwaOZEzmJ0DdGg5VO1NzLmfKpGj3L0boQLjXbNsenU3?=
 =?us-ascii?Q?9Xw/eNRISi28NycX/1r37XLrygyjnDQjW2FdzzQPDpsPOuvNo2Bjr1sUl+mh?=
 =?us-ascii?Q?jud5xOLIubc9rpGj3Sgxk6gYWZ4v8P21QvAg0Hj92lsJRNcmyJ8JAHD7hH5Q?=
 =?us-ascii?Q?WeVeg1lqdSjYJH1cFqhf5+/wv+o+xmwTF0yLybbXXVXUUdwyHA8Z2q8aWMrU?=
 =?us-ascii?Q?/O8V0Ny2CFIgEK653zaraKSBa6UwaEFie2ryWfdsJ7EdCkxt6zqy/+lyTsqw?=
 =?us-ascii?Q?obFt6tNLGOkgGYjPbRNdpF+Do0rGyarJTX8qPIrKt8qhnA3t2SN/S7a6FRyW?=
 =?us-ascii?Q?hRl6515eZvhGn2KIcc6YjihMq8Ib4Xgn57jzI4zTpqnpWMtP05VpIOz+NGcI?=
 =?us-ascii?Q?N/GII8e46eBeP5oAXtpMhAq8dqqEzPP7njm5//aQXwoK1vRhxGH6tfL/PxQz?=
 =?us-ascii?Q?C30/VQscoG+lJ94JZyzfHWdR8iSFbWL4dOsLtu7FZcrguX1AvuUTJ+7Vi5PR?=
 =?us-ascii?Q?fTJkSlW32dMcc6JT9wE1uVAYFXdkVAc5JOG3Oy0FFgVJvV+Wz74e6LQmNKXM?=
 =?us-ascii?Q?KynwIhIjcp5wlSVETjkDog+nh3Rqxg2VZ/GrgCJo7qVPV9jP+IFMqWiPNSKM?=
 =?us-ascii?Q?Xubw3lmLW7VVAxd/HBbGIJX+DNjvkbp3fzZ9Bju+pY55eg9XQDD9inZoEoGs?=
 =?us-ascii?Q?kRFoS/yG15Ls6vOLECZl696P/k46uGZN1AdqvSnp?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(36860700013)(1800799024)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 07:10:57.6141
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d07f00bd-ee58-4e76-6db5-08de4f4e3ca3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9279

This patch series introduces a new managed clock framework helper function
and demonstrates its usage in AXI ethernet driver.

Device drivers frequently need to get optional bulk clocks, prepare them,
and enable them during probe, while ensuring automatic cleanup on device
unbind. Currently, this requires three separate operations with manual
cleanup handling.

The new devm_clk_bulk_get_optional_enable() helper combines these
operations into a single managed call, eliminating boilerplate code and
following the established pattern of devm_clk_bulk_get_all_enabled().

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



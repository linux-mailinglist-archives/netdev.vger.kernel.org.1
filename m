Return-Path: <netdev+bounces-246550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D247CEE065
	for <lists+netdev@lfdr.de>; Fri, 02 Jan 2026 09:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D9DAB300995B
	for <lists+netdev@lfdr.de>; Fri,  2 Jan 2026 08:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EAB72D73B4;
	Fri,  2 Jan 2026 08:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kTX30Swd"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010064.outbound.protection.outlook.com [52.101.193.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A8226D4F9;
	Fri,  2 Jan 2026 08:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767344118; cv=fail; b=FnJaH0040F3W6ZSkr40clIrOoPTOt0HEEzyN/s9sRwq+Nlp524lIDBT5OxkObvXPc9Ft/n6LDm8/fUnuITswXsli2lE+X9N1kKpDSBwb6wQgzCudB0z1BZZyPLt35b4Di+B23ct+f17WkK63ltdhYHIveIpJpyupxE/Pwi1+1mE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767344118; c=relaxed/simple;
	bh=lobpFxl7VYTGeQqG0CtVrV9qupkk3X0idtdl/6YAIy8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Qoa0B8Lqh1m4WpEOBBk7fvb8z9TxLhTEshzg9OVgsimiTPg6Jrbxqytxa5yeA50sbjCMUDmYYl7lsj9mH0dCJFxihjpwmCE9dGcC9sqarthhZQIpOth2bdTXXqIQA9QNx5NRpIClLMoh0xSP/F8UdbouC6t7n+pZ6RxHCKim7Hs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kTX30Swd; arc=fail smtp.client-ip=52.101.193.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LN3hzEsroN9/kUadoyaX1jFFNN7uyCKeHYwV/LhDMsTSuL9PyQQRGKn/GmnGYYM8OefV/0AEPbGgqOLqMXmDKz4pF/xKytNhRvCkxRQuwII/slKzw9eCV7Dqb2IWZG5Vv5cEWO8v/Tg9LA0PIvUBOJm7yEE6FHleP3bt7evv45R9KwdOOOs8eSo2+gWQGpiLacemA9cbIWdZfS8dhOuk8APLczCMhjHVXARzAai1e1D1cJuRuqO0W+QzOrx2geLxpMOV3RpADcj1yCglgiKWVTBer7y1iqpK6l210/e2kZ2Kf27QpW+nlTcA1U6uIhdCYmd0euAzOvHarFsOlwmxEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1n0GBmZN8YoiNkT5cUhMNMTblt2s2nH5jjCBaZC4rJ0=;
 b=WHNscQDrFKpEieIHMjW0nMpzQQ9tWGtplKF+4Kry+lduTG+p9z6M8Lu81QLKqwRVnRp88gbKbR8FnEN2wp8C8jDCeww2zjabE9oTc0Z/5NZCExOfY8t+sT5ZP3KKoBhkW/C/8NfdFFVD2rj86k4SHDrAAtwEKPlhc4YpZ0EJtvR5floBVlh/q0Dgi8Zuo/jJcbDffJDvlk20FmTsJURQ5kq/+pSP4gwkVi23bGjFsj+IiQ5QXIUCw5Ehi1G7E0hs0GVO8HSJHJCK2xItHFBxtTI8meFEt/RCq9e8ldLxq+7DRaMLqbEuhqsFBr19FH9jcL8bdt7RDLT7G4RgYAycZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=baylibre.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1n0GBmZN8YoiNkT5cUhMNMTblt2s2nH5jjCBaZC4rJ0=;
 b=kTX30Swd+kbPspY8W/EVO7vseEZ3EopRy8cSVbx9KFJWxNEJmVjHH+f7qCsj8o0SQpE8Ouyhm49QOEpVs2+RmIKKJNDAbQpMNlVKAjjYKdcoVbyBUqDIYEUQd1tj0FA5Sh6LLmQ8tu9mQ447xXT5nJHLOiyqd+h1EbZ2LqqbtEg=
Received: from SJ0PR03CA0004.namprd03.prod.outlook.com (2603:10b6:a03:33a::9)
 by MN2PR12MB4045.namprd12.prod.outlook.com (2603:10b6:208:1d6::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Fri, 2 Jan
 2026 08:55:12 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:33a:cafe::1) by SJ0PR03CA0004.outlook.office365.com
 (2603:10b6:a03:33a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9478.4 via Frontend Transport; Fri, 2
 Jan 2026 08:55:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Fri, 2 Jan 2026 08:55:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 2 Jan
 2026 02:55:03 -0600
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Fri, 2 Jan 2026 02:55:00 -0600
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <mturquette@baylibre.com>, <sboyd@kernel.org>,
	<radhey.shyam.pandey@amd.com>, <andrew+netdev@lunn.ch>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <michal.simek@amd.com>
CC: <sean.anderson@linux.dev>, <linux@armlinux.org.uk>,
	<linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
Subject: [RFC PATCH 0/2] Add devm_clk_bulk_get_optional_enable() helper and use in AXI Ethernet driver
Date: Fri, 2 Jan 2026 14:24:52 +0530
Message-ID: <20260102085454.3439195-1-suraj.gupta2@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|MN2PR12MB4045:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d9de3a-9d53-401c-3902-08de49dca382
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|7416014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ppFaR61LzmXh7p0VbmG4pHloWmGKY8uaD1wmDXLT3YpDnsbn9wuB+jzL65J9?=
 =?us-ascii?Q?NK/3Cl0nJ+bUqip8oRqebshktJ6Pj/n3pHXPV0K8cdR4TVgwjRWL3Z3y86s4?=
 =?us-ascii?Q?I09/uHKOl7F/M5HSikEijb9YPPBp2tpDbLnJoJZWAnDd5w4X0drbmat/CNiL?=
 =?us-ascii?Q?l0zZKT60Gij97OiHWFb2EzhytJEDWPojPcLSpQaMnXqfPiRbgR60Ed8TfOu+?=
 =?us-ascii?Q?FHpmceC9lghMV++tgj1npQFSfxihgjvl9zxdCtS17zLDXdQ1Mblx6HimpvAI?=
 =?us-ascii?Q?h36QLlkIIlPcRx74jo7TvYkBtziXNZTr5MpFGqBfRuFr9Z7T+U8Oy/ntrRon?=
 =?us-ascii?Q?UmPyumN+O7iOlg2OJy0b8ADGHRrzmK0/JP1uaEZtWdPJq0cnTvAdp/vUbMl2?=
 =?us-ascii?Q?sNdnocmq0rGA4+hvsP0+t7fsu14CnoWUxV7xl7y+qOEexiwXj55+cJbIcGQF?=
 =?us-ascii?Q?q9uuxhmtf7xGfgV4NqeXG/uZuy2eRbw61WqyiZv7cLls4btCMIDUlTZEBaGt?=
 =?us-ascii?Q?GFRsTs7G6haLycMYQ2uyeNUWFUvmub+SL5aRWquVfJjs/NuMKjRZz04dlURu?=
 =?us-ascii?Q?GGa0b4AAeFPWbdLvghRl28i7Z2beDc77gMzgQ/gERdDZpSnqNcPeDMcFOAs0?=
 =?us-ascii?Q?wbHl7SlcmPX0fFAUdVHUNbIcp5QMvq3oSoSWSlek/t4RE8QAE/1ePHrbf9NT?=
 =?us-ascii?Q?6GyLKNn6OPm3cycFK0W2PkdX3uAZY5Lflnx0NP+Jou3ruJZCb8RCUuzafEA1?=
 =?us-ascii?Q?/5uYY4KwudAi9JoxBkAfBydgJLeJdhMs2mPeBJUFgUjUEevwLEDq81K1XvUg?=
 =?us-ascii?Q?6SIFZLWApFWUaBSN92yt37FRAjUJUCtBjpRb4T5zr5/51nwC02XJB6g6pQ4j?=
 =?us-ascii?Q?8q7cgIi/mODE7K4FQSOnFQbWCtgjm52zrH3qgUR9TZOAEbtXAJFlAocXH7l2?=
 =?us-ascii?Q?awDR/cjT+k1yAUJMeeQEPnqe+OpbxbU0p4l4ktZ8za4E5oDS/ltI2WT3Gr8V?=
 =?us-ascii?Q?tH/463+zaLWBBA1xKdLoMw3lYAkjJGA8SBN7F0Zv/lPBP+B+4XZ20pUIdxB8?=
 =?us-ascii?Q?1SsX421Nfo3Ytq9gtDC74crZ8mwIpJtKD0RrpvM2j6I5dbn2FJaOUbn+FncR?=
 =?us-ascii?Q?B7ysXRVRwE9tTnrbRRJwU0UYCwvu9QsiwMxAVRcbp2BTlmZtoYa5I1oPc2py?=
 =?us-ascii?Q?xKr7Re4BJT1QnVTOWx5JMDF0T0/NJZVsHGQ/YXTlzKd1M7JK1fn7lOcvZ2n1?=
 =?us-ascii?Q?hMljE4g8myF/uwokrrrq0lTUgk1zPX9A0/9V1+QSeZh39Q+Mln1MUUUlCs4a?=
 =?us-ascii?Q?5N1PuttCs3+XEkKmai6I3ajbClkxEam9KgeHVVbbFrblPXbtYM0a1kKjTNd0?=
 =?us-ascii?Q?5txNyuKYXUxGZKCJ+MAHEWoq7wNzK56fun2gHlU7iFY2F8H33p2iKK5W+PV1?=
 =?us-ascii?Q?0PaWKY1wViWybsDxgUubvK/g1QO+zjPpoYouokhJWBakGAA5z/KJ72ZTe8bT?=
 =?us-ascii?Q?NEpOCSaVSFqRvvKxc1M/04b43oS1xViZDrj7Ys6+QIk9mKxG38EOZgG+8aCj?=
 =?us-ascii?Q?JnPoEkhQt978jE5dHa4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(7416014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jan 2026 08:55:11.7223
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d9de3a-9d53-401c-3902-08de49dca382
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4045

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



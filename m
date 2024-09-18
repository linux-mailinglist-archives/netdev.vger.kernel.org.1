Return-Path: <netdev+bounces-128842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C6C97BF0B
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 18:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4971F21A51
	for <lists+netdev@lfdr.de>; Wed, 18 Sep 2024 16:18:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 895571C9867;
	Wed, 18 Sep 2024 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hPzyITlF"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2047.outbound.protection.outlook.com [40.107.236.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECFAD1AD5D6
	for <netdev@vger.kernel.org>; Wed, 18 Sep 2024 16:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726676282; cv=fail; b=TENTGSJsu9exxF0Uut19NHR67uxy121PEvK63EwnfNlF1Y4jy0XdZe5IUB9DSPcurvoIA6VRoBt5nYwmt6E4GA1D32xYEIKTRaagSYBD/o0qBCzEAJD5VXYyYdIzfFqSIEeTsLYLWEW/2z9fr8K2Gbiph/svv3VExjb/7pXcto4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726676282; c=relaxed/simple;
	bh=lrdxbv+E0tNL4dis/KXsKr0MvXkF7ZIzYFhbcZZoDPk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I0j786M/sWJvF2EXVISVqlY7/TlSw99UtMKpM956gTmf+dDGi8oJhUO7AM8QK16+HS91EXlYnh6kD4SsLzbVwLFhcm9oxKIkzqalQ08REv9FS0+2jHpEHwuBk+wiwJ0Fnv1FoLvzIxDMBBjBFCdVaCYL0vjLwy3uSIVPGNTYX5E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hPzyITlF; arc=fail smtp.client-ip=40.107.236.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wT9tvLnPUIVuMaoLxYQtARpeFn4WcwiDtNg9XS55evaOwl7SaHIY9gARycMj2drWFwQOlPqzhc6LvBFHJJ/QLkPXBrtH69xJJB1l/HkxDLg0YbLcBJ/Mq7YQDB26YUXIXlbn0SPlYTuSXTNR7W67a3oPjWYQcat3rGIpmYFePDwSNupzYkO6S4t6VbKuGVrUHOSHQfR+xYRAb01tHQsJt4+1DJATHPasXGrv2yOiybDCrQ3vhfFkLfYU5A/WZYL7igX5gLB310D4kOW0l70txqwwlYSn0A1XcqpVRjhrBYPJflfMqpQSLn+OOFqinGwYGUK4IzEiD1PevxKvcDdVHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7uhdYhD/p/lVTjHPBQrloBbzJ3PrnOP2Pb7oVY6346s=;
 b=YsLFjj7JGJa2q6HhO2Ee6Vr62t4lEWQHJSDSwrQUEgxJ0HHio7O/nIYhHW9c26gsQVubsiDKv5QOap2gsqDsKFNq3DChMwOOXWUu5rJTHld5fckASgL9W6FQKVe3EHTig0zPOvwxLnYc7GGod2Gqk4Ri9LlpDVGu+8AZbBLDoWgRTEAEf1aaVdj4LYoCNVrljlyeOAU7EJ+LIwCgZnrkzOgvnqFcxeyIsY4m6SXeMr0Q1MdOt4/+KQDL8coKaVwvMKJeiWd0cJS2cpIbTDaEWs5VFWPyOiT+CXAfCiHQx0I2z2Cog01KhyiAq0xr6rvVcNydKLOj0D94Dl0R1hd+2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=davemloft.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7uhdYhD/p/lVTjHPBQrloBbzJ3PrnOP2Pb7oVY6346s=;
 b=hPzyITlFAOcXOe1UpPvxZn5suPTLqfo7xKHx7A2pfzPzaCJAtbP4PnGjggpC22ejOi+Zv4LYpAoqpuLhkwKvO9739BWgg8vve7dudXOnpE9Dz30QtrSsuGVZqFdcH9xQzNwjAh+XMPdgmO6Fa5+nlrXX9tVjHKMfGzYLq2R5Cjg=
Received: from MW4PR04CA0280.namprd04.prod.outlook.com (2603:10b6:303:89::15)
 by DS0PR12MB6654.namprd12.prod.outlook.com (2603:10b6:8:d1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.24; Wed, 18 Sep
 2024 16:17:56 +0000
Received: from CO1PEPF000044FA.namprd21.prod.outlook.com
 (2603:10b6:303:89:cafe::82) by MW4PR04CA0280.outlook.office365.com
 (2603:10b6:303:89::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.25 via Frontend
 Transport; Wed, 18 Sep 2024 16:17:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044FA.mail.protection.outlook.com (10.167.241.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8005.1 via Frontend Transport; Wed, 18 Sep 2024 16:17:55 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 11:17:53 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 18 Sep
 2024 11:17:52 -0500
Received: from xcbecree42x.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39 via Frontend
 Transport; Wed, 18 Sep 2024 11:17:51 -0500
From: <edward.cree@amd.com>
To: <linux-net-drivers@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <jacob.e.keller@intel.com>
Subject: [RFC PATCH v3 net-next 0/7] sfc: per-queue stats
Date: Wed, 18 Sep 2024 17:14:22 +0100
Message-ID: <cover.1726593632.git.ecree.xilinx@gmail.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: edward.cree@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FA:EE_|DS0PR12MB6654:EE_
X-MS-Office365-Filtering-Correlation-Id: 815ea82f-3dc6-4389-ea31-08dcd7fd7400
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DctLLrB9mn8rJiFAFyguySjcv/XVGmMYMUNOdacU12jLSBtGtaoFbCoZGL9C?=
 =?us-ascii?Q?JrCaz0urJ1/g4np/W2xRnHDw3KWxvQ1ZNx77Vt85PlIuQF2fro+ZU/zZ5VED?=
 =?us-ascii?Q?3sis5QjP2tgTlI8ggzQancYSGkOOlPZ8SXV7aoLm/EUnS2Lre437sKzmrmdp?=
 =?us-ascii?Q?uQJngbJTSPw6aQeXZqwI+mVhcplPmNycUHQyHjsd0vpWIdkZk42XaHC8kN6C?=
 =?us-ascii?Q?hCfP+IzzvXKTgi8uVD31WxO2ztZ2ESOniDlS4qsdmBjfGLNLc3ssk9JUkxKW?=
 =?us-ascii?Q?DEyRnqjSVaMI1GV5/vw3nlS6k0zgsE7IryK2JPiDKf5h1fWsnTRPYacmOmOD?=
 =?us-ascii?Q?f5R3ZtoLtiooJdp4qX959lN2IJ3AssBbeqhN0y9KyEApxqGWMwXYeTqL9zZM?=
 =?us-ascii?Q?4RHotFa2azyiSVLz5faEFshgKqcXmWUj7WCoEKzm3MbO8eqbUjNw5FzBrk8y?=
 =?us-ascii?Q?vyW0A6PYzrtYTUN0p1ugZhX+jgRInO7eeoBwwo0CZObj+1Njw9jRvyq3AzmO?=
 =?us-ascii?Q?ReonBHflLkvWMpOkhFf0Tq+eKS6Od3vQPSe77gjrVPxv6IXTg2ua+Mb4MAnR?=
 =?us-ascii?Q?966izzHTiekYiZ/O44vhhjwDHHmqHK43woDevSj7bMpwlDxFBK/YX0j79oTY?=
 =?us-ascii?Q?BhxCUNrFWJcz3LNHQJMyk/e6Sy1bmTrEFHMH2IOTTD7qzmZulTOxaNVbkoMY?=
 =?us-ascii?Q?apBx7WrDFSceOKp3dr79ah0hVsweNtdTF1X1yt3wnsYFUejpN2JVC+AfoDct?=
 =?us-ascii?Q?5Keu5iS4O+EjPfi8GEmGuHYtSF1kd0M7KsEVdKmqtY+13aNVWTmDwET0amgK?=
 =?us-ascii?Q?JzrZEHfnc+mPNmX+9cP/TOCs+Bm+Hm1Eld/xtJKtEnwGPZQZ/lkDMW1MLclx?=
 =?us-ascii?Q?NQP0HlSZCD2BF4X56ktr5Eh9Ext/x8NcaPGBK0+/TrU4ece5tgSSeQfi1VjP?=
 =?us-ascii?Q?cxj6HjTtP4Krbd6h22mLVKIVYAzrOkNnVapZKS0F9WHrKOW0lLGijNtMQCjR?=
 =?us-ascii?Q?olNMxM4oL78r9FXklNU6sK1aJTbM+EGgwMLlzxt4hA6JWJinSzog0pu9U+jI?=
 =?us-ascii?Q?6idJ3W/sTdDSfMT+HCDV12b9NzgBXucGZXuHJLR8+pHgtEWpbg+5rdO0bSJs?=
 =?us-ascii?Q?x9Cfn/Yk7iEhcm/8Yp4W/frUeaNEqlQEMoLivMHRGEhXtMd3U+PDGRtU4ZLk?=
 =?us-ascii?Q?Nv04fOcr5iP8jGK9j8xHF6/C0huimn9t2dWxbcBkLBKAOVTAVYCR/AvpTCHE?=
 =?us-ascii?Q?qWHf4+ooQL6zAOJcb56CFjQfLwMvSNcf6K2il157iwEE5g/dy6DBJbeFNxL5?=
 =?us-ascii?Q?DY+haEVEGU7KSwV1uXltMYbRHpt+xHoZtTpMpulN5ITQO1GxoGaPz9mbKD/4?=
 =?us-ascii?Q?5ex+DawcSoOX6dEUo/SD9KUqa4N2QtF844O3dcbdiAqPNjUQXhAXufMNnCg2?=
 =?us-ascii?Q?nOnLzjIH1JcTXz7ktjje5XbmgtxW6Vfs?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2024 16:17:55.1120
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 815ea82f-3dc6-4389-ea31-08dcd7fd7400
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044FA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6654

From: Edward Cree <ecree.xilinx@gmail.com>

This series implements the netdev_stat_ops interface for per-queue
 statistics in the sfc driver, partly using existing counters that
 were originally added for ethtool -S output.

Changed in v3:
* make TX stats count completions rather than enqueues
* add new patch #4 to account for XDP TX separately from netdev
  traffic and include it in base_stats
* move the tx_queue->old_* members out of the fastpath cachelines
* note on patch #6 that our hw_gso stats still count enqueues
* RFC since net-next is closed right now

Changed in v2:
* exclude (dedicated) XDP TXQ stats from per-queue TX stats
* explain patch #3 better

Edward Cree (7):
  sfc: remove obsolete counters from struct efx_channel
  sfc: implement basic per-queue stats
  sfc: add n_rx_overlength to ethtool stats
  sfc: account XDP TXes in netdev base stats
  sfc: implement per-queue rx drop and overrun stats
  sfc: implement per-queue TSO (hw_gso) stats
  sfc: add per-queue RX bytes stats

 drivers/net/ethernet/sfc/ef100_rx.c       |   5 +-
 drivers/net/ethernet/sfc/efx.c            | 109 ++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_channels.c   |   6 ++
 drivers/net/ethernet/sfc/efx_channels.h   |   7 ++
 drivers/net/ethernet/sfc/ethtool_common.c |   3 +-
 drivers/net/ethernet/sfc/net_driver.h     |  47 +++++++++-
 drivers/net/ethernet/sfc/rx.c             |   5 +-
 drivers/net/ethernet/sfc/rx_common.c      |   3 +
 drivers/net/ethernet/sfc/tx.c             |   6 +-
 drivers/net/ethernet/sfc/tx_common.c      |  33 +++++--
 drivers/net/ethernet/sfc/tx_common.h      |   4 +-
 11 files changed, 210 insertions(+), 18 deletions(-)



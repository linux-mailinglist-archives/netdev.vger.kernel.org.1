Return-Path: <netdev+bounces-64268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2B19831FAE
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 20:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 10EFB1C20B0B
	for <lists+netdev@lfdr.de>; Thu, 18 Jan 2024 19:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB4DF2E3F5;
	Thu, 18 Jan 2024 19:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wxxpVt4v"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2045.outbound.protection.outlook.com [40.107.223.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5522134CD3
	for <netdev@vger.kernel.org>; Thu, 18 Jan 2024 19:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705605926; cv=fail; b=CBYfj3QNGRTrxynSdmYtzi3klAexTx1c5zdSRlBRxHJkokuBIQDev/QluVJfgVaCPIgWOsoRYWTeJAooTWv0f6DrTQQJTd5LkS8B2UVgWBly0t3g7kpESfKg6hI2NXIZACWGqg9eE4sV7xmdyIt11EAoqQZ4H0crbQbeaTiBXWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705605926; c=relaxed/simple;
	bh=GDhHfgDZYVQ5TfF21b+sXRyidAS22zQh3CS2oM5A7fw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Q5gZNkQHghka94s6k0U6Ux6wBogDyf6p5G26+sRw7Qp05MVZb3aP4Kv2mdG0X5/CXwMYvaUJJbYDudFs5L0V9e2S5/42yVsV9bkCm++GWF/Xgh8XYuT1keZVzd2Id9ZxhRKfJjygiLWF+zvs2I4/ia6GDRz942pjpBjFK6YK8Kk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wxxpVt4v; arc=fail smtp.client-ip=40.107.223.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DSB2hxMtTc8pQHwW7Ju7KLevYm1YA8kXgt1+a2OKCJCTEvd/BCg1WFh7J/ua9C7OLAiF+V0XrVb3sPSg7z1K+WjjBzcvS19NlShpeS7ej+CH98kFoIsu0oMRdqZ8YLFqJuA5yBB7lJ2o/mHQfoq2J7z/yI3U05YeLwnd7nbjv4ISn2sWBMZeH+Os2CCFBY46crAyiXsgptIyh5YO1lIbM3zihPyTL7/coGu/5JfYd5t1p4yPYR6ZGqhSEPvE4arF8Lod3EzakPPKt8y4VsW2cIpqkQYkmQfxYf+0kNkcfSVbDd+AYWvBF8VhO6FZ4wXkpu7WlkRRMRGiGTxLiZGLlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JircRsJuUUeredaeNAxOEeUMGqHl3D5U20oYEAoF3Lk=;
 b=EZGIxafggNA/0tb6fkpcuDJAVeiZZBBWKhrEnC5jAGDBIbwPXe6u/LMljG7L/vgomfLfRJbiLEKvLURVlvNOJmIZPvUbMbwsugg8ZGNgxvIghQMK7TIO74y6v+hN4yWUKe9g3rqnFj5CJitMjNWZrMM+zkM9fg1FpUW4qm6h0zek3zp2yiCAQiulfZQMIkhLJQlGlhsZEk7ZJD4O5hs8k/j+xrpYQKd+8DWPlprAj6NyIAobU8STpZfisVy/dalJIYpENYS1iNB/GELZ0pJke+ToD5YNAUT2DFEKE4eXkkr5zKFyxC6+Bi00c0qGfSNkAEGQlJfbQOTQTeIuPNIJjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JircRsJuUUeredaeNAxOEeUMGqHl3D5U20oYEAoF3Lk=;
 b=wxxpVt4vtA7pSkGtjWLkimeojklbmtxRtRse+WoAZk/iQTHBEF2pnlFeBfI3BHehPdtE57uvbXLh9BogrS7qsxR/sbRvA3v1wLfPam2/rF5UmCAJJaF2p3pBm640mOXbV0h6FhCohKwLHI82f9SYpU+OBGJFvzxD+oFcAQz/MC4=
Received: from DS7PR05CA0102.namprd05.prod.outlook.com (2603:10b6:8:56::22) by
 BL0PR12MB4913.namprd12.prod.outlook.com (2603:10b6:208:1c7::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.24; Thu, 18 Jan
 2024 19:25:21 +0000
Received: from DS3PEPF000099DC.namprd04.prod.outlook.com
 (2603:10b6:8:56:cafe::7f) by DS7PR05CA0102.outlook.office365.com
 (2603:10b6:8:56::22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.8 via Frontend
 Transport; Thu, 18 Jan 2024 19:25:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS3PEPF000099DC.mail.protection.outlook.com (10.167.17.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7202.16 via Frontend Transport; Thu, 18 Jan 2024 19:25:20 +0000
Received: from driver-dev1.pensando.io (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 18 Jan
 2024 13:25:16 -0600
From: Shannon Nelson <shannon.nelson@amd.com>
To: <netdev@vger.kernel.org>, <davem@davemloft.net>, <kuba@kernel.org>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>, Shannon Nelson
	<shannon.nelson@amd.com>
Subject: [PATCH RFC net-next 0/9] ionic: add XDP support
Date: Thu, 18 Jan 2024 11:24:51 -0800
Message-ID: <20240118192500.58665-1-shannon.nelson@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DC:EE_|BL0PR12MB4913:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ee1899a-acac-4f50-dcc6-08dc185b3645
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	aiUGRYY7OmYLSOmuHFN3FWPAFl0y6JiNd9q2UDiXQpvo59cbTO/rvuIcooY2KZmCl0Yz5uVsx1oBfB08vQD3np9kfFvsmuOEKGpD5lE4JuU0p6FBAsuOCZWfnIW7Yi0Mh+gdsaM9VpifDoA23cxprnGTODG6UhhYFG9YLDVkIR4crqAZQ0AHr0WZuLggWTY9NssIYnJYV9yIiyzprkT59Xg+l/1dlREP6FlVKkuVwgfkUj/fsNC/YjmL7HM4906BXfQPp7LoJ5sbHHsYRRAelqBK3SQ6eqcn4qQOOAJ+qo3C6gYzSGADnnr1JgT79DOACbu8FHFI13Xaa/X9XpLmsOascOMGxykYnPXM94YhIeDmovAMgw+D2YaQGEjpQLBh6am4QrbwhXYZUfkWbIeFk57ViSvIIAEMk/8Sl6mO4I/apZpuAUVEOZ6c4B2gB4EmMI7ZkRbSOG/PxnbGuCNDYVYVP6Tl7IahN/yYT2SaidY+V7cqj177oL3xm9wKQLUcC6HUffRUBW5P59cD0ssoz5Imbt27q1QGBiIbh8HZG18Fj8xBW6urJLRXqT9Vn3Sn8QRXWkqdNYKnbBnhNT8gZ3HzrtJdfDN+IXWflD0LLCtJTegmxLhQKMzskEVZWSH5x51ZJTPbcw0POz/58MKthZx8ZC8dISQFUbrFmHTlmr6Ja9VEG6nzMUmUVRGM0aaK4gzEgcSk6mQTpMm2XCYJj1UGitSPK8uKVj2nloswcPlsJkKlS0Ny4xCHHcV12vV16FEtIAy8CLEpqRqIxjWkWw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(64100799003)(1800799012)(82310400011)(451199024)(186009)(36840700001)(40470700004)(46966006)(2906002)(36860700001)(36756003)(86362001)(41300700001)(81166007)(356005)(82740400003)(110136005)(316002)(70206006)(70586007)(54906003)(478600001)(6666004)(8676002)(4326008)(47076005)(16526019)(2616005)(8936002)(5660300002)(83380400001)(336012)(426003)(26005)(44832011)(1076003)(40460700003)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2024 19:25:20.9531
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ee1899a-acac-4f50-dcc6-08dc185b3645
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB4913

This is an RFC patchset of new support in ionic for XDP processing,
including basic XDP on Rx packets, TX and REDIRECT, and frags for
jumbo frames.  We present this here for your comments and our
education, and are hoping to get it merged into net-next in
this current development cycle.

Since ionic has not yet been converted to use the page_pool APIs,
this uses the simple MEM_TYPE_PAGE_ORDER0 buffering.  There are plans
to convert the driver in the future, but not yet scheduled.

Shannon Nelson (9):
  ionic: set adminq irq affinity
  ionic: add helpers for accessing buffer info
  ionic: use dma range APIs
  ionic: add initial framework for XDP support
  ionic: Add XDP packet headroom
  ionic: Add XDP_TX support
  ionic: Add XDP_REDIRECT support
  ionic: add ndo_xdp_xmit
  ionic: implement xdp frags support

 .../net/ethernet/pensando/ionic/ionic_dev.h   |  11 +
 .../ethernet/pensando/ionic/ionic_ethtool.c   |   5 +
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 190 +++++++-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  13 +
 .../net/ethernet/pensando/ionic/ionic_stats.c |  18 +
 .../net/ethernet/pensando/ionic/ionic_txrx.c  | 454 ++++++++++++++++--
 .../net/ethernet/pensando/ionic/ionic_txrx.h  |   1 +
 7 files changed, 654 insertions(+), 38 deletions(-)

-- 
2.17.1



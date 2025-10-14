Return-Path: <netdev+bounces-229348-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED12BDAE9C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 20:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E57C4240F6
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 18:11:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BAFE307AD5;
	Tue, 14 Oct 2025 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="txHuqbFH"
X-Original-To: netdev@vger.kernel.org
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010055.outbound.protection.outlook.com [52.101.56.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C67A3074BD
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760465514; cv=fail; b=F/XmqtJXWj0kQoEpAHaX5rdrFJDtAHLDCLLYd8DtKzR2xBWNAHWT0v09gR+4H2eoJKorxkybSZnhW/KSMmVopBYn7jDdK8+YXealVJ2A3MknEWRiFaiRBuptgdthLfQ0MdDRdiLOq74nuAln7UDAYIYMBIXve3kamrMB8Q2Bkog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760465514; c=relaxed/simple;
	bh=fWRfX9/4j1KnPj16boNZ2FZ6iSdXu2tVPdaBAZV5nYQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nxccxultoamfjpxhKVwKS/Bd2y4twl9Ph6wh1Sa8fIxNeGoCilmEAajoFts0Nef4sjU7Rjq4uoZaedUdKM5Wz/D1ty6b5L+JN7ImgPpQfNt+v8vrdUJYI9eSYEDn4WA2X2MHNksO694WqF+9JUqgCDn3vuFQaqHlrx614wcN+kc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=txHuqbFH; arc=fail smtp.client-ip=52.101.56.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q7PHCMn9suWg9XCQ++TxFk3sjb17q2QXfd+Hwjv/rwujlk6XYty/YfuxgcpOxb99WWXZzLDEydZvBxMSjg+u6Fj+4U5Nmz4UVc3nsaaMI775DH6byTowJGerN3YtvGmG8F6KwmsXRtasA6yXzsFjfgh3RKNl6LJsETtJq49tZaeyGYNzQ0DQrQH5qWT6GH9qiw2G02C34j6kUfq6vLHUh/+YO35pK1fRWDXixBHBWBOds9NLcUtBaOyu/Y4aJoNrZ9XbVUEJGRywuoTtRy1Wm9QuETauOcYm3G+q9JO5NVa2aXGIR4p7YC97p8AEWIrrqTcalFP85lqLuVfJPQ6QjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HGzU2CXcTv2fvYJOoL8TRJglGhvxMtGrq27yJoXZu7I=;
 b=vOYVx49DErUtNEv3S7Io5K87VKidJMEPhO9fMYfPhC/HeaiH5Yzt0mPnW6KFafbE2c7E/ZU3yExXzGebTQLiCRNHubB2h5t7l2a3tGgawcwqeW8vir21wo5GIlPmCJ6YY1p5nO/8Ue50JgzpJl/9KywXCt0pxg7d58PLIz6Jh+6h9bAHUvnlq+yriK6wkxGr4a5AOcdZrOTLOEHSliClkgkt/NOcPQwITb3Ip9zHCjV9a0i6FoxY3aXnYpmtNs4d9KhekEiWCaBTZWf/HptpkZO9PZFdJpblvnjwHwfveq9yORRF3tjtmEyx/G++iY1VqlGaU0/oD9Fbt7Ysg82WHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HGzU2CXcTv2fvYJOoL8TRJglGhvxMtGrq27yJoXZu7I=;
 b=txHuqbFH857XPrtE0DQoPEKdlb63Q7XC0NVGVCHUlmjmchHoirzg1vDOyiCRwmGk6BLr3yOqxnzmj2uRPGIpKSi2zgcQNhXiWgCRc9M3HigB4DIN0N83zWiHd34U6VzjWxNzmh8d/JNJshB/phzyLRiBUfq/g5QTPaBAUdeYBDk=
Received: from SA0PR11CA0121.namprd11.prod.outlook.com (2603:10b6:806:131::6)
 by DS5PPF8002542C7.namprd12.prod.outlook.com (2603:10b6:f:fc00::657) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Tue, 14 Oct
 2025 18:11:50 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:131:cafe::40) by SA0PR11CA0121.outlook.office365.com
 (2603:10b6:806:131::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.10 via Frontend Transport; Tue,
 14 Oct 2025 18:11:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9228.7 via Frontend Transport; Tue, 14 Oct 2025 18:11:50 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 14 Oct
 2025 11:11:44 -0700
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <Shyam-sundar.S-k@amd.com>,
	Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next 0/4] amd-xgbe: introduce support for ethtool selftests
Date: Tue, 14 Oct 2025 23:40:36 +0530
Message-ID: <20251014181040.2551144-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|DS5PPF8002542C7:EE_
X-MS-Office365-Filtering-Correlation-Id: f3b42142-7f0f-45b2-0b63-08de0b4d2563
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?t/FaDfigJiY7AgFJ2ZgziKWBZXKcKNy/QPIJKGtBvD49eYmbKZcFaaj/T82a?=
 =?us-ascii?Q?XvCaVzeSVy5Z5olsB+zUqmvYGmWm90oONCnzp7TgwZPbE6lAuTLShzuxH2Ke?=
 =?us-ascii?Q?PMe52zWlc6YQlaBhuuGdJ4DzBCdgfkm+dhSlBNJ4nEXZ6Emof6pXQyk4tpHo?=
 =?us-ascii?Q?Dt39aHa1Q1GTBJSMD6gXG1GzVMGjeSzBwyBNUCWJDJa6bfw0PTrFunnKqxLX?=
 =?us-ascii?Q?sjRKFRZ7vjN52jpE6YsMQq1ZgJatNW2wnABYLY1rZ4mSc/OW1ns0t4tYWTZG?=
 =?us-ascii?Q?ynhpAEiTlRtjl0AVPNXoCxfQ9xDHxakw9+QH1cbiSp2C6H/t/fU1wn692yBL?=
 =?us-ascii?Q?jrrv0xempVgpuKfBfnqKiABOOh6nnrSi03l3bZiXhQemJNrqhlKUTJifNENN?=
 =?us-ascii?Q?xIbO/LVrNTspApGyTfmCiNXtxaMeofKJu6x6E6qEW1nOnPoQQZnNSQe3zwlL?=
 =?us-ascii?Q?dkZfKpZlzRtFNu6Jpe7gV3VPSc9R0ksc0juATKHzPUZWRPQYwtmL7D5c1Ti/?=
 =?us-ascii?Q?xaYnDNHPJ4ujurgq/aw7RGMv6oULAQQG8mkvs+BGwaQGTT2LMshh2F/Tpu/w?=
 =?us-ascii?Q?b8kAURl2++Tx9+cymdTmQIaxa3yj5BinnPvTvVwLW2QrMtbkYOQyaSnPnC7c?=
 =?us-ascii?Q?H5Ux0xswHIlfOwbvtZHfGn4w8QOv8tWTABc6kzNp9fZKIPP4c0oZN9iu5X+2?=
 =?us-ascii?Q?0nKOjU3tn7pFjiukWodj3jQ+XxhEwZ6PbnSLREtavIwBGSi8V0t1bM66ebGD?=
 =?us-ascii?Q?ko8kkgf7ZGyqNGZrk1dFjzXeZpXD6Xd3eKB82AjhHH4kKP6vLuuN5F6NBIjf?=
 =?us-ascii?Q?9GOVSE3fqN9VgjVgP+qdAYvUtWP79ogQv9rN7VGAPdEr5vgZpirAzm2R9yWD?=
 =?us-ascii?Q?qbZ135gxqU80/sP4MAtCuPuysSJHjm5OyqgMzvaXVGu4fOYiwFChIKS4z/Fh?=
 =?us-ascii?Q?ODHMmr7mFK3uT4IrPJHejfrF+PmjQoFTtExiI/v/vkFwAdbcPTmwFHE1YtoJ?=
 =?us-ascii?Q?O66+35V1kYPUF+6Bscp3fjbPFZLmvGsh7LQQJ4gkLc6rbgGNpPfitSUN+/Vl?=
 =?us-ascii?Q?A8iSfa73/YkVXoI3tLAXGETKnMhEbRLO2/hlIg2z92q6T/WI6bP9H2a0Qgy5?=
 =?us-ascii?Q?IMicClKj8rmkrmYQryjd2HQnZTMDLxzwqOPPPnuP/WNoYrFZaQkFs0J9edyu?=
 =?us-ascii?Q?KaJp/UJhahfe2cq6RWUGcuEpJ/L7eVmPpJ6kpJjhHDroIrr5YtSDrc8Olla3?=
 =?us-ascii?Q?M9gc8HTSXRVDSSEtux4gGQSYsx6G3UjS/s0AUSfUci4EL7KlZurUttjlMVLG?=
 =?us-ascii?Q?e0cg8RSX+kxbU3k3MTF25QAJrxqaz2stbtXfAdXe9BT+25xn3uWEd1VbU8fG?=
 =?us-ascii?Q?Ju5H+MzHPqS5dh0/plJHpYT2O8IL0kI8KQO9/zsBPj8xE0jd9fVDHdPtCW9Q?=
 =?us-ascii?Q?+I3elLkkO7HOmnY1SCYzNyf8/hrLtUPYKhyfrYYlU75FYlNM20Y0bHnI1UGA?=
 =?us-ascii?Q?ORwoiL5aFcyVrl3gd/J7Zz4GpWJbHBXZfUny/oTHpfTJMeJ5z2b8Fn1f23OQ?=
 =?us-ascii?Q?wrRz9l+vFF4tufBStIU=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 18:11:50.0162
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3b42142-7f0f-45b2-0b63-08de0b4d2563
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8002542C7

This patch series introduces support for ethtool selftests, which
helps in finding the misconfiguration of HW. Supports the following
tests:

 - MAC loopback selftest
 - PHY loopback selftest
 - Split header selftest
 - Jubmo frame selftest

Raju Rangoju (4):
  amd-xgbe: introduce support ethtool selftest
  amd-xgbe: add ethtool phy selftest
  amd-xgbe: add ethtool split header selftest
  amd-xgbe: add ethtool jumbo frame selftest

 drivers/net/ethernet/amd/xgbe/Makefile        |   2 +-
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c      |   2 +
 drivers/net/ethernet/amd/xgbe/xgbe-ethtool.c  |   7 +
 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c | 506 ++++++++++++++++++
 drivers/net/ethernet/amd/xgbe/xgbe.h          |   6 +
 5 files changed, 522 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-selftest.c

-- 
2.34.1



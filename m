Return-Path: <netdev+bounces-186461-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 622B8A9F403
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 17:03:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8505C1889B0B
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 15:03:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38F8426FA53;
	Mon, 28 Apr 2025 15:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="4MoWLkSp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2078.outbound.protection.outlook.com [40.107.92.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB8E189BAC;
	Mon, 28 Apr 2025 15:03:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745852585; cv=fail; b=E1ELLIGbhaHmWb/DmzRSGjzaoI8b/MKxXY7+DhcohNLabtHM78yAA5ihGbECgMhZVpqXCd8B2AXexSo6uS/9CykwVcjJcL5sy37o5w+wHTKV/8mr4ax73GjTqXRvhf2tRbCp+MxQtDK6GRwBhwxhhcQQk75CgkePftR69fVoIAk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745852585; c=relaxed/simple;
	bh=rp+BAeTsm7BXAd0yxvkXDqz6Uji/JpIejAfTnoAnE4M=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZC1nPXFBRJZPY1aBZpDpWpcc0IQBGjEoPzm//7hqCggqdr9oV+rGfBBFtiwJ2jUBwVv9fTbYoComJdWp2DjgOhO0U+MPuiv06o5MavlxdTsXyKMb1KWueVHaKBWtPCE2nLPhwdlP4a53yAXoU1EjrIJDh1QQkbLU26Jqgb8HBtc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=4MoWLkSp; arc=fail smtp.client-ip=40.107.92.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xjJ3d+9RVIblcQiszr0U35vLkmP98YcMB8Iu1wl+82U0GoRNlN5aw2ql8/dVzPsqG3pW4DJWCfFT7tuhKpSHPF4RUjSm7IZCGBes4sk6gaPZH7V7Pdir5iyHIXxtxjD11iWHehTeJjp6L5SmmLiOWpoyF0ABGnzSrIKUwKWTkCE06ERePsYcbzETUl4TIvPWkgfLuBT3LxKmWdjmdD1vc+WhSjSC/ge5eUx/5pSTTnwvQqhLGVNtvkhzsyWiwMHA/anikbFxF11BoGQ7aRHcAn7Mx7S8PxyLUd13jLwQCkQNFEZov9sXS6L4VmounlOMNcjjuVE0uhNQrfQ0EAFlwQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdgWeKoqnoIC2Dr1kWz535qQ+VznrBuO+DScfpvtepE=;
 b=aAkvNZH8Ge8jEh1mnse6iXnpNpm69fkS3eJQYCJrz/8yITfsQlqLDcbHuPKHPFhzldiI3Ge49t/oLmXZp2pVv67EIOvAVlnA4L4IW1s/jIhj0joQ9hZCxOjOzcYVdJMgVfxl3cy2oikkqlJ/0oCl5ZUJUZL4OAgLPoeCry/U8efwDldz6UUlRgEMhNC7fIsF6huLxswBZa3kJyAU76fXmtd2xBDE0zH6pASRtKHHeR3fNa+QnmUiKK0ye0l59smWjMGgE97+6gilqPtSkYRrisojyTkx2yhYtGAwCXDN6I2d1/fjKS/ne/jIDAIsJ3wOxooczfZy9FO5fpx3hYZLpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdgWeKoqnoIC2Dr1kWz535qQ+VznrBuO+DScfpvtepE=;
 b=4MoWLkSpLDO9E6qGw9nbM2Mxv6CvPywJHsXz5V1MEkksKbIJPJK/EchbtvxUmhiiuqVoOhQSw37emI/4Mg1wk8gkipUXwJ9tRcbhYx5Di6/XIjlDCKxhpmIFygAEZs2LvBkTfYrq8nhZEg8MEtLCEkmL1kj49YDnRcdUJtUH46w=
Received: from SA9PR10CA0020.namprd10.prod.outlook.com (2603:10b6:806:a7::25)
 by DS0PR12MB9445.namprd12.prod.outlook.com (2603:10b6:8:1a1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.27; Mon, 28 Apr
 2025 15:03:01 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:a7:cafe::b0) by SA9PR10CA0020.outlook.office365.com
 (2603:10b6:806:a7::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Mon,
 28 Apr 2025 15:03:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8678.33 via Frontend Transport; Mon, 28 Apr 2025 15:03:00 +0000
Received: from airavat.amd.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 28 Apr
 2025 10:02:57 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<Shyam-sundar.S-k@amd.com>, Raju Rangoju <Raju.Rangoju@amd.com>
Subject: [PATCH net-next v2 0/5] amd-xgbe: add support for AMD Crater
Date: Mon, 28 Apr 2025 20:32:30 +0530
Message-ID: <20250428150235.2938110-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To SATLEXMB04.amd.com
 (10.181.40.145)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DS0PR12MB9445:EE_
X-MS-Office365-Filtering-Correlation-Id: be65c874-150b-4e85-c394-08dd8665c48d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?zY2AYRINTtRjoR2alXN09D2zbVTNO963mrPZPWLgpcqVE1+JW5mMTSsBLk0j?=
 =?us-ascii?Q?YZmHBCHYvScKFRr9Vn3RuSsrV9JVEuq5N6Q3iKBOlBpPrrzPZbGYXGw869sw?=
 =?us-ascii?Q?MU8wnz5OtVhIaLDT63EJZCLM+DqbvOBGoXvn+jZ45eZGTwK3C/jk/u1iUI1g?=
 =?us-ascii?Q?+7fFnF7krTp+T1Bmo073/u6qhES4k4WcD/q4Nqon2VDpZXHQI9Tic9oOzz0T?=
 =?us-ascii?Q?/eJAVQX6BHgLN6IIFNMHkKlXLljAf2AK7IDM/tMbIyKmAMTDz2U1KYNTACst?=
 =?us-ascii?Q?q+/O78LZxKmYs38v8VAxUXGJQODgNiR0lZ4Cq025CYD0P8FVx4qkY7OYK0LX?=
 =?us-ascii?Q?Eqqu9XwNApZ8T1Gj024YCkioccVU7czjTIusmqc5lZ7nyKpBiD2IVkmS4l5p?=
 =?us-ascii?Q?SBhBLBFq0mN5QRVsCYITduUsC7PnL3FV6aNJ5eG54Sw4zVD+h9MVbFX6CWXH?=
 =?us-ascii?Q?ozlYd7/XGY6lsx7ML2xWhhIOXrdq5jkhilEDSgxZ7biq2FpTzhOMz7EBAmoG?=
 =?us-ascii?Q?fVtQ2hFw5LOxTDtG2coh726eGrsCImCYM+Nr7SqZSV9eWAq3vr0RYc2TomCa?=
 =?us-ascii?Q?JLCkPqSTtXm6IRkhU0/QoOHSFWkA0rJINBik0ZjCumC6z3cHOgTPuxGvT2li?=
 =?us-ascii?Q?PLMBp+7Y3XJcI+7/QTJ+5VkR9hab/8cDNHCZOUO7LiQ5E756nIrvwjYscp17?=
 =?us-ascii?Q?FKWiMGqwsrjhhZVvPgL/9Be6ffaunSJCyTpr6f0mLGK92ka/k8WtFMTwTLBe?=
 =?us-ascii?Q?HLMglfkxzHBVDUPYJUfMf+zEbAr9yjSfTxJmv7veSYdO1+mwhWp2hMzZBm0u?=
 =?us-ascii?Q?UkS0AL28Jle2iaP/Lwq9flR5N5qGbAKPc3GRQv26yXblYQa+ZKeYb3ztjBLK?=
 =?us-ascii?Q?9di4cwYZ8+NVvXPPqsQRolu+SPysL/YM5NqmDxbjzY2I9UDJl+kelJM7dmAT?=
 =?us-ascii?Q?ltTSOm85V6AcRRUzjlhL3I41UWLdyn1qmKXxGgPY7sL1NRiSaFGLEm8dXhB3?=
 =?us-ascii?Q?P3PoRIfg3An0j90d3Lq7AdoJBGy7mHoJetHYrJQ4Twb77X5hV8GdaqEXASUg?=
 =?us-ascii?Q?fKi69TGDsRcOBXJx3Z2vYlkG+zXQtMzEOTmkJZYxfUZNQFipwHVqLa9ES86G?=
 =?us-ascii?Q?ECWmoIKnAJTTtHbdU8P0PdmeYyoxR07Cw8rec8rZH8PHfWpc5p2lJBORyp2c?=
 =?us-ascii?Q?E79Dqp3uzVdy1cFEUwaqQmAZqMfSP0IaKQJDI5qRFYF3ZliQ9nxEUL5bw3jL?=
 =?us-ascii?Q?9ac8/0lZ03djVkMBZGOLnmuNK62msGt/pJ+IOBl2xNwFqtO6Kse6sHGu5rAn?=
 =?us-ascii?Q?N6yF1v8wNU8Cy1XM1c9Rk2fZ2OH0AnFAJeuzH+o6hBoLlXc9G9TZEvVfjiWL?=
 =?us-ascii?Q?0EIWezLYPv5qIzmmHbuBQmfgJmbiDCX+61iEUVz5ela1M/MNAdej+iByB2jG?=
 =?us-ascii?Q?UFS+rdO0W40dHrWR0FZ6sirp8LizstytP5WTppBr60MpwQAg/Cbe+3XKkpGw?=
 =?us-ascii?Q?hNzZ+e6iaRiVs3oQdlDDIw34fhNmiM6d0q2i?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 15:03:00.3381
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be65c874-150b-4e85-c394-08dd8665c48d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9445

Add support for a new AMD Ethernet device called "Crater". It has a new
PCI ID, add this to the current list of supported devices in the
amd-xgbe devices. Also, the BAR1 addresses cannot be used to access the
PCS registers on Crater platform, use the indirect addressing via SMN
instead.

Changes since v1:
- PCI config accesses can race with other drivers performing SMN accesses
  so, fall back to AMD SMN API to avoid race.
- add the xgbe_ prefix to new functions

Raju Rangoju (5):
  amd-xgbe: reorganize the code of XPCS access
  amd-xgbe: reorganize the xgbe_pci_probe() code path
  amd-xgbe: add support for new XPCS routines
  amd-xgbe: Add XGBE_XPCS_ACCESS_V3 support to xgbe_pci_probe()
  amd-xgbe: add support for new pci device id 0x1641

 drivers/net/ethernet/amd/xgbe/xgbe-common.h |   5 +
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 144 +++++++++++++++-----
 drivers/net/ethernet/amd/xgbe/xgbe-pci.c    |  87 +++++++++---
 drivers/net/ethernet/amd/xgbe/xgbe-smn.h    |  30 ++++
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  11 ++
 5 files changed, 220 insertions(+), 57 deletions(-)
 create mode 100644 drivers/net/ethernet/amd/xgbe/xgbe-smn.h

-- 
2.34.1



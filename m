Return-Path: <netdev+bounces-173653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF21CA5A57C
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:03:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 086B71747F6
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:03:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2BEE1D7994;
	Mon, 10 Mar 2025 21:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ldIG6h8a"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2068.outbound.protection.outlook.com [40.107.94.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E4581C5F1B;
	Mon, 10 Mar 2025 21:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741640635; cv=fail; b=GrbYyzZ8x2QfOBZ7SMxe1EVrp1+omvKt3rrWE6EkKMbbgrnoThj4QuQGPWqv1O6ZsW2g6SRQkOPNPRRxduvDjPriHvP3oBBG7jh4te+yDgcGWi6Ty3mJo6ePBgxMaigdCuOq8X+2pTV2I60iMgPprqOE5iExoU7ioGe/Z1fWoB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741640635; c=relaxed/simple;
	bh=S7slVHm56z909KddfElQGbSWFigw2rtyCqi1LUOyxgU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Na5sjiE563zSJkarbCMq+d6yAu/vEcRnKCXhxB1GJXN0IE2xK6+53YoNF8XV061K2aCeqOn+Q3dv6oDp2LAH+SIP7fHOB3UOK6eJ0xTUtXtJkawNYrPjEpRKhB/4ifQi9X9CtISKeV/dsGZnV8birqWFQytq21Ii/q04+Be214o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ldIG6h8a; arc=fail smtp.client-ip=40.107.94.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jEW/oaGlTAG52hLuOGHdlwYKT52Sl0JwXyjULKjigbCN0H8xbGxIeACDd7y12vArSIHW7ivSv2oWLPKN8MElioc6lksg8iiaHQrl17rqkRULow/vIM7VoFhYgEp3P0tmhYaJvhclJQBIujU75fKjRwCjT+lRA1UhJCElWf3jk/URVhH1QZDCjqvM018yYvxJd3XKPIMZrbizuE7F0T2W5fMGqXhOs/5gmuB2ct3yGtT583W3Knaq+96cI97J6dArYBrmXccwbfTkklN3vWKyQQxckT98mvHfOVn4p5Bb+uFl7b6WBmghbVUMdm7ftg4ID5OeR0ewGKCq9pqCl82rsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Emj8awQIz7ElOl+PbE1aRiOHDpFCGyqtr+fiC96UTGE=;
 b=DuRCQNdO4g25ivBiaYUYvXcyD+nHqR2bjpPXf34J7jzc4jUTkWSYzhZJQ1eg4rz7e1yuegyRjYYo2729dfn/bPu5qtt1SR9ynppByaqrQ+gV4/YYKEgVmaY+YOVa5uxAMSm9L1LqJSPmDwQdAXYulhu8Fp5e0Ijr5/uHpg5C5DPHjigA5JznaOA+4GMXVohOx2rpWlv1uBej3pkXYoi1mMs+Nml+GiEJCcQy8aKrHZXkthgEzQYMGCmP5slNPVT2/FzPET9cMPChb5I7A5T/QJEuJRxwdjHDyKVoNp4nqNmvhjgzaG4+raS+YAh89IDk+qglK+zao770xiXU18jMIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Emj8awQIz7ElOl+PbE1aRiOHDpFCGyqtr+fiC96UTGE=;
 b=ldIG6h8aJEYcens4qlVkbPNxWD+geFPWznwwAnWc21U3bULwVYiB6ABf/r4NNFIIobCcOszRH3yPYTGSw994w8+xApoFyokdtw3cEPv+H4sDR6HbK8rGqRWPqQdR1wqX0Mlsem+xSw6sGug32EnQSbdXTjF9e533a09hrwm5S9w=
Received: from BYAPR07CA0038.namprd07.prod.outlook.com (2603:10b6:a03:60::15)
 by MN6PR12MB8514.namprd12.prod.outlook.com (2603:10b6:208:474::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:03:51 +0000
Received: from SJ5PEPF000001D3.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::63) by BYAPR07CA0038.outlook.office365.com
 (2603:10b6:a03:60::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.26 via Frontend Transport; Mon,
 10 Mar 2025 21:03:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001D3.mail.protection.outlook.com (10.167.242.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8534.20 via Frontend Transport; Mon, 10 Mar 2025 21:03:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 10 Mar
 2025 16:03:49 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 10 Mar 2025 16:03:48 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v11 00/23] add type2 device basic support
Date: Mon, 10 Mar 2025 21:03:17 +0000
Message-ID: <20250310210340.3234884-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D3:EE_|MN6PR12MB8514:EE_
X-MS-Office365-Filtering-Correlation-Id: f393ce43-c200-4ac0-ab29-08dd60170f73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|82310400026|376014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?+FZCX0LSFHul1ycBJb1oFPL18vWPrKl1MoH7I8+AwCGS3lthP4Duk5w+/RUE?=
 =?us-ascii?Q?PICwm269QZdzmod9CK3aD+twL3rAwVxpNnBjGtt0Dewe77Jo7dD4uPl0XZXi?=
 =?us-ascii?Q?AxKbnAFzyzvNrm3k3AueMhee2QMHDCo0p3u21/fMfFEyoOQt/zLOw5ajv3iN?=
 =?us-ascii?Q?QgRPCdMXs37XoO23PM1Lir9ywk8P5xDhxAxhgWH5p4k95t3wXRN6TZ3FEZet?=
 =?us-ascii?Q?GrUvp4fbQUAI8VSoWzVjokUTMFDiqo1AjKSmBIIVampUHixgDhicRgKzY23/?=
 =?us-ascii?Q?0oUxOqWw16GeB6S/yHq7hGNUD/5T9tJ/f9qTH9U0BUn848asA5ATC2pqbSE7?=
 =?us-ascii?Q?+5kH1j85rBnOluHhji0zoRvKaCQPvoH9DK8D7ThULKT2wj0s30RMAkryMsZU?=
 =?us-ascii?Q?1DnFmaQ6T68vWZPof1Cn4qZNkEssdSMNWw+H4vQqMt4vRtyKr2+A0llyG4lO?=
 =?us-ascii?Q?cgA/Iue5lSGm76eeFbVi1typcjHrCei+kIbAYvmL3tTj/vqJzd+zM8h3LACv?=
 =?us-ascii?Q?hsm+zYrbN9DK434CTRikistOKSddNdqIDr9vl6obA8jVV8cXNBs4AIfEmcR+?=
 =?us-ascii?Q?/+oo5/nt9gFMKkDoB2mlKZpi07iAxP9zONlFXfVFBYO8RSLwtTf8IGSvlYZ/?=
 =?us-ascii?Q?FGefkugtAm1r1cxNWCOM5JOAxRlPLFoQMuy7MCP99p0EpdBp4emijT0Ue2jl?=
 =?us-ascii?Q?oh82QMnyFoVNsop1254fZmwnlV9rk7OzTD8lx2dLPzB5qzup3e6VAC/suptt?=
 =?us-ascii?Q?sC9EvDmJ43r3SvPI1mAAaVzodeTQgGCZG0ZU8n9iZMDZTCVwdLvO2tMDMc6W?=
 =?us-ascii?Q?vn9Xo7FnpA5fmaFsnKRrhkmbw+vcNUXVx9ANqfIn6YKERKbqTEJHSxbe14P/?=
 =?us-ascii?Q?Z6KjQmfz7zpQUPwbk1LBlWKpsBRGS0HlLo6aLjPCZtQxO6UEglYvuR8zZw7P?=
 =?us-ascii?Q?DqxpmfueqcSGFsEcuhOF9C8ctp8ej28C5YxMH+eX6n8VaH1Vgyv/22shnJZ+?=
 =?us-ascii?Q?9OwdjCCjWbNsbO/PuOk+DhcX0aDXsxlyZrySTO0dGPh2BUJt/xPkiEr7BOjg?=
 =?us-ascii?Q?eYfVUs5pGdNO5DTetJ2iItDeK7jIlXQhThGS7v4/BK4h1PHw20pJ9gBdXOQN?=
 =?us-ascii?Q?QLdA+d8A9iftS1VaxFUXtv9rbhwuYkFQxcKqpMHUAb0GiR8LZ3zPDbpH3Dzg?=
 =?us-ascii?Q?32VZwHZQWIXj5xyDduQxa0lLO4cSogxLt/6PBjiVtQSEpbrQvl78+MWDqTAW?=
 =?us-ascii?Q?FNqW6VKJht9zn4FnQlZc8IjJbpnfG4Ce+zzJgGtGkB1UME5Wz5hriS1NSo/i?=
 =?us-ascii?Q?EyPXoI5VXB0shJWe/lkWkMk/gZsG/VV0Li/UlfeWQAqFpx243s6mOixI+A5P?=
 =?us-ascii?Q?3DUfsNjSmV/BMc2SJupeYSeJ78Vzhv3DlfAdtAswm1cPKUJs1DOHi13GFi/r?=
 =?us-ascii?Q?Y2K4x0Uo2xgUXp2MrzKgbK+KBjHcdxUAFcqqk1lm8SrIJAzJPFK7CeUKJ66D?=
 =?us-ascii?Q?/eFGdWT4g8hhU+M=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:03:51.4512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f393ce43-c200-4ac0-ab29-08dd60170f73
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001D3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN6PR12MB8514

From: Alejandro Lucero <alucerop@amd.com>

v11 changes:
 - Dropping the use of cxl_memdev_state and going back to using
   cxl_dev_state.
 - Using a helper for an accel driver to allocate its own cxl-related
   struct embedding cxl_dev_state.
 - Exporting the required structs in include/cxl/cxl.h for an accel
   driver being able to know the cxl_dev_state size required in the
   previously mentioned helper for allocation.
 - Avoid using any struct for dpa initialization by the accel driver
   adding a specific function for creating dpa partitions by accel
   drivers without a mailbox.

Alejandro Lucero (23):
  cxl: add type2 device basic support
  sfc: add cxl support
  cxl: move pci generic code
  cxl: move register/capability check to driver
  cxl: add function for type2 cxl regs setup
  sfc: make regs setup with checking and set media ready
  cxl: support dpa initialization without a mailbox
  sfc: initialize dpa
  cxl: prepare memdev creation for type2
  sfc: create type2 cxl memdev
  cxl: define a driver interface for HPA free space enumeration
  fc: obtain root decoder with enough HPA free space
  cxl: define a driver interface for DPA allocation
  sfc: get endpoint decoder
  cxl: make region type based on endpoint type
  cxl/region: factor out interleave ways setup
  cxl/region: factor out interleave granularity setup
  cxl: allow region creation by type2 drivers
  cxl: add region flag for precluding a device memory to be used for dax
  sfc: create cxl region
  cxl: add function for obtaining region range
  sfc: update MCDI protocol headers
  sfc: support pio mapping based on cxl

 drivers/cxl/core/core.h               |     2 +
 drivers/cxl/core/hdm.c                |    83 +
 drivers/cxl/core/mbox.c               |    30 +-
 drivers/cxl/core/memdev.c             |    47 +-
 drivers/cxl/core/pci.c                |   115 +
 drivers/cxl/core/port.c               |     8 +-
 drivers/cxl/core/region.c             |   411 +-
 drivers/cxl/core/regs.c               |    39 +-
 drivers/cxl/cxl.h                     |   112 +-
 drivers/cxl/cxlmem.h                  |   103 +-
 drivers/cxl/cxlpci.h                  |    23 +-
 drivers/cxl/mem.c                     |    26 +-
 drivers/cxl/pci.c                     |   118 +-
 drivers/cxl/port.c                    |     5 +-
 drivers/net/ethernet/sfc/Kconfig      |     9 +
 drivers/net/ethernet/sfc/Makefile     |     1 +
 drivers/net/ethernet/sfc/ef10.c       |    50 +-
 drivers/net/ethernet/sfc/efx.c        |    15 +-
 drivers/net/ethernet/sfc/efx_cxl.c    |   162 +
 drivers/net/ethernet/sfc/efx_cxl.h    |    40 +
 drivers/net/ethernet/sfc/mcdi_pcol.h  | 13645 +++++++++---------------
 drivers/net/ethernet/sfc/net_driver.h |    12 +
 drivers/net/ethernet/sfc/nic.h        |     3 +
 include/cxl/cxl.h                     |   269 +
 include/cxl/pci.h                     |    36 +
 tools/testing/cxl/Kbuild              |     1 -
 tools/testing/cxl/test/mock.c         |    17 -
 27 files changed, 6186 insertions(+), 9196 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: 0a14566be090ca51a32ebdd8a8e21678062dac08
-- 
2.34.1



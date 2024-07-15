Return-Path: <netdev+bounces-111562-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 92359931941
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 19:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B11FF1C2171E
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 17:28:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9128447773;
	Mon, 15 Jul 2024 17:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="cmCQhu9u"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2044.outbound.protection.outlook.com [40.107.92.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A230E17753;
	Mon, 15 Jul 2024 17:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721064529; cv=fail; b=lTNqlWjUinwoNjoZn+mltwFrnZODOtwY89jXwoFCcsc/w7Bs8n1vm7pRF7EOkewo/VIdNRx3yJtlHpTQGf8Mdiv7cHuU0l+aZMfzCKHGNMijLY3gfw2CepYK+1dRVQLsgQgDm7aj8Y4yFrdXkmkjB6so6prYszoijEFT9Q6MjHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721064529; c=relaxed/simple;
	bh=D+uibmt4y1KE/vyPkyAV4M8OT1QDbIqjBVAk9cIZ+Gc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SS8/Jrpup27bl/yevHF3AKr9CjvB81eEqf+2hZ832V63jz9kQwBj6s3Qa2jAd132GmV/HNNN2OYfczGLjR7tdFbZRceYPy70t6MOxnhadytU85X1k0olb1kHzHHe2osyzU71M/olDTXFC059L9hOLgsjo922JjjzanA1MG3gZC0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=cmCQhu9u; arc=fail smtp.client-ip=40.107.92.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dwwYo51jr1AlTMkyfMcHQ5BNtTTbT47xSWysP4hLYDOupcNDshA5yjOFeC6LsLwtgQ9nIpHgsvYNUzsYCCLlxSLk5QkhTOShWbDhgKSe4GxqSOUdk9x/E8ogRIv7z0PKLTx6jPGZtKeYjWFNlsqt7zU3f4DLYakbJ9+dNEgcPzhjuPXNVh1TE74rZnBVxwaFvHVMrN6H8R+qBsHfGIgfomB1zRPCV9olz8QnYUiBBiqATxEucw7lUZAipZf2VjX35FLNFyLRDpj7AH1NZiJWoPt5XCkh3Z73nCkbGPAY7Grqr3XwWTCt9Bu8Bil8WZ3EPsfYIsE7daj0mkqGlmiNtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Sl/diJvG+QLXcaH2Op++o+G1PVA4ZiuPgvrtxuNtCj4=;
 b=PRq8X5iKBmfHPXeOgwJzMu1pgnVt47kguLrWK2jZzC9ALi4xygnMv0wzhfuUBVnSB6qK2SLrrhe4769g1KSZ9z79hd5Bio6ljHK/BRCl0rMguIqlHyyA11ovyMYrNBF8Ei1xcS7Mxzr2IAf11Hs9v856i1rrCy+k7ZN0bQHY3eVsCLQVys45Hv6jk7hy6X6XykdBYRXZEs3qOWRfFbPo9Z0f9y9Hbr4sTsqxBk9tCzLpH1Hu9dk/cxm34KDMYrwzpZDRgprU/ZNLRJlMHwvOJGUhFxlm9O+UpUn9XbjslifFHIh8+3gqHeyw7DmUoBVOSNJ6mS1bkBWuyUkXFimmEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Sl/diJvG+QLXcaH2Op++o+G1PVA4ZiuPgvrtxuNtCj4=;
 b=cmCQhu9uTB6e/QThbvywpsnFQ12hlSMyNJHkckRNRDAThBEaTor/kuenGaEcZmPEZa80g+onwN2ZhlIhay+7b2ZceHsxm2xggdH0ptSxER5eH04HZOfEJoTPGHYlZqiWGslmtNuASzXZa+be186Sl1UoBx406OigNsMxCFKIudg=
Received: from BYAPR02CA0011.namprd02.prod.outlook.com (2603:10b6:a02:ee::24)
 by CH0PR12MB8461.namprd12.prod.outlook.com (2603:10b6:610:183::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 17:28:44 +0000
Received: from SJ1PEPF000023DA.namprd21.prod.outlook.com
 (2603:10b6:a02:ee:cafe::79) by BYAPR02CA0011.outlook.office365.com
 (2603:10b6:a02:ee::24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.29 via Frontend
 Transport; Mon, 15 Jul 2024 17:28:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ1PEPF000023DA.mail.protection.outlook.com (10.167.244.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7784.5 via Frontend Transport; Mon, 15 Jul 2024 17:28:43 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 15 Jul
 2024 12:28:42 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 15 Jul 2024 12:28:41 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <richard.hughes@amd.com>
CC: Alejandro Lucero <alejandro.lucero-palau@amd.com>
Subject: [PATCH v2 00/15] cxl: add Type2 device support
Date: Mon, 15 Jul 2024 18:28:20 +0100
Message-ID: <20240715172835.24757-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB03.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023DA:EE_|CH0PR12MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: d2264491-cc8c-460a-a1da-08dca4f3938a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RnFPaFVXdEh6WENkdE9IN1ZZL3p1QUQ0YzdwOW10bzVJK2dDeVpBTkpqb0kv?=
 =?utf-8?B?alNlY2pTYzJXNmcxQklVcUxwTWplaTJyak9nSDM1TkdPQVdpZk14SlRReXJH?=
 =?utf-8?B?eWl5QXArZHhhUGliU1ZpTThpUXBWU1IxYmd4eFBQdFNHQVRoZlNXTkZJOEsv?=
 =?utf-8?B?V3pPVGVQQnFSNzh4NnAxbXg3ZGxpRG5xL1BybnR5WVB6ak1qUXFsWlN2Ykd2?=
 =?utf-8?B?Qi8wY3pPVHE2a3ZWdXo5N090RnB3WjJBZUVMOWo2SU9jOTdXRER2eFhvV3pU?=
 =?utf-8?B?dW1JSkhNOUZua3IweFVISUN5ZGRoWUt5OUQxYUVZVURvdHJOdXhLREtYLzFu?=
 =?utf-8?B?MkN2STQxejZES3YyQk5jS1pMb08wb0ZBUmg2ai9FNTFFWnIxaEJGWU5iczZP?=
 =?utf-8?B?aEJDMXlxbnlOWlBsTlRyTm53dDE3a1U5UjVrK0tYU2hqRUlONGtWMm11cHBv?=
 =?utf-8?B?WU0rWk8zMEx1Nk1SNVNWclQ1OTVqdkMwM1hOWS9rc1hqWE5OQWQydHBZMEkw?=
 =?utf-8?B?K2hYRWtiaGM0K1R2cXJnUDljNmhibUI5UHZVWkw3T1h1V0hkR2VYdlZiZzJh?=
 =?utf-8?B?UkwwTDQ2emJYVklIWUF4WDhEeXFVRHRIWGExalo1bi84RFlyb25DdTQrYmFS?=
 =?utf-8?B?ZVc2YUJYeU5jbVNxWmo4cWtQV1hDN2o0VDkzRGRzR0xCbnNsM1o5Vmx2bUxN?=
 =?utf-8?B?K0krRU9OOWYzcGZnUU9meWNaMnNjK3l6R2tBSkIzRjlId1VqWDY3b3ExVVBj?=
 =?utf-8?B?bE5ObVVRaGRlLzZTVmRlckZ5eFk2NVF5c0RTbjdZOXV1WjhhSlRUNWZSa2Vn?=
 =?utf-8?B?SXJrZnowYlpwS3k5YWR3SUVDU0Y2cmFXWEJDT3dvbmk1RldDMmxqSDJCU1NY?=
 =?utf-8?B?Q09kZnUraW9sWnR5VVFLVHFSc1h5bWlzNDlnZ0JnOUdLNWNtQ3B3Z1lZMmlQ?=
 =?utf-8?B?THc0VXVZNmpIUTFtTEFoQXRKK2RWSGV0SzZ3T1haYlN2UVlYMUl0OTE1UFhN?=
 =?utf-8?B?UnZkMjdGU0d3R2NZWkJ2QS9KY25sZW43ZjVKeTVlYjVzaU5QWVdzZkE3ckdP?=
 =?utf-8?B?SEVuT0NLSUN6QU1aYU01YWNJY09sRXpIb3FhcytkL1lJUWoyTEhqZkNqbVhY?=
 =?utf-8?B?dmFaa1Y2ekhnMU5yeDFBdGVqYmFpV3JJVnNWeG4wWXlOdUo4ekZxWWdsSFVZ?=
 =?utf-8?B?M2c2aWNoOThqQzhLMTlPQW5TS1VibDNXRUk3QUwzTmQzbTFsUXJjeWlURGpx?=
 =?utf-8?B?bitGblFUenptRlYzdHlJbUNjcHZiTm9GUHhkd0RuSm9uVDNCQ3JMYk11eTI3?=
 =?utf-8?B?OTNQWkcyQlJNUXJMVjE3QVpmSlBlVlBnUUMzUzhPQlN3aEE2Q2J6cXhkY1Bx?=
 =?utf-8?B?UUEvM3hnNThwMmJMQkovbExJM0s1ZG5KVk1ScU1zUzdwb3dCVWpDbzd6RFdz?=
 =?utf-8?B?QjZmMEpMYXgwdVpid05ORVRtc2ZxM2FvT1k0dXZ6T21vdnYybGdvcXFsN3RR?=
 =?utf-8?B?STZ5ZlFRTU9VRmYrMnRXMWRNb3VNMTFqZ3NwVUNuZDI5VlNjM2Qrd0l6aHYz?=
 =?utf-8?B?VUFReDZkSnFMc2ROQ2dxbktrN3hNNzNZSFZmZTFzU3VOdU1JYlhoZ0c1Y3BB?=
 =?utf-8?B?aFc5TkZQK1dhTnFaY0JOQnBjNVI1L1VNWnN5dUtQajZ0NFZIaXhhbXc5ZkF1?=
 =?utf-8?B?aSszbUpIT2lTVTV4SEQ5cXdrRlRzOWFJUFYwRVQwTlJWbUlNSWhNUVMzTmwr?=
 =?utf-8?B?TnVUcHpPNUpqR2JyY2ltSEFxRmxWY1lIWjJmVndvb1N1TERtQVRJTXJmZ3Fm?=
 =?utf-8?B?UzZkcC9WWllpdkVUMkNjWXdWd0VhNkNrNjVxZ01Xb1JGdHlyMmVoVmZSZUl0?=
 =?utf-8?Q?8OPqBW2Xk2bf+?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2024 17:28:43.7705
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2264491-cc8c-460a-a1da-08dca4f3938a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF000023DA.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8461

From: Alejandro Lucero <alejandro.lucero-palau@amd.com>

This is a second version for adding CXL Type2 support with changes from the
first RFC patchset.

I have removed the introduction about the concerns with BIOS/UEFI after the
discussion leading to confirm the need of the functionality implemented, at
least is some scenarios.

There are two main changes from the RFC:

1) Following concerns about drivers using CXL core without restrictions, the CXL
struct to work with is opaque to those drivers, therefore functions are
implemented for modifying or reading those structs indirectly.

2) The driver for using the added functionality is not a test driver but a real
one: the SFC ethernet network driver. It uses the CXL region mapped for PIO
buffers instead of regions inside PCIe BARs.

Current CXL kernel code is focused on supporting Type3 CXL devices, aka memory
expanders. Type2 CXL devices, aka device accelerators, share some functionalities
but require some special handling.

First of all, Type2 are by definition specific to drivers doing something and not just
a memory expander, so it is expected to work with the CXL specifics. This implies the CXL
setup needs to be done by such a driver instead of by a generic CXL PCI driver
as for memory expanders. Most of such setup needs to use current CXL core code
and therefore needs to be accessible to those vendor drivers. This is accomplished 
exporting opaque CXL structs and adding and exporting functions for working with
those structs indirectly.

Some of the patches are based on a patchset sent by Dan Williams [1] which was just
partially integrated, most related to making things ready for Type2 but none
related to specific Type2 support. Those patches based on Dan´s work have Dan´s
signing as co-developer, and a link to the original patch.

A final note about CXL.cache is needed. This patchset does not cover it at all,
although the emulated Type2 device advertises it. From the kernel point of view
supporting CXL.cache will imply to be sure the CXL path supports what the Type2
device needs. A device accelerator will likely be connected to a Root Switch,
but other configurations can not be discarded. Therefore the kernel will need to
check not just HPA, DPA, interleave and granularity, but also the available
CXL.cache support and resources in each switch in the CXL path to the Type2
device. I expect to contribute to this support in the following months, and
it would be good to discuss about it when possible.

[1] https://lore.kernel.org/linux-cxl/98b1f61a-e6c2-71d4-c368-50d958501b0c@intel.com/T/

Alejandro Lucero (15):
  cxl: add type2 device basic support
  cxl: add function for type2 cxl regs setup
  cxl: add function for type2 resource request
  cxl: add capabilities field to cxl_dev_state
  cxl: fix use of resource_contains
  cxl: add function for setting media ready by an accelerator
  cxl: support type2 memdev creation
  cxl: indicate probe deferral
  cxl: define a driver interface for HPA free space enumaration
  cxl: define a driver interface for DPA allocation
  cxl: make region type based on endpoint type
  cxl: allow region creation by type2 drivers
  cxl: preclude device memory to be used for dax
  cxl: add function for obtaining params from a region
  efx: support pio mapping based on cxl

 drivers/cxl/core/cdat.c               |   3 +
 drivers/cxl/core/core.h               |   1 +
 drivers/cxl/core/hdm.c                | 160 +++++++--
 drivers/cxl/core/mbox.c               |   1 +
 drivers/cxl/core/memdev.c             | 122 +++++++
 drivers/cxl/core/port.c               |   4 +-
 drivers/cxl/core/region.c             | 459 ++++++++++++++++++++++----
 drivers/cxl/core/regs.c               |  11 +-
 drivers/cxl/cxl.h                     |   9 +-
 drivers/cxl/cxlmem.h                  |  11 +
 drivers/cxl/mem.c                     |  24 +-
 drivers/cxl/pci.c                     |  39 ++-
 drivers/net/ethernet/sfc/Makefile     |   2 +-
 drivers/net/ethernet/sfc/ef10.c       |  25 +-
 drivers/net/ethernet/sfc/efx.c        |   6 +
 drivers/net/ethernet/sfc/efx_cxl.c    | 134 ++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  30 ++
 drivers/net/ethernet/sfc/mcdi_pcol.h  |   3 +
 drivers/net/ethernet/sfc/net_driver.h |   4 +
 drivers/net/ethernet/sfc/nic.h        |   1 +
 include/linux/cxl_accel_mem.h         |  58 ++++
 include/linux/cxl_accel_pci.h         |  23 ++
 22 files changed, 1021 insertions(+), 109 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/linux/cxl_accel_mem.h
 create mode 100644 include/linux/cxl_accel_pci.h

-- 
2.17.1



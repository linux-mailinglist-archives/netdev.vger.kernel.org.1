Return-Path: <netdev+bounces-189811-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B32B2AB3D22
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 18:14:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF1BF4635A9
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CC1C24E4A1;
	Mon, 12 May 2025 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tMprB7WT"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2072.outbound.protection.outlook.com [40.107.94.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF5224DFF6;
	Mon, 12 May 2025 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.72
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747066270; cv=fail; b=fWBtLdsq1DpLh7wUHtdRf9LKoMiitShKy4YEj0Jbmbu/UZ1AN640W/Elzt4kVZqk5twQOd7UnXZfBvQjQGFadAf4vBl7tVOT3yQpfG6km+qGZDr6qPRwsHDkkUa3mIgzAd69ZcqxSnSCqFPGWVaqTARBFymKIjkmNKsEDOuozjQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747066270; c=relaxed/simple;
	bh=z4S1DwdZQbY5xUps0OXl07xY+TCaSgnGsVgKzAbyxcA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jlxA13MCquwCDCOE1SWUgxC3No4lMJSv2UJ63zwv9XRNtYQzQwP2pU/++xMXRdG/7fuiJpZYGWOUnuZ9x0bevw0Bxj/G6/XUGFAkw4pNuKdAQhge55SjvuoKbZnXL3mlN/tcNJwajM3lmRXZdvtdkzAWvHpuZIlHa46Kr8HqIFw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tMprB7WT; arc=fail smtp.client-ip=40.107.94.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=evqXua4gKlmQvx7kd0U412VrBgG26YMmb91kUhDB53dWpBMkpgQWPW4HxN9QD4UWFatkwTdFLl416xTTcjogG3ReMVRiYQBREBamDxFSbux+Eoppz77PFXk0PSE4dScOGoxfBWHiwv77HzgGhFZVB8uY+WKU4qr5fk1Pp0K33Ss8qbk824rCwQP9yXuNWgSv1aVA5wukmsm44zEtVFujd/1JegE8NPHCQcSYhmFBphPuX6xtq9dfSLRXE/K7vWH+cDBi9WtxVvQLl4VcWgpmgWCwo/dCCWyXGygVW6V4n6UmZPuDp9uBOxTvZRd4kxmtCxpCNS3LE82Mm02oiqhS2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgdwJh3GF3U0buakSkNgEc5hps1CEEdHPOA6kjCENyQ=;
 b=VwqX4RUNc9zUV56MlJS9HeshvmPUVk4VPZSu2U87v7+9wFvy71iDE8oayWPEOGq5ZifNh4AlI0hIX6ZMK9g1E6FKwWj+ZrqOe1ZjU8Bdm1o6r6tz0gZIW3EzZc/n/R+JS+HHfqWd5ZsT443Liuty/FZ9FOtrokya27McKqE2dZzHBdPylWtdJs4b5m8+sK+QrYzSi5vbY+6FYmcdHef/y2mvgEMEqvNrRHzfrO9HD3SEH/HTOyL0JG8T7AeXB5xTyRIyUpq+qbhk0hVXX5fnfrhMMSRl56kOQhMVrpWq55pS8sgUuQTrLvY2XO5y2usqreAdFopTiJmJYKB60tT9cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VgdwJh3GF3U0buakSkNgEc5hps1CEEdHPOA6kjCENyQ=;
 b=tMprB7WTCMeQNPj8NnT36ZMVzn1535W2P5eVOB0c7Zvt+vAp67R/J5F0dj/7QzjR0O0GjlxVroVozS0qgjw4q7nkoe4zr5igipiatHdiLWz5wNeULz79sSLMXrQA4RpIRzVGyM+e5F6r3mKTK/PZOji/tFcb3qjxuG9Kq/HS3QE=
Received: from SA1P222CA0032.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2d0::13)
 by SJ0PR12MB6944.namprd12.prod.outlook.com (2603:10b6:a03:47b::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.25; Mon, 12 May
 2025 16:11:05 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:2d0:cafe::ad) by SA1P222CA0032.outlook.office365.com
 (2603:10b6:806:2d0::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8722.25 via Frontend Transport; Mon,
 12 May 2025 16:11:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Mon, 12 May 2025 16:11:04 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 12 May
 2025 11:11:04 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 12 May 2025 11:11:02 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v15 00/22]  Type2 device basic support
Date: Mon, 12 May 2025 17:10:33 +0100
Message-ID: <20250512161055.4100442-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|SJ0PR12MB6944:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b6b311-a976-4f3f-ac05-08dd916f98f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|36860700013|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?d2FySUpxbzV6RFIwQ1N0TlZ1UlduazhKYlVwYXpvNmFJemY2NVlmcEFsRThR?=
 =?utf-8?B?eWhJdUIzZjVKb1dZOUtCakdHRVNRUGt0dHhCRmRnYlVXN0ZJNDNYTXFSNjVz?=
 =?utf-8?B?TExLZU1YYkZZaW1hdW9JRnljSWZIUmxTM3Q4NlIvd0RvTkxFYmZ6K1JoNG1C?=
 =?utf-8?B?UWxiZDFPOXp0Qy8vMThEQ1UxWUJPdDIycStEeFkrZzV4T0RHVnVFdTh1SWcx?=
 =?utf-8?B?QmdZOHpvSTloVlFOdURyY2xjd1lGMFJNTk1zOHgvR0tpZ0dqbjhOVk5vU01O?=
 =?utf-8?B?K1VaMGtDTmppK2FrNWdIdlRVOGFGRWYrbDZydnkwOVhpazRTb29DR3Qxc3pj?=
 =?utf-8?B?UVpWVjJBbXlsRWhadzJVdDR0bmZ6ditqOXUrcEhJdHhVZkw0WkwwYVBaUE0z?=
 =?utf-8?B?cXl6cW0zaGg1K0NWZUI3SzJwTHdIQTR4ejdBMTJEcEhURzd1ejF0SXRrRzJE?=
 =?utf-8?B?a2pvUjdSNDZ1SVYvSjBDWUdYMGc2aVJldzFtQk02Tk81cWZqb24zZHZ5ZEVF?=
 =?utf-8?B?R2s3alBBbjFVRGhlcXd5WGNVNHppTGN1UFNkNllydGd2NytUSXB3NVUrc1gy?=
 =?utf-8?B?SVFiT1dpajFqNmMzMzhsSEVjUVJndXNyRkhZbk02OHVDbjBvMHNsR3ZZOXhM?=
 =?utf-8?B?L052ZXB1SjV5ZnhwRmVXVjQ2SnlLcDkvUEFVSkJMMmVDalJ0OUsxN1FJOWVq?=
 =?utf-8?B?VkRrMkh3TTBNNU1PN0tPM2ZxS3hBYjlnOWw5ZTlKL3NUb3k3NGh1bnFEM1Q4?=
 =?utf-8?B?YVZjNzFOemh2T0YzOXJjK0RtNHA5elc0QTJLTDljRkxsU3NNVTVTczkyWm1Y?=
 =?utf-8?B?M2xOOVVNMWZmb3h5MjNQeGM4dUFGTEFqejVIZzFqNGlFUE1peUxrdWtMWEpj?=
 =?utf-8?B?TFRPdm1ZdmNDMk1uRUs5RDVYeExCNWZUc0YvbzlQYVRJQjQ0YTNwZGZ3ZnpK?=
 =?utf-8?B?bUVyd3B1LzBySHUzeUFoSkc3SXk2Ty9tRzc1RHIwNCtQTjdJVTNvUFdZSVp0?=
 =?utf-8?B?S0RqSEs0S0NEU2N3djIyQ210UWxOSnhkNnZCa1dQZUpZSkdESFh1aDdxbUxK?=
 =?utf-8?B?RDdtMDUySk8yWlpmZDZmcmUzRHpjYkFuYTYzU0FHMGZwSi9rck1YenBheVF3?=
 =?utf-8?B?WXFrVFE0dUxPMFlzUmtHTUxKTGpKdUtQWGxmQVVzZWlzajhXZVJoYmF5d1pi?=
 =?utf-8?B?eEEyRWJGOVQrTXVadStCWjZuZDk3dFgyZzlSMUhLaEZQVk5UdHNjYlRncTQ5?=
 =?utf-8?B?ZVhRKy9sQkh3anhFbWpJRS9vR3NqWlp3Uk1OaUtoVzhxYmVoRzJZd2FCQlRl?=
 =?utf-8?B?eEx2VmNaSEprRk42RUJqT0k2VkZUZW5GcXhrdUM3VVFSQXc3aHd6TzNIWTFW?=
 =?utf-8?B?S0JudDh5ZUo5VnlzNVhhTE1RWkVMUVJ1K2RqcWY5aWU2eGpHUy85UnU4d1Zy?=
 =?utf-8?B?aU1LbnFkK0tvOWJ2Mmg4YTdXODQwUXhIVU01dGZ5SWxZWDFsR3F3bC8zRzJB?=
 =?utf-8?B?SnJ6azRxMm8vY0w5Mmc3SnFtczZkVzYvdWxJZW5IYU1oSDN3Qy9hdWdrMkIv?=
 =?utf-8?B?YlJkblJNV0w1VTBXbEc1ZVkvVHFFenpsVzBINVJFM1UydGwzQUs5M0VUM0ti?=
 =?utf-8?B?VkRzZTl0S1BraFdoZUkxZUExRTdsNkRSUmhNMjBiMUFoK2xpY2tDNjcrVUFK?=
 =?utf-8?B?ZzltMWdsSldkcXhORnExTTR4OElGVllEVSswNHRhWUtZTEErNlptTTU1c3lp?=
 =?utf-8?B?bjdmcVNkMTlLUUViZDdabHFTamE4QUlxY3o5bldncWZ3TWk5R0cvdW5Tb2Mv?=
 =?utf-8?B?aXBoSDlaelZzVWZjUnA3RGkwejBGbTJXUjI5TnZtcjAxQUpDQlNXTnN0WWRO?=
 =?utf-8?B?TjVMSHhKdmVsNmpMZjQ1MzBDTlFRYmFLM053eU1wTk84TmlyLzVPVHBoMVEx?=
 =?utf-8?B?TXByVmtqYUROU2JzUndvejQ1bzRsOEZIZk4rc1RhWmxRZFNGWm1zTTQ1WjZK?=
 =?utf-8?B?bGhENDA4cnBpZFRFL1FkcTVoMTFLNUtGTHNhVDh6WVFSTDVGWmdJZEdQbXdZ?=
 =?utf-8?B?MjZrRC9RMEpyOEhFZmxmd3FMQkEyT3FXdzlaUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 16:11:04.9191
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b6b311-a976-4f3f-ac05-08dd916f98f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6944

From: Alejandro Lucero <alucerop@amd.com>

v15 changes:
 - remove reference to unused header file (Jonathan Cameron)
 - add proper kernel docs to exported functions (Alison Schofield)
 - using an array to map the enums to strings (Alison Schofield)
 - clarify comment when using bitmap_subset (Jonathan Cameron)
 - specify link to type2 support in all patches (Alison Schofield)

  Patches changed (minor): 4, 11

v14 changes:
 - static null initialization of bitmaps (Jonathan Cameron)
 - Fixing cxl tests (Alison Schofield)
 - Fixing robot compilation problems

  Patches changed (minor): 1, 4, 6, 13

v13 changes:
 - using names for headers checking more consistent (Jonathan Cameron)
 - using helper for caps bit setting (Jonathan Cameron)
 - provide generic function for reporting missing capabilities (Jonathan Cameron)
 - rename cxl_pci_setup_memdev_regs to cxl_pci_accel_setup_memdev_regs (Jonathan Cameron)
 - cxl_dpa_info size to be set by the Type2 driver (Jonathan Cameron)
 - avoiding rc variable when possible (Jonathan Cameron)
 - fix spelling (Simon Horman)
 - use scoped_guard (Dave Jiang)
 - use enum instead of bool (Dave Jiang)
 - dropping patch with hardware symbols
 
v12 changes:
 - use new macro cxl_dev_state_create in pci driver (Ben Cheatham)
 - add public/private sections in now exported cxl_dev_state struct (Ben
   Cheatham)
 - fix cxl/pci.h regarding file name for checking if defined
 - Clarify capabilities found vs expected in error message. (Ben
   Cheatham)
 - Clarify new CXL_DECODER_F flag (Ben Cheatham)
 - Fix changes about cxl memdev creation support moving code to the
   proper patch. (Ben Cheatham)
 - Avoid debug and function duplications (Ben Cheatham)
 - Fix robot compilation error reported by Simon Horman as well.
 - Add doc about new param in clx_create_region (Simon Horman).

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

v10 changes:
 - Using cxl_memdev_state instead of cxl_dev_state for type2 which has a
   memory after all and facilitates the setup.
 - Adapt core for using cxl_memdev_state allowing accel drivers to work
   with them without further awareness of internal cxl structs.
 - Using last DPA changes for creating DPA partitions with accel driver
   hardcoding mds values when no mailbox.
 - capabilities not a new field but built up when current register maps
   is performed and returned to the caller for checking.
 - HPA free space supporting interleaving.
 - DPA free space droping max-min for a simple alloc size.

v9 changes:
 - adding forward definitions (Jonathan Cameron)
 - using set_bit instead of bitmap_set (Jonathan Cameron)
 - fix rebase problem (Jonathan Cameron)
 - Improve error path (Jonathan Cameron)
 - fix build problems with cxl region dependency (robot)
 - fix error path (Simon Horman)

v8 changes:
 - Change error path labeling inside sfc cxl code (Edward Cree)
 - Properly handling checks and error in sfc cxl code (Simon Horman)
 - Fix bug when checking resource_size (Simon Horman)
 - Avoid bisect problems reordering patches (Edward Cree)
 - Fix buffer allocation size in sfc (Simon Horman)

v7 changes:

 - fixing kernel test robot complains
 - fix type with Type3 mandatory capabilities (Zhi Wang)
 - optimize code in cxl_request_resource (Kalesh Anakkur Purayil)
 - add sanity check when dealing with resources arithmetics (Fan Ni)
 - fix typos and blank lines (Fan Ni)
 - keep previous log errors/warnings in sfc driver (Martin Habets)
 - add WARN_ON_ONCE if region given is NULL

v6 changes:

 - update sfc mcdi_pcol.h with full hardware changes most not related to 
   this patchset. This is an automatic file created from hardware design
   changes and not touched by software. It is updated from time to time
   and it required update for the sfc driver CXL support.
 - remove CXL capabilities definitions not used by the patchset or
   previous kernel code. (Dave Jiang, Jonathan Cameron)
 - Use bitmap_subset instead of reinventing the wheel ... (Ben Cheatham)
 - Use cxl_accel_memdev for new device_type created (Ben Cheatham)
 - Fix construct_region use of rwsem (Zhi Wang)
 - Obtain region range instead of region params (Allison Schofield, Dave
   Jiang)

v5 changes:

 - Fix SFC configuration based on kernel CXL configuration
 - Add subset check for capabilities.
 - fix region creation when HDM decoders programmed by firmware/BIOS (Ben
   Cheatham)
 - Add option for creating dax region based on driver decission (Ben
   Cheatham)
 - Using sfc probe_data struct for keeping sfc cxl data

v4 changes:
  
 - Use bitmap for capabilities new field (Jonathan Cameron)

 - Use cxl_mem attributes for sysfs based on device type (Dave Jian)

 - Add conditional cxl sfc compilation relying on kernel CXL config (kernel test robot)

 - Add sfc changes in different patches for facilitating backport (Jonathan Cameron)

 - Remove patch for dealing with cxl modules dependencies and using sfc kconfig plus
   MODULE_SOFTDEP instead.

v3 changes:

 - cxl_dev_state not defined as opaque but only manipulated by accel drivers
   through accessors.

 - accessors names not identified as only for accel drivers.

 - move pci code from pci driver (drivers/cxl/pci.c) to generic pci code
   (drivers/cxl/core/pci.c).

 - capabilities field from u8 to u32 and initialised by CXL regs discovering
   code.

 - add capabilities check and removing current check by CXL regs discovering
   code.

 - Not fail if CXL Device Registers not found. Not mandatory for Type2.

 - add timeout in acquire_endpoint for solving a race with the endpoint port
   creation.

 - handle EPROBE_DEFER by sfc driver.

 - Limiting interleave ways to 1 for accel driver HPA/DPA requests.

 - factoring out interleave ways and granularity helpers from type2 region
   creation patch.

 - restricting region_creation for type2 to one endpoint decoder.

 - add accessor for release_resource.

 - handle errors and errors messages properly.


v2 changes:

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



RFC:

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

Alejandro Lucero (22):
  cxl: Add type2 device basic support
  sfc: add cxl support
  cxl: Move pci generic code
  cxl: Move register/capability check to driver
  cxl: Add function for type2 cxl regs setup
  sfc: make regs setup with checking and set media ready
  cxl: Support dpa initialization without a mailbox
  sfc: initialize dpa
  cxl: Prepare memdev creation for type2
  sfc: create type2 cxl memdev
  cxl: Define a driver interface for HPA free space enumeration
  sfc: obtain root decoder with enough HPA free space
  cxl: Define a driver interface for DPA allocation
  sfc: get endpoint decoder
  cxl: Make region type based on endpoint type
  cxl/region: Factor out interleave ways setup
  cxl/region: Factor out interleave granularity setup
  cxl: Allow region creation by type2 drivers
  cxl: Add region flag for precluding a device memory to be used for dax
  sfc: create cxl region
  cxl: Add function for obtaining region range
  sfc: support pio mapping based on cxl

 drivers/cxl/core/core.h               |   2 +
 drivers/cxl/core/hdm.c                |  86 +++++
 drivers/cxl/core/mbox.c               |  37 ++-
 drivers/cxl/core/memdev.c             |  47 ++-
 drivers/cxl/core/pci.c                | 162 ++++++++++
 drivers/cxl/core/port.c               |   8 +-
 drivers/cxl/core/region.c             | 433 +++++++++++++++++++++++---
 drivers/cxl/core/regs.c               |  40 ++-
 drivers/cxl/cxl.h                     | 111 +------
 drivers/cxl/cxlmem.h                  | 103 +-----
 drivers/cxl/cxlpci.h                  |  23 +-
 drivers/cxl/mem.c                     |  25 +-
 drivers/cxl/pci.c                     | 111 ++-----
 drivers/cxl/port.c                    |   5 +-
 drivers/net/ethernet/sfc/Kconfig      |  10 +
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/ef10.c       |  50 ++-
 drivers/net/ethernet/sfc/efx.c        |  15 +-
 drivers/net/ethernet/sfc/efx_cxl.c    | 159 ++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  40 +++
 drivers/net/ethernet/sfc/net_driver.h |  12 +
 drivers/net/ethernet/sfc/nic.h        |   3 +
 include/cxl/cxl.h                     | 292 +++++++++++++++++
 include/cxl/pci.h                     |  36 +++
 tools/testing/cxl/Kbuild              |   1 -
 tools/testing/cxl/test/mem.c          |   3 +-
 tools/testing/cxl/test/mock.c         |  17 -
 27 files changed, 1415 insertions(+), 417 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: a223ce195741ca4f1a0e1a44f3e75ce5662b6c06
-- 
2.34.1



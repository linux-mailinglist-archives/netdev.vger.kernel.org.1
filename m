Return-Path: <netdev+bounces-182282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C94ADA886A1
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 17:15:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB4B2163425
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 15:13:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5527C25394E;
	Mon, 14 Apr 2025 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="yjcfpU2R"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2070.outbound.protection.outlook.com [40.107.100.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0E0252294;
	Mon, 14 Apr 2025 15:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744643635; cv=fail; b=mG1MkqYKRnrNfABJ5OxTcs8ETmrt6Yf7Kf0PglwxiUfrraY2C99cP6/FD8LbtEgVulmEw59M/1FNjfpFzU21ZkBlxQ+VUhWZtCGJ+h4Jnmv3iuhfnRevZiOf3+h4XI2YqjLRTGckPGIzmtO35jWA8hvB+QTIQD7MSyGwJVzOxzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744643635; c=relaxed/simple;
	bh=YnXw0tCqO1CcbuH0fwrQ8ZYPaRq44/SHRIY3zie2Qno=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jTEUgHgMPv1dEZoA7oTDATwMONVNutbHojUrG044l60z3lSbiHuHeXnqxF7futgI/f6mfjJqaeTW0Jt18HgO1HPmCMK/QYniRzefPq5+VXMrJgeYplCbV9taCnpbjV5E6+KGHA57yDgAqznbOcF04rnlhW7HRmD2Cv+vCS3abp4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=yjcfpU2R; arc=fail smtp.client-ip=40.107.100.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rMIXUAt0v69R26DLe/aNfiCLr5oaZ35xrJlQUvkeZM+C+Poy9jzTYp5g1U3Z/sifrsKlwtE/hSt4+pKcZiu+0ilYWOa6t67kwPEe95ctJjzB/B10wgXer7a1hh9YNFZ00XW4Z40iQwQSCF001noSt5qRQAm7sFeg+ocJWr5j17AWZm0kprLV+1fGJ0T6lkAXlJhI/ZdmxKrz6XV759wXUuKL430UtZxz0ROqrEOWBMxZHLqsup7aaNyRMqeWmx06PVXCeUS86yKVtBZtLCcaTZWsFoU5jBqcqlZRzdzlo3KjjSpeNtK7hZAKaOrQGWz8Kmwch0EEqlS4jAvwys3wmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C/7fHvogEzC5EFz8M1i6ep27tJmDeDHk1a0gRInUvj0=;
 b=kCjN2TCmviZsJ8V/AtahT0lkildakW7MzMb4UUvFlLbhG0AgLUxYOhCmGauYfri6OnMqKaX+x9xVWSxNEvziJlNXGy/3/TNIgVoBI9qrEKj/YORHBWYXmgFh1gr9a1M0Di2k2L396GemhOR4HBLdUXi+QPwojHyn2J7E9O1gFVBaMt1Z7yrUd4++sY5URiP0r0ovwi0W4oDeqtUmcuqz4gGaUuztp3vupF7oVYXEWeX5yKNfJs6Qwi1Jjueclz4KvruMBeVtR9g/SXPF25HjFI8zryLPc3WUwkIk4Ci54fwMWMChqCi8E0oOYR5BOwdrt4CQ8u6GFx6Swu7p3PnLDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C/7fHvogEzC5EFz8M1i6ep27tJmDeDHk1a0gRInUvj0=;
 b=yjcfpU2R6DQt1+uRbUppMvaPyCJtCK4z3Kh+lAW6GtXXlVqGawt89EyOGhkqgfHFQujLaaiMykfqyKI59QpXbHch4RFEjX3nx6dbg3C8b9kptc2wAQepm4MfPYRn8x7CMJjGh2XmHUPC4A0msKtSxmlpkl5qcM+FqKvqFrHYd5g=
Received: from PH7PR10CA0023.namprd10.prod.outlook.com (2603:10b6:510:23d::21)
 by MN2PR12MB4062.namprd12.prod.outlook.com (2603:10b6:208:1d0::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.27; Mon, 14 Apr
 2025 15:13:47 +0000
Received: from CY4PEPF0000EDD5.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::a6) by PH7PR10CA0023.outlook.office365.com
 (2603:10b6:510:23d::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.34 via Frontend Transport; Mon,
 14 Apr 2025 15:13:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EDD5.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Mon, 14 Apr 2025 15:13:46 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:13:45 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 14 Apr
 2025 10:13:45 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 14 Apr 2025 10:13:44 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v13 00/22] Type2 device basic support
Date: Mon, 14 Apr 2025 16:13:14 +0100
Message-ID: <20250414151336.3852990-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD5:EE_|MN2PR12MB4062:EE_
X-MS-Office365-Filtering-Correlation-Id: ae0d84be-ec6d-44db-0211-08dd7b66f3e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WUZ1SDNuSU5qTFhBT2lTdC93MW9xblhVTnBsbUlsZUY5bFNxK25NQURualM2?=
 =?utf-8?B?MEQ2aFNtbkZ4eW4xdXZ3dWdYSXBPalFUOFpGaUJrMlVIbkFqVGtqa1pxcXh5?=
 =?utf-8?B?THEwaE04Yi96VE5va2Y4NFlxM1I1dGp4VkE3VTVmRVJMeEZ4eWE0MGNqT3l5?=
 =?utf-8?B?ajBqMWt3M1M1YkVOektHMmsySzhsVitoWkI0czNtanl2TkdMRkxkSHV6OHU2?=
 =?utf-8?B?U1BqcGNGYzZoVG5UVlphcUxibkUxS0YwZjFYZ0k3L0kvOFc4aTRKaTBnYXk0?=
 =?utf-8?B?ZThaRWdKRHRSbTlyZHk5c3FpRy9lMTREZU5yZmpKZmVZaDd6TjAyU0VEcGhF?=
 =?utf-8?B?QWxlVlFMOTBPZUIrcGxTam1uUUxrVU85NGtmaDhXaEJ1enN0d3RobDU2dWdP?=
 =?utf-8?B?Y1dvd0J5YWRaMkJVajJma056ZGJnempRcE8xcXk4UUNmUU5vSXhJTCtabGFX?=
 =?utf-8?B?ZFNWcTNoTXArMDZqV1ZHcndBNmlhMWwxcytpRTBWcGpWSWpKUzluRTMzcEto?=
 =?utf-8?B?MHk3bkh6OEx2ZlFrTGhXaVAxbjcyV0Y3VTFIVGdjSHkrR2orcTZ1NjVKdXZy?=
 =?utf-8?B?YWRMNEJsWWpLc3lGdVY2UFRTbFZzZHlTTVFOQW5jbGthNVo2U0k3N0RncjU5?=
 =?utf-8?B?S2pUT3JWaVlyd1U4WFRSV09WNHNadVJQaFVNOFBDbmpuN0FiWHBQbi9vMXFZ?=
 =?utf-8?B?emVHak1OSmJ0eUVEcmxubTIvbEZGVHlSMDB2L0hHM1hTN2o2WUJMeTcyUmNN?=
 =?utf-8?B?RlhvOHROc3lweVVPUzhCeEZ2VkVUNnc2cGhxRTYrOWlnQTlVVDJQNVRuWFB0?=
 =?utf-8?B?dThXdmwzTUErdlJScElWY3VJVE8zSGpJb1E1NEJmdThGWHJQT2gwMTlKQ2Fw?=
 =?utf-8?B?MXpJTWh2U3FrRlZwenBGemkxT3RPdlJCQWlJaS9xcVpQc3dvM0ZwbDBUbDRL?=
 =?utf-8?B?M0hOZ1dhQjJIekE5K3ZweE1UNzBuc1FPUDhYK3FmcWI3ZURWUHpjL2crajRM?=
 =?utf-8?B?UDVyV2Mwbk4vYkExTGpjQlIrY3hQcVpkKzRYTWNhTFZ1bWtTL0tkbG1mbXlW?=
 =?utf-8?B?aHJxcGxYWW5HWmpYZ2RsZTRlNGhSNzJRRlk1c0R2ZkEvUERYMnIrU0JPcEFi?=
 =?utf-8?B?cFo1Tzd5TUlWQ3paaUZHakRRZVdQcTg2T3cyc0NwWXNmUEFQbml6WEFnM3pS?=
 =?utf-8?B?eGhNN3B2NDRhYXdPUzFlQWdET3FkZytOZXl3aUY0dXduZVdsV2R0ZGVFWVhv?=
 =?utf-8?B?ME83bkY5TTVyQjlUMVJhM0NlRmhZRlAvRXRuckpXbmNpS0RLMEh4VStLNWdj?=
 =?utf-8?B?NXdjRzRIMUxLQlFTano4WU5mYTNwZXpIY1QzZmU1eTFvU0F2THZpSXFFOFhh?=
 =?utf-8?B?SHBJQWl5QVlsQVZzMU5zRWVNcitsSE1qVHd6YjFKaUJwV0dRY3FHVHh3V29q?=
 =?utf-8?B?bVNvQkxKQlE1SG9LZU12Sk8rVktITGx0SUlaVGJJaHpudytMZGxLaTY4bkVF?=
 =?utf-8?B?a1UyV2FhSUk0Rmd4dmVYMmtSakg0c2UvTFZ2Mk1xQnBWQU9nQmM0T2RPNGY2?=
 =?utf-8?B?UlpXamRrVUd0ZXh4ZU1IUENlSzYvNFhjTW1IanlsM3lLZ0hFaG8xQjBkUW1C?=
 =?utf-8?B?Y2RNQ1l6LzRlcHl5MTVwWEk4Q1BFQy9LTXdvOVQwSDhWYmJpSllEVFMzMXRW?=
 =?utf-8?B?aytmckpmSUpXbGl1V1UxdmVwY0t2OHZ6VS95OElwamdHSHNpcGczT2hxU3Ri?=
 =?utf-8?B?SDFHZHJkbkVVMGFkQ2FQbzJFbTNSbGxFL3cyMzRIOXRTbVkwOW03N2lmdnpJ?=
 =?utf-8?B?SUw3dVNDZlZjYkZIUThBemlxdlJjTDk1NWllMnlqa1M2MnNaMm1wVE5Xd0dS?=
 =?utf-8?B?OWlGMkFsMVByQ1dQY0JoWmhJRmV2bytGM0xBSmQ5U0NsWStPZ0hLMHZEamJW?=
 =?utf-8?B?NzRBOWVBN210RkZFeE9Da1NuVzVaN1RONkk2SHM0QVRkZDZ1TlIrMktlUzhy?=
 =?utf-8?B?SmgxV2ppa0lJRStQblZYYVNEcGpBVXJ3N2Z3QmhUd3VwK3pTZ0tDQnRRZDcy?=
 =?utf-8?Q?NVPU+C?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 15:13:46.3930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ae0d84be-ec6d-44db-0211-08dd7b66f3e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EDD5.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4062

From: Alejandro Lucero <alucerop@amd.com>

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
  sfc: obtain root decoder with enough HPA free space
  cxl: define a driver interface for DPA allocation
  sfc: get endpoint decoder
  cxl: make region type based on endpoint type
  cxl/region: factor out interleave ways setup
  cxl/region: factor out interleave granularity setup
  cxl: allow region creation by type2 drivers
  cxl: add region flag for precluding a device memory to be used for dax
  sfc: create cxl region
  cxl: add function for obtaining region range
  sfc: support pio mapping based on cxl

 drivers/cxl/core/core.h               |   2 +
 drivers/cxl/core/hdm.c                |  77 +++++
 drivers/cxl/core/mbox.c               |  30 +-
 drivers/cxl/core/memdev.c             |  47 ++-
 drivers/cxl/core/pci.c                | 146 +++++++++
 drivers/cxl/core/port.c               |   8 +-
 drivers/cxl/core/region.c             | 415 +++++++++++++++++++++++---
 drivers/cxl/core/regs.c               |  37 +--
 drivers/cxl/cxl.h                     | 111 +------
 drivers/cxl/cxlmem.h                  | 103 +------
 drivers/cxl/cxlpci.h                  |  23 +-
 drivers/cxl/mem.c                     |  25 +-
 drivers/cxl/pci.c                     | 114 +++----
 drivers/cxl/port.c                    |   5 +-
 drivers/net/ethernet/sfc/Kconfig      |  10 +
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/ef10.c       |  50 +++-
 drivers/net/ethernet/sfc/efx.c        |  15 +-
 drivers/net/ethernet/sfc/efx_cxl.c    | 160 ++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  40 +++
 drivers/net/ethernet/sfc/net_driver.h |  12 +
 drivers/net/ethernet/sfc/nic.h        |   3 +
 include/cxl/cxl.h                     | 276 +++++++++++++++++
 include/cxl/pci.h                     |  36 +++
 tools/testing/cxl/Kbuild              |   1 -
 tools/testing/cxl/test/mem.c          |   2 +-
 tools/testing/cxl/test/mock.c         |  17 --
 27 files changed, 1350 insertions(+), 416 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: 73c117c17b562213242f432db2ddf1bcc22f39dd
-- 
2.34.1



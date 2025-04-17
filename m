Return-Path: <netdev+bounces-183914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4493DA92C9E
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 23:29:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BB5C446C59
	for <lists+netdev@lfdr.de>; Thu, 17 Apr 2025 21:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC3F209F54;
	Thu, 17 Apr 2025 21:29:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J7MZN0Xl"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2050.outbound.protection.outlook.com [40.107.220.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E38018D63E;
	Thu, 17 Apr 2025 21:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744925381; cv=fail; b=Bv2esunOp+G/i2fSNpIAMTFTaj+85Sc4mvgkxds13HTQmsr0MMxnhlt5nXO0A4hLmp/T9TviwFLTTXqQT9nIUcuxVIYYOGVJMn8QInOJs58klWIMRarbSKrC4HaeLwTO3OFtuFi7iD1LdHnJ6eH3vpAsTIrZ5KVqjOel8qqlHoY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744925381; c=relaxed/simple;
	bh=UQomPrVLyAgkECl7KBa6LW+sbOQyJUXX8CIekf2XII4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BQuUMey20mLSf7/0jCulQfPWY6KiOZifUWaYg0B6MRNHrbCaNyq6AZ/oVyh8JcYRdWHrVYHTkmEF0aqbJXifTzZzS73Ujbt4WM1thohRrnm6rpdOPosFyAhqxby1puWbFPwjUWV1iiFdtb2/gzVUorumYNu47Z5Ktd9LWcGFi7w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J7MZN0Xl; arc=fail smtp.client-ip=40.107.220.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UugsXVBFGSaCibKDdmzYeMsTZbTrRdebYVZhF7F8Hl6DM+7eNZMq0g+YETot25NEzNXY1oy5k8i8P6k/WT5fz1Zs8bidg/PydaURtuVmuTz/w5uHN1q0SAxk3o1BBhqnhmnSFqms2zycf29MsKUdUznYh9nFEEQG3dmcJ5tSHr8QfH/2RopDwJTZei00m2Yw+IKSUY9A/xaapkL3BlODBLAYgAA6yVIHX62Yxe+G9f9INO188MT4HkRskxuqp1HOK/JmKbV7hlaxaWKJky66G0zzbgr1giIRFekD0EGC0xLobybaBdQD2dAmRoVDamalMhh20wu14uUsLgAAxK9XgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TjOYaPOqAb6FZyevTQxrPj2gGXxZwK+blEroHzOhNg0=;
 b=ftzumG58RoaQ3iG9pz0D3t6rFbAvuWVdZ3rxp9Dw+31bpfI4LqkwR8kp9r5UMhX+2ObRjpAwWHw+odsNirmevf8cluSfeN2LZvRypWaNXm31fKqHrKFD16C1UmslNEm1Xiaal2uKibyjojsgFfKYvz7eCaxNGJS/e3/A2uUqczUAXKtMe/672Yn+vEMTgAphQ2vvmfG4Gozf5/FMRxs82WwWAUL4fFCHn1Bzu+gkM3yIf3WJLTkrnm9+AoAIinDstoW1AqgZn/A2pGpqR0GBhLQ4vedjHJRZf04u0OuY99O7WQ+h4XlmstwxE4gyJ8g3VGUMfCT4yx9TSn1R6wwLSA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TjOYaPOqAb6FZyevTQxrPj2gGXxZwK+blEroHzOhNg0=;
 b=J7MZN0XlZ68fA1yNSPCqXlQbco2UKKK2d4qROIFye+tVCMAfC+ArkLEiwm4pNx/v9DMArkjDFC5c2PIg+keEz8VPvo42LFtBcJMnNEa5oWVJiVUwhktJcJXAnPoFDZOto5TI95jPeQoMOmluhJiFdNW8KhVcK/l/6GAlV+sCBj0=
Received: from PH2PEPF00003848.namprd17.prod.outlook.com (2603:10b6:518:1::65)
 by BN7PPFD6BF22047.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6e4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Thu, 17 Apr
 2025 21:29:36 +0000
Received: from CY4PEPF0000EE36.namprd05.prod.outlook.com
 (2a01:111:f403:f912::2) by PH2PEPF00003848.outlook.office365.com
 (2603:1036:903:48::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8632.32 via Frontend Transport; Thu,
 17 Apr 2025 21:29:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE36.mail.protection.outlook.com (10.167.242.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8655.12 via Frontend Transport; Thu, 17 Apr 2025 21:29:35 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:34 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 16:29:34 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Apr 2025 16:29:33 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v14 00/22] Type2 device basic support
Date: Thu, 17 Apr 2025 22:29:03 +0100
Message-ID: <20250417212926.1343268-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE36:EE_|BN7PPFD6BF22047:EE_
X-MS-Office365-Filtering-Correlation-Id: 37922065-821a-4c3f-0ec6-08dd7df6f36a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WEpya0RFZ0Jsd1lzOFlJNzQ2bG05OWx3Mjh6QUZLalpkeGJWbk5IbWl1Ukc1?=
 =?utf-8?B?aU1zcEZnQVQ5SlVjZ3Q1K1RTMXJpbGtObFRmaWtOWTg1NCt6T1ZEaXk0blo1?=
 =?utf-8?B?dWl3NjdndjVwZGRic3BWNHB5YlphMUlFdHVFUEVsUFJIalllSy81NU5tcFlI?=
 =?utf-8?B?WmRTTXhXZ3MwNjBacndCWnBrdFgxKzZrUUVYVFhTM014aFNRd2hyR1JETlNY?=
 =?utf-8?B?TmJ6NDdBb25ob01MemkxVldmelpPWFlRc3NkejNqYUhCdGZUQitkU0tZNVR3?=
 =?utf-8?B?aUNCODFQNHJGdWVrbjVpRzBUemtLZFhIZytJcDB0dGpZcjVVVHViTGc0NnZl?=
 =?utf-8?B?cXk5QmpNMnJiRjZUb2NiOVdHV01nWGhUc1JXZWUzYnViZmtZTGJYbXZKMTd4?=
 =?utf-8?B?QVZrTTk3TEIzaUYwZmU3Z3hjbWZSMnV1SUJwaW9nd21sZEhBRU4rRDhZTGVp?=
 =?utf-8?B?SmZzSElIdlUvQW4zMUt0SmJGbUFWRDRERGg2Y25mTGk1Y1IwKzUvb1pzMFZm?=
 =?utf-8?B?QnhPZkVpQ0VLYmpxd0JuaksxWFlGOURxY3dlMWVQQnBFM3U5RGpFYzVnM0lK?=
 =?utf-8?B?MkhXN2hUa25nNlM2K2ZVckVoVEs1NG0ybitycDJGWjFQcmpkcTUxUVI2aG11?=
 =?utf-8?B?VDlFeEk5ZlRrUHRLL01MeDNoMUlPRk9RVTdOdE9NeUJLM2N2OTd2SVZSYllo?=
 =?utf-8?B?c0tYMHZ5SkEvOXZyU0R4b241WEswcG44RXNUTjFWS1dWWUdTWnVKRU9zZ2tz?=
 =?utf-8?B?UnlCbVZXRjllNmdGMEowek03bUVDQlU0NG9wd1JDd1d2RFdQdzc0OFRmT1hY?=
 =?utf-8?B?N2o4QWFpZFdVUkN4bFZBL3RXQ0hEQXhQMGdwMWFPWjVLZ09FblQydnFMaVMz?=
 =?utf-8?B?Q3crMXhSSEYzMGVWVDRLNm1vVlhJOGRiK0ZGWG5UUTVoK1MveDVEdHR1VUt6?=
 =?utf-8?B?R2xDR1Y5YllKTGV4MTc4cDFOeVd6NXFFVXprMHdTYkxsS2l2Y3BZR1NtVkox?=
 =?utf-8?B?Q3dLaHhyWnk2SDlrMGhsTjRlTk9hNU1oZzJwMXJkTWRxNWh2blVDSHArblFu?=
 =?utf-8?B?WlV1WW00TWdvR1RVTkdpMnFSSUNRQmhnQmt6bkEwM25TYjUzTER6WEJjQlo4?=
 =?utf-8?B?bjRLak42WStjWXE1U1kxMlZjSlBYYUF0OTc4Rm5pKzRncHZYZjg4MXRFdGhV?=
 =?utf-8?B?dVdaaU16aDg4d1BNT3drb1JyMHBlQVRYcE1xQ0dvWVRWZk5CS0pjUXlJRFJr?=
 =?utf-8?B?d3l1K0xEckg0ei8xVlFXR21IR1prQ1ZURDlTSCtNWUpXRTFuZS8vRk9UM0Ir?=
 =?utf-8?B?YjBiVWYrS1g5VFZnc2U0T2lkMVBONmN4RVpCd1JtNGlVWXN5ZXJYdEVJc3F6?=
 =?utf-8?B?UVRCRVQ5dDVkS2Zaa09ZV3h4SlFYN0JubjJyL2hEWHhYbktsQzZ2UlgzOVpK?=
 =?utf-8?B?SkZRcXkvUld1dTArN2ZKM2V1N3BSK0swREMydjZUaHphTGJZZlRPSGVna2hx?=
 =?utf-8?B?N0NUc3BkaHF4MnVmWlhLQXFBc0FaS1pVOWc2TjlYK0ZtWEtYaXl6N3YyWkdn?=
 =?utf-8?B?RkJjbVA0QndvT0krWmxNV2xnSk5tM0tNK21PRWE3b1ZibTBlUVBKc1BxelJC?=
 =?utf-8?B?OWZOVkk4TU43YkpBa1MrWnhybFd4N0VoVnJCMHI0SFlqeWlPVnQyYzZ1S0hH?=
 =?utf-8?B?SERHSXVwb1A1R0RhdHk2TnNERno0TXU0TG9ONXNEQ0hJRmxUa2MwbDRaMGMw?=
 =?utf-8?B?SDZwNFI1VmlUVDFHcG9XRVlNQXErSnNPMEF5WVFiMklxY01oVVNsZ05McXZQ?=
 =?utf-8?B?NFMzM2NCeWxtY0pZSjhVVm0zc3lKVHlyK29HNlJhQ3ZjdlQxa0RFNEw1S1JJ?=
 =?utf-8?B?RWlLNTc2ZXFzenZEUStsL2ljdTFoRGlyRUwzQ0w4UHB4Rk5VRW9JUUx5VE1x?=
 =?utf-8?B?djZHNjQ1YUQzaExXSVdnRldQRTNwZkFiVjNoS0JmdzVJSjMrZXA2aFRtR1Zo?=
 =?utf-8?B?eGw5aG1VbVB0am1sSjJZR3poMXNsRzJmZWpSbzRhTkxhOGVrd3BUdFgyZU5F?=
 =?utf-8?B?Q3hSRSs2Z1JXUkJxUDF1Q0pmVFArak0ycFNwQT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2025 21:29:35.4313
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 37922065-821a-4c3f-0ec6-08dd7df6f36a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE36.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPFD6BF22047

From: Alejandro Lucero <alucerop@amd.com>

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
 drivers/cxl/pci.c                     | 111 ++-----
 drivers/cxl/port.c                    |   5 +-
 drivers/net/ethernet/sfc/Kconfig      |  10 +
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/ef10.c       |  50 +++-
 drivers/net/ethernet/sfc/efx.c        |  15 +-
 drivers/net/ethernet/sfc/efx_cxl.c    | 159 ++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  40 +++
 drivers/net/ethernet/sfc/net_driver.h |  12 +
 drivers/net/ethernet/sfc/nic.h        |   3 +
 include/cxl/cxl.h                     | 276 +++++++++++++++++
 include/cxl/pci.h                     |  36 +++
 tools/testing/cxl/Kbuild              |   1 -
 tools/testing/cxl/test/mem.c          |   3 +-
 tools/testing/cxl/test/mock.c         |  17 --
 27 files changed, 1346 insertions(+), 417 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: 73c117c17b562213242f432db2ddf1bcc22f39dd
-- 
2.34.1



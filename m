Return-Path: <netdev+bounces-163036-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9AADA2944F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 16:23:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4AEA16045F
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 15:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BBB91C6BE;
	Wed,  5 Feb 2025 15:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="sph+l09J"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2053.outbound.protection.outlook.com [40.107.96.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E068151984;
	Wed,  5 Feb 2025 15:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.96.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738768803; cv=fail; b=RyD4mQbPLW987dhyn1D2lE2bsvjBFQ2QWh5d5e8hhdulbWgPCrVWMXF+CdneYwY8+CctucPhl5nKqA4hs0KidlEydxF6wbu7ccpu3r2WHYAVgxv9+25zEfVAoiLujjU6iKMnbfKSVUYxRFxBURXTJsOxreVfXjR1aZDf4JQMcAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738768803; c=relaxed/simple;
	bh=/YWrFtu2osAXqUwQ7VaOK3nvID8o2AAjXc0Iyhhj+VY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZB5AcyjSKwCASt9loN0Txyc0d+CHH2M5WCvcRmRnynKcjXY1SECKMK8z5G7CL3QA+f2w0+KzuuKgPN2AHOfnHtujndjp9wVuYqDoHRh+EoDxzlbu7XE05jO60fL29wJuLFay09Nd0ERbVDBM31m2L4oPx2idC8RpmB/IUwcjI84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=sph+l09J; arc=fail smtp.client-ip=40.107.96.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Kiyj4rSlZ/oA4qdxnVIhaGc9iAqagbGizWc2hlpEGJt4CxGt4l8zE4nX2d5Qw16cTTmsQTqG1/Y+/HXXPkcxVoUitIZJlXSmAsUoysVPvDPDXj6uyad9NCsfbVHS8W0+2wTvu8eNnoRc3k8mC8xBZ36KNhBm81HXkRgOcxfkroxlfqzxtkHpyjXTMX/wxzBU6UVdIyPkCVBukbw/aw/R+xSj73toLlsZNOPT5bzFD+me7iPekp7zrZdaiNpqgDSuNULT2fANgG0Cwj9MmTgQLt8FXr4Zbg6wh1dlF62U0xIOEUldrPmPO8K7P6f7kgnmbkyKNvu8g/niMtUotMJmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9kWPvC9FvWYdwCmmBfJiZ5Hc8LE8YO5T9sNgGLlGOVU=;
 b=uz4vlPt0VyXeoxWH5H5TFoXRwbw6ZeLie1q6XA8JUXVm9qjGta1AuUmwPqBXj2kbGjUaU6o4dgdsb+2F/PxV5HHawGqaSediW4ZWQW/fcM//9hOTTCEnzDjOAwufI8+xKD/w3NXMGgnOxh7pM8M1R6VbPUH95Pq0lP2xTyeU3qbpbtZOppIaci7NzQP52P5bCksZEJsVJrOr4XD8nAn6pA2xFGsZOzmBnRuYzlBuHSYKMHU+9HyI9lHk62en+MsT++d2nqR9ENqIeZmks4vxRbCh624YChilLI1vYJiLosE5K1mr8oz9ZXsPxEPxgz+wYERE/2z/jK3DdksttY1o1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9kWPvC9FvWYdwCmmBfJiZ5Hc8LE8YO5T9sNgGLlGOVU=;
 b=sph+l09JSFmGe2En8oUqshrIyK6ic27ZK9P8tY6WODZhFWtYbuwJsl6F0sklGfINVUEWE3Dj4HKw2Y4sGZlMU12x+SLFZSGerxc5Yv2lm+mM7IXYeaLSt/LRvQU29Ujk+4CfTpNDopsZVJzezKwWHTjMzsY5ER47TbRDvUzRy7w=
Received: from DS7PR03CA0045.namprd03.prod.outlook.com (2603:10b6:5:3b5::20)
 by DS7PR12MB6142.namprd12.prod.outlook.com (2603:10b6:8:9a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Wed, 5 Feb
 2025 15:19:59 +0000
Received: from DS1PEPF00017096.namprd05.prod.outlook.com
 (2603:10b6:5:3b5:cafe::1d) by DS7PR03CA0045.outlook.office365.com
 (2603:10b6:5:3b5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.27 via Frontend Transport; Wed,
 5 Feb 2025 15:19:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017096.mail.protection.outlook.com (10.167.18.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 15:19:58 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Feb
 2025 09:19:58 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 5 Feb 2025 09:19:57 -0600
From: <alucerop@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v10 00/26] cxl: add type2 device basic support
Date: Wed, 5 Feb 2025 15:19:24 +0000
Message-ID: <20250205151950.25268-1-alucerop@amd.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alucerop@amd.com does not designate
 permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017096:EE_|DS7PR12MB6142:EE_
X-MS-Office365-Filtering-Correlation-Id: 2c912d7c-38fb-469a-f244-08dd45f88de0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|82310400026|1800799024|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?dDFhRFN5aTVvc1VvUGhUVXo5QW5tWjd0T3Q0U2lVd2RXV1B0L0dFNDh6NGdv?=
 =?utf-8?B?OXh4a1Z5QmVwR1lRdVAxRWhlUnBLbTRraEFkNEpYRVNhdWk3QW0yUE83Nlhj?=
 =?utf-8?B?WndnWmk0cGdvLzJVV0pGandqT2lHZ0lQZnluMlB1dlpNS291RnB3clVRbUdX?=
 =?utf-8?B?RXJ3c3g2TGRMRG4vU0FCcGhoV3JEQlhWY1pxS2pQbjdVdkdxcUthb3pNZHVK?=
 =?utf-8?B?SXRvNHlXNWFNamFUR0RrT1FWbFlsSWJHOGEzZDZncWlXNTlPYm9lT3RXR01W?=
 =?utf-8?B?RUprUFRYNy8wd2VGeFJaTE1HVmwrR2ZqUFNZaUdHYjQ5YjRuRGRRODdtSnEx?=
 =?utf-8?B?L3ZjRUs0Tm5rZE0vdTNKcVhaVDZTOFYzckVVSjlKL0dWOUk2djIrczZGckJI?=
 =?utf-8?B?MkFac0ozZXZhUjNIZXZUZ014bXgvQVFoSVo1REVvSisrOUxicTZJelFLRGZv?=
 =?utf-8?B?UkpOSzYxdEg1SXdNZ2R0TGx1SENkUm40ZUhPWTduWnpUbDFSU3VCRE1wQUhP?=
 =?utf-8?B?TzU5Rk1NeDI2cVViMFFuMk01UFRIeW81V2NCVnBNY0FCOXArZ1ozTlloYmxB?=
 =?utf-8?B?TGtBOVJpNStxdlhTZUw5R2xkOUhYNW9mbmhMQzRjaitBU1diTUtWL0E2MWJ3?=
 =?utf-8?B?SVFOOHdxUS9TTGhXdlFXTE80NDliTjdJZGp4L2pkTmVneWZXRGRISlJSbzVZ?=
 =?utf-8?B?QTdGZXd0ZGw5RU5KYTA4Tm5OdThNSWVWOHoxSmtlNThYUk1PcDN0cTZXODdo?=
 =?utf-8?B?UUk2S1ZGYXpkT3Bsc1lKMWtFOVZ3QVlyQTFUM0wycHp0YXZITlpXZkFvMUtU?=
 =?utf-8?B?dllDb2JMZ1o4SmVNVXJlWTdYSUIwU2FoY0hDQXFEQWFDNjBLM3JIbklNRjBu?=
 =?utf-8?B?eFhiSEphYStsQktLQlRnQ1NvYUZiYmpVQUk0cEZRNGZRYjlFVnE5R2k3NytT?=
 =?utf-8?B?RmFyaXJpWDk3RnZjMkx1OFFIaytOSTR6OGNxKzg3aTFyQ1ZnbGF4OEpZR0FF?=
 =?utf-8?B?eithT0t5S1M4Z2VxR1BLQmNVMlpwYStUYVR3cDNaT29lU1cyZFdzVzhiNGYr?=
 =?utf-8?B?L0duOUhuVTVET2l5UUY2WEQ0VVVtc0gweGRTUlM2RHU2MXVnZXZaN0w5eXdx?=
 =?utf-8?B?cjRpQVpPY2oyTDNGUWIyMlVRN09nalZXeFdLVW9QVS9MVGRLS0pLVVA3Snp6?=
 =?utf-8?B?NTZVandVVlNWOEtBazh0WWVlcUhFOGJoMW4xMWs4SFlORTVzRkN2bTBBVmJ2?=
 =?utf-8?B?OVRSd3g2MDdzRGNhNlBFYmtnblBKS1p6a1VPL3BWQlRZUzVXMmVtQjlLQjBn?=
 =?utf-8?B?N2t6emIxbkhzbkoyZjZBcXUrQUlNTnhvZlIrY1hSVWc2dmQyRmhzcWxpa3JF?=
 =?utf-8?B?RitJM1pWVDNiUGpyUEs2emJzSjhjdGNXbllZZzdMM25NRXRYSmZLUDM5VU9Q?=
 =?utf-8?B?eWVVMTVHOGpLNUZDYXNMNEZXZkV0d1FPNjlaOFBpUkw4KzVtQzFJNjlOTkNl?=
 =?utf-8?B?RlVWWWYzVHFadVdYVzFqN29aZVJMV1kvRVgwUGpWaS8vMFY1dk9VbU5id1Z2?=
 =?utf-8?B?bkRLRzRLdXd5VzkxbnZad1FzVHJtYU1nNWpYdmRiZ0xhQ2Y2a0oyZHNJbHVP?=
 =?utf-8?B?dC9ydjdGZzNkRTFwZStIZHBCamZBRlp2VlpSSUtISFlrMXlNMkNKWk42Znha?=
 =?utf-8?B?dkpHUWhiSU42R2c1QW8vNmZVYTdoc2l5OGZybnlYbU4vejZmajM4VklYTjNo?=
 =?utf-8?B?Yms5cmlkKzR0bVY4MHBGWEt4TFh2My9kcEkxNHZvZng5K29RcjlnKzN5WTBM?=
 =?utf-8?B?Z1pmZXZ6a3VLK3FlTWFhVy9jYU5pQ2NuWU0va0JrelpSOWtZdEI5SnBQUFE1?=
 =?utf-8?B?ZDhNVFpERFFZWFMybTZyVUNXK0R3R0htSm9iMDJ0U0lndFpLS1ZvcTk0RTlZ?=
 =?utf-8?Q?wYNrpt4hEGs=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 15:19:58.9920
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c912d7c-38fb-469a-f244-08dd45f88de0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017096.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6142

From: Alejandro Lucero <alucerop@amd.com>

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

Alejandro Lucero (26):
  cxl: make memdev creation type agnostic
  sfc: add basic cxl initialization
  cxl: move pci generic code
  cxl: move register/capability check to driver
  cxl: add function for type2 cxl regs setup
  sfc: use cxl api for regs setup and checking
  cxl: add support for setting media ready by an accel driver
  sfc: set cxl media ready
  cxl: support device identification without mailbox
  cxl: modify dpa setup process for supporting type2
  sfc: initialize dpa resources
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
  sfc: update MCDI protocol headers
  sfc: support pio mapping based on cxl

 drivers/cxl/core/core.h               |     2 +
 drivers/cxl/core/hdm.c                |    87 +-
 drivers/cxl/core/mbox.c               |    20 -
 drivers/cxl/core/memdev.c             |    52 +-
 drivers/cxl/core/pci.c                |   127 +-
 drivers/cxl/core/port.c               |     8 +-
 drivers/cxl/core/region.c             |   424 +-
 drivers/cxl/core/regs.c               |    37 +-
 drivers/cxl/cxl.h                     |    21 +-
 drivers/cxl/cxlmem.h                  |    38 +-
 drivers/cxl/cxlpci.h                  |    19 +-
 drivers/cxl/pci.c                     |   123 +-
 drivers/cxl/port.c                    |     5 +-
 drivers/net/ethernet/sfc/Kconfig      |     6 +
 drivers/net/ethernet/sfc/Makefile     |     1 +
 drivers/net/ethernet/sfc/ef10.c       |    50 +-
 drivers/net/ethernet/sfc/efx.c        |    16 +-
 drivers/net/ethernet/sfc/efx_cxl.c    |   179 +
 drivers/net/ethernet/sfc/efx_cxl.h    |    40 +
 drivers/net/ethernet/sfc/mcdi_pcol.h  | 13645 +++++++++---------------
 drivers/net/ethernet/sfc/net_driver.h |    12 +
 drivers/net/ethernet/sfc/nic.h        |     3 +
 include/cxl/cxl.h                     |   104 +
 include/cxl/pci.h                     |    36 +
 tools/testing/cxl/Kbuild              |     1 -
 tools/testing/cxl/test/mock.c         |    17 -
 26 files changed, 6021 insertions(+), 9052 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: 6cd498f39cf5e1475b567eb67a6fcf1ca3d67d46
-- 
2.17.1



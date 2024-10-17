Return-Path: <netdev+bounces-136661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 189CF9A29BB
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 18:56:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A5071F24966
	for <lists+netdev@lfdr.de>; Thu, 17 Oct 2024 16:56:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45B361E0B99;
	Thu, 17 Oct 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GdPnIqND"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2057.outbound.protection.outlook.com [40.107.236.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3362E1E1317;
	Thu, 17 Oct 2024 16:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729184002; cv=fail; b=tivOd6g4D0MF08kf0SEyhby5IxP3pCY5GzVZJZhU6X3AC/CUgDmxoQhf9FnnbbERtarKjJVfat12h/wuDmlcNkOlg/xmSNDL/dydJFxNa0IzhuEwhol/x+DiBBTxOdy/IcdAf6ZM3Coup9vdHwiHcXVB9NRbTXGl6N9b3UqC5U0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729184002; c=relaxed/simple;
	bh=fSbkoLPX9ILkrxXjyf6ESIyJAsLC7ys3LTsmzcRjYEE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KVsEEqfJyq5LqEpSF9IFQLNlZ0YJZof1kbzTaT3Qn3XoNhDVR9a+EdcB5d31ljt2+8zJwS+ZNUSoDLijMSLqyh9EBXh0pGQkTw5nUEwNPFSkW+h9Xi+OpPSbRFZHtMbvi1QlhJ7MwNO1YOfERoojOd68Ki54zakYgz9jrcMMtkQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GdPnIqND; arc=fail smtp.client-ip=40.107.236.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Uke2cEWI37a7K9+yWht4KiO9YY99ev4SFFcGq0vZQ+vq7TfubIVuN0yhv5F5fKHp6HtKdFKEb+XqNSdIqIyBAu2gDFHWgQ71lYusSCTin/O4BwD9Nz3oWYk8onNvjtcf9uG3eE+0altpusd7YbUnyTPIj+xJceGM3ZoCbArrMpNJ/9Xn+qsNXFQAOHstF3Btvgab/PXaJ58ffM3eSPJT72IBrooGTHj9TmfcvSghF58Mv9uNxS53odKb/ErTNr+Ej3Ob2HmI1wBYkwWP5XBTiVRJvg0o3zfBGX/7y5KWStXax+fN//pgoqxbe+dZPPQaz/1Hscspf7mPGss0iz/O0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUupsjD5FQpqjCuaBWupdMU0BQdVCE2M4YPMa9iQ4G0=;
 b=S06p/dLx+kgmKIp9GEs0y24MNYVOBsTPI2Q8nifoDOiOOAelEvjVN8f5W5qqggJskemu3Cq+waF+6kZ8lEkSssg+d7XT4agLRZ1atJZc0Es6ie51+EIhld4f+mchRuxwSupyggJE+7ls+dA4/rY2SmRUgJ3k8nz/Ctt9r2Yf+1UzLPxzioxzDR4Q8mFf1hresXP277CiKuZ6uLQdBgaNqmIPe0b6JWRF0pftUF4P6ptq16Bznrvc5VQDRwraRkOvWX2MqhLZwDMqT1XKItG4dciQno35GMaheQwAQgJw/N1JsRkMb99ubXVaJ3mJI5Bw6Hjbul6B68qhUCbI1Fw3yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUupsjD5FQpqjCuaBWupdMU0BQdVCE2M4YPMa9iQ4G0=;
 b=GdPnIqNDbwUj2ChQcOIVEfmwS5KiQWwY2rjZL0WB0L0k7gfnXTfFGrdyy8DDwh/4pN/200S1ieJ4Efb9zTdwRmIURFfIAsCPIU2X2NDoe95kT6J3ooR+jqPhLVzGxO38bFZSjKrHaMjfUtRJPjK0Bu6yvLO231OUahvsJ4ovHpg=
Received: from BN9PR03CA0931.namprd03.prod.outlook.com (2603:10b6:408:108::6)
 by PH0PR12MB7887.namprd12.prod.outlook.com (2603:10b6:510:26d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.17; Thu, 17 Oct
 2024 16:53:08 +0000
Received: from BL6PEPF00020E63.namprd04.prod.outlook.com
 (2603:10b6:408:108:cafe::c6) by BN9PR03CA0931.outlook.office365.com
 (2603:10b6:408:108::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8069.18 via Frontend
 Transport; Thu, 17 Oct 2024 16:53:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF00020E63.mail.protection.outlook.com (10.167.249.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8069.17 via Frontend Transport; Thu, 17 Oct 2024 16:53:08 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:08 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Oct
 2024 11:53:07 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 17 Oct 2024 11:53:06 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alejandro.lucero-palau@amd.com>
Subject: [PATCH v4 00/26] cxl: add Type2 device support
Date: Thu, 17 Oct 2024 17:51:59 +0100
Message-ID: <20241017165225.21206-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.17.1
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E63:EE_|PH0PR12MB7887:EE_
X-MS-Office365-Filtering-Correlation-Id: 5adce22f-83da-4c59-612a-08dceecc2db4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?MmhmVzczTVJwb3ZQR3dPYVdvQ21va21keVRyeTB6QW1GbjBGS0tpdVRpRzhi?=
 =?utf-8?B?NnhtN1R0MU5vRG43T2hPTlVLMWtwOEUwczc0V1MyWGFuZVdScFhmNXI0d1ZN?=
 =?utf-8?B?aDBub2luQkpGanZId2tHRFcvS1luRzNxK25LTDkvbjluczVIMjZSNytkMHlp?=
 =?utf-8?B?b1ZENmJNNkcvbFZHam14cnVhNWpsb21GMkt5aFFmdnpPYnU3QzV3bkhhTE5E?=
 =?utf-8?B?LzRHSTE2QUtuRWJ0bDJJMGhLTWE4U1dHWXEwTHZ4UkpQR2ZQUzg2RW0yVldt?=
 =?utf-8?B?Z3Fhcjk3ek9yT1BqMmt3N21HQkZPeEZ6ekxNSWdLZHQwT2QzUkZkeTlpWUR2?=
 =?utf-8?B?ZGI3eFN5Y3hndzdMRGYvRFNCc3RnamlURFR5RlN5TC9hUUYzd0tQYTRZd3lS?=
 =?utf-8?B?UnBPdnlIRGdlellJVGE5R2VhL1pLL0prQmErQzZaTTVURmM4QUxDTGJkUUE2?=
 =?utf-8?B?bFJBSys1VkpheGlaYVhQcXBFanVVdVp1V2ZMZTlSU0lhRWl0QWNUYVdFY1pJ?=
 =?utf-8?B?NFppTjd4emtncVhCclhNdnJuRzdwMG9UTnVwWm9jNDd6L1ltRE5oZG9sNVhj?=
 =?utf-8?B?TUhTcW5abXBOMHNscXU2TVpVTWtBaCtic3NnMXJyL3FndmwvR3ZRYy82d2gr?=
 =?utf-8?B?cU9ocElJcEcwNVpQNngrcFAwZ2lWVk55ZG9aaHMweDB3a3dkZEpvTkRBT0RZ?=
 =?utf-8?B?U3JZNjEyVUJiOElIblpLdElBSWhnRUdmbU1yU0dudFFkSFgxMXFsVVlhNmZO?=
 =?utf-8?B?d0NDZFBSSnlLVHVzTzhiNjZhc242b3piZkQrZHhFM2xDVlIrR1ZseHBLM1VO?=
 =?utf-8?B?dldxZyt4aG1PTzl5eThCWUxKTFhGMzNUbWF0dmdtOStIV2xMTkl4YkxrYTBr?=
 =?utf-8?B?ejVvbi9TSXBOZ2ZNSml4ODB3K3g3NjBUSk5ScURuOE92OHk4dTZxNk9TUDM0?=
 =?utf-8?B?amk1QWpybWRvY0t5dENvUCthdFltdy9LaVUrZjNOQkNtcFZrRnpvMG10SVdL?=
 =?utf-8?B?cHUwM2dReXhGR241VW1xWE85ZGtqTytNdHZ1MlNwUFFyV3daMGhpNXhDNHdW?=
 =?utf-8?B?VzFLWERTUnBGeWx3Q0hGRmFQQnEvRzZlc0dKQzBQaGgxaGJGMXBJTGNXRHBy?=
 =?utf-8?B?bSs1eGovYk5GSXZaV3VhN1Jna3pXdWxaeXJERWc4VjFwYkVVMXZkVFdxSXBw?=
 =?utf-8?B?Y0dueWZGa3dkbStlSzNHS0tnS3V5VHliZVVOamRCRWhQSklrY0NUckxRY3Ew?=
 =?utf-8?B?WXB6VXBXMnU4S2xVZzJXNHhSUXRaWWpZVko0NkZwakk5QlJETUU0Y3l2bjJE?=
 =?utf-8?B?MmtHYVpFZG4zbTFQYmxzN0s2eUtvUzJpcm1DVGN2bzA4eHVWZVY3UmJ5R0ly?=
 =?utf-8?B?aVR5QkZPNWhjQ2lGSUVJenpoK1JTN0dHeEVrRHdZWVJnVnRGb0drR2k1V0l6?=
 =?utf-8?B?enFiclNqbldBRE4zdDdCZ2J2VndYWVhwWUVEUGhXdWttSTMrY0lJTWtKNjhB?=
 =?utf-8?B?d0FSMm1oNGQwak1Vb3hlMHI4UEhHd2xYcndKSWlYWkdWL2Z1MlorYU5PaWRk?=
 =?utf-8?B?TWViTGYyVHYxcm00S2VxN20zWnMwc3pDZUFMMk03d2c0QnJna2lSRkRGNzN3?=
 =?utf-8?B?cVFXVDJhL0MzSGV2RmQ0NEJJaDZZd2FDWmVyTGlQQUhXSThNeU95Zi9EWGF3?=
 =?utf-8?B?bDFRS3ZCUUZrVG1pazVkMXY4RTJFTjZqSlA2a0RvZkpGbE9qYkt4ZWV5YTNV?=
 =?utf-8?B?SDcvdHpzQkdVQllmakpqQm1nZEhNMHR0MysrS2xKMFliR0hnbkZEZDFKemxy?=
 =?utf-8?B?Y2xnOW1LMkszTlJDTldCblErOEdIdXd2Z0dCbzhzSys3YkNLUGM4OGNqRWkx?=
 =?utf-8?B?SGY3K1d2ZXRuTm5CdUJic21McjJtSFIwenlhTC9WZWhDOFE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2024 16:53:08.6677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5adce22f-83da-4c59-612a-08dceecc2db4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E63.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7887

From: Alejandro Lucero <alejandro.lucero-palau@amd.com>

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
  cxl: add type2 device basic support
  sfc: add cxl support using new CXL API
  cxl: add capabilities field to cxl_dev_state and cxl_port
  cxl/pci: add check for validating capabilities
  cxl: move pci generic code
  cxl: add function for type2 cxl regs setup
  sfc: use cxl api for regs setup and checking
  cxl: add functions for resource request/release by a driver
  sfc: request cxl ram resource
  cxl: harden resource_contains checks to handle zero size resources
  cxl: add function for setting media ready by a driver
  sfc: set cxl media ready
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
  sfc: create cxl region
  cxl: preclude device memory to be used for dax
  cxl: add function for obtaining params from a region
  sfc: support pio mapping based on cxl

 drivers/cxl/core/hdm.c                | 160 ++++++++--
 drivers/cxl/core/memdev.c             | 124 +++++++-
 drivers/cxl/core/pci.c                | 124 ++++++++
 drivers/cxl/core/port.c               |  11 +-
 drivers/cxl/core/region.c             | 409 ++++++++++++++++++++++----
 drivers/cxl/core/regs.c               |  30 +-
 drivers/cxl/cxl.h                     |  14 +-
 drivers/cxl/cxlmem.h                  |   4 +
 drivers/cxl/cxlpci.h                  |  19 +-
 drivers/cxl/mem.c                     |  25 +-
 drivers/cxl/pci.c                     |  95 ++----
 drivers/net/ethernet/sfc/Kconfig      |   1 +
 drivers/net/ethernet/sfc/Makefile     |   2 +-
 drivers/net/ethernet/sfc/ef10.c       |  34 ++-
 drivers/net/ethernet/sfc/efx.c        |  16 +
 drivers/net/ethernet/sfc/efx_cxl.c    | 186 ++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  29 ++
 drivers/net/ethernet/sfc/mcdi_pcol.h  |  12 +
 drivers/net/ethernet/sfc/net_driver.h |   8 +
 drivers/net/ethernet/sfc/nic.h        |   2 +
 include/linux/cxl/cxl.h               |  81 +++++
 include/linux/cxl/pci.h               |  23 ++
 22 files changed, 1210 insertions(+), 199 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/linux/cxl/cxl.h
 create mode 100644 include/linux/cxl/pci.h

-- 
2.17.1



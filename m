Return-Path: <netdev+bounces-154569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A46E9FEB12
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 22:45:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC01F161B9D
	for <lists+netdev@lfdr.de>; Mon, 30 Dec 2024 21:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 918B119D06E;
	Mon, 30 Dec 2024 21:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AVudEjz7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2079.outbound.protection.outlook.com [40.107.101.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919EE19CD0B;
	Mon, 30 Dec 2024 21:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735595105; cv=fail; b=axfqrxl9PltiJMauKkpt+pmM0X0y9PAQIcfKaj8ghaogIzvQmvaCge8e/VsK8EDNoIV/+K/0R2CHjhQyoP0bjTQKw4VGEhx0Uc3J1KaFANAg9HLI1b4FLZlZElHWrdM7EBE76kzWFc4q3V1cHmqOLrQJSystJsSC/yrF+GayuBc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735595105; c=relaxed/simple;
	bh=RxMlwh5kxtNvZo2gRzZ1DXqBDd3LSI4YHjkHup+PP3c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ecKf21KoZFgsN9BEKzkNVwxrLCsvuyo8t5DAaMZvl9jQnulblrb+8kpR+EBfjmHMsRK05gAL8RJ5x5tfUyUat9/Ipfk7bE0pi4uBla4h9rNTEKjzwn0HCYu9fPgSevjnaSxo57SgurGTHD4KFjLzrrw+LQrqVNQDOfDFedKbeRo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AVudEjz7; arc=fail smtp.client-ip=40.107.101.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aufAtDJSZhNpxLA8UG8aSbKixglA7u6UGexrXkEec62/gi9oLU33+vxldtftvYjd24tgJKfIVt/nkbFtgnTiCAHRUIfn2K6dhgu/UoearbtAaDAzwDC7aZIHab6YRM0OT7tmL9FCz3DybfUMQkE+a7x/DktiHLMrbdkM10Px3V7mIcwCXOrrKh8sRSRnbyYcr6m2/YH6YvODX4vK+ya5yocKYDbSrRqAzLeyIYHeGyUP0WeitvWTLgdaYjjEVucPT5mPZtdVg4GAcZg6xw7aiej0C9HmC4IpIj2nLB5mG62rLWpfQf53DgD376KAhVOwy6xhoSj3Yo/SkOV0fLlQvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=psKl+AumfXCoUFyL0OCwa7KHZQvVHkN4qREPG8fSqY8=;
 b=MAvCuwULziTdf9Hx2TaIZIerUY7y67igmAiletm32stXIH9NU5b0KeI0IlCbyyAa5iNYSCVDzSNoX/NJPJ9XoD5TwGF6whM6ex2PGnG0kgVxpuQO5U/n+o9q0pwcRjDKhZzZCF5EPxkTNCD+0INQKgz5wYi6wWYP2wNKEDHYonrZhW9b/f2vSF8oPPhbaD/psGtV80R+zDRvinjpvt/RMfjNJ/VYu4vzfBbsXijGt4CkznFXRsRdv4BIM6paOvhPnswaHl5xNKouod/Umm1gXp6JxH/iluWLkhKCIyXC/mHNrpG7Z6U+trgoNWahtJ6P9ci8N/Tzq/3a3RsPurGjjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=psKl+AumfXCoUFyL0OCwa7KHZQvVHkN4qREPG8fSqY8=;
 b=AVudEjz7qcwM7wAqcRtHz0+FV54CVmvYAKEpY7vzX3K7a1nr6SSmv9Yn2SrZTAp5nDPJYTYF3Bvv+CUZ4XodjkbWoxP6RthsPhlWFqj5khqFfcqu8rRk3P1RN8FoRpUYIkh8TL0b/tAVkJA+wtw/LfdhgK9YdWWK3FxBeGmIgrE=
Received: from SJ0PR13CA0011.namprd13.prod.outlook.com (2603:10b6:a03:2c0::16)
 by DS0PR12MB9397.namprd12.prod.outlook.com (2603:10b6:8:1bd::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8293.19; Mon, 30 Dec
 2024 21:44:55 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::aa) by SJ0PR13CA0011.outlook.office365.com
 (2603:10b6:a03:2c0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8314.7 via Frontend Transport; Mon,
 30 Dec 2024 21:44:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8314.11 via Frontend Transport; Mon, 30 Dec 2024 21:44:55 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 30 Dec
 2024 15:44:54 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 30 Dec 2024 15:44:53 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v9 00/27] cxl: add type2 device basic support
Date: Mon, 30 Dec 2024 21:44:18 +0000
Message-ID: <20241230214445.27602-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|DS0PR12MB9397:EE_
X-MS-Office365-Filtering-Correlation-Id: 80dab4b0-02fd-4f58-4f35-08dd291b3306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|36860700013;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Zm5vQ00yYnlIQkdyZzJZQnRKczk4NkZTQUdiRjdpTHhCWGxVSjVKbkRHaUc3?=
 =?utf-8?B?NWhCVGVGdUFBaVhlYVk1cWJKWUFSNWFJVURycVdxb1lqMTlDQXZTTUd2QnZY?=
 =?utf-8?B?Snhmb1pTR3UwMjBGSWMrY2xoM1VHeHIyUEVkNUhUZTIwdjlrb1EydDVWMUlp?=
 =?utf-8?B?YSs3Z3BPa0Fhb1Q1TmJCWWQ1NTRsWklSbUNuT3g2RmpUZExwSXgxUnZIUmti?=
 =?utf-8?B?VWE2d3ZQSlZXWHpTVHoxcGZVYXJ6QjJsK0FDUktxMVRoSHk4YllCTWxROFcv?=
 =?utf-8?B?anR2ZFhYeGFhU05uUjQyT1BNRWt1bkYvTlVnaWNUSEtFYmFTZ1hPRFp0TTJ5?=
 =?utf-8?B?OFlhcUpLZnlSbzJaeG5uQmdSRG9qZ0d2YVdzMTNkMnVFTHI1RHJFSnF5NFNL?=
 =?utf-8?B?MjlQays2OXdUWUU2SVY1U054ZEViT2pUaHVMQmZSWkpyaHlneGtPU3ROTUhB?=
 =?utf-8?B?U2NJUUliby8wb3U2Mjd2dzNkeElieUhGclN6RnRBUTJIZ1NiTHFVOXV1dkxB?=
 =?utf-8?B?dldYVCthbE5tYkFVMEdpTlF6NFUvMTkvQjNxS1ZiVEsvbHRudmxZMWVuL245?=
 =?utf-8?B?Q2p1ZkpGOC9qY0hDQWpJVnBKSG5keVk5dkgxcUcydUpJUk1WdEx3NmlqdUw5?=
 =?utf-8?B?bisvVlN3YmNsbXJGR0JxaTE1N1hVZW9qbk96Z2R6aUJ4NC95UFA1T1U2VGRT?=
 =?utf-8?B?dTVvU0I3TFB0L1V0bW0weUR5SGZQK2doSEd1VlZROWpINFFNYkhyalQxRFpH?=
 =?utf-8?B?RGRTOVIwODg4dGVKeE1TN2ZEZVpuL0JYbEdZd3JLMnRhWWF5NVJ2RCs2aGF4?=
 =?utf-8?B?Y29IT09VTElBQ1NHeFZpTmpReE5na05YRUxLOFlFUmJnVmxCOEMrRy83QlRw?=
 =?utf-8?B?Z01SVzg4T2JmZktiYzlpNDY4TjVXQnZDcHVXNUNtc1dlb1d2bldDaXF0SmVk?=
 =?utf-8?B?U0htNklrRE85a1VKZS9lWklXVzZwRS9OeDA5ZHVZRmsyTFU2anRvU3poeG1H?=
 =?utf-8?B?Mm1uUTJtdU1URU91bi9oK3NaZS8xWnFLR2hwOEdBMmRGWUFHNTlrd1k4aGRK?=
 =?utf-8?B?b3ZWc1VNZ1lKRG1vUGppTE1ERlY2cW9OVWh5b2YvdDlnekxqaVdmZXR2Z05O?=
 =?utf-8?B?YU9NVTR6Ylp6YUFGbWRMaG5RdWZBU0RHUytzZVoxd25nNU1WOFZGR2NtVGZF?=
 =?utf-8?B?TGg0bDlnRmJVbEgvOFB3WWNSU1k0bUx1RVEvaVlQUzhGdmlvbEVLUDlOeWkv?=
 =?utf-8?B?OGN1emoreXM2bjNYNnJUV3VBek4rbVZQQlZrejZVNDhGOEtYWGcrY0ZRRzJG?=
 =?utf-8?B?VFc5cSt1TlFNN3EyVWNtd0N2cHZLcHhtemdmb1FJb2lHZzdhREhYRWtRd1pX?=
 =?utf-8?B?R3o2UXJNeldab2UwTEVNV0k5ODJZWi9yTXZtVjBwSFpYMHJ5Y3lnVXpnZGZD?=
 =?utf-8?B?NFROaGJyNThkekdmdW5JbERLaU5Ub3VDUm9UR001WGNVZ25TaGVQVkRvM1BU?=
 =?utf-8?B?NUg3SjR4NjMwelZiczlVVkpUYUphZ0RVQWtqb1F6aTdWU2ZOaGVTMzhET1JY?=
 =?utf-8?B?NzhnMk1UdWJkazhYT0Y5Sk1ma3VabHovT21vUGRzMmNTRGlPZXltcXYvaFZU?=
 =?utf-8?B?MEZDTnhkMEdmeFZRVlowUlZxZkpvcnJXOVp3aFBqNGxZRDZKT2lnRXE2ZzI5?=
 =?utf-8?B?QW9RU0s2d0pRQU1HcTg1dGducGUvSEsrR0R0ci95cnN4Mk1zTVNvOGZ0Zm9m?=
 =?utf-8?B?VCsveGpxVzVuaCtaZkpnN3oxTUZKM3B2cVFWeDZ2UkdXd2o1dUQ0QTJPTmxx?=
 =?utf-8?B?dTY5VWhSSmZrYlhrcUlmQWNoZ1lLOWJOSElZMmZJZ1R3MVpDcXZRVmFjY3JX?=
 =?utf-8?B?ODAvcjhQaG83STFjN1AxUVBRV1FXQTRIOWg5dEJnTXhzNDUxVVhLTDZJSnJ2?=
 =?utf-8?Q?W0st68oAW3E=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Dec 2024 21:44:55.1823
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 80dab4b0-02fd-4f58-4f35-08dd291b3306
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9397

From: Alejandro Lucero <alucerop@amd.com>

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

Alejandro Lucero (27):
  cxl: add type2 device basic support
  sfc: add cxl support using new CXL API
  cxl: add capabilities field to cxl_dev_state and cxl_port
  cxl/pci: add check for validating capabilities
  cxl: move pci generic code
  cxl: add function for type2 cxl regs setup
  sfc: use cxl api for regs setup and checking
  cxl: add functions for resource request/release by a driver
  sfc: request cxl ram resource
  resource: harden resource_contains
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
  cxl: add region flag for precluding a device memory to be used for dax
  sfc: create cxl region
  cxl: add function for obtaining region range
  sfc: update MCDI protocol headers
  sfc: support pio mapping based on cxl

 drivers/cxl/core/cdat.c               |     3 +
 drivers/cxl/core/hdm.c                |   153 +-
 drivers/cxl/core/memdev.c             |   110 +-
 drivers/cxl/core/pci.c                |   141 +
 drivers/cxl/core/port.c               |    11 +-
 drivers/cxl/core/region.c             |   422 +-
 drivers/cxl/core/regs.c               |    32 +-
 drivers/cxl/cxl.h                     |    16 +-
 drivers/cxl/cxlmem.h                  |     7 +-
 drivers/cxl/cxlpci.h                  |    19 +-
 drivers/cxl/mem.c                     |    25 +-
 drivers/cxl/pci.c                     |   112 +-
 drivers/cxl/port.c                    |     5 +-
 drivers/net/ethernet/sfc/Kconfig      |     7 +
 drivers/net/ethernet/sfc/Makefile     |     1 +
 drivers/net/ethernet/sfc/ef10.c       |    50 +-
 drivers/net/ethernet/sfc/efx.c        |    23 +-
 drivers/net/ethernet/sfc/efx_cxl.c    |   183 +
 drivers/net/ethernet/sfc/efx_cxl.h    |    34 +
 drivers/net/ethernet/sfc/mcdi_pcol.h  | 13645 +++++++++---------------
 drivers/net/ethernet/sfc/net_driver.h |    12 +
 drivers/net/ethernet/sfc/nic.h        |     3 +
 include/cxl/cxl.h                     |    73 +
 include/cxl/pci.h                     |    23 +
 include/linux/ioport.h                |     2 +
 25 files changed, 6120 insertions(+), 8992 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
prerequisite-patch-id: 91b580e38dc5d1ef2eb4175507d7d3d1fb438958
-- 
2.17.1



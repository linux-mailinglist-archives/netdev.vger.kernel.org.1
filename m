Return-Path: <netdev+bounces-148158-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6450A9E0984
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 18:13:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C30281BBF
	for <lists+netdev@lfdr.de>; Mon,  2 Dec 2024 17:13:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEC471DA636;
	Mon,  2 Dec 2024 17:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bE1pXQt6"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2070.outbound.protection.outlook.com [40.107.243.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76ED1DAC89;
	Mon,  2 Dec 2024 17:12:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733159561; cv=fail; b=KKeF+5gWrRUdxrb9gErqTlvWQbw8tp9nSuftjUR5OCqWgFxlh51NF+dzdANy94H+IfoaaWhzyLOqFnAHOvtdseWBppaf0KwsDAdr6Zi3FYl6RB4Xe1i/JAa3v9ROFvNRxHxXaqH6m3SKGUYlGh3TRpsgNaaB6/fub+jE1F6iSrw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733159561; c=relaxed/simple;
	bh=tthwOjhpIo7XVNZn9ngiacJLGqpp8GtEyPHcybjkF1s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IsK6ecv2jvez5o8Q/FOMsrNp/qG2zNb/Ec2nvP32D6NBND1yDVFXLzVLI0PrYMFlxaTXZmTmY+8kYbwM4g2bSeS6Kpl/SsBRJSTAJqRkugFcIF4DaniBq0zSw5R7f3+rlveefzBye01cTKFJJzeEVZ4Z/LqVFg4RNIY5/VJ0s/o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bE1pXQt6; arc=fail smtp.client-ip=40.107.243.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KJGgO0DYuKLBpMunrG/KnepBluBqEx4P/vT9ZLM+a/B4lTVJvTVuZTb3qfHAko/FpeFdDhTZSg9DfHiU4ftMNeHwGMYOM9mC+mGUxmcAkA8oJMTNg2avtTjUfC4DtTtmFtkfT28HCmpbFd2rwh6glBlHGQjx85uniF34q4Px5YrM7n926vt9E9i2fkOrmxQLzevc2tYdy9t6BZtc6uT+AcdiojDSRM0EVeuP02dG/AbK8ZNvQAViT+lh2w2Lhsf7OKYEDMcX43KDvmMn5locMU2Yedn2+Z4Xl8jby2bQTLgsoZRaq/sc+gy0RQqBkGdLduMZ8DNWRrXUZEl61HYTxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=es/aJyytJScX4nnhU/VA11Iw9+tojWPO/K/qSP26Aa8=;
 b=QDIQW4xZZLx90fgyeB6HR/8uElUjBIWiEKd7plB9y7oSjD8qDlh60yzi/NyUpceuV+50/ivFXqnXGpDWvsMRQapTc5MQO9Sgt0M2Oq9vK2b/AkGcX21e+Bb0i1dZ3Fma6/4sasfsn0ZDVjGKQ4q8pYNMHTeBWR4QGuwxhcRRdYJOesdkABRFDW36QhIqDs83cfdxqL/E5PqMeQTeSXrYE5l/8bX+460thgVt2vuv0UtjDoU5J1I2//zgf8SbIkbjfmXJSqmPQhDRmDBkw88fHk3K2/p/VAv2hD/J/BgkaR9YkcfQNf6rYiwH2oRidP0hOfUmoCZndAhOpAIIhTFy2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=es/aJyytJScX4nnhU/VA11Iw9+tojWPO/K/qSP26Aa8=;
 b=bE1pXQt6hsMTaTFZxRUdZDe8RfIYfhXb6WJp6EjVwkDv+1bISQpB+PelhrxGze9Pz9j+1hofKL9Gn1FnqOGQGMBTMkWISpI6iGg2yH3vGSg1QR8WK71Bqc57txFIMg6M5r/aG/sNousQgROfAVjUGTXFwDOyZmnoyVHh/Cg6AZA=
Received: from BN0PR07CA0017.namprd07.prod.outlook.com (2603:10b6:408:141::31)
 by LV2PR12MB5870.namprd12.prod.outlook.com (2603:10b6:408:175::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8207.17; Mon, 2 Dec
 2024 17:12:33 +0000
Received: from BN2PEPF000044A6.namprd04.prod.outlook.com
 (2603:10b6:408:141:cafe::2e) by BN0PR07CA0017.outlook.office365.com
 (2603:10b6:408:141::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8207.17 via Frontend Transport; Mon,
 2 Dec 2024 17:12:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BN2PEPF000044A6.mail.protection.outlook.com (10.167.243.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 2 Dec 2024 17:12:33 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 2 Dec
 2024 11:12:32 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 2 Dec 2024 11:12:31 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v6 00/28] cxl: add type2 device basic support
Date: Mon, 2 Dec 2024 17:11:54 +0000
Message-ID: <20241202171222.62595-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A6:EE_|LV2PR12MB5870:EE_
X-MS-Office365-Filtering-Correlation-Id: 36bce2ef-d034-4be6-dbcd-08dd12f482dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N3ZuVmlZZU1LVGprVTd3Z1Q1L3paMFBDcnZ0cUlNaE81Zms4OEdkeEdLZG9t?=
 =?utf-8?B?T3VHUzBzSnhkT0FQUEs4N01NQnlYbmhOeEpWN0VaaW5yOWZwUlRHZWVrTFgr?=
 =?utf-8?B?MXJjejl4U1VyOUxXU211eEFiNmxPN2JiVVJXLzhrYWdHSzVrNitYR28rWGpq?=
 =?utf-8?B?Q3hHVytVdGJIRkY1WFRVRUNSeE4ydEZXTkJQM1dUdXJXK2MzYkxSQ2xzM1Z3?=
 =?utf-8?B?MnhYMk9nM21ySHkraTNKR0JEQmNTblZ6Y2o1REh2NGJxMHZzUnFNRzBuei9R?=
 =?utf-8?B?eTlHaWI3WjRDZWNhRlJ2YXg0a1J6bTRpRHRUclZmWFRBck1LNi9rQnJDcXQx?=
 =?utf-8?B?a2JtRW8rZnRTazR2eFJsZnVwQzFiMGdhNzJLcXZvUlBpVml2RXR5VHMxYmNt?=
 =?utf-8?B?c2o3WmYvRjMxbWI0Qis4Qi9xZmcrS2RiK0kxS0ZHSzkvTHRhN204Q3NZalRv?=
 =?utf-8?B?RGJPRzhaWDUzdGRCL3FURXEwRzJVbTdxWVlzTk9xVXVZSjloVmx5M2QzVDc5?=
 =?utf-8?B?ZU04VldYOWhjbUwvWlRmMkhzVFpnMEtHWjBkWmxrc1pYdnFlWWhRT2xtQzZ0?=
 =?utf-8?B?RVlzemJ6dThYd0xnN1BHY09wRG44VnYyY0RMOXVtdFRibmh4a3RzVDZJZWhw?=
 =?utf-8?B?MkZSZFNwRVpJVlBsRHg1NkttbkxMVXFzcXRjd3BwMFdYQXJ1Zzh4US81MllS?=
 =?utf-8?B?ZWZBcjh2dkVzSWtlMUFmcVFuVW4vL2dJclVTa0xodmp1VzRYVkl5M0xRdVVp?=
 =?utf-8?B?RWVaUy9nbWpKMGdKRy9NT2llQmpVSml2MkN6RnR1a3diTEgrMlZjbW5GUC9Y?=
 =?utf-8?B?SlhWbnJHZ0pXZU5zNUlNM0ZvMTBWd0RCdzRXMHNJYUM3WElJQThwTnUxaDlH?=
 =?utf-8?B?SGs2aEhqRGdjSEU4QUJBMXNteFgvWC9yYzExTEhMcnVGRGJxcElYcCtVSTRn?=
 =?utf-8?B?emNXOWhtbTh0OFN6ZG1rY1p3dmZmRUZSSFNZYTlnd0lHL1ZBakhRQjFkQnhW?=
 =?utf-8?B?S2dGYUdNUGhPT1crSmxUdEQyVzErR3V2REZ1UHBjT2k2NmZpNG81T2RqUVVj?=
 =?utf-8?B?YVV0dTYyNFhOQjJoODhlTEVCOXljU1dWRjJLTVRuTXhPeVdCdjJNL2xISS91?=
 =?utf-8?B?ak00bFBUajJrNlFiN3RqaWNOdnpVZ28vYmkvZHdwdE1jWGtib0NqMXhzMjRR?=
 =?utf-8?B?R1drWnJEUGNieVZ0MEg5d2JkSFc4SEI5S1ZvN1A5TTZMVUxLSlBhSHhHbkwv?=
 =?utf-8?B?Q3kvQVh5b09TYTZEVG0yengzbXBzbFc2VkdTMlppaWJad093bmhVU3ZOMEdD?=
 =?utf-8?B?MjJ3dUFjeG5IdmZDdjd3NEpGcVdOTHBBcDh5ZHc1azVBY2R4eEd1eDgycUxF?=
 =?utf-8?B?NWltVUF5ZXdBWjhpeFpVaU1pMGY4SENMWmJjWXl6bEdUbE03VndUZW85QTBi?=
 =?utf-8?B?WlVDK0hWM1FlQWtzVm9PVlYzeHJ1ZkQwQVZEQVlhalZtbWIwaURFWkFtVXB3?=
 =?utf-8?B?TkJyYk9UWlI1MEF2UmQyL3NGZ21vKzg5dVhpNXJ4ODdmbDhrbm1VeENackdS?=
 =?utf-8?B?WVAva2gzb3JnODlBWFR3cHlQVkJUWVpCU3laOU5LcGZMUmVQYnRYOGQ5WktT?=
 =?utf-8?B?YXF5MGpSdm1wYytERlJrU2R1QUNMblR3S2ZHaGVKWFRLeFc2VDdkK3kydW43?=
 =?utf-8?B?RmpMLzVSb3lRMjlVNklidTl4SStrRU1YSkRpTEVQeG1tV1NrSjg0VWhrV2Zr?=
 =?utf-8?B?c2dNNWdYTzR2amNiSndydGVpVDRqbFk3VUFXZEFDc2VsS3lhRC94cWpnclFC?=
 =?utf-8?B?S2hYcFFkKzJCaVBBMy91bzNvaDZyYnRaUlBuemhWeTkyNURxdkZ1dTNUNGlW?=
 =?utf-8?B?bW1jSDlrN0pVVXlxaUtMZThXaklncDlIMlBQTlltNmdLVC9IZW5BaCt4cWJt?=
 =?utf-8?Q?adaVingTRi8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2024 17:12:33.2595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36bce2ef-d034-4be6-dbcd-08dd12f482dd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5870

From: Alejandro Lucero <alucerop@amd.com>

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


Alejandro Lucero (28):
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
  cxl: add region flag for precluding a device memory to be used for dax
  sfc: specify no dax when cxl region is created
  cxl: add function for obtaining region range
  sfc: update MCDI protocol headers
  sfc: support pio mapping based on cxl

 drivers/cxl/core/cdat.c               |     3 +
 drivers/cxl/core/hdm.c                |   162 +-
 drivers/cxl/core/memdev.c             |   123 +-
 drivers/cxl/core/pci.c                |   126 +
 drivers/cxl/core/port.c               |    11 +-
 drivers/cxl/core/region.c             |   414 +-
 drivers/cxl/core/regs.c               |    30 +-
 drivers/cxl/cxl.h                     |    16 +-
 drivers/cxl/cxlmem.h                  |     5 +
 drivers/cxl/cxlpci.h                  |    19 +-
 drivers/cxl/mem.c                     |    25 +-
 drivers/cxl/pci.c                     |   112 +-
 drivers/cxl/port.c                    |     5 +-
 drivers/net/ethernet/sfc/Kconfig      |     7 +
 drivers/net/ethernet/sfc/Makefile     |     1 +
 drivers/net/ethernet/sfc/ef10.c       |    49 +-
 drivers/net/ethernet/sfc/efx.c        |    24 +-
 drivers/net/ethernet/sfc/efx_cxl.c    |   181 +
 drivers/net/ethernet/sfc/efx_cxl.h    |    28 +
 drivers/net/ethernet/sfc/mcdi_pcol.h  | 13645 +++++++++---------------
 drivers/net/ethernet/sfc/net_driver.h |    12 +
 drivers/net/ethernet/sfc/nic.h        |     3 +
 include/cxl/cxl.h                     |    69 +
 include/cxl/pci.h                     |    23 +
 24 files changed, 6098 insertions(+), 8995 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: e70140ba0d2b1a30467d4af6bcfe761327b9ec95
-- 
2.17.1



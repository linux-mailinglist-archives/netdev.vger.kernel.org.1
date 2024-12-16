Return-Path: <netdev+bounces-152277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B5F719F3577
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 17:12:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 42A98188AFF1
	for <lists+netdev@lfdr.de>; Mon, 16 Dec 2024 16:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA65A200BB4;
	Mon, 16 Dec 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="GCFwptRJ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2063.outbound.protection.outlook.com [40.107.92.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C124F13B2AF;
	Mon, 16 Dec 2024 16:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734365460; cv=fail; b=REHpZBClNqI97tnWlF6UsBI/EZ+Ch8d4VGUMF2CAb3LpwDx9TtMV8LZ1gZlN3EpyzoPlUjso1+xAzeb91N40PKPv0E+6+w0vQW88rUrGRfMjhDDpa/vKGic0lU6aI5f3lJTouF252Hqnu5jco1i3fLIhvC3y5ql7qkSUKZw/DpU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734365460; c=relaxed/simple;
	bh=EnkXy4OFdCjfRNVXcO7fA2ZwUswN71Q6V0xKc0FmFXw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BO3I6DNxc0ndywBGUlmb9XJ4j2uOeeBwHR0ejXSfUmbsiK2WKEtSMpp0b3pBh4ieq41Eua63prKYL4ttWA4o0spRoEliSzgwf8H/0de2DavxinYMHOTOgI4Rkr9kzOA1xHLktGm/qNgCXgaoXGhVpz2bOsZ1Kr9kLvFsEMwjty0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GCFwptRJ; arc=fail smtp.client-ip=40.107.92.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOcb2TqF0j+6GpGpeeFu8YUuzznkqvhd9H+wm7bfNLcSH3yfZbpAeDCkmwH0I8SGC3OiNWI0SYoQmFivdtq+8C/nD+2lKFDIwmmm8U1KdOILu+3CQzPYe3D3P9XQ/2vwupvuZqG/yXVQf4mPJHsQjb3KFn7SwHYX+LGboBI/TSGzwFIXhPr6/j9sMrijnfcpgKNL809PFQiaTD8qx3TePMb3vYV9kOUYPdm2SFmQlcGhMqpB5vnedVB3mDA4m5nUwWCtQVjJuy9wH7TQwLnDfW7bBoa6R9nGFk0cwxs63FzSYNLzA93iN3xdwhf8k5KvDWFS8mJEIJBo8Zz2YFajyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OLUIPFY8cjZZ0pCcUHo7iDs4QvvhL5a30sw0DX5K5rg=;
 b=Fq9aphqnDbVxCWyQblsknSeiyN+NsrldZAD0lW45CuFumwW0NBHgQWbJeUu/IuAYHckmNo3OP9ru1xa6Pd55H+A+5iG8JU+R9OeE4/VLnmXjWnZc2/Zb6q/pgdqnBn1oAP/ZwfIDngWkW08XqInQ3fKrbddFLySPK92k65b0NggfLgdXaJUCfZoxGD7n7QJgkZrbLNMjXeM3BRGBEF837TEb+I5k83OiOkkSzSGo3b/K2hKgdi3WfCG+nfuO0G2DIsqpx44gnzDUtdysg2bsuLE50mMbv1p6X5+yUOYV+OFyTxTl4lHcOol6jMeRf2rxirNdHSXau6BffBpyfBXaBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OLUIPFY8cjZZ0pCcUHo7iDs4QvvhL5a30sw0DX5K5rg=;
 b=GCFwptRJND4JKnN6SratzxDRK+GM0JU+opTqq9t2IttsalHT4+hg988ooe/IyfMYFF7kR8XD859JXDr1FX01s3KbJ2l9482UaM9co0FjqEZnYyB75lO8CbOvpSc0zPN1i3C0AG4u99tWwLJIffCPdCju7s0p1SbpWRT+SLF1G/c=
Received: from CH2PR15CA0023.namprd15.prod.outlook.com (2603:10b6:610:51::33)
 by MW4PR12MB7311.namprd12.prod.outlook.com (2603:10b6:303:227::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8251.21; Mon, 16 Dec
 2024 16:10:53 +0000
Received: from CH1PEPF0000AD77.namprd04.prod.outlook.com
 (2603:10b6:610:51:cafe::3c) by CH2PR15CA0023.outlook.office365.com
 (2603:10b6:610:51::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8251.20 via Frontend Transport; Mon,
 16 Dec 2024 16:10:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CH1PEPF0000AD77.mail.protection.outlook.com (10.167.244.55) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8251.15 via Frontend Transport; Mon, 16 Dec 2024 16:10:53 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:10:52 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Dec
 2024 10:10:51 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 16 Dec 2024 10:10:50 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v8 00/27] cxl: add type2 device basic support
Date: Mon, 16 Dec 2024 16:10:15 +0000
Message-ID: <20241216161042.42108-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD77:EE_|MW4PR12MB7311:EE_
X-MS-Office365-Filtering-Correlation-Id: c4a5a0c7-2c58-4b76-3ede-08dd1dec3729
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?QUIyQzd5QUljYWhYalFaSGFIdnZGZExBeGorUC92eEF0T05HYjNiNnZTN3ZD?=
 =?utf-8?B?YmNUVEI0QkVLQ3VPcjlyZUp4WHV2VzBNRHcrZ3dlYy9vOW1KNVNERjFFSDhw?=
 =?utf-8?B?K3lZSGtXTTZiMHd5MHNpRHRTc2xqNVVNUEZNVGV4cVJlaXprMmYrSUEyTXBO?=
 =?utf-8?B?T0taUkhUNlNucUVGcDNubFVBRWFhZjV5enZMWHQrMkxxWDBpVmR4d2dhaExZ?=
 =?utf-8?B?VmZNT3lDVnFYUGVlQUEva0pHMCtYWFdYRitycytxOWNIZzh3OTZ3elJxV3VN?=
 =?utf-8?B?djNCOXBkd1ZZRnI4M2REMlBWeEU5Y2NTTHk1ZzhCOWNGWmVneXFXMllieXFP?=
 =?utf-8?B?UFVXeFVLL2FjODBDRVIrSWVkOGVKemNvVUFacDd0SU9TQWxLQTlPTVlncU5O?=
 =?utf-8?B?L2dtcUR3R04wcEVvNmNzWGdOV3hjREVzWElhSTVBeFpWYnZoSVZPMEYzTTJF?=
 =?utf-8?B?dS9qbXVFQnlGSnJjT1Z5dlVuRWdjbzFRcnA5SFpaZEhNZFFHeDhJQ016bUxT?=
 =?utf-8?B?OEtwZjAzdzNVenRFei91SGpMbjdkOTVKZC9MRnZSN3NiWjlOODZwNllQNlFz?=
 =?utf-8?B?dVBpL3JmUm0ybkFLVUMraDd5bmtVVkpWMnBteTdhVlliTll0WTNHalY2VmFn?=
 =?utf-8?B?cHFCWUhwbVY1YzhlbkF0QnpCZnErSmI5VVhTVGNZcFRRd212Ui9yeE13WVBr?=
 =?utf-8?B?YUZ1dGJidXZ4MTZnek5YZ3ZQYkRTNXNIcGtyMlpxQVkxL1ZUY1ExZUFsU0Fv?=
 =?utf-8?B?aWxEeGIxaE5KU2gzczhhQUt6TjQ4MVJ4S2hxK3ZwUEtOeE1HVHNjZENBdzdm?=
 =?utf-8?B?T0VVMkMzU3V2Ti84QmlCWXVmbmZtV1gxbHlhUE50amRFTzhVRXRYVWdoa0pi?=
 =?utf-8?B?QVlSMlhVNnJ0cjhDVUIzbXo4S1ZWZTZTWW5NWjM0bUFHL0JDTHF4K1JaOWlP?=
 =?utf-8?B?dXpHMVdzNVZFazFMQkNSV0h1a2xKRk9VMlIyY1ZDRFNRTFlGZEIrbk5GcUpY?=
 =?utf-8?B?c1gvd2ZJZG9iWFl6SjI0bmZScVRud3V3SmFKOXZDekJXSlpBZDgweCt3UWdn?=
 =?utf-8?B?dHBSTlowS1dKYVhwMkF2bmZmeWNZQ2JrUXdLYUE1MkNvc0d3UnNyb0lZOWxk?=
 =?utf-8?B?NTdRVEgvTU1WTmN1YVNZZXdrSjJEUThWU294c05JMGtFTHZzenl0Z3kyK3hn?=
 =?utf-8?B?eW5sSHUwKzVNa3dHVEQrT0lDL2Y1L1hGMGFiRlZuQVhJN2lwYW05U05BSThV?=
 =?utf-8?B?RzNlTVdYWVZzR2RxelFESElHM3AvbWdIR01yeTM2R1hQUDNJOGZFQzRrdDBX?=
 =?utf-8?B?Sjl0NGRCYzZVdXRQTnpZYnRkNnNDWkZQUkFraXJlRDZtbUhvN1huUUFPNVZu?=
 =?utf-8?B?M2RoR1F4RjhFbDVQNXRVc0NwQ0ZCajc1azdKOTk5dmxiZ2FDMUR6Z25CbVZ6?=
 =?utf-8?B?eTBwaXZkYkFrMGszQTFDNm9jOHVCNTkxYUE2dUFMcEdOeVkxdkVnTVIyUmdl?=
 =?utf-8?B?VFV2U3RNdGdUS0w1ekUrSDRWdnNLTktlWElUc09WaS9GanVJWDZrd1ozSmpr?=
 =?utf-8?B?cmFFSjJNakc0cWVhQkY4WmVhLzlaWTg1SVRXRVp5eEhnakVIU0tOT2MvSEdZ?=
 =?utf-8?B?N2RiOVZkdkR1dms3YU05d1htQ1J2R29SSUpYS1RSTys3NXE4OUVBUWlpNEtr?=
 =?utf-8?B?aW9mSmhNNmVOSE9VTGhZQkh6T09DN09xeGFCR1l1ajk5M3NJNE41OVZQWXY3?=
 =?utf-8?B?bTEwWUF6d1dnREdCdVZxQjYrZXFadnZSY2ZFU1dEa1RIUGcvRk9Nem1laGdn?=
 =?utf-8?B?R3B6ZVBIYjhOejJvWHZ5VGxWbzdONHUzMDBTNWlUZm9pL1hFdFlDYjlYeVpN?=
 =?utf-8?B?WndYcTFRbGMyT2g5QzBEK2dCQlpKNldjTUU0QnZzZGc0YXZkeXYrRWl4ODY0?=
 =?utf-8?Q?La5BUzZCGLQsNrClmtXGb8R0Ta1HadY6?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2024 16:10:53.0478
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c4a5a0c7-2c58-4b76-3ede-08dd1dec3729
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000AD77.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7311

From: Alejandro Lucero <alucerop@amd.com>

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
 drivers/cxl/core/hdm.c                |   154 +-
 drivers/cxl/core/memdev.c             |   116 +-
 drivers/cxl/core/pci.c                |   126 +
 drivers/cxl/core/port.c               |    11 +-
 drivers/cxl/core/region.c             |   424 +-
 drivers/cxl/core/regs.c               |    32 +-
 drivers/cxl/cxl.h                     |    16 +-
 drivers/cxl/cxlmem.h                  |     5 +
 drivers/cxl/cxlpci.h                  |    19 +-
 drivers/cxl/mem.c                     |    25 +-
 drivers/cxl/pci.c                     |   112 +-
 drivers/cxl/port.c                    |     5 +-
 drivers/net/ethernet/sfc/Kconfig      |     7 +
 drivers/net/ethernet/sfc/Makefile     |     1 +
 drivers/net/ethernet/sfc/ef10.c       |    50 +-
 drivers/net/ethernet/sfc/efx.c        |    23 +-
 drivers/net/ethernet/sfc/efx_cxl.c    |   182 +
 drivers/net/ethernet/sfc/efx_cxl.h    |    28 +
 drivers/net/ethernet/sfc/mcdi_pcol.h  | 13645 +++++++++---------------
 drivers/net/ethernet/sfc/net_driver.h |    12 +
 drivers/net/ethernet/sfc/nic.h        |     3 +
 include/cxl/cxl.h                     |    69 +
 include/cxl/pci.h                     |    23 +
 include/linux/ioport.h                |     2 +
 25 files changed, 6100 insertions(+), 8993 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
-- 
2.17.1



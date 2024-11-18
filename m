Return-Path: <netdev+bounces-145937-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03E19D1590
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 17:44:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94690B21F7F
	for <lists+netdev@lfdr.de>; Mon, 18 Nov 2024 16:44:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB101BD9D0;
	Mon, 18 Nov 2024 16:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Y+WuHOcb"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2045.outbound.protection.outlook.com [40.107.244.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15E521B21A0;
	Mon, 18 Nov 2024 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731948289; cv=fail; b=rmREVtairBU928dRHa89LHCYLWp8iXX0LGiWHozs/71zOfe2q9+2mO8Pm1HZYB2DmbhqhJUYBjYnVEkEmJEc054xCqFFtVBUbpFBS9oJPkfsat/brYu3UZ0/bUEMUfhJoxIlXiLPG9HMfApVldxYN7FZxRUvM9k7cN5V15j9OB0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731948289; c=relaxed/simple;
	bh=VKgQGecVFTuUEOQxBBhDHN1fDy/bddm6/S6MvOWtx+8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SMSxhXhtWS44uKv5N9qn9XnNyUoxQucjnK2GtQJHok2RhhytFgAr4hq3G2ve3U9xr3VYtaCX8VAnt95+1s59jiI+y+ywjfTN05JQ0M0MRJi64+ksoz4QX2dLfROjHku/BJn2U8bTwhADQx8I74wY5THYk7w1yMTeEX1TUICsYMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Y+WuHOcb; arc=fail smtp.client-ip=40.107.244.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aTxuR0oxT5zWqxlz0N+NCwhEbNE+GUJV0rItmhxfpKjgB51xZ6kvTDEtkfAikVi8BXCXlTKbc3wqHLrcgc+4dcEc5usaRuuZPdNlRL7HLGiKqNcLMi01UV9zfop/8fHCZHB1orKJ+Ha53YobODD8sRiq8KHw8pTlZiqFaYbB01+3IhAEScOKW1Q18azeKN7GVe4Gf8vcIfqJTZCx7FvyYzlgZ1BjaBfbnd5oAioCMqwDSX5R5RehjKqDoj4FAVT63CgqHetTLP7/OxyOVo9P5CpUsbEzkzR6zFZm9Nzooj2OboX1xmEysXRYcsbogsW4pvN2m7qy1icqAXiDNhUHOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vl8ioyh1KgdbzOpfUw95fWBZVBJ3GJXFvSW3lmy0zmg=;
 b=N3+qgv3ns8OhEz8GkoATl6Fev6nYfodfjVrfzNWUgf2ZeDY8k+aiyb0NyRkwEgsaYwkyWU+r6gvxSocBQq0wKmFGqoyyE563AUKROd75oK80PhT3C3d1G8o6OYJC8blbKMNFz8trVNKGh/+LERdIeJpLvviQCRJPYA8dzV6xhwVfACOKMbfrZzWHRmkwXN0W26FU986zuRrjhSkhI+libP2HtEEU3G+I3Qy5AerN/Z4ByzPMMIWEBP9AL2DjecD1cIbxpd131bcoodUsHksYtutxxxlVkYfeVgsj5D3DEKAyjcap3eljAz2z89aVnLcNDc++Wr9vrhKhV2fy4BF10g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.12) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vl8ioyh1KgdbzOpfUw95fWBZVBJ3GJXFvSW3lmy0zmg=;
 b=Y+WuHOcb+OiK6l7M8JnKjHwNlPCp8GKRE1MBu8NpxdJ3MnN3Ryp9tmvHWaTZHVu67/KhWYJEiWFl0HpVDzuxSanUjWxVyycVApZSxJx5czwRYsbddfK689qGJc4Rw8ctisSx1gxckUVn+bP/AZBVYl6MSbbAgq1DwATygBULuYA=
Received: from BN9PR03CA0659.namprd03.prod.outlook.com (2603:10b6:408:13b::34)
 by DS0PR12MB8197.namprd12.prod.outlook.com (2603:10b6:8:f1::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23; Mon, 18 Nov
 2024 16:44:45 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:408:13b:cafe::e5) by BN9PR03CA0659.outlook.office365.com
 (2603:10b6:408:13b::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.23 via Frontend
 Transport; Mon, 18 Nov 2024 16:44:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.12)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.12 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.12; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.12) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8158.14 via Frontend Transport; Mon, 18 Nov 2024 16:44:44 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:44 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 18 Nov
 2024 10:44:43 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 18 Nov 2024 10:44:42 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alejandro.lucero-palau@amd.com>
Subject: [PATCH v5 00/27] cxl: add type2 device basic support
Date: Mon, 18 Nov 2024 16:44:07 +0000
Message-ID: <20241118164434.7551-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|DS0PR12MB8197:EE_
X-MS-Office365-Filtering-Correlation-Id: b037f004-d9c2-4e8a-4de8-08dd07f04e88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y2xvRFRLWnBJYlJIL1Eyb0FacVNjcHJ3VnJrb0FEVktsTnlueDVNREhDZU90?=
 =?utf-8?B?clhXUXRFUHN0bjJ2MlZEQ1JSYlExOGMrbTJKQ1NvMU04eFNwT0hyYnBKNzZi?=
 =?utf-8?B?bWF3UjZ6YWM0OTAwZ3B4eHcrNnZqYmpZZmY0UHZmT2RLNmh0c09WZlN0NElK?=
 =?utf-8?B?UDY5NHZxOFo3bWZ4bzU0TWpJanFRdXYza0ZPcFllaWtCbThFOUdrTzRZY3Zy?=
 =?utf-8?B?VXR1RG03anN2NzdoR0VaZkJoM0U0OTZWYW5PSDhicUVKWVJhdFh0TkxUME40?=
 =?utf-8?B?TzRHVGpZQUxUOXdXallXd0FNbEl5ZG9RV3czb25aQWlyVlpmbGNQbDJtZEtl?=
 =?utf-8?B?T2R4YXhJT2ZtOFZrNVM5cXF4TXZKOTRPY3N4RG5rRCsrSjdBdW9mdEhiMmQr?=
 =?utf-8?B?dnBlbUFTSEx4eXB0RE9rWWFqWmRzRExQQXN3MGc0VmNFZW43d0h3UXVrUC9C?=
 =?utf-8?B?ekZKS2lmRzQ5L3NZM09jaDNwQ3JtUWNDK3FjUm1MR0ZsdDArUXNCWjF1Zy81?=
 =?utf-8?B?UUN6L1UwcTBTaE1TcHI5dm8yN3h0cnRJQU1WU3dVZm12M3pheVhvSFRMVkRv?=
 =?utf-8?B?QXJyQWNpTWx3RHlXNlhKS0FsdGJ1SWNjN0RNWlR2NFJpbTl1ZnBqM28vVGh6?=
 =?utf-8?B?L0ZSZ0Q2aWtTSjkzOWJNbENOU1pTT3g0b0pKQjRiRzR2VEdRUVY4aVlpYVhZ?=
 =?utf-8?B?YSswK3IwK0NpN3hadE9RUEV1dDdjSUtXZjdaeEd4ZFJlRU9laEczYkUxd1RE?=
 =?utf-8?B?Y1JzZzRQTzYwSFdlb01QbzI1eG5YbFZKbEVZQlJlMCsxdk52bDc0NUlhNHVy?=
 =?utf-8?B?QXZoZ0xQTFFTNXRyWmxPOFBWUS9rUStvdDJjUkh0QU1zWGZPSitKNVk3TGZQ?=
 =?utf-8?B?Z2VBUHUrVGJqc2E3SFBseU9FVGk2SlVSK3VxeWx0UTgwUjRrTkFWeEhtS3Bv?=
 =?utf-8?B?Q2dwM1NuaXp4ZTREeWYvVVRnTGM3MXNRWGU5S1Rob0pWSlh6alJESGhLK0dR?=
 =?utf-8?B?dzk3ME9RWVBPVExjVjltcW5BbEZJWGhUOEtvK05aZWcwOGV0T2NpWVEwelpC?=
 =?utf-8?B?dng4b2dYb25LR2pxSlZuckg2aEEzMFgyMndlaEs2WTZSaVBrL1l3TDFwMnFL?=
 =?utf-8?B?SWJ4eUpsV2ZqMTdTNTZlbm1NNExkTWszazhjbnhQRVA4dmVvQmt1VlVIMUpq?=
 =?utf-8?B?WDhaejRuUHg5Q0VheWk4Mk50N0pFQWQ4eVVxT2s1NEdXSEtKNXNzd2NsaWtj?=
 =?utf-8?B?U2dqZDIzOGlKQkxkK1ZTMVA1cFlCUUM1NjNic1Q2R2dSOFdlclk3VCtUT1lZ?=
 =?utf-8?B?NzFSUlVReFZSZTdxR0t4RWNKbHdhbW1Gb2NOTUtxYW40dENpa2VqRDVFekhX?=
 =?utf-8?B?N1NoSHpxSGFoNzVIQ3VBZkxFQjBWbFNtNGV0dnlsenN6WVJmdklkczZRRlRx?=
 =?utf-8?B?N1ZZUWxxamZzSWUwZGhSbHhEUExIV05OVEsvdWt4QzlYdHRZbmIvZjJRSTBT?=
 =?utf-8?B?MVNtc3RBK1Q2U2pYY2tFRHhjd0hZMlVCeTZVaGVhKy95eUNCd1RCb0lydTU1?=
 =?utf-8?B?elQzSjVvMjl5dEN0UkJKck0wZUZBRCtub0VUdEtqSGFvV0p4bisrQWlZMWph?=
 =?utf-8?B?dG1jWG5aSWd4cTVtdUF6bU9TeFRQWUt0NTkybTJLbUU0dnZMR24rSWNsVnAv?=
 =?utf-8?B?SWpvMGswM0ZYS2lCUVZVMFF2aVJiRXR4YmVNWjlSem84SlVLNnNGa0VReXVQ?=
 =?utf-8?B?aVBSbFU0YWV4d3VpZ09UNk1lc2wyZmtiTHhrQzlkU3NMVjFWUXE5N0M3TnFV?=
 =?utf-8?B?RTc1NlJqcWk3U3hQT2dML1RxamFjK1h1MGh6YzRCV2hLelYxMURKSzFIZ2ht?=
 =?utf-8?B?bEVhYS9vb1BQeWhZWUthNjM2YWhjUzRORmZUeVFXSmxzVXc9PQ==?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.12;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:atlvpn-bp.amd.com;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2024 16:44:44.6954
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b037f004-d9c2-4e8a-4de8-08dd07f04e88
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.12];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8197

From: Alejandro Lucero <alejandro.lucero-palau@amd.com>

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
  sfc: specify avoid dax when cxl region is created
  cxl: add function for obtaining params from a region
  sfc: support pio mapping based on cxl

 drivers/cxl/core/cdat.c               |   3 +
 drivers/cxl/core/hdm.c                | 160 ++++++++--
 drivers/cxl/core/memdev.c             | 123 +++++++-
 drivers/cxl/core/pci.c                | 132 ++++++++
 drivers/cxl/core/port.c               |  11 +-
 drivers/cxl/core/region.c             | 414 ++++++++++++++++++++++----
 drivers/cxl/core/regs.c               |  30 +-
 drivers/cxl/cxl.h                     |  17 +-
 drivers/cxl/cxlmem.h                  |   5 +
 drivers/cxl/cxlpci.h                  |  19 +-
 drivers/cxl/mem.c                     |  25 +-
 drivers/cxl/pci.c                     |  99 +++---
 drivers/cxl/port.c                    |   5 +-
 drivers/net/ethernet/sfc/Kconfig      |   7 +
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/ef10.c       |  49 ++-
 drivers/net/ethernet/sfc/efx.c        |  24 +-
 drivers/net/ethernet/sfc/efx_cxl.c    | 181 +++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  28 ++
 drivers/net/ethernet/sfc/mcdi_pcol.h  |  12 +
 drivers/net/ethernet/sfc/net_driver.h |  12 +
 drivers/net/ethernet/sfc/nic.h        |   3 +
 include/cxl/cxl.h                     |  82 +++++
 include/cxl/pci.h                     |  23 ++
 24 files changed, 1269 insertions(+), 196 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h

-- 
2.17.1



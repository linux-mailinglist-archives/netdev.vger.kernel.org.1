Return-Path: <netdev+bounces-126208-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EFD59700C8
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 10:19:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BCD58282441
	for <lists+netdev@lfdr.de>; Sat,  7 Sep 2024 08:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B9343ADE;
	Sat,  7 Sep 2024 08:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eGw9Xyuq"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2043.outbound.protection.outlook.com [40.107.236.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4261212E5B;
	Sat,  7 Sep 2024 08:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725697164; cv=fail; b=YQ95/P9CwHO4EX+kl1Tsj9gWqTlhBYaWOCB0B2TqZ92/pCgO9dibAvTOx1rwGtB8r9Ut4eCuJokrgGO9MaNvljBRUpWdLzlOMZnAGz6kD6lwjyu/crN+mBjB6MUC80ySeRgXtryoalk2TYbrWRub44O86jRzhexKSc9PLJHP5zc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725697164; c=relaxed/simple;
	bh=2iziT9OFvKai3jXO0V1nyBX03c6ny9BN5Gj53IWLsIg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Em7phcgmG++a/ARtciyN22o95TQ/VdYttWw5Vm4d0UMOV8EP2Q2hIte160Iq1aOPtSiVjoL8pug9ks8BBlEbjpoUXiYrf/gy0tHEY2dcOTSR63YRw/iYPZ864nUjvTbmICc4RLw//BMMZW6i3aeriWPsnyGsByOn6COVaZlOOMY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eGw9Xyuq; arc=fail smtp.client-ip=40.107.236.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l0c+h8KNlL2qPj7cwOcOQfxJO/OgR4BOaZGkJaSPtXAA3BCDMUuYW/PVZ/MP/ZhLz0yepvOrwTxXV8/ZSv4Lwh/m2uE4rERMPIDYPAQ5U/LqilH+Y63BWfzSPHx/frA7AWC5+pSpvo7XQzTc1kwG4OwtE7MgS8QH5bMKzogv484rJFe+bBEaYqgyj9TAvlB+yKD8VLKuA8vRW2+/ySAbqFRspU0xkw2ie/7bCdnOAt3zxuHLP2XdOWVwCDCuwb7QhBWOQ1IukEC+s4UU+5aAMnS2ReJ5ydJhEPyCNSpfGplGuOj8TonEFNmCIthXAeywMWLPvdzK63vU1PZM/BH2jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZnSAEkI3XpU3wGFgMeVisfAP3Ctv3N0UuIt/mcOYZI=;
 b=Jcas0TogV+0wkFnQk1MO/19tr9GLTneGQBeSD6P+fCYuraMHf7aDVxIy1JRkHlpFqK9M8X3KlRHU7pzUOrMUlevX2x+ftgY+jlW9JBb0TNbbDElzf6jxYba6WPxgD6vSFWhc6Ol9VPFrs6wRPfUxpqcXxZTdJdAoCe/QRBUutk9lfrOKVpXiPrAm1gbXqsTSmvFHtjVio3Wb2mf2vDoHpZ0TY9iyajDkIXi01OzCZTZrmhErJcNwOtO9towTcipCTo1/1IvUbd1GLLyxzG7ZXhpqOXVW1JhD/PdDS56Y0i1TIcZZaBXfCDYI5zzyHv0PIr2mEZdCM3QRB+2wYLDcGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZnSAEkI3XpU3wGFgMeVisfAP3Ctv3N0UuIt/mcOYZI=;
 b=eGw9XyuqDU9kZfaGRw5lOitluEymQttr+QUS8iBJfyCn185ULaOuQPyPGNkLSbEw+RCVogKuWIVt3DrWV7jktPzhvIxSmUug8Co84RCZyy5/DoagFjunFco5FKhtENYRh++p7yH3zLEqLdq/ZHcPwK7vPKKcEI0k9h98L+Uw7hw=
Received: from DM6PR02CA0097.namprd02.prod.outlook.com (2603:10b6:5:1f4::38)
 by IA1PR12MB6529.namprd12.prod.outlook.com (2603:10b6:208:3a6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.31; Sat, 7 Sep
 2024 08:19:17 +0000
Received: from DS1PEPF0001709D.namprd05.prod.outlook.com
 (2603:10b6:5:1f4:cafe::53) by DM6PR02CA0097.outlook.office365.com
 (2603:10b6:5:1f4::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7939.16 via Frontend
 Transport; Sat, 7 Sep 2024 08:19:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS1PEPF0001709D.mail.protection.outlook.com (10.167.18.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7918.13 via Frontend Transport; Sat, 7 Sep 2024 08:19:17 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Sat, 7 Sep
 2024 03:19:16 -0500
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Sat, 7 Sep 2024 03:19:15 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>
CC: Alejandro Lucero <alejandro.lucero-palau@amd.com>
Subject: [PATCH v3 00/20] cxl: add Type2 device support
Date: Sat, 7 Sep 2024 09:18:16 +0100
Message-ID: <20240907081836.5801-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF0001709D:EE_|IA1PR12MB6529:EE_
X-MS-Office365-Filtering-Correlation-Id: fefd8069-7806-44a0-d931-08dccf15c44b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ckdqYWtKY1JuTm9CTzhIcFc5QzJEb1lHTXdVbVQwa3psbEtZTDdMM1lOTjZy?=
 =?utf-8?B?OU9MYVg4dWNJbGJUYWU4YW5DWXloa3FjdVpjcElJczRhZ2gwWjV1YmU3YTRQ?=
 =?utf-8?B?UUNmZEY5RmNBUWJqd29jaTRneVRFMGt4ZnF3YkhXUURJVmMyM2RmMFYwOTBu?=
 =?utf-8?B?b0hlM21TT2RSSm0yZkp0aUhTNUNFUFlLMXVrcDNCYnFwVFdoZE1oNXFuN0FN?=
 =?utf-8?B?Lzg2QkFadytvL3hjVUE0YWJqSCtMdkk3ZXV1MWtHVytvUzcvQXlnQnl5eE5j?=
 =?utf-8?B?SktTUHZmd1RqbXRNSWs3RVY3MUdORUdQK0RadFFiRlJmYVZNaWlzZ3BoZU5p?=
 =?utf-8?B?U2ovNGM4MHJaakJZejZsRkkrRS80UnQ2RUx1ZU9IRFN2RnJEUEFmeGdReTFw?=
 =?utf-8?B?cWQxTFRQWnpYaGZudzd1WWdDdGdEN1lKcWZKZ2txTmcrYTlvMVVHdzdUNWpv?=
 =?utf-8?B?eExIZDdpQ2hrT3B0c25MUjRiKzZrSW52Zy9tUU1kOVFySHAzbnVnY3c0aGo5?=
 =?utf-8?B?M1pwVnJ4dVNGZkMrd2p4SzJmellrdS9UKzQxV3JBRmxyNURpZFJMdUExT2JQ?=
 =?utf-8?B?VmZUcStwVGM4TERmSksyWFRzWVZGT0pINncybWJVT29ZQkY1U2VlcnhvVENO?=
 =?utf-8?B?TUNEL2tYMjJXNGVRekFKOU1KQWNtTkhxTDZCNWM5akdrZ0xHTmRjWC9qZ3Zt?=
 =?utf-8?B?YmJsQWxSZW94dlpIVkNJMDU3Wlh1RjZVWlUvRDd0M2lKbmY5Nm9YWG9kTnFv?=
 =?utf-8?B?SkovRDc1a0UwNllFdGhpRnJNNHBDNFMvRzBsY21DakNRT1h5M3dVdldocGNr?=
 =?utf-8?B?QkxOWTZLUWw5Mlc4dElwWmp2MHdEVWRzT0ZkMFBMK0lEbklSN2ZCQm9BUWpV?=
 =?utf-8?B?Sk9QcmR1V0Q3ZmtNQnhpU1BSNkVFTkF1YkppNmZoUzhsUUY4NHgxM0xNVks2?=
 =?utf-8?B?MXRsVzRPNVRlM1lCcXhTMEtVVTZOVCtBbEg4dTVkcXB3bUFyMjdtMDd1WmdM?=
 =?utf-8?B?ZXIvaktKNzhJZmU2UEdkQmpOcEdlMC9GaFZBTzZ6WEVUZTJ5ejBaZUxxL3p6?=
 =?utf-8?B?OFUxRGdlaHZSUnJvYk12UURHb2pCa2xOTUFaWk5ldDQxd200NnRQREYvUXd2?=
 =?utf-8?B?dE42cVRJcWJPQVpLZStCY25NZlRaMldVdTlqcVM1ZGNkb0ZoTWlWRXZKK1pG?=
 =?utf-8?B?VFAyRHNIVURWSU5YNW1OeElHc0M3S3Ayc1NMMjZDT21WZk52dEpPRThUVmlE?=
 =?utf-8?B?ZElTM1dTQmVSVUpKeitQQmsxQTFwRHRKVGdGZFl0aFpJRkVmdnN4ZEhzeWNJ?=
 =?utf-8?B?T0V0OCtISXI0azczRllXZmM4TXNZaWFyTE9CUU12RzFlTGFsaXhKd0JmWUhw?=
 =?utf-8?B?RzdTY2VhMDJGSEJsc2lWSnBBbUVNbUVsL2JLM2pzRWF4dnBxQXRPd1ZBMjNJ?=
 =?utf-8?B?SE81bUZHUU9BOHA2dU5WTVZUMTJVTEFORTNEL2F4OGdLSjdKNkJTSlVMVksz?=
 =?utf-8?B?bzBYaEpIWGtkVncxcWxkckxmUk5TSmFscmd6STB4czFSMWQ1V0xha0U4Qy8y?=
 =?utf-8?B?Y0tVME1SWFdpbm9NemtKNjcxUThVS3Y0OXZkRDdnb1JFLzNvL2t6MEFZMGx6?=
 =?utf-8?B?RXpXQ2tOLzl5TitIZWxHY24zbHljd2lyMng1bzVPZE5tOVM3aHlWa2RwTW1S?=
 =?utf-8?B?VktPbzJvcWlpNzdBdTNpeFFOQnFzdUYxNW05Z0NiczJ0RlRERHZ0bHFFR2Vl?=
 =?utf-8?B?UmVEaVdNVk9EQWIvK0p1VnhaZnl6bEVqcTh4MDJ4YmhoU0xpZGhoQkhhY0hq?=
 =?utf-8?B?QmJGVFh4S2FwdFRKejROSFQxYlY3Qk5XRjF5cm91UFAwQ3hzdE54MExJNUt1?=
 =?utf-8?B?T3RkNDZEOXFXVUQ1ZE5LMWIzZHJkenlPTkt5N1pIWkhhczZiMC9HWnZhUmcv?=
 =?utf-8?Q?JW8rYCOLbfP37Sn3p7HJVAB+PGY6LqMQ?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Sep 2024 08:19:17.3242
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fefd8069-7806-44a0-d931-08dccf15c44b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF0001709D.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6529

From: Alejandro Lucero <alejandro.lucero-palau@amd.com>

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

Alejandro Lucero (20):
  cxl: add type2 device basic support
  cxl: add capabilities field to cxl_dev_state and cxl_port
  cxl/pci: add check for validating capabilities
  cxl: move pci generic code
  cxl: add function for type2 cxl regs setup
  cxl: add functions for resource request/release by a driver
  cxl: harden resource_contains checks to handle zero size resources
  cxl: add function for setting media ready by a driver
  cxl: support type2 memdev creation
  cxl: indicate probe deferral
  cxl: define a driver interface for HPA free space enumaration
  efx: use acquire_endpoint when looking for free HPA
  cxl: define a driver interface for DPA allocation
  cxl: make region type based on endpoint type
  cxl/region: factor out interleave ways setup
  cxl/region: factor out interleave granularity setup
  cxl: allow region creation by type2 drivers
  cxl: preclude device memory to be used for dax
  cxl: add function for obtaining params from a region
  efx: support pio mapping based on cxl

 drivers/cxl/core/cdat.c               |   3 +
 drivers/cxl/core/hdm.c                | 158 ++++++++--
 drivers/cxl/core/memdev.c             | 174 +++++++++++
 drivers/cxl/core/pci.c                | 111 +++++++
 drivers/cxl/core/port.c               |  11 +-
 drivers/cxl/core/region.c             | 417 ++++++++++++++++++++++----
 drivers/cxl/core/regs.c               |  29 +-
 drivers/cxl/cxl.h                     |  14 +-
 drivers/cxl/cxlmem.h                  |   7 +
 drivers/cxl/cxlpci.h                  |  19 +-
 drivers/cxl/mem.c                     |  21 +-
 drivers/cxl/pci.c                     |  90 ++----
 drivers/net/ethernet/sfc/Makefile     |   2 +-
 drivers/net/ethernet/sfc/ef10.c       |  32 +-
 drivers/net/ethernet/sfc/efx.c        |  19 ++
 drivers/net/ethernet/sfc/efx_cxl.c    | 180 +++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  29 ++
 drivers/net/ethernet/sfc/mcdi_pcol.h  |  12 +
 drivers/net/ethernet/sfc/net_driver.h |   8 +
 drivers/net/ethernet/sfc/nic.h        |   2 +
 include/linux/cxl/cxl.h               |  81 +++++
 include/linux/cxl/pci.h               |  23 ++
 22 files changed, 1237 insertions(+), 205 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/linux/cxl/cxl.h
 create mode 100644 include/linux/cxl/pci.h

-- 
2.17.1



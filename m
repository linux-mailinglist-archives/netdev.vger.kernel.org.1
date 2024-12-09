Return-Path: <netdev+bounces-150333-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 537A39E9E86
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 19:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C23C01882FA5
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 18:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51A791993A3;
	Mon,  9 Dec 2024 18:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="x7b7NIsw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6608317DFE3;
	Mon,  9 Dec 2024 18:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733770488; cv=fail; b=qeU18m3D30aC+ALjVvaoiKZNd9kpV91NUSeMpqsVUMMRGbsVuQhNN+uujrBnnbzJiDdQWXnRa8nALxvoGOSGHW4zr7QAGGXwkd/BG0oZoldioac4n/ylDi/SDO/uoAUzo5P4wmCePFnfsVfzXSuOrNJDI5Bq/aJ+qAZqcz10tnQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733770488; c=relaxed/simple;
	bh=+11q/XSCHoNN3mwHqc+k73aMhdANm0apFc9M82WKVeU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d9FqEpIFQLSJrHQ30yW3hgOAFnWLElUKIImX7ZlEWEKZRHqOUhA7zXowWDfEBXNd4I77oGNgHcEz04iP8bSk7RX1dvVcFGQQWZqi/WlNEf+3CkM5lt1C6eyufX2CEgaJPcZ3IMvzjH7/aU6QAHgfGT5/WiGOeXj3an1BsmgcfAo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=x7b7NIsw; arc=fail smtp.client-ip=40.107.220.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qlcKcb5K53/xnzo59xxP7Z6MtqdLGuksNLqatqch2VGyhHWFvgeACvxViDLfOf8o4I1/y7ie58LTt16r1YHmyLoK9sUzXhl1ZqiNG5wt2f12TgqMofgVdolq8cIZUKQBD5hYnB9lDPR0YEMyxOUrj/xVljllIl69JGQvJQi1iBYncaO9sjX7Do2k7DFDIw5qZdAjTgDLTOsTdCZqzoi1KjSv3r7P1wNrd1NH5K9brvxciLhWxHem+r6isyQZ/cTf68JkdXDms5nO2JipzZgvnEFLUw1WzCnJS2DUn8QX6usmBcta7fiilsuS0M07Oyt5pLhwkzKsbT2MvMzz+KBlXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PGq9gYruvK1SGYCJE6acE5TDT9RaIHYYIsdHbKlTyo=;
 b=MxQE0S4LyJDMAJaIUVALK/0GVWZMkzKLybdX0O7iRlr55BdJSFrDe1LHxX5FIA8WlfXpuozKFAJRwPikCVUu0blsA8N0qkEiOSfIt+kd71pHqIj2lyD6UJcjnDeUAYqaoz8+f9aWyAkhHZQkd+6HhN6lYP76gZvYhGMFGo1547dr2XkFgXbEciYdwY3Tfjsw50vAkuc2DKfoA5PC1PNgcAIZ6n5W8oDFx+a26ggLuNmzGuU/k0j+R6KDOhfadov4w8aBEpcX0qBDiUdXFP4niRUCw8Aiw/4UJFGRwpbPB6QwNS+T1iVlMEKOW5kGOrPS00FKFPJstwEf/dLqfekOug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2PGq9gYruvK1SGYCJE6acE5TDT9RaIHYYIsdHbKlTyo=;
 b=x7b7NIswg/F7nm3DYJrnxnZ5592p59fqcvfOQRHOvsG6VDtLKi9wPJ8IKKakqDbptH7pHdSTRB0d0qdZaxtNowMtq3dt9C5b80h3t/QdbWnvh/1XSy1ep3/grF6MRWxTMX4RmAXxGkw+vvSv7yO4cfOTwmRS1+Rgl0mA4yl+Jww=
Received: from MN2PR16CA0057.namprd16.prod.outlook.com (2603:10b6:208:234::26)
 by SA1PR12MB7128.namprd12.prod.outlook.com (2603:10b6:806:29c::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.18; Mon, 9 Dec
 2024 18:54:39 +0000
Received: from BN2PEPF00004FBB.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::d4) by MN2PR16CA0057.outlook.office365.com
 (2603:10b6:208:234::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8230.12 via Frontend Transport; Mon,
 9 Dec 2024 18:54:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF00004FBB.mail.protection.outlook.com (10.167.243.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8230.7 via Frontend Transport; Mon, 9 Dec 2024 18:54:38 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:38 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 9 Dec
 2024 12:54:38 -0600
Received: from xcbalucerop41x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 9 Dec 2024 12:54:36 -0600
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <martin.habets@xilinx.com>,
	<edward.cree@amd.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v7 00/28] cxl: add type2 device basic support
Date: Mon, 9 Dec 2024 18:54:01 +0000
Message-ID: <20241209185429.54054-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBB:EE_|SA1PR12MB7128:EE_
X-MS-Office365-Filtering-Correlation-Id: a6233131-be29-4e1d-9df7-08dd1882eed9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZjRvRWR1Q3hDM3R2VkUvUUJPWkIreHNDL3JhQVY1RjNLVllWQVk5Q25NOS9N?=
 =?utf-8?B?RHQvSXlKUlBYWXVMQm9SWU5aamhDeDc4aFY0aFkzYTEwS0UxUEphRFppQnd6?=
 =?utf-8?B?emlINDhLak9seVJiL1lIVUZOUlRjL3Z6N1M5TFcyQU10ZHFXbVlLSnR6Rjli?=
 =?utf-8?B?S1VKdThZd0pNWittTGRXRXVTRWx2V2JMVVdEYy9lVlh2amEvekhZK2VqazBm?=
 =?utf-8?B?eldiMElFeSsvaUl5RlUvMXZ6T3BaeXVRZEdoVzJhVVVJTk96M2tuUlFQWTR6?=
 =?utf-8?B?Q1B1Z3I5OFJsTHk1RjNPTmNxcU1DMkllWk1lYnJTWWNzaUR4RXBqblBvZk5p?=
 =?utf-8?B?RzNmNEFwSUdzNjBUTjZmOHNMMHdMZ2VaREU2Syt1aFV1eG9ERk56T2lEZCtV?=
 =?utf-8?B?UUh3TzBTNDF2VDc5TU5rNy9sd29XWFExaFdBQzVwNjJRU3JkaGhic0VHYzlF?=
 =?utf-8?B?eTVubjFkNyt1czVZaVhzTlJpVktWclJrVkw2a2NXRHpiSWkzTU5IWDc4Zm8y?=
 =?utf-8?B?MXdMNUdjUHVIRE9ZWmEyZkFvS0pwK29WQnBZVEEzc1lrNW5Qa1FYeFlZV2xi?=
 =?utf-8?B?QU4wbkhKRTc0U0t1OE1Eajhqa2t1K1FtNlc4WFJYaHNGdjA0K21wSk5ub2Rh?=
 =?utf-8?B?Sk1Hb2lDQVR6K29xSGJ1ZlZDTU5VRXBodW9aSmJnb0JyU1ZnYWJqNzJjK1RP?=
 =?utf-8?B?REpnd1pta3JaUzJlTDMxclpMZnRzNkVoRkM4cWN3UVZrOE1QcmdXb3JxeUds?=
 =?utf-8?B?aXd1SHlkVDVvS29qOWI0aDJmbDBxZWtGMEwzUnJvUFJGSGJFV1N2WXU1dEhl?=
 =?utf-8?B?NVBsTlIrcnNyd2VNcXg1NTYwSWdveldGT2RtK3J1aTB6TXRWK3JTcjBVUVRt?=
 =?utf-8?B?S1hCYlBtTmR4dUNaaU9XNjRpVC9pdXZyeFc4dWQ2U1U0NVhTK0pOT0dnMzY0?=
 =?utf-8?B?VDVOSFh1djRqWG0ySVFRQXdWazBkTEVvL2tCaE14YUd3S045MlY2YzQvK3BJ?=
 =?utf-8?B?NnlSdWVwc1RXNVZRbFVpakQyZkllZWZjUDRQRkVhcmhsd2hKRXpUZ0FTQmNj?=
 =?utf-8?B?ZXU4cjlhY3VWVDJmeFNiK2IycitxRDRqZEJEdDExWWVvRnd0MENacC9HTysw?=
 =?utf-8?B?Q2VaZ3Raa0xRajdBZGovVUppVWtpWUVNTmZrMTlvMlRlRDN5TDNTcmxoTEZy?=
 =?utf-8?B?K0todEdycDhUZTdKMDhQK0J3NExpZXFkQnZQU1Z6U0ttVFoxZDAvY1Y3ZDhk?=
 =?utf-8?B?YWNpUlBPMjdveGNBSTEydGh0Vjlsa2tyK2lSMFNMVjJNL3Jrdk44N01XVU9K?=
 =?utf-8?B?SnpzQTN2c1E3VkVGKzRmbzdrNS9CYlJsQzh5RFNmRlhBVDk0d1RnTHBCM0tu?=
 =?utf-8?B?dUl4SmZ4aHpWQ3N1bTRVUmpUdlRPb1IxRmNJVzc5QUdtdFdpYk9CYVNTcG9I?=
 =?utf-8?B?S3M5dHoyWnNtTWN4REJxNGhHOWZCcnN4UjdrM0ErV0xWcVRoalBFWVRQWG5n?=
 =?utf-8?B?WEFoWVYwZkMrOGhHcmVSZ29NNWt0ZW5kZ3RSSjluUlJSaWNIOXpaQ29MYTBC?=
 =?utf-8?B?WGFqeEFyMFVTdjh2VEZMZXhaanN2WWpGa1BTNVYwV1BBN2FhdHJyS280UGpX?=
 =?utf-8?B?c2Z2ZEZnMjRMM0RzVUxBVW1laDlQT2gvUUx5cVBYSzZoVDJmV1ZRcVoxSzN4?=
 =?utf-8?B?MTJhVXBSVjM0a3FkOTFGaHoweHRzOCtyaXNMNWx6aGhseE1NVkkwMVN4b3ho?=
 =?utf-8?B?OUludUZRSkpxNWRvejVSZEJ1TU1aT3hFWGJxLzBHWGZOYmJaZE15azVMelh6?=
 =?utf-8?B?VndqSDlxWG1CUkJiUmRUT0xvMDVYMTNLTVJHY25RaEJPSE5ObktBTzRpOXgy?=
 =?utf-8?B?cGJHeTBheXBhSUlIajBnYU9acFBoTDRaZjZsWDV2WnFwRkNoRGJFbkdLWnVG?=
 =?utf-8?Q?UQznJIbCeO8=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Dec 2024 18:54:38.7751
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a6233131-be29-4e1d-9df7-08dd1882eed9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBB.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7128

From: Alejandro Lucero <alucerop@amd.com>

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
  sfc: create cxl region
  cxl: add region flag for precluding a device memory to be used for dax
  sfc: specify no dax when cxl region is created
  cxl: add function for obtaining region range
  sfc: update MCDI protocol headers
  sfc: support pio mapping based on cxl

 drivers/cxl/core/cdat.c               |     3 +
 drivers/cxl/core/hdm.c                |   154 +-
 drivers/cxl/core/memdev.c             |   116 +-
 drivers/cxl/core/pci.c                |   126 +
 drivers/cxl/core/port.c               |    11 +-
 drivers/cxl/core/region.c             |   423 +-
 drivers/cxl/core/regs.c               |    32 +-
 drivers/cxl/cxl.h                     |    16 +-
 drivers/cxl/cxlmem.h                  |     5 +
 drivers/cxl/cxlpci.h                  |    19 +-
 drivers/cxl/mem.c                     |    25 +-
 drivers/cxl/pci.c                     |   112 +-
 drivers/cxl/port.c                    |     5 +-
 drivers/net/ethernet/sfc/Kconfig      |     7 +
 drivers/net/ethernet/sfc/Makefile     |     1 +
 drivers/net/ethernet/sfc/ef10.c       |    48 +-
 drivers/net/ethernet/sfc/efx.c        |    23 +-
 drivers/net/ethernet/sfc/efx_cxl.c    |   181 +
 drivers/net/ethernet/sfc/efx_cxl.h    |    28 +
 drivers/net/ethernet/sfc/mcdi_pcol.h  | 13645 +++++++++---------------
 drivers/net/ethernet/sfc/net_driver.h |    12 +
 drivers/net/ethernet/sfc/nic.h        |     3 +
 include/cxl/cxl.h                     |    69 +
 include/cxl/pci.h                     |    23 +
 include/linux/ioport.h                |     2 +
 25 files changed, 6097 insertions(+), 8992 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: fac04efc5c793dccbd07e2d59af9f90b7fc0dca4
-- 
2.17.1



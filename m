Return-Path: <netdev+bounces-227919-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B61F5BBD903
	for <lists+netdev@lfdr.de>; Mon, 06 Oct 2025 12:02:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6B19E1894B6C
	for <lists+netdev@lfdr.de>; Mon,  6 Oct 2025 10:02:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F33221D3EA;
	Mon,  6 Oct 2025 10:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="p6hgUWi5"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012048.outbound.protection.outlook.com [52.101.43.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B07212574;
	Mon,  6 Oct 2025 10:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759744925; cv=fail; b=eSyNWxkjbH8cIYxAF6VJeZS1OzUV7EFrfyPv6ymEMwEC1Hp9+agTq39mOLZt1Gh5VrCud9P1dQ2dt7SgrXT7SgC4oROa4iXnc68/m0+hb1mri2x1NUQc/e4l4TbVJ20F2STfHYcF97cBUtLyNY96G5t8Fweh9wisAnIZFVFKaPM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759744925; c=relaxed/simple;
	bh=9ybTpe0UtDjdH/gwG5ae598WYgg7LPJaZqzrJlG0VuU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AmgcZGReb5Dcd5qroStDmpDqFoe1q2MZxLcL/KF2rG5i7UXeTueKG1wbSmHpcmdpWbKf3CdGMWqGK1zNkvpOF+LLRtX4RtcRG/5Mp8g+w2v4KYcxyKLkAwVo/UoTvFe466M+iH3inczsCL1i9nl8LwnT0DiSEzxzEn8uqIm8qH8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=p6hgUWi5; arc=fail smtp.client-ip=52.101.43.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nr5tNeC72gLurZCKjB0JBQhZaoeDjSOFnpD1BEVYQW+RuAmRm8udY8OzwjU+phh1yFoQlGgpSXVl+9BXKFuqbAiEPGHMcoLtK2bUGsqwMbpgzg9A9SFnEN3JiNhrOXze/jKmSI6l/UG/4Jtn/Hg93c2jcMqZ/FI5ewzVbZccK+/BFallTm/geXykTTYGbmdl05+8tFCYO9aQpQXSGfQu8F9E2p99gLAS8YoN6wU1q4i3HeS8Hy8zfwjXiPZkLQLhEiofLQMrvC2jm7tjUlQ/Ymwnfe3YQ/5Y9ZmlCURqoP28EtBOdbKrFtQhAmjp69trL7bMw0bsdDFFSCBanZV/Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5ypgxykpu+C+lMHnKISBVsefhRxtBlDRovKpncWKn0M=;
 b=tgDMPlspcgtSi+ffq4GaA0vVWsWC4OeRe52cBagzkw9vseDaXC3DZFk6Pk61IJxvRmg1GvxkSSY14+wh0awjb7tvVTxlfJmgY8qPamoXBWJSInOulX3eGX4DsIxiz1WfGvK5FCvuxllpu8Jv1i9Zzf5S6FUCatd8HGgcZpmCt+0Q0w1fO8SZBbp1ni1hXAHicFmXwSrxo7uXp4XXH5PKF+S4oXgC4W7qIN8nkeSIa9E5SKpdfee9BpXkTsON4V3omCDd0KhOg2tp3EAmIED6BUhcLLK9rmXnRurItoY7WIfis1L8AZMx+eh58WjCNuQTlxd5hlyI3p5KSTKQsGcauA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5ypgxykpu+C+lMHnKISBVsefhRxtBlDRovKpncWKn0M=;
 b=p6hgUWi5rFUeYVgsYX+kgVk7dafaBgcZZ/Rcj+MUsLscmxZ5r4yljAO8AVgUG8/PjDMgGaxkM9HW947p/DEJVcLAj8Zf1feBfjw1ZArPzct7oj014dLoqu4ed5/aQspPXna6xfn6LR3fCAA0qcn2VTrddCngdDyVuZTmKuutPeU=
Received: from BYAPR05CA0026.namprd05.prod.outlook.com (2603:10b6:a03:c0::39)
 by LV8PR12MB9110.namprd12.prod.outlook.com (2603:10b6:408:18b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 10:01:49 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:c0:cafe::36) by BYAPR05CA0026.outlook.office365.com
 (2603:10b6:a03:c0::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9203.8 via Frontend Transport; Mon, 6
 Oct 2025 10:01:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9203.9 via Frontend Transport; Mon, 6 Oct 2025 10:01:47 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 6 Oct
 2025 03:01:47 -0700
Received: from satlexmb08.amd.com (10.181.42.217) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 6 Oct
 2025 05:01:43 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 6 Oct 2025 03:01:43 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v19 00/22] Type2 device basic support
Date: Mon, 6 Oct 2025 11:01:08 +0100
Message-ID: <20251006100130.2623388-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|LV8PR12MB9110:EE_
X-MS-Office365-Filtering-Correlation-Id: 5069b381-481a-48b9-39ac-08de04bf5d20
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZG5iMVVlV0NTb001ZjkvUERRbWJiY1lhMUhzZFd6QUZrZitWSDRsRGVlVG5r?=
 =?utf-8?B?Z0k0aVpRbGJmUEk5WWdXb1lzekdIU29JclZ4SmdmQzhyaDhMTWlRQmZiZ2pv?=
 =?utf-8?B?K29reXRaL0lCMWZkT2F0bDRKckxtTTJLcmQ5Y05NQzdFMDdUOGxyb2UxSFFt?=
 =?utf-8?B?UktjdTR6QWZtamFOUTlVR0tNSjhWK3FhWk1XVFB0MHdYUmNOSk1vS0RRcCtv?=
 =?utf-8?B?d3U2K1Y4ZkhWanlkSEdNenNjdW84MEdDUVQrVTcvb2JSaXNQY01CMGhnUFR0?=
 =?utf-8?B?NVhHNzBCbVoxeVhNVGNqY2E4VCtqN2pzckZMNnVONHFqaDhJd2s0VWtUNkwx?=
 =?utf-8?B?dmhTNjZDNFo5OStxSW93dW5jUXBTaDRJYko4MVBhd3o0bUhhaFd5S1BqL0xm?=
 =?utf-8?B?dHdCSTJjaUdjZkhIREg4TWsyUzVvTnNhdjZ1c05iYjBaVndyYnhCUUF2bm1t?=
 =?utf-8?B?bDQ0SWZQRTB1VlM3eExDclF0WDcrZnhxbFIrd1NyVVY3STBvTlA0RllJVE5W?=
 =?utf-8?B?T0xYZ3JVcE1UcVdhV2RMbGRLcDI3YTVtRzlvMWlaNVpxZGJJSUFHd1pGTVNS?=
 =?utf-8?B?VnBpY1ZCQUVRdWgwWklRaDAzaXZXTEpDQm9GbVdTcS9hRmNLUGVaL1BpTEcw?=
 =?utf-8?B?KzlVMVJ2R2E0MTMvZkt1ODFJMGpTcTNQOUdWSVI0TWg4a0w0ZVRVNEU1SzdX?=
 =?utf-8?B?OFdRS0xLbksrNGtvUjM1NjJOM2svcitoOG1LMjVDTjNxeEc3VGtUNVRUNS95?=
 =?utf-8?B?cjB6UkZFS24wYW9qakZpZWVUY0R5RjhsMlU4YmYzR0tKMEpGZUVoMEg1NUxI?=
 =?utf-8?B?ODg4cWQvSXljVUFHZ254blFXaGJLVE5uYWxzcmg2ejNNWndBNmROZGR3MS9a?=
 =?utf-8?B?Zjd0eXh1SWF1d1djS3d5Q3ZBaldneXozcTlDTm52bCtKV2hWb3ZyeTdoRW5m?=
 =?utf-8?B?ZWZuSlEvN2x2Z290RXR3Vy9Mby9CaThCc0JPcVVWSGErT2thMkpHVnNlSVk4?=
 =?utf-8?B?SitHNW1BMkpIQWlqSGw4bklIUU43SkdIdWxKK0hUczNZVVpQNjJ2ZDB6UDQ4?=
 =?utf-8?B?Vk50TnRucWQxenpVOWdmeitVaStvSngyN3lyL0loSjk1MXJRMFI2VnJiSWUr?=
 =?utf-8?B?aXBReHQzYXBtcVJPSkZiOXdVdjY5UWVjVU5XTlNjUWg5Zk5DRXlTTjRoYmR5?=
 =?utf-8?B?VUZ0ZytndlVkbGJEREg1UGR4ZFBaaDJYSkpQVmxiRXZCOUlUUExidlhhTTZl?=
 =?utf-8?B?UFFsNjdJYnF5MlcxRVNMZ1JqdWFkYWR0QklVSEQrRXA5QTYwMyt3dmNZYTdF?=
 =?utf-8?B?L05BejlBWWo2ejRPMG4zTGp5K05YTUFna09JaWtJT2JRa1BhSXVvZGk1cDhx?=
 =?utf-8?B?bVp6cjE5bk9icUNpUzFFWDFGMlhJanVzUDk0em40UGV5TXJ3aDVJYm1VTHQz?=
 =?utf-8?B?ZXhqWnZPdit2Ni9LVjVQbWRua1R4UnZoTHk4S1E2SWRZT2JSSU9ER2taMk1F?=
 =?utf-8?B?cExZMWlMMFN1VEhPUnF4WFIrNko1U0pDN2R4dnNtNC9EU2hONFIzZGVXWVFU?=
 =?utf-8?B?WDhzd3VoZmpyVkQxMTFsVDUzOGpBQnRpd0NlQWY4UmRWeXYzSGNIbWV2dmVP?=
 =?utf-8?B?NmxIZkxqOEkzZGwwYWMrWjdPZWJ5T3MwUk9UK0xQQ1NMNS9MQTFTZmtRZVk5?=
 =?utf-8?B?dzI0cVBNY3MvWUpvVlhLRWlFemJ3U1N5d0k2NU5IY29vcTArMmJnR2NYZHIz?=
 =?utf-8?B?MU1MeUR2eGhaZTJyTE93QnJ4Y2ZidWpaaEs4K0lRTG1jQStjV0V3SlUrT2p4?=
 =?utf-8?B?bTcvZ3Y4Um5Zb1FKQTZTU2NCZTU5WFVFMGxKTndBdmR0clVqQlM5NWw4UXdZ?=
 =?utf-8?B?RlFyZXFHR1R2b1hsUFVSYzlZeXkvYk9YMVhiSFBNWFVRMDdMZVNxbzEzQ1h4?=
 =?utf-8?B?K2NOL2pxTzkwaHVOT2Y2QkVvbmNjODJaSCtQUXdsSW5EUXIzTEUxR1lUL3BL?=
 =?utf-8?B?UzhjNVMyWDI5RjFlUlEwWlJzTUpMZFVVNk1wT0h1VzlBYWdsYjZac1FyanVn?=
 =?utf-8?Q?taeF99?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 10:01:47.9461
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5069b381-481a-48b9-39ac-08de04bf5d20
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9110

From: Alejandro Lucero <alucerop@amd.com>

The patchset should be applied on the described base commit then applying
Terry's v11 about CXL error handling. The first 3 patches come from Dan's
for-6.18/cxl-probe-order branch.

v19 changes:

  Removal of cxl_acquire_endpoint and driver callback for unexpected cxl
  module removal. Dan's patches made them unnecessary.

  patch 4: remove code already moved by Terry's patches (Ben Cheatham)

  patch 6: removed unrelated change (Ben Cheatham)

  patch 7: fix error report inconsistencies (Jonathan, Dave)

  patch 9: remove unnecessary comment (Ben Cheatham)

  patch 11: fix __free usage (Jonathan Cameron, Ben Cheatham)

  patch 13: style fixes (Jonathan Cameron, Dave Jiag)

  patch 14: move code to previous patch (Jonathan Cameron)

  patch 18: group code in one locking (Dave Jian)
	    use __free helper (Ben Cheatham)


v18 changes:

  patch 1: minor changes and fixing docs generation (Jonathan, Dan)
 
  patch4: merged with v17 patch5

  patch 5: merging v17 patches 6 and 7

  patch 6: adding helpers for clarity

  patch 9:
	- minor changes (Dave)
	- simplifying flags check (Dan)

  patch 10: minor changes (Jonathan)

  patch 11:
	- minor changes (Dave)
	- fix mess (Jonathan, Dave)

  patch 18: minor changes (Jonathan, Dan)
  
v17 changes: (Dan Williams review)
 - use devm for cxl_dev_state allocation
 - using current cxl struct for checking capability registers found by
   the driver.
 - simplify dpa initialization without a mailbox not supporting pmem
 - add cxl_acquire_endpoint for protection during initialization
 - add callback/action to cxl_create_region for a driver notified about cxl
   core kernel modules removal.
 - add sfc function to disable CXL-based PIO buffers if such a callback
   is invoked.
 - Always manage a Type2 created region as private not allowing DAX.

v16 changes:
 - rebase against rc4 (Dave Jiang)
 - remove duplicate line (Ben Cheatham)

v15 changes:
 - remove reference to unused header file (Jonathan Cameron)
 - add proper kernel docs to exported functions (Alison Schofield)
 - using an array to map the enums to strings (Alison Schofield)
 - clarify comment when using bitmap_subset (Jonathan Cameron)
 - specify link to type2 support in all patches (Alison Schofield)

  Patches changed (minor): 4, 11

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

Alejandro Lucero (21):
  cxl/mem: Arrange for always-synchronous memdev attach
  cxl/port: Arrange for always synchronous endpoint attach
  cxl: Add type2 device basic support
  sfc: add cxl support
  cxl: Move pci generic code
  cxl: allow Type2 drivers to map cxl component regs
  cxl: Support dpa initialization without a mailbox
  cxl: Prepare memdev creation for type2
  sfc: create type2 cxl memdev
  cxl: Define a driver interface for HPA free space enumeration
  sfc: get root decoder
  cxl: Define a driver interface for DPA allocation
  sfc: get endpoint decoder
  cxl: Make region type based on endpoint type
  cxl/region: Factor out interleave ways setup
  cxl/region: Factor out interleave granularity setup
  cxl: Allow region creation by type2 drivers
  cxl: Avoid dax creation for accelerators
  sfc: create cxl region
  cxl: Add function for obtaining region range
  sfc: support pio mapping based on cxl

Dan Williams (1):
  cxl/mem: Introduce a memdev creation ->probe() operation

 drivers/cxl/Kconfig                   |   2 +-
 drivers/cxl/core/core.h               |   9 +-
 drivers/cxl/core/hdm.c                |  85 ++++++
 drivers/cxl/core/mbox.c               |  63 +---
 drivers/cxl/core/memdev.c             | 209 +++++++++----
 drivers/cxl/core/pci.c                |  63 ++++
 drivers/cxl/core/port.c               |   1 +
 drivers/cxl/core/region.c             | 418 +++++++++++++++++++++++---
 drivers/cxl/core/regs.c               |   2 +-
 drivers/cxl/cxl.h                     | 125 +-------
 drivers/cxl/cxlmem.h                  |  90 +-----
 drivers/cxl/cxlpci.h                  |  21 +-
 drivers/cxl/mem.c                     | 146 +++++----
 drivers/cxl/pci.c                     |  88 +-----
 drivers/cxl/port.c                    |  46 ++-
 drivers/cxl/private.h                 |  17 ++
 drivers/net/ethernet/sfc/Kconfig      |  10 +
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/ef10.c       |  50 ++-
 drivers/net/ethernet/sfc/efx.c        |  15 +-
 drivers/net/ethernet/sfc/efx.h        |   1 -
 drivers/net/ethernet/sfc/efx_cxl.c    | 165 ++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  40 +++
 drivers/net/ethernet/sfc/net_driver.h |  12 +
 drivers/net/ethernet/sfc/nic.h        |   3 +
 include/cxl/cxl.h                     | 291 ++++++++++++++++++
 include/cxl/pci.h                     |  21 ++
 tools/testing/cxl/Kbuild              |   1 -
 tools/testing/cxl/test/mem.c          |   5 +-
 tools/testing/cxl/test/mock.c         |  17 --
 30 files changed, 1476 insertions(+), 541 deletions(-)
 create mode 100644 drivers/cxl/private.h
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: f11a5f89910a7ae970fbce4fdc02d86a8ba8570f
prerequisite-patch-id: 44c914dd079e40d716f3f2d91653247eca731594
prerequisite-patch-id: b13ca5c11c44a736563477d67b1dceadfe3ea19e
prerequisite-patch-id: d0d82965bbea8a2b5ea2f763f19de4dfaa8479c3
prerequisite-patch-id: dd0f24b3bdb938f2f123bc26b31cd5fe659e05eb
prerequisite-patch-id: 2ea41ec399f2360a84e86e97a8f940a62561931a
prerequisite-patch-id: 367b61b5a313db6324f9cf917d46df580f3bbd3b
prerequisite-patch-id: 1805332a9f191bc3547927d96de5926356dac03c
prerequisite-patch-id: 40657fd517f8e835a091c07e93d6abc08f85d395
prerequisite-patch-id: 901eb0d91816499446964b2a9089db59656da08d
prerequisite-patch-id: 79856c0199d6872fd2f76a5829dba7fa46f225d6
prerequisite-patch-id: 6f3503e59a3d745e5ecff4aaed668e2d32da7e4b
prerequisite-patch-id: e9dc88f1b91dce5dc3d46ff2b5bf184aba06439d
prerequisite-patch-id: 196fe106100aad619d5be7266959bbeef29b7c8b
prerequisite-patch-id: 7e719ed404f664ee8d9b98d56f58326f55ea2175
prerequisite-patch-id: 560f95992e13a08279034d5f77aacc9e971332dd
prerequisite-patch-id: 8656445ee654056695ff2894e28c8f1014df919e
prerequisite-patch-id: 001d831149eb8f9ae17b394e4bcd06d844dd39d9
prerequisite-patch-id: 421368aa5eac2af63ef2dc427af2ec11ad45c925
prerequisite-patch-id: 18fd00d4743711d835ad546cfbb558d9f97dcdfc
prerequisite-patch-id: d89bf9e6d3ea5d332ec2c8e441f1fe6d84e726d3
prerequisite-patch-id: 3a6953d11b803abeb437558f3893a3b6a08acdbb
prerequisite-patch-id: 0dd42a82e73765950bd069d421d555ded8bfeb25
prerequisite-patch-id: da6e0df31ad0d5a945e0a0d29204ba75f0c97344
-- 
2.34.1



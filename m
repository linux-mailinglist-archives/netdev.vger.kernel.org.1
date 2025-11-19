Return-Path: <netdev+bounces-240134-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A9E9C70C9E
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 20:24:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 2D9E0355172
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 19:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2968531ED92;
	Wed, 19 Nov 2025 19:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="SIzfrvjT"
X-Original-To: netdev@vger.kernel.org
Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010037.outbound.protection.outlook.com [52.101.61.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA132D4B61;
	Wed, 19 Nov 2025 19:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763580184; cv=fail; b=HzRj0mc9ZcSE6s4o/v1T/CMrG81skTeMVHdBNL6Hez8vxsHN76JLGVN5DL4wV7RORAPaW90BXUgKWw/33CbJHmRiJE/mrOOp5h0UJe4cXMGaaoBQpWK5v9vPODLwmq+ws/mqTo7fyWFjr15VT038/K1/zwGgNj0QqJO529eJkyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763580184; c=relaxed/simple;
	bh=GPqwZ3jR5MLqMsNvUmxB2EZcpDfibws/1Z0NvvtXgc0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=feSdSjSoYnpHOYt1xU1ptJN0lt77V/drqotXrogNlDBT1W7YEu+JUGua+mhc6fvNtmRgLR9WdMEb+ugcqSHl7u+7oNGMYBOzMpAvhxPEvm7nllaXDgew1Q0RsAJRt768/yo0JFbsbfcBHiTfRsA2iMiRSMliXV7j2iLtnMpuKjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=SIzfrvjT; arc=fail smtp.client-ip=52.101.61.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OmzQyrpZojDSEr+FRWv8KpIvF7zLNmd1H3jxGgQpxlq+0awYOZb1UtvGaM0mQirmXKVXiR0GNNq98o92IJMXeDDkWaZO8nfvXxdVppbMazSwPCxsw7F6CyjRTNEj7/svkBHcPY7wTTnmNBp1ZedqU02BpVlaTgYqa/S1OwqARd1dgKK/loUt79UbR97jdhURRtKHPN1trdBBrgEJjVykNUECmOW5xRO2FOmQfNJz4rGKWwjtTSkn9Kf4Gm4BepxrSZd+cSKKo1YIUeIp9AZorKihnkOunqwX51La299yv/9ItXCrt+p+Rxty8oJb/LUbvB+DKOTLGtO6MO/+rsTzww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MDZjYKgkXx82hGljs5bG1B4Tr994LecfoK4Ks6VhsXg=;
 b=KhoGDEYxpZXVGJd2N9V+GlyoLg9ZBykseZYVJ/oRrPpoDHoZb686cCvqJiWxS+pqAuQuft0TVRpFMDMK5bdIz9y/YbA+IZGZOEVYdJePK0rmeOMeiDR6ydvQ0K0t9TqVjvFGvnv65NLYQEmpp9PWEtJdAmnbaH8e4Cxu7aDF2CfqxqNp45yv2CLGAbSDLSHg/n89ywvhaSsAcwsEUYFQpa1Kj8xEq2y1RXdLlqx3jVycK2Wf9T/OE2zNNk43e9cYcN4PsZ8jXINut2fqndB6ko09tYJtiTT5ZOi7D6INlWayCEJhOrk/uvodFy3UbipWxpQ7bsPQ8gQsghe6VpONQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MDZjYKgkXx82hGljs5bG1B4Tr994LecfoK4Ks6VhsXg=;
 b=SIzfrvjT9++LIC/9De9sS4tQE9gXkWqra33nDIoz3eM0WqGrI7pqQc4/YmD4BhTEi/Myw7kaaQ8lQuvEW0TmnUIQ7VYWXntmkcRhzNnX6i73o8uzYP5MhNlYZKYYufsZSZ6blAZBUD8MtcbFBMeFDkf7HRHnWcWBWLdHlM0eFOo=
Received: from SJ0PR13CA0102.namprd13.prod.outlook.com (2603:10b6:a03:2c5::17)
 by DM4PR12MB6614.namprd12.prod.outlook.com (2603:10b6:8:bb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Wed, 19 Nov
 2025 19:22:46 +0000
Received: from SJ1PEPF00001CDE.namprd05.prod.outlook.com
 (2603:10b6:a03:2c5:cafe::89) by SJ0PR13CA0102.outlook.office365.com
 (2603:10b6:a03:2c5::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Wed,
 19 Nov 2025 19:22:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CDE.mail.protection.outlook.com (10.167.242.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Wed, 19 Nov 2025 19:22:45 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 19 Nov
 2025 11:22:44 -0800
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Wed, 19 Nov 2025 11:22:43 -0800
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v21 00/23] Type2 device basic support
Date: Wed, 19 Nov 2025 19:22:13 +0000
Message-ID: <20251119192236.2527305-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CDE:EE_|DM4PR12MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: d028e239-9c4d-4775-8169-08de27a104f0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|1800799024|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkQvczgzNjI3czFjR1hWcERrS0RsQ3VPZVVVREpJNUhES09IUDdwby9sTE1M?=
 =?utf-8?B?WkVhcU8xTytXZnFDOWphd011Wld1TXVMclZ4SHB0MjFZNldoaWMzMFV4T3J6?=
 =?utf-8?B?L3FqNEtyN1ZmckNlZzN4UXM4cUZCMzgvSXMwak5TbGNrc3BBY09RVGRqRU4w?=
 =?utf-8?B?b1JNR2gxbnhXRDF1VkhndFhuRU9WNW8zYjQvbDEza0IzMGUvR0loUG1DM3Jq?=
 =?utf-8?B?QVI5d2N2QTdTVG0xNkRFcXFJUkI5T1QzSXdCK1dxckI4Z1d0dTV4MldRcFNM?=
 =?utf-8?B?NmlWQ0xtY3FBNjNwQUw0dWpyS2w2QjZMeHRxc05KSHJFTlpaUXNGL2dxV3ox?=
 =?utf-8?B?dlVpTGJSUTdTMmdTYlIxazRuWUdLVUtxRXQwd1ZvdzZQL0NiUzR5RmNFZ3Ay?=
 =?utf-8?B?RmE0dEM2TDAxUzlpcHFoNkQrSjJLbWlwd0xXVEh5YWRIMVlZL1JMcnBZYjVp?=
 =?utf-8?B?UHVwTFlmaTA3TnVOSmZlQVNRcG1ncHh2eXgxVEtPajJHdDJraU1tS2M1Z1Bt?=
 =?utf-8?B?L0RzSTJ4NW5jbkJOWEFrSWc5akRTTFFlQ1dCSUJoRSsxRFpuMVptUGRuc2dp?=
 =?utf-8?B?OVhrYlkzYURxY0l1NnBwRFJkQmpKY0F4b21oREJwSEFDdTU1MDZiWDgyNk9r?=
 =?utf-8?B?RDFReW03MGZSWkUyTk5kclFrQ1pQYkxJSFd1MFpENTRnSTlwUEVlOXBIMEUv?=
 =?utf-8?B?Q2o3TlE2cHBQdFFYdVA0bnJQTzFzVVdVZThBZ2dsZ3d4ckhWT0FPVjZUYnZm?=
 =?utf-8?B?TmpmZjd2Yk1nMkFWQ3RJbm1PbERTTlA2enhDZXU3SjNHNXJHUWJJMkhYS05k?=
 =?utf-8?B?L2RlZ3BIU3RFWkF5dUhZaVczaXpUWjEvM2xva2RkR3BJM0NtSnY1TExuSktz?=
 =?utf-8?B?TjQ5OVZRd3FYR0svVmxRa1JvWk1xZkxDNFNXYUJNOXloWWVNRFRTMDFIaGlQ?=
 =?utf-8?B?NHo0MkhBSFd3K09oK1hIQ2xWMzRlWTR4Sm4zemRTeWE3djdRQmhkLzBFc09U?=
 =?utf-8?B?bzRESEJsb05zRlAwNGEwWE9SUVZMN3Jtd2NkQ1ZEY2xSUmFlMmFtTnVnNGN5?=
 =?utf-8?B?blVIQ054WWhWQ3pjWnpWRHZWb1RMbmpOc2E3c3RsL0lPUlZOVUdna0RoVVM0?=
 =?utf-8?B?SXlCeUd1ZFdEY3dJLzYwN3FJd1dYbGZVdFdzV0krUW1jcytNWTIyQnMraUsy?=
 =?utf-8?B?T2w2amQwZTNVWkswbklCNzBadmFjeWtqcUdWbzZ5bG9xdzJDYmo4QnFySWNQ?=
 =?utf-8?B?SXlUVzYvdTU5eEhaZzVYTEpUUXNGVFdRM2lod3kvM1R1bHlTZ3h6TXNjeTVx?=
 =?utf-8?B?SUNlSjVrOWU2bm05R1Juc2VXbGZYLzM1d2ZvNVFpQ0k5WFZhVXdva2hvc0hn?=
 =?utf-8?B?THRmcVUvSzV2UFhFTWxZMTdqUlF5WE9NSHo4V2lzQW5Id0l2N3ZDL0tMSzF3?=
 =?utf-8?B?VFRGamFNMlowUGYvRk5wa0cwZ25IdXZRaDJuSm91TCtnajNDdmcycjl4WXNU?=
 =?utf-8?B?cVVKZFowYm9LcGpjcCs2eTJZNldNSVoxNlV3cWwvUm5lVEZsa0tKNDlpdFRh?=
 =?utf-8?B?SWg2R2o0S2VhekJxUThnTXRFamNTaXNzaVQ3MTdpVWY4eHRIS01sQVRhK1hP?=
 =?utf-8?B?YlVYS3YxTEV3aVRtZEt2djdoUVUxZ1Q1cFl0ZzlUNUlVN3F4OFJNb2E2c2No?=
 =?utf-8?B?NWV1cjA1d3krTHZxU3BPNkFoSXdKSnpWWDBWZExOY2RBZUFPbmNtWlhneEtC?=
 =?utf-8?B?clA2OWI3SXF2M2UrRHU0NGlqVWZxVkJxTWpqZnpQRkdSYU9DSkVCcnB5Yk55?=
 =?utf-8?B?K3J3bHljeGpCTFJxTWhlemppM2tSRVZLcFVQSzJqRXNKV0NYdlRVUTNlTHFk?=
 =?utf-8?B?YjhtbWVXdzFDNENLekt5ZEhrdmVqenpIYmR2UDR5c25jNDc2UXkza1RTUEtE?=
 =?utf-8?B?SFhMM21rNVpNN1cyWEhkL3BjV0ZVR3NPeFFhT2FMc1R0SUZZalNySGZNSmh4?=
 =?utf-8?B?WHFxTWNNVlYrc0RnS2piM2xNWWJLMjJ3YXM2eU81WS9TNHhaSzZjL3gwZ0ZE?=
 =?utf-8?B?cWZwNTZJdm9XSUhwSFBGWWJXSTZ5REtkNGMrMC9Vc2JLZk1hNUdiYlJ4eTQ2?=
 =?utf-8?Q?1VAw=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2025 19:22:45.7923
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d028e239-9c4d-4775-8169-08de27a104f0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CDE.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6614

From: Alejandro Lucero <alucerop@amd.com>

The patchset should be applied on the described base commit then applying
Terry's v13 about CXL error handling. The first 4 patches come from Dan's
for-6.18/cxl-probe-order branch with minor modifications.

v21 changes;

  patch1-2: v20 patch1 splitted up doing the code move in the second
	    patch in v21. (Jonathan)
 
  patch1-4: adding my Signed-off tag along with Dan's

  patch5: fix duplication of CXL_NR_PARTITION definition

  patch7: dropped the cxl test fixes removing unused function. It was
	  sent independently ahead of this version.

  patch12: optimization for max free space calculation (Jonathan)

  patch19: optimization for returning on error (Jonathan)


v20 changes:

  patch 1: using release helps (Jonathan).

  patch 6: minor fix in comments (Jonathan).

  patch 7 & 8: change commit mentioning sfc changes

  patch 11:	 Fix interleave_ways setting (Jonathan)
		Change assignament location (Dave)

  patch 13:  	changing error return order (Jonathan)
		removing blank line (Dave)

  patch 18:	Add check for only supporting uncommitted decoders
			(Ben, Dave)
		Add check for returned value (Dave)

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
  cxl/mem: refactor memdev allocation
  cxl/mem: Arrange for always-synchronous memdev attach
  cxl: Add type2 device basic support
  sfc: add cxl support
  cxl: Move pci generic code
  cxl/sfc: Map cxl component regs
  cxl/sfc: Initialize dpa without a mailbox
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

Dan Williams (2):
  cxl/port: Arrange for always synchronous endpoint attach
  cxl/mem: Introduce a memdev creation ->probe() operation

 drivers/cxl/Kconfig                   |   2 +-
 drivers/cxl/core/core.h               |  10 +-
 drivers/cxl/core/hdm.c                |  91 ++++++
 drivers/cxl/core/mbox.c               |  63 +---
 drivers/cxl/core/memdev.c             | 212 +++++++++----
 drivers/cxl/core/pci.c                |  63 ++++
 drivers/cxl/core/pci_drv.c            |  88 +-----
 drivers/cxl/core/port.c               |   1 +
 drivers/cxl/core/region.c             | 413 +++++++++++++++++++++++---
 drivers/cxl/core/regs.c               |   2 +-
 drivers/cxl/cxl.h                     | 125 +-------
 drivers/cxl/cxlmem.h                  |  91 +-----
 drivers/cxl/cxlpci.h                  |  21 +-
 drivers/cxl/mem.c                     | 152 +++++++---
 drivers/cxl/port.c                    |  46 ++-
 drivers/cxl/private.h                 |  16 +
 drivers/net/ethernet/sfc/Kconfig      |  10 +
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/ef10.c       |  50 +++-
 drivers/net/ethernet/sfc/efx.c        |  15 +-
 drivers/net/ethernet/sfc/efx_cxl.c    | 165 ++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  40 +++
 drivers/net/ethernet/sfc/net_driver.h |  12 +
 drivers/net/ethernet/sfc/nic.h        |   3 +
 include/cxl/cxl.h                     | 291 ++++++++++++++++++
 include/cxl/pci.h                     |  21 ++
 tools/testing/cxl/test/mem.c          |   5 +-
 27 files changed, 1486 insertions(+), 523 deletions(-)
 create mode 100644 drivers/cxl/private.h
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: 211ddde0823f1442e4ad052a2f30f050145ccada
prerequisite-patch-id: f8f1003c82226bdbd967c0755c41d6602f35884f
prerequisite-patch-id: 8bccb1a750b00b11bfc347f3f2e1a162990f6275
prerequisite-patch-id: d9142fe7f0c216b3ea219847b9514b5997df63be
prerequisite-patch-id: bbba5b3224f0c6a0a331769652e5d6a0a3c28934
prerequisite-patch-id: 7c9fa56417d63fdb17a09abf932de8048c5b334b
prerequisite-patch-id: f418c5b2aea8b65520742f750f4b79f8cf4f0c90
prerequisite-patch-id: 9205c9a8b15f9571c6ecf9ef46b526ac8c9d9b33
prerequisite-patch-id: 7390649b7e6b0c0628de8403d46a5047e1e12417
prerequisite-patch-id: 70e95c74c1777b9e281ba54add0024746f5ff5e1
prerequisite-patch-id: 5a2273b31ad4755e14fc8bca28362f2bff54a909
prerequisite-patch-id: e9dc88f1b91dce5dc3d46ff2b5bf184aba06439d
prerequisite-patch-id: 0c5c038156ff28f810a63cd08ddab7867619af23
prerequisite-patch-id: 7e719ed404f664ee8d9b98d56f58326f55ea2175
prerequisite-patch-id: ad0c7b6122a0398a2654c92ab0c0527cb8a968c6
prerequisite-patch-id: c2829969f73d41d63b50983b92fef4cf72f87d03
prerequisite-patch-id: e1d0d259bd20b59cd9dff76880f6214e88c1fe32
prerequisite-patch-id: db84a3b9aefceef39764452998967f7aef0a3796
prerequisite-patch-id: cfb91a38e8c55201344eda86b730c0991ab8d79e
prerequisite-patch-id: 9889b65c6eff79af627158dac6cfe67f2b10fc21
prerequisite-patch-id: a4e751c90817a7d5016f7840f64185108fe4393b
prerequisite-patch-id: e90c5457d242847534b1c7f657541ecc7c72f23a
prerequisite-patch-id: 16f41d388ef33e355d90b9a38d1bacfa9f5740d4
prerequisite-patch-id: 8654e54082d6dba5d83dfdfb2bc2fd85b12d4a12
prerequisite-patch-id: 1afa817cac87367bea6af9d6eed8582b070d8424
prerequisite-patch-id: f5c386200140e5b90cbe5914dba04076cbb79d2f
-- 
2.34.1



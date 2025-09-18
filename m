Return-Path: <netdev+bounces-224319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C598B83BD1
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 11:18:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD73E1C21F07
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 09:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37727301008;
	Thu, 18 Sep 2025 09:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="17Vu/6/t"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013037.outbound.protection.outlook.com [40.93.201.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020062FFDF7;
	Thu, 18 Sep 2025 09:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758187096; cv=fail; b=feMLj1JMYf1lhOttxONV9ZjM3fFJtFSaxBTftdls6szoXy5QuE9LZTdQL0UE8XHJvPfwD9E7Y15pzHJdJft3pPsamyhncYRIMOd6q9lad2ojkafMD5qMy6TN48Lt2/smVq8kQhC8zqYJduiRzSlh93bhi7NOHUhPA59rIqjixgo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758187096; c=relaxed/simple;
	bh=BA1BPtcjvFDJ1vmXpcom/nqv1TymSj+kTLEn5MrIbOo=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J3VzCEsD1RLyg5GXzQIE+N5x73xdNOE9xIdiW8fY8ZZhze6NAZziUSntv9mA5yWuzpTTTot8amYsMiWSkKEuj0Rpnx0BqaR2NvK03f6e/Cd7E/QG3Ss1V28pytjG8jvcwKEpcWUxmMP0Z2NhrFhCPqa2gwQ4Is84pRk1mSPZlRQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=17Vu/6/t; arc=fail smtp.client-ip=40.93.201.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJvkdESjF3IC2A6DmZwx/Qy5rOojP0nHjNKk6kW+TwWvMvuj8WK8EFiunwzK6pbxXSmTIapEzYqbcC5lyigBjr1Va1m0r9Y8pu/nKdvhwIMm62kx8NGX1ceOZyh7jipHjBRcbHSFhlOWNabsw/jrppZbgGYxZ2Y2ioh4m48n7MGqjFWtv903rs7+KClizOpwVfyZr70HkMrqbRVQTE7CArsEWdl1x7qYbEPVBjKIqaX9vq/W3Uirzs7USCDuDqj1DrtGq5GfDqpZHvtnaqzIw+zehVrsV4Jnj0yosRwRGdnrYqOlaHDzr9nxToddnQOZpMzyY/n6cJsY0M0BUnTeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UFFMDMc/gREP+LIvfrYYiEa2+L9lE6GEIc/GEwLtfQY=;
 b=DZ6oGqTv3yPLNGATiE4NUeE/6O+I8PvUhQW4qbrXaYTPz96HsZzO3BdMm0qFkv/mGhDPvqcZhD2Z01ISjPd9meUNBUmqZSZkxLqJuYM4W6s6WnoBntyivSEFhy78qwRVNiNBf8+o2T8JJ/QQtJSk9qSfCPWShyFIOEpV9T7USdvesHed/i5eCpROgFf9s67PDtjv5mKJ7/2cln7aPzqeQLL7v4Fx758qXtqI3gZNKicJ7YeYUSCxJmput82+nKanmVVvNTnMEtCvb5OkCUpbSCgUI1s9On4opqyX8zJ9OamgfKS0UYP2gXRof67J5Watpf0u+MFhOFthHavMB5Vl4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UFFMDMc/gREP+LIvfrYYiEa2+L9lE6GEIc/GEwLtfQY=;
 b=17Vu/6/tceZXjK1634rraPZD6KO86QE5n/TxPhIC1S0NIJO/PNlFCe2BR8imp0uEkq3t5cCQgiU2CQgM04hEe/aw3vnr6pf3WYuIU02FY1Qy1bQzDAI6MuSYd8JMbTbuJtr7/Cth9ItzYNVmOKbATIltsQd8mOVNmdQ8fnhei6I=
Received: from SJ0PR03CA0142.namprd03.prod.outlook.com (2603:10b6:a03:33c::27)
 by MN0PR12MB6001.namprd12.prod.outlook.com (2603:10b6:208:37d::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.23; Thu, 18 Sep
 2025 09:18:06 +0000
Received: from SN1PEPF000397B2.namprd05.prod.outlook.com
 (2603:10b6:a03:33c:cafe::e5) by SJ0PR03CA0142.outlook.office365.com
 (2603:10b6:a03:33c::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Thu,
 18 Sep 2025 09:18:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B2.mail.protection.outlook.com (10.167.248.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9137.12 via Frontend Transport; Thu, 18 Sep 2025 09:18:05 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:01 -0700
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 18 Sep
 2025 02:18:00 -0700
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Thu, 18 Sep 2025 02:17:59 -0700
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v18 00/20] Type2 device basic support
Date: Thu, 18 Sep 2025 10:17:26 +0100
Message-ID: <20250918091746.2034285-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B2:EE_|MN0PR12MB6001:EE_
X-MS-Office365-Filtering-Correlation-Id: 2e9da729-4703-4eed-8640-08ddf694469d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T3dxR0VEd1c1WjBIVm9xZEhOY2tyZWpXYTJtZzRaVXc0RFE2NFh6ck9uUUFl?=
 =?utf-8?B?OFJGcTNuZGpVNGVBM3A3NEVCRlp4VDF5R25iWWl3NU5YNWN5UG1YNlVsTmdW?=
 =?utf-8?B?eVAvYThlUkViQjNNdTN4VkRiZ28yM3NYSVRINEdmSWFWd3ZiMzlmTUZaUEhH?=
 =?utf-8?B?VUtCNW1vMDRWVVB3c05SMUdIZkFYNmw5TThIQ2V6RkNYWGRTYTlYZEtPYnBK?=
 =?utf-8?B?S0NlT0RRZ1Btem9UZDdUcVZOSmM4S2Q3RWRURndLNGt3TzNXRFF3cGt3MUEy?=
 =?utf-8?B?NTlPY0h1cFN4ZmgxVDZNOHdLenFUS1UxSmtLb2xMbTJjMXB1bU9GcHRMNkhY?=
 =?utf-8?B?aENxd3BZR3BUaFJJTGNlTWJSWnlUU1UyZEZKUVE1TFBSQlU4cGlTeEg0eGx1?=
 =?utf-8?B?a2xIK2RrU2xJZ1BXcC9mc3A2ejRQN1lveUlabmVxZENIcFlKS0FiLzAyaFc2?=
 =?utf-8?B?VWUyaFVHV1prU2t1SmdXcEhxUEZVeTA1L1NnU3UzempxN0lKN1Y5MmZkWnc1?=
 =?utf-8?B?NmJFN012dnhoMTU0bjU5aWJzT2lsdjF6b0IvRzlpNFREOGJQOWJJcU9kQU9w?=
 =?utf-8?B?cjdjb2VJN2hhY24xemdXWUJsUUNPT1k4TysvWDBkUzZ4b0pFYXdTVHJRYzZn?=
 =?utf-8?B?azMrU1dBS1ZwY2dyNm9CeERmTGJ3anBNZ0pFSG9DUWtIMUJZNER6SUlUU3VM?=
 =?utf-8?B?b01nc2JWOG5tQWowRnhtZ1pHemQ2RjR3Wm5Dc3VqQW5RYTY3VWtiZmwrRXpm?=
 =?utf-8?B?VThmKzlJeEdsalpPTUU5TjVySVlMbUl2aHpLc3ZIRzY1R1FTUE1HWHNkYVhD?=
 =?utf-8?B?TnF6ckRuNWE3UTh5V3ZpNWZBMms4TWYxekNHbmFTWncvT2VETDZ2R3ZSTWY0?=
 =?utf-8?B?V3NNWEhOeThpdnVScEc3QVJlaHVZWGFaV21vWlNqWi9Ia216U2hWM2tieHpM?=
 =?utf-8?B?Y3ZRZUtiMlNhWnNhSkhtSXRKdlVqWHh2RGFlWUFoSGpXcDJvckx6STBkMjkv?=
 =?utf-8?B?cWoyTFVqR0pEK0tiWkxNS0dEZVgvMlMyem5PdmE2MHgrV0VWeFJ4c0xFVUlF?=
 =?utf-8?B?Uk5LSlEyWU5MU0hveXUrZnpwT0hVSUMyS2VUdG51Q1lrV3Ivc0kyRWVNTkx4?=
 =?utf-8?B?YmpwRVpUVm5Td2phYTZOUEhNY0x5NHpKc0NCbG01cEMvVWFtbVhXZDZhWUVE?=
 =?utf-8?B?SmtmRmVlVW1JVmxlNHpaeGhKejhvMkVBTHlRV3pQbXNNanpRL2hVbXdNMWNx?=
 =?utf-8?B?cngwY1lXdzlYWXlpcGk2eXUyeTFCTS8rQ0NTeHhtTHN5U2wyYjF4UUM3eXZt?=
 =?utf-8?B?aUcrVkpZNDR5TDdsVUtLMnA3Vldtbkh3RkRvbWJWd2J5RWhKTXhNYU8wVVZz?=
 =?utf-8?B?M0p3cHc5eFVyR3QwUGN3ZXl4Q0phRDZUNU5EL0lBaVRXQkNPcUlRa21QMVQw?=
 =?utf-8?B?Wkx5Y2lOSzJCaW9CRVZ6ekRPb2J1bUMrY2IzYVdZZ3FFNlRYdWlLR3kvKzNH?=
 =?utf-8?B?Y1N1Wmdrdm8wakhZOFJuU3NtS2phcE5GOERSa1Nkd3ZvbnB5c0x2UWxFcytM?=
 =?utf-8?B?blVuTnptZ0lkRGtRVWNtUVpBRmNrV2d5b2tQTmlzcEZlWnJ4VG5JWENNSDJM?=
 =?utf-8?B?SHZRUkFDRms3MmYvcmVnU1lwTzhiSHJDaWIyMDNza0F6NXRXblozS2xjVDJV?=
 =?utf-8?B?bFp4N1M4N2RGUzFjNHY1V0FvbDdZMXJNVUFpc1FzUGFQVjZnNlhiMW93eGd2?=
 =?utf-8?B?VXdtczVlK3hIM0dPZURORWo4aytyWnVYN0dnbzhxaDU5SFZzZlhXMlB1dFRX?=
 =?utf-8?B?WlhXOVEyRC9zMENKNmJJTmZuQTRwUmwrVWNScitQNUpVWFV2QktBQjJmaTlL?=
 =?utf-8?B?REtMYW15dnBMUzlSbUtCaGJ0RzZkVzZWTDFJVlVRYzFVZS9MTTh1RS9oUTdy?=
 =?utf-8?B?R2NpUUt6S2FqMlZMVlhkUE9kSnh4U29ZazdGYnIyT0t0UHdhclg0SU9ZTGRW?=
 =?utf-8?B?WjhlT3FDY3Z3PT0=?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Sep 2025 09:18:05.6157
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e9da729-4703-4eed-8640-08ddf694469d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6001

From: Alejandro Lucero <alucerop@amd.com>

First of all, the patchset should be applied on the described base
commit then applying Terry's v11 about CXL error handling plus last four
pathces from Dan's for-6.18/cxl-probe-order branch.

Secondly, this is another try being aware it will not be the last since
there are main aspects to agree on. The most important thing is to decide
how to solve the problem of type2 stability under CXL core events. Let me
start then defining that problem listing the events or situations pointed
out but, I think, not clearly defined and therefore creating confusion, at
least to me.

We have different situations to be aware of:


1) CXL topology not there or nor properly configured yet.

2) accelerator relying on pcie instead of CXL.io

3) potential removal of cxl_mem, cxl_acpi or cxl_port

4) cxl initialization failing due to dynamic modules dependencies

5) CXL errors


Dan's patches from the cxl-probe-order branch will hopefully fix the last
situation. I have tested this and it works as expected: type2 driver
initialization can not start because module dependencies. This solves
#4.

Using Terry's patchset, specifically pcie_is_cxl function, solves #2.

Regarding #5, I think Terry's patchset introduces the proper handling for 
this, or at least some initial work which will surely require adjustments,
and of course Type2 using it, which is not covered in v18 and I prefer
to add in a followup work.

About #3, the only way to be protected is partially during initialization 
with cxl_acquire (patch 8), and afer initialization with a callback to the
driver when cxl objects are removed (callback given when creating cxl
region at patch 16, used by sfc driver in patch 18). Initially, cxl_acquire
was implemented with other goal (next point) but as it can give
protection during initialization, I kept it. About the callback, Dan
does not like it, and Jonathan not keen of it. I think we agreed the
right solution is those modules should not be allowed to be removed if
there are dependencies, and it requires work in the cxl core for 
support that as a follow-up work. Therefore, or someone gives another
idea about how to handle this now, temporarily, without that proper
solution, or I should delay this full patchset until that is done.

Then we have #1 which I admit is the most confusing (at least to me).
If we can not solve the problem of the proper initialization based on the
probe() calls for those cxl devices to work with, then an explanation
about this case is needed and, I guess, to document it.

AFAIK, the BIOS will perform a good bunch of CXL initialization (BTW, I 
think we should discuss this as well at some point for having same 
expectations about what and how things are done, and also when) then the 
kernel CXL initialization will perform its own bunch based on what the 
BIOS is given. That implies CXL Root ports, downstream/upstream cxl 
ports to be register, switches, ... . If I am not wrong, that depends on 
subsys_initcall level, and therefore earlier than any accelerator driver 
initialization. Am I right assuming once those modules are done the 
kernel cxl topology/infrastructure is ready to deal with an accelerator 
initializing its cxl functionality? If not, what is the problem or 
problems? Is this due to longer than expected hardware initialization by 
the kernel? if so, could it not be left to the BIOS somehow? is this due 
to some asynchronous initialization impossible to avoid or be certain 
of? If so, can we document it?

I understand with CXL could/will come complex topologies where maybe 
initialization by a single host is not possible without synchronizing 
with other hosts or CXL infrastructure. Is this what is all this about?


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

Alejandro Lucero (20):
  cxl: Add type2 device basic support
  sfc: add cxl support
  cxl: Move pci generic code
  cxl: allow Type2 drivers to map cxl component regs
  cxl: Support dpa initialization without a mailbox
  cxl: Prepare memdev creation for type2
  sfc: create type2 cxl memdev
  cx/memdev: Indicate probe deferral
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

 .../driver-api/cxl/theory-of-operation.rst    |   3 +
 drivers/cxl/core/core.h                       |   9 +-
 drivers/cxl/core/hdm.c                        |  83 ++++
 drivers/cxl/core/mbox.c                       |  63 +--
 drivers/cxl/core/memdev.c                     | 154 +++++-
 drivers/cxl/core/pci.c                        |  63 +++
 drivers/cxl/core/port.c                       |   3 +-
 drivers/cxl/core/region.c                     | 442 ++++++++++++++++--
 drivers/cxl/core/regs.c                       |   2 +-
 drivers/cxl/cxl.h                             | 125 +----
 drivers/cxl/cxlmem.h                          |  94 +---
 drivers/cxl/cxlpci.h                          |  21 +-
 drivers/cxl/mem.c                             |  53 ++-
 drivers/cxl/pci.c                             |  86 +---
 drivers/cxl/port.c                            |   5 +-
 drivers/net/ethernet/sfc/Kconfig              |  10 +
 drivers/net/ethernet/sfc/Makefile             |   1 +
 drivers/net/ethernet/sfc/ef10.c               |  62 ++-
 drivers/net/ethernet/sfc/efx.c                |  15 +-
 drivers/net/ethernet/sfc/efx.h                |   1 +
 drivers/net/ethernet/sfc/efx_cxl.c            | 191 ++++++++
 drivers/net/ethernet/sfc/efx_cxl.h            |  40 ++
 drivers/net/ethernet/sfc/net_driver.h         |  12 +
 drivers/net/ethernet/sfc/nic.h                |   3 +
 include/cxl/cxl.h                             | 295 ++++++++++++
 include/cxl/pci.h                             |  40 ++
 tools/testing/cxl/Kbuild                      |   1 -
 tools/testing/cxl/test/mem.c                  |   3 +-
 tools/testing/cxl/test/mock.c                 |  17 -
 29 files changed, 1449 insertions(+), 448 deletions(-)
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
prerequisite-patch-id: ed7d9c768af2ac4e6ce87df2efd0ec359856c6e5
prerequisite-patch-id: ed7f4dce80b4f80ccafb57efcd6189a6e14c9208
prerequisite-patch-id: ccadb682c5edc3babaef5fe7ecb76ee5daa27ea4
-- 
2.34.1



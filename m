Return-Path: <netdev+bounces-178311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E5B02A768C7
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 16:54:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BE17F7A50B9
	for <lists+netdev@lfdr.de>; Mon, 31 Mar 2025 14:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 919BD215191;
	Mon, 31 Mar 2025 14:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="08QhvOjg"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (mail-bn8nam04on2063.outbound.protection.outlook.com [40.107.100.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B0552144B1;
	Mon, 31 Mar 2025 14:46:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.100.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743432379; cv=fail; b=ZKyppw1JynmFF5C64VVeArkt1kfuEI6K9UFp6LH3UCp+sUaF0zOp8tvin7+O2iPsmGFk0HLz77puq6iySXg+SWVspZZ6wherUGWWsx25H3Wm6sasgis/QVMzklDFDx8fniqhbsW8KvG87/A3LIIhfGGJkFc1kfC2+pZwb+3JVjw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743432379; c=relaxed/simple;
	bh=DTgkWpcPMPkhR8qsCyh87ln8jFr2D8Bzaveh1EAJUJI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HOw6r4Y1e33nC88oEXAemMmINfuesUkktEGl6zEw/rDJwl8kzZM1iL4fQu7U1K7k+4imKhVJXxEFA5+V4zEqoNQLCcJil4CkeQz7lDaplBH0xdF7JfMzniJDhR8Xn5EkH5e6tw7EXbx+96N6HGMjcmuZ5sGwN5QM9brvxj0b7X4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=08QhvOjg; arc=fail smtp.client-ip=40.107.100.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q+XezQ+NaMqonIQU6nrE2hZKr+gBp140VJBSM0F/TBCr3/4y8MDpBTsoCRaeulnmTJEBvpHa2JoK3GSJlMxtHYCPAqf4f2+RMFdcm1CKJQUSqu1ldEVq68oettNOvcSOa4KKVLyt70KJvleCN+YeG0enmrjMFPChH4p9p3cs+Q0bn/bsgZR8Tn5lksYv4hd0mMtvgEOpWe8kJvXkgc3sTuiCH9q0jYNqg0sBYZOp+d+HZbkk6QeEEnT9I+O0EUxYQzt7hXCi+Ln2R0+W98jet4MmWH7U9a8wDhzOEOo3+Abft0DlXLiVySfZ37E/kl+bPcn37mgEo264KKeyQOywqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1fzBpHMag2ECc4VueB7qlZ3vRs4bsDXufyrMlo9GM+Q=;
 b=QNr3ZLOap6qlfK18uLtxdwmsK+vdHzgm7lODvf4BJPcYIEisTb+nA4Kky9e8PB8gjjlCmuprFqTbQ0mfNYG5v+wU+MY0f+AkaFoO0IDkJ/pq0x6VcYOeN6bgd3m7iHnsPl/77MQLKSfyCdQi2SeRTw5SzEBFGUyG2x3hjJD5fDiN5vH9XMvKNpUYTYUBuCqnJ2PW1ZHdPfZR8MevG+QXfHNUYMDO5/htsnUwpqf/g8JvTFYdqV5KdM5pwKFyo7Hb64ZzADy2DOa8ixq3hj6JQVn1CldMG67gFs9gNLZebnihe6tvUyfW5qPVsB5m6Vrw3er55Y6h+/e0/Lp0U/1y9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1fzBpHMag2ECc4VueB7qlZ3vRs4bsDXufyrMlo9GM+Q=;
 b=08QhvOjgEWz7LyojLK1eTJO1kb8sMf8Zc7LG4l5dS684R7p1TNQHYflwj+7AeTGHd/TEe10Vls1Ri/wWVW4aEQiBS1gwYjPskIW+dSPxPzJx3N2ErRbrCHC+guhXLcS7rXO1S4TecbbHT/cyxkdIjNEjMetVWuFmZwYwB6+M4ao=
Received: from DM6PR08CA0056.namprd08.prod.outlook.com (2603:10b6:5:1e0::30)
 by CH3PR12MB7690.namprd12.prod.outlook.com (2603:10b6:610:14e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.44; Mon, 31 Mar
 2025 14:46:10 +0000
Received: from DS2PEPF00003439.namprd02.prod.outlook.com
 (2603:10b6:5:1e0:cafe::f) by DM6PR08CA0056.outlook.office365.com
 (2603:10b6:5:1e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8583.39 via Frontend Transport; Mon,
 31 Mar 2025 14:46:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003439.mail.protection.outlook.com (10.167.18.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8606.22 via Frontend Transport; Mon, 31 Mar 2025 14:46:10 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 31 Mar
 2025 09:46:09 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Mon, 31 Mar 2025 09:46:08 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v12 00/23] cxl: add type2 device basic support
Date: Mon, 31 Mar 2025 15:45:32 +0100
Message-ID: <20250331144555.1947819-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB04.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003439:EE_|CH3PR12MB7690:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eaba81b-e398-47c2-12ad-08dd7062c6f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|34020700016|36860700013|82310400026|13003099007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?a3U4QVBXT2hCUHBvWXRRM2FucklOMUQwVHdFdENQTUR5ZU8zWloxbkJ3OW1Q?=
 =?utf-8?B?N1ZCUFc2TDZuSk5POHhZcTdhNGg4aXBINUxpSlUxazVYTkxxaVpMaWVyNjI2?=
 =?utf-8?B?Z0hFQ0cybm1FRzVuditwUGdIdktNUXhOSk93UExTem1GZWgwUHN6NE8xMlF3?=
 =?utf-8?B?Y25yZmR1aXppNTA4b2lUYmdrUlNVT3FQdHF5U2J6c2xQamhJd1lYUGFVTDJD?=
 =?utf-8?B?MTZRVFFtSGhaUWJmWVRBcmZRUUp4c0FmRlZJUElkdVlIMHBCbDhuc2FSVzdz?=
 =?utf-8?B?NzZhNnBTUmNJR0J3NmNrR1I0aWVWUTRkRjhGU09Sby82WjJLZ0xVeEJsVTFk?=
 =?utf-8?B?MTVTay8wcHNVdVljZ0VORjhacGl6SEpSeEczbnpJRjJRTFZjOE9wK1pNa0xB?=
 =?utf-8?B?aFBlKy93a0hLM0hMRWlHbFgxc1V2UXl6QzJacVFxUWRMbUI0bHg0a0RQbnN6?=
 =?utf-8?B?NnA0QW40MlcrR1ZPYllrMXRzT0tVNFN3WVJqaVBqZEdQTGZxcEU3QndER2xk?=
 =?utf-8?B?dXpxb0FTdjVqWFNWa2dXaXRzTnhHQU9XNVd4VXJISEhqZWdzaERjMW5kRDhJ?=
 =?utf-8?B?cDJ1WEcySEJjaStpelhydkRxOHplOGY1YzBMMXJIamdRUDhTdU81U0lJZ1hI?=
 =?utf-8?B?Ty9oeDAwaHhxOG1zMEhFMUlkU0xHUmI2anNxQUg5Y0pqcXFFWStiSk5lZHVH?=
 =?utf-8?B?SFIyWHVCNkM1Nmxsd092YW4vSEtaV1lOOFFuekxEZFNaMVZ5ZUVlMDNhSElX?=
 =?utf-8?B?WXFGVjZwOG9GTTJHcTVHWmVWRWNPTEl0d2k1ZllaalN2SVhvUmtCa2MwemQ2?=
 =?utf-8?B?Uk00MjIrRmNyTDhQS09LWm4vZ3RQa2VadDBOS0NuTkhTck14ODRUa3NDL2Fh?=
 =?utf-8?B?eDl6V2lIbVVrUmpRdHBCKzNseWhwcWI4SS9IRHJ0QTlNODlJMURZZHJKR1J0?=
 =?utf-8?B?eFh6Vzl4aWNoTXNBakZHTDErR29BMnBaTGU1UGk5VFg0N0FaVHBZTzBzYzF6?=
 =?utf-8?B?WkhmNXBJYkZYbmRjVWg0dEZvdHRXRHNxcjFOeitGRGRUS1BZZmRNcWQwUUJW?=
 =?utf-8?B?K2kyM0RreVhPSThpNWlQZnh1VHpBYXJYMXhRT2RTMHd4d0dpZ0lVS0hXanp4?=
 =?utf-8?B?aWJVVTRBNldyMjJ6amNXNStKcTV5d1N2S0dURzdRWG1Bbk0wQ3BuN1lGMXZX?=
 =?utf-8?B?R0pWQm1uSjZVN2dnbllnRzBCOExoVTM1QWE2MVpIS1E5NHliU2dueTZWWGVQ?=
 =?utf-8?B?ckFiRXk2NjhZSEl2cFZVRUVva0pDQTVadmdwZENDTndZYlIraE5JNlgxRXFp?=
 =?utf-8?B?a2RJUkFxRUl6eXVHTVlIdUJ0ZlJ2SjIzTGhKWHVWSDR4NTl4eG9kYzdwR0Ja?=
 =?utf-8?B?TFlJVEdhQmRnNjcwRWdnMFF4aFhQSnVoK01mNGVkRXhsWU5uY1Z1SnJCcmVP?=
 =?utf-8?B?elpKZHQrZ3RLR3ZrMk5QOE9GWEg5bjlwRkxSOEdpbWxldTBXUnNrK0ZqTzVr?=
 =?utf-8?B?MEQ2bzhJNEdIdDluc2lBYmlhWVYwRkpzTUVWdEc2MCtxRTVFNlg1SENUT3hD?=
 =?utf-8?B?SS9aMVBDRUV2a3RiWWR3bEFMVGdWTjlRSWxrc1lBY3MxRWxhT0pMTjlURTNK?=
 =?utf-8?B?ZU9zeTZWT0JQZmxBQ25UOEYyQy9hUjFMYUsrNmpWUTdzRmljTHVaZ0RoejRl?=
 =?utf-8?B?SXhucUg4TUQzMnVTc3BnYm1DVzZRVFcyR25tTUVsakw5TUpwNGFYMktDMCtC?=
 =?utf-8?B?ZmhJRnZnT2V3T1NzT0VHNkJJbTBxa1hpWkJtbE41U3NJRFpIM2JzQ2VrUk9O?=
 =?utf-8?B?RWUxbWdMSWlPMlVhb05MSVVvSG9DMnFrUUI5Qm1ZR2txYUt0all6Z1NkZUFu?=
 =?utf-8?B?M1pxZVlqZDc2cEdQVktsRzM2Qks4SjJQZmhtTURTa2hNUFhZaDNRS0lHODQy?=
 =?utf-8?B?V3NsaXU3WlZGcGhOUWtuZEorcVNCcmI4NzlidXBjN0VqNkRLVHRIUmFZdzA0?=
 =?utf-8?Q?LDNWHE6Gt71W2c7IKJlu/opeGp1HiA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(34020700016)(36860700013)(82310400026)(13003099007);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2025 14:46:10.2858
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eaba81b-e398-47c2-12ad-08dd7062c6f9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF00003439.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7690

From: Alejandro Lucero <alucerop@amd.com>

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
 - Fix robot compilation error reported by Simon Horman as well.
 - Add doc about new param in clx_create_region (Simon Horman).
 
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

Alejandro Lucero (23):
  cxl: add type2 device basic support
  sfc: add cxl support
  cxl: move pci generic code
  cxl: move register/capability check to driver
  cxl: add function for type2 cxl regs setup
  sfc: make regs setup with checking and set media ready
  cxl: support dpa initialization without a mailbox
  sfc: initialize dpa
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

 drivers/cxl/core/core.h               |     2 +
 drivers/cxl/core/hdm.c                |    83 +
 drivers/cxl/core/mbox.c               |    28 +-
 drivers/cxl/core/memdev.c             |    47 +-
 drivers/cxl/core/pci.c                |   115 +
 drivers/cxl/core/port.c               |     8 +-
 drivers/cxl/core/region.c             |   413 +-
 drivers/cxl/core/regs.c               |    39 +-
 drivers/cxl/cxl.h                     |   111 +-
 drivers/cxl/cxlmem.h                  |   103 +-
 drivers/cxl/cxlpci.h                  |    27 +-
 drivers/cxl/mem.c                     |    25 +-
 drivers/cxl/pci.c                     |   118 +-
 drivers/cxl/port.c                    |     5 +-
 drivers/net/ethernet/sfc/Kconfig      |     9 +
 drivers/net/ethernet/sfc/Makefile     |     1 +
 drivers/net/ethernet/sfc/ef10.c       |    50 +-
 drivers/net/ethernet/sfc/efx.c        |    15 +-
 drivers/net/ethernet/sfc/efx_cxl.c    |   162 +
 drivers/net/ethernet/sfc/efx_cxl.h    |    40 +
 drivers/net/ethernet/sfc/mcdi_pcol.h  | 13645 +++++++++---------------
 drivers/net/ethernet/sfc/net_driver.h |    12 +
 drivers/net/ethernet/sfc/nic.h        |     3 +
 include/cxl/cxl.h                     |   271 +
 include/cxl/pci.h                     |    36 +
 tools/testing/cxl/Kbuild              |     1 -
 tools/testing/cxl/test/mem.c          |     2 +-
 tools/testing/cxl/test/mock.c         |    17 -
 28 files changed, 6189 insertions(+), 9199 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: aae0594a7053c60b82621136257c8b648c67b512
-- 
2.34.1



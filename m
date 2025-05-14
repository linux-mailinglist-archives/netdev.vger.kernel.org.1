Return-Path: <netdev+bounces-190415-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB5FAB6C99
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 15:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C8B53BB129
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 13:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42F622777FB;
	Wed, 14 May 2025 13:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="AZHdJOFZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2057.outbound.protection.outlook.com [40.107.243.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C54128819;
	Wed, 14 May 2025 13:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747229281; cv=fail; b=CUWCvizgQwQUgkTTieQDT26etzBciPrEdeKihezoO4qp0sVfx0XPURhnyZWurSg8tmU6ckmehxVnpxujxoye5WGJiEXu2IXXUl/d2Cqfb3sD9V+fZmM7mliTlza/u6WmW9fq4c4qa4rHeYhpMXB+11THZesKPLwDLBZRARm/P8c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747229281; c=relaxed/simple;
	bh=XtIbkjdzYQlg56bt2qquQVJnuHa6LWtdAfklc28RqFM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NowhnBp3b0uxM6/20z8LC/ZS60hF5YY+pGlcqGqyrql3d5ZmlVDKgFjgx8Ycg+dmA/NieSNFAyNPGgxS9LAiILkMiYRj8yG+zKsDXjf6DCheIfl5ZkVmpYDD37ShnfB/HLN1EcApRTq8S9rMZ+M6yWQ5loNc3I4rYPLiTfjkM1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=AZHdJOFZ; arc=fail smtp.client-ip=40.107.243.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H0oKr5zt/dUYc9E6pYcOBzFmGYixZDLlAqaoPoKJ6Ttbvatc+NEE7EfgoAyowYfA+HG8V2PBf7x94uxl5aqWEtm+Cyld80+uqdL6Il02CVzCbbvCbB6XRng8s96GmT75KCAu8cQKhUmXWsLt6H/bPrCwGtgP7Q5D4NFKC9ai0EdxKELNWgoF3DdkOiWqwThknFP1EzKF/Dteqykl2+Ut5BwYKBcImUAdcIibcVyMPkAxI+ckx6MHjqPmhvlWPVQdOO9sNEuWlQhWtggAkCnURrPXTQmX8L7fS+nf4W+OX277CmAzbRuaJA6odEnoNIli3aVfFog+86DSBzt+vPnRDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P7SzvdO/7/cgBoy5NfRCEi/MMRruUv1Q1zCjXoWkLsw=;
 b=huSJyT9lqACPvZmJ2DmyMoH5D8adS0V+YP0nHjoIwYW7IjpQmhMPRHw94Kt6NoVs0nT2LRtacwwRIvcZHvyMwM+ksoUjzUCQtZHecgG6mFKKR28QstYnDHD6SoEKp/y/yk8N64+OsYojIi6rhH4zPPczP+wDpDaG9RsbT4W0puYrVz4uIzD7eSAHuTjUNvwCfgTKU7n1YwC/Fdo6OsB0ZwvGVyeWsykHBVG/gOtN1siSdQifIwNZrkSfMeW1Ez1scwqntTLyY01luk2sfWvXlYFfw12GTAo+GBs3Kz8pZU8qvZ04bokfTCTvrzLRA4ADaJ3Tbd+pL5yG0fMQfmN6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P7SzvdO/7/cgBoy5NfRCEi/MMRruUv1Q1zCjXoWkLsw=;
 b=AZHdJOFZkOcwKjWPbdtDU2eTDH5osCdHYJV83496TE20tVObjzOl5CFliZIhjCCSD+ml6YoseRnSRCczRZzXIlqldYFEOTiFudTyY6VXwyQDUhZISCb8h0j8Wh/ymTwBwIH/9BQuCe/mFfUOacaWGFlKmR7bOhm3rqrc2QtEo+Q=
Received: from BN0PR04CA0071.namprd04.prod.outlook.com (2603:10b6:408:ea::16)
 by SN7PR12MB7321.namprd12.prod.outlook.com (2603:10b6:806:298::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Wed, 14 May
 2025 13:27:53 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::63) by BN0PR04CA0071.outlook.office365.com
 (2603:10b6:408:ea::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.30 via Frontend Transport; Wed,
 14 May 2025 13:27:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8722.18 via Frontend Transport; Wed, 14 May 2025 13:27:53 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:27:52 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 08:27:52 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 14 May 2025 08:27:51 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v16 00/22] Type2 device basic support
Date: Wed, 14 May 2025 14:27:21 +0100
Message-ID: <20250514132743.523469-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Received-SPF: None (SATLEXMB05.amd.com: alejandro.lucero-palau@amd.com does
 not designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|SN7PR12MB7321:EE_
X-MS-Office365-Filtering-Correlation-Id: ed4bc663-b4c9-4513-6dbd-08dd92eb2176
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|1800799024|82310400026;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZmliVGtHTHpaYUdNUUdmWUZMdFBLaXBRbzdSTHhNZ1psOE56ZVBQM1lMUjgv?=
 =?utf-8?B?bGJ3TlFCMVRYNkwwZlpMSEVhbUg1TDlNckU0YjhScTFWbEFrdkpxRTUrT3F2?=
 =?utf-8?B?ZFVvbEFxNC80MG1OWksxQTRhTHRwejRLQlFUNGRqZncvbkdsWk9PelRyL1g4?=
 =?utf-8?B?eVJvVElqTE9JUm1LbUh6VDBaSXVYYUpOcmNyaGU0emNCQThoTVNac3BPV1FV?=
 =?utf-8?B?a3ZURXdabDB5MjM2N0YyN2xRNnZ0MFBSN0ZpS1V4UmRlNGRWOGNhSzBOVi9G?=
 =?utf-8?B?VXdKcFlqdFkrTWhKTy8wQk1nMU5ROVlWTVh6R003Y0RnYllRU3FjL0d6R2po?=
 =?utf-8?B?ZTgrbXRJUXVuZDlOVXBINnE5aDlUaEpBN2N2Qkp0QWYvOVdJdkJ2cEQwbFBw?=
 =?utf-8?B?WlZ4c3hKZjVQczFLUks3U2p1NGphNElzSnVIYy9ud3Jva2Q0WDlJQlh1aGxp?=
 =?utf-8?B?T1NvZWdmMnR5WUxzakVtSFVnKzJZY0NSSzZnK0sxbldKZ2pUSWNRYzF1MW9F?=
 =?utf-8?B?V3lKbC9DVkdsVXRyRVMvOEtpNG9PRjdEc0oxVU1HSlRoSGM4bWgzTWtQcklW?=
 =?utf-8?B?ZEZsblJBbmFHSTVna1Qyc3I3bnl0eGREbXZOUXVXaWsxdktDMlFBYWQrYzM4?=
 =?utf-8?B?YUFsK05HV0xaV201aUlFdVJxeC9DeXBXS0VldVM2VVJsOU5MT3gvMFR0dlgw?=
 =?utf-8?B?a2JobXhYcVYyTkplUElEUTdMc2thNC9kdWVEeFc4Y1pac2phWndSL1kyTWtI?=
 =?utf-8?B?YkRGMS81WVlTSkhucUE4b3ZoOXdHVFp2ZHk4TjhqbXZDUkRCSTNnOG5VTUVQ?=
 =?utf-8?B?ZkhtTVhxTTNUN1k4S1dEem9adDFsOEVKRjFTYm1wVEV0WjFJZmQvU3NMcEdt?=
 =?utf-8?B?a3M5My9Db1NHb2EydXRyNThka0tDMzN4c0hvVGdMTU1RWE1YQ1c2cG9wb3Av?=
 =?utf-8?B?OHBCRFZlbnBEQWxtRk0zcm12ZnBjRnQzM3Y2UVg5ZHp1dDIzM1lHS0xLWkVi?=
 =?utf-8?B?ajI1d0hjZlNLcEEvQUFpWi9NRHRVZWwyY0lySENLbnpUSFYycnlEZ3M3QzFO?=
 =?utf-8?B?bjJlcGhZZEtoQ0RRcDBPWStyNkRGOG9ITDJ6NWpVOE84SnhuMG1BbFgvNEZh?=
 =?utf-8?B?VjRBRkJnOUpSTjYrR1RLZ21oQjYvRkRsTHVMNEliYmE4cGdyUzN3b2g3elRP?=
 =?utf-8?B?NVhxWktqZWViQ2hIVm16ZEtiZm1uT0tmYzJKWVFBUDErWmJiWkdCSmZkZVBp?=
 =?utf-8?B?aVZYY0g0RjlLQzR2eEJUSjhsRUxuMnlCNHB1OUNiRlBGMGxmaGZidzROTFl6?=
 =?utf-8?B?YjhMOVFSTTBYcmR2QUg2RTdNdmIwd0prSGphdEVqcWs0aTdBcENQWWRuelI1?=
 =?utf-8?B?OS9lM1htekwvanJRbjFsc01PTFhiSmNxaFRDM0pLUEtHZWJwTnhKeE1mVm5x?=
 =?utf-8?B?Y2hoOWZrMTMxS2NYbzVNamtsNlpjYkNCMVZaVWFTaVRLYWsyc2hZQzVHTXZG?=
 =?utf-8?B?dU02Sk5zdmNWZjV5Zi8yYmxtS0I3SUtkMlpSU2JHMlNXajBYTTJLandhME05?=
 =?utf-8?B?Um9oeFVjM05ubzZZQjJWNDMyUDc3TmJWY0YwOUxYZGJsZUZUUjBEYmo0dDd3?=
 =?utf-8?B?M0tHRU40WU83RVRENUlSRG1COXRQaHpDcWQ5TVByUjA5anlnaUM5NE5GUkVH?=
 =?utf-8?B?YTRZQlpTWERKOVdtaUxxcExnYTA3MlZFYi96ZVhXRWVJSnZoSlVSUld3RkZ6?=
 =?utf-8?B?M0llVzdvZ2ZJUVBQRnZyQWR1K2k2NVhQVzlQdUNBMUZhOWpXZnp1VU5QYWRl?=
 =?utf-8?B?cCswRzcrUm5BdCtwV000cFVQb1N1VnNBQXkrMWJQaDNabjNER0dyQ013ZnRo?=
 =?utf-8?B?Uzc1TmQ1NUhPNDBpTC9vRnpXRHp1OTRWWWNMMEFXOGd1TGQrcDZVaFNLK1B0?=
 =?utf-8?B?NDdPbVNTeVZWSkF0bVBnOTYvSHgwNTJ2MEprMG0xM1JzSXorS2N4aXkzanp4?=
 =?utf-8?B?VjZ5ZGx2dzc1Qm50aURlR0twQ0txeS9McCtlYlF3STd2eUIwVDhBK3BoYjR0?=
 =?utf-8?B?M1o0VWdFNFB0R2xSN3gxU2xEK2ZSbFUxM2MrUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 May 2025 13:27:53.2420
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed4bc663-b4c9-4513-6dbd-08dd92eb2176
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7321

From: Alejandro Lucero <alucerop@amd.com>

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


Alejandro Lucero (22):
  cxl: Add type2 device basic support
  sfc: add cxl support
  cxl: Move pci generic code
  cxl: Move register/capability check to driver
  cxl: Add function for type2 cxl regs setup
  sfc: make regs setup with checking and set media ready
  cxl: Support dpa initialization without a mailbox
  sfc: initialize dpa
  cxl: Prepare memdev creation for type2
  sfc: create type2 cxl memdev
  cxl: Define a driver interface for HPA free space enumeration
  sfc: obtain root decoder with enough HPA free space
  cxl: Define a driver interface for DPA allocation
  sfc: get endpoint decoder
  cxl: Make region type based on endpoint type
  cxl/region: Factor out interleave ways setup
  cxl/region: Factor out interleave granularity setup
  cxl: Allow region creation by type2 drivers
  cxl: Add region flag for precluding a device memory to be used for dax
  sfc: create cxl region
  cxl: Add function for obtaining region range
  sfc: support pio mapping based on cxl

 drivers/cxl/core/core.h               |   2 +
 drivers/cxl/core/hdm.c                |  86 +++++
 drivers/cxl/core/mbox.c               |  37 ++-
 drivers/cxl/core/memdev.c             |  47 ++-
 drivers/cxl/core/pci.c                | 162 ++++++++++
 drivers/cxl/core/port.c               |   8 +-
 drivers/cxl/core/region.c             | 432 +++++++++++++++++++++++---
 drivers/cxl/core/regs.c               |  40 ++-
 drivers/cxl/cxl.h                     | 111 +------
 drivers/cxl/cxlmem.h                  | 103 +-----
 drivers/cxl/cxlpci.h                  |  23 +-
 drivers/cxl/mem.c                     |  25 +-
 drivers/cxl/pci.c                     | 111 ++-----
 drivers/cxl/port.c                    |   5 +-
 drivers/net/ethernet/sfc/Kconfig      |  10 +
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/ef10.c       |  50 ++-
 drivers/net/ethernet/sfc/efx.c        |  15 +-
 drivers/net/ethernet/sfc/efx_cxl.c    | 158 ++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  40 +++
 drivers/net/ethernet/sfc/net_driver.h |  12 +
 drivers/net/ethernet/sfc/nic.h        |   3 +
 include/cxl/cxl.h                     | 292 +++++++++++++++++
 include/cxl/pci.h                     |  36 +++
 tools/testing/cxl/Kbuild              |   1 -
 tools/testing/cxl/test/mem.c          |   3 +-
 tools/testing/cxl/test/mock.c         |  17 -
 27 files changed, 1413 insertions(+), 417 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: b4432656b36e5cc1d50a1f2dc15357543add530e
-- 
2.34.1



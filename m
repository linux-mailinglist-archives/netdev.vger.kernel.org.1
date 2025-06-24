Return-Path: <netdev+bounces-200664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 328FCAE6821
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:18:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A55043BA3AF
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 542CC2D23B7;
	Tue, 24 Jun 2025 14:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="v7ozcaOZ"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BA9A2AEFE;
	Tue, 24 Jun 2025 14:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774458; cv=fail; b=F1OsH5vkI0ZRKkF6gJOTTSi3i92GhDNpj62dgeOnvA7HZdHdV98jCqRgKBqAfmXEodY2BYggEFgApDFeEhfZj2UJMt8UncV2Mhrj0aRA69SXr+F2qlySc4nfuF+P7/ALCjpjJYTlbKwFh1Elmh04rYBGkLRm+FWTssZeDom347Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774458; c=relaxed/simple;
	bh=9uM1S5JnbY9DOlK4dEq3WC6bVPZELoQnvI3YvMiedvc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LbFk6m/ssuoZmLvTIrk/7aAyIoJTV7/Shep9yARABhitIlzVGhG68c/qUCH7jQv/KunOoH/5WBLwSsvwr1RJKw0Yr6u24SWk4LLVPyOZcySjaRP+bJ726tCT23Hc/XotsBBYn6nZowXXjWCC8g6SKQoc32lGWtz0RQhqiYQSL5g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=v7ozcaOZ; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sMDaWUUIRVqOwg5tvYnJAba9IoAfelEfo7aSyifjzonFQo/Z1rdZ6E321dxnGMF1Tc+Fh3pWzorY8TvhHvnKA3g2/ajjd2H64oO1xxbmI0XIQnVaRI6Gb82kaTIympn9FguMPHbWY1evcKxrQwEIabkjmXJ1igDbWXPJsxZ4eb18S4oRzjK6omJkkMxBZf6ZQiv7Z72eCfF81pMvJlyQs+3m/gh+Q965fJBQsZV9EoUwpblJa9LShoUMW8l3TsOwa9yBpCxujXg3M0WRh6t7UGBM0VZSszGFw4EinUloIWg6HPcbppiIGNa8qywd/mVWY+QWZjB78dWvZ8DEmtZdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xe33k15nWC8TFUbF8KkuA5zRM+mbsBDTn/z8AkJjknE=;
 b=UdReNjw0DzQ43j/ZRDr2bRk88hIIrL6CeFgp8At8JnYN6MIFjHLquf1qRqJfk+RIuYOI17MM2158SfA1ECPx0HXX/HakQkFFkletaNwb1GqLUzrBnSjSxZBeqD1+NPT7fy0Z1T/Om0R80ENno5w63dBJ+dCgx1ClpfbAjPpCrG2L5oXnZoQ5S7t2NjqatPYN4sxgY75IlYKVnpVbYIV8idOqi/KwZfZUhBYSZRQKMSBsS8ERUGkTeWPwRLSvdYTkHGrXydnJ1wQHRV3gDQZGFvLjxWiq5//9apoxGAzcxcnYn46RAC9y8pO+k+TOGEfaDiDTA6n0VjEfEhvSY18Olg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xe33k15nWC8TFUbF8KkuA5zRM+mbsBDTn/z8AkJjknE=;
 b=v7ozcaOZ++mU2cCDfiUOc6XDwyIgeT1TAiU/t0TMIygVMwVYYtMHL8MIgzLakLMP+QKl3pYiH8MtLIiVDza2K1jBJ2lee455BxUTVKUdx1DnkNFXVdX1JmGhGzUKMniyUY2Bmo0YqUFYX8WBY1KHCITIixtlZv5pgO6OHSWtY0g=
Received: from SJ0PR13CA0156.namprd13.prod.outlook.com (2603:10b6:a03:2c7::11)
 by IA1PR12MB6580.namprd12.prod.outlook.com (2603:10b6:208:3a0::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Tue, 24 Jun
 2025 14:14:13 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::2b) by SJ0PR13CA0156.outlook.office365.com
 (2603:10b6:a03:2c7::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.16 via Frontend Transport; Tue,
 24 Jun 2025 14:14:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Tue, 24 Jun 2025 14:14:13 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:12 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 24 Jun
 2025 09:14:12 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 24 Jun 2025 09:14:11 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dan.j.williams@intel.com>, <edward.cree@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<dave.jiang@intel.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v17 00/22] Type2 device basic support
Date: Tue, 24 Jun 2025 15:13:33 +0100
Message-ID: <20250624141355.269056-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|IA1PR12MB6580:EE_
X-MS-Office365-Filtering-Correlation-Id: ecdf6235-41ce-410e-51bd-08ddb3296554
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?bEFuaDhscDZESml2S0UwemdaZERzQ2dvNlVmTzNhRlphbU10NmVmN1FKdkk3?=
 =?utf-8?B?UFlLblNZekdXa3VSOCtlNXNVYTJpd1YvOW1oZEFGaGZ2NVNUcy9UbzdoZ0R1?=
 =?utf-8?B?ZGI0c3cydDRGSXJUcUNGWjN2cFNSbElFSE8xVCtJSjFRVGNTMzFCTGlOM2Ry?=
 =?utf-8?B?U1VXUHIyZ0xia3M2VDVkZHlsaytrdm82N3p6TzhxcmZROUE2UnBYVGFWTXlC?=
 =?utf-8?B?WkhmMlhLbWlXQkpicEhjOG1ZUXNFVWhkamhsNHhyL05reFh6eXg0RG9BYU5r?=
 =?utf-8?B?T3JwV2g2ci9Yd2NjT3o3N0dmcDd4MFU3eEJGTkRiSmJEU1YvbWlTR04vN0hi?=
 =?utf-8?B?dThCL1F6b09DSzUwcXJ1czQ2MnVQMkFlOXBRUVU0Z3RHdWltNUNsSTN1T1dj?=
 =?utf-8?B?eUo2d3NQRWppNHN6aDM4ZjJLdWxta0dnbXBHU1lxdnZrejhhSDVuTGxXeDh5?=
 =?utf-8?B?RTJ4YTVjSkh5STZCVHltZEhHRG92T29ZQzZQNjlhRmNCeEE2Y1lTd0ZvQ241?=
 =?utf-8?B?c1VHUkV4L2lRV0xxM0dvRlR6ZEU4bG1OaEFFZE1OWnNkMTduK0xJL1R6VGJo?=
 =?utf-8?B?RHlscXg2dU81VVlJdDNXdUNac1h0YU5YTERtSUlvQjYxM1JZd2hDT3ZYeXIx?=
 =?utf-8?B?bmorV3hMVnpuWUF3M0RWaGRIbVlPWFBKc29NTWRoTHhhaTM4M3RRZUNOT0Q1?=
 =?utf-8?B?Y2FpRDk5aEFidEVlNDFzanJMUVNjajJNanN0V21SWkREVUF4TldHMVhjVExL?=
 =?utf-8?B?SlZDSTBzd2ZRNTBvRmJlbHNJb3NqVGd3ZEExcFoyNUwxdHUrOVIwSnJzTDdw?=
 =?utf-8?B?TDhQZTZlVmlYencxQ2dxTmt3akdZai9XUjMxTk1ETjErTjhRYXJ2bTRCWlZq?=
 =?utf-8?B?ZmphTisxUjZqQ1JCampDM290RDUyWTVQWUFFU1FqWS9lVHJTeVE5UnliRFpq?=
 =?utf-8?B?c0JEYm8xYll4MjgyWnlnaVVRUU5IQmdUMkJCY0p2NjZWOE5VVkhFelp5dmtN?=
 =?utf-8?B?R3k2djM5cU54UXcrb1Z4RG1jRHBOTUhzSG1va1MreXArSFhVWkRpdThDeER2?=
 =?utf-8?B?RlI1eGo4T3IwbDNaZ29BemY3MmRZWGdiWjFLTWlpb1Bmaklwc1JKd0JGd21P?=
 =?utf-8?B?NHZIVWpzSmJZUXRQSXh2eWQ1M28yT3lnYWs4SmNJZW5kWElxMVJPZHM2Vldh?=
 =?utf-8?B?RXdQdC9OeGg4YnAvSmk4aXQ2TThBeWNrYTEySFdPQ2o2VDlhRCtMWTczTEZS?=
 =?utf-8?B?SnNHd21tVlZKd2EwdWc1eTVDVDFzQWtjWjBvTUdiTndKbjRTaXJuK2o1c1BU?=
 =?utf-8?B?Y0sxSDUzUFdGMVB0dkFEb2o4aTJTOEJTc0xRYWdoQytreGxjNFk4QlZENnZa?=
 =?utf-8?B?clU1ODUzbm4xYVgyUnRpbU9aNUtydVQwODlLZ0xZMForL1RHTVdKWS92MHlt?=
 =?utf-8?B?RncwMngyTTJ3S0FtTDdJdGdMOWhaVjFZSFM2K1NtUXJWN2taU3FIUDJwL0ZP?=
 =?utf-8?B?dFQ3aTJoOVdGRThycWdjaFBQUmFkTjg2bDdhTlhuT2JGeEdUVnhRemJGb2tm?=
 =?utf-8?B?UEdCc3lCeFQ1VjNrSlNzM1lLWFQ5ODlsZkdrS1BoZ1kwdnJBbDA5S2tmZkdE?=
 =?utf-8?B?UEo5bUhUU1Z2VXhCdFhaWWp0T095dVVhTU1rNnUvNmY0RDJwYk5lVTZpUWxy?=
 =?utf-8?B?S1NUbG9oSU95R1dkSXhxMmlLbGRzVERtQlNaUjJ3Z0RLTXU2ZWRTUkdxdW9y?=
 =?utf-8?B?bzE1Q2ZMS2g0QU1TU3VWb2VaUzRCeDZSVnBGVnNmWU1RcnVyY0hZZ2lwT09C?=
 =?utf-8?B?Rk9udkdFOGtHNTZNSlM2dFhtRldKYnRvS0l3aUxUTktxTWVPNFZQNFRNRFd0?=
 =?utf-8?B?czdBRzFIRTc1YmdrN2ZDMTEyN1luaTVrWGxvVjNKWGxLckltZmU2cDBKYWlk?=
 =?utf-8?B?RGZwTG82SnppeHNIWWttbU8rL3pYWnFuQnBNUzY5NFZNTTVtcmx6ZVlESjJu?=
 =?utf-8?B?RUhkYW9FRnZxb0pzaTkxT01TWTF2RjRweHBZTThzNnJaWkhCdTdqdFhXMVk2?=
 =?utf-8?B?UXVaaElZZzJrajVOa3QyWThWRldiTGUySnNvUT09?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jun 2025 14:14:13.0187
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecdf6235-41ce-410e-51bd-08ddb3296554
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6580

From: Alejandro Lucero <alucerop@amd.com>

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
  cxl: allow Type2 drivers to map cxl component regs
  sfc: setup cxl component regs and set media ready
  cxl: Support dpa initialization without a mailbox
  sfc: initialize dpa
  cxl: Prepare memdev creation for type2
  sfc: create type2 cxl memdev
  cx/memdev: Indicate probe deferral
  cxl: Define a driver interface for HPA free space enumeration
  sfc: get endpoint decoder
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

 drivers/cxl/core/core.h               |   2 +
 drivers/cxl/core/hdm.c                |  93 ++++++
 drivers/cxl/core/mbox.c               |  29 +-
 drivers/cxl/core/memdev.c             |  89 ++++-
 drivers/cxl/core/pci.c                |  63 ++++
 drivers/cxl/core/port.c               |   3 +-
 drivers/cxl/core/region.c             | 446 +++++++++++++++++++++++---
 drivers/cxl/core/regs.c               |   2 +-
 drivers/cxl/cxl.h                     | 111 +------
 drivers/cxl/cxlmem.h                  |  87 +----
 drivers/cxl/cxlpci.h                  |  31 --
 drivers/cxl/mem.c                     |  32 +-
 drivers/cxl/pci.c                     |  87 +----
 drivers/cxl/port.c                    |   5 +-
 drivers/net/ethernet/sfc/Kconfig      |  10 +
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/ef10.c       |  62 +++-
 drivers/net/ethernet/sfc/efx.c        |  15 +-
 drivers/net/ethernet/sfc/efx.h        |   1 +
 drivers/net/ethernet/sfc/efx_cxl.c    | 181 +++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  40 +++
 drivers/net/ethernet/sfc/net_driver.h |  12 +
 drivers/net/ethernet/sfc/nic.h        |   3 +
 include/cxl/cxl.h                     | 262 +++++++++++++++
 include/cxl/pci.h                     |  51 +++
 tools/testing/cxl/Kbuild              |   1 -
 tools/testing/cxl/test/mem.c          |   3 +-
 tools/testing/cxl/test/mock.c         |  17 -
 28 files changed, 1347 insertions(+), 392 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: 0ff41df1cb268fc69e703a08a57ee14ae967d0ca
-- 
2.34.1



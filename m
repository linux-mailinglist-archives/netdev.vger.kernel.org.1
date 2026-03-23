Return-Path: <netdev+bounces-270480-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yIGyMOsmwWmbRAQAu9opvQ
	(envelope-from <netdev+bounces-270480-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:41:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EFC72F158D
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 12:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CABE5302DF43
	for <lists+netdev@lfdr.de>; Mon, 23 Mar 2026 11:31:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B38638B129;
	Mon, 23 Mar 2026 11:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="rZ6YlNi8"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010038.outbound.protection.outlook.com [52.101.193.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBB89387598;
	Mon, 23 Mar 2026 11:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774265490; cv=fail; b=p8+sSBbZcU2Ciq6yVB2+J0Wcl1oVwjsQc8q+MehaTuqEGNbxNjK63DCoHpR+WzRwXuy0PXMXvzKTLRL2UeYtn/AUd09R2exlNM7pxdEUmoTrFDMA82ifr0lu8rtB0PQtuHaK/YYOl6ypWeLsqMB74TtTgaGzVCdEJtUaG8ccssE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774265490; c=relaxed/simple;
	bh=H3kr3zYZGbNj7LlwDZ6QnvSBKtmRplgaCe5wLsHtvGg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=szAS63GhhWMuRistHJRs66ZXrrr/QflTb/vrtmRlbNV41ZZtMavHsHcBHeoNwzKC0Io9dMbQjczOhtrjXRmAwTX9+kXEkRcD9Mq4sr9euTipMmcCTefTS1vGndiV7t4xjsQAtPGAtdih7xnpohxDeNM179vPbiKe1bK6WryX/w8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=rZ6YlNi8; arc=fail smtp.client-ip=52.101.193.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JsLa9toMlLD0WuHNG0muO+qXhuATrBWxD+tZdsjTUCltPt4HKjOVpGDKfm2QZ6MHJA7a6nXDNDj3PvxwsC+UHWQjjuGH0MkN6Y4k0jQtx2gc/NObTp22rVUJ7pkQfdvTBQs9vaAaZwf9tUpV4JFf4ZbIcn2xK5gIFkhKglpY6lf5N2HmdkpolxUF+hsTacvPGWQUWZeOHb7s6DAOAum6nFjgDKmPLniSIgqvHrTF96ba/RxK9EednC+CRtovlnrLRogWPhotMpr6LYq+o2bhLvpI3EHgrOz75EcGgA7dsKxwfWctUIDj0qvP62ESk1DmoNOw5i/VyLLzxCO0V6nKcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9VNhL4xCMKdNcaT8jVGVciCiK0nq4KMN3YLJLlQiiyc=;
 b=IeFifSAe1g2qoqKKcVR02kBRgkc1l8mszDCrwI+e1S1x81iUPb5An2cmJbw5vskCr3lwm0TXJaAsaN3mTqDkGr4pbOBXw9XrEU2LxbwGzSS6dOPySwsBt7i1Y5TB5C/tMVirlzgAkR61/Vh38UmoKHb+Jl2X64vbvGheY2eb0FaghixLaG8CfnznfydhKQCTUJH3dEJ93+aBNp/BEjC/0hSl8SupSNSFwH55MF1FRJM27iXcW0YthvT/CxzaAWt03vfKVzL46O12ToIm+n8eL/aa0KkPTj2oCp8Bcv4XOErkIKd7+B8XrEn8cdVhQWcjSfDdrW3xT/uE4F/ArjZu3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9VNhL4xCMKdNcaT8jVGVciCiK0nq4KMN3YLJLlQiiyc=;
 b=rZ6YlNi8f7yVhD3QP7vMuy7X1GwW0FLueKwdlP5ybd67UqkD7HdxArfaWTSHmjEc5yqQVu58boUEo1IoLSOwN+yB1D0HSEI5VszHk6vFkgNt8LhTYQ1OdAdVHPYTF9LLhF709jSL1ar8nb6sMq8xMO9KxtoajOUeTP9Jyq2+0p0=
Received: from BYAPR07CA0094.namprd07.prod.outlook.com (2603:10b6:a03:12b::35)
 by MN0PR12MB5785.namprd12.prod.outlook.com (2603:10b6:208:374::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Mon, 23 Mar
 2026 11:31:26 +0000
Received: from SJ5PEPF000001F0.namprd05.prod.outlook.com
 (2603:10b6:a03:12b:cafe::5f) by BYAPR07CA0094.outlook.office365.com
 (2603:10b6:a03:12b::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.25 via Frontend Transport; Mon,
 23 Mar 2026 11:31:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F0.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Mon, 23 Mar 2026 11:31:25 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 23 Mar
 2026 06:31:25 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb08.amd.com (10.181.42.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 23 Mar 2026 06:31:24 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v24 00/11] Type2 device basic support
Date: Mon, 23 Mar 2026 11:31:06 +0000
Message-ID: <20260323113117.2352709-1-alejandro.lucero-palau@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F0:EE_|MN0PR12MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a168039-95c5-4943-a082-08de88cfb801
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	5CNBnoigGUmU4tYE1S2hgqv89H0Vs4LvAO++8RL3ykHFV2fonWZOv5ZXtGK2bXjH/8iyjGeRLDPmJ64LNs+1PH/NChm2l9MiY8tTqYh8aED+4FbfaBLUlD0S8nkDVlu395vg9LVyphkrL1Lao/F94CjI0PmkgG9zTyixGXjDXAHIKCHUjXk5gFeBGzAmezYZsXGKTC3xqD019naz7lTBioV/6AkIomLfkq+Wh/iBv3jhQ4f0hzH/ruowibyphYhwvIBkux48IA3eTdJbGy7IpoPTska4pElC+sagx92nJdYeniOErGdYsi1aDtPLWKWREBJvRCIoLoQ8H1UE64ikuPlh/4b5ivCzH4MRJc2/Lv5dlHveG1wXRHpwPm3w2BRRGjtUMdpgBfitV+/I+93ZjJUeSWhGlbfm9WiOVkbFxWVy9XCbe5trN3VPJC53Lf/Sr96jETMMaRoeutfMaJstdlM8UCI+H25YmQoRCnP3WIGrbJ5Am1PlbPEiSHA5v/P5n0eRaAPsJVVAhl/bBVlw4mCPvWio2GvRfXbNQmh7DZeBgxbqWYOy20NUNXBFZU5yQwi6LWZTz5ho4KUQBFmqXP7WON0W4U7HAui8O+fzvaf12FTi1QnuSZtWKuuX+C9rmXlfnpHf8YmeAVibxcw+cSCBrDHaQWqD0m9KRxfHTJ/jD5vCbsOs9Tt/Xoip6pAGOYKNY18qn7DHK3O92AEyLk5u78MieYUt65IRaE3dk58=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sBm2K5RH0jaEMDHv6j/46v4AuBCG67LJOyaOja/R6f2SO0owljzYeIkyWkIKQ0SoCsOnutzqpNj3WyOmK5HNDnyNdD/3abKkICtD+RYcoN+Ironzg/kMWoFa11EXChK9RHK9XhBbKec6VqWQCkOT7AL4wtdyt+j8NZslQkOWpBqq2lVjOGzV4Nx0ZUMTdI9Sfwu8d+fHF+lg7uACCws8gOoTzJDO4Ru7iGXuaxx1AX6/ZexjxFZfr1211GvI1p+1XYOScR/rIWJjexA0pzTaUal5PGZRbl9NDI1IJFe6ZEdnxIeZd4yKuXzJY3fOl8JQKYWhW6iHRjuMrTD0VTzDeKrqWQdC+0SjOhkQxrbCd7ONUtYlSMx3xg+Q5fBB5NASlo6nKmgEIQG+eZTNeY4rO5JEph5xl9itsZ3i/pjkBp7a/vgZTfZBJcJptJ41nz+7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Mar 2026 11:31:25.8741
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a168039-95c5-4943-a082-08de88cfb801
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5785
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-270480-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:email,amd.com:mid];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[amd.com:+];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[alejandro.lucero-palau@amd.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Queue-Id: 4EFC72F158D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Alejandro Lucero <alucerop@amd.com>

This patchset should be aplied on the for-7.1/cxl-type2-support branch.

For the sake of having the impending Type2 support for known drivers
needing it (sfc and Jump Trading) this version does only support the
case of HDM Type2 device committed by the BIOS, keeping the
decoders untouched when driver is unload, which requires a patch from v6
Smita's series:

https://lore.kernel.org/linux-cxl/20260210064501.157591-1-Smita.KoralahalliChannabasappa@amd.com/T/#mdad81d3817def8baace77ead9e2e305e775cf51d ?

or a BIOS locking those decoders.

Patches below same than those part of v23 but with only the code dealing
with the supported case.


Alejandro Lucero (11):
  sfc: add cxl support
  cxl/sfc: Map cxl regs
  cxl/sfc: Initialize dpa without a mailbox
  cxl: Prepare memdev creation for type2
  sfc: create type2 cxl memdev
  cxl/hdm: Add support for getting region from committed decoder
  cxl: Add function for obtaining region range
  cxl: Export function for unwinding cxl by accelerators
  sfc: obtain decoder and region if committed by firmware
  cxl: Avoid dax creation for accelerators
  sfc: support pio mapping based on cxl

 drivers/cxl/core/core.h               |   2 +
 drivers/cxl/core/hdm.c                |  39 +++++++++
 drivers/cxl/core/mbox.c               |  51 +----------
 drivers/cxl/core/memdev.c             |  81 +++++++++++++++++-
 drivers/cxl/core/pci.c                |   1 +
 drivers/cxl/core/port.c               |   1 +
 drivers/cxl/core/region.c             |  47 ++++++++--
 drivers/cxl/core/regs.c               |   1 +
 drivers/cxl/cxlmem.h                  |   6 --
 drivers/cxl/cxlpci.h                  |  12 ---
 drivers/cxl/mem.c                     |  45 +++++++---
 drivers/cxl/pci.c                     |   1 +
 drivers/net/ethernet/sfc/Kconfig      |   9 ++
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/ef10.c       |  53 ++++++++++--
 drivers/net/ethernet/sfc/efx.c        |  15 +++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 119 ++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  40 +++++++++
 drivers/net/ethernet/sfc/net_driver.h |  12 +++
 drivers/net/ethernet/sfc/nic.h        |   3 +
 include/cxl/cxl.h                     |  14 +++
 include/cxl/pci.h                     |  21 +++++
 22 files changed, 480 insertions(+), 94 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: 64584273dfb8a1e5fc7d78094ba22a93c204b44e
-- 
2.34.1



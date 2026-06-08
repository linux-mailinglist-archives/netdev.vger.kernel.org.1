Return-Path: <netdev+bounces-296758-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id TDioJBNGJ2rjuAIAu9opvQ
	(envelope-from <netdev+bounces-296758-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:45:39 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 121FB65B0DD
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 00:45:39 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=riJxCZPP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296758-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-296758-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C01D130B6F6F
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 22:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449F33B38AD;
	Mon,  8 Jun 2026 22:41:00 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012015.outbound.protection.outlook.com [52.101.43.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 930B43B14DA;
	Mon,  8 Jun 2026 22:40:58 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780958460; cv=fail; b=N7vgzFGZSyMgLdG7uFYhFFJq49XaS2aaEs/RC4k1Umv0Ee372oVRahaOF8EylQmxwkH1zulzqSnGHOr8ETL41XJ5jtL+1C21lk7/2BfI/6E+dEOx+kqum0ofx0xp39ZPd8AvTtMLJWggyftJlVRPwiEPAmIjmOLCvCXslvl3R+4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780958460; c=relaxed/simple;
	bh=jyXeyjdZBVa3dC87AYkeFJtBJapapfNV7KhyGZsoieY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hWLKa4jQOkIm/W09VzmAAatOsQkL4cTkYARJMQ4AILEPaVAz4y9vPuuU3k9frGR4wT6IvVR3UsdU89C+tSd6j75+DE92XYkTD0p9giqKfXVGQS6na2nxpzzHObUcDk3TEUYDxd0DbeoXRSKbfyjdxOQaYUCzE3NdefSeSKo9pJk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=riJxCZPP; arc=fail smtp.client-ip=52.101.43.15
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tHVOYPyaaFFBAHtHhPEpXV2gNokajx18hF6j2NmZ9kt5R/KGsJzvaviUbZTzwGRDYZ3IN7avcLtRmIeNa4z0V3eyFU6IhOppCPgVZA4EZaaunK+kp4lJ888r+JwRPc09padpZVS9KT0A4NRSB6WbjVxOPuQj/ZW9Bd8/LGYg9uPlXcRQPllHZyr0vKgNF2sBdSbL/UcdmVZpx5+ncrWMAgiq7mUKmDY+3bxNQIJ0LggXL2m4eYMI5e25QxJclkCV0EyOqCQEeC0aHyNkeBuIzgt8oTuNfUZrWE32ny8pQIuJgWeQjw0VzpJMvlMGCck/GJCvjE60lyRTy36EofCv6Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SpO5pzXRdfoRJytSKBAP26lA/E0nwxcHFnpHN7EKPdw=;
 b=kF4Pavmnz88IlyrjjZNdLwBzSSOEdbd2Mk1dyTrEYJWGtUbf59BwMD7VijBWBR3kzLh9eGI4oFBEQOmK7dDeFEWm9whYlB70+AbG1W76tIDnAid4GRpUUuvZQ5u667Z14Y9GYkMterOT+II67sSkEmlqfoxQl8kVEXZND21QEFecpl8PIh2EmGTWV3x499CUv80VQmckGFQcNwag4wH74m7F/GWTGVHPyxxPBnP73ThuG6C+A055DSh3mnwiGHBrc7yUHV8CRjaMNgkz2EtKUM4vHjAs+CY7naHN2+bHuddmLd4XyP1U+RuN7Q5n8PNKScrzqr5yzbGgqn3Cfuza3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SpO5pzXRdfoRJytSKBAP26lA/E0nwxcHFnpHN7EKPdw=;
 b=riJxCZPPepo5jG0q3nyzuCQ6TWyzyJJ3MRtGXQqwp/irNzWNLOf+AxSV1mMntQg6BsxIlvs485mUwmVzOkX5/siTe1GQrPJ0Rarja3dbyqe2vt9BPpQV2v6YJCXS9WP1EGehAu3/3tl3fVLs3bQ4OZyfjVtTFgV8mBjlFfgj7Hg=
Received: from SA1P222CA0062.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:2c1::13)
 by IA1PR12MB8333.namprd12.prod.outlook.com (2603:10b6:208:3fe::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 22:40:54 +0000
Received: from SN1PEPF000397B5.namprd05.prod.outlook.com
 (2603:10b6:806:2c1:cafe::70) by SA1P222CA0062.outlook.office365.com
 (2603:10b6:806:2c1::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 22:40:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF000397B5.mail.protection.outlook.com (10.167.248.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Mon, 8 Jun 2026 22:40:54 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 17:40:54 -0500
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 8 Jun
 2026 15:33:11 -0700
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, <linux-kernel@vger.kernel.org>, Eric Joyner
	<eric.joyner@amd.com>, "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH net-next v3 0/6] pds_core: Add PLDM firmware update and host backed memory support
Date: Mon, 8 Jun 2026 22:32:50 +0000
Message-ID: <20260608223256.12357-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000397B5:EE_|IA1PR12MB8333:EE_
X-MS-Office365-Filtering-Correlation-Id: 70fa0480-d649-4c8e-fd92-08dec5aefffe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|376014|11063799006|3023799007|56012099006|13003099007|18002099003;
X-Microsoft-Antispam-Message-Info:
	V/fLe4JhAEa4dMHUCE6kHBrGBb+Q7x1OKPImPN8WC++mvc2Co0qBUaIw4vP2JnbUvfZ4mo+FR+N/ixvQ5yX90fTEgcx8f6ijkPpXLF0tJ+Yc5Sxb1chlEge9G1og9WWRzgMbjdzrxcSBlGtHyaj9IE1kwyBpgi4Ebml3qgEXUVFaT9abyrPWd4NQsFLHA5dhFQ1ZK5zgZpkM2JG0EJRif9GQZzW1yaQqo01Ov5Ve1Ka4pN8AUzI7OxLFzhuYIfYOpGvzC9dc9JFEUVUygprMw1Gbq26Jr/R/J+u8L92AVP+0WvCKHqTRkh6LHNxt8GCxhL3S/IXV8uImDFfnIyz9UcfBe3iDJWzrm3fi+F/HRZ8qSQyjbp2f+lAW1xCuAWlIBcPSP7xo8NMonUTTik9kCEfm9iYOuyZhVVLedoADmkLyyK4xEDIkKHqBtfbLjJUWNXog1J0LHAErABBpdJRe2wsAYCSc1jtD38mGJvMoQduT8xW56jyd0bBwO5+SWaBt9i70FXVco9pyKrB4VU9jo0cewB73JBa2z/w90R4wzi/pzWl3Qxy86QWaFGLcPQ0pv8p6V4HI8PxkPd1zQgPWf9d/XOgFXaNV4XZDH+FOx7wp5G/yj6gfXpWoZIg0kUYQbFaaH3r74SOLKnOFf4JnLKKtIutJuXSQNYjhWQTwcK/LlFS05YFI4zTlw8e9BA9o
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(376014)(11063799006)(3023799007)(56012099006)(13003099007)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Y7m6fpXzjcX/5No6I1kEIDXhG1jWstWTGED2j/qpPJRtebgV7NcG3utLHjTBCYhGFX2KscTkijbkSryDYqYbNwbqkOQNoMYuEoEzamjwTRsD0xc4FI9Yb8VrArTk5K52AfXT+chayEVdDpE6FjjYuP8QUnx4xEBBLl2YqtSk9YjH7gIWu247ryl9Ho9bb46G92oCzfRrHYCBudlKXPlWyiG/RevPiytjl7no0rfvZssknjLtXWtO8hvVXfUhKU20lu/+JhC6BOf/cvlr8ggHW2RUrvbv7j8744HQP9JFyqZLtRudaIXNZuEKpt3yVpFn5LC89xGtjA7fXb8aMcwzWlelyNILcZmaqJpugx0hzMnLJFyulRHgWDdNBffXz2ra0ETgJKzBSQEMV6ZJTtdGexzEvlYHF7g3JBc18LIp/+EcNH3Ew2JUwuOMnRdT6i5z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 22:40:54.2405
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 70fa0480-d649-4c8e-fd92-08dec5aefffe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF000397B5.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8333
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-296758-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:brett.creeley@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:eric.joyner@amd.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime,msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[8]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 121FB65B0DD

This series adds PLDM-based firmware update support to the pds_core
driver. PLDM (Platform Level Data Model) is a DMTF standard for firmware
management that provides a vendor-neutral interface for firmware updates.

The implementation uses the kernel's pldmfw library for package parsing
and component matching. Users can update entire firmware packages or
individual components via devlink flash. Component information is
displayed via devlink info, showing firmware versions and update status
for each component.

The series also adds host backed memory support, allowing firmware to
request memory pages from the host for its operations.

Changes since v2:
- Use driver-defined component names instead of passing through firmware
  names (Jakub Kicinski). Added component_type enum that firmware populates,
  driver maps to stable names like fw.mainfw, fw.goldfw, fw.bootloader.
  Added documentation of firmware version names to pds_core.rst.
- Fixed bugs identified by sashiko:
  Patch 2 (identity version 2):
  - Fix comment using wrong macro names (IDENTIFY vs IDENTITY)

  Patch 3 (PLDM firmware update):
  - DMA-after-free on EAGAIN/ETIMEDOUT: when a command times out or
    returns busy, firmware may still be accessing the DMA buffer; defer
    freeing until a subsequent command succeeds
  - Use dev_warn_once for incompatible firmware version (ver==0)
  - Clear component cache after flash to show updated versions

  Patch 4 (component info):
  - Fix min_t(u8) truncation of max_fw_slots (u16) to min_t(u16)
  - Fix F_FIXED early return skipping F_RUNNING flag check
  - Don't fail devlink info if component query fails; use dev_warn_once
    and continue to report generic fields (fw, asic.id, serial_number)

  Patch 5 (host backed memory):
  - Switch from adminq to devcmd; fixes both workqueue self-deadlock
    during recovery (adminq completion runs on same wq as health_thread)
    and health_work re-queued after cancel (adminq timeout re-queues work)
  - Remove MEM_DEL from teardown path; fixes both MEM_DEL sent twice
    for same tag and num_host_mem_reqs ambiguous semantics (now only
    tracks pages to free). pci_clear_master guarantees DMA quiescence.
  - Fix PDSC_HOST_MEM_MAX_CONTIG to 4MB constant (was arch-dependent)
  - Not fixed: pdsc_host_mem_add() failure ignored; partial host memory
    is acceptable and firmware handles fewer regions than requested

  Patch 6 (debugfs):
  - Move pdsc_debugfs_del_host_mem() before pdsc_host_mem_free() to
    fix use-after-free race with debugfs readers
  - Use %u for unsigned types and %pad for dma_addr_t
  - Remove "file exists" check (now dead code since teardown removes file)

Note: The following fix was submitted separately via net:
- DMA in flight during teardown (call pci_clear_master before freeing
  host memory):
  https://lore.kernel.org/all/20260604213637.3844317-1-nikhil.rao@amd.com/

Changes since v1:
- Removed redefinition of __counted_by kernel primitive (Jakub Kicinski)
- Fixed kdoc warnings in pds_core_if.h
- Fixed checkpatch warnings
- Fixed bugs identified by sashiko:
  Patch 2 (identity version 2):
  - Zero data region before firmware commands
  - Suppress expected error message during identify probe

  Patch 3 (PLDM firmware update):
  - Memory leak in pdsc_send_component_image() error path
  - Memory leak in pdsc_flash_component() error path
  - Missing devcmd_lock in pdsc_devcmd_finalize_update()
  - Fixed dma_mapping_error() return value handling (returns boolean, not error code)
  - Skip logic for components with index > 255

  Patch 4 (component info):
  - Added generic fw version display for all identity versions
  - Handle components with both RUNNING and STARTUP flags

  Patch 5 (host backed memory):
  - Race between pdsc_remove and health thread (use-after-free)
  - Set missing index field in MEM_QUERY command
  - Host memory allocation size and zeroing
  - Don't free host memory on MEM_ADD timeout (firmware may still be using it)

  Patch 6 (debugfs):
  - Fix dentry reference leak in debugfs_lookup (missing dput)

- Improvements:
  - Cache component info to avoid repeated firmware queries (patch 4)

Note: The following fix for an existing bug was submitted separately
via net:
- Timeout error overwritten with stale status:
  https://lore.kernel.org/netdev/20260515212907.998028-1-nikhil.rao@amd.com/

Link to v2: https://patch.msgid.link/20260516-upstream_v2_clean-v2-0-7e0d66bf4020@amd.com

Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>

Brett Creeley (4):
  pds_core: add support for quiet devcmd failures
  pds_core: add support for identity version 2
  pds_core: add PLDM firmware update support via devlink flash
  pds_core: add PLDM component info display

Vamsi Atluri (2):
  pds_core: add host backed memory support for firmware
  pds_core: add debugfs support for host backed memory

 .../device_drivers/ethernet/amd/pds_core.rst  |  88 ++
 drivers/net/ethernet/amd/Kconfig              |   1 +
 drivers/net/ethernet/amd/pds_core/core.c      | 163 ++++
 drivers/net/ethernet/amd/pds_core/core.h      |  51 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c   |  45 +
 drivers/net/ethernet/amd/pds_core/dev.c       | 136 +++-
 drivers/net/ethernet/amd/pds_core/devlink.c   | 107 ++-
 drivers/net/ethernet/amd/pds_core/fw.c        | 767 +++++++++++++++++-
 drivers/net/ethernet/amd/pds_core/main.c      |  11 +-
 include/linux/pds/pds_core_if.h               | 470 +++++++++++
 10 files changed, 1819 insertions(+), 20 deletions(-)


base-commit: 903db046d5579bef0ea699eae4b279dd6455fc9f
--
2.43.0



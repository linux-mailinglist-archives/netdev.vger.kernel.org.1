Return-Path: <netdev+bounces-302843-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id pyigM5L5Qmr6KwoAu9opvQ
	(envelope-from <netdev+bounces-302843-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:02:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 269516DF213
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 01:02:42 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b="GPCOoZA/";
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302843-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-302843-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A08A830134AA
	for <lists+netdev@lfdr.de>; Mon, 29 Jun 2026 23:02:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EAF235DA40;
	Mon, 29 Jun 2026 23:02:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013030.outbound.protection.outlook.com [40.93.201.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01FFE2F0C62
	for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 23:02:35 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782774157; cv=fail; b=N7Jda1sSES1M6N8Ni6z3HI/l7KHWiM0+yhSQgadqonmk5uAS+AKtQKodpuDpC9hAPs+jjG0QsN6QkTDwOd2zAquzCBNgWlLJMcPO7PyGq0LlR/bfO6O699n91ziHc/E/m0xgweXDMHr3/layRex8QkSHJLVltUiecnv9fQO8HMk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782774157; c=relaxed/simple;
	bh=0VnYiUTJimZi3xGcJryw4CVrachr5OY1TgrVopiye1o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z4nS/JaxQUrATyi8mLVswb9xvV+cacCg8Iwe2UQR86CFWOQp3gcrDJCR9qe4VeyTVJSznz7mkBnksVtnYncJfqDDqg7XSBNGI8mFDM2mN1vCiZE4vBin9GQ+13CA2OZNbCXZxnyuB0FYbQPcH02i/NUQUbmxlcoviY7VQuPkW6Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=GPCOoZA/; arc=fail smtp.client-ip=40.93.201.30
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l25LnfA1W4x65hcNFj2/+QFnrx7Ir/qK5EPZfwFEXxq3o6lWBrF4kpzaA0qHwAxpSmBMpiw3XAj+i+T08gHGiM5+Qw6XDPOFOZr8okWxhbeNT6mCdCcIIkXM5InLOJjy2pWbgmyVZCGSccrGVCBU3us26jfo+zNpYnLFUVG1mKOebF/rmTpCI24woaFJG/ozi75L7L0ppyXwNR3bKgEGKqWX1htlj9Od1FEaeM72PCYGbM4XWopq4NUHioGrVI6urpwce5cEoN6/iMCxwlRculXLINRBzHyWzDXYIpS4a+tuGHGnih2PchCBbBT32X7XcS37/wg5G0LDHuYDfHfOIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvr1JlTLp++/ucwRlxSwlyTpY9Kt/mjpLpZAj5ZVOuY=;
 b=zPDZ1O4REDDAxCt/B+LoAG3YdLEwKufSA19HuGQupXsao8xtqy4OJ6hfqJ9d/UmlsOZvYEesuvIeYdG6h91lhPzhRyb9a8fxDd+WSarklj2C/8wAFA/xgBCjx+yXh4BrCZmZb9J18oyNzZtSvSgK1IyNiNXK5+W+xint5tUHXSJKMvfwJk87Jem0vIXjcCsg8rc41yxZxu4eBjTdgYlcMOAnpTtZ7EsciumJBgWJYQ894Qqe1XZTBhd32DRrnlizUcqJxv3HAMw9r1D2ZrZue8YrYGVFmMgv+yXwlJKel7IUA7XLAl7cH4wfHq/U4coZADQYZ1aLlOjxXkdGwXWcPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvr1JlTLp++/ucwRlxSwlyTpY9Kt/mjpLpZAj5ZVOuY=;
 b=GPCOoZA/lnfaUIWQUFMqzW1v+ce0w6geiAb0QpvSmLOMEw2IO39sPIO1L2KgjgXEEY0HX7D/5xWkG4+WA+Ldx2FdB6nkp0n87Spz+hjj9aKRkKQRrk6AFrUc8vtJ9qag46l194XZ1/rO0bUPSOTkoW1IrXLvQbejr7wBTVSu1Ow=
Received: from SJ0P220CA0013.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::20)
 by SN7PR12MB7324.namprd12.prod.outlook.com (2603:10b6:806:29b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Mon, 29 Jun
 2026 23:02:28 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:41b:cafe::3c) by SJ0P220CA0013.outlook.office365.com
 (2603:10b6:a03:41b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Mon,
 29 Jun 2026 23:02:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 29 Jun 2026 23:02:27 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 18:02:26 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>, "Nikhil P. Rao"
	<nikhil.rao@amd.com>
Subject: [PATCH net-next v6 0/6] pds_core: Add PLDM firmware update and host backed memory support
Date: Mon, 29 Jun 2026 23:01:54 +0000
Message-ID: <20260629230200.82092-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|SN7PR12MB7324:EE_
X-MS-Office365-Filtering-Correlation-Id: 24df7793-d2f8-43ca-b3fd-08ded6327da5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|13003099007|3023799007|56012099006|18002099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	bSVSNOcCcpLX1Zlo7zdTLvSeua2a2zZFBvLnHEorVhUjUOcVt312aKG0eHZ0sP3mPofDHh3WttfqoYDGzbPgJo/ttJXEYJp1x5kd3cBdRJuBC2TDQ+4JJNvHaEj+Tn4bWiUkf0ZlTVd4m6ft1pM2X76D3w5O6wXd+F3cdLlv39g7CLkTduOPuw26Wa9ygZfv9sWS/ih2JO12MIUGkTZ3xkoWLv/z2Q0W/Oukm4T4aVOjAj9Qs94RXdKRlzU9+ir0iCURJrEu1KfCnhOnc99gorXKMy/o56Pj4DMtpLHEltu/C2zf9aKCK0mBfbLa0b0vwsvFngxw89wTBnSH4RA5T9KVwyZOGvsW8LPkDjCX3rbLV/1I1ojkZQSov7unsz/CZNjkCAJx488D4TY3zhLpNADU2iMGr7ns7wVFhiKxThkjWquzj/hfWhjDQNsVkn2yuQlWRNVgBhPLZ3tOrPgxKCrHCjnth1FfeiNV3iXQU3FYM8aNshE37RPjDvGx5RuKdNkx7EUExX91xu+6F99oe6rbU+XeVNqg9LRnLv2rAWFK70HgniW3p1glKYunJWd9n0vRS6nNC7diQuuErE4jKN0pWw65yQ5mX2b/nhMGCDFAaQehMT9H5XlIF7QBrV10whaYILVWx2LT6j7qLd9AWMwFz8evHiXnG2ya1bxdz0BDQY166t7tvAvIAnNU74GStfumowRsrCGmxPYzVHfaxw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(13003099007)(3023799007)(56012099006)(18002099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5ZyQoE5S+jA1guaZlBwgKNODP7E6kl6QH8MrXru2RLxGjo4EcI9EcBW6zqrizyin0uA3MBv+DYzos2D4zEsX2KEn6XZDWH9jyLu6wK1CKJZC9BsKVhlo5HxGswPMaxenL3ECajQmXWhiPlpIPySkYTFgeWUbqHaxbLAMkMtRW2mA86CURu7KSoXzbYLvaXate+ClSWmC8b1XIRGtfhO6uMGPQfiivU3ufYUGRwwlP/lG3rz9OCLLJGMXgbb3Oia/QTzrtWwiz/ZQuh+gjUZvzsxZJH0jvJTRVCHFTxtsBr1DvWZk7BqJ3SOwr7TJ88iscqUnVnmCvPdKK0O0Vqzsq7KYW72JA1O6KNRWnSUrJpHSzW50OekurviaC/gD3GwuA5l8sx92PDj6xBBtTJpOAGd5qOwP8i4zHooPtu3cjANAd3WkNh0rODKg+8YyJt1H
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jun 2026 23:02:27.6819
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24df7793-d2f8-43ca-b3fd-08ded6327da5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7324
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-302843-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 269516DF213

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

Changes since v5:
- Patch 3: Changed "fw.suc.mainfw" to "fw.suc" for System Unit Controller
  firmware to be consistent with the "fw.mainfw" to "fw" change in v4
- Fixed bugs identified by sashiko:
  Patch 3 (PLDM firmware update):
  - Remove stray kdoc fragment in pds_core_send_component_op enum

  Patch 4 (component info):
  - Fix fallback to dev_info.fw_version when pdsc_get_component_info()
    succeeds but returns zero components

  Patch 5 (host backed memory):
  - Expand PDSC_HOST_MEM_MAX_CONTIG comment to clarify why PAGE_SIZE <<
    MAX_PAGE_ORDER is not used

Changes since v4 (sashiko review, Simon Horman):
- Invalidate cached component info in recovery path to ensure stale
  versions are not reported after firmware changes
- Fix v1 error handling: propagate errors from pdsc_dl_fw_list_info_get()
  instead of masking them
- Fix v2 error handling: fall back to dev_info.fw_version only when
  pdsc_get_component_info() fails; propagate devlink errors so partial
  replies are discarded
- Clean up max_fw_slots comment to clarify it contains component count

Changes since v3:
- Changed "fw.mainfw" to just "fw" for main firmware (Jakub Kicinski).
  Gold slot main firmware is reported as "fw.gold".
- Removed redundant memset before alloc_pages (Paolo Abeni)
- Changed dev_err to dev_warn for alloc_pages failure (Paolo Abeni)
- Only report dev_info.fw_version for identity version 1 (version 2+
  reports firmware via PLDM component info)
- Fixed checkpatch alignment issue by extracting pdsc_dl_info_get_v1()
  helper function

Changes since v2:
- Use driver-defined component names instead of passing through firmware
  names (Jakub Kicinski). Added component_type enum that firmware populates,
  driver maps to stable names like fw, fw.gold, fw.bootloader.
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

Link to v5: https://lore.kernel.org/netdev/20260616-upstream_v5-v5-0-9b46c59b0dbc@amd.com/

Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>

Brett Creeley (4):
  pds_core: add support for quiet devcmd failures
  pds_core: add support for identity version 2
  pds_core: add PLDM firmware update support via devlink flash
  pds_core: add PLDM component info display

Vamsi Atluri (2):
  pds_core: add host backed memory support for firmware
  pds_core: add debugfs support for host backed memory

 .../device_drivers/ethernet/amd/pds_core.rst  |  84 ++
 drivers/net/ethernet/amd/Kconfig              |   1 +
 drivers/net/ethernet/amd/pds_core/core.c      | 164 ++++
 drivers/net/ethernet/amd/pds_core/core.h      |  54 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c   |  45 +
 drivers/net/ethernet/amd/pds_core/dev.c       | 136 ++-
 drivers/net/ethernet/amd/pds_core/devlink.c   | 137 ++-
 drivers/net/ethernet/amd/pds_core/fw.c        | 780 +++++++++++++++++-
 drivers/net/ethernet/amd/pds_core/main.c      |  11 +-
 include/linux/pds/pds_core_if.h               | 469 +++++++++++
 10 files changed, 1858 insertions(+), 23 deletions(-)

--
2.43.0



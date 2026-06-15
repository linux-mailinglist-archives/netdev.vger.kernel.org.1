Return-Path: <netdev+bounces-299627-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id yzdkJaZzMGq2TAUAu9opvQ
	(envelope-from <netdev+bounces-299627-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:50:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 152AF68A38E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 23:50:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=wbLn9hHP;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299627-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299627-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 085EC3023D8E
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 21:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C818E2E7631;
	Mon, 15 Jun 2026 21:50:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010001.outbound.protection.outlook.com [52.101.85.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21902319852
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 21:50:21 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781560223; cv=fail; b=abO+EI0e0hvKeLG7PqiMrsuftK7zo72fm7rxyEN5ald6Hr39gScC7gsGCXf8XwbTvf/M3rscGM3FFBUIaNyllYa5HXX+3mKVyMp04+o+bq9z7L8RoFiLUF+UvV+Z6qGrSL8noprJ/oM0DM4D4rKgnE9IXWLcP0lv0P55/+RrB1Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781560223; c=relaxed/simple;
	bh=ybb4/v6d5+CkEBtAuBQxhKHXyfGMpS78mMy1YYB360Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=h3xhfIrip2m0rOmwli+dKtXaSsp0V8JTLhE2SL50tPjS3voDgZi7hewJFUbA0EnFq6iagX7gLHBAuhjPKV+EGKDlVt4sexpkQWIRxtGe+BxM1hHTk0q1jmkZUfi6Qcw9a35/q58CjklKb8Qh0DCtkDN0yxfBhZSAdIzauE7tBkw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wbLn9hHP; arc=fail smtp.client-ip=52.101.85.1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bpghflmwLyAQ0JbYFzDU7DIo4u4D7Ey3RO0XbzNiC6+cAw6MRbTnhDIjM/1/BUKlwM5nPJaMk8NIW3Ls/q2Aj6DBr9Z7A3UHMztm9P8SzQS0Pwj9whj+tBg486NC4F9m1bNg0EfrwgnMZRjhvwvsevagIVXYwmUNdxfJf8D3F/qOlv+ejngzXLy+n+11hfx9E0NMPAEyb3LmrHYxCR9luV4fYV24Yc0U1jsh0zwyeGaIr7jtZOnNouM7AremU4BVgK/DnaLMAiyPzHv0b2aPPmwns9Fs7FXNLu0Me/Sm+HjKRWfx92V5UWXXdgsw9bWN/vbUGxOg6rCW163Xxq8LZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Vnx7UXeaoGx0h7tmn6m5D9s7oRWEzhzS/25W/4LN8Uk=;
 b=J0OJrRQCFPtE7YgEcMXIqAE9LF5UdXV9Bre0EfhVIPHOcgJEh0TrDPjg/cvnb/s2Vz15AUH/TFTFK82NDMSybVdbtQU00IZ2+2Z6AsNkJT2v236UGKxXgEDtdjtb4RGfYLqAaLIlRULUiwlV1hfetpg05wIdAcnYEvEDvSsvseSilQuFNxKq2FRntvCVp2bCHWbj/AXf44qYmeeqJjmYKSZa+Ytd5/8Hj36A3KqtExxnFGeJ9Z3qGc6UtPuiXK/UxHwywLd4xFt2y1qk0A8EXqtbHHROPSzpqe7AmOwEBC+q/ZCPWaZyr0GmAgJTGgyojfLX8BdtFAuI2dc6j0FKXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Vnx7UXeaoGx0h7tmn6m5D9s7oRWEzhzS/25W/4LN8Uk=;
 b=wbLn9hHPoBPQjYW/nVyWLzILSfk2ULi78uTIR7VRa0hd3syT2BlNp816yCJRCqhlOpxMmCug5rEhtR1ioGe+/izlEp3nyAeQUCmTpnzAw6Sc/PALfDEYIO45EVOOns/xKIvqlWFEjgM/EUNTsD4k5a8lCoIvSiYSVbJcsy0YIck=
Received: from DS1P220CA0016.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:44c::12) by
 CH3PR12MB8076.namprd12.prod.outlook.com (2603:10b6:610:127::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Mon, 15 Jun
 2026 21:50:16 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:8:44c:cafe::25) by DS1P220CA0016.outlook.office365.com
 (2603:10b6:8:44c::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Mon,
 15 Jun 2026 21:50:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Mon, 15 Jun 2026 21:50:16 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 16:50:15 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>, "Nikhil P. Rao"
	<nikhil.rao@amd.com>
Subject: [PATCH net-next v5 0/6] pds_core: Add PLDM firmware update and host backed memory support
Date: Mon, 15 Jun 2026 21:49:44 +0000
Message-ID: <20260615214944.192902-1-nikhil.rao@amd.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|CH3PR12MB8076:EE_
X-MS-Office365-Filtering-Correlation-Id: 566f9139-a529-4f41-bc37-08decb28162c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|36860700016|23010399003|18002099003|13003099007|3023799007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	8OfKOXwHkrNN66voggxdQ7qnp2LUASHXTQ/oDvfKi2dA9RQkMCjPJvd/q+CgMoOAtAKpkWNsf2v1xR9LLwZV+KC1/u68wBbIXLnJG5+zUBo35FXynwNIdg6emPKHmQVid8hw+HtcSDw7WWXo0+/s8nwzbjl47mxGHjf0p3ASZNezxPHtwIrwWTc5xh6ORnpHtkOzHnG3S1ckanax4x+y0AXTtJD6fANBjN1VJFLAupcpkBlEP+XhHoz4RuwgKHbHsXVB4nYoAF9yJYFwSP7GCYzyC5J0eOnrAhLeZOxbhsnA5PewHiX1gxSGL9/TbJufz6WlMyzDYxXx8nBCzLrUOuKNDptvVn/sHwFK/DN1Vm/EUEsuwX+1F2SWovW7Kp9dThBDNQ91rQmm9OUwrsrtNq2d0wMCxlHXbnXInZTzxvbPsiI9mOlFs4iZqSxwXO+inZ3Eb31c2WrPlLUFbsUdrENaQH2O8TKgCwuR808T+ZkWfCAiyaUE5FqjYYCOaoXf/S7Prjl2mJ2aRgjejVXLRUuKReQgDKUQNqPdWYj9AaXImkDYXctwUBvp7iUc7JYm2SftlB+SIdHfIQlSyeiU3Dk0V5JttU7X1vqhRS2Ws4rW0xrvIoAGWp0ZTpcyyBrGWvz070elmYsxMkuT81Ou9UmANDgTDuEr0k8llLzZM/KAiqV26FuMSKHRctSoY165wj1Mzmohh1jEKydogTXmNIZcgsj/Mr0Rd4NcrKlqvzQ=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(23010399003)(18002099003)(13003099007)(3023799007)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	fYRyZN/6pj8l/Vqg7bsNB1EBt3t9Ur5yPfDW+pvCzoqQX6K6t+r5VQysfowBMIozK+QtiXGjSLQ0XuKUMQHOMops8NDH7JXFsirCIjCjI4cHidbWXGjiIgpeNH+gMkFXKykm8AEDZvPMrwV58g9APrDdRDag4Jlg6Xnncb5WhJEZcCy+VBq/6Jv2GcTEnhGcmBE6cVMv3+wxV72uar61jJqnD+fcNJuJZ2GxxHtfgjssnYaspFJ1mX44V+l7W85qsOJRHy64IeX3Uhl+rO0KInkHpE9oIAgklAB0ZVMkdk8Rl6z/mvQLaX0o3HK7JV0eLPeLyZlds6+i3ZfsWpyEs1m8ZcWM1K5j24ey3HxFGqpUYljzk6Qwn/5pmAKPHW0cu4qSlWBtBQV/zuIL9RFqjaGMazF+LAYAaqivU1h0IYIuUjfPext6rlsJ/0XXuwol
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jun 2026 21:50:16.3833
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 566f9139-a529-4f41-bc37-08decb28162c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8076
X-Rspamd-Action: no action
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-299627-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 152AF68A38E

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

Link to v4: https://lore.kernel.org/netdev/20260614-upstream_v4-v4-0-f1c5765d90c2@amd.com/

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
 drivers/net/ethernet/amd/pds_core/core.h      |  52 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c   |  45 +
 drivers/net/ethernet/amd/pds_core/dev.c       | 136 ++-
 drivers/net/ethernet/amd/pds_core/devlink.c   | 137 ++-
 drivers/net/ethernet/amd/pds_core/fw.c        | 780 +++++++++++++++++-
 drivers/net/ethernet/amd/pds_core/main.c      |  11 +-
 include/linux/pds/pds_core_if.h               | 470 +++++++++++
 10 files changed, 1857 insertions(+), 23 deletions(-)

--
2.43.0



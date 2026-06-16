Return-Path: <netdev+bounces-299716-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id U2XkBCy3MGosWgUAu9opvQ
	(envelope-from <netdev+bounces-299716-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:38:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 62B1968B82C
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 04:38:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=amd.com header.s=selector1 header.b=1oJhyxyy;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299716-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-299716-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=amd.com;
	arc=reject ("cv is fail on i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B83730078E7
	for <lists+netdev@lfdr.de>; Tue, 16 Jun 2026 02:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 246AD38837A;
	Tue, 16 Jun 2026 02:36:22 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012052.outbound.protection.outlook.com [40.93.195.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770BB175A62
	for <netdev@vger.kernel.org>; Tue, 16 Jun 2026 02:36:20 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781577382; cv=fail; b=R+1rbpPGOfXgVs7j7jldJbEouMbpa/vLzymkdpBJ9qVfxPPd30WRBJxuvF4KNCOyLBVCCnS2eIYlGM/1Z9TKEtQF4Za8r6fMw9a18A2K24WEa/txwN+XFd8D4JwpX5spR82WDrP8o5lOQzMOn7q3+opsHH30R0w1FdNNoT1jTZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781577382; c=relaxed/simple;
	bh=PtOebt1I4QIjejaa66FAAwMABi+n16q6LVjRxMhDYLg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TvXIDxQd3Vs+WUS7kW3LmpCNhZKls62CejkcWobyZvmLTPKVwJsL84ry5RdhCb2FEZjTTINVbJb8+N3PJJ7VNjd9YEujacN4d7GZevKkRm6asv/rtilyzF+NM6XdnmzBpXQ87QNy3qAwyooIagKsUtBrSdea4QNE5St6sz3gjvY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1oJhyxyy; arc=fail smtp.client-ip=40.93.195.52
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XUrRCDqdq/cxMZb45XzE+hoh5YLXLwDR8M6nRLM3FxQCY0PeYa6GFU0YSg+MWuWbk/fWRmJTj7VpLregeiubSR0cGIHWFXS+9e2ZTE0zmU1ijBP0h0l1XbbnoHIDrkuCwd0x1jpGCZjcQ8R3g4nNPPxEkUeIc0JrJ0OJML6IIlG/EoPcesnCTgrg1axwO+wNq13KlE4ZE0LDxJ6vPnTj0ghYT9qSb17TjRz3NwSjeV4C/YjxsHIcFGpawn2bgz5QX3eoNbZ7bRAjO6jyi1pApm4ort/CsLjcgBxyJBe71jbasQtVkt94HNyIJDZKwwxzKHUKiwmQIpJ037zh+ojLPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTqK3X4OEYuDdajt/8hrcLSc0maSRM4mkTd8HF3mrVE=;
 b=Y/70ZTWC6/lHaxg8x2GlNcCrfLrPbPvw8C54m0f2Q95rMWERZn8aW3JZ5aGXVhGfzQIGBP3PxbijIu+tZxTBW3zUxA+2/LTnkHaFbY3m68ZIqI0BhAn/4Gy5r/W/cK/WWvY7AVh/eB/WLRS6Z6JhzHa5vIHI6X/zHmwMg+ytx7pvQaK6VckEeKUb8nrnMiIduu9DoeNI1XntXGSGjtgR7vg+v2wT3mpELSkBccfywVM1SB+Omi/BpBEkfdCME+n7/c6GcsWKw5FV7KG+FlkFNgWGBgphNWc36kWQf5Yrmhu58TA8ZtHmti4Q3rIk77CXrGWK7Sh04UaLnfn7/F9JiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTqK3X4OEYuDdajt/8hrcLSc0maSRM4mkTd8HF3mrVE=;
 b=1oJhyxyy+jiK8xaZL4qiYRuwR7wTyLHtZtRgUP3ySanrP00bKYZsNiZHIBsmwZ4bbJjvp/ysdUmnttQMP43gzFxFmBlgg8XLj94J5GUKD29A3poYEy9h015ioO81bezdI1UPFOD3fW2WmE7Vb/mGwvqVtZ9JaAPRI9a56XkSOmc=
Received: from BY5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:a03:1e0::30)
 by PH8PR12MB6986.namprd12.prod.outlook.com (2603:10b6:510:1bd::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 02:36:16 +0000
Received: from SJ1PEPF00001CE9.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0:cafe::71) by BY5PR03CA0020.outlook.office365.com
 (2603:10b6:a03:1e0::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.15 via Frontend Transport; Tue,
 16 Jun 2026 02:36:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE9.mail.protection.outlook.com (10.167.242.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 02:36:16 +0000
Received: from amd.rund-run.pensando.io (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 15 Jun
 2026 21:36:15 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
To: <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <brett.creeley@amd.com>, <eric.joyner@amd.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <jacob.e.keller@intel.com>, "Nikhil P. Rao"
	<nikhil.rao@amd.com>
Subject: [PATCH net-next v5 0/6] pds_core: Add PLDM firmware update and host backed memory support
Date: Tue, 16 Jun 2026 02:35:48 +0000
Message-ID: <20260616023554.258764-1-nikhil.rao@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE9:EE_|PH8PR12MB6986:EE_
X-MS-Office365-Filtering-Correlation-Id: 39122cf2-68d9-4670-6e67-08decb500a40
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|23010399003|13003099007|18002099003|3023799007|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	dQ/xNvjUEFZqhXVjI1mMsmTj3bIWFohNWQx+CxjxfR4aPSX3hpyZhjbaOdaSd5nOOuZRiZ9CUoM88/8Os3ZDvZv8mwT7M32s7R+sMWrkV6XfEIljZwaev8Xs2TgUeKdBJQ/FZK67xCMdIrQzufHyMwb57J6xm11V9ulaqp9jPMhddO0c4YelGTZjytqJjaG5iwqZi5odbYkJ++w8hx13tq2wYdPeEnItk6u/Ppwbd13wvm75uCERqMkV+OuS7fDYVycOq+OVgNhwN81xm3/XCOmWcMH3124XZ6roy52ZmF0kr79ayOH6aDH+2Hh+Six3ngjx1OCcQhAv9gIOacCoWEdjIs6MEDvPBeKpa2RGV64ZP4ojDW4vvaj5RYJTnnJcGCTN2TaC7pzNfWsEdByyHTygp/LT1SBb6taGJCshbP9mQ6NtibCkniYH0CHkhYVGkNck14giepbzD6tfocKrYGNKTj6rFOFHZB0Lyf2r5wecZah/ahDxuY9rnnbP0g9dxdOe6zkcIoX6C2LgdECQHgQ88+VOmrJXz6u3aPC0o3+hVvLGvb5r+yb6kjIUwLT3qHNE8tdR76UtiaTHhWCBe+c2goXFfzEqzVmlu9Ah/mWQy8hgB5fR59Dx3uq9nBUwnEB6pzCr8ZcuM53bMbNGriPzuSfSXJKVGY+5XDs8hZS+d3PYXqXPWpcw/fYYjPoMuhJ3RHnDDrn4MMiqMuI5E+2F/C9QCHhw1CqYncVmLoE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(23010399003)(13003099007)(18002099003)(3023799007)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HBNqZnrSXI3NLRWcjZ+Z/jxscYs55S2B+c/kc/2Iosw4x5SULb66nAtZPrTqgIKTJo1qN2Pi5ScBCvH07bc/AQyJrFGiFWYhRwlmotZ24RsFlAjJBgKSisopOHWaGlBLmxH7YKZJa3LVk9U1y+sbxTtKfOzgUM3NqOm/d45/NCn+FeOvoxUjI3IHK7p7sSMUmX31LHBgGAHAcm802LQclssfYHBKRips6GHrrkIHA5VKaYUVyFJIpYV7uQrMuxtFEzVta6I5dWBfo4XA8dwbYNQhEEjY8ByDlHIzhVOHVZ8w6N8NsUZ2e9YvfffPantWzDYhPzXVfIWZ9uwIIOS0h0X5n4xEabx14ZuU4IBO9tuYPiQe2g/51I1KJHEcFXwuCban2/hPttkI488qm0SkZS46fXBEeQnlkiBoBi2k4GCNTBFlFfDYLU3RFnni6nHW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 02:36:16.1896
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39122cf2-68d9-4670-6e67-08decb500a40
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ1PEPF00001CE9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6986
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
	TAGGED_FROM(0.00)[bounces-299716-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kuba@kernel.org,m:brett.creeley@amd.com,m:eric.joyner@amd.com,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:pabeni@redhat.com,m:jacob.e.keller@intel.com,m:nikhil.rao@amd.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,amd.com:dkim,amd.com:email,amd.com:mid,amd.com:from_mime];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 62B1968B82C

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

Note: Resending v5 - patches 1-6 were not delivered with the original
submission, only the cover letter was sent.

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



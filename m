Return-Path: <netdev+bounces-273221-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPTfG62Pymn09gUAu9opvQ
	(envelope-from <netdev+bounces-273221-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:58:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E038835D512
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 16:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7E68B314B36F
	for <lists+netdev@lfdr.de>; Mon, 30 Mar 2026 14:38:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 072612E92B3;
	Mon, 30 Mar 2026 14:38:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WiKLC3o1"
X-Original-To: netdev@vger.kernel.org
Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013017.outbound.protection.outlook.com [40.93.196.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FECD2E62B5;
	Mon, 30 Mar 2026 14:38:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774881525; cv=fail; b=LKerRUPD52Cbr7+1KujM0cQKBtv0MWE5Db4lecSw0pkR9R3k9mtCNHCMMKkWfVTe4SM0ydX5pEhXsW4vFCXcWBwRyQRQL7bVoWyJbGRHNqzqgutgVLun3GT2OdOjs6+B4DCVjyWWWaOgZ3dDYODpuWgIg/ZHODV415WQnIPsaEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774881525; c=relaxed/simple;
	bh=roo0AQ1V8ZUE4js+l3eRSO28JtQAEbtLjnoMcwD0ME8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=blmwrmu9BoEsqYHF+dm0FwLl3gLoOhRlOStj62tdcmZyl5/9gPegjwHrUfdLard2zUNTprY4Bkf6gDzyjUgkYcKwRzFZhqK24uQt41EuXvl8g/Wc5+AmgwYAEBun15hRNpRyWR3SDkdJmhrGIMgafr4nxstCyzt0Al87bLBQI8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WiKLC3o1; arc=fail smtp.client-ip=40.93.196.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YJU54lb925/lwQrOXpxJCgb+c5PNvDVRV9UxLy6ah+Rl5OtlYeXxdmWbdymf3I8CnLsd4hOEe8loLAVsd1OEttQoq+5Wl78piNHTgG/j1czsLchZJy/CE7ze94X/qy2ePfzUOYAOkum6bt4RP3B2r8ykV/cRkTtU67Y6wBEGO7xmH0n06Qxz/SHtunh6efUi9SdFYpGIFnPrr6b0rXAq3SO3XvdguI+ZMp+Z3KtoRZaVyJq994a+9/vFvExzznrIEdRREz23v6+WrQwhK3zOHp6x9JThGE1pHv1bK+nOTgWY8qyfCPfCrX4iYbQykDN9+kDXYbZO4lJc7agFVS8M4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uqWxNMGB2wi0n1T6dT4oeactsOmnszaGy/hLsMolnA0=;
 b=VB1Xmz/ON0eHiEqGS8sSZrw9PWmH0HuJUnufVRTK83nZDvwiWT+/SwBCSgVEyc247pKdXg/g72+te4ccmpDnXS20x4x6Az2hVxUo8OoNcT/KtwQXy5G0SMnEXcje0qML6olCbXw4rNukjHa4nVvt3lzZUpbRbHEy6NF5hQmDyw2DUOwdf8n1TsXgFqTBGm1waQN8Cqepaqgipi6E0abcSR8qB0cfNyfk7bzw2qZXZeeuGbdfyC2grIMMShP94iX0r76TLlWwG+OPB6kvMWy2/dNHxtOTsgYCMVVEFfT06ymiazZmzkiNoGVXISRZu8/cRW+W3/jeXidt4RWwsrZWOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uqWxNMGB2wi0n1T6dT4oeactsOmnszaGy/hLsMolnA0=;
 b=WiKLC3o1AhTW7eVOB4jAu4ln+gbt2LA1DwTyZXLWb+zyGUatiAzXVraxGR35KVkORItnyAaYwRREsW+N4jKgf7AdtHSuJV03tNuD1cBf53TP7vLyfDkf7z11TXrgbEYOSdIxJdJgNH2ntD4H5T2dejZ/XPk7LeOxxXhtOzxdxa8=
Received: from CH2PR18CA0032.namprd18.prod.outlook.com (2603:10b6:610:55::12)
 by IA0PR12MB7579.namprd12.prod.outlook.com (2603:10b6:208:43c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Mon, 30 Mar
 2026 14:38:35 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::dc) by CH2PR18CA0032.outlook.office365.com
 (2603:10b6:610:55::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.28 via Frontend Transport; Mon,
 30 Mar 2026 14:38:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Mon, 30 Mar 2026 14:38:35 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 09:38:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 30 Mar
 2026 09:38:35 -0500
Received: from xcbalucerop40x.xilinx.com (10.180.168.240) by
 satlexmb07.amd.com (10.181.42.216) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17 via Frontend Transport; Mon, 30 Mar 2026 09:38:34 -0500
From: <alejandro.lucero-palau@amd.com>
To: <linux-cxl@vger.kernel.org>, <netdev@vger.kernel.org>,
	<dave.jiang@intel.com>, <dan.j.williams@intel.com>, <edward.cree@amd.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>
CC: Alejandro Lucero <alucerop@amd.com>
Subject: [PATCH v25 00/11] Type2 device basic support
Date: Mon, 30 Mar 2026 15:38:16 +0100
Message-ID: <20260330143827.1278677-1-alejandro.lucero-palau@amd.com>
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
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|IA0PR12MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 3409d67d-ce3a-4c1c-2bed-08de8e6a0663
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|1800799024|36860700016|13003099007|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	zbDKkcEV2FIIzsNPB3O656un2MwsAWbhVJukQMX1VVQtjNSTb/HRW3udUOg3vncBhQ+7L0ojBZNeJ3X+7gZIlhpRCdfyh50Kj5n9Lkw8VQ77Q6oDiG+/40a9b5TlGW1ufTWZ+GSz2QidJodchgCDMqDpWTXQFUjqXFq1UWifMAkHBrxEHyq85AJv4ckhu/yiNsPQsSE7gqXeJKFT13xexmo1JIYVwgNvdwlbZlO2dZbzYtwjyxkChYdr+HGUVZqa/55dOVEnslIwdKa+KsPBWcRELA9IASpsQgBGRlIvCubIEMihd8Aps3E01msJROAFjuRsT2n8kZPFZsmhknwhvmsXxB5aRj54LPf1s0Q3UKFVvXw0e9iqbSyBb4qkbtzplCduGS71HG+688aTxCpUpGcCTkR8Ze9Rzp1PwlWEUJzeqzWp4SJyicb2egPzltqsNwdEoTHqnm1JRm3/wxjZZPzCdElZ74qpYbVuiOhWwIw4mRYe3axDJM+6BAQ3iUde/SdxH9rI+MLO3W9pqDYdMEnX5nXfO7WoBsZ97UlIn17OyBHpdRp/oUhl8qalbYgLbNhueapeK/bkIw+ckaP6J1Uo/x3qZ/03t/Km+NMB4C4BBwGw1loEoLYA6RobeugXdeha9J0rsumMXeMJoqdqHybh0plZ4Xx54/iMAGQfQbumYQm9HFVkyMmBzDp3DVS3Sea17n8TEB/wHvVP+hx4uQxaCuGiDuM83NnnK7y/yiETYloKst7uSvXDHPthMvL6A9ahUGAFRXL03DiITzG+uRR5CVyK5vu6sqr3ggCRAUk=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(13003099007)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Sb7z9MeOvvoiiUdaiKgDCAzmn2YzDCEHQfxyhp/+QGOgiWvV1IXpKZK/wASR4xAYOkdxXqeR01FqqB+t2bfRfcEpGqTofwtWhdKrQJAm9EGqhOSOhniwjxGT3QgyKxoHMxJvwqs0LONnD253ScpC8CN0E8zvHFjrdjef8M3qKR2U5LXMJ8C1/8KSMF/KUTG28KBU7LWUEjedoo0TqR9QZ5Y2jR1fwZYzEOy8l4dzjfJ7lOnBsK8ROkZrcYwLr3gu5z9JXJ7qseG1ixzleOgSAmJ6bXYy1RtsepkcT3KFzqmMKRX4/0B3UopI3LiTNa5iUxc9LiHn96GI+eIHPvM+Zkh8qBPJf/GHJyYnMd24uSeF+ZtU2OWiesRXIG/3viDJ5Qd2iOOT+BJ5KrJyOqgx+haU60gPbT3+8v3FbLTI1E2jXaSyWXlNQyuwvsloU9Sa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2026 14:38:35.7762
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3409d67d-ce3a-4c1c-2bed-08de8e6a0663
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7579
X-Spamd-Result: default: False [1.34 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273221-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:dkim,amd.com:email,amd.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: E038835D512
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

changes in v25:
  - minor fix in patch1 and patch2 (Jonathan)
  - patch6: get region instead of decoder and region
		  make check based on decoder state (Benjamin)
  - patch8: decouple unregister_region and cxl_unregister_region
    	    and use devm action release instead. (Gregory)
  - patch9: add comment when calling cxl_unregister_region (Jonathan)
  - patch 10: fix commit (Allison)

	

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
 drivers/cxl/core/hdm.c                |  48 ++++++++++
 drivers/cxl/core/mbox.c               |  51 +----------
 drivers/cxl/core/memdev.c             |  81 ++++++++++++++++-
 drivers/cxl/core/pci.c                |   1 +
 drivers/cxl/core/port.c               |   1 +
 drivers/cxl/core/region.c             |  38 ++++++++
 drivers/cxl/core/regs.c               |   1 +
 drivers/cxl/cxlmem.h                  |   6 --
 drivers/cxl/cxlpci.h                  |  12 ---
 drivers/cxl/mem.c                     |  45 +++++++---
 drivers/cxl/pci.c                     |   1 +
 drivers/net/ethernet/sfc/Kconfig      |   9 ++
 drivers/net/ethernet/sfc/Makefile     |   1 +
 drivers/net/ethernet/sfc/ef10.c       |  53 +++++++++--
 drivers/net/ethernet/sfc/efx.c        |  15 +++-
 drivers/net/ethernet/sfc/efx_cxl.c    | 124 ++++++++++++++++++++++++++
 drivers/net/ethernet/sfc/efx_cxl.h    |  40 +++++++++
 drivers/net/ethernet/sfc/net_driver.h |  12 +++
 drivers/net/ethernet/sfc/nic.h        |   3 +
 include/cxl/cxl.h                     |  13 +++
 include/cxl/pci.h                     |  21 +++++
 22 files changed, 489 insertions(+), 89 deletions(-)
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.c
 create mode 100644 drivers/net/ethernet/sfc/efx_cxl.h
 create mode 100644 include/cxl/pci.h


base-commit: 64584273dfb8a1e5fc7d78094ba22a93c204b44e
-- 
2.34.1



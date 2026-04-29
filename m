Return-Path: <netdev+bounces-282274-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDxVEqm68Wl1kAEAu9opvQ
	(envelope-from <netdev+bounces-282274-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:00:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A494490E07
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 10:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 60E5A30733BC
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 07:58:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347E63A6B68;
	Wed, 29 Apr 2026 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YolXFiZw"
X-Original-To: netdev@vger.kernel.org
Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011053.outbound.protection.outlook.com [40.93.194.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90FD63A5E7F;
	Wed, 29 Apr 2026 07:58:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777449505; cv=fail; b=dG2KlD6dV1YyabFyOyz12iZa5qh44z75gTsFJd0B8OxJJDl9B03LsTkoIDJAl0Zh9Uu8I077QCy5uWJmVznHWmZSN0Jrz0SUuKBAi5GM9ebt/TIsGHFXT2lsFC9a1anU3CDZ25RYOKohl0brXGalpFcOSo4kzmvwr0N8Dp0CiRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777449505; c=relaxed/simple;
	bh=+8c0dT/wsEB3PYokv3LzFbiTS5qAQFzDGKPWaZSNcQU=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=gznQJiKheZDNlcQqCmPdBXzQG4fPntspMydJNG+qmUbRYUw1t5NgUEfsy18JB7rNIbDNZpMxLuBp1f1zNMh1T1MCMetysw7O3uNBmNMjxh+2gH1qoo6UO2r2+cFBcKPsfynjTrS/MzDmdBJES8X2rPG9QxxPVe6B3rU81eNLMyo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YolXFiZw; arc=fail smtp.client-ip=40.93.194.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ij3do5kfft8TbY7fZNJKnaM94WVdemiK7LnRgItJLMEnYsdlX5lHEFTmOOckfq5FXH74pUfQ4zfhD56OKfJDVVFdkU6kjzcKt8WHilTuvuRVCLV5ZHzLq4AGamX+xJ6B2ieo17KBUKmnzcEhOqEL5s4o4Q9JPbrst1X+0nF+8g0URhOA/VkhTwl1E6Kq7AM4/Q+3oEd8gUzo1RdH5412kNQHDH6fW1aBsR7C7y1bGWXnPTzrf/KRqXAX3ormT5PCqMx09NADyhM4mFUnTqYi0IL5yprGQjYeLIsKlLfXehKBx90cUkoCLynfDJyJZJGRhnPQJ4AIlFS1kRRN2OoD2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=seTb7Kh6JcgJNfchAnLnBf9PDKgCCHI70VZNcfy3AK0=;
 b=KG9nvy4ysLv+bh1b09DzUQuSpZt3p5c1QZLf8YblSxeMDrRcnhcWxJT2Hcgf1GspaWNeLVEMjhGcH3DgfXrXEorNaX6TQ1M1R+/xSD0UjvV4udoX0q8jfvpPinVUKMYi7fb7axUWYP2SzTW8BeAWcljIrI2SZbb14Icv+fnqBr1DBMxrY9/Y7umVhcErZWT5VxeKXzXExGpeWMuLYWFi+HUGy7zfCOmg0/c2I30Eju1Xqot0KDebj9OnnMfW0eyXhL7iB1kTJrKwpSdBfctUhDq2jtl+szM3l5EHnMAPJ9rWywUNOdVd4UZhMysdZFu9siVbljIV20XaoQZ1D1Qqlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=seTb7Kh6JcgJNfchAnLnBf9PDKgCCHI70VZNcfy3AK0=;
 b=YolXFiZw1xLdTeTetENpJbgyvbIpzO5ZZOWYkZISRpzJLInXsve/bj8IcHspCT+sW8/kuLwzvJyH/2DGp8Ow43atIDRy7jz1/V6NHYM+E8Er1HZZ3sFSMu983ja02EQeWHdur15LwQhYu+bc36pJ9dkAoM+tGYInYpTq5d+CWOQ=
Received: from BN9PR03CA0290.namprd03.prod.outlook.com (2603:10b6:408:f5::25)
 by DM4PR12MB6232.namprd12.prod.outlook.com (2603:10b6:8:a5::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.22; Wed, 29 Apr 2026 07:58:17 +0000
Received: from BN1PEPF00004681.namprd03.prod.outlook.com
 (2603:10b6:408:f5:cafe::ea) by BN9PR03CA0290.outlook.office365.com
 (2603:10b6:408:f5::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.28 via Frontend Transport; Wed,
 29 Apr 2026 07:58:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00004681.mail.protection.outlook.com (10.167.243.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Wed, 29 Apr 2026 07:58:16 +0000
Received: from [127.0.1.1] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 29 Apr
 2026 02:58:15 -0500
From: "Nikhil P. Rao" <nikhil.rao@amd.com>
Subject: [PATCH 0/6] pds_core: Add PLDM firmware update and host backed
 memory support
Date: Wed, 29 Apr 2026 07:58:04 +0000
Message-ID: <20260429-b4-pldm-b4-v1-0-e43b6c92e46c@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAy68WkC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDEyNL3SQT3YKclFwQnWRsZmhmmWppYZZqpgTUUFCUmpZZATYsOra2FgD
 nsdt8XAAAAA==
To: Brett Creeley <brett.creeley@amd.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Kees Cook <kees@kernel.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, "Nikhil P. Rao" <nikhil.rao@amd.com>,
	<eric.joyner@amd.com>, Vamsi Atluri <Vamsi.Atluri@amd.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004681:EE_|DM4PR12MB6232:EE_
X-MS-Office365-Filtering-Correlation-Id: c959eaba-e654-41b5-d049-08dea5c51252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	fP+dnZawCUbhJ8JHxpHXRy8SEclQWPeUNQyBOTwqblII2bsNEFzVVj75z5EmFa79EpXBswUidhF/iZAp3V6/G43qG0OOv5kszvP+peYfTAsit9WlRuCEYN/wkrQFZ/Zjm6JvCyikPj16Lyc689x0DXf6QV0D3HEXdkAcc9MFt3UWMQyvpwNhqkT7hvDOQh5ad39HCLewabQwM/lUNXcaVvP4P1ZvfqlV/32MYrwunwp2NQfmCO5mrdsQWxEmbEfBO5sZoOTF5w6av0U0lDlDPUl8G0SQo7FrLRDh0KS8KJRZZgGL4rivwshePodrtWX+v+mHuRjaUEL9pxyqWHPWATgUzAoEAsHemBNAMmJd92hXC4L/mLJKanWM3cYyEVi9VkPsrxRiJfScg09z6of/paLb7+uaYguRc1HNREf7La7EnX1V/BVqLNyXLiR8XWesWIdp9T6slEd7nk5OZomsVZ4X19ClNQ8GwU1/B3izE7UkOA6xDSniOhKYBHMLlAkuSxNKLp9LlKosTZSNgVHS+m/ByZglmcrf4ovDgt/QBzMJPTceeM6toiy2XTU2G/9BdGC4CkEZffjH6C1rM4FKC9ZyO7YeMuLmUfRdJycU5munsjpyDfHQPBLRymbln7na389N11xNSIx6JG7/jGzpapa8Ir3e570DRM9xZK3FuKZK42AMWnZVBaJytqVK0DQthFUn/QgLziBCHWXfH9SCWixw4orXs5g6wQejF9Dv6cTPjTNWGZi2WZ3+b690xi7/MeAvWngrU3tOpEzxt7UKaQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kOVsboNcjZwAgJlUeTApvb3X7w9DXbaZmSWsaGHvKUoSubJ8D0NcXS9qMvjGNZLO4Q1oSeHMZn3fwAGIm0a5EI4CiOvFy8hsQpI0IScGyD4wQk76pvQzsWpKWFw3U1/o5PlrQliP/kjFrQCZevb2RMM3O4DXNg9brO25Fsy2FKt2NDJd9zZ3tEdllwY7lGOSLGyX2prFvdQ03ROOBh5jqCqFgB6qLb6T7B5KoLwFkS1l1g29JSuOD66dVndpuMXU77g3yQCwAx61X8bjN//Bdm95CbCeMEMbCHu4lNkx0YLDawUnLEA5eMV5TTftsEC0SlV4FKBwg5th0dyEWuDu0zpSZn2FMmxYCFZhpv/zc9498+g3S/E4UOL3M2qBqXGT6LS+hBDBqV5pXG8r4MhGdObM3p1Bp7+SSPbKWAwRfLD2EKzIgbOVN6W7IJQvF5+W
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2026 07:58:16.7345
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c959eaba-e654-41b5-d049-08dea5c51252
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00004681.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6232
X-Rspamd-Queue-Id: 4A494490E07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-282274-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:email,amd.com:dkim,amd.com:mid];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nikhil.rao@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]

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

Signed-off-by: Nikhil P. Rao <nikhil.rao@amd.com>
---
Brett Creeley (4):
      pds_core: add support for quiet devcmd failures
      pds_core: add support for identity version 2
      pds_core: add PLDM firmware update support via devlink flash
      pds_core: add PLDM component info display

Vamsi Atluri (2):
      pds_core: add host backed memory support for firmware
      pds_core: add debugfs support for host backed memory

 drivers/net/ethernet/amd/Kconfig            |   1 +
 drivers/net/ethernet/amd/pds_core/core.c    | 166 +++++++
 drivers/net/ethernet/amd/pds_core/core.h    |  33 +-
 drivers/net/ethernet/amd/pds_core/debugfs.c |  43 ++
 drivers/net/ethernet/amd/pds_core/dev.c     |  86 +++-
 drivers/net/ethernet/amd/pds_core/devlink.c |  77 ++-
 drivers/net/ethernet/amd/pds_core/fw.c      | 699 +++++++++++++++++++++++++++-
 drivers/net/ethernet/amd/pds_core/main.c    |   7 +-
 include/linux/pds/pds_adminq.h              | 132 ++++++
 include/linux/pds/pds_core_if.h             | 381 +++++++++++++++
 10 files changed, 1603 insertions(+), 22 deletions(-)
---
base-commit: 1f5ffc672165ff851063a5fd044b727ab2517ae3
change-id: 20260429-b4-pldm-b4-b36169e986e6

Best regards,
-- 
Nikhil P. Rao <nikhil.rao@amd.com>



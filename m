Return-Path: <netdev+bounces-268987-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFs2FkCWumnSXgIAu9opvQ
	(envelope-from <netdev+bounces-268987-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:10:40 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AD6E32BB420
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 13:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 55F74303207F
	for <lists+netdev@lfdr.de>; Wed, 18 Mar 2026 12:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C554A36B058;
	Wed, 18 Mar 2026 12:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pivabiM/"
X-Original-To: netdev@vger.kernel.org
Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011040.outbound.protection.outlook.com [52.101.57.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E107364EB7;
	Wed, 18 Mar 2026 12:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773835837; cv=fail; b=KUYQCADGf7QavrUAfdXjW0+Qf2cqvfI4qKhQNScLpzlM/Hks2ijGGQFoiQZWmuW/D3CkWKSI6z6TFL0dXlRkNSzlhiuTxff/CTkk5ig9fjPsA5vQDgm6aDjsBj2wYJiud36WJr8qrs0Ln4KjHFG52M1rmvFpPsRAli2Nhk9mwAU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773835837; c=relaxed/simple;
	bh=8Zhz2DAbAsxTPqGPUvNpt38Nsv/HfnnYrxEYydNjjBk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=llRvi69Xj/U+aruPkrzW2Yb+0mxECz7+5zxoNPebFvgeRnlmsic+s+M8DEyaIhgIEBFN0/fsslJ5JskwYoiuaWLDRvuqnoTv03cc+FZmW5DGOGQFJWGD5OkZyBTB7PnKNqGdHcXT91gsw4TzuHO5UA7A+71/6kCLR16zTYsMAh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pivabiM/; arc=fail smtp.client-ip=52.101.57.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t9o7zygiCQG5dKsXft9U86pWkd8TOVfF83ca5btndp700R6Spm+ab0EgcgFEW1eBQJuLGhyXvqYXMH4EbeL9fF3z7c9FotSMI9a9/4rmCb8NchGZstiVZfoIdjgwLVmCeB2rzD0LAAtYvBQqv02xEBMyTPCCBLCeDC03QM2Wn/tez2cbwi7vY1SfDrKCxRwZz7ah8Jv36Ds0Ohw8I6L5sSxa1jFCt59yN32x77EaWbke4vWdwCmwCUoq7PGFN3LEgLKUbwK1vCP3se1/7u3jMJMEOY13kPiizulhpEoddk8BUGjRqNSwZXVp26tSDxaKkECXD2XGUqcvUoJVeV1wlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nQpGoqI4A1k71uou+t79t31VNZDv6D6+NeJhi4hsuvk=;
 b=qsYap1dEVDNJjlH18l3XP3BIYG6IZunhax9BdYaizqvqFcs4zOQJq9rvPa1mSH23tnGP02FJEO6Th++/eG+a+tB6saSHo5GLUOwL4QNw+dV1dJHKHOml+umU2CvEAZq+UnvUGT1/FQN7sa7G0QQZeXn6Wd1yD/R7D5p3xsng41kqYSH7u4It2gW4zK1pt264JmG9w31Y/39Rv0bar0LqxLz3b8OZnOqDSxH/B9bz6IEG8Pfl09jfWXBSrxH7ncrkswL4QxkFBGe1QeBZ85DK03dZRyMGPllE1SMqfOlsXyPEIWNMUevRa1WP4+u+JobkknUSubMaD+XbHYVuftOtqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nQpGoqI4A1k71uou+t79t31VNZDv6D6+NeJhi4hsuvk=;
 b=pivabiM/wox0eGll5bdmqi6C8+yOx4+BqMKmBISQm/oshCsL/BtIatWFv7eKCYnbWLwtnT/jrgDQEQsXVJUVvRrUlYnMMqWLhT6tAv3FjylruUQt7yqeWtpaIpg4L1KXqRLk+vPTOp7FyGEWirvGqg5G5kpu05I1bCa10mI45Po=
Received: from DM6PR02CA0127.namprd02.prod.outlook.com (2603:10b6:5:1b4::29)
 by IA1PR12MB6212.namprd12.prod.outlook.com (2603:10b6:208:3e4::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.9; Wed, 18 Mar
 2026 12:10:31 +0000
Received: from DS3PEPF000099DE.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::1) by DM6PR02CA0127.outlook.office365.com
 (2603:10b6:5:1b4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 12:10:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF000099DE.mail.protection.outlook.com (10.167.17.200) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 18 Mar 2026 12:10:30 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 18 Mar
 2026 07:10:28 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <netdev@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <pabeni@redhat.com>, <kuba@kernel.org>,
	<edumazet@google.com>, <davem@davemloft.net>, <andrew+netdev@lunn.ch>, "Raju
 Rangoju" <Raju.Rangoju@amd.com>
Subject: [PATCH v2 net-next 0/3] amd-xgbe: TX resilience improvements for link-down handling
Date: Wed, 18 Mar 2026 17:40:03 +0530
Message-ID: <20260318121006.1565435-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: DS3PEPF000099DE:EE_|IA1PR12MB6212:EE_
X-MS-Office365-Filtering-Correlation-Id: 3dd1b1be-4557-4917-0d1c-08de84e759aa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	R+ZeBJxxcPktE8SHP795ZIorygQL/sQ7UREK+uQdhpDcQcAH7spFtKaqAXejh32OflBPgJvm5t61Fk60kzS7mkmLrARKuByJNZ7Qdh7/57HdFHTnVf6G0yXvq47S073Ld5Ik8mREMGpg+mk0d/ZPZqRUQORvHmfLr0ceQTAmSSAasKq9ZG93L2Her0q1pkWwtDTqnUnp0/Ym0LzQoM8LOQY+6I9NJuzV9WJ3JDDuJTCSDhmbNI/7dZixVGOOhycqdsYchZT47Yzv52lx/X9T+P2d1/YJJXWXGsMVCoM2ew6slv0GcI8itt3Lmc6xhj4f3OwJwIWKx8K3plTmvQuu6LjdcQHtOFSmwqQsHHXPsUFCuWswDUwY4L3r/e4m0HrQo8bL5kjYcKMzcyQDSNAKbdBr7tmctF8xr5Znod2hDg3AC7qfszkqn1Cn3rqMH5hDe/OtlKhbHOWHHOeAdPPmkjWOUH3fAlM6UoDQJQhJM16yPQg1rRVfvm1g/K75YFG/wIdtnECwKdghvzf83fNL7+8S72ZRHrrs97oAIXzLervw1b42CPQSzf1e1d7B1Pups73UOC1dAVvdQ9oLeKVaoHa0zOWRHd0DcE2RxxvCyJuaeg5Vnh9BQ9RrqKcAg5qBIxmFFaCV7fuSpBUZHRP4FUIf2fhY2h5FqlPDOyEkAGcCL7Q+foNP+Qly1Mmt7rqXT+7Tm/vX74jVIJ0VB4LKN9gA++tDGcMFSZjsqBxw2LZy/HWJ+z/Ij6IOQ+p5+VM1DJ4lSkeKMVOEoT0Y9ailww==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	74UYe+aSvxMEacy9sy9f7LDQwc9/RC6alolYH6x7Au/gnKbqZG2wtbCQKTQVlR+lLkl17LXuqDi3lb6ytqQULuzKHi+46dIH/SpI5XcRd6aTcLqXqmomMBaBp3+1Y5SVH3t5AaROP7r6V6vzgBh/zv7rEmfzUuK9oVP0pn4Ql0ekgq91B9jGqwDV00jYbRVYc/BpnJy9r3lrYXwbAyqX7tII0YNNOfCQOZnUtpVzwBSzFMD/82Pdqn3USVPP1Mv/L3Go81a2U9ISAjijgYJajZ0Hn7sIm1md9LAeKOD9rf2NzFrwNj6oQJGMgfYlA5x6OgU94+Ztm7Hnl9Fug1HJvXpwcZds79O/sfRbT3FBpC4ZB6YUakFzSv50X+PzXNyVTrgxCulqX2BWQfMY/Z7wSrRiOpzbATpl3gQ63+QLd0byMJgM9ZdWfFvKDii9RpcX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 12:10:30.9330
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3dd1b1be-4557-4917-0d1c-08de84e759aa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6212
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-268987-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: AD6E32BB420
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series enhances the AMD 10GbE driver's TX queue handling during
link-down events to improve resilience, prevent resource leaks, and
enable fast failover in link aggregation configurations.

The three patches form a complete link-down handling solution:

1. Patch 1: Fast detection (know quickly when link goes down)
2. Patch 2: Quick response (stop TX immediately, skip waits)
3. Patch 3: Clean recovery (reclaim abandoned resources)

Changes since v1:
 - The original patch is split into multiple patches, to better
   isolate each specific improvements.

Raju Rangoju (3):
  amd-xgbe: add adaptive link status polling
  amd-xgbe: optimize TX shutdown on link-down
  amd-xgbe: add TX descriptor cleanup for link-down

 drivers/net/ethernet/amd/xgbe/xgbe-common.h |  4 +
 drivers/net/ethernet/amd/xgbe/xgbe-dev.c    | 86 ++++++++++++++++++---
 drivers/net/ethernet/amd/xgbe/xgbe-drv.c    | 67 ++++++++++++++--
 drivers/net/ethernet/amd/xgbe/xgbe-mdio.c   | 18 +++++
 drivers/net/ethernet/amd/xgbe/xgbe.h        |  3 +
 5 files changed, 161 insertions(+), 17 deletions(-)

-- 
2.34.1



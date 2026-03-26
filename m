Return-Path: <netdev+bounces-272208-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4CGNFlKCxWlc+wQAu9opvQ
	(envelope-from <netdev+bounces-272208-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:00:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1994E33A9E6
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 20:00:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EDC5A30A0ACE
	for <lists+netdev@lfdr.de>; Thu, 26 Mar 2026 18:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB0543A3E72;
	Thu, 26 Mar 2026 18:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eaUxL8Bw"
X-Original-To: netdev@vger.kernel.org
Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 183C6425CF5;
	Thu, 26 Mar 2026 18:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774551323; cv=fail; b=KGouRR3nRQEg4mNpiVdIgia9+nKEBNE7sXQCKpPLjjTHhMvagjUGsyEG2q0fv638sTVr4agrCcGikPAojTvVDloZ2y/1arxLZg5n4j8HlELkJOwHx1y4LPqYBIujqSFZDbcd8zgfpANKf2zgQVCFgLnL/KLki16fOGgERh2kXj0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774551323; c=relaxed/simple;
	bh=D4Xo9d5ECb2xkXsdWEXBpDwTJVvFXNevXYR1KclmNk4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fMzh63bp/xT1uZEz8tN7RAuDzjeESaYNnJxwBry2YgiEB4R6GeOGA1PZdUNqdIeQ07DmxSTFjbhRYXzerisfBNrJBVy7w/t/cyTb7WhzppPWsQY/FCexcLa4gDqw8lA5G8RAmVDfaYOsXVadPNnm68nz+IwpMA/f8mnCPT67OPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eaUxL8Bw; arc=fail smtp.client-ip=40.93.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VCD8wH/ThRxkk4QrlaT4HxjQFXDspyiD1XQ9CUjnR+wt8qFftmoukQFBErX+b5g/rq32pR0IShhsRH6qbz4bZ+fWxBz51Sw6mvnXRqKFim4m2PozG3eMcWeKULQOQliIwYYxwl2FoMkVRL8JP1bj7sAq1r8JSS6KCthLqztVvmQgu2zYmRDvbkQZaGY1EDLdyC83Mo5j23BeQ9LO/uVwKQpJTI8DHoRNNqoW3pgODW/nGumE41lQ23XHwVwu9IF/hRZ+xkxkHnvsWKs1heIFF5vbdngIs/2vqmv0hV1WhsZlrK3GuJ+BzM0dpcrfj2VukXpAspVJHX5j800bRUqu+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=70dx2TmCW1kN7PAsE0EPd3QnAagndkpU7G4X0MLAceM=;
 b=M/HfgSCCYmiL26u54teGoyBi6YjoW8RFFktVYLJQMtWXnOM7crnU9+vSmHbOfraBSvrZ5sznyLTSWowiqFLHbMroZTXyd+B2YGwBZEy2uGR/rLe9ZjvfYREo0HyDMm/QQxJZBpC6at2n5QY2lPSfa7LfoUKg8j818SYet/IPKgYWDHFF4+9wDyAKCqONJ8ThCxOaIKzWu+hz8CgwolVSxZA/nS3e3Xg3N416xLWRJcGl7E4bEclI6A7sfsktjckptWvXlKdyDZ7LzT86D1ZlqUwQsKI8PVgkK7x+V0QhG1W0DEIcKgY929nyO35aeVFCSSkC9OblwRSM56KkSsPApw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lunn.ch smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=70dx2TmCW1kN7PAsE0EPd3QnAagndkpU7G4X0MLAceM=;
 b=eaUxL8BwydYqy6vOJb2MgwRG66stTafIxy8EmHsRmEbx6dfR0bjIzPRCn5KOXd4ZwpqPUeT+QqcLU9rpJE56F9JV3+ysvKE2TbwvIm8FaoNJ7eQ7NGgk/RzZDC3lPc7XZOQxU/mhxjg4BV7it3jiedNs6nKCCIw2kBUF3ytaQyM=
Received: from BN9PR03CA0415.namprd03.prod.outlook.com (2603:10b6:408:111::30)
 by DM4PR12MB8498.namprd12.prod.outlook.com (2603:10b6:8:183::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Thu, 26 Mar
 2026 18:55:17 +0000
Received: from BN2PEPF000044A0.namprd02.prod.outlook.com
 (2603:10b6:408:111:cafe::6) by BN9PR03CA0415.outlook.office365.com
 (2603:10b6:408:111::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Thu,
 26 Mar 2026 18:55:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF000044A0.mail.protection.outlook.com (10.167.243.151) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Thu, 26 Mar 2026 18:55:14 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 13:55:14 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Mar
 2026 11:55:13 -0700
Received: from xhdsuragupt40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Thu, 26 Mar 2026 13:55:10 -0500
From: Suraj Gupta <suraj.gupta2@amd.com>
To: <andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <michal.simek@amd.com>,
	<sean.anderson@linux.dev>, <radhey.shyam.pandey@amd.com>, <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <harini.katakam@amd.com>
Subject: [PATCH net V2 0/2] Correct BD length masks and BQL accounting for multi-BD TX packets
Date: Fri, 27 Mar 2026 00:25:07 +0530
Message-ID: <20260326185510.3840084-1-suraj.gupta2@amd.com>
X-Mailer: git-send-email 2.49.1
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
X-MS-TrafficTypeDiagnostic: BN2PEPF000044A0:EE_|DM4PR12MB8498:EE_
X-MS-Office365-Filtering-Correlation-Id: 20ce70de-413f-40b9-ab6a-08de8b693716
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	osh1OPd5W+A0u8Q2IbTwL7p6UxsG6emFiYj6IVMCk+cCEL9/o2DwQ1l73+cPtzIhNM9QKO+cOUl6stWzHUapzfoOuBMOMXn3EgY36XM0x4esUehstHxHqLVumsIoAs0oav59+3Z0fgK46MDQt9cRD5xWQzTZu5ztY7PnyCg7uUSwELAr7oxnSDvqhDh6PC7ouAEutAL3tfwTT30ZV4aCtM2bKY0tin7NRMtGFu1L+ZxLMm3c1iwN/uV7t+2OZ8zdj+BzKutkhz2BfXaCWZZanhS1A0tCvWJ5Jmflzod6aFsC19snv66IyAvZwnAAlVJDX8dQENKqRnyRIgbeaASBONS4HJ0QPRX+YuwVRZ2HcgeBQhTZ1E3RTLv6RdzsDwrRsgcZ5iw+KnGkOksnQOwQEG7CBeSncFrNqWKzBmzOlaJxqXe+3Lc/YMpTESJiQXl1xXunI9NQiR21U0tn6QtFrMXigDzKoatypisoFedsoUqZrnCwYEft/TI9HP9RStm4K4T9mnH5nJbcxi9YtmmNscuz7g8NFs+pdiD3a828u4kV5c2DIT4vkDsib6fxMBUZVoMrujQp016wZIASAyQzuukTtW68kzA4nCj8pLMWzx2O8VUz2O57XVZYPVhqyBf8sfz8kZvE0VvMEn5WT4EDLgWWmgHIh4Y3cWGWHewvekQb94rm9pkdOtw1oBy+mrbk6qUWJvMeHKo1huytMbaWzZRYdIXO4oaJjyJguEjbCG/kGCGrbzFifs1lPBhaYoJVh651T8OACmGiB26JCzkYkw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	q2XVazAeif4JOuNZMrOkM0yjnzYj5VJyD8m+YvxhUveHhj9lXaUFnTYYnIMDYIZjRiVvO+/DB3RAYRQnwFfjrp91WBgC4HW37avS89V26Z+DtG7TJt2YSs35dqRuhfaLai3ZwCjhEWTvZq7faTusiREOEgAgU4QyfxKczHGtmrETzJSYIfrGhkuWh1N/MvgP1m7GIJB5IyYegs5qt7YU3OYM6PP0xS2nCUlRKUcWfoINSyykkXqlP1j/qwVAJqDMRrn3WXp2kyd7hcVqhd240CD7KE46Di/gLIP+Z3dQ0ieSXHo7GlavQsqh2aDvAlFQIzdPgoqo+XZRDuP8dxj7sIii1LtIrTMXevcURxjq4yeMnU5HUAS9pMx31AXsPVmt6lvbR5WBzLQIHxPcI5HMOU8ajSIceQCaFxuJt8d5HTQ3fHoKr/b6ujpJUDeROtNc
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Mar 2026 18:55:14.4838
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 20ce70de-413f-40b9-ab6a-08de8b693716
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044A0.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB8498
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-272208-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_TWELVE(0.00)[13];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[suraj.gupta2@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,amd.com:dkim,amd.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[9]
X-Rspamd-Queue-Id: 1994E33A9E6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This patch series fixes two issues in the Xilinx AXI Ethernet driver:
 1. Corrects the BD length masks to match the AXIDMA IP spec.
 2. Fixes BQL accounting for multi-BD TX packets.

---
Changes in V2:
Use GENMASK() to define the BD length masks.
---
Suraj Gupta (2):
  net: xilinx: axienet: Correct BD length masks to match AXIDMA IP spec
  net: xilinx: axienet: Fix BQL accounting for multi-BD TX packets

 drivers/net/ethernet/xilinx/xilinx_axienet.h  |  7 +++++--
 .../net/ethernet/xilinx/xilinx_axienet_main.c | 20 +++++++++----------
 2 files changed, 15 insertions(+), 12 deletions(-)

-- 
2.49.1



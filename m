Return-Path: <netdev+bounces-275534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qbafFA1j02mkhwcAu9opvQ
	(envelope-from <netdev+bounces-275534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 09:38:53 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 931CB3A207A
	for <lists+netdev@lfdr.de>; Mon, 06 Apr 2026 09:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9A466300D321
	for <lists+netdev@lfdr.de>; Mon,  6 Apr 2026 07:38:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B673630B6;
	Mon,  6 Apr 2026 07:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="11pogHO7"
X-Original-To: netdev@vger.kernel.org
Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010009.outbound.protection.outlook.com [40.93.198.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B40C7318BA4;
	Mon,  6 Apr 2026 07:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775461130; cv=fail; b=kbVicwBSX/bxlpj/xx/kg9VKyrM7AwJtHjQWYlpLVOd7BzDqYhapRgS8dxyx8G2XdUv2kg9+IH/uiP+06HJrUkBmgkULz1qQ6I0OabNUIDehzXMh5PtmWr+nNwjKOF7K+UKN8FLceuhZtJ2L1y/wCeMOjhgEncuNRRukCOciwtk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775461130; c=relaxed/simple;
	bh=9P8f4XPudKdDx1L9kEcWaI4J7ihtU/rBDeEwGrqXj+g=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SMYoXAfQS2Vl9rKDj1JVeJKmL/k1AgbTvT1Tuw6WsRqsL9x9r1r/z+vJU3MaYi8PHH2nCNAdBU1sa/FrkFKSVWTt/ky4Ae9bmDdE7Iv2KTk8Rbsbw111cnV/ZCGxgTcYwX3rtd0cQGY8LlSyTkI/IngoxrgfsXB768vMs6TSyzM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=11pogHO7; arc=fail smtp.client-ip=40.93.198.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OpQuYFZszGjQ4uW6Ltt6gdWpYdLBqTqZuPZ7FnNSrgMAVbAu2asMCwGf2EQ2i90LGmVZbuSHijsvrlYta614KXqSfDBYJDypldrmEGDa6T2HEL2rEKs/4hotNSR7Df3VCje1rODSmwepm6/wUAfVY9XZKZ/4TqOrp+R/s5hBB75BYkWbA9iqAAmi3HzfktL+weXsP0/HViiHrZxIToRRjZLxZdxZwa3tHM07sBkBm8bSajgdy2yl6LaNrUcwy122QbZEALPsP98FQRGt+Lgcx3x/bmaONxKqVvle5t7l/YDy/r/10gqa/Fhn89hrzwxCfr649OPzZEv+5gqQxJZUww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uoV5A9J6nV10akgLn6Ya602h2679UKvku/bkXzK4UZQ=;
 b=c9x3T4fq+r5RZMAOnAT8s/MhHQhXuGCYMg75r34/OQ6ZQIRJwU+CURHLQcrNk4UMGjbZFQ4ITBA8R+o4jomyQbPYW+xQaLduXiRtfKVJrW7Ysf0gM2l0x79pjmTNL/E1pO1KT0pGUT5381O9AGAcdpq3T4YkR+FX9fr0OCEJxkzG3SZPPs8XMt7Esot5cI7Kd9vLwP0f2zmRQP3YMgQDPZJu2oQTgPLBcZaeMZXI4hVjJJP8wWOWhOK0aX997oKMJYW+gAUOMCxhLIdiAErJxt1WeFfWn165kihJWjF5wPgS6EfqQfOqiYXKqRP7Wq99ceR+EEvLDIRyNXhEqmGZXg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uoV5A9J6nV10akgLn6Ya602h2679UKvku/bkXzK4UZQ=;
 b=11pogHO7zyQkAl7DLTWuBLqh725UMZy+a7J7//E0+LbwYsb9DE6sSi7TdORTDm+hrKB2FvrO4xb1ikrg5uoZrHDgyWUroTjpsgdH/zZvfhxgFvfEpDW8IAoIHhwyOISIf5mT9O03TrNiAfmQOpk2NW9VBGG26QsDkH8KmELuhrs=
Received: from DS2PEPF0000455B.namprd21.prod.outlook.com
 (2603:10b6:f:fc00::518) by BL1PR12MB5852.namprd12.prod.outlook.com
 (2603:10b6:208:397::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Mon, 6 Apr
 2026 07:38:45 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:61f:fc00::37b) by DS2PEPF0000455B.outlook.office365.com
 (2603:10b6:f:fc00::518) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9791.23 via Frontend Transport; Mon,
 6 Apr 2026 07:38:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9818.0 via Frontend Transport; Mon, 6 Apr 2026 07:38:45 +0000
Received: from airavat.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 6 Apr
 2026 02:38:42 -0500
From: Raju Rangoju <Raju.Rangoju@amd.com>
To: <linux-kernel@vger.kernel.org>
CC: <pabeni@redhat.com>, <kuba@kernel.org>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>, <netdev@vger.kernel.org>,
	Raju Rangoju <Raju.Rangoju@amd.com>, Prashanth Kumar K R
	<PrashanthKumar.K.R@amd.com>
Subject: [PATCH] MAINTAINERS: Add Prashanth as additional maintainer for amd-xgbe driver
Date: Mon, 6 Apr 2026 13:08:16 +0530
Message-ID: <20260406073816.3218387-1-Raju.Rangoju@amd.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|BL1PR12MB5852:EE_
X-MS-Office365-Filtering-Correlation-Id: bed6399a-bd19-493d-7f8f-08de93af888e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	52guhNNOBuGGtOt9mJ5aQ8w2YGVEhnDKYQ68QqN/0j0MH319xJMRvYPso/3w+xbzR6OK2lnmuV6iSCAUOdDD4+Zpfy4/1CmZ00fvaVrBF+Sc3KBnlkFFjcp+gA3OCi64KQ/nIWhqGDvm6UyWWPUWGMFc+J2SSAqOmLi7YhAQP5UOYge2Z0/mpeEj8anOnwEXZotmps4Mycn9N9RzHfXSe0VJmPkPR4oJ+WFilNuYE/FGtupJAM3j96u5PgMzT7FSj6A6g6ckfy3EU1OQ6NR7U31CnqxnX3JonFFQx2O3z1CGziDoRTS5zTtbJelJyaYGQPtTGEOcQMP8EGPN3DmN1EennsZJ6nv2lQljII9js+SNySElooFKE6EbnmRbyM6rTRLU0MadjH2kUTplqNA+C0XjfIKrTorWI8oh/yPiADZ9AZF2SFyk6IFG9vgfcoBkeIAKC585SqTameWOM/YSiLyBq26puVtn36wm/5vanSWkjGL5wuWybBhf2V7CA1r9L5E4W5Q+IyMiTttVvevmcDlebU8adSsF2oPyK5a82fQNDCt9TS7NR6jY4veODQXGsE7jlSYM2mycS6GsziHFIn5N+0xf/nky4a0VENi/2A9fsFObFCkIf3fmQudyGj1wTe+rVAQ3Kwp6EpsLUjtuaTTIMD1VgGyWyWd/aIkI6n7/2mP2Ajlu5BokGyQ3CD5POMBu8jCWec+rF/YQVUTzQL/zTQi4jS6yo25EATTNNBXcgGh8zH8OlExGFj/bP17oeqYgFH8bRlVaKJ6yNg9vlg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	98rLOUH00NUY6dCXbddweaK1WMxLdnhHoi6Lt5/vkkCN4wum7Qj9Cm3HBT4/FiqJSj0TKRQk1/ctBK/IQxq5XCrbvgI87O0aUb7K9ZhQP9m0YDPg31gMzbqoExBZYgs/aLyNzNCb7jJlMnBJhArpuI7RiGJhusXXjTz6BWT1cFJNXH5QidMoJQy2kc2yKz6wi3wnLKSK5McnDlDWvVyHgMfO1E75zbbAl26V4h9rVpg6ufrDvZFnQk2Gf+q7bfRHLXhOGDsOIbbVv2GGsRWc+Tx7ueNfhvLOsoB57fhZt63GkEbK9QGlBOo06HAzEu3TLvqYjrwcg7bqh9mBg4NRkUs2SWSiGGydGIX7V43XiLCUfGaO883uj52il9a7b6mW12vUaOaZ4sgNkrGagvMsTN2TStkZBPPAbfHNpI5ycUSk18NpqGD0qnAXcvbG5PpV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2026 07:38:45.2249
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bed6399a-bd19-493d-7f8f-08de93af888e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5852
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[amd.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[amd.com:s=selector1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-275534-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[amd.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Raju.Rangoju@amd.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 931CB3A207A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add Prashanth as an additional maintainer for the amd-xgbe Ethernet
driver to help with ongoing development and maintenance.

Cc: Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>
Signed-off-by: Raju Rangoju <Raju.Rangoju@amd.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4601903a8f9b..dc935838e516 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1291,6 +1291,7 @@ F:	include/uapi/drm/amdxdna_accel.h
 
 AMD XGBE DRIVER
 M:	Raju Rangoju <Raju.Rangoju@amd.com>
+M:	Prashanth Kumar K R <PrashanthKumar.K.R@amd.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	arch/arm64/boot/dts/amd/amd-seattle-xgbe*.dtsi
-- 
2.34.1



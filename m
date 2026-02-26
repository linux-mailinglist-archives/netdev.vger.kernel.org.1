Return-Path: <netdev+bounces-261545-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cGlhM26aoGlmlAQAu9opvQ
	(envelope-from <netdev+bounces-261545-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:09:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51AC21AE347
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 20:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 330B6308A14C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 18:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96373BFE23;
	Thu, 26 Feb 2026 18:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="vnJtf2nc"
X-Original-To: netdev@vger.kernel.org
Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazhn15012043.outbound.protection.outlook.com [52.102.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5134A3B52F6;
	Thu, 26 Feb 2026 18:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.102.128.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772132098; cv=fail; b=PtGVOMvGG3G/iUPqbCuR7zd/r0K2BmqQFAwwfEbTBbn6FLbaFlm7ClYiLqLhhe9uYjuT4NzknVy3Eag5HJgFOf8waclddoLfgv8/kmQCuSc5E3renfVCBLvEB5laVupbs9yXZQJIImUsDWPxqF8hvMAm7RE0G7BhFOhy+Ei7VUg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772132098; c=relaxed/simple;
	bh=ja/yIGMWwxw7JlwQjfH1BiV7ZTYssBRN2x3X1vt0ipY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FaBb52kGBysQolaUbrUXhdRhSSCe9TGY+aAunTkFf3IZ8gYcrgFt8eQq+y6RVAeacjgMJGVDqGIBDBOoOROvlPKt+e/QEO4V7sYBGPtNm2Uge+5QO9ZVoYnmC4XKh3tOlAhQ0z6N18JcGFRrWyPWRdWVQLxP3kib2uYj+MBSItc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=vnJtf2nc; arc=fail smtp.client-ip=52.102.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mCCNZuNoS4Jd7SFT20z8cXVrWcxabZC/aG3lx3mZAoUQBerN5HoM32gBVrOAnW+g5CIi5CDg9HAh9I2Z8UEkSXxiWl/mkVLY3yLmgmdFeDa4rgbD36o4XIB7FSNImqhOWOwDrCvB703xRiKgPId0DnOekhiYBk2cqxiDfw8z2YUjf4Zf+3hOT6dx8vtYJUuBQ++HvPCsSbdpUjxt25dO7a3wZk90TdayTQpVV6DGg/fhffFNozKo1VYzUPE7p5R4cnHG7a6fwcOmrWDEZqXp/UamidHpZj9PZfbmwxRhwiOihb8n3Naf3UU73FwNrDT21kc20HhnHTqM8LVFb+FDqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PRZG/bOAwSWkG31/K1DHKkMuwrdImswtfVquSoxYKLY=;
 b=Ux3tkUUme1hhDgnGr9MriBOBbk9a8N9X69WhLA74BJHpDsS8RIy1PJS5hgmASUaxcJhRBf2MBmp0H+z6QphUKCC/Inftns01nIgt2i5m/AXn+x5suTwm3YI6aebvcl+S6bBoE5wv9GbCuv6UcxiZLW1DUX42KxSEIbhrT1xz/a51P2BOqSAEFViyl67hb7oM+PU+rbnhXqQs6KiQMLjzYiYrH+eI8XbJPivOOnrGZtYilv6wKRuCXIpQ9nxT3Ccb+LaDqPRBJTvsYMMEoMRxWxcJxPrNF4XPpNicZSEE4Hw9sz/bTSYy0DuDnznIw0mbiMyBu7eQC54lJ2SSHA8Olw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.195) smtp.rcpttodomain=kernel.org smtp.mailfrom=ti.com; dmarc=pass
 (p=quarantine sp=none pct=100) action=none header.from=ti.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PRZG/bOAwSWkG31/K1DHKkMuwrdImswtfVquSoxYKLY=;
 b=vnJtf2nc58xt4khFjrqvkkG1C9CW0nxKNDn9HzwscM3rbMVvSpW22mtr0bAF88O4UIyGNKEPNQLfc7qNDrJ68I91oP7XZdCPnAayoHfROQMUH9PZycNcNDnm+CeULMEzZ0LvyrYd3MnGRYwdvB3CrGgyRNZW/VslDNh6/tmqb+c=
Received: from BN9PR03CA0162.namprd03.prod.outlook.com (2603:10b6:408:f4::17)
 by SA1PR10MB6616.namprd10.prod.outlook.com (2603:10b6:806:2b6::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Thu, 26 Feb
 2026 18:54:55 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:f4:cafe::9d) by BN9PR03CA0162.outlook.office365.com
 (2603:10b6:408:f4::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 18:54:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.195)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.195 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.195; helo=flwvzet201.ext.ti.com; pr=C
Received: from flwvzet201.ext.ti.com (198.47.21.195) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 18:54:54 +0000
Received: from DFLE208.ent.ti.com (10.64.6.66) by flwvzet201.ext.ti.com
 (10.248.192.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 12:54:53 -0600
Received: from DFLE214.ent.ti.com (10.64.6.72) by DFLE208.ent.ti.com
 (10.64.6.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 12:54:53 -0600
Received: from fllvem-mr08.itg.ti.com (10.64.41.88) by DFLE214.ent.ti.com
 (10.64.6.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 26 Feb 2026 12:54:53 -0600
Received: from lelv0854.itg.ti.com (lelv0854.itg.ti.com [10.181.64.140])
	by fllvem-mr08.itg.ti.com (8.18.1/8.18.1) with ESMTP id 61QIsrLq2583023;
	Thu, 26 Feb 2026 12:54:53 -0600
Received: from localhost (meghana-pc.dhcp.ti.com [10.24.69.13] (may be forged))
	by lelv0854.itg.ti.com (8.14.7/8.14.7) with ESMTP id 61QIsqBN025537;
	Thu, 26 Feb 2026 12:54:52 -0600
From: Meghana Malladi <m-malladi@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>
CC: <kristo@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>, <andrew@lunn.ch>,
	<hkallweit1@gmail.com>, Meghana Malladi <m-malladi@ti.com>
Subject: [RESEND PATCH] arm64: defconfig: Enable DP83TG720 PHY driver
Date: Fri, 27 Feb 2026 00:24:48 +0530
Message-ID: <20260226185448.2167189-1-m-malladi@ti.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|SA1PR10MB6616:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d328090-a987-4a44-811e-08de75688765
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|34020700016|1800799024|82310400026|12100799066;
X-Microsoft-Antispam-Message-Info:
	LR09SzJvtDesR+zgVgX29TOZnnXJ3BuU7f3Sy1XR3W5yTaidhcfODFsIRJWbhsthQX/aJGiKLemAv4elZEJD4d30rKn32qPD4PBw1QY3O6Xgac0gndkHDBqwQc6LIk9H0XcT20b1FGge6wZb9a197MKXL5c206N3zTXGzKuxl8yMmAi926lgY5YtJSiJMWuuKVHDs8dAcuspIXdZ2bIGZfKQ4wB9oIPky/Ez8MYPcIQty/pzkO3f+hqgI14I1F9+WRyBuSAtxE0ddGQcN9VLq4/Lu4lvHNTcXy7DiNjILZIbRTKjct6GH4oDXdLTU0ge0t+LMLR1mbkOFvjg5IGyZWoWZ8s+F1/lEG9lB7pcYDRkJ1RDftQeyP1xNNztP0U2R3A/irpgSVLsip2vJKplEkTMRf2HbFC677N2MvImuId67MuegOifkYNGG09oiKqzeGeooYq+EcfGjrkRQ8K9A7SFVEMzEGP5dTJDlYvDNb6evenPO+VaOB6pwPaMWj9IeF0ufMVbxp5JW3tCPdncVvd2VRFnenwG4Y+jQYH5HdXz9eHuHwJfF/1Ps7U6q87PDL0FRDln25eKt6sIOFe04KNh4OS66prg969qC1EzDEvwg0UUqG7uOA0/0HwgTXyaiLywzqWoFwa4m0/+H3eBoKiI53YQgKTokLz+dsCVfElYCVk8jWy1y6pP2yM8r6LJPObm+q7MiGJIyLZ+TSFLSPa/Rv9P6ZpkyjCPSDeeFwM6a92hZoLHQ/1ea6wtHtHmuyhG2tq7ULnoMIXqvL9ocyMhqETl+rxqBrVX+6d1YgVyZm0YwLOJNrLZ2+j+/JMLYdGkDQDfLPEKr2Ph0zoh7Q==
X-Forefront-Antispam-Report:
	CIP:198.47.21.195;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet201.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(376014)(36860700013)(34020700016)(1800799024)(82310400026)(12100799066);DIR:OUT;SFP:1501;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	N0TxiqEUn9U78UAqYUz0xF1rtSLTSAwbD5VnP6wcdOIelgNk2rdAipmMb+tk/cetzLHYureI5zo4Zir/Wbd0EPfArnAhVt2RdnIfgyBaP5sJ9umh5QreQiHtTR4cr0GIexnGFfY+1W3x2SR1wz3xvHPaWqNcA0POr7exLqkCWbBShlcEG7jsEQlXdEPcKqM9RwedxrviDW5da2QU08tWfGufY5zwUQu6W6JAjw1mQSnKMCSe6b109cJBXjnzzzEOrslw5Z/iGqy66Q2hp6WOuZC9BLn3hse8+pU7/TNIVBqNWp2F3eVdduDjBuj1j4PAnNnXfoUm3N+XFkkdaZVa+8HMXyV4fWkjzhSYflcrHwGY/xTG3z1GG9qv1dgTfq2hAUXgHbYaM+DuiUIb4o0+NFHvNQiyPr4NoNE5KQ1K58JyL5geia93/0geOYuZXu2u
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 18:54:54.0691
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d328090-a987-4a44-811e-08de75688765
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.195];Helo=[flwvzet201.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB6616
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.34 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[ti.com,quarantine];
	R_DKIM_ALLOW(-0.20)[ti.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.infradead.org,vger.kernel.org,lunn.ch,gmail.com,ti.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261545-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[m-malladi@ti.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[ti.com:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ti.com:mid,ti.com:dkim,ti.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[11]
X-Rspamd-Queue-Id: 51AC21AE347
X-Rspamd-Action: no action

Enable DP83TG720 PHY driver as a module to support TI's DP83TG720
1000BASE-T1 Automotive Ethernet PHY. This is required for the
DP83TG720-IND-SPE-EVM daughter card used with AM642 EVM ICSSG0
interface.

Signed-off-by: Meghana Malladi <m-malladi@ti.com>
---
 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index b67d5b1fc45b..3b88df2ca5e1 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -420,6 +420,7 @@ CONFIG_REALTEK_PHY=y
 CONFIG_ROCKCHIP_PHY=y
 CONFIG_DP83867_PHY=y
 CONFIG_DP83869_PHY=m
+CONFIG_DP83TG720_PHY=m
 CONFIG_DP83TD510_PHY=y
 CONFIG_VITESSE_PHY=y
 CONFIG_XILINX_GMII2RGMII=m

base-commit: 4916f2e2f3fc9aef289fcd07949301e5c29094c2
prerequisite-patch-id: d9e4c1f3ec36250ae7ce49b720614eef25f9ffd3
-- 
2.43.0



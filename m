Return-Path: <netdev+bounces-100936-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B27718FC8EF
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 12:25:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C858F1C2314C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 10:25:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B01519147F;
	Wed,  5 Jun 2024 10:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OG7lVFoS"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2068.outbound.protection.outlook.com [40.107.243.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1AC1946D2;
	Wed,  5 Jun 2024 10:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717583121; cv=fail; b=JqtnwzjSlIek+DnC6Ezxk3oQEX2PnsESwFWiuLxeDBXaYHrVTpPzH1in7lX9G979yywH3k8OA6YfnhQdwOFpcuc2LI+cctSnzmw7Q956GmVal5nm7F+rRI5S+MSQH0vJAFMW89P9U8ZTnn6Gel5N9T/BwrW1QOg1lgDUpJYPN5s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717583121; c=relaxed/simple;
	bh=XkvGZ4z9JyJtatCY67LiCJHMnr4s82VSMC/95qmkROY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rIROg9zHjz+8mPL8izwdYE7dI0CdCWI52J7gIdpmkZsA+ebWQYMEc83mUVXbyxvU2O2V36VPBGs3XgBeavZsZFJPiwqVUJQQrYbky1q1mMIMVZkVBXv/fHQpkwBiRnAlDSJVOGmjjcHkOYhFpYIEIUbbupt/VCVqwg8haxKwWd4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OG7lVFoS; arc=fail smtp.client-ip=40.107.243.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bIWNdu1mdfGWf+3F3fWJjnxVZ0ZGghREmIWTkk0xHvw0wlvi0i419vKTOVvH1rIpPShJFo/Lof2OKwGYWEHvBB620ZmVIBFVQxwmwu2vsggR/yakiSXIBgUPknApDg1LPvhLBGagKH7cp+fnQKDqUfOMvHWKaGv2bvZq796Ta5zCrqkdOTLmQHonsKXDEJ/sitskEo6G0f1M3jWe95alMDR8ixr1wnh95oq4Y9HppbA94HU4cdKxpPa8+7Yp08lfPBFVIHxyj1sVQsswrbfCj4RlyQZ1VMZ3i6fTEkfdn5JQ7nqzAGDqLnJEOVUaA+1YjILaV9Xf+9p+Thq2Zn6yaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/asj8pYTs580x0ZS0Vc/pnHSqYHgHw0IpaY0j11lw98=;
 b=fovtq7YM2NvqnggPZZoSfWtKSJKkXUqTWFh3NBtoGr0DYsFQo34jgSB2bh5/K0jkxuY6qLVvciSBBSwS15AzsK2Qc56hfbnT917yzAchFnUvag0OUsjyEUIk7A/FdezNUR8o1pVWOln36hQoelQ9RT5oNcd4WLWmrTX4qTxhShV2XvIqf5YGkPavvRk4zUCFYzW/Vzo4wU6UdLevJqKjHxh7bzeGtZrZTIgYfSmiFNF9DQBGrBqaAuByPcTsBn4hGRe97T5FEjTJWK8utMrElojBr4G8k+a/Iwj/gSErBBmQtlWzpd2UZ5FfI7aJJ7UbqCAX9qrqxoF8WHJjSw3+YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/asj8pYTs580x0ZS0Vc/pnHSqYHgHw0IpaY0j11lw98=;
 b=OG7lVFoSuHzG2QWxrZpL2LgQG1rcObz+yXy0VodlyYBozpcfAkQz7zkUgX9qUBWlp2fjkNoKu5fkLWHeWIQfLoHNQl6BWBGwSc4HTOW3eF6IQ+JbC3jas5Yt0/0SXbzYhpX0P8nYWFkt8VpP6wKMtSdy0qG2jKecsvUoU4R/3wo=
Received: from CH0PR03CA0087.namprd03.prod.outlook.com (2603:10b6:610:cc::32)
 by PH0PR12MB7096.namprd12.prod.outlook.com (2603:10b6:510:21d::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.32; Wed, 5 Jun
 2024 10:25:17 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::ed) by CH0PR03CA0087.outlook.office365.com
 (2603:10b6:610:cc::32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.30 via Frontend
 Transport; Wed, 5 Jun 2024 10:25:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 10:25:16 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 5 Jun
 2024 05:25:15 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 5 Jun 2024 05:25:11 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v3 2/4] net: macb: Enable queue disable
Date: Wed, 5 Jun 2024 15:54:55 +0530
Message-ID: <20240605102457.4050539-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
References: <20240605102457.4050539-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|PH0PR12MB7096:EE_
X-MS-Office365-Filtering-Correlation-Id: 850e41c2-1056-4ad9-709c-08dc8549cb13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|36860700004|1800799015|376005|7416005|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?JtiTaSBNQu0wivYwI1JVqR/5Lrs7BYi52NISkYdsBT5RfQOy2dCkjQV5MYhx?=
 =?us-ascii?Q?3qvPZbCsd4IDQwv8+OOkJcYCixsX+AkAzTCQlJOcsa4Lzt8d2hjNataAU7S8?=
 =?us-ascii?Q?4ZKG/xslXg5RDEqPAvK2gHg8HJnWwJgN1e3gIp2/Gw+tRrsue0MUZVry2SRf?=
 =?us-ascii?Q?QSiHJtZX93dCsix4r1lmBv6a4pkhpiG/+Z0b/HP0aNl3r2yurxbuR/I/0i5t?=
 =?us-ascii?Q?xR0363lVzBnoG8cuOXVqybcEHemtF9VZCuTFOuwZw4WHDJ0ZE+YR5u2FAZjp?=
 =?us-ascii?Q?rjKSSkyfAgxbO2sWtWlbtQv15hiEobiylILT5PNXTU4D4pYE5Gc5d+BpMLmD?=
 =?us-ascii?Q?6sA0jUBRTfuTVzl13j0ncsDNczpsySl+YIQp1WIeW/0YpMXkXRTgx4scjfdK?=
 =?us-ascii?Q?df0EhaCylWpjrUD97jjgCgxNDYrweaLndl9GmeoUenSeJEXtuclqRGqnSEXo?=
 =?us-ascii?Q?5PTEUI7aG0kY42Oi2R4HHM3wSfDcX+6oGFZSIwUhQVYI9F5QD4hCNj6T7Bzg?=
 =?us-ascii?Q?1wwQ8Z1WfEbNX1y07y06FPxFCkzShbZYKfaOFBMCwCtrtn/j3Xzem5vkF7jj?=
 =?us-ascii?Q?cna5O+Mk1sIQbQN138xZ9G3TkwS53ozMZtymsnby9P7e9/qYtM8sc24f+NbN?=
 =?us-ascii?Q?dB/TSS/UaRUtZwU+O/7UREGlukPIB4feZwU1JC1sHu6jA1Vs7Cue3LFS7zYM?=
 =?us-ascii?Q?nfWad8Pzv51oYLncV1+SNHHGR/HjMdsKcp70HuN6Af5gfnjxz+VV4mspGACT?=
 =?us-ascii?Q?6EL9D7TyfCHBCpz+p12eOi8ynrtLCuhbe89M/A13tOTWw53Usa/9KZjuTylb?=
 =?us-ascii?Q?caANULfk30rCgAPa5QQ8QhuZKNNau6IWr21uxXXW3XBnVBd3+DkcR1sHbam/?=
 =?us-ascii?Q?mzHuxT2MJTRph209+O4SSm6ejRss9d7GPf3xGr4jVwtVSSKCrfwZA55gcVA6?=
 =?us-ascii?Q?5MJ/5cGZ3SYS0xbDCez8+stzHjWuYtHICRqzLYvAeh5pYWIcYnGgjVKUv0Kb?=
 =?us-ascii?Q?gC/oGRQXko3fVr8WURQwiNTSI5MSeOJmohwUjkBCIbadLA81oundFmOGCdm3?=
 =?us-ascii?Q?nMgG+huhqrzmnKnUqBi0R64uPdbRqBIds2ze0HxjqMLrk4Fu60bSLXyNwU51?=
 =?us-ascii?Q?bq86AzniCJv2YwpwhJTZjaG7WjEQUsDo+Kkt6+WZjTn5CY5OBaFLMPd8D/C3?=
 =?us-ascii?Q?cR80EiFtr14cGpmGrQkOB2VVSkKobpXPn+8Upf5Y2LQIV30nv+14KzXyjS2H?=
 =?us-ascii?Q?OuFyLQLNjyccW3WP6c7TJYGXkriAd+YrH0sFVMUkdrogiTzVLFoepbBHUZ45?=
 =?us-ascii?Q?HF9gMguIuI0L4/f6J2s2IUBgv01ojxb2r4jBE5POqho061va21AXPfze+1bv?=
 =?us-ascii?Q?MTuEgR823xYFb/2qGhOdh3l6n4DC?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(36860700004)(1800799015)(376005)(7416005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 10:25:16.4517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 850e41c2-1056-4ad9-709c-08dc8549cb13
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7096

Enable queue disable for Versal devices.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
---
 drivers/net/ethernet/cadence/macb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/cadence/macb_main.c b/drivers/net/ethernet/cadence/macb_main.c
index 9fc8c5a82bf8..4007b291526f 100644
--- a/drivers/net/ethernet/cadence/macb_main.c
+++ b/drivers/net/ethernet/cadence/macb_main.c
@@ -4949,7 +4949,8 @@ static const struct macb_config sama7g5_emac_config = {
 
 static const struct macb_config versal_config = {
 	.caps = MACB_CAPS_GIGABIT_MODE_AVAILABLE | MACB_CAPS_JUMBO |
-		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH | MACB_CAPS_NEED_TSUCLK,
+		MACB_CAPS_GEM_HAS_PTP | MACB_CAPS_BD_RD_PREFETCH | MACB_CAPS_NEED_TSUCLK |
+		MACB_CAPS_QUEUE_DISABLE,
 	.dma_burst_length = 16,
 	.clk_init = macb_clk_init,
 	.init = init_reset_optional,
-- 
2.34.1



Return-Path: <netdev+bounces-103934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EEF590A671
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 09:06:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22BC21F24750
	for <lists+netdev@lfdr.de>; Mon, 17 Jun 2024 07:06:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5A4F18FDD9;
	Mon, 17 Jun 2024 07:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vMdKh7tW"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2059.outbound.protection.outlook.com [40.107.223.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63D4D18FDB6;
	Mon, 17 Jun 2024 07:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718607872; cv=fail; b=PZ2X6d6Q9yXS0sr9FCjrU92p5Bw7XPKHhtfxksiMbMd3UTynfpddthLUHt3ED0AskVgrPocNna+C5bDG5W9uzVEB7e7SvknlgwEtLRymeqkNIDruXM66tHOD2oX5WZLvQuAO9O/9WDzgyQB7DasOYJSg9NEo8eU63bB5IZmZyx0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718607872; c=relaxed/simple;
	bh=c9//7KBKsuH5+IUhfBJzhCb1fw21P1RreQw5z6GuW40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dKkoJ3TWbAgi8ht+mr80FseoGK5JEpH78IcRoeN1uUGiUI/+Jy5b3MVJxljjzSkNXRUwGH0HjdLfdIlNtSF9TxQorwFgp1UDpolxON30HOqg1c2quI0Ad3Yu0bQUfAJ3s1flDVdjSj7q0opef9Ju68VG5zxoEqn7xFbWSgINmaI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vMdKh7tW; arc=fail smtp.client-ip=40.107.223.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bVoLWFTIUUJFoLg3iLmkAJ6OIWoAluUl6Od87T4evp/rl26LjBzJoHKBvGIt8jl20I/3H0gDTrnQ0uFCPTLMYUD75KBbV8oRxQgnhqnGNXstGAZPuLmVSnSHymX2MoTdlvCgFTdetaAUCUJIKnFU6/OU1GcGWikTU+vwR7Qkx7yPe5AGwsr21fP3wuDQ/WVs7fBD+9CT/NF8vXjKdjdDwWrplEt6cqaVxj1YJORHLaYZfV8o5E6xuh4uaaw036qv8GKHuIvGO3d/sPGyqdYx65kcTxo3Y9UqM304et8K0wojzAsVGyKPCmHc/SNVltZrh5H0Ectsxvb53v80ZRCmTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk/lU7HHUtKZYvFVMBoHhyBzyKqnierFbLy8XZl42ms=;
 b=dkTIpN9wg4lRhdnNOmKMDiMy81WC+5p3SluiaCr4oo1F7JBmQyORMYbwB3B1TskFOep8DMi22gh5hHdZzxTCmNjDExLKVN4ZaAd2qXpVh5M7EBA2pG5iGWdUBMY0InC7E8F3tOhQGGnV0/8qn5LnXsEr1Y/SUKPEMB9byLRX/Y4AF4A1qQpkCWaI36tvo83P/DAdBkB/9IVjPwSPYpTkrGs+sLYT0udg/WDKRK8J0ickko1SziKGEI0lEeM/kygT/+ZxuMJplLgS1afYAIgawqinhNsIJut8QenL2iRLXK3iR+Ya+Bh5Xuuk/i1boWE5nep3MCbCH3i3YvcHayRoHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk/lU7HHUtKZYvFVMBoHhyBzyKqnierFbLy8XZl42ms=;
 b=vMdKh7tWVcgwJDHnonoRxFqjdyL/naIzZK61NUJK9F9nv7IfnUGCPINvlcA4X4C0lxrHlpvBTKEbgF2Ku343avSpWu9BKFnnW/7ReAQ84jnRrsFXeftN7SVvlPMsEs12a3Od8zpEZFmsMDsGkC8odxNbMSJrlS5vfp518T8Hrcg=
Received: from DM6PR21CA0015.namprd21.prod.outlook.com (2603:10b6:5:174::25)
 by PH7PR12MB8825.namprd12.prod.outlook.com (2603:10b6:510:26a::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.30; Mon, 17 Jun
 2024 07:04:28 +0000
Received: from DS1PEPF00017092.namprd03.prod.outlook.com
 (2603:10b6:5:174:cafe::f) by DM6PR21CA0015.outlook.office365.com
 (2603:10b6:5:174::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.16 via Frontend
 Transport; Mon, 17 Jun 2024 07:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF00017092.mail.protection.outlook.com (10.167.17.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Mon, 17 Jun 2024 07:04:28 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 02:04:27 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 17 Jun
 2024 02:04:27 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Mon, 17 Jun 2024 02:04:23 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v6 2/4] net: macb: Enable queue disable
Date: Mon, 17 Jun 2024 12:34:11 +0530
Message-ID: <20240617070413.2291511-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240617070413.2291511-1-vineeth.karumanchi@amd.com>
References: <20240617070413.2291511-1-vineeth.karumanchi@amd.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB05.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017092:EE_|PH7PR12MB8825:EE_
X-MS-Office365-Filtering-Correlation-Id: f43a438e-a120-4ef5-17b5-08dc8e9bbaf2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|82310400023|1800799021|36860700010|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?oIwQ1UxKjcoCUCrzWKJMX0ksZU6LH/PG7UOBPSHXCUyPIhoOYVE/OTTYyH1C?=
 =?us-ascii?Q?AVggc3HwwxZlpr7esnf2+HKRWrCNRHEewu79MMk5EGUyXGnUvpT6kHnnIC0A?=
 =?us-ascii?Q?+dCdwm3ghsN8EODIkRvil21zIeyXsLIxXuON7iSh6bYUp02+ObQLA5WUJbBH?=
 =?us-ascii?Q?5J9HqHrkSvMKYpvxsaniMG0NdcD2X67PWQQtkmVaomuzdeE4oSaJa/gaHzTF?=
 =?us-ascii?Q?55RQhKPBjtnvPUSp5OlYc4Jrk+5JH6behkrqX7xr9dnCyReGqbi0L8RTa9Wq?=
 =?us-ascii?Q?k6Y+V0Z9NweyyIAnil2UwBnUIE8dWC8B4QyGBOb52bgAo3OAMSJUbX3PFroZ?=
 =?us-ascii?Q?wOv8otdX+QU6qS8nX9wobKgJFcZWdsqqcyypAggiNrhtdJHGQje0mhSaREXP?=
 =?us-ascii?Q?ecksXztSclyXzB32tFBBucEMjsdPmBlwrRa32vSom4xT3C1FxP5ImnkhNmQe?=
 =?us-ascii?Q?wk5A208wBu/Izro5Q1BXbnrs1Fa7TawekHSU3R6y4T2PPATCHvgReZRmldpf?=
 =?us-ascii?Q?o1LcCfgDek4qnlQP2Zj36D/GCKMnHzuRGIuSPpedjkOP6daEsOeLbnJduzd9?=
 =?us-ascii?Q?K4TdtDhWVEXXZ/vZUpPkzrLWjP4VstenyyBYNdO/HGqgX18JLrV2HtL96VbE?=
 =?us-ascii?Q?m91BYh371GDgHvCI89JlsH1I67W6Iy6N6BcaI36HK8WN9QD/Gmg37A9wtv/g?=
 =?us-ascii?Q?tAl385iohXUHDn4LA8TAgh/7IkrXCLGgbY472YTx46aoqilvXdynC5jDAQEq?=
 =?us-ascii?Q?2AsllrHGtrEh5D0nSp7/TJXV09qA2ns1vKdrFK8Lq8H2fhRiBFUpkH1t654F?=
 =?us-ascii?Q?lcCMQG0lesgd0HQ58T9552zX4OA1kAxE61t/xcop9GelVlRH4XEMjOjoPw93?=
 =?us-ascii?Q?KPWjqxcquhmZydHckHCgz/A+y3nd1K377dKgLH0/4Y3UDfBgiUKUaRmZuut1?=
 =?us-ascii?Q?3t8Cs+ndBWZFZrgkdT12f/kZ4LGi8xVn/Rbzq3fndU1PRdZHjAZmpjwn6UIY?=
 =?us-ascii?Q?deUg7eFfs++8zR89q46rwgVCOKkl/bYTW3uAGbYFqUEIO2WdYDrf/fc/h8Yz?=
 =?us-ascii?Q?RoeL6fW3RiV8GRItx9tC0gDtdrZArv9oUnZXpPGnSMZ/3pD6f1in+t7ku1g0?=
 =?us-ascii?Q?Kz1PJBJxzDqJJgZrZftkp4utfvoS2vl5RvPbaGAmNoszHbJbPVoROn/PvFPQ?=
 =?us-ascii?Q?19vZieTOL5zh0Ze6q9CMxs+zh1MSvLdwfUW0iKaiYbuy+JNYTYehdXJPnO2G?=
 =?us-ascii?Q?OQqsszpk1ua8C2MNnf2lxB/LEnXLtEFxjg+SMig2vGdSWnRpL30UEkx+SPV/?=
 =?us-ascii?Q?3IBWI77Go3YEKC6m7diMw6pjyOUAjew0BYy68rng+LesaAMcGJbv3jZgDjV5?=
 =?us-ascii?Q?6AjW8HVChP1VRJ8Sc0oAzpQWmJSCu9mATzuxPRjdJZ3PgfdfQKvNot49Vujw?=
 =?us-ascii?Q?7Klf7MD/ge4=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(82310400023)(1800799021)(36860700010)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2024 07:04:28.6177
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f43a438e-a120-4ef5-17b5-08dc8e9bbaf2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017092.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8825

Enable queue disable for Versal devices.

Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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



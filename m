Return-Path: <netdev+bounces-105536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B311E9119E4
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 06:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D718E1C21E7D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7029B12D75C;
	Fri, 21 Jun 2024 04:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="pkOAzQ7b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2073.outbound.protection.outlook.com [40.107.95.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6E5B1422D6;
	Fri, 21 Jun 2024 04:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718945878; cv=fail; b=KlcEDYRuGz1J+JprsUU59z+2fM4Ly16qyTxHSz+RWSo9xFPS8/j7SF00HCBr6UjoyfkhQZjp1SjNAY8/zPrhSP12ZqrdA4SnDwmZv2ODzFX0YZqgjmCKnHUQ5ORh2tf5CPjrbCpEenEEXr3RQUYIKHl3GWI9OTsFF8xKKmfSv6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718945878; c=relaxed/simple;
	bh=c9//7KBKsuH5+IUhfBJzhCb1fw21P1RreQw5z6GuW40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Mn5CeDizh2/JrSo2OwutnWjBr7jh0TKtAPc81UKnFC4EqgZYcaJQPR2hRVqF6mb4y9Ms66Z4ia+v2Y5An7j0Hx/Y0mU44LS3k0OXPFm/r0gWPCV7oGqMNuDdmlY14VUPVTWMk6sIPrDC0+bVXJhKh9QCTAxibx968A5fSy/mfVA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=pkOAzQ7b; arc=fail smtp.client-ip=40.107.95.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LuR605NDm9tsNIvF0oGIhjSsfdlMekp5sX73TiDJ8r8xuR3z6ZHdh5uMGzZFfQNpkh0X7ebcjG+t74NHThdjpztCcGQvolkl4JYeqDBYWQ80EgS1QS2vPOZ8VYAUTdjPrWKwz4vUWklZUjcTBT4RKFjGfXp9JxhSSGuPJoF5sQ+GhQJe4xWFMAXk3EnCGmX0r7SmWF0hnATC4sJxKVb2g3O4pD2ingHc7fexOXhDg177nVQFah5GT8bbyvTz6KnHl8H8QD3h/Oid+VdUgjqi9LmJkN2STk8QQvsSFmtDMb7zoRi+0c4cYSm/tH+3Q7KO+EckQTIE/JzhAkJQDh7o4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk/lU7HHUtKZYvFVMBoHhyBzyKqnierFbLy8XZl42ms=;
 b=YGoyEcTJHDNWUqJmBHCdbMApJj+HkQ5sY0uRvhlA3ieuzfvOoPQbKKaGIssOW8PDCCZUNaJSrjbdWs2nfX46XObnaP6VrIlj9DmYbDoDOCAbl19lS4sem43gK8OxXW7fLznV+9+1xpyqll8rnqLhU7tHdfNeQDYnn8aW4eYXiNw/nSvjGCx36+JQh/FExB9PbTfGcc3+Du7W0m7zr8VHI0es8IDJM5StHFDI2clkHsXxDs0hi4rFJHacZZtLN4bOFyWDP2qkABXo/KDO6JUIx24VI0elkAK2XNiKoxTwLatWe+LGx+qnA9DJ/KEYSuB2aPmVoXhkFAOtdDxIH+jakg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk/lU7HHUtKZYvFVMBoHhyBzyKqnierFbLy8XZl42ms=;
 b=pkOAzQ7bOA938Ft2MAdYiE6rNn2rOSVIovL3S5Z6J8WcboOSsHAT//1Bd1NnZOu1/FVqyoBQoqRmdSN2RibuZmuxqfBi0N/0DtTNLxw90jZSjxF29Xd9ciBegfWJTP9NrBPP8cVC1iZHrURhNfB7PJb9MAONacNyAr2WrUrFev0=
Received: from BL1PR13CA0252.namprd13.prod.outlook.com (2603:10b6:208:2ba::17)
 by SJ0PR12MB7035.namprd12.prod.outlook.com (2603:10b6:a03:47c::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.20; Fri, 21 Jun
 2024 04:57:51 +0000
Received: from BL6PEPF0001AB4E.namprd04.prod.outlook.com
 (2603:10b6:208:2ba:cafe::bd) by BL1PR13CA0252.outlook.office365.com
 (2603:10b6:208:2ba::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Fri, 21 Jun 2024 04:57:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BL6PEPF0001AB4E.mail.protection.outlook.com (10.167.242.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 04:57:50 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 23:57:50 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 23:57:46 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v7 2/4] net: macb: Enable queue disable
Date: Fri, 21 Jun 2024 10:27:33 +0530
Message-ID: <20240621045735.3031357-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240621045735.3031357-1-vineeth.karumanchi@amd.com>
References: <20240621045735.3031357-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4E:EE_|SJ0PR12MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: 36c89e9d-2ca6-497e-a41c-08dc91aeb3fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|36860700010|7416011|376011|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?W41Bp//KlJdWgL6uuw4wk5pnfbbkbsd8l7uFXxSPGpnad7Qnl4nx+6WcTL+0?=
 =?us-ascii?Q?QJHmK7tQ4xOa+fRZ5OcAME8PtU/M1fg60C6TosApKVbtShc1I/XtPeD+zHf0?=
 =?us-ascii?Q?nfJVtKyDLgCh1dPEJIAonup+ILl2JgMXvQz3H/Kq+WQgreCm5cz8ZuPw73NA?=
 =?us-ascii?Q?DjxBQnXQy601y41nSCY6mrllOPx6wQiJAWAJnw/f/BkFYRK8s/px/nVaNTEL?=
 =?us-ascii?Q?XrWl8aPT2fDPJIaKdi+dxB1aRC1fVSZfHILgJQ088CwRJumB/qUKXyKfnw0b?=
 =?us-ascii?Q?/+IL9xq1wk9YC2eXqXegf2XtIpRaBFVu15zF3EGxnZnNzSBqJcIsO3yT6ywO?=
 =?us-ascii?Q?TmAHqwe5vBBl0Tb184c/u18sTw8ORqVAcqiDvIlv7RAjkV4E74Hpzbz83Nd6?=
 =?us-ascii?Q?cY6TRTpWb7eHqVELgkDjiOQ+xoxEGKZjF60xgxeu75jD9k51KJitRGH80KCQ?=
 =?us-ascii?Q?iytiqA7DtPWt8Tc9dyLIXEwlOinNRgWryMlixCU2kzl759gETznL020/SD0X?=
 =?us-ascii?Q?kIR38XwV8ODsme+iOZBBefvi+ruwt+dV5h4ipywae8tALbsG9rYw+5XtrKEH?=
 =?us-ascii?Q?AbG3cHZtcGYtKU+GrsbSCsVmD09fREdmBJ+JyiqpjGj3kECNanu+e7PMQDwc?=
 =?us-ascii?Q?J02qlpbJ7/7/yaNYkDujkF9QG+SzLClygIqzxlDPtaNZIRhopCiRFXz9IYnF?=
 =?us-ascii?Q?5F2elQRXXEMWQuD4QLOT24Ke4K0ViN7nE8+auxtYPKn5LjHIdEtEYr4Kxvke?=
 =?us-ascii?Q?fMZ8k+BOM28+P3YPGqut2//xN/joT5m4kYoL/LLa8/zutnBMtOwtuHPdz5xV?=
 =?us-ascii?Q?xWA6p8Ap6ZspBRYSJiTEYhzBzX6c/DaIeOF52lu2sKlluQ4xFmiMXNqSmZhG?=
 =?us-ascii?Q?5SVrApbndJBFvqM5cyA+c8U5IpezPpDZBZikSj23f7AXhLy3sacJqmSw7UuG?=
 =?us-ascii?Q?g2n6Qs6ROeDLsjASUTGfEjxRyr61DDW0Flb5HH/E7pqHYGUrHFchnWRvGtqd?=
 =?us-ascii?Q?9RGCNU/K0MKb7ulkEIojdhwtBlBMNgLpA2r5X/da2CxpD1oO+ljeygnuoy3l?=
 =?us-ascii?Q?iPjf1rbVZ1REL3BKDd6rbrMYIK7WevWS07u6dFW5ZCX33Wb2JBmyCbcDPbPD?=
 =?us-ascii?Q?bWoZoyqr1T2mw8ehxsLuaZfVqX6rGc9WWdtK28RGN1uV8ynqgWioIX/jVuqL?=
 =?us-ascii?Q?+lGWtptBZjPMn7qeN78qxd4vW9DYAm/Dk/Pwo74sv8if3hBtWNBlou6Dz1L3?=
 =?us-ascii?Q?z1h4SI0NCmstsxxkppp9EgbL/ppluDaTUybWei3KufU0W4qEeb/MuXgo/0yv?=
 =?us-ascii?Q?rcz9gzRlTzjvbUu1p/cJrmW9m6Ajr8juDrolj9DBJ98M5g73HhUeI4MauCkT?=
 =?us-ascii?Q?dT5ZQemoT+pV/kVsJg1EMrbY7rJZqUxITq0nvIASQBf2FHkzucYaUjn82Tau?=
 =?us-ascii?Q?ERW++jzuCFk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(36860700010)(7416011)(376011)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 04:57:50.9027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36c89e9d-2ca6-497e-a41c-08dc91aeb3fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF0001AB4E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB7035

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



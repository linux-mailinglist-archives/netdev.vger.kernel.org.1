Return-Path: <netdev+bounces-102654-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A1DE090414A
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 18:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 12780B24711
	for <lists+netdev@lfdr.de>; Tue, 11 Jun 2024 16:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 185094AEE6;
	Tue, 11 Jun 2024 16:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="CCMdfx2x"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2051.outbound.protection.outlook.com [40.107.236.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7708947F5D;
	Tue, 11 Jun 2024 16:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718123330; cv=fail; b=BoKJJL4DLdhR+ulaR5Dz0NWEKXzzARqspJ07e1nxVS1neolmygtMYDJbJvJrv8UVE0m6XzhAwBMFRrVOhmAvY3Dp1ypug1gTMaGCHhzimggLmX9wMT45NVLB1ZDYQctGq/B0pq0DMDU9dCua2K7UkavxjqcRHM9RCQjXxgDbaD4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718123330; c=relaxed/simple;
	bh=c9//7KBKsuH5+IUhfBJzhCb1fw21P1RreQw5z6GuW40=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uQdloErSXWTwOF9ka7zJzgf9gnVzxUaqEchkghYnn647VUjOcZdcH0czQdKhRB9tbs2SZQOWIv3ayVOmNpmfbAsICGuX32EAsJJs7dkietMi7uDpJaH4DiZuNWoBiVx9yJwvEB2ezKCar0+mv2F5Xd4+8pYmnoDfKsW2KP4fYIA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=CCMdfx2x; arc=fail smtp.client-ip=40.107.236.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eekWT8tbCmhinEpgppJ0NEY9AwXO1ize8B3Xu7uTCJDQOONltgmvIJW+f1prIxko55DodxFfHAApBoELkOqg9rEQl7sh/KTLCiznMroXwht0rIdY7OszTzNQmaVf/jwDgFu1kM4DhGaRDimEe4FuPwn/a7KHQOnRVAVW2ps4adYjv7FSXLo9SKpJybAblor+LD9VlwM0Dz069NTPVwYEkILIusonwXkU37L/Ss0FDSF0wt9i0PMHCBl6xhLpo+lIOy18cdBjLV60er9+xt7u123I01rnxZZl8T+KX8r5PM32MvpSS7nAyixPdIYGF1tr4CZQBlQbm3/Ip9HU7OC4hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wk/lU7HHUtKZYvFVMBoHhyBzyKqnierFbLy8XZl42ms=;
 b=PcJeZkF2q6ZdWwhyPV8nceuueFnJTSRsI1eMur5XUDtc8tGFbOtUMvGGeboLQ9eQeEZYRu6FGyA3glelXq+MTcYgHRL+OumkfodITrhJ29PIRe7zMaq+JUP0Vy/pq2PP+WqR/DBig/m/FVJ6fWds/RZ6pG7Dex/V9Qn2JoBi8mbWLiHTv8P50ZB6RX+w8aFILoOr96OIEvGpeZQG+Xcy68PLw2Mibkro2c+nUsvGktvg1nLAsG+cSZBqharj4Reo2Xu03WvGofpUX0TCnRcTNp4yV7WDTzXs5MMzhy9rDwYjfhevzygfcPCGJxFn910xwtjdCDFTesfq5euo3VKqsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wk/lU7HHUtKZYvFVMBoHhyBzyKqnierFbLy8XZl42ms=;
 b=CCMdfx2xNcOXjvvAkPbQm8pDk7HlL5KAJGfP3finjmBp420Rp3Nb66qSEDc869oZYToDA8VPGvybCFA+Xa9/u9IpfDH7CxdPA2XmzjGLGFPNY1SV1Jh5kDDxMt/HveMpGo1rYzTWZ1LuzLYVFIJBK9J/MtlxyHQ+BnzItZJSVjo=
Received: from BL1PR13CA0175.namprd13.prod.outlook.com (2603:10b6:208:2bd::30)
 by MN2PR12MB4080.namprd12.prod.outlook.com (2603:10b6:208:1d9::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.36; Tue, 11 Jun
 2024 16:28:45 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:2bd:cafe::a0) by BL1PR13CA0175.outlook.office365.com
 (2603:10b6:208:2bd::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.18 via Frontend
 Transport; Tue, 11 Jun 2024 16:28:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Tue, 11 Jun 2024 16:28:45 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:28:42 -0500
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 11 Jun
 2024 11:28:42 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Tue, 11 Jun 2024 11:28:38 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v5 2/4] net: macb: Enable queue disable
Date: Tue, 11 Jun 2024 21:58:25 +0530
Message-ID: <20240611162827.887162-3-vineeth.karumanchi@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240611162827.887162-1-vineeth.karumanchi@amd.com>
References: <20240611162827.887162-1-vineeth.karumanchi@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|MN2PR12MB4080:EE_
X-MS-Office365-Filtering-Correlation-Id: 08572010-1f11-4cf1-f86e-08dc8a3390a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230032|82310400018|36860700005|376006|7416006|1800799016|921012;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cxaKeZMMjChzIfsyqClHJLoGi5gh03lGYp95rZFQMpZQLZdrzX0P4j49B5Xn?=
 =?us-ascii?Q?BDPqGWRKeVrSpK52EjrHo2kMYl2sJbLR9KTljatpyNvplsk1WgzDKxVHWFp2?=
 =?us-ascii?Q?+fj2pGtlSduucXaKHm7QTNhPPExCizqFDMzLsqu2GSkBKMBGOckZLLP+ZsAq?=
 =?us-ascii?Q?WfwO5yjmzj7gRMdSyJUW2OoD/y+oGFi0L+iwP2IBqwMNn77kT9IDHdGuoF0P?=
 =?us-ascii?Q?HPe7Rf15xLWHm021MJ4XxGTN178qtDaQ+jwTMpPtjcY7KE8cS/tPeEdrSMi3?=
 =?us-ascii?Q?J8xu20wAkThMz2Vx/Db9d8H1Eyg92DZcT6QvZObYXftihYjpsa+gPlsne/J2?=
 =?us-ascii?Q?fJekXaJz61hpwzEnFonp2UtR5LMrW1YxMjbMJiqmec54tCKRlGpwG/vFKHic?=
 =?us-ascii?Q?mz+nqM3BCXUs3kORvhMt7ADWiVOVyDO/iUutKLczIrlfX4TNHV8aReqH7g2B?=
 =?us-ascii?Q?ByvSr+5RI0GX5nqrIJgNuKoRBd0Z+7eVoCujrm1ABb8m2S10gOAeDG3qFVKb?=
 =?us-ascii?Q?m0UnpvgFLksByaWxG3JHJ7GP7SEaubJOw981fPWMIpo+WadDxDW/BDMqJSmq?=
 =?us-ascii?Q?ONMrYfUSW8CsiBil5O/WdAPgy8wTiML7cNldFRAHtfdvqvZx6bq8QT7M2qrK?=
 =?us-ascii?Q?Wq84S4IVgzQ+2olCDwqkF17PmMt4BoRPK12Y7UtSxz4la5aneBLEJeyRzqci?=
 =?us-ascii?Q?4wyKOAyoBdAJuWaXjpl0JPnD8PyyBpQudFgmQR9+Muiy6DNt+bUste2/212a?=
 =?us-ascii?Q?MM3rc5KkqUYeAjmBfwGpo67i8UqxAYvdCulb5yyX5TfdJXGQT54pd0V8mxvX?=
 =?us-ascii?Q?FzI491nBo7KxB380QuBCRPv2Pzre1v5sJbGCp2OF/ZxPmMU4RNHWsT2odVJh?=
 =?us-ascii?Q?Mj7V7thE4qxMeEHX5JFRfOaOlM3kWp4FhxnqZrVp56kaP15XnaxCi0NalIFJ?=
 =?us-ascii?Q?FdAkgEFMDBY4Isorq5GZL2AP91yDp+UHProF2ztPtWo4ZdsaDJQc7lXRoxgq?=
 =?us-ascii?Q?bOtBDoGdQ9B/6BLQVK2pYymOU4GvCU4h932eNs6dXXLsmHkZtZZ9ajletoBh?=
 =?us-ascii?Q?rAtA3nwQDctXv64nc/UVNNjTVZ9ux/n4pr2MhEDPIRw6LbOid/XaoKmCFsWS?=
 =?us-ascii?Q?88kDjVDUtCymRYh51abigHxo2yxQ+ao2Ppzdx5QWeemCCxmZLHrkUyyKIqxu?=
 =?us-ascii?Q?dxPHyikaWW4DfE4aRLzql0pWndK9e1x+eWD26l3MwBaVAjQCCjUXtOM3wj8H?=
 =?us-ascii?Q?Hy1Q6z4BWQfgINjyrVT5OM4KDYWwlA7sbNa79Xdm7wFqBVgo1ZAq2rhiuzym?=
 =?us-ascii?Q?Kkw8P9KtZxlmycSma1tC4lF25sSqFlKmwQg70HcLhuQ5NjiiAj9fpMKhcfR7?=
 =?us-ascii?Q?LYskA4045jp8wc1kDIr3OmeJjyeVmhqMNCg5fIL7r2Uxl1Lg23dz2ZvUfBfz?=
 =?us-ascii?Q?1kzwhQwSlQA=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230032)(82310400018)(36860700005)(376006)(7416006)(1800799016)(921012);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2024 16:28:45.1938
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08572010-1f11-4cf1-f86e-08dc8a3390a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4080

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



Return-Path: <netdev+bounces-105538-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D71D9119EA
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 06:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B88A8283500
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10A00148841;
	Fri, 21 Jun 2024 04:58:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="WRTZBXlD"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2066.outbound.protection.outlook.com [40.107.93.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8951416727B;
	Fri, 21 Jun 2024 04:58:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718945887; cv=fail; b=PFY7TZQsoiVg4e/cI7rV7rbAi9Oqw1eShodIhN0cEezG9AbZBR/rOVnBmZWUSw3fGv/jGfFcJ6217jv9bgeTTmavXj4W2C7/OpuTTHC+/GU+tMXiOgopoj12sxwrjKNJAbRSHPnJr9oXgwn/WkCtLyGDNkCAMJisG25ucoJcrPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718945887; c=relaxed/simple;
	bh=JkXez2qJZvQa49DEDAn0mAxBd0XqLq3AT+iQ1SqxX0s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIo2PGSh1krSIAvTjw8y7zHPM2ugsQvgQhjPf5dJQXwInGy8vWRjIZ/WbINyia/YQnVKNm+73YxCGRhQVUELuh5Pr72pCsOG7zDmvL+eCh2zzY72cS/Ft1FNAp/b9STMP/R+2beWE7diMlMu5fVCSygtxBVOZcjzYQmp5iPSpEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=WRTZBXlD; arc=fail smtp.client-ip=40.107.93.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QgN7AmCS/pkcFiHmMsRfNwmy40NYRvu69Xdt4suQAZnPWooshx8V8qVaNwKNvafvandDZdkaIXCPIVxuSC5EvoqFadupqRTHWIpr9FRGKzwusSoOoW3p0WP1quCYHi3vRaXCS0h4dHoD71rMAtclWDv3BefnlZ4J1sOoafxAjewC/30rDiCqI0TFyMnkHPKdAKP6GB/3giUmB+aWswMIyBs3IvDQXJN/o6bq+Ht02pNknl9ruMAMWyAbubxp2LeoI08ovSGvjWM48NZ0CFeEqACl/ln2DPCqyhkhv58wvQCXGhYO7Jq92TRpuySLfaqtPQDW75e/snnPDWK9PdAM1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=65IL+f5STpJuNlS+ntBsjZ4BhYTF37B+zPjZiTWIns0=;
 b=kS925SONByHWm80v5UxsNU2qijATkf+wr/Tlj0ehCiJsc9qnlTvkcof7Li2h2pLBvT4q39ygA8mqwWsVUo4KRNrxEBZPOYczw7R8Wqvg4Rtab9NRQceKnV7J23N+0qxFuFQLri7XIIdb6rfLYm1mDeuijJpEQ1iqkUjBCrzec0ttaOvORuchWn/+UpChrR4QgbUwD0OBVi7cUPLOOaoNL1eTSGgJhtEKZCCGvkMhQAFRvp+29AxjpXHjZM14R12XfORFa3YaRvlJnRtMVmYh4luhzYHEaU7JNeUgANoMQzFXLwNdCUbygpBDDh1b9hCPT02YxaVVfv652pTQaT3+4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=microchip.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=65IL+f5STpJuNlS+ntBsjZ4BhYTF37B+zPjZiTWIns0=;
 b=WRTZBXlD71Max+1P0Mm8Uk9m78ve79X5Fd3Efry5v4sIkFVmG+HwfmLDlDHfqxIMve5rLEoH2AhwofQwM2+jziHjhRPVbIZPP25hxtuuUtyp/6QfjlKaP2dqSg7PUoURewihpc3FpIa/oErw6EQOnSVqDq4IT9zP8IHfhmuLdao=
Received: from DM6PR02CA0117.namprd02.prod.outlook.com (2603:10b6:5:1b4::19)
 by DS0PR12MB8271.namprd12.prod.outlook.com (2603:10b6:8:fb::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7677.31; Fri, 21 Jun 2024 04:58:00 +0000
Received: from DS3PEPF000099E1.namprd04.prod.outlook.com
 (2603:10b6:5:1b4:cafe::7e) by DM6PR02CA0117.outlook.office365.com
 (2603:10b6:5:1b4::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Fri, 21 Jun 2024 04:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 DS3PEPF000099E1.mail.protection.outlook.com (10.167.17.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 04:58:00 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 20 Jun
 2024 23:57:59 -0500
Received: from xhdvineethc40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.39 via Frontend
 Transport; Thu, 20 Jun 2024 23:57:55 -0500
From: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
To: <nicolas.ferre@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<linux@armlinux.org.uk>, <vadim.fedorenko@linux.dev>, <andrew@lunn.ch>
CC: <vineeth.karumanchi@amd.com>, <netdev@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, <git@amd.com>
Subject: [PATCH net-next v7 4/4] dt-bindings: net: cdns,macb: Deprecate magic-packet property
Date: Fri, 21 Jun 2024 10:27:35 +0530
Message-ID: <20240621045735.3031357-5-vineeth.karumanchi@amd.com>
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
Received-SPF: None (SATLEXMB03.amd.com: vineeth.karumanchi@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF000099E1:EE_|DS0PR12MB8271:EE_
X-MS-Office365-Filtering-Correlation-Id: 750161dc-3f4d-4e4f-70c1-08dc91aeb98a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|82310400023|1800799021|7416011|36860700010|376011|921017;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?tB7le451YSeuVBVHv9jne304cEed+MYhbBdf7k06vPSTiFFwsCirt7VPRNX/?=
 =?us-ascii?Q?qx48PE46PImLakweHINcRMFTwoz8m1e5NbYNHfOeOyXMhyQ7kgxUHlVWx0Tu?=
 =?us-ascii?Q?EuqhIFv6UA3+B0eGzisjLOXaniAYRtxyPHN8B43fOsdHyCXuyYfxS6Fx3Ahx?=
 =?us-ascii?Q?tSpIvhoRuh+KF3dZAlCsfM1UQEV/KBju8sc84TK2DL4alKX6vIbIzGD+uh05?=
 =?us-ascii?Q?EwNjn9i+jM1XBDBImDcqDTXoRjzXm2qn7wk8dEDZrsRtJ8h3IQMCJ3/5Jjq5?=
 =?us-ascii?Q?9/y5BTD2YAWv5bUvR8H/2+bAYlSGUJ0rZoZU3ghk2h7jNtJA0RyKQja5Dsds?=
 =?us-ascii?Q?pA35uEsLXXESaw2vME3tOEygM9GnU+FoBP76loytTgVe7ysoOP56ST+3tjxr?=
 =?us-ascii?Q?/aBQdpjGsreSPC7ZM4Nwb9eNB7Ohn/I4ziW1pR8D1cCEIy2cYreulFpXOaIk?=
 =?us-ascii?Q?8iYQYRKmlJrDF+VwiC61msgSEuQwTTq/7io8hvoBX7lK8SDFlap6xllVBKI0?=
 =?us-ascii?Q?RVM08Ia+rvygTlIRJxsbWDIm6k/B0iCOAK2Vbr8MznfNzy/znY1R1Mh5214J?=
 =?us-ascii?Q?Iv8OegKZLB0Wp8E/R8MrancaXmpPzDqYMxAEV9qWLMmOAYEsiBCs+IKBvcw2?=
 =?us-ascii?Q?nEa9llpsDDvmYQxEU2/MbKx9sxR8oAhO92iEh3BiXowHiKaXbYJJK+zr+ioD?=
 =?us-ascii?Q?PWAFvdDs1Qv44RgvYTSje2R+lFt9984NyrzdiJWnW7zmBsrxnXyjM7iiCWTH?=
 =?us-ascii?Q?6F5vwjRtW+yb91r20GcVQIM//mSdmR7N59PMN33BOPAw4od/Fv3fZuopBCGs?=
 =?us-ascii?Q?g3sIVJA9gU+Qy300EszIyHvsUzyGzOxMglPt1vOCDF3yMd0iqrIkIRK+xPBh?=
 =?us-ascii?Q?eW784J2ciNz9i8jGbUDmeU7cqIRgT5eSIU/WjhdM1GnNvOuBsTMyEErx6HDv?=
 =?us-ascii?Q?NP2AlvxWsaDRtATlNpNpPTTkBDPIpjhCM930NtvioOMMOv+KNISzU9pU8g/p?=
 =?us-ascii?Q?Hf+EbdQisZQvNUqpPDUkxd/AkpRPZdatlY97XCqru5kyCaUBiZezt6hYVket?=
 =?us-ascii?Q?eq6z9ZnP0230YBSh9yRZJTFXN7DyfCIjtI0Ogdf5rsgcP9Zn1mmLiGMii4Me?=
 =?us-ascii?Q?eoueks4z6O+aeyUVX6pc2TOVf145w/KazNVbGLN9yzQQL8dNwbDvYWt21jQP?=
 =?us-ascii?Q?i30VADmohi2B/iBZ7ZYpAsUstyZWrdTya/zGs6a9ThMe099wzQnTc921+FZs?=
 =?us-ascii?Q?V63CnX+niI2CmfhtcxuFwNEYI4ePDzNVdRafoLtNRHkPk6u1KInBtrdz4Rl1?=
 =?us-ascii?Q?/u3rfQFRw9Q7B/m0E/ajDHzz5QPRdze58PhWoiowSxJQSAex3pGsYQy4oyQb?=
 =?us-ascii?Q?Du7yARwadhpcuGl/TjxaOYzfl6FHFPUO43IxPCno3tjQ82IPBVitf9mLzdMr?=
 =?us-ascii?Q?wQ9bDw6H8gk=3D?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(82310400023)(1800799021)(7416011)(36860700010)(376011)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 04:58:00.1868
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 750161dc-3f4d-4e4f-70c1-08dc91aeb98a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS3PEPF000099E1.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8271

WOL modes such as magic-packet should be an OS policy.
By default, advertise supported modes and use ethtool to activate
the required mode.

Suggested-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Vineeth Karumanchi <vineeth.karumanchi@amd.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/net/cdns,macb.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/net/cdns,macb.yaml b/Documentation/devicetree/bindings/net/cdns,macb.yaml
index 2c71e2cf3a2f..3c30dd23cd4e 100644
--- a/Documentation/devicetree/bindings/net/cdns,macb.yaml
+++ b/Documentation/devicetree/bindings/net/cdns,macb.yaml
@@ -146,6 +146,7 @@ patternProperties:
 
       magic-packet:
         type: boolean
+        deprecated: true
         description:
           Indicates that the hardware supports waking up via magic packet.
 
-- 
2.34.1



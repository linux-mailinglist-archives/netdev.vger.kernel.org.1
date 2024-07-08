Return-Path: <netdev+bounces-109816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 149EA92A021
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 12:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9354E1F227AC
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 10:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5272C78C6B;
	Mon,  8 Jul 2024 10:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="atWtePvI"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9C73A27B;
	Mon,  8 Jul 2024 10:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.35
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720434471; cv=fail; b=SkWTqsS5/vuJKT2ijc2NSKEwO11MEwDbIumZ7SyKXDLgUMI+nieKkG20eSskdCw/XhtR8RPWf70j8w4WSDVsopP0sa5vtkLtCZtW1kg1/h4TYdcMdcgjc1FRsspYjVRx7NheeOtKooORJbc1i4RLAU941K+CLHArHqlRFbMbtyA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720434471; c=relaxed/simple;
	bh=rY2yN9ZhJccZa678cRD8YoBWUIqI4x8dUEU6EmR2Ye0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bqpsEEGCqY1qggTq/EqzDZIUNgpB1vG9t+7DIEBz2gpQtUZKNaI51g+gBjrcUHzhFxkwczfXpL2LjTMB2i6zmO0AM6Dv5CzBeXvc0gT1UbV7JZkR5wF+PydH1HvsyiIZ3shtz0iXKGfp/xCKo6T3TdToXiGb7AQDpN2TaHugO0w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=atWtePvI; arc=fail smtp.client-ip=52.101.70.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ANQgYqRhyQwDaYkFolFbvQb4m1bcbQsMSs9/2iFkiIkCpvwdzf2zLsr3m5l2I1/tcIDl63TBT/9QlU7SzURLwqz7ZnWjM8JsHF911HUD5zMTXIzfDkndmtgD5hsX1UJdoUiqgXlzwEwn2WwlmBDDmYjxYt5hJD3191Re3PxFk7fRm2fcSzmSsfkBBgJn3/bct8qRGX5gnrQdyhtMjD631j9uUpkjCrYeCtKDO56e2q8/Oev+tFKSzv1KDxaWkYm6gKmdMoqadMk41oF0ObmPp6i5PcZVZ6sSF7gzsOg4vzGMf3JOn977Ny5HfGVR+HExhTQJIFulRQ4Y12dP57auGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VrzxF+efmd49eXzkBexWj4ZUsr9TZMniEw4M8z6Onpc=;
 b=WeFnOfKjotFg6e2v3LKpb47FO7ETyBm8OLIyH1wZ036t5JDfUFd3bPbJRPyug1yz8YcXyHAT2qJ/xVUe3u2EWg77fWh2o6DxIXtc8e7uF+Lbw6oiT6G3ysDm6qKEIbblgoxeBMNyj63TPLC9rkgrxvd+QO/5dolRhq1I+clg4e2/zlE2iAr0U1ysTMyMn6gNTJSCmwJ0YxkO99/t7NNE/4brUbFYqHd5N/24VXEBq93wIt75np1+TAqIBRGNn4vfXzsZLqJb3U7vhZ/NqpE3Cw300+FBrIBGrOYUd9xGyH6Ra2s+wLsbPSEhwk+/mJVTYTuAF5C6iOA4NUH2j9i4xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VrzxF+efmd49eXzkBexWj4ZUsr9TZMniEw4M8z6Onpc=;
 b=atWtePvIXFpo1IhPLa9OhJV1tHH0KqRuA6kw8SDfs0ZR4+arK3aBMqVEwNzaWnEFp+ecylhGHYw328uSvXJxzRX/7316x4aB6iIiIDdmVGbmXAlT8LtoZ8pbkfOYoZ/bk084FvJTUvnUYG8+UUjaWYFKCypHvQVVdEJKnj3Eafw=
Received: from DU2PR04CA0073.eurprd04.prod.outlook.com (2603:10a6:10:232::18)
 by PAVPR02MB9642.eurprd02.prod.outlook.com (2603:10a6:102:301::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.30; Mon, 8 Jul
 2024 10:27:45 +0000
Received: from DU6PEPF00009524.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::f1) by DU2PR04CA0073.outlook.office365.com
 (2603:10a6:10:232::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.26 via Frontend
 Transport; Mon, 8 Jul 2024 10:27:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF00009524.mail.protection.outlook.com (10.167.8.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Mon, 8 Jul 2024 10:27:44 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 8 Jul
 2024 12:27:43 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v11 1/4] net: phy: bcm54811: New link mode for BroadR-Reach
Date: Mon, 8 Jul 2024 12:27:13 +0200
Message-ID: <20240708102716.1246571-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240708102716.1246571-1-kamilh@axis.com>
References: <20240708102716.1246571-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail01w.axis.com (10.20.40.7) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009524:EE_|PAVPR02MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: 2af525cb-6a39-4c96-56a3-08dc9f389abc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|82310400026|376014|1800799024|36860700013|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UVZzbW9Bekt5STE4Q2c0UHB5dFNSMHpzMHlrYzErS0Zvd0diODMvd25wU3BU?=
 =?utf-8?B?NTdNTUJOdlZHVEFVY2wvZHRlNmMwOTg3aGZFYitkQkw2aHlkTC9xRVZ6TXZJ?=
 =?utf-8?B?b1pMTkE3Q2EyYzBoaFU2Sm9ONS9KdDZRSmhWeEhjRjN3blA1ZnIzK1hSWTZ3?=
 =?utf-8?B?KzV1RVdyd3FmNHFPdVYzMUk4eFdGZkRWQjVaT3ZvTThHa1NZUDE0SlBNd2M4?=
 =?utf-8?B?aUZ2RVFldHRuT3VncTlJYU14ZGNZRE1PZXRsL2ZWdms5NDh3THVwVlRJczhU?=
 =?utf-8?B?Z1hDRjdVYVlkSXAxN1NrY0ZWMk16SjVVdG5jQU9CZGUxOVh2VDEyZG5FZDRp?=
 =?utf-8?B?YitmMXBSTVUrMjhhMXp6aGNENndHMEU0TEk0SkEzN3ROSkoyZGIwVWpZKzZL?=
 =?utf-8?B?QVFQUFN0YVVhaFpKVmw3U3RkT0lONm01a1BiaWJWOEpZWGh0b1YyRGhZT0k0?=
 =?utf-8?B?M0wzdHY1cXdvSUNwanExV0QySG9JdmZ5YjFpQnZteEU5Y0FzM3R0ZG5uUi9i?=
 =?utf-8?B?dU9LNTFHYjBPZXpqUGV0UHI3SVFpTmd1dUZJb0NMZmpwdWJhT0o1dDRnYlhB?=
 =?utf-8?B?bU91bXYzdzI1SlNHOExxVFU0b1ZCUXVQclpaWDdsWGI4NyswOStpaGphMTMx?=
 =?utf-8?B?aVNiYmFpcmluNEZaV1N6RTRQSFVIckJGWmNIVCtyQjFBa3pvZjF2K2xmUHcy?=
 =?utf-8?B?UGt2MHlHTlhCdzBqRUs3K2VidUh2K1hQbm5ac3NOQjRCa1J0N1BuVklmckht?=
 =?utf-8?B?MlZSYkNPZFpLN212L1prcUVzQnV2dHQ5ckJzYkdEZ0ZHTnh5Q0hYRmxhTDZq?=
 =?utf-8?B?emJOSlBsditzNllmZnhKTXZrZ2V0ak9BVDVFamtoa2NzQ3BnRzd5Zlg1bTNy?=
 =?utf-8?B?cm5SeUt1a2RvZ1F1NkRqOEsyTkMzSUN1Qk40b0VEWldMQk82WWVlaXBraEtr?=
 =?utf-8?B?aGw4cGFMQXg4S3R2cW15cEVhczBOTWNreEtmeEY3d1dGWWxwNUg3YW5iazBR?=
 =?utf-8?B?TTNUbmFlTE9rTkhkaU9NVWR4TkJqVkpDalZJV2hjOCtodnJTYlk2a0FEdmhk?=
 =?utf-8?B?ZGZTd0Y1UjZEMEZWd3JQc3hFVlZ6WkhZdHEzZ1N0NVFUZVdEMDdrM0RkZFBk?=
 =?utf-8?B?UXdaUnRLa1IwVjFsYlJ5T0MxN3daV0c4VEFGZ0tPaEN4TkxacVdUSUViamxS?=
 =?utf-8?B?V0dnanorSFdDbGl4ZFpSbHFYTjFYSnk3RnIxZ01Pc2htWjF2Sm9jekdOSE1w?=
 =?utf-8?B?cU9iSzhsNDcvcElhTjNyV1AzOW9hb0lzTkh4aTZ0RXRzam9HTzBTa0lhb1RI?=
 =?utf-8?B?K0VhSGVobUtGbWtucW9JbUlSa1dkYnBtSmF3RmcySis2SVJwcmlzbzJsd3F5?=
 =?utf-8?B?MGxjWUxkNlI3RGpmTFpDVTFzWXlLZGZrbVpZeGdCN2RneFV6N0JoMzhDQnVv?=
 =?utf-8?B?S1B4RGRuejBiYW9DUG96RmhsOU1nNVJtTEpSQVlVUzF5K08yVFp4TWV2RWdu?=
 =?utf-8?B?VWlpMXdtN01sRkk4eFZLaDVwSjg4YTRGSEdxZ1I1YXJpZGlESGpmblRlNWN1?=
 =?utf-8?B?eVExNk83ZHd5bmhlbjhrQ2FCUE5ITFhhVjdZZktGaVZicHJtTFBGMk50RTZG?=
 =?utf-8?B?QVFIaVE0ckdlUFM1OStnTlp2bm9vUjgwWUc4dGQ5RW8xVzI5RkZpUDF1Wi9p?=
 =?utf-8?B?Y1d4cVFGOVpSZEV6T1grK2NCWmo2T1gyWjZYUnRqdCtmQkwrS0F1VWNKNVZr?=
 =?utf-8?B?YVF5ZXN1YWhMWllKYTBMVzBUSjdkSEc0b2tWT1JERVUzNUhLcUJEQS9CRkg5?=
 =?utf-8?B?ZVNlZ2JoQ2NWNWhCa2t6SmkxR2E2bTZSYnZvMG1rV1V1R25KWE9UWjczMGpw?=
 =?utf-8?B?N09kbEoyeWZjMVVZRHFHNVFjNkM4K1dSWGxGNHBvOHoxSVBJVzI1enFxVGZq?=
 =?utf-8?B?ekNJcVJReHdMRFBvd25pd3lTdy9OazJScTRHNDlDeHZNRlI3aXJZNWRxMHI0?=
 =?utf-8?B?b1ZxaWtQUGVBPT0=?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(7416014)(82310400026)(376014)(1800799024)(36860700013)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2024 10:27:44.1849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2af525cb-6a39-4c96-56a3-08dc9f389abc
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF00009524.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9642

Introduce a new link mode necessary for 10 MBit single-pair
connection in BroadR-Reach mode on bcm5481x PHY by Broadcom.
This new link mode, 10baseT1BRR, is known as 1BR10 in the Broadcom
terminology. Another link mode to be used is 1BR100 and it is already
present as 100baseT1, because Broadcom's 1BR100 became 100baseT1
(IEEE 802.3bw).

Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/phy/phy-core.c   | 3 ++-
 include/uapi/linux/ethtool.h | 1 +
 net/ethtool/common.c         | 3 +++
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index a235ea2264a7..1f98b6a96c15 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -13,7 +13,7 @@
  */
 const char *phy_speed_to_str(int speed)
 {
-	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 102,
+	BUILD_BUG_ON_MSG(__ETHTOOL_LINK_MODE_MASK_NBITS != 103,
 		"Enum ethtool_link_mode_bit_indices and phylib are out of sync. "
 		"If a speed or mode has been added please update phy_speed_to_str "
 		"and the PHY settings array.\n");
@@ -266,6 +266,7 @@ static const struct phy_setting settings[] = {
 	PHY_SETTING(     10, FULL,     10baseT1S_Full		),
 	PHY_SETTING(     10, HALF,     10baseT1S_Half		),
 	PHY_SETTING(     10, HALF,     10baseT1S_P2MP_Half	),
+	PHY_SETTING(     10, FULL,     10baseT1BRR_Full		),
 };
 #undef PHY_SETTING
 
diff --git a/include/uapi/linux/ethtool.h b/include/uapi/linux/ethtool.h
index e011384c915c..54b31344961d 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -1863,6 +1863,7 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_10baseT1S_Full_BIT		 = 99,
 	ETHTOOL_LINK_MODE_10baseT1S_Half_BIT		 = 100,
 	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT	 = 101,
+	ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT		 = 102,
 
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 6b2a360dcdf0..82ba2ca98d4c 100644
--- a/net/ethtool/common.c
+++ b/net/ethtool/common.c
@@ -211,6 +211,7 @@ const char link_mode_names[][ETH_GSTRING_LEN] = {
 	__DEFINE_LINK_MODE_NAME(10, T1S, Full),
 	__DEFINE_LINK_MODE_NAME(10, T1S, Half),
 	__DEFINE_LINK_MODE_NAME(10, T1S_P2MP, Half),
+	__DEFINE_LINK_MODE_NAME(10, T1BRR, Full),
 };
 static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
@@ -251,6 +252,7 @@ static_assert(ARRAY_SIZE(link_mode_names) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 #define __LINK_MODE_LANES_T1S_P2MP	1
 #define __LINK_MODE_LANES_VR8		8
 #define __LINK_MODE_LANES_DR8_2		8
+#define __LINK_MODE_LANES_T1BRR		1
 
 #define __DEFINE_LINK_MODE_PARAMS(_speed, _type, _duplex)	\
 	[ETHTOOL_LINK_MODE(_speed, _type, _duplex)] = {		\
@@ -374,6 +376,7 @@ const struct link_mode_info link_mode_params[] = {
 	__DEFINE_LINK_MODE_PARAMS(10, T1S, Full),
 	__DEFINE_LINK_MODE_PARAMS(10, T1S, Half),
 	__DEFINE_LINK_MODE_PARAMS(10, T1S_P2MP, Half),
+	__DEFINE_LINK_MODE_PARAMS(10, T1BRR, Full),
 };
 static_assert(ARRAY_SIZE(link_mode_params) == __ETHTOOL_LINK_MODE_MASK_NBITS);
 
-- 
2.39.2



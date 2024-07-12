Return-Path: <netdev+bounces-111092-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DAD0B92FD2B
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 913C2284882
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6700173359;
	Fri, 12 Jul 2024 15:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="gw07D4mb"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F7171E73;
	Fri, 12 Jul 2024 15:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796873; cv=fail; b=gSTnzKoh7InFen99Coyw3g/ntpSaWdEMfhaCfizlW/rZh1kguovEpGDl89oG/ixFfssawAcXw5zpsXQwp+Da13HunSKrSDw5dYejK1LIQfWG8wTPUIwus8RWqyLPZLx3U0QXBaWPAcPdXQ+5RyeW4gAf5vIdPilxrekCCYjo1IA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796873; c=relaxed/simple;
	bh=CoZS4HyrZpd1L0x+7/ATWOtTP10BJPpKWx74B2nMaug=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cS2y79K3rtEkXYyN5RMviY36PU719ZTlI5pQO0DNbi1l5xYkAEx+h7MP7o+2BZ8bLDeRlU+UJTQXXcTiyI6oJgquJJyt80i3ier9/sz4/uL2icwsaNpFMw3Gdf5gDZgF9Dml+7Q694r0E+q2d61O/FeSXzvNQInST/LDa8U9vjw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=gw07D4mb; arc=fail smtp.client-ip=52.101.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=htYKb8Fft4PCCRL6F3oe5aTmC8cm/y+pE+g7OWChPDoOotxVbqZ0k2ptR3Ef7uw/4O5RThZ4fdZ4frOmbY0DuBm9nABT4Z4F8/tBEVFb61Dohq+X/9nVHW5/e2df1Fpxa8eqieLENaDy7OVCY5FKJzMzFl9sVxRvacpjfSKq2JY9j0TvbDNHLQck68XXOe+wIVAOMJ1IK1oIfR3z/l/0ESk8hwt1GQaXU4BAXkclnH8FjNTrkeR7PJOOHTz3RjWVuFvokopO4dCw6MSz9FtUVd7LXj00oVbVJIJGILD73oaXOpVN58nI/CK2sjxPXdif0RI4jZMpq/teHppCDGQqOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d2eCV92LUQjh47mH0GCQdRzqvYB2dM8HWuJhuqWLlCI=;
 b=JOu/WSSKS78pu48HOYTY7bgxKl4vE/dAslFMIFlVnWv1lP8F/qczAi8FfvaJXTmBdH/LAffP1pdUoTt91ZkKQt5juzM0kEKO9u+FafhwXON5JbpYLCjQfs/KN2vkzvGx/aSco1ONxNut0lZ0KkAduEzbAFOUxzwgLQ1CbgZdIYnXWZmHjaqRbM++bllgmugihjF3VZ2Yf46syLEmdlcRyW7cBUyODFY95yZJ/UukUyno4m2wp22lvzxUzeGjIzOuzTSHdOtFncCvwF9BLsS1SwK33YQhkQw6T9rbU6AW8wvLk1gwFILJlOjKqLuFlJPMXjqULhA2i4OOTuKV+tPP5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d2eCV92LUQjh47mH0GCQdRzqvYB2dM8HWuJhuqWLlCI=;
 b=gw07D4mbthzV+NkhNHSovoUpblDiepv7Bis5CRwCtmP1WLB3noLc+WVK/hjdT1o/BqgNyrfc2bDtU/1iXN23frpk7s4Pv1m96gSqtRC3Nk+Ex3LI0pZYJTBh9ldCkaRcdNL8iX//T2W/VEjD/2aAvC8mNTgmhP5hxZcKgjc8iec=
Received: from DU2PR04CA0223.eurprd04.prod.outlook.com (2603:10a6:10:2b1::18)
 by AM9PR02MB7121.eurprd02.prod.outlook.com (2603:10a6:20b:26d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 15:07:47 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::c2) by DU2PR04CA0223.outlook.office365.com
 (2603:10a6:10:2b1::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Fri, 12 Jul 2024 15:07:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Fri, 12 Jul 2024 15:07:47 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Jul
 2024 17:07:45 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <f.fainelli@gmail.com>, <kory.maincent@bootlin.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v12 1/4] net: phy: bcm54811: New link mode for BroadR-Reach
Date: Fri, 12 Jul 2024 17:07:06 +0200
Message-ID: <20240712150709.3134474-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240712150709.3134474-1-kamilh@axis.com>
References: <20240712150709.3134474-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|AM9PR02MB7121:EE_
X-MS-Office365-Filtering-Correlation-Id: 12b54f5e-51b3-4aea-4f90-08dca28463ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|376014|7416014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?N2dERTRJdlpxOEdmKzJtZUdEOWpsMU9QTUt0WUtKaVhmaVljdmpnYkw5NHBu?=
 =?utf-8?B?T1NOSjhsYWswQ3FtYlZOSUxwZ0haSTdJUlZoc2FKTy9mSENOc3RZNnhZaXRP?=
 =?utf-8?B?TkZNZDR3SzZScnJVZFNxUzl4dzlJazl6eUwvVGxOazhkQXB0cFB6dnNlZXQ5?=
 =?utf-8?B?UUFrRTk2ZlQ3WUFoTk9sS0QwSklVdEZ4ZUdNRWVhcFQzZEM5SFkxZG1ZMU1W?=
 =?utf-8?B?UXNtRHFwdXlpNXkwQUdKYTdFS21zS3MxcjdYcDJ3R25jY01oaXU5Q3E0T1RH?=
 =?utf-8?B?cVZvamJXQklhdyt1R0YvQ0t1a20wR0U1N25sTUZSOFhSNUxLNnQ4ci9oVnpT?=
 =?utf-8?B?U1phbkRuSDFMVWluUTlYd3lHOHhrNTlRRlo2OExXT2dzSFhONklwbklIYTdk?=
 =?utf-8?B?RGFEZjVXelBCZWI3MHQxK0hDUkplazh4cEJPUW5iUngrSkhsb0xCdjBWb21t?=
 =?utf-8?B?N3Q0ZVpORy9wVWdxNndvZjRyZjhJaDlsTWpHYnFMQUJkWVphRXVWR05jY0NQ?=
 =?utf-8?B?ZnNOK3Rxa293b2tORGg1M1oxUlp6ZTZCWjFZV01vNVNCTGthRnlEV1V1bEh1?=
 =?utf-8?B?eHc1ZTd1NU5VYlRTazRhYnJTc1Qrd2JJTis0WW0zaEVWeHpzeTZ6V013YTYv?=
 =?utf-8?B?ZlRGOFZiZGhTblVUSDNEdlNxZzhtbm1MQ3RET214RGp4OGpWTDRJZENRVlNr?=
 =?utf-8?B?MmIyTHJVUERjVDFFL3VOQ1VmZWRzU2lERHBZNFVkNzVwZ2hyZWN0eWRUNjhH?=
 =?utf-8?B?YVQ0WG1DL2R4M1ZNdlJ0N1Zqa1prVUZRNjVIQmVyNG9VL1g3cm5wRElwM1Z1?=
 =?utf-8?B?ci8yUEpQOHBINU44amEyNW5NOWs3Tys0aUZDNzBoOHBJcXFKZ3ZlYlNmY0dr?=
 =?utf-8?B?eG9tSjcwMUM5UmFQUTY4SisveFZNUGpsYUN4eHhBVGdQK2wydkFpUGtIK0x5?=
 =?utf-8?B?RVI0OEFJck9MYzNuaVh4UGRHbVcvVHFWSUJXTkhYRGZlRHRwdEdBMmF1TjhH?=
 =?utf-8?B?VDJjaXpVbHV1M1BUZ1FpQWdZdmYrUE5EaGJhbEpVVTBjZ1d4ZDZTMm4rdEgy?=
 =?utf-8?B?RkdZRTU5SUNabUQ4WnkyaXlzVlFMZ3VBd2l3QjliSTVKOTU2Nmw5Q09HL0RQ?=
 =?utf-8?B?OTVGOGhJWWJUeDByTFM3clYzTUlPencra3hyRWIwdWp1a3c3RGtBTUFGaWsx?=
 =?utf-8?B?VHlhOTYyenhSbmpWUFZrRmRuTmY5YmduVkpmWDVXUlRDZ1JsZmV2VHpNY1NR?=
 =?utf-8?B?Unl6SUdQMFNDaGhZVkljY1NlcHpZMlRGNVR3S211VUJJWE5tSlFjRllpY2pi?=
 =?utf-8?B?Y25nVnVDaVZCaXFZaXJtK3pqWDRKakhJcllGTjgwL0tvZlBjYUxhWndRNGVT?=
 =?utf-8?B?d3MyQWRYeXNtU0MyNWJYZjlHOXJxY0c4RldQUlZJRnFpMm9LSjlOUU51LzdT?=
 =?utf-8?B?dXRwZkM5Rjl0ZkFDa1FITjl6SEd2S3F5Z2tDYzlCa0kzR0RUYzFXcU9hanJZ?=
 =?utf-8?B?KzFQd1hEZFJZbDFZelFuaGpKWDBLZFRjS3NyWVNlNFBEd05md2ttSFRIbm1y?=
 =?utf-8?B?TTdOOGU3T2ZLS3JjelpGOVRFR1pVNEtWN0FYZnZvMTZOaHJUN3pJVE8ySlF6?=
 =?utf-8?B?QkZLUngvWXdQa0R1SFA3TElEUjVDdElkQU1STXVUWXRGRlVydFpyclZxMk9l?=
 =?utf-8?B?UkJ0a09paXhLcVFWb0wyVzV1ZU9Ta3hOTmdscUJMYy9LMDBJekxvaG5EUEt0?=
 =?utf-8?B?YWRKLzh3Y1NVWHRpTzdKaU80RkozUldUdDgrN0g2REZEaURlak9XYlIvY2F0?=
 =?utf-8?B?bVZXcE8zNXdqS1A3S0M5SWhBbzVHWm8xWmNBOEQ4T0ZyTHZTTStmcVg5TkV0?=
 =?utf-8?B?a1p3Y01vOE4venVzQnJOUFlMR3JmeElET0dBTmVmd0hocm4wRnVPSEdUZVF0?=
 =?utf-8?B?QWFtbkJvY1RlSGl3VWZreldrbWhGVjNPYTJZQjVVZ3J0bWxLWXFyNURidDU2?=
 =?utf-8?B?T3UrMGlTdGNRPT0=?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(376014)(7416014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 15:07:47.2834
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12b54f5e-51b3-4aea-4f90-08dca28463ce
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7121

Introduce a new link mode necessary for 10 MBit single-pair
connection in BroadR-Reach mode on bcm5481x PHY by Broadcom.
This new link mode, 10baseT1BRR, is known as 1BR10 in the Broadcom
terminology. Another link mode to be used is 1BR100 and it is already
present as 100baseT1, because Broadcom's 1BR100 became 100baseT1
(IEEE 802.3bw).

Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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
index 230110b97029..4a0a6e703483 100644
--- a/include/uapi/linux/ethtool.h
+++ b/include/uapi/linux/ethtool.h
@@ -2054,6 +2054,7 @@ enum ethtool_link_mode_bit_indices {
 	ETHTOOL_LINK_MODE_10baseT1S_Full_BIT		 = 99,
 	ETHTOOL_LINK_MODE_10baseT1S_Half_BIT		 = 100,
 	ETHTOOL_LINK_MODE_10baseT1S_P2MP_Half_BIT	 = 101,
+	ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT		 = 102,
 
 	/* must be last entry */
 	__ETHTOOL_LINK_MODE_MASK_NBITS
diff --git a/net/ethtool/common.c b/net/ethtool/common.c
index 7bda9600efcf..e92ce33af990 100644
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



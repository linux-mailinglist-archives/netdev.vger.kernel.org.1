Return-Path: <netdev+bounces-201257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 086EDAE89F8
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 18:36:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CCA4A315B
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 16:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DFC42D8769;
	Wed, 25 Jun 2025 16:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="rITrhvw2"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012020.outbound.protection.outlook.com [52.101.66.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E33292D320B;
	Wed, 25 Jun 2025 16:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750869318; cv=fail; b=YswxRr9FFW6+4/1TM7THdZ1dvEkvhBDGZEWVQevkRVTDU1m8jASngpwqYqQLivWhkBoIXDuy/QYWCOZBmRIOBRPPvMTtCG0ZOlu3WTw//Wj7AEf/vs2pUocj34yMgKQe/6hXAbSq6fPLW2S6rvrAXQFGJKrTZwkwKFcqFSXmJvA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750869318; c=relaxed/simple;
	bh=9Ab8Hr0P589+2/k+k1ckGcu1dTQZIIKcw6nBRwa9T2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gX9s79LkqjeBEmoDBVdTf2d4EUvnhORLvnkO5LjAOd42SLeDNzq2d0qwWkO0OVKxK9NYW200HRPmW1QxmlrV/su5IWvgZWGMuzV/HFHLsnhk19E7b1iUJ8x4j7zoyOT1LnZ/a+/H17AQhez+BVMXha7GUsdGm8vWSbs6xH808Y8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=rITrhvw2; arc=fail smtp.client-ip=52.101.66.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R0mV8TrfnLzGYdppsCoScF8pXZyqEYw2byUxgIKD0fcDsRtRbWgErjVplTsOree6uWqHGNadgXeitTbP3tBrFY3o1t06PpS4xbXWKu/mGGxRMmevRGfSCgdcZQkOpMbgnwNG+/bQWRsDgthgHTiScnt0zc2hLi3Xt96CLLnfk/Wc8+MBi9OAamHgNpdTYtGkHwJ3y95WS/jL9PfCjLMz3YFdqy6h5BHOJs3RXzXLya6pDVbuFtRFZhGrxBCJVAiwRoAr5wpjRj3pRJblObq7iF/+cqnv71OXPV2fl4ZW8htoJUiyhWvoQn/RIQL0VMD0d69Lh8+Ji1g+EglgFxiU/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETMjB9OUmu9q1sD8dOCeAnDunxpzp63VkYoHexQEaHI=;
 b=ubJjykIi6VQQatx/MjuBa7GZXR/O+SuszNGKC4X2nhyLh3i6/utasUF0/SXwv8lH4CGcYf1wm4zcG3NAaefLXE5D695nFjXV3mPZsty9IoL2jgDsfFeNsbfiPA2zfmqi/6Ky86PNRXuqry+EXzr8qWFIldhbr5cPt89qRmYWx7o2d5JmEI/dBEZbIPyl9mm+fTHFoeoCKEeroPFZPGq5Oz7OzONYTsippo7R6e4zjrGWExxfMKLdKkZ9FvmunAcpjS8Nq11ZlpxW4r1E4nFReyJNPo0O5MrFbZePome/0KeJek11OZsE1VNJRFJns1azTW3Xf71SBP9Tbb/GnjTxzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETMjB9OUmu9q1sD8dOCeAnDunxpzp63VkYoHexQEaHI=;
 b=rITrhvw2kOA23YnbFip5vFzTQCrIbKOy3knm8juuW4SBPDfcYtVLtg5UjjwjFbAyLvQKTaN5cH86n1FBUq5bA4uVC/qdpkek4Ya2E1rO0jBBT861MMPgeCYSLw/dVDkW83/bGm39X9ZbjLF5kdG2Up69kRFlJ+JYPTmSd1lbLRo=
Received: from DU2PR04CA0250.eurprd04.prod.outlook.com (2603:10a6:10:28e::15)
 by AS2PR02MB9550.eurprd02.prod.outlook.com (2603:10a6:20b:599::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 16:35:11 +0000
Received: from DU6PEPF0000A7E1.eurprd02.prod.outlook.com
 (2603:10a6:10:28e:cafe::98) by DU2PR04CA0250.outlook.office365.com
 (2603:10a6:10:28e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Wed,
 25 Jun 2025 16:35:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000A7E1.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Wed, 25 Jun 2025 16:35:10 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Wed, 25 Jun
 2025 18:35:09 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>
Subject: [PATCH net-next v3 1/3] net: phy: MII-Lite PHY interface mode
Date: Wed, 25 Jun 2025 18:34:51 +0200
Message-ID: <20250625163453.2567869-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250625163453.2567869-1-kamilh@axis.com>
References: <20250625163453.2567869-1-kamilh@axis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail01w.axis.com
 (10.20.40.7)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E1:EE_|AS2PR02MB9550:EE_
X-MS-Office365-Filtering-Correlation-Id: f50e33ae-1daa-43e4-1b78-08ddb406407c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|82310400026|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZWJ3d0NqUlNRWVVuZ3lsRTdZd0pzTVowWHhmWitwUzdBY2NuTGR0VWRjazV4?=
 =?utf-8?B?VkR0SnA4SUNpRjVRUXRJQmxGendBMXQ2RDhFcksxcWtJNHZnQUg0Z21keVd1?=
 =?utf-8?B?QmJZblJLalRNUkNUcFFCWEhkVURaM3Vxamo5TUpmNUJ2dEZ2ZUJoeTlZR1lj?=
 =?utf-8?B?QmZwbm1EUk5VcGl4aTNkeXBHWVJ4YUtTNVBxR1NpZVFxK0RkSTJlRW82ZnN6?=
 =?utf-8?B?dWxGUm1DM3BDbjN2dEcvNkt3UDZmNjRnOGNya2owaUJ3RWdHcEVDNkhZYThj?=
 =?utf-8?B?TFg0WlZOSXJXWkcyb0wrWXZ0U2VwM2kxMlNvWkFKT09BUlpwMC9zNGl2U1F2?=
 =?utf-8?B?eDRMRnV4eS8vcFNjL1dGd3pIOG44OURUc0FjRzJZSzlMOWY2bnozVXRXRVFR?=
 =?utf-8?B?UGZWc3FlZzZubFNJaUMwVzlYNU5YSW0xdlJ6UTRmYTczQ2E0QW5HcFNTbnpv?=
 =?utf-8?B?aVRkcGFZZmtXaGlzUDhVSjBySXR1azQrSDFNZzc4V1h2cDk2czlsRjljZ0FD?=
 =?utf-8?B?MWlnZHAyNTlaakkxVjh2cDZ4SG1vN1hLcDE1RjlpNFhPd2ZpODgycEdBOThv?=
 =?utf-8?B?dXBiWkRaVGs2SGc1TFNOdVFkazJ0VVBZcVo1ak43ck5TbVp0b1NpTVp6N3gx?=
 =?utf-8?B?cEpxSERjbmd1T1NsWCtOcnVIckh2VHZVL1hvU0IyUTdtVERWQ1BQTzhXM3I2?=
 =?utf-8?B?YVVhODZadDdia1RDSTYwcXVZNTZUNGM5RG1QRFcyZEloSHgxeHF1RjIzeVBH?=
 =?utf-8?B?VFJXcW1hRHVOb3ZDUmJuSHFjb1lDc2dPS1VZUFkrbjd0YmMrRXoydloyNEdC?=
 =?utf-8?B?M25WZ0lwM1ljdUVFeTFvd2FLUW9jQklpaG91b0xpUjFxd3ZCQUdzZW40K0RB?=
 =?utf-8?B?bnBLcUd0a1MwRHpTQVFYWW9lU3JveWtjS2VsSXczWjdiWXhxd3FuYXorYzhn?=
 =?utf-8?B?V1FtTkRlUVQ2VWtPYkpuWmRQVFNlQWdEMHU0NzBRYzdBdk9Va3o4NUY2clF6?=
 =?utf-8?B?NmNIWE4yYlpJbmxSREc0NjRSa05qclRrTzFaODluYlNVRjhtOSs5WDNmTlc0?=
 =?utf-8?B?cVJldEJZeUloaHlENFhYU05xajkzT2lKVjdNZjN3YnFmNGRaMHkrdk1VbE9V?=
 =?utf-8?B?WHR6bmVycWJ4b3kvLzBwUEpFSERDcWxUd1NnUXlmNFh4RnpIMU9Cb0FGNjJ6?=
 =?utf-8?B?VTMyZXVnQVVMQ0RrR3BYNnU2ZWlRWkxPM0Q4cHE5d1dOUVdncjdObnlTdzA4?=
 =?utf-8?B?RUJNWnd4Ti9RZHlyVXowWmUwZWphSTlrN09mOFFoa2t1YUhiRjl2YVVpbXRy?=
 =?utf-8?B?T3ZBR01qZkl6bkVWQ3NVZmpuL1JBeU1MNEFIdXEwQmxncnhzeEhQaTJyaUJB?=
 =?utf-8?B?emNQTmhyRGJKVVhIOE4yRE9lZFhlUnhvdWNkNERBeHpxVmZPZEVHeW5oeXg1?=
 =?utf-8?B?S1M4NWVVTW5tUEJESXRrc2cva085Q2NZR2djRWttT0VWaVU1QmhQR2hkU292?=
 =?utf-8?B?cDRtY1pTTFlGZ0dVSDRqSENydHMwb0ppNi81TWd6dVhwZDhaWHpjb1k5ZitC?=
 =?utf-8?B?MjZhWjlFVUNUSEkvMlNqVCsrL05CVENiMmZja0xmNXRBVDNtMkJ5eHhyL0lm?=
 =?utf-8?B?Nnh0aEtjSFVBTDBzeVltOVE5SSszTGZRSTlGdXVEcUVTYmZPdDlYbENNUEly?=
 =?utf-8?B?akkxT0FSR2F5d2MxYllDYU03UmxEaEpCUEhKYTFXaDdCd3lWUVlLSThvUVh6?=
 =?utf-8?B?MXhHSHdhVVZlVDhvK0EySFVJY2s0TnFvMmhpc2d5V29GTE1NRjM0U1BLT0tq?=
 =?utf-8?B?U3FQTXh4U256VnlpYjcwNlpmL1pWdmZtQjdtN1JHakFhREJORHRiWnVjRTNK?=
 =?utf-8?B?MVFnL1RScXplTUJzTDY4K1lPMkM3QXhYTjJIdEJGeGlxMlRoOFhNUUdWdUZT?=
 =?utf-8?B?YjFFV1FsZTVBR3Y2M1p3d0dLRGVVSjVCczBxVmZseGdySEhpcGxYS2E0Z0xt?=
 =?utf-8?B?ZGxBMHpjNU1jSGNwa0cySnB4WE9WaUpBZkhBRll5Ymo4UWdTR0ZWem1CN0JS?=
 =?utf-8?B?a2xSK0o2SXpSTXFvK0ptQjZUT1RKam9LSEZhQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2025 16:35:10.0629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f50e33ae-1daa-43e4-1b78-08ddb406407c
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000A7E1.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR02MB9550

From: Kamil Horák (2N) <kamilh@axis.com>

Some Broadcom PHYs are capable to operate in simplified MII mode,
without TXER, RXER, CRS and COL signals as defined for the MII.
The MII-Lite mode can be used on most Ethernet controllers with full
MII interface by just leaving the input signals (RXER, CRS, COL)
inactive. The absence of COL signal makes half-duplex link modes
impossible but does not interfere with BroadR-Reach link modes on
Broadcom PHYs, because they are all full-duplex only.

Add MII-Lite interface mode, especially for Broadcom two-wire PHYs.
Add MII-Lite activation for bcm5481x PHYs.

Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
---
 drivers/net/phy/broadcom.c | 7 +++++++
 drivers/net/phy/phy-core.c | 1 +
 drivers/net/phy/phy_caps.c | 4 ++++
 drivers/net/phy/phylink.c  | 1 +
 include/linux/brcmphy.h    | 6 ++++++
 include/linux/phy.h        | 4 ++++
 6 files changed, 23 insertions(+)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 9b1de54fd483..7d3b85a07b8c 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -423,6 +423,13 @@ static int bcm54811_config_init(struct phy_device *phydev)
 	/* With BCM54811, BroadR-Reach implies no autoneg */
 	if (priv->brr_mode)
 		phydev->autoneg = 0;
+	/* Enable MII Lite (No TXER, RXER, CRS, COL) if configured */
+	err = bcm_phy_modify_exp(phydev, BCM_EXP_SYNC_ETHERNET,
+				 BCM_EXP_SYNC_ETHERNET_MII_LITE,
+				 phydev->interface == PHY_INTERFACE_MODE_MIILITE ?
+				 BCM_EXP_SYNC_ETHERNET_MII_LITE : 0);
+	if (err < 0)
+		return err;
 
 	return bcm5481x_set_brrmode(phydev, priv->brr_mode);
 }
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index c480bb40fa73..605ca20ae192 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -115,6 +115,7 @@ int phy_interface_num_ports(phy_interface_t interface)
 		return 0;
 	case PHY_INTERFACE_MODE_INTERNAL:
 	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_MIILITE:
 	case PHY_INTERFACE_MODE_GMII:
 	case PHY_INTERFACE_MODE_TBI:
 	case PHY_INTERFACE_MODE_REVMII:
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index d11ce1c7e712..2cc9ee97e867 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -316,6 +316,10 @@ unsigned long phy_caps_from_interface(phy_interface_t interface)
 		link_caps |= BIT(LINK_CAPA_100HD) | BIT(LINK_CAPA_100FD);
 		break;
 
+	case PHY_INTERFACE_MODE_MIILITE:
+		link_caps |= BIT(LINK_CAPA_10FD) | BIT(LINK_CAPA_100FD);
+		break;
+
 	case PHY_INTERFACE_MODE_TBI:
 	case PHY_INTERFACE_MODE_MOCA:
 	case PHY_INTERFACE_MODE_RTBI:
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 67218d278ce6..5eb0a90cb3d5 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -237,6 +237,7 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_SMII:
 	case PHY_INTERFACE_MODE_REVMII:
 	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_MIILITE:
 		return SPEED_100;
 
 	case PHY_INTERFACE_MODE_TBI:
diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 028b3e00378e..15c35655f482 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -182,6 +182,12 @@
 #define BCM_LED_MULTICOLOR_ACT		0x9
 #define BCM_LED_MULTICOLOR_PROGRAM	0xa
 
+/*
+ * Broadcom Synchronous Ethernet Controls (expansion register 0x0E)
+ */
+#define BCM_EXP_SYNC_ETHERNET		(MII_BCM54XX_EXP_SEL_ER + 0x0E)
+#define BCM_EXP_SYNC_ETHERNET_MII_LITE	BIT(11)
+
 /*
  * BCM5482: Shadow registers
  * Shadow values go into bits [14:10] of register 0x1c to select a shadow
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 74c1bcf64b3c..70ac7dc795fc 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -106,6 +106,7 @@ extern const int phy_basic_ports_array[3];
  * @PHY_INTERFACE_MODE_50GBASER: 50GBase-R - with Clause 134 FEC
  * @PHY_INTERFACE_MODE_LAUI: 50 Gigabit Attachment Unit Interface
  * @PHY_INTERFACE_MODE_100GBASEP: 100GBase-P - with Clause 134 FEC
+ * @PHY_INTERFACE_MODE_MIILITE: MII Lite - MII without RXER TXER CRS COL
  * @PHY_INTERFACE_MODE_MAX: Book keeping
  *
  * Describes the interface between the MAC and PHY.
@@ -150,6 +151,7 @@ typedef enum {
 	PHY_INTERFACE_MODE_50GBASER,
 	PHY_INTERFACE_MODE_LAUI,
 	PHY_INTERFACE_MODE_100GBASEP,
+	PHY_INTERFACE_MODE_MIILITE,
 	PHY_INTERFACE_MODE_MAX,
 } phy_interface_t;
 
@@ -272,6 +274,8 @@ static inline const char *phy_modes(phy_interface_t interface)
 		return "laui";
 	case PHY_INTERFACE_MODE_100GBASEP:
 		return "100gbase-p";
+	case PHY_INTERFACE_MODE_MIILITE:
+		return "mii-lite";
 	default:
 		return "unknown";
 	}
-- 
2.39.5



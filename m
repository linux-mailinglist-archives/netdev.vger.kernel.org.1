Return-Path: <netdev+bounces-201528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A8CFAAE9C54
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:17:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A99C1898780
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41236276026;
	Thu, 26 Jun 2025 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="TCaHMcip"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012019.outbound.protection.outlook.com [52.101.66.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAD8275AEA;
	Thu, 26 Jun 2025 11:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750936591; cv=fail; b=gNr13eG3Nx4+ItNHqtSqEmheh6heumfLWREo3mhGyr1z2HQwoU54iKJnDQk+xzDCUrICPTdKERMptObnAqjMZ+C2L92x578w8hMCtAfFE5IdWC40juIS2ejelgKZqWVtijSnYCryh7DY7You4fbyvyksNjUm1Ymj+AaTqZ487O0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750936591; c=relaxed/simple;
	bh=9Ab8Hr0P589+2/k+k1ckGcu1dTQZIIKcw6nBRwa9T2g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P5e3Z70fF5sXKURuZKbEZRzUCHOvwUulqC85glf/DvIorcPCpnHXWlOtijfA/QZM+m/ZH3enfj0prMzxXk888iNl/UNrwsc76dIBcQLhADzLsYzYRhP762WXLIRoVXvg4tyN8ZM2GOfGeuf9FtjIGEc7SLCuihy3fCm78MV0XZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=TCaHMcip; arc=fail smtp.client-ip=52.101.66.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kbwEOVfQtkRIITl8GXfKSgIP3dOWPB6Jejkjsjthw0C9FFiSK2xe1C5ACVTwKepGhW6ysXeyli+0nY/5eTxPm0WT3gvjTASBg8O1l1oNTl/tUE0ypClkgqejxrZrGrILesYd90J6Zys9XtgalH9sVDWEt72oftJkH/SfLxMYRxitfMj6GUZyxPLScZHIwZDhtKhNxLQrmpzpCpifvCprzI2oPznQ1mu1NY/IMsHtN1dKGlO+IdU5oZz1Ox7bmiQFyT17nAdgXhmrPoO1aGzMsi1eiGdMMuQpZinwPlJ16pDXSc8s5KzF8JvKgVlX5hSKP6JPTbfVncqwjSV2y12nxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ETMjB9OUmu9q1sD8dOCeAnDunxpzp63VkYoHexQEaHI=;
 b=hvlWdV4XFCFljOLR7AFPol6iRCwlJ2pLrOLlPDDY7ZkuPRnA4/szdl4UU6YlRe4265le0zDE5h+2PVx5YvkzlFE4S1B6mxIcwupWbGclHSRcgtohwjAZcsl8lFQsjkKqxAOYJBp/wfhQOFnLocnhcBjeFqEyq8baYEZBApbpD9KXlS08sXJcPLoKMbEjSRtTXHsVPoqkkK/Lz4MIzFJrUrbpHmWDWEE0zasrxPcX2CrxQYyoHmAbuKIy8IY4X1y+Zsb7frXCmu8xhxggCzBmwTxenUjaWV++WmqyYk4AhJgScDvxYCm3wF1to8sAahtx2Ca5qohJU3krmR1WggwLKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ETMjB9OUmu9q1sD8dOCeAnDunxpzp63VkYoHexQEaHI=;
 b=TCaHMcipEkLjpPvawvz4/Tl7Hk7w1w3z0Zqd4KiCwUK6lNZyGhGViISGr7oK6PY5A9m+DUMNyEsX1FNMEcggpD5hkhQPOAom8TkzRcPa2QKfbykw6wSKOpSB6fxW78Yce8UR3QVQTd/z0ILkNlcTXnDVRmkaRqHjb3RFfQeqMK0=
Received: from AM8P189CA0030.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::35)
 by VI1PR02MB5757.eurprd02.prod.outlook.com (2603:10a6:803:134::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.22; Thu, 26 Jun
 2025 11:16:21 +0000
Received: from AM4PEPF00027A67.eurprd04.prod.outlook.com
 (2603:10a6:20b:218:cafe::64) by AM8P189CA0030.outlook.office365.com
 (2603:10a6:20b:218::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.25 via Frontend Transport; Thu,
 26 Jun 2025 11:16:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A67.mail.protection.outlook.com (10.167.16.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 11:16:21 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 26 Jun
 2025 13:16:19 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net-next v3 1/3] net: phy: MII-Lite PHY interface mode
Date: Thu, 26 Jun 2025 13:16:01 +0200
Message-ID: <20250626111603.3620376-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250626111603.3620376-1-kamilh@axis.com>
References: <20250626111603.3620376-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A67:EE_|VI1PR02MB5757:EE_
X-MS-Office365-Filtering-Correlation-Id: 95c91744-eab9-424c-f81d-08ddb4a2e117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Tk85TlpVc2tWOStHSnd6SHJiSkt1M0ZGTHErK3BaTFE2SWo1Y3l3ZWdOT3k5?=
 =?utf-8?B?N1BXTkQyV2lvSDhnTmUvQzhWaXdYcDlRdEh6blBlZjNyaXVWVzFONW5GUm1C?=
 =?utf-8?B?a1dKY0JzUHF4VGRzU0dSaG9YaWVRSmo1SkN3Z2hjV3lnMlBGTzhHZFgxOStW?=
 =?utf-8?B?Q1hJOTVQdnQvd1VOcUlTMUlkWENNM1dEKzZvcFpKYVAyejZIMjRzczd5TDFI?=
 =?utf-8?B?SXFNVWZsKyt1d2FNSUNDY0RwMG5DaDM0TFB5T09IRVBwQytuYnQrd0NBQklt?=
 =?utf-8?B?L2xiZi9CM21DQTZvdHFLMTFhb3MzYmN6U3VDV2lnUG5Bd1J3alVPVzFIemlF?=
 =?utf-8?B?Z1J1M21JQU1HT1dkRngwckRHYkF2YXZqM2ZxKzFCZVVabVlXWm5RTDJkZ3pl?=
 =?utf-8?B?SWxiY3ZOTjE1bUpzS0NrUkw4VTdzb0ZsNjhlcHFFRmc1TzQrQkJNejR0WmM0?=
 =?utf-8?B?OGUyeXoycFpuVFdrM1k2amw0a3kxQ21RUnNscGNsZ01SVlFmUUNScDNIbVdG?=
 =?utf-8?B?UTlUUkF0c0hzWjNFeURhK2NLckJLdEUyQk1OTStQby9qM2FOeWYweVkyRTAv?=
 =?utf-8?B?TFlqMEFBb1BZdzV3NUtsdXV5Y2NuMVhmNDNqUmlPQm9CNEpyWVBVOCtwNVlH?=
 =?utf-8?B?ci9IUklJNkxiajdiV1NRVnlBbnJsOG5yYkJOMjZvYjVuQW1ScC8wc1czMXkz?=
 =?utf-8?B?Z1kwbUNpZDRRRnkyWCt4SHJjTm0wTFBjN1FzeGc5L2dudzlBU1p5R05Ma21V?=
 =?utf-8?B?WVdrVmJXa3hBYmJEVy9DbjZ1WXZuZGFKaHdqM0ZkMk1GZ0ZDL3RxWTdyeWFz?=
 =?utf-8?B?TElDdEF2eGhTT3EzS1ovakJudW5UT2tVMVhTWTE4ZmV6NDNoMDFMV2d2MVEw?=
 =?utf-8?B?c0p1MTEzb3V6cTRjQ3FwRmk1L2xjQ0hERVlYWDRlbTNqTlVSUXhoSEhjQUx4?=
 =?utf-8?B?ZWNPMWpzanhYQ01vZlBQVW9yLzZPYXd5c3o4d2xYZTNFTE15TDlwZW9UNG9s?=
 =?utf-8?B?WW82SG83RnRDdXJlcnQ3ai8wYlRjekExdk85UXBWai95WTQxTkF2UURERGxV?=
 =?utf-8?B?ME12RmR3NHpQRlEyR2xsQjU1c3ZtSkdaM3dJYkRkSDRIaG1vV2VhaTdSS1Y1?=
 =?utf-8?B?dHN2bGJwd1dUZGdUdkZjU3ZyNnk0dncycnJtQUxoYVdWZjlFN0xnRUp6RUQ1?=
 =?utf-8?B?ZVdoak5VVlFwRGJTb3NQQ2Vsc3IrWUc3QWg2YTR2Q0tMYzFuQjVOSTdoSHdL?=
 =?utf-8?B?QS9Kd1Uxc0ZraFp2d1pRU1doYXlFNG5oZzlWNkFNRU9UREtQL2M4T1ZQTlRC?=
 =?utf-8?B?MExXRzdpSzFCZGp3amlyYUdtS0oyR1ExemxNNHVWTWsybk5aN0x4MGFiTnJt?=
 =?utf-8?B?aENQSGhNYTdoQnB4SkpMTHdwTnNFN3g0KzRzWExBaSsvNmtqb2IySGV5SS9Q?=
 =?utf-8?B?ZUJMSlpxNlQrZDhyYVhLWGZNbTkxN3RCRmFFN3VhY2g4QmdPcXlzQ0VKbXpJ?=
 =?utf-8?B?WFhwT014Y2UyKzdlSDk2TEhaNVhZVGhYdXpOeGlqSWNaT3c0dzdIaWszRDhE?=
 =?utf-8?B?bW9rWVdrYUNzeWt0RjN6N3ZvVmVyT3lMS0pqeGFqaWFMUkxOTFJmbzNiVll1?=
 =?utf-8?B?SzBqbEZJUEdLN1pSQTM0M3F5c1h2K1k1a013djFLNjZRYTFEMksvcWFWaGF0?=
 =?utf-8?B?bkM4UWpsYy9RTE1oZGNKRnVsOEp4L3UremNWWlRBZGRBTm1sZGMvbUhRaTZV?=
 =?utf-8?B?NHVPM3RwN3NBcGtiMVhQSFhVakl0Nzh0KytnUTAzb1BSa2I0WFk3OExDTnl1?=
 =?utf-8?B?RmtIaXhzbFNqVHhpWVNpT0laTklHY3ovUEhOQVEzUU1NRU9Zcmg5U3JOYlFx?=
 =?utf-8?B?RkhEcTFyeUNKVDkxK0M3M1lyVEp2TDdBZ0ZyLzlZaWg0a256S1NETnZLeWdm?=
 =?utf-8?B?TXNjNzl3cXRUbTJSeGFsb3JmVzZrYUJ4KzBCcktnMnkyT0dsMXJYRnVxcW9M?=
 =?utf-8?B?R2ZHc3ZzQkZsZk53MnNabUFHcVAzY1dsR3hSaVgzc0lpRzhudmR6akNjMGh3?=
 =?utf-8?B?b0lKRExZYUl4cXN2cGVOdjFHOVhNVVQrV0xIdz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:16:21.0149
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 95c91744-eab9-424c-f81d-08ddb4a2e117
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A67.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB5757

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



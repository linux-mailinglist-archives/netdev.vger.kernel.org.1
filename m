Return-Path: <netdev+bounces-199787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CBCD8AE1C86
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 15:46:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 57CC4171D0F
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 13:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84975294A10;
	Fri, 20 Jun 2025 13:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="HfFX9FTH"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013026.outbound.protection.outlook.com [40.107.162.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67709290D94;
	Fri, 20 Jun 2025 13:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750427185; cv=fail; b=GHpocyhfqn4zjaCvmK0me7E7AYR0hf6S/Aa+1zU7u2jIvEfuBIijmNGFsXWcj0W4cMAJ/6/Yfz3PZy7J9h4TaC5c3RgnzO+tX/lg8X0OKICc+22+RugE94JnHL8Vb89ca5IGmFVWpZG5NJ4dTiO9vfOQsQCWZpMi0iz2GbrSrK0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750427185; c=relaxed/simple;
	bh=EL9i1a8V+v6nhoEBy+HISL4fzehb31OYbHYcoKkWQlU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HrcExOZXcOdqgflH2FGZeDAgojnQOxhf6qEyV/ym1P/56XqJ4GKf1UM5oJDCmsQQxYtpveYgNmWxj5N3T9fnXR4Z8sOuv2lt/O3gyNlhCmxf1cz9AWozae5fqqIcUDLCvChEA5PoT3GYpA3IaQBL5KMo87Hyk6a8Ag+EAYyTcdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=HfFX9FTH; arc=fail smtp.client-ip=40.107.162.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Lnm/Uun/z6UVOlNL26PiwDIkTC9GtNnUc0FNsr6a83gSFm6D632br07jph8VYbtHjpgsCCp54jrcyBWLj4S6npiGzkIwhMA8PYALc5xjgb+I2yg1+HomoSaj7r2vezYy7vo25Sec6IRXfvB/JZ07UTaL2LqVSeQS9QX2u1kRdw8VBE53COzucbrD3Y0cOoVIVn4jAi60/LVatb6RYJx3B4ksrxkisN6Dii1tC0+2+KxuhATXsQky2w86i8BeKCVkk2k4exspjIeDPKTdZF3H6eNFCx1aPqHfXt2PSFJopi3QooKmH1rLbtmNLjCEFZ4Gm7q0Gg4BBqW4/0fK8yEsaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tIJ2tzKIp8TtCd9Y2Eg3uLz8m+fqsO+Ox0+oQTWG6jI=;
 b=GALMrdqUqprVIfnT0K5Bi73HAtkzUosv+wrD+jj1ejy8tR7XvkS4zNbBXss3V1Jv5AocW6isM50yAnH4KFvHgAXcOJ04umJrsfdKrUyHt0qtvRWDPzwI6poWPMblRFDi/Q/uSUm0UFMGBBdrAGzVOxcmEx79ma2Ay/cn32zQNCnuGEat5nfKA+Deiyl3NDyM9hQ7+CQGW8ebeRYROClZm4SxeS7bZefqwdOxiGCiwdl7Ab97XsiKuL5Wtt+9Qx76X1w18rzaYTt/zZForEEBeknl+n5urhoPbFaDifD1x+oHtJ44upuutnYtYO27dH/egAhWuoTAARX0gfF1GgBZ+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tIJ2tzKIp8TtCd9Y2Eg3uLz8m+fqsO+Ox0+oQTWG6jI=;
 b=HfFX9FTHp5nB88zDOg/Ks4VLWlKYrR5x8Q+N48x3owIvNKREfRvgU7yabHRMGe5LY7jIzhtbgfVL+WEIm1nx1wUeH0gNdm1RnENR8XZ/ikvTE4jePiuwVrbyQSiWmepxE4+yV2FnXrRkQyYg7kWeJwanmJufQHXG+K2pxeacW0U=
Received: from AM4PR05CA0036.eurprd05.prod.outlook.com (2603:10a6:205::49) by
 VI1PR02MB6174.eurprd02.prod.outlook.com (2603:10a6:800:185::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 13:46:19 +0000
Received: from AM3PEPF0000A78D.eurprd04.prod.outlook.com
 (2603:10a6:205:0:cafe::70) by AM4PR05CA0036.outlook.office365.com
 (2603:10a6:205::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.25 via Frontend Transport; Fri,
 20 Jun 2025 13:46:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF0000A78D.mail.protection.outlook.com (10.167.16.116) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8857.21 via Frontend Transport; Fri, 20 Jun 2025 13:46:19 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 20 Jun
 2025 15:46:18 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>
Subject: [PATCH 1/3] net: phy: bcm54811: Fix the PHY initialization
Date: Fri, 20 Jun 2025 15:44:29 +0200
Message-ID: <20250620134430.1849344-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250620134430.1849344-1-kamilh@axis.com>
References: <20250620134430.1849344-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A78D:EE_|VI1PR02MB6174:EE_
X-MS-Office365-Filtering-Correlation-Id: 1748478a-681c-4f00-77b4-08ddb000d5e8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700013|82310400026|7416014|1800799024|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VGd2dkV2MlRvczE2K3Z1R05pU3R2dkxtNkVldVZjU1JYMFZ5OWxLZ1ZFbWVI?=
 =?utf-8?B?NUNIRTBvRXJLc05zV25JWUpsVDljUkZuSVJ5bXB2Yk1ZZXlJSjNzdTZIa0ZZ?=
 =?utf-8?B?aXoxMEl4Y2NpK1dQdDIwYlRNV292RmdWMkhmVTV5UmNNd0ZPaWdqemNEd1Jh?=
 =?utf-8?B?QXJzVnR5VjFOeFRkc0F0Yngrc2VUd3dSblNueUlDSzI2YUVSeTE4aUdOekxa?=
 =?utf-8?B?T2NvMWNZOHAwREt6T1dycnVydDBEd0xCRVUrNnk0ZmhDNElUdGFHL1duUXlY?=
 =?utf-8?B?eWxTbXMyRmtrZzZIR3RudmpWZmZwZFFQanZadjNkbHFBZ1Fqa3Ria2xmdHJW?=
 =?utf-8?B?V0FCZDd0bGlvSzRFbFF6SzVHanYvWHZwVHRiQzBXNnNQNXZHREpackJFWkFi?=
 =?utf-8?B?VzZjc0lXT1NxbE55THVsWVlFTFlIWHp1dGJWVmhQSkUrMjErai9wWjk3TVln?=
 =?utf-8?B?Z3hRY1VRb1dlMWpUcWM1U0M5Vll5WjVqWUl5NlBFcHhCM2ZNQ3NaVWRIMU9I?=
 =?utf-8?B?ZUYrUjd5WEpVUGEzaXYwclVjaXpDR29rZkhTa1FHYzMyd20xYmxZbnZkcGRE?=
 =?utf-8?B?SWdmUzN6bXUyQUZidVpUUWI3NG5ZSTJWbWNWOTNXUUxRZ1VHakxPSFBuWmpP?=
 =?utf-8?B?MG1SMVJRWW5aWTcxL1ZoL3JTRTFIVjIvMXQzMmNaT0c5V2NyQTEzMDk1RnZz?=
 =?utf-8?B?RU9iQ3JJczgvZ0tka2QyMXJnNWtmV3BWajJPcU5XNEFadlhwczNlSGxXcDgy?=
 =?utf-8?B?V0hKaDJYcVJDWmtKNVpHd0YzMnhvN2tKa1Z3RUsrREFtVkdhUXN5WllIeHpO?=
 =?utf-8?B?ODlFbHJVNE9oS0ltOC9INU91eksvNEgyM2loZUQ4OWxyT2VZSkI2UEJNRWlZ?=
 =?utf-8?B?SXgrS2Y0cXZiaCtXaGpQOVhjYnQvTHMwZ2czT21HQ1dhWlV5cWZvWWMvWTVw?=
 =?utf-8?B?ZEl2WlBPb1A4VSsvTlR6N0tVaVp3OUU3QUF2YjZaY0lCMFZ3TFpySlluQWxn?=
 =?utf-8?B?eU9LK3NFcVpDeUJiS0lDaWdxeUxDWlRzRVRYWFJ6YWJoSEdYTnlaSFJKWjZh?=
 =?utf-8?B?ekkxenRlQk1wRnJ1bDhSSlJQbzl1QkFDT1FxZ0Z5R2RUWkZ3WENKcENad2da?=
 =?utf-8?B?bGY4eEszOElUTjg2Z0FJbHhUSlpMT1VMWERZamtkUXhseFdabVQyNjFkWEZB?=
 =?utf-8?B?QlovdEozRzBnU3hUSE9hV3Z3bUJuOUZWWGZxYlZnNGw0RDdJbGNGZ2lyZ0ND?=
 =?utf-8?B?S1E5WWpaOHRLZTltR0x1S21UeVpJRnN3b3JoSWplRExWM2lDVERtRHNLMmlj?=
 =?utf-8?B?MlFGKzVDUU8xR2E3anpnSVRIVjJ5TXVOV2Ntdk1JUE0vejZFSHA3Y0RnWWE4?=
 =?utf-8?B?VnV6SmFQa3UzY1draklWVVF0RjE2M1dyR0xUV3pmbGpGc25SUWN2WUNxVHhX?=
 =?utf-8?B?WkVRcEJYalcwL0VNbDA1UTdCdW9KK1M1Vk52Y2I1ZjJJN014TG5VTjU2bitC?=
 =?utf-8?B?dklSOHZmU01JV3RsbkFITHpwcjdrM2RRcUY1aC8yODJ4STUxYzZDSkxRazdv?=
 =?utf-8?B?NHU2V2xHY3F6TkU1Mkg3aldCQ1VKaFFnSXBBdml0L3BuYUttb1FiU0taTi91?=
 =?utf-8?B?R1RuQnl6WkM3ZXJtTUo1bi9iZXdPSVRXUHJPclhPV3Z5aVpZZ21WcHlXVy9O?=
 =?utf-8?B?aS9MYktiS0FBRkIyZ210MmlGMUR1L2owejhRVWFrU2U1RFZnTTlTUDBjR1o1?=
 =?utf-8?B?QXlMZFRmK2IzZDluOWc2YytkajBhNk5FMUFqbDhqLzJCT0lqVlZtekVHMk1L?=
 =?utf-8?B?VktsTCtNcGhFcjZNSWdHRFNtOW1qWFpENkdVVXA1ZjJzUnppNFpKeW5QYitB?=
 =?utf-8?B?SmNIazNEcFlNQXN5dUhWdWovRWovTFpEUUtUa3FaM1Zob0JZQ0tQRE9ldXdp?=
 =?utf-8?B?Z3JBaTk5SGZacFFGMVNDVzY5UEEwanNyVC9JRnpvai9NWVQ4d1R1blo5Q0hH?=
 =?utf-8?B?UDAzc1JxM0JCK1dGRVNVaFFzc3hrclVtTUJUNmt2RFlXY05leVdCVllVSldI?=
 =?utf-8?B?NXZ0bzlzU3NLUFRmdHJNNEh0Z1ZBaUpFQU5JQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700013)(82310400026)(7416014)(1800799024)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jun 2025 13:46:19.1298
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1748478a-681c-4f00-77b4-08ddb000d5e8
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF0000A78D.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6174

Reset the bit 12 in PHY's LRE Control register upon initialization.
According to the datasheet, this bit must be written to zero after
every device reset.

Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
---
 drivers/net/phy/broadcom.c | 22 ++++++++++++++++++++--
 include/linux/brcmphy.h    |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 9b1de54fd483..75dbb88bec5a 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -420,11 +420,29 @@ static int bcm54811_config_init(struct phy_device *phydev)
 			return err;
 	}
 
+	err = bcm5481x_set_brrmode(phydev, priv->brr_mode);
+	if (err < 0)
+		return err;
+
 	/* With BCM54811, BroadR-Reach implies no autoneg */
-	if (priv->brr_mode)
+	if (priv->brr_mode) {
 		phydev->autoneg = 0;
+		/* Disable Long Distance Signaling, the BRR mode autoneg */
+		err = phy_modify(phydev, MII_BCM54XX_LRECR, LRECR_LDSEN, 0);
+		if (err < 0)
+			return err;
+	}
 
-	return bcm5481x_set_brrmode(phydev, priv->brr_mode);
+	if (!phy_interface_is_rgmii(phydev) ||
+	    phydev->interface == PHY_INTERFACE_MODE_MII) {
+		/* Misc Control: GMII/MII Mode (not RGMII) */
+		err = bcm54xx_auxctl_write(phydev,
+					   MII_BCM54XX_AUXCTL_SHDWSEL_MISC,
+					   MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_SKEW_EN |
+					   MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RSVD
+		);
+	}
+	return err;
 }
 
 static int bcm54xx_config_init(struct phy_device *phydev)
diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 028b3e00378e..350846b010e9 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -137,6 +137,7 @@
 
 #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC			0x07
 #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_WIRESPEED_EN	0x0010
+#define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RSVD		0x0060
 #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_EN	0x0080
 #define MII_BCM54XX_AUXCTL_SHDWSEL_MISC_RGMII_SKEW_EN	0x0100
 #define MII_BCM54XX_AUXCTL_MISC_FORCE_AMDIX		0x0200
-- 
2.39.5



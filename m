Return-Path: <netdev+bounces-204068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA90BAF8C46
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:43:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E339481E67
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C537F2EE99A;
	Fri,  4 Jul 2025 08:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="f3kw4r0X"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010062.outbound.protection.outlook.com [52.101.84.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8351028A706;
	Fri,  4 Jul 2025 08:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618141; cv=fail; b=SUGqqwqG5uzBQXhpKN/Y0GYm4jcdp+TmfZnzZsO2/nlsON5YdHFV/NdcVH1fLgVLmM3Byk6dmzEJcHDTuXEEp6n0QJgUXA0ue6rbGNobi+SkH6uvOXSnYDw9nHzuWt2NGbFNaTKRm272F7gcWmEeFhAQjkYXk78QgYvapBUV6cQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618141; c=relaxed/simple;
	bh=wiavBSsHVxnjxiyFsBISmOdlNkKRY2jBRLJ2F21RWX4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=beMl9KD3KOYB2Q+wc7fu0gSasI3ouXMRUoHJZwassNq/MzHQLSjsdbJlIGWTUkLEFfmHw5Bx5Zij+sE6hUSg/P0uQkoIggOfm06edNStd2wVxE4Iwp/dnx0isBOTF3bg2oTSPDrlWjKCszaNgy3Vq8hYbVJrHauxqqn1ZO9EdhE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=f3kw4r0X; arc=fail smtp.client-ip=52.101.84.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LZRBYM8FC158INhsTyFbxPhqOzkf8Wnnx+WZ6WcOJ4DkUR0WlcmCmKyP1oGrW03qrr8G7QGzKwEuhfNOAgITCnOVLFwx5rqK4prmfXa8rVaayYC2Fn9Bz7OsOI9jfzTVCXymAfJmIHSoz9CpnikI6YDkC7Hw+PocfUWqFnt8bAru4HN20FFaATZqgeGvgM9Y1OSGlaUAv3Z3MBzvOmgY0+Q9toLYwELLHm7symzuoKP4xZPubgRsr2eLHnMgxQqEMvAqBbKR6XidMLYmQwIHNFK8ZWINzhO7gPTneM4Ot5S8uSIJ5SBZYiQsWQJuAaKjxZoEGbRQb81oGsHaRYiUoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jqqJKLVK+iRN2eOJCTeewjp8WvXT6DArcDg7nGgvr2U=;
 b=Ky840OThVdRTXW5xXT+8e0iKUn2+gCA+oq8pagmkodmUVK7/xtV77o++jhcTVtHkwvjHYd55pIC2SvcCEvAlrE4Rx2oY0M+q46S60ncyfQJ6SPB30vg1nbp/pEihMmlJKok4dzNNc+oHVD2qDDtQ9ELkKut4zDU5hVssJ6ttZZJ/l4s39wKjGqEVx/S5TYz0AkUVdJOUbHy5CGo+cS2RVQi4KW0mlE0nYjkaOxIFO24kzyKxq4FSrEjhYy4Z7t7IRS5F8zuHIDJ+xy5EOop2blSmsmRAU8l8NIOpj3vfSbxMw9iqR37O5iPwn0OBXsUovtnNa7d4dCpq3Il+zRBowg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jqqJKLVK+iRN2eOJCTeewjp8WvXT6DArcDg7nGgvr2U=;
 b=f3kw4r0XVyGOFSvQzT1aucRFpgDVijCEGK+yxVGhnnOjRyzhfSLVHY/zGRAoaJO6ic4TiruyS9GvxrIRrXlOmL7LFLJKPqQ1/7xh9RtNyki/9KmRfb6rmVM3WOtcCj0T4ddvO55PSD/14ATj6JE2pNbw4NDS9acViciuRcItiRc=
Received: from DU2PR04CA0248.eurprd04.prod.outlook.com (2603:10a6:10:28e::13)
 by AM7PR02MB6321.eurprd02.prod.outlook.com (2603:10a6:20b:1b8::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Fri, 4 Jul
 2025 08:35:35 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com (2603:10a6:10:28e::4)
 by DU2PR04CA0248.outlook.office365.com (2603:10a6:10:28e::13) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23
 via Frontend Transport; Fri, 4 Jul 2025 08:35:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 08:35:34 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 4 Jul
 2025 10:35:33 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>
Subject: [PATCH net v6 3/4] net: phy: bcm5481x: MII-Lite activation
Date: Fri, 4 Jul 2025 10:35:11 +0200
Message-ID: <20250704083512.853748-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704083512.853748-1-kamilh@axis.com>
References: <20250704083512.853748-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D03:EE_|AM7PR02MB6321:EE_
X-MS-Office365-Filtering-Correlation-Id: 174ccb1d-2818-4072-4dfc-08ddbad5beed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|1800799024|36860700013|82310400026|376014|7416014|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?THZyMDFQUFNaVkM0MU8vazJGR2w4MGRtRGZYQXVnakZkanZSNGxCZzJkalF6?=
 =?utf-8?B?NW5oYkNOVDRGbUFybFZ6aWVMUC9vVW1Vdm8xM1laTHBaTk5tcHEvakg2bXhy?=
 =?utf-8?B?QXJJb2JKVTc5NHE2TDBaYi9hbmlucXRqSm8vaTIwOVFDaHlWU2ZPWjNlNUFs?=
 =?utf-8?B?VzNLSUVNeGJNUVhld2pvK2l4V3NBcXFWSnRzaER4bVJLWWkvN0xqMWtNd2lN?=
 =?utf-8?B?RWF3VUpQdWhsNU16SG1aeG9rR05nZThVVlVleGdGOUQyRExvK1plWHFaM000?=
 =?utf-8?B?Ui9CSk5qOHhUa04zcjR0TlJrc2NTeTNGenZPUjIrbS9COTNjeWNRNnlpaTJ0?=
 =?utf-8?B?d3JwekRIU0UvVkYrcmxneXhXcml4dU9Zd3A0WGRJc05zeVFXNDZ5eEhKVmVq?=
 =?utf-8?B?MWJobythOW5kRitTMHo3aXorTmdLSWhhSE83cTMxM3RMK05MeEhrUHJYL0da?=
 =?utf-8?B?U2MyQUt3WkYwcXdFREIvOFgrYmdPbUwyNTh0MmNKd09UbFpyY0xObndQTjlw?=
 =?utf-8?B?WDN4dEQrcUxJVURyNmxoeC84aWpmS042ZWxtVkxXYUNTT3Y1SHAwTjBkcGNv?=
 =?utf-8?B?RGdnUnM3M0N0bFg1WTdDSkZqM1Ezc3RqQm56MnBGLyswN1pSempKTzRKbUg2?=
 =?utf-8?B?cE13cW9sUS9sWnRCbDdWby9reVJGZ3lUTWlKQ0FMNzJmR1dxOFhLVXB5Y1g3?=
 =?utf-8?B?aU9qdVlDV1BCa29mUWZXdXVIVGVJVWZKTGNFMklWWjNqc3BJcnRuKzhLMjF4?=
 =?utf-8?B?SE83alYwSDFhOWtZK09hZHJXZkNDKzMwL0NTb0FXYnlTTTYxL3ZlUEEyVUQr?=
 =?utf-8?B?MHJHZkovMVVkSXFaZUVJWUxucTJ6Mmp0Vm1nZGZMSnUyc0lSdUZneDNOR0JZ?=
 =?utf-8?B?L0lNUStjL0lETW5YOG0zRGN5amZoVXdlNXYwY1hwYkZlakdxeTVrRlRoK1Jk?=
 =?utf-8?B?NGNKMUNLNHh0Z1h1Sk9XU2x1ZnNzS3BBM1RxVkI2YnBJNEpZRURqYUpCK3A1?=
 =?utf-8?B?dnV1aVNRTHJIZ2JHSzV5UDFxbjdkSjVGVldJMjBWRjc0c1NtOVZ1a1NMM3Zy?=
 =?utf-8?B?NDRnOElyOTFYeTg5a012THFUS3VmM2JnYklBVkl5QkVBcHpwSkJSOWp4QWtM?=
 =?utf-8?B?Qjh2VDZvb2liMUl2aER1eGh1TzAwd2MzVUo1YklCVi83bzlhdUxHY0hTOE1a?=
 =?utf-8?B?Vm9MeFBoSWlCTVZUbHVHQjIxQnhpNDFXcjBrYWdhN3BVU093enBoN05XR1Bm?=
 =?utf-8?B?NnFoalYrVG1GK3dJaFRwNmtKeHJwakRmeHRuTTl3cCszYmhwVGxtZTNCeHZ6?=
 =?utf-8?B?NithU3BvNVB4bnJXTmFoVWNsM2FJQVlNdWdVOFRJaDNaeVlWdHhkVnpNaVRC?=
 =?utf-8?B?ak9kSmVCSW5teXhDL1VnR0VBWDllR0RITTU3eFlKeEoxQmhKLzVpMXA0OXNI?=
 =?utf-8?B?L0tDc0NUclptdTdySVZjVnQ2aFRXK29HOGFUMllrY1hUMjJ1eDZVSWdRbzN3?=
 =?utf-8?B?WTZSU2NjTEs4RkNybFZVRjdoOW9wYjRHSGZBQ3hmSnVGcndhbUp6ZjMrRmdy?=
 =?utf-8?B?czJZQXBUZTZpTWYwczNMVlJmamV4ODFRR1VhRGhHMXQvR1IyNHRJZlkrbG8v?=
 =?utf-8?B?VTFTUFhJN0RPVnBIM0EzL0ppZlJGaDZER0tYOHJMbTlZaFMrL3JmVUpNT01H?=
 =?utf-8?B?d2lPZHdBTXRYN2VCa01yOWZ1K2lBT05iOFc1TUlneFh3K0h2L09nbTlmMDVn?=
 =?utf-8?B?U0NpeXBRS0xwR0YzbXNMODdyQzhHTUlVaVFaSDNXRFBCZm1zUk4yQm1JWis3?=
 =?utf-8?B?ZVFTbzlWMjc3dW1ENVpiVWNFTkt0cTYxeEs0QmtDeTJ4YjhPcmh1bVVJeUtZ?=
 =?utf-8?B?eGdMckZUdnhZREhHWUZZSjhyeFJXZElIalRJV3hDUXFxNkR1a0NybURCOWtZ?=
 =?utf-8?B?T1FYK2tzWm1GVzh1bFlFSHo5SlFPMWNoRWlvZmJMNjVzdm5JdUF6SFA1WGpj?=
 =?utf-8?B?azhCQzRManBHZ2VsOUpvd204Rlg2VzRjNTB4ekVZT1lzZFIwOURTMHVkU1Rr?=
 =?utf-8?B?Vjk1Tk5rZFp4VzZzUHRmdzA5UWlnWnNXNU15UT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(1800799024)(36860700013)(82310400026)(376014)(7416014)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:35:34.9962
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 174ccb1d-2818-4072-4dfc-08ddbad5beed
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6321

Broadcom PHYs featuring the BroadR-Reach two-wire link mode are usually
capable to operate in simplified MII mode, without TXER, RXER, CRS and
COL signals as defined for the MII. The absence of COL signal makes
half-duplex link modes impossible, however, the BroadR-Reach modes are
all full-duplex only.
Depending on the IC encapsulation, there exist MII-Lite-only PHYs such
as bcm54811 in MLP. The PHY itself is hardware-strapped to select among
multiple RGMII and MII-Lite modes, but the MII-Lite mode must be also
activated by software.

Add MII-Lite activation for bcm5481x PHYs.

Fixes: 03ab6c244bb0 ("net: phy: bcm-phy-lib: Implement BroadR-Reach link modes")
Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/phy/broadcom.c | 14 +++++++++++++-
 include/linux/brcmphy.h    |  6 ++++++
 2 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 9b1de54fd483..8547983bd72f 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -407,7 +407,7 @@ static int bcm5481x_set_brrmode(struct phy_device *phydev, bool on)
 static int bcm54811_config_init(struct phy_device *phydev)
 {
 	struct bcm54xx_phy_priv *priv = phydev->priv;
-	int err, reg;
+	int err, reg, exp_sync_ethernet;
 
 	/* Enable CLK125 MUX on LED4 if ref clock is enabled. */
 	if (!(phydev->dev_flags & PHY_BRCM_RX_REFCLK_UNUSED)) {
@@ -424,6 +424,18 @@ static int bcm54811_config_init(struct phy_device *phydev)
 	if (priv->brr_mode)
 		phydev->autoneg = 0;
 
+	/* Enable MII Lite (No TXER, RXER, CRS, COL) if configured */
+	if (phydev->interface == PHY_INTERFACE_MODE_MIILITE)
+		exp_sync_ethernet = BCM_EXP_SYNC_ETHERNET_MII_LITE;
+	else
+		exp_sync_ethernet = 0;
+
+	err = bcm_phy_modify_exp(phydev, BCM_EXP_SYNC_ETHERNET,
+				 BCM_EXP_SYNC_ETHERNET_MII_LITE,
+				 exp_sync_ethernet);
+	if (err < 0)
+		return err;
+
 	return bcm5481x_set_brrmode(phydev, priv->brr_mode);
 }
 
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
-- 
2.39.5



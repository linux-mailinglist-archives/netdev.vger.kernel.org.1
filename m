Return-Path: <netdev+bounces-200316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8087EAE4820
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 17:14:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803423B4CFC
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 15:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A375C26F477;
	Mon, 23 Jun 2025 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="k27tfXSD"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010034.outbound.protection.outlook.com [52.101.84.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E3C4214A7B;
	Mon, 23 Jun 2025 15:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750691499; cv=fail; b=AsBqUDe1yBIGZkK41n4Yq+MuraRdypt41XAqxw/eh8i1WsUsi7IVGtaTc5erdkon1a1VPfmJSygTeIW9NjrYFL58KlBxM0yhm8XvGUwCKzv+4gYF9emN/PC03nsEfMrxSqRW66jxMjp+2jy54He+ow+hZGMLPbwyWC3gLpky2Eo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750691499; c=relaxed/simple;
	bh=cghjO2iR4gilo4hR+oGXmdYvufC0n4Q8jWPAshpfUV8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wchx3qv/r4S7FzsfiA4hOK44xL9zsyt2GGnCgHFHHezmtNKnZ7FDrogHalExVvwsCTddthA8T1acHUOOE8tej5cBB+NNTkKp3NJ6HmUG6ROy9QpbRKk+Qib5/smJxgnoyDolnUyAOBxxPm5y6ZiRLH8OWUyt/oQKL65QdAsSr04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=k27tfXSD; arc=fail smtp.client-ip=52.101.84.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=masSmqi993AAnHnswrFfaMt6In3NrD5bivMjyUG9Q/eHFIFl6VuBL3+9OlP0c/vKRQCW5+yzTZuLjrB+d2E0gMywplsgQ3Xquco7hvrFaFNxcH0zDIkBkFh1GTopegxvUfDRP5unDRpYbl/tPBvgVC3vD7zzSGhR5VCP74b8W26sL97AayidYI2dxfI424ctxWJhAF+IdW8v3gbicKtLR+INhMvPDPdfup598HVVWqX/7MKOVR7Xrocishgb4z9RZtHh8E5iLNN8DyLt/mtfeeqxVtTgSYDiL4CU1nnyVYaOZMHl3RZGBR/m0jH1F73Uf++s/9RjTCHyB//xel4mBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6xJMgfQyzpkqgnof9CD2NLlBdLyTjgHOC1g4EyMMu9c=;
 b=NMlJa6zq/rqSDw5/5mKJ+deB6Nq/eeyPlReJSbN7/6ffbQ+xWOI4R0owMJVEYk3uBfs0bPc+DmFUeeUdHUzVofjiSr5pDGW2eaS8cNIV1ZfpbDeACWbM3kTiSjchvrrpiJcwcT11F4a2BCR/3G7TwOf/8ntnX8PjgyNX0eM7UhKkSGtiUITTVUO7DowozwN4NaQGPHCPP5Ga3XMlT3nR/AU58OebDUaRrv7FpvMNFc89v1jyrp/XzyV9dWOaPTwMRvGFJA5kqYCRswIs3P57T5vV4mYr83WC38ZZlVF5sZczBL3Fg2k+1dNrRzJ53aTlYA4A2jjO4UPwBXSQc6PP1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6xJMgfQyzpkqgnof9CD2NLlBdLyTjgHOC1g4EyMMu9c=;
 b=k27tfXSDuf4vScs7ntsq9yJJaSqxx9P6byzGwSPrhFQ04evXrgnvqt0v37Q3j7fkBQH4YP/X5sJ+9XSBUesz+skbk4XU6blgXNuPpVw15p6/A0ENucWMYDyyUapgz9iMujrAgZL81CBC1ifr+Wyb6k6whlnMC5ef445ksCQaVJw=
Received: from DUZPR01CA0029.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::18) by GV1PR02MB10757.eurprd02.prod.outlook.com
 (2603:10a6:150:163::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 15:11:33 +0000
Received: from DB1PEPF000509E7.eurprd03.prod.outlook.com
 (2603:10a6:10:46b:cafe::db) by DUZPR01CA0029.outlook.office365.com
 (2603:10a6:10:46b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8857.30 via Frontend Transport; Mon,
 23 Jun 2025 15:11:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E7.mail.protection.outlook.com (10.167.242.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Mon, 23 Jun 2025 15:11:33 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 23 Jun
 2025 17:11:32 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>
Subject: [PATCH net-next v2 1/3] net: phy: bcm54811: Fix the PHY initialization
Date: Mon, 23 Jun 2025 17:10:47 +0200
Message-ID: <20250623151048.2391730-3-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250623151048.2391730-1-kamilh@axis.com>
References: <20250623151048.2391730-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E7:EE_|GV1PR02MB10757:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b3c02ab-360a-4aaa-1c2f-08ddb2683d79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|1800799024|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?ZEhtLzNqMGhYSFBMQ2VDWlg3NnpHdFhlQzJndk5zdjJxYkdpYkFLc1QwNXRa?=
 =?utf-8?B?a1UwN3NidXAzem9Yc1J4eDJLZGdTQjBzeDlzUk9MRzQ3R0tTSTAvWmhSUVll?=
 =?utf-8?B?WHdGVFVocFJvSG9MSE5FM2hqT0VGVkhtd0UvdUZwd1I3OFRCTjdmNW9uUlFl?=
 =?utf-8?B?czlGbE1mYU15V2svcEhjZUo1WlVzOWczUTBaSkx5aUtkTmRZZWpLazV1d05s?=
 =?utf-8?B?VWQrWTRpN1VnKy91dDQvcEs4RWpRSEVGNWR5OXNUZUlBLytQQ1UxcEp2OWV5?=
 =?utf-8?B?NitXeUs0KzZBdVBCKzFHS1I3VENMN3c2SldUNkYxRjJJdEJXR1lXRWRYQnBR?=
 =?utf-8?B?UHlFajBhU0FpemN6aWxkUHZoTTZyVmJLT3dEUTQrdFZuTllqdk1ramNRcWFM?=
 =?utf-8?B?ZEM1TVJnKzJSSlUvOG9QanFYWWp1d2RZSWY3RmlydThHYmRoK3QzazV6TE1w?=
 =?utf-8?B?bDF3VGNBQ0Y5MmUvcExVTjF2aWhQSXVQK24wS1Q2L09rcW4zWTRUcWlVdWpM?=
 =?utf-8?B?QnBJQ240emUrWHo3UjBPN0VscWhKallIK0JFeER0eTFITnRGeUxlRW5iM3Bk?=
 =?utf-8?B?dGJBS0NRZGxzRmpkZGFhUG1idlIvZkZORjNHZlFMTldrOHF4LzZKWm9FQ0NN?=
 =?utf-8?B?SkE5eld5Y3ZHTlBWdnNkbmtJcjdjZUtIMlc0SnZpNHloU1U1aW5jeWpzbjNZ?=
 =?utf-8?B?WUZ0YXhZK2RjbGZjWU45UmpoVG1LeGRpWFdoMXVZUnc1MnkrbUJwL0pDUnNF?=
 =?utf-8?B?c3BtTHZPSU1id0VuK3llUHFLNER1QTJVNEpsMDJHZWpCcUhXRXRKTS9vSUxS?=
 =?utf-8?B?dXRENWlZT1p2eFB0ZzUweFZMMk9nTWZxczJVR1BaMVBIb3J4b0ZVdzBEUTJP?=
 =?utf-8?B?VEJEQk1vdmt0bXJ3V3hEMEFIbWFkNmkraUY3VXZXZTdmVGV3K016elJDMEZW?=
 =?utf-8?B?MXJyTjkyNlJvMlZBVjhzU0NsQ1FjSmtxK1NvM2dYR3RVQm4ydmp5L09lSVpr?=
 =?utf-8?B?UWlNVTdidHRZWi9RWk0rZ0dUYUgxa0YyMUVvQXNNRSs0ZEN0bCtWcC8rZWhV?=
 =?utf-8?B?SEphZ0hkdlRwa2RwaDRtWXpIay9GTUJUTytSVU5PQUg0UnBYdGNwSnBXOHdT?=
 =?utf-8?B?RW1zUUVqakEvdld1STRlN0lxdWJuQmoxZVpTMWpObE1YZTgraVZYVzZqUDJW?=
 =?utf-8?B?Rms3RWNyOFFXUEZ5Nzg4cC9IR011eUpYUmNGYXB6SXk4V2hZS0lDV0hGN0dX?=
 =?utf-8?B?dUthUFBXb3NucjV6TjlSM05IWUFSZXkrT2lJbDBvRWR4UTAzZTE1aDZpbmxh?=
 =?utf-8?B?VjV4OHBvOC9HM3k4dEc0TTJoSkN0SUs3cWYySFM0SVd4SDBkSmdmSjYxbFhH?=
 =?utf-8?B?ckN4Mm54TmxNaGxKc2J0QU5hdk5lcmt6cFVWTit6dkVvcUhjbEpzeUhsM21D?=
 =?utf-8?B?bmJHWXhQMlJWQ2hxMnFaMWZHTDZKcGFxUnFmSzUzM1prR093Q0VEL3ZaOVJ5?=
 =?utf-8?B?OWxnWDd3cGtuMmpGUjVhdy9TbXQySGtiL1dpbTBmQUpFeXRSWi9ZUWcxZlVt?=
 =?utf-8?B?eXZpQ3dXa1hTRTVwNk1yMlBTUTlzU3lwRWFFU2dVQ2xpN05xdjdQM2h6RGNR?=
 =?utf-8?B?MEpXaDNvL3I2ZFY3eXBnSlN0WXY4Zk1kUTlCekc0Ulo2UG11KzJZTkNKOHBO?=
 =?utf-8?B?STdQZ0xlQzBQRVRQNUpqcnNXS2hNSnA3a3BoREkrK2tUWHVWWkkvTW5ldE5D?=
 =?utf-8?B?WkZxMjVUTzNrckNwS0s1TDBGaDc1ZjhXbjh4NmZjdzFXVXoxSVlLUEtqUDJn?=
 =?utf-8?B?clJXTmhUQ2dUcXkyN2IxRmdlU1Y1RWJEaC9pT3pMc2JsYjRSanBYbFE3VXNo?=
 =?utf-8?B?UEJjOWpyRkh0SE5ac0Z4ckM0VmRRVGkvSklKUXNlbHd0L3BKUmsrS21sYVpx?=
 =?utf-8?B?RTdEejQwZVRkRDJOcHhYclBlZmpZVXlkU1BGK2R0Qk5RR0wzTHA0QStjVUFX?=
 =?utf-8?B?c0o5ZEJRdTQrRWdLN2JHTm1DVjhTNG54ais5cVMydGFNeVBSOTRzNmhNZytG?=
 =?utf-8?B?cHVZZUFWMnZKcklQbkk0S1JkY29ZTnRsUEJrZz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(1800799024)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2025 15:11:33.3652
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b3c02ab-360a-4aaa-1c2f-08ddb2683d79
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E7.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB10757

From: Kamil Horák (2N) <kamilh@axis.com>

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



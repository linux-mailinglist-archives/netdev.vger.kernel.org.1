Return-Path: <netdev+bounces-111094-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD28492FD32
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 17:08:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9367B28518F
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 15:08:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B410B1741FF;
	Fri, 12 Jul 2024 15:07:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="C3mKWmCg"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012010.outbound.protection.outlook.com [52.101.66.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E905B172BB2;
	Fri, 12 Jul 2024 15:07:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720796874; cv=fail; b=K/sKmYpR2AytfLLbys9IkzL2fKXTZ6ffpqXZc5GgxY1IBZ7DdLK74SVfwJGEGQ3WdUOyh4+rwpTvo/dD7sJWT0fMFr2btU6wjT6+MZ6V6nJlpy3EDZa1JyrIi0Et9dJosaaPxg+EXB/qcgd4yowp2R5xkBckxG/hr/F9CtEyQtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720796874; c=relaxed/simple;
	bh=TRSkrY0bK0/aZ1AaE6zto7Lq5+j5DjMRaKvhXNyLuFw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eZXMyvhXEXozhVvxTYSJprcVimxSQqQElL1nZ+6qp4LPZj4fYC3L8JuhdwUvUN0zU3T3z8PnjcjGogM2sdEqdfho30m2nnd/pk6p/U1YHYCyPDFN+Sa8vntJsicsffQ0hLTTv8YuUbVdD8hlM6Hqy8dJcYLvF+5bSf1oKEf19Vg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=C3mKWmCg; arc=fail smtp.client-ip=52.101.66.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hdahoY22gi/9xBMkuIqV6R5fLmZvECdW9+N6aC6z4vyqb6kSb7PRHnjCya2px3qR+woP6DS+wcv9Hq/nKwR5x6B1pbLVMp+N47xLvipIsL9xmM8mgVSrmZZnWnus/rpJiQZh9f9KpmKLUNs0MJFbR0PHjTrEvdCt7dinRkDvz1F3srXzNcg8UKMeks2gESGQDAPNHrSehPeyAez519uncn4+rTzuxeB819Hlx06r62tH/zi7QAc14jeiWRtNbxAY95Kb6J9LoaP7SHTTy9+SQbjc/LmEE7K7fhb+GAGgCyx/hxxEn2u5qocKlD99XfQY9Pc+jcpUkczozJvz/NQTzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=flzGYOLKBDtwpeJKoma/kiAtran8qGaYqqxiBVHMUvM=;
 b=A1JcNGDqAT184uGIFM6NqoXjc/Gzurq7vBSCcsyW9hs11bGJX4t/e8Am7213XjfI0gGNz+bDr5l2IDELW6fwS7McZHQx2S77oIBT06M01NMgRp4N7Jz3kVHqgf1ZG6eT1eGkIiBf33l1LExWr+AG6l0HuuW+sRna7YzF40AB93snQrGbcE3CiYNOGhTKQIXbQjO0Ff2705vgSKr543VgkqdXfiRVAFty0exKU098mFSdG+NPfFFAGadXtrvUP+FIrzgoScpgxsN1j8dFfy1YETmTxOb4SOrD32oW02iekTeveLCFHXnCwPPQCLFI2u4K/hu2Yp/jKh7mJokKPnsTPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=flzGYOLKBDtwpeJKoma/kiAtran8qGaYqqxiBVHMUvM=;
 b=C3mKWmCgFyjdILQbrCzczorTbkgprzO1QSOScaqLhqdqHHZC2JRPz5d+oLvI5ymJjxbvcQ2ZqC3rYc/hTJCMq/u+S0LIAbhNlBPYFjiOOctc392dved/mPgXdfRwHxX4h5PKn/NlDf8g2RamDnTMQnOJBAb5tVGvbK/x5Sytk7I=
Received: from DU2PR04CA0230.eurprd04.prod.outlook.com (2603:10a6:10:2b1::25)
 by AM7PR02MB6339.eurprd02.prod.outlook.com (2603:10a6:20b:1bc::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23; Fri, 12 Jul
 2024 15:07:48 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:2b1:cafe::a8) by DU2PR04CA0230.outlook.office365.com
 (2603:10a6:10:2b1::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.23 via Frontend
 Transport; Fri, 12 Jul 2024 15:07:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7762.17 via Frontend Transport; Fri, 12 Jul 2024 15:07:48 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 12 Jul
 2024 17:07:47 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <f.fainelli@gmail.com>, <kory.maincent@bootlin.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v12 4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach link modes
Date: Fri, 12 Jul 2024 17:07:09 +0200
Message-ID: <20240712150709.3134474-5-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|AM7PR02MB6339:EE_
X-MS-Office365-Filtering-Correlation-Id: 9be9ef26-dad3-459f-f8d0-08dca2846479
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|376014|36860700013|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UmovaWcxbTBINTBoY2YvZ01SZXdrcDFRamk3R1BVbUg0WmUvNW4wVkx4OW1Y?=
 =?utf-8?B?TStjWlZUckxoeHR5R09jaU1YS1lraUtlSmRpQ0RGb3h6ZkpYTzNxWURGeEZt?=
 =?utf-8?B?dTBUR1gxZzFyZTR6STZnRGJaQ1FWaFdDc1NKUTQyTEVNNmpoVjBmbUFrUVlx?=
 =?utf-8?B?NkRncElzUERKaW5pVGRLczZUQnduM2llTzRMTFhUZDhwRE5McGFEaUxES1NL?=
 =?utf-8?B?QmZpSzY1NkFoY0lNenVtNWJVTks0dklFdnorTXZKeC83NGRMWGoxbGhJWlJI?=
 =?utf-8?B?NzRnYjRNU2pCcFRlL1pvQmpGNFgwVUszV1NtQ1lQMXBqdEZwZW9reWt0aXdK?=
 =?utf-8?B?QWtRWHlnUVE2dkp6S2haUUE2akxEc0l6UE1tM2dkdTBQVTdNNlI4Ymc0S1Vt?=
 =?utf-8?B?RmJ4eVJPSUp0bng5MGFtU0JJdGpqRXVmbERUaENkUHZyUmt0clphVExldXVO?=
 =?utf-8?B?RU9WTHJvVndJYlJLK2ZxenFxeDUySnMyQmVVK214bkViUkw1Uit6WGJjT1Jl?=
 =?utf-8?B?ZHpPd2dqNisvWjdCbUNsQ2d6RGtlTE1xSTBCUlR0UVFyN2M2N0RFR090OVZv?=
 =?utf-8?B?RVpOQTlvWmV1UHRsVkRPY0FheXNwbkdNQnNYWloyc2krclJPOEhVZllRNlpF?=
 =?utf-8?B?THhwSCtMRHJFbWpucUg0eWlIdzIyb2FDL2RFK2hjaDhvK2xmaXFZdERleXln?=
 =?utf-8?B?UDRIY2pwYmxPRzh2bW9kOWR2ZmY2TUdIc3pPWEFFbWNmQmxOMFpjZEdjRkl4?=
 =?utf-8?B?cVlOc1MyY1ArcjFZNHg4bjZ0WE9DTldIZXB2L2QvaVFCNDZERjlGNFZSUnBm?=
 =?utf-8?B?UXBwYmNHWmxyaW5YUXJUQmJDT0VwaEFuZzh2WUp4TXI2OWRKRnRSMTRieXgr?=
 =?utf-8?B?bXZabU1kdk9iNGRaeFRDZEdCQ3lQa3IzOXRsdXVKS2ZXU1cwQ1E3TTc0ajFK?=
 =?utf-8?B?ckxWbTdaY3hGdVd0bXkrQkRlUjgyc1RlQVBDalllZ2ZVRFZKcStabTgvVGFF?=
 =?utf-8?B?QUhEWStOVDQvVUorNHAwb2dmbFhYcjVBUVJPSVpCRTlqRGlnZWEvNnpvREpq?=
 =?utf-8?B?dkZ1RWFyZnN5d0ZOU2pGZXpJUjFNYmlSZjNlT0dydlRwSTZsNTlQVWJyWHhH?=
 =?utf-8?B?SW1wa1M1RStYNkJsazlrd3hmT1ovOWY0SHBmZTNMbE5NR0lTekpjb1JLM3Ri?=
 =?utf-8?B?TVEyL0twUWowYkR5OE9vKzNoRXZlVDM0aFM2ZWZZcXlRRkY4cXR5R0ZCSEtT?=
 =?utf-8?B?N3FzeGdybDJmOWttamVGY2t1SkNEMktNRnNRY2ZKQ1p2R0Y1UEhzMEswZWFu?=
 =?utf-8?B?V1pIZUIzcDlUbFJyVW0zeEE1Z00yQU5vTndWMWZabGNvem5abjJqMDRwRmNo?=
 =?utf-8?B?bnhUbFYrZ3dzd3NxTXVwZWRvY0YyWVNYSk5nSkl3TmFhZGlsWFZLTDVCNHNw?=
 =?utf-8?B?Uk43TFJDZFhSQkN5OXlCTVZGbDFQcHBNWEdaYXBqQ0czUnF5bmxWSW9wWkp0?=
 =?utf-8?B?b3U5czh2bzBjR2tsaUV0dWVJSkttQzF3ZHkrcURtald4SFFRZVhsMEdOZ09t?=
 =?utf-8?B?dUNBLzFCdnV4VFVLQnN5Q0sra0JxcW9CYktMZTZFejJ1aDlxM0FyWW14OFM2?=
 =?utf-8?B?c0VMS21oaDFQeGFaVHRrU3RTZ1FNRjBtLytlbjlsNEdKMXFjaG01K1puckFJ?=
 =?utf-8?B?M1dOVldxNzhwMWRaT2FoYVAzOGliWDQzd2phbUp1amFtKy80aVM3RmRoMlpK?=
 =?utf-8?B?WDVHdUhyYkZ5Yzl3cEZDRHZzLzcvdUVnZkxBVXA0Rk5PaFhlNjBwdW1YNlVE?=
 =?utf-8?B?SExDdlZIQUEzcDZUZ3VuR09pUVVIZko1UHRjYmtPcFVHQncxWXFzNGNSbEpi?=
 =?utf-8?B?UG5XdktDNllRZzZYNzlBU1Rwb3g5elV1UnBZViswYTljN0VGYkpDRU5xaE9w?=
 =?utf-8?B?N1VxYmJhb1E3Z0ZGTmFmcm1iaFJRRGIrbHdUbHd3bnN2OEdOYTRUK0UwTUc1?=
 =?utf-8?B?M2pmcTJYVVBRPT0=?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(376014)(36860700013)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2024 15:07:48.4084
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9be9ef26-dad3-459f-f8d0-08dca2846479
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6339

Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
Create set of functions alternative to IEEE 802.3 to handle
configuration of these modes on compatible Broadcom PHYs.
There is only subset of capabilities supported because of limited
collection of hardware available for the development.
For BroadR-Reach capable PHYs, the LRE (Long Reach Ethernet)
alternative register set is handled. Only bcm54811 PHY is verified,
for bcm54810, there is some support possible but untested. There
is no auto-negotiation of the link parameters (called LDS in the
Broadcom terminology, Long-Distance Signaling) for bcm54811.
It should be possible to enable LDS for bcm54810.

Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
---
 drivers/net/phy/bcm-phy-lib.c | 115 ++++++++++
 drivers/net/phy/bcm-phy-lib.h |   4 +
 drivers/net/phy/broadcom.c    | 403 +++++++++++++++++++++++++++++++---
 3 files changed, 494 insertions(+), 28 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index 876f28fd8256..6c52f7dda514 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -794,6 +794,49 @@ static int _bcm_phy_cable_test_get_status(struct phy_device *phydev,
 	return ret;
 }
 
+static int bcm_setup_lre_forced(struct phy_device *phydev)
+{
+	u16 ctl = 0;
+
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
+
+	if (phydev->speed == SPEED_100)
+		ctl |= LRECR_SPEED100;
+
+	if (phydev->duplex != DUPLEX_FULL)
+		return -EOPNOTSUPP;
+
+	return phy_modify(phydev, MII_BCM54XX_LRECR, LRECR_SPEED100, ctl);
+}
+
+/**
+ * bcm_linkmode_adv_to_lre_adv_t - translate linkmode advertisement to LDS
+ * @advertising: the linkmode advertisement settings
+ * Return: LDS Auto-Negotiation Advertised Ability register value
+ *
+ * A small helper function that translates linkmode advertisement
+ * settings to phy LDS autonegotiation advertisements for the
+ * MII_BCM54XX_LREANAA register of Broadcom PHYs capable of LDS
+ */
+static u32 bcm_linkmode_adv_to_lre_adv_t(unsigned long *advertising)
+{
+	u32 result = 0;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
+			      advertising))
+		result |= LREANAA_10_1PAIR;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+			      advertising))
+		result |= LREANAA_100_1PAIR;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Pause_BIT, advertising))
+		result |= LRELPA_PAUSE;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT, advertising))
+		result |= LRELPA_PAUSE_ASYM;
+
+	return result;
+}
+
 int bcm_phy_cable_test_start(struct phy_device *phydev)
 {
 	return _bcm_phy_cable_test_start(phydev, false);
@@ -1066,6 +1109,78 @@ int bcm_phy_led_brightness_set(struct phy_device *phydev,
 }
 EXPORT_SYMBOL_GPL(bcm_phy_led_brightness_set);
 
+int bcm_setup_lre_master_slave(struct phy_device *phydev)
+{
+	u16 ctl = 0;
+
+	switch (phydev->master_slave_set) {
+	case MASTER_SLAVE_CFG_MASTER_PREFERRED:
+	case MASTER_SLAVE_CFG_MASTER_FORCE:
+		ctl = LRECR_MASTER;
+		break;
+	case MASTER_SLAVE_CFG_SLAVE_PREFERRED:
+	case MASTER_SLAVE_CFG_SLAVE_FORCE:
+		break;
+	case MASTER_SLAVE_CFG_UNKNOWN:
+	case MASTER_SLAVE_CFG_UNSUPPORTED:
+		return 0;
+	default:
+		phydev_warn(phydev, "Unsupported Master/Slave mode\n");
+		return -EOPNOTSUPP;
+	}
+
+	return phy_modify_changed(phydev, MII_BCM54XX_LRECR, LRECR_MASTER, ctl);
+}
+EXPORT_SYMBOL_GPL(bcm_setup_lre_master_slave);
+
+int bcm_config_lre_aneg(struct phy_device *phydev, bool changed)
+{
+	int err;
+
+	if (genphy_config_eee_advert(phydev))
+		changed = true;
+
+	err = bcm_setup_lre_master_slave(phydev);
+	if (err < 0)
+		return err;
+	else if (err)
+		changed = true;
+
+	if (phydev->autoneg != AUTONEG_ENABLE)
+		return bcm_setup_lre_forced(phydev);
+
+	err = bcm_config_lre_advert(phydev);
+	if (err < 0)
+		return err;
+	else if (err)
+		changed = true;
+
+	return genphy_check_and_restart_aneg(phydev, changed);
+}
+EXPORT_SYMBOL_GPL(bcm_config_lre_aneg);
+
+/**
+ * bcm_config_lre_advert - sanitize and advertise Long-Distance Signaling
+ *  auto-negotiation parameters
+ * @phydev: target phy_device struct
+ * Return:  0 if the PHY's advertisement hasn't changed, < 0 on error,
+ *          > 0 if it has changed
+ *
+ * Writes MII_BCM54XX_LREANAA with the appropriate values. The values are to be
+ *   sanitized before, to make sure we only advertise what is supported.
+ *  The sanitization is done already in phy_ethtool_ksettings_set()
+ */
+int bcm_config_lre_advert(struct phy_device *phydev)
+{
+	u32 adv = bcm_linkmode_adv_to_lre_adv_t(phydev->advertising);
+
+	/* Setup BroadR-Reach mode advertisement */
+	return phy_modify_changed(phydev, MII_BCM54XX_LREANAA,
+				 LRE_ADVERTISE_ALL | LREANAA_PAUSE |
+				 LREANAA_PAUSE_ASYM, adv);
+}
+EXPORT_SYMBOL_GPL(bcm_config_lre_advert);
+
 MODULE_DESCRIPTION("Broadcom PHY Library");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Broadcom Corporation");
diff --git a/drivers/net/phy/bcm-phy-lib.h b/drivers/net/phy/bcm-phy-lib.h
index b52189e45a84..bceddbc860eb 100644
--- a/drivers/net/phy/bcm-phy-lib.h
+++ b/drivers/net/phy/bcm-phy-lib.h
@@ -121,4 +121,8 @@ irqreturn_t bcm_phy_wol_isr(int irq, void *dev_id);
 int bcm_phy_led_brightness_set(struct phy_device *phydev,
 			       u8 index, enum led_brightness value);
 
+int bcm_setup_lre_master_slave(struct phy_device *phydev);
+int bcm_config_lre_aneg(struct phy_device *phydev, bool changed);
+int bcm_config_lre_advert(struct phy_device *phydev);
+
 #endif /* _LINUX_BCM_PHY_LIB_H */
diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 370e4ed45098..ddded162c44c 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -5,6 +5,8 @@
  *	Broadcom BCM5411, BCM5421 and BCM5461 Gigabit Ethernet
  *	transceivers.
  *
+ *	Broadcom BCM54810, BCM54811 BroadR-Reach transceivers.
+ *
  *	Copyright (c) 2006  Maciej W. Rozycki
  *
  *	Inspired by code written by Amy Fong.
@@ -36,6 +38,29 @@ struct bcm54xx_phy_priv {
 	struct bcm_ptp_private *ptp;
 	int	wake_irq;
 	bool	wake_irq_enabled;
+	bool	brr_mode;
+};
+
+/* Link modes for BCM58411 PHY */
+static const int bcm54811_linkmodes[] = {
+	ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+	ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+	ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
+	ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+	ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+	ETHTOOL_LINK_MODE_10baseT_Half_BIT
+};
+
+/* Long-Distance Signaling (BroadR-Reach mode aneg) relevant linkmode bits */
+static const int lds_br_bits[] = {
+	ETHTOOL_LINK_MODE_Autoneg_BIT,
+	ETHTOOL_LINK_MODE_Pause_BIT,
+	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+	ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
+	ETHTOOL_LINK_MODE_100baseT1_Full_BIT
 };
 
 static bool bcm54xx_phy_can_wakeup(struct phy_device *phydev)
@@ -347,6 +372,61 @@ static void bcm54xx_ptp_config_init(struct phy_device *phydev)
 		bcm_ptp_config_init(phydev);
 }
 
+static int bcm5481x_set_brrmode(struct phy_device *phydev, bool on)
+{
+	int reg;
+	int err;
+	u16 val;
+
+	reg = bcm_phy_read_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL);
+
+	if (reg < 0)
+		return reg;
+
+	if (on)
+		reg |= BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
+	else
+		reg &= ~BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
+
+	err = bcm_phy_write_exp(phydev,
+				BCM54810_EXP_BROADREACH_LRE_MISC_CTL, reg);
+	if (err)
+		return err;
+
+	/* Ensure LRE or IEEE register set is accessed according to the brr
+	 *  on/off, thus set the override
+	 */
+	val = BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_EN;
+	if (!on)
+		val |= BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_OVERRIDE_VAL;
+
+	return bcm_phy_write_exp(phydev,
+				 BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL, val);
+}
+
+static int bcm54811_config_init(struct phy_device *phydev)
+{
+	struct bcm54xx_phy_priv *priv = phydev->priv;
+	int err, reg;
+
+	/* Enable CLK125 MUX on LED4 if ref clock is enabled. */
+	if (!(phydev->dev_flags & PHY_BRCM_RX_REFCLK_UNUSED)) {
+		reg = bcm_phy_read_exp(phydev, BCM54612E_EXP_SPARE0);
+		if (reg < 0)
+			return reg;
+		err = bcm_phy_write_exp(phydev, BCM54612E_EXP_SPARE0,
+					BCM54612E_LED4_CLK125OUT_EN | reg);
+		if (err < 0)
+			return err;
+	}
+
+	/* With BCM54811, BroadR-Reach implies no autoneg */
+	if (priv->brr_mode)
+		phydev->autoneg = 0;
+
+	return bcm5481x_set_brrmode(phydev, priv->brr_mode);
+}
+
 static int bcm54xx_config_init(struct phy_device *phydev)
 {
 	int reg, err, val;
@@ -399,6 +479,9 @@ static int bcm54xx_config_init(struct phy_device *phydev)
 					BCM54810_EXP_BROADREACH_LRE_MISC_CTL,
 					val);
 		break;
+	case PHY_ID_BCM54811:
+		err = bcm54811_config_init(phydev);
+		break;
 	}
 	if (err)
 		return err;
@@ -553,52 +636,117 @@ static int bcm54810_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 	return -EOPNOTSUPP;
 }
 
-static int bcm54811_config_init(struct phy_device *phydev)
+
+/**
+ * bcm5481x_read_abilities - read PHY abilities from LRESR or Clause 22
+ * (BMSR) registers, based on whether the PHY is in BroadR-Reach or IEEE mode
+ * @phydev: target phy_device struct
+ *
+ * Description: Reads the PHY's abilities and populates phydev->supported
+ * accordingly. The register to read the abilities from is determined by
+ * the brr mode setting of the PHY as read from the device tree.
+ * Note that the LRE and IEEE sets of abilities are disjunct, in other words,
+ * not only the link modes differ, but also the auto-negotiation and
+ * master-slave setup is controlled differently.
+ *
+ * Returns: 0 on success, < 0 on failure
+ */
+static int bcm5481x_read_abilities(struct phy_device *phydev)
 {
-	int err, reg;
+	struct device_node *np = phydev->mdio.dev.of_node;
+	struct bcm54xx_phy_priv *priv = phydev->priv;
+	int i, val, err;
 
-	/* Disable BroadR-Reach function. */
-	reg = bcm_phy_read_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL);
-	reg &= ~BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
-	err = bcm_phy_write_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL,
-				reg);
-	if (err < 0)
+	for (i = 0; i < ARRAY_SIZE(bcm54811_linkmodes); i++)
+		linkmode_clear_bit(bcm54811_linkmodes[i], phydev->supported);
+
+	priv->brr_mode = of_property_read_bool(np, "brr-mode");
+
+	/* Set BroadR-Reach mode as configured in the DT. */
+	err = bcm5481x_set_brrmode(phydev, priv->brr_mode);
+	if (err)
 		return err;
 
-	err = bcm54xx_config_init(phydev);
+	if (priv->brr_mode) {
+		linkmode_set_bit_array(phy_basic_ports_array,
+				       ARRAY_SIZE(phy_basic_ports_array),
+				       phydev->supported);
 
-	/* Enable CLK125 MUX on LED4 if ref clock is enabled. */
-	if (!(phydev->dev_flags & PHY_BRCM_RX_REFCLK_UNUSED)) {
-		reg = bcm_phy_read_exp(phydev, BCM54612E_EXP_SPARE0);
-		err = bcm_phy_write_exp(phydev, BCM54612E_EXP_SPARE0,
-					BCM54612E_LED4_CLK125OUT_EN | reg);
-		if (err < 0)
-			return err;
+		val = phy_read(phydev, MII_BCM54XX_LRESR);
+		if (val < 0)
+			return val;
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				 phydev->supported,
+				 val & LRESR_LDSABILITY);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+				 phydev->supported,
+				 val & LRESR_100_1PAIR);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
+				 phydev->supported,
+				 val & LRESR_10_1PAIR);
+		return 0;
 	}
 
-	return err;
+	return genphy_read_abilities(phydev);
 }
 
-static int bcm5481_config_aneg(struct phy_device *phydev)
+static int bcm5481x_config_delay_swap(struct phy_device *phydev)
 {
 	struct device_node *np = phydev->mdio.dev.of_node;
-	int ret;
-
-	/* Aneg firstly. */
-	ret = genphy_config_aneg(phydev);
 
-	/* Then we can set up the delay. */
+	/* Set up the delay. */
 	bcm54xx_config_clock_delay(phydev);
 
 	if (of_property_read_bool(np, "enet-phy-lane-swap")) {
 		/* Lane Swap - Undocumented register...magic! */
-		ret = bcm_phy_write_exp(phydev, MII_BCM54XX_EXP_SEL_ER + 0x9,
-					0x11B);
+		int ret = bcm_phy_write_exp(phydev,
+					    MII_BCM54XX_EXP_SEL_ER + 0x9,
+					    0x11B);
 		if (ret < 0)
 			return ret;
 	}
 
-	return ret;
+	return 0;
+}
+
+static int bcm5481_config_aneg(struct phy_device *phydev)
+{
+	struct bcm54xx_phy_priv *priv = phydev->priv;
+	int ret;
+
+	/* Aneg firstly. */
+	if (priv->brr_mode)
+		ret = bcm_config_lre_aneg(phydev, false);
+	else
+		ret = genphy_config_aneg(phydev);
+
+	if (ret)
+		return ret;
+
+	/* Then we can set up the delay and swap. */
+	return bcm5481x_config_delay_swap(phydev);
+}
+
+static int bcm54811_config_aneg(struct phy_device *phydev)
+{
+	struct bcm54xx_phy_priv *priv = phydev->priv;
+	int ret;
+
+	/* Aneg firstly. */
+	if (priv->brr_mode) {
+		/* BCM54811 is only capable of autonegotiation in IEEE mode */
+		phydev->autoneg = 0;
+		ret = bcm_config_lre_aneg(phydev, false);
+	} else {
+		ret = genphy_config_aneg(phydev);
+	}
+
+	if (ret)
+		return ret;
+
+	/* Then we can set up the delay and swap. */
+	return bcm5481x_config_delay_swap(phydev);
 }
 
 struct bcm54616s_phy_priv {
@@ -1062,6 +1210,203 @@ static void bcm54xx_link_change_notify(struct phy_device *phydev)
 	bcm_phy_write_exp(phydev, MII_BCM54XX_EXP_EXP08, ret);
 }
 
+static int lre_read_master_slave(struct phy_device *phydev)
+{
+	int cfg = MASTER_SLAVE_CFG_UNKNOWN, state;
+	int val;
+
+	/* In BroadR-Reach mode we are always capable of master-slave
+	 *  and there is no preferred master or slave configuration
+	 */
+	phydev->master_slave_get = MASTER_SLAVE_CFG_UNKNOWN;
+	phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
+
+	val = phy_read(phydev, MII_BCM54XX_LRECR);
+	if (val < 0)
+		return val;
+
+	if ((val & LRECR_LDSEN) == 0) {
+		if (val & LRECR_MASTER)
+			cfg = MASTER_SLAVE_CFG_MASTER_FORCE;
+		else
+			cfg = MASTER_SLAVE_CFG_SLAVE_FORCE;
+	}
+
+	val = phy_read(phydev, MII_BCM54XX_LRELDSE);
+	if (val < 0)
+		return val;
+
+	if (val & LDSE_MASTER)
+		state = MASTER_SLAVE_STATE_MASTER;
+	else
+		state = MASTER_SLAVE_STATE_SLAVE;
+
+	phydev->master_slave_get = cfg;
+	phydev->master_slave_state = state;
+
+	return 0;
+}
+
+/* Read LDS Link Partner Ability in BroadR-Reach mode */
+static int lre_read_lpa(struct phy_device *phydev)
+{
+	int i, lrelpa;
+
+	if (phydev->autoneg != AUTONEG_ENABLE) {
+		if (!phydev->autoneg_complete) {
+			/* aneg not yet done, reset all relevant bits */
+			for (i = 0; i < ARRAY_SIZE(lds_br_bits); i++)
+				linkmode_clear_bit(lds_br_bits[i],
+						   phydev->lp_advertising);
+
+			return 0;
+		}
+
+		/* Long-Distance Signaling Link Partner Ability */
+		lrelpa = phy_read(phydev, MII_BCM54XX_LRELPA);
+		if (lrelpa < 0)
+			return lrelpa;
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+				 phydev->lp_advertising,
+				 lrelpa & LRELPA_PAUSE_ASYM);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				 phydev->lp_advertising,
+				 lrelpa & LRELPA_PAUSE);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+				 phydev->lp_advertising,
+				 lrelpa & LRELPA_100_1PAIR);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
+				 phydev->lp_advertising,
+				 lrelpa & LRELPA_10_1PAIR);
+	} else {
+		linkmode_zero(phydev->lp_advertising);
+	}
+
+	return 0;
+}
+
+static int lre_read_status_fixed(struct phy_device *phydev)
+{
+	int lrecr = phy_read(phydev, MII_BCM54XX_LRECR);
+
+	if (lrecr < 0)
+		return lrecr;
+
+	phydev->duplex = DUPLEX_FULL;
+
+	if (lrecr & LRECR_SPEED100)
+		phydev->speed = SPEED_100;
+	else
+		phydev->speed = SPEED_10;
+
+	return 0;
+}
+
+/**
+ * lre_update_link - update link status in @phydev
+ * @phydev: target phy_device struct
+ * Return:  0 on success, < 0 on error
+ *
+ * Description: Update the value in phydev->link to reflect the
+ *   current link value.  In order to do this, we need to read
+ *   the status register twice, keeping the second value.
+ *   This is a genphy_update_link modified to work on LRE registers
+ *   of BroadR-Reach PHY
+ */
+static int lre_update_link(struct phy_device *phydev)
+{
+	int status = 0, lrecr;
+
+	lrecr = phy_read(phydev, MII_BCM54XX_LRECR);
+	if (lrecr < 0)
+		return lrecr;
+
+	/* Autoneg is being started, therefore disregard BMSR value and
+	 * report link as down.
+	 */
+	if (lrecr & BMCR_ANRESTART)
+		goto done;
+
+	/* The link state is latched low so that momentary link
+	 * drops can be detected. Do not double-read the status
+	 * in polling mode to detect such short link drops except
+	 * the link was already down.
+	 */
+	if (!phy_polling_mode(phydev) || !phydev->link) {
+		status = phy_read(phydev, MII_BCM54XX_LRESR);
+		if (status < 0)
+			return status;
+		else if (status & LRESR_LSTATUS)
+			goto done;
+	}
+
+	/* Read link and autonegotiation status */
+	status = phy_read(phydev, MII_BCM54XX_LRESR);
+	if (status < 0)
+		return status;
+done:
+	phydev->link = status & LRESR_LSTATUS ? 1 : 0;
+	phydev->autoneg_complete = status & LRESR_LDSCOMPLETE ? 1 : 0;
+
+	/* Consider the case that autoneg was started and "aneg complete"
+	 * bit has been reset, but "link up" bit not yet.
+	 */
+	if (phydev->autoneg == AUTONEG_ENABLE && !phydev->autoneg_complete)
+		phydev->link = 0;
+
+	return 0;
+}
+
+/* Get the status in BroadRReach mode just like genphy_read_status does
+*   in normal mode
+*/
+static int bcm54811_lre_read_status(struct phy_device *phydev)
+{
+	int err, old_link = phydev->link;
+
+	/* Update the link, but return if there was an error */
+	err = lre_update_link(phydev);
+	if (err)
+		return err;
+
+	/* why bother the PHY if nothing can have changed */
+	if (phydev->autoneg ==
+		AUTONEG_ENABLE && old_link && phydev->link)
+		return 0;
+
+	phydev->speed = SPEED_UNKNOWN;
+	phydev->duplex = DUPLEX_UNKNOWN;
+	phydev->pause = 0;
+	phydev->asym_pause = 0;
+
+	err = lre_read_master_slave(phydev);
+	if (err < 0)
+		return err;
+
+	/* Read LDS Link Partner Ability */
+	err = lre_read_lpa(phydev);
+	if (err < 0)
+		return err;
+
+	if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete)
+		phy_resolve_aneg_linkmode(phydev);
+	else if (phydev->autoneg == AUTONEG_DISABLE)
+		err = lre_read_status_fixed(phydev);
+
+	return err;
+}
+
+static int bcm54811_read_status(struct phy_device *phydev)
+{
+	struct bcm54xx_phy_priv *priv = phydev->priv;
+
+	if (priv->brr_mode)
+		return  bcm54811_lre_read_status(phydev);
+
+	return genphy_read_status(phydev);
+}
+
 static struct phy_driver broadcom_drivers[] = {
 {
 	.phy_id		= PHY_ID_BCM5411,
@@ -1211,10 +1556,12 @@ static struct phy_driver broadcom_drivers[] = {
 	.get_strings	= bcm_phy_get_strings,
 	.get_stats	= bcm54xx_get_stats,
 	.probe		= bcm54xx_phy_probe,
-	.config_init    = bcm54811_config_init,
-	.config_aneg    = bcm5481_config_aneg,
+	.config_init    = bcm54xx_config_init,
+	.config_aneg    = bcm54811_config_aneg,
 	.config_intr    = bcm_phy_config_intr,
 	.handle_interrupt = bcm_phy_handle_interrupt,
+	.read_status	= bcm54811_read_status,
+	.get_features	= bcm5481x_read_abilities,
 	.suspend	= bcm54xx_suspend,
 	.resume		= bcm54xx_resume,
 	.link_change_notify	= bcm54xx_link_change_notify,
-- 
2.39.2



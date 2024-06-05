Return-Path: <netdev+bounces-100915-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A36E8FC86C
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 11:57:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A93E1C21135
	for <lists+netdev@lfdr.de>; Wed,  5 Jun 2024 09:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52C3C19049B;
	Wed,  5 Jun 2024 09:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="clID9TSi"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2054.outbound.protection.outlook.com [40.107.13.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E3EE18FC7A;
	Wed,  5 Jun 2024 09:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581436; cv=fail; b=oacFxdjVOeXO2+rjGkIdS/+0Zug/54AjcTtpAiSALWUUvwLWL3fWVAeflho5qkZzfsnd9Py5SPtQjvXC63RRRKfv5ahbxds5ODD+CZIWJCbV7WMOlb7VTrN685VZa8sriganTVsNfTgYZoaJKl+4klRSXfxnI/7/Dp5dgyLuA1s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581436; c=relaxed/simple;
	bh=Xk7xRlaFXpenkizNr6g2f9aaZAXGdOtjHnfiKA0Y2oc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BKK5gF2fhX2SB4B/LjceOyyFQvJVURVws6HnyVDb32rQvEbDQoGApsOixdpvLWK1UjYJPaINmv/lZEN+cETDFUnAE50mWCEkfYPBzFuj2HqwSsmoVXwURFFRYoYJR88rc1ifE7gKo374b08gPnM3713xbkJXktTpxuNArbg6w1w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=clID9TSi; arc=fail smtp.client-ip=40.107.13.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Bbqrl+IzChqNt1tY486/q5QNPLGn9tj9OXxvzGd6cHAMQaaTb8bJiMRXFLXbCcp4JaROU60eXmVvOvHHf2jfP4AsdttHtx4DEtsCVCnHxQ6X1TjLnZK4TU4txx4ulJXXcT/10BX3UZ63cvvDcMEoEA1wRpM5MrERWLF494T169iLSo2gtlexh41HaXpRcKiF5QS0aB0TUvcc0QCZuNOeQIerfS0pRGSYvTjE00t2lsRgoc9K2pO1ldQxwibXx5QmBbfIyyB9V/bMn2oGX16a8wI/VQ/APu1nu3KtSbnvpIF7dazOVV9GdKh/F88Tc6a/bbPMaTM/qOh4/Gah8LK1jg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X0aKuPQxHSfCtYhcnChDVxZdZ1PeUkt3AoDncLbJLu4=;
 b=nvRQ6bO3DPaf3Uwy+GXven+cGj053oBBoGF0rryDIL4MDWUGYTW2bfEsaLQrV/C1yP/2CLkidNjPJ7azJjKdUCfekxwIfFRxx1WudltnlNE2Sg8ibrE3eKQUM2BDN9XSybHd1nyJ12x8V6hrpOycFuyO6upzlG+R/uXHWmznRKNoR9GPxPEwzb/4v32TJ7JCvIPnOaTlfpICg+Gg4tGU8qnCZ79hoXF8p3K1lxt+tZG9NLZuL5CclyYX3f3Z2a9vxMGTqOnlKEHyECyY3ayyOYS+vqRFMR0kzhAWNXYjtfK3mMOxh68paFhRxNk/YpshDVG+jFGXZcpICXTiJszsrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X0aKuPQxHSfCtYhcnChDVxZdZ1PeUkt3AoDncLbJLu4=;
 b=clID9TSi8j7x8d41sg2s9A0YjMtkBigICCI6jStdvG8+hE5gpuJAtX0EQeKhcVPy2DyizerVj5m+be2ApCsdokbfrT9bVHUFPwwqR9ittm3csv+uhnmrZb7utAoUx3KG/gVEYzytZnw2FCJL4joxjXyPLxZqmzpaVXeGam3B/WI=
Received: from DU2PR04CA0232.eurprd04.prod.outlook.com (2603:10a6:10:2b1::27)
 by DU2PR02MB10085.eurprd02.prod.outlook.com (2603:10a6:10:494::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Wed, 5 Jun
 2024 09:57:08 +0000
Received: from DU2PEPF00028D0B.eurprd03.prod.outlook.com
 (2603:10a6:10:2b1:cafe::6a) by DU2PR04CA0232.outlook.office365.com
 (2603:10a6:10:2b1::27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7656.16 via Frontend
 Transport; Wed, 5 Jun 2024 09:57:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D0B.mail.protection.outlook.com (10.167.242.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Wed, 5 Jun 2024 09:57:08 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 5 Jun
 2024 11:57:05 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v5 3/3] net: phy: bcm-phy-lib: Implement BroadR-Reach link modes
Date: Wed, 5 Jun 2024 11:56:46 +0200
Message-ID: <20240605095646.3924454-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240605095646.3924454-1-kamilh@axis.com>
References: <20240605095646.3924454-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0B:EE_|DU2PR02MB10085:EE_
X-MS-Office365-Filtering-Correlation-Id: 7b3597f8-962c-4ad1-b5b1-08dc8545dcf3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cnpoamlOd0pwR1QzZG1wekd6M3lENGwrQ1lNYk5HMGQ3QVVDbG55YzFrMVAv?=
 =?utf-8?B?YUpyR01EUjRNUlVRRHc0VnZ6QlVlaFVMTGljMUdVWVhWaTNMbVZ3dldpekJK?=
 =?utf-8?B?RkRqamtXa0NVdjY2TG53Z2U2VkpSRGZBMlR1b3J2d3dyZ3lrbXBJcHBOTFJ2?=
 =?utf-8?B?bkFkS3JNQ05aUFp1ciszU29PUC83WE5lV0c1NFJ6cTZxN1NtTEJ2ckMrcE4v?=
 =?utf-8?B?L1M4ZDJCNk9VaXVlUFZjenhLYWZsU0JuTi9qOGJwejY5Wlp4OVhlN2lsK0pq?=
 =?utf-8?B?QWJQVEhOaW1PMlRBT2gvcXJtK2hiN09EZFd2TUpzVlJPQm5VZitvcllXMUc0?=
 =?utf-8?B?bjVZU0czdjl6ZDNuS3NtcFRTVXhjT3JQcEI5eEJzOFJqS0ZWbEFkTEMxRWF1?=
 =?utf-8?B?TWxlbFNndE8wTnJRUGNSSllQcmZWMk1lcjgvRW0wc29wZ3d2ODl6L3NqTk9V?=
 =?utf-8?B?U0Q0V0t3U2t1ZDNod20yNjdTUVNHMG5WRGRabnJQKzNPL2pIRXd6WFBVcDNS?=
 =?utf-8?B?T2VWQVBqc1pUSVlyQjlSenNjaWhLbEZXVHAzMTZwTkI1T0hWSzFmOE9lSEo4?=
 =?utf-8?B?Rm9yd2VOcU1BcVdCUzd5L0RjRmxkeGFES1Q3dDV6UWdRamFMTEZUeUE5RjEx?=
 =?utf-8?B?UWx3UU50UVdCc0pIOWo2NzdCZUtNOVluVy82UG9iMUc1YVFVNWVMK0VTdDV0?=
 =?utf-8?B?SmhJRGlsb1lnaHo4enhCV1JoZEJ1S3BXeFg4aEU2cjJLN0tqOTBwTjlScGox?=
 =?utf-8?B?OEQxTUxNd3ZNMy9QVWdWai9jZnYwd0Nia3dnVkhaeU9MMTRNOUtQU0FwSGF0?=
 =?utf-8?B?ejlrd1BaVUUyL25HdDV0dzZsOHVLeU1WK2IrMmtHVEhua3ViRWg5d1pYYmVL?=
 =?utf-8?B?Wm04Vlk3bmRWSzJ5K1dIZE5UeVh6L1Exd2xoMEtTRDFyN1RsQ0dFejJvVFhr?=
 =?utf-8?B?dUxuUXJUMXZUZDhub0dzYlBJclZaRCswOXBBWjVtbkpsYWJidUl1SU94d1Jz?=
 =?utf-8?B?OXN2KzF5K2dvcERYVytDNzY2SmU3ZU85UnN1eWhzTG4yNmdWNWpRQm9CenFn?=
 =?utf-8?B?YjQ3cGpmVEdIU2Fja2FTNHEzMjFnbGZnajE4eVRoU2ZmZXRsYVdDeG9ZZ2tp?=
 =?utf-8?B?ZEoyb2EzZWhteW9JcVgxZlBkbFFRdnJnMGlhSVllL3FuZkMrcE0xREljZStI?=
 =?utf-8?B?V0hld3RmTEkxdzNuZUV4R0FNR1Y3T2k0STZlR3JJTWFvcWdCUHdDOUNWWFVS?=
 =?utf-8?B?L3RpeUlBTmkrY1lWYzJRQzQrcXkyaXB3YUFSYlNJN0RjejRGSXVjUUhQT2Rw?=
 =?utf-8?B?c3NLc1NpQUtxczRRYW1vakNaNUh0SHN4aXRaRkZpelZtNjBnZDRMQ1ArdnIw?=
 =?utf-8?B?VXo2ZDY1azd3S1Brem1rUFN4ZVhoTzR3azhZdHdLbU95Y0szVWJtaktVVkEw?=
 =?utf-8?B?cHh1S3Fqclhlc1JYdHNQeCs1dXUxdmtCd05QdGVrTHFZOTVFTDlSZWtEcHN6?=
 =?utf-8?B?U2wyci9lc0xSNnlzWHNOc0w1ajNBQytJbVhESlVCVXVmZE9HdjArQ2M0aEZy?=
 =?utf-8?B?aktwcnRQOS9IVGhhWE9hemZOYlhmaEYzYzYxQXpDWVhVMlJRWXZvNlFSME1m?=
 =?utf-8?B?UEswQkE0SWtOVlRLd2owalJKU3RSdVBnVkpJVHFVZzFjQ3lzQW41c0l4dGp5?=
 =?utf-8?B?dm5qVVlSRkgrMkp1TjArRkdkZHByNDgrejVQeXFBMXpVdUd1emJmZjBOcXVp?=
 =?utf-8?B?K3lTR1dyQ0tuWXRoMXllYjJxV1BIeHdHTFZmOWtWYjdidkpYdXBCbG8ydFd2?=
 =?utf-8?B?RnNwZVBsS1Z0OG4xNllnZ2VHZzVQUnRUeXBvR0twTnhrMDFUL25qOUJtNW44?=
 =?utf-8?Q?nO5mmy42O/Ei+?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2024 09:57:08.5027
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7b3597f8-962c-4ad1-b5b1-08dc8545dcf3
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D0B.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR02MB10085

Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
Create set of functions alternative to IEEE 802.3 to handle configuration
of these modes on compatible Broadcom PHYs.

Change-Id: I592d261bc0d60aaa78fc1717a315b0b1c1449c81
Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 drivers/net/phy/bcm-phy-lib.c | 123 ++++++++++++
 drivers/net/phy/bcm-phy-lib.h |   4 +
 drivers/net/phy/broadcom.c    | 368 ++++++++++++++++++++++++++++++++--
 drivers/net/phy/phy-core.c    |   2 +-
 include/linux/brcmphy.h       |   9 +
 5 files changed, 488 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index 876f28fd8256..cc1b5e5a958c 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -794,6 +794,47 @@ static int _bcm_phy_cable_test_get_status(struct phy_device *phydev,
 	return ret;
 }
 
+static int bcm_setup_forced(struct phy_device *phydev)
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
+ * bcm_linkmode_adv_to_mii_adv_t
+ * @advertising: the linkmode advertisement settings
+ * @return: LDS Auto-Negotiation Advertised Ability register value
+ *
+ * A small helper function that translates linkmode advertisement
+ * settings to phy autonegotiation advertisements for the
+ * MII_BCM54XX_LREANAA register of Broadcom PHYs capable of LDS
+ */
+static u32 bcm_linkmode_adv_to_mii_adv_t(unsigned long *advertising)
+{
+	u32 result = 0;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT, advertising))
+		result |= LREANAA_10_1PAIR;
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT, advertising))
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
@@ -1066,6 +1107,88 @@ int bcm_phy_led_brightness_set(struct phy_device *phydev,
 }
 EXPORT_SYMBOL_GPL(bcm_phy_led_brightness_set);
 
+int bcm_setup_master_slave(struct phy_device *phydev)
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
+EXPORT_SYMBOL_GPL(bcm_setup_master_slave);
+
+int bcm_config_aneg(struct phy_device *phydev, bool changed)
+{
+	int err;
+
+	if (genphy_config_eee_advert(phydev))
+		changed = true;
+
+	err = bcm_setup_master_slave(phydev);
+	if (err < 0)
+		return err;
+	else if (err)
+		changed = true;
+
+	if (phydev->autoneg != AUTONEG_ENABLE)
+		return bcm_setup_forced(phydev);
+
+	err = bcm_config_advert(phydev);
+	if (err < 0)
+		return err;
+	else if (err)
+		changed = true;
+
+	return genphy_check_and_restart_aneg(phydev, changed);
+}
+EXPORT_SYMBOL_GPL(bcm_config_aneg);
+
+/**
+ * bcm_config_advert - sanitize and advertise auto-negotiation parameters
+ * @phydev: target phy_device struct
+ *
+ * Description: Writes MII_BCM54XX_LREANAA with the appropriate values,
+ *   after sanitizing the values to make sure we only advertise
+ *   what is supported.  Returns < 0 on error, 0 if the PHY's advertisement
+ *   hasn't changed, and > 0 if it has changed.
+ */
+int bcm_config_advert(struct phy_device *phydev)
+{
+	int err;
+	u32 adv;
+
+	/* Only allow advertising what this PHY supports */
+	linkmode_and(phydev->advertising, phydev->advertising,
+		     phydev->supported);
+
+	adv = bcm_linkmode_adv_to_mii_adv_t(phydev->advertising);
+
+	/* Setup BroadR-Reach mode advertisement */
+	err = phy_modify_changed(phydev, MII_BCM54XX_LREANAA,
+				 LRE_ADVERTISE_ALL | LREANAA_PAUSE |
+				 LREANAA_PAUSE_ASYM, adv);
+
+	if (err < 0)
+		return err;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(bcm_config_advert);
+
 MODULE_DESCRIPTION("Broadcom PHY Library");
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Broadcom Corporation");
diff --git a/drivers/net/phy/bcm-phy-lib.h b/drivers/net/phy/bcm-phy-lib.h
index b52189e45a84..0f6d06c0b7af 100644
--- a/drivers/net/phy/bcm-phy-lib.h
+++ b/drivers/net/phy/bcm-phy-lib.h
@@ -121,4 +121,8 @@ irqreturn_t bcm_phy_wol_isr(int irq, void *dev_id);
 int bcm_phy_led_brightness_set(struct phy_device *phydev,
 			       u8 index, enum led_brightness value);
 
+int bcm_setup_master_slave(struct phy_device *phydev);
+int bcm_config_aneg(struct phy_device *phydev, bool changed);
+int bcm_config_advert(struct phy_device *phydev);
+
 #endif /* _LINUX_BCM_PHY_LIB_H */
diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 370e4ed45098..5eaad9913df6 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -553,18 +553,98 @@ static int bcm54810_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
 	return -EOPNOTSUPP;
 }
 
-static int bcm54811_config_init(struct phy_device *phydev)
+static int bcm5481x_get_brrmode(struct phy_device *phydev, u8 *data)
 {
-	int err, reg;
+	int reg;
 
-	/* Disable BroadR-Reach function. */
 	reg = bcm_phy_read_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL);
-	reg &= ~BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
-	err = bcm_phy_write_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL,
-				reg);
-	if (err < 0)
+
+	*data = (reg & BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN) ? 1 : 0;
+
+	return 0;
+}
+
+static int bcm54811_read_abilities(struct phy_device *phydev)
+{
+	int val, err;
+	int i;
+	u8 brr_mode;
+	static const int modes_array[] = { ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+					   ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
+					   ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+					   ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+					   ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
+					   ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+					   ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+					   ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+					   ETHTOOL_LINK_MODE_10baseT_Half_BIT };
+
+	for (i = 0; i < ARRAY_SIZE(modes_array); i++)
+		linkmode_clear_bit(modes_array[i], phydev->supported);
+
+	err = bcm5481x_get_brrmode(phydev, &brr_mode);
+	if (err)
+		return err;
+
+	if (brr_mode) {
+		linkmode_set_bit_array(phy_basic_ports_array,
+				       ARRAY_SIZE(phy_basic_ports_array),
+				       phydev->supported);
+
+		val = phy_read(phydev, MII_BCM54XX_LRESR);
+		if (val < 0)
+			return val;
+
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Autoneg_BIT,
+				 phydev->supported, 1);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+				 phydev->supported,
+				 val & LRESR_100_1PAIR);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
+				 phydev->supported,
+				 val & LRESR_10_1PAIR);
+	} else {
+		return genphy_read_abilities(phydev);
+	}
+
+	return 0;
+}
+
+static int bcm5481x_set_brrmode(struct phy_device *phydev, bool on)
+{
+	int reg;
+	int err;
+
+	reg = bcm_phy_read_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL);
+
+	if (on)
+		reg |= BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
+	else
+		reg &= ~BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN;
+
+	err = bcm_phy_write_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL, reg);
+	if (err)
+		return err;
+
+	/* Update the abilities based on the current brr on/off setting */
+	err = bcm54811_read_abilities(phydev);
+	if (err)
 		return err;
 
+	/* Ensure LRE or IEEE register set is accessed according to the brr on/off,
+	 *  thus set the override
+	 */
+	return bcm_phy_write_exp(phydev, BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL,
+		BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_EN |
+		(on ? 0 : BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_OVERRIDE_VAL));
+}
+
+static int bcm54811_config_init(struct phy_device *phydev)
+{
+	int err, reg;
+	bool brr = false;
+	struct device_node *np = phydev->mdio.dev.of_node;
+
 	err = bcm54xx_config_init(phydev);
 
 	/* Enable CLK125 MUX on LED4 if ref clock is enabled. */
@@ -576,29 +656,79 @@ static int bcm54811_config_init(struct phy_device *phydev)
 			return err;
 	}
 
-	return err;
+	/* Configure BroadR-Reach function. */
+	brr = of_property_read_bool(np, "brr-mode");
+
+	/* With BCM54811, BroadR-Reach implies no autoneg */
+	if (brr)
+		phydev->autoneg = 0;
+
+	return bcm5481x_set_brrmode(phydev, brr);
 }
 
-static int bcm5481_config_aneg(struct phy_device *phydev)
+static int bcm5481x_config_delay_swap(struct phy_device *phydev)
 {
 	struct device_node *np = phydev->mdio.dev.of_node;
-	int ret;
 
-	/* Aneg firstly. */
-	ret = genphy_config_aneg(phydev);
-
-	/* Then we can set up the delay. */
+	/* Set up the delay. */
 	bcm54xx_config_clock_delay(phydev);
 
 	if (of_property_read_bool(np, "enet-phy-lane-swap")) {
 		/* Lane Swap - Undocumented register...magic! */
-		ret = bcm_phy_write_exp(phydev, MII_BCM54XX_EXP_SEL_ER + 0x9,
+		int ret = bcm_phy_write_exp(phydev, MII_BCM54XX_EXP_SEL_ER + 0x9,
 					0x11B);
 		if (ret < 0)
 			return ret;
 	}
 
-	return ret;
+	return 0;
+}
+
+static int bcm5481_config_aneg(struct phy_device *phydev)
+{
+	int ret;
+	u8 brr_mode;
+
+	/* Aneg firstly. */
+	ret = bcm5481x_get_brrmode(phydev, &brr_mode);
+	if (ret)
+		return ret;
+
+	if (brr_mode)
+		ret = bcm_config_aneg(phydev, false);
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
+	int ret;
+	u8 brr_mode;
+
+	/* Aneg firstly. */
+	ret = bcm5481x_get_brrmode(phydev, &brr_mode);
+	if (ret)
+		return ret;
+
+	if (brr_mode) {
+		/* BCM54811 is only capable of autonegotiation in IEEE mode */
+		phydev->autoneg = 0;
+		ret = bcm_config_aneg(phydev, false);
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
@@ -1062,6 +1192,208 @@ static void bcm54xx_link_change_notify(struct phy_device *phydev)
 	bcm_phy_write_exp(phydev, MII_BCM54XX_EXP_EXP08, ret);
 }
 
+static int bcm_read_master_slave(struct phy_device *phydev)
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
+static int bcm_read_lpa(struct phy_device *phydev)
+{
+	int i, lrelpa;
+
+	if (phydev->autoneg != AUTONEG_ENABLE) {
+		if (!phydev->autoneg_complete) {
+			/* aneg not yet done, reset all relevant bits */
+			static const int br_bits[] = { ETHTOOL_LINK_MODE_Autoneg_BIT,
+						       ETHTOOL_LINK_MODE_Pause_BIT,
+						       ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+						       ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
+						       ETHTOOL_LINK_MODE_100baseT1_Full_BIT };
+			for (i = 0; i < ARRAY_SIZE(br_bits); i++)
+				linkmode_clear_bit(br_bits[i], phydev->lp_advertising);
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
+				 phydev->lp_advertising, lrelpa & LRELPA_PAUSE_ASYM);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_Pause_BIT,
+				 phydev->lp_advertising, lrelpa & LRELPA_PAUSE);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+				 phydev->lp_advertising, lrelpa & LRELPA_100_1PAIR);
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
+				 phydev->lp_advertising, lrelpa & LRELPA_10_1PAIR);
+	} else {
+		linkmode_zero(phydev->lp_advertising);
+	}
+
+	return 0;
+}
+
+static int bcm_read_status_fixed(struct phy_device *phydev)
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
+static int bcm54811_read_status(struct phy_device *phydev)
+{
+	int err;
+	u8 brr_mode;
+
+	err = bcm5481x_get_brrmode(phydev, &brr_mode);
+
+	if (err)
+		return err;
+
+	if (brr_mode) {
+		/* Get the status in BroadRReach mode just like genphy_read_status
+		 *   does in normal mode
+		 */
+
+		int err, old_link = phydev->link;
+
+		/* Update the link, but return if there was an error */
+
+		err = lre_update_link(phydev);
+		if (err)
+			return err;
+
+		/* why bother the PHY if nothing can have changed */
+		if (phydev->autoneg == AUTONEG_ENABLE && old_link && phydev->link)
+			return 0;
+
+		phydev->speed = SPEED_UNKNOWN;
+		phydev->duplex = DUPLEX_UNKNOWN;
+		phydev->pause = 0;
+		phydev->asym_pause = 0;
+
+		err = bcm_read_master_slave(phydev);
+		if (err < 0)
+			return err;
+
+		/* Read LDS Link Partner Ability */
+		err = bcm_read_lpa(phydev);
+		if (err < 0)
+			return err;
+
+		if (phydev->autoneg == AUTONEG_ENABLE && phydev->autoneg_complete) {
+			phy_resolve_aneg_linkmode(phydev);
+		} else if (phydev->autoneg == AUTONEG_DISABLE) {
+			err = bcm_read_status_fixed(phydev);
+			if (err < 0)
+				return err;
+		}
+	} else {
+		err = genphy_read_status(phydev);
+	}
+
+	return err;
+}
+
 static struct phy_driver broadcom_drivers[] = {
 {
 	.phy_id		= PHY_ID_BCM5411,
@@ -1212,9 +1544,11 @@ static struct phy_driver broadcom_drivers[] = {
 	.get_stats	= bcm54xx_get_stats,
 	.probe		= bcm54xx_phy_probe,
 	.config_init    = bcm54811_config_init,
-	.config_aneg    = bcm5481_config_aneg,
+	.config_aneg    = bcm54811_config_aneg,
 	.config_intr    = bcm_phy_config_intr,
 	.handle_interrupt = bcm_phy_handle_interrupt,
+	.read_status	= bcm54811_read_status,
+	.get_features	= bcm54811_read_abilities,
 	.suspend	= bcm54xx_suspend,
 	.resume		= bcm54xx_resume,
 	.link_change_notify	= bcm54xx_link_change_notify,
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index 4a1972e94107..3e683a890a46 100644
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
diff --git a/include/linux/brcmphy.h b/include/linux/brcmphy.h
index 1b02e1014583..ae39c33e4086 100644
--- a/include/linux/brcmphy.h
+++ b/include/linux/brcmphy.h
@@ -357,6 +357,15 @@
 #define BCM54810_SHD_CLK_CTL			0x3
 #define BCM54810_SHD_CLK_CTL_GTXCLK_EN		(1 << 9)
 
+/* BCM54811 Registers */
+#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL	(MII_BCM54XX_EXP_SEL_ER + 0x9A)
+/* Access Control Override Enable */
+#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_EN		BIT(15)
+/* Access Control Override Value */
+#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_OVERRIDE_VAL	BIT(14)
+/* Access Control Value */
+#define BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_VAL		BIT(13)
+
 /* BCM54612E Registers */
 #define BCM54612E_EXP_SPARE0		(MII_BCM54XX_EXP_SEL_ETC + 0x34)
 #define BCM54612E_LED4_CLK125OUT_EN	(1 << 1)
-- 
2.39.2



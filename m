Return-Path: <netdev+bounces-105675-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0149091239E
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 13:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 249EA1C2536D
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 11:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAFD17BB10;
	Fri, 21 Jun 2024 11:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="K1LAdVkm"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2083.outbound.protection.outlook.com [40.107.14.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07EB1174EC7;
	Fri, 21 Jun 2024 11:27:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718969248; cv=fail; b=emH3JhuezEDglrr+4XuPw1lA0loRZj1IBLn/VDd8+dVU3Lj9T49pFJ4Jy4+R+rRtDb3XefPz/wppepmooAuQYRcl+JxqAFP6Ietln6neYiABF/k7YOyPJ0UY0TzAEhH8eBYIvSlKY82lRYXmKU0gVGbywp948DgrK7GgAdGzjR8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718969248; c=relaxed/simple;
	bh=9ytA0MQjAcbVmCeUuDKLdBgl54JRZDsG7waJBgShkm4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BV4QBVOjbYiBAa7dxmw63qp4kuzfSDN7KTgjD2lzPlbEE0msfNoabDu299goLZm7b6g/23U8UKDhm0XpxHiiafwDDV/ijqdFXYiJ7ZZLuKNcPd7uD4/ynFkE9Mq5wUu+NB/yWt4/PP/cE3ZSzHvDgViqtx0qJzJs1cABWcoitDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=K1LAdVkm; arc=fail smtp.client-ip=40.107.14.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AzkVJNx/pOS99eEHQ67YETV9Wb8FoD5+2I+Y+J/UM2XmkvB1IuOsuufXG8yOEe4scIOSmUgqfPtdaFtIimSEloCKF4kvfxGF0xp/paH/ptZ5yBHV8iEbYm1vLonnvaPsZGykHWxcgh/Lu7qOGWNFgwpVXZan52U/wLO87fZ9So7twL5wbsttpAT0CTG3L16K3AvSG4ZyaGSOBZbUTdYm1PDnLrk50+PCxEIek0ZrmnC8vRY4ZIiwrIDMTlU2zgBGgqK79VCNzV7DMN8+F8//ZYlWFcis/kWS6VT0r6vziNODeM5IBuNI6i8ukIVcPInJyhFheSLHdDUZ6ZFeI0wJvg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/zGCIZUEgdDv5ziKYSIHZjB9o3d6fOi1QVHYz6mHLdM=;
 b=nkWbyYcsk7KEe5ki+E8Ew1grQuKcA25hxspVMYtPXxgH7Mn77Z/tElALfn60ugoKB56y7CnJ/bjzkB3eMKmtjAeYS1YyXXrbJUDHx6cM37F0bZSXngRnZmy6E7oU684uXfRHGXvt9ZsikRNmhZlo+lWs8BLXG/GnbGltrvtp0SowBVixml3bbodCFgZ8f0TIHmeNPqJRuS2vxpDXpxS8/9sfOVyWubNr02jm8vvFOa0yPnnIchA6Jt7A+o0y7i0BegN4sgQ9WHf06H8j2yqsuP8shlKbxixbumYIAjN9iIwRMYwokPLvfZwG6HKuxzGR74iJxnQ/HF+a8MpO8TTPLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/zGCIZUEgdDv5ziKYSIHZjB9o3d6fOi1QVHYz6mHLdM=;
 b=K1LAdVkmFoRdVx7EK5bV8JT0nKly6SbNjGVFD/dlA+uz3ba4MAapsSDUbUL8VSjzB+Dm+ew8L+Wbrr7NFHZjY1kEKa6PGkaF8iRCW+f+IRh94o9eauHWHb4zI4h3aIqCr1HTA0Fsrpz6DDylRrpiqxGM30Gi69LHuTiD+X1JtyQ=
Received: from AM0PR10CA0026.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:208:17c::36)
 by PAWPR02MB10022.eurprd02.prod.outlook.com (2603:10a6:102:2e2::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Fri, 21 Jun
 2024 11:27:22 +0000
Received: from AM4PEPF00027A6C.eurprd04.prod.outlook.com
 (2603:10a6:208:17c:cafe::45) by AM0PR10CA0026.outlook.office365.com
 (2603:10a6:208:17c::36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.36 via Frontend
 Transport; Fri, 21 Jun 2024 11:27:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A6C.mail.protection.outlook.com (10.167.16.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Fri, 21 Jun 2024 11:27:22 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 21 Jun
 2024 13:27:21 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v9 4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach link modes
Date: Fri, 21 Jun 2024 13:26:33 +0200
Message-ID: <20240621112633.2802655-5-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240621112633.2802655-1-kamilh@axis.com>
References: <20240621112633.2802655-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A6C:EE_|PAWPR02MB10022:EE_
X-MS-Office365-Filtering-Correlation-Id: 41e49d04-b1fa-43f4-fedd-08dc91e51e6b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|376011|7416011|36860700010|82310400023|1800799021|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Q0dOdHMzT3dCUlpFdUxiZC8rWHhvY2o1SWFMTWxydkp3RVNzMjQzY0xxV0V2?=
 =?utf-8?B?RitEYWc1eGRIa2h1dk5wbUs4WXBUMFkweFd5ZytGNlZXYVFJUnF5ZU01VDdk?=
 =?utf-8?B?L1lCVTNjaEUwM1RDQ0dSdll0NHNINEJRcUpCZ2tUS0hpNWIrTitXTk1UUTU2?=
 =?utf-8?B?U2kzeXgrbTVHVFNvelh0a0JIQkY2Z2ZiVnQrMExRKzczZ1M3MEhpYW4xdWlY?=
 =?utf-8?B?S1lxVGFzeWdvcWRFL3dYem1VVW8rSlpoYVFkbFZ3QWcxNkJCOTFrd1lzb0tp?=
 =?utf-8?B?T2ZNUXVwbzM4RW5qQjN6T2tTcTNXOVdjakN1YVErV2psOEI3VmNEbmZmcWQy?=
 =?utf-8?B?bTVjNVhMQ3dTa2Q1NkswMVJNMHZJVVRPcGtKcDZnOTVkb21OdlVXSmp0RmhF?=
 =?utf-8?B?MFR5dnh4Q1BIY1R1a05kSFBVNEVNRmZKS2xxQ3N2Vk9PMXpkdGtWYk5OelU0?=
 =?utf-8?B?RGZkNnJzMnRhRDZCNFZqU0kzUUV4K3p6RDlvQmdFZG83d0cxMmNNQUFCazhC?=
 =?utf-8?B?YWJnWEQ3UUJNcGxaay93bks0aCtNT010aW5FalM1VmFQRXpQTnMyWjFZcFU2?=
 =?utf-8?B?cHlaazUwbXhmb3lYakxZSzRtK3g1R0dEdkxPdkx0RlhoY3lrajRCUXVYdnhs?=
 =?utf-8?B?dENvS1I4bElTMjJ6d1Q1UUpyaThZSm9CUmJPWU5KMlBhclg1aXpBWFhUMHlQ?=
 =?utf-8?B?b0VXNU43QTd5eCtMbU9MVVBBamNKSlhIOWpqUkpEM0JrbGxEUHExVk1qNmNl?=
 =?utf-8?B?NS94YzBFSjhiTkhSdkJLaTNySkJ0WWR2Y01WMHhhTWZGZDRFMndiZVBCd1VX?=
 =?utf-8?B?NjY4SGl6dnEzNC9qYWVqMC9aMXVDY2dUS1puMDMrbnpXQXRNNERiZ0tYc3hT?=
 =?utf-8?B?YzFyQ1NVamcra2xFWWxPaStxUzJIUlFOMnk5TFppU2FJdGNDNUdVMGdPd2xE?=
 =?utf-8?B?T0VKQkFxaHYzck44RUlEcVRDSUEzZGFjK3hXTzlnMlFtd3NyK0l0OXcxWkhL?=
 =?utf-8?B?MHU2TGxwMERIVzdDM2hrQzJ4N09uNUZlWThnaFQ0NVVneDZQcW01QTRCdEs3?=
 =?utf-8?B?ZWRHK1pGR1NrOE16SFNCdVRMVGdENnc3L1JEN3dkT0NrZkFjVzJmRGFEaUZD?=
 =?utf-8?B?L3F2REFrbU9qREI3dDVpMDUrR0JQWGdmcTZFSnRPUTdNNFRYSU15VSt4dlBF?=
 =?utf-8?B?SE1FYmJ3SCtVVldCcFFYZk15aC8vNmg5K0ZQanI4THVReGQ0UFJiR1hFc0Zh?=
 =?utf-8?B?clNDR1AvblJ3T3ZpVXEzb1hkRmwreERhK08vMUN4UEZZNFo2UlFrYlhIcVNt?=
 =?utf-8?B?RjMyRHMwTkRPKzIvK0Q4Rk1sSFhCZ2QydTdYM1hOVTlQQWZNYWRPK2pKNitr?=
 =?utf-8?B?MGIxMDBoSzIrNS81R1JEYkxzbHg2QUdQNlJZejVXdE14aFRhZVAyZFJnSC9v?=
 =?utf-8?B?Szk4OUpRbE96TThsbTkwVEhNSndIZmZCU2FzVVdScEhHN1c4bkh4UjJwaVor?=
 =?utf-8?B?a2xHNklMY2w0ZVhUQTFOSmJTRkNFM0M2cFJpWnRsenM2ZDRkUWdYR0RFUlZq?=
 =?utf-8?B?cnZ3S09NMkNZcElDc2ZOQWoxdWEyUW5IbEt3dVBFVytIOHFOanRtbUsza3R4?=
 =?utf-8?B?Q05ybjZzeUZDVTFiODMvcWhrMjdwQmUwL1pZeDFpbW9yeVdhTXZ0ZEFwRjVz?=
 =?utf-8?B?Zmlmc1MrbW9IN2F0cGdwV2czZzRHcnUyTU9mY3R1d1l0cGt6NXgvTVErckRG?=
 =?utf-8?B?ZlQ3N3ZJNjA1TUNmVm42NjI2WGVxdHROTUZXQnFHOFlrcEcvM002ZG1zUm1I?=
 =?utf-8?B?TFdGT0REUTBUdnhBNlZKY0NzMzU5VVJjUDhCWjlnUUluVVpuQ2h1OHZlNElL?=
 =?utf-8?B?MGRnV2RKS2pxdnNtanVvS0I1V2FLankzdXFRUHhHSnU1NXJJQ3E5aVVBY0s0?=
 =?utf-8?Q?5ozanD+5NeI=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(376011)(7416011)(36860700010)(82310400023)(1800799021)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jun 2024 11:27:22.3231
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 41e49d04-b1fa-43f4-fedd-08dc91e51e6b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A6C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB10022

Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
Create set of functions alternative to IEEE 802.3 to handle
configuration of these modes on compatible Broadcom PHYs.

Signed-off-by: Kamil Horák (2N) <kamilh@axis.com>
---
 drivers/net/phy/bcm-phy-lib.c | 115 ++++++++++
 drivers/net/phy/bcm-phy-lib.h |   4 +
 drivers/net/phy/broadcom.c    | 392 ++++++++++++++++++++++++++++++++--
 3 files changed, 493 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index 876f28fd8256..9e15eb4a5d43 100644
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
+int bcm_config_lre_aneg(struct phy_device *phydev, bool changed)
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
index b52189e45a84..fecdd66ad736 100644
--- a/drivers/net/phy/bcm-phy-lib.h
+++ b/drivers/net/phy/bcm-phy-lib.h
@@ -121,4 +121,8 @@ irqreturn_t bcm_phy_wol_isr(int irq, void *dev_id);
 int bcm_phy_led_brightness_set(struct phy_device *phydev,
 			       u8 index, enum led_brightness value);
 
+int bcm_setup_master_slave(struct phy_device *phydev);
+int bcm_config_lre_aneg(struct phy_device *phydev, bool changed);
+int bcm_config_lre_advert(struct phy_device *phydev);
+
 #endif /* _LINUX_BCM_PHY_LIB_H */
diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 370e4ed45098..2aaa2e8bfe49 100644
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
@@ -38,6 +40,28 @@ struct bcm54xx_phy_priv {
 	bool	wake_irq_enabled;
 };
 
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
+};
+
 static bool bcm54xx_phy_can_wakeup(struct phy_device *phydev)
 {
 	struct bcm54xx_phy_priv *priv = phydev->priv;
@@ -553,18 +577,92 @@ static int bcm54810_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
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
+	int i, val, err;
+	u8 brr_mode;
+
+	for (i = 0; i < ARRAY_SIZE(bcm54811_linkmodes); i++)
+		linkmode_clear_bit(bcm54811_linkmodes[i], phydev->supported);
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
+		return 0;
+	}
+
+	return genphy_read_abilities(phydev);
+}
+
+static int bcm5481x_set_brrmode(struct phy_device *phydev, bool on)
+{
+	int reg;
+	int err;
+	u16 val;
+
+	reg = bcm_phy_read_exp(phydev, BCM54810_EXP_BROADREACH_LRE_MISC_CTL);
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
+	/* Update the abilities based on the current brr on/off setting */
+	err = bcm54811_read_abilities(phydev);
+	if (err)
 		return err;
 
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
+	struct device_node *np = phydev->mdio.dev.of_node;
+	bool brr = false;
+	int err, reg;
+
 	err = bcm54xx_config_init(phydev);
 
 	/* Enable CLK125 MUX on LED4 if ref clock is enabled. */
@@ -576,29 +674,80 @@ static int bcm54811_config_init(struct phy_device *phydev)
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
+	u8 brr_mode;
+	int ret;
+
+	ret = bcm5481x_get_brrmode(phydev, &brr_mode);
+	if (ret)
+		return ret;
+
+	/* Aneg firstly. */
+	if (brr_mode)
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
+	u8 brr_mode;
+	int ret;
+
+	/* Aneg firstly. */
+	ret = bcm5481x_get_brrmode(phydev, &brr_mode);
+	if (ret)
+		return ret;
+
+	if (brr_mode) {
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
@@ -1062,6 +1211,211 @@ static void bcm54xx_link_change_notify(struct phy_device *phydev)
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
+static int bcm54811_read_status(struct phy_device *phydev)
+{
+	u8 brr_mode;
+	int err;
+
+	err = bcm5481x_get_brrmode(phydev, &brr_mode);
+
+	if (err)
+		return err;
+
+	if (brr_mode) {
+		/* Get the status in BroadRReach mode just like
+		 *   genphy_read_status does in normal mode
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
+		if (phydev->autoneg ==
+		    AUTONEG_ENABLE && old_link && phydev->link)
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
+		if (phydev->autoneg ==
+		    AUTONEG_ENABLE && phydev->autoneg_complete) {
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
@@ -1212,9 +1566,11 @@ static struct phy_driver broadcom_drivers[] = {
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
-- 
2.39.2



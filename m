Return-Path: <netdev+bounces-100592-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F345B8FB3F6
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 15:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68E381F2165B
	for <lists+netdev@lfdr.de>; Tue,  4 Jun 2024 13:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 121CD147C85;
	Tue,  4 Jun 2024 13:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="alqFzqdM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2048.outbound.protection.outlook.com [40.107.7.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45B3149016;
	Tue,  4 Jun 2024 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717508259; cv=fail; b=nSKRMYnX/v0FaEge9H2xzAHBDDCXej9dpW9L9vw8we6mlWRFx2AWDy+apGElphWJeypk+WDK7tMpxkL2iPZ5rZ3peUUIwa/jKepHHXb27d6h5+/Lf+3mZ1rq+SwVC0x2XkFVMrmjTaLysPFlgEm6CUH3KzSgd/XXmnqOCevVFTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717508259; c=relaxed/simple;
	bh=+qjeXHHjXMAjBBKGLPeb/xOJ20H4lt5pZeMkIuuIBZo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sgr5G4EOHdyJQ2KwTe/R+e0P0l1lDBdv58Ax0Iua0ahPzDJiagIH904+SK4WONJXF/Ya8fvDyn3gEDtCtmJz3UjtPTT4vEeYvfPnEiQbTS4BWkteHV1XHPRej571z8EmMOv55oEkD8cSX90kJ49Ztrce/v9hJQ/2Lnu6ZUWd134=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=alqFzqdM; arc=fail smtp.client-ip=40.107.7.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IT8+ypErpEBKx9ZYqbMAoMCOh3lZA2E/4kb/TQ51hhWeAWUJboxIRlauSsoxKXLEM7rcHipFJkhfS4JdhKUS/W/D/m8JOj9aF4ln7gH0dGWkyw8blk+dAfg9z+jWG3fd9Vda93muZ/B4CrJne8BgbnWFSHVhZPEQ4XOHdajxTU89y8uJYOWj0VfKt0ytpxJ99MbBUpnabcdeafPzY7eEGkg3JRblqI5r8avVFqVBAzcrethBA4XfsVAz6Aqi58o+HK0/zkB2TieXfQNa0X3lF11Xa7I6dIZbWu7eQeXC5EZ8CnbiJIIQHWLUh126YmkR4lc+LPj3Fa7GUMOD75Hxzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rIoWdzzzZMD6cihq8Mnalwfu8h81WhNrtTCksqGtFs4=;
 b=BxpgHStZcVQtuTVEUKZq1VSit7wHvI7sHSs7O/S7PSWHllKfsTYrVgD+dwDwS3yoQTIxEzlwnoV/SNxjol5XEkQo3jFNoHg20qWpX6xSh1RCSxnDfJwlOIQsffLVppQlOlEkuADf3fv2lp1uBNEf7eac8hLBa7/cw5+yQVOz16TwZI/wtMB7bw/UYxM863hKQH++cCHMzdzRFvYYho6e8cQSCAeEeGJ3TXwANplBNVNqQkZ3+5pVE0fHuScb3LW5g+EWYRv1kD4CV6vkgKN5U6puJGgtFVEuAqWQ7ivoC5boNpHvK0xnpMQBvo1W4/9/33cMwXrygcQE+zsuS3UieA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rIoWdzzzZMD6cihq8Mnalwfu8h81WhNrtTCksqGtFs4=;
 b=alqFzqdMALb1eNfm3ddhS1s4mNy1bgnlWzf7yU6nhAsoO8M8SraSZ18BLzv0N9a0w9cYOyoyptYUJZ2IlzqJG6o8LL4Liu34uARjcXlLpc6mqFEtP4qNY0RRvFmYt1VSFe5lgzzXvxsyCh5Qit7V2++0paBkvFLdtou/ilX6SzI=
Received: from DU7P194CA0027.EURP194.PROD.OUTLOOK.COM (2603:10a6:10:553::7) by
 GV1PR02MB7780.eurprd02.prod.outlook.com (2603:10a6:150:1f::20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7633.25; Tue, 4 Jun 2024 13:37:22 +0000
Received: from DB5PEPF00014B98.eurprd02.prod.outlook.com
 (2603:10a6:10:553:cafe::e1) by DU7P194CA0027.outlook.office365.com
 (2603:10a6:10:553::7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.31 via Frontend
 Transport; Tue, 4 Jun 2024 13:37:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B98.mail.protection.outlook.com (10.167.8.165) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7633.15 via Frontend Transport; Tue, 4 Jun 2024 13:37:22 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 4 Jun
 2024 15:37:21 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v4 3/3] net: phy: bcm-phy-lib: Implement BroadR-Reach link modes
Date: Tue, 4 Jun 2024 15:36:54 +0200
Message-ID: <20240604133654.2626813-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240604133654.2626813-1-kamilh@axis.com>
References: <20240604133654.2626813-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B98:EE_|GV1PR02MB7780:EE_
X-MS-Office365-Filtering-Correlation-Id: 2ac67524-35e4-46fd-03a9-08dc849b7689
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|82310400017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?OXFweXR2TW1scWxRcVM5UXM2VWVMWWxRUEVFVXVrK1A3UklHYXIxUWFzSk11?=
 =?utf-8?B?d28xTUc0Wkh5dUhxNklDUUV3c2NsNEtyUzZDQ29VRTFoeWNHT3BYVGNSVkpQ?=
 =?utf-8?B?aEhodlYwYW1GZzZLWWhGRkFJcjgvTytDSHg5dDNYRFpKRDF3S2xSWlByZnZW?=
 =?utf-8?B?alZ6YkhnR3hBRi8xSWE4K2pnYzc5dlFObWswbCszZkhrMmx4NHVXRTdsKy9S?=
 =?utf-8?B?TnltWW1zZ0d4TWx4UkFUNnk4aDVBNVF1aUI4N3pWODRRdlpTbXdIT2s4Q3Jy?=
 =?utf-8?B?cFYvWFAxSFJScThvbWkvQlA0SitnczNnZFhDZkFpVEVzWkJseHR3VkVxUXY5?=
 =?utf-8?B?eDhiMFVWWTFWdHF6Qjh2TGNFSHRHR3NoVzFYTDFKQlRJWEp6aWMrbW4yZlVl?=
 =?utf-8?B?d0xFUnJFY2kzUUdqQWVKWWFxMnZkYnltS2Fjbi9QMTJ0bkpZVE9iVjNkcVBx?=
 =?utf-8?B?ZTZwYmgyM2pxcUlHRDRnQW1zczNMMGc2aVZSMStvcFo2a29oWDlBeXhqRVVq?=
 =?utf-8?B?RVZQdFhoOXZoRjY1a2lzTFZpSHVkd3JiL3plOTNRSmNiU0tFUEY4YS8xWk5J?=
 =?utf-8?B?ZHc3K3gwdkNnREhVeFZKREx6NTBlSXBzMFIrNEN5WWR6cUJvV2lvQXNERk41?=
 =?utf-8?B?QS81NWFSRUhuSERHNEhHbURkRnF0ajdLc2psTlRPeVhQdkRQR2JwQlVEUnI1?=
 =?utf-8?B?LytMVkk1L3grUHd6VGhBR0JSd3NqQ2x0bFFDSU5oOThkZFhXOENnWnlyVm5E?=
 =?utf-8?B?Uy9IbzRJWkNNdFlxdktsRkhkTjNOSE5mU2hGbzI2MXlYd2tqZGZWckxSQVk3?=
 =?utf-8?B?KzdHdy9SdVVJeHdzQ1EzNFd3N1VtNXBXUjVxMXhIR1UxREE5OE1EQi9hTkE2?=
 =?utf-8?B?aG5sWkRxcldIdmdIYnkrcjNOTytXWXBvOW1RL3ZyRWlQOWJNaUlQTHBLUEVO?=
 =?utf-8?B?eXNBcXU1eUJTRzN0WXVWV1BZSnZWeE5tZDUwbjZ5TWNURXcwM3V5MTVYeDJw?=
 =?utf-8?B?ek1MQzFBem52NndhMHpvQko3VEt0S0JmRFd3Vlo0aUxXRVJyQjhUU3RJMGk3?=
 =?utf-8?B?WTBadzNmb01WZWQrd1E2WU11ekg2b3FKSS9ITVFFVTM0MW5GdmxrOUFPVXBY?=
 =?utf-8?B?UHBzUWFPbUZJMW44cnpMZUtoeHg5ekcvKzN3ekRadHdVUzFXZkVTWGtqRWlh?=
 =?utf-8?B?QnFHT09NVnlyWFFiQUFUU1d2WmUyQzdnbExuNUlaNWJIdlBHRzJpRlpuQWx5?=
 =?utf-8?B?YlVRbWZhajR0cXkwU1g5WHQ0TTlLb0FMMHdLNjlzYnZObWNteCtIV2xOc2Js?=
 =?utf-8?B?WGswaFNrTElqamJ5d1pWKy9hS2dKTlJMTDhDcCs0dVNxRnEzQSt4M0lKL1Nx?=
 =?utf-8?B?eVRUdjFObnR5Q2t4OG04S1htVk1HSWpzSkxxSG5wUDE5MGliUE4xU3FCTzRV?=
 =?utf-8?B?MEdrbzZVYjVRU3RjRG5nTnR4WEVmd1JDcFlZZ1FrMlNmTHR5TUdaSklDQkdG?=
 =?utf-8?B?cTkxd0ZKSmh3b09MY00vTWQwTS9XZlNzclR6UkV5eGtRZ3ptYVFyejRmeWNy?=
 =?utf-8?B?MlFLSWd2V2N0YVpVWm1KQWVEOS9DT2ZhUENKbUxXK2pwWG5Jd0J6dXdZWjJO?=
 =?utf-8?B?ZUxmVWIxUkxwZGNneXBlNFVsQVArM3Z2QWdRYjlMN3h1dHFicTF0QTV4K2Nq?=
 =?utf-8?B?Z2JYbDhZNXphaGhZc0tZendmeFlGV2VkVHBWVjJOazNpd0swVkNpbHkvanBG?=
 =?utf-8?B?SmxQV2VVWnN0cUJnZHVjeHZXbkFHbGRDTWgzd2ZKUkwxSXZaOU5pcHozUmJ5?=
 =?utf-8?B?R3MycGYyZUdLdi9VL2pMZnFyM2o2L1VIa2luT3FDaDBFY0UvRFVJZkplUGpD?=
 =?utf-8?Q?RZ5gzVpbsRkRd?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(82310400017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jun 2024 13:37:22.2474
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2ac67524-35e4-46fd-03a9-08dc849b7689
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B98.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB7780

Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
Create set of functions alternative to IEEE 802.3 to handle configuration
of these modes on compatible Broadcom PHYs.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 drivers/net/phy/bcm-phy-lib.c | 122 +++++++++++
 drivers/net/phy/bcm-phy-lib.h |   4 +
 drivers/net/phy/broadcom.c    | 368 ++++++++++++++++++++++++++++++++--
 drivers/net/phy/phy-core.c    |   2 +-
 include/linux/brcmphy.h       |   9 +
 5 files changed, 489 insertions(+), 16 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index 876f28fd8256..8b626e8276fc 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -794,6 +794,46 @@ static int _bcm_phy_cable_test_get_status(struct phy_device *phydev,
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
+ *
+ * A small helper function that translates linkmode advertisement
+ * settings to phy autonegotiation advertisements for the
+ * MII_BCM54XX_LREANAA register.
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
@@ -1066,6 +1106,88 @@ int bcm_phy_led_brightness_set(struct phy_device *phydev,
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
+	if (err < 0) /* error */
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
+	return err > 0 ? 1 : 0;
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
index 370e4ed45098..8fda4aa0c231 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -553,18 +553,100 @@ static int bcm54810_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
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
+	static const int modes_array[] = {ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+					  ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
+					  ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+					  ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+					  ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
+					  ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+					  ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+					  ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+					  ETHTOOL_LINK_MODE_10baseT_Half_BIT};
+
+	u8 brr_mode;
+
+	for (i = 0; i < ARRAY_SIZE(modes_array); i++)
+		linkmode_clear_bit(modes_array[i], phydev->supported);
+
+	err = bcm5481x_get_brrmode(phydev, &brr_mode);
+
+	if (err)
 		return err;
 
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
+	return err;
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
+		return err;
+
+	/* Ensure LRE or IEEE register set is accessed according to the brr on/off,
+	 *  thus set the override
+	 */
+	return bcm_phy_write_exp(phydev, BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL,
+		BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_EN |
+		on ? 0 : BCM54811_EXP_BROADREACH_LRE_OVERLAY_CTL_OVERRIDE_VAL);
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
@@ -576,18 +658,22 @@ static int bcm54811_config_init(struct phy_device *phydev)
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
+	int ret = 0;
 
-	/* Then we can set up the delay. */
+	/* Set up the delay. */
 	bcm54xx_config_clock_delay(phydev);
 
 	if (of_property_read_bool(np, "enet-phy-lane-swap")) {
@@ -601,6 +687,54 @@ static int bcm5481_config_aneg(struct phy_device *phydev)
 	return ret;
 }
 
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
+
+	} else {
+		ret = genphy_config_aneg(phydev);
+	}
+
+	if (ret)
+		return ret;
+
+	/* Then we can set up the delay and swap. */
+	return bcm5481x_config_delay_swap(phydev);
+}
+
 struct bcm54616s_phy_priv {
 	bool mode_1000bx_en;
 };
@@ -1062,6 +1196,208 @@ static void bcm54xx_link_change_notify(struct phy_device *phydev)
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
+			static int br_bits[] = { ETHTOOL_LINK_MODE_Autoneg_BIT,
+						 ETHTOOL_LINK_MODE_Pause_BIT,
+						 ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+						 ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
+						 ETHTOOL_LINK_MODE_100baseT1_Full_BIT };
+			for (i = 0; i < ARRAY_SIZE(br_bits); i++)
+				linkmode_clear_bit(br_bits[i], phydev->lp_advertising);
+
+			return 0;
+		}
+
+		/* Long-Distance-Signalling Link Partner Ability */
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
@@ -1212,9 +1548,11 @@ static struct phy_driver broadcom_drivers[] = {
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



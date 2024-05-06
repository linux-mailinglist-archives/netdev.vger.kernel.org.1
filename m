Return-Path: <netdev+bounces-93744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A347B8BD082
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 16:42:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 58E6C280FAB
	for <lists+netdev@lfdr.de>; Mon,  6 May 2024 14:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EC44154BF8;
	Mon,  6 May 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="eOYpMrBI"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2041.outbound.protection.outlook.com [40.107.15.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955C6153BDE;
	Mon,  6 May 2024 14:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715006509; cv=fail; b=HZGrBLGR6BdipthISFGpAq0Sl5Ln6nYl18kQlcdv3CTQlnEgHY00ceNIsBDncW7NdrXaMrwDB3d11aUJ3YdDYCbFDwxDEqqHhc06d3Sz0PNOtnO5wNpIP/Gb0oZ+OFZEfue+LLrgrxEf0dMISLtxL/N5Dd2pP7PMnrKp4MccAiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715006509; c=relaxed/simple;
	bh=WmAR9U0Gn2Nh2vDpuXL5eLJ29h3oGuLoUcKDpjH9BZ0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pHbwwyomhKJQsfo20GNzwlp/iaEoTgs3Dcju17ZZcl4ttZmWtjzSt5KwNSfv6R3TV2x7sgxGfc7Gpsvav8rFfahweFC9jI+zsEQtblXxBEWI3ylBrB56EDeD4JijpFC0tCdU+8zlULTRgqaYfrS5s3bp9nnAcZkD9iFpqOFYCcg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=eOYpMrBI; arc=fail smtp.client-ip=40.107.15.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k8QVMIT/uw2GvgobKTbMt/OTchqjaxQPer+Dy2lfn1ceNvaSxlibHkBKnI/46Sf04ao2gEpufMnirilSzHsQSncu658ocLSQkTgIhuZ7ivFRPQTcBPtE/+OBk+cAkSU3r0pQHAAd+7suDEPqCSDu9UJcKU7bs829suhiNvWIEP3l/AkIfFflyhgxmJ2CiUD/B31AmMB2VZTXjy9ACWct1dBnWctqnXLtAGVX8LvYdePk/GdUH+SMmMHppGzAO+IFFSZhBLBCrXJASzlCusKDsg8e2zNqq8CHw50TpLzCv6MCLpNG1j6OtnpU/wrgbdQrc5LUm7fc3c6Mo7nv6tADSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b0ulcU0UgSJifHHm7A5J71+Uifs30gHXkzxczWPYpgQ=;
 b=a5Vdmc7P4hgfyBGkDDZxIWw974MfvFM/7/spZPGdrAP2mxkFpMhJDi43L5lPE1kRBY+7T/fECqIuHYQ/7YSMPzEMg3B9DO94w5g5lFH0BOEI9Thmf32OdRYzymsFEaUKLZbopnh1KZ54+XT0NiLPK6dfSCrGBW/XTTl2xRxrwCGdCXW1zDCYgNDQuV3IuNdUuesqclvtoH7r1VS0vT13Uin1ZqIHX1UPHEeGamwDZtDTj5ypboVTqOqvpKjPiYUbxXE68Jt1asipEWu6QdOc3bb7xfmISA5u/bhCjbxfzvXaU3YQARlgKZ+wWJ5dZ9Eu3Baewav7U4rICtQBUcBOUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b0ulcU0UgSJifHHm7A5J71+Uifs30gHXkzxczWPYpgQ=;
 b=eOYpMrBITXwaXRj4lV59090EFr/nAv/KcJnhu3G7Q4Cjs31uhMca9W4ETjHX5mfWJhZV/YsW4eWV1XDqz3a0Xqtw1v/jytnLl37mwNrHXgSJYAff1ZewYYoRfL84Ef97Fx88cgCryq8G1Yns4FxVSIn9Oj89OjzgbTGsoeQmKrE=
Received: from DU2PR04CA0046.eurprd04.prod.outlook.com (2603:10a6:10:234::21)
 by AM9PR02MB6625.eurprd02.prod.outlook.com (2603:10a6:20b:2cc::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41; Mon, 6 May
 2024 14:41:44 +0000
Received: from DU2PEPF00028D04.eurprd03.prod.outlook.com
 (2603:10a6:10:234:cafe::89) by DU2PR04CA0046.outlook.office365.com
 (2603:10a6:10:234::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.41 via Frontend
 Transport; Mon, 6 May 2024 14:41:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D04.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Mon, 6 May 2024 14:41:43 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Mon, 6 May
 2024 16:41:42 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v3 3/3] net: phy: bcm-phy-lib: Implement BroadR-Reach link modes
Date: Mon, 6 May 2024 16:40:15 +0200
Message-ID: <20240506144015.2409715-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240506144015.2409715-1-kamilh@axis.com>
References: <20240506144015.2409715-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D04:EE_|AM9PR02MB6625:EE_
X-MS-Office365-Filtering-Correlation-Id: 551e6d2f-865b-48ca-7183-08dc6ddaa626
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|82310400017|376005|36860700004|1800799015;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RmlhYldYQk5JVXY4amVINE9sWGF4SWZJZkx5dUoxdHk2Vlo1cDZoc2VOVDlW?=
 =?utf-8?B?ZVJBSDlabXhZaTRORmxSQVArVlB6ZGZXNVN6MWhEZ3Npc2g4Zno1ZGR1OGta?=
 =?utf-8?B?NC9zVUNsMWZzbUtZUlJpdUFFbXFBb3Z2SkRFTENzNnArU2ZEZG1FZ1hURlYx?=
 =?utf-8?B?N2FJZ2lEKzhEbTFsMjJ4eitYV3F4bWtsYm5lSlJ1YldrdFZzRTBReGNNZW1L?=
 =?utf-8?B?aFNSdTdRM3F0RStTb0dWWjFCN3FrWVJMeUI5Ymh4Z0pKT0pFc0VneGlXWUJX?=
 =?utf-8?B?TW9HMUNvejgzWmtQUW8vbTRMNW41WGVkZTZqVjV1S1FiNU16dzA5clhuYStP?=
 =?utf-8?B?VngyVllRRHNOVFVVV0haQ21aM0xWc0kwRmdGMnl2SEpiaThWZzQzNDdVY1ZN?=
 =?utf-8?B?YS9CMmFsbjFyNC9qUzJZbnIyUzFTdXJjUFFxTUFIZG1kbEZEdm1YOXI5VDB3?=
 =?utf-8?B?RFU3NWlMVEkrSS9aK081eXFPaENMRllmdVlGREg3NTAwdGd4MmhBZHcrV1RJ?=
 =?utf-8?B?d2VGQ1NzdmU1dnNYMUFvclZqbHZMZ2RFdHgzTzNsYkI1SndoTlBnVHpvLy9I?=
 =?utf-8?B?OFE2N0lSQlJ1N0FGUTdkZUNlRTF3WDRpMjZhY1hIRExmREJWNE1yeENUSzBF?=
 =?utf-8?B?NUVZZjdTL29HaDNlUktGUnNNMXBuYWhCTnhZa2ZLcmdBdWtsdTlidkI5NDNy?=
 =?utf-8?B?K3J2YjdWd2xDdTVMQldRYWFZTzNRSUVOMkdIZml2L3diR2FETWVJZ015d0Rr?=
 =?utf-8?B?VmNGZkVKZllyZ2dVQ0VIREF2L3gxYXFyYm5FZGdsNEpuYm1YbmIyN1JUQmpv?=
 =?utf-8?B?L01ZWTJqdXZ2eVFRU3R6dVQyWDA3aGhraGJjZUd3Yjc1akZZTUN0NW5vbXFi?=
 =?utf-8?B?TktCcjQyU1hSR0NqbnVsNWlRRWNzQVkzL0RPdUNmeFZUdWRNU0ZaRXVldzFx?=
 =?utf-8?B?VFZNbi8ycmVpK29PMmsySU9DWS8wdC9lOFJPUG43djUrVktobkZ1K3F2ZE9k?=
 =?utf-8?B?eDFYU0ZyODFJTnUwMloyWG12aHF5NHdSd2NqaExVUkZmMnFEb2F4OXNxOVh0?=
 =?utf-8?B?cVgvQU0wU3NzVDlOQ1BoZHBRQzM4c3RFN01Gdmt2bE5FUUFwNDFFOUZQZVh4?=
 =?utf-8?B?dHMrUUZoNjMxSGpEQ2c4d3hlUHg5U09IZGt5K2M2SGhuRW5CR3A1V3pkT2JX?=
 =?utf-8?B?blI5VVJQQlgzYnk5aW1oNmpDcnBIQ1dCL3dUaFVTMlFYaHRveS8yUGVCTTZj?=
 =?utf-8?B?Ly9IenYzWUwra2czdi9zZVMxYXd3ZzRnUlN5M081TWExc2ZzVjZvTGU4Qzlr?=
 =?utf-8?B?U1g5Y2xxNjJoa2EwQ3pDVDNFU2xpVGx0aldYVys1T1VObEVIN0RRWXk3bDF0?=
 =?utf-8?B?QThNWCtheWdqZFBiLys0YkxTSFhobG1PeVNjRjg0bGlVWkRmV0FjWS9EaTRZ?=
 =?utf-8?B?WXQ3S1h3WFBBTmU4UEk3L2cyYytxdDdYamdwZ1JEdnBxTkhWbDNyTE5pUGVD?=
 =?utf-8?B?ajRwMTVsaUxjZUlQUWF1WHpBNHpKMUxIbkdzN2hpQkpWVERlWXlGTGsvSFpF?=
 =?utf-8?B?YUtjUGtYMzdCamNBZVhhOWo2Q09qS2NUdlIzQ24xNFVieGxFTmNBaXVIMlgw?=
 =?utf-8?B?eHJqWnpPaFNmY2JWbHRibFE4YVhxN2JVWFAwalc1UGdTNnh5SkthRTBqOWt4?=
 =?utf-8?B?T21KVHBwQkxXWWx4WVprMkhZZWMwaFBQcXp2Y3YyME9hZm5sOS83UlN1VlRx?=
 =?utf-8?B?UHc0VEtCQkhKbDlIMGh6dXZQcU1rdmtDZkZ1eEVtVlZuUm5mcXdhc0gzU1dS?=
 =?utf-8?B?a1hNNkhPWjJyL01od3FZOHEzcHpZdzFxMFR5MjRXYmYveUZDTENxVDZ2U21l?=
 =?utf-8?Q?nlhQeMIq9sraJ?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400017)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 May 2024 14:41:43.6821
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 551e6d2f-865b-48ca-7183-08dc6ddaa626
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D04.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB6625

Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
Create set of functions alternative to IEEE 802.3 to handle configuration
of these modes on compatible Broadcom PHYs.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 drivers/net/phy/bcm-phy-lib.c | 122 ++++++++++++
 drivers/net/phy/bcm-phy-lib.h |   4 +
 drivers/net/phy/broadcom.c    | 338 ++++++++++++++++++++++++++++++++--
 3 files changed, 449 insertions(+), 15 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index 876f28fd8256..9fa2a20e641f 100644
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
+static inline u32 bcm_linkmode_adv_to_mii_adv_t(unsigned long *advertising)
+{
+	u32 result = 0;
+
+	if (linkmode_test_bit(ETHTOOL_LINK_MODE_1BR10_BIT, advertising))
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
index 370e4ed45098..2d8898fd2228 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -553,18 +553,46 @@ static int bcm54810_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
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
+	*data = (reg & BCM54810_EXP_BROADREACH_LRE_MISC_CTL_EN) ?
+				ETHTOOL_PHY_BRR_MODE_ON : ETHTOOL_PHY_BRR_MODE_OFF;
+
+	return 0;
+}
+
+static int bcm5481x_set_brrmode(struct phy_device *phydev, u8 on)
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
 		return err;
 
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
+
 	err = bcm54xx_config_init(phydev);
 
 	/* Enable CLK125 MUX on LED4 if ref clock is enabled. */
@@ -576,18 +604,16 @@ static int bcm54811_config_init(struct phy_device *phydev)
 			return err;
 	}
 
-	return err;
+	/* Configure BroadR-Reach function. */
+	return  bcm5481x_set_brrmode(phydev, ETHTOOL_PHY_BRR_MODE_OFF);
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
@@ -601,6 +627,56 @@ static int bcm5481_config_aneg(struct phy_device *phydev)
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
+	if (brr_mode == ETHTOOL_PHY_BRR_MODE_ON)
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
+	if (brr_mode == ETHTOOL_PHY_BRR_MODE_ON) {
+		/* BCM54811 is only capable of autonegotiation in IEEE mode */
+		if (phydev->autoneg)
+			return -EOPNOTSUPP;
+
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
@@ -1062,6 +1138,234 @@ static void bcm54xx_link_change_notify(struct phy_device *phydev)
 	bcm_phy_write_exp(phydev, MII_BCM54XX_EXP_EXP08, ret);
 }
 
+static int bcm54811_read_abilities(struct phy_device *phydev)
+{
+	int val, err;
+	int i;
+	static const int modes_array[] = {ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+					  ETHTOOL_LINK_MODE_1BR10_BIT,
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
+		return err;
+
+	if (brr_mode == ETHTOOL_PHY_BRR_MODE_ON) {
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
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_1BR10_BIT,
+				 phydev->supported,
+				 val & LRESR_10_1PAIR);
+	} else {
+		return genphy_read_abilities(phydev);
+	}
+
+	return err;
+}
+
+static int bcm5481x_get_tunable(struct phy_device *phydev,
+				struct ethtool_tunable *tuna, void *data)
+{
+	switch (tuna->id) {
+	case ETHTOOL_PHY_BRR_MODE:
+		return bcm5481x_get_brrmode(phydev, data);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int bcm5481x_set_tunable(struct phy_device *phydev,
+				struct ethtool_tunable *tuna, const void *data)
+{
+	int res;
+
+	switch (tuna->id) {
+	case ETHTOOL_PHY_BRR_MODE:
+		res =  bcm5481x_set_brrmode(phydev, *(const u8 *)data);
+		if (res >= 0)
+			res = bcm54811_read_abilities(phydev);
+		break;
+	default:
+		res = -EOPNOTSUPP;
+	}
+
+	return res;
+}
+
+static int bcm_read_master_slave(struct phy_device *phydev)
+{
+	int cfg, state;
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
+						 ETHTOOL_LINK_MODE_1BR10_BIT,
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
+		linkmode_mod_bit(ETHTOOL_LINK_MODE_1BR10_BIT,
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
+	if (brr_mode == ETHTOOL_PHY_BRR_MODE_ON) {
+		/* Get the status in BroadRReach mode just like genphy_read_status
+		 *   does in normal mode
+		 */
+
+		int err, old_link = phydev->link;
+
+		/* Update the link, but return if there was an error
+		 *  genphy_update_link() functions equally on IEEE and LRE
+		 *  register set
+		 */
+
+		err = genphy_update_link(phydev);
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
@@ -1212,9 +1516,13 @@ static struct phy_driver broadcom_drivers[] = {
 	.get_stats	= bcm54xx_get_stats,
 	.probe		= bcm54xx_phy_probe,
 	.config_init    = bcm54811_config_init,
-	.config_aneg    = bcm5481_config_aneg,
+	.config_aneg    = bcm54811_config_aneg,
 	.config_intr    = bcm_phy_config_intr,
 	.handle_interrupt = bcm_phy_handle_interrupt,
+	.read_status	= bcm54811_read_status,
+	.get_tunable	= bcm5481x_get_tunable,
+	.set_tunable	= bcm5481x_set_tunable,
+	.get_features	= bcm54811_read_abilities,
 	.suspend	= bcm54xx_suspend,
 	.resume		= bcm54xx_resume,
 	.link_change_notify	= bcm54xx_link_change_notify,
-- 
2.39.2



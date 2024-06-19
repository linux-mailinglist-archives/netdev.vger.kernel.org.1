Return-Path: <netdev+bounces-104914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 541BB90F1A4
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 17:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2144286F6E
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 15:05:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D8871514DC;
	Wed, 19 Jun 2024 15:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="L8XKfWyM"
X-Original-To: netdev@vger.kernel.org
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2044.outbound.protection.outlook.com [40.107.15.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FABA3FB8B;
	Wed, 19 Jun 2024 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809474; cv=fail; b=AkFbABlBXKYlJKfZ8UYqfZbfb6fKG4ReH1toDhZ95Oix7O1JD4tJM1J+CR2JitMO8nX8L5eCqK31q4xrdAq7jX4a4yt6iF+eT3rb1s7iQht5P9a3ttctazIq1gYoRN17Dyj6i27Yh49hi7UoyV5DVzR/wSkzIGt9+DnnAEAs0t8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809474; c=relaxed/simple;
	bh=qbcXrG7lYsxdX0LUBpZ9QXbM2iVDMBGtsfZoIPFc1SY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CsIBrA0adta70SzVd3pKOS9sRnOEohcAkyoJWA8WfxFHqtOBUog9ieA11qM3t5vv/7FCSHDfR7l/xpW+EKEyDbwUrzbvuaq+WEqB3oFz/iVrVrjfoK46d2W4aC8mUYLgT785cUjzg1LaKmesZ3ZYpB4k6HlmhcJDgmWP9Fe6i9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=L8XKfWyM; arc=fail smtp.client-ip=40.107.15.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A6WGSasjwAqpTRKjjWvyp3l2Gw5JLDB9sm6O3ZVZQgstWcnlXYVI4FaljBKqx8bFEOd86PiWoDwJ0XnMbk4dGTZf7VJywDBzHjQI+UYHE2kQ6zWMm9GOaffOyBi6yBAPBPj0KP9zjWUvCJ4welOyxH8msrMTfgXVasXHPzXFulkDu8OTCeSoucvGazNN5+yfjj0sWrHzA67rZ2J56jQ6WzQXguCNMHF4XYhBeImC2WoHq/ZNMYu78UZtNIAn23L2vHuRmtQ5oRo0mCIU/Kp71W8HlPg3mHXbKVXESUc8TKttGbH58zM8bQVqWQjrrVY2T0N5ohAj2th5t04kcvJQVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y3Us/9dg22hsWpiRrwJDir2yIXW5gIxKsJ1tiphoG8Q=;
 b=lJiMKbU0rCafhVWKSbdLC906ewWKy+E7XzFllcko8x+uG0soEVTQOUG84BlHhPregUbDck0//itm5tEyihHZ09OIUNaqdl4vM+bHLjczOQ75c+HFs2ZZ8HlTwxx5hzT0KZDkIQQDTrHWgieI31KHce6YuaKjrMOfZx7MyZMFPO2pomSEFdqQRjpY4pIbSbvsOc8YDI95fKvlP6CAZ2ekSSpD4dClKhWFWw3OuzHcf297tiKmTm4T/b5eivW4BL2PFJGcAabHowMxhHtLgoLJCeSH1pdkM+d3TrAzgybaQQf0w4xhMnNjhyfzi3gRLEFuTXCHJiDKuEY5k2kZYuoYUw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=y3Us/9dg22hsWpiRrwJDir2yIXW5gIxKsJ1tiphoG8Q=;
 b=L8XKfWyMBf34t3FXs54+uyUqDBfNXje815d0azFsjzVlm6tc/yOTCGdSWuMC2RAlLTesR5NTOpx6+G6pgxvXXgR10ZzRySB4jgKPrQWm1Ctlmp9Bc4eUzVtBMUAoJZ+FqzrCY9XSDfBa+GoomASnJEtBV+Y2aWxMIIIJvKJKbTA=
Received: from AM0PR02CA0228.eurprd02.prod.outlook.com (2603:10a6:20b:28f::35)
 by VI1PR02MB10268.eurprd02.prod.outlook.com (2603:10a6:800:1c6::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7698.19; Wed, 19 Jun
 2024 15:04:27 +0000
Received: from AM4PEPF00027A64.eurprd04.prod.outlook.com
 (2603:10a6:20b:28f:cafe::3d) by AM0PR02CA0228.outlook.office365.com
 (2603:10a6:20b:28f::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.32 via Frontend
 Transport; Wed, 19 Jun 2024 15:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A64.mail.protection.outlook.com (10.167.16.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Wed, 19 Jun 2024 15:04:27 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 19 Jun
 2024 17:04:25 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v8 4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach link modes
Date: Wed, 19 Jun 2024 17:03:59 +0200
Message-ID: <20240619150359.311459-5-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240619150359.311459-1-kamilh@axis.com>
References: <20240619150359.311459-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A64:EE_|VI1PR02MB10268:EE_
X-MS-Office365-Filtering-Correlation-Id: 4337e831-7f3e-4f35-06e6-08dc90711ce8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230037|7416011|376011|82310400023|1800799021|36860700010|921017;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?Y3RNNXVZTDVUTTBNcThYQ21qZm1KWmFwTFlHbTlLZ0MrWkUyaWRMSHJNMmx3?=
 =?utf-8?B?bnV4cHZWU0R0MmFtNHR1N2dFb3JPbU1ycWt5c0FQTGU4dDJXdU1CUTZZdTFu?=
 =?utf-8?B?cnhRaXozcWJDYzRzSjlZeHNGMzZFYVBnSDJqUFB5c0JoQ1JSbjI5bkw0MzNh?=
 =?utf-8?B?cG9qNkJFK1pOTEdDMDBURTZLeklTM0RXTk5ZQVh5MjlqeUJYYTZPdFJEVHFm?=
 =?utf-8?B?WGZra3lsVzVvSW9hTWtpN0h4cDMxQVBYWTE2WnBvWTRxUjNmeVRVOTZuaTNi?=
 =?utf-8?B?aEFwOE94VjBhNHF2TE80ZVZIcm5NWDNQdWVRVEc5L2ZHYmYwR3NuT1oydnVn?=
 =?utf-8?B?c3p1bGI4OVFkNWxZcktBOGtpaXJkZ2oyY1A4Q2FIZVNLcENZR3Bta3g5TnBT?=
 =?utf-8?B?VFVJZnFtQjUvdUhkc2ozWlQzVE5lZnpqWnZoNlRCeEJtemg5WGFueisxNUV3?=
 =?utf-8?B?N0ZqZnpSNUJzRmwvZitsRGt5Y2RmcnNWNmt4YkFKR2Q0RytvUU1TQVdyY2ph?=
 =?utf-8?B?dCszR0F1eCsrYTVUSFM2UUFMUlpNT0xEbzVUT2tLcU05TDR0RXA4c2RETE1y?=
 =?utf-8?B?UVA0THZGZXlhajN0VDlLVjFKTlZmYkVhU3Fzb1ZvRVorZ0QvN0N1MEZCSG83?=
 =?utf-8?B?ekJKWDIyMElWMmFoejNlcHdvUENOQWI1WWo5SUhiMEdBNzd2MEt2REJsOFp0?=
 =?utf-8?B?TmtlMSt5YVVKc2dLbWp4SFcrYUZLNFBUVndQYjdiTStyRmwxUFl6WUtsU1VX?=
 =?utf-8?B?UHFxaVhVaWEvT09nckhKS3JIK0E4NktTc2ZpRnJzSElpTXZJbUFzNVRQQldv?=
 =?utf-8?B?Q3FuTGp4dDZ5c3QyUmtId3IvNEFVSEtKUWFrdlhDQzB1R1R0bCtZUE9jd0hF?=
 =?utf-8?B?K3AzUGx1ODB6SUZyQlJjNXExUUNRK2ZZRlZpenVMRE95Q3VvaGhGQ3plUGR2?=
 =?utf-8?B?UGNYbkZPdEtaZUlZTWlyWXdNZXdTSk1ZTTd3ZURFSTV1Z1ZjSmNZVDUycWFV?=
 =?utf-8?B?YlhPb21yODl1a1kzdUUwY2NFMWNpR0dOTUczS1k4eVRqNzVhRjZ3YmEwU2ZJ?=
 =?utf-8?B?NmZmVzdnaEQwNFdZMG81UE9XR3dkWlZHU3JEVXp4SjNPWFZsd1dBU0Y0ZzN1?=
 =?utf-8?B?YmNLK28wV2RwUVdiM2FmUUt6V0VLcjBUZEhlL0RjU3BtVmROU1llNktSTmFI?=
 =?utf-8?B?Q2tmZmpJa1ZBOGVaYnN6Mkxzc1JwZkpDdWQrczNmVzRweG44dDhyK2w1eWdw?=
 =?utf-8?B?T1B6QlVzbmtkdVIvb2tnNmpvN3NhbUdsQUxIQkVMMVpDSlU5R3ZwelRKZ09C?=
 =?utf-8?B?Y1hmNEtuQWh6RVArLzlybVVjTjhiUENXOVYrUzd0OXVNbFZsVm9KeURIWmln?=
 =?utf-8?B?WkIxd0pVV0lIS3VVMkJham0xRDRrZUp2Z3lJajd6ak1YZ1ZCQnJxenJRWWhM?=
 =?utf-8?B?YW1WTUJGdHJTU3ZsWDF6Ry80d2hLNkFpbVJNcTI4bDlobDhSZWJIS1Q3WUJB?=
 =?utf-8?B?QkVMTEFqUjdhcmNVMG5mNDZyOC9MWFBvVC9DT1VoNzkyN3pSa2JkKzVBWUtD?=
 =?utf-8?B?V1dqTkVIRFM0Y2lTNVFBb1VHQUt4SDFYNmVnVVVUeEM3UENwQ0FpLzZGczRD?=
 =?utf-8?B?M2NSd2tVQlpxdW54eGFWTHo3ZWJHdEVGQVp6b1VtQld5VU9JRWNkNUErdFhZ?=
 =?utf-8?B?RWdGc0QzVUY0Y1dyOUtpYmlQclczUlFOc3hyM1E5RTlqMEVScFN3ekN6aitS?=
 =?utf-8?B?VHhOMlBqbFJTTXBjeWcrNkEzY3JqSWFDTXBmZDd2OFZrL3hobjJRWXlHelVm?=
 =?utf-8?B?Y1c1VVFYOWFOdUdWajMzdEFiL3MwVHM0RTd5VDVRZGhtWnRuWkhkNmJCb1FT?=
 =?utf-8?B?WU9Ca0ZYdEZTeldBT0VETE9ZWDkra1NKcVJVTmdEUjl5YndiOW9mbEZBU1hH?=
 =?utf-8?Q?Vya0Z3F22e4=3D?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230037)(7416011)(376011)(82310400023)(1800799021)(36860700010)(921017);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2024 15:04:27.0127
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4337e831-7f3e-4f35-06e6-08dc90711ce8
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A64.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB10268

Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
Create set of functions alternative to IEEE 802.3 to handle configuration
of these modes on compatible Broadcom PHYs.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 drivers/net/phy/bcm-phy-lib.c | 113 ++++++++++
 drivers/net/phy/bcm-phy-lib.h |   4 +
 drivers/net/phy/broadcom.c    | 392 ++++++++++++++++++++++++++++++++--
 3 files changed, 491 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index 876f28fd8256..8d431c9c398d 100644
--- a/drivers/net/phy/bcm-phy-lib.c
+++ b/drivers/net/phy/bcm-phy-lib.c
@@ -794,6 +794,47 @@ static int _bcm_phy_cable_test_get_status(struct phy_device *phydev,
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
+ * @return: LDS Auto-Negotiation Advertised Ability register value
+ *
+ * A small helper function that translates linkmode advertisement
+ * settings to phy LDS autonegotiation advertisements for the
+ * MII_BCM54XX_LREANAA register of Broadcom PHYs capable of LDS
+ */
+static u32 bcm_linkmode_adv_to_lre_adv_t(unsigned long *advertising)
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
@@ -1066,6 +1107,78 @@ int bcm_phy_led_brightness_set(struct phy_device *phydev,
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



Return-Path: <netdev+bounces-103236-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D48190738B
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 15:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00032284E1B
	for <lists+netdev@lfdr.de>; Thu, 13 Jun 2024 13:24:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5AE41487E7;
	Thu, 13 Jun 2024 13:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="XgjXWRHX"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2082.outbound.protection.outlook.com [40.107.8.82])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DCDB146D68;
	Thu, 13 Jun 2024 13:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.82
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718284885; cv=fail; b=KecyyIDwPf7qRkIlF6ks+YEJlQ8wjHTyFi8/yn6TrdgiY2Kf9dv3nuRSjDCf37ocvkOP0WLn8JzDEqwfvHywZzpRDRY9aDzeTfeYnrqsvq32ShYg3RsLIXWsl6eZ1TRBamwrN388ffuQrNJ0ijUrCfLgoF9tYXdwClOt6Tfd4k8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718284885; c=relaxed/simple;
	bh=DVN3AcsuRd1Lcf5zwtraMqxQtwS5ft09RnQyXEWbn2k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=L35q+kSxHqVHdYFaXQKnnDdF89fRWMylPWR6iTFcVzKMb9QQ+pdQr/a0n6LbvpARliyyc1lgTqmG5tlQv+LmCIbWsYsn0J3Zffl+NIiEdok7lfuNSyPCsp8h4/0TmpLCRcpR9IsAQVNPPnxhCnOZUjacFXEai2RMNbytJ6oyoFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=XgjXWRHX; arc=fail smtp.client-ip=40.107.8.82
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H8GYDcjCr2TMXoHb9OMwrXQyMJ5v4i/N1/r71+ti2YEnL2DW4AC0WdnJyhUKL8LuflBhJrdfnWScQ9sbM9FWSoFdB1WErY/0E9kbXS22nXG1CpHtfw8YxbaR/cSyt/Aww63cmKmT4tKUJlPUXGBrUPMkFSz26U9y23T3or4hU5OgcVt5QX7kUdu1yeKanyj0RFpX1DFa4aix76H5UeBKldks8SkBTdjdZ995OLi3S77g7smcfjc+FzLjfvC3ArNKoenI3+jLz+U5Tg2oqh6KogKpSbn0L+kxVTRaOEuZN0Gc9PN/Ju/mGfiCSUG+PB8VSDz6LO6IyFwCCRVpHtWo+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CyvhM5VOdfGB4pjx3N7f6K49eekDkH8HiZPEBKe7ius=;
 b=Axjp6XCd3EXI5bQ3LmXIktq9e58GfNf3D0GbM5/6asC+c8GyqlL5ondHVtlzJrcFiymYR/+mciJCEP6gNWFAP320M2PNHCj98DR0cctzTK1MLx0sQTcESi3CSr//qHDzuJFm/tMVy04s2nPAk/3TMA/XF5PUhVNo9wT9SERnjiaMi2Fr3Fja/HueSHZxw5/RUrHy9G0aPFtHeZOQBJcpxcELNbtFavjfxcdwvCzPHimSLa9LdCLqilbiSARGDOCxi8vj1AbgzbFoVH6+IwTIB0r4aB7WwqKWODw14V9QfNYlH+oTbcdUyvpFSUdnIf5ZeGPfMUYiH1iEOTe8R1b6yQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CyvhM5VOdfGB4pjx3N7f6K49eekDkH8HiZPEBKe7ius=;
 b=XgjXWRHX3wzJfEk7tUZwsTWKaYrN46Xhlg+LWgGttMZLRWxiWVhR03LbXtjGcND7JAHBeND7FJN7bLg5VwBiFZRmznMDkgqI0Vn0Azsm/zZxMRoxuPxns+EFfPLQGael78vOmx5O78a8+b+W8Iq8DZm1YN+YoFays94KqSe7Hko=
Received: from DU7P195CA0022.EURP195.PROD.OUTLOOK.COM (2603:10a6:10:54d::16)
 by AS4PR02MB8432.eurprd02.prod.outlook.com (2603:10a6:20b:577::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.20; Thu, 13 Jun
 2024 13:21:18 +0000
Received: from DU2PEPF0001E9C5.eurprd03.prod.outlook.com
 (2603:10a6:10:54d:cafe::be) by DU7P195CA0022.outlook.office365.com
 (2603:10a6:10:54d::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7677.24 via Frontend
 Transport; Thu, 13 Jun 2024 13:21:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF0001E9C5.mail.protection.outlook.com (10.167.8.74) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7677.15 via Frontend Transport; Thu, 13 Jun 2024 13:21:18 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 13 Jun
 2024 15:21:17 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v6 4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach link modes
Date: Thu, 13 Jun 2024 15:20:55 +0200
Message-ID: <20240613132055.49207-5-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240613132055.49207-1-kamilh@axis.com>
References: <20240613132055.49207-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF0001E9C5:EE_|AS4PR02MB8432:EE_
X-MS-Office365-Filtering-Correlation-Id: 45fa8b32-8f46-4242-af29-08dc8babb5b1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230035|36860700008|82310400021|1800799019|376009;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?aEFHNjl4V3lXdHZtSDdxVEFXdXZXZ1o2NzlDbDNwVUFwZzRGcWxwSjVHOUs5?=
 =?utf-8?B?MmU2NVo4ZWFrZ25EZ2MrNlNSeWtQQy91cVBvMVhQVlFFS3NxR1h3eHloeDg3?=
 =?utf-8?B?Z2ZPdmJpdVYzd2UvTmZjMWQyZTA5RVkzZnpXVm00TUhSUVZGcFA4emxYRHJU?=
 =?utf-8?B?US85SFd3VmNQVys5dm83Vk55dW1FbjJpODRwMDRUWVNqYzhrSEt0ZGV3U0t0?=
 =?utf-8?B?QUdsN21OUVJNeDZQMm15aGVTdENTMXFQcC9QS0E4MWJ6dVcrMVRDeUVKaXgx?=
 =?utf-8?B?Y1JVZms5eXNpekRUN0VvWjdPS0h5YWZJcFAyWGxwVzFaRnBHL0FUaHFzVk9V?=
 =?utf-8?B?RktSSGZGVnhxZVZlRWxaY2RQVkNWTENHQ1g3ZFVlQTJQb2E4R0dBMVZzVTBO?=
 =?utf-8?B?RkphY3Z3SGpEUGw1ODdDanhTcFA0UnM5bloxM0JZZ3F4OURmMHc5aGZ2blVI?=
 =?utf-8?B?MEovTDJuZElJQ3ZFODVqYVdJME12ZU0ycTRkTkE1UUdKUnI3K0YvM1ZvY0k5?=
 =?utf-8?B?UWtKeWoyL21FWU1vRHpMRFFIcGZxNllxTWVyNW5SWnBobnpWSUZLQzNCKy9y?=
 =?utf-8?B?OHBMVkt1TUp0azltMWNlcWhGUWJnYmptUmZuR3BVdC9kTmJwWlVlTGl0cWpC?=
 =?utf-8?B?bGJRWTZGS083ZXVnV2N0TTQ0WkUzbXBWOXBTUlpMYnFONXR6NUptaXdJZGJu?=
 =?utf-8?B?RlBHc1cvU0FDRGhhMzhIWjhrU0Flc2ZxNVN1TmlQOHhKNXBmVDhXOTV0NGVN?=
 =?utf-8?B?OVRlUk9CUVl2WmJYM1NGeXdhUVNDZ0wvL3NNcSsxbzJmT3MxZXZCZXpYTzF6?=
 =?utf-8?B?eDVhU2w4RzNHNWppUS9yU2NqRnNmZVRMUjBMWTMwVGRRaUgvbVovSTVINitj?=
 =?utf-8?B?TnlOQWxRMVBiN0oyOGtvaERRcE1uMFc2YmVTc3BKanhNUDNtVUxpL252Z0JO?=
 =?utf-8?B?eFNORUNGdU55STZiQmJiUkU2SlU3YWNHUSs5dXovaTh2aFA3OTIwdUZCVEhp?=
 =?utf-8?B?a3l5amc3T3VMUWZ4bVlYekUxK2JzaFpxV2YwNWpkdWZiVW8wZUF4SEVtbmN5?=
 =?utf-8?B?SjVJZSt1eFRaWjVkRHBQd0ZCZWtBVzFMVHlFNFJvVUM0dGMrYTl1NjkvNmRw?=
 =?utf-8?B?bTg3SGhoVk1QcHRxVlRlT3pmTy8zTkNJUFdQVzhhRVFZTkk0cDBIU3J5aXI2?=
 =?utf-8?B?UGxuVzErSmxlZWhjWnhZTE5Qc1pZZ1V4REZaMUdDR1JNVVlDNXVTVXdpb0w2?=
 =?utf-8?B?dDBOVW1TOERvTFJUQ0h2Zm1qRnlNMGdJb2dpZ2Z1bVkzc2Q4MVNScENIZXZX?=
 =?utf-8?B?eHNhMitKNHRkSlEzUUJoUXUvRWZxaXgyNDQwbzhRbktXM0tteGJYYlZ5cmRL?=
 =?utf-8?B?Q2c0dFFDYnU1Y2VBRDZISEhUajJBSERDdUpRTjJDdVdtZFBjTDAxWlU3a3Vl?=
 =?utf-8?B?STBwZC9odUpHWTdDR0FjOGNJQzJVa2dPS3AxTEd0alNzL1JJRjM1SWUzS2M0?=
 =?utf-8?B?ZVJZYlplYVVrU3lUUFZmblNGbk83TTZ6NWduZ01qdkNtcjMvRGd0QXFLMXdH?=
 =?utf-8?B?eVROSmZZejhkd3U3VTZoVVROQldvSWF0NVB2bUh1QS9jQmNjVDkwNGVnRUtn?=
 =?utf-8?B?TC8zak0vc3YrR0lPM2owekU2b3g0dy9yN01hRm1XWVRWVVQ5aHQvYk9xcWNv?=
 =?utf-8?B?cURwM0d2WUg5WGcvSmRsV0ovSE9qbzAzVm1xa2RDeEtzTTBlQjIwYVZPeHJj?=
 =?utf-8?B?UHdZeTBaby8wclUyUXJmbUllYUFQeS9HSk5tUTlMY05mdVNuNXpZV083RHRj?=
 =?utf-8?B?OTFoTnNEV3poaU1kZ0NGcE9TdnQ4NjMzQnV4cG9hVk4raXJkY2oxQW1uMHA4?=
 =?utf-8?B?RWZUTG84N1pkN212bThEbm9SUUFqVjE1VFZkZjhqVEdhOEE9PQ==?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230035)(36860700008)(82310400021)(1800799019)(376009);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2024 13:21:18.2975
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 45fa8b32-8f46-4242-af29-08dc8babb5b1
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF0001E9C5.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB8432

Implement single-pair BroadR-Reach modes on bcm5481x PHY by Broadcom.
Create set of functions alternative to IEEE 802.3 to handle configuration
of these modes on compatible Broadcom PHYs.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 drivers/net/phy/bcm-phy-lib.c | 125 ++++++++++++
 drivers/net/phy/bcm-phy-lib.h |   4 +
 drivers/net/phy/broadcom.c    | 370 ++++++++++++++++++++++++++++++++--
 drivers/net/phy/phy-core.c    |   2 +-
 4 files changed, 483 insertions(+), 18 deletions(-)

diff --git a/drivers/net/phy/bcm-phy-lib.c b/drivers/net/phy/bcm-phy-lib.c
index 876f28fd8256..e4f1766cbc10 100644
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
@@ -1066,6 +1107,90 @@ int bcm_phy_led_brightness_set(struct phy_device *phydev,
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
+ * @return: 0 if the PHY's advertisement hasn't changed, < 0 on error,
+ *          > 0 if it has changed
+ *
+ * Description: Writes MII_BCM54XX_LREANAA with the appropriate values,
+ *   after sanitizing the values to make sure we only advertise
+ *   what is supported.
+ */
+int bcm_config_lre_advert(struct phy_device *phydev)
+{
+	int err;
+	u32 adv;
+
+	/* Only allow advertising what this PHY supports */
+	linkmode_and(phydev->advertising, phydev->advertising,
+		     phydev->supported);
+
+	adv = bcm_linkmode_adv_to_lre_adv_t(phydev->advertising);
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
index 370e4ed45098..5e590c8f82c4 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -5,6 +5,9 @@
  *	Broadcom BCM5411, BCM5421 and BCM5461 Gigabit Ethernet
  *	transceivers.
  *
+ *	Broadcom BCM54810, BCM54811 BroadR-Reach transceivers.
+ *
+ *
  *	Copyright (c) 2006  Maciej W. Rozycki
  *
  *	Inspired by code written by Amy Fong.
@@ -553,18 +556,97 @@ static int bcm54810_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
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
+	static const int modes_array[] = { ETHTOOL_LINK_MODE_100baseT1_Full_BIT,
+					   ETHTOOL_LINK_MODE_10baseT1BRR_Full_BIT,
+					   ETHTOOL_LINK_MODE_1000baseT_Full_BIT,
+					   ETHTOOL_LINK_MODE_1000baseX_Full_BIT,
+					   ETHTOOL_LINK_MODE_1000baseT_Half_BIT,
+					   ETHTOOL_LINK_MODE_100baseT_Full_BIT,
+					   ETHTOOL_LINK_MODE_100baseT_Half_BIT,
+					   ETHTOOL_LINK_MODE_10baseT_Full_BIT,
+					   ETHTOOL_LINK_MODE_10baseT_Half_BIT };
+	int i, val, err;
+	u8 brr_mode;
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
@@ -576,29 +658,79 @@ static int bcm54811_config_init(struct phy_device *phydev)
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
@@ -1062,6 +1194,208 @@ static void bcm54xx_link_change_notify(struct phy_device *phydev)
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
@@ -1212,9 +1546,11 @@ static struct phy_driver broadcom_drivers[] = {
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
-- 
2.39.2



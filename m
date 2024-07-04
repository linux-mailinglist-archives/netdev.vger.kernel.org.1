Return-Path: <netdev+bounces-109234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1FF99277BE
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 16:05:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7007F286C23
	for <lists+netdev@lfdr.de>; Thu,  4 Jul 2024 14:05:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3FA1B11F6;
	Thu,  4 Jul 2024 14:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="naFWB5q3"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11013044.outbound.protection.outlook.com [52.101.67.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EB61B0123;
	Thu,  4 Jul 2024 14:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.67.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720101900; cv=fail; b=lOTRQcIgF4zHkXL+k53bEoufNOBD4XfmdG0Ju94bag43Q+IJqGekPRPuDiVB78U6Ju99gEArVhJuZJrn+I+MZZcoYLlNRnyi14ae4pflDpKHON60zMMfqEVilxSJOMBeZypFZPU54YOLblbRrxp0q5WprOKejePEwYX1qGTAjGo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720101900; c=relaxed/simple;
	bh=oFa6tEtN72nKtuIuVlVFIsXLZ6A/2PJ0IsvV+K4lNw4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jmvJhmvaN9HSz05LtAH/lSvBNx68m1ynKlKCc8/28zlj5mPlJd/y5WWTAxSyY3sGRGbGFhA6OLq2Vt+a5fxj2IjSuGKEgB6bsLM9uASRRrrlpIm8vTmBL9dcAaBb2yWdJNI76Ke+0zYZrjgj9nQvCRHp5NNYF/X3qcV7se3nm0c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=naFWB5q3; arc=fail smtp.client-ip=52.101.67.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oc4PVS3dzK7ftqVT5x/BjKbg8hwIOKP5D4azn8kjMdhty8kHJak9397VKQIFCvR2TY9NMtlGV4dhn37ja8VItpHj7vpyAmhC/ul380DfAJ5WSZunYW+AxbiZuhzsg9sMKZuk82AP9LmEpWVQYYq1tsPaxCOc7Sg0MOkl1LoOEpERHlp0jHZaS7K0ZBeLmL2gcNFQm4DYx2Z/XndMUJO4wB9DeOcy8rn4pVDbHQyXoFmbDMsNLnhDjNsBRIXYm6HczbfVMbhxgwWdmO4ZCYR3IvXnLjLs72MKJAmJ7w7RGt7Ncz5S4P1K4OWYlRb28Nn0KWEkb5uKR9U8tU9PQkYuLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXv8LCvY0wgtr9MminrtGUbRcLa8J+OJWxMUixNEWII=;
 b=LMlKCQeToQ1/yYavbGHm8ddwef9hwXahT/vveDn2dj5i6UIhMMeJ0WE9wQAT80G6kZWswJEEpzAZYTFPjBD+789gGB9l9Aj+6jqr7OHIFr1GHFG60hycTZ7f4V3Vvgunyk7/LUMrNltQA4H1aYFlQiHqBkrUOEHrCuHtK77aZyAZP5xE+U9iLuNGuv3pEAaTyls3BapEokTzs4tb24o44eIovMUPu0T+/Qd93VK+HRge/OJtQge3p3r8tQFsWRoU3Q0cgYlllsdPBTsGpaRegVuWbYMfpmljdfbTfnIR3c0dzzhfqzQDhZzPombdxj1EXGXXQk/kqtTkQRB1SFQNqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXv8LCvY0wgtr9MminrtGUbRcLa8J+OJWxMUixNEWII=;
 b=naFWB5q34Z/ScMTuYKwEXDDifS41jmdLiwqKUX7AKa/vpkfghlCdw604UExEaVcmlBPGSBcU83BvL7J8Uh3xSPK8b+QjaiyxXFVGh5oNwv/rbJkVGe/F9RkPKFe3N94j26dqoaL7O9XIN5myNFJfYrYRSPBmgXa+ZuIg/uS4mME=
Received: from DBBPR09CA0029.eurprd09.prod.outlook.com (2603:10a6:10:d4::17)
 by AM7PR02MB6420.eurprd02.prod.outlook.com (2603:10a6:20b:1c1::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.29; Thu, 4 Jul
 2024 14:04:54 +0000
Received: from DB1PEPF000509E9.eurprd03.prod.outlook.com
 (2603:10a6:10:d4:cafe::c) by DBBPR09CA0029.outlook.office365.com
 (2603:10a6:10:d4::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7741.25 via Frontend
 Transport; Thu, 4 Jul 2024 14:04:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB1PEPF000509E9.mail.protection.outlook.com (10.167.242.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7741.18 via Frontend Transport; Thu, 4 Jul 2024 14:04:54 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 4 Jul
 2024 16:04:53 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20=282N=29?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH v10 4/4] net: phy: bcm-phy-lib: Implement BroadR-Reach link modes
Date: Thu, 4 Jul 2024 16:04:13 +0200
Message-ID: <20240704140413.2797199-5-kamilh@axis.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240704140413.2797199-1-kamilh@axis.com>
References: <20240704140413.2797199-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E9:EE_|AM7PR02MB6420:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e636ee8-9b10-41d7-6f9f-08dc9c3247d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|1800799024|36860700013|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?SmhoWDQ3ZUgrOExVNS9qM1prcHNJYXVYbTdCbHZyT2QxNCt0R3piRG1iajdQ?=
 =?utf-8?B?SU1hNGZtMmpDOExRY2dQMVJLMlpHa2RrWFhYOE15UmUvTmFNVjMxeEZITy9t?=
 =?utf-8?B?MjI2TEhLWmRKa3NBOWRKdHI4RGJleWJyTHlyLy9qdVMvS3B4MXRwclBGVDVM?=
 =?utf-8?B?N2pROWpkKzduSzQ2UkFsQlBPYmkydEpneFpNVG43dlFHd21lREwxbVBkVXlD?=
 =?utf-8?B?OGJtVDkwQ0Jja2MrSlFvaHIvNlhJS2xkdnRudWpFbmh1MU4wNTR1dTMvNnVr?=
 =?utf-8?B?b2ppUzB5a093bTBBdFlnRGN5Tm1sbVNabE44OXA3NFBjRGtjMUpLeDlCRm1i?=
 =?utf-8?B?SHRiUy9PV0I1ZnliRXpWQXg1OUpEZnQ2b1MzSHN0cnBRcDRRZzFiRW9kN2FI?=
 =?utf-8?B?NnQvenVBbmJBU3ZNblcwMHV0VW9yZW9oWjlHMG9JM25OR0poWDJhTElyR2VV?=
 =?utf-8?B?OUQzUjk5MkhkWHFWVkEycW9NUWFBVmhBSUVwQ28wYisvc3g3WTJvMFU4U0ts?=
 =?utf-8?B?YUVGSDJmTC8raTN6bG5lRkg3YXVJeXQzekEyYnFWN1NUd2lhclcxbVpzaW5M?=
 =?utf-8?B?a2JBV0k3OEZWbE0wTG1HaDJBaTVISThWekdxd3FHSEFJcVpDZ3JZRm9ybkR4?=
 =?utf-8?B?UGIwTUs0NldqeGdTdndtTGhHWTZ1eFNsTkg4TDFZcVgwZEVtWHZpZ0FaL1VR?=
 =?utf-8?B?MWdrK0o1QjlOZGI1dUpEQ3FWdEM5M3kwdWdFSExNNWQwSDdrQlgrekJ5ZXZN?=
 =?utf-8?B?azhQd0hyV1N5RjZCU29iQXhHK3FSSzdpdWR3NWNYQThzM0o1R281SlEvRHA4?=
 =?utf-8?B?djVndW5TUjRtakg5eTIyaWgxSml0WU5xM0swMThaQjY0TXgyZjR1SjE4NlE4?=
 =?utf-8?B?ekEyeXMyRnFRVGFHQVRBbytZbFhBZXVyOERzTkcwN01nQldzU2wvenFLNTFX?=
 =?utf-8?B?VWU4WnVIS0M2Yzd5ZDFFOHB5Nk1NLzB2WG1aOXREUHd5REZ6d1hkUFVJbXJR?=
 =?utf-8?B?Vm1hZWVGNFVwVFBSamJ0WHZZVW1ONVR0Y211bGZIdUdNUHpBaHBlVHl1clBW?=
 =?utf-8?B?RFJRcmt1Sk85RHlzVEJjSitHUXVZR0syQ2I4Znp4Y2JUdXByUGlCSzJwVFBx?=
 =?utf-8?B?aXljRW0rYWgxUE5La2lzc2ZFV3FwWThmeTdKaHFCZDVFbFFqdklOVVNGcUxT?=
 =?utf-8?B?dDZWbjJZYllrMTZ6REZsUjF4d09mTVRDTFF2WlFveWlzYnBlYnFqSkY0MEJB?=
 =?utf-8?B?bFpwTXV5elZSVWp3endHUUZ3NHhoUUdMQ0NMelRaaWZRK3kzbUk0aWdpMmxt?=
 =?utf-8?B?Q3hBN3lYVUwrYkxTQWhxcGFTZlRSWTl0OGg1eVRhdVlHZVBsQncwSWwzRjlE?=
 =?utf-8?B?TmhiVEd3VklXMHZ6RUNkS0ROb0w5Q0pyck5scVB5cWREK3A5cnBjQ05mYnZ1?=
 =?utf-8?B?eHlEdVVQM3FuTkViSG11bUNqTnYwWlF6Q1lmaGhYMHYvL2R5Qk40QUQ3ZzUz?=
 =?utf-8?B?b1Z1cGZyVlVmcElXZ0JOcDRRdUZyV2NtMXNBUS8zRldGblJ6TFF6MUtzcWhW?=
 =?utf-8?B?RG5vRjBYcm9aUFAwakdZL3ZlZElWQU1kdkIwMDhFdmEyQjIwUTRzc3JEdFJX?=
 =?utf-8?B?VWNKRWxsWVZHZ2dWdThIMWYyWi9iRlVsVlo3V0EySEdtK3V6SC92a1NuUXYx?=
 =?utf-8?B?dEVOQm93QmdyWVJpS2tMUEhFWDVMM0VkSFdyWGhZYThqM3drcEtjMndTcXFJ?=
 =?utf-8?B?MVZYUXFpbTN3RjJzRFFWWVNXc04yQk16NWlDQ1JKeUQvWW5DQ2pwMVQ3MnVV?=
 =?utf-8?B?VzRxWHJrK0pLWkNWYVV5V2FOelZFM0JSNGxCNklUdVJrTFUxL0p2c1lyYlVn?=
 =?utf-8?B?WEJoVjB4NzJyWTJ1My9COXJ6OTRQdGQ0Q21RVC9DNnJYWk02akxINzdENklR?=
 =?utf-8?B?WFNYUDlNaDZLdXdGNUw0OUFTcndKVVJLSDBDbVpJVi95ckN5Um54cmFCbGZM?=
 =?utf-8?B?c3RoZUh4NCt3PT0=?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(36860700013)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2024 14:04:54.6323
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e636ee8-9b10-41d7-6f9f-08dc9c3247d3
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E9.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR02MB6420

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
 drivers/net/phy/broadcom.c    | 405 ++++++++++++++++++++++++++++++++--
 3 files changed, 506 insertions(+), 18 deletions(-)

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
index 370e4ed45098..304ed78315de 100644
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
@@ -553,18 +577,105 @@ static int bcm54810_write_mmd(struct phy_device *phydev, int devnum, u16 regnum,
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
+/**
+ * bcm5481x_read_abilities - read PHY abilities from LRESR or Clause 22
+ * (BMSR) registers, based on whether the PHY is in BroadR-Reach or IEEE mode
+ * @phydev: target phy_device struct
+ *
+ * Description: Reads the PHY's abilities and populates
+ * phydev->supported accordingly. The register to read the abilities from is
+ * determined by current brr mode setting of the PHY.
+ * Note that the LRE and IEEE sets of abilities are disjunct.
+ *
+ * Returns: 0 on success, < 0 on failure
+ */
+static int bcm5481x_read_abilities(struct phy_device *phydev)
+{
+	int i, val, err;
+	u8 brr_mode;
+
+	for (i = 0; i < ARRAY_SIZE(bcm54811_linkmodes); i++)
+		linkmode_clear_bit(bcm54811_linkmodes[i], phydev->supported);
+
+	err = bcm5481x_get_brrmode(phydev, &brr_mode);
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
+				 phydev->supported,
+				 val & LRESR_LDSABILITY);
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
+	err = bcm5481x_read_abilities(phydev);
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
+	struct device_node *np = phydev->mdio.dev.of_node;
+	bool brr = false;
+	int err, reg;
+
 	err = bcm54xx_config_init(phydev);
 
 	/* Enable CLK125 MUX on LED4 if ref clock is enabled. */
@@ -576,29 +687,80 @@ static int bcm54811_config_init(struct phy_device *phydev)
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
@@ -1062,6 +1224,211 @@ static void bcm54xx_link_change_notify(struct phy_device *phydev)
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
@@ -1212,9 +1579,11 @@ static struct phy_driver broadcom_drivers[] = {
 	.get_stats	= bcm54xx_get_stats,
 	.probe		= bcm54xx_phy_probe,
 	.config_init    = bcm54811_config_init,
-	.config_aneg    = bcm5481_config_aneg,
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



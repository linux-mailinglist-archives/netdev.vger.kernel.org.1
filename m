Return-Path: <netdev+bounces-201902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AEFCAEB639
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7822B64068C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:23:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D732C1587;
	Fri, 27 Jun 2025 11:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="hvHKFBxp"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012062.outbound.protection.outlook.com [52.101.71.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EC9C299931;
	Fri, 27 Jun 2025 11:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023415; cv=fail; b=MB9yS6BXzC8ZTZwKJbxC34yBs+53WervzKW3wdjKCh9Pro0Lexf3k3O/hTWW4R5aMNK2Bm2ck0wcpgJQN8LoxvduxLqVlYBwt7YHgeS+0qGxtszi1Qzls2SZbDZOPd/xWtQstavNDlndN8+0qWcvOQYrZAMXdh00z79p265m/f8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023415; c=relaxed/simple;
	bh=NcvAuScwKf4k9DVehdsie1SetQBKOo9OmyLYS3eIquY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EbrXhqQidPlF3ZVONcJlEogTq47kdOGFWcDVoK0YAadRHKcCKc/xH9FZBee359hT7dFLkvP0OJ5vtN9b8RAgjcU34Gv+HqSo/bGXl2s8JTbp3VRSELFeyfauv3xzrTZElGwNALA4EOFb1huWDHE/bUejevX9ycj52XrSfG/1Hso=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=hvHKFBxp; arc=fail smtp.client-ip=52.101.71.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e3OoHTLXKSDY7uji+DTI2gCvxnUjd8Pa3MWKIQRH5UvpkK061uy/g94mvCd/fWAf87oEpsrW0BvZlOSfmYPRgvrm95DblrHEuEe+b8/hWFlAiXxZJx+RYWS3Z3mlYWtgJ3KX/qFx/7kJAtEcyVSFWFTSeXLyECfpn5mbb80SNb6/nz+qjHc7IpLtvq/dqbdDh+z1ILzdCVPvlPEIaDs+d0ZbkQgtSqoyw2leioJ8bCi2xpyuzvplNm580u4efMio9nzxZHyaMW8sH3AdeqCOPI4ezfR7WUk5kgUpd4E9llKTVGbp9+KGQCwAfNIUNwiUvW+NmxG2cbMtwlQ8bJ4rQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rocE4T0RwHkcDDJAiBjxAByskvGc+jdclVl1Q6awb7w=;
 b=KtivLc/nNThwqyDg1lO//TIc9iaGvZgrFuz0cryoX38qiB9vthBrBanWj9d52HUAQW/Y6Imudw5hn4Qr7KDQBA85/7piu/oyLi9C2F8f08GcXaOCOU5ybYPbZ2XOnK3lPMwuS3JMX9O2m2vgmzAPgoJG86cbxsKC3r4RcD5mDpLajJtDT9jSqiSgPs2xYygTOW9WNMU8VtyhWI/jZXeNO3xGCgLN+T9IIirsAasns2wTWccxTyaPYBvdyt3P9u0q6oUleZ+LeXm6J2BscpimakmLrYf0RcQ63xSPk0hK//IZ3a6R5Bi7cqhfog+G6cK8Yvp6tlA67SiMbTSDZcIxxQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rocE4T0RwHkcDDJAiBjxAByskvGc+jdclVl1Q6awb7w=;
 b=hvHKFBxpZrum/04xMuPDIj7jMHM0A/RC2fI0SnDnvttjQteW8VE6O0RKVaormRzPVmoBS1FVA/mgps7nlIvEQP78UCJdiDe/pQB7rDeQ7aJvpSZZxcTWNjzQhPwf5CfADhafe2nnmWAYLXTheeht6Vq1VJ60Ej0pHq0+xvySpJI=
Received: from AS4P192CA0018.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::7)
 by AS8PR02MB9933.eurprd02.prod.outlook.com (2603:10a6:20b:61a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.26; Fri, 27 Jun
 2025 11:23:29 +0000
Received: from AM2PEPF0001C70F.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::25) by AS4P192CA0018.outlook.office365.com
 (2603:10a6:20b:5e1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.23 via Frontend Transport; Fri,
 27 Jun 2025 11:23:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C70F.mail.protection.outlook.com (10.167.16.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 11:23:28 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 27 Jun
 2025 13:23:26 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net v2 3/4] net: phy: bcm5481x: MII-Lite activation
Date: Fri, 27 Jun 2025 13:23:05 +0200
Message-ID: <20250627112306.1191223-4-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250627112306.1191223-1-kamilh@axis.com>
References: <20250627112306.1191223-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70F:EE_|AS8PR02MB9933:EE_
X-MS-Office365-Filtering-Correlation-Id: 10b26082-b12d-4988-248e-08ddb56d0a04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|7416014|376014|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?K1prSjVYTGJwSmZtcm95M2Q4ZGdieXlVSjdWQUdXT0JWcFJjQXpPMDRvaXl3?=
 =?utf-8?B?dmlzN1Z2enQxUmU2TVcrZVRVaTVKWlhhKzNaMnlKWi92bXcxcXUrbzlwV1lG?=
 =?utf-8?B?VHdvS2s4R2ZscDdNdklENlVDaTBVa2dxVzVYcjFtOXRoQnFDa0IyYjNjV3JF?=
 =?utf-8?B?VG1PcHRMVEhqYkI5L0FjQW1zZEZIQUNuUkpWOU5BRENRVTVqaUF1OXprVVVL?=
 =?utf-8?B?MHlTenhPaWRlUjJwT1JCYUxMMEpYbk05Q2U2bFVXOGFiei9pVm9UQ2N5QjlD?=
 =?utf-8?B?VlU5YzB3KzVJU3IzQUxZNUFsYTg3MjZvK2ZHWTJDLzZZb1JIWldkSVNGNGxl?=
 =?utf-8?B?cVJRSTdpYmJUb3hGZzF1bjBuOVg1dnA4MXUrdzZmaTgzKzBzai9YNmgvWkVG?=
 =?utf-8?B?MGh2b1FQVnVTZDVlQTNYRDVPUWE0UWJVMXhMRGp5U1ZFV29SMWEzMmI3Sk9D?=
 =?utf-8?B?eUNKNEg1bDAvaysyQ016ZWI3NzJvOHAxRlJteUFmbDhycEFvZFU0VjVUS2ZL?=
 =?utf-8?B?TUd2Yys2L2pGZ0VmRGpUeUZuNldpbkIybUIxOW4xOFo4N2RtV3d3WG1JT0kx?=
 =?utf-8?B?VGhSREhtbnpvN29SY01Bc2l0N281MUZzUUcreURuUmppTlUrTW9Yb1FIVjFN?=
 =?utf-8?B?eENJZWhHdGQwaTFHL2l6TXVHRjZ5MGJJNFkvNjJndHEzRjVTajRDQUVpVnJp?=
 =?utf-8?B?UDRLZ3N6L1kyK0tKMDJQYnpOOG1OWFAweE1FWVBEczc3dzNrTmdXdlF5QzRL?=
 =?utf-8?B?NW5qTlRvWWpKUWpzQ2F5VWp2ZFVha1JQaVd4cWVaR05zaVl1OG1MSjNQbFFH?=
 =?utf-8?B?UVErVlJuVk9DVEFKY1Vpd2V6cmU1SFBpbFJlMk0ycW9mTDJaWitpdGNXb0Zm?=
 =?utf-8?B?K24zc1UzeGxENW9hTlR1bXJBN2l5cXJReFNKNTMvWU5UcE5XQzhXczJNYkk4?=
 =?utf-8?B?UmpJTnJIeGNiMU1tRHU2M3pIZDZpNVI0bzRuSkZ2TTRvaThLNGl1ZlZCZEJq?=
 =?utf-8?B?Q2ZEZ3ZXQlZ5OWt1WGorUXp1Nks3Q1I5cS9lenl3T3VjMVpLMzdpd3NzdVNW?=
 =?utf-8?B?RXdRQ25XQXpjSWxLV2x5eERjQVFUdUwrUnRQaWZ1Z3pmenlTeFo0MzBxaUJh?=
 =?utf-8?B?a3hFaTJTaWRaMmtyczJxUVVvdGQraThXVmJ1amE5VHpYV1JkQmpnMVVIN1lt?=
 =?utf-8?B?elVVVEdpYWpLanh1Rk1FbisxRXU5VFNHMXFkbXdqNHFlMUppNXUyczJHSVBj?=
 =?utf-8?B?NG1yMGtxZ3BnYWJobUI4bERrd25nRjBReU1DbmMxVFdWNytHVzVLdmgxUnJK?=
 =?utf-8?B?THdoam1Ya3M2NEQxQ2VudDRDdXdNTEJZd2FJT2JwUzJ6aXlBU1gxdWduTnp3?=
 =?utf-8?B?eGo5LzNxaGdCYjVrSFFLYXorOW5sVFpnK3JGcjErZ1UxQ2FvWXZWMGphbHpG?=
 =?utf-8?B?SElhZFdRNFNubWlHanpYaFJYVGFWOVZXSUV4SS8wbE0xdEk3QlNlZ3o4QkFU?=
 =?utf-8?B?TVh2T1BQQVkySWxEdUYzQ0l5b2dDZ1h1bnB3MlU2OHFrRlpzRmNoN21iZGVD?=
 =?utf-8?B?cUpqdUQybVR2SlZEZEo2SkdzNGFBeno5ZFpLTnNQMGRPeHdaT2dBTzNqZVZB?=
 =?utf-8?B?cnpkVGtMRFJNMHZCZTdKWEhLZzlCV28wZjV3c0NMWkkwWVBmYVlMbTI5VmZC?=
 =?utf-8?B?OWhJaWRnNW1nQUUzM1hlNUg2YUpiYzJGVmtuOUZuQUtUTU5IenBQeEdrYk5s?=
 =?utf-8?B?b3VuS3l2L0kvdFQrUm9XQ2Nib0RuL3RSWEJtL0loc1AyT0NvM2pKdGVFWnJ6?=
 =?utf-8?B?cHhrUEx5d3QzYVVJZ25oSTU0Q2swZCtYWTRIM3JVU2pYTHpFMDdrbzVFSU1Y?=
 =?utf-8?B?b1JEYkZ4L2JlMitCM081aklhL1U5cEExNVVWdnpxdVNmOVg5SjdLcjFpMkxz?=
 =?utf-8?B?MDR2bEo5SWVkR3hxQnd6V1JmV2RQZVN5Uy9lbWNidnFrWWRzMmpzVHV0TVhw?=
 =?utf-8?B?dGVtU3JzT0FOREhwckJSTVZQZjlOYjlaRHd6ejFjWE1UM1o4dHVoeDZ4R0R0?=
 =?utf-8?B?SGxkVGZQODFGQ2cwRXZ6UFU2RzRjRW1haUhnZz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(7416014)(376014)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 11:23:28.0156
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10b26082-b12d-4988-248e-08ddb56d0a04
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70F.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9933

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



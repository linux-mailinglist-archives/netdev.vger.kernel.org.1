Return-Path: <netdev+bounces-201536-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B37F4AE9CF2
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 13:57:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4297164333
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 11:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9649F21773D;
	Thu, 26 Jun 2025 11:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="VLe1qNq2"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1762F11CBA;
	Thu, 26 Jun 2025 11:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750939002; cv=fail; b=Y3pnayYfh+2IeET54VR909gXXFlLQcbh3kSVIuEMjZCE1av8JGFgLkZ/GSPrifQ6i2B91Z33Jo9KsnbIpsxn9Yrq6HgBc2wn7NHI8ZIyfWT+OxHtQ/RDfKir2nAOIM2mW+uWKl52to58EwSx38b/wrU0lUq0WaPI3UqQgZwKgzs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750939002; c=relaxed/simple;
	bh=2ysOHcBuJsXGub6rPstXlp5lLEWGHxa1nKb71vOjFDU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GKxu0AiUgSqubnOYar4rVE9U8gG+mbZgahIZgTpqAJW/O0Gte5Nxi+GCampxW07RCjJDdv4xSD6BrFaSaV9z0jZGqQ3hbK/v/QCQ9oA7gq7FD1YWJZwsaqkAEaqOcpdSdrQoAGV/5vKkqZNW7m9xi0aukZbOI9RoIaqnJ34aDrY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=VLe1qNq2; arc=fail smtp.client-ip=52.101.70.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaRJCft7usJx3Eaz+JOLlxrzLmEYmDpHyEjSi6eEkMvSj33b8o4XKZ0QdMtKZbO4Zw7ka9uHdD1ZG5i3UA4v0eWdpnm7zWdPPRlKdFy2+mqSzoNtW7I/Jx2dBUstVdBBcOa+c0hY8OJNzxva6fgkQjor9KbBrFxCNTyjprHvbO6RsCLG5dsyYCyztuyJ+xQ9xSDxcpXqG6y9CTPlgkPfaGeRyDGyo8IcxDmAE9iODB+wSFACLys4aAMUvf93Mq2xe/sX24EUCiDa6F8nNiBLW2oIuHwXmDPbtU24qHjzajcMPr5RtCDJY03UHNVqWmlyw29MboLUtydFgxPsymcm0A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ox8VzJtnMKTgrcap5x+waMr6uHOdMH2SToVVXz3dI1s=;
 b=Um8wywwukJgs+qmvxP6iOYxPh+x1a1XvezoUiWAUUnvY5CyCE0NUDUkMU0d4UaPEgedaOV0vm/2oGrqrLO5QAzTXRh1ckatDv69ixQoDNtJnH0vEUz8MtYaVnj6kFw9lm8QTMyxRZ9edTxeP1Tx9B9ZOcaIoysNj3Sa4H39O7Ym3j1OYFtwpDeUAsy5XceXBpwjsQ1KkD+78yt7fqgkDFxpyRsuc+eDK6zjXvhznxBK99kvK7Pe3Lb3WhV0QOxQ1wG915WtMs4zE+jN26cKpIwgmCNAO5PhHORq5OXY5VX1pP7U3kNCmt5+kxknm8RbR5w83fn8CLnw7ligDE7Hwqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ox8VzJtnMKTgrcap5x+waMr6uHOdMH2SToVVXz3dI1s=;
 b=VLe1qNq2HzWfQ+gL69aWzL3NAQn/5VQDuaPIEgIYlLSH9sXMIeLs+hoKAzlRPuUOcOvYgPTLJRey1ThNHwcHiKw7ch5neVjlcteGBnyp39quUW1jv3H9AVYY98nB7oyBJ+fL1/hpdMjIFv7e27DJqxAz321YI8S9wW2Hz2tvY7Y=
Received: from AS4PR10CA0002.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5dc::19)
 by PAXPR02MB7984.eurprd02.prod.outlook.com (2603:10a6:102:28c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Thu, 26 Jun
 2025 11:56:35 +0000
Received: from AM4PEPF00027A5F.eurprd04.prod.outlook.com
 (2603:10a6:20b:5dc:cafe::b2) by AS4PR10CA0002.outlook.office365.com
 (2603:10a6:20b:5dc::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Thu,
 26 Jun 2025 11:56:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM4PEPF00027A5F.mail.protection.outlook.com (10.167.16.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Thu, 26 Jun 2025 11:56:35 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Thu, 26 Jun
 2025 13:56:34 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH 1/3] net: phy: MII-Lite PHY interface mode
Date: Thu, 26 Jun 2025 13:56:17 +0200
Message-ID: <20250626115619.3659443-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250626115619.3659443-1-kamilh@axis.com>
References: <20250626115619.3659443-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A5F:EE_|PAXPR02MB7984:EE_
X-MS-Office365-Filtering-Correlation-Id: b29e129f-a9c5-4ff2-e5a6-08ddb4a8802b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700013|376014|7416014|1800799024|82310400026|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UkpvelF1Yjh4WUt3cUY0cCtuTW5OMFZqY0ZONEhpVXlnUGZ0YnBlVHJZQW5q?=
 =?utf-8?B?OWQ0QUxuNFc2aDhsbEpsUkVKd24zRUN0dkQ1MmZEUlU3S25WZFgxbUtFODlH?=
 =?utf-8?B?Mkg5cTQ2MExWaHRVMjU2MHFhNFdtUjk1TGJxYnMvVVZ2QkptclpJaTRhcmVj?=
 =?utf-8?B?ck84RXIxYWEyV0czdFhaR2xhaEFOMTBsazdTRm40S3o5ZHFpdEZaRVpaL1d5?=
 =?utf-8?B?QTJPcE1CMjB1Nmd5UGE4VmhSbkdsRGtVNnNSc2JYUk51U3Qwc0RHY3o0UmpF?=
 =?utf-8?B?cHFjdkJVRnEvY2g2NkZjdXVFOGpEc2NnelJrYjZQRlFDTW5kaDkwOElSdENo?=
 =?utf-8?B?aEltLzBjZGdkRlRiSDZ6OVp0blFJZWRoSldqZnRuNmIzeHdYN01VOTBlZ3F0?=
 =?utf-8?B?VXVIZm5iNmlCZG1LMmU4enVDVDg1YTRHL1hqbjdBa2hiRk5FenBuZDdlRG9j?=
 =?utf-8?B?QUFWL3lrRlhQeWQvOTE1WWdPQk1zVWptSXI1dWx1NG04S2ZVR0ZxUTNrN2VY?=
 =?utf-8?B?OElHM0hleXZURVdFa2RTb1psUyt0NmprTmxDa3dLd1RxMmxKLzQvc1ZIOEVu?=
 =?utf-8?B?U2dMcmFkN3UzTFdvZC9nZGNSSW50V2l1ZUJ2NXBobDZWdERtRXM3NEJSMlEv?=
 =?utf-8?B?L2hJQVdoQmQyUThPUUhEdm1iaHRHV2dhaWMxRUpRTFh4QnZqT0ZId3BhVW1W?=
 =?utf-8?B?by9oS1VnckVuRmpRSE11SlVTRmlBYkJNZFlJMDFLbFdvRlFZMTJYWUhkRHRD?=
 =?utf-8?B?NVhYZFRMYkhFTTBCcFRFcEhuVThORklOenR4V3pJb3NvaVJrVElRbUN3Ympk?=
 =?utf-8?B?Q0Vqb0w5REIvejNuSjR4RHhZbzEwTFlDL1VwcHdjM3h0cjNCOUszOUlScFpE?=
 =?utf-8?B?ZUNLM1lMbmVMQncyaStrTDRvVHpIbnhYOWF4K3RTQ1B1RUh6dTlzMEtCRVow?=
 =?utf-8?B?cFlRVVFVdm5nekVrb1VKZHpvMFJDenUyNUlPQWRoQ2tqOG53R2pxRWxORm5q?=
 =?utf-8?B?UHVBZXRieW54SlVUR0RjUmhUVGVhSnFocDNTVzNsWFdjcHdmQjNSc3UrY2R0?=
 =?utf-8?B?cjAvRUpNODZkNzgyM3lHNUMvdmlCRHBUNFVxZGtiMnBHL1pQRnRqMnZqVk5a?=
 =?utf-8?B?MjZRMVdOVlU4dlIrR2hhTlBraFdUT2JIeFpiUW5FM0RpR0ZjUmJqUzVkSXQ2?=
 =?utf-8?B?dGNvcDAyNHVxazFpQnpzTEpBejNLVWU0TGNhbGFPZ1VrVy94L3lFU1hEQ2ho?=
 =?utf-8?B?OWJNSStGVDRUVmJqTlNjRXBrQzQyNjNtTzRHOHhjU3ExaTNNY0NXNGdWTzlK?=
 =?utf-8?B?cXZqVThMVVM1UU5nL3lGRlhCZDVOSHhTWlZXdW9vaFBHblFmU3J0Q09EdWtZ?=
 =?utf-8?B?OU84aVliOGpUUTJVY2NtaEZ6a1ZnRExXdStjeXgxME51ekdaUUJIM3FkdE1k?=
 =?utf-8?B?dUJmK0Z5cUovNmhNNGNmdlk5OERCb002dk0vV0EwQXlBYkpmTUpMTW5FTWhW?=
 =?utf-8?B?VHJzTkMrZDQ3V0VwK0liZ1gza3IyTk5zeDltM0gxcWlBZnEwcG1UTlphZkJM?=
 =?utf-8?B?REYrWXM0RXVUb3ViSGNpK2hNUHZOc3d6WDZSbUVQcDBNWGhvSS8rVE9keEJw?=
 =?utf-8?B?QWhOdGw5UVJHODZKTndQNTgzZ3Q4Z0l6R2ZNcEpGTm0wMk1kNDRuVXFiWHJ2?=
 =?utf-8?B?L1c0Ky9IQ3hoZE1ZamVjQzB4bzFNeWxVczlpRkNRMHJzMDZsdWROV0tqcWt1?=
 =?utf-8?B?a0NBc2pOWjR3cUVDSEk4eWRTdFdwejhTR1ZWdHdRN1RRdzQwRUZiRTdaOC9n?=
 =?utf-8?B?YTRVbzJQNHoyY2U1Y05PbnZNQXNKVXhjSjdVREZrTG9HWDhQYWV1TGRrUDdp?=
 =?utf-8?B?V0t4YU1Yang0dWVKQm8vV3JkN3V4QlpBQWRIcS9MeHZkOENTa0Q1cDQzRHE2?=
 =?utf-8?B?aGlJdG42bkZZQkF5dXBXUnFwUkt4VVhHT0dnNEZRbXlVOFJDL2piWDc4dndR?=
 =?utf-8?B?RnErWUlHL2VHcUFJMS9yTy9TTEJZSGZpeWs2MFlxU1NHUmVxYUp6bm41a201?=
 =?utf-8?B?SVBXY3g1RWM1eEY5clVNcXlYbFE3ZmcydnQ2Zz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700013)(376014)(7416014)(1800799024)(82310400026)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jun 2025 11:56:35.3930
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b29e129f-a9c5-4ff2-e5a6-08ddb4a8802b
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM4PEPF00027A5F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR02MB7984

Some Broadcom PHYs are capable to operate in simplified MII mode,
without TXER, RXER, CRS and COL signals as defined for the MII.
The MII-Lite mode can be used on most Ethernet controllers with full
MII interface by just leaving the input signals (RXER, CRS, COL)
inactive. The absence of COL signal makes half-duplex link modes
impossible but does not interfere with BroadR-Reach link modes on
Broadcom PHYs, because they are all full-duplex only.

Add MII-Lite interface mode, especially for Broadcom two-wire PHYs.
Add MII-Lite activation for bcm5481x PHYs.

Fixes: 03ab6c244bb0 ("net: phy: bcm-phy-lib: Implement BroadR-Reach link modes")
Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 drivers/net/phy/broadcom.c | 7 +++++++
 drivers/net/phy/phy-core.c | 1 +
 drivers/net/phy/phy_caps.c | 4 ++++
 drivers/net/phy/phylink.c  | 1 +
 include/linux/brcmphy.h    | 6 ++++++
 include/linux/phy.h        | 4 ++++
 6 files changed, 23 insertions(+)

diff --git a/drivers/net/phy/broadcom.c b/drivers/net/phy/broadcom.c
index 9b1de54fd483..7d3b85a07b8c 100644
--- a/drivers/net/phy/broadcom.c
+++ b/drivers/net/phy/broadcom.c
@@ -423,6 +423,13 @@ static int bcm54811_config_init(struct phy_device *phydev)
 	/* With BCM54811, BroadR-Reach implies no autoneg */
 	if (priv->brr_mode)
 		phydev->autoneg = 0;
+	/* Enable MII Lite (No TXER, RXER, CRS, COL) if configured */
+	err = bcm_phy_modify_exp(phydev, BCM_EXP_SYNC_ETHERNET,
+				 BCM_EXP_SYNC_ETHERNET_MII_LITE,
+				 phydev->interface == PHY_INTERFACE_MODE_MIILITE ?
+				 BCM_EXP_SYNC_ETHERNET_MII_LITE : 0);
+	if (err < 0)
+		return err;
 
 	return bcm5481x_set_brrmode(phydev, priv->brr_mode);
 }
diff --git a/drivers/net/phy/phy-core.c b/drivers/net/phy/phy-core.c
index e177037f9110..b2df06343b7e 100644
--- a/drivers/net/phy/phy-core.c
+++ b/drivers/net/phy/phy-core.c
@@ -115,6 +115,7 @@ int phy_interface_num_ports(phy_interface_t interface)
 		return 0;
 	case PHY_INTERFACE_MODE_INTERNAL:
 	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_MIILITE:
 	case PHY_INTERFACE_MODE_GMII:
 	case PHY_INTERFACE_MODE_TBI:
 	case PHY_INTERFACE_MODE_REVMII:
diff --git a/drivers/net/phy/phy_caps.c b/drivers/net/phy/phy_caps.c
index 38417e288611..b4a4dea3e756 100644
--- a/drivers/net/phy/phy_caps.c
+++ b/drivers/net/phy/phy_caps.c
@@ -316,6 +316,10 @@ unsigned long phy_caps_from_interface(phy_interface_t interface)
 		link_caps |= BIT(LINK_CAPA_100HD) | BIT(LINK_CAPA_100FD);
 		break;
 
+	case PHY_INTERFACE_MODE_MIILITE:
+		link_caps |= BIT(LINK_CAPA_10FD) | BIT(LINK_CAPA_100FD);
+		break;
+
 	case PHY_INTERFACE_MODE_TBI:
 	case PHY_INTERFACE_MODE_MOCA:
 	case PHY_INTERFACE_MODE_RTBI:
diff --git a/drivers/net/phy/phylink.c b/drivers/net/phy/phylink.c
index 0faa3d97e06b..766cad40f1b8 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -234,6 +234,7 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_SMII:
 	case PHY_INTERFACE_MODE_REVMII:
 	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_MIILITE:
 		return SPEED_100;
 
 	case PHY_INTERFACE_MODE_TBI:
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
diff --git a/include/linux/phy.h b/include/linux/phy.h
index e194dad1623d..6aad4b741c01 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -103,6 +103,7 @@ extern const int phy_basic_ports_array[3];
  * @PHY_INTERFACE_MODE_QUSGMII: Quad Universal SGMII
  * @PHY_INTERFACE_MODE_1000BASEKX: 1000Base-KX - with Clause 73 AN
  * @PHY_INTERFACE_MODE_10G_QXGMII: 10G-QXGMII - 4 ports over 10G USXGMII
+ * @PHY_INTERFACE_MODE_MIILITE: MII-Lite - MII without RXER TXER CRS COL
  * @PHY_INTERFACE_MODE_MAX: Book keeping
  *
  * Describes the interface between the MAC and PHY.
@@ -144,6 +145,7 @@ typedef enum {
 	PHY_INTERFACE_MODE_QUSGMII,
 	PHY_INTERFACE_MODE_1000BASEKX,
 	PHY_INTERFACE_MODE_10G_QXGMII,
+	PHY_INTERFACE_MODE_MIILITE,
 	PHY_INTERFACE_MODE_MAX,
 } phy_interface_t;
 
@@ -260,6 +262,8 @@ static inline const char *phy_modes(phy_interface_t interface)
 		return "qusgmii";
 	case PHY_INTERFACE_MODE_10G_QXGMII:
 		return "10g-qxgmii";
+	case PHY_INTERFACE_MODE_MIILITE:
+		return "mii-lite";
 	default:
 		return "unknown";
 	}
-- 
2.39.5



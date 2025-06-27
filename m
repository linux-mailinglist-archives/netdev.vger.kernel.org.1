Return-Path: <netdev+bounces-201900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1635FAEB630
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 13:23:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D6D041C42BEA
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 11:24:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0AEC2BCF45;
	Fri, 27 Jun 2025 11:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="c47gY6Ot"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB9B29A9C9;
	Fri, 27 Jun 2025 11:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751023413; cv=fail; b=STi9oR4yrf4v4HzQu3gqI/KkgSkQNXjC3AIuLwU/sEZUC53y/U+ma2s+hPJ/IATfcDfZFlBWRfai3xOd8yKffIo2vB/sR3oQYYAGSNBx/qXIgIxZ1PFS5C6qKoRtS7T71G3AWFVcPTmNNiuOl7DPrCFgH9w2W6pUFIC0VCvRpGk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751023413; c=relaxed/simple;
	bh=KWKuxv9G3Nz7I8evOgJMDbytUcw2Xcxnop0DEu4RB0I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ufKXSs+FL5IjB2OSe6y3tEsU1ppTwfTqjSb7qJ/sAh8nPjVFDyT7NSVPjhODGr/iyxL6VbCnzWAWlKhU+WksFPeUww4q25bs33cWL3ZENp8xfisCdnIphcHjkDklEOiL3GuclD0P6kpMl2uU1dliciuwL43WvRFi+NdtFrCvwSc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=c47gY6Ot; arc=fail smtp.client-ip=52.101.70.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jad46KvXzLCpFqJchJ6nCPmtNC534ltlFGY0YPquZEX7/++9CSyZQqh0NZL5YzqR3OPl4OzgE+wfwxOv+ee9St5g37Ps3SgPL8U9oRvDNUY0Hvg5zeg9mGtdgdU2YBkVb9EBMc2mSEjG3Dv9kUE2s6pHFCpzrXxZ79IyTltcSAq3cF9HCn6xy4ENidzlXzzqu66IlL20smwMjtOAZGkXLo1lPZlyR8QJbfBMp6GFDj9YBfPQsUcSuoMNWj6s3A8LhEIHuOrbIN+b1dLzOSW4pCyzlxmh7AMgGcQVHSpI0cepOd/LMuL813hICDRyUhZegw54w+RBWCGkr5emlijtgA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xnd5mDNNmEH7bSz3i2HcGCcnIY6VGQ7LcTsjRCu4tpg=;
 b=tWGae8d7ER2TTuNinLb2P6CwvaJMTMrVFz5yNRUt0FRjiQz6quT1dJyIPdqsKaPfG850dUKlxvblq4/6jpjd9TfPt2f0Vx2ss2YqfMtk9DM+UKHan9+ysYTqzSZE5JrRZ90zbfnHJ/pDGvTtHRQEVbb62f4ZBcjgNLv40IW14Yqs6QjAZ+Tc3ZV4GnbXP9mask6230EykkWqXsLaXPq2j42J+Y//npe2te+9H+m9X/pcDzX5qGJlGhLfl8LbBXsg2nY/c0N9IqiZIh8K1sJHZEgljMLmz4QLG9ETAnu2RoVbLWKx7OuRf2lWpgVTR+EwUUf2pgLXhfnZg3FPqB1P+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xnd5mDNNmEH7bSz3i2HcGCcnIY6VGQ7LcTsjRCu4tpg=;
 b=c47gY6OtF3VAEecZn79hClbz2FwhXD5IUB6QFYBm00rZbSO2BhAUS+zA0MdK4XlHw/XISbjE4oBJO46vA3hJuWNvOdAPKE3m9xyqnWVIu83jXOMXPQur0czoiqwyemuJcfFnoyYN8kKdHG4/kRfVBdEZyWZ30FNKmnd21JRh5MQ=
Received: from AM5PR0101CA0027.eurprd01.prod.exchangelabs.com
 (2603:10a6:206:16::40) by PAWPR02MB9856.eurprd02.prod.outlook.com
 (2603:10a6:102:2e4::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 27 Jun
 2025 11:23:26 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:206:16:cafe::1) by AM5PR0101CA0027.outlook.office365.com
 (2603:10a6:206:16::40) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.21 via Frontend Transport; Fri,
 27 Jun 2025 11:23:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8880.14 via Frontend Transport; Fri, 27 Jun 2025 11:23:26 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 27 Jun
 2025 13:23:25 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net v2 1/4] net: phy: MII-Lite PHY interface mode
Date: Fri, 27 Jun 2025 13:23:03 +0200
Message-ID: <20250627112306.1191223-2-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70A:EE_|PAWPR02MB9856:EE_
X-MS-Office365-Filtering-Correlation-Id: 491d3f61-d474-41f4-ccfb-08ddb56d08f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|82310400026|7416014|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?amlON2M2bVZqR1JGQmEvNzFZcURmdWhINHdueGNtTktJZ1QrWXRNSXhwbzNk?=
 =?utf-8?B?NDNLVEhXTFVyTXFMVlRyVzM3aUFlOW56TFVodGM3b01JRDhGRHRraVBWMi8x?=
 =?utf-8?B?SG4yRGFWeHBRRzkvZVBvRVNXdEU5UTllRjlEb2hFb1pvNU9CQVErV1pkdVNn?=
 =?utf-8?B?ZjNWWGxEMVgvQ0Mwd3NoS3N4enJ1azhYVmFzMWJJd2xTRTJ0bFVtcEQydjBm?=
 =?utf-8?B?T0Z3ZXJwdjhaZEVXTmtOWDY2SldPOHNDOTVFU0Z2NXkxUFFzT2ZvR0VMNThP?=
 =?utf-8?B?QlNqWXgwWFFqeCtMNXRjNGtoV292U0xXaWJXZUNhRllrN2c5ZGQ2bVd6RXFE?=
 =?utf-8?B?c0RlaWcxUkU5ZkRGWlp2SVBGc3g0cTI5b1RHQ2dHMmRQT1NiSlBsTWdieDcz?=
 =?utf-8?B?d0lpQnpFVGU0ZFd1ck9KbVJpajhvRDhQR1l3dWMzZ2NWTnplNDFjaUpVa2xy?=
 =?utf-8?B?MjZsU2dSTGUzQnBZQlY4ZUszT0NCeVF2MkxhRjNxUEh6RXcxNmgwRnV3YWt5?=
 =?utf-8?B?dVlOcWZJMC82cTlNSEFrUTc3akRjMlBxODRrbkl5SkpiejcxWk9STmt1QkZz?=
 =?utf-8?B?ZGVIeWQydGFITEhvaCtvUVdNb01uVzh5NjlZdUEwd21SWWRubmdPQ1AxaWZx?=
 =?utf-8?B?UjYyK1BFUnptQ2NZaWlTUDVrOTlabERTK2lGNHU2QXRXcUlpVFcwMldyRnpk?=
 =?utf-8?B?aEUwTk9VRUh2S3VZVm1RQWV6MTF1M3pyYlFkV2d4WE4wajMySzJ1ZlpOTFZC?=
 =?utf-8?B?RVhYOEErS0xEUFRreU10eW1tSlZETjZBcEdKY0UwNjJVeVFnYVhORW1kS3JC?=
 =?utf-8?B?dGsyOWVaMmM1UGIxbU9lL1A1Mk1TMTRiWDZKVzhlRWt3NVZyZGd5eVdCM0Ju?=
 =?utf-8?B?NE9MNmhIbHZVczQ0Y0RzOGxaZmhKU2VVcG5iUkJhd29PVEx0SFdmS090NjJx?=
 =?utf-8?B?YjZPc2lYYXdFY01KcW1iak9GWmhJUFU0eHlBWWEwbmthWmNQRzMzS25VWWVV?=
 =?utf-8?B?SlRqNU9PT09qbWRTTlBXVVVHSU5pb3dBNzlxenorU1h4eWlVOExYaGFwNjRQ?=
 =?utf-8?B?R2lra2VjYmtPNm9PZFBVaDhXSkZYdEtrTGVnVUQ0MSt4N2xFa3o4L0NhRFhj?=
 =?utf-8?B?WDAyVFZFaGxQOG5hSkdiVzlTcHN0K2c5NHRwRGVaWmJEZVpXMWtQWHFEbXZk?=
 =?utf-8?B?Rjg0cmM0YnBDb0hIYmxpNnd6UDZudDZKRUl1ZXJFWmx4cy9RNE03M3pTUFJG?=
 =?utf-8?B?N3hWci9mbmdPa3NFZWRIZXV0TUhKL29jM3NPVGxwWVQrU0ZWQlpNVUhyY2pz?=
 =?utf-8?B?TDlrV0VNRnhOVUpJb3ZIU2pOeUZHck0rb0crL0dBZDd4N2ErbDU4VzBhbkx1?=
 =?utf-8?B?Uy9meEJkN0c1MWpmY2txNUVNaTE4aUJrV0daTk9rRWp6bE54d2pZbnFHUHpi?=
 =?utf-8?B?L0RtOG5tMXlwWHgwZERxQVBHRXVxWXQwM0FEaU5mTTN2cHV2WlRGNFB4ZUl5?=
 =?utf-8?B?dzV2M0NFbWttdS90Z21ORGVtNUxSbTU3OUYySUFhSE1HWXRHUUxHaFpIdUtG?=
 =?utf-8?B?RFhMVkNnbmdRbTZFMGNsazh1Z2Q1djl4WE5FYm9VZUdSaGV5a3dmY3FUMGdD?=
 =?utf-8?B?eGVCMVRmQ0RleTViK2xxbFJkb0hVZEVGKzBBelM3clpPdlcrUU15SStSK2xn?=
 =?utf-8?B?T1UrSCtqcHllVmVDejNKZlNLM09KMVB0M2kxZXozY29xdkhacElibnM0VW1G?=
 =?utf-8?B?WTNGSUc0Y2lGYk5KSGJoN1ROeU5iTy9UYWE5ckduNmt6VE1la1BYMWtCSzhK?=
 =?utf-8?B?TDBmL0RDT2ZXNmhhbGRwVWZKcDhwK2ZoVmRlWlRKd2xaSVUxczlWdHdxaXJ4?=
 =?utf-8?B?NTdhS085amsrWnkraVFqU1VFbFhwK1BLb0JTSmZtSFRCTXVMbHJ3TWp1aDh1?=
 =?utf-8?B?TzJJYitNa2lkTW1iRFNZWXlIK1d1RlR5ZWkyR3JXdFh4MWxIaG91b1RLTXZQ?=
 =?utf-8?B?TWlISXBEUElXdEw5dzNVaEw5WEtuVHkvamhwVVkzR0QrVlRvYlZVS2dmNTdJ?=
 =?utf-8?B?bWY3Z3QrdFFKVTl2dWNRNjFFTEowdUxtSHFGZz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026)(7416014)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jun 2025 11:23:26.2445
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 491d3f61-d474-41f4-ccfb-08ddb56d08f5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR02MB9856

Some Broadcom PHYs are capable to operate in simplified MII mode,
without TXER, RXER, CRS and COL signals as defined for the MII.
The MII-Lite mode can be used on most Ethernet controllers with full
MII interface by just leaving the input signals (RXER, CRS, COL)
inactive. The absence of COL signal makes half-duplex link modes
impossible but does not interfere with BroadR-Reach link modes on
Broadcom PHYs, because they are all full-duplex only.

Add MII-Lite interface mode, especially for Broadcom two-wire PHYs.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
---
 drivers/net/phy/phy-core.c | 1 +
 drivers/net/phy/phy_caps.c | 4 ++++
 drivers/net/phy/phylink.c  | 1 +
 include/linux/phy.h        | 4 ++++
 4 files changed, 10 insertions(+)

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



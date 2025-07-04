Return-Path: <netdev+bounces-204070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 337D3AF8C52
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:44:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74EF47BDB84
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8602EF9A6;
	Fri,  4 Jul 2025 08:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="F4a74MVZ"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011039.outbound.protection.outlook.com [40.107.130.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FCF228B41A;
	Fri,  4 Jul 2025 08:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.39
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751618142; cv=fail; b=eWauPTUdRJPXPYrqiCyqFRDxLc1N6JcAcjTk5C4iN5Llt83Hba/PnKOBG+kOwW7CLyJiJhVBEjLeriyrpqmbso4IM/5cgeOXs/ZlxP88G5yKIp7nySGpeKpoOiJdkdTo8M0f+L7IF5w8m+6F+VYZ+WtT50sQAjLni13aTP9+shY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751618142; c=relaxed/simple;
	bh=U+OJmOvHH7RkWPnZPo1uBuBEVK1OgCV1TmA7KuIw+LA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LhL+zCToT0TssOuvoBo5b3KgpVUc8/lwBdRZVU7WtHrbrk0H7glC1xi9Rx1o0PPZ7dj0y8yaXZ1aT401dmBq16LOd7Y2n89I5HLnZDMkJpHaFkI2NfBamuAQIk9SACtRkpDBK5hGmUf5+mQi/2enTRCnkHLTv292roUT66lLpro=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=F4a74MVZ; arc=fail smtp.client-ip=40.107.130.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nWXTUQtY0v5l6EpHQRP0b7Qy5R0iSDCGMnzSu5GdhmNEBcg+w/xgcBwf43feIrSQsA7RqKmNRORD3AI6z0OQBqy+baHZlq1MbPgkUWy7ap0NtP4u2iXX/LHPdWGZ/52/IKBkaaQFCT1KYKNECr4QLAimdj9nVYLd9/XdBtU/6Db5a7o6TWfb6eBvZzEkTq8a3INt7BDufWGa86NhZS2L41FxIbPaT8UHw12TpjS0gkGoJF+CyI4dOoGdTwl/d8mCeW4/6NBektHXiRb85zci0I07sRfZtPLlIt/ZSRYwwHJjMfjq8iO/9TJEhlaTpu+ucOfkTEOb92UJCBT4O4gboA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a4DReat2ghkBdi+F2QJLoc/e9uQI6YxLdPcb9cIs1o=;
 b=BDzuWXYar6OKyjhF4+r0W98x5eEir8Ge8BGSNmXbTeNCgsPkRPZMgiSkBAp05UuzrdRpxXUO+yt1ooWv8IBoWxDPFA901bw2Tz5T0FsVLw8JkUyw8UOwIIdSW8TMQVNjZ4lms4v3YxoAe2CwoTN6cfI3I2HyIYk3pUgdA0z/bn3xkt0pcWGNQYF74uSNVNjPDNC4mONXfFXrI5a1Q8dp/85dfFzMiJndzH1W8StJuYbB0+Do0FBBDz3H6o2vFV6nPKbtr2zc4KXgAAm7jpkJV7Vazh5ZU91ojKsMcrVjByrQD6vnvsaELz7I+V/VjYnPiO/jglqaEhE/rp43wCx2WQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a4DReat2ghkBdi+F2QJLoc/e9uQI6YxLdPcb9cIs1o=;
 b=F4a74MVZR2f3RPVYk/WqhLYrKMdaMbYSEQWD0FJa3wsQnqwWfKPoR4TuUHXl2o4xboENlPsED7hysVfD+1uxwrMeKYb6aM9g/nEKpPpgyGhKz3w//37CNtUgWPQYE4nRiNbXnMv6SBgalOKF9H8PzaN+Vax37SiBeQrLb3QXDVo=
Received: from DU2PR04CA0252.eurprd04.prod.outlook.com (2603:10a6:10:28e::17)
 by PAVPR02MB9987.eurprd02.prod.outlook.com (2603:10a6:102:31e::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.20; Fri, 4 Jul
 2025 08:35:34 +0000
Received: from DU2PEPF00028D03.eurprd03.prod.outlook.com
 (2603:10a6:10:28e:cafe::be) by DU2PR04CA0252.outlook.office365.com
 (2603:10a6:10:28e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8901.23 via Frontend Transport; Fri,
 4 Jul 2025 08:35:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DU2PEPF00028D03.mail.protection.outlook.com (10.167.242.187) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Fri, 4 Jul 2025 08:35:34 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Fri, 4 Jul
 2025 10:35:32 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>, <horms@kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, Maxime Chevallier
	<maxime.chevallier@bootlin.com>
Subject: [PATCH net v6 1/4] net: phy: MII-Lite PHY interface mode
Date: Fri, 4 Jul 2025 10:35:09 +0200
Message-ID: <20250704083512.853748-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250704083512.853748-1-kamilh@axis.com>
References: <20250704083512.853748-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D03:EE_|PAVPR02MB9987:EE_
X-MS-Office365-Filtering-Correlation-Id: f28308f8-4dce-44be-5fec-08ddbad5be79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700013|376014|7416014|19092799006|82310400026|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmF3UzNlQy9jWFA2Zzg4TmI3MU9aVjlhZ3dwTUhWQjZQTGJQSk1wNFVqWEY0?=
 =?utf-8?B?TlJFZkxGV0pSRVR2YWd0aFlsak1WWSs0MEFFYy94bGxpdkx1UUdkUDRZRGlR?=
 =?utf-8?B?Vms4ZUlFWGJubWlweDRjMXBsdnZBOStINmZndDJYc0hJRXNGRXJud1JXMks1?=
 =?utf-8?B?R1lyVWVxU2ZLY0VIQXRXMWtoaUUvcTVsUjhxdTJueTAxWDdISUJlclJTT2hD?=
 =?utf-8?B?M3BHUkNaUFR1cDcrWEl3eHZlRVVTaHRWMGFuK0N1WmRGWnMvSGpHWlhvd1BS?=
 =?utf-8?B?RUl6aVJYNXNLeE52S01yL2VCQm5wb1hqeCtONnVrOFNZMHBJazY3akNZM2ov?=
 =?utf-8?B?dnNobXNub1crTVFxM0Q3ckNxVjh1UTBTUSs0dHVzTjA0Nm15Z2VpSm01c2dv?=
 =?utf-8?B?bUhrbzRGMHY1S2hURUF3R3p2WE8zellyZUlWZGJGakZXQnc3akdJdmNnREpJ?=
 =?utf-8?B?ZzF1ckg2YjBMUGhubnoxNFNXaXh0LzlFQWs3UjVtb2docWtubXBHei9iZWU0?=
 =?utf-8?B?VkkvV3pVcWtrTjBLRHU1bDVyTGYrWXR4N25tRkIvbTAyUzRMUi92d215eWdG?=
 =?utf-8?B?Wms0YVdybmc1SGlEbEpjb3ByenU3RzFMdEk1MWRpZFJYMERJc09nNE45dElz?=
 =?utf-8?B?ck1RbXZuOFNidFhOaUN3c1htYjFDS003RzZSUEQvWUZHQjA5emIrMTAvdUdy?=
 =?utf-8?B?bElIV0hicFZLSE9tRFdMOWN3Y3hvTDYyb09SMGxrK1E0ZEpBK0xBRC9qRDRB?=
 =?utf-8?B?UTFhRG1zNzlFaXVLNDVsQitIbnhGUVd0Ull6czNJTHp4L21yOVZ3NGhiays1?=
 =?utf-8?B?Ny95dm11UVkwWWZVMTlWYmoyeTFxL2Z1NmI0RHE0dU1LN0JVbnFXN0xBeWxs?=
 =?utf-8?B?SWpyd1ZQMXhPMDdETXVnRFp4NzdQN3BxUEZvZkphTEx0NXBTUk5sZWl4dWwx?=
 =?utf-8?B?dzQ5YTFoemxCZUJ4d203Y1VkaXBPSENvUXdMV1o2Z0RiajlxdllZSXZzaEl4?=
 =?utf-8?B?dExtVG9IMzU0NXdXVFVrTUhRSnpQK3NOMHFjSEFlUlJPTlJvajlBckVSVHUr?=
 =?utf-8?B?ekdIajZKcjYrWFlzOTNjZDJYM2c5UDBHMlhheDZjUjNhNTRCTHBVc0phNGxx?=
 =?utf-8?B?M01ZaUZSVWFTRms1bTgvT01qZUJHMDIvcENwcDUrcDBNUFozUEZVUlNyV3FH?=
 =?utf-8?B?VGdSTnhQajFINWthUWdIeGx5dEZYb3Z0aFgrOStacmh3cDVXZGdsUVQvUkVV?=
 =?utf-8?B?RVVCR2wwQ2x6dDdkd3NtUjFKWEs2VXFSVUQ4T3JhZGZuRTBhRFQrVEF5UXBJ?=
 =?utf-8?B?em1FdERMU3B3MFZjeFk3NlNzV2FkVXpoRTIrRzQ4U0hhUnlHNGJRRGE0eGVR?=
 =?utf-8?B?RlJBcnc1eWE4ckJ2YWZLREFpOXY0NGoyTmhJSUlsTXRQdWVYZFYvZ2NXSWds?=
 =?utf-8?B?RG9YcW5nblh6d3hKalE0V1pGZ0VaaFovYXA5VmJ1eVJkRjdleHlWTHA5TDhm?=
 =?utf-8?B?emVaWWNXbWkxaGhtME43cGd4bHJ0UFFIOUpXbDBWTEJNVG5QaUNKTHBkdng5?=
 =?utf-8?B?QXBhbW5sS3VxSnlZbjZWclJKRXdVSVdEL0JKU1pNTnpxTkZtRzN1U05YRkJV?=
 =?utf-8?B?cGt2bTNMc1RDRzNVQWd4ZDIvaWY5WTJaOStjMzVyWk80SndrUHNxLys2T1Rn?=
 =?utf-8?B?WmtvL1JyOG82TzJ3c3R2eWdKQkRrQ0EyMHZHbzdqeVRKeFJrWHBCTTFzRGt4?=
 =?utf-8?B?NW4zVTY2Ykw4YVJTVXFvclk2Ui8xRW5CVkZvbFJYbGNDVng5OVY3RlNQVWxS?=
 =?utf-8?B?eXE1amROSDNlQlkxb3pBdEhPU3lCdHNyR1BWYmJGWGVDdVM0MTkvak9QWU5M?=
 =?utf-8?B?UUZOeXZieSt3RjhaK0pYQzladGJEdDlPemxXN09sYUNZMmk4aGVHRU94dWxH?=
 =?utf-8?B?Q3R5OHJwUHZlRVo3alluN1l4TzVMcUR3ZEZLeEpwZVNZclJnZHpvbk1WMnZ1?=
 =?utf-8?B?SlY2TkJ2aUZZZjBWN0EyYktDczZacXV4eUJEYVIweGtmd1pUSGlVaWNLN252?=
 =?utf-8?B?eElJZzBEZEM1alRqQjBTblpoclM3V2hwVmlBQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700013)(376014)(7416014)(19092799006)(82310400026)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Jul 2025 08:35:34.2307
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f28308f8-4dce-44be-5fec-08ddbad5be79
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D03.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAVPR02MB9987

Some Broadcom PHYs are capable to operate in simplified MII mode,
without TXER, RXER, CRS and COL signals as defined for the MII.
The MII-Lite mode can be used on most Ethernet controllers with full
MII interface by just leaving the input signals (RXER, CRS, COL)
inactive. The absence of COL signal makes half-duplex link modes
impossible but does not interfere with BroadR-Reach link modes on
Broadcom PHYs, because they are all full-duplex only.

Add MII-Lite interface mode, especially for Broadcom two-wire PHYs.

Signed-off-by: Kamil Horák - 2N <kamilh@axis.com>
Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 Documentation/networking/phy.rst | 7 +++++++
 drivers/net/phy/phy-core.c       | 1 +
 drivers/net/phy/phy_caps.c       | 4 ++++
 drivers/net/phy/phylink.c        | 1 +
 include/linux/phy.h              | 4 ++++
 5 files changed, 17 insertions(+)

diff --git a/Documentation/networking/phy.rst b/Documentation/networking/phy.rst
index f64641417c54..7f159043ad5a 100644
--- a/Documentation/networking/phy.rst
+++ b/Documentation/networking/phy.rst
@@ -333,6 +333,13 @@ Some of the interface modes are described below:
     SerDes lane, each port having speeds of 2.5G / 1G / 100M / 10M achieved
     through symbol replication. The PCS expects the standard USXGMII code word.
 
+``PHY_INTERFACE_MODE_MIILITE``
+    Non-standard, simplified MII mode, without TXER, RXER, CRS and COL signals
+    as defined for the MII. The absence of COL signal makes half-duplex link
+    modes impossible but does not interfere with BroadR-Reach link modes on
+    Broadcom (and other two-wire Ethernet) PHYs, because they are full-duplex
+    only.
+
 Pause frames / flow control
 ===========================
 
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



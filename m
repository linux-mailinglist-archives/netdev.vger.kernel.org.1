Return-Path: <netdev+bounces-204886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E84FDAFC686
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 11:02:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 335DF4247F3
	for <lists+netdev@lfdr.de>; Tue,  8 Jul 2025 09:02:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3EA92C0302;
	Tue,  8 Jul 2025 09:02:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="qF/ALbgc"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 714B5298CC4;
	Tue,  8 Jul 2025 09:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751965323; cv=fail; b=LkGRuxvuAOIfGsEe0ie245a7EAF5fzMBGvvU1L4Xd7zsB+Buowf3ppEwzyQhrOHxrkzd8ceEQHIhh3VsOINP6knRnWg3CnGo8hW48wYx19oK1FZg16LW+oR3niHOGPkoIhDzUDvnRY2AOxWe6SueHfpVDVFRp6Ry/bSLxD1Fa8o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751965323; c=relaxed/simple;
	bh=vBWU6XbvnYQbFKdo2Qt5Vbw7E11swFpA9m+QrCOYjfI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ntALV8WFlJPYWsM+p8Jc78J2qX8ynIgdVg5CrsPP+2rvmC0rMyGCcJF3w3N1fCydMvxtzW8urUyVKBa+OO1k+T6PwRCAdebGqVcEYG+1JZI7mMVD/HmuU8NUXzKlyf20HxSbUk4j4Su34BKXVuIhM/0zZqozgxdSTiPZIxyIog0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=qF/ALbgc; arc=fail smtp.client-ip=40.107.159.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=UYBNH8aADo2smTs/3PkxkJyVvycPLfD60HhhxJLuN6y/wnnFqbrktsn+6Pmag2TXHD3D17YJuPMwJ8as08mn3wmv4YcUGbo+h6p1xYoeb4BsGU5l7OOW6j0o+mkwbhN5O+b1Lyo4WLgsi5zTjhoPEHCFyFwY4fj6dcBm8ZrTRL+Bt2y/eEfnLSNbWTiZ1P4vRVxwrOJHznFDOQJvWc2XvPcA0dbpBd8wBOMjoOrf4OkdqIfpd2hBnIDtARQhUNZyOih9kf8/YfI4lhT/EB0Oh/t/O2e/3cB8nNLrpU8gkQ+vTNapjG5XROaNM/SnJsz39Z0EhleaZ0eq6cN3KMAYBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9hXI1UjRDUw1E7U1QwdHpmp0hDgSRaa58EEM2B6MPwU=;
 b=q4rRh7hw+J2y+5fYNZBr2RIwQx6JGAwk+UFC+QTF1D+rQgJ5if4OgjFzLBciYyjPoroH1Ma+VH8tzVuOu+0d+VbBzq5mC2hg22wErW79s/Y6yQjrHPKGk4MeMoRlnNt1Lid4mmC2Wrpm/rpeSF9mKkBlBYGEThKByTWnVAmMtzWtq/nZvuKnIntfBUVIbGh+IjY8g4CsIztgByi83fjXKCPD9V7htnvE0vNxTHLAEebXPdgR9BBeYV0DdAmfuJaYwHy3cI1v/nEr0KVG3GmGBZx//VZ437hPwee5RvNaBk3rteOtGQcYfyk+TJlOGX3hxWH8ZxFzkoBJF95U3OzTbA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9hXI1UjRDUw1E7U1QwdHpmp0hDgSRaa58EEM2B6MPwU=;
 b=qF/ALbgctx5FAdUJDzVxc06GOHUBHoD4tSwDO3bBdELk9bIT2fnt7l+Ba4ZGhM8k5qiDFHm4IkrSLg6saiVQPWdGvsKRLDzMF7SsmvkmN6O5gLt9Tvmr/anKsJ76e+76/wk5sdZtnvpSLA4uDsaX2hIA//j1Ye66vQsvPlJuH7w=
Received: from DUZPR01CA0035.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:468::13) by AS4PR02MB7831.eurprd02.prod.outlook.com
 (2603:10a6:20b:4c2::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Tue, 8 Jul
 2025 09:01:56 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com (2603:10a6:10:468::4)
 by DUZPR01CA0035.outlook.office365.com (2603:10a6:10:468::13) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.20
 via Frontend Transport; Tue, 8 Jul 2025 09:02:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 8 Jul 2025 09:01:56 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 8 Jul
 2025 11:01:55 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <robh@kernel.org>, <andrew+netdev@lunn.ch>,
	<horms@kernel.org>, <corbet@lwn.net>, <linux-doc@vger.kernel.org>, "Maxime
 Chevallier" <maxime.chevallier@bootlin.com>
Subject: [PATCH net-next v7 1/4] net: phy: MII-Lite PHY interface mode
Date: Tue, 8 Jul 2025 11:01:37 +0200
Message-ID: <20250708090140.61355-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250708090140.61355-1-kamilh@axis.com>
References: <20250708090140.61355-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9E:EE_|AS4PR02MB7831:EE_
X-MS-Office365-Filtering-Correlation-Id: 90408f49-b48c-460d-a057-08ddbdfe1769
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|19092799006|7416014|82310400026|36860700013|1800799024|7053199007|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RkQ3Wm5oTzRodjl1aVNSZ0NFTDZXMFdFOEZiWllKOFVzMzhkM1RrOEhnclNy?=
 =?utf-8?B?Sm04aUk1elVYWXFOYnprNllRaGF3dzFTcnZOM1pDNkJlMjIrR2k3cGRMc3Bj?=
 =?utf-8?B?ZDdXYlQrSzhJTTdMZ0YwT0pvc1k0N1YzV0RPRlJCRGtnUU9tVmdsM1c0ai9k?=
 =?utf-8?B?TTcwV0laSFVmbzVGMFU4QjBhbEl4T29lR3E1Wlh0aW5XMk0zUmQvelZ3R0pB?=
 =?utf-8?B?VFdMYTdyN0tSVGJ6WjlXMFVIc29sVXhRZWQyTXFPdUZSbUorNGNaODRnWjdl?=
 =?utf-8?B?VjZObFZvVGdYeHltR3Btd0lRbm5haUF3QXFSL0hrK2ZPa1VOTUNMbXpsdzc2?=
 =?utf-8?B?VjBEUStBUmY1WmRicHF3MUJ3TWVybHVOTm45ajJ1ZEE1RTNwRmlqaWRubXdq?=
 =?utf-8?B?Q0JjdDBldXF4ZjFBZ3ptYmtWN2x1NTJQN3RvNFZiM2VIUUtwNVhzbHpsM25P?=
 =?utf-8?B?eUZzaXZXWnBQdXRRL2tUVktsNjVmYkVEQ2NUZ3E1V3dxRVpWc1R3Y1l0TUhI?=
 =?utf-8?B?SWlRWGw4QjJ2OWt6TW1MTHhaNmN6ZEk0QjU3V3UzZ0RMeStNZ0NtSEpqQS9U?=
 =?utf-8?B?SGVVTkx1cjNPUlVtVnpVS3gzaVJ6a0Z4YkNRamRYMXZRWW1Ld0ZWaEEwZGlK?=
 =?utf-8?B?WDBBNkR5TUx2RGhycTg1K0p5M1J3cm1BQk9XRU5kU21GZjZSQ1lrWkN5Z29R?=
 =?utf-8?B?TWpSSlVLT1pmQmZkcHdacEYzKzhQdElYZ3pRT0FSNkJTaVFweDZSeUxqRVJN?=
 =?utf-8?B?MVVGVldrQU5CWUtVcUM1SDlnd09oNnJSbmx2UFlUYUtFOENTTWRFZ3FhbjJB?=
 =?utf-8?B?cjNSdDJ4MnE1SzJNait1RjdPZVhpQm1teWZzNTF6R1NyN0hoY3FKRHJseWZN?=
 =?utf-8?B?STJPVm1iSktMdys4a25YdHJ3SVZJWTFIOFVqTmZVcWZJZ2tIWWN3b3pPNkZn?=
 =?utf-8?B?Z3JnUkMyb2Z2ZjZMWGJEVUFUT2JLT3ZBU1NGM1g2enpvR1hUamhpLzhMSTNV?=
 =?utf-8?B?Y3QwaXRPUlRxdGxCS1M5cDkrWEFpQU9vazVoUE84cXIrYkh4Q0l6Q085dUk5?=
 =?utf-8?B?N3NNam5LVWxBOVdMTkVnTEhYMW53S2VmZnRmcVZkM2t1SnlTYXZwZFZwZmN4?=
 =?utf-8?B?OWpMaVUvK3hQZm1KSGlpN2VyZmRKM1BNSTJiSTF0aXFkNmtmUExXWGRRZVBN?=
 =?utf-8?B?YVE2V2kyMXJpY3JMV3pFUjVXdFArUU0yeTg3M1J1R05TVFlEeEU3eXVSaDQ1?=
 =?utf-8?B?cE5BYlhGR0dXaUljVDh1b0VGTTU1UE4wQ2M2WFdXL05DYThmeHpISFZUTVJI?=
 =?utf-8?B?LytEVVhqUVNaekZlOVhaTHJzMnVUZnNicWZiNFc4WXJEN1I4VDJielFoOFhQ?=
 =?utf-8?B?a2xwNjkwY0pSbDJjUHY2M2dBa253TUFXQW9YMmQ4eHZtaWpWNWhJQVhJV3Nq?=
 =?utf-8?B?aTVJNERqaEJLOU44UnNTbWZvQnlONHpreXdFS2FybkRUN2QxOUs4OUgzR2N0?=
 =?utf-8?B?bzZicnppbnF2TTZZV090K1NySEJQOC82Qy9IT3BtSjE5ajliNGJJWXpSUzFj?=
 =?utf-8?B?LzBacnQ4dkFZbkJWb3hRV2w3RzJoWVEzanRTQTBvWW0rZUpjdFAycE8rWHgr?=
 =?utf-8?B?T1hzQkNpQ2ZHSGRLZmxBWGVPRFVoNHZQdGxjMXZ6Yi9ld00zTG9SUkxIMThz?=
 =?utf-8?B?a2NwUW9PSnlEWW1ROWlGc3gwSVpOWW0wa3B2N2VYZVQwV3Yzc2d3M2RkdTRK?=
 =?utf-8?B?YTNSUjJDSmtLZ09EdDMxWS9SQ0lSZlVocVZmcitoYVUzN0JyQnBsdjVJMzlu?=
 =?utf-8?B?NVp2VGtVK2RRa3FnRlRkTnhiOUdjMkhkdEFlcFRaL09rK2NielRuS2pWKzJX?=
 =?utf-8?B?NEtIV1kxU3Y1WmpLUHNYNTZFdXczbE5Eb1VEeElRdWVJOUd2WVpOSk9XN3Jk?=
 =?utf-8?B?blRhSUJhVDcyYVY4L3RMVWZRbVgyaE9LMUM1UkQyZC9EWWFCdnVrYm9naHdo?=
 =?utf-8?B?aTkycGd1NkM1TlFUYXhxUmpvRjU1TUdtODIySkpUWXo4ci9xb3puVll4S1po?=
 =?utf-8?B?MHZvWEc1ejFTRHJRRnlTLzArS3NhckVjWEhlQT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(19092799006)(7416014)(82310400026)(36860700013)(1800799024)(7053199007)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2025 09:01:56.8088
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 90408f49-b48c-460d-a057-08ddbdfe1769
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR02MB7831

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
index c480bb40fa73..605ca20ae192 100644
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
index d11ce1c7e712..2cc9ee97e867 100644
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
index f5473510b762..c7f867b361dd 100644
--- a/drivers/net/phy/phylink.c
+++ b/drivers/net/phy/phylink.c
@@ -237,6 +237,7 @@ static int phylink_interface_max_speed(phy_interface_t interface)
 	case PHY_INTERFACE_MODE_SMII:
 	case PHY_INTERFACE_MODE_REVMII:
 	case PHY_INTERFACE_MODE_MII:
+	case PHY_INTERFACE_MODE_MIILITE:
 		return SPEED_100;
 
 	case PHY_INTERFACE_MODE_TBI:
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 74c1bcf64b3c..43786bb8f804 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -106,6 +106,7 @@ extern const int phy_basic_ports_array[3];
  * @PHY_INTERFACE_MODE_50GBASER: 50GBase-R - with Clause 134 FEC
  * @PHY_INTERFACE_MODE_LAUI: 50 Gigabit Attachment Unit Interface
  * @PHY_INTERFACE_MODE_100GBASEP: 100GBase-P - with Clause 134 FEC
+ * @PHY_INTERFACE_MODE_MIILITE: MII-Lite - MII without RXER TXER CRS COL
  * @PHY_INTERFACE_MODE_MAX: Book keeping
  *
  * Describes the interface between the MAC and PHY.
@@ -150,6 +151,7 @@ typedef enum {
 	PHY_INTERFACE_MODE_50GBASER,
 	PHY_INTERFACE_MODE_LAUI,
 	PHY_INTERFACE_MODE_100GBASEP,
+	PHY_INTERFACE_MODE_MIILITE,
 	PHY_INTERFACE_MODE_MAX,
 } phy_interface_t;
 
@@ -272,6 +274,8 @@ static inline const char *phy_modes(phy_interface_t interface)
 		return "laui";
 	case PHY_INTERFACE_MODE_100GBASEP:
 		return "100gbase-p";
+	case PHY_INTERFACE_MODE_MIILITE:
+		return "mii-lite";
 	default:
 		return "unknown";
 	}
-- 
2.39.5



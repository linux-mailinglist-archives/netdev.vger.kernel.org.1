Return-Path: <netdev+bounces-202386-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF1CFAEDB05
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 13:31:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF7DF1782FB
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 11:31:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACFB25F968;
	Mon, 30 Jun 2025 11:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="At8pOnC+"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012063.outbound.protection.outlook.com [52.101.66.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A5B1DF73C;
	Mon, 30 Jun 2025 11:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751283063; cv=fail; b=VD9aSUIBBfEyQZt/jT/t1CAbdKcZyhN97YV7qrlRnLotJu1n9tpH/JHnY0mTAcFfX2T5xFfect6TAXKOCtqgB2OzGcFJllz/7Kx6YuPDmFcm1XV02Yi4Af4pmPEOILfFNWuczUuC0ZZgOYlA1v6ZGJs6vDZvKB6A9tkRdxMCmqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751283063; c=relaxed/simple;
	bh=kyDwrgfelgd6Pcao5lOBIvpZdobINgHiB1Y8GKO13pE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S3CehWL/8mBsSNr90C8SHbk4Zl/rf827CP8jgv9ZhGYQmWWGmvjobw7vT613KisIPXtMNElgM+geEIWQIfqDdylskPXBoitrnvU8ACUu6v30N5AdYv+5nbnVJf91cI4bHXyVCUcksTb/HqZdt/Gc9dC1k0LAK96ulqRxvnjCtsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=At8pOnC+; arc=fail smtp.client-ip=52.101.66.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hXawjqFc6oTNqeN1njyiRAIqZ0MsIVxK5FnihB/FWFfl7gBjjLWhTzSDPjp6C1HxVU5aInASfjgv8VoDeXO1JUa8nub56EVDOhvQpb1DgTA/nS3rBTbPAglsJnJ/0jyWYuZpt0CPGLhB2oMcGtFdD2DQy2wpEh+CTaDsF7+aQqi7eP0hfy3+7xv8Fh+WAJiXr0RpNPU91hoIQ+VP4+InOgV5fChozMfb6J1I1aUTu+MMSsjUj1cLtU+UY9El0FaJ1sz3QrvaeWMjKOWo9rfOnHjiqhm1Nww57up+wK1lNLrgAqyZfwpByNF7qw8Lr3ZPZnhxL4Rw6ELxeP9HKbn6aQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=f/Q4khuupCDjG70AcbVcBr2t7jliAHS+WQfeKQj2wfU=;
 b=bvl8MgBjF2POVUc0PRnzRHgm9Rl2ngDmJPviIkDQGW3X/N29Y2MemGUJvbyUVnSvP1t+6tCrxPJ1rUTqao+qQlPmhrCOLdMUvaMZUDbAciMrh5FY/PS3JSrSt1ZmrD1K2fS0QyqVtMVsNCAPCv+c0XAEo3l+b33YGA2B66MpHeEhfDSuIjKP+EabAcTurcNwdy+pyM+rHcezNhQ3i4XaaXW5w1SEoNOLme4RzRRRc7kQMJ0qmIoweqNe6zFElxaM0nf2Wpy4TPTrXxDVNtPeDgZAgtDESQbLFBir3b5vmHTebQ6WXhGEiuKXUfSP3vzw7B8dcsJZZhtv757jqSEMsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=f/Q4khuupCDjG70AcbVcBr2t7jliAHS+WQfeKQj2wfU=;
 b=At8pOnC+ZbYtrU7N02Z77fGWozwEa71t0TzBjpcUVCgvaPHJ/T6zILD7ACOZbvl3PwZxcQaVNN1nrUoNX/7bJbMYKWP0X3+5DwL2F/F8Od0D3tMlRy/vPvlakiTGJS7rAq3S1MCi/uDlbJ+XUpClCd29YuA09tk8DYi/ohFdERg=
Received: from AS4PR10CA0027.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:5d8::17)
 by VI1PR02MB10250.eurprd02.prod.outlook.com (2603:10a6:800:1ca::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.25; Mon, 30 Jun
 2025 11:30:55 +0000
Received: from AM2PEPF0001C70A.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d8:cafe::38) by AS4PR10CA0027.outlook.office365.com
 (2603:10a6:20b:5d8::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Mon,
 30 Jun 2025 11:30:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM2PEPF0001C70A.mail.protection.outlook.com (10.167.16.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Mon, 30 Jun 2025 11:30:54 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Mon, 30 Jun
 2025 13:30:54 +0200
From: =?UTF-8?q?Kamil=20Hor=C3=A1k=20-=202N?= <kamilh@axis.com>
To: <florian.fainelli@broadcom.com>, <bcm-kernel-feedback-list@broadcom.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>
CC: <kamilh@axis.com>, <netdev@vger.kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <f.fainelli@gmail.com>, <robh@kernel.org>,
	<andrew+netdev@lunn.ch>
Subject: [PATCH net v3 1/4] net: phy: MII-Lite PHY interface mode
Date: Mon, 30 Jun 2025 13:30:30 +0200
Message-ID: <20250630113033.978455-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250630113033.978455-1-kamilh@axis.com>
References: <20250630113033.978455-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C70A:EE_|VI1PR02MB10250:EE_
X-MS-Office365-Filtering-Correlation-Id: 44e276d2-2738-4ed8-4d0b-08ddb7c993a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700013|1800799024|376014|7416014|19092799006|921020;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?M09UT2x1Q3R4K2lSbHUvRDJ5cTA4bWYvYmJIbER1ZmdCUnVGZmxOL2tVMmh2?=
 =?utf-8?B?N2cwcWo4VGpwUTBkL0RzdEdwUFU3dGhGT1N5bUczNWwzM0ZYU2sxRU55OGxj?=
 =?utf-8?B?TEcvTldtWHAvUzV6clNqUWlsRWUreUVITUxLZ2ZTOUZsakV4Z0R0SWE5WkVQ?=
 =?utf-8?B?RElHMFFqeXdDOG9SMkw3bGkrNU5nZGkzdzNsUSt1c2ZFRWtENXRpOWx5L1Bn?=
 =?utf-8?B?ZDRXM09DTXFkRnI0R1pLMTRmeTN3eWN4dTBHSkZZR2pGVEIvQjRPMnUvSFE5?=
 =?utf-8?B?SDRNTEptWkJuZERJUy9XQkxQSkZLQnFCeWFuTllQb1RRMUFuN3U1amF6clpO?=
 =?utf-8?B?TjE1WWRmVEd5UDJYWkVTLzg3dnhaV2h5eHpLWnFPR3ZlY1ByaVFEUWpieEhU?=
 =?utf-8?B?aEpReVRBWTBIR1JuYXN6TW5vZHNiL3NUNGlOTHFmcWdteDdsYkF0NWZWRjFS?=
 =?utf-8?B?T3JxbTE3RzFYUHErbkV0M1hzOWsvMXVtUmF6Wnl5MDY3SWovNjVJNHlvUWl4?=
 =?utf-8?B?VFo2QkIyUWNVZnZtcWVCNDRNZDJ6NVUvRy9zVVMvWTdmL2pMeGF0amVDcXFG?=
 =?utf-8?B?UmhsN2RwSUFlc2lHdXFqSVlTczZoSnM5RFI2TVNOdXVSOUlMZ1c4amNjNHpS?=
 =?utf-8?B?eGlGaitIKzhraHd6SEkvV1U5bS83WHRIQlIvc1FBYUlsblJTcTN4VWh3cll5?=
 =?utf-8?B?SmNWMXJwS05MbDJuMWNqRk4yMDBsYWRPMmpaNnlVSkRoTmJkeE1icytta251?=
 =?utf-8?B?MWlyNmRQeFFoSnVsMSszT283RVZOQlB3SUI4N3EvNEpKdkFiZEE4TFN2bWxy?=
 =?utf-8?B?dGdGOG0xblFwTStXNkxSWUFqKzU0WERBUXVXNFZFcWdZcld0NVdCR0M3OFAr?=
 =?utf-8?B?Y3M3enlzUElqelR0cTNkcHlpODhtWWVTZkJOV3B3eWxucVpoMW5WOGpqYWRI?=
 =?utf-8?B?OEIyeEUyS0ZrOXAvQmoycFNlbHBuangvYnN2bzMyMDgzV3VSOTBabVE1RkRH?=
 =?utf-8?B?MXNWeHY4Y1kvQXVaVDBzdnEvWkxiNjJwSzdEQ2xvT1YxODUydCtSd3BFNDRH?=
 =?utf-8?B?dVNoMHl6R0ZsSW9VZkpQU0d1WFNnMXZPTGovVGVMWnJjd2FVMHpHdWpPZk9m?=
 =?utf-8?B?S0J1WFhyTzJ4azMxeWJyRlEvY000VWZYUFlUSXR4U0tGMGhFMzV0aUp6V3lB?=
 =?utf-8?B?bmVyNHVjb0dyLzA0aDlja1dsemVwWG5xT3ZFNzJUeHg2U2VIU0NROGk1OEJz?=
 =?utf-8?B?K2lnQ21KY0RGRW5zcWZZNkpiclkweGtuRU9ici9DNDgweHZDaVc5QzNzK3Bs?=
 =?utf-8?B?ckYvdmkrWVBGZGtaS1RIUTlES0RkcUxYT1ZicDVDT1kyaDhKeTZzQlNRYU54?=
 =?utf-8?B?REFzcHAvb1dsQ0NjaG9wQ2xoUTRZRURlMFEwdlpDNHhnd1ZVNHZEN1BFMU9B?=
 =?utf-8?B?azVMNGZhbnRrRXZsMWlzMm1udWpPaU92M3FCbjRKUENRVE4vQ3NIM21vT2pE?=
 =?utf-8?B?S3ZRSWs3SVRuWG1tbEdKbWEwN3o4bE9kM3huZmxvQzFGWlhDcmNiZUQ0ZzB2?=
 =?utf-8?B?MFVUeVpIcDZITXEzNFV5eGhpcW9FYUp0Rml6NXBSc3c2NzdFWVdwYTdJcDlp?=
 =?utf-8?B?K2szSFVZUVR2dkJyR2Q0RU1yMWNpTzVzU3BsczhFTGZ0YzVYUUpVVm8rT0Uw?=
 =?utf-8?B?R0VjTUQ3Z2RSeWtrMkNxcU5USDQ0K0R0czZUR3lVOUwwenp6aGlYOWlOSGhZ?=
 =?utf-8?B?bzNmSy9mVDF5c0FjV0VvNCs3czZBc2xOa0RkY3FlR0JDR3hyTXdNSFlhelZi?=
 =?utf-8?B?T3hMeHFpQ0kyY2dOc3pNcHpIdmJ6SzkrU1MzTU9pMG1lQzRIU0RkU2t3cmZX?=
 =?utf-8?B?QTY0RWZXSnFvQThsdENsLytDeW9tV2g5TzZJMjBQMzlBelZpNUFwSjZOZS81?=
 =?utf-8?B?RG4xTXRNdy9OYlZWUzc3OHh6WDJDLzZFNThoK2NndG1kZktJeUlkM25QQW5p?=
 =?utf-8?B?WStOZVVmSlNyYmk1Zk5FZm02RVc5UHRGaGJBVzhuUHlTWEkvcHpxRjA3WHNS?=
 =?utf-8?B?bG0yUEM4OTdQYVZZczNqOXlnWkFjV0hwaHhXdz09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7416014)(19092799006)(921020);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 11:30:54.9588
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 44e276d2-2738-4ed8-4d0b-08ddb7c993a7
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF0001C70A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB10250

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



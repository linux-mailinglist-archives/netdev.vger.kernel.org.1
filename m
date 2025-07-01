Return-Path: <netdev+bounces-202786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A8EE2AEF013
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 09:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94F0E18904DB
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 07:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83F8262D29;
	Tue,  1 Jul 2025 07:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="mbUdiTgO"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013047.outbound.protection.outlook.com [40.107.159.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59A9825EFBF;
	Tue,  1 Jul 2025 07:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751356238; cv=fail; b=jmnSKRSo3vT3TPpqeqarZynhbxQ0KvaAPI1hayt5vtQgiJokyPqkQPriYC1aCsKSQQ+lyRihp3eqCYZzWGXmCUT2S4tNCAQFo1YJonXc0SzogL2Lvqu1yQzw8FPNprM+VTWwPvpI980Lu01iB2ZEzoWJrMeMdlrl3n9mTQo5gDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751356238; c=relaxed/simple;
	bh=U+OJmOvHH7RkWPnZPo1uBuBEVK1OgCV1TmA7KuIw+LA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R8pkj0UJbpN29YW2av85bwr89JmLPiU/E/78BQ/H5HzECXsbHfSszJjAE4VUGPhvZu5OCJi/KoXxmtHGjhiUTZtOc3Cxg/LMXBlw9/ZD4Ah5GEfn16+0MN85uDbZIvwyOjK7yOxClrnBSGlgBj4seqEYj/1zNiPMGmVFkovtqJg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=2n.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=mbUdiTgO; arc=fail smtp.client-ip=40.107.159.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=2n.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MyMgc5Bx+aByEvN1g+EgXuvshzLUwrsmfJDhUitYzjgMdneTbDZjTIxnBIqANYiwQfeDFkUPhR83iPRkat7zPe5sczpdke5bxho6qPJr8uQSPYunxZGjmJ//n09zjaiyVdoQjM8C6/L64bBDkhWdhZc42Jsdcy3EoVyzP+ZehSgg+GmizKi7v3+Q8ZtgTOKb0LPg0v0+SM4/KD1HyQHaXbqjYPeg1Tcpr5W/Exh1VpbZ5GgpnhqMEdQhbPqakZ/0ndrFK8OALocgfH2g4KJZATLQMj2RkWtjJ6b5cYUNfqcFSgiMQgBoHUeg0Rk+TMssC9o98zFjtsd6Oy53zHUIug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6a4DReat2ghkBdi+F2QJLoc/e9uQI6YxLdPcb9cIs1o=;
 b=v3Q/PKnXbDf4dSUcwyj6T45NtpPK1gLyr9jYg9yvTU6I7AW50R/e1fTNLtbrjrToSQuBFLKI5P6br8qqdeWt2c7NsKT/57JvXpkadnA/plB87NIAmxWpFILsdYa6GyZbVEkD8Xb/PKcotrJzPrJiAQOLiICjYFoYzINW6Xib4K15RdG4d30Xnrf1tF3TWEdh5RW9GWbg/8CFbecs8aPoXWAwTcbvJgbGo8s8ry5HvG03j0sBZszVGvQUyuU4SKK2E2bELK48CBkABxJEOEvw+CCy4s70T7MtxZSsvZe7gkGvabPTwR5ZJjBhu/VMzyZBGv0gsxr+443tExpHsZPdPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=broadcom.com smtp.mailfrom=2n.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6a4DReat2ghkBdi+F2QJLoc/e9uQI6YxLdPcb9cIs1o=;
 b=mbUdiTgOOyfJwprjMguKe9XjLz8x8yC/ncCMXHujmbzSnUEbJe3+hXn8QyxiYL7Yx8TaYIO63u9DKvrpjxYsEpu4DbRQKRFhS/3yultKq2rwEdQC5nokVyuIBF+p3KeaxY7OS6RijUnYCsdZq4G2DAmHiq/Tq0H4iAfyftHjX4A=
Received: from AS9PR05CA0339.eurprd05.prod.outlook.com (2603:10a6:20b:490::7)
 by DB9PR02MB8322.eurprd02.prod.outlook.com (2603:10a6:10:395::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Tue, 1 Jul
 2025 07:50:31 +0000
Received: from AM3PEPF00009BA1.eurprd04.prod.outlook.com
 (2603:10a6:20b:490:cafe::30) by AS9PR05CA0339.outlook.office365.com
 (2603:10a6:20b:490::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8880.30 via Frontend Transport; Tue,
 1 Jul 2025 07:50:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=2n.com; dkim=none (message not signed) header.d=none;dmarc=fail
 action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of 2n.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009BA1.mail.protection.outlook.com (10.167.16.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.8901.15 via Frontend Transport; Tue, 1 Jul 2025 07:50:31 +0000
Received: from pcczc3457tyd.2n.cz.axis.com (10.4.0.13) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.44; Tue, 1 Jul
 2025 09:50:30 +0200
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
Subject: [PATCH net v5 1/4] net: phy: MII-Lite PHY interface mode
Date: Tue, 1 Jul 2025 09:50:12 +0200
Message-ID: <20250701075015.2601518-2-kamilh@axis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250701075015.2601518-1-kamilh@axis.com>
References: <20250701075015.2601518-1-kamilh@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009BA1:EE_|DB9PR02MB8322:EE_
X-MS-Office365-Filtering-Correlation-Id: f5127655-8103-4221-7c8e-08ddb873f430
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|36860700013|7416014|376014|82310400026|1800799024|921020|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?YVJqK1Q3aXo4Mkxsb1NWNHJQanVVRzVFSHZxVkpXZzNRdkZmQkJZN3haK0Nn?=
 =?utf-8?B?Y2VXK3NnbkNQTWtRMGszVGRDLzBsZnBucGxDdkhWcXRmajl3ekxZdk9ML0VH?=
 =?utf-8?B?VWhTN0I4TzBaMHdRNTVOTDRack9XSWxwUVcvRStuN3p3enFuR0RlRkNkL1Js?=
 =?utf-8?B?UU4wSTR4R1FpMk1pMVMzdE82K28ySHFHRUN5YlVSWXAvNkEzTklVZmZVTDVQ?=
 =?utf-8?B?K0tDSktOOWttc0M3eVpoTHZoaEd3eVVrWHplMGtuaGFmNWJEMk1ZRzhSSENa?=
 =?utf-8?B?a3lDcmV6eU80UnZZMXZKTUZKMXV3SHlISFd4MDZVZ0pWZDQ5SzBId2N3MDlT?=
 =?utf-8?B?OEZNYU9JUXVlamc2NDdIdHFLeStYSE4yMjc2aEpXVlJ2Q1dsenNyTVllVElX?=
 =?utf-8?B?b2hnVGQ2czFmalBmQXRPRmFWSmFYcnd5QTlCWmRDaGJQY2NhSkdONjFHTGo3?=
 =?utf-8?B?U2RvUjExS05QL2tKWFB1UzRuM0YzVnZLMkZDS0F1OWJ1cGp0cHk3amhJVVVu?=
 =?utf-8?B?WkFUd3pUU3pqSSszbE9oc2JnZmlPbll2YVdKS1JScnVhaDFhdTVmMDZMdEZK?=
 =?utf-8?B?SXozSW1ONGdlQnpoaEZpSHZONlIzRUgyNXBxOU9UR0d2VlFPN3pYUzVDMExr?=
 =?utf-8?B?bE5wUDlNZFlnTWtsRXduN2wzZkJkdXBEdDdKWDBTZlRIbnhwdXFoWmNmWlNC?=
 =?utf-8?B?ZG1JdXpwUVJiMVBPeDUvcEM0T1Rldjk3YVRuWk0wRzk3UjI2eXI1NlJNa2Z2?=
 =?utf-8?B?VUVpMm9VY0JkY1UrQXI3Y01NTU4zYjhxTUZMUGIzOEc3SVRLM09JcXkySEFJ?=
 =?utf-8?B?cmJzQ0NrTWp6ZXQyUi8vUHJwQzRKN0haMUNJM2lIVEhEVS9QeDhlVXhFMURm?=
 =?utf-8?B?NzBaNnY5ZnNCOGJ4V0IySmlKRFVNWE90ODFKbTZ0NkxKamFLcUxWdFdtMzBE?=
 =?utf-8?B?amZlWUxlaE9Xc2ZMYVFGSUpyWlNCcFEweHJNbTdrK0hWdWFQcHFoWXZncGNS?=
 =?utf-8?B?VTZGTWJaNVhiRDVvSUlXTXpBVjR1NFRtY3FSdC9VRCthQmt5a2tOTWhjL2ZU?=
 =?utf-8?B?R05HbDlESVNsTlllUU5RdE5aMzVWd3hQWjdmam9wdi9LM2NMeUxobi8rOW1x?=
 =?utf-8?B?c2k3YlZhdUQ1SS9taU5zU3VsZDEwa1pRNjNMS1BteUJVMEhpOUQ5bnZoOGdj?=
 =?utf-8?B?UDg1aEZqRkg0aXQ5OFVodjdNL0xsRURJN1B5dy85aEFPVUtJRkQ3Vm85Y2dq?=
 =?utf-8?B?eUQxUUpqbUw4RjJBMnV0bkd3Q2F5SGQrM0JrTno5cWc3SlB6Z1pIY1dVUUVr?=
 =?utf-8?B?UXZNSzF5Vnptcjh5cndKWlF4L3BNSWZXWEQ3eVd2U2QzaXU3aUNqWFhhZ0tr?=
 =?utf-8?B?MnhVQ21Vb2UvQm0zb01yNDFNN21XR1ViQzg2enUycW9pTFVVK1NBTEcyZVpy?=
 =?utf-8?B?OGY1c3JEOWZyZmpVU2xYU2ErdFZQUEgxRFV6UUl4U1dRcEhocXYwQVhoWGFP?=
 =?utf-8?B?Y3BXZVUwUVV2K3VXUFlaZWhiUjYzZklKVTJia0tLT2diVGdmMUlpc29qRlo2?=
 =?utf-8?B?TVhMWjNHRkxac3lzQ3RRK2k2dVRYaDRGd2cwanRnRUtvc0UrMEo3aGpKMU52?=
 =?utf-8?B?NlJ5dkdqd2RGZFdkN1NOcVI2OWlHMGs1YWprQTk3d1laYW1rQlNTdW5NUk0v?=
 =?utf-8?B?RTlSQm1hSDNlK1BhSmFDWC9FQ2RndWpGQ1VObHBsdTdqM2tBS0orWjFwWDRy?=
 =?utf-8?B?S1NSb05PWVlqSXpXTmoxbE1IVERFWVhhQ1VrbDJZMnMwRDl6TnFKbkdYNjlr?=
 =?utf-8?B?ZTRqdnY5Tkc1bUNvTmpsQ2JCaFJYRStJWUVIZGJRTVhmcytLOFJ2RVhWN1E5?=
 =?utf-8?B?NVFQek12TUJNRUhNVDQ2WmxwdDg2Qm9nYk9hM1YrcWg1OC9ZbHF0Q2pPejdP?=
 =?utf-8?B?TjZuWE1jTFlXZGRzSzhiN1pMNjczWlFDQ2tVSkszYkZqUE1Dakh3bzVCNzZB?=
 =?utf-8?B?bWRINHg4Z2pXL281bWp2dGJoOUJoeTh0aXQ1TngzcGx6eXBXNklWSzIvNzJz?=
 =?utf-8?B?NlhWL2RmTUUrcTU3VGJOanQvK0RJaHZjcnJHUT09?=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(19092799006)(36860700013)(7416014)(376014)(82310400026)(1800799024)(921020)(7053199007);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 07:50:31.3650
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5127655-8103-4221-7c8e-08ddb873f430
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009BA1.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR02MB8322

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



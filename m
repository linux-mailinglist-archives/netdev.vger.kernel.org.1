Return-Path: <netdev+bounces-279219-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aLrOBOag4Wm6vwAAu9opvQ
	(envelope-from <netdev+bounces-279219-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:54:30 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B17441662C
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 04:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 403323094B62
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 02:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 336B6310652;
	Fri, 17 Apr 2026 02:45:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E255309EEB;
	Fri, 17 Apr 2026 02:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776393950; cv=fail; b=HEJHHl8nUB2fvglnQCohDX3eMCYtpfyzYiUGli/ihCmvvoqdv9xyXCfTRJQ+wGC469SB7DL13qNUPqx8l4aKPIIlwEFkkujb+Oesvifeor/QGsZvQXUuQcn0uNIjl2CiWWaUCnCwNx0L4wLBeimZ+mXGcDGV7QsEK+2Dn6koc0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776393950; c=relaxed/simple;
	bh=ETH1xza2+vc2EFuWCY6JZ+FwBbkzijc2y43fX7Sl+aI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WeG88NntAB1Tp69mwtrctMzfbgdYSk5TKSMQduqX4UI2QOJUmhtD1mVS9nVvTU5q2g4lgpoP/nqEg2UFIcbkmIXpNd2vsiBbnOK1B2MqBl6Zm8Hglyp1KA2w+4cCktjwFl7N61Egjtb7GAdiTqUhUh9Nrhfq0VYuUjP9Bnwhij8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nOFAs7zIIh9O9avw3V1QKI17pL9ResX5MOv7uBEOHD/4EV9iPI5Rl52IxH7kdZrgYE8jp+t/XEAf6AevI/eDL+MhLm/+zXKs2peEXmhLv4cqS0NfpG9wpqGO69d1czbiLtfZrMb/jekAEGeskZOZKHQt6VUXTX6XMvTHrj7jrSWBaYEfljdgMGa1HZSlqkQEFK3qOzfS945vZmJ7HcYlmfJ0Y8LJK7Ar+n+SXGIQ92hES6zpRXY9ekIuzVFIyx4dGsD4mVHgtllWuc5CBmBowUGpu8mF97cT5YZithB7KpzSeO+dwpgIqKLHUzKojasrhmQzFpT5fFX1RR900U3SWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i+10xODl56HJQGaS/vXtH4yad5Lnn9iLeNwV4HoOUgU=;
 b=HXqm/i2GnoZsi8Nwv38TUhLuqovmWVEwK/LRSHnnw8cVXFojTsoPguGTU7M3q2S4PEdPtgkY5fXIVTstwlJTO0T22e12CEu//ZHeJuTzAyVZaxR6EUoxn9mICn/w6Km8JjIpz1PGVFrLcMW7Zk6kCLnd71zrFZQgR9pnRI6cqTFyvkENpe6iHT6qCOrPkR5+NbP1DO7cFTxGUizMWtnKJxoYoD/+h02eowo8vXLD+aF2sNvZzCfSsrWp2svdI6azSDn/9HWQ4M8q8uOG8hdxfRiP+eH3RR+2QUwZdCfeQKeqX311BGl+iSif3+wEbNU9jkrEsDhsY63yeGuZ5Cxz3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0517.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 02:45:35 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9769.046; Fri, 17 Apr 2026 02:45:35 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Emil Renner Berthing <emil.renner.berthing@canonical.com>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v2 3/5] dt-bindings: net: starfive,jh7110-dwmac: Add JHB100 sgmii rx clk
Date: Fri, 17 Apr 2026 10:45:21 +0800
Message-Id: <20260417024523.107786-4-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260417024523.107786-1-minda.chen@starfivetech.com>
References: <20260417024523.107786-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: ZQ0PR01CA0036.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:2::20) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0517:EE_
X-MS-Office365-Filtering-Correlation-Id: 36843234-009c-4201-0c6e-08de9c2b6699
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	IPPGFHhJl/QlyumHrlCktvgzgACkKWqC4PpDf4CM610J4fXrDMBTj3EwodQIErvwWhBQ+Rhi8KzGaae6VtE6KMmlLvRFCicKHDQUV71+D/+BinwmMLEAILrb3wpVaHzCLEx4J2qEmgyhRT1U0BLpwaSXmJk/SDoR6FaaUzrZuKypUNCDY/pKNOlrh4aPUOAmKP6KSIlzJKF7gRUlc/AEYCzwy6xOchl0alzGX+NnviCiZn48BgqlsXircSsAfil4bv+aStYW0g7aTzP9L5FTfKLeFmOJ+x4aIPyEWuZ2VUP/NgdIRTtH207LU0QqWLc09W+o1Y9VXNdpFmJ4leoqHmS9/+lLuQEhAsjiarvdXEXNxz8NnQ1UIcHpRQ0TU/4ENIlS4YamlehdecDctCzEKTA6nVnAupEaQnQicFgi/rH/6aJ+o+dtO4Lnn0WgvjQ4HVYSqKWNKOLW+3eMRsYBEeuCwfFsiARIE2MJ3b6usvRpdHJM6CujPH5Rhcyii6+MM4NEcalpYHZ7g7XZz88KvEEWu7NRfptqO9Va5e8rI0pHeBSahIM45J6Usz8MSBrg7Qa44Dh0kj0B5tRHsgYWJ2/1Dtdtd7D9dXDJnr2LmHM=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?tHh1MH95jn9IGPaaMVacunOf9fYX7khFOV6OueWvD92eAd3NBhsZYaYbCR4P?=
 =?us-ascii?Q?6KkdM5iSg4Q2o1PXg8BpoQjAYj0dX2W56V0mPGr/YsDlncHbYeYEzSpubMSC?=
 =?us-ascii?Q?mmRmFDfsMjkW+vPsEe/23zajNo/4zvkVst3ij6Su9FdqjIOOvI2cnLwEXIsi?=
 =?us-ascii?Q?tcNXcIDszmdh5me2EHFudpeAdUKRAEPRYea5OZ7SselfwRv4NI4ZMY25vV0T?=
 =?us-ascii?Q?A+3VFESTCj3VA6l5d/30NB8tLvgWI259sPwKabYFWPTnwqebAjNA3sZPLjk+?=
 =?us-ascii?Q?7Xb1Dlwlsdj7HQ4wOKsAsVSzO+U8Fv6RiZs1bcBsl+5kSWbBPfVL3c6KxWgd?=
 =?us-ascii?Q?BHep0Jgf1bjxp0ikqgrV1c5ScGT+ckItTbCUI3IPk3tRit0CnDcQVuEk6l5F?=
 =?us-ascii?Q?L65I04VBaU2q9sTTBkbPSikitBGQqBDmOIjMPvYCMIw211w+Z4yVna1jaPlM?=
 =?us-ascii?Q?0liU+HD0MRna+FDmKvKPVFzJ4aGJy1Mnnp5V25sDkZhrZ0aEifNzmNrKK3KD?=
 =?us-ascii?Q?mQ4WbbVenPjNOWLVoJlyMhjdQme5AVo26A/UM6ZEJbVHxCZqAmpqlNi24Jzo?=
 =?us-ascii?Q?TJ96XngNsIcS2egFaPaLDWiouGF2TtYWkuTkoyc8+n2uYT+pdHeWU50lhEMq?=
 =?us-ascii?Q?hWJKn/P03nPHfSJ/UwQHeDfU9vI12+Z5kLHj9dRZtMUJp/PSnascuTGyeVwi?=
 =?us-ascii?Q?IrW9Ap4r4YZZbNyHtQmTVXQNeB2Y5B7HzQJQgDeW8kIRXm72Njs+/o2k4gPD?=
 =?us-ascii?Q?WhBiCfZTaWPV3jikfb2tefUhPDUQIt6hGGRLn6sapTdiQSDfxLz0Gqu2ybub?=
 =?us-ascii?Q?tqJ8Dnj6kweaLu9/deXbN4gKxA+0nRLU+9/c+ry9rT7/D10x1mWQmuo7IQtx?=
 =?us-ascii?Q?vyVDQeqRyF5EucReicMibUEeMEz7SE32egbt4yPRoSbX11B5/oUGbSCL9PrF?=
 =?us-ascii?Q?LZzEN2uyhV9/IAf8ETLZx4V5TB3IQ6l1b+w2mJlTeuz6YYj9u27KM+wkWlW3?=
 =?us-ascii?Q?NqVjS9rdcXdibvbWLVxodwTuK46QrpEoAKaVa4L2gS9zU32HHGc2CxmNlMs0?=
 =?us-ascii?Q?4hjgj3sa9gdmGMCiVHqARGJJQogUtrCfZr7c1jlcAjo8Fc9HB6JfKtlMZFMJ?=
 =?us-ascii?Q?Uf4i196ehUPC2B5SpYhScThurDy3G1oouZgvZHlurLcGbZTYzBzYcspqZWmN?=
 =?us-ascii?Q?YhjqLglyYIWIZyDdLjSMQg7QhggNRu2Px+bk+yR060Fe8yeEfRygY5e207Eg?=
 =?us-ascii?Q?9VKpADRBO8CQkH4ASq7pWgeJMBTjf/6HOcVDx6LX32cLM2iFMXDQwOLmypux?=
 =?us-ascii?Q?9db2AyvEQdqIBb1v9hvUcKtZI2aFjUphZvRBb6OWosr23Prd4WXaEUscR2Eq?=
 =?us-ascii?Q?R+I28AEUCmwVeRUNAF330WphQN7vewSlGWsQmXydPAzF4QvOKWKlIAMCALUG?=
 =?us-ascii?Q?dGI0S1VGmtoprull6CiC21Z/uxfsw4b34m3WudQ8UMO1MCsPYQES/MdyLaVy?=
 =?us-ascii?Q?QTQN0dlXomKVQKeDnfpOQ6Evel3m0vgVaaUTe91cYReUYBDneTXdWhQNOMtd?=
 =?us-ascii?Q?zxLzNwsBY1K52r8Au1DmU+5F3qVxYn1iyeeiWmJ1Y/o8ln1ZlpTK9Lg57cQ7?=
 =?us-ascii?Q?UObN7s51DkGxb6vV2mCPY4qE0cv7pkBvL8Naxart8JCZJp4KgXMugrHwGARV?=
 =?us-ascii?Q?varnyanXXxCRbAHfd0rZZEi5LPOnpPR8pBS5Hzb0oLKq1rO7y7Cs5sAy0Fni?=
 =?us-ascii?Q?rHVSeYuUE9UPwwvY2g7+WI7o7gH13B0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 36843234-009c-4201-0c6e-08de9c2b6699
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 02:45:35.3154
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2u233lNkBRPGn97+Han1Dkz7NJ74UxCgAHTj4pNPa1GybN8xg3JVdeP6sX8NLUHFUguvn3dvL7QUrutVQttCEESR478t0idRmgj32Jsitas=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0517
X-Spamd-Result: default: False [5.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-279219-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,body];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.802];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,starfivetech.com:mid,starfivetech.com:email]
X-Rspamd-Queue-Id: 7B17441662C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

JHB100 SGMII interface tx/rx mac clock is split and require to
set clock rate in 10M/100M/1000M speed. So dts need to add a
new rx clock in code, dts and dt binding doc.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 42 ++++++++++++++++---
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index edc246a71ce3..3802cdbf1848 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -39,20 +39,26 @@ properties:
     maxItems: 1
 
   clocks:
+    minItems: 5
     items:
       - description: GMAC main clock
       - description: GMAC AHB clock
       - description: PTP clock
       - description: TX clock
       - description: GTX clock
+      - description: SGMII RX clock
 
   clock-names:
-    items:
-      - const: stmmaceth
-      - const: pclk
-      - const: ptp_ref
-      - const: tx
-      - const: gtx
+    minItems: 5
+    maxItems: 6
+    contains:
+      enum:
+       - stmmaceth
+       - pclk
+       - ptp_ref
+       - tx
+       - gtx
+       - sgmii_rx
 
   starfive,tx-use-rgmii-clk:
     description:
@@ -99,6 +105,14 @@ allOf:
           minItems: 2
           maxItems: 2
 
+        clocks:
+          minItems: 5
+          maxItems: 5
+
+        clock-names:
+          minItems: 5
+          maxItems: 5
+
         resets:
           maxItems: 1
 
@@ -120,6 +134,14 @@ allOf:
           minItems: 3
           maxItems: 3
 
+        clocks:
+          minItems: 5
+          maxItems: 5
+
+        clock-names:
+          minItems: 5
+          maxItems: 5
+
         resets:
           minItems: 2
 
@@ -139,6 +161,14 @@ allOf:
         interrupt-names:
           const: macirq
 
+        clocks:
+          minItems: 5
+          maxItems: 6
+
+        clock-names:
+          minItems: 5
+          maxItems: 6
+
         resets:
           maxItems: 1
 
-- 
2.17.1



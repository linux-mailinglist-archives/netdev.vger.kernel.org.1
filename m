Return-Path: <netdev+bounces-292204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCuLMFGzFmokogcAu9opvQ
	(envelope-from <netdev+bounces-292204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:03:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DAD5E17B6
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 11:03:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5463E303D4C9
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 08:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE6473E3DA1;
	Wed, 27 May 2026 08:57:23 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2094.outbound.protection.partner.outlook.cn [139.219.17.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C1E43976AD;
	Wed, 27 May 2026 08:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.94
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779872243; cv=fail; b=fdYA5JmY1uB93HS908dfeYKQZ/2afZ9qSLJnacRLMMup97BEdmoEG9YxqWyrG8PG/oijQ0cpZC+J7aW+odaye1oJtOkTIelD2l5ATcTslbv3MFcjBwDeywH5tH5zYPX2IfKNvF4Ax+6OBcl/0OM94MpJywLUim+tNYs0FELvX1E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779872243; c=relaxed/simple;
	bh=1iJd646GxOzoes16DECFJtrhEizDWQVqg9DrnrK8zuY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=H8sjqKtS3kACg2ZxtQBIEjHdV+rqXYcxoNpLSQPyOsQUolvJTp3oa4tj33ztajkWhpuYZn+6B3AmRouIM7pTExr1+bi2gOsHITk5pDwvEsSO3Dr9K7T/TG/9w5nfCi8UV/go218A2+v0+An3+cxginjL04rhrXy7uacsqoxdQ9s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VH1YlIdVj7nA0b4iFeaU383GjSiZ82GvHlZXcWAUl5Nqugb44aoL4ouIQImm4/lH7TtuUvdS2iw652I0LmeE8xJTxRAaAGOJrA1X/SUmH4dZ5zxxvbDt0r1wFePDefLcZI/YwlFnzI00z9LQtBzqZoTcjFLEPQcKu3KP/UsqPfKm6akAqVHlrseVJ97I+fy3veTGr/dCRNWomMPAGYQa+qujP0Z1rwGklFBu789IRMUFh2stg6+ncr7Qm9qzypd56sFc0a8qWPxHrMG6BTj1ZocASH9vXn+lNpjav7TUw7phH/Ny7WBZ3E1LwucmuZmBaw/RppFl9o5foXugqNJKow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SyUu4EST6HBvepKNZQyws64F0GAJgZBVAEOdg7IuhSU=;
 b=lqOxt+kFdDOqeMNEDT2yBDW4j+Gkvu/cQebscoVMmgY3Sk7mZM52e69roOuFQmLYqHGCXqzSF9q2eVYPIU4fYBa78osGft6YYSm56pRhcqKfldNdUowWBHylcsHH5T+rYTSfc6hnm6cRKqVOTuWO2uaI6ZZgF1xvzJbUTKR9RS0pJe2lBOvY7skivtbobR8Nuf4agIdQXcIdrNzKxADHyEV854v+4mim8JlZz1fnxfy8EoH02PrW89udXI0PF7aTpoENE0Ll5/azEem33zrQCdxgzKevKZwJ0sWkrcaxqJVxxS0EYkGOO12cM/os9j0Toe++Io6ENwnrVtqeRJBe0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0829.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Wed, 27 May
 2026 08:41:17 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Wed, 27 May 2026 08:41:17 +0000
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
Subject: [net-next v5 2/4] dt-bindings: net: starfive,jh7110-dwmac: Add jhb100 support
Date: Wed, 27 May 2026 16:41:06 +0800
Message-Id: <20260527084108.121416-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260527084108.121416-1-minda.chen@starfivetech.com>
References: <20260527084108.121416-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SH0PR01CA0014.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:5::26) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0829:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b7ac6c1-577f-4cb0-9bae-08debbcbb831
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|52116014|1800799024|38350700014|22082099003|921020|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
 ttKwAEmRZPcLPesrR75AF6TgbpwRDwHSQ19ypgyLSld+EgD1Z3azAggaegI4VWvEcBlzCCdbGF0q6s6CcX6Fi+YoMVo9mPhBCrYuGFTosnegpsJX4MkIaBDgawOao0easWZJ/YoDazJi6UWU8WSYDJKTWidx9GRfIFStv9ZdVy/cFcO0bITBA2iDshapEnxXlUPnSzGw3ww2xVOEfeY7jE1rTwJ2kDXqzFSUCQD82W4n1Bt4lm7MWaA3sJtPhZobvyEezJlKd21VwIjTh2bOopWJvUBw4+Pw84goToTp19ZmoiFfLqsH8LeRDc44a6JrBBLziDJJgzLK2OheD27FP35xmeewB7PHhmC7oswDHtdw7bnkvJ/uXyXnHhwMrtSvB9HyR8BXeVqEnzPByRJjGrR3xdnN9Wr5JXl10YbhEb74Wh02lDgTPkL3MvXq2kEbGS25mbhJymDR3G3cZttxyi4gw3XqFdqljBWc+w4JgjwL/IqwaRoNoH4loKn1KxEv/XsCMSADhw+en3S/SShu+5Tr0QfxjzeTMFi6xPwmKXG9Tiw9mGW04/N1syHJPA5z35Xmak5ckF7jX2ffdvJlUQ==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(38350700014)(22082099003)(921020)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?KLzAFlcPK3D17Ru2d8/6Ctxy1JCA/hVeFhmqPuiL7Mx5bPSf5e4tL97AY8v1?=
 =?us-ascii?Q?jC9tg60d/YWn0EwAbEdpcNkjO+7pdD8VjkGr4UpZd+yM5PUIWDvw2azokIQG?=
 =?us-ascii?Q?BsBsu74wyMzdhPT1czg1JcgM6hGmfjPCc4hDxKdXfX/5z/dZaPBqorV1hB2W?=
 =?us-ascii?Q?K/ogK4Ez3+1YPenNrMEB4hHg3UvPXEoye41v+fkJsMhz9M4W0g5MdD2Y88E3?=
 =?us-ascii?Q?YjqCfnjSCRTQA9e+0Vxy4tzLdLimRMsPOw0B201f4GEXUwY/XUIlLGOb2mct?=
 =?us-ascii?Q?HuPQ1qcsVQrw3m5cN2ZKbPcMOj8kG018L4u7UicQkle8xQF10g/76+icJ+vW?=
 =?us-ascii?Q?0/lrT+MWIGMZhINyhvmEvOPL8ysEYhZgyFw9sHKAtmgThcYmHGmFO9zoK7ZI?=
 =?us-ascii?Q?BXcGyJ0hOX8N9Bw7ev7C3rf47F8Ep1NAIUO06mthcuxhjwfju8lR+cqJ3C98?=
 =?us-ascii?Q?jY4FgsoL8MDfkejGof7m5utFudZVCajGXFlvn7dMRJPRNiYGSOEYm1FDqv7o?=
 =?us-ascii?Q?KrCBjcfHZL3FrXshO9UY5aIi0M5DfQNPXbN+BkQsReBfEGdyNFOqAt+4FjkE?=
 =?us-ascii?Q?ob2o/pYeTj3VgF6GlSW4s9AURepcOiVMSicpulkhRaJ3+T80It7xm0vHm6wx?=
 =?us-ascii?Q?WEojImNfNsvjFh9RvH7uxvdgRhin7Hmpy4heV5xgNc08Cw/zP5h45FM3dSA+?=
 =?us-ascii?Q?zplQUPBFfxslanoB6BWbRGwqiki/AZn53IxtXwp2twUFbgSjPoDpltixVtAs?=
 =?us-ascii?Q?OmpO1zphKhrovgpvbn2214vZL5GaCSukJ8o/Uxr+MDjX0LHOzfGTR99XnUze?=
 =?us-ascii?Q?7sLT7Mg39RXye96qFetE/ufe8g3STyOgBoE1p8GMplxX540BDpKPemeuMb4x?=
 =?us-ascii?Q?dxefs5TZoQJ07vZImH+YpQAD+PloCrOQQU2CX7axk25t91pRFHynKqlBYlGd?=
 =?us-ascii?Q?6gtLdUdWSTKXL1OtW7NZ98pLgJIgIpczYqVykd01JZSThad4a1fCkrIXtzdT?=
 =?us-ascii?Q?Kt3u2iXtN5eYCBKKz3ndAn4KehoDbzeQAZSrm00eK/uf+VTSJ61H0UlXp9Kb?=
 =?us-ascii?Q?Da/VY4C7gmGqzp8ERI8frixCaxfGICwZsrYAcCWbiZFRc35W0Aq3nQiWGwNM?=
 =?us-ascii?Q?Krq/8wc3WtTTmIuh34sZBYexba6gkf7taZ+GT7xR114lSyF+Z++lnFTjcD5F?=
 =?us-ascii?Q?qqoorNxlYtxB7J3fVdLkKM5S/gsIafEGbhnZgzcQBfF+4eHxk8q8xHc3KrnC?=
 =?us-ascii?Q?QKxwP4FYn5qFo/tkm4Y5fQG0yHK7OcjUqjla7fOo21NnaSsnz+TJZhlegQMg?=
 =?us-ascii?Q?d1uShFxe8/sAZXJjii0uBkHQCUBpXCBFT5LH/deDFtLzBAZ+apu6/+Q6B3Af?=
 =?us-ascii?Q?ZqbFymdKgBBpEHoaZr1O+vWfZdw3riBA24AYM3xepP5u2EnVxrTv0jIhaaGg?=
 =?us-ascii?Q?kNIwPTo50MFao1L/nMe4WuDsVXKMkvsidLo9bomBgRqphqWkqhdlD2PnYa+f?=
 =?us-ascii?Q?wF+3kRzWbaL6Srq6QfWO7lGw3kUrMiRec3Fyx4LcIeV2q+852lRdqBaDwL4o?=
 =?us-ascii?Q?xVEm2M6vg9dTrM9wgj9Ya9QjY/6YprYdHlfU3fx+pFg/DAiSd2OLiKoBG2r6?=
 =?us-ascii?Q?5YzmMRxOYYCmpNJSQQDmCWzoMnclIn6YfVmT0x7e6aSZtv+bP3L/dSmrMlx8?=
 =?us-ascii?Q?UXX7MSqYq+Yrjc69hsTel/KbJ6mDHB6Cp8sl19vf9cplrTZ8UmpuQhmr2YKM?=
 =?us-ascii?Q?jTMyKQ+eHNJYb3OLAqILIHWmyvcNbIE=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b7ac6c1-577f-4cb0-9bae-08debbcbb831
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 08:41:17.7152
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: V4HCKn8/i/HZpE49AAEPJFVFNnvX6mzqSX6E9KE8f8J4zyHbgMYfc3B1sLcPuBCGWuXMIAwCAzPtPrRyHJhyHuTO05GuHrLcCr6bgbhJmo8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0829
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292204-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.220];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,microchip.com:email,starfivetech.com:mid,starfivetech.com:email]
X-Rspamd-Queue-Id: 05DAD5E17B6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The jhb100 GMAC still using Synopsys designware GMAC core.
hardware features are similar with jh7100.

Add jhb100 GMAC compatible and reset, interrupts features.
jhb100 dwmac has only one reset signal and one interrupt
line.

jhb100 SGMII interface tx/rx mac clock is split and require to
set clock rate in 10M/100M/1000M speed. So dts need to add a
new rx clock in code, dts and dt binding doc.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
---
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 55 ++++++++++++++-----
 1 file changed, 41 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index 0d1962980f57..fdcc61c65f87 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -30,25 +30,33 @@ properties:
       - items:
           - const: starfive,jh7110-dwmac
           - const: snps,dwmac-5.20
+      - items:
+          - const: starfive,jhb100-dwmac
+          - const: starfive,jh7110-dwmac
+          - const: snps,dwmac-5.20
 
   reg:
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
+    minItems: 5
     items:
       - const: stmmaceth
       - const: pclk
       - const: ptp_ref
       - const: tx
       - const: gtx
+      - const: sgmii_rx
 
   starfive,tx-use-rgmii-clk:
     description:
@@ -107,20 +115,39 @@ allOf:
           contains:
             const: starfive,jh7110-dwmac
     then:
-      properties:
-        interrupts:
-          minItems: 3
-          maxItems: 3
-
-        interrupt-names:
-          minItems: 3
-          maxItems: 3
-
-        resets:
-          minItems: 2
-
-        reset-names:
-          minItems: 2
+      if:
+        properties:
+          compatible:
+            contains:
+              const: starfive,jhb100-dwmac
+      then:
+        properties:
+          interrupts:
+            maxItems: 1
+
+          interrupt-names:
+            const: macirq
+
+          resets:
+            maxItems: 1
+
+          reset-names:
+            const: stmmaceth
+      else:
+        properties:
+          interrupts:
+            minItems: 3
+            maxItems: 3
+
+          interrupt-names:
+            minItems: 3
+            maxItems: 3
+
+          resets:
+            minItems: 2
+
+          reset-names:
+            minItems: 2
 
 unevaluatedProperties: false
 
-- 
2.17.1



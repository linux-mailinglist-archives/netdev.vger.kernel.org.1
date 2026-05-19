Return-Path: <netdev+bounces-289384-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MNoJFPE5DGp8aQUAu9opvQ
	(envelope-from <netdev+bounces-289384-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:22:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BB05457C23B
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 12:22:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6481A3029A46
	for <lists+netdev@lfdr.de>; Tue, 19 May 2026 10:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07EDC4B8DC2;
	Tue, 19 May 2026 10:15:27 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2123.outbound.protection.partner.outlook.cn [139.219.146.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1363947DD7C;
	Tue, 19 May 2026 10:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.123
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779185724; cv=fail; b=GyzOJX6AG8P7RWY9xuUj8QpWr2ffilU+slqa/wIVRIxyQJVSDunnPV/BgFSq4ogneGacERJ+5iGhiwB4gfhQVyrZ3Tods3JA2+/Sx7gcHbhIYXuWSaj9UJDmyqTKkAVHyXJOdHjfkvL1Pejai7mWXnAYHjlVuD1TrI3EuyAJFqk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779185724; c=relaxed/simple;
	bh=0mu6UxoakgfMCFAA1LRdfrl4D/HveT1GAO/c3wow8rY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iF7E4VWL24AanADmBemWwXBv9atYsekCMLXBI5iXoghVUvzq2TjZRmSiuXw2QNryUcUrIVC6UN5IEA5/qPfgDQucxsd1c64X9fQN+KfMfWSV7HLPg7MrAQuZsSLmDivzD4d8wS+11iLUwE+7fwwC5nt0CeX5TcfXasZqSeK7K30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BBDZhL+ut/TWF5i0GD+dI5rsURVo3NYxLDwNilIeBOHKrdhWzUubDFJ8kN3tiBXWF/l+jXl3TpapxoFCnQBcQd1Cvrso4uW0r322ERs20aSsR1ihdxTh5SDHpEAbVy4vd70MXeQOPyc2Y3Hxg1/sn7nX5Pwyl3U8QWWgWDtp9bSAe95/1Sjwh52LogVJTL6rhxHlcyVXibz+FEGEnPKN5Qzs2amQZBphD33NGb/yn87MOcr3Mppn2qWNEE4TKgUvXuIMYMPGWgScNuOWEP49vUA86VyT2KjapXJ4l72BBbpIWxRKtXcj+vpera+2NQyulCEEP3IHwH9HwASJAA5Yug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hxJobuoN9Xxk6KUYNZ2BpZ/tx6UOqD4aMDKtmwQz0/o=;
 b=Ukw8sTTZJLTeCDiO99xxCGtbeIPeHOXrTFLhfq92oLx30sCQltpH9syIXvPpoS7glJAG4SNL8B1UEyWcyAzMnCykwSyFxSmi+B/IGqE1PxRHAkjKZd5VwJahd7LffSQz9DjSJoJihJpxaq6GN01PAdpXYYF/PxsJLnbChjOgS25R9lCygmcMtmXUCBqvT5RcPxZy9502I6fTwCvrMp1lbUgNkfiQ1KXED8XhfLDEAm4elQbQDMIH7ervxwQgEUIB7fyPKUUI27Bx81UPMNQyKLD/yBGTCZG5C/vMOTSvtNV/Cv27/ED5wK2o0rhH7EulNY+TiQ+cKPx6iGwN82x8PQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0493.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1e::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.24; Tue, 19 May
 2026 10:14:48 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Tue, 19 May 2026 10:14:48 +0000
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
Subject: [net-next v4 2/5] dt-bindings: net: starfive,jh7110-dwmac: Add jhb100 support
Date: Tue, 19 May 2026 18:14:33 +0800
Message-Id: <20260519101436.111476-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260519101436.111476-1-minda.chen@starfivetech.com>
References: <20260519101436.111476-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJXPR01CA0056.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:12::23) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0493:EE_
X-MS-Office365-Filtering-Correlation-Id: d09f5e4c-2653-4830-e59b-08deb58f7549
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|7416014|1800799024|22082099003|18002099003|56012099003|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	uv2hYS5IXU+UeRvAW2sTw96A5mAJXXbNj7ENyXvwl5S6r7atjEaOA/RMtwDeMf8cCmksbVTv+bzMWxjLkF7AkBZaE/7I0+C23SRXaNhL+Tl7KA4gC/5X1MyWn/y1JzRW16eCWoJtB7b/1E6NH5jFhAnFZn2+gyAfJPS0YLG0LanlwnkqINhzGBIwR/MmfjwyBw45KJMIUVa1eqRqE4nQL4G4u+dEf8ofqiXmutce+8pTT/FyHbcQ2nhWo2O9cKkv14SAQqDv/64d/hO8zy0BX1CbnvhGkzFIBphNzSmhCXOi/WnM2vWp7jp9Q5xX9WgIqgpwiAg7RJAyk2QTo8wkqdRcaYSAiQDetWBTqvL3CRkpvxIrbG3G/5UizQU14ub22yPi0cVV17tw1/HNuwXItFsl9PhQzKkav/l3IC6olZy4KnVN8gBKbBodq2lWGiJ+xiAysslqh6O8eGKprdzQAGsbTstt1X9MZxw0li5e6nui6nWB4JMBKLSzFKN5OoZGFYY7fy/vU7O2WMJ4ErGyJ5fw1Af5GXK3nKItVDj3KiJeP+rMNdzJGhUo88nMSx5SV3Rr973X1x5I54HMymosRQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(7416014)(1800799024)(22082099003)(18002099003)(56012099003)(38350700014)(921020);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hZPThOk/n79jUGo2tTT2oHd6woYsoaCHNafoZVNSjYWTwmzrC3oZcFEv/UUN?=
 =?us-ascii?Q?IYhAw0Vdu6xSHNdJHfJlR1wDk/skC1uUKTmLuhZo8ng9Xw2W8lHIe+9FKuPc?=
 =?us-ascii?Q?4oLcBxAhWKkz3vc7p3/+awpiA1CGp2MJ15yKAem4rw2V2GzqSEnIP1PD8wFF?=
 =?us-ascii?Q?ixgmfy7Iu5Agzsdot3kMt+f9BVk1MxgSdc9RmoysgRdamP4UiBRcyoB6VlSa?=
 =?us-ascii?Q?qkYQc5NoPuWbdRQtGcSjYs+a0HPEpJGwyj8U7w1eoejs+jEBiJFssr3wXm1K?=
 =?us-ascii?Q?NRydhRw81FaYm+XjS8GC3RB6sOjeG9mElssN1P4dKeD++xipg+F4et50oeLO?=
 =?us-ascii?Q?qC7nGKsoO2ItS0TWzklOqIsIIECpdhXrqqQ+ppOzeGEkP9DvtcAayuSHQeo5?=
 =?us-ascii?Q?qsc1A51BFmGVCiJNgsLKBOGHQNLn0Uf/TAmD0IwEiHpR6X09SoJxLW2dyTWf?=
 =?us-ascii?Q?DeZB0azLuMG3ev62CceK+V9THDyOZroX86lK3vef4tL4lmG25yXEst535lyd?=
 =?us-ascii?Q?NXencLBFxKzPoZgKAqtka5FhTHgaVAyl0LJhLxp7epmn86e2t+DFfHfHVC0F?=
 =?us-ascii?Q?PtfhMl/jM4X/U3Tto2ABbVQUSKo9jq7V55BEdnjoW1dqjj+rvncjUab23nU4?=
 =?us-ascii?Q?y0n36BL2Lw09WR7rA5OeUaVCIXsqzgYpdLXvd+khttTk5yIFBPhQLd8U3O2G?=
 =?us-ascii?Q?b4wCrS5slErupXfp1fB6T/6QD0mM120woCoGQXrqPLvV4FgQpjusMX0bKNBD?=
 =?us-ascii?Q?6dCHhVZz1+Z3gmTi5XFbFohrPkxf0Xm7p1A2YpXF0WY67WWKQf1SQHgfdIJM?=
 =?us-ascii?Q?Jhh2DYFlMHBz9w4Y4rDpdaqnldyCp5heaWQo0wnp8E/bPZa7q2/a9Gi6DC08?=
 =?us-ascii?Q?DN9LJ3rIpdH/3UnkpAbN08W/HTLOEkcu0j9omaeJ60tKosqZa3EXFldRbHrV?=
 =?us-ascii?Q?7OsAChQrZ9j3Y6PFazbzm6GDWWrRDlaVNqNOcIqUn9//pFBtGUvFeppTCR0M?=
 =?us-ascii?Q?pevHX5k/zOGn5G11itYwFugt4TvB5lyduspNvr8ntBrL3dnjSzYktKZOFtgZ?=
 =?us-ascii?Q?Btu2VLQlPVRdsPtNo6kw5mKuXKmGE0OV4GGcnGYsx7Hu7okFALaqB1H0MOxU?=
 =?us-ascii?Q?E9xJHaPLaJ19heMpZQjvJpCxuNM/DhmZzqpsKKehzRpC4PbTqnagwcLQRldI?=
 =?us-ascii?Q?Ky2R2jmkvFf83j/rr9Oog1cebwRJBGYlISbB8qBr4S060VhkKWVK1eCTUE4f?=
 =?us-ascii?Q?Zza4WkL4pVHRjJuBiK5JMRooW9JTutrgseZlVH9Yceo2yq1CuUYQcVbwmQX8?=
 =?us-ascii?Q?WgNrYn/0vEMiBUvFXGUGQ6T4/n/T7YIMKyQRnnb1KiCvJTSBgTa7GKZOdYM8?=
 =?us-ascii?Q?G+CzoK4OTX313MJyif6WMmniXePx8PytVLKWlguPNVrrl7TzJqVdYr5eErN4?=
 =?us-ascii?Q?TUVMSJyrsbrEMqLPOLUCZvZe1gbsdmAoGtAihgSmwowUroN5QR6djynsd8bU?=
 =?us-ascii?Q?Ek/Pb01K864wZYt/GCaiPTVlLCeoD/EVSTkeHoYYr+EYcKvqWvAd42qdkE8K?=
 =?us-ascii?Q?HW1oer6DFCEVN9yaFPsFXoM6g3DPRFZKyGDzse+J0f9ghTaRsqOXYRrvenwu?=
 =?us-ascii?Q?6IkDlzQlOZklp9Pq2Ljg/gEVae7xpqCcspnjhtNdN5whT2Cdoxo5E9o56wyA?=
 =?us-ascii?Q?iUZxIsA8mC7klxoRcc63bORl5GFSNGrKFdYiF6FxtPjok+z6C45XYSS6vRSh?=
 =?us-ascii?Q?Gy0f7MPlTDJ2A50Q6/4+Z5f6P3ppB90=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d09f5e4c-2653-4830-e59b-08deb58f7549
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 May 2026 10:14:48.6919
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SOZfo8iX4w7pPZd7r+1XjKg0lt3iqbE1EMGn7cyCj6/F6HwVxs+vuQE/078Or24ksF7rQBX4N4fyHGl0+qlpR0sCPuH8n5iiy/PSmTQReQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0493
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-289384-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:mid,starfivetech.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BB05457C23B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The jhb100 GMAC still using Synopsys designware GMAC core.
hardware features are similar with jh7100.
Add jhb100 GMAC compatible and reset, interrupts features.
jhb100 dwmac has only one reset signal and one interrupt
line.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 51 ++++++++++++++-----
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index 0d1962980f57..06aeaa0f6f00 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -30,6 +30,10 @@ properties:
       - items:
           - const: starfive,jh7110-dwmac
           - const: snps,dwmac-5.20
+      - items:
+          - const: starfive,jhb100-dwmac
+          - const: starfive,jh7110-dwmac
+          - const: snps,dwmac-5.20
 
   reg:
     maxItems: 1
@@ -107,20 +111,39 @@ allOf:
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



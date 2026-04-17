Return-Path: <netdev+bounces-279223-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eHB9Jr+m4WknwQAAu9opvQ
	(envelope-from <netdev+bounces-279223-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 05:19:27 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 17312416872
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 05:19:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52A0E30022D4
	for <lists+netdev@lfdr.de>; Fri, 17 Apr 2026 03:19:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CEE63264CE;
	Fri, 17 Apr 2026 03:19:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2100.outbound.protection.partner.outlook.cn [139.219.17.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC78E2DC792;
	Fri, 17 Apr 2026 03:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776395965; cv=fail; b=UPezYmEINYnGSnHrsn4gipHpC20+y+NInI8jLnaaknskTzGlzumnilP3Litq+TafAeR3ZKt70BANmPdh4LILQeeqvo7dfGMm8ANg+swfX9F2JvMNyFc4F8qEBsph5FJ0RpkEHTQ4z8NXCPrYQ1Dfqdidkbd7gw91N4zNJoIDWEw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776395965; c=relaxed/simple;
	bh=9jl8s+UqaPNoyEEaDSPAHaAxNuCu/To5W/kPbf3IMtE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=McITN5o6URcLByT0HfmwAUfYCxrLNC40kbMX77tHYrwjGFoxPHdMi1UBTmZUhPr+m8kynR0IncTBr7zH8b+WRTYEafCAnUlDsN8MG8e/WA63fv58PzGGzvT4V0pFv6XQhhkJa1kzBDpHm0C0BjaHOSbggNOcf+zfMJb4pjfJGO4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oOTC43Yf+cqaER6DfQUPyVrZV+Tkn+VkbY1/aeJw392YI410i4F2pHD6Ah6fClUCbJjyD6z6PJjKCfrHblcvOWb2SQP9hQgQjHpmVT5bGmt74NAOy2FZlIm6BnZFgVt9QpMET2lBg1ADS4ZJpl4/gXe29uPmQyZoZNxcG36s4eBmTZ36dA19N0xu4a54bOObjT7I+legUF6SlXkuxza4zDPaAea9lPqFja/qhqygyot2WcEhfshEreKpgLLsfV+rfDKN1YtZlg3H+/P2RnNcCRJ4+GTYGclZzzmsA2Bunq3t9Q02dXkMlVzC5k6Qipfe6FyLESE2cC+JJh4sbbBPAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WMpd0pcMLeW+7GQ5AjZJ5urZydn4OmYU/Qq3HvGwXCs=;
 b=HmUYS4JRN7Eqyblo12JMoCuhqAGIMh9h3Wu31Vgc1UlQd3e9QlVWv6KwRfT00MY+Zan43HlNAt15MN7z+vuvgZTp1J+5DpF+bCKK19DwD9DnbXJRoz2D/vD5A2KBRPwZ1B92irfeSQnzFEoE9gINpVTpbKGGWKIpBJy8c3hMRyD0hyTpWjjfvQbu0A96fXEjIyqktpa1Fmk/iW+H/aDLDhTX2ITbE3DZEZt8615kQtRbGHZuJN8U4Z+ORhBEmETchRfflLhjB82O4eqZ3qwkPEt6kQ7j5Kjpubfo+hlNmxWxKaMOK8e5ozn1kPSJ8yVzxV1HssxTBZrsbVBh94et+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0517.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.48; Fri, 17 Apr
 2026 02:45:33 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9769.046; Fri, 17 Apr 2026 02:45:33 +0000
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
Subject: [net-next v2 1/5] dt-bindings: net: starfive,jh7110-dwmac: Remove JH8100
Date: Fri, 17 Apr 2026 10:45:19 +0800
Message-Id: <20260417024523.107786-2-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 83bd8599-7c31-4dc9-32d3-08de9c2b6532
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|921020|56012099003|22082099003|18002099003|38350700014;
X-Microsoft-Antispam-Message-Info:
 37Lrd9T+Lv1rcJjpVosu9Hg475fQT7rfr+jupqfctcf5xK9y8Z8hPsPX8rfwmByCblyt7Sm7qikpKokUyiZ5OZwuEo6nlvqcOULUxcRya0kaGL5xdKnznrU5xSLpkOQGiISOOtFEDDcAeVVmuuUylgsP1hKvnFln9HlSs9RNnSHmjkteOU/A2xtGIdogIHvG4lUO0IxszOtVTCiFfIri15Rys4xWUmt6UexJJ1DoD+ladtTy1gdk779Kx4bH4T2Eh7Nxw4jEfce9nYF7cXzY3H9SYfQJ19gpqVtmcjoWfDssVswuyhXQxFQrBhvy29FpPEp+/X+HlrlRuIBBNsLvPSJt372VRuUMza4OcEd82HnwBIHpCxCQj6bGmvV6OUj3T53zVs+y6KngXMlQfzg8cyiP+qJoDI/mFqyRl/nCdOrsGvJOoue3No/WodnUIpizPEhxrfZDRS6nMmvDr+FUvMeg1D6t5xPLYcSz/+X/oAnm5xHIaysEjzTIOQXFfkYWeCByAfbIR5av6TJKIwAj4NRLL9H1LBFqMXwakr9bWw6vPnzrjTpQlgoYw8WY0jpI/F6e12L1iSN8ccNmzWOyUt8OugB8Oa3rm7vZkU8oSRc=
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(921020)(56012099003)(22082099003)(18002099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?NrizoNoTCDehHmmM9XBI+tG60PaO05lrusI8NF/l5YIyFNsZ0mxtV8YDMOqB?=
 =?us-ascii?Q?z5KxLBqHgqyYlSBADDFjs6oc6a+r/3KY3YioRRYFCaPdXL3KrwsPE7fHCw4C?=
 =?us-ascii?Q?bHQy77Be6xJ1ivdurUffg6lf8dauSYF+y1vdjLqYByXrEg653gfDhUaaCcjE?=
 =?us-ascii?Q?Or01dxuG3zPsZ7HS0zVR02h2UZHPhBIh5VUpZFdeDd8dvX8fr+HPQdmbCBuB?=
 =?us-ascii?Q?58xouVPns49dhptdwc0NPHfhJNHFh4A7lRvklx1uG6Oh1ilrNjKgpGEV1wSa?=
 =?us-ascii?Q?Mh2iT5HAlpe7BN9IGlOeROetP66Ft+9MIh8Oh7S4W+XaC6W3QnVwAntq+psY?=
 =?us-ascii?Q?9ejSgBiJmZ/ROkQuY0diFjMiBIfShWbnns9zO0ssWQvgSnKw7hs9TKJ2XxhQ?=
 =?us-ascii?Q?lgo8BpcM4IZT7ltpQjMqJHuBOV2+p357JrUql5HFSoH9wh9j9y3rUAkqxWrU?=
 =?us-ascii?Q?+8lSR3Rit2m+Dp99ETGL1utDCL0rKJpYQd0txVsctZLb0ugXTmEv93cNm+zQ?=
 =?us-ascii?Q?cAF2sef839h6Ic211I1cGcjE/fE5DzElod4O8PHCWNw7bHBuBlLStvdgQXT4?=
 =?us-ascii?Q?Hp4YuanyJyAs5/wI2PNoVYLpjANpkFcgDD6gwHh9cxBm1vjip6ORmfVhOk1U?=
 =?us-ascii?Q?FHinkpE9gdnRnUaLatuFq92ecorgO7IM+VW0n0rqttdzXjCJlQAwJ1oKV2KK?=
 =?us-ascii?Q?oF3NvTtRP8hLInBcXs0iIeNrY7Yo5zg693D7YLBWQk2b0TUCPD++lyX66U+B?=
 =?us-ascii?Q?/5rkBpXuBC1hnetpR3hZiBFeZjS7FhYpa4+GVv85CHHPNTwa2DiUYRSPAdsj?=
 =?us-ascii?Q?9v0ZLIXMxc9htCagds92CuW7CuxGdNFJvUkYtoj7FnayVpLRZoww04rDXcft?=
 =?us-ascii?Q?4mnJF9SH/a8xQFyxdggyJ8VsKBlFcjPJZmvzilveddq843dNPASf8s/lXl7Y?=
 =?us-ascii?Q?hvAyFzIDhl7gZj980rwPyOmHZqBpkMcxSzVYVwdkEt3qc5L5HZHeyyEaOO1C?=
 =?us-ascii?Q?oxXj7+NRVgKxi7BD590W9kABShw4Bd95sxEtXj75Vx50OyI4eAmJtxLys9pR?=
 =?us-ascii?Q?dmRYFWfEGUQ9va5aXpuXNcgJKV+qCKm9krMBhL+RQkbu9Mk/SGGQFvctF6ar?=
 =?us-ascii?Q?e4uv5iMtnDcBADNQlEhQWhhNSrm9kHtIsuSuykIrhkytZE74KlMokeYb3ggV?=
 =?us-ascii?Q?WDtXKtonGI31ifJtnoVR/qJocXeNmxOyCGkHsKkyI7S5F6bRCBL6NNX9aHCs?=
 =?us-ascii?Q?Eb6nUzXZfL5COjPlzFOe1eHYS85fsIAWCc/707G5fy34u1s+SPsOLmCipV7I?=
 =?us-ascii?Q?zgWrX8Mu0IiOeQR2IYHldJ/GgcjdumFkLMUxwriQNZcWJnHlw5pcJxChs6us?=
 =?us-ascii?Q?kQCcudc/9fwP8Zs/XylZnN2LnenA8gdHzfOD7hkPW0tojledUzwfB+aSqSRv?=
 =?us-ascii?Q?VHGwEHY6Rz2jzaJe4mwtaQPMO7Pmx/znSypK7GzrH1G2LXUZClSOixnrgGyd?=
 =?us-ascii?Q?PeMgc1ZWJWsb+MOIHPdFMl3Nv/OPvMGX11ZKnO1PqaOiLqkwp+WypF4FwIju?=
 =?us-ascii?Q?S50WsDe4wpDYJ8fDy6e99mnyhiK7sG/20c4aWZG9O7bTA4oNXEbwBQYQoM4K?=
 =?us-ascii?Q?bf0Jbg4qNy2FsXGEgTo4GHA3OxK5C8aPsXJHEWtNyUxmaOjLM7n5SFT4pRUU?=
 =?us-ascii?Q?eEmiNm9/Zeqa1lRgy0vxhTYQ6n+eVBm92QBwNm18dVbdIn0cp4ri4w1R63ii?=
 =?us-ascii?Q?bhziGqPPFw0uemaVNxz5wp7yeg1MqVA=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 83bd8599-7c31-4dc9-32d3-08de9c2b6532
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Apr 2026 02:45:32.9518
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2mvK1jJVAWEBeEt5w43tMXrDFSwJZ2kfpQpNI1TF0pD2TEor/FxT766Go1WxbAgailY/BrSe1V9YtM6Q/aMPxCSpTITa9MQVGcXmWGQHOqQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0517
X-Spamd-Result: default: False [5.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-279223-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_SPAM(0.00)[0.768];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev,dt];
	R_DKIM_NA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:mid,starfivetech.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 17312416872
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove JH8100 dt-bindings because do not support it now.
StarFive have stopped JH8100 developing and will release it
outside.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 28 ++++---------------
 1 file changed, 5 insertions(+), 23 deletions(-)

diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index 313a15331661..0d1962980f57 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -30,10 +30,6 @@ properties:
       - items:
           - const: starfive,jh7110-dwmac
           - const: snps,dwmac-5.20
-      - items:
-          - const: starfive,jh8100-dwmac
-          - const: starfive,jh7110-dwmac
-          - const: snps,dwmac-5.20
 
   reg:
     maxItems: 1
@@ -120,25 +116,11 @@ allOf:
           minItems: 3
           maxItems: 3
 
-      if:
-        properties:
-          compatible:
-            contains:
-              const: starfive,jh8100-dwmac
-      then:
-        properties:
-          resets:
-            maxItems: 1
-
-          reset-names:
-            const: stmmaceth
-      else:
-        properties:
-          resets:
-            minItems: 2
-
-          reset-names:
-            minItems: 2
+        resets:
+          minItems: 2
+
+        reset-names:
+          minItems: 2
 
 unevaluatedProperties: false
 
-- 
2.17.1



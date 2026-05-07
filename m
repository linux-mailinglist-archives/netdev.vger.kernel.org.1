Return-Path: <netdev+bounces-285265-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IM5UJo10/GkEQQAAu9opvQ
	(envelope-from <netdev+bounces-285265-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:16:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1218B4E7506
	for <lists+netdev@lfdr.de>; Thu, 07 May 2026 13:16:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C7AF330523CA
	for <lists+netdev@lfdr.de>; Thu,  7 May 2026 11:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A9723932F9;
	Thu,  7 May 2026 11:15:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2108.outbound.protection.partner.outlook.cn [139.219.17.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E493932ED;
	Thu,  7 May 2026 11:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.108
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778152546; cv=fail; b=A3Qld8HBjMJGptEvLszu5/typXG1qaSUAm4bYvd5AsHVemMqvu99GEezXiqyjqBy1XBjutG6c8lfZ7sDtaXX2mtz4jA2u5mzU/eUgu2mLtcoLaL1NGDJZ+BuQhl8e2PN6fT0tDOlOyonboDBX91fNSdGZS0eTIx9JQLdbG/Owv0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778152546; c=relaxed/simple;
	bh=j3naYQrOWqa+E7v1efgOSh/+RbBDT4kogKA3FIgrUt0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UcncIXLGGx7sO1S70XY7zbtRubjbATS85nznLULeWi3c03a/dJyYeB8GrGo/WdHRCx4flzSRY9pycTn9NrxQHoZnTYnpheLZYdmPSOt2vpKRqgVmbTNzmFndOo38YKgSinYIUU//vqNDHqMaC7w9TpxUL/OXottbMyeCKiKE6iM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/dK7Ht4cRR9QuAem/T4887vpWGxhD5jBXbFqAIF9BWQHlQ/6pe+d0PIdx3jgJbU8lDYThEjq7woDMqYKH6qSl2jT8XmxvKreEag4azHLJUuleXLVbGYK0ddRXO9yFLh9iP8dJ0J9cXA/l/OVUb0KibU80C9Aa0+kmnKKyJL0HI59GCOiedUXrUSujG+Bogl6djIXr6OaQ1Tn8lkb2AVOYskUn350Zq3GVj/lhFgO3wzshnmPKFapU/QvBQ14pvjPpSQHS/sZ2I3jC3OKrUu+A/K+wc+hK5WJhyEiGEM1VyRIOgrcC3pMsVRN8V+WUR8RpEBIvYzu5TPESWoaDL1rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U11VPWbpd4j7TLgXxRtFAs1tqcR9cTHlVxX/m0z/H3Y=;
 b=ZCqJU0Ht45Pwj9E89KSVRe4YyKXts3TZakWMjnuquXFmcpOcC1ySBhXtdZcLxy5bqzPpqlAQODOnWep+1CDgqRGKjjHuZkpBTw9v/MIF9aLSegva9rXa9xFgfx7Dem/yy7BAtymyE7rTRe9Mzvuck1DKuxR85AhoT28jqvhkbVwuqKq8xm2lWCTrjNa8kBUh0DwIGLX1p3PvkLY6AaqrCpbfrNein0qlXxE9nZe0yYzEVWQl76HoUCuhh3l7SiNCOl/8+eoE5O+z8oEYUqesngAlwKmiGxXkzKl+5VZH6iS6hhvedXeNv+vr3Ikp45Uv6mkxy+OdCYhF9sdTPntGtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12) by BJXPR01MB0870.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:14::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.17; Thu, 7 May
 2026 09:41:25 +0000
Received: from BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 ([fe80::e2de:92aa:4c1c:a829]) by
 BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn ([fe80::e2de:92aa:4c1c:a829%6])
 with mapi id 15.20.9846.025; Thu, 7 May 2026 09:41:25 +0000
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
Subject: [net-next v3 1/5] dt-bindings: net: starfive,jh7110-dwmac: Remove jh8100
Date: Thu,  7 May 2026 17:41:11 +0800
Message-Id: <20260507094115.8355-2-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260507094115.8355-1-minda.chen@starfivetech.com>
References: <20260507094115.8355-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: SHXPR01CA0013.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1b::22) To BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:18::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BJXPR01MB0855:EE_|BJXPR01MB0870:EE_
X-MS-Office365-Filtering-Correlation-Id: 3a89e1a4-d4ce-4322-2331-08deac1cce6f
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|376014|7416014|52116014|921020|38350700014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	3Pt/ZYaEvToWlRXx9sFftKKKSKO6fM41R2mlYtYcR7joK9SEHVBENJbzvjEBucu6KA9oEdYT96ucdHm401PCiBOrhEEsvXqKF0FdSGZU4A1Qrb0P2cfumBfub5qOW5dimhW4T2U4WMIEFBbe6/h864Yqqy/BB1Vkj6EXnXf2Ezj6LlSEXa26cKMk2fqugnp6TuyTZ3CWkttbo0pzO3Qs69My3gLQTUG6v/wDQdhpMZyr8KuN8Im3Ql5qFRa+Q2uQH8Y4XUqbsO3wKLJqXaavWpO4m88a7mzchP/0MJ7MF6tZRpuHdQc2022tkWhuNEG0b+ZUZS7WLt61fxfXBTndiyTOgvqkHXcijXQ5GmryZBtFmN3iWSWxJTrYf+oVk6zGDnnnQWSqNZwsz+gCc0YgmtlXdDwRNrXZx3huSrepNDTXljzqjhcDRM2Gmf5ulDWKe64HomgGn6tU6urOX9QkRuBFjz5HO8QJHg5oc7bPgAUKQcb6Np5cZT5qF4EEXbOxPHftGPqzmzossV8wfAoSAkcu0o8U3a01RoVcz34iW1IChXQ0xogPjw0+rn1uce6n5uhHoKmz44X4L3EFvehUNA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(52116014)(921020)(38350700014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2ItyHvCeSBQ9aQL3yECb7f3tcsVF3V/r9wnpn3D0szjlJyLTkTqaqZyDP0er?=
 =?us-ascii?Q?TMTFFX8akm1x3QIoFq2+dR95b1z5QDl00yzIdYhWMuW67Xjyib2solFsW/9E?=
 =?us-ascii?Q?JlLfiR9fxrSKYR+mFnYC2H8+xuULJlmGTEbe8TFfxJ+mhvjlIOoI9A4bNbZw?=
 =?us-ascii?Q?Iby8jeyyHIoS0TnYeuUwA1Jyny5pFJkdkiqBQ+l1CyQxSm7A2X+fLvWBhSek?=
 =?us-ascii?Q?67X7QfKmbamjDFq8k7bGG/jGmsS6XfFvlmP7jRtRiys6BbbVbW5lmmIE0hB4?=
 =?us-ascii?Q?3UiLn1w7zXXpKfiCiEDOrgCMiOT40gzbQxpRJkqZdOBHsXnSklmBywaYk054?=
 =?us-ascii?Q?gXwLBP/gMErnSLCrJy1wmCaRmsc/Rcbm3h48lndIkztlHDSmFh/gHE0F9fDG?=
 =?us-ascii?Q?Oo4g2tgDBS/T0brWW+H71m4EkI9hp6HBNKv9RqE/GKqjitmWsuOiVj7rly0n?=
 =?us-ascii?Q?AMwMeBiQCxWJ23augiyyHvisTbDUcjeqZ2rfff+WlNAEHlK3oMS3Q2efVGQZ?=
 =?us-ascii?Q?pQOxlIjXZoVV7kl9h0z7mAevA0q33UW6vzC7Zep4PNwPeUN5GEM8lf5L9+Tt?=
 =?us-ascii?Q?9NZvomk7w0YTAZupYg3+Dl7xZ72zKLR6ILgSxIDwXLT8RHjK6k8a7jSnCjNv?=
 =?us-ascii?Q?1eLtmjnKLrNrDw7B9Z5K7YA6iEUm9V266YBG1EgJarAlF8vHghO56h7i3pck?=
 =?us-ascii?Q?JManrurKzvShID1ymVzo/HIE4fkbLVa8MGoqahxstTHG0uz1qHyI3Nd9IWXE?=
 =?us-ascii?Q?kEjDr54pz2Y/x9hr+dum+J7EkGn+PF4e/FoJkGikdJLGYbiAyDu293Jihlmf?=
 =?us-ascii?Q?1HAPUUtS9oVTUFWvGOvshCDxASgxiyLUPBCcmP3m3Qg9qrYAbRAjYS9ewbxs?=
 =?us-ascii?Q?RPYMABcf55hWARgmcn1jECK7ZwGWdYXZMisX8jnJufKL/Ff/Rr/XDHiVaIch?=
 =?us-ascii?Q?V2H0qCMt1JfnuqOdt8WZkHLrOuR0flXvS+aK1pkFrvjwJAjdrs+yS8glM+94?=
 =?us-ascii?Q?Efu69IGniUgqEKrRvmsBRlpAARCEEFGrc0Wb5VzlR+Mjmh6Ry1s0ibbZuWnF?=
 =?us-ascii?Q?/qtYbhtHc1V6nbZgb9agsVUMkPJiQP/GMO0UMQCoGTP5k4EipTmddXiqIu0L?=
 =?us-ascii?Q?wR/ZxJjC7jKoqrRpSXzojriVxI5tlWAJtWFC1nZGNBSiDOQ2o5kjiu6Xejo0?=
 =?us-ascii?Q?evW/1uuWUz5M/Ymqx93onwzGSG+o0b5JX2baxs2xdqawGgix+9SYrR20Dxmc?=
 =?us-ascii?Q?o6bBjNK0Q3mfyrHcipwQlDPPCVQj0JMZUrrI/6xZQRr4VydBwwlyQILgnt7y?=
 =?us-ascii?Q?sz2ORSu+8UBDayLXQ6+C+yss3BYA0nRLUS5MQGzpWQQc+7eHr+o2EMfV04Ys?=
 =?us-ascii?Q?vKbNC9eB7mZSlMGkey7PscbAB7WChwWJYzW+LXF8mLF4zwjDJU/sIRk8QZlE?=
 =?us-ascii?Q?6Kp8gfNsOe/giP7NPuDMgoRLAkusoJ3OGOltvu8/8MSe3BvWS0VfmcAVaJih?=
 =?us-ascii?Q?BZ9fNEHC0YFc9kvmKctM9dvhWgvRTvdg6h27AZPxEjl4TPMBg6N0PXiLx5SJ?=
 =?us-ascii?Q?vyN20Qo+DzfCFI9XS5OG73FkvMFxTBGYICThmeQ3dDEJs3GlPG0dN0UEVt1F?=
 =?us-ascii?Q?0GLnwAyivaIqP0woCnVQHBw0DzUd2xvVi4YDc62dSXon0UIcMe7XIessoyqT?=
 =?us-ascii?Q?IPntMGNkvCoYOrjZbEY0o2+3m+rc4QSIkg6Fkz215GYutREMDBlL3bJ9x8s+?=
 =?us-ascii?Q?Uy9JtDMK1BLxsO2VKFVs+x1mnm/45Do=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3a89e1a4-d4ce-4322-2331-08deac1cce6f
X-MS-Exchange-CrossTenant-AuthSource: BJXPR01MB0855.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2026 09:41:25.6709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: f22Ppz/gITobr7bW5f708Q0LcjAZK6IfjALq157ijd9jN55+CDAVzc0sDIqCz/h1ADYeLLJjdjaVw+mC60y+cRzNBzwqZxZwKLe4WBK8+0A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BJXPR01MB0870
X-Rspamd-Queue-Id: 1218B4E7506
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.34 / 15.00];
	RECEIVED_BLOCKLISTDE(3.00)[139.219.17.108:received];
	SUSPICIOUS_RECIPS(1.50)[];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	BAD_REP_POLICIES(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-285265-lists,netdev=lfdr.de];
	GREYLIST(0.00)[pass,meta];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.325];
	R_SPF_ALLOW(0.00)[+ip4:172.105.105.114:c];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: add header
X-Spam: Yes

Remove jh8100 dt-bindings because do not support it now.
StarFive have stopped jh8100 developing and will not release
it outside.

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



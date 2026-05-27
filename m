Return-Path: <netdev+bounces-292241-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UFmxHfzFFmpVrwcAu9opvQ
	(envelope-from <netdev+bounces-292241-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:22:52 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E55FC5E2924
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 12:22:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02FCF300BD8C
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 10:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 963E33EE1E4;
	Wed, 27 May 2026 10:14:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2091.outbound.protection.partner.outlook.cn [139.219.17.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B903ED5B8;
	Wed, 27 May 2026 10:14:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.91
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779876893; cv=fail; b=Z1Tjq7i7O/XVkDTKVsxtKfuTAus46TrqVpOj2f7p5+zbW9wBU7C8261Q+m0E4/x3BpIuvzQuoMpyz9aNU2dkyEXtQqYADBfiLiiZvn5iNJM36Un50/ofqTgOvzrA8pB2Bo/XQRlqP+/yOI9y4PuMkilK0NIHebODMciEP1gdVVY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779876893; c=relaxed/simple;
	bh=CDRer719KYGVwVtG52U+ad/PqaviuaMP3OV70A4F8xs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=dJjOyuXokIDOVLlNCQO8ssEvxDWglqL2Yzus4t0kYb+xa2+L0/JG2R2r0FFkXSgktzx7m54Cw+9yQITQAgnEGuHHF6hOy5APkNji5m+IayJmDjj4CDGWk8Q1PvvNtghlnxj38qtqRi5WE+s6/GG9lIDyqtF+3ULJtre/UvYk7o8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EP6uny48kQwHXEWE+Sg6q2o6dl6dRFm6clKBz391MXlW4+MzrgngKGx/YlD6NI6qjI3MPlr/aUe12uUaWTlp6RJ3ZZvDdPkMZjo3qhV5Hj/P0puzy9GK008ptWJjOuuwn7LnnmW44D4V0R3EtgelYXrlo3Yc5dgW1jV4M9GrIWsx4BM2bbo9WbC/+y6gZ8gDgU57n+66V3XdERBmI0oT2d1RPay6nIHmXJbPVSWSjE6PWJ3C8KG8tNCkWLa/RpklQu3N8kIhTCl/iYmF7/eH+WHScjx2GaYaZFbmee5kg6aPPGCFufayLCy4xREqmC4ukjYatJ0NWJn34pvZ4qfloA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QSuTNxaOHK8IF2jEPBALgIgPSk7URmKKThqcy8k3090=;
 b=bGWuwNpXZxT00ErX6R4pNkdNymZqAnEjDOf8yJtIEC3TXVZmozqCLZ1D1zriij2BMc1cSixXlpmGMfhaAlFLQ96LQZ3NGe/pTz4jjegT2ixqmQH5XoFkMpG8qqKmNpuf1oKdpc085Fq9OtFIWcr5CUosAIyVEewdhaHmH+3yxNi3jxXun9B7rUpmsuVeGymhvW7T9CQ/lUppb72ucToJEPGE58/OEcNLAjcRtF3y1dZ/sjiy9YokLOQVHkqOPZR8NlHgZMsqv1xj85IJ3EgLqEHez4E1FfWDsMgdZfdHx/8Q+Xb2KbyrBbq6ENHW0VFcq55jsfkyuAJ5k67PTDYDow==
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
Subject: [net-next v5 1/4] dt-bindings: net: starfive,jh7110-dwmac: Remove jh8100
Date: Wed, 27 May 2026 16:41:05 +0800
Message-Id: <20260527084108.121416-2-minda.chen@starfivetech.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3d7070e6-adc2-4ed6-c00c-08debbcbb7c5
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|52116014|1800799024|38350700014|22082099003|921020|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
 VVSdN4R1wWaaPkrBJ80nPPeLp7GAkx9BbauUrcxBPNZyXXXgWMBSHXnkZA7HXVXbe+02wRqNcXz2END19PfwUiNEDNHtyf/vzuBZbqrZCzhjg65nYkwvh/9UgtMBIcqnwIIxhTwQY4y/opHdeAdDt0y4PQXcNAN9blQkc01ksnMlmZOUfSUT8AWc93fYRYbSTLCPz7PTGf+z+XxBw4g6tbkjfjxLh8ywbMk6+AdA9H5NU+zL25AFPEsIxuEAlgDR3xCBk/fYVAaBUpcgoOSp8SIvNnKrqfML1WzI+gA+QUpAZgegCUXznq6TKIHiG39cuV1ilflLhnsQpkCtS5xGkFoEUyW1qUeK70pXRGf7Sxxzq6mvRJwIUkmsSbt+Ygj9MnnVOp5510nUpVMnDyehdZ4AzVTxqCNnZfOy9xkiHxEl8iwxRHx8Nfz5O2RqAunKoOfedF8Z/6VIs9qM4JAYvRmFgBzjd5W4rdiOe/jdCzgc0rnPGMaYwQbUU7orpwFgnwvc1pQmP3PCyQRW9JrZhVIEKORCNn+iHACt7NKK+VNUzMw78ROW/WUlfCJQG+qF2qWIgcGrp4miFd9A1kjIrQ==
X-Forefront-Antispam-Report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(52116014)(1800799024)(38350700014)(22082099003)(921020)(56012099006)(18002099003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
 =?us-ascii?Q?V94Dn0dVqIUDIPc6+8tUvwpD07TymuJfQ9lxMJ2cdbDyVRJkd8LJ7SDqT8jL?=
 =?us-ascii?Q?DHxudjWBfgoeNG5T9+suwPpTypIbY86NRXnU5D0ydfhi3pO+WuFx2+RYAmQa?=
 =?us-ascii?Q?MVW4gG2QZOk8oMPmrJXPaMuc1igEvlmkT5r/klYQf0LDwreeAIEfKsbPEKDM?=
 =?us-ascii?Q?J8fJiaZr2R2aHVskHsxoN6n1QCVn6YNcZwlr9puuUPs5hCmQoQ+FQmZ+zzql?=
 =?us-ascii?Q?0gL7+SdelMQwB2XvP2G2v14znkO1vv0srG/aqmVA2NFfZCovEa6hJuyUjr0p?=
 =?us-ascii?Q?Ez0MRhGIohs9nvALc5jaBqElGJFVu/YB1khaNZurmUxFb25hXh8BPQNIfTcG?=
 =?us-ascii?Q?SXW+GBWxxfC8nmx5EvOWju8umYmgD74XTDym9TBwicEup3xfojwAiwWMDFbT?=
 =?us-ascii?Q?/NZrGdvO5GIgfW7x4SbHLSnpklOFMEB08rGfZ23ja7Bs8aA9E0rJ4D8ZRlaz?=
 =?us-ascii?Q?nL9xl2NwyAhNxgyc+nCoM0YMGIXlGceSKBdAi89KNeDJEnmwouBiftbaAYQK?=
 =?us-ascii?Q?qtTHIFoCoeIkMR62PPCc8OYLKwcOigHcnxqcW2jWyRp32pkVXYs+4ANo1F6n?=
 =?us-ascii?Q?Q/ROvR6WY2rWA+C+yu3MgstSD9wddRrbBqUjd0EJ8A5onUyQukRasXqfImaJ?=
 =?us-ascii?Q?jUoc080LtjwzCM/qXKxl0LhqoVYBabLJououX7S9t5Nl7KbZSHwM9AGeiVDs?=
 =?us-ascii?Q?SYRXZuSGBEGIV2f+7h3WqwJG3V36f2POhGeabjafZoO1Zo1YoWpgSo2FMyBI?=
 =?us-ascii?Q?gd7F0EHFD3Y7vpLzfRfCqRHOtBg22eANEfC1eB2wEzEz1mw7+bfVaK1oN8wk?=
 =?us-ascii?Q?Ae+JCKjC16vRfBbpr5iur8tG//uECYbV2JuVsgraU4JHcoAn/4ciUztXMeBl?=
 =?us-ascii?Q?SreDW/kYXJJxEG4iT8/ORX0DHoJwHQ0I0SHDyViDX0BPcF3zh+FP89cUey0c?=
 =?us-ascii?Q?GzTn/PkcrmEITdJ/hfYfD5te5nJbtJA1nI0A+Rb2kIopLTxKNMOFU95yV8Ib?=
 =?us-ascii?Q?ckjYffGQLZTFIckJA6120kwMLQ3trpG/KTXAvdjjjNq8P/EJKc3COtBdvuZ+?=
 =?us-ascii?Q?RsLkX+i9SPGKRHqpZI9K4MvU6pGYhwNHLuHB0DEvDz4PlW7AwXPe8ssdV0Rv?=
 =?us-ascii?Q?yJ0d+fwsKwXMkZE57mPVvraropV44u7D0cEmjZCvZihotGHnUXchEKwNkrdp?=
 =?us-ascii?Q?NQUTcbwMRYUBirfY6K18B2c24/uLk0w4wma6LuW2bXFVqXACg+6uz9+zx8/I?=
 =?us-ascii?Q?LZBEuYEDpK0Q5y2kX/e2iNyv5EP8DsIwLeyfARbVSUjGMZS3M2Gsn6q9xxSO?=
 =?us-ascii?Q?v3ulTPWRyhS4ThecoE+R2woU+ICMNU+4NTangiIqd/FmHDcbwiG3MTV+TNJv?=
 =?us-ascii?Q?8NVqey3dotZHzcCsSnbYRhxnkOx/mdp079OaQJEiN/NdvBEvjJEjkmpavqjJ?=
 =?us-ascii?Q?U07vGc4iUBBkkaBIbdGggnbDB7067qSKDPCJ3dMUC61Vk+E+LyOtKmgs42j2?=
 =?us-ascii?Q?NLWyZo1iklHyZ+Yy88AYyvtqwCSYmiTEvTJz9fJPnRnD1LUOYmmPgtAxXYka?=
 =?us-ascii?Q?YhZyGcWHK0LAMARue7X7y8WLkDJCbliQL1VMfLOLoJCpNDlSlfBxT+IbAxPG?=
 =?us-ascii?Q?kboUH9M/2kktB558lPHj1vcm8x+wsMXX0ZMmRg9OT/r4KFevSEAbrCjIlhid?=
 =?us-ascii?Q?tJPdOgrPPD6+f1JUx2N1HK77olmEQNkBpOGmaFaz9ABrIRbrPsZGjpAD9wAS?=
 =?us-ascii?Q?lgI5Q8hg5YzcHtPsPdXiEVr72428xKg=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d7070e6-adc2-4ed6-c00c-08debbcbb7c5
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 May 2026 08:41:16.9989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m+666bLJYbWXb7BlVW4Fv34wRB5BwFQ8yfpR32XFMkDkM+QXVVQPzEGb2bNq0nmtXqX95qnTG6dUKL/eKOiehO2Rpg4DEIg6IQaHEGMCrtA=
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
	TAGGED_FROM(0.00)[bounces-292241-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.208];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[lunn.ch:email,microchip.com:email,starfivetech.com:mid,starfivetech.com:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E55FC5E2924
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Remove jh8100 dt-bindings because do not support it now.
StarFive have stopped jh8100 developing and will not release
it outside.

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
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



Return-Path: <netdev+bounces-276364-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oGKxNx8Y1mkxBAgAu9opvQ
	(envelope-from <netdev+bounces-276364-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:55:59 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 488323B961F
	for <lists+netdev@lfdr.de>; Wed, 08 Apr 2026 10:55:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 654463038A44
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 08:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5362A3A7F67;
	Wed,  8 Apr 2026 08:44:45 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2103.outbound.protection.partner.outlook.cn [139.219.146.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742ED3A784F;
	Wed,  8 Apr 2026 08:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775637885; cv=fail; b=W4zz1sqwEC0IshrKhHnxZuiuFPkDULtTtP47pxDlE05ahc2hqxL6XQj0JWzPL2RhCA2yvkCVJq1hliFbU6wJHABDeJonk+jpC7VBbkagfQBSUs0wwD1MRi0xEgG4IBnSQlfsRM8mfkaTPCRCnDYgof7LtdTr/b2l1/zujcys8rY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775637885; c=relaxed/simple;
	bh=ejLuyzD4dwyPuuL5kmQ7p+Nh27qXLSl6W4VG6wDLQ8I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Z3TPnrU7373Cl0KUBENXU/YyYF3MAt0XJ9QxsanSO0Tvo6J0DL4teMCnmZw6BAqw2xza2CMuphQ9TXj5xFLaQi3mFk6+hs75rgpmVKtd1tlKB4FLVK1XFEP/D9ii8BaA8keeyDvbOlGJt8sN1v1fwqPto+DUJ8Mpu4yTRomlKnc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HYQQOlGbZljjn/B01BFH9e3pRkQ6gAGX6ZKtdYWtJhNaLMMk9N/gOcQlg3OAzATvqrCFKA0B1pTeeRx7T6Saz3gfcgHpmlj3KDCXC2H+sD+WvJmIybio+kqRDmEjQ0Ut3Xz7koYFGfhVr0K6BXj22SAfOwGqvrEIsWFeIM/3Xn3iuvCf5QgraGhI/PPTlrzwHV6+y9ZY5mnIr2+XxfMUHNb+U0z1KC4znPr9NXNBK3JUgzUc8LKJlUNtVSXzxBxDCFobY6pvakmQ91/mYcqQNyzqwT4gZVe0E5MnWUgyhwcFpANJhRSOiY/Ar0yMFsTZenvMegGqjx9+1Oz2gOQgIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=E7epneKxWjCxS5EGIJIdGZe6tTKjC+CRk0dYlqaVA2w=;
 b=SunFdonKZR2OCELS3Whub8/d3ONowgmtJHXgvodFOaQqGt2KkqBHxxADAxle0qGUcSaAAj2re4Kq2Z9ev+4PRQdIxt2Uqk22/tis8i85i56VVLuF5vduFhH8UgsMM04VRCWg+/WojCx/YwRA+F15nry4YmDhyPCasgv/6BEfvlg4A0+exo2CRjyovJ8JJ5nInjUrQC1uLIAZyPQ2NZD/TPJvCBcoia2ENYn+Oqg782wHEqldtFz8FQqi3Jn86IKS7LD/vTnF+VV0wxjTtYjL1JswJzCbV66KUWY9f+0dLLTpCLXaPanlqCCMHZdZBaj2n1pDOZNq8sJ4MLaxUiG87Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0719.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:26::10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Wed, 8 Apr
 2026 08:44:27 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%6])
 with mapi id 15.20.9723.018; Wed, 8 Apr 2026 08:44:27 +0000
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
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor@kernel.org>,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	devicetree@vger.kernel.org,
	Minda Chen <minda.chen@starfivetech.com>
Subject: [net-next v1 v1 2/5] dt-bindings: net: starfive,jh7110-dwmac: Add JHB100 support
Date: Wed,  8 Apr 2026 16:44:13 +0800
Message-Id: <20260408084416.29753-3-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20260408084416.29753-1-minda.chen@starfivetech.com>
References: <20260408084416.29753-1-minda.chen@starfivetech.com>
Content-Type: text/plain
X-ClientProxiedBy: BJSPR01CA0012.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c211:c::24) To SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SHXPR01MB0863:EE_|SHXPR01MB0719:EE_
X-MS-Office365-Filtering-Correlation-Id: 8df93bb8-afbe-4115-b8c5-08de954b0b45
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|921020|56012099003|18002099003|22082099003|38350700014;
X-Microsoft-Antispam-Message-Info:
	O9V+99GZqibBXb8b3nrgQAPOW2+Vf8BfxSSaJ358pOkRhpw2ZTGR1RX9XV65YcqxDYdAWmvWYJ6Hi8wW+0Z67w0x/hQvnel2mZy7fqUClunVOt7/A+yyEO8mcj5ZI8MSwHLt4uE67k+ddHghG3e65EBU5BxKnliRf3HNvknuphRFhxcInjLVZwdHzSrCZ2sluQGK/YqM1wERMzP9UxE3RN581545ipN2P388jpG6hhUKov0fJSFt9C0nm61EBATiKO5RbFsjAIHNfeAglbLDF+evL82Ex0tB6oqGoE1V25tFkHCPQP6UQs9Rrr8yzSok22208yBMkOnNU6oiFb8D+Ps2Vc44DASGsTARl06DBQvHHmM3hHl5hcpTEC3uzFfg40XD6QXxQ3YeUkhyJ6+gYzrky+dDTMGtUuzwh08yPx804Lr0uzJZg8BvqTAwRamgDOL3+8V8UHjgc/wFImmq2KZwtbebfRysKDdEMojFwxLOGINoT4Gd+zG7y0+bx4HX7ElT6KgbkaaRRnIzvvc8iVfTelf6GLqXQPO9URfJEoLLrRarU8ROATWzc6//+SoLMUZ+THRLvaSmgZZt3Osdyt81/lP9fs6jTbwAZYDb0zU=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(921020)(56012099003)(18002099003)(22082099003)(38350700014);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DQO9zBO8Mg7VNQUS8HQO7BOExkBYPPlNGYaEJVHO71bzQKHyXDvwd0CREaFi?=
 =?us-ascii?Q?WZNI8XBfzaYrfiqaMN/eO+JEZsuLvvmujIGPqVi3GDPojX8wzyjnvXwds65Z?=
 =?us-ascii?Q?wy5ldlig0OINsL5b413L+2bEzjGV6z08GiS5fIshXTbuwEhXKMRCsCAdN9Lf?=
 =?us-ascii?Q?2mTdL1D2DFCfgiOFgwjzAE2BCUUPtk91MR8PvjeBebeS0LCEY976UfxKf6Bg?=
 =?us-ascii?Q?p3/LiJsKYHO3JrMoJPuT109unRWKiMviJVNgJjTJIXsqOEL62+VC4RIfiEvE?=
 =?us-ascii?Q?DJ1WcdQhdQ+saHxlTTfIN9pGroPCvbJpGNlfodr7bwhCOvZqzUSBZ+Eq9L/r?=
 =?us-ascii?Q?QM0QTNvEcu2hMAU5+A98aNvxr2HHG3WNyuOO8sWDduAMGPAp7e0hMNrsx8bK?=
 =?us-ascii?Q?YlJ24bH1p/I8GB8LAXAQfmqCp7ocLTjFSKY+ljMzeK3RqOdEtpCKm9MDg4eV?=
 =?us-ascii?Q?v5RA099ILZNH8OjbA8YUL9p20YAlyRtLzTsvR5mDgWaTUyuzho4p11LrwMyg?=
 =?us-ascii?Q?Y3hfsejkcbPXjStnim0tCD9GXP4zNYPRdAAWfL738itBfvgO48vY54DFCZjd?=
 =?us-ascii?Q?hWBZVRJQ/gmVgLfgtTwVzfH3Z3EK15CuZuulj7QENUOIGUYeVMxROR1q82jT?=
 =?us-ascii?Q?Wbp65H/L+BuvYA2JJf7+EwpzZ0q4+STu7DVgp/rJMZgFCkwGBwjl/6Ju5Y14?=
 =?us-ascii?Q?3IfT/p07FGONAwQTnqteQKPOKGQ74iHgHHkCvY7NTTi5vojj+TKpVPu88Tkb?=
 =?us-ascii?Q?uGMb8sURyaNbLw7LZWfNn+WC0mw3VufB3dzFL4Iog0aX/yBK5JWk2thImjzh?=
 =?us-ascii?Q?iYGs6mRsETsHqAvf9gQAXFEXQrAXAMbGFjYOpyDTGqBCYoNrvkI9jg5h7t3H?=
 =?us-ascii?Q?OjNdgIp2TqaNTK3BAXikcbXC/AAKkwC4ipPaGoprqlGGO5FXd7MacWV1U7Xb?=
 =?us-ascii?Q?HZ+ZCtAigNvRbcvO/aPzEQi5AyLeJaGIGCCMTCWzZBb4edRcckRsFZGr8/1o?=
 =?us-ascii?Q?5x0Vy0rKN/OzV+2mB270vK+CVk0p157e4v1NOBo7GS1poAYQck5S7bHxkEuy?=
 =?us-ascii?Q?Kp9RfO7c95SCQAznO07yOVbF46pM0ZbBU6zHuetAfD6PQc4pxvv3JoM75Kw0?=
 =?us-ascii?Q?HhjIUlyGRE+Mf5A45N3IH6UXbRkV9VEKoeg2y/3orlz47TwSDrFl0pQ8ihEb?=
 =?us-ascii?Q?TcaDA+nq/s2+601noy+LBB7WroZKkOlT5Od4TQ9FnDA+MKSJMjuqB7iD/qP6?=
 =?us-ascii?Q?GrBvIBo/TgIvKKrOXvck7fK8Fh6uHOELUHwiUd3o6EyzzCNyiDQhuRGDokcB?=
 =?us-ascii?Q?XPDUjnorB7Fh/6qfypQqkKHEIQxKsIv4LIHPXsivjDsCuVvBFahJhCZ77sEK?=
 =?us-ascii?Q?Bbvm6oDCATvQNf58BR2pJS6YpwUV2TveHjnRCAQJWZiykU4915cUiUd6p9Gc?=
 =?us-ascii?Q?8fxVPK4r2vBXCOMOXP20qmOfvOjNLmc6YTObUS7LA8GhuOb/3NBcOTwa824d?=
 =?us-ascii?Q?ia1tVkunE9FrUC590N2oDrGoQHvRRPl0bmhey6ORDhHZfhw4/tzTpiQYo7ek?=
 =?us-ascii?Q?jSwXc8RVu0T0WSMGZpLEN2XeNoGtYVtrmPZnszQfMXzq+VSTrpUKWDdYWY+r?=
 =?us-ascii?Q?TNwyGEs6aIty9cK01cMFLcBUcuc7CMV+kZZ6cTDKarMNOYBLslVIqxUqzbDM?=
 =?us-ascii?Q?RHXH/8AYnZf4vyIUfLYFEqSokE0mPW8OPfeW6MKJvlO/wGL2ZgWGi5Zu849e?=
 =?us-ascii?Q?IaEudkQm6CVRjyKEAj2kSBscA5kN5b0=3D?=
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8df93bb8-afbe-4115-b8c5-08de954b0b45
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2026 08:44:27.8427
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4j8bMRJlhpPSaQxbn/6rlF9GOU8e4HfCA591G8seIBSxgeOqzvXtEANcMceSNITxKFFtlC3gD2WmHvqv1nve6xE4ZEJ42+ciOPtKTy2xa8Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0719
X-Spamd-Result: default: False [5.04 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,linaro.org,vger.kernel.org];
	GREYLIST(0.00)[pass,body];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-276364-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.597];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev,dt];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[starfivetech.com:email,starfivetech.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,11b80000:email]
X-Rspamd-Queue-Id: 488323B961F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add StarFive JHB100 dwmac support and compatible.
The JHB100 dwmac shares the same driver code as the JH7110 dwmac,
which contains 2 SGMII interfaces, 1 RGMII/RMII interface and
1 RMII interface.
JHB100 dwmacc has only one reset signal and one main interrupt
line.

Please refer to below:

JHB100: reset-names = "stmmaceth";

Example usage of JHB100 in the device tree:

gmac0: ethernet@11b80000 {
        compatible = "starfive,jhb100-dwmac",
                     "snps,dwmac-5.20";
        interrupts = <225>;
        interrupt-names = "macirq";
        ...
};

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
---
 .../devicetree/bindings/net/snps,dwmac.yaml   |  1 +
 .../bindings/net/starfive,jh7110-dwmac.yaml   | 23 +++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/snps,dwmac.yaml b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
index 38bc34dc4f09..85cd3252e8b1 100644
--- a/Documentation/devicetree/bindings/net/snps,dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/snps,dwmac.yaml
@@ -115,6 +115,7 @@ properties:
         - sophgo,sg2044-dwmac
         - starfive,jh7100-dwmac
         - starfive,jh7110-dwmac
+        - starfive,jhb100-dwmac
         - tesla,fsd-ethqos
         - thead,th1520-gmac
 
diff --git a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
index 0d1962980f57..edc246a71ce3 100644
--- a/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
+++ b/Documentation/devicetree/bindings/net/starfive,jh7110-dwmac.yaml
@@ -18,6 +18,7 @@ select:
         enum:
           - starfive,jh7100-dwmac
           - starfive,jh7110-dwmac
+          - starfive,jhb100-dwmac
   required:
     - compatible
 
@@ -30,6 +31,9 @@ properties:
       - items:
           - const: starfive,jh7110-dwmac
           - const: snps,dwmac-5.20
+      - items:
+          - const: starfive,jhb100-dwmac
+          - const: snps,dwmac-5.20
 
   reg:
     maxItems: 1
@@ -122,6 +126,25 @@ allOf:
         reset-names:
           minItems: 2
 
+  - if:
+      properties:
+        compatible:
+          contains:
+            const: starfive,jhb100-dwmac
+    then:
+      properties:
+        interrupts:
+          maxItems: 1
+
+        interrupt-names:
+          const: macirq
+
+        resets:
+          maxItems: 1
+
+        reset-names:
+          const: stmmaceth
+
 unevaluatedProperties: false
 
 examples:
-- 
2.17.1



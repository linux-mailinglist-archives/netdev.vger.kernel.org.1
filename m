Return-Path: <netdev+bounces-287330-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ey4H/ifA2pL8QEAu9opvQ
	(envelope-from <netdev+bounces-287330-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:47:36 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E730C52A900
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:47:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5D9E3016825
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:47:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7076A392C36;
	Tue, 12 May 2026 21:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="QfjhSA4A"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011067.outbound.protection.outlook.com [52.101.70.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFF5A2DFA25;
	Tue, 12 May 2026 21:47:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622452; cv=fail; b=ABAcWlhKScj7lokkXVL8Yg+qjQ+w97sbywwP3dxMDK33wlj5buPH9bwxFTnhYZnzm+Rrm2eHACJfqhnRBOnngVPDHpDXbZuoeiIIp9j1QqWVZSNp7tCgQn/aAsUNasyZ4hHhUgv7CSxpEte9derTWMSogaUfEjUsr2hssotOcoA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622452; c=relaxed/simple;
	bh=wltcME82shZiCkPLyr7ncxuE14e7tFnXAddVwazzhgY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=A0FDrKbJIGrGYAJ3LYLywnMT8jVA5L0cSl56RujLTJxSnFqcFeXfF4mN1DTzkjF837FKonsY3ycG3gUt0Fqd2tG70U/q0qL7FUdcXFW2xYWV9tK5nMasG11vqTiqHsEBakd8hux1z9NwcE64jH67EeKzu6MnetOO5ByjRi2k65w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=QfjhSA4A; arc=fail smtp.client-ip=52.101.70.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wz1qYQW4Nv3i4i8AVZNwjpVzqnV0XurWxIJu4/KLA8GdUPw8jjr2ED62EyUKD0+F2hvWIgFRYfndZ9xHRp73WsFNSiAQosdf5PQBLBSl1b+hLwkJZ+sgeWCiC8EGnRB851ranfigurJxADNCXhTwKg3Fgmyd1Z9DOOyyKBBo/gkkgKGiOv+IfDhgbLZZZxUttEwTN4iVsL1RtU5KyrTfpvDwEFi59FFI+lPNYtnQyZP6oVRl8Bd/2rGRYXDx6Rt+jVk9vQotShsgNCI1vwIAdqBnx70eJpTFYKJYmvW6aQJq6Xdqc+gQQz9KP7c374okw3iXiwOSX806/GncGKiv9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dm9vbSW+elDATPm1NqXx1sfIjXMEYAKVSHece4JBhWw=;
 b=yAWuyb3Za3IskSaVvZr7xoQeRKh16T6QFGVoRomHEfV3EfPC98jTQCk34oNaikYv/JZ9+0Xa4wOPp4oWA/5vqAU1OYzHJPqSP2l+RYedZ/5ZLF4QAuv66lzERG/s85mIR+yPI3R6sRDYRQzNCGFFupoqfZ0FLAVBbwK3NuQx4KEnEzyJgxi30agpGL8KhKCVfO8EuTmh1r5Qfkap0htLlugROo1M+BvF6nUvpt01N/uoVkuOrLlrAh00go7yCkCYSwCxyX72mywlvJZUixnvnLJ23RD0nkXqoPAFxW6diMX7ZHnfNCX/p10hPH/FDluFPFVxRhIzkCdEOVgTjk+R6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dm9vbSW+elDATPm1NqXx1sfIjXMEYAKVSHece4JBhWw=;
 b=QfjhSA4A8xis/E9uMA0umvZuBR0vWeUc/18w0c1dpfi7215thKdYznh8vBzkYSKWCe/quQEt2E+sunZkOTCL0U8NexHGP65tBUgUhVMV7eY6LaUoK/cBr/oU5X+DiLWQnwqoalMSUOXDWZrHld9sdI/C0WZzlYjWwmYhHChlEhG4+Ws5jvadGhzGpTcFW7QA0w+F6HKMuzIIX+UXJnSS9aBSTs11eFUpgd2sy3Sc5bLR0SLQLB7ZGaEToi6qbzjfRgfs1O9FCJOl2G61xWD869RtNDbjj9hUjcEWVZeQ85AOLLNI07v6zJ/u9mwl+w28QdM39fFvggZETLUvihWXcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com (2603:10a6:102:2a9::8)
 by PAXPR04MB9399.eurprd04.prod.outlook.com (2603:10a6:102:2b3::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 21:47:26 +0000
Received: from PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588]) by PA4PR04MB9366.eurprd04.prod.outlook.com
 ([fe80::75e4:8143:ddbc:6588%3]) with mapi id 15.20.9913.009; Tue, 12 May 2026
 21:47:25 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Frank Li <Frank.Li@nxp.com>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: net: dsa: Convert lan9303.txt to yaml format
Date: Tue, 12 May 2026 17:47:02 -0400
Message-ID: <20260512214704.1084890-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR05CA0024.namprd05.prod.outlook.com
 (2603:10b6:a03:254::29) To DU0PR04MB9372.eurprd04.prod.outlook.com
 (2603:10a6:10:35b::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB9366:EE_|PAXPR04MB9399:EE_
X-MS-Office365-Filtering-Correlation-Id: 80808e14-7fe4-4cc9-488f-08deb0700e34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|19092799006|7416014|52116014|376014|1800799024|38350700014|921020|18002099003|56012099003|11063799003|3023799003;
X-Microsoft-Antispam-Message-Info:
	lhZjThALOeI1V+Bz01jkWsv9uUVV96Z3tX8pmF5QwNRAtJ6pfSb4/JolRGjXzdXByZxBoi5/HArthMCdhj3IyT93QESkesvFvhPN1cfoIVxq8OmL8SycPg7q673Q65DDcCnOxaDN+6t9DXfOHEfjcJUtzqXtERF4JqjoXVpU3B0pzuort5fOY+PNLFAzIRRkz9OkWmeesKGT8JpWuSeBghj4q504UuXheRCvTbEj6BoZ5uPyOFeow/n9fJWdubel6+PDyZjMfw4PMTT1LR7xzt7YtfiIZ1db2PryrkQTvvmP0w87jVx7LqELFxOrdW4JSrm4IpWR2LDgjsbD0Atz8xRtGV5KMw0iH16ITXo4GJENA/blEBkyr2xjniudSe87SeKd6mjRe7H6B3HHYF6w8jttvQVVLCNcJQ2SkphM+Op3zx0ku5XgzfRmeie+ljYmuGy5TboeoATIMDfUVbgMrgbABxfNzy3X/SX6kfBOi76lWJDJahibpLi43Edtf3rnbnO+BaOQ0h0CshL0rYICz/97oEaqo2d58gwEMpBTZXnBPrRvubCSH3tObJwX9oywKqjKBGJyOiCwvVfDop8NG47jmdpD+ozw/rBJ2Gk+3AHQrG89QAUiqXsLBgxCGBNAMKWWcz6mNZfdMmKX9G+QlCt3GuY4cH8oTvq3T6CiD3gI8gtAbQtNs+GyJgI7A5qtV2FUCvb4xnPzDWzp2c+yUw==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB9366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(52116014)(376014)(1800799024)(38350700014)(921020)(18002099003)(56012099003)(11063799003)(3023799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?UgWet1Q6pP1ByOdtN1KUZQjCAogQwwoFwGo+G3W9dI+poMnTJyKUl3/9EAcR?=
 =?us-ascii?Q?p82JNam1mTpTPAh9bfqSKeDxr6LwVLAv2oqVtL/AOoS1VWSqmT1WLfVVV4jl?=
 =?us-ascii?Q?oKTLPp9eyROfew2gfOfpeqQtYlcKoJ92KSf87KcmtSo5oBqmRejwzHAc8JKE?=
 =?us-ascii?Q?c+L6VYTRmI9oSqR0n7R3w6rz321OGLs71ADIkFthT1nsrokx6i8ya6kvo32Z?=
 =?us-ascii?Q?LM5rp+GNEMzbk/gYeTSNix4YZLBq0dOFomMJHv9MN7f0s7MJ/Ne2dP3ty+xh?=
 =?us-ascii?Q?EI0+m+5Le83w9SQwZqPxs7Hl6P5kw6aoHZcWpQOqyapo01T4V/rBANqNo3/i?=
 =?us-ascii?Q?+HwzzCR4MTs1ZZvFXLE8E9x/iQpA/PBN3CT9hil393C62XpbF1Mn65qUqgzr?=
 =?us-ascii?Q?HeMAQpiwL0o7ojibSzadffwXmxwdO+W9I1i453XdzOlIyFH8NuO0GuQOq131?=
 =?us-ascii?Q?oHmteq+NADAHkBNpHovRVQ3JeifAZNc5wozHNk+AbAG336XH1S6FGUvAMoUq?=
 =?us-ascii?Q?GGH/qfDIEqIen+vWGAT6QEtmRIsmA12t0Hayd0MfIg+JMvN120RpT0ZpfCn/?=
 =?us-ascii?Q?pId3z+WR5r8FhqBIG49eZucKgpFMNhhxGrvnq+kFNVnLiZJxfAJleCaGIxwH?=
 =?us-ascii?Q?zJXvYJcB2o32VrtGrg9xER2sauQqZAZcSpkO0g5ikASXu374X4UnTtTK1iml?=
 =?us-ascii?Q?UjK1u0XSNN1OGeDAfddBoGTZ/OUy/SroyE+KjsmlpzE399CBkOcUnVgghtmj?=
 =?us-ascii?Q?zTLiMQqloZt26ERHMlXcWs6JudFuPY4wVLyNTlOcG/blhIU47MmkGeqxQJp7?=
 =?us-ascii?Q?Cn2JT7yHZt+Z+mUufgs983swUPTgvknHI4xU+3/ftstTTpKj3a4xf+8lr5Bs?=
 =?us-ascii?Q?oNt3RncaSmg0WQ8YruEZUhPTdNE2MjspNYdENtbk8dZJ74r2LcWIh895yVuR?=
 =?us-ascii?Q?kiebD9+RRp39ADkb58X2IMVrJcvTaFgoC7yuTXySGwANJK230OeCy5c8FW9j?=
 =?us-ascii?Q?LQb1DSY5hVXDTlDJIKJwRJuE96p88TzQRfVCSbLg9EEbl5ef5UCBRBPyOKGw?=
 =?us-ascii?Q?z786Cwgpt3DKapBDzEiuGy03HCDGzm4Dk3uslJXZVH6DQdNlcxDfyEKNtoO7?=
 =?us-ascii?Q?OsIkd20rdEg5Kl8xCnDhQKvDfDLwa/vouPYeiVVsE4qJyktcNdwRmO1qCLfb?=
 =?us-ascii?Q?Xm4OvNlHK7uROGcRNc8Po0tZAYsSgIYxOO7J+obzpPMN8G3j260N4yl6+Lgr?=
 =?us-ascii?Q?YSpbb4gyoT2Ecn6YhWsC8bQb1C/AWzoAIAv78QJK2m+GHFkNfcKz+D/JNyo4?=
 =?us-ascii?Q?cHDxxsZWX52jGqTAEnKoeqh3sapA8ve1RH8M79zRjMKbRztRtCTKR3GJTUrH?=
 =?us-ascii?Q?LwAw/lBZo3sMUivGyycL7194J3Riy7mYfRUkWsoR7u648dq2LDrQhpGW/hg2?=
 =?us-ascii?Q?BiEzaXajQCci+BIzA0OcGkE+BiCt9WTBhvXo+2bXXeqNmPtozNh+N0obUD/T?=
 =?us-ascii?Q?QGFYw4DTDFqmOZTHvNkCVcpQfRjAv3UMe8Ga5k/stg+OKQqMWvhzZ3E0inxI?=
 =?us-ascii?Q?tly7xoPw95zYTwj+ut5PJmMguam+eJt0dengvYoOn0dSGKKHNoHdZKYGqC5e?=
 =?us-ascii?Q?auUqdpwoIIUthwfp6tWilBSbCinOHYDRAzgzJVz5ChsTtTTLYzPfLrVmW2Vq?=
 =?us-ascii?Q?MRddzAtHqbW9IRNI/LITgwg6KILWMy5JFKRvAOFqj+5dHK+S?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 80808e14-7fe4-4cc9-488f-08deb0700e34
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9372.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 21:47:25.8745
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: v9s8qH3mnmZt0UywR6FyxycuKi3gPiwXJj1/FlZKnQaUlSyxUZTLHdKD7yk51MydcsPwdjQ/LMoIqclg6ZaQ6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9399
X-Rspamd-Queue-Id: E730C52A900
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[nxp.com,none];
	R_DKIM_ALLOW(-0.20)[nxp.com:s=selector1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,davemloft.net,google.com,kernel.org,redhat.com,nxp.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-287330-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[Frank.Li@nxp.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[nxp.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	DBL_PROHIBIT(0.00)[0.0.0.0:email];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,nxp.com:email,nxp.com:mid,nxp.com:dkim,2.250.240.128:email,0.0.0.2:email]
X-Rspamd-Action: no action

Convert lan9303.txt to yaml format to fix below CHECK_DTBS warnings:
arch/arm/boot/dts/nxp/imx/imx53-kp-hsc.dtb: /soc/bus@50000000/i2c@53fec000/switch@a: failed to match any schema with compatible: ['smsc,lan9303-i2c']

Addtional changes:
  - rename switch-phy to switch in example.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../devicetree/bindings/net/dsa/lan9303.txt   | 100 --------------
 .../bindings/net/dsa/smsc,lan9303.yaml        | 123 ++++++++++++++++++
 2 files changed, 123 insertions(+), 100 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/dsa/lan9303.txt
 create mode 100644 Documentation/devicetree/bindings/net/dsa/smsc,lan9303.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/lan9303.txt b/Documentation/devicetree/bindings/net/dsa/lan9303.txt
deleted file mode 100644
index 46a732087f5ca..0000000000000
--- a/Documentation/devicetree/bindings/net/dsa/lan9303.txt
+++ /dev/null
@@ -1,100 +0,0 @@
-SMSC/MicroChip LAN9303 three port ethernet switch
--------------------------------------------------
-
-Required properties:
-
-- compatible: should be
-  - "smsc,lan9303-i2c" for I2C managed mode
-    or
-  - "smsc,lan9303-mdio" for mdio managed mode
-
-Optional properties:
-
-- reset-gpios: GPIO to be used to reset the whole device
-- reset-duration: reset duration in milliseconds, defaults to 200 ms
-
-Subnodes:
-
-The integrated switch subnode should be specified according to the binding
-described in dsa/dsa.txt. The CPU port of this switch is always port 0.
-
-Note: always use 'reg = <0/1/2>;' for the three DSA ports, even if the device is
-configured to use 1/2/3 instead. This hardware configuration will be
-auto-detected and mapped accordingly.
-
-Example:
-
-I2C managed mode:
-
-	master: masterdevice@X {
-
-		fixed-link { /* RMII fixed link to LAN9303 */
-			speed = <100>;
-			full-duplex;
-		};
-	};
-
-	switch: switch@a {
-		compatible = "smsc,lan9303-i2c";
-		reg = <0xa>;
-		reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
-		reset-duration = <200>;
-
-		ports {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			port@0 { /* RMII fixed link to master */
-				reg = <0>;
-				ethernet = <&master>;
-			};
-
-			port@1 { /* external port 1 */
-				reg = <1>;
-				label = "lan1";
-			};
-
-			port@2 { /* external port 2 */
-				reg = <2>;
-				label = "lan2";
-			};
-		};
-	};
-
-MDIO managed mode:
-
-	master: masterdevice@X {
-		phy-handle = <&switch>;
-
-		mdio {
-			#address-cells = <1>;
-			#size-cells = <0>;
-
-			switch: switch-phy@0 {
-				compatible = "smsc,lan9303-mdio";
-				reg = <0>;
-				reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
-				reset-duration = <100>;
-
-				ports {
-					#address-cells = <1>;
-					#size-cells = <0>;
-
-					port@0 {
-						reg = <0>;
-						ethernet = <&master>;
-					};
-
-					port@1 { /* external port 1 */
-						reg = <1>;
-						label = "lan1";
-					};
-
-					port@2 { /* external port 2 */
-						reg = <2>;
-						label = "lan2";
-					};
-				};
-			};
-		};
-	};
diff --git a/Documentation/devicetree/bindings/net/dsa/smsc,lan9303.yaml b/Documentation/devicetree/bindings/net/dsa/smsc,lan9303.yaml
new file mode 100644
index 0000000000000..42f8473538a07
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/smsc,lan9303.yaml
@@ -0,0 +1,123 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/smsc,lan9303.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SMSC/MicroChip LAN9303 three port ethernet switch
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+description:
+  The LAN9303 is a three port ethernet switch with integrated PHYs for the
+  two external ports. The third port is an RMII/MII interface to a host
+  processor. The device can be managed via I2C or MDIO.
+
+  Note - always use 'reg = <0/1/2>;' for the three DSA ports, even if the
+  device is configured to use 1/2/3 instead. This hardware configuration
+  will be auto-detected and mapped accordingly.
+
+properties:
+  compatible:
+    enum:
+      - smsc,lan9303-i2c
+      - smsc,lan9303-mdio
+
+  reg:
+    maxItems: 1
+
+  reset-gpios:
+    description:
+      GPIO to be used to reset the whole device
+    maxItems: 1
+
+  reset-duration:
+    description:
+      Reset duration in milliseconds
+    default: 200
+    $ref: /schemas/types.yaml#/definitions/uint32
+
+required:
+  - compatible
+  - reg
+
+unevaluatedProperties: false
+
+allOf:
+  - $ref: dsa.yaml#
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    /* I2C managed mode */
+    i2c {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch@a {
+            compatible = "smsc,lan9303-i2c";
+            reg = <0xa>;
+            reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
+            reset-duration = <200>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "cpu";
+                    ethernet = <&master>;
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "lan1";
+                };
+
+                port@2 {
+                    reg = <2>;
+                    label = "lan2";
+                };
+            };
+        };
+    };
+
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+
+    /* MDIO managed mode */
+    mdio {
+        #address-cells = <1>;
+        #size-cells = <0>;
+
+        switch@0 {
+            compatible = "smsc,lan9303-mdio";
+            reg = <0>;
+            reset-gpios = <&gpio7 6 GPIO_ACTIVE_LOW>;
+            reset-duration = <100>;
+
+            ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                port@0 {
+                    reg = <0>;
+                    label = "cpu";
+                    ethernet = <&master>;
+                };
+
+                port@1 {
+                    reg = <1>;
+                    label = "lan1";
+                };
+
+                port@2 {
+                    reg = <2>;
+                    label = "lan2";
+                };
+            };
+        };
+    };
-- 
2.43.0



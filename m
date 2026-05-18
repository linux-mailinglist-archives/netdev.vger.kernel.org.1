Return-Path: <netdev+bounces-288915-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ID9jJP7NCmq18QQAu9opvQ
	(envelope-from <netdev+bounces-288915-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:29:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 02267568C7B
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 10:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CD78D307BDB8
	for <lists+netdev@lfdr.de>; Mon, 18 May 2026 08:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7833E277C;
	Mon, 18 May 2026 08:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Bt26xTS3"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257523E1D14;
	Mon, 18 May 2026 08:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779092581; cv=fail; b=XLQ6wFbjl0RhlaNx1wCMVjKul5Cr46WCc1d7t3UhdaHG1A7A2wckmgZ9hAvFBudv3ad8LnetHiyUMCMIKyLYgF5DbCDnWYecYmYPuE4u3h13bQ4fOUeMOrnaGbzEE4L9TBhYPl1dEnFYwN07fIa4LnAGIyj59XH1oSf30kURh1M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779092581; c=relaxed/simple;
	bh=OyPXbG52WBg84pCeJobLritIIeyJGfjrW/hKuqChuQU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gMnRzaH+FsUGBwk3yQaaWmsoyjAuW9GqyMO/bBamIxvgw1flLJrhpg1rD1mDhBtDH/O6reHzl1UbwKPkWtbnELlYleqbLvElh/Gu68TJdW4oMG/2pVENI7UK7kfpIEMpBT1jT4ReicWjFa+XHa6KlmkiRcBeCHMJe6Dnm3US/VI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Bt26xTS3; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KDC2p58OW9UF42LyVUx/mjRcnNIT1KONz9KFVJyu0vlAUukuUf71P9m99rt+K4UBZeOIagHnjTolRzs3dB4YDOg75EDTZrhBtaXE/07lwee4wZ7brpqrjAKTmq7c3nw6k2IDRNy9T8P7anKF9tRdxsoUU0SqPrE7wz4yzQJMgKYHe5RSbGMn5C6dGA8DWUWjXYQZWO7hROogn82Zv39HxDUf/B5eOZK2ov+iHLJam9QNYpCxCcNtId8ec+/JHsssTUxJIugxM5z9/7ADAnP6dbnXLBEFPFbo10Db/sWkejP0l5Sdd83AlGiPSTkc8xhvkpasWXchJU+z+T22XGZLjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V3voDZ0BuJ9tq1vIoWPDfpf+3DqJH36ktgseQNif49Q=;
 b=Tf98lgSH9hJ0El7JL7FIDQ9Bue+VIDmeoPF0nhqCU0MkdxIpGZmiFXY9X2bmnR24kg5EpecKLaL2Eiq9v00TI6XU04/XkDs7AXIdT7vfPXNAcnsfNLl6iC7Y96X4atWbbClIbNYD0YPvLPzkioPlOcVN44eqODyEcCXmc7OmCLJsB/qNzzUFQVF1s1hVQXkuA6crJSjVN00WGa3n1HHEbhvv0ZVIAzUoV4Oq95lIllzIJ8wVdg67OvXQTiaWj9fWDSa4Bg08XnM8KoD2hd/KrMmAa0h5g6Ir5wK4evmlfW2jfXxoqMC1lpXkog+d1riylrELq4JhflD8Z6EA+FU0dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V3voDZ0BuJ9tq1vIoWPDfpf+3DqJH36ktgseQNif49Q=;
 b=Bt26xTS3MiCtCU+BttZpR/dupEBs5hm9ZksU3bFW95CZr2lruNdaQy0Zj917eTjnZv3+pF6hG2XRE/wIu1ZfpmnnLbDuwV4BsKsnLyRJteb+6bTweNrmWRZGJi3O5Wp3DqI58v7zrZrQoq+Tm/eW30LScuDBI0SwZHOGjjHVjJasVFX4IY1dPG3L0ZsJXYBwCzN+gDk3QFhrMcK6PVZmNp4I1eaTSvZtdxUOfMeHpPEwCpY/tAoJ3Cb4MIPI+qww+tjoeZ+STy8DmU1/tv3GoAyAjY3wX1ixD5GoBZWG6NhbHH+5LWN3PD6/BEgeMNwXmDsknU6n1fyHViqTSM0KDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
 by AM9PR04MB7713.eurprd04.prod.outlook.com (2603:10a6:20b:2d4::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.25.21; Mon, 18 May
 2026 08:22:55 +0000
Received: from DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7]) by DBBPR04MB7500.eurprd04.prod.outlook.com
 ([fe80::c291:543b:4bde:cee7%6]) with mapi id 15.20.9913.009; Mon, 18 May 2026
 08:22:55 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	f.fainelli@gmail.com,
	frank.li@nxp.com,
	chleroy@kernel.org,
	horms@kernel.org,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	andrew@lunn.ch,
	olteanv@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org,
	imx@lists.linux.dev
Subject: [PATCH v8 net-next 02/15] dt-bindings: net: dsa: add NETC switch
Date: Mon, 18 May 2026 16:24:53 +0800
Message-Id: <20260518082506.1318236-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260518082506.1318236-1-wei.fang@nxp.com>
References: <20260518082506.1318236-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0005.APCP153.PROD.OUTLOOK.COM (2603:1096::15) To
 DBBPR04MB7500.eurprd04.prod.outlook.com (2603:10a6:10:1f4::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7500:EE_|AM9PR04MB7713:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c55c18-6a9d-41d1-9799-08deb4b6a97a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|19092799006|366016|38350700014|921020|18002099003|56012099003|22082099003|3023799003|11063799003;
X-Microsoft-Antispam-Message-Info:
	8esSNVk2kVtnmdYuqAvfHPVePDagEZCuP/536ramnMjbHR9J/O5iLN5zjBDzbboNLZGYAxCNhw6v7LK6YRNc7VAP+knWKVL1O8NE03ocanU9LRWRa8ILws1gknDtnZLcr1o+4ovhXg7xL76zLiLaFEVe6gRFa5qNgILHx+l1WnVBF7yGOhfu0vFR99O6SseuyaxOzDL7BA4weMQ7ave+Z4rAjme0a9ezxqpPGcYQBJmASjDKJs+XwUac0mEm6pmkrDGGcCLDUVwkdIMkgITcjzMyK6t4QvGtP6SDuz9ypiPsbajiVesTvQtFVtUf6vASritn1RQwpDknMmRE+GQGAoi7RYrhJ9H9uIwd+2N+rCnwAnZVdGkK3hq1ZpUlHSvHvjUMYLHag6b/l1IvfBJwzOUD0cIoaXZwTiJjxf1B8yM7PYtAghL8q+FQyo9KPvD6sS06eM/NdwjBAGOIaKCcg10uOB3xjtVM+L47Q7KGz/bbRE7egO3Pp+APYiMHf6mKON5gNHwvhaftwTbFzLhDABKS5Vh99VAlTmfYtqt9X5pwjkThHZMixt/lkD0FWe9TcngOQPtCDRsYXvtPWsqsOMg/Ymi1zdp+XfniDclMS6OUsNteOT/CintjitM+DRMEnPWMDZFhsfd+RiRW+WWteX58UrQl53by0ey6BjAHLR8Q99NzrM8XR6aVOeMkf1eBEJhyJVxl7uJkhSj/Vvo79A==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7500.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(19092799006)(366016)(38350700014)(921020)(18002099003)(56012099003)(22082099003)(3023799003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?gsmIy/+UIA7k79MJKugKhZyUQ2kzsQkPxh1pCyv5bnRvJRIFOTT8GODzJVi1?=
 =?us-ascii?Q?xl6hbkuVnZyjL16otzS7CecDmTfxAbZsvgjet0S7gRbvOzrXpLjva0+LIZRP?=
 =?us-ascii?Q?slBLHq0K7ygwOsgrvpnl81cNEYn6jQ1RlQaZSlxiexxB7KKJ7KbFFqUlvo3P?=
 =?us-ascii?Q?N2rmkb21klbskXCGypH6WYsUWpUIS3rLCC9JbaKTxnTet27FahDVuydRHw2b?=
 =?us-ascii?Q?BaOQL9/g53ZC5mv1KIivlgJULaenKJ/aczmwm7TXEPZGHdQ6ESw083t8DH02?=
 =?us-ascii?Q?YPg/LpBtfk95wsKx829BGwif3Ytsw1OKDpiFxWb1XZHOxl6tAtz+HxlWce3E?=
 =?us-ascii?Q?92PfVgLByPvLxLpilmHUrwkFWn1N9lI2XRsc0c3RQwfSeazo6Hp5qpKyAFWa?=
 =?us-ascii?Q?PyfiQ1oj4zZmP7s5s78rGuHetbnTyE7M1QEi5GLrgRxWn4zNfRWtWOgKKvR4?=
 =?us-ascii?Q?G7TP0niYEdNcevxm5Ceu4jHu9XI2Q+ijUu5acZaQgf5yg+PC/bcDN5Uvtj45?=
 =?us-ascii?Q?lmRiMqn6DhsbMtEQLRJqtKvn5OnxQhmloeh843Fvzq86gSQ+Rw0fpH9AIeDJ?=
 =?us-ascii?Q?LrCfTPMKCYlvymx/hMrdVl42oKLTj0Abo2xYKHIihuMbBOmOeeqUjhFdAl8i?=
 =?us-ascii?Q?sgrY4otcFfvedUpFWlgl/RYBAsJgjpS7C9pVcCV/6i+sDEMs08ZUfaLeJsK9?=
 =?us-ascii?Q?SsKzySNQzBVj6QBsxg2pvCTddwxvqN0s7Zm66OJadovHWWExaTiELHsZrc0M?=
 =?us-ascii?Q?yORWY9CQwHWgsm27nVar5gXbOZxfp2w8V9QkG1IHeTyWYfiIzGX5oUjhXmal?=
 =?us-ascii?Q?MeUIT3+aHvZOLWeCP6bZMgMoh7zvAMLCVxAkn+42EK+vzJweisAfeosE0egX?=
 =?us-ascii?Q?Bd8N6s/6XK+Tox1/wjPPS02OxMOQjaafbNVxPcBmB1fVSAsJrJfVPkCoGp72?=
 =?us-ascii?Q?OQHrjKatKjDjPojUaU96Zxopvm5xGenqPDZ2tD2MzSAepkl4Ely4XUtHxQ1h?=
 =?us-ascii?Q?lv5x5D9/kc2Q5tA4A5gQte0+doNwbrTdgpH1zATLWAfRlPnagu+N3RiN2pls?=
 =?us-ascii?Q?hc6lK28JE6T8Uy0Hn5LSxqpeM+cAkUTy5NcXWrNfBEQ06/VhICmXEAXvXoSC?=
 =?us-ascii?Q?GqVC+FBUPGo5XKYXrnGujuc7fV8WfD0hg/bs6p88yt4Hi0jECGIfL9g5O17F?=
 =?us-ascii?Q?jda+Qw0HZulRKkkgK4HY3ohRNUw4RkF7CUDg/758ptRGZARvq9TKrNMG5W0o?=
 =?us-ascii?Q?QooHaZT5vILdPUxy7vMvlIHC/jd+uPouQU6m/g68iJni/VuTEHkX80nxrQ02?=
 =?us-ascii?Q?U79wx5Q2P2yIDXQ2slxqkNGocBVJnNxlHSwrIQL1/384bXK10No3qikPHg/z?=
 =?us-ascii?Q?a57cl9brSvExdDBHTc6gHFSJTPC82wtBTKNvKrSMepp7uuF9ZH3nvnexfiTY?=
 =?us-ascii?Q?y+MYsDBz82TZ+2WR3MkDjZCCVh33RSevVaAZ66xUhewikte7SugAg3AEh+EY?=
 =?us-ascii?Q?uNbAqGjZx+kLS9ILZx5C3Be/gj8ThkwUjf4h/WTyrDbiDLrhJo06IiZuDJg/?=
 =?us-ascii?Q?Q5W7jbyRoTsJAHj4tmTfVS/YWQesjwZb8WtIVJgDPg3XZoxMA46oGAzETHSG?=
 =?us-ascii?Q?vNtaBpIOARMwqzEUSz1fF0NSa2B3BWLVdNIwr98kKfwELvL16fvrown+KBeZ?=
 =?us-ascii?Q?8hzQx9y27zMNJ1qidDZCmLN3gV7WEflc/xhIKIbmjuzb5LqzuEsijMc8Dmgh?=
 =?us-ascii?Q?40ACrp8Xqg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c55c18-6a9d-41d1-9799-08deb4b6a97a
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7500.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 May 2026 08:22:55.6505
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFbonSByiE8f/OaakmUASXl4QPQfBYMrqEdPCQjybPyKwLoFly7W0XvQFZRF9rVb2cAt65d/S7snmrDUhnFnng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7713
X-Rspamd-Queue-Id: 02267568C7B
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
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nxp.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,armlinux.org.uk,bootlin.com];
	TAGGED_FROM(0.00)[bounces-288915-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[25];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wei.fang@nxp.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[nxp.com:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev,dt];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

Add bindings for NETC switch. This switch is a PCIe function of NETC IP,
it supports advanced QoS with 8 traffic classes and 4 drop resilience
levels, and a full range of TSN standards capabilities. The switch CPU
port connects to an internal ENETC port, which is also a PCIe function
of NETC IP. So these two ports use a light-weight "pseudo MAC" instead
of a back-to-back MAC, because the "pseudo MAC" provides the delineation
between switch and ENETC, this translates to lower power (less logic and
memory) and lower delay (as there is no serialization delay across this
link).

Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/net/dsa/nxp,netc-switch.yaml     | 131 ++++++++++++++++++
 1 file changed, 131 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml

diff --git a/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
new file mode 100644
index 000000000000..1b35e4cbd049
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/dsa/nxp,netc-switch.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/dsa/nxp,netc-switch.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NETC Switch family
+
+description: >
+  The NETC presents itself as a multi-function PCIe Root Complex Integrated
+  Endpoint (RCiEP) and provides full 802.1Q Ethernet switch functionality,
+  advanced QoS with 8 traffic classes and 4 drop resilience levels, and a
+  full range of TSN standards capabilities.
+
+  The CPU port of the switch connects to an internal ENETC. The switch and
+  the internal ENETC are fully integrated into the NETC IP, a back-to-back
+  MAC is not required. Instead, a light-weight "pseudo MAC" provides the
+  delineation between the switch and ENETC. This translates to lower power
+  (less logic and memory) and lower delay (as there is no serialization
+  delay across this link).
+
+maintainers:
+  - Wei Fang <wei.fang@nxp.com>
+
+properties:
+  compatible:
+    enum:
+      - pci1131,eef2
+
+  reg:
+    maxItems: 1
+
+  dsa,member:
+    description: >
+      The property indicates DSA cluster and switch index. For NETC switch,
+      the valid range of the switch index is 1 ~ 7, the index is reflected
+      in the switch tag as an indication of the switch ID where the frame
+      originated. The value 0 is reserved for ENETC VEPA switch, whose ID
+      is hardwired to zero.
+    items:
+      - true
+      - minimum: 1
+        maximum: 7
+
+  ethernet-ports:
+    type: object
+    patternProperties:
+      "^ethernet-port@[0-9a-f]$":
+        type: object
+        $ref: dsa-port.yaml#
+
+        properties:
+          clocks:
+            items:
+              - description: MAC transmit/receive reference clock.
+
+          clock-names:
+            items:
+              - const: ref
+
+          mdio:
+            $ref: /schemas/net/mdio.yaml#
+            unevaluatedProperties: false
+            description:
+              Optional child node for switch port, otherwise use NETC EMDIO.
+
+        unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - dsa,member
+  - ethernet-ports
+
+allOf:
+  - $ref: /schemas/pci/pci-device.yaml
+  - $ref: dsa.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    pcie {
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        ethernet-switch@0,2 {
+            compatible = "pci1131,eef2";
+            reg = <0x200 0 0 0 0>;
+            dsa,member = <0 1>;
+            pinctrl-names = "default";
+            pinctrl-0 = <&pinctrl_switch>;
+
+            ethernet-ports {
+                #address-cells = <1>;
+                #size-cells = <0>;
+
+                ethernet-port@0 {
+                    reg = <0>;
+                    phy-handle = <&ethphy0>;
+                    phy-mode = "mii";
+                };
+
+                ethernet-port@1 {
+                    reg = <1>;
+                    phy-handle = <&ethphy1>;
+                    phy-mode = "mii";
+                };
+
+                ethernet-port@2 {
+                    reg = <2>;
+                    clocks = <&scmi_clk 103>;
+                    clock-names = "ref";
+                    phy-handle = <&ethphy2>;
+                    phy-mode = "rgmii-id";
+                };
+
+                ethernet-port@3 {
+                    reg = <3>;
+                    ethernet = <&enetc3>;
+                    phy-mode = "internal";
+
+                    fixed-link {
+                        speed = <2500>;
+                        full-duplex;
+                        pause;
+                    };
+                };
+            };
+        };
+    };
-- 
2.34.1



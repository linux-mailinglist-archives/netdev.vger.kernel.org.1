Return-Path: <netdev+bounces-202556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69A1AEE433
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:21:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2357C3AB89B
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:16:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C01F8290080;
	Mon, 30 Jun 2025 16:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="e7gOXzxY"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012047.outbound.protection.outlook.com [52.101.71.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD6128DB68;
	Mon, 30 Jun 2025 16:16:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300192; cv=fail; b=Dfuj7Joypl4uiwojuPDSA1tC463C9vHQk8B189ozo9M2IX77KejWn57+zU4+Je65j48CEGtuXNa/iyc0p3qJyTdIXhgCMyAieIOHAkzr0sOEm/2CYba5WvBgOLBmynQunsqCgZjLr4UFGMdF3ltIibU+Wl0LXL0QtYlQFXNper4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300192; c=relaxed/simple;
	bh=9yqiV2i0/bHt53RUon3EyIajOAPHTuaR5Ujyua+iW4A=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=m7FYwaIL3dyd5Ey7hhAtcPi+DOuvpuRwgc9aotFB/rJFXDikAVbWb7YaXhcQnArWPox2rV0qFHuAL91xGdvqDrm36xwB++vH5RL2adurnefKU1LlZ8ROPz7rkz1dIV15y0FDqqvOtRPZ+NRcA/oCnWKoNqjWxCprXGG+/zIG8tQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=e7gOXzxY; arc=fail smtp.client-ip=52.101.71.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ryrFweWi/8DzJxSNquGXnjgw9kCcqg5Xa360r4T2S/uxy7TxJtnZdHgR625XwL5rjUxrx/i9lWDP7OoFPF0Tua6M0KQuCv2t1V5xWbkUb+XgurX6gqEkI56gq7zfNsjj22IvfvnIzf14jDIRcQT2zlkTiv0KY4CfcV3JEP4WRUaEbfguPk46W5JODEomoe9gn8iJFYBbKM7Hl03iNcvQTc8dORUyezkbndZ8O1026RBTve86LTdIbir/K9YwugPSxzJmjZbbl1nbDWTe42SWUrhnpxXmvsVz0gQIFcQRdw1bFydMU/OkFEjeirMg8xThibyfNwVnR3guZj21mx13Pw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XHISNHExruPOttpTn5np1SevZGH2TmNOTks1P4rz9so=;
 b=oMfry2JUWPOW/uzKp9mwphNTaYuPAXJbpX+M0iVXeNQk7Ah8ODPBqnvRA/cWw5OdXPhrUXZS+HAcDvZsjH+ILmDJKr5TWy1633oKGijUvEeubA/zO39W2A79YyVGnFXR2v6DHTphN+BGwsz47yVF8JNeU96uNgHQCqIA8vUBeuUILcjVyEc4Y9B3WK1Gn5IdZL9qORbpzeQnzMJf7L0qFid123mJjqUMWgzGVYABO69VbntSVY6xPjPwcdHWCrmF3LCLuwpauermgNLDGLifP0EIt6w4AWrjVwx2tCala5whVTGlhFK0tfNYdTORnCKsB3D/1wAc1DRO3LMUZLr6RA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XHISNHExruPOttpTn5np1SevZGH2TmNOTks1P4rz9so=;
 b=e7gOXzxYVZjB53PgpFpFkMYYdTySxIE2mrUs+L16bWuZ6GmE0QN2Vu8jCphWblgcbE76suuea2QA7eiDuSH75qUv0xIFwgT4nOJBVsagsSoi2TlHDxO8dlXM1q4imRx33UnTR3hX0hjf+ChpEeqzsb6fmyNbZ+jJf/yInNq6z+mXLOYDmep+DXfcaXG7nj2s72v4x/lCiewDfiVXpq3R7DZOSlFkZlSFiCWuGczjyCPDk5rAEUSVfuMGvKm/8uCnHd3SxS9yr062S5033g4MvDOSAVgaM+hIZoJVSFDTE9FrnSl7+xApn1W9rjRsLTFDxMqCZnBg7ZkTNLz0L1JIeA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com (2603:10a6:10:309::18)
 by PA4PR04MB7839.eurprd04.prod.outlook.com (2603:10a6:102:c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.31; Mon, 30 Jun
 2025 16:16:27 +0000
Received: from DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d]) by DB9PR04MB9626.eurprd04.prod.outlook.com
 ([fe80::e81:b393:ebc5:bc3d%4]) with mapi id 15.20.8880.027; Mon, 30 Jun 2025
 16:16:27 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	netdev@vger.kernel.org (open list:NETWORKING DRIVERS),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev,
	vz@mleia.com
Subject: [PATCH v2 1/1] dt-bindings: net: convert nxp,lpc1850-dwmac.txt to yaml format
Date: Mon, 30 Jun 2025 12:16:12 -0400
Message-Id: <20250630161613.2838039-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4PR09CA0021.eurprd09.prod.outlook.com
 (2603:10a6:20b:5d4::19) To DB9PR04MB9626.eurprd04.prod.outlook.com
 (2603:10a6:10:309::18)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB9PR04MB9626:EE_|PA4PR04MB7839:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6bf146-5a91-4e45-f00a-08ddb7f176f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|366016|7416014|52116014|376014|19092799006|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?cBKOjYcX1G81nDUy+ZaBbH39OO1UA52rsgVJeFqSUlYWHMJT7Xfc3XBH642T?=
 =?us-ascii?Q?mArpukmQO7LNAjfCq8M1jEuv+fXBganaUHgS0fa67WXlzYY6mmS3C/6KQYZB?=
 =?us-ascii?Q?O0yM3nLZ7UHwmI/JPM9EGR8V6UVX5O7KzwDx0NqrbP6C8yptnxDD3kZXp4jL?=
 =?us-ascii?Q?RbCkeJ+qVb2jAiIYMgkwnzbv7kK7KCHX1nFv2mMvmXyVmMMurG2L1d36c0aR?=
 =?us-ascii?Q?Z7h9YiZDioo51uO20Mgm1KBW/6bA3vHwkb3hc80TzId1545TNcilfOV5DirU?=
 =?us-ascii?Q?+GpGv27xymW6r0lmphf09QN/nj3otD7CExciwg0gLsEEHf3I1jKekCRIQ/ft?=
 =?us-ascii?Q?zYm+UwF1B8dr15ncinup1dxIGnGDDTx3QtjyzShb2LYLVcdPHJaQvB70L35n?=
 =?us-ascii?Q?oQg/xquqrs1SK04QXdJjQ1T8xmmo5z2dA5wxVxqAHP/KpZNsY2nU/HiPNrYJ?=
 =?us-ascii?Q?fxhswqW11T3P6GEgWHfiQ7vnr/1hp+FBeMq+rstBmF3qksp30DEbeC2RhlKA?=
 =?us-ascii?Q?7Xkg8eB2vONQa7h/7/V7s4KPjsO/ZYCTqGLNxfZvGZBPcpL9XAcFZnlf8kZS?=
 =?us-ascii?Q?367sba8hhzCYeDPYHJaYGcRrLffHkQYd3Znf3vykDCBD3W1mNrRLxAG+OHWk?=
 =?us-ascii?Q?lSjO20dHFUFVrnCxo1CagvOxW9ZifUbSnoKLv2dNHVma9a19M9aXbKs8y+qJ?=
 =?us-ascii?Q?RwFqfedJgljcP5Px8L5F/RC55l4XOcYTiQPRZGyeb3Q0QMzA5GwOSB13v/dM?=
 =?us-ascii?Q?td7Et2JymLGG1VJ0pbOsL0vfh6XXTImU7MWXW6kb9yR3QfkxwyzfouqYm4DP?=
 =?us-ascii?Q?Lv7uho04bKpydqvsDX9OQbXI063HZdM9tUjwVUnZFgnrQIhBedjHxcbq1/dU?=
 =?us-ascii?Q?qpcDO8FwA4HVDS6/Erc4KlMJqHrx+86ROCCAMvaT+D7ye/O6pf462PoH6lDO?=
 =?us-ascii?Q?LEoAqyIGp5iVzTJ+FVJON+tp3iqsMbcmPUe6seEqUGOJvNBhUfDhhYXDG9tb?=
 =?us-ascii?Q?tFw+Vkeuj/X6G4UgeDOoOxTYGjiOZ5FN/4WYhaNA9tQdXw2hmEQQX8yQQde+?=
 =?us-ascii?Q?/h7R9M3QB9nVuJBOjiYICVIT8DCpHNkA1sVA3AjKQFjrPhAYRnNt/ISm4NxY?=
 =?us-ascii?Q?GgHYhYO+z0ikircdwiyVgs8emX9wUp8LuKHQL7ku3JUC4e3wetaSYCAU7PQz?=
 =?us-ascii?Q?y2fuQuMGGPRZOgTxPW3NnDHKi5wWbmy/IErf8RMwS/43szuwvW/oLke9ddMB?=
 =?us-ascii?Q?mwwU/WJCO0Veq7TLpLUXJ12NJXzyOuwK1l/6rJUmjR0imSCyf+xdwCSklK6/?=
 =?us-ascii?Q?+5YcPvoNTvNaeLknqLOJ1h/Xz2n6oAsQRrGhXLGpB53ON1A8rDKXaSexp1nz?=
 =?us-ascii?Q?sYyv+ZXp8hKlGMu72bMrvQHgreRHoqx0jJav6GHFxV0KOQ4P+gwjcmzhI8JW?=
 =?us-ascii?Q?ukGgqJzyM4hRjQO/bI4mWW0b2fwdnNM4?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DB9PR04MB9626.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(52116014)(376014)(19092799006)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?50u4TyvTxUosPhw/7+AWKQ3V6UU4IrqAovxRCZKQym1XOfCE4ljaDPDiUTeh?=
 =?us-ascii?Q?A3rnah0U0ioMXjvzrfjs5MyRT9NRyS2iHuGihlxcLL6XJ1aF9UBHvjpZASM1?=
 =?us-ascii?Q?6BF+W13uh62IWh9CzAma2HBzY4HxxVeOJjSMv05RA7ZuDp1v3bv7oHaNYlX3?=
 =?us-ascii?Q?8JcE+2M28cm3pFBqGwILxd6ZR4lMhFOBwcObxqIhOqTVbf5a7dz3Gam/7RiV?=
 =?us-ascii?Q?x8Q48OoBLlENSmvhanE+RK8P5qPPyIV7gtG97bz9XGLtAFfuZNGZqwR2Ok3V?=
 =?us-ascii?Q?KLlouv22lcgK5yqKhuzmQ48YxW9ZzIxE3bEbgVy59LaelMCNROjf3gCWdGLb?=
 =?us-ascii?Q?R2PeriQbnaR7/4kJuo2ptqqIPEWN0ATNvkpWTftjgxXABMeBjrYbOUaES9ob?=
 =?us-ascii?Q?Pwwe4aL4yzZTNh6EDKdGNUzqC7oNc4X3CQf7zRG3NaP4fGV9ILupa61KKYAo?=
 =?us-ascii?Q?pn7Ll9cDJ8LZQNB3sA+/7Z7AmozIb7DhOc1cNwigZ+joegOoKmbB/PjAV4rf?=
 =?us-ascii?Q?ej6UXm8HzFyCDfsgRxa/LX3N8FFI/svclAgCiZAPoegnEVBsWBXH+hLon3GO?=
 =?us-ascii?Q?UdASN2S+bCT0Yh58A3UqLhWyOVnAsSZJvzWV417yTrrWy31WJC3yroHE/bhS?=
 =?us-ascii?Q?6Fw9CUGwS5WL0gN6BxK14GHKZGuBsrYXkf4NWbUJZGdEY0dRvhSPObGXeYPW?=
 =?us-ascii?Q?wRCGVQjNh96I2Ki143HSuW8JzIH+UwtVMyDHe75hQqwfVgq6R6p8yns53xGl?=
 =?us-ascii?Q?Y2fCAdsUwvQsw2nEQMy1b2sQpw3myitE5JeZUA6AUfhFatr0KwnCwt3689di?=
 =?us-ascii?Q?P4UHMR9/WIDnT/c7JidpSEzKuAAO6aOYbK6GvOEK49FuLhDPuv3NpOlOYvyy?=
 =?us-ascii?Q?bi4s6NfM4YNd3WWnH4hyn6f2S43c+OGiG56ZGU5bGtKFQgZdHkJsIJzk/rqk?=
 =?us-ascii?Q?Vy3CDLcrZP8DiURPvLS6MFVGFhlFhInUUux8cDMFFVyYTf1HXZ6IjqupZhRv?=
 =?us-ascii?Q?6++ufnt/8Bdb63SSAuk3McRa23104jBPxQNXFVleNVav3KoxfOTXKQxoDSyq?=
 =?us-ascii?Q?qfE26JyJZb74SWSrdbqivqDkLoArPCzOYuRIE23az5rHimgRftxHpLKNuJEr?=
 =?us-ascii?Q?ROY5aK0SJQ/AO7DxR1w+5611+7Va8uu3FurSu1UtMt2CHCcxz4WmKOct1DL5?=
 =?us-ascii?Q?LNp6UFoVv9kVRYTafU2WNVAtDIW72/JOj8ArPeIVwZKMz4pLzYjnpr7eY4vF?=
 =?us-ascii?Q?N8uOJHHtAZCPzzyVlGQESUeNFpZ7Lsps9cifqc419UOzKnoaQX7zpOBkXIKw?=
 =?us-ascii?Q?qzYMrrtxFYHRAS1t/liV1GQTQjaIQDkZ2wUdn+tjugYmS0QnuoH0SFecDAgM?=
 =?us-ascii?Q?jC+JapDD3rW1BdxG42JwjbwZdU53ZP+0NrNX1m8AMPSGgRy2CkrtwVEdJTX0?=
 =?us-ascii?Q?ZkV25xriWR9Fm8sX6vg/xNRCX6vO4ko50voCrPWVTGHb7vCfrNEbz0KK76sm?=
 =?us-ascii?Q?ctLy8fhTVOLPpmRSFF30WMKtPU1D4/L+W5DYQ/4/CPeqW4MfJT95mvD+4v3m?=
 =?us-ascii?Q?MFQWq5OEafmwEJj1+Og=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6bf146-5a91-4e45-f00a-08ddb7f176f9
X-MS-Exchange-CrossTenant-AuthSource: DB9PR04MB9626.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 16:16:27.0497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dd9OXIq3EQCvOSg2QkOBzuWjv+Vr+SgFHXfa6Y+rsFKADW5zaFc/+iHwXjKFm6NNOBDHMC1SMLHIHq9Ig+0hXw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7839

Convert nxp,lpc1850-dwmac.txt to yaml format.

Additional changes:
- compatible string add fallback as "nxp,lpc1850-dwmac", "snps,dwmac-3.611"
"snps,dwmac".
- add common interrupts, interrupt-names, clocks, clock-names, resets and
  reset-names properties.
- add ref snps,dwmac.yaml.
- add phy-mode in example to avoid dt_binding_check warning.
- update examples to align lpc18xx.dtsi.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
changes in v2
- add Rob's review tags.
- change phy-mode to rgmii-id according to Andrew's suggestions.
---
 .../bindings/net/nxp,lpc1850-dwmac.txt        | 20 -----
 .../bindings/net/nxp,lpc1850-dwmac.yaml       | 85 +++++++++++++++++++
 2 files changed, 85 insertions(+), 20 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.txt
 create mode 100644 Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.yaml

diff --git a/Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.txt b/Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.txt
deleted file mode 100644
index 7edba1264f6f2..0000000000000
--- a/Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.txt
+++ /dev/null
@@ -1,20 +0,0 @@
-* NXP LPC1850 GMAC ethernet controller
-
-This device is a platform glue layer for stmmac.
-Please see stmmac.txt for the other unchanged properties.
-
-Required properties:
- - compatible:  Should contain "nxp,lpc1850-dwmac"
-
-Examples:
-
-mac: ethernet@40010000 {
-	compatible = "nxp,lpc1850-dwmac", "snps,dwmac-3.611", "snps,dwmac";
-	reg = <0x40010000 0x2000>;
-	interrupts = <5>;
-	interrupt-names = "macirq";
-	clocks = <&ccu1 CLK_CPU_ETHERNET>;
-	clock-names = "stmmaceth";
-	resets = <&rgu 22>;
-	reset-names = "stmmaceth";
-}
diff --git a/Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.yaml b/Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.yaml
new file mode 100644
index 0000000000000..05acd9bc76163
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.yaml
@@ -0,0 +1,85 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/net/nxp,lpc1850-dwmac.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NXP LPC1850 GMAC ethernet controller
+
+maintainers:
+  - Frank Li <Frank.Li@nxp.com>
+
+# We need a select here so we don't match all nodes with 'snps,dwmac'
+select:
+  properties:
+    compatible:
+      contains:
+        enum:
+          - nxp,lpc1850-dwmac
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - nxp,lpc1850-dwmac
+      - const: snps,dwmac-3.611
+      - const: snps,dwmac
+
+  reg:
+    maxItems: 1
+
+  clocks:
+    maxItems: 1
+
+  clock-names:
+    items:
+      - const: stmmaceth
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: macirq
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: stmmaceth
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - interrupts
+  - interrupt-names
+
+allOf:
+  - $ref: snps,dwmac.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/lpc18xx-ccu.h>
+
+    ethernet@40010000 {
+        compatible = "nxp,lpc1850-dwmac", "snps,dwmac-3.611", "snps,dwmac";
+        reg = <0x40010000 0x2000>;
+        interrupts = <5>;
+        interrupt-names = "macirq";
+        clocks = <&ccu1 CLK_CPU_ETHERNET>;
+        clock-names = "stmmaceth";
+        resets = <&rgu 22>;
+        reset-names = "stmmaceth";
+        rx-fifo-depth = <256>;
+        tx-fifo-depth = <256>;
+        snps,pbl = <4>;
+        snps,force_thresh_dma_mode;
+        phy-mode = "rgmii-id";
+    };
-- 
2.34.1



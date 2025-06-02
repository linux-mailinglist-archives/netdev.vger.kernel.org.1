Return-Path: <netdev+bounces-194612-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC31ACB1EA
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 16:25:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2280B7A1FE5
	for <lists+netdev@lfdr.de>; Mon,  2 Jun 2025 14:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494DF22DF9E;
	Mon,  2 Jun 2025 14:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Tim55ERH"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011012.outbound.protection.outlook.com [40.107.130.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E74222571;
	Mon,  2 Jun 2025 14:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748873816; cv=fail; b=RKkbHMbkj9WRtmt0GPc1xO5Syj9NRNGaAyWOmEh3qGCs9ZKGXGaZhWDDg0U1uzeZnakxg00s07cTW/Q1AZMZxN7R6OEi+O5Gr66QB4YEtpb5OjjUnQlssYdlZKOUIMOdriXkJYoA6sGsNHZcqWfwwTYCto4W7OZ47vqhKST0R70=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748873816; c=relaxed/simple;
	bh=Q9SobM1tGjvailQSjvRbueTikKGoL48izsLOa1GSZGw=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Chbw8UtDHUSWBk4bro0X3YgmkcZJl66SLg7L7YDbIXM++lqfurRd6cEijysmsy3r7Q21HbuwLOiBGVco3S2QZWor4/CuPm3eclh7bfKjxCSugJn1ZI4YJZZfJyvBOqf8CwrnojwpsWg5XIouJ3GtYnVscO3+NsN+TB3LqM7ePDg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Tim55ERH; arc=fail smtp.client-ip=40.107.130.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tph/HqAi3CYC1GctT0VRdB1o9dPXyfZvrpNMpmmljomNOcOgmXNv/bdx7YE/U9Zx06gBv+twXV9GAVk6ES7Kxk68MJbUcwcGVWflbqJtMeVY2UWJqlysTeUlAipYwjfJTPSjyajMkAIdZFUPqTp1Jmp73eE9LRIg8XlRbqa7ogxuqfbpp1BYcaijht1H9T0WEY6aXv/efXPUWqRGVsFiPmZJyYhyEHiHdtyBznC7Eg/AV5Hl9eShJ0YjnJNN6pNQTMlfLXxklQ7rPK2hFVqgXk46u3exXy+xyxbuwbFLTl9Qtz+5aVBG0HLe+QX+5fVR2ai/tkKapBZzPpHlj7BLCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GlG7MekXwgEc/g0+ePzTGLxrMz8woF1UDGt+qvjwgg4=;
 b=d33bl8pQDDzrxnwRfIJLapjNbIBX4suvwaQgsEyZVxKQpyFT25p6tTyVbmUKO7r8RUZebT8QJeEHravEsYFU+VhAZkyuFNUIpDjzIGIkxkiXXXoH9nGxzi+YFVJm5ZVLQj6nb8DKYTIeqGPEARlJtW+F5Ydqa8vf1XsrvBPDFS3+2sNVa5r9AySbX8CkhxVLtqyL9ZSkQCdA1/zVeFa+h2ENFY8MjqAKC/JgYF/BDZTOd0sgwLpx9p9DVsqvxgHjDn8s+HQqLgVBvZPbhKnQJ2utaMOKQfi9fNUDPgVpzrdTThsKjRmAR8Dl9EIpitAK/EomBjD4sGae5WIxjqeGhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GlG7MekXwgEc/g0+ePzTGLxrMz8woF1UDGt+qvjwgg4=;
 b=Tim55ERHpq3PZgcxjx3VXWCQ0fASqN3IMA2kU0rkfdkFFFlKCeRz8s6hJ1DmSWqUw1B+AnyOU2r0KO5KnVwnopRGQnT1vt+HRGXlC0DrohWd9C2B2g3Weak/cCi9aMHqBFlUjiNgOfMpVaq5g5knx4cv7bocNxRdg37kDqeoEdUfLbqtE3vh8JdbGcJbKhxSTypokYzwP6jA2SXANQOb7Wd53jfWWHIEKA6dui8S964xgQaRfmahUe1asry3F7vvxwfhRvjXpDRw4N3w+DdjfTTktj64fQGzfPiRQzQnGwoGVtnjHVRPZSwxH8pJx2QAhjjA2JaX05y9WiAskZupNA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DB8PR04MB7051.eurprd04.prod.outlook.com (2603:10a6:10:fd::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Mon, 2 Jun
 2025 14:16:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%6]) with mapi id 15.20.8769.025; Mon, 2 Jun 2025
 14:16:50 +0000
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
Cc: imx@lists.linux.dev
Subject: [PATCH 1/1] dt-bindings: net: convert nxp,lpc1850-dwmac.txt to yaml format
Date: Mon,  2 Jun 2025 10:16:36 -0400
Message-Id: <20250602141638.941747-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ2PR07CA0015.namprd07.prod.outlook.com
 (2603:10b6:a03:505::28) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DB8PR04MB7051:EE_
X-MS-Office365-Filtering-Correlation-Id: c1b49b9b-8f5b-4bfb-c6ab-08dda1e01e08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|7416014|376014|52116014|1800799024|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?evrf6ND5fe4j2GrpurffsgO3tRzwLOAPCNrOim5gkfSa3Vc/aEnrKPEWZc+t?=
 =?us-ascii?Q?r0ANJl40jVZo/8zB0mM21geYpzLKKrFZwx15YC4di/HzllSusQ3w1rybktxV?=
 =?us-ascii?Q?L/WDikgeZiT+DQtGE8YLGHiQVoseChnx1o9lH71nD9yIpQviiDP9fsJvYtFY?=
 =?us-ascii?Q?aoI5FO3OGxskXqeshfIxyCiI9ZlDHpJmrHUYC9kJ0GMo+xUhDiy6NwjMrlyg?=
 =?us-ascii?Q?awmPpVOOuoQyiuvRBi9AWKOaukfIDWnJqpkY3sU02VEeQi9SSakyTvYUEX2I?=
 =?us-ascii?Q?Bzr0CupBiPiaDVy+tNux4cSmXuWe8alE7RYsEOflIz0VriXkhJedc47GeaYF?=
 =?us-ascii?Q?eqGVsQKkcVD6a0K6Hd69w3KmMvkb2O5UEztsnszcgALgvcRc+k4EM+mGQwiV?=
 =?us-ascii?Q?twH9ZhPlaW+9NIyL6852dY2fBuIbZYFDHoccBpqoPG3L6hLpaID2tJLVEdWd?=
 =?us-ascii?Q?H1T+t01+JV9u6pZ3Fdqev7/vIsq86Ag51fq+Vos32Mjzxu818S4cmiANW/39?=
 =?us-ascii?Q?XQo4cKkHBeCpeXdBS8QCvk4o5VRrEAhbwaODgspY3uliRNoT9t/Y5lxs5SsY?=
 =?us-ascii?Q?ryy1sY4BCzhiXQ3wU0/3/vv8uaRvmKgpjJNYbz5kYBh0S/1L2yXVW0wyfih5?=
 =?us-ascii?Q?Ilt5aq2I0uRbRi0RorA1rKCHvC677OgGn0n99Uaif4QBahDpRTeJxpG3n2Gy?=
 =?us-ascii?Q?iHzWLI/n+E/u+7u1cgKKSTPa7No+MUcBcqcCITesTDTcUtDd2dApQt91PatQ?=
 =?us-ascii?Q?djoY303Bjk1WzUQv8KJ069kZxC9RZPv73sTKCNeQYN9/XF2Wb/rDr8Gv3qsc?=
 =?us-ascii?Q?B3fuKfeFzoKq5V+pwtyExBl4ICJfvC7I4Yeow6rlJ+uYhkqjjuCjM7xXpzPe?=
 =?us-ascii?Q?kmtuqIZvGGm+pN4DB+3YUSYOxrw5BLgJP314X3wjLDDjnrX0QW7vkRiarIdp?=
 =?us-ascii?Q?sDhClzpsqbSLItE0UQsWEdfotQpqYbo+ReR9eYHt+eSBcPFuo4JxjwrnIvjM?=
 =?us-ascii?Q?dBnIlxrLTCgmXc0hcvoMMxRb5zYwTWNuO/lRYH4XDV2Q0URBWlasa5pXqqPs?=
 =?us-ascii?Q?GbeaSe2kPZjQgCwtYiHlikbcVB6upp7uKVTkRrFvGh1DNG6tall1uwte9qhj?=
 =?us-ascii?Q?paZs7Dsuywp3StGLqzEZBOqxTVid+aNXhbLG4G8KB4AjEUZ++MZp0pZT5IZ4?=
 =?us-ascii?Q?sEGhR+FSTIJyXz28ebxcx751zB2jqWtdotMpz99qS+xmW3LJ/ef7w0oSWeq6?=
 =?us-ascii?Q?V53YThb82QysVX2wbXl5p+LEkDPQLZLJ0i/0ImZWtJfurchwTMFmBYGBw8DW?=
 =?us-ascii?Q?V6tiKO74fV72HIEcAyYgH+4LH3DDc+TyCVhg7RI/X6T7RBbc+mlnoZAFh38m?=
 =?us-ascii?Q?CKmwUV0vK//XNe6NHMceoqJ3fDBFq4VGb+Wb3ZwRybMemh70mKtPYD4LPozP?=
 =?us-ascii?Q?CQpPxxG/xbISrb1Dtv8qpYH3oOd28m4muxyKbNVPx8A1w7eLpNa75Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(52116014)(1800799024)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?/AE18SYy+DOSjIfCCRerMWmAIX8KBQqLc34w849fwkzIIWsmhUiTF8FHTb5u?=
 =?us-ascii?Q?abFZFyFvKdDP9avlApvDsKJ1eAmsxvfnj6Cf4MzdAI6UWMpTaBVOorPm8TT6?=
 =?us-ascii?Q?H8OU+6rvxBVQldSgd2bDTowefSzlGiWo+0CCRtk6F2vl7gRS+ih9MQEjcjCT?=
 =?us-ascii?Q?rqbuujRLS6vQflsrnGKHprngUkRPgfpQSAokgL2fW13TRyXhtGHqiqj8DO2j?=
 =?us-ascii?Q?XaV2k2dw7DcSUOwrAhjFedt2GnwUX7bLzWgc/l/H/FOWMlIq36iEcq+kyFym?=
 =?us-ascii?Q?w+IAIDZF8KorjWWgwYzRfur8Nv4b6PokYNb/fkGbnodw3LbdCfaFEprL03Mg?=
 =?us-ascii?Q?FDPG0MXRGRhs3OjwLm86WbacIxLftMRtNGLSKmImUCMP9SHEG01W7T70zmLQ?=
 =?us-ascii?Q?D4jRvJhIny71qZcVyCOqeZIDwbuBa59IIMGnWNRGU9son1tQrsiGCg03Nd+U?=
 =?us-ascii?Q?izVY9I5JitDBmZOR3EfbYAS+PWXnHgR/IrnlKol66VQROn7oMUheoqfANOEA?=
 =?us-ascii?Q?lKX51GxrMd07gxHf81gZz+wCXQWbGUINJd+8wzVPO5BHIQCYgVAI4T/UKc3D?=
 =?us-ascii?Q?0xUo6LwLbMGQJS60m39y+7hQXCLBWM44AxKwzAsnMniKjA6VHvWB9uG4hOYF?=
 =?us-ascii?Q?X+ld3kQS+IPs+4nvnCg/MNUZ7llztdKrzof34iM4eiUYPr9BWJlQCiVOlZXd?=
 =?us-ascii?Q?CSe82RhiO93npzDInWrCLfUV1eKxigr0S7thgef9oR8Q7dlWsUesxVLtPJ5O?=
 =?us-ascii?Q?nmbRl0Pay8FLhoPAU/aENqcdRbQs3I1lKQBLRKRH4pgfT87ZJaL7Ehzgf9g3?=
 =?us-ascii?Q?kM4kPCEC9YJ24earatpQGLMHXK32TKzwQethPyXJ+m/4/Cq2rjsWcbrRg4N4?=
 =?us-ascii?Q?lPTLf/5I4Bj4pqSNbill15jBu3LsZGBAnfQAEUNFybYLStwQjFGtEakt/OCJ?=
 =?us-ascii?Q?YPKCPi23ZIsemu/2v5hjCXieaXW6qcoOr4lokHnA4WynSzb2ySU24w0H4p5k?=
 =?us-ascii?Q?GKBJC14HLaYm+lzmXP5bvsLpQQ1dX32m5Pvf2HzZqDOipQkEBTz5ZxszSO3I?=
 =?us-ascii?Q?HOiPmPt+RP88YA1VRimGTez7Fn8NpGX4PMnWSJzQUqdiV5Hl0UVpnbEHv5YB?=
 =?us-ascii?Q?rYUg0EJxBh5QPqkkYzIrb3TYpRAceDYImud4dIaqapIcI9xUQLvtfQa2VqBS?=
 =?us-ascii?Q?/K5QlkOwIX0CHgWhFLDgid1w2PlR1b9dUgAADwsPQtx57FIaDbeMHkZAF+VR?=
 =?us-ascii?Q?Uo8xOLjhh0H/hk4f7QWZYu8WpAiXT/CEnnULX5vKGA04DkREzXmcFEQctLuh?=
 =?us-ascii?Q?LYtuyJqzqcHGkgLpYPEZq/OB0OJyH23n4E9XpVubSkSSmAovOjDGNjWNUDMe?=
 =?us-ascii?Q?hOeEQHYlePiYlySoQaa+avMQrn+vgfw+hCAxqPKwLUoToLJQt0CDl/03FsZU?=
 =?us-ascii?Q?91d/dEspUhzO0/1SzKnAHc6okBhy2lE+osN0SQVRr+pywCZg/5mQqwsEdk0O?=
 =?us-ascii?Q?V9l7lWqnbIb/0+NQUDv/7HnuiXYu2Uovb/b/xAmc8guvSG76I5cLwkXBxkv2?=
 =?us-ascii?Q?+MMeiLCeAFD9JfT1o6I=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1b49b9b-8f5b-4bfb-c6ab-08dda1e01e08
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 14:16:50.7628
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ic/ErpztTWXjuGc/93fTs7HB7ZDpQQ9oEv/K2qR4TKc6ng2AlNGABT/smFl8P46oL1/qEM3d4e79mts+Mh4dOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7051

Convert nxp,lpc1850-dwmac.txt to yaml format.

Additional changes:
- compatible string add fallback as "nxp,lpc1850-dwmac", "snps,dwmac-3.611"
"snps,dwmac".
- add common interrupts, interrupt-names, clocks, clock-names, resets and
  reset-names properties.
- add ref snps,dwmac.yaml.
- add phy-mode in example to avoid dt_binding_check warning.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 .../bindings/net/nxp,lpc1850-dwmac.txt        | 20 -----
 .../bindings/net/nxp,lpc1850-dwmac.yaml       | 81 +++++++++++++++++++
 2 files changed, 81 insertions(+), 20 deletions(-)
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
index 0000000000000..c2bc0d80fabd7
--- /dev/null
+++ b/Documentation/devicetree/bindings/net/nxp,lpc1850-dwmac.yaml
@@ -0,0 +1,81 @@
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
+        phy-mode = "rgmii";
+    };
-- 
2.34.1



Return-Path: <netdev+bounces-242491-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BBDC90B08
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 03:58:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id A7BF54E1CC0
	for <lists+netdev@lfdr.de>; Fri, 28 Nov 2025 02:58:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 126F72857EF;
	Fri, 28 Nov 2025 02:58:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hAtDnu5o"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010020.outbound.protection.outlook.com [52.101.84.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D889E285419;
	Fri, 28 Nov 2025 02:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764298714; cv=fail; b=oO61+J69t1S9c97w8UwPpjqVu6Px5fAsXdJhccbQdN/2wT2bsqEXqJyaQGWMzMnv+tydvt/D3AviPq58jJWUv9gPIfRK2F1Z9QE99lQkhXWnmg52y84kSzXJvXazx/stnFa7nngVpLxbISPTwfmp6qZFxCzWs0sVs+rZr6L9uvw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764298714; c=relaxed/simple;
	bh=6PnLumvjC1B66to3J9ev+JON3JewMu5XBo7d4pBlRUk=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=IlZZvHS9t16wYw0j7OnYfFQ4M7m+T2DsRHoRQGePz1UNgEW0N9A+r3tupJJbG0oPzkS0Eb8X1I4UvnLVCz0s6aq57ucrtL1XfomiymjnSY4EVKgWqF1OMgZP8Q97UJS+5JySEAZ19Rb5dQU7wclsJGb20CWu/o57/zL1hz43QTs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hAtDnu5o; arc=fail smtp.client-ip=52.101.84.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rfSul1t7pZTZgGoQ8+mIz9CPFv7KIqy0dYm41Na+JFCE5yHvj5dCi/HgIoXsQW3GTNqfnPmGpbS6sHOgeHI5hk29yNzAXULzxzIVxl+gu6oy+OZW9FV9lh9sto+QtBYi4NlNq4x8PK9VIiXwERBVYGD+vzpjOnsay3yRP9abE5VZty5zR0NOzgnYItpZQFX6Edz9wGMBbBHrgc4K1lwAWkEeIs5NYIWcsd2qLkb162u+ORFQkezSuuq9w5H0XAM1TiXO2YPNy4Eq4xPu4bEcOBBllI0LNSzhGStxA0yPTvzIPu6IcurNzicbuyUIL5LUZpkYo7328gx7kTi1ZTLFYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bd0SSzn1GYHTgUA3cLZfihjp6dI2LWCzDMpOn2c6S2c=;
 b=m/YnToQkxEhnO5Kfchd+0szeLogmO/1T++inhL13h4Mfj5eBlhGJLdGI2FX3h4z6Q8S9RAN73DZoaNinotLAHZgDXNZcvxe7sX8s89a4QM76ePkIiGWELwPobDcqJS/wMnxPh7V9vxMvDvKgrwRVing/pSLE9KVslWPv5r7jUqEGAMcHKPQwaE5fE+bih6b9lFMKCdZI7YXszw+T8Ps4qJGd7QzwBo7XnimuuHD6RYkaZxgJhO+aal6plXLy8pWH8Oi0qsf5ppQgI8YYVmIScIkyzP46fklNWLqHrj7P09O7sodeogqwpU+6Zd6NC35N7rhanMPnGu+8gkyiz0vyqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bd0SSzn1GYHTgUA3cLZfihjp6dI2LWCzDMpOn2c6S2c=;
 b=hAtDnu5ooIJxqp6MYzF5raaLmw/EQzvNIPs2Bb2A59Nx5ePrZKKsI10ER5EVg06LmfX/TZRpBGCd7d13vurtcVu1dQZthBFpEpKGBbl9cAihWBwEzwvoP5xCHgXqugZ5joR3vSlExEsxd75k3L3WvVzWCQEX5f5C1356TdZ6Sc2nPrzlfPWpQJcXAh/TGtkzw1/P7mUvdwZbALFooE8V+JaRiW3hxaD/a0/k9wgSSmaMPruigr9dLedFf+W+fCEOAgBflrUdLwMd8zk9AxwwIPtOOFwqO/EpomxkEvnJuUPnAseWvFZJCPDS9NYG9TUxELM/xEoksv6jyGYWC8kWIg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM8PR04MB7300.eurprd04.prod.outlook.com (2603:10a6:20b:1c7::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.15; Fri, 28 Nov
 2025 02:58:28 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9366.012; Fri, 28 Nov 2025
 02:58:28 +0000
From: Wei Fang <wei.fang@nxp.com>
To: shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net: fec: ERR007885 Workaround for XDP TX path
Date: Fri, 28 Nov 2025 10:59:15 +0800
Message-Id: <20251128025915.2486943-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0088.apcprd03.prod.outlook.com
 (2603:1096:4:7c::16) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|AM8PR04MB7300:EE_
X-MS-Office365-Filtering-Correlation-Id: bd7eff41-e149-4a14-3be1-08de2e2a01d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|1800799024|366016|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fT15H59XcKFT3zJxrUiFNU1rYMmhQsq60CcVSMWTRTYjwqw33912n7lpRLk6?=
 =?us-ascii?Q?/RZeFYBWje1vA0R9rT/uZcboxMeI6WTaruApCA8ihvXv7lExjMS6U2PNgGIs?=
 =?us-ascii?Q?gGztMfOns2wfsYtkUnpue45VRw3+c75rvNr2r8qf56sHc6Pi6xdKjH8iXsBe?=
 =?us-ascii?Q?r2z2VntFEHjG1HgD0OhBHJzVsdqO7FxHzCIYJybF0LQ+l+Kr8pt/mmZKHzJ2?=
 =?us-ascii?Q?yYkfWKnqjc7HEHvSLru9r+CIXhQ2N9vbMTUZpKT2UXL5mmklBMlHJppxnezg?=
 =?us-ascii?Q?7NoBJH25Jw9CSwUep+X4JPnBZ1DE7ZLc9eQPCPZgreiWYlaYv5xlmFJSDjjB?=
 =?us-ascii?Q?kVwB/DR7d6BUPGsq+sXBoOfpFUAY95264pLdvo1dwQREHF5wdxjpBa8WPJ0e?=
 =?us-ascii?Q?2+H/vliSBsjX9Tpz+Z+Me4UAVMUvByyE3bmwoi7xK1Hid9KAP/u4qDNWJ159?=
 =?us-ascii?Q?71HOx2teCJe2q5bRgXblQggOz2zIy7FB2dhfdb4h3EMhgHJV2h5g46ywMpbU?=
 =?us-ascii?Q?AvAyki6L7Ku1yDAwRPtXDKt17DrOlt+KJ1jKb/8qucI797ryLNVUCm4mVJEJ?=
 =?us-ascii?Q?v4n48Hl62mLVhgtYC2EmyKwXlTYlo3PW6eABG5MpedlF7N5otPjSpuytXDni?=
 =?us-ascii?Q?UTjAqCGW2gXz2/jaTCvVPZkiSNx/2SD5M2gdNVCruLBDQev4B2TZ2mUZ40V2?=
 =?us-ascii?Q?j17itGIbcuzB7bItaMz2SeFluzzBOFdR3dQxeOWBYdVrjJM7Q8F0HcAOWfsu?=
 =?us-ascii?Q?FIzmKX5a8S85vbaGLnpsbmQqmfouc6Sf+kqM/ZQk+9/KNi9QzbZacmF3+r0v?=
 =?us-ascii?Q?Nd5VSDHrdoQd+X/JO6SShVDpdeLL96kODiub429224uP8+O9romCjuM+jqGv?=
 =?us-ascii?Q?8vRuNAV7e9JdZosNnOghJzLBIiMzHzcD+JubxX4WwjBy0SWDcwf710B9TCYb?=
 =?us-ascii?Q?9ps/ysATiXMg4UCyNV8gmMPkVzeDro7/D1ZL546JlW0KTSAGrPwp/fkaOybc?=
 =?us-ascii?Q?TjnYmaq+VrixURwXy8McSRUHJYeXACssbaN3HT6fv5wMwvcshqNHiiRnF/sU?=
 =?us-ascii?Q?1uJLSyL35kja3v2zeY21gn6rLEuk6OldrxHgO2FOWHw0eXwOQ+OE1c9Enalw?=
 =?us-ascii?Q?9C1g9x8PzUHdww+khGOsI8RLvdXCiRk9gJ3Kvq+go8YTliexHqyDXEnHS/Lf?=
 =?us-ascii?Q?wUZQkdV71vIvzp1dPg42t3Zk8hp4sHcBc2Hl0V0sweTb1Gm80broaRzep6Dq?=
 =?us-ascii?Q?5K2HlhVY2MwGHDNBwIt1chc6FbNTUiyjaCFEZG4Zzi9SGTHlEQGh7Ful2mV3?=
 =?us-ascii?Q?kmHUuHEI8toEzf4iwBI2owRIVJL07u0hn6EZxp7PKTKdwmJuJ4DnFwcwsUeU?=
 =?us-ascii?Q?KaLqL1ZOpXmZMqklQBqFHdfYRbn9PD5jYjoXskENz0gtcax8xoTlL0ESJm3I?=
 =?us-ascii?Q?Sl+z1kJnAnE/Uc3X7skCzXVMWZekPWJ2Ku6oyCicuPr5p1rcfqoMUtoThc/i?=
 =?us-ascii?Q?oQpM/znplHhBdRY4qUULOYUF04eVloneCZYI?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8XLs6nTsxIxk9XPkkmZKSzDDDbIQgnTHS6tVWZEpVWVVxRafcEumfQzxKGwI?=
 =?us-ascii?Q?Ohe1bl20TNiC8gXrmFFtVZIRo8snwhUGftwo8lGUUtDNnC+dWSaKqKzM4Rjd?=
 =?us-ascii?Q?EcHanCu503RkNydCbrCXx0dk5s11uytS1uQkIydIUwIkMwwsGgqXUbDVDaty?=
 =?us-ascii?Q?CuDPTkOgLyW+erwWSbJsT49WyEbC3mYiyolbgulO2aBSkvwK4krWFA710zZO?=
 =?us-ascii?Q?3or3Ex5bqk33N7ZrlJ71I0G1QNv1TVx/8EezsHHG2bY76LXpz+iSuSqHnhdi?=
 =?us-ascii?Q?/xsP1OouscMFEpWQx5Bc97Ijtp7jklkTaVnNsA1zIin7Y3FqwXEicsbRjP/F?=
 =?us-ascii?Q?JzuIPEwhLmoZBkaBUr+I+Djt0Z3Dv4SGjLqRKhs48jnU7cAmS/kotIkwI08E?=
 =?us-ascii?Q?X9WCnbeQir6DCQxNWeO5ZnJZ2P6E4tMh8DFpq318ADmeZoNAoaR46lVDv/Ys?=
 =?us-ascii?Q?AKufPaTG9EvWC40RRv6PRdlOe+D4VF6otECe6LhKHIFILbunHOg1o3yAWS2X?=
 =?us-ascii?Q?bjR0Xf2Hqij6ALTIECaN9lkxxTp/2RGOxFdFQCgrSsfN0FwRuzIC56RqC6da?=
 =?us-ascii?Q?KT6QT+9Rot3QcxqVAhOv0XhFi1RPAoq3PHW6RFzYsiMBcnHdspxg/Plme1cA?=
 =?us-ascii?Q?3VykazP/KgH7JT7MHYGNbIySuxXGrIKkira/KeNr/YPZwHd4FHfHrlhroD4W?=
 =?us-ascii?Q?M7PdUaPU3AIYcvRoiiUWhjxBnXAcOQambTQ3iE07hGL5XMGr+qoX3ci0PV8S?=
 =?us-ascii?Q?ZAqnXnCpk7MAyXD5rv+ZZMQ8b7wfHV9Qm8iS0SltxPryxyXgvqxAp0ijqjkM?=
 =?us-ascii?Q?LRh6R7241zSFYNISWattH9cXWGs5pN9aez5i7eVJyjOlKcp+dtS8KkerdTuT?=
 =?us-ascii?Q?oHd4MtjTnkNOPSJ/JAokda7RCLDY70emFS1g1ogeB5GvpMKIxxq9/i+lX0pZ?=
 =?us-ascii?Q?1p3KaiNKiFpr0SZaCLSfEFIchfWVeU65i53GrGeTTLq9kMN+2ohH8ZIceLuw?=
 =?us-ascii?Q?kVfWnSSjnro4uuHVaHssyyoycRa+1Gi2u40r5y/vh9fskamRVMMLLwHPsMwl?=
 =?us-ascii?Q?zT8YEeIW9kBmYoj/n/FQ7q++0RfwQzwrJBtMmkkDZkMIJGDt9daYGtNS5sL9?=
 =?us-ascii?Q?lNcG1vN9vY+Jhx8VY2MUo0+Hhu4V9+Mtw1i2Lbw03SiLY1iYObMcV6PCstae?=
 =?us-ascii?Q?Ae/QIm/YiFjVEXq6/sh6IG5dD6ViK23IquTzdbux0Rus4vtEp5FJDKmzUKBw?=
 =?us-ascii?Q?q8Ml3t70gUJyca/Q3S18c9p/kkd3WeBt4eM3Xwkbmj2Fa6xJiP3wBcKsk8RM?=
 =?us-ascii?Q?H1zQSudB+u0ehxB2hZIJP3fPorjEZvmsNjEVfRK7exr8Vg8z46Fm2blH+xPs?=
 =?us-ascii?Q?dwRSr/lwN+XPUDmn1cxS/wGIf27k+F/CJ/CZSF8/qN9iCBXJWWJwJ9glQjc4?=
 =?us-ascii?Q?3vXpORHvndKx9lhqHBPIS7CFnIu1br4gEuJqsGFLIN1wbJKSk805FTrz1kJv?=
 =?us-ascii?Q?JNHG7rVuuJ+9zxbg2Uvs+wyZ16P/PJyU8b+5Xf0IjPMY3TXJwhyO1kJTeen1?=
 =?us-ascii?Q?7gO8rPAnakMWIfuWJL5Servs0b3MV0uDz2HgBVHp?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd7eff41-e149-4a14-3be1-08de2e2a01d3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2025 02:58:28.8770
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tzC5UaZxIAzjUkioMlj1g+s05waSeySs/ex67JgHUihZMhODkk1jgKjDLN9BdZTk0Bo0HVnvAR9aksRtTXYB9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7300

The ERR007885 will lead to a TDAR race condition for mutliQ when the
driver sets TDAR and the UDMA clears TDAR simultaneously or in a small
window (2-4 cycles). And it will cause the udma_tx and udma_tx_arbiter
state machines to hang. Therefore, the commit 53bb20d1faba ("net: fec:
add variable reg_desc_active to speed things up") and the commit
a179aad12bad ("net: fec: ERR007885 Workaround for conventional TX") have
added the workaround to fix the potential issue for the conventional TX
path. Similarly, the XDP TX path should also have the potential hang
issue, so add the workaround for XDP TX path.

Fixes: 6d6b39f180b8 ("net: fec: add initial XDP support")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 3222359ac15b..e2b75d1970ae 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3948,7 +3948,12 @@ static int fec_enet_txq_xmit_frame(struct fec_enet_private *fep,
 	txq->bd.cur = bdp;
 
 	/* Trigger transmission start */
-	writel(0, txq->bd.reg_desc_active);
+	if (!(fep->quirks & FEC_QUIRK_ERR007885) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active) ||
+	    !readl(txq->bd.reg_desc_active))
+		writel(0, txq->bd.reg_desc_active);
 
 	return 0;
 }
-- 
2.34.1



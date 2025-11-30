Return-Path: <netdev+bounces-242805-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D2350C95008
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 14:18:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0DBD24E11AB
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 13:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A0DD28468E;
	Sun, 30 Nov 2025 13:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="n6fCnvEX"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010043.outbound.protection.outlook.com [52.101.84.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 483302836A6
	for <netdev@vger.kernel.org>; Sun, 30 Nov 2025 13:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764508669; cv=fail; b=a0TQe0snmaCZTBIqDlpFRIf/na3ikTm7mleCw6P28uhUIvmLmInnDioKP389tsJ+bQNCi/xdFqNMYDk5jzxiki/0RlKGS839LG6cINu+QmfiSHoxDOD9/reDDITII+MHvDwlwhxZFlZphtBsA7wflkQmTgnOVToG/2LcrlU9CrQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764508669; c=relaxed/simple;
	bh=gFe1mWO3pcjOTrJIqB9OlydQZ9h9+IU+SsIvceE964Q=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=bmMIs9wFnFNIBUVIXCyDyPr3fvNPGeabHQt8biPqz7PRxIYZ0Nh8ubFHP061KsfudFNaqKtrrbTGVw4zziaBX+1dfllhlonkX3V3rEg3Bu+Tx8RYb30MEioHonmOMBXLy99IIqLtTnEVAk+a7wVzFGur3Sk0oQXARp2Nuz7CAOE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=n6fCnvEX; arc=fail smtp.client-ip=52.101.84.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/ihQr1C+5cj1FURGfAVB0dINUB0XLEP7sKiMfW6u1Ff5zKS0892OQ5WtFxb8PL0A/JhuhxtaFr5VXkwZkdQ+miWF4RfTfjxDBc7qr95S2utWvs1Hb+9IT/9D/XlRfRoCgbLiXWl6jZ/G0IzQDTPe7jPbBNgZ9B8mZ2PyTBg7a68EEM3Bkl0tjMYKQrbEf5o+iD5UEaqyn7TDtwTwSDjh6s49waisUNjbXzmnkx3Pkf6JFj9WlnSoSv/TGdUoKPxJw30Y8btN9ZX2hNuiiniA0BZzg3+g0nXzEwkDdBPNHDluww21ldTQBqGPBAJOI4iX5NkIC/swJ8i/i4zXhn96g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m5AlvRwNs04QGRvcCDhS4c+VafJpS5Yldr9fFX1dJsU=;
 b=nTxBLYsEdu/V+8yFcf+grLpaFlV87l/dAkhe+kQQtzOD/GFB/5JskRnv5gbPx0J9UTZU4jvAwX2EIBbwbkKEoxWte9FcB8PCBAICCqdrxnMJ+19shabx3n8UzkKJ4n+yXaZpjIa02XL1VPV5dcml18pnRWf+SP7DSoVgDP6R8WUfPyLLwW3OVR8WmR9fL53Aow3TzUEWu7eYnlltCR54oqAKhEiMieSFLMshFqFZYOhlQI/k9NXpUCy0ogqHQVSih5+rmOCcH4CgOSjyv3bzUvUsvO16gClP9G4xn27TNBUGrgrjGwWwdLu92NuXSdY88TKE5z+9jOfCKMC+Ceykgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m5AlvRwNs04QGRvcCDhS4c+VafJpS5Yldr9fFX1dJsU=;
 b=n6fCnvEXUfP3NHdR96D05lzDq8UmJVJJxWuMBMmGsfakPKFDsju49EmlByuF/qH5hmoJGkaJHf7dgHXJ5SvaJOIt08dt5rX2J2UcMre4d1B/IeGsssvRNBKOx52cwCpVRhcT0Kue2uKBNPuLq0GxB4HWBHxyTmtcr7HcNT91MaD14WrQFyIsqxThYJ+QpqdWtJAgYzUB+HwMyaRBukNzg6CCfIo66YhyBzTnee0LCFC/6nEo0SU7PRk13cV0td214sTe93RfFHa51bFm8ueiylEcCcb6Mb57qRyioM5uQSUwrmanx8YOxAONNagkLqywPNQkiU535mxO60vulLapjA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com (2603:10a6:20b:438::13)
 by AM0PR04MB12034.eurprd04.prod.outlook.com (2603:10a6:20b:743::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9366.17; Sun, 30 Nov
 2025 13:17:37 +0000
Received: from AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab]) by AM9PR04MB8585.eurprd04.prod.outlook.com
 ([fe80::8063:666f:9a2e:1dab%5]) with mapi id 15.20.9366.012; Sun, 30 Nov 2025
 13:17:37 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>
Subject: [PATCH net-next 10/15] net: dsa: mv88e6060: use simple HSR offload helpers
Date: Sun, 30 Nov 2025 15:16:52 +0200
Message-Id: <20251130131657.65080-11-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251130131657.65080-1-vladimir.oltean@nxp.com>
References: <20251130131657.65080-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR06CA0128.eurprd06.prod.outlook.com
 (2603:10a6:803:a0::21) To AM9PR04MB8585.eurprd04.prod.outlook.com
 (2603:10a6:20b:438::13)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8585:EE_|AM0PR04MB12034:EE_
X-MS-Office365-Filtering-Correlation-Id: a71d2543-f2f3-4071-315e-08de3012d4e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|52116014|376014|1800799024|19092799006|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?OBaUBYfb6oT50dQ9oLi5kKALeIgBzPVhi2AYnnWuo6GhqDotPqEquD/83HVO?=
 =?us-ascii?Q?bpoC4jFPFj6Gkpzak0jzrtFPozf+wBIlntvhoqMnQhM0zjLvi37gBZf7BLoH?=
 =?us-ascii?Q?TH+z85eqkEdcDnvRKKQMeVGeBw/1fBS8NeG7kGDkHCUMQ+HKpExUEn2skpXl?=
 =?us-ascii?Q?lH/sxJM4CiFVztWXFdW0u1I+4gIb2b04fMeL3qWkt9UkLSKETJhxdf+bgfLn?=
 =?us-ascii?Q?l3f+LoSuhNNBBUcoFc/I3kz8OHGFXq1rAbfxmq43H+JIxSTZQ6booig2zniL?=
 =?us-ascii?Q?y0pBeUwqRfhwzNdkLv1GQ4wNXNhujZUdl7OtUgXr/Sroy29of4e7KiEKEcz+?=
 =?us-ascii?Q?239yeUhpMow1hG3PO9IAGFSdRcGcOYwqrXOu1bTlGYlxx+SOkG8gfznqZf6v?=
 =?us-ascii?Q?qcCh8Q+gG+97nP/X6axcd9rYEdEEI3EDvT/jioiCCJisirz+5NK+aOm6uSA6?=
 =?us-ascii?Q?03AenV4NSAiRF73r2SvYPdRX6b3lQp+prGgETUVXUuPSJ/RGfVLq2YvyCNqe?=
 =?us-ascii?Q?VeG8v7/Wr314loeDYuDjQs4goIvuHootKxu3g7q1YLzpn65SYl8GedkhGUfG?=
 =?us-ascii?Q?UiEZZg+bEga+W/CXnjsB4SONEYbtXjosUij5NmV/dVxXuaawdqYIcySctfkj?=
 =?us-ascii?Q?ch+jFjMUSQoN6lLXxQnV+qiUZSKl7YK5u73kp9vQOzBkGDSAZGn4nELAFd6m?=
 =?us-ascii?Q?qP6Vw0u+7nO65FxCXmyE0N9w80iLBaYVhyvARUA3X2cJ8x0yTXhS2bn4JeqV?=
 =?us-ascii?Q?rP/TNpxjyFMczr507vtY6P8CgrfuWgRDafnXVOkWbtiPbzJSB2iylRw6F3FN?=
 =?us-ascii?Q?KoFDkm8dxsY5lDn2eupFUFIcAKz7OVVeIzXH46Ifio3niQhwWIhA+t/k1UKL?=
 =?us-ascii?Q?vPruspe7bq7VTjRcGJ68IuVMtL/U1O7YAZzsAOQHT2Y7IvziyYUMzNrfOhbq?=
 =?us-ascii?Q?v6eGxAODxPWhCrmiEBcaYN0TbXsz1wDJdfaAVF1zJWHHPS1q3SS8jU84OdRr?=
 =?us-ascii?Q?b+dSQP7T+oxoNaLam//244QqjgnPqmZ/1PXPg2fpn5qo52Vi55wiujtFAQnx?=
 =?us-ascii?Q?Hsnrw01cHKJ9JlF4mBpjOwFaUpxm5ze7ztzp+Ma7qg3JI1eVB00sz/M9+7KK?=
 =?us-ascii?Q?9y2KI4gqVtQkslESBXlyAnMHnAw7nzvZISmU8M1TVyK1GCxdOBlzvLibNknz?=
 =?us-ascii?Q?ExAhcg4qHgiPptD0BQqP9WnSGY9fSRQi9Bgg98ll28m4QH09rHyiycMi9UR3?=
 =?us-ascii?Q?93YV45hJmD7YuC+3H9DB9UAVybB5/I5fPl1CVaRp1Xa8/Z2ztEIAZbMavt/H?=
 =?us-ascii?Q?7Mx0p6pIcFE2chq8efjkIIarVgcExWbJkt5/WYABL/IVgcY/Baxi/LGdI/Um?=
 =?us-ascii?Q?1M4YzxoukqaxF8s/hPtfCjpQasAOFqN82tZ81gebMvXuEWHiuitTgx15k+sj?=
 =?us-ascii?Q?dRd59ONyjNR+WCM/u65bkZI0e2OAk2lbILQCwMfJzV2xZZWXLmrvUdfSlDBm?=
 =?us-ascii?Q?3i6RR0+FXuM59gI5cI20cPVS/Hgh2fQZNYHh?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8585.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(52116014)(376014)(1800799024)(19092799006)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?F8UcBxgduaKXeCI0E/5cVLiP9caLgZyvB2vOGHCl2sK5mUq6tgfpL8ltVejJ?=
 =?us-ascii?Q?TuI3PZ8LDLzvLXB9DZSJBPFaLb5eGBtqFs+3xOBaCk51MkxQlDr41jImry4d?=
 =?us-ascii?Q?Yvjsx8feq51FpQzUBV17YDkcZBUSMS5ubE9VIlDzL+5Cb0hIpJPfvSl0c+y3?=
 =?us-ascii?Q?J965i1pLhFLrwZOdx8jyq6SkR1+RaLkI7CmdGEQobalU19R3x5fzxSzrukvr?=
 =?us-ascii?Q?2DFsPRaGSjyvZiCPMne96Dqk/fRWP0ZSh30BUR7sqSz9KHqj1m3IB9fs5XmR?=
 =?us-ascii?Q?yei15xmgduSAPoK+lflM10DljMtKkWSYt4jHZW3Q/gV6cVoHBirN2gAbXI1I?=
 =?us-ascii?Q?vEVxucxLHMfxtCeycnC2vjrWg7FH7KEh01SLJcw54KQVwufYDzeTGoBuBJOT?=
 =?us-ascii?Q?IMVX/BQXgHnJX8eusesW0CK6bsF7RIq5cBMj0ZzaTqGVXFBJhgk5sUJ+bGBO?=
 =?us-ascii?Q?Rk3MvH2YLthF/E6I+uuuOD2J8NdXRWYsDQbObivDYQfxYqOMOYAU9+j4UJQb?=
 =?us-ascii?Q?l4CUI6vhsXG5sRt59FpB4LvL+iUNPT2PLkQjzTMRuSKRD2kWLVF0Gz17vTC3?=
 =?us-ascii?Q?X3cDzxBCfv+pan5SobtKdrTUF4PXtIxCJwd0zARbeFE5n5zmaaUlrrQgWNwK?=
 =?us-ascii?Q?GihoO+JWs/akHcxOZbfCrRAHBqShMuTCFOIn141WYA05G0zR1t1Q8io/nLBn?=
 =?us-ascii?Q?ETXDyjgmJSMNr5i1eXo6d3svDssEnWyU6GKjLChdQ2hx/0yZ236Qg+k/tFTE?=
 =?us-ascii?Q?hRCkI7tTGFVqzd9K84TWsKTi4vfQekwXUV3NUBcXZUWyGEYk0RPWAo5SZG0c?=
 =?us-ascii?Q?VBFnzW41OfKTun5obuie9OzwXBQGMoMb5qTW7Qx5VqvfkhtuAlgCL3V49Wi7?=
 =?us-ascii?Q?/Yj6W7DEn/JaReWSmOXjjGa0NZdbDDjLMfc7M5L8iLjXugHF1OQZXOVdC8LG?=
 =?us-ascii?Q?fZEN7JM/18ItfjAHC16RnzGB2QvuXry/uwfJn4mfpSx/ae7DKJ+/i8Cv1u6u?=
 =?us-ascii?Q?wU8xTOSlcMzT687FcVwpAzLOhfbHh63eOOrgjNUe9VxaKbBPXWkmzo71xcmj?=
 =?us-ascii?Q?G6GvZrOBKo0mr5PaAmb4Y2VL1Ex1W1amQUCxVYtS8uWKJgCzdvPv2aHmq8iJ?=
 =?us-ascii?Q?uR7vqRow9L2vZcO1yw9HxTmRXwfwFqWVSXlh6eWmxNeHjY/ttmwdpf8NfqAr?=
 =?us-ascii?Q?1OxEazVN+H+Lhkb6v2Cn1tUdjbtB+2UvLlYXYelph0Ytug92jcqDQ+xzSR64?=
 =?us-ascii?Q?AlrjrkIpXvcH1G+HZu0obOpPzA4IHCnuXaUiPA4KnIb5lV+mvIFzECwnRHpt?=
 =?us-ascii?Q?lCwn9S4fuy69GWs8Q1YGHPX1pB4MxT6XrvW661kXHJdhmhGD2Hbk5sYK4150?=
 =?us-ascii?Q?h2FzbwKgsPGvDbwA6Zzhl8kyyEFjbz/oSV4ghAdjTUpSLO6fwkgZqQW6vhBm?=
 =?us-ascii?Q?GTlu3kBMBaEdIlztfac4C+R1VyBkQ9NdhyLPbsUqpVXbS9IfZ4tcquhDlm4O?=
 =?us-ascii?Q?0kEoKBw6pDQ75nWKb1Dvf9+fYi5pspyFebft06onZdmT+xQzlE8VmIYLj3jL?=
 =?us-ascii?Q?sMBR/LCdz4cVvFRJg2biy6wk95Ao5vrzTrZXOtbMqDaEyFxg2b1R+eqzheer?=
 =?us-ascii?Q?VQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a71d2543-f2f3-4071-315e-08de3012d4e6
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8585.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Nov 2025 13:17:37.4375
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YmoPl3pTBS4QN9PJG+XDI/ZMFyYN7MLiVB1pXcAH8VI6Lu1W5zoXvRqrRAGiHVgxzFVFy20qA1DGZ4tIrrL+3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB12034

The "trailer" tagging protocol uses dsa_xmit_port_mask(), which means we
can offload HSR packet duplication on transmit. Enable that feature.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/mv88e6060.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/dsa/mv88e6060.c b/drivers/net/dsa/mv88e6060.c
index 294312b58e4f..9c8ac14cd4f5 100644
--- a/drivers/net/dsa/mv88e6060.c
+++ b/drivers/net/dsa/mv88e6060.c
@@ -297,6 +297,8 @@ static const struct dsa_switch_ops mv88e6060_switch_ops = {
 	.phy_read	= mv88e6060_phy_read,
 	.phy_write	= mv88e6060_phy_write,
 	.phylink_get_caps = mv88e6060_phylink_get_caps,
+	.port_hsr_join	= dsa_port_simple_hsr_join,
+	.port_hsr_leave	= dsa_port_simple_hsr_leave,
 };
 
 static int mv88e6060_probe(struct mdio_device *mdiodev)
-- 
2.34.1



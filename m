Return-Path: <netdev+bounces-186398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 66831A9EEDF
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 13:20:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1328917DBDC
	for <lists+netdev@lfdr.de>; Mon, 28 Apr 2025 11:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF4226A1DB;
	Mon, 28 Apr 2025 11:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="cnrn3zLQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2081.outbound.protection.outlook.com [40.107.21.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B359526A1BD;
	Mon, 28 Apr 2025 11:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745839026; cv=fail; b=Llu3UPax5bHRofZPl9hufX6TIFXmJ2agYNXFIoXNN8x8aKG2w8NEJSNiQbKRQZgAZL99+bIjLKADd1sk60Bg8V1rJIBD8+tFqhdVM2CYJ1b4D5+w7RYmIuTAxIh5py2nY30aFiB1JGM28ZbbpCOvm279p1Sffp5y1X9T+5c7EOo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745839026; c=relaxed/simple;
	bh=9wPZ4h5jCGLKYVO0lXL3xXTkqE9RcvKWCc80vc294S4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZkyvgsoPWro5WbDZltq/XY1TYcxzQUivsHA+wHDvik0Rjdh2SWvsBs0r/8sZ23TmAHSWJZd2722ghIAWWZc9BxkIGCvdab2k3gizDMIWjbTKbrZ27YZ+fPx1QhGoeiZClKiQM2NXk0hOP/3L8zV5xH5v2/dM+hfBNQSPPRbIp1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=cnrn3zLQ; arc=fail smtp.client-ip=40.107.21.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cUr+nLd+k/4dsHrNBCfrvrJW5wwgPZagxA6gNZpqRXvLFIWAIhPGrIl7UeO0PUFv61KcXQybBX20QTVeXGomNqG+zBqhVHHoqyVqLaXjug6MHKyXKBzt2rHzKChzRs3pi1iofr0BjraGLX5cjw+grNNYL+JZowudGFLYB/R/Qz+RLdH6WTK85UXhZCdz1yVKa8lxmH6bGrcODuALOSkAh95IBhKKZSptyruTUZv4jqmhPFbIA4PminrvSRkoLguKk9xfkjv+81Vi18LPcP1DZy/lnI0+tr3nvksN0K/9oU06A7L6OZQwvUZNOWaX57PiD3OjZ82B6JqyrpyAdzi5cw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s9/5NgNm4Af4KuRlT0NklOYF8M0AptqEsRDnGRFnGUY=;
 b=NjQnoBcwY4ZKno0nxBDsHFRxhB6C3fp6r9Brv64OoCZNUf7FrUWPbjBydUq0B7AdnJgGlG0YuAMZA1ZOeIfwtjZp8qCIIpENMx8h7f7xVHUHzSf9s4e5ePfOlkL/xo15DDXua+DSjW3FR988kBQdeaONRl1P1RY9xl6s5TO/OWTUTzqSMR6j55rw/1mRisfa9o9vV+/OirIVivoBzBFHZjyUnGz5v1oxKFVnBazbIKVDONoZKGPkrGgaUFN27x1syz5jOxKNsX0e7ff3+Fc7f1oiGFyEqVHKJEVk5KrM5QbMeHwzVSND4zhlR2UYqwGJEx5KpRyBVzuUO0Jc5QzFEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s9/5NgNm4Af4KuRlT0NklOYF8M0AptqEsRDnGRFnGUY=;
 b=cnrn3zLQ9eg0z4y4RnLW6ccS7djh/8Fdhet2Y2BgZdrrDRqZB0n5TGWpptrb2sQdio17kqAhfEQFj6Bk3JDNFbzAvupGqnRu5uVKxS/9YXf9p2wKSpIBuqz58QbaPClnYHasYXTs/5F7RR1k3K5DNwXGGknQ/owQ6kOTLRScVf/kJcpw+D0I2+xEh6deqT9csGPOIuLPlGTjQudAIPO+H7HMnWXuSxRDkvJPq7E5fl/0AxxF9BMxIYUrMHc014+C6o2vhRMHlOiWoMVyuB8IwH9NZ7ywtsS5jKHZ5buQdaeto7Na+tlBbBLPVOr2Ah1lmJI5LN0IJk8rR1mNWCRshA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA1PR04MB10360.eurprd04.prod.outlook.com (2603:10a6:102:44c::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Mon, 28 Apr
 2025 11:17:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.8678.025; Mon, 28 Apr 2025
 11:17:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: christophe.leroy@csgroup.eu,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH v6 net-next 14/14] net: enetc: add loopback support for i.MX95 ENETC PF
Date: Mon, 28 Apr 2025 18:56:57 +0800
Message-Id: <20250428105657.3283130-15-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250428105657.3283130-1-wei.fang@nxp.com>
References: <20250428105657.3283130-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2P153CA0019.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::6)
 To PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA1PR04MB10360:EE_
X-MS-Office365-Filtering-Correlation-Id: d98c971e-81df-4f5d-d59f-08dd86463306
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|366016|1800799024|376014|7416014|52116014|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?qo6qAHyO7ElO6w/3vhoWBhb/sVgl+9Ufs4yNw+AZNsn+sRAxsa++GeFm01mF?=
 =?us-ascii?Q?2qpOViqbIIkOBF4FSwcPUdoqCBnFBny+2k+Dr7EaX4vIfHUg4C4OAXgY5500?=
 =?us-ascii?Q?jZpuwA51SK7Sw3/0QxNpi31tWimrQMySVVE3WP2UU36lhe6Jfr9P3T7OZ+iM?=
 =?us-ascii?Q?KJaRsQwzLPlf1neVObJmHSywAvn9HcaS0UVV2QpoWycsADPP1aR5WmLQgm5Q?=
 =?us-ascii?Q?lygX+1R/wDb8Py6nVQyGt2xNPWlG+smN0Ps/VckjEPOet7YqDOc4KilWKdKq?=
 =?us-ascii?Q?+cqUCnt3Rh2X5qDtc2x2FyGbX5RVRfUQcBm/810oki0TcD00pnnmSzZOG4sD?=
 =?us-ascii?Q?e2XfPySfhwnga0CUdwwZY/nz7tNqPaVkzl7eesM8cLepOssMpcU8xrGDJQLW?=
 =?us-ascii?Q?N79c41t8eI2bssZIwPoOkyTi/UDsvNxf/EF8R3AYl30iZftofJafcCAAX49h?=
 =?us-ascii?Q?TekFGLPfYk8EFP4jHNy2D835Gl8fy4jGTvMuBpIRgo8ObSBp8M+K9zQDRdxR?=
 =?us-ascii?Q?+cJR2BbXH4L2Ksfel/A77qT2b+ybxB9c+o3eZL3X8m+LmF6IRKBkybOdyThq?=
 =?us-ascii?Q?7+mRDeu+//Nup9APwL8WcTESmpZMfrCT6hkr8N/uVNWJ0RkBaGLCqw8j++kU?=
 =?us-ascii?Q?rk2vm8pZTWBwlJ7qwAEwrG4zYDCMf6Nu+LdfexfgKLouq0gDHmpSVwVQqzZ8?=
 =?us-ascii?Q?Wd+QuO64lwCihUYj0a6uVEGMvvfkDYSMxyWisKpm0FReCesU5k1bIyJDIQ1H?=
 =?us-ascii?Q?shnILWt1sdFYGOF+8ZOx93aIDlrMTJvM/cDBE5DwX7dtRCwUWqHAd0kkAFwr?=
 =?us-ascii?Q?a0rg1ejDTBdL+Icx0J6c2EwTi44Fld49+VP6zooZ7PriAilnpkag2AM7xGGp?=
 =?us-ascii?Q?FgJ/u2w5YJPiZqtHOQPdUQ9JW98fPdH6+56nhbnvH2vC3b71xU+I0ZqtpXdv?=
 =?us-ascii?Q?oesJuLtvzwaNcdzp8yOySRn4S78xqUCELXNHdlI4ZQlqnljbbnH118a8xhcQ?=
 =?us-ascii?Q?eYl5zc/sTVGhphuW7hyvmbeqyEtXPi4uno/9Z31R0ZRP1mD4VXj5JL2YjYZi?=
 =?us-ascii?Q?97fBld8mmmv+BxN+gSg5dzIq+V3ufaX5pWCYGW18hZbHgWrUDwI0pN6kNpWX?=
 =?us-ascii?Q?1p6ffMjTGYfjb4qaxIVyv5SQIeBfG/xNfxNkLLk360hsHs1ZQquPM1eINn2S?=
 =?us-ascii?Q?OutWbAXugrFPjMFRVyvLujsL9xAOehzWBT7QrbTzbtPIQco9rlSqc3NgPkQ5?=
 =?us-ascii?Q?Q5TvmW9zRkKMS0Kd/JdiPY0U0xdu2kXl9n5Msqn0t5SPC2acTMJlx2JzGEe8?=
 =?us-ascii?Q?G1kYWNyIQaRaUOjrVJxa5ehnBZ53I38FAyc6UgfxTzWdmYkX1fz3LHCqMR7U?=
 =?us-ascii?Q?pVKVDGn+CxjuQJxxEV2LCFJGfHtUCdizAfEIy4wktHa9NpfY7gkHl7eb6TjZ?=
 =?us-ascii?Q?SuaT5p5hbtX8inMjXc+3y3DweGu+HLnc+feB3J73KQ/Q50DgvQxsfg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(52116014)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hamwYKdDdVi1NaeaF8w5u/nahYjUpKij5WinmQR+qu7t5Ty+zQ4DjjwJuupL?=
 =?us-ascii?Q?v+oprhy9jQKmkQuFyTZzeAvgU9tIEZNa897CbjFVid3mb+k5uJfykIZvjqyr?=
 =?us-ascii?Q?3PkyiQJMZyCOZM21ad6bEksAmZ4Tnfa6dt+Dr1eS2Mha4JnetLIEUu0TQt20?=
 =?us-ascii?Q?lsgXpbz6PxuUBnJYIDhtiKY8IanLEOyh804vFYFFaROsZt+Pd9PzwjRNFiiD?=
 =?us-ascii?Q?CvoFZgrCSN11NU6mSSnRm1XU8PBxDU6h/NIgjXBLemlGRjtFwgK72eNyXDxi?=
 =?us-ascii?Q?kzPbpEWKd9iO9DpnIGmPEU65D89ICEXi3pT/4PIRnNyLEJF76C8hX7xkdX/j?=
 =?us-ascii?Q?/znr2t/e4WkDu0XN1ihYFRUsBRUiwjvIIMgQYSe29d0F+Jf6prNrX8je9Q1z?=
 =?us-ascii?Q?mF04kREKFHLVzSZadKy9pUYVZkoEBHm4JpPmW4ONA+eNA37tnCR00iWnGLGO?=
 =?us-ascii?Q?GUVd3b1AQeBv7NNaY9Lo+nSZmdq88KVqmpD/M7YCS2x9PmB6Bs473WC1elda?=
 =?us-ascii?Q?1qQBHsk+iMh3tXia1+Hxi/i5arIRJFCQlAaGjVVxdto31h+OY1CF7xvglQ5c?=
 =?us-ascii?Q?705ycM/4M5c+xwbuTXUpUZ4HbSJOV4I8e3okvJxhQ6/C3UJSaIwY2sv16eUi?=
 =?us-ascii?Q?c6Qilb1LR+0w/mAtZ/TGBOvSwqQYeFHPa4GRgoJBcpXHX7WHyrvYCfsYlRVs?=
 =?us-ascii?Q?RinqQteeX1quRNdXJH7jrhdXNj9jvvUUxFauD2pCQjWyWcm6eFuU9ROCCLNH?=
 =?us-ascii?Q?uRe+YeYB6WGJ273azoBy6Y0r/v5K3cHKOr1ikOBJJt0IqCa737oY+lkUvFFZ?=
 =?us-ascii?Q?/XZLxFmvqoHnQKILUfEraYJGpk/fQWCb+7ujEVBh+v8FSZ9eUxUfGYsiM/tJ?=
 =?us-ascii?Q?YV1rfBkErmJ7vNeCgUc3dBxn4R72nP/0ujRg4gWuvyoyJ3Aoq5Ak7EjI3JQt?=
 =?us-ascii?Q?MeYM2p8BvaF2ISavXgxhJMfvVyoJ/fwlDq91Aq8BWa0hgHhS0UFREvMxGE9q?=
 =?us-ascii?Q?0uh7i3pRDudr2P80HimkgFkPZRUDCrDt2mdRax/sSTyg4SYI3dgZt/kKh7F8?=
 =?us-ascii?Q?NIAeRxkGz+bDV2Optew9UgNGcFSj8vJCssJ9hkeSyM2hXsGKjX7MBw1qBk5C?=
 =?us-ascii?Q?frJC8kTHXTaZzVPrngbuomrpavqg0LCw7kLyKvc1QnMrkgFmW0jltAQTnWi8?=
 =?us-ascii?Q?m0MM1gfl7GXGs5jY+7fPEISYbxn8Y2bkV1rlX6BBD9Nr1x4dWQnDs1dVJdPM?=
 =?us-ascii?Q?10LTn4eA5NkGqRzUkcloOJCa5u0O8cwgWD53DGJXYl0pCFIj+PkiAac5BDok?=
 =?us-ascii?Q?X3fh/7GQbewSLWTVzeBQTLAQeLLP4gAYF1/CyO3203DpKdzgh6J4yBnptc7C?=
 =?us-ascii?Q?HOyiLa0IL4tLqil+cTtmFDXRCttis3Ns8W5Vt42e+isdJAjcO9ZIce2vEFPa?=
 =?us-ascii?Q?3ccVrEM4gEXnaV5Ww/HIObPkcE5VnDAy3mslpgDKCjCiom5RFBq6ZEgMB6Gw?=
 =?us-ascii?Q?GKYwsIbOsQi/L55+fS5Qx7IJ2t+9ClAhQFsG+1JTqTsq1fTyYFuVUkPDETb4?=
 =?us-ascii?Q?JwCja2a9UOu1AS4MJcQ0yGhlxrslgHLDXmE+99nr?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d98c971e-81df-4f5d-d59f-08dd86463306
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Apr 2025 11:17:02.0239
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SpcDSOPn4MpF1zuwF41XAySUDtxtLQwSetB5GMdk/wx4uk9jPXg2HBFA5yQKExyu0ZRYw0c+NqMGcNrGh6C9Kg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10360

Add internal loopback support for i.MX95 ENETC PF, the default loopback
mode is MAC level loopback, the MAC Tx data is looped back onto the Rx.
The MAC interface runs at a fixed 1:8 ratio of NETC clock in MAC-level
loopback mode, with no dependency on Tx clock.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
v5, v6: no changes
---
 .../net/ethernet/freescale/enetc/enetc4_pf.c   | 18 ++++++++++++++++++
 .../ethernet/freescale/enetc/enetc_pf_common.c |  4 +---
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
index 1f6500f12bbb..c16378eb50bc 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -101,6 +101,21 @@ static void enetc4_pf_set_si_mc_hash_filter(struct enetc_hw *hw, int si,
 	enetc_port_wr(hw, ENETC4_PSIMMHFR1(si), upper_32_bits(hash));
 }
 
+static void enetc4_pf_set_loopback(struct net_device *ndev, bool en)
+{
+	struct enetc_ndev_priv *priv = netdev_priv(ndev);
+	struct enetc_si *si = priv->si;
+	u32 val;
+
+	val = enetc_port_mac_rd(si, ENETC4_PM_CMD_CFG(0));
+	val = u32_replace_bits(val, en ? 1 : 0, PM_CMD_CFG_LOOP_EN);
+	/* Default to select MAC level loopback mode if loopback is enabled. */
+	val = u32_replace_bits(val, en ? LPBCK_MODE_MAC_LEVEL : 0,
+			       PM_CMD_CFG_LPBK_MODE);
+
+	enetc_port_mac_wr(si, ENETC4_PM_CMD_CFG(0), val);
+}
+
 static void enetc4_pf_clear_maft_entries(struct enetc_pf *pf)
 {
 	int i;
@@ -536,6 +551,9 @@ static int enetc4_pf_set_features(struct net_device *ndev,
 		enetc4_pf_set_si_vlan_promisc(hw, 0, promisc_en);
 	}
 
+	if (changed & NETIF_F_LOOPBACK)
+		enetc4_pf_set_loopback(ndev, !!(features & NETIF_F_LOOPBACK));
+
 	enetc_set_features(ndev, features);
 
 	return 0;
diff --git a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
index 8c563e552021..edf14a95cab7 100644
--- a/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc_pf_common.c
@@ -134,10 +134,8 @@ void enetc_pf_netdev_setup(struct enetc_si *si, struct net_device *ndev,
 	}
 
 	/* TODO: currently, i.MX95 ENETC driver does not support advanced features */
-	if (!is_enetc_rev1(si)) {
-		ndev->hw_features &= ~NETIF_F_LOOPBACK;
+	if (!is_enetc_rev1(si))
 		goto end;
-	}
 
 	ndev->xdp_features = NETDEV_XDP_ACT_BASIC | NETDEV_XDP_ACT_REDIRECT |
 			     NETDEV_XDP_ACT_NDO_XMIT | NETDEV_XDP_ACT_RX_SG |
-- 
2.34.1



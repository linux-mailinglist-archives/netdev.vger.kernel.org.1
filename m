Return-Path: <netdev+bounces-95678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F428C2FDA
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 08:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDC061C21080
	for <lists+netdev@lfdr.de>; Sat, 11 May 2024 06:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B6AA55;
	Sat, 11 May 2024 06:31:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HOYV7EDJ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2050.outbound.protection.outlook.com [40.107.8.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ACD380;
	Sat, 11 May 2024 06:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715409083; cv=fail; b=lFblFghi90gfPpDuV2TOMPzLGCQ30atr5qYlqcoDIvb2FoMb9V19gcJ/GAkg7ElgKhx8DF+X6/mt6fTiCXkawzS1jh2ciq4uVa/GLBRinB7MRGgYOcBd29Tmke/FpcNYSs7oEqJ/p173nQMmdeJji7pumQurSFCO8WRw11F2SMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715409083; c=relaxed/simple;
	bh=BUDFgpg+nYEFNgcv5M0PQZH5XdKcv+4AI5+Aj5dJris=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=pkwnOP7GbV7N8tS06Ju55aPs5I8wFWjgRKoBnHgkrngogXkyciiVhSRvenY9qfJhNbqZkQ8UuheG0ivQqZgTiz6oZ1S+h0Vb11M6KXZUsPb8P0Oc9yDtnkET2fw5E+CgKwtkYVPxZTJkGQM4IbJXM7krHfdkLJlM17g3NMcxyhg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HOYV7EDJ; arc=fail smtp.client-ip=40.107.8.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oXaLUeX4bmofbi+ks88beROSrNizbwMOQ3INELzB9aBvkIjHcpLfxh/85uG+2RcHeVVRaBE41Jkpe7oSNjSpFTgNKb6gBgOyrNeiwdW7vcPkBdRZiOQCo4Yd04xrxd7RhoWHjBDzdb0ESCOfdvHbKIXON/VJO6geRJaQaG8pEuRpjxAs8WsYvZTpNB4XYlK63yAYXXgmHX8PwTwsfCQTqX4aSE4cmgjQ+th5aV/X+Z9OFs7co0YoH5xQPvKR0ccF0++hsu1jZJ7MhxhFHQoR0OtTA8mO9pdLexjofzfqG6yEcvYyD3sTZtNOh52lMo+eWiG7sTUsu3vh0rBIN0qq/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UKoUWpdmUUawbUL+N8U9sNlZrRisggBQ4JyNY/Iwu0M=;
 b=RLfDwAzpBd1aZRpKcROW5TDXPNv8KaAdfA1VC0a8yz4trAcB7WnRdQBh4dVOZA0UgyKKjEXZG4mkCGXqwXRQEeGAUHMWmb/gjS1kJlVMcFjAx2n/MUcHqFqssOZA4j0mBKa73fM+lOJPdQWHLyPyMwJOBbmVS1rn7n8GDmIlTu4mlXmtOASHkV/CvAQqb4Nw+3sK3FHwTXJ0PX8VUfTT0tvBGZ7BkJs7O1uTiF79JG+oVtezQZjG6S3jAkNczjSPofdSnaVtULaqyAkWzpniF2/GSLWAyD69B3lFgZkjqWFALansIdqdJ1xmmM51dL/gJJPfQfcshlVQaHNMJGr5Wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UKoUWpdmUUawbUL+N8U9sNlZrRisggBQ4JyNY/Iwu0M=;
 b=HOYV7EDJqewdRh9mJ/yCEN1dm2DQzNsNHbELT2JK5fOLNjMdmMbEkc4K6sZRAnWuIMXW4YnqpkjS1H247CndG6Pvgu4hR8+wvPgZMwTRVdQVezorN4GzltTJGUUbqJYg+Tce7bAUp8KllHNyZ0Pr9vQMiHr5AA2RxPO50zMQT5o=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM0PR0402MB3891.eurprd04.prod.outlook.com (2603:10a6:208:f::23)
 by PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.49; Sat, 11 May
 2024 06:31:17 +0000
Received: from AM0PR0402MB3891.eurprd04.prod.outlook.com
 ([fe80::6562:65a4:3e00:d0ed]) by AM0PR0402MB3891.eurprd04.prod.outlook.com
 ([fe80::6562:65a4:3e00:d0ed%7]) with mapi id 15.20.7544.052; Sat, 11 May 2024
 06:31:16 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	shenwei.wang@nxp.com,
	xiaoning.wang@nxp.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH net] net: fec: remove .ndo_poll_controller to avoid deadlocks
Date: Sat, 11 May 2024 14:20:09 +0800
Message-Id: <20240511062009.652918-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0058.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::9) To AM0PR0402MB3891.eurprd04.prod.outlook.com
 (2603:10a6:208:f::23)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM0PR0402MB3891:EE_|PAXPR04MB9642:EE_
X-MS-Office365-Filtering-Correlation-Id: 86f166e3-5c4d-44fb-5438-08dc7183f640
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|366007|376005|1800799015|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?R28UeCxIbX0ntuGn+qWrZeeAk21ZeglGWrOjcrPdvg8GoIoaGWpPsn9EUS8Y?=
 =?us-ascii?Q?HMPF8Df8LsVoQ2CzbrjT7IU0LoNPYWOj8+8BWBeHPAGlyFQoZnOixrVJJaUj?=
 =?us-ascii?Q?+rESLJ1f9+aUdycB3sLZNdBhFR0Mm7KmxWJPWx/PzwR63+s8uW4kRSy3Ay6y?=
 =?us-ascii?Q?rg7eqe8DtCQjsnK3K2QGXnv95CoUhellgf8JglOcbZard2+9UefcVj0NcAZ3?=
 =?us-ascii?Q?9QeaWklGUtQ32WGkM3eGzSf7A2mqI/NZHzQx6fZgOQaryzZMfepIhY46hIiu?=
 =?us-ascii?Q?5CMYo8VP4nUXFM4z4BCa6GQHQk79njDcYVVEkK+RK7abOsr0O2WScD7zBJcc?=
 =?us-ascii?Q?WeLXYRZBvFFK3efXEPUN4plrzZpHmpFWKFHYC/GPe7NPL7VvwTG5pFuKJYLo?=
 =?us-ascii?Q?73/DH1F5SMjdQd66KEY1wGZ6x7TyHxPf5wDWU2SPX8K7iMrcFV3oXZcLBkLw?=
 =?us-ascii?Q?lRRzPxesUtanMI9W3hIHQTPQOgSaf7ginmSqSP0WnEoSa0z6feMHLJKztUr7?=
 =?us-ascii?Q?rm+8HtdZvenD8HeJGST7M+tY0I64tREWAC9UANLYoZstae7hLRCVsjjVKtXj?=
 =?us-ascii?Q?V60s1dfLKXUUWDqydirjIi2j1ak8kAOk4Mc2fH1hs1QtK7gLOVOE51ozYKS2?=
 =?us-ascii?Q?2QUMr9op+QwZeGAJBHjjYCXUegC92GBcI93kjchkjjp6So1uGP7tuB8ofeRY?=
 =?us-ascii?Q?Fux+YYhNDHqPZ9jhM7jt25DquaREScuVYJF+o0bZI+bnrD4MfOaBz1YNyhen?=
 =?us-ascii?Q?z1EJyG22dfjerLMoHW5PTC7oapGYnQXyer3tqMPy4jObymqx3Yc0NcmrImYy?=
 =?us-ascii?Q?zrcM4gdUtJ+xhRYhGactSa89NpU/ydIFM+Jv2Rgm+etecflDXOf/i02G0cnD?=
 =?us-ascii?Q?+E7PqzoxzAAQBQ55/cXAN+zrvSRHoBNk5FGfFpzme5OseAR4YdVSxZ+gNVox?=
 =?us-ascii?Q?934V52JH4YZWpWxXC/9Tzp1zsnHXYV9tDP935Ct3VgYR3hVFEkuUFhPKYOYj?=
 =?us-ascii?Q?vMl1kCR5yoV4nSKGFUzPmT5q1659VLv0uRLJHuFHr7I/gMX51SHLyhfGGn/I?=
 =?us-ascii?Q?f5W//jzKgInFZ4xatLUcoEn6kLGpHmzwFOZv0gu8j6nZ/ZA7hQEEbwjuZf+V?=
 =?us-ascii?Q?OfExwXSo1l23wGj8zk4TlVNKtkHNccX0nqA4v/ZJiwyN7EJLSigwyCxOVNm2?=
 =?us-ascii?Q?2T0Mx4YsK4AwGBOEcmlxfgGYDknj3RHHfeFe4V+TcQnsCSGNubFZ+ZS+sYQ+?=
 =?us-ascii?Q?uOgUxkW3TSbh0/iNQ/0KEqXx1rg1QFB3IMAEmcJqbpupFG46T+8P0jmVINu3?=
 =?us-ascii?Q?IrX3OLxirkDEhtnLr06U+JULnf/A2K5N6LHuknBOG7rWvQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR0402MB3891.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?8hAY+UWobnl78QdNQOF1nNao+CQ63b4flseRlYmFwG74hMJWv01/TG6hRc26?=
 =?us-ascii?Q?OTskYMokSHJwdyK5Er2sRyqvIXgZNLF//4CM6TaG6rIW47GyTTTLMz95I0g3?=
 =?us-ascii?Q?pfrRcHu6LG3grGpes/wrd432Gl1mz7tplU2sudVzEqLrwEbig0BrpFzVf9I1?=
 =?us-ascii?Q?i8bBYx+D9ZEUyJPwkLpFf4TTXpmSC8p7ECzB27bxKOo90/kWB6M8PUCOuYq6?=
 =?us-ascii?Q?wLo00vPTA3qewT3g78LLNiXYpeK4goLOYl9RCZGs+08n65YesSgaSXKufXEt?=
 =?us-ascii?Q?XD3smJzBu80TmEJcVxBmJtwau/AWWM0jiK/BSUBp5NSJxp2YM7WiZgzCqQoZ?=
 =?us-ascii?Q?c5oO/zJhaKb5cuP9h3+xgzpC2l+PUYeZoYGiOY0M6D0/E/zOXwNBwSBLaMIa?=
 =?us-ascii?Q?gI3nzXom79YWPZUj61C/OlIaiAiUm710nT+YZDzZ0TWQ4pHfZdxBsp+/aaqp?=
 =?us-ascii?Q?d5U4amcytX2qWMQ/L0ugWPlPOgn8hY7Pmej25nSZ7/4TloVo25haES4g8yJU?=
 =?us-ascii?Q?Ldxdldy7Q2xKjT0iRjMcyEefKhkbCaZZYyBu5eFVBmLv4Qma80TiDkZBc/QL?=
 =?us-ascii?Q?BGqY35KCSlqrdn0NdmUnGyXjsXhQlJj3CoheDdEW3x/o9+uqEiLZciB5LX7x?=
 =?us-ascii?Q?Arfh/3a1J+w1oI06uLRnDPP4d8bdXiUfizkEcTwIB1XdR1Z/UJnE8HntPlRS?=
 =?us-ascii?Q?pq3dEqwiTQ0lqDMHOclK2ts7pBvnXsdITf/buUDXqnC4vtkryCSbARDjmNJm?=
 =?us-ascii?Q?/ML3Zmm2vbNA9y9PpXQxtYqOx5F/jrFZYc2Ia31D1uAhu0Qzx4401oBYbxq6?=
 =?us-ascii?Q?eFXPo+7vq028dihSv2Wcn1s1YUH3hqQAuHGgDufxTRCnnIQkS6SAf5USMv1j?=
 =?us-ascii?Q?DQyY5LJtyKVZvBK24ejSImb/6+AzKvaosbtHa1M1lbTt8jRXqxAyk/TJ61fH?=
 =?us-ascii?Q?2W/8T/pbeheWRC9Rb2KhjbItCWCXuA95DN5EZ4E7jN/AQjwvTGlKvvYxGN/o?=
 =?us-ascii?Q?le909D44SttztVn1XiPbf2HDYE0jk+GSKcJ7b0Z9/e2+r2Gf3BZkXBJUSV9Y?=
 =?us-ascii?Q?aqPV3cbS2rtMVAeGjQIRWOkWLDvgLbgZQeDPwzz5Bu6kvBcvOjzd6SIGC2BJ?=
 =?us-ascii?Q?edkn+z1k1XKKj3zNZoddEDWrbQDXo5lvQwIYXQ73jRZkT6qTtWurLaRLFNcg?=
 =?us-ascii?Q?5jkEh8y0V3hbnqabHgRpuIeymD/vvj8Hhr35hP1wV2g2qQutj8Klc8nqqYg3?=
 =?us-ascii?Q?ZX2gJigmbUI76aV7rFJt9Z9lkPr+178y7FNWyLsLYCGa0BksimIuS/u4qtk7?=
 =?us-ascii?Q?O5SFMbGf+om9NDtXR3JvFb3iuPVgqes1PWhP7Umtj1oNRG60exJrIeWsnq1b?=
 =?us-ascii?Q?fp8Ci6+XxSSh2ER+kqLZq2XZqteFvwd+8hrhikLl4wCPyc975VSmokAIvBpr?=
 =?us-ascii?Q?0Ppru1Ec0KHR1tDrxKhqaH3MZPXTA9tmNB5qT5t3glvAFVz/Z/ZnLIyHPr+8?=
 =?us-ascii?Q?3bA7mGUDd6Cviy02xXcq0Rkl9cPaqkTJ4Y6gzkt/h3jmUnxFEdlLnOX2lR+R?=
 =?us-ascii?Q?qKrtxg707O0fWSa5EGtL9WJHT+eW43TZnsThQxQb?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 86f166e3-5c4d-44fb-5438-08dc7183f640
X-MS-Exchange-CrossTenant-AuthSource: AM0PR0402MB3891.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 May 2024 06:31:16.8328
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: C3mc3rRhFOB1008RJj/a0hXqxpXti1fZhIN1JCIpBaaTykcnt4ADBOnBVLNfkAS6utaD8k3hOgxGlo5JckLurg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9642

There is a deadlock issue found in sungem driver, please refer to the
commit ac0a230f719b ("eth: sungem: remove .ndo_poll_controller to avoid
deadlocks"). The root cause of the issue is that netpoll is in atomic
context and disable_irq() is called by .ndo_poll_controller interface
of sungem driver, however, disable_irq() might sleep. After analyzing
the implementation of fec_poll_controller(), the fec driver should have
the same issue. Due to the fec driver uses NAPI for TX completions, the
.ndo_poll_controller is unnecessary to be implemented in the fec driver,
so fec_poll_controller() can be safely removed.

Fixes: 7f5c6addcdc0 ("net/fec: add poll controller function for fec nic")
Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 26 -----------------------
 1 file changed, 26 deletions(-)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index 8bd213da8fb6..a72d8a2eb0b3 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -3674,29 +3674,6 @@ fec_set_mac_address(struct net_device *ndev, void *p)
 	return 0;
 }
 
-#ifdef CONFIG_NET_POLL_CONTROLLER
-/**
- * fec_poll_controller - FEC Poll controller function
- * @dev: The FEC network adapter
- *
- * Polled functionality used by netconsole and others in non interrupt mode
- *
- */
-static void fec_poll_controller(struct net_device *dev)
-{
-	int i;
-	struct fec_enet_private *fep = netdev_priv(dev);
-
-	for (i = 0; i < FEC_IRQ_NUM; i++) {
-		if (fep->irq[i] > 0) {
-			disable_irq(fep->irq[i]);
-			fec_enet_interrupt(fep->irq[i], dev);
-			enable_irq(fep->irq[i]);
-		}
-	}
-}
-#endif
-
 static inline void fec_enet_set_netdev_features(struct net_device *netdev,
 	netdev_features_t features)
 {
@@ -4003,9 +3980,6 @@ static const struct net_device_ops fec_netdev_ops = {
 	.ndo_tx_timeout		= fec_timeout,
 	.ndo_set_mac_address	= fec_set_mac_address,
 	.ndo_eth_ioctl		= phy_do_ioctl_running,
-#ifdef CONFIG_NET_POLL_CONTROLLER
-	.ndo_poll_controller	= fec_poll_controller,
-#endif
 	.ndo_set_features	= fec_set_features,
 	.ndo_bpf		= fec_enet_bpf,
 	.ndo_xdp_xmit		= fec_enet_xdp_xmit,
-- 
2.34.1



Return-Path: <netdev+bounces-189010-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0BBAAFD95
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B80BD188D5BF
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D47126F466;
	Thu,  8 May 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="nl5xzstp"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013014.outbound.protection.outlook.com [52.101.72.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65BE08460;
	Thu,  8 May 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746715604; cv=fail; b=FUTnAPtCXMghaMts1pkNqJ4vQzTNJaaquxYV4yjsZlw2Rhj3K921J6ODYyDbpYM3OUbBFOMAKotBOQE4xFammmFvnSzE/2J5UVg7oSGGy08dLtId9X447XjdNrRpH93X6DR3Ad+PG7eMsUNWwFk294pASTZo/7y5i8MuiDQQkEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746715604; c=relaxed/simple;
	bh=Svmtf9V2uGV7fFtD+tZm2g3K59XHvOePAqqq0Bex2RI=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=Z62D/r+2L3cknaN5Cx/6V+phcHSWEfgx2FSYF/6QWpedKYBoOlvsSs8Z9IUzZTlyQQ5S5WjIaHioIjntDt5x0EyzumzEx8ZEpUGApB1g1oeTfmSfThvm8FfcdvQdWAjfMMuQWQPZIFn2ChZYtmNtLWQYAo0bOPETtqbOqIFI21s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=nl5xzstp; arc=fail smtp.client-ip=52.101.72.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JrCx7rgtAEX1mf0Ebo2rNS3RPT8p5TXJOiYXqztvUl6/SRdtjnnDOJowmwyMHQu92v2XImBy/IrmevpqMUQqtFx+DZjyizGRkkbWYa+aQi9D+PrRoOv/KwQLZP90MA/PD7EYChn8j7AsHdkj8bwt4TYiz4bhy+6V2bnRkIXlq8CSObBv2IhMYUxZqgwM6/w1WqV+3p1DxJb7ly6I5aT2WdKyNDoWQy0Tso8TqumnXEQDUNTlwmBb/2lUVgC70hTcuZpALkdiqX1NiTRuQdziKRz8UAqa/igz2X/PVJnYjt3YZWRiaQBNc2iCAwpWQg9+B498ibFu62UV/O+FiaUDPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KBLHYCjzGfjC+0Lf6ZwZCcdSeAGv2HDC6sNxjNOSiCw=;
 b=df0/XKkaUjnnDVc8vja4Z5lk20XcRa0pGXxwc4UYqEhry+4BtJn/AgAOxoYbxh3q2gOMfLAxsI2mx5g9fmJMH5EFCYg/ubRPqd6C6yNPvM4aqwsJ14PmkrxpWhcgQqqGnT1HMYxd+4UPRGnJC/jC0sR/r8RRAYcp+H37XopXiCY8YV3exnxybvboeCGevumioDuwRw+gw9ESPX1tv45MjH0fIN/LCZQr1IH4X5LAZcK64lWixi8AtDxXsv108YG0JttjY8+ltU39vHGXdfezNKSoCAkGCZSkFJiD7ogRjlUCkisgSEDaKOHmS7Ly/qCaGpWzikyPZYB7+If47d0MKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KBLHYCjzGfjC+0Lf6ZwZCcdSeAGv2HDC6sNxjNOSiCw=;
 b=nl5xzstpCD6jydfAtjfcdcWsSfOzifBbpd0HRmCp/eb4FtpSQYd5LYwe6xgnXeB4FvWfZmjVniTXwrTNlogzgMHXAUHR9rRAsqI26RgAdTffIIooVdOpsntFVsEC/JFHRyHCOM0J7gY+9VQP30YtZm58zxfqFTZF/vX8qC7BUPvDpoZcRXxei2QnpBHb2oJJe5b/gkPRohcuJNNZp3YyVElvB4EGGJu/CNZRMogUCy3OX13CVXURPxii/4SVrsAl6aXYmbz+by+lOdplHenQ0Ys2Fxrhup9+7YIQektcrv5ch/2KJYc7W4CuVxpvUrIeGfMjI5dD6xUh6hx/DYex9w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by DBBPR04MB7819.eurprd04.prod.outlook.com (2603:10a6:10:1e9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.23; Thu, 8 May
 2025 14:46:39 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 14:46:39 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Marcin Wojtas <marcin.s.wojtas@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: mvpp2: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Thu,  8 May 2025 17:46:30 +0300
Message-ID: <20250508144630.1979215-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BE1P281CA0389.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:80::17) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|DBBPR04MB7819:EE_
X-MS-Office365-Filtering-Correlation-Id: 8de023f4-9917-4a8c-eb55-08dd8e3f23be
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?odRXvgjwaG7yI7bvmSNQfq0nvet3Uy8DNO7Uq8e5EUb85pNWAheOzs3EW0XQ?=
 =?us-ascii?Q?0L9vo0B6XwqX7k0P59LAGBFAiLLURtzTxsH8P2RNdsjs1TLRbz74mmJbPoR8?=
 =?us-ascii?Q?YV4W+ThCyxURFZIpalNMhNfsml/iT8+jDuUCs2zwkhBgqwGrb+jDEivg3PjR?=
 =?us-ascii?Q?WfR8jMEhL4zHjL6tpO/Ll9e+TikWXuMN13vaZ8Epv6mYDmcR/kdnpJgREoTv?=
 =?us-ascii?Q?7BbHXcyEYuzz4mW1/JndcmSzYE47HFwwAzekWhdv+uLrhhOLaoNSyxi3quT8?=
 =?us-ascii?Q?bpKokPnrOC4PFTb3+a4ucoQ7087d/Cnwz5/zOoE9yCimJ8BjhdjQPywbHd0i?=
 =?us-ascii?Q?PIQ7SFKGrDPBsG0bVQq1n1Yyc6jjM6O7vlzee43Ok8PBf7K3yAp6ABHMJ6ja?=
 =?us-ascii?Q?Jh/dp/KQvsAlGGB7GI5MM+5U156PBLtxGwYJkR/xFktYXn3mul/R0yNOIDOe?=
 =?us-ascii?Q?TLiotfp9MkskHXbg7GmEYwaHkh+T0PqOKuqICYIGp6GzAD+/pfHBCOaGhh9B?=
 =?us-ascii?Q?IreIxIYfhuCVh8mv0wG0UDRvz4rfJfyy8Jw7mkFkRwlmoIVRmfM2MlhXsjJ+?=
 =?us-ascii?Q?rTXASR7xtpnqkSGqjjfw4mbPdaRIaQqxa7hz8ykJMWmO09oQaPDiH4qLxw8J?=
 =?us-ascii?Q?oG8LvrOVzG7C7boZWOX3MADpAOJXKpRnQR2HHQ906EZuMd1rb6ADfQIIgiwO?=
 =?us-ascii?Q?pM/aiVTSj5NBQQYlA4z6RUZ6l66DTCmJhO/CyaO6sl5e6it1/lqA4TGUB2nW?=
 =?us-ascii?Q?JUv26y/CclDH554uXF5YRax/TBnbnnokszUGWBAiyWmEvOwSN/eGXY+Tt1GF?=
 =?us-ascii?Q?yCdNXv+XWYJB93FykeDWgRd+F+1jAvJeqW0PX3fXN+7l7rHuCkNrlxJfzBeX?=
 =?us-ascii?Q?WtWy8aSJiS1woP2sOUbtVvR3jR1mrtrfyuiI44hZ9t/mep7Lskl1MBgos1ck?=
 =?us-ascii?Q?niJrvcI9OiUJiIOXv7Sy86NeMqkvrRSE54Ho3NrOiADQFpmYSz/nxScP/QyF?=
 =?us-ascii?Q?0YDolrR4RtnjM7rS4yFPTV1w5K16EhZ5EFYcnaVeiyqYd0R2N+NVWg6gjO3Y?=
 =?us-ascii?Q?eTzbTbl15AJJrIuV4+rV2PXzpj51oa7Fx1Nl1IVteRRjMiSEP93RsCAOMVKC?=
 =?us-ascii?Q?bJzZW2FABbimxmZQVoTfmgvPxG2D8nsTAdkxarvsVVcUHQfD1ai6ii9lv5M+?=
 =?us-ascii?Q?TyfxkWxgxMkHEVwC3QSIJ/EVYdXiEabCp81DDDIuXSi4hMnI8gzUGbM8PpPG?=
 =?us-ascii?Q?lbmQzo48yT1ruHDnAdv84qEOv6pyMXWJMDAQZubFYLu+B78+8t87kKdS/XKw?=
 =?us-ascii?Q?vuBVruLnkHpX0NQcMLkJNjDvJPF8mH1qUBidTTFVPwSSAj70zExER0YZ/p+A?=
 =?us-ascii?Q?U4R4IxpQjqcdeH7eXum4D/lrVfe2UowRl9hi/hAfgu/jKjBPyzCT7NNjTs9D?=
 =?us-ascii?Q?f5NDt6u0B5cc4zk3w44y6d51Snw3I4ywyxRYtbLKkRLUVOOwnX2xjA=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JHVRVXLcuwrZwAcS3EKFEIgWjeIwOeL16pF0Ho/L9OK1q/Z1QmlvTSx5cFVS?=
 =?us-ascii?Q?JAbdpOFzPvD5k8eswzQLTgDTGXYiraFV87s4iLhPzgdbinnv/+RoTHhgoqvc?=
 =?us-ascii?Q?yPqfKfdrrkYfu8kdV53UcyKbtjM2RmjueqdRrn5zdTDHV6nwvJXF94zJZgHE?=
 =?us-ascii?Q?gTpjXtUHHpLzAflliTn3NzteLauAdbnlFnk1OpUYnjZs8cclASQ8btcf279y?=
 =?us-ascii?Q?1cMVNjlSn8Sf/8NhBbZsLXqz1aVJKp+Wj8PiRyog6o6Y59ndaauI6KrcqOa8?=
 =?us-ascii?Q?3fpPeeJsWWnmfHH11Y16IzbYbQlotjcctvfk6nQZZ3+PWovl+Q8zMgEsPN6S?=
 =?us-ascii?Q?5S6OCssdswXmX7E4VSHWT9GlI8W55TzTbcnYOov4uZ2qeQ/U/HncvH2zB2cw?=
 =?us-ascii?Q?tuAdd6MPmWS3kbGjc+dzkmZ1QNWVaf05PWGi1TWBlvo2a69Oq5mYI/zp1r1H?=
 =?us-ascii?Q?DKRG+3CefYOSPcwr1E3WeXCs9gyljVVEZhrbMwzsdvzSCkMLlF8NUlJPflDh?=
 =?us-ascii?Q?YOZEMN3GUASBkgi5Fkv53Hccxd94ASu01qoX+U5cXf/iqJLqTlIOJPIiD6x6?=
 =?us-ascii?Q?kWWCuhXF5FyA5e6qoBdEviZEJDYloEMI9XA31Ycmchj6cHpS0qkunHKm2Ioo?=
 =?us-ascii?Q?NPDwyZM6HfE/TZdiK4w+6EV5fMSfZu+o34ecWwCgSWurz8HxWFNx7U0Q0f1c?=
 =?us-ascii?Q?GDF9pnSQLQ0wOVhysWrzy2vZUqzo1WRGGgpIOwIVXaR/igwoM8rvRN72rhyT?=
 =?us-ascii?Q?uZyF1GALPcO1PkC4RTEGHxwuCBijnOz9qCzCLuwrSo3c784LGLcHDcL6c9sX?=
 =?us-ascii?Q?+IHi/z0MfsPeQH8NcvJnv7J9axam8bXjJH+uChLMtXXJTvuWQKPvVSIJgtny?=
 =?us-ascii?Q?Ja+tWepaYBTk9TvP1o82DJ0WupiSUtJ4IlDfe2w8elHHJrWPjOgp4EZrSHbV?=
 =?us-ascii?Q?DAKxbY2KqdahIEL5MDwUoU1cxH9vmHMHwBLMU60yZIvVV1w+AoxcBlIS7Cd6?=
 =?us-ascii?Q?llpOsvHswgM9eS6dPH3Mui9adjjN9l39DU2m/0LLwZmrloP31E3/s3taVv7p?=
 =?us-ascii?Q?w8Pa4QKX4LZr7cD4w7EaK6rKaBKq0Y5RZY02UjKMnZSHsLV8F1IOWtK/ziCx?=
 =?us-ascii?Q?/1lXIZx1EvM81LB0aLOYjGe29J4dDs/bXt+yqITn5AlclnH1ytpRB5bpK6SI?=
 =?us-ascii?Q?jniezQtFgAnFSveKEN8MaBk57vQz1GNKj6nHEZcJ9TMF7LAgWzzS6t98HpJk?=
 =?us-ascii?Q?bU3QgGWGbPY6h0xh25/Wjfe6CH0WZsJdJNSZAXEubpplCvRzCMVRuDqxJ8uN?=
 =?us-ascii?Q?bFvm916m61RK9Xq8w4YqAzva2E3/Vxo1QG3FTvmJ4CqH0JoscjirlkahhAxm?=
 =?us-ascii?Q?aBezxOCfqSNYGdNyOl8feVrQZuLpMl6HOgLf95QRJkE8yuqM5gYbDlrOYsrk?=
 =?us-ascii?Q?jzCuPgerIG1Bog6scW/opA4flZPUkaKe+R4WX8vinrrwG5soGO4h3DxS14nH?=
 =?us-ascii?Q?11bNmWMbYNueNGWdPEUSWjjXFlHv5emxdBVZ/z4CqjcCB5abW7ebGV0dEf/Q?=
 =?us-ascii?Q?kIcx55CUY6Jqkt1ZjEDjpOCWgmbKe3pdyBGGB4AL/iYntfGSz6b3cX/qj3Yv?=
 =?us-ascii?Q?Xw=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8de023f4-9917-4a8c-eb55-08dd8e3f23be
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 14:46:39.2704
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZdHGW5AT680aGZ+rH6HmMbgUWiQnLATpt6J7lKJ1w0jO1BpkT3VQmC4vUea6ElstL5KqcHCUIJGpa2TsIHGyHw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7819

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6. It is
time to convert the mvpp2 driver to the new API, so that the
ndo_eth_ioctl() path can be removed completely.

Note that on the !port->hwtstamp condition, the old code used to fall
through in mvpp2_ioctl(), and return either -ENOTSUPP if !port->phylink,
or -EOPNOTSUPP, in phylink_mii_ioctl(). Keep the test for port->hwtstamp
in the newly introduced net_device_ops, but consolidate the error code
to just -EOPNOTSUPP. The other one is documented as NFS-specific, it's
best to avoid it anyway.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
Only compile-tested.

 .../net/ethernet/marvell/mvpp2/mvpp2_main.c   | 58 ++++++++-----------
 1 file changed, 23 insertions(+), 35 deletions(-)

diff --git a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
index 416a926a8281..a7872d14a49d 100644
--- a/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
+++ b/drivers/net/ethernet/marvell/mvpp2/mvpp2_main.c
@@ -5173,38 +5173,40 @@ mvpp2_get_stats64(struct net_device *dev, struct rtnl_link_stats64 *stats)
 	stats->tx_dropped	= dev->stats.tx_dropped;
 }
 
-static int mvpp2_set_ts_config(struct mvpp2_port *port, struct ifreq *ifr)
+static int mvpp2_hwtstamp_set(struct net_device *dev,
+			      struct kernel_hwtstamp_config *config,
+			      struct netlink_ext_ack *extack)
 {
-	struct hwtstamp_config config;
+	struct mvpp2_port *port = netdev_priv(dev);
 	void __iomem *ptp;
 	u32 gcr, int_mask;
 
-	if (copy_from_user(&config, ifr->ifr_data, sizeof(config)))
-		return -EFAULT;
+	if (!port->hwtstamp)
+		return -EOPNOTSUPP;
 
-	if (config.tx_type != HWTSTAMP_TX_OFF &&
-	    config.tx_type != HWTSTAMP_TX_ON)
+	if (config->tx_type != HWTSTAMP_TX_OFF &&
+	    config->tx_type != HWTSTAMP_TX_ON)
 		return -ERANGE;
 
 	ptp = port->priv->iface_base + MVPP22_PTP_BASE(port->gop_id);
 
 	int_mask = gcr = 0;
-	if (config.tx_type != HWTSTAMP_TX_OFF) {
+	if (config->tx_type != HWTSTAMP_TX_OFF) {
 		gcr |= MVPP22_PTP_GCR_TSU_ENABLE | MVPP22_PTP_GCR_TX_RESET;
 		int_mask |= MVPP22_PTP_INT_MASK_QUEUE1 |
 			    MVPP22_PTP_INT_MASK_QUEUE0;
 	}
 
 	/* It seems we must also release the TX reset when enabling the TSU */
-	if (config.rx_filter != HWTSTAMP_FILTER_NONE)
+	if (config->rx_filter != HWTSTAMP_FILTER_NONE)
 		gcr |= MVPP22_PTP_GCR_TSU_ENABLE | MVPP22_PTP_GCR_RX_RESET |
 		       MVPP22_PTP_GCR_TX_RESET;
 
 	if (gcr & MVPP22_PTP_GCR_TSU_ENABLE)
 		mvpp22_tai_start(port->priv->tai);
 
-	if (config.rx_filter != HWTSTAMP_FILTER_NONE) {
-		config.rx_filter = HWTSTAMP_FILTER_ALL;
+	if (config->rx_filter != HWTSTAMP_FILTER_NONE) {
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
 		mvpp2_modify(ptp + MVPP22_PTP_GCR,
 			     MVPP22_PTP_GCR_RX_RESET |
 			     MVPP22_PTP_GCR_TX_RESET |
@@ -5225,26 +5227,22 @@ static int mvpp2_set_ts_config(struct mvpp2_port *port, struct ifreq *ifr)
 	if (!(gcr & MVPP22_PTP_GCR_TSU_ENABLE))
 		mvpp22_tai_stop(port->priv->tai);
 
-	port->tx_hwtstamp_type = config.tx_type;
-
-	if (copy_to_user(ifr->ifr_data, &config, sizeof(config)))
-		return -EFAULT;
+	port->tx_hwtstamp_type = config->tx_type;
 
 	return 0;
 }
 
-static int mvpp2_get_ts_config(struct mvpp2_port *port, struct ifreq *ifr)
+static int mvpp2_hwtstamp_get(struct net_device *dev,
+			      struct kernel_hwtstamp_config *config)
 {
-	struct hwtstamp_config config;
-
-	memset(&config, 0, sizeof(config));
+	struct mvpp2_port *port = netdev_priv(dev);
 
-	config.tx_type = port->tx_hwtstamp_type;
-	config.rx_filter = port->rx_hwtstamp ?
-		HWTSTAMP_FILTER_ALL : HWTSTAMP_FILTER_NONE;
+	if (!port->hwtstamp)
+		return -EOPNOTSUPP;
 
-	if (copy_to_user(ifr->ifr_data, &config, sizeof(config)))
-		return -EFAULT;
+	config->tx_type = port->tx_hwtstamp_type;
+	config->rx_filter = port->rx_hwtstamp ? HWTSTAMP_FILTER_ALL :
+			    HWTSTAMP_FILTER_NONE;
 
 	return 0;
 }
@@ -5274,18 +5272,6 @@ static int mvpp2_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
 {
 	struct mvpp2_port *port = netdev_priv(dev);
 
-	switch (cmd) {
-	case SIOCSHWTSTAMP:
-		if (port->hwtstamp)
-			return mvpp2_set_ts_config(port, ifr);
-		break;
-
-	case SIOCGHWTSTAMP:
-		if (port->hwtstamp)
-			return mvpp2_get_ts_config(port, ifr);
-		break;
-	}
-
 	if (!port->phylink)
 		return -ENOTSUPP;
 
@@ -5799,6 +5785,8 @@ static const struct net_device_ops mvpp2_netdev_ops = {
 	.ndo_set_features	= mvpp2_set_features,
 	.ndo_bpf		= mvpp2_xdp,
 	.ndo_xdp_xmit		= mvpp2_xdp_xmit,
+	.ndo_hwtstamp_get	= mvpp2_hwtstamp_get,
+	.ndo_hwtstamp_set	= mvpp2_hwtstamp_set,
 };
 
 static const struct ethtool_ops mvpp2_eth_tool_ops = {
-- 
2.43.0



Return-Path: <netdev+bounces-188969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 29F0BAAFA67
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5428B4E81BC
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 12:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43988229B2D;
	Thu,  8 May 2025 12:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="j4aa8MN8"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2060.outbound.protection.outlook.com [40.107.22.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 340BE22579B;
	Thu,  8 May 2025 12:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746708523; cv=fail; b=Aas8MhYq7XkKxbxBXBNXVLOo/u/a1QxMtRwSxMI7Q5sZJgTQ/5mDCn71/5I3MDXvSDIjnX37V1pMr5I2aSVqGNOMwzm3TNALlKsyNez9Vy3FtdysSGh7KxHIvSoJeXrjiL2rRAPaUGNhwcVPGHKWxFgbdFZRfvBR7B7e0oZlU84=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746708523; c=relaxed/simple;
	bh=xWozvKcPnx9/GkIC//ABDHPfM1XntUXSZGk90ihaXQU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=WdK90oTbrYTU/uzw9BoZNvsXzzndbpGvNVlP6r3d1IBUNjsa6AKuC12HuqSGnuf+CcFUtDFy3o9moEwLUMfHCNLO7DoK2WMFhTlg0CrxXm7J98WbpPIVu5KCmjkIqj6naoxx7InH3NTHWPStLkUiV4CRuEqqW5JH2KGxNSTSCmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=j4aa8MN8; arc=fail smtp.client-ip=40.107.22.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OD9zOa2treNbcG2x7Oy4PDb/yNgqCTJSrY9VJD4JTEr7q4zCCpjsl3oKb6vpz3s/tB4P0+Pj5uvaCPLS5/ztbnxdb6vLW0jvH8LOjCaD91Dw0W/aml+G/kVOhafCm3e0KQbuEw3WVJpJNDnQrS/roZhdjdT7Zf7w7sqOQHXknoHoLTgtRNN4jMpJr8ColNMzxLfQbz2DkhKCoPdtGDk7k6HezcgsKlX8JkmDEHYXDJPEY5IWnIkm3JIHsVfzlDtWV+fFi4pECqxXHLJ95s0vDFnK6jOuH3+KL74vheq051cWzi/mGeq7kkKl2YdTqx9/GHiC9u9zfZeq8vEMv7H6oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G/GWYQm9mbRDNU0KQbuNv5oyywdtXgVtI4Y83K4or8E=;
 b=QyzGVP26PLb4yCDYXmnLp8a+8XB3mlcouY3s47rn17XGsQcRJzXtgBlD7qiwjdN2T2JhvppWk6bkOmLtEnL5nCwXZSVs7P8XDnFDyBU1XpvhVfB9vuygKXxzOQuwUkyod0auVffV2eWdXFLdX4H1B/pHI7nKsY9lqf2FTWIPr6pVXM+DxqthrGkJouixGqXwhCLZnmdYlO5+QHAqFY0Je56MZo6/BCWcelKMAM0yIwUUbWTV4VHhzEfbldCCpUNROXxwy6zqga7jgEGv7WfmYCyEZHoOClOhM78UwqI3jXEDQj1eC2V71TMFv4gqe7eGSXYN8yzBvstHkDAkLcTRfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G/GWYQm9mbRDNU0KQbuNv5oyywdtXgVtI4Y83K4or8E=;
 b=j4aa8MN8i9NGace3KhsQyFew6CPxTi3cglPuiCS5f3uDrVUFS/Hbid7t3xytot1vBHpp5LTNaOrJFHyHWW5qKj9a8w9G5jv0yHwoDobJkQZzMfUeSb93opVaiDGjI4W4BYXgmxRxJbuTAE5pyW7R3kOO7WgdIA+ugWqvseHigNUMzu6f+Q0twpCf92ZEqRmNL52TQ9uSUDL1Hkr2SVeC7U4gg7lP3QSMyeAkjz1Uk6vMbPuslslLu6yaDL9mWcjmUx53icge0ke0j4vwAZGuN4b1dK3MMteQM/DL+qEOOZpod7bualo/YHEdcysBX4A9zHTDRrS2QgKbkfWskVokcw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA1PR04MB10398.eurprd04.prod.outlook.com (2603:10a6:102:44d::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Thu, 8 May
 2025 12:48:37 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.020; Thu, 8 May 2025
 12:48:37 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?K=C3=B6ry=20Maincent?= <kory.maincent@bootlin.com>,
	Madalin Bucur <madalin.bucur@nxp.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] net: dpaa_eth: convert to ndo_hwtstamp_set()
Date: Thu,  8 May 2025 15:47:51 +0300
Message-ID: <20250508124753.1492742-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250508124753.1492742-1-vladimir.oltean@nxp.com>
References: <20250508124753.1492742-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0157.eurprd07.prod.outlook.com
 (2603:10a6:802:16::44) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA1PR04MB10398:EE_
X-MS-Office365-Filtering-Correlation-Id: 9122ebe1-a1f8-4e8d-676e-08dd8e2ea6af
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?1KpREBVQrFWc4Vhba9018aj/L9hmMsq6VQMrgc4d7US+oA1tlpaAIJzFIBsU?=
 =?us-ascii?Q?2yDfwFXBsRY7fcf8y1++xuul1Lxj/hzhLBtgNOWktEdt6lRomk2x1IGmZxxx?=
 =?us-ascii?Q?WdwCFvrxJREoQekNzwf0yjyExpyuBL81h0aaGi0sxoffmnvQmg69fETFb4xT?=
 =?us-ascii?Q?vU0BHYz9udStQ///wkFWJbrAT6BiV7f7MmRHeyabaDeh+Ze42AoSeUxpYvhy?=
 =?us-ascii?Q?bdhfYgTtPg/gc4B7sLxGEHGB4cwBQmWnH7HgcllCD695SiOLhk78W5SiSrAy?=
 =?us-ascii?Q?Rlt7sbEioh6YhI5ZGTR13ecM/846JHsPg13ChpdbTr2NKRnYKZctH8QGZki5?=
 =?us-ascii?Q?0wzLES0wkYz1IkARfmzIU3kPkb1ii2xUsccXgSNPIfrHoq5RJNusfnLSGMY3?=
 =?us-ascii?Q?P28ACCUC3EaVcYLAL4po/Tq3+mo4MICxNYJd4J6wA2upOcOdFHNRGBigWWb5?=
 =?us-ascii?Q?q9XvssZjSkZP5pF9qFXDxZJRC8Xd6NzF3NHqzltrfaUOl0rRl5q+envLj1w8?=
 =?us-ascii?Q?K6tc7vfoTH6wbsi/wnLhF+6Z3+3OSjMsIcQJN0dchJRPzDRXDrd+LGpDYmLU?=
 =?us-ascii?Q?im+aH/RbRl4pa3yTR+yhDrwYIOZUAXqvdmVo6VQaz0Z+pHGs8N/yCo95GCPB?=
 =?us-ascii?Q?wsNn1a/i4ak17LIuHwP3ohfYrufzH14/QEzSqUGOu87zyYpQDVna4Dur+v/Q?=
 =?us-ascii?Q?lJ4j1EsNtOvd4COXbslzqVeuWzKRLk5qPp1Z3mFzWEDAzF7f88Gi2qo29e5Z?=
 =?us-ascii?Q?IUGD3saHr8YrylwtBTwH26zOdMxuq7HAw3lrnkBPP/MLkAcix92JdMJACsYA?=
 =?us-ascii?Q?7ANzqnRsNG0DdYtC93LaAQtkdcpn23JAP2hRaE4n42cNFZK2OxbFm55p1wrf?=
 =?us-ascii?Q?4F1jmvMcDDHBQMk6nugRmi7ul7oo1d6GfBjAGE/Db0hSerPPZt3lCniVt8DK?=
 =?us-ascii?Q?AGxNX6aLYQtnLM+GWVpU9VT2YKcMs5Er7AaepjV8rkheNElDtnJ855AMVUsg?=
 =?us-ascii?Q?nTq7GyyMmiRVU/+n6Assge7+whCKtElntPw7VWIjlnB617koP02aqTuVu5z7?=
 =?us-ascii?Q?fgAMNInyqJcT7YwYNUDKCAJ4IYcOZ88c/REjWfKoEiTYGcS79Ngy/EklWzP4?=
 =?us-ascii?Q?pZNoCkOvxZa3glXM2/smcZAwz9KPNb+i5pPaTl9LhB/Y4p+jdKO+M7CDhByo?=
 =?us-ascii?Q?sSWJvpSxdQF8g5k9uYx+MH2qcjUuHm4ZvyG2UmL1fR8Y1I+sO9tV/g3Si01n?=
 =?us-ascii?Q?+mjLbaanPo4NZO5vdO28OR4xwgw0WNwAwbex9VwMPyw/Zoo4ES9kZFof7TXA?=
 =?us-ascii?Q?vJTSq+A29YYCJzNx3pStTG4eS5Wh3aNA6EXAlOxmkg26L/SceagkRZdc0eYs?=
 =?us-ascii?Q?wTHcG/Jd/x8mBp1IFt2CS1hNxNsRcoky7DBRHbPmSmoCNbaYFy0SdwVrf7sp?=
 =?us-ascii?Q?I69GopDGoPSixXaK+b5INa2GT3v/erz4GA/FspvqdrhaX9zvFs4EnQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?xlfk/y7iJfLDSiQJ+kAqG20WmWOZRAF3rQNesn6C9BrZHhtzXB6Y+oTZldk8?=
 =?us-ascii?Q?zHTRieuiJH68gGm6tgAYFsEinG8wiNNRDeZY2SsbW5ibhhRpnIcCWstuNLpe?=
 =?us-ascii?Q?fQ2mGKFRLHbxZDVDsHaONVfPSdVFu2696wla9WjvximVxPSaM6Wljfsqoi8Y?=
 =?us-ascii?Q?5xIfbcUA3TqVyJFG0oDbRiGARxz4jvRFFzQ8J0UuPJo0hGVQVdn+rEEA5RLF?=
 =?us-ascii?Q?ZoT6uZ3o3AO2Qp69WZW8SA7FpAfM//eshQq10RUshwlbO6SB2ht5OHPrYWik?=
 =?us-ascii?Q?hQkI+0793v68yrhOZFFUDc1+NVoWmBdOCuJzr6BFq9WRXmd+SevboiQxz1WT?=
 =?us-ascii?Q?wlyDW7rh91NA8Ip/lv2MPRKGBtpxAqadcPQ7CEAEi7tBxl/Sf75ZJ5AzAWab?=
 =?us-ascii?Q?jxOG4PP1waiVhwIs//mlAK74iE7uN5CxxAwnYk/HszXkte4kqC0GIkxiVwH3?=
 =?us-ascii?Q?AcY8s7lopwAsq9fE7fJ4tWk78JWikKPwHK4AGgLCXZ8uXZoyU92/r4KJDw97?=
 =?us-ascii?Q?KnAejvlfGTlrEspAT1yiYS/g9aQU8pqKhWhMGHkhcOhOO+VAnAk1GOQAK27u?=
 =?us-ascii?Q?7+RLIfAmw4V5x7QW0l2xsK4TfCIJGczftMg44ZRABMU+kb0ZJir3NvSKYfaT?=
 =?us-ascii?Q?yI+te9bdGO6WmcyPD4r8URV74dcd/omwRXwW7y4aR5qTOMr3v3i2Sem0LAfb?=
 =?us-ascii?Q?juh3W1u9CbXjzakLsYnWrECgvBS8jjnVkxyQcve7pPA4bP+J4P1ojIbyghus?=
 =?us-ascii?Q?AKtHGzOQftnGnoaywmG9xDRbXctQJOiFj/NNyegBGuX1XvQu3pl5CysPQbpG?=
 =?us-ascii?Q?Bm3rMaX7R1KgnawrOW15M6UVZII0B/LYq64pq79WcP/E/nsh9RMg6mmst9cc?=
 =?us-ascii?Q?2WnCHRRJ5kFNuP3EboNMg++pk3RUYvoUxrLWT6V5/nlY2N0V7iH4AAiVGkK2?=
 =?us-ascii?Q?+C9NHCz6YYfzvgJfIip2buoI2YF6tuexcOBsauGOxKUm/cQCpIDze9jH/ut/?=
 =?us-ascii?Q?BjRpdFyqR2BwaDFUbndSAQjFipUBN7XePHpYzGRMLDbfLaxnuvZEgtMeR5Hz?=
 =?us-ascii?Q?moeprwF/B9KLaoZUXxsrO23151aD++AWfvLbmapS/sNh1iyIwMbDjhy1wMR9?=
 =?us-ascii?Q?vTSGtz/muPRVx5qHXpFrCKksduYztogoOGRRdaaGHWh4qjpYp2SOaxkWWcop?=
 =?us-ascii?Q?Yikad6zgfkOCnkfdMeMbXP9n0o+qAcu6snecsE+m7xE6425IuO6POr9icrmg?=
 =?us-ascii?Q?CxsAvIc34/QgWkcZH74wCR3KZgdMBXmdTxF4jxw7P85RPWM1YV61Ak6YPB+4?=
 =?us-ascii?Q?O3cBZu/ZTZn6Yvi9WEr4RLRbrQk1iRTyspKr+3rubPQp2xV9v93aBTy9a6YH?=
 =?us-ascii?Q?C7P96hT3WZaT5Hj7/G9YavoRkMOqRuwjftfI/QSDgWoxYZqdlds0J3p4addq?=
 =?us-ascii?Q?qT6sHB36hBmU2MGN9GXtyqI/XMBtNBkpi/7yvld7tyiSs7UiUHdUem4SxDQ9?=
 =?us-ascii?Q?AY/Rrtxuc4W52GYAlHT3Z1RimHhbKSn76EoXURagbSQGSqovoDobS/wrHH7w?=
 =?us-ascii?Q?G6LvDfGdWlaWt+Xa3k6CPwzN+77LuUaY/vHlU7P15kTY4Zfcu2wcnw593uz7?=
 =?us-ascii?Q?Lg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9122ebe1-a1f8-4e8d-676e-08dd8e2ea6af
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 May 2025 12:48:37.4668
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 39CSHxaobYKXrF0/ZwG1y5LCoK7ufqHVlCHld/L0HIGIhLDVsi9tqE4/1eNbZszV9Lgagg93D4J1jlpc1tl9yg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10398

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6. It is
time to convert the DPAA1 driver to the new API, so that the
ndo_eth_ioctl() path can be removed completely.

This driver only responds to SIOCSHWTSTAMP (not SIOCGHWTSTAMP) so
convert just that.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 .../net/ethernet/freescale/dpaa/dpaa_eth.c    | 21 +++++++------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
index 4948b4906584..d5458a5fb971 100644
--- a/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
+++ b/drivers/net/ethernet/freescale/dpaa/dpaa_eth.c
@@ -3089,15 +3089,13 @@ static int dpaa_xdp_xmit(struct net_device *net_dev, int n,
 	return nxmit;
 }
 
-static int dpaa_ts_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
+static int dpaa_hwtstamp_set(struct net_device *dev,
+			     struct kernel_hwtstamp_config *config,
+			     struct netlink_ext_ack *extack)
 {
 	struct dpaa_priv *priv = netdev_priv(dev);
-	struct hwtstamp_config config;
 
-	if (copy_from_user(&config, rq->ifr_data, sizeof(config)))
-		return -EFAULT;
-
-	switch (config.tx_type) {
+	switch (config->tx_type) {
 	case HWTSTAMP_TX_OFF:
 		/* Couldn't disable rx/tx timestamping separately.
 		 * Do nothing here.
@@ -3112,7 +3110,7 @@ static int dpaa_ts_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 		return -ERANGE;
 	}
 
-	if (config.rx_filter == HWTSTAMP_FILTER_NONE) {
+	if (config->rx_filter == HWTSTAMP_FILTER_NONE) {
 		/* Couldn't disable rx/tx timestamping separately.
 		 * Do nothing here.
 		 */
@@ -3121,11 +3119,10 @@ static int dpaa_ts_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 		priv->mac_dev->set_tstamp(priv->mac_dev->fman_mac, true);
 		priv->rx_tstamp = true;
 		/* TS is set for all frame types, not only those requested */
-		config.rx_filter = HWTSTAMP_FILTER_ALL;
+		config->rx_filter = HWTSTAMP_FILTER_ALL;
 	}
 
-	return copy_to_user(rq->ifr_data, &config, sizeof(config)) ?
-			-EFAULT : 0;
+	return 0;
 }
 
 static int dpaa_ioctl(struct net_device *net_dev, struct ifreq *rq, int cmd)
@@ -3139,9 +3136,6 @@ static int dpaa_ioctl(struct net_device *net_dev, struct ifreq *rq, int cmd)
 						 cmd);
 	}
 
-	if (cmd == SIOCSHWTSTAMP)
-		return dpaa_ts_ioctl(net_dev, rq, cmd);
-
 	return ret;
 }
 
@@ -3160,6 +3154,7 @@ static const struct net_device_ops dpaa_ops = {
 	.ndo_change_mtu = dpaa_change_mtu,
 	.ndo_bpf = dpaa_xdp,
 	.ndo_xdp_xmit = dpaa_xdp_xmit,
+	.ndo_hwtstamp_set = dpaa_hwtstamp_set,
 };
 
 static int dpaa_napi_add(struct net_device *net_dev)
-- 
2.43.0



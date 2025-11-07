Return-Path: <netdev+bounces-236747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 268DAC3FA69
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 12:08:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F08A94EE78B
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 11:08:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C02931E0EF;
	Fri,  7 Nov 2025 11:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PFZ5jexr"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013019.outbound.protection.outlook.com [52.101.83.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFCAE31B80B
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 11:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762513718; cv=fail; b=Lhyaf4Xlr7IvDYKeBHsBcrFdaqV5Uw4I9CtgbVZ9TvnLDa2/+ti3C+VH1+r5NEi5W3c+5oHQ0cCpFGdWlHQSCgeF7ojgsHMi9C+sHC2zVFtqzBsHv945euaEelAkc7MObMRixuNFgnkGsEnF8Y3eT1ps5thjCd++znEjBtpZkTE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762513718; c=relaxed/simple;
	bh=dqETqPvb/yVztCmGW0wqbri40op/cMs8Oej15BGFtOU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=qMBgu+0KgivtPmPD55Vb9J2Z+75xe4cugW6btuCdrerp3OccoM2Y4WzqvQRdOU2hLW7hxazljMZDu4bgyjZP41SJFhz/fiyhnTglyU+P4QTQGVu2C2FNiU4Otr+oEIxBo+dt2AfzgD+6jFLJhjv3Ikmb94mZBOb21ZHOS+lnXrw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PFZ5jexr; arc=fail smtp.client-ip=52.101.83.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jCjMqY5cWGyX+kI/86LlFPqkHDQ2VmFWWd0gGETObANBRg746EVzdRp1qBYVQqnUGxSAtRzyepQHwi85nTYuliqpWBn25+rhSi/2QuSCBOemb+jlIl7KXgTudNOQiA5Nylanh63lSwc2J7ijo7vHZMgj4+KHX2dus89YYrAt/IpJRFt1QHL1LAzf0fLlJjWVO3xHv+BtV9FoJy0zMGkCQwgRlPn7l0u2HHC9SREp/QRsPCPE3S+el2cifkwjwX4FSMw5e94oVl6j72ehbnTGxKf3kXc128V/9PND1VOIAkJFsUkkYZEQkn2eZYKk+TGIMd2/E1lLuOl3Fz6GxOR5WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OzQFJb3XmxiHSWTOAFSbTjBZ8+q3on0JHuJUNZhjZq8=;
 b=MzLbchBJVYSD8uwkmPgQ07064TqVRDuNuljCNUUsnvsLKf9IAL0PIv0uOqJf81XXnAZcahtp01NKc82a5hg9tB3lO8xfslwiEb2sg4DBPszKcm4ETmobtrWkiOXU7MDCtkdWboC0QIEPZDUvfspHjY2T8Bpxte6sbQIFrfEp5XD4BMY/wqwIOrqgKu0K4xYkzLcUDR0uobODHuArWgM9hd7kfrAM1atqn7+hXh7mMEfoCIB/kPaFv4oWtXaCWUF47dxb96/Dix/aFfVO/aEN0c0cbt642304eHqu6AbkLzdR2T/cHl8XBIptdLo8V8J7tIMCEnCIaeVlvR0r2t6RGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OzQFJb3XmxiHSWTOAFSbTjBZ8+q3on0JHuJUNZhjZq8=;
 b=PFZ5jexrNWZIPGYt+QNRstyYtA3a9TwtUlbEWpbnZpaM+TGewuwzZ0Z50PZNaq92mt0wCz+NKueg+DFH0Is3pTbg/EyX+3OcYvp3lWDQE7aATasSN/CG+CTfM7dsMJyiOoEeIE2Of4lbZtEBw6iSPQSGWmKXhuMBu04gffSfgxfZYSgtv4fhdlaSsJyLkjEy72xsd/LDNN0HMIYOW1RS4ooyxwqlb4GJLcF5Nn/XmDXHWpKaOs0alBnBrMeXfmsV2FW/AjLvitFxMCen7LnGhgh+/R13u6eSzwdhcHGcwyOldhjK2sCaOj/68K/DSw2BvCJKpr3mWXQ0limTxOE0ww==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by AS4PR04MB9505.eurprd04.prod.outlook.com (2603:10a6:20b:4e4::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Fri, 7 Nov
 2025 11:08:31 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::b067:7ceb:e3d7:6f93%5]) with mapi id 15.20.9298.010; Fri, 7 Nov 2025
 11:08:31 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Marek Vasut <marex@denx.de>,
	Wei Fang <wei.fang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>
Subject: [PATCH v2 net-next 1/6] net: phy: realtek: create rtl8211f_config_rgmii_delay()
Date: Fri,  7 Nov 2025 13:08:12 +0200
Message-Id: <20251107110817.324389-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251107110817.324389-1-vladimir.oltean@nxp.com>
References: <20251107110817.324389-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P195CA0028.EURP195.PROD.OUTLOOK.COM
 (2603:10a6:20b:5d6::13) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|AS4PR04MB9505:EE_
X-MS-Office365-Filtering-Correlation-Id: 5e7c7f6b-6149-43f7-b0cf-08de1dedfc08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|52116014|376014|19092799006|366016;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?DQtt5ixRsra0axY/zzG9xDfXH+LYZOHCLkyafe03nsPrvJvW5VpvRzzLcoBj?=
 =?us-ascii?Q?UJpHEclOlwfv+3iXGDhwaQ3uNJqj4YckhcPUYkkN+yQiDnn3Te9NlaXu2c/n?=
 =?us-ascii?Q?Q9et8fFJf8eaJEPGPqQ89hRLzXoLrcqTcWso226aKp3/38+VXKY7U8zU4hVa?=
 =?us-ascii?Q?fdC7IfEQfsI61kuYIGdikqz4yfhEbGp+4F0xGHYlJVOdF5wzPYPkf4k52zB0?=
 =?us-ascii?Q?dnAEZ5TgTNju4ml/HsJ1qDzAeDLmpNLHa3CHTRAd5yhOnYq2rVEbeaT75BUq?=
 =?us-ascii?Q?6VjC4koErgvfdZOlxU6fiiKzW0gc3v1NLA7Ay3RESY8ppQMBlUXYamDLOs6Y?=
 =?us-ascii?Q?W7lT6m/7VqXnrhRkY8lYN73H4quXpUDAqrII5EnIAw4rvRGL/NNLPFMJZAIu?=
 =?us-ascii?Q?uJKu8TdHRnYDEYpGBfWLORDZgJAYIIWvFyo26jXz7Nz08hCVZDT+7UEGmcGO?=
 =?us-ascii?Q?2jOBylAGdEdQENat62+QN4IyDlmKBZEDkNdAuLxLx4Fm1OXvTRFmKL36DfQF?=
 =?us-ascii?Q?h348oHPsvmFKzJ3v3hQXNm/uhN3LGVNd8rJKXvfmBO/t0THW/OHTU2yS7IWH?=
 =?us-ascii?Q?L/hXE8hdwRtpYOA0AM2dcZnaH0czct/hF6dIX5mA5nkVKpBWUCtSRVKqvJFk?=
 =?us-ascii?Q?pzlK/yp/d5wQoi/5VH+l+2b3/t4Eeu1krSyD9qOrksZvi++fJKypGbiBKwLA?=
 =?us-ascii?Q?B+tXj8+y/1+3rITmVddl2iMbVmWNUEi9fpOdPAPM5ogAj43AyOSHgDb0OPJj?=
 =?us-ascii?Q?XvNk3eUvyQ+pWtFviLKpiKRb9jMAqJKX3rOY0pnt8b9o+2ftkX/KtemNZFC9?=
 =?us-ascii?Q?M1906MWX5Z8mtiKxEcCt4AzE5OidxkjDfPVq38++AETv21hII1Zp2R1sum/h?=
 =?us-ascii?Q?h21BrxLMz8exh+FVZAll5v4knJwDuWVb0OC44zsHLkLpxx8YZG7SX2CzDjx+?=
 =?us-ascii?Q?EYeLg2PuPdwCnC+6vWLvBunD9aMY11j9eTfNFtji0tB25PiGutvRG3aI1nTb?=
 =?us-ascii?Q?3wi2g8PkYg/+Z4voaC9kGOnssHBz1fpxZ/2SbOB5NXB1D9D5g0n6tUDHx+9Y?=
 =?us-ascii?Q?eAUyv3zWlm5fzMSb45dij5jUe3PYCrKUENCn1RqFXTq/GyMLG+Am6TTdHDwi?=
 =?us-ascii?Q?91waETopR94MNlPSyDme9Ec8AlzZyoO4egn9+HkvF0X4+71kAI/gieq9EHVV?=
 =?us-ascii?Q?C5Jl0H23hzDs5WFR8mXs3Kh71O3gftn9U+8op8G85u76DhCaV5DyRc7takq0?=
 =?us-ascii?Q?0EAj01VyVCSQwfWAUBF8hJpUPOqKTmX/yvPtGuRA40TkcVEWtV1rRCr0tQKc?=
 =?us-ascii?Q?A0wq3lv+iDoXJ1lFKqXx4vtOxkHBCpoHqVdhCHZwboPsgWEUuer3oc8qSZnO?=
 =?us-ascii?Q?OeaJWaKLmWcS+ekUZ7+EBiFgBlcw5tGbJHIZsH0OKmkhsiR0T1w1QsvExPmT?=
 =?us-ascii?Q?yK1bbkY0iUzlgBVh0HSt838jbxmJXD5W?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(52116014)(376014)(19092799006)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2aKuTLsKKRKvuhWICkr5RSFKUR62viHv+cMyrUcfwe7mBlWN5q0mKEk6zoYe?=
 =?us-ascii?Q?2VRgf9Rc7ExfKvdP/Q4m/krcL778x6ztHYVD8XiQf4H6YMmqDnX0+1/Rt87l?=
 =?us-ascii?Q?2am+zdIOWnZ226im0qX2adJueK7YD1BS7o/KllK4N3OOWWVdTCEuO/EgVnNO?=
 =?us-ascii?Q?CrWJckqsNRNzTKeW+REg1/5z+ZP3Tmtd1ynDZGHjT24Lcl0YwMhnYhebymMB?=
 =?us-ascii?Q?iip10prUpIkRLN/A07AQlp2a3gWrQyRcYRkNjk/TpXUytpAzchq6rwfgJOUR?=
 =?us-ascii?Q?HYgEePCLTEnp+J+UqV4Ij/JikGKwTS5Qtx7AfJRUGG+n7QeuBWC0VlkJV3Xq?=
 =?us-ascii?Q?fEGeHQYMZMfs2+7JqqeFfThz8dacoOobmR+D3BufE1kUV5WolTApPuzgNUgv?=
 =?us-ascii?Q?yoIuYAe0gAS93MGf7WtHAyspS6tKDZ0af9Y75L0Ss6PW4mk3rIG12+ir2Jmc?=
 =?us-ascii?Q?DwOToGUq3wQrTXuOleoRapjSrvXuf9c2k6z/BVM3lt1VMuNsn9ncHVyjIzSo?=
 =?us-ascii?Q?8uTqnPIv/71G6Fn+DyIVgbEIm1aeXmmTM9cCq21QdjJDfZP5NZw1xBHhHAdy?=
 =?us-ascii?Q?8JIieecvIsVuYVAoNhg0jWp4rtPAM/7UDy8wwntzLi8NT4W5sR0nJ+RgXP8l?=
 =?us-ascii?Q?cjcGr2cLPBaAtoKG/uGYKMAJB//DBH+8WC9XJ2kaiwXXF/XVkk/ys4HlO61V?=
 =?us-ascii?Q?+sV9y/OtyMr2ilwEVsuDER5b/iuiuIGwFDHmnmADhXpx5EUFtaKnUHgHICq8?=
 =?us-ascii?Q?tM0CnygnK6RWH+uDK9CaQfOHV7c9ER1ZsNIv+NLTdc4m+R0bWMzGfAmr7qie?=
 =?us-ascii?Q?jQv319ulq9iFhpJXZxeIdw8o0dK6TCwoFPajABrZYhEpU/vmgn5qJx4t3arB?=
 =?us-ascii?Q?0tqcMY736KRKl9WS0SMeNhnIs5roZlT7kf3912Avns0dFvv9CveuvYarWPQI?=
 =?us-ascii?Q?gXv/PRx7xb3/20FUoOZc82K0vvyd3JhZWTLjhn8uokYjPjd4khMT7iQUIF4D?=
 =?us-ascii?Q?zpkidC3OsXkPTE2GZpnmhA9wbr4tnt3c8pBdRbX+zrBBsfdqSCjXO6pVC6IO?=
 =?us-ascii?Q?YDsxHNXPbmFpIGWFOn292xaZxru7ZUAOSQNFwcwGn3nyE81+2xy0g7I0zpIG?=
 =?us-ascii?Q?hWiZ8QVEx1OOLsh9XbvceS6mo+XOWUGsYhXkM/iG/XUNVOqfJEW/+ynU8oCp?=
 =?us-ascii?Q?OpA9ntLf/Ih+3PiKtADlzZxcm1/UK5vYr2eoe2r2lDnZCj2KMoTevG9EU0f9?=
 =?us-ascii?Q?HVqQRUch/R3iPTNvwG73tC1/MSI3muz4YUIZam6O7OrbA+udVnLYHsQjRTdX?=
 =?us-ascii?Q?aYGQQ92AcL4pfXH6FPpRu7cxX47mUgdZ73nsVcX2XhFDH2LZ0vpw5KdPPRQ+?=
 =?us-ascii?Q?IFcwuZx1toCNCAC/fTMYLL5j/jdpGj83g1fFzwGrInt6H614vO/1Mg7x3k2y?=
 =?us-ascii?Q?uM/oYrvUL5uIoSoc2dWQTIUhhsumpdAPRvfIX+bXY3Dzoby/V2zpNtqDPgmD?=
 =?us-ascii?Q?tMiZzsG6S00r1ORBUm278iSNrauCs/SKVDZOBipqaxUaQs5s8XM0rO/BwPFi?=
 =?us-ascii?Q?9crdnX7muMp68QJG7oAUI0lTkUxrHjkqbDJDIB/YsjhCu6oYLHNQp2b1qpoB?=
 =?us-ascii?Q?fa7Nd5ZqVBDy6nbhNJNgs64=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5e7c7f6b-6149-43f7-b0cf-08de1dedfc08
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Nov 2025 11:08:31.2999
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Hg6cPvuWmCcG2jU2vDvr8ZsrjDOjlzh/Qj0gYURC2iK1KR5UUqw3FT+O94MGt+QgjaxfgRnIRFqLtjIqFrj0WQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9505

The control flow in rtl8211f_config_init() has some pitfalls which were
probably unintended. Specifically it has an early return:

	switch (phydev->interface) {
	...
	default: /* the rest of the modes imply leaving delay as is. */
		return 0;
	}

which exits the entire config_init() function. This means it also skips
doing things such as disabling CLKOUT or disabling PHY-mode EEE.

For the RTL8211FS, which uses PHY_INTERFACE_MODE_SGMII, this might be a
problem. However, I don't know that it is, so there is no Fixes: tag.
The issue was observed through code inspection.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
v1->v2: patch is new

 drivers/net/phy/realtek/realtek_main.c | 65 +++++++++++++++-----------
 1 file changed, 39 insertions(+), 26 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 417f9a88aab6..896351022682 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -587,22 +587,11 @@ static int rtl8211c_config_init(struct phy_device *phydev)
 			    CTL1000_ENABLE_MASTER | CTL1000_AS_MASTER);
 }
 
-static int rtl8211f_config_init(struct phy_device *phydev)
+static int rtl8211f_config_rgmii_delay(struct phy_device *phydev)
 {
-	struct rtl821x_priv *priv = phydev->priv;
-	struct device *dev = &phydev->mdio.dev;
 	u16 val_txdly, val_rxdly;
 	int ret;
 
-	ret = phy_modify_paged_changed(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1,
-				       RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF,
-				       priv->phycr1);
-	if (ret < 0) {
-		dev_err(dev, "aldps mode  configuration failed: %pe\n",
-			ERR_PTR(ret));
-		return ret;
-	}
-
 	switch (phydev->interface) {
 	case PHY_INTERFACE_MODE_RGMII:
 		val_txdly = 0;
@@ -632,34 +621,58 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 				       RTL8211F_TXCR, RTL8211F_TX_DELAY,
 				       val_txdly);
 	if (ret < 0) {
-		dev_err(dev, "Failed to update the TX delay register\n");
+		phydev_err(phydev, "Failed to update the TX delay register: %pe\n",
+			   ERR_PTR(ret));
 		return ret;
 	} else if (ret) {
-		dev_dbg(dev,
-			"%s 2ns TX delay (and changing the value from pin-strapping RXD1 or the bootloader)\n",
-			str_enable_disable(val_txdly));
+		phydev_dbg(phydev,
+			   "%s 2ns TX delay (and changing the value from pin-strapping RXD1 or the bootloader)\n",
+			   str_enable_disable(val_txdly));
 	} else {
-		dev_dbg(dev,
-			"2ns TX delay was already %s (by pin-strapping RXD1 or bootloader configuration)\n",
-			str_enabled_disabled(val_txdly));
+		phydev_dbg(phydev,
+			   "2ns TX delay was already %s (by pin-strapping RXD1 or bootloader configuration)\n",
+			   str_enabled_disabled(val_txdly));
 	}
 
 	ret = phy_modify_paged_changed(phydev, RTL8211F_RGMII_PAGE,
 				       RTL8211F_RXCR, RTL8211F_RX_DELAY,
 				       val_rxdly);
 	if (ret < 0) {
-		dev_err(dev, "Failed to update the RX delay register\n");
+		phydev_err(phydev, "Failed to update the RX delay register: %pe\n",
+			   ERR_PTR(ret));
 		return ret;
 	} else if (ret) {
-		dev_dbg(dev,
-			"%s 2ns RX delay (and changing the value from pin-strapping RXD0 or the bootloader)\n",
-			str_enable_disable(val_rxdly));
+		phydev_dbg(phydev,
+			   "%s 2ns RX delay (and changing the value from pin-strapping RXD0 or the bootloader)\n",
+			   str_enable_disable(val_rxdly));
 	} else {
-		dev_dbg(dev,
-			"2ns RX delay was already %s (by pin-strapping RXD0 or bootloader configuration)\n",
-			str_enabled_disabled(val_rxdly));
+		phydev_dbg(phydev,
+			   "2ns RX delay was already %s (by pin-strapping RXD0 or bootloader configuration)\n",
+			   str_enabled_disabled(val_rxdly));
 	}
 
+	return 0;
+}
+
+static int rtl8211f_config_init(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+	struct device *dev = &phydev->mdio.dev;
+	int ret;
+
+	ret = phy_modify_paged_changed(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR1,
+				       RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF,
+				       priv->phycr1);
+	if (ret < 0) {
+		dev_err(dev, "aldps mode  configuration failed: %pe\n",
+			ERR_PTR(ret));
+		return ret;
+	}
+
+	ret = rtl8211f_config_rgmii_delay(phydev);
+	if (ret)
+		return ret;
+
 	if (!priv->has_phycr2)
 		return 0;
 
-- 
2.34.1



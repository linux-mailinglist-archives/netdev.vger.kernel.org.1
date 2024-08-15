Return-Path: <netdev+bounces-118724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D49895292A
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 08:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42856285F2F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 06:06:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34F2817921D;
	Thu, 15 Aug 2024 06:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h0MAQ5FI"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010063.outbound.protection.outlook.com [52.101.69.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CFA176ABB;
	Thu, 15 Aug 2024 06:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723701948; cv=fail; b=HG9mmp7vTmnbO4FttBTqYTAkkwPn4XY4+lSDeS1rOlR7UtHN1wVQF/dwkN3W/bZ4l72OwXykGWhBm/qrMeiTV4jGhTPmdIvFR/G3jOs012O6CjDpGabO0Aned+PjZ/5czIMZB6yyc+Q6XxASiO4/dzdZgOR9uzWWLHStARFe2Go=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723701948; c=relaxed/simple;
	bh=6r2W278wJ9l92J+rk/B7agUB00MNVdyhhOrv6AJ6ad0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Aic5X7aLDZNnKtJsZzBFQOthwMRDhKf6I1xSsLkJ1HPamgosuPIjVDO5W4ZJCsdXEyggsYrD4I928X8D1malr8UzfjS5kVjNn9M/GQd+3aGiyg4Zh8WVEpWcfnpJniDXGNLhD4ssfeD0crnryo5w3z275shyg2dy+w1XbYlsc4Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h0MAQ5FI; arc=fail smtp.client-ip=52.101.69.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bJ+JXlTHSHPXtmIgGMK6N/+dAj1uY8ypAepjF2UZptay+V+CPp98VB+VGzhAHtKwHz0W1TPrcpsj1HaETf8T6+CDe32BDLV6/Tz3W0h6oGMVTPktvGQi9pHAg22Qa8vCB6wDlKxT3v+DhGyxzvHjxgpRmy0rJetPK1poNoE8IaZxtFjKxHhptjpVOqn8U17sZaaIjOmWCjBILRfSOKSU7395xNXIL7f78CoJt7VrWD1wzNYO82vW6m++/fizJTfLIb7tkQQdKCXhMXANm0mDxipPA8TgAaH+IPv04CyU0pkPKrTVGhJIWuk0jRrSBUq86bprxcJQ6FCb1+XXlVEYPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xBlYMES8Hqud9QFPNzLbO95lEsOpZl8fQtWDFnRnYXw=;
 b=yXi0T0nOPMs8Kg0l9B3HMMRm3br/BklR2NtqQMso9WTR077vUJrXQUUDHsXg0E0TuAzaL13v5WMRFCHfV8ivmITXTI5tseRZzEz4uMXHCTNitYXWWxRSGcm85mX3og8nKcWSfT/DYDmvdFTPekRcxJBJjW13xDGow0yGe/C+2R7IIT8sW+hJrzixAyArukunOrWfcU0aovlIUnLpdETOKVAjZAlOO212Sh8mdYxm4svLyyGm1exZlxJ2YKoG1OKppJFbK5+GbiLOOS5Z8LUO7L6HzwJKZVYhJC7nQp/yRLNM2fdmptsaBUuUGZL4UvPiOr76bzOkjeTqG3zN9A5a4A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xBlYMES8Hqud9QFPNzLbO95lEsOpZl8fQtWDFnRnYXw=;
 b=h0MAQ5FImYW/tpKLUsW26AGIjDWy6gUagyhKmntquNuhQgN0ETz6PlblRpsk0zh7loGEQoMAVpBIRIn9iMJZU9MwYjURJ998qd3IFkDE+w7z5mx0fV7bRvv1Pb5PlHQLMeAphqpLflrxx0wzjhG3x4jNMPgHcJlaHUQwNNKXZMXQ8wTicdlikDEtXuzkFJiNJNi2Fw6ipzC/LxsM8BWi6DAOtEmNWef5JMUFYWcllpRqNNBRKOvMbEn29gn/DI8XlclOV4C06gC9jCKR+foLYtCMh3l6bso2wTngZ/eF8qG6tSWQMeOQ2mBZdVXFwEAbUuu6Pv0XoKV0WZZux405nA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10805.eurprd04.prod.outlook.com (2603:10a6:800:25f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.18; Thu, 15 Aug
 2024 06:05:43 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7875.016; Thu, 15 Aug 2024
 06:05:43 +0000
From: Wei Fang <wei.fang@nxp.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	andrew@lunn.ch,
	f.fainelli@gmail.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	andrei.botila@oss.nxp.com
Cc: netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 2/3] net: phy: tja11xx: replace "nxp,rmii-refclk-in" with "nxp,reverse-mode"
Date: Thu, 15 Aug 2024 13:51:25 +0800
Message-Id: <20240815055126.137437-3-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240815055126.137437-1-wei.fang@nxp.com>
References: <20240815055126.137437-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0097.apcprd02.prod.outlook.com
 (2603:1096:4:92::13) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|VI0PR04MB10805:EE_
X-MS-Office365-Filtering-Correlation-Id: c15cda80-85da-4171-d815-08dcbcf04c06
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|376014|7416014|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Qpz2gq6KzowoLK2BRM3/tnUMz7z0l7itmdfmbqNz+FaCZu6OEdQnbaERVWXb?=
 =?us-ascii?Q?xSlzepPRGpVclGc6dqzJ67xUb0bBYb8wgtgg+Nqocb6H8kSoX/lsuC61cJEq?=
 =?us-ascii?Q?2+xwI9czsWKkHH7kCAT0H5Yl7ZIDBZEF4ba27ZGylcxJ9EFERMYP0teVQDSN?=
 =?us-ascii?Q?E5Rp8HfIBcDCURgmcho3y35+lTwqpbnbgcxwYFLKL4oQg9BZGWVnMHV0vu0I?=
 =?us-ascii?Q?Es1El42UHahEOTF4jGA2M+ooCDyKWJW7SGDwB3zH8Fpsd5D4UmZ07Z6tPVGN?=
 =?us-ascii?Q?C95lBEEm7/GzSZSaMKVEAkcOqRZnBQ1vJGgGgAxh+hDHF5/TLPj0Pp//b0W8?=
 =?us-ascii?Q?f4YMSomiZjIzn8afaagh2fK3IvjnZXindUgzCBl1VioRbF/ePCILQ4y02xfv?=
 =?us-ascii?Q?gojFzrO13EoSEtmMEfq8FynVPnKQSQqfAgsLajimybtAnUvwUOBcmDAgc3rt?=
 =?us-ascii?Q?Orn76kdufqCJYgJLE56jp/iRIJqsbyEPcZj3O+i1nHGuB9JFQcjR3739D12W?=
 =?us-ascii?Q?1RocBV0BUGsPsJPYdi/DxRYBMyO5a7eBTcVWx+k/M5k0EUZSpSTAAEBFCzLl?=
 =?us-ascii?Q?rPGLGx6V9Er4CRrXuwszpE8UHY5W5GqxUOeA4AcAquLkMM8cpEkAvFbfZCC0?=
 =?us-ascii?Q?HgnIbCqMFuA2EPXlL6thM135aKYlrhiTl6PPKBrQG/1NoRaSUMePw6WwcNoj?=
 =?us-ascii?Q?r2twW+dWX4xd9igD5M/gGxo2xt4l+HRwWdVajLPTSVZSU9/0nIBlEBRFwhHl?=
 =?us-ascii?Q?9SiHx0922cr0yaqQV9b+VhKchlEauFvHheXt6tG54xAXsmLjKGsD5gBtsERH?=
 =?us-ascii?Q?1DS3lUQi0TiRLlq0+kZOSThnTMyYRJiMQ5Xu1Hghzi9dEROKU1+TMdqC0rOu?=
 =?us-ascii?Q?CNRSWo2KcGrIIwUdVttPGd3yrbkfEw0h6YFkBrLVMLhZq5kySuS299BIubkb?=
 =?us-ascii?Q?FzEf4l/cS6JaD8GmzKGu9W9RAVGRdkn2N5Q0Oxpnc3MeWG/kPP/vGWyGgLJ3?=
 =?us-ascii?Q?28z10/ib6zKPHBMgooZsI7YqB+ng3p4b4BYYWGr5fQF/6o2dt0wMdaOyWZ+T?=
 =?us-ascii?Q?yj8wlGDe7VH+felHYm+Nv6egYzqwv4KFMla1qFkWW8ziJ830VHYsB/GrjMCd?=
 =?us-ascii?Q?m+WxF5aQSfd62+tFuEtRclo0glro/sDECo0w7vR6dS4Vd/YT1llXUz2kKURT?=
 =?us-ascii?Q?Ovuv7HePX0K5wQfOdpwc7cU8Jr1pH9tSE+sFrZu5eh33p9B8tI0NQ1XBNkCZ?=
 =?us-ascii?Q?afC6ZACOB/FoRYZdS3PJxp3rv83zXHEYjQEZuaf09UvR66LxSiQMdejodt4H?=
 =?us-ascii?Q?w5FU0CmCabCWxE8vrUwePmcXBY1IARABXp8bPjtxWiGsn7nomMOoBMU3TnSn?=
 =?us-ascii?Q?6dHzsge3hr/IRpQj4Af/ScE4tTThBoJgkWzyrH84+XAHSzElBgHNdCzsljam?=
 =?us-ascii?Q?dgxgQ6n977w=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(376014)(7416014)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?cljGkYwDilbbs8cbVS8QRHrDzdMpQI9ZYbRF5ZieVkhwwLtcpyKx4XGW/jnt?=
 =?us-ascii?Q?xd1jSCiZtixek0Ur4bwWpISS1toX6K7p50l7helzhfWYgwwA7X20SHPmQQYw?=
 =?us-ascii?Q?Pd2x80h9zvyqShG5b8JoF6vH814T0Nw9zTzGTnl1hIn8P4CyRBzRjuWaYATD?=
 =?us-ascii?Q?m/IM0W3ujaltDCEu2LQQZYWqVGOHKM5pYuhIRQNRTZeyaulIjFq1zrVDYFEx?=
 =?us-ascii?Q?W434MGY4XZ2W+1hCOaKTLWbrAH1J8vSBfcMsq50Oj4UGTeaPsBfUkmOujmCt?=
 =?us-ascii?Q?ZKureVMVkHTM4LGr3ADShcs9AvZHJqqGodNr2Y/X7Q+eSM6O8p3wKubyY9FK?=
 =?us-ascii?Q?lQ4Mv2q2rEt97MlbjsLQvZUhqvM9rI+syZt++2yCJKbBCYIA2U+GbMKHqk+3?=
 =?us-ascii?Q?ur/nW6zPNCzRgkSX6nWUoChuK9j2yxaLwr8Zv07v2kJQ4yrqtdXTYbAtVFek?=
 =?us-ascii?Q?SZRkKmvMQba32lq0DEs2sU9MP9DiKM/JJS/WSksdd/1r+oFXBBnyGNIJ0y7+?=
 =?us-ascii?Q?9hjfUD9zTF9tKEJsbRXHrQkvQ5+vsZ+3HWV/rIHelExToqZBLUXmbBPnpxp6?=
 =?us-ascii?Q?aouy5O7ZMPvht6LxeHGqvNf8syZrAMG570aQ6BnyYOTUMK5YutqeflxpXk89?=
 =?us-ascii?Q?xETfNFodtOCiCEkV6Wc19c1UyQ9gbB8FSM8FUek6PAHX5IFvN83k9d+zKDum?=
 =?us-ascii?Q?SzFTgDAgRtVBxP2eia5WN9X75srd8mOA1+wy3S32v600ak4PDg6gxDs3Y9Mr?=
 =?us-ascii?Q?4vIs+IbSB13rD0HEtrhS+t9kTwO8a2SZ+FyPqvOpl+iuSyHGV099//ltSb4t?=
 =?us-ascii?Q?wr0LbPYwlp9gfqTj0p1mTsfNn0ORQzy2kW1jnWftUFuM/Q970SV2JbmOStth?=
 =?us-ascii?Q?j8R+qVGemkFyx5U06nK5lkBdhNPKlloRZL3Hs4USiaaN2tOR/kH0pImDqBoe?=
 =?us-ascii?Q?rff2WyMPzuN4BuF59OcG4S/Aztyq+mKhNWFObk+lVGwSvGUlX4NG2WZzee8c?=
 =?us-ascii?Q?EL7ZtoXHeEpGrvIjiPGI8y8JcJ5uimASYsXHKPYL9NM4VAO8sKDkrrJWeIli?=
 =?us-ascii?Q?FvNwx0ClGOAH0KAhzhxz8uHsD+4lJDFkPPjogi4Y08oTVckeuR5K/ZtY5aQe?=
 =?us-ascii?Q?rqTararVliaUqaRhaeYjfJ6L6/W9BPpT6C+NZrzUJE1hwfGg/OhLO4JtTy8M?=
 =?us-ascii?Q?/51hygCymHfMUKCRKx9TSinjNY1wLEt5eYVBInDzWfpSuswj/hpcHBIta4Sa?=
 =?us-ascii?Q?k+iDLemB0vHvBzIwSlVh06H/eYgRstVR+ni1AIub9meQfl6qMawOlbDidJ/y?=
 =?us-ascii?Q?vwWxcIm/waulqWt9mQztPnv/+LgCrDfajrK7RhQt7YBkvZVTb/MK+qQ7QgZt?=
 =?us-ascii?Q?fxjH6TXra/VAX9mPfbINVUwPZmnLOXk3mjREMNimpNsX7WBTX23MrNCZ9XIl?=
 =?us-ascii?Q?F2U7yw7xWgtS71rCmYssIqPTky51i+ejrPAKf+jGcGTtriffJLpF7t2wbh4w?=
 =?us-ascii?Q?zUG4OHFSsBnE1GrUqg+AKMALN2tYt6sQFMd2EjJx9+UD5pThmOUrCILv0qB6?=
 =?us-ascii?Q?14v8RpaTUedX6I5gMbqEJAyFXk4yf+se5GlLM2F8?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c15cda80-85da-4171-d815-08dcbcf04c06
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2024 06:05:43.5578
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xl43uktSJnhZGZNAJuL6DcTz5NqYiij+EU6YWV6X8YHuCc85GEOQsm8bz2ep1zOXQAF7Gnf0IjD79SCxaPJxjg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10805

As the new property "nxp,reverse-mode" is added to instead of the
"nxp,rmii-refclk-in" property, so replace the "nxp,rmii-refclk-in"
property used in the driver with the "nxp,reverse-mode" property
and make slight modifications.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
 drivers/net/phy/nxp-tja11xx.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/phy/nxp-tja11xx.c b/drivers/net/phy/nxp-tja11xx.c
index 2c263ae44b4f..a3721f91689b 100644
--- a/drivers/net/phy/nxp-tja11xx.c
+++ b/drivers/net/phy/nxp-tja11xx.c
@@ -78,8 +78,7 @@
 #define MII_COMMCFG			27
 #define MII_COMMCFG_AUTO_OP		BIT(15)
 
-/* Configure REF_CLK as input in RMII mode */
-#define TJA110X_RMII_MODE_REFCLK_IN       BIT(0)
+#define TJA11XX_REVERSE_MODE		BIT(0)
 
 struct tja11xx_priv {
 	char		*hwmon_name;
@@ -274,10 +273,10 @@ static int tja11xx_get_interface_mode(struct phy_device *phydev)
 		mii_mode = MII_CFG1_REVMII_MODE;
 		break;
 	case PHY_INTERFACE_MODE_RMII:
-		if (priv->flags & TJA110X_RMII_MODE_REFCLK_IN)
-			mii_mode = MII_CFG1_RMII_MODE_REFCLK_IN;
-		else
+		if (priv->flags & TJA11XX_REVERSE_MODE)
 			mii_mode = MII_CFG1_RMII_MODE_REFCLK_OUT;
+		else
+			mii_mode = MII_CFG1_RMII_MODE_REFCLK_IN;
 		break;
 	default:
 		return -EINVAL;
@@ -517,8 +516,8 @@ static int tja11xx_parse_dt(struct phy_device *phydev)
 	if (!IS_ENABLED(CONFIG_OF_MDIO))
 		return 0;
 
-	if (of_property_read_bool(node, "nxp,rmii-refclk-in"))
-		priv->flags |= TJA110X_RMII_MODE_REFCLK_IN;
+	if (of_property_read_bool(node, "nxp,reverse-mode"))
+		priv->flags |= TJA11XX_REVERSE_MODE;
 
 	return 0;
 }
-- 
2.34.1



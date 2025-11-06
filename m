Return-Path: <netdev+bounces-236268-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5A50C3A7DD
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 642BD421B6D
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:11:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABF130CD89;
	Thu,  6 Nov 2025 11:11:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dOtegr+0"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010061.outbound.protection.outlook.com [52.101.84.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 606B72E973A
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427481; cv=fail; b=GvwV3qrhjDHZJdbcNyiYNAfKFuh4GXrNx/ZMJqsGroGgldSnm5uijFe+y+0LBJm2Bnmb4QlLCr5pIpGStGBccOl6lSOaQnnY75bAHwJ6YlgeWSgio9wf7YVE6EfjRXlRm5PCVSqaujZ4YdExoXdRgpxDDaNXvps9NthISxDakBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427481; c=relaxed/simple;
	bh=9f7euKtrvVarRlZ8LS0q83r8qIwaNoSV+TWJGO5eIOE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZtDl3i30+pwMGKOXBtrnS0z8lDP9OWKinNU9pJPo3UubT8hKW+o+bL4sGDlOdNLR9Ua9+vOQSYiARA2FKPf0yxxo0WcBVli7jaR6F+vjRp1obqJU9oTHGNGJj91lYAF13uzvxXS3dkmxae19Ek5IqD/qDCyLWqGoaEfqxBHiLpA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dOtegr+0; arc=fail smtp.client-ip=52.101.84.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mXjV3K0U7k1UevaqsFBhWWUee6sBKji0+lnttDksoY8nk/9GnTzXiu+dzFy7Jc1Ooopu4gwC9UXT+sLEb49d/8uF9voZGjj8ybsy//TPKoikvB+M0v6eUBZ43NE3neYZWOWYMfyK6Nbodrc6qExbL7aaMS+4JQ8in6UYzBigdyMoPk8WtmorMa5ZIcTQc3ZgFDRNcRwjlns/luIw2iNteHuZdLJffkj9SkvrQy5AleoWvlrGDTW8ZQ4s8J8NcMVf33skKZ2MT1r+IyRCgQ6tJHV8WnwWAKP0HdBXbE2bh8S3eL5WTnDxnmVmdX4FCsI3Y8/0QQKFZVpMYdzbTg13TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2QhrJ/yDQ6e33zzpW4tgHd4/ABRPzgz7RUlzu96Qs7g=;
 b=i60XhzcJ+a5W1ifhKYsOov9p8XR5ryQXPPzM+vs88AK6Yu+bkYNvBMy7ocjJdmfx4cL2KZm3uKwKKkYYU33pETbHUASgJiJt+ZJ4PXdwD5RW+9VU/F1n9iHbkhBBxfFGVKxK1y0wtij/qqAci7Bmz0HnTgpXFBkFxldHgjvTcDJOWUyradZAfSA8kI0ED5MnLAb5uIbSK9r9XR80drR6+pRGhcf5LCfZIH0CFl+PpbKF/TSqlI+95a6Lbe5xKMfUq8APn0aRSge1EfepTNH03XO5iyVwAdB5Xyj9io2V5fMTyjpu+98QSA0yEdzP0AhgGmySSjqFkcfdTLTQGQIaOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2QhrJ/yDQ6e33zzpW4tgHd4/ABRPzgz7RUlzu96Qs7g=;
 b=dOtegr+0oWjYPli9MSVrSsflErth2yWURKrCxLx91f2hpYPf69asyh7ML9oi0h0/rakJ+JX+Y4QdENLiNBPqLmILRcter2XejU2RNJLdFxM0hAj41+laLW0D6t5CYy3kbt2qo/O1YRjGpwOSOePPG5JYd1UMAPD86g/J+p5kAbRl1oIXdI2I1Ji2aKmsp4ztNHH5SZPkZAjX3KRT02jenmjcuCWTeg1CfjS4h+lEP/sth9E4o7L4HCZt7LK9GOdcokcZ9hl0Vi2WBjrKzuSiytRpjsSPvDSc5rbwETGb/0NivQnc0PpGrbON2Q1DOZ9TkghBkCJL1GsZE9atIEiW1w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM7PR04MB6872.eurprd04.prod.outlook.com (2603:10a6:20b:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 11:11:15 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 11:11:15 +0000
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
Subject: [PATCH net-next 1/3] net: phy: realtek: eliminate priv->phycr2 variable
Date: Thu,  6 Nov 2025 13:10:01 +0200
Message-Id: <20251106111003.37023-2-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251106111003.37023-1-vladimir.oltean@nxp.com>
References: <20251106111003.37023-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AS4P250CA0007.EURP250.PROD.OUTLOOK.COM
 (2603:10a6:20b:5df::11) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|AM7PR04MB6872:EE_
X-MS-Office365-Filtering-Correlation-Id: 2b2e86ef-e4db-453e-0638-08de1d253388
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|19092799006|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?Vp1NprLIjz/zl6w0YZzVI3pBuHJI7QR73ul5k3WBBKK+7BurTGk28qUkj9hR?=
 =?us-ascii?Q?dH/ZUVQMAgcPt28jzZ7jFe71dnKt3nKMQzxMQy8PvTM3Rhvd6vAfcpOzk5Sx?=
 =?us-ascii?Q?20YAsJVdQ2LCN2PYKfbxo0x9xx2qyF7Tew8EJmQEeRVaeIsr3LUyQjwITUvR?=
 =?us-ascii?Q?F8/oc2xPbiKaAsoru2QPPcacPbvo35nuaxVg1256IC79viebrw2aJjH8a627?=
 =?us-ascii?Q?QHZk9i1Qz9RqKAa0IDIxGTzqFyXqOXbhieb1ybrSSM6C09KfJWvpF/Y7YisI?=
 =?us-ascii?Q?HTIg/rnG2FTaTjRp4vCGg5/XghT4AZdWQJ7S3l5NZs6W6Vm4NJTn8+KBcFY+?=
 =?us-ascii?Q?RtzlED1NiFlPyF1YcnBrfr3oR+5zfW5DMrbLJNz3hm2Fw0u/IGOAbYc7Y4JR?=
 =?us-ascii?Q?5ni3x4f8K7QGFrVivvyUaRJoCVFfc8RrfkSGXur9C7q+bKYF2ZHAiCY+xSzN?=
 =?us-ascii?Q?nbj66hreCzxvxyoEGCba0/iEA/iClUXnX8L1Cwaaq/3tXEAnb4HQDiZl6jEA?=
 =?us-ascii?Q?aKxF5HgcDliV0TQzgldYE15JnlNUrHXDy7gFTjA4U+NFjy2b9gn24OrrVzcM?=
 =?us-ascii?Q?goNJ1T2q3Y3vYBJxl5tsHpm8DUnJYjoJg6oYI2qXW15IKUoLKhqK6TL/YLIu?=
 =?us-ascii?Q?hSxSuMOzwFjGQtHCzmUajKb6c7jdYT4AinwjfOWG6D4g9VWRLJE/D/qwQBKL?=
 =?us-ascii?Q?VT2yPU8k2/qmZ/OTsba52RAZPc/bPyMpQb4rdUVsUgywPiwvwZm0bKY/bpbM?=
 =?us-ascii?Q?5X2IzM0ZHtSmChQIAuyxS5v8h+6di7G+IJ6DLgCiUfTLBB8pHjMYchCRI8fN?=
 =?us-ascii?Q?/L0elziUyHdMmx5Ef+m0IWOIsbjdaNlcS+H+OOEivIc+y7UO5897xYJ2oc7q?=
 =?us-ascii?Q?v3SXa8ZY6ToPHz2kOhxrfDgPwdgHiIE7QYX5gPSH4FwqaqJLfOmP2j20M57S?=
 =?us-ascii?Q?v0amliXSpw+8XIfXafZUCjD+BWo5+O4MB/lQq9AiTD+9e2m17L3cqvJZ7jZ+?=
 =?us-ascii?Q?LS+JZDaeTH1Ah1GP5/lCYnUWq0gCCFw0G7NlkAjJfUGF8Ap5Xqnvb0ziur7y?=
 =?us-ascii?Q?ZdkubcD+WOQJ8BeMkOrBCcUx7RLLL6zRajFaR7aMnu8MyypOOIFDWUHsXUFw?=
 =?us-ascii?Q?m6RVL18LLD19zEOSE5Vejg1vu0oCaG5Z0evkIIncqjAcL74K52Ir9Vg1rLNc?=
 =?us-ascii?Q?pbHlJ3eZLsaqLBqkABZNJtQIOtWJAYHfgwXsYYDK6+PZED5Dtee+HzvWlvw3?=
 =?us-ascii?Q?7MV2a2POHoxwilGWvUT//95syqsVeki6SrgElgl+SZEKnpMA2Gi8nEUeZcOG?=
 =?us-ascii?Q?fXHiLsB08Mxoo5b0hZHqv9lAcsmHqv1hYCbCEoQTdl/jJlnYwOLTIHPPFYXe?=
 =?us-ascii?Q?lHXHv0ObI/6NSVGWHiO9UFbUoN4XQPgwGemjzK5DlaOwamv1P0PheaJjQr+e?=
 =?us-ascii?Q?kCbwYu/8EAYWjxUTdbokAwxSsnw9atBq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?9w3wz1LrrnMFV4gmjqbA58VM2qFGpEHgR3hxxF81BX+VcXWMuExcPddRBXds?=
 =?us-ascii?Q?qWCLX1Bl23weoOGPDchZPk4fR8ERoOHvEm1lIwARYz0DaC1fjBOzbKjm2HVF?=
 =?us-ascii?Q?EAPtOyDQBL/1r8/BTIYkh3sEKfshL9HD289N/rN/0bbUNWbrI9ydjg0lblul?=
 =?us-ascii?Q?Ci4GLAqy4iSncT4eGPbjWmZxQmaPLp8PAsipEuIQzErize2YK5KHHLxbxmld?=
 =?us-ascii?Q?j+AECDH5+DgKcS+KA1AHgKCU8AtJsPHTDEQBQwJPIvp0R9uoO92RDuj9RRGD?=
 =?us-ascii?Q?uNAhdEmJ5wr45aXAD9OsqpbvAePoU0raasFedcjteq4nWVXnxup7K5ocrNHq?=
 =?us-ascii?Q?6qsgH3QVHrTEBBPPSov0o7sdACG2E8FZMlsomocNzEdkabkKNdcP3SH7raOr?=
 =?us-ascii?Q?OC5lR7YK+eG6eD4tzJ2xhQUgObbODu09yXndbx9luQmXVJ8b7mJTXbTN28wd?=
 =?us-ascii?Q?guFlsixIKFfIPxpV4DCq4muQovow3Q1kaHva3GIYy+lFndn5lGB6PHQk1dsJ?=
 =?us-ascii?Q?fftrB48cy6spM1ksLpEbHSnl497YCsuUXczEVg5ftws0e4xrDAvtNkdH1W4P?=
 =?us-ascii?Q?TkRmthPciOOAAGCdzTkzoT0awr5epx3nbHMZ3Br8yaJ25TB+vQzPwge/WLVn?=
 =?us-ascii?Q?FJ4wnFii8PJ1npfIgU8yTZE3oY0LrGAJJCIB20/pNCJRsJ1LYfCi+HjRgpHM?=
 =?us-ascii?Q?K/H0/ZkghQ7KbUMoGn0lx8mzhd6nGJJ43AiW5VraDsLiRif72hnooVrojl38?=
 =?us-ascii?Q?Ovf1oRU59Z/E5aXQZroUM2p+3bQq2Tzs19ii2wSx0FhQ6ZL9PnHmdm77RDei?=
 =?us-ascii?Q?a1iA6wNMKs0QAQXOXiQhoz6qsMHvAO2vR7nBe04Mv97sxdkRE/EFmBAjQPna?=
 =?us-ascii?Q?t8BgN3Une0e+yXI3JgFjBT+t72S2pYVvqeKdIWe8NebaRU7YWmMVGdqU8e0p?=
 =?us-ascii?Q?cu8x9k/pBsj5+0SF/semCWczVWA3CJb3KDI0ArIbWhJGlGFIoSBlJmrrTIy6?=
 =?us-ascii?Q?U0DbiN/+4EbDBM9HUAP+UbmTYbUYrwdY8CDqwZaK9krFjtScRTrI13gWDf4U?=
 =?us-ascii?Q?NBtGvSVswQ2YFJP7FT0HmLoibbPvmtzUd7SrqSD2BBfyC+rPECHnVKOux1Up?=
 =?us-ascii?Q?JoKdkasOe7wXUXNgi/mtZmHHSvw5Z7CJrF6XbRS6NnpE5PRSufms/UqpBeBG?=
 =?us-ascii?Q?6XVYe/vCG00ELKo+nR0yH2FtKJ3Uf3ed/6l2K0lJB0TM+xAHJnqjU6P/eyId?=
 =?us-ascii?Q?iab0jVyUBt3qwm3xRyhnoD6ONZ93ABZQZykbcbUczqV+Vu4fGmu0bYwS0WK5?=
 =?us-ascii?Q?rpT+9hIhwfrn7X6evt7b7Gz+U2dTjX7t7mHfolWlrsoasZLzdv9n9EX2ITby?=
 =?us-ascii?Q?Y0ihURWT/Li+zC5LHF3elWpuudSdHU/5Bg1V3Hzifx9u9E23JDLHL0TK+1yJ?=
 =?us-ascii?Q?DRMOC/uCicR1QtJvzF6WcFvN4jiJgrnIejX+MwPqpxy5VMQMWGniwXq9aGDB?=
 =?us-ascii?Q?/nylLoliAo8qrNnCTsu+Iu2Rn+fnlw1CEJgIW4z7Owoe7Zq2u9sntUV3xZPQ?=
 =?us-ascii?Q?7jH2vyjbfYC1wf/XywawBpko3WuHJ7CTwTUKKrF99Iwp2lWaXgB8kvIgEkPs?=
 =?us-ascii?Q?2SyGLpBKAF6QPOUvHiadzp0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2b2e86ef-e4db-453e-0638-08de1d253388
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 11:11:15.0760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LN8tuXQNTQCCsZbL+Ccwrtbb2YizKTo6epw27bPFCCqZns/sETi3aZiWaZWFb4NGgxP6u4o1MvT/0L5t7NvXNQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6872

The RTL8211F(D)(I)-VD-CG PHY also has support for disabling the CLKOUT,
and we'd like to introduce the "realtek,clkout-disable" property for
that.

But it isn't done through the PHYCR2 register, and it becomes awkward to
have the driver pretend that it is. So just replace the machine-level
"u16 phycr2" variable with a logical "bool disable_clk_out", which
scales better to the other PHY as well.

The change is a complete functional equivalent. Before, if the device
tree property was absent, priv->phycr2 would contain the RTL8211F_CLKOUT_EN
bit as read from hardware. Now, we don't save priv->phycr2, but we just
don't call phy_modify_paged() on it. Also, we can simply call
phy_modify_paged() with the "set" argument to 0.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/phy/realtek/realtek_main.c | 31 ++++++++++++++------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index 417f9a88aab6..45b53660018a 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -194,8 +194,8 @@ MODULE_LICENSE("GPL");
 
 struct rtl821x_priv {
 	u16 phycr1;
-	u16 phycr2;
 	bool has_phycr2;
+	bool disable_clk_out;
 	struct clk *clk;
 	/* rtl8211f */
 	u16 iner;
@@ -266,15 +266,8 @@ static int rtl821x_probe(struct phy_device *phydev)
 		priv->phycr1 |= RTL8211F_ALDPS_PLL_OFF | RTL8211F_ALDPS_ENABLE | RTL8211F_ALDPS_XTAL_OFF;
 
 	priv->has_phycr2 = !(phy_id == RTL_8211FVD_PHYID);
-	if (priv->has_phycr2) {
-		ret = phy_read_paged(phydev, RTL8211F_PHYCR_PAGE, RTL8211F_PHYCR2);
-		if (ret < 0)
-			return ret;
-
-		priv->phycr2 = ret & RTL8211F_CLKOUT_EN;
-		if (of_property_read_bool(dev->of_node, "realtek,clkout-disable"))
-			priv->phycr2 &= ~RTL8211F_CLKOUT_EN;
-	}
+	priv->disable_clk_out = of_property_read_bool(dev->of_node,
+						      "realtek,clkout-disable");
 
 	phydev->priv = priv;
 
@@ -587,6 +580,18 @@ static int rtl8211c_config_init(struct phy_device *phydev)
 			    CTL1000_ENABLE_MASTER | CTL1000_AS_MASTER);
 }
 
+static int rtl8211f_disable_clk_out(struct phy_device *phydev)
+{
+	struct rtl821x_priv *priv = phydev->priv;
+
+	/* The value is preserved if the device tree property is absent */
+	if (!priv->disable_clk_out)
+		return 0;
+
+	return phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
+				RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN, 0);
+}
+
 static int rtl8211f_config_init(struct phy_device *phydev)
 {
 	struct rtl821x_priv *priv = phydev->priv;
@@ -669,10 +674,8 @@ static int rtl8211f_config_init(struct phy_device *phydev)
 	if (ret)
 		return ret;
 
-	ret = phy_modify_paged(phydev, RTL8211F_PHYCR_PAGE,
-			       RTL8211F_PHYCR2, RTL8211F_CLKOUT_EN,
-			       priv->phycr2);
-	if (ret < 0) {
+	ret = rtl8211f_disable_clk_out(phydev);
+	if (ret) {
 		dev_err(dev, "clkout configuration failed: %pe\n",
 			ERR_PTR(ret));
 		return ret;
-- 
2.34.1



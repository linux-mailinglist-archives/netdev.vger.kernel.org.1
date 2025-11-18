Return-Path: <netdev+bounces-239689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF22C6B5A2
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 20:08:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 9BC9E29EB8
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 19:08:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 498EC366DB5;
	Tue, 18 Nov 2025 19:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="AUlXBjRM"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013015.outbound.protection.outlook.com [40.107.159.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D40703612F9;
	Tue, 18 Nov 2025 19:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763492769; cv=fail; b=Qn75empENaahqzdzvECtXRXr+ZVBIeFqA0uV530Qapyy9ETucwEWo/lZcPxRZAAQu2SxUAHL2bkXYI24f7nadQmAmvDzWJphiGWCBFRaut9gGKDkS9BbDg1w2uvOOhfT9vhDbkGE6IBIKEXt8uOnLWVMhnzdRIsL/pcnw68z/h4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763492769; c=relaxed/simple;
	bh=GPtXy4dxOff6XH37IOQJPeCgnmo27Q+9Xn2Ue0+fsFw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=n+MEB1hxXhcDAS8C62fNKwxv9hzL3xB7i0i+MxNTuWpaWnRDHtisx4WInFmmC0T7KFmG34gcgVajlbUTG+d4Zf7nWCeq9wSNipR8lZZmBZdxjRo75JIHPnaQxPFiRdVODhwV2HhMPf9VH7Ew6q/s6i8H3wxPMtjWVD5d8UGxawo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=AUlXBjRM; arc=fail smtp.client-ip=40.107.159.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ao0s4fEx2KjMTdmr2n/CVUW14Q5KL3JuAq8gUJFtd1Gowwm1LIt3bGlPnrddHHhfMvWpdowutipPh8kl8wsKELN2u4AWrEOovDejCKu/8QJoE12wa2XdK163uHcFfQ/lYy6NHKc7HQcuiHtiKK51BoU5xYMVThGVnsk5TFYraoeopAJjTGcDqbiO1ZeJiYzBjdl5rt89Wr6n4BEvqwsi0V+E7vRECy/2cEAvX0TXpDqFY2XOfs4A8nJA2jOM9IT79AsuGB9uqeP2az6EU5gGM+FZmA9bPHnGFSOUd/CBj9jF5YXyjps/bIjFYqEb78fQ+AlfaF/sfxbZbqHr/R+xMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G6/zS6SPTIz7nOXYpQ4SdiNpGqZm1rlDpaA1luA6a90=;
 b=FxiSZHtL/DIGn8S7mUn8S4DkMTeRKxTX1P8XHINvHPDxWWZd05hmNl5H71SkuWPpD2es1Hj9138sbzjggL8Q0pgFTWLk8qHKaWHAsaht8Xa82kqubt9yrIBBjCKNdYOrIA/VE2J3wUkbsh2JKPtmH9BImVMOu2kY3WC4Y8+R092LqyxzSkSnLniuhqZINDwLYP4p1lRJWq8+SFNmOpCbeuLVYeofSFbzqMdr48Q+KONjegFajJBQ16tTpCpz/DYQ3SgP5rtX6RU4SeihftbJeKt78A45nhi5TOThicqNEtMfvcTWWfj+7+Z43gT6VrN2+wRHLr7xzYjUjSI/k+1fgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G6/zS6SPTIz7nOXYpQ4SdiNpGqZm1rlDpaA1luA6a90=;
 b=AUlXBjRM116q8/LmVvxVX10BBPKrBbSX4e83vSKVjAGZZd4bEZt8svazwtvLndtJA07sVXUzdIMlpPrfHWLl1wmtxOx3HBphggqHLo6LIFIWLA7IeewQHnagly06Mf2htJhnyIK12Dshh1oEoq/9TCe6HuIn7jrknUCDylxdFphvf/0Y2jRfmYFLmpQuxGytm9SpWmkkuG02csnBxgwcY5os9JDafZIPfy0b544HRykDwbAuPFT4sz3Z4MQso9oAZVaEgYEjgBhnhkHSbZH0g43QQccAapcDM0wcEp1k2kvsknZxtmFWOhP2zXUjHL4xleOtB3WYp5keS7P2oUmzBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com (2603:10a6:10:204::9)
 by PA4PR04MB7695.eurprd04.prod.outlook.com (2603:10a6:102:e3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.10; Tue, 18 Nov
 2025 19:05:57 +0000
Received: from DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff]) by DBBPR04MB7497.eurprd04.prod.outlook.com
 ([fe80::503f:b388:6d07:adff%4]) with mapi id 15.20.9343.009; Tue, 18 Nov 2025
 19:05:57 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 09/15] net: dsa: sja1105: remove sja1105_mdio_private
Date: Tue, 18 Nov 2025 21:05:24 +0200
Message-Id: <20251118190530.580267-10-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20251118190530.580267-1-vladimir.oltean@nxp.com>
References: <20251118190530.580267-1-vladimir.oltean@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: AM0P190CA0022.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:208:190::32) To DBBPR04MB7497.eurprd04.prod.outlook.com
 (2603:10a6:10:204::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DBBPR04MB7497:EE_|PA4PR04MB7695:EE_
X-MS-Office365-Filtering-Correlation-Id: 464c1d86-d224-421a-411e-08de26d58186
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|10070799003|366016|376014|52116014|19092799006;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?iFg0uuOmgmrX3OpOYZK1hs+Zmxv6xLcU4L8mHHWJaC8lqjfPqvMDvmpsJWTx?=
 =?us-ascii?Q?ecPO/hW9dEgAw0BFDZx1oYv3dRAzcJiyEdA7+JsiV5h5ugKtKwShmL2BCS/T?=
 =?us-ascii?Q?nS5besmqvXUDCh0Eqw5BxK+dy/bNaUbfPOFCup1pHmoh2o5LPQvb7a7+lk7z?=
 =?us-ascii?Q?Zt/e20AkLv6eQSIbr4EXQdhBcKExGGGMoaC8Sx19Kfx8iCI9sviqA9Cq7IqB?=
 =?us-ascii?Q?9CigExJbP30TF08ndW/5pXS8w+Xr6i0Wj+oufrrXFBzQQ5Tr1jreuuJiGK/6?=
 =?us-ascii?Q?sA7Iv/KLURkIvGFlxU3469KvJrtF7Oq2gjCSOHKTW3Mf9kxGBpNgnEf41cqR?=
 =?us-ascii?Q?7pqyGYhWC+CNYkxCw2pNJKuxFUywcWWtsl1lelxAkRkRE8gCDkwuUkb5tS7k?=
 =?us-ascii?Q?TSNHXLYIqdpbm27EXbVg1ttRDWDR6IxUkDC4f5qgA7c6JQYW1Ht/3PWWmVYP?=
 =?us-ascii?Q?5vGoW+/b1/dVlUezTVTu+EIFu4aQGygSHXEuf+7fvtfxazkB1UPBGLxyVEXJ?=
 =?us-ascii?Q?Uzkr6nkowJQJruF3ayTRSdIH9VpEQCSZX8QOFh4RpJLLTTeZH8FII7vy8YXd?=
 =?us-ascii?Q?XBOhHxvoo82xGgD12doEzJQNr+Zxw6pZKC0VHKksiux0zQ96Hah/gaoa2DIn?=
 =?us-ascii?Q?NFp0leuXdPhryqVs/eGT5km+UePhyswyxDH6K6wIJ+j4L4/yipckwe5yIBal?=
 =?us-ascii?Q?MuH0eaVX4uPz+f0bTYG3hwBitgCNoSEWSUO5srbdlC5bBlNPRGKkgrFLSuqQ?=
 =?us-ascii?Q?CKoISDkXrHcyfehgoqKtgQJdOZshhe6+yd2xPNs87WddquxMMqTyym8iD5SJ?=
 =?us-ascii?Q?a+xZ/9NEPl/MDONyFVP8jaN2qdVUnpdSYA20S0WltfJ+rNneOqD+3aby88Cz?=
 =?us-ascii?Q?VAqSo7gZUHwcmrNcbU9/SWxEM6u7qNcejqXXV1jldSgz6GMnQixpwqc5SvYS?=
 =?us-ascii?Q?on39W0N5AXs8j7LExbjIu15Gn/MpOmnuJxIb4rwKSXJhsWO37SWXiWpM1FVh?=
 =?us-ascii?Q?DuFfoi9tyO8tSGg9+ho45jLP9xo7cyZhCtuec1SJErDQ3bqunfTiyIABKz+w?=
 =?us-ascii?Q?3gPF2gICj8N7rfNluDAwUVSzO/XSpjSJ/JdM05y69UUKMVwRMxJw8OhEItw0?=
 =?us-ascii?Q?bndr24RzxW4oBZTZM5mLPrsC+U/mweYXDhlnGkrcXTHUIcVski/6dWfjfUkN?=
 =?us-ascii?Q?F040agVABnBLYdHmfaS1cuMAItv1lZ/Qw0tfDHwFz2NsOsbS4x1EhEvnNm7q?=
 =?us-ascii?Q?txeT+B6sSWaulnw9/DM919m28EoxmoWVY39iAQffGYZZS7Jht9XUzvnly9Hd?=
 =?us-ascii?Q?5Pbsx9UOOBeNdAkk4Fm4ZyeBOd1Ik6pXPDbOjFjHnVGDgNREoSlG2rhvpdHl?=
 =?us-ascii?Q?MM1kt5ehaAtF4Wa72rRso4uSK7J2UA07OSX/nHfyC8eCx+mwJXGjNJAQhC3H?=
 =?us-ascii?Q?bofbgMOUyNgDfLJhnK9ZuiO/bNIBeEtq?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DBBPR04MB7497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(10070799003)(366016)(376014)(52116014)(19092799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?sOacyb2HMByr72zjmcOeo16ppNqjPoL5FdMRfwPt9avhmJVYEEVVRpkj45/E?=
 =?us-ascii?Q?WB5HtREx+j/EX4cn69ETffMOTZAdAAml+Hk2o2r+wg7e/YvtnYIKV5oWgKgB?=
 =?us-ascii?Q?MCWrqEqaDj4zBqcxotL1VqRv8be89qwf30u1+wRgZVRQ9oZxRYZWlnBkqLpE?=
 =?us-ascii?Q?AJDcKil7CjvIqjpWZkcMfkvLzBO4ND2fXYovOC51pbfrxP9hIkZMBfCQvnck?=
 =?us-ascii?Q?6wrCAP6EwQ3bjGFCcKwGSgUcLSEqnL+QfpVGUC0kq9p8PW/1bYK8moU/JLzA?=
 =?us-ascii?Q?HrJoIpyo4PUHz3mpdw4CafSO3KzjQ5lsc3tBQg77K4Dy6TxlW+0F3jKYcMyR?=
 =?us-ascii?Q?B1tZTNkvb6FtoUUIzWwTYhm1Vv40Au/VvyxfxNdBVwtxuFUVbMJ2QPsKZ5TB?=
 =?us-ascii?Q?eKM3Ye/zBQgLFJQtWf97jGOZHiphQYtIQllT8thwX8q/P/SbkhuhkwiF+Xc0?=
 =?us-ascii?Q?UOE1I9nAWf4tUSjmV9NG8Qcs/wnbT6l4RfgWt6li3Ef0vpoba7ZstP4JK0RA?=
 =?us-ascii?Q?l6je6beSKdr/0RUVbIS8diw6SqAMj9enO4J1GaPfSSHI3vaCClsms9KosbKa?=
 =?us-ascii?Q?eArwARDJxungYJ5n1jr0A/dVYRVOY0zXYaLcOfWDRcdqh5rFY4no33jwRbhQ?=
 =?us-ascii?Q?Z9IzOfCG+H+frUs2tA14fZNbp9U8wYMTv0XuWFqAb6LCAxNLwQi8jLw19UM4?=
 =?us-ascii?Q?YxCHE5imBRbtuuDRqilYPhOVT/DEI9h3zJYLyjUzT7/Ifo0bqcGUCgQGgm0S?=
 =?us-ascii?Q?OspCi3yzYnkFM1pavgmX/cVaWUU4fEBDFGUAQKtAZlUWzIOWYslugpfk5XNe?=
 =?us-ascii?Q?e+uIcx/JZ0/QVQ5hdaB3Kn7791TP5t2YQjeCGQ2ZXdIVGLjNHbnB/oDJhjrC?=
 =?us-ascii?Q?dC0+UGbzZNl3x6oJ6awojvIqXaKOc5J4QCrMSi96Vsp7BWFTk3SvzAFy6qZC?=
 =?us-ascii?Q?IMV/zRnWpEMSQpU9dgrxjl52ywk4kz+thn4V8xVJN3nxfsI5kEqo7/IXnisM?=
 =?us-ascii?Q?XZXp+csSiPmGmAAoKuO4YhRdKdQkT2wMPwAVV/70BNgrlY10RDj+d1Gjd8YE?=
 =?us-ascii?Q?8Yh+YhjcjRhhKrxttx0fGlkYEwxg8KifL4EerZdshjKP3VUp23cv3cARq+KA?=
 =?us-ascii?Q?2865q+UOx36tVvQn5eBaCxnv03WD8BCjpu9gwoKxUUVZYeY0ACyfSV2gHoUN?=
 =?us-ascii?Q?HgaVhiPNCsvYoIqPypm/CucWn2J8d6cNeC1hWHLeqs5t8k7WWEZezHd1LRAB?=
 =?us-ascii?Q?ZlNOT3gkJi6iUs4REWqyM0zhfRi4gm1pwq1PejrKi70tzXyuuSmxfn5obyBp?=
 =?us-ascii?Q?3c2V21rJB4b6CzrlAq5cQYWFD5r94aRgqe1pnYdQwi+IMuX+6mpUpbhamCD9?=
 =?us-ascii?Q?Kkhxj9cK4/jpwvV1x5flNOJBYZA4shIewnZ6AgIG3BKVgjIlAa7YzWd4NAY3?=
 =?us-ascii?Q?ofx5rN9W+hD9PZlDlQpp4GpJJbcMbtGhPKezLvXW9HqB8nzuQ7ngJWUHi/Wm?=
 =?us-ascii?Q?G79eWoC0B/5lwzmqUcPRpVK/oO1zXJV/u474PTtCqba+Hd0qpXg9ys+ABKek?=
 =?us-ascii?Q?xLiW4WjCEguYgimC2ppF4WPQAp+pTcN2gj9j9cYDF1uxcVyxWw+9x4sDpna5?=
 =?us-ascii?Q?pIoNnNnzxePuyIQ43Hkx1qQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 464c1d86-d224-421a-411e-08de26d58186
X-MS-Exchange-CrossTenant-AuthSource: DBBPR04MB7497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 19:05:57.7852
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: huBs5drBLSIBUplXrFLrOJaIqxKWTWhdQoKNF8VXsr4GNeJTZIGTnnshi8ATM92FZAzMRAmL7bDyNUkc0N51TQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7695

This structure is no longer used for anything. We can just set the
bus->priv of the PCS MDIO bus to be struct sja1105_private.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/dsa/sja1105/sja1105.h      |  4 ----
 drivers/net/dsa/sja1105/sja1105_mdio.c | 18 ++++++------------
 2 files changed, 6 insertions(+), 16 deletions(-)

diff --git a/drivers/net/dsa/sja1105/sja1105.h b/drivers/net/dsa/sja1105/sja1105.h
index ff6b69663851..22fce143cb76 100644
--- a/drivers/net/dsa/sja1105/sja1105.h
+++ b/drivers/net/dsa/sja1105/sja1105.h
@@ -94,10 +94,6 @@ struct sja1105_regs {
 	u64 pcs_base[SJA1105_MAX_NUM_PORTS];
 };
 
-struct sja1105_mdio_private {
-	struct sja1105_private *priv;
-};
-
 enum {
 	SJA1105_SPEED_AUTO,
 	SJA1105_SPEED_10MBPS,
diff --git a/drivers/net/dsa/sja1105/sja1105_mdio.c b/drivers/net/dsa/sja1105/sja1105_mdio.c
index b803ce71f5cc..d5577c702902 100644
--- a/drivers/net/dsa/sja1105/sja1105_mdio.c
+++ b/drivers/net/dsa/sja1105/sja1105_mdio.c
@@ -9,8 +9,7 @@
 
 int sja1105_pcs_mdio_read_c45(struct mii_bus *bus, int phy, int mmd, int reg)
 {
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
+	struct sja1105_private *priv = bus->priv;
 	u64 addr;
 	u32 tmp;
 	int rc;
@@ -35,8 +34,7 @@ int sja1105_pcs_mdio_read_c45(struct mii_bus *bus, int phy, int mmd, int reg)
 int sja1105_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd,
 			       int reg, u16 val)
 {
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
+	struct sja1105_private *priv = bus->priv;
 	u64 addr;
 	u32 tmp;
 
@@ -51,8 +49,7 @@ int sja1105_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd,
 
 int sja1110_pcs_mdio_read_c45(struct mii_bus *bus, int phy, int mmd, int reg)
 {
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
+	struct sja1105_private *priv = bus->priv;
 	const struct sja1105_regs *regs = priv->info->regs;
 	int offset, bank;
 	u64 addr;
@@ -97,8 +94,7 @@ int sja1110_pcs_mdio_read_c45(struct mii_bus *bus, int phy, int mmd, int reg)
 int sja1110_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd, int reg,
 			       u16 val)
 {
-	struct sja1105_mdio_private *mdio_priv = bus->priv;
-	struct sja1105_private *priv = mdio_priv->priv;
+	struct sja1105_private *priv = bus->priv;
 	const struct sja1105_regs *regs = priv->info->regs;
 	int offset, bank;
 	u64 addr;
@@ -135,7 +131,6 @@ int sja1110_pcs_mdio_write_c45(struct mii_bus *bus, int phy, int mmd, int reg,
 
 static int sja1105_mdiobus_pcs_register(struct sja1105_private *priv)
 {
-	struct sja1105_mdio_private *mdio_priv;
 	struct dsa_switch *ds = priv->ds;
 	struct mii_bus *bus;
 	int rc = 0;
@@ -144,7 +139,7 @@ static int sja1105_mdiobus_pcs_register(struct sja1105_private *priv)
 	if (!priv->info->pcs_mdio_read_c45 || !priv->info->pcs_mdio_write_c45)
 		return 0;
 
-	bus = mdiobus_alloc_size(sizeof(*mdio_priv));
+	bus = mdiobus_alloc_size(0);
 	if (!bus)
 		return -ENOMEM;
 
@@ -158,8 +153,7 @@ static int sja1105_mdiobus_pcs_register(struct sja1105_private *priv)
 	 * from auto probing.
 	 */
 	bus->phy_mask = ~0;
-	mdio_priv = bus->priv;
-	mdio_priv->priv = priv;
+	bus->priv = priv;
 
 	rc = mdiobus_register(bus);
 	if (rc) {
-- 
2.34.1



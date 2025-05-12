Return-Path: <netdev+bounces-189783-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 205DFAB3AC6
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 16:36:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 69C9C7AD4DC
	for <lists+netdev@lfdr.de>; Mon, 12 May 2025 14:35:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90DAC2185B8;
	Mon, 12 May 2025 14:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WLvSTXuI"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2073.outbound.protection.outlook.com [40.107.20.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B038978F43
	for <netdev@vger.kernel.org>; Mon, 12 May 2025 14:36:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.73
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747060584; cv=fail; b=OzV60qx6ohSvWyCMAsE6/bDJi5/T9e0NyyjGA/8KH5zGM2ysP3uWv7Wx8hFcmnzFQCGJ+aQAPh4iGDfDl8geDpPVX4EXCHaAKcxUyrrMn/4g+tDWhUCHlToGKqM+ns68OdyFRsg0FxGPZK5Xnc+dqKaLz/pVAw2rrIOKsm1s0r0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747060584; c=relaxed/simple;
	bh=bNjdYJgZ1fjZ6oyhMvxXyX/uaEwyNTL9DX9iXx8aMjE=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=lT4LQKUlFxnE3ScnlXkefVLDfUam/Kkt5nL2GJAH5SXUuGHLyyQbWuFrKcFqx2LAF7BMDZmFYGawa7ohca3NpFScjwnBo5WA6xU9aWJUEMdui72rXSgd4h7TLtegJp1boWNuzCxnxhOOiJMdAG/tNIeq6S6hqEpDf/WLT+wS0YI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WLvSTXuI; arc=fail smtp.client-ip=40.107.20.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MufmzNJlflbQ5l/R4lzub64212m6Ar79AAZCWqF9C+lHdbD/1k6S7AjauA82WMzgY67rFgXECD273rHzCCAnTYkfPTieAzGpBz/T0EdIbLJ7OdCbi7ejJDs6PyHPZOKjMtcmxAsWTiU6obkYZBxXDA7nuTRnfaeMfuD7gvs3p1kM6JUZXQUOtJkEGmROWp2KHv356Vb5y4oq70OfsM3M+14l4XWrMDWug9Ur88l8xZTxy0V3cGvAMspQko5w6BHwnoQOb42JCvR3EgI/P7pMJ9Mh4PSJUBcuz/3+I6G6R2CITuVkCvFfc2PpmDmdfEvswpdwBWfBUMDckq7k5bajSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=trXC5mbIJBwmK1iAa605jJ/cQwBvhCLhUbi61OXpQLw=;
 b=vUgdwJSbtXa1UcKw2pR50h7EYCQ01fje8D+koiIVgtzxjG7P5IW9VaPgLrCo6/15S1sMQIyA0SSBuEiZTVvbK/1AB/pL22fIoiuWKTj/wkbjwUxDUHKjON32TWmda12bd2/J7Kp3R3+usRGT4x48jEqBISN+3ojZ3HcRf8J9STw2YwHZTDZPh+1oaD9+KaySK/4HLzaKiKbEUkDZltbqW1u+g9g0A+U0P5vTmF+msr3P/9og2qYQJ+e6PO7WBqc5v6o1dfBVTnaPaD27ONo3T3+2JmTLwD1oEwDbdZSshWbcJ6E2KSOpi1oSU5IY5RvrvIic170/aKUC+1R//x9XWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=trXC5mbIJBwmK1iAa605jJ/cQwBvhCLhUbi61OXpQLw=;
 b=WLvSTXuIVxpbVIOp6s0GjKPKtVI2Kd8lkFF1XWqArSU2NmNbxkNxYdMyNGwRVqjfOPXmIWszcQlqSO0BOgbeUCvd2W9XnB8I2THQjaia4KrmKIuKBTdSUTb7+QJ53htLE33RQaFwdnV8B4rFZAXb3+sDQyS+nGtMGOAMdwxN4Dp/RgUYXG/38vQCy0N3TT7irAr53PuOQhs5HoHhDDke4VoHPKzfssSkFNA+99J9ecd2ZPifg/i3bW+kpcghSZ5MRyinIg2oOA9V8N0oHOvIqwTDjFMFzBO/buN6larY2hDMkuNDcS2AnRNZYakgKKGr5mNObhUa7CQIBIHUhdCxuA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by GV1PR04MB10632.eurprd04.prod.outlook.com (2603:10a6:150:206::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.28; Mon, 12 May
 2025 14:36:19 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%4]) with mapi id 15.20.8722.027; Mon, 12 May 2025
 14:36:18 +0000
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: netdev@vger.kernel.org
Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	Russell King <linux@armlinux.org.uk>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>,
	Richard Cochran <richardcochran@gmail.com>,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next] net: stmmac: convert to ndo_hwtstamp_get() and ndo_hwtstamp_set()
Date: Mon, 12 May 2025 17:36:07 +0300
Message-ID: <20250512143607.595490-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.43.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR0502CA0028.eurprd05.prod.outlook.com
 (2603:10a6:803:1::41) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|GV1PR04MB10632:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f2aed12-7f02-4355-3bed-08dd91625b89
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|7416014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?J3QNnryk1DZmQ4uqINOPFvjuv/TWXScJymgNTwe2ao/cHDes5Eb1oNwZayUI?=
 =?us-ascii?Q?B5tUqY6Ks8/5nuvY4Yh8k6aOM8z/mliYbeFGKESfyaYE5CDb22q822tG9+mZ?=
 =?us-ascii?Q?njTqFErwJQiQORtxU8evwMIMaHT1FErXdMbya1HvgEuWaPNHohGEHb4EE0BH?=
 =?us-ascii?Q?H5wxYBT455iZ8Gx64O6gn5O6iOVzJI0ZX/Iho54si/MBx3fhFgAZop02FPiU?=
 =?us-ascii?Q?VQIR1meOFYFR1vZO+MFp5V43Z5xr81jxWqGUt7u4ljbxcQQzAFYumMyDSKpi?=
 =?us-ascii?Q?/EcefVeXBbraawfn9ybGtIr+OoenQd4JraAJbjQxyoLq32yW9mTolQo6SXkO?=
 =?us-ascii?Q?ew56PaV6fWFRaPSp3hbWN4NjGk42L/kzl3QZeENOOJVMd56JxXMywm2z3f8G?=
 =?us-ascii?Q?o+XGMH1IZfq03rGGJ/NastydxRFTvfBLC9hxQOMNTXJuGF8sVqfO8ua6x6ca?=
 =?us-ascii?Q?TIwqRbTlGuzKyCTEhE09R+5apdhIB7gnYlK5UBH37+MoIbFyrJZZnc43NPee?=
 =?us-ascii?Q?/K4yvdywJNfc4vuyHfYdPkLyOk0fatqjX1QZ8uL0Cxq6pUat/LOC04f3RIuq?=
 =?us-ascii?Q?joweE9qKqUoXqltjrBVrbdQucEExtMDGAoewvXFybZvOwwTGcc2ym0g8k4G3?=
 =?us-ascii?Q?3CajwrVoELNBoH/VY0pLHXkAtNfvcIGRq4m3FIm3TvhhJo/nIfjj39oF0BCZ?=
 =?us-ascii?Q?WfYbjcU9DNJtbNG4GAS3kMWo/ZIjGO76o03Jea6aQIXOOTQZv617+O19B5zR?=
 =?us-ascii?Q?2hivKIs2+UsQ/CUF2zKNLv2F9Ge1utepY9COGmAO7XvRl3iaX+JuxvegvOj8?=
 =?us-ascii?Q?7c0AV3VEzMKC50LzRPTCU1lMqp39WgjtI6bSgzgqxvUVSBAahpZvUGQKSGNQ?=
 =?us-ascii?Q?ks6EJwz9LtD1neFYL+VzxUE8Oug27jqa7y4vWHe0Myguy9QulRW68BFfMEET?=
 =?us-ascii?Q?/RkU8S1IT61ECBDWN5UX41+LUkXLiUqTbtSBELFHCf/EpN4uRf6i6PU7PIWP?=
 =?us-ascii?Q?F2COnOGFpiUclLexEkJU+afBObYz247NHmgjESeyCV9IhOTC9C6wn2TUHFgh?=
 =?us-ascii?Q?dERAJ1OcN2uz/FBn1XU1eUtCkqffMqLhSKz2hldklx4FxE4U9RlXtYrpKINe?=
 =?us-ascii?Q?rXjnOerNumP/U1BiO4U4oRdXDalWdLcilKxF/+MWdd5runh7JsHPLOpc0ydu?=
 =?us-ascii?Q?dkh0x2PjupgtPeAQZvCARcMI9co8xeBW2Hq5cY8yPfw6lrxcSc7hkQ5NBu5I?=
 =?us-ascii?Q?fJOL9B6H6d7uu+xQInNVlgfB0VbHzorRvksqKc+0VWoIujQXKj0iZ2gxCdl7?=
 =?us-ascii?Q?KwaG8+SDabCc/eVvbXIZVXIRr5c1jd3hNJPjqCBNMyJyXhZhDptkRTloJOmS?=
 =?us-ascii?Q?tv5mDE/7iZxTzTyJQftq6OfzjgGdecs+umwtX8dZG3II0W67CMJFCdFdSLdI?=
 =?us-ascii?Q?PUFVh1ogRDNtHfULq5+ss7Xqe30yivV6TyJzw2lhJp7nPiRO8m+v2Q=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(7416014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?GY3KJX/dPtUxR9sm8ZBksqigx0mpTholGkbG5Y4x729SEl5FVCStVNLhl8KN?=
 =?us-ascii?Q?E2n3uXdVNY3g1LF/6ftcF6m4mpIHXX5zNlhVD+PSo83ZA/fAoaxlXZXU0RPd?=
 =?us-ascii?Q?ls/iiG4Wee9e/sPv/rntU206bB8CQql7rvaA09gFa6WiXpU/bsE0GHLDIufV?=
 =?us-ascii?Q?SG2xc9NYUpojw/SAN5x0oqJTWLMIznHhoWx8GMrWfyszOnj44lAiIV0OZzhg?=
 =?us-ascii?Q?IBZdkyFriPyyTpGm3MsBb97+OkYxs1U6UwbHKPpejHB6kNg9pfnZp34KG23B?=
 =?us-ascii?Q?edrQakREWCeUMmGdeXX1R2KDQg3UmoWz33LgNMhRhGDkjDkNjfyyyJM2uRgy?=
 =?us-ascii?Q?UqhHhySvoTGl5yXFhJI76w3g3Dkoa/wYlf4iGUv2f0R/mmdQaEYuDiGqPZDW?=
 =?us-ascii?Q?bh14KyDmGxQI/Lk53rEVHXpX+1zZccnKauF8V1xlRC2uczBRQ24CKoqXrp5W?=
 =?us-ascii?Q?+365QPcBOHroxTNby0xDRERw079d6TsvAr/jRaztQEBgTwPgOuNjd92Yvxg7?=
 =?us-ascii?Q?Iy4PCHm+yT1WBqhDZW9CYjP8vZw2rqqhtwAldPatmfAcgwP2Gao5pvP1XS0Q?=
 =?us-ascii?Q?QD10rghCOWQMKn+2nWdTJxhJfpRAf6novt9HOUPwoaHAkpaRXWx3BFo//KgR?=
 =?us-ascii?Q?dURWVn54nEyzgU5SYuaqAcqtq2eQSYxO+wYIGdfw8QoORRrApE1CXuoBA7Xv?=
 =?us-ascii?Q?JbifSo9VURgZOn2qE0gDli7qBAPo055n1VzzxgYYiS2/XFYidOLriSNqU3vT?=
 =?us-ascii?Q?H+RZ0yR5MHxUq4p1xsMsWB1YK60xrklrT+zcfVLNGFtSGgxAF5xvx4Ru1t2j?=
 =?us-ascii?Q?4bGe3n4oTtOdoG1u0fWqj9zZEDQFj4moq0uTAY4ikLbGycqc8MayOJXNFi6R?=
 =?us-ascii?Q?elDVLFw3tg0E9aNOpgwmLvn/GQGXPjrPD5hSosKTNweunq0lYYm966IqqiZa?=
 =?us-ascii?Q?2VGemy5mdZBAyd4W1t/AM6P+wqLkcrtqSQIe2du+Co191uwmDMqQLrkW2QcL?=
 =?us-ascii?Q?XrvSTCulnEAVgb0tN/Q21G7Ad0FVJeK2Rj5kSWCc9Ll1UVAETvaByymWoUvy?=
 =?us-ascii?Q?Lw0M9dQXCM3ipBQTpO/gpQH52tk6snZYFDIXV2OXc65YzZPcES/nteWqpXs7?=
 =?us-ascii?Q?U7vNdFY6tHenXAG7UhQWH+XWTdZsTDSutjG5hPGw7Ir1sGPMsOHh0StRxhUY?=
 =?us-ascii?Q?K1hmt9/oFEONvRI0GjqATJfEow2E1MkkH/2sCBfowO4vK67VfSYWHCbZphLt?=
 =?us-ascii?Q?bmnC+Wiu1MiZwiENU7Kzg/cu1kc2Y0Vf639ksnB62/FIRljjJL6bH7pN4qVD?=
 =?us-ascii?Q?CkKXgMtbK49AieBv8oM+xa1guvTTodASYXEDMas+60bmhI1JbifFKU1lb+pL?=
 =?us-ascii?Q?b8VzkZ767OSN47MoTnenNRGXl14gqwbu0+gm9FYzrxgxsRfp6aMCAaBmyK23?=
 =?us-ascii?Q?gQ/SRlMtoZC0svIogwFcD728dyX8ZIW306zw2404x4QtHvhSaV9ryM8I76P7?=
 =?us-ascii?Q?ZTyWfV0SeSjn3h9qzcm4UbcY0Z3fULtzbJ8UTWCLpWJoSxiuBTgqfsHQiuTO?=
 =?us-ascii?Q?XHL1tVtMotO92IY2VNzF/RYhE0GWqnXl8Uae8AVb/8tDT47WGSNdtf9+8ZES?=
 =?us-ascii?Q?kg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f2aed12-7f02-4355-3bed-08dd91625b89
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2025 14:36:18.8490
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8ot/d1wI+SZ7sTjBAnf8PtWo6B1+VW7ec6dEc3v84C3f2GWX7qldddflPK0xQxasYwAIFHKtUmTicf53+0Dp0g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10632

New timestamping API was introduced in commit 66f7223039c0 ("net: add
NDOs for configuring hardware timestamping") from kernel v6.6. It is
time to convert the stmmac driver to the new API, so that the
ndo_eth_ioctl() path can be removed completely.

Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +-
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 80 +++++++++----------
 2 files changed, 37 insertions(+), 45 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index 1686e559f66e..cda09cf5dcca 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -301,7 +301,7 @@ struct stmmac_priv {
 	unsigned int mode;
 	unsigned int chain_mode;
 	int extend_desc;
-	struct hwtstamp_config tstamp_config;
+	struct kernel_hwtstamp_config tstamp_config;
 	struct ptp_clock *ptp_clock;
 	struct ptp_clock_info ptp_clock_ops;
 	unsigned int default_addend;
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index a19b6f940bf3..c090247d2a29 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -568,18 +568,19 @@ static void stmmac_get_rx_hwtstamp(struct stmmac_priv *priv, struct dma_desc *p,
 /**
  *  stmmac_hwtstamp_set - control hardware timestamping.
  *  @dev: device pointer.
- *  @ifr: An IOCTL specific structure, that can contain a pointer to
- *  a proprietary structure used to pass information to the driver.
+ *  @config: the timestamping configuration.
+ *  @extack: netlink extended ack structure for error reporting.
  *  Description:
  *  This function configures the MAC to enable/disable both outgoing(TX)
  *  and incoming(RX) packets time stamping based on user input.
  *  Return Value:
  *  0 on success and an appropriate -ve integer on failure.
  */
-static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
+static int stmmac_hwtstamp_set(struct net_device *dev,
+			       struct kernel_hwtstamp_config *config,
+			       struct netlink_ext_ack *extack)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	struct hwtstamp_config config;
 	u32 ptp_v2 = 0;
 	u32 tstamp_all = 0;
 	u32 ptp_over_ipv4_udp = 0;
@@ -590,34 +591,30 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 	u32 ts_event_en = 0;
 
 	if (!(priv->dma_cap.time_stamp || priv->adv_ts)) {
-		netdev_alert(priv->dev, "No support for HW time stamping\n");
+		NL_SET_ERR_MSG_MOD(extack, "No support for HW time stamping\n");
 		priv->hwts_tx_en = 0;
 		priv->hwts_rx_en = 0;
 
 		return -EOPNOTSUPP;
 	}
 
-	if (copy_from_user(&config, ifr->ifr_data,
-			   sizeof(config)))
-		return -EFAULT;
-
 	netdev_dbg(priv->dev, "%s config flags:0x%x, tx_type:0x%x, rx_filter:0x%x\n",
-		   __func__, config.flags, config.tx_type, config.rx_filter);
+		   __func__, config->flags, config->tx_type, config->rx_filter);
 
-	if (config.tx_type != HWTSTAMP_TX_OFF &&
-	    config.tx_type != HWTSTAMP_TX_ON)
+	if (config->tx_type != HWTSTAMP_TX_OFF &&
+	    config->tx_type != HWTSTAMP_TX_ON)
 		return -ERANGE;
 
 	if (priv->adv_ts) {
-		switch (config.rx_filter) {
+		switch (config->rx_filter) {
 		case HWTSTAMP_FILTER_NONE:
 			/* time stamp no incoming packet at all */
-			config.rx_filter = HWTSTAMP_FILTER_NONE;
+			config->rx_filter = HWTSTAMP_FILTER_NONE;
 			break;
 
 		case HWTSTAMP_FILTER_PTP_V1_L4_EVENT:
 			/* PTP v1, UDP, any kind of event packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 			/* 'xmac' hardware can support Sync, Pdelay_Req and
 			 * Pdelay_resp by setting bit14 and bits17/16 to 01
 			 * This leaves Delay_Req timestamps out.
@@ -631,7 +628,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V1_L4_SYNC:
 			/* PTP v1, UDP, Sync packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_SYNC;
 			/* take time stamp for SYNC messages only */
 			ts_event_en = PTP_TCR_TSEVNTENA;
 
@@ -641,7 +638,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ:
 			/* PTP v1, UDP, Delay_req packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_DELAY_REQ;
 			/* take time stamp for Delay_Req messages only */
 			ts_master_en = PTP_TCR_TSMSTRENA;
 			ts_event_en = PTP_TCR_TSEVNTENA;
@@ -652,7 +649,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_L4_EVENT:
 			/* PTP v2, UDP, any kind of event packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_EVENT;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for all event messages */
 			snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
@@ -663,7 +660,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_L4_SYNC:
 			/* PTP v2, UDP, Sync packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_SYNC;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_SYNC;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for SYNC messages only */
 			ts_event_en = PTP_TCR_TSEVNTENA;
@@ -674,7 +671,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ:
 			/* PTP v2, UDP, Delay_req packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_L4_DELAY_REQ;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for Delay_Req messages only */
 			ts_master_en = PTP_TCR_TSMSTRENA;
@@ -686,7 +683,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_EVENT:
 			/* PTP v2/802.AS1 any layer, any kind of event packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_EVENT;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			snap_type_sel = PTP_TCR_SNAPTYPSEL_1;
 			if (priv->synopsys_id < DWMAC_CORE_4_10)
@@ -698,7 +695,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_SYNC:
 			/* PTP v2/802.AS1, any layer, Sync packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_SYNC;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_SYNC;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for SYNC messages only */
 			ts_event_en = PTP_TCR_TSEVNTENA;
@@ -710,7 +707,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 		case HWTSTAMP_FILTER_PTP_V2_DELAY_REQ:
 			/* PTP v2/802.AS1, any layer, Delay_req packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V2_DELAY_REQ;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V2_DELAY_REQ;
 			ptp_v2 = PTP_TCR_TSVER2ENA;
 			/* take time stamp for Delay_Req messages only */
 			ts_master_en = PTP_TCR_TSMSTRENA;
@@ -724,7 +721,7 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 		case HWTSTAMP_FILTER_NTP_ALL:
 		case HWTSTAMP_FILTER_ALL:
 			/* time stamp any incoming packet */
-			config.rx_filter = HWTSTAMP_FILTER_ALL;
+			config->rx_filter = HWTSTAMP_FILTER_ALL;
 			tstamp_all = PTP_TCR_TSENALL;
 			break;
 
@@ -732,18 +729,18 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 			return -ERANGE;
 		}
 	} else {
-		switch (config.rx_filter) {
+		switch (config->rx_filter) {
 		case HWTSTAMP_FILTER_NONE:
-			config.rx_filter = HWTSTAMP_FILTER_NONE;
+			config->rx_filter = HWTSTAMP_FILTER_NONE;
 			break;
 		default:
 			/* PTP v1, UDP, any kind of event packet */
-			config.rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
+			config->rx_filter = HWTSTAMP_FILTER_PTP_V1_L4_EVENT;
 			break;
 		}
 	}
-	priv->hwts_rx_en = ((config.rx_filter == HWTSTAMP_FILTER_NONE) ? 0 : 1);
-	priv->hwts_tx_en = config.tx_type == HWTSTAMP_TX_ON;
+	priv->hwts_rx_en = config->rx_filter != HWTSTAMP_FILTER_NONE;
+	priv->hwts_tx_en = config->tx_type == HWTSTAMP_TX_ON;
 
 	priv->systime_flags = STMMAC_HWTS_ACTIVE;
 
@@ -756,31 +753,30 @@ static int stmmac_hwtstamp_set(struct net_device *dev, struct ifreq *ifr)
 
 	stmmac_config_hw_tstamping(priv, priv->ptpaddr, priv->systime_flags);
 
-	memcpy(&priv->tstamp_config, &config, sizeof(config));
+	priv->tstamp_config = *config;
 
-	return copy_to_user(ifr->ifr_data, &config,
-			    sizeof(config)) ? -EFAULT : 0;
+	return 0;
 }
 
 /**
  *  stmmac_hwtstamp_get - read hardware timestamping.
  *  @dev: device pointer.
- *  @ifr: An IOCTL specific structure, that can contain a pointer to
- *  a proprietary structure used to pass information to the driver.
+ *  @config: the timestamping configuration.
  *  Description:
  *  This function obtain the current hardware timestamping settings
  *  as requested.
  */
-static int stmmac_hwtstamp_get(struct net_device *dev, struct ifreq *ifr)
+static int stmmac_hwtstamp_get(struct net_device *dev,
+			       struct kernel_hwtstamp_config *config)
 {
 	struct stmmac_priv *priv = netdev_priv(dev);
-	struct hwtstamp_config *config = &priv->tstamp_config;
 
 	if (!(priv->dma_cap.time_stamp || priv->dma_cap.atime_stamp))
 		return -EOPNOTSUPP;
 
-	return copy_to_user(ifr->ifr_data, config,
-			    sizeof(*config)) ? -EFAULT : 0;
+	*config = priv->tstamp_config;
+
+	return 0;
 }
 
 /**
@@ -6228,12 +6224,6 @@ static int stmmac_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 	case SIOCSMIIREG:
 		ret = phylink_mii_ioctl(priv->phylink, rq, cmd);
 		break;
-	case SIOCSHWTSTAMP:
-		ret = stmmac_hwtstamp_set(dev, rq);
-		break;
-	case SIOCGHWTSTAMP:
-		ret = stmmac_hwtstamp_get(dev, rq);
-		break;
 	default:
 		break;
 	}
@@ -7172,6 +7162,8 @@ static const struct net_device_ops stmmac_netdev_ops = {
 	.ndo_bpf = stmmac_bpf,
 	.ndo_xdp_xmit = stmmac_xdp_xmit,
 	.ndo_xsk_wakeup = stmmac_xsk_wakeup,
+	.ndo_hwtstamp_get = stmmac_hwtstamp_get,
+	.ndo_hwtstamp_set = stmmac_hwtstamp_set,
 };
 
 static void stmmac_reset_subtask(struct stmmac_priv *priv)
-- 
2.43.0



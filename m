Return-Path: <netdev+bounces-134084-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89E3D997D4B
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 08:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D0DB9B21DE4
	for <lists+netdev@lfdr.de>; Thu, 10 Oct 2024 06:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BED1C1A303C;
	Thu, 10 Oct 2024 06:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MX11MGV7"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2042.outbound.protection.outlook.com [40.107.21.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7731A263F;
	Thu, 10 Oct 2024 06:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728542075; cv=fail; b=YSTruYkLHTAgFqgOABR+PJi62UroYBez4ccAhSQ2MU5V3ucAjO8rAIkJtmrY2nkcRHWOsnlrdp3rse/y+lPiZLpLQOc58o8MXYK4EebtSQ/bg1Od4xIpeV6xFve7m21nKNyp7jn1LfnRuabH3/S6flPE0ILYYlyYt+pP3SWNxGM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728542075; c=relaxed/simple;
	bh=ww40cClJbFELCDEIoCNzb5p+xJCemyuxy8ZqV/vbgjg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=NM8AXZNVxnVJLN7lu4v+fe79TThJN3Y35PSRmom+aktxHRYOBQiA3bZ5UXssvarkHD29B4VP/SbjuA6fLu+FGJ4F0EKk4+84eQWB6rED++pFDJbvhb8ctGSqssFJaArnf2BqYRsyn4jsYsnDoai9SGWKhaS/MWPa/cI90yEkC3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MX11MGV7; arc=fail smtp.client-ip=40.107.21.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qJbzhV2XaHGmMdSngnam2IOutHbu2ZrsFwqi25vzEQ+OM8WJ9S2xeMDQg3cedSp8OrRuwaQ1murqJ2NOixgV1CGE/QqdByFxunU8QD2ndQi+4H01O6z4knND63AKTX6ETLCAIgZRVe+ffMuT5D2pDc12KnVBtIC6l6bjEPqvzTRyBu9W6C1X1njLr14uUAl0ynJ0Z2XPLymUds82z4FCIAqQoFTHt/mbzgg80fbtjzkH1tgwk32cTsnlHIrDn/yG/1QKJNH/Xg3vdqadYuE4GWWjCkKfHhmV5jZD+2y3k4L8U/WbSjIkjsmdx/rhicKqdQh1bFSIbGHs1NrUHoH10A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yyhXneNHv7jAPsamEUr3qhbfXnJZhC5+8047lec3Hao=;
 b=JmdaIvr+UOzfkpWKyeoxG83+gOy6e2jzvw7Jv5/+5INFFzuktoa7N75jhNkRScLqSEgLhbSyh6pOqsQRIkmd/W4pcjdKL6ZO2XfyHADmIi843vQLeAaGes7sHe1Auwp9wV98TX9xl00LEo6NHA/C4UEdjYIPvrIc5bDqP6V06f1UPEqGVMErfTj9y6FQVBlYUh8Er18qolhWqZXjxQfTlZvWO47/ryKV/njyS5dBm7PSXXl3MTSCNOnqEyW+amBtErCmmScsyEp9CZN8AcEUkcwiYmYRl5aDaZNZvOHggcBErH39/oxgOThh/BWJBkpa3LPOA68wx6ZTeMGaXOvrkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yyhXneNHv7jAPsamEUr3qhbfXnJZhC5+8047lec3Hao=;
 b=MX11MGV7PzJ8jSrWcfSFjdWdmgshadqKVfu49/W16n6r2AVgiI7YQT3Pys+1B23hNg3WpdiuhNp9aLEVyRkCagrollIDE/bKKq7Fp4p41j47nlf0UNbigYa2qWTTwcJ17H3R6djSDJpitlYD6eGgBH4wEmJIFDrwNX+g2pl0J+NwOjJWb1nwpYkFNDmLMa80V16inAgodh1E1V/Ieos0Z98JW6bJ9Nv+zDb9aObO2BeZO8/HN/KbSvWe91BGxvnTOkgsUJrG5eDjrLH/aVuoUJEC89A0KBMIeahZw63CnUo7Kq5nFjA8h/6pPyEltlYd291S1Fdv44skAK7W/Fg3TA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA2PR04MB10311.eurprd04.prod.outlook.com (2603:10a6:102:413::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8026.22; Thu, 10 Oct
 2024 06:34:29 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%7]) with mapi id 15.20.8026.019; Thu, 10 Oct 2024
 06:34:29 +0000
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
	andrei.botila@oss.nxp.com,
	linux@armlinux.org.uk,
	horms@kernel.org
Cc: devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v5 net-next 0/2] make PHY output RMII reference clock
Date: Thu, 10 Oct 2024 14:19:42 +0800
Message-Id: <20241010061944.266966-1-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0003.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::16) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA2PR04MB10311:EE_
X-MS-Office365-Filtering-Correlation-Id: bd970035-f275-4739-fef6-08dce8f597c1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|366016|376014|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?mwKkE8Q+y79Xk0Fi82+mZl4+/na6hLR1kUioEk0xnLXh2V8LmT0h+oOw3biq?=
 =?us-ascii?Q?JzhkrVdhAFf5wJBCZkENoDakIgghSmnRjc0Ou7mFStTWOb9XeuiB/mjDV9x8?=
 =?us-ascii?Q?7g1IzvEUCX9Odz8gb0xvHhZvDmM8myghxqwwCrZOJzG5Up72agP23pcd8Bcm?=
 =?us-ascii?Q?ClcRMm1w6TeqZBsy7dPKBVTIKDkwWnrBIpEvDgwPPC9t8M2PF6YOKItIobET?=
 =?us-ascii?Q?ZHi5yU7u1J2rvLIn2F1nMAmcaGHLKMI/6wYlU9IIj7OgAHTWICNQUR2KpPg9?=
 =?us-ascii?Q?ierxsLUMreP0GnFL8lONBEbuAskDY6NtO82/4A2luFDyrxYqFu8ImUoCz0VS?=
 =?us-ascii?Q?VqXdQruyHy8P8305YT4cRbMW34M6hKGHTbN+RixtSWrmwXbINLMSo6ViONSy?=
 =?us-ascii?Q?gpdhq1MmiZQpTYvQqS8weR+LDYo+ApxlpFbUFJtiTXFgso/WpFtOOO/egbI/?=
 =?us-ascii?Q?unjqXQNPE1BJxNEyu8A6hXpRTgf03XNk6c0vvmSl2GhLYRTlHYSgOQzA9AQ4?=
 =?us-ascii?Q?bMr0upFq8RTOYwcaVdhtouKsHcsd/w23QqPMdzJI7TDwAtZoqPrYPIAIFD4m?=
 =?us-ascii?Q?KcysXnG5Ds8SVpjkZreWAnY4zwhhaK+rLzIf6sY9e8RaJjPQGyn7OsQ1dwwP?=
 =?us-ascii?Q?jykVFSjnQQXaQ02G5L2XvloGDMmBGU7AaCnD5wixP+aTJh/+zEjwuC1rlLqX?=
 =?us-ascii?Q?ZqT2VFplZIH6bZbF6LW4RCF7fkUeg5xOpwBSp02az0Cq6U3xqDvI2w72wp8W?=
 =?us-ascii?Q?0D0B1S7FdVJq2TGNQchlR3QWWZb4EF3KWWZxyOQrMtYP0NtWDo7D/db/D3GN?=
 =?us-ascii?Q?RmVxAKoCuwppZmGhtYzgcLaGBm8AjsFl54dB70NFGexztWfin3eQ/Xc3EPAZ?=
 =?us-ascii?Q?2Qv4D9qEk+enSozcUZeGbrSmoqHbwzsLqCuPw6+vjBTJuBsk5NnSb+SW/BgQ?=
 =?us-ascii?Q?xJO6P0BUt0O9vu4bTxn7yEv28q9yaDjbzhHi9v6YDqdn9LdAnojqm9/TkOAf?=
 =?us-ascii?Q?YRHuE3Bp+jTY08jUwb3RWCuo3NW120Ac/xu/iZIk/2LmJuJ7rblLJZSoMUj7?=
 =?us-ascii?Q?O+gJa+I3bfzC3myge+3geG+DWGHFgLZ/ah+rxM8NFwuCuU08SpjSt0rszJAI?=
 =?us-ascii?Q?B5O7p5uDGmSslkJV2ilukadcTx1fULyXCY9lnCdg/Y2DTnwBBoqyea/71zGh?=
 =?us-ascii?Q?/QKXgU91wQvd9fdw9KKoxpNV4PkVPVh/8hQ3ySBm681371jTNTqQXu4w3cqS?=
 =?us-ascii?Q?27tHcVIKP+R6Z0q+BEMdCmRFk6SkAOv6tEm48dZmgYnw6BSs1W8aOmMKn4Kj?=
 =?us-ascii?Q?U1CpObj+rtY3hTNJrfolsWbGinhxq8QbMk1dgb4TJ7nKUH3qyE83NoqA2C0H?=
 =?us-ascii?Q?Ge1Zk30=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(366016)(376014)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?zbsKHHX+ZqZgtKNnQvKOB7pFSLnSc/4HXOSBF7WBZHlJSJ4UTcQ1rxZuajuT?=
 =?us-ascii?Q?NPr7+wyJRkoDXi27pJ9rqXD5PvWjrVmmdrCMYqWgcEVEWYoxnCSrgWT05Dqr?=
 =?us-ascii?Q?eREy/DEoxAc7pm0nGICKjbYFoznZSOXP2lrRrRLngVROCQMFDMneFlrypCvh?=
 =?us-ascii?Q?H0X6xo2IZ6N63wIZpZGChLwRAyCpY6UCpr1iORXWzSkM6gOz1EhMRhWOEHY0?=
 =?us-ascii?Q?8xZo+REJYO9qgWbLuupxZYecDMQK1phMuXt5vWiDejnSgR9NUCqhwDR8JGGJ?=
 =?us-ascii?Q?exvvEBIkPntnlumTiaYF8A5OeIX9wpnLAntTp+RbHk2LlDtMyNFAVB+gCGXd?=
 =?us-ascii?Q?7EfYBFL1CvPNk1wGR5avUXqajgBofg+E1duSPVT8v0UuA9NYEFK/qtbZ9mZj?=
 =?us-ascii?Q?vuWs1Gmulb8qW4OF4zQvq4Q0iXyx0M4k+9ab1kl7CLj9mkuWYaJjxG69bWfJ?=
 =?us-ascii?Q?/ru4dBweKyE/A9fn3BXB6nZ+XT9h+wKJSiVfFH8T1oeuyo/r8hl46Jq2RUIS?=
 =?us-ascii?Q?IEbq3/c/qfc+ycrnQduBrHm6OCV2oiByGMaM7jM4EXkycqMANrIftvH+3+bD?=
 =?us-ascii?Q?TaSnFk7JbdG1k4r5m92MybJr3r+q0h6RJZW7bv8whPZ1W3ZODWbBSZD7UmAe?=
 =?us-ascii?Q?KLGka5rd9TTqqGaCnb6rrBrCahrKcujp0ADUnnEuRr+aaBxQATh7ZHQlqViM?=
 =?us-ascii?Q?dHwP5r6fA3Qb9haqIE5o/TZk75u2FgenhT13UqnKevxGwbbKl9Z0M7JE7Mc5?=
 =?us-ascii?Q?r7C85P/zvns7t9UhTjLIxNcG0dtMRiGys3vrc5NfimR2vpbs58w74HvBVr8V?=
 =?us-ascii?Q?1KhsnXG5ZZuirVetvA8vQLHG+QMCqg4B9lRYq6LbDh/l+aGjgzL1jF/M3ORD?=
 =?us-ascii?Q?MceB0u26BA46Vq7z04d0450E4tcdOMrrOML13W32pNo6K8vTzgmSePNKvDsS?=
 =?us-ascii?Q?45retno5QDcqVzGmM74I6K6ksVxeNFU8loMakOuedGQlG+VNWsg9O40kJeXf?=
 =?us-ascii?Q?KrlhaDLFjTcwkRPfQp7//+9aLck9/NjudVpBgn6jh1Ni9ldH5YI9eDRhFgjO?=
 =?us-ascii?Q?j/YwxdLkVQBIp6AEy66fUgEIfXkHJfapj4fIYXlKD6876AduAqRiLBAq6D40?=
 =?us-ascii?Q?xEPCQ4AgJrTQgKmiJGHiQgo1guGt1N3Uxmwtz6PS035ADta5zSg2bIfV/S9i?=
 =?us-ascii?Q?n+NPqfZX0Ld/fGFckcNm6DyHH7EvB8i6POEK18wO5J/gzH/kEKJTuUpL6kap?=
 =?us-ascii?Q?4Z3iVf9kbUSDrku2DFPnGhzcuckJhrunUSWCUTyYk8eMxRvM+FDa8+OHrYGt?=
 =?us-ascii?Q?uXqj7HrKfh9Ize7gixABJl8ixPfHIQBeen/lm3pFIPnCvLltoGBGOrgmhFOL?=
 =?us-ascii?Q?NdqCI4/QAo/vdx7wkqlQbVazPjk1T1JQ6iDkQw5BfX8v2y41b93Czj9WQ5dO?=
 =?us-ascii?Q?bKVZg6fBGgW/3NdVwcSW6KV/OM6hWA95XGWoSavc1VeTacSMm2pXT3I8FwqU?=
 =?us-ascii?Q?f04AdStsWkCsjacNN+SzGeB2c8l3BGLQgCgQTllJstZzcAjrLYlgcD4JYNWW?=
 =?us-ascii?Q?77ia6Wanbf9NTsuSmKUtmu8JkCCQswDFLRmDhg4R?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd970035-f275-4739-fef6-08dce8f597c1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Oct 2024 06:34:29.3561
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8gbQIx3oDi06qAGySwXEkMoBnB3PN5XwBXQPhAuM1zqlsnhpioWd3btI4EdGjJl580bwJ4Yps9AlIe5gV7YQdw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10311

The TJA11xx PHYs have the capability to provide 50MHz reference clock
in RMII mode and output on REF_CLK pin. Therefore, add the new property
"nxp,rmii-refclk-output" to support this feature. This property is only
available for PHYs which use nxp-c45-tja11xx driver, such as TJA1103,
TJA1104, TJA1120 and TJA1121.

---
v2 Link: https://lore.kernel.org/netdev/20240823-jersey-conducive-70863dd6fd27@spud/T/
v3 Link: https://lore.kernel.org/imx/20240826052700.232453-1-wei.fang@nxp.com/
v4 Link: https://lore.kernel.org/netdev/20241009151223.GA522364-robh@kernel.org/T/
---

Wei Fang (2):
  dt-bindings: net: tja11xx: add "nxp,rmii-refclk-out" property
  net: phy: c45-tja11xx: add support for outputting RMII reference clock

 .../devicetree/bindings/net/nxp,tja11xx.yaml  | 16 ++++++++++
 drivers/net/phy/nxp-c45-tja11xx.c             | 30 ++++++++++++++++++-
 drivers/net/phy/nxp-c45-tja11xx.h             |  1 +
 3 files changed, 46 insertions(+), 1 deletion(-)

-- 
2.34.1



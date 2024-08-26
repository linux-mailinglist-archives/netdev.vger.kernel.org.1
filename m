Return-Path: <netdev+bounces-121779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 294E195E807
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 07:41:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C4B81F21CBD
	for <lists+netdev@lfdr.de>; Mon, 26 Aug 2024 05:41:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8460F7DA97;
	Mon, 26 Aug 2024 05:41:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CgbCudIe"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2050.outbound.protection.outlook.com [40.107.21.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DCB770E4;
	Mon, 26 Aug 2024 05:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724650889; cv=fail; b=RTJOZ5BHCG/hCfXj7TPGruoY5RQsCz0r0wIVdlq1YhLlDg44QQUcQyYJWyWVwI2OCztMRCarWkRUDoThQ2osOHpBtGlVk91Cc0WCfJGfLTQaxJhw4bxc6si5jsBiaBRqOM7EH9VGYjeknLnuOIny2fsvpV7fgACkj5lEfoa31JQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724650889; c=relaxed/simple;
	bh=g4S0KLZJbKiQFWXDLNA2hT1bEDBbp/1jRrixgmTPDu4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=DcR/2IVIeHi8ErG9I+qPrjGx+irrM/3qkuJVh07ZH4az6udJgoB0YlC7Qi+UNvfKNpXaCo2oSx85ck33/SLJ/iP/m1rJab9CKClHz8Da/BFeRB+Q9VvjkGrHs2ZbxQdgeRH+H4SulgEViBFZFfYuXPl+2NE+h5DKAC9sN/bkcTM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CgbCudIe; arc=fail smtp.client-ip=40.107.21.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M2mQVgU2j9pmn4D4jFded0Dq2PnQyKdtDGeaLicjdTEC/7or/4DiGAeBmq7kqb8cbpHQWoLiOgpgXH1yB9SJgJiPqBs1tul5r1qyTuT9HMcsbpdLvXmcnPqh20jvAnTALXKfM+1uSqpHe4f/hh8CfqUKVDRhZNafupxSfNSEmfvqIqsHzri+LvX8IejGVsMOJkH57JaITg24GJ5zzdkB22SjnXsAg4tXftD6llL2uf5b+Rzsez9OLv8ZYPCg1F45IqJpNl/OH8yDMzRsbxYxEiAsdJm3TD0G1Tjvsjoot5UAr3/xr+E0ApVVOq5lMRorUnX+X3o5dm6kEVTjAMqeyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zi5QfgfadH6Rzqmwc2YZ1QXOziM84vQYDXyoGepBtn0=;
 b=sZQeC3kp5VT9+fdjDMEg2uIFJsS5nzoN4ub/5sQ5cfyM9br5EqOJl+Q5mgkp8z2TxXrtZdnUNNPZZ7jVM8DadQ57iAeoSAqrmBRA29QfgWgf9fmD+rlXdSJrG/eFglYt9vl90vNYURy8iFuJCl03GltljPfhoRedzNRVuXlNH2jFKERMi0oxMoTiS2gNaEVrE7p5bUoDqz5Zwuy+eXoHK4AKEx69VsgISpq+qWhxoN6bHpQfHNTRsj/RmxJ8jtXIh79bFEuq8ZaS3J3b5qsNRK1jLo0ZdLfcODhH/nbKLEpkeJfegHk0UXOxe7PMHsG1c3YQI9kDyJxvWG1g9f4u6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zi5QfgfadH6Rzqmwc2YZ1QXOziM84vQYDXyoGepBtn0=;
 b=CgbCudIe3oOPV1GJ8yKojHkNcPC+YMeD9zSzqHyOGZxdhPCJy9p+9YHyNd5xcf1dfpcPD+McbxTQhkmLFTgy0o56c1ACDHH/BaGFNnAI6dByn6/ns+IdtsmB7aJUN1/p7G/VP2JGzg/Mo+8oYnaX4dAMnZsnwkIeN3g3Vwh3PJrRzlmbyUAKOAL69QntTtgI7mPzjOXarWN/VtSWVUIyVDtCDpMpdN0J2Jc+81i7FYT6YpvWUiTrnK8QQ/IPhMAzcyGVEmzW6Nan6bhnRhFqa7ELL+94PKdu2rbneSB0KxQRlORtR17szl39KdwHcg7uHqSD4QeBbGRNoDPuUv1LvQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB9075.eurprd04.prod.outlook.com (2603:10a6:102:229::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.24; Mon, 26 Aug
 2024 05:41:25 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.7897.021; Mon, 26 Aug 2024
 05:41:25 +0000
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
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v3 net-next 1/2] dt-bindings: net: tja11xx: add "nxp,phy-output-refclk" property
Date: Mon, 26 Aug 2024 13:26:59 +0800
Message-Id: <20240826052700.232453-2-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240826052700.232453-1-wei.fang@nxp.com>
References: <20240826052700.232453-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0156.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::36) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PAXPR04MB9075:EE_
X-MS-Office365-Filtering-Correlation-Id: c5c9b415-ff34-4f26-15f0-08dcc591b942
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|7416014|376014|1800799024|366016|921020|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?GhXqVvRJI7v7kTynTVaZoKQtPpC/TnM6mWJGvL+aOiGCdMbt5KMSpC+g3RbZ?=
 =?us-ascii?Q?5/BcgqwEVG+kkRh2dwJ3J1CaFz/Z6K2o2KrfT8JP+b5TQua6jxJBRYYoN6V0?=
 =?us-ascii?Q?EzVpT/apCYEBXnjepiY92rqeCvpfmgB0yT+59Ok58YSHnUwhy+tTjZdYY9Zm?=
 =?us-ascii?Q?VYwOcqoIC9gdAky4h+RCKQNikA7UNcba6spV4UhfWhFibZKAs31eNSbU/8/N?=
 =?us-ascii?Q?0UHcmgP7ijW77SncHWebwMw5nzg6bn//gZ0jqAxaqoG5drj6x9eZT1b64Nzr?=
 =?us-ascii?Q?Eh6+8TrgB1O8qx5+q8fdfLhdrjUH7sajBocs6hCmbDGW/P026Ir39nsLd0/U?=
 =?us-ascii?Q?FxTB5VV7d6HY7cE/RVVxpHhkYgKtVG9kRjfNNZptzOWlntG8+FocCmKPxGuV?=
 =?us-ascii?Q?Vpcs9803a3XI7XDpB0mK/JqURYQnxX2S4aXprr3jPe/COB7eaBM5FIjIuGQ2?=
 =?us-ascii?Q?JGTS2sNARZtrzVw/Hh1iZz1T23kyNNyvWn9CHaJ7b051njkBLymhQ/gyidpL?=
 =?us-ascii?Q?1lXoAB45LDKWNWS6aGrFrMu8tpcogKeW0scpgogIQ5QHZ2gK4caS0b8i6D2v?=
 =?us-ascii?Q?IJKmvf4PaSAg3sKBlZjWgKlw2xftTHXza9GYvaxHD/QgpF+JoS1m5sAkWupu?=
 =?us-ascii?Q?imjnc7IYSq1lYnTdhNq9SdVuKvbOoGz7R4jcWlsbY/J6EyJOWFT712siNfB7?=
 =?us-ascii?Q?qN5DnszbQb4VlJMtLqOBNER5kH2TKW4KgjF7adgLq2KQXnlYuYDFJVkZeDAz?=
 =?us-ascii?Q?MfZcmvHo8CBaidnZzbm4dzynkOf1wb992alZOpOMofOXwLObVBkwwaap2V2s?=
 =?us-ascii?Q?Vk8U+AusXlHb6G06FzApiGsl1mfTxJvlIaQy+3q6zCMKE+pJHcTeEGEtHWcB?=
 =?us-ascii?Q?x13bFib6LhtTAW+jQNNQYiOULZdnXV7CSnGs9dLHv76Y6kMiRQLWlC7iDeKa?=
 =?us-ascii?Q?lZokQjcY2gzZoJ+1qdzjnXu/fyT+97lDwuyu0hV2Ip8Lw78o0jCVY/soUJB0?=
 =?us-ascii?Q?+hx2Ilf63f50pCNe6KzQmmGPuQT6wNXCry31J9sepSay380WJD1ZQZe+itGz?=
 =?us-ascii?Q?zbFSKsnyXKD23ZcF8iFf98sSt59wMDE7YrLNXQm0bUj28TsaXGWnvkhXGwjP?=
 =?us-ascii?Q?ELD9OdNPrfM91rADpZ1qjmlUAE/ci7aMfCUbm+dtdg4TDkWGOKf3KO+6pcij?=
 =?us-ascii?Q?krydYlmhgAwye5C9Zx1Uv3t6i0eKQS1lGZuvX+cztfN9CE1N4kzwKZEMT4Ww?=
 =?us-ascii?Q?YFsnc/CUBrsFThlpFoi6OXvadzN0de0+L2IGSoJt+puIwXNgF1JmQOTVFmFL?=
 =?us-ascii?Q?bXaWC+FXpFPaAWonPldChau0Cqf81ePRFf5VOKWDvwkRxE03w+04JrLEvwz3?=
 =?us-ascii?Q?ETLJyLc2a8G5Y2+D+Lx/CjYsW6eq7NZDMJuRj1hVh94rZ8+fx3RFwn4SbCFW?=
 =?us-ascii?Q?9TG1+gW/zIU=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(7416014)(376014)(1800799024)(366016)(921020)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?YJ3sp04ftqwKNcnqIb/dReDLfjLjL1YDpRZyJSf0jUUi4UVeEgMwhrGCHbyu?=
 =?us-ascii?Q?z07v2y8nmBESUIvV68cLThmhMuUOgnwhsE9IDb4JAL/gZqQz/ar/B41d7//s?=
 =?us-ascii?Q?Zq+ne+UXPi5OPvzvUSicCaEx+kMiW8Nu3TOQKiZLY/E70Y+6O35CGQKfaUms?=
 =?us-ascii?Q?W796yUumoNC5gOfu14L5iMd3c+QplY5XBCYl+ezKAVjFB2Hi4Kn7ySYP0SBN?=
 =?us-ascii?Q?rWbhoYgj1Q0vgDhlwGHEiPjgOgTUEL1aj/V7YLh9EFX4Y7yONT2WxnTy6jBD?=
 =?us-ascii?Q?1JeZuXqgoFS395KMWdCaeFHtjK8VeM/+dbfkhbXnuuE7AkOSTdal8vy6zbSk?=
 =?us-ascii?Q?NCwzb9rjE6EkGrYBH+0GAeFYgfXgVgiK6djydY04/Pi0mYQOqhisT0eeGCjb?=
 =?us-ascii?Q?PgViuR2NwpjFCGH89ApHi5xCm53B0WNagwBNXExyBHXV9WQwidFeROUvIKUl?=
 =?us-ascii?Q?OtqLuCehz83N7kSiBqzT72aJc/b8sF2HxHBI7VjrLnMslQHhbHH+AICnHhj/?=
 =?us-ascii?Q?GMXijLBYZZ9IdwImskqF1hOFcWXjMknVDYCQguwZccCmKvrubj6cZEOYHaKv?=
 =?us-ascii?Q?Y7I4DiFs2WjsSZDZBmkFaTS5IWRhuWkaCmOlA/oPhScCvbC6ftnWbt734jWl?=
 =?us-ascii?Q?KUYfB5M9WBmAnJ3lZdc1wb7bUi1tKgn96t4SpVFMf8KKsFvlmywK/cbJuef9?=
 =?us-ascii?Q?hnCQnRV+lJpJikMhi/6hKmzUro3hQULmfp+som7dlYp9z99gq0Rd5BiMEkvV?=
 =?us-ascii?Q?m5gh11T+rpNs9V2Zv5muW5T+P1m6OIHUMo3Yfngn6Pxiesl6oCoZi0y4Bth+?=
 =?us-ascii?Q?nBlOvTuktihE8uIzRqnLqkWycWpaAtglGQwGuIuupXRDSplUKPz4ymXc3rZn?=
 =?us-ascii?Q?tPZ9gcyY9LMvxDpFDh4Flti+/fW9DVXYTOQEpryicFM05dOoWKjROhOFQORh?=
 =?us-ascii?Q?qGM7+i//WQFwY6d2ylxE80i5gGP8rUM0YtSSuQbFxCQxJyigwPJs0IyAyBEm?=
 =?us-ascii?Q?Et2rSPOgtKM5adcm5bkKTLG/3brd3Uqt91soy+HoHxLg9x+3PRdAFY0Lryo4?=
 =?us-ascii?Q?UlH5YGvhS92LVuHTWqmF4tLAJYWHoLsBWgJDgaAhXl3QcDXEIAe5iuWAIYSp?=
 =?us-ascii?Q?zmGfskA1sBucSBCwKhZyFoUvXDLkxT87xfxu848il791+U8KKxik0/5ynZFi?=
 =?us-ascii?Q?V+KZVmfowte9wICTOQ6DJAyMjU1gs9c39DG8raCDEI+ITMGZ6MVeh9Marsos?=
 =?us-ascii?Q?SKQV/4bsOuu4uSOu5p0ua22UhzhsW54ecszabZl4plradctUBwxfHOUKfhPm?=
 =?us-ascii?Q?D2PEtTOb/sCOjbrkpkgr//klTucYo3NLhqKYrn+X9LW2mm6AnjGkIyDhMTCM?=
 =?us-ascii?Q?XI1teRHgF3Q1JpxYw4rPQOr/cbNXWE0sW9gHPOkquwsW7GVxPEojSXzF0Eq6?=
 =?us-ascii?Q?u7Yk05Rpqi3k0ptJB7Cv6FVi7UdME0oGiOj+F632H3kVS+4RMHm3l2rmXlPO?=
 =?us-ascii?Q?mUJPfR4P2WkZ9g718Ahvggchsq8ZxrTNBKI/HcQHDT9S3aGOmsPXxhBg+MhG?=
 =?us-ascii?Q?vM2iCSXIn7XUcVMKBphtn4Byci7Nfe5pn5wTw3gw?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5c9b415-ff34-4f26-15f0-08dcc591b942
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2024 05:41:25.0299
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ig0o6x1DGxwbGes1n+Tpn9IoP+fI4RN0yZQdSpqwsUxncAB+qW9V68EcSL9IeYbh5i6/UCZ+Lc5qARvueZ+YIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB9075

Per the RMII specification, the REF_CLK is sourced from MAC to PHY
or from an external source. But for TJA11xx PHYs, they support to
output a 50MHz RMII reference clock on REF_CLK pin. Previously the
"nxp,rmii-refclk-in" was added to indicate that in RMII mode, if
this property present, REF_CLK is input to the PHY, otherwise it
is output. This seems inappropriate now. Because according to the
RMII specification, the REF_CLK is originally input, so there is
no need to add an additional "nxp,rmii-refclk-in" property to
declare that REF_CLK is input.
Unfortunately, because the "nxp,rmii-refclk-in" property has been
added for a while, and we cannot confirm which DTS use the TJA1100
and TJA1101 PHYs, changing it to switch polarity will cause an ABI
break. But fortunately, this property is only valid for TJA1100 and
TJA1101. For TJA1103/TJA1104/TJA1120/TJA1121 PHYs, this property is
invalid because they use the nxp-c45-tja11xx driver, which is a
different driver from TJA1100/TJA1101. Therefore, for PHYs using
nxp-c45-tja11xx driver, add "nxp,phy-output-refclk" property to
support outputting RMII reference clock on REF_CLK pin.

Signed-off-by: Wei Fang <wei.fang@nxp.com>
---
V2 changes:
1. Change the property name from "nxp,reverse-mode" to
"nxp,phy-output-refclk".
2. Simplify the description of the property.
3. Modify the subject and commit message.
V3 changes:
1. Keep the "nxp,rmii-refclk-in" property for TJA1100 and TJA1101.
2. Rephrase the commit message and subject.
---
 Documentation/devicetree/bindings/net/nxp,tja11xx.yaml | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
index 85bfa45f5122..f775036a7521 100644
--- a/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
+++ b/Documentation/devicetree/bindings/net/nxp,tja11xx.yaml
@@ -48,6 +48,12 @@ patternProperties:
           reference clock output when RMII mode enabled.
           Only supported on TJA1100 and TJA1101.
 
+      nxp,phy-output-refclk:
+        type: boolean
+        description: |
+          Enable 50MHz RMII reference clock output on REF_CLK pin. This
+          property is only applicable to nxp-c45-tja11xx driver.
+
     required:
       - reg
 
-- 
2.34.1



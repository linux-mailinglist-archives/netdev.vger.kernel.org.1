Return-Path: <netdev+bounces-236267-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E34BC3A78F
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA28E1A4758C
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E002E36F4;
	Thu,  6 Nov 2025 11:11:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WObZZ6Lh"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010061.outbound.protection.outlook.com [52.101.84.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1E452EDD5F
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 11:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427479; cv=fail; b=Xq8ZiYekTqfKs0NsWAOVWcQH7mTMSjqjMNfgytsq/VLhBBzjB4qWrqUeED9+9hoxcGl5alSvcMqXJTpq+TRc3ashiaoIpbrCPDrqUcpKtrFkrSB1QcSMBieZUgAToOY1Vf9fsFjZcfEbf6kw06Wg64RQ+bN3R38762/z6mKYiP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427479; c=relaxed/simple;
	bh=D1O0qng4j4x8xfd505QGHlbUTC5I92apbKQUZfcwfG8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ONxqf1P2IH7Yg6P5sKyMJhyM5z6oj/TpGgtDZYK3OPUdTDpX8lHMUqLYXC0L2ND4wzR4cO0bZfAjy4pDnJQT9aTXEjK7OLgviLTjxaOmUhh2nf8lmr++QmIaevbia1VudRvysKv1jAXwAuN50q5YR5fJJDt6MzoDiHMPyFKl5vU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WObZZ6Lh; arc=fail smtp.client-ip=52.101.84.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QXbYDhxy0BZK5dFrrVlt/ChItWCEmOZuiu8yzf2lbS5N6YAMRnyD7mKxHr9sjQ9KY1GEXUV7ZA7BvC5pk5MlJ1F9DhVcxiziwjMR/kAFPJnjPtdP49Hl/Ml0AXfLAjUxeKb/ctUE9kbXB36a+HtPPDJ7TmrPjHoc4H5g0bI8s08Wq9HJtd+Tv/VmmvZkYcEwnUFzHpT0GsWxDbqrg22TS+3sVuA4FShDjdTj5IyG0vOzqYfgU9iaepgPIJX0VGcDPXFC9HkxMwhf97GlWwOOkC7nqikB0CvmP4Jyq/IomjbY+68dreuVtFZvRvXCVqlpXrz+5M+M1RmX1h6gC2ktjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cwmfGmuX/4efPXsrKge8MU2lP8FUvFamgJYDUcAUfhw=;
 b=KEYDTO7oLxebBsyF2giY89AyA98wErQuwMC3U9Pb5BZqQqfGdhbE4O0LO2XPq9UFkZrlJfzXG26vUkHqNO6o2Yft1EysTUVbixa0ZbYqUkY7xkmz65dgCyxHyLIwIGUb1dW/Ub+R5B9PLL37GzduUXl+PTTiw1uyvCe7bh6dkyvXTSVovpFbdA7yrcim5uiIDvjznB29wKCRUzhQyL1ch8I2IO5oM8NR3jlTidAE0qGC6aLsaAFFh1pRDIhWcmoIP2H3p6sRfDZ7q9kTUkC+YOs20h1MRHTan5tJ+hKFluEJGFK6W3nvy+PR3ltqtwUO4rLJuCPrxRfY19pxlu68MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cwmfGmuX/4efPXsrKge8MU2lP8FUvFamgJYDUcAUfhw=;
 b=WObZZ6Lhnl/kUWPhHyb8oBWxcGiA1eiDqyLEgowUpGYXBN4+gWLnKbkKHnOkVX9LUquVgugYs1jMUH+wrQGMPllsJMlEUsIBZ+LE+VuxIp31Np1M8iF07OtaI0RgpCS+zR4cLlU7DoBuNtDaH7CaJ2i3VHo7DZHr5A2LzqvF/7NRYkFdaO7ePyfTTK88ZRK4+71Gcbr/INkVPK5QnEAF9TATz+REfPO5YVsxNaosA50s+F/ckCN3iK0qp//+Vzb5YY860XMWizxAr8PsklzTgm4Im6iI9nqJAsRam/x+Gb0GBRaxmVBxUlNYs+HVDlGWRsE9S2RKrmDuZFx0yCuzQQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by AM7PR04MB6872.eurprd04.prod.outlook.com (2603:10a6:20b:106::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.12; Thu, 6 Nov
 2025 11:11:14 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::6861:40f7:98b3:c2bc%4]) with mapi id 15.20.9298.010; Thu, 6 Nov 2025
 11:11:13 +0000
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
Subject: [PATCH net-next 0/3] Disable CLKOUT on RTL8211F(D)(I)-VD-CG
Date: Thu,  6 Nov 2025 13:10:00 +0200
Message-Id: <20251106111003.37023-1-vladimir.oltean@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: a172d8d2-1ff0-411e-0388-08de1d2532d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|52116014|376014|366016|19092799006|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?P77P1hO0lMX5d1RrYc4wM+XLwyS3XxgRW3+J+Z63aWA3nqeWgp7MNwUyVbR7?=
 =?us-ascii?Q?Yx2kw9EcTyE8dAcoN8peTj0epkMssaVOuzJ2yn/xSfP2f8gRVNktHcIccihR?=
 =?us-ascii?Q?ncGpwD30ceed9jTYSCKqykBplw0Zl06RQfL5d4mpKFZjoHkuGCBU6AUfZznI?=
 =?us-ascii?Q?V/ftXY7ukgfxU1op+KYYHsooqZ1yIoll35tFVBuiDEjoNyj2eKy0WZt/qm4r?=
 =?us-ascii?Q?e+R0o3Ce8M8iPCsXjrNEVEJO/0JehUOiFjFwie7L3y70BdVtkVhUG63XhHsL?=
 =?us-ascii?Q?mvI2Sk00GtZaHsGAfN5x6J2Fi3+FCHr4vOH/nEusq8ZKW3gII1TbFUcRAmH3?=
 =?us-ascii?Q?FR7FdGCdSIC3D8IXeFmTep0UJXEkmigMCOCMyhGW/Cs5X4ERN5D+tHSb+VjQ?=
 =?us-ascii?Q?CL0ulqSn88LhKfikvmhbDcZkWkSlqVtNkvdURar+QCEPW7xxcTr53EL9YqK9?=
 =?us-ascii?Q?qoe1ShTxvNvmgH2XKigvd7bG7pS6df3P2FK7epflWqPvZBxig9FKdyXCoOUI?=
 =?us-ascii?Q?VNdXIolWRf1QIRisrscX11Dj6BHCvcyJq/7FZkhOnljiZApIROwqBMa2sBoN?=
 =?us-ascii?Q?IOs920076gEObs+AmGroYDtcTaAT7tUMSCos+JhiijK1NeQPF3ut65lTH3YS?=
 =?us-ascii?Q?wgQYOyFYJwS66i9Veb8pg0urrb6G+p+JPa0HFly/RNP3SWPuR+H/YDkP7axT?=
 =?us-ascii?Q?cSe0yuUEtJYVN2UxmZJnckh0FaG6pFZddqfwbuj2N+iZuuQEoFyiJh68LW0Z?=
 =?us-ascii?Q?f07yUJjmdBwhFhMe4Djx7GRj+oZnU0wKjdl+3j4vk9/5NCuWdaaTfk3/Cc8X?=
 =?us-ascii?Q?AGaWI1+M3e9dgIWgS4i9f6T6IXa1SuzbfcZCC9zPjmRnrKor7M1gMfksXiMq?=
 =?us-ascii?Q?1A/YHNYiVVv8bSEoe6mOPD44G7p5xtybZHqH11vHUmDpHH1B+wwYablDNR9I?=
 =?us-ascii?Q?LWxEtEXotyK2f1RAOb7Yv+qAsN+7DJSeus1zJ4pZALeX1ez+0p8mWac0x4SU?=
 =?us-ascii?Q?BtMCYyWINCP5b/XaZYEA3t65ni4C1CU3VPguQu4SLTcvstWwDXE1GZ52MiK8?=
 =?us-ascii?Q?deycCmnTc1tLLQQ7UXf02jlPNc0mZrDt61s9ykWK4bDLEGNRYD8fktu2iyjW?=
 =?us-ascii?Q?FUFrqdWniolDfoqVJJwkHBaVUa7STWDUtSYbN6GrO9lql94HLUS5n5JUIjeH?=
 =?us-ascii?Q?2hR2mlFVVos1UwTlSxFV8Ms6FY8DD0U2zwUo/qgI3bY2ttBYP7t6uQfSmRUf?=
 =?us-ascii?Q?ECqFP4Trljy14f8ci+YLhSv9xGG5JNptQaKPn98UakphYBAohmxziTKWo/9W?=
 =?us-ascii?Q?SsZqjH3kvk4dPqzbBqt2ozE6IGijW7rTXEkvMAVAmZU2+0EsggNlLij8lLQE?=
 =?us-ascii?Q?FtceQkY4Hli5aRpm5lJwsm1rV2MKp0p4m+/VLaln356l+E5tob1s76cHYoFv?=
 =?us-ascii?Q?JVQOJLxYNNYzsmlm9vV/qrUVxuOmmxyi?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(52116014)(376014)(366016)(19092799006)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?ev+RF1idy18p50U+YTUjD1kVaUkoTtdndSYuVUj4TZMLE6NjPxatpLC+kzkg?=
 =?us-ascii?Q?tYwiLQbp+wm1lHALQlFgzE+F4If1L0SL7joU8mCBrzCuz88zsmHdgQUTx1LK?=
 =?us-ascii?Q?uAGJzgLcJ8nZv7uFfvIpHhP2WKK5HdmgrLXSd4UrnvLwEWXUAhGbAJGvJo0A?=
 =?us-ascii?Q?Zy8ISBW5riyLw44lSfoNNYZWB3PDi4KF+bGpdhiErjUoLIJyohnCg4e9n6wL?=
 =?us-ascii?Q?maH/wlYDX5jw/QPVuiGUCcZW2aXauS3SK/IcRQffWmdz5nr1Bs9gwXIj+SlL?=
 =?us-ascii?Q?uokPrfnUBEq8BzucW/+97zP82fZhvk+/UzmuGrDyEIZJ850SW8x7i0K6Il6h?=
 =?us-ascii?Q?J8f2kzgm+yo2xofQ4mHi2YekXD/GglqWVejxqzdHPFK0S7sxxpMOMiw4x66S?=
 =?us-ascii?Q?7yc66mi/CLHojfkjC/CQ5ptkv6owTvVjGMmZIUtZNbHGtvTJNpHZ1t8uYto2?=
 =?us-ascii?Q?d6rGFN47G6uDE4O6t/k2tjI0GljdSofEATdT2ZV6ZP6Ki/u5rt5kwkL6VIM8?=
 =?us-ascii?Q?TVY9yWAI/3A/kRfhJ0t7IwBpkmNW0fxthDIsNjo28dvJCmnHWliuMf/R64OE?=
 =?us-ascii?Q?OHRyaNu5rLH0gRBWVtJNW4B2Xlpd1swFl9xQ8hNv1+4ps/BtgLum6o3GSlKe?=
 =?us-ascii?Q?qRT6AlIGiAwVZE1odZ7oIqiSf9EQKZKEyeEbUA6ykNfJelEd/ZXgsEVhoneF?=
 =?us-ascii?Q?kSw9wQpMPjiOua1dH6w+McooN3xw3+g3Kz7ohM6JC6vP4XzLJxl78M1TLODX?=
 =?us-ascii?Q?+Ppw5yqozrx17ivobJVT4k21BjJXly1sb/DMUfIBHXUZpyyAryCC0f2oP08D?=
 =?us-ascii?Q?ptU5HVPpdNzhjeKYDettGVt8yreBzVhYYUvEXfbXVqlH8z+9++7TTSSRe/W0?=
 =?us-ascii?Q?WFG4JQAOxFP+u7AyMCwR9hZDL2x/lI64gWm/ML8MZgZKR2C31qbYfxHSLuW2?=
 =?us-ascii?Q?awESth8TgYE9pawb3QGvPBBTv/Vmfa3sqp+3/FhbvlHIHWq1XFzyuWZ+3SYp?=
 =?us-ascii?Q?XgB2nUnLbFxpCPD9uomoghiY5qC6TI42B+2jPo+jCSbcpRLwyIyD00n/PsH7?=
 =?us-ascii?Q?qetIB9F1C3PYx/DC00yCnJis/wWf06HXB9mFEKcopAFVol8fizLfDHS/+r/p?=
 =?us-ascii?Q?FobNk0fxij3Q55BCDoBkx0+wkkcuJZ8Ad5PyjOSgJUhXcJF+Ugfu/ZUnt84f?=
 =?us-ascii?Q?9PM9iExtL/lMWHoE/NpRkrJRVTVapbfRKiasygo68rJ93ZP5L6H6YDOER+Vd?=
 =?us-ascii?Q?lWaJNmdr/19OgIgcwGVkWT/vymzlIYhedf3Qry0rcSAowvgePBsFKKL3G2jf?=
 =?us-ascii?Q?gZ9J4tV2R+lwqUrVLEjK4tYUPI6DyepEo/iqV2Mqh93I/CR95Qo2HRgWhwl7?=
 =?us-ascii?Q?4cZVjemn2PG0ejFK8opoY6dL8Tpe9ccmuQmL0NtiqxjzqZJA21e93Yce10f8?=
 =?us-ascii?Q?QNBgcEtmG0cgZ/W54J0y28rgX7YFljCCLUn84mRXx1Cdm2T6HzE8gVW6iQqC?=
 =?us-ascii?Q?Yvm+KCBKkan0PsjAqTAl3stGC8PYHeT+TsH2+ab9pIPCocNFwEUId35pxdq0?=
 =?us-ascii?Q?B7EtLLmfkFlpRkZ19BsOe/p9tSqI94+SrXJVEvuP54nE+7Jz1R1uuU5CsQ0J?=
 =?us-ascii?Q?KuL6iRDATvSjzLFNjQRzdgI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a172d8d2-1ff0-411e-0388-08de1d2532d4
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2025 11:11:13.9226
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: imgxyFBlQg8vOmWpmLVh9UEe8qTDelv1Wed4DJpDGCOQbWWMAyfcfbB71SDiJtxDJlG29rZ6ExKGysOCv/YJ/w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB6872

The Realtek RTL8211F(D)(I)-VD-CG is similar to other RTL8211F models in
that the CLKOUT signal can be turned off - a feature requested to reduce
EMI, and implemented via "realtek,clkout-disable" as documented in
Documentation/devicetree/bindings/net/realtek,rtl82xx.yaml.

It is also dissimilar to said PHY models because it has no PHYCR2
register, and disabling CLKOUT is done through some other register.

The strategy adopted in this 3-patch series is to make the PHY driver
not think in terms of "priv->has_phycr2" and "priv->phycr2", but of more
high-level features ("priv->disable_clk_out") while maintaining behaviour.
Then, the logic is extended for the new PHY.

Very loosely based on previous work from Clark Wang, who took a
different approach, to pretend that the RTL8211FVD_CLKOUT_REG is
actually this PHY's PHYCR2.

Vladimir Oltean (3):
  net: phy: realtek: eliminate priv->phycr2 variable
  net: phy: realtek: eliminate has_phycr2 variable
  net: phy: realtek: allow CLKOUT to be disabled on RTL8211F(D)(I)-VD-CG

 drivers/net/phy/realtek/realtek_main.c | 60 ++++++++++++++++----------
 1 file changed, 37 insertions(+), 23 deletions(-)

-- 
2.34.1



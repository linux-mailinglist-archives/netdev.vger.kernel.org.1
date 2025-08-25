Return-Path: <netdev+bounces-216372-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FEDB33543
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:39:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 584DC1885B35
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:40:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEF5E2857F9;
	Mon, 25 Aug 2025 04:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="W4I1uq1I"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F4B7283FFC;
	Mon, 25 Aug 2025 04:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.61
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096633; cv=fail; b=CjMg+EDfQoYU581P1XM86X+C+LBuPEYPMVAcJLpXdaA3cXfekwZjYfbLvO1jzwUcQldC1GvjL40FU6FXBeaiAlKu8HJCgn7NwI2zbIeXmNIrU3gDrV7YBIFJ8Sv06bQVDBenFxQoUSXRQTfg/eAVDr1RPgTiGqe2gjXzDjUhO8E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096633; c=relaxed/simple;
	bh=HcNU9F8SolcbMat/3RRzsU19/rycuyujw1bItTw8Js4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TeLqyn7GfTXkIg0bYZeSJ8SvNJukhxYDc30nfrh/Hm5iixSCLZ4Po8N4bzz3uXaoYE4JR+XBipkF/MGsOgL4ZIVCQaDrVa4rLJzNFeQaoiUoe6YHhizQ5QgIXPKu5VzljStgTa93RTNFNSs5UTiUcnk+wreI3hofWwBI4qxk2cc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=W4I1uq1I; arc=fail smtp.client-ip=52.101.72.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cek15SMVdh7bkRPrImcDYnfKU8kN3sypzDR5FRHnQbeQe2btdpEuAcTlQ4zLA+a8NNH2hhmbouv4BmH9GIwxYH3TFnsQRyMoB12hJZ7rt0pK84R2I0jtWgCbnvBjGkqxw2/ImREQQTaNWl2lsfyH0upwjtEmAg81ttQ0msdyenzT0K+sVkdiQMA+ucjd3xWzuNafrv8vWelgykTAUR8/GconTz/8YpwNmEDQ6DPY/VqVfy3gLHKoq+W8srCCqYNqnirVkFwCgZC/Ik4e+ZqrZ5k1mwfhVIhUxDFcsy1TvHdaWOjnzjWrxOHGeYaf6rAyLLtcslBDotJHdRG+mBxisQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dkm4uKGuhvMjNUrPhXErUWX5TkWmSeE+eTt1E9hi72k=;
 b=iN61yxgvABEkdB7XeuXKuFyP2q4lbk/F6LclkQTMGPC9Pf1xiQla7TMNO8A/a7ZMvUwwo0VkIWG5dbzfiiIqQmEB2GpzvlbmHeHzgs7JI6FcFYZMFRL1mN3jFNWo+CYeNAvdHgzWWKqX3a+WAZRWypb4IZkzdnNcSlcnt0fpMGFFriMYXOrS2JMYBfqKjjNKsg0fZkPmDz02jVjC4r7ydnGieylh0vvz87y6T0SGK9QNi5+O3rFTsGvKBlIqz39aS1rQHpRYY1swM1da6iEf8aW50vyxZCtgY3mnhkdAH13GGa9khL6xyM8Og2/kUTFlY8Np4Ml9MCm9YreMHaeqcg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dkm4uKGuhvMjNUrPhXErUWX5TkWmSeE+eTt1E9hi72k=;
 b=W4I1uq1IrFVkhVLAbLWtkBzysi6GW4A077KwvqpYTAoawyPD/Bhpm52nwNKc/DvOdiLn2507g8j4BDWdlWcDZQCwpNuOH9HVxwAaooxwhRQJBSEd1UW8M1abg/JJpn0yn47Jxv8YrQjEl8BW4t83rfdkodJlUYQWQhhI6SOJrEBjLpF0FZbPUIupEp2Ei8EtA4Nkpd1869nSE4YAJQeqoHZWDT6kvBdu23BSHs5f5DmUw0Xdir6fubScClOlSwW3DbpFilsWErlrlQRfrfsMjeZmmEQtObcx43y7kSH+wVeGtQtzsCYmrOeO7PMgJvZWPSySinGhg2H8q8MoNvCsAg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9661.eurprd04.prod.outlook.com (2603:10a6:102:273::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 04:37:08 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 04:37:08 +0000
From: Wei Fang <wei.fang@nxp.com>
To: robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	richardcochran@gmail.com,
	claudiu.manoil@nxp.com,
	vladimir.oltean@nxp.com,
	xiaoning.wang@nxp.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	vadim.fedorenko@linux.dev,
	Frank.Li@nxp.com,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	festevam@gmail.com
Cc: fushi.peng@nxp.com,
	devicetree@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	kernel@pengutronix.de
Subject: [PATCH v5 net-next 07/15] ptp: netc: add external trigger stamp support
Date: Mon, 25 Aug 2025 12:15:24 +0800
Message-Id: <20250825041532.1067315-8-wei.fang@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250825041532.1067315-1-wei.fang@nxp.com>
References: <20250825041532.1067315-1-wei.fang@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0064.apcprd02.prod.outlook.com
 (2603:1096:4:54::28) To PAXPR04MB8510.eurprd04.prod.outlook.com
 (2603:10a6:102:211::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8510:EE_|PA4PR04MB9661:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ec9c3a-614f-4088-9568-08dde3910cf4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ohctvprczIhRV4z1zzbh69zEWaVw58q+mtsDGfM3cwBEEsCzzRqrM+Ru6Wy0?=
 =?us-ascii?Q?WnAdyfyN3FpmRruEESqO8E1qBfLnXQ+9Ka7CV1K04WajRxi7DfQTeqlWeL95?=
 =?us-ascii?Q?VUg5F3rm6u5edYkQ7vMver6eo79ifgJkUMknMYAXFasQaSLHKun7QJg+nLri?=
 =?us-ascii?Q?Fp+JJD0sqedtzSrasPP/2xF5R8/Blunuyo9BZYvc4u0II6nZHWch8sxsDRxR?=
 =?us-ascii?Q?CUZXPHiJ+IQ4Vw/IQbcUTwckoLRkxDNaZe0oo5tn7qF6+K3vQjHNYUPUSYc6?=
 =?us-ascii?Q?DBsIqx0dtC8cyTHCoDw++hVFeWEc/gGex8PJn0oaTuWvWRbUM7jEihjHYLNi?=
 =?us-ascii?Q?6gBBA52A292CiHhqw3946vmstdJfGl8lOCkK9x+gRtq084WWfWD9+r8tg+Bi?=
 =?us-ascii?Q?UbIFSqhoBSFSVFvg2Fn4HjsRuHu4+hWpHNLv4+4T1xbSU9H4NHFM2+tDIu5W?=
 =?us-ascii?Q?iDE/gUGBGNliFTEoHYFoHMBdWowcPQmXxDvCoF0+UzIAIk2Yr6Cuh4IwAgXN?=
 =?us-ascii?Q?OpcwU4s5N2HRuv3RC1xbccOn1876I1UqFr+pAZSBRtt6lRFFUhlOwO72WNOt?=
 =?us-ascii?Q?sxUhypvwI29eknkVoVcNaHvhSqQ4GsWqWv8U8kyY6Mr1TNE4R0avd1XOzLmF?=
 =?us-ascii?Q?lHCccJ2C1f+smZPb45CIwGyBEng1RgKwRgbdP8XdylVdMhx4wdqn4VOlzAE6?=
 =?us-ascii?Q?sDI/RhMbm6CSrw+rzvey7/9HPlmo5uYboHHtcNk5Q10UbUXsPSnjCm9PKw5W?=
 =?us-ascii?Q?hIKfjUxqR48I4gEIOxJuGboRmrBROcCX3uF8oLP/6joD1QoQWi3kHNO5Hnnt?=
 =?us-ascii?Q?DaPXwgkhLlI4RUsgi+Hha7aLu1plmETVbgWO/hkXTMXEwgwrJ4XDRARB6TA0?=
 =?us-ascii?Q?Zrwh0pfWnshZNhNYD/wP7P25hH4qIm9PGebTs6fPdvPjARZHz325B/bJcUe1?=
 =?us-ascii?Q?nTXbK/988xkR/1+yuuk8g9iUw+vHHhMb68MmfwKRJj/cf43fFrQtzpPmtnEN?=
 =?us-ascii?Q?whkkgEoR53f9BWQwMBZazLd8f/bozGr3KIeN0zioZI3vJTYfuflhrP0fQ2uE?=
 =?us-ascii?Q?XXR9uUeUS8K00jxClh6vtJJ+wzyAYHHMyqLwPyM7w+UYiE3/Q06RitmVqSIR?=
 =?us-ascii?Q?9t2GDUzbQoj6+RaVN1XeeqJvYZXqfYKkMZU2QG1ak1ac/AkuAaJE1HI3bCy4?=
 =?us-ascii?Q?XaV8DqVFYT3R9D1b4pS2/AW7J69p1vUrKsbQ/vlE5m8eXLU6KB0iaXWV3Okz?=
 =?us-ascii?Q?3w7ppGFll0CVwANaibSwXvPrMvCVQhkdCWzUoFvEXjuE08lc6/cS1mUrDMFY?=
 =?us-ascii?Q?GxQa+Q3Xl7eiKsaj6/qRYJEYEKIhZY5aSOUrGYf/D8alzZpwypOtT3CLnmT+?=
 =?us-ascii?Q?Pjrl17c1eJDJEodYGauQfp8OEsUwbMNC5JExxwhOS430p+QRQYbXppn47eWe?=
 =?us-ascii?Q?cSlKjE0VSC+P8D6QNNwkeOvyu9ea/wKrpiZqjAdWN/vMDCI/l/8pLfLyd0iB?=
 =?us-ascii?Q?pvuy/y0IaFaGXiQ=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Lpr4nqRboJ6DdLgmoiiYAw0uXDq2HmdUpNFm3MEEQa5jAJfl4VfYKERcyV2i?=
 =?us-ascii?Q?IuN4fp0WhNkpw1fFPzMM0z7WMuG5q2fuaIj049D7Y6stFDeEr6u0IdEM4eBl?=
 =?us-ascii?Q?/d/9bK/CGTlqJdk/VTqzBoYy5UrZKH5+MFbmMs9KPTfFFoYIP7AIu1Ovc7JU?=
 =?us-ascii?Q?HuaLUyi07d3w1KBhtvW1+waxM5KZI0aex+weTfS9XjsKhZNux3cbfQ88osum?=
 =?us-ascii?Q?kT3BhqpszngXyWMXJwjkr5jbMi3iX6HmPwhl1caSdOGkQhY6N/HN6s47cKbF?=
 =?us-ascii?Q?T6eOmBDAZHUmiH2VPd2u7rDIpeRp3Pjz+lWhSZO+/gY0HgCRUULBEgODaolv?=
 =?us-ascii?Q?g1drEmVyOqh9PgFEOU7FvVX03H2j+i5apU30ogsq4kJkndbtZJDATe138MFZ?=
 =?us-ascii?Q?2yefRHglwZqhh7J1y6TSiccOJ5MhmCrss3f8Y0UVNNEY9Tb3TFYUguhI/UbG?=
 =?us-ascii?Q?cRuG/BJAOzuKO0jECKZzgrsCvPzYpJYqLS0oAhNYSwfMcFGAcmfwC6NlD3eP?=
 =?us-ascii?Q?u+pRlvN+MrZKnQTRBBWPcMaytvttkAmirU6NIGmkA12UHCM8WLg9iwPlt9d1?=
 =?us-ascii?Q?4ZfC/zYfxxvgpv/H+hblQ2AaA5Mvw1sr1UvksOR9IJfrpe9302eouJxCtbDY?=
 =?us-ascii?Q?k2GHD7kgyrPywKmrdHm+zpZhjZq0OprU4q6PdT7f0Yu2KXBdn4aDFRGiZCGz?=
 =?us-ascii?Q?AT4ZrJWgC6fTX4fvXGoU7WeYbyfutcox8UQh0Nxn6h1r6/ZMOfGm2hWLujvY?=
 =?us-ascii?Q?LR4aFpD5dLQBJPto3kFnrDBEWYiWwxmbNenhbQIQpgP96TDBGEvYYIavZgiO?=
 =?us-ascii?Q?tXk+jdIihvHU5TQBBdhu/8LvbVev9d3OK0jEjPrdOHFjIWo6ZMsKGX9WC/Y5?=
 =?us-ascii?Q?XNJRwuKBDZASjJ9iFK5rkvxXxqXSBoNfnM4NnKqJOuCAXDQl/KYjMGFQ2hQ1?=
 =?us-ascii?Q?mOmOaaGz2Fi33BoUnAp99njSjqDVQwIAowlrWIFVFQiJGbnNzOOKEJpHNAMy?=
 =?us-ascii?Q?M6NP5Cpx4b7m4CKqn6sBFEQnRDSlFYcqptS6jAMJQetFhFCfMNa4Pht8m8Bx?=
 =?us-ascii?Q?Vp/4YxK6ZDQK4kpMf0OWfDKwbgyqpYXMuXRopq1/EQeKNNxYTP5zqZsXnuBt?=
 =?us-ascii?Q?55Jq3opH7EaOD68ZT5GUJQ8kW4jZQHe212SVy7AjrAOXmzhy7eQgre/HPMQn?=
 =?us-ascii?Q?VIkYsvDu9SMCW9WtyJ0iQjCffKEuNWijfDWxyo6wfeE7LqKlhSDuL9iXwrmu?=
 =?us-ascii?Q?4+YrsQ0bXbaW9NPO9JPAyWUr2D3dY6dOnaxl1WBKZU7exNbg0qoWgCgQI16B?=
 =?us-ascii?Q?zyu9VJWrVK3/P68AjE1gTGIfs1X8Wfe52yRZ6eohJyUsGdlzFs0zymyKCTw0?=
 =?us-ascii?Q?ST78iwFx+bgbK1QDGcqBHtcfFFtVMBA8VN7HQErcxIdsF5m+qFExKzOxSzvg?=
 =?us-ascii?Q?1bugFb6oRQvzkxThT0CJl2ZsNtt4BUT9TpBKFfnhAHE9tyHPYEzAVlxmZ/se?=
 =?us-ascii?Q?R9/kbqN6LeJdQSJfhX61DANIYT0wTMmwShgkaMpybVsP17F1PGH82OHOQXOe?=
 =?us-ascii?Q?90zccRXHHsm8nGfDViPcnP7qCHA/ywvNjM0n4Mix?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ec9c3a-614f-4088-9568-08dde3910cf4
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:37:08.7123
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: grzXs1V+5Tc3S/aOLLrO7s9YHEE+OBpY5iGWQyeM/77K+0gZEw+d5RLSAC7W9gYsNr+RffMxy1A3uA4SI3OMSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661

From: "F.S. Peng" <fushi.peng@nxp.com>

The NETC Timer is capable of recording the timestamp on receipt of an
external pulse on a GPIO pin. It supports two such external triggers.
The recorded value is saved in a 16 entry FIFO accessed by
TMR_ETTSa_H/L. An interrupt can be generated when the trigger occurs,
when the FIFO reaches a threshold or overflows.

Signed-off-by: F.S. Peng <fushi.peng@nxp.com>
Signed-off-by: Wei Fang <wei.fang@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>

---
v4,v5 no changes
v3 changes:
1. Rebase this patch and use priv->tmr_emask instead of reading
   TMR_EMASK register
2. Rename related macros
3. Remove the switch statement from netc_timer_enable_extts() and
   netc_timer_handle_etts_event()
---
 drivers/ptp/ptp_netc.c | 85 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 85 insertions(+)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 8cf44b8ebe44..a5239ea1f1ff 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -18,6 +18,7 @@
 #define NETC_TMR_CTRL			0x0080
 #define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
 #define  TMR_CTRL_TE			BIT(2)
+#define  TMR_ETEP(i)			BIT(8 + (i))
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
 #define  TMR_CTRL_FS			BIT(28)
@@ -26,12 +27,22 @@
 #define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
 #define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
 #define  TMR_TEVENT_ALMEN(i)		BIT(16 + (i))
+#define  TMR_TEVENT_ETS_THREN(i)	BIT(20 + (i))
+#define  TMR_TEVENT_ETSEN(i)		BIT(24 + (i))
+#define  TMR_TEVENT_ETS_OVEN(i)		BIT(28 + (i))
+#define  TMR_TEVENT_ETS(i)		(TMR_TEVENT_ETS_THREN(i) | \
+					 TMR_TEVENT_ETSEN(i) | \
+					 TMR_TEVENT_ETS_OVEN(i))
 
 #define NETC_TMR_TEMASK			0x0088
+#define NETC_TMR_STAT			0x0094
+#define  TMR_STAT_ETS_VLD(i)		BIT(24 + (i))
+
 #define NETC_TMR_CNT_L			0x0098
 #define NETC_TMR_CNT_H			0x009c
 #define NETC_TMR_ADD			0x00a0
 #define NETC_TMR_PRSC			0x00a8
+#define NETC_TMR_ECTRL			0x00ac
 #define NETC_TMR_OFF_L			0x00b0
 #define NETC_TMR_OFF_H			0x00b4
 
@@ -49,6 +60,9 @@
 #define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
 #define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
 
+/* i = 0, 1, i indicates the index of TMR_ETTS */
+#define NETC_TMR_ETTS_L(i)		(0x00e0 + (i) * 8)
+#define NETC_TMR_ETTS_H(i)		(0x00e4 + (i) * 8)
 #define NETC_TMR_CUR_TIME_L		0x00f0
 #define NETC_TMR_CUR_TIME_H		0x00f4
 
@@ -65,6 +79,7 @@
 #define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
 #define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
 #define NETC_TMR_ALARM_NUM		2
+#define NETC_TMR_DEFAULT_ETTF_THR	7
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -476,6 +491,64 @@ static int net_timer_enable_perout(struct netc_timer *priv,
 	return err;
 }
 
+static void netc_timer_handle_etts_event(struct netc_timer *priv, int index,
+					 bool update_event)
+{
+	struct ptp_clock_event event;
+	u32 etts_l = 0, etts_h = 0;
+
+	while (netc_timer_rd(priv, NETC_TMR_STAT) & TMR_STAT_ETS_VLD(index)) {
+		etts_l = netc_timer_rd(priv, NETC_TMR_ETTS_L(index));
+		etts_h = netc_timer_rd(priv, NETC_TMR_ETTS_H(index));
+	}
+
+	/* Invalid time stamp */
+	if (!etts_l && !etts_h)
+		return;
+
+	if (update_event) {
+		event.type = PTP_CLOCK_EXTTS;
+		event.index = index;
+		event.timestamp = (u64)etts_h << 32;
+		event.timestamp |= etts_l;
+		ptp_clock_event(priv->clock, &event);
+	}
+}
+
+static int netc_timer_enable_extts(struct netc_timer *priv,
+				   struct ptp_clock_request *rq, int on)
+{
+	int index = rq->extts.index;
+	unsigned long flags;
+	u32 tmr_ctrl;
+
+	/* Reject requests to enable time stamping on both edges */
+	if ((rq->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
+		return -EOPNOTSUPP;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	netc_timer_handle_etts_event(priv, rq->extts.index, false);
+	if (on) {
+		tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+		if (rq->extts.flags & PTP_FALLING_EDGE)
+			tmr_ctrl |= TMR_ETEP(index);
+		else
+			tmr_ctrl &= ~TMR_ETEP(index);
+
+		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+		priv->tmr_emask |= TMR_TEVENT_ETS(index);
+	} else {
+		priv->tmr_emask &= ~TMR_TEVENT_ETS(index);
+	}
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
 static void netc_timer_disable_fiper(struct netc_timer *priv)
 {
 	u32 fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
@@ -529,6 +602,8 @@ static int netc_timer_enable(struct ptp_clock_info *ptp,
 		return netc_timer_enable_pps(priv, rq, on);
 	case PTP_CLK_REQ_PEROUT:
 		return net_timer_enable_perout(priv, rq, on);
+	case PTP_CLK_REQ_EXTTS:
+		return netc_timer_enable_extts(priv, rq, on);
 	default:
 		return -EOPNOTSUPP;
 	}
@@ -641,6 +716,9 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.n_alarm	= 2,
 	.pps		= 1,
 	.n_per_out	= 3,
+	.n_ext_ts	= 2,
+	.supported_extts_flags = PTP_RISING_EDGE | PTP_FALLING_EDGE |
+				 PTP_STRICT_FLAGS,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
@@ -673,6 +751,7 @@ static void netc_timer_init(struct netc_timer *priv)
 		fiper_ctrl &= ~FIPER_CTRL_PG(i);
 	}
 	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+	netc_timer_wr(priv, NETC_TMR_ECTRL, NETC_TMR_DEFAULT_ETTF_THR);
 
 	ktime_get_real_ts64(&now);
 	ns = timespec64_to_ns(&now);
@@ -806,6 +885,12 @@ static irqreturn_t netc_timer_isr(int irq, void *data)
 		ptp_clock_event(priv->clock, &event);
 	}
 
+	if (tmr_event & TMR_TEVENT_ETS(0))
+		netc_timer_handle_etts_event(priv, 0, true);
+
+	if (tmr_event & TMR_TEVENT_ETS(1))
+		netc_timer_handle_etts_event(priv, 1, true);
+
 	spin_unlock(&priv->lock);
 
 	return IRQ_HANDLED;
-- 
2.34.1



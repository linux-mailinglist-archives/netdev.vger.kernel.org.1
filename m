Return-Path: <netdev+bounces-216366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 136E4B33530
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 06:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 74984189F882
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 04:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27CA7280037;
	Mon, 25 Aug 2025 04:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="jjwT9GU+"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013037.outbound.protection.outlook.com [52.101.72.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A487625A357;
	Mon, 25 Aug 2025 04:36:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756096622; cv=fail; b=mds3tVI+WtBVkAvZYV9QPniJU8Mz/MHizQXTnMFs7GX/6MrcioFD9rd63a1+OcxPr5huW7Yff7baZg9c/CNOteQPByG4WPiWDbRex5+c9NK5yMb2hR6FcLiKrQzRer4kPjwaG2p2qTtaVb2AppQopi4LHx5c3q4vkNhqXJfoLwo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756096622; c=relaxed/simple;
	bh=MXWno3jM+FBTdm+lhrqTq+P8ISguRVvPYrk2tqcyS+s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=EribN0GLpJSAtUKr1SP8pvbNbj4z8QvDPdE/UtRKihLffnzaBt0C4hLtOb6yDRCQU0rqDFd0qyPlrMzSgQVvfbDTv5oQn9VeXVGaqgqgv1e6asH5rDB6M6aZI9WIwH5Gt2IdYx0u6iYH38LPruAbLr7mgcSIH9g4rd7iOS/zrqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=jjwT9GU+; arc=fail smtp.client-ip=52.101.72.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C+7Jz8mRQhYYGy6evPSBOin3ZitftQDpcpD8kUrQAaVPhuTVhb6XllvP7kHO9FKW0Lnm4v0AMoa9c1JHHif0iH+iTVtAK8WZI3efsTEKg0Xcdoc9sUcb60HjriKkMAjwoR6zNzdZEzijyjOMSsuLeC+Q+ImyICvog5Us358+0v9Q0DEk310FaInToHZiGqUfxlKjwMM19bJXhWqJf1a9I9+VxwnIRuaphRdmO0+PlIR07rAEtz9PoKc43AWueXMBDHwAQynO4WaRqj+RjXA/XnSM5mLOkBZS0qIITVKzS6i3Nnv3ypxCG47z8hYaHO1FmgQB/km8z+GvIm6xbTy/uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c6gG5l1JUBkYg2X+YCjcgGWWzUo7wmmXYgGdBc9CPiE=;
 b=aUBCHc46g2Nj0lveeHjzneZ85TJbWs6b07WGYW2TkgpwTGSDceN3UtEL804IjIupY1uvMnNrsZmkfQqMqwJMiTKkKVKMRyt2TRfGIujstn5nBH8lWXxK+SFj3i8DDycwGENJe8u6NLRv7RbzhQ0CLOV4EtN0eFzExI/V7CNGWFes3Empt7N61yrXhTN3Cm9czXtykPYcOyO4OHj1UNRB6FiyO3V3JCBdXey06k4DkBJ0xRjqINylHR1vo6bO/Dd3B8Y5uGvFVB2EXwPql1e6wE4hpUfbjAX5kyf9ESs5u+slyI96Opp9G6tE9LgtLbT+OXkGOzj/nBt2ohcOyPSmtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c6gG5l1JUBkYg2X+YCjcgGWWzUo7wmmXYgGdBc9CPiE=;
 b=jjwT9GU+Bo2/lScNLt4Ekbb8ihoiyeIcl3SBRuM9PEcRiKfImIiei9QehYHBgcsqgX197XYeIZdqx3xVxk9rRdYNDBgGbSJo730hGjB/sXjYmcbtzcT00Di5RzA+BYpDqcl7dmTavv6iIouNa2+z3vG1nN0WUG7YPWhxRU2uRtMkPpuZ49mM/G5Uaex1oGiR2derA6X/pARflJK2ClUl4YjMZzCpDKFYoT7nFwdcWeYnN8mdrAoWlTlTJi1Mv51OobSXvhGwL9nZoY4BdCmrmwSKmaS7oFyCNLCdjO3pdzxNifwY5EDb8tuPFw2QVFt6HTXqfvEoebDHj4Oj25i5zA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9661.eurprd04.prod.outlook.com (2603:10a6:102:273::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 04:36:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 04:36:56 +0000
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
Subject: [PATCH v5 net-next 05/15] ptp: netc: add PTP_CLK_REQ_PPS support
Date: Mon, 25 Aug 2025 12:15:22 +0800
Message-Id: <20250825041532.1067315-6-wei.fang@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 487e933f-0320-42c6-5fb6-08dde391055d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|52116014|376014|366016|19092799006|38350700014|921020;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?ApAfpjx5pQh4CzxXdYVD9HiIRtgyNrFTsbd8NSdkRBI8SiUYDkY8kxUZD/cu?=
 =?us-ascii?Q?aJDGqWNSnLI2FY3oK42yYpk0tfi2VMAdb+gOVcrJy5dQ10rU+TRJgB4lWBSG?=
 =?us-ascii?Q?LQEmi3EiVREvmKA6lh/wvPolayBMDdJhcZTmgqeY006+AK2NJEDh6tY+qrVE?=
 =?us-ascii?Q?s7MDorn9CfdZO8u/S0v55vPS/QSfIW+DJ5ZQIosyjezYwPQ0qL403mk0vhuL?=
 =?us-ascii?Q?qjsCKojtuVOhJbp12Haj5GEeMl3bm4hgZV2m+Vl5c/D4xnw06iXVgtKKA5cq?=
 =?us-ascii?Q?V8bzxuWH2rxrc63A3hzU5XHH4ZQaMq/GaSGkrRh/VOOxMZbJhBNbcjWbj4Ya?=
 =?us-ascii?Q?z9WsozWd7IfgC1NYQddZ79Jsvgz1vMkJZLjNoTg5v9CfZMzyGM226d6LSsVa?=
 =?us-ascii?Q?TPuqNKmkN//Dsedc188LJchuOfGegsgLHRuSOTrLZ7ePCYIGBr7wv9p9eaH4?=
 =?us-ascii?Q?9kkz9TbeTfUQvXkqPHX0SB1dl2FQCinQW0HefH+bggDSudyG8vWdY1qlXWnX?=
 =?us-ascii?Q?SbH77Jutr7rKToO6uYOY1qCLZDy+DRs3lbfY1p0+mdEjXNp3kH0gJ0esMBo8?=
 =?us-ascii?Q?Us9dkof3BODxSHxDsqRW/RfDs/1QOap8UinHqMhtjQZA/o1p7zwzxlyOi59m?=
 =?us-ascii?Q?8KztP6hfoEYyXBUK26chzDxYcS+lHBqNc7sft6F8LWAMiBde28oDL6fjlARX?=
 =?us-ascii?Q?hDXEo5iNPc2eO6R0k/gu7rhL2LdrBXaWpbcCHgni+q+5rWxA1UWGW/73ulKA?=
 =?us-ascii?Q?cSRsK6/0p6Gx7u3ewKpRO6rKspHQ/NvdUix68zR5sV+G8UxdniB9MGX7eQMZ?=
 =?us-ascii?Q?QmmISISyae8cYnbmUps+kN9zT4lLarj3SUkwXKCsn6I2P+vAfK0oh+2vQHP7?=
 =?us-ascii?Q?ydGw4RJDQ/ysjht6AcY0cihL4Dwkw+1ROrCA4h51Ayk15cAmZjZ17Isf6y3W?=
 =?us-ascii?Q?isP2bzymfpGCao7EVDF+3CJtPk0wLrZxbloAqYXLVqqCLZyQgwBam3cPInGV?=
 =?us-ascii?Q?Z4/7T6nGSeimohOCcBf4Zdz8G0ZOkGOLEZ99kGgCWC9YQ0HJC/VnhSROV1D/?=
 =?us-ascii?Q?736Kb81ZSGu8G6wFB2rqlxtoxjENwdrYwZNTc+ukapd1adl/IQdGLfK27r6A?=
 =?us-ascii?Q?97De9QGndlk9DM4kxDikmFUxiW+L0kaWg1GQOz805ylS2JvU/WRZrQjOG4Fz?=
 =?us-ascii?Q?uKuN9Ks4fbrvazsufjH2X4cPjQaOz3Y5He9q7Sgk/v5S4nAFGXSsAdd+5bk/?=
 =?us-ascii?Q?exugjuNu6d4jzmXQAZTxqNxiKJAKLrRiGSOqcr431RMpwC0J/5xTvTRihaI5?=
 =?us-ascii?Q?qeLUzK6OVzb2LykhpzU/TEwIzHYOOPgr0jicsUlwnuGliLywn7IzJhtxxUir?=
 =?us-ascii?Q?BET+PTrNxbOt4fFpmiil+XXjSN3sqa1WpvSXs8oV1DIOpvfjeS4ZIdxf+ykr?=
 =?us-ascii?Q?9nSgRUw7cLP2r+hPyxMHQUXic8xPLjeHhEM92ylc65vnNgj6Ynv0ggfHKO0N?=
 =?us-ascii?Q?TLA6/A2x1SG5iba+gIA2u1Kpna17KfgvzcmE?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(52116014)(376014)(366016)(19092799006)(38350700014)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BldsUdDRbVJxZUqqjtL6+sFq1T6AihhNtSw2cSNkMQ8nL8LxMeWQuf6dWB0c?=
 =?us-ascii?Q?9iBtrd33MXtZkubdomUutXq8GWAAPv3JwjgYmJ+I9NOXsDYb2shLBy5WAjd2?=
 =?us-ascii?Q?86wMBp7r0aQvTnqaC00eCfDQPGE1/Mnxsw2ZBWvCs9cyxdllN6f2sf5pl168?=
 =?us-ascii?Q?erlwabd6AtZPaeXFl6He0Yau78v/im2NVQEDeZqxvpaE1ciVcQWkKOWt2Yv4?=
 =?us-ascii?Q?MHBs6fwHmA8amnwwy45tlvEXeo5G03XYXf5v1jcaPgn7PFz+Kn3iVlshjyeN?=
 =?us-ascii?Q?3Do3A6MGOGh9giK8e4qWi4lm3Jw8/ekb5k6jwop9NPCXsxNXXWGJfljvdVK9?=
 =?us-ascii?Q?hOrKwXLGFVcvGvWoaGa2H2fJXBZFezJFiVk5R4n3WeBGB52KmRVPV8fNRL2q?=
 =?us-ascii?Q?RNyzJZmhozYsnGZFNFOm9SqyXbzWoo6IXASgGb1rU87DTXtrcGaP0rKPaLH0?=
 =?us-ascii?Q?hLVOqiD37/w6rstZYc9jitZKSuLhgjVxxySbysovmcps7oHg2CVUOdGWXhao?=
 =?us-ascii?Q?YFFrNYNSGyrYwcRdbkSA9KFKx6o4HwFP9Eeqp+EvgfxhfteGn/x0XEz5/Swa?=
 =?us-ascii?Q?9KTeywsvSn9R+RYvgc3aQEGcQrwm6bZf57K4NzKb+ketDv28ooOMe5snf9YW?=
 =?us-ascii?Q?k1FpETw7oEcfqMbWwaChxGfn7hhF4cJ6KGLwwDJb0V/kf80KQDJNHx4cRaWj?=
 =?us-ascii?Q?pVXXwp2wjgLe/GRvwpWI8IAf+mKLdfx+gM5wGvetffY7T7V7MQyHRrq8bPC6?=
 =?us-ascii?Q?KGotVqFCP7FNh87eCs0Xb2XJ/YCNDDl1H0sfvjN2w0rmS0wbZbvVtsTUOHi6?=
 =?us-ascii?Q?mmNOaRuZqQng+AFQIgRkpPGulE2FJ0fRnx1hX3/1HtVW1vWpftWV0wS1yoz4?=
 =?us-ascii?Q?caJF5bOVGmfuoR9k1XjtHpkJwL5zxRHFN118F+ZG3wGZewicwnfebuyaH00/?=
 =?us-ascii?Q?GVa5gWWl8T71m0G28V1KNIQuX6mCzLGLoQ72XMIxwty23fxwdPKPp8lB6rqG?=
 =?us-ascii?Q?lMznpOP8OwqirBxIzJmAaF4rY57jaHQ/uj4EgYhQrAZwHV0s9BaObBVzxfwd?=
 =?us-ascii?Q?od+cFFDES7Dg5asyiFlwgDS3QJoYeHwOfP/rmE9BQu2beHAkt9241lBIA7db?=
 =?us-ascii?Q?XVXgHRm5nXo94yjZzcorNckyAOjUhdK4rzSws8G1ap1M4DNjHK27+jC8IeVi?=
 =?us-ascii?Q?EEfkCkW2kXfT0ozsAGrmrpkwxLihkh1hRWI2lEHiUdX39dJ+iyb3rb2K2i/T?=
 =?us-ascii?Q?FWCnQ/I4jHZsuXzKfN2GKYGOF9A0MjwasUbfJifXXF2hzLbmCtK6WJiMMJ0m?=
 =?us-ascii?Q?BlTBGg7JuNrKpc8HR2P9X/MkJkbiifiF3PlwXNELg1ni4hkp7aiz2P0pFUiR?=
 =?us-ascii?Q?gVTEjTDgre2RHgZZItyh+y87Q6OUVkWN7q+OY8X5dHEEs7OKpNJGr7wa+q6N?=
 =?us-ascii?Q?i1LxVR/tfcNYEYjhCVW/iEAAn/kFj4lF8MhIa822YJ7NoRVuQedYaWUdzXvz?=
 =?us-ascii?Q?c5+oFmgox+sR+aHm1zsOXOjxSWUM7wSdo3mVcOx2+yENM7FJOYogT7unDNbF?=
 =?us-ascii?Q?Mf7GZ3qzsKxfRaqqoPMJ5MpzllnPDdI655r7xj3m?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 487e933f-0320-42c6-5fb6-08dde391055d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2025 04:36:55.9398
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1Kbv0jYquz5DCOOxwzYVlothUznHzNC89YYSr7v3pIamFBqicjzLo45ij6fU2bgrtl9104T8yjm8NhVUeVW8tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9661

The NETC Timer is capable of generating a PPS interrupt to the host. To
support this feature, a 64-bit alarm time (which is a integral second
of PHC in the future) is set to TMR_ALARM, and the period is set to
TMR_FIPER. The alarm time is compared to the current time on each update,
then the alarm trigger is used as an indication to the TMR_FIPER starts
down counting. After the period has passed, the PPS event is generated.

According to the NETC block guide, the Timer has three FIPERs, any of
which can be used to generate the PPS events, but in the current
implementation, we only need one of them to implement the PPS feature,
so FIPER 0 is used as the default PPS generator. Also, the Timer has
2 ALARMs, currently, ALARM 0 is used as the default time comparator.

However, if the time is adjusted or the integer of period is changed when
PPS is enabled, the PPS event will not be generated at an integral second
of PHC. The suggested steps from IP team if time drift happens:

1. Disable FIPER before adjusting the hardware time
2. Rearm ALARM after the time adjustment to make the next PPS event be
generated at an integral second of PHC.
3. Re-enable FIPER.

Signed-off-by: Wei Fang <wei.fang@nxp.com>

---
v5 changes:
1. Fix irq name issue, since request_irq() does not copy the name from
   irq_name.
v4 changes:
1. Improve the commit message, the PPS generation time will be inaccurate
   if the time is adjusted or the integer of period is changed.
v3 changes:
1. Use "2 * NSEC_PER_SEC" to instead of "2000000000U"
2. Improve the commit message
3. Add alarm related logic and the irq handler
4. Add tmr_emask to struct netc_timer to save the irq masks instead of
   reading TMR_EMASK register
5. Remove pps_channel from struct netc_timer and remove
   NETC_TMR_DEFAULT_PPS_CHANNEL
v2 changes:
1. Refine the subject and the commit message
2. Add a comment to netc_timer_enable_pps()
3. Remove the "nxp,pps-channel" logic from the driver
---
 drivers/ptp/ptp_netc.c | 262 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 259 insertions(+), 3 deletions(-)

diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c
index 5f0aece7417b..69d45a4a4cec 100644
--- a/drivers/ptp/ptp_netc.c
+++ b/drivers/ptp/ptp_netc.c
@@ -20,7 +20,14 @@
 #define  TMR_CTRL_TE			BIT(2)
 #define  TMR_COMP_MODE			BIT(15)
 #define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
+#define  TMR_CTRL_FS			BIT(28)
 
+#define NETC_TMR_TEVENT			0x0084
+#define  TMR_TEVNET_PPEN(i)		BIT(7 - (i))
+#define  TMR_TEVENT_PPEN_ALL		GENMASK(7, 5)
+#define  TMR_TEVENT_ALMEN(i)		BIT(16 + (i))
+
+#define NETC_TMR_TEMASK			0x0088
 #define NETC_TMR_CNT_L			0x0098
 #define NETC_TMR_CNT_H			0x009c
 #define NETC_TMR_ADD			0x00a0
@@ -28,9 +35,19 @@
 #define NETC_TMR_OFF_L			0x00b0
 #define NETC_TMR_OFF_H			0x00b4
 
+/* i = 0, 1, i indicates the index of TMR_ALARM */
+#define NETC_TMR_ALARM_L(i)		(0x00b8 + (i) * 8)
+#define NETC_TMR_ALARM_H(i)		(0x00bc + (i) * 8)
+
+/* i = 0, 1, 2. i indicates the index of TMR_FIPER. */
+#define NETC_TMR_FIPER(i)		(0x00d0 + (i) * 4)
+
 #define NETC_TMR_FIPER_CTRL		0x00dc
 #define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
 #define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
+#define  FIPER_CTRL_FS_ALARM(i)		(BIT(5) << (i) * 8)
+#define  FIPER_CTRL_PW(i)		(GENMASK(4, 0) << (i) * 8)
+#define  FIPER_CTRL_SET_PW(i, v)	(((v) & GENMASK(4, 0)) << 8 * (i))
 
 #define NETC_TMR_CUR_TIME_L		0x00f0
 #define NETC_TMR_CUR_TIME_H		0x00f4
@@ -39,6 +56,9 @@
 
 #define NETC_TMR_FIPER_NUM		3
 #define NETC_TMR_DEFAULT_PRSC		2
+#define NETC_TMR_DEFAULT_ALARM		GENMASK_ULL(63, 0)
+#define NETC_TMR_DEFAULT_FIPER		GENMASK(31, 0)
+#define NETC_TMR_FIPER_MAX_PW		GENMASK(4, 0)
 
 /* 1588 timer reference clock source select */
 #define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from CCM */
@@ -59,6 +79,11 @@ struct netc_timer {
 	u32 oclk_prsc;
 	/* High 32-bit is integer part, low 32-bit is fractional part */
 	u64 period;
+
+	int irq;
+	char irq_name[24];
+	u32 tmr_emask;
+	bool pps_enabled;
 };
 
 #define netc_timer_rd(p, o)		netc_read((p)->base + (o))
@@ -124,6 +149,155 @@ static u64 netc_timer_cur_time_read(struct netc_timer *priv)
 	return ns;
 }
 
+static void netc_timer_alarm_write(struct netc_timer *priv,
+				   u64 alarm, int index)
+{
+	u32 alarm_h = upper_32_bits(alarm);
+	u32 alarm_l = lower_32_bits(alarm);
+
+	netc_timer_wr(priv, NETC_TMR_ALARM_L(index), alarm_l);
+	netc_timer_wr(priv, NETC_TMR_ALARM_H(index), alarm_h);
+}
+
+static u32 netc_timer_get_integral_period(struct netc_timer *priv)
+{
+	u32 tmr_ctrl, integral_period;
+
+	tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
+	integral_period = FIELD_GET(TMR_CTRL_TCLK_PERIOD, tmr_ctrl);
+
+	return integral_period;
+}
+
+static u32 netc_timer_calculate_fiper_pw(struct netc_timer *priv,
+					 u32 fiper)
+{
+	u64 divisor, pulse_width;
+
+	/* Set the FIPER pulse width to half FIPER interval by default.
+	 * pulse_width = (fiper / 2) / TMR_GCLK_period,
+	 * TMR_GCLK_period = NSEC_PER_SEC / TMR_GCLK_freq,
+	 * TMR_GCLK_freq = (clk_freq / oclk_prsc) Hz,
+	 * so pulse_width = fiper * clk_freq / (2 * NSEC_PER_SEC * oclk_prsc).
+	 */
+	divisor = mul_u32_u32(2 * NSEC_PER_SEC, priv->oclk_prsc);
+	pulse_width = div64_u64(mul_u32_u32(fiper, priv->clk_freq), divisor);
+
+	/* The FIPER_PW field only has 5 bits, need to update oclk_prsc */
+	if (pulse_width > NETC_TMR_FIPER_MAX_PW)
+		pulse_width = NETC_TMR_FIPER_MAX_PW;
+
+	return pulse_width;
+}
+
+static void netc_timer_set_pps_alarm(struct netc_timer *priv, int channel,
+				     u32 integral_period)
+{
+	u64 alarm;
+
+	/* Get the alarm value */
+	alarm = netc_timer_cur_time_read(priv) +  NSEC_PER_MSEC;
+	alarm = roundup_u64(alarm, NSEC_PER_SEC);
+	alarm = roundup_u64(alarm, integral_period);
+
+	netc_timer_alarm_write(priv, alarm, 0);
+}
+
+/* Note that users should not use this API to output PPS signal on
+ * external pins, because PTP_CLK_REQ_PPS trigger internal PPS event
+ * for input into kernel PPS subsystem. See:
+ * https://lore.kernel.org/r/20201117213826.18235-1-a.fatoum@pengutronix.de
+ */
+static int netc_timer_enable_pps(struct netc_timer *priv,
+				 struct ptp_clock_request *rq, int on)
+{
+	u32 fiper, fiper_ctrl;
+	unsigned long flags;
+
+	spin_lock_irqsave(&priv->lock, flags);
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+
+	if (on) {
+		u32 integral_period, fiper_pw;
+
+		if (priv->pps_enabled)
+			goto unlock_spinlock;
+
+		integral_period = netc_timer_get_integral_period(priv);
+		fiper = NSEC_PER_SEC - integral_period;
+		fiper_pw = netc_timer_calculate_fiper_pw(priv, fiper);
+		fiper_ctrl &= ~(FIPER_CTRL_DIS(0) | FIPER_CTRL_PW(0) |
+				FIPER_CTRL_FS_ALARM(0));
+		fiper_ctrl |= FIPER_CTRL_SET_PW(0, fiper_pw);
+		priv->tmr_emask |= TMR_TEVNET_PPEN(0) | TMR_TEVENT_ALMEN(0);
+		priv->pps_enabled = true;
+		netc_timer_set_pps_alarm(priv, 0, integral_period);
+	} else {
+		if (!priv->pps_enabled)
+			goto unlock_spinlock;
+
+		fiper = NETC_TMR_DEFAULT_FIPER;
+		priv->tmr_emask &= ~(TMR_TEVNET_PPEN(0) |
+				     TMR_TEVENT_ALMEN(0));
+		fiper_ctrl |= FIPER_CTRL_DIS(0);
+		priv->pps_enabled = false;
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+	}
+
+	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
+	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+
+unlock_spinlock:
+	spin_unlock_irqrestore(&priv->lock, flags);
+
+	return 0;
+}
+
+static void netc_timer_disable_pps_fiper(struct netc_timer *priv)
+{
+	u32 fiper_ctrl;
+
+	if (!priv->pps_enabled)
+		return;
+
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl |= FIPER_CTRL_DIS(0);
+	netc_timer_wr(priv, NETC_TMR_FIPER(0), NETC_TMR_DEFAULT_FIPER);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static void netc_timer_enable_pps_fiper(struct netc_timer *priv)
+{
+	u32 fiper_ctrl, integral_period, fiper;
+
+	if (!priv->pps_enabled)
+		return;
+
+	integral_period = netc_timer_get_integral_period(priv);
+	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
+	fiper_ctrl &= ~FIPER_CTRL_DIS(0);
+	fiper = NSEC_PER_SEC - integral_period;
+
+	netc_timer_set_pps_alarm(priv, 0, integral_period);
+	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
+	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
+}
+
+static int netc_timer_enable(struct ptp_clock_info *ptp,
+			     struct ptp_clock_request *rq, int on)
+{
+	struct netc_timer *priv = ptp_to_netc_timer(ptp);
+
+	switch (rq->type) {
+	case PTP_CLK_REQ_PPS:
+		return netc_timer_enable_pps(priv, rq, on);
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
 static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 {
 	u32 fractional_period = lower_32_bits(period);
@@ -136,8 +310,11 @@ static void netc_timer_adjust_period(struct netc_timer *priv, u64 period)
 	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
 	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
 				    TMR_CTRL_TCLK_PERIOD);
-	if (tmr_ctrl != old_tmr_ctrl)
+	if (tmr_ctrl != old_tmr_ctrl) {
+		netc_timer_disable_pps_fiper(priv);
 		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
+		netc_timer_enable_pps_fiper(priv);
+	}
 
 	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
 
@@ -163,6 +340,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 
 	spin_lock_irqsave(&priv->lock, flags);
 
+	netc_timer_disable_pps_fiper(priv);
+
 	/* Adjusting TMROFF instead of TMR_CNT is that the timer
 	 * counter keeps increasing during reading and writing
 	 * TMR_CNT, which will cause latency.
@@ -171,6 +350,8 @@ static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
 	tmr_off += delta;
 	netc_timer_offset_write(priv, tmr_off);
 
+	netc_timer_enable_pps_fiper(priv);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -205,8 +386,12 @@ static int netc_timer_settime64(struct ptp_clock_info *ptp,
 	unsigned long flags;
 
 	spin_lock_irqsave(&priv->lock, flags);
+
+	netc_timer_disable_pps_fiper(priv);
 	netc_timer_offset_write(priv, 0);
 	netc_timer_cnt_write(priv, ns);
+	netc_timer_enable_pps_fiper(priv);
+
 	spin_unlock_irqrestore(&priv->lock, flags);
 
 	return 0;
@@ -217,10 +402,13 @@ static const struct ptp_clock_info netc_timer_ptp_caps = {
 	.name		= "NETC Timer PTP clock",
 	.max_adj	= 500000000,
 	.n_pins		= 0,
+	.n_alarm	= 2,
+	.pps		= 1,
 	.adjfine	= netc_timer_adjfine,
 	.adjtime	= netc_timer_adjtime,
 	.gettimex64	= netc_timer_gettimex64,
 	.settime64	= netc_timer_settime64,
+	.enable		= netc_timer_enable,
 };
 
 static void netc_timer_init(struct netc_timer *priv)
@@ -237,7 +425,7 @@ static void netc_timer_init(struct netc_timer *priv)
 	 * domain are not accessible.
 	 */
 	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
-		   TMR_CTRL_TE;
+		   TMR_CTRL_TE | TMR_CTRL_FS;
 	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
 	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
 
@@ -357,6 +545,65 @@ static int netc_timer_parse_dt(struct netc_timer *priv)
 	return netc_timer_get_reference_clk_source(priv);
 }
 
+static irqreturn_t netc_timer_isr(int irq, void *data)
+{
+	struct netc_timer *priv = data;
+	struct ptp_clock_event event;
+	u32 tmr_event;
+
+	spin_lock(&priv->lock);
+
+	tmr_event = netc_timer_rd(priv, NETC_TMR_TEVENT);
+	tmr_event &= priv->tmr_emask;
+	/* Clear interrupts status */
+	netc_timer_wr(priv, NETC_TMR_TEVENT, tmr_event);
+
+	if (tmr_event & TMR_TEVENT_ALMEN(0))
+		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
+
+	if (tmr_event & TMR_TEVENT_PPEN_ALL) {
+		event.type = PTP_CLOCK_PPS;
+		ptp_clock_event(priv->clock, &event);
+	}
+
+	spin_unlock(&priv->lock);
+
+	return IRQ_HANDLED;
+}
+
+static int netc_timer_init_msix_irq(struct netc_timer *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+	int err, n;
+
+	n = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_MSIX);
+	if (n != 1) {
+		err = (n < 0) ? n : -EPERM;
+		dev_err(&pdev->dev, "pci_alloc_irq_vectors() failed\n");
+		return err;
+	}
+
+	priv->irq = pci_irq_vector(pdev, 0);
+	err = request_irq(priv->irq, netc_timer_isr, 0, priv->irq_name, priv);
+	if (err) {
+		dev_err(&pdev->dev, "request_irq() failed\n");
+		pci_free_irq_vectors(pdev);
+
+		return err;
+	}
+
+	return 0;
+}
+
+static void netc_timer_free_msix_irq(struct netc_timer *priv)
+{
+	struct pci_dev *pdev = priv->pdev;
+
+	disable_irq(priv->irq);
+	free_irq(priv->irq, priv);
+	pci_free_irq_vectors(pdev);
+}
+
 static int netc_timer_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -376,16 +623,24 @@ static int netc_timer_probe(struct pci_dev *pdev,
 	priv->caps = netc_timer_ptp_caps;
 	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
 	spin_lock_init(&priv->lock);
+	snprintf(priv->irq_name, sizeof(priv->irq_name), "ptp-netc %s",
+		 pci_name(pdev));
+
+	err = netc_timer_init_msix_irq(priv);
+	if (err)
+		goto timer_pci_remove;
 
 	netc_timer_init(priv);
 	priv->clock = ptp_clock_register(&priv->caps, dev);
 	if (IS_ERR(priv->clock)) {
 		err = PTR_ERR(priv->clock);
-		goto timer_pci_remove;
+		goto free_msix_irq;
 	}
 
 	return 0;
 
+free_msix_irq:
+	netc_timer_free_msix_irq(priv);
 timer_pci_remove:
 	netc_timer_pci_remove(pdev);
 
@@ -397,6 +652,7 @@ static void netc_timer_remove(struct pci_dev *pdev)
 	struct netc_timer *priv = pci_get_drvdata(pdev);
 
 	ptp_clock_unregister(priv->clock);
+	netc_timer_free_msix_irq(priv);
 	netc_timer_pci_remove(pdev);
 }
 
-- 
2.34.1



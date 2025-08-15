Return-Path: <netdev+bounces-214145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27E0DB285A6
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 20:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E8A41D03929
	for <lists+netdev@lfdr.de>; Fri, 15 Aug 2025 18:14:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 338CB304BCA;
	Fri, 15 Aug 2025 18:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="LWOTf0Ll"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012069.outbound.protection.outlook.com [52.101.66.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66A673176E2;
	Fri, 15 Aug 2025 18:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755281630; cv=fail; b=hyAsCONJD3iaWqhqgH7xYGLqTAtZ7FFi6zs/JxqwcUrUmsQh+RYe3Wd9lR3FITkl/B5gg+XyE1teQagKsZMHKAOpE2iLDJgbj2NYxx7jwbR4hKZGvkO7iJVEnYTuEan7DXPj0nz1JOD0VLGZ3hD3uiefI82PKsJAV996niPN8qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755281630; c=relaxed/simple;
	bh=vF1oxPppDxIiiAQSX/0bLSggv2e0x7NdwRzDG45HWRs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=gbCKoUA3khjv9BN/u2FSZxtHBdPg4pc4Diu8aSuPMxzMTnvCf3cf3vDBOraGx2WaDYGJxOyGTStVhphKb5VqKJYNXQ8RnS2vv2co3e9I9B5d9bgRb3XB0ycTcwHOEMTQQUFTbFviI0DxZ5Np64SdCmlraPPVN0vBKE6eQU15fjs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=LWOTf0Ll; arc=fail smtp.client-ip=52.101.66.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pe9rLTCZRECmdXu+p9PpflGKBoUrhapBA/02nlep8pB15Cih6APVpJT3JM3NsUnkb/6x19EnyJEupCMcxxtbch1Lo9yv63K++tNEl4wYDPFWdJP0Ws2rL2Ukple7OqhhM0JYhX0fEaOL9ZxszrFs4VNfn8N4ROKwbPvXB/5+ZJxl9Fne9L5oB/fgoaOUgWdUxit5opLCqueOKfScc9wqutkR7gqPm60lGGBp6/wGhftcJ8IKLC7MAiKDS5YAVA4XL4ZrJi13uztjm5KwKymC944lbnT6ob+GR0JJ3p8Ur/BlNUVX6Dt62fMp5gpQVDz20/TEumkw2TVH+7TtnZriWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJFEPw6sP2fdsvmITJ+kNZxwjD1RSGc8l94pHMoWS5Y=;
 b=R4e1Q1eBQth0P65B+KGWzQ+zq2gUiWdPETpfvmTbMWFLrqT9gDSNlDqEFKzdL8FCBiV/qKp1ujFzMomdB0pjQSoJeOOO8AlAF1MvGwfqetyTGSmjda0Xsp5FBVySQnK68iTCOHPmX8WindWBXYyQiOHOUUwxFEkP1LOH+qz7JtyJBj5g4bdeSy0NlakmP+qpmT7TwtIr2YEguWLQK3adMwE0jZpJ8OaBPagj2Krusp+SeO7PoelwZdEwOXzwe/laCLtiOjw4MQheOofCaj0RhAFNy+S7pZapGmqcyZRb8Hpxb9eVwVurH1v/IAgCzIOJ4tz8vi6pFqw3OOcNfBsarg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJFEPw6sP2fdsvmITJ+kNZxwjD1RSGc8l94pHMoWS5Y=;
 b=LWOTf0LljsnddvoPEaZc47OrLwXZ1cgWvaOwSH8M9W3ABGW7Iiwh0oi9AHlbARJwrIdyolKy2bJTMBWibpYkHJbYuq3LCLoKAGx5JO3czFieajHHnaTsVhb+s/BU1x9TczOY8Tcr3r93uepJPmFXqqi8raWjfRIGFOfu+sJdQd/7c60H1nXsJP/f89HkoaTcBM638LAPKw++0U7EKbovygtnOKhjfNzDF26FauCHAoS1t3WkBS5AQJ9jsSW9KV6vUyEQerJI3U7suYILEJf4xWlDykDEPn/SRguaZRFzbOfqgpWP8k0bAfZfIGDdxXOYp51oX56SsaKCoKnb7TuBGA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AS8PR04MB8401.eurprd04.prod.outlook.com (2603:10a6:20b:3f3::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.7; Fri, 15 Aug
 2025 18:13:44 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::9126:a61e:341d:4b06%5]) with mapi id 15.20.9052.006; Fri, 15 Aug 2025
 18:13:44 +0000
Date: Fri, 15 Aug 2025 14:13:34 -0400
From: Frank Li <Frank.li@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
Cc: "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>,
	Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
	"festevam@gmail.com" <festevam@gmail.com>,
	"F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH v3 net-next 04/15] ptp: netc: add NETC V4 Timer PTP
 driver support
Message-ID: <aJ94ztwgm0BkyDWs@lizhi-Precision-Tower-5810>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-5-wei.fang@nxp.com>
 <aJtXNrndlngzeSm8@lizhi-Precision-Tower-5810>
 <PAXPR04MB8510D9B82C03EF2A4379A14B882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB8510D9B82C03EF2A4379A14B882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
X-ClientProxiedBy: PH7PR13CA0023.namprd13.prod.outlook.com
 (2603:10b6:510:174::23) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AS8PR04MB8401:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d76199f-e24a-4ee6-b247-08dddc277864
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|52116014|7416014|376014|19092799006|366016|38350700014;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?15eGj09CS3NrxoMt0JK2EO8VxXIUIJMXIc6OtgsKDyiCdrEjEvuZSWS3/YH+?=
 =?us-ascii?Q?u9RuECNVVScG9dzqhFBPrP7QxcWdALUqBhFZQuWT5EUDP/F5y8m2MVkBL8Ou?=
 =?us-ascii?Q?K2+pYhLyK4oO/4y0hJ02MUYpapqQScNVJu1Oa6ZAavS2l1AjwAl1GmOw17Ra?=
 =?us-ascii?Q?gNl7oxF9QtefgNgHuY6wDrpmBt+m95JheH9DvDoSq0FO5Nj5QXN6LMIL4b6s?=
 =?us-ascii?Q?qP2g4Fz8wSJ+aT0eEjyE4jf+zWivvYZKLlF3OcHc3SB+kS0uZ63KMVdRW/+5?=
 =?us-ascii?Q?pU5qsyKj3wVS7XQO50cp4M5SKSOZ+JiaSvovwsFkvI1vgGSwpMLL01cr84Te?=
 =?us-ascii?Q?FC7eidTSXliKEh4ZiFXiq27gplDLaQmuKgga378n/KX6CUCOlY8LYl9EuW1P?=
 =?us-ascii?Q?xsee/WTPxqWjQymKPpIBS3vje2AksToLYo7QvSn/AA4tqpfLP9iUdphfld4D?=
 =?us-ascii?Q?TjQDPYvhDLCoKlIlaa/AQqqp/Ml5w3EPg3gPE7oZ71DEz45Yu8ayOb8C3F0+?=
 =?us-ascii?Q?Epeg81wSGAXTq/666IwPKbPYgnTKd9ad24Kwek0ydj3R7TAUh/EsYZTmLnv8?=
 =?us-ascii?Q?UXXMdshl3J+YAKWpbRaKtJCI0e7uHrNe2EWGQ7GBKNkfWYeR3jJuEWQ26+FK?=
 =?us-ascii?Q?z3ANXos+6u2yN4yzFYVKrAZoH7l2Ms20JfS4/920k50d7k0yEYMcMNnbtYHB?=
 =?us-ascii?Q?VhGg4hL2JvLmTu3K+Td/HRi7zvjfyMu4t45/nN3IDkaxvmqbHOn/KvHfy0sF?=
 =?us-ascii?Q?zd8g9Hv8tnB6Q84BEfLSwS8MoDWkgjPfSeuZXCVagZH+HkY+D1C6NRFU9E2Q?=
 =?us-ascii?Q?PrDqeN+yRrrKaGw8eeVZ9UB0XKoAE+YgNI1mhobEwLosHKH39BjoWzduxwWn?=
 =?us-ascii?Q?g6Ou1AyQmR2Tul9PNOPcAEkL9qiBqO3VVpZTdrVAFLOzb7vZTCurfm8D01n5?=
 =?us-ascii?Q?tTXTlrZugynRgJ7PbHjB7CYtilf9xwBG2/tq5Sp5VQqJbYzSpYBF3q5Jsd+9?=
 =?us-ascii?Q?o58KaYrYJjcdNwwE9dda5mfN+L7tXw7srMaawDBqBC6xlXIAJ5eN/gLcd2Md?=
 =?us-ascii?Q?hsw9FXKtWh1ZsfcAH3AyCzPKaEIOKOMamSN8jwcJuKtxkxzTB0GpiHPat2WN?=
 =?us-ascii?Q?GWNfKS15RwKmr0hIHE2eBS5x2OvBs32AI0/AK/0QKQoDIq8x7/7jW+op+Iq8?=
 =?us-ascii?Q?nIeCe8HGHzBiZx8U9kNp4lJbw1+70YyTLGZ0dr7yN6dEjLEZPiZan+vBJKNc?=
 =?us-ascii?Q?wjRWs9Ob5EDh7aj76ou9kQ0X4idT2JFa39BP4Lq9eKW0cm7xZrPkrswrkEmq?=
 =?us-ascii?Q?Rlo+sehyeylL0LY9OXWBW32XxUFtRxC7fmJOD/cBnYiMmRPWGrJTB/GrI+7C?=
 =?us-ascii?Q?hK/w3Gs/NaYGrnuSk+6sFS9SRk485CHJ0D6XUrt+8OLBYW8v4N7/R0YeLeFp?=
 =?us-ascii?Q?l9Y83+bjwiGotHW3uIfW1R2kFftsqgWEf5+PRqykWfCxTtyu5MWsNw=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(52116014)(7416014)(376014)(19092799006)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?hyfLntDJEU+PC7LGo8eDrWOYxy2SCi1lqNUyX95a9766Zm80a23HSdikbAQ5?=
 =?us-ascii?Q?5FrqvZ2PD+Ymu7Hkr7aX6L0FXOZuKxThZ/Bj7ETN7LV/4NETx1Z9bBrTFxOt?=
 =?us-ascii?Q?QsMvlHHOPY2z2xlOnuLD5qasH2DWUGN67gnUwcWW3Q6ods45+oVTQtpRl4LZ?=
 =?us-ascii?Q?e6VOqJzWO8vJABcU3Ok3RdSooQywKJLEpxOCZq67JpPdaDe21Di8P67xUuOv?=
 =?us-ascii?Q?xpC7rZQgphf6OZc17c7KAwAWkzfuM6SJYqRhzwOduJQyo28TV9wFcclm54xJ?=
 =?us-ascii?Q?jJXwW1mJJnKPgSytGaBLXC58bhYozTVt0VYEkTeH/J9AvBKjLzLtgHivFdSo?=
 =?us-ascii?Q?H/Jx/qpvyWXL7SEfuoBqjOyR324PA5aRy+QI7ngh8kTkaoL7tFmaRjs0UCGg?=
 =?us-ascii?Q?zLAVUp4ss+P/c5Jil0ZCj8MThocC/LNsWjIDTJ9Bb8li0Y4v/ov5qRoGHx30?=
 =?us-ascii?Q?0S9pj3XIwHGQPIoFO+S7M7Kz+SBTOV/mbWrPZofhasPgf8QomrMEqZIMnkDR?=
 =?us-ascii?Q?t3mIHfO40uG2iYX999A2dcsbNozpVALRSWPfixADzGMgHYyBnJxfERIkE32C?=
 =?us-ascii?Q?sjZ0DvmjiZV0zoLszN/AT9rQ1yYppUH47+75Np2gj0bGF/oMiBJzlTte1oxr?=
 =?us-ascii?Q?2NZKVqOZGwxuKtjgFpYji4gABVykSc8AVxg/rlJomRxY+jCALaRbEolH0qwC?=
 =?us-ascii?Q?5wXMK18SmgqvHMpyV8TBWQAg8nuNKasgwPLOMP25xHb+OCSe/VRhHCBgeIjf?=
 =?us-ascii?Q?7SN9LqPg+0UjPRzjngG0x4ktFAgq03kx7bJUwZ9eYZs3bEhxX2EdVKSG67J4?=
 =?us-ascii?Q?q9vrxcsXOzSkkdp7djR1G1O9JKc7JTAfjMV6scNdLk/jqg/pZv9lLKR1Ig5p?=
 =?us-ascii?Q?g7pYlgDeGoeTahKFbYOrd0cJCMS35VmE29FeT/+6m7vbMaNY7jWeSpkriBpK?=
 =?us-ascii?Q?E+v49N2NfzjBI+fTyYV0STEsgDpJukARjq+7H/OEg+u18qkjVbuIpQTGzHIa?=
 =?us-ascii?Q?KSe4d714WxpJYoWg86K/kFwV1Rz1yEHsPzedc+VIFMxZAnyO67lTMkwuaDbK?=
 =?us-ascii?Q?B8WLOeXjmeAKd2+OXyniteOnU6C0+Pq4QV0iuITi1RKAx33N9mH3wCbEFDJ0?=
 =?us-ascii?Q?+xQ3izwD3oJ1rH5BB/kI2U7jKVXvXhH+uIFeqbe0o1AkcijskNT0gk+CtmaK?=
 =?us-ascii?Q?qKxvojJPEZzc1CiZdh+7DKplTkVngg6W8ZzDfJcguV+CJNsYw3J2DLiYyc/A?=
 =?us-ascii?Q?zsldcg0K0QfWC21Dy/xJjzOnNJEjn8NVYdOR1tl0rtaSAsa8C5i1MHC2E4X8?=
 =?us-ascii?Q?3/hvyPT9sSaJypZlHpXgMhYbpe3juKu/DYSD3Ai6BcqerdD0+n5R6RcasO33?=
 =?us-ascii?Q?9VecjXBe7fmNTFc8dW6mTs+duM0hLiYpKcA4Uc0DWsyXk5fVsW+SybRHtyQs?=
 =?us-ascii?Q?NNDXTzRt4sS09Rzx03jPMf4FRPNFc+gNpyqD3IVWvIjMVMqOrxVoDCBPYRvY?=
 =?us-ascii?Q?x+WxG7JVBnngqGLGoIG63qtzxMHZmXY2eU0SMnUTc0eI25I0h6fkIx/RCU1c?=
 =?us-ascii?Q?GUM3yYvhosp6aAElqN6/F/Jymzh6eixrh7LqLMKf?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d76199f-e24a-4ee6-b247-08dddc277864
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Aug 2025 18:13:44.1196
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xgC9QLQ9zFx47k/vlzv+8CtGmnDcmy9Y+JjaDYrbSXvrDMyO97O7l7fGlE8c5ESJkLTxqFA4/diF02GFo8Yg4Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8401

On Wed, Aug 13, 2025 at 01:46:10AM +0000, Wei Fang wrote:
> > On Tue, Aug 12, 2025 at 05:46:23PM +0800, Wei Fang wrote:
> > > NETC V4 Timer provides current time with nanosecond resolution,
> > > precise periodic pulse, pulse on timeout (alarm), and time capture on
> > > external pulse support. And it supports time synchronization as
> > > required for IEEE 1588 and IEEE 802.1AS-2020.
> > >
> > > Inside NETC, ENETC can capture the timestamp of the sent/received
> > > packet through the PHC provided by the Timer and record it on the
> > > Tx/Rx BD. And through the relevant PHC interfaces provided by the
> > > driver, the enetc V4 driver can support PTP time synchronization.
> > >
> > > In addition, NETC V4 Timer is similar to the QorIQ 1588 timer, but it
> > > is not exactly the same. The current ptp-qoriq driver is not
> > > compatible with NETC V4 Timer, most of the code cannot be reused, see below
> > reasons.
> > >
> > > 1. The architecture of ptp-qoriq driver makes the register offset
> > > fixed, however, the offsets of all the high registers and low
> > > registers of V4 are swapped, and V4 also adds some new registers. so
> > > extending ptp-qoriq to make it compatible with V4 Timer is tantamount
> > > to completely rewriting ptp-qoriq driver.
> > >
> > > 2. The usage of some functions is somewhat different from QorIQ timer,
> > > such as the setting of TCLK_PERIOD and TMR_ADD, the logic of
> > > configuring PPS, etc., so making the driver compatible with V4 Timer
> > > will undoubtedly increase the complexity of the code and reduce readability.
> > >
> > > 3. QorIQ is an expired brand. It is difficult for us to verify whether
> > > it works stably on the QorIQ platforms if we refactor the driver, and
> > > this will make maintenance difficult, so refactoring the driver
> > > obviously does not bring any benefits.
> > >
> > > Therefore, add this new driver for NETC V4 Timer. Note that the
> > > missing features like PEROUT, PPS and EXTTS will be added in subsequent
> > patches.
> > >
> > > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > >
> > > ---
> > > v2 changes:
> > > 1. Rename netc_timer_get_source_clk() to
> > >    netc_timer_get_reference_clk_source() and refactor it 2. Remove the
> > > scaled_ppm check in netc_timer_adjfine() 3. Add a comment in
> > > netc_timer_cur_time_read() 4. Add linux/bitfield.h to fix the build
> > > errors
> > > v3 changes:
> > > 1. Refactor netc_timer_adjtime() and remove netc_timer_cnt_read() 2.
> > > Remove the check of dma_set_mask_and_coherent() 3. Use devm_kzalloc()
> > > and pci_ioremap_bar() 4. Move alarm related logic including irq
> > > handler to the next patch 5. Improve the commit message 6. Refactor
> > > netc_timer_get_reference_clk_source() and remove
> > >    clk_prepare_enable()
> > > 7. Use FIELD_PREP() helper
> > > 8. Rename PTP_1588_CLOCK_NETC to PTP_NETC_V4_TIMER and improve the
> > >    help text.
> > > 9. Refine netc_timer_adjtime(), change tmr_off to s64 type as we
> > >    confirmed TMR_OFF is a signed register.
> > > ---
> > >  drivers/ptp/Kconfig             |  11 +
> > >  drivers/ptp/Makefile            |   1 +
> > >  drivers/ptp/ptp_netc.c          | 438
> > ++++++++++++++++++++++++++++++++
> > >  include/linux/fsl/netc_global.h |  12 +-
> > >  4 files changed, 461 insertions(+), 1 deletion(-)  create mode 100644
> > > drivers/ptp/ptp_netc.c
> > >
> > > diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig index
> > > 204278eb215e..0ac31a20096c 100644
> > > --- a/drivers/ptp/Kconfig
> > > +++ b/drivers/ptp/Kconfig
> > > @@ -252,4 +252,15 @@ config PTP_S390
> > >  	  driver provides the raw clock value without the delta to
> > >  	  userspace. That way userspace programs like chrony could steer
> > >  	  the kernel clock.
> > > +
> > > +config PTP_NETC_V4_TIMER
> > > +	bool "NXP NETC V4 Timer PTP Driver"
> > > +	depends on PTP_1588_CLOCK=y
> > > +	depends on PCI_MSI
> > > +	help
> > > +	  This driver adds support for using the NXP NETC V4 Timer as a PTP
> > > +	  clock, the clock is used by ENETC V4 or NETC V4 Switch for PTP time
> > > +	  synchronization. It also supports periodic output signal (e.g. PPS)
> > > +	  and external trigger timestamping.
> > > +
> > >  endmenu
> > > diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile index
> > > 25f846fe48c9..8985d723d29c 100644
> > > --- a/drivers/ptp/Makefile
> > > +++ b/drivers/ptp/Makefile
> > > @@ -23,3 +23,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
> > >  obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
> > >  obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
> > >  obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
> > > +obj-$(CONFIG_PTP_NETC_V4_TIMER)		+= ptp_netc.o
> > > diff --git a/drivers/ptp/ptp_netc.c b/drivers/ptp/ptp_netc.c new file
> > > mode 100644 index 000000000000..cbe2a64d1ced
> > > --- /dev/null
> > > +++ b/drivers/ptp/ptp_netc.c
> > > @@ -0,0 +1,438 @@
> > > +// SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause)
> > > +/*
> > > + * NXP NETC V4 Timer driver
> > > + * Copyright 2025 NXP
> > > + */
> > > +
> > > +#include <linux/bitfield.h>
> > > +#include <linux/clk.h>
> > > +#include <linux/fsl/netc_global.h>
> > > +#include <linux/module.h>
> > > +#include <linux/of.h>
> > > +#include <linux/of_platform.h>
> > > +#include <linux/ptp_clock_kernel.h>
> > > +
> > > +#define NETC_TMR_PCI_VENDOR		0x1131
> > > +#define NETC_TMR_PCI_DEVID		0xee02
> >
> > Nit: Like this only use once constant, needn't macro, espcial DEVID.
>
> So you mean directly use PCI_DEVICE(0x1131,0xee02)?


Yes, or
PCI_DEVICE(PCI_VENDOR_ID_PHILIPS, 0xee02);

Frank

>
> >
> > > +
> > > +#define NETC_TMR_CTRL			0x0080
> > > +#define  TMR_CTRL_CK_SEL		GENMASK(1, 0)
> > > +#define  TMR_CTRL_TE			BIT(2)
> > > +#define  TMR_COMP_MODE			BIT(15)
> > > +#define  TMR_CTRL_TCLK_PERIOD		GENMASK(25, 16)
> > > +
> > > +#define NETC_TMR_CNT_L			0x0098
> > > +#define NETC_TMR_CNT_H			0x009c
> > > +#define NETC_TMR_ADD			0x00a0
> > > +#define NETC_TMR_PRSC			0x00a8
> > > +#define NETC_TMR_OFF_L			0x00b0
> > > +#define NETC_TMR_OFF_H			0x00b4
> > > +
> > > +#define NETC_TMR_FIPER_CTRL		0x00dc
> > > +#define  FIPER_CTRL_DIS(i)		(BIT(7) << (i) * 8)
> > > +#define  FIPER_CTRL_PG(i)		(BIT(6) << (i) * 8)
> > > +
> > > +#define NETC_TMR_CUR_TIME_L		0x00f0
> > > +#define NETC_TMR_CUR_TIME_H		0x00f4
> > > +
> > > +#define NETC_TMR_REGS_BAR		0
> > > +
> > > +#define NETC_TMR_FIPER_NUM		3
> > > +#define NETC_TMR_DEFAULT_PRSC		2
> > > +
> > > +/* 1588 timer reference clock source select */
> > > +#define NETC_TMR_CCM_TIMER1		0 /* enet_timer1_clk_root, from
> > CCM */
> > > +#define NETC_TMR_SYSTEM_CLK		1 /* enet_clk_root/2, from CCM */
> > > +#define NETC_TMR_EXT_OSC		2 /* tmr_1588_clk, from IO pins */
> > > +
> > > +#define NETC_TMR_SYSCLK_333M		333333333U
> > > +
> > > +struct netc_timer {
> > > +	void __iomem *base;
> > > +	struct pci_dev *pdev;
> > > +	spinlock_t lock; /* Prevent concurrent access to registers */
> > > +
> > > +	struct ptp_clock *clock;
> > > +	struct ptp_clock_info caps;
> > > +	int phc_index;
> > > +	u32 clk_select;
> > > +	u32 clk_freq;
> > > +	u32 oclk_prsc;
> > > +	/* High 32-bit is integer part, low 32-bit is fractional part */
> > > +	u64 period;
> > > +};
> > > +
> > > +#define netc_timer_rd(p, o)		netc_read((p)->base + (o))
> > > +#define netc_timer_wr(p, o, v)		netc_write((p)->base + (o), v)
> > > +#define ptp_to_netc_timer(ptp)		container_of((ptp), struct
> > netc_timer, caps)
> > > +
> > > +static const char *const timer_clk_src[] = {
> > > +	"ccm_timer",
> > > +	"ext_1588"
> > > +};
> > > +
> > > +static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns) {
> > > +	u32 tmr_cnt_h = upper_32_bits(ns);
> > > +	u32 tmr_cnt_l = lower_32_bits(ns);
> > > +
> > > +	/* Writes to the TMR_CNT_L register copies the written value
> > > +	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
> > > +	 * register copies the values written into the shadow TMR_CNT_H
> > > +	 * register. Contents of the shadow registers are copied into
> > > +	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
> > > +	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
> > > +	 * register first.
> > > +	 */
> >
> > Is all other register the same? like OFF_L, OFF_H?
> >
> > And read have similar behavor?
> >
> > > +	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
> > > +	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h); }
> > > +
> > > +static u64 netc_timer_offset_read(struct netc_timer *priv) {
> > > +	u32 tmr_off_l, tmr_off_h;
> > > +	u64 offset;
> > > +
> > > +	tmr_off_l = netc_timer_rd(priv, NETC_TMR_OFF_L);
> > > +	tmr_off_h = netc_timer_rd(priv, NETC_TMR_OFF_H);
> > > +	offset = (((u64)tmr_off_h) << 32) | tmr_off_l;
> > > +
> > > +	return offset;
> > > +}
> > > +
> > > +static void netc_timer_offset_write(struct netc_timer *priv, u64
> > > +offset) {
> > > +	u32 tmr_off_h = upper_32_bits(offset);
> > > +	u32 tmr_off_l = lower_32_bits(offset);
> > > +
> > > +	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
> > > +	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h); }
> > > +
> > > +static u64 netc_timer_cur_time_read(struct netc_timer *priv) {
> > > +	u32 time_h, time_l;
> > > +	u64 ns;
> > > +
> > > +	/* The user should read NETC_TMR_CUR_TIME_L first to
> > > +	 * get correct current time.
> > > +	 */
> > > +	time_l = netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
> > > +	time_h = netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
> > > +	ns = (u64)time_h << 32 | time_l;
> > > +
> > > +	return ns;
> > > +}
> > > +
> > > +static void netc_timer_adjust_period(struct netc_timer *priv, u64
> > > +period) {
> > > +	u32 fractional_period = lower_32_bits(period);
> > > +	u32 integral_period = upper_32_bits(period);
> > > +	u32 tmr_ctrl, old_tmr_ctrl;
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&priv->lock, flags);
> > > +
> > > +	old_tmr_ctrl = netc_timer_rd(priv, NETC_TMR_CTRL);
> > > +	tmr_ctrl = u32_replace_bits(old_tmr_ctrl, integral_period,
> > > +				    TMR_CTRL_TCLK_PERIOD);
> > > +	if (tmr_ctrl != old_tmr_ctrl)
> > > +		netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> > > +
> > > +	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period);
> > > +
> > > +	spin_unlock_irqrestore(&priv->lock, flags); }
> > > +
> > > +static int netc_timer_adjfine(struct ptp_clock_info *ptp, long
> > > +scaled_ppm) {
> > > +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> > > +	u64 new_period;
> > > +
> > > +	new_period = adjust_by_scaled_ppm(priv->period, scaled_ppm);
> > > +	netc_timer_adjust_period(priv, new_period);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int netc_timer_adjtime(struct ptp_clock_info *ptp, s64 delta)
> > > +{
> > > +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> > > +	unsigned long flags;
> > > +	s64 tmr_off;
> > > +
> > > +	spin_lock_irqsave(&priv->lock, flags);
> > > +
> > > +	/* Adjusting TMROFF instead of TMR_CNT is that the timer
> > > +	 * counter keeps increasing during reading and writing
> > > +	 * TMR_CNT, which will cause latency.
> > > +	 */
> > > +	tmr_off = netc_timer_offset_read(priv);
> > > +	tmr_off += delta;
> > > +	netc_timer_offset_write(priv, tmr_off);
> > > +
> > > +	spin_unlock_irqrestore(&priv->lock, flags);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int netc_timer_gettimex64(struct ptp_clock_info *ptp,
> > > +				 struct timespec64 *ts,
> > > +				 struct ptp_system_timestamp *sts) {
> > > +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> > > +	unsigned long flags;
> > > +	u64 ns;
> > > +
> > > +	spin_lock_irqsave(&priv->lock, flags);
> > > +
> > > +	ptp_read_system_prets(sts);
> > > +	ns = netc_timer_cur_time_read(priv);
> > > +	ptp_read_system_postts(sts);
> > > +
> > > +	spin_unlock_irqrestore(&priv->lock, flags);
> > > +
> > > +	*ts = ns_to_timespec64(ns);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int netc_timer_settime64(struct ptp_clock_info *ptp,
> > > +				const struct timespec64 *ts)
> > > +{
> > > +	struct netc_timer *priv = ptp_to_netc_timer(ptp);
> > > +	u64 ns = timespec64_to_ns(ts);
> > > +	unsigned long flags;
> > > +
> > > +	spin_lock_irqsave(&priv->lock, flags);
> > > +	netc_timer_offset_write(priv, 0);
> > > +	netc_timer_cnt_write(priv, ns);
> > > +	spin_unlock_irqrestore(&priv->lock, flags);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +int netc_timer_get_phc_index(struct pci_dev *timer_pdev) {
> > > +	struct netc_timer *priv;
> > > +
> > > +	if (!timer_pdev)
> > > +		return -ENODEV;
> > > +
> > > +	priv = pci_get_drvdata(timer_pdev);
> > > +	if (!priv)
> > > +		return -EINVAL;
> > > +
> > > +	return priv->phc_index;
> > > +}
> > > +EXPORT_SYMBOL_GPL(netc_timer_get_phc_index);
> > > +
> > > +static const struct ptp_clock_info netc_timer_ptp_caps = {
> > > +	.owner		= THIS_MODULE,
> > > +	.name		= "NETC Timer PTP clock",
> > > +	.max_adj	= 500000000,
> > > +	.n_pins		= 0,
> > > +	.adjfine	= netc_timer_adjfine,
> > > +	.adjtime	= netc_timer_adjtime,
> > > +	.gettimex64	= netc_timer_gettimex64,
> > > +	.settime64	= netc_timer_settime64,
> > > +};
> > > +
> > > +static void netc_timer_init(struct netc_timer *priv) {
> > > +	u32 fractional_period = lower_32_bits(priv->period);
> > > +	u32 integral_period = upper_32_bits(priv->period);
> > > +	u32 tmr_ctrl, fiper_ctrl;
> > > +	struct timespec64 now;
> > > +	u64 ns;
> > > +	int i;
> > > +
> > > +	/* Software must enable timer first and the clock selected must be
> > > +	 * active, otherwise, the registers which are in the timer clock
> > > +	 * domain are not accessible.
> > > +	 */
> > > +	tmr_ctrl = FIELD_PREP(TMR_CTRL_CK_SEL, priv->clk_select) |
> > > +		   TMR_CTRL_TE;
> > > +	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> > > +	netc_timer_wr(priv, NETC_TMR_PRSC, priv->oclk_prsc);
> > > +
> > > +	/* Disable FIPER by default */
> > > +	fiper_ctrl = netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> > > +	for (i = 0; i < NETC_TMR_FIPER_NUM; i++) {
> > > +		fiper_ctrl |= FIPER_CTRL_DIS(i);
> > > +		fiper_ctrl &= ~FIPER_CTRL_PG(i);
> > > +	}
> > > +	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> > > +
> > > +	ktime_get_real_ts64(&now);
> > > +	ns = timespec64_to_ns(&now);
> > > +	netc_timer_cnt_write(priv, ns);
> > > +
> > > +	/* Allow atomic writes to TCLK_PERIOD and TMR_ADD, An update to
> > > +	 * TCLK_PERIOD does not take effect until TMR_ADD is written.
> > > +	 */
> > > +	tmr_ctrl |= FIELD_PREP(TMR_CTRL_TCLK_PERIOD, integral_period) |
> > > +		    TMR_COMP_MODE;
> > > +	netc_timer_wr(priv, NETC_TMR_CTRL, tmr_ctrl);
> > > +	netc_timer_wr(priv, NETC_TMR_ADD, fractional_period); }
> > > +
> > > +static int netc_timer_pci_probe(struct pci_dev *pdev) {
> > > +	struct device *dev = &pdev->dev;
> > > +	struct netc_timer *priv;
> > > +	int err;
> > > +
> > > +	pcie_flr(pdev);
> > > +	err = pci_enable_device_mem(pdev);
> > > +	if (err)
> > > +		return dev_err_probe(dev, err, "Failed to enable device\n");
> > > +
> > > +	dma_set_mask_and_coherent(dev, DMA_BIT_MASK(64));
> > > +	err = pci_request_mem_regions(pdev, KBUILD_MODNAME);
> > > +	if (err) {
> > > +		dev_err(dev, "pci_request_regions() failed, err:%pe\n",
> > > +			ERR_PTR(err));
> > > +		goto disable_dev;
> > > +	}
> > > +
> > > +	pci_set_master(pdev);
> > > +	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > > +	if (!priv) {
> > > +		err = -ENOMEM;
> > > +		goto release_mem_regions;
> > > +	}
> >
> > move devm_kzalloc() before pci_enable_device_mem() to reduce a goto
> >
> > > +
> > > +	priv->pdev = pdev;
> > > +	priv->base = pci_ioremap_bar(pdev, NETC_TMR_REGS_BAR);
> > > +	if (!priv->base) {
> > > +		err = -ENOMEM;
> > > +		goto release_mem_regions;
> > > +	}
> > > +
> > > +	pci_set_drvdata(pdev, priv);
> > > +
> > > +	return 0;
> > > +
> > > +release_mem_regions:
> > > +	pci_release_mem_regions(pdev);
> > > +disable_dev:
> > > +	pci_disable_device(pdev);
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +static void netc_timer_pci_remove(struct pci_dev *pdev) {
> > > +	struct netc_timer *priv = pci_get_drvdata(pdev);
> > > +
> > > +	iounmap(priv->base);
> > > +	pci_release_mem_regions(pdev);
> > > +	pci_disable_device(pdev);
> > > +}
> > > +
> > > +static int netc_timer_get_reference_clk_source(struct netc_timer
> > > +*priv) {
> > > +	struct device *dev = &priv->pdev->dev;
> > > +	struct clk *clk;
> > > +	int i;
> > > +
> > > +	/* Select NETC system clock as the reference clock by default */
> > > +	priv->clk_select = NETC_TMR_SYSTEM_CLK;
> > > +	priv->clk_freq = NETC_TMR_SYSCLK_333M;
> > > +
> > > +	/* Update the clock source of the reference clock if the clock
> > > +	 * is specified in DT node.
> > > +	 */
> > > +	for (i = 0; i < ARRAY_SIZE(timer_clk_src); i++) {
> > > +		clk = devm_clk_get_optional_enabled(dev, timer_clk_src[i]);
> > > +		if (IS_ERR(clk))
> > > +			return PTR_ERR(clk);
> > > +
> > > +		if (clk) {
> > > +			priv->clk_freq = clk_get_rate(clk);
> > > +			priv->clk_select = i ? NETC_TMR_EXT_OSC :
> > > +					       NETC_TMR_CCM_TIMER1;
> > > +			break;
> > > +		}
> > > +	}
> > > +
> > > +	/* The period is a 64-bit number, the high 32-bit is the integer
> > > +	 * part of the period, the low 32-bit is the fractional part of
> > > +	 * the period. In order to get the desired 32-bit fixed-point
> > > +	 * format, multiply the numerator of the fraction by 2^32.
> > > +	 */
> > > +	priv->period = div_u64(NSEC_PER_SEC << 32, priv->clk_freq);
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +static int netc_timer_parse_dt(struct netc_timer *priv) {
> > > +	return netc_timer_get_reference_clk_source(priv);
> > > +}
> > > +
> > > +static int netc_timer_probe(struct pci_dev *pdev,
> > > +			    const struct pci_device_id *id) {
> > > +	struct device *dev = &pdev->dev;
> > > +	struct netc_timer *priv;
> > > +	int err;
> > > +
> > > +	err = netc_timer_pci_probe(pdev);
> > > +	if (err)
> > > +		return err;
> > > +
> > > +	priv = pci_get_drvdata(pdev);
> > > +	err = netc_timer_parse_dt(priv);
> > > +	if (err) {
> > > +		if (err != -EPROBE_DEFER)
> > > +			dev_err(dev, "Failed to parse DT node\n");
> > > +		goto timer_pci_remove;
> > > +	}
> >
> > move netc_timer_parse_dt() before netc_timer_pci_probe()
> >
> > you can use return dev_err_probe(), which already handle -EPROBE_DEFER
> > case.
> >
> >
> > > +
> > > +	priv->caps = netc_timer_ptp_caps;
> > > +	priv->oclk_prsc = NETC_TMR_DEFAULT_PRSC;
> > > +	spin_lock_init(&priv->lock);
> > > +
> > > +	netc_timer_init(priv);
> > > +	priv->clock = ptp_clock_register(&priv->caps, dev);
> > > +	if (IS_ERR(priv->clock)) {
> > > +		err = PTR_ERR(priv->clock);
> > > +		goto timer_pci_remove;
> > > +	}
> > > +
> > > +	priv->phc_index = ptp_clock_index(priv->clock);
> > > +
> > > +	return 0;
> > > +
> > > +timer_pci_remove:
> > > +	netc_timer_pci_remove(pdev);
> > > +
> > > +	return err;
> > > +}
> > > +
> > > +static void netc_timer_remove(struct pci_dev *pdev) {
> >
> > use devm_add_action_or_reset() can simpify your error handle.
> >
> > Frank
> > > +	struct netc_timer *priv = pci_get_drvdata(pdev);
> > > +
> > > +	ptp_clock_unregister(priv->clock);
> > > +	netc_timer_pci_remove(pdev);
> > > +}
> > > +
> > > +static const struct pci_device_id netc_timer_id_table[] = {
> > > +	{ PCI_DEVICE(NETC_TMR_PCI_VENDOR, NETC_TMR_PCI_DEVID) },
> > > +	{ }
> > > +};
> > > +MODULE_DEVICE_TABLE(pci, netc_timer_id_table);
> > > +
> > > +static struct pci_driver netc_timer_driver = {
> > > +	.name = KBUILD_MODNAME,
> > > +	.id_table = netc_timer_id_table,
> > > +	.probe = netc_timer_probe,
> > > +	.remove = netc_timer_remove,
> > > +};
> > > +module_pci_driver(netc_timer_driver);
> > > +
> > > +MODULE_DESCRIPTION("NXP NETC Timer PTP Driver");
> > MODULE_LICENSE("Dual
> > > +BSD/GPL");
> > > diff --git a/include/linux/fsl/netc_global.h
> > > b/include/linux/fsl/netc_global.h index fdecca8c90f0..17c19c8d3f93
> > > 100644
> > > --- a/include/linux/fsl/netc_global.h
> > > +++ b/include/linux/fsl/netc_global.h
> > > @@ -1,10 +1,11 @@
> > >  /* SPDX-License-Identifier: (GPL-2.0+ OR BSD-3-Clause) */
> > > -/* Copyright 2024 NXP
> > > +/* Copyright 2024-2025 NXP
> > >   */
> > >  #ifndef __NETC_GLOBAL_H
> > >  #define __NETC_GLOBAL_H
> > >
> > >  #include <linux/io.h>
> > > +#include <linux/pci.h>
> > >
> > >  static inline u32 netc_read(void __iomem *reg)  { @@ -16,4 +17,13 @@
> > > static inline void netc_write(void __iomem *reg, u32 val)
> > >  	iowrite32(val, reg);
> > >  }
> > >
> > > +#if IS_ENABLED(CONFIG_PTP_NETC_V4_TIMER)
> > > +int netc_timer_get_phc_index(struct pci_dev *timer_pdev); #else
> > > +static inline int netc_timer_get_phc_index(struct pci_dev
> > > +*timer_pdev) {
> > > +	return -ENODEV;
> > > +}
> > > +#endif
> > > +
> > >  #endif
> > > --
> > > 2.34.1
> > >


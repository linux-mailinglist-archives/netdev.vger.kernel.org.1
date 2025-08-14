Return-Path: <netdev+bounces-213554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B356B25979
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 04:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AA9961B6842D
	for <lists+netdev@lfdr.de>; Thu, 14 Aug 2025 02:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F14A256C6D;
	Thu, 14 Aug 2025 02:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H+il9FZW"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011034.outbound.protection.outlook.com [52.101.70.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD3924DD11;
	Thu, 14 Aug 2025 02:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755138175; cv=fail; b=WvZSSjc6VlgBAtFU/WaiZUAEu5QQ17Ovzr2eYQsEKVjZO5Ebzfh1oBKxggDdJS1/tnGXrWpcOe1/NSGYFjeItdU3dn2ft3Iqx8sklIl992LzxxJJ31oeBkN1K1d0QX4Xxg5KUnlt+t4RX2DNd8zVyuB9idAC11fjIRncUmEoME8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755138175; c=relaxed/simple;
	bh=bB9d3CA9uLUpL7NK8m8ZdTo9Dui7m2tfWkNDcSU/htk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d1yn5twnQpc473h/mf4Oe+LXpEjWYDD3lCwROBTAibKAlwnSCo9wW2IV4B04XLJl0L9srVKrWV+3J56f9GspeVsvAu2XFyG0V9AIhpSy5G4wnkPBhJLUSqsbq09ShBuWYtuvXor0lhyT9Ecfh0QA1yzKfBybtREjAuA9QBBWwPY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H+il9FZW; arc=fail smtp.client-ip=52.101.70.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WxYmkxsUSn2bi65NQBD7sBaYrFhX1lOJncslAKD4JE+dX4Pn06TVm5Q1R1zf8dIyMjCUFUeRd2yCkAAPBXTKHfiPWVcmL1Xbfh5IorvOtL+yCO/PaV6/X7Z30lNrN5TTn5GZe0FujbF5iyyuUM0FGq1bpDe/I2Xrw/P/iGhd0OfVyEMf8OilUaXtvGFkc1tUXcSdTmxrnOuqdZhmS7QZ8oLX6VNIPZpfnB4TTF1mU/giJkWp50Z7rjqguOwZ/zsuPWkPSMI0S9o8peJzWxSmo2LupD+EuQ2BSxJNT8258vmpU71UMcXjXyXCQQXXq3gsNqgiIWCGU5tA1tF6bjygsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BR8llfgoNeUfMxvk13DdvtDh5qZGe6ULxuue+m7W8Bw=;
 b=k1Mf8n2X0AX4VsBObJdUv8DG1XWCbbLfaCraqgZ5Z7N8tyHgrk0vGMcmaUgQkd9L6QmZ9ULeWJdJljVvk7OINQ97SyrONFiRyEXN/ZENrgqAkTe7qP3w/9nPvN9GG1Q2J9zmXcePYB4gqSVfB1nbYGdxtlwXVU+eAdTmN2w99XbyJ18jCZpCWPxdMXJ/OfhRecrcNMuJOnidrvYK7wT/ok/JI83rFdVyGjYFuFfjb7NjGy4v8rzXUXRsYHYYE7lJB1fQHkuDZwunrUuNORXUVl3zgi4doVkoDbId3laP/oD6eLdsKGnUC5YnnMGAIYbw19cVcR3NBmcoENjswM0Rtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BR8llfgoNeUfMxvk13DdvtDh5qZGe6ULxuue+m7W8Bw=;
 b=H+il9FZWeSrj3fYcIwIZ4AY4t3Tbe0XmrDCe6XqnGEhheBypC3LpzECkMim+yO3j7ggAhB6RC0Of3AwsnL1In17K1MG9OLGDSoB7USr3lv2+avh4lSoba4Am1N4TyJTOlSF9FMwHdefBH3Z7XiFFNbjN1Z56zvPW09HSeXRE3Zxsk7lyG2+lQYsjpCBS/uBG9OaMI2N8Q6lbGQuXVEat7d/Cjh4MWd51/5OBXN33P6RWVlHKJIMsDXJuhtaPqCmclxHIPwWsrT/UJPCuK7Z6I2g+Nk9Lc3QI6xBpCCGWuUz/N1+3ihATR6+QVJRSnf33IrAopFaRzXDaQecGOyhvew==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GVXPR04MB9879.eurprd04.prod.outlook.com (2603:10a6:150:11c::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.13; Thu, 14 Aug
 2025 02:22:47 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Thu, 14 Aug 2025
 02:22:47 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>, "festevam@gmail.com" <festevam@gmail.com>, "F.S.
 Peng" <fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: RE: [PATCH v3 net-next 05/15] ptp: netc: add PTP_CLK_REQ_PPS support
Thread-Topic: [PATCH v3 net-next 05/15] ptp: netc: add PTP_CLK_REQ_PPS support
Thread-Index: AQHcC3DsDacGBzi4GkeW8QCnEeawArRfH9SAgACx0RCAAN9JgIAAuIEQ
Date: Thu, 14 Aug 2025 02:22:47 +0000
Message-ID:
 <PAXPR04MB8510EFCF906554968D2380D88835A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-6-wei.fang@nxp.com>
 <aJtZl3jgBD0hLyt0@lizhi-Precision-Tower-5810>
 <PAXPR04MB85109D4D0866A0E03BF04611882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <aJyqDxFwzKgmeUdA@lizhi-Precision-Tower-5810>
In-Reply-To: <aJyqDxFwzKgmeUdA@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GVXPR04MB9879:EE_
x-ms-office365-filtering-correlation-id: 4b6a2e76-dfb7-4db3-c980-08dddad975ef
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|7416014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2AAN9RpAqDmXmAIHpfZRX7F+J48HxebyXBZOKNQM32zTA1rC6KafbeNxChx0?=
 =?us-ascii?Q?PrAl1g/wXCEqiBMwIbHq5xPgruThBVrsu9G4pBvL1cmEkTWPvNZg3fMWZT7E?=
 =?us-ascii?Q?+S1l+vCPGjr5EeG4iSBRvt7sBdXnWfb5fUdJ/jEBL4H+y6JPJKHssy2JAVOc?=
 =?us-ascii?Q?11grg1hkdlNT5BBJVcb2ZHEQgyYlviIKBaXVZn3nNmg0i/HTLFUjB4vnRyS4?=
 =?us-ascii?Q?UN4kU4pfvUJQOfWhy1/FgocB4qZR2wZ5nypRMg7Pu9vsknFq9Fb052o/7Ctl?=
 =?us-ascii?Q?tXbif8FGq+zr58B621ja8jH+RJOtBTAx/7okJM5l284pVdUuOV7kjOg2hwKi?=
 =?us-ascii?Q?1PvrNFxk/vo9DqqHazoJRvRdZb/KAtSVdQuyScmE9KOfN3WgNvcx+SZ7hY4/?=
 =?us-ascii?Q?QXouqQhtavK3qtmNSbhs6yQfd75T205J9zn/A59EVHj3EPP9szLNpM5nXKoP?=
 =?us-ascii?Q?PHNUedBLZp6BpQ0xQ/I89+9vQq3qgkTMXDMW0FFZ6/9oznnPcyZxxpoGUF+3?=
 =?us-ascii?Q?eJZ/VGVJGZX2udvf1S/Op7/5csl3DCd2mVxKwi9IKvkbjj4CtXeUU+OBcf1E?=
 =?us-ascii?Q?LguqJYMTgcXJHhTPAzhTzt4QHiffDK1cJ+kyPIQvdgg8HNzC7XyqBIhFiaW1?=
 =?us-ascii?Q?WhkAjGflVl/ut7VSRbkHcJVVg+TI0bC1Onrcgmm15eFDBbVy/K3LDhnhK2Yy?=
 =?us-ascii?Q?RtPIYqjZxspWwcqd7HKCC5DVJtPj/Yf2Pq4SwbmA4AAXge96qbVAec2v/Fca?=
 =?us-ascii?Q?pNJid78rA51MuCBiyNQmAVfyOu2L9U0hVw0ouyx2dNmgxAiBbbcfLzY8AXCR?=
 =?us-ascii?Q?CrI23VYwtRVfyT42pjsXqIXJFD5QtcygxnNlBpdJRb735vs2zm9hSCNIi7r1?=
 =?us-ascii?Q?tvjlKDAyH5Sorb+zNUjHyJp24rc+WB48zBtXr0L36gwoxFOnbcDCJRL92HDC?=
 =?us-ascii?Q?e86BGcXMRBblg2uun7MSK2NCKHOMv4comvwoKGzWsrJTBPqr18wHdEm49Dd4?=
 =?us-ascii?Q?CmtWuvbjv/lAj3CBK0UBMsFbckYJrZv8J+YwXRS+heMJYs2W3kDanUGoNhDH?=
 =?us-ascii?Q?qNwziPGPdJIAMJZUegiMu/WPdtnebn2UuJClRifnFAyorxKIf+lflw6yf1g2?=
 =?us-ascii?Q?OHZcEgSGl8Lqzzkxd4aix3Ngc6f+yujreaLgwxXYRla1p6w8pjNmK7gA6MIg?=
 =?us-ascii?Q?qrZIk4VRl2WMk6D030xIsqatqZUVDlv0ScF4W5fKh4eWjomgpn+YJY2J0glH?=
 =?us-ascii?Q?aUVRMoesOI8kP/R4xtZsQ2K1h8N5Qgs0raXjfLm0eORAZ3untXwi/EAl6N9H?=
 =?us-ascii?Q?Hbo9ifA4lp0QPqxv3Fr5QZ0iEPOzEUB6UEEhhvF/X7HaKgKLGRkLL5EGJSDW?=
 =?us-ascii?Q?cpLQWGlICO/QUFynIBQFZcWvOpN6wMxhNlnUdYoefF1AEc/iR3WdrU/wxbrf?=
 =?us-ascii?Q?ikgRZjFrnP2zsdAVIWVBNRTVTI2qYI6ZEL/ycCS95FT9l7DFheeBsg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(7416014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?YA9kYrg051hn3faO6mqM7OotqBxWP5ksZLfWg6q4Tip2enWgSsgcLqXgEKqs?=
 =?us-ascii?Q?e3qePZu3jdpvsTAyjTzC/vLDCGc8FMe5GuZoBj92ZwzOsZr4Nli42JUuk+RM?=
 =?us-ascii?Q?++NQynhvuQP5cQqrIX9w0faKMAxp58eaZCdSbeWmZVCIgBDgOJE4vgc+uxjB?=
 =?us-ascii?Q?ZKf0hEbZwZ5t9UxZVwOjj73lS+ykcpL0XnQy3xXAY6iAcB7//JdB6W8oaXRz?=
 =?us-ascii?Q?3xb0Qxa3+/gMKgmMQ6ogUlpZvxKA2Wzjgg6GSglEHT4PMyFD7VORWBA1po7P?=
 =?us-ascii?Q?ijBl2u8rUMiR54SExO+pEHUj04GqyzGFBSGQo3ZvfFLk2xJLmJdyOhwDiPbG?=
 =?us-ascii?Q?l+afKZt8NOau6jhErilkDPz2NCClcB79JaY15tPGrWdb+z0Z2MHJHFCAlxWw?=
 =?us-ascii?Q?4P42sYdSf75Mz2Z/izr9i6HsSMdZ631xiMOczEAZvHvFhFlR1fh8j9TSP88c?=
 =?us-ascii?Q?096MvVVBwqriIiokZzUNK5VbRezjLf8GGP3Qvao17CJVVP7q+yRMi9Zsrj4t?=
 =?us-ascii?Q?7HTwKNjkxSNjhiaCKVZ4HHqMQCUkTrEYumMSPRVwmDHUVqCjn4KuopN642x1?=
 =?us-ascii?Q?HQj/Sku0WX5g5q9oYQAcx/9s+6cYtRxZ5My72K+rP2ZLPUDY5Wj8PXW0XX1U?=
 =?us-ascii?Q?ZyMY5TbuCVVySBlnmCbbBECjA6VlSkprijhqQOElHtVYQv/forrpPxtSt5Co?=
 =?us-ascii?Q?yXgzZ1VDsUKA1GbCE5Ng5TtxWs0xsiTTBCsjPp4XFqzKUydmW9k5bwG+Qg71?=
 =?us-ascii?Q?76FaGvF6tY7HblPb8Y7xguQBmtNwZvg/z8VIfTXitBwJ8qDuSyV/TQ5lVDUM?=
 =?us-ascii?Q?TtHEqemMmGn/Qmc5cAxkd0O/8lPmte20DIIw5X4nDSoRHpEgTkuKsPTsNxFN?=
 =?us-ascii?Q?1N5i7xAANvw24xWy8sZ9f1lrX5o8cQzQETBQqYlOZfDBA56huFxCOCe2T7nr?=
 =?us-ascii?Q?qz6yAxlDycH/U+31rlqejwr1/98aQi4IbJVL6pm6hv5HF7vMjPu2550lPJOk?=
 =?us-ascii?Q?JMfSARLsslWVq3D2mDYhDx5Z2+ero8M5OkwUqTPm94mdzPIKcAGLhDK8LMtW?=
 =?us-ascii?Q?GJkFvr0Cv0Vqxbbyh3J3orRs+9Jba3VeMVbudSNGPj68Fyk7Uemx1DttIw1K?=
 =?us-ascii?Q?+g8wifQG1wk2PCqpf2W0WWHNHy+tRpszPFW69G6hFHlr3gtlW9AAbBQWxOaM?=
 =?us-ascii?Q?urzXTHTjnNefHz0pDYqaztMecyu/rutITbI8WQzH8xzD0ubr0qIC6HyG/28E?=
 =?us-ascii?Q?TRWE4X4kX3qtGuDfM8EeOukN6oCU7rtAvhNy/0N5r8ein1E2tBdKVCZHSn06?=
 =?us-ascii?Q?Fwj59JeLIz29FWEXQnPTEbHW9lZ7pj1rqstZGz+Eu0UMyjTgLambwH3CvO9K?=
 =?us-ascii?Q?wtY+quOf3V4N4/pDrCcsosN+Npv2wlsyu6D5eGlp6LMJxodG15YKb1GfPVxY?=
 =?us-ascii?Q?xS67aRJfjA3A3FV6KvsuZ/BmqVsBAhoHB5CkUgYhdNsSLJpfq+J48aidOVgG?=
 =?us-ascii?Q?j7dtoYsAU2dZbaPbeMRu6KJPQEM4LlTtcKuVvlxhH1eJFHrulN1Vvk7ZFpIp?=
 =?us-ascii?Q?poFlMX3bb2uewP0GnVY=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b6a2e76-dfb7-4db3-c980-08dddad975ef
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2025 02:22:47.7784
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rr6OktIr5rG8cOnxl6e6Ln+DL28gYTiIhcV+huP8VLobGD2OQSVDkFsZXSAdWdflx3qZ3A57Xw6f63/jjR4C9g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9879

> On Wed, Aug 13, 2025 at 01:59:01AM +0000, Wei Fang wrote:
> > > On Tue, Aug 12, 2025 at 05:46:24PM +0800, Wei Fang wrote:
> > > > The NETC Timer is capable of generating a PPS interrupt to the host=
. To
> > > > support this feature, a 64-bit alarm time (which is a integral seco=
nd
> > > > of PHC in the future) is set to TMR_ALARM, and the period is set to
> > > > TMR_FIPER. The alarm time is compared to the current time on each
> update,
> > > > then the alarm trigger is used as an indication to the TMR_FIPER st=
arts
> > > > down counting. After the period has passed, the PPS event is genera=
ted.
> > > >
> > > > According to the NETC block guide, the Timer has three FIPERs, any =
of
> > > > which can be used to generate the PPS events, but in the current
> > > > implementation, we only need one of them to implement the PPS featu=
re,
> > > > so FIPER 0 is used as the default PPS generator. Also, the Timer ha=
s
> > > > 2 ALARMs, currently, ALARM 0 is used as the default time comparator=
.
> > > >
> > > > However, if there is a time drift when PPS is enabled, the PPS even=
t will
> > > > not be generated at an integral second of PHC. The suggested steps =
from
> > > > IP team if time drift happens:
> > >
> > > according to patch, "drift" means timer adjust period?
> >
> > No only adjust period, but also including adjust time.
>=20
> I think 'adjust period and time' is more accurate then drift.  drift alwa=
ys
> happen. The problem should happen only at adjust.
>=20
> >
> > > netc_timer_adjust_period()
> > >
> > > generally, netc_timer_adjust_period() happen 4 times every second, do=
es
> > > disable/re-enable impact pps accurate?
> >
> > PPS needs to be re-enabled only when the integer part of the period cha=
nges.
> > In this case, re-enabling PPS will result in a loss of PPS signal for 1=
 ~ 2 seconds.
> > In most cases, only the fractional part of the period is adjusted, so t=
here is no
> > need to re-enable PPS.
>=20
> Lost 1-2 second should be okay when adjust time, which only happen at
> beginning of sync.
>=20
> Does software enable/disable impact PPS accurate? For example:
>=20
> suppose PPS plus at 10000ns position.
>=20
> enable/disable software take 112ns, does PPS plus at 10112ns Or still at
> 10000ns position.
>=20

The purpose is to make the PPS signal always be generated at an integral
second of PHC. Below are the results without and with PPS re-enabled
when adjusting the integer part of the period.

Without PPS re-enabled:

#before adjustment
event index 0 at 39.000000017
event index 0 at 40.000000017

#adjust period
./testptp -d /dev/ptp0 -f -1000000

#after adjustment, the generation time of the PPS signal gradually drifts,
and the deviation from the integer second becomes larger and larger.
event index 0 at 41.000000017
event index 0 at 42.000000017
[...]
event index 0 at 128.999999931
event index 0 at 129.999999928

With PPS re-enabled:

#before adjustment
event index 0 at 86.000000017
event index 0 at 87.000000017

./testptp -d /dev/ptp0 -f -1000000

#after adjustment, a PPS signal will be lost at 88 second, but the generati=
on
time of the PPS signal does not drift.
event index 0 at 89.000000017
event index 0 at 90.000000017
[...]
event index 0 at 161.000000017
event index 0 at 162.000000017



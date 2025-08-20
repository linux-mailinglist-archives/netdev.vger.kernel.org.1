Return-Path: <netdev+bounces-215109-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4829CB2D211
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 04:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C672B1BC24B7
	for <lists+netdev@lfdr.de>; Wed, 20 Aug 2025 02:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BB3F22B5A3;
	Wed, 20 Aug 2025 02:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="H3V4Tmmy"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013053.outbound.protection.outlook.com [40.107.159.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D01681FC0F3;
	Wed, 20 Aug 2025 02:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755658090; cv=fail; b=BYrGL/8xoncEWz8Sy72W9DcIhGu+uIte08nWpzNR/GsbVeatPjHkzf3XqEPBxTeyvCGA179t05eub+PWRk1uBNeq6EN2AD1KPtA+7xZ/YBbqPaqEZbMGgQro5yZImdGXeqJRDA9M75bbgP4mhdUajs4Rei/bjEGdiJUwUnUkeiU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755658090; c=relaxed/simple;
	bh=SdpPrF8HcqaOanwRv8/Wr/PQzJDrI2aDvrvrgHE4kYQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bHGj/oKYAzsJnjOGi4tQOajQo63TCANPa6Y59EQZzXTrtREE3Wh4J4UzCgXP4X8yMtNdkCPrx3l90seKmEVNQylmuLHGvppdCTlAknJkSD0R7EejPKINK9yQdKTqnHhRxJdDZBenBpDJ7Y9hMm51wK5LDSDl1IWCf5gZLt1zApY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=H3V4Tmmy; arc=fail smtp.client-ip=40.107.159.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h6LUfkRs6Klai8Al9h8X0dcTNNCevQ56GHbJinBoZ4huXnkc2ZiIk6Qe5JjcqItIsIkD5RYWymQSUThsy2KvJ0xhtuHJyNgDBJo1J+S702fkz5B0HeTSLsHlSuoHXyetkJjzMek0yg68Yy808W6dXP8Z52BuSFQQxDrLAtkm97Svb0dWoYVS/PhUivuv39Jxk0IP78D86W84BowvHQLwgud47/68uk+myuoIb245UIbnTlZdHBCavFa+1Lpxr8W2ZhBwK/twwV8CuFJ88AmiczC6OnnWh92t+PuHAwBwXoOdX3c72TkN4wWYVXEwPzhzvixMcUT3+LDw9aJpbrd0DA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5TYesFGJgOLZKyyOqI6f6aCWsU5Rdz70YsU7zy42s6w=;
 b=iHr2XzGgUmRPAvVZ3otdee/E/MN4ll6BwbnRSBaO62rLr4Js2MvK6ganErrfmwTQwpOcuVkRp5RTJGdh+uNdJSh2dRqU1UrB7L9ZoTlPdytpMJkFllVa8sVZVQHEDSbz+8Mz10g7vo1sl10hAu5qkhakwERhBUM93MXeaON/HK6xul4YdklTI7DQPd9mEAdF2wlPW7gZMumjc8n39PU81XXtCbA62/5WvFY+jX1FVml/WWOL9LTDbcX3yMi8HtBaQ21tZjbI+KsrG0sQ3iqf+LO/Bpw8Y3eI4aqFeWFnzAWhBA7Uxq6fvKKyUulKE9NLmFR+/K+ngBjQbEOJvkA7cQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5TYesFGJgOLZKyyOqI6f6aCWsU5Rdz70YsU7zy42s6w=;
 b=H3V4Tmmy57HScaoERI/qR20Prb9wL/PsjQrAOpUMHRRV3kptLxZkLoprtco0pP0fLbPrIGJb4T1vNkEmQGNkjrmy4dwNhPlA2gTyawo8ZZrFVN+Lv+ZHh+K1hZ9E/V7qLM91j3ZJCDUzLBPMpm7WKJ7hmnnK/FtNLHz5xMAuz2QuSXIkR48dow9Z7lGSbgTtWm8X5H2ELMtNN7RMQKDhihucH0hFhqkjXGV3Y2+Vbp1HvpdpATAJ2Jr2xsj7OYiQ5TV40n808uOr6H44vCIctHON7XPi7Uw8I/F5UURHcgzvQknQbrQ6z1oWtOFi8XMrEp7olL3Po8f/vAmZe9/0Rg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB8684.eurprd04.prod.outlook.com (2603:10a6:20b:43f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.13; Wed, 20 Aug
 2025 02:48:05 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Wed, 20 Aug 2025
 02:48:05 +0000
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
Subject: RE: [PATCH v4 net-next 04/15] ptp: netc: add NETC V4 Timer PTP driver
 support
Thread-Topic: [PATCH v4 net-next 04/15] ptp: netc: add NETC V4 Timer PTP
 driver support
Thread-Index: AQHcEQj5CQ+mJcoNQkmqvF9R3wJl/7RqFc0AgAC9VpA=
Date: Wed, 20 Aug 2025 02:48:04 +0000
Message-ID:
 <PAXPR04MB8510620E3278283321983FD08833A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250819123620.916637-1-wei.fang@nxp.com>
 <20250819123620.916637-5-wei.fang@nxp.com>
 <aKSUzDpO9Yh58XoC@lizhi-Precision-Tower-5810>
In-Reply-To: <aKSUzDpO9Yh58XoC@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB8684:EE_
x-ms-office365-filtering-correlation-id: 02721ba7-992a-4b11-f4c1-08dddf93fcc5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mMtNsWJ79/Xu/pC7JeQV729UTIb9AS/zP7jRHtRv+PONiYHFAZ2p1Tsq+Vfo?=
 =?us-ascii?Q?RADyUl0a/933iRS5kjCdepOpil9F2hOI1VZ9piettA9L6XH1L0s0vsOsuEXC?=
 =?us-ascii?Q?Vs7++F7muLszMHIy49GgE5am1cDMsWXmWKz/6mi5XrNh1l8SflBNBjY73M9C?=
 =?us-ascii?Q?bouVcaWxM82X8EE1MauBwqibLhy+0AbsUR7znFnii7eqCAsWw4XHtE6Ybrc2?=
 =?us-ascii?Q?j6OhkqxqCOtVv/emBpLULe1iH06u+vfIhTbUonjFCLzixPMLwPk1zkGWq0GP?=
 =?us-ascii?Q?I3J17u8v5E1OaRxWb1U+NcK7IpdkeIGh/0XBUK5PpLi3lGzEm98jIHhk3qPD?=
 =?us-ascii?Q?7rKx0FzTQyaoQtp0Y4EzaXlVxz9gTjUCiei/+Y5/EvHY/dB91S1GRtZAmTTv?=
 =?us-ascii?Q?ZZExHp3Po9KI+ReVlF1w0XOlgcSKGN/QkLe0kNEKFWhN8jAZt4nRlHtvNRCA?=
 =?us-ascii?Q?yvrKNNKvna3lIVYNbwF/JJuoQXaB9BQ0jN4TQ84nqCers8fWepKFv0omEO+t?=
 =?us-ascii?Q?yJZJ8+q+yAkgyWq6a9Stq3V0zwhjjMqCx7bqVQnBrg5ytRBI+vtJK2H9pMbp?=
 =?us-ascii?Q?d6ObCVmVX/u7Oh8OIjpTZHGE0KmxBtxmkI1sT6kh67KsU5UI9VWEsWloMIvo?=
 =?us-ascii?Q?PS2jD/mCt3PUX0binO6OpO5QfBSws71eBGAoIoHKx/DPmuAia7gcVBP4SGAU?=
 =?us-ascii?Q?caj2drJVgcGL3XZJiPC5zuB4zAkAI55irG8x6Q5jF+kp9twJePvAr6hIukqy?=
 =?us-ascii?Q?a5Wr9g8ERHMdXclrUCUtogszivrJQdglE+DwXE1SaUwo2y8w133GgjWeCXVH?=
 =?us-ascii?Q?Kk5LFDzvQcwo+dxegvTYAqdYGC8TyN8vhuiMAtbEByKwDp5iqI4T0nJgaAqf?=
 =?us-ascii?Q?fsEjTEIondGqKkBFBP7dAzOYkwY3PSVQQbk55psHYpfb6asiti2bAeYRqjSj?=
 =?us-ascii?Q?88doza1WqXK6BrnvmzefF7Y8OfNfS90Vi2KhFZlLrZCVdFuP1XwwrQvdVxMv?=
 =?us-ascii?Q?YvXql090K2QrVZO4uUxxnN60iOv1ZUO/BEyBvYvINHilE5SITvIEB/NPR6NU?=
 =?us-ascii?Q?zN8YOQgDyekWoQuv4/y9xgFSomLCbJGNwes0rNGiXN/MgQYMNMrpoFTDOLSc?=
 =?us-ascii?Q?OhcHlydbZzfirK5k6Za1KQyZvh1/JWzzYXaF9Dw7Uc/ZosfGHodqhmlmZ325?=
 =?us-ascii?Q?HpgGaC3mx5nBcLT6kC1SE1xHeekPc2UegyDjQtuhGEeG9QOjyo/jdOhnL8ln?=
 =?us-ascii?Q?bZpHkhBM3cN22NuiOx3loVP1AUBMlQXWuVxnaLVFW4M5hN8osk9ZWeCnwoaY?=
 =?us-ascii?Q?JU7DNvKS1/t4AtpkR34ISwQ9OTemSZ2/TQ20DdhhveorezRYO7NITtAOUB0K?=
 =?us-ascii?Q?448ShHjfU1f7QyuHPg0yxhjc1zxq8QTU6hEsNpT1jB8b5qtXzPz/o086QipU?=
 =?us-ascii?Q?Q7kF4aWlk5+kfl/t8x3/EMfplF0+CrGK9fiDJIv5W4TJiWNj+v1WQg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hAegR8QaoINTxx+z8oBdN23kKY2NvyODscRHb4FxaQ6HJdK1oey+1X0i/myZ?=
 =?us-ascii?Q?xHVJAkJOrQSkR/IlMM2JO136BPjVy+F+zSBeEZXnWjVr7QL9ASqC8XDGSphc?=
 =?us-ascii?Q?zu3xSJczkGKprLClsdrpqffIcuv3sMBVsbCFD1AA71rlDrf0XB1VoHetZzGa?=
 =?us-ascii?Q?dLzfQuriPz8dDG/DqUv8ztCcGfH/wsHGWj/RL1pK50OLEGrVSS+zc4nGIZkV?=
 =?us-ascii?Q?f+6Gd8q3jfrqUs2l4JtkBMynCEbv86tKgWGXn5mrk+TeHyPPgUSUxc33VfUQ?=
 =?us-ascii?Q?lDFeXRpdthbe+dV4KnYgvJgvs9uUlLNn9WKwBJz+5YQUxc1Uj0txtMlb0twb?=
 =?us-ascii?Q?2qUMcsGPdUN5zhA/LSmvcamXq/rhkBe68SX1NhEgGu17kwwmxXnv3nMwKYM3?=
 =?us-ascii?Q?Uzg6A31vDnD/Ki/N5Ymw7HS9rAcMl2DTLUpge5CzRqwLVMVO4QSBwjnEIWQP?=
 =?us-ascii?Q?a7M12DvPGZOhTfREPz+O3NZ3ZxMw6q1HyLoG/TzUfHARrheO5mTQ9o5Y9MLW?=
 =?us-ascii?Q?ky/qJUIqNy4Sp089+WLVj3cmKo6DcePlRPuawbqbV9EAB13jB4Zvk1/CGq+7?=
 =?us-ascii?Q?3nEHauUULIMdbzP5R+8+c/eXw9HLOnLU69Mdus9Oi+HRtzp+foS/mtWStwEm?=
 =?us-ascii?Q?+sZkYW4oXHRNvri+ra68EkvQ0WxitaHtEsfdwMP2Gyh1op3NEESCpwzY595y?=
 =?us-ascii?Q?JvBQ6Vm3zHdyXfVq0eHroB4eJUR3C8OSie2P8UP39pXK9bZN3tBxnvsmbSur?=
 =?us-ascii?Q?NJSEE2z/xRl1X71Tbm+ha6DZroFpilNvovDcOQH89K3E2Ofipm08+OV8mCnt?=
 =?us-ascii?Q?CQVg9WY6Hezm9Vl834Yq+avfXfDMutD1htkCPH5bph4ejK5HU70/h1eXbmjk?=
 =?us-ascii?Q?C/FKA7lWiY8FotaDf8fY6jzNqbte7qy6kL4R9gzupI8VTfVz4gJR7iQucDRh?=
 =?us-ascii?Q?e85DulfewptQ/NGHo9eh3z1rNQ6rVVCUM3q4m8B3fl7uCUq7jAgEXHFFU0Qx?=
 =?us-ascii?Q?z6XXXXznrkhD/AIpv9UJG6gPqcCmucakuqD+o4X8nR4lfWNyTBIYIthMiF8y?=
 =?us-ascii?Q?37dYMROQaOq7SaAOTUWlrhHa38xN3HqGQ/TIRJlfLednpCyixUkSBdmk0NPE?=
 =?us-ascii?Q?OeYXtkKtEibXK6dlLNCnVgocXJEpfX+v4oKg/zYVukiuFkxUYDcXzyBtYM7r?=
 =?us-ascii?Q?l6cjaOcdJ1TgapIXd8oIcaTbFMvYsm/c1zx5wfoe7MFxaKf5/b06MbBX1LtZ?=
 =?us-ascii?Q?80EjzKE+XW/nm1HpPLrkhTQ9GWnwqdsQb9mlhcN2d643exxrzYC+CVPxXAPn?=
 =?us-ascii?Q?8t+lZ2G4RAq576aNF7FTn6U1ItOw5pQRmdmDkDsXHIP991qlRV7Z+OPgeo4L?=
 =?us-ascii?Q?F5fZMGgvCpRQ0pBcdrLHSNDgp8PfRhdAThx3qiNdEbPBvnAWDYGU9EBEIuGl?=
 =?us-ascii?Q?0RGQbjQIigXaTGxa0/DT4x3pO4x4pSyy7z/VV6RVuYrfpjZcYMl+9GS6N2T7?=
 =?us-ascii?Q?SJDtI20mXN7urYSr9Qp4V6pjVEMJbyrxgB0mYpkIQ+HYkFy2AW6LmAGCw2CA?=
 =?us-ascii?Q?InhGJYpA2pJOHXN2rdM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 02721ba7-992a-4b11-f4c1-08dddf93fcc5
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2025 02:48:04.9862
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: rP8KXN4MTY7MMhno7wsDRni8B1Iy5ISFR61AKtm7GvaTsuDJbXA759EfpedmeppVtaiEM/IK1YoxLBD7krVIeA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8684

> > ---
> what's change in v4?

Sorry, I should put the latest changes first.

>=20
> > v2 changes:
> > 1. Rename netc_timer_get_source_clk() to
> >    netc_timer_get_reference_clk_source() and refactor it 2. Remove the
> > scaled_ppm check in netc_timer_adjfine() 3. Add a comment in
> > netc_timer_cur_time_read() 4. Add linux/bitfield.h to fix the build
> > errors
> > v3 changes:
> > 1. Refactor netc_timer_adjtime() and remove netc_timer_cnt_read() 2.
> > Remove the check of dma_set_mask_and_coherent() 3. Use devm_kzalloc()
> > and pci_ioremap_bar() 4. Move alarm related logic including irq
> > handler to the next patch 5. Improve the commit message 6. Refactor
> > netc_timer_get_reference_clk_source() and remove
> >    clk_prepare_enable()
> > 7. Use FIELD_PREP() helper
> > 8. Rename PTP_1588_CLOCK_NETC to PTP_NETC_V4_TIMER and improve the
> >    help text.
> > 9. Refine netc_timer_adjtime(), change tmr_off to s64 type as we
> >    confirmed TMR_OFF is a signed register.
> > v4 changes:
> > 1. Remove NETC_TMR_PCI_DEVID
> > 2. Fix build warning: "NSEC_PER_SEC << 32" --> "(u64)NSEC_PER_SEC << 32=
"
> > 3. Remove netc_timer_get_phc_index()
> > 4. Remove phc_index from struct netc_timer 5. Change PTP_NETC_V4_TIMER
> > from bool to tristate 6. Move devm_kzalloc() at the begining of
> > netc_timer_pci_probe() 7. Remove the err log when
> > netc_timer_parse_dt() returns error, instead,
> >    add the err log to netc_timer_get_reference_clk_source()
> > ---

> > +static void netc_timer_cnt_write(struct netc_timer *priv, u64 ns) {
> > +	u32 tmr_cnt_h =3D upper_32_bits(ns);
> > +	u32 tmr_cnt_l =3D lower_32_bits(ns);
> > +
> > +	/* Writes to the TMR_CNT_L register copies the written value
> > +	 * into the shadow TMR_CNT_L register. Writes to the TMR_CNT_H
> > +	 * register copies the values written into the shadow TMR_CNT_H
> > +	 * register. Contents of the shadow registers are copied into
> > +	 * the TMR_CNT_L and TMR_CNT_H registers following a write into
> > +	 * the TMR_CNT_H register. So the user must writes to TMR_CNT_L
> > +	 * register first.
>=20
> You have not answer my question, does other _L _H have the same behavior,=
 like
> below OFF_L and OFF_H?
>=20

Sorry, I missed the question in v3.
The answer should be 'yes', TMR_ALARM_L/H also has the same behavior.
Regarding to TMROFF_L/H, this behavior is not explicitly stated in the bloc=
k
guide, but the behavior of registers of the same type should be consistent
within the same IP. I looked at the driver of the QorIQ platform, which use=
s
the same IP (but different version), it also writes TMROFF_L first, and the=
n
writes TMROFF_H.

I will add this to comment, thanks.

> > +	 */
> > +	netc_timer_wr(priv, NETC_TMR_CNT_L, tmr_cnt_l);
> > +	netc_timer_wr(priv, NETC_TMR_CNT_H, tmr_cnt_h); }
> > +
> > +static u64 netc_timer_offset_read(struct netc_timer *priv) {
> > +	u32 tmr_off_l, tmr_off_h;
> > +	u64 offset;
> > +
> > +	tmr_off_l =3D netc_timer_rd(priv, NETC_TMR_OFF_L);
> > +	tmr_off_h =3D netc_timer_rd(priv, NETC_TMR_OFF_H);
> > +	offset =3D (((u64)tmr_off_h) << 32) | tmr_off_l;
> > +
> > +	return offset;
> > +}
> > +
> > +static void netc_timer_offset_write(struct netc_timer *priv, u64
> > +offset) {
> > +	u32 tmr_off_h =3D upper_32_bits(offset);
> > +	u32 tmr_off_l =3D lower_32_bits(offset);
> > +
> > +	netc_timer_wr(priv, NETC_TMR_OFF_L, tmr_off_l);
> > +	netc_timer_wr(priv, NETC_TMR_OFF_H, tmr_off_h); }
> > +
> > +static u64 netc_timer_cur_time_read(struct netc_timer *priv) {
> > +	u32 time_h, time_l;
> > +	u64 ns;
> > +
> > +	/* The user should read NETC_TMR_CUR_TIME_L first to
> > +	 * get correct current time.
> > +	 */
> > +	time_l =3D netc_timer_rd(priv, NETC_TMR_CUR_TIME_L);
> > +	time_h =3D netc_timer_rd(priv, NETC_TMR_CUR_TIME_H);
> > +	ns =3D (u64)time_h << 32 | time_l;
> > +
> > +	return ns;
> > +}



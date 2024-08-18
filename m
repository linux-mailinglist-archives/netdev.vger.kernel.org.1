Return-Path: <netdev+bounces-119502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 378BE955EC2
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 21:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65405B20C6E
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 19:39:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 218C9145B25;
	Sun, 18 Aug 2024 19:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="mZsSTb+Q"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D86C12581;
	Sun, 18 Aug 2024 19:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724009994; cv=fail; b=pBoi1jnB2h3xeXlVzKQjEyzci/WwSUwyS5HFZnNFaNMWKrjSNSglLZ9VnM/mHX84nafPSSzG8py65IS9WSbDmvxNmM2sfizZoYfW3wtZnGnyhIj19nZovuNCDJjJouXnLuT3rNKL6q6sXlVngVWNzj5XDnpKOax0rNhIPApRuC4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724009994; c=relaxed/simple;
	bh=aRDd2wcWU1BFdE5A+AxBNcpfmHHr1NG0sQfP8u9SjSE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qszVb6+94r/MjzdYv2UTvNIzvxGVqroTK1dc6XXs8MhaM4FTzmVzD7kg/1XSqgeHDFF2axEyPlYRdbk2z7W4K8N5FLX/hj169i4gRHfKJ7RYjw5CrSrgl7IjjBcBTwzFpw57GsT5W0n4Qy/e1+1mzvQmsNDdst5/t+FzYo0I/vc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=mZsSTb+Q; arc=fail smtp.client-ip=40.107.22.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pfYNKd++kkI5UstoLAlyYQsRi0zUYJslVIRIT3HQSpH6JOJv9GcDCUEF2TjDcuFGcD4ARfgbzFLmdptitq8H5vDsVz0hwvczbgoGWU7uiYT6xTgC1IKqnudjR0Vdv9MWvjcrwfwn9XU/cncqpiiWU0cfMr4yzj6yc5LqiYous3wKU3+X20gVyWaC1dG3NqdWSIM6oN052lUoK/8i8p5N3ny7GvFvohYH5a5Jnu0ctUQw40J9dSd3qlklpoujsEEN8FWll/C1AIwatGQe2n69M2gBXK9tBM309Cr5wvF1C0UfFshTLYqY6meYyVLOIl+I68sfSqD9MPqjz/qHajP9gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ywb5xzVWTifrNoaCYSMWUm0eTnwsmMJIABbLOukyAYg=;
 b=GUtvvYEi+Pd/xX4+/NsSZjrrMV9WqdNxkRrAMzS3vsSldFXtgBLlaTDnJx0EFpfDWOI7mjSWoKGrs2AGsZ0ClUl0/tgyDUhkoFpImDyyJdxQtAYYDgsVX5rPcC7Fs0PPqVuXN8ffyxI4rSUTXDnl/ViORKde+U2wVkzgadBCGv+MsyZmhBSuiDIH6hxmvu7okko+E3rx7p2v7JJrkN9TsqdCoagGETn2JA2TEZSVaMAmaCxXrGocb89IlFbPNi+DImsDe8r2YuuOXc0ZNU0fjdO/eoNycEHbzz2ap7DeyxaNdyBR4wAvIie702JK9n8skL850jeCWR7WA+IVeUksrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ywb5xzVWTifrNoaCYSMWUm0eTnwsmMJIABbLOukyAYg=;
 b=mZsSTb+Q9pxBmBY8uRb7/wBYts4mCo+qcFO70Q2EtfZ7YbnirYwLh51CHBSkf6SCEJJjd/54S4/s16zl0yDxlk7uSqjQzjD61t2s3tZLxHYf8s2qDRrBP7NSeMdKRgkOkxIJrxsb2e3UOEq3fUyjoF0U87/5DZH6oWvzCt6mZOE4eR/Mp7KDOpnXXt4kBGsgO3jvIEV+68U0SHsFE5zxRU4uMk6UUxVG1hLiNJ7wI0CQjGnzoSk1NjjAUeVUbqXMnJJ3QCfQaf1hSzKrOhWZGhFrvixKKMoljSdFoMogt7uZpQiRFzMXWdr/Z3jVzaIvlU9kmILJfFzqLsZ5SxsTng==
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Sun, 18 Aug
 2024 19:39:48 +0000
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27]) by AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27%4]) with mapi id 15.20.7875.019; Sun, 18 Aug 2024
 19:39:48 +0000
From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
To: Simon Horman <horms@kernel.org>, "Jan Petrous (OSS)"
	<jan.petrous@oss.nxp.com>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, dl-S32 <S32@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH 4/6] net: stmmac: dwmac-s32cc: add basic NXP S32G/S32R
 glue
Thread-Topic: [PATCH 4/6] net: stmmac: dwmac-s32cc: add basic NXP S32G/S32R
 glue
Thread-Index: AQHa8aZi9HArParP3UqJVAUyqq23oQ==
Date: Sun, 18 Aug 2024 19:39:48 +0000
Message-ID:
 <AM9PR04MB850673CFC7542E1569A34FD5E2832@AM9PR04MB8506.eurprd04.prod.outlook.com>
References:
 <AM9PR04MB85064D7EDF618DB5C34FB83BE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <20240805170002.GM2636630@kernel.org>
In-Reply-To: <20240805170002.GM2636630@kernel.org>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8506:EE_|AM7PR04MB7142:EE_
x-ms-office365-filtering-correlation-id: 43e3a833-1763-4846-f852-08dcbfbd857b
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0oAW1uJnQ6UQjm7NflDUXt2uspYO4SfFHq25XxURiZFAjGkUxO3zi9r+dWVT?=
 =?us-ascii?Q?TPHn1wFFVMHCQqNruwPdc9o+eVAkICIPV7Vaao3YHPUxTUB01hmfGoanL4im?=
 =?us-ascii?Q?E28vV4X/YMp2KbVyxC2sVs0p4N8Kz+KZVKJBqR/3l+LH+SH4KAWTwA8h0tu+?=
 =?us-ascii?Q?Dn9Pyb/D0L0NlX8o+gIBlx3Eq6xcG3rwMXiExcuvP0LrQHmqjGSqaNIVbbUu?=
 =?us-ascii?Q?6a0PMHEMUGZBRnU5D9kO2MjfkgXczLRAOyCcudfygiAsbOx4uciQqTbsfjED?=
 =?us-ascii?Q?lzbZkuqaA3389aOY6n1lV7WFZHrGtelFT5/evYHCsIP8eT1fvLF3ByrGR2ze?=
 =?us-ascii?Q?f+UmtO2hICImQD121BSN1+WcL0MFBDO0Zz97C0W2F83aj4XzEwzykl2+S65s?=
 =?us-ascii?Q?AaIwn6WZ7B+9rdSSdMdQOwdOaa2r6lfrj2TaX2PTNBYa+BrMtM/CtaQFgu/b?=
 =?us-ascii?Q?cwE21ebxP7/FvRSj9GAbDmWFkwWdy0ho7RkL6nk+5xD/xCnuhO9Rf+P1QYyn?=
 =?us-ascii?Q?R2Oa410hOeDYJWOvEO9pu47/akdm2jaN/r6UBqdyUPHfYpd13/RPFxBd10G2?=
 =?us-ascii?Q?lNtgITizbzq41XIu4WLLaPXKRqKkYFf6ZmoodyZCCRP7GDG25aBTfi6phMEY?=
 =?us-ascii?Q?G9aLhmSUfwfsNpuXuR1wHWiIhpS0aWKoN96VaJhiKzmEsAFxiS6jROiMsedx?=
 =?us-ascii?Q?c4W+dasnOkTcLgrKl9Pn7Np3oRUWSKlAyvn7LqaR2JDrF7zLK+NeiTu15V1t?=
 =?us-ascii?Q?U/nCicU7whn+Zm1BpBki901yK7j8XCOTa9VbJho0K4oZxkNXbO3tZASVnIXr?=
 =?us-ascii?Q?DiLntpDWO0RLHQOXo5JQHVjoUN6+Lix0JZ0ik/7XPv6QI2ed4TwVeaatdZIO?=
 =?us-ascii?Q?nhIy3Dm5IBPRVPgcfjhGfSxEzG6W9u5V8YdiNwbKUnMBZc8golbJbWeF6AjL?=
 =?us-ascii?Q?uX8xf/JHUxOTQndDhzGXCZ3+012Rh0ZWyi7KV/QyfLC7fXWcyY9lCFy4K8za?=
 =?us-ascii?Q?NyIc73NpbJzk5wtdNRrPyOS39v+rqjzM68JI1XjNZLVlr+Rj30xnh78F5sOz?=
 =?us-ascii?Q?gaTWrK6nsW1tS38d9CkkHXCb3yhFLbMz92e7P5hxZMOH/VQmAQlocwz4xOax?=
 =?us-ascii?Q?skwsJCtl5cjuylO8rT1T0qZyzjSBuVCMHDN4ZDt6MtDJHZpKkA7b1YUBVfWC?=
 =?us-ascii?Q?bxJlhV68CHl6XDqLejqyozPEJwnHH98KGBoqpiNMSbqOJpD/dmPSLHTD5thZ?=
 =?us-ascii?Q?Q58gkn6zjpCZJ0aB8LGBNqgQNf5wsB1zS9rxZW2JOhNXsibJ0yyQhzVCIPNr?=
 =?us-ascii?Q?s/mmFHv7fbdxR7L13S0rP5HldHDWHwzYp0SHJ6XaNTlo+TT/B3/piIfpJPeU?=
 =?us-ascii?Q?1SbsGgs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8506.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+O+wCGFIe9XfCKKaIyTSCCNhmzVvZwd+povzK7at2saJzb7xxbq9kX3v35nw?=
 =?us-ascii?Q?QYdhds4boQ6TfEQzF02WQaYKQpasyqUQbxBAuL+dQH7GqaSKVjj5RxkhoW8w?=
 =?us-ascii?Q?yQzJOjs3CIJUcuIq0CLgImbdE0S6vCNiiXxWGJP4CWOi2mltOFhp0qqBIa2o?=
 =?us-ascii?Q?lrrE3D6VsdP4Q05xp0xe9j6VkZ+yPOxyFO4Cs4xloV3iGWM8Oe4uTuqKQIrC?=
 =?us-ascii?Q?aiI2tf+TVu0pFbRzxhPf+N8Et7ua+sVCVTbLPoZWtE3OeKoKAeEVBdvhauFw?=
 =?us-ascii?Q?CEriR7NTo3G/sLMG7SnCYGZzGcqAZiu35doqKi3VacElg37rAW5SI7BWwcZ+?=
 =?us-ascii?Q?iXsgzu91V7qcgbLKwaj9/JKhPZ2u+0uoI56zGX7WPCs6gSqY2m6r30sJkRJH?=
 =?us-ascii?Q?BSntO+iytojwho6qAaEy+bomCuyrJmWsEk7wE19qugY06PXqI1RkuTELHXQP?=
 =?us-ascii?Q?3FDbmMdYPvVSY+DfNglfYwN/CSAfq2ivJx+lI+sYTpnyOC8D0ZtCmf8ub3i2?=
 =?us-ascii?Q?MtInPXaYL0OZQic+y4H4ldZxn2S58WIAIOUG9Dq2+KnwGaI1hfe+4wpj7w/h?=
 =?us-ascii?Q?BvDFvdS458lpiaEJWjlUqD57YBhqHPli+eYbAanqcloU00phcxcP+m+RU4mx?=
 =?us-ascii?Q?+kR5wxneZDt+b6tvGOe/m6SOd18QPKVwZoYldWgbriGK8Mg0SCPqPaXStFKZ?=
 =?us-ascii?Q?DW9f+KsRL9oDfH9215yrVd02GcaaD0YCTtWYl5Xv+gpnAn10MjT7Yoo8aY3x?=
 =?us-ascii?Q?cY8rD0fLyYvHv7G6Nms2+VENADUU5OoxVQnzlYS5xD0+eP/u7dPb/HMQ6o1l?=
 =?us-ascii?Q?RBu2HjOLv/VHLbto+yHUXz/Ij8rxwyj1+3vPjyJugZ8K1ZF3KaZqMEvvTgjP?=
 =?us-ascii?Q?vV0vagRuVk4ns8vp4UFgCJzx2cyMwcBagY5mFxgkc4BYXcC7FolHt7Sc+8V1?=
 =?us-ascii?Q?Epjy0LYDIRMl5TgdxV1oWmRJDVLvwF0+IBnM8s1TzdvrI8ATkiHHGcVdx82j?=
 =?us-ascii?Q?uewP5vxiU25PnqiCcG586FTEXReQCUX37I6tZVU3OIMNB7OcKFEm8CwK1JY6?=
 =?us-ascii?Q?8nFUjs0bB5Ag2vnhqQqORKytP+yTPsoo4XNXfjgakR3JXS05sDYMxfJym+jI?=
 =?us-ascii?Q?MF8LI0fOW2V4Rf/gtV/ASGbGPlsxukh77S55wA7n0MEg5U1cnR5MH5K8nGMz?=
 =?us-ascii?Q?wCnLvotbG95I0DBDyoG2F6T5pyC22JLpkY/MD5sDjPJS8K+e8hLTlD9rKSz5?=
 =?us-ascii?Q?7kF4Dc4oJ9RzTpiCU5AEyyAvwkVUG0205Z9eVSXx0HXm14lKjqMsbxWfVFCk?=
 =?us-ascii?Q?TBkBszVlAUgYVyvvnM8VEC9mlpq/81lvlf9C8jNC+CeZ3CDDNHOuf4tQZsAI?=
 =?us-ascii?Q?1mSwxf52/huE049Aykv4N72JPrFDRh/XPSSXy/Gg4BRE2KN8yQtYzfpzj4on?=
 =?us-ascii?Q?UCNWlCc7i8iLgeszGQOXXZPi810c3TYhMjMZG8WKdtEfHFrlUaxerGBKHEFA?=
 =?us-ascii?Q?J1KsiOlZjpEljtgrt0A6f2mQMOBlLLF4lGufjmEQDQ6RtJ31FSX8feFOBN+v?=
 =?us-ascii?Q?fQCpI5i5usRZNGZF47AMdwqy8Z+E+S96/OuT4XzV?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8506.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 43e3a833-1763-4846-f852-08dcbfbd857b
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2024 19:39:48.8836
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7Em22RnX2BOrrCVXkM7mNc/m+rjof/FcMrjMXOeuVpT6eugrUKVJI4YQkgJep3WQuOn9qdrh7aXEGLddKOH5mg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Monday, 5 August, 2024 19:00
> To: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; dl-S32 <S32@nxp.com>; linux-
> kernel@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com; linux-
> arm-kernel@lists.infradead.org; Claudiu Manoil <claudiu.manoil@nxp.com>;
> netdev@vger.kernel.org
> Subject: Re: [PATCH 4/6] net: stmmac: dwmac-s32cc: add basic NXP
> S32G/S32R glue
>=20
> On Sun, Aug 04, 2024 at 08:50:10PM +0000, Jan Petrous (OSS) wrote:
> > NXP S32G2xx/S32G3xx and S32R45 are automotive grade SoCs
> > that integrate one or two Synopsys DWMAC 5.10/5.20 IPs.
> >
> > The basic driver supports only RGMII interface.
> >
> > Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
>=20
> ...
>=20
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-s32cc.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-s32cc.c
>=20
> ...
>=20
> > +static int s32cc_gmac_init(struct platform_device *pdev, void *priv)
> > +{
> > +	struct s32cc_priv_data *gmac =3D priv;
> > +	int ret;
> > +
> > +	ret =3D clk_set_rate(gmac->tx_clk, GMAC_TX_RATE_125M);
> > +	if (!ret)
> > +		ret =3D clk_prepare_enable(gmac->tx_clk);
> > +
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Can't set tx clock\n");
> > +		return ret;
> > +	}
> > +
> > +	ret =3D clk_prepare_enable(gmac->rx_clk);
> > +	if (ret)
> > +		dev_dbg(&pdev->dev, "Can't set rx, clock source is
> disabled.\n");
> > +	else
> > +		gmac->rx_clk_enabled =3D true;
> > +
> > +	ret =3D s32cc_gmac_write_phy_intf_select(gmac);
> > +	if (ret) {
> > +		dev_err(&pdev->dev, "Can't set PHY interface mode\n");
>=20
> Should operations on tx_clk and rx_clk be unwound here?
>=20
> Flagged by Smatch.

Yes, it shall be there. Added to v2.

>=20
> > +		return ret;
> > +	}
> > +
> > +	return 0;
> > +}
>=20
> ...
>=20
> > +static int s32cc_dwmac_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct plat_stmmacenet_data *plat;
> > +	struct s32cc_priv_data *gmac;
> > +	struct stmmac_resources res;
> > +	int ret;
>=20
> Please consider arranging local variables in Networking code
> in reverse xmas tree order - longest line to shortest.
>=20
> Flagged by: https://github.com/ecree-solarflare/xmastree
>=20

Done for v2.

> > +
> > +	gmac =3D devm_kzalloc(&pdev->dev, sizeof(*gmac), GFP_KERNEL);
> > +	if (!gmac)
> > +		return PTR_ERR(gmac);
>=20
> This will return 0, perhaps return -ENOMEM ?
>=20
> Flagged by Smatch.

Changed to -ENOMEM.

Thanks for review.
/Jan


Return-Path: <netdev+bounces-119501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 59371955EBE
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 21:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DCA51C209EF
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 19:35:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB41146A9B;
	Sun, 18 Aug 2024 19:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="AlcJD8P1"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2071.outbound.protection.outlook.com [40.107.22.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEFD22581;
	Sun, 18 Aug 2024 19:35:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724009740; cv=fail; b=W7thpb5lBq1nqQxIww4KldJ8/8vsAQePnVbFLNbspNK2va1CZwPgjXgzZkzJSgZtclKVrY8xW00iAdjAwP/mxEqNVke5vt0FVY6gWSR/zJ6Px42piH4N6RZJ4gTIxL8pSAwdNoOIMRXd5Wh8gJ3DMbqCnAV91W3PKx0HpZw5z10=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724009740; c=relaxed/simple;
	bh=B/mXHA77vRzyaozlhvC+1MXGIHLJSO+5GbqPkLr2Rvc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Tzv5GFhPlVtdhlpy91xJ+SGAzvewokvvbl8tyOUGKFXuCRhGmiMRXUfdGiQRXWzFqj+MKgEjwM8IbPA7cImrjD2nII3tnVueC8Kq6DX4GTX+t4nGQulbgXT8M3j2j/bHoiHWAbspCXR402xXfpszTh236vKzawYZpLYR3PU/Fi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=AlcJD8P1; arc=fail smtp.client-ip=40.107.22.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUEVlFYzELY4QtQugnnNM1pix5wtOnUBcoMB/xvrmvJ/BvbUROCC1aivf3FM/mR0a2F1+rm7TruGiA2hNGnhsB4yZZcb+CHSAcdZXXkwDj8bMf8HjOUYL14l5wbZCphNDpCUX4K7W+4j1nPj1CYDrjJpzcy842SE8/4FN2LMnhQSqKPbeXVCU65oYW9zH7IX4MCdzvd3o2IuNeyj0Bz9K5Oah4Pm2JlJo2GytsPXHUicJw3ShA9uvzyGBGDGlSxVHlqx18J4N5qqkYy/oTU/cRBaCDllEBNeCVTNTfuoMcIJ4E0+HUzfHv1+kP6P/YAb2MPuGPtqVklsX9pFJEk2Rw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BxSg/A4iRkBFwjmKoelgrzcJ8h6OQwWQHRBZBFSqitM=;
 b=wWsf/eBRJkGjUJ8fqtdWQjzacbJDHRXYQ2yST4ye2bCp6YiC0qo8rRX8GxOa55aTHl6fF+dIGWlpGskpQPEcYG9JwWS1VE43x1xwcO/9w17+IJlibK+d6zff15sj2u7cKM/4x9TO9C8AbayhUB+ehX4Zs2j7X+y9avJLnvGrkdxlNlcJqWqkf7b4SQpJiEtiIBIOioHnx4diqKDdySqsPI3KVF8qLrExo6sQy8Kds/TaZkIcZ7OCk8fQDtbNHeO95/FY5iptQQPL6bE2xhOp0/tkA6GR12R8REQvvAZFL/QmQshz50GFLxJIJPsrqVVG8k0FBXwY+8y/RrhULy7pkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BxSg/A4iRkBFwjmKoelgrzcJ8h6OQwWQHRBZBFSqitM=;
 b=AlcJD8P1oOs3JIrU8GXb5G1JEE0Lom22fTYE9kB5Axfr1LQcYHQTI+XBueDuZeMLqP2ik7ePtoO7kNMuqjdlaQfp15J/O5MCf6VOPZHhRxxJpinM1KyQa9IBud90dK2LHuEbefM+J2ddvuQylTpWhIz84ePhfsyh6Bqfy9CRxtm5/SgZ+k8Hw0HpPnpxlOAH7eY+WDQV6Cpr4qucadoCOezOHlzG1nUb+br46EL1OxKzo4lcHlJWzouVXw8kXamK7CyqwpJXq/kaRoa6fhvNAG5PwZDOd28lzujXFntND/34h2kKoxxSMqlTylINmad2k1PI+ZhG5XVFhfwcB+DlMA==
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 by AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Sun, 18 Aug
 2024 19:35:34 +0000
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27]) by AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27%4]) with mapi id 15.20.7875.019; Sun, 18 Aug 2024
 19:35:34 +0000
From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
To: Russell King <linux@armlinux.org.uk>, "Jan Petrous (OSS)"
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
Thread-Index: AQHa8aXLOKsd06Ee/UWvTVQrVCH/Qw==
Date: Sun, 18 Aug 2024 19:35:34 +0000
Message-ID:
 <AM9PR04MB8506AD31D297BD27122D89B5E2832@AM9PR04MB8506.eurprd04.prod.outlook.com>
References:
 <AM9PR04MB85064D7EDF618DB5C34FB83BE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <ZrDq8aZh4LY5Q0UY@shell.armlinux.org.uk>
In-Reply-To: <ZrDq8aZh4LY5Q0UY@shell.armlinux.org.uk>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8506:EE_|AM7PR04MB7142:EE_
x-ms-office365-filtering-correlation-id: 6a6501ad-96e1-46eb-8091-08dcbfbcedda
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2LB3+GiKnbon+pHghynuosmqY+gObuv1Lvsp1Lr+e56hFvCcBpDldCCa9MCF?=
 =?us-ascii?Q?xH+CVayWjp9X/c1+My2uesUZOCnxGrmctSwBAniRiuDX0+h/ZU0ExwVetdIQ?=
 =?us-ascii?Q?kPrIC6Nzslh7EIGX5W9mMPb0LHtGvupGWIct5HQGqsT63IaQ5LRIU0fc3Ued?=
 =?us-ascii?Q?PAAhxpsuKbkSXpm83YO4EVn0ILuBTWq3UJhtyGItHjulIpidgrOXSkAf99h5?=
 =?us-ascii?Q?t/kb1UHm7thqkpsG7fGCOYM6uEqwglnv8+UeAaa4VvsRTJj6Zx0BKbvuteUB?=
 =?us-ascii?Q?jef6Aom7Cn4LqfqKaZOJKd4gXJ7pq/VDl0v67JjyIMELdCBff27ro5SFNoFM?=
 =?us-ascii?Q?aT6/HTfuADS73MA3y6hzDmc63M1frERU4hMyH77Mx9C4w2+8HDGoBTI5/tGA?=
 =?us-ascii?Q?fGgQon0XhyPBJDrhsg3wD7d5mqjK+zhw6A7EOW7QA950fijYmgT9VfZLfsUu?=
 =?us-ascii?Q?QyLi1IJkMy8zS+dK6whYnHP4KszUS/neqgF6XFfVCz4HWVrtpxDNb9FaP7II?=
 =?us-ascii?Q?qHrxduFSCUZJlj040EkDtTCRBKI66tUd5Ma2XjAeXLWl5opzuFZoXt+vP2/k?=
 =?us-ascii?Q?UXUdmCPyfZP2seo5WumJOj6TXDz7zxdp+3bOnC6WT26HiYlj6JGlH7Syz07G?=
 =?us-ascii?Q?4qDQFMs2IqpVPgP4cfZ9/Ql8TSo2uY4AUPIr69lV6QJxSr1jE2yEKhnaUYUf?=
 =?us-ascii?Q?OeMu6iXe2bEWmH91QvgxvV/JvEvNBVKHEr9OcDtYV2wMOamH2I6Es2qEGV1Y?=
 =?us-ascii?Q?vbEt7/DDh28P3zlr/vZf/f1jQBDcpugVuTl4/VdZcYxFOOTmSDkD0taGx3FF?=
 =?us-ascii?Q?qe6AIGeOwScm6JHVOUmPGgXZR9tyrgaQckKT73dPJKo5mMbcZCeE40sHkrXW?=
 =?us-ascii?Q?oX9g7jTHflSraBQ/rFDHtOXSHI+7//GtkZkPzhp3tIgGJhx+ysp1OGTmpQ45?=
 =?us-ascii?Q?hdVgfArZx6iCOYxDXcQGHarkTswVCFYKvBoyM4BlYuMn/y5dQqL3Dc1Ln6vj?=
 =?us-ascii?Q?3TKGHWmQWFb8T07NtenTiBb76noh+rTpWXEfySeUxfKFXgT0ykyxB3BZ9ACG?=
 =?us-ascii?Q?dmZtMwLSTK90bT7cQBZ67kXAdzmWfGIYCUkynK68BBZDMIVlhh1o6KQkr0La?=
 =?us-ascii?Q?bEHjDuC7DbnDtL/sGBhVh/hh0Ft/3V3Ibg2siN18Tzqba8zQOWBu0LWtUzQl?=
 =?us-ascii?Q?KiXwBgWY1B8ogcat+lfLDrzyMkzLRGuc6AbrhVPJgMYgESUMoOB1/2a8CI/a?=
 =?us-ascii?Q?zLXxLqETQfJem0iCumCJaeRllx/EtKFeH/L+wvjkdSzVWPD/usY/il40L6mT?=
 =?us-ascii?Q?jFCquKYB8gZhv/m+9nUiP9bDjUZbC8yXGOxrl8CWbfv0g+ook9TzJ/RP37eg?=
 =?us-ascii?Q?tj1EdFHmzjuoQyl7QRrXT7IIoNVcCBVWmIBp2NbL7zyR9HA60A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8506.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?1plBDGd9J5kzrvxYUdJAfIwooSLP4zMaqEqXUKySYulEOmR1sGf2D3PEVDnd?=
 =?us-ascii?Q?ZAKj3ptaRj8b2mXY5PXvO0l8htZbu6BcsvoIOx9Hj+zGsi/GwoxecyRUyh52?=
 =?us-ascii?Q?PVXPreBtBgjZKaQZ61BFIqmM6KSYNlEZcI6U3rsZ8iCDlvAQLIBjyIkkA8jG?=
 =?us-ascii?Q?5mmuAq4WTgOMTKJMAxGbw6IraoV36PrnciCDJNNx93uztnhBIpOGncl3wkr3?=
 =?us-ascii?Q?nBocUiOwUxkb3rblebrE2GiS1OdoresjZI+0BjlzeVIsOidId236/FoMOnmk?=
 =?us-ascii?Q?qbbUUhjn3aP6i/T1zrTSvCSQ/pVKvpbrqIDLQ/ZI4pWaln5PYTW9XjJceBOC?=
 =?us-ascii?Q?WOisaB1SVsESywBOZSKD7MYrO2SI7RFMqymj/UWpUzvNymvrwmumn2GrxoHx?=
 =?us-ascii?Q?9fx4E8CjJkjEBSsXnxVVrjiyh+HGSzlovo0uxTknusbViglzxcEjSBVMYL0l?=
 =?us-ascii?Q?n52AqwdPbt4yZu3VpPHKbwbbKohj+fWZUpfLozlQaWMXXHhVzCmrUOacHXtl?=
 =?us-ascii?Q?mVbk2GZ8OdyUlAlt63yMR71J/xDG5JBFVPeW+UMzDfzFIqwnKMJBnDUBsEyr?=
 =?us-ascii?Q?9Imm45F+JjSj6AmEm61S7iYfbxhx0bmRaPQ9VnEVU1kk5SyDkKoQccy88PAs?=
 =?us-ascii?Q?c0ndlzwDfD6xcCvCDnPpQf/fJCz6SdQAcKry7R0HchvUa8Mnb7AtVBDFHrYB?=
 =?us-ascii?Q?Qg+pPSgaDgeCecJk+q6OWNI149FSbyoGu91w6Ult/SSEuzvfqh+iTFXuFfGw?=
 =?us-ascii?Q?HkW8xn3ECXiBoT9fjwvmNHXXrezE6B1bwJ6s6QQYNZu8dN1Oz4dF1vmMYrgh?=
 =?us-ascii?Q?Ek92O7HQQTXpWQVq5PvkwV7Q0g2K1CTUKFKG5D7uIEy8nl4uzN416uQ+VRxX?=
 =?us-ascii?Q?Go2ojR0sJrwNtDx0WJVvJ8GAwbYjd22d1k2krm0UF97DF15Ac8ueK6SQ/Mvo?=
 =?us-ascii?Q?omXuA/GibBchCltXnyKmwiAfXXiATuE8Z2pEETrZto18qJvLkZJ7IDVgp0Vq?=
 =?us-ascii?Q?u6KRaKSGzHxrxD2O1xhSfbatPETlrBatjOwFGmybNH4WW8HXURLZaoY9z8pn?=
 =?us-ascii?Q?xM/2AREAUnnppQ+aL/dyrg4o3jRpWTIWsz8TL/ABBzG+CZN8auAyPXTvW+/E?=
 =?us-ascii?Q?wtprtNvMttjtJ9I9k7bwFlIK2gRsCKyeKqUK/I6EuNR44hk9LIxpgmJhffNr?=
 =?us-ascii?Q?JWtNcqtzSPhfxw7xOifQvTs00QvxRD+8A2uegvSMIk1pQtcd5M6NsTCTBHRx?=
 =?us-ascii?Q?fVWv7f9fb3UVw47rz6Ez4y+4L3K8u4yxN1X8W5N2yMR733NytmsGcXWRpuII?=
 =?us-ascii?Q?hm+tri7qqbRzD+GYBhAnFJUCNzq2lm1RqnQum/APp0g6GAWpn3dUOJl0v/Tt?=
 =?us-ascii?Q?CcHTLKIYhWRGM8CE4NiRv7zD95FbKYac+TvBPmDYXHrq4f7kyDvr3fyfNY/d?=
 =?us-ascii?Q?3n0mGoF27voqY+GWQLI0g7AfBliJeT4uteMVS66X6ENw2yCe2kjFEsNilDj1?=
 =?us-ascii?Q?Azmay6xqXrUkTZRX603Q2EM9OHy8EpOtSVVrIeuk2O1F2MxhZqKKZtkw+Nu1?=
 =?us-ascii?Q?yZpYK1edv9YEqhGNU1HTUl96UTZ/YhkfZf1Zo1lb?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6a6501ad-96e1-46eb-8091-08dcbfbcedda
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2024 19:35:34.4513
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kPghhZPulmdnlmaXYfSK1q6/XRNzV3hIg5exKchvK8SDmAaATnOMsafZ0s1Cl0sFv8boKhUJuXEI70Leod/DTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7142

> -----Original Message-----
> From: Russell King <linux@armlinux.org.uk>
> Sent: Monday, 5 August, 2024 17:09
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
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > index 05cc07b8f48c..31628c363d71 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > +++ b/drivers/net/ethernet/stmicro/stmmac/Kconfig
> > @@ -153,6 +153,17 @@ config DWMAC_RZN1
> >  	  This selects the Renesas RZ/N1 SoC glue layer support for
> >  	  the stmmac device driver. This support can make use of a custom
> MII
> >  	  converter PCS device.
>=20
> There should be a blank line here.
>=20

Added to v2.=20

> > +config DWMAC_S32CC
> > +	tristate "NXP S32G/S32R GMAC support"
> > +	default ARCH_S32
> > +	depends on OF && (ARCH_S32 || COMPILE_TEST)
> ...
>=20
> > +static void s32cc_fix_mac_speed(void *priv, unsigned int speed, unsign=
ed
> int mode)
> > +{
> > +	struct s32cc_priv_data *gmac =3D priv;
> > +	int ret;
> > +
> > +	if (!gmac->rx_clk_enabled) {
> > +		ret =3D clk_prepare_enable(gmac->rx_clk);
> > +		if (ret) {
> > +			dev_err(gmac->dev, "Can't set rx clock\n");
> > +			return;
> > +		}
> > +		dev_dbg(gmac->dev, "rx clock enabled\n");
> > +		gmac->rx_clk_enabled =3D true;
> > +	}
> > +
> > +	switch (speed) {
> > +	case SPEED_1000:
> > +		dev_dbg(gmac->dev, "Set tx clock to 125M\n");
> > +		ret =3D clk_set_rate(gmac->tx_clk, GMAC_TX_RATE_125M);
> > +		break;
> > +	case SPEED_100:
> > +		dev_dbg(gmac->dev, "Set tx clock to 25M\n");
> > +		ret =3D clk_set_rate(gmac->tx_clk, GMAC_TX_RATE_25M);
> > +		break;
> > +	case SPEED_10:
> > +		dev_dbg(gmac->dev, "Set tx clock to 2.5M\n");
> > +		ret =3D clk_set_rate(gmac->tx_clk, GMAC_TX_RATE_2M5);
> > +		break;
> > +	default:
> > +		dev_err(gmac->dev, "Unsupported/Invalid speed: %d\n",
> speed);
> > +		return;
> > +	}
> > +
>=20
> We seem to have multiple cases of very similar logic in lots of stmmac
> platform drivers, and I think it's about time we said no more to this.
> So, what I think we should do is as follows:
>=20
> add the following helper - either in stmmac, or more generically
> (phylib? - in which case its name will need changing.)
>=20
> static long stmmac_get_rgmii_clock(int speed)
> {
> 	switch (speed) {
> 	case SPEED_10:
> 		return 2500000;
>=20
> 	case SPEED_100:
> 		return 25000000;
>=20
> 	case SPEED_1000:
> 		return 125000000;
>=20
> 	default:
> 		return -ENVAL;
> 	}
> }
>=20
> Then, this can become:
>=20
> 	long tx_clk_rate;
>=20
> 	...
>=20
> 	tx_clk_rate =3D stmmac_get_rgmii_clock(speed);
> 	if (tx_clk_rate < 0) {
> 		dev_err(gmac->dev, "Unsupported/Invalid speed: %d\n",
> speed);
> 		return;
> 	}
>=20
> 	ret =3D clk_set_rate(gmac->tx_clk, tx_clk_rate);
>=20

OK, added rgmi_clk(speed) helper to the linux/phy.h for general usage
In other drivers.

> > +	if (ret)
> > +		dev_err(gmac->dev, "Can't set tx clock\n");
> > +}
> > +
> > +static int s32cc_dwmac_probe(struct platform_device *pdev)
> > +{
> > +	struct device *dev =3D &pdev->dev;
> > +	struct plat_stmmacenet_data *plat;
> > +	struct s32cc_priv_data *gmac;
> > +	struct stmmac_resources res;
> > +	int ret;
> > +
> > +	gmac =3D devm_kzalloc(&pdev->dev, sizeof(*gmac), GFP_KERNEL);
> > +	if (!gmac)
> > +		return PTR_ERR(gmac);
> > +
> > +	gmac->dev =3D &pdev->dev;
> > +
> > +	ret =3D stmmac_get_platform_resources(pdev, &res);
> > +	if (ret)
> > +		return dev_err_probe(dev, ret,
> > +				     "Failed to get platform resources\n");
> > +
> > +	plat =3D devm_stmmac_probe_config_dt(pdev, res.mac);
> > +	if (IS_ERR(plat))
> > +		return dev_err_probe(dev, PTR_ERR(plat),
> > +				     "dt configuration failed\n");
> > +
> > +	/* PHY interface mode control reg */
> > +	gmac->ctrl_sts =3D devm_platform_get_and_ioremap_resource(pdev, 1,
> NULL);
> > +	if (IS_ERR_OR_NULL(gmac->ctrl_sts))
> > +		return dev_err_probe(dev, PTR_ERR(gmac->ctrl_sts),
> > +				     "S32CC config region is missing\n");
>=20
> Testing with IS_ERR() is all that's required here.

Removed _OR_NULL suffix.

Thanks.
/Jan


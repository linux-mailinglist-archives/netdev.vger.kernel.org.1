Return-Path: <netdev+bounces-213144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAABB23DCC
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 03:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34717623CC9
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 01:43:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21B061A0730;
	Wed, 13 Aug 2025 01:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="bkH297w6"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011004.outbound.protection.outlook.com [40.107.130.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8C7B249E5;
	Wed, 13 Aug 2025 01:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755049384; cv=fail; b=QSMlI9H8A2m7KGWX+XFkZVeEKz7sv2vh/aOxo0ah/oJu8CrR1JqUwhd+8gGRUWPkWBMZdIEbeBWsbAM2gq8RvyolPIEpfXBBPQitA40T6isrMkt9kSiNUgDs3IVnWdy2c/wM75l+6pxP0NlWwjMm830LEdlcDkaScUhdpSwTSek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755049384; c=relaxed/simple;
	bh=zC/PmfYPJSKsVqxhhkVawQzscAyO6ZFlI7EXGxLSiKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X7mQdXIOxkGTDKRhWFKzWz0ImOGnULNDZJfr+jyQ4Tnfo9QK4EfnBDKXu4zAdBVW98rlJ8bmzQivOu2RjKzMbgAmfOIjRhx2UJVqV8qhcmKJUeu5L4JHpXUDYXjzeQG9440RbqnImeN/kxTq7mI7TJ0efnmwXC2WxKSVQ4xPPAc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=bkH297w6; arc=fail smtp.client-ip=40.107.130.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d/gZ+/CrcBASglka52cVizSWC/nIhrD05riozkULzITipqIDn9N3RNwBcekzFvJ/8pnunqzlzFCZXvr65XqgyEYzTbl00FYZz77OI90KTplQaTWxvN61qvkikZTgVm0BqW4YSy9NXU/VirbKqX/CHd1GOuKg2MUafGsuDJFmj8uuT3beVEutp5bi7X3W11Nywi0AaV9TDCXurZ5JDGzhLZVoCtdHHz2pTVogLx1bd199GXyWoIeZlHDFhiKt1fgMZXlCp0tN8m71Q8YGlg5HnvS8jaeXCgoTy9l6zAS2cTK4Fle780p99OoeiG65iz3RrRPa+nbZekGnbckY0sJqZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9drZ54etuaPqYX0W053UzAaPZcvdHMqJWBXct4IORWM=;
 b=qoO8iFDQbEDjJ7Br+yUlY6IVrfZEUzilIrI8Fiq7ZMa2XNrq4OZDv7AppLnZ4HfgiQ9u+K9LF3mJocYip90ZgDvKInB0tIayXF7kq1xNpeMMd6oGOkDPpQ0kabA9KiF7HiuvHn7euCS+iP7OcOh3L3uOXWVNTYpkAaYN0EfzsOVfpnXrlabh1RnKgQkkWIT3BvUHaantN7sI6ss4QHPRoMAOiyRZKNF2cu8VOQCZVltGxk+9dEbyk3CGebNe8d+GASH/xXaK38cuPH6UZGHPxXqcAj85E4wmoKqrHZuF37kOdPjiPuBNoBeHrFD9kZGHdiiwfGJEORj2kNFIpy8hXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9drZ54etuaPqYX0W053UzAaPZcvdHMqJWBXct4IORWM=;
 b=bkH297w6hZm7yAv8TPMxNLufXoA6KAwJgMMpOna9li1+KVI9R4WvUPE32rdHbivdVcxesmf/vNiRkFvmZdnynaWlMDq48aWF/HrJnpS7MEODtpN/rpIZL1C3WhRPf/XYphfYcYB5VdyenNsf0Z+Xqgkpk0FGQVH0OtPwTY6d4c2IkLlipLthuXqWH+ef3zRgTrWeDpb7En1KcSgYnQ1Xz2PZ6WLpiSG1TD2AsJKrIKxwuP+06eiA8ENqntaXQsFEZezlWznMGRUwTrWgGgoN0V6XNkyBtD6xN6cjCdDUDCcl0ef6zciPnQ2f0tbemrK1C1rkl5QVmluDIs7TnGqb6g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8621.eurprd04.prod.outlook.com (2603:10a6:102:218::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.15; Wed, 13 Aug
 2025 01:42:58 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Wed, 13 Aug 2025
 01:42:58 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>, Frank Li
	<frank.li@nxp.com>, "shawnguo@kernel.org" <shawnguo@kernel.org>,
	"s.hauer@pengutronix.de" <s.hauer@pengutronix.de>, "festevam@gmail.com"
	<festevam@gmail.com>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>
Subject: RE: [PATCH v3 net-next 06/15] ptp: netc: add periodic pulse output
 support
Thread-Topic: [PATCH v3 net-next 06/15] ptp: netc: add periodic pulse output
 support
Thread-Index: AQHcC3Dwa6c+/SXDskmAIfeEvfOrWbRe632AgADjtoA=
Date: Wed, 13 Aug 2025 01:42:58 +0000
Message-ID:
 <PAXPR04MB85108318D1AEB3B4AC615D33882AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250812094634.489901-1-wei.fang@nxp.com>
 <20250812094634.489901-7-wei.fang@nxp.com>
 <20250812120359.5yceb6xcauq3jkqi@skbuf>
In-Reply-To: <20250812120359.5yceb6xcauq3jkqi@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8621:EE_
x-ms-office365-filtering-correlation-id: 2f8e54f3-9205-4cda-8689-08ddda0abb6e
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?fBCVeBW3h6O+bQyFJ+24yUaErvQrwu6RI3QkYb8yz8TBJxB/6bTEtAaVq3Av?=
 =?us-ascii?Q?vORSHgKwkoQpMPf3E5TiDocQVyoqaPsg3qz1qj1xNuO4mucrCzSPBK1iej5a?=
 =?us-ascii?Q?ai7nbuofOuulO0T+icUE31tItV4FJlP9023DWHadNkHZ05eitGNcZvQhU2Ap?=
 =?us-ascii?Q?GJ0yY/ZilbfOoYYvEUO57IZjDAMWJQg5rPlUNxkz+ekgdrA0VoKsLE8m6PL7?=
 =?us-ascii?Q?iP94m/KpO72WJX9jvdgOc02sBOm+yyOk+/DTmWSjH/WrBQvhtR8KqxlVFRtu?=
 =?us-ascii?Q?UxCdP2uFWR1cRtjVEEuyYRTgTpyP/4ebq7qLRTOhHLFa85sl5JqNb5DIBcCZ?=
 =?us-ascii?Q?up+Y4LGqrGKEzoiVpPK4i0HJgRd6EZAyWLzMFUV2Owrv8E+L5lOPFOCo1byz?=
 =?us-ascii?Q?sfq6IIIkBnicTrOd9Z3wv1fFQ7sxux3zVxfpL5x7/TFAriJ5ecPPslYg/RiA?=
 =?us-ascii?Q?Yt9xWbGDY2XDJClfvRAuxnyaKwjLSVkaVYuwU0D8cOYneRg3hiRgpiGfjJ95?=
 =?us-ascii?Q?zxRoV1y8vCc/y9tUx1Dvl3OWh8eZ3oUaturNlRF52W7WK0kFEo34LBd7a0+/?=
 =?us-ascii?Q?ky79y0rfdrXzZgXJqWIg/qeo6zppe39rUmEdMmsSB/lZVFcZps3ILGMjvMse?=
 =?us-ascii?Q?VIAR8PezcyTXjsjNXAJZSluT58pPORYkDsBxUKaPf3jDOvHo+DmR6iyuiu49?=
 =?us-ascii?Q?MQR8Z/nIbYVqDv4bbRcMyrgwSRVzz/BsCq77ba37uPx5/MuHCSagJua4pJi2?=
 =?us-ascii?Q?nGlXM5T1NTiQznkJ//pzP5aCXhWcuRDPB4c1L7tqanmXuBV6mm7zSD26kXZ8?=
 =?us-ascii?Q?G8J7W7b/1HdsUhq6xa3gLUpkLptZAVZihH2xXXEMZA+wQRnbJ378L7CCrXuZ?=
 =?us-ascii?Q?MvWsNAf0Wq51W7bKXh3fdUD5WrBlObSDR+Ull4bd4TpNM7SjsNuVPPC97/e8?=
 =?us-ascii?Q?+dMYZkLyIDGc1ZzUYCmw3CjdNpx5q8yxrQQ/8SUgSK6adSddOF4WL2KGLT5n?=
 =?us-ascii?Q?v67CU7ULI872wrGj3ABN+w5x5tSqJkcGWVdYpc+RBsruFVLm6JJeGx76WU0Q?=
 =?us-ascii?Q?Z1aQ/B5LCPhUv56B3hdYh9hUp3jFOu6YIi4ku73AaOjOJYevSIQUotwYWMg+?=
 =?us-ascii?Q?N/PLa4ZbqGAliVJ747H+vJ6/2z4hnU9AkXXGssF/5XCvJQLphDyS+iyojJ10?=
 =?us-ascii?Q?v7eNATJ2DeCn4m+gVO5/vFL5x06VzDEQLRtWczOe/eiTqx9vPY56bPCOj2Jn?=
 =?us-ascii?Q?/VwyMb+UvzP+hHPM1YZaMyq42ZYa5ShSxAkWzs0xfUidpKXfpe12FgIG2xaz?=
 =?us-ascii?Q?eyfnu8lO3NdeQmJxl5vwz/KwLPDGx+4QtJgUR0PgDmZTWH1ta+XZXkAto71z?=
 =?us-ascii?Q?ZmzpoRE/GAry4Iaq9yAbze2imeWzGvDPVnSz2bradHn8450YhuOBKtPjNh+g?=
 =?us-ascii?Q?ux6Dy9fbbYndAFyule1vgO9ktIBtwsjx08agYmAnBuxigUjCgaUKdA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EVimF9+w7PcxwMosFTHGJUJmN2qA3Mo0++Gky+E3PWO524gvvavZLvwn0xfC?=
 =?us-ascii?Q?jALzZ8mygIzneAKeBJvoju56kb3NzHrwzRF/JpwzSG29SN6NHnwrCq4gdRlA?=
 =?us-ascii?Q?hCY0sdgK+H1Bz20z2PB+qBXxx37n3vGIzrqF99d6r/bnrgyb6Sk8zD2uWp9Y?=
 =?us-ascii?Q?ZX5HWorMdJ4I2VwZjct2gugRNzv7JVGivPk05lIcCvSdFdLzJcWI7n40rc8Z?=
 =?us-ascii?Q?M9cQENhHZWEfD3kvmvAQjz8ZJTOA8aW9E4LLHJVYti+Et+LuyVPi1tA1FFcm?=
 =?us-ascii?Q?FrkwlAH5fkjoEZ3FVieia123tdeRm8W+WTHagror8PvBU8LzxHQlEVgHnB86?=
 =?us-ascii?Q?8IxONSmnTb3n/2GHFLndNOJVPZyyJV7h46lk1b7jyZ0EotOgF8tUcTMpU45W?=
 =?us-ascii?Q?km/no9/sE4OX7//P5lyRpKDvrRbT1JffU1grO9f0Fc9W4DGfTBtL5+NXYCaN?=
 =?us-ascii?Q?TtOMaG8s9J9cfKHNSgno+bmnfY1qSwcrxa9N8La3iQs4cSJEPQyPRV4wtOST?=
 =?us-ascii?Q?nd9jI23c+j+n5UvIKzBgC2fO37YLPdXdnnO/L43Lr8hmBeZGuGo8PZr+CSfQ?=
 =?us-ascii?Q?+m2y/sN1KrBmTU+ZU6QOnrzrC9SeNLUXK52MIHV1+ocLZS1jJpIo8CVWRDav?=
 =?us-ascii?Q?CHix0IMzRZ5faT2IS5Ju37wiBJLKMMl8t8NOOWHWrzsCS4A//EsyN7l2y+LG?=
 =?us-ascii?Q?P3P1cyXn4yPuPpqDPdvzgdrN6UdOgVAws41oLt3gQmxkMRRcNdpx65vUnvso?=
 =?us-ascii?Q?rO4mt0J43Ko9u6tZaxdbUlV99rhoUW9Y8bDX7y3uFBq+5t69KxG4SCwRoVDT?=
 =?us-ascii?Q?2PMdSF/t02pgUCWah2Em1xBIJRzznu7P/fxthZUsWiFO+84LjomaZnwUWahX?=
 =?us-ascii?Q?jzQDpJR6MS0rEC0RF3sZei90vMZjARqaDu7sVroF6x7QbNm6V7KYLhKUaGwY?=
 =?us-ascii?Q?yOs0otRu9Sm9V3HpRQPd9DHc6Tidouo7CydEec4O6Bmz6wToqHhxmg5AX9qV?=
 =?us-ascii?Q?0dQAYGuVnEvvVmrzC+zWu29RAFd6gfnqBtqZHk4cMXKlu+5hDlxwJoakW7BR?=
 =?us-ascii?Q?tUzU8TBL5wf+Ld2NtpLLQYBmBW0Cc7qJkSkKy3W6bP3Obi4eBXh5FTs6RUx0?=
 =?us-ascii?Q?s1HjTNhMiB6GDvE9Arn+AxX0GZHEwdfmb4wTXUtmKjfL++o5b8tNYRh6CBHJ?=
 =?us-ascii?Q?hYKqfa4TNt3Xl/0UrfBgcx7SjWNVAU5Sw9CepOhxPXGWkc4NG3efEx/ZfsrZ?=
 =?us-ascii?Q?Wa4HTCzhpP79dPVWjwYrl0EggnnDgbqOmk3RIFyccPwZk50Bv+izblDK9v/p?=
 =?us-ascii?Q?GNgGd+KZhi4uqkr0oJI6EES/HLI+H2s15z58SgCLWdJmtNWOR/+sXGJ1xg3i?=
 =?us-ascii?Q?F3op0tIhaHJ0ldhShQ3JLDLN7KF0NHjxpJ/iddjth2hlaiiFDOY+FUe+Hi/g?=
 =?us-ascii?Q?rDHC6esTgMorNkYdXWxvfoiarx9NIeQ7RG5Y+wJjhpC1hslKzSlHsF61exJm?=
 =?us-ascii?Q?3uEiaTGkJO3RrxKi3rUjDsdgCGE5kB4Ash+qwimbjLoeqOcLZrXxbDZcWoh4?=
 =?us-ascii?Q?KTrkPoysXCqdM393QEE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f8e54f3-9205-4cda-8689-08ddda0abb6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2025 01:42:58.5304
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8vKL6tP6ucT6wokUx4OGhkEWLRisYDN+3z3Y+liakapMDSXZDjDoQP4cJ8aU4v6RmZvP9qyd5874a8vYQ1NVFg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8621

> On Tue, Aug 12, 2025 at 05:46:25PM +0800, Wei Fang wrote:
> > @@ -210,77 +343,178 @@ static void netc_timer_set_pps_alarm(struct
> > netc_timer *priv, int channel,  static int netc_timer_enable_pps(struct
> netc_timer *priv,
> >  				 struct ptp_clock_request *rq, int on)  {
> > -	u32 fiper, fiper_ctrl;
> > +	struct device *dev =3D &priv->pdev->dev;
> >  	unsigned long flags;
> > +	struct netc_pp *pp;
> > +	int err =3D 0;
> >
> >  	spin_lock_irqsave(&priv->lock, flags);
> >
> > -	fiper_ctrl =3D netc_timer_rd(priv, NETC_TMR_FIPER_CTRL);
> > -
> >  	if (on) {
> 		...
> >  	} else {
> > -		if (!priv->pps_enabled)
> > +		/* pps_channel is invalid if PPS is not enabled, so no
> > +		 * processing is needed.
> > +		 */
> > +		if (priv->pps_channel >=3D NETC_TMR_FIPER_NUM)
> >  			goto unlock_spinlock;
> >
> > -		fiper =3D NETC_TMR_DEFAULT_FIPER;
> > -		priv->tmr_emask &=3D ~(TMR_TEVNET_PPEN(0) |
> > -				     TMR_TEVENT_ALMEN(0));
> > -		fiper_ctrl |=3D FIPER_CTRL_DIS(0);
> > -		priv->pps_enabled =3D false;
> > -		netc_timer_alarm_write(priv, NETC_TMR_DEFAULT_ALARM, 0);
> > +		netc_timer_disable_periodic_pulse(priv, priv->pps_channel);
> > +		priv->fs_alarm_bitmap &=3D ~BIT(pp->alarm_id);
>=20
> You dereference "pp"->alarm_id before assigning "pp" one line below.

oh, sorry, I will fix it in next version.

>=20
> > +		pp =3D &priv->pp[priv->pps_channel];
> > +		memset(pp, 0, sizeof(*pp));
> > +		priv->pps_channel =3D NETC_TMR_INVALID_CHANNEL;
> >  	}
> >
> > -	netc_timer_wr(priv, NETC_TMR_TEMASK, priv->tmr_emask);
> > -	netc_timer_wr(priv, NETC_TMR_FIPER(0), fiper);
> > -	netc_timer_wr(priv, NETC_TMR_FIPER_CTRL, fiper_ctrl);
> > +unlock_spinlock:
> > +	spin_unlock_irqrestore(&priv->lock, flags);
> > +
> > +	return err;
> > +}


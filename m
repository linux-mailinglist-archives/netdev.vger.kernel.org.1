Return-Path: <netdev+bounces-157617-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A0E7A0B045
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 08:50:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D2863A6730
	for <lists+netdev@lfdr.de>; Mon, 13 Jan 2025 07:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C0E231C87;
	Mon, 13 Jan 2025 07:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V1r+khdx"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2074.outbound.protection.outlook.com [40.107.22.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 683DA3C1F
	for <netdev@vger.kernel.org>; Mon, 13 Jan 2025 07:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736754605; cv=fail; b=qn/z9o0z7pw3zDO5alCsx2+SMbJ4BIU6oP8zx8MeV2Iqo1sg2lHeyU+kXzEK3vl3veB/gP5CM5lO56zCB2QlVRGHu6byjoEFU15uN/y9hkEHous7AHvtLZ8vmBCvE7eeMpUrBsWCj2BI+gnIkfA1bpltDqDJHaghZJ8ewpvvfTo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736754605; c=relaxed/simple;
	bh=Ebr6wMW0zXGlXWwQZV6P6l0JpjO8+nqzL6bC86JDGGE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=WEdJBBKp5ZXIOAVGS8Q+t/n+uUgSGakkLxMxAVHSC7fjxpqWvrgPN0/LJ+1wIH8Xf7o8ce3k9SJCulyWIvpdV07mgDW0qJEyemu4dePtjhZh3KGHjgMvo47g2IlYMnvhsfqiaNkfSo0fOTw8wCST3tWE3Wvd0h39iXEPrTwccig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V1r+khdx; arc=fail smtp.client-ip=40.107.22.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DaaFlXZotQIGSpbgDTiRbdD9eOwov0uBONvT04AeinTe2/VsGmQH48i6taN292OqD9baN8aRY8+Mi9QBEgDPhFct7JWtQZmoHi+RPJ/Mf42O0LfGTv3TmefrONziQvtcT6IkH2EBJTRFWOIfyQVGqR8/6Jih7B6A9MgDVwLnmgXzXNF9HXfxPhDeED0X0/wLn5rSNi8rScbEZGcJD7JBoZOEgTeQnCsKmxuJmk8MG9eXxXJHy7cdbmr24F8rcSxCAS4SH9OpYVm7JdFPSh983ZqzG0OAOJM8bKI14p+1Gd8VQYB5HRFFPL8Qu933Sz1fstkQ5fKFPZLHuF/FMp71LQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ebr6wMW0zXGlXWwQZV6P6l0JpjO8+nqzL6bC86JDGGE=;
 b=bKAH7c1wcurFtwO7HOnsg3Jb0lyvinA3lz7O1Re5upvFHxGFi9y7k6s/vmqVDDb7QjcBQaK1LoLcVCRcG3BNK/o1S6c6yl7WeKQMgESMwQXW6ji67jN/L5kuh6SfZ/T3hx4y49uiqujwog97SgzuAPpQH5xiwkBVH4heBR2itoN5GQZ4+/74Npt2zb0RvYCOvnTTDBnjfFW0hM05E1CLjgY0Ne3ZuFlxMOup12iFB452ixpTad7MtRZDoTNs+n5U4oar9d6bM2uxUrACGXedaPR/sfU91BjssgXz9E6L/9MZ9oxQ/9Pbhz0boJNdLiGt4Dc0O6fYHIzVebOMzbz8LA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ebr6wMW0zXGlXWwQZV6P6l0JpjO8+nqzL6bC86JDGGE=;
 b=V1r+khdxiu00V2SuCv5b3a40CElwOVaR0kw/EfdNz2mcKG5cnPogqmGD6BseeuFYZFNJJdIZD5nFuTHTsNywCKYsqjHNjDE05lI0j3cuyAxUwgZCsObn5dAWKskcUDn9+hUTpzLJhiDmHhikzOWppId4r5YcCcGA9Ub+YgFkRX5iuwyXcy77G43RngY/bX05HSZOIdkGgUf3fGjVJy1vvu6CIfsOdDXZ4sWORsHuiSV06QZ1ASqNDo+/9j+GxT9MdBZsU5O+PpFYPTvVLEtQ5KK0dj/XpigWxHiVFtOj7Sx9xiwbstKC7DkyjKjGx2QqXoQFpn5MTeJ4ihIdH1Mjqw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PR3PR04MB7322.eurprd04.prod.outlook.com (2603:10a6:102:8e::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8335.18; Mon, 13 Jan
 2025 07:50:01 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8335.017; Mon, 13 Jan 2025
 07:50:00 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Russell King - ARM Linux
	<linux@armlinux.org.uk>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: EEE unsupported on enetc
Thread-Topic: EEE unsupported on enetc
Thread-Index: AQHbYEAEPp0VVipOt0OTBhisL57pd7MKgsxwgAARFbCAALLmAIAA0+cAgAhD5bA=
Date: Mon, 13 Jan 2025 07:50:00 +0000
Message-ID:
 <PAXPR04MB8510882831FF8AFBF755FF45881F2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <965a1d69-d1fb-4433-b312-086ffd2a4c12@gmail.com>
 <PAXPR04MB8510A9A1597FEB4037E76DDB88112@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <PAXPR04MB8510028FA548562F1A7B7A1688112@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <99eb663b-02c5-4ddb-b1d4-743baf2cc06d@lunn.ch>
 <PAXPR04MB85106EB2145E199F8393BE6388122@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB85106EB2145E199F8393BE6388122@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PR3PR04MB7322:EE_
x-ms-office365-filtering-correlation-id: d8d06fa4-d77b-4fd6-b316-08dd33a6e225
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?aljXWmHvXobJjHJMAwf3mv922x1mJ4ZPCaePYRp5v//xjKf82P+rAnRST+Yu?=
 =?us-ascii?Q?mO/BkhRlxsONwTf3qymKTkV6Mvk/boK0w7L/S07lT7N4QfCKSK+yKw0op8QH?=
 =?us-ascii?Q?F+30dBsmmW7W3lHx/q5GCat7rwGLyvccC67ZUU3aIPCBUD+bL0ghF16fz/a8?=
 =?us-ascii?Q?/BE66GfFJWTuKJH9FntyEDRh03rYtnFknzNsrg3INffABDnObT/b1KTCOp8k?=
 =?us-ascii?Q?N0LXLQH2CC85gkvk9izmRHHvWP80Kjn5sf8LW6ZR58iBx2VZ4ERzw551QwKI?=
 =?us-ascii?Q?IFgwIiLg2kXbqRnGI9pMKsy0857779NyORPiMc9KaUZuwPTUBmh40+O8dl0A?=
 =?us-ascii?Q?+QWJOajJX7NTIvayeRmulfsOlYT23Z2IOiS1TRHcZNiF+JRRjxQoPNr3wsSx?=
 =?us-ascii?Q?AHXxpUlx2GS8G13c+zhRHD5Gba36i+I6ba9ovz/l2PlJQ+HFtUHEXd5A097t?=
 =?us-ascii?Q?t2LSO/xz3Rl9nQBkt+3hglE3epnfnyFEPBWGSBoiU8NJ7FnlooHwV7tdMK/J?=
 =?us-ascii?Q?SNCeC++Bs9zeVlgXjROPwtPgq03elng34cTVTYYJsLRAfEN0loMtLSiC90BF?=
 =?us-ascii?Q?ghTiMulaA1RoJutt7KLwcTonyYU10BPG9BdaeyFMMPthD+szLJlIJqDCDrDV?=
 =?us-ascii?Q?AS9Z7eexRXbLmm9/hhcKnwlGR0Kg34HPep6VGZXYV9DKeM8De+UXE72oAhE3?=
 =?us-ascii?Q?Ga/Y7LkATzw3+LHLFREcexyKAg8RFZBoxASm9ajzWVZN8TDLBwxOdj0WR4Dj?=
 =?us-ascii?Q?kx9BtZ3BZ1Z4+3AhgYPmrKg+vEERWRXWdQ3vnDgqtc9YPm6AiYbMEiF4vr22?=
 =?us-ascii?Q?vQo8aNCGTlHNaL4d+nuL7nJUHQaA3R96cuPlMhcfPDAkS1U6TLsw9x0Fz5rH?=
 =?us-ascii?Q?GZgWDYDqnKvQmd3QXuJr31SIy3VI65w3LNa8So6ck78Tx1oSh5G2Qob3NAHQ?=
 =?us-ascii?Q?17bWHnopet4YCuQzAdqd/8hyOk6EkX/BL0JPR6BM5/sJmgT2rajPKcjm2x6O?=
 =?us-ascii?Q?gq0cDj7UObPMJN8IMnkr2VEsxjuuX8OwjF3M/Ua4n0f6xGwCD6pnohy8PcfE?=
 =?us-ascii?Q?qi+wEHdLOtv+QB8J8qETl7Of4TKolChAyUtoOdVVg73iLTdwmDKXcSKg4QUk?=
 =?us-ascii?Q?TgNIFZcPkHgPJbLg7l9Tz3c309KwFzkwrRYnnSgr4XyPSEeaoH8n+lKaZWIV?=
 =?us-ascii?Q?ZcnNRJkfraB+ppuxwBk6lQOHWvT01fejwa/nhfDcovcqCJGLEC8vkoknqJDK?=
 =?us-ascii?Q?XAw0w7hLaQ/V1PSvsvbgDjeKpqwPA8rk8Dz2u4iyt5LJRJyJK4zdRP6lubtN?=
 =?us-ascii?Q?BKdeCkrf+qglAKT4gELUERiMRMVN9gtMvJAW173jMzWfvfIRO352u6u2ieDo?=
 =?us-ascii?Q?iQLtTW7ay6bhxzKGaSv2UADOMmwHDJ6sLc+AJ1B1PrD9et0MCFxdK8UQwlbr?=
 =?us-ascii?Q?hj++v1698gc9mWsypvVTcCHno2rJmrAW?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?fDxTKdG7LfsxYcOvCceswh5B0ay+sIOC+VAA61ILqdAw4lxHu9T1Mgc3vIh8?=
 =?us-ascii?Q?oVTmSiRCHr2i0h5hZmwX1KKCrF8AauY2lykmcbiNyUQ2i8xRDbu13FrFfNc5?=
 =?us-ascii?Q?iah2eyZ/SBHBoabf/QEt4aQxvvmpw3JX/lySa2fmlq7kQhznQflDhJFXGTx2?=
 =?us-ascii?Q?IFm1G8/tGF58eWCBCe3OsO7U+j0Ne4z7FHucRtNnYNVRMI+0w1r2AJkNdxSj?=
 =?us-ascii?Q?Q7lpLUoO3d8aHBCfZJtO2cNDuynIg+q8GRXnBidio6y8p0vtQjHkZbMFl7uI?=
 =?us-ascii?Q?b0SvE/Y9Y7MXxYXWXzvFKZ0mezmKRVMtLPtOMsTVYNNks88U6SlCmvtR7bO9?=
 =?us-ascii?Q?R39iOnnGdmEMGwMhg+goyMrtVTMd/um3WJHM9fdMk+WWiNKTIZVJe3O8rcB4?=
 =?us-ascii?Q?wjO9omPVRXU1pudskHsKO/jZNVZPhbst9qsZTIgfzwVPXIAVLk+1skNYye1w?=
 =?us-ascii?Q?i5NkW1EZl8di7BYUbzSqa2LInjxL59wZkMFx66hIWVZGjTVpPLlBDeREQ7fj?=
 =?us-ascii?Q?rClPVu2Xeli0T8hMaFB5SVZwVXc5Wi9o5oicCXXNzOFbnBrZ4tLC7SHRynAH?=
 =?us-ascii?Q?nX3R5vFOsqtpnV2LJ81we9LH6LoeU0Wn8ue/B4rcQyeeNDqOgrdZusjGY46+?=
 =?us-ascii?Q?Dmth92RRqNxUuhGZZOJwb9Sf7V39T9du1U5+bhl+FKrOGz7cUaZchDBMRxzW?=
 =?us-ascii?Q?z/5gRlimT13kpgZu1BmRIsDmGfnI4oLSOTJpBFnZb10klpN6ZGq/dEHd46RD?=
 =?us-ascii?Q?KMY6x+BKI7rsbv/rr4WtN5tNwi9PprWdWU5MAK40ZZaF/1grZWGegHDlEx3r?=
 =?us-ascii?Q?4EK0GlhbRwkGfHf18N7HAESGAI2JVLV2yVz/af7vVgaI4BmrTVsE8m9VNN1C?=
 =?us-ascii?Q?dR2hLn/7LLFKAck5O6y2Xddqco4nkrFuUBYcx/hj3mVvHFO3qXDKAqe+ARqR?=
 =?us-ascii?Q?HPz/tGnwhp9/v3msf54FFpK84L1iKKBHlE54+nK9SOCP1TDuYT6Ym318Lbzg?=
 =?us-ascii?Q?xE9fmEHho9ekfN8El5ZYwskQKKc+ujxpt55ubexmvrrmM2EVswBWJRGo5dmn?=
 =?us-ascii?Q?zQ7EGZJFriZKqhonk+RtOab9mn+V+anfKTDmJ3s8+RRLfY+LXjvlEsSwWZSX?=
 =?us-ascii?Q?aBkdqZDhKayRFev2AmT8BZiWYEUSwRcFic+xrF0Swvz7YC5CGvhe5Um3XXJH?=
 =?us-ascii?Q?PZhxVNZKZel5HrXjfRI39rqLTCnDwapFB7cQcoNH47ABS/hfDf0YpeYlJO8R?=
 =?us-ascii?Q?4cSU5t6jXryalelq9K41Fcd6LnxHaYWVNxb4Woab+XJ22Bm60ZXo9z+LiA7f?=
 =?us-ascii?Q?gymlIxs9SyAdq2+4aIEczdXEyNcKRuUEdnj4PbofNuVOtP4xEgfXQjGZiuxG?=
 =?us-ascii?Q?3kuHHF2DCM30zvIJ8eHf4ozlVK8GpAB6SxOvlX0V7h5f127ngYOVWGu+6bPe?=
 =?us-ascii?Q?YsjhrfLtT60+cis1i+e1DIVFB7Yu/I9Urdi7I3+aRjUV73bdyHqIt6/NTTc0?=
 =?us-ascii?Q?2xDoT9yK1gOrXkT4drCRRsEUIb+Qs25JQIyJR3x7xTi7eE8ihvzO2b6pIwf9?=
 =?us-ascii?Q?KbE81bk03uQ5EuhV4NA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d06fa4-d77b-4fd6-b316-08dd33a6e225
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jan 2025 07:50:00.7644
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hiGkVcZIFlmz8APXLscMvKziPq/GCyMfn7WR63lT+26XSTIpaMkiTtf66CRK5JmLzYfMCSQoatt2N9ASM9xmQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7322

> > On Tue, Jan 07, 2025 at 02:19:53AM +0000, Wei Fang wrote:
> > > > > In enetc_phylink_connect() we have the following:
> > > > >
> > > > > /* disable EEE autoneg, until ENETC driver supports it */
> > > > > memset(&edata, 0, sizeof(struct ethtool_keee));
> > > > > phylink_ethtool_set_eee(priv->phylink, &edata);
> > > > >
> > > > > Is it a hw constraint (if yes, on all IP versions?) that EEE
> > > > > isn't supported, or is just some driver code for lpi timer handli=
ng
> missing?
> > > > > Any plans to fix EEE in this driver?
> > > >
> > > > Hi Heiner,
> > > >
> > > > Currently, there are two platforms use the enetc driver, one is
> > > > LS1028A, whose ENETC version is v1.0, and the other is i.MX95,
> > > > whose version is v4.1. As far as I know, the ENETC hardware of
> > > > both platforms supports EEE, but the implementation is different.
> > > > As the maintainer of i.MX platform, I definitely sure Clark will
> > > > add the EEE support for i.MX95 in the future. But for LS1028A, it
> > > > is not clear to me whether Vladimir has plans to support EEE.
> > >
> > > By the way, I am confirming with NETC architect internally whether
> > > LS1028A ENETC supports dynamic LPI mode like i.MX95 (RM does not
> > > indicate this, but the relevant registers exist). If it does, we can
> > > add EEE support to LS1028A and i.MX95 together.
> >
> > Do you know what the reset defaults are? Can you confirm it is
> > disabled in the MAC by default. We have the issue that we suspect some
> > MACs have EEE support enabled by default using some default LPI timer
> > value. If we disable EEE advertisement in the PHY by default for MACs
> > which don't say they support EEE, we potentially cause regressions for
> > those which are active by default, but without any control plane.
> >
>=20
> Which platform do you use? LS1028A or i.MX95?
>=20
> From the RM of LS1028A and i.MX95, the default value is 0, a value of 0 d=
oes
> not activate low power EEE transmission. I'm on a business trip now and d=
on't
> have a board available to confirm it. Or I will confirm it for you later =
when I
> return to the office. Also you can find the address of the PM0_SLEEP_TIME=
R
> register in RM and then read the value of the register through devmem2 to
> confirm it.

I checked both LS1028A and i.MX95, the default value of PM0_SLEEP_TIMER
is 0.


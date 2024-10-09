Return-Path: <netdev+bounces-133719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66138996CAA
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 15:50:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22C40283989
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 13:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D04B1990CD;
	Wed,  9 Oct 2024 13:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="RcBdhuNn"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-VI1-obe.outbound.protection.outlook.com (mail-vi1eur03on2051.outbound.protection.outlook.com [40.107.103.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D27192B88;
	Wed,  9 Oct 2024 13:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.103.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728481805; cv=fail; b=RNb2GgQTossQuNLzuQzCH3AgoaeMDkLdkgoI9mjGh0ZegwSsHw/DMkiKFIo8zIanMc5HM7rSRnTD77wr/yaeKCIaHj6a5e14w+sGHWAHceD16zeOro5BOZY3zc2OcsaSp7LU8R8mQTZaCoBgQWGYs2Q44dVHAngsmRVxybcQqoc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728481805; c=relaxed/simple;
	bh=Zk9KxJB5KCZ3k9dg5DpplPMUvmkT1aPpsHPd+8E0mpQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d85sMaYj/t9SyIyQ26z8YhbTQ7IAUosa/YW5HzLPP1Kp5DSfWsT0soRnnAy5FciCSrLKHsilSsfqzRIXZLFrKjf868s3aSAFu9lo+RU4OFYqezGE9B6rt7bmEeOybYBJ7pUWGLoYM4bDq0lnkUy59kqt4qb24ZUDIcCe8Y71LMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=RcBdhuNn; arc=fail smtp.client-ip=40.107.103.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iP7VAyVX3rw4IddOiGu3Cwrl0d7Fi5Y3b5tpkVbPpJ/EKWnKw0hZM+LvMAEnliMKEnbolgHN/WJ7pUVHlAVy79D3mEbkaJhn7X7d55EY1as5B96uGOrmyV8Phiu20PUbGQz5Ljsa/gq+eqzkD+I2q+XKgqnAixzY867+B4m9CAIXUXltNIa+gSXKXBMfzItv8xoOPiPGVpOppTVaNlE/HSJhmZwPgGqnJs4Pe7vTkXFysFYfvjrClg8WtNvewgwkuI79FSwLGe9KHV9GWQaX7EO2KNxJdnj8sQzpoNQ729mN5ns+L8WYThM1oet39OvZADhpJM+Nw+BxhequMJ/mNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GVWB2C/XtnQoqFUnWoihU/Mka/76p/ncDA8XBR6IMHM=;
 b=CMea4tXNQYvHCIHR2sDmy0Vq6doWGMOBvMWIn8VdvcVglOFVxOZBmTwbVGfp+IfsB+cvDBFmjn+kC+08mcgd7IAWyPVG1qSo9/Jaq4eqhxDs/sd7FiQHJX5pmintcRfR+l9vgM7NjN5kzuhx8z5ClTxdeeiFWPh5CV+uXElHT6HOSGf3HNET2bHWUCg1LpuY/Y+/rMhXnKyFznipdPYEU436axV4aTH4JHu+N/SLZuZx19otV1AyAGbL4gCG7BqclFuEWkaj/u6+m8fDJdJ5D5D0nzVN+9m1xJt1dy2mck9uhwkYtzJ0xRFgvLCPsBQV1sKuy1dhWECaG2mblJ9/MQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GVWB2C/XtnQoqFUnWoihU/Mka/76p/ncDA8XBR6IMHM=;
 b=RcBdhuNnOkacOM+cAobyua6R5Y/+OreqM7JyUUkizrnTzLIjrybabznLVEAzUPVgAtLFiyl0uHUZomKanIqVyOte7OLRnqJarwrONb3C55/Gp9acUqK4vA2bcw8RLY5T31AyAfBOcHMTACiTbpFpeXzXgI5kyvYVb2FhupAJQqA=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by VE1P189MB1120.EURP189.PROD.OUTLOOK.COM (2603:10a6:800:16d::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8048.16; Wed, 9 Oct
 2024 13:49:58 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.8048.013; Wed, 9 Oct 2024
 13:49:58 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Kory Maincent <kory.maincent@bootlin.com>
CC: Oleksij Rempel <o.rempel@pengutronix.de>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jonathan Corbet
	<corbet@lwn.net>, Donald Hunter <donald.hunter@gmail.com>, Thomas Petazzoni
	<thomas.petazzoni@bootlin.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-doc@vger.kernel.org"
	<linux-doc@vger.kernel.org>, Dent Project <dentproject@linuxfoundation.org>,
	"kernel@pengutronix.de" <kernel@pengutronix.de>
Subject: Re: [PATCH 00/12] Add support for PSE port priority
Thread-Topic: [PATCH 00/12] Add support for PSE port priority
Thread-Index: AQHbFOYypdriGqfBF0imTPrJ4BWVpLJ9mBcAgADiVoA=
Date: Wed, 9 Oct 2024 13:49:58 +0000
Message-ID: <ZwaJ9O394v9Zueic@p620.local.tld>
References: <20241002-feature_poe_port_prio-v1-0-eb067b78d6cf@bootlin.com>
 <ZwXMFV5SaIGgVoCU@p620.local.tld>
In-Reply-To: <ZwXMFV5SaIGgVoCU@p620.local.tld>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|VE1P189MB1120:EE_
x-ms-office365-filtering-correlation-id: 4faf7a76-961a-4615-7bac-08dce86943ae
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?kAjMZvc68se8Koo4VQwjQdS0mCJVYZGSBwzuo9hMWBlW/H0PsSztpGH918fa?=
 =?us-ascii?Q?ZpkRcHlCOpEy7umKYCDGKd23d8tTOziPD7wPd0GEGMTDeNOUGOJrAJHL9JhL?=
 =?us-ascii?Q?htN7rjUZ09Rv4Wcf5IY+LtONIyEnv+eQ5Wfdgc2v0A+nR4ib00sAdHStliCq?=
 =?us-ascii?Q?1gpmgjE0riw3G9L2d31DORVma/eUenuJj56OUg7VK/VuHkPirFyI9r7nHkJd?=
 =?us-ascii?Q?fWnLnMJg3ON1Lro3C+4V/Q+wJmKhiVtF4hf+dmSY+PDc0rzHqXUflDVWE5w0?=
 =?us-ascii?Q?Wfm8Olohvv+4Jef2cNT2gIenyqH4kXiJPw04TqeUOLqaJ9aB0s5KOBP9Zdwm?=
 =?us-ascii?Q?TVAVDZRhj2JfxKgtr0H6M09UpgGBNFmaQrqHwsGpGDCLJJH48dP03IRXEZ+6?=
 =?us-ascii?Q?JmNwmeXBgMFpmGqlud77+Tgly0JyhOwOD4ydtveLgY7ZDW2gxtphWr2rERjm?=
 =?us-ascii?Q?mqsefRX23+6L/9cfT0YbzclXkRPnTQdj8dwbuljp7Su9LM2RIdX7zgoXL5/2?=
 =?us-ascii?Q?msDaHpE3Vp9Xd9YPP/T1bLOtx1ZFqWX7T1qOQ6yxoYy4UqTfy2CvagBMEpK2?=
 =?us-ascii?Q?WJJOVOSZw+64+k5kdPG8NHJ4ZX3+QHyEjhlWEVQD7rSsKXpiUWUZu0e6szyq?=
 =?us-ascii?Q?nl6CLZLf4qEwxDnQ+xQ///jnnSG3sf5WKOn5iIap5TqfVns6qTEM/ftSCC1S?=
 =?us-ascii?Q?hc7jemMA6ACfhJdwsSWUINf3MHLKEqIO7YhGNOaWhM3rH3maycq+SHVhRtoP?=
 =?us-ascii?Q?PxvSDiWGLXO736rLEcJucD7aerBJ+lspTOUBIQlkdfo22IJmPa2dDK6cCI3H?=
 =?us-ascii?Q?xt+gdxwhduaQEyo4GKkDoGJDkoW5d7g5Kz4/IxSwuLrrXNWBuxbLxluM3gzF?=
 =?us-ascii?Q?dvHoB6pbGebJo0QD+wq1V+p6Sgl5k8ABLgMkAZ+gs40jv2B+06FDEuSzFR83?=
 =?us-ascii?Q?BHagTqnqtTfKps45MZrXJiwSKrVH901RS1GioNwwGa+tpjXJQ7niB2kT1O4o?=
 =?us-ascii?Q?aSNENQnlVhNo6N2LyViGqXa8Yg2Y1lm1iK11uI6mMvtX8VcKoH8TWQzoWCEn?=
 =?us-ascii?Q?7v1zQ7quqDJx8fo2KRGBAg2Js+yYj7PQ/EoxvpP75X4m1iU/nCq7bbEcxbn5?=
 =?us-ascii?Q?MuHp1u8MUP6GrT8+EiEI8SuT4a1o25Kc9PUkOVb5vOPKAC05eDsCiNS/0MZt?=
 =?us-ascii?Q?eAH84EV151K1NMeL4sy+Bqv5yR89ynWLeJhkb9yowSROt/Jomt2I3EW5KXSZ?=
 =?us-ascii?Q?fDZBJMuoAU5cBHU2YtoI7kHlBSyuHMbNm2c7Hf9ev3DC6tr1mZ4ccXSOCVXW?=
 =?us-ascii?Q?K5QgqxfJXcaUa5p5lkUihhZRR/t9vwpu1aA4QLdCqqyjvg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uINWGCi5tV9kWZb0x5ScsItIqrWSX76heYcfdIex6ak+n9avvC8Fg5PMxPoX?=
 =?us-ascii?Q?mwWkNrTlNkFFdXhnec9uhXBIBZXZpo2iT6oBQKoxPKlsKjBO1l527nWQ7A4R?=
 =?us-ascii?Q?gv6M3p2MV6ASd1IZ0dttk43AVpjSH/ymwboM1PlNUJuG76B2AmAD6Y2+Lan3?=
 =?us-ascii?Q?+ypbTbBDtvzMwWImQv671lxH4Ifus9hO51y+8gVN7Rq6BpEnOoUSGGK8Gv70?=
 =?us-ascii?Q?KvKYK6/CLigxKjMdtWm9nmM7T3kB+5zz6Nm0LCSbJNpMbV0K7A/TIWbt1jcU?=
 =?us-ascii?Q?3YfwfFazTkveliBVJ805WYuCQobyjwY2RFGTa5rSR16shtlnUduUFfdc/Oth?=
 =?us-ascii?Q?kNIu5lG7iAuUGLvVv+JKgWWSD+DhSub2Mrz/ZLDZnl9D4c73cip2p4Dmf2+c?=
 =?us-ascii?Q?UPSXLolsYKHK1zHEI4TT/M/RFV6KMXS/8fd4Zj8l2mumRGPhDphB1OMeRS4U?=
 =?us-ascii?Q?yXO5KbcXI+HpNuLedQFvRBrDkT+9iZBgAKDTIJK64Q5rpr9hRgF7++jrQfi2?=
 =?us-ascii?Q?LLkBn/otxFDbWaoxYIkd3ZxoupLUOWvTEPa1d/B+UzVucycG3Pp0SxHlfzM1?=
 =?us-ascii?Q?lwnCMXiSUfqTvHV8Fzf1Bxdb+96+C0tatBZzN1+exewBNoV3aoy2yuFqJ+xi?=
 =?us-ascii?Q?bvdDYnm+03gWsqV7RCjXM2JC7QrT4fh8xWtKk8nROGhREnrDST8d8TBO2ybx?=
 =?us-ascii?Q?FC7rsR8FZ/R1Uzss2ErVhmzlF3fRXyFcKh8i0nBy2Y550uBnLscCEa32ivV1?=
 =?us-ascii?Q?rYkB2GFw2Ul7VTV+2BNdP8DNNSCQ69eekI9Sq6DPvQvJHOdpTlxXJhRYl1Z/?=
 =?us-ascii?Q?KsRVjnn62O5oGd+CD7vSFvR9qKu/YPwjONL3kY7gNplsKRw96OqXnwoxDZZN?=
 =?us-ascii?Q?Qko701JYWo86Gnr/svV7rzeEZIVe1nZsLd5V18CGXLZG/dZi6G0nkZDwAkKx?=
 =?us-ascii?Q?szRHbnHzWEc78wf9mu0ECAOV8GqndoquWveBq2acK2JfuNxTKyi6L7dC1O3X?=
 =?us-ascii?Q?MXa6SsMCTXmZJ2BG2dyQAKRxkSN8pemITppo7QxKVNLIloJiCK1r9MZes0wV?=
 =?us-ascii?Q?vGvw69dwSB825cwlwSEdrBG/VvQZeLg66SGla6t3kx9pq6UIr/Arr/eNXoMh?=
 =?us-ascii?Q?GmCarsdpkNLr9iO14DeoxTDqjRoZaTaVcwBlPTOTyTqjKklsj/lcZwffMQNH?=
 =?us-ascii?Q?rODvUkWdDuCBPJwyDh9Fvxbi6ktKACD+6OdgXa6QOCccsB+nPs5IXvpBODuK?=
 =?us-ascii?Q?uTilxE7oEAhxeOzUy7DZjpQC55yo9XpOO4EfPA4MRzNm+jKJNzDytU/0pXUc?=
 =?us-ascii?Q?UhnLa+XJfAaEwiUS7AZhovyx9q6K/lPIbqsOEGVc3atRIcVTPOIFrm2GllRm?=
 =?us-ascii?Q?FWyJpHW2FvnB16yc69evex3zgp7VJIFTwEgcpRxFzDpe2MmVkbBSKCXvH4HN?=
 =?us-ascii?Q?orJFUyiw3LBx/dGqASyv22nYoj+hHiPLrB7OlIsAM9ZB4167pcFehllQZMPf?=
 =?us-ascii?Q?mfvBLI1XdIfQ3FDnHEL9sazLSpyiTvh4vg3TgmcDvHPbbSMWwd+i8IyWicEg?=
 =?us-ascii?Q?hElmx+CJ73MlO5c5LqA4klmz3iCF7tYohAxH6/vuFsOVT96XDjSqWTQMwdC9?=
 =?us-ascii?Q?Yw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9D9C9EA583BF3946A85B1ECA9126CF31@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 4faf7a76-961a-4615-7bac-08dce86943ae
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Oct 2024 13:49:58.3989
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sS3F/He0/dffT5Ed025bwuoNI+NNaxrLC/wLctjWSKzJkTJsuAVi8W8QFgh0byzMYCE6cbL/VakAXLON2yGdIA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P189MB1120

On Wed, Oct 09, 2024 at 12:20:21AM +0000, Kyle Swenson wrote:
> Hello Kory,
>=20
> On Wed, Oct 02, 2024 at 06:14:11PM +0200, Kory Maincent wrote:
> > From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> >=20
> > This series brings support for port priority in the PSE subsystem.
> > PSE controllers can set priorities to decide which ports should be
> > turned off in case of special events like over-current.
>=20
> First off, great work here.  I've read through the patches in the series =
and
> have a pretty good idea of what you're trying to achieve- use the PSE
> controller's idea of "port priority" and expose this to userspace via eth=
tool.
>=20
> I think this is probably sufficient but I wanted to share my experience
> supporting a system level PSE power budget with PSE port priorities acros=
s
> different PSE controllers through the same userspace interface such that
> userspace doesn't know or care about the underlying PSE controller.
>=20
> Out of the three PSE controllers I'm aware of (Microchip's PD692x0, TI's
> TPS2388x, and LTC's LT4266), the PD692x0 definitely has the most advanced
> configuration, supporting concepts like a system (well, manager) level bu=
dget
> and powering off lower priority ports in the event that the port power
> consumption is greater than the system budget.
>=20
> When we experimented with this feature in our routers, we found it to be =
using
> the dynamic power consumed by a particular port- literally, the summation=
 of
> port current * port voltage across all the ports.  While this behavior
> technically saves the system from resetting or worse, it causes a bit of =
a
> problem with lower priority ports getting powered off depending on the be=
havior
> (power consumption) of unrelated devices. =20
>=20
> As an example, let's say we've got 4 devices, all powered, and we're clos=
e to
> the power budget.  One of the devices starts consuming more power (perhap=
s it's
> modem just powered on), but not more than it's class limit.  Say this dev=
ice
> consumes enough power to exceed the configured power budget, causing the =
lowest
> priority device to be powered off.  This is the documented and intended
> behavior of the PD692x0 chipset, but causes an unpleasant user experience
> because it's not really clear why some device was powered down all the su=
dden.
> Was it because someone unplugged it? Or because the modem on the high pri=
ority
> device turned on?  Or maybe that device had an overcurrent?  It'd be impo=
ssible
> to tell, and even worse, by the time someone is able to physically look a=
t the
> switch, the low priority device might be back online (perhaps the modem o=
n
> the high priority device powered off).
>=20
> This behavior is unique to the PD692x0- I'm much less familiar with the
> TPS2388x's idea of port priority but it is very different from the PD692x=
0.
> Frankly the behavior of the OSS pin is confusing and since we don't use t=
he PSE
> controllers' idea of port priority, it was safe to ignore it. Finally, th=
e
> LTC4266 has a "masked shutdown" ability where a predetermined set of port=
s are
> shutdown when a specific pin (MSD) is driven low.  Like the TPS2388x's OS=
S pin,
> We ignore this feature on the LTC4266.
>=20
> If the end-goal here is to have a device-independent idea of "port priori=
ty" I
> think we need to add a level of indirection between the port priority con=
cept and the
> actual PSE hardware.  The indirection would enable a system with multiple
> (possibly heterogeneous even) PSE chips to have a unified idea of port
> priority.  The way we've implemented this in our routers is by putting th=
e PSE
> controllers in "semi-auto" mode, where they continually detect and classi=
fy PDs
> (powered device), but do not power them until instructed to do so.  The
> mechanism that decides to power a particular port or not (for lack of a b=
etter
> term, "budgeting logic") uses the available system power budget (configur=
ed
> from userspace), the relative port priorities (also configured from users=
pace)
> and the class of a detected PD.  The classification result is used to det=
ermine
> the _maximum_ power a particular PD might draw, and that is the value tha=
t is
> subtracted from the power budget.
>=20
> Using the PD's classification and then allocating it the maximum power fo=
r that
> class enables a non-technical installer to plug in all the PDs at the swi=
tch,
> and observe if all the PDs are powered (or not).  But the important part =
is
> (unless the port priorities or power budget are changed from userspace) t=
he
> devices that are powered won't change due to dynamic power consumption of=
 the
> other devices.
>=20
> I'm not sure what the right path is for the kernel, and I'm not sure how =
this
> would look with the regulator integration, nor am I sure what the userspa=
ce API
> should look like (we used sysfs, but that's probably not ideal for upstre=
am).
> It's also not clear how much of the budgeting logic should be in the kern=
el, if
> any. Despite that, hopefully sharing our experience is insightful and/or
> helpful.  If not, feel free to ignore it.  In any case, you've got my
>=20
> Reviewed-by: Kyle Swenson <kyle.swenson@est.tech>
>=20
> for all the patches in the series.
>=20
> Thanks,
> Kyle Swenson

Somehow I've managed to post this to the wrong thread.  Please
disregard this message (don't reply to it), I'll send the same text
above to the correct thread shortly.

Sorry,
Kyle=


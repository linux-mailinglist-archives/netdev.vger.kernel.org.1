Return-Path: <netdev+bounces-120328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A13958F7E
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 23:11:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E21B71C20C69
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 21:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347911C4630;
	Tue, 20 Aug 2024 21:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="dcqu6Chq"
X-Original-To: netdev@vger.kernel.org
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2070.outbound.protection.outlook.com [40.107.104.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE4A1BE228;
	Tue, 20 Aug 2024 21:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724188288; cv=fail; b=LHF1Roz5Q4Hv4Ek/g1GStiDL7ASuzIPmsFlNagL53Awfv8ai2L3z3bcETw0S/mAHdrSCuY1Gd27ffSnzNpCVkUA8SgS8IY16g7n2CQD77hEFLS1suUKy2IVSD+z4/mO69tdmb9vCo4Z/EGQ49QUugudZWKtjEt2G5/Ij9P5jamo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724188288; c=relaxed/simple;
	bh=4+hyANkTOZ+2M2leMYMy3z3NajxUXAH4Yisd6CMJOyc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TWLhrUVTbHR3nnG5t3KgsjYOSuA6UZgvwwtzc1S/C45dFfo/EQABgJ/GZqhtpIhOlvgU5UaqEk6ofN2oBXChbEEWxdFUqNy0+86lPGTFkbQ5rWGk7z/EmDSP+iz7n+Hjk71frCTGbFkuBqbLjKWwLh6CAEizUYXmqM4I0w91mLA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=dcqu6Chq; arc=fail smtp.client-ip=40.107.104.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mHzJPbJ06/EpPaQPluTOiNDXnIrStFSAPg+zvv0PWS0sof1MOBPrwCODGXrHQsMsDbG/UIHV/MzL+X75a1AL+OO6g71eApNqPFsQESgMiiQOYT5hdCWinLQDrRhB5Crun9TmxJQJd+DKqTnUdU6Mbj+V6pGUmVq2qNYT+/pW8JtgJaAf2bzgWvP0rc+F9Q+/vpl3zYkgCgg8WkytTRlPo3K9nfV0oAobCW7QArruJZz0JPhp16OGyu/MqWgZbTxdZGeR72HkpzeM7B6Cy74xSwga3620EruI187PCIhMS881Byz3XMh/BFEZU7bu8Z3XU+LuLXIu8qwaApzZ9LTLnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=O0aMFkuBmYQR+7my59N7+MudmRVO0ce4HB42RdJHSgk=;
 b=H9FSWBI5ZGJKCw/zyb6g9kqnWoCbNkGetA9/6vaGiiVF5fevlIGPEAodSXlIoirnMvtBYOpdxa5pLSnXKYiYGr4vQC01Rfs0iQdUCowCA4pSjpr/r2VnO6vnn2p+moIYktzCmqCU0f786sKEMEV8ecSpWL25YBZwHS3Bmy6EqTldfnuMmzf9L0hNzJuveznWC+/uix7qJzzsvWEVdePGxiha/+d9moCYyICG03fZkW8QsjYX/p6J4OIHMr8zwoU0/kmSY5RMwvPLeXYaq9/I1hi+z+DdjeGEl8ix5yshmCKTymwOB187wvI3Tfn05YjC5yfLra9ksfp2yXPZNUwLZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=O0aMFkuBmYQR+7my59N7+MudmRVO0ce4HB42RdJHSgk=;
 b=dcqu6Chqz3sNhdLLQgSlgb4a2/+Zm2jzuK1UGw6kzELz84vM8+1jqumGYO8RKnIzdCaqxgd0i/Yfg3he/uYZJhnW6tI5qYiyd9cRmsA/QuiyatIeonwe8VYU0JESEg/YcIG3ec+if7PS68xFG0Z4bzAfeQxx5qJy6AGdWj640mI=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by AS8P189MB2071.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:508::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.25; Tue, 20 Aug
 2024 21:11:22 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.7875.023; Tue, 20 Aug 2024
 21:11:22 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: "kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "robh@kernel.org" <robh@kernel.org>,
	"krzk+dt@kernel.org" <krzk+dt@kernel.org>, "conor+dt@kernel.org"
	<conor+dt@kernel.org>, "thomas.petazzoni@bootlin.com"
	<thomas.petazzoni@bootlin.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [PATCH net-next 2/2] net: pse-pd: tps23881: support reset-gpios
Thread-Topic: [PATCH net-next 2/2] net: pse-pd: tps23881: support reset-gpios
Thread-Index: AQHa8mpN+TA+JG1k4E2yihVubvKI7bIvrj8AgAD2gICAAAFpAA==
Date: Tue, 20 Aug 2024 21:11:22 +0000
Message-ID: <ZsUGbsnkvCr_tyqS@p620>
References: <20240819190151.93253-1-kyle.swenson@est.tech>
 <20240819190151.93253-3-kyle.swenson@est.tech>
 <ZsQ2fuqWkMYwq_kh@pengutronix.de> <ZsUFLDaMdVPQQ98I@p620>
In-Reply-To: <ZsUFLDaMdVPQQ98I@p620>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|AS8P189MB2071:EE_
x-ms-office365-filtering-correlation-id: 2fc59f0d-ae40-490c-95d2-08dcc15ca4be
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FTJtj/NkXT5CXn90tybiRkzNDhDGMJEjB2tCyaSyrhyc8tosFJWAfb6UNvkD?=
 =?us-ascii?Q?0gYpQVolYoubuArXt4F+etKKzNDNCSDejqONu8GT2f7R8eWpesXtQoD+aweP?=
 =?us-ascii?Q?s2kMdl1+UX4L1KmQ/ZvE7OPRZwz81UcOWU+0oVZuZdcyCg00LLLEDQirdl9T?=
 =?us-ascii?Q?2htMfr/bUflcLqzvQBlIVqddZGhkPmrkmaxGDRtuxwTKu1Gt/+zNUN9ZCcjI?=
 =?us-ascii?Q?h0QLVttY51ySl64N0ROebUif/MJDbBb5zT760Uagx8BegB+7Jj8DPNz7cY7c?=
 =?us-ascii?Q?lZjhNlsRVoLvUgSHMpVzLo3QWTEbq3NuobYS+Fy6sTXUuuspl7pA4THfH5b3?=
 =?us-ascii?Q?hpOmdYxnJqmbKoLO8VXNcgizG/6Sd3TVnIX1QGsa7PBTYKfmzjyc97W+4ecJ?=
 =?us-ascii?Q?p1UGxsI0JbaXPlRmgQtZP5vWYjZo4EyUCCoUJzymoj3Q3J5mrJoPphFCDp2Y?=
 =?us-ascii?Q?160TDdUl0r05o1K2tM7YzhN9Ubek4ld9dpkMGQRMMRbK60T7HaJKUoZlv91m?=
 =?us-ascii?Q?tCOGeiSpEfhEBjPLHZhd7uG8gS5/6pCBftA15Qndw8yTILubymYGdUUW/5ce?=
 =?us-ascii?Q?/+q3jQLqEgi0Vqx5vuDbyAjPXslLCKz8ISc7I5H+GIMnNP7Q6Px/XT94hnkQ?=
 =?us-ascii?Q?F/UiBGHCGRXX72ZKVi/3f1aknS75A2cb9VxSyWBK5/NgnCOR4UQEYZJ1EOCR?=
 =?us-ascii?Q?yMAKMrnMohXIkMl1NGpOd9pSQAKaUG2ieqAih2UVCnKo86ss+QJNYYlv3LTy?=
 =?us-ascii?Q?PU439cnkRh0newsNS2K1u6nMv9FWjFKqW0YWR6fWB9rGwjy646RDFmrB0aMg?=
 =?us-ascii?Q?HcJhKq1eYvdGQkL4iexvxY8+H9qzuXhjciaBzeWhjxtBRUq9YmqxZ5/wv8zO?=
 =?us-ascii?Q?bk3zY4v9rzk1UGdlZKVP9F55tHFuR/s69/jPiNvdrV4MPtbUyp3yw/ArOYuJ?=
 =?us-ascii?Q?fipC/+9Ua1JxQmxMMn/bK0o59iPEACgConAPZqRXTpT01LWBkrxTgPSxCC+B?=
 =?us-ascii?Q?x/DYKZ9Fsd3A2+wNFjIN8T/veTQfH0JPLV0ZINO/DWLhVxJrrhTD10UR9ARm?=
 =?us-ascii?Q?DEiRWyO53+/P0X7dSOB8b0ebxoUfI8khrBvj3kNenqzPTHWlcW8lMSFj3+Vu?=
 =?us-ascii?Q?NnWqbOS8+0IklUP4JaMId/JY+mwxum+RQai9RS55eSl0q2OeH8vgYxdXWnyr?=
 =?us-ascii?Q?k2I7iigqBStPYVBkklshPXof4IEZr0Z8JB5SaMeGgKb1J8AD8wH5sBh1Ya7L?=
 =?us-ascii?Q?X/JH4/0fgDDRgaeBE87afZjwSmCzzle0V+Ij2fXpXUlLARYlpAFJblxRN2NQ?=
 =?us-ascii?Q?S/ZbbGmvCddh8g90k5Brj3X5yNORJeNo8zn9K22bDZzT6PNuM76Rwr0ae8vI?=
 =?us-ascii?Q?6b6y7nw=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+UYeTyrPF9arAXzsyU3JnNgWffw2irx9EJmgwHHi5yAqzmLfMXlDOiuSuAlx?=
 =?us-ascii?Q?WZINRKkUlcLdP/dlWeDFkTLaC9mQVP1PBKJbXwrUTmb2dIo87/8w6uvj8aMa?=
 =?us-ascii?Q?U2TBCbYezH/9BO/spE7rvpKMDqJn2A9sCiH9At6uyftivfqat6cIux1eSydz?=
 =?us-ascii?Q?PpdjJHKVIQ8DvXjCE8TfpfKaS9cwmNJbZNpWF9b6bsqK5/HGvBB1/mWZO/PJ?=
 =?us-ascii?Q?QNtIjMrP3Qu6na6ORwZoKrcPpdkMArFODNWDE+Rt/vZng9EFmcGnB+KhkZnP?=
 =?us-ascii?Q?a/TqXR03Pw8sJSmnJ9Fc8JDaG5pvSkRCr9lt/414xSEdiRFARvWghZmjNCyu?=
 =?us-ascii?Q?wipLNyxVqyuTk0hylAHD7zVQtoIxJXuiIrHBP+lTqs//31nL5B1nT4v2pPDd?=
 =?us-ascii?Q?pikmvkuDUCVGwxlAJUOzor2Oxqm+ZcDTgupTR7HtqSMcBLoCIUE3Q/eV7Bro?=
 =?us-ascii?Q?+yHZKij9R3j+ffv368SlEYXy1HFSEgVVxseBQZvt8i20uwbqSqPek9ASY7I4?=
 =?us-ascii?Q?vp9JPRlymd2jz+EtV9LaF4CQCS1QpKqYiVBh0Q9KrJIlpaLpUkIm9t9Kv99s?=
 =?us-ascii?Q?1M9268fyh6iMH0k1+rdNTHthELULNbPyi4sEMjc5MfDz9Rar29Hq5BSKY0tr?=
 =?us-ascii?Q?tzelbGWGG8AyzL4+X+N28BfDz8rNbm7qLFtuUWBx/Sp0kKR83H7QB614veaD?=
 =?us-ascii?Q?l8C5DiMKIocFBDVrBYKtG6ULrtPJSMFfvFcTGVL+McOkDZxmAYAy+V5FpFDV?=
 =?us-ascii?Q?YWU8/iwhjtH6DLJ8XIcwNAw/GXAlRAKINP00+M/xh7CEjswylJbBEBZBxGPx?=
 =?us-ascii?Q?rVtEjtt3GaIJURrZPUc/BxdpiaylR4DmKyrM6BWjkAk8oCTw0XApbnOpcoQe?=
 =?us-ascii?Q?tI+ZTEkAvUGoRxTizj9NUqHwuirqwZc9Hcb5AFkmWxAZTDEHiYmaZZ/4Ea7V?=
 =?us-ascii?Q?jxyd8cf54J0dJ/SIf/8ZGqYjFlsLNS2KlKGSyuFU7tAS0KArbPQzY0Bgh/X0?=
 =?us-ascii?Q?5bLIpxOjkE2+3aVxiNh/JJyrin2smC+8LsMrVobS+5Q99vwaMk7X2YIyMPeP?=
 =?us-ascii?Q?l2qE01sPfOpgRs0TdWKpL4z+RWWv+dq1H9ovnCUH1Egna4g/YmH5jbd7ZCXp?=
 =?us-ascii?Q?GkM++XqCuOGpkXYFepnP+QzaxPriaSAeQozXm0zDopfRo6EBFgKMPwIwj51w?=
 =?us-ascii?Q?0CuJFdYaHigq9bzm4yVKpZyejJS5zrirWzugpZKgqGelOyhrCAXYjpqAZ0d4?=
 =?us-ascii?Q?e9Rxqp8R43V7EPMs7H7QR3AaG2r3aa/3wyYRhuD2uGBvJ3QFzpFZvcULpxO/?=
 =?us-ascii?Q?8b22fKQUOScb1fKHZP3EnuRkw4fTZE7I+ofYqkrK/i/H4ER6JduxOtp0l7ks?=
 =?us-ascii?Q?FoqXG+ZmdipudDkSI5UDJ8yxn2OKIBe/0iwyqxwpX1bOvXkSzckDYnSJc8CG?=
 =?us-ascii?Q?Mx/k3qIC5lSCTcnEGA0YccHsanreZ3z11tqXD7Hvhu2TSvKwi9dN8QJ0+/iF?=
 =?us-ascii?Q?AJCVCFfaojrVQy4Jl0r29puNnTUVPTx9GPzBN4HGOZE5wMgsyW0gO7LWebKn?=
 =?us-ascii?Q?n7llQ2SEP17lz53wKby6rsFPPREE1fkxa9lVgTHId8/Y7Z5RKfwdYqAyN8vk?=
 =?us-ascii?Q?fA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <007C1FC4ECB91F4997BBB641332E24B6@EURP189.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fc59f0d-ae40-490c-95d2-08dcc15ca4be
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2024 21:11:22.4239
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oGzak9WZxm0ciJvzE1kIxwDj2taPAGZTqOpsfqs5pEl23MM4jsHaRL049f/YYlYEifUBNh02qPwVf6aFU1ZYtw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P189MB2071

On Tue, Aug 20, 2024 at 03:06:19PM -0600, Kyle Swenson wrote:
> Hi Oleksij,
>=20
> On Tue, Aug 20, 2024 at 08:23:58AM +0200, Oleksij Rempel wrote:
> > Hi Kyle,
> >=20
> > thank you for you patch.
> Thanks for the review!
> >=20
> > On Mon, Aug 19, 2024 at 07:02:14PM +0000, Kyle Swenson wrote:
> > > The TPS23880/1 has an active-low reset pin that some boards connect t=
o
> > > the SoC to control when the TPS23880 is pulled out of reset.
> > >=20
> > > Add support for this via a reset-gpios property in the DTS.
> > >=20
> > > Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
> > > ---
> > >  drivers/net/pse-pd/tps23881.c | 13 ++++++++++++-
> > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > >=20
> > > diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps23=
881.c
> > > index 2ea75686a319..837e1a2119ee 100644
> > > --- a/drivers/net/pse-pd/tps23881.c
> > > +++ b/drivers/net/pse-pd/tps23881.c
> > > @@ -6,16 +6,16 @@
> > >   */
> > > =20
> > >  #include <linux/bitfield.h>
> > >  #include <linux/delay.h>
> > >  #include <linux/firmware.h>
> > > +#include <linux/gpio/consumer.h>
> > >  #include <linux/i2c.h>
> > >  #include <linux/module.h>
> > >  #include <linux/of.h>
> > >  #include <linux/platform_device.h>
> > >  #include <linux/pse-pd/pse.h>
> > > -
> >=20
> > No need to remove space here.
>=20
> Sorry about this, somehow I missed this gratuitous diff
>=20
> >=20
> > >  #define TPS23881_MAX_CHANS 8
> > > =20
> > >  #define TPS23881_REG_PW_STATUS	0x10
> > >  #define TPS23881_REG_OP_MODE	0x12
> > >  #define TPS23881_OP_MODE_SEMIAUTO	0xaaaa
> > > @@ -735,10 +735,11 @@ static int tps23881_flash_sram_fw(struct i2c_cl=
ient *client)
> > > =20
> > >  static int tps23881_i2c_probe(struct i2c_client *client)
> > >  {
> > >  	struct device *dev =3D &client->dev;
> > >  	struct tps23881_priv *priv;
> > > +	struct gpio_desc *reset;
> > >  	int ret;
> > >  	u8 val;
> > > =20
> > >  	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C)) {
> > >  		dev_err(dev, "i2c check functionality failed\n");
> > > @@ -747,10 +748,20 @@ static int tps23881_i2c_probe(struct i2c_client=
 *client)
> > > =20
> > >  	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
> > >  	if (!priv)
> > >  		return -ENOMEM;
> > > =20
> > > +	reset =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HIGH);
> > > +	if (IS_ERR(reset))
> > > +		return dev_err_probe(&client->dev, PTR_ERR(reset), "Failed to get =
reset GPIO\n");
> > > +
> > > +	if (reset) {
> > > +		usleep_range(1000, 10000);
> > > +		gpiod_set_value_cansleep(reset, 0); /* De-assert reset */
> > > +		usleep_range(1000, 10000);
> >=20
> > According to the datasheet, page 13:
> > https://www.ti.com/lit/ds/symlink/tps23880.pdf
> >=20
> > Minimal reset time is 5 microseconds and the delay after power on reset=
 should
> > be at least 20 milliseconds. Both sleep values should be corrected.
>=20
> Sounds reasonable, I'll change the first delay to be closer to the 5us
> minimum reset time.  I need to review the docs around delays to pick the
> correct one for this case.
>=20
> For the 2nd delay, I (now) see the 20ms you're referring to in the datash=
eet.
>=20
> I was looking at the SRAM programming document
> (https://www.ti.com/lit/pdf/SLVAE1) and it indicates we should delay the

Sorry, this is the wrong link.  Let me try again:

https://www.ti.com/lit/pdf/slvae12


> SRAM and parity programming by at least 50ms after initial power on.
>=20
> Should we guarantee we meet that 50ms requirement with the 2nd delay or
> would you prefer I just meet the 20ms requirement in the datasheet?
>=20
> >=20
> > Regards,
> > Oleksij
> > --=20
> > Pengutronix e.K.                           |                           =
  |
> > Steuerwalder Str. 21                       | http://www.pengutronix.de/=
  |
> > 31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0  =
  |
> > Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-555=
5 |
>=20
> Thanks again for the review!
>=20
> Cheers,
> Kyle=


Return-Path: <netdev+bounces-114328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F8F94225D
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 23:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD5DD1F238AE
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 21:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D636F18DF8A;
	Tue, 30 Jul 2024 21:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="NE0vMIHQ"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2051.outbound.protection.outlook.com [40.107.20.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE6921AA3EF
	for <netdev@vger.kernel.org>; Tue, 30 Jul 2024 21:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722376378; cv=fail; b=fq0FtK+thh946bHj6nrjqdT5yX5oh9x3Lf7+YLMJmtzncoZikuLK2mDXs2d7aUTvkOOnEvXtwlVGODVVr/fCUOWR1czu3ba0F9XTsURau+ANqHV86eNMA/hSZomlrW/AQCFCSC5iEvOS4yFtAgpf8mEUTTzKvRE7HUgh7vM0V0A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722376378; c=relaxed/simple;
	bh=icbk2g8n6ZJL+CV8ZcxhIgx0VSIYiIQwvCM4B274S7A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=blNdqaQZvWqDsc29ZOObASN0jjQBgq2PWYkG+BsRu6+6sMIRnmm2FpS2Gog1gp+7aqR9aI2mAqB4uCyeIG1TtH3/YrtUa2aXwHjmSBQfdFUjJmYedUe4LPVibryzk+EDJQMtZEf+zFnK+auySlD9hGxSLyDM2Osz7fznXNgiRZo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=NE0vMIHQ; arc=fail smtp.client-ip=40.107.20.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oYfh6hnEpT1ES1WQU7+sV3OD+z0IwO80h37UMuphl44OzzETRHxAGj60/cDZMKisXAM13bHs4xO0ASNP8ueEHwTHjX3VXD+OFLVFeScK4FsGQqbISiKa6C9kN5BbHNVIeUmIPzrv+0et4fraBV1Xc1P5Ua2Z0j6E10RG89qf9oo48qLVoP4EQBNMTCY67ReE+0nfwYfDtVtrRbt44f1NifGa/JWvNygrWa27NVGjqxVCpQ/vSoM/4+uK/N8i2bcFB5B6t9hu9VLPlit7mfHtxQ+MwGJMB3nYyZ3brrb/GyedTQMdHSK+wokEanOqCHmG8CtBiBtcjPIOuMWzK0iv7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4ET/kPLLYFXCQ0idTP0ZKKGIT2AAhhnfQIzKjbpQ/W0=;
 b=uiJCAq8ay67jTqSeUbdoni5x9fhrFOktxseepnhCUNgQhn5it9HDVuTFhUwHvx00t7bdTQO+3r9s0fOVepsKnAgg0XF+3Z5Magq3sim8as2Wkt0YK67hVzz+detqYZccRvFVWMFG7p1LIWG0ygq5wRgD2p34T2/iWfsv3kKHbND8vvY9kk+H32Wu2L8N6prajbAmeXiEx3sjZfLDuy5OFJUvChZYTdJJbZY+XfguR/3SM18E4EnOr6kmYSWtDaNPL8gyaRvWhQlhoG39eVhHULwOWcYfiLEarKCTw05NQy/NTax8EH+q0T0m5NbG28wED7V0HLgb0l8bzIbpkkicKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4ET/kPLLYFXCQ0idTP0ZKKGIT2AAhhnfQIzKjbpQ/W0=;
 b=NE0vMIHQGLBPsGe0HhSGteQpCC0hD+oeGy3yOsHQ62fTWPVUr+4kpBBA1BBJK8SxgMZn2Ncd6rOCi5mqb59WPbpwZC/Jk5o5m9IC1EhBme1VCAiJa9412+kDpa9P9giHoFz+rhMVH+64D11mIAAQ1lT9VbtxhKtPkvli68YSNOc=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by GVXP189MB2750.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:1fe::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.21; Tue, 30 Jul
 2024 21:52:51 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.7828.016; Tue, 30 Jul 2024
 21:52:49 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
CC: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net-next] net: pse-pd: tps23881: Fix the device ID check
Thread-Topic: [PATCH net-next] net: pse-pd: tps23881: Fix the device ID check
Thread-Index: AQHa4psWZOlh+SNemkOo5ar/c6pbhrIPcu8AgABddQA=
Date: Tue, 30 Jul 2024 21:52:49 +0000
Message-ID: <ZqlgU4AsUmfldJTM@p620>
References: <20240730161032.3616000-1-kyle.swenson@est.tech>
 <20240730181812.5fc002fb@windsurf>
In-Reply-To: <20240730181812.5fc002fb@windsurf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|GVXP189MB2750:EE_
x-ms-office365-filtering-correlation-id: 861b8ff6-ccf6-455d-a279-08dcb0e1f46b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?C8Ce0tpUokuBK0mKSwSUkD2ucyAi7o9Tm8lIk4blzLphBulNrWtEyxVKl7cE?=
 =?us-ascii?Q?9jjR9o5s+JTKGu6XFcbZba9+B3hWIszDngadVH2ak/KalxkB1rCyuLwk6D9i?=
 =?us-ascii?Q?C8xmFUANpkyf45wN5ehFvGC/wz2NDAeDj5Ve9yDoTN/kTZ86eZ8z4GnrUk4M?=
 =?us-ascii?Q?laiSdWBPLd6aKs26NSMxFFc764YOweesoepxermTIFp/3OWs3yacfoe7PEg0?=
 =?us-ascii?Q?GTpzEsjaUI5pnH/dwAe/wLq744HTEe6u0Kof2vyul8fQzGdk5Nr9sTwsWgOv?=
 =?us-ascii?Q?C9R34os5Hrx9DJaaOVoyOfQJIEWjCm2p07SlkNJqzlMYW7JWvlOqbPpLLIjo?=
 =?us-ascii?Q?/RsYVS5/Y379M9hXhcdaYwW9ENCY4mPxsdL5KdgLqkEgGmqXQHgOUDdMmuRC?=
 =?us-ascii?Q?F5HtTuncLFzaeu3WG2DJ4mKx0WB2GDr3ByIKjuLgV+EX7IM+eoGGvSFoDvBZ?=
 =?us-ascii?Q?OYcYfD7EEn1cArvySz9KuoEKnRjl0MaT+nzCq+22foycHbeRgRHg/QeiDR37?=
 =?us-ascii?Q?clD/Pzq6g00SKjBcBY5+34ISi5fAVzrk09KWWEoGPB46QYusC69BeBZ407nO?=
 =?us-ascii?Q?wqabHV2UtOmEBifO8/VTAAh+RPREWLSQld2VjoqOizf0l/MJsks5MWc4L+5/?=
 =?us-ascii?Q?f2j9Ks7er+gP6l7m0ANzQC8CF1K5n0etoNc/Ff7zsCUCmATuI44LPdOCmNjZ?=
 =?us-ascii?Q?pUX7bV9/E85EEzuPcrLhZNLtAn07hqBb9UYJ/cpLeKwkEqsvYHDYNVIPD2BK?=
 =?us-ascii?Q?jMcPH9KYph+bKHVewaega5CP+GwO6QMSjbD6bjfrPhqd1N1ftmk5SXlGS3l7?=
 =?us-ascii?Q?rRwqVhprkKiWwn0lOhTIV9Psjcf66kRlt6gk4bbvXJkh2vhzxk6kDAfnWPVE?=
 =?us-ascii?Q?WlvqoWwSyY7KAsHut8s4pXp3KHlu44QUYDQ3iPHBnkuiarsMa8In68rNm6rq?=
 =?us-ascii?Q?2mj4vmcsmcDI3u+u3bBUIKwO0H+DZjCRKMF//QzgPmOTSKOcFEM7bwUKXxKb?=
 =?us-ascii?Q?IKG5G/c0PS/0qX4kln/2JHzHTgChGKjqk+GPY30rdeanRAmddOWqUSxy2kmA?=
 =?us-ascii?Q?C4T10Ka5SnZKELmDhIg4j8Ink4AGQeGlvoaAVzAyV7X0vLLfLWu9Ce4v/C1h?=
 =?us-ascii?Q?YtF/a2fuopLFjKaqMj+u1wJCRCn8U8e2J+dviTMZsl3MYCgbNRRHJgLSiDx1?=
 =?us-ascii?Q?b3OffC6l4JJZ6gUS4REovZFK13pSXlNWwJXJF4PY9o0oWEQ4ufelVbVBftsD?=
 =?us-ascii?Q?SWZPKbEIQknCiZePLXKYrE9be5frdYMsuTbduFnQnbYIQs8upi7WBYoPYgqt?=
 =?us-ascii?Q?Uspa4cIuohH9+E7xbPO9DTO0bUw7KwgzpM14G2jJ9oSkxwuszgLipHvGlyVs?=
 =?us-ascii?Q?4PQQZlg=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?hLMkoagsWBCzM8xYWLbPcJiQN/e8BJEP2iSO7BkqozTAOdUIvzs/GNJr7UUQ?=
 =?us-ascii?Q?Fy20tpDfBUVnjpZX+UcNtHWDpdZGqKMim/naKCJGpsH+BKG2kStXOfM9An/K?=
 =?us-ascii?Q?xuBKRhJV2YK45YBqxAUVxC5pUUWuKyDdU8iGteSxmc/RZ3sCTUysEdRfDinM?=
 =?us-ascii?Q?whtJs/1a2AJ9uhHZ3i99kYJwdWhwN6itFSEeUmfqrjmFDqTMAs+m9E9/v9UA?=
 =?us-ascii?Q?hEveRhTLiWx8AbtcGGVMTaqVAbU6fe0ezuX/gBwBFa2sCda3bkAeH6NBQ2mh?=
 =?us-ascii?Q?vRU3ubaW4Sj5SRoMDrYNCx0Q/av0T4AhThz+wUQh/pLbp6Ejexmx1TsiQGgu?=
 =?us-ascii?Q?9sK8DuUJb3F7pNRJZTgOMvCvrnqxEDA5f69ywvcWEMnWbyrZcJZO3jEd4e7o?=
 =?us-ascii?Q?LBBEK32RmFqQUH8/sAIAU4dWLWBAfYAUQkec2rJ1xD0jF3KNHE8pbMSUnQWs?=
 =?us-ascii?Q?FFJKEUY93HpczrI/JnzZl0JAig3YGW1P7ElK6bKhzOK9KW2LI1avmTPu8kIQ?=
 =?us-ascii?Q?8j6O/ifU61Fpdt1Rl/fLsSOkgmaI4D7sSGHxfxs0Q/e67k9MwqCiyK6O+5Uq?=
 =?us-ascii?Q?FnmiytjJ5B6PMQ7W5e/V5K/R8V8hMCVaSZekZfcNY8g7CBkmW3xnBbRDaI1D?=
 =?us-ascii?Q?HUS+aNiIYVX+5PZc0LbvyH21tREJNZg+L1OUa7Lw8LhOWGfxeXcdwd+9cXm/?=
 =?us-ascii?Q?+f6vDBMAjq4NVY5pM9MbmZu9YDtCpCluqP8AatNSY/ULI+YLEOMzjWiH4hCE?=
 =?us-ascii?Q?7YwbT+CiUkafE0DsqP0Rjq14YZSYW+/7CmIjyFJuovkJpUHri1Kv/JFe/zhG?=
 =?us-ascii?Q?5qpDWKwOzEJOH5m6GzRyrAzOh5hT52k+UCH1owe2NkxETLGhpit0BAtGFlbt?=
 =?us-ascii?Q?DhOWHGcHkhDNIySOmJUV7jS9jW7ui8q/QF5CbYzVP66XJhybKkCeFzp+u5jq?=
 =?us-ascii?Q?4PeMEsh9m7u3chMHvaZeVmTEWI3Hi7bw9Zkb2AJ2bu1dH1OIArKh1a93ssiv?=
 =?us-ascii?Q?Gz7JVcRV+11eMqXf00rqlzNszbLgJXjd8fuHLQ86Egb66Q6odi+JDOWlEDl+?=
 =?us-ascii?Q?M/Q3k0sBLQuYcLuHg2I30GjAie3YABQNhBJtNU+lvzoE9+CB2p8yRQBQ8NR8?=
 =?us-ascii?Q?VUV+fW86ugxSL+sRIPO2o2bUn2z10f7Ty+BS4bHbXc6y7MLxwgskE0t2tLyk?=
 =?us-ascii?Q?8TY18JSnwCgRBxEnF4FEypFZHjRpUpIw8HCvxQAb9fDBiITueYZO2qE8v7My?=
 =?us-ascii?Q?cRkLMO5VYbs4b+U+q+jd2x+PqZiRViO4z5l0s0yRRh+iZDwMEzNCZTu+Dd8K?=
 =?us-ascii?Q?kROmVWmcos9aClcDn4A8yzllyAURe0qbDlshdr2oZSAOiy/A1rS76xxyFtAe?=
 =?us-ascii?Q?EiA17ACeBdAevKv09fg1FJKkmOsy9WpedHWBn6VBpln3QWSwx8Or7rnwDkaA?=
 =?us-ascii?Q?2EXxMIBl7ZuL76nYpAPfZ3aPrKUH7YgGb5aSmX8ZkhLC+4mdglJo+CCHrlNN?=
 =?us-ascii?Q?UcDYgqVMfifIbbZykjMCquSblFm3yRa6XReZy88GxQaYekcjO/i1wI/1IqQh?=
 =?us-ascii?Q?fngfneBWHIY9pBrqww12FumzH6tvGlS1QsEaRy9kR0kJfN4+inpfn8jM7ptn?=
 =?us-ascii?Q?tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <AB20800419439349989B682440D5F79F@EURP189.PROD.OUTLOOK.COM>
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 861b8ff6-ccf6-455d-a279-08dcb0e1f46b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jul 2024 21:52:49.4394
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: REBkLnTDcMR5qBkBoQS+MUjGKfh2pUAwkESalqgU2yvwYHMLjSOPDV0FtbLoLh2G9UuZBxNR4l25irKzB3sBLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP189MB2750

Hello Thomas,

On Tue, Jul 30, 2024 at 06:18:12PM +0200, Thomas Petazzoni wrote:
> Hello Kyle,
>=20
> On Tue, 30 Jul 2024 16:11:08 +0000
> Kyle Swenson <kyle.swenson@est.tech> wrote:
>=20
> > The DEVID register contains two pieces of information: the device ID in
> > the upper nibble, and the silicon revision number in the lower nibble.
> > The driver should work fine with any silicon revision, so let's mask
> > that out in the device ID check.
> >=20
> > Fixes: 20e6d190ffe1 ("net: pse-pd: Add TI TPS23881 PSE controller drive=
r")
> > Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>
> > ---
> >  drivers/net/pse-pd/tps23881.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >=20
> > diff --git a/drivers/net/pse-pd/tps23881.c b/drivers/net/pse-pd/tps2388=
1.c
> > index 61f6ad9c1934..bff8402fb382 100644
> > --- a/drivers/net/pse-pd/tps23881.c
> > +++ b/drivers/net/pse-pd/tps23881.c
> > @@ -748,11 +748,11 @@ static int tps23881_i2c_probe(struct i2c_client *=
client)
> > =20
> >  	ret =3D i2c_smbus_read_byte_data(client, TPS23881_REG_DEVID);
> >  	if (ret < 0)
> >  		return ret;
> > =20
> > -	if (ret !=3D 0x22) {
> > +	if ((ret & 0xF0) !=3D 0x20) {
>=20
> Thanks for the patch! I believe it would make sense to use defines
> here. At least for 0xF0, and perhaps for 0x20 as well.
>=20
> Maybe:
>=20
> #define TPS23881_REG_DEVID      		0x43
> #define TPS23881_REG_DEVID_DEVID_MASK		0xF0
> #define TPS23881_REG_DEVID_DEVID_VAL		0x2

Ah, yes, I agree.  I'll make the changes and send out a V2 tomorrow.

>=20
> and then:
>=20
> 	if (FIELD_GET(TPS23881_REG_DEVID_DEVID_MASK, ret) !=3D=20
>             TPS23881_REG_DEVID_DEVID_VAL)
>=20
> (totally untested, of course)
>=20
> Best regards,
>=20
> Thomas
> --=20
> Thomas Petazzoni, co-owner and CEO, Bootlin
> Embedded Linux and Kernel engineering and training
> https://bootlin.com

Thanks so much for the review!

Cheers,
Kyle=


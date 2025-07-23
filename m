Return-Path: <netdev+bounces-209174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEC50B0E88E
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 04:25:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E30A3547798
	for <lists+netdev@lfdr.de>; Wed, 23 Jul 2025 02:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1B851C860C;
	Wed, 23 Jul 2025 02:25:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="mMEKOexk"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2052.outbound.protection.outlook.com [40.107.220.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3AA2E36E7;
	Wed, 23 Jul 2025 02:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753237532; cv=fail; b=Dx4RMjDls2zu4+oHJqgw3tly1KM1PetI9wixpJMz3hrPInwXMP6sOGrVMBDJoMr5kyMtChLHM6sn7PsbaPH+AAQFkOUH0zko4YBblPflzXDJLYtCnqR4Pa6oTKxIPgm0dzGqt0KzR9V/yYTzOQFzlYUyA5ksV51dn84/4s0gaZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753237532; c=relaxed/simple;
	bh=0XV1OY/gpFJZG7Ut22EIW/4cCd5CSsf6Tlil/IPdpXI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DlHe1pBsus/TGtvzuRvdKkjBSv153SjE038YUGtZ5K9y6PkDpIH4MFjYXNM888VnEFF6+DiPqTZnJ9vKTJh4qziPvccyVrzz0ay8xFU+U6xQxPTOvSexDVonFYJEqNPj0ozv+ZITGE4T+d1cNdMQJDIoQ/yN+dgBouop3kLO2Ds=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=mMEKOexk; arc=fail smtp.client-ip=40.107.220.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dsImF3hGZ2P25eoKrfOGQkdraeSQPRVQSSXqtfT1lR/1yh2yuYjnb9dOnYSOwol0hcT6Rf4SCfKJHySKuJ9incFB2frMQzRRTKJ95tpKHDxkjU2zMaP0HAv/237/v75ShbnkL9Gl9J7gGgBD9PbuFF+9Y/dsR76SMj7JTruFmrAIIQoBsi0fy/4Pu6zyDZyZo4V9igpEUW92bGechqPuL/g4K8a5kz7bXB8iqpFqR0BNRq+/S9fgN4MbzBIMIkWudL+RDmg40poav0aL08oGf27RYfanaXvs3OIbh0hJlSUmFGfPblEfwYhARFe84jSGdz0gEmgrrfkibjrkDZgEzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F495ZKmZb8y99p9mlwxcmnMo9aSUIMC88tDRoac/4b8=;
 b=bP7EDnWXmOJl4/ZHkAk2kXnstrD6hF5Q1NZ3730VrNEyQ255CdPdBqocLsJrJg9JP+hIdf9xpo1g2Bigx3NyBx7PkyCgElxr4HV8RuEzcmkqzIEKF67jyEyVfRGQ3THSUeZi9vwqzHVxmJTjRPBK+4W6ErZboxLEY+ZgaIrVZGjJhosbFTPQhQjycYCoJ8mrkL/JDa/Y4FRM1FUpjGMq2z+6O5cytv6whb44PSS8K/t8P6XlpcizDQnQ0G2nBIFV0NdMxhe2HYvOrY/p3LwgjHAEKhPTD5kBqybawzcHWIAs8eqlJLfSkC+B4OVL2PopqGhlQfX3MRFt85bEufAAkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F495ZKmZb8y99p9mlwxcmnMo9aSUIMC88tDRoac/4b8=;
 b=mMEKOexk2+s18ZALfK6xifnfOhmB6yBfJqRewMA+IEsQxyfb4SPHfO6UwotVbBNtix8YBS2Fjei/Z+DLInP5N4D8DPxFjZMtL++S41jalsmT4H0KuuSV5yTHYErTTO5jB3qF7paPayUpqx5iJcw15gBvoBY5SyQ/j3Wql/HjhidhzzJHmda62l9b25W8hMWcIJ+DCNozyrK3+8TGVr7Et1Se9eSfnAxygaXm7XPBYEsXgiJyHLGWZDqOscCdQGblObegJK2zKYuwdk6nVUhsZMAA8UO3DDxHiKQoJQBkr979M8ucD2R0TswAEdoRB2s2bzoa72oUg6c27ZQQPju90w==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 DM3PPF90FB92BE6.namprd11.prod.outlook.com (2603:10b6:f:fc00::f38) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8964.21; Wed, 23 Jul
 2025 02:25:28 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%5]) with mapi id 15.20.8901.028; Wed, 23 Jul 2025
 02:25:27 +0000
From: <Tristram.Ha@microchip.com>
To: <horms@kernel.org>
CC: <Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<kuba@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <maxime.chevallier@bootlin.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v4 4/7] net: dsa: microchip: Use different
 registers for KSZ8463
Thread-Topic: [PATCH net-next v4 4/7] net: dsa: microchip: Use different
 registers for KSZ8463
Thread-Index: AQHb+Et23Zt1PEXlIkK/NsvHKZPcN7Q6zkiAgAABfwCABDF2wA==
Date: Wed, 23 Jul 2025 02:25:27 +0000
Message-ID:
 <DM3PR11MB873641FBBF2A79E787F13877EC5FA@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250719012106.257968-1-Tristram.Ha@microchip.com>
 <20250719012106.257968-5-Tristram.Ha@microchip.com>
 <20250720101703.GQ2459@horms.kernel.org>
 <20250720102224.GR2459@horms.kernel.org>
In-Reply-To: <20250720102224.GR2459@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|DM3PPF90FB92BE6:EE_
x-ms-office365-filtering-correlation-id: 0e5cb253-41f9-4866-afb8-08ddc9903003
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CdjwevTkT/PmROwAPjSnYpXhO3PvNIL+PxM3musTqyLUXpftlsQeY26MBI+v?=
 =?us-ascii?Q?kow6Zo65pk/DIGMJzNUx+e2K562fpt7TP9ruKPFDETtje6T9UpH+uhy35reX?=
 =?us-ascii?Q?sNZJlIvGJUDoCO9lDTJ0kotSqTO8QEzNuM5KYD/Iazb6hNlYUQkO17wM1I3A?=
 =?us-ascii?Q?/3UZxaeWKUb3E8A+X3I3AjVa52zL2fYB52F7BgB7AGZnRkuwHnryIZy4KRfZ?=
 =?us-ascii?Q?F1+9erKYZlFQknHm3nlwwH2buQewhFaG6aI8m1DEhYeivjhIj8M1r6Bs5uhb?=
 =?us-ascii?Q?nQ/EHzXcjLBEcSmuMwgsBV8PBwYOLV0f/dwxANAM2VTstVOLD/R4WvAlte5p?=
 =?us-ascii?Q?Ergp4csjhhDqEcrzh+BR6ICdcch+Wqo66r3AUzjKL9hfpNQuze0xXAPg/KIh?=
 =?us-ascii?Q?OG8HrPOgQxn19lJdBgHQReQlTLvrEK5UnBCWE0KlFtiKGcUelQM6wCkKlRZv?=
 =?us-ascii?Q?lS69D7l/iAixnUPWX28L3nvQiVSNgNEpgPkSBbE22xwO6M2mwAuWaU155ek3?=
 =?us-ascii?Q?EpdJ0trKuen6KM6fAo899hTerk7Zxo/I6DKxy4aY+Uvqi0co8phoTiFwHMPg?=
 =?us-ascii?Q?HK6P2lXDXxFUUaagnMFculbMPn3inpeGRSh0+5pjQl3q4q0sLZaS/04xUON/?=
 =?us-ascii?Q?poCnmSJZ/EpIctf+QSguiX76exGfJ5bsSExUckA4eXBodDg5NZUHOCg7moV7?=
 =?us-ascii?Q?9+rgifjCrqXS6eud6CSduiRCXDnkK1IiKB88NhT1I5zQ9PiweJd2lR+yn8Ne?=
 =?us-ascii?Q?R/m5GXUv3crBJJFV5UNCCF+9eCZ4slYZOz4QEfDWp67W/Ozo+Z+GPGHdRcqI?=
 =?us-ascii?Q?AWJ4fiVPpQMZFdLvdCameq0QqIgdRegPz+nk3wr1g0E9HdXwe6ze6f0iTf2M?=
 =?us-ascii?Q?Rdw/fYmHit2N8MXDYoZ1JxJx19Yh3FB+I4+TRS9otxcwrFCeRbA3piMS752L?=
 =?us-ascii?Q?ZMITgh4Jqj4CGZqfU+cF/wx2K1mVQynA/0/sjvzxHUni9TM5VSiOJqf0LOoV?=
 =?us-ascii?Q?KTykY5F3C5OtrK2w1h9AqoDlE7BKYm0QCii2cz0R8zi8vQxoca/CybFMj8lK?=
 =?us-ascii?Q?+LzDR3JQF32C42KiUIB5Jtfko4E6Qfo0YnGd89LWNcnoEeDRfFnElIdRb1D9?=
 =?us-ascii?Q?8IybeBB3tI2DBUkFd8POASuIUHumiNCYwmf2vqxC7LthNq3XxjMKa0vTLNkh?=
 =?us-ascii?Q?ts7AuZV3sLp9LAoyQvCEN08tRs07XOdPMQA1AfacuNn1nPufBUrKju0I3XX8?=
 =?us-ascii?Q?lYO/F7dHFLcph2AvwytkUz78JlRNN/xvlElqiUC6sqcY8IvLFQ13GMLskasD?=
 =?us-ascii?Q?EUgK7lmmgQ0DuC/Nx/tEPYA3wbxZs29l8yJcp5+w12gEIKoq+oRclvOQkt81?=
 =?us-ascii?Q?xlNfbu3u96filu1Bnwx9lf6vTxeDk/rYQsDmAHDoL3mJtuBU8E9Qhd4lnwZO?=
 =?us-ascii?Q?qiA8jHZowiRJy8gUx6CPASo4fvTD9FnQbCSHf9Xp44KTlPS3wODsMQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Heou61FNX5EwuehyB+++BT5YGFGEYLUQhBYfLYZYT8KC2gZymoRFqjcWdIma?=
 =?us-ascii?Q?wc8p1YbECCjiGfxid2vHZNzsW/zTBeUp08nlumShsamCF3Ym72n+GmK+vzfv?=
 =?us-ascii?Q?f1b1xvjohTZ4OxvmSBK0ZovfmtdhWEm47jQkuiEJARh7WxhhZDFKaYkYq1uw?=
 =?us-ascii?Q?y5z8EltXftA7SJMY7L5w3nGQ2QvFG9soBa59AQekoWrIb/8H8MkwTnlHFO0h?=
 =?us-ascii?Q?TFx8wjnUs/4a3QNoff9xDxYMtNsTLoH+NjCBfG69Rleq+vWRiUMioyJaTPEA?=
 =?us-ascii?Q?vj4UAfSKKexUuluJFa3iEsyF6Z5JQjRVIoM11ObYHTPmS+jw6zWEuWjWYa2R?=
 =?us-ascii?Q?n1rY9hBNdxJ0uLsrEemzcv0XZnk0sEz9Etce3A3+qch1FHgiiXeHI0vBRIT7?=
 =?us-ascii?Q?JlulvFoB7nHkEk6ufROznkoB8G0RF5EvYt1VoRewizkMUatjh6WtSQasVikD?=
 =?us-ascii?Q?cqSs3YS+vJaggTVWH1JemzTzC01n7OCeyGL1QkAD+ceseUU9DJQQfLMeQLc/?=
 =?us-ascii?Q?ijkthc8IGrzWtYqMcBKRwZ89HH3TP+ic1qHz1vz92HNx6pB4dZ3xQLKzYHCd?=
 =?us-ascii?Q?vIttWkr/n5nv2zpqTNfYJ/gX5I+EM+CQLiYJA9XqjcDh6fsPMmqAPwNRmcGx?=
 =?us-ascii?Q?rjIDZ/3xDip40rYMxIOj2l1RWbly9GilC5SEpFDhGI0VMJCgNX8eJ9Bb3DkK?=
 =?us-ascii?Q?hWlz2ZNnbWuJXpcCgKS41HgWAgwIyIvWZz0/uFXnQ7Gr1dW50p5cYwNW19W5?=
 =?us-ascii?Q?b1p8t3WNueYk+5HyS0Fn6CGjbe5eFvYeUXtVjWRG2FJfXG6U53p5WCosBtpu?=
 =?us-ascii?Q?D/P3xUhjl2Bm12pCDx+WDJmFCrCLfYheji22qrp62xwrLgwBtZk6eGcODZ1X?=
 =?us-ascii?Q?3gT4fzTboalbWFHvX4IJxoQgM8XDXPOjComQ02DvO+fBRARkIZ63qXvsMdgp?=
 =?us-ascii?Q?T+PT7xzMyIhtMvWc3nn1y/0p4mpo2aEoaaW7Mh6E2mwzwngMRQlXHY8yVAos?=
 =?us-ascii?Q?SgWuoaSc6Mr/GyoqQYnt94WIRLJ4LU+cCCC3hZKtjMEXfwmFuQEBK4OMpD5f?=
 =?us-ascii?Q?l+ofH3naSMqPyYkRejYAikxg24qYyCVE44XKbqUzc9PwAZJJaMF5ehxGHNl5?=
 =?us-ascii?Q?CbhtTEikEmAjYcSPxCgQRyk1dBfiDXSXLz828og2uJgAHnoUSGXt9rj8Wwbn?=
 =?us-ascii?Q?XJQt6E/dcLD9fFHbnZVAOeKg2WGIhq64QeVr83G6G2M+/JJA8hwvH8uMOH1x?=
 =?us-ascii?Q?WU3NI2+eyR3PZFeCg1US1vJ4tizofSYtez1hsgzPoU6wvrLE5XCbpEeRt5JK?=
 =?us-ascii?Q?iY/b+oa1SZRDjhxwn3D3oMaVM8KCeFpZwQVCfzpzDTycc3pcrKkwEzjcl/dO?=
 =?us-ascii?Q?g45HoEiP2UmPFkZFsDVqzJ6Dvq7sLAce/ojWS40C9NTlsoMbWdEtYI0z30ok?=
 =?us-ascii?Q?v9o3vdl/T19ujihxdwLDMCGUFUiyCPEcW0U/s7mWAxyqi55ms2gqkPM0dyqG?=
 =?us-ascii?Q?BXiyI6XF6MJkedz7O//N+BRdMvGIiXHnCkmjAbohFpe+EIzfTn9Azze4zptx?=
 =?us-ascii?Q?/NTM4xA2ZKIxw2wCjIAy7p8GhH0l6HJTp+hWP8gu?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5cb253-41f9-4866-afb8-08ddc9903003
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jul 2025 02:25:27.4175
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GCWbn38pBrDhpW/L/jvzwuQ+Drqr6y8x+GDzW7ZJer4RQmHyKo4Munw2jnGpvCXUJiK1mWYMHpjSDF+Fa0D+OHaxPHZHRdq7vpw5xIszt7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PPF90FB92BE6

> On Sun, Jul 20, 2025 at 11:17:03AM +0100, Simon Horman wrote:
> > On Fri, Jul 18, 2025 at 06:21:03PM -0700, Tristram.Ha@microchip.com wro=
te:
> > > From: Tristram Ha <tristram.ha@microchip.com>
> > >
> > > KSZ8463 does not use same set of registers as KSZ8863 so it is necess=
ary
> > > to change some registers when using KSZ8463.
> > >
> > > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > > ---
> > > v3
> > > - Replace cpu_to_be16() with swab16() to avoid compiler warning
> >
> > ...
> >
> > > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c
> >
> > ...
> >
> > > @@ -2980,10 +2981,15 @@ static int ksz_setup(struct dsa_switch *ds)
> > >     }
> > >
> > >     /* set broadcast storm protection 10% rate */
> > > -   regmap_update_bits(ksz_regmap_16(dev), regs[S_BROADCAST_CTRL],
> > > -                      BROADCAST_STORM_RATE,
> > > -                      (BROADCAST_STORM_VALUE *
> > > -                      BROADCAST_STORM_PROT_RATE) / 100);
> > > +   storm_mask =3D BROADCAST_STORM_RATE;
> > > +   storm_rate =3D (BROADCAST_STORM_VALUE *
> BROADCAST_STORM_PROT_RATE) / 100;
> > > +   if (ksz_is_ksz8463(dev)) {
> > > +           storm_mask =3D swab16(storm_mask);
> > > +           storm_rate =3D swab16(storm_rate);
> > > +   }
> > > +   regmap_update_bits(ksz_regmap_16(dev),
> > > +                      reg16(dev, regs[S_BROADCAST_CTRL]),
> > > +                      storm_mask, storm_rate);
> >
> > Hi Tristram,
> >
> > I am confused by the use of swab16() here.
> >
> > Let us say that we are running on a little endian host (likely).
> > Then the effect of this is to pass big endian values to regmap_update_b=
its().
> >
> > But if we are running on a big endian host, the opposite will be true:
> > little endian values will be passed to regmap_update_bits().
> >
> >
> > Looking at KSZ_REGMAP_ENTRY() I see:
> >
> > #define KSZ_REGMAP_ENTRY(width, swp, regbits, regpad, regalign)        =
 \
> >         {                                                              =
 \
> >               ...
> >                 .reg_format_endian =3D REGMAP_ENDIAN_BIG,              =
   \
> >                 .val_format_endian =3D REGMAP_ENDIAN_BIG               =
   \
> >         }
>=20
> Update; I now see this in another patch of the series:
>=20
> +#define KSZ8463_REGMAP_ENTRY(width, swp, regbits, regpad, regalign)    \
> +       {                                                               \
>                 ...
> +               .reg_format_endian =3D REGMAP_ENDIAN_BIG,                =
 \
> +               .val_format_endian =3D REGMAP_ENDIAN_LITTLE              =
 \
> +       }
>=20
> Which I understand to mean that the hardware is expecting little endian
> values. But still, my concerns raised in my previous email of this
> thread remain.
>=20
> And I have a question: does this chip use little endian register values
> whereas other chips used big endian register values?
>=20
> >
> > Which based on a skimming the regmap code implies to me that
> > regmap_update_bits() should be passed host byte order values
> > which regmap will convert to big endian when writing out
> > these values.
> >
> > It is unclear to me why changing the byte order of storm_mask
> > and storm_rate is needed here. But it does seem clear that
> > it will lead to inconsistent results on big endian and little
> > endian hosts.

The broadcast storm value 0x7ff is stored in registers 6 and 7 in KSZ8863
where register 6 holds the 0x7 part while register 7 holds the 0xff part.
In KSZ8463 register 6 is defined as 16-bit where the 0x7 part is held in
lower byte and the 0xff part is held in higher byte.  It is necessary to
swap the bytes when the value is passed to the 16-bit write function.

All other KSZ switches use 8-bit access with automatic address increase
so a write to register 0 with value 0x12345678 means 0=3D0x12, 1=3D0x34,
2=3D0x56, and 3=3D0x78.



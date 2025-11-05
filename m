Return-Path: <netdev+bounces-235683-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CC5C33B5F
	for <lists+netdev@lfdr.de>; Wed, 05 Nov 2025 02:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6534461596
	for <lists+netdev@lfdr.de>; Wed,  5 Nov 2025 01:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDB431CAA65;
	Wed,  5 Nov 2025 01:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="AZr+klPD"
X-Original-To: netdev@vger.kernel.org
Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010069.outbound.protection.outlook.com [52.101.201.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15ECE1C84BD;
	Wed,  5 Nov 2025 01:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.69
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762307582; cv=fail; b=NzE7uouEermo6myS984o08oJjvzXFFQbK+tepvt1XGxr4ExDM2e/iSIekHSG+yJYZDMvetWHhaWNbgLgRugZkYGfUCGZXbkTeI88MAX3fbBxu9lLC6ATgcg7FIPCtbkCTG1vwVhhncGIAMmzwwoLdpLIxhVGjM1Edl9qdVX+P2o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762307582; c=relaxed/simple;
	bh=hbSZAqD7AiGSwYlm5hPaEndqVF/vyvwpdzAUkAQVjRU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=L1G/y/muGPYrVnT1ZUSinKojdd3Th6AKoi1fz73HZJjyNAwXg7L1PH8OlSXuu/HVChj/Yix3fmYvo63IxNPeDJvlYBvE7yyqvoqzeG+g5QAyYsw+tBRSMBpqOBGEeRNZ2TmXsGccqtDbb5Uw+ugxGWYp5a+Jy6bZK6izmYPN4Ww=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=AZr+klPD; arc=fail smtp.client-ip=52.101.201.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=odCz1rVFpuQkTLqSyH1n2h+W9IcSsngEKjdA7ruk5c9RUT+8i9M4Ts+i1uTdx6Z0fG3DzT/skfaroOgLthdM4lnHKoaFCo3GhK3ssM12t58wrzerljomxFiYHalWwNC3GFzjU/ZMuBN2HWyDTuCLX/mBrcYo7+mPsi5OhRjoKVgUdh1h4TM1Kv8pqo8FAo/bUKxdpJQebJdDhO4STa+jgyMRfJTfWh9FnnVqQOfuCd2Cj23aplytocITDtz8LqEUFWN2lUqUWWIqTou5vK5iDGGyDpegxK+hXjDHjzvVfh74S0IoNOABZSz5Vy2Ir2om1jJFQad/ZyUyJYwY4cSYAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sR0dO82EU9+cinDtIshK9zUI/rmMDq7I03jvY5SeoCQ=;
 b=toGjbD9d4U32P5+KBRNFN1cJyvio/s9/jfY/UVA3Ofw4RQHb6Wa+VDcGRlCzDlcG0t3m18oxQbKm0AzMFtnF8Ny2qwPdJlkYp3Lu6CqHBx/ZTYG2XRRAISLnxstCRUMt7wAET/A/fjN534C9kY7K+KoUe5S61huATZUKYjm5dziPK9Tqa77oG61DAG+TKVANY7r2HmOlgY/RBw+eJj0w0/SzcCADgLD2WsPDSX/PBateLENJECKkNXc9z42uGK0WRNsw83lXUZaaaocT5VytKjnmyVUPHOW7u5uSbA8ZqnNxANDX0YJjZ9PaSj45UkcIq+d4ShxtuGS1IORbnb2LoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sR0dO82EU9+cinDtIshK9zUI/rmMDq7I03jvY5SeoCQ=;
 b=AZr+klPDntLww0dmGBWqv0/VcdjZOiqhd8G2scXz8zHBgJ7/n9BlK3kBsq/3ivvCpXAN6ydsonowwZDmWddpaFPlI7Q3SiAMk/2s7XGx+GQqa1udCji/KhT6Q7R1LtLchGORTGdBaE7Pdhje+cryhbcMzr955KsnoF9z1/CLXEzhWQAn8deriH9XwbIjP8Q5sBJ/9wK16Ol3f7kLBd7U759YrhysBRFTsrHi9cGlF48yvEJwTFJAxVsAY0hBJOXsXxzZXGUZ+29H/Gc8GqLJ3dAbQZsvm6/inEySzPr3Kqji6NWK6Gld64wOykkiTptHp0Au3ZWCvzqXgqXH46mw8A==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 IA1PR11MB6122.namprd11.prod.outlook.com (2603:10b6:208:3ee::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.14; Wed, 5 Nov
 2025 01:52:57 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%4]) with mapi id 15.20.9298.006; Wed, 5 Nov 2025
 01:52:57 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <Woojung.Huh@microchip.com>, <Arun.Ramadoss@microchip.com>,
	<olteanv@gmail.com>, <linux@rempel-privat.de>, <lukma@nabladev.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: dsa: microchip: Fix reserved multicast address
 table programming
Thread-Topic: [PATCH net] net: dsa: microchip: Fix reserved multicast address
 table programming
Thread-Index: AQHcStGGZyry6uUAY0iu2/zpEINAj7TfhZ0AgAPP7/A=
Date: Wed, 5 Nov 2025 01:52:57 +0000
Message-ID:
 <DM3PR11MB87369A57A48FA097DA7A5A74ECC5A@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20251101014803.49842-1-Tristram.Ha@microchip.com>
 <9f8e7666-d78b-418d-b660-82af4d79983e@lunn.ch>
In-Reply-To: <9f8e7666-d78b-418d-b660-82af4d79983e@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|IA1PR11MB6122:EE_
x-ms-office365-filtering-correlation-id: 4c8971e4-f307-4912-ba08-08de1c0e0afe
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?iso-8859-2?Q?Ga/KZxEpZDGPgXB/qhJ8CeGgSocKngFEHtWJqd+/mpKIM6Irz6o4V9pEkJ?=
 =?iso-8859-2?Q?31FarAzzuhzFzb0s8Lo27jMPYIDD1U78vKdAxtfL9Bj72cM8dwFf72MnIz?=
 =?iso-8859-2?Q?NK1P4dcLxNVC+/VYyC+52AE62Luy6Ob2ZfFvZwSeLBo5EYXlzeJYF6yOZ5?=
 =?iso-8859-2?Q?hgkm7FsJDW0HLL/FGKtom0d539Is0DJBGukZmPUxpfZE2qkWmaHQfSIgtF?=
 =?iso-8859-2?Q?wQRkbhedT0qdpKrWzP8Hezz2H0bEePLb6e0DyuAel8mKB5cY0euNVyUCdV?=
 =?iso-8859-2?Q?48bbuvE+SMiOTk+CmYw/avtLyZktNRulDA7Gh2I28nt2V/aneJyYo6plPI?=
 =?iso-8859-2?Q?9guHV8l0p1mWq8nKyrW5qf7lfxKlwx+QGehjEGza5WvJQPvG6blCA6vnkn?=
 =?iso-8859-2?Q?WeAMkNlCQRvjLG9f/oHVEw3xYJR0P5IeWVYT2DQw7IxM1ke7snk8tGCkpR?=
 =?iso-8859-2?Q?nGQ53Q/DtUpOVvhM+2SUM9uedo9XD2ktNoWgjKuDko5n9XEXNees3mMaQD?=
 =?iso-8859-2?Q?QYvetFWhuJpzZWXcveQLfD7AXq2TPlOETJ9njYDiSn3jo/JjPq709G5zIj?=
 =?iso-8859-2?Q?78HYTg62EobQngnUctacx7x/K8ZTIXGu+pFjXKe87cFb0+9jUai31A1E5e?=
 =?iso-8859-2?Q?/J0h9xalXuOd/Gcy/+jc3kIb/0QIuLOYvZAesLKMdqhWjV+t5ndtc6p/q8?=
 =?iso-8859-2?Q?4Rg6gYbYYDv12PbNVPg/48DcWwP8iffST5vimSKDnl2CjO9G7fSQxqi0Mr?=
 =?iso-8859-2?Q?eCCHLhfWEQ+66oQfLlXm9JH5Qxn0Xxm7OVVfLmxM+1DTJgE978Z9jIA53c?=
 =?iso-8859-2?Q?fPU+ZqQA3CVLr/nyVe0g50xa9/AeQf8jdkqqFbX7syI6iMa56/6pw3BBk3?=
 =?iso-8859-2?Q?HpVZ5kJIJGZyTao2ueutOlkAcNNppqWRcIXqUCPmrJIqmmqyaiRRwLH36i?=
 =?iso-8859-2?Q?4ElMKwNV4uLgZGfOgAUr0Sn5h8TxGBB5wRnwNKIu0a5l4PIgbGun5zjB5y?=
 =?iso-8859-2?Q?Cr2GWN+upRKTm9UUPSkpcLAcU9JHsvdNA7L4i6lSdC1iJd/nSqebVNF+rp?=
 =?iso-8859-2?Q?TgpXiz/5LX50NkPCtPRxpvdQGa1q68MQbiNvLxLWyiVv4U2yyp/imQQOwv?=
 =?iso-8859-2?Q?ioW13xSzz+VA/Ab9/GIeUgl03SXYTy1wzA0J6SI5ZIbhgA3g44O4xN+rB5?=
 =?iso-8859-2?Q?75pNp8tFO1JdqezRQYxPO4vhxMPdddVC6WWg/B4LrBSwiyxXpdgD5kSZ+B?=
 =?iso-8859-2?Q?LYm8wg1KweLoLyK8zD09tmyMXEo0PWaS7CjBQLAJ3KiAnLAdfFL2kul2g7?=
 =?iso-8859-2?Q?RqTqfluVBgpYY7g7PYKnLxLZAnuedcdzvnIA4TC2bmGxwhZJp0YCO2bLfK?=
 =?iso-8859-2?Q?DvBkWQDqCtJF3k9eob8/o8P7StXrVWOj8+JibaMZeAAswAVfMrAOWgoXBt?=
 =?iso-8859-2?Q?Z0FIZ+GNH+DUxAieWiejhCIs1hc0CPCyPn+txkRllTUfO3FXD6epCL5neT?=
 =?iso-8859-2?Q?NSVVET7opJZF9cJtxeA25bkPVSWIx/ZhvLyk7bj30vDB0FhZZt9sKew2pL?=
 =?iso-8859-2?Q?ULKXMKw9+8ReFS1qf1NljxF5efm6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-2?Q?JBAKj2rNh5FMjdAJKzUjeqvQ1e7gxO+D/n2oF5gHKbSD3Ah0TlDljMnIB4?=
 =?iso-8859-2?Q?JTJcQ9uI2hqr/y8ZGpJ9j5YnypFudhl9NupytQ8pGvsJYNyqer98Bq6Siu?=
 =?iso-8859-2?Q?5fwybXexKs3DBf/FjgnGGccJzTdZgSHF2x2c1dFywZQcPA/aY7IfDNjp3z?=
 =?iso-8859-2?Q?uEWumMaVQH4EgEZqEIAv3dHzzdIXSViOCjgR0ckGktlW5B4vMVeGXvjm21?=
 =?iso-8859-2?Q?oZRlQQF1rxt0KVnREq3vvtRerpyM5LpbZgoyv+JIEgYrLpDde+qVF2H/wO?=
 =?iso-8859-2?Q?lfHnNrwS2Gdf41gjN2RfhbOwfZi18f0Zk1R2O9xK6K5HZT6zU1kc5N3fWO?=
 =?iso-8859-2?Q?BdkvUUW1qjDFKlpTz0VpjDi+vq/yj4I+uuzP8Uf/xaYjjiwhz6SIG4a3Mp?=
 =?iso-8859-2?Q?/P8KQWqNJrNZEDsqPiCwaC3VEcnJiPHl8j9NamZZiauTxQL7UkTwFSPoBG?=
 =?iso-8859-2?Q?083Bc6Q5MmcqEp8RHaXBaFlrZXzstr5tuLci7HljOOeQAdB8XXASh0Qpgf?=
 =?iso-8859-2?Q?uSDMhPHfTTpQugwD4cizoIBTT9pjXa5iEB3BCjsowoOX7rwsaM2pYLar6n?=
 =?iso-8859-2?Q?JT6wD0iT+Fa0RjwLSpbBjoz71ZJb7qsm6tUx1IGYuG6QzwreO0rloPlZBY?=
 =?iso-8859-2?Q?PYKgzv2B5Om3ucPL9tPmlj2yuMZhJJcIrYuoNoPMQhn0IvxM7F9wFcRN1r?=
 =?iso-8859-2?Q?Nz3fWt0KW6BNOIVOriDqqcqgl3moU4isY9exp0IuLnjq7LHcdChfEEHV3M?=
 =?iso-8859-2?Q?qbMaCR7jQUWqw0V2CMe/pBHI6uVaJlBHXvrqGTWrhg36kO4Iamz0JY6FvQ?=
 =?iso-8859-2?Q?+iYHThsWEpevI6S2+y632bzfRl3n+FZhfp3hxiOainOuSnkAqqg/5qwv4A?=
 =?iso-8859-2?Q?iDWRBZ70VKMm6ODjBt8iw6PxIdvjAL04DbGofcCUcpbgaVS0/QQT/KbYL+?=
 =?iso-8859-2?Q?0RGvWDe7/7l34GldovIEz3KZdxAdHJ10L1G86Z2ZI2T8vnle52xtgq7nid?=
 =?iso-8859-2?Q?H5vUGM+xxuRoPIBC9iSk5U1V3TZyR6HmGfaEJqj92ICkcpe/b/Gr25/IUX?=
 =?iso-8859-2?Q?/ynTw5VyrgLijwYkEWoNsg4KLLox8pFMOCC+GBfoZMib8y6B/ssVsnLFCo?=
 =?iso-8859-2?Q?vpjR6LTXYrFdJZqfrRRIU4tNCKWRqBZAyJ10Cd1dnhHiMfxcdyjRUTAG7A?=
 =?iso-8859-2?Q?BokSwxMHOt/FEBqdbVI5QSJNbLzxOaS+w7gwaBGs2CNC9kHNErIwwXJmeR?=
 =?iso-8859-2?Q?ZyjXBakJ4N6EJZ/KpsY2WlQTwNWRafg2W/9P0Pv81V8uY04WcojgwaMiyK?=
 =?iso-8859-2?Q?WO9F9yKKSTA88hI7tS05Bl12W4ulyg1laPAIwCyJF/lJRO75J+B0+uJSe9?=
 =?iso-8859-2?Q?XzQEQobBlVlwnvtgFLP+ksDN+IuX0usRWk0e7j11I4O7Z7YZIGyhegnJQp?=
 =?iso-8859-2?Q?tuDcubl68tmQKVdF0N48/cnEqK4PR/6nkr7OPHQKanu1P7Yv5y+2rzgBKy?=
 =?iso-8859-2?Q?jHR+L2o18nM7Yi62lR6zVwESZnK3JpwffZN6u1h0T3NZayxaVI/kaPdFT3?=
 =?iso-8859-2?Q?79yRMx1nC3wYaNgHRujDQvrCSrVk3UBZa9Ju68MppDpGGd1dDhNewORkBS?=
 =?iso-8859-2?Q?23ww7DitAfa42T9KmK5hxHVFLlBHx0CPNt?=
Content-Type: text/plain; charset="iso-8859-2"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c8971e4-f307-4912-ba08-08de1c0e0afe
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2025 01:52:57.2480
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sXx3yp/kqmgeJ3+bXk/V5lYbgOqN7vXjtqEhOyDQQA5KHtMYk/2pBdS16CqVylRxtcPDVNc6UT5Chv9fjIo0M4RYahb+FZDJVNV2W5CpaFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6122

> Subject: Re: [PATCH net] net: dsa: microchip: Fix reserved multicast addr=
ess table
> programming
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content
> is safe
>=20
> > +     /* The reserved multicast address table has 8 entries.  Each entr=
y has
> > +      * a default value of which port to forward.  It is assumed the h=
ost
> > +      * port is the last port in most of the switches, but that is not=
 the
> > +      * case for KSZ9477 or maybe KSZ9897.  For LAN937X family the def=
ault
> > +      * port is port 5, the first RGMII port.  It is okay for LAN9370,=
 a
> > +      * 5-port switch, but may not be correct for the other 8-port
> > +      * versions.  It is necessary to update the whole table to forwar=
d to
> > +      * the right ports.
> > +      * Furthermore PTP messages can use a reserved multicast address =
and
> > +      * the host will not receive them if this table is not correct.
> > +      */
> > +     def_port =3D BIT(dev->info->port_cnt - 1);
> > +     if (is_lan937x(dev))
> > +             def_port =3D BIT(4);
>=20
> Why not just def_port =3D dsa_cpu_ports(ds)?
>=20
> The aim here is to send frames to the CPU. You then don't need the
> comment about different switch versions.
>=20

There are 8 entries in the reserved multicast address table to support
multiple multicast addresses.  They look like this for 7-port switch:

0=3D0x40
1=3D0x00
2=3D0x40
3=3D0x7F
4=3D0x3F
5=3D0x3F
6=3D0x40
7=3D0x3F

For 3-port switch:

0=3D0x04
1=3D0x00
2=3D0x04
3=3D0x07
4=3D0x03
5=3D0x03
6=3D0x04
7=3D0x03

When the host port is not the expected last port like in KSZ9477 then
some entries in the table need to be updated like the ones with 0x40 and
0x3F port forwarding.

The design of LAN937X is a little bit different in that all host port
candidates are in the middle.  The first RGMII port starts at 5, probably
because there is a 5-port version.

0=3D0x10
1=3D0x00
2=3D0x10
3=3D0xFF
4=3D0xEF
5=3D0xEF
6=3D0x10
7=3D0xEF

So when the host port is port 6 or port 4 then the table needs to be
changed like this:

0=3D0x20
1=3D0x00
2=3D0x20
3=3D0xFF
4=3D0xDF
5=3D0xDF
6=3D0x20
7=3D0xDF

The code is to check each entry and only update it if it is necessary.

On the other hand software knows what the final mapping should be and
can just write the required entries.

> > +     for (i =3D 0; i < 8; i++) {
>=20
> Please replace the 8 with a #define.
>=20
> > +             if (ports =3D=3D def_port) {
> > +                     /* Change the host port. */
> > +                     update =3D BIT(dev->cpu_port);
> > +
> > +                     /* The host port is correct so no need to update =
the
> > +                      * the whole table but the first entry still need=
s to
> > +                      * set the Override bit for STP.
> > +                      */
> > +                     if (update =3D=3D def_port && i =3D=3D 0)
> > +                             ports =3D 0;
> > +             } else if (ports =3D=3D 0) {
> > +                     /* No change to entry. */
> > +                     update =3D 0;
> > +             } else if (ports =3D=3D (all_ports & ~def_port)) {
> > +                     /* This entry does not forward to host port.  But=
 if
> > +                      * the host needs to process protocols like MVRP =
and
> > +                      * MMRP the host port needs to be set.
> > +                      */
> > +                     update =3D ports & ~BIT(dev->cpu_port);
> > +                     update |=3D def_port;
> > +             } else {
> > +                     /* No change to entry. */
> > +                     update =3D ports;
> > +             }
> > +             if (update !=3D ports) {
> > +                     data &=3D ~dev->port_mask;
> > +                     data |=3D update;
> > +                     /* Set Override bit for STP in the first entry. *=
/
> > +                     if (i =3D=3D 0)
> > +                             data |=3D ALU_V_OVERRIDE;
>=20
> You have already made this comparison once before. Maybe
>=20
>         update |=3D ALU_V_OVERRIDE
>=20
> higher up?

The first entry is used for STP, so the override bit needs to be set
regardless the host port is same or not as the host needs to receive
BPDU even when the port receive is turned off.

The six entry is responsible for multiple multicast addresses including
01:80:C2:00:00:0E, which is used for Layer 2 Pdelay PTP messages.  The
override bit also needs to be set as it is required to receive such PTP
messages even though the port is closed.  This change will be updated in
next patch.



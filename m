Return-Path: <netdev+bounces-125788-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CAE096E96E
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 07:46:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1834B1F239B4
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 05:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73F13A3F4;
	Fri,  6 Sep 2024 05:45:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Jrz7QMzA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2054.outbound.protection.outlook.com [40.107.93.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 743D13A1C4;
	Fri,  6 Sep 2024 05:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725601556; cv=fail; b=J0C95HY0rQxP5I8lfSgqfRsASY6hW2pEZh78bhALUqUcZA22boHw2K7Bw9Ecv5hgf9fOSX2AMhFdn9DQBPepQSEdV3f/hGqK2CGXLtiaUKT9t7vUCBdVRHRe9RfCXN9ArC/oj2ndi1puU5WN4UTRBrUxn/TUTgoY1DVWA88wHDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725601556; c=relaxed/simple;
	bh=5Bn0emdlEGHVTL12Hrr3QtlVeYVz45vLQzzmBmEKs2U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nQaKsn5EMbs/Y6pIbzmPJE/LYWJWNlNf3zNODI0j9d3kiYs6HIQtH5crI8Tk8PeE+m+niJXs7f18++gGIS8VyT6+UI96Ev/UZoJMnaTs/ZHAoBD7WbTDaLQ94LExhUBurHw3rnFRdrbziYwlqiXoP4cNmMnWA02/D//vYnZdLtM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Jrz7QMzA; arc=fail smtp.client-ip=40.107.93.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKVnYUplkoRR4skA1e/9O5H9Gs5y2dyWTvizNzW6Oq/cnaakvAyYfqc114JAzBHQhrI8MJlYkLPHgCKb8ZpZsmGc6wzBoU1bsBCE2dx2vontn8LGWO4NDr5Sjdq+Wdy47NEV6iKFFWLpoZQQ6HdVfK2utYjRmSqKEzxgGqwK+X7KCO2Z5CEUwhOcTs1uiFMbFtDdwwuyqwAT8RI5K883tGDTh9wdlWZRqxD/Ri0BDHXy1OlhYMDQbUnD98YwRRBG0W1twfDaPDKASeULb7RPKIm35xa1iv9sJ5bt1LZaaJDGZpXO9bL9WPD4q1shplDzm+qW60eYEe2NzdDuN/Udzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LR5rGEI/Sjm8dzaeoBjm50TETz8lqEbC3OR/gJYPqXM=;
 b=FNXbyAFGTCY+gtQmM+xHFA4S7CObBazc8RHUgCWEi6X/3ZjQBaalChedqOtL6p9AAUZP1iYM4sE7RwYcazOHphdo68oNzxiAbNEcTzXOB8D7WAp5pvfxZA0PEKARpVl5acyxv3hMGLVfxchRE83JX+t3xXc5s4RWMcPdAv9GXMjhKCICcwhc3tOVC3N8ogIibEVfeok7Y/2LagIQyy5S7gBp09ZV7Zac9g7bfODmHoS/ix2VLFQBbIUhdYObCba7LJHG77r4xyxD198a1o1N1J9Kwhd39IFJe7Nzrk7s7P4BQmolFdI+jMX/tTdWvqu0g+UABGErtJtNwGnBsJJ2hA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LR5rGEI/Sjm8dzaeoBjm50TETz8lqEbC3OR/gJYPqXM=;
 b=Jrz7QMzArusXaofrZqkDrRbhaCNQNzlpGfGP/oDthYznA5Q3CyvW+ml7phlixEZb8z+YHPVzd4cZHmxGz/0fFbZJzqWgxKGIrSFFx1cwxhgWKEQzErnAP/d0ia8GUAWxVgbXmbg/Bhfn718+MtTWWkxT1Ub8k5cGQTFB1L5P0ReZFKr6Vfm/+YAzMbFfS47tE8XagXiYGK+TkQ9m9y2HjVhIAR3auac0jQ1oKc7dv+DVIV+jY3/amaD+MTM2MnpH8x8Ni8LVERMid5mkD2/A8mFYK5JtGy518fpI0T09oFDNdd6Xf2a8ECJaeF46JiwWY12KkC1OHbPt/uv0BmtC9A==
Received: from DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) by
 PH0PR11MB5109.namprd11.prod.outlook.com (2603:10b6:510:3e::11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7918.27; Fri, 6 Sep 2024 05:45:48 +0000
Received: from DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5]) by DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5%3]) with mapi id 15.20.7918.024; Fri, 6 Sep 2024
 05:45:48 +0000
From: <Tarun.Alle@microchip.com>
To: <andrew@lunn.ch>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: phy: microchip_t1: SQI support for LAN887x
Thread-Topic: [PATCH net-next] net: phy: microchip_t1: SQI support for LAN887x
Thread-Index: AQHa/rWByazDEsACsk+UoLsvK/nR0LJJI7UAgAEMJqA=
Date: Fri, 6 Sep 2024 05:45:48 +0000
Message-ID:
 <DM4PR11MB623922B7FE567372AB617CA88B9E2@DM4PR11MB6239.namprd11.prod.outlook.com>
References: <20240904102606.136874-1-tarun.alle@microchip.com>
 <dba796b1-bb59-4d90-b592-1d56e3fba758@lunn.ch>
In-Reply-To: <dba796b1-bb59-4d90-b592-1d56e3fba758@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6239:EE_|PH0PR11MB5109:EE_
x-ms-office365-filtering-correlation-id: 5bb2ebf2-ecac-4033-12e9-08dcce3728c3
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6239.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7JLZHNtr5xITi7RNFznLfkRqW+16L2hiptIllIkAaEYM+rEALttVad8EbzXs?=
 =?us-ascii?Q?bbj0qvHrAgcN3B8r8SCvQAHWiQqz1P/NJzIgWeTyZMj8EHyxDccLz4iw+Bih?=
 =?us-ascii?Q?AiTDemj/XJraZg/yauBsSE8Lk+NIQzCpu+mqLGXWfRP0r67eMtzCpS5LWaSi?=
 =?us-ascii?Q?Izd5NR9Omh0MKZfGLb8fBeY200z8YDBU5p2keXtrjFbqtPqBcB+33r1bht4t?=
 =?us-ascii?Q?DS3/RzeFuJVmpGhk5nwCbgdW9E/aYEF4jdN9id9fRy+ns9SeAJVeEIMjRyIR?=
 =?us-ascii?Q?lwVQPRUKT1LrVEKMmS+fda91ucMItCQOfoK14/IceOnGNZ+j74zn9cGDp+0X?=
 =?us-ascii?Q?gKWkqCORMxS42nwEEFagfxhfBib+eVbaF0iH0ui/sti9batbbc5HlnxkhaW5?=
 =?us-ascii?Q?L8hf9tXcongTinAhu7+IjsrJbUDswfoHlt8hFPJ6hw4+3KwreDelWabWTfpp?=
 =?us-ascii?Q?ijG22dcn+9N3BWGsmg9JXiE4i+Vx5EvwKg6qaEeRgIlz/UsJ3zz/IC4uDrg9?=
 =?us-ascii?Q?k8NrRnPQkoxj5LBUoljfOFNiDZTBfGZKQgUKD8Zpkr1mHZL5MO3L2w1vb+I/?=
 =?us-ascii?Q?m8d9AML1wOhFCme0KajV86tIInRKICpYYEHJ6taAQ6A8kiokG2aIrIH31cpz?=
 =?us-ascii?Q?nkcweFkDWSeyg24dnFgMKWC3RdyiuOgP1mN5iNl271i2lOHggVUVd0VXx58H?=
 =?us-ascii?Q?FZYrpQLM3nWx9OWKOnv9G/dSC27Q3SuHrR4dTGkbIzPJMGeH12YBYz7YFuJ7?=
 =?us-ascii?Q?SWrOFGKdE2WP3YKkYbXo1OUvravYo8bhz3gtIOd0yvFjwtNbc0QhY1DqZLOU?=
 =?us-ascii?Q?Vb1qfWC6ix2b7zcyJGRrhd4JvSTe1mDpGBGx+xMr8OwqUOMSYBLpM3liYdPz?=
 =?us-ascii?Q?6grznmR8SDX0QUqusha4yjCOY+fnZV0JNcDy1AXjgrXPq9vHdyRflQmnNjTB?=
 =?us-ascii?Q?zVx3+Bbo3riM2DAXnB8K+be4eiocqset+pi0+9c4gXEIhq2P6S6cBauypzL2?=
 =?us-ascii?Q?mZ/rgpyAgUJAefMaaJ/tjcNEO43EbAZV2aNbCexPYoDhqsnDLlOkuTnYlSJo?=
 =?us-ascii?Q?omN32/TqKlZzMBPhb7+y00lP6290usCzxWo3NJPS2ytOjSCIduymbItztmiP?=
 =?us-ascii?Q?WdeMYYjmU6TgnWroJgwrQQ9UPV7TH1+2kNsjn2XXQcuA0nPd8iMS/cXm2lmI?=
 =?us-ascii?Q?6ORS3eqcmFe2BSlhEMBrtvE9s5C3DI8TKtC0PFeDQY50HjbsrjrGzDMg7W1S?=
 =?us-ascii?Q?OLqJ9m/k5soHZj0tdm0Is4S8f3KuEBmhk3mKxb4FuNeKeMiIgJsEBynwXIJ7?=
 =?us-ascii?Q?f4vh9Pdub2ho+Hk9G1Mgq0LLQRQhuUWdXKtTJFLPPNQVqLkMm9PLq7VXQiLh?=
 =?us-ascii?Q?HtvUG3rXh3uk8zQflQi+VMvBkUlKUm3wYd7e7hvoTNx4zftGPQ=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?zWE9bRkSTmsPqUjpvV/zUqX8PhBegTzf8Ou6aQD9msxswEoibd3xj0e/pJ3a?=
 =?us-ascii?Q?bqWej74vNUJFzzWsb0DklCiBJNzRQkgjOyw0uVB4A3LYQsAurRMZWb/vC5Bi?=
 =?us-ascii?Q?4jcHniuGy25opjSEP8TEBi43mwPLf+dy+BV7ssIZpI7D/okCirgy14rG4Pot?=
 =?us-ascii?Q?+2N3o+ytXeyuC5b3xqTWZxWQPxQ3jTgXJjXakrENrvQGYiGikX41lKu9ePYu?=
 =?us-ascii?Q?hdPtFhNDm/QmRuinyS2DhJA/fQ+PUc1Y/xXgolU3uIjG4QAgvoYTA8SJryzT?=
 =?us-ascii?Q?UoiwAqsRxkpOCCL8lLPiDtwEVg42qCmboF8sXClhrszakXPYJWxk+hH1sIUX?=
 =?us-ascii?Q?G4KMtB6VmrW3ywihD5BNs8FiVsz1IOe+HifwNAIHxChwA5g6fNJYzmiJNTfE?=
 =?us-ascii?Q?SP3nu66sGkZlQB4SyP2Q7Ao+NsTGE7ZyXmBvI+ULB80oqHqV+PsleH0lKLDS?=
 =?us-ascii?Q?ItXC2PgoJb3S221ghfCrYTFn/melqSU+CGK2NcJn+R8UxYHaF7YTViJWoURn?=
 =?us-ascii?Q?wGHByvDTOOwrX67NR5H7WlJz48LMA1+c63wy6xouF4CinGFWYRByLZPFD1dM?=
 =?us-ascii?Q?q11MJstO22iFEAtWeCSp+IiEJCNlLmmBfbC9piHLKDeoOdlpDhculFGk8eSm?=
 =?us-ascii?Q?SAeAGhMxHxlqbUhopoiifho0KBJcjDC/w1+2XtziUsCwB4OnWVbWjwDL8jdJ?=
 =?us-ascii?Q?z6YctU0T2CPRUqv+uL21BVlBYf4JipYrnwT46ubh+IvldaQX9TjQyEmYSwpY?=
 =?us-ascii?Q?mfyEPqVcZ7zJdOF+crvkOrYAYUAfKIFxqcUGgi0n00nXHH4SOhT5n3Z+VFFA?=
 =?us-ascii?Q?qdqFa+hRCpadBX6zO01vEV9pufw4pv6htjr5nxu8X/vOWlv9Tu79QOrp71eQ?=
 =?us-ascii?Q?D45qVyTtPlmjOYjcl6IvBBOLPJCuNeTjsukrpeI4YOW2dPTY/yNISX5CFlH4?=
 =?us-ascii?Q?uTKCUJVbwVY0TEqo4R+G7eNPlr/fCZqMlhEgtoVSYsviTJJ+Wphzqdxa0ego?=
 =?us-ascii?Q?OfAZM+TFy6HdcdNZFlND2uSSscyYplUub4+IU5Guf4lVp+GtOKSpaEOHSObZ?=
 =?us-ascii?Q?PxL8tFKhnghDI76Lp0nxHEEJsFNSl6fhUH9UXM896nS3mpVktMHlsYxtA9hj?=
 =?us-ascii?Q?ttRnSzTdQSarFXtX2XcbtJxg4OuJ5YG9Ug5R0NGdEUgKDrw6wyqzvpJFrXOA?=
 =?us-ascii?Q?vGokeLBanWY4J563gtLVngYcrD8gI5ToBlt4L1K2OTCcxfpsZbAmSq0o7qSu?=
 =?us-ascii?Q?uBqZz5uO4UvsuLuFDIG+0J8DNXWKMPMy19HpuzhTvpx+Wh6u4WCbLgSKz4AD?=
 =?us-ascii?Q?+8JfvVf324KpcDVPDep+kz5CIaeOwtAD6B53yPsh4MoPrBcoNMR6Z6IkLWS2?=
 =?us-ascii?Q?e7OQagnmjfh5TISsFdr1N/+To7lPTg3/DF8qMNcuG7UkX4OWUTlPUCUsKBv/?=
 =?us-ascii?Q?VLw0l1BS1GF6HmdXjAW+oyjlvX+HRS3x45GlA4OYRkoq/V4r+lGA2SsP/YKF?=
 =?us-ascii?Q?ZO8WDX2Db8M+o7WzrIW1AgBDZeWlIxbLs/x2jLDq4VejQcd29pQVLte5IzgP?=
 =?us-ascii?Q?V+Bo9ol8GhkehOr3x7xlmtKj6GVMuOEIYRoOGZn6?=
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
X-MS-Exchange-CrossTenant-AuthSource: DM4PR11MB6239.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb2ebf2-ecac-4033-12e9-08dcce3728c3
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Sep 2024 05:45:48.1657
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JKXkk3DS+GNaThQx2XpmVAKw6vSlPNb2cHxBFdvrdla3PaxNMoaHRam8e5aEDuFf/FOj7zqgR4yYjAoU4ACEka11TX1k+mOMRyWqZFoiVzQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5109

Hi Andrew,
Thanks for the review comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Thursday, September 5, 2024 6:09 PM
> To: Tarun Alle - I68638 <Tarun.Alle@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net-next] net: phy: microchip_t1: SQI support for LAN=
887x
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > +     /* Get 200 SQI raw readings */
> > +     for (int i =3D 0; i < 200; i++) {
>=20
> Please replace all the hard coded 200 with ARRAY_SIZE(rawtable). That mak=
es it
> easier to tune the size of the table without causing buffer overrun bugs.
>=20

Will fix in next version.

> > +             rc =3D phy_write_mmd(phydev, MDIO_MMD_VEND1,
> > +                                LAN887X_POKE_PEEK_100,
> > +                                LAN887X_POKE_PEEK_100_EN);
> > +             if (rc < 0)
> > +                     return rc;
> > +
> > +             rc =3D phy_read_mmd(phydev, MDIO_MMD_VEND1,
> > +                               LAN887X_SQI_MSE_100);
> > +             if (rc < 0)
> > +                     return rc;
> > +
> > +             rawtable[i] =3D rc;
> > +             rc =3D genphy_c45_read_link(phydev);
> > +             if (rc < 0)
> > +                     return rc;
> > +
> > +             if (!phydev->link)
> > +                     return -ENETDOWN;
> > +     }
>=20
> How long does this take?
>=20

~76ms

> genphy_c45_read_link() takes a few MDIO transaction, plus the two you see
> here. So maybe 1000 MDIO bus transactions? Which could be
> 3000-4000 if it needs to use C45 over C22.
>=20
> Do you have any data on the accuracy, with say 10, 20, 40, 80, 160 sample=
s?
>

Here number of samples are suggested by our compliance test data.
There is an APP Note regarding SQI samples and calculations.
No, the number of samples are only 200 as any other count was not
consistent in terms of accuracy.
=20
> Can the genphy_c45_read_link() be moved out of the loop? If the link is l=
ost, is the
> sample totally random, or does it have a well defined value? Looking at t=
he link
> status every iteration, rather than before and after collecting the sampl=
es, you are
> trying to protect against the link going down and back up again. If it is=
 taking a
> couple of seconds to collect all the samples, i suppose that is possible,=
 but if its
> 50ms, do you really have to worry?
>=20


Sampling data is random. If the link is down at any point during
the data sampling we are discarding the entire set.
If we check the link status before and after the data collection, there cou=
ld
be an invalidate SQI derivation in very worst-case scenario.

Just to improve instead of register read can I change it to use phydev->lin=
k variable?
This link variable is update by PHY state machine.

> > +static int lan887x_get_sqi(struct phy_device *phydev) {
> > +     int rc, val;
> > +
> > +     if (phydev->speed !=3D SPEED_1000 &&
> > +         phydev->speed !=3D SPEED_100) {
> > +             return -EINVAL;
> > +     }
>=20
> Can that happen? Does the PHY support SPEED_10? Or are you trying to prot=
ect
> against SPEED_UNKOWN because the link is down? ENETDOWN might be more
> appropriate that EINVAL.
>

LAN887x supports SPEED_100 and SPEED_1000 only. This condition is to=20
address the unknow speed. Will fix the error code in next version.
=20
>         Andrew

Thanks,
Tarun Alle.


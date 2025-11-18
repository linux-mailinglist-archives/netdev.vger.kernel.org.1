Return-Path: <netdev+bounces-239350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAB3C67165
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 04:05:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 85C5F2961A
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7F031B114;
	Tue, 18 Nov 2025 03:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mZziv3ib"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011052.outbound.protection.outlook.com [52.101.70.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F2972FE04A;
	Tue, 18 Nov 2025 03:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763435097; cv=fail; b=pKqZpv9fWXdfb9PgagdL11veTY3z5jcW3R3xVAuGDG/5xa1BEZtnEZPT4MNzF4CG4h7WWC7d1aqyZ3fNh7tUM5eLXaDDCupU3HBosB57Jp5J4U7fTHQnCT6IM0oMqTBX3LCDU4YBo4sCr8vm9/zjHmBnaE4h2AuLpVzzYQLwxok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763435097; c=relaxed/simple;
	bh=Q9nTydXXqDc3GpZQFpBKWn4iEMKHD9wA4ELtJHDLrS4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BTPlb3uYsI9Sl+Nyw3nA8s/s73UzZB4TYlQmhmnK7lHiIviCQYB6fk8RlIO+LmmM6nYhKKWOpUNMmFzKYUBYOgqHQrtxu/LhSp3x0/FdG3jRGvYIUCA6c6ju6WntUIrXdlGG3pLnyfHGLSPMeIFBXbrragiZ+0t/VCYxtIA+x40=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mZziv3ib; arc=fail smtp.client-ip=52.101.70.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WOENKOeSvM3Zn57zoLue0gOYGT//OH8F02ud9Y71HixzSrRXybXtrUona8k8tJYSK6+C9js8vG5HM9ygfvanmXwDD3fefrB2XnOTjX8VfT0dmfVZsl6wPQxZhFHGX8Mnb106oEG+kH15F3xz3DP3eK2iBA3TNPwef3pw0LHup9YFOzavsmzCtMLPR204o/erp68lvcazoaYECZE8HWVuZ9xPvscsxZXlt/N0VS2qm7Jq5Hg3g2jt2nD7HXFcCdhOFgSAiAeR82IIXyA29rcvqmEF6Hwq3AUCWljEnEx9Lj2khq6L5sCI6Aj9kHbtsjJcqRt30iyM0I9GejVazngUCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8YLB6Ms/N0bKRzsJExJXaWhxU299nUFjMp/rD724Meg=;
 b=AOZItL+NnRcCZNIf8Xu4zhGQuKxRVKLjdRDpXKHXZGbaAeEh7TOsdkYftn7Q1ULmmYD/bzt3dTU0T/+qRHDD2cGKJ0PwzI0gzRLAozVcDQXaa/K322uNs0GyvSfipAQIDL54SbuERCoKYbXiGcIVfq4P6j0PH0UGgwaZ4aC0yd9eJit6hUaHZNQr7O8M2HkSIQxOrgIf9KPD7jQdEpw5p0ghGa5TbOiaOWxRC8RVvt0IoRHd7H6qEuK+zQT2mFIuCz8vvgKTF64c7V83mHq0ASh9BdWh5SLHAQ14fTGf40nIXqCCEikWsoHArPFT5lmiXaFa04Bu1woOnTW8uAprzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8YLB6Ms/N0bKRzsJExJXaWhxU299nUFjMp/rD724Meg=;
 b=mZziv3ibtbzjtY4MhXFBE45OWoOKj7YxrWr6HE+2i21+6ssFOMlcRYOrGLgVKAdmvHEdJG3PZyP3mYkH9P+jsbM5sXZJZFYkgZxMDntawhkTOiep+Q3E8tSusMsJDQdsOFbEHagckL0i1VZ5UOu4NmQ5LTWH0gs33vM3OPpdpMFIx5DKsXRhv3GVxUuYE2Abao4iZoT94yLbfBqRstGgOSJ8Fi0C8tZJ1yzfK/PLjFUNnpZtfQHbJXRvc5j2MLMdrDFgRxnCUDsuGIyA2SloYP68HGE4tBZcvuoOUpU4vYvA355ibIRhsmg56rdyjfqYWLA4hkry64jLvB3NNbaGwg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI1PR04MB6959.eurprd04.prod.outlook.com (2603:10a6:803:139::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 03:04:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 03:04:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/5] net: fec: simplify the conditional
 preprocessor directives
Thread-Topic: [PATCH net-next 2/5] net: fec: simplify the conditional
 preprocessor directives
Thread-Index: AQHcUvIHSjOTg72StEO1LGc2qBglv7TuDf4AgAA5wiCAAocOgIAApQhAgAZV9gA=
Date: Tue, 18 Nov 2025 03:04:49 +0000
Message-ID:
 <PAXPR04MB8510A9464D0D0B9260C56F8188D6A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-3-wei.fang@nxp.com>
 <aRO3nMEu/D/kw/ja@lizhi-Precision-Tower-5810>
 <AS8PR04MB8497494755B820A2D33ED39488CCA@AS8PR04MB8497.eurprd04.prod.outlook.com>
 <aRYG2YqpeOr3U3XS@lizhi-Precision-Tower-5810>
 <PAXPR04MB8510C99BE9177113B0ECF3B588CAA@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB8510C99BE9177113B0ECF3B588CAA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI1PR04MB6959:EE_
x-ms-office365-filtering-correlation-id: 91922621-eeda-4c6a-71a8-08de264f3cb8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|1800799024|366016|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XYOpl9ujLPq2lTHliY99CZA2j995t7oFTqpWa6yDCZpC5dJOs43kyr3q22he?=
 =?us-ascii?Q?napTC+/KsdR6foOK5wxGG3ulAlOvsnC8ZKIcz85covBnyME1+VB46wnrrTD9?=
 =?us-ascii?Q?X8+augh1G4RiTcpw2hfaIBDmlSHgrmFJykfpJ5xSwBrbZ/3Xmnr1RMSHDDJi?=
 =?us-ascii?Q?b3DRa4Me3xEtJCnTCP5W+R2KXGK8d5EXKAp/t6Hq1aXa2/hXP84aUnsa1oRP?=
 =?us-ascii?Q?V2XEemobF6li+QLf/q4drEIaMJkiAyShcunsshSTyZSHMJZZr+ZiTz63UzPc?=
 =?us-ascii?Q?S41+49EHwi+oMUt83S7sroGJHHOX0RfLZH7weJ5G/XTjXYxsSVJKBBkKaJhT?=
 =?us-ascii?Q?ioc9cT3ibp0shPI8OiAd35CDzneIRJBjxxHFkyUWtz/octhjBAXajEN72Ht9?=
 =?us-ascii?Q?bz+xvY1ziR10B9fG/Y3R64HnYCLRjn5vd2maIO64Aw+Fy3C7a2EsuBrARKhU?=
 =?us-ascii?Q?7M05rMQAgMXEcC9ZdLnSShbtU8QKABVJ6pD7EdgPwiTjz9jCJ2vb8yt7AqzI?=
 =?us-ascii?Q?h9IHt03KDfz2CBBx0380Rcv6fp6Sgq3yd+j9nwZhtdB8hlF3/RPDVl5TftCT?=
 =?us-ascii?Q?UcAdu4346XJwL61I6u+suN4f6QX7Uxs0/hUKseaGxhRE/hPecyPXpIIRmG1E?=
 =?us-ascii?Q?Mbe7W6pjXaFGOX77Xc75DntKQO7AzJUEkVpog7TrizYHpQTgFMJptMGQibz0?=
 =?us-ascii?Q?fx5HR8AbaCbXSw3+pV7OOP8MGXF90ace2PWBOgJ6jAY3gLSEEk7j4CDS9bvh?=
 =?us-ascii?Q?cLX8hm45v5BIRnwQm5PUwKX2A/7jGPLQnpmZ85k4AS2u5V7I17a75KC0yB/D?=
 =?us-ascii?Q?Pq3sPb2sMBTBJhpwRVgH0DnW4jA09wzRmlNyvJq4NOafgF0VD9MuFfOYQmZe?=
 =?us-ascii?Q?o8EpL7HoLMlfdS/C4+usonesFjNaoxphY+kwzIukrdIMhHY8pdzTzTFNfqJO?=
 =?us-ascii?Q?PA90qWiR8IzFcbUJD3qQA4uoV3n7qpuREu2Syc0oSQtt7Ev6GrhIP0kNLy18?=
 =?us-ascii?Q?1JnHF4N2OaCpGeUFfQ2+4+jhkKu987HXzkmWjqRrGUUckh01f08MXdG2rqoo?=
 =?us-ascii?Q?21vFBj2oz8Ye9X+Dl+dsOTpxDT3Ao91DSHwR0datHseabG1ofjR4ON3VopzF?=
 =?us-ascii?Q?xvvh1J19Bl8av6LDo2LmMZEvwJZOPZ+3LkZyklXkHZE9AJL4lqco2wiIuMwn?=
 =?us-ascii?Q?q+kjckGJwvsCd0F5/86XGfdc7bO1Sth/Wg6UsXwmLKiqeZooQekKG/5ztBI4?=
 =?us-ascii?Q?skEa0BM0dKSNpqNPlaLXb1ILIXUuNHrTBSNpX3l5Mv2rOL5nfrOb324HmPp4?=
 =?us-ascii?Q?53gAfHmcx6K88gBmrJuEVzj3pHFhXu+12as7qWKzuR4gmfXyz0Zbm1eJLW+l?=
 =?us-ascii?Q?sq3ps1lGQQrPaLO/1SRg81Zu2MMSuFXSXexUqzwM6NZHjKpL4+pyRB69C3iF?=
 =?us-ascii?Q?bUxUQlUVxlnKYkmKZSx4O/AenD8u6H+mEClCGn7nIjw3lDbTEA2PG4q6bFZ9?=
 =?us-ascii?Q?4QUZFqI/n7W/cQwT/dGlpumMa//KtbNnsPaC?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?F7NxYnUVJh4+3qrcBpDaReRB9rHJYpuomYGCcJQuYIAjPnQOz8nw76bBQ1hk?=
 =?us-ascii?Q?x2atLgp7m8SWhSp77ucaWHhrwrYtr8blj+/FY9WMzejacm2KnQl/vcnA/JzV?=
 =?us-ascii?Q?9mX5D72OCpxs4EdEADB8eHptagJNVaaYRKoM3GaG5GvHbNKSYBsTJwNDmyg8?=
 =?us-ascii?Q?fZBSkbA/DVgVFfhVhirvD/gkCXIOV2hv70zquJVbDTlbuTSMozrx7XkcRJYd?=
 =?us-ascii?Q?QTSITVafxKFytbE6S9lexV8Bc9o09mejTeZMbnmVSiMrcuqJkOUTR+kwKkeM?=
 =?us-ascii?Q?r3/BKYFnt1mg8Y0w8spHvgOzc+GK34raeLHGjn3MoehcuUYqcp6a8RDU5+X2?=
 =?us-ascii?Q?ILd0FvLqUEqqtmup4mcFDE1g2NbDL+GcEBRXUo7JB+oZi6Wz/YrretcF6h9t?=
 =?us-ascii?Q?rkIVvudKCShqeAP9WjUOglXafASYXSrQep+Dy4eq1KIaQOMHbBu+Ed3DWilo?=
 =?us-ascii?Q?mPiTz3aYFgQjiTsbRb8cgGtJFOVWu++XdFeD+ZxA5IrOEgrsPCv4ex951Kr8?=
 =?us-ascii?Q?kg451t4ohhhU06+UDfFLrvuJUBPSM6d+C7krVJS0x8oN3loPid0x5beAaDem?=
 =?us-ascii?Q?f1O1kmofaHkN+5+vRlzTO7tZZ937JxNkP7ug5d3ORftcCS6hnESJlpUBwT2T?=
 =?us-ascii?Q?YpHoPmNmOKfqP1Xle/l5hr7u1x40vdsdYyQe73AgE7IdqEMpN/xSwp2fejDk?=
 =?us-ascii?Q?6NfMp7FkYHOlKPic0hegZacdaijnuSoKN2bPWR7eZ8AQ/x2QZ2T1mb3XazMt?=
 =?us-ascii?Q?7fsn9EfLsNj+9Ya64l/wtO0EEgWvJ+vqAeJha+9Qxdvh42075vOTTv6Li7DH?=
 =?us-ascii?Q?ZPJ83yXFcD6CGWPUOkQoeG5MnkxZpeLhKkdwhYDtBj7zO3/yFkScNQyU7YvV?=
 =?us-ascii?Q?nEdI2QoSSuxQ4ee81eP6+Ycl18dcWrdBeQmg4hMKWY3UNxrKHbhMIAttQeSe?=
 =?us-ascii?Q?TM2NxY/8Oanes2WyrWGcTZfjvigCP+mAKCpFNfYUzTkLGRFmZviGuIUROc4y?=
 =?us-ascii?Q?ytE/yDIkXgKxNzv4+gdNSEmGMq3IzJeWVXqrSyCint1n/Y6cO47wC1kQ+alt?=
 =?us-ascii?Q?bSHnX54AYEq0drv1VfMHXFslYXfbQ8QMGrjPGFltQpOsGhZOOt5JOs037Fq/?=
 =?us-ascii?Q?Ydu9DU7gC3FaYYCglJ/k2Qdxmb3aaFK6fHrYxcJtJYsfuSLJz3nEcf582faO?=
 =?us-ascii?Q?zHk7VWju6EUYnzOb7CrZCZbC1vR2ScU+dS1JIx4oNVyUWx+swg0N6bLbraLW?=
 =?us-ascii?Q?n9mYVQsjRBgIdn1e3uigxS7l+3kZByLLss8Vkwpd8BMfK7eAkdmUWZ5qu4YZ?=
 =?us-ascii?Q?WGmzPFUVbwm2UdmhffGA3cujNKmRCw0zNDIukAT4crHvhbx0xQQX7uOIS/H5?=
 =?us-ascii?Q?cXzVukwdlhkXEUAR2iphdf5iHj8VKRoR84GcbPmOZjS2Yk5pfkdhGQM7EY7H?=
 =?us-ascii?Q?F+MlubKAOLrCUoP32t4GnhwhaMtE6kBocgStIrUZyNaqfnqRkuZJRC5DKlrD?=
 =?us-ascii?Q?O978huSwZRLDykN6QWTs9o6+AqLacCzJCwBwYqdPIKBx3O6lTHQq4blNnlAd?=
 =?us-ascii?Q?2iSdlJT5v4ovPO8tdFE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 91922621-eeda-4c6a-71a8-08de264f3cb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 03:04:49.5883
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: vuPZzgpwObhYgxuhynXqZX4WczbCgDgg0QdHYv347wK4w+0ayCWj1+OdS1wtNut87mkgM2DPkxqtnEZmY8J/BA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6959

> > On Wed, Nov 12, 2025 at 01:53:15AM +0000, Wei Fang wrote:
> > > > > -	if (!of_machine_is_compatible("fsl,imx6ul")) {
> > > > > -		reg_list =3D fec_enet_register_offset;
> > > > > -		reg_cnt =3D ARRAY_SIZE(fec_enet_register_offset);
> > > > > -	} else {
> > > > > +
> > > > > +#if !defined(CONFIG_M5272) || defined(CONFIG_COMPILE_TEST)
> > > > > +	if (of_machine_is_compatible("fsl,imx6ul")) {
> > > >
> > > > There are stub of_machine_is_compatible(), so needn't #ifdef here.
> > > >
> > >
> > > fec_enet_register_offset_6ul is not defined when CONFIG_M5272 is
> > > enabled, so we still need it here.
> >
> > Is it possible to remove ifdef for fec_enet_register_offset_6ul?
> >
>=20
> Yes, I will move fec_enet_register_offset_6ul out of the "#ifdef " guard.

Sorry, remove the guard for fec_enet_register_offset_6ul will cause
build errors, because there are many macros are not defined for M5272.
I'm going to use this version in v3.



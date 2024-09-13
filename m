Return-Path: <netdev+bounces-128250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 179AD978B8E
	for <lists+netdev@lfdr.de>; Sat, 14 Sep 2024 00:53:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 947421F23F7E
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 22:53:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C277D15B108;
	Fri, 13 Sep 2024 22:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="v3GJMD/S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2089.outbound.protection.outlook.com [40.107.244.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310F148FEC;
	Fri, 13 Sep 2024 22:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726267989; cv=fail; b=ovCBJDbidBan2YAthBJ5IcEcrxZRKzr0eMuldTfuz+AL6YZqppcWyH5Y1Zd9K6Ap0lGIMX6riGffpF0u8JOV4MrkwDiJSwtnakrpCkH17NsFF7FSZOfAJqDN3ngwN2np44sBc5khPtxfZEFnX79w6d6WsWF22WOKfP8X0m/E89o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726267989; c=relaxed/simple;
	bh=39ZWWjhl5ttS+2DysA2I10LTbiUivHRKo7VC0PkIEak=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=NSP+823dc8F74ILXI2h8m/0i4pdvuGH0mzFtD/RBdsx95pxmaOW+NmhGblcLr6/g5Ym6LQlTKJS1ABo58xlIe/v0NRfQOJvl2Zomb/bz2ASj+XtymeN9MWdvmGDllUuewmnCbs0RB/DqzvC+Lo0GstLC1aZSKVPt+34cnlltI1k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=v3GJMD/S; arc=fail smtp.client-ip=40.107.244.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s7B78yweQzCisUNRQqO4dS1lRqvuNV3fXx6qMWkcXPd1TXVpNUIu6VoS1znwe2C1f2fwB//2buFwSpbe1eqUeKaJL+AlnEv05rRhu/DmGqFMsmxj4Fax8C3Ua10dOthCf3PNmKkWYrzKcZcx9L5SZ3bwqUnYNwPZmSabns5yHr9DXvemJEl8IF3nld2OwUJOVXpe23Lz3pYbIElTukJD1joHlKZ1XXyTNrVU1xYSFfckncZFn47sOPLJrmb4Ru6yI3qvtkOBtLK5mMqTuFi0StmRlO430HjxhLrvITKaCTJv+e6m7GNO6nYlrU21e84BAR3mFvhat0cbhw6nqQmOGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DaLMjYg2+tlG7CI0B5UuFKmlk4A5gVBn27Mi4PcFsTk=;
 b=caI1SMPBy1nP99vFaeCiyI7eb+EnLGwR09GuFGxv1KmBkYbybcQOck1dpa0NdRdVXAUGOpPVnk/CsO3Y8OnaFmkPVOhrSvnPwffCDXceFU2SYFDtF278/HQCjquS+pRx4HjTje2qdIUcg3vhHrNx9L+KVJNIFeQ2rQdSBcKKNvAVlPxvhD3Ox55wcbIfseskA6rHUurajcHTt/H34CQj7DB0H7F293UObQusgU9tfxtsdN1E56pDDxucIUmVh1mXBn9zb2kN8cSAyLz3S/e4xrRoy6xjf7Q6Qygt95YUlRjBtkYjmNWerSHUWCWGDU5uszweU1jYQ82X77LloI1ysg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DaLMjYg2+tlG7CI0B5UuFKmlk4A5gVBn27Mi4PcFsTk=;
 b=v3GJMD/S8E6+eJa/5iHtzS+sghphGDuyx3WQfHZgSpuNMZ6OlJjnzaFeL6TnzLvm0xfZjy9uXyC/g+8WTBB93a/lrQNK4Gmi0K98Z3y/nlnRXd+TQ8DnAFtOqIitgs+UqBLhS0DKEhaT3rbuWulCeqmhLodKERx2AETN01yIwXIFEgUrIvUW3QFj9mlMNMu/faA8il5lihEOtmz0Shn0jC4uh1ovLaqGtvPIxh/Kxm8yn+jgcN3byElBft2bAUTL0f5AFH4WTY8sa6TSFG3t6IPbZJJR3YazYXP3l/Z8bSpBATW0QL8ugIvZqHLMn2h8tkh4HK0YpS73k47IpFRTvg==
Received: from PH8PR11MB7965.namprd11.prod.outlook.com (2603:10b6:510:25c::13)
 by DM6PR11MB4563.namprd11.prod.outlook.com (2603:10b6:5:28e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7962.21; Fri, 13 Sep
 2024 22:53:04 +0000
Received: from PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739]) by PH8PR11MB7965.namprd11.prod.outlook.com
 ([fe80::ad6c:cf56:3c3d:4739%3]) with mapi id 15.20.7918.024; Fri, 13 Sep 2024
 22:53:04 +0000
From: <Ronnie.Kunin@microchip.com>
To: <andrew@lunn.ch>
CC: <Raju.Lakkaraju@microchip.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <Bryan.Whitehead@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <linux@armlinux.org.uk>,
	<maxime.chevallier@bootlin.com>, <rdunlap@infradead.org>,
	<Steen.Hegelund@microchip.com>, <Daniel.Machon@microchip.com>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Thread-Topic: [PATCH net-next V2 4/5] net: lan743x: Implement phylink pcs
Thread-Index:
 AQHbBGX8VAfW8KWmWUiadZFQXqJr/rJS1qaAgADhgICAAI/DAIAAAwnwgAEhXoCAAEoQgIAABGuggAAYrYCAACw2MA==
Date: Fri, 13 Sep 2024 22:53:04 +0000
Message-ID:
 <PH8PR11MB7965462BB26287CB056A5EEB95652@PH8PR11MB7965.namprd11.prod.outlook.com>
References: <20240911161054.4494-1-Raju.Lakkaraju@microchip.com>
 <20240911161054.4494-5-Raju.Lakkaraju@microchip.com>
 <c6e36569-e3a8-4962-ac85-2fd7d35ab5d1@lunn.ch>
 <ZuKP6XcWTSk0SUn4@HYD-DK-UNGSW21.microchip.com>
 <cbc505ca-3df0-4139-87a1-db603f9f426a@lunn.ch>
 <PH8PR11MB79651A4A42D0492064F6541B95642@PH8PR11MB7965.namprd11.prod.outlook.com>
 <ZuP9y+5YntuUJNTe@HYD-DK-UNGSW21.microchip.com>
 <4559162d-5502-4fc3-9e46-65393e28e082@lunn.ch>
 <PH8PR11MB7965B1A0ABAF1AAD42C57F1A95652@PH8PR11MB7965.namprd11.prod.outlook.com>
 <867aadb8-6e48-4c7c-883b-6f88caefcaa6@lunn.ch>
In-Reply-To: <867aadb8-6e48-4c7c-883b-6f88caefcaa6@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH8PR11MB7965:EE_|DM6PR11MB4563:EE_
x-ms-office365-filtering-correlation-id: 7f788006-61a1-4921-5e66-08dcd446d393
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB7965.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ouJEpuj+Z9G6XWAZa9TyaDDsYKuIYktmGfeBzOvlQa4Ka8v40DadTOC37AtV?=
 =?us-ascii?Q?oi3pzQR54HiyHng1Cdu/aAMlojFRipYBjSlhYZ10PARD70qy0Xf0f9tzpBxT?=
 =?us-ascii?Q?DOd66q88GiHXJrwqKx8WTTRBkamhdfloZAbHQDJeLtL4ekW8y7F+KnzWbAsB?=
 =?us-ascii?Q?PEik82fuo+Q14TwsigvdP1uxYWFel8WC1Pbw8wO0aMtT2j0FLbXR2h34I0Bj?=
 =?us-ascii?Q?dBfJpWmN61r6cLU7/0I4Ie1/MMj4cX3USZRgmGw6mXXyx4HB7Ie6w4VKugrE?=
 =?us-ascii?Q?hD+FMYamMWDiqqX6o24VwxcXDth2KAA+iabSVJqBfLYHVl2iEI165aXOv7uR?=
 =?us-ascii?Q?YSnsJSehD9mgFM0RPUEEWYYGKxM81J6XdwWpSiAceuUW8xFuYKjiicAobzYn?=
 =?us-ascii?Q?g8FOQtY8nFxCSkd2KEplX/zmcODMrjlBg32g2c5p+TygJdHopuUjvd9VAC+e?=
 =?us-ascii?Q?OubqXvlyGHSM+Z13VDxVtGk33kur9Yg2BOrXyb9LnoWl3xxu5CBZ2IdooDiu?=
 =?us-ascii?Q?8x4bZgeJtz5AGt1+jPbtBQdIJTJJFxoCwiGheWFqsVCgO8dqv4FLJ+kiOeJS?=
 =?us-ascii?Q?S0gaYBVuc8ikN9Dr/uYqHieEbQSbvhX6fSpd/w1kTKK/04mAlWABTD7HC3QQ?=
 =?us-ascii?Q?I0ex9eDr+JlmIkWi9n/zUcK52NLNf85rv+u8nR/KF+hemBl7sMwNZGgt3Lcl?=
 =?us-ascii?Q?eiWnK6lqP3bTZ/8eQU94tQe/AuG19/b+WVRdFtUqv/y0YJlU7R5eCLYq4ywh?=
 =?us-ascii?Q?1ial1yT+qIWO0EsuszeiAOE/6NanBrvGqlRrBQlz0lkz43Qjc2q47CaJsuJk?=
 =?us-ascii?Q?55xejEz60eC4jeoi6g51zqoE3+9XHkm608Da9PCJ6TksxKGkJ60unMiByFT6?=
 =?us-ascii?Q?Tc2kbV41iuJZgNGc7PLYcfF7h0VS/2PWwvKfLLDkL1UwDxV5vpohClGhuqeA?=
 =?us-ascii?Q?TAp/VHmoKjVb01jGLXUyQ0rJY+KjwXgNxPU42qnEtvr43PwZQj0gpliYYNwE?=
 =?us-ascii?Q?Py/S9qR+I6bj9a/ZquEP1TM7spD4jX7sWOJe1qF5ohdm6C7GK2bWforKe1yy?=
 =?us-ascii?Q?wB9+5KN4ITAgKL8VC2Ml64U/VwDV4ca0ksspTtefiJLrfKdj6UbMGzKPf7Ae?=
 =?us-ascii?Q?QtxBFVR+0yAmSVugziVmapzGR8jJl7CRwY/H4uJUNB9zy38iFN+4DF2n64sn?=
 =?us-ascii?Q?VjIokGycvertBOHZQFNv6MXYPaYRi17MlRM8TkgQIX4fxIccWfZAKBQSNaU5?=
 =?us-ascii?Q?dg9s5XqdxbMYEOPZcdwmcO0SHj4A6np2PyY+/A8RGzNopJSaieRimigxU+w7?=
 =?us-ascii?Q?I4Pr1jGe5EXxfo6IPfBU/WplS53ZhUVJoYxsBRpXRGXKXHSzS5fsYmgngs/A?=
 =?us-ascii?Q?Uqi5cxH/u5O2fPNUAiHxzEcD22bYwZuKIUPa+ymZ9+cjHgFXOg=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?r30aLuBR8IsaG1ltKgOr2I+NgAsX4SbB4kU8A72jRuHQ4yNzZCXYwER1+37P?=
 =?us-ascii?Q?fQAqYwtYW2QJfuTIFjZjaH3e/xZk8X7Z3Ddv9d79ZKMUITNAML9EpazAube3?=
 =?us-ascii?Q?T2MON4bzKKc6JaS258auxDS3Uwmk+Y2RMnkNqJbo0kYgQrvw6BJQudrbIpRe?=
 =?us-ascii?Q?f3QVcz7ZDewG6FdmS8U3tsSVsKbGMNQjyeCK+hyl2RvvjApQ1snkFC5HkHrT?=
 =?us-ascii?Q?ARkemJ83z7tnS8vEntzFXSugEgWt1V1Sfr3AGEyLvyZ3zzByJwMHJGyorBRg?=
 =?us-ascii?Q?JXvRyw2UlVDIyrvBLuA3c4vOq2gN8h2LHGeY8bugNaCDyTz13aQBnUc155Gq?=
 =?us-ascii?Q?TvV40s1bdDK5ulwASdbHZ778XecFY/cvXba6ljw1o+QqYi6yREYFOauAM7w0?=
 =?us-ascii?Q?3+wzfq3/AfRDcVQw8zZtRP7GGemjhHg5Rx1UAMU/DIK7a04dcpdcyjMLfe+/?=
 =?us-ascii?Q?I1H5lhjWKcdPp3aHNvE8zczbiQw/Sp2OIptX+AM4994nx/+5Jn8KYCd1GIUU?=
 =?us-ascii?Q?KOT6Q2rPEeMRgF7xJ4F5N5S0Nah2R0NP/wSz07jbtruOvNMkngxcQ8yuWR5r?=
 =?us-ascii?Q?VwnqOvMy9azNo2Xl/WDNB98KvA4w3jM2hwW4EBBA/a7MWbJ2MyM+O9KCuRHW?=
 =?us-ascii?Q?K8Ngydm2yJJROzPB48xM2xHgL4cz7OS6PakIwEsOi2x4oUVOdnHBf6/EiKNO?=
 =?us-ascii?Q?+7jgFVcOpvxFaqIZeXWURZZNBF7RkFgd6vPxy/ijtmDoLeDRNqMc+NYU+oP1?=
 =?us-ascii?Q?wmarLyC/VsPVXmITRteNYL7qTFXhl5V1HWUaRXwGyExXkXsxhl6s3jKhhDZ0?=
 =?us-ascii?Q?OIuHhWi/cQtD/OMAU6krW++/x9YVgn/aKjLXufoxcEWIR6e60vZkLYruiEz2?=
 =?us-ascii?Q?JYH4i4Dr9ckBWcpLEFB03MO/DTwQRiSaU1f5WD8fGuJK/aooF3urNHr5ddG4?=
 =?us-ascii?Q?D+0F6G0Npm1CBHrR4DM/39Xm4HjC3EwbqsDDgi3jvklgq2ShHrv7u6FIV1zD?=
 =?us-ascii?Q?Qkg5bPtc7BhQAC1uOEPOv1W8WMV/r+dcvGBdv8gfBkCVHdUgYkykQeXTo99o?=
 =?us-ascii?Q?aCElGvQhhBNSi4ovpdch7W5qp6BS9YPmViFm1ssz2LOOKAjL9c3avE7EVVqK?=
 =?us-ascii?Q?ha/kfstdzM8E8FqNfZptnYMEqRmkNQw4EurVbQRjsjseHj67JJoyhn8xcsVO?=
 =?us-ascii?Q?VtXFkOGPby7pM2gggQEFoSruQ0REz5Smvds4tscbyvjPRh3S1N67K20EMDqK?=
 =?us-ascii?Q?IWO5kabP9HRmM9pleNN51I7zvLZAVQTS1ZoUNzY8U/GR8WZd5+fWqcquYX1p?=
 =?us-ascii?Q?gM3RsZGfSpSlomb4BoaV0gIbFnS59WGvVXc9izklrWYxU02BIue1KlD+8qLw?=
 =?us-ascii?Q?+nW6ie13XqmkborGHl0gSLsnBlPztOt/4XkeM2G/SIuY4Q9OOpUzCVtvNiIa?=
 =?us-ascii?Q?Z7Q7IEQGZmAA2UPh33jis6EF+2SZmdOo8/iThV9r1brFxRUxG/KdCBFdZ5YB?=
 =?us-ascii?Q?MnLLZuPsoB2K4bSDH7hUnl7002RAAOQiP8SP51L+QaaxcO5LlZaqBdFqbFFd?=
 =?us-ascii?Q?3axoh1/f8LXahcDw2iUln9eG3yyHUNPOHkW4zb7q?=
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
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB7965.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f788006-61a1-4921-5e66-08dcd446d393
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 22:53:04.1992
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 9itQs1SVecJt4RJe7NZPns5xpPG/my0tZGB3GLjzdpiMwVG+fJnQdYOhBHpBAx5zVZjhts9Edl29jUOOf74111c3ESd2RKUVp3+gqoLvzls=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4563


> > - Furthermore, I need to check with the HW architect, but I suspect
> >   that the block that was not selected is shutdown to save power as
> >   well.
>=20
> I would also expect that when the PCS device is probed, it is left in a l=
ower power state. For an external
> PHY, you don't need the PCS running until the PHY has link, autoneg has c=
ompleted, and phylink will tell
> you to configure the PCS to SGMII or 2500BaseX. For an SFP, you need to r=
ead out the contents of the SFP
> EEPROM, look for LOS to indicate there is link, and then phylink will det=
ermine SGMII, 1000BaseX or
> 2500BaseX and tell you how to configure it. It is only at that point do y=
ou need to take the PCS out of low
> power mode.
>=20
> Independent of RGMII vs SGMII/BASEX, the MDIO bus always exists. Both mod=
es need it. And Linux just
> considers it an MDIO, not necessarily an MDIO bus for this MAC. So i woul=
d expect to always see a fully
> functioning MDIO bus.
>=20
> One of the weird and wonderful use cases: There are lots of ComExpress bo=
ards with Intel 10G Ethernet
> interfaces. There are developers who create base boards for them with Eth=
ernet switches. They connect
> the 10G interface to one port of the switch. But to manage the switch the=
y need MDIO. The Intel 10G
> drivers bury the MDIO in firmware, Linux cannot access is. So they are fo=
rced to use three GPIOs and
> bitbang MDIO. It is slow. Now imaging i put your device on the baseboard.=
 I use its MAC connected to a
> 1G/2.5G PHY, on the MDIO bus, which i uses as the management interface fo=
r the box. Additional i
> connect the MDIO bus to the switch, to manage the switch. Linux has no pr=
oblems with this, MDIO is just
> a bus with devices on it. But phylink will want access to the PCS to swit=
ch it between SGMII and
> 2500BaseX depending on what the PHY negotiates. Plus we need C45 to talk =
to the switch.
>=20
> The proposed hijacking for C45 from the MDIO bus to talk to the PCS when =
there is an SFP breaks this, and
> as far as i can see, for no real reason other than being too lazy to put =
the PCS on its own Linux MDIO bus.

Ok, I see I probably misunderstood what had to "always exists" (assumed eve=
rything) as you mentioned in your previous email for Linux to make use of t=
he frameworks. Interesting use cases, thanks. =20

As I have mentioned before I am not (and will likely never be) a Linux expe=
rt. I have just been advising Raju from the perspective of how the chip har=
dware works, the drivers I have written for it for a different OS, and what=
 our customers have been requiring from us. I wasn't advocating against ins=
tantiating a second MDIO bus or whatever else makes sense in the Linux fram=
eworks/environment, specially if the overhead to implement it is low and al=
lows for richer or alternative use cases. I was just pointing out potential=
 problems based on my knowledge of our hardware and the information I was t=
old (now obviously misunderstood and/or incomplete) about these newer Linux=
 frameworks (phylink, xpcs, sfp) by Raju / was understanding from your emai=
l. Unfortunately today was Raju's last day with Microchip, so I guess this =
discussions will probably pause for a while until a new developer is alloca=
ted to continue/complete this patch set.



Return-Path: <netdev+bounces-145127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E199CD530
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 02:54:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DB5A21F223CA
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 01:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C3F6155C97;
	Fri, 15 Nov 2024 01:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="OJvHei3T"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2080.outbound.protection.outlook.com [40.107.223.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53F477DA67;
	Fri, 15 Nov 2024 01:54:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.80
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731635643; cv=fail; b=PBbNaA4Dyf+B6w5cFqXLSneweR3v7NHVsac3lOeGSeD9uBI/zyM97TDGoNrMezd+2eJge9fQvVeBkii/OczosCfAdrf0eOPUyKJz+e7YkWQFusqkimgpqw5/lnrDxXTJCKmrXG/h8WOXLga2vPbsy5gi5CVZ0JTPHBXKhRj+X9M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731635643; c=relaxed/simple;
	bh=gdR75T1ucsQJBm9RyjFEC0DVy2jtqfWLpV+/5ekh8fM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VPSJXxiQwwFXY6s0zWdeS5ecyA9ad3CKU2HoNPNnUbHOTdIbceX4XUfSnsQvu5jX2IlFN50pDTxGdegWhO7JoGFhuMuc0bO3ZR/Gh4NpEu4jM/gaEmOw4nvTNH9acEJpUG9C2ZnIB1gi7bUPRTHuJgTUW8mHuCU+7mVY0ZxDZ64=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=OJvHei3T; arc=fail smtp.client-ip=40.107.223.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=flbNgHdImHrEJLcYf93v5tUuDNJp4dkhC2QobsejHGInMN0I4dlM4PfcpYXW6zwP8t0plGXL4k+Ymh5VprG5ug2pFhOZBVnCBkcDN10A7y9QuHdRJLnW7xXQGdaYqiLcmWpyffI+EKZ/DaRROJLN8bqc6ZdSmEyKt1SZLl3d9jmsvhTTwqo5ug47HXcGK9Y3ZtJC2BU3eL35yld8ZTS+PvWfj6ekm2uT/iLlKN1D6nGvMWElu9yxS3wA1S2GV68PJZdj1LgH3Yx5maNWrg+Ctc4EEPOJmN+VTeqdoV8tJPlosNBi843h+vKYq1UO4S1w91EjsoWKd9gVzEUMx+ltLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZxhPiLI1THFsvpDefYVIb0i3F1TqcJomHGCOrESAmBU=;
 b=FQdriTff9TKkI/rbfmzn/1BgrBH7w0oRUbQ8oQuSqOARecqro76GOXaNABq66WkROIC0gg8byEsTSJB6asj32+uGjOdHk1eMvsD3TdjY93kN21KF75YtqV7r2otg7277Vb3u8dQu9I/1j2Ne9smTYHRsUQaBgrEVCtlJDTv8+zgsU0c9WzFxYPHu83ZQ/m+L1uvT2iQC3RWPZ3bnlt67qcYsZ26FiaLnxQjLeSV8jhuR2mLk09nmti+NZSvBV/rA1O4rVNwzBHBBd6gxwCxgddvjFaJsh8rfvxWQCjaezmmbM5kZ36IerOol5iiAjbQtAYWg4hCa+TldL1ra3Oqiww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZxhPiLI1THFsvpDefYVIb0i3F1TqcJomHGCOrESAmBU=;
 b=OJvHei3T2DMHLfOI6dI/30hznAM1rYw3DCGtq0XnJGjyoBtFGjpzPaovcmb8ig0JJrQn5+NDeLcvHSNqTSteZImnNY2YKhPZrpQ4qHHT14TEqsN3IcIR6jNkcamXEV2Tmn9wtN1ZyXaG3c8+AwGfjnEfwj5AD+g7SVFLKjTmpVDfgru+8FTbCy3FvFrwafUfesQTbFhH6EVwaqUEt1jjAib9AvTM3IQVVlCqWGVNUdsqn77EXCF8j936+DiG0vq3psKzaZmawpxiNSWuzt4/XMZDZYqCoUjTDeHTylEjrxpKeHzs2G4vBLbPSq4CWjMGfk/ptDregyFOOIT25JsBDw==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 SA2PR11MB4954.namprd11.prod.outlook.com (2603:10b6:806:11b::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.18; Fri, 15 Nov
 2024 01:53:57 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8158.017; Fri, 15 Nov 2024
 01:53:57 +0000
From: <Tristram.Ha@microchip.com>
To: <olteanv@gmail.com>
CC: <andrew@lunn.ch>, <Woojung.Huh@microchip.com>, <robh@kernel.org>,
	<krzk+dt@kernel.org>, <conor+dt@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<marex@denx.de>, <UNGLinuxDriver@microchip.com>,
	<devicetree@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Topic: [PATCH net-next 2/2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Index:
 AQHbMkqiYUyxAMrEtEGHh8l2mClPuLKvD0EAgAPmaUCAALlcAIAAy2zQgADVf4CAAkw7sA==
Date: Fri, 15 Nov 2024 01:53:57 +0000
Message-ID:
 <DM3PR11MB8736D3C4814D9DCC8022F803EC242@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20241109015633.82638-1-Tristram.Ha@microchip.com>
 <20241109015633.82638-3-Tristram.Ha@microchip.com>
 <784a33e2-c877-4d0e-b3a5-7fe1a04c9217@lunn.ch>
 <DM3PR11MB87360F9E39097E535416838EEC592@DM3PR11MB8736.namprd11.prod.outlook.com>
 <700c326c-d154-4d21-b9d4-d8abf8f2bf33@lunn.ch>
 <DM3PR11MB873696176581059CF682F253EC5A2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20241113144229.3ff4bgsalvj7spb7@skbuf>
In-Reply-To: <20241113144229.3ff4bgsalvj7spb7@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|SA2PR11MB4954:EE_
x-ms-office365-filtering-correlation-id: f2d6d5cb-6ffa-4e9f-3394-08dd05185e5e
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CMjaftbrAjQYWinBYSb745WDAncxuc0zollGis1YjHAuMy3x26f/FrKaW+co?=
 =?us-ascii?Q?0sGYr+xyyBwH7eVQfeOqQpkFVemKmgByfg/yGsek2qA4y6jSzCCEKcnDIc7a?=
 =?us-ascii?Q?h+ZOdKSqTcPlTd4k2Ow9f+2/ulRNKQqk+lYPiES2S88x//QyfgxNzSw2eIHj?=
 =?us-ascii?Q?a/rv15ebETPDEzSDZ8XE6wasYklkrQ/ucjJgnqQYRkncSpvjabbSCnPJrVgg?=
 =?us-ascii?Q?IAGEzGxlSUlbwMr9R24NFXb2bnmx8UcPkCMCcU3lxWfP9VBZq3kcDoZX05mf?=
 =?us-ascii?Q?c35e8UHiy1o40aKsJfnIVYWO5pHblVv0DznOVcAkWIJwHtz9TU9pOAghsXfl?=
 =?us-ascii?Q?tXz8n89mRDoamEIOYcwusfxYvAhqdOcPhf6vWNAqNUFoJ1WbgghghKqEpeFm?=
 =?us-ascii?Q?zPpnrHSIrAouluERXM28hjGRjd/vuCAIM5UVHjP0erdKrZtsTEZSFimiGoEY?=
 =?us-ascii?Q?at+gejbugZEjDYg2A6LbLY6Q7ZmZoecOGccrr8Rz9xL9FoA5TP5EpXHLUyw/?=
 =?us-ascii?Q?BR26N3b/eCK9Eazqsn7/Ap3x/0uuyKLDuKYw5ZUaS0m26lcqVhhLzeo38jdi?=
 =?us-ascii?Q?TgSRd9pgtDMahmvhXee2btgBVdUWEtPCnyqf0bTHwMjgoZF/gJKYuPnsfq3K?=
 =?us-ascii?Q?XCnVrPSpGFU0huzTSSOKFwK1wrIHiJjr/n38g3qXnqrTQcM/xXLzjqKR9S01?=
 =?us-ascii?Q?x/BlrKRdHUTTt1mrSnwNoHnBP/YDDcVTP3vxznyWeYJBFA5dy78ot95nVnQ1?=
 =?us-ascii?Q?HghAX8W0GtWrNAYIa+iyayoNbfAdc8NiV2WX7ekC4KFs1u9s5b17DlV7YBlU?=
 =?us-ascii?Q?AoGGVEEbZySBMOHRFQkadmK6VT3jbepd8ieDmW/D4AH0n4myb/pEhP8yQh+o?=
 =?us-ascii?Q?ml8KIvbR+fnc7Egg5GDEZe0C9YuZNSC5G9g66m8+txXBjIKI1PNrWu1lPXdZ?=
 =?us-ascii?Q?lPilkJO8ezdrBTA7ivu2H4O9aMoIHdk2jyTHYcmGuaYyLoAXmWCevsh25zD9?=
 =?us-ascii?Q?nFgaqL7gXDaDsjKxI842sNjsEVPsp89rVnoirBTR6QqFtzvHhED9lzaYOc6o?=
 =?us-ascii?Q?79iAfceI1/qqmRVbsPZ5P5BOeX+d3rNiXTO5jKwnsme1KQ+Z/BTwhzrA8e9v?=
 =?us-ascii?Q?FHyegydZ6V7HbaBSMvMm+83Tvbv4jKZWHrbdvbBvK01L+Ut/gUVRHDynqOQ1?=
 =?us-ascii?Q?Onm7icutdjF+bQoA87XsjPUYeM5IK3LfhCARVfNCkUC2jmxFLXj2gwy4HqJc?=
 =?us-ascii?Q?aTMI4h+zxVzz+B9mFMEW+Ifl+TtxeotAnohc67+0rrFnU+XGPyHJZgfH/xn9?=
 =?us-ascii?Q?1huCLzfBRznMrr1ubh6tB9ig6PgmN9OxKx8Bydk/kvJvI0m/f9GlEL4AcRBr?=
 =?us-ascii?Q?bsByQ2Q=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?bVeMP/dOw6/VNBIGwrqALwfZV8M39hRZpRicxc5TCxm/Tjj2Pd344/sHv8kj?=
 =?us-ascii?Q?rYiEP1X4RaY4m4BTHU3+6f9NRVCoV7ME7Mo6yCUMrjwhYml35ATvHfhs+P8e?=
 =?us-ascii?Q?m3Cq/tZRtWAgzTOeorKaBdnLZ8iJKf4J8zAUEKK4Upe55KNflv0/AWzEzgVt?=
 =?us-ascii?Q?Ve53WIep8jXRl5Ly6rAsHIt6lzbNN/ys4+5a+w+q4qhNV14AZSNnfbxoaOAw?=
 =?us-ascii?Q?xu7Ahba0JkvzqluXrAMS1wgXrTllDijaA2MKOOL9Kh+3h2ABhx6ebcKCbGzk?=
 =?us-ascii?Q?Rho5Q+MRx1uSVb32376vYmyIpwsB6+8IMtwh4AALAZDkYzY31FZQaHgI3h6v?=
 =?us-ascii?Q?UANb3rEnc93TDND6JXUNkJmkS+DWDfPddzLC7UokRIIKKDLNNRJXRIpJKpeu?=
 =?us-ascii?Q?6TbtU+LD+WTK1/+gCslnM4ojZAyKB4GWbAsWghCseTYIgdnPeN8Z8joRGDiq?=
 =?us-ascii?Q?JHztxnRDd6D6+jMEFNOaHBggEjjks07e3sHuiaw/GEU7mg/beVfwzEotTG27?=
 =?us-ascii?Q?o+4VowW2X5p9YVsqTPIOEaKqwCqW90hET1czgOT+AmsFKl68rAsm0r21F7a3?=
 =?us-ascii?Q?KBGp4n5VScXhK25xr3O3/OSIL4AzlyktemxgxQpenluzDSa1cCkXZKs9OqrG?=
 =?us-ascii?Q?glhRl15uw0WvWxiYsvjBXiP83OcphjXP4gwO8ci2foKQXU200TGplrJt/iVM?=
 =?us-ascii?Q?sgnUEGoAnQ9t9zHQfW7TSSUxVwsaC7+Oa9keZcIDhad9uNLE7tixjLnBy0/x?=
 =?us-ascii?Q?Xdv3LVQsFs/EyHyUszmXA31v0vnUULlitHNl60eAXk/MYImLPDl9Uf+Etstx?=
 =?us-ascii?Q?LxDUsOv2HsmSCQ+ADTQ0IwdOFZEzNTtLjvxdO2ovFG/runRzbIVOihe26DUH?=
 =?us-ascii?Q?ORJVJkSPCcDrpmCpTqfd3iyUvB2o5RFee1CzQTgROSJc26DbVKj/4aJu5Hav?=
 =?us-ascii?Q?oXqfrraJaY0ll4y1slPRWFNdGlCd4HlJsrSnY7a9/5TQHN+VpRfITaokaBVM?=
 =?us-ascii?Q?1CTUayialkMD6zP+Y6HOtE2KjJQ7HVmSmfZM6JBSqkE8VgOk0yMd1vODlJkc?=
 =?us-ascii?Q?HLSKDO2Hemk4kWkspCvpvOwONjc7UwDrUjnrsqweywtfd6odInuKo1P4ATht?=
 =?us-ascii?Q?56p/ZvONutXt+4ccabl4q7mPM9ku5sN6bv+2fVs+qFYLTJIRvJvLQFFKFku3?=
 =?us-ascii?Q?QAk7Yg/fn3Ym7ajIiBr+7oszJF7Nttk0m/5AAft3OTfSe6dL7HqE6jYTn4/P?=
 =?us-ascii?Q?tvHFfZXUkDuLKDJV5ccRzv9l7A/aFRtQjY9MqFOa+eoyekZOHeLtRfikGXBo?=
 =?us-ascii?Q?I1km8xWyScUjJbA80u+oJX0ucS/1mf/4A1guSy3ylQmH9sSIL5Ku3rJDVLEt?=
 =?us-ascii?Q?amQ5LzxKP8PwQfgpq0Ti7C89dqZE1UzrfNXddtbgg7L3dZ9hwx9dmoW7UXDC?=
 =?us-ascii?Q?fVrRav9bzHbLbQ/EZY0QwBU+gDOYcChPPYwiv5TLA9ZITH1dvAkxJPHLVceS?=
 =?us-ascii?Q?c+tKOGw8YxvQY76EVFfoWyCNmGhgaRuCxf8FcFoECnd534cAdphS/IhOppui?=
 =?us-ascii?Q?woSmSPl+rNqGLdZqmFQ+2kXnsb3LBSfVDzw7rmTF?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f2d6d5cb-6ffa-4e9f-3394-08dd05185e5e
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Nov 2024 01:53:57.6489
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: k18FtunFytNuktxV4b+98gsPHpZ74F5wgpS76t/xyVAMex5PYygzXB2MXeREsw/JHEGWreGyjVnheFwTcLHlH5ke6/0WhDl6BhdajNOfkow=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4954

> On Wed, Nov 13, 2024 at 02:12:36AM +0000, Tristram.Ha@microchip.com wrote=
:
> > When the SFP says it supports 1000Base-T sfp_add_phy() is called by the
> > SFP state machine and phylink_sfp_connect_phy() and
> > phylink_sfp_config_phy() are run.  It is in the last function that the
> > validation fails as the just created phy device does not initialize its
> > supported and advertising fields yet.  The phy device has the
> > opportunity later to fill them up if the phylink creation goes through,
> > but that never happens.
> >
> > A fix is to fill those fields with sfp_support like this:
> >
> > @@ -3228,6 +3228,11 @@ static int phylink_sfp_config_phy(struct
> >     struct phylink_link_state config;
> >     int ret;
> >
> > +    /* The newly created PHY device has empty settings. */
> > +    if (linkmode_empty(phy->supported)) {
> > +        linkmode_copy(phy->supported, pl->sfp_support);
> > +        linkmode_copy(phy->advertising, pl->sfp_support);
> > +    }
> >     linkmode_copy(support, phy->supported);
> >
> >     memset(&config, 0, sizeof(config));
> >
> > The provided PCS driver from the DSA driver has an opportunity to chang=
e
> > support with its validation check, but that does not look right as
> > generally those checks remove certain bits from the link mode, but this
> > requires completely copying new ones.  And this still does not work as
> > the advertising field passed to the PCS driver has a const modifier.
>=20
> I think I know what's happening, it's unfortunate it pushed you towards
> wrong conclusions.
>=20
> The "fix" you posted is wrong, and no, the PCS driver should not expand
> the supported mask, just restrict it as you said. The phydev->supported
> mask normally comes from the phy_probe() logic:
>=20
>         /* Start out supporting everything. Eventually,
>          * a controller will attach, and may modify one
>          * or both of these values
>          */
>         if (phydrv->features) {
>                 linkmode_copy(phydev->supported, phydrv->features);
>                 genphy_c45_read_eee_abilities(phydev);
>         }
>         else if (phydrv->get_features)
>                 err =3D phydrv->get_features(phydev);
>         else if (phydev->is_c45)
>                 err =3D genphy_c45_pma_read_abilities(phydev);
>         else
>                 err =3D genphy_read_abilities(phydev);
>=20
> The SFP bus code depends strictly on sfp_sm_probe_phy() -> phy_device_reg=
ister()
> actually loading a precise device driver for the PHY synchronously via
> phy_bus_match(). There is another lazy loading mechanism later in
> phy_attach_direct(), for the Generic PHY driver:
>=20
>         /* Assume that if there is no driver, that it doesn't
>          * exist, and we should use the genphy driver.
>          */
>=20
> but that is too late for this code path, because as you say,
> phylink_sfp_config_phy() is coded up to only call phylink_attach_phy()
> if phylink_validate() succeeds. But phylink_validate() will only see a
> valid phydev->supported mask with the Generic PHY driver if we let that
> driver attach in phylink_attach_phy() in the first place.
>=20
> Personally, I think SFP modules with embedded PHYs strictly require the
> matching driver to be available to the kernel, due to that odd way in
> which the Generic PHY driver is loaded, but I will let the PHY library
> experts share their opinion as well.
>=20
> You would be better off improving the error message, see what PHY ID you
> get, then find and load the driver for it:
>=20
> diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
> index 7dbcbf0a4ee2..8be473a7d262 100644
> --- a/drivers/net/phy/sfp.c
> +++ b/drivers/net/phy/sfp.c
> @@ -1817,9 +1817,12 @@ static int sfp_sm_probe_phy(struct sfp *sfp, int a=
ddr, bool
> is_c45)
>=20
>         err =3D sfp_add_phy(sfp->sfp_bus, phy);
>         if (err) {
> +               dev_err(sfp->dev,
> +                       "sfp_add_phy() for PHY %s (ID 0x%.8lx) failed: %p=
e, maybe PHY driver
> not loaded?\n",
> +                       phydev_name(phy), (unsigned long)phy->phy_id,
> +                       ERR_PTR(err));
>                 phy_device_remove(phy);
>                 phy_device_free(phy);
> -               dev_err(sfp->dev, "sfp_add_phy failed: %pe\n", ERR_PTR(er=
r));
>                 return err;
>         }
>=20
>=20
> Chances are it's one of CONFIG_MARVELL_PHY or CONFIG_AQUANTIA_PHY.

Indeed adding the Marvell PHY driver fixed the problem.

There is nothing special about the Marvell PHY driver.  It is just
phy_probe() is called during PHY device creation just as you said.

It may not be right to use sfp_support, but all three (sfp_support,
supported, advertising) have about the same value at that point after the
PHY driver is invoked: 0x62ff and 0x60f0.

I mentioned before that some SFPs have faulty implementation where part
of the returned PHY register value is 0xff.  For example, PHY register 0
is 0x11ff, PHY register 1 is 0x79ff, and PHY register 2 is 0x01ff.  The
Marvell PHY id is 0x01410cc0, and I saw there is a special PHY id
0x01ff0cc0 defined for Finisar to accommodate this situation.  Were those
SFPs made by Finisar originally?

Some of those PHY registers are correct, so I do not know if those wrong
registers are intentional or not, but the link status register always
has 0xff value and that cannot be right.



Return-Path: <netdev+bounces-159924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C577AA17630
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 04:08:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C809C3A66EB
	for <lists+netdev@lfdr.de>; Tue, 21 Jan 2025 03:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B84F61714A5;
	Tue, 21 Jan 2025 03:08:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="S5lh/9V7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2071.outbound.protection.outlook.com [40.107.92.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D104689;
	Tue, 21 Jan 2025 03:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737428916; cv=fail; b=QI57uYH+M0P1jw76/CRvwJipY9RXtkKzwSMAUk9w6T+yCQJQK8w8L9tJ14wAv6KihJu2JazVO8cZt9eMHokeWilxTp98ENLCUJetSlzdKdeQyNZRmP/zibEm33qm9rkUfDgpt2pL8Zakl2cV++eFB7oiQXhrdABXc9S57a4KW0g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737428916; c=relaxed/simple;
	bh=sMWZ1SJdS0vfN0Ea8VCzUcDAwR3Rw+buXhzy/d1neD4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=QH/K0sDlZvXbgjhZN2B8/JCcFNcmLWv5eWnZDaVlO0gplBT6EyaaDM/hKn9BWakyF0L2Tl0c3SQ+0YGCXuR63gy0gk86WDIaV8Toy6bM/eyAbvdEWNCHjx43sAVUsv+Bll4vblV2qGzAa175qJzSINj8UU9LtBERGWPOC8Ynk+g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=S5lh/9V7; arc=fail smtp.client-ip=40.107.92.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tzfekPyFepF8FV7Cjf0HilWG4Oolymx0GP8S3vmHBxqD18yg+JJT4q+bb84qbiZGbvYb8Vp/SeltfJPuXkbSyc01G0XGidKjkFzhqvt6gT50ZQ5gaghIdpTBObquNAtoWjd+dSghMARIpD+0V/oW/0yyegU/sIMl5Bw9pwy/9qWDOZ8U0cNm0t0biN/1Kt5uEQK1+FcFXjcfD5iXxymMwxgRAEuVdQAn2s1pBt2xvaJiM1OhlScIUZMnRVjSua22s9WE8Dpofd2kOGQfhYAlLPgyu9ECfNVEOa1jhDl25ssrKVDX+ejR876pZzEcDCHG8ChUKaGVx+jsfH1AGmFWRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nGZ1tqQU2RPG9mfqUYAFHRKyxuPTja0uCDl1C9z5kEM=;
 b=Vypa+H5wzX9vePpGCHLqlhGF2gUQ4r3W1wdE9p30rOULfBmDEC26zJjv+95vUcImnp9Ml/ofn95nvHKJZRTAK0Vpt3vGvyRC7RSr9uTJeH9/puFlofXHJj1fOmqxur/ghjyEO9++WUO3RD5BmvseI1Xs65fgdJvFXO+lJvOthrfImN6tPKcUGjAFFMsTjp2AgwUkSuPIZyNgMwKPcNw+31tDpcmqXSuoYY+4ZXFjrO26dMD8dkVv1en1LtaFXo7w3zQP3yS/YbIM5QBeAiv89YYJSAWI+Qw3RqJs1lv2N5Y1VlPRhJ+7YVvtYyUklsVDQN5vdC+hkzh122b7YR/Rdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nGZ1tqQU2RPG9mfqUYAFHRKyxuPTja0uCDl1C9z5kEM=;
 b=S5lh/9V7OY9pXAd7FyW4UpzqbwdsjIT1kN+Kn3Nqc28YzqHqQ+S9D3diZhlmbMep36ImqD2LCH3OOEHtG5LxMhjM0Q/+xEhRVKiqmvb9vVhZV/AsSspt1Z0JcN99FzTjtyRMCDmGDL5zNUngUaQXZeaAdoQCssCkjniYjJ5tyxZ5Fbm+mlbdX5Uvqj68s3RQBI1bFakfD6oazPlMOnrAH5iQnBMjyNLZwD7R2HrRgeYHySr1JKqkxLKpS0nrr+0SSwgrKykqV122sSfyQvzEq+U4yr4F06EE68Mg1NUM6kIKclZiDngR3zn3skRh3mmt3hzW4AJfsEAXSD5wtyxDTg==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 LV2PR11MB5998.namprd11.prod.outlook.com (2603:10b6:408:17e::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.22; Tue, 21 Jan
 2025 03:08:32 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8356.020; Tue, 21 Jan 2025
 03:08:32 +0000
From: <Tristram.Ha@microchip.com>
To: <andrew@lunn.ch>
CC: <olteanv@gmail.com>, <maxime.chevallier@bootlin.com>,
	<Woojung.Huh@microchip.com>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Topic: [PATCH net-next v2] net: dsa: microchip: Add SGMII port support
 to KSZ9477 switch
Thread-Index:
 AQHbZi6jUsb5OQZHf0qguVy2R8e1urMWcOoAgAEuMACAAohtsIAA1aiAgAC9nfCAAAjZAIAALAdwgAELSQCAA22VIIAALaaw
Date: Tue, 21 Jan 2025 03:08:31 +0000
Message-ID:
 <DM3PR11MB87360344983B11FF6485B2F9ECE62@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250114024704.36972-1-Tristram.Ha@microchip.com>
 <20250114160908.les2vsq42ivtrvqe@skbuf> <20250115111042.2bf22b61@fedora.home>
 <DM3PR11MB87361CADB3A3A26772B11EEEEC1B2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <91b52099-20de-4b6e-8b05-661e598a3ef3@lunn.ch>
 <DM3PR11MB873695894DC7B99A15357CCBECE52@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250118012632.qf4jmwz2bry43qqe@skbuf>
 <DM3PR11MB873610BA4FE0832FCB3CA5BAECE52@DM3PR11MB8736.namprd11.prod.outlook.com>
 <8ad501e1-a56c-48d5-bafb-125bc1099b7b@lunn.ch>
 <DM3PR11MB87365983C47EB7104CC4E9FDECE62@DM3PR11MB8736.namprd11.prod.outlook.com>
In-Reply-To:
 <DM3PR11MB87365983C47EB7104CC4E9FDECE62@DM3PR11MB8736.namprd11.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|LV2PR11MB5998:EE_
x-ms-office365-filtering-correlation-id: ff74023e-3c07-4e7b-46aa-08dd39c8e2e7
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?NAeJPmJANi9+oKyctd7/6D5gUYIG3NjppTswn1uv+152bKdkQ2F20i8VGbpp?=
 =?us-ascii?Q?JWia4froRrPl0QZVaZtkUyJOARRfoyCVgQz+6wxFFNSeN//cvVhjw4t4Lesk?=
 =?us-ascii?Q?LVO0AGjJCv6SzMK12006EaD0FuRK1qqlQJjIr3iPfUtAkmJF35YUhidYcFmy?=
 =?us-ascii?Q?2CM2Nr5B/LGb5FlCGoKxPhCSTw7832Txqhk2qfYuo867wyHpDNLx4nVZCGW/?=
 =?us-ascii?Q?yMJGPFibCBHHXSXFcvzmLxg7/QpxuDKobnZPXPLPG/Qkzfh29c4ULGc2Nryi?=
 =?us-ascii?Q?RxDsTg+6RCScFoUmYp56nw5T/0OC8UBoYPQwwtl1IfCJqLJS/ayeIWek62YK?=
 =?us-ascii?Q?U7iJbfZrY8B1GOwn2wHo1mSLGPmiI1ClSEFnlIN9aaInRDaw05ZZwup3RLDX?=
 =?us-ascii?Q?cj5ePFGAUcT24BfO/Ijl7JmrDeQ9KGapaF9Q8/TM71IdT4tKZHgNDtrFtyPq?=
 =?us-ascii?Q?AR5mFhM1SDmml2JPBQEpTKcLiTeS7s3DDoX6WrhWI2AOKknMXwDKQO/OVLGP?=
 =?us-ascii?Q?ezHAYRzgnyMbag2xUFVL2/jw0oCRIod0jlOACPG5A7MVglMnyH6wTPdIHEvY?=
 =?us-ascii?Q?BtYcb4RazNdq7rOs2O5Rwhl0zN8DLPzRc6iK4OFs5vpDLHpoiRLEs/cICRl2?=
 =?us-ascii?Q?k6bYlnrmr6SjX7cn4SlticDOnR8I2RQOGBctw+TiVz+Qx0z/79oeUROru3AL?=
 =?us-ascii?Q?tgWZYEYKnARCDPS+uslaTaWscgJzFRJeTL0MKA9DUnbJI/1f9BRYJKXA4nx4?=
 =?us-ascii?Q?RMqhqjlAdStrvS1UcL6iSfRJBCKTrSPVK2X+cJTc4VX7wKMFlS1TbhdTcdXy?=
 =?us-ascii?Q?K5aCXjiwSBMU3iTWq0X/g5shX3X3CxyCDscDIl8cibR7gv7lsfFIDakXsyvj?=
 =?us-ascii?Q?DLI1PO4CTb+y+JUhXEnq9ydTJ7NsQj0sgK8rxzjwGLapAPM+ouLxMc94qk6t?=
 =?us-ascii?Q?D3H/CIdpvrbsnDkIBNSbMAr8BzvxzwQxsaRd63yZJwhlyL1Zmjon0HA4TV27?=
 =?us-ascii?Q?mTMSlusXx0gA7RGx/Ne0+F6nFoEjQiPm6kYwyn/3ydBVvZTSAMKhjPhncY2T?=
 =?us-ascii?Q?gCFlVIctzKYHWyprJKUPVmGna6uCW3S1xIhalHXDmHzGuVy5Uw6mk8DJR6PS?=
 =?us-ascii?Q?omUGfUQ/s2e0JndBxxpA9imAYoUKWOxxmYytuCPwP3NVA3MvLPbZzQ9QPVFB?=
 =?us-ascii?Q?3EIbbDI1v26WGea6lxA8v+K86dewSGfti+4d9AfFrIsFVTolzfEpL0CbEl+1?=
 =?us-ascii?Q?SRU0Cz45YjWAFySQscXPhPf8Y6Bq+2fmNIHbDPJf3T/2ZhuAmB0zH6z8ulMK?=
 =?us-ascii?Q?jb9afSLJmxlecrsi7YQ/4oFjsjeCseM2Y9aQogTpxaIYz/Ew00xJVGuDsAyB?=
 =?us-ascii?Q?omDaNIffy/Fi/lgV8mifQYHqNtQ00wGTH0mZY9LbN/K29hSol+Co3D8WT2fW?=
 =?us-ascii?Q?Jcv5603EgE3QHF05oxrIQ2Evsve/XINC?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jc6RVmTSRonFhR7ZXkXPqEs2BHRzzmTXgQevovuJeoTELQ9VmFhKVLhshNEu?=
 =?us-ascii?Q?POiH4OXO32u2ZQoFuIDNKQO4lzmR8l3ecGeJRlLreIzzekrsnT2furbkManw?=
 =?us-ascii?Q?OaKiCiTESSsD6MNeQnwyBiTAqLZNzFRxojU2pCUvK6He1I3spq0P9PxxHmDl?=
 =?us-ascii?Q?nNOKU/012dEHzAZbvIyajtGzGFRG/JpbANwvzaDSm0tn3V/cRaKVOQpLIC6S?=
 =?us-ascii?Q?3dUvPZwrUQdEgHFHi1/0ccrUv/5qRXl21MA2ZL3d1+ZN8o5MEBaeDWM19rzl?=
 =?us-ascii?Q?3guLFPerKyf4XwoXaMnF4TfcGDVVPag3onmOTc1DakQBjn26T28MAQyao/JP?=
 =?us-ascii?Q?Lgv6DUDY/b1Do875tgYX31w+4Ou1VGFa6iVJaALSokOapySlEcIYlLJvVMDd?=
 =?us-ascii?Q?GGD4QQAyLEvyJdRfLJPTI0x1lh6LTm7YaqKfaF1X9SZ7M6cZtrXQI/zczXoF?=
 =?us-ascii?Q?JEwBJn/7xp8ZvUwmZ82uPbv8dp87k/+MBDMABI/grztJ7361484g9XKWSVYX?=
 =?us-ascii?Q?E9Ccw8a28LJeYbG0+cbDcUKLH1UebzuJNAePu/HkfLRnEsse60KaUolvQde/?=
 =?us-ascii?Q?MImvFajluvTKRaYpZjgoJrFHvy/im/2uPmrz8qacM8nmP+ObrVn39e9y3CXR?=
 =?us-ascii?Q?8ttqA/ozuCcqxnywx3KkhyA4yB8CKK91kVc7IlbbcDSt/vHrXDrSJs7SFg2n?=
 =?us-ascii?Q?HlDCEB+Xr9HRap5HmNOm9aR0vkT9v8NXSkSECDwNnMCaXKtAXjPAd6EE7vEd?=
 =?us-ascii?Q?OvDsPhU/A/5oZUUVkQlAdPl2BMrYIPqfcScjn2HBMAgr+rRr016FObGqI0yH?=
 =?us-ascii?Q?ItxN8NuFg7iqB8E48qb3mNvSLKEYjZhs8gOkSm1rjrnfmSKp/GgHkYDerd+y?=
 =?us-ascii?Q?MctlSmLinG4SmAJ+GfUKwQdWOcYJb8bDcs6P6R4C6vl0V3G6pIANxyau9MFX?=
 =?us-ascii?Q?HufZF3dwqcrkHHXDxuzavdn5D84ce6HuFyRO7ipRlydP+kdez4HPXDAaPQn8?=
 =?us-ascii?Q?g6O1dNqr9/6BmSaJMc+MHuOrz0GZpbAFp4i4K+Zw2YKb7VG0pH2uTsHqB6z1?=
 =?us-ascii?Q?Ovw8+GKd8ucd0US2Za54JnexX0iPzkXxv5nmiX7ajf6ybNAY6eh0glaX/xFa?=
 =?us-ascii?Q?pdyM867ucZdEkkIOeWAmYjsF/bZUVGEnNSSKVT28ej7KqLK24J3dIVed11oK?=
 =?us-ascii?Q?aobeyEIERcCMsiid9fFKosuPntR4IEjclBBpUqNBJ6vRWOgxfTTclhgL+ACx?=
 =?us-ascii?Q?5EHV3eJkf75EYw6TjJXi7yI9DQjCFKRBootZqX9y9dsvZ2y6NbMgSF/GZWQo?=
 =?us-ascii?Q?eAqHc6fHuwnsq/UeG8UFF/22kaPqSlkcGOMAQ1Cspn4FBvLnneXYwbtYNlya?=
 =?us-ascii?Q?VZoMMmkrJADk3C4DD/zAwb6tpKUOEkGUG6PmXOw9SB8qp0CQKQPKo4b4+Kp8?=
 =?us-ascii?Q?ACKxpgz9eP8jdCdsRgqDuusaqG5We+kOFNzW8/URGK/lw4KvwBDeXfSL3lK9?=
 =?us-ascii?Q?QqVGKRHwmaXD70UQlBSlPv5ve7moKDqLq9tTjMYndy04+5uh53olV/OPjV7x?=
 =?us-ascii?Q?0UltWujdNHJm4ahNp91bk1CGWeUW5ONg/DRySq5u?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ff74023e-3c07-4e7b-46aa-08dd39c8e2e7
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Jan 2025 03:08:31.8973
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: aNs2Fs5cFSPu89eOAY6wzJ7ftL2XFKRW28Qlobc4V0Z18+JVh9PRfUxXFxnsgutdnSIUv8UD9hk3qwqq5gOJ/dHzCm4ro1XCm62Z32EC+vM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB5998

> > > 0x1f8001 needs to be written 0x18 in 1000BaseX mode, but the XPCS dri=
ver
> > > does not do anything, and bit 4 is not defined in the driver.
> >
> > Does the Synopsis data book describe this bit, for the version of the
> > IP you have? Is it described in later version?
>=20
> It is definitely defined in Synopsys SGMII IP document Microchip used.
> It is named SGMII_LINK_STS where 1 means link up and 0 means link down.
> It is used in combination with TX_CONFIG, bit 3.
>=20
> It appears in latest SGMII IP document where 2.5G is supported.  To use
> 2.5G some other registers need to be changed to set the clock.  This
> procedure does not seem to appear in XPCS driver for the Synopsys IP.  I
> think a similar pma_config like NXP can be added, so I wonder if the 2.5G
> support is complete.
>=20
> The KSZ9477 SGMII module has a bug that the MII_BMCR register needs to be
> updated with the correct speed when the link speed is changed in SGMII
> mode.  The XPCS driver seems to skip that in the link_up API.
>=20
> The device id for Sysnopsys is 0x7996ced0.  It does not have any revision
> so it cannot be used for differentiation.
>=20
> I can send a patch with RFC label for somebody to verify the code, but I
> do not really know how to update the XPCS driver to not break other
> DesignWare implementations if the new code is not compatible.

Additional comments:

If neg_mode is set to false in the XPCS driver then it works for
1000BaseX mode as auto-negotiation is disabled, but then it does not work
in SGMII mode as auto-negotiation is required.  When 0x18 is written
enabling auto-negotiation still works for 1000BaseX mode.

As MII_BMCR needs to be updated for different speeds in SGMII mode the
check for neg_mode needs to be changed, and auto-negotiation needs to be
enabled.  This bug workaround needs to be done somehow with other means.

The initial check for link returns invalid link up as it just compares
the interrupt bit value.  This is incorrect in SGMII mode.  It can be
fixed with additional check for 1000BaseX mode.



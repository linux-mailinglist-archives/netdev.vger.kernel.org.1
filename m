Return-Path: <netdev+bounces-161430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A142A215AA
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 01:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53242188896D
	for <lists+netdev@lfdr.de>; Wed, 29 Jan 2025 00:31:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD21517BB21;
	Wed, 29 Jan 2025 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="DBjfxND/"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2051.outbound.protection.outlook.com [40.107.101.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18BD742A8B;
	Wed, 29 Jan 2025 00:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738110678; cv=fail; b=Vyz+WRn6km4B/198qritivCsJtv/pr/nYf6vjizMgJ3bb92yI6bxU+Eeg5CTmD1zy7/Nm5dNsEP/jBpAj9OqyUk88MlSlvvUUjMtP9jZP7UdN6NhvCmdX2WeQl4q1uPKffsz1GH4XMipyJhdB/HRrieI2Vfjjbb7tj08K03i5yo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738110678; c=relaxed/simple;
	bh=xYka+GanbZhlu9/uyygKDXRTr/hsowJdhN1Sb/inQko=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=dzaB3unhvt5bOA41XeFWdl4b5zVxODZwJot5ynP4bOhKqt8YfXPjx5S/GEGRvsS/dZo4YHHtKCU6fxfMGoLz4j5y02DUHc8NWdZAB4QL/9uZ+/6S/A/g4Bj3OFwakrQ40+8NWBD7DjqFljnGLoeD77H4iC9quKTy6FmfkpWpAqQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=DBjfxND/; arc=fail smtp.client-ip=40.107.101.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pvPnyjguuihE/8bM3Wir562aJQrGVY35uAETKSHioiMaIWyXT43creW2A6ChRffENTD7fd9GiSOifIZVMXBEmKAkjoHqWYkR2UeD/yrXW6nGS3hfS3jWQRjnimXXPMFwDyb9rb9OyMBJJjuaI+vQ7h68rtHkRvlNOcM8aKO9ytX56L22Iu5z7c6V9LQzWkvKqZuDblwFJfbgWMibCMSSkFz4Yhb52SQ8gOqzjsiIU4fDwLJ4Yv1y5p1WDePqnf3FRYpRRzkmD9vmt7+P0S+lsERwD8VrqR25iWmq6Lyt4BJZEx81cpb7JlIrT6hgidEytt1LsxR0NPm/XW/7yOAp2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UVmeX9hPsWXPibsVr9NUkqn2/eBpwX0Yf0KTvXkHlk=;
 b=CmBrPHPtpUDfjCb71NOud6T16r96/y/WLEbMfKmLWL7ClwUsFqswbT93kIePuJjY5Qq2r5DR8jWvam7fExWTNCpauZO5YjP+KUqhCUzo0IPyCnLu6CacKk6F1MFfCm+PGGyKsFVKTvddAssT4Lo579XWNewXfwtK6odoqqjzrxvBayiNz4jcngXzxZSa1pIrr8mC2flfmzObaOBV1sOMIJq/PXsidR7iJZuusKtNkZZPBSGmaZGQbiAhcexZlEvI09BafFyefPaf4JEA2/qQK8NeqbPg4WLM0z3fBECKnMPW2iXA2j1laVgUhyfmlr0Cs3OcItib7l2fbKclh9th2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UVmeX9hPsWXPibsVr9NUkqn2/eBpwX0Yf0KTvXkHlk=;
 b=DBjfxND/qD7jJ36o5hD8hie6iI6ZWH1JXqF8/ysklER1LKRKSgexDNsVIgT042zPS+a1zEwwO/GeVNuGRiDZjbSZ0FoJ9CHw9oM+iDWb12xVEgF14tq4IyRz/QZXrX+5zWWlZthXv0pcOfgR3WjJuvcKfvVskRgVzzgTDDMINGm/hCaVGH67XFjMXo45qq9i1Gt1+NxRhSZIycmqY0zuRR+uiJpRvyd6NI8uQ9z3eVijDBqQ3u4f1m6vgarPUGoh3XZefRUKYAIQtEd0HWaBqODxzLB5HIvj0hPopij6ttBvIJLFzh8suKfXcWxPrQm9q1gv8he2qmTMnmHxvVjGgA==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 PH0PR11MB5805.namprd11.prod.outlook.com (2603:10b6:510:14a::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8377.21; Wed, 29 Jan
 2025 00:31:12 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8377.021; Wed, 29 Jan 2025
 00:31:12 +0000
From: <Tristram.Ha@microchip.com>
To: <olteanv@gmail.com>
CC: <Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<linux@armlinux.org.uk>, <maxime.chevallier@bootlin.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <UNGLinuxDriver@microchip.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Thread-Topic: [PATCH RFC net-next 1/2] net: pcs: xpcs: Add special code to
 operate in Microchip KSZ9477 switch
Thread-Index: AQHbcTVTuivbdfDuaUSUZ/9LsKZxAbMsVDmAgACHHKA=
Date: Wed, 29 Jan 2025 00:31:12 +0000
Message-ID:
 <DM3PR11MB8736F40CD4BE7FC3E04544E0ECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <20250128154305.sqp55y5d5lc3d5tj@skbuf>
In-Reply-To: <20250128154305.sqp55y5d5lc3d5tj@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|PH0PR11MB5805:EE_
x-ms-office365-filtering-correlation-id: 527f0fc3-24f0-4031-6a1d-08dd3ffc3b9d
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?qNuqwP3e+I6F11JHTt6tWd9YwfQa6YCEww5X0BrxRMeRSORJ1AK1v1hvFp/Q?=
 =?us-ascii?Q?rVvQrAhzu8jnrRUhnwKPTOQYk8x+is5VC8arP9rVSaNJEpXMyPhYW+kvvR+g?=
 =?us-ascii?Q?aQZD/MAdfhNw2D9354keKXJcVe3rkxd3gajBWvKJE99XaCBV+N7OuOnqVD6M?=
 =?us-ascii?Q?XvhChtRzbp06YFTbp1KzBhQlXmm24mu+hLKU7cHj6dh/l6pQ6IuuZkTsJMl7?=
 =?us-ascii?Q?WTGFWkSLOMVljncxZr7+L3HzNdzJ9/4Ax/tpp1F4STAs3cOgYZ3SwIaiVlEc?=
 =?us-ascii?Q?0bNnMPfgnw8gu7e54/HeIFzNddOhDSRbTs5MzODDlAq7ipgYHoQkM1jF8+pN?=
 =?us-ascii?Q?PQoN/sYwH0pQPCPXryZr1xMEOIeqIXBB5zfHBnvBikjHw+OjyHjwwJzLLGjJ?=
 =?us-ascii?Q?aEQDjtnTwvIZrMiq9mZtf4gxAiPe4lqsKNbscjOFUQpfJ8lcbaYH6UK3wDhu?=
 =?us-ascii?Q?99odVmSEq5oSW5zgnVQRkyiRKwBHYGSlPcXw7oeJPH8xcME8/eurYOIcyth2?=
 =?us-ascii?Q?wKxZz09b95SAf7mwDOmxqRjyjVvBr32QM3Whe0cGFJC9qxNMzsykHkAKB+0J?=
 =?us-ascii?Q?5YeF1XASowr71r77iVsuBxQTFdqj/i04uLkiNpm895YEsWHWElUII63GGweC?=
 =?us-ascii?Q?Ut/q7dzNSlDcSdmp1xHAfKOFeEGJnN04MCFDMsXXbxycaX0pkdVJ9gsO7TdR?=
 =?us-ascii?Q?1fjhAO7hwtuPI8JPr/g/CW0gZ+tfWDfQcpCHFYhfcbl77xbErIsv1UuzrQ7d?=
 =?us-ascii?Q?OXbJzJ62PpxqaE1S0JN0rj43FiCswAblNDcl3xpLhnVVgjRES+J6ZKR0e9x9?=
 =?us-ascii?Q?GZgBT5Xuh0UFnusX+I2TzoeG6H6rZVRefVcMvpcx+YVYnWtfC3QLkAI+CNcI?=
 =?us-ascii?Q?hPVP+aYqJLra/P38om45+6wEfnsJSEf6GfQ/KIe/6O5Ni9bndxxw0Uk9Q/FX?=
 =?us-ascii?Q?WYDFdw/95b5o/1bB3TlrUIfPXyqXphWMT78Mq5s8kTwEf2fcz32CHiomx+fw?=
 =?us-ascii?Q?to5Cjhz8CKDqYB7IJVeTlOoU4PkL/ZCBU7fJsAS03abhOFYSQORQwdFVIxNj?=
 =?us-ascii?Q?i4DLoIEg2efIBpaciq42fbqipInftZFTrjD2klVjBfMjCFLu8GKW7xkacQyD?=
 =?us-ascii?Q?r95V5i9wCp05UdrRhO59TeN7WrzVHuV5sdCik3NT5unDKGAbMP7454/oojjs?=
 =?us-ascii?Q?1ERZ4NFDJKaSPwKm/709ViG/cyQwKKjedk9DmBBDKzPZtDRMk1FRgQ4DEfmE?=
 =?us-ascii?Q?lHZchhP6XhU1UJKxvpRbHtCThptpvCl1/HLxnEMUPSqBM6QKm2vulU3Uu0Az?=
 =?us-ascii?Q?tI5hPYz3w0XRl6za+Nt/bPqmnHXhcdGhbCBjSw9X3cDv3BoRD0QO5h6Vcvpg?=
 =?us-ascii?Q?fpQrQs017wDmbPFAyshNB7hiIoFAnJNH9zXFoELSeXA6UkDVJSsPJGEFqqyG?=
 =?us-ascii?Q?+QKhiT4OT9eG2vSHAEI4tjeOGz1A7E15?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/RMNBjiDw7K+jMODlYEEsohijh6pa5huMc1qQHL9/iy5BFTX5NjQljDYUVu2?=
 =?us-ascii?Q?dVi14wZmiEMXzqmKLfsAuLKafiYjKOdVz30bVGK9noUJwFJxBImB1nIegmUP?=
 =?us-ascii?Q?X7mYpfC1p1wW3tuoMUX08bIcVzIxNGSEADJVFgCsvgNNJ+j1MpgXNSbdkwQl?=
 =?us-ascii?Q?cIOlk3NpAMIbM+LU1NhUuHHegl0ygjJ7U8EUY9A6QZsDOx5Ij7LKFq51r0kd?=
 =?us-ascii?Q?c1m6hsRM7E9x36C46KbOr/wu+msQbmPHWTviceLvt+IokIDfC/q/EdWKhoW2?=
 =?us-ascii?Q?U1soI4IET8SgsMewHFf+KX+kmJ7BFrMkACipvNj0VQbA7BsNcHyvzKDsxZGN?=
 =?us-ascii?Q?VjzN5AVVHEgpUWgW8M3hde5eh4zyUjY+SgSlIL5EQQYqagQ6XY2FY9IDPF99?=
 =?us-ascii?Q?8CmyQ+bnrhTZv0QPa9AdhMDJAFGDh9OpRNeVXfDNu/R1/SFlanAf3h/DheoO?=
 =?us-ascii?Q?gXEIR8rwgM19wBhCYfKIvhxq+3PpmGKq45O72rBfa/HbK4ejhAyyxtVE/SMP?=
 =?us-ascii?Q?I5CreYOUS4yRiR8qh8JwEMKVa2FaNAvqRFJtScZsPUCE9cRSgvC60XPDewod?=
 =?us-ascii?Q?FjZV3p9vWecerqdUXBRmq9s4K5ECgwFSqzpCTExhnDvMbhMJtW78F/aagY19?=
 =?us-ascii?Q?WuYcp+f6Cn9X+aTD8BHr4lZaUXej+a0STNPQOzAsBMJEBGQ9D7yJcwi0vcZ5?=
 =?us-ascii?Q?H0qE2gQNoYFPX+PWKqxQSUsWpii78SDHiilraKhj6cvWer0Ay9Vbt1tZWy+c?=
 =?us-ascii?Q?195hGRAqXu6cLq/xdJDFsxl4xbECHaHl5VN0XvimbofZc7cWe9GZlYzZCIz3?=
 =?us-ascii?Q?00aSM5aye7xFbfA1E5RqCYlOTXMcoBA2aUIBAudRC2y0o5wXBbK8psBl1uLr?=
 =?us-ascii?Q?nmKGFRb+I2VoXPLLIOhtPnGiDCR6VsFhkvs49Jhx72+o+uomEv02JeRRqnad?=
 =?us-ascii?Q?HT4BXOwfN1CuFAiuH/6hzYcg4oql4js/YeWxTIJ6IxXC9rQhMYRLW5shTfJh?=
 =?us-ascii?Q?t9RTAKZT+F1kLLrDa8rEScqPqwzh8v6PMaAfS78yXUORHmKPseZZAGHsBo5l?=
 =?us-ascii?Q?HT3EXU8OxgOvvgSMZ9e9Y7mulLCBn8vdYznBnPVWdRd5CI5UQYxxRrWqZLts?=
 =?us-ascii?Q?vDa9KvhJfQb/KPz1vco2Ydhhe0zpct2pgsi8SDYEiuv/LpNzcxcGhhDWhzjI?=
 =?us-ascii?Q?DJw/wFcm7k0sLJTxA9VjMZdNGPMwc7jtVU9q4hnhY8qMc7BFzIS5wk01mEJR?=
 =?us-ascii?Q?y8+IkQVZwEbEDGevR1NQfv45dwaB43p799deQyMNyU5kXdzb5lPNQga8cU3e?=
 =?us-ascii?Q?e6fg+5ZJxts403UY8QAgn/k6ukKsSS10Bl96Jt26a2/Vq8lbZ4v8WzlmT0Qg?=
 =?us-ascii?Q?/tO5Vx7Q2DWbb7YSd6KH6LMAg4ot+zObq8uedJWvGl1B33TMnn8IbkyE/raJ?=
 =?us-ascii?Q?Azbp9235AWdwx9249qSygSLMboGVq2EK2jc2m6iTlSiDADBEmIAPpp1YixqI?=
 =?us-ascii?Q?ed6DA3zyf51MxlvIKiksu50ruiXI4sAKtV66HhThUCQ6bOda0Ecf110M/6gc?=
 =?us-ascii?Q?ZirFbLOR4NaFNzTR3SwSD3pYlek0/Qz/dbzSzQwy?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 527f0fc3-24f0-4031-6a1d-08dd3ffc3b9d
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jan 2025 00:31:12.0365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: I57JgKyw8q2w1Bl1K93uPGvQKT/gnWlTjutEfNI7r2vqgLi4dowMwpwrT28wcuM4+ABHhyctZHP4zHs4AmmDOmPhW3h/x3t6IwUpSKGRLMw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5805

> On Mon, Jan 27, 2025 at 07:32:25PM -0800, Tristram.Ha@microchip.com wrote=
:
> > However SGMII mode in KSZ9477 has a bug in which the current speed
> > needs to be set in MII_BMCR to pass traffic.  The current driver code
> > does not do anything when link is up with auto-negotiation enabled, so
> > that code needs to be changed for KSZ9477.
>=20
> Does this claimed SGMII bug have an erratum number like Microchip usually
> assign for something this serious? Is it something we can look up?

KSZ9477 errata module 7 indicates the MII_ADVERTISE register needs to be
set 0x01A0.  This is done with phylink_mii_c22_pcs_encode_advertisement()
but only for 1000BaseX mode.  I probably need to add that code in SGMII
configuration.  The default value of this register is 0x20.  This update
depends on SFP.  So far I did not find a SGMII SFP that requires this
setting.  This issue is more like the hardware did not set the default
value properly.

KSZ9477 errata module 8 indicates the MII_BMCR register needs to be
updated with the correct speed setting.



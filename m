Return-Path: <netdev+bounces-164848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B11BAA2F5ED
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 18:53:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3F30E3A8EA4
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 17:52:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF452566DA;
	Mon, 10 Feb 2025 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="rORKY45b"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2048.outbound.protection.outlook.com [40.107.220.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9A2566DD
	for <netdev@vger.kernel.org>; Mon, 10 Feb 2025 17:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739209864; cv=fail; b=iPCTDy2csE4hrxU4L84o4/zJyMGBvsP2khJXOvDU4O247OlkSm/wePkPlbKQIlYzg/dyr3BKwvGR9e0gZumHuhEnbqBnD+vZg1l53GkrdxvSVbPJQSAVfGucRmbGB2AEa2BjJ5M9UQnGGqFAD5UaGfNj/OzSJJvy8lndoFT+R5g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739209864; c=relaxed/simple;
	bh=ldAt6ajbsctuNjP0m8YDSG6q0IguSvrStfoHY4Kn+u8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V79ZoBrrX3zPe/++W4nXbM30GoLPGzDhVvVORHywE47nTm4bsp/1zNlKOZ9KZr8wiRX+OXPJ9T58RqjA42Yv25Jbe+wQUgZ65O/XEnOPsXyXtYxrr9BLROA79uBYbMBnwkwGftiBmHj47dbRywAh1TbkYjiG3A4BK2vLVrmvyE4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=rORKY45b; arc=fail smtp.client-ip=40.107.220.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q/u+TUQqLbX+rM3HJxnjHLJLFpaq2d1BdUuZbFyVnB57fjzwQJiTcvnLLLrkbCeG6BdKkhDLfEMk0KlnzyEV/AoTfLgGzpUA/9VFSNF/b2ghFmbSFbMEPb6j1ZWMF0CYMfmYiFmFymS2rR5gm9So+yF5vIYSa9pDgVGXq2OUHXywbMK9IxmrqbFW/ykxKMEcqWxYmfIR6PZtiQUrarQbpAAtAMHEN9ufifXpHehqbOgecYOmae/kAFFQ/zEZPQs33TcnLtyoZWCmb3xroe+uOhzmaAyN6XiiItrFcwG5l9q9OFc33RfPL76ydZvSYy+jSgiwTmsnZ3xZ1wtOsBe2TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BlHXK1VlmLJR4Ry+8L4x+DjBPsu3Eo7+GiG0B1nfWVU=;
 b=XJGMpq2MuKz+Z4dvM4qpsJUra1Mo09nwovxmCuykRlxW2AQ1JbTsptblzYP8Yvl0A8Bpy9uRVX37dOBmsKzT2Mb0BOZUoirQgEJitxkM5OfJYhTB8u5om9mX6ZA+pAW0PS4tZs448yZp2UBdKrfKPfBzQ1yiYeU6VNZBn28nf9/rv/k6si4YXTpYnzwpody6yBT28ixmyw5kSJHvF2k4BkKGpW7LvU1Y58os4VikasYoTbPW39DSwUVvMBmh7R6+rize6q7BoSy1xfmtnEuahvlTwykXOP2SCRtzVKtVMSvsh5BM3auqcwPj5EK45d1/e4iADMfcCsg8EiGMhqN20Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BlHXK1VlmLJR4Ry+8L4x+DjBPsu3Eo7+GiG0B1nfWVU=;
 b=rORKY45bjzz1Cyz55r0zkxXU48RKYNNTEED23iaXJrNgHnMdOSVhqaf6FR+Lrayd/pGmk2QIZGb4hEdhvE6pMH6Zx0QzyXhMZaYkk2rv14wthN/KukTty4tmLmdnsOGXSO3wFCj3WNo70aRU9uAlsUnsCMVx9Bf0IzfnPey+SndeCPAhc8NMFcGcmkPsYQy/MJn6y9BArXN0EwMtVMb0QSBz/SJv6wyzBghOzbITwC4FVJR+NZ+vJGPE8BKk9Z9DICBxzmpmRi1jaAXdfpCSabz2Ou/1/Yoy5zbNM9BFUhKxKMekhF1VYjPWPvNaZNXV6l1LMV3rjjPz42rH/AndGg==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 SN7PR11MB7140.namprd11.prod.outlook.com (2603:10b6:806:2a3::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Mon, 10 Feb
 2025 17:50:57 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8422.015; Mon, 10 Feb 2025
 17:50:57 +0000
From: <Tristram.Ha@microchip.com>
To: <T.Scherer@eckelmann.de>
CC: <netdev@vger.kernel.org>, <Woojung.Huh@microchip.com>,
	<UNGLinuxDriver@microchip.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <horms@kernel.org>, <linux@rasmusvillemoes.dk>,
	<kernel@pengutronix.de>
Subject: RE: [PATCH] net: dsa: microchip: KSZ8563 register regmap alignment to
 32 bit boundaries
Thread-Topic: [PATCH] net: dsa: microchip: KSZ8563 register regmap alignment
 to 32 bit boundaries
Thread-Index: AQHbeJHqGv7WFh8IpEqW7eFrNskOm7M8mJaAgAQ0YICAAAlk0A==
Date: Mon, 10 Feb 2025 17:50:57 +0000
Message-ID:
 <DM3PR11MB8736BC7EF3A66720427F3775ECF22@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250206122246.58115-1-t.scherer@eckelmann.de>
 <20250207170037.06d853af@kernel.org>
 <xsvd6wfty5qq5k3c5rzhuyclef5fy2e2lc4fgwo2sa56qchjeh@ooeq4mtxqncl>
In-Reply-To: <xsvd6wfty5qq5k3c5rzhuyclef5fy2e2lc4fgwo2sa56qchjeh@ooeq4mtxqncl>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|SN7PR11MB7140:EE_
x-ms-office365-filtering-correlation-id: 35e532c5-802c-4dbd-425b-08dd49fb792c
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(7053199007)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|7053199007|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zm/DZopMb1pBCcRB1uht2OFyMmBpGojw8mBQgSZWDzgyH5MaKG/WkcEhL+3J?=
 =?us-ascii?Q?EJXLh0qNVUY2fldGOzvm7/jLd4j614XPxqqovph4fQ0/IZx2UTFBExkr352d?=
 =?us-ascii?Q?35jZK7vNPvhOGnrzzf/2XSTy8qMwapsG3oM1xzbhkEHaPbss5RWWWbuuNyCb?=
 =?us-ascii?Q?c8OTZ1yQMdbYeozU58uxez6ZfcN1weQK1iHHw6kClymATNiCVXBAQQmDTMVg?=
 =?us-ascii?Q?4Lp5GpcZU3IgY4Lp3yhgz6nKzMQeMJMJ2VyetFl3X9HhI2AgnV3KYw/ULNqT?=
 =?us-ascii?Q?aMaM0q795bgU+HX5bkZ2qeR+/2OP7nUxkZCCjC53po13xYKA6VeVqt0a9WO8?=
 =?us-ascii?Q?Gi2kHNGnYnBms0tLGxO9gR7+WYJFIMtoCbQGeXOhnm/nKGXas1TY9JC90qhL?=
 =?us-ascii?Q?Sg18sFYhioseaMdRN5+16GyX8YN4HVgzyK3t77ZudLR4Dr14NuU9O5b4k+Iz?=
 =?us-ascii?Q?CnyEL50VyTaaWZjRbT7va6xRClliQliPQmWcgT3+Wf51m/oDKlJcCFzy92De?=
 =?us-ascii?Q?/HT9CnMj2KCrhzB/3hpmZBfkpBdeJPd/gmlCTfSIEmPg+EUh/CFjrn0DNl6d?=
 =?us-ascii?Q?BKhz4mW+7WhCe0m/cP/Qs0AX0/eZtbbJr98j5iDHxVvyWYDbwerOUfMfedW/?=
 =?us-ascii?Q?sObICuui1yTheK7BuR5Rm7l9z8ordUgkN2HWEugSlIRWHvKrasFsJy7SsVj9?=
 =?us-ascii?Q?XTp/+VDoSXuK4UUfUHCyACp85tDwVOTwlG2LaAkM+djJ0H9P6K1rzck1AyUA?=
 =?us-ascii?Q?K/TZDH2cc5+TWNkKt+gAgIqVOTh3RQJl3Cm88eiBzMSeW3N+LX+6Bq4Cz/Vb?=
 =?us-ascii?Q?mcXbosxf9rGNMIP+geVaSNk/CY1Lp5bMXMI/ojqM/Y1PwgX8cMxkeo0OztSE?=
 =?us-ascii?Q?GnSI5dVIwf4ToGITS4oxsNddnGHn9XfE/bAltqvMnvUURaPRS739zLHjyGBo?=
 =?us-ascii?Q?upIGZOE7SOz4ooGi46j064q0qhTBhsLopcs5ROsdt8mVIqlAyBmTAhZpzuEZ?=
 =?us-ascii?Q?IWAgEo+p8PKOA7eWEdOrSQf9HhkLAd184Fc2aSwK7MeT0xh0ZkyuRHD0A807?=
 =?us-ascii?Q?95dJNokMrb8vCinhRxS8z67BLq3W/+cuUEsIAlv2tUNMwoip31yCUu0wLiJC?=
 =?us-ascii?Q?w2BDenK4K1PlnAz7LZMwBe/4P4yJVSge7FW75VrpdqRNfZMEFbVyNreZgF6W?=
 =?us-ascii?Q?sAlAXDWRLBkUDj875AgEEBGsmxDWdS3HNpbc2NRe6jT7YUOfYMseDuoK3yD8?=
 =?us-ascii?Q?EGkzPkU04G3whumzT5Tdpta9xj3aft7mJL9CWrhU9vktTvPgpq44K1RQHQx2?=
 =?us-ascii?Q?64UA7Pzn2Q0J/V0P5YnfF1amEbMg9rJKwm5z8mApmu44vR+zXU39t+ErDffh?=
 =?us-ascii?Q?+9K1av/pCxdAcfsFXib8JGJy00jfNbljWKhL4FQ0t4Dcw2tKtWR17D6ZnG4w?=
 =?us-ascii?Q?NAfNT3V6duaUr+vm5C/pw9n8CSmmyqEf?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?6BFaRxy7HcNeOphakBCsEKH8KifGq7uMj/SfefQsBuqSearan9h6o48UegdJ?=
 =?us-ascii?Q?uQEpkMWLpQTcQUO2ZI3gJzWgZzx7wBXirSQEYAtLOJ25WHEvKZTXo9qnyRxz?=
 =?us-ascii?Q?ojMHps8NrC115UiVkfZRFrYYowA0SpLd6ntMV2CNfUlAqoXtcave8jZbZruU?=
 =?us-ascii?Q?gs+Y2hUCEMmqn38jYzlllSdMZZDhHNM+PRp73wyjz3eEt2XdiRyU7ZFN/L7H?=
 =?us-ascii?Q?Id4kJgsMkz3Gx6GlhU0Ey7GEM6U1QUWA+uIU09FzAa/yJUV0keZx48RsqwbK?=
 =?us-ascii?Q?viUJCa7a8KIxRwf/FiAXjIa0su3Uz+sJJ0jU97Ut9oBsxPU2cjCd3WHmKQ/V?=
 =?us-ascii?Q?6zOzuxbYd8HeBEVPKXeudLOUkEGV2a6v25/HFbqyVQj0Dsv0MH8ZiP+qs7K0?=
 =?us-ascii?Q?BiSn7TmXIYdEYFRMkvzJ3URbjB3l2EG2NHAfsBUYqrTi3b2bQrGqMK27+562?=
 =?us-ascii?Q?5wtTXSzsml0Uj/nKaQ7gzXq+4Qo0BbyXD3seNSwDucHkBtSruRpH2FU1YhSg?=
 =?us-ascii?Q?gMTWR9Frax32rHkmGG1/+qDgteytT6ncorC6MTvr/68NGP4rFTnRcf4Fv1eU?=
 =?us-ascii?Q?zXBD2qewfjI6+axTjxRHqttD1ctIInhJp+nN3B8/UVDdIegE/4nl3V2gmzrR?=
 =?us-ascii?Q?syP67OAfdr8YNZeVtmu1tbuV/HXF5J2uMlffGRgHo0cCmOEWxoqT7ZhmvX/I?=
 =?us-ascii?Q?GSa+ibojcLi2n/Nv91DDqGx0kvPnG9/Z5fEag0PXLCyx7pNYr6r1SMU4evFT?=
 =?us-ascii?Q?RiCrOoj5+LX5p+d1Yn7VC7SPLw/8gHOJpN/HhZ5DjhO6VlGfn2/E+NCxcVDE?=
 =?us-ascii?Q?4Zv2N67bsgVWhyDpg/hgNx1V/PvaEvZjvwEuijc/2bpoyKCp9b3I1mosSYzZ?=
 =?us-ascii?Q?mqrxLFnl+OxUnfh215Bm7x13SiiNJaverUDbqDVKafts2ExmZoVskMP0ursk?=
 =?us-ascii?Q?eLTTjAJB3VFgjNdCeQWumqR2U8L5EmX9Qvphfn8LBa6eoLa/Ael3DPbU1rwR?=
 =?us-ascii?Q?aeetz4+gqRusCwY3SouCNYOv56ciMJxY8401qjGV50HCNTttg0fBh24set6w?=
 =?us-ascii?Q?enE0u/cQrhZTewHKBK1gllsyHMQsdEmmfDQeCMvQtQ7RZQU9XcPNJYsMVVrm?=
 =?us-ascii?Q?SwgQkpNr3qOr2xZ8OtIqJOz0rPaLyRE/7tcrqRPLC+dSMy54ntcGpyOL1NVN?=
 =?us-ascii?Q?pGm/aRQ+PBov2zpHSdIMkYIE4hYAYZuXIAud+Hi/M/CMawDcdsegXL5OTXLK?=
 =?us-ascii?Q?Z9rbwjUaXHkQDMZglZmTramLJ9p2pYvch79ltGq1sLqiCa5OikJ8hE7WQfPc?=
 =?us-ascii?Q?SPCPSJdzaK8lM6Y0r71cdPtfroXmnMA2YITUc+N0nUnHeV/nsi0qk5dLZ/kX?=
 =?us-ascii?Q?1qO+oa2RzzvIqecSPzZKxM8Y0g6lwhib3WAUxkn+2MSvKoIHMBUOt9P73o7C?=
 =?us-ascii?Q?Q7wMwQ+8hO/lrwZ4aR/mvxehQA+Jirfdck19CA1B/v4MFxXqtLEdWGLaoj9u?=
 =?us-ascii?Q?odGY2c6iffIR0JFuLwGCLRUXJ9lAM0++t4toLEWGxdRKYc2tnTc4u2MnVkYP?=
 =?us-ascii?Q?GnN1XaAQkby18qCFDPa5DzHc8V48m2esyWfBuYMX?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 35e532c5-802c-4dbd-425b-08dd49fb792c
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Feb 2025 17:50:57.4566
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: uLCYUwkitjBlUTxHvYEdrE1PxKfz6gykgZVoUFz0M5Bm3s+E788KgIrnkaXG1AE3Om4Al7ns4rUv228W99mNquf6LhTaQK+NB9NqVnU9p/A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7140

> Subject: Re: [PATCH] net: dsa: microchip: KSZ8563 register regmap alignme=
nt to 32 bit
> boundaries
>=20
> [Some people who received this message don't often get email from
> t.scherer@eckelmann.de. Learn why this is important at
> https://aka.ms/LearnAboutSenderIdentification ]
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e content
> is safe
>=20
> Hello,
>=20
> On Fri, Feb 07, 2025 at 05:00:37PM -0800, Jakub Kicinski wrote:
> > On Thu,  6 Feb 2025 13:22:45 +0100 Thorsten Scherer wrote:
> > > -   regmap_reg_range(0x1122, 0x1127),
> > > -   regmap_reg_range(0x112a, 0x112b),
> > > -   regmap_reg_range(0x1136, 0x1139),
> > > -   regmap_reg_range(0x113e, 0x113f),
> > > +   regmap_reg_range(0x1120, 0x112b),
> > > +   regmap_reg_range(0x1134, 0x113b),
> > > +   regmap_reg_range(0x113c, 0x113f),
> >
> > can these two not be merged?
>=20
> I am not 100% sure.   But atm I don't see a reason why they could not.

When KSZ9896 register mapping was changed I already explained that
0xN100-0xN13F ranges map to PHY registers 0-0x1F, so it is safe to assign
only 2 ranges: regmap_reg_range(0x1100, 0x111f),
regmap_reg_range(0x0x1120, 0x113f).

The formula for accessing PHY register through port register is
0xN100 + reg * 2.

There is a bug in which high range 0xN120-0xN13f write has to be 32-bit.

> > >     regmap_reg_range(0x1400, 0x1401),
> > >     regmap_reg_range(0x1403, 0x1403),
> > >     regmap_reg_range(0x1410, 0x1417),
> > > @@ -747,10 +746,9 @@ static const struct regmap_range ksz8563_valid_r=
egs[] =3D
> {
> > >     regmap_reg_range(0x2030, 0x2030),
> > >     regmap_reg_range(0x2100, 0x2111),
> > >     regmap_reg_range(0x211a, 0x211d),
> > > -   regmap_reg_range(0x2122, 0x2127),
> > > -   regmap_reg_range(0x212a, 0x212b),
> > > -   regmap_reg_range(0x2136, 0x2139),
> > > -   regmap_reg_range(0x213e, 0x213f),
> > > +   regmap_reg_range(0x2120, 0x212b),
> > > +   regmap_reg_range(0x2134, 0x213b),
> > > +   regmap_reg_range(0x213c, 0x213f),
> >
> > and these?
>=20
> Dito.
>=20
> Will send a v2 as soon as I can get my hands on the test board again
> (next few days).



Return-Path: <netdev+bounces-128039-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A456497793D
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 09:17:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53CC41F242B7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 07:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 945FE184552;
	Fri, 13 Sep 2024 07:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="t1e9TGd0"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2048.outbound.protection.outlook.com [40.107.92.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E84D77107;
	Fri, 13 Sep 2024 07:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726211848; cv=fail; b=RKrHtw746J+cCRkcnUtOO1quUe6fr8fiObTVhnzl27iIhTfqdBnOIYeJ7+l3e3I1Bg304Q68z7/3JW5/jr1nrJwiPyblcBQB5Erz9rO20BzApcCadwAQ29KBO4xtgr/YiX5emPR15sPtTa1n/2rTcQ8gzppcUUuq8FJhFYI3nyI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726211848; c=relaxed/simple;
	bh=I9DscJeNDJT4uNZ2eUInIrWy7KSqLPNtjw4dH/TGHE0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=X6GIbyvVpxt+bHOJFrmAPE+z6V8PqbTW5Hf0GNVem1IuHeH/R1zfu8x21LuPpK9LdHl+cftSDRKMk7+31b+cYgmDIxpaPSMGMkUmZPcmK8bFSCZnQnDFswgvnmLx7xOa2EvUAol0q1bQTByqpP7QXzvtuJdtp3Y5ZL1Ag7Y2GqA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=t1e9TGd0; arc=fail smtp.client-ip=40.107.92.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mGCjg7aKoKU0hN6BtgdWOri3ULcEw3zgqGRxP2/VTJenPIcKx03/1V8C4ErTkzE7RaKSA/pnkDj0wyFDLPwuyc3Qk3jS8YLajRZhuajbNLsdQcVurGSnb9cW0tTifWZRy8KooBi+h/qTk+XYbWz90edNgbM5ST2FuO0QiAO+1Z8a38KwX6KBFEmeM6fdyw+3hEd/orWJsLGWptts66K0v2Phv4lph/wDrsYmvggoE+KSfnsFCiluBllxWca9wF1Gq+5FsjZgoAts+n6IPEWBJJtTTsukS8JS0D0Xq3muqfeNsWyFklIC9cCQy8ppbw3K/UnSdDXv8aUTnuNS/tf20w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntqaFOVcPDt2K7ohfbgMIiwXTqKcv74RpScHUGG4OSA=;
 b=EVkSmWWx+HCp8B+yl065ZLtIl0ySFocwH9muSgQZxD9PGRNN55ftuQdFWGrpcEITztGERFoPJLbjDfKT2hKgzuSvTV09shdzWOhezYUFZ9yO8oPMXIm3U22InKxzJ4LeBd3YL+JsP52RXlSLNCBMFCp3tDSog/qFEioHfEVKE9t/54aCL5+ZiSaSjCZ8KDW97N4hNGJAbGRozsatsFVWJxZemkwhOwqvKLed2ANQEcBFM4B+q+SghH0DL77f/GJeYajnw6sx+6vHKFbT5J+5znjcOGhQYc3DZrHcCsw37wCZR24GI3QnixJUWcrU8E6mwno1a5wKV3rCQBoCNlMh5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntqaFOVcPDt2K7ohfbgMIiwXTqKcv74RpScHUGG4OSA=;
 b=t1e9TGd0TnCl9wJmGhCYmGZqFc98N+sTC0XBjtEc+c1M9wtuYNloyk/V9zM20HNLhFsvnI4iI1+1FqYAKzBDKTyFzRdffOYIQ0NAoyZ9IBsWEHc9rX5EB5F4YYXnL5KOfTYNgrxe3fA3YlR+RNNK0iiFpy8oexVqnighGhBzxWb+Qf6oC7PiKlNj5pKYD7LBv8G/AaP8DmCi7DzcgLNl62M+1ZpWqwmm7vidynBk9VyCeYfxlGa/Hn9PoEAe4Rn8GXm7MYdlaeeLmtU0d0b+wmKpTu8zIjuuPK863OCsKPkUT40XEFdW0lfvsNrPSXtNUeIUgZNya9O2WJ4nsJDvzQ==
Received: from DM4PR11MB6239.namprd11.prod.outlook.com (2603:10b6:8:a7::20) by
 CH0PR11MB8233.namprd11.prod.outlook.com (2603:10b6:610:183::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.27; Fri, 13 Sep
 2024 07:17:21 +0000
Received: from DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5]) by DM4PR11MB6239.namprd11.prod.outlook.com
 ([fe80::244e:154d:1b0b:5eb5%3]) with mapi id 15.20.7962.018; Fri, 13 Sep 2024
 07:17:20 +0000
From: <Tarun.Alle@microchip.com>
To: <andrew@lunn.ch>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next V3] net: phy: microchip_t1: SQI support for
 LAN887x
Thread-Topic: [PATCH net-next V3] net: phy: microchip_t1: SQI support for
 LAN887x
Thread-Index: AQHbBEzINi707w8K50y8J4iUSIwWz7JSzBuAgAJ8nuA=
Date: Fri, 13 Sep 2024 07:17:20 +0000
Message-ID:
 <DM4PR11MB6239F0D858373406A556975E8B652@DM4PR11MB6239.namprd11.prod.outlook.com>
References: <20240911131124.203290-1-tarun.alle@microchip.com>
 <a7e330fd-9000-4b23-bec6-ae2bbfe487a9@lunn.ch>
In-Reply-To: <a7e330fd-9000-4b23-bec6-ae2bbfe487a9@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM4PR11MB6239:EE_|CH0PR11MB8233:EE_
x-ms-office365-filtering-correlation-id: 986bf8d0-42db-457c-d87c-08dcd3c41b78
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR11MB6239.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?CHwSPUJNpubBahOP8VWdhpvo/wAZyCjQOAvHd3nNSo/pDVeIMNWetitJlofY?=
 =?us-ascii?Q?1hcZC015JsIt1ixbBuwENDMvSXShLQdQV2auJYDjsIcm5dowyCljKH9eHdF7?=
 =?us-ascii?Q?rlo9QAIy8sToo2TJJHkWz0ugTYarzklT10E3eSQt+zQW8fK7Tq08Y26uUXYw?=
 =?us-ascii?Q?nM2kgBTP3CZxFd1CIZuY95QSy3vPIXXsZxaCKdeH0DUt8VbmRSxa7z+k8Vkt?=
 =?us-ascii?Q?a3+ZHtHaaulqQ8he3vV77jBEhYnqHE15Sk7G1mOCU7fuiNK94XEbZscn02B2?=
 =?us-ascii?Q?G5sWbc/8NoD0zS6BhiLcsZBU7PUHvnBfY6hTfcJLm7VvrUJDMrjXuM6lOfRu?=
 =?us-ascii?Q?ORBdJUoFo2zWQWvcbub7pZOQuf/Dcsta5YkB1UKS5UOPc5ZLrVUPoa80gVnc?=
 =?us-ascii?Q?+4/aRdahw0OE5UdvvpJ4RdxF3FPkYNjR6LpiMm7acLUOF1RX6W57XNSRqnDV?=
 =?us-ascii?Q?114EkKRGBDHnUny2mvjQs78Wb3np7ZKkDAEGEsnCwqJyeL65kDFF/OlMylDh?=
 =?us-ascii?Q?JFy8lJygHHAMCtof5R/sqt5p0EZLXzluVdK264HDrHxAQQ9/EGeNmleCz1A4?=
 =?us-ascii?Q?SQzf/InsL80Rk/xo3RPDEn7/hbtL7GqKBAev9tJStNDBBsEUSgtpg9cYV+ym?=
 =?us-ascii?Q?R20M1QcIzCrgrTB1XSJnPkyCCyJtOOzUNxiNKAIAOBPPY6bljBsQNveqbCdH?=
 =?us-ascii?Q?c96xZHYcMxhYIYPKeVhBFIl9pICr1edFso79zPMAXep0EcNVlksS6WNkU4Vx?=
 =?us-ascii?Q?2tzboKD8Ubsr4YdF8BzYAyEJnmHvOinSWsBTplM0xw5p9km07UF7FbaEvMH1?=
 =?us-ascii?Q?a7a5KnwrbivK8SGK4q7Yg9oLt3CjlQwi0MSbKgBSND7zq4n3pf/FpD8E4wVt?=
 =?us-ascii?Q?Bcw/pfTmBnKQc1zDphWBDtJ8H/sTLVWzNafF0kKW2McDJPI78Vl6p3A/sok+?=
 =?us-ascii?Q?fJr/spA5Vl5N3roJ+/eeF/AaipZPih2w0uK1bMA33MlCpB9pTLTEV+eL4y4u?=
 =?us-ascii?Q?mItjDX0wTN/F3kztNxSBTXgEZq41jkFAiEWHxiGBVCv1VZo5jx7ZnzNduSkn?=
 =?us-ascii?Q?O03rHH1l4pIdMx2Te1URIzDDMG7g9o9uS5xfCwFRJoQbWvGj6/gkIIPQ7sa2?=
 =?us-ascii?Q?jfJDnSZ68y0H4ZhopVS4MbbtK1Z9PUnpKbuImQ6DI3OtFt7caPlU6CYgBgL+?=
 =?us-ascii?Q?kQrDcDVPARWN6qTjoGxv4covCYizcKXNmEeUDO5EwcinVZR4IZCc9Df+xVu1?=
 =?us-ascii?Q?I5Ejd1jPTDnzZn3CzuxZLZc/goY9lihbvV9O8Hf/JM5TCsn29eBQsvdRgydM?=
 =?us-ascii?Q?vyYfIyshZoSZuDidkehSzxq0dK17MMEuSX0nsed990NGanVvPUOUAUqWw+5L?=
 =?us-ascii?Q?oDzDoI91WeY+rG3uC5RM5wMWA4MI3XIF/1XrmEhjwiwcJHPtCA=3D=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?MqCryY8HXALbjdW8AxCszkmXSdb17nRoFrhD647VW8Xm5IAq0XBNjjn/Iie9?=
 =?us-ascii?Q?NMm82onrC20ziPl++DLWypJi1c8XIGkASOW0xZKNfTnJQhIl02+s92cJEMYO?=
 =?us-ascii?Q?kB6Hy+yOaAjoKXkG3pSP6q8cFuRQmCCqJy0qb/AI75mU9t12E9YJv3VkC89D?=
 =?us-ascii?Q?NsUVn1+VeH9YnmHja+LIIWJxGud4agPeBLWdHX/K8GM3LPNFCqmGkfi7B28f?=
 =?us-ascii?Q?IuAqrTODtBbumLuNRCSzqalf/aJ4WHC34BpSnlRnhqKPVnye5I08ufhtAzpB?=
 =?us-ascii?Q?UCbUtRziIN9BpkHSD8dX2khsbR7Q4ZKlPt92YY76YZmU9sUJdhpGz0mYObJI?=
 =?us-ascii?Q?Mnk0lixNDAO0Ku37/EPXelUdSghEcq2oTebKSLczt54tDI4snIWd7QwfcXjW?=
 =?us-ascii?Q?kzcxmCTwK1L/HDSNDkaYjBAL+cnoOYdtUY/Nczy/CKDovcbMsI7l8PJZ75fN?=
 =?us-ascii?Q?cxB2M0FzfAKNrInNqrAPXU5ifXPYeVZSDamXN62PmkCuuYeLFcGNGTeooyes?=
 =?us-ascii?Q?tnAWca5gn/MEP9N1RY/29g8t0DhSLOoIE1Wd4vQsPyqE7xXqbEQK/xJxbG8e?=
 =?us-ascii?Q?ZuPAaOYSFiz2BJrw9r5BqnW8hV2SkhUWlQ2lVtLxrNnz9UFEc4EAlqJ6BRLT?=
 =?us-ascii?Q?jgfz1/vwFo0IpY07fX/5ruyMUXezq93N5MgTNBJt2PrE7SJAFc8KJLJIb8H/?=
 =?us-ascii?Q?N/TieiAnVT+ABAlu0n/QBmsA/EvEzt9Bf2Y6WaniuTUrP195lm1B6lckij7e?=
 =?us-ascii?Q?K2Yio2ZkUtDR9LRfLGlUL6D4meRhK1ELOtTNzsT6HIFxVe6k9clfLtiEJ4F2?=
 =?us-ascii?Q?kyO4d8Y+MRviOUcttWzKfjrIhkx68KzY8ZgrvuqJj4SEjO3UOHww0F6hA3ar?=
 =?us-ascii?Q?9enQmytWL/c3tEAt1cdX0eU+XyrQMcS6KHbkSHB+xcRPSjjpbitxmu/+05eD?=
 =?us-ascii?Q?kKjvUrxg6jIsQHpJLEDrWZkD9+4xHaAXcIbLfXkjlZ+M+Fd7bWu/qfMCOA0d?=
 =?us-ascii?Q?CGaAOmVuMcl1wZSbP4t5u0iySEh5GT91YEE214UnbpiFXSvKrey5bnfKASac?=
 =?us-ascii?Q?5ArGoH4zWXXMuvCV/KMG7gJFHPymypvMyTZPFMj2K1XQK4Eakdo/FJ4oHjA8?=
 =?us-ascii?Q?8iqgoKSgk4aHAs/PWxKtDB8NWO5KFrkaBJOxJZr0LWQOlw6fmwVg50WYtsSI?=
 =?us-ascii?Q?vZy5hfzTzhPvU6dRlfuQI9G43xaOWS9GuHWWQlX2DbD6Uur0CzPDUmgRdFaL?=
 =?us-ascii?Q?OHematPPeEnHKJhq68mq3+RDikSDumnYZucqNpWhJf260Pdq9SQw3ruUymL4?=
 =?us-ascii?Q?+TVuYyprJvi4ovNDZhi54EQzOB1v7d8W0m0Mg+8kucJXOzxNEkNyWmYUApUh?=
 =?us-ascii?Q?Q6NgoZ4Em1ch7MBzKs40deDdL64j4zJsosgUuyheKgwU7T3tRE8V6DzlTveu?=
 =?us-ascii?Q?WBjpTUSKlvX6RrGjmpmt/31/WKkl8eqyRvi410wWxDvhoSKEueKzOpGxxGgR?=
 =?us-ascii?Q?m6j1SKYmNzl1KGYV88Xh9jn7/dXvUcIYXNLfOHupma/H+M1W6XWK4pUhCVjC?=
 =?us-ascii?Q?rSLLLoMDozN7jOB9/F47frSuEc/iiUCrNZQRk2Kn?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 986bf8d0-42db-457c-d87c-08dcd3c41b78
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Sep 2024 07:17:20.7659
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SKMpL2RgbZDtqKNGpJ9PZg6qedF6DeLjboGpVdBxdvcPEHu7V0I4qkxYZ2l287h/PbX9zCjfkHEeRc0XuZWgyfRXebux+OeYgNoBG89Bjms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8233

Hi Andrew,
Thank you for the review comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Wednesday, September 11, 2024 10:18 PM
> To: Tarun Alle - I68638 <Tarun.Alle@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org
> Subject: Re: [PATCH net-next V3] net: phy: microchip_t1: SQI support for
> LAN887x
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> > +     /* Keep inliers and discard outliers */
> > +     for (int i =3D ARRAY_SIZE(rawtable) / 5;
> > +          i < ARRAY_SIZE(rawtable) / 5 * 4; i++)
> > +             sqiavg +=3D rawtable[i];
> > +
> > +     /* Get SQI average */
> > +     sqiavg /=3D 120;
>=20
> 120?
>=20
> Isn't that ARRAY_SIZE(rawtable) / 5 * 4 - ARRAY_SIZE(rawtable) / 5
>=20
> Please think about the comments being given. I said you should not assume=
 200,
> but use ARRAY_SIZE, so it is possible to change the size of the array and=
 not get
> buffer overruns etc. So you need to review all the code.
>=20

My apologies I realized the issue just after sending the patch.=20

> Better still, change it to 50 and make sure you get sensible values from =
it. The
> accuracy won't be as good, but i would expect it to be still about right.=
 But with
> the current code, i guess you get 7 no matter what the actual quality is.
>=20

To be consistent and accurate with compliance tests, 200 samples are used.
If customer wants accurate SQI value, we need to use suggested sample count=
=20
as per the compliance reports. Otherwise, single (any other value) sample c=
an also
be used which will give ~ +/-1 SQI value (which may not be guaranteed alway=
s).


> This is a general principle in C code, and coding in general. Don't scatt=
er the same
> knowledge repeatedly everywhere, because it makes it error prone to chang=
e.
> You have to find and change them all, rather than just one central value.
>=20

Going forward I will take care of constants and repetitive calculations.

>     Andrew
>=20
> ---
> pw-bot: cr

Thanks,
Tarun Alle.


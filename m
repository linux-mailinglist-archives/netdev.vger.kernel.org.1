Return-Path: <netdev+bounces-156345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D249A0624F
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 17:43:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 730CE7A1C3C
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 16:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3BEF1FF1D5;
	Wed,  8 Jan 2025 16:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="Ui5w5Xzs"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2051.outbound.protection.outlook.com [40.107.92.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24E3202C4A
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 16:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736354396; cv=fail; b=YskB9EqrWHbVYUdeBqFJkVjINdNWDFaJ79UgHMT3tQdTvs6c6TOq7Ih3NVfDdix+gfcc+vCV2SWYBmHj4AzlMCg/yIF9mqtweC6doVJZKL4ioBC2WdMPWPWx35+PsC5Lxv9tHNiOaicjLL+JRSFFAb54iwj1pwcZABcvHwF23lI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736354396; c=relaxed/simple;
	bh=TyaX1k+8WcMBgWOJi/PyOyCHkLenU+2GGqvDhcrk2IM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jyBk5QS+oTUaIwL7wSgFWnkKI4S6did0a9fW6PzCqmSl5bC+lhLqfzH3IbQmvC5nlDhkhCVDzS+EmSPSTHEHD9ZUuaF2GszFvyNxdjvo0wW93HfCe5BMueEhbLiYJs+tkX4l7wtwxJKOGKa3HMKijHv9RUIjF67LA9tkL22Tqk4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=Ui5w5Xzs; arc=fail smtp.client-ip=40.107.92.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=STj/mdQQQCaC3xRtnnVNcsz4Q7ASQS7Ro0F8MZVxVFfQ7SUNk1EhRWsiq2MSGExIxpoiPuOqtxlFP5gc2W/TL679iM32cmzbOxZpsneGUwKEA0G6THmHi1ZcUIPM/3Pij6pIWRAOiK5rSk3uyoaXnnvmeLxlk+KAdLsx1+5xkjqiO4iPdKGIs8V+J4fO29SZo3HrPqT3QzRoX9RjATUX10Wt0oP8TBauaVgWlzEcQEM8Ecmliio5v11Pbk2FkYAwLkXyt0uPcBScY0mSE6ZuypTKFFxcjEAYRLCtxg4Vg6mWdSu1URklrOOJbK1pbE5nXvutpIpxktlrHKFz+aHP5A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DRF1fGUhea4kqWlDvT01oZBzot5/EtSuyeW1HxX0r1E=;
 b=LDg+6iSS7E6g3C0+e66B8elAINZdpSzD1p7ixPSLZAlJQRmzKyr6sL1GBmEAtpX6w8CK0alkcoLXcJlzBTJHIZAnalJTIl6TdlQLnSMiSWme81k77eLEgE+MPwlWkaJd8I6KevNXyGlZsfDC5PQL9EWjNuVe9m9iT8Jmg068rFCtT3dyEcDanJqxcx/zamvKR58ADjQsp++EBCHYOfsndxfFb1Ei+3OMODAUx6PtDe+bY2HqcZFWJP9e8vyiNHUK1cQGgGlxtjJO6nmvBfHQxPzsEQbeFqpQyxwCzVKrynmI7SEwKWX1Syx1QwTTaVu1ZruP64n/a2ojIceC+tE77w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DRF1fGUhea4kqWlDvT01oZBzot5/EtSuyeW1HxX0r1E=;
 b=Ui5w5Xzs1j3K/r3OnfQL03ou1pKKWNYR+PaxwX29HzwzoEqjYupmUev3YfF/09ThzPQvCnbK2lSXlpRDFkdTkoyc0BV9eE42XUXkf8uUZnfOSsVC+KmXNVnyocBUtZzzVGJOe68alYomowB3uxGnYHozbEWevKUIz3SRom1x5fqH3BGJi7xiV41jHZCO17wR+PoRsaZs6gnoPrwUDynBOO7vkzWwp2dCJGxO1KkHQufVBWrxzJqAANhzevUPb4l0+8lNOEJSpbtAJgPspeQIfPyPLqDqCIHeCzOAe9pXw7vcPH5+1qhfAo0PYFeXGxFXx/mjhGUVWBPeUwC7PSCk7g==
Received: from SN6PR11MB2926.namprd11.prod.outlook.com (2603:10b6:805:ce::19)
 by IA0PR11MB7185.namprd11.prod.outlook.com (2603:10b6:208:432::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8314.18; Wed, 8 Jan
 2025 16:39:51 +0000
Received: from SN6PR11MB2926.namprd11.prod.outlook.com
 ([fe80::8fe6:84f3:2dcc:80b7]) by SN6PR11MB2926.namprd11.prod.outlook.com
 ([fe80::8fe6:84f3:2dcc:80b7%6]) with mapi id 15.20.8335.010; Wed, 8 Jan 2025
 16:39:51 +0000
From: <Woojung.Huh@microchip.com>
To: <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<Thangaraj.S@microchip.com>, <Rengarajan.S@microchip.com>
Subject: RE: [PATCH net v2 2/8] MAINTAINERS: update maintainers for Microchip
 LAN78xx
Thread-Topic: [PATCH net v2 2/8] MAINTAINERS: update maintainers for Microchip
 LAN78xx
Thread-Index: AQHbYeVf4z5Jz4UnJkmjQfKc7CYrqLMNE8qw
Date: Wed, 8 Jan 2025 16:39:51 +0000
Message-ID:
 <SN6PR11MB29263D454E5CFFD6B941EDF2E7122@SN6PR11MB2926.namprd11.prod.outlook.com>
References: <20250108155242.2575530-1-kuba@kernel.org>
 <20250108155242.2575530-3-kuba@kernel.org>
In-Reply-To: <20250108155242.2575530-3-kuba@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SN6PR11MB2926:EE_|IA0PR11MB7185:EE_
x-ms-office365-filtering-correlation-id: 2edd5d7a-405a-4944-4c5f-08dd300312bd
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR11MB2926.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?pKR6HaoqmWWoaZOMfri7nUHUPjxgpXZ4H5sHRpg2zKIvNUazgGXZ3YIQuIc8?=
 =?us-ascii?Q?b/Tv8oC2HUnIxWvgp+/P3u/LFnr0A9ic0ySxqK+rWuxwCg3Zp4HnkszeRfKV?=
 =?us-ascii?Q?rDLeMRzulJ/jZMTbZDeYu+fj1A4kESN1mKPRHHWoKghc8ghzWUSz/au11lon?=
 =?us-ascii?Q?W7GEmmQwcyrKvZJKAihPdpfVAF9l8eCSbpc0aEv32AetCTJz+l1h+AN35PTm?=
 =?us-ascii?Q?ZZlnLXmjkGC9nUzJgbMJjcAPWYUVWyyAfSc7XYlDvL6hh4wWjVCZkD1Gl3hD?=
 =?us-ascii?Q?CRX/MheAlCudBCnjnNaqv0raslVgoFdO2UVCyf6qf9Y6fytzvTG0WfyiuOkw?=
 =?us-ascii?Q?BJqph6nIgA8LRzIdWumaJihp7iCK08V8t+E5WhjU6ShcfFnShAUtb+9NZ2cg?=
 =?us-ascii?Q?bH/G1dgdyNg0KvkPOIzSeZoROXpkhY0W71s8qhUXeO3YlII4jb3renBDLx5c?=
 =?us-ascii?Q?ZXIr7qRJDHhpAPY4rl86tTlYGMXs3ETcI3lcw1iERAwJhtucIbc9ZmeErCgU?=
 =?us-ascii?Q?mu0QwV9M2/PuyodffcwnnMx1MLKHIRzIrbwzq4GRuZijXvnWW9+QlzjtWqaX?=
 =?us-ascii?Q?WX9BHxlFOc1k26OrfNnGlQb9feV9ZKD4c8u4PhBs+V0ka4YDT9Ca6bTDgwLd?=
 =?us-ascii?Q?sYExr1144Gwdf2EbdxVpj+3wHHnbNdENqPxfFRADx199lHFkIGjs2MVp1cCK?=
 =?us-ascii?Q?zt/0c7LvArtpA8DJ4Nl2TcNNg2N3Q8NBlAYM+jHOEmh5NDkzTMqOD+2T6zr6?=
 =?us-ascii?Q?mCNc8U6FK5qTNUbNMlzdXejo2INdicqnOQcLOuqbc476wzwqlb4rf3D3KNK/?=
 =?us-ascii?Q?6YFksXhd9RdJmg4jAzoPZo1nkkguE78oh/RFJKRO3IkPLLjts6pxUQf5QTxi?=
 =?us-ascii?Q?bhLIOmHeTaK7c4wlVmfUy2dVD0JEFMSsFzpuV0qh1RWyeicR3Ob8Gk4WbQW1?=
 =?us-ascii?Q?HZUGfjddxZJ/V5NMMx0OVz/cm9anp/vkqqti0APa/W7t1YsTVhdRfQP33ZPN?=
 =?us-ascii?Q?fojAxx6kgDUAau8CuY/rNW6n+PFVL3JEQwgMxixiZxtcb0zUe08MscEqTkv5?=
 =?us-ascii?Q?cdP+j2xnSsfnKStbyMqbIQjiIkDU3xZ50ly43UmKL5sCEF/04b8Jctc9sEle?=
 =?us-ascii?Q?i6rK//TiHLbSbZgDvFMhcPPZsk/wDOfHZC9FXYPuqNyv4Svn22FwOGCbolEH?=
 =?us-ascii?Q?Fa+HDHX84jbGD4RmL1IlWLE+5UJzPOBs9gxH4jUCJZbqxUyD7O1dYtJxvPk9?=
 =?us-ascii?Q?r/PythzfAxuHJs6ZZ/XMIcdQVflsH9c/XGUAAZvkrAZaLLVfK0hN+Sw+IT63?=
 =?us-ascii?Q?4jMjF7wsM5Xio1kGGfKGHk/iNulxrDCnqmqFIsjx3Bmf3HmSNkdhxO4Q9MYP?=
 =?us-ascii?Q?+EPRpL4FpwMEEhkmtBhZ/mOqqj+PTDE3yvr5iQSV5q+//wyCkphVHM3Fbny2?=
 =?us-ascii?Q?/GBMLXjx3lA=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?L2Bs+yX+jK0ifx6WyQDG5il5guDK8ZpFjdiJUPVJVL7zdZJwMedKebwxzhO5?=
 =?us-ascii?Q?zIiP216ZFEK0bqWoOv3Fwck9u8n1kooq5k6a9RLbOwrFbQdiFs7viXfM0IpK?=
 =?us-ascii?Q?1CePRyPH2TcXrEpbLLUO+dDpSNrj/8ayUNZidWZLeGeZGXRfDKZQ0J7gT0cu?=
 =?us-ascii?Q?MGKEuJyxSXSixX+Jod5hvafqmTNOsbSrbp+HaGYB7HFOf2qSqU9w1XC/wH0o?=
 =?us-ascii?Q?+o0mRrlB1feqjul7b/47GLpOIaCs7Nnx/Hmx+EYYimAyOz/SkI9QX1Vi+KDE?=
 =?us-ascii?Q?DCTdje55ow5Z1ET1UgVc3m/87fmk8s6E6Xv3wZ539zhFgogWj35UQE2pOilw?=
 =?us-ascii?Q?iJx+6tqpE5Y24JwanyoWEf873BjA+GP310kqbgHxQH8I3Oc/L3sWciDC03R6?=
 =?us-ascii?Q?zP2B5HzCVGYj/ABEnvm/7NGAN/8LgoFaVX5826XU2CQwLk90pXaQoAJMYa6D?=
 =?us-ascii?Q?cpNxwLFEXZUTUluO3L2KsJoyln+3zcpv9/n6MdBauoYkvZ3Ny+Nou2p7lK6O?=
 =?us-ascii?Q?+woAi8MZQoxw5N8d8f4HUSOwzWZCsaqFiDlwoLA56sBupg1J4L8LFh68KZna?=
 =?us-ascii?Q?1pVjT45gPxh1JXdQZ4GhrDB0GsqWzEMMGub8YJ0MpO7m+0nRyhL5GDG6x0S3?=
 =?us-ascii?Q?X/3nqfzxmMNHfRkUBTGGxp1hm1FaTMVy029NQCvWYRIw7700oq6y1p9kAbmt?=
 =?us-ascii?Q?lX6hW9t1mleNgmIDr8O3UCAX5RWY3hNetPe8k+lMAVH735OzftMOMFcFotyr?=
 =?us-ascii?Q?zLTzKtJy8wGSgQ1aQ80Mzjv/w2lP7xE+dSgO68mNIjE0f/QWTIlCeOxPx2ij?=
 =?us-ascii?Q?Fu/quYmAKuNwJi+7b5mBM0m4AFq4uAzCjdtgg9mBUFRZzE9Ir8mqR25ktbG7?=
 =?us-ascii?Q?xZjqz8jR8fM6u1rIMziDaV6ex5gljuHVgLupFQzDoJjADR1CeZKAvxapTDNn?=
 =?us-ascii?Q?r5JRh8908vcS5stECu2I9Quple+jpaDPaK7vwW6xDpeOb7g7YcTN3nOKiev2?=
 =?us-ascii?Q?FOXbuu7/C2xXkphryUBkCSmKqxb72upswF/xPo7z7Q/iNwtTvvtRVQnW5ULR?=
 =?us-ascii?Q?rXRRMEwA9OatoKkLe3H/AG/BSyflrXsPAtv/vDNIkjZKK5o5/EZPwpE+E+em?=
 =?us-ascii?Q?jGCSmHEjv6kBQn9Kv5pWe+03X6o9altxo6g+NAhqVSYSm3ayw6W3vdtU+anx?=
 =?us-ascii?Q?By45mTeu7GPNM0Q1oEcLKNSuYDcjOmHyTmmgNk7NjvQKXByjUmXvM2RC37GU?=
 =?us-ascii?Q?4yklq7aRP9C1roGRK/TE4F9sIyaE5Sumsf4Jfqg7GwgMnfk0q5MzxodRYwaJ?=
 =?us-ascii?Q?ftxkIcAMJrhSfsuF4EGhmTzqniz5kAPUsT+vIo1T1T5Alf4IwHHEjFJjDKop?=
 =?us-ascii?Q?QDVtaYgOW/kFQk10SyFwEFFYBO1te4qPBPaO0JH0JTm4WFkiLr2AsA9VaSoL?=
 =?us-ascii?Q?QnS1ov/a/SipXpOyyPEj/qCZEqaatnkCJKszD5R4ihndXxsSskUNlmPi8Jsd?=
 =?us-ascii?Q?D8nO62K2d6hI5IMQ94PNNG2CuoR8xGT4VUR7vZ4guZZb4ZBVv00g7AaEv8DV?=
 =?us-ascii?Q?Edq/jKUYVVmmG+DQCQUG+OwXLDbrypxNmb3BmFpS?=
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
X-MS-Exchange-CrossTenant-AuthSource: SN6PR11MB2926.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2edd5d7a-405a-4944-4c5f-08dd300312bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jan 2025 16:39:51.3534
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ds/j66iARHYO+bFaQJqiiXpcHwUI2l2CzOy4wDxxYmMRzAfTL9+CoEhCThk3dJUxRtRsxDPBKSFJC8zhpPCWN8a4CLZSEReR21e8TBhJlgM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7185

> -----Original Message-----
> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Wednesday, January 8, 2025 10:53 AM
> To: davem@davemloft.net
> Cc: netdev@vger.kernel.org; edumazet@google.com; pabeni@redhat.com; Jakub
> Kicinski <kuba@kernel.org>; Woojung Huh - C21699 <Woojung.Huh@microchip.c=
om>;
> Thangaraj Samynathan - I53494 <Thangaraj.S@microchip.com>; Rengarajan S -
> I69107 <Rengarajan.S@microchip.com>
> Subject: [PATCH net v2 2/8] MAINTAINERS: update maintainers for Microchip
> LAN78xx
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> Woojung Huh seems to have only replied to the list 35 times
> in the last 5 years, and didn't provide any reviews in 3 years.
> The LAN78XX driver has seen quite a bit of activity lately.
>=20
> gitdm missingmaints says:
>=20
> Subsystem USB LAN78XX ETHERNET DRIVER
>   Changes 35 / 91 (38%)
>   (No activity)
>   Top reviewers:
>     [23]: andrew@lunn.ch
>     [3]: horms@kernel.org
>     [2]: mateusz.polchlopek@intel.com
>   INACTIVE MAINTAINER Woojung Huh <woojung.huh@microchip.com>
>=20
> Move Woojung to CREDITS and add new maintainers who are more
> likely to review LAN78xx patches.
>=20
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> v2:
>  - add new maintainers instead of Orphaning
>=20
> cc: woojung.huh@microchip.com
> cc: thangaraj.s@microchip.com
> cc: rengarajan.s@microchip.com
> ---
>  CREDITS     | 4 ++++
>  MAINTAINERS | 3 ++-
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> diff --git a/CREDITS b/CREDITS
> index 2a5f5f49269f..7a5332907ef0 100644
> --- a/CREDITS
> +++ b/CREDITS
> @@ -1816,6 +1816,10 @@ D: Author/maintainer of most DRM drivers (especial=
ly
> ATI, MGA)
>  D: Core DRM templates, general DRM and 3D-related hacking
>  S: No fixed address
>=20
> +N: Woojung Huh
> +E: woojung.huh@microchip.com
> +D: Microchip LAN78XX USB Ethernet driver
> +
>  N: Kenn Humborg
>  E: kenn@wombat.ie
>  D: Mods to loop device to support sparse backing files
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 188c08cd16de..f2cace73194e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -24261,7 +24261,8 @@ F:
> Documentation/devicetree/bindings/usb/nxp,isp1760.yaml
>  F:     drivers/usb/isp1760/*
>=20
>  USB LAN78XX ETHERNET DRIVER
> -M:     Woojung Huh <woojung.huh@microchip.com>
> +M:     Thangaraj Samynathan <Thangaraj.S@microchip.com>
> +M:     Rengarajan Sundararajan <Rengarajan.S@microchip.com>
>  M:     UNGLinuxDriver@microchip.com
>  L:     netdev@vger.kernel.org
>  S:     Maintained
> --
> 2.47.1

Acked-by: Woojung Huh <woojung.huh@microchip.com>


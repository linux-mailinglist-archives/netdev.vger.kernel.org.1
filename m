Return-Path: <netdev+bounces-161971-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB24CA24D85
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 11:16:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4026E162D87
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 10:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90D541D5CDE;
	Sun,  2 Feb 2025 10:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="fcFbN6/G"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010029.outbound.protection.outlook.com [52.101.229.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C38E17FE
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 10:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738491410; cv=fail; b=eDW6MvzeEMB5SxXD36gLY4X2yhOk4viqjc6+27sol1UJMaNTk0+hLw0bCA9fcFkEmxBIOdIeAZBhteb2QKvXbo34nWl93DgsXyrjXJIfHCMxEWd/tUh4b4RarARE1qbCObPKLt6OWjnWVft6DelqAbm50E3VkYcDAU+33hpRN1Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738491410; c=relaxed/simple;
	bh=Y0G4flhtb6OS0++vdAtBHCRnSuRL734KduePx7ILL8s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JBxYVhpx400YyKqk9INbXzpU1+a8vO/Xd8aSZVFKBepeDy1s8q7MUwOtwhr/gLGmLYEqZgchqAsZLdHsdUVGMFLBAMHMDLdwj5M5su9y12MdCCTvRYwyGKsbyVEbcL72WkBHvryhPivjyeSlqTjHRw/m920yzDk7a2b0dxJxUwE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=fcFbN6/G; arc=fail smtp.client-ip=52.101.229.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cm54RaEjhJEfgfUDpWr7QaGb+g81wCwVrOgPm4Cyxaqh5bnPnJFm4elgcu/NpZdiwnYtiaKToZnvT0TCmjP9/IWJsZkW/K0ERtHAs2sEuRp3tEmckeSOEyVwfk8NsV6VMWRvgwpkZG0hxxdn0nQP+sVgNFRooPQaMMCB3TMe8p9Vk4fO5Qw8p04fmH+G5dgGo0hXg2XY5Rh9A6R0XskwjX0Ea6H86DZWf7bftJTAaInXMVsJyQeyTAyXQbiHudA2AK8UD+WBwxLrAx2R0z0NQTzjHiPz7AXWpp63ATpwaNMbc7dqDxwIs0iXwH2O37pgBitqiUHUvKgVxg9PogLiOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZUqKcCmfCcF/zdikN+28RzC0SJfS+AMQsomcPM/8IHw=;
 b=qxvvF6sgoXdRZZL6OFy340xMM6kmMrAovciXzgXHBwSmlI5/mvfDPqvhpW2tuy4QuHilmKZZarZmHcv72jSmJgRZdTB/42iV1lp8HIQ0LuVf6N8ojLOL2o82nr/3p+gYGnXwMYaVjT4++vkacjpv81HRrf6E3oslh/hl8gbb4V7Iw0BM1u32ufeJyNWWTVyH8Os9GnUKmjxJfuAo+ENUI3JXjSOMiHljmuruTnonGU1lQVqWi0zEFwEuT89axh+EVTUM0QsgVJU/tKmfz3AAUFMzEiO19ACxSWMYAJ9t/4UH0CJZs4YsaWSJLoOd0xeam9feYTE4di3eaGGRl8lZfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZUqKcCmfCcF/zdikN+28RzC0SJfS+AMQsomcPM/8IHw=;
 b=fcFbN6/GCwj7YqcCxuiFXyHZms4Z/K6EldaO6Mee9AtKtswwNy+MBhETS9XWeOFH77TSpwzG5m47dr6tXheu6L3xxLcPWrbJdFBp1qf3DpSxokc7v+OY/uv+n8SKXs4B3lf00pOGAQUGOlnDkjspKhxhYJlSsz/48x8w6BGrjYs=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB9540.jpnprd01.prod.outlook.com (2603:1096:400:19b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Sun, 2 Feb
 2025 10:16:46 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%2]) with mapi id 15.20.8398.021; Sun, 2 Feb 2025
 10:16:46 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	=?iso-8859-1?Q?Andreas_F=E4rber?= <afaerber@suse.de>, Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-actions@lists.infradead.org"
	<linux-actions@lists.infradead.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, biju.das.au <biju.das.au@gmail.com>
Subject: RE: [PATCH v2] net: ethernet: actions: Use
 of_get_available_child_by_name()
Thread-Topic: [PATCH v2] net: ethernet: actions: Use
 of_get_available_child_by_name()
Thread-Index: AQHbdM6otO3JULTQ+0i/rG1eJBgoqrMyy/CAgAEBN1A=
Date: Sun, 2 Feb 2025 10:16:46 +0000
Message-ID:
 <TY3PR01MB11346FB6EB2760A0F19DDD0FC86EA2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250201172745.56627-1-biju.das.jz@bp.renesas.com>
 <278e8d0c-e4bd-4126-8617-be2b7134b307@lunn.ch>
In-Reply-To: <278e8d0c-e4bd-4126-8617-be2b7134b307@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB9540:EE_
x-ms-office365-filtering-correlation-id: fafe6fdf-1312-458f-d635-08dd4372b2e8
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?eHNh97TaXv5YwM5XbFg4DmzgbCBMOlxw3bEgHr3BC82sd0ynn7spyRfbMq?=
 =?iso-8859-1?Q?4aeEkmZNCd07Mt+t/6yafW5yeXYrPLWTz4CS40GPypZwl+lcTTAniArf26?=
 =?iso-8859-1?Q?1KHhjSVxitTfG+jEyRq0uSPUZwn6zCyK1PXo4IlSWXSDUl+/myzdGr1kdR?=
 =?iso-8859-1?Q?g1WsX7yoExzEeBVUaqjYNLextmzm/QqUmMD3osvYdNWBz22Tfby8C1F3EW?=
 =?iso-8859-1?Q?W3MJgi6/pk3X9q6Ko8Amx9EQOMld/X5ejk+k7Y/eEQ8uUsU94Sm+yQFz6i?=
 =?iso-8859-1?Q?uzCl8BP4in+j9u/Xmd9JLwLlPzzMtyecn8DPn7RtbMa6QkP9zblP9TFDxV?=
 =?iso-8859-1?Q?cEH2rvfCOZHZniVNVS3itXNlC2rJ7OA+w/LWlXF2pYRXjNHpbUBPWKnX1v?=
 =?iso-8859-1?Q?LOVdADa26JkZNJoawDph/Hx49PhAc1S1VZO8dI7f4y1+ZYSeUMMVLUn3+t?=
 =?iso-8859-1?Q?IqXQrkGomVDWOStBkjcfemQcurKgsiLiHKBqLptZ0R8zpeedXgahMeoZQF?=
 =?iso-8859-1?Q?++H4EdbzjSwf6AXcLPOK1xRRJnhnQ8w33NC5UZpCF/u8fEKUG7Z8EnDGd7?=
 =?iso-8859-1?Q?zYUOAB5TPIHGJMiH0FEZ1D4dAI9cjFYW2ZRCMQBvOVvwF7fv4QlM+bqjDm?=
 =?iso-8859-1?Q?dVHtLt1j3N9gRH4thUbU4Qh6TOfNK1+Caq6PWxKQrsF495YLeBlmYmc6a2?=
 =?iso-8859-1?Q?nxyntKnmeVS4+dpwE7zLtTIK9VSfgftz96GcEuAHmt8nzISQ+Lq/EiV9A8?=
 =?iso-8859-1?Q?Rk+XGw2cZI9JOAALUTa/Pi+kploUrUTMDDQYeqE69cx+wpRbAEXbveLrNr?=
 =?iso-8859-1?Q?xsZVndShKI5gjSJaSN+xBM6EC8ddmxaxdMsisuZzksJT7rBchIiTlEL5E6?=
 =?iso-8859-1?Q?m4M794EzZQDt+6rillzYesBRrTvp7tMoD66XMZEIMm8KSApHgaZ3ZbNiiI?=
 =?iso-8859-1?Q?KrN6O0J6682XQxzG/mgXYchp0KN0FXXgVaqBr/L5XQttcRVudqjL6l+JlG?=
 =?iso-8859-1?Q?IMiI3XdeTYWF6VKurXw7eYlK9XxcqPTDnVeTUcIQphgiZdPLEfFUmPQXvF?=
 =?iso-8859-1?Q?L37OI5Aa0G39At+camjSFqC+1gWNwOUtahMY+LmkGNmR9x30dQ4LmsSnub?=
 =?iso-8859-1?Q?SSaV9fH11R80sXLgb5xFxy1W3lVU5S7F2GUOPnA+j52cCDb07Z/ivxLFzn?=
 =?iso-8859-1?Q?FFTc7omJUiQPyPagEiXCy5yjOp20bIUUteubUqwaNjsUsAkVCfOjVQzl5y?=
 =?iso-8859-1?Q?v3H3cew5lfLGv2DOvj/exnanNgLcI4HlhWLEAWkjPJJzuyK5TGzY7eZmrF?=
 =?iso-8859-1?Q?fouhV8ktVlhJ2qJSJVNc20jh8LBrTivUFIHsTc1LJQrO90u4al9hjywA41?=
 =?iso-8859-1?Q?irMIskcNKlNfXIOKOm2fv6vtX/CE94tQ4M9y0Nb/ARjOm4GmTk9ZWo3DYj?=
 =?iso-8859-1?Q?yDuYK7Ya/MeBxbzkpCfKAUIyq/nidL4nWP0XaQI30aIRwsZgeeaTx1E0lI?=
 =?iso-8859-1?Q?2q6/cttc2o5whkJHxZyhpb?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?5CwX43lnFHQ1NSixV6oZS3lus5MzgZ8mKk1Qp20sRirCV5/cUvj4yYd0Ai?=
 =?iso-8859-1?Q?XpWGhnXDKa0R5WNbuw7MQooBJC1GfDaExP5BxBm28U7/nSTaQVG/sVsmt+?=
 =?iso-8859-1?Q?Uq3S3H5emAiFDHyD1qxRxf+q+VevzeOoU0nKKMSdp5vxRtcCcq7qrcJnIa?=
 =?iso-8859-1?Q?GI4+nAWMUrxJ2Xc0x7tZva7sFiNx0mUY3UGqPxdihXMBEt9ime/6rlfiyZ?=
 =?iso-8859-1?Q?b+KKdQbtRJWu1AntjWH36IzAIxIzWurnFsCdsRWkHzpo9lghaKqHZGwxlZ?=
 =?iso-8859-1?Q?6ajf4BPmJaC6tz6M9YzeBJqEX5mnQAqcngiwv983guzuq8FVgRCuKwCEVC?=
 =?iso-8859-1?Q?5xk450NIYFBqX0nO7OIyzdplrWfsiOMGhsr0yJfTgha+yWLIoDhGJi9cu3?=
 =?iso-8859-1?Q?DnyLwiv9GTDuZ7vMQ7g13mN3JnRc1qy1Q5cu0gLHMz3QhKRn0eJcA0rV+J?=
 =?iso-8859-1?Q?Nu1Gk9a8vd2dKRqgEr7d+jigvzQrxwddY4kqwzzf16/Knd/3/G5NtpfJ1B?=
 =?iso-8859-1?Q?/KfnYPnIHuirkRWcxN0ZHzhv7Q/zs8yqn8hEXUCEauiT1q/ZYDZyYhH70w?=
 =?iso-8859-1?Q?GqfSQjzqEoEz8RL16GlB91NpNHNeH0QdoAbRNTfaDqk6/8JZJD5VP6Gflq?=
 =?iso-8859-1?Q?Z9LAersZVlrs2Z06ybsMDARPcxQDfmoWZ5SN577xZvFTxFfcQLNg950GXl?=
 =?iso-8859-1?Q?Sb4HKdfSsHk+Axs7czIivrogmFpGiUtUrmODkrXiX8qu7fhyhStjSxRqwa?=
 =?iso-8859-1?Q?N8OaHlDaZhBInAgIoZkHbT0pKIegGRqtsgGPAFpQjbz/v6Ee+XiSCiCZpF?=
 =?iso-8859-1?Q?eDNltaXYLfJ5G+bb88PcmvjQCsWkblqzQPfgbu5pvZDGtDX4RpiiatrBUx?=
 =?iso-8859-1?Q?skycQ5wE2N0ziHBlYEPtWX3i0DWOlYNO9bx4Mpxe9y5m0mUdjLl2dHJXQZ?=
 =?iso-8859-1?Q?SesYq5h5pOaeC6ofw8BWcvGIhGRqq97p035CMtY/bOKmn0EZ+pEXFx0dCo?=
 =?iso-8859-1?Q?CMqfMg5fPKm/epQ3JpOCl3LQQpzQX19YZIYhzyxzeqjyYyx9ztLO0VAtEk?=
 =?iso-8859-1?Q?NwovxLmtk6u7zyae3Dh0m+56p014jPLH/oRERQ5xy+BAhI++cL8Izzxlqv?=
 =?iso-8859-1?Q?v/P84fYpdH/2d3WDMNaIjbrNbv3K+3nqOWHyrewB31DuSKRXE1Id5l+Xnc?=
 =?iso-8859-1?Q?FS0r2nFLj2uEmLoulcc+ZvHQ+ctulbB0B/UzIE/u6o6IQTuqVZlYXGRtjd?=
 =?iso-8859-1?Q?8uGk35sWCHTB43beLRhkX+5/hf3hzVQZ/Lmx30iVGubvR8TiMmGbY38Sdj?=
 =?iso-8859-1?Q?3w6hPIr8Y/X+NpL/5dp2EO1PRh014fhmNgDLajIr0MUpqxXFlgBEhUAXbX?=
 =?iso-8859-1?Q?wVVSt0N9PASYJK6AjvVswsEXax4JkR75B+DKnJEqbmwOHjiCsD0eLm9WWg?=
 =?iso-8859-1?Q?EyU7edQ5IToP83ojqZ9ezL5J7cfBGvDxyrjS+XeoWNTD0rrA0cE8IS1sPR?=
 =?iso-8859-1?Q?1H1iM1N+Nqd3Qyffm5eBi/H8TAWtDiMEJNKDNGr2i8dXCgziblc9MHF/HV?=
 =?iso-8859-1?Q?LjbH4qCCgZMujxPSZfehDVFyTFoomTTo0RWArjWoj4mmovNo4E1NSPgFYC?=
 =?iso-8859-1?Q?q0fMMPf9p+UnSAydIjhIUfy50oLdmSiA2dn5WJW0ffZCp92tsxwJwvRw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fafe6fdf-1312-458f-d635-08dd4372b2e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2025 10:16:46.2841
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: znWLBK7ES2RTXHCYK07beJMx8XYQl2xoLoRD+ACVYnggRyZwCf29uj1fIdiKOm/Nf8aXLOGVKfj5dfHUcA2je03TPbd17cIozHGRbRIv6lg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9540

Hi Andrew,

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: 01 February 2025 18:55
> To: Biju Das <biju.das.jz@bp.renesas.com>
> Cc: Andrew Lunn <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft=
.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pab=
eni@redhat.com>; Andreas
> F=E4rber <afaerber@suse.de>; Manivannan Sadhasivam <manivannan.sadhasivam=
@linaro.org>;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-actio=
ns@lists.infradead.org; Geert
> Uytterhoeven <geert+renesas@glider.be>; biju.das.au <biju.das.au@gmail.co=
m>
> Subject: Re: [PATCH v2] net: ethernet: actions: Use of_get_available_chil=
d_by_name()
>=20
> On Sat, Feb 01, 2025 at 05:27:40PM +0000, Biju Das wrote:
> > Use the helper of_get_available_child_by_name() to simplify
> > owl_emac_mdio_init().
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > v1->v3:
> >  * Dropped duplicate mdio_node declaration.
>=20
> And version 2?

It is typo. Actually it is v1->v2:

>=20
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html
>=20
> Also
>=20
> 1.6.7. Resending after review
>=20
> Allow at least 24 hours to pass between postings. This will ensure review=
ers from all geographical
> locations have a chance to chime in.
>=20

Sorry for that.

> and section
>=20
> 1.6.6. Clean-up patches
>=20
> Netdev discourages patches which perform simple clean-ups, which are not =
in the context of other work.
> For example:
>=20
> o Addressing checkpatch.pl warnings
> o Addressing Local variable ordering issues o Conversions to device-manag=
ed APIs (devm_ helpers)
>=20
> This is because it is felt that the churn that such changes produce comes=
 at a greater cost than the
> value of such clean-ups.

OK, Will send next version with simpler readable code, once
dependency patch hits on net-next.

Cheers,
Biju


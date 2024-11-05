Return-Path: <netdev+bounces-141810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6DA9BC54E
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 07:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF9AD1C20F59
	for <lists+netdev@lfdr.de>; Tue,  5 Nov 2024 06:18:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA4611FE114;
	Tue,  5 Nov 2024 06:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="HWUML1Xn"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2068.outbound.protection.outlook.com [40.107.95.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E77C41C69;
	Tue,  5 Nov 2024 06:17:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730787464; cv=fail; b=o4dhs5o9/f7os8qhEe14I0a72YhdMqhPwwt5YlJUwc6jte4zrnHbiMzHQ4HBbB2GdC0gr6y54x89spQPpIfAbewatrL5zN7ycznOY04OGa5rYEOUYGuoJzJLy5L+PNYGRqoYfHXNVjVXVSyHk1N3vWcjPzsvsOfCvtH+2l7g9Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730787464; c=relaxed/simple;
	bh=ispRzkpU0Mh73b6f9ESRguLA2MTbckltDDCrvN1u4O4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B5JobK2Rp6myNuWBCwqZVz6TuL4uPOFJYzKVfTTQ7DzBz9NQjqO6iU5JmpW0Gg8hAnZ2bWspMH6tZN4Qt9JorDqPh59CUNpxPy2DSouVr50hScydm4u992N89i9cIoOgCMPha9ArpNzk7K7uv2BFnwwZiMrPI8l0if+8jHncJSk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=HWUML1Xn; arc=fail smtp.client-ip=40.107.95.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VHX8v6uGCF+JU62Wdlq1aXH5G967OyFYFMRt5SJxxJ0gJ5O8f3HeAhajsmKWNjHIo0g+x77kcbbk8+xu3y3pf47Wj98XfjP57WL3JULmJcmCop+JFdZDQGYudLSoqMuDcvvGFq7EUhAOhXFS44xPg4ek/Rconmrpycw71Qez1OOijk/bCSoiD2pZcppRv8YjA2Y3kRQfsgHSILM/mZ1ps6vnqgrKMHe353n7bMo4wObYKqTQL3YsDeDw/ewpo9LaTVtFnaymtZbWl154txc4dkRR3PgrymeCo6t2pvJLg+ma20Iau/VtqevL3YkzYPJ9j1dKTWqSA65zD1IXkEM0NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VOq32QKShFigypuhdhiu3ZKYDql9cmr/UpnhDRjCPU8=;
 b=TUVFJAv87AXKKwWaEdcfgcYCvDMUsYQhAnnqnH/1G0cIn+8s+zLZ3O9zOQB44seMipCZfGSxWlJf8XMewak5kh2QbmZiNe4uekfTic/8gGJY8niYPMSUl2WoglmYHV7Cwt5rJQBtuPedNVlV0u8pw8DjR4VRZG/CYFF9eSUzvL9ZJ4jIM/J3p6tZV688LWwLOJP0PqGTzbdNH5op/rbXXqf5gU9HLfl0orc2haipOKEjRXjksVyyO1yaKYed4EO+qhQhjD0uwlash5PZ6GPiB2AK3iemQPnIU82hmm/wTX/TD9icD7GfeGXrhapdalLesIf1L4/su3WwZAvJJzC2Dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VOq32QKShFigypuhdhiu3ZKYDql9cmr/UpnhDRjCPU8=;
 b=HWUML1XnhsrffP7zJNL9TTMqYQPnCJE1lF6jnLIOx+zam4yT2KdVR7T82+AE4/l++GBE8JLyCS2JdDCgjEk9SdAdpUfKLBqSa5QGtWMqJb6JVGEzGlnoh3pmE45zRxcU15sQXnCDd68FDfQQDArLVMkN26BpRPFlAIF9HIsecKITxwfOO9rKS9VxlzEZ4vKKSgru9391Bi5qKEDoONW8eO9oWN4dPsW6mombIWA1ewAYFXekpkw2Sy/3jxaWGReVtUGhEKsACpC4Svj/ici109xHMQe/h/tgi2x95Ds5h6fnj709gMTt7DpbPZV42aXaOUCtp6wtjvhfbnYOyPbBPg==
Received: from CO1PR11MB4771.namprd11.prod.outlook.com (2603:10b6:303:9f::9)
 by LV3PR11MB8602.namprd11.prod.outlook.com (2603:10b6:408:1b3::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.31; Tue, 5 Nov
 2024 06:17:38 +0000
Received: from CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708]) by CO1PR11MB4771.namprd11.prod.outlook.com
 ([fe80::bfb9:8346:56a5:e708%2]) with mapi id 15.20.8114.031; Tue, 5 Nov 2024
 06:17:38 +0000
From: <Divya.Koppera@microchip.com>
To: <andrew@lunn.ch>
CC: <Arun.Ramadoss@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<hkallweit1@gmail.com>, <linux@armlinux.org.uk>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<richardcochran@gmail.com>
Subject: RE: [PATCH net-next 5/5] net: phy: microchip_t1 : Add initialization
 of ptp for lan887x
Thread-Topic: [PATCH net-next 5/5] net: phy: microchip_t1 : Add initialization
 of ptp for lan887x
Thread-Index: AQHbLpkcu3zDaqb96USZuaMJKFisPLKnJ5sAgAEG8/A=
Date: Tue, 5 Nov 2024 06:17:38 +0000
Message-ID:
 <CO1PR11MB477194184681EB22FB869149E2522@CO1PR11MB4771.namprd11.prod.outlook.com>
References: <20241104090750.12942-1-divya.koppera@microchip.com>
 <20241104090750.12942-6-divya.koppera@microchip.com>
 <8c585168-20b0-4abe-b4f2-0d0949627bfe@lunn.ch>
In-Reply-To: <8c585168-20b0-4abe-b4f2-0d0949627bfe@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CO1PR11MB4771:EE_|LV3PR11MB8602:EE_
x-ms-office365-filtering-correlation-id: 957b9e87-8b5c-4954-48a3-08dcfd618c0b
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4771.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?MmT6VKngOFzpySYvGPCMsd7L78RKDdgjinOSzopJl1k8cj6cwCYKvQ2hpEMg?=
 =?us-ascii?Q?ogsP8RUkzIDC7xaSue89DSPYhnLchXu1PhnN+3xaBLQKRrZHcIVbjT3nZweI?=
 =?us-ascii?Q?NZh4fIjeWqLkPCZmgv9QAZ/aCwUimZmDIXfdfyzgHJC72fAjB23xx8rTt0xO?=
 =?us-ascii?Q?tIFOT+7HWRX2eQIKM8B+qjPZf1Q8LgUWE4ORGiSfYfVNGL3b6E2+xTlXZAgk?=
 =?us-ascii?Q?JaymUaJ1fxNIClzUEMzlxKZIQoHg0EKZIkVS9SwV1+86Av8skEFWAy9UMn/V?=
 =?us-ascii?Q?BCtb5b0MmNavSdcuvHNvCJcGkgXnj5weW26VWvcdB4gCuhzFyIUbTsmKCiFW?=
 =?us-ascii?Q?LFHCb1Cn7CRQOwk9B9/Hx+WlnAFVFU4v9w6jGZ3ohmC/+9/hlyjNELTyDxBz?=
 =?us-ascii?Q?u/Q/nX07o+chfoXH4roCxTka/FTqM2UF/R4+QqsTH2u4MUP6u/kyB21G21fC?=
 =?us-ascii?Q?pg8VwtUGKG4kevh+2DAwXXnBBdoSIMRiGayjsps72dzhNOZBKvdsUUnSqm9s?=
 =?us-ascii?Q?aBaEkD4wcT4+Kg2ajTdVQ4PPSBO6mBH9TiTlbm9uh8GY1yeaa9KoXiX3fiw9?=
 =?us-ascii?Q?+AF0U+iCbPh7NzoaE9u3b6vj/03ZzbJb598KBhPR9pXFxFRkmtAr3eghOWJs?=
 =?us-ascii?Q?mqdPFfk1H493jPN/WwvgQ2Susj70VOQftiiTg6u+XTMFNGvcug8UbPcAyWMx?=
 =?us-ascii?Q?Xk1I++xROcajz2WGAMKaAogOvM0D8gXaQ/G4YYPg9gQdw0qrJlqfovjB23WU?=
 =?us-ascii?Q?MoY+2MUjZmPRbBmRXzvcxmGN20UkkbDc6n7j3wFEAxGk1Ue17/ZABQYm0RTU?=
 =?us-ascii?Q?lFcr2wVmGL+2ny+x7yxqLfyIJ1DNQMPOE5HtXvY3axR7JNUXKiX5KzXz8QhA?=
 =?us-ascii?Q?3x2blWbXDzUhIOmucS9COaaouknsGIGvCQqC48rN8+c+b3mO5stDgEiy5IzY?=
 =?us-ascii?Q?KUcpXips6F8G/SCWOQfuBIBaD9URm32OWRPWGFUILKwNMqPoo5EWAitoFe74?=
 =?us-ascii?Q?9Anq7QzQ5AJbVOAb51bXbXIVoIxNS/UAOcAZGq1raTR8uyt9Fup1EV0wOnNx?=
 =?us-ascii?Q?SLphElLE3khRW1GfGqW50Mot1K3MqQoWUwOglx1HsCgupnXS9n+MDm4Eqf8b?=
 =?us-ascii?Q?AC1UZgRUCazCPxSHwNWYNsLYzFHTlV0a8dYTg7MD0KDsgFHeMVTVVW1pzL2M?=
 =?us-ascii?Q?6RQVnPjwd4a5oqjM6+13pyuE0UHmDsnUM+wXiqVDIBCq1eMwAnGWWKTzmSW5?=
 =?us-ascii?Q?3oCaRz9LSKCXr8w73HPUs2UXgbA/vlvsSXpCPbBVm0hoQZ2jClvwyTP9w+g4?=
 =?us-ascii?Q?JtasMnSMKFrERpJdwaVI++AWPQOO81M3wOU3GEp6Ke2jCvkJDVDtOfRqzZwN?=
 =?us-ascii?Q?/PGoDJY=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+XR9T4KZi+5u3joc1YtzfHkrCMSP6sA8eL0Hn83OeP0SWfpsTlD0figUXiH6?=
 =?us-ascii?Q?07UaA2Qwi+wJn12Wj2ljC2uIzbNvahm8sdFnHFjEjqzTyEK/liV3nb6u0xqm?=
 =?us-ascii?Q?QkZbetDdk16v00EaphoP+cPfgu4llb8sEzwVdnbT+vlxUHCe50S55E1uedQW?=
 =?us-ascii?Q?ByVDTJ0ZeOuIN4YynneHHdFZISqKE5b7UoyZEspbcHpqcuceYl9VbMYLFyAb?=
 =?us-ascii?Q?eaal9xQdOUiQo2WUZYMxQ1j9yR+7KNjivAvJanVMp4tpGtF9muwYUvu8vX73?=
 =?us-ascii?Q?afF1IuDi/lrI3zZreoJx+YFbmW2Gg/hCSmi3MOw7LmhO/FbHBkquWfFqIAAf?=
 =?us-ascii?Q?5sCZiOWm1egzFTVnh1pETM173nGCcpV5V9+wFhrWFnipm/7Y1SXiL2Cx/vqc?=
 =?us-ascii?Q?oGAa6se9gfPvNgHYEvjVBdY+yxuKAx1oDJNVeJ39Uibe2A1BUuurJNzRwKtC?=
 =?us-ascii?Q?zOrjCfy7I1/z/obYVfVhxxbi+8OIk3sPpYNRwywZPOvUGNZJOHMS/5Fd/0Ll?=
 =?us-ascii?Q?MOJW57Po3fWtx9dwmrBpSOON+XkUnPPsE0wTw821ajdNxqSfA9BQ+alI2ZeH?=
 =?us-ascii?Q?q7Aw00UiD4OlDje1uBpo3a5tK9VAfJm2vLBjc2nLr4k3tSIglxFzhGVg5V3U?=
 =?us-ascii?Q?kVFyfzinr9d97zGKbHIa3jTapZTu2C/Gogl/pivIc52H0K6Ery/be4gl8KIF?=
 =?us-ascii?Q?V2tqpEf9Hw4Wn01nK4y0tuWl3wYJ1CW/VIA6qjfwpiUXNqbzSKuQEYInztT/?=
 =?us-ascii?Q?GU7x94Y5Pn/th4PT/XtVYakWKLfLhP2D3XcHzuN5uwT+AOM289Y8xIj850IS?=
 =?us-ascii?Q?7TuR26zOgm5Snv5FZRJ6szxrrc4M5rDaeZDk1QBwaVtaE7MtKMqNWeL3bgQr?=
 =?us-ascii?Q?aLMn6CJkNKTfeiqUT2+hHAXTXnmfELflrmwN6TrhrvkJL9DX+q+QCYzb0Kba?=
 =?us-ascii?Q?hzj5cyJe5kaITOwq5pFb07r9nkp2XQ034lTZGupy/dOSPYk7Z739XGb6S1JH?=
 =?us-ascii?Q?UV/nebH4JBQSCj8lbgjJ+YwV9Za0+AGtsHRPAmKjzX2eqtJwPJCIot7b+ogh?=
 =?us-ascii?Q?7bY1dANUXK5/+2MLjrRiiIiQTRkcKgTkC9SF3JHu/G9hj3mVMCGL32BHSXsZ?=
 =?us-ascii?Q?2YBBP9FrlIG1wDssMUXkLfO0W8IJGsmDymiy/M8kOjwN3lR7597k+flGL9BD?=
 =?us-ascii?Q?NUgqHswUJBOmHUfXTI8syuT10oogf5luIWeOVLyQTCZ3w4uK9B1bXa41GPZC?=
 =?us-ascii?Q?ioILjmVKxWl3+fXKoItuDpFDwlbyNGoetH5iXHPynQcm/OC1D03tbNk2REsf?=
 =?us-ascii?Q?Asn6nVI9lntxESrpDFHQQdgVgLsf4Ntl0XtmbzXfAIYnare3nwSthEnqoC30?=
 =?us-ascii?Q?OUmpjTWhBh3e957Zmewp2/pVtD2nAdKIje2oD3YdoyQ0cQvVYytud+CdRFk0?=
 =?us-ascii?Q?uFQIq9Dk7hdKIUiLrleAf12Oh1J8rHUrMhbcs9v0QOaeNVCAMWsvRNvCJJm0?=
 =?us-ascii?Q?rDXiwpd1eTPwd1S0Wf0SrCOYLhb+/tLvxqwb1LYj6TfC6ww7snIcc0cXdKix?=
 =?us-ascii?Q?00LaJk6m6mkQb1nCxZ3N2L9zToJ5BBmAmunzb9pZobwkxu/gyJhQ8FYzMDvn?=
 =?us-ascii?Q?7w=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4771.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 957b9e87-8b5c-4954-48a3-08dcfd618c0b
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Nov 2024 06:17:38.2921
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: SwUeOrtwJNNLs7+fIk+LqF0JXtzKqfwAtPzUUmCeX9nLzulK/uC3w/tLbxIcdpXIcSK6V9vicq+zsyiY99yPub+PXaq786XesBfkUVbInrA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR11MB8602

Hi Andrew,

Thanks for the comments.

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Monday, November 4, 2024 7:34 PM
> To: Divya Koppera - I30481 <Divya.Koppera@microchip.com>
> Cc: Arun Ramadoss - I17769 <Arun.Ramadoss@microchip.com>;
> UNGLinuxDriver <UNGLinuxDriver@microchip.com>; hkallweit1@gmail.com;
> linux@armlinux.org.uk; davem@davemloft.net; edumazet@google.com;
> kuba@kernel.org; pabeni@redhat.com; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; richardcochran@gmail.com
> Subject: Re: [PATCH net-next 5/5] net: phy: microchip_t1 : Add initializa=
tion of
> ptp for lan887x
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> >  static int lan937x_dsp_workaround(struct phy_device *phydev, u16
> > ereg, u8 bank) @@ -1472,6 +1478,12 @@ static int lan887x_probe(struct
> > phy_device *phydev)
> >
> >       phydev->priv =3D priv;
> >
> > +     priv->clock =3D mchp_ptp_probe(phydev, MDIO_MMD_VEND1,
> > +                                  MCHP_PTP_LTC_BASE_ADDR,
> > +                                  MCHP_PTP_PORT_BASE_ADDR);
>=20
> In general, PHY interrupts are optional, since phylib will poll the PHY o=
nce per
> second for changes in link etc. Does mchp_ptp_probe() do the right thing =
if
> the PHY does not have an interrupt?
>=20

Interrupts must be enabled by integrating platform(MAC/Switch).=20
Currently mchp_ptp_probe() is not checking for interrupts flag and also irq=
 might not be initialized by the time probe is called.

To handle this, mchp_ptp_probe need to be called once from config_init inst=
ead of probe where a valid irq is available.
Based on IRQ number, we can skip ptp enabling from config_init and set defa=
ult_timestamp=3Dfalse.

Let me know if this approach is acceptable in interrupts disabled case.

>         Andrew

Thanks,
Divya


Return-Path: <netdev+bounces-199748-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A93AE1B3B
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 14:51:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 60BF73BEC08
	for <lists+netdev@lfdr.de>; Fri, 20 Jun 2025 12:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEDB28B401;
	Fri, 20 Jun 2025 12:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="WSCf2ieM"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010067.outbound.protection.outlook.com [52.101.69.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 797E527FD72;
	Fri, 20 Jun 2025 12:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750423877; cv=fail; b=tSvo64LXiAQSW6XT13Mwz8VFpHNkQQplPJrfBGNwlMIjfA4Z1GxVHSv9EyTaAkxYdQJqnMMwTA6vnpkDPkdiPpRrdwTJVlN1C45Y76zbZlVgViZsxTa4WxEX2dULNc2eCqPaGSov/iR8HuSvGfizdCCIf7KtIQ8UtbytgyUJfQ0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750423877; c=relaxed/simple;
	bh=Kmz46hiwpbfbnwz5a59VqFTX9Cl2+ONa1ea5ySzLCM0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Iw6onbfAXjaTsxMZlCg/lCIQW1Y34a1plII/E5jlrHS/Iqi4eOaw5xQdV1wc2MXX+ZV6j41lnWDcj/VM6IeJcW1owrBT6USPzFD00Bn18WTtFQH83EAgIBMDhgoMLyk7ZS8m69oQcezLp7gBgvqQ0QGcMeK8Xe+wncVmAyU2uB0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=WSCf2ieM; arc=fail smtp.client-ip=52.101.69.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IFbCLs43T98ahNQA17PYzJvCUpU8wKWtPl+qY8oA+F5Hh3LmlN5Zcf1dYwJtmblmGfg3pa6+5WLfl8zNda9YoO1FadD8U5nvL80gA+Fdif4wh8A/bSWpbcCzd7KKO+UjUtTZ62le71mMVAdEsTCeJ7kWsBF3NDjve87Dn70RdvZ1KbmaV5P1bECa5MVGv/LUoT7CADhLd2ZjKcky+bQCrUzZ5Q9e36KmQZb1fRTa1L1cRP+SUu/i1njVyF1yDsU6GOlmXxR/VCaMhahwib9gjflKuJabHZ6SoAt4lNLLk23lSkI2O8Pe7emgnvURqe7HnAK8x8f+Ih7SbVPbVxqb1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Kmz46hiwpbfbnwz5a59VqFTX9Cl2+ONa1ea5ySzLCM0=;
 b=K2lCdU7N4m6w94VTE2GXA0WHUv2KA8yEZUpcilHJD3DwZbU4DMVCsLTsKvto9EIvKSWXiebqSuBr1w3N41N54L+Mn7OJ2RUmuvpwHXJHlnh3KrJy22Zk7e4D0hrWgG9EditmtJGJ1C8o4QvzQ8n91wzAGLSe5XO9udtoHgtVfkEUZ8mg8ejvsNwzl8Blh75HWOfxQM+VOpgy+0YANArSvdNpnB9yycxIW5PxB2xM+/8x0MaDLYa3fuUVBaB+0e/T397oVR7cM60pzLEJAtt6+TCoY7ooUojxH+TF7ksyRbByNxdkBL49GVP50Zd3LVXhZ+hkOsaGQBggVbzozPQTWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Kmz46hiwpbfbnwz5a59VqFTX9Cl2+ONa1ea5ySzLCM0=;
 b=WSCf2ieM8XHbWVFMrEiwHnBZq5ERTbNuWei7DymuGdZgwlJ0PjQp9iqdY+64SJx1vKQe+Wz2dtMKvEnI7IakggXhLEhSryBSI7nN7K8EIRfcpwfPA36jw+RUohXbbQiCsEDlVWqGQbB95w31nheknatMPfm48aAdlH1sqKgGBfbYKxxRbBx9or1sUSc6eM0v6ftdjRxprcw9gKSeqlkFKsnEWdrXvEYwvx3XWX7HT/7rGKsHmsIXGYnJY6oEO8bNoBW28ZJe+bQzG1pCV4tO2isJ80pZ6ubRv4JhH9qZAHkRZ1iAkHY2Uc+EHdeTY0zaz08IGAjNacuPfuWf46TtiA==
Received: from AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9)
 by PAXPR04MB8783.eurprd04.prod.outlook.com (2603:10a6:102:20e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.25; Fri, 20 Jun
 2025 12:51:13 +0000
Received: from AM7PR04MB7142.eurprd04.prod.outlook.com
 ([fe80::c2e:7101:e719:b778]) by AM7PR04MB7142.eurprd04.prod.outlook.com
 ([fe80::c2e:7101:e719:b778%3]) with mapi id 15.20.8857.022; Fri, 20 Jun 2025
 12:51:13 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next 2/3] net: enetc: separate 64-bit counters from
 enetc_port_counters
Thread-Topic: [PATCH net-next 2/3] net: enetc: separate 64-bit counters from
 enetc_port_counters
Thread-Index: AQHb4czMHIa1f0mikkGU/4Vy1y1AVbQL/Nkw
Date: Fri, 20 Jun 2025 12:51:12 +0000
Message-ID:
 <AM7PR04MB714218CFD852C0C266D515D7967CA@AM7PR04MB7142.eurprd04.prod.outlook.com>
References: <20250620102140.2020008-1-wei.fang@nxp.com>
 <20250620102140.2020008-3-wei.fang@nxp.com>
In-Reply-To: <20250620102140.2020008-3-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB7142:EE_|PAXPR04MB8783:EE_
x-ms-office365-filtering-correlation-id: 5fae0dfb-77a7-4a7b-6b18-08ddaff9234c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?zlF0a2BcVY+ZJDaYbvnFO9ovQU6NUy2REPg1ZDUPHhzezheABGBm/GpRbzt/?=
 =?us-ascii?Q?tiiD7ehS+sIQDpcuicZ+INVA6AkaEdxHKF7JEsuNALraz29/jjLlP2cbpe+z?=
 =?us-ascii?Q?PXfI4lVB7HSfcqyfNQw7U+3mpTTIPe0QrY9XLEczz3z6uI0mV/qfYxo7YKhj?=
 =?us-ascii?Q?Q/oTm4CSxJdSQMAaX3WF2ZFqgrAc8iFc8p7fcf0V4afQhhXSp1E5BlTCsX4Q?=
 =?us-ascii?Q?Nl+5zCoLgkPx5Cs3J8amv3QXxAOFbDtfAjmpRQdAj2lPhQyfTlKhxvwBF4ji?=
 =?us-ascii?Q?0Cbcsdbi+G6R6QWmNwSc9mvMNvGOez3RdzaSUcqNeLCOnKF5fNFQJmnuyjCg?=
 =?us-ascii?Q?SsXgPKgoroQ2lBIX42pqzxFrCVmYixzkymFeKrVpQe6siZk0E4PJ0Ec+U8rL?=
 =?us-ascii?Q?qMoCkfxQj6a+a6Yx8ejv4u3dT/pwV/Ru44l2+1mWl9QBJ5BKJqNtYQKmy9rM?=
 =?us-ascii?Q?2vGHblc2d9BJ+KXAbBFlPJsctlmWAc1eywXTcyyiEPl0UrAqtrfx8X9lffjJ?=
 =?us-ascii?Q?3+e9ZicS4M/yJCczHkySpAV7KBEXChYV03XiTUNGm7MhkF7EOMPgUPgEbEmW?=
 =?us-ascii?Q?mAnYz6QJ/Ikv0+aNEH6NWTZR/pH+nsru7OAF0vFTcbSNHLrZhmUlR3AJkl39?=
 =?us-ascii?Q?+ZK2S4oqs7GsPTOXCkrCLzwdLuQpz78KB3cUYK80EJ7oC/nWe/pDGpZyjjI5?=
 =?us-ascii?Q?7FHFnG6x8jJHMdG6rQRVpQThiuJm/MhHy24Ls+nGLxtMOcDNN7c20SMLyQ45?=
 =?us-ascii?Q?aeuyYVDDp2deHEMJ0Wy3SMYGoH8MGJ3Mejq3E1eAVDdMw5MU7Vj2HFekyGCp?=
 =?us-ascii?Q?Y5/7P0PsOoSmnLakH2Lot9gd8RjQrc8pxy96rguI0qUhpBQryFxmwtJmlx/i?=
 =?us-ascii?Q?082hJyoiOtTNYxEADxmVkS4i1flVLrzVJxKqPXY2P4aAOulUKNt7G7MfgVM6?=
 =?us-ascii?Q?faEEtil/I66oyov/6WmsEKjRfKfYC+sqQTx4EtpkdIQNu71m85jnhUSrDY90?=
 =?us-ascii?Q?vKenK45SYFGvLmzq8yom7Ep7y+m2eapIfUWZZYSsbAfQtbKxCICSW4ZOIjiO?=
 =?us-ascii?Q?7++Ld+NTjBsQJM3H0kv4TbB3ehvaBZbEgv7GZeHkE7h/v10taxXyGfnouYnW?=
 =?us-ascii?Q?AoqjsR5E4ZcJJHDS3+PSkg34nXsdrJNbBt//+1h7K0oFqH5A2qIb5Hre5UPv?=
 =?us-ascii?Q?jA1MhYONFXRMbzGC0d1I8X9bEVNnMKOzqG857fRoNK/3LtvOG7RNLr7xvtst?=
 =?us-ascii?Q?Gpq2vnuEziehFItvwatJkPZO238rDLGhkgtyjVoO5llLmeFxQnY1ShIkhNxQ?=
 =?us-ascii?Q?ZFtQOViyhQvJE54UbhJX7GUSniwS/pt4E62l49a/CqlE3tnbG7x3dl7TTDEa?=
 =?us-ascii?Q?SWMZE+1R555s+wHG3wWWGHUEqlmBrgkHWCBLPkruCFxT1Hr6sk55wtk3d6BU?=
 =?us-ascii?Q?BtXGob6GqO1QbalP7mWdFpg6ttAjSbeq/tlHIdd/tYJG92h+PGL3LQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7142.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?uO85tFLBj4wB8nsMmN3R8yOk4WEsPze0vXC9rcWo0Ao9HXiZm0dsjGe1NOkF?=
 =?us-ascii?Q?Ym5FzccdMnLG6/ITmX81MmYME/ayJUU0BEwqDFN676M8k7ux6WCG26ShoZnh?=
 =?us-ascii?Q?Dx09TRWtSeUN86AXBqLpcyFwdoh2QWEYUFzsKlvguU+byCIuQT6YWxRgxgM/?=
 =?us-ascii?Q?+vpD8b/OlDorR9RzM+jSjXKpyY0t28dabWY6G67vnz/8Kxq7h7BbSciGLdEV?=
 =?us-ascii?Q?jdQ68gpzeBYwyyfmH8nsj0BnbJ3KJtSLD4iFdXcR+ciCRsb+2/PLaYUtPzz3?=
 =?us-ascii?Q?Z8AHppDoUgcc/jqNzCd7MMqq3029NF3wCT4C3YIVvRrLA56nuPF8ErfIc6/s?=
 =?us-ascii?Q?i3gz+/Xcdc26Nk9su6jUXCiQnW7HyLPx3lB+RRa9GvwiPT4xVCfdtMh1XQ2S?=
 =?us-ascii?Q?JKicYafgf+Mr/QBMrLk5ZWr1hSLmdzANzYCoMeETSmlr/MG1sTNMxp5fI3bq?=
 =?us-ascii?Q?dh47LJK8Ei2qM/QN9EiMuk7rO5hU1kN6zX/00+kdTW31+w8b6RR/kdMxFseG?=
 =?us-ascii?Q?JNKHpaAHpaRwkU2mBXHz/F/NZK526K4ULXG6/GCbhOvkmDpVeNZHgemFKcdR?=
 =?us-ascii?Q?SOXFiVvmS3SzJlrEgwJTsFvlgrldAjuFQN7n3mJ5IAR2ZIp26dUybx+KAYXt?=
 =?us-ascii?Q?wQxxrBnXuwFpLWv9eyvG3qs+bazTdOj1AtMeSqdjH4hDEbZ/HwVtVyHP47lk?=
 =?us-ascii?Q?yc4IshtinxI3h7tUFzkqwynlM1CPMNs3m9hgvZjK/vel9UUIazG9hrb87f6B?=
 =?us-ascii?Q?iLSyvV0KGYSvQkJ7KSDhcJZr9PYwg+KT2z8UFMEI9GOt3A8nzQxrJ/qJIgLs?=
 =?us-ascii?Q?/AZmmOGvptLFEm7cmapl01s7yuQcKmQbr7iFek0oecjWOcfJv/BAZSD0v1+Q?=
 =?us-ascii?Q?oIEsfn0BnFhIVX0zDfA3V95xQClvuXQ01WVbFPpI5KnGmoSw5r0GIVhIqTsL?=
 =?us-ascii?Q?XKB42C4idDowwvudVTVTi0PVgXa6ytvwigv58IIJGILHTYzsPfJlAd6dgQlG?=
 =?us-ascii?Q?axNPfaVTXwbD/+1rTSUGh17wbFGmJL36s7LnWJZ8YACJVDv4pM8sb/GLQC+e?=
 =?us-ascii?Q?o7i6s3lp6wgcyt+rio7tNRR/Npi0SjxvQUcb/BEz465ACIG8cso+DjifVSd/?=
 =?us-ascii?Q?TedBWQd22wB9PPaZ5gNd+ZgVz3esOo9MbE+f4rRZfDdiG3ogQDkcxLOawmVL?=
 =?us-ascii?Q?vfb8AklAk48152wiUl+T0QPCfVOCcNNvhZ69Q/vDGEL2k5JNdj+sqODW0Xlb?=
 =?us-ascii?Q?Ygv7L8N7IWSTzuCIBgeR8usOGxyN9h5HP6/Ldf/heqOIVf+uUmy/bHkUHrJI?=
 =?us-ascii?Q?tDdE67sxQtGM0IUvcX2OGlapyKireL9Fw0m93kWUgCLQg79SYVMqOABWRCKt?=
 =?us-ascii?Q?9Mw+AFsFJWtYGGeEJr6MvNE6hxXcqwN4Hc9dVVJeMttrep2j43CyxAgYQq3b?=
 =?us-ascii?Q?XM31HvIJ7O2lXmk6q44HpX1e6cvzmRURvSpRG8s8kRE3bSJQKtFfFeXaVVPX?=
 =?us-ascii?Q?If91r/NUUGFK4BoQjBShheESqWxZP7K7RlqKHG/T2UKd/ZLOQCWi78JuX3KB?=
 =?us-ascii?Q?O3YcuUb4FgxsY90jowdMkINvxbi84VU7dBtliDch?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7142.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5fae0dfb-77a7-4a7b-6b18-08ddaff9234c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Jun 2025 12:51:12.9955
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A2kydgbyDik4r3LfGRvlqZ+5eOkrYAGvyEddeWR8atKz1GEnEuNx2C9S4tvXuui1Ajtlju6shzWBfwSBoH178g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8783

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Friday, June 20, 2025 1:22 PM
[...]
> Subject: [PATCH net-next 2/3] net: enetc: separate 64-bit counters from
> enetc_port_counters
>=20
> Some counters in enetc_port_counters are 32-bit registers, and some are 6=
4-
> bit registers. But in the current driver, they are all read through
> enetc_port_rd(), which can only read a 32-bit value. Therefore, separate =
64-
> bit counters (enetc_pm_counters) from enetc_port_counters and use
> enetc_port_rd64() to read the 64-bit statistics.
>=20
> Signed-off-by: Wei Fang <wei.fang@nxp.com>
> ---

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>


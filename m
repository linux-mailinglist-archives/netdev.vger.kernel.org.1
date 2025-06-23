Return-Path: <netdev+bounces-200113-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF881AE33E4
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 05:13:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DCFB018905F2
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 03:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E4D1AF0A7;
	Mon, 23 Jun 2025 03:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="kf+Sdo+a"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012014.outbound.protection.outlook.com [52.101.66.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5367C199237;
	Mon, 23 Jun 2025 03:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750648402; cv=fail; b=g4kGvaRc3nYxzi83e0keuiIRgxagFYyKjaElPSvw2+KrOkQ3qCGV0QWsHaqO+ecqRa+rL1XXeqtq6o6qn+QPQ4ySrKmEDbh2Taz59pUIhfoSJekUEp1g65LAx1wZWG9l2lWiRjtsS9YGrglcCQ3G7kqGsoSi2r1hG7mQ3d6Yi+s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750648402; c=relaxed/simple;
	bh=f38vrpD80L5NMQrGrk9xI2HEbgUxFpUIEAorHwp6SXs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=tJ/T7mPSKXn9qEcg+yCAUmwzbF4NyKe7nS/Nuzaa6MI6EaDTTqOreMZWe4Jn7KSAvJcWo4VwQLEy+BVznTBIrhi26biwyJDiAS6AjrvSma8aGc3H61nFIXyWOXLIYWUsk8MJgQ/y3KRioOcwb2DQYBP6OxFB2+PR9IZIfxJMEwY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=kf+Sdo+a; arc=fail smtp.client-ip=52.101.66.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yuwDE01t3nyRENw7a9clDzvimeKVMfew0Nqbrt/urPXYKD1OGZT9ABUWeh41jnR7SROCS51Fx/zD2zJEqrWWcKOKSwbUjPNvla9rV5l29pZkY3KloPRbcO3zrr48AuDHniGtmKss1/HFYTtYYIi86BTdGwwKjjkyEfB1dbVXPKnFb1zzW9DWLLX/fJ0kpCEMedHblQVLJ0UtWr/7iGtGiToFzCuuZqpA59Cij2S51QT+oe9WCYuKfXyEU3hznHiX/h60ARREHzM1A9FlI+SKUfQ48DaOGd6RVgrNVIlPV44iVs9lpvb3g5/CZjfxyW7Y1KSii/6lgRpO7uPza7CMCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tO72LW7wjf8WJ8OcQBVWzogFeYAJ4ERMZi1kYHs6LbQ=;
 b=W57dp0ai6OKZ0rAM5ZOYpm/g1DLM4bbaDzizW0k3ozQyMNnMCcT6zcuO9yARN0XyjVGUsPK+7/RHimHgdN+HsbWbF3JkJkBliGWjdOi3NGb5VntQex+mFrrVkrxr6+Z5swJOKxwVwc2qzQ5SAVbolQzH2Lg2Bu6yr97YVxs+hrSyqTg1AEbd1FIY96mrz0tYsqN0A1regUlcIIJEBYEtzByGajmf0je1DRDJxkWO2o01FGIvFuv3eG3Qlklw0wkbm/hELQOHLS9Ire9FETyS1lxLwikLBApAC8twL7M2WA//MdYTAoVinAXSaPdi7jrnpFZVGs9lcpCQyjqH8d4Q8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tO72LW7wjf8WJ8OcQBVWzogFeYAJ4ERMZi1kYHs6LbQ=;
 b=kf+Sdo+azjbWhHpkEvvxDSlaZg0zzOB/sR+DVrP+HJMt5MWCMwR3aEka2SI+Pg7TUzHp18WeRN614cATqO01EDI2mfSq01foMuCLp01gkX4VdQO4wJUKq5SuPpIBFypNX7dY5xWcCc+ZUFe/yGMaHv2MsRrc0veyhekiqEhKnrqi7VHAsZ5Zb0FQOb6dOGBS1taU7cCGaxUaeXdhwF2vyOIZwInXSpZXS2BqNzit+s7WO3V3PtE2ty8fx+PWW8OkTw8p3uMJNNTC+og+er3gYarVT4sgmU955G/D5pQqI6ewz1JjqGe2dT9yyp+p1XHIbQqYUm8Uwpo+O2hQDLb1Xg==
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by AM7PR04MB7095.eurprd04.prod.outlook.com (2603:10a6:20b:11c::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Mon, 23 Jun
 2025 03:13:16 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868%4]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 03:13:16 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next 2/3] net: enetc: separate 64-bit counters from
 enetc_port_counters
Thread-Topic: [PATCH net-next 2/3] net: enetc: separate 64-bit counters from
 enetc_port_counters
Thread-Index: AQHb4czMECBu5rY4X0SHhurA8ziGm7QNbRCAgAKgp6A=
Date: Mon, 23 Jun 2025 03:13:16 +0000
Message-ID:
 <AM9PR04MB850500D3FC24FE23DEFCEA158879A@AM9PR04MB8505.eurprd04.prod.outlook.com>
References: <20250620102140.2020008-1-wei.fang@nxp.com>
 <20250620102140.2020008-3-wei.fang@nxp.com>
 <20250621103623.GB71935@horms.kernel.org>
In-Reply-To: <20250621103623.GB71935@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8505:EE_|AM7PR04MB7095:EE_
x-ms-office365-filtering-correlation-id: e0d6da4f-de7e-49f3-5e37-08ddb203e5cc
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2H8HEuvWH4Kp31YTkb0GsAC1S56cNAdXpJyH8pB/lD8nnQa/FqTqDgWM/L5w?=
 =?us-ascii?Q?q3Ouk98D1cICgQHpjUvO2ltgb8N0pIbjxSZ1nXeUujdlUvQdxHWVZn/Cu2wb?=
 =?us-ascii?Q?TBtLkzjVlmlKLSEzqiZE7fphJvvgF+rB5TVVBnkVIIFia5h70OtZe5dBh1Ml?=
 =?us-ascii?Q?KROdHmK2WUTfFV+09VHrEv+gIq0qG+olAAFftHLabJhRO8/4yFjXzxiQwCeJ?=
 =?us-ascii?Q?J3uKrBPgYm7Q2BtNJnj46CStNsXjQ8MbMvLvFIxON5G8trbuWE+uf+dK8R5R?=
 =?us-ascii?Q?JynVu3AdrYt576o6gluDQbPj6rhRQ1pRZpZBL3AcAjUJqL9SCpVFxwRifSEo?=
 =?us-ascii?Q?P1qw7Phqfq1AHs4aD0reLQABq8YYhcRF2s/FaNc7jdpQfGqz77QTNFgOzuSE?=
 =?us-ascii?Q?sVCD3PipNaWxSIiqZCucf3VpmKvZ23mqAsWYfp/0djvtvB75sjS0FoZPGCEa?=
 =?us-ascii?Q?82TY1YaOvuWueBxbjgoDdxB1XDVXTCPTNuVYgwd9qEJwfPwRUdoyh3DD3h0T?=
 =?us-ascii?Q?dfUcT7XUzz81i37RDiecOqpuMWkiTjPdAzJaTMhXCiRlHc3GnDOhfRR5yzse?=
 =?us-ascii?Q?rIb2HUxAGcGJHMBC0FoBNRe8rfPguY+b1brErxh0+HwKuR2UvSBqPifJhpAy?=
 =?us-ascii?Q?jinNbVHwkxhWb+MT79hT2Ah60/jIGA/rWrRuzqGh08ZUiwTtGyG1TG4DIXMF?=
 =?us-ascii?Q?kmZIAyL6VrpmGJYNnaWbCV69w6hmYnUbQHoshyAhCPofS86dO3NRppujJ30j?=
 =?us-ascii?Q?tPEWkgAA9QzeoK2GZXDW3G2eHOx7xW4LJf5CczO/4YYjURUYw/LqIJ49mw/T?=
 =?us-ascii?Q?d0ZZV2XFRxN+/x81/GFUhyitP9S2c/zsQhN//pCgTUz5i5h7ylm2iExjyFM7?=
 =?us-ascii?Q?jYWCkfslrDLaHu+sWB7KTKb8pgIOiq4NxUhddtn9wg5H/8+V1gw4q8YTixeJ?=
 =?us-ascii?Q?hZo9nZEdxe/Czb6oNrkdtM0nbolyZcaAsrQnW6s48NazIXoSkTcpi7vg2fzY?=
 =?us-ascii?Q?9ITXAVS+f1FMB3mHKccui55hwfKhQaOW+Bd1uD2tjblaDTsk51H8iBfeoQun?=
 =?us-ascii?Q?WbKgHp4O1xBg6+niOUEQMXNeGteRo97JvbzcTXWQmWH59M8YE7QEeVVX9fy7?=
 =?us-ascii?Q?Glhi2lgCOS5JPpmrYbT/LCXqAzW1w0QCy15HS5IdcIFLjK5bkD3WnVrE/GPZ?=
 =?us-ascii?Q?cRtqPW4n2OXnzzGAgv+He2meSVDTr6TXNjXrIfRGhO7/y6Dyahe+iBZmYK0o?=
 =?us-ascii?Q?i56fSo5pZKlkjdrnErm4N5Ce40/oZ6zGANXc3A9wesWI/UQxZmn9kHZHUxN8?=
 =?us-ascii?Q?sfkB6XTifZe9js1KmdhK15y2L8wbr2BoptQa09ytsuEqiygguKaulZlJWYQo?=
 =?us-ascii?Q?yPk9b8MUminNAxiXGxXWqhVwLGlegFJhRyEW3qo37UjfV4E6QdftYlGhyx6K?=
 =?us-ascii?Q?gTyOCPjnTrJ7LyT8PxFo1Wf9r1D3+vJEqIHFPNL8shqtSSW36LH4pn3vdjye?=
 =?us-ascii?Q?vNb831H7MtT67pc=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?7IGPtGdK8ol0vREHYV45HOndhbf4f2tkiRu4gv+bGQFlQCytuAbotQuJN+dJ?=
 =?us-ascii?Q?Kv1+K5GaY01oRcxdkX6TNlTJ0O1dGmIp3OPoCatFIaLUPWWtCOi8oUUlf7az?=
 =?us-ascii?Q?r9UgNBpdkuAIGCXVAVxYdH6dh1CfbN74+JO2Yts2wSJaUVbBoqdjB2/PIzeQ?=
 =?us-ascii?Q?cIYE9KdAE5f+DLrXFF3HQkblUbbEYJGEQ9W2H/I0SilyCxwOF27ytHi22oGb?=
 =?us-ascii?Q?9jI1kOzqswIxyA/2k1cxhL1+NE1roU1/i+aLAuOYasH9O2DzqQIIP7AbumTw?=
 =?us-ascii?Q?cDY0076ahCPv69WmHEk7T4HmEKyV32X/VtkwJaRuKqlTtztHAFKGf2SSvfUm?=
 =?us-ascii?Q?AGYTkJnovDntrJoM/BNkU4ZCUM5SgrojT7xOBXGmANXhrySqkAO9I7dLnTDs?=
 =?us-ascii?Q?qJnhbHpyRxWJIqrmepG0KsKHhaY7+XHFR95BuS4/RkeQR7RjCI7mzggXsaJR?=
 =?us-ascii?Q?5svYrSRQ5kKbLwWVLQMkB48z0xBpAPzpNLUyAFUdYb42xxhYsQfSrTYUiLdG?=
 =?us-ascii?Q?of07wVhIo769ie+NF1ytEOFIzwPSEF/FY+NcsrU3SjLaXhk7Adz28KGsUy79?=
 =?us-ascii?Q?re5lKFa9sSscEg1gFqLIC3YwL4sT+PugKuYkiqPx26vLW4r/bYx+0+6QwuQw?=
 =?us-ascii?Q?rEGGuR171d3+fFCOGG92zShIp9cVQ4/qOOtvo7B3MY0YqPBQGxN0oRBNC6sj?=
 =?us-ascii?Q?F/h22vHgsoI51UjPGLcaBtIQ89UHggvSLi/fjAFlE5ANO4XBhyQRBRn0DFtW?=
 =?us-ascii?Q?xsxiLmDuLK0AoxwDAcX4FzjmXZAjU6mmm/ycCXpknFBbZSbAPLhx1EW41OBD?=
 =?us-ascii?Q?kLbUa1SIzXk52v5IapipIsOmX5vPfDKTPS5N8bBF5ocoEpkwuOJQsS+cwdhl?=
 =?us-ascii?Q?j+bWubVWXvnW0M1KDdekf8ipRABDRu4whVopcz+xv+ycKaWTxyp5kPYbQ9AL?=
 =?us-ascii?Q?39GolxDyIo7SpPKBdHODC3+bHbU39WbS3dyOG68sMk/YMxH1bPNOUOz8gLEp?=
 =?us-ascii?Q?dxRFJ5TAeG9yzSOQlVo7njSYRmbV1muoAzJE0XkL52MjgsYm8QoB/y11doib?=
 =?us-ascii?Q?U1O+EoMhDnp4vAglyvB2hxmpRS2kWdd83Ca0gCas4Tkxd19Z/saxe/QDAT9I?=
 =?us-ascii?Q?OwAoY6wKNYfd5gUfyfAR4M8mDd6Os0JeQXhNcFF7n3woEjkLmSteUDnBHooM?=
 =?us-ascii?Q?9OfTwMdC5dBvgm6QrrlPT1yPurzubv7Y8hin9kxHZLwQnHJkHLaqJlSp1Ynq?=
 =?us-ascii?Q?UV4dSwv7N3/Yokeb7b2WeNFQo7D4K1UN9HLS3yhrBu8u6qVg6mrQiNE0E9L6?=
 =?us-ascii?Q?+/175E3majc/8WH0LhOW7gpxaInb8oOxSoJrVSIRfdA2x/N8ZpHyKla1ayPp?=
 =?us-ascii?Q?nlZy/Jy3uT0/3i9euHmzT1W8gMYpVfgdDnc/ZTMDykWYQi5X/C0xJWcGLYZw?=
 =?us-ascii?Q?UyoURF69wDHt+nc+rR7tDVZhLTS2ilOkcXR3uiQ5oUOY5TAu2Pdd6+a6UI5r?=
 =?us-ascii?Q?LiTff865mhYXiUg8O2TEy/LAq7yJ2Hw/iinP5jmcSQRZYznukkz2MgCxaFFl?=
 =?us-ascii?Q?8nlovUeWxG300zInVvE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e0d6da4f-de7e-49f3-5e37-08ddb203e5cc
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 03:13:16.6337
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iKogGul+D11k8uHuSbB7aNGSl8U/NaureCgWxJXU9miimW+4NshSLCeyIDaRE2dOyHPw3GkuOM3PzaCvvII4UQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR04MB7095

> This patch looks fine to me, as does the following one.
> However, they multiple sparse warnings relating
> to endianness handling in the ioread32() version of _enetc_rd_reg64().
>=20
> I've collected together my thoughts on that in the form of a patch.
> And I'd appreciate it if we could resolve this one way or another.
>=20
> From: Simon Horman <horms@kernel.org>
> Subject: [PATCH RFC net] net: enetc: Correct endianness handling in
>  _enetc_rd_reg64
>=20
> enetc_hw.h provides two versions of _enetc_rd_reg64.
> One which simply calls ioread64() when available.
> And another that composes the 64-bit result from ioread32() calls.
>=20
> In the second case the code appears to assume that each ioread32()
> call returns a little-endian value. The high and the low 32 bit
> values are then combined to make a 64-bit value which is then
> converted to host byte order.
>=20
> However, both the bit shift and the logical or used to combine
> the two 32-bit values assume that they are operating on host-byte
> order entities. This seems broken and I assume that the code
> has only been tested on little endian systems.
>=20
> Correct this by converting the 32-bit little endian values
> to host byte order before operating on them.
>=20
> Also, use little endian types to store these values, to make
> the logic clearer and is moreover good practice.
>=20
> Flagged by Sparse
>=20
> Fixes: 69c663660b06 ("net: enetc: Correct endianness handling in
> _enetc_rd_reg64")

I think the fixes tag should be:
Fixes: 16eb4c85c964 ("enetc: Add ethtool statistics")

> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
> I have marked this as RFC as I am unsure that the above is correct.
>=20
> The version of _enetc_rd_reg64() that is a trivial wrapper around
> ioread64() assumes that the call to ioread64() returns a host byte order
> value?

Yes, ioread64() returns a host endian value, below is the definition
of ioread64() in include/asm-generic/io.h.

static inline u64 ioread64(const volatile void __iomem *addr)
{
	return readq(addr);
}

static inline u64 readq(const volatile void __iomem *addr)
{
	u64 val;

	log_read_mmio(64, addr, _THIS_IP_, _RET_IP_);
	__io_br();
	val =3D __le64_to_cpu((__le64 __force)__raw_readq(addr));
	__io_ar(val);
	log_post_read_mmio(val, 64, addr, _THIS_IP_, _RET_IP_);
	return val;
}

And ioread32() is also defined similarly, so ioread32() also returns a
host endian value.

static inline u32 ioread32(const volatile void __iomem *addr)
{
	return readl(addr);
}

static inline u32 readl(const volatile void __iomem *addr)
{
	u32 val;

	log_read_mmio(32, addr, _THIS_IP_, _RET_IP_);
	__io_br();
	val =3D __le32_to_cpu((__le32 __force)__raw_readl(addr));
	__io_ar(val);
	log_post_read_mmio(val, 32, addr, _THIS_IP_, _RET_IP_);
	return val;
}
>=20
> If that is the case then is it also the case that the ioread32() calls,
> in this version of _enetc_rd_reg64() also return host byte order values.
> And if so, it is probably sufficient for this version to keep using u32
> as the type for low, high, and tmp.  And simply:
>=20
> 	return high << 32 | low;

Yes, this change is enough. BTW, currently, the platforms using ENETC
are all arm64, so ioread64() is used to read registers. Therefore, it does
not cause any problems in actual use. However, from the driver's
perspective, it should indeed be fixed. Thanks very much.



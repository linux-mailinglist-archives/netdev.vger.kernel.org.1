Return-Path: <netdev+bounces-189961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED17CAB49AD
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 04:48:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8D6E419E7464
	for <lists+netdev@lfdr.de>; Tue, 13 May 2025 02:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A01581474DA;
	Tue, 13 May 2025 02:47:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="ddbl+X9v"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2053.outbound.protection.outlook.com [40.107.247.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE4C2A1CA;
	Tue, 13 May 2025 02:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747104477; cv=fail; b=kp07nffao3jiph7oa0Wn8q+M8BUZdw+u3UL/b4FpZUAFWjiaYYeb2Tb112SqI2TsnhW5JntBQ+rPaITeISUgYAAhQT+1tlsn20TyXAiXmdaXg0wg6VxgFoEzNBKrv58yx+WGCNIO11loC79PHs/W+RKa6Sv7iciad3JF51HUWFk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747104477; c=relaxed/simple;
	bh=xjo4F+EQtfu/ZGSKPuTGFfAcisgpnq+g0qlu2HEO7LY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=chWeBm0Ke+XrEMPr64IjRgSjDRxqdb23jtjE2NJMYbM/yiiH7gptEx6cyvJ16+xW1AwEOEH5wS01nI+wsa3QBcQ99Qm767IWRJPwmuO5seJEDaTuiAf69/NjJgwmy0sVwbVWMA9+NSQn0xYjbWBULiFtysR38iHve8myeocTNLI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=ddbl+X9v; arc=fail smtp.client-ip=40.107.247.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=w+ODXMsFmNlIbo99HoWXuHnolNV62JvN+vqdA5PqhfWkct1iNiNQiKHMQ4sp9Pb4uGZHWZb4msUoiBEAz7kqRm1IGo/KOCw/O5H9pfgEM0rvrKxlPfZXxtrVo6ugbRxdspP9xpJx3L/FM+phdOvApss15KokByHDCSSi9ic1NS7CscCwhTV8AaekMqWVlCsB13W4WmOTvZjo2XIEt+xCL48Jk11Ysn/URTf1i6DxTfGLsQl5My8akD8OWLLAQLYi/nsyUOsJq8xoXXCY+uikFAmnpvs4bdXMhBkbuq9gIzGBST7y6jRk0rT1ks8z3JUe2GMu+sc2uTjCTPQLHikCdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MFamF+OCS8wgcpMpnEcNfHs3S9t5rswoVk0jAMHs+Ds=;
 b=l4T9115JS2+BVPBWE76DOULxe7HM2wpKn5Fanl1sJxJCeAh31ovwJd1TuEfR77ZFvdo4Q9DTmuuDSiikv7pc95FhIUiZa5ZHIXxiGJFU9e4rd4AyvdNyQE9r8f/AI/TyjXwg2aJ1UuQwLAVWXFT/UFzrVlW4dfs2kc3S6eFFvRaF0Idp9htkGKyAwSas3J1oHxVeIjqvv/HHdFu/QtUhf6NemHI238cMxVkbfvAAB42o6IRcbAV2FTuRJ7Z7lJ5hwJeMAQDipXM0r16E6xti6V8JZg8t8eT3dvUTzCIhZ77TfPuRt+FkKQOdqTDmsj6xPoOXVZzeI9/LfdJwe6Kh5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MFamF+OCS8wgcpMpnEcNfHs3S9t5rswoVk0jAMHs+Ds=;
 b=ddbl+X9v5i36HgAAZ5AIAUQNzk69/kVQ6WhOV0JJkKWvlZrJQ1t3ieuG0p5dNgMI9avfbxtIKYycl/qaU2UU0dcLrXjfxrJd5SF0YFhEEJA2O7n/IlKAYt5sTc8fduzgfknlarQDhHJTHGXIAJqXenzsvLbSnsrbh5fmvjaQMFaihkgf7YK/Aoy/2kubvYVT0PB7iETP0vGoFtlw5XSYJnxl4nRj63qd9zSR30mhSmNOEh7Zu0w9j2EQGiHQpujPh/fVkCNXy3dp0HjKdGe9vuDCRy/QzbhtwGUxyDF/v1Vh8VMZjZXXWsmAIuk00SyCTXVff1wUZch93lucKIUZsQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB7573.eurprd04.prod.outlook.com (2603:10a6:20b:29e::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.29; Tue, 13 May
 2025 02:47:52 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.8722.027; Tue, 13 May 2025
 02:47:52 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: =?iso-8859-1?Q?K=F6ry_Maincent?= <kory.maincent@bootlin.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Simon Horman <horms@kernel.org>, Richard Cochran
	<richardcochran@gmail.com>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 net-next] net: enetc: convert to ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Thread-Topic: [PATCH v2 net-next] net: enetc: convert to ndo_hwtstamp_get()
 and ndo_hwtstamp_set()
Thread-Index: AQHbwzBmVlv1NLYZCkOzaU3wWu9mm7PP2xMw
Date: Tue, 13 May 2025 02:47:52 +0000
Message-ID:
 <PAXPR04MB851094997FBB7BDFDA6EDADB8896A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250512112402.4100618-1-vladimir.oltean@nxp.com>
In-Reply-To: <20250512112402.4100618-1-vladimir.oltean@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB7573:EE_
x-ms-office365-filtering-correlation-id: 1e94f278-61de-4684-85f9-08dd91c88e5d
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?jPh+/+JE18zIOTIYkRqXH/Y4lUXkkXTlRboo59jP99EL11wN8/EiBFn8Nt?=
 =?iso-8859-1?Q?1K4h0AH4yuaOGhx3SYO44xcn636wV/7nYFJhLkILT+IIztLkBvxiq/hPUN?=
 =?iso-8859-1?Q?Wx4+VyTgmcqkuDcR3Wgrq0KYr9w2PbdhwauQ4lvgX0HEpqdpj44pKec5KF?=
 =?iso-8859-1?Q?yBLp4sHIDKW2ovIaRupgKNrXKV/E3WUuXkEYQIAxxOTRWrPLU/3MQh4ZDy?=
 =?iso-8859-1?Q?2WStz6dA2XI5/dmQNnGy7VXOejUX4YfVPks8DoMxYZsTpIYd4gYMblyBdl?=
 =?iso-8859-1?Q?m1oeg33G6ekkE3xbnMDEOCi1Wk4iMgXk3IPZa8rVdPT5ZnyC4UwXObpSZ9?=
 =?iso-8859-1?Q?mrROc7GsSJ/vInoD7sdTe8e49BmNHyNnMTJ9s1AJv0ZxFE2BuaFvfLvxbB?=
 =?iso-8859-1?Q?UoB7Ud/wTjCUoH5nGSYBNYqv2qqk4yyPcwGCApmhnsDsM/5PHhIiiCky46?=
 =?iso-8859-1?Q?ypPYaQUPy4hn2zT2WQlCYZ01MG5b+a3/Tgtic4e/3VNIFd+iUqktuJJvzk?=
 =?iso-8859-1?Q?8nDNH4I7q282bmMUbg2ABW0R0qwDvlj2b2WpD4emJ29aduLZfBcFihSBua?=
 =?iso-8859-1?Q?nS0aHUXUP5R9NoFqrvPJHMigsFrdDYakWakKfgmiE99a8WNKuoBWMQA8sw?=
 =?iso-8859-1?Q?s5TYUcuhhmLp6F6ni+ZcX9Psid5quaTgwxxmfuIG4QymYmiftTjC2h4CDD?=
 =?iso-8859-1?Q?yWr1s3OmJf78TV3+2akN//paQ2Ckg3GGm8FuBjQJmJKTk3EXrE1Hlf9KFi?=
 =?iso-8859-1?Q?GdFjy8+uwa8B4uQ/+MJYfiFs+SgFrbxlcbHJmkqqAo4cBTwx1w/jozSxLl?=
 =?iso-8859-1?Q?PMgi+qraj2uupkHrYhQ5HF1a56BYj0dvlKREKcLFny/P3ZsYjBCLNf0KVn?=
 =?iso-8859-1?Q?V1m46yQz/RkllOZ3t7yGmPnUqw1dudsOuIr7mRO9yzkFC/+rr+lfIpq2Je?=
 =?iso-8859-1?Q?/xjA+CqU30CxqvAsulifJjfctdjQvx1dH8Y82TMDzs3yXfw/+glXH21KT9?=
 =?iso-8859-1?Q?uABMJsiiorqXrRBMNR3hAx6T2JmzPGm0OwopR82Y12pmiTlg+iatPYBHWm?=
 =?iso-8859-1?Q?SdnK6IF5N7vgDjNJOaAQqA3/UsnXsg1Lw24mpK5uxERkzVGSIHhpNF4JeQ?=
 =?iso-8859-1?Q?UBmoGHFKmh2b3Iz5oC5WUQO42zTT9ErEmNh9njQfElm1t1auTbpH1fvRGq?=
 =?iso-8859-1?Q?AQiCom2A16DWPg7enQ8O6bhUA+gPQhJvlxTr88zza3am9R9FZfW90tzz2C?=
 =?iso-8859-1?Q?zIcEpXAvERtGPGV+voZ9+ru3Y7DuQI5+G69/QSdjx3P9OHI6saU7258/Ee?=
 =?iso-8859-1?Q?7AJkCBq2zZ3ei+J7dbbCAZaNYcXhurkFVNCEgbUt1mFYC/KHCkZUtzEuuZ?=
 =?iso-8859-1?Q?NX7jMBDOUz0kiNTGXupeUuwqxlSe2Br1WQ/1borx/qlcvonuN3zA/vtvQL?=
 =?iso-8859-1?Q?zWgbTT1UP9UF+oIcvxxeq/IMPni0DiQJLdz2IoQnJGn2/HCYioSPHK19N3?=
 =?iso-8859-1?Q?nNcVUxb77XoYkyPCKimyNkfAs7aBcXLD71TE4XXxNZWg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?yYd1hcLBTNBXIoqP6elrflytG5Tv4I/TNOA/XgWAHAuz1dTzskgYBO/c8T?=
 =?iso-8859-1?Q?zbqR03xXaHkuz0Fcqj/uQoB3fCaX4Y6bYGfrV95TigmD7nr9LCTr1TM9iZ?=
 =?iso-8859-1?Q?Ci9xVIu/vpYyUJlCBmOt99S5F34Rnx8cLysGcg5Hm1XN5P91NHfnwi1w12?=
 =?iso-8859-1?Q?HT1Iu/86sMHmrrkSS/rdhYn1cAvA+xL6d/BuSuGMP+C6HM6BUAMwcVZTpq?=
 =?iso-8859-1?Q?pMMAp9XONOyg8jrqoF5IICHW1gufxLVezVeo1ou2+a42VLjmI5aVmm07ji?=
 =?iso-8859-1?Q?XybU40gSqEpKpL4tbgfJHZ1qgMtqEgHX1N7w/bLKKmJ2QH8potK/ZQmOHW?=
 =?iso-8859-1?Q?Z5GLcIbHhO/M/2H1sHeN74wskCHq9dJOH1Nbw2PviPmDJcoFlKcbeKy1SC?=
 =?iso-8859-1?Q?br/ZYkIXXoeGm3quzfEv0OO/r/Xmx5eBGZO/7eMCXhClWFOyiuPm2EGQUT?=
 =?iso-8859-1?Q?D8IaydxAI2pXRDKCqo+yR+K5Dn+l/u1wsLABdD6lCZ0zWevBtX8DqYcadP?=
 =?iso-8859-1?Q?ZasDo8K4KnQIV8BfDFdk8Dy08wLjrVVybPGwV/dqj88VUo2EoCczqTq4tm?=
 =?iso-8859-1?Q?lQNlmdhN7YX3Z7Cg7g+WOxBAQjiYrbv6waRYFoHa3yVK207vgDWfjwpRpB?=
 =?iso-8859-1?Q?HrWWqhdVTs7FXrbkzCr1s6fNaYk2IcBGBW5RYGaCcVfU37KRkRik/xd4Dl?=
 =?iso-8859-1?Q?pDnJKNni1xuvK7AMBjSgY71GV9uLgslQxkjRMzDwKF1oDNnvAGq1fdetOz?=
 =?iso-8859-1?Q?6EW6SN6pffMeOplyUssXrq3GLPFLV7b6dGiaGsb4LVqPcQs37/apWoB1W+?=
 =?iso-8859-1?Q?nlx9oloiETjEZFRAq26V1DRqgXO8xhl/0pxE1wPTdGqsqx8qqokQeAPgV1?=
 =?iso-8859-1?Q?Kf3GVVyuxAcHpKkHLYWYswLlZVjuCVCNiUnEiwxohZmF64WBuAbUVroqEm?=
 =?iso-8859-1?Q?gkjhgSwxoNAka+6WN0MTnMhUxtKfh7Pw8+XWxdCpWaEzocV8shWpFBLZ67?=
 =?iso-8859-1?Q?BTKMHzuW1NslzOig2fpWrcQnkS/HYkr6DuUmhRzR8yv2zRDggA+0fV17Ej?=
 =?iso-8859-1?Q?UR85Huq2L3EwH1hwwTL62XsVFz415FzE3PdzCtqFk9yEdXnRnw+lYt26sw?=
 =?iso-8859-1?Q?+JJno+PlweHTwC0ShmTTPWpfSKiwUjRN8KV3sNCkjEb67FWa0T9Ue2qUOd?=
 =?iso-8859-1?Q?egmLa3XoIA6u3cDg7hiSeLmTwNFEo2n8iMb488mvg3Izwu1wE0BTrnMJsu?=
 =?iso-8859-1?Q?UzYNKX/969mA5DMySsKnGyvoxUdFgzmSC/6fiAi9Z8X00r/sIsEe0ukTsx?=
 =?iso-8859-1?Q?I5dmh0cQw6M4nmJP7x0rxOMBb2Vg0xjvoyF3s2mF5lSe1VnSoP4ptaPagq?=
 =?iso-8859-1?Q?UyjohtvLLXV+mjHNq/coa9DJ1ZpcGZ6EA5G8QnskffYpUvP105um+kRgDe?=
 =?iso-8859-1?Q?MAIiFC0aqKgWHbnE2A6zdIE7Slq2emKJpreKtVhvTLuplJFXc7PRX8w65b?=
 =?iso-8859-1?Q?Jtv8/59mA1GJjgQ19ja37DLnHopUEnNq/Xzsx0Kf08lun+/orVNe4Z8yoF?=
 =?iso-8859-1?Q?4glCR5wN1D1wwkMDcvkiTmQVNp+4TelEtYXADeV8WZpAxS6rzDAY8Wza2F?=
 =?iso-8859-1?Q?zMHFXqtaDwZ1Q=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e94f278-61de-4684-85f9-08dd91c88e5d
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2025 02:47:52.3879
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GBre4nzo8mrjP+CMAVSAEVYjM2+5QUkiEoGK+scdg5c7+5zqcrq8MTtOktUIm+O+4/zR7/uhSFnb6YRIr7gfTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7573

> New timestamping API was introduced in commit 66f7223039c0 ("net: add
> NDOs for configuring hardware timestamping") from kernel v6.6. It is
> time to convert the ENETC driver to the new API, so that the
> ndo_eth_ioctl() path can be removed completely.
>=20
> Move the enetc_hwtstamp_get() and enetc_hwtstamp_set() calls away from
> enetc_ioctl() to dedicated net_device_ops for the LS1028A PF and VF
> (NETC v4 does not yet implement enetc_ioctl()), adapt the prototypes and
> export these symbols (enetc_ioctl() is also exported).
>=20
> Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
> ---
> v1->v2:
> - remove shim definitions of enetc_hwtstamp_set() and
>   enetc_hwtstamp_get(), replace them with "return -EOPNOTSUPP" if
>   CONFIG_FSL_ENETC_PTP_CLOCK is not enabled.
> - delete unnecessary config->flags =3D 0 assignment
>=20

ENETC v4 can add timestamp support based on these two new
interfaces, thanks.

Reviewed-by: Wei Fang <wei.fang@nxp.com>



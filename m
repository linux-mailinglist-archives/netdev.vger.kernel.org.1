Return-Path: <netdev+bounces-221046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EFBB49F1A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 04:20:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31C431BC380A
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C10C72459DD;
	Tue,  9 Sep 2025 02:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Zr6Xy7Bn"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012065.outbound.protection.outlook.com [52.101.66.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE211A5B8A;
	Tue,  9 Sep 2025 02:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384438; cv=fail; b=BXFbOUt+BD1KvQFVNkQo4dqiGOFdlXuEySFuDaPM+t75PT5JC4eVBMdOS/k7k6O7kVsYUb2wNeFTyEvr3VZbve7RNCdZL7kc7P53mQCJX6IO0JvHqr1a/eWancluFRPVJjWdInuqgIW97PbuIam6wVybIT8DlwHTUDECSN2Ov7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384438; c=relaxed/simple;
	bh=rKdhxsyoQzJRprl5lzrI9AeGwNs7jufsHXmvRkEkVwk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UNxmz6e8pei0Cg7AYU0Yfl0czmWrYz6eIZjzph3fW1CGUw8I0A/1kNCSwc3RlrkD3bCT6xSv3GSnUeGtrS8/9/OAeKm0d26IKKHHjw/g/iWzclwB6yv3uMD0CQchDKcRGjAb6UkMDp5AEHPHgx0Ye+wfZ1ujSNuajwSJqHinvPI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Zr6Xy7Bn; arc=fail smtp.client-ip=52.101.66.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k08Wk59XUjSt0rVnuwAAfQ5/nAPXiVAtiGeLNhRO0IzlqVQV6V9QrSaJiFUxOKDIyk98F3pX4HpR0dOrUtpxo5C3zCUk8Y9ZnW7YZ4VU/GBOS6SHRBByATVy+rCdFEjGY7xKPvk/gazAAHaC/elirM8Goe4Aa8ug3HVJuQMam5xqTtHOsEBxg8lkvSrLJfYoFLzDa0HYAwcgAX6D0rFAh+RFUjklpJMqD3F+1o9t9y+8Q4SGRt+HI/2QmJZbsOeYG0QyWBZKKZ8jd86s43pX8TkwGUjd9aMV96EujC98oIxVbRzQxtBgqvFuHl69CmTteMZUBwMH25h4xBa7DttKpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/Lpc2/lkhhds1CihovyPKnbTPvGMbTaevvjIWbTpIPo=;
 b=Do6nQHMYGndJ8Iwo1858pp4qGge/cPJmu5zw8wXVkZdktHolDLTD3VKqTHf5Rohjy6WWCYbi545ekeOg6vNJ9Jwt0zM91mnP8M9iPq+kufYapi6ENXopt3+7fe0bQ0iEgNrnqhIjgCkKYxXjAbTxU2bqqO3HhJTGyuAsuK27lduIWsXpKxZ7nbN1FV1eWinXkZhQfdbId1jwBhHLEFJ7GEemZfDsbmqYQmzkktCFCN54B4Iq02UzxX5tI8CJ2mHHiBsR5U43XLgaGWT3SBySm7T8AIvy6JQS7ahUzvSqeUTpOmj9ZcoLGejxjLzWNeqPk1DrKfkvmXV5/EoqpvDdvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/Lpc2/lkhhds1CihovyPKnbTPvGMbTaevvjIWbTpIPo=;
 b=Zr6Xy7Bn0cbhjSiL4FeoaipkwhZTJLqHeeiDdXjVcA/vSFppAMbxY4kTg+jlOcfXMCym1/5OSYHXGn57hjxInd+DnEqU91hGgSZ2tDFJOjgvDJ3u3WBr2OtlGV5RBEYf2It3FOeNzafYzIPv3Os+9zNnY7+DVUJpiFSRTY3n+kPIktPIBUXamVyJ0N08SAG8klx4Hzb/cUwayyiU6oEfbcJ/AXVpuhhCj+aOc2YiaOVcp61V/SL02Bz+1WJJJ2DulS7o7kJnWMdfddhhEYI/Fxa6Ut9W8Gs41gWGPkp/G3EpRT4rPJf8uXRVms17ERDs9hj/Ih10GrnSzWSsTTRW2Q==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9637.eurprd04.prod.outlook.com (2603:10a6:102:272::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Tue, 9 Sep
 2025 02:20:32 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 02:20:32 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Shenwei Wang <shenwei.wang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v6 net-next 4/6] net: fec: add rx_frame_size to support
 configurable RX length
Thread-Topic: [PATCH v6 net-next 4/6] net: fec: add rx_frame_size to support
 configurable RX length
Thread-Index: AQHcINxFfox/vpewnUeGY9sfglIWOrSKHrTA
Date: Tue, 9 Sep 2025 02:20:32 +0000
Message-ID:
 <PAXPR04MB8510E1571AA25F1F880FC3C6880FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250908161755.608704-1-shenwei.wang@nxp.com>
 <20250908161755.608704-5-shenwei.wang@nxp.com>
In-Reply-To: <20250908161755.608704-5-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB9637:EE_
x-ms-office365-filtering-correlation-id: 7a2114c3-9b57-4339-1357-08ddef477418
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JzGLehTA1xZFGRn08r5nTjCL8gI1HDh2d1eKd5AZNFSxXrIz1XGm/LrWsBsq?=
 =?us-ascii?Q?5+al8h0TQ6zaWvS9F1s3UCTfrosc2dnZRxNru7xUF086YHlCsXpmlA1CWOzh?=
 =?us-ascii?Q?6okCSnDWYx89Ad6/RQFZt+UY/rYEST2Ro/qfgq3j7d0eJInJy8bAgvStYaK2?=
 =?us-ascii?Q?CTRLfumvOeYXwl0PLFwzOEn+yN8UhH6l0aaEFRRRu9lBdbpDhZiaG9M8mJTq?=
 =?us-ascii?Q?aQX6EgXa4z7A7HlHV/VYrLNWKNyh9zkO0Aw0H4vGrTils2/Yf9kzTx66seWr?=
 =?us-ascii?Q?DWz7nRo2W3KhY1FiVNX7QilCdsXUJ05NN0Q5dnqUx0/PXNOonSaZ6OIE1ZVX?=
 =?us-ascii?Q?0noQC5ScewVcapxs8Nv85znkmKapsC4j/vaNDvaiNDfkC7UTNWA81Vnt9waq?=
 =?us-ascii?Q?Ne0GFmIEIlyvb1A5q6CmgXqOclha2YA1I4LckZjDEmMmhmc4IeRL4OLQlfYC?=
 =?us-ascii?Q?y9GF71dwkupchQ6HWbvx5sJCE9EVQL2TsNWI89fqJ85QR6PHzdoTGqs1GjmA?=
 =?us-ascii?Q?AFVjkQaL7uCe8tfWiXqHLQRboZBYYrsnNJpc1fdviQIoiCgWv0GIq38fa0bp?=
 =?us-ascii?Q?UImvohC8xR+zfVHWPoe3+nQGbkdTclW7vicjey8C73KIZICbKAO9QK4+qYSb?=
 =?us-ascii?Q?TZY/YS4CO+TOVD8/+0Ov8dwxBT7/CsVJ1cchhaz0BYV6KdLWdSagna9Gze61?=
 =?us-ascii?Q?l2V4bAViyTGTh3OJgws2ORowG83wyKak9Olo0xmpkfHxK2ebFCzNceQQtYga?=
 =?us-ascii?Q?IhyWukBfVBkbb96xy9VE4EBcLRB9RvXgU/ypLudZ2SMlMyI2iJJ1y3NNc4Hf?=
 =?us-ascii?Q?uGQvMBYFtK/LKwgRmR5a0edPWtAavlalSDsY3f/mUz2sRRTsvqrE+WLagafn?=
 =?us-ascii?Q?GB7X04hbbQseygmeh5spq76ywYSRM2OCPCKHuN4VjNRqvuqcj+m6Xn/sSzhW?=
 =?us-ascii?Q?bOzGOFaPWomdMtM4ohUyVdNnLhJ2VIL1RDpVaXF5rk+Ikty1zU6YvSlMJksg?=
 =?us-ascii?Q?C2KC7DBK+DeM9T6DUivZ3YsjDkmrYyRvho9fg81ZEKHhETFb3yNEkGMIMAHm?=
 =?us-ascii?Q?jGU5pk5yM1qW9KiYoF4SqjrNVZKqGYJ3sYaAiTEcL3fyjsbHOlgh7deQHSeS?=
 =?us-ascii?Q?JNMrLsWH5RB7q0NCg4+kqezT/Fo1aZah48yhqJVmQpfxGyUpv7z2yFZQRsj5?=
 =?us-ascii?Q?Y/97l1YiQ23f1ZXUlY8dGbJlpoDqkP/frTJuITj97NzexJM+v/86nHYXghvw?=
 =?us-ascii?Q?KjXHoU775kDN0dgzE5axeIFKjZXX4z7vcR1eqzxtcxjF8ruurRpXNI5NHFFR?=
 =?us-ascii?Q?JtEyHoVWYBOZGMTAGlyECaDxTIUv2n1SQ1e+hzFiSHSrA7uiwU3OPa6slvSh?=
 =?us-ascii?Q?HU+fFb2DVV89n8Sh5ZBmROn2Df/OUf7R0z5U+g5MHRnIMXzJZ7Z+vLZnEJ8f?=
 =?us-ascii?Q?5IaIEDHPfcUum8qXoq9N6IP9/45CpmsvWRQWktSVxF0Z2yuDIaBkTr9G/fcE?=
 =?us-ascii?Q?1SXgNZa5pQTuM9w=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?u3u7H5fnaNg7JArcJRoPxnMB0SMiaIq+m8WglWUU0SEhgRxwzbhN8TiXa7Nh?=
 =?us-ascii?Q?8/NgLSBDuTuO38kWWr02NkwiX+uUd6mb/eby+0TCpabF2O/XHMPMLNliPTmF?=
 =?us-ascii?Q?cP1+yg2ZqnWsYp51/xMBSBoUhRmbdSyt4NX2Jaz5wzEZSmOiNUUlXSBG0uGH?=
 =?us-ascii?Q?x5qm3/iZx+aRnqgHAULfJOeSj0m5vXnfWdiZ0uN9coB42d/N8CJgzz+xYOjL?=
 =?us-ascii?Q?k7XRqE8i2BY0poabcfiROpUYK5KaOStQeHA3XLY1xwZFe7M3VQ3wKBpFXkgI?=
 =?us-ascii?Q?Nh65d099qeaE540LKSVw53dNbk8sACOlq+7Roi+kdjT+RKXxtZbXOH1+CY3U?=
 =?us-ascii?Q?ip5Dl0FkMA7mm05DVSIetNZzex6BiydadObvtU7W8mNI/FgWFAGSqVfSa0lK?=
 =?us-ascii?Q?8jyf+vno77IzqcYIq6FQiy3ZpNHrn8t8/cWoYxZ1EsFI28WCfWunsIyQx+Vv?=
 =?us-ascii?Q?vEMbjy3aeNtlbuJANFSz8eNC6m/M8IeScZhcwiDG92ACfPSZdUC6MHO0Mgno?=
 =?us-ascii?Q?TBJ2toOuWYgs+Xw6mfs1x4airCkbsGpAi4slTDOlFmiBqvE9wU4Cm2tExNIS?=
 =?us-ascii?Q?XYaQ1n29iNyibIkQGxi6IPTxlhrBpqFHCY5i+U9cwCQmPfKv2Ksxdg3TgTp3?=
 =?us-ascii?Q?Oodo5SVQsIE3pI4cgCpFaj4F/6E6oydVKB730UPuzmt9zo2dU7QGxCvdDzqk?=
 =?us-ascii?Q?WSH972BNm9Bn0JgeqyYaryYgR2xAq/wFOxwVh9lrHWkxuijxO9X0ZlIal1pK?=
 =?us-ascii?Q?X01iMYHBLg0pvIdeoPaa5rug5nXYniaBSiHVFC7HGHtSLDfs69reNgwQb5RJ?=
 =?us-ascii?Q?i1xOw7zPB8whJa3ahdD1wvwofWldQEadQx5WE7zFTBg7B1iXGA3fIySykzhH?=
 =?us-ascii?Q?2fSa8bNmkEPwDAzqeALxL8nc4y9SyzQ3V+p1/PsZvb5OjZYo4SQSbJF9Utsi?=
 =?us-ascii?Q?4b1DOHfA8tz/NW1l68hlnsuXxJrnybZcXL/hz7wq2qz4/MEGVJfMEZEC/R2j?=
 =?us-ascii?Q?fYw8s1133i/AQFHrJpatVBcuLpj0Mlil4q4SG70zGF5vvnty1Vx7eRUE6CCt?=
 =?us-ascii?Q?hnfVT937T+pA9nVZn9qN+nTInqfe8A5QbDmPv2Q6El6siUNHu3XlGmS7dVBu?=
 =?us-ascii?Q?M+/E05K8/7jESfakpvYLCnCBGQvtpoAHPyRUlKV3WNP5HtRgdDCJjGfKawT5?=
 =?us-ascii?Q?Ynz00thjKaAhkfZTJNayEPT757OXwzsCK+VS0rVW7FIejDqZ2PLFlSOH3qYH?=
 =?us-ascii?Q?jNQDNnYvrb3uUn4nMCgxu2NtaLyNa6pjFEwblN/a4eiRoH0WwaW9xrZAgK3w?=
 =?us-ascii?Q?5x0gW3jVcCApnxgRCKyIJZncrvIcOiwvrlKMfl2QjLy7I5nL2nQTTPY2U3s3?=
 =?us-ascii?Q?K9Ow+jbbec0qS8JbMXUy1m7YSRBIblPBX5ZCtZla2Gv210iOO1dIYsiuthrR?=
 =?us-ascii?Q?B+twaTLtWdkBJESORESBA18ut2yTMS1tmGpnjr7rjwpoBN+wnkFPvxdrkKcj?=
 =?us-ascii?Q?m7SrQHGtavmVb9BJIQ1KNLd5fz5ujqjd7aY2IUoMK6oAQcqDgf++JztJYIeI?=
 =?us-ascii?Q?IDOG5AcSswIUDrAHjfU=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a2114c3-9b57-4339-1357-08ddef477418
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 02:20:32.5854
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0VVA2AUlZZmyPsM50dwi6HaldAS84zpWfpayG/zyGe0cIepOcdvg1WLm8fS1NduMzQWpPUwQU0ArxOYLadFBlA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9637

> Add a new rx_frame_size member in the fec_enet_private structure to
> track the RX buffer size. On the Jumbo frame enabled system, the value
> will be recalculated whenever the MTU is updated, allowing the driver
> to allocate RX buffer efficiently.
>=20
> Configure the TRUNC_FL (Frame Truncation Length) based on the smaller
> value between max_buf_size and the rx_frame_size to maintain consistent
> RX error behavior, regardless of whether Jumbo frames are enabled.
>=20
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec.h      | 1 +
>  drivers/net/ethernet/freescale/fec_main.c | 3 ++-
>  2 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec.h
> b/drivers/net/ethernet/freescale/fec.h
> index 47317346b2f3..f1032a11aa76 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -621,6 +621,7 @@ struct fec_enet_private {
>  	unsigned int total_rx_ring_size;
>  	unsigned int max_buf_size;
>  	unsigned int pagepool_order;
> +	unsigned int rx_frame_size;
>=20
>  	struct	platform_device *pdev;
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 5b71c4cf86bc..df8b69af5296 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1192,7 +1192,7 @@ fec_restart(struct net_device *ndev)
>  		else
>  			val &=3D ~FEC_RACC_OPTIONS;
>  		writel(val, fep->hwp + FEC_RACC);
> -		writel(fep->max_buf_size, fep->hwp + FEC_FTRL);
> +		writel(min(fep->rx_frame_size, fep->max_buf_size), fep->hwp +
> FEC_FTRL);
>  	}
>  #endif
>=20
> @@ -4562,6 +4562,7 @@ fec_probe(struct platform_device *pdev)
>  	pinctrl_pm_select_sleep_state(&pdev->dev);
>=20
>  	fep->pagepool_order =3D 0;
> +	fep->rx_frame_size =3D FEC_ENET_RX_FRSIZE;
>  	fep->max_buf_size =3D PKT_MAXBUF_SIZE;
>  	ndev->max_mtu =3D fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
>=20
> --
> 2.43.0

Reviewed-by: Wei Fang <wei.fang@nxp.com>



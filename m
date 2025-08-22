Return-Path: <netdev+bounces-215959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D2AAB3122F
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 10:48:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80CD916246A
	for <lists+netdev@lfdr.de>; Fri, 22 Aug 2025 08:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB2C72EFD90;
	Fri, 22 Aug 2025 08:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="VlY/dgGU"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011007.outbound.protection.outlook.com [52.101.70.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9C02EF651;
	Fri, 22 Aug 2025 08:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755852285; cv=fail; b=CeXWxV7XT7Zny+2ZFyFhvQouUD2j0C7tpb9N2qXTROC6bxzx4XDO7BcOFriff4D9pT2MdSU7Ry9VmJ4bsbFhYZL1uhMHVbY/yw9aSSf6uYzzKeWOHXGnsH2Jnoj37opocu+w+sV+vca3EXXJlnCdf3szbtpJN/j4XYhX0cwTBg0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755852285; c=relaxed/simple;
	bh=v3fxhnhTli7reZt+XOc0s0PsKv8B+w9jrfpwzZvHUno=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sk62H96V/uUPpAtT5hNBEquYf8wbVJ6rjs280XDDo1ifioK0AlP1sN/D3Tu0aTGL9R7Sl72KttaALdGJQy6D/aAogqd3mo7LJhxehBpF2yx0BP1653gr90VB2ndmZcviKMuRwKL5OdZsYxIQ+X281lBLxPOj02N4rUjl6R70Vzo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=VlY/dgGU; arc=fail smtp.client-ip=52.101.70.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fndv3caeVl1qumrwEZXWZLtDi7lQBuBGV28cM2/CoNSHe2AHagoDPPTx7LQQ9b2ieTAkYampwt7DBGIG4qjApPzRcBnnYC3zkD+RLeSEoQMZakyRkJX0POaHLrn9qlHQhnNMHphlL85cPvC+ts3x+6reNS3SCOYp2Zp2rOZ57JjhqDDlHdYe5jrtr6AWt6ggMpvyDWQh2FhMFb0V55bhAL7KkyiZFokGUx3tnWhPs8TZE1p/+4d2HKuHDGvuGaM2+QkIFTRST0jxwDH3iiQaEr3TZU3QMBgJ9zVgg9sTur4+XwxfB9xOjydiIiOjKIsA8J/a2GLs99sVQ2CROTId8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t8d/EsxwJdxXuR2IxEqzyhLgKg5tuoc8jO480+LeQWk=;
 b=FOlvM8e5u4txPvvnEwK29k0xB53ir6NYQwTa6vRHoAHqX6tML1VCbO0+93y0xVO5tbSS8szWbYFWqI/HycZhaCsXj8wlilEmOj/5iaVC3bYS9Nr+nBkHQsE5jf4TL3GcvMInvmiZ9M2fyHjQJ8PKjibDuK+U3+WktOJbIfVFdoWx1oot2D5qYAYWKXtliPgQ71REBLuFK1m2h8oa6wqnKApF4e00Qb9fz9s98yw5Ai3ihLkSPYCi+bBNygw9BVAIWVW8teYKLdww27+/Zxec4ifqh1eIAwBNbLmHp5Mpt119nXN84L6Rk3929BzNNthAx32wvjWt+2/RO3ISgCxWuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t8d/EsxwJdxXuR2IxEqzyhLgKg5tuoc8jO480+LeQWk=;
 b=VlY/dgGU9Ez/cWWk9ydYYM2tDPQq/6bq7axb937owe1Ig7kvTFxBud3z9zSghN6nCaqOjEz9t8ogkfjoFKZD0qVjLZKSx32KGiwGIL48v2CF6k1iK5IGwYfiV+ASQAtViaQhtF3WX5RtWvpx+asOADNKerdVkXjhAAeP5jPqmoOw3nMLNFIkO2p0GR4g0QjmBNfU1Wg6eomj/TjfbSePQ241/Y8dSXLkMJ3tJjzGRlVsglJ4Bo1LseBH7vtIcJye9SJ8DNQmAfld5lpja09MUEXswIDGsWgHWFG+xOxLOuRXr10ezu/QhjwJ7ffBE1ukmTdkV4MWukIDhJwvWmcV2A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS1PR04MB9557.eurprd04.prod.outlook.com (2603:10a6:20b:481::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.15; Fri, 22 Aug
 2025 08:44:40 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Fri, 22 Aug 2025
 08:44:40 +0000
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
Subject: RE: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Topic: [PATCH v2 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Index: AQHcEso1Ue9PAAZZWkmtSe1X7IJrlLRuVqww
Date: Fri, 22 Aug 2025 08:44:40 +0000
Message-ID:
 <PAXPR04MB85108182AB184083B5F32D3B883DA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250821183336.1063783-1-shenwei.wang@nxp.com>
 <20250821183336.1063783-5-shenwei.wang@nxp.com>
In-Reply-To: <20250821183336.1063783-5-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS1PR04MB9557:EE_
x-ms-office365-filtering-correlation-id: 6117706d-7c9c-4e0e-6474-08dde1582264
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|19092799006|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?vxzuE4XTCrqTgm/Or3PQhQXPa1TwXm+jkLvvHJ5X1QHqXLiSBnHP/w5+4f9t?=
 =?us-ascii?Q?Ksb1UEbRaoYulht100I+jrd9UcTiCU0Otlv/adgcrXkeH9FY+YACLWji+/B5?=
 =?us-ascii?Q?YYR0k1xH6E0KqoH32y9aJOCIScvfodw/ANHpRiB4McCnZ1JkUJJqMI1mFcoy?=
 =?us-ascii?Q?VfBMAYHccE1IYRcjPrAXSRIMNEuAsoVowfSernMtf2jWOFhhocjvKCCXqH/f?=
 =?us-ascii?Q?1v2CZLh6JP7B+Lguo3pYv6uw6K0Gipj6d0085jugkhZLKWoa6+8XdelE4Nn7?=
 =?us-ascii?Q?gMAmiSy/DiB9L42VsY3OiamCvKenANiNX/UjCG3iPVW6SJPlyeGDic7M8OGf?=
 =?us-ascii?Q?p2vh0SfRXOxb4U0te8OB8teeEPcdcTcmAO5wDEygIvKUJu7jXTKKs1pfzApY?=
 =?us-ascii?Q?7jdbwkaoLj/C6+FL4Aik3vWmqTqXzYierDU5wo8oiMk7lhttlhZ01pgKnNFC?=
 =?us-ascii?Q?7rR2qRzQyjMsBih4nFurim/BiE+xUeQ0u/wxrQUHsmzUDlAkcj2xqNjgTwKi?=
 =?us-ascii?Q?ZcxGYcZkU4NdpZCcd2gSQp2b0CaEXNL8d3QWXOVHAlkQncisTUBkfgZPj5Vk?=
 =?us-ascii?Q?6Gd+4Kqds3nNL5QEroRb+0VLG+IpCKlReiiNesahGRgtSTmoZUeZVlDlHnwr?=
 =?us-ascii?Q?OrhGuKnoeVfO4rHdMCKbs+daqWpF7qX5Aed+BgVv3/srOhRs+wj0gI0EhPmp?=
 =?us-ascii?Q?f6Qn6oDRKw8TQq4MZZFGD/rrCRnZa535G6yYniKqJ4bUeTpwVAkLJr83jZAM?=
 =?us-ascii?Q?zlGbeuYieFat/DP4sCbyx6zTXPgIJZriR6noYhmSslt5ybvcBEvsUQFyvBFG?=
 =?us-ascii?Q?sE5mXh7q3QE4d7iLLqvavwBsKPPnhJxnJ/ZShV5YZ27GoB1a+ghJ/VxH2O6V?=
 =?us-ascii?Q?YUs3x60yyj22QuHUuwnXYOU4jNI6S2R4vfBaRkLzdroGvNe7Ylgxl5dU9i/6?=
 =?us-ascii?Q?rfWDFqL0zPXl0yi6LhV3KE88UgBxXgLNrW/noh8GrtFmwmhwaRskUXGC788e?=
 =?us-ascii?Q?bbWoVSs8FjI4AaNkt2CCt7sLNVWMFxfUZ7BSBTv4H1JdxHhCrUCiWY2rzrrA?=
 =?us-ascii?Q?ybhfKOSfChM3bcI8BS9UpqCZoC0njk+UP73x4Im3znxaDaq0tOQga9uJ1JnH?=
 =?us-ascii?Q?vji6tHzk5A82d0dhk5NEMrGKMGFXg316MoijaChBL705vcCEYGJ/bceNNdr4?=
 =?us-ascii?Q?0Esy6sksd0jT6vIfjhhc0acjWF1PPPEZbb6OgjoHORtWjmRBmeuJHOMKXGaO?=
 =?us-ascii?Q?vFTkmVF7L2JQ5m7788w6aN2Y0pkXaoIonvVCHJ/36LwFAoUoudV+XEMT+niI?=
 =?us-ascii?Q?fSIh82WlNUBCrBqxzry8aEiML7uIcgFUFXgf51xVMvxQUSMkNt3FjRVMQFG4?=
 =?us-ascii?Q?3C6RsyqlhROklXTbxdRDxbV6bTjUsy7Ix5WPf2TLe+paOhpt9YTLAXzguB9q?=
 =?us-ascii?Q?hYfGEBlYrjwlH72MmVC/uIMlfFeexZJZtvP13qYUwA1Y05yvgROePA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(19092799006)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?Qi0joetdu6e+SJPBtjUgVqr8ESlzvMhI3XhYpCr6TXNC/34PPt2N3UwaoOq9?=
 =?us-ascii?Q?SOeYnZ+f8ZjciQWi91nvkOeZR/fq/3A2TuVL+vP7GSPjQQJEHBBIawHsHY0j?=
 =?us-ascii?Q?dQ3gHTjuElksvBznuijOwFMfoFx0JpAHuHzfwXHqESp3Ax1IMTizpyNqcCUH?=
 =?us-ascii?Q?lXmgzicLge6x6WYomFxnKjotW3J1gt9fOP83rEohGyMdsqDPW50vsx3pjbOi?=
 =?us-ascii?Q?63PhCseRCu3VD+YPlIGOqWxrXxiZGw+oqV6TAyHIvdSPlcKtbAaBQZriIABT?=
 =?us-ascii?Q?euYX5SVpx2LeyYjBNHoOCgalHeW1cgCoV+HkgPe8F6SnPHh55kFnFOyLi2DP?=
 =?us-ascii?Q?C/7MpNL3619BgdHNU6dfrhtavYouxbPYxV5EtZBt+xVPw5dF6zKBhQrPiB1U?=
 =?us-ascii?Q?zPZWk0qIO7FZXZB2lSu96cvQRFMe2pwhlgnlc/GVqv19OIbNNADeIJpSrrEN?=
 =?us-ascii?Q?lq+yyUslRJgyEwLcPvs/AJH8Pat3joSPemeGfzDEAbdkF38rzDjcXSOksC2t?=
 =?us-ascii?Q?xm4VmaoPXtDAeG0bX8mrslXB67DFMtNpPRvHorhthUky96sWOtXtgtWVDqzk?=
 =?us-ascii?Q?ak65DL73LWhShMOQ0oy6RTddef1Tj4HinQe3WPwS+aeU+rk0XbCnPKU/kpYH?=
 =?us-ascii?Q?TURdUzxZa1YQM4cCSoov3jlrIft2H7GPMvdCW2M1UgzDoYSPbmi3ncA87u2N?=
 =?us-ascii?Q?TbgpFqjp3NTSQ/cGzsKlxwe38iXwCUDgpZECZRtGolBqMMSQyQdaRLPNg/1t?=
 =?us-ascii?Q?fHup4+67MlghP3VuRB4dk3ELJo28CGMq/4+Ju0TAA+dG2XENknH4kgvEdc68?=
 =?us-ascii?Q?/q4RP4rfzEmrWwqBJgHdfUY9nkWW/85B3gGtadxaNzMcaV40RXNAb8Gkbng3?=
 =?us-ascii?Q?+9G4iRvysooXDv4dz/ZAVzKBBpqMD49VnsGF0ENXuQvSqLyXsV/LCPIPkOx4?=
 =?us-ascii?Q?GopKpXnq3KTAVSy8OVACouCOxjAIXIjTaxgjaeG0Zz+dh/CN43uR7mkcVb0Q?=
 =?us-ascii?Q?ObIySq9ES81WXoV4h3AtjyskWnXn4WGWVnUqUs+WvnrrEZxqW4y842ihxdmH?=
 =?us-ascii?Q?dFnAIRLyuhLyot+FKpFiH95v6moVXfkOUFp5/SMqtSl//2nd1IaaYkXGW+o7?=
 =?us-ascii?Q?g/ueRweAeR7Yz8Eg5rzw1vvssfiM8nBMsjdt1aSlkirPaZ8BRvA7fRskdr6C?=
 =?us-ascii?Q?e001mFe8axBbRPezX1c1QWjlStBpuENDzfWzSrbSRAiRW6rYUdWF18DjnXqm?=
 =?us-ascii?Q?QCrNFL3WxIgI1enx4WOpsy5LciAjJybjjRRA63o7DsP4/d0oN/9/R3Tq/AQU?=
 =?us-ascii?Q?bWyfNRL4JD4ePZzZMmFyvyOCEbovW5Mo7gUBCxg3VhHfsDUnJCHJZUPfuJ78?=
 =?us-ascii?Q?/ffEC9wdtcJAB1OaVxI46UUE+B+ofbmAZAEH4yIcq+0/d74RDP75i5+JtcPs?=
 =?us-ascii?Q?5o5z+zjaaQgu8kRPeJFaIuYua/0agC0U8V3JPc7U+QFTy9OyVcG7OCIlEwQt?=
 =?us-ascii?Q?9TvMxinxp7ADcITqVFOis/1LtCVfkvOzhlsqONKSgqqKNVJD3Ao2388M1dsJ?=
 =?us-ascii?Q?3oV3aBVDniAVUzl/DtI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6117706d-7c9c-4e0e-6474-08dde1582264
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2025 08:44:40.6652
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g0MlMEXpeBa/SJI2OJiJsjKaGK/W60Z4oN4WNGQCjPohm+/tZf5In5FLvFvZ3aMm9YSjV3yaLL/L7mgL8CjUBQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR04MB9557

> +static int fec_change_mtu(struct net_device *ndev, int new_mtu)
> +{
> +	struct fec_enet_private *fep =3D netdev_priv(ndev);
> +	int order, done;
> +	bool running;
> +
> +	order =3D get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN);
> +	if (fep->pagepool_order =3D=3D order) {
> +		WRITE_ONCE(ndev->mtu, new_mtu);

No need to write ndev->mtu, same below, because __netif_set_mtu() will
help update it.

> +		return 0;
> +	}
> +
> +	fep->pagepool_order =3D order;
> +	fep->rx_frame_size =3D (PAGE_SIZE << order) - FEC_ENET_XDP_HEADROOM
> +			     - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));
> +
> +	running =3D netif_running(ndev);
> +	if (!running) {

running is only used once, so we can use netif_running(ndev) directly
to simplify the code.

> +		WRITE_ONCE(ndev->mtu, new_mtu);
> +		return 0;
> +	}
> +
> +	/* Stop TX/RX and free the buffers */
> +	napi_disable(&fep->napi);
> +	netif_tx_disable(ndev);
> +	read_poll_timeout(fec_enet_rx_napi, done, (done =3D=3D 0),
> +			  10, 1000, false, &fep->napi, 10);

I'm not sure whether read_poll_timeout() is necessary, because I
get the info from the kernel doc of napi_disable()

/**
 * napi_disable() - prevent NAPI from scheduling
 * @n: NAPI context
 *
 * Stop NAPI from being scheduled on this context.
 * Waits till any outstanding processing completes.
 * Takes netdev_lock() for associated net_device.
 */

> +	fec_stop(ndev);
> +	fec_enet_free_buffers(ndev);
> +
> +	WRITE_ONCE(ndev->mtu, new_mtu);
> +
> +	/* Create the pagepool according the new mtu */
> +	if (fec_enet_alloc_buffers(ndev) < 0)
> +		return -ENOMEM;
> +
> +	fec_restart(ndev);
> +	napi_enable(&fep->napi);
> +	netif_tx_start_all_queues(ndev);
> +
> +	return 0;
> +}
> +



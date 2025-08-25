Return-Path: <netdev+bounces-216358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B6549B33479
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 05:20:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89B56189DA7C
	for <lists+netdev@lfdr.de>; Mon, 25 Aug 2025 03:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DF4722E004;
	Mon, 25 Aug 2025 03:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="NahRiDPB"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011043.outbound.protection.outlook.com [52.101.65.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65B0CCA6F;
	Mon, 25 Aug 2025 03:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756091996; cv=fail; b=avw+T/XRkZuDEC7IdUgao31n0DaoQvistLrg7BJKdC+njj/QLYBXKw6AFGezY7pYePKi6QJMr1Sh3LAHvYeoZFfpxY06Qc3wmX29dvK7VI6csFmMWA5cXx8ETd/S9gHOWiO4Mbn3zBXT0s0RklpFCTTZD7IiYLQOOPN6YSlgM+g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756091996; c=relaxed/simple;
	bh=ImAmLQke2F71M1KblyUCfGKWHvshfSPhobZ1mWTU0A0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xui5ztjBKGX2ULVI+QkQdznlIvUecJTdFli4BNhdWZPrTsJo8xhS75hJ3aKVrVY0Kx3bTEqYB5tkAFYk4qwYpHBpSfgd1ZSi1f58bc54GK2D/SWZAyLVCwL2pxiVp3XaJaMbrwqeKJH9HvmmqBIUGrkyfNmR88i+jQ1Ntb8OLvc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=NahRiDPB; arc=fail smtp.client-ip=52.101.65.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gLs6Gy6pBuxfa2sFRlVr6I1QXcQAGtywhdqzHCbKxywCX9p0V9vyiL5L6ZlcD9zLhox5z8celvqNNq0y66+33ws+f4YXHOcwive2Sx18v0AehIF4kkC+zHnQPq6Wz+f6bEB+s045Ic79vRTZROKSSc4f9ftPbkjrRwY71mUysrJJl0jYWJ/Q9fZJ9cTWalsxRgSPU3zfXcifsLel0jcMFiZU72nC9ECbHFM9huQ2jZpx1lzvQnWOnvxR2qVzuYrTeJFSlZkeRYluWsLZigToYbPlz9VjxTIr+VErHzwd9cI164HDjcCKRlk6vXey4x9U7HtkLOaOUVxWJq48VtDHXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=omo5m9B5TvK0h2f2eT3iDpnsZPkduHxSerNCTgnMIU4=;
 b=fJ/H/OS37LG8fswT7gXQoSH40zuMEs+qaOfyab7uborcBv/WeutJWNNqvGMgezzsXzk8/v2WP9lZ7wCQMDq7O6nHX2V8t2seFCuHmex4WmGKgRnBofZO54pbfRP7vdmqu0DJeLAMSJ5mD+LFuNwx1nEYkgw7MLJWkl6GuG808vlb7VjmeF5glYu1BfkcO7H6zFaWXfEpYZa8bXA40HI8rjqTpfINuA9Pot5XiCbiVwwVmQlvOrPqEFg72SSy9M2JZ6y29Z4GmMzV699kAmYr4B7lKZy5hCavKYJrAuv6BZ9tTQ9Ja/j0r99BEqmR+nslYbU6Hm5Y/2e1igZRhkv+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=omo5m9B5TvK0h2f2eT3iDpnsZPkduHxSerNCTgnMIU4=;
 b=NahRiDPBhXrz/tVXGPzm/RYJOQ1BUgl446D/GmWbudSBKCwaIbdeyfcGXHBgLxHWyNDXqpJPzhJ46uhsdQXvemXFCND8oOaB5520v8S4JNkIyvyEAD3mjLv5nnzEvZy8wccNHsX5gPv0IoKyqadD4ms8/k0SRuUChhLVsnoDSas3+7nfrrF9L9r/HI4b7Sz61Y/4yzyBEfy5xQ/pYQ9KEvDc9alr4LzZnLUjo6DsWWT4q01La1IhMpExb4qMxWnetzKx/aKNBQPg1lvLK+JVPufxqp0iaaoofbgfC9bxJY3olXy2aSmQnOvFjjCPuKf8tGKe1ctjSkDQyxpVOXNzIA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB8965.eurprd04.prod.outlook.com (2603:10a6:10:2e0::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Mon, 25 Aug
 2025 03:19:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9031.012; Mon, 25 Aug 2025
 03:19:51 +0000
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
Subject: RE: [PATCH v3 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Topic: [PATCH v3 net-next 4/5] net: fec: add change_mtu to support
 dynamic buffer allocation
Thread-Index: AQHcFGBspLrjygLcqEK88ipxHkKr+bRyswiw
Date: Mon, 25 Aug 2025 03:19:51 +0000
Message-ID:
 <PAXPR04MB851020D68D3A263766CE54F0883EA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
 <20250823190110.1186960-5-shenwei.wang@nxp.com>
In-Reply-To: <20250823190110.1186960-5-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB8965:EE_
x-ms-office365-filtering-correlation-id: 1f31106b-ec3b-4f62-13a8-08dde386411c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|19092799006|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?J+xNm/gMm35eX4Q3u+kx/Bdok5DBVzhLpeqUqEu3y67mtlVWqHSvW5X7u7ek?=
 =?us-ascii?Q?7/PdHctE2fVWL+PvxxtloRml+w6HqktCMOCUMg/Byzj5Bl+qprCFNh7XeXqs?=
 =?us-ascii?Q?7wDoWnm6Q23/VVGKzZnAtsOrIizYo5msCH2/iStaXbINzb8sGjR2yhRz/N6i?=
 =?us-ascii?Q?pO93yv+suR/MmuTDslceKpwgqZUHtvzhjClABdLZCn0H/8kzvaaYkD5JpCTc?=
 =?us-ascii?Q?yVDTbKLoKNjvApfi61SdezujEhs/7Po1S8kNklvqq2uK4aH4D32Z+8uiSHB/?=
 =?us-ascii?Q?qDHEkSKEH9JBCVcGDU/SVq9uFREU4YDzjuEsisvee6gOzTZzY4Zq5F3w250+?=
 =?us-ascii?Q?hqzcVGGiLMJGo+sfrDuP1k1vFTNi5AYbHDumWkO2S7NzaZJ3OOaKzvikuucn?=
 =?us-ascii?Q?qojOJKNm9ZvHDOxiv+skf8srBX6pXfuP5KUR8Eppj3eBz0n3AmcnfTSQxBxg?=
 =?us-ascii?Q?NJk+mf7/6LCcI6MuRt24+Mc4zUy7D6L+cztTr8U5naUUwsQxCXUaelNXCBWY?=
 =?us-ascii?Q?vdww1fuSqRW/xzt98aM5CXWlFEpKN1vP66JzG1C7KsIuV1DXQgLQDF+w1cgJ?=
 =?us-ascii?Q?ou0Exg+SABzwj+T+TZxXCl5HRMwl31jCQ/2MtuDqhYTMuzYAc7sdpbY8wCGg?=
 =?us-ascii?Q?TpL6RjocS85Cr83Z8b8jn0g+uh2nOAbmliG5WcrBh1A1uqG/kc02SiyCDudY?=
 =?us-ascii?Q?YtWG4BEhnGbMw3+G55gs0NZ0xvXU7XvkTdLDz3JlA/4Zh7TE/UEm7YrBy751?=
 =?us-ascii?Q?EeS88qaGQSK4xYQFsdNYO1XbZClhWCZ7JYZ4CQHVkW4nzm6vtEMe5c4uIRIM?=
 =?us-ascii?Q?haA83IlF8jQPyPLV06Cvhl94LtVoaZsg8XfTBbO6HbBHM47B0irT1FWNeHBj?=
 =?us-ascii?Q?SYTJ0NoLvq2+YDNux5h1D+4+KD7Nne/W+uG3jSrR4LFCsIJ32MZ9/AIjr5pD?=
 =?us-ascii?Q?uU4RxUPprJwD/oxXJngwt7zxyZAzAl6wVPznoJn/9TyzTFIY9DelwMtBGZO6?=
 =?us-ascii?Q?AieC8mcgo6g6cKsrdKwRgOgw1YzzHVJbFEwIZ0Tx8X7v1RMNDDVuUEqFK+7m?=
 =?us-ascii?Q?9thJi1yBS6LCdN3upSMMZ8oPhWRAcbP2ch1Xi9wq15KoR5y/CaJ6n/EEWMuj?=
 =?us-ascii?Q?IPJXfAQt4aohZ+FFdXjLZ2o2asS2M9j8IiCmHr63RiTZkSO5VyFz2yU85qzr?=
 =?us-ascii?Q?cgwnGqT6OfW8Q7m30pWiopUxxeHuf4FD1hmQRyiFT3mZo0CUzN4vSFifF31Q?=
 =?us-ascii?Q?oKya0Ok0IcPRlai1CkUW14KUl1d5k4XSJ2FpgXsfIE2FZea/EpyiDEVKyed3?=
 =?us-ascii?Q?dIq3rk3Q3tWpLUwb6D9xv2EyJHgwgLr+/C6q7XTeV36opoXuiQyvUP3wnTnm?=
 =?us-ascii?Q?RIUvMHlI7nu3Yogs8aJJRkZlPsxqvPrtbI9Fi/iD2S1wpj38M0+BxxkdPQfF?=
 =?us-ascii?Q?+wsxyFhUTzlIhMQRpgC1pR0qUP6E6kBby2EqM3hksRknUdCl+eRaqg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(19092799006)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0ig5Zx3PGmUdXjLnjyeFmp6qVIb+4iSehy+MVWn/aINEvH2Cs+mlGD9aGuBG?=
 =?us-ascii?Q?fu9zSpvO/a6aMg8bWzyn1Wp8kb1Qe25hHUtSNNzR3iIpszUTz+jWCsUbV0uj?=
 =?us-ascii?Q?87rDYqc2mGoth4YS2/lQg4eme5ydHfaI7vKxgjQLYopfpdfIr5hRqjxupliT?=
 =?us-ascii?Q?1ABqJ8ukaQVJL6F8hJP65bWYfWquLVlOdyKYmDO/hxaUaXUhNKQiEMIKCcMo?=
 =?us-ascii?Q?EnGLwaC+IMauaOisSxGiOyaRiTmQKfkSv34X59NovOkPkCIYql6ETuaHDDBJ?=
 =?us-ascii?Q?/cIxXLsDlrMAG9b/DM0dqw51nwpWTT6XMYLlfI1a45heb2X/VYZScisMvfiZ?=
 =?us-ascii?Q?OImyzhAgAaVnRNdCfFsFRdQGZ9GnQ3qRPoKxvJUq5cwoGCmgEy8RDFt7GvpK?=
 =?us-ascii?Q?slYadMKUFctwtO02lq1lkinwcK7QmcZYGU3qtxXya8VSWGLAJZvZ57m4ZiLs?=
 =?us-ascii?Q?nz5d6F/IbYfDl8Bfd42ZsU2DdHiYTYtwk6ieveUz29dF5N3Zg1udYBc+JdAP?=
 =?us-ascii?Q?JBua0PQGuiPegIiid4sdpLLXPL69k/pmAh78C4rsuNDJwz1I4V642ThEKtdX?=
 =?us-ascii?Q?mpHKZ/yAxZxWm8UHmBFnFmMWsj03Kf+JJXIek/cA3wufahJZO+LYdnuZUMG6?=
 =?us-ascii?Q?Q6NyV7XfE4UAEWOZ/dwExmwgkaryEXwdAyjp5LP57I7YCI1akULUxGNXGtDn?=
 =?us-ascii?Q?uEos6OZPvcFqa9Qr/XzTnvlWd36dYNqNdWx1n1Cldf/Y9kBs5/WmK0g8apo1?=
 =?us-ascii?Q?g3VdZpNMVs+BbzJUSdZkZ7i4uYMBLYX4o8J0+O0Xihnvfhwc/6MhHpIHgnok?=
 =?us-ascii?Q?M2Ii5rnYamQQV1ZwBw0fL3/94ssZcvu4Q0YppjRur4tNwohRKOu5ddWha1M7?=
 =?us-ascii?Q?M8YxwvYBjXAJHQJAaS8FtcvFVB+7FQA7q/iE7yflkzJaMW615AQoBoYPMU4w?=
 =?us-ascii?Q?f1GOipWBWZOcm/1moBcJe7irFDCxf6lygUPxFaDUb6QXoUaft4pt/ekHj1GV?=
 =?us-ascii?Q?erCD046TQDRwL/cf6CPHSC14xsF2k7T76h5E/AZtKipx8II2Ev+u3CAQ2mwc?=
 =?us-ascii?Q?1xKrkhFtEH2BYbk7qPD9BusjFm1cch46CC5IWqaeh0l1DSuFOJWAiIpjhMib?=
 =?us-ascii?Q?DOZk7AlK1dAAmlmm0/pSAi9jxCmvH9so84akP8UUYPSbS+xvjjgURF/hWmWs?=
 =?us-ascii?Q?38GWXRFmhiqd2I3PEzdnoTsNFhEIiY/1eJj7syIc8dltxh4sG9EEuoICi0yq?=
 =?us-ascii?Q?9/VzzWNEyde8tIAQ7t/YXAl5hw8ioLoBn4zB/M0jpqVc7f9W4Kg31z16dPtr?=
 =?us-ascii?Q?dXW4YpFmqPtrAm8bfv8ikF15Ci5+Y1F1O/mgEiBsIRsgefc3qtMz9ntCoUfy?=
 =?us-ascii?Q?UkXHOKSEB7CkeSj2R+0jsdGr2f+KDQOSlka0eNXG3heoV6CEmKWaH1EZ/Eyi?=
 =?us-ascii?Q?kJQRDOQ37ytxK/jhzxr5lLjT8Lykex8XCE6Ac2o+lcYVtpj2eARtYnVMMz/T?=
 =?us-ascii?Q?HOkkJ/sZb2hZ07HdipmKUGrfRBRBL/vuIhfZxAQAQinr2ksSl1CLojcLekna?=
 =?us-ascii?Q?XdBj7B1/PDMn4KJ3Nvc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f31106b-ec3b-4f62-13a8-08dde386411c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Aug 2025 03:19:51.3913
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7m6+zvipUZiPWnuTfIfIPslUwNtgiGa1E2B0LGMCSNu8cSTs9hjpklNYdD6HsPlFUNXWN4NkhocgDikUpCz2xA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8965

> +static int fec_change_mtu(struct net_device *ndev, int new_mtu) {
> +	struct fec_enet_private *fep =3D netdev_priv(ndev);
> +	int order, done;
> +
> +	order =3D get_order(new_mtu + ETH_HLEN + ETH_FCS_LEN);
> +	if (fep->pagepool_order =3D=3D order) {
> +		WRITE_ONCE(ndev->mtu, new_mtu);
> +		return 0;
> +	}
> +
> +	fep->pagepool_order =3D order;
> +	fep->rx_frame_size =3D (PAGE_SIZE << order) - FEC_ENET_XDP_HEADROOM
> +			     - SKB_DATA_ALIGN(sizeof(struct skb_shared_info));

Same comments as in v2, please check the new value whether is reasonable,
if it exceeds hardware capability, then return an error.



Return-Path: <netdev+bounces-221045-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E1638B49F0B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 04:16:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8503617BE4B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:16:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AFF22D7B1;
	Tue,  9 Sep 2025 02:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V/O99e7S"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010050.outbound.protection.outlook.com [52.101.69.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CE354723;
	Tue,  9 Sep 2025 02:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757384204; cv=fail; b=VLDJjQY5MxR6lkd0AbF15H03DeDH1koWBbbki/9n78l6LUA6eYMRsY350VNCI6rxe6N3Wa7ELnQceFMvJkzQ9yQ3YTnt0HWLkKKTa86Lr+gA97d+6YnwfmfgXJN+5twvK8BZHTSwNJTFQMxP8doJLt8SnKO9wFyuuMtol9Ud8HU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757384204; c=relaxed/simple;
	bh=IXRbzfMkjOePrBFVVYjmdv1nlGhrGSPCmwm2RewpuAU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=m9tIDgB04bYoZ+NvspTa4Fg5wJclT5kHO4AgV/QrhIG04LWPaEU3e49stGl5HATpXaReo+xZ0Odem20sw0oEssQUwliAuW+3tYCmR7Q46Tlz6jrTJzPBAys965n3WLvi6kRev7PebIazigbO9Ey7Q8yoo9yXcWaQqHqvjRfIDMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V/O99e7S; arc=fail smtp.client-ip=52.101.69.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=udkyqhMy4+u29nU+EWRLotE/5KVAtl0f2mpSkHkG4vZaxSD8SUt4T9OE5fxQpw15oxz6v7n6UhUYGRiHPucGGGTODHWxjaRdumBhwuaJk8uCphvHhr1oyHaCL6pxR0DXjFs2zBzPAeRizJwLWod1X119TyiovFlmmuqEykn3ynFjUqwO+YKf4iyrOFDq3efljtHdskygH4uiMWhRTjnwc3qqrWLzgggbxhbFmO4Vehkf+KZy1dVJAcyZCnhDEicvUC/07gwLFHM4qXJpoSoEB4jUW6eTbEkHXmbpxPc2IxdPgFZGQXzU1wlsOtY5LeOM8MY2+NcJ+T0m5AaF4frctA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RgTzoM8+cIbKe/J3aKFiluiIV3ijELj6HJYo42O7ZTU=;
 b=xyotcF6SxuVQymBDGuHL+ubGSTl0HWfWuqho8vC3Z0T1RmrPKiJ7mbID+FkYHnw02GzrONkwrJ1D7iY7dwnAYi9cLWhIMkpbyS14oKRI2hwdDIdQOB8cYr1TlxhpdvQCxPPgTS6KWtdTp7pMolZ/8wSN6A7/XXkUhjuvXZoIvj0jJRD8K3m4ocYkeTZPZ7oVAB/bOVe2G8HDZ7wHIIGQqP1k/VYwcmwAKjn8Y2cZKU8fvqgTcMEQjVDIMKm8o6q1d+b8VHxk/pPNPXVb67VTrTz+YCXKXhDZz++GdQtVYj8XVe3MPFYzf8+9z8uF+2v9H7avCZXswyynHrzn4z3TtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RgTzoM8+cIbKe/J3aKFiluiIV3ijELj6HJYo42O7ZTU=;
 b=V/O99e7SocaV9g7cquPzaAUsfjgnN+9H6UgKkUHO69xMK9gMoY/FmmYG8RWowP43DUN1zPj1/BicavM71fLttDKAm8m2pe7xuSiCasvKi0r9rKEpK7BKS/Z4ENNHp6WS0z7Ai7sJh1wIOaFeJrnTBbSObfi1YHI4SUBJExpUnbus1m04lbFyht3LzCiNFtbl7TH0Au+Y9qQiVWAnLQSFje9yiM6jmJSq1WiY1inMv0edz07rSRl7lAVJ3ZSrsplBbJt+ll/GtWdEm/AimMbcwRKhkjhMeXEc3QO9f7l8Gw2A1WLD6S50aIBizIRwHOGQB+ApYNX6DEZUNhG+pb5dzw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB9637.eurprd04.prod.outlook.com (2603:10a6:102:272::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.13; Tue, 9 Sep
 2025 02:16:40 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 02:16:39 +0000
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
Subject: RE: [PATCH v6 net-next 3/6] net: fec: update MAX_FL based on the
 current MTU
Thread-Topic: [PATCH v6 net-next 3/6] net: fec: update MAX_FL based on the
 current MTU
Thread-Index: AQHcINxDKDdiJLN/pUy7KgY02sREIbSKHZww
Date: Tue, 9 Sep 2025 02:16:39 +0000
Message-ID:
 <PAXPR04MB8510347524AE294B0BEB67CE880FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250908161755.608704-1-shenwei.wang@nxp.com>
 <20250908161755.608704-4-shenwei.wang@nxp.com>
In-Reply-To: <20250908161755.608704-4-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB9637:EE_
x-ms-office365-filtering-correlation-id: 54efb9b2-0f5c-4022-eb5e-08ddef46e904
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|19092799006|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xBW/Ev3nMmrGKWPmgKFXapaSlomIsMm5xprEBYIwtGmUC6NVaN+enLrNoyMq?=
 =?us-ascii?Q?BmC+oO0Aiz2cF3iCY/mdePXgbbzUv59ttexmbfFQ64i1eWdFsdkHxhGmbLx5?=
 =?us-ascii?Q?jiWLLAdJhs7P8WGFozXgEEarANbQ4z5PLnbVyKsG27VKs/JBjCz3CLADeEgb?=
 =?us-ascii?Q?C8aShsv7U5I9QJkwF3+Euy4VTVXZt5BXWHAhQsPO9NrIl8ulYVQAWdBGHMCE?=
 =?us-ascii?Q?0ic9bsOxnOsagoafZlGj3Zp7NBHywCpXSD5bJoL5kt67+BrIGzFzO5AJTsaj?=
 =?us-ascii?Q?ueh5U13Rfus8gTOsYKFBjnVPLC3ODs9bm8nv20ELTAQ2/ElAH4p76P9YD1ii?=
 =?us-ascii?Q?M5FBL5EnIY5qjr2CSt09XIqPZ0zIgcKEKgWKs1qD/ND39et+meBfRpgLhjLS?=
 =?us-ascii?Q?Z194Zk+epjRScBOtouLl6YQx2HQOSd8trmbcrWFxmfCzur7sLmVLHMoCPr1/?=
 =?us-ascii?Q?1WyHhkzFgD0izpvw4QaaOiS42F15cVqnNwIHcYM+47QPwceieCwqFRDqrDue?=
 =?us-ascii?Q?OSPdxPdzMdBFCZrdnMqVPcTjyW1pZPIdqV4/6WWSqkQzpvAgEYCtXYO1Nq+V?=
 =?us-ascii?Q?hrTV5HZEdMmv0WpXoQfXwqtrHIaPcUNS9Ft+BcDUpj7XVbmtkxQXaSrEKWMa?=
 =?us-ascii?Q?6DWGfP98Mtxcx7jdYDiEFPzShH/bnozTTrzv4J1FssQen3+Gt6Z9lHj2FASh?=
 =?us-ascii?Q?J/YmV6YDOuLbzTLjOKmcm3tniIP6AxHyqAFe4/6zcy92Qxu9hqhXSbhVy0Zd?=
 =?us-ascii?Q?nQ5G3zAgVJvM4tM+aczDmh/aZvxE45aEisU2+JSMFMFp0CP2TVNIxxv4Q6KS?=
 =?us-ascii?Q?UvIXbXHFa3kDbh5oHQQn2R7XMGkYMSSWV3iuiZcPyi1H9rLTJ1QliFcLmPl7?=
 =?us-ascii?Q?5W3CBMXJ2EfLZCPbRc3MLqD6FA98p0+M3YzEOnVmBY2uK2GZuUBS2roFLd3G?=
 =?us-ascii?Q?mR6r3xfzjOz3HQGAb5k9SrkNoH6oamIf2h1ifq2WNZifL5fcWfyUTdBdkUY0?=
 =?us-ascii?Q?SqZTRJrV46Exd+9gsUJocmE8SGnGj7MLe81vW/FVA1a1ZRE8vO83rvvBYz2y?=
 =?us-ascii?Q?04iTUE8IHzhX1kQukFNVjeEc9vZXM+NmeIHHRgo/sfM8gXwVN8VLbOa7QoBL?=
 =?us-ascii?Q?SvSeJZOZP5K61UJe0vF6/udiCSv4qUrrUZCe4tbLYO9eIiO4e5gcnVgQfQ9j?=
 =?us-ascii?Q?lrYUZFa4jUVBkEwhEVmDvGWfR6i+KDGSexcDRYgYmh4jn6Mz6fvyhL4hlZ99?=
 =?us-ascii?Q?PZzbEFpiXWi4YoQWky7EEmb9nnJle+Dnn2J1nEoC10JaxdjDZ3/24IYAdjfZ?=
 =?us-ascii?Q?DRr1w3FgR6NRgRRCbbTKYYb7/Nr0i1yYkcVV4LjPBO5UhWXDBneEu6W/YXxK?=
 =?us-ascii?Q?F9ZR42SumJ1b4ZyxrzOnhzY4LxXBTs2oOZBOqUurfWYLyFSLQzSSX5b3fvFY?=
 =?us-ascii?Q?yJDni85u7u924Cv/wWtDAj3hZcx+PNuzXNw6Wa1DKFduqKC81Q1EtBZbmvH6?=
 =?us-ascii?Q?A3dcrX2PszkTG/o=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(19092799006)(366016)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?TPY2NGguwKL0/ZKps7AH3fNp3/Aq6s3mFZIO+DOsMW1RCAVm6zvUGxgH/gKu?=
 =?us-ascii?Q?SmppOmdv/NYm+EbUS08AWaFuGVQEFYvPReRcwAj5JAxNtxrDLPxs2bZKxc84?=
 =?us-ascii?Q?rhyBUXoA3e82r8U2gbn8Y0Rik+vnUp5Wq45OAsRf0FGhJ51YVmEw/ia8O97k?=
 =?us-ascii?Q?pQXHcJ2IoBnKUUz0i+h3y2cVnXqLJUFFqLL4cPgv3osicD70RIfAP7LuxiSy?=
 =?us-ascii?Q?liV34YREQ5tqn+lrHz3W4EYgyye02p48zDx3xwxN3kyM4fAJ06IKo7B/TCnn?=
 =?us-ascii?Q?AIhqt9GcuuNd0Cvz3wnPDfZQoDVtIgaHs3/NRhqUX3aqARlMMiU4f0ZvUWS5?=
 =?us-ascii?Q?/GSgYNX/5/WrhmWSckbYOsbwLfSnLoGjHnChJbwvDGKxBWY3eqjcn1keqA/E?=
 =?us-ascii?Q?HvCm0b+PjQbYNHxr001NKl1ZJiHuW47F2SdCKPYy7GjVdBM+6ljbydXyEqS9?=
 =?us-ascii?Q?LY5xGwCrH6hmRwR/wYFKDgCjkn/u9VKO8BHbJdlK1U6Yc11J9Tcrgsnea9zV?=
 =?us-ascii?Q?b1QfyRoRPjKbzxdP8S7x0Vg8VfvNcKv7cSmIj1Xm3Gx4n+o5HODM2dVZc9jq?=
 =?us-ascii?Q?wOxkOvTr+o8GkSq4BMScSYm0Wpg8mdCwnsMTE427Z+/VDeDJzwKackO0Ch7K?=
 =?us-ascii?Q?KSzJjqS044zyFL0dAJYeB97rZU/mUn8W4ZVIPgxsyjL8EMLn/S39doQoj7ka?=
 =?us-ascii?Q?5js50QX6JAGTst9vdc55ZEZp0TV6MBBrxYiYcmOK7RvchZt+kut4xtk9DIw8?=
 =?us-ascii?Q?BSAZ7S6a9iO24vb5mw83uR8EqPibwRaXP5CcowI/1JTPfrjsxM7LKb27+e4y?=
 =?us-ascii?Q?TQQGEu5RmKgZ3NTmuxRJpCxCi7mQ/ukFeKfBWcLjpblkp+Vk8pxUherJllIV?=
 =?us-ascii?Q?1P2SMrj6omsft/v1wfYPT1XkRSJ0gDAEnTPvz6j+Z7Uop3MgsS9UcyoWuNKw?=
 =?us-ascii?Q?b01pfh+fPbLw2MZwYXk8+pZDZXwoONiggc3wS5UMHbkntTQZl56Rq2xxFcw4?=
 =?us-ascii?Q?R/dEzvR7DHsLiDMG+OT2a7fKoHE9tJKcyWd1cBgPAPEpJfi+q8l5QJZNREpJ?=
 =?us-ascii?Q?T1DlkfljyBJkPFzp2ScJ2ujB9Z4n02MPb15vE7usg2G3ggrZy4b8pi7NBRX3?=
 =?us-ascii?Q?3rKb01r+sona1C5xIoxy2iVAZHSbqZWNqmhgWZHPXow9oTkFL2tg/wEs6gml?=
 =?us-ascii?Q?Cl/sYKYWvihE0OugAbCJa4Ez0Dcg2oKlOa/zU/xk/j+h+1eS/+ryCfZjeMdx?=
 =?us-ascii?Q?5wd4+FDz2X5GkCiXUO5Qsd48b82TIobVubIxcBZbX3zJQLlfSwBFb5qjU8b1?=
 =?us-ascii?Q?ZjaM6mTOYNR+Hkt5W8inY21oobGHm5lsKs+BaIYjVxnR4IYVY/JVDoKy7Bpe?=
 =?us-ascii?Q?VmtwKyHoKEqtuES0aTQVpVy/qjHMu88Zw1e7dXkviu3cBYtEXzhmoU+4sW+9?=
 =?us-ascii?Q?PzqTpEdWnkj/hg1IhRzv7dvL8+a8ZWHKICC6PL0/sZGMaZe1DsJCWBhDVbsg?=
 =?us-ascii?Q?aQRUc9OkdIFcOchXLHYY/zoV67UbWua6fvMtDSbXsxtLTTkN5IOKmuJCrNWx?=
 =?us-ascii?Q?q5iG3CQh0W0GE83zTFw=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 54efb9b2-0f5c-4022-eb5e-08ddef46e904
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 02:16:39.2240
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: YbbTBH1LZb3V+cuqOlQskk2SrOl+71jq96Ni8QHrq/r/MtgFATW4Y5SCEn27Yn+PAhexTR6yLnR6zhrfvghnMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB9637

> Configure the MAX_FL (Maximum Frame Length) register according to the
> current MTU value, which ensures that packets exceeding the configured MT=
U
> trigger an RX error.
>=20
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 642e19187128..5b71c4cf86bc 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1147,9 +1147,8 @@ fec_restart(struct net_device *ndev)
>  	u32 ecntl =3D FEC_ECR_ETHEREN;
>=20
>  #ifdef OPT_ARCH_HAS_MAX_FL
> -	rcntl |=3D fep->max_buf_size << 16;
> +	rcntl |=3D (fep->netdev->mtu + ETH_HLEN + ETH_FCS_LEN) << 16;
>  #endif
> -
>  	if (fep->bufdesc_ex)
>  		fec_ptp_save_state(fep);
>=20
> --
> 2.43.0

Reviewed-by: Wei Fang <wei.fang@nxp.com>



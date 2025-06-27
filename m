Return-Path: <netdev+bounces-201724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2D7AEAC54
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 03:30:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 328213B69C7
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 01:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC14270830;
	Fri, 27 Jun 2025 01:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="lH2Hx7sa"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010045.outbound.protection.outlook.com [52.101.84.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C261362;
	Fri, 27 Jun 2025 01:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750987837; cv=fail; b=eNWVowrf81pJAQEPG1Woh4zHYIN0iTUQQJ+TkFeiCvBg3EP0cfV/tQetSrlMRHOEj9Oc2I7IXrKMHQMyH0ji0wrdfr2kIMRwZEz9RntC8ZTOgwZHW65p6+uZeuUsk98m3+/IFL5y5pw9lZ/TuXrfNwEtyQ1S/Q+qTanbcucUTm4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750987837; c=relaxed/simple;
	bh=mb8Li7QREfeGv4sQhmdUieiXcxnmTMKrx+doyf5GVAE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BAUeQljTuEdR6aHCjK0i2tGot45GzxKXWN/269n1lI152Z15rIaUEbG8q6EzzgxtuuMjbvv36dqY1/T0Yx8dm7Lc1qTGtc3eeXwmpuFNb15aOrBJL1Am6jKRXJxV9K7wQBa19CNS0Xu94uulV7d6VjW58/0av9FS39Bo/QDkp/c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=lH2Hx7sa; arc=fail smtp.client-ip=52.101.84.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T7cwgDi7sgqI5lOPbUm3T41EaKadk6MXVDdiav8CRUcxC0b2ossefL1ERfN/T6VuRmFaVx1ozLRhh5PmylLdjF27LDN2EP1feDaqPfVEOE9WICcCNj2YfFAHSs/79lz9ss0EEGf35C2ts9tee2QY3R9EvwMr0nE2S9HJLb99C0NG8zD0NzFqTem+jjxoNQ+ij3gNmvrUoHvEujzH3/vUWOKMoAiep1zSeWE/x7BpAwrEx/8Z+fJZ8pUyKjwOhLlY9xk7BBg7gaMJ22TTIzY3yZyrGTqGO1Le+C+XjvVt3TR9Fs9r85g/Qjkxceu8fPyPOWOEYgRbHog5yb1bM9TxMw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dMaqF90mptQL99lKn96x8P+KuyEz7Cwn4SEkGYOnYrM=;
 b=Km5ro3b/lvkrVRqS8QOM7G1OsE1C52vn5k+POkonKAznpN49iU93suPPbQt/w6nRaMNM1OEjL8w5SbHTeIs5E1nS8jUNdp7Wck/Bp6+4j1TIcMen3tWG1pf8HwuFzsVdUnI+XCjbgzKeKjWjnJQ0aSBMn0pDa4O9daP3i1ErXDnBOquSpCZardLUt5Hjce8tpcIgkZe7H8NbmCDLefHEbG7XXKUQU64HSaifvkjM6ua2qjVGqTpF2UHDMeNYaggeRUOptKmZGnDrpyOvhu4rBz115LCH6QLEPeDaS8gY7xABi06/bA/szoLR/tcRaanyUzjEMv/dlaCfNtsga1D8Eg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dMaqF90mptQL99lKn96x8P+KuyEz7Cwn4SEkGYOnYrM=;
 b=lH2Hx7sam4j2AevQnJjfTadgs6EXI0N7gSta+DQKfrJ43ZNFMnYCWT1VrfNncPh2NhaVgHgk/6d/vEAqmIbudEOn6Aw30/FHMbBeNkr/1ryMPSo++eeDiw4CE80iMGDbxJ+38EL9LLWBLIcIhXOWfc2Tvt2GEap3CRYn3+xi55360XnQIOtIBTwVoPbewn7m4ajuoKULAIiGqbr67Z371fyxhG8AurJ3Yl+FLNtr55pb7VFT3y3/Uz+Ky3sZXDdjsMF9xfyBkLAiP0siuO4c97x9KPVA1YHgSSrNVw5wKK3U54aDt4hgr70Q56uem/PNG3Ipx7f7xpcn+hUMAQhihg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI2PR04MB10980.eurprd04.prod.outlook.com (2603:10a6:800:274::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Fri, 27 Jun
 2025 01:30:30 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8880.021; Fri, 27 Jun 2025
 01:30:30 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jonas Rebmann <jre@pengutronix.de>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH v2] net: fec: allow disable coalescing
Thread-Topic: [PATCH v2] net: fec: allow disable coalescing
Thread-Index: AQHb5qBneT3oXAH8kkyMvXOKyZ8cELQWOLLQ
Date: Fri, 27 Jun 2025 01:30:30 +0000
Message-ID:
 <PAXPR04MB8510ACEEA236D77E6E59A4068845A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References:
 <20250626-fec_deactivate_coalescing-v2-1-0b217f2e80da@pengutronix.de>
In-Reply-To:
 <20250626-fec_deactivate_coalescing-v2-1-0b217f2e80da@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI2PR04MB10980:EE_
x-ms-office365-filtering-correlation-id: e3436384-ac8a-4543-3249-08ddb51a340c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Z+YzKdIqNms4wFeTqX3C7u/MdA7ES+6IGy3m4ZKVgX89MmALyV8jeT9zPirc?=
 =?us-ascii?Q?s7tYQFFIAdiCGCdQJ/tbJ7YXNABAk4N/GtmZDJO/m5shKc3Y7c1uGCN0atN0?=
 =?us-ascii?Q?LiNWlZwL7r7unGch3ju0toYl7uhTVBvfmx0ZSSg0kXqb48Rz05EoiiZi3ORE?=
 =?us-ascii?Q?nA0g5rV7qyHCkX5vd1YGE9tc5QNAw9fI1yhJokxEeOk53KxGndmIJMTtC+Oc?=
 =?us-ascii?Q?V6otGv3clmfcI9p/uXPa+eeIXBdV4RknrjEVE6PbffibsTmjNa+tO+pFshS8?=
 =?us-ascii?Q?M8UBHPPqD/XbBvqeUyqmGquxl3Wtpe+xoZIXq5KQfpZf7KqcWketaVxUAg6l?=
 =?us-ascii?Q?nZ6CTvbRHk+5yjp2fTcEgZ35CUNj4Ehch080+1e6NYMSqDjaUTaHe2LSHoA4?=
 =?us-ascii?Q?X6PTLlSK2JeFNTZiw+rAqvSB5UWAYrQAgZWGMdfre28PyeXFTmi6sgHxJl7y?=
 =?us-ascii?Q?3fSRwOaBxX2OS3hkNecjX+kfOSPqkrnmXVQzHk1bStyUgKGcoBV+tq8nFxws?=
 =?us-ascii?Q?ILXL8H+cJGtp/3gxEDYO9vyBctaXsIFX0nD5QIn+UEJHHYerYPr3rfpXbVMi?=
 =?us-ascii?Q?Bh8nSa56XOhKQVHhiqKseWESUSEzq3xnUEgumyjN3wiOs61YpgS+G6zoCiUJ?=
 =?us-ascii?Q?0JB8AXx9eTTDtB9vSAcDKvps8OrrBCOb7gjahDQCwjTruntMpDQSl3XBAvt6?=
 =?us-ascii?Q?9fNQBEMUy0rUzDzciP/D0x3Pl8G+8H55ciCE3kDWgR+c/Tgo3QuDsyZoLsgw?=
 =?us-ascii?Q?nkr440vB3P5IkjHCk0hbV9rjePlhuyu1EBLFoHBTAtzfNEvIS7H9fVNVqDaC?=
 =?us-ascii?Q?B6krBXgNKz4HK7276EAqMUrNXthCedZfrYOQUoiy1amcx8Dm6HBQojTWriiA?=
 =?us-ascii?Q?6bZkOz/gs9nMXxNh+oYjhmhFa/P5cf4jqspGrspqNDnexzILhRBCj/VOf0hR?=
 =?us-ascii?Q?Ml4XU1y99k7vZ868Kebyfl9b6lt8haoe/QtS8yTFdtJM0PSfWFa/hsBLzWDy?=
 =?us-ascii?Q?TRYlHE4l+7N4N0wG2KX2hrITs6K1nsoyKQ0k/pbc1XYuhqQaHkGer6msDG9e?=
 =?us-ascii?Q?0JVJExeGKcH7MStMOK1GpZJ9RBmWl9+RsbTXp0XLJQqEsTN+f7GGBksxLUnT?=
 =?us-ascii?Q?c/T+Kz7ACPwWtPmP6R7ke/GTQqzxcDWKvF5AT33DVW3ZHskJYqnom4N6Rz3p?=
 =?us-ascii?Q?w5DeV9aNIB/hZxEnYtodJXzE1vkjugU9CTWCoqN+mVlSokoqKn2fdQkSFLSJ?=
 =?us-ascii?Q?T8fcyu3ckKzrrkbd3OvfQAsb2OwURpLLG12pTxa8bmhSIuQ5m6T2qFXh8+NJ?=
 =?us-ascii?Q?En8JVQbawE9onUg7PQkQByYi3KbGVkE8DFmiUfSqOLkjSVPH7N4fMgUtIAV6?=
 =?us-ascii?Q?43F92xPVal9xJIE81dz7U4lWDeSxZpH84/0bE0kRIDDaXqbuNNlMOay+bg6v?=
 =?us-ascii?Q?0a1izGibgTY=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?u2XhQufVAvZvjgYhrPWaNTJDJespLjSJrtddZd8/urP8Al70VP+VX3iZIzbE?=
 =?us-ascii?Q?kQ9SFyRORbtcHtC/7Zo/k/UEea26IPkHgUmvr6WYLjF7Fbj0mcVCArjrczrq?=
 =?us-ascii?Q?IDXeFU9I8nDt3TVQttnpkjpib3eEYwo3oI2unHC8JsVrHr72nIIZELnz3CK2?=
 =?us-ascii?Q?8ZUK7OKNTCMsVvfAKUpd/V9Fya8w+AlpTVzwSJxrhnfuYsykfH/oBMSdpeQY?=
 =?us-ascii?Q?rNoWIW+w8SVlRjH7UctiJ4LxttXk9fU+TSJuMWqmOUurSd/gh8dJ4Nk+vpih?=
 =?us-ascii?Q?XBBYNwUfNF3nAKd3rTmEHkmPUdKNPKLTJk0tVvP6JIfarQmoIl4yAhanBxIp?=
 =?us-ascii?Q?dE/oOq/Fp43QTeJcQz8Zis7K5MXGHg6p5Hot+liPQijMwSy+mjl72QgVACbR?=
 =?us-ascii?Q?xADzFpZfOBndQOPDrO+JMUpmwLX48KCflbiycr9+TwKUDgc/IrYcKIByrhOO?=
 =?us-ascii?Q?qxvS3oOzKVB7GYRa8SLwO0mlxYRGYawgx++5mkZtC2dRsHT/OkfpuQBJGsev?=
 =?us-ascii?Q?Zie98EzopQsfrMsHPBtOFsDMaLuwTVL2Qu9Qoj5crebpuLh9jQBzNZvg3ZXf?=
 =?us-ascii?Q?m5XtNCEHLRMvyMI8Ph/i6ppb6iEfmI6GVhWw50o3oOpWqJFBeIIzqvEvBigH?=
 =?us-ascii?Q?pW1z1GbRdpfKF8LVAlDO+iwQzfpS+jfVhkvCqRzX/IDqPvQ1zhVQ64VDWDo0?=
 =?us-ascii?Q?ycHuRJ+0to0AM4LIwR+K5FizWopJlz+c6HgnE4A5B4mVA8RSpAWcLFaacggy?=
 =?us-ascii?Q?bxbRIjGqvziLZR/goAzHxB6ddv3uV+V1yj8b9FiqOg3OJqkIAVwuHNbEz0QN?=
 =?us-ascii?Q?kH/Y4VWoaNPr3MEczoLBiJq6YdX+SFdGZJabTCEOFMxqRwiCaFyWWKqFDPfM?=
 =?us-ascii?Q?N0tPO66flxRc6EgQHIEqUW2r3j9UxZGOW1yihHY5Ph24c2JYPhi6yJuV1hB1?=
 =?us-ascii?Q?Dp//CD/zwQOWgQkUr99EqFN/e0lace9gZQwlqUsgbSl7uO49Z0XuksoXl9FE?=
 =?us-ascii?Q?8XjyBzilamRwzA8BDr16abIdSiaHgJUd3RQ1+Msc/j+PU5PUthCVEjUq7QV6?=
 =?us-ascii?Q?5japkUq9KubmLORkNrzMzrNPIUZ5hLjujv4mLUK25iIh1tO72hoUJGc6bJYc?=
 =?us-ascii?Q?I6onMGhkoDrgLEjz3ew9ZrRP0QQ2F8egRn0VH7iycVADoe6hdkJCOvuUvnq/?=
 =?us-ascii?Q?AmNjB2/0Nw33P+VybtdT8we046lYm4RqbjdzI32iI5tbjpgbAth5noIskSIR?=
 =?us-ascii?Q?OvWIIHKBlTQ+aYkISj1uHLlU+wpruvwa+WUMsBCQfH6O9D+EJjBRchBFMflB?=
 =?us-ascii?Q?mdzCk7aJ3y7G+Q8nE6knv0qKoYLdTBgMx8ZUPj3igjo77xi8a6Z8NYTiCeLv?=
 =?us-ascii?Q?vipDODIHMCmGZ7TsmBRlbN84OEJ49Zgx6cXK3yXPIkh0RZN236/Jisf8M2xe?=
 =?us-ascii?Q?LEzodZjv8ks9o47JywD5muPg3LNj/hKxXHbixHcC46zOUKhOzddO+32tqHi0?=
 =?us-ascii?Q?OJmjdVJRHUfcj+KJPcfogFbItPkFAAyqFUx4eI19qyJ3efE8rEA3DgWYkLmy?=
 =?us-ascii?Q?L+du+iIqkbH0mYIQeFg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e3436384-ac8a-4543-3249-08ddb51a340c
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jun 2025 01:30:30.3231
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: f9G4V7v4bQcysWF5h0sDVu2adPZ116s3wrrum43bxHMmA8CHKKJVQniT2/plNW2dHaDFJOwosevkdiZhdTUjTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10980

> In the current implementation, IP coalescing is always enabled and
> cannot be disabled.
>
> As setting maximum frames to 0 or 1, or setting delay to zero implies
> immediate delivery of single packets/IRQs, disable coalescing in
> hardware in these cases.
>
> This also guarantees that coalescing is never enabled with ICFT or ICTT
> set to zero, a configuration that could lead to unpredictable behaviour
> according to i.MX8MP reference manual.
>
> Signed-off-by: Jonas Rebmann <jre@pengutronix.de>
> ---
> Changes in v2:
> - Adjust type of rx_itr, tx_itr (Thanks, Wei)
> - Set multiple FEC_ITR_ flags in one line for more compact code (Thanks, =
Wei)
> - Commit Message: mention ICFT/CTT fields constraints (Thanks, Andrew)
> - Link to v1:
> https://lore.kern/
> el.org%2Fr%2F20250625-fec_deactivate_coalescing-v1-1-57a1e41a45d3%40pe
> ngutronix.de&data=3D05%7C02%7Cwei.fang%40nxp.com%7C49dd91b2cd334451
> 91a608ddb4b78819%7C686ea1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C6
> 38865422543116485%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRy
> dWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D
> %3D%7C0%7C%7C%7C&sdata=3Dt0upws9HvxuIzBe5INmHspMnBpZ4%2B61hZAG
> pfikHb74%3D&reserved=3D0
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 34 +++++++++++++++----------=
------
>  1 file changed, 16 insertions(+), 18 deletions(-)
>
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index
> 63dac42720453a8b8a847bdd1eec76ac072030bf..d4eed252ad4098a7962f615b
> ce98338bc3d12f5c 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -3121,27 +3121,25 @@ static int fec_enet_us_to_itr_clock(struct
> net_device *ndev, int us)
>  static void fec_enet_itr_coal_set(struct net_device *ndev)
>  {
>       struct fec_enet_private *fep =3D netdev_priv(ndev);
> -     int rx_itr, tx_itr;
> +     u32 rx_itr =3D 0, tx_itr =3D 0;
> +     int rx_ictt, tx_ictt;
>
> -     /* Must be greater than zero to avoid unpredictable behavior */
> -     if (!fep->rx_time_itr || !fep->rx_pkts_itr ||
> -         !fep->tx_time_itr || !fep->tx_pkts_itr)
> -             return;
> -
> -     /* Select enet system clock as Interrupt Coalescing
> -      * timer Clock Source
> -      */
> -     rx_itr =3D FEC_ITR_CLK_SEL;
> -     tx_itr =3D FEC_ITR_CLK_SEL;
> +     rx_ictt =3D fec_enet_us_to_itr_clock(ndev, fep->rx_time_itr);
> +     tx_ictt =3D fec_enet_us_to_itr_clock(ndev, fep->tx_time_itr);
>
> -     /* set ICFT and ICTT */
> -     rx_itr |=3D FEC_ITR_ICFT(fep->rx_pkts_itr);
> -     rx_itr |=3D FEC_ITR_ICTT(fec_enet_us_to_itr_clock(ndev, fep->rx_tim=
e_itr));
> -     tx_itr |=3D FEC_ITR_ICFT(fep->tx_pkts_itr);
> -     tx_itr |=3D FEC_ITR_ICTT(fec_enet_us_to_itr_clock(ndev, fep->tx_tim=
e_itr));
> +     if (rx_ictt > 0 && fep->rx_pkts_itr > 1) {
> +             /* Enable with enet system clock as Interrupt Coalescing ti=
mer Clock
> Source */
> +             rx_itr =3D FEC_ITR_EN | FEC_ITR_CLK_SEL;
> +             rx_itr |=3D FEC_ITR_ICFT(fep->rx_pkts_itr);
> +             rx_itr |=3D FEC_ITR_ICTT(rx_ictt);
> +     }
>
> -     rx_itr |=3D FEC_ITR_EN;
> -     tx_itr |=3D FEC_ITR_EN;
> +     if (tx_ictt > 0 && fep->tx_pkts_itr > 1) {
> +             /* Enable with enet system clock as Interrupt Coalescing ti=
mer Clock
> Source */
> +             tx_itr =3D FEC_ITR_EN | FEC_ITR_CLK_SEL;
> +             tx_itr |=3D FEC_ITR_ICFT(fep->tx_pkts_itr);
> +             tx_itr |=3D FEC_ITR_ICTT(tx_ictt);
> +     }
>
>       writel(tx_itr, fep->hwp + FEC_TXIC0);
>       writel(rx_itr, fep->hwp + FEC_RXIC0);
>
> ---

Reviewed-by: Wei Fang <wei.fang@nxp.com>



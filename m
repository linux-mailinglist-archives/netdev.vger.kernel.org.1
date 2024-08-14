Return-Path: <netdev+bounces-118635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 24FF495253F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 00:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3FE1282CE1
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 22:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5CC21474D7;
	Wed, 14 Aug 2024 22:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="fcDXVzGH"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2070.outbound.protection.outlook.com [40.107.249.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECB160B96;
	Wed, 14 Aug 2024 22:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723673355; cv=fail; b=sr9GxwDxStn8Uz7Pf+HUWpFjWa4CapSyyvUVuZZhaN6GyvI03YP5TQ6na6qTIg7n2pXNvXPZ5DcQXij1MbP1dURajrDV9NARBfAdg0X7d9FqejVJhq/63RmqwEm0GHR04amOnjRvuMFTqpPqT0et+Sic2ORkeu6NR9SsnKWbZrI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723673355; c=relaxed/simple;
	bh=wHU7NSI9v4vY9e3t251QYEPPJNc0i0NdkAdgx3dW5UQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IB054wQnzZxSogrxuRjTUAWhCMoCdp1gzad7pmdN0Ki2f9PsFidMJrFwZ8v8BvcYtAmj34IpXDBhX26UjKA/uYhrP0jilYeOtkpJYau1Fa0Mq90pqILRIwp61lXdHIg4GbsR7BfWkREy8tvaaNPl6EPqWK5eU/cbewYk18zudHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=fcDXVzGH; arc=fail smtp.client-ip=40.107.249.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eqCLSpgUOe0OT7RTFCDvAKhhgI2uCsLMa8GHE22R4yDeD6dca+oWSGCRzZzq/g3oZwgacsqZLYzog103NCO4Mk6JkKvCDjjXp06AKEhKy1Sv496KRbnhonC3rSuci4Ja4dHbelTLqGDexncCYdHBHBV0xsfVAdzExQ0djzN0oQrQsLXsNk+lzT4NAZsPXUNN77eTwM1tPFVuni6+LStyZMTJohEVtFvR5XVuaehFMsefqNaS7w8n+bEmQWrLov1fZpjklcQ07Bf9hMeW5eGZ5JZD2Yxmc1N06LHgW/k7jOFqBsl4C+zveC8T5i+7o/jjvg/VkCdNoE0tDwk/YSsMVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BtFLbOnKLT3hu4BPolgkLjacxFuR28nKcaSOslyEhe8=;
 b=CDp/dVQY2b9zzVg3jiiRkO2PDarklnrueKRqMi76yDAktdLkK1sWUA7EB0ZSI3o+XS9CUv+y7Deh2F5sY98wvWoSPeAVo3VBOzBESHg5xLjG5HuvPqSt7zZw1Sh2+W/GuBfJQFLE4hbnLV+6YiRBK6niELe6mlnz0GZ4DHRerNj211evQdNNMgYXicvItqChcelUNTdSlxorY+5TehzSytbKOFCVzAUPv58mnfRfQ3m7Mv/Hriy2Fz2RmxVL3Yr+3SORJZYPwKpRrb69/OoRY6p0iP0RjwnaF1Y4hKgy9IW1v5PCYucMs/0dVyxepUtK2LHWBxKBcFEdx4RFYRLcCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BtFLbOnKLT3hu4BPolgkLjacxFuR28nKcaSOslyEhe8=;
 b=fcDXVzGHVKVqRuzoF2Vk0d+/6HVCr26oXa+l+tK8vftazGxitxD6IwaH40G6dJYvQm/5wVkXwf/AsI6YoqGmrCRM/rOQy6ZrWilPrmitgOnXEy2kS+Q77veqcf4LBlJqGhACQO8M1G+MXE/0zPLxroxKbPZWVUJsP8+RuFF7hsY=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by GV2P189MB2429.EURP189.PROD.OUTLOOK.COM (2603:10a6:150:d2::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7849.20; Wed, 14 Aug
 2024 22:09:07 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.7849.021; Wed, 14 Aug 2024
 22:09:06 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: Oleksij Rempel <o.rempel@pengutronix.de>
CC: Kory Maincent <kory.maincent@bootlin.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Andrew Lunn
	<andrew@lunn.ch>, "kernel@pengutronix.de" <kernel@pengutronix.de>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: Re: [PATCH net v1] pse-core: Conditionally set current limit during
 PI regulator registration
Thread-Topic: [PATCH net v1] pse-core: Conditionally set current limit during
 PI regulator registration
Thread-Index: AQHa7VO98gSpx9TQMU2uTRtF5dImDLInUnqA
Date: Wed, 14 Aug 2024 22:09:06 +0000
Message-ID: <Zr0q6HGW4wSBIUWz@p620>
References: <20240813073719.2304633-1-o.rempel@pengutronix.de>
In-Reply-To: <20240813073719.2304633-1-o.rempel@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|GV2P189MB2429:EE_
x-ms-office365-filtering-correlation-id: 87f117e4-71e9-48fd-71fb-08dcbcadb71c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mjX5nqf5IYaJnWMv4z2uECbdzTTZa9cwNtXmFQhcRxnIHXVzZLRpgCafGPLa?=
 =?us-ascii?Q?roFtH84bX4fqKFYLCzDtoi2qzNSPoIpsxpDr1p/zbr1rDq1y6yLkklclCtER?=
 =?us-ascii?Q?dV7lOy1p4vgJ1e39E7BSDIGwmcNzmH1SaMkgAWfKPicZ6F2cAunmLhxLut2W?=
 =?us-ascii?Q?ySIcqIJ6YczSGdI8WAjxzolF5qLBxdVBOjItnXqVuEMDe/uLAp3smAFYUHX2?=
 =?us-ascii?Q?pmH7nRG7yTzAAwHbX96S2IVg3XxjW+LPWXg9o88kdWTQPTm8APupPfR5zUKC?=
 =?us-ascii?Q?OLKet4GoAIDO4Y1fPnvn1+xJkklM8k+yJSHijHGdSO0ONed4thoXIahuSy/g?=
 =?us-ascii?Q?inBikrc+drhXON4bPUdytmAmEs7y9HN2rDXcHnEhMh/NlyszCkYCZGBOrP+W?=
 =?us-ascii?Q?3DM5nYXuCNV668bwRfXH/2iHyoc117AH6V2ZqS06vkqrKrmt8MmCjoRqf+vg?=
 =?us-ascii?Q?0YVDkO4I5KZwYgzgyfdLVcN3eoRcK6739aWirmlkp3vEqYbHrXhJ1Ga3+/D3?=
 =?us-ascii?Q?fjIGVVXXanQAyI1B/Fr3Se+/ELjHT65NymH7KwVX4Oj4YVIrrzUyUersBS5l?=
 =?us-ascii?Q?78WO7I40uQ9LgKxdJuu2C56jmvHe2nVuzRca1LvZARfqfao04uDtiEaaZQFt?=
 =?us-ascii?Q?8pyUzLqJUFl+TNJ+EOf90ivWjp4xoXovDEAR+7DLS4wVvkswdUwCy9+hkOx/?=
 =?us-ascii?Q?vg8EpGruoHW4054ekaeq+ps/cGK3iEUNss5i7/ehcv/DHI0aiEAt87oO3JZd?=
 =?us-ascii?Q?wQNMe0BRJhiNqdDrAZFYf108Z3KH6XWVVOYSz0e0EVWWe8TRQhDFiMMyoaxu?=
 =?us-ascii?Q?/RVaOumsF/6B7w51QvLpVxFnoB0stIMKJW88gKbS65KfO37KmxbvOFGg2L+C?=
 =?us-ascii?Q?+Ewbh7KFD5SNjOx5bkWTPLpLDI+gwfuQglwYgRy4JuSeNbzZeNZ9yvTv/53e?=
 =?us-ascii?Q?h3sCRozwtNxg3f7R0fbm/gu6klxnp8WE4Dq456RRjD+3Ldk6Ew+iCj851B83?=
 =?us-ascii?Q?K2dWW2H7Q2ocDJPob9NEC94wRIWO3Pzf8Xy68yiyvxDWpQQ/ltjXjNvnhF88?=
 =?us-ascii?Q?QizHDnPLPpIlN0ZB5PGuISDlkCjdahNAl/jePPx3bvFgKw6OfnZC0jUvVpSV?=
 =?us-ascii?Q?uLJzHsY27tJV9BLErM9xOdhVF8DDUW2HtwQ6tMDLYlEIlDvnhEjEc3M2BF5m?=
 =?us-ascii?Q?MNIO/2syOheRkDTMv+Ka4qZD8Xt9lF3r82glBoq3cLhyt4BdcTxM+CrTtJUu?=
 =?us-ascii?Q?gY+byQMrkCYQUBXEdZnKjolQW4L7eiiKp/drng4PrTTz4qo2NBDkpTxhuXcJ?=
 =?us-ascii?Q?v2xOQtCgZl3WQzFLjhpjVM6YoZYVCekperjtKWJqI5qfS+iZ0Zb4PbieuVWZ?=
 =?us-ascii?Q?B0FqVBjXspnl+Wi/Cw9LArxm8U1yMTfY6IHI8IBWckjQMJsDgQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iI91PjRb/PuiXUxs9/LMDg3b8wrFKGf4GPYuHKvJbWam+c6zodKgGZynZ67I?=
 =?us-ascii?Q?hQIJ3CsyuSv11eCskDbtO9+ScawTYj5D0nMf3Muu5sps1kJTg0a2uAboTvaI?=
 =?us-ascii?Q?bJTfctX1f13g9aeL7gvPokMsS1caZnpYez9JVrQVkz9Vqmv/KEN6nwQi//WO?=
 =?us-ascii?Q?0IPvMVjc4cTFmZmwr8b6mU4GjUEpOIuTp8P90WdfYNvrLZvNbpzRggm1VdPO?=
 =?us-ascii?Q?2V1dDvE3yCowqwpCdX8aaR+qAxpDa5GloGl5p+ZOCALzlDeVTjiUPmm+bssm?=
 =?us-ascii?Q?eyG/5cycXBA2QWLEZ3HHEOOY5y+he2cLLjL3hTz2WsReybER1qDEglksctb+?=
 =?us-ascii?Q?bm17Fme3ugBBamOKwpiM66uZ5kE0QAEFcW+Z0CvtqhKvXg7W6gq2L/XdRgkQ?=
 =?us-ascii?Q?vCwW8kNfJy221pohHuiTGy34CrfsVgzf2BWCXZsirY4WYHw2CUuqvpS+1VLb?=
 =?us-ascii?Q?VUYCSLo83NQ1wFki+M9B8/WjjHXjoDnFc/8EPB0/c6YijAC+7F2g6gIg1ini?=
 =?us-ascii?Q?wgHJw3yu4pjVXU8+T3FLbO046qWiIzPsR9Dx4eLJ9Rzq9+53Ws/Lu90Z2amF?=
 =?us-ascii?Q?QHlqd1oSHuo0LC8S52GUrksaJ5QduSPrJH5DWJAe9Lv/1ngAgPD8Wz4YTR8l?=
 =?us-ascii?Q?3538uD0xuGbV8hga5Zu43OoeXsofLMGRCadhmMoOPkVSxFY/Ut3MZBAOVqhG?=
 =?us-ascii?Q?Hg8lcalqxUfPgVY2aOpNrxxYRcuJnt9tdtnhd3nbrGHv6yT45mBdOQWRxzFe?=
 =?us-ascii?Q?+O3nZPETnpqyqdwLnXZhS5LJ782Efag1P259BdC0VEkTQUWnsINxw9YLMJJ9?=
 =?us-ascii?Q?oqY7B0S2+8b9ykfRcFsqpJKDGAWflOIr06qGnT9AbHVtojrpqRftTPvbbQiQ?=
 =?us-ascii?Q?G6qjkIX9Ucww3/oOtNF9rM0SpAZXd49R5filc3FhF1mIsBQJQBPxaOdwrAzs?=
 =?us-ascii?Q?sXnAPSRmLb6Cfy9mc0FbeTHNuqYpfkxtoLCQwlaaZcbA0q0u1EF6CQypz7iF?=
 =?us-ascii?Q?lMOXcKe3ee6BMZIOepsx0/StKJuhPSnoKDdLwiWPFOku3OAlVun+SixAcGXf?=
 =?us-ascii?Q?gBGSq+a9oQQC+GGiiQgVqgQdETOeoOOel9EUYKwR3KFz25yTSRMeq/Ol/YHM?=
 =?us-ascii?Q?yB/vP7VPxGYxW1EZ5pqbla/djVvY1l4Y73nMFJWRTh0spHijBE1YWylwBv1k?=
 =?us-ascii?Q?vou3q+cXgA+UrRmCc/dL39u5pWe3j1ANe0irvs8tgQ196U8RsOFw1z0bZP5r?=
 =?us-ascii?Q?Fe7iTng3GvL8yW1mQ353hKnbcPZo3edCUUpPjizxk3A7RCpXXGHNj7TXpoQ6?=
 =?us-ascii?Q?oTBNb+38EvzV5s3puDJdBb/0esmLn/WIk7GPU11Az95R7W+OQUQzhikEgXDM?=
 =?us-ascii?Q?ewSAwnal8bXIAXkPUsvCYrvHn1NA+Nk8WvKcTa/atNRbFNre0a/mC5C/iAoc?=
 =?us-ascii?Q?LNR+RqWSOaFqDPN2I/0lh7zpUcVr6DzS5H0trKQbsrVZw/425xjaG1QoIURu?=
 =?us-ascii?Q?+gpBe94+7Uc/MhActG19yQkE6XgZz8RDlhYdxeuy8ksuYGJmG/3Oy5VUNxVk?=
 =?us-ascii?Q?0ZjwHTINkU5y2cvdSkFQKVtCLcVl7CvULHQtgmNJ?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <9ADBF82B47EDFC4E90B3F88EC281CDE8@EURP189.PROD.OUTLOOK.COM>
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 87f117e4-71e9-48fd-71fb-08dcbcadb71c
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Aug 2024 22:09:06.6972
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7W5Fssv6BrhmOJOOrA+P01WYRBq3IuikUKhrNnL0NSxRqeWtkc+f2yhtl2aFnA4pDSncTlj2DPrjoT4Medx5Ag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2P189MB2429

On Tue, Aug 13, 2024 at 09:37:19AM +0200, Oleksij Rempel wrote:
> Fix an issue where `devm_regulator_register()` would fail for PSE
> controllers that do not support current limit control, such as simple
> GPIO-based controllers like the podl-pse-regulator. The
> `REGULATOR_CHANGE_CURRENT` flag and `max_uA` constraint are now
> conditionally set only if the `pi_set_current_limit` operation is
> supported. This change prevents the regulator registration routine from
> attempting to call `pse_pi_set_current_limit()`, which would return
> `-EOPNOTSUPP` and cause the registration to fail.
>=20
> Fixes: 4a83abcef5f4f ("net: pse-pd: Add new power limit get and set c33 f=
eatures")
> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
>  drivers/net/pse-pd/pse_core.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/net/pse-pd/pse_core.c b/drivers/net/pse-pd/pse_core.=
c
> index ec20953e0f825..4f032b16a8a0a 100644
> --- a/drivers/net/pse-pd/pse_core.c
> +++ b/drivers/net/pse-pd/pse_core.c
> @@ -401,9 +401,14 @@ devm_pse_pi_regulator_register(struct pse_controller=
_dev *pcdev,
>  	rdesc->ops =3D &pse_pi_ops;
>  	rdesc->owner =3D pcdev->owner;
>=20
> -	rinit_data->constraints.valid_ops_mask =3D REGULATOR_CHANGE_STATUS |
> -						 REGULATOR_CHANGE_CURRENT;
> -	rinit_data->constraints.max_uA =3D MAX_PI_CURRENT;
> +	rinit_data->constraints.valid_ops_mask =3D REGULATOR_CHANGE_STATUS;
> +
> +	if (pcdev->ops->pi_set_current_limit) {
> +		rinit_data->constraints.valid_ops_mask |=3D
> +			REGULATOR_CHANGE_CURRENT;
> +		rinit_data->constraints.max_uA =3D MAX_PI_CURRENT;
> +	}
> +
>  	rinit_data->supply_regulator =3D "vpwr";
>=20
>  	rconfig.dev =3D pcdev->dev;
> --
> 2.39.2

This patch solves the problem I was having with the regulator setup for
the tps23881 on my hardware.  Great timing, and thanks for the fix!

Tested-by: Kyle Swenson <kyle.swenson@est.tech>=


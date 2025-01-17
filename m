Return-Path: <netdev+bounces-159150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66249A1485B
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 03:47:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A711A1889A49
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 02:47:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3F561F561C;
	Fri, 17 Jan 2025 02:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XKbrcTVy"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2077.outbound.protection.outlook.com [40.107.247.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25A0A25A620;
	Fri, 17 Jan 2025 02:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737082059; cv=fail; b=LhdMXfd9Yp1ipROnoy8ORgjIX24KjZU+zAio+JTDuwPw8enuO2jrwlPRtACVPxlgceCaBrlBMWsHPVEiS0TNRZqku0eQUnHiXnQfR9/B9Xbz/Gy0PMBdiBNZ4VywTFAbuYaPcZH8Re8ljGohCpztOF3AQJHxsBYIaAmnhBjwt5M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737082059; c=relaxed/simple;
	bh=0wniKrhiqdvXAh8hDwMOzNRZ/13nophs1llAAizpK6g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Oi+QcRXI1E5b1EWdNFvzrenD9/Azfkq+BzmhXV1+T0V5T7vKyzhMiXBCTH1znVpwVD3QDDLZDlcd65b+VzjNZ91YFlW8KywRw449kfcs6iXiGTMUuuKHlis7EnWTUDEx6kbstBpiB7i4wgoF9BOaLK9rkgHAKT4+mAQU3z5YiKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XKbrcTVy; arc=fail smtp.client-ip=40.107.247.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A7xVHo6pvMpeDLbSUi6r9iC2NsjdrxA63G3RPamveZU3QNbwFugrwDSd6R1LPaCU6cW36xPx04YNhae6DY0rUAW0QQfqrn10fbHIDxhtmHMFc+3oJe7ZdyoZP7yblMqxIHeIu3CYWTLA4EuyIzYrZV9H0zdtJlw3CcaQ9sfO0NmWsTEXig5AzJdNO5BqGLvzdt/tCp6+mFwonpVOHjnMpIqdAJSxmYPpkw+soORDZaQpAGPcQ4+wKJWnWH1ATbHYdRQhgyEJWcWUlIFjm4xJ+J6ZQIJPBXxuAYGNarPTL2KosgnwyfllxO6MiUNu9RoBLZ7GU82e7hNKwBFNqFUbpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CWkZibYEgK+WvxNhLD6fIMFS9y3rR6raXhqZUu/LHbg=;
 b=dhLOVfAT5AQ9iAwAvgeCFlSeCGaoMUpgXSQXkaYi5So8Eho0WQcWZAV7HNdnoKl+ReOF8YiIQe/A2vwQBZD/iQkqdfL/FT2AeV/DuM7uuS2XB4uE111H/BiNX7QycmiWyzKVlVA3mEJ4cuLFDeEB1dMU0aVbthr2PnxECeCssSsV09FUyQ9dz43rTs8869gbxfPMVtImQA2zUU8/Cbiz7BwGrTT1TeHJYCZVsZG9cakAGW/QWYs0z22NJH03qlLJMovUqbql0aji2uZUYRtBM1prqZ9Xdo8/COI+kDnW0ShkjiiKXgGhSsEMCJn/FmuNFGTIprgV8b/UzW4yGCy6Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CWkZibYEgK+WvxNhLD6fIMFS9y3rR6raXhqZUu/LHbg=;
 b=XKbrcTVyXqrgGt4Pskcntc7U7DncJQdFk4dzirn4vJc1RJQjz+z3ReG/xbHtGWQ05AYSJ6yM9lSEkBHW79xXg27G/qA1y6RA0qXi62sD8Q3RENwC5RVrRWeLw2u0P5Dr8GioGj/qwfClumLtOny66iP/BzJGDdPf1qMJh+LjWC9xSD8qgFJtNSewLzc3Sl6vNnbxMoyFRrkxoBdmAbittjottjFGVb26IvCm774M3VbePc+lx4c0o5mfNL6zLlydUI/SYDMXzfa+cyFrVg4L8If+qCA+8LM2ExG+2BCK2PJh30L0isttbe+f9iPDu0utUDd9OEqEc/D2JzH3x7Vccg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7521.eurprd04.prod.outlook.com (2603:10a6:20b:2df::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8356.16; Fri, 17 Jan
 2025 02:47:34 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%6]) with mapi id 15.20.8335.017; Fri, 17 Jan 2025
 02:47:33 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
CC: "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next] net: fec: implement TSO descriptor cleanup
Thread-Topic: [PATCH net-next] net: fec: implement TSO descriptor cleanup
Thread-Index: AQHbaBfkrNWnJ8Q/Q0Sh3+45MzkbSLMaPDTg
Date: Fri, 17 Jan 2025 02:47:33 +0000
Message-ID:
 <PAXPR04MB8510E1BAD3FDB59268138682881B2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250116130920.30984-1-dheeraj.linuxdev@gmail.com>
In-Reply-To: <20250116130920.30984-1-dheeraj.linuxdev@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB7521:EE_
x-ms-office365-filtering-correlation-id: 91b543a3-2e6d-4903-5e6c-08dd36a14b65
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?0q1GOMX38moPa43t1u0WEaer/G7KVAXHM94iu9AmlkxSLlNf+eVkbpAw4LSz?=
 =?us-ascii?Q?ie9ni0jPlKpruWdEIAkwT4zoc1SuRByxU+xcol2kYksmF9VXZxjbhiR2pJGU?=
 =?us-ascii?Q?tWtkoJaHlrjG0+Nq153GfEQ4g5EfU0IgKqwGt8msu24L/M/jUwUcp0LFknFn?=
 =?us-ascii?Q?S7Gech2YlEEYrJJ2eoF+CyralHUxjLbabXaC3zVBb8uN6lRS4LsYgS23EZYM?=
 =?us-ascii?Q?oJSJ7w53ZCLQWfqhIpX1sTge3y6Zh98kg4ZOO8f8EU/kUaDK114ohwI8E1NZ?=
 =?us-ascii?Q?Ox7F+wbjF3+dy5qgPDoc4Ssq+L86jmVsfVAKTyYgsaWqQ9aOs0YVOafqNz/s?=
 =?us-ascii?Q?XvwdNFI+mH6HaoDVvl9DsZnFkYsXToIjDx/97SI73DP94a77maYQRvj1sL7h?=
 =?us-ascii?Q?sXghdcnUw/pru9ODFRFCuNTVXPimcZKuXHTXqH+Xg/UvG1YA3XspSv5do8JI?=
 =?us-ascii?Q?VInjbswxJksEYKLKmf2CSeZkA1+IJHFPwlB6LpzF405vdPupUAIUs1ZNHeQ9?=
 =?us-ascii?Q?TcxJ3ch1wA6BOJkTQJ2kzeqXsQjE/rHoj4rStDNpEayHgBYmSZK8+U05IgNr?=
 =?us-ascii?Q?ALM59xR9cUXMcxZkeK7tikWh1ORT9Oog/5V/KtT+DeJprJ2/0RMAQ3m4R+6a?=
 =?us-ascii?Q?NtLbzdXxiEXPE/nowgrBZZl0sW4JNisfnK6ztSWBXM0iqmR8Kp9YY7/0S0Kh?=
 =?us-ascii?Q?Frfj8NF03B1SYBifwh6gz2GUSTvIsHwRl453yy8s8yQraDOsfzUO5tnccoiO?=
 =?us-ascii?Q?NEjiLnfYvZSmtuT/OvduKCuDj7k1455N35WkTc/UyVl/pixQ9USLHf42x7Jt?=
 =?us-ascii?Q?35LUb7ci207gz9eVuM7KCoi8/Fi0JQxbX8YjRtBr+9lLcIaMUEV0VWLYRIMs?=
 =?us-ascii?Q?RRSbKBOo9vh9dsp9dmlRRuUAljGhsniQMjfjAg2s63G8OSC94pzYab/9JlCE?=
 =?us-ascii?Q?OcFGbvqArahgEgEvxbGKCu4j0GAwgaTEZ8cMD+WwQFRuGWptNU/hhd4qy0Ak?=
 =?us-ascii?Q?GdoC61SJTHo6XNC9rsEort+WQLT/mgcESFbRCKV22rgwKwA20B+JKS9e6S/3?=
 =?us-ascii?Q?1fmeBR+aDOi8jmonb0qQOQw9AOCH+bcMI6zDphdNK88+y67TYOTxFrsAXv2W?=
 =?us-ascii?Q?5Po5zVw3pMvuX+sWD5stNAknzf4MK2WD/jKZ22T+UST4IHeTuW7lJ/wAIl7i?=
 =?us-ascii?Q?B5TJnw+UJX5zy+dIKh/nJie/noXsEjRSw+6ibu9LUDGxR9PV0pmH3KFyJhXG?=
 =?us-ascii?Q?JADdD1F1ymXrPA87vhzHkXZJcCzbF0jfWq3Ud0yZvsbvHR5ZA2FPlpofY8lF?=
 =?us-ascii?Q?gEZOY3jPLnxOe40vvTRiuwrvySnKcJisdMy3/KiNmYmglZHcLROcUxtWlzqB?=
 =?us-ascii?Q?81qGHMVnB/DM36bUJV2ZK6dlgcq+KlB41FQqpnw6X2v96T0EtsjsZyPzW07s?=
 =?us-ascii?Q?tgTiDIUS7f7WtnxnAr8MibC3IiBCP2lt?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?jzIwhRCFeT+bZQHpQExpFR6WU+JwsZu0dkWCglHCgVSy9QuyqDbgI70ED/FI?=
 =?us-ascii?Q?oY24PNuMS3udWC7+yMUAqUVXsyMWLuc47TP17U2MKF+xRzz6u/ZqBJ4ET6uK?=
 =?us-ascii?Q?QpJn9YUlSsQ+fC9R0pOWurgL8VT/Sy49QII9hqyxNx1Hx6I+vFxTQZqd3m5r?=
 =?us-ascii?Q?8j/5yJOzGUsf2l1JIhumrP4mE/BGqC/kfGD02G3YmRQMENahCbjjPBlzuoLg?=
 =?us-ascii?Q?cByB5He/n/KPvWkjpOKIY73dBKnsXmT4yU8OZBpUOCGaLd75IGLjY3kLaCyz?=
 =?us-ascii?Q?mml9UQF4InvIzyVrMPE+ExWnUuatmQ36YRmjga7SudiFRZ9aiDbhaUWaEnJE?=
 =?us-ascii?Q?fh6gwVbqIgNYM9W7QnFP+c3Dld/4TUrs2Xg5PG7ybVR7aD1gk4csI6hK+Y/5?=
 =?us-ascii?Q?BAq81OdAsgnzP3mYBRN7AS3HhM682Eccpo5uS9m1TEFLLqDUkIDxWV7BoU8D?=
 =?us-ascii?Q?2n/+sdA+/KrLsPYfz9+7/OSne13rHzrriy9ykCNbEBR7W8TrM+dUy3ln/St7?=
 =?us-ascii?Q?mRkY28TOe3BWLIp2K49IHdJgtde9uU8AYDKiL/Pfl4ZXyDdL+LWPHmbEj49k?=
 =?us-ascii?Q?Z3Fi8h1/FZre+t+51O5Iv0OMz0r/9ensHAFsnml10U1Zk7TfGej+5rdFVEv0?=
 =?us-ascii?Q?3w60IfF9BwSu9sePPziy/UbfRJN5lbfZZdvxB4sY4qK9pN6mexwQjuaRsve5?=
 =?us-ascii?Q?oJs+zyMTWhSXPtnBI/W7UN78lPLn9Tpi2L1XCbc3+Sm+5w56Aj4WI02+YPxb?=
 =?us-ascii?Q?ftiTg+UKrHHHYa/IU/EujinmGxCPabglSYTu63pJYbYD4Lxn+0K5TN4mmhvu?=
 =?us-ascii?Q?PfBv93Dorq/7qDoKyAi5Uhp2GfgdRve/o2iXF5nusgOCz/nAlKCPauBcF1qy?=
 =?us-ascii?Q?COQKrUevZf9LPmYOX/cmvJyS6P8c/T8iP+5iB8Fmub2xVu8OhTlw0uo2sDcB?=
 =?us-ascii?Q?/Nl06fvxAvJrwgUZ2WJODt4pST08Wgpu22KYQt0VZwBpGoUaWPHzeNOZ6lf0?=
 =?us-ascii?Q?Qe/WVPuynNFL1v5TSyYp6Qc3BMm3URANJe1wA0I7ehONUHPFFnqpDg3SI19l?=
 =?us-ascii?Q?yCtXjlKJupPxfk6lKywsKT3g0IYmOPH3irFBmUBRkdPXnLiSa/y01fdGBOB/?=
 =?us-ascii?Q?OnPZPDo4/J2iR9OLqnjyAgxFxCyNvn3ADrbwIloZWrslCrjB/ThL49rd50Bf?=
 =?us-ascii?Q?wnG/Bm1x+yWm/WlZgIoMbSj3bumSG+rSfXp9GtWt/4fAmdSuLkDzx4rz0pKK?=
 =?us-ascii?Q?RemwcduB2oTmyobFTDew1HEp0FE0G8W0/8JRa8AcF2qrKh1WH22NffozgKx8?=
 =?us-ascii?Q?IAYZFYebK1B1sXIKDizOZ/lYJYeRQTPVkKoXXr35eCq0+SDW7qnXWQoMq8Da?=
 =?us-ascii?Q?g+TPKmq0Gt4qJnyod5cCdrEXc7w4oGvPMEq4H+VeYrXat6/QDMJP9WYZXFM6?=
 =?us-ascii?Q?wGX11t2fzSzcBqNzr38mj+7OVDbk3BvtMVzDPKXxWF/hXvulIDA/quFBOcsu?=
 =?us-ascii?Q?qS4I9oPQCztu/ZfzbyY1h52GSv1W/E3S1423QqfoXUIDxoO/mINDi+7rgFgE?=
 =?us-ascii?Q?68mKm+1xe2XPSin2OoI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 91b543a3-2e6d-4903-5e6c-08dd36a14b65
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jan 2025 02:47:33.8483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: P8Ub2v6caRjxiPumif9J9pVpNhh9pjVRSruT22nYes18ZAMZ5pfsO5o8DTnwIfv9GNEZgO2+fBVhr4fGQru9kw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7521

> Implement the TODO in fec_enet_txq_submit_tso() error path to properly
> release buffer descriptors that were allocated during a failed TSO
> operation. This prevents descriptor leaks when TSO operations fail
> partway through.
>=20
> The cleanup iterates from the starting descriptor to where the error
> occurred, resetting the status and buffer address fields of each
> descriptor.
>=20
> Signed-off-by: Dheeraj Reddy Jonnalagadda <dheeraj.linuxdev@gmail.com>
> ---
>  drivers/net/ethernet/freescale/fec_main.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index b2daed55bf6c..eff065010c9e 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -913,7 +913,18 @@ static int fec_enet_txq_submit_tso(struct
> fec_enet_priv_tx_q *txq,
>  	return 0;
>=20
>  err_release:
> -	/* TODO: Release all used data descriptors for TSO */
> +	/* Release all used data descriptors for TSO */
> +	struct bufdesc *tmp_bdp =3D txq->bd.cur;
> +
> +	while (tmp_bdp !=3D bdp) {
> +		tmp_bdp->cbd_sc =3D 0;
> +		tmp_bdp->cbd_bufaddr =3D 0;
> +		tmp_bdp->cbd_datlen =3D 0;
> +		tmp_bdp =3D fec_enet_get_nextdesc(tmp_bdp, &txq->bd);
> +	}

There is still some cleanup to do.
1. If bufdesc_ex is used, we also need to clear it, such as ebdp->cbd_esc.
2. The data buffers have been mapped in fec_enet_txq_put_data_tso(),
I think we need to unmap them in the error path. But do not unmap
the TSO header buff, which is a DMA memory. Actually it is not necessary
for fec_enet_txq_put_hdr_tso() to call dma_map_single(). If you are
interested, you can add a separate patch to remove dma_map_single()
in fec_enet_txq_put_hdr_tso().

> +
> +	dev_kfree_skb_any(skb);
> +
>  	return ret;
>  }
>=20
> --
> 2.34.1



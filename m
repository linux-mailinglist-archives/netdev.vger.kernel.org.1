Return-Path: <netdev+bounces-201393-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DE2AE9410
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 04:36:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF9623B1A99
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 02:36:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C92F18C332;
	Thu, 26 Jun 2025 02:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="c5hY0Ec8"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010068.outbound.protection.outlook.com [52.101.84.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3528C224F6;
	Thu, 26 Jun 2025 02:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750905403; cv=fail; b=gYvqi0n2QrGXoHFJaIRoP03mJKsf22FrvnnaRG5N/CkmLLJEDbzAjYHEbpZVhO5mgdBC3TEYLgCOJk/guJxaj46QK1fBVYE4LbO1ToGxaTH4uSFelYi/33WHcUwPmW81oaBsteW30uPWcoIOCvVNHlSNRbkKxAG5OoPNm2+hJHI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750905403; c=relaxed/simple;
	bh=mxCLCYTzXkLRfZ/8dawdH1f4zenEpaV+p6gjoMg2BuQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qLTDBqHSXx6JBKJ3i1o9y5BWNaC5EZVwyajxyWbxve5KOvVBt5weDqpI/4I4Pc/GCjd7tqc6aF7D+jhpepU3hEaQ4Vo10YRc7mv+4lxeXcDjaJ4BVFREe2kIdef5UMuP7O22tfLxoB4GifAbh+GebqOjik+pJMKmjqGL2NdpFLk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=c5hY0Ec8; arc=fail smtp.client-ip=52.101.84.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FRjCE5QSl3yfUPTCk4j3xyT0d4Co9dRv++Zsb/NA5SeJNEWVfscgp9rvJcucLPkD2SgAWEKX83w2qaMwg1P9AyFtoSX6jY+G9TAs9tn+5Ol89XmGsjX+S60lih7wQd7osoghpCGaRkzG+WDioeq5vbJPTxpti00MQitfOk9zzuP/kGisnJ82JzXCXEKmR0Y8G4qdROPN0eZHCxA8FL/RxQtJC+yPnDRA4qzmwVtLR019M7f1PnM6A5KAjVCSd+D5CZMinfbX5R7Ez2LPT3nh0hbBcvRF0v6kY8iIbsW6x5Oh/SZFlj92CxK5IjoVRLCHJ96WcGxOqi4BCZiDJnTtbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YpTMVg/aRISxFujn5KoNmFy2lQNjubpjyNMvRL9nkFw=;
 b=nt36H6NoswT08NgbeZ5JWKoGWPut21qbsQ49jQDdcK+PLXaWk7Q9evQFRlEKzNZAj2KLcWMwsJxykrMLqF2dE7ZYuZV17RHmBaqnjxV7AcRG0ixdrhk+K/XaFSJT5lBk6wmfDV+0xjmcILk3l7l0iwAfy/Vp8Zk3TIeVLKaxWPanUPyFApBIjXdygaMOiHDrfznbTfUhXj8RkrnJNUGqh3AFL6gxZf5NX/FhptIH1I8wqJnF69BsIT44+Fjxx+bbE6hmgbNesorqr9KRaW3qAeKD2lH/xcC+VJgUHOLxqR8PlGDy5NdbrS49FMXqjAWpkygyxSluacP5y68rxtxnFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YpTMVg/aRISxFujn5KoNmFy2lQNjubpjyNMvRL9nkFw=;
 b=c5hY0Ec8bKJqPXlMzimfEDmENwELogmAxLFpniU062eO1KpOtZ3TySYLuQqU0tk+8elwN0n1pfpHFislvj0FrWUUsy2lqeQD9hSWe6wUDm04y85ufIgPAvoIudqv4uDiv28OU45/EpgeeumThSWvr0RyWNDHRwIyL7/RU6BKEbUoIW44xbCbxu/cPU75GlyUskjNKk2szPJejO4rbJ3ZstVbnY3vparvlNaUwm0N6zo82PIhylROuvFCpJnjuthdPO7mNRzjGcMIRp0/Yuf7sxQw27cuUcupMmQNH/7PO1WkH1yX1qa5s/BMxtLd+7Lbmi9vKZfmwlS4Exm+uJlC4g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PAXPR04MB8285.eurprd04.prod.outlook.com (2603:10a6:102:1ca::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.30; Thu, 26 Jun
 2025 02:36:38 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8857.026; Thu, 26 Jun 2025
 02:36:37 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jonas Rebmann <jre@pengutronix.de>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "kernel@pengutronix.de"
	<kernel@pengutronix.de>, Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: RE: [PATCH] net: fec: allow disable coalescing
Thread-Topic: [PATCH] net: fec: allow disable coalescing
Thread-Index: AQHb5dxtqoQxXCJYzUKpoDrfk2u4yLQUtvEw
Date: Thu, 26 Jun 2025 02:36:37 +0000
Message-ID:
 <PAXPR04MB8510C17E1980D456FD9F094F887AA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References:
 <20250625-fec_deactivate_coalescing-v1-1-57a1e41a45d3@pengutronix.de>
In-Reply-To:
 <20250625-fec_deactivate_coalescing-v1-1-57a1e41a45d3@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PAXPR04MB8285:EE_
x-ms-office365-filtering-correlation-id: f8d6c1b7-2537-4dcc-a4a6-08ddb45a467f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?jsqPY0X4dF/OIYxL5lB+jPnA4bRuHZtv5cHxZ8dogJfxMFzDbEoCXWOzXvcl?=
 =?us-ascii?Q?6+Zqm0NOk6yoUT4+PJWeI47yV1zQXGjG+ogeAcAwoTwDXwCJVTdZrV1YvaHH?=
 =?us-ascii?Q?lj6ctJ1QYn4zwP2Ms82l5R51nhfYdx+XokZAGzV5bOhWqVKnDEuLEEAZRCc0?=
 =?us-ascii?Q?/I/itlwdAugbGbOAyq+apFiY+mkbScP+1oRb3Lk6NbGv7Nx0Aakh4Slbp+6O?=
 =?us-ascii?Q?TyH6tSPDqWhd/MF+UCSSRlWLN5s4oDJiN1PZ6UDBu8LK8VuM6FXsL7v3eFHc?=
 =?us-ascii?Q?KM6uf7zNun+KNZY0D1jtgvNVBjN6b0KRKtjuFST6XM5359jQsEDiO91ur+8e?=
 =?us-ascii?Q?3kiTNDM8dQi4vQyZPDl3Pa9rMfBQwBMQrKrLq9ASW9PZh2F0APcgsYZNjFZc?=
 =?us-ascii?Q?5gP9wNtZnGxuv2GHr6InRfPZJnk7GpZZ3LH9Qm/MNtD7QjlHAQdIyylGHaGr?=
 =?us-ascii?Q?wnt12H/iPGWHmnZ1SGvLx/arZDt32JlFoCPqUeuw+wQ5HgkFE/vRmus/iCcX?=
 =?us-ascii?Q?Xn9HRlf4FuJLIQkxRNRNd4PIyZ1vigeP/UyQ3b1NByPiGEXd9h+Hz1r5pK1Q?=
 =?us-ascii?Q?E6OkDoIlQN106G4ka9S5vuInCkKmmjpmgx3bBlQ3BPRw4dS1tJEdw4Z1P7p5?=
 =?us-ascii?Q?ELWAUWUAZKlI95a4WTsTojMPB7sIwgWJe7WeS/mK1FlroAFuMW1+2gDvd6d0?=
 =?us-ascii?Q?IT1SEwzVZBMemWzbZ1PVkMc/zs+BYlIcdf22GPnMeKYOcv9Z70n6G2GPYxkY?=
 =?us-ascii?Q?DKrpAPygx31DAECTvU9YiqjobAHeLeT/GyEn0g4iYhGNI8c1xqxxn4DSNn1h?=
 =?us-ascii?Q?g4VCbaccGAeVHbasxWfQ1290tYzgv61Y0FNxkkGy5bKr2xRUrTHUdcHkGtm+?=
 =?us-ascii?Q?7bYOFeqXxRnJG5o8Z6rMwbYw6j5s2D/JkAYkPfOr3paO63LjPwVmVKbb4+eB?=
 =?us-ascii?Q?3P/cOLi05eQscVgSXo/nxUL3eXGKUE16dfAdfCvs+1VSP3JxNUCtG5XlCmCa?=
 =?us-ascii?Q?fG3wmw6tu6P6p5ClI25AhqpmMtDvaHaF45q4sezv5uzWH1LYET5wwa6CRiy5?=
 =?us-ascii?Q?g+W9Bzp6KXl9BD9b4XbeGcWMFCzlFC9OBm8YrNhEF+vhRCbIyuQKgf+1rHGe?=
 =?us-ascii?Q?gV/KTn5ksrLp4hdNUltU9R5nplWvMkiDWbtTHhuMN8dto5vDh33oxTOSkuU2?=
 =?us-ascii?Q?08ij8O0cBGHEsojQ7i0+xcV78ctL3F+kN5TlTZMm3ezbUyJy0SS+DfLlrqT9?=
 =?us-ascii?Q?6cL5kCvTgv1b4cg8fTvoKmEvE0e2vr5GzRq7VdXRnEKyRa7eICX+9K1WmaTf?=
 =?us-ascii?Q?arz6bUYfOFHIIAeII8ATWAXspseo75ib9aDgFfbjWeZUwbH0ZMOyLhhjpDz+?=
 =?us-ascii?Q?uMsoUoQRCliIVtRUT25QfDXcRAWwtnIbhRCTbssNHTQNhtwGPXYQx5t+5cWK?=
 =?us-ascii?Q?J+3t5HRXRXSsnUYzz2XUoQ1TcO+847adGDQRpxVI1Z+Hqs6dPNdG0g=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?BiTSTexMptOD7walKEVQqgWn/wOQ7yoC+Uoq/jMiQYeYe5kNUBl7BYo+sd5g?=
 =?us-ascii?Q?6IeWHR6pt/g1xi1UD8OB4TmwPfIMiNNY9Lzyt0chIO62PJQIXwk0+gv7YbzZ?=
 =?us-ascii?Q?J40e9bfhJFzI9zZIiJnRTuxTQMOtDDiGFm0xV8NEbMM0BTY/QUmBet02IMZq?=
 =?us-ascii?Q?djGLaDN4UW2BYnwSMmb+W9SIPT+UOmZ6MQ24gWiafBHMZ1UXL18HxbuKWR1N?=
 =?us-ascii?Q?xpHs5/j4SQBlAlckH8M3oz40qmD0p7VZoH+kt2YF9+iSTnYmwTpp70Qe06yq?=
 =?us-ascii?Q?Gfg0+axp+UBhTuYaXLB2wJFMiRlVF/8q/JTYxnft2zlOQSNDk8chTcDJlCiQ?=
 =?us-ascii?Q?NGLxD9/D7pUHU+eq2LHrCx9jWViaErAu5AiStdhe/JqgN4+em/X036tfNqiW?=
 =?us-ascii?Q?hEaMoAIa/t57DCevCm1xsNztDnCDqxHASS9Ymuvy5UD4PcB3kro6hoSy53Th?=
 =?us-ascii?Q?RVTOFPhRQ4PVaGRz4jr7YiI4tIIG5FCcsGurm3vay85keFGokT56zH3XtlXC?=
 =?us-ascii?Q?PJM7vmpSvCzKawBgFGw2OM0MhJUUYGbKaAJhOi7ZJAWgGPkCex2CZTm5Xd53?=
 =?us-ascii?Q?q5LosfLPJbYs0g7XRYrNX0xez7wHYL1IL3S1L3oq8c1flDXf7qp/IobE227a?=
 =?us-ascii?Q?Pj/T4mNifkOo/X+1nvrF+s1a4MUM+Em68te4Eoq42ulSIPmqYOp4YuyrJaM5?=
 =?us-ascii?Q?YahDbF03iNUEZec+G5QZxAB3d7eZ+HMdoe5cq+FeVPrJ4G2HUy7xeRcHbnjD?=
 =?us-ascii?Q?fTCDbgAwLvjkxa1OpLS1nEkn5jMIyyaxDRrFD3Kua03bbdQ5c7DhDScDapuO?=
 =?us-ascii?Q?zf9rVyNTD2QQicBSlJbTzf09GIMAXmc8LrFpifE5RphRF/HdkHhh+FG+DStJ?=
 =?us-ascii?Q?+VaKZE2a9HsUjA5ZGTuGt7WlpoV646rY5o+UTVm5XbsYpAnWoOefGFG/MxXX?=
 =?us-ascii?Q?UxWzEeseQoa6lp2Ov7/9nlZgBwYaHN0fQLYq2ilTUbWRSdH2yQZ1Dd2ql63n?=
 =?us-ascii?Q?cOUfrBBuVWs6SWYad1NGLo6dYNE/FBery3d4tqEdw1oeqOUofLiYelmvdBR+?=
 =?us-ascii?Q?Hw8ifzCihuWfGXH5eGXWewE5lpn8TjbL+4EAqj00c59koB+P6+/7ajvCyroM?=
 =?us-ascii?Q?18k5OnuKznOKzeo0uKzEcfwB07oJQRpr985VIH/hvIrrOrY4RXGsAR7yXJMQ?=
 =?us-ascii?Q?+MaHAOt/yW5zbbCYPQVYIrNhORZLF0uFOB0QGa4hs/9XNuR1HMfU4NT2+GE9?=
 =?us-ascii?Q?1pk3C77elUR9fCledvsNDroyUsWVfmjrAT6GX9991QU5HS4rP61/t+msn7Ru?=
 =?us-ascii?Q?ZIYAcagJNmwoX9di9KCsxOJY7SaJ7uLCYtOuhqZNsywhRv3tMxrCu/dwPR1r?=
 =?us-ascii?Q?4PXVZNi1oGXbH+JEhFYMy8ASC4XIvT+VSWkGZ8sY4QpaHCId2Wl3FWfQJjSI?=
 =?us-ascii?Q?ZoB+X03CWDL6asCxT2DLReQNvCWznrwMSUrANwkgU3YM2dKQPrYgT0IqJ/iP?=
 =?us-ascii?Q?ab/ABRe3qASDNdG9pxPaFWVkvfwjHxWOYKQjQx1epqHvCxWSphGdJA+kZ1SW?=
 =?us-ascii?Q?la0YeJ3vLcvt/wm4N2s=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: f8d6c1b7-2537-4dcc-a4a6-08ddb45a467f
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jun 2025 02:36:37.8923
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o6LrnifoFGM1cXPHJ3pQ4eEf4HqGqmV0pDseSr4JZOvOkZ2hkrkDeH2G8IbXlHRac/8q19Of5p1YW5tM59w1CA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8285

>  static void fec_enet_itr_coal_set(struct net_device *ndev)
>  {
>         struct fec_enet_private *fep =3D netdev_priv(ndev);
> -       int rx_itr, tx_itr;
> +       int rx_itr =3D 0, tx_itr =3D 0;

Since you modified this line, it would be a good idea to change
the type to u32.

>=20
> -       /* Must be greater than zero to avoid unpredictable behavior */
> -       if (!fep->rx_time_itr || !fep->rx_pkts_itr ||
> -           !fep->tx_time_itr || !fep->tx_pkts_itr)
> -               return;
> -
> -       /* Select enet system clock as Interrupt Coalescing
> -        * timer Clock Source
> -        */
> -       rx_itr =3D FEC_ITR_CLK_SEL;
> -       tx_itr =3D FEC_ITR_CLK_SEL;
> -
> -       /* set ICFT and ICTT */
> -       rx_itr |=3D FEC_ITR_ICFT(fep->rx_pkts_itr);
> -       rx_itr |=3D FEC_ITR_ICTT(fec_enet_us_to_itr_clock(ndev,
> fep->rx_time_itr));
> -       tx_itr |=3D FEC_ITR_ICFT(fep->tx_pkts_itr);
> -       tx_itr |=3D FEC_ITR_ICTT(fec_enet_us_to_itr_clock(ndev,
> fep->tx_time_itr));
> +       if (fep->rx_time_itr > 0 && fep->rx_pkts_itr > 1) {
> +               /* Select enet system clock as Interrupt Coalescing timer
> Clock Source */
> +               rx_itr =3D FEC_ITR_CLK_SEL;
> +               rx_itr |=3D FEC_ITR_EN;

nitpicking: the above two lines can be simplified to one line as below,
but the comment needs to be changed appropriately.

	rx_itr =3D FEC_ITR_CLK_SEL | FEC_ITR_EN;

> +               rx_itr |=3D FEC_ITR_ICFT(fep->rx_pkts_itr);
> +               rx_itr |=3D FEC_ITR_ICTT(fec_enet_us_to_itr_clock(ndev,
> fep->rx_time_itr));
> +       }
>=20
> -       rx_itr |=3D FEC_ITR_EN;
> -       tx_itr |=3D FEC_ITR_EN;
> +       if (fep->tx_time_itr > 0 && fep->tx_pkts_itr > 1) {
> +               /* Select enet system clock as Interrupt Coalescing timer
> Clock Source */
> +               tx_itr =3D FEC_ITR_CLK_SEL;
> +               tx_itr |=3D FEC_ITR_EN;

Same as above



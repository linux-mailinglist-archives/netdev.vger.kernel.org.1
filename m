Return-Path: <netdev+bounces-223413-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C596B590DE
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 10:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE03916EF9A
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 08:37:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F68272E4E;
	Tue, 16 Sep 2025 08:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UVkt2wxj"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011064.outbound.protection.outlook.com [52.101.65.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D72415B0FE
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758011846; cv=fail; b=BPBXGJXht0kcqlBJOzVr0t39951w1AKnlx12628Ac4G3FdUUsKQ1zZqzSATX8ju+l2EYUfAgJmjx7wOoLzb4t/mpRCWWRPz+3g1TXu95AkXCazA7C8LiIG9lrxKzOtMrAW1/tfTaYmyikqWIvk2B9KISrs9mIS1Zets10k094y0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758011846; c=relaxed/simple;
	bh=qryGj9dKZys/Voagpi75E0Eru2m44idPXpV8RYHQi78=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=So24xMU4ru08O0bocyJXcuqlJv06lTXYTjU2DkL3ucn54I+u8+7+JJ+PVdphtIvqRJaaFKXbN5KMeQIgnF2y22mwJngxQdUQ6qeJQEUpz71hMkZR+tU2o11J/hkmq0VmGM3DKEYQimK2hesr3+z3bKfj21k7EeyCVp7PuelrTCU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UVkt2wxj; arc=fail smtp.client-ip=52.101.65.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=alZTiM1aTCLQ9mQy1QlqAx5IVyVIjzjTL9RlGX3rDOpwV1XJwe5DGTaVj0G61H0Qa9bql7/W5E0jGOM8uXIUBy3sDrkFzhzQkJx5r4drdnuVihYn/bO9kUgc1rVPrCemisxdTK3/4ZIuaAxwue7uGdvHw7zlnb0KrMfhtaHEr6bH52JNhkHbq9JYYBvkguqGaEjzjOg/IGXnI/PE9S8nx+PN7wf8wdqonTGx3l1T2jnrUrIxGPMnh6eZ26aEayk78+ITPQoIY7J4sbuZ2zIaLENuOfD3IoT/Xw/Wl6jwoalf43bPJBsII3yAcP4jcXT5L5iv5QkXFRX/DfsgTn6JsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qryGj9dKZys/Voagpi75E0Eru2m44idPXpV8RYHQi78=;
 b=rFkf5Jo/fwi5yZ8WatOo+aWoMd7NlKSxZr0imCuZECRiGyA0TIYzy7wDVVLp5SNjvQoeIx9J088quGjJevdsgwVvOwmfBVMyhN5Rw3B56zigRs/31T4s/owo6TbXQs4Uw71bDlUiqiSgVDPztLhbcbM54EAenSKAvlhkVj+lGE/86ltS/frJvUbgkARvPCWOMMHiVhgOXP7SwtoeNjogcWhmATM6Ng1wt14NmB8H/Rbc7sVSnl5JUge/is8UAx/B3JfsiUrhsmQhdr1Kq/Hk3Z0hC5LUuNJjl5MCR0KYRIE7mvvX/sf4DxzNeWSBwMWBEcvShhJBlT6ICXV088Oitg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qryGj9dKZys/Voagpi75E0Eru2m44idPXpV8RYHQi78=;
 b=UVkt2wxjN0YqX6nX3M4FnHQUuFrvnZC5z8rsKZzpkBZ/J7gWjMxQqh2gtvVotc1iPsfeZt83fGemp/nU1kg5IJs13BEFnrxs96t+nUjUqIHw/28Y5JZ8TyyQrur5H4I4akmoPTDrZ6Z3tX3TGyQQXurfxdhO8mqzCJ0DoJQ6bxjMbGf7/YhHYfbBwBglyIaH22GNwkw2OpjXh+na1V0ej0UUu4S7VsPt4qjIdonDjACHzm3vqNjD9lt+4tqMTrKX3zS2fj/fau8EAhF7fImKvwJ3iOoWyHFcvaE73jOVaIkOGAHoy+KRMWE7DBh/g0GIjzw/bxjcpByBkQBRsI6seQ==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8327.eurprd04.prod.outlook.com (2603:10a6:20b:3f1::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.12; Tue, 16 Sep
 2025 08:37:21 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9137.010; Tue, 16 Sep 2025
 08:37:21 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Russell King <linux@armlinux.org.uk>
CC: Ajay Kaher <ajay.kaher@broadcom.com>, Alexey Makhalov
	<alexey.makhalov@broadcom.com>, Andrew Lunn <andrew+netdev@lunn.ch>, Richard
 Cochran <richardcochran@gmail.com>, Broadcom internal kernel review list
	<bcm-kernel-feedback-list@broadcom.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"David S. Miller" <davem@davemloft.net>, David Woodhouse
	<dwmw2@infradead.org>, Eric Dumazet <edumazet@google.com>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, Jakub Kicinski
	<kuba@kernel.org>, Jonathan Lemon <jonathan.lemon@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, Nick Shi
	<nick.shi@broadcom.com>, Paolo Abeni <pabeni@redhat.com>, Sven Schnelle
	<svens@linux.ibm.com>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Vladimir
 Oltean <vladimir.oltean@nxp.com>, "Y.B. Lu" <yangbo.lu@nxp.com>
Subject: RE: [PATCH net-next 0/2] ptp: safely cleanup when unregistering a PTP
 clock
Thread-Topic: [PATCH net-next 0/2] ptp: safely cleanup when unregistering a
 PTP clock
Thread-Index: AQHcJk7p71Z+A0ineEmo0W/IGhZZfLSVezmA
Date: Tue, 16 Sep 2025 08:37:20 +0000
Message-ID:
 <PAXPR04MB85100C0C6A1F468F17ACBFF68814A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <aMglp11mUGk9PAvu@shell.armlinux.org.uk>
In-Reply-To: <aMglp11mUGk9PAvu@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8327:EE_
x-ms-office365-filtering-correlation-id: fd3925c1-512d-48fc-b1d3-08ddf4fc40ab
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|19092799006|366016|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?P10oCVmyBcK3wSBj1YHwEZuIYSypxny7B9AMTl7SNiQ5VV1cSU06phzD5V43?=
 =?us-ascii?Q?/RB/OPXJpF6FxZWkPsb1mHm6ChJNWAk8AHq7Gqp9//FTI9Qq3jROwRYo/O73?=
 =?us-ascii?Q?yVwOm2huFC+E/PtfYJIcvvlklRypurT9sI95AkLXFTyhvw87N3otSKCojzJa?=
 =?us-ascii?Q?nBM1f6mgNmWgED0BOOUTIegA05MikXik/FOvE8g0qpO3DHuZSaoCh7XEwQXw?=
 =?us-ascii?Q?3qbg8fAplxEcekQWJ7VLRlSy7iXDamxeGH4R7TqOK6aXTg5YZKrIuAKZOTKH?=
 =?us-ascii?Q?pAfnG8oqbBLsaKagDkrzqMs38emz0qim8bcfxjkYOxOxvIH266pRiOKBkId5?=
 =?us-ascii?Q?Te1XEfLzvaadwtztXQ4JwwMx3NvZJFYi93+84cMrV8yowcaQbQYeCgvDHPt/?=
 =?us-ascii?Q?b+I2nYxr8+5gzOLiH8AbsMlAHWLWLwM42COLxizpVvJygOoxKkWZ2k00BSZr?=
 =?us-ascii?Q?dB8lsDRddfSXcOjR//JjcYeJ6AzRnxKSI0w9o8PorwaBWszGZx9bXmIv4nZF?=
 =?us-ascii?Q?ZUfidxuqP3TkRaOiPqFuT99pgnKnJ+zJn1D7h7DHJkriaDmUNIPh9Ht0MGVi?=
 =?us-ascii?Q?sZtEr0A69o2JQB6mklXNcIx7kUogDCNC4R7vA+DdLp5s/QFwf7pqWKW6r3bo?=
 =?us-ascii?Q?BrrHmhFZUVGBACRxisJpja0hOqVGvng0vfBs5xFrsvgOLgWJEqU219dTcBjr?=
 =?us-ascii?Q?M11TdFW8mKY58nY3PGC3Fqkjwk0I+MfOMET0CjC3XNriGI61GUxeuE37nbaO?=
 =?us-ascii?Q?VtiYYKHMVjv07ypUp/0SCzaWaxDb+W8UxnK83jQ0ucUZWxq6exVG4ifNFOPc?=
 =?us-ascii?Q?NV9Ox/lh/SD8jfhHOzIHqhm+JGilx5gPcU0OnYKx/1AzQjgonq2zvfp4rRJ4?=
 =?us-ascii?Q?xfDuGg6SNUoCudVTGt1FGLaPaGuq83iQlltcU/fbcAOJy5BiI9ZJI+t8Apq5?=
 =?us-ascii?Q?/LRIg8d1OdoR6aQuBaywEmud/M2At62a49GGdePfzi5g1dOTCP2lGprSKp3g?=
 =?us-ascii?Q?j/jdogts1OHMe4DnYqW7QaGND5ylJdQOaYRa7dczkRw09DdBPXSfDvsJQoPQ?=
 =?us-ascii?Q?xSICX+zxtHKFao6QOOnlcMqUv1wpsgd8N5DX0Pm0MxubaRGRcGBzytcmPWvT?=
 =?us-ascii?Q?R0K59cGqXV4o+sIYlilzkOOEUUFa3YOTmM4YXgzhWqMatiXGISYqsb+ILCf8?=
 =?us-ascii?Q?a2epPsIrntOdZ0uZZxWgGIYf5qasyGjTOg53a0ZCkAPZTK9BkUIUqWcQ5HuJ?=
 =?us-ascii?Q?vTTsAjlhy/HUn8kNeVTvc5nB1lruF8vZj3NBWtYLNcEK5Ey6+XLcx4JOSRdK?=
 =?us-ascii?Q?bwLRZxp4HjrR5tlGjIURwtPO8NFmtXys4IO+oYHW/a1DMIdGynKEFBGzef0n?=
 =?us-ascii?Q?STDFHtN9igtsOp4UCqSOcO9T8g8Wcd8uaHciFAc/EL5d4fGgSq8gbUCl5Z03?=
 =?us-ascii?Q?alPhGO3ZAxP+xAIt8CgF0IqopwscwrFcc8uiv2x6fiQRuvIiLe2aHQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(366016)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+vLAzti7v6sdK0t8GZfOViLmFlhvwLiZvKrttztJ7CQSvyfpVAwJ0ssE8XmV?=
 =?us-ascii?Q?/AiTJxhFaSX1xEGMgsX4L69yVvM5VoQp3eokIxQ9+33ZCyXbTM5dI9OkrRvm?=
 =?us-ascii?Q?EBNafu418TUoVWnptl3o78Q2lMV6NEwFkcKdola22T8MGUVkeTEc6Y1E4pEr?=
 =?us-ascii?Q?U8mqHzVg06Q3ohWafTBxAztureOxSlP1Q2Ll70LekGdvFLUG+1R7AO2fAmT2?=
 =?us-ascii?Q?nvh8w71fzu+7kEY0wKxJFg/KS2mnuY+I06M3Z3CerzrWJoXdYWYB2x3RqjOi?=
 =?us-ascii?Q?dnrjsrXEDkHPKILpK31KuR9tJV+HEzxKWaxseF2agIafby8lLbldxkKjesji?=
 =?us-ascii?Q?ZG29BiO63RLES6oZqbtB9EbIK0f2TUCZDjk2/PMF5dwOXHkagH3FUuk79OEd?=
 =?us-ascii?Q?EKihY7HP3PzRmbUKVZSX89nHE2Fmhj+h9ZPMp09WOa3D2oFdAd24kG6nZnuS?=
 =?us-ascii?Q?TejyYO28ZyQlMqpSGBQQYF6KdvE9Uk+Tbfc/UXk/21ZZBdEBCERHXRVdEQxF?=
 =?us-ascii?Q?VhQpBpa3OMx0RFDgfhOpOMfWtJYioRRaQ1dzRe0jX58JL/B7WAW6ZR7giZmR?=
 =?us-ascii?Q?/YBslmw9Zzt+xp5X4cEmXJVJOU75eHxBKljvvYP7NbTNk3FiKb5ndQUXYpnE?=
 =?us-ascii?Q?X48Mw/LdQ5IBUjmOaRvD0D52y/CTSc4dOeOMOiaYUQxOFW6OdTSwKci9yzWJ?=
 =?us-ascii?Q?nJf/+UvEm5z+u//zasfo4iVYQXxMbLnsaY4jM+Q7Ni6B340RlWwNwgpa0kDc?=
 =?us-ascii?Q?hNmTNT4nurQGZmO4KXBwrqgNoEEKg/tlPNNFtxXwunFGwR8tRB12CTG+26nl?=
 =?us-ascii?Q?l7Rrs1r/kGo+a+iprtvutgJg2RSCwbG3fD/HZZ8fil5WMQi4UCa9vr5l+hqL?=
 =?us-ascii?Q?RWAiGbvF9TAu6Ds0NdAZmoG/n55ThqYuQwc4SFjM65cE2yiDgyGCgrxjufH4?=
 =?us-ascii?Q?9uGCKzBUJYSsRitlNVAh35eUUXWN+zzrjlp758L/KeOnDczDvmraIGMrr7TF?=
 =?us-ascii?Q?ouzOtwzdmcw2lqvTPAmPO52vQvMyCc9rw1+tyo5QdgxC4Z2EpT0ZpYe6YB0v?=
 =?us-ascii?Q?q8la9ACzhbffNINQt09pAgMAqVy1EpgM9tc7rPq7D7aX9aJwlgw4Dhzqa+Yo?=
 =?us-ascii?Q?IIfO7dhu3rQlMzC7005qHq2I0q4O5P1U0Ac2hkKQkQd71LkdPTXjfXIpKUHM?=
 =?us-ascii?Q?0vEkZtrYj5lma0RUUoxCV+0eKaVALFSWfIOmfjnTuNsujTwpiASEA9CyXeAB?=
 =?us-ascii?Q?yF/jRU+PAJDvRcFrXNzCZV/K7lT/LpU/dvUkyLP/AJLUJvFXwl0mCfrwQGeE?=
 =?us-ascii?Q?wMPckgoxVOrDVoGd6i0X/tGMsLzmV/8jkGCDBw/38DOsVvOXjV7E+abKla48?=
 =?us-ascii?Q?K8p1Zw198qe614Ava59x8uyYnHkeq8cA7iC9EKJN/Iw0joFy8rbSV6B4De6s?=
 =?us-ascii?Q?otV9agTvXccj1uFUav2wmy/UbQlZ7t7WnhSND+jGh/CkdUmXTQZJp0A/qHX0?=
 =?us-ascii?Q?KMhHnRH1QarTk0OAqdVf2EtYa8Fl7/Pl5bEmRhaypmN7AX/wZS2EyiWHtWpa?=
 =?us-ascii?Q?OwtgtFp1IOAq/2bYRHk=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fd3925c1-512d-48fc-b1d3-08ddf4fc40ab
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Sep 2025 08:37:20.9995
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7aG2steJGIlK+CiddIKUvK39a8qncHhypTImxB/l8bXd561FjeWPW25OdZxEzMbh7EN2/jRFG7L6eJu/acM3jQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8327

> This is difficult for me to test beyond build testing - on the
> Clearfog platform with Marvell PHY PTP, the ethernet PHY is the
> primary connectivity, so removing the PHY driver for an in-use
> network interface isn't possible.
>=20
> On the ZII rev B platform, where the DSA switches have the TAI
> hardware and where root NFS is used, removal of the DSA switch
> module somehow forces the FEC interface _not_ connected to the DSA
> switch to lose link, causing the machine to become unresponsive
> as its root filesystem vanishes.
>=20

After applying the patch, I tested the unbinding and rebinding of
the ptp_netc driver on the i.MX95 platform, I did not see any
issues, and the NETC Timer works properly after rebinding.
I cannot test the pinfunc, because ptp_netc driver does not
support it. Do you need my Tested-by tag for this patch set?



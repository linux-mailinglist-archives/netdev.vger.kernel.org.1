Return-Path: <netdev+bounces-111606-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912A5931C66
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 23:09:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF6831C217C5
	for <lists+netdev@lfdr.de>; Mon, 15 Jul 2024 21:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C8913B5B6;
	Mon, 15 Jul 2024 21:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="bPqatG1p"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11012030.outbound.protection.outlook.com [52.101.66.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60F3A8174E
	for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 21:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721077764; cv=fail; b=Xs2RcvXXeJUZHZFufVsdLIWn9Yy8eipAmu8VmsuWv5FZJZEF5tzNYZ/oWk7Y+yK2v6uCGIeYWG6KDP27rDMoE/v0JkCYAHkaFBZtf4gquZYovirzYRKDnTVPqfD0gPpkr8OFg0z2ltAGL94K3IKNo7DsYamFjHV8lVKFV4sMDu8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721077764; c=relaxed/simple;
	bh=kK2n5uj4HN3+rhSW8BRmwkU4htKKn1mq4EgTcrG06VI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B0nk/u9WSqnqNWNu7PrYRHLGIxdruqmNW4PfZXBYPTMXFvxQRjG+6npCygZzm+4RyDhp65hdiXoHpVTU4ef7PpZ6h+iUnP17zFPpLEFN9YvdF0JtfNk0efh1XtgFA+hY22RR+GF/nyNdoygZEDznSre3g29r9EFzmTGoM7aQdwM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=bPqatG1p; arc=fail smtp.client-ip=52.101.66.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dPnnIF8pBLkUxVPK93wo6NbqjhgnRObny1o0FLi7ijwHVDbzP8Chy9Z5ri95Ja4HBbGtyA7RSB6S0XkrI8cCLzwAIkzw9HCUTAkIIT4htDHi9kY+onIBG3dQeQ8QjHyAO1pmI2Ry7AnakRnvUjNVL11LcRZu+6xLN/qUpJI88Io+uQQZo0IAg0ycTA3rva1/YfxFKXaiP8oG9pqrMqZhBQ8cE/nsEdb8si9U2/uVnlR1SNOYvJn3I89SI5SX/fU/R1B7cQe0iPxDx1X43VJDtR4uM7QS/nlwgOd//y+kH1K5bS3OA+Z23O9qbcB3CitfaZKLBear9/T4QWU+zYD8ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bUxQiNZO34Qul+hnIuVB7gCfHhvwCVmO4SwqfrST9/w=;
 b=sZE3HcDvf81xk0VQpMoXKf7umdwKu6J49um0jEngpGexOWMY++mDmK5vEx/Ql4i1BmyXosDIQhOzqC1+fzNjbDN5SGD3cjWw0uIZCNdhE7055qFanQnOMgbO+fOfxqyA5678bfLQnzLpl0NVsEONvqIluIhhxDVvbRCZv2c+++r/Hz1Jz3x55u3vYXPwxEygnDDb6q8nt7ncWrwKP2Wb/yhpvxJ/o9AM5gCNXVaYstKYhqF9ozBBS7JPwUvRVHlLgi9+8NoEZBFQZkedckZrMylnQF5gBk8wiZ2QDXQsgk3YcXeCxeog8YLYKP8fDiMfKqVTdkua18c0KF51t3RsEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bUxQiNZO34Qul+hnIuVB7gCfHhvwCVmO4SwqfrST9/w=;
 b=bPqatG1pnp5b2M3ohC9LsYwvsKP2d0s5inngPeh4txO+UPP/HFCOKj6nOC/1L/lm3E/V/vCXScN2PsGcnU32ON3JkdLmL9znCL6izPW1e9MCxA/ojNJOCBuAKVoZbEKdTFgWGlFef5hUt9NsvfgKzJMlIDGXmbFo1AWRgcqb1Qg=
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by PA2PR04MB10085.eurprd04.prod.outlook.com (2603:10a6:102:3ff::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7762.28; Mon, 15 Jul
 2024 21:09:19 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%3]) with mapi id 15.20.7762.027; Mon, 15 Jul 2024
 21:09:19 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Wei Fang <wei.fang@nxp.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Clark Wang <xiaoning.wang@nxp.com>, Rasmus Villemoes
	<linux@rasmusvillemoes.dk>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, dl-linux-imx
	<linux-imx@nxp.com>
Subject: Re: [PATCH net-next] net: fec: Enable SOC specific rx-usecs
 coalescence default setting
Thread-Topic: [PATCH net-next] net: fec: Enable SOC specific rx-usecs
 coalescence default setting
Thread-Index: AQHa1vtBr9HotV69LEGJ3rmed88HiA==
Date: Mon, 15 Jul 2024 21:09:19 +0000
Message-ID:
 <PAXPR04MB9185762B86A4A17A7E2C716189A12@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20240715195449.244268-1-shenwei.wang@nxp.com>
 <6521b6ed-ed67-469e-9cc8-b08c489cba10@lunn.ch>
In-Reply-To: <6521b6ed-ed67-469e-9cc8-b08c489cba10@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|PA2PR04MB10085:EE_
x-ms-office365-filtering-correlation-id: bdbbc860-cb32-4017-66bd-08dca5126468
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?4Uxo2QUqmYXVdOCe5VwDPPohoJ59iThkbLnnVxaxUiLEkz6hawN61GWSaaoA?=
 =?us-ascii?Q?gQcKwUGWU0XnIb190Hm/Xvl2Q5k2biUNjAV3ijP00B9KMv6GP258R1/Br9Mj?=
 =?us-ascii?Q?KzPyUa9olzzeq9SalCS5rwpNVleFivjgQN4HNXrE/MBuBJkFGCCP0saZDnVH?=
 =?us-ascii?Q?3LfYV/YW5m3T0X5utERT5exU3ky7RjEXOSEk1qApmbforWE9xgk73zAgy9KN?=
 =?us-ascii?Q?JzroCR82YB41uEtX+L00uURrD8FAWwdWSRTRs1X7DxeMRcSCTdED5f5vnUPX?=
 =?us-ascii?Q?FSVf9BPmBS44CGIoKYLhGTMebJg4zlhDOMa/r6r0yN05u5Y5UWGhjtUR/kXH?=
 =?us-ascii?Q?vjp/tcSO7b/jtI+q1IG1qW4fA/RQOIgsk2vg3ARFpVKkTnxeaM65Rf/6skZr?=
 =?us-ascii?Q?N8ET4gJKbMkkuYdvUVDgmxGgmHvC9ojTdOoreneC9XkHUkspJCRy2F9KrpW7?=
 =?us-ascii?Q?zPWy4Tff5jPqkKKnZhLap3A16dC72pB8IJ/CSFXO3QxVlb2tHFr1+0cg/CeZ?=
 =?us-ascii?Q?QRG6vZkvycPK8OxV85qmCcjvlV/l5/XeU4LbKPnV8FylihYD95YPQq9rtTTv?=
 =?us-ascii?Q?A52G/oVPO+IPP53ykKA0BWVnmNJnOi7bD3EjW2xrEVEEtRKqkNiu/lCbWPtW?=
 =?us-ascii?Q?KwlN4FZZbn4TxO6vXnWxIoNkMqUB3SfL8qoXEBewjsmgyzogfjf6y/DIJr8d?=
 =?us-ascii?Q?KKmIMcI/Jmt3lzTys7Ppi1Xf1faiKE5Iw6KX6YtKGPqnIm1HlAnPkemB0uAb?=
 =?us-ascii?Q?3o3M4uxqDVeHvFVkyBzpJVVyN3Fy+GFEyhgGXtAYA2hn+qWKRMqLdfaS7+rd?=
 =?us-ascii?Q?Thgs4CdfJQNrgq2JW5mdE7kAuXu94u7aHivkOtq11SvgtnMunVLZSfIfEFIQ?=
 =?us-ascii?Q?NVRdyh1jKylV51z3tMMBBQpoRzuCwF23rCE9KG8Nr8UgQSdo+0IuMUWH8JJK?=
 =?us-ascii?Q?wQdlpoJbie26NMA+8Wsq0vClolnqUHqDiKGQL2k+Wg2i1mrYmtLqO6ONBYRX?=
 =?us-ascii?Q?/GT6sBZqAv5s/0vXyDZwnadUZ/a+1nlKHnpc5AIHRZYWGsBixVMA3PZItK/y?=
 =?us-ascii?Q?suMouxBUKgFIfX58wQ+U4rnZQPBWQFd2ALaefq15SlStdK7me+9yYtgDdoRx?=
 =?us-ascii?Q?BBJ+HrebjLE8Nx+uq3oZUx5rxac7Y6PuxyNh01ZWcok/+f7ci0yLuZftIvsz?=
 =?us-ascii?Q?BFv8dgL9OEs9b1hBARiZbSZFyxiurmZGEqStk98p9va3eGYYu0Xu790lvyF/?=
 =?us-ascii?Q?1na3KBsm+1hS+I17w0I6yZYYQdWFhwJXCQCJvTQ+2WQ1rOQCn4Ld5rnLfUe/?=
 =?us-ascii?Q?0/MwL6uLKJ4J0Io84MRmmxmRai/3XuWEnpGxZMFu9PjO+eZJ3GmzoahkTBYb?=
 =?us-ascii?Q?Hq4E0kGivkTxOAyeP5keHdlEXJRH3atLWP5FrRfS8WWqTwNSYw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?tkaj6Et4BkW0Ad/JognzN1gbptQulN4N6Z8MQEWc3ZTSHiGm8XOPTZejjxsI?=
 =?us-ascii?Q?9EjEH172gWFRmORz2AVWn+RFl2xg7CtepAChS9mWkkn+naEEJ86z9NjH3myZ?=
 =?us-ascii?Q?U+/cKutsXKwHh4kYS9sAmqmAj35nV940HvvV/JjseGKPUCwMFGM8ZP+gPFRW?=
 =?us-ascii?Q?CFVEbMGaCMgqoPAX2YCO738IMFofd4xArg0firSrHsBaEByCcxcet9RS37Al?=
 =?us-ascii?Q?EIcYsoUn3XE6rB2Bh3exyo41nKkliqLVYr1WWbn9o1awmiwsuM6KtyNonYuh?=
 =?us-ascii?Q?44xpsrtlF1nbaY7k/ABpFv2HCZvtmlLUqEXWkE7uSjoysLwsknC73ppa8nci?=
 =?us-ascii?Q?tr1OMIn4fIQlLBynlOvVqAlRrt5SKSqsVFcoNr3A4+xyAqqQdF8AxhOfGH77?=
 =?us-ascii?Q?e4iy4FjIA6DbRfEfRxcZS+pxSy9JPrUHHPGfEzBm3T+RxjnqGxcLVHoNyTdy?=
 =?us-ascii?Q?fCINFlzNDhfcpX0Kz3Bm8u/LnETQwP9xFkvvnvAvA/6BYmEcd/Lg1mDdzrH4?=
 =?us-ascii?Q?FcYBI2hclfdfdKQavDTL6dkWzmwtwaGtFrxGcXX3Davh3zL0bqi95hWKL/lh?=
 =?us-ascii?Q?zkJS0/5azXtcCSnWDJ8D1aEOniB9w6IBR28TQglRxTmJDcnO/Q+fSiRLf/Rb?=
 =?us-ascii?Q?nHDHx7wVDrs5457NlD9fyXpE3EOzE35Z0zcHNxvcxrGmeyEU7MUsSTCO0m4r?=
 =?us-ascii?Q?gbWZUabgH//C0uehyC9RAFAtt9iSkPo2B9wDO31M2hC2vNEsfsrQ1MJbejpT?=
 =?us-ascii?Q?FjHycCHnyk9s3RBqak0Td/XozSuUyeXmnDNl1vCxBuRIH/SUEKCvhLFWLq7v?=
 =?us-ascii?Q?3nW24IJYEPa+oOJ2dBa9nkhjMK5u85Vu/+z1ys5crJzJDc5C5fcCmQM3z/c8?=
 =?us-ascii?Q?HY7D9sAu1Ek2MpzuqOjLba2dDqo67uAQ0975km79HZ/3V2h625WO2DC3GM+V?=
 =?us-ascii?Q?u4vw8nv0vWBk12jR6FHCOzSDSPVCzqQItz42QlRaLFe8KLS7+5kjf7cVXAoW?=
 =?us-ascii?Q?bXdeubNhrJPxIBQQ4UBwDX9B7wTp3QhzjlAZrpNQeUbe+mamokNxGEKYxQxv?=
 =?us-ascii?Q?A9XNYjstEig8xXZsY7vXbNG121GMNBQjDf8rIavOIHl+aewSQyyeLpv99z9B?=
 =?us-ascii?Q?zmVYUhoqun5VuZSxgXR9cK36eZhCILT9DuqtJVTdM0pZO1ArQoa/0uT3SuZg?=
 =?us-ascii?Q?aNRb0/WEEC8jnAqNgrlJOR8FiWKMgnTqzQ6TMBFevXolotbfNEEnweIHtzbl?=
 =?us-ascii?Q?jdLlNScmknDiuKDMxH4HrHNSFUyyz0lyvI/Kvyye7pjdn1KnsNMYLCb9bWRt?=
 =?us-ascii?Q?tWN8Ran2NPlyrIJw712bxpUpHPJ79n/8Yhofa1nFNj7SjiLSsCoTHTS+W+JV?=
 =?us-ascii?Q?t1KwMQn8/QaEj7lijecViQmFWjl3QHjqlSkXvaEHoVfsyIyXQ+q8AwyczwM/?=
 =?us-ascii?Q?9dW2UMD0uHYj1IpJrLs0aTdj1L35shgBJ6s5bWrn90ppB/Hsm4tCFWfT7i43?=
 =?us-ascii?Q?KwXLj5Gq2NOH+P41/aP6C8kDCUNWNp+akfGZSc0KzPJNAP2kxt8V4o40Kju4?=
 =?us-ascii?Q?SHspK211quAJZu65Rogib2oyJ8V7ZMaGZj8XeTI9?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9185.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bdbbc860-cb32-4017-66bd-08dca5126468
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2024 21:09:19.1905
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: OMEIdynZz9gRBGxhEF9I35Iv9wavY8c9XrgREdJqbRMj7mCDSGg9Yhvv6CjR8qXn5oC3ZkEoauyxAW0pOSgFqA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10085



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Monday, July 15, 2024 3:47 PM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Wei Fang <wei.fang@nxp.com>; David S. Miller <davem@davemloft.net>;
> Eric Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>;
> Paolo Abeni <pabeni@redhat.com>; Clark Wang <xiaoning.wang@nxp.com>;
> Rasmus Villemoes <linux@rasmusvillemoes.dk>; imx@lists.linux.dev;
> netdev@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>
> Subject: [EXT] Re: [PATCH net-next] net: fec: Enable SOC specific rx-usec=
s
> coalescence default setting
> On Mon, Jul 15, 2024 at 02:54:49PM -0500, Shenwei Wang wrote:
> > The current FEC driver uses a single default rx-usecs coalescence
> > setting across all SoCs. This approach leads to suboptimal latency on
> > newer, high performance SoCs such as i.MX8QM and i.MX8M.
>=20
> Does ethtool -C work on these devices?
>=20

Yes, ethtool -C also works. This patch is to enable the proper default valu=
e so that=20
a user won't have to reconfigure it via ethtool.

> Interrupt coalescence is more than latency. It is also about CPU load.
>=20
> Does NAPI polling work correctly on these devices? If so, interrupts shou=
ld be
> disabled quite a bit, and then interrupt latency does not matter so much.
>=20
> Have you benchmarked CPU usage with this patch, for a range of traffic
> bandwidths and burst patterns. How does it differ?
>=20

The NAPI polling works correctly. The traffic bandwidth and CPU usage is=20
no notable impact during iperf testing.

> > 64 bytes from 192.168.0.195: icmp_seq=3D4 ttl=3D64 time=3D0.486 ms
> >
> > Fixes: df727d4547de ("net: fec: don't reset irq coalesce settings to
> > defaults on "ip link up"")
>=20
> Fixes is not correct here. It was never broken. This is maybe an optimisa=
tion,
> maybe a deoptimisation, depending on your use case.
>=20

Em, just an optimization.=20

Regards,
Shenwei

> And next-next is closed at the moment anyway.
>=20
>         Andrew


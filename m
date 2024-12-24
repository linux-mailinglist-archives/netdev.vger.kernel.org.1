Return-Path: <netdev+bounces-154169-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E12239FBDAB
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 13:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB52518828E2
	for <lists+netdev@lfdr.de>; Tue, 24 Dec 2024 12:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604391C5F25;
	Tue, 24 Dec 2024 12:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="PsmehJ/p"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2042.outbound.protection.outlook.com [40.107.20.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A827117D355;
	Tue, 24 Dec 2024 12:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735045021; cv=fail; b=MH+qTJebZcaeER5WKsLpgevOm20PbgMeU569urwzKg2BSyJXTDCdi4CxtdSJ+fgPpNnT4bh3QT+GhF53ff6BujjSiUME5tQtHkphw9BdB128iMQdkUoxknGKFHfa+rmkK/efooROuEx/VSnKA+SgYceycEcM2b/y9EeTz+j0YjA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735045021; c=relaxed/simple;
	bh=TMlScz+hklmYYConamXo5h4SrttVQ06B2u97gNcv8dg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FeaEdJu3APVHRMpJalFjU/kCtDFQrW/P3B3Zo45/CB8qJyxgDjlhkVZSiteJoX7nQXCNE+MomLR6MovFzTeXSgFwOsnbHfApe+N1nLu9tz0L3gUY6AWoqLC/Y6z/z91gAtDSjYr5zy4F+Hs1pb6KtidjYmpi1aQKo6oDuQnU3L0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=PsmehJ/p; arc=fail smtp.client-ip=40.107.20.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oOhD9y6DG67z7pglO/MAzIGfKcuoq7zh0wEnEr5w29qebLXFiaM0MBEu3Ce+50ihdIetn5zzSgO/x11fbWUiNoBsDznMh9EUTPBM+TOd/JA+D6Djvdldg5qV5fYdIwo8ljr+4Ov+tcsxOoCSXovDQMTPBCpVApN2nRw6nUCSC6rToCyIgimXUTgzw0aX+iYsh6uO/VAR/AHFjW8egxN3JPjUrWXN1c4NS67HqZeRIfdg8qKVDMb1BqPoxQ2V+IvcJCn260+3hSirvkPH+vFE7MFc1m63FTDC/Uk1WiV80s15iSp+u+9XU7wL80FY+hRecKycty6ZtPXRFBrwxFQejg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DUSjf8zaDjnmMkJf9vnmVMCMguLc0nHDBo+jY6uqF4=;
 b=sVuuA8z3LJXBDhq3r/wHauQazI+runys1KbaOpbSMzhrCg/kftWejT8JLBAInYckYRGCvNo+vq4MDjcgAB+kRya9TpfhrYO3WQliCT2JzkzV4rwn1XRLNygPqmt2kfen0boa/b7Qj5pXXiIfRiNdUBWfqqsGRpqRe2dyJsowKRyatt2GCWznpkmbdNaMBlyB6Sjj5gfFfPAmX+HjzK2fccH58S7L/KEGf0dGPbIR1fP/bv21jqG03zppUCg3/dlVD87uAeQ9vwqpvPfUPrrdamoIGJ8t9WhubiIML5vvJ6mFj1h0W/eToBf+6jkuFw3AcYfk/ZbGHWxVHTyVed0Q0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DUSjf8zaDjnmMkJf9vnmVMCMguLc0nHDBo+jY6uqF4=;
 b=PsmehJ/p2RlsKsakRn/KuR/mUnoohw+oGzGg7NwWGzQ75m4qH9G1ClMws+SkaI1UnLBafCsYaLk45qmCYq7asS/dyZaruF2u5PbhJdAJyWhaiynuZEH2TSTqXuVKvhJUyQ90zytXq9h+hCAKT0Kv8x+fFke6fLXo7hTpMklFYqWvqAWntzPYuKqtIrG39gZo26iMy8Ngi3GCPP9jpbJHdGb+wBOTgguPtjf5AoLZU5SBAA62Hy/5WwA7AQCOPVFgwCshb6ZoFx10l0UpFH1+wFmb6BRNL1hkgofoFlYx5Ll1jwbp8sg95clTYHEWrRowkrR4PYPYQCLMywb5pAK7OQ==
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com (2603:10a6:20b:40a::14)
 by DB9PR04MB9723.eurprd04.prod.outlook.com (2603:10a6:10:4ce::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8272.20; Tue, 24 Dec
 2024 12:56:50 +0000
Received: from AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868]) by AM9PR04MB8505.eurprd04.prod.outlook.com
 ([fe80::bb21:d7c8:f7f7:7868%4]) with mapi id 15.20.8272.013; Tue, 24 Dec 2024
 12:56:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Kevin Groeneveld <kgroeneveld@lenbrook.com>
CC: Kevin Groeneveld <kgroeneveld@lenbrook.com>, Shenwei Wang
	<shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] net: fec: handle page_pool_dev_alloc_pages error
Thread-Topic: [PATCH] net: fec: handle page_pool_dev_alloc_pages error
Thread-Index: AQHbVXTL9rxP31UEeUuKxD7ADuRne7L1H4Pw
Date: Tue, 24 Dec 2024 12:56:49 +0000
Message-ID:
 <AM9PR04MB85059A742116F7E57D0DC32288032@AM9PR04MB8505.eurprd04.prod.outlook.com>
References: <20241223195535.136490-1-kgroeneveld@lenbrook.com>
In-Reply-To: <20241223195535.136490-1-kgroeneveld@lenbrook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8505:EE_|DB9PR04MB9723:EE_
x-ms-office365-filtering-correlation-id: c142f74b-1385-4aad-2e3d-08dd241a6e8b
x-ld-processed: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?+L89e3DdtyVXSlKVciOAxuiIQQYL7iyE1hrnQR/vilLlicyzHtNrp6fpL1Vq?=
 =?us-ascii?Q?qsOjzNSMU02YuCEb+LEDK1RS3oje5icUBpnQPVLWDa/XBErMOzVBVKoMAeld?=
 =?us-ascii?Q?ctXS9lT/IYDcfOb6Qqf5MJxrlQdpOIdiyp6P8jxLhr5UAEdVrtoj1zyYREzt?=
 =?us-ascii?Q?q+Rcd2k9S6gyfL5mZE9s3AbKm9/NA19tRuHl3xhwJ0byn+2rmyOJgiWiyosR?=
 =?us-ascii?Q?zZxHU8sYddZtunzv1i0iTB8EsYtL63EyWXPIUQNL7yCz4GVTeUNiRdfExNFs?=
 =?us-ascii?Q?HACqT5UNuMWuTCUab5RPtHk6bFKqr3Hvta+UdQ1bzD5bypYwgcsz8yQBf9fI?=
 =?us-ascii?Q?d5AjN8cuIYpUHanYNdbHnGEAkk2mfNohxixyOFJnfn5xfhNU07M0A4/C12UG?=
 =?us-ascii?Q?gPNMLScLxu9QmfiQWKkuu1ypkM5Xb0Lc+yxs4Wv3Cx9om2g+g1BG3O09Z3+q?=
 =?us-ascii?Q?/+e7M4HPsSj9OnR864rt/n7JjEoxvZPcEElIZ6bSyYDm37w7irkIhYQX/YNW?=
 =?us-ascii?Q?6TTKSTj/zSA1jg5dZr6wmLDF30A4zuB1WBqJuDKnko5/yKQv4lrjkNoFzT73?=
 =?us-ascii?Q?qKs0tV212EJSYyl6X8VMUMVFH2jM5WpNpPRGja7i8HPlM8Ti8Lj7XWkNeXcD?=
 =?us-ascii?Q?7ZwpSXGCg0nmvYnPvlKQ+wFIxoc0GOX/nBvIUcYOeYFKgpn3j/u4kCV9TYGo?=
 =?us-ascii?Q?vX+T3/8OH5frXU895NregvYAnq0Scv08G1dfeCrJJVPVJj5jKThXQu09JJ2W?=
 =?us-ascii?Q?uzjdv06tEnYMlYvGxNjzmzRoHDrGdhFBcf7lg4mZRiLO5suQgAJTaf/nwThq?=
 =?us-ascii?Q?6XqyeT5zlFCebmKLR5iTZp9wtC7hM3lhMufQLsf30iw1N3oCwxVOt8v1eyXn?=
 =?us-ascii?Q?GHZxnOFxayLNep4Fk6Ftv6rY5TcIfXp131vNtmzr4XtmOVCanG1MKHfQ6gfp?=
 =?us-ascii?Q?+p8T+VWlY5giwIxC16BPNw/KSN5MOSnosu4t7i/4FDl2e3T8oRHqkIQ36D22?=
 =?us-ascii?Q?xAoPJ8Foe5aFi9GNAr19O6YvtcAVUM+H+CrzA+mEUFpiSeLk5Rwa/gdjpwUl?=
 =?us-ascii?Q?3M40ZR7rSmoKer6fTIIUxzok6OY9iP+/Mw5q9cuy+E6KV592QMWkrgqlmXrq?=
 =?us-ascii?Q?uqNs/QyVtFy8GYf/f//GFTOAIO+DMTKueDD+uYUakO7QHrHB9+9JfqaAeMSJ?=
 =?us-ascii?Q?8b/NsXkfmsK1ie1KwN6I+zDtqFyAGRPrWciFzlIqVTgnetvvXUcLeCQJN5Xg?=
 =?us-ascii?Q?BnMAAv84Za6h2+8msmDQryEvl6AXFFKgzReXkHK0YXWXZvL7P4wWvEjm2JLm?=
 =?us-ascii?Q?HTFHqaeCXwhGT1a8G9cAufxaG/KG/VuAwPV8V4bN0ZCAdhoTO6rR1Vth7EZg?=
 =?us-ascii?Q?+BOks7LxR0VcFYEgJU3NLmZD8M3nIPIRii0yHbuhzLIWa4gg2Iyeuvko7Bna?=
 =?us-ascii?Q?+CFSBdsOQiMHUGROZ1LtmS0VwShFazF+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8505.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?3ZTNd7qG7IBtcXphzxcrBj4BS6Z+OF9E2ovfPTTLEKjN+XtgAZ9CQ0nyH0J9?=
 =?us-ascii?Q?hF6gd7phqUxrpl2h5YuQZO1SOTighUqTwd2rmKfW3v5+3oP1oxGcnpbIsbvK?=
 =?us-ascii?Q?rkyKa0x5qKiQGxTyUQmNFEOAFpFu7uIK/bqPc5shOPld5rJqUpI5IR1rKWbw?=
 =?us-ascii?Q?ckVtBCztriWVP3ZHt+WHngdPRgLETvAUaTppCgcwom/LEAQKem+069QP+Qkk?=
 =?us-ascii?Q?y1SD0XyAx/ga1tYCeYhbf/qCNWHzlR1BFQ0AL+kvYSof0HV2M88BFUgbLXm2?=
 =?us-ascii?Q?83LEpZpK8wdnvJ4Azq5H4q1ztZaka5d+CThfmP4HMUbc4usagOgNoSJ4jS+7?=
 =?us-ascii?Q?qpyp7AM96N7mpDmTMGMhvV68beg7spsFyRzWlPFOnQlFNdSNAXJuAudWfRoz?=
 =?us-ascii?Q?cfc4g0k3V2//ykjHSvcU/bgwoV9gBdrbt/MmFhQ9xxdcc5L8ltStCDo8InU/?=
 =?us-ascii?Q?G6RM5Fas90IHYJnQjxI+5rIdfhxp3n3nXpl0bLjNYT+M9Hb545i7U8DSngII?=
 =?us-ascii?Q?XQ3jdONcrdFlcoz1aStZPT6suIs5kpO0yXbaTyFGpQikYdPP10070/7wZYQR?=
 =?us-ascii?Q?PVUJmwlzqhF5b6eYYiJzYEC2LGZff5K8D+R11ID7J8GZ3V4dh2RZjTY77B1o?=
 =?us-ascii?Q?8qegyZy0IIqLFTftmyZnpf0Pix80bnHjmXa1PUM2GIqqTfdBabRrKDRwpBAK?=
 =?us-ascii?Q?AWiwt2OPegReSAT4cCMzpAlRHDmCBPJ3Hv6ynLniC57/r5PMa/Prk7MsrAL/?=
 =?us-ascii?Q?nTXpqZ4Ak169TMX4Hx17qpe/+2tXhjTtnH7UpsAnabMm1DS+Op11P3R0CQpv?=
 =?us-ascii?Q?NChYYQHVF4lP5wgBNEY9uVqdt2g4W/dMHaeOp0WJJwI3SIDe0hQUpKfCCHoM?=
 =?us-ascii?Q?BiAz5fjAEX/1E9hwVhr5oNpSr9aXYUyTVZm1WoOThPrA8IM/RrhIlNYxDs31?=
 =?us-ascii?Q?vcbiyBy/xmTdVSUMqta1FqnL3HhbrC2+yNjUgryeOc16eNphCgPDEKT++Z9s?=
 =?us-ascii?Q?GFYSxqmrjXHZfB7q/vcy/qAzmAh+LO2/i5Z+LKq11ERTE6b9oLr0XVtbIPNu?=
 =?us-ascii?Q?cNqNK7IAVMhYrS+G2jz4ns7WuiGqvpTIU+S0lLsyN40dMfa5k8VmTuXEYFPF?=
 =?us-ascii?Q?3dtbSdQOmGT5lPROitOoGKOJGNtyGwSpnZULOJ7TC7Bz5ACS+JObSGNnGF3U?=
 =?us-ascii?Q?NcWNi1XzOb2UJCmi6m9PKifkp+rqetFKBfHMWUEGvtsqkBoEqnm9+KJapzsJ?=
 =?us-ascii?Q?4QsoE70GG1Gl2X6Knnio6okOuLd4OTg/rgnfgs8W1MzfhMNE3YZNKHqlQu5v?=
 =?us-ascii?Q?NE6P4HnSUWMJbGGjnUSXCZiORkuxv8niUV4qto1Y1mbNs9pL7poePDQA4I6i?=
 =?us-ascii?Q?P3Mbpag36uy1Py8FQXB1VGgc2tvgfyWIxFUIzsep+uA8aY62ed6dZuCNL3Ux?=
 =?us-ascii?Q?CCHsZjwT/Yho5xBXVsUK3dUHUV0eJwXWa0VM7HTIctdTkoFqIGzlt0GFmybj?=
 =?us-ascii?Q?IsvctegecMoPGoj9lv19zkuJNhdVlcLmBqcc94NK0W/CQb8rEdnEmd2B4vpe?=
 =?us-ascii?Q?NdVlW2aealg1M6JbwQw=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8505.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c142f74b-1385-4aad-2e3d-08dd241a6e8b
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Dec 2024 12:56:49.8570
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ERHQSJF6QQvYfiI/D4uXXzjpLWX9qO+/2zfFkHzn9bgQG0yrCmKzTn42evJ7oG7Uee6E3WdwOdHdt5D6KuAfrg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB9723

> The fec_enet_update_cbd function called page_pool_dev_alloc_pages but did
> not handle the case when it returned NULL. There was a
> WARN_ON(!new_page)
> but it would still proceed to use the NULL pointer and then crash.
>=20
> This case does seem somewhat rare but when the system is under memory
> pressure it can happen. One case where I can duplicate this with some
> frequency is when writing over a smbd share to a SATA HDD attached to an
> imx6q.
>=20
> Example kernel panic:

Please simplify the log, it's too long.

[  112.357543] Unable to handle kernel NULL pointer dereference at virtual =
address 00000010 when read
[  112.370145] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
[  112.397701] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
[  112.404233] PC is at fec_enet_rx_napi+0x394/0xba0
[  112.408949] LR is at fec_enet_rx_napi+0x37c/0xba0
[  112.650805] 1fe0: 81067700 80e6befc 90981df8 80122bd8 8013ebd0 80122c78 =
8013ebd0 807d07d0
[  112.658986] Call trace:
[  112.658992]  fec_enet_rx_napi from __napi_poll+0x28/0x148
[  112.666945]  __napi_poll from net_rx_action+0xf0/0x1f8
[  112.672107]  net_rx_action from handle_softirqs+0x19c/0x204
[  112.677703]  handle_softirqs from __irq_exit_rcu+0x60/0xa8

>=20
> [  112.154336] ------------[ cut here ]------------
> [  112.159015] WARNING: CPU: 0 PID: 30 at
> drivers/net/ethernet/freescale/fec_main.c:1584
> fec_enet_rx_napi+0x37c/0xba0
> [  112.169451] Modules linked in: nfnetlink caam_keyblob caam_jr
> rsa_generic mpi caamhash_desc caamalg_desc crypto_engine caam error
> etnaviv gpu_sched
> [  112.182764] CPU: 0 PID: 30 Comm: kswapd0 Not tainted
> 6.9.0-02044-gffb6ab7d6829 #1
> [  112.190261] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [  112.196794] Call trace:
> [  112.196806]  unwind_backtrace from show_stack+0x10/0x14
> [  112.204592]  show_stack from dump_stack_lvl+0x50/0x64
> [  112.209663]  dump_stack_lvl from __warn+0x70/0xc4
> [  112.214385]  __warn from warn_slowpath_fmt+0x98/0x118
> [  112.219463]  warn_slowpath_fmt from fec_enet_rx_napi+0x37c/0xba0
> [  112.225490]  fec_enet_rx_napi from __napi_poll+0x28/0x148
> [  112.230914]  __napi_poll from net_rx_action+0xf0/0x1f8
> [  112.236075]  net_rx_action from handle_softirqs+0x19c/0x204
> [  112.241672]  handle_softirqs from __irq_exit_rcu+0x60/0xa8
> [  112.247172]  __irq_exit_rcu from irq_exit+0x8/0x10
> [  112.251979]  irq_exit from call_with_stack+0x18/0x20
> [  112.256967]  call_with_stack from __irq_svc+0x98/0xc8
> [  112.262036] Exception stack(0x90981e00 to 0x90981e48)
> [  112.267100] 1e00: 8fdc4400 81067700 81067700 00000001 00000000
> 8fdc4400 81a85500 807fd414
> [  112.275288] 1e20: 00000102 81067700 80e6befc 90981e7c 90981e80
> 90981e50 8080113c 8013ebd0
> [  112.283470] 1e40: 200d0013 ffffffff
> [  112.286964]  __irq_svc from finish_task_switch+0x140/0x1f4
> [  112.292474]  finish_task_switch from __schedule+0x300/0x47c
> [  112.298072]  __schedule from schedule+0x38/0x60
> [  112.302625]  schedule from schedule_timeout+0x84/0xa4
> [  112.307699]  schedule_timeout from kswapd+0x29c/0x674
> [  112.312776]  kswapd from kthread+0xe4/0xec
> [  112.316893]  kthread from ret_from_fork+0x14/0x28
> [  112.321609] Exception stack(0x90981fb0 to 0x90981ff8)
> [  112.326669] 1fa0:                                     00000000
> 00000000 00000000 00000000
> [  112.334855] 1fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [  112.343038] 1fe0: 00000000 00000000 00000000 00000000 00000013
> 00000000
> [  112.349835] ---[ end trace 0000000000000000 ]---
> [  112.354483] 8<--- cut here ---
> [  112.357543] Unable to handle kernel NULL pointer dereference at virtua=
l
> address 00000010 when read
> [  112.366539] [00000010] *pgd=3D00000000
> [  112.370145] Internal error: Oops: 5 [#1] PREEMPT SMP ARM
> [  112.375468] Modules linked in: nfnetlink caam_keyblob caam_jr
> rsa_generic mpi caamhash_desc caamalg_desc crypto_engine caam error
> etnaviv gpu_sched
> [  112.388734] CPU: 0 PID: 30 Comm: kswapd0 Tainted: G        W
> 6.9.0-02044-gffb6ab7d6829 #1
> [  112.397701] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [  112.404233] PC is at fec_enet_rx_napi+0x394/0xba0
> [  112.408949] LR is at fec_enet_rx_napi+0x37c/0xba0
> [  112.413661] pc : [<805355e8>]    lr : [<805355d0>]    psr: 600d0113
> [  112.419934] sp : 90801e68  ip : 00000000  fp : 00000000
> [  112.425163] r10: 8fe2b740  r9 : 000005f0  r8 : 00000000
> [  112.430393] r7 : 8133830c  r6 : 8e740820  r5 : 81338000  r4 :
> 810cf000
> [  112.436927] r3 : 00000100  r2 : 81067700  r1 : 80e6d4b8  r0 :
> 00000000
> [  112.443461] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM
> Segment none
> [  112.450605] Control: 10c5387d  Table: 11d3004a  DAC: 00000051
> [  112.456355] Register r0 information: NULL pointer
> [  112.461072] Register r1 information: non-slab/vmalloc memory
> [  112.466742] Register r2 information: slab task_struct start 81067700
> pointer offset 0 size 2176
> [  112.475469] Register r3 information: non-paged memory
> [  112.480528] Register r4 information: slab kmalloc-4k start 810cf000
> pointer offset 0 size 4096
> [  112.489164] Register r5 information: slab kmalloc-4k start 81338000
> pointer offset 0 size 4096
> [  112.497800] Register r6 information: 0-page vmalloc region starting at
> 0x8e400000 allocated at iotable_init+0x0/0xe8
> [  112.508349] Register r7 information: slab kmalloc-4k start 81338000
> pointer offset 780 size 4096
> [  112.517158] Register r8 information: NULL pointer
> [  112.521871] Register r9 information: non-paged memory
> [  112.526930] Register r10 information: non-slab/vmalloc memory
> [  112.532685] Register r11 information: NULL pointer
> [  112.537484] Register r12 information: NULL pointer
> [  112.542283] Process kswapd0 (pid: 30, stack limit =3D 0x3ca59c34)
> [  112.548211] Stack: (0x90801e68 to 0x90802000)
> [  112.552578] 1e60:                   8fdc4400 8fdc4440 8105aa80
> 00000000 00000000 00000000
> [  112.560764] 1e80: 00000000 00000000 8fdc4440 00000000 00000016
> 00000040 00000000 80147414
> [  112.568950] 1ea0: 00000102 8105aa80 00000000 810cf5c0 00000006
> 00000000 8fdc4400 810cf6a0
> [  112.577135] 1ec0: 90801eec 8014037c 00000100 00000000 00000040
> 00000040 00000000 80d49400
> [  112.585320] 1ee0: 00000000 00000001 81067700 90801f2c 00000101
> 0f07b000 00000001 80e0a240
> [  112.593506] 1f00: 81338c40 800d0193 00001000 00000000 8fdc4080
> 810cf6a0 00000001 00000040
> [  112.601692] 1f20: 90801f67 810cf6a0 00000000 0000012c 90801f70
> 8065ec7c 810cf6a0 90801f67
> [  112.609877] 1f40: 90801f68 8fdc4fc0 80d49fc0 0f07b000 90801f68
> 8065efd4 ffffb6a1 80e02d40
> [  112.618063] 1f60: a00d0193 00000015 90801f68 90801f68 90801f70
> 90801f70 81a5232c 80e0208c
> [  112.626248] 1f80: 00000008 00220840 80e02080 81067700 0000000a
> 00000101 80e02080 801229d8
> [  112.634434] 1fa0: 80d47510 80197904 ffffb6a0 00000004 00000000
> 80d48c80 80e02d40 80d48c80
> [  112.642620] 1fc0: 40000003 00000003 f4000100 8013ebd0 200d0013
> ffffffff 90981e34 00000102
> [  112.650805] 1fe0: 81067700 80e6befc 90981df8 80122bd8 8013ebd0
> 80122c78 8013ebd0 807d07d0
> [  112.658986] Call trace:
> [  112.658992]  fec_enet_rx_napi from __napi_poll+0x28/0x148
> [  112.666945]  __napi_poll from net_rx_action+0xf0/0x1f8
> [  112.672107]  net_rx_action from handle_softirqs+0x19c/0x204
> [  112.677703]  handle_softirqs from __irq_exit_rcu+0x60/0xa8
> [  112.683205]  __irq_exit_rcu from irq_exit+0x8/0x10
> [  112.688009]  irq_exit from call_with_stack+0x18/0x20
> [  112.692996]  call_with_stack from __irq_svc+0x98/0xc8
> [  112.698066] Exception stack(0x90981e00 to 0x90981e48)
> [  112.703129] 1e00: 8fdc4400 81067700 81067700 00000001 00000000
> 8fdc4400 81a85500 807fd414
> [  112.711315] 1e20: 00000102 81067700 80e6befc 90981e7c 90981e80
> 90981e50 8080113c 8013ebd0
> [  112.719499] 1e40: 200d0013 ffffffff
> [  112.722994]  __irq_svc from finish_task_switch+0x140/0x1f4
> [  112.728501]  finish_task_switch from __schedule+0x300/0x47c
> [  112.734098]  __schedule from schedule+0x38/0x60
> [  112.738650]  schedule from schedule_timeout+0x84/0xa4
> [  112.743721]  schedule_timeout from kswapd+0x29c/0x674
> [  112.748795]  kswapd from kthread+0xe4/0xec
> [  112.752910]  kthread from ret_from_fork+0x14/0x28
> [  112.757626] Exception stack(0x90981fb0 to 0x90981ff8)
> [  112.762685] 1fa0:                                     00000000
> 00000000 00000000 00000000
> [  112.770870] 1fc0: 00000000 00000000 00000000 00000000 00000000
> 00000000 00000000 00000000
> [  112.779054] 1fe0: 00000000 00000000 00000000 00000000 00000013
> 00000000
> [  112.785676] Code: e0275793 e3a03c01 e5878020 e587301c (e5983010)
> [  112.791907] ---[ end trace 0000000000000000 ]---
> [  112.796535] Kernel panic - not syncing: Fatal exception in interrupt
> [  112.802897] ---[ end Kernel panic - not syncing: Fatal exception in
> interrupt ]---
>=20
> When I first encountered this issue on newer kernels I did a bisect to tr=
y
> to find exactly when it started. My bisect led me to c0a242394cb9 ("mm,
> page_alloc: scale the number of pages that are batch allocated"). But
> this commit does not seem to be the true problem and just makes the bug
> in the fec driver more likely to be encountered.

I think the above description is unnecessary as it is irrelevant to the iss=
ue.

>=20
> Setting /proc/sys/vm/min_free_kbytes to higher values also seems to solve
> the problem for my test case. But it still seems wrong that the fec drive=
r
> ignores the memory allocation error and crashes.
>=20
> Fixes: 95698ff6177b5 ("net: fec: using page pool to manage RX buffers")
> Signed-off-by: Kevin Groeneveld <kgroeneveld@lenbrook.com>
> ---
>  drivers/net/ethernet/freescale/fec.h      |  2 ++
>  drivers/net/ethernet/freescale/fec_main.c | 38 ++++++++++++-----------
>  2 files changed, 22 insertions(+), 18 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec.h
> b/drivers/net/ethernet/freescale/fec.h
> index 1cca0425d493..ce44d4f2a798 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -618,6 +618,8 @@ struct fec_enet_private {
>  	struct fec_enet_priv_tx_q *tx_queue[FEC_ENET_MAX_TX_QS];
>  	struct fec_enet_priv_rx_q *rx_queue[FEC_ENET_MAX_RX_QS];
>=20
> +	bool rx_err_nomem;
> +
>  	unsigned int total_tx_ring_size;
>  	unsigned int total_rx_ring_size;
>=20
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index 1b55047c0237..81832e0940bb 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -1591,21 +1591,6 @@ static void fec_enet_tx(struct net_device *ndev,
> int budget)
>  		fec_enet_tx_queue(ndev, i, budget);
>  }
>=20
> -static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
> -				struct bufdesc *bdp, int index)
> -{
> -	struct page *new_page;
> -	dma_addr_t phys_addr;
> -
> -	new_page =3D page_pool_dev_alloc_pages(rxq->page_pool);
> -	WARN_ON(!new_page);
> -	rxq->rx_skb_info[index].page =3D new_page;
> -
> -	rxq->rx_skb_info[index].offset =3D FEC_ENET_XDP_HEADROOM;
> -	phys_addr =3D page_pool_get_dma_addr(new_page) +
> FEC_ENET_XDP_HEADROOM;
> -	bdp->cbd_bufaddr =3D cpu_to_fec32(phys_addr);
> -}
> -
>  static u32
>  fec_enet_run_xdp(struct fec_enet_private *fep, struct bpf_prog *prog,
>  		 struct xdp_buff *xdp, struct fec_enet_priv_rx_q *rxq, int cpu)
> @@ -1697,7 +1682,7 @@ fec_enet_rx_queue(struct net_device *ndev, int
> budget, u16 queue_id)
>  	u32 data_start =3D FEC_ENET_XDP_HEADROOM;
>  	int cpu =3D smp_processor_id();
>  	struct xdp_buff xdp;
> -	struct page *page;
> +	struct page *page, *new_page;
>  	u32 sub_len =3D 4;
>=20
>  #if !defined(CONFIG_M5272)
> @@ -1759,6 +1744,16 @@ fec_enet_rx_queue(struct net_device *ndev, int
> budget, u16 queue_id)
>  			goto rx_processing_done;
>  		}
>=20
> +		/* Make sure we can allocate a new page before we start
> +		 * processing the next frame so we can still more easily abort.
> +		 */
> +		new_page =3D page_pool_dev_alloc_pages(rxq->page_pool);
> +		if (unlikely(!new_page)) {
> +			fep->rx_err_nomem =3D true;
> +			pkt_received--;
> +			goto rx_nomem;
> +		}
> +
>  		/* Process the incoming frame. */
>  		ndev->stats.rx_packets++;
>  		pkt_len =3D fec16_to_cpu(bdp->cbd_datlen);
> @@ -1771,7 +1766,11 @@ fec_enet_rx_queue(struct net_device *ndev, int
> budget, u16 queue_id)
>  					pkt_len,
>  					DMA_FROM_DEVICE);
>  		prefetch(page_address(page));
> -		fec_enet_update_cbd(rxq, bdp, index);
> +
> +		/* Update cbd with new page. */
> +		rxq->rx_skb_info[index].page =3D new_page;
> +		rxq->rx_skb_info[index].offset =3D FEC_ENET_XDP_HEADROOM;
> +		bdp->cbd_bufaddr =3D
> cpu_to_fec32(page_pool_get_dma_addr(new_page) +
> FEC_ENET_XDP_HEADROOM);
>=20
>  		if (xdp_prog) {
>  			xdp_buff_clear_frags_flag(&xdp);
> @@ -1883,6 +1882,7 @@ fec_enet_rx_queue(struct net_device *ndev, int
> budget, u16 queue_id)
>  		 */
>  		writel(0, rxq->bd.reg_desc_active);
>  	}
> +rx_nomem:
>  	rxq->bd.cur =3D bdp;
>=20
>  	if (xdp_result & FEC_ENET_XDP_REDIR)
> @@ -1943,10 +1943,12 @@ static int fec_enet_rx_napi(struct napi_struct
> *napi, int budget)
>  	struct fec_enet_private *fep =3D netdev_priv(ndev);
>  	int done =3D 0;
>=20
> +	fep->rx_err_nomem =3D false;
> +
>  	do {
>  		done +=3D fec_enet_rx(ndev, budget - done);
>  		fec_enet_tx(ndev, budget);
> -	} while ((done < budget) && fec_enet_collect_events(fep));
> +	} while ((done < budget) && !fep->rx_err_nomem &&
> fec_enet_collect_events(fep));

Is the condition "!fep->rx_err_nomem" necessary here? If not, then there
is no need to add this variable to fec_enet_private.

One situation I am concerned about is that when the issue occurs, the Rx
rings are full. At the same time, because the 'done < budget' condition is
met, the interrupt mode will be used to receive the packets. However,
since the Rx rings are full, no Rx interrupt events will be generated. This
means that the packets on the Rx rings may not be received by the CPU
for a long time unless Tx interrupt events are generated.

>=20
>  	if (done < budget) {
>  		napi_complete_done(napi, done);
> --
> 2.43.0
>=20
> I am not confident this patch is correct as my knowledge of napi and the
> fec driver is limited. Even if all my assumptions are correct I still do
> not entirely like this patch with how it propagates the error state via a
> variable I added to fec_enet_private. But I could not think of any other
> way that did not involve more significant changes to the existing code an=
d
> I did not want to spend too much time on it until I am more sure the
> overall concept is acceptable. Suggestions welcome.

Another approach is to discard the packets when the issue occurs, as
shown below. Note that the following modification has not been verified.

-static void fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
+static int fec_enet_update_cbd(struct fec_enet_priv_rx_q *rxq,
                                struct bufdesc *bdp, int index)
 {
        struct page *new_page;
        dma_addr_t phys_addr;

        new_page =3D page_pool_dev_alloc_pages(rxq->page_pool);
-       WARN_ON(!new_page);
+       if (unlikely(!new_page))
+               return -ENOMEM;
+
        rxq->rx_skb_info[index].page =3D new_page;

        rxq->rx_skb_info[index].offset =3D FEC_ENET_XDP_HEADROOM;
        phys_addr =3D page_pool_get_dma_addr(new_page) + FEC_ENET_XDP_HEADR=
OOM;
        bdp->cbd_bufaddr =3D cpu_to_fec32(phys_addr);
+
+       return 0;
 }

 static u32
@@ -1771,7 +1775,10 @@ fec_enet_rx_queue(struct net_device *ndev, int budge=
t, u16 queue_id)
                                        pkt_len,
                                        DMA_FROM_DEVICE);
                prefetch(page_address(page));
-               fec_enet_update_cbd(rxq, bdp, index);
+               if (fec_enet_update_cbd(rxq, bdp, index)) {
+                       ndev->stats.rx_dropped++;
+                       goto rx_processing_done;
+               }

                if (xdp_prog) {
                        xdp_buff_clear_frags_flag(&xdp);


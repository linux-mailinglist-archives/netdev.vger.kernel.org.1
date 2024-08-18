Return-Path: <netdev+bounces-119498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C0F0955E93
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 20:54:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D70E1C20949
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 18:54:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D6F145B26;
	Sun, 18 Aug 2024 18:54:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="dEcf4AU4"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11011038.outbound.protection.outlook.com [52.101.65.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F1F38DE4;
	Sun, 18 Aug 2024 18:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.38
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724007247; cv=fail; b=SJyKIDyJUMEYMZ4rCTjXzwX5XPOXKp6xHvPZ6H+e+WAMLAM0UPctOgtn3+o03mNtq8o37tI60/3TaxXZlrQawu9inC6AhFF2NKfrFa2R5TfYigLaLYMGviCVYpNHDZhRBQYZZh+OLo81nB8Tj+zy/qDd4Oms0X9LkjExTPzwpQY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724007247; c=relaxed/simple;
	bh=FxSlmckkvw3e/EDhsXjW1N14j5sq1830KWFV//pGRjI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PtFeEwUkIiMsSXsaexCQLF6gpRJHrzsoebUJtxFb8v8WiUFvp3o2Cy/jkwIZ71sOd2aym5bEBLpPykKSLnLdYJhEi5Z8Ml0dGXJsZD2FlEOfQhBHg95WOvO/kZJhFHaLMRX9S5HdCgQ9/mZSiuZmjPGc0QQ2geF07JvuDmNZpWc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=dEcf4AU4; arc=fail smtp.client-ip=52.101.65.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZd3Mex1TBOCQMw54AnifSbg0dgfeDihEwVT3KdwD2E2RYd48m81xpf3tI3Okg685QBHFHb+7F30RjTiz7y2hWRzYkWbBTbjKZGovmW+hdbh64k0uhszN8mrS7d+aV5oT6BaaUw1KPr0s3Eft6pfG959TgpCJ5BAAC00pjqLQoz2sEahKOm80gCyjgiLhiMm8DN3FIyPEVqgKhBMItP+jEem4OxiogDB3n1p8OQZVsvjBtSe9LV9l9LSUImjjsFs5PCZpNUvd/szXF127srvU/emntvxbSKg6gVij+oDAJ43uHgqiLS2hheTouzkPPrfjK59QtRQ9ZdF6wDnC7xr5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aR/jfSROt/yzSrGVDOGnHh2w32M5ghWZCSkddexD9Rg=;
 b=sNQIhE/iQj2F32gQ+aJh/6wXX1AWCZbLhbKCgIZ89EUkcoVVqA6n9rjLRI/QLXad87hxHnKAmfL+QVSNjyO+zFJbvFhaWYpN+jbrPCiFw6WNLSi2w8F2jZNhXkkyb7MxbP9Cj4cv0PtjlMrlYcNf837FhI4Z4aNIVlL30p4ZtV0khaFPINt79kO1d7HHuJFdGqc55n4GVaZ/dTElLgnVGL9e+D2nkCbdWJP9nWnwMy6/lveaUD2s6qLd+vFJXOCmuQI2kaP7A+RH8Zl13qcg8CyG9Ez5+aMBu19aebWkIuguaaSQgvzr+h6/+5eYSGt2eewSJNmZuKsYJtKVKpEWVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aR/jfSROt/yzSrGVDOGnHh2w32M5ghWZCSkddexD9Rg=;
 b=dEcf4AU4YB++2jhO3IwkjnTmURqEsIdPXfComISfM+6ErsY2KgZfIppisxUu0cpeRzXcZB2RqMdMNXMNeSyTzncuEEOAX5Zvxmqe5dodBygWk7OcFzzcCzFrUTzUV93iq0gaCiv+/N+7VZbCaQXQHSjMIRXseu8awoRN0G2O2oshad4SAHUcztKBuEpxaiAlGQNsT7xJprgBQV9On2ChgNdkoEms/AFv6pj8N4w+6+nOxsYhMOGxiz/Whoe3CjTxlolS1FP7td/ycDJ/mUqymIT57L8LxVAGxBDvSehdlbW0zysZFx3TWg563aPMbK8ET43TaKRhN6R9I7S/e2mqWQ==
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 by DB9PR04MB8300.eurprd04.prod.outlook.com (2603:10a6:10:243::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Sun, 18 Aug
 2024 18:54:02 +0000
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27]) by AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27%4]) with mapi id 15.20.7875.019; Sun, 18 Aug 2024
 18:54:01 +0000
From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
To: Serge Semin <fancer.lancer@gmail.com>, "Jan Petrous (OSS)"
	<jan.petrous@oss.nxp.com>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, dl-S32 <S32@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH 2/6] net: stmmac: Expand clock rate variables
Thread-Topic: [PATCH 2/6] net: stmmac: Expand clock rate variables
Thread-Index: AQHa8Z/9XwPuf/W0m0+yr5eu+Cgo+A==
Date: Sun, 18 Aug 2024 18:54:01 +0000
Message-ID:
 <AM9PR04MB8506994625600CA8C4727CFAE2832@AM9PR04MB8506.eurprd04.prod.outlook.com>
References:
 <AM9PR04MB85062693F5ACB16F411FD0CFE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <ciueb72cjvfkmo3snnb5zcrfqtbum5x54kgurkkouwe6zrdrjj@vi54y7cczow3>
In-Reply-To: <ciueb72cjvfkmo3snnb5zcrfqtbum5x54kgurkkouwe6zrdrjj@vi54y7cczow3>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8506:EE_|DB9PR04MB8300:EE_
x-ms-office365-filtering-correlation-id: ebc29db0-1c53-4b32-0c3b-08dcbfb7202c
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?2FBCBHb7blN/YDOYT1Dp/3KbPnhIwlLTXSfWvCmZgyvgWfKrSfKbPU27GYNB?=
 =?us-ascii?Q?u7nJGaOaupVVXWDsevou7gu6Lup+rT4WdgIdOpnQSviz3jkrqbY4WhX/B5d8?=
 =?us-ascii?Q?cCRajSSy9C41pWOqTPEymRIlqvAqw4qsJEdBLXqCw6r/+TfjE4SOBGW/zlWb?=
 =?us-ascii?Q?nHFSfKzexVYaSEIMNjI6uvGZmFoJ+RRxUE9VbhvCkZR1+NBI04SeoqO4yN2w?=
 =?us-ascii?Q?NTxED/60Ghaef5/Dot9Mw7+AONCB1ZhgqCD5Pc6zOe2j3WQ2dMbry7OyWHyB?=
 =?us-ascii?Q?wHNw+2xE/Ol7pLrOwS5OsDuPNs/uiqaPEyiz6x+OjUi1t8OJcpsFc0uOoR38?=
 =?us-ascii?Q?OHbWB8T8BCcykPmTrurwDtDoNCxXIBBC/HlPydWhyUKfifF0unPC708ZZoWg?=
 =?us-ascii?Q?wp1/f/AfImaycSKuKcaO8ANjqEwd/RxIrM9bhQPdpWFqtH86bqAA6zGOGZvT?=
 =?us-ascii?Q?2kuwZdeX/0tnTRWkLaaBh2/EkMd3JJFIcrFsbg8UymnfwXNUMMzC/Tk6jzly?=
 =?us-ascii?Q?Eg/j59tD4yTYNYaI5h6eoWra7w+tbV2WqZ7dvh/TQIoe9gyyjlZfHlL4THyK?=
 =?us-ascii?Q?rYpFRqyEKTNwfBO1JuQMIKxw2Z3RmiYyO9kgmaH7t3PLJl1WYrTHFxwqSUW4?=
 =?us-ascii?Q?RaTSaNNKRefGnFLV+PCgnMbn79bs3U/U7UCJb/wFf8PuNZEzG1qvmcKy4mRD?=
 =?us-ascii?Q?l+JYArt224IgNWjlg7edyeK5fF4+TD66374G3CjZ+XjHQ53pJ6X6FstZb1c2?=
 =?us-ascii?Q?mOXVcq/s1yqloXVdroP7GjcKzbPMQxZzYpeaJLAlWKpQ7aZgnOXCc8I9i0CJ?=
 =?us-ascii?Q?9vAsinmaC0WqMd3XplfKvKzmMA2sP6j1ZgUbbNAdlTSjwMdbiv4T89zBnhG3?=
 =?us-ascii?Q?2gm9IJT5zh7hS9f3MD2ixGtFD7r1BmgXb7RnZsiJt4ZtJ0t5i/1vzPhiC6tG?=
 =?us-ascii?Q?DKzP8aVbAdhSgm7kkTFsOGIkLI/l0Ijz0H+0p0D/Qt3DCXYvbBw5W9ql/KSX?=
 =?us-ascii?Q?sBhStDsncM0991eZ9YH3OIh6yxAqQLNncLweDbvz+VQ2OwkmZicSqrVg5Fxf?=
 =?us-ascii?Q?FBlm1rC2zSHLPVRY4zlO36gC1mLhotHXpGTtjkouaAA8RrHtd4pk6JkrBUD7?=
 =?us-ascii?Q?Sz9yC2iho8HFbF2I6e/rQFGRM1WxlQej8YcLV04xPkK2aGtX8OBV2IAwvQma?=
 =?us-ascii?Q?y7fkcJr0/Re9/uLwR/X9WQ6il+CrLeEiBbGqf3MqtEM3zG/NilPMv1keT2t2?=
 =?us-ascii?Q?ArZ3OwuIGYyLlE2SWfNWfCALNZQZCk5oz5GfYXuaitmv5UKODvDG90ulDOse?=
 =?us-ascii?Q?bw3WKIY/NFKT7k7rIeGf46DY96OnDX5bvld6tRbGLPRcuSfE4p0iPxb+mYwP?=
 =?us-ascii?Q?gmGV9m+xHl3OA0KGcomJ2nkS+uX1z3EEDfuE2+yiBDNOQsSVEg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8506.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?w4hZRr/xS0FsJTPW97P5v7/W+ReuDCuzpyeUP2oi9mlKjXUS27qijBElMgMq?=
 =?us-ascii?Q?Mm9tJZY4rbIkkrBXxUev7FyKmREe6+A5nqZJKn6qw/2FBVp+lWxHtdJFMf7C?=
 =?us-ascii?Q?F9K/fdDO4XoOzmAetuKdNNEoYlGB6uEC22io4BFUw5riq+rThKeIchXp6O5q?=
 =?us-ascii?Q?wIYwhK7WzhZBj3EHXuj/j8eXzAd/IlbF4NLVvg80G7aPz4lfsFugSf0aOa8q?=
 =?us-ascii?Q?QF70i84yyki2jHsW8pdrfMdS7KtBMuEMEpWBMzvYB8+7hxmjmPX3P673abqf?=
 =?us-ascii?Q?in2eAucPQh6vT2y/f4DliTcHk1/9OtERB7YRdMZDtSK4FiLdJKGGxBRNHfB/?=
 =?us-ascii?Q?9zWU8JHLyD2bhZzJEes9gz3KxzESaSZEg35OQ6VGuvVX5/FnJ8GFnO8xqmlm?=
 =?us-ascii?Q?zyKlz0S8vom6w39Mr3yevi2gpHZdIj+8Y+QzPqKyXnA03xwnmXdUJbeP60uH?=
 =?us-ascii?Q?VnLmMQpNjFtWZNiUpsHHcFHocSdGA86VnHV0KAtZEIrTdJose2rw2iISjLmu?=
 =?us-ascii?Q?efSkN+OPEiJf6K3iLQdmwDh0iKcmkdeA5TPhC8VXOp/wK9JYGAL6vAuRCdv9?=
 =?us-ascii?Q?aJQh2YbHrTylj75bPC7ULg3cG3Xykaaiq86WiMAaif9AizwhZitoLtey642/?=
 =?us-ascii?Q?v6CVgRpjGj/SmvXV/RSn92UJsgXt6rcFD/h5cxa9dCyyqRAqUjoBQszqeMjH?=
 =?us-ascii?Q?8eXyG7aN8WXNHuP1hwlH8RU9WBHHK2EsHj6JDSBZrGos6aDYcWZuC+SZkcJK?=
 =?us-ascii?Q?jLKXRpEMHKFf3MjQL28qud2ebQ8eGF9S7G5UtOSZdaLieRHDv1om/WIbZyfq?=
 =?us-ascii?Q?tGNz+6YkXw/wcJaj2yLtmVzoDZPERRye+v8vreVWEEpI7/L7mkzsDLUkLb2C?=
 =?us-ascii?Q?L6X57Xn7xlF1ZKpxobvTxvsSEoIXLk84bkQijdB0eInQU98PIjqk4Eu5mq8Z?=
 =?us-ascii?Q?bTm/796+hA8oqupH6Nf5CsRXc/H1CyleRflJKpGPNtsWpuEIAfxVeZ8jaz0T?=
 =?us-ascii?Q?MIQf605mxTWNf++Tnat7d/ZTxW0AVXDI/Pra9c6QF233bX7h1oPDNiEZoTjT?=
 =?us-ascii?Q?TJKiOHU1evOHSLnM88BUSQEKKUkcJ44CQpfeEtOR7vcB/2TLEskTW/Y/pyks?=
 =?us-ascii?Q?2A57BZyY7nlAggsg1BAVn+ujcNVhW3a/JolcFx5CsuHfWub4U+t5Jkt+3hQ/?=
 =?us-ascii?Q?/VKq7zbmDymZaj3mWo58sJb3URsszDyb1F+vJxnb959U9bqb91wWc4dhJk+S?=
 =?us-ascii?Q?4Y2Q2KwbrAPAoy3oJEzO2hcveiYueG/NKdzxsfknn5YM0ShvyfFgzSkcJJJx?=
 =?us-ascii?Q?k/vQfIW9x0JJ5Zr9AS2KvoHDyMS25gtyXtj6zlJ3TyU0qmxcwZ/CYtYs9tzq?=
 =?us-ascii?Q?2UBoJV9lrVsqr6wchyOqYnL2oc2qq0mwBKJbbz9mICiGDax0UAPKVZ1MbFjE?=
 =?us-ascii?Q?9j3Bh7ZxcbC9cJM8efxQNURWj0G3W113cL/YB6o2hVArkY4XoJfvqNcTpSTM?=
 =?us-ascii?Q?kQiOWS8fl802o1sPP+tFUCpJL+8Fh922ANjlLd8gjuFVZB5tMKanIld4IV3b?=
 =?us-ascii?Q?vCLNcTjJzuaj/Dv+qbppwn6yWbL8a9RO/USPrc6x?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8506.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebc29db0-1c53-4b32-0c3b-08dcbfb7202c
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2024 18:54:01.8823
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: l/a+VDNQ34WYOIDEpeKCe382cpvUSrgzUWQaEUJODJjw0HLK33ufJShg4BAYAj/vbhAXqMqILAe8lz61Y8YOWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8300

> -----Original Message-----
> From: Serge Semin <fancer.lancer@gmail.com>
> Sent: Tuesday, 6 August, 2024 12:18
> To: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; dl-S32 <S32@nxp.com>; linux-
> kernel@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com; linux-
> arm-kernel@lists.infradead.org; Claudiu Manoil <claudiu.manoil@nxp.com>;
> netdev@vger.kernel.org
> Subject: Re: [PATCH 2/6] net: stmmac: Expand clock rate variables
>=20
> On Sun, Aug 04, 2024 at 08:49:49PM +0000, Jan Petrous (OSS) wrote:
> > The clock API clk_get_rate() returns unsigned long value.
> > Expand affected members of stmmac platform data.
> >
> > Signed-off-by: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
>=20
> Since you are fixing this anyway, please convert the
> stmmac_clk_csr_set() and dwmac4_core_init() methods to defining the
> unsigned long clk_rate local variables.

OK, will add it to v2.

>=20
> After taking the above into account feel free to add:
> Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
>=20
> -Serge(y)
>=20
> > ---
> >  drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c | 2 +-
> >  drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c   | 2 +-
> >  include/linux/stmmac.h                                  | 6 +++---
> >  3 files changed, 5 insertions(+), 5 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > index 901a3c1959fa..2a5b38723635 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-qcom-ethqos.c
> > @@ -777,7 +777,7 @@ static void ethqos_ptp_clk_freq_config(struct
> stmmac_priv *priv)
> >  		netdev_err(priv->dev, "Failed to max out clk_ptp_ref: %d\n",
> err);
> >  	plat_dat->clk_ptp_rate =3D clk_get_rate(plat_dat->clk_ptp_ref);
> >
> > -	netdev_dbg(priv->dev, "PTP rate %d\n", plat_dat->clk_ptp_rate);
> > +	netdev_dbg(priv->dev, "PTP rate %lu\n", plat_dat->clk_ptp_rate);
> >  }
> >
> >  static int qcom_ethqos_probe(struct platform_device *pdev)
> > diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > index ad868e8d195d..b1e4df1a86a0 100644
> > --- a/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > +++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_platform.c
> > @@ -639,7 +639,7 @@ stmmac_probe_config_dt(struct platform_device
> *pdev, u8 *mac)
> >  		dev_info(&pdev->dev, "PTP uses main clock\n");
> >  	} else {
> >  		plat->clk_ptp_rate =3D clk_get_rate(plat->clk_ptp_ref);
> > -		dev_dbg(&pdev->dev, "PTP rate %d\n", plat->clk_ptp_rate);
> > +		dev_dbg(&pdev->dev, "PTP rate %lu\n", plat->clk_ptp_rate);
> >  	}
> >
> >  	plat->stmmac_rst =3D devm_reset_control_get_optional(&pdev->dev,
> > diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
> > index 7caaa5ae6674..47a763699916 100644
> > --- a/include/linux/stmmac.h
> > +++ b/include/linux/stmmac.h
> > @@ -279,8 +279,8 @@ struct plat_stmmacenet_data {
> >  	struct clk *stmmac_clk;
> >  	struct clk *pclk;
> >  	struct clk *clk_ptp_ref;
> > -	unsigned int clk_ptp_rate;
> > -	unsigned int clk_ref_rate;
> > +	unsigned long clk_ptp_rate;
> > +	unsigned long clk_ref_rate;
> >  	unsigned int mult_fact_100ns;
> >  	s32 ptp_max_adj;
> >  	u32 cdc_error_adj;
> > @@ -292,7 +292,7 @@ struct plat_stmmacenet_data {
> >  	int mac_port_sel_speed;
> >  	int has_xgmac;
> >  	u8 vlan_fail_q;
>=20
> > -	unsigned int eee_usecs_rate;
> > +	unsigned long eee_usecs_rate;
>=20
> Sigh... One another Intel clumsy stuff: this field is initialized by
> the Intel glue-drivers and utilized in there only. Why on earth has it
> been added to the generic plat_stmmacenet_data structure?.. The
> only explanation is that the Intel developers were lazy to refactor
> the glue-driver a bit so the to be able to reach the platform data at
> the respective context.

I guess it is home work for Intel developers, right?

Thanks for review.
/Jan


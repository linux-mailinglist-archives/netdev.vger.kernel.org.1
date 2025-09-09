Return-Path: <netdev+bounces-221053-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9D7EB49F6B
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 04:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F89F4E39BB
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 02:53:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15C0256C70;
	Tue,  9 Sep 2025 02:52:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="RJFcCwlz"
X-Original-To: netdev@vger.kernel.org
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011055.outbound.protection.outlook.com [40.107.130.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6081D61BB;
	Tue,  9 Sep 2025 02:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757386376; cv=fail; b=KXVCjVGyjOFV/GgtOnKVDzKkfLXcuMgcduwyZbP+FBB/88OT2y7csdfrCtejcf6GAh5dcyADM5DhoXMGFOSJh7o8d5oC8U6CqPTpxqLNhScjRB9Jz2LdcFy380Q5CNLczxOIAi4sQwg9EJ6YWk3OsXM9KXCt5b1pkOTX2U/x47s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757386376; c=relaxed/simple;
	bh=jyfnFsJT6sifZgtKYM7Ly6Ukqkir01Fuk4Lc2iqfpXQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K2+TBM/h6xC2WH+PqPPDj9dVcNhYyi1m8FqvRXnPVWiGvFGywYWy1ZnS6pvZ0c0oSRNpUmr0f0zM9nlMZAPPX384rcLuI9qfr4yvpEEJARbvP2kIftE4vca+kO60HtNEYuMk/J7NU+HaDeaaxQc0Mm9Tdq9XdUL2wtR9ckG+dQ8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=RJFcCwlz; arc=fail smtp.client-ip=40.107.130.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jXDEZXjdUwYRp9gOZmalOR1RbFbdfAzdJtcUgxV88oywBBR/ELbIgGKTZQwbV9+K+9L8f1bBVfRm6ySp13ceE8YaWlxawi+Kw+wNVwQYrAdkvuBpCd6C6kDXVnMRb2eu4c4GX3aydep7UWuVn9827Sda97U4KV0uXkfE0i8Pr5BGRKRkecFSJtgmaciJkztr64pRwZqiirRXxCXbTB1aX0WTPiXtPADgvGIUILz6QjymqDpZk+coQQ6JHge/p4nyRO9e50xdu6Bu1BnvMO5xLVSN66EwsXEfTpYCzll6CE/RVq6LrDmJU1WHNpseHY9H9clwPA0EdF+Gbqe/kASp8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3SVinXXfmvFNTuc4xP1YDwKKJLKn1ZWKKCZFmVHfP1U=;
 b=rtnC5xDKGUg+44dvcX4u6lgnjHUSLRHd+82Z2rYuE4keAmkxfp0Oymg4W7mO7a9M9T9K7pckUjYZ8ad7mmQkfMemfWA3C2KLs5uJSLMiiooyARlxTFRNET1h4P6tGR+IgOLTZJ86M4t3FMSlDqHgshuroxBHiBsaJi+odZy92e1EwxgtYlCbAwxLCWc6Q6yYILP1WD2mtgUQD3xtxnB/25voa0yC9rt2BdXZsmqAEPTmfU3G3hgdPFtNmyOaWfQjsj6D0zOvRl3+EMmb+To06z4d2ZSD+M8kQ7HPLShq657UYI83oN7kZCfGfaQtJ6tvOWBXh/9UJ7Fc9Svut5LmTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3SVinXXfmvFNTuc4xP1YDwKKJLKn1ZWKKCZFmVHfP1U=;
 b=RJFcCwlznxzoIgDdChTi/uml5kWBhlenS+yW9OQqjQ24SKKvjq4lylOgQ78tfbe496G7xPgWLOIM92PW6pTT08PMHQdVxND43MTS0Dvb5d5fbeunIjpHXZDNwd+GmjNslg6ciFusYn+hLX14UiIjm4J3jvT0Em3t51oEkfzoGw6/YbvFperL7IrvoV9/F9mhL0b8IBD3yAjEeopKIyqbQWZzxRWTEkF2ZqP1sjI0pmqi0qcQyi79z8+QjKuttcYeDjxwowT5KLQ1/gCpicXcUta0Kplw+VJgdZBe5N1/vE0WuTmaI3BPr1/Z6vNVO9yGkOVcL4IRrOrc4JQJSAJ81A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM9PR04MB7553.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Tue, 9 Sep
 2025 02:52:51 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 02:52:51 +0000
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
Subject: RE: [PATCH v6 net-next 6/6] net: fec: enable the Jumbo frame support
 for i.MX8QM
Thread-Topic: [PATCH v6 net-next 6/6] net: fec: enable the Jumbo frame support
 for i.MX8QM
Thread-Index: AQHcINxLGqaPq5bqZUuWdKBQThXOOLSKJ9Xg
Date: Tue, 9 Sep 2025 02:52:51 +0000
Message-ID:
 <PAXPR04MB85104BC89754A75CE7D4C5DC880FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250908161755.608704-1-shenwei.wang@nxp.com>
 <20250908161755.608704-7-shenwei.wang@nxp.com>
In-Reply-To: <20250908161755.608704-7-shenwei.wang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM9PR04MB7553:EE_
x-ms-office365-filtering-correlation-id: 71181662-e9ab-4ac7-ac79-08ddef4bf78a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|7416014|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?JWWHv8DE9hEH0L5E77Yc5CDWCILnRPsbo5iBuohyRDBukBK1djcWjEeZ2i1R?=
 =?us-ascii?Q?NG1Jx1amRzrEX1zkjXIQC5ryq9ZAhwht10VeH4m5nf2sc/WuaGtk9GmmYJDS?=
 =?us-ascii?Q?QB8GLy9OHTx3vO7nNLQ/OOFlKya26q6fIqUaWqDsq6pf6eh/CJLUCF8jcVGB?=
 =?us-ascii?Q?fHGLbCi7Zx6ZgasQdT7q+U9TRatjPFMkhWerFzm8Uqk77rkIbMFFY+rYcCv6?=
 =?us-ascii?Q?IaB1SKl6OI7PaOj7eci7OqITv7+t2GKF/EvzzD6IkQOrHzK5C8x8ZobCXbBW?=
 =?us-ascii?Q?0l3bJ6fQaToywd6lEVU6ffHaOEVKoqWCp9Y6Yy0kERvIhoq9WFtgVQKcj5U6?=
 =?us-ascii?Q?eeSJlfKfIdJRYy3WkYQPGqSkxtgGoWI7vo5jv/aNJtaxSMbMsKJlfzf+7a01?=
 =?us-ascii?Q?LZe3El4l1zrp9wlIBJLaKm/pE4orzisFgZfu94hspA9sm9yEUKEh7w2j2j/u?=
 =?us-ascii?Q?9+Xyq2ZWFsGW9wfadL4jmGMbnsFLn6csqUzK45C2XAn1DIXlKzCBEMRCeJ8N?=
 =?us-ascii?Q?AriaxvSSRgYou8uKF+WzKUGOTCs9eUr8OXSetK+33/O/9KEH7GMfURt4fEO1?=
 =?us-ascii?Q?mSECD/YCCjCvfVpIvZHmOXcgtAiYSCnC7C9CL1FpaW7TXfbEgaQOGpyVbDpN?=
 =?us-ascii?Q?FsKKEJs7mMgjkKbJWccnkoYlkft3DOCjo14hl3enfXCGWYv03eBe3QINqzFc?=
 =?us-ascii?Q?hqm+n0MxBtsDSSDn8lyNAJdL+72I+aRzssl1wH7kznnKnQpTRMwPEj4qhT0u?=
 =?us-ascii?Q?K9dq642BUOAHKO4MJF5xW8PvOS0wI1oF9ohAv3VV8dHOAYAlDByPlXZOasBx?=
 =?us-ascii?Q?FGnEz0iGL4M3NS3qw/MQYQ4kIYU6grYLlNcfcxLQn63gLD49EU4KqiYYVZHn?=
 =?us-ascii?Q?Bo3lyHO0N/XvW2eepElW2onyypSB5xk82qs2aSr1M9WeV/4xggz1t3fBcMJ+?=
 =?us-ascii?Q?FN9fAqfz4PF3yY84Jlmskyb5a8yJ9fHfPfyDi14JOJlUZPYat6E3DTxDx/nr?=
 =?us-ascii?Q?gmnWp6aDr2ox0eHmBaOr41HW14ufO3lrcUGOPBsZr1ghuEdzXJGR/bvu99Kl?=
 =?us-ascii?Q?r+scNz/MVloKVibUnmcCHaSt1I1QRSTUhLJngtsJWBwrzad592aUpTNjIg0u?=
 =?us-ascii?Q?aGsU2coEgUCBZNU956WWqazgGrD3+UGB90z+tEdNoq1iRTuFw1bYhaz0tF3+?=
 =?us-ascii?Q?eopwPxNdh4P+w2lQSbbOgbSj4gM6oTY1QDlUai1kmdv7xz5GKpq7544X3KYi?=
 =?us-ascii?Q?I5gabajui5ZB9Rddhk7g2ZCMGRuCLs0hiQZqpU2IEJLB5hOfADjUC5WmyjPx?=
 =?us-ascii?Q?lgaIhAR5EMISXSRpUONOvBl+rGfgJHLOd2KsuiqUy+OEZlfKuISja3qzTKeT?=
 =?us-ascii?Q?lDq7NaxCo/CtbNUFQ3wyfnsgu8xFx4EPmP5zI3uy8J2ah+MYxS5ApP5lU5Vz?=
 =?us-ascii?Q?3Z+Gqx2dtcSsR2Hh6eEnrMLhyY3KHenOtfXRtUwpJ/e6ihF8aSzYW8fWVvbe?=
 =?us-ascii?Q?Hq2WEH2XxNzYPLA=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(7416014)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JWOoYGFC05eWzTXQL6Pm/Z1calQPTtOtZYHvpexnT0L1GT+x9lVpquXavqxX?=
 =?us-ascii?Q?rG8LoPeV1aFxJiHe6K0wdWbqCPfY8DdPH1oO3ZC3X1pEAQAxdDhZjyqs+vIv?=
 =?us-ascii?Q?Cioj0xd5R7l+4moN18RjxvK8zWIwxlNooNRYfVoRV8y7t34pLgX1jTl/GDMO?=
 =?us-ascii?Q?2ufWoo6SUm++T0SkZK+dllVTVFszd8zU3YYJ34AJS5280IC5NrMqswUOfa03?=
 =?us-ascii?Q?DKhUdtqi5FNb9SSeNTAk3+bTE5C04686Xv0yEyF4aZAwQseIyWKULzEdSXrn?=
 =?us-ascii?Q?Ej2v31+l8gm59Hnd0iY1vj79OtMhzoXGswSerU60WSjY6K4jODhkBd1SNgj+?=
 =?us-ascii?Q?X1mupXcRrQIFcb4Brz9VMZXkHH1UWQXKslCms5xE9uAS3Si9ZRvHjGzMlzgZ?=
 =?us-ascii?Q?/R+2X6odIZPB4IrJegK+o7UPbj37CP289fXkYFlQdiPiKduu3UyXp8pt+fJa?=
 =?us-ascii?Q?gxmmJgTZzEHx9uMoBKxFpFaOTLhSwXyApMIC5ULznU0ST65AXHGPItSy6m6C?=
 =?us-ascii?Q?hPJ/Y+dqwhf1WCqAw6Zv3Od+A4guVRMB9LEuW/85rVN12Y9wupIhkVW/cV8Z?=
 =?us-ascii?Q?SBEOL94DSqhS0IcUDRqqR9uP+RPhRCHy/cAhK+no15SFh5R7ZxrN2IFGXYXt?=
 =?us-ascii?Q?XXbzDhLW05jpC65tTUaDcBynZKuVClr0SlG+biEI6Pbj5/SOAUoIMATrp6yW?=
 =?us-ascii?Q?KbHXx+UmKRbLkbAYD60QdaThtDx/hndLiNzSKTP+E6LHgcPlJ94zgwzxAMJg?=
 =?us-ascii?Q?kQ3zpl8HnjXmemxXSBBOR/F6G2bj1WPbonoIFTD5VFJ7BJWlUYb8wnkv+ee9?=
 =?us-ascii?Q?xMqhZq3cYPkhm0GLSSDMVg4gKp/tzV2uzrjw1KKJ951ArQalziJb9BOtokS7?=
 =?us-ascii?Q?40VOrW1c3c0BY0uaCbCF8tMnheL8GSvUp0gv9fg4NR4M2rW1atOV3peRvORy?=
 =?us-ascii?Q?G5YIgvu5OJ8k13y6hgCQJO2MMQ65q8fPEk/v7vGORr6tqJvj1d3R81yM0x+s?=
 =?us-ascii?Q?Y8tI2kHgjO8r3wqLKD1cewWpYkMdmaw3HeqtJWYEpOf+PejOpG/ReLqvsARs?=
 =?us-ascii?Q?bKAf1+UKLiIHEM6yIxR/JmYWBxA1SbtPKt5C7UJG1LGga9nme9jUvHdjJRq2?=
 =?us-ascii?Q?RiCXUOjzGn3qKMDO5fq2i7fJXMWEdxOZasTeeX3qoUHGq8yM40oiWuTQ3c1g?=
 =?us-ascii?Q?V+NVDO9zz5EPs8pceB1iUxgSAqFYbKu4Zt1UBnOT9xpoqzIABAkAlIeN7RwE?=
 =?us-ascii?Q?2PndBOto44ZWObLRrwNVcT07m2LWuSF86ch07wFOrx6ez16mFOjiXF1nky2n?=
 =?us-ascii?Q?gdBS74fsUXG/SLNn9hYQqOj6pgdGW5S84/ang7nRLQWKOMddN7VbPXajEem1?=
 =?us-ascii?Q?cySPevDDMjpu1qZaa7JUpWl/mWXaEwvSzMv1wbFpc6nwqyhjA928QUPJr8Er?=
 =?us-ascii?Q?x0Ut4tQmUoujbSnAhoPZ/Ap16fgwi00ADKwr3LnistZCQs7RISSBnmn7PHOm?=
 =?us-ascii?Q?yU/s/vcEfKY42ZcgraMxv2bNxou+G9r9h+pKhibJ6FU5TzInbc8P19CeHeIa?=
 =?us-ascii?Q?dnf7WH1/ImOLrDqYgLM=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 71181662-e9ab-4ac7-ac79-08ddef4bf78a
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 02:52:51.0834
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 0Hq24skbPtYFyeuvpozrAoiTQiLhBhLoPTWaPxCfJB9zaFRi9aUfFtfnPlgRHknFBA3d+r/90zg/HzmgGHHL+w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7553

> Certain i.MX SoCs, such as i.MX8QM and i.MX8QXP, feature enhanced
> FEC hardware that supports Ethernet Jumbo frames with packet sizes
> up to 16K bytes.
>=20
> When Jumbo frames are supported, the TX FIFO may not be large enough
> to hold an entire frame. To handle this, the FIFO is configured to
> operate in cut-through mode when the frame size exceeds
> (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN), which allows transmission
> to begin once the FIFO reaches a certain threshold.
>=20
> Signed-off-by: Shenwei Wang <shenwei.wang@nxp.com>
> ---
>  drivers/net/ethernet/freescale/fec.h      |  3 +++
>  drivers/net/ethernet/freescale/fec_main.c | 25 +++++++++++++++++++----
>  2 files changed, 24 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/freescale/fec.h
> b/drivers/net/ethernet/freescale/fec.h
> index 0127cfa5529f..41e0d85d15da 100644
> --- a/drivers/net/ethernet/freescale/fec.h
> +++ b/drivers/net/ethernet/freescale/fec.h
> @@ -514,6 +514,9 @@ struct bufdesc_ex {
>   */
>  #define FEC_QUIRK_HAS_MDIO_C45		BIT(24)
>=20
> +/* Jumbo Frame support */
> +#define FEC_QUIRK_JUMBO_FRAME		BIT(25)
> +
>  struct bufdesc_prop {
>  	int qid;
>  	/* Address of Rx and Tx buffers */
> diff --git a/drivers/net/ethernet/freescale/fec_main.c
> b/drivers/net/ethernet/freescale/fec_main.c
> index a2aa08afa4bd..329320395285 100644
> --- a/drivers/net/ethernet/freescale/fec_main.c
> +++ b/drivers/net/ethernet/freescale/fec_main.c
> @@ -167,7 +167,8 @@ static const struct fec_devinfo fec_imx8qm_info =3D {
>  		  FEC_QUIRK_ERR007885 | FEC_QUIRK_BUG_CAPTURE |
>  		  FEC_QUIRK_HAS_RACC | FEC_QUIRK_HAS_COALESCE |
>  		  FEC_QUIRK_CLEAR_SETUP_MII | FEC_QUIRK_HAS_MULTI_QUEUES
> |
> -		  FEC_QUIRK_DELAYED_CLKS_SUPPORT |
> FEC_QUIRK_HAS_MDIO_C45,
> +		  FEC_QUIRK_DELAYED_CLKS_SUPPORT |
> FEC_QUIRK_HAS_MDIO_C45 |
> +		  FEC_QUIRK_JUMBO_FRAME,
>  };
>=20
>  static const struct fec_devinfo fec_s32v234_info =3D {
> @@ -233,6 +234,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC
> address");
>   * 2048 byte skbufs are allocated. However, alignment requirements
>   * varies between FEC variants. Worst case is 64, so round down by 64.
>   */
> +#define MAX_JUMBO_BUF_SIZE	(round_down(16384 -
> FEC_DRV_RESERVE_SPACE - 64, 64))
>  #define PKT_MAXBUF_SIZE		(round_down(2048 - 64, 64))
>  #define PKT_MINBUF_SIZE		64
>=20
> @@ -1279,8 +1281,18 @@ fec_restart(struct net_device *ndev)
>  	if (fep->quirks & FEC_QUIRK_ENET_MAC) {
>  		/* enable ENET endian swap */
>  		ecntl |=3D FEC_ECR_BYTESWP;
> -		/* enable ENET store and forward mode */
> -		writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
> +
> +		/* When Jumbo Frame is enabled, the FIFO may not be large enough
> +		 * to hold an entire frame. In such cases, if the MTU exceeds
> +		 * (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN), configure the
> interface
> +		 * to operate in cut-through mode, triggered by the FIFO threshold.
> +		 * Otherwise, enable the ENET store-and-forward mode.
> +		 */
> +		if ((fep->quirks & FEC_QUIRK_JUMBO_FRAME) &&
> +		    (ndev->mtu > (PKT_MAXBUF_SIZE - ETH_HLEN - ETH_FCS_LEN)))
> +			writel(0xF, fep->hwp + FEC_X_WMRK);
> +		else
> +			writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
>  	}
>=20
>  	if (fep->bufdesc_ex)
> @@ -4581,7 +4593,12 @@ fec_probe(struct platform_device *pdev)
>=20
>  	fep->pagepool_order =3D 0;
>  	fep->rx_frame_size =3D FEC_ENET_RX_FRSIZE;
> -	fep->max_buf_size =3D PKT_MAXBUF_SIZE;
> +
> +	if (fep->quirks & FEC_QUIRK_JUMBO_FRAME)
> +		fep->max_buf_size =3D MAX_JUMBO_BUF_SIZE;
> +	else
> +		fep->max_buf_size =3D PKT_MAXBUF_SIZE;
> +
>  	ndev->max_mtu =3D fep->max_buf_size - ETH_HLEN - ETH_FCS_LEN;
>=20
>  	ret =3D register_netdev(ndev);
> --
> 2.43.0

Reviewed-by: Wei Fang <wei.fang@nxp.com>



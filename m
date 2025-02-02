Return-Path: <netdev+bounces-161969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32FA6A24D82
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 11:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA73D3A5340
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 10:14:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B74F51D5CF2;
	Sun,  2 Feb 2025 10:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="Jcwr1hJP"
X-Original-To: netdev@vger.kernel.org
Received: from TY3P286CU002.outbound.protection.outlook.com (mail-japaneastazon11010060.outbound.protection.outlook.com [52.101.229.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7EAF1D5AD4
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 10:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.229.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738491277; cv=fail; b=CR2V+tBw/SD+HM6mLcmXl3dniT1BaQsxwM2DhHtRqkw90jSsvowO7s+XqNXKR07cmaDTUGDgBqTe0e7vD2kJAjfZ4aXDr6dsUcJww9DHgbKLXzmo9ZYxCT4sju5cfAhZk16H2QFvu7rqC1RiO3F6ex7VcAEVVgoKc4fF47Yza6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738491277; c=relaxed/simple;
	bh=72Aa472mdUjpGSAW5YijUAvAaT1yrvdoihQ11jnNQ68=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ivGlp96xkFyuwII0Hzgu8Qv3hIOArxewNAIMn0+ydHRJ2EMscAdDtu47NYQW0qqJBMOuuicIRjFFmLApRcDXxz5zv/32l5SXkFMcE7f+8ZXCu/CN3PLHNoEPjWMcMVxoiy6ggJ1C3EZfESK7dTmhiftOZYXIiNjVP7TlNpCpffM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=Jcwr1hJP; arc=fail smtp.client-ip=52.101.229.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sbOkuxsI43U88CjFEfGEJXL31YhVlf9KK+PLjrc8cvQI4lNhvKbpAjW5rV0IUGBhfvhpoF/BFnMtyc/m+IOr9VgYegRv2GIYF9i7pd8FVBEdl+yk8q6CGodihH0oE1pbfoGVzqJa3QNmZHAIkj+JGDVMAdzi1liRBVgtqm4U91uYRFWoo1sOfPPDUtUl6zCQMgutRI+0iwzQZ1d8tocp6kSjVU5/nz4WFBgcWncQjJ6L5NvGn7ufS5XquPXNLSKzgauYVY0p9Lk8G797s0N/8oUgZ86AuCj40LjHXV+84aceqyF495v1hSDAcs8uynpMgu51vXFlpV0sDsoCmLZgyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FR/jMDXcrfvMcW3JtDZBFioNBXJI50LuMbF9H8Xyy2c=;
 b=YoRSTShOdbYltRsIZkO0/wIrJk7xHMbul14zR/S/Y1yhoZlwW2afzt4bXo61sA9PZi1phrNg08L0g+jN6rscSCffksMYvnO1a6KuS1F/w/UU1xYvz4yOSsBJZLhW1HD+0kBcc56R4/5PnOWXuLpB9/wBDwbvBWpFs/zD8MkjfksdfRNSt06Gri2EyS65TvYkz6V93AujUYBkUU9qfLvm9gvuodHhzOMIF2HUP8ZipnNdUiB/vL2xPO9TQGJMdottZ6a6gmViOVeSVEvHHLZ5dugHJJudBSsfjSwWRR0Axrf9SS6DvEVKLTNi4TpBWbOJNyjO3/L+PFbK4TJchsglkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FR/jMDXcrfvMcW3JtDZBFioNBXJI50LuMbF9H8Xyy2c=;
 b=Jcwr1hJPrG8HU2xPK6sAZ3vVfg77yf/WjuDH9Me7lbZO4DQAdBFPEMsG882jjSD9VzcEFCFAkPKV3xP+FxRrEztTU5LJhb3gfDqd85d27FRGgIBVyVsTSvWARIIkcRMHztlxIo61HXYP2KPmYDhnXpaqRtixNA0VI64zbQdMhoU=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB9540.jpnprd01.prod.outlook.com (2603:1096:400:19b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Sun, 2 Feb
 2025 10:14:32 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%2]) with mapi id 15.20.8398.021; Sun, 2 Feb 2025
 10:14:32 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Felix Fietkau <nbd@nbd.name>, Sean Wang <sean.wang@mediatek.com>, Lorenzo
 Bianconi <lorenzo@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Matthias Brugger
	<matthias.bgg@gmail.com>, AngeloGioacchino Del Regno
	<angelogioacchino.delregno@collabora.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-mediatek@lists.infradead.org"
	<linux-mediatek@lists.infradead.org>, Geert Uytterhoeven
	<geert+renesas@glider.be>, biju.das.au <biju.das.au@gmail.com>
Subject: RE: [PATCH] net: ethernet: mtk-star-emac: Use
 of_get_available_child_by_name()
Thread-Topic: [PATCH] net: ethernet: mtk-star-emac: Use
 of_get_available_child_by_name()
Thread-Index: AQHbdMVlFxV6iG1NNkGBfxnS3fsEHrMyyecAgAEC7cA=
Date: Sun, 2 Feb 2025 10:14:32 +0000
Message-ID:
 <TY3PR01MB113468F3BEBEC430687B060FB86EA2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250201162135.46443-1-biju.das.jz@bp.renesas.com>
 <28da459d-a611-48aa-8ad1-da5f6d605442@lunn.ch>
In-Reply-To: <28da459d-a611-48aa-8ad1-da5f6d605442@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB9540:EE_
x-ms-office365-filtering-correlation-id: cf3423a2-5ff1-4d74-fa02-08dd43726309
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?AS5OQoUxVXyG215dZvYZzGURu0Gvd/LEdX3RKBusRfuxXlDEnJbJFI8XCsc8?=
 =?us-ascii?Q?AvW5qNds5IV4VukF6ZnP+ZGdxvy4cyWm3QsI06w+SkkA4nb5YBs9turQp3fC?=
 =?us-ascii?Q?SJh3gvGzVgRkM3oxftbwQ4WZLkyaGGzinVpq7myqOU6ToEE+nzZ5eUTFAlNG?=
 =?us-ascii?Q?fopPAreqFm91MyklIBTazPeaQwF4cCHWnlvU+FQEnoqev0jrNnqzqmQUROfv?=
 =?us-ascii?Q?qlAyy+tax3005vHbvWmosV9VYKwvDQ+vbduk0A5CGsJakNxZWm260C5jOsws?=
 =?us-ascii?Q?3n5JkBglxwM3nRf/0R5DRJUSADwEK0XnesfMtfCkncqxUlPWfgmNd8O1AWdT?=
 =?us-ascii?Q?JzQITH4pdpCKqlvc4hDXns0pxNXqbLaB823AEmb/fwMpkqBLuZ0LOTP/FvJt?=
 =?us-ascii?Q?qIA4wcqHLopomn3VcNMclI5sGC4bjpCrlTbOLlHV/zPWgrqbLpwJYN//d/Iq?=
 =?us-ascii?Q?O4G3TBeQ02HG9BafQvFSM9oIlpJ9LeummLVocaLvjSsvm9rlxlFiDk9SzbPr?=
 =?us-ascii?Q?nXLSuum0m5ia4Vd178gXO1lHoX2+cmXQLIDhRZ6AwoKD93em1/rWKkY+/tVO?=
 =?us-ascii?Q?Wl1OrK+gBRTiDgkt9c/A1ZpmI81W+YnH66BGzO2VDDT89VY6nQLnwtxNG5vV?=
 =?us-ascii?Q?ILCidXV1zeoeT2LRDSzPn1KlPkMRujVDpKr8TchRRKDU8AUy4xyREyY2oz48?=
 =?us-ascii?Q?JBCttyAyaF00b5WnSllg1LYlQscyvpOdjH47BqPxhpT3clcAfC3bzNgyYHx+?=
 =?us-ascii?Q?C2ulvxTAypXDFgdAyjI1I31GFuRHHsgUnl3ZichL8c6/j9UcNCn2W+cAFUjs?=
 =?us-ascii?Q?fhLPezsatq8x7wZrRjo3K7RxATFG9xbQUm7QrXHOMGr4n6AheXsR45+xwmdq?=
 =?us-ascii?Q?H7TGkHcvzonhgq3c3kd8hLXhrWgH/a4oDvHReaDtxQYRW8jO+XaXHuRmOl/Y?=
 =?us-ascii?Q?AhnRGs14xjXokF768LhNycjyFR9M3pfSXSiblgZLnprMf7tMAOegbTlaHid+?=
 =?us-ascii?Q?J6s9BaXHS8OXVvQyiLb1TT5a3N44LDl6h5NqfZWKEGrpOvkkQ3ZiPw8dCp3O?=
 =?us-ascii?Q?xbahGzwxJd3UqcLQhANsE08WM13AqU59yUyIJRMWeyK70hLYbxPzTsvpgQOH?=
 =?us-ascii?Q?1fZwf8G1hCRMiN40QM//OJJAHz6XKmmU3T+Og7HboExYoA5RiUduDBMBeMj1?=
 =?us-ascii?Q?qeFyOL8MBPwxWHAuhsrUv1e0r7KXvYqQWv92V1ftarC/cidIs0/o3YsD2n2X?=
 =?us-ascii?Q?KfP3OAiwk7IoyCbrug28JIqraV7M9gpD2TBkuk23zH5qxbZ6KGqQz3Upp0NZ?=
 =?us-ascii?Q?dmkmtJCmC30U2KOj98QPGljitqS8yC7XxL6WqfDfsNe27YSh4m75qmghfhEl?=
 =?us-ascii?Q?1jq36BaMrlrs9NIfYUrNlAdOo/zL6FAusQwcOkoWo54SUGUYuL1d0GmvaypA?=
 =?us-ascii?Q?2lA6ZIghINr01vY4Cuo8h1xLVCw/aNbA?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gtgvOgJeveKP44gd2dlmpk2GEn8H6+COVvg8Rrj0yJZUQPH+sdFes813xJVg?=
 =?us-ascii?Q?WESqK/aXmqwTeOfwpfKDoIh+PmdoT7DY460Yvjcpm8Z5ENs/Tln517aaPArV?=
 =?us-ascii?Q?HdR9eo4B4zar2OLCML61Qa0GQMXXZtLUiwuF/+GLmMgXv6XpuiGoFxvPgm39?=
 =?us-ascii?Q?tcFBUO1brLpIfTaDsXnWoLMvwApVqRdMVSgxJnm8ceZK2vbS9xhtZl+o6O21?=
 =?us-ascii?Q?ylpgnXezCGlWR7VEqijYi3qaRr6EBz1mF8HN36FrwHLxnvRTRWZCeWGbMmmo?=
 =?us-ascii?Q?Uc5XWGhe5kP0E1fzkczv14+gyD6/0Y7+CCiu9KBXjGq5fMKqvs9ajbN+VRER?=
 =?us-ascii?Q?NGz7Q6Jwtp37xnqvMIlERwqjUpU0QN6apxFfT4/2aLYXQJwxhtyARZBvAo93?=
 =?us-ascii?Q?xmy4jEU09UHQvd9y+ZXQ7mZcsVdV97xYC7dVBV5fL6hOrOkQakqNoQiPNISI?=
 =?us-ascii?Q?8OD7id29f+MrRrubmfuvSuQ/+ANjvU2MFFYMKUvAaDYjAdlbVZJpPshwSU/C?=
 =?us-ascii?Q?eZXWJ96MywzO9mmmvX4B/Grs23VOqYoBls7/5+J0OweW9H6kpMPE6dgLrhsx?=
 =?us-ascii?Q?oePdFaC2zK3HfTtJfm2RpbqtoifSsxGQArfFY8D4MuBVC2BGo0595zpDaWIu?=
 =?us-ascii?Q?Z/GSm9RHNmal5JH3rfObN/PC6e6KA4vELvS6cPdN2qaR6bq0N8qtLlBbr3xg?=
 =?us-ascii?Q?/vPf6r/DZ6lIntStOchMF3SEwrsLwDPjvubQOrSawOX5343/gINo/g5YCJI7?=
 =?us-ascii?Q?1PF5+BqkcqKwbr3KcXpXMSSpfqEdoVZo3EpHuT2gL4qUdEvs35Hby3d32xpH?=
 =?us-ascii?Q?moO2hXzDuxjTcip4oIJDYZICoLi2FGAjvxghkmHC2WUfT6GS0+GzVKaVugWV?=
 =?us-ascii?Q?8b0xg8tQ299qK/vka6b8FBGQ1+2/Vt/TWtW3tuaS/JquSqWzjoZ6BPdfJ52J?=
 =?us-ascii?Q?PTXMtY1iy+mD1vmLCJZ7XEN0XzSRinpcaAz3F+o68Pc0kErEIKeAVOZj7ccs?=
 =?us-ascii?Q?i13+UBJ+L5Jaty91mKth4m89760gVh4XvPGSrOGfwiDNO0Pw0iflKqOXxtDt?=
 =?us-ascii?Q?Al9e22g6XVDrikdBBjBbmhHxbI+f6Q6HjVDBqCxAYnK8SEuayACSI2VCeDIs?=
 =?us-ascii?Q?O3e0ugeKllgoUxSzOVLSKpRmCqKyF4z96vMFuGUKRVQA39cVdjJ9+kIfXqpq?=
 =?us-ascii?Q?GfblUPQMgai0kJOh5Ym89je2mMxf5rQOTr+O3Oe84DaguVnwP3dj1Msx96Tr?=
 =?us-ascii?Q?TZdw6+xF7BQRILOFF8N1ON0HQcqU12NHqTJGYJVoz1aRxVZmWt5rk5E0HSYS?=
 =?us-ascii?Q?+Zx3iMTIxTCgTd3M1YQ0aa+BwAkduDzvNlH52hOFR77zbv94M56mY+tTaein?=
 =?us-ascii?Q?0eues20JBIuPUHKg7vrvl4KOa5S6xLf0maDebEBTiIBIjLb6RcGyoHF1wxU7?=
 =?us-ascii?Q?qIYawKImPSXV/MOclZvOwyb6fHFsBptEgwcnsrT3woQn9U6kZXjCVsGmoo0C?=
 =?us-ascii?Q?8k7EqhM2X5nz8NNaY8mWy1j9FcYzehwO3gCEDq6ZLZFkqlfv24Z+g2NAwwZE?=
 =?us-ascii?Q?4DRQHSUYGDCcvzepzkf3mEohCRhuWHyEl7WobyTBJNPFEfXrxI+jtJR+kEsg?=
 =?us-ascii?Q?cg=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: bp.renesas.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TY3PR01MB11346.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf3423a2-5ff1-4d74-fa02-08dd43726309
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2025 10:14:32.2816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: a8D1gATwOhtX6zmlRxtO/LjkprrLxvC6Z6qNGYQ3nRo+EUL0Lwtya90up5/za4aJVC3pMOrPX0Tq1AQJIrV6Vr4owNDIcN58lK33PvqhcN4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9540

Hi Andrew,

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: 01 February 2025 18:47
> Subject: Re: [PATCH] net: ethernet: mtk-star-emac: Use of_get_available_c=
hild_by_name()
>=20
> On Sat, Feb 01, 2025 at 04:21:32PM +0000, Biju Das wrote:
> > Use the helper of_get_available_child_by_name() to simplify
> > mtk_star_mdio_init().
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > This patch is only compile tested and depend upon[1] [1]
> > https://lore.kernel.org/all/20250201093126.7322-1-biju.das.jz@bp.renes
> > as.com/
> > ---
> >  drivers/net/ethernet/mediatek/mtk_star_emac.c | 24
> > ++++---------------
> >  1 file changed, 5 insertions(+), 19 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/mediatek/mtk_star_emac.c
> > b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> > index 25989c79c92e..beb0500fe9d5 100644
> > --- a/drivers/net/ethernet/mediatek/mtk_star_emac.c
> > +++ b/drivers/net/ethernet/mediatek/mtk_star_emac.c
> > @@ -1422,25 +1422,15 @@ static int mtk_star_mdio_init(struct
> > net_device *ndev)  {
> >  	struct mtk_star_priv *priv =3D netdev_priv(ndev);
> >  	struct device *dev =3D mtk_star_get_dev(priv);
> > -	struct device_node *of_node, *mdio_node;
> > -	int ret;
> > -
> > -	of_node =3D dev->of_node;
> > +	struct device_node *mdio_node _free(device_node) =3D
> > +		of_get_available_child_by_name(dev->of_node, "mdio");
>=20
> Same comment as for you other similar patch.

Ok, Will send next version with readable code once
dependency patch hits on net-next.

Cheers,
Biju


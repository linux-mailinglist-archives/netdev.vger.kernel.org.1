Return-Path: <netdev+bounces-161970-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A147AA24D83
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 11:15:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61EA13A535B
	for <lists+netdev@lfdr.de>; Sun,  2 Feb 2025 10:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CD3B1798F;
	Sun,  2 Feb 2025 10:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b="iR7tzu1X"
X-Original-To: netdev@vger.kernel.org
Received: from OS0P286CU011.outbound.protection.outlook.com (mail-japanwestazon11010036.outbound.protection.outlook.com [52.101.228.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AB117FE
	for <netdev@vger.kernel.org>; Sun,  2 Feb 2025 10:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.228.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738491325; cv=fail; b=fE3/GgG8Id1GAGrthqF92AEPGT4e6VBdr1OGK07qDOb33H1jv8ygJh11/cFcemzKy1O/e/xRtry6g1S9/8lWVMGduT3ZX1QJjP9G5hsoJy66DNt5A6aZv4vX96hflU0Vzb7H8xwv5FtAP+dfzzHGu3YJWsbBb0irFFrGcytG4TY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738491325; c=relaxed/simple;
	bh=LGo8I3wbVwPd/LdUJ+katIo7uBREG9TGu69CriMQ90I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cXB7p12cuMQDaXIUbYTUyObfvBICfyfMPjjMu6CDVxPBj0oO+wYPYfEj4q125xvMlXfXo2PuJwPNrJTM8hm4PLpFVLixj5t1YREV+82GsUfuBCQDaRgdYpB2szP5Kk6cTO1zWC6rBWJ95ZuDl2vJO+NNEooNixVR5Q7MiXX3ZFM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com; spf=pass smtp.mailfrom=bp.renesas.com; dkim=pass (1024-bit key) header.d=bp.renesas.com header.i=@bp.renesas.com header.b=iR7tzu1X; arc=fail smtp.client-ip=52.101.228.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=bp.renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bp.renesas.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OQOeBugliZI/O1Yz3F/mN5gHDvjh3acKdgr+suAf5lZ+tAtPth+rUvBe7vPf9FGHtsOZYia0BQLtc6ooSaRPflMgaC154lkTN9CStNkOyiPl5XfwPy79yUlNUIKlj2C0D3vc//84NBQ6xLGygI7puSQhOg5Z5ZHI4O8QTdwW3oS6WEDYjeqzqlCPWCq6Bj9zOKWOVpNz0Aeud+8Rzm4U1nhtltnjoOZzShFET3AvYTVU5SIkpvDuQMB6b006FVQs6khbYksL7FEKfWCWanoEYORCOk9eif94hFNqGFAOl24110ysJJ6iw6Z0gZWn6bEEjHUmDFcFfmT3MFb1utidtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mWD6kWu2fRFZ4iwSB/UbA8zTEGlN5P4GCzOLWb4GcA=;
 b=C+AWiV7e9AzhfwWFoV2F1BNhrDbsY0YSZp+jl4X4xJSYuX6iFdg97cLx3Gv2CBefSEgK3SJ6SNMcGsIV7SaFsupaFASikNLSEeisI7eJy6uP/WLKXGHWkv81BXMQl1W7utm2FluAj8jb+FKJRXAG5nhX23s1FsYYGdrhy3ow8bOoU/zj2jXyy8p4K0cZLaA8U5tJO+cj7m4GvjZEs6AbiNPdMpQa4BHSuI6Co1E8gg6k4YGnyNL86VqksZh8HFmj2W8qBDvvz1LOy/d39TnCzhgZL+OpF/In8bW3RIFt6gOZM9m8i+mGCjZ0ba76oIfYhV9dbkjkrSygOZK2XQNNxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=bp.renesas.com; dmarc=pass action=none
 header.from=bp.renesas.com; dkim=pass header.d=bp.renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bp.renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mWD6kWu2fRFZ4iwSB/UbA8zTEGlN5P4GCzOLWb4GcA=;
 b=iR7tzu1X+pzp1WBGZemxlhiXiqN/rypY14TqWEmMGsisdPC2ZACVv5HDL85Yx3TEd1De+o2yvYZswURF74CCLUPW/G3XCC+HCi8uC6Z0W5mkyv1PBc4ADTeDFzqi/J3ay9Reh3fHOLTA97W9ockyrUCaiNHkq7NK0uS4vDs+e3c=
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com (2603:1096:400:3d0::7)
 by TYWPR01MB9540.jpnprd01.prod.outlook.com (2603:1096:400:19b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Sun, 2 Feb
 2025 10:15:21 +0000
Received: from TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1]) by TY3PR01MB11346.jpnprd01.prod.outlook.com
 ([fe80::86ef:ca98:234d:60e1%2]) with mapi id 15.20.8398.021; Sun, 2 Feb 2025
 10:15:21 +0000
From: Biju Das <biju.das.jz@bp.renesas.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rosen Penev
	<rosenp@gmail.com>, Shannon Nelson <shannon.nelson@amd.com>,
	=?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, Simon
 Horman <horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>, biju.das.au
	<biju.das.au@gmail.com>
Subject: RE: [PATCH] net: ibm: emac: Use of_get_available_child_by_name()
Thread-Topic: [PATCH] net: ibm: emac: Use of_get_available_child_by_name()
Thread-Index: AQHbdMp5OXvgOYCYUk+2SYeZK2oPZbMyym+AgAECiDA=
Date: Sun, 2 Feb 2025 10:15:21 +0000
Message-ID:
 <TY3PR01MB1134692E120054FAD3830736086EA2@TY3PR01MB11346.jpnprd01.prod.outlook.com>
References: <20250201165753.53043-1-biju.das.jz@bp.renesas.com>
 <1465223e-a9f9-4bdc-a2f9-067884080bb2@lunn.ch>
In-Reply-To: <1465223e-a9f9-4bdc-a2f9-067884080bb2@lunn.ch>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=bp.renesas.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: TY3PR01MB11346:EE_|TYWPR01MB9540:EE_
x-ms-office365-filtering-correlation-id: fabf3e24-cdc6-4bb6-8968-08dd4372801f
x-ld-processed: 53d82571-da19-47e4-9cb4-625a166a4a2a,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|7416014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?1bxyNeSU76RRkPpWoUketAokIWe4Oqll/wOjDFwgg3B7v+Ns/ttHFiiFZA?=
 =?iso-8859-1?Q?rZ/NMcA+w+AHnXZg1rnp0ag2WRPFnS9I8gJKvZXIdiFEQuiQ7J2O4r4PVf?=
 =?iso-8859-1?Q?U8ypd6p8GvGc9lEQ1MmRCJVApgg2SagCgKjN4cVBMnaDbnSnyHRzOh+vJJ?=
 =?iso-8859-1?Q?uJvsnem6LsvFwNpxACS76GhttWGaZ9zoNib74JAHGGLo3vKrN0gx1hnpQZ?=
 =?iso-8859-1?Q?OqEM4Dh89z5JtEA/w0hal3lyPZT4PBaBpi2STkfB9aKxxO8VpM+rYCptiQ?=
 =?iso-8859-1?Q?PwV3r2MwFReqv9FAxinfIV5XI34rqEiFPGHTB6hB2r69jmDLI6H3HsHv/k?=
 =?iso-8859-1?Q?vJUKdBe2OpRqq3qhIBcayYZ5Oiry6PZVfXV/MWAYtbrfExceMEjKpdTcn0?=
 =?iso-8859-1?Q?MR1TiJPskGagu2xsN0b+vEZ5jXNpHg7URLsXO9vV++2nNbMTFQyZtP7KCS?=
 =?iso-8859-1?Q?OwDR84URuJpuSPLUWPduvte5AiwvzXz8AMRkufVNfIvSKrQSpH2FqjzmjB?=
 =?iso-8859-1?Q?j7LOEMDGvZn4mc0km/U1mhD+rjB1s/aWkB3GwrN6lsWywd+GIVwnOCCE1s?=
 =?iso-8859-1?Q?lYr60mIh2m9FWse4ajVOiV8968qo+4+yP3VZhozZbvdIUlCcJg30Db/g0e?=
 =?iso-8859-1?Q?kSOkJITTkV10rgey6naNcYc1ntzSVPgWGur0LRYGEuuLhsvKM4dVMgOWHg?=
 =?iso-8859-1?Q?fML/F139XU2MvEQTAS0t624cLDv9SoKWQJSwau643+pjtAVt89pHVMy4km?=
 =?iso-8859-1?Q?wdFW2iNWLpsMqXIDHY4rRhW6Q7RSaGo1D3B0BHB3FO7zSVZDBLLmoVHacc?=
 =?iso-8859-1?Q?D/VRRZ/PF5Mm4OxpMq8UIVFKdNTZfwA8TwcFe9DfBxsE7a7SLG8xXlOL9z?=
 =?iso-8859-1?Q?wsEY0ECHqg9d2mi2uIzW5QrQSXzsNKpLPimau8jGlvjqQbZgSIxtHPs0Eh?=
 =?iso-8859-1?Q?MTkXo+qCPJBwIHU8vCHdEug1onu1RodN45GADe9DzYh9zFmBRcBzB5la1S?=
 =?iso-8859-1?Q?FV8p1iOFhQjhM1mrgDq3Zx07f5VG9e6FaYa3nvlL0w1TnIL8B78b5L7BcE?=
 =?iso-8859-1?Q?roJZtaM2RXDIAee791218wO0iF+XkWjfN3O0FC+1YUtn7AdFcPLsjDpFu1?=
 =?iso-8859-1?Q?k9hlwODD+hbcPe2gFUHxqxTNqBaszY4Jifo4Bn17k/9uRvD+n87qtBqAfK?=
 =?iso-8859-1?Q?aOARpNTvaaJWk4TcRWVrCUI0pYDgIbDFsnvZfsoL/Y2tSQ2KmFsJNf8wTE?=
 =?iso-8859-1?Q?staDURK7TTVvPPgcemc+TiRA/VCWf+lQE/3ry9N7CKwt+/5Sxg94U2ZhIu?=
 =?iso-8859-1?Q?aN/9+6fLe/ccwgbdF9BqV9+S3icwdiexiBqKBNVNzIpYD2StVa3R6rr/jH?=
 =?iso-8859-1?Q?lJzUnjkFEBE4LZ1rX0lfSuwCK5lMcJocoLi0+X8MCstiiy27QFbFlwph2+?=
 =?iso-8859-1?Q?7DWXhIVxF15hhS9pBtjG8DmjWKx+6J7A4rHLkNlYpa0V5YpNdi4g7I6oHB?=
 =?iso-8859-1?Q?Q9eHZYNNhByRGzuG9ATxEw?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY3PR01MB11346.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?HNXLOX52HbPvxWiwVh0suQI8th8TfI+MXBhiB39fE+YLy43i7B15G3E8nb?=
 =?iso-8859-1?Q?3RGZbm4boKhRE/4fT1gvgFOuuuncvwQphkFQj/2t+EJpw9RJ0ZfbPD7dgh?=
 =?iso-8859-1?Q?CH8gb8kLXn//5myl289qLfSOqUZ9/5nVXGiPctt30pwfbyJjzgfMdIt0HO?=
 =?iso-8859-1?Q?IKVNUf9XJXaW4jCTrpf/Veo+efhQbpLNgY2weYZjCi6HgDBfTRsefGYjD6?=
 =?iso-8859-1?Q?3tj12wsRBr/OtHpUZIZx2bfchTvu7V9o+EDS/26fvLikfQeZzO759vP1zf?=
 =?iso-8859-1?Q?P26wxWtNtzXijpSgaaLGURNZrdtQxskzd5gmUA8d9R/mzGWcwCXQPOyq1O?=
 =?iso-8859-1?Q?cG1g+ob3U3GNjyh9Gmu4DxzTZP9EEJt+WOJDoRSN5ZAl5QMQ43uL8QPt+m?=
 =?iso-8859-1?Q?s4O5lnOFjLrup0LjOH+GvudXJcPR5lXHoqeER4qyodWB6p7NaV/tkOV6ce?=
 =?iso-8859-1?Q?0JQZUUmfc3alM+x2fKRrthlRe/L9s3Il5MlzU4deGinVmREe2UoA4zgy02?=
 =?iso-8859-1?Q?bPxVOrE4gqPXvkG4z4V4BIthjRKE6UDo7r68bkMM8PC9kCdzry7T6bFBnN?=
 =?iso-8859-1?Q?J8W9ELYFp3qzL3MFes8ZuyuDJ0ugXd0ylc84lPEI4/C3Ju7M8GkT4+iIvw?=
 =?iso-8859-1?Q?2QGn5yX5f4inZfmTTUMgrt4SSIbiAktkG2p9qDzcvI1/w6c/wMVjZjLG0g?=
 =?iso-8859-1?Q?E1geBcr/gPsOL5pFDrqFFyjfDbcRYtl+S9xpsB4yd147rFVAorZh5SgbdH?=
 =?iso-8859-1?Q?4Xrl8d/9uVFZEd3+SuoTlzxaUwMQpgS2YhFM2TjQAdF9ocQfa6SeQCywRm?=
 =?iso-8859-1?Q?Hzf8vf7OFKgMooxZhg/nRCTyVIlwKe283actGRYy9cYuE3X9/yp79ZNaDs?=
 =?iso-8859-1?Q?O+1uG2VkdIqDpq1dQY2BJMJSz8UVP7zL3fYpedQT4jxtZU5yBwis7Gm4Vl?=
 =?iso-8859-1?Q?GYwjuiARVBSoU6gEJ5G8tNGsskPk4giLtEQ/8LIfIDR2EOW7/eFpy6JBBk?=
 =?iso-8859-1?Q?80Fy+lQGzuqWuuGSx3RFyh5jGLo6OqeCqVEuRuj9itCgGzSjw6LKjMU/Nm?=
 =?iso-8859-1?Q?vH6orN6Pj2rD0oPtlzBnJpWknLa8lTKpRMcF/FwL8kRIveAo6F5675Py4x?=
 =?iso-8859-1?Q?HghnDzF8DBxt5opAHVZTWNwP8p2DkBfCT5Y/p7ZfMVrlr84f9/3cukzY0L?=
 =?iso-8859-1?Q?t1bAfBzaDGz8WbJ1aPYERu8F88WpNEbjB+OvOg1HzChubzw1aEdtSQrRFR?=
 =?iso-8859-1?Q?kHzTsCWBXpTJuTXxxyR5UoLlcHt4LHftHWy7o4ymInqc7PTjYh1Gr6pruy?=
 =?iso-8859-1?Q?V68avCv9KmpuxY0/IA+cKXjatUnJURmaACf3b3Ngmqwb9uAeApZSP15Mi5?=
 =?iso-8859-1?Q?t/XJWkpMMLDBinCEDxgkHJTJRymIimI0z5j5JDTFgUbv8cqt5NMbHOkeuM?=
 =?iso-8859-1?Q?4A5ummYHrcjid9L/eVR7fviGo7L6l/G7bhq35dw+6f2ygv7oCItgovfImA?=
 =?iso-8859-1?Q?CuUwqTus+nHw1NMR0pnbsjqO9KHvmXELptynEx53BcBCGa/LMOvdHoZ40K?=
 =?iso-8859-1?Q?xumONiVKlgFqoDXBtHCcvEp2oa+fVrjleq/7iZJDb00zPXHQY6rhtaMUlW?=
 =?iso-8859-1?Q?vU/Xh0H82aY1seokeJZWi54ZshbzHVCV0dZkDv+j/Om8eiUGw33dlVeg?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
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
X-MS-Exchange-CrossTenant-Network-Message-Id: fabf3e24-cdc6-4bb6-8968-08dd4372801f
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Feb 2025 10:15:21.0740
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wtKMrSooebDwhgNhgdE7Is945MCIo3fn7L1toJWBV/bZqjClkXH2IO2fsMqDeOKMeawWvI5VEyip5NS+A4PrTz07IJEnewvcpFPyIM5uOnA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYWPR01MB9540

Hi Andrew,

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: 01 February 2025 18:49
> Subject: Re: [PATCH] net: ibm: emac: Use of_get_available_child_by_name()
>=20
> On Sat, Feb 01, 2025 at 04:57:51PM +0000, Biju Das wrote:
> > Use the helper of_get_available_child_by_name() to simplify
> > emac_dt_mdio_probe().
> >
> > Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> > ---
> > This patch is only compile tested and depend upon[1] [1]
> > https://lore.kernel.org/all/20250201093126.7322-1-biju.das.jz@bp.renes
> > as.com/
> > ---
> >  drivers/net/ethernet/ibm/emac/core.c | 17 ++++-------------
> >  1 file changed, 4 insertions(+), 13 deletions(-)
> >
> > diff --git a/drivers/net/ethernet/ibm/emac/core.c
> > b/drivers/net/ethernet/ibm/emac/core.c
> > index 25b8a3556004..079efc5ed9bc 100644
> > --- a/drivers/net/ethernet/ibm/emac/core.c
> > +++ b/drivers/net/ethernet/ibm/emac/core.c
> > @@ -2550,26 +2550,19 @@ static const struct mii_phy_ops
> > emac_dt_mdio_phy_ops =3D {
> >
> >  static int emac_dt_mdio_probe(struct emac_instance *dev)  {
> > -	struct device_node *mii_np;
> > +	struct device_node *mii_np _free(device_node) =3D
> > +		of_get_available_child_by_name(dev->ofdev->dev.of_node, "mdio");
>=20
> When you are new to a subsystem, it is probably better to send a single p=
atch to help figure out that
> subsystems way of doing thing. It looks like all you patches have the sam=
e problem.

Sorry for that, Will send next version with readable code once
dependency patch hits on net-next.

Cheers,
Biju


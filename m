Return-Path: <netdev+bounces-141385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 84A6E9BAAE4
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 03:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CCD7280C35
	for <lists+netdev@lfdr.de>; Mon,  4 Nov 2024 02:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C96EB14375A;
	Mon,  4 Nov 2024 02:37:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-SH0-obe.outbound.protection.partner.outlook.cn (mail-sh0chn02on2125.outbound.protection.partner.outlook.cn [139.219.146.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1C54C6C;
	Mon,  4 Nov 2024 02:37:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.146.125
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730687833; cv=fail; b=Ly8ukfrNxLm9uLYXpj/ENRczhaHgBQq+j7qMesvqtWp7FE32a9nP8vnVtuW5PvFQBeUtk3xQyYnPn7CY4WaJANFC6+5G39/e94JV16FRzo/nzde5HFbPL34XnVr64Zv25oo3weQHkQy5DAp+JSCz3xRfu9S9z/zXjOtr9YA+Sqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730687833; c=relaxed/simple;
	bh=VgflmcSJaurruyDMG3nunelITIT3P5xU2eXeYpB+sB8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Sk/9F2//XsmgZ+NxcanYAF8W2dbx947ai02RR6YHKRIIQdBU8BpxnrwFZIYTt5Vlu3MnbIyMQENOjWa+NI8Wid1TX9boBNisew9UrWXAosa6cPP12mJYCg28mfX9Wu4WlHgumJIaxfXgdTwXu0ExUycIGMht14CGvk5oGxmDbZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.146.125
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpURuq2HbDEAk+ud4CmNmtq4EvU3L5YA2TsUFV2+c0q6FQFnf+cJbp3Xrc47onIOD45sJaZQQCODtLMY5cSzetsB2DqS4PO7DxQWL9Q8vBpGxHinVZ/TTpb0q6vRkntKU0qqRaFkKlj/CnTvFDedaMFmT3g7wGtR7PvQBH7KRQWuI0xCygQWNyapLRPgEMpy2Zp0U9EllJUd4KpiJLANeRyRZ0tPh1mHfDOWHYOeHr/DJjlFEaV5c/MCv4RRVbA6EDtV/8zctvtEgAXln+k5Q7eWolSaxw5QOEpPc8WUjDL9IBorPwqwEm4gREuMjRT5bqr1PvzAleqKf2mpp6zQHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VgflmcSJaurruyDMG3nunelITIT3P5xU2eXeYpB+sB8=;
 b=FnsTCm3+30B7JXZR4XSS19IozgtXHHGvWFv8gTEPOJzBVfP1RJTTwp44DNKcIMeWokz4Cw4j7yzURH5CTIq8U15PmtoyXCGg3m8iLfT0LNr+8pvlqIGY6HVTyd9IcdFOsS9A+XP3Y3v+rq49yNIoyKdEERASL/Jyb/D1CbvLEu7q3QtTv3brkdlrsQ/DkE+sNdl+upNSdm9qmWK5fqrEunA4JyDwPwX6lxkL2q9T1BjkP6i8G5WxfBnGOR85ymqjq0bcnfSw6wFvW9Nys/meQs3wNBYJ7h2vXnap9WrOO2MqwXESdkFEUmi38m2fpShkTJ+JECF2epFiFn6pQm7phA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:f::12) by ZQZPR01MB1092.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c550:a::12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8114.29; Mon, 4 Nov
 2024 02:37:09 +0000
Received: from ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
 ([fe80::617c:34a2:c5bf:8095]) by
 ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn ([fe80::617c:34a2:c5bf:8095%5])
 with mapi id 15.20.8114.023; Mon, 4 Nov 2024 02:37:09 +0000
From: Leyfoon Tan <leyfoon.tan@starfivetech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Jose Abreu
	<joabreu@synopsys.com>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "lftan.linux@gmail.com"
	<lftan.linux@gmail.com>
Subject: RE: code From d0f446931dfee7afa9f6ce5b1ac032e4dfa98460 Mon Sep 17
 00:00:00 2001
Thread-Topic: code From d0f446931dfee7afa9f6ce5b1ac032e4dfa98460 Mon Sep 17
 00:00:00 2001
Thread-Index: AQHbLDdnp3G5sduXf0On8c/t/k5P5LKibC2AgAP3l1A=
Date: Mon, 4 Nov 2024 02:37:09 +0000
Message-ID:
 <ZQZPR01MB097938C7F967F9707A4CC9AD8A512@ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn>
References: <20241101082336.1552084-1-leyfoon.tan@starfivetech.com>
 <38e4fc09-7c88-448b-b9e8-f9a082f1dcf0@lunn.ch>
In-Reply-To: <38e4fc09-7c88-448b-b9e8-f9a082f1dcf0@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: ZQZPR01MB0979:EE_|ZQZPR01MB1092:EE_
x-ms-office365-filtering-correlation-id: 9341335e-f0ac-4f45-4e6f-08dcfc799496
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|41320700013|1800799024|38070700018;
x-microsoft-antispam-message-info:
 TTl0Ess5/kXLCfbQhwDU7i8OAiQbe5btCUGwYR3RU4/qAdntKg5Uc2y+oe1dM5hUrahjKPVSy8ydPwRoi/RV0Jl4F6DgSAo2qmVeaK6SnJBjcKYBAIznm+0uhAs8rUVc6cTqMAB4KeD1xX71QBhhJyGqis58ZYAWcx/CarIZ1tK+lImW8NA3A8TKEJDRWwCnyxcidtJy0HZSV+7DgQe//khxVIy7Qk76julbJr/gdWrUSTmnciTaW1aUHhkbdcE83j6QFLds/OPGudlT2X3t1hTKCPE9gu7fM58gizAcxltKEj8VQwyC2a4ZhvwsqAyXFj3TzUq+YEDimKmpLIa8kyZ8Vo2Eqy8muORYG2+KDk9+7M3NIamSeqMPVbiGtkWci9erxZm6poFX94Ih3naZ/tO1pzrapTbtfjPPdkYEeEqBwrpCaHXg72BUGzw0bFQAFIWBSvaPo4CIUwl/aI1RMoz7Vb+f3UPi39y/A5Uw3l5hp776m6W0ItA2FZtI1onzGAR00O4LiE0EkPnsuSVBe/HDDRekCXATomX5pwTgrCyGy9v5WmXVRqtNJXYHYL/rk1hjVT3IEpcIk68HyOjdRuMJ4P8Er3/qlj2fRGm592vKrDI3Hpy1Qv4C3Ta3bdgE
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(41320700013)(1800799024)(38070700018);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XNdfbxaSn3rk5mgLQopNVNSmf/zG7OlstFfGdlyZr6VxRhS5BDzzxtuqflIW?=
 =?us-ascii?Q?nuG5T9eMxwGfETIrt2b70oWq0s3wGzCPtOdKt2YJxT/TstRfyrgRtpDnSFQh?=
 =?us-ascii?Q?9qYW/Tmm1ZE2EbzJc2rDIEGqiZ7sP+53vHfOjbcS4AC70wObJ+xQ1bn1SUlO?=
 =?us-ascii?Q?eTRqvJNBUsSX24tIFXYMs/kPrcW3KBgThXUC5skJ2hOjtgGRYL3fEj2hJ2VA?=
 =?us-ascii?Q?M4FwwKBb5G10w9rrgsorDFoB9y4Jy48USVJty9oVGPFTmQvFyoAgnSnXGgp/?=
 =?us-ascii?Q?kvB97fWLtqXdzebcJUJ3gOn/sVBJka1GNmKCEHssVItOyYXHYrB8VMdMtdcI?=
 =?us-ascii?Q?zxdA+wEY0MP2ttSkpoNleC1m0UY1liqjmKCxm86ccydRhBz7ammnvQgiKInZ?=
 =?us-ascii?Q?DiOsq2MtKhV77cu+VfVN4Pk/t3cwvWYusLzm4gLDr6fgFQnBPf6ZHkqpx2fF?=
 =?us-ascii?Q?wXEs9uMKiVxuK+5RBS3Tof5p9h1xITK5nubDscdlyp7ol/8OgZyKmWjKU4sd?=
 =?us-ascii?Q?oEK1ciaNWn0QqQxcO9Xy/G1qCqtWQgjDvYEDBdRoFXrZFyERkO/ltwqWg2eS?=
 =?us-ascii?Q?PbxOxLODrjzNX15lX5TBW7y+ZOp0ZqNf8GetGbpPe0/RTivY9YEFz5gkaag7?=
 =?us-ascii?Q?RWWCmsB+GWqnfl7csnrgPp1RDhlAQ4HobMzoKxtPQBPbDqTZz0rFUDZnT8dp?=
 =?us-ascii?Q?QK7wjRKsJek28Pc15c3zfqqPXFoysxUiQ+3/3SpX53PHIEQ3pmvdsrFionfW?=
 =?us-ascii?Q?wjb/t1h78plLN88wUQzb0TWMZU9TJvMpqhbsEaqWJUn5YSxvx7UqnibySQTZ?=
 =?us-ascii?Q?h6BgxVqKA8cT2irtzqLGQj4jRF36sMiKlkTauyxr06K4BdUfte1hC47h8qFb?=
 =?us-ascii?Q?nLQinHcTRpFc+XTZKIa6gOy6YwGO2B0hgMVzylrecE78VvGR/Nsdhvt2rBmw?=
 =?us-ascii?Q?vO57kg2Pi1FiH29y3DxEa5yyE5+VriU5HZMpRGVjwPYQMGQMPQfEMaV6tQ9C?=
 =?us-ascii?Q?1kn7InZigEHzfBxBxE/+V72EkdvzbZqdbO+IXHt1DDXBNYLpALltjPUsnCBh?=
 =?us-ascii?Q?pzGW8iTeyAtSEc4TjbZBMS2Ug7T+QzfEcXywcFfoc8s4lWyBWJEgdaSH7bJZ?=
 =?us-ascii?Q?s1RT66sceCz4A5qXb3WdDpu6O3Mwa4vRTL6GDfQkhL+mCBDC9Q9DhSGldq+d?=
 =?us-ascii?Q?lorU1wC1XruTRn77F4y4IZXSBHMNHVmfgPrBwRPA161p6uIfXJXuLxTT5TFV?=
 =?us-ascii?Q?64SPD4M8zc5x2unhHh88a+3qR0KIEvd8xlGCyJGgPnnhCJ1XEXmLWX8XxyLc?=
 =?us-ascii?Q?o8QOHdUYLhu55IsHaoGPy+DOIxzM0k03NZj0flJ5j0uWs5gqZSmcZ8KPSvzi?=
 =?us-ascii?Q?JxVTrRgIjnqlKz1yauYiqM+TCXd6q+JjokIi4h9pkVggtBdZVU87QLKaQT2T?=
 =?us-ascii?Q?jUcGwnkq4spVNQkUZO4nElGU1tFRwscWeE/Su1lsSDl0VlOcSVwKZFl+AFad?=
 =?us-ascii?Q?KaLYFMVJOy/J8LK3mSND9DQE+FwAMh2MhLa6sa1JKGqORMwLDsH48yenEqlA?=
 =?us-ascii?Q?zJ6WEP5B7PkpbBshEG1zD1hj1LDr3setqboMNsSR2AWkBQrWqidlL7VL8TWd?=
 =?us-ascii?Q?tQ=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: starfivetech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: ZQZPR01MB0979.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 9341335e-f0ac-4f45-4e6f-08dcfc799496
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Nov 2024 02:37:09.3616
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Y4hmmR4iFUKEz+IyS/1VKPQWqEYte4WY2bs+ia6eJytM49u8AoZ5haeyDqYY5lPMEyXJd08dbIovgcwZisPiao1ZdIkDHSx4Noox0vF5Djg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: ZQZPR01MB1092



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Friday, November 1, 2024 9:31 PM
> To: Leyfoon Tan <leyfoon.tan@starfivetech.com>
> Cc: Alexandre Torgue <alexandre.torgue@foss.st.com>; Jose Abreu
> <joabreu@synopsys.com>; David S . Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Maxime Coquelin
> <mcoquelin.stm32@gmail.com>; netdev@vger.kernel.org; linux-stm32@st-md-
> mailman.stormreply.com; linux-arm-kernel@lists.infradead.org; linux-
> kernel@vger.kernel.org; lftan.linux@gmail.com
> Subject: Re: code From d0f446931dfee7afa9f6ce5b1ac032e4dfa98460 Mon Sep
> 17 00:00:00 2001
>=20
> On Fri, Nov 01, 2024 at 04:23:33PM +0800, Ley Foon Tan wrote:
> > This patch series fixes the bugs in the dwmac4 drivers:
> >
> > Patch #1: Fix incorrect _SHIFT and _MASK for MTL_OP_MODE_RTC_* macros.
> > Patch #2: Fix bit mask off operation for MTL_OP_MODE_*_MASK.
> > Patch #3: Fix Receive Watchdog Timeout (RWT) interrupt handling.
> >
> > Changes since v1:
> > - Updated CC list from get_maintainers.pl.
> > - Removed Fixes tag.
>=20
> It looks to me that the first two patches really are fixes? The last patc=
h is just a
> statistics counter, so probably not a fix?
>=20
> If this is correct, please spit these into two series. The first two shou=
ld target
> net, and have Fixes: tags. The last patch should target net-next, and doe=
s not
> need a Fixes: tag.

From the comment in [1], the fixes for net should be for the user-visible p=
roblem. That's why these 3 patches are
resend to net-next.

>=20
> > - Add more description in cover letter.
>=20
> The Subject: like of the cover letter could be better.

[1] https://patchwork.kernel.org/project/netdevbpf/cover/20241016031832.370=
1260-1-leyfoon.tan@starfivetech.com/


Regards
Ley Foon


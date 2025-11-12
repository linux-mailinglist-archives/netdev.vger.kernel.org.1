Return-Path: <netdev+bounces-237794-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B28BC50491
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 03:02:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01BF3189B51D
	for <lists+netdev@lfdr.de>; Wed, 12 Nov 2025 02:01:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2589F2C3257;
	Wed, 12 Nov 2025 02:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="l/dv5unv"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010047.outbound.protection.outlook.com [52.101.69.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBC32C21FF;
	Wed, 12 Nov 2025 02:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762912810; cv=fail; b=XzOae0wd+PywcVjSJ0yUuuWb/v1qJMvlt1vcT0Hx8wjItE2YHJO2mZrL7kPGOxvmyPp+1Kc2NHJPBY0D2wDXpdVZQwQRkNCZyyob1yPM81Q7bvdBawsGivLhkECEljTzYy7EBBaXwgeuEBNDKLj+A9FURbwtd9qSoL/6A13M314=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762912810; c=relaxed/simple;
	bh=hX2aeOVqYza+ZU0N7kOS8JasTbkiTuFcj8IgrOblb14=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=B/QRtOi5JfyV+gFxijSQO4Whp36fFmWDFwnUGL88yhuGgTaxYkjnFWg65gaVxAynHyF9miJ9lWs1xWKLzfr2qK2JDZN8Rkymth5p2R8ukLcZ1b5cb3ivRPj/e0tGgsGQERn2ZQmMmVFZx3ASpZwWuYdPmdfpXWtU0doQ/s2QJJM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=l/dv5unv; arc=fail smtp.client-ip=52.101.69.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lKR+9MiZFMrZlnUK7xhUKKZd4JVlyG1vrsQqTWTM9o1iDZaLIU4i+NR/C5oOWUJObQrUtnXV5btwvckdA3P+Z3StCupGpMubnTE04EbmeW27JG56uZUSFvh+/6r1xChMCdGvPgPolRjcUPGZTPLZ2J7Ods6Ks7Y9n1rDycbXOGR/zwA2MEzDg3gyl6yED4UKSpcopxWh1McwyTUcPLmRSCVVsibPt5P5cp/jObVkgQYQ19mAPwdq/M+PaTjmCCFJYlUvbAeXjmOTbntvpCRkuZoLzRTX3Lr1qO19C5bP5dJre+CQuw3/t4wFJeFUzmbpunj9Zc2I8Zp4I3XuFnNK9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hX2aeOVqYza+ZU0N7kOS8JasTbkiTuFcj8IgrOblb14=;
 b=HcLfZRj84jELHvCqQ4xj2pe37r71bzIEwbkKL6pAKBQpjaQWqYATutDviitOxectU8I6929c3BFQfj8dYECeZuCFDMgCDM9wPBcWwevz25qFdPdMhYnUvWSuptgQ7iourD/NrxJXnNaGDHelMM/2P1Eg7WFLWes+KN5btHKrx2gZ55n7fncdUla2CgcsJwjmsIjhQF2R2HWjAvGUDOReZD06pEcxMS8x3XMk3vngDVs3Z2Lbg4vI6Nj+qzFXE6kWG4FlfmUicjunsWDeDpKBuU4larOFAz5+8I5qD4AUapAtMcAfUfRaiNM3WrpGh7Gb3ZE76HXj3bdjt/Fo9esl0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hX2aeOVqYza+ZU0N7kOS8JasTbkiTuFcj8IgrOblb14=;
 b=l/dv5unvnS0eHbNbr1l+ItV7zzVhMcyqfYEp6mI1w4lyfkZxtLnO8uquxXr9PMid/+ylnbMB8GYEfxApaJuAf2FrEEEHTAl1a+lnce2hM0/O9Jm8widwkc726LGr/gbAMDorSmY/rhwIsDAeuCX0f4OeWcdWyUSo9Zp2o+8MldS7+Jh8cWUtpbMI4QTBbJpZTjqH4WIEEQM5QuZvkJN0ZsVt6YT76+M5wb1XEKfgMdaU4f8/FWClrgNUDlDbTNVqJ7zB3/+sviHh9GC2Zy8orwP/jbwe0LRYUuBYZ3YMyQngduHZxofR+i1BUEEOEiNc/HqCFiWHpIlGPoh81Iy+yw==
Received: from AS8PR04MB8497.eurprd04.prod.outlook.com (2603:10a6:20b:340::17)
 by PAXPR04MB8427.eurprd04.prod.outlook.com (2603:10a6:102:1cd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 02:00:05 +0000
Received: from AS8PR04MB8497.eurprd04.prod.outlook.com
 ([fe80::24f6:444b:9e8d:6aec]) by AS8PR04MB8497.eurprd04.prod.outlook.com
 ([fe80::24f6:444b:9e8d:6aec%5]) with mapi id 15.20.9320.013; Wed, 12 Nov 2025
 02:00:05 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 4/5] net: fec: remove rx_align from
 fec_enet_private
Thread-Topic: [PATCH net-next 4/5] net: fec: remove rx_align from
 fec_enet_private
Thread-Index: AQHcUvIMuEthEp4yc06FM8zZbactabTuEOKAgAA4j3A=
Date: Wed, 12 Nov 2025 02:00:05 +0000
Message-ID:
 <AS8PR04MB84973D6B08C8D8A37E71A8D688CCA@AS8PR04MB8497.eurprd04.prod.outlook.com>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-5-wei.fang@nxp.com>
 <aRO6CS2LcrgZLbXv@lizhi-Precision-Tower-5810>
In-Reply-To: <aRO6CS2LcrgZLbXv@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AS8PR04MB8497:EE_|PAXPR04MB8427:EE_
x-ms-office365-filtering-correlation-id: eae35ec0-c166-40c6-539d-08de218f330b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?mOfAxDrapUqhU818IhCAyCq3XT2M0KvW4D+yzY//mMAXGSJKE1yNK46ZFH1e?=
 =?us-ascii?Q?e9cNrigcFKlI3xoJ141TnnPPUKm9lvNKATGf0YiPrKbcVArSWhLs6Tc1rViK?=
 =?us-ascii?Q?6D0CPKS39TKz1J+MH73oE4gzjghBQX4cZO519X7R48hiNJbV81QnCYG9j6K4?=
 =?us-ascii?Q?9KAHSRzPA4EAsenhoO2K00uxh/JajxrYybJayKTEi7mgoqNrwPY3UxipLTzV?=
 =?us-ascii?Q?HCD/8dT91VZ8nI0N5RP8acAMGPCdMMbIljTI9F7mdKzcIMGmta1Kx4R330ff?=
 =?us-ascii?Q?FiTrIMUaEVSxM7xdcTngIoVs1DgEyrH0WP3TXcsGT1NhCnGCJVCfXf5f0xVP?=
 =?us-ascii?Q?KsBt2E2S9i+b/SiaJx0ma1GKtLMsBFAuLbruBEAlLYNJcImQfKClpNmH8rWi?=
 =?us-ascii?Q?FndSh+buuPgffn1cEAt7dvfd3u1Nc+/mkZV2U0ZCuAoAe6gJN7zDZBYpLMbV?=
 =?us-ascii?Q?nH7fIQn89CwdMNL5DVRestFZrPhg3H/TKtGdoBBUpc/AJ1/qwySoYmuY6CPC?=
 =?us-ascii?Q?0fnM8I72Vib5iiTpjZAf4HwpV6/muLrS7uWjeoa05OhYQ6HjPkWLCGYMEQDZ?=
 =?us-ascii?Q?aXzrHfu77firPgtW9cC9UrNdPkBC0OUQd3dseDH7ugibulgfmqSf5ZL55nbG?=
 =?us-ascii?Q?J/5s21LEc4cl4X68+ehiSp4xqUzfvaxSWvkA77HCn7P19LnQMJy8ZHApeh1P?=
 =?us-ascii?Q?1ufZqM5M9Ru3crB/1Ux2wrLdzs51648Y5IZYTQCxzivYMGp9SQ1poSHQD+CH?=
 =?us-ascii?Q?3vycAsdtwI7jUXPGI0KPQiJugAiwh1eCs8aUVDlJWlmsFyJspUv53Wp8u5ni?=
 =?us-ascii?Q?G6NeD6BWLDsKhlgai7AJ/QCHiJUTUtJtYWmSOZkv72NmpPVTJkeot2meKQil?=
 =?us-ascii?Q?3nQLQMjecZAitgImFpvNVUu1ln03OfGGaoaYG9YNXp9X4ce10eNGdnAGyezT?=
 =?us-ascii?Q?EnxlgQNbxZWD/ulDy2MThRd1KaHimdOJ8fgGKC2IYOglck2FLfHqcGIXIvco?=
 =?us-ascii?Q?FEgzUJNQpEPCaKkkJJ5wuY5JwIsXclnARCtZZ3x3j7phczgHWDmWTr4cuAKA?=
 =?us-ascii?Q?m6GZGT37g8JhEGDVKGet1zntIq+YsY089/4k4LtJlQWZZiUJ2rtmpvbODnkI?=
 =?us-ascii?Q?8El+hesQlccz+zJGo4nUXMZ5WFxnIVd14li+vZ1K5K13sk5nDlRk+S39LT5F?=
 =?us-ascii?Q?NLfySfZBCyHrfR93Q3KFlgVjYu1JR9Xzycv0XRXQ6m1jDU/gsnFF2JM8uhcS?=
 =?us-ascii?Q?Pw/TM5VBUMc8dOHRRZil5CHDMaJhwXRCxS/VmdCzJgFxY9xo5FPHgsRIay4v?=
 =?us-ascii?Q?yohq3bR3exWhCiq6W605i/wxLoPhun4D2RAvv0ruAAZgzZp3KvSXTeK8YBID?=
 =?us-ascii?Q?++d8Ngk5QFr8WiWsH/xjvagULf+kgFSPQpJ3ADgms+YMXdRv7cQ98nbAptf1?=
 =?us-ascii?Q?Wx3KFFTNWjHUaiWT/yyrz3G45Wd270qN0eR3/fmizuZbVfVjorzMIgr3nozw?=
 =?us-ascii?Q?yySc+6X1DCCI063+NzvdpiIZ/zG8FWfctsFI?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS8PR04MB8497.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?c81xWPU6bqzZvWXC+4yxTsnV0AhKOUpp0FC8n1NWBNiwW4xgkivWc6cy95Gh?=
 =?us-ascii?Q?4TcsTc400paQ6bm4K1G13qVfEGNaRlLHDLSoxG1UTQUMMvj4hw5KmVIVEYfu?=
 =?us-ascii?Q?PVY6HEF15vH3GdTyoHqdc2+57psM0KU+GTc8WHPMAWz9PJTdH+lzJLzBojJB?=
 =?us-ascii?Q?OMFurWAuPT2Fo02kKRGIwY2wQH76Hhy3YNNXdyCsoTqE4j6i4qHfhIx7n+V4?=
 =?us-ascii?Q?KGwM6kzm0ZRoCjD0nvM6mjCRXgm1eap8iXghUiuebgqDJNeQtcMCY7b++Ofe?=
 =?us-ascii?Q?5YV5qCMCqGYS3Px0ORsAyihBT4SdJsJjqMDytqNWWvGc+SYYEOyPMLeTip5G?=
 =?us-ascii?Q?kPv8N61VjoA65sO27qG8ntwBc2ZnYCufwFZl6X3sCRTeqefIu3In1xWh+u7u?=
 =?us-ascii?Q?Min3fRB63fHR27dfl49a/qRTZCKv66juXRD5ceWHwK7goqIb89djXy3d+7To?=
 =?us-ascii?Q?YRkdph33fOGE0mIeMYbHA9RR1FfNxCQEZ2xb942ljD3bYn1t+jMaRotSFasJ?=
 =?us-ascii?Q?UyonJ5vu6gBBwzuKEUhS9mfdfH3F58HXlYbLc1gT2zpQqMvAXjqqO0D9lZVN?=
 =?us-ascii?Q?SCfoSdspPLnvC4WdElgl/OqsXqyfyCMElO4zXvezzcJyb3lZaH2h7m4iIoY7?=
 =?us-ascii?Q?z1ib3rHyL/IMJQN+xcsjRZR0/fNnrOl3ICvJ6H8sKNUeppKRFt6Lj6MW8GVq?=
 =?us-ascii?Q?P62C7iIUq+y6uxtiSuoDtLTpgCJuJydDHur2Zh7VQ98hHoGq+x81+VOUmQPy?=
 =?us-ascii?Q?YZ+N+I6rXgnRgMMTQ+aI7NrhTtY1Is7RJyKKJQjfZNymEGVsN4Kad0ITp1Kl?=
 =?us-ascii?Q?9BwSwbErqo3eFVZiQbi6gXSPe4ng40NSDESH07sYcitHiVE0uA6bl+FV1M9P?=
 =?us-ascii?Q?SSqBOdrXfpFXiEB2A4tURytf9S9hyzncGUFDVMLkHnqUq/scV6S1GuERppYe?=
 =?us-ascii?Q?qbcMo9KncfYIC6XLwtOU0ouQmwn2mMNP2DmqvxTr8tSg5lNLQ2Mpr/qyNsL+?=
 =?us-ascii?Q?EjPw11xo3dfb2tny8tvrXUXqfDILiNug4QmK52Xy9L62yTwI2kyMmNXcEVw3?=
 =?us-ascii?Q?Zq88SxXPicbgs6UUM9DIIW/eKZkQB9E0V9YWB+Zn2BrXYJpjq+uorzxLMIyb?=
 =?us-ascii?Q?xOQWS3Bvr1PE60uR+3SgtmRQ2IAjK0oCAreX/PG/ecbKr0ryRfTTgb7oFF7T?=
 =?us-ascii?Q?r+f7xp7kX+bzfoNVFKqWD1mJeMuSa11P8wT0jfQfMayjnoReIw5FtPRl3g4p?=
 =?us-ascii?Q?P4/8QRntYWyp6D2lKndMQlxxeOTZO997q7hdd/zh4pN1AtWdz+uTZXvK5pOz?=
 =?us-ascii?Q?Ou5bEo1ox5CfENRmgQKMRzY+gCRbQT6qhbpfAAp7pQ075W8DNOhrJg0dEY8G?=
 =?us-ascii?Q?wF6iM34N8wABrkuOvJA3LgBIKCvk9demXgAyKL5G32cxkPwgbpmnjcfo+he/?=
 =?us-ascii?Q?cCeV0pF81vXqyOEXk/C8i7nXrWk/ETYy15xAwB1NU+I5tae5NF1hjLNK6Cdz?=
 =?us-ascii?Q?d59XV9vVVkmF0G0P1d18oQcMDzA3FpvRpWiD8gfuKbr5/Wo9/x1ZaHcCTHTr?=
 =?us-ascii?Q?9NFUfo/Drp3wGR6WIIs=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8497.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eae35ec0-c166-40c6-539d-08de218f330b
X-MS-Exchange-CrossTenant-originalarrivaltime: 12 Nov 2025 02:00:05.2634
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: og7VJCREBydMmzYQD08Jp+wfYeTL9S3uOuqH4wWE1RBv28e+S2chk7ptMtWe6hND25tACwPefQATrxPYEZpNug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8427

> On Tue, Nov 11, 2025 at 06:00:56PM +0800, Wei Fang wrote:
> > The rx_align was introduced by the commit 41ef84ce4c72 ("net: fec: chan=
ge
> > FEC alignment according to i.mx6 sx requirement"). Because the i.MX6 SX
> > requires RX buffer must be 64 bytes alignment.
> >
> > Since the commit 95698ff6177b ("net: fec: using page pool to manage RX
> > buffers"), the address of the RX buffer is always the page address plus
> > 128 bytes, so RX buffer is always 64-byte aligned. Therefore, rx_align
> > has no effect since that commit, and we can safely remove it.
>=20
> I suggest keep it as it because we need know this kind limitation in case
> future code change broke prediction
> 'net: fec: using page pool to manage RX ..."

We still have tx_align to get the limitation. Or we can add a comment
to doc the limitation. Invalid code in the driver is pointless.



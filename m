Return-Path: <netdev+bounces-239335-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id CEFBAC66F79
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 03:08:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 28C17363734
	for <lists+netdev@lfdr.de>; Tue, 18 Nov 2025 02:06:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01DE931B123;
	Tue, 18 Nov 2025 02:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UE2H44zi"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010064.outbound.protection.outlook.com [52.101.84.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5D0F1D2F42;
	Tue, 18 Nov 2025 02:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763431510; cv=fail; b=HNmLhEDCi5ecMHtzep97cWEkaq6vwSkxep7Yem1Ue4yrUR0SPVPTGrOQQNXKuqaOOayue9GB+O3loHpikphdtJZdSG2vKc3XkL99NRDi/hB9v2kLMuwwVgxOcXKN02mWzip9u+mhFkwKz9x2FYTfWZz46aWGvhGSqMw3mpDtNzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763431510; c=relaxed/simple;
	bh=bJKvKEzh3UjpWw7s3FWPwRJgrym27yEfqOYG4cHytlY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BC19mEPpLL4YrpseHg6wJAjQ4au0wlx+krA5HlR+NmQQSLam+9fTkO0TWJe0ShL1StqfDKMW15Ei2aNlJu3ppaenOAxvJhvoAGVv7G2X9QuBQ9aw3aMYtO9OznhHVHs1NXF8KZdX5OgZs54UJXkJpkBx3+bZN1v3UyEpSM5tt/k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UE2H44zi; arc=fail smtp.client-ip=52.101.84.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N53Gt4zrx5laRALlaToz9+uzgswhnVzCn4PGKtQoAQ0GLGgljKL5QfXw2FAem8SbDcdpzh37+59GKG8SWMtYLONiU91WenDpsy7239nwqw0VMLOPp2mJedxPwyAKuQahKkmpaaHfP0gVocYzFlMhI5A1XQaibRWFiuX7t5l2FiLe49y8VsBXqdWmeFgEz4ex8h1TyXca78xAecgb5slCieHhYMPeQXAvIFKftCU5ufG5ghGtCU58QANJQRcyH7UBMjw7204li5YpZGfMsu30WjfJmu7MPgtYsECF9QyFPgd4cVOgMIGM53PPjw69Sgwerjct0ZLpzE9O+jhcn+fZig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bJKvKEzh3UjpWw7s3FWPwRJgrym27yEfqOYG4cHytlY=;
 b=x0lv+yyaBTz+7bMfDSvCnT1Azdjv2o5uq/kATKjc1EKdNnyqq4LVgcT7QI/NwaaxD4IGq0HUosDGchatOPIYSD1IspPZTL+S4/FqyInbqStW8TlZeqLYz1EQ5zchwsGTlNsTQ54o/gD+Nef4M7hhHYoTZUe32fcoQrC5b51wySwAEgLQwv3MZil0oBwbnMQXihogJHi/yljubx05/Y0MuoQ2E/vg2DDu7jeG5hCxVsgqPD7TK8lDWy7BV6k8w5R6Of3gSNZJB4hK2Nz6ZDdH5WKuSWk/J+9Wsg+DyNISzl/LgaHFLU69QVquv4TLPmalIm9fQjL8YVLf6slLLrlVCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bJKvKEzh3UjpWw7s3FWPwRJgrym27yEfqOYG4cHytlY=;
 b=UE2H44ziPhNXdoB+wgWp3ouD/S+dp8PQtwldJplQAYRO/mqxnWVgOpXNVzX+IaiqPjXFA/YZJPlZTJ5WeHrNmEHOwvWlpLU9D0TCkDTfBTRnir9pxzsDlJ8meQtUijF6h93QNjLfncrAmKqkbumscZOUzlgk9wsQtAByJHbgDaTmpiKdY2d8BJRhdoqijOir6XtY2bUG1jhDIFX9EnY9Iq3NUYSbIQCMO/VcraXRh9OA4XlSMuQBDfvWj/0ccU7ZHHPbfNldYQuE4FH+r9IW7H7OY2Rwpe2K4boKP1AoSfjRcmAsEVauFZ3IWP6N5aBE9Q3MdnE+ARtLx6ugrK7bqw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB11939.eurprd04.prod.outlook.com (2603:10a6:800:307::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 02:05:06 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.021; Tue, 18 Nov 2025
 02:05:06 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Russell King <linux@armlinux.org.uk>
CC: "andrew@lunn.ch" <andrew@lunn.ch>, "hkallweit1@gmail.com"
	<hkallweit1@gmail.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, "eric@nelint.com"
	<eric@nelint.com>, "maxime.chevallier@bootlin.com"
	<maxime.chevallier@bootlin.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] net: phylink: add missing supported link modes for the
 fixed-link
Thread-Topic: [PATCH v2] net: phylink: add missing supported link modes for
 the fixed-link
Thread-Index: AQHcVqH8wRDKQtD4n0GYxJSxykL38LT2/UQAgAC0ocA=
Date: Tue, 18 Nov 2025 02:05:05 +0000
Message-ID:
 <PAXPR04MB851052762C78966B59B96AA388D6A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251116023823.1445099-1-wei.fang@nxp.com>
 <aRs8gMOyC9ZbqMfe@shell.armlinux.org.uk>
In-Reply-To: <aRs8gMOyC9ZbqMfe@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB11939:EE_
x-ms-office365-filtering-correlation-id: 6acaf984-5ceb-4736-8147-08de2646e4b7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?U7uMuI8SLkTCVOpnDckOvqBMwST/lquVBGHeH74O0XeXbVjIvh12kBiBV8YO?=
 =?us-ascii?Q?Ivt5Mbx4/DiBgIH7apdSE1SRyqSNhgvm9nMoU6F/Jo8dvdRDZcMosXEOpuUE?=
 =?us-ascii?Q?SDts1VWxBLnO6rOameEZKVYgWFHozV1GI4Nr10lnnMme7FUW1vq+d1Kw5Xjt?=
 =?us-ascii?Q?Nn1i4orXdhOCISfvwHbvQ3h/9RAWGdHtlEg4kqpLDpRRxeCW7BJp+nRPsg14?=
 =?us-ascii?Q?CDdUtZryJ3oQlCqvr6P/MbwBygQzsERkg+bJUww/5yb0ccpA7L68+PdlswaT?=
 =?us-ascii?Q?zxPXLrm3GY8PKAVP7BkKQHMUjOtHbaYApLyLlPBAaHZlbRv7rym4CoDyNoMz?=
 =?us-ascii?Q?PawzpHS7NSQ5+8ab0HZqOD4VLvTqY2Ig7qgSZOV8nQ8TtVXtshE1ZQDgMzXE?=
 =?us-ascii?Q?Yg0FApBVStEOxnDAJ+09Or+TDjReK35Eo2Z1jDGjmf97mr7cfTqbnlYxRqJM?=
 =?us-ascii?Q?+FSS+R3nZ85tw3agEl0jnqHXYPH4aw3kaNm/ydMZ24UlEwRcmkbs8rQLVo0i?=
 =?us-ascii?Q?N3zuhyWcIDIOYx6DjdLTeL8AQ+BlmT7m5oj2kIX/F3TTR9cfIAglfUhRGERQ?=
 =?us-ascii?Q?1NMwwivcsoZRsRwnR6IlutjIYLxp3bAxw22zj8cjDZFJljTjqIoUriTmmvtr?=
 =?us-ascii?Q?DfgyWJlbmF/voTJQ/fgt5MbEhiGto7Wk0YxOIQnsPdhrHzWXEavtaw6huo56?=
 =?us-ascii?Q?qOf043f4kBjPbm5TPbjPFzvD2yApgrC+NuEUaFISSsryLK498Zb1I7R5Q2Xh?=
 =?us-ascii?Q?+Y369mhdoUlplv61iH+on5aFANBbXrtatukdMpgqJY3BwPnUt+daY9id/N/I?=
 =?us-ascii?Q?hx3lnnRVbbrdzn59xasKiszD9gO94lFaGAravYT3EJBKQtHxELAb/l1fn8sM?=
 =?us-ascii?Q?ZbthpbUNKTbMvlpfXjsx+prtOysS8AaKtNo5Ah0cWMvIn70Scoxym+LjZVZf?=
 =?us-ascii?Q?luag54TzG80Sv1x6kD3q1GRdCtrxfInV5tbcItDuFbMYbXVl0TSMayTw/XK5?=
 =?us-ascii?Q?9azUVr6QQhfspqstTGHhe28jtV25onQjY6IXY7rj7y07vLx/3GArv86PSymQ?=
 =?us-ascii?Q?6WO2RPEo6TRbcvJx20yYwfZTd6LzvuZ3WoYwz76xi7X3aFqI0Dl57I/gaxkj?=
 =?us-ascii?Q?e81n6Y9sxOqU7xm+W8DOFgnLNPBdtXDjmrcTj3vcxmV14KOY86Qc4iTEEaOv?=
 =?us-ascii?Q?OJ0gVSxdM1M53fTqtQyqLapO6oFc3OrzmwlkhPfvxfsO+fWDey9w9U1x2GIx?=
 =?us-ascii?Q?/FbW7ZVP6HgZbdMiXRw6gvsXcUGGJ79aOBB8FOCBqazym1E2TsB5780qYgiJ?=
 =?us-ascii?Q?evV1BrKyaMvcgkUGQRtHNZIcHzI6PB69DVJLkNf/1BAc1rxRqZ/sTY7royBX?=
 =?us-ascii?Q?Vj0Y29yDAe+siqcQfyuhfjMlUOnfBx+yFyXH3vx7T3ntud7voxO99wG23Bq4?=
 =?us-ascii?Q?1ofMSLgu9iiGDNtmWQzyA4V10P5HOcF5N+1HvRciG8IY8Fp8ON4Whq05zP+v?=
 =?us-ascii?Q?i+sztP8Fsgm5zWJ71d7FGTb935SzKRUZXjLK?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?gNHxpPb9cSph0GuJhtqBgwD6Cmc3Dj5mVwlP552QjQRsgjkgtO6865W/mG02?=
 =?us-ascii?Q?Cu6a8BeFxcESWbRCSEMZjeZRzTnk8qPjXfnIsQJZ3VbBVDkp6+a/uFQ56ax6?=
 =?us-ascii?Q?WcOjMphT4OUK9qOEijEVC0EdHftj1pzkrdYNoDJcOwuFEXwtyIR5oTZg9jw+?=
 =?us-ascii?Q?uPPwwKjxGff1ttjQB2SFQyWGrAn5XU3bccyW8nojXsqs+oM7bJGGngmfhA1P?=
 =?us-ascii?Q?OUp5F02i5rzY1Vf31KiQO6GwpSsWvEn1IX5llgrZue4NSGlbZDcOJMbxf7n3?=
 =?us-ascii?Q?gkG0HqBPr7CUU3hY3+Btliq91tU062Eh3RVFxdB+PBj8ZN+1wtCgUqyPcMjN?=
 =?us-ascii?Q?Y5Uche5/bMJY8+cpimUPczYhMlRqCQ91W47WfLyT1ikIo0zAznvUukHV6vV5?=
 =?us-ascii?Q?FPnLculthOFP/2RWxnBkCG5U2xLLlU4vuXGrtH6FJZ44U9rnAhHKkMJ67MGL?=
 =?us-ascii?Q?gqkbs3iPuDFeNrfeSczMHL7qFGMnPzPgtJRzBWBpuokbRQhf4dFtpuFXxuhb?=
 =?us-ascii?Q?c9HobR3WZnkDZI3z5jh5MtyhDYYD3pB36pIe6hke1taKtkHr2qm7+u7Y7M/e?=
 =?us-ascii?Q?04ImMF5S0SW6/B9QTMF5u6z/jroCuU2h3hzhFsTUPuN80Z01ux9/2IgaT8ap?=
 =?us-ascii?Q?HQm9hfS4Bv9sf08LfwPtlIdp2IxsE0HoI41RMyy1BTfo+qEKI15Mul+ldLPb?=
 =?us-ascii?Q?1BYpI+skB0iJm5T4WzUqiWxuRs4vCCS2grktvhv3wBKY4SMht49ve+dEnnPR?=
 =?us-ascii?Q?8swLz3LL+o6Ei2R45491ZoSwAr7Py35dhDWj5qjeD/atPcufhJvyat/5wF9D?=
 =?us-ascii?Q?U2Y9z6Un6Tt91Usd8CNcvYy1QGF0cTV5I6OvMWUHWj8SUuFlmb6ANievAOnF?=
 =?us-ascii?Q?iatnA46exfQNNySYcD/1I5zaoCP5tlqy/nl/f9zecy9brr/4CYGmaRPLyO1C?=
 =?us-ascii?Q?MVPvGa2KWSxseipfhnCmnAuznY+SS+48lixhXPNwHb5+/gTQ5tr75Rq1EIOo?=
 =?us-ascii?Q?tGLa3RWUylrnOODhe64Kwr9jXkudNWxHaQJEN4Nxs/8XzTONX8Z8x2HIesUf?=
 =?us-ascii?Q?E1jDoDqKQrk7DsqIEv0JKN+hJ6aB3GpTnDjcUU03ix/eHjKUFyCICBXlUf7U?=
 =?us-ascii?Q?LNAU0DGpoe9CUfayiXoP7p/0MMgr+zuCCCmq1bl49ZLXXtAlAJHxelI0WSat?=
 =?us-ascii?Q?dVAzkdDlvYljeEx8W2IwMryuIjmI2TrawMTbqupUFPVg3qWn7HmzKuJQsMTD?=
 =?us-ascii?Q?yqHqv32HGxgOJ01F5nj2JMfx/a4NtCB6EROKL3iXUHmRlAz61rAVHr7yvur4?=
 =?us-ascii?Q?mwor7CCZLLRUcK41ftEddeYjOQk54G7sV1u/Eh+FshA+jpEqPXK749hNQf5k?=
 =?us-ascii?Q?ur+4wsptvESG7VHsEzQRWlP8VaMr16fsRvkUZV5MnOJdxqaXx7B+c44TCGWJ?=
 =?us-ascii?Q?CXkg5Z1d3GZpeOZlMeUV1vODIxHy2BAOiKEiI6EU8IGIk6mxoMpyPyC8NJWr?=
 =?us-ascii?Q?wkhnBTSmPn5Zq2fdKO3AmPR3H3nbtXTNS++aJFjvfZaPQ8+UpBfvAOELitY0?=
 =?us-ascii?Q?iplYyijc9usnE75akxE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acaf984-5ceb-4736-8147-08de2646e4b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Nov 2025 02:05:05.9533
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Z4U844rrmUGHGmlF/6TNLhEbTMJN0cXCEok3MRyUicBeFzyvI3ti0DZ3wzb0PnJw/It806SPl65kAavtGS6v4g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11939

> On Sun, Nov 16, 2025 at 10:38:23AM +0800, Wei Fang wrote:
> > Pause, Asym_Pause and Autoneg bits are not set when pl->supported is
> > initialized, so these link modes will not work for the fixed-link.
> > This leads to a TCP performance degradation issue observed on the
> > i.MX943 platform.
> >
> > The switch CPU port of i.MX943 is connected to an ENETC MAC, this link
> > is a fixed link and the link speed is 2.5Gbps. And one of the switch
> > user ports is the RGMII interface, and its link speed is 1Gbps. If the
> > flow-control of the fixed link is not enabled, we can easily observe
> > the iperf performance of TCP packets is very low. Because the inbound
> > rate on the CPU port is greater than the outbound rate on the user
> > port, the switch is prone to congestion, leading to the loss of some
> > TCP packets and requiring multiple retransmissions.
> >
> > Solving this problem should be as simple as setting the Asym_Pause and
> > Pause bits. The reason why the Autoneg bit needs to be set is because
> > it was already set before the blame commit. Moreover, Russell provides
> > a very good explanation of why it needs to be set in the thread [1].
> >
> > [1]
> > https://eur01.safelinks.protection.outlook.com/?url=3Dhttps%3A%2F%2Flor=
e
> > .kernel.org%2Fall%2FaRjqLN8eQDIQfBjS%40shell.armlinux.org.uk%2F&data=3D
> 0
> >
> 5%7C02%7Cwei.fang%40nxp.com%7C046af7619cb34d31ce1f08de25ec6ac4%7
> C686ea
> >
> 1d3bc2b4c6fa92cd99c5c301635%7C0%7C0%7C638989894529904535%7CUnkn
> own%7CT
> >
> WFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4
> zMiI
> >
> sIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3DC3b%2FDWqT8
> yliu6m
> > tGDX0JtrdDevoTik74gZwn%2F1%2BJXk%3D&reserved=3D0
> >
> > Fixes: de7d3f87be3c ("net: phylink: Use phy_caps_lookup for fixed-link
> > configuration")
> > Signed-off-by: Wei Fang <wei.fang@nxp.com>
> > Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>=20
> Even though discussion is still going on, we do need to fix this regressi=
on. So:
>=20
> Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
>=20
> Thanks!

Thanks, based on Andrew's comments, I have sent a v3 patch.

https://lore.kernel.org/all/20251117102943.1862680-1-wei.fang@nxp.com/



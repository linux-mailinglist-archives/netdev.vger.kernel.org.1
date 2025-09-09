Return-Path: <netdev+bounces-221272-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13B3EB4FF99
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 16:37:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D3F37A912F
	for <lists+netdev@lfdr.de>; Tue,  9 Sep 2025 14:35:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6091F34AB18;
	Tue,  9 Sep 2025 14:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="XGV8I87z"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F347274B35;
	Tue,  9 Sep 2025 14:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757428641; cv=fail; b=gK9NcOXgwMgRJHuFVpHsFp1Fumek338fmvdI/mCl4Zbs/6GALbZ4EkKLsqkGlTyv22JEfod+hhGG7akfuflhi6a5hOfEnmuEXr4l22beLF6VEkmTZn1BipBVArfi/LfiATyMZzBzn5xPpm9hB13hBFw4h28ZN1FPnYbd9YTDpPI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757428641; c=relaxed/simple;
	bh=CwXfrmcSXsIXEZa0ZpO2vP+K9oKlJVlTIVXil3oXlN8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RU/gVFLNxpoReRi2GyGq++S2ceGxO6OV/53eZ436k4f2pCigqAtsb7tLebNlDdsvSjAK7S5Bdd3DecZSbkofHFHl8ERUEeqedPevm6b6dG0q+qdL8CuKwQaoDJYBj5qwoUS1ePpxV7OGVtm7LFI0mtnyG++w40rpCeTSMVHv7Xo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=XGV8I87z; arc=fail smtp.client-ip=52.101.66.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ckIThclTKeKGjAcMOcRMsha5JixZzH/7RUwehPtQyA5iUpxfgJLTz5jKb0xQ66oN4QmJBiY1jzatXz6OU8YOcD1OTl4hmEYUzfNOSzSi9jmfw/lqFMSMJjipjnRNhMiGcAz7Kg26spjydCwFRLT3sSnCFrZfuqlwBozAjHydddbQVK5UK/R0lsQ20bj0cZ/4PXt9pWAg7+oyIYylpLAeaePsP7pGUezRms8s6mIo0jRIJSe41HqNHdLvsz/J5lRv1znrsf496i+EbCaT3G5RBVnX9vXUUult7eYtdKuPdPesfVU9lFRjxJmin0qagwIpfwUu0JXWZtRYoXNO1Iyurw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IVowVX7s4OoaKjyG+yHfBqF/OOSZLrfZUDPihnEl+Rc=;
 b=i0ga0RrCDa+2r0StGIhfQ0CRcAP4aPfIYoabNI4olgD3eI5Fg5Sit133eSKT0qG3O3obYgMPDANJEnMuEzO3p1gAH+qadtYktMmbAsBNVriM/UN5csVUjqDLpHAq2HosHpxsm+J/n+40ZTKY5X0RdcXvydw+i7zvySfsmeUmpDWSGj36lakG/d7TOpLpjlgDGadLEknTpDn+1RluovVvC0aVegD3SBzgu4Ju0N9DZErz6Xxw8EZ6VbFV4azmMbhH/Y0j3SFlMl9ylJj8NTol/aiqBH80wVe5q/1H3yGsKzmhxkfgbN6f6kBkbjS7i1afNdEIFyUTABv2hdjtYDpwLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IVowVX7s4OoaKjyG+yHfBqF/OOSZLrfZUDPihnEl+Rc=;
 b=XGV8I87zbKR5H2wbY8ihEKzZpInbNEm0S/MC2x5FcJizH8e1akRiiHxfhONkYDwnDJuwLscEeFR5bZmTm8IeIvYssXc0RghgKoW2yk7XZdRzy7eoSv+5tw3OXxsv6Qp8dCB9xn+VEIMR5LtSZy5yxaykWQ1SIhyyZOJItYH32bAHj+wKRiuYvC+c5+BgHEYsei9JMiS1CMaNA056JhhROC+MZergSTv0OcdxaJKGOB0Sf0khD34c/tEfWxe7epBQPg6Pu+Mmcj2ZFYuaN0Jz3Xwe1KjDZ2g+SgTUNLmkonHvEzkgHkkLODm39Z8zXXD2919wK7AS8M0B0yTYrpdjQQ==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM8PR04MB7299.eurprd04.prod.outlook.com (2603:10a6:20b:1d4::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.15; Tue, 9 Sep
 2025 14:37:11 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%4]) with mapi id 15.20.9115.010; Tue, 9 Sep 2025
 14:37:11 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Wei Fang <wei.fang@nxp.com>
CC: Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Andrew Lunn
	<andrew@lunn.ch>, Frank Li <frank.li@nxp.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann
	<daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, John
 Fastabend <john.fastabend@gmail.com>
Subject: RE: [PATCH v6 net-next 1/6] net: fec: use a member variable for
 maximum buffer size
Thread-Topic: [PATCH v6 net-next 1/6] net: fec: use a member variable for
 maximum buffer size
Thread-Index: AQHcINw7S4DTsdIUOUyGePXr1GhdXLSKHJCAgADPe7A=
Date: Tue, 9 Sep 2025 14:37:11 +0000
Message-ID:
 <PAXPR04MB9185336929DC3D5E5B858ED0890FA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250908161755.608704-1-shenwei.wang@nxp.com>
 <20250908161755.608704-2-shenwei.wang@nxp.com>
 <PAXPR04MB851097411AD8CF1B4250517B880FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
In-Reply-To:
 <PAXPR04MB851097411AD8CF1B4250517B880FA@PAXPR04MB8510.eurprd04.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM8PR04MB7299:EE_
x-ms-office365-filtering-correlation-id: b28c56a8-422d-4da3-968c-08ddefae5cb1
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|366016|1800799024|19092799006|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?6WUvpKGDOfJq/hZJBpIxiDbEi0yFz9IAkTEZXMXUKgAdqmVehS83CWcJ9/3n?=
 =?us-ascii?Q?ntTcdIXmBtrNIfJz+QbTsAIkCp6M4+dJS9GdLEdzwc7v7yaOXB8lu4rSY1wd?=
 =?us-ascii?Q?PwJOZHk7B6suME+Pa/e63bKJuwkLPIQycs8GSkVVN5K+LKThsbZ/mnyUWFuk?=
 =?us-ascii?Q?IodeorRBmjdiSSINo9Bd1+zaI/wXxAKXfxyjNwNoTBzfhBpkAxKv2fNUctV7?=
 =?us-ascii?Q?6h8gOHeQggdBFTljU4ko92YBTuKgPY62WvvMvTIm92UfXj0buCi8O2YeAXAE?=
 =?us-ascii?Q?rPMvEkkcn58zN2fxvdqOSL3JBlQBLy5Pj5IGZYerMdK5XI6IXm2oNcU7dor8?=
 =?us-ascii?Q?YE4iyYlmX+IQeIKjPXXtT3lznwFXc2TxgYacXGt2+IZ/WLF/Mk7f0/A6XLXx?=
 =?us-ascii?Q?KRAnZePXNSzY6d6S5OacaBHQr1M2aJeUMWTa9f61ep5zI4+q8Lq+1kJay7Ya?=
 =?us-ascii?Q?/rqvGiEH1KuZgM7nX4+2V/L9J+lkwUPddfrYSEhfHyLpSh1qi613egArktUS?=
 =?us-ascii?Q?zLDXMMay2Baj87uHM9PPxNWFLsgmoVogBR4TMJrWLYg4U+oIG82LnJDYvTkB?=
 =?us-ascii?Q?aGALYbweLf3tjKFFVwBbEjIAz9PH2ZKyZ+SAURGKXMKFRk4d5YaYDC+XmbEk?=
 =?us-ascii?Q?8QSCloqDrgplojHrNoAW4YzPNuCZzWdpXD/v56OXXnFR3gw4TuKk11/3p7PB?=
 =?us-ascii?Q?Ndioo1wOHo4cyKtxHGtTN3+axkV502iChIEn2taYQfVL6ET+O5LaxHCkapQy?=
 =?us-ascii?Q?FWDV4c2zIBnc2EgLgHSRMgbE5NDVDEt/3vvXsFvLR1Rx9WVLMjFe3cg+trQu?=
 =?us-ascii?Q?SW2fuwuemWu6SvHkWcggX71IW6a768d++0XPKR0OCf3lLeruTQdWvTJViuVz?=
 =?us-ascii?Q?SINsAVjC16JrnL5z9Pvo9gp6kURGsMf+co5LY7/Yuq8Sw32U3uXUwSK6TFaS?=
 =?us-ascii?Q?VmxCqs72TYKW8p7DjujP/546hzQDbofunJQ8oGDdAfRFNdYM6B8c0EHtBzMg?=
 =?us-ascii?Q?qGu/wkf8upWjtlKsk/MzjbqHz88kcTZr94QTOCfbdkduq5vsJeUJW9+XT1Pb?=
 =?us-ascii?Q?SA9kFiCmISgVj+lgisfpfVmWpEm3dABUckL3UdXrHeg9nYgp+7Y0qIarpvTp?=
 =?us-ascii?Q?HGxPoPWbIud//oibUNsvTVRCAYcxCbqxyejh7b99FGrnnhp1PtRWRwmTjYgC?=
 =?us-ascii?Q?LS0Y42bJnbbIhDkGRqt4FAxE2616avwXh1ee1qHNmC9gl4TGPGRugqtvenNx?=
 =?us-ascii?Q?0FjvRq/9DIPv5+yMAgJBBGcN+LJE6UR2EmB07lVRa0K5F1PP0iIR7pO4pxpb?=
 =?us-ascii?Q?DOjRDcjnB23OovPsQQCF+tX1bQhpFLbzVmu8nbP8z1nutdOCzNqA2XFAqprn?=
 =?us-ascii?Q?lndn+raSV3Dy0UmnOKsL7gLUsSE97W9lXDalAdUw/PY96bGtSl7gCMshUucE?=
 =?us-ascii?Q?QLQ+ZieTAFPPrbEedr9CvxAwsdxIZp0pKU/Tq79pSDblvFTAFRvdHqlTYk4k?=
 =?us-ascii?Q?G0Yk9IrcMXN6DHQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024)(19092799006)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?+NPpr6a+Kz70rTjHSGrCAX77LT27b55ADHrxuMRTKHcnP5E8FfIVbxi6ZMfp?=
 =?us-ascii?Q?Qs9vuk5S4H57gCA3dWm6wMBBT7O1hq1FziiMHjQW4CHKm3GD05PV9vFN3oEx?=
 =?us-ascii?Q?Is7gqZOuE89n6dfsQPCadil/ajBshnAuuIw4LfhG7zl4qXggP4CaEn0weoYO?=
 =?us-ascii?Q?awBxFH1preFO38u7W8NNdxfER0wvsYW1U4AHqLi3wHdezezcLw7Pzgn7FgUi?=
 =?us-ascii?Q?mXOcDodz0reRNOPydjiUCeLyE9v1BI2YHtUZbPNwGgkuGiH1ecXWj7hIydp3?=
 =?us-ascii?Q?ateZ0eHz/NxYcuhs/6GI2QSCksM6tqqUQnRmsDj3vURtAFaWPNmYE2QwGB4i?=
 =?us-ascii?Q?gn7RJkeEb4MfGhlgyehr8EFEqIOt4EH28Q+XDq9D06xTyb1eOR7PE1h3B6qt?=
 =?us-ascii?Q?oxrsIr0xu1xsLXcot+Z6WYZ8WJ8s0neFJhKJrN3B/0+v6m2CT3BULU0k7OaU?=
 =?us-ascii?Q?PFMx/UKNK4dBh45Oc9ZxlkB01WQ4Ee23kFWc5ybCiYiXsFOHCB8zI6to6Fs/?=
 =?us-ascii?Q?7DsBJtogHy6Mrr6wetLFWl7ZX3RH4FYvK8BoOSf0MPGCAxR6IP0BdpoQbhy5?=
 =?us-ascii?Q?22s+DcOrYH2A5LhvHsVis37ujsXg375icKq0nVlV0fCrEvmPDhidjeTENaX8?=
 =?us-ascii?Q?b9xRuJ+QDfnYObtTpX5rF0X/ehHA1xPrKOlBqM/CZVSO0703S3DxMicSP41B?=
 =?us-ascii?Q?iM9Ea5cIZVFydxTA77klphPH5jgGbO6OjfkkFklt2N4Tjv7IhWfq30Dd4NVv?=
 =?us-ascii?Q?LEnC2JocohTx7qtgMNrqXAiTUP/C4BV/wtTTf0xyJF/K1TVWHrXGtJ6fCJvM?=
 =?us-ascii?Q?FyLsXmVQUSOdTFtDmoE0pkspZf6sdP+bwovxKIcfv6616uAkX3qz92ua5J55?=
 =?us-ascii?Q?2jGBeTqm9a1MlpXy3jLWp2rrvDjUSJMcH1vx5j2cOZCG8ZBbdoJor9eKuxTy?=
 =?us-ascii?Q?JsnvWMnkpBiTKRmToRaXWcnxLylhr3C13wKUQW1CTlAkoJFVEHquCdm1VBWi?=
 =?us-ascii?Q?2t/bZ0yo7trlJb+sOn5tKx1sl7UOprmBNCaI0PVcQ9IIo7UNoDp/F3U6Sbpn?=
 =?us-ascii?Q?7ZHaWyrLxFEJ0BFUbGdgFWfze6z/4QrtbGfIR2Bd0wWtagTJTKZrs7iR/PQS?=
 =?us-ascii?Q?f+3hUKZ/W9C9Uxr/cT7Lc3UNuCsW8ViG1R1UcjC0ydaTLLFH5gpuiI4Xtbkt?=
 =?us-ascii?Q?B3jq4xMKRuiQmb+Y0y2TmJTyMjFZA7kCClmfNJvegVxBmRWwwxCg8ZUr0ad8?=
 =?us-ascii?Q?fkO2GYI/5B8AAIh8Q8FMxMjTIKSODz3asGVYDvqXbbd8QnW7cRgiQtx3lrhE?=
 =?us-ascii?Q?l8x/SrIYQG7eDNEG8LfFo7WNi1CKV8m3R8VIpRTav2ANsRXRapdMm/SnNlYT?=
 =?us-ascii?Q?KDWZYccqdZ8L2Y9f7E0dPgAhAOeZBAHk3nuwbS6gg80lKJUU2LcQzka4aRcn?=
 =?us-ascii?Q?nRkcnN5OElO3u11FGhmKymehQpqE/fsZ3cGnetIJCyYqVyId/1eCV+WM3u+S?=
 =?us-ascii?Q?10J99p9/sG1zFwIyKtt8971web0xvKzyvAQJdKbwAuKv5F6pmgsR6u4Xxv0K?=
 =?us-ascii?Q?bdqu0ppvN6Avkgm971Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b28c56a8-422d-4da3-968c-08ddefae5cb1
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Sep 2025 14:37:11.4384
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: gWdjjDq+TgMOvquyqJguDnWy9JjNmgHbD1/yffwB7/nfhul6wTIARFMOv2i6py3+asrzR7WvRyfiG/bDwLmpRw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7299



> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Monday, September 8, 2025 9:12 PM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Clark Wang <xiaoning.wang@nxp.com>; Stanislav Fomichev
> <sdf@fomichev.me>; imx@lists.linux.dev; netdev@vger.kernel.org; linux-
> kernel@vger.kernel.org; dl-linux-imx <linux-imx@nxp.com>; Andrew Lunn
> <andrew@lunn.ch>; Frank Li <frank.li@nxp.com>; Andrew Lunn
> <andrew+netdev@lunn.ch>; David S. Miller <davem@davemloft.net>; Eric
> Dumazet <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo
> Abeni <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel
> Borkmann <daniel@iogearbox.net>; Jesper Dangaard Brouer
> <hawk@kernel.org>; John Fastabend <john.fastabend@gmail.com>
> Subject: RE: [PATCH v6 net-next 1/6] net: fec: use a member variable for
> maximum buffer size
>=20
> > @@ -253,9 +253,7 @@ MODULE_PARM_DESC(macaddr, "FEC Ethernet MAC
> > address");  #if defined(CONFIG_M523x) || defined(CONFIG_M527x) ||
> > defined(CONFIG_M528x) || \
> >      defined(CONFIG_M520x) || defined(CONFIG_M532x) ||
> > defined(CONFIG_ARM) || \
> >      defined(CONFIG_ARM64)
> > -#define	OPT_FRAME_SIZE	(PKT_MAXBUF_SIZE << 16)
> > -#else
> > -#define	OPT_FRAME_SIZE	0
> > +#define	OPT_ARCH_HAS_MAX_FL
>=20
> In the fec driver, I noticed that the expression "#if defined (CONFIG_M52=
3x) ||
> defined(CONFIG_M527x) || ..." is used in four different places. I think w=
e could
> add a separate patch to define a new macro to replace these occurrences. =
This
> new macro should be more generic than OPT_ARCH_HAS_MAX_FL.
>=20

That is outside the scope of this patch and should be addressed in a follow=
-up=20
cleanup patch later.

Thanks,
Shenwei

> >  #endif
> >
> >  /* FEC MII MMFR bits definition */


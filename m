Return-Path: <netdev+bounces-189011-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 136BFAAFDD1
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 16:53:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 781904E078C
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 14:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01F8D278173;
	Thu,  8 May 2025 14:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="nUd4ttHV"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2087.outbound.protection.outlook.com [40.107.243.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA37278169;
	Thu,  8 May 2025 14:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746716009; cv=fail; b=sQmQ0vlTyP4AG3naxPy1bVU/4iaXO9jhfwKHXSZhToosNnprNLjwwZuIMmbF23EMqb5BXqKFHu201ZnDeO0aPxH8WnvSbWwB9DMVi6aLz1yPMBV3XCZYTGiqwo5RiE6A4kENztQesKi0CNrkQxkxP+hsLTl3K306Q+RzhEc0I1k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746716009; c=relaxed/simple;
	bh=Z53K9QLcjKMLOdwjMryh+1/kxHs7bJuSUAOr1ia+vNs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Pft+Ne8q3vyayn/xl5uf0JSEoHkqjzk/Cf/Z4j/nx5Kws36ifXKu2u2vuyaSBnGoc1rzef2S6WnxCDBOhpEwpwDgnhtMm5YG3QJp3Gj1qo3/CpMSQfTzlRkXU0/r/lENtUUfcfY5qXCwJD5sQTZCpJbBgr5mSZbRko2wDSS9Rxk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=nUd4ttHV; arc=fail smtp.client-ip=40.107.243.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fL6Ney0F2YjKtdLmg4PNnRTlHUyW+zxK4L8hzlBRq1/IMShM2RcfdgG5mY30DJAt3KiS9mmE+D1RRBHW8qO+vthwGFa0Mp3I7Pl/ekhudnxlZUjs9uouDAmCoqrWYkxxRB44Q5Fs2xvgZeLzcC/LL3e2LO9mjkOzYjh4VigusY4BxKYFF5tGMKHTjAhptG7qSmCVRT6PPodvtzyMuct2TJ+pR6sdkTIJ8ZH1Y4g8HmBkOgIpMgy9uLdQisEoc5e9U2NAHiODmX5SuNrjKoX4AdDoqayBqPHVrhLK2u3AZSOiV5xCcx5oA8lXt6E3rsmMxDKMduQMwxDhEuFIzuYA2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7KEgly8hFucYOkPCBxHCaO5p6nSDsOsXOLh+sF+En/E=;
 b=ZGWEPt9YCDO4RXOuYIr1thsbtyayC912UG58qHnV7WTsLwmg2aCmbm0NjQTcMhSycs97hodBB9JmyDC0AFyJhHYuqhu2KfjVcBFNIQ08A8th5XihxAtWQ1Jbmbn/gK3r6jMZ2aTVH8ykWnq3USs9Wt5Rc6Y20HHjubfeDX4C3zjjoa+xI6Zj9qbprpkFMoM5Vedwfuqylcx3bISsiKXv2au4RBFUqUsuAy9mm0hKhJEH07si6zNJfVeT2FUtGB2ErxS4nlEnTrxZuF1z8nO01TuFVqZsrZplKIwCPC6l0IenL28aEfxG00aoLBWzuYvCrtDoRCZbLdLfZlZnzpLghg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7KEgly8hFucYOkPCBxHCaO5p6nSDsOsXOLh+sF+En/E=;
 b=nUd4ttHVl3IEFf11mKn4x8TwXPehFIqtd8ZOAcg/vyaZYhfqvZgrK5X8BlgGTS7RH4VN9/HmOl5DkW7wU1HaVb5qXwh+LFTxuzNQSuB6HSFcoc5MRixzLCkwYRG4am2uAgPXRVzi/gKi4qJGfWP1cgS95G8DGGxC8cDbbj5Cv2MmyBzC5PQn+G5/ynWk/LAXVmVWmkxeyUeW89fQBbKiMP0G4yehaaD20TkeZLOZ2smxAPtaE1TmoiXSVypMzhOkug5fQ7zJNTu1/LqEk6KHx/ouOHzTmTIp9PDeC7InFa6TMTogItmuArEmHh2reJwsDQIoc5pbMq2e6pSoa7prow==
Received: from CH3PR12MB7738.namprd12.prod.outlook.com (2603:10b6:610:14e::9)
 by CH3PR12MB8331.namprd12.prod.outlook.com (2603:10b6:610:12f::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.21; Thu, 8 May
 2025 14:53:19 +0000
Received: from CH3PR12MB7738.namprd12.prod.outlook.com
 ([fe80::fad1:1acb:f5eb:98ee]) by CH3PR12MB7738.namprd12.prod.outlook.com
 ([fe80::fad1:1acb:f5eb:98ee%3]) with mapi id 15.20.8699.034; Thu, 8 May 2025
 14:53:19 +0000
From: Asmaa Mnebhi <asmaa@nvidia.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, David Thompson <davthompson@nvidia.com>
Subject: RE: [PATCH net v1] mlxbf-gige: Support workaround for MDIO GPIO
 degradation bug
Thread-Topic: [PATCH net v1] mlxbf-gige: Support workaround for MDIO GPIO
 degradation bug
Thread-Index: AQHbPTCwkw/5mDAiDkuucKlF479Xq7LJ1/+AgP/0uKCAAAhugIAAAetQ
Date: Thu, 8 May 2025 14:53:19 +0000
Message-ID:
 <CH3PR12MB7738C25C6403C3C29538DA4BD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
References: <20241122224829.457786-1-asmaa@nvidia.com>
 <7c7e94dc-a87f-425b-b833-32e618497cf8@lunn.ch>
 <CH3PR12MB7738C758D2A87A9263414AFBD78BA@CH3PR12MB7738.namprd12.prod.outlook.com>
 <6e3435a0-b04e-44cc-9e9d-981a8e9c3165@lunn.ch>
In-Reply-To: <6e3435a0-b04e-44cc-9e9d-981a8e9c3165@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CH3PR12MB7738:EE_|CH3PR12MB8331:EE_
x-ms-office365-filtering-correlation-id: f58de553-d5ef-454e-621e-08dd8e401291
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?HczMX6atRFhia05WHf6kSRf4vuonT+XkgbSpmMQMxKX0WGuDheMQZRWaXYVI?=
 =?us-ascii?Q?U62tpvWEH3ZiQAncjqBSfOcHG9y9nJqYzep/O6BiavpuzM8coHDYlbm0koBC?=
 =?us-ascii?Q?+/uh1T+aJxNVUCWhG1ZUViwa65+Fo8C4niau4LRChADH0KJ/uGe/quJtCPTz?=
 =?us-ascii?Q?wLWh3c00faT4Y/Gj5Mb+oNT/bTiCkyw8v5XGuVImmSQS8LECWM2PyPT4L0P9?=
 =?us-ascii?Q?Q2C6QO3/kkNjrf55SR4jKlWMF4Os1i7ds133c5Sav0PqozrmKZIWUggozsHe?=
 =?us-ascii?Q?y3vi2iE0xF0Oe9d6GHoz2gpOf65uS/4gajpFxOVc4J/EYVyeS5kjAK6JHx5s?=
 =?us-ascii?Q?01OWMrDiFla7SfBmQiAMlQ1oRmtFrt+L/Smb+caaVO4VY3EY+dZiK8Hm7VXF?=
 =?us-ascii?Q?RmDg3Df1w459ndl3ReNSD8Ye7xCDGWFm6Zw2Ltg0gzh8kg7Rq0b1omNKS3bT?=
 =?us-ascii?Q?1axmx+1Xr7Wnyb80qLcR8+9LhyIVwIxRAcvypcwnNT/Z2A9X4u+BzpwmF0hw?=
 =?us-ascii?Q?l1ykvQfUP5n4pGonMLkROjxKfk/9lCvdAV/bi3wEz0oHme8q/4/El8gkqCkW?=
 =?us-ascii?Q?bo1gUzxLisET8QflLYZkiDgDSmS2gu0aBmWxT1VAXh8nlN4PZ8D3QiwQ7lT1?=
 =?us-ascii?Q?6A28ewSyW6rOqmNigi5oWnZ+t5r4JwltmPh1OaTSD/BovBjTJqwr64YHZ0Bv?=
 =?us-ascii?Q?BTNouWYMcBwxcDhmcLGMjE0hoL/z4iBZW4rA31TAC2qc1xjT+lBY9bZExcd6?=
 =?us-ascii?Q?A0ZYBIKFWXCzi4KUAiy1SqZMvEgM28NZS/o2D4deCu/2W6d5Qx9QdzLj9Jus?=
 =?us-ascii?Q?sPN5a+SVoYQQ3KLQqsr0wxQyywQJ6fpdNTIZRGxYDpO10+561bsRgldTkwZI?=
 =?us-ascii?Q?mS7LSSItXcyeijNT1MRrEIvsVu5z2h4rqKAOzkqC/Kun4CDN5V1O7xmbVii5?=
 =?us-ascii?Q?vunLiIyNpOYwXytZMYn3EMzlbgdgziGZ7N9tJF6KCeU+721dbaqTm7qd2yeq?=
 =?us-ascii?Q?qvQR2QVDLC18ouHD1+czDGyRgoHOwA9SqZnYdVjmb1buntj3rFOsMbtVI2J5?=
 =?us-ascii?Q?zTodDc2fX/8wTQ6TvpOKMFAdXhqUobt+XB/5GxzfGiKNODb+V8ATbYumpccT?=
 =?us-ascii?Q?eocev2fCTk3piHyTZp/S0op3TohBHE/TXytNAbyGxtEEdxASBWgNx4GybzYT?=
 =?us-ascii?Q?ZZIf4EstvPfU2NSeIGVS9RrKBx9efCZYNcI44qPHA7baIaB4qLEDfDZExlRI?=
 =?us-ascii?Q?gbohP2haOjCHIsCHzHcuKGou+ukH7Qs1PMV2CvLm1A9u7TUdsbSUUGQnw0+5?=
 =?us-ascii?Q?96h3gbiDyZ5vY80aXgMB0t/cwF6czDhRoyxpzoGNBFyAfZCVkVpF0qI8APWz?=
 =?us-ascii?Q?cbKfGycsV9xBlu9cb04LLXgWApBkKk8+yKfe4S/2Rii+7X6OAxFVblJw5iTK?=
 =?us-ascii?Q?pPP8YK789tYxLtX7fuxIFK9TW/6eW1eq2JoblLztI6ye7/G9vmU5K5wsB6Gk?=
 =?us-ascii?Q?OH93c4wr7I7Xbis=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7738.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sRHdKKMYPP+/w/D/lvlNk/VqxxPKpnFTdIzZdiLC9ZYJ7dJ46VDsXHJ0CLYy?=
 =?us-ascii?Q?Nd+nON/95EA1BNDjoS2khnUUjQCE4zgOY1jXv0Sk7g7iiGtOaKKW7NZ8ZpCi?=
 =?us-ascii?Q?LwwMO7VjlGPHmL892E8eBYUJ47hFYOCBVNPaWo/FHNub4LxV7Id6Wd0bQbao?=
 =?us-ascii?Q?o+g6uY4Mm9d58JUARJn8i8EkyYCc5P5zoAOmwxwB7kDtwhIPcFNAawVc6v/h?=
 =?us-ascii?Q?zzmNnykJQ25H39waDJ2mSo/gO//PBW5egNnloBnNP7vxklulo78lEOpN27kU?=
 =?us-ascii?Q?mgeNPPlu6Np7/H6vdRD03ReinVLU3A5ryRLLGNUiA8Maf3kfA8XAMCTLPnaM?=
 =?us-ascii?Q?RLIn5EOUWA1tkJfUJfruz0gh9esVHtq5dQfRYjtTNr1hcbzojlohLadAUkB4?=
 =?us-ascii?Q?Abk/bBJRXzuJthVqxYYa2QefKQf4qIav70WSiSGxk8fhkayffju77jB91mSR?=
 =?us-ascii?Q?lTAe+ruP4PMHuv+VDk6l+Pkyu2GCQigtgexins4WqBG47DqWkezPwsHvuTUC?=
 =?us-ascii?Q?opAtNLURIB1H4V9qjnsREdbx8A1qR1W0MDHsYFDpQ2zWtdqDvgTSCfF3Zxus?=
 =?us-ascii?Q?Tvfc4UGrp/+xPyC1mqKMQObXCDJcOykGzFToq91CRy2K4hKrVJ36ASfbG5xF?=
 =?us-ascii?Q?qzNPbjfPOJmQN0ie0W5sVdMd2C2DxlcET1XCpvq+/zC5YehUSGBQNx0tooLB?=
 =?us-ascii?Q?m4RUYfYsNq5jEhYkuspjHR8+UEazvHoisn/fPlFO2As9HT+CHCgm8+iOQuEZ?=
 =?us-ascii?Q?w2ZzSgvhwlZizTZo65c+qQ4uHeHat0Myc5TLGsHTWLwXIwQ/4otclQeb0RIV?=
 =?us-ascii?Q?4jz30iM0A57CuEzys6fs2TqhDzAcsolKZGKgnBAMwWbk81747rCy4mRH7y0O?=
 =?us-ascii?Q?Gej3JA1IdtqjOUrHaqUBUiydk/gajG7ZTii8NsExbA0DhNsF18N7ZzJTfvY2?=
 =?us-ascii?Q?scSeOzWygJ1ys3rkTgLVrj1VTxSljM0D8WYg4d8eIOw0Wi4hM6VZkup319em?=
 =?us-ascii?Q?dehMWSIyXU8DTm2sx5wFPoeLIT6s2HAI0HvzYohaz1eDZspnW85HKaKLUWZe?=
 =?us-ascii?Q?tSLhbP26H/KhRd7JrcKJ8dW7Pjbj9m41pEwpsaJLqhn9d53bxEVCHc5K1Lq0?=
 =?us-ascii?Q?v75OLMNguPH1zKNHA+d8pXhb352fBwf/vk5rwqAoK4lcpEvnYuuzINrzf1cL?=
 =?us-ascii?Q?souAXc3Z2ZR5faQqv62oZMB5W17cB4zQ2NGK8AKHsNRYZ9Ah4Bl1Kgy1GfYT?=
 =?us-ascii?Q?1bDupw7nGK4g2LzqUgvmtYWJeBjbvyW2fjwFcUtlsb8nazjyAnIwhtSx3V3d?=
 =?us-ascii?Q?r/s3g0xD1PqJb7Hms3K1BlznAjJZ4X1IDwkMnyLdG2ZXeYJU/R6vYKD3JJh3?=
 =?us-ascii?Q?sQOByrNqgv2T2aBN6MmYB+5T2VjO00oO+GOpf9htvWqlRsvikmvXQDfAavEd?=
 =?us-ascii?Q?YZkgBhz02SXKxsvYsyNqo8zD+7GMlcSrx2S2hbaZCBzpS6je495kl/VEhsKX?=
 =?us-ascii?Q?H9iFf8tzDksg0K9Pu+jlzxBzCImNXeVXFKfA+kz4IWf83HoHxAgVF7q9JusI?=
 =?us-ascii?Q?ILHu4Iqzv+PRVEYWGOM=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7738.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f58de553-d5ef-454e-621e-08dd8e401291
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2025 14:53:19.6748
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lL5ZAAFiq7M0k88yQlGr6DeP3L+wnexO+uhEhnmz7ka9eK+f6/gw6dc3WPa39ZkOVH73+g7fOeQ8TI96zDUIgg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8331

> > > My reading of this is that you can stop the clock when it is not
> > > needed. Maybe tie into the Linux runtime power management framework.
> > > It can keep track of how long a device has been idle, and if a timer
> > > is exceeded, make a callback to power it down.
> > >
> > > If you have an MDIO bus with one PHY on it, the access pattern is
> > > likely to be a small bunch of reads followed by about one second of
> > > idle time. I would of thought that stopping the clock increases the
> > > life expectancy of you hardware more than just slowing it down.
> >
> > Hi Andrew,
> >
>=20
> > Thank you for your answer and apologies for the very late
> > response. My concern with completely stopping the clock is the case
> > we are using the PHY polling mode for the link status? We would need
> > MDIO to always be operational for polling to work, wouldn't we?
>=20
> You should look at how power management work. For example, in the FEC
> driver:
>=20
> https://elixir.bootlin.com/linux/v6.14.5/source/drivers/net/ethernet/free=
scale/f
> ec_main.c#L2180
>=20
> static int fec_enet_mdio_read_c22(struct mii_bus *bus, int mii_id, int re=
gnum)
> {
> 	struct fec_enet_private *fep =3D bus->priv;
> 	struct device *dev =3D &fep->pdev->dev;
> 	int ret =3D 0, frame_start, frame_addr, frame_op;
>=20
> 	ret =3D pm_runtime_resume_and_get(dev);
> 	if (ret < 0)
> 		return ret;
>=20
> This will use runtime PM to get the clocks ticking.
>=20
>=20
> 	/* C22 read */
> 	frame_op =3D FEC_MMFR_OP_READ;
> 	frame_start =3D FEC_MMFR_ST;
> 	frame_addr =3D regnum;
>=20
> 	/* start a read op */
> 	writel(frame_start | frame_op |
> 	       FEC_MMFR_PA(mii_id) | FEC_MMFR_RA(frame_addr) |
> 	       FEC_MMFR_TA, fep->hwp + FEC_MII_DATA);
>=20
> 	/* wait for end of transfer */
> 	ret =3D fec_enet_mdio_wait(fep);
> 	if (ret) {
> 		netdev_err(fep->netdev, "MDIO read timeout\n");
> 		goto out;
> 	}
>=20
> 	ret =3D FEC_MMFR_DATA(readl(fep->hwp + FEC_MII_DATA));
>=20
> This all does the MDIO bus transaction
>=20
> out:
> 	pm_runtime_mark_last_busy(dev);
> 	pm_runtime_put_autosuspend(dev);
>=20
> And then tell PM that we are done. In this case, i _think_ it starts a
> timer, and if there is no more MDIO activity for a while, the clocks
> get disabled.
>=20
> The same is done for write.
>=20
> PHY polling happens once per second, using these methods, nothing
> special. So the clock will get enabled on the first read, polling can
> need to read a few registers, so due to the timer, the clock is left
> ticking between these reads, and then after a while the clock is
> disabled.
>=20
> My guess is, you can have the clock disabled 80% of the time, which is
> probably going to be a better way to stop the magic smoke escaping
> from your hardware than slowing down the clock.

Sweet! Thank you very much Andrew! I will make the changes and send a new p=
atch soon.

Asmaa


Return-Path: <netdev+bounces-119496-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 080F7955E87
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 20:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AE9C82813E9
	for <lists+netdev@lfdr.de>; Sun, 18 Aug 2024 18:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF49A2746A;
	Sun, 18 Aug 2024 18:38:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="wlXjuK5U"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2040.outbound.protection.outlook.com [40.107.249.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9875DD512;
	Sun, 18 Aug 2024 18:38:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724006322; cv=fail; b=luPAXwQ8H54kwZ+Xbd45sZS0TCjQQYQmThaTx3ezDc9QoOl7fvnvPGne45lLY+AVCAeoJjjs5zIh8wU0U/IqhDdFVWt03kSMe6QgvDq1AVjg1aJZOG6Olo1yz5t3VtYoPJWt9hF6XOdr7MWzOw2SWXLI3kHF7MbgupEJVncdszg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724006322; c=relaxed/simple;
	bh=z5S4ItsDCr505PgSmeRrCUeU1JxioIrZVnxjv7JeJ2Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uQ5vdbgtuEes7ToCvNWvuZyCvfWamTdZOXmIOYiFiI5jGC9s709dIv40shvzPVrDUpLIFCk2iw4xiEGF1FcxudmeVccwJi1JB/DV1vk7bhOQe2r5xa/n/IFVAWresFDBpLhKEG2ZlTeItNTG/XgGO5X3faEA7M58isEoYqw/wPA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (2048-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=wlXjuK5U; arc=fail smtp.client-ip=40.107.249.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MZxHkvO7NI3rvRvGo8V+usIUMhY9jLGWp8lg+x592qL4tJXgU4dQHjvdpdxocJgRGrTbaIY7fERaI/8+2upOjvvHizTdJdyxHcLPQOQtN6BcqDMRbglGJwHXqMIM/l0Cqb2/3BjAvL7u//hVze2/2FQ9NaEm/PwRu1LO8l4OO2O99v+jiCuiKlozSQZvrLCSH0lUhnPacqjp7qaNfo6lJMR2qbd1USW+44BjOzyPG6BSqvRJZmdW7lP6KCV7CeUSaZcYb1wOPSi6Mdhpfk4aFHf071TFL30lpQ1IsJR0/7BhyYYzuNoSnQgLRD+E4zGwS9cJjcoP7gy/QtY/TPO0Fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JUIk8TmFLpj8gpQg3oAJtqRv3U8GaM1297MCqiBg37w=;
 b=sOWiLKyK3E3gFwgEDDKM8ONwXa31j6jLHYWX2R1Zbe2myLpiCSWU0exGG30dkSgImvZe6A0O3rwBM2ZHMYsH0TL998i1fl/fMgCJIeqkXE8+8qEtz6N2Ulte3onfFIh2gPCiL5vlenpuUnezygLd9tvKM+lkdbvcWD2xl5m0WVMwH+iMO2hkpW9QQS4Xu4ZrwNvZMpm+NxdlgzGXtQE/dsL7zCDj0vcs5IFQgHSi9g3ZTkXQU4vPyfKq17xJ3BbIdpAi28ub8sPBSVLv8dtI4hYdFtP3Qn6HDRKYlVpiD4OanNKhQ2ZyEXG0aYDLA3Ct8984nHeQlxnClvufjNOw1Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector1-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JUIk8TmFLpj8gpQg3oAJtqRv3U8GaM1297MCqiBg37w=;
 b=wlXjuK5UUEszb9DN17e1Ij0dMVTn3P5wDbU/rgDeR7jPXALLTHTFcgjF9dBLD9TUX4bKguelha0Cyg8JqacrAl+LZSOqqovR4sLCJ1kDexS2f+yWOD2jjDEwfu1+t7jEV2CmRKmK4yUrgUjSjmxorvzSxAHZeh37p0evW8o0cQU8nDyv4UhEmSJEi8Mx4ogVPYJpcztzdxrFHXcm5We51wt8dqIbRq7ddbNpyMZtv2EsvZ8gegl1NOZIUnIyntYBZRTygCeJy7TcIG8msNRKdp2bVj8RXuNmjKXfHuic9XScPvz3yE7RpJtpFYBC30IFnr+8Z9WEtgo6+ytAi5a8hw==
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com (2603:10a6:20b:431::16)
 by PA1PR04MB10294.eurprd04.prod.outlook.com (2603:10a6:102:44d::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.20; Sun, 18 Aug
 2024 18:38:36 +0000
Received: from AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27]) by AM9PR04MB8506.eurprd04.prod.outlook.com
 ([fe80::5f7:9bab:66a3:fe27%4]) with mapi id 15.20.7875.019; Sun, 18 Aug 2024
 18:38:36 +0000
From: "Jan Petrous (OSS)" <jan.petrous@oss.nxp.com>
To: Andrew Lunn <andrew@lunn.ch>, "Jan Petrous (OSS)"
	<jan.petrous@oss.nxp.com>
CC: Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, dl-S32 <S32@nxp.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
Subject: RE: [PATCH 1/6] net: driver: stmmac: extend CSR calc support
Thread-Topic: [PATCH 1/6] net: driver: stmmac: extend CSR calc support
Thread-Index: AdrmqCAbIYfhhpSjQm+gwLO5S8kGvwAG3s4AArZ9+4A=
Date: Sun, 18 Aug 2024 18:38:35 +0000
Message-ID:
 <AM9PR04MB85060887C2FB9B397E24231FE2832@AM9PR04MB8506.eurprd04.prod.outlook.com>
References:
 <AM9PR04MB850628457377A486554D718AE2BD2@AM9PR04MB8506.eurprd04.prod.outlook.com>
 <8aa45bc5-b819-4979-80b5-6d90a772b117@lunn.ch>
In-Reply-To: <8aa45bc5-b819-4979-80b5-6d90a772b117@lunn.ch>
Accept-Language: cs-CZ, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM9PR04MB8506:EE_|PA1PR04MB10294:EE_
x-ms-office365-filtering-correlation-id: 9e71eff1-de95-4e9b-ac57-08dcbfb4f874
x-ms-exchange-sharedmailbox-routingagent-processed: True
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hlFwRpMZi7Oe/oErDAVLBQ026Y3bBtpb5Y3Iil9Z50LFlzlhRkQSFvOrD+6a?=
 =?us-ascii?Q?JRN5AC/evDpxC8YzpiVIRIHQMCZ7jmJ862azwZ18yrD618puoAOxOa2MUjFN?=
 =?us-ascii?Q?dSRbbmmThSgf3pk3o91ZPxytTz6VyLM1fg130nLIr+cI+7zgLCnvi78UTl1W?=
 =?us-ascii?Q?tCtBbqklS5owtjagBp4HSq0qG4Kw57lHH76tG3vKcu6SjoxwQYdJBImnc8Vg?=
 =?us-ascii?Q?aip/Pvc/frs2I4YorqcIt1hMJskDSYirTL1Ja+hlYM1m0YKD0d4dAugMAJ3Y?=
 =?us-ascii?Q?BAPKY8oeZKuLJnxx7aXDfDWU7g3NkusneIGQA/oYSTLKcD2z/ot1qi1LiWMQ?=
 =?us-ascii?Q?1HDkJgioN26eQF/OfMii33CN/ccDxzmZ4i47MdxJ/Nq9ZjqNkQxDPyF65L5Z?=
 =?us-ascii?Q?a9vJUWwI22kzkE26NVYV+UgUSO8WHV04z1H3lxGAiyYz60I/GC0VSvuPC0bm?=
 =?us-ascii?Q?sN14YskA0iryao8kva6P+OaZ9ZCOT4mHcfRL0NaCW9G+hdoKnEcrYDxwoY+J?=
 =?us-ascii?Q?CeEvPfBlVSBzWntJD2od2uuDABopUIfLs9SCyBeSVwqqvFPLfPnhRL8l8Ajv?=
 =?us-ascii?Q?8JQLowvowXQiBV7ajFPq+LIp2+ELQ6w7WhPwETHI/hPo0RhMFa9HwmuYhG28?=
 =?us-ascii?Q?NI/Dz3ysfJaNLfMd7Wky6qb5Bg4t72AA4lb8zIVVf+KmzTbbvvbcxdCYiV10?=
 =?us-ascii?Q?HdKuqETrLAumbM8VfRZ/OrEMjjN3tP5mHEQK2XAx8sG9m/oPEogg/ZTa5V0K?=
 =?us-ascii?Q?e5LaM0oVEGuA6rpAtepeYgFLKUrEWncA+kyxUnSuCLbvsQdjU73u9v2zVgqH?=
 =?us-ascii?Q?40mFKdeH0SUIayUd7NHduYJUtvVP7w4SqNoE+uTFiQ4+kwTkwgJSvBZP3Pwq?=
 =?us-ascii?Q?Zm5tZKDtIWczjJiA5a25nFRyHnrX+1SzFMd8KsdjZfW9V62kFbfwjqxRY9b0?=
 =?us-ascii?Q?HLAw8rWE5QPozKAKY69xWGvsXCKiXSG6k986yhcFbaIuPHXDvKgy8nR21obL?=
 =?us-ascii?Q?1PeoQvfcj8uNihCAbhkWAU7KIfop5977nbEgsxM4PELKgPNjImyqnT9SD5lJ?=
 =?us-ascii?Q?HLGTmySrr36xKnNgqPJS2P/0DWyYahJ3ZYLbhXPgiQ7u9cUUsKguuWVhg3JS?=
 =?us-ascii?Q?HSjrzCigG9FXNEClFrCmzThSHucSLgmsu77PQSh56B6N3QUz6AgUzkQVHRSp?=
 =?us-ascii?Q?nWmlIv7cV4HtFxmt1kxLjvb/khxuvFOVR91H+oF8gDXN2LISTVLxxcgbHAiB?=
 =?us-ascii?Q?fkhq4u/TYbE7Ycw6t2+8IRtHhUcrrs5crFT3bUGrdKOnAo886GSD8nxeBvI6?=
 =?us-ascii?Q?kvGFu4ayf6TmCdYVtEyvrm+FaqaM1qrUGsFyM5iDj2KL2nOoASxkTZegdtI2?=
 =?us-ascii?Q?Rrgego0odghB50GjnJXdgIw0oQlWZhlgahaOoUVLKbfED3KUDQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB8506.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?dNlMbCxsuprR1vxErZajqJW1aGGdy65wC3i4xdQW7qaAedegRQMuLvbg07hM?=
 =?us-ascii?Q?n3CfGnY1yZC/ZpaYeellwTMZLNzn6XrlXRJvCpmv6joTYgsW2VvtNwa54QoC?=
 =?us-ascii?Q?39qwximaJVxp/ove/zfMIPPagSIbA4N5nCYBDrUog8Dmjbt0VpChbK3oCMvp?=
 =?us-ascii?Q?4lXeazftG8A4zograArRxSkpPe7HTY6KUY3Xi3ax9ZSBgz4oe3ZMaVCgjGG+?=
 =?us-ascii?Q?ur4zCgWZ4xMjPOGrjnFjlp/jkxcyOqPg0WtfQtbgD9lbm/W1wAHGtthUDumr?=
 =?us-ascii?Q?Z2oMF+43RsGUjtHZmEtgZusq1uRGUiceNtFctyvvRpNtmXub9n5r8Hi/0RpY?=
 =?us-ascii?Q?M5rGE7ndpncD2t0gFsrY+pZ5dKzkSGj2R4IaVT376141ZxTOLWNaP1ldIAIX?=
 =?us-ascii?Q?Nbcp1mOaWRt0xwKZUJDiLLb59zgqsQ2UW1lxYjfACsbxePTPgiznXpBqzZ9f?=
 =?us-ascii?Q?kEhhkMfZychkR5EYcxpTSsvoHjm7T5IXitZlTW028qmI5vFGsoeS9MhRGIlK?=
 =?us-ascii?Q?ghPlKpSl7/4Jl1Q7zgkBVjnELpKHRAQUjGdZMHhXVCAGGf3H8xD9xl3ggsji?=
 =?us-ascii?Q?zJ6y+7ObNNi2kPOGyEWSq7RDMwGHx58RWoQugcDeVe4tNh2UReCR4DZ3KecK?=
 =?us-ascii?Q?rH3oaU3tltNK5msNbGetk1ws/uyACWZ4VRcMRFcPvglGETd2Fbrtw2RfpoFV?=
 =?us-ascii?Q?tguZKiXj/H5h4brGKMlLyFg/DN8FKvKFOTEM+YmKwqQsIzfarxMPTRwL5Jri?=
 =?us-ascii?Q?MEo05331yOxrON/iyoUCIuJm4qLDdf1ahchEYECVCCURf/n9pH2cHRrLWuMy?=
 =?us-ascii?Q?hZ0e7seaieavcFRfmmWOA92nfjuH9Y4jgUvyAa6zqZrMOf6QIDJxdnfA6gu7?=
 =?us-ascii?Q?Z7bnheeSVoS/8ocXIIZ1ZOP8UAIlTGtOB3on8z26VUzVwWFs26yJi2pW3T6m?=
 =?us-ascii?Q?ojq/ILfSG36c4uwwamUVEK6+A8ou8V1+zwdjOvVggkb9t0ml1RVg9vSzu1F5?=
 =?us-ascii?Q?0SHJFLHTzvoxbVynsxkxmrGRCO8zKdigb8+l4L7Gn0fDm/hYcAWoybht4jzL?=
 =?us-ascii?Q?RDOjvYXxhdCr/Z0gqt8jdSD0T1k1PCS51wQTw1S6Q4TzDZ0aiz0COz4X1CVI?=
 =?us-ascii?Q?uSlKS7U+Jkz+2FFYfnfankun4TaVuj+hjAYzxFkfUQp91FXwdr3C0wrBtPTj?=
 =?us-ascii?Q?/aJ/jvIThpdA9F7c5ambcEy0XroT64neWtgoQyE03VrOyP3CtODaF3WWjX80?=
 =?us-ascii?Q?Gr5QWGzKl+Q0VdB7DNSn9XBe2pws2kfp4n2GHlfu7rOgnQipyMMU5QKR+BNp?=
 =?us-ascii?Q?oSXhdCISq8FS3XbQNI62Sj3d8Ayi9f0cgmaHDbtd7JNzo8XkxgTqDJ8ifhKF?=
 =?us-ascii?Q?TAOXTJ/ooLoIoOK/wIQFlKYL0HLwblzym9xubMqSBGtEAgOHlB/QMO6Zp1zL?=
 =?us-ascii?Q?AF91EA3lwKX5VFGDBh+KU3DjPs9WwVQ4a5jShvDKl7o+//93HSS7Z8uF66Nn?=
 =?us-ascii?Q?YwFzarJ3GAt9NrGwz4nc3zUPxYa1F8TJQd9zaJu1ffvPdv7SNwzMLbD/NtPJ?=
 =?us-ascii?Q?Aul8UKtyBi3Wp1NGBthNwAp9CH1JqD88Pc7PRq83?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e71eff1-de95-4e9b-ac57-08dcbfb4f874
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Aug 2024 18:38:36.2695
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W99bp8OK6IAJNZ8RjHhcQVIvKruovoHf6DxP0gwg3k4L/RPhXCWumNMgWgoTjd2/a5IiCE9De+HXJU34SB71VA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10294

> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Monday, 5 August, 2024 1:11
> To: Jan Petrous (OSS) <jan.petrous@oss.nxp.com>
> Cc: Maxime Coquelin <mcoquelin.stm32@gmail.com>; Alexandre Torgue
> <alexandre.torgue@foss.st.com>; dl-S32 <S32@nxp.com>; linux-
> kernel@vger.kernel.org; linux-stm32@st-md-mailman.stormreply.com; linux-
> arm-kernel@lists.infradead.org; Claudiu Manoil <claudiu.manoil@nxp.com>;
> netdev@vger.kernel.org
> Subject: Re: [PATCH 1/6] net: driver: stmmac: extend CSR calc support
>=20
> >  #define	STMMAC_CSR_20_35M	0x2	/* MDC =3D clk_scr_i/16 */
> >  #define	STMMAC_CSR_35_60M	0x3	/* MDC =3D clk_scr_i/26 */
> >  #define	STMMAC_CSR_150_250M	0x4	/* MDC =3D
> clk_scr_i/102 */
> > -#define	STMMAC_CSR_250_300M	0x5	/* MDC =3D
> clk_scr_i/122 */
> > +#define	STMMAC_CSR_250_300M	0x5	/* MDC =3D
> clk_scr_i/124 */
>=20
> That should probably be called out in the commit message. It is not a
> fix as such, since it is just a comment, but as a reviewer i had a
> double take when i noticed this.,
>=20

Will add the note to the commit message in v2.

/Jan


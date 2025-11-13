Return-Path: <netdev+bounces-238174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A9BF1C55433
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 02:35:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 902044E1023
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 01:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABA2C2980A8;
	Thu, 13 Nov 2025 01:35:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="h5NvD/Rs"
X-Original-To: netdev@vger.kernel.org
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010045.outbound.protection.outlook.com [52.101.84.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7A428FFF6;
	Thu, 13 Nov 2025 01:35:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762997749; cv=fail; b=YQHlc4UjHTvSbqrwUGilA/jZbR035a7WZislihqZyvq3YWucDma+dMcjF1tV7hscXGgxRgJkk1bBbXTvEZmdNali4Dvb4dxo5vW5EpG6ayTAtJbjs1eeJTH25hFvKUxsujJclVim53Xh0SX661cXnenAs2oZKkOA24Lwl1Ndygs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762997749; c=relaxed/simple;
	bh=kJtSWyI0D7twv3fgQQp+ITWUz4x4lFmND1kkNn9hpAQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=En5vAv+xjsDPkg9ATCfZUz7zgiWDLelTYIAJQAsHQJa93z/lAHHwvljmbycsazlS09ui2hZdN887/9qv19zuR/yHNalg97hCAg7VhuWlqUhx8rpKB5hjEqyhKFO7QTh/wmln4K1JW5pDAhLfilUDj0L93gngtN0GFA48ynth940=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=h5NvD/Rs; arc=fail smtp.client-ip=52.101.84.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DpVqXCdAhxsVUFxj0rBCjzcFpYThGcFI6/AgH/64vav7zO8QotE+HbhSd7LbUpN7QwZ8mu/MTbq0YXQtcZrg2pTMrR8AjWz1vU+8YqAX1QsGHj0Jo3MvJ/Lij8H8WKpakJSzPOfClHoBWAFlTN6vvDHEVT31E2cFqlPEH5HSDV7wdGAFAWmpMMEXOYIIsIpL8By7ZswzOf3aC6AX4qa2YSSUj279pqKNagfNj5+zrb/QoqbcqfNJVGmDJ7FCk/wZvC9QfIqgXdpZuG0JTNFWvLR21WoNcnRG9k/Ia12+GsrAiemiNRP/53zMzUwIPQt8SBNwCYvIzybOq5Fq5D5bTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tl6uGiX//KKgECOCk9V/diQSfMoHKcFbkPfq3X74FRQ=;
 b=Qk6/WhPk96a0r6rxbgzRnruBABf0Q5kWNedLiy6ZfvsxKBugszA1KNdwMVKktnkL6dLxgAxEL6I6z0lf5L8E4u37DPkuyaNskvahCAgeprhyWNO1ZXX1UdrNyG7TTILW8e1v+Mnxag7ASRHPcAqyN7vmwlGofZl/+tkT+Jdi95WQMT/PDwMnrJPERhi4p2lce5tMyplj+nR4vGwl9KnYFVempVBGwqO4Co+3Tx9KHDn3fgZorRRTdm9Aqm5ZF1ib4lCsllHhEa+kOn5nVQAyPuRSZQ/1F0B26OTmRsYJM5KKoxqFoptB3z6IUTMq98IIHD9CTUrtshIZyT2j8yBumA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tl6uGiX//KKgECOCk9V/diQSfMoHKcFbkPfq3X74FRQ=;
 b=h5NvD/Rscc691Gphe4H8eMfoooribVCEisZU8HWbwUuYmjNSXtr5vVYn9q2EltH+ACdFnFRWNudUjKXBlG9x53W0Fu6DwnMgHyiYEQOrO2XC0JRi0VxtwFZQIVY808mYh3EQoVfil0BkWQH7IjCcDjncEhT5cYberS4dpdTMUfRvWx1tncqAln+blziq+hnPM8CeTp+5f2frfnfSgE/MYBvVtX7EYp5zhEC+WRxD5mzZ/jhFvgDrlAEswNs/aCudqchRAKJbwSlFuX4zj6ETICRlE+rMmTCrOB1vfEUvb8XBzVhNgLUJJrJd4y69E2tThb/LxRfO/FLIwYir6BhXww==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AS8PR04MB8564.eurprd04.prod.outlook.com (2603:10a6:20b:423::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 01:35:42 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 01:35:41 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"eric@nelint.com" <eric@nelint.com>, "imx@lists.linux.dev"
	<imx@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net-next 1/5] net: fec: remove useless conditional
 preprocessor directives
Thread-Topic: [PATCH net-next 1/5] net: fec: remove useless conditional
 preprocessor directives
Thread-Index: AQHcUvIFMn6oL/NXRUSshE/9ChqG07Tve6gAgABY1FA=
Date: Thu, 13 Nov 2025 01:35:40 +0000
Message-ID:
 <PAXPR04MB85104CA04EA6BE1DFFFE7E7588CDA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20251111100057.2660101-1-wei.fang@nxp.com>
 <20251111100057.2660101-2-wei.fang@nxp.com>
 <28badd8f-8c76-4e88-bcb2-49ed5026c1af@lunn.ch>
In-Reply-To: <28badd8f-8c76-4e88-bcb2-49ed5026c1af@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AS8PR04MB8564:EE_
x-ms-office365-filtering-correlation-id: e9b14ef6-22ec-4cb2-3f7d-08de2254f4d7
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|7416014|376014|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?GuaY6WukFOwp8HCNZRI9UXyVvkxAGquf8yIxWn8bx371OlBGujfxjo96tOrB?=
 =?us-ascii?Q?T8NbPf6kjhy0oJceQiwaN9ka+wBveBG21qnhVKDNSDa0GGKqKBulStef5CCX?=
 =?us-ascii?Q?IwE9iOhwOJCcqtNfwK/JoDasN+QdQhzFSGYWBymxnK0ozbyThd1amyoWpoWr?=
 =?us-ascii?Q?68/J/fO8dINiw0R7oqVh0Mz9gGJtaHeTcAcfGu5NFZrLfh4lTkovBGGrZMky?=
 =?us-ascii?Q?A5jaBq24u6nESdXT+0nUGqQdKJ18HLPWRKOj+cT7XlBtGmqVW81cC9rB2uST?=
 =?us-ascii?Q?dRMyws8LMex/7VEAtxmNOw11+T0NEGlMEFWUcRBgbCRM/IBsA7+d1SUcrYhK?=
 =?us-ascii?Q?g5FciPu3QJkRZKzSbnVYBHYLb0DtvPswU23a3MMHrg4DQwZqqakgrTxDcxHm?=
 =?us-ascii?Q?zMwgubsB3kyuxtjuGplizajuEzwhj+3m7dL5LghIz69LR9OMplpcwm4J/gKV?=
 =?us-ascii?Q?8wAUHD5vGngjVao7sBVvNT6hMZJ+0PaguI10INnnKyQPRqTQe2nXoCEieN8Z?=
 =?us-ascii?Q?4o1IOYmtj4OKjjUX4wcBP1PyIEgjtfO/v97IRYM/uHGdAfrsrhalJNAKy7JZ?=
 =?us-ascii?Q?p+bSZ4HjSu8qPAr7FpC7tYhUwjJMNAG7tV+iQz9SjWzBDg0WTpW77lwD0n2G?=
 =?us-ascii?Q?BXxUdUx/4iKUrYmMWvDSCSpZhXRt66zkdjeFCYjh3OTHWAH97Of9mgt+0PRD?=
 =?us-ascii?Q?NZCvtVLzdVudBYPAK9B5Byd3S2asiwo+qDGZGHfGet6xeJ//lrWMOiuj8kuw?=
 =?us-ascii?Q?RkL+jtHaOUxIJ73xAfct35elLtzS6f2guyd8YhrQ49ZRHcBKb+M78SCbo3M9?=
 =?us-ascii?Q?KvyevBr2eaJRhTVbOXZBOidCvEDZiD2AC14ztqSyzec8L6uXq+Hwg9Vla+aZ?=
 =?us-ascii?Q?z8ZBezL5PjLqS1vHu0J/QKRcTsvZyRLXc66FNYc6+8QCinnqcLFbMnkOC+4X?=
 =?us-ascii?Q?glkV8HeSgSp40axlpRSuQGvfbP17GrAEk3xeQZv5KDeMJQx5wEu8CoMzFOAx?=
 =?us-ascii?Q?Ngreq6UzSStCB14/Kj89EutZ37nPtoRLXyPSmFTCyC+rQeDisNSsKTC61GFH?=
 =?us-ascii?Q?CAibPdSL55h77MWcQlh86mIFKdqRNhVKTUnIsMqhqqdDY1KCbr8B7JOjlDeB?=
 =?us-ascii?Q?q02sx7/5Rmkgv0dglvg9UFLLHufCe4RNLz5U1e/XUl3ptPYkoMMvt0fVXioS?=
 =?us-ascii?Q?H6SQz7+DZfXbOoWT4y8WedEK0lKOk8gcKW0mbF6iLno3Cg9aTvFv4+RqkZd+?=
 =?us-ascii?Q?yKS5AZYpmNBpPRlnwUfoQDfiFsIlfa2znae0HFpCHitUnflp0AWMoJW0RCHQ?=
 =?us-ascii?Q?GXICLU7LvJpEoN5l2myfz7fovwh+64G18QWtESPT1GL3hyKanuL//vKBFpdO?=
 =?us-ascii?Q?n1hJZXKBwkU5pLk8WVgHhM2+KiRRQpB3S0stEox1b2IVmGQjnyHnAMDgmojL?=
 =?us-ascii?Q?kXUNPA3km6/lhvDeOZRHNcduEWXsznfQcPrSXmaiYvxyKMpDTjn1hujcJfs6?=
 =?us-ascii?Q?2ldqGtg89jCd2SWMPCLNK49+BaAgEegUuNsj?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(7416014)(376014)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?0GIdeEDVvNycFktWbCuWSpC+D2LKIz9Pbis8ZUsTAi0Pq8FVGhbP7LM7Lt6p?=
 =?us-ascii?Q?4kcgx7s0xc2ivDc1fUBdl6YWMzg6iVgEdnU0FGvMmsGdawJ6Bt4GrrgHjSqN?=
 =?us-ascii?Q?Wt6cQhLiXfKlwy/W9EUNy8M9vPnI69OVC74nXT7VMpQ/55x5uf/LIqmEKwwf?=
 =?us-ascii?Q?k9QlNgEV6z81iB1UYTHlfDaqAJdlmtOkLCvi/x/Jl1gusjKziD7qf35WFzPF?=
 =?us-ascii?Q?d58l0qJwjNy8nEU0mD0zgMJDcTND7srAMfAcYAsmHc1h+YpkhrqM/pMhfLhA?=
 =?us-ascii?Q?aDIA70RLBhpOcktiUl65z1jvsyFkBdpiqe+51x+fsz2mFKFl7v2+lpNtLqXJ?=
 =?us-ascii?Q?Dmf53opxpg8uOQVC7ZwIBfADkYOmNbu6G8AG/E/wl+JM06YNMe+Bgw664qCo?=
 =?us-ascii?Q?esFbBwykI5meFEe2+HLzmli6LFpepmP24mZdOtWmnjGK6wMihiDVYwkuThev?=
 =?us-ascii?Q?RXcCrkkDql7Edvh0spQbAiEk55GEDKOIWVmuwuBmQD+pdHrImtmZQi1xhlID?=
 =?us-ascii?Q?yfDVjptkCjnLJ4wuVEkE9hStOT1avV4ax6bi64+Ottmm6D9/ZOhOYZVb1vXf?=
 =?us-ascii?Q?D+Ec3kmcMD0mjTPVS1YNdysAlw3Nl99uImxEC7Whr1GLROXMpjsL+Rd9pgth?=
 =?us-ascii?Q?kbCB+uNJubPjW7ZSaTUeQRU2vXxC7NXjHu3fqt2aNE93Ah/asacQEJ+qfIkb?=
 =?us-ascii?Q?gJSTG/FqaTnk4emwq+EJtwVkQkNAGADwR38cFjTJ1RChq2kZAvfC2HT6LbeM?=
 =?us-ascii?Q?4zBs5u4aZ0tYzRFjN/rNqFubVS4db98vEcDlSdlW7XVTd5v3Wf7xbTN5VPBR?=
 =?us-ascii?Q?WCGeJRcrlHOaZJLrFixHNbvLY0ICs7+ifMyLDZMuvMPmaKLZr0ioVbakeh/n?=
 =?us-ascii?Q?zqDk4wdeYS0l0o5rQpg8roQUTNFklMjSSA17dBidAfx5yGASFR7IvUF7qlwf?=
 =?us-ascii?Q?+CUV41Sbm8v/5C9cOpFFjco2ToiiVwHJtRfZK6pCwUR/MMg/NlPqnapv2I79?=
 =?us-ascii?Q?kBq8XAWPVUl+2LmeJeTnZi0aJPPQTMPCRKLVRaDWoHJOLUq0+63NwjJUxpZc?=
 =?us-ascii?Q?wGUgAX39uff8yqh3HTIy3dl8Uusy4U9HeI3TRecRZASUZ4sOnrksSr0OAWkS?=
 =?us-ascii?Q?wuDjgL5GpfFcj6WB3auMCNzqMERpLn+WYYB5mj9/OX8UXEzG44qYRdLsMSkV?=
 =?us-ascii?Q?e9PIPEp9bqxP2KXyMY1UVsr4SOaHzzRYAshOv1+7BI7a9V4+DuKvCh6WM4La?=
 =?us-ascii?Q?b8xIDG3D9PX4n4UHXlUA75XvJQ6y3WCOXZdfqS6maZxLd0b1m1uA5noqgpuX?=
 =?us-ascii?Q?lJq1NgEi5J/Wk5kCWDH/EwdTSOsq/8ZmkQV6BbV8ygcKF5e785lkfEY/xJIo?=
 =?us-ascii?Q?b6qVdAevJKUowGuqd2d0AIrj1N6750DHRez4YQapL+H1EEbfp6KgBsyqmjk/?=
 =?us-ascii?Q?1FVpPrssQXenaQ6p/tANlncK+o1mpMFNVP6IiVRycieMlcbz4vgjCmcro1UX?=
 =?us-ascii?Q?ug5S3Z6q+rycDsmcRJHkCUprwQ3Mbgs8F+j5a7a6ZraISUSKmXYS7C+Gq0RH?=
 =?us-ascii?Q?CtdXGFvIGDkbVmtob3Y=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e9b14ef6-22ec-4cb2-3f7d-08de2254f4d7
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 01:35:41.2931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: syaJE8c1AoQzRGH3K7dQ6ZJ7eE8dpYxWoGGrgWeu4jZeMnUFtz7SG8pym7v+/F3suUVd5OF3CAEDi6Z3T/vniQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8564

> On Tue, Nov 11, 2025 at 06:00:53PM +0800, Wei Fang wrote:
> > The conditional preprocessor directive "#if !defined(CONFIG_M5272)" was
> > added due to build errors on MCF5272 platform, see commit d13919301d9a
> > ("net: fec: Fix build for MCF5272"). The compilation error was caused b=
y
> > some register macros not being defined on the MCF5272 platform. However=
,
> > this preprocessor directive is not needed in some parts of the driver.
> > First, removing it will not cause compilation errors. Second, these par=
ts
> > will check quirks, which do not exist on the MCF7527 platform. Therefor=
e,
> > we can safely delete these useless preprocessor directives.
>=20
> > @@ -2515,9 +2513,7 @@ static int fec_enet_mii_probe(struct net_device
> *ndev)
> >  		phy_set_max_speed(phy_dev, 1000);
> >  		phy_remove_link_mode(phy_dev,
> >  				     ETHTOOL_LINK_MODE_1000baseT_Half_BIT);
> > -#if !defined(CONFIG_M5272)
> >  		phy_support_sym_pause(phy_dev);
> > -#endif
> >  	}
>=20
> I think the explanation could be better.
>=20
> I assume the M5272 only supported Fast Ethernet, so fep->quirks &
> FEC_QUIRK_HAS_GBIT was never true?

From the driver, ColdFire platforms do not have the quirks, so it is
never be true for these platforms.

>=20
> >  	else
> >  		phy_set_max_speed(phy_dev, 100);
> > @@ -4400,11 +4396,9 @@ fec_probe(struct platform_device *pdev)
> >  	fep->num_rx_queues =3D num_rx_qs;
> >  	fep->num_tx_queues =3D num_tx_qs;
> >
> > -#if !defined(CONFIG_M5272)
> >  	/* default enable pause frame auto negotiation */
> >  	if (fep->quirks & FEC_QUIRK_HAS_GBIT)
> >  		fep->pause_flag |=3D FEC_PAUSE_FLAG_AUTONEG;
> > -#endif
>=20
> Same here?
>=20
> Maybe the commit message should actually say that M5272 only supported
> Fast Ethernet, so these conditions cannot be true, and so the #ifdef
> guard can be removed.
>=20

Yeah, I will improve the commit message in v2.

>=20
> ---
> pw-bot: cr


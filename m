Return-Path: <netdev+bounces-184327-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B94AA94B93
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 05:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 185C23ABE48
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 03:14:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5B4F2571B9;
	Mon, 21 Apr 2025 03:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="IxIgUHCp"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2078.outbound.protection.outlook.com [40.107.20.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24AA92AF11;
	Mon, 21 Apr 2025 03:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745205301; cv=fail; b=kTnRhElqMzBDcTtivz9b9IVyP+MbeJM5Niir88ZG7AdlsFuP8DOwZraAohAXv1CL0YPSwL8gsOpxnug4gNnlnoAfOKBIO8iDy4G+PgKeUwllx6RTGUS5v+JXznNSQnUCDd25YRw8ShzyG35mI7Zgjs4ZpzTm8/FDC15rHXrodjE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745205301; c=relaxed/simple;
	bh=GnOe0TgJva5QMIBVJS6VP3FZWMrvlitYaQNYPZWbDfg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s4y+iR5Jd6UfTfo9IF6h0A7rBXBwvoDtSbnjo22nPdYz6Flsb8JsHjmbKt3X3kcbzlw5iS617GHGc1uMWqwVeB6IDszjkBa1+eWQ30yRz6rjWZ5uPJbQj/PDsBfSFoRIDLOUDsbHamr5aJDdVL0ooMPTmBbR5buM4lxr4a8aFrk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=IxIgUHCp; arc=fail smtp.client-ip=40.107.20.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CRzqkZ/hNqsPhkOp+Svaq/8LdJQygbMunNpWope4iELc7yBbbyY0Yv8HBtWFNbQ8HWjJeC2B9OyJ19Jyo0EdZwxGpfmJ+xvNMUl2SF6K1RhUMlbMgQbtSy7GdDX7wXyPgkpVY+1OmQjqvppk75I4nPYNA+RZgm5oZIuq+oytpHhtIwj1RBfYugvrvVFQfmJ1ZsmtdvogpEsRkU49hTLTRHuClxokA/NG+Y0SwRQc1JBoNcOhzTRuAn6UzOzDPmm9NNmP1XQTFYSvXaBaJSPiAJ3NrV7H9nXrRxZf8jvJboSDMY42OAA+fEVXi2K//6TdD+q7uFSM+kUw689zSZYb7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HJSpcGPS1gw/n+iUWK1xktR6XEgqwq5ISKtQlb02BPk=;
 b=Vf41CW3z0cMzWFFArsRxSRuh8FQiV4EO6FI8ohBfSE7YEYp3Qi2+Kbtbi+sAdOSNrZvN8QTmzm/LkZCkOqbGZQOfxwmdLVW94kjHrVHWMBi09D5t6Hq0YVjYXjrq/kvbRw3RRqlqwVP6Rxarv30FFAyUuWQYLH0ldZ/vORM/Xd60un0Ts2gBhTWU5ksz9B9ITZRnF+Kij8/9GULhjCy2pO2YVEV8jOC0xmojbdiJD76+AXPNG8CYlBZHgXYw1RE1wdwlKWpvsjj7jecf5rOFYdoYJAnTqY/voFBrU2EwPj0PPe9Y88i7+M0OUduGGRtx6N7j4unGMsYgK8luDYGQ2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HJSpcGPS1gw/n+iUWK1xktR6XEgqwq5ISKtQlb02BPk=;
 b=IxIgUHCpWj8EzQ5IF1WvxTJyxn3WdR4Tj65oJAAEwP6i30ow+ndWz/6x+7uYqbNj0GDQwpkZH+8jR94vacrplkpKmxu/Aj2uJaRW4FRc174FTXb8bAd0qvCBv/VC2e4/SxzPEXn8A+4filTdW0eshxuAVnRSerrYWfY4RwLAirxIZWuH61xbZ2AAyyBH/31EqkftCzxkNuof1urWk6zsEnsB3TVfZm3hfsXTIZ5XL3LBYsOxBtuoKAqKiMQ7ZcOA8dNJhdp+5w6CmdiIHpy3G6hRSu1Jfqzj1fzSzeXj3V/RIiXfU2xRc41JwtkNUq4LIfNjaBb6hf1vGspA+1Ym7g==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM0PR04MB6948.eurprd04.prod.outlook.com (2603:10a6:208:187::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Mon, 21 Apr
 2025 03:14:56 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.8655.033; Mon, 21 Apr 2025
 03:14:56 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 net-next 04/14] net: enetc: add MAC filtering for
 i.MX95 ENETC PF
Thread-Topic: [PATCH v5 net-next 04/14] net: enetc: add MAC filtering for
 i.MX95 ENETC PF
Thread-Index: AQHbqsrnhddQYwLh8EmRihJXUf5Sm7Opmw+AgAPeiwA=
Date: Mon, 21 Apr 2025 03:14:56 +0000
Message-ID:
 <PAXPR04MB85107B19F79BA40F70950FE188B82@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250411095752.3072696-1-wei.fang@nxp.com>
 <20250411095752.3072696-5-wei.fang@nxp.com>
 <20250418154117.jcd6xxnwot4nmhek@skbuf>
In-Reply-To: <20250418154117.jcd6xxnwot4nmhek@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM0PR04MB6948:EE_
x-ms-office365-filtering-correlation-id: 42f8ebbf-2c3b-41e8-6400-08dd8082b154
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?xDSR8D533SYqsd8MN0FNHhY/IsFPjUXjhtG5wSXeRcGOhLFA1v97rSdvBk6S?=
 =?us-ascii?Q?IhIDQrXyWYOjdUSli2nVnYQM3UcK4ffSWPVjQW2E0x1OFnW8no0Q/Kb6Lxy+?=
 =?us-ascii?Q?T312cKVB+Pt+mEOTXM0Ql3yds8ml/iwWyPre5En416EUyvp5imbaVF9NAcyt?=
 =?us-ascii?Q?V9YF24+KnpjGJ7PYn2uwal4sxJHNBG7y+mr474DcT7q9xqRTEv7Jr+nMbak4?=
 =?us-ascii?Q?q5/s0x0GZ2m+AI115y9oGTY3RiW8qinZhqiOfABS/eclLl/VcGMTuA8wDPm1?=
 =?us-ascii?Q?EtbC262ACXIzj1xXk6Ot/f3HP44WClD9Wu0QXdNWpfASyVkcL//3Hps/6pDm?=
 =?us-ascii?Q?TQTt3J3BqKqG+dCrqQQLH8ALvA54Gors1Ln0TzFgvGm9rp5EavnUL6ndopMf?=
 =?us-ascii?Q?mgd4QvJ883v1MJMLgXSLFWdCzQKNg9uIa83uqZtG5VPeRHsa8NuaDxUhhT+D?=
 =?us-ascii?Q?T+vF7f0Rsn4XDcKuwAnDDXBMejOmJsxuKMB1Zir91dGjR2ZAIT1poG9/st9X?=
 =?us-ascii?Q?ZurCRjh5uZl0UuxccM9H7p9+fjhCDy2h6v9SXMbjeJVzC8NgnYsPHvh6Wy4+?=
 =?us-ascii?Q?936H538T1ii/JCi7PYnPCtA9bvbojw3yehDEpyEhlh44Fl2ui/LJHkAYO+nE?=
 =?us-ascii?Q?MN1krxAmXHXfpvGvB/uwExOtWFFXkn4sXNmOh2WxrKwWqxIuHF8XsOPhG7MB?=
 =?us-ascii?Q?AtH3aXBF0Au9cdAKRLk7L3RL/bGw3+DmpTLXP4NiWgN6pzKly6J/Yz+HRsCk?=
 =?us-ascii?Q?khDUA7sSrYtjQ52VZoc3pAX2WrRQsqWFHNWwbCJyeUrQIrcgZQhd/Z0gHGJx?=
 =?us-ascii?Q?sVtfzalGb60bCsis+xF5snWLEEkJWZvLwe0z3uhtwvOzDmRKBFofkGIPPFrs?=
 =?us-ascii?Q?EYZGX2YEXrLENeZvri48RqD9fwrx4nu8K0aFCtcBu9PhuKG4ZttCXqmnhNqx?=
 =?us-ascii?Q?aPDrecFtmFucGPGz+Qffzh9fWH1zxa6HrdvNaH/4e3ge+FZ6lq8steK6cb3h?=
 =?us-ascii?Q?sGe3BiRVpfnNUTJ9J3eHHNMe2TZEAMSZG0ZZqDkt8ExQp8D0wZc7BYq8EcSm?=
 =?us-ascii?Q?iMtsS+Vd0lrJbiwBZcxqaLdj2sUewMjwn81QnJ5xg1pXW6wGyllCMDrm5Y9x?=
 =?us-ascii?Q?wnbNVeX9PnDSWhle7kDGUTvN0KzrzJvFU4qM+RxUA0i65Bz9g22XzeL9snmR?=
 =?us-ascii?Q?Q47Fvc3c7vwcKr/b/EMEeBgCSoruGOsbyF4fpfm/vc72z7qfTAP09f/VdTIV?=
 =?us-ascii?Q?iO5dZqGSA4Obu4EMqOxlSpvtK+LLDmrVmjGJNo8QHdJH1EASiqUYBaTVeTGX?=
 =?us-ascii?Q?oI9ZkseRu2Q7atnL1SSmm7zfvn64/xL3t68gum9Yib9UHtWKjbBXsqCul2+H?=
 =?us-ascii?Q?U5ac0WXQR83aTVAI5zuLJ6grWf4+xZQ8U6ATghAcpeXIcvtK8WdeiFo4VYXe?=
 =?us-ascii?Q?/GWdTgDQCWtiAE4m8wNvW3sDJK3E6wUF2t2m3Dm/s1FzeuhBd1A+OpbKRxSL?=
 =?us-ascii?Q?q0POKrKtrloVnCs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JiVl7ob0YqT9Tow83z0xc8MOVr0RqJ+iya3WHg6xGE647RZzh9ppzMF+z9ft?=
 =?us-ascii?Q?byty4CY/V2K0QkraP4/QCi/uzxV29pRwb6ApcNTynzcNFMLJu+4Bm9DaRfww?=
 =?us-ascii?Q?PJhcu8TplY1bPp5e8j2YGqZkSwIiO2cs2+zn5olEEjPadOD36CEUX+1OzBv+?=
 =?us-ascii?Q?Ml6HuD/k8xwqYje+BsF3Mzng0oJMVOfazcq1Q68QG4WqcPvd2EdidXH2Aii1?=
 =?us-ascii?Q?yYOUVp7NYq0S4Jk0ewPlMo3XHLPGkDKGu6uwnW0qUbO+6UACQQlgxx6jd5gd?=
 =?us-ascii?Q?9zudcfKoR3OyJPTCnCirUqHgeW8dE/HrUnen2Cjb8git1/ITIszAMplMBqYe?=
 =?us-ascii?Q?xRN31VqurYvTOhdWmt+/ybxrLntM5OYcVBAE4u0bBwWXc07o4YJEAm+CAJIq?=
 =?us-ascii?Q?l+K+v64CX2/5pkAAvZb3/lssgKtYOYo5XJ99uQ7atnTfPMmsUMeLLoTQCoTi?=
 =?us-ascii?Q?myR/pMFzN+EvwueS+uA8L8xx8LBZRuk5i/1EplFqRKnf2Y5uePmqjk85gU8D?=
 =?us-ascii?Q?dkwhERYAoOrWDWsmRnbu5f0xVX/cmCBACpinnqtz+nw4QFfo4gJrUlidTy+m?=
 =?us-ascii?Q?rX5wHTTPnQYc4hrePtX7q5j0v27N44HPIJGkY1Oc5kv8Gk8+EqINBmfJw5Vu?=
 =?us-ascii?Q?0myuo2hq6irRwPeI9sA5us9Nb/EAcgj0xiFHhT6bJmOlT7T9dCaoEGy1T+4J?=
 =?us-ascii?Q?W5xpIifxzA2U1Ox94eF8pld4rB8mNkPqsja0G56ucZl6uFdcNHLOHXaiLFRI?=
 =?us-ascii?Q?cLxcx6B1tcvHQefSwIDNnD5y3z070DoVrgBhUB2gmw6IOV+srote9FB9k2of?=
 =?us-ascii?Q?4+jvRWXcPqHvJPhVKMSZWpSEDsLMaCbE9a7ZFn2ZTHu88B8AFW00DM8mI448?=
 =?us-ascii?Q?GrcsYIRa7oVWwWDYSMVsU5Xm3ZA/ku22oa2kgEgvnWV2fnGwiEgMabbBj8OG?=
 =?us-ascii?Q?xnhE8RuzUYPGAMM1JsuDdW/eBViDJ8h6CwYxLFln4FpN83SW1v8PMZ6IM2Uc?=
 =?us-ascii?Q?UOMg2RMKhIn+DARE4qtq22D5zOkVRF3PIc9ubr/F1TmRtSczGfD1+x3vgych?=
 =?us-ascii?Q?9eZC9gDwLuCpodHKKC/EaFNK9y35lpiIhH71oml8HLIjNZOxhbIjrGR1TP9S?=
 =?us-ascii?Q?aecPKrv1E3Gk9Sazz+K3Ev/Sp40qkBZdvu8vTGKXu1eBXB51cJwWaMKjYiNz?=
 =?us-ascii?Q?mk7/yXjIhaZ1i4mazKpA19zCc/EpkdaCa6ODvfTRkd8uveruRP+7Ds0agRyN?=
 =?us-ascii?Q?n6SPWJPI0jDIpjghGQFt62t2rtYImxJy7eHvRfrfQQXB8CsZAU7EwV3kCto+?=
 =?us-ascii?Q?I8Io/e+AWwOzAg2ciXzET+Y/0hpKhPfPxRfhVsqko7TobPBAxVjPcQHq66tR?=
 =?us-ascii?Q?Ym8WmeFP3gKawRq2oDD37XoYkRgg+dXB5Ff35O8935FnG4ZQvzDhQsbzUNkO?=
 =?us-ascii?Q?nWqkVSRw/JOKQmWQwoqv9xrf2dzIlnPMQ7yyh+Te3oM5J6OJkfzFYJhZGz/x?=
 =?us-ascii?Q?OB1Mm1WiAL15v2Dnw9sH2KEcvC18WOVtwNEUTCq3zgZbOEhVfYXd1nVvK4bd?=
 =?us-ascii?Q?V/wQrb7ClamFO/PbPxg=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 42f8ebbf-2c3b-41e8-6400-08dd8082b154
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Apr 2025 03:14:56.5478
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HuLKEFHn8Rb4uDRhHU5LaZ/oSeMkA8B/R/HNfOCczTtYTr4hnKJFFv2UOYUb+ZS8aTk87wHv29VQcMl7G12k7g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6948

> On Fri, Apr 11, 2025 at 05:57:42PM +0800, Wei Fang wrote:
> >  static const struct enetc_pf_ops enetc4_pf_ops =3D {
> >  	.set_si_primary_mac =3D enetc4_pf_set_si_primary_mac,
> >  	.get_si_primary_mac =3D enetc4_pf_get_si_primary_mac,
> > @@ -303,12 +489,55 @@ static void enetc4_pf_free(struct enetc_pf *pf)
> >  	enetc4_free_ntmp_user(pf->si);
> >  }
> >
> > +static void enetc4_psi_do_set_rx_mode(struct work_struct *work)
> > +{
> > +	struct enetc_si *si =3D container_of(work, struct enetc_si, rx_mode_t=
ask);
> > +	struct enetc_pf *pf =3D enetc_si_priv(si);
> > +	struct net_device *ndev =3D si->ndev;
> > +	struct enetc_hw *hw =3D &si->hw;
> > +	bool uc_promisc =3D false;
> > +	bool mc_promisc =3D false;
> > +	int type =3D 0;
> > +
> > +	if (ndev->flags & IFF_PROMISC) {
> > +		uc_promisc =3D true;
> > +		mc_promisc =3D true;
> > +	} else if (ndev->flags & IFF_ALLMULTI) {
>=20
> enetc4_psi_do_set_rx_mode() runs unlocked relative to changes made
> to ndev->flags, so could you at least read it just once to avoid
> inconsistencies?
>=20
> Speaking of running unlocked: if I'm not mistaken, this code design
> might lose consecutive updates to ndev->flags, as well as to the address
> lists, if queue_work() is executed while si->rx_mode_task is still
> running. There is a difference between statically allocating and
> continuously queuing the same work item, vs allocating one work item
> per each ndo_set_rx_mode() call.
>=20
> In practice it might be hard to trigger an actual issue, because the
> call sites serialize under rtnl_lock() which is so bulky that
> si->rx_mode_task should have time to finish by the time ndo_set_rx_mode()
> has a chance to be called again.
>=20
> I can't tell you exactly how, but my gut feeling is that the combination
> of these 2 things is going to be problematic.

I think we can add rtnl_lock() to enetc4_psi_do_set_rx_mode() to keep
consistency, as shown below.

--- a/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
+++ b/drivers/net/ethernet/freescale/enetc/enetc4_pf.c
@@ -497,6 +497,8 @@ static void enetc4_psi_do_set_rx_mode(struct work_struc=
t *work)
        bool mc_promisc =3D false;
        int type =3D 0;

+       rtnl_lock();
+
        if (ndev->flags & IFF_PROMISC) {
                uc_promisc =3D true;
                mc_promisc =3D true;
@@ -519,6 +521,8 @@ static void enetc4_psi_do_set_rx_mode(struct work_struc=
t *work)

        /* Set new MAC filter */
        enetc4_pf_set_mac_filter(pf, type);
+
+       rtnl_unlock();
 }


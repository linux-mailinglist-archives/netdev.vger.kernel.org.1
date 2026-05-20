Return-Path: <netdev+bounces-289811-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CBkdHKljDWquwgUAu9opvQ
	(envelope-from <netdev+bounces-289811-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:32:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 703A3588FB7
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 09:32:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 058EF3013D7C
	for <lists+netdev@lfdr.de>; Wed, 20 May 2026 07:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FF653264E5;
	Wed, 20 May 2026 07:32:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from CHN02-BJS-obe.outbound.protection.partner.outlook.cn (mail-bjschn02on2122.outbound.protection.partner.outlook.cn [139.219.17.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62FEC24293C;
	Wed, 20 May 2026 07:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=139.219.17.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779262370; cv=fail; b=SYW7YGwF/Pm//BHKa0xJZQcPEiUIAWdmiC2MEq14piLr1MbcEc4bxKZ3DtVxFb0HSfyu6uqzk98/T0BPtlAFpR7FASncfJ0xTdSvv2wVEzewZzwWkmOebUg+MXtQmSn5zWP6hynwIrmn5sGL18X4gaSi1OGjIjp1vNbetlOlHpE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779262370; c=relaxed/simple;
	bh=RWoqrYLaMJhlygCiJ/8bM58vzUxdzEiQ86iXK2L87dI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UrEkk7vIZpCmJVB5dMC+B+8mUjod4zSkjS1vLcKAj9xdvDDcdmYMa0ejTqdo1pN7nxRDVGJ9A4PYqYoTN/k+brbF1pcFNAj3ijiKdE/d2X0LXOkcG/SPixhIsfODUa2RIYgqLw+QUHCSgLU4Xsl9pweUNE+MAaMItp18MZ1hOu8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com; spf=pass smtp.mailfrom=starfivetech.com; arc=fail smtp.client-ip=139.219.17.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=starfivetech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=starfivetech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A5j0t0vQ3mYlyL01kRc8Lu61UjRcvx77AZJMMzUF/isVzMzZBM+FJPpPmk5pQEUbfiMRGijOBvRsjBNi/gkKTixvMkQeVhGFERLar7yFmNue/xNnHdVCB6Mgx95ce94ap9j9l5EvZyozBAxTnPaJWinv1BrVSJHBCxME6LaFZAuAi86mssEcx7cAnLao7fr8stmkgs68ZNXb3pbiw8lxaCqzeILqZ7KZPEOYXrCAk/+47+jcO9OhhoCMxC4Mehs3mvqaIrBl/dDbn6udgyw/KxCEdG2EQGrPSpDf+6W4Uwv8PtkEGgbanaik06QN9ITw7Ny7u11yiFSVimp9yu6QLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUvkoKV6OPo3U49ZxrwKYkS+mzW7t1Us0+gldRfvbSg=;
 b=I/Z3R+8V4TU13Jx4uuJ3MDesHZbWq3pWSwZaUosAcpEv0WyGrdIo3ZN5mI5i4sxa92GKLc6KAL+REVP292/V/l2k7UdqFg5PhS9SvvM9IF2OstyL8GzH2opw2mQGq2+RFsGnjQN4koQQw0RVATi72Ucq36jH2p7dfkUqgNaUAtEjGEN6AKW8LpyMooCQX6p5RTftT2FdUWC+AcvvuYSjVD8sjcnJRHzwWbGNxswfAkyNyYlyEoeAaphjLKWsB/ELRv2DNE7nfmkpHeZEib3zZ8crStF2/H7Hxu8YovQ/hVcws+Xz5bhliJEWVlhxPSGOesDX8lThp7NoUa/b+GsegA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=starfivetech.com; dmarc=pass action=none
 header.from=starfivetech.com; dkim=pass header.d=starfivetech.com; arc=none
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:25::15) by SHXPR01MB0893.CHNPR01.prod.partner.outlook.cn
 (2406:e500:c311:1c::23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.15; Wed, 20 May
 2026 07:16:47 +0000
Received: from SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
 ([fe80::9b99:12dc:a115:b90f]) by
 SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn ([fe80::9b99:12dc:a115:b90f%3])
 with mapi id 15.20.9891.021; Wed, 20 May 2026 07:16:47 +0000
From: Minda Chen <minda.chen@starfivetech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Alexandre Torgue <alexandre.torgue@foss.st.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S . Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, Emil Renner
 Berthing <emil.renner.berthing@canonical.com>, Rob Herring
	<robh+dt@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>
Subject: Re: [net-next v4 4/5] net: stmmac: starfive: Add jhb100 SGMII
 interface
Thread-Topic: [net-next v4 4/5] net: stmmac: starfive: Add jhb100 SGMII
 interface
Thread-Index: AQHc53hU+JPeVlYe+EWGQV8dabD2M7YVZY0AgAEcvhA=
Date: Wed, 20 May 2026 07:16:47 +0000
Message-ID:
 <SHXPR01MB0863206A6ED966AABE7B3407E6012@SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn>
References: <20260519101436.111476-1-minda.chen@starfivetech.com>
 <20260519101436.111476-5-minda.chen@starfivetech.com>
 <6eff2d70-a0ac-4d9c-8261-eb5249b7c877@lunn.ch>
In-Reply-To: <6eff2d70-a0ac-4d9c-8261-eb5249b7c877@lunn.ch>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=starfivetech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SHXPR01MB0863:EE_|SHXPR01MB0893:EE_
x-ms-office365-filtering-correlation-id: 15a16b51-a1cb-42a9-dc18-08deb63fc137
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|7416014|1800799024|38070700021|22082099003|56012099003|18002099003|4143699003;
x-microsoft-antispam-message-info:
 WH0rLBO9RVD2hXBkiWzoX/8UpCUP3iEPMVNXGOroz6IAcgdVXAaqSq5G2BZ+xP0tjvunzH4+/1qViL3Eq8wGbiEU3FYFr4qkPOcRiR8jVU2ohMbsdXUcfXm3ccq653CTEHqKTo14J/36fCRvwcsPQxh9oLeuIXen6hdMJOb1K7TzaguCXcx6krFP9aP3PHYXbCiD36LSL23DLlrCA9Dtsz9azojtAC6go/Y+6X3GENAUDrcNeLZifQilee4RwYIP4LB3+QxeAu4nWWgg+4/GGF6NywrT4bNK3HsnsQxCbd8S1LlsimpVmIgzHpARbNAxYcm3HdaLQj/r/NxPOJqrqH7IQhOuaq5KMrD1YtHvAn9LRqCQWid9iOttXHvpjuyQeQJfEgc5MA8N2jm842Gkc6pkhMPV+51EpsvM2koX2imrbF2UlQT8qRIoAsW0k7LasZRLAh+gYjdypno0YSqVHI0Aphk0kyD1YKEi3R/vYnJlaaPemp8zN9aGf0w8r2kHxtmsoUNfGYpHQ1vi0NekC4ll0m0UAew4ggX5bAT+o4QUdKSctFMeQjg51N5Ff+Xy
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(7416014)(1800799024)(38070700021)(22082099003)(56012099003)(18002099003)(4143699003);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?rtR3bmjr/mh8tQv/wvw67vrkiVP6X6B/a+zv5W4dTsQml0o2TU8vHtZxZ4tK?=
 =?us-ascii?Q?8E1PWPaSq5U9gpBzrH2HWU3Qbx77INiLWrVvPR9Z5n8TjvAKRCgI7dlQGmNg?=
 =?us-ascii?Q?Z/6o/c8dP33RBurPURohQyzjZECMgytKwR0BxDXSDpLGaqIF69Lmw3J3gdG+?=
 =?us-ascii?Q?I3F9H0b1aJ/KFPrpVBCOPN++DXziLk7MUOXpf4+HwqybZW00ctc3cIXY7xK7?=
 =?us-ascii?Q?D0JJEMzBALMbp3WwYLw/Ypd5j5lf7GS4hh2vwe/k63ePRs/M9CLLfrhxUu7O?=
 =?us-ascii?Q?aS0ETZayXthCXNEz5w2wInUx3SJbBbHYN8HZgqkQJShyRLKwFVyjwqkMD+Sb?=
 =?us-ascii?Q?puhohaSU8YupsQoTiOTREftC5YT8TO4m8Db73WeK8igWQX40F4+IEQrKa1cv?=
 =?us-ascii?Q?Q/ymd63fPQ3QP1waWYF5arxLJunGkW2sACgIdyw5V0VtuHsRhfeDOHMg/VfC?=
 =?us-ascii?Q?C9KPhx4OPXy7o4yzhhUlzqfYRUREtOiwOIy043C5zHIiHgtG0DasHDI53GDW?=
 =?us-ascii?Q?xdIdqlPn4ttudm/vdkx+8ihyPK22AgQ4nXtr0OfVgfYdM+eUiJJTkkDLcaG8?=
 =?us-ascii?Q?QAWj94jXPv1SkQHtLE/SIPJqEoMvvnSPLsWen1nkQXJn0tq4Ru8d351LF1TW?=
 =?us-ascii?Q?0thN6GKfmwrFZinYCP17pvVdrPgI0m9sA6TPfHjnQZXT9SPtagXN9AkLEbg1?=
 =?us-ascii?Q?UBDGpluWKhhBrfjS9jbu80E5MckvTYRdrG31z/H/6tbYkPj2OQV8Nz0mds9V?=
 =?us-ascii?Q?xyJm2e7a70zkFqRu/QazNXANf+/xggINiofrYugtZmaDdEuHO/YFCju+j9PM?=
 =?us-ascii?Q?VB2YKFjdrmn/E0kD78t84GuRh1CHpfGc2xXH/QMILWEhb+sXQbh3BBmeji2u?=
 =?us-ascii?Q?EerpbqnjcKQByGtxBPEGp6udKWUY8JbOYm1+h+I4GZqSrBUaA9fQG/8o7Ikb?=
 =?us-ascii?Q?hp5msLTRXZV77FtnN80c7tHpIGgCL+TicRSA0Npziyaaoe9dsHYS93XptZfW?=
 =?us-ascii?Q?fkX8bUHGJfiEEZ13m/2Y0mij5YxfiNHZQW7enNHVK/85IKExsXNuR+u6JOKR?=
 =?us-ascii?Q?ikJLnohiLNGPxdDrYTaAlJyEWiRioRqWd0GTLHIDNM9lPFXewk/7Qs7Zqyhy?=
 =?us-ascii?Q?73KtTVqtLpb0AUG8voawiUtt71bOLn3Uh+lUrm5mXkk7hKvhyLMNUGZ5lUaX?=
 =?us-ascii?Q?APVWjkLRFyTqmiA33C0jjDNCvQjhyhhCKqm7U6MGO5SlXdGcZWLrb3kxPDMg?=
 =?us-ascii?Q?CSacqRG5zi5uYNwpYJnXdXOpgU2zHVBhCq8M88nUxniPC+HbgTocMpId4/6Y?=
 =?us-ascii?Q?of6ANhAXcmAbSu002+LkYjHvqh7ydPj2S1tKc4vC/C5bnigZs+/tAB7Tzfqx?=
 =?us-ascii?Q?6oDDgoNFn401GCn7x+0WCFa4R64HQvRQ8l3M/pOhsJP7ctzqAXrPZT93mWMG?=
 =?us-ascii?Q?xC1ZN+sx+2O3/Df4lshYwheN4hwYnLC01T9Ks9cpcExmUh5bVmG77bXAQKPi?=
 =?us-ascii?Q?QO/ttJFH4VQOerxkEJrSB3Ud+ZwwMjtU5E8vIidmnrQ7xNcTNECkIQGLlR+T?=
 =?us-ascii?Q?2grHDTtPNkcASo0TeyNtCdRYDgVn4IyTTLReS6cGa6f7frdXyh2jr7DGD9Ip?=
 =?us-ascii?Q?52Serg6gvbIHtk5WsnguvLYjxqHzPCeWadR70CfAh+uP+X5MIsMCzJfqSlJj?=
 =?us-ascii?Q?tube9BtXnia/JRaJxpr6a5XNP3ggoqkbpJutkmBaomh4wvYeEpxj02Y3XBIx?=
 =?us-ascii?Q?b5QuYftRvg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn
X-MS-Exchange-CrossTenant-Network-Message-Id: 15a16b51-a1cb-42a9-dc18-08deb63fc137
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 May 2026 07:16:47.3411
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 06fe3fa3-1221-43d3-861b-5a4ee687a85c
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qshQ8i/lLkaIQh0gZR29BH++5/HXQKnUTLF7qL6WX40ExMSEqyys7f3dudEcCWt4mK/j/48IJktTcfb6N11roaj/6276smvim2xi+FcJiKU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SHXPR01MB0893
X-Spamd-Result: default: False [3.54 / 15.00];
	DMARC_POLICY_QUARANTINE(1.50)[starfivetech.com : SPF not aligned (relaxed), No valid DKIM,quarantine];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_REJECT(1.00)[cv is fail on i=2];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_CC(0.00)[foss.st.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com,canonical.com,vger.kernel.org,st-md-mailman.stormreply.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-289811-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[minda.chen@starfivetech.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[SHXPR01MB0863.CHNPR01.prod.partner.outlook.cn:mid,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 703A3588FB7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


>=20
> > +static int stmmac_starfive_sgmii_set_clk_rate(void *bsp_priv, struct c=
lk
> *clk_tx_i,
> > +					      phy_interface_t __maybe_unused interface,
> > +					      int speed)
> > +{
> > +	struct starfive_dwmac *dwmac =3D bsp_priv;
> > +	long rate =3D rgmii_clock(speed);
> > +	int ret;
> > +
> > +	/* MAC clock rate the same as RGMII */
> > +	if (rate < 0)
> > +		return 0;
>=20
> You probably should return the error code, because something has gone wro=
ng,
> you have been asked to do a rate you don't support.
>=20
Okay. I think return -EINVAL is correct.

> > +	ret =3D clk_set_rate(clk_tx_i, rate);
> > +	if (ret)
> > +		return ret;
> > +
> > +	return clk_set_rate(dwmac->sgmii_rx, rate); }
> > +
> >  static int starfive_dwmac_probe(struct platform_device *pdev)  {
> >  	struct plat_stmmacenet_data *plat_dat; @@ -102,23 +122,33 @@ static
> > int starfive_dwmac_probe(struct platform_device *pdev)
> >  		return dev_err_probe(&pdev->dev, PTR_ERR(clk_gtx),
> >  				     "error getting gtx clock\n");
> >
> > -	/* Generally, the rgmii_tx clock is provided by the internal clock,
> > -	 * which needs to match the corresponding clock frequency according
> > -	 * to different speeds. If the rgmii_tx clock is provided by the
> > -	 * external rgmii_rxin, there is no need to configure the clock
> > -	 * internally, because rgmii_rxin will be adaptively adjusted.
> > -	 */
> > -	if (!device_property_read_bool(&pdev->dev, "starfive,tx-use-rgmii-clk=
"))
> > -		plat_dat->set_clk_tx_rate =3D stmmac_set_clk_tx_rate;
> > -
> >  	dwmac->dev =3D &pdev->dev;
> > -	plat_dat->flags |=3D STMMAC_FLAG_EN_TX_LPI_CLK_PHY_CAP;
> >  	plat_dat->bsp_priv =3D dwmac;
> > -	plat_dat->dma_cfg->dche =3D true;
> > +	if (plat_dat->phy_interface =3D=3D PHY_INTERFACE_MODE_SGMII) {
>=20
> Does the PCS support 1000BaseX? It is not needed now, but it is something=
 to
> keep in mind, try to avoid making to code too SGMII specific when it migh=
t need
> to be more generic to support 1000BaseX as well.
>=20
> 	Andrew

No. do NOT support 1000BaseX in jhb100 soc. I think 1000BaseX need new serd=
es PHY
be Intergrated it and maybe new setting.


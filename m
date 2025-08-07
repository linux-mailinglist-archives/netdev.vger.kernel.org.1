Return-Path: <netdev+bounces-211998-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A88EB1CFE8
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 02:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9009F164DE4
	for <lists+netdev@lfdr.de>; Thu,  7 Aug 2025 00:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBA3C3B280;
	Thu,  7 Aug 2025 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="F7X9uOkj"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2079.outbound.protection.outlook.com [40.107.223.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D6710E9;
	Thu,  7 Aug 2025 00:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754528011; cv=fail; b=GP/tAsp0y/eEYnQE61Ug1si43CiMJhVF43C0d2mHkivCMTHESjPX+00486RTlcuQX3XiFv8z/NlwMhXwXqa+jinwLdHrysdlGgVj3tA4IxxgYBul0hSCfYNayvcj9jKpgGvGicAO6fB+SQ1xrd1JejRbLd+RCZf52gRHvE618Qo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754528011; c=relaxed/simple;
	bh=c5+MWJqzUIS1Fvdeh26VGyExE4pagNf5ZMzyp8Jnq38=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=arYFKOolGODDbKls2SE3R81wtNw93hFYXEW5d9+x5lMCw8RPc6XLjzNMQ+Uo+pYsn9I1plqjrFOw+Yw4iZdWCR9fqhG4iu7qzPL7pnSv4ey3qeKFpYa6Jh85eutJ3PpH3J9EdJ3ghgLzyBZHVWi3F+Yh3F+4EN7dS78zZaUIoN4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=F7X9uOkj; arc=fail smtp.client-ip=40.107.223.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jBktolJ7GdHuvmQnawcT0yORbcEnlxSlfRDyf6u+djHlOCnsvkX4xM2KOhzdxvzUssYzqcLG5v4zQQjTM55RIi4fqeMjsAx9iBKFlu4I6Xplps+NIu0y7DUqz/ve7L2Shk04ZUDrQ4zA4IM0G8KSojVDTIrtpACy4UTxNxD6z56oi6A/SdfvFIZVPqI0/I5xNO+OSFU2NDZV4JvisE9EfKVXljqk6YmrkY89vRDSyyOPa7iWKDoiNHub0rdwVUjyy70Gc8oLkephJWGGadD2UR5ahXMMmkeDB7ETKQtK70XWGZXiy2p9uM6a0QvgzYcPd+C6Rv4uuBWSIg2UmQ3qFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=C1S+CsenROpyrZRPhqkBWUXb44IJjWyF/HPKJyBwlI0=;
 b=p7UiMz5QO0dSRhaigHpzzHa4PnjWx7p/5x7Zk9Ef/oxNfX2fb6kxulRE7pOmV8nTCteELsjdL2MXLN5Ie+pc7c1Ra3XBPMmegAA3mKGRpsB/X5uupMcYTuNQwRKNgJCSatpfYdZl0KTTlhJ5Wcnrp0tEPko+9KpBUJ8lD7nJfsTIHcBfN8f4FJ+vGEeUqc/FTNIJEpRiLek+mW4pnToBtzFDghhPNj6FJUQcHapeRsCYiBglllvEWDGk406O7TCJYwYQcGO74ZuPiwJiHvCNeOm15qIeEMGRlgZMLgVSJMsIzwum26FsUgNnviCEvrNohdRhrxiIZWf91WYNi4PfOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=C1S+CsenROpyrZRPhqkBWUXb44IJjWyF/HPKJyBwlI0=;
 b=F7X9uOkjwVqhWdv75AxQlxL+wqtRefn/jFzsG74OPG7zasRcm0KG9Tauiyqej8POvls3l+vTf78M4osBba2Qje1hI/Lw4GSvdSqRCcpJU9eRVeES/Co3k5rpuYWRtfnfquFY11fVOWvgdMPhpv4wSGg7wmBDdoRB739skfdEuNEw7PNCpSrMC1BWIWuX6Q20gIP8yaUk7LigtsVrHzkjoO9Gf1v47Fh5gnDWLqX4X0Hp4Z+KDxwRQuj/jvRS1mFCZSxwQcz1LTdOqm55/RRZA/Fcc91s/P79yA2TDki2Ru1p7AD2Lo6EKyVd2msaly6VC1zoJn2OSbDrS5Wi1IymRQ==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 MW3PR11MB4604.namprd11.prod.outlook.com (2603:10b6:303:2f::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9009.14; Thu, 7 Aug 2025 00:53:26 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%5]) with mapi id 15.20.9009.013; Thu, 7 Aug 2025
 00:53:26 +0000
From: <Tristram.Ha@microchip.com>
To: <o.rempel@pengutronix.de>
CC: <linux@rempel-privat.de>, <Woojung.Huh@microchip.com>, <andrew@lunn.ch>,
	<olteanv@gmail.com>, <maxime.chevallier@bootlin.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH net] net: dsa: microchip: Fix KSZ8863 reset problem
Thread-Topic: [PATCH net] net: dsa: microchip: Fix KSZ8863 reset problem
Thread-Index: AQHcA0OVRw6vHUSQj0GZgGjKuek5lLRPuJmAgAard+A=
Date: Thu, 7 Aug 2025 00:53:26 +0000
Message-ID:
 <DM3PR11MB873655B75D0FF0E386567293EC2CA@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250802002253.5210-1-Tristram.Ha@microchip.com>
 <aI5gDWqMBBtESscm@pengutronix.de>
In-Reply-To: <aI5gDWqMBBtESscm@pengutronix.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|MW3PR11MB4604:EE_
x-ms-office365-filtering-correlation-id: 2e0f6bcd-9fd1-4efb-4ee0-08ddd54cd15f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?tp6rgIblF2G+03pqWvw6/NQqoq7zfNlTKPsyUu2hJWBdkCP1EPeblh0VBIBK?=
 =?us-ascii?Q?9b4pzVoI9zr3jFEkg8ZyVXlfpzqLMn9PFwiifAcctjLR4/36ozU9Lp/cgCWx?=
 =?us-ascii?Q?GTFTp6rKIg426IODMTBHOumJoxFBbAL8jtaGfGuuLTehG+MKpNLMAz8RgBt2?=
 =?us-ascii?Q?WskPrDx6vCgPm3+1VV9yCc+TSDrPcVA/kSuhNeKnsYIihKZD2pgs3tWKIz3O?=
 =?us-ascii?Q?1r219fxTmK7BbMQtioSBaVfglMHVaQ4AfOL+A+XHZJQmmnj3OX7q1yQF0i25?=
 =?us-ascii?Q?M3rpcNo69or0hPddyZj1SKSN+aCuQnIivNxEyCKo9vbLje9iD4qp7lMsanQG?=
 =?us-ascii?Q?XMokV7xTMhGx9GcxRtTvGMJ9keu6BZzMJCzME7KGNJj/lWBusEGhuBLI0RKA?=
 =?us-ascii?Q?oL4nh0L3GUIdWAQPnCVKUyZJo7QAt4Df/O8hzvjQDT2+jrNwXwbA1f/3CaS/?=
 =?us-ascii?Q?iOcAN5WxkIaDXUzm95Ka1keXjxonz4y3DTFpx2y0F62qUWu/GogHd0NqTOQy?=
 =?us-ascii?Q?I+bg9ey9tqZFbOgcVCQfj/iv0j9AbQud0KI8+S/dycCZ+SM0Yzjq4zNEP2Iw?=
 =?us-ascii?Q?H5dsRZ1LOUrpAhEJBE80bfAckQqCzeMzWmd8qd+LKL0VD+9ZPCCodqFLpAb+?=
 =?us-ascii?Q?99z3EjUUG5I9p+7lcaQPsfEKTkG/yjwPbGoAIXeKhSHFZKGtWBC1jcgLjeVH?=
 =?us-ascii?Q?g9stszsUGNcQWQs+JGwioMxKkCsM70dKVBOkO1YNjst3Ph7TvSaI3j0ccVUb?=
 =?us-ascii?Q?sJ/3BwEg7Z9Vn85abKhAScayGbhAv6Fxnz06XCOf45QJHkun3RLMadZ1soGB?=
 =?us-ascii?Q?FW7xbX5Qt39VHJ0TJq6ZnJAizwZMDbFEvZ4qQKhZyUPxviHf1zngLJl2r6Ur?=
 =?us-ascii?Q?g3sGTab/Ek/b7VJgx5sTJh0orZeB4IQ6GtSN8yNt2H9oIG/mCKm7sBeg7V/L?=
 =?us-ascii?Q?HWqe2zb1EkVXeYggJ4nFdofAwHPgew69Q9H6xFHsyjAttkzikDuicbAhhWrg?=
 =?us-ascii?Q?m8W9geFJIPh5vJTpGwlkzTU8OhG34kmV95lshP/uAPdsjdz4wy7r2i8FO424?=
 =?us-ascii?Q?s3KcQaHxMC8QDcrsYsUW9v8YXNuUW8YSBRFWEVjJIkn/PK5QPV6VLB6SocMF?=
 =?us-ascii?Q?jEVM9OSXJb+BFlZVzyQV7R6aTy+Ld+w9Lf2Yt9YCrcyc1eNW36rp7GZFYKto?=
 =?us-ascii?Q?00Yi/9Xgx0Gr2UXJFv+OK0XZ3x2Y0YUotHPsFDNqqh1+nX92FktpiCZDF9bj?=
 =?us-ascii?Q?UYhxxPTSbGvFPKfa83STfrUApmPkdEb3OgiJ+9jfm3tXxxtD3y2h4TtUdJ/F?=
 =?us-ascii?Q?N5GYx/aWG19UYSXqndWg7gH9y0GGDXvvJLlf/odjc314ATHeUwehf0tHChp+?=
 =?us-ascii?Q?2ikcvKe6nTE8b934dfWC+4/8dYlJ57sEV4THVIltcCFSszD81bd2eqwHR4Xj?=
 =?us-ascii?Q?HEUFIhsyUYXN9S/Fzgnpn4f8Cji7ezO1PWyYRn6OwOhGBq74BQTKKQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JbiyXA7gxzycps1f8Evqx4PIlQ55mIPAMTVzvSP/4sYR1AMNfheUo8m9tC2o?=
 =?us-ascii?Q?T9bU2KKimDrcLbkl9VoHvjVka/aMAA1QjYDmgRtmShBm+OSaWu+ry47tuLiE?=
 =?us-ascii?Q?lBiessetCPGYzF5v10yXvL32dtI5twrUCSTAVRp9XCs7u351GjxBUZtsQQ2v?=
 =?us-ascii?Q?hjqezbhN7LbVOumhRPPfPlybBE7+uQ7uzaPUvRbIxLd2DQpNUCW1RaHPFzrV?=
 =?us-ascii?Q?MpBh21bNeo3oMx3DeTnzEbc04X05OIURnScRqdAk8aTJf6O3bZbU43k7XIen?=
 =?us-ascii?Q?f4o2d7pEb5wRLVep3ebhtQHQb4iJdlA0Qe2elghwXQW3rq3IN7ATiFVwRmkx?=
 =?us-ascii?Q?2vquFL2CvaG+aBqmxrYhQcYRcAMs7XaW+PFsfoepAJ+CdOBtpbw0NAXjwfIv?=
 =?us-ascii?Q?gdBit3Ott4KDLpA07Y5szKKcXhVFgEYXkaiQS7tbFm6vGeCJNyRQBgxQXfIl?=
 =?us-ascii?Q?iQCqiRgQfBab/o6aN16WCE8ORQWE7Urm3LXVqwMmKjngbUlDCuV0txKLsC+b?=
 =?us-ascii?Q?oHaRJvVVQb86MP1isNcUC3iReBMVBlRaQScvy5nNyGikvpZ3tVgV9qQCv9bc?=
 =?us-ascii?Q?uE8V+TYv3FmQ848+CxYr+fnaWAJJ1aSsaG6LZrbIXcNEZXpHf2ehNtI6KuhF?=
 =?us-ascii?Q?MX4nJ/7PlthvZtH7PaYFaoiz3kGjZPJEzlqCV97y84yka1j8nheXZvuCu2ht?=
 =?us-ascii?Q?+bFVnNNNdzf7Wy2sQNPQVcharg8RhEbNKoNTOI9A0Riy+tfb77TNzeK8pVN3?=
 =?us-ascii?Q?afU7abE9iG5eVyQfZyn3RVuul2YIWhXXp/Wr6nAdlVXG4xs6kRCr0nXCjKfP?=
 =?us-ascii?Q?bueQ9wr+N8aZpJGX7OVOWnXH3pJmGZXo1IG7ZQq+RYSy4UomOb1QrRnM7gj5?=
 =?us-ascii?Q?XNjDi6P0GTBbtU5cTcIHDkWAMmnp1+IyF9NGjclC6jrpkMlSrMimh3+Y7F17?=
 =?us-ascii?Q?irGubvZtLQw5exdBWQKIZAqyZIvtM+wXfQEkWpdC1Tce2gaaRNcXtdG+SyXZ?=
 =?us-ascii?Q?YGxXRjleq/G8mOvPiTrzdkK3ajKb5ennTREvYHg8wmjoOz8hcx60cBtYLAaZ?=
 =?us-ascii?Q?3V0ZFmp7vQ8N+a3WG7vyiqQw0d3nECEPXlqd5R0FRxU1SDEzI6zDywRPEilT?=
 =?us-ascii?Q?ocNse9j+d3l2Y+pqITtE4gNOE4GrkDXW244EM9sdvPgyfxw37CZSdjML+OF2?=
 =?us-ascii?Q?XukQJPnmv5VfvEcktmlDh8M7Wt3HjLz0Hx/2J+amdjQqSS1J288PJ81oz7mP?=
 =?us-ascii?Q?BdkLMoKkjownK/WXI/sJ9GzXlmHHeREB8dziJ75XC9DEQ+AVg+q5I5sVAffo?=
 =?us-ascii?Q?/bnf8fchNHzt2o9skUuhK26Uxndwsq4IfPNPE5xlpLsAvvQOTjtLekM2yuQv?=
 =?us-ascii?Q?HOri0TS3/MKtSU4Y4KW/+s3L+4DeAbMDNYLcyhKRIQaI1n7yGGYyljr3cXuG?=
 =?us-ascii?Q?3/lmNiu27L5Ni+8z2PeNOadcBdvFtz0mWPR4CUkgZ771jkrbuVLWBEkyZvO+?=
 =?us-ascii?Q?xkhWn+q3ZGDki9rqUdQmQkku8csJvQl1jXs1Is155ERocOOmMdut+GDcyZ9H?=
 =?us-ascii?Q?3LXGh+USuCyB1EsVLx4Z6avUaXvge4UCe2GwPejB?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: microchip.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM3PR11MB8736.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e0f6bcd-9fd1-4efb-4ee0-08ddd54cd15f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Aug 2025 00:53:26.3365
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: XfHHM/bI1HBBjFFipfkGm7BcZ7f3s2iCdNfYFafIH05JmQz9rWShmlHrD07rwLJuQbjLxSfcmXbF9/VcRI8z54D3U9k/PwkBJqzXUVsDe7w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR11MB4604

> On Fri, Aug 01, 2025 at 05:22:53PM -0700, Tristram.Ha@microchip.com wrote=
:
> > From: Tristram Ha <tristram.ha@microchip.com>
> >
> > ksz8873_valid_regs[] was added for register access for KSZ8863/KSZ8873
> > switches, but the reset register is not in the list so
> > ksz8_reset_switch() does not take any effect.
> >
> > ksz_cfg() is updated to display an error so that there will be a future
> > check for adding new register access code.
> >
> > A side effect of not resetting the switch is the static MAC table is no=
t
> > cleared.  Further additions to the table will show write error as there
> > are only 8 entries in the table.
>=20
> Thank you for fixing it!
>=20
> > Fixes: d0dec3333040 ("net: dsa: microchip: Add register access control =
for KSZ8873
> chip")
> > Signed-off-by: Tristram Ha <tristram.ha@microchip.com>
> > ---
> >  drivers/net/dsa/microchip/ksz8.c       | 7 ++++++-
> >  drivers/net/dsa/microchip/ksz_common.c | 1 +
> >  2 files changed, 7 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/net/dsa/microchip/ksz8.c b/drivers/net/dsa/microch=
ip/ksz8.c
> > index 76e490070e9c..6d282a8e3684 100644
> > --- a/drivers/net/dsa/microchip/ksz8.c
> > +++ b/drivers/net/dsa/microchip/ksz8.c
> > @@ -36,7 +36,12 @@
> >
> >  static void ksz_cfg(struct ksz_device *dev, u32 addr, u8 bits, bool se=
t)
> >  {
> > -     regmap_update_bits(ksz_regmap_8(dev), addr, bits, set ? bits : 0)=
;
> > +     int ret;
> > +
> > +     ret =3D regmap_update_bits(ksz_regmap_8(dev), addr, bits, set ? b=
its : 0);
> > +     if (ret)
> > +             dev_err(dev->dev, "can't update reg 0x%x: %pe\n", addr,
> > +                     ERR_PTR(ret));
>=20
> Better using ksz_rmw8() instead. It is already providing error message.
>=20
> In this file there is 4 direct accesses to regmap_update_bits() without
> error handling. It would be great if you have chance to replace it with
> ksz_rmw8() too.

Will do.

> >  }
> >
> >  static void ksz_port_cfg(struct ksz_device *dev, int port, int offset,=
 u8 bits,
> > diff --git a/drivers/net/dsa/microchip/ksz_common.c
> b/drivers/net/dsa/microchip/ksz_common.c
> > index 7292bfe2f7ca..4cb14288ff0f 100644
> > --- a/drivers/net/dsa/microchip/ksz_common.c
> > +++ b/drivers/net/dsa/microchip/ksz_common.c
> > @@ -1447,6 +1447,7 @@ static const struct regmap_range ksz8873_valid_re=
gs[] =3D
> {
> >       regmap_reg_range(0x3f, 0x3f),
> >
> >       /* advanced control registers */
> > +     regmap_reg_range(0x43, 0x43),
>=20
> This register is no documented in the public documentation. Out of
> curiosity, are there some where more information about this two
> "reserved" register ranges: 0x3A-0x3E and 0x40-0x5F?

The current KSZ8863 and KSZ8873 datasheets available from Microchip
website do define this 0x43 register as it is a basic operation to reset
the chip.  One thing is the register bits are automatically cleared so it
does not require a second write.

Registers 0x1A-1E and 0x2A-2E are used for LinkMD feature of the PHY and
other PHY related status, so they do not apply for port 3 with 0x3A-3E.

Registers 0x40-0x5F are not used as they are not in the datasheet.



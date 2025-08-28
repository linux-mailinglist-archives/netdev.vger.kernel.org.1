Return-Path: <netdev+bounces-217578-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 743EBB3916E
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 04:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31733682BE3
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 02:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF95F23D7DD;
	Thu, 28 Aug 2025 02:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Uu86MucY"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013047.outbound.protection.outlook.com [52.101.72.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14A51C84A0;
	Thu, 28 Aug 2025 02:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.72.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756346648; cv=fail; b=LgjdDcae801XRceZlu7xOzL6VG2WCV2t1UTnaxJ3fJwA1Fzh/f+JaVHvKxtb3A03qSzzpAoeOTvjmsS9PQaePGtNe3uYUQ+x0DqUgz6wy5wlZOQPYBPmIvsTsIRNc9WXPloFLpLmozW7cuK2JWxj2NZlSlOOEMLP5qRWHtWT/80=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756346648; c=relaxed/simple;
	bh=HRlz3fygj0ZRHmTdbnb8fEw03GBUvMjdbym+Aq7Y7us=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uKqlE7AqAo3nyYo6/uOeJSmYr0cOBE7BTywBoStyE5jfJOC6Tvb5eajYd6exx4Pl76/AYh5PlJ9R3r54cYNYPF3WEj8LMi8qMVxe7J5241pXrnP6JvEFcWlkY4a8B7rEGBsHn9vhJmkxg4iuTTSEfGgtBLrpm1YU7mA4PUWWMZk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Uu86MucY; arc=fail smtp.client-ip=52.101.72.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CdBncw9eWO+5omkK7Nw+rK0lKDh94Gto0IVxol4FUI7GHviMyPo/mpqGtpESBCHEwD5dBOjUxBZ+fMNqk/PKLh3pPDoN4vRJQhQK0vp9XLByavlYCrBBxpK0OrimmoB46yc5EaUYMrL9to2dDqM2zyRb8QY3G2pkZGf5b/D1cDBnquQ8F1s0fBIfI9DHZ6+pUGH43iPHzX1npQXEO9VKGQH247GTZWrBADnVbi87OwxY73rdcgr9BSdbcv+igT3SWkPsi3jix1YHAtUzkARaRgQqztgY2qZ7Pbp3YS5qKP08fcVw61d8ec8tnljmcFTubAgfO2p3W9lMzArblyw/vA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HRlz3fygj0ZRHmTdbnb8fEw03GBUvMjdbym+Aq7Y7us=;
 b=yvx8a4wI5uRbrGzfXbUxMQLSOXwd4R3/r974MndW9lENShCMYPOBueiR5YEiOklvVX/snDvlNBaQ+ZH6Cyj5migcyk1uLDeGfS+tQQlLNK/UE5/0yRIDAoIVje4SP5JESVyfTz5N3tyyJmqYZ7LhY7h4wJKGdLC2kO0YRR7uUIbZBwyYmFXpc9CgJUnFhJxAizAKGy2DBBI4zmsRQ74LeHN2maTpzRWmG0hTs/8q2w7JfMe9E6rv8tOKn0vWGrOxotjljY4iJUrQMeI5JSpewWB4JX9kFPZ006e2jOw96il23hm3WayHPvS9XfkHRGP1k+QR/vEPCN6Cv5sPuHL/hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HRlz3fygj0ZRHmTdbnb8fEw03GBUvMjdbym+Aq7Y7us=;
 b=Uu86MucYfWv/PILvlCQKm0V1b1dGpvvuhOQ/UPIgUtWyYsv0Q1++BOMk+gazkPnBXaBnQjUevISJP+nR+mfivW9OVO2V/cvJUelhyyHCRT8s/7dYlQgFrZC28ZOGFd1FybJ4em+JF+hJU9kw1ytV+l25vN8b20l0TzusFhPBq5xi8q+2HONpX7TeJOTM+yM/5OXDUb10l0/mc4za6P+5KCpHda6VlvQhyFliDECRA171MSN3zh6Ru5hUWACQKCvcC2bXI1vzCONLefzOLygFGHx1cRr1QabMuMUIaknvzP5yZNfICq4zZK34gkcg9KKRH0gllNc9M8G+31/CfaOcgg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB9848.eurprd04.prod.outlook.com (2603:10a6:10:4dd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Thu, 28 Aug
 2025 02:04:02 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.9073.010; Thu, 28 Aug 2025
 02:04:02 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Frank Li <frank.li@nxp.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, Claudiu Manoil
	<claudiu.manoil@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"vadim.fedorenko@linux.dev" <vadim.fedorenko@linux.dev>,
	"shawnguo@kernel.org" <shawnguo@kernel.org>, "F.S. Peng"
	<fushi.peng@nxp.com>, "devicetree@vger.kernel.org"
	<devicetree@vger.kernel.org>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v6 net-next 04/17] ptp: add debugfs interfaces to loop
 back the periodic output signal
Thread-Topic: [PATCH v6 net-next 04/17] ptp: add debugfs interfaces to loop
 back the periodic output signal
Thread-Index: AQHcFx+Knn/pg3+vN02ZJpsUqQe/U7R2m5YAgACz/rA=
Date: Thu, 28 Aug 2025 02:04:02 +0000
Message-ID:
 <PAXPR04MB8510D6DE4F62F90EDE0C56AE883BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250827063332.1217664-1-wei.fang@nxp.com>
 <20250827063332.1217664-5-wei.fang@nxp.com>
 <aK8gODZD15OP//V7@lizhi-Precision-Tower-5810>
In-Reply-To: <aK8gODZD15OP//V7@lizhi-Precision-Tower-5810>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DUZPR04MB9848:EE_
x-ms-office365-filtering-correlation-id: ece8f8d6-a672-487b-3669-08dde5d728f5
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|376014|366016|7416014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?hE1b2ZZtl10FqWROCZJuCt7tkCyy0f0qt0ImJ9IMzsRCTKC+kbQvHlK5ClUV?=
 =?us-ascii?Q?ZyEysIn+2+y/p7buJar7JqhmdQ+ahnb1uBmz04PvfRjAFlQtHkOsojINPmBZ?=
 =?us-ascii?Q?1kmDWDo6Bub+LX3dj5AVUZRkmufl1GViBC/+cDNItGPYFU5Su2d9/m3ytmjR?=
 =?us-ascii?Q?Yvcvmlj/46jOOy3JaDua0INBeIFe07yoHZ68dytqpXL5dXpB9/XdGazlT5rG?=
 =?us-ascii?Q?ddkax3WcjxLDLTSYVO1yX7X2A6gfzUkKm/qgZC2i1gm392yf8ouKOOM/PDW1?=
 =?us-ascii?Q?KOsB3afINYxrrl7f7VdNJ7SaGeHOkVK/b7L2jgR0ywoQYB0SzwD9Kb3TKY5r?=
 =?us-ascii?Q?zc3sLBc9cuf+yM33AAAjjQSBaUBzDcQ7EGPLP2lzvKuAXkitcQe0whAE7UmN?=
 =?us-ascii?Q?TnAv4GoqDKP3dA2GX+PCScRXv7Ta4HxDdVi6wYXtQFgocQOvFja5vTRR0iW8?=
 =?us-ascii?Q?Cj2q5h+D+hfNWckoJFqP3Ur/Pe23htH/vCzvYik7WtBpAzH0/2EEe6brf7sw?=
 =?us-ascii?Q?zwitn51hpT/gTje1WH0qmg5IsMAGgXlirfR0jbjICVIzQeGXQ1QKdtntddzv?=
 =?us-ascii?Q?k/D0iN+qnoinQs7XQGrHNijJ1fWFksRU1PyAba8Vqr1hDqLie/XlHHl8HhbM?=
 =?us-ascii?Q?lPICqm3dWnmCClVRDAYSAXxA4n9eFo+qZR1IrkZB9OsEOEvGESxaJCnmL3nl?=
 =?us-ascii?Q?Pd1pOLMnPJdkIx2qq8PxN4jzWcLWc4/GygXkJAi1AACta6yZWMXKCmx8muEn?=
 =?us-ascii?Q?bEP9xFrC3S9qnOencKBmj5cCFsOmg/Ea5F8tyH/MesrDTlbWHq/VDkrkbUo7?=
 =?us-ascii?Q?lKkgWX067BiVxSd3l96ycWChaa9/KcaDl5b9KD0N3PPoS+xyRegu4UpvyDrJ?=
 =?us-ascii?Q?tDAoGf7L3C1iiWy3vkdu95lpcVB/59V2vZDj+yj+uWNGwCeoOjt8vx5J7lGu?=
 =?us-ascii?Q?dNkTPqucQ209QIqVrcl6PfI/hAyl69F+POv04O0j7Vf1q84pKpQflh8qgG32?=
 =?us-ascii?Q?vuSREbg5EF+CAMRO+8/G7aBnKuHUnCeGcn69sXq156pPKoXnavZG62QNIX39?=
 =?us-ascii?Q?XK413Rdx3JFRDJc9Cqm56GA4K1MpEHT9VAKVpX+iKnwKO8IVEsz2dPFvCSqg?=
 =?us-ascii?Q?eBqAuB9P5CmbprfrAfZ4cnqRfHslPy/IY9nHr3gcd2ZGjsB4lhO86YfcQS+7?=
 =?us-ascii?Q?nPvfOXslPVoVdWWlhAT0zB/tMo8w3bhOMOYHwnwkBLlFnXJHpw2c1iq7YaBp?=
 =?us-ascii?Q?j/otI62c8B8KG0AIRagRymyskiMf6L9drv4zRqPpoymXgUKW+ht0QfHemiaR?=
 =?us-ascii?Q?7MF2saC7J165gaN/ISenvvPdNz0uFqfRrZ76tmKCADvJYV3UYuyEkAE8KGbc?=
 =?us-ascii?Q?CFPlQJydgJsUfiCL3ow78nnpX3H5mE2v2n6MV9JSl9dNxI1uJ8BR5fMY3K+a?=
 =?us-ascii?Q?lDrz6+18ZiQD3CdKtg+rQVJagZ4Zd+OipFrA4RLYDddHjNOpIAsSyQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016)(7416014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?iHi8YuF1jVlSSOu71t1IvF8vWcZQBxQEJ2zTgLdR3L1zCyHJHc78JBm2Z6kG?=
 =?us-ascii?Q?tLcMZz5BSU/EUeySPkZULTiVIv/cC4nvlpeVn9i9aAaSAmHBM70IczWT+NAM?=
 =?us-ascii?Q?Zd3UkntjiotF12QkmzvXFZUZYsLebZWxRGW/9xaSdfEghLlTuofD1Er1XuzY?=
 =?us-ascii?Q?ULA0T0In1fAAZcPzruRJYI5Tk7lQMtr1eYUtDGaUHRlI8PPC0DbWacETqB0P?=
 =?us-ascii?Q?7nU/nZUHkmmOQqUh5CTFlyJ1G0Je9Tsru7YUa2jpdvGiM/xywIg0C4tjBlve?=
 =?us-ascii?Q?Dc0ghKZQNY2iGjTjVocniZ+FQjybtVRUR3UvAz+158dJooYfYZoLMGizQrX+?=
 =?us-ascii?Q?wR4B5Lln0Ene4LVok6nWyuv2euN2WjrsJgsDk6WpbWFLOf6UvAuPw0Ev6E5v?=
 =?us-ascii?Q?nue1vKPxKaRa2F9v3ql0V31FYZ/45zpmRSaa3gIdhx068fJYJAOa0zCnQ47D?=
 =?us-ascii?Q?jzen0x+aKoLoCwdyOXYUoLvwjY8kHX41gCwmr5qT/Mcnc0leBi6RlEhBfxHd?=
 =?us-ascii?Q?d+1eUbO9JLB5cNrRcBzrkfbrWNAoQ8uIxS8HifdaHNTRZwOi2073Vmql/0lN?=
 =?us-ascii?Q?gXO+R7c6Uej3rpb5mhzjCslWzl65IZ5FEjmMvbcZ19IGEI21TKMS+MAu1mY0?=
 =?us-ascii?Q?JQX+HCdsbEL15da+uVcq6firfgFYo2juVWu4XcCMqaqeq8ao1rKrgov8s5XS?=
 =?us-ascii?Q?RODhVs2yU4lHLUJ5xWQms/dWA3FMCK0G6ftfharE2xSYm1enBSsyFUoon/sL?=
 =?us-ascii?Q?OdC+OgXUvH3KCif+mmGSjRfy5pLSIsxZPrm7Yx2+lFX740GmwdyTmAucqKr1?=
 =?us-ascii?Q?7PKiy0nki/lkpMvgtQp5cAilaWODReN8deSuNNa+qLDiVg2Qyr5ms9tBypq3?=
 =?us-ascii?Q?RbIg/o8D1h/nNTIt1TME+TGEjmCMeGcVK6c4QWfr2d5kHyErTM5RJOBCOI7X?=
 =?us-ascii?Q?ecApwpfbAHlbzK8cnKUWhG8k176hX1z7JU1M3IQw6kgEvdUgpqZnbQiwyn9Z?=
 =?us-ascii?Q?XQLb6twHMJjT/j0reX31zS7QQx4pioYPcGbf5wQlK7cqHk1t2zhpzEQ3LuHh?=
 =?us-ascii?Q?S+6kiBRw0afKZzFgfTtLP4KRKbpxnWG6i1V0hsnjvcpV8Bq+GYm01thCMxBH?=
 =?us-ascii?Q?JwcIzcfi22NazK+jEscpd4jLJdVZhF0jCL2BpBgjoJ85/ekLsTRiIfaxxNrZ?=
 =?us-ascii?Q?oPH0VCxVhet5AOUGpr0X96yYuUSYOr1/Dr/KaCzt5s8I5bAiG2U0C5SQXsBO?=
 =?us-ascii?Q?v/etZkRcc84d6UKSiAI6UbVW1rDmlB+fLtCJS6Sl+YmX5hMmsywS0+3v6d7U?=
 =?us-ascii?Q?DbESE4uSzA8453ZbMPrOLiqIBakfu0Aul42oHoNRvYUOwVMBojxHkxbzQll/?=
 =?us-ascii?Q?VceKTlN5V0pEHssQ5W5GwkDXcQ5kxWbpPj4lZ6B+pTim0KOTo7qX3u3O7qi6?=
 =?us-ascii?Q?SlgDWhPWVgW8gReL0csBx7+n9qNT81NHEneLJyOhTtgQdzY5I2vMpiRYFoOs?=
 =?us-ascii?Q?D1Hj71UoigQGnmc8d/UtnTbwEmQvIpJxTEkEuVAe1Ia4lTTmBTDJ/NBguHlf?=
 =?us-ascii?Q?4A9rYR8PcGjHtDNFjs8=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: ece8f8d6-a672-487b-3669-08dde5d728f5
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2025 02:04:02.3766
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KufrTGVDQyUfQRaMMDFvUGc87QIFFtEMZNd9dtSe3ZZ7ecP8gNQ+stkZj8yW2YZpXwib30oH//WINXZA6fgqZg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9848

> On Wed, Aug 27, 2025 at 02:33:19PM +0800, Wei Fang wrote:
> > For some PTP devices, they have the capability to loop back the
> > periodic output signal for debugging, such as the ptp_qoriq device. So
> > add the generic interfaces to set the periodic output signal loopback,
> > rather than each vendor having a different implementation.
> >
> > Show how many channels support the periodic output signal loopback:
> > $ cat /sys/kernel/debug/ptp<N>/n_perout_loopback
> >
> > Enable the loopback of the periodic output signal of channel X:
> > $ echo <X> 1 > /sys/kernel/debug/ptp<N>/perout_loopback
>=20
> Genernally sys interface only 1 input for each entry.
>=20
> I suggest create one file for each channel.
>=20
> /sys/kernel/debug/ptp<N>/perout<m>_loopback_enable
>=20
> echo 1 > /sys/kernel/debug/ptp<N>/perout<m>_loopback_enable
>=20

There is actually only one parameter, which is a string and is parsed by
the driver. This practice is actually quite common. see:

ixgbe_debugfs.c : ixgbe_dbg_reg_ops_write()
debugfs_sta.c: ath11k_dbg_sta_write_delba()
wil6210/debugfs.c: wil_write_back()
ath10k/debug.c: ath10k_write_htt_max_amsdu_ampdu()



Return-Path: <netdev+bounces-200905-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 36608AE74BD
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 04:23:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96C975A2EDB
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 02:22:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D813A1ADFE4;
	Wed, 25 Jun 2025 02:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="m9O1uIQJ"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011029.outbound.protection.outlook.com [52.101.65.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038E51A5BA0;
	Wed, 25 Jun 2025 02:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.29
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750818181; cv=fail; b=l9f1+tfREaibgp8kQ3ERf4RMU5+2z0d19H4NL4c7pn+jy1xgVpEHq3sWcIXBUE9HIwtVtystm7M9O/1H2ZH87gOpZXR6ijKGe7R1cQxGz5xdsxiVs9vPoi8a5z1xyU4E8D7v3r8DREcAQtxS67/mmqoB3BtsI3AJ6F5r4SqJZuE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750818181; c=relaxed/simple;
	bh=0LdYSFmLeDlduVhiw7pLB1+S44zUz5Hkn1ct0gcer8A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t9NItY/euTfTeXj4okX+c7UBh8TS2JOwRRpKTBbNaXBv+i1F0ifdCmU1A4MIYTbhZ4dS1FEIae9dcugvE855h5nWpz+doyOetLI9/m6aJS2/ggw/pcFROAHyFrAlSlD9kSzNIB58G5OJ6rxKioNZkxG664wJ2Jd+dNd4psFZ+5o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=m9O1uIQJ; arc=fail smtp.client-ip=52.101.65.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zxm8ogAW72TcuXtmnYlMxiq3adgDt9bTxiasIyiXMzdcVaXaQQtCR0KDOhNu+d6f/bOG7Q6vJjs0U+dcNgHnaZSqQY7p1vCsh1KO/r/NKG3yfaniK1WkdRQ/VdQYaMmfvm76RPfL9MrXsvLHX3wjBW19TabAkHrdSGzdxGtyB8K5iYU5hVKx6dEfJ5N98scJIPUCFSxbe4lK7KkKe8n5H/ItyO8EYc0Z+ZOmpyYvDJfVXaCEfOefO7J4mqFwVTsvcPLJ1DHyuC/j/b1FWT4dfhvX32tS1da7IETHKe75baYG7SdJQ0xq8xY3siBHl22FbY1P4Vx+424bBsZ+W/YubA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0LdYSFmLeDlduVhiw7pLB1+S44zUz5Hkn1ct0gcer8A=;
 b=wmX0ObRUUE7YlDmnw3te43sODLyXeeWhwccbBbvED83I5r63ETCt0OuPK3YFj+8377W1V+IW2fS8Yd/2KJ41nViUhBLVCKK5sb8h95LQHUfm90WJQy8XpjR0/VE0plKt1MHiGBwNKgRt5HKoV9ybv+OrWHcbM7IJvGOq/nVFpSYX7F9HSD29HN9kIDcpCLs8iA/Wx28eIaWaOIB5pqPAcUe59jz4FkUoO80945GatKF1TtIvR0WnADP8F2CofQ8+DXlwiEi8k2JklE6chfI2khoyyX7tSxNpgvkEtp1wLPbHixCpAL5qvUFzqf2ClU1fbuc4safV0wd+iZ+JWm3SLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0LdYSFmLeDlduVhiw7pLB1+S44zUz5Hkn1ct0gcer8A=;
 b=m9O1uIQJ+VzcX6etSBLqSk46Aw6oRKVaosy3PmZncxSrspf75Tv2ZVnp9GLwQm4t2B6GkwN2ZUGJPu0s7dJDy2vs4i7OCBuv0IwppMz+Xst5rbB9ToBqbGTktRzZJu8lbEYo71tiNxcsklWazH709L89A5OD25Yx7bBUZKJpnxPcxZtuWFyCI900sYGKGH3adOaal9NunQ4G6bAART1H+s49jzG1BpUcGBtgI33vTLT6Rl+iH+fEMb+e6HSurFeLPoHmOwmC7WehbJdmBFfNGzOdzpp01N1TI9nQj5Uf0F/Eu7M7X1FRuCKv0ZjPTKOSPtdOIXM3nsC8ce71DF9Q1w==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB11000.eurprd04.prod.outlook.com (2603:10a6:800:268::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.27; Wed, 25 Jun
 2025 02:22:54 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 02:22:54 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Jakub Kicinski <kuba@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "horms@kernel.org"
	<horms@kernel.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH v2 net-next 0/3] change some statistics to 64-bit
Thread-Topic: [PATCH v2 net-next 0/3] change some statistics to 64-bit
Thread-Index: AQHb5PCefeDeoGBcAU2O+0gg3q53zrQTEliAgAARsWA=
Date: Wed, 25 Jun 2025 02:22:54 +0000
Message-ID:
 <PAXPR04MB8510EDB597AD25F666C450ED887BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250624101548.2669522-1-wei.fang@nxp.com>
 <20250624181143.6206a518@kernel.org>
In-Reply-To: <20250624181143.6206a518@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB11000:EE_
x-ms-office365-filtering-correlation-id: 4123ddbc-edc3-4971-1334-08ddb38f3122
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|1800799024|366016|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?Y6ZseB2vi+ZQk8MnlndCn5Qpr77ocj6rukhBuFNHw0giFiO/zb26c0CgMkie?=
 =?us-ascii?Q?CTpw/99GMeesp/cqdgKpxXMoVSbimpp+zcs7HC+a9TbnfLOhvHXq6xHiELmX?=
 =?us-ascii?Q?nbaVLCBl2M5KWGu9+8P7uxR2xfHIRLMv/vkaYC/upze2FHVP7wA4DvP2Wxcq?=
 =?us-ascii?Q?yt+XHPiFk6p/dpUg9MirFYxqMsFBkrh6+4oke1Zzh6kM6FYSTeBrw+1AO+pG?=
 =?us-ascii?Q?vHHHRgqGKmolGsDYTs08d419FHMwMrBGCLPyNlVDheU6E4LpyNVrqGg76HWD?=
 =?us-ascii?Q?nPX2EbFBOBm3+KyUOL9WeKRR94zT1AIU/zIJj4oXlybcWXeYlaMoQoYXFCOQ?=
 =?us-ascii?Q?t5+2eWXcPt+EoQwUetKqdjGKxqO+urVm/eCK0UMVtIS/FpgbKYX/S5a3ateA?=
 =?us-ascii?Q?lFNU9rRSrr5Hgn4Av/5tJk0jIuPIM8KfTSJAiFoFhLolkwH/WGR8U5zD9fHx?=
 =?us-ascii?Q?yHfJUCsWsOU1q6ZN/+8+msLBoSDZ0tsu505OW9L5WtsEnlJgy0rp09dTddwq?=
 =?us-ascii?Q?/IfExbCEt6sl2VFaujWJBEeFHXzV2Es99h8wfP9jonjEH7+TNg6t9SVsmGQO?=
 =?us-ascii?Q?9HCgHC4CYWVc0krnLe/Xq1V+ZRnaTQAMg1KzQwb+vkpXulC+SypmC3HQTi/a?=
 =?us-ascii?Q?is36CuAKipgksWzewkiTL7LOF6ZRC5r/ia2jr7IZt3rKq+Xh6fxBNbUtsb+I?=
 =?us-ascii?Q?/EAgaG18h+Xp5GkFW88u7ndeyCedBwWvu4MxSTovy1XGo4SixfuhJyQI60jr?=
 =?us-ascii?Q?N7eG05D7zBt9zmKeaNbFKGrl5NvGIBwcIa9bf2w+IkEFEqajEZ8xmX6eL1KY?=
 =?us-ascii?Q?9prq3404VxZgyyueUtZqPhrHQsr01Chb456WmFW5ebZUkX74cWqLsQ9k6zCb?=
 =?us-ascii?Q?otxNLDQVm13lHWZ8QcmRk0oW7VYNA1Xfe6jvwJnmaKvpfD5yUIMY8Rh4gEPV?=
 =?us-ascii?Q?A5YLWI2J5KwoxeVA9s3OqNzUXhEWmda2o5Pq1PNYFZYB6fStCVraze5Lyiz8?=
 =?us-ascii?Q?PlUIFpXA4nyDpQc/sfjmZ8JiTcK9i9SSRv98OPMm6FNl6hmT7yhZOf18mjPt?=
 =?us-ascii?Q?Hll9YpcBMq/sSTJ6G7SpczhYv5zWtbPaDTvyo5vBE1jOc04J7qvvIDFLFwZM?=
 =?us-ascii?Q?VuNauxaOV5MZlcJaMnVtOcUmeQRNTRY6iacJOuk5cF2JfGc+UbFGTsdnZyna?=
 =?us-ascii?Q?QBG6PawvdHRj9NFi1Qm2VMaaPF08zqTnEPZQX1SEVPy+JvikLhzWL1Oj5wMj?=
 =?us-ascii?Q?mTlgGkQtffXz3YyWM1ZP90l94cqJqkHX+T1j1I3GDBWzjl1Hbj7ZgZStEBoD?=
 =?us-ascii?Q?QjR38+m63OT+Nj1XssHTK6lbRQKMRiYdfsKha9mZE+uraS99ynXmSdyRtoMC?=
 =?us-ascii?Q?JreZjHohuOZLuKDinH8OLpV/8gGJ/RRlw0W8vl+CjUkz002BE/z9soiqwfLE?=
 =?us-ascii?Q?G0FU5VC1fqaDoZOdf1JzW9X1NpV2OldQkAhjX2c4FWigCWsC26bQMX+F1BgP?=
 =?us-ascii?Q?LHwpBmZqc7ReiWQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?cwojwwJ0uqLw9dHo0mgI98SB4l0LXEVaUVoNvFPy0rMFbZJ3yRO4H2fF2nvU?=
 =?us-ascii?Q?hDRmQ4xzTZtQ+Dt2c2ho+JDlW8u2Q4SHvhGlq4g/daUZ7F9b46JfLipbt3UN?=
 =?us-ascii?Q?BE0etnYiAyrAXcVfzOM9GCRbO3GQbntDMqnooKYMXevcvcSg1u95l7NO26Po?=
 =?us-ascii?Q?vdv2dEZw0ScP7934WGxlzulQvcq1JfOD/u78N32UkiWVTGDzRcN4Qte+Nx1o?=
 =?us-ascii?Q?DSEEI/FudDFaqjFmLQaze1aHfFz8q8qLnNxwgz0tEh5D697NJlaa8T/juf9y?=
 =?us-ascii?Q?6MkkYeNsgGkKbJkQ8ms9PlRKDzTt4tGJHokYre9UDCMPzC1HxFEhclcjbeTR?=
 =?us-ascii?Q?o9XDg6j8vpfj9T+GOtgSlxM4G/QPwC8L6XMNNxU40nWHXxW/OuCXF1Jg2Bq1?=
 =?us-ascii?Q?DOiPsdSmGFhqXDDqZw/T1v+y7DYk3KwgKdKHry/3LiCYbvWrZOvjB+AYwK2g?=
 =?us-ascii?Q?D74wqbP0ZMbst1DmOb92sc0CCTBTiry5IVrHU77trXqbkQQ7aVLka/ifaZjY?=
 =?us-ascii?Q?gfOpy1rdKivNj0Pz1ubLULvqGwlLb9GbHLEkoAIcq0JXC5FKfZHYAlzwStzV?=
 =?us-ascii?Q?N2iXzQBJTjpufvljdUgMQ3aUumUikh5BUFe9UOUF5Mpd4AyLzU/XGywyMKvD?=
 =?us-ascii?Q?342JOs8+oWw0TBhlseKoVk5ZWj7kif1Xt9GkZOZbrlfLJYDtytWzW/jdITkN?=
 =?us-ascii?Q?GqlVVlNhA9Bjl82cwUJ8UAMUEpLxy9aLYpfIUCVC1g49kJtrGsX7Q1DvZm9o?=
 =?us-ascii?Q?s3DRb7DCBv9+9tOMMYXUhb5Rgrwz6OLkPxyK8rm7nUKrk0SvqEZRmEpYzYaa?=
 =?us-ascii?Q?q64zQRmnfBAWBQrW/OJrv6Zd09svgkilP8bBfbd5N640O5fSUzUTAaySsUx+?=
 =?us-ascii?Q?JJTtqzhe8StghPqpOJUB8b3hUqaMxOjKBjGBbrMjW5AIMIRZGeoM7i9gIZDy?=
 =?us-ascii?Q?N3j3BB/5e7A1vrh0Y4Dpl/XfrfKfyt1OCZRHge4QQ9IrfckpwbcCiy1Avp3t?=
 =?us-ascii?Q?DOVPgouiuSBuNX6CuUND6llSmhLIUhFyJ6bdUzEetkaJLIjrjTMBVpZVYuNF?=
 =?us-ascii?Q?tn/YV+0Kf64iWe3z2IC+9Uaebj6Qh/NqWgGVvwmE8lg+lc8YLs4ZfeGaYCYW?=
 =?us-ascii?Q?hvDIIGIA+7lmYBomKI9R0HzCGf2P8DFFJoHKFWIofjZNk2jbCNCHa/nEexEr?=
 =?us-ascii?Q?FhwjQbYx3nKFPSI1Vt9UXDO467xYmAwsZRA2w4FwO/gBPl7LviuUU34KCQ/w?=
 =?us-ascii?Q?b86FZiMUj+fEg76jzoZZZBOY90ItFG61ZEzHkCAxqcH0Eri+Q2UzHK39JXn3?=
 =?us-ascii?Q?85BMGNFsP6g3TYSqcoeJH+gGtAdPYAmlbMGqWCXyryx5+cOwuziyq5+rKH5p?=
 =?us-ascii?Q?FgO0vXKfBr7E1ZYLWIQrp0a8nzdV0FT12Q7xUAFWnZq/5Sp4f0LnsSY7+iWg?=
 =?us-ascii?Q?L9PcmPXsxAzdgLE35rkAEIIhlOgEvff2hbbn2zI7CIc+1n++rEPikaclsVA4?=
 =?us-ascii?Q?j0sZgxwrL3n5SCw9onMbjcGAK59GEqGuimgRclbSC9S1pX3mZf9bjhQ2K5s6?=
 =?us-ascii?Q?AcsM+3jb/BCmx2SbUwI=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 4123ddbc-edc3-4971-1334-08ddb38f3122
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 02:22:54.2258
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: W1H13EbkKuQT7LUdeds6LvCZzo1M+Cp2+bBoMclDI6SoAFwKz3tsSgTX7PqUlaSDER7e6BOso29fxg6Tqz9LWA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB11000

> On Tue, 24 Jun 2025 18:15:45 +0800 Wei Fang wrote:
> > The port MAC counters of ENETC are 64-bit registers and the statistics
> > of ethtool are also u64 type, so add enetc_port_rd64() helper function
> > to read 64-bit statistics from these registers, and also change the
> > statistics of ring to unsigned long type to be consistent with the
> > statistics type in struct net_device_stats.
>=20
> this series adds almost 100 sparse warnings please trying building it wit=
h C=3D1
> --
> pw-bot: cr

Hi Jakub,

Simon has posted a patch [1] to fix the sparse warnings. Do I need to wait =
until
Simon's patch is applied to the net-next tree and then resend this patch se=
t?

[1] https://lore.kernel.org/imx/20250624-etnetc-le-v1-1-a73a95d96e4e@kernel=
.org/


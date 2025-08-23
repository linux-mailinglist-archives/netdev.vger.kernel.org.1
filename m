Return-Path: <netdev+bounces-216248-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8F1B32BEC
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 22:10:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F09113B6617
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 20:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13A782EAB9D;
	Sat, 23 Aug 2025 20:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="MNdV6n+D"
X-Original-To: netdev@vger.kernel.org
Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012048.outbound.protection.outlook.com [52.101.66.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC1D2BD03;
	Sat, 23 Aug 2025 20:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755979802; cv=fail; b=dXKE1qQSe7UEgIRj9t6WCzLtNCwrzZn9CEmBymKycz2KNoHj6L/E8m9mB2EO44q4riu5l98RsLXfSX+vuXkHoAoPf7N6LDxM8IgNg7F8lc1Ry0r3IazljkWLLHDatZwva54m+vRwds2bFMCG2eRxN70mt0Hfl3IKPvPMT1NgXzE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755979802; c=relaxed/simple;
	bh=effmN2qasx1xSqsC4LHhPUfeKDqG+w3rStcPLaoS7kQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HyhvjfVpERTOZLK30UEKjMjJEVTfAdSrjtBQVEOzuF8FEy5o5C3GmrpU7jNIolE6o0HkJipiGgl7lsYrGH+8sh8fCWB0yVPoF263JnvXUOcKblcIxq+6OgFXPeRb+GsWJgshVubf+yL+FdNtFajxc/mW22Gq4GSpLw3/WTxcSEg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=MNdV6n+D; arc=fail smtp.client-ip=52.101.66.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DeLTmDCFKlcX+Y479YT45qAtk4FdAeI84ThqAxDuxJsf7GzUfS3lqjTWYjo4W72ZwihpYv9KZOL/yzsU+eo4eBcQz/gojtFagFqMn2zaCgluijFYxS8q2lbMcIVc1nnAF2tVruGdiZZnvPgHlN+ls1dG2j1J5QJR+O5YWCLncN+TrtqUeUbEOSStdqc6VGLHeRmtHGCBBDEou9sBxlQ3orH96L5XwYzJetauh5DXmN+jaxxCiso/DCxOaFcV4nYLU4SN1IjEJoPLvAagXCa6uC9vXu1jwmKM/69bRKMoWW7MEQ+16aEHoJowqwdNulSd2gVQ5KgNlGjaY9DqMg6eWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+yvjeAPci8k97mN8iy2lw6ZnsoyQiAY58WTxxiQyVGs=;
 b=mGpHpPoppdl8b5uXjjoKbkFi56nT+gb3NrUB8+DO0EQa3WHdRwa8MlLHoO16Sa1HCw0HtPCpqWLN9rNSip33s64GdxKkF1yuNHHnDY7WOhKb7aDAOPgZC9elZiSgtQs/Gpbq2Umd/QQ7zOnT6Beg5laquaA8yvPw6mWoiE2yhsu2TdXP72MTT+N64Vw0hZoTMB5NBHt4JYtRPhosvHhq0irV2enDbzmm0fWM7si0QT4ohMUx+5F94Z0RWCqgQ6THOeKEvZTnDh1e52AhkmB/MppMK7l5X8g3fvDfptAegQUl/HeePGUJdywdOjoHZUuikzl8Mc7OI85B8kiJlzsN/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+yvjeAPci8k97mN8iy2lw6ZnsoyQiAY58WTxxiQyVGs=;
 b=MNdV6n+De5XIgqgQQrLQkRaeZnZzSQtbsUfZuG/QHRC3QZ++7xdQ+TsOgzKQN9zKs0ht8Ax1Go3GCPwmHd8MZudtqVLN1ofCEzA2CpSAgtEwFzC+hPTylXdHW6JUS2ovhnJsogXw/RLFe0XFeoh+iO76tTGWpwM0euOYriX5CfD17LltLt8vcKNntD1QSXwfqsJkSj3+NXJu8uZb3VtNKejyFSA/ssMXNIJxLfamvEFxKMqPaJVy+W9V3xj/tMNJvVq5Syz00+LmxBann/Rp1ZtoHdWEiHPcget2rmFPfA54S9kSeAzzt1YJOVx4qOk7f6CfW0TuSzQyfyGFXUySnw==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.11; Sat, 23 Aug
 2025 20:09:55 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 20:09:55 +0000
From: Shenwei Wang <shenwei.wang@nxp.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Wei Fang <wei.fang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexei
 Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Jesper
 Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>,
	Clark Wang <xiaoning.wang@nxp.com>, Stanislav Fomichev <sdf@fomichev.me>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>
Subject: Re: [PATCH v3 net-next 3/5] net: fec: add rx_frame_size to support
 configurable RX length
Thread-Topic: [PATCH v3 net-next 3/5] net: fec: add rx_frame_size to support
 configurable RX length
Thread-Index: AQHcFGnkz5n9Q1yzskuWnB2vcuoySA==
Date: Sat, 23 Aug 2025 20:09:54 +0000
Message-ID:
 <PAXPR04MB918577F27FD6521B23601219893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
 <20250823190110.1186960-4-shenwei.wang@nxp.com>
 <0abb2c91-3786-4926-b0e3-30b9e222424d@lunn.ch>
In-Reply-To: <0abb2c91-3786-4926-b0e3-30b9e222424d@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AS8PR04MB9093:EE_
x-ms-office365-filtering-correlation-id: 1a56f0a2-e6fd-45fd-ce29-08dde28106d8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?ExPDVaZExFXWrxDUUmgGR4VAm/blMbL+++OdnA4MbBXgVl2X4Gc2EdlYgLCT?=
 =?us-ascii?Q?AP1Aql6eEUniGPt189G/tTW0/5AqTP1hE4dcOTSxHn8RarvhNqLYp1Jjdyzk?=
 =?us-ascii?Q?CF7BDCx4Ww3PCtpbhzsoXZjPphed/GBGtNSwXdQy3fl/gm7DNAdW+AHCCLoQ?=
 =?us-ascii?Q?nPiS3kHHQ9hr1MLJchPOMewHrLMbVfw0VsjaJt2rcLkxxs2oBZ+chb6HRDQ8?=
 =?us-ascii?Q?GjM6yuRO4H8po0/Lb0Kte/OzP1WV47MoblKX/e7YIpRLXDW8t5mDJCcesOnz?=
 =?us-ascii?Q?PoYCWFSJ5YaEGp+xeGLCeVOT8SKQ+n6bLN6phN5qevoszC+XAioWzdNoX+bZ?=
 =?us-ascii?Q?fuGl75pA4mObhxZSmZZE03XmeN7rjoSIAPhArgVQBvK9G9KNj9qbJBSS+Rlq?=
 =?us-ascii?Q?3n1cdCYZQtRozgOOO6uQf8bjaICpSqZ17LAGSIbmAcKMEBVmTRBp+juw+L8G?=
 =?us-ascii?Q?o38F0ufsfe5wt0q444jG9OArsGIr1dm+jOQ9JBe/V+AWkPY5jKYN4NBXqcAR?=
 =?us-ascii?Q?+CoP3/0IDXA2MjOMZ39f28VTTkLOI8GvTVWqowfMfTNhnhMNbCMnlmD6FygE?=
 =?us-ascii?Q?HH3OGML+Nm1Tci6Enw0DUBEwKbgu8gUErWatjDINR7n/zXjylMSIvPnynUu5?=
 =?us-ascii?Q?sj+/vfVwpHabf1EbZ5omEP74ayHbrYvH+bH4GThJkCpnOrF3c6UNmEgSug4b?=
 =?us-ascii?Q?07q765NUvgbT6c1mBxvNkGmQRAWHIRYnMtfL1FWMvj86SR2Mp3QKPy05pq0y?=
 =?us-ascii?Q?UU/o6d/b7YvjmfkITvZ94AV0k9HCqQROqcwtvVdc6E2F9bvKhENg6orA/2sE?=
 =?us-ascii?Q?PuJzLxc2CIHpYoATk/3lkYeD2q6N62BDkE7ufyLinruR5re5BavFGc3sZVCt?=
 =?us-ascii?Q?3Ha4bmbL2wLop9ip3EwrbaDWdH4LPmQ/L/aJRgSO8jNUuZvTGqpAaXwpCzOj?=
 =?us-ascii?Q?LqhbH5BDgBjwItf2EtAsADsxZiX00eROlq/EOLiP+P5iTQ0tjdIZT6vXEj5T?=
 =?us-ascii?Q?CqUdiHvygFp660CYLxhvVwicUoWu3NxpK706mANKpMdJxySt0pxm5YBBZhwm?=
 =?us-ascii?Q?/wfe9O2cdLRdfWpOpNi1lq8DQY4OisMJAi94aNnWFZW6NcrAfVg/WPsSX3ds?=
 =?us-ascii?Q?Fco2KOaL1a0H4t5Ldkid22NTWC2xSd34fe0HaHHb8TAyzmqSVgCBMX0EHPWe?=
 =?us-ascii?Q?0kmwuXUaI7ci/+TE+/AzoLhtvKG/FZwsuaz/ej9m83gfI6KpqMJHoICzXvUE?=
 =?us-ascii?Q?8O/oBQSYTisPPKJAcwZx3fN/FFjfDfwJ7BolDL4HyzyZ7hwNHLphKkUXV2QD?=
 =?us-ascii?Q?uQW+TxWsdU+WKHqw7oq0Uz3sXvB+3HN7G9jzC5Zpe+/IlhiHNbLKWWCbUuIM?=
 =?us-ascii?Q?y4Ns5n5D09mP+BUZzH5uIfcc428fLcEgFdYAq7sMLc+2MZbukNn5BzGIt1ZT?=
 =?us-ascii?Q?Lfwu9QH7s/mD8Wo44SzVBms4xsdVg08e0kOHwsiwPQsEDkwTKOOuaw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/Pw4N+Sl4KWdZAwOL8kMIYkfcxrREZ9FAQeRZodcsOpfomgynKpSqJXID2Eu?=
 =?us-ascii?Q?1dVKZwqIwvzMp6g0+XziCqNtebEgzuVNztuoX/YlXZ4CvwdmlFv99GRt97lR?=
 =?us-ascii?Q?Y2ewRHlb6xB5SfXz+nZKKQGbTai1faal30NQ9CoqNiifk4EfRiJj2bjeum9e?=
 =?us-ascii?Q?RtVaQVYi2EGRRUQZ7PcS4Tdq/AxAOL61CNnmX41mY/Jxa4OTLBUt9z4r5mJ4?=
 =?us-ascii?Q?a/riT4DsZArmcRJzhJJujJhYKja5ZMvwWVKNyfU+aQon48pGKj7n7Fd0IpDc?=
 =?us-ascii?Q?TtRtLno+yOIoAd6Uyb7T//LBLFrcMaopEQUtJzGdhfia03WLPcZM8mapXZvk?=
 =?us-ascii?Q?/YS4kVoKW3uAwmRbDWcKotNzcj+iU898flqQTzMtBUX1VXPXZT9h7LeIpIIw?=
 =?us-ascii?Q?pngnJWgAgQRJKWjnifbj/iGsQ0PHIlBogKs1bTRJXXnca0nwmJe4i5hOV/cy?=
 =?us-ascii?Q?kXLanfW8cbPlneJxu+OdtbA7qrRqNYapGAI9wOGEmz/32w6vrVDa6tU/RrXh?=
 =?us-ascii?Q?ABFz25fASc5xWcINMmo4EKQ25MIFr/XBVckdvtlvw/KrDOnlSPsNUBLfKiYS?=
 =?us-ascii?Q?CTCezcqRo4V4xt3o2MR0CdrJjAY3/1tB7w1OFU4vlv800dIkJ5b5O6qEe2vn?=
 =?us-ascii?Q?mes4uAEb4oehC2y5bfVesaR1cdNc6duTIzNlUO4DyF90Q5LC4FDcC+xF6SZR?=
 =?us-ascii?Q?sP0vd9IVJ0DEjd5GLuP7pN42TswdgJNTEt1yOTM15oQc0a1vz+HZFwDYNLJ8?=
 =?us-ascii?Q?tjOevfT+PwraeTJp5pwh3wPZq4/+Yozn7QtXQYd4NxLkCPUleQau0JkYlQDF?=
 =?us-ascii?Q?BclKubq8iFhFlZZR2O2pjCGgzBPE1PKAsi++WNVMBQcVclIZS5YM3LGkAcWT?=
 =?us-ascii?Q?J0/1Qez8G/P8FDPyw6vsUHg6N1rXU7DoMq1C7kxIG0eT0XiRKmmcJd9zrp2B?=
 =?us-ascii?Q?I6Lfji8AeszumGvRK8mWTDCwueDjvcpXTZ0zPeeEP6mhFRmtrrn9AXGK9o+/?=
 =?us-ascii?Q?EpQXh7tYn6IVvCqEgTH95YiLitxJeBeFqnpfO8attRyEUmIZdmXyCc9N0hrB?=
 =?us-ascii?Q?QU81qhC7cEyOsIH4PrhD9Woe0LrMJ/BA7PpdKVo/HSeOqqySjgzCOwtHjuRQ?=
 =?us-ascii?Q?mE2X55SbmJRjh2HWPgLAyZ8+C1N1WXyIDivoKDpVRAoigp2YMG4+ffvgGG27?=
 =?us-ascii?Q?EwjZqY0QGlfGP6cnwI/X6B+dfu4jH7DkYM3zrpjmCMrUtBzihx0v04VzLo00?=
 =?us-ascii?Q?RZacfDwGy5DExhfTeKM0FJ2OaGqdUkbBtEwZ0tbQ+/g7IzidCiEeWs5yX/T4?=
 =?us-ascii?Q?rw+PVmDhmjLNpTKHKU20JzVvuOszbuIZxhgxM+32BfUscujToNFaQqP71vjt?=
 =?us-ascii?Q?iSJu/21zlHhVZ+Qx7K6bSJdUx9+Kb07+g+kXylfUmPOV3Fl/4IvK2K1Xe/2w?=
 =?us-ascii?Q?1H+FVyv/+PpMbo4DiwOo1yr7B2xcX6O6UmMx1e/G8BUui0yXaCtKRPL1V71W?=
 =?us-ascii?Q?bUwwoB23cKlesx6Rs9EXBcR4Zwf64mds/fYQqNgjKQk60SkCyC8jkn3Dbj1r?=
 =?us-ascii?Q?uRiGk2mrndQ6zzhdM3g=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a56f0a2-e6fd-45fd-ce29-08dde28106d8
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2025 20:09:54.9404
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kbtkZzmAv38Z29lmGFK1nDnuLrR3d4lEGG5fA+ToFxEy2IsVXDkv1iV3ARHZFLAk49AppNlJEJt+NdHnZJtn/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9093



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Saturday, August 23, 2025 2:11 PM
> To: Shenwei Wang <shenwei.wang@nxp.com>
> Cc: Wei Fang <wei.fang@nxp.com>; Andrew Lunn <andrew+netdev@lunn.ch>;
> David S. Miller <davem@davemloft.net>; Eric Dumazet
> <edumazet@google.com>; Jakub Kicinski <kuba@kernel.org>; Paolo Abeni
> <pabeni@redhat.com>; Alexei Starovoitov <ast@kernel.org>; Daniel Borkmann
> <daniel@iogearbox.net>; Jesper Dangaard Brouer <hawk@kernel.org>; John
> Fastabend <john.fastabend@gmail.com>; Clark Wang
> <xiaoning.wang@nxp.com>; Stanislav Fomichev <sdf@fomichev.me>;
> imx@lists.linux.dev; netdev@vger.kernel.org; linux-kernel@vger.kernel.org=
; dl-
> linux-imx <linux-imx@nxp.com>
> Subject: [EXT] Re: [PATCH v3 net-next 3/5] net: fec: add rx_frame_size to
> support configurable RX length
> On Sat, Aug 23, 2025 at 02:01:08PM -0500, Shenwei Wang wrote:
> > Add a new rx_frame_size member in the fec_enet_private structure to
> > decouple frame size configuration from max_buf_size. This allows more
> > precise control over RX frame length settings. It is particularly
> > useful for Jumbo frame support because the RX frame size may possible
> > larger than the allocated RX buffer.
>=20
> Please could you extend that a little. What happens if the received frame=
 is bigger
> than the buffer? Does the hardware fragment it over two buffers?
>=20

The hardware doesn't have the capability to fragment received frames that e=
xceed the MAX_FL=20
value. Instead, it flags an overrun error in the status register when such =
frames are encountered.

> >
> > Configure TRUNC_FL (Frame Truncation Length) based on the RX buffer siz=
e.
> > Frames exceeding this limit will be treated as error packets and droppe=
d.
>=20
> This bit confuses me. You want to allow rx_frame_size to be bigger than t=
he
> buffer size, but you also want to discard frames bigger than the buffer s=
ize?
>=20

MAX_FL defines the maximum allowable frame length, while TRUNC_FL specifies=
 the=20
threshold beyond which frames are truncated. =20

Here, TRUNC_FL is configured based on the RX buffer size, allowing the hard=
ware to=20
handle oversized frame errors automatically without requiring software inte=
rvention.

Regards,
Shenwei

>     Andrew
>=20
> ---
> pw-bot: cr


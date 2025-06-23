Return-Path: <netdev+bounces-200108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A1B1AE3369
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 03:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E330F1890932
	for <lists+netdev@lfdr.de>; Mon, 23 Jun 2025 01:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D85CF1553AA;
	Mon, 23 Jun 2025 01:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hveeTwLC"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR03CU001.outbound.protection.outlook.com (mail-westeuropeazon11012022.outbound.protection.outlook.com [52.101.71.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E1317D7;
	Mon, 23 Jun 2025 01:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.71.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750643406; cv=fail; b=LANyfCOEoepvs7l8D8e6hkFlNZANcDbDBkSDvkxG+MROlXNMUdu6lMs7YR5CSaLOjnbd5exkMw+sGLk7D0D/rl/Q63FOUQgRBv345WG4QmAwdzVoZ0TyzdVvgvSuGrrO6p367icaqbyHYnnMHDcoh6U+fnCYccdxHoI4saozo0k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750643406; c=relaxed/simple;
	bh=RZdrSFKcKpW2KiCzl/M1jJqLhhajyWQqO4g1wIHBJjU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bX+/Y05tWj/xMGDcL5FiQwbTSqVS7n302LMU71RbHgvOKu2329j/zywzT9tyEvAkhz+6329w2gGzPwryGddynJbogVGe0Hi9INDwEhJmKTqd3L357KEHSHluy2S5crSMYWvi+fJrnBd1SqvOhlTK+rwdpFttUse/XXWEMgiNNZ4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hveeTwLC; arc=fail smtp.client-ip=52.101.71.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ew5CDWTGwNIZElGfM3FRd4SbWDzf7nCmu3snrlIZPt3scRXVY7mdUEQNQkOOdtR/hHNzJwR9ljpd5ArgszI+OewcrvEcxGydXZyH3TXw/eg9MSOrO7uje0nPKekunAZcP5CnMQu8NSAL9MIQNnHnLaaiIb2p/yqqYgiJgxLmtF65rD6wJwZDcMw/Wd41qkaSsncGovR25eB/PxN9vO6v7qIVaE6bNlAIBYJmkYCqOcpIpvZ7tcs1NJLjBaFV7vVZON82Oo0F4oXTzxkphh1hCBAsc3pRScw+WPJGffChY99iwIK/nVnpePLhXEe4k1CK16MY6XcbFTZat3uomK25Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kdhYb811GUQcc9R4nBFu/RnAXQiZa7YYqPMIAdpzQOI=;
 b=g6v9D2HwkSbZ9688V4bGYEWXjmnWP/tAoEdRl51LJ6aKBgZXnGCvEvQcSZuULCkPKfUJJDKrzB0npTxH29QKfKpXAEg9fJnkrhy+dtcQYmpY4VNwZNpr6/yfW2a0A/pV2pthqbvrSqf3cwp6+LwuZ8mddUQ4uBP9OVcSVQ0GQ0MLOGnxQQJ8S5jJhJjW4GkScnmZY1WPn/o4caEW8pVzTN29TCgZMI1n6ZrOiqyrJeWFIKlTwbKSPBnmuA90sxShTFgvZ/b4RKt+6Sivsyk3cVhmlggVlLSjnKyw8GHoK0x2lttwU/h4PAqMgnlL20TetiZ1Zfp87SZuYSjWVDu4RQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kdhYb811GUQcc9R4nBFu/RnAXQiZa7YYqPMIAdpzQOI=;
 b=hveeTwLClzqsY4IABHgyuESs+uxqUgUCdY/SG2HycUGAg7Ckhidbf0GUfsJ9hwigi1VN5HliRqqFOr+XtvzlX4YTQW4ov+gLQ+rHjJLGDJGQfIgx9kNMGxx9rl2h6ez70WfNNECl0I5iAy1vUeMTSyQbhVGXNvGHB1Um57GanBW+ajUDK/NG/BzvZgz1z6VijSqTBUhl3lyGzoB+jfs+G3bmQ7B3FHBBtss73mgfXD3pDCA4DGTX/EmddZKDulP45Du6SIfbeb76ZjZ//hUjlTAeHzYGvVOV07QBau28me3FuO2IdNW0E6s9cOv2Qg75wVF9loZfD/m6y6Ty6y7ARw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by GV2PR04MB11328.eurprd04.prod.outlook.com (2603:10a6:150:2a2::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.28; Mon, 23 Jun
 2025 01:50:00 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8857.026; Mon, 23 Jun 2025
 01:49:59 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net-next 1/3] net: enetc: change the statistics of ring to
 unsigned long type
Thread-Topic: [PATCH net-next 1/3] net: enetc: change the statistics of ring
 to unsigned long type
Thread-Index: AQHb4czJKeEuJfMl4UaViP+KlTFofbQNYN+AgAKcFdA=
Date: Mon, 23 Jun 2025 01:49:59 +0000
Message-ID:
 <PAXPR04MB851070E3D67D390B7A4114F88879A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250620102140.2020008-1-wei.fang@nxp.com>
 <20250620102140.2020008-2-wei.fang@nxp.com>
 <20250621095245.GA71935@horms.kernel.org>
In-Reply-To: <20250621095245.GA71935@horms.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|GV2PR04MB11328:EE_
x-ms-office365-filtering-correlation-id: 0045ac58-60fd-4bbd-3117-08ddb1f84384
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|376014|366016|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?H8JzZiZZegKhlIoRDBRtj2ef494hIZQOcOtYwLXUJVvsO0O63wKZk1kOj8mf?=
 =?us-ascii?Q?g8L+/MbfRCKVAmdSIpQqql4jzE6PEcBwTzd9SADeUwnNL0Ib6akmgmEqhaQE?=
 =?us-ascii?Q?W0q45H4uNkMpaZ6QranUmt/ETRmv3C9EJFWGpMNeuXA3JqVaLzefbes8mafC?=
 =?us-ascii?Q?9XfL5ismR3KY23KebitUU+5ueQKSdXPFk+Coj9e+3JMWvNLG8lMQwj0mv3Q1?=
 =?us-ascii?Q?UpnLvO0JMRBw5wkBJ8nbBXUYvS3Mt3iIhbIU4FrdljWgxvbFNGy1qPFk4QJW?=
 =?us-ascii?Q?FviBduH9HihJmwC6rRQ5mLaogX2F6DJThCz0U8WlIWyU/NokuYiprgJF1u71?=
 =?us-ascii?Q?CjHlwpgLqJppKbTl3SxQE+p1rSiFG2kW6TyMQYl8qpFpj25VCgcHVE4KLLfO?=
 =?us-ascii?Q?pf3aK3NNIAU2DUJ/Iu50mL4sHy6Rx9Tdg3hqVd4kW8IChCZIyBAZB7697Yh1?=
 =?us-ascii?Q?yHDRR4xSg2l6E1DnLRUJhcLJMHqSSNmGYKaNgq6Bsc7zhCLVw25cpGOvVZRW?=
 =?us-ascii?Q?Jj+tudgIDWdHweLc9+M5x8f1c01MfTfP2uEpBGyGBcqBnpEq7ULADPTmRta4?=
 =?us-ascii?Q?v7nGwFaRRxpN4fhrfvvyOadTTRLvaec9UlqoHLcP+DIDtcxZaTwpGapEBUMX?=
 =?us-ascii?Q?O9d++S0vDTI9961GJ7Xwitk79wU0JV2jF7i6Ex/XvvwwtDZV4iR5SxU+RDHK?=
 =?us-ascii?Q?8DricAZGPlRwsibfXZqqiFpG3eVzjk4jIsMVSo3V4ajewCVoDX9M6kCdoS7F?=
 =?us-ascii?Q?OASWI+U3+E7QZ3pSJuOBvIKLjd5xX3HgiXrmYE3oNyNCuK+LPCZwdLSJNWcZ?=
 =?us-ascii?Q?O770qLk4YaUnVQGY+TIF42pVNuS3uzqiwiu90z99ClZvSnEddfvJHBYnoGBL?=
 =?us-ascii?Q?TK21IfaBuFIqiv6dpzNkr5GCAfpfLpEJTUJ96/q5W9RD1F/T5pqU3wl9wif1?=
 =?us-ascii?Q?xlwtz+ZsaU/51My3PWJmBAIMKUqBADEFR+96DuqsB21i8kfLWyUU+bmluSDa?=
 =?us-ascii?Q?OAcUBhiUEnzY8sDnln+xatNS337jgF8/tupZKHug0qAGqwbL0lKKIP4hEeug?=
 =?us-ascii?Q?EWY8uViC4bAHn+b3oq92jhLYj2dR/+m/T6PgqPN8i/GEbUINwOpeFRnEw+JW?=
 =?us-ascii?Q?VaghCsSgE+X0MbQCgviXSiQ4bolQs4rzeCB8s03y8JVj3jKNaSqnWJwjz6Nb?=
 =?us-ascii?Q?W0PUV/IXdIvVb5SKVPRP62W5pBmmlIVJ4LlFAagmSGJYZJ6dCRjQj1gmA4Fd?=
 =?us-ascii?Q?PbdK0Zu76eLuqT0c1aWUaeZPHZy39WChGSfdXQa/1cLDRDt5kZlTRGnCtGlY?=
 =?us-ascii?Q?55KuTt0TM5fpGJnUMRj5tjXrmA2WwJtr1YlLTQbadJxCK3I0PqsoHftcA4on?=
 =?us-ascii?Q?0JckuIMLL68Xke/j2HzTBPc/9nrhPW0oEiqEl+BvOXkwX/fwRr5v/f2jTcrk?=
 =?us-ascii?Q?9y9XIbsVCpd9tElqxb2i8BWIpK234l0/bv9Jz3P0QiGjklLWKxW9owRxfLm3?=
 =?us-ascii?Q?Oj/RNA8tMSylI28=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?EvpphQVxbgzhg/W1en3KViV5WlnU01GCIXLymyYpIeGhD09vVZyI4afyxDDe?=
 =?us-ascii?Q?kfwExTMP/A1ug9Yn/enGL9oLLs7Pf1ZjqMKvqdLou6Kybn3dgbl8bU2NdBzj?=
 =?us-ascii?Q?mFYezlxhl/IChA0cXOFOKujF7NsQGiXQPq6LXyKM258UCHVgFUG9ug+3riP2?=
 =?us-ascii?Q?LRI1fmMYlpc8aG50FvRefBAMhC7ygevVDLh6WpDKGveobJg9nQuyWdy00VIS?=
 =?us-ascii?Q?AuDP+YwaI5oIJ6txqI117yyxilZ23ZRKSKPTfPoYqZSXa2YMj9hkSabMrZxG?=
 =?us-ascii?Q?t05Xvyc9DHHCarKnK6Y2mi/CpJ459hVKBB6QHJQbMDPwr7try7YG8GoJ+LEq?=
 =?us-ascii?Q?mP9byO2SUXoICM9+3f0ov/WBtlB/ddYRi0TvZetSpcKHSCCA1ylkEjgE2fOv?=
 =?us-ascii?Q?ZdsWWhpx/nsCgOseqYeTAOv78bvJFY29h6mR9a3J+ROAh5XOjDMQSQcUxRZV?=
 =?us-ascii?Q?pFH8atIUS2Bp24AaLAfwt3Gzo/WNgftIrXWOuRWAPMFuR3uk8A4nZqhzGYHe?=
 =?us-ascii?Q?HOQJdnINTJxALNN/ijnD6cI1vjg5DBvbLDklv1Hq9CeeYO0MM2D/qvWf8Ri1?=
 =?us-ascii?Q?803if9azjHHAAQK22MTLUL0eCWVqKRkccEsa0tpcTF3s9/IwQ0LXsF7vrZef?=
 =?us-ascii?Q?RxAoc9/HRbhYtdragenMrZGJ036qdDSgrAw+c7HFQx8DGuSDPIroD4E8vYBy?=
 =?us-ascii?Q?43aZ8b1uv40T3wTe/4xvYRBB0N3PVqdJq5A6EjoxlxtDelI5FH2C+HOr7i5U?=
 =?us-ascii?Q?w7G5pKzgxkfvNp1Z386yPQlwuLZ24E4NrC+U7aucAKk7redO3ZuXPNKdpKud?=
 =?us-ascii?Q?urpNjo/54/c1nRUMe8UkcpxKXDUKY/zRYFd7OLoooCAqVwRDfK3f/VBKqIYo?=
 =?us-ascii?Q?DlZFgvwR4Pha5ubhfYcfPlDJpMax6c7AX5ePQ/LWYrUeg/ZYY5+hlqpgibXH?=
 =?us-ascii?Q?80ws+WfnHB6HVjderpHa0D9bkTjH5riOmCVdespkSJ3Z+ykP2nBQUD/2/Siz?=
 =?us-ascii?Q?klRxwwlm8GmoDp9ZTAhhWZcMrBdwpRx4hxssikWkDXc08O3pHgOFXnFzL8sr?=
 =?us-ascii?Q?fYBVCuziqGk9zkV6tvwTO+YEwMH9RKIPK0aFdRmJGzPoDS0AQVL2GbB9wWd6?=
 =?us-ascii?Q?mMLoeGLThzSizFs/zxzMgvVn+YPF5l/+F2E5CI452JPIpJoJOy6IS/9OkWmk?=
 =?us-ascii?Q?AirEJyJmRJxM0MvaCwwLfDVNeZVAPhaHN2Co8mb6uQTOSQtytCoZTvyiKa4i?=
 =?us-ascii?Q?K7UeXBs78gCb1AEH4GgPr40R6qY9W8NR5MBcT0z0qjECfrKNqRYkPHbdacye?=
 =?us-ascii?Q?nTBQ1+QcQyGpERhc9MIQx3lfIGLfGOGokFiKaZmiTxw3Np28Z/0FwuiwaP4R?=
 =?us-ascii?Q?g2kIAe6+C3/SquDr7hkiH7zXFLyQaBfbKwLFMybbZM4zCEE2TYxEchrsnYxb?=
 =?us-ascii?Q?/gQUznw3H2U+KLg35whDgjNvY4yDOticrSbnJKu8ZUmvkWNjo2koySyXVaTz?=
 =?us-ascii?Q?5gBwU6cu9BtwqdcBpB6CBWVp7PFfu7tHWYSdGgLVr/OYtnPzWgSPPomEEl/X?=
 =?us-ascii?Q?Mr0VgYffCNsZOJkEmYA=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0045ac58-60fd-4bbd-3117-08ddb1f84384
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2025 01:49:59.8773
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: fe3sa/PAxIk2T65UeUozkoMlqUwH9ak3BOCFQXl/gZ3X9BE7Pc7YxqZrH8Yz5hYCH/HaFSm28mb1mKGy+STrXg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR04MB11328

> >  struct enetc_ring_stats {
> > -	unsigned int packets;
> > -	unsigned int bytes;
> > -	unsigned int rx_alloc_errs;
> > -	unsigned int xdp_drops;
> > -	unsigned int xdp_tx;
> > -	unsigned int xdp_tx_drops;
> > -	unsigned int xdp_redirect;
> > -	unsigned int xdp_redirect_failures;
> > -	unsigned int recycles;
> > -	unsigned int recycle_failures;
> > -	unsigned int win_drop;
> > +	unsigned long packets;
> > +	unsigned long bytes;
> > +	unsigned long rx_alloc_errs;
> > +	unsigned long xdp_drops;
> > +	unsigned long xdp_tx;
> > +	unsigned long xdp_tx_drops;
> > +	unsigned long xdp_redirect;
> > +	unsigned long xdp_redirect_failures;
> > +	unsigned long recycles;
> > +	unsigned long recycle_failures;
> > +	unsigned long win_drop;
> >  };
>=20
> Hi Wei fang,
>=20
> If the desire is for an unsigned 64 bit integer, then I think either u64 =
or unsigned
> long long would be good choices.
>=20
> unsigned long may be 64bit or 32bit depending on the platform.

The use of unsigned long is to keep it consistent with the statistical
value type in struct net_device_stats. Because some statistics in
net_device_stats come from enetc_ring_stats.

#define NET_DEV_STAT(FIELD)			\
	union {					\
		unsigned long FIELD;		\
		atomic_long_t __##FIELD;	\
	}



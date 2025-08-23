Return-Path: <netdev+bounces-216247-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2C86B32BBD
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 21:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E1E1B683B1
	for <lists+netdev@lfdr.de>; Sat, 23 Aug 2025 19:54:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFCF23C8D5;
	Sat, 23 Aug 2025 19:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="UxWnQz8Q"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011051.outbound.protection.outlook.com [52.101.70.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6502521B9DA;
	Sat, 23 Aug 2025 19:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755978823; cv=fail; b=gDMPOj8OlgSq5GJfiPN7hDu6YJkGJC6PRfdsMMn2Yu0GYz3zxMi95ppjEKVNpbidpYhRH6IdarN9BfioqZ1WSbVhCrXszyDAupBCw/AOJfgNm0yhpXsV3a4Rdi6Xalxb14orz4utfc+BhooAxKXdan1RbFVOzSLEealRohcojgA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755978823; c=relaxed/simple;
	bh=eQsoxxEEj9bDlk4e4pF3g3GEjOfBOpCzY3oUmTDc9V0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YXfpKq/X+1/8vZxZj8zrbfmr8CjNLaZ7p0EBGM5q0ZmkarC/FBaKdsEdphwu7IF8m5wfdB16LHnHySXKh7w38l0nR5ojeP76E/E11+xKeQDn5envAMJ7UGZ9akkVsxMwuWYJFabqlsbuZCn3+U4yVm5OiZWUyXtFECB6heVN2YM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=UxWnQz8Q; arc=fail smtp.client-ip=52.101.70.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U2AixYOgqulhGaaTcYZl6Y5SG5gs66wDaJSm3+0uQSNWv9z+jVi9gEXcuxkaAoVy36GdeQRVNdym+RuPdVzJwGj3qFoHDu7mbWpksMrU7VYhGMTkbbzEqik3PEkAUXW7idoi3YZljK6MsjNisZCFOxjB7vF1T78PmqXLPDjtmIlE0bK01zYjU0tmDsOm0uFHcLV1llNiJ+pDzFn0SZoalythSAJSrSsxMdzehZCUr2IIXbLOYXtE5MaY+h/yc3RXVO1Z59AxOvWlFb2QXaLzaCX/HMuVTkXc2j8V2Et7t2bNCJbkfJ5R95llO0xNwLkZ1xK1KZDgtIux208qvWzcNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lhfcr1PeoDyUdex85YQXM1CAsVMdr4OmqoUohgBhPSU=;
 b=O+qVrnM2+VPt/KfhJFWGDFO7x5Nt7ckjLxbVNMejGQTTHsGF8H6j/x2e2qeYMWSpNA906ikv0JJMjSOGEpmEKDhzJ29bdKu9pNztT0CqcvI/8i+0985/0k4238g83LS8m/N9I0ef+0VFs3yvTCptkxTYzYrWhsDrRqnzKHXo+m5DbHzaMYEY8qWEs92d+9zTEz9YD1LidbAeoR/qCStjlXL32LdDW/QbJyCTbQMdjQH4k+5YiMVDsAU1k56BP9T+HolSNd3evtUna7blhw2np3t21VqjKPn2Fu+L+FqD3H5ZqvdOjMuWxH6MzN6ByRmTV2nAKQderOwkXj5dI17zYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lhfcr1PeoDyUdex85YQXM1CAsVMdr4OmqoUohgBhPSU=;
 b=UxWnQz8QzwPHbIshD+1DJMOrZ3gUpCbRNOMLE1ubtenhnEVwMRCJI+5w4Q6K8fRnm3A0CfNdSSwICvxC7NBvWUXsFqsHAkK5QvQTK6mVSJk3WqxcOZ9cYTJxe7jaTnckqf9tlTR2WZ04UjX1SqfoT/cyFUsET497FUBJ4Ac41CtYuF/5ae6pmWvyAbZND/4HFWtyToYTZTJ8DO0OZsY21H/iXFYJqGUksPTzAFM/4KYvsVW9NapWDrWO288x5JM+JdNA/7jx0xYTX/rKyMobiosB0YBo0P40wU7AL6QZqfKaH+XdSYbTRui4isVut2qlQ/MVZiyZ8j3UobGoUSRN2g==
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com (2603:10a6:102:231::11)
 by AM0PR04MB6801.eurprd04.prod.outlook.com (2603:10a6:208:18d::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.17; Sat, 23 Aug
 2025 19:53:38 +0000
Received: from PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612]) by PAXPR04MB9185.eurprd04.prod.outlook.com
 ([fe80::21bf:975e:f24d:1612%7]) with mapi id 15.20.9073.009; Sat, 23 Aug 2025
 19:53:38 +0000
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
Subject: Re: [PATCH v3 net-next 5/5] net: fec: enable the Jumbo frame support
 for i.MX8QM
Thread-Topic: [PATCH v3 net-next 5/5] net: fec: enable the Jumbo frame support
 for i.MX8QM
Thread-Index: AQHcFGed3jgFadvm/UWIjbgZVrZcXg==
Date: Sat, 23 Aug 2025 19:53:37 +0000
Message-ID:
 <PAXPR04MB9185AAF36A7FB42C4D00CBDE893CA@PAXPR04MB9185.eurprd04.prod.outlook.com>
References: <20250823190110.1186960-1-shenwei.wang@nxp.com>
 <20250823190110.1186960-6-shenwei.wang@nxp.com>
 <fd9af170-fb59-43fa-9eea-ff147f4a84a7@lunn.ch>
In-Reply-To: <fd9af170-fb59-43fa-9eea-ff147f4a84a7@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB9185:EE_|AM0PR04MB6801:EE_
x-ms-office365-filtering-correlation-id: e46f0f75-3f0f-4326-648e-08dde27ec082
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|7416014|376014|19092799006|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?B+Tmj+d1Vhv3XseZkkwpnPJdRnAryKRTwTuEqPtVgDERu8YhSAhzigX8TDAv?=
 =?us-ascii?Q?LUY7tCujpH0byNN7wHdZaAS9j6QL+cpDZtwXUV3lbf5U3yALLiHfaKdxZlbK?=
 =?us-ascii?Q?DLXkGDAMDyQJ2hYuhpfou39Y6ga9RKCS6pmwLsiXgw14dFh1YSAOBfZlAeHl?=
 =?us-ascii?Q?ZlJ/4/DUfE1427e5gTq9TXfo3RCuoNSRMsUzX5lxiWoAfjVAZ91fcvFbyH31?=
 =?us-ascii?Q?+xVLH4e+IHYR96u38pqEo+wkprUkjRqlhDJgEpcFi6YKuyecn9vx3nX8WM3+?=
 =?us-ascii?Q?ppjoAbh5oyhIsK4dgCYaikG9UFoQaeS1cw4D/GCoHpixvnXKziRRIidkQEKA?=
 =?us-ascii?Q?REF/Dkoj6H+btVtptICcQRNW88SR1smQ0FGMY2YuNdB7S9Sm4zKcJh+5o3vE?=
 =?us-ascii?Q?M/v5C6aXbE5p39mVrYTHB5v3pb769NNNfA/gVITK9Cb6cav7ZKOjlycm+3fp?=
 =?us-ascii?Q?tBXFRH83dh308nfvlSxomMdxY1TS/O33T/ytD1UJASEGSEdJr96uzSkUtCvj?=
 =?us-ascii?Q?xYRo3WkpMaaynKckKj2zxeOVe8DnXQ2NTFJBH61j3TNhI0ITWU0nLD/YJGZf?=
 =?us-ascii?Q?ytonW6eZYYSUQraO8cT4w42rkbpl+OwNfs0jveFR9cjquRU8qBuAXetrS/ZF?=
 =?us-ascii?Q?RwKyIf/3bqiJ/6mFs3KcCym+K8mSMolxocxtyXKsHgOma0YElzctmhavo5fL?=
 =?us-ascii?Q?EARD0sCcF8brB6LuQMjuLWS4DbKyxQ//mAcZq1LHxuWEYvbM3eeCKi4eOwfX?=
 =?us-ascii?Q?C7iTFDeVi/je4hQnmRDPhJvWqbQxJELbDSiS4EB4ygNHA3+1iuBIeBDSSmcI?=
 =?us-ascii?Q?NUDmSRA4MtYGNXdTwhckxxOzWlp/yj77d953umZyQFr1RWQTpidhBYmZl49a?=
 =?us-ascii?Q?DF5TSsReJuEHqRs23Sv9Yz+3+MOYbuKmEAAHy/rn8aBQ5uxicngAT273iUoI?=
 =?us-ascii?Q?z6E6TxMu5wu1G3CymUrUaRKt3QDCCyB9UzgOTgoyonGXfsw7RZ1Jx75CHKio?=
 =?us-ascii?Q?bTsNwTWHntwZ+icepY2YPHxpfFGFJwhlO7Ub5JxVjsboZAZpPneNDfDTLi8N?=
 =?us-ascii?Q?aCTUQp4LhuXL2S8G5sljN/v2q2JAgagRCq+0xOgnBVMYCroV/dW2A8oFSNjt?=
 =?us-ascii?Q?pHJLCZDH4qpPLd7CIyIBZgoTUdyqo9OAQWDeBqR2LEQyScwnulZ3iYRGi/QF?=
 =?us-ascii?Q?OyubgaNUBo3RkRWFupL6NNIUjtDduKJtI23H+RmIGz2fWqdwN0yqsxeL2wY/?=
 =?us-ascii?Q?9sAzao4P9LT+WcXm0hxDtDSPuRDJsTqxuuVqE1Lf4BmHprohF4KBLI6/aj7U?=
 =?us-ascii?Q?pU2v3HItJqkOiECwlR6QsW/hs9RbtlyElB+JMNCBVolcsU+KNeUO6gOzkZnD?=
 =?us-ascii?Q?cKTgts7PmnPgWqlxEY9FHM7wfLn9SCwR8IQzb+Hhh8TdNDgEiiBiNscg81L6?=
 =?us-ascii?Q?5A6ftF1pUeVqlnkEYR5b2O38980xY9b/+mG7hw69cik5xlUKLl1z3A=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9185.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(7416014)(376014)(19092799006)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?id/1u4dXpiNXW0gTYNCDUik8qrN25/VPEDWcuqsz2PiVN22gBLXU5XSnXjhA?=
 =?us-ascii?Q?S0X3qYKsCcrhN7inDsjfIWUqpHear4M0uFcEY8SnhhS/clM3mg7NRR5eSYIo?=
 =?us-ascii?Q?EuUyKB1Ax6RgXIprzbnT/+FqnZ/ORg4GcDjhAAdN30RXjepZ4jAMF80ZKOrM?=
 =?us-ascii?Q?P/ojNlkg1gcG+wgJlIBYOFG0omXNYTSaAOObe4guWbyHZ1Q+hx9Vye8xZmN+?=
 =?us-ascii?Q?OIqsVsPd9i7rsGrFnz2/yo7fSK/C5PLB8RhNqNi+d7LGdmdbLjeQ/Aoe+/aV?=
 =?us-ascii?Q?70EVWwnDPyXo7/o+utoQN6PB+/2WZ21M7SDDpEa/g79k2nkIaW8iXLGwMS4V?=
 =?us-ascii?Q?rM2ujvek7NFwOfa6KrmDzveq9I531e+eEvFZOr8JqGNbmfKsL1hnTdDEDmHa?=
 =?us-ascii?Q?dNorzmHyzPtZStKNaJH2hKb+aWV6K56arKthmO5ABsjNtr2OtL11I1421Cng?=
 =?us-ascii?Q?XP0cPkW9fZ/heACTAwJc46p0wAUwyY98CSJfBTAW+29NkW13AW+U5kwM2V66?=
 =?us-ascii?Q?+74Y3BDfSUfl/vUNaMiwXni+RCJdoN0CYGldiCn2yt50h/FwRBTDUYFTuBQc?=
 =?us-ascii?Q?jbMcBbCJUSnfFFj1WDw9yQrhXPzl4ht9oGz3W4bsQzXAyAB7MCFVMmUN9wBN?=
 =?us-ascii?Q?VHmq4H5QtCC3suBuJUwe1eTo2jzGo0X3ignkMejra3vo1A+ANFMg2wSfCZxp?=
 =?us-ascii?Q?RbKH8/dw+ta/MtJLmkR0zUNuydxZfmxYqFZKOxG9P24oeGWv+y666F1+/MTz?=
 =?us-ascii?Q?aiaMkZCRQ7Rx7zhj1URockJL6+GgXD36Pfg3dLVN7bAAtudWdAEjl5NKxZuM?=
 =?us-ascii?Q?3eft2oYQGXN02dqpOtr26oR5e6ORIKdjuY9kUzVjZPCV68F/0288KTX0AkCX?=
 =?us-ascii?Q?sT4dcd7eBvsMqwu5v7V04a9eauXXuHc/CDOb375S4gMcrYBqVJYkb/Xl6DhZ?=
 =?us-ascii?Q?Lrk4WJd7BpQiMc+SaY9CUHGFd6ZhTv7XdWppwIWfobf5VavbdUT0OSbj2ivy?=
 =?us-ascii?Q?YUvdYSrXCWth72DYfp4+yVmpnSQn4IIg8kR2QgxGaVNrCwr//7A/EecPmYrO?=
 =?us-ascii?Q?2w4pAGzbIc3OHCEW7kplZI6S7dWTAHmU21dd+NH2z9XGEYIhUWNXSwoec+Vg?=
 =?us-ascii?Q?EF1vFW+cy87XR0mB7MPFAfLrIeCzqY/mA1UciFyx9DGGTAd8Q1/O60R7kNCh?=
 =?us-ascii?Q?2v5bgpRgzH4augzawvyefoBoBXb6+UWDvfiBge0I9dvIpaOeIvvvUL6d20Yv?=
 =?us-ascii?Q?fBFCldVf/9Uo1VyDcO46PNyM+BL6vA84KGmqVo2FYRO2YJ3x+pu8vicMxfQm?=
 =?us-ascii?Q?iSniyUmNTyPdG9Sx1xqAfD6OsnNKG5+nxXTkRU3zf6GQWbUHkx6GDXIwU8vq?=
 =?us-ascii?Q?CRFDfHw+XXVOr/EuGAwvSPqgsTKQexgOcs1KsEUxY0UrR6SqAUMAdq2uBl8f?=
 =?us-ascii?Q?N03Tk9EUp3tk/cNuzZdXOqvOefuSiiRpqXYNbhcMsEbw1DFHtMfekHlTWlJJ?=
 =?us-ascii?Q?/lKUHeveaKzPKXMZy1DBkZfmBe/dYwg5m6roytF5UzXN0vRRVjH0CZzoZ47g?=
 =?us-ascii?Q?KEdu7wDpFDx/IuMV8BE=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: e46f0f75-3f0f-4326-648e-08dde27ec082
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Aug 2025 19:53:37.9598
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jK3SFBaGyRRIwX4HSurtDVzISl85j/yiMPVaT/SLnx/ranF9ohgj7OArLm+kHmODre8Tz8FzeTHLKOFnhEhxCQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6801



> -----Original Message-----
> From: Andrew Lunn <andrew@lunn.ch>
> Sent: Saturday, August 23, 2025 2:26 PM
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
> Subject: [EXT] Re: [PATCH v3 net-next 5/5] net: fec: enable the Jumbo fra=
me
> support for i.MX8QM
> > -             /* enable ENET store and forward mode */
> > -             writel(FEC_TXWMRK_STRFWD, fep->hwp + FEC_X_WMRK);
> > +
> > +             /* When Jumbo Frame is enabled, the FIFO may not be large=
 enough
> > +              * to hold an entire frame. In this case, configure the i=
nterface
> > +              * to operate in cut-through mode, triggered by the FIFO =
threshold.
> > +              * Otherwise, enable the ENET store-and-forward mode.
> > +              */
> > +             if (fep->quirks & FEC_QUIRK_JUMBO_FRAME)
> > +                     writel(0xF, fep->hwp + FEC_X_WMRK);
>=20
> The quirk indicates the hardware is capable of jumbo frames, not that jum=
bo
> frames are enabled. Don't you need to compare the mtu with ETH_FRAME_LEN =
+
> ETH_FCS_LEN to say jumbo is enabled?
>=20

The comments here do have some confusion. The goal is to enable cut-through=
 mode=20
when the hardware supports Jumbo frames.  But we can limit the scope to ena=
ble it
only when MTU is less than 2k bytes.=20

> Is there a counter or other indication that the FIFO experienced an under=
flow?
>=20

There is a Underrun bit in the status field in the TX buffer descriptor. Th=
e hardware=20
supports retransmit frames if high memory latency is encountered due to oth=
er=20
high-priority bus masters.

Thanks,
Shenwei

>         Andrew


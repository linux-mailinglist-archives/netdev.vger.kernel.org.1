Return-Path: <netdev+bounces-203789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B1FAF731E
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 14:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A8BCD4A64B4
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 11:59:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2AA92E424E;
	Thu,  3 Jul 2025 11:58:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="j+r7dF/C"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2055.outbound.protection.outlook.com [40.107.220.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B342E7BB2;
	Thu,  3 Jul 2025 11:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751543936; cv=fail; b=TGtboJq2taGkYlDtVIq0VSWPhClULoAn4UYTdQpDWSmfVXrX103vXmOnc67SnXaxqe572cbXMexjM4VUqR3Niy4B2sHMzZwH7eLPmEAj88UVepbxz6Pi5TtObY+nZlAtIX7DUm2TsY/GsbMVCBvDd+1UqIUTcccHUc6r6JB7gBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751543936; c=relaxed/simple;
	bh=P8lO5dL1PVur2kIDgq5spH4wSjhFyFH7GjdOBmzveZE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OPcGeNIt2vfDwkEmaLI1pnK3SBxH7/nJP7oUUI23jRQaWiaW41B2pKGOYi9nZRyRLXcTTmpUDpK9rucbl6BNWMSY7yzQo1yrv7Lf6VOCbXEzE1N7UJQGakMDpn/28cDE3HElio7GHO8CrO6Q3NJh/HtVCH5gxG8gRmXrTvCDe4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=j+r7dF/C; arc=fail smtp.client-ip=40.107.220.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Orr4aCiLNDGi1JHb3b/ZG7qZ0KG1xUk5+Yo9tAJaJWxwvbyTDjXpb8rNPOK7vW7Dw/WZLgosmEKIUKJeW0EgECRhla1KAiihJvMMxYS2/3xnfOFl7wI8CedrOOI2hmCChevkgh5GNEFp7IdsNFUdYT51VnQoVKFIx0WGqBlNH712cV0i1A9EV3Zcasm621KuSBvIuV5vYGFfPLQOwXMzYPlfzQjqONvpWvMuETJAjBsAyxWoLsR4Ld4/XIXupSSoTE/2EJN3GL9gm+o4L1x2nDtlKqOHNlNxOnRIe2wD48DUBAJBAmtuocroWhNN21ZSs2D11tvuPrrio6oUbWRJEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P8lO5dL1PVur2kIDgq5spH4wSjhFyFH7GjdOBmzveZE=;
 b=PVwX15n31A5/dx1cei4SpACfrJG77VNnnkchHBXhOcdnUP3cHyoyQhs+RFSb+Ycc1PHKuScgCo4J5l+8XUKECidKQknH3SEhev0Ia6yf1PLmbtPOy6lHjIta05S+9cUKSDzyMmUMStiMkV4MqdAjPI0jFZOMBcmpQ23CKcpZ4As4dRr94bPQaq6Kkjsu65yIly9AGqwa99aeEWfWP1cLwGw6Kq8QqL26yvPLQmmqD4fvioAIBXZioYe/Bb8UmgKpK1FkC4bJKS0T19nTeDuiFcXG1j60yO+J72gSK7FHlpuoOrLMPHxSJoeUhQPg7LHUSh3m35H3aczloMpMgSzz/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P8lO5dL1PVur2kIDgq5spH4wSjhFyFH7GjdOBmzveZE=;
 b=j+r7dF/CVBuzY9Xbwr1gR/XlVwZpJnyIk43+ukP9tcD4+vPv23OdDglBB430049VUjfchMUyvsFIxJ/u3Fq+nNd4onvMfLv64iUC9cBkRMcp8+BS2evNyNnF/1JywbWHbpnYCFPMIHKHRfCKzRlWb7bXIY7DrRRLMOT8kaARMtVcB+Co+2YhY4k+Wv92trpDaF/mwwBgTfn4K9RvsZNXczyGKuxXSgqRsAmdrf7fhfIAtpExMUJzhRQdaU4bOgE0lF+20xoUHnlMsvrIWw4jBWXzlyBBp5wTq4MowZCKPKfBRFI1YKGTDPW/tnW9u0jROWehknyb0LAokrnDzRePXg==
Received: from CY8PR12MB7195.namprd12.prod.outlook.com (2603:10b6:930:59::11)
 by DS0PR12MB8069.namprd12.prod.outlook.com (2603:10b6:8:f0::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.22; Thu, 3 Jul 2025 11:58:50 +0000
Received: from CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8]) by CY8PR12MB7195.namprd12.prod.outlook.com
 ([fe80::e571:5f76:2b46:e0f8%4]) with mapi id 15.20.8880.029; Thu, 3 Jul 2025
 11:58:50 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Dragos Tatulea <dtatulea@nvidia.com>
CC: "almasrymina@google.com" <almasrymina@google.com>,
	"asml.silence@gmail.com" <asml.silence@gmail.com>, Andrew Lunn
	<andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Saeed Mahameed <saeedm@nvidia.com>, Tariq Toukan
	<tariqt@nvidia.com>, Cosmin Ratiu <cratiu@nvidia.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
Thread-Topic: [RFC net-next 1/4] net: Allow non parent devices to be used for
 ZC DMA
Thread-Index: AQHb63aYJqQBPRpj30ykrq2XrPwwyrQfKE4AgAAZDgCAAA5wgIAA8qiA
Date: Thu, 3 Jul 2025 11:58:50 +0000
Message-ID:
 <CY8PR12MB7195361C14592016B8D2217DDC43A@CY8PR12MB7195.namprd12.prod.outlook.com>
References: <20250702172433.1738947-1-dtatulea@nvidia.com>
	<20250702172433.1738947-2-dtatulea@nvidia.com>
	<20250702113208.5adafe79@kernel.org>
	<c5pxc7ppuizhvgasy57llo2domksote5uvo54q65shch3sqmkm@bgcnojnxt4hh>
 <20250702135329.76dbd878@kernel.org>
In-Reply-To: <20250702135329.76dbd878@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: CY8PR12MB7195:EE_|DS0PR12MB8069:EE_
x-ms-office365-filtering-correlation-id: 268419ff-8ffd-4ea0-2399-08ddba28f9a8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|10070799003|7416014|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iPItUVgpDFMtuXqCC9nrBGF43SGqaa13SadWtEdZsPgVz9ZjheosGyLHZiD9?=
 =?us-ascii?Q?OeWutshkvD7wd9rZeAOYaZ3CjGSeG/RVwVs3XgPHTpThNmTwMHlc1o7m9TKA?=
 =?us-ascii?Q?kvFW7qZKU7bsgeuY7jGpTTRw2mzct0EvyiHPOnGQVA3zbpDk5XgJmp2UazbY?=
 =?us-ascii?Q?aO2d/LInst6vY2X483kGCsS+FbYnKv+cRU4kuK00quEP0yQCD4FmV4XtM/B7?=
 =?us-ascii?Q?xlKHPXjmr7cySO2QtV6U/yM1X7/Pej29q3IMNjEQfD6bRBViTM12a2olJxse?=
 =?us-ascii?Q?q/CuL2x3uek8xYCCcWRueYSHbvTRVqY6UlYzJD7HNn7/VjBI0h3mx3OEMfS+?=
 =?us-ascii?Q?c/RSrkBIJFZt2MMyZ0daueqziWy2MgYoF2hw2Tkzo7WYZU8Ztfm+Sf1R5xVs?=
 =?us-ascii?Q?U+OhKOeohipDLNFH3RWQP+UK/LzvFeh2TdD7Rt0xFeQnI6he07i2cXqHxQNU?=
 =?us-ascii?Q?cMvmcokKZDNUz7UsaRaa69dTsqehgJ0UViW5/kd7BNF4siiVun//vIyYDHWP?=
 =?us-ascii?Q?hvlg+LF2hKMpBP1Z4HB6dzYHafxP+yhXNy835YAfXVYSYtkmAacQUJUz2CpG?=
 =?us-ascii?Q?zw0Y2KAw45kRyy8uRr6lZY6OhtykZYFnmxuO9UnE0pN0gbGp9D2cWgdI24J0?=
 =?us-ascii?Q?/cMHG3ldGUZPY5dnbOgvjrgfc+3MImDSdU1Ps2HGbiEdqWfdWR1DISVNM/WQ?=
 =?us-ascii?Q?5BenOY7tCw/DqKnPRkgblg8j4Dj1Ofhvlvng5YYP0g026Fb2w9uK53o885wk?=
 =?us-ascii?Q?CyyxKuiKZWlbal1HCvvGhNlwS9PjwnFNsALGRvGmRAI6ZSqozcDaMXNpdK7L?=
 =?us-ascii?Q?Ge4RS5jVdna17+T3TlBII26W9TzjVlk/RYpnStrCGvb94mcsLAl5Hr0hosul?=
 =?us-ascii?Q?3WQWB7TV38T4qzYUOxWW0jotlhcGVu4CtvCzaUzfN1T/YOfLBbzSOiljqEJw?=
 =?us-ascii?Q?8gWvc0RKVK1tJIEAieXiwMzKyrlbLENVNzYeAS8xsXeURGCXGXoRCzFg5LT0?=
 =?us-ascii?Q?WLLLl8vzXFOghGd2ANxW0owwiZYkBQrCeS15ZxrHxyhICnQ7Axd1ZXPOqFKw?=
 =?us-ascii?Q?wrEKBU7Z+v0AWX3z7AMnvJYPggWdUbVpYqL3MN8HbAAuK8pPa9BFLiF6uODQ?=
 =?us-ascii?Q?pSfq+dS8YWRX9W+7lc/3IqfzSNPaP1ftkqKSC6XmcKltkyFD3ZKSXU7BTOUA?=
 =?us-ascii?Q?3fH1qvbuHXgWIy923LTKwIEEXB1v4ZoQrs6fdxitdawyTWTG+7wTTrT2OsR5?=
 =?us-ascii?Q?Bc5vaSn7PmJ+7KN6HdYe2akcM7VgsUq4wj9TT3RI/3lZFKnJ2E+pDpg5gNtY?=
 =?us-ascii?Q?mDQKUJPk5iszvqQWoOrF9jM+JTzd4eAkg/1WScLczT9IJdll+hWly6eyIYIw?=
 =?us-ascii?Q?1CHWQwxUFgVnp0l3J1iHowEFR1N3i2ThXmznHQWdW/r74G9GVgqeTyuRz0+R?=
 =?us-ascii?Q?eEBVcp1BLlhDZC9w7xUOpVmmUfEzse6snpug0gTHaLYjMTMc+U4glrnSFvbH?=
 =?us-ascii?Q?MECMcIorn4IBacs=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY8PR12MB7195.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(10070799003)(7416014)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?h6LIJLhueH1RFj9RKXVhkxMPIQAi/9AJjpvagc67jyscqAOdBbir/T0YgpQg?=
 =?us-ascii?Q?MC6PVkrDjpsWSfzBj37b7gRKoq226y6y3Lp266h9dMPDtmus+W0GR6S0+/2Z?=
 =?us-ascii?Q?HJhzP598kmhn9AcB6F4fyV+tP0DCHIWgWjCQolQCD4MasPd20YAHmd9iVgje?=
 =?us-ascii?Q?jGHeIfImv2MApe/1QhvXA9EJoeTznlXysk4c/NTYs4K1psHsE6KVW77axyAU?=
 =?us-ascii?Q?YaCeXxeTgA0XVAzQ5AtEBysYiyZP4nXnOCzHOLAR+Xbcd7MCZ6fWOOy9VAOs?=
 =?us-ascii?Q?c7KmM1mQS7EmZ4ZM7zh5i6upCS6IQWfRW+7vjqENTzMgtOGOjBq9WV+InbI9?=
 =?us-ascii?Q?BfVt+wdKksLrSg9405b5MUBmCOeexeeYfUbeOo+ovCcMvTuWqg7y2/nBW7tg?=
 =?us-ascii?Q?NcxqdN9EuXZG7Uc0X1OH3bJIBo6KwHIucUkLLiCyP53VnbuqB9+qlg6gs7Yv?=
 =?us-ascii?Q?xb/UgBpHzc9PT/Iw5Z3mosL6OoNuL78Fi53ZY6THe8rlzMyH+D5rI5Wm9BrO?=
 =?us-ascii?Q?EBg1fkTLlF5cgrj6vZDzvybUjSrO5NolGKmxEE+sap3VFwtZ/kRyckh2PMa8?=
 =?us-ascii?Q?laVUR8EashIc+EMPFnxyuFri2nGpa5XCKFqarHoQIl2shZVGW0SvDlhp1EAv?=
 =?us-ascii?Q?v9MVJ4JaGTsYvUfp2+OtCuk8RJtkGEgBKRP7PJQffnaGIv8wjdMNhaYKhuUL?=
 =?us-ascii?Q?iemi1SSmPqAtG4HglfTxdZMzfI2975I0alTs6/c45vZJbm2zXS1Mz9K+nOGc?=
 =?us-ascii?Q?cIB7Sz+2Nf3e1kznviAaIOVEm0w5D9NETc8j+cLFmkJ9uImKi8JTCp8z6jVz?=
 =?us-ascii?Q?SDryrnHtikqfW1RZ7hpMNcKRZ0VJxegt1L0uaRlsRpgJD28UvE/4n9MYhLnp?=
 =?us-ascii?Q?UZXQR4JeE6QcZ+cCRjxBcP5WpBHg3De7ol/HeeGTIxaGmA92ztitkjVWw/Sa?=
 =?us-ascii?Q?/j35tzKCwcvgIY55E2iu3ZdJ1GOPPnuKsKdqmPvZrYG012hnADbhrM+VMZ2N?=
 =?us-ascii?Q?IOpVwQF4IoePRzBMoWLW+IFkNXWNDjzka0JaFvUmuTGgaHqz4h16Ds8prSPa?=
 =?us-ascii?Q?fDGwtJwrJ6z4eFT3oMflRK/n/muS0RpQgr3cDfCUp8u3l8pfJZdyAvDUrkJu?=
 =?us-ascii?Q?0JCIqASGPElhPe//jjYxsA6eH8qhSBpNh+j28VjkxXhy2DMqOZWgsz6bK5cK?=
 =?us-ascii?Q?bSzJsRTk9uA6mA8OFO9W4Wb6ztC5+WTz7on08AXiR/06BtYL8L9OJ+SymnOs?=
 =?us-ascii?Q?WwIP8i2jLqKBrJn9OjsBynZ2EHGCY5fqsNzqUeIrb5m65xrqqZ+WzMJqsb9n?=
 =?us-ascii?Q?QpH0OKSfavnMyogpD9Q4F7bIY5PKPQkiTbAX7aBbVU5kST1/Kj2eVX8SPS2F?=
 =?us-ascii?Q?LYQJzlt3f+o3/wcwnNVQLy+Gt3FWm+zyzFvOXK2mubCJAJ0Cn77C9Be/rmx4?=
 =?us-ascii?Q?orWf+TUR9TjyR6J/HIShrLU5t53UqbhY8HlXnFvMYFJaoqfRckZ7a/1Hs3y6?=
 =?us-ascii?Q?uw4ZPnKHVDg0eoCzILaqWvPIhh1tIazj5NWFDCzXtOa4PxZ6LPb2LipOugxS?=
 =?us-ascii?Q?FfSA8S67HjrxB99t+NGzYHzfgEC8AMFU+VW4wynibRlxKDubkJ0RkkV2PXvB?=
 =?us-ascii?Q?M8fIYC8JscDqHoyi0hYYN3Q=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CY8PR12MB7195.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 268419ff-8ffd-4ea0-2399-08ddba28f9a8
X-MS-Exchange-CrossTenant-originalarrivaltime: 03 Jul 2025 11:58:50.5705
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iFp8jSCOGFmKXdJlSR9LQb8U82CLlbKU93DCjzK0iuLnLaozfJeZBNMTs8Td1Jf+9qwh2S9gaUBnyPm3p5IT3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8069


> From: Jakub Kicinski <kuba@kernel.org>
> Sent: 03 July 2025 02:23 AM
>=20
> On Wed, 2 Jul 2025 20:01:48 +0000 Dragos Tatulea wrote:
> > On Wed, Jul 02, 2025 at 11:32:08AM -0700, Jakub Kicinski wrote:
> > > On Wed, 2 Jul 2025 20:24:23 +0300 Dragos Tatulea wrote:
> > > > For zerocopy (io_uring, devmem), there is an assumption that the
> > > > parent device can do DMA. However that is not always the case:
> > > > for example mlx5 SF devices have an auxiliary device as a parent.
> > >
> > > Noob question -- I thought that the point of SFs was that you can
> > > pass them thru to a VM. How do they not have DMA support? Is it
> > > added on demand by the mediated driver or some such?
> > They do have DMA support. Maybe didn't state it properly in the commit
> > message. It is just that the the parent device
> > (sf_netdev->dev.parent.device) is not a DMA device. The grandparent
> > device is a DMA device though (PCI dev of parent PFs). But I wanted to
> > keep it generic. Maybe it doesn't need to be so generic?
> >
> > Regarding SFs and VM passtrhough: my understanding is that SFs are
> > more for passing them to a container.
>=20
> Mm. We had macvlan offload for over a decade, there's no need for a fake
> struct device, auxbus and all them layers to delegate a "subdevice" to a
> container in netdev world.

SFs are full PCI devices except having unique PCI BDF as they utilize the p=
arent PCI
Device's BDF (RID).
Presently, SFs are used with and without containers when users need
hw based netdevs.
Some CSPs use them as hot-plug devices from the DPU side too.

Unlike macvlan,
SF netdevs have dedicated hw queues, switchdev representors,
mtu, qdiscs, QoS rate limiters.
vdpa of SFs is prominent use too to offload virtio queues.
And some are using SFs rdma devices too.

SFs are the pre-SIOV_R2 devices and hence reliance of auxiliary bus
and utilizing core driver infrastructure sort of aligns to the kernel core.
If I recollect correctly, the Intel ICE SFs are exactly similar.

> In my head subfunctions are a way of configuring a PCIe PASID ergo they
> _only_ make sense in context of DMA.
SF DMA is on the parent PCI device.

SIOV_R2 will have its own PCI RID which is ratified or getting ratified.
When its done, SF (as SIOV_R2 device) instantiation can be extended
with its own PCI RID. At that point they can be mapped to a VM.

> Maybe someone with closer understanding can chime in. If the kind of
> subfunctions you describe are expected, and there's a generic way of
> recognizing them -- automatically going to parent of parent would indeed =
be
> cleaner and less error prone, as you suggest.

I am not sure when the parent of parent assumption would fail, but can be
a good start.

If netdev 8 bytes extension to store dma_dev is concern,
probably a netdev IFF_DMA_DEV_PARENT can be elegant to refer parent->parent=
?
So that there is no guess work in devmem layer.

That said, my understanding of devmem is limited, so I could be mistaken he=
re.

In the long term, the devmem infrastructure likely needs to be
modernized to support queue-level DMA mapping.
This is useful because drivers like mlx5 already support
socket-direct netdev that span across two PCI devices.

Currently, devmem is limited to a single PCI device per netdev.
While the buffer pool could be per device, the actual DMA
mapping might need to be deferred until buffer posting
time to support such multi-device scenarios.

In an offline discussion, Dragos mentioned that io_uring already
operates at the queue level, may be some ideas can be picked up
from io_uring?


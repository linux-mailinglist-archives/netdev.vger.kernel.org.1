Return-Path: <netdev+bounces-284826-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mJyWB0c7+2nUXwMAu9opvQ
	(envelope-from <netdev+bounces-284826-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:59:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 75AC74DAA2A
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 14:59:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4F77C303EC29
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 12:55:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFE343EDABA;
	Wed,  6 May 2026 12:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b="g4v2b3Zh"
X-Original-To: netdev@vger.kernel.org
Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010008.outbound.protection.outlook.com [52.101.193.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6FEA4657C2;
	Wed,  6 May 2026 12:55:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778072115; cv=fail; b=Pta0IkMoJO6M7pvNOxD2whZC+5YfXs7Y7tAC1FiW5s7Amt7o8au8caH93jkv2kTV4vC7aAZuOonYwoyw2v+CUU+vpDJi5bbLJg9RTwLGpZ1MUFUUEPYMtyAPugvExN0RidtKK12q2oHSuxiRFgg9Lk6WW311itqLEvy9slmFWUQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778072115; c=relaxed/simple;
	bh=GKrFu7hwBkxUO8iGu6nY0O2vLEOGpHxcxYQ+dhabzB4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MJk3Moq6tAZsufMnRB6L7UmPrYLQdQV7pDFJWQN8OeoC7979EOu7GK0InotP4Jxm8jSSQpDs+d5hAQeAxU4boA0QchEuyxT2zXpRU4Mo20F6OIiAzgspUtZMPK0A0qejpgrx9PmnOTiMkVqf3m6eiPnv5KMBPAJzP24V5wuJ7a0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asem.it; spf=pass smtp.mailfrom=asem.it; dkim=pass (2048-bit key) header.d=asem.it header.i=@asem.it header.b=g4v2b3Zh; arc=fail smtp.client-ip=52.101.193.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asem.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GnGSuCKV32izj4mgj60ogQAlu1L95b3XajJdupP/Q4Sdk79QG6t2oCmyG3j5KOBRw+Q2+LFSKiBNN24eNG2MWGAcyAA3jDE4YjCMHN06xPjuYv99ZRcIyzY1dcJ2LP54VZSQM795/k4o/OjmyD0HkjdqT/p2OSnDI6vffat+Oyk4x4qc5/dGz4VY8hBJLZVp8UEH4b0Ub9bvMcuedvHI7fi17TB0reZFx0LGEZh64JBWz5lMLbupf2ch4ArBhfwRg8AGq3yZiryneqFMCyo6LMiRP9MbnN7U2LVjj5NfOODpQPAk99jr0l1CtEAETYNIyYJ+ozBaE182ayzEDdLIcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GKrFu7hwBkxUO8iGu6nY0O2vLEOGpHxcxYQ+dhabzB4=;
 b=Ify+5rOQZGbvkWUKvzqXHQY2L5hCkPcpn8+/LJ9jGjIw28q25zEhDa+WppCPVF12m2nU1/XvfHlgdpsxHMRhP85goGziZVgyINSHUuPHEXfH19yJRgWWCWkpI8iam92x6qTcUndtG6Af2P3HY5cgNb0egQZnRwWdM9LXpkgAL9QtsHXWcf1CPUcxNFi6lbpHtgUKuoIsilwhiFtbvTDskKePo1DNxRDMnwLjkkNbM4SH08mHzucWvJneiwP/Enxo9/BZs8CbTZNJK3XC8GXaH7PVNv6PuzvjWjctkm8YDib8ZytsTaIZ8CPOdhGipgBq6Be74y+VBFWANnNsDLNTjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=asem.it; dmarc=pass action=none header.from=asem.it; dkim=pass
 header.d=asem.it; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GKrFu7hwBkxUO8iGu6nY0O2vLEOGpHxcxYQ+dhabzB4=;
 b=g4v2b3Zht77g+NspWuyDZw2dfLi5AiCHCaqfzaEOnvkZeFhSFVO9igNbnIBBomwqHF1ud8yTGQIIj9ziSB9UPTs628EeI52Q9TwUW9Lmyp4uKaXm3hNOXBQuURft8lUa3bX1xLHgcevYMhPYBwJHb9bnq0I5h5fYIJRKwgzylrP/gy7SZTXLaoAIf7Y6awsnSVtbxEJzNrAHYvFnd8ExbgZFQNYxygFSL66yplMPw/nxiMngXFZdWmzm8jmFiby8vnaRiV0CTChznzhNHwFIO9Wj7fvWfffiUhL4XcA95ZIszNZPuGrVYLsoaB4e24QqHbCgWC1ySYiATtNGIHroCA==
Received: from DM6PR22MB2152.namprd22.prod.outlook.com (2603:10b6:5:2bf::17)
 by SJ2PR22MB4156.namprd22.prod.outlook.com (2603:10b6:a03:543::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9891.16; Wed, 6 May
 2026 12:55:03 +0000
Received: from DM6PR22MB2152.namprd22.prod.outlook.com
 ([fe80::dc0c:acf7:ccdb:14ff]) by DM6PR22MB2152.namprd22.prod.outlook.com
 ([fe80::dc0c:acf7:ccdb:14ff%6]) with mapi id 15.20.9891.008; Wed, 6 May 2026
 12:55:02 +0000
From: LUCA ELLERO <l.ellero@asem.it>
To: Andrew Lunn <andrew@lunn.ch>
CC: Heiner Kallweit <hkallweit1@gmail.com>, Russell King
	<linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: phy: dp83867: add MDI-X management
Thread-Topic: [PATCH] net: phy: dp83867: add MDI-X management
Thread-Index: AQHc3VeNsAjJGDCkPkOXyW+YrV5N6A==
Date: Wed, 6 May 2026 12:55:02 +0000
Message-ID:
 <DM6PR22MB21528FA74930F6DBD2ED8A7F853F2@DM6PR22MB2152.namprd22.prod.outlook.com>
References: <20260505122751.233764-1-l.ellero@asem.it>
 <9414fa96-05e1-4d7e-adca-4ccf3b96853b@lunn.ch>
In-Reply-To: <9414fa96-05e1-4d7e-adca-4ccf3b96853b@lunn.ch>
Accept-Language: it-IT, en-US
Content-Language: it-IT
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
msip_labels:
 MSIP_Label_e14c1950-b3a8-4278-88f1-6df69d73b9d5_Enabled=True;MSIP_Label_e14c1950-b3a8-4278-88f1-6df69d73b9d5_SiteId=855b093e-7340-45c7-9f0c-96150415893e;MSIP_Label_e14c1950-b3a8-4278-88f1-6df69d73b9d5_SetDate=2026-05-06T12:55:01.880Z;MSIP_Label_e14c1950-b3a8-4278-88f1-6df69d73b9d5_Name=Internal;MSIP_Label_e14c1950-b3a8-4278-88f1-6df69d73b9d5_ContentBits=1;MSIP_Label_e14c1950-b3a8-4278-88f1-6df69d73b9d5_Method=Standard;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=asem.it;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR22MB2152:EE_|SJ2PR22MB4156:EE_
x-ms-office365-filtering-correlation-id: fdce838f-ae82-40fb-2bf4-08deab6eb04a
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|1800799024|38070700021|56012099003|22082099003|18002099003;
x-microsoft-antispam-message-info:
 AiyEAiUhPZYcPnzRaa1kJJDFEICG+JyL9soVs9Q+6i6t6Woz51894BwiVCsI4Mrp/E+Ze9jbL6qvi6LBq1MMSsVHfWc3gItHthNK0fe2BOFjz7SPdUaam/l8h/DhTFA3OHLabIE9Y+yO4gTiwW4iTWE6MUHvDyBEKUFHnXbPlyTJaCXoXzMquU7J6szZ66o6h+WrMEZ8fa8GWVtjz9w86mcAPM2rwUCOLoqtov1pgrGvFMikO8Er7nIvXflHTryMCV3fe5fECZQAok9a700+bljrva5r42HuGIYsqHM/V5hxzefhNpsa56jlm6Acz7BOYcr6zj+cGt9nbPpgf5x4NZRK8woxZIg9gmoI66LgnQYEUy6s6+ZZMUOW0N1JlpMKFsbUQjEALthe8V5fM6D6fYTUhPMDW/HiUdKHMIYMRQv8NXA3v90XnO4A2JbjpupUrL1ciu3KeTrowOUhpGg1rgQg784F8MUb+GVPX2e/+ApZANlqhB0g6Mr5rrgYCoVU1dvLOW+kdNlR9s9m3+IBCifiqeir9Gps8ewtgkXT6o3r+7tbEjpVHL14ZVxCHg6ergW6ugaXjyZRKXseXK2l3pY4XUcKXRn3itR1VwK80qXXdlfkCZ4QIHEfEedcJpTtToD54M/DsN0scVVvFnKmHFnkRBDnfnG+ASfOhZfI9mP+bVnTxNYdU8mAeH0dpTzzT4Pfx2P9urYZqrj0h3PvMr5X5AvJ6imGTcHrff4MkrlAksLCu1MQEFcww8ZlnnTC
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR22MB2152.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024)(38070700021)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?3lYakljPtnoWcvIpSFqwODahCOzxPXzHUMtc1CRAz7GTiUy1JI7Begg1Tf?=
 =?iso-8859-1?Q?3+o5NsPL+SrKoeeT7Cv48sCGuHsqbeU31qTNhUGaEfG0di+cBqc4XtpGJb?=
 =?iso-8859-1?Q?DfmnTEcK3UzI170JTOgZ62j3Vi+ydIjVuxHPQ6R1Rp+so6NBppd6InUETf?=
 =?iso-8859-1?Q?2KFkixfq/HSs+Og3/fBXhoygsiU+dcCGNt9DQW3M/1s2q1gbcZQwPSnPIZ?=
 =?iso-8859-1?Q?rayyjs5gpg/zNb7Kx7GXlUyMII/Lx+hkD4vLr8tGZD6Rgsak5ElxAe7QF3?=
 =?iso-8859-1?Q?sX6UnssIdjyF5mAvIqrF7ZK/nmPwR1LRtqtRTN7gqbmz84Z7EjqfVELVob?=
 =?iso-8859-1?Q?qgDMgmlsDFQgAI+WexONi06rP3bUcqhx5Mcs8vmfBKZOH091t9pU2wArrV?=
 =?iso-8859-1?Q?86aoWcG616d6WJFyucCH/G8xR2xBzytB/qlo0iDq9uOUR75YiEbGqylRst?=
 =?iso-8859-1?Q?AY/S475xylhigdDOakwJeLPk76aZx7zsjbfwpWFr512msjFYYXH1zzuOFx?=
 =?iso-8859-1?Q?qHBfmzBoRK+6xhjq2+gKZSebUIe1P5ihc2sX/JmVnPQA1ANHdkza+TAaNM?=
 =?iso-8859-1?Q?ThdvWXUQRGcIJ/SylDjA/PrtBJ/R9xZd2t4uQQ4NX8/93sjY35BldVtmSM?=
 =?iso-8859-1?Q?XnmW9FYKOh0aidYgUVB657RFvBrN896y/Beatjy5YGGnXdbvm/TlxJHK86?=
 =?iso-8859-1?Q?BwfxikDJUtJCD092TFMNxX9OGZNnEVHyQCYE9LNDxHMWSZdMTIl8Atycwa?=
 =?iso-8859-1?Q?eMqSao3SMSdq+7DyOnp0wYAhtM2FL5AL+L/E8y++Jmatd8sauoA/29jT+c?=
 =?iso-8859-1?Q?mJZMqPXUFJfwbI2mMCUVQ3f7UzWaBfGSbTdvdm0OBzAGoCGq+gWpixH84G?=
 =?iso-8859-1?Q?eefYHGLCJ5uOxqpAkYWV/QJHIidpWvcVaH/4ER91HNcpfxTRFDbGn08gYT?=
 =?iso-8859-1?Q?ctfqhcY2m7jj+9lomEWGTjqnYjF+P886aFVy+zWZvkftyX6t/gDe/qFpsr?=
 =?iso-8859-1?Q?iCRIHA3vxJxJjpaBWOMFhtvHY7zM1u9KGnKbaXbGDrmS5UFrz+sfeXysYj?=
 =?iso-8859-1?Q?a6Y0tKZmiMjt1as/Q4JM4MoBJ6JtjBu2YWFnugDWGT6+b8LV3wMVOsI0U+?=
 =?iso-8859-1?Q?IkVA5PYqXRz8SCApoYn+O2C/ClxRbU3qrAYVPU0gtN/cWVOBo+R8o0WkV5?=
 =?iso-8859-1?Q?93bprJYQ2CR5qs/EE299CxjTBoZnNzOM+zRO6DUpoukiG+ozwFYCVIqW76?=
 =?iso-8859-1?Q?8wg9Xx305VTyXQjGyfOGnTMrjWQUvNvt/Auyg0ySykakwIp7WoW2L0j2hF?=
 =?iso-8859-1?Q?tasCre2k1iYawJpW6APIMxXYzDleFmzhp0/MLNljXMrl61oeCrYJVv9Hpr?=
 =?iso-8859-1?Q?8wREa7nC+WQkDI4cFreaFiT0ORIRDujxkrw9UY9b5NqdEm+46YuDNnmb6M?=
 =?iso-8859-1?Q?+pwTJneYrSacJd7hfl+j2q2+8N21YCAIhPj7rxyp9HwSZZKTLBzwCaGtj3?=
 =?iso-8859-1?Q?/En0ENVpVChWArVqv1LQuSVeQlBtFmyWNmCtQDDpjlrSbyb6Pcnx07JhRI?=
 =?iso-8859-1?Q?f/nEEs4YtmJraFEUdpVD/8vfsW2J3B5bb7brlhKp7h3nwkDYzFf2TLUMKL?=
 =?iso-8859-1?Q?aSGMVekDKveJM++Y5u6BrvoYUO57mYU9XvJd8Lz4sIA4A0y1ponaXYBR3z?=
 =?iso-8859-1?Q?XIwMLVcI8ccIzxbU6fYhq5tF3pm1Chi70KFpoYLpCdDKSbN+At7sDwuze0?=
 =?iso-8859-1?Q?U37OekbuhS/xzXTCkIuP+JgSxuFrpcwIQGPy4bg/UFYnlhOIp+EEEpoEgW?=
 =?iso-8859-1?Q?yruOXfh3mTPkjULDm6Jxu/VbQfftHOU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR22MB2152.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fdce838f-ae82-40fb-2bf4-08deab6eb04a
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 May 2026 12:55:02.4528
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 855b093e-7340-45c7-9f0c-96150415893e
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iYQJXu3H9MZV2o2h7E4c/oFBKDrZlcXRXsmO3omRPjNE6f6x6jjGIQGuvcfnvbRSartifvg5DYCHDmg8Zew+oPCahZM/BrOeDp/VlPCmpADBYpjqzZWiuHjUD+omo948
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR22MB4156
X-Rspamd-Queue-Id: 75AC74DAA2A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_REJECT(1.00)[cv is fail on i=2];
	DMARC_POLICY_ALLOW(-0.50)[asem.it,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[asem.it:s=selector2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-284826-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[asem.it:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[l.ellero@asem.it,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,asem.it:dkim,DM6PR22MB2152.namprd22.prod.outlook.com:mid,lunn.ch:email]

On Mon, May 05, 2026 at 02:34:56PM +0200, Andrew Lunn wrote:=0A=
>=0A=
> On Tue, May 05, 2026 at 02:27:30PM +0200, Luca Ellero wrote:=0A=
> > ethtool on this phy device always reports "MDI-X: Unknown" and doesn't=
=0A=
> > support forcing it to on or off.=0A=
> > This patch adds support for reading/forcing MDI-X mode from ethtool=0A=
> > properly.=0A=
>=0A=
> This looks good to me.=0A=
=0A=
Thank you for the review.=0A=
=0A=
> Please take a read on=0A=
>=0A=
> https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html=0A=
> The Subject line should indicate the tree.=0A=
=0A=
Got it, I'll fix the subject line to indicate the net-next tree in v2.=0A=
=0A=
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>=0A=
=0A=
I will include your Reviewed-by tag in the next version.=0A=
=0A=
Best regards,=0A=
Luca=0A=
=0A=


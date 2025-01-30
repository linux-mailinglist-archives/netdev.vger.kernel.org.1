Return-Path: <netdev+bounces-161596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B38A5A22850
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 05:50:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8B003A702F
	for <lists+netdev@lfdr.de>; Thu, 30 Jan 2025 04:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9059414B945;
	Thu, 30 Jan 2025 04:50:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="B7zuNSOy"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2088.outbound.protection.outlook.com [40.107.101.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A9A34778E;
	Thu, 30 Jan 2025 04:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738212622; cv=fail; b=TgFxqjxJsjikHZh8coiMAeX3SRq/ycLNjrT14WRpO6vNNJtEdjPb+nJaz7WZle9xclLFOlKqWVZFpN4MnZk7rDTPfYdVPE0pSf5KoRjPFCbTZ6Yp5GIYo6ajyr7/SnRPBcWdQE+ff76UkfOsdekCGDERfPJ2AtDKw1hV9GPXRro=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738212622; c=relaxed/simple;
	bh=Pc2VWXetdtgxwTGXwtcBEVFAFG31Cs6OpyXzDBFGQok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BhtUVs9Kh8lyucFl+y5+U89EaK4ZBWSzbyvYFfFfWGdQfgicM2AQUYgduzhagEt+w2uCLxUleAXyrjlykDsObGhfs0hwaXKzhwhMtbVhDymwJo8O8+WD95bJj/JbdcE6Sehpe2BJsc1GD+lCSbLhhXPXlCJ4BOPFIEqXoKHeqFI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=B7zuNSOy; arc=fail smtp.client-ip=40.107.101.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k0theTua3IdW7R6DYPwmfIZo/NqHTM490t5HWnIRQM0e3Z1DEUJgIIUdtRWXVL2bZAv0pyXWXfxc5o3sZDcShwSLDF1IfE9WOx6c6dGl+R3fily/bJnPVD0ccI68NyRy5uxoaDNGumrdYZSQENQW7wNzZ25dnoYL6F/FaCh7QkhHda9Nf/Wfr+FEUnn8HjhcpWWRfLsx3BOLjasQEmb6txWKdk3P9jIc1gRI3syCl+Np8qRICPDjNNzn3Cus15jyaoRjvg3eyn0Vs0pd51D90k0zExcP+ABlahkmWvSqRiYyWSHbUcLx0X8ODaArrq+1C21pjNW+HJm3XcXIZfo3PA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JMVHM/oiBXj33fX9n+ipn0pWqjcOouoyB5b/XYatz5E=;
 b=Md5WeVWoSuMDWrysvGQYM3637NRsBA654ctAu+X8w6maP9ZhVb0D0UaTZ9fFs+WgSLOOM93JvMK4RQVf2je2bcPfnPrtq8fAhBF5BLOYvGNIOj3e4PIxw2/w6pSjvA252C4UQKCoE+eHKtyRXfvmIqSsPE3mDP6pOV7avd4JaBhwvBUrhMTbHV3LzewgnaQwc2RrXQE0d/oZ/nThwNAqE9sdEC1xVXgtjKNkQ0Ix5H593pQJK1SdruKhAjt6OCg9EXr3hdRo1vhzDHD/MIrzatk4HIEO7TU7ZWJlCwxz/QnNW+6M77TuQx0wH1u4GLYkW1ZtO49VH8DCnqX+Pc5gKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JMVHM/oiBXj33fX9n+ipn0pWqjcOouoyB5b/XYatz5E=;
 b=B7zuNSOyUm8lDTDX95F+kmR+zWoyPcYiKdccTxrGLNeMdvaSP5Y9DDxCBT8b7Oo6vfVvzEaHbahJ8ywO2bFujYFzWe8sAcg62Eb9wyx3G9pwyGa7MF1Us1w3Pz4OGhfvB+bcEkAIoFr3/en9F2JCX1pA/D3YCxjdIpdd0EU06G/shkxK9GCunehC9714EnAnXlM/aaEIRQlE3NuEe/Iw7AQvjRRUrO6st4i4YDHzY4O13IjbDeQNMrVuvoI0Ip62Oe8rz6R9wOTCDpMgUENiFfkto/0ALgi2XUuepyT0uwLoZjVQRTChrlvldlKOLhUx4d6VvCByaWk824TzvLbl7g==
Received: from DM3PR11MB8736.namprd11.prod.outlook.com (2603:10b6:0:47::9) by
 IA1PR11MB6292.namprd11.prod.outlook.com (2603:10b6:208:3e4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.18; Thu, 30 Jan
 2025 04:50:19 +0000
Received: from DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0]) by DM3PR11MB8736.namprd11.prod.outlook.com
 ([fe80::b929:8bd0:1449:67f0%6]) with mapi id 15.20.8377.021; Thu, 30 Jan 2025
 04:50:19 +0000
From: <Tristram.Ha@microchip.com>
To: <linux@armlinux.org.uk>, <olteanv@gmail.com>
CC: <Woojung.Huh@microchip.com>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<maxime.chevallier@bootlin.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<UNGLinuxDriver@microchip.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: RE: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Thread-Topic: [WARNING: ATTACHMENT UNSCANNED]Re: [PATCH RFC net-next 1/2] net:
 pcs: xpcs: Add special code to operate in Microchip KSZ9477 switch
Thread-Index:
 AQHbcTVTuivbdfDuaUSUZ/9LsKZxAbMr6oWAgAAP2ACAACTNgIAAL48AgACPMRCAAWS5zoAADrgAgABkpMA=
Date: Thu, 30 Jan 2025 04:50:18 +0000
Message-ID:
 <DM3PR11MB873652D36F1FC20999F45772ECE92@DM3PR11MB8736.namprd11.prod.outlook.com>
References: <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <20250128033226.70866-1-Tristram.Ha@microchip.com>
 <20250128033226.70866-2-Tristram.Ha@microchip.com>
 <Z5iiXWkhm2OvbjOx@shell.armlinux.org.uk>
 <20250128102128.z3pwym6kdgz4yjw4@skbuf>
 <Z5jOhzmQAGkv9Jlw@shell.armlinux.org.uk>
 <20250128152324.3p2ccnxoz5xta7ct@skbuf>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <DM3PR11MB8736F7C3A021CAE9AB92F84EECEE2@DM3PR11MB8736.namprd11.prod.outlook.com>
 <20250129211226.cfrhv4nn3jomooxc@skbuf>
 <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
In-Reply-To: <Z5qmIEc6xEaeY6ys@shell.armlinux.org.uk>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM3PR11MB8736:EE_|IA1PR11MB6292:EE_
x-ms-office365-filtering-correlation-id: 0de4527a-2ca8-473b-b3f8-08dd40e998ad
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM3PR11MB8736.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?dkeeIRcc7suzxvLNle5cfycTrmsNMv9bF9+OOe98xfiTEE37dmapVhPM4tnH?=
 =?us-ascii?Q?ol21T2Hv+B9ce4bFly1Za9LRUjhHn4KdE1dAOldit+nNtq+fJhqsf2uT5g8G?=
 =?us-ascii?Q?IYCBaeH7/St+eK9i9oGSav+bRU+RpvkaGnxaLWU6psInQ8+71J9lcgw40JML?=
 =?us-ascii?Q?L36npwenKHJ7kd2caLMxPHZmvg49JxYepQjFiNt/GqfovOrZbRXTVUJl2Dw1?=
 =?us-ascii?Q?+UF5lZEpoXiwD7MW0GwOqLAMVhKr5KSkaVHTgPlNcH/3FlhMDYyKGHHgkz2F?=
 =?us-ascii?Q?2hyvsKHrKWa3SfD7c4o5J4TWrsOyZhR0ZSHaQyuGrws6UzdkdF3Wif83zZdR?=
 =?us-ascii?Q?zjY0WsVnZQIC/fpcFvqO5eV4HEkgzXxLSVsUxE69RFT6aP90n5l7mUGGc8lp?=
 =?us-ascii?Q?2KaQAnUsyZfM3PsAtbyPkUo5JgiWSkNCz0ibcLIhZp48z5Q03syhBhCtb9ox?=
 =?us-ascii?Q?1pZ2VGId0CswBq+OvldLh4XV5fk7O+OPKbQdqhe7UMYG+uI9OzJDdz5r521a?=
 =?us-ascii?Q?N2PntMyuOHOmBMOm6MCL3wM7DSuDQQV43qZN/eVA/OyQU3QInOuE1PN4TwL8?=
 =?us-ascii?Q?aM7E7tHzIUvD9nzVQzeIr20c6SZ56iz/pvQMg13sVXQPxn8rR2MOemvwNhfz?=
 =?us-ascii?Q?X8+BDcwneZtjp/Btxtdt35g41B+J9v0qRfNPsnBfY1Ih3gL2xCXkB5WGbGis?=
 =?us-ascii?Q?OHYAuokQnonOE6tLcdUElbn8bL0LXiS2VzNbKMIx/HUaaNb8/Xf+tzj5NDFQ?=
 =?us-ascii?Q?WASsu8b896ifmV9ez/ENFXm0NLnDHYw93Gl4nmrcHtWIUlfWTvxdkzeBNC2a?=
 =?us-ascii?Q?4urE0VNiVeV1v2bHGzzBiGYysSiysk3CbgQfn/KfSUQTV35hy9N2sJED987e?=
 =?us-ascii?Q?H5nl60pfQp1teCEF7geoqA4RFmHLA3kedeDwe3eik2czt82fFvRAWYpADwJf?=
 =?us-ascii?Q?kF5CbmO+dyMiLx9MGO5etevxu92JV0NuAS/Pti99KX+ppjX47UdwMi4J8Nbo?=
 =?us-ascii?Q?k4OZpUuvScO9pIjnkgKGF3JozhszPdPFWwGpayOYpVshzCl/xul6FSomNSrS?=
 =?us-ascii?Q?YZzRE8XHl4mHc3HXcFe+pmx/GTtpp+eXZiuONj5LlQNRO/N2DVX0OUtFd1ne?=
 =?us-ascii?Q?VuZu2SE3eT6RhurL3wC7iXjoDBmuoWTHzrlaK4rfhRY2CSl+gzRjwUnf6JMr?=
 =?us-ascii?Q?zsqRqfrthjFJiv+ifh5WfSWsGAESMYAjqlLuetfTMXj91Z+f4zgmQwMKhTRA?=
 =?us-ascii?Q?rH5AZPRJ71xR1cW3sxdZEKMuhutYs2jURrbQui5Q/H4ZK6Is7ONQ3V5Q9GDM?=
 =?us-ascii?Q?vnMh+r3N3u6DG3Bxtrj8E8HZ2LomEUDIwpqwIDEvD1XpKXoPZBiEgajIn9pL?=
 =?us-ascii?Q?JvYMoVX3qPAZgbp3aDpMjhTRcunmhbElSvINmONHeOgbKgRL/TIHPPyQldKT?=
 =?us-ascii?Q?XktJqxgnPjMCx98R94VpYh8EA61RYHaj?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?I9u3WjOyNxNiuHdT1wYZa9TCnyKahG6glh6B6NIKYua2iKuh5j9grP8hpIPW?=
 =?us-ascii?Q?fEpcQWLBd8zWBbjmF2yFIaY5HqCF+2hnRyCEn0u6+Fa5Xfzu1ccjVZGpRecW?=
 =?us-ascii?Q?O+wFOZlZRixNd7fdauA7NBLl5mkjnILKM6FgzXi8+GCf2EorReQpiZOIAsNO?=
 =?us-ascii?Q?iPsdfFH3R2jrbo1DhMSzKoYEDHMSEsmembJEmWh51hjST0u3zledz6FZxsJV?=
 =?us-ascii?Q?PgPXOtWyL3nxerd2vjHIn/QdFsji9LGqFb6TLKCn6G3SyzDTZH7WfwPZorE0?=
 =?us-ascii?Q?sQKGcRffKnMvpuuvMwZ8eLzOqZ/M6q0ZrsXBo/w1BKxHQ43KdAZsYT+BIUD3?=
 =?us-ascii?Q?g0JmsZfo8zmsRCP2zMpu689PaIfnE6wZA1dCBTo9lHqoQxoHhFF+4CeYm9WS?=
 =?us-ascii?Q?Aa24F4vMTaUC66WWr2dQ7BSzb14YApDOUPm9zOA+eHkXiclPjhL/oF2KmtMs?=
 =?us-ascii?Q?GKy8BAXtpa5XM+7njCqq03x4X+Ck2CdLP6WT/P3YmCFnriWRFeRBfCbWHDLT?=
 =?us-ascii?Q?nWCzX5v4CUysrbUEK6D+N4NiKdbUh4Ir7ufXO85GFfOelsgekaK0vpW0UjZo?=
 =?us-ascii?Q?6cAgr4sVZGSUebmIzHQuIzNokAEMuSG9rsyy0SGZ6R4RI9rmK4QA4fEkhxxS?=
 =?us-ascii?Q?cxclgoKkhNviwB/XLm6iKTq91LWQPwq2s0VUsAe7Zogx2QxbHQcdDvr9W3rh?=
 =?us-ascii?Q?qrllVV/6y0eXITBNjI7O2+4DnPzSzvpykTJXWS/dZLoDGRZtLsJ1lB8aX8yg?=
 =?us-ascii?Q?FdXSKDlrvMOWpzetIOBcsl6P/xVg2hxZJyd7YG+7/iMmm8uAl6gUt3RnczsY?=
 =?us-ascii?Q?t9X5B6iTTyf2L+x2dRKDj8RNw9T3L6L+MATs7/BMhuV+c/+hdWS2Zwn3LyiY?=
 =?us-ascii?Q?qCeXL4taX7OZWIEKVP9glCqO23Nheeu2M9nnWxAc1D9DWGrACZ11D/2R7dUq?=
 =?us-ascii?Q?GguWmZQJhjg1+jwEnsGCc41zvGMMFd2TMXcNq1fgOOmkgV9mILSEV9RdxvwF?=
 =?us-ascii?Q?QBFHN4pUxtAYZM3Ucx+rBT5a0gkIQlTun2gqIh4z7Pvu+++9qE7P3xM9AyPY?=
 =?us-ascii?Q?MBRI7+ISjQH32kCSo9SdXEGfOH4vdb5ZdLm+KzdWYiyuVw8LPdKrI+etkCPu?=
 =?us-ascii?Q?efcUjhqyx+MyoS/+WabvCrKBNgnsjFGJX8PLYGeLjRhXD5TupEeUmHm/2mz5?=
 =?us-ascii?Q?aU/xRprTZ040C88HkdrTyuhO76tju+nnWdIKp23qKwpFaenBLK0giKovI2pk?=
 =?us-ascii?Q?u3V4lauvqSgrkAYr9uhZpKVO+m0Qk9fPEKGXH00c4li34ayPjVqx/PACrNdF?=
 =?us-ascii?Q?9W98XpC4rjzHl5f4z5KFrn2PAUhQHqdlsOzUTGHYMW9Qlq+EushIzxtvpEf1?=
 =?us-ascii?Q?gp45cJ5oZGD8ngRW4o393qhfjCLi8omqoMrAZLCkcacxFDBGwlVw6C5NZ/hA?=
 =?us-ascii?Q?2hA36HdWimZN7awhZqsTtWRA1XeUz4O7I9uQR6pl9zcI8RJrW33zVRf5Z8lK?=
 =?us-ascii?Q?YZ9rUeoJZdiMtQp5ZerH8xmOuLFM1oklAPni+y3c2s7r6ikF0ND+rxYuEvWu?=
 =?us-ascii?Q?vTWKlX3evn4Vsvi9BNF7GHklOwRXBQZZfbWvW1k+?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 0de4527a-2ca8-473b-b3f8-08dd40e998ad
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jan 2025 04:50:18.9432
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ScEsq30s3sfyP0ZuTKL9LH0ZLnBIAkAuzTc1xtwhdW2DH9eod6KJX0+7rZ7lsb915jQwtaMy3F6Xlw3jTgMQ7QSOZwEcg6PBQhg0ecx7sJM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6292

> (To Tristram as well - I've added a workaround for your company mail
> sewers that don't accept bounces from emails that have left your
> organisation - in other words, once they have left your companies
> mail servers, you have no idea whether they reached their final
> recipient. You only get to know if your email servers can't send it
> to the very _next_ email server.)
>=20
> On Wed, Jan 29, 2025 at 11:12:26PM +0200, Vladimir Oltean wrote:
> > On Wed, Jan 29, 2025 at 12:31:09AM +0000, Tristram.Ha@microchip.com wro=
te:
> > > The default value of DW_VR_MII_AN_CTRL is
> DW_VR_MII_PCS_MODE_C37_SGMII
> > > (0x04).  When a SGMII SFP is used the SGMII port works without any
> > > programming.  So for example network communication can be done in U-B=
oot
> > > through the SGMII port.  When a 1000BaseX SFP is used that register n=
eeds
> > > to be programmed (DW_VR_MII_SGMII_LINK_STS |
> > > DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII |
> DW_VR_MII_PCS_MODE_C37_1000BASEX)
> > > (0x18) for it to work.
> >
> > Can it be that DW_VR_MII_PCS_MODE_C37_1000BASEX is the important settin=
g
> > when writing 0x18, and the rest is just irrelevant and bogus? If not,
> > could you please explain what is the role of DW_VR_MII_SGMII_LINK_STS |
> > DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII for 1000Base-X? The XPCS data book
> > does not suggest they would be considered for 1000Base-X operation. Are
> > you suggesting for KSZ9477 that is different? If so, please back that
> > statement up.
>=20
> Agreed. I know that the KSZ9477 information says differently, but if
> the implementation is the Synopsys DesignWare XPCS, then surely the
> register details in Synopsys' documentation should apply... so I'm
> also interested to know why KSZ9477 seems to deviate from Synopsys'
> implementation on this need.
>=20
> I've been wondering whether setting DW_VR_MII_SGMII_LINK_STS and
> DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII in 1000base-X mode is something
> that should be done anyway, but from what Vladimir is saying, there's
> nothing in Synopsys' documentation that supports it.
>=20
> The next question would be whether it's something that we _could_
> always do - if it has no effect for anyone else, then removing a
> conditional simplifies the code.

I explained in the other email that this SGMII_LINK_STS |
TX_CONFIG_PHY_SIDE_SGMII setting is only required for 1000BASEX where
C37_1000BASEX is used instead of C37_SGMII and auto-negotiation is
enabled.

This behavior only occurs in KSZ9477 with old IP and so may not reflect
in current specs.  If neg_mode can be set in certain way that disables
auto-negotiation in 1000BASEX mode but enables auto-negotiation in SGMII
mode then this setting is not required.

> > Never touched by whom? xpcs_config_aneg_c37_sgmii() surely tries to
> > touch it... Don't you think that the absence of this bit from the
> > KSZ9477 implementation might have something to do with KSZ9477's unique
> > need to force the link speed when in in-band mode?
>=20
> I think Tristram is talking about xpcs_config_aneg_c37_1000basex()
> here, not SGMII.
>=20
> Tristram, as a general note: there is a reason I utterly hate the term
> "SGMII" - and the above illustrates exactly why. There is Cisco SGMII
> (the modified 1000base-X protocol for use with PHYs.) Then there is the
> "other" SGMII that manufacturers like to band about because they want
> to describe their "Serial Gigabit Media Independent Interface" and they
> use it to describe an interface that supports both 1000base-X and Cisco
> SGMII.
>=20
> This overloading of "SGMII" leads to nothing but confusion - please be
> specific about whether you are talking about 1000base-X or Cisco SGMII,
> and please please please avoid using "SGMII".
>=20
> However, in the kernel code, we use "SGMII" exclusively to mean Cisco
> SGMII.

I use the terms SGMII and 1000BASEX just like in Linux driver where there
are PHY_INTERFACE_MODE_SGMII and PHY_INTERFACE_MODE_1000BASEX, and it is
also how the SGMII module operates where there are two register settings
to use on these modes.  What is confusing is how to call the SFPs using
which mode.

All the fiber transceivers like 1000Base-SX and 1000Base-LX operate in
1000BASEX mode.

All 10/100/1000Base-T SFPs I tested operate in SGMII mode.

All 1000Base-T SFPs with RJ45 connector operate in 1000BASEX mode at the
beginning.  If a PHY is found inside (typically Marvell) that PHY driver
can change the mode to SGMII.  If that PHY driver is forced to not change
it to SGMII mode then 1000BASEX mode can still be used.

The major difference between 1000BASEX and SGMII modes in KSZ9477 is
there are link up and link down interrupts in SGMII mode but only link up
interrupt in 1000BASEX mode.  The phylink code can use the SFP cage logic
to detect the fiber cable is unplugged and say the link is down, so that
may be why the implementation behaves like that, but that does not work
for 1000Base-T SFP that operates in 1000BASEX mode.
=20
> > > KSZ9477 errata module 7 indicates the MII_ADVERTISE register needs to=
 be
> > > set 0x01A0.  This is done with phylink_mii_c22_pcs_encode_advertiseme=
nt()
> > > but only for 1000BaseX mode.  I probably need to add that code in SGM=
II
> > > configuration.
>=20
> Hang on one moment... I think we're going off to another problem.
>=20
> For 1000base-X, we do use phylink_mii_c22_pcs_encode_advertisement()
> which will generate the advertisement word for 1000base-X.
>=20
> For Cisco SGMII, it will generate the tx_config word for a MAC-side
> setup (which is basically the fixed 0x4001 value.) From what I read
> in KSZ9477, this value would be unsuitable for a case where the
> following register values are:
>=20
>         DW_VR_MII_PCS_MODE_C37_SGMII set
>         DW_VR_MII_TX_CONFIG_PHY_SIDE_SGMII set
>         DW_VR_MII_DIG_CTRL1_PHY_MODE_CTRL clear
>=20
> meaning that we're generating a SGMII PHY-side word indicating the
> parameters to be used from the registers rather than hardware signals.
>=20
> > > The default value of this register is 0x20.  This update
> > > depends on SFP.  So far I did not find a SGMII SFP that requires this
> > > setting.  This issue is more like the hardware did not set the defaul=
t
> > > value properly.  As I said, the SGMII port works with SGMII SFP after
> > > power up without programming anything.

TX_CONFIG_PHY_SIDE_SGMII is never set for C37_SGMII mode.
Again I am not sure how this problem can be triggered.  I was just told
to set this value.  And a different chip with new IP has this value by
default.

> > > I am always confused by the master/slave - phy/mac nature of the SFP.
> > > The hardware designers seem to think the SGMII module is acting as a
> > > master then the slave is on the other side, like physically outside t=
he
> > > chip.  I generally think of the slave is inside the SFP, as every boa=
rd
> > > is programmed that way.
>=20
> I think you're getting confused by microchip terminology.
>=20
> Cisco SGMII is an asymmetric protocol. Cisco invented it as a way of:
> 1. supporting 10M and 100M speeds over a single data pair in each
>    direction.
> 2. sending the parameters of that link from the PHY to the MAC/PCS over
>    that single data pair.
>=20
> They took the IEEE 1000base-X specification as a basis (which is
> symmetric negotiation via a 16-bit word).
>=20
> The Cisco SGMII configuration word from the PHY to the PCS/MAC
> contains:
>=20
>         bit 15 - link status
>         bit 14 - (reserved for AN acknowledge as per 1000base-X)
>         bit 13 - reserved (zero)
>         bit 12 - duplex mode
>         bit 11, 10 - speed
>         bits 9..1 - reserved (zero)
>         bit 0 - set to 1
>=20
> This is "PHY" mode, or in Microchip parlence "master" mode - because
> the PHY is dictating what the other end should be doing.
>=20
> When the PCS/MAC receives this, the PCS/MAC is expected to respond
> with a configuration word containing:
>=20
>         bit 15 - zero
>         bit 14 - set to 1 (indicating acknowledge)
>         bit 13..1 - zero
>         bit 0 - set to 1
>=20
> This is MAC mode, or in Microchip parlence "slave" mode - because the
> MAC is being told what it should do.
>=20
> So, for a Cisco SGMII link with a SFP module which has a PHY embedded
> inside, you definitely want to be using MAC mode, because the PHY on
> the SFP module will be dictating the speed and duplex to the components
> outside of the SFP - in other words the PCS and MAC.

I do not know the internal working in the SGMII module where the
registers may have incorrect values.  I only verify the SGMII port is
working by sending and receiving traffic after changing some registers.

> > > There are some SFPs
> > > that will use only 1000BaseX mode.  I wonder why the SFP manufacturer=
s do
> > > that.  It seems the PHY access is also not reliable as some registers
> > > always have 0xff value in lower part of the 16-bit value.  That may b=
e
> > > the reason that there is a special Marvell PHY id just for Finisar.
>=20
> I don't have any modules that have a Finisar PHY rather than a Marvell
> PHY. I wonder if the problem is that the Finisar module doesn't like
> multi-byte I2C accesses to the PHY.
>=20
> Another thing - make sure that the I2C bus to the SFP cage is running
> at 100kHz, not 400kHz.

What I meant is this Marvell PHY ID 0x01ff0cc0.  Basically it is
0x01410cc0 for Marvell 88E1111 with 0x41 replaced with 0xff.  Some
registers like the status register even has 0xff value all the time so
the PHY can never report the link is down.



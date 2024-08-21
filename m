Return-Path: <netdev+bounces-120448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CE695966A
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 10:22:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A15FB1F216D1
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 08:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 584D61ACDE6;
	Wed, 21 Aug 2024 07:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="KFZInWNd"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2042.outbound.protection.outlook.com [40.107.237.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEC981A287D;
	Wed, 21 Aug 2024 07:56:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724226963; cv=fail; b=ViPw+KRGfcclFqm4HdOD1L+pawNfgSwjQgdV/kCb+9jYmSxohLXX7FNEiC+N9oZ5QS8OP2/w9PSg3owd/0wQ70xqX5eNw2aSddiKccskQ4wViVZUvpNRW2PCqX1Dp7y7AMvBmm+D8TxzvDBXDkIZts/Kxlf8jCk6KERcCTeYSrU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724226963; c=relaxed/simple;
	bh=0/y49xbgRYjx24gB/f79oG3jGsIlbzr/Yu+0XinsxyA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RVTySvv/AKTuYdUv2awnKW2U99PCRMVc1Pf/caUiY6ouRo0t1C19tPXlG1Cxqj0NrM9j7wNVruETrvVNZy2uAqHtwwX4vndgeDTxOOsCBrLrn06alrXV5LjTNAyqbclf6bHEZvZ9i6GRIuwEQ/QRSkyF+ehROiSm6NP6/OxOZc0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=KFZInWNd; arc=fail smtp.client-ip=40.107.237.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I2v+Ptsb+n//DbQ2NYezllP15jGL4UojtKpZwNr3PARmxpSup/Iegh2nd5vRg/6n+lvuXYW9nItWgmkkt7zfo49bQbiVYILX7tvsbMn+tdEHAExSYFauJSjV96dfz3BLxg1/ZmJQ7ul8Awc2lQpxiIGsqzC86o+Cm00ooyCFiZpyQqHzDoHDSlSBZSNnLV7YHukBU43l02xvyyKEj6iH5Btubi5t5ayA+qd/RYhkYJgeqyZKMB4cybrj9LLji9XU5z6ei/G63HN4xNPoo/vPKDuB5ezJo79p/G5HOLE5NHKuefoPB6ADf/HzKua4xOvjfTXZmR45EZ0ed0LZUi/YGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0/y49xbgRYjx24gB/f79oG3jGsIlbzr/Yu+0XinsxyA=;
 b=zDK9OgBMfROg+pdXs5Ms5lr8oVqvQzr7/CxlrDlqFPFnI6LYTPK07Vi1m8bFVyhBgvx+R0sSrvdWYyFyH++mYOYn7VQ27kVyFI3luAmGJRXNPBG2LQE24ceRNqsI9uZkZH9bILz4EdPUehnZjihf/TFWFKwYEtDxZl827ErFMxQDd0hh9a/PfbEBXopK4LM3AItM+bc5QGUh60JEufMy4QLFkRKud8+Rtq7iNzINimgONCoO4RwmZ1yDYD0x/N0QFIxlSteyBUjoGGMr3C4klN2fYeuKR2ttrdkj+Umx6uSGrXFQfUpo0z550NomukWaA6PdGf/zeApdHkyQEn3rLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microchip.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0/y49xbgRYjx24gB/f79oG3jGsIlbzr/Yu+0XinsxyA=;
 b=KFZInWNdlNXBxYQegPVr34cj0iBx8xzS/EFeMSPa2YNhotX+JQJhQ0IY/jwgTzdERDgm7fu69DpKWoNVTcJLE74ana7HfBe00BIY7N0LyeUyMaLNtVkNh5aH6QN5fZ40XomWiex/5uc1QrSv/ZRdu4ajYBojU6K3jA6MgExYv4xg2ORC2DFALPyaDrzgj2gHIKqn72mLZMSsIZHEuFahXHFDgoroChCv6yYDZNzIythuHs4TS2qLOKtmIb5R/RYc1JkmTeBWuVockl6ceSQwXT78PTzzBpg9kacG4k/paNgIjRrKWTR4daFGfnOWkShxGeTiXGFhdDhlBM9amlN1xg==
Received: from LV8PR11MB8700.namprd11.prod.outlook.com (2603:10b6:408:201::22)
 by DM4PR11MB6525.namprd11.prod.outlook.com (2603:10b6:8:8c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.17; Wed, 21 Aug
 2024 07:55:56 +0000
Received: from LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::a624:b299:5062:5ab0]) by LV8PR11MB8700.namprd11.prod.outlook.com
 ([fe80::a624:b299:5062:5ab0%6]) with mapi id 15.20.7875.019; Wed, 21 Aug 2024
 07:55:56 +0000
From: <Raju.Lakkaraju@microchip.com>
To: <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>, <linux@armlinux.org.uk>,
	<kuba@kernel.org>, <andrew@lunn.ch>, <hkallweit1@gmail.com>,
	<richardcochran@gmail.com>, <rdunlap@infradead.org>,
	<Bryan.Whitehead@microchip.com>, <edumazet@google.com>, <pabeni@redhat.com>,
	<linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH net-next] net: phylink: Add phylinksetfixed_link() to
 configure fixed link state in phylink
Thread-Topic: [PATCH net-next] net: phylink: Add phylinksetfixed_link() to
 configure fixed link state in phylink
Thread-Index: AQHa8fh4uC5D6kLwpk6HNkOhh85KxLIuxGuAgAKU2AA=
Date: Wed, 21 Aug 2024 07:55:56 +0000
Message-ID:
 <LV8PR11MB8700C786F5F1C274C73036CC9F8E2@LV8PR11MB8700.namprd11.prod.outlook.com>
References: <20240819052335.346184-1-Raju.Lakkaraju@microchip.com>
 <20240819162353.GJ11472@kernel.org>
In-Reply-To: <20240819162353.GJ11472@kernel.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: LV8PR11MB8700:EE_|DM4PR11MB6525:EE_
x-ms-office365-filtering-correlation-id: 1634ae7d-637b-49e9-184e-08dcc1b6b061
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV8PR11MB8700.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?wQUasuaTAJf41COHfCXvxuIDrck1xs0sWh2n5VV+SUK5lAQ3V1MmmGXWLyrc?=
 =?us-ascii?Q?jfoGjLc0KDR6YwqnaUM12uaoWCvqM+nWsmmA9aaUaGypJx7H4mNt3kkGVbBm?=
 =?us-ascii?Q?uNdfDFkBHgNIWaz8oCzkUi7lGRl/m/43CH0TjNpXX0C7PXnjBzHnrHl42Gfh?=
 =?us-ascii?Q?BQaLb+FUiYs/TKTmrIaDhjVBeqC87XVkdvGIsvKjqLmTMrnMaebA05LDJ//k?=
 =?us-ascii?Q?QXArPwBVjZvx7eBQXtu25c00xb4yD5sBGiTsb2A/wVeee7ZUbPkX1/MIhT6y?=
 =?us-ascii?Q?OfdzjokiX74B1BdEsRsoXHS8DIYz6EY6URV1YAspi3hY/kUvsewCCuBwSq0K?=
 =?us-ascii?Q?DuYYrkxx0+YXGTDILJgGOWa2evw96rq47LY0Rufa++9mZfr/fQ8D/9wWx5z/?=
 =?us-ascii?Q?OfMlaUWG9kQXaxbZgBGOZaZRjgHajzkcZC5dCEYg6errLcfjnJQgye0zdFs0?=
 =?us-ascii?Q?MGg/fqCAbnD7/rj5OhOka22YH+6VKUcnI8mp4ZsKEQaHLUjyPcBk6SPi6Zb0?=
 =?us-ascii?Q?ELOH/3TjIMnwHql5TiXxfbQTaUcvGjPwJClixaXb9w7W9GCYii162FvCU+Y2?=
 =?us-ascii?Q?yYVfIAn/5Kz84GZ4zGzf/LHQ4l8IwIIYmorbnfJXSCTw7f9dQFoCEz+Z+8kh?=
 =?us-ascii?Q?ijczgVBhlp/AnscgFRgbr+scWDiTFGh5X9Ui+I+idVyxPjwORogoRWy+2jJx?=
 =?us-ascii?Q?44WsrTWzaNJQ0Z0kohQevNj2e3+Ugg+0X667ox9UYg+sKyRUzzReVFIW4qre?=
 =?us-ascii?Q?p10jWr7pJGHpv6TZoEuN5EWGLVQww2AMuG6eRg4I8Rhw/w+3ILoxqI5QekQZ?=
 =?us-ascii?Q?4MqHlT+rTZTLmyxIkugFJCY1yBtjLD6qlkUE68ssFTaq4FVsIptteBOUHZdY?=
 =?us-ascii?Q?qclIezAoE02sBDLo/UJ0xjgCEBHl5O1DpSz0GguBn2toRhzjOcBZgLXlG1nT?=
 =?us-ascii?Q?eO43gcBiFIFaMih1godP3OskURpkRq2DGRoy7TDgSOGhcBJrZwB7Lt6TW8+V?=
 =?us-ascii?Q?4Qf67Op6HjmEW5vAHPHj4fu897t1/TLBsHVmZQGmeunR57vDN4xyO3GaeacU?=
 =?us-ascii?Q?sJoEqG8G0DpOQVHz2c+sXTXpp38s1YIsqWF6+eFy8umZvEXlvuRgUc/tlp+X?=
 =?us-ascii?Q?LrR7BV7s20u21ea1Nu9GwymXlluNtNsdHE9PZNwApqdTRideeTdU+Y9Xn2rR?=
 =?us-ascii?Q?SfdYKERZm9HRkPaF+Du3vhdQt888GzC8o79rPqAfQyQ4C7WO1Bk1NA4o1L2y?=
 =?us-ascii?Q?a7Gce6CEZZppCiXz+7g97JEYdaXHpKCvXb7drshY65PErqGo4L48x7MYrlwh?=
 =?us-ascii?Q?ZANeFSrSrh6mEbjwq6lSD3lpZrSMETD4/fdWzUuko2BvMDvsXlcx7Gp68jrf?=
 =?us-ascii?Q?LGmTf7Y=3D?=
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?qoCmC/jM3RRi5nB4BXAmya1fwvhTQLfWYg1+V4WBOWBjpV7ONx9Vy4hKwuRO?=
 =?us-ascii?Q?k4dsA2CBBIU+qNmYgqPDsJoBs3/6GYs3EpJfoTaUM1K2AEscj3V/D8Moh+9e?=
 =?us-ascii?Q?UUOD77RFx4hD2PZ8TW23Iigt1d50G/eV048Ujxku9GKdcz+qm0wYDcSOaqcE?=
 =?us-ascii?Q?xx6GN4BDbLrxi3xzcGlp0FiiLxc95QQILYEipYkG141KITfCJsnVLfUJeR+a?=
 =?us-ascii?Q?8ZhRImYOViALw6YynvUAIJ7+8fu7OIhstIOLBiwePcDJPMs/y0rYYKO3kw9T?=
 =?us-ascii?Q?s7E1wpPQW4sJUO6L5FbjoNXtVTXGVvXkIESnTT2JaIXNJbfMYDGdEsQFQyYK?=
 =?us-ascii?Q?7g97fPY64WdxgmrhuUg3BZuCBxtaROjMEKq1TJFQ/hKxSE7l0UfFvk1zbfmz?=
 =?us-ascii?Q?Ml3qElrn7fakzSlHpW4dXOvI7oZQtl8b+TLR6FD074BMhLKWhMQFSzT7g86z?=
 =?us-ascii?Q?85vNb6aNjuYlyremWMy80ReMVUoe7gisCY3CxmNY/DAodkrpLPKyDOaK0fZF?=
 =?us-ascii?Q?ZuMSA94pPqcXgLOwt5mfYfSEIw2P3WN+kDk5jNuAWfO2VLcBeoEC3GU98ip3?=
 =?us-ascii?Q?Gu84v0l8WUxvfMGdsI/AJVETg3BPcuGkjC5t0XwPE7KlTqPamNw5QXbqZzWz?=
 =?us-ascii?Q?7Ap58asAUQJ535rj0yabOdjHkKlXRF5eTzD0zgT+5A5HlbheZv2bM7uh6ar3?=
 =?us-ascii?Q?0swwMR+y32ldums9t45G/VNnzlQfBIWSzw0CHXnptHXtdkYBwdGCTCrUvK94?=
 =?us-ascii?Q?15ct0WKB2yY9dDPIyZZrgUT2pdcoGvckrmnwVyVsQWQktPENPbhFsG56c9G1?=
 =?us-ascii?Q?pV4HIzRTRS+CqXKHHCAEQ6ZmfjRJ5OKGq+qQBTY1P+bzjtr1dSfQRcloteK6?=
 =?us-ascii?Q?tIdiqLXn0v1i7vus2Y4KXuSONGC1I+1Up8lzhzN2EAHs0Z9+Rg0fcbmTt+Hr?=
 =?us-ascii?Q?fnrCSSwSiI7WFvvUWsMj1iTbrndkC/lVDACYGDAZ6k18GSbqxesXuhbn4pcw?=
 =?us-ascii?Q?EdcpCpsAA8z3vm4x7SjJr+pmaNTJ45EdzFSefr9krarCXXkYgkdsr1qjANDC?=
 =?us-ascii?Q?OEdKllYEl5EbOeoyMt1P2sK/lZc1AAYZNfX2q8esuxtk1lbJcxIjqu9+M3HG?=
 =?us-ascii?Q?pqkshGUqCRn8FsJd+sAovt2PGXX2jYAFhVDmfn1v8x9pv0o/uWCRTRcKjOvX?=
 =?us-ascii?Q?hSiO89R3r6xKSoFrNzh5eJoHddlw4l9axekGstmc//y5AuHNsfMZ+PTFmh8z?=
 =?us-ascii?Q?8eK67/uJY2WpNR92uQDy3WhcO63r+YOkC7EfZPRZxAEeRUNzrdPATjyZlTHT?=
 =?us-ascii?Q?rsVUk7rPHEnUWAnyKKNwCzxgSg/EOtu7gN6b9yQ7e2TGmexYr4MWDNaNTpHi?=
 =?us-ascii?Q?7TuxH9XvbPjruoFdPxxDqmwJvdK+VqM6ZAEhNHH0wNP5AIm0fCxuytvBYMvn?=
 =?us-ascii?Q?nkjQaUhoTOtHrQ8j5x+bavWjQDvc5iExQcGFlFn+GCntmmv57hk8m/ds7Xdi?=
 =?us-ascii?Q?s9sW7+zAO5NbsY9qHJhMEFQGOrClTemT17cWfTxkZAZsWbR9aarfOBk80eE4?=
 =?us-ascii?Q?kdWq7XNK5cN5/Je6UnVUjv+o583hdWfdXI2T25JE/k/c6LBaFbmSClkRDLUU?=
 =?us-ascii?Q?Hg=3D=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: LV8PR11MB8700.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1634ae7d-637b-49e9-184e-08dcc1b6b061
X-MS-Exchange-CrossTenant-originalarrivaltime: 21 Aug 2024 07:55:56.6771
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HkCXYmUfULs7y4H3rttj/CwLsgPQDQcOQzMndLZWcAlqva51Cw5DCQHDwCcPdjXPAM7Fkw7mJMAepmpsMMuL9rzQ68LPrcr/36ysY8qFuh0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6525


Hi Simon,

Thank you for review the patch.

> -----Original Message-----
> From: Simon Horman <horms@kernel.org>
> Sent: Monday, August 19, 2024 9:54 PM
> To: Raju Lakkaraju - I30499 <Raju.Lakkaraju@microchip.com>
> Cc: netdev@vger.kernel.org; davem@davemloft.net; linux@armlinux.org.uk;
> kuba@kernel.org; andrew@lunn.ch; hkallweit1@gmail.com;
> richardcochran@gmail.com; rdunlap@infradead.org; Bryan Whitehead -
> C21958 <Bryan.Whitehead@microchip.com>; edumazet@google.com;
> pabeni@redhat.com; linux-kernel@vger.kernel.org; UNGLinuxDriver
> <UNGLinuxDriver@microchip.com>
> Subject: Re: [PATCH net-next] net: phylink: Add phylinksetfixed_link() to
> configure fixed link state in phylink
>=20
> EXTERNAL EMAIL: Do not click links or open attachments unless you know th=
e
> content is safe
>=20
> On Mon, Aug 19, 2024 at 10:53:35AM +0530, Raju Lakkaraju wrote:
> > From: Russell King <linux@armlinux.org.uk>
> >
> > The function allows for the configuration of a fixed link state for a
> > given phylink instance. This addition is particularly useful for
> > network devices that operate with a fixed link configuration, where
> > the link parameters do not change dynamically. By using
> > `phylink_set_fixed_link()`, drivers can easily set up the fixed link st=
ate during
> initialization or configuration changes.
> >
> > Signed-off-by: Russell King <linux@armlinux.org.uk>
> > Signed-off-by: Raju Lakkaraju <Raju.Lakkaraju@microchip.com>
> > ---
> > Note: This code was developed by Mr.Russell King.
>=20
> Hi,
>=20
> I am wondering if we need a user of this function in order for this patch=
 to be
> accepted, as is often the practice for new features.

This patch is Mr. Russell King's developed code which I'm submitting to Lin=
ux community for review.
just following Russell's request.=20
i.e.
https://lore.kernel.org/netdev/ZsCMtARGCOLsbF9h@shell.armlinux.org.uk/

if it is required, I can send both together in a single series. Please conf=
irm=20

Hi Russell, Do you any concerns about Mr. Simon comments?

Thanks,
Raju





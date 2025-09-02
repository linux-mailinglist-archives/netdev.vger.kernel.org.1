Return-Path: <netdev+bounces-219097-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1053DB3FCDD
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 12:41:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 051673A84D9
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 10:40:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D8E2F39A4;
	Tue,  2 Sep 2025 10:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="t2blhYa1"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2044.outbound.protection.outlook.com [40.107.223.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70932F39D4;
	Tue,  2 Sep 2025 10:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756809585; cv=fail; b=RxLY/4uzo5bQrTB2DReQQUx6Nk5bpcw1CM4Wd6DX0FO3RohLrXwxbXKffPTOc+SFpdoHh4vqKtexd1wp45jb+Azp7xGy9NO75gbTx1uOuv9gf0AMANfnQKHyov7PcuMxEZsOWvnruIIFCkWddCbcyVWlSxMdQ+ELB0FrWieAwEU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756809585; c=relaxed/simple;
	bh=3lGJc328TTFeO9/vWs6vXGifKrQ7eS8wZjvk4QvXZ2w=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oL4DtKlv3llLK3YrbndwWBbCRC9DEWHHYDMtWKLcWQS4TV+/94KJzBkXFLZiCOYASR7uTyREDv3mlGo25DPLgo4oFB/330W6HAtjuq7f0qLyWjTiAh4HfBxCJvYWyLjV+mWZZNtw2ei8WXNB8X2BGvflnjR7qy5PgLSKIxilrbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=t2blhYa1; arc=fail smtp.client-ip=40.107.223.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rdk2PavlE/C5GPm6VyniZjKV3Yf3xZ0ZFo0s4QwTGn4VpFO7ZmpcFgF95R6WpFnJijNAB9kaE3jy9GZSWdCtONY/wlax8lk5HI6ej5JfHqGbq4o/57XK7YengmJMTzCgngG52pOwBa5mWTxDHOtReYVI0Gnan6YKUbZ3NuStO5IRozVQp+MZ23vVmcvexfYxdxrbT7EkPrST6P1p6RVEQeAh/TiGhyEV8S4gDgNhbbKlXe9qXedi/9iOVmvASxDdmR+UP9UGi5KOuT3fa3btcEQTcWpHCR330xHan+UN2jdmm+wqPtq53glDIEqlt6F3ocpaEnaD1i37cgt3stmASQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CgHp/8tErfDXld4APtcWEQmQ1fpT/tdRRUEmDFp0A0s=;
 b=RT+YtOU3PzIojBV6PDZm9hSRNszi9PzniW8pL3KOvFA0/m0qLhQvE76ok+7C9vD1ZAq2oHLSgpDqMTijG06nYb2YpEb6H+NBv2dkmLaMsR3yU2olmHcfjgYt/C+vW4EzG1oYixdGSj+98ujROs58z4cXBjA77iWo6tkAgEmjmLLH0aV5gncUwrjfPPG+i2WKY/lvnXTDNMltYxnYmOm4B6Tw1QyMofMBW8nPATdZT1xItTT1DkWW8vUUrnHqWD2hES6zqaU5NDQrtu+t79iVP/JHvOnqsbt3vSXEOmZEFGKNSkM/P+2ecBvCbiv+HQ5h+62oUGYYAkg9Z3qMvH4u0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CgHp/8tErfDXld4APtcWEQmQ1fpT/tdRRUEmDFp0A0s=;
 b=t2blhYa1g+qqU/5Yugj7QL4fesHA2K/yZCqXNg1P4SaLglghkoZCbvbfuyPIvaIH5TWxkvLP1QXBCF4fVw3/nVni0clWfirXQL7g7MccvAfuoLsO/CrcqD+Ak4pT5iHKHRo3tN5G8ERit0fAgEsgNg1oHxwnAMO87qSh65t4sASqujGyLF3kpK660aL/d6C705OsxkrKmRU8trLA2loDAL5+DW9EUE9CQ9OQUIq8rbWgNWSH8pq+e3Y2JQQKRR21Ifw6FSToGXJcn1kj8olzkjvmBmLJ9Cub0NJsLqQkHkvC6G2nztso2Uoy8p39gdAUXWdhDMJK9V9mKhV9AX2Wew==
Received: from PH7PR19MB5636.namprd19.prod.outlook.com (2603:10b6:510:13f::17)
 by CO1PR19MB4933.namprd19.prod.outlook.com (2603:10b6:303:da::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.27; Tue, 2 Sep
 2025 10:39:38 +0000
Received: from PH7PR19MB5636.namprd19.prod.outlook.com
 ([fe80::1ed6:e61a:e0e1:5d02]) by PH7PR19MB5636.namprd19.prod.outlook.com
 ([fe80::1ed6:e61a:e0e1:5d02%7]) with mapi id 15.20.9073.026; Tue, 2 Sep 2025
 10:39:38 +0000
From: Jack Ping Chng <jchng@maxlinear.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"davem@davemloft.net" <davem@davemloft.net>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>, Yi xin Zhu
	<yzhu@maxlinear.com>, Suresh Nagaraj <sureshnagaraj@maxlinear.com>
Subject: RE: [PATCH net-next v3 2/2] net: maxlinear: Add support for MxL LGM
 SoC
Thread-Topic: [PATCH net-next v3 2/2] net: maxlinear: Add support for MxL LGM
 SoC
Thread-Index: AQHcGONYZdoM3BaqikyKYzM9KF3Q4bR6E/UAgAQAW/CAAD2rAIABUPVQ
Date: Tue, 2 Sep 2025 10:39:38 +0000
Message-ID:
 <PH7PR19MB56366632D5609B0B51FE8939B406A@PH7PR19MB5636.namprd19.prod.outlook.com>
References: <20250829124843.881786-1-jchng@maxlinear.com>
 <20250829124843.881786-3-jchng@maxlinear.com>
 <65771930-d023-49e1-87a7-e8c231e20014@lunn.ch>
 <PH7PR19MB56360AF7B6FCB1AAD0B27120B407A@PH7PR19MB5636.namprd19.prod.outlook.com>
 <398ad4b1-1bd3-4adc-8bda-5cc8f1b99716@lunn.ch>
In-Reply-To: <398ad4b1-1bd3-4adc-8bda-5cc8f1b99716@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR19MB5636:EE_|CO1PR19MB4933:EE_
x-ms-office365-filtering-correlation-id: f8b9c08b-9b6b-45fe-4da1-08ddea0d047c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?c3AQYhDrklb5Vfx46NtbG894gc0rmFIuSQNuu5MAKG1lB2YVCf5rIk9ALOrv?=
 =?us-ascii?Q?lu9zCFH3i5rjXtJNzTf+6e/cDB/K9jVCZroGBKYENVSl9kGPJQrwAMLr6aij?=
 =?us-ascii?Q?2lBOU4DR0bsTBZuRT7wSkmSz7q/ViZe+vwDfOHyiVcIIkcVNpbSfPiv5OiRI?=
 =?us-ascii?Q?iY3WyePkZyNn8zaBBExu7eIZXphqQQpsYI4b3xRB+IqgEn4TEgFPJkr8wRg/?=
 =?us-ascii?Q?WfcgMkPMdV/mfZiMWyCJv/Ctr9hHxVGvMh16hZCDqb4+mRcZByT7GnnXRhO6?=
 =?us-ascii?Q?pUdYi/ExJ+J0IZpATbRkR8aNBx3Gcmq4n2087R+37JJh04oNrqyD5Q6+3C4U?=
 =?us-ascii?Q?G+47cavQAyrqcrIClsxPY6sqKJh/8saC6DxNhlqt3fNixWJ2uLNo7TQA1Ucs?=
 =?us-ascii?Q?IWsKBU1I1hJPhHgH51G6fETxh1IMVVsNsY8ntzGyOjekGzQEsHhKW1dj6xVM?=
 =?us-ascii?Q?GRjL8wD9hf762mesoWOSc475CUcwh5P+NWbQUZWXhXNIcuVd4yWOFgWD2yIQ?=
 =?us-ascii?Q?oxViDahbxpHzAfSLoh3El4PLQ8qTBUnkqVgeZ90slQjf1UZNjEUdb7FuDwuO?=
 =?us-ascii?Q?HKjqZCNiA55aoUuR7znzchdkTVqQFq5xMm8DDpI+NNX1ZRbo97JUH/TSmExN?=
 =?us-ascii?Q?hkrLKGDXxYpmvX/5bt9LAg2ME2F6SCJLl90U37NrHj5fg58ly8EINEDgiZTw?=
 =?us-ascii?Q?8/9q3LfgQzoVFBPg96wf+XxDieeI2QqZI2E72l+unLh9W0u8nfsF5zVbrld2?=
 =?us-ascii?Q?SZ8psbx3eW8oPYeAZEj/rdJDfuV3fMiJXh8Y8NlFUA0YOZHOgvnAyy1CRMlj?=
 =?us-ascii?Q?iAGrWazuGfwXWldT5AXsA68IIG8DQzIuXSP384nUuSeXF5xtUetQ8pBfvLX1?=
 =?us-ascii?Q?1UtfHPIMHDwMK9ffNo7OgXWwq3qXxJKEZElFnWFHoXdzInAHLN2M6m1F+xGM?=
 =?us-ascii?Q?OWEsBL86SrEYOA/yaMc0WWpXfIjr096IUWXJA773W8rFbWDlikfsaWsldygO?=
 =?us-ascii?Q?fQpQPcnRJdy9HqKAlnR+onzH9iEBCwF+uR/tOMYjLTnVe0S171sK4grdnUrB?=
 =?us-ascii?Q?Fnah8o/KL0sk4g2qfSq+68sJR3dRflSnO5j2Lm9cxTqWe0bd26MEHXEk9JBc?=
 =?us-ascii?Q?ZrsXuh0TJVtAdx4oK3BMxgy9PodyfU5soGMNSecpLNyekEP8OlPzsXj6DAya?=
 =?us-ascii?Q?oDsx/8oIsCrn8lKDiHGt/CxZ/AkLmNwIXnYKMcWxEofuxBAcRNwofG4zK35j?=
 =?us-ascii?Q?KghTdBFJa6KQ9SrMHxUwibwo0IShvpMWX6vOUlThxO/KBoKjZoD1YpIQL2/X?=
 =?us-ascii?Q?d8so8lvUHC1K9cG7gSgFEGfamMR/BOiGD4NR9xFa8pd1quG8jQ0/MD1s6rzb?=
 =?us-ascii?Q?UlQIr/5duRVGhPQbgmHMtxAeaisGnlRBB/OebdQYcCJ09FNnLtyj9A5SKvud?=
 =?us-ascii?Q?QWQ8Iya9/eR3Q348/7TKFZCXrp8ajoCUhRic4Wy8uUs/5gZCsFXbCg=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?lebemE9cSBZkL292wMoTH9XDyXbU33bQ0W/4mJGzLwPzyNaMToTKIgU74Fpg?=
 =?us-ascii?Q?zyLTs0n4RhRzSOaE7Oxs64mqbRXWaj9ivgG+1LayUkUzjmQBIMMYQOihGiuE?=
 =?us-ascii?Q?uNzOid4jyZaSTa+niUNN6zX9JSjDppmOrkTAKwMrpIzOY+hXw6vWWtztETp9?=
 =?us-ascii?Q?kbzQKK7Z1M8s8Yq18EDyB3CsUk0stpXI3pLB6pXxo1tyWYG84o93shQEKgiP?=
 =?us-ascii?Q?+zg/FOqOL7squxJwbwn3DzsXZGJUweFjrV2op3NhkOWe2pBW8lU5uYL3ADlk?=
 =?us-ascii?Q?pavXDf84wU0arNF4yuKmS1tKidLWJ5Q1cTptEnnVKOmKj8Ou50THRXwIx1s9?=
 =?us-ascii?Q?nw8CHX6vKHfglvBfh/9aw9eWUhcW9xg73ZiiMKYhG/CGBKjUBefA2t65V6ua?=
 =?us-ascii?Q?2d2/RyeQatN0HZDKyw2D3phmQBKBqptAgN7pnHKm6ilOmhTgxNgcKdnSgUm4?=
 =?us-ascii?Q?+YFX2xERhgEM6JslRzIYHlm6rTjZtSIhzI+8lUVhnQ15tbBdxTjOe9pdXI5L?=
 =?us-ascii?Q?zT/9V+EFW03hOgqBs0/9iuf5Outwo3y6e+lkoJIjDqE+d3SpYEX9vc6F2b4Y?=
 =?us-ascii?Q?VWSKUVjBgpbNIRJvHltHsYPGRjxpA/OyqjNkhQQ7bS7NniMDmFCx67hpLuxr?=
 =?us-ascii?Q?kYeYsJO7GrF3NKpHTPthcD3tmi6CTYfu4RM8Mqdp9bvfOt8Eq44DIgXXMl8Q?=
 =?us-ascii?Q?rmZaDLiUCEk4vdLI2e0WhB1mTarOO4Sr9iQH9e337o/te+vvQFduverQ8N6z?=
 =?us-ascii?Q?VXL01NowXIq2QOF0yRaJHDLkzoPy69WuNO/Fh78b4mN1oRsV6BymhvMCPMaB?=
 =?us-ascii?Q?7GNnXmFRhBRgWcB/LTx6IruTBUjHAwSXqkb7FRMAXHHmTBBFF+Tu5RM450Jf?=
 =?us-ascii?Q?yMC0rk9Hv1BM+DPl1d/wU9+MKwiPerSMpBaha1GMxBB666Bbte2V+uSkIiUZ?=
 =?us-ascii?Q?FjgDjsVDmbliHuUfomcsunlX3BmMdwMFrLXexRxI+WZPMdrPajFr7YNFHID6?=
 =?us-ascii?Q?hRkvVp23mfBigubNHp7hNuD4J3kG4zXIUeRCIKHfk0kHVe1VB/dDWHZfauf4?=
 =?us-ascii?Q?vYNbGNmOlFctGIj5INR6vFV1gYYy8qplBvtV55C6v470wliDxvOr/jFpg3ur?=
 =?us-ascii?Q?DoTy+jkLCyTGI9a7/Xe2jVWKw+b2iW6dn90TyCnF7/TuXcWG9vSpSAjIR6WJ?=
 =?us-ascii?Q?dp4KC0AKH5CL4GJqhz6R39briUDzt8T48WdshzpOOpcDkCo/PRCdnFyrAshZ?=
 =?us-ascii?Q?E3HL7VZUvrGEuLKUK7aqXDN4CxHccoo87Yv5dpIfxs0vbc7gcjiBXOUmlZcj?=
 =?us-ascii?Q?CCCnER5uxq7t7fmV6bChS/2zQbYpErItOupPE/lX3R+h+GHq/R+8e8kMS7PC?=
 =?us-ascii?Q?SBlGHcbefQjd6ofHMkn5hydjQGS8BPEmq/a1oFNmUbdS/xrz72FknfiwYnEX?=
 =?us-ascii?Q?hwVarItQgEtBUGstC+n34KMAQpj0I7J8JJRMQfk918dcZZYJuCYuizK4+CLb?=
 =?us-ascii?Q?sbmc6XhRsdp0q005Hxg8J+cLAJnJ6OvYz3UK9r9tR1jaPnAfxTdhZkPkOUD5?=
 =?us-ascii?Q?Cwk9OmCeWK1ArtFVebZn5grWlEN2elI14QAJPX6n?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: maxlinear.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH7PR19MB5636.namprd19.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f8b9c08b-9b6b-45fe-4da1-08ddea0d047c
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Sep 2025 10:39:38.6611
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: cO6lyeEtuWVJQC0g/eM9SRBFswBhMOFZpVNL2fcebb1s+OlbQeWp2MkdWp3bXUj5ywvxhVMXeXQxGIwLCeakNA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB4933

On Mon, 1 Sep 2025 15:11:08 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> On Mon, Sep 01, 2025 at 09:38:44AM +0000, Jack Ping Chng wrote:
> > Hi Andrew,
> >
> > On Fri, 29 Aug 2025 22:24:06 +0200
> > Andrew Lunn <andrew@lunn.ch> wrote:
> >
> > > > +This document describes the Linux driver for the MaxLinear Network=
 Processor
> > > > +(NP), a high-performance controller supporting multiple MACs and
> > > > +advanced packet processing capabilities.
> > > > +
> > > > +The MaxLinear Network processor integrates programmable hardware a=
ccelerators
> > > > +for tasks such as Layer 2, 3, 4 forwarding, flow steering, and tra=
ffic shaping.
> > >
> > > By L2 and L3, do you mean this device can bridge and route frames
> > > between ports? So it is actually a switch?
> >
> > Yes, the SoC does support packet acceleration.
> > However, this patch series primarily focuses on the host interface to d=
eliver packets to the CPU,
> > where bridging and routing are handled within the network stack.
>=20
> Linux has two ways to support a switch. Pure switchdev, or switchdev +
> DSA. Which to use depends on the architecture of the device. I would
> like to check now, before you get too far, what the hardware
> architecture is.

Hi Andrew,

Thank you for your valuable feedback.

The switch core hardware block is part of the MaxLinear Lightning
Mountain (LGM) SoC, which integrates Ethernet XGMACs for connectivity
with external PHY devices via PCS.=20
At initialization, we configure the switch core ports to enable only
Layer 2 frame forwarding between the CPU (Host Interface) port and the
Ethernet ports.
L2/FDB learning and forwarding will not be enabled for any port.
The CPU port facilitates packet transfers between the Ethernet ports
and the CPU within the SoC using DMA. All forwarding and routing
logic is handled in the Linux network stack.=20

LGM SoC also has a separate HW offload engine for packet routing and
bridging per flow.  This is not within the scope of this patch series.

> Are there any public available block diagrams of this device?

We will  update the documentation accordingly in the upcoming version.
Please find the packet flow at a high level below:
Rx:=20
PHY -> Switch Core XGMAC -> Host Interface Port -> DMA Rx -> CPU=20
Tx:
CPU -> DMA Tx -> Host Interface Port -> Switch Core XGMAC -> PHY

> How does the host direct a frame out a specific port of the switch?

In the TX direction, there is a predefined mapping between the Ethernet
interface and the corresponding destination switch port.=20
The Ethernet driver communicates this mapping to the DMA driver,=20
which then embeds it into the DMA descriptor as sideband information.=20
This ensures that the data is forwarded correctly through the switch fabric

> How does the host know which port a frame came in on?

On the RX side, the source switch port  is mapped to a specific DMA Rx
channel. The DMA Rx descriptor also carries the ingress port as
sideband information.
Either of these methods can be used to determine the source switch port.

Best regards,
Jack


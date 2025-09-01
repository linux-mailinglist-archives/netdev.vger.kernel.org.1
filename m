Return-Path: <netdev+bounces-218684-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCFE5B3DEB0
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 11:38:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AFB9189510A
	for <lists+netdev@lfdr.de>; Mon,  1 Sep 2025 09:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588C42FFDDC;
	Mon,  1 Sep 2025 09:38:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="01j4bOWN"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2052.outbound.protection.outlook.com [40.107.94.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820AF2EE268;
	Mon,  1 Sep 2025 09:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756719530; cv=fail; b=PV7eENO2pvFwOr2TEs/MzZ++cVlsANnCIuPVl/cHMAGxoq1lnQDb8fLKiHtlcC1p7ReHnp0wjSgfZHDXQ++5IzyJbSYX3i5iy7Rfq+8/f1CJT0YzEmxTjrOCFOsfXNWCkTAsbP9KIGZrlhLyGfcOj23bhMytapaEt37rg0GZh9Y=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756719530; c=relaxed/simple;
	bh=b/L211O4khJT5yG4yI3cGuNXr1sy+w7AtHxZdGgF4bM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UEx+Z2Wq3aP0NiE2P7CpTNxD0hKnpalsp/xyXgBiNfhNaZdmWan5E8QrlHkgq6zqAQHbM71M9AKL4DjCeTnWJZYfSBFcPH+1wvuTs4Ezxm4ZAGjAhtvCixPun1DhFHgzzCTKkN4LPNuSOYorYlwCEmpzKIoMEJoEOLeUCWyrcHk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=01j4bOWN; arc=fail smtp.client-ip=40.107.94.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DwMkG6VoJ4LQD2+ECyi0KDLoxYa17uWe61oFNz0FPWPNwMr/X6WFl54K+shQ8i9BM4631STtKK8jHj/E0XEQsuuVCVBlFuLNX0/ebQDaY6fbT5fO6PyTT74Z7FFl1/h4YBS7j+LeM5prhyoMhl9Pi0XVqWqZ2CMv8bX6dBFBv1W68fRc7RA2fV/jTRN1xQa34Vq0E0CVbpbjI6uY489iZrwvhd3iq9AA22UzPcvISuljwHLz5WfgHKMVreSv2fQUTAfFCVX6ni059Qzz9ZFxIwGk4cCSFolU8TO52XD+ddSo10tzsMnAQ8zTnNgU5N0nVQufCdTxQE7iJ1s1agZb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b/L211O4khJT5yG4yI3cGuNXr1sy+w7AtHxZdGgF4bM=;
 b=ZPN33Z+MAu0y/GBVILTQ4WgSjUel0YMlQy3LntMdjckdHHw7IOEwa66eSwnXWldS/mUf010QeGqKRlJVfk23FZD0Ff0wyR391XUMhzpzzHbrwTFwOuHkOkVDSksCnHUdOPFB2XIuOBgBN4MlUtH4IkhSHdhq8T99o68n1R6qSyP33Kgdnkd8l23WZCnbjqCVGJWne9+7/vP0O0xppKDLaDKAlJo0F6oD9b6YFVko0qYPzoj2k/jM6XSw/cSRXWUJY/EW0GpHwYIq8/uf5/DdHc+j5QPXJhGJO+f9uN49N0tD5vyizl5v5udo/NW8/GlqkD2sa9AKrTs88lauesIUqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b/L211O4khJT5yG4yI3cGuNXr1sy+w7AtHxZdGgF4bM=;
 b=01j4bOWNuF9Yk+je/OqSr55cOjwMofOLOoOYI+VzkuWIEeyo23K8SA5FrAA4qBYxZN6qn3dU4sr/j1789xDawZN1QyCjgDZ9sm8dzapEchXQMQukknnbLLGc+QDmD/ilR9/SfD8U+C7Sfj2G/Xi1JQSMlfDoA+MssZaZ4W3pR1b13phneVt7jkIei3TSL6eDxrCEu0ec6I5iL8u06TAX5c4YXurgbwHZMvQWVNomZpk4Koxmd7qWvRvID1Gt6plk9qFCGpnu1hpi+tCrtJINSPeU5odnpXsFq4Bl5KH3QPk4VbgpdSGnOatzkjsUqIUR7g/A0SDB0d2gpto2RYpODQ==
Received: from PH7PR19MB5636.namprd19.prod.outlook.com (2603:10b6:510:13f::17)
 by CO1PR19MB5221.namprd19.prod.outlook.com (2603:10b6:303:f1::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.18; Mon, 1 Sep
 2025 09:38:44 +0000
Received: from PH7PR19MB5636.namprd19.prod.outlook.com
 ([fe80::1ed6:e61a:e0e1:5d02]) by PH7PR19MB5636.namprd19.prod.outlook.com
 ([fe80::1ed6:e61a:e0e1:5d02%7]) with mapi id 15.20.9073.026; Mon, 1 Sep 2025
 09:38:44 +0000
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
Thread-Index: AQHcGONYZdoM3BaqikyKYzM9KF3Q4bR6E/UAgAQAW/A=
Date: Mon, 1 Sep 2025 09:38:44 +0000
Message-ID:
 <PH7PR19MB56360AF7B6FCB1AAD0B27120B407A@PH7PR19MB5636.namprd19.prod.outlook.com>
References: <20250829124843.881786-1-jchng@maxlinear.com>
 <20250829124843.881786-3-jchng@maxlinear.com>
 <65771930-d023-49e1-87a7-e8c231e20014@lunn.ch>
In-Reply-To: <65771930-d023-49e1-87a7-e8c231e20014@lunn.ch>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR19MB5636:EE_|CO1PR19MB5221:EE_
x-ms-office365-filtering-correlation-id: 9d073540-7ea2-4730-1168-08dde93b57e8
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|7416014|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?XHpFG/q/I9318+w+ve9GT3ukRTcAp2zYrFsCKKBlI0iesuxjwFMhskoXyRYB?=
 =?us-ascii?Q?Xxq87ZD0PEGuKjKuyVxVfAgbUagNdBf7K7jGKV1FrKhOxVqWUM3lriW7qWLV?=
 =?us-ascii?Q?1nrWkVFya/uQA8y0JhslSpEM6ULdvBGMtJljegLlxLJgCIGJlfPndyZ6WM5I?=
 =?us-ascii?Q?grOEpmfNIbVLXFL1ZtGursgIKFrin4IenbiXvJD8AmlhqbdeXolbzgcgiYKu?=
 =?us-ascii?Q?4x+s/wjiot4uV2dsnJ5kr/pCUIqqYr+9026KlO2IvFf0PWSJSW/E42+DGZeA?=
 =?us-ascii?Q?YQIMEOLKazyadSLjC6KXFYSfEbnoKCRBepu2YSdT/TX6vZU+V36vMR1xsGKA?=
 =?us-ascii?Q?2GxDKafIfrkh1Ya7qChlX979MIyNS9nrUA92xbUCIZXEfnCs3Ol1avoCV2EL?=
 =?us-ascii?Q?0AUH5XrQHCQcANIan2kPT+Ov1rIZlhW2TR9s70dQymVJDd0hRuoU5USWW4d2?=
 =?us-ascii?Q?hzPsloXdN2jP4/vt0rRW+iDZqy8vHR7M4rMxp9toCtnk+zV9SOy89ojsA55e?=
 =?us-ascii?Q?Ok90+LgCL+ZK8TCvGBTszZLw8rF6lKhg/z7Qhpff5gV3p+GDh7aA5cDw3YNO?=
 =?us-ascii?Q?7LEWCYij1G0OirIrJo07zNX7WDqAKwoBAey7Vfhg8xgm4k6LJ263BKKWboAc?=
 =?us-ascii?Q?Lx7C7kyjxzsolFIl7Fm8CsRvWZuiN7mai8B2CTG3xET6VfdW23bFzz4GKbSD?=
 =?us-ascii?Q?q6ajhB3heQW5Q5pymvIIh67cLftyJuaIgTqR40rwFJPwgbVgyAp0BUOCctOs?=
 =?us-ascii?Q?gOoTmGCRfylFE0BvdMgXwlfCnJuHguWL/eHqJyVbDIF+b+0gcDxpjXCSNT8U?=
 =?us-ascii?Q?tUv3Q4fdq3DsfIi5PaKSTnwd5uPBKXD8aC8HCcHinpeb2BxS44rCEaWcK7Ay?=
 =?us-ascii?Q?yvd9G0JOoQ+HlAVBiNb5GRZib1D/Pdgx8k/8ZadBgVUhWId6FGBEzwb3WLJ9?=
 =?us-ascii?Q?SfGqRueMf+zscz2Jiw5l0YgJCGep+H5QS1SwX7CemT4pdWdWN1JxNbHxRuiT?=
 =?us-ascii?Q?wLRPRvMPEvNlOLS0Jl7lNSDiraNJRspDvrnPAW1ZGXs2Snf3/JYuNJyP8jPA?=
 =?us-ascii?Q?hS5A7vnpxK1uQ9vf50wSfLc4r3x7roCU00RuA7f9sf1XQJ9uX9ZigfA5+Kub?=
 =?us-ascii?Q?Ra3t5rJcUdEzhPKoGoV2mAJiV3vvKI7vEc4N7I2mfU6wQJIT651V9jzhMhub?=
 =?us-ascii?Q?rRBTnP6oBxRljuNwpHBHaIZqsqwNvDuFw2Ie4CpBH6dYc03llNn9VkAoZXyk?=
 =?us-ascii?Q?4JZZBRy5vZsbFMcUsJtK6hspzSuHJGGXvSBBzLu5f4wJkwY5+TrbNw9Sm2ZJ?=
 =?us-ascii?Q?jWwBpw2NUAbu2ZR1oTqZrv0TBHR49gue3ZQ4UPvLB3j0Y+w0Mr8carcUcI34?=
 =?us-ascii?Q?xQ20iGL27/k0jnAzZeyJlfgLCVYyRrFX2l468rhvWePXeTUf2WEV2oiI0a9N?=
 =?us-ascii?Q?Do0ROvCLMkY/cN7pc/P9ZjCyMWJOoCB827QEDfcYr618yOE21BS0FA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(7416014)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?XI1vAwnmA7NETEVJh/2akNIZkXYjEaJ/wG/ADnnp1MYs7G1HqvSSf/eyzADr?=
 =?us-ascii?Q?q4b0q9KP1AX1Tniro0okHrfIQMSWw/Y7PbDKj78KWKynvc4LpgtAz/i1dMam?=
 =?us-ascii?Q?BgNSNEEXptsgTk+HwjHmL71paz0HgxbFz9SjOvKblAO6z5dfoAUGDz32NPzg?=
 =?us-ascii?Q?iHFOxLP50MjyRNsSAJUjLuX2+ANGoQ2B4PmL5qnk6+A3IZ/VEVL4GHDDfmau?=
 =?us-ascii?Q?mM8wiZUIcYGjgA2dB3J/sbMTJbUbzoEZu8DEKCESnAEeef2cMwCoOIp3DSvC?=
 =?us-ascii?Q?UlLs0hmJwXFUA70XBBU+UjHZw63H6+SBakozmtkNCeLwuTQJrn+6GKZHsRZu?=
 =?us-ascii?Q?DEss/gRlLCo/2BZ0yhXLqLRKG62ZQ7961LcahjJlI+gug9bwzDhTIO/TVbYO?=
 =?us-ascii?Q?/W/dPcHkNAC+yHLw3fN2lT7JHWdnAcITCtmHY96Bhx8zXnRbvkGb3FUV/zCO?=
 =?us-ascii?Q?jGHF0WybvlUnX8MUN13WAVGKTw9fqmbgjP1sV3pSPmLXZDG8i2o7OqX2F7eu?=
 =?us-ascii?Q?tIns3pz0DfHBjaxGJ02DlZBZYk26mteBRpCf72EAPX8f/t4mJa1ScdyDZDyk?=
 =?us-ascii?Q?ItnzIwBWIbCjZ/VabmHm93oPe1XpZyepQ0bKzCSLsAyzvAmi2JSLOJsZMzQO?=
 =?us-ascii?Q?AjEkFejuFwLtHj/un3apARhi+DE4uAsSmO5s6wm4gNPiLqXBKyC2kR5TRZdK?=
 =?us-ascii?Q?v5JCbUZKAsPMvUUqfq/pXMwitutiRTtHmXR6DXz2gFrrB+ceFbfMYAqa+8eA?=
 =?us-ascii?Q?AdxJWFvn3KPmhQRaC+QCcSwnb5sy38HGRFtD1DC7kDJcqoSM5poXvZQVTKLD?=
 =?us-ascii?Q?XHsFyUFocQipSKU1iE+oE6W7RcWMbccpctwIQo3HuL4ZDcO/2KiOYl8zUgxl?=
 =?us-ascii?Q?RpUQ0LAU3x9cZM8lXv1Tl3oagmCv5KhfatuYeS3nTd8fcAXgj4LFUMSiPe3U?=
 =?us-ascii?Q?+trox6/jPN8OTg40y9xQgwaGdjmGC8mZKPE5FXKd64wdV6Z1HtPIs8BybDdd?=
 =?us-ascii?Q?meSwUecKVP+MDUu2qJGwsElWmmA+UMRDjT7yZMKch3Ii+EpBoPI3PzO5342V?=
 =?us-ascii?Q?TBcy2E9M4mlC9JNfq9zokd9bnvPxAMnHnmUBqq4XxcAHHFQ+gakw1glnlLwS?=
 =?us-ascii?Q?/rQR1i1v2lunFdhOdK4ZrCQBs+neWhd3h8XSQR2dQ6/uaqtaH6dhMxrgjtkU?=
 =?us-ascii?Q?6OUSOuL1cm0LAQ+omqwvRZU8N8FbMB09ajGUgwBDsLy0tBC11B01ie8TrcZN?=
 =?us-ascii?Q?sefOsKLolTGDDAbj3f2K99BZY2P014wdO1Qih5ImhvlWHyoudYOnaiO/R9MB?=
 =?us-ascii?Q?ugNEOQCrDTWAWQO29OXedtvYdMzNdb2jDiZTEqDcMfFsWkAfh+YW60WsWJnh?=
 =?us-ascii?Q?TO1d9AsBNev/hyyFgM6tnMRDOGRtcgZroGgjRSAmXrW88coI056fw26MsSty?=
 =?us-ascii?Q?8axoZrB1/bCK/oIiMK0nGN6zmtSDaI0atPiDDCFPNuGn+YnzI4UVPSKhB8gO?=
 =?us-ascii?Q?K3nI4llVIlAw7Gzg/NhbPyaBhdBN09nY3NamRc3Y9nNitZQlj/QqnuVybLdl?=
 =?us-ascii?Q?sBYZnhB2XyPVMrcZgkChZT5kYQe/bm13Z1xTRJ11?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d073540-7ea2-4730-1168-08dde93b57e8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Sep 2025 09:38:44.3381
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: B0Q0iVeCHks70XSvsqJIi5qzVehaxA868dC6CM/nLQI3LzVsSmvcmKlngseIp/OmWb6Tq7K3YajKBVWUj9TtLg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR19MB5221

Hi Andrew,

On Fri, 29 Aug 2025 22:24:06 +0200
Andrew Lunn <andrew@lunn.ch> wrote:

> > +This document describes the Linux driver for the MaxLinear Network Pro=
cessor
> > +(NP), a high-performance controller supporting multiple MACs and
> > +advanced packet processing capabilities.
> > +
> > +The MaxLinear Network processor integrates programmable hardware accel=
erators
> > +for tasks such as Layer 2, 3, 4 forwarding, flow steering, and traffic=
 shaping.
>=20
> By L2 and L3, do you mean this device can bridge and route frames
> between ports? So it is actually a switch?

Yes, the SoC does support packet acceleration.=20
However, this patch series primarily focuses on the host interface to deliv=
er packets to the CPU,=20
where bridging and routing are handled within the network stack.

Best regards,
Jack


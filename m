Return-Path: <netdev+bounces-206623-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C4B84B03C19
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 12:44:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 00C023BD7C5
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 10:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EAA9245010;
	Mon, 14 Jul 2025 10:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="hyczOiiZ"
X-Original-To: netdev@vger.kernel.org
Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011000.outbound.protection.outlook.com [52.101.70.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729E2244669;
	Mon, 14 Jul 2025 10:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752489836; cv=fail; b=DS4YCK+HhDyg++OKm/JulUN1sDO5MuqDfw48bM5uxcjRPtFAuELPLHAFKfHbaXHIupZ9pt5kShLCDzrM5k8u+Z+W9MogewL/OMMt6GptvzpVyAyqTS5EmhYKafjojHSCvQPNkx+hbD24+FR8vmjmyr1SEj/htEB8jzZHnbpWPuQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752489836; c=relaxed/simple;
	bh=Dt+MCFc1PkobYVkN80C6zK0Jftxrq27b2bKTLOXkwG4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=HYyRhT0Z6MnIWliAJRlm6F8Ai+TmrAu9yAq2PlhvOkHnVyxU9jmEQEJQCFiQsUWy5wxL/4YHBila10wtqj+xs1uvnz2KzsKMH8Le91ZZkMJBodkz+SAYJtRt73iBT3bsKVOa7/IQM5NhrnChqlY4xmpue/W3xYqbL/KcUQtH5UU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=hyczOiiZ; arc=fail smtp.client-ip=52.101.70.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CmI1IZqkT6AxnM+fymoNbaEPKFiKihA4MjF4DOUVs5Ho5I0vov2g1kZYyMaINsQDC8wx6BX/m/3ArmKY7VBORoJv/X7rPOKgAidUajssNkuGk3MjXDUCvmROzw4KAF3gNoR852zA5PhjyuN+t9RZHBgkb7qehA8vWCHIcHMH6RwZobKx/OD4arQ76Z8g7SqAgxCVo37Q20G/f6Mh1x1EhHTSajO526QAVhXOHZdoqFzi19BC5oLMVUGCmJAmx8BNsL3r/Wj/YANjjsHWkTw1rersns5rc6xh7b/TyA5L65E3eXcDmcSm44LaQpsOPi0lrnw6UFqUcPvgTcUAP1JmRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dt+MCFc1PkobYVkN80C6zK0Jftxrq27b2bKTLOXkwG4=;
 b=DJmWY+0bhWuR7DQWndyKgj6zJqHu97H73ontiAmBlRUW8gR0Y5s/Fp8476rodCHd16f5zlVDuPEd14EFepC/FdIPlhBDnZhT8mSDW41fTbkfklWuuTh1GQUBrOODQiE48Mm0/dbLQoWycLWCdjHPtjewc9bD03rIFMv4Vr0ONbweT27VFhhF0dk6FkMA2VZy2EuDrWKr9q9dbRcblR73z+Y2CdU7NH3eGXh03oCApczBNbwH2p4pSk/So98CSGlbJyMNtmS2BA+xfodCa5wIeCEanHgAeWcjVeTbtcYTUVDUfmfV69hsyaM3fYNdR8B1rhw8dLNfjp8etrJoMdGf+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dt+MCFc1PkobYVkN80C6zK0Jftxrq27b2bKTLOXkwG4=;
 b=hyczOiiZ6jU+LxmisbSrotcG241+6QBFq4IAYf7dx1q6DWG1plAq/OpwzCS1cO0/cqkscEs+HTqa3ZdFY12rMWCk/P37WtC3SAEHhl1VvSOrIr/AgjVQeSED04waT2DtTkZGSjsYSq/Jv2eUYZPLrp25zfP8w8Ob2RyT4YbGQ8isCkaHzGmnvsg10i6OVHf7mFTCCgN7ElO8PeJ+kv/km5865uHZv+9v+oY4JAh4khOD/0kEBRPXf5uPZqRKEu0kos5FAggoPkH1yvpHElg8c66reThsmSfFNsC+ZoZdx06/0pZ3vJcPcqEBahqLU0AILDjMU0JtHGvqVhA6FHxYrw==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DU2PR04MB9097.eurprd04.prod.outlook.com (2603:10a6:10:2f0::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.23; Mon, 14 Jul
 2025 10:43:50 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Mon, 14 Jul 2025
 10:43:50 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Krzysztof Kozlowski <krzk@kernel.org>, "F.S. Peng" <fushi.peng@nxp.com>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "robh@kernel.org"
	<robh@kernel.org>, "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
	"conor+dt@kernel.org" <conor+dt@kernel.org>, "richardcochran@gmail.com"
	<richardcochran@gmail.com>, Claudiu Manoil <claudiu.manoil@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>
Subject: RE: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Topic: [PATCH net-next 01/12] dt-bindings: ptp: add bindings for NETC
 Timer
Thread-Index:
 AQHb8jPWk5neHXUn3Eeo02nqDOVTYbQxImMAgAATMMCAAAm6gIAAFX1wgAAGKwCAAAFaQIAADfuAgAACM8CAAAPoAIAAAqbQ
Date: Mon, 14 Jul 2025 10:43:49 +0000
Message-ID:
 <PAXPR04MB85105A933CBD5BE38F08EB018854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250711065748.250159-1-wei.fang@nxp.com>
 <20250711065748.250159-2-wei.fang@nxp.com>
 <ce7e7889-f76b-461f-8c39-3317bcbdb0b3@kernel.org>
 <PAXPR04MB8510C8823F5F229BC78EB4B38854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <61e6c90d-3811-41c2-853d-d93d9db38f21@kernel.org>
 <PAXPR04MB85109EE6F29A1D80CF3F367A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <169e742f-778e-4d42-b301-c954ecec170a@kernel.org>
 <PAXPR04MB85107A7E7EB7141BC8F2518A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <836c9f0b-2b73-4b36-8105-db1ae59b799c@kernel.org>
 <PAXPR04MB8510CCEA719F8A6DADB8566A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714103104.vyrkxke7cmknxvqj@skbuf>
In-Reply-To: <20250714103104.vyrkxke7cmknxvqj@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DU2PR04MB9097:EE_
x-ms-office365-filtering-correlation-id: c3a3d001-629c-42a0-35bb-08ddc2c35198
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|19092799006|376014|7416014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VsycvE3IMfcRednWATeLk9B9plg0ZNwMli9+PuqCgT/wrLC+0lkZNO8jzkRi?=
 =?us-ascii?Q?AQoe96f8bnuP1VlYakU8Co8g1/xcSD2ccyF4jNwldpT2rRiXl9kZ/qlsS61V?=
 =?us-ascii?Q?+rInK74ONRVVBWjQk7SReGyMXHMk1l7mZuKNema5dPpCXfwcLOOApptItuVS?=
 =?us-ascii?Q?U3g2gPsNJ5G7C/ZWX/hMAV3ukqAp/7hwTWwMb3XNodZnJ0P6Ap/0eEstfUow?=
 =?us-ascii?Q?+/JSFfK7rgczXL+/+hsMKpfH6HbQhw8KTBpF+2KcSGzl/ttlImg850lULui6?=
 =?us-ascii?Q?g94pfLGn2LDyzlrNnfMxZv95F/pHBeG/3KwKIUyftC59g1232s+zlz/gN0fX?=
 =?us-ascii?Q?KgSU5NRDI8rh9iUBAKG/92UWWWsfGQCE3s88lbAvfdNR+ItAAPTsOdhFMGtO?=
 =?us-ascii?Q?zQVM7owkt6IQ2bvnF2Zi0eKf4stT3L8XGIOBX7KPzg9grN6lMELjWXe0ayKE?=
 =?us-ascii?Q?zhRVuKchPxcWxOcUtpVx7XOCNVd0w16o1s8Z+x+N4iJVSPnjMlmZBeNNY9QS?=
 =?us-ascii?Q?IWwMKoSq8rn1NFEN2XMEsWGje3JnUNsBbKOc1sUqJA1SAkRNVfwoXRTdRIiU?=
 =?us-ascii?Q?FsO9CZ9v/gYBRKf5C+6l8L9y9MP6Ut28VvwsV0ffHsrLI10mKtcVe5NYtQ1B?=
 =?us-ascii?Q?03ygert1FsV7NVZ8r6a2daZ3q4+NswZgSXVaJb3A8rutSR8dL5mUdWEPLTRu?=
 =?us-ascii?Q?UgmYANH4262+A7bBzXgR0/BztML7/X0JOmDHYMXiZWd8Tak9SQ5rUdhYrrJc?=
 =?us-ascii?Q?yLY+AhxAdSMiqf1JsJsuabPganqXuvPgn5cY8ox2m/gDxK50fo6Bl/MUf7by?=
 =?us-ascii?Q?R3dPtnn2O/UQVXCIBElYbsJkGzc2KVUEKjeOQ8kBdlVj29K/S7e/GLBCaC2Z?=
 =?us-ascii?Q?9c0fYAIrhTSjmCjU5L4+p8t/spnz/0PeQVYPWNIWzq417dmkL8Q+zI1UBi/d?=
 =?us-ascii?Q?RXs2pZYTgIp0xQ1YoDIv4Ti31p/DJvGnyrRPTmtu4kadlJkU3fVRp4owzNCw?=
 =?us-ascii?Q?UWryhnvr7rwuJvlEn3TqPIFah4nTqQo7NsQOMQBcoZS1fBkdM/Sd3/+/qLfi?=
 =?us-ascii?Q?l2sF9PudeH+AZ/4m8esVTxeg8WAZxsTcSjscNjFDrp3XnRbfqCP7Y24WZzb6?=
 =?us-ascii?Q?5j4QaX6mOKWFgeCTYRfO4/B1fF2MJAkUny/lnhv0G033VGi2nnEsZtRKYreD?=
 =?us-ascii?Q?APf4mwoIXtJtdDy/f45TgnZlxrayn2goVmxLLty898E661BgVSF9tTixRm1B?=
 =?us-ascii?Q?RwAFhZ8oC2ciQD7dJN66ffvugyXihQnHOoM8L96h8Skj0VXt1YO9ii8zXo6p?=
 =?us-ascii?Q?SbmhBb7VrLan4KZZ2sKC+rNxoXpdClNJXTegU/ERBEBN7AtCg0ivn7XYBWFI?=
 =?us-ascii?Q?/9Ioo55fXxGwy1QJ6tZsqWsC50xI1EQ532Kcge0vc9K9n0Xz7oXm4dVCi8L6?=
 =?us-ascii?Q?MVGhv9z34WwF4tQzH2lmuuyONKyPKiLIEzW9XxvUnNYFW94fTR/MbQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(19092799006)(376014)(7416014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?sA+HDnEfS5xQ/wLWaa79TqEuFXhPJQ5bVY6SEkbbgDCwvO6zaUTE6DH80mbT?=
 =?us-ascii?Q?tZZ4oL23fUVeUUYIlQQFzuVc17/gp0+iERvyhaI2ms42tPV31LIxsydoas3N?=
 =?us-ascii?Q?wBPFt2Ha1x7LbsIaGJvaxtLjMA7UeEtHAz9jd9zGyrFHvC01EjdVBkoeVoeu?=
 =?us-ascii?Q?zhToLRmF6EDTsXINBYA/+QFqUSfVMmXXO25OMskH6b1L9lOeCijr+9khCQD9?=
 =?us-ascii?Q?mM0IQeKvCkYuH/uDdWmauxpTOCv+uKkoA5VxHM3abKphq22Sdzj1h6YCoWxG?=
 =?us-ascii?Q?b4t545RD1BlbRUbohwPogQqGobQH+gwItbT413DH5R11qVSDhukubLcI7hZG?=
 =?us-ascii?Q?4+fcN9hAQnq/zwPzJnOWhf8FxQrs2g4bZuhdJetgkI9VWQAzOJouCN+FC8fA?=
 =?us-ascii?Q?oQG9+hJJel9GFI0D6P3UXj/0vq5mB/p8TXgQyHxCRp0O2/LFdYz9N2+w9u/c?=
 =?us-ascii?Q?dd49WMRLgCxJ/cxVpd4uKCci4wdkG5jDx2DMk6xUVXjnwDaMiao9gFRbiv/W?=
 =?us-ascii?Q?Ickp8ouw7xIjc9rtPLIkaIJpayVL3vrlEhImwS4YUpSuioXLXyQ5l/6d0Qrh?=
 =?us-ascii?Q?wx3cGxpxu48vv/rJz3Uky0KA9/yfbGSnchGYlNzaoWidOQCG0WJDMTh9nBne?=
 =?us-ascii?Q?lj5z8ijDt52nJ9doL0xWP6LGRNQ/XrUjajuUx4Nrc8a1ys/uHOrZDFLs9GWe?=
 =?us-ascii?Q?JsuSTNkAObPrsnYTGa4Vmewu0LllfewJDNq1FCYLnVPwtBUC6adtMDYOpRGC?=
 =?us-ascii?Q?mXOXYYwyaMrmisL3lUicZOKwBZhMESfQCfrjgtszVouByY6f5MihHqXF+oaq?=
 =?us-ascii?Q?5GaFbXuUr4W6GTxwF14uNCnJWfCE/i0VsFWVPlGc/B7CNDw13uFyZixwS5vs?=
 =?us-ascii?Q?qL6sTRj+ltmVD4dL+8gpz82+VPuozKTXmF/s2xJ4zrgUbBR2VJxnI61ZNT4J?=
 =?us-ascii?Q?AS9+hQp7XltDV6HueRujwm0AXdna977TlqDRKK+08xwVG1A6quNAXfUUiwXg?=
 =?us-ascii?Q?9vHI6MWcVVxuBa0Cp924rFw+NUO4dxjCA6+mOyXgpbmcKMgOs/1w/myWT6ub?=
 =?us-ascii?Q?kCMpuMfaHNtKshN9E+7bEKbVPPvpE5L/nGxytb0jpiWB3DggcnN5rhkhwysQ?=
 =?us-ascii?Q?YF06uzvKu6+/Xqh86LRLlKiNiz8tGHaHNpVn57YKrOruMq7kxHWVz+9lEb/j?=
 =?us-ascii?Q?ppnifjwDk3hREDrpwC4Mro0d16IoA0pdOI7WWNpukiTd7d2TL9ho/muaFB+Z?=
 =?us-ascii?Q?zuo088YdkJBRu4BUUKaNDCoa+FqNTz/eFaSyihj6vOXHU3gR+8ugez9ccFS1?=
 =?us-ascii?Q?bfEdOqN1HFzkUmuDkKpzIRPad+g/rPYxAVHbzZNhCpoubO9os+RAzceWAYXg?=
 =?us-ascii?Q?mI+C3zSt7tjNt/zHVl0e69mmPcfr1PvPW0O34FQ/cxR4IVm5Isg9zhls4fpM?=
 =?us-ascii?Q?BYFtx45HdxVrkhVpdEev7wtCxUd3ramWKa7ah3uQ/L8DI1kZdY3iNOV3GEKc?=
 =?us-ascii?Q?UKFn5JQHVQQJRcvmy0GxXO9FOZa3h46xw9WsDWeMAisBIcw1yluOg6MDUPAF?=
 =?us-ascii?Q?eaGIAIxR3zTBU8pihb4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c3a3d001-629c-42a0-35bb-08ddc2c35198
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Jul 2025 10:43:49.9201
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mMcLyMxx8Kxzb0kUiTQ/ihHDySLnLtaCfi6g+hVYbF+cRV2nPAa3IoM5+8hi2sdUfVFJ2ngMDjZVXgct4IoeCg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB9097

> On Mon, Jul 14, 2025 at 01:28:04PM +0300, Wei Fang wrote:
> > I do not understand, the property is to indicate which pin the board is
> > used to out PPS signal, as I said earlier, these pins are multiplexed w=
ith
> > other devices, so different board design may use different pins to out
> > this PPS signal.
>=20
> Did you look at the 'pins' API in ptp, as used by other drivers, to set
> a function per pin?

ptp_set_pinfunc()?

>=20
> > The PPS interface (echo x > /sys/class/ptp/ptp0/pps_enable) provided
> > by the current PTP framework only supports enabling or disabling the
> > PPS signal. This is obviously limited for PTP devices with multiple cha=
nnels.
>=20
> For what we call "PPS" I think you should be looking at the periodic
> output (perout) function. "PPS" is to emit events towards the local
> system.

The driver supports both PPS and PEROUT.



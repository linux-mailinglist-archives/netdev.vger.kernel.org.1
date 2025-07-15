Return-Path: <netdev+bounces-207001-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CFDFB0526F
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 09:11:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2DF51897B61
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 07:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0305426D4D7;
	Tue, 15 Jul 2025 07:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="dgZdcNeH"
X-Original-To: netdev@vger.kernel.org
Received: from DU2PR03CU002.outbound.protection.outlook.com (mail-northeuropeazon11011000.outbound.protection.outlook.com [52.101.65.0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9D381F0E47;
	Tue, 15 Jul 2025 07:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.65.0
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752563504; cv=fail; b=M9FGslVE4PNoT0yYXwxw3+4OToDH9YIOVqSRujH1TbH65YS/K2GjksV/cAC0p97irwE/eHfkzIPUm4U6THOy6/fBFoFaEvDjxiJ1OlopwJa4nuMj4J+EtAxAW5c3G4fWArC4b3JGjrpo0EsSC7fX7bEndJdYi46ssTWP5FXOJTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752563504; c=relaxed/simple;
	bh=IrQaQykGjj3dB/3nVu8v+dK34oLNaImDrN9lEaKIOlw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=K6D6ELMyvle8c7aX0O2rFLrc1mL47ZyWzp0V6O3mjgd1AYfVE9N/cp5PMTqErEsu+agXtHTDIPmVkjLxdgClwwtkrOW9Y7OjG0dSnQtwuD5rznVRUynXuTuz5Kx1DTQDW5FFYPU3LdKWDoNqsiK/4u0xCXmBmMX8+50iMGr5zzU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=dgZdcNeH; arc=fail smtp.client-ip=52.101.65.0
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eglal1HvPDa3zPKdextzqNb65JLIuIEdL4bz9JNT9j0+tu53TqiASqC4UMNcBBlXePDVN2E221en6J9Ban9MvMkJLz68jCoh8N+S0o5hT8BohBd8IPMn0fX26q4hQgTwOeVYOvj25kTls8doosYXWVNmtmZ96xHLdHoRnB1rtJUUbN0oeL5yezEgSj64NhjnvJDHxAYdtfUbGNR8oVd56M2eBHaZiAgk41R7EjYPzN+YHbNzA9ZsPe1bXuIbQSiFSCaQem58ZEBSafv/4JpofY/l2BifNWZzzt/YxNPjUxW2pjmfv5HycJsVDIWxHUO0IB4Y5Esk66GKm1OvmR7F+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrQaQykGjj3dB/3nVu8v+dK34oLNaImDrN9lEaKIOlw=;
 b=DMy968+N15HIpaxAmVNRVHSP3HieRFo76JFZ3nE6JwctU3Bpq5hrq7eOpaN/GYjcOiKFKohrV7omQLS2eDQt+Rb02KWuamFAuGaBv6yYHR3z9Iwux5q73y4iNOR7eOVC6mRg02pxMP/Y1pBXTAN1HuUZL5gVh4mql68/YRh1IKgvDm/2yv+GNqAC4Azv3k+JVM/VK0gN2Bsc+ZMWUd87cTz/yzp9ilmCSiIFt2W/t2nHz67kIqkZMJpa7cPdJQyb0OmbQVlxcnU19q/yoMXPWG1oBT8Qaa996mPMf8DhRxotZGkL1ePzPLxW5QJy7hh3nndJoeAp6ED6Wij+/oTPdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrQaQykGjj3dB/3nVu8v+dK34oLNaImDrN9lEaKIOlw=;
 b=dgZdcNeHRZIlcCkGmHFJZbwnMrbbwb835TOLeK3GA1pXx18EOwwx489mBRWLAYIVcLJCfrcqPQJt7fQXJV7Pcl5MXMuErTyEQGAteSR+P4/Fh5sZdeqWMNkTlGgWsuxKYxa0XoP4J5JkubVpnjsaUsHJJj4yOHXQwxxX4mj5cJB9j5xxOzCzAVLZoTKixUIETNMkklHciQX6ToHcV5lEhLplpgc36+hK4CXGZ4H+Bkjcf8+DZeJzLEh7pyk0hEKHVBV0UXiRrsGfREoJizpMMQKg5TDSdXOW9ypFxKPwuoREI6CeMLhiJ0dsGSqx3VyXWw3hUh06Tg+a6VFruo0Apg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA4PR04MB8063.eurprd04.prod.outlook.com (2603:10a6:102:ba::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8922.32; Tue, 15 Jul
 2025 07:11:39 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8922.028; Tue, 15 Jul 2025
 07:11:39 +0000
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
 AQHb8jPWk5neHXUn3Eeo02nqDOVTYbQxImMAgAATMMCAAAm6gIAAFX1wgAAGKwCAAAFaQIAADfuAgAACM8CAAAPoAIAAAqbQgAAP8QCAABcf0IAAD72AgADTHvCAAEudAIAAAbog
Date: Tue, 15 Jul 2025 07:11:39 +0000
Message-ID:
 <PAXPR04MB8510633DE93F043A0CD09F5B8857A@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <169e742f-778e-4d42-b301-c954ecec170a@kernel.org>
 <PAXPR04MB85107A7E7EB7141BC8F2518A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <836c9f0b-2b73-4b36-8105-db1ae59b799c@kernel.org>
 <PAXPR04MB8510CCEA719F8A6DADB8566A8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714103104.vyrkxke7cmknxvqj@skbuf>
 <PAXPR04MB85105A933CBD5BE38F08EB018854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714113736.cegd3jh5tsb5rprf@skbuf>
 <PAXPR04MB851072E7E1C9F7D5E54440EC8854A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250714135641.uwe3jlcv7hcjyep2@skbuf>
 <PAXPR04MB8510FFE0A5DA2F3A94E9CB7E8857A@PAXPR04MB8510.eurprd04.prod.outlook.com>
 <20250715070256.ce6a3insjihjtpzj@skbuf>
In-Reply-To: <20250715070256.ce6a3insjihjtpzj@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA4PR04MB8063:EE_
x-ms-office365-filtering-correlation-id: 8542babe-f2db-4816-c55f-08ddc36ed80c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|19092799006|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?VQFDKVhbeJCP+ib/C4tyUsJCNFYbGLxHDWa+ymjDmF9xZ6Uy1rNSjBSbGZnU?=
 =?us-ascii?Q?/wjM3am+044qQrLN5bTFHw+vkXcEZjy7qCFXOqNwrYYQa5nd68mZS/FKa7/O?=
 =?us-ascii?Q?6DsUmmIddna6RhlOr2j3FZQRy0dlXm6bOqNsixWr62HN8TrOIndLu/YLFlif?=
 =?us-ascii?Q?ldw5SEYltVS5yi/kmoohDnEijJ5mGPMwDbDVUjOufkfFA+VWqRmyadW5hQjO?=
 =?us-ascii?Q?ZMQ/eD6AkW3b3kiqK0gQwpXdyvsdjS5fR5qaKl/Grlv6/ra/O/7EQBsqFzLl?=
 =?us-ascii?Q?SJT/JDDUsxiCq3PDTD57A+svi9VcXLZuDdR+wf7hChZ9RtdwE0lQ2WunyiLr?=
 =?us-ascii?Q?R4hB1i+EnUNqHRbtVLPSAOcQMgT4DO4k/94cnr4jAUaXcAdq4AaVVVbSB+JS?=
 =?us-ascii?Q?/gATb6rZ29V5pVFZL1+mxZRfmRFeU4+4/66yoruuj0WpMUi4a0hpuA923oHr?=
 =?us-ascii?Q?AJzFWO6Umucbvtx9/IqEmbUIfqIwAMUSM8kDw8QHCK6yE6egnGswp0kNO4/s?=
 =?us-ascii?Q?p+E8bAGm8WICuN9UCgOmeL1d7F42P1/oanOZno1QBvarBeqwyrVITqO8y9A0?=
 =?us-ascii?Q?b4Eh+1sOAnsdYTp8US+xXHBiNHqd1jAdRO8XAi/zLhIIU2DSB9eIwYcmUnOw?=
 =?us-ascii?Q?pN8/lF3Bqtjxj0YQV7zp6I1lTHTZ/ZH1TTAgRrGGE7OrtI6CcxB9VG2p801C?=
 =?us-ascii?Q?nhK2fMaqqVlcjOswULKx3anQzStC6Ro0tvMLXbhrW80C0sFkualwJAYvNLwi?=
 =?us-ascii?Q?w80fFRjfa7V4HskOjYSL9KRAdnzr7MS3o5b5QSBI5RIsOTcb8uhqKd3HTTQ8?=
 =?us-ascii?Q?jd1o/15quXIQnXwxrWFD5IfgNlBVNHCIl7stQnwZJMebS84QHEf+LsR4G0DZ?=
 =?us-ascii?Q?5E6xivS+1rIeRhe/k2TEOwrJjqf02pfQxT/BUEFD2Z5OK1DnYIfiFjNeIyaq?=
 =?us-ascii?Q?xcvGUeyikDai2D14u5qB53LWq0lFnC2D5ot/VJCIH/S4M8hjWokGPsmDFgWF?=
 =?us-ascii?Q?/wjuGOhu1vg3llElD1N+WxHrclnsizMKyFlq559HyOqvgiqlJGqQoJXDJZXm?=
 =?us-ascii?Q?78yu9G2PEV+bw2ghNv48pVHRWGFG7+qtEvAQXdP+/nZVOq/UhYuMdMpk+4KJ?=
 =?us-ascii?Q?Bk5K8swUYEOMNqON2XbUi2AwolpcM+HB2Dxr2lHXYx1xfmXBifllV0qlqyj+?=
 =?us-ascii?Q?5d27u4sGzk5VKIwv/Xw9ASH2Du2NJxgtwSisz+cXBFIMnSCqSDlRYpN0rYmr?=
 =?us-ascii?Q?K/LPPc+FOnRo1MFThnvjeXms57gSIAmDrXUdhg7LG7CN3OlYwr22ulANug8b?=
 =?us-ascii?Q?e1ZkTdhJlElzTEreSrZejraK4sheHafx9k+uNGZNaTYN6vvouNgJWhVCeYKz?=
 =?us-ascii?Q?hIE0mdTzsMShQkbeM1cZ8iY/ANAKNdxcxP98YUj2E1tkCUb7u1pPdMtf4woR?=
 =?us-ascii?Q?uWde+ImktWoF88FwC1u5en4FxQXTgBBj+5LfpYiQ+XvXSq9576VNrQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(19092799006)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?5+mEFiyIT30awct9VSVLxfVk+N2KwhoTAHmCGoKTJAC/IAbugQ8SfTBkAB3p?=
 =?us-ascii?Q?137l3hPJRVBZaTTnT7RcnXFyn0YGFX7osaIft+1wJOqz7aS6s+XjrpV4qphg?=
 =?us-ascii?Q?+dtMLVS96xuM3iYn7SUquhXpsEGqA+tRcpM6ENxsVFCqkJMpDz9/6nshYUh9?=
 =?us-ascii?Q?W7A/7CzDNN8wgNV8eZuR4jHn0BdNMWgiD/chK1PrrLtwqLioVG1vnRbnYZSj?=
 =?us-ascii?Q?7Wd3V8JBy+JngYWp5IWHkpQPRdRONkQ0LHo7Kqm3Ynht70myp2O11kNuSEr+?=
 =?us-ascii?Q?XJ+epQDVeh312I9Ti+B2qy0tBMzdng49G7+G+uWJOiHmgAVtG96MW/qxLLHr?=
 =?us-ascii?Q?HT8jll8vN5Fm3xCEXI4vOQU2V+R12qmwMqnO6VjHLtripU3Ig+yTbFN+ONfN?=
 =?us-ascii?Q?CvySMtIeNF2RPIZb7NrAC1ULbLI22uY7iBckuvI4NH46Okj7pGkiy4kP++4s?=
 =?us-ascii?Q?fXnNb74Y38cvHyRrHoiSjT4TChogy74zGUI4AyPbuvhz0/NxjSwAeghHIWsO?=
 =?us-ascii?Q?gLLPzxnjUfM4ncYNj2zra+OuW9aWiL6WijT4QKDutqUnKk5oB8hQzBJJkO5H?=
 =?us-ascii?Q?Wyou1Jg0X9qG28Q9zElxMeEAOP6LwCjD4mdBfy7eB23opVUoXrgmP1X+XXg6?=
 =?us-ascii?Q?PH3G1cl0LC+pDFAFOk/CrTy6pCYWa0sQ+A4olH5ElOc5MI9qzIQ63VzVN63B?=
 =?us-ascii?Q?iSBNFr7JwMrt9bfu/2fMKf0ByGDkpy10BRQecUsYO8bTqj6kotwsVCaKXWoI?=
 =?us-ascii?Q?sJWnUPZejkHHrNbRNBY7ohofe6/jortrPQNjfNkDFghLPEZWeDKfMpdEYYT/?=
 =?us-ascii?Q?C54qA6Q7qMpcMGtFN5iCg3O2aX/dSFTfKi8HYXAilN4Jiz3z1apNNc9n1lVY?=
 =?us-ascii?Q?hGs89Y1UqKQAe8cvuClF6mVYQWXGQisY4TGt1U1idxFcXH0GCN5NkzeiDpga?=
 =?us-ascii?Q?F6CoL3ZfeLJnIdiuwU8wmuw3uVEz5OJW6ocOcz57nRKxqKWen0pehXauZgOU?=
 =?us-ascii?Q?gAiBcfjc+Ov4ldu4Hq/OeT8lqNUHxEmXj6OChE3pBkclX1KkoHvSOA+/5pUu?=
 =?us-ascii?Q?zJPQHnTFILbGe9VUfIEq4MBYqj5ARjC4CC+zMM5xidDPopvGtqqwJleWJ727?=
 =?us-ascii?Q?BkzWFyKK9TKXXgV/IacBFuyBuNrsagVq+K5PoB8O2XC8daFVpABn5De4OcYF?=
 =?us-ascii?Q?qrdYviDMNbxrjrrRjw1Esi2t7jOpRnBK3SrRzLTfp9L3XbpzVjTcc3H+5iXJ?=
 =?us-ascii?Q?/Et97fv9VQNPFughqAEGs4aOHAzymdqUjm7CQepYwR+HOZzqGxyS3vNzxiMH?=
 =?us-ascii?Q?aKcVjA4lVs5kn8POcAoC3O/7SjzUbB0Lf/9DmLXPlOB2C3nWXoHCmkA3jr3b?=
 =?us-ascii?Q?GBPBc1Vp+Gx3286qnOn3z7VdrsJfeq2WrTMaUAphcjL9539D/QFYMhz2NLoM?=
 =?us-ascii?Q?p5p0Sx5QPPP6WQF6wrd9i2TviphMlucwv0Aq1JbrEguT9onnWsPojt7qF4OB?=
 =?us-ascii?Q?5o0Dfuy8Vww4qUMVsOUZ1gqJvCF4MuPdo+nVD3LwC5E5+PkQxfaA69cOXEm5?=
 =?us-ascii?Q?OIfejx5EhsZmpM3TiSc=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 8542babe-f2db-4816-c55f-08ddc36ed80c
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jul 2025 07:11:39.4552
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qg4sMMLYIPoVScXc/WHODM/jGHAI3gqCONyqyL0xEz+AwfnSAh+syCKgvWtUkEqhZVHx+ecQbbxuhbcmi+uX/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB8063

> On Tue, Jul 15, 2025 at 05:52:33AM +0300, Wei Fang wrote:
> > > You seem to imply that the "nxp,pps-channel" property affects the
> > > function of the SoC pads, which may be connected to the NETC 1588 tim=
er
> > > block or to some other IP. Nothing in the code I saw suggested this
> > > would be the case, and I still don't see how this is the case - but
> > > anyway, my bad.
> > >
> > > In this case, echoing Krzysztof's comments: How come it isn't the sys=
tem
> > > pinmux driver the one concerned with connecting the SoC pads to the N=
ETC
> > > 1588 timer or to FlexIO, CAN etc? The pinmux driver controls the pads=
,
> > > the NETC timer controls its block's pins, regardless of how they are
> > > routed further.
> >
> > pinmux can select which device to use this pin for, but this is the
> > configuration inside SoC. For the outside, depending on the design
> > of the board, for example, pin0 is connected to a CAN-related device,
> > then in fact this pin can only be used by CAN.
>=20
> Ok, but I fail to see the relevance here? Do you just mean to say 'there
> are multiple FIPER outputs from the 1588 timer block, and they may not
> all be pinmuxed to SoC pads, so I intended "nxp,pps-channel" as a way
> for the device tree writer to select one of the FIPER outputs which is
> multiplexed to an SoC pad, rather than arbitrarily choosing one of the
> FIPER channels in the driver'? If so, I believe the case is settled and
> this property will disappear in v2.

Yeah, now I'm clear that PTP_CLK_REQ_PPS is not used to output PPS
to external pins, so this property will be dropped.



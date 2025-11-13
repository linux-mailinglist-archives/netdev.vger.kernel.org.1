Return-Path: <netdev+bounces-238279-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62317C56FCA
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 11:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B68F23B6072
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 10:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9889833120B;
	Thu, 13 Nov 2025 10:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="fjtaHgW9"
X-Original-To: netdev@vger.kernel.org
Received: from TYPPR03CU001.outbound.protection.outlook.com (mail-japaneastazon11022136.outbound.protection.outlook.com [52.101.126.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 237902DCF44;
	Thu, 13 Nov 2025 10:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.126.136
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763030444; cv=fail; b=qZqxvmmzj9e1KnfIq1XPDiM5Gixp5xFMtPh6GZw4yv1mtmBNnxcChlK/WFOuHnsDPAgTe9JVpL4Rkqr6WKBa8eYmaGoFc0RnEtDS0jElWBU+q3mar07o9UtF6Ass3Wfb5tPqam/+fp7Jimg0fEEtP6acdbjPD6IIPs1W0rO56Mk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763030444; c=relaxed/simple;
	bh=OJ2vdMe5V9OCZrXkJ4jtmMgBEz8B1AstvCH+fjIB4mQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=bhvXr63mNjXrXTTCLlUnCuAXGAiTJEwVUiZ/yj2AQmxqy+Af/nuCOwWovVGW8EZBgvIrjPzSXNPURUsk29vLFeSzGWm85XbNilcuE/HolcDRG9lJ+mRl15NEUhJA67uoDoEHHHNIj2bKiX4JT/VgfAWh0Vks/s1Tz7O7zk9p0IA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=fjtaHgW9; arc=fail smtp.client-ip=52.101.126.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DjASKpTH7A+swpOe4NLKEo94zHXf0uUiAdYRH6+YQDD0VADjohZozC/y6tKjSHJYByNbWdVRGyU15+vi6KwFmUS6XM1V1Ih6bn4Vig/8be7hhUNfFi/4uR0Jlo4vBvsWxrDbDBLB6EDas4JPvahwXCw0npIxL7h2GYRJW6iAdQ39GJtTxNUIBuwJgtuVvlG9lZx/yfxYg9hjzRWPYlvVE4wM83GfW/BrH+VUhthbZjLQQrYkhk7so0u/vfipJmeABcU92NdZFU2gQQsSg9Gw+Y/AFx0GjQIFLy4LI/3pF55F3jXcGePggMdx1C1eY+fRKmIsoSqUJOjeLGGK3wdTrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OJ2vdMe5V9OCZrXkJ4jtmMgBEz8B1AstvCH+fjIB4mQ=;
 b=YS5lr65/1qIzi6MNGsLbRx+7MGq5XfU0XQhwDimUhWOlzPrM5Esu7DI9vqQFIPnSCo1DgV+7842EpLSqS91ypqwR4KQddy0dH7lscBHrGGSwEQ1tJc6wyXBFrJlv04n9dGd17gt/pcl4oif+HQlHcmxvlmk53XfDKYQLGbDcJ3jDaguJ+LhF2IICkKUAWbVQTy4iUYcH5wY8QI8NlrLAcmrlgcHAj5/uPMo+0L5SpLrtrshSqumLm8iF9+de+FiOV2wVwsMlm+bJIVdvbgkrQh9/2Vw+IdmG54P1L5PWp3ycQ07of9GIx/ewo1Z/hekRA3H2riLu1NSYT+b+q/pBBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJ2vdMe5V9OCZrXkJ4jtmMgBEz8B1AstvCH+fjIB4mQ=;
 b=fjtaHgW9bvQ6sBYtoH0gchSmOSUbk7JjlO6EwOva/yXpXS7pv8Y13ygsZdhf2EL3DMyw5n1hFvkHqOme3KrV9DYY+XiaQEkiGFfqQJxsxhxpgX0TWjbYu5iQ0ZfjZOlJACvvk+0G88oKRwuVwwFyu4cOzW7ahaMgeqNz+VUF9evsndao7QRp6TXN5b0Y/8yo2qmBVHrRPDUmyIKd+z4Mj/5XF+PfvAzMWKqfwRp43bPoXRLyI9AS1AhGSe9Lvst6J/fH3MfXcxlbWrhSsftIS0RMPY0YpraYtXnJ0UWul26/wW7iQe8ul6WOXP9UY4NYK171ShqhRhkqPtinzwfMIg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by TY1PPFC2A7D9DAA.apcprd06.prod.outlook.com (2603:1096:408::923) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9298.16; Thu, 13 Nov
 2025 10:40:37 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 10:40:37 +0000
From: Jacky Chou <jacky_chou@aspeedtech.com>
To: Andrew Lunn <andrew@lunn.ch>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
	<conor+dt@kernel.org>, Po-Yu Chuang <ratbert@faraday-tech.com>, Joel Stanley
	<joel@jms.id.au>, Andrew Jeffery <andrew@codeconstruct.com.au>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-aspeed@lists.ozlabs.org"
	<linux-aspeed@lists.ozlabs.org>, "taoren@meta.com" <taoren@meta.com>
Subject: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support for
 AST2600
Thread-Topic: [PATCH net-next v4 4/4] net: ftgmac100: Add RGMII delay support
 for AST2600
Thread-Index: AQHcUjKRp/5wUPPeG0Wo2Pz9fS4A+7TsCtCAgAJeVpCAAKBqgIABWbLA
Date: Thu, 13 Nov 2025 10:40:37 +0000
Message-ID:
 <SEYPR06MB51342977EC2246163D14BDC19DCDA@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
 <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
 <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3af52caa-88a7-4b88-bd92-fd47421cc81a@lunn.ch>
In-Reply-To: <3af52caa-88a7-4b88-bd92-fd47421cc81a@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|TY1PPFC2A7D9DAA:EE_
x-ms-office365-filtering-correlation-id: 6acd2cf3-5459-4316-1471-08de22a11521
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|376014|7416014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?3B+uB8jIWbLevfibYdxCSBrK53yb3pOWdoBGFQ2cStKUG1c0UwnpViSpqaun?=
 =?us-ascii?Q?egncbUus4Na2rr680+YdWvzEuPrZvZJdiSVufR91fTtLWFCPHRPMswPlmSge?=
 =?us-ascii?Q?Tv8dnFjkLzHqvfEyrkktpqRgnvMH7l9kAfhmCLetSxL3WbaefKTKjIQNO4qT?=
 =?us-ascii?Q?g7GoI9kSEPHurkF4sJeGfZt02Ltcrqq4pcy+2nwKr3daZsEECR8Hgz2AorYq?=
 =?us-ascii?Q?uLa53BVsIMjC+XoTRpFBIaekFoW86btqhzvYIWFOzflkRxdtUVZ77PFWPcSk?=
 =?us-ascii?Q?47miV4V8jiz4VCLtEMb6Zs8rUMDPgNEyE9t95YMVP4rGPsiSFQD9DoghETOW?=
 =?us-ascii?Q?ZkplXzcc0rV8pzZrekouD/MA/eSEWAmsDB8kZJXa+7mIC75xqLSqHX+F7XAY?=
 =?us-ascii?Q?ak8tbnYMdj0VJcNk43gYIO5zVe9H6wJAvzKTWzVXKkmvlkvJldBCU7Q16jn5?=
 =?us-ascii?Q?74rDRiWSZewU1790Y7SYtAeWDbW8soqxUk3xC8q7+w6AS4KU39bxSst7lLzr?=
 =?us-ascii?Q?lrIkfWBxAFgJoyV+f0pKb2ddX5AUTyf60Xhov8tvdNbXzCYrhdTvt6mMQrp9?=
 =?us-ascii?Q?Tyw00BzaJgFh3NOzoJZoskSc47F/5mvGlzsYvQt47jkB37ke/Wh4b+EMZ0Qe?=
 =?us-ascii?Q?LE18MpqYBdTrJOoCg1Z08lsUU2U6H+cerNq1F15Lg8FsbYsYsKDlefBBqxHK?=
 =?us-ascii?Q?dw8UdWEnoezhV66aoV+y6rKIZ1Bb3axeLBbEXy1B9KH7EqtxQIW6RdQ4ZIAE?=
 =?us-ascii?Q?HBt/Pj3bKkhALKRYVcF+XQK8l6kmQaFdT9YfXLaKBJVYpKM8dPnzqA2ClX53?=
 =?us-ascii?Q?G/Hh3TPhk0Bx0+g71acm/kLxFSV3WRQR9/akZuHHDGdiVKvO8b2pb1kYlNNI?=
 =?us-ascii?Q?tzfC3Y/CVrqCmLp/QOLrvy2962M7aIWRTWdgjawDkJCAUARd/jEuQNE7sabA?=
 =?us-ascii?Q?wvNdH5FqneOwd7xk2sMoAUUJUFziBbaXubOkNpAE8g7N5WSz234ulBYunoCF?=
 =?us-ascii?Q?d5Puz/uamhZAtFR9gJpVIF6ruz9+VrY0qYFGCuVh4DKPhU/oE5Un8zMmmHzV?=
 =?us-ascii?Q?lK24ACZTxPQ6LNFCDTlf3RIL3oIDgzabT1eRUPk7d8akqec1zO7r1xFUDO7E?=
 =?us-ascii?Q?WmKrH8z46T5gUkaKC1hLNOdY5D0J27LYH/4qLqVFWgqJRzFO2/bAoNf/TUSk?=
 =?us-ascii?Q?wrlzlc5vTLYPd7KZaDpyykXKGQ4zRh1DALi9KetxVZRdgelTgWJqUB1Hjinb?=
 =?us-ascii?Q?S21PG6De7af/RXyY6bfFDqEdB+2N8WnMH/M/VyYojO1CcVW0cK6M1oEoRLVw?=
 =?us-ascii?Q?U27MCSQ8IigsWKwYJzNcrTyEXoSykV8jaDpdPEbBP1ZvuQlfJflCJi4x88NH?=
 =?us-ascii?Q?x2FN7W8uEj5oGsp6BNDXTuDpM68iF072QEcg3NH90qT0WfVS4Fgc+IKofJZ1?=
 =?us-ascii?Q?6rMt0jI1RMj7nl1gNL0/+yBxhCDLklVUg+5YVG970x2HhMzdXJD/LbPPC7no?=
 =?us-ascii?Q?zwlooHIo0DZl2merl2ZaCQoVU4BaLqne4aa+?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?HfRS521P9Mm36ibC8d2At24z9j0BLv3ZUek3YABy8RUXetPVW05+/wjSOxlK?=
 =?us-ascii?Q?62N8Qse1gdmZDeOqoTeLuNnS0yUkaxcyEVDg+7NBvANGIYB1ioA224EDPJK2?=
 =?us-ascii?Q?soLMcMqlmjisQxv3SUVHheWWN5c8kVgJsrra025IrvmGLwFZ/liz+/jn2ju4?=
 =?us-ascii?Q?HIqpyWDMHQ5i1QhDq11/XwcOU2Z8WXssOnval6YHENH8j/h9UbM6teR5AX7P?=
 =?us-ascii?Q?JClzbpliSKHu/GfBmrRaVlyFmn64Gy+1kGDVvbcrLrlfoSNJUbcuK5ozk/Ag?=
 =?us-ascii?Q?HzjsOOZipov2LZ0CzFGgNJTODMH1/AJASyHTEcFfKp69REirWfidp4IvLdV+?=
 =?us-ascii?Q?BKYOFQ1gK9Eq+J+wfRFRvqbNd540LhN9KT/ugSqS2l64GhEp3rH14kiU7xqS?=
 =?us-ascii?Q?mziNfcf+fmkw/N2R2sOG2cd9jCd6rbtTC1hoBn1+QlVL56rtyKZ33kiPzQXJ?=
 =?us-ascii?Q?BSSkDdcDuRCxKWjQLSY3NG5qhjUdbZWbQ+Eai3BL0sy+5T54opC/SZ04kVHM?=
 =?us-ascii?Q?hcmPDYOjs81zVj2DPy2Lda5HVdKcpQ4BPqwN4VgmjpujMr2iN3rsz03/nCa5?=
 =?us-ascii?Q?4YFK5Naxb1qG0gRuEzjLS5Vn2dpNrKo37/YNRXt3rXPbdh/uuoKJCvPjt1fI?=
 =?us-ascii?Q?/uUCR1RbFQEJj4VRDQ4Hsbe0nH8OAjZuXtnrIFhoh6mppalkDpsXqUtWXoV4?=
 =?us-ascii?Q?lqAIKi1Qzpe5bRhzJzO6ruyd0m9cde6BXqNrg95rnRk0b0tTL56pJZ7o71aT?=
 =?us-ascii?Q?Sp9iDRU0wcWtBK/YWalx/bjJFgr4MoJuUzFJJTDuoprxpMWsGdjpHiEWKpg4?=
 =?us-ascii?Q?Dk8MwZk8admvS9FBPHyfL9Z9QREjyTBHtsF+ScLl8aBWmVpoir6Q2z1cViLD?=
 =?us-ascii?Q?xFXcG6aIq+AaUGlGk98aJMNaY9bBmD/m7Y3+fKX4JBf0pRUMk22CBh09qjOo?=
 =?us-ascii?Q?i2QxDCDxDBW7rwBxZweGQNlPWriPdxgbb9oZ5Rw+b8CoSmmbA03OEi7vIqdK?=
 =?us-ascii?Q?Zk0gPDYpFxSZjutyykfn/WQ9hOs7mWEvqkJmlJZ8BqFnHkJySvnjKHoSJ6BW?=
 =?us-ascii?Q?Pn8J0T3E0B0xMDAyFH0f3JBRvq4Qt3UEovwgrQGZ9xnenbpEoP0jVEBmQfal?=
 =?us-ascii?Q?K6c4P2fLpSyC8i1u8gkC/M1WQQlaqX30/xoaJ5nYrq1W8j0E83J8mHtVAA2k?=
 =?us-ascii?Q?ie2NTjxy+QBUefSHaPD9iHfgNHz5UestCx35W1hz8X6+PwAQfYF4SbPUFc7q?=
 =?us-ascii?Q?oDVm6fZu/6E1UTPwFHTpg30hY/aYHhL5s4N0RSIMLqKB8rhNTVc3cV6mtlCu?=
 =?us-ascii?Q?l7eXzJBmupyCG/UvyzolkV8DNkPgcTh+0VAzaQNNUWJReiFd+qwm5NO5X5jg?=
 =?us-ascii?Q?Bi84jv5Vt7ZHAQuJ1SYaqDOih0flbh8T3uJKCuz1uRIIFygcUygALmbA+zIe?=
 =?us-ascii?Q?48DYaU/0VM+JmxGTYN+sbREZ3JRI8CFHoiy1ozFVj9UU4f5aGWesSlbFCq+C?=
 =?us-ascii?Q?Xcy7TaPrzp34PANAbfnqDVa80ts3IYdVRe/1CMjwSTEt0mBh6lHNy51R1I0m?=
 =?us-ascii?Q?UydDYic7+FRl6OnIY12RMzu+Yr8kYGo9Hk9sfeL2?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: aspeedtech.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SEYPR06MB5134.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6acd2cf3-5459-4316-1471-08de22a11521
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Nov 2025 10:40:37.2273
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: ue/9K4dBC6boI2ClYOKnven0quif8FuMcmRrvuyflVSVSkfUr8jqGeyFJvmEKRjqxE8H8u9g6t/JlT0clz5985u1a5M1grJlKVypdmK9E9M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY1PPFC2A7D9DAA

> > > This is an optional property. If it does not exist, you have an old
> > > DT blob. It is not an error. So you need to do different things
> > > depending on what the error code is. If it does not exist, just
> > > return 0 and leave the hardware alone. If it is some other error repo=
rt it,
> and abort the probe.
> > >
> >
> > Based on this for next version, I want to move the "aspeed,scu" from dt=
si to
> dts.
> > Change it to optional and accord it whether existed to decide it is
> > old or new DT blob.
>=20
> I think that is the easy way out, not necessarily the correct way.
>=20

Agreed.
That's easy to implement adding support RGMII delay configuration for AST26=
00.
According to aspeed,scu property if it is a new dts.
If it is old dts, ignore delay setting flow.
If new one, configure the corresponding value from tx/rx-internal-delay-ps
properties.

At first, I would just like to support for new dts based on AST2600.
The existed dts in kernel is as legacy dts for AST2600 and try to bypass
them. Therefore, I tried to use new compatible or aspeed,scu property to id=
entify
which new dts is.

> All systems have the aspeed,scu, so it should really be in the .dtsi file=
.
>=20
> What are you really trying to solve? That the DT blob says "rgmii", but t=
he
> bootloader has configured the MAC to add delays? You should be able to te=
st
> for that condition. If it is found, issue as warning, and treat phy-mode =
as
> 'rgmii-id'. If the DT blob says 'rgmii-id' and the MAC is configured to a=
dd the
> delays, the system is at least consistent, no need for a warning, disable=
 the
> MAC delays and pass _RGMII_ID to the PHY. And if the blob says 'rgmii-id'=
 and
> the MAC is not adding delays, no need to touch the MAC delay, and pass
> _RGMII_ID to the PHY.
>=20
> Are there any mainline DT .dts files which say rgmii-txid, or rgmii-rxid?=
 They
> would be rather odd, but occasionally you see them.
> Assuming there are not lots of them, i would probably just leave everythi=
ng as
> is.
>=20

Based on the above information, I have attempted to outline my understandin=
g.
1. 'rgmii' + MAC delay:
Add warming, keep MAC delay and pass "rgmii-id" to PHY driver.

2. 'rgmii-id' + MAC delay:
disable MAC delay and pass "rgmii-id" to PHY driver

3. 'rgmii-id' + no MAC delay:
Keep disabling MAC delay and pass "rgmii-id" to PHY driver

4. 'rgmii-txid' or 'rgmii-rxid':
Keep original setting


I have some idea to discuss with you.
1. On 'rgmii', I want to add warming and directly disable MAC delay and pas=
s 'rgmii-id'=20
to PHY driver.

2. On 'rgmii-id', ignore if enabling MAC delay, all disable MAC delay and p=
ass ' rgmii-id'
to PHY driver.

3. On 'rgmii-txid' or 'rgmii-rxid', keep the above item 4.

Actually, it's difficult for the driver to determine whether the MAC delay =
is enabled or not.
Our design doesn't use a single bit to indicate the delay state. Instead, t=
he delay setting is=20
derived from the user's configured delay value.

From what I understand, when the TX delay value is set to zero, the data an=
d clock signals=20
are almost aligned to the edge - which likely means the MAC TX delay is dis=
abled.

Therefore, I'd prefer the driver to simply configure the MAC delay based on=
 the phy-mode=20
and the tx/rx-internal-delay-ps properties.

As you mentioned before, the v4 behavior results in a network interface tha=
t can successfully=20
probe but does not actually work.
So, I'm also considering another approach on the AST2600:
to not support rgmii, rgmii-txid, or rgmii-rxid modes directly.
If any of these are encountered, the driver could automatically treat them =
as rgmii-id and issue=20
a warning.

Thanks,
Jacky


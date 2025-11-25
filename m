Return-Path: <netdev+bounces-241361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39D6AC83277
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 03:59:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E78383AAA01
	for <lists+netdev@lfdr.de>; Tue, 25 Nov 2025 02:59:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 768821EDA2C;
	Tue, 25 Nov 2025 02:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b="E8Ls+LID"
X-Original-To: netdev@vger.kernel.org
Received: from OS8PR02CU002.outbound.protection.outlook.com (mail-japanwestazon11022074.outbound.protection.outlook.com [40.107.75.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC101DF246;
	Tue, 25 Nov 2025 02:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.75.74
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764039525; cv=fail; b=j/cX7f0p0bNzFQWwaDfgL0rg+3kRFnzUVs6XosYYsyuLWxrGL2BQPfiWr6tN7D2vQOfxiqZknRtK9iHZYwt1f0490mE1zIxMvjMmS5/EgSVXDaP/WSROkPcwsRszIOdgS5cxuU9UOubWq+fClHu9q/E5VtFPx2xqTGxFCICnG/E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764039525; c=relaxed/simple;
	bh=StJnRpzxMn9k+qr9ibGFEFydOlmHTX9fv12wx8SflRI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LyfShfoh949tAcaPHm2Db3XEEHz4iGDDCuvcGMHXHMWc1gpdIlzOZGu7E3F6ejW9Z7YrmFzKQRoa2Nj7nUiUsA8gX5fUjOtJJmP71vu0DfFL2aFvCKC7jkJUvV0uUr3Lor1qxXCpS5/nZl82Dwg09XaKHUbfXBHMrOOHLGuMbs4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com; spf=pass smtp.mailfrom=aspeedtech.com; dkim=pass (2048-bit key) header.d=aspeedtech.com header.i=@aspeedtech.com header.b=E8Ls+LID; arc=fail smtp.client-ip=40.107.75.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=aspeedtech.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aspeedtech.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cZDheLo2w74ul70hmqFzBPuoWGNSNy2Fg5TVuewbxPVmADLp2QNa9QVrIONaX0jKiCfPmWRRTAfUaHiVhRwo6lOmiwp630mCh+ycVIKWhyNAEFt6Om0+PNwOpjeVKMuyJNB32ZSDoEs55Td0UwX24ht7UGVldh9tx/xhJXOhL6EBzwr+Ax1U/bv9jJIEIVBVrwlEK6gK6iucL9WWHjIW/3VUS0zJx4Xu02l8AG2YOpaPW7Bs+TJZ7aaIUY0Z9L+MX8n100CNcjfPhEYltZJ5sbQApDVcullxCeCD+DYwakvCXePbb/nO0m5nfHAoans9X0K6392TqwXIMtbml7Bs3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jXNRs/9XXgWtQxjvnue+81VvtB40Se3E6I+DAsP8UfU=;
 b=ZKFBJ8EveMgcPtJW8vvKy3ahLYv37/xCaeWTejB0w7RaNSD35k/GSxlRIl4wb9WVYnGLbynZABvTo2bEb4xyQ1AOmJkuA3FRmtwWGVK07DdqQ2ZYwpVKtl9Qytnkg7P6Cpu5qN4oMsK+w0j6c0qlsK//S4+EFBnovAXItb0M3ThnCA3+vZP1M2nKsWCh+w1VbpT55XaQktORwXylq6RZn5Vd2gD8cOW9ueqw1jESUgRrLxcZrtUsegkrZQ8PmVYjMEdpnxnpdJbiP78oQhrettqZDDGQHgN7ExRkpX4FSOB6PSm1Mbwh0W9cU7LxT632tfV1Wpd+NT3OFqc8JcH7BA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=aspeedtech.com; dmarc=pass action=none
 header.from=aspeedtech.com; dkim=pass header.d=aspeedtech.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aspeedtech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jXNRs/9XXgWtQxjvnue+81VvtB40Se3E6I+DAsP8UfU=;
 b=E8Ls+LIDuA5EjSUwNwawvmmgWEbiqT7z3Gwj/d7VZe8Hdee1W907GiHKLqBp3l2J2QjofjGCLhH9VMw8GJ9cmdWKyCXbnM864JlGfDCX16m0jbAaZjgkR+pVLUddqOrOH/mtG/GdM+0Iw/doaEk8dW3OZxp5uaUNxRNvQRfWX3UNCIECladZ1bFonq8UxhOGottolOP7/F+56ybmEK8Lebi3WEUDndrMsEPBDp5wlyXTtuZ3di+Rb7oLnOI2AtB1S9ynlXENYc6F9wDTdgnoZUrymeE1VHVtmI2yf60MsdirRqpY5yuIlcw6Bkn6fj2iUzhaPURLPyjdpZcHTvmOkg==
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com (2603:1096:101:5a::12)
 by SEYPR06MB5648.apcprd06.prod.outlook.com (2603:1096:101:c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.11; Tue, 25 Nov
 2025 02:58:34 +0000
Received: from SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28]) by SEYPR06MB5134.apcprd06.prod.outlook.com
 ([fe80::6b58:6014:be6e:2f28%6]) with mapi id 15.20.9343.016; Tue, 25 Nov 2025
 02:58:34 +0000
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
Thread-Index:
 AQHcUjKRp/5wUPPeG0Wo2Pz9fS4A+7TsCtCAgAJeVpCAAKBqgIABWbLAgAPq3QCADnQYkA==
Date: Tue, 25 Nov 2025 02:58:33 +0000
Message-ID:
 <SEYPR06MB5134BC17E80DB66DD385024D9DD1A@SEYPR06MB5134.apcprd06.prod.outlook.com>
References: <20251110-rgmii_delay_2600-v4-0-5cad32c766f7@aspeedtech.com>
 <20251110-rgmii_delay_2600-v4-4-5cad32c766f7@aspeedtech.com>
 <68f10ee1-d4c8-4498-88b0-90c26d606466@lunn.ch>
 <SEYPR06MB5134EBA2235B3D4BE39B19359DCCA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <3af52caa-88a7-4b88-bd92-fd47421cc81a@lunn.ch>
 <SEYPR06MB51342977EC2246163D14BDC19DCDA@SEYPR06MB5134.apcprd06.prod.outlook.com>
 <041e23a2-67e6-4ebb-aee5-14400491f99c@lunn.ch>
In-Reply-To: <041e23a2-67e6-4ebb-aee5-14400491f99c@lunn.ch>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=aspeedtech.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: SEYPR06MB5134:EE_|SEYPR06MB5648:EE_
x-ms-office365-filtering-correlation-id: cc29e808-26b8-4492-9b0e-08de2bce858b
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|7416014|376014|1800799024|366016|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?7y1pgz3vSY8HSE7PKFuh+1w+8Tc6MBOaIhvAZoQv1AJVt7PuMk5se8XRSHKM?=
 =?us-ascii?Q?e6VkiqUCKWtdfahteA755RyLOUD9fZO2FB8ouwBFQ8ypVIXuKikGUAMMDVdu?=
 =?us-ascii?Q?087qG6+KjRpwrHJDG1CPX53rY+P9ELs9p73nSDaUQxyXqUcwLTCB7XMKyMhb?=
 =?us-ascii?Q?vdYuXiqu95O41v1TIOqSsuRWcHy0cDMoncmEafUUw5RHibWEurTKZdqPkHEh?=
 =?us-ascii?Q?UdFaEbaX0vnA/zyZ4MT3bogjiQvT7GSrJNDPxowF+KLxBszUBKZNerTm6vLD?=
 =?us-ascii?Q?3RVS/nKWlob3EkVqZg1E3KlmkaPuIcNt7UKEP6VQeCr5Iu/C6LJlbeDYdyoG?=
 =?us-ascii?Q?KvZAmMYZM5V+TFvSG+sJeL+Btsq3TroVHN3I5x0DciOR4vu862STTAusGSLS?=
 =?us-ascii?Q?FK8WrylZL34gmev94h7QB7grXNnAzwHEEwq4xFX5ZHegoX24uRG9PWiUJrOX?=
 =?us-ascii?Q?DOnBqMoXeimdVcqMa0RvoDRtSTirN6wsLlD9PLCsqhI4IqNQqvEUOe1vY2/3?=
 =?us-ascii?Q?F6xnPXXAr1tWUOBkcmtyU3wSJe3ijwNOfuNMSzDgzmEIt7Qa5dPnIyAfK+Nb?=
 =?us-ascii?Q?FdqAj4THhtxz26b0Ljk2uhyso2rt5htPBEN6oZENPYZYJNIqDNMPXgZLQcRY?=
 =?us-ascii?Q?RAmOUoLsZQN1N8+IvJN73xtaIf5RwfdDjnZ+Nv92JgPYqW/zn7Khtizw6ziv?=
 =?us-ascii?Q?DoqDPFVUVKjbHoSD8RYg5Uef16XCoum/9mYaWsFo7hZQ1oPn5eKLxxkS0L9e?=
 =?us-ascii?Q?mM76NwOAKjqZw/KscEvVjs66HTv3WlST0DJ/+YVhLVRnPQGRih2gaRMcZMCD?=
 =?us-ascii?Q?Y+4r51xA1oHt1R01aS/ENyvkv6IcoOt1oqWS5yqAYbKOqZ9zLhbjoXVjXn2E?=
 =?us-ascii?Q?du78h4yX3MeozMfl+Bsh5vN+IxcIv4sc/4f9RyLBaOM9Q+AoGMQrA6dOgft8?=
 =?us-ascii?Q?bwTCxoCODPGR1QvaZeVbdNyIS3Z4Q1Qi6S3gEdPG/AxOekEWV3foDBzwbhi0?=
 =?us-ascii?Q?hn7A7nMBdMKj9h4Aejy4IjWeRfq7W5kDsY6VzZBKU3w0L8vjguasuoZIwMuQ?=
 =?us-ascii?Q?tu+30xiTHmAAUm3GloadcTAaUBTGLVmrPK5ASoB1Fz+BZSem8TV64DzXjixN?=
 =?us-ascii?Q?9zXIuYmth+MLG4CT0jwUeqsTDbXvp8lENNwRa643nxZgEENmrPKAFLxDJQ7J?=
 =?us-ascii?Q?acNgl/1MAPOcG7z5/90iUdAwxRXdX1z1jm78Bd8J+UD0kCg4yXv6aY+V87qK?=
 =?us-ascii?Q?s9zE1jvLwq6u+qkyjruNUq80Qx18V9KnKY27EWF+ztsiPUxNrRF/MPbBOSWB?=
 =?us-ascii?Q?1h9nBLrDqfw513gR5JZ/Hh/xFOX3t48BkU1aDlrl9YKrlb9zWWrQujYLj/VG?=
 =?us-ascii?Q?eV5tzK1w5qJzZtjrflTqYhtSrvAtu32x0/1O9ePX2ga0WIPHsZvPOLj46rzF?=
 =?us-ascii?Q?Os2CyyeMWd/Hvfh9B5oAqVxqAMng9p8Ew/kDzQm32rSYvMgOqX4ceNAFzVJT?=
 =?us-ascii?Q?Pm3ZH0lvivGRhGrQQcm+B1rWea2B/b5EhNs1?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SEYPR06MB5134.apcprd06.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(1800799024)(366016)(38070700021);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?OYihrf9LpzDsrLDxThUMoTOtke8C6tkpphb6ZybOuXpaSg5+fL4zye7onSse?=
 =?us-ascii?Q?aafnKRS11kbyyFimoypXo6PL6/jM9NiqbnHEkjTmRvtQmR6xLZSUfLCZa4H5?=
 =?us-ascii?Q?0qAw2HN0WRiuokFerrAba8DS0R2RXs/31N6r+E0J/K3J8wWtJh3ApX9pphJq?=
 =?us-ascii?Q?Rak2AD3MPco/co/na8meFgS0nLlna36wXbxZpRpnptYCP1foDmB3XOJzKOp/?=
 =?us-ascii?Q?pYKr+pehej9AyGDw9NTpWVl4NuGqSGW0XEoY/YKQp4e482FUU50Lv50IHp7+?=
 =?us-ascii?Q?lcdGJ0F51QkCFu7+lA8PeLBR0V2orE4u0W32Ku1GSqOWIfnuocBvYvuqfczd?=
 =?us-ascii?Q?FxSHu/D/Sd0tWJHo/7iGHzIkA+QcPHL+3YxyvB7PmJ3si/bkOVoaqxFXMWzp?=
 =?us-ascii?Q?HWG6g070Cpr8/xz3kyIbdV3z04flS+v3kwAtYTua3k15mojbUULwC1eWOa0f?=
 =?us-ascii?Q?Q9TCwDA+SSwldlzT3NC2wkmScIYS42y9BYdPtF9WUzB5zfBTVETD1qEpT6sA?=
 =?us-ascii?Q?f/mb6/UF7U8L9Roz9gJ5ZV5qiPTcFLDb2srADCul1LBRGqSGjuwSYbC3V0co?=
 =?us-ascii?Q?JGg2VxGrxISaV9Rf34MHMQmAKnLPXdhpf6D3aA9ngYR//CfzcFyBVS0asrxM?=
 =?us-ascii?Q?zvOdHKwGVrLpr08akHBKeVpYClIB1I9e0VvKOJ+6wfgJ77k8QGC8oF23HxNb?=
 =?us-ascii?Q?OXFc58yVqhoKGnby+Sxm1QMWI3aMCKwJ1QB9IIYVxipgBwW5+AePF7VJAGM5?=
 =?us-ascii?Q?SELtv/mYy4ogtSU2jJKfJezbTbBBj0YKy8zm7ok0T9CGRh0gIlJYwVEYXJTU?=
 =?us-ascii?Q?BEihzdlWwRsShMesz1uKD5Qgin3af4q3Ap+tpqQJK1mW3+f8d9rXo85CiBbP?=
 =?us-ascii?Q?km+lnucJNWLLIwqh1T8s2V8UqmPE7y0tBNFAFx5CMzbjo/+AWtHPdQoaKKmE?=
 =?us-ascii?Q?S+kTc12QotjhXtLXSHXHuSC7QSL8yZWlxoEvzb9Egs8uVx57UnFHMZI33qhA?=
 =?us-ascii?Q?G/X/ZuydxnqEh8TNzgJRMl9f5qaouq42T6n5pXP17UDJJnDEL/f8P32FmYZ/?=
 =?us-ascii?Q?mXvfpZ91zubl4GnTI1Su+spAhqpbznIOrwfeQJ8AH2vtRmGlHweF/ZruELgl?=
 =?us-ascii?Q?/Cfi04+SNEXdN6KC4sw5tz0WBKCACQN0D8wSaN23ziY8mJr1yZndnnJCVjmN?=
 =?us-ascii?Q?1MvifmeiO4yrf1wF/2aPaqrtF8vcIegkOgUXKFZ0X4svBzC46/eJR+T+mXPG?=
 =?us-ascii?Q?yJto1y1/0Hkq2g3RkLUjGbGUcyZEXZN9zk2Cfqa+D3mtYwU903n9gtg7eN5c?=
 =?us-ascii?Q?CX9j+fCpiw9UcHnJvIY7GZ010jnUXdn+UAdPB6AJ1VuJmMZsABmXC3fsyZkp?=
 =?us-ascii?Q?7zL0yqZfCsY78ej6RGnaIgcF8t1r3pibqJ7/PF8OhjQGKltdYGhYZpCTroyf?=
 =?us-ascii?Q?weMaiqOV9M9RxEYd6CzzRFsSmLvL8a/2g6kJ6JmLK97n0heHcwr58IWwyaQP?=
 =?us-ascii?Q?x+sSWsWK07qHQcK6zafjFcJ+MIyxAAfLQl7Dahpe8aJWmHz7M+c14gK48/l4?=
 =?us-ascii?Q?68MyOOIbJmpPeSdqrqX2tq9ELfEPgh+Sr0ibEp5e?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: cc29e808-26b8-4492-9b0e-08de2bce858b
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Nov 2025 02:58:33.6674
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43d4aa98-e35b-4575-8939-080e90d5a249
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ed5p0tYtBDDmEpU5H6ksHIY0PH/FS1Hg2B7eRWviTMLPDvoNvtDYYbUlAb4/szxxoHZPi/k6CODsMNISdTsRUNWp4Gzjl2jeO2onkrxQOS8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR06MB5648

> > Based on the above information, I have attempted to outline my
> understanding.
> > 1. 'rgmii' + MAC delay:
> > Add warming, keep MAC delay and pass "rgmii-id" to PHY driver.
>=20
> Think about that. What delays do you get as a result?
>=20
> > 2. 'rgmii-id' + MAC delay:
> > disable MAC delay and pass "rgmii-id" to PHY driver
> >
> > 3. 'rgmii-id' + no MAC delay:
> > Keep disabling MAC delay and pass "rgmii-id" to PHY driver
> >
> > 4. 'rgmii-txid' or 'rgmii-rxid':
> > Keep original setting
>=20
> > I have some idea to discuss with you.
> > 1. On 'rgmii', I want to add warming and directly disable MAC delay and=
 pass
> 'rgmii-id'
> > to PHY driver.
>=20
> Yep.
>=20
> >
> > 2. On 'rgmii-id', ignore if enabling MAC delay, all disable MAC delay a=
nd pass
> ' rgmii-id'
> > to PHY driver.
> >
> > 3. On 'rgmii-txid' or 'rgmii-rxid', keep the above item 4.
> >
> > Actually, it's difficult for the driver to determine whether the MAC de=
lay is
> enabled or not.
> > Our design doesn't use a single bit to indicate the delay state.
> > Instead, the delay setting is derived from the user's configured delay =
value.
>=20
> But you can turn it back to ps. I would say, if it is > 1000, the intenti=
on is it
> provides the 2ns delay. If it is < 1000 it is just a minor tuning value b=
ecause of
> bad board design.
>=20
> Do you have experience from the field, what do real boards use? Are they =
all
> inserting the same 2ns? Or is each customer tuning their bootloader to
> configure the hardware differently per board design?
>=20
> You might even need a more complex solution. If the bootloader is adding =
a
> delay between say 200ps and 1600ps, it suggests a poorly designed board, =
and
> the PHY adding 2ns is not going to work. There is a need for
> rx-internal-delay-ps or tx-internal-delay-ps in DT. You can give a warnin=
g, and
> indicate what values are needed, but leave the hardware alone. If the
> bootloader is setting the delay > 1600, passing _RGMII_ID to the PHY, and
> disabling MAC delays is likely to work, so you just need to warn about
> phy-mode being wrong. If the bootloader is inserting < 200ps, and phy-mod=
e is
> rgmii-id, that is just fine tuning. Maybe suggest rx-internal-delay-ps or
> tx-internal-delay-ps be added in DT, but leave it alone.
>=20
> Whatever you do, you need a lot of comments in the code and the commit
> message to help developers understand why they are seeing warnings and
> what they need to do.
>=20

I try to summary in the following informations that I understand.

1. with rx-internal-delay-ps OR tx-internal-delay-ps OR both

  Use "rx/tx-internal-delay-ps" property to configure RGMII delay at MAC si=
de
  Pass "phy-mode" to PHY driver by calling of_phy_get_and_connect()

2. withour rx-internal-delay-ps AND tx-internal-delay-ps

  If "phy-mode" is 'rgmii-rxid' or 'rgmii-txid':
	Keep original delay
	Print Warning message
	  "Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"

There are FOUR conditions in delay configuration:
'X' means RGMII delay setting from bootloader
A: 7500 <=3D X <=3D 8000, 0 <=3D X <=3D 500
	Mean "Disable RGMII delay" at MAC side
B: 500 < X < 1500
C: 1500 <=3D X <=3D 2500
	Mean "Enable RGMII delay" at MAC side
D: 2500 < X < 7500

  If "phy-mode" is 'rgmii':
	Condition A:
		Keep original delay
		Update "phy-mode" to 'rgmii-id'
		Print Information message
			"Forced 'phy-mode' to rgmii-id"
	Condition B and D
		Keep original delay
		Print Warning message
	  		"Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"
	Condition C:
		Disable RGMII delay at MAC side
		Update "phy-mode" to 'rgmii-id'
		Print Warning message
	  		"Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"

  If "phy-mode" is 'rgmii-id':
	Condition A:
		Keep original delay
		Keep "phy-mode" to 'rgmii-id'
	Condition B and D
		Keep original delay
		Print Warning message
	  		"Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"
	Condition C:
		Disable RGMII delay at MAC side
		Update "phy-mode" to 'rgmii-id'
		Print Warning message
	  		"Update 'phy-mode' to rgmii-id and add 'rx/tx-internal-delay-ps'"

On 'rgmii' and 'rgmii-id', just condition A is different.



Because the driver may need to update the "phy-mode" of dts, it need to add
CONFIG_OF_DYNAMIC in ftgma100 of Kconfig.

I list the flow in probe() in ftgmac100 driver.
-> probe()
  -> Check and configure the RGMII delay of AST2600
    -> Call of_phy_get_and_connect()

Because of_phy_get_and_connect() will get the "phy-mode" from dts,
The driver needs to update the "phy-mode" before calling this API to
Connect PHY driver.

I consider these adjustments can cover older board designs and remind user =
to update
their DTS and can also introduce new board designs with 'rx/tx-internal-del=
ay-ps'.

Thanks,
Jacky



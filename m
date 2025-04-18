Return-Path: <netdev+bounces-184150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 899F5A9380B
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 15:38:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A04AD17C416
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 13:38:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73E6F278146;
	Fri, 18 Apr 2025 13:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="mg9FHfS9"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013046.outbound.protection.outlook.com [40.107.159.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B9B627700C;
	Fri, 18 Apr 2025 13:38:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744983517; cv=fail; b=jzFtbeo9Bnbdd1YhiI8CxXwYpaXLlqUcyNpk5vMvxe6UG+u59oBMtDHcvj+Pks8eD2TiWAxIgpyogkv6f+xtk2rUmQ+96i7CPbPOz7t4JYpoMTeGoeN4FjznFLlhBSBXfIemSTRNB52TAYl3c3YQJyh+jVwTyndz3WlyRcw+rf8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744983517; c=relaxed/simple;
	bh=moz2xpMvo3Ix71uoWvk4v7Te+jrP05HVoQ+ZvcM8xIw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gNPFtpF2xlLhamYvd0T+sBzC8gP05tr24/D8mcoQ6A2ncThh/uAkH4hdQy78o+Bdlqj3CIWwpgsRvVnAqKm7q+2TC1fP3JCENNEzUWCpl+bU+Kkodi1mjEqGYUrh+unMZOQWREzK/rzz5JoFEGVuv+3HK/Ksyq0sIsBQI4cwR8o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=mg9FHfS9; arc=fail smtp.client-ip=40.107.159.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=toEZl021be2yhx75eiEE1nbigGLZGG0xRYDNt8YBG7RvzpMkEk+0qEzaJWONCheb0uo+mawhYnB5V42uI+52VrVnN9MG3pmSHX8TXp8wh3BM7GW00N/5x6KPI/8Xr1mJfYsR2AQwb8h/0UmKrjabTfNzBR/c16T7kLrbC4X71eDvZ93lJuh1e84/wW9LmlrNaTSaRxJlvn8G/DUyYJO3uCbThbM2tTOvOmloCNzjRxpbRjNXKhJOfcd/FieJsrwosyYzEtiUnMa7FfDGlJWe0KMTh4Yr6uzRDq0H058bmTX6VbdViCe5ttiMMQzAsuAEegx0UCEXLFSi0oA+D4kD3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=moz2xpMvo3Ix71uoWvk4v7Te+jrP05HVoQ+ZvcM8xIw=;
 b=GkwyMW7n5hVVPa6P292bLEjhjKVMH7JRBBk+gTjgYiqerUHBy/x6U2UqoribDEggX/EhjJDv2ueruY+Za/GDUXBw6AE43pCcQeeCLIcSd7T9rvEAtA8M55Mp+UEYXFbYA7RziLgQjnN2WQKa3Y0LHDqFCA7EJEuJb/ip6AphArfxqeGMOJaedIKuQgF8XF1xiQHtkRSBnVAfDF+I+mMbo7TJOtFJnmvR6NeC8CHUGdgvngC54HzRnkZXpxqJzykMqknfxzYbc42ZhrpOeQ1S+IVyHgEH9azSg/SDSzotkLkid+fmu5O2VPnhsle28tSq5xoo5EfIMgHiRYKWBwNKLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=moz2xpMvo3Ix71uoWvk4v7Te+jrP05HVoQ+ZvcM8xIw=;
 b=mg9FHfS9M8w0XrS14HS2CrlWZsjPsA6yAzwdkgRGQLC4Gnt+P7M4LDAMX7YCekrgF/9U191sw1CMIyFaxSye6Uw3s5XJlaki1bZCvBKQorHHtkFRPGVuHwaLbFF2etCBB6rfQcUAbAcIGJpwN+5l/gOfKu/JW+rXCTc3HonuqRPzKZ5f4OWeZ14YLYBeMG6pCA6dqLVSKXu8ORZKKS6EUqcKzzBjmVrFNk1/zV3nApsupUDNfYZDSlrZbUvGSuuJ/nlOzZdgyIxZV1254PUWvu0SnND9GswdJHcLRBDsBml2NSa5UpvlffWyZPBNbH7bCHXgmlwRNaRjKPNCbJLe9A==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by VI0PR04MB10735.eurprd04.prod.outlook.com (2603:10a6:800:269::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.36; Fri, 18 Apr
 2025 13:38:31 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%4]) with mapi id 15.20.8632.030; Fri, 18 Apr 2025
 13:38:31 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <olteanv@gmail.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Vladimir Oltean
	<vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	"christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v5 net-next 01/14] net: enetc: add initial netc-lib driver
 to support NTMP
Thread-Topic: [PATCH v5 net-next 01/14] net: enetc: add initial netc-lib
 driver to support NTMP
Thread-Index: AQHbqsrezU/enlrTaUytzwpaMrx9ubOpav4igAANP3A=
Date: Fri, 18 Apr 2025 13:38:31 +0000
Message-ID:
 <PAXPR04MB8510715CEE1461C5CC8D8CC288BF2@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250411095752.3072696-1-wei.fang@nxp.com>
 <20250411095752.3072696-1-wei.fang@nxp.com>
 <20250411095752.3072696-2-wei.fang@nxp.com>
 <20250411095752.3072696-2-wei.fang@nxp.com>
 <20250418124905.2jve2cjzrojjwmyh@skbuf>
In-Reply-To: <20250418124905.2jve2cjzrojjwmyh@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|VI0PR04MB10735:EE_
x-ms-office365-filtering-correlation-id: c12a4827-8c5b-4490-1b50-08dd7e7e4ee3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?iUO59WnN9Wev2iy6Jkcye4NN1z1H9WYstvEWANX7lab/PdqCFaO+gYJZW/U7?=
 =?us-ascii?Q?SuXOHjY/ZhjjKskCjZcUBOLf3UtNqnjs8pI5nziSotQcefWLIZ29VG1thC6A?=
 =?us-ascii?Q?4BF0EhZXOpIdC8yddVm4JfDebpDc3NnC630xIIPJCHCaAkvqOKVa0CcVgWrf?=
 =?us-ascii?Q?J6tcMmkYHN8+Zw+vg0ZK12mD9jgbr0eU9jnknU0Xsc2V88ph2BSEZV1aTrHB?=
 =?us-ascii?Q?A1ORizBXlxLJftlIxwDD9SdqHKfEQMtPQifDw2UxFSgqHIWhBsS32+MWXnlu?=
 =?us-ascii?Q?vcugL38+SbsvA7W+zwU2Jg36tx8F3JrW56j7tMZG3gtqH4IjOXrvgAZeY5Q8?=
 =?us-ascii?Q?UzNCVzDMwXOvFJQ76KkYaK0frjrUA5keo63Xu7ANcqCFnnFpvvF0i4ibGc7u?=
 =?us-ascii?Q?AKC1SVg9SLXYE2oFJQnI9snortLGuLrF0jrSM54mJ7kEg2gELE4EtOxwA7Gh?=
 =?us-ascii?Q?egA8wnaoSFBl7aB7gQtAKhrjq6Tv1J0tgU5FRfSLF38/OnAB1ijyZkOu1+t4?=
 =?us-ascii?Q?hFfOjKzwxt8JmjvD87a9Lx1UTiOdyI7O65pVCfFCbdkVXYC4FO2IZ5NvnIym?=
 =?us-ascii?Q?iWYgsBTN4hBhWlvzZiQA0fVzyAW2DoQ7aEOfEgPTqczdNpSgRiFCDkHE7nBm?=
 =?us-ascii?Q?ijP7GsEuz6q7d85G6WOGOtBxQeT+rKe2E63C/dxa4c0TSavdjUGYJNWVn27L?=
 =?us-ascii?Q?1p8mmsNkfikVCXFbOP2z3yUlnc7zPAkgmbGiJNVQLaJasmGKNrLNiIXpNUoS?=
 =?us-ascii?Q?5XDovtLRCXgwVXsX/sfT5UNdG0/orI/Uws3v+CyjF2YnRfhqasnNSP0xEY2j?=
 =?us-ascii?Q?mC6kVGnFTLUN+hjmTfOG19cDv9xLetxOrfeEjScbo1RyIhKs9QMYwFKubKWZ?=
 =?us-ascii?Q?AvxHuyST+PZlbrmnXnWbn1ZoVvNm6RC+qRgOm7P+GTEfYxoTqS4l2yamXrac?=
 =?us-ascii?Q?YAZlUZL8tjwW6VqYfam2i5vG2DvxpmtXmXkclrZYN95bKvQCxOHsWVJghEVW?=
 =?us-ascii?Q?y+g1EBaWRpHWhA2AfjNfc9sBBO3tiv3dnh5zv3yNgs72cywUWpQ2C9CqMbl1?=
 =?us-ascii?Q?WaQtAVuCT4Nef2G5JK02I4NTmuSZZTVecoI0rCfeDHdln2bASQ+hU68Ehtux?=
 =?us-ascii?Q?5fzxdZiqoLQj3mv17cNN3d/C/MY15VxMPqkgfz5dD3NbVdC3IFGzEnpsebps?=
 =?us-ascii?Q?77fA3URf+NvUQbUKVwQR2ppWaQY+8w5vABDH8krwUM3ceYlAlCKJICk+6nTo?=
 =?us-ascii?Q?BuSyRR7r89P7xxrsiI2TVk5mmInFrlkJ0DPrLT6+fpHHmldfE96+p+UU0tNN?=
 =?us-ascii?Q?EsrAJh/N1ADvC91Vu8JY5noqI6gWINvMLkTQLhxeljmevtEX07uSs9D1uu/X?=
 =?us-ascii?Q?Y967gApi5GzM6BIl7dpPCbikaFM7sebzNoaGx7IzraD9OkhGLNideR4Wh40r?=
 =?us-ascii?Q?c5vCUBbeHCEgh++Hru8mg8xzUBgLW9+FgRVNhMFlmhIrd2hFKA8HV4Uz30Ng?=
 =?us-ascii?Q?cHGCaFmQuRcU338=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?/5ALQSixI7EpQ7MPz4pMaPqHV4BR3pdDK0Frt6CHbjcq9yvJEyA0zjdhJtyh?=
 =?us-ascii?Q?9FqFOQ1txD76oZ1QHxFfuTjkzSkudmazFqZqgBo//e+//OYjiBS357Nwj9rC?=
 =?us-ascii?Q?Hwcun0r09m7/TLh/gl182hyVLwLBOEeimwP7J0edDB9EmCRPKAa+HiDPldho?=
 =?us-ascii?Q?Lh66Z8hQ7fWT5cQ1KlQ/zRBkzxADTS2pwCYK6ZHXAEmwWT0vkC9ZoL79qEDo?=
 =?us-ascii?Q?N58CUtm8ADDfUK4Z/6Mhd6zimznHKACHGmA5taansVbjErb2sxAXWTdUYADs?=
 =?us-ascii?Q?Aq+L243kMkMso9Yiulrm9Y4hbDToqMDdqWdQgKmdV4gn/Vx9MFBhPJaAAlX0?=
 =?us-ascii?Q?JsQkdXH+nRPpEkbAQt8u+6jYrsoGCbEmTAXFrIp6gW14nCNXCG6uAW8GUhO7?=
 =?us-ascii?Q?uzuAdhTz1gyyPuk+uKOOhu4ZBYUc4Ky01jbFNmJV0QoIycwzRK3W9l+gX7cD?=
 =?us-ascii?Q?k7CxGi4vzKz3PTzEiZ4iGfT0FPWxxerQ/ULLmQxZlEqF8+ZZp5L8Jvzeq8NN?=
 =?us-ascii?Q?H3CoAIDa9/fE+5DstcnfAbjILi8TjkhmjyQutKoewXgu6Eiwn7ynLSJnjc22?=
 =?us-ascii?Q?dXaQLlMV10rAHEYrogW76K84klwhyGM4SEaQdKMDlMvL8lYfSz7X5ptC6lYp?=
 =?us-ascii?Q?Z1EW+NJPimLqhMkYKhyjW3iklihGA56OLHtW1uI7CU6DpehkmnnX4hKtsg7D?=
 =?us-ascii?Q?kJVCxeDa/sIU8gN/V6LnsbNy591uD4SCrFoqJyNEAdJZ3Ljpuu9+hDwZF0Zn?=
 =?us-ascii?Q?ewXSD8qvTKaM9vQ/IeizPNW5nNjrDkmFmniIjk2+lllSi10ipcWdEoaf1ibQ?=
 =?us-ascii?Q?7wlwaVS4lcMOckniM9amCR/5ZnfM35U7GdoTywyv5w8KQ1/s2pmtHc5pr5qb?=
 =?us-ascii?Q?VIkWXmwKAQiuaCbvN/+bGGyQyyXmREQCgkOm9SfMdonp4iaLm62VGQtrt7wq?=
 =?us-ascii?Q?EE4xhz05O49m5KlfriArUWFIeeXrJvA/iXfN/1mfw1cLxGLd2DDU2uOsTfQ/?=
 =?us-ascii?Q?d4o143xhy2LlLak+Z8Oe5LHV2xOpVxmXZwb4ov6LbzVMQb5Z1vFvuAUG+4ZV?=
 =?us-ascii?Q?k76e5ArYNqb6y4kkO5iznxB06Nhgco6X/tUlr2o4m6Y960is53LuSuFzfrJ/?=
 =?us-ascii?Q?PTEtW8zeRMRwbBwzLEO/yzYCrIeujhfBk7j8ivHWXJwRUq4a7G54ausDIDKI?=
 =?us-ascii?Q?X2SDd947welLuUvKtKKmJjfPCivQ7BTbT0tCPwo/mrGvmK4MQXCC+2V+2oPW?=
 =?us-ascii?Q?iaJRacQSp2400G7DVxuCMHGSL9LRODwRi2wlkd0g/zUNPH4Tp/AmKdd0EwiT?=
 =?us-ascii?Q?MfK0mMGgpgojYxhzGOBd5ndKlqlp01Jg/FgE8iAUy2Cd9Kn9LguEwq+9HxJN?=
 =?us-ascii?Q?lPto6uJkBhgAobcgLGhETkiVQp6VirkhdQVxN6Ud3aIt8YyITn+HcZsvfiFv?=
 =?us-ascii?Q?LrG5SQC2XQOKuJBFKDm7TXAjZxUfGGDr7tPo72hGrxEAirfvVg/P+239OY0u?=
 =?us-ascii?Q?e4UhyoWNZazq7SLlf/Fm2fsW4jUDAIM57xuoWXkJ3eC0gJY1gqYSGtM7uTUd?=
 =?us-ascii?Q?vKOkjeho7yoTE69ArvY=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: c12a4827-8c5b-4490-1b50-08dd7e7e4ee3
X-MS-Exchange-CrossTenant-originalarrivaltime: 18 Apr 2025 13:38:31.0389
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EgyqXrgx5pFvZQaJMx1kh6Ov96v0ed+vnVItW1t5s/uAAPcHxpKl9iatodArmmvDpbVTlBvRbfeckFzriV/8gg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR04MB10735

> I see this is "Changes requested", so here are some more nitpicks from me=
.
>=20
> On Fri, Apr 11, 2025 at 05:57:39PM +0800, Wei Fang wrote:
> > Some NETC functionality is controlled using control messages sent to th=
e
> > hardware using BD ring interface with 32B descriptor similar to transmi=
t
> > BD ring used on ENETC. This BD ring interface is referred to as command
> > BD ring. It is used to configure functionality where the underlying
> > resources may be shared between different entities or being too large t=
o
> > configure using direct registers. Therefore, a messaging protocol calle=
d
> > NETC Table Management Protocol (NTMP) is provided for exchanging
> > configuration and management information between the software and the
> > hardware using the command BD ring interface.
> >
> > For i.MX95, NTMP has been upgraded to version 2.0, which is incompatibl=
e
> > with LS1028A, because the message formats have been changed.
>=20
> Can you please add one more sentence clarifying that the LS1028A
> management protocol has been retroactively named NTMP 1.0 and its
> implementation is in enetc_cbdr.c and enetc_tsn.c? The driver, like new
> NETC documentation, refers to NTMP 2.0 as simply "NTMP".
>=20

Okay, but enetc_tsn.c is only existed in downstream, so it will not be
added here.



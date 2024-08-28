Return-Path: <netdev+bounces-122603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6564B961D3E
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 05:59:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89FF41C217A8
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 03:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD9313210D;
	Wed, 28 Aug 2024 03:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="NwsIvF/7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2047.outbound.protection.outlook.com [40.107.220.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873B369D2B
	for <netdev@vger.kernel.org>; Wed, 28 Aug 2024 03:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724817571; cv=fail; b=o0CiAKsPAeUOR3nztAe/vJL/RbQWimt8dSSpCQdc7wUdn/VpomZrYIugPgGaBLoBu9OD6vDGfCTY/9kUX05vFlc1AXKL/M8A2D7IIKcrW6ycWf6PVA4kf9EIuqaGTQpaXV+yuC2D+cn+gJItD4Qm9tgbN7QfuI7arfPI0nQDJLQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724817571; c=relaxed/simple;
	bh=qY89+G7PMA49J9RswnFAwOvW/rBCZq3HXhvkjsIXFo8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rIP/81gLuGM1TK5SgAMkcDNe9pXYobdwa3WLAq8gjGZruP7jwXfS8V2pAUHJK82uuTutWrnagxQySLpBPn7pA5eyAaXJPp7VOrcZloVo1+wuwRHB93/MN1Im2i3uhq3ceoBqg4gD5Jo42l9A+SaR+4XvvQFFfo+Os1l52mbcsfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=NwsIvF/7; arc=fail smtp.client-ip=40.107.220.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=THaHGr+9GEv2VUpzogbVbaklTcYJ3L+kIxVNOqpr0a9RLOQt0mg/XD9lR/FmsnHhU4zeQEfbD2dxwW8sR+yMaJfz8xnvQB2dVOvMQ9cQ2fegWZdDoiCiFepBslk/Rg5NeVbyW4TLmE0n42SNWzwPWwdlyvz/G2lGUpdhHxnx+vsqhQF1Uvbogow+HcRniQ0pAlPXI4a+SSWPDvriHYpMlpOW90+wlZ4N4jtntzWabHmflcAxzUIqKLO7u54tL2B4fY5gmp+mO2JEgKuW/DMfwzMTM55gqTHLvlPpE24egnXW+Ij6ETIn+KMHDWuYcM7uRbEG7LKiHgn4DD+U1RzR7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qY89+G7PMA49J9RswnFAwOvW/rBCZq3HXhvkjsIXFo8=;
 b=nsRsQagbD6njxea0Snp4F70DzAxm5LwUeq/IOj91bXaFhI0euTKhKzd2Xmnl65+lu+iRpHEQbbYPP7lxzWZ4p/BsJpIdLncavnTs3eRB7U0EQaj6zUU7oOFNtgpT+dsaIMT0SFuZfG0niSYkjyxPUF81UbzzOCu+yKUkcHyN9VEfsaeixNA77HoE+dWQTfDHNH0f4vymcirr1ejNeKzF47MIHBcNmDcIu+fys1pUkRwJwlfPnUFRw3pwLxntRgUSJVFqRtsiGnPtaqE5pIvNuY+4zlAemBNiZqtmycBOOB8EqU/MCvq9a4z6OhX2W3ONYRZaDeek2pGDUru4Znd91Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qY89+G7PMA49J9RswnFAwOvW/rBCZq3HXhvkjsIXFo8=;
 b=NwsIvF/7cLsoxvdYFQM442yHakfkZbBa/MBmGM5fiYKv7G+qZ1t6RDcQDCldekT4EsrNkHiBD0xGjpGTmkUP492R8T937D6bvSNDyuR2Je5qfXldIYK6ILlQmKfV3SVwesEZIH7EQaHlC4Trz0MNxIWrrSBofDr2DIKtwuQ1KJjlvcEoHbbjbAva3LTHaDonWCU831U7joUVceCA95WeDkl5QxQ8U9CVEdYf4F3unsrKDkkCbP43PZzuAeBERVqxVszP6rzzoBQiXD01w2Qz3qoCvhdPH2gx5MoyiFURSiOP/GGrH0u8MJrEmtmqRxBcy+WpXs/tzRBPt3aNc4Bfxg==
Received: from IA0PR12MB8713.namprd12.prod.outlook.com (2603:10b6:208:48e::7)
 by BY1PR12MB8448.namprd12.prod.outlook.com (2603:10b6:a03:534::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.26; Wed, 28 Aug
 2024 03:59:26 +0000
Received: from IA0PR12MB8713.namprd12.prod.outlook.com
 ([fe80::9fc9:acc2:bdac:a04a]) by IA0PR12MB8713.namprd12.prod.outlook.com
 ([fe80::9fc9:acc2:bdac:a04a%5]) with mapi id 15.20.7897.027; Wed, 28 Aug 2024
 03:59:26 +0000
From: Parav Pandit <parav@nvidia.com>
To: Jakub Kicinski <kuba@kernel.org>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>
CC: "Arinzon, David" <darinzon@amazon.com>, David Miller
	<davem@davemloft.net>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
	"Woodhouse, David" <dwmw@amazon.co.uk>, "Machulsky, Zorik"
	<zorik@amazon.com>, "Matushevsky, Alexander" <matua@amazon.com>, "Bshara,
 Saeed" <saeedb@amazon.com>, "Wilson, Matt" <msw@amazon.com>, "Liguori,
 Anthony" <aliguori@amazon.com>, "Bshara, Nafea" <nafea@amazon.com>,
	"Belgazal, Netanel" <netanel@amazon.com>, "Saidi, Ali" <alisaidi@amazon.com>,
	"Herrenschmidt, Benjamin" <benh@amazon.com>, "Kiyanovski, Arthur"
	<akiyano@amazon.com>, "Dagan, Noam" <ndagan@amazon.com>, "Agroskin, Shay"
	<shayagr@amazon.com>, "Itzko, Shahar" <itzko@amazon.com>, "Abboud, Osama"
	<osamaabb@amazon.com>, "Ostrovsky, Evgeny" <evostrov@amazon.com>, "Tabachnik,
 Ofir" <ofirt@amazon.com>, "Beider, Ron" <rbeider@amazon.com>, "Chauskin,
 Igor" <igorch@amazon.com>, "Bernstein, Amit" <amitbern@amazon.com>, Cornelia
 Huck <cohuck@redhat.com>
Subject: RE: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics
 reporting support
Thread-Topic: [PATCH v1 net-next 2/2] net: ena: Extend customer metrics
 reporting support
Thread-Index:
 AQHa69ZW4SARocHZAUSg3QWcyU8F9bIkcQQAgACfhwCAAD2PAIABmGGAgAA9c4CAFP5L8A==
Date: Wed, 28 Aug 2024 03:59:26 +0000
Message-ID:
 <IA0PR12MB87130D5D31AEFDBEDBF690ADDC952@IA0PR12MB8713.namprd12.prod.outlook.com>
References: <20240811100711.12921-1-darinzon@amazon.com>
	<20240811100711.12921-3-darinzon@amazon.com>
	<20240812185852.46940666@kernel.org>
	<9ea916b482fb4eb3ace2ca2fe62abd64@amazon.com>
	<20240813081010.02742f87@kernel.org>
	<8aea0fda1e48485291312a4451aa5d7c@amazon.com>
 <20240814121145.37202722@kernel.org>
In-Reply-To: <20240814121145.37202722@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: IA0PR12MB8713:EE_|BY1PR12MB8448:EE_
x-ms-office365-filtering-correlation-id: d5f36642-347d-4478-c4ab-08dcc715cf46
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|7416014|376014|1800799024|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?RVA+41eux/vKz2chSIJIuF0wqDvT6nJYZiVX34ZVqaX4N1eICQmPfmiZHQRY?=
 =?us-ascii?Q?avRTtbLjOH6J3HkrgPlaFRpIeOYYpy19X4HePG3k39n1QshDmtrTsp1gYtwI?=
 =?us-ascii?Q?QNnGwImgdtaH6D1YHR6Bh6N3Onp355aJGYGbj0IM/+BgsSOEzlWVmlDxpwfv?=
 =?us-ascii?Q?JMaGX3+BA9PMilWRsBdnZ4B898tgBTn5ufeNM9JzNop5gzbxNv4BLUJEXzMJ?=
 =?us-ascii?Q?rEZ66HBbqhPpA0YuHdLytKr/kyD5gKjlu5uV6Wipg6eT3EOL2vLBOlXaNnzl?=
 =?us-ascii?Q?xrc+Air0kaztTJxM2XoQjLKMag6fs12tLtH0Ab9dS6jlaa/GA0palvcpdwzu?=
 =?us-ascii?Q?czXK4z3jLb/B6jMi8wPIlhfrHXwhWL5P9DDXv2Vo7nFVFmBYrMBTRPOoeKX9?=
 =?us-ascii?Q?r5Hr5ThM8dn7mrK2RtvwOEI+uHgkTevdNNghdIJ4CRvxyQWXLUoOfdznz3FP?=
 =?us-ascii?Q?maIA9C71ge4fT72P7voLMnNNpoIXmLLiC/of7fbxQWt4xmbQmyQaN2fXkk8W?=
 =?us-ascii?Q?L+EQYEbpOga5HlRKgWjcdLcwLOeKS/jE2ianFACdiz6YckHAhM42JcJlSiWY?=
 =?us-ascii?Q?CfwBw2EHPRL6gm2CopVh3hJdlmqT1ShV+xUuWJgOFsooEEzYymTjNKnXpXdJ?=
 =?us-ascii?Q?iA/BzuISzDCJqRpoC/5O6fsaYpmEuFWWsGusx+hnNKCKAxHsOKGiahP++v5u?=
 =?us-ascii?Q?rrzZh3n+l6Q7kXP34cdOd6sRGJL1obQVkqgp7Vm58wFWiG5U/UOoZvGBsnRE?=
 =?us-ascii?Q?or0iYgj/GhC1OkGfhSgeAbEumXDvfzrbzxvAfJqLfTU3H/l0JrWZZucnRYAV?=
 =?us-ascii?Q?IxOszwFwviDxnBKRiImheZN68jsp49bv6RSAXaCuLlAIiZJTGejS09hZKxjl?=
 =?us-ascii?Q?zlXMyQqh/UfIYcPz376yJ3BRooFIVWUIL3iGJyCdBg+Pxmt++d0AqSmy+bVr?=
 =?us-ascii?Q?jpgzgVqdpAJCxwVHz/jrP7xwIgaLZDq7NuKAo1eO9Ht763agWsgwWmC4fMa8?=
 =?us-ascii?Q?6jIq+sUkHXqQQ9u5ZgR8+c0bepRTvhukR8QOnIiZ/1eN3uQv6+wmCexhCd4C?=
 =?us-ascii?Q?2javBo/8tSKTbon+HFKV2LXArJEBmS3fqXoWrvaKmptFBCRGJDiuNCtQM+pS?=
 =?us-ascii?Q?cIu3hwaTKAkeSU5yhpBCbsFDtAcVEpITH/QHgj6l8hy9DkuxuCGC6XYdKeYf?=
 =?us-ascii?Q?KXtXBU4p9xMPyTGSQZ4WAqCUt6FbU1mqYS6z1HQ90Wx8KpHKvwkLn3S4n3Xo?=
 =?us-ascii?Q?mwX9oaha7xfwHF7uM9rOPvflwPtFraui5TCt+dl14WbpPeqJ2Efig1Y6jRup?=
 =?us-ascii?Q?KatJwafqJtDwzD9O+m7s0U0hCrlLFvLROMs+lucw67b7DyeLDUFw/1Qzu2/t?=
 =?us-ascii?Q?3F3crskJT92kMB9tBsKYt7RTf7mPNPIXsYt2ZBrL0FM81z3nCtcyCaNVjp/I?=
 =?us-ascii?Q?AaHS6I932uQ=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA0PR12MB8713.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?4dYY7L4WTTByyf0pL4dqaQbnAbGD40mb1Rn9WZp9jb5mfWFHrrV3RQPFsZNs?=
 =?us-ascii?Q?M5p7k9AttsMEN2E05fdRKGpz23SidW9Xu4wQU75XCdbXAQTWGZ080pLnTg9F?=
 =?us-ascii?Q?An+Z7SQKmcDshxMKX2exB6nHZ/D9fb34zGNRJO37p/eR73v7SIN3LRS1Rh+Q?=
 =?us-ascii?Q?SGDYgJCk6/hn/JBnx71kwheLF6b1/kPml1uuy9IDor0FTzbTtTBGBQZjMM3X?=
 =?us-ascii?Q?QOVOuVlPdDKfT9F6L7Gwq1vfC2S0LPf7rInNElas8ma089rwurV7Kvi1GrAn?=
 =?us-ascii?Q?xdyISJTgkteoXFUqwTuHQUAys2o9kzLqEFv/xqvc/g3fl8BAZwJ6+TCSgVeS?=
 =?us-ascii?Q?Y5rslbeMrpneGmPgUGmErBFpmM2+eJ/ftC3ENldyTeSFNfnFoxg0Yl6cmR88?=
 =?us-ascii?Q?0GjIM6tmmt/m1/35lvxLkgp6aQ2uACk8GTlPCTJZH4tfbe2V/vlfnrtrhpRD?=
 =?us-ascii?Q?oo7Ch1NUngRi0u+iV24q3bEMaLUW3MXTfD6VkbNCHTnBGHt4ukxAphNLkmhG?=
 =?us-ascii?Q?AXRtf5kW4S46RAh4by0Dr7HbzgQVPa/SIiPHp2Z2ZmJzcDP28cpwM8ibXzgT?=
 =?us-ascii?Q?JTdJhLc3aGiPyjnkaE5p9s3BNZK0Va2Z2FoDTkzFDO4xLUassos1kjsS952E?=
 =?us-ascii?Q?DlgFp7Xzubrkn6KA0FBybs/GDLz2zef7XCEpfoa8Zm7fvEMgXQzTSMQy2wVT?=
 =?us-ascii?Q?q9JjdSete2bo1Lan3NbSarjEu21HKrXXRcfoJBVNX/5haBqqDtxfMQ/jlAzK?=
 =?us-ascii?Q?F/bXTXpBIAqrDOJ/XvFvHDkmjbJMAAdMLmczC8usqux1TsoZTwsDTxDx5BvB?=
 =?us-ascii?Q?IXppKySyCj6Q9aACtnWyzKnAQBYAqeTM7osNq3A7vhR2ZOB4J0l0+W8o+iP5?=
 =?us-ascii?Q?gSb9B0HmAgy0hy/sm4sugRQTEJC/XQzZ37R/+UYdjetux6FmjFs/RqpwM/k/?=
 =?us-ascii?Q?W3+pZSJhkJ0p/awRlyniQL8QZX7tq5ickiY0fp9U1xSwjpuzkPMGarCycXDn?=
 =?us-ascii?Q?vk87OFud02dQ3sMLC3bwlwuZRo+XcO0Qk+e7XZ5IzGR35KSICzLi3Lpy2cHt?=
 =?us-ascii?Q?cVslid+WQLDL9nnPbplTfThj7NVcbkPeJ/09hAByR6J16VDyHZbxAejIfDQj?=
 =?us-ascii?Q?JZIYGVuLQ99Nky0+5qmOvRDUQobC3gmFKsRIlds8rk0+b9frr9OR56/zU8bG?=
 =?us-ascii?Q?K9iuSspR9PmYtl7VpK8GYKOMi2TrUorzE+0TVyAWoCQh4ymINphkX5++85zN?=
 =?us-ascii?Q?fB5Fk2Tv9DmyvsN+XcUPwbViXvMAjkilndt+tqh8lz3mQUyrIUsb7hKoXjPL?=
 =?us-ascii?Q?P4LZYuvWlTYx6IG449UYIh0ZBZaL8U33gx3JQ3YOj/VytfNJ5ZC2a1OxLmMh?=
 =?us-ascii?Q?Oe1nw6LJpxQVTM+R+R+smEo8/EQN6QdlC0A6a/9Z+KcfpFoUB+wYbWAo9Qaa?=
 =?us-ascii?Q?CKYm1nBzRQMVdWdOe3F+33dmg/TSRuy8KX4gYxBKFcuEuYYPQy8jHErguFqk?=
 =?us-ascii?Q?cwHadcVCGEFy0vuQkjUNTVPvP50LAmbdxSeZgp9wD91Uuv6FkNTXAtlWwsKL?=
 =?us-ascii?Q?tDMsn8GU1NmJylqWC8UfHKDmUugqdHFWDCLXF1lW2+1sRQg7dAEIavH1u3ao?=
 =?us-ascii?Q?ey0JORVAZM/AEzk+ObFSHIIqiiHfDasdvUGr8/V7Li/S?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: IA0PR12MB8713.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d5f36642-347d-4478-c4ab-08dcc715cf46
X-MS-Exchange-CrossTenant-originalarrivaltime: 28 Aug 2024 03:59:26.5431
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HYcDCgNPGxAJ3aKhCHQg3Sq8y72blRd3rRTy9qZaIYTC8L3PkVVSI+9P26hJFcvXTRyKEqh5NEsIXiUGraxcRQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY1PR12MB8448



> From: Jakub Kicinski <kuba@kernel.org>
> Sent: Thursday, August 15, 2024 12:42 AM
>=20
> On Wed, 14 Aug 2024 15:31:49 +0000 Arinzon, David wrote:
> > I've looked into the definition of the metrics under question
> >
> > Based on AWS documentation
> > (https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/monitoring-
> networ
> > k-performance-ena.html)
> >
> > bw_in_allowance_exceeded: The number of packets queued or dropped
> because the inbound aggregate bandwidth exceeded the maximum for the
> instance.
> > bw_out_allowance_exceeded: The number of packets queued or dropped
> because the outbound aggregate bandwidth exceeded the maximum for the
> instance.
> >
> > Based on the netlink spec
> > (https://docs.kernel.org/next/networking/netlink_spec/netdev.html)
> >
> > rx-hw-drop-ratelimits (uint)
> > doc: Number of the packets dropped by the device due to the received
> packets bitrate exceeding the device rate limit.
> > tx-hw-drop-ratelimits (uint)
> > doc: Number of the packets dropped by the device due to the transmit
> packets bitrate exceeding the device rate limit.
> >
> > The AWS metrics are counting for packets dropped or queued (delayed, bu=
t
> are sent/received with a delay), a change in these metrics is an indicati=
on to
> customers to check their applications and workloads due to risk of exceed=
ing
> limits.
> > There's no distinction between dropped and queued in these metrics,
> therefore, they do not match the ratelimits in the netlink spec.
> > In case there will be a separation of these metrics in the future to dr=
opped
> and queued, we'll be able to add the support for hw-drop-ratelimits.
>=20
> Xuan, Michael, the virtio spec calls out drops due to b/w limit being
> exceeded, but AWS people say their NICs also count packets buffered but n=
ot
> dropped towards a similar metric.
>=20
> I presume the virtio spec is supposed to cover the same use cases.
On tx side, number of packets may not be queued, but may not be even DMAed =
if the rate has exceeded.
This is hw nic implementation detail and a choice with trade-offs.

Similarly on rx, one may implement drop or queue or both (queue upto some l=
imit, and drop beyond it).

> Have the stats been approved?
Yes. it is approved last year; I have also reviewed it; It is part of the s=
pec nearly 10 months ago at [1].
GH PR is merged but GH is not updated yet.

[1] https://github.com/oasis-tcs/virtio-spec/commit/42f389989823039724f95bb=
bd243291ab0064f82

> Is it reasonable to extend the definition of the
> "exceeded" stats in the virtio spec to cover what AWS specifies?
Virtio may add new stats for exceeded stats in future.
But I do not understand how AWS ENA nic is related to virtio PCI HW nic.

Should virtio implement it? may be yes. Looks useful to me.
Should it be now in virtio spec, not sure, this depends on virtio community=
 and actual hw/sw supporting it.

> Looks like PR is still open:
> https://github.com/oasis-tcs/virtio-spec/issues/180
Spec already has it at [1] for drops. GH PR is not upto date.



Return-Path: <netdev+bounces-121167-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D82A695C08D
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 00:01:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 00AAE1C22392
	for <lists+netdev@lfdr.de>; Thu, 22 Aug 2024 22:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2651CE6E7;
	Thu, 22 Aug 2024 22:01:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b="cE+9VjoP"
X-Original-To: netdev@vger.kernel.org
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2062.outbound.protection.outlook.com [40.107.247.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2069156446;
	Thu, 22 Aug 2024 22:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724364081; cv=fail; b=mAZ9PLNDYPqUterKL1721PbIW5uKwmNtr9UUN5GR7ds1JHpZvmPW9FbmKFb2ul2fx5QKe47rrelhARnbP8ch1lkNQvHKu1sSn4BanzBkXq3Qyar07jldb7fwO6x1QHxAu0YLs6nbGfma0xYDw+No/RUU6uuQP/mXp8qhCjAPdyY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724364081; c=relaxed/simple;
	bh=BxFa1AnCk73WZwbnUk51TOQwVqSc36mwF+QRq0J6NVY=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=gOWlXUalyVcJCF1pzTMmBUg4f7Qz7NqAKY7h2VgH46kvqHuuJ18K1rK5Ej/ytzTaBKFpOysDinBO8CpeRtjXGL4Mfecr3tLwUQGdIGE/X6p/DHwDCPFsIDZr7CPZXeJrFiIEDWyJliTaGcj5bIhXstYOhlpDCxkEkQ5j/zLoIv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech; spf=pass smtp.mailfrom=est.tech; dkim=pass (1024-bit key) header.d=est.tech header.i=@est.tech header.b=cE+9VjoP; arc=fail smtp.client-ip=40.107.247.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=est.tech
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=est.tech
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uOEuisH+sHQ9jeaz9rkJgOpCfPhsM6EDm8nWFPkpG+SpdctR23TOPISJZL3hwUuJrselFik45p9BDv0RSR8YgIGYE6k+P5SYMKOK0CT6PMwU8pTAqxhmswl5yUXHHsw8OlVc/MdzXT7LRNBOWgxhw+uofLEq47W7HbwC//OoQ89ExY5JKiCOtK+SlUekB/2guNRCTWbhN1tccCcEnvqfPDoftGZydglAs9BCIPxoj0RMmiM9vHbUAwBZbvuczTXcYGWKFImdO7QWj4YU4NNr/T2aScT0/uft5tQGnhnkqIewzv9oIx+ePzhG9R2aRRowf3XANBu3/mEwwUBclLD6Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oRTnm9b10k8vuyLzDjxLkLgrGm1a4AplaDmmUiW9wZs=;
 b=MFCN6krsNub4mA56ALtzRVh10xeO4d2KhhRI3eD4h6Y3LqtPB+NvH8S0T0SvXanCK7U1ZUk03jyo59MijPfqNN15THnrT25edcFC6ZFf8qZ6sTtGyajO5ONAIJv4cYWGN2UOat7MAm/eZM9IQk/h8ewPHNZ/GZHI6IEmFfpzGCIqBjy4Nq5A4TF+uXPI7tKc+BFR4YJItDN3qpmqhSJ18Zi76vMTQqEFF5PQQEiVKrOXJzeHLieFnFi5evFeAUqj09bRoYSa/XfDDl8uK/32KE4sMQSlP3BYrRU6S8m4gAmgWXgSdtTZvbn9SS20y0/k0QpoZClG2P3MyA+pv7jaBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=est.tech; dmarc=pass action=none header.from=est.tech;
 dkim=pass header.d=est.tech; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=est.tech; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oRTnm9b10k8vuyLzDjxLkLgrGm1a4AplaDmmUiW9wZs=;
 b=cE+9VjoPY2QpZjATGvqEmDTyan2m8mYwIqRI3JWbmls9MYiAF1BJDwvdMAbx+gB0/XmL4yEH1LGBxnL/GHnRJw4gpmUhvuFhgFqNBnjeusMGt3YX6/0eRYEpRxGfqNYLyTEXW2VOzyc970Yc45N5W6jxImu3of11d7n7B8Wkews=
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:115::19)
 by PRAP189MB1828.EURP189.PROD.OUTLOOK.COM (2603:10a6:102:27a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7875.21; Thu, 22 Aug
 2024 22:01:16 +0000
Received: from AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab]) by AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
 ([fe80::53cd:a2f6:34be:7dab%6]) with mapi id 15.20.7897.014; Thu, 22 Aug 2024
 22:01:16 +0000
From: Kyle Swenson <kyle.swenson@est.tech>
To: "o.rempel@pengutronix.de" <o.rempel@pengutronix.de>,
	"kory.maincent@bootlin.com" <kory.maincent@bootlin.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>
CC: "robh@kernel.org" <robh@kernel.org>, "krzk+dt@kernel.org"
	<krzk+dt@kernel.org>, "conor+dt@kernel.org" <conor+dt@kernel.org>,
	"thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>, Kyle Swenson
	<kyle.swenson@est.tech>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: [PATCH net-next v2 0/2] net: pse-pd: tps23881: Reset GPIO support
Thread-Topic: [PATCH net-next v2 0/2] net: pse-pd: tps23881: Reset GPIO
 support
Thread-Index: AQHa9N7P/WeWEXGmLkqr1qfa2UCDgg==
Date: Thu, 22 Aug 2024 22:01:16 +0000
Message-ID: <20240822220100.3030184-1-kyle.swenson@est.tech>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=est.tech;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7P189MB0807:EE_|PRAP189MB1828:EE_
x-ms-office365-filtering-correlation-id: 1e11e082-2a59-4ae1-a01e-08dcc2f5f1e3
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|7416014|376014|366016|38070700018;
x-microsoft-antispam-message-info:
 =?iso-8859-1?Q?+jgIlvQND1GWLg8K8g8VpbnHwL0uSd649xm+q0npzVYA5m0kKj3+o13wTG?=
 =?iso-8859-1?Q?E+zD0AVTRhCfDlWPIzL/X5YuCJiGvNOYbK9JCfWxUWm/aniH+vmPmUaj5p?=
 =?iso-8859-1?Q?aIgjxuVS7LY64Ph+VH7q9vnJBz55C7zCAWXkCN1+0oK/O7703FNIe/YVf3?=
 =?iso-8859-1?Q?tnPwQ9IaSt1K3RqmrRW66o7i+BUHlAYU/0SIZ6f4hmIk3JvIvKE7seDVQH?=
 =?iso-8859-1?Q?q01JuMSJVCxS0jb2XTXd17djSInfBN9DN9rmPUy/GHzggxh+SYJiyrU2nC?=
 =?iso-8859-1?Q?sLd3Ja3vMIcqy5Axq9KQRn9Nx82HgJSWgFDLalWuaFdF2/8hjVlCX8IBRs?=
 =?iso-8859-1?Q?0499DLdn2z2qv0N2y0DhAbxuX1u8HHNp5wvY5Nxqjr6vvgcs9maGZppyE4?=
 =?iso-8859-1?Q?6UFzJwEBhXPW+QrrHtOmVVluTNsA+lpt9/HZmzeZm8xoOglmYBExbi3ENZ?=
 =?iso-8859-1?Q?W2ouOb2nbuhRBTyKwp6eLRh+243nmGNSPkRqYaqBdHFWLscqsyYnKFO/SD?=
 =?iso-8859-1?Q?Fvhe1kqNl7e7OABPlEFLwTIJYMMuhmbxyAv/vQufRBXRMy/ycHYcUdvJta?=
 =?iso-8859-1?Q?nXeBkn+NsrcqDDSWlQum6jC4tnAda2H023wTaSBUyzVoTfzL83wyqti932?=
 =?iso-8859-1?Q?Taf8Idr0JdBzEe9ZIX+hGhDOpEyVffp5QZoqTQhOnImbtRxyQ+7wW6MgAr?=
 =?iso-8859-1?Q?TwrspEAt39N025zXrA/Kfm1LgiO/t+RFmvlyyHtoyZxp9gc1c4dLFVkuDW?=
 =?iso-8859-1?Q?AJVS12XzomQK0m/5YmFXDoyVZGRYwk+x9Tjw4Jl3KvT/gJvsxyxWdBb19P?=
 =?iso-8859-1?Q?m2FfE4kKr6d3ic8GXDNGENQAmSAqk9eUJWWTY/ZUF89dGMQwFSI3uQcx44?=
 =?iso-8859-1?Q?g5ZjLNdcJdDIN7JM5mdb8CpFJijF2HwU+4+HLpVRJKHl8YeLPn/NECFJWB?=
 =?iso-8859-1?Q?g3l0rmSV42uPvSdqdowKBWdZCbhBWomeUQxBIY1cpMJafGvb4Wt6q1BIQy?=
 =?iso-8859-1?Q?ZsYhznTCGlp0hpdiH8+Ei50owkADLLqGzTgWU6BHb3CjUKqelDQbec4jrn?=
 =?iso-8859-1?Q?hvNaxPpdQR9b4p0oIB2E6TjJCHjn3mCjhPPrSzg++I9DkMloUrFR7oYJqJ?=
 =?iso-8859-1?Q?IBxi7w7jJ7m2bY8pTiklWQofBuee3sdo1k5R8zBN3yxjLTuSVVPx+WlIFd?=
 =?iso-8859-1?Q?NRBRKj3nXgZg8GI2PTmFppXJQgITG/NIsj7xp8S5xRcX/IuuToZa45TSzW?=
 =?iso-8859-1?Q?LsOo0zSZPAVQD7NI8FG2UiDYm4MZL0I7OOTdkxo8Zyu+BfO2QSYShasEjx?=
 =?iso-8859-1?Q?oDAwOuHwHI4FQlODaCJ6rGFf83A4wkbPDdJEH2Q6plf2Ch1sYY8OOdg3XJ?=
 =?iso-8859-1?Q?MIahxpJVgcKkoZbR5Ihqtu7ruCywp2WSjPTZpfxY1M4JXTPlbWwmEdLPWI?=
 =?iso-8859-1?Q?XXnxG9dRYuv5mo6rDn4p76sB6XYkkAVpj3PuBA=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7P189MB0807.EURP189.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(366016)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?iso-8859-1?Q?cse4G09VNUhwP5/tA8AFvc2NR4bvlqYBhL0Vr/eWx31jeRBo7eH+f2Kl4Q?=
 =?iso-8859-1?Q?pXnDLeufryIR8FcIuGqPYdO/kiO1vqAPdAMqHbBr5nvlg4PY2pVzZZL+NQ?=
 =?iso-8859-1?Q?V4oKDKT3CYkYajdLkJ3CBksG2ReGaB2yVbP5HtVIbwKTPpD0c3MZUCc6Dn?=
 =?iso-8859-1?Q?tN0kPSFt1YhH076ojKaH3Qn92qGY5O0tlv/WrMR9LH9lS8J3BCT1kLhSIK?=
 =?iso-8859-1?Q?GMxebKFjI/BHXSX2lFEkx3yFgpnJPdssQVNN9O0+8jKnTn9vzqncxFAsAt?=
 =?iso-8859-1?Q?BIkE0Yzf1wabUxkhtxCMW3OLDnxUJKkEzDmIGg1OsDTlrayskVEr9jmeWm?=
 =?iso-8859-1?Q?ylkux6xWBlhEhB3OX2Js7FmaEBw3LzR/baEwu2AfAk0D5gIzlcgJpTLLlu?=
 =?iso-8859-1?Q?9wDPjis3uhXdoDa4wpKdhdc6mFDv93B+tf+aTvxNaXDgMZ/s1UyQzFgxdr?=
 =?iso-8859-1?Q?EUe4dCx4IW9abKmb18bP0EiN+vsaKc317yfpXmVcCy2Hg1muTuoIlm6WqN?=
 =?iso-8859-1?Q?CCBA2E4lJ/WVp3p7N31mcmQx/0nqr0m+7IbW4AX1IQqTL54KyWh3gJf4Ur?=
 =?iso-8859-1?Q?3QUv3KeVgvwSG2FYjyErL62sFrpGQvBUpbrH0zDW8fh3PdMPdZcMTZNJFK?=
 =?iso-8859-1?Q?Mw71lsj+XMQ72LXxKOZpX8Lee0RqscZ3xszyhtsQhydXrUEHEwnujfI3UQ?=
 =?iso-8859-1?Q?rjtXQ5AvpYBJ7QQpnWaNYFJqoxs8AKQdxKT+yym7lNn/Wi0VXaShPsYmJv?=
 =?iso-8859-1?Q?ndzbPu/yx3W0gol7CidpOL9upzZxrtuvJjWjizFRrmcKXbmZzZbifE5D8g?=
 =?iso-8859-1?Q?s7leZ7kMSBLEg6hIjo54K0LtwQ7x7AtGTQIJewLvjkrz5JzKRosBZ4WT+s?=
 =?iso-8859-1?Q?Me4hkyE6eIcMiBqWcmoh5jz1X3ZU+eBn8iF8F3brsCVJROcS55647x7ZDI?=
 =?iso-8859-1?Q?gctA0NaVEjdxRPzXQjg7aDYsnXj8nrhX4Rl3MSJbsdLSSlfAkQOnyMiCh8?=
 =?iso-8859-1?Q?UEEcMtwVxG6SENRwCcNqtC3sd40RyPCQ+FFw0G1VFddbVqa8uaMm/RddaV?=
 =?iso-8859-1?Q?YViTgOoehQFQR+QduXyHbZDTd0fdnj+rMVAVhfmyXzuPX/s3F1dEZpFfOE?=
 =?iso-8859-1?Q?aajgiEE5UwgCrMN7TcrXUnZdAwg6rgdxYfNRj+9QvpncmOmnlU0/Mpqkge?=
 =?iso-8859-1?Q?mS2u/D9e6pCu0HHx6OgJ8j3EjtlnTnu6qHxwjVHQYrFn0kqN+J/JwtQHmL?=
 =?iso-8859-1?Q?zK3HcQMuNoiW9drO6LZubOjUd+9yRzgyshhaZVSwGKvmP/nyXWuZdNgsjF?=
 =?iso-8859-1?Q?yC+rMpJVgOoWaUP603IOKEt1BDpxyH14hAOXfNgK+Nn+3G0rsyRo0DiVNS?=
 =?iso-8859-1?Q?RT2+4bYhK0BfaKMSh/5EIQ9OmSLmkW7WuA3XRW8dq0BEYtAmxy1/N6D6qy?=
 =?iso-8859-1?Q?QSVa2mlfR6GY3KyBV4N+OG7cqsNEgeHeq3qLSikH1Rj3xvGrF7KafxhaFL?=
 =?iso-8859-1?Q?YvXvGRE+c6NiTUeRhAUM0/tJdxkNsu4pfhwN5UE6CrMv1TyKZvNEdQ1NC/?=
 =?iso-8859-1?Q?45CHWM7pmn3mBcnTGMBBHCec7fL6wF3nyFXus+hcNKcZJ3uIZjbu5Rhrmc?=
 =?iso-8859-1?Q?dwqCrBW0/+/RUXnCSZI+AlREPuNocWfQmMCfX4PhdRR+qp+27NnvK/Zw?=
 =?iso-8859-1?Q?=3D=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: est.tech
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: AM7P189MB0807.EURP189.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e11e082-2a59-4ae1-a01e-08dcc2f5f1e3
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Aug 2024 22:01:16.0205
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: d2585e63-66b9-44b6-a76e-4f4b217d97fd
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wHDE2OceM/DTYrVFgcSiSvk6Hkm4IzLbAk6PVgt+Bco9qvHuQ7UzpMWUs3ABwRI5+XYm6VpFhuMwi/GlUe9lSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PRAP189MB1828

On some boards, the TPS2388x's reset line (active low) is pulled low to
keep the chip in reset until the SoC pulls the device out of reset.
This series updates the device-tree binding for the tps23881 and then
adds support for the reset gpio handling in the tps23881 driver.

Signed-off-by: Kyle Swenson <kyle.swenson@est.tech>

v1 -> v2:
  - Changed the reset pulse duration to be between 5us and 10us, per the
    TPS23880 datasheet
  - Changed the delay after reset to be 50ms instead of 1-10ms in order
    to meet the minimum recommended time before SRAM programming.

v1: https://lore.kernel.org/netdev/20240819190151.93253-1-kyle.swenson@est.=
tech/

Kyle Swenson (2):
  dt-bindings: pse: tps23881: add reset-gpios
  net: pse-pd: tps23881: Support reset-gpios

 .../bindings/net/pse-pd/ti,tps23881.yaml      |  3 +++
 drivers/net/pse-pd/tps23881.c                 | 21 +++++++++++++++++++
 2 files changed, 24 insertions(+)

--=20
2.43.0


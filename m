Return-Path: <netdev+bounces-207401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F254B06FCE
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 10:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B3921AA04EC
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 08:01:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F350E272819;
	Wed, 16 Jul 2025 08:00:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b="K++c4ZNA"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2049.outbound.protection.outlook.com [40.107.236.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD8A26FA4B
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 08:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752652827; cv=fail; b=c0dTjUzF0F+KDoPt7GmoCa1nC8vfe1RTTtYkPkLf1zVpaVQm/jrCgHb7ledVLJnqMmGlv9CACqV5A6OQGdS+VxGotMkgxQXlRJdF4AKG8eSxM738E8+PhU9QUrkr5qCnv+hAAu5lmCPOojaxuFABSzeCCNVMYzO9L2mte5Ij0wk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752652827; c=relaxed/simple;
	bh=61VR8shnvbKzsY2KhsXE6Uiz16oDCtEztyFUPJ9+rSk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SzZpftHv7KGPs8l7Y+OnbGR1b7njlwpc/0cAodoAYD8tjug13fdSvWoUgRValA57yp1Q99EFYzBc++EOz3NEQkmePxBWghTAc6UTt3xfJUOd5/57QhgPAxu/G9yBBUU0QiIaFTlWo1KYoBCO+4MeW9v/8nly9oht3gqobW9vY0I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com; spf=pass smtp.mailfrom=maxlinear.com; dkim=pass (2048-bit key) header.d=maxlinear.com header.i=@maxlinear.com header.b=K++c4ZNA; arc=fail smtp.client-ip=40.107.236.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=maxlinear.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=maxlinear.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zQIL89WOWG/bUu/A7xK1edrWDoVINJ4QjIXPkZxIvs9guyl88i4FqB1n3vDx6EVsAu9d39UMX9jVcXMPhXRhZTNqmSfyIKHaa33eXuCvtUWi9r71K371VYPwys+WBMd+t1jVB2Rj0PkvlYW2QeQTYNR5gp0aPl64zD7bCwEyDjXGx8f5zDsS7OWtV2pm+XwITmuEcqDqGV31pj2ZKawwQSYRuIIHXAEpBCg4d7pJyML3FzdPRXUmewKd+9ch/s+C9UhQY/mJXGY1PRZVNILpNZrq1/JpluPIXPEHYevd/dFpNC7IMxNDCqoVoNRqCBOh8plqXreHM3KEAAJpVliYUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=61VR8shnvbKzsY2KhsXE6Uiz16oDCtEztyFUPJ9+rSk=;
 b=xNzzs+iWYD7XeNsA7Q59Si5B1f85JdzayU4nJOLRjuJUlmHeCxKOkBj1KQkEKX6x8v7/CTQp+lFSWys9MqhblxjfrnuBUHyXC2hPtiDEnZR2pDrtLCwYqISJXu86m2/nZO2loPYsAdJtJfmZwbG8EdaJtM5v67NEUeVXJNjYv9/evXCyE0T4nKePUYFrwSjIp5tKRbVVZL0XrPWllyucvMnDWR3a855zXbs57qcfr3V0VXCmnDURUvMDkyoIX55s3d7mYOjPaMtdJlxFt31L1Unc2k7mEDhqfxUYrJ1UXfvz+iR9AN90ab9OfRioUbi/YWk8wFKpxbojFxbfW8VV2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=maxlinear.com; dmarc=pass action=none
 header.from=maxlinear.com; dkim=pass header.d=maxlinear.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=maxlinear.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=61VR8shnvbKzsY2KhsXE6Uiz16oDCtEztyFUPJ9+rSk=;
 b=K++c4ZNAHyoGG3IImhPkFwh8Mo8LljcxmLbBuo0jDzvVdQi6zPORrVjHnGVzRYwUjsrIrVT7SS1M1ksKHXxJUuUNHO8m1RylC6RzvsVUXz8YarAKICal4oETaqsLngpTrfXOZWWV5Q9W65lblakpMQU9kxD4mC/IWAYTDOBRTiP0o2Jd66a6xUIHeyPBFN1i5fhe9XkyakqE7bbaQcoMgPEznDZXrKst5eVOQP9Mc5L3DSSj5Z6ZlNsxBRq/89d1iUWiJ1SxRdPYmTId42QgJNtAjj4A27wojfZ9WbYLvDFZkqNMuZUp7Z28sFXIhjXp2aR7NhkQYYJlyQOKQ2918w==
Received: from PH7PR19MB5636.namprd19.prod.outlook.com (2603:10b6:510:13f::17)
 by DS0PR19MB8355.namprd19.prod.outlook.com (2603:10b6:8:1b4::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.20; Wed, 16 Jul
 2025 08:00:21 +0000
Received: from PH7PR19MB5636.namprd19.prod.outlook.com
 ([fe80::1ed6:e61a:e0e1:5d02]) by PH7PR19MB5636.namprd19.prod.outlook.com
 ([fe80::1ed6:e61a:e0e1:5d02%7]) with mapi id 15.20.8943.019; Wed, 16 Jul 2025
 08:00:21 +0000
From: Jack Ping Chng <jchng@maxlinear.com>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "davem@davemloft.net"
	<davem@davemloft.net>, "fancer.lancer@gmail.com" <fancer.lancer@gmail.com>,
	Yi xin Zhu <yzhu@maxlinear.com>, Suresh Nagaraj <sureshnagaraj@maxlinear.com>
Subject: RE: [PATCH net-next] net: pcs: xpcs: mask readl() return value to 16
 bits
Thread-Topic: [PATCH net-next] net: pcs: xpcs: mask readl() return value to 16
 bits
Thread-Index: AQHb9f5GcyN8HoXPxEG1ln1kTHtsDbQ0WcGAgAAD5KA=
Date: Wed, 16 Jul 2025 08:00:21 +0000
Message-ID:
 <PH7PR19MB5636A566EF580005BE4BD15EB456A@PH7PR19MB5636.namprd19.prod.outlook.com>
References: <20250716030349.3796806-1-jchng@maxlinear.com>
 <20250716092557.09bc8781@fedora.home>
In-Reply-To: <20250716092557.09bc8781@fedora.home>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=maxlinear.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PH7PR19MB5636:EE_|DS0PR19MB8355:EE_
x-ms-office365-filtering-correlation-id: b25809b0-0bde-4ffa-c3eb-08ddc43ed026
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?UH/AsaX5IYEAtM6WNHol9zeR+39R0bZP2kHB0CwUee7//wxqW10dyQ2287do?=
 =?us-ascii?Q?UQWWvGRSvvvU4MKWf4Q79rRWjTBvgGZIkZWuB3oCgRNEI+ckPwDI7vhu4BQh?=
 =?us-ascii?Q?d9Tqun++rngsoAz2Ia76IfOtt5S3CpS+tBPM1BnJDx6oo+aqM2tpw0YZtdgB?=
 =?us-ascii?Q?TA7NmrKp4lrrZ400bSZVb47S8hYpcrcdWzXjJmt/N2k1sNaHXqACOvl9qzuo?=
 =?us-ascii?Q?tCZe3CaYdKoKiTXD4WCFMO+mOJW9g0cytFLRep4VDrS/AMAD1lim000J3xwh?=
 =?us-ascii?Q?+5c71YqmegpiiNX1bw/U5lujzOarHQ6sNggA0YFj6S/PMrm/tm/V4DZbJCzd?=
 =?us-ascii?Q?RuyzWtPSfx3Iz9Xzxrzcy3zcjCKQzYGPC2rqHXTgJ3dtIBfRMqujpXpkvoPP?=
 =?us-ascii?Q?W9Q3+ZSFmakqqe5wCFDWqfqjdELQjtIa8S4bW+k4fD6iwPKhKRnZ2StU2g3C?=
 =?us-ascii?Q?GgHXMyGoKvFWYk6kn904AfIgGhku30USiEpLmLzJxcgV+WX5f3253+U7c+2d?=
 =?us-ascii?Q?MlFH+6DEBDCinyaUOlHuvmE4rSy1kimgxspn86nYd8d+ouIy5q77boM3DvE4?=
 =?us-ascii?Q?U5hOEm+9ZKmS6O24bRPNwYwF2RwbBvuhq/QzSSwHQQUyySKRPbZjykX3EyGd?=
 =?us-ascii?Q?6FjBrzaPqgvq83MigYIJrwan5NmdG7nE+/JuajA6E33mVPNmbRY9E7KFJqEP?=
 =?us-ascii?Q?B9PpxEIMwDdzlQmLX5tGbqSR0MKFevcw/i+nt2RtNy1SUysTFhQY9VR3rRyP?=
 =?us-ascii?Q?Ggrqbqqpfo6JZgf4VU+3u5aVk968EEHR8Lzz1PzABuhthTcvjJE8rk2HE2HC?=
 =?us-ascii?Q?M4tNIYEkjiczj0hEDYYBbB+2q5HRmgGp1ggiBpfrrAnki3o+ynlC0RWaJX1U?=
 =?us-ascii?Q?3LroGjSkm077vavtCM5ohBR1jN7QKR9g5B2npafjFqv2PHUyQ3ZowprShXl2?=
 =?us-ascii?Q?KAvJQvYRkh/VHNb7550ejdDMw0pYOelRL4CJ5W13ulJ58+Z4vlB0iG7jzOX6?=
 =?us-ascii?Q?Fw1C0eMq3U3ZPpDb71MWjk0JVymvM/asHgFqbMZKnAAoIOs/zbgF4g5rjoDT?=
 =?us-ascii?Q?sSgxmEsvyF9gqwY13fR59G7p7HQjo6IpeelnpfS4lJ0sEJGdciqAejCYruQG?=
 =?us-ascii?Q?V69FDGbgpDKGx6JwC/z4IDh91wz7Z/kTnvZp85kpwEcjLeUKdC1FxXmZqOrH?=
 =?us-ascii?Q?JL90djz7i0HJU+b8XQt1LJId3hy2UvhfSDvrVP5nJuAAI5N8x7upUSuREgIs?=
 =?us-ascii?Q?yYN2v3ASeo4fMgVVEL8oebzgbwL7+gVQv5taJ850VArbDgXE1Gx7Epuhhnyc?=
 =?us-ascii?Q?PGJe7xERLuLm79TTr9T6p0iRltq7Hx2KE5+yYVJlX7KRNDcVfWSMWbj8avpB?=
 =?us-ascii?Q?eaz2/R5+q9ogkTfBIJZHxfYoOdz37/Nv962iYLy6QaL0wKLD/wVthbMtrSyr?=
 =?us-ascii?Q?139w7d2q4FTvthTpEdF8ivBgwOMEr+3ln7AZe66M/MfsS2WLxaY5ZQ=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR19MB5636.namprd19.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KNSuVa8wYUAq+Aelscn1cj+7IjBVvMRjoQ6eibDKiSxh+hMnmzT555CGaIJV?=
 =?us-ascii?Q?TUuPdBVNC60bgCFovLP0pkDCVObkqVgLpvtmFT0AHIZ4Vj9OejNRSVjyEjCZ?=
 =?us-ascii?Q?4rsXf3mQnIX4YPDhuGp7VYGef+4m1L1SnHC6GYUlewRhLXwLk+FJ+QkF0ott?=
 =?us-ascii?Q?ZWUn6OguJ9bGSaKOmZdx2AtGo8N/MdkF8x6Lv4Z15K+LCr8g2ipJnIBBYr7q?=
 =?us-ascii?Q?U7BHvyMCQ4Kvk1DiNAaKb6YAfJbglbR8SQeOP8JNWKJBN4K5aM2cq0eh84lw?=
 =?us-ascii?Q?WILmt80B82yMno5egPLytpvZymRKoYRIzL25GLAxtWww8TQ8L/m7lVlX0x3t?=
 =?us-ascii?Q?lpBul07Lie5l5WIsVFnMk2ka9cTKDhH1I4RebGQ1h+xQJLMmuZQpREJJm3Hf?=
 =?us-ascii?Q?OI6VfFNH9ZPr3tPpmlM3WQjpmubeJhE8c6ctJ56GJgBvDajsIz4R3+18LdPx?=
 =?us-ascii?Q?r2xi6AT31uZ2wxDYbXPiSQfjIRu2btyY86PDNNYY9fiDMJNEP3ZKtn+yxIgy?=
 =?us-ascii?Q?88TpDKKn4h9fMr3dlgSbXNd25iix5e+qvAi0+/1Fg4P2jCihzH7HPTFWdG9u?=
 =?us-ascii?Q?6hbO6PYSGYze1+m6WuIrPvulzb+x80ADwG0fLfRNa59AJU8Kfiri8fxF6f0x?=
 =?us-ascii?Q?cyBHu28IidEQI6UJfwBv8ZIlyK0hUy0JOFbVhL3i4enpnthMyf87oqi1YHNh?=
 =?us-ascii?Q?9vsk34g4MTaCr1Nuqtjb1g95UXEaAAqEJ3ZyBZSzMu1ApVi/8tJVxyuZ04ax?=
 =?us-ascii?Q?TBrXpeG5BttxSMUVJrYvYFoVd8xRVarqD3s2Y4JFSx+8HTyA5hLZ6G5LFiSZ?=
 =?us-ascii?Q?fp2yZwtPrRx99eBvIusgYLV0l4pssoGUQ72muc3iJ2kAxURK/ZCtQGyPjJsp?=
 =?us-ascii?Q?zGE9dYHf1WyK/VxtdJhME3OzIOrcifDf4lF8pYQjpmkB6kepR1F8FA6FZCz1?=
 =?us-ascii?Q?JuKLW3pL4izihi6tieI2F71V/xqRHG/G9dR90uWoGm72IrC5cCQG0egmLVKF?=
 =?us-ascii?Q?NVA5ZP8HqHGAaS+4VYPR5FH0pNcFhed4iv+w4I/rB88QNno2o3cfZD58E1Ia?=
 =?us-ascii?Q?DZJLecBwbsoptKQP2kxDtkunjOBJHcz+Xk62KQglILfFA3B7OFkxfULVD/Fs?=
 =?us-ascii?Q?5HI/ls9PS6vFr7/SQVOvJapapM88oDh8zGr6WWulWhLuvmyqL+67SAlpzQDm?=
 =?us-ascii?Q?FYPZvEsDMz5ACly3WsPhl7KC9n8oHBTbAZ2wShclEYn2vRvTw02wf5BjTT3v?=
 =?us-ascii?Q?P/+anVJ6BKb0jg8vdG7c9gTO+y3iWiflFxHbSiHqK7mTUzY1qSNyVh8jPsAy?=
 =?us-ascii?Q?3YkgYtzFbU65gPrLKQ5fL0+W1JS0JzYWo5m/eZIwfERQz+z+H75gB/zCLn23?=
 =?us-ascii?Q?GFyEXl7UZ0Y2U3loFF0tIE8kn3AcjUe17fXWOT0fWOayxTqOeE7BebyekyXb?=
 =?us-ascii?Q?tA8oeWWrNhBrWC30WWNOJca9A8QzyhFfU+8upt0KIIApbdgq7XL2PeDd6ahX?=
 =?us-ascii?Q?Qn1PRjnPmXDJW/wm3jSL4p0ijENAIfG0NiKaYb1yIpzUB2aV2OqGMvwIbwwZ?=
 =?us-ascii?Q?6OpBi9M7+9QsnKq3aF+ixVYxB5yGLEukKVGr3hpK?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: b25809b0-0bde-4ffa-c3eb-08ddc43ed026
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Jul 2025 08:00:21.5380
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: dac28005-13e0-41b8-8280-7663835f2b1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Qqvc69idC8c7mjCElwHJJ+r/aAsSIsLhEk0R0Ls3URHWUS9c9p45o5Ar2JGJiBlToW1p1VuiEtyteNJz5j7mZQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR19MB8355

Hi Maxime,

On Wed, 16 Jul 2025 3:26:00 +0800
Maxime Chevallier <maxime.chevallier@bootlin.com> wrote:
=20
> I'm OK with the patch, but is it fixing an issue you've seen in real
> life ? If so, you should make this a fix, sent to -net with a Fixes
> tag. If not,
>=20
> Reviewed-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
>=20
> Maxime

Thanks for the review, this is not yet a real life issue.

Jack



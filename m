Return-Path: <netdev+bounces-116663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0731894B547
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 05:00:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E41C1F21660
	for <lists+netdev@lfdr.de>; Thu,  8 Aug 2024 03:00:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FC0D2FB;
	Thu,  8 Aug 2024 03:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="Xx/ch+mh"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010011.outbound.protection.outlook.com [52.101.69.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888BB2F2D;
	Thu,  8 Aug 2024 03:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723086013; cv=fail; b=Fdlhmm4T+uLuvEuuWvqzu8YlYM4gfJL7ZTKcqbn8zuCMJ9CwMtMp3cJWTYE16LwDHxWk0WBziEoXdfL8K5kjickj3cNK4nj8dBajnia2QPWgGrEc3oeiR9346S+pReNRZdTo8j8Ky4pc3tyixcH0y3nSdkzksGGyBryw/jUTQP4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723086013; c=relaxed/simple;
	bh=1GZ0JYOtIEueIazcA6UOqTcKoaa+8Fnun50CN7SZ3u0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=aaZxxCyxFiu+5ybP5/vFJhEvGqf7GuZIH/wJ1iM2abbTz6ytCGyEPFHwhMpztwlJbnHZIOAj3F6dtbgdKRHmgDH6pCz2lWHhtNdl5bDjE4HDcFkeHeWJwHWvyiqMmfxU0YcEiQY1v+EhIKoAA4ThrOHMOgClVC7lTzbJno4RJgk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=Xx/ch+mh; arc=fail smtp.client-ip=52.101.69.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=divcPOP89xlW0j1BXheYNssilIRFKGmw95fc3rqkl+gEzb5id8kN4Qpk6Vh/B8z3OJAGcz07JEEFWv4QX6O0bmOwopPqP4y8vbC1z49ZKZ6G9AE7VrK354XR9ASNVONC5WNAaHkm180HdvKrOkT0zQpTWGT5xQ1qebgZPgzr+5utlbjfGkscItJstull2bstQXsB501mK1Y6NhswMioRKE2Am3SHGLMsjXJTIlbZqkGAAzgs01OtRqlF9ULXjhijvlGRv8I7rUkBDBdHVdiiYmW5uGTrqKr0wiQkCWcy+kZhxgK+USzDDS68HK+BIg4GYMxWYvw8xOQKMRcBfE0WBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1GZ0JYOtIEueIazcA6UOqTcKoaa+8Fnun50CN7SZ3u0=;
 b=JoYGmE0LZVKcZRg/4seGe8C/gi/jNg2PkE5RF6BvBnA7yoIelaap8aXBHtwFMgpegLwyz82T7NJKA528u424I1RbvyTmdKhOsFRvsmFd33V9C5C/k/+uOAdtaDVVHbsL/C8g9jgj5XAsSXpL+RECbalbIFrelfGa4jf+c2+iN6Ju03cnXlt2p+1w6JlvTVchf5zLjvcJTUAt1gfbZJuDVjOVuyo7DNgfcn2uvezoRJUT6bGDhVVk3LZqd9JTGsGhtNgQ63YIyA3FrXs2Xm/57DltRdRH/Q9QG+9ca87CM7++f9/lhPkuByQoltKIQxTQTuO2UbvsyOysuaB8VRkjDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1GZ0JYOtIEueIazcA6UOqTcKoaa+8Fnun50CN7SZ3u0=;
 b=Xx/ch+mhlSDi55L5E+cLltWqtWSTvu2AubTz1hOJtlOdIspcHW9XLp/gIl3exuT+WuAAoG3dcg54DIiYIXVU4WTKiobK6+2tB1D6jPW71sH6C8lZjL7pmtqQJtZTHLITAzoH9q5xTY7uyIX5r+1aml3pqDva2aRvxsc9nQeIrqjh/+ralcLQD6Chglexwsm4eXrPzLAduNYdHG8SIPLzAHbdFe7LrbozcYbJU3U5UorR9FWn8r+Rv0MjBkMcH/n9piYffB3jMH8jlvyGxtxyK8hoeUmotGi2kXrZfejq1g16e0+WvetXgt5JWgLIHCfTXfpyn78sPKqqJ8nF+2YB/A==
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com (2603:10a6:102:1da::15)
 by VI1PR04MB6958.eurprd04.prod.outlook.com (2603:10a6:803:137::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7828.26; Thu, 8 Aug
 2024 03:00:08 +0000
Received: from PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630]) by PAXPR04MB8459.eurprd04.prod.outlook.com
 ([fe80::165a:30a2:5835:9630%4]) with mapi id 15.20.7784.020; Thu, 8 Aug 2024
 03:00:08 +0000
From: Peng Fan <peng.fan@nxp.com>
To: Fabio Estevam <festevam@gmail.com>, "kuba@kernel.org" <kuba@kernel.org>
CC: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Fabio Estevam
	<festevam@denx.de>
Subject: RE: [PATCH net-next] net: fec: Switch to
 RUNTIME/SYSTEM_SLEEP_PM_OPS()
Thread-Topic: [PATCH net-next] net: fec: Switch to
 RUNTIME/SYSTEM_SLEEP_PM_OPS()
Thread-Index: AQHa56a6ccRty2rqv0q034fvdBrDprIcrrrg
Date: Thu, 8 Aug 2024 03:00:08 +0000
Message-ID:
 <PAXPR04MB8459AE5C3E9B45AADA7114C288B92@PAXPR04MB8459.eurprd04.prod.outlook.com>
References: <20240806021628.2524089-1-festevam@gmail.com>
In-Reply-To: <20240806021628.2524089-1-festevam@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8459:EE_|VI1PR04MB6958:EE_
x-ms-office365-filtering-correlation-id: dd2cb6a3-6032-467d-3d48-08dcb7563657
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|1800799024|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?SORZ6zzjgghi2oysRbtNG9YltcSRGK9Z0M6yMFZQiRImUpnPjK+2yvMWAFiM?=
 =?us-ascii?Q?WSp3bhWSocg2eogZv/MpyV0Z6cHVD/mHgsyXQZmVbdRqTfNrm6vAtFnzhu0R?=
 =?us-ascii?Q?sSUXShOeMxPbi2my5iKx+zAyw1tR2z//rt+uIjP/8/j8n294OGgR2ny7PMM1?=
 =?us-ascii?Q?LP/+1WvrofImxZxyCA5xjPzeFfMg9KFm27vmmGjQe6qCrFYML8SEKectYwKs?=
 =?us-ascii?Q?8TzsEMQbSZwkjmqh1h5WZKqIFLtS8hUNwJnSiqXuozlL7HCl/fYdcKlu/Nmf?=
 =?us-ascii?Q?Q0OapF9fuBrFOZf09WaBYbm/l0mJyRiU5T0UU1Dco7t97I9VfDK8r8igLnJr?=
 =?us-ascii?Q?sJ2YpJxEMin2osYo4Yxh3VKRoxswdFGwnz1YL5IN3OrSsV2zlRQ0UZFajLgZ?=
 =?us-ascii?Q?TEn+fih/LeBcBl1uRxxxdcZckL43Wd3NV2WTHRsFq1yr9eTYd6a6/AS4bYBu?=
 =?us-ascii?Q?Fta0jFKF05fb5pxVJHPtAEhYRCI/X/FF2zpAzapfTJIElTB7Uves5/5nFLB8?=
 =?us-ascii?Q?qp+XFPcvj0tE7KvZaX2FPwIMv6Udd7OGz1oOKs/fNFIQKodL4ZmxAk44VquI?=
 =?us-ascii?Q?LExC/wK/9dzKBVXy5pI/1g6zllFz4ELuGamsxH8wgr8kGM2OIIj0mrM5i+Uh?=
 =?us-ascii?Q?7QxOKuVBvhZ95jISEB5BOG5kpEVeI1kP2TgZzZVOYpv2I+rn4RwmcwwQZ3M6?=
 =?us-ascii?Q?BH62hnky6CCdeln8eIN48GRQ6PChrDE9XBc17Kv5YSWAhDKQwVS/VliYsNmK?=
 =?us-ascii?Q?4AgfPeaj1YyPXy2f8xQhIDU4eSdH8gx5MvLYPhQO86KbBTiwWRHmGRpBfV5I?=
 =?us-ascii?Q?d8+aDazH0m5u+nxv1Fs03a4fvGkqtusXx+RbT2MvCxmYNFkJT1iqJMCefk6U?=
 =?us-ascii?Q?B+Vz/vZ8yxx9SF8ysePLo4+OGJiHXEWBHODMmslifMpwbvUqzwWe9Stuhjwe?=
 =?us-ascii?Q?TwWStfJKpCPMevQx2ulgqzn39fLKR7M/SKFpX2Bv4N3VGiMpzTl+sfQShQtB?=
 =?us-ascii?Q?hDPC3o1KYEDvCOW62yWqYOyAMbhNmLA/Ge00ESE6Xs9lvJCkCokDV+aPh1PM?=
 =?us-ascii?Q?7sEQu98WQqFYoso2IkJ8T7phK8vQr0iZa9gIo3qt/oLehy48I3Y8Ao/neVwy?=
 =?us-ascii?Q?4PvHsknb00uKsl7BXCvYD4Pdqo+X8cPMFww/mDF0LseW3psOLA+yFQXnw75U?=
 =?us-ascii?Q?ud78hIPMZClvnSnauvtbCN5X5FO6gIEZKbpy5czuGz21xONFjjqG6IXRMuiO?=
 =?us-ascii?Q?igm+xdFxJ97yp16xT4oZgrkPKpGKP5V1LDp1/lzV5ckx7E1xUs6618KNRC+c?=
 =?us-ascii?Q?rThRmg6dcwq01RSOFMmLYit7LvpRpwDBb+camFcT+loeu7ARglV6EevZRHu0?=
 =?us-ascii?Q?EuZ0QghVXb7fOJb+nyW9lfP+deCFqVpCCPjKVi0nIIE/ARTY3Q=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8459.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?2Ilgon1MHerCHM4raqt9gwiQ/8j3J++vnAcPv1+cKlhpIVuVfLhgWWtpzODG?=
 =?us-ascii?Q?Wcg+DXagna2Cpspt9y6wisBIzIHOLd9ATUvi8OsP5AObrTQNv/I80WpNGD9k?=
 =?us-ascii?Q?7w7qpJQ4dfIssmSmDRYd30T4hZINJ+lmJKaFADXUNxnU4k1EOz5e7zFiWzrC?=
 =?us-ascii?Q?Pn+jtg5WtJqRNvNxnqKJ4530GKBoK5DydUh+vnojBKgSHXZ7jiSTjUFGRzce?=
 =?us-ascii?Q?LocYlizAMCXgEWxJluBwPQmOsuKtS0PZjKRd0Bel/k4f+ccKMBd/I/tylpkv?=
 =?us-ascii?Q?S0TnWcDPEMVlLP7hZhI1KgOANAAJ10Uyg2hFFeoMSdT/kfeM6vcV/2XvPtCo?=
 =?us-ascii?Q?l2nB7SyX/wWHcyDh5FI27OK9VZjo4GIxvPYc2q+zsZRMd2/tbWWDJWn2UC7E?=
 =?us-ascii?Q?E2NfNY0uqvaPnHI2TBub+NS8BNJZr3YfHL0cCol9rdw8sxqxiUgJsQYs9mMu?=
 =?us-ascii?Q?UkHA8kboLWhcRpe1In08UVsN2+ga+SUPahUE1vKwBZTFdMrcngqY0DwOGD9w?=
 =?us-ascii?Q?tvXYlYwLRFLn3Ta7yA1BZr4GxBEq1Ef8v2BAnmyGmdr4IPYOmy4T7dzF1Ij8?=
 =?us-ascii?Q?BF/N6tQMY+zQ2ccKGKoWLrLcwUpbqZkhaXQgF2WHKn4vBzjKYp4IZ7oT6rJH?=
 =?us-ascii?Q?OfEFFXCia90vh0QMZ2pzzz3ony6nFyTXCl15+XnzLauuhlzyQfJ0r1xCWL8w?=
 =?us-ascii?Q?BETByGhKkUWO3DFyOIJ8tA6N9z3ue9a8cdsx3aHFam6eQ/gGrJH2/GbuDRBp?=
 =?us-ascii?Q?cXgqgWvAq6cQ0kHwbKEFaR20QE02tH3ROKLho1IapknaoZIJPDYIVu2ztWqY?=
 =?us-ascii?Q?MsywCo5V88+wlsywOcJV3WjfJIkwYf+elQo1HPvweJiGdY9vmrtJkwKMBQhC?=
 =?us-ascii?Q?m5f4qic1nwhm46YNRAIaJvvS2IxvMkRELjjAxWh/hRIjDcUMkkv6+DXaJwdw?=
 =?us-ascii?Q?wv0K/l3xhE8l4r53fusA5bj5O+f7OVWX9xKx8RLYQW7KAa08g1YVTE86esxM?=
 =?us-ascii?Q?F1Ve94Hrj3MMpipE0dVe0TsZfJILvFq9RV6BAW9TwzVotnG++HXwKPhcr3P6?=
 =?us-ascii?Q?7naeJd+o4LGqP7HkvJyV/V6oXb/E4iLcwQnspZQ0ta+uPylwWL/W9Qus+H6L?=
 =?us-ascii?Q?4Z0QqeyUe90I2qpQW/uNTnZWHsJ+QSeqG1T+/9W0s6KviALA09U0jmNe4zJa?=
 =?us-ascii?Q?Z/B8IN/7kxnLWrz63r5aQ3Q76LqnuTFxoh0pLxgItIkTw1h5+1EokLLy9T1b?=
 =?us-ascii?Q?ZsVve64xlfRYJFMyEaqjWe2gXtyhIWzZP1C98RV3yIADRZuQVw7t74E6M38u?=
 =?us-ascii?Q?rLzVnhMJIf9elZ7QKCuGd5pI1/E+p1jLt4coJHznaw+s/QZvuZBWv0rmPeQm?=
 =?us-ascii?Q?wh4HstZilp90NxaEHyqMt0e5ZVGvVnGWbIA36rnrkL/d6B20jKZo3m7o+PIU?=
 =?us-ascii?Q?gyOOUf7HWbNIeWbY2k614vS2iPbO5llJSeXKxI6p5uw9/uLNMwhOiGvUMLm6?=
 =?us-ascii?Q?Ry/LtWM1nGocNFLv7oxz9JonjhuPLpjgYNKoMVQBke9SAa1wQtekW0gsBOHm?=
 =?us-ascii?Q?//KGlZ4kflDBFjz9KSE=3D?=
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
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8459.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd2cb6a3-6032-467d-3d48-08dcb7563657
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Aug 2024 03:00:08.6191
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 2fzrAAhlPNWkckftTbWInoh55VibdLtf47B1155iN9OLfLIbp0Gf24ild4+XR5FBAXAxVJPt7Jrqia6rljv0tg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6958

> Subject: [PATCH net-next] net: fec: Switch to
> RUNTIME/SYSTEM_SLEEP_PM_OPS()
>=20
> From: Fabio Estevam <festevam@denx.de>
>=20
> Replace SET_RUNTIME_PM_OPS()/SET SYSTEM_SLEEP_PM_OPS() with
> their modern
> RUNTIME_PM_OPS() and SYSTEM_SLEEP_PM_OPS() alternatives.
>=20
> The combined usage of pm_ptr() and
> RUNTIME_PM_OPS/SYSTEM_SLEEP_PM_OPS()
> allows the compiler to evaluate if the runtime suspend/resume()
> functions are used at build time or are simply dead code.
>=20
> This allows removing the __maybe_unused notation from the runtime
> suspend/resume() functions.
>=20
> Signed-off-by: Fabio Estevam <festevam@denx.de>

Reviewed-by: Peng Fan <peng.fan@nxp.com>


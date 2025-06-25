Return-Path: <netdev+bounces-200903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191C7AE74A5
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 04:08:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5D895A3592
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 02:07:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC1D1991B6;
	Wed, 25 Jun 2025 02:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="U2lP1zFh"
X-Original-To: netdev@vger.kernel.org
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8A16190676
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 02:07:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750817279; cv=fail; b=DzxANPRrcx3KaifiNoSGRx+CIhgjtLyE/j8MzzK7E1aEi2EfG8+LhKPkJlSmytoKkDlX6SLKpJfBS8iH3wgtP2bo5xNWuNRMKtglnLkqddwCmdOoMs89MGOOUYvmu3LbaWeOc4iUpxkd2vS7wVRDPNU/YVaePqNgMvD/iqlEq2M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750817279; c=relaxed/simple;
	bh=Cnr6tnzq6i7zPMqGZFjjLW0AQN8qGXfWTe7efSlDAoc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MDF1xV4+/fuNXRpQB01kJCxonla07Tf9gbfGvfg2uU8J2Akv8pJ8RHM3CQ/KFgw6wLhQ5ETwTMPiA/Lu1eMHdde3NIJqPEPbWduQiHnBCuw+hxquKFbUnCtURpK995sP2Ru2BAtUfQqK2b5+/ocpNE2juE6Oos0vj+elUSl/ppA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=U2lP1zFh; arc=fail smtp.client-ip=40.107.159.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=teMiEd6cjlSzOIY8gjnjZdjGLRS578WJc4WNitSNJZmPPbYXbTcSQORxjX8nThxuNzVLmy2ryHRBa6qePadh+sg+xIhf1+TP5tvrTpPWOtuQod8Iy3M6WL2LxeA90IIDWUA9mw4AfbsZbVhI3uml4C3TiZ75JdcnYxyDrQa+fTOmEM9ithojEBXN3mQ0z5kPLBA4p9XL33KhdxhYi1EwflT9I2rN+4JiP1AY+bhMhsD1rUndzmO79+JzlRXueI6Cq/BsLTCyonGmy/7+gnWZTBLUem4KG2CFemEmQCXXnyS/aMSfM5LXF7XJezTDjTs1zp2/W/Ln8Ue+jlX4HHjHug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NiEf1F9AAwqYmreaWQAs5gDVzfnlITDrE6nY+vrtFl8=;
 b=FHPKxdDd03lR0a8b5ekon44DGuujKJOslH6Qx8Q1xeJ7OV4xgAjyHBa2PxknwiWdO7gBtsjSsJaQqwZY9VMInfkxKFF7U33wYK58sFPDEiO+tS6nPeztB3WR5bqXRzwwbXZ3SBxIpvrQ0ptZmbI+pdVGbMt1ELdmY1rQsuDlNgstA6yOPK9BIq15pIh/+OzuE89bDUSgJvJWpZK72TGR/n1idBjJWC9pr++bE11mnVVENDtDD2XXwHYqhdbY3hyWQidJH4QiWNbHRn2MtmbAeWGwPdwWCBnnYHM8ZaL+/ap9gDgk3WUhCQrsY2bErzgseIG7tq71CYFkCjCkz3yUmw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NiEf1F9AAwqYmreaWQAs5gDVzfnlITDrE6nY+vrtFl8=;
 b=U2lP1zFhfECM2Ioz51YNt8QNullmIhXTGjzPP+h7xImvdusDvUr3Yk3xdfKGI2WoVI6d3B0aGRHf4cBg5kz3hF/J1fyYCD7MTFmO9pTx58IV6Kje23bYHXAX31GkpYjZQDXHZjLHOc1zmwgGMHSszA+TUNneE6fLA+TIIoyIQ/ZsiysNnPCrHzkgSdH5HmHmEb+P+4cryqI1tLBEqSGKBLokkL1eyx7HeieYrJpbMMPys1D1ojdgsD4wxarrsXwzsztLYEuPtVcHzdXkENIxxn799+hSfDp2WT5b/ynQFznQoVXYf/btGrFonrWZhs3r+Sd2zrXlnffF/Likxa7svg==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by DUZPR04MB9898.eurprd04.prod.outlook.com (2603:10a6:10:4d2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8857.29; Wed, 25 Jun
 2025 02:07:53 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8857.026; Wed, 25 Jun 2025
 02:07:53 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Simon Horman <horms@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>
CC: Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Alexandru Marginean
	<alexandru.marginean@nxp.com>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>
Subject: RE: [PATCH net] net: enetc: Correct endianness handling in
 _enetc_rd_reg64
Thread-Topic: [PATCH net] net: enetc: Correct endianness handling in
 _enetc_rd_reg64
Thread-Index: AQHb5SX+lieaBdpcGUGvBFbK9M//sLQTIULw
Date: Wed, 25 Jun 2025 02:07:52 +0000
Message-ID:
 <PAXPR04MB8510AADE753F4D8E195F61F9887BA@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250624-etnetc-le-v1-1-a73a95d96e4e@kernel.org>
In-Reply-To: <20250624-etnetc-le-v1-1-a73a95d96e4e@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|DUZPR04MB9898:EE_
x-ms-office365-filtering-correlation-id: 1639ee0b-d22b-4a27-dfeb-08ddb38d179c
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|1800799024|366016|376014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?DkCiWDcL29faRl9kgQhxJKPKsaLbmEmDehV0j1YUUDoFfW3vDS0lDd3GSYO6?=
 =?us-ascii?Q?V6C2NczH93njmrizNh663sMsFBIh7/aPxxHcWbScZCougHAsxuRgu7vPP+Gs?=
 =?us-ascii?Q?EHLw5Hap8NG9wQCQThEL0y93fpquKnbClAwI/9fAqf2cFoUmUyf65z9AHfyH?=
 =?us-ascii?Q?LyMJsV1IPPelXz2YvFSnFpQo4UGQEZ31GrnVW+4TCI6HJuwQ0RxiONF9UDDk?=
 =?us-ascii?Q?mKP8IUrodsYm8m4+Df3yDfEDAr8WZVQxLcbBPl6guoxDpb+cTTK2psEYDNqR?=
 =?us-ascii?Q?kWAE9fDy9lQbilue7rCzIJyrL98urk5+v2KT2cYczoJgTRex/vy1k1P3d7ob?=
 =?us-ascii?Q?WNagKA94578NeuofcZqMqtCdcgHt4eqoU0xcaOhPq1CeiV2nJ6XoZm2YGaf2?=
 =?us-ascii?Q?HqU2ROdudusL6r/+o53qi+ci/R0vrupmWBfJdGj4S/oWWsUFcoRl74A47KYN?=
 =?us-ascii?Q?mB2BH1O99SSSaww6D3YGDKeffKUYX04K8VVPwRI3Hc6ChiTDOqtuLDmbexYf?=
 =?us-ascii?Q?Vvzw/zFPNAAojddCZickReiK+BexyuopeweQxNFdP/xTLdjUGGXr3xdOsSpH?=
 =?us-ascii?Q?Oh576G9DxyCiUJ9NZRtzf/j8IJ85AYeBupA4U73BDS3wMFNsHlOMKPJ0mV2B?=
 =?us-ascii?Q?hHjEUMADd0wsEB2BrJE7O83SSpQ2SmBc6XGihn360VZuyVHs27khOeNRXcZy?=
 =?us-ascii?Q?Zh7VLfTz+qXIAEkbRG/CFL2gxs/pFfcEVyXa8FoBCl62CTVCfebStvGndyT1?=
 =?us-ascii?Q?EXsq6uN04ebtPlX2MBqp6rPY2pYXVGt0GslIO8S/2f58j00USkJVhNGs/JXg?=
 =?us-ascii?Q?4FqCkjL7KVhFaEpK2E88V2TTysSsQNLdcoT4QbPYQ850lQmntBf30kLT0B93?=
 =?us-ascii?Q?VE6Kr6UtsNASe7zwZr4wkepd8POiBikRYnwLsKlks9YI9GgmXvaPaeTpLqYE?=
 =?us-ascii?Q?BQvJZFRgu3YyWIuG1ax8m7lRg9jiERlUVrfK/UMY1O8Q+GmTL++7xrDMxyUQ?=
 =?us-ascii?Q?DG8uVYVbubdFwwqwCaoHjbnvfbj2L6tT1lzA/OFQpgsZ1eB+hhk0r6ZoKIQC?=
 =?us-ascii?Q?vrRMwtVUViS91xKJrcz7Fdaq83oulEZILyk02wdGNIeDIs0+Xt3OLHBNlz8J?=
 =?us-ascii?Q?/GffbqQMFsK7eqG1c6+4AKFeGJa9hHtd/z3MH1mlysCp6jN09bY7ZMKqjdKA?=
 =?us-ascii?Q?U+oMBGNQvho1eX8NhPTF0sD3ariSDrk7gbD4MpLbhwFyTGrpF+vNOIpyRipF?=
 =?us-ascii?Q?cvD4W+/d1Dv0RLK4+b6Sp/rk4iXnZ/OcGcVhB/94GSzjVvlHbO0xucf3ohu9?=
 =?us-ascii?Q?0DvZzU7XEC6B4CTnR0kwvFnqAVGfc9CRDtsT09UfPuoQGMFYfzSTwfI7KNeq?=
 =?us-ascii?Q?VwWBET/e5sEm53LZy/hMAE5sEzzRRACYNqxhZCHEOCRazRzs2iPZaHmC7M3q?=
 =?us-ascii?Q?nti2pmkDfjo=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?SBHIAIfn2ZeQxoDEjJ7mPvZokp8DB79DRfB47HA08Bhz5j3YmR9XU7r/ZrjV?=
 =?us-ascii?Q?/vmy37tdR2W9y9H6X3CDqA6Gk/JuZDI77QYlJhME1YgCpr4EsNUqcPx9ok/f?=
 =?us-ascii?Q?RHM8ECVpDccfM+++g/ldqqg9CnlSy2L5H6CS7wegSE/em8+MMl8UeYh24sA/?=
 =?us-ascii?Q?3/p32T4iVNFTTywkr6dwFqsNhY5VzKh6MMs4dOkOzGLB0TUpqSkVVmlNeSpT?=
 =?us-ascii?Q?IcjJonB9euwBfNhHg4W+f08Jmpe5mqkf7w9Wwo+jQbb31wW42h7ERgGAH3T/?=
 =?us-ascii?Q?DdXX962trSkUhJ7qoH6vkFRduVMhSy+CScdbXrybJwCWLzjWu/aot5/ulQet?=
 =?us-ascii?Q?vh8ZIP3bdjpl9b3UedWLVoR7QFOXvu/8+Sxdo2s34BmXLLlfh/LObohTO1IB?=
 =?us-ascii?Q?4MZwL3RIme6xUsFIj1a9+KQn2W73QNNTqru9CYGo81RL/mRwxUaq/EkoTPVO?=
 =?us-ascii?Q?A/m4EHBEOMFXEWM8oNPebVLX5O6+Uh1p/kkgW0QvxtGEmZbpuZDch0/RwHwu?=
 =?us-ascii?Q?Gq9/x52REw0kWvByawMC4yhyYpOh6o/g2dJhY5yI/m+VlMZHBbWh+vPiVafB?=
 =?us-ascii?Q?GT6+DZjyRyiFLE7wqCfIeEq9zhS6emTrLKsQUCkvmMNgoCIiRto+KL7ybj9O?=
 =?us-ascii?Q?gn7YRfP/llCAPq8tdap03KoFIPM4JwGQK9wRAj1nLXDP3QjVhnk57rA80Izi?=
 =?us-ascii?Q?Zicur8a8Vf5Vram9XjM09gjgTYy2E3aXkZ3grymyFv2ZyZ9CFNhzswW+7xem?=
 =?us-ascii?Q?FaJd42K+yANFdasM1zK0X0FkbRkqDnn2leOjzzYrsj0SGun68mBXMSUHL47j?=
 =?us-ascii?Q?WJNwBilIIRM02C2LfZXm3VqLEOsX7XDn2QY2Lj5WSNcEcFzyCDS3FPE+Twrm?=
 =?us-ascii?Q?vlvbXBaTDcTN4+LTNwqmRM/MG0js2K1CIZldE3AtByU7fOev3VgAjgvUQQyJ?=
 =?us-ascii?Q?2HfQoRGKpKrNYhCkerSaRHkn4pEH0h5AWAiOhh5BAvCBnyDjyfPtrmTid3EY?=
 =?us-ascii?Q?VVoXOdfNdo9EcGza9EcC1WF7gKEevKu9UQFlVrMk7akRV/WYk7dPvpLex/Lr?=
 =?us-ascii?Q?oYsGNxV++Os6oNo1YDwLdVQeR0p+qDX2XZTUY2axDEzecW3Lg90sdABZcYHu?=
 =?us-ascii?Q?vk/hqfRqjCp3Y/HzWyMGU502dxMznitbN4V6oKEGjOQZW+ZueIfq9msIdMbt?=
 =?us-ascii?Q?d+t/GPpUU55H1znvdeuF3bLsDIx0pSCL53rBU3QE7nqaWyf5B+0N8s5y8U+6?=
 =?us-ascii?Q?x6WfvppZBjNYC7LiCM5q4vFv68m8dGOb0AAy9fi+e6WM2u2T62NxWhnFgEy6?=
 =?us-ascii?Q?SQ6jWRz5jzwclAwdanRKE04HjZzMkWDrGMb0nAgEwrj8sllAPrqpKOrTy4bt?=
 =?us-ascii?Q?YYs17jhZvqdHXk6g9wys1RIPg/q2NwNLnuo5xW8BxKoK1/yeY410pwHg1sk8?=
 =?us-ascii?Q?RkFKQOA0EWSqCt1vi3YZ9X+8JzfmoqcC+ZsNvTyk5nc3MIhNACrQr380R26M?=
 =?us-ascii?Q?TNW6zbIl7pLnUTffBH0t9ULdt/ru+dsiu7YxxnpgMKfzNnzF8TvIsqH0LBR0?=
 =?us-ascii?Q?2ZpaLRB3M4qnSjMbpgo=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: 1639ee0b-d22b-4a27-dfeb-08ddb38d179c
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Jun 2025 02:07:52.4120
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: V4FE83AfhM6HoYZ4HAD/qAz2dbVeMOyC0lF8ZjurxB+2rC4qyASh+0tTquCcmSOlzjwch/Lk9lyYrVMGwsv8LQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9898

> enetc_hw.h provides two versions of _enetc_rd_reg64.
> One which simply calls ioread64() when available.
> And another that composes the 64-bit result from ioread32() calls.
>
> In the second case the code appears to assume that each ioread32() call
> returns a little-endian value. However both the shift and logical or
> used to compose the return value would not work correctly on big endian
> systems if this were the case. Moreover, this is inconsistent with the
> first case where the return value of ioread64() is assumed to be in host
> byte order.
>
> It appears that the correct approach is for both versions to treat the
> return value of ioread*() functions as being in host byte order. And
> this patch corrects the ioread32()-based version to do so.
>
> This is a bug but would only manifest on big endian systems
> that make use of the ioread32-based implementation of _enetc_rd_reg64.
> While all in-tree users of this driver are little endian and
> make use of the ioread64-based implementation of _enetc_rd_reg64.
> Thus, no in-tree user of this driver is affected by this bug.
>
> Flagged by Sparse.
> Compile tested only.
>
> Cc: Wei Fang <wei.fang@nxp.com>
> Fixes: 16eb4c85c964 ("enetc: Add ethtool statistics")
> Closes:
> https://lore.kern/
> el.org%2Fall%2FAM9PR04MB850500D3FC24FE23DEFCEA158879A%40AM9PR0
> 4MB8505.eurprd04.prod.outlook.com%2F&data=3D05%7C02%7Cwei.fang%40nxp
> .com%7Cefddfbd98e9747bd394d08ddb33d1e72%7C686ea1d3bc2b4c6fa92cd99
> c5c301635%7C0%7C0%7C638863797278832158%7CUnknown%7CTWFpbGZsb3
> d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIj
> oiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=3D4mt9vl78XAw%2BqX8
> w5zSo7xUA2aajicHGJnn6KpoNbXQ%3D&reserved=3D0
> Signed-off-by: Simon Horman <horms@kernel.org>
> ---
>  drivers/net/ethernet/freescale/enetc/enetc_hw.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> index 4098f01479bc..53e8d18c7a34 100644
> --- a/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> +++ b/drivers/net/ethernet/freescale/enetc/enetc_hw.h
> @@ -507,7 +507,7 @@ static inline u64 _enetc_rd_reg64(void __iomem *reg)
>               tmp =3D ioread32(reg + 4);
>       } while (high !=3D tmp);
>
> -     return le64_to_cpu((__le64)high << 32 | low);
> +     return (u64)high << 32 | low;
>  }
>  #endif
>

Many thanks.

Reviewed-by: Wei Fang <wei.fang@nxp.com>



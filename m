Return-Path: <netdev+bounces-230352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F0BC5BE6EB6
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 09:22:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A96C63A7A3E
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 07:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6831C244694;
	Fri, 17 Oct 2025 07:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="X8iVSJuE"
X-Original-To: netdev@vger.kernel.org
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010016.outbound.protection.outlook.com [52.101.69.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B183CA6F;
	Fri, 17 Oct 2025 07:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760685776; cv=fail; b=jLEPeDoRyL/PrZbJC014SHQXLidQyLvglqK8pGsGoWkI0tHUcugFu+E/pNaLuabAO/sl0/dxGmAKvCdH0ghJmLqyuTD1/zvbJ+WoCZ9sSJuwr1ijPkbmGOzP79W/DFD+pMLo8cWQlx22ILjveywCozO6MvSX6mGNhnsG0tjEXFA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760685776; c=relaxed/simple;
	bh=ZAijHdOxVdQzAfXnl0+XSEHedpTQETxoMCZ5Rlh5T5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=poCBcdJYSAEB8p+uzxCak0nKIEKmHMh9gUqXJqZv5Nc7Hz1+sQRs1CLRywNCqF7Seu5g4ia/GPQB7JMn9BZXU8p9XySsqZr+6rWxo0S3g0XE7Td3nGg0KWMNC5WwM6QKEWfbvCQPX9p7SFM1fUrewjD7GWJykBQWDvtitNa0x8U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=X8iVSJuE; arc=fail smtp.client-ip=52.101.69.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OUxBVV1sxQk5gQoRZ+snyZtV2l+9eaibuA6aXELCrzh/WwwOz/PA40IHSFTrF8+fKJ4+d5dhLhPrRYJ8yCv4ODvrgCKnK6qjStXyvImHR3MdxVKCKdmZwVNzv/72VVcPhtw75EMN6qncZjV4f4cEtp31C2bZNm8RXmo9II0M9yw8nsHlO+xsR5WS7lo6FeD36UZjw6xMwx+sXRgto8LXoMB1eTOCmrRJvojhUxS1aUK0lMxDYu0BqDa+9GEsLMzbf+W1KidIiKIlPU/3juNRkR/ZRD1fZeRj2zz4NLxPaaqvdNjDb/5fCvOc5v4UR7ILh68iJJWW6WaKxssKpxHebA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZAijHdOxVdQzAfXnl0+XSEHedpTQETxoMCZ5Rlh5T5g=;
 b=LXZs8z0gySLDxjoaB/ZOxGbAyZkx1A2gciSMRcHdNHqXYS2jKsjhsOAgleDnrMytj1tYfwADdLti1EYDuFD8SSRjXW3s2O8XpgfkzfR2W+7HNFTgt/HwOJddSTw7qIpFE5kkyRloN0jr6yAyQgBN6g0dKoiicb8rqVpyFcUd6FbDPGxecuL6H8bKjlxP1ianKzDAiqLmzQYBe1aCxKoV3xdetdkgIJmWlnkVphLghI/vdu/uUOrIIePcRiqd/fmQQQOCNn/rMuZZlVffVVKvqsgqqxDhiifjvJOkSmqFgecDOOeSjuy/JUJs3Sz8QfUn/s8HKc8HFVJp2yiIZMe1mg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZAijHdOxVdQzAfXnl0+XSEHedpTQETxoMCZ5Rlh5T5g=;
 b=X8iVSJuEUyOU0w9Pg83bWNxb82dXNXaPKjoOZljXmZK7PAJZyQZoBgmN8gnWWjD48jJa027fboI9KB7Inc8myL80iZa1DkkrHxv998kQro6A+56YEQBl+xNUBEOqWFx6BONm6bP2iPxk1U1Yk5yJGXuxAHV9rYJnnTpqe+gD3AuTifJil1ipBBYNlcS96PF/hNhS7Usw+jMj2LtwSm0jU3zn7Ud28IMKruo5+ONo3gg8fNkY+yrHbvmpgk5dVBs0DwjG76ChNeZq89NazV/BCPeTN8sH4yCUjhR8sCA876owlm/9Kw9yfofIz1bTswhsWGsteczdo1EyFf8ZBmWMIQ==
Received: from AM7PR04MB7142.eurprd04.prod.outlook.com (2603:10a6:20b:113::9)
 by DU2PR04MB8885.eurprd04.prod.outlook.com (2603:10a6:10:2e0::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 07:22:50 +0000
Received: from AM7PR04MB7142.eurprd04.prod.outlook.com
 ([fe80::6247:e209:1229:69af]) by AM7PR04MB7142.eurprd04.prod.outlook.com
 ([fe80::6247:e209:1229:69af%6]) with mapi id 15.20.9228.005; Fri, 17 Oct 2025
 07:22:50 +0000
From: Claudiu Manoil <claudiu.manoil@nxp.com>
To: Wei Fang <wei.fang@nxp.com>, Vladimir Oltean <vladimir.oltean@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch"
	<andrew+netdev@lunn.ch>, "davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>, "kuba@kernel.org"
	<kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>, Frank Li
	<frank.li@nxp.com>
CC: "imx@lists.linux.dev" <imx@lists.linux.dev>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 net] net: enetc: correct the value of
 ENETC_RXB_TRUESIZE
Thread-Topic: [PATCH v2 net] net: enetc: correct the value of
 ENETC_RXB_TRUESIZE
Thread-Index: AQHcPnY8f5rpGnda2UySozUoIATsj7TF7+hA
Date: Fri, 17 Oct 2025 07:22:50 +0000
Message-ID:
 <AM7PR04MB714270BD923D7982895C5CF596F6A@AM7PR04MB7142.eurprd04.prod.outlook.com>
References: <20251016080131.3127122-1-wei.fang@nxp.com>
In-Reply-To: <20251016080131.3127122-1-wei.fang@nxp.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: AM7PR04MB7142:EE_|DU2PR04MB8885:EE_
x-ms-office365-filtering-correlation-id: 1d4f006a-ecb5-475b-1527-08de0d4dfacf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|376014|19092799006|1800799024|38070700021;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?rNC++WArIkswtxODfEEe5f1lupy4gGGpzyi3Ru/Nd1/hM+i3ZvFHd0VsGshu?=
 =?us-ascii?Q?LAb2n7RZKEWb38ZShcI/8/Mr/KWykO34aWHyb+IQ6+E3ntFx9iDBF9KHQW9M?=
 =?us-ascii?Q?J2x+4g4Aq0w1r4z39OKeIWOv8Szjez4F1StCNxV6aQTiWEBMP3e1KgWWPRQU?=
 =?us-ascii?Q?HXWbQCx+cOhdxjV4f9xpdQu4S9o4PNeegvAXHAaGN7qDFmulThK7zcerSk6s?=
 =?us-ascii?Q?/dJZbzl2L2jp20mDhRU5Ukcy3v8P31xhX3mqgccnIkmTBjHaypa6s1tUDEgV?=
 =?us-ascii?Q?K1UYWSvl9eeEcOFEnbu0xhHPhpcSzraoreKC5KQdS4Na8iTU5QKfyL+t+stU?=
 =?us-ascii?Q?aDE3pP+UF4H0uU1jp+FlUrun3/TyrhKwWjW0YFNRgAaVy//uYS9jSv2x/fka?=
 =?us-ascii?Q?yrSe+TciRGr6qn+8Ku7DHIRLHnmSkiPuDzJ7girJ65VL7Y7EcPFZMPTJUovz?=
 =?us-ascii?Q?uWv73W7WE/KcgRtjtWD8Ed7daR+5F0B0ksHZuYWeHtREWZ5cvt20GeGKUT+y?=
 =?us-ascii?Q?8PjSncMZbpjCgITthAWgjo+j1rmEtvm497E8CPE5TYG1VZEm4uevIbvmlIen?=
 =?us-ascii?Q?wI6p7Tj2alKNnGK/z/XdPOOr3/ertE0SzVwS4aLOs7GKX0yQBR7bnjno4Xmx?=
 =?us-ascii?Q?59GXWPiFKC8qFniY6zxsTXSevUV3hvzv4Dp394gyyyO/wHe7RASDC8rKzJ4p?=
 =?us-ascii?Q?449TmpGwyhLSK5z+O9ukFK7AkPi3VEkCEEml9tjlTJN41mYuT4Lp0yg8W1UX?=
 =?us-ascii?Q?0SKVV8y7tkSMF4ZrCVrzWRvpfh4TJeAibc451dvHuU58iaAm8WWTHgcKLJfW?=
 =?us-ascii?Q?e4puiqMAl1tXlRefBzlZ6u4l2kVa03zRAkhIvBLjzcj+kei6DopmOFZs0VY7?=
 =?us-ascii?Q?7hktz13K4NMdEbi62K1LR3H8MCHP/LQYZOMm6vzRwf+U8awinzHW5L2RyAjX?=
 =?us-ascii?Q?tlgq5aV4WzwHGX7e/pBWMkyDx+mIX4/JM/temaUxZTMUeETps6FshVzIM1Ac?=
 =?us-ascii?Q?uidg3w5lUO3VrmVCy/jMRNR3BnpYfVOxPjRKppDuidU+PN8OMfVnBNX18adA?=
 =?us-ascii?Q?x9j2eYc/YktVfKpdSq5r+9C2nRSPJFIRLtmlLBlEtQzqWk7NMTBKjxLbnEAz?=
 =?us-ascii?Q?Q1rZms/0G0B5j6VrpwezWWr/NJT1b+z+zGeYQBwRAJTLiRehGxnT/h4k18by?=
 =?us-ascii?Q?GIyWtcNpBR+oa8mYrRJ0ZgEZSd6tXP7Y77g2kCxQmjlJ6bKYcAmpKiD/C9uU?=
 =?us-ascii?Q?/WhNgRs79dVIhMy/FGBCtvQop/XBcjk38Ij3pGNGEr+wh05WtV0FKJjBSDMl?=
 =?us-ascii?Q?ALYU07BygTsAFRvhrZCXi0qQpzFNtVZThvM2t4wEN6SR3j7lwcUDblYrWBNa?=
 =?us-ascii?Q?2NAElfL1wTMWHqK9vIVwBsuG9wpqbrvyPABXsiHkYjQEDmJaCtrRyrqzK3Jl?=
 =?us-ascii?Q?j1aphpqWgLH+u1CjpJkiaTjEgVaaC+6PKOaEk/XzTue0qo427mbwkjztZKbe?=
 =?us-ascii?Q?hywYXDUzluAXdPUJL84Aijwr2Rg1lp5Cln3A?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM7PR04MB7142.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(19092799006)(1800799024)(38070700021);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?X4aNum6Cb305WjDD28Pwlt7PCuXDYVS7TZ5LOr3CYjOf4bwFnkTOJd6zLRj5?=
 =?us-ascii?Q?kQjW8hZawMf7tWvD6fEXEwc0+2rqosSoKqQuwDwAtHBUlr55o0aemsVdCmih?=
 =?us-ascii?Q?A6QjxiESiWMswgL42KstKaEEIenTxZaS94eehZPV/+h4ooAoCr9hpPyQIlta?=
 =?us-ascii?Q?LH/zA2GE7xme3QZlbjDH0tbM5S+rNAZSFkciIslDZ+y2wb2U7iNFulfkPKtA?=
 =?us-ascii?Q?yfbiW94i8eyUy3XKwGzn90X7gGXzpoBNWR1wvXQM8O9wtX7ywDtTF/JxHkw9?=
 =?us-ascii?Q?MUtFtJS9d4jYNTA8rwVJVGwfuVrfn2wawiqIgIuN+tRdpkd0fkkc0TgikZWU?=
 =?us-ascii?Q?fWHe5LgiLEuxC0FpTMcUfdn6vVHC3pCYujeLFDy+Yc9swnA0Uf+d3JGh9t1K?=
 =?us-ascii?Q?Jr/PKxrsMwGJYj9348ncWsGXRiSFvz7MM7BgHRowO4TK5I0grXrTTkizDo1M?=
 =?us-ascii?Q?IVsD6CO7lIiaWgQeB18dRwbLNKCmnjGNEZWHXnAV/30lXlOcPYfTM7PtqPSH?=
 =?us-ascii?Q?Hgv0XRV0jLcueYFXrp0mC/aFP5nOxS6BBpt1NPbxI57tcjfDXo/JQHJOrFNm?=
 =?us-ascii?Q?cJz45yxEqUQ1TeIHhCYD8fs/rYJ8s2JwTOX10I/URfdHCpO9m7p0i0XA8lDC?=
 =?us-ascii?Q?M05NjHUXwV4Wh+l4pL823USj97DyBhZLYc89e9Pso3raHnEtsUP9hriSMVlD?=
 =?us-ascii?Q?3nKDq14koTErup674+zxQ8d3AbSnUCerjNqbhr11zZob1ld5KDZWVXODN7i6?=
 =?us-ascii?Q?NNMJvjcvU1vtq2CG4FNO8STDr9ggvGF4qRK4wJCSy9rl5X9TB2+O5dMDGkcq?=
 =?us-ascii?Q?6GcYJlkIuwqGNHgtfQnhj2nOJEifcOWiY/osRyC9UIzFKcCf3PToSKcdxmvx?=
 =?us-ascii?Q?c8OTBXHzChgh7+k5tkDlX9fQ2nyNbX5R4bA3+hDPfEq+6ecNVf/V6xgBz7me?=
 =?us-ascii?Q?MGq6WDSTGHr4aMmyGwqkzu1pxEApYEjMz8EUv5Bvxdg5LidRy8S0fxQRLeV5?=
 =?us-ascii?Q?fOXm8wjUUTXk4HNoEzDb2j4PiO+Fw4XPbEZiX6fubO+9i61GNA1VZOjFtujq?=
 =?us-ascii?Q?Bd7xM/KTbPMf6Sm+DJBzw5+4mJFtM7MZkzil0hpFVI4aBbX299c9wDiOextv?=
 =?us-ascii?Q?Mhzvje0TH3A01QVoGHL+rT+WhhnZyk7iGtRd89axyWluXrIFLf2T0vJ1xGtL?=
 =?us-ascii?Q?fspGy+fbLLNSj796Y32/h+7DQcolPZbkLxUpQmAcdlhuWcorOTgFFAoJO/7w?=
 =?us-ascii?Q?P/BeoE8t/1uu30kClbXshmCbUtA9q4ZCHVm+cpVERq6F5Vp98aaPx6dKZP54?=
 =?us-ascii?Q?CsGFF2mVC4iPxrkyMjKtg/oKsR11MyXSBDqjWdNCwjVvT4A0JPQXQkfGTPsf?=
 =?us-ascii?Q?3A39QI64ucHCei2Dv7lZQOpawZcNr/zIOY0I87vHegm38cz1BoSjo+kmvujB?=
 =?us-ascii?Q?q9j9X9FjX/Kcwu9BuX76QkzejrxSIPfcnWb5bQfAS+XH49Dsvf41e9YKJUSt?=
 =?us-ascii?Q?CpCf2+ygSwXB3Q4srqDEXVWKEjy6F5iys9POwSC7RXSHuZb9gVFyKrgvE4ta?=
 =?us-ascii?Q?oDtFobC7hoXknNqFy/imgzOKhMcPrCOl/iigXgMJ?=
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
X-MS-Exchange-CrossTenant-AuthSource: AM7PR04MB7142.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d4f006a-ecb5-475b-1527-08de0d4dfacf
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Oct 2025 07:22:50.4274
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BjCZzZceW4PKOgH0t9sj35uvKy+0cfE/jUJa325F4wnjKGHQK7orSk6vGydBO9aH43zzkDxOK+oBPo5hXHghMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8885

> -----Original Message-----
> From: Wei Fang <wei.fang@nxp.com>
> Sent: Thursday, October 16, 2025 11:02 AM
[...]
> Subject: [PATCH v2 net] net: enetc: correct the value of ENETC_RXB_TRUESI=
ZE
>=20
> The ENETC RX ring uses the page halves flipping mechanism, each page is
> split into two halves for the RX ring to use. And ENETC_RXB_TRUESIZE is
> defined to 2048 to indicate the size of half a page. However, the page
> size is configurable, for ARM64 platform, PAGE_SIZE is default to 4K,
> but it could be configured to 16K or 64K.
>=20
> When PAGE_SIZE is set to 16K or 64K, ENETC_RXB_TRUESIZE is not correct,
> and the RX ring will always use the first half of the page. This is not
> consistent with the description in the relevant kernel doc and commit
> messages.
>=20
> This issue is invisible in most cases, but if users want to increase
> PAGE_SIZE to receive a Jumbo frame with a single buffer for some use
> cases, it will not work as expected, because the buffer size of each
> RX BD is fixed to 2048 bytes.
>=20
> Based on the above two points, we expect to correct ENETC_RXB_TRUESIZE
> to (PAGE_SIZE >> 1), as described in the comment.
>=20
> Fixes: d4fd0404c1c9 ("enetc: Introduce basic PF and VF ENETC ethernet
> drivers")
> Signed-off-by: Wei Fang <wei.fang@nxp.com>

Reviewed-by: Claudiu Manoil <claudiu.manoil@nxp.com>


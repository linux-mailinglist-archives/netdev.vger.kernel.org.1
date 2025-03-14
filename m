Return-Path: <netdev+bounces-174790-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17BA2A60705
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 02:29:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AC6397A9C50
	for <lists+netdev@lfdr.de>; Fri, 14 Mar 2025 01:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC357D530;
	Fri, 14 Mar 2025 01:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="V1fpHnss"
X-Original-To: netdev@vger.kernel.org
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013008.outbound.protection.outlook.com [40.107.162.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74DD72E3374;
	Fri, 14 Mar 2025 01:28:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741915733; cv=fail; b=N+zOz4tDq3Kr9SaXInr4bcUwlshZEvtTqVaW7vvVFnV32isctmWTkMccQol18Elm6MRkJ15mLe4sRvd9wWXdDymdBMTfOb/YQA6BAayfIJJm/1td5OMZ7hEJaaLyYwn+k3RmvLKvRFj+7+mCFFYo8w8wkhAnP7KTTyem1GPQY9A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741915733; c=relaxed/simple;
	bh=qlsyXlEZmCBIJHkz5PtOYxFu0YwSUun+7mcqxzIOj4o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=N59zJhCFaohP2ejtdH5BCKJiZmM6UrfrSA+azA/yqYlo7t3t5HavW2nTCgdYGjFuvOVFa+bwFeOyK4eyFT2P4CbgglVQlGCA7H3ZpGMiQAqPMUsxX24vi0pGeT4eBOQpx3R3yCMLlAJtvhUTr+ldUW9ykk3YhKtauCiy+rB9O7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=V1fpHnss; arc=fail smtp.client-ip=40.107.162.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PpQKpp5P7zAM53OsKM3lfk39L0yxlEcz+XiBD30NQ/QUT60lIJK8hr2FK6BUwBlDLsDqPSA6FwED3XWddmldnH0lo2rD5bcl7M1a7tOwnUUgZDLaGxi/hLZ+zMW95UgyH0/3brC6mBG8bYqCAawV+cLpswPV387niWppbj6soQVBeFYbX72fpe8EUsoAJ5C4KoC/pP77rszs75vjX80+axC7zkBRg90sDQhu3eRlhT3okTqdqQA1USWoyzFQs4q2BQ/LTSzjt1SiuQGXMVdvA88cN8dM+aarPqGEF9/zrLv3Nmkh4nf1yly4PsJ0qTssmSbrj2L5S/d7IgABeulWpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlsyXlEZmCBIJHkz5PtOYxFu0YwSUun+7mcqxzIOj4o=;
 b=vNOsETot433A6Ex2RbgdnN8tvjHNqWyf/CJAgcv+WiGIrqFth7F7MCufEq/mfjxYjrfPsZx/NkU+Nl9LthAXyimP36UqirABOLo7jRal2tsJCPeAsenfVId+TKkmZl8VClZDXzirLr2ioJ3NhR4ChjiH5X4j7Fv1oStA9r97B7ZGJkPeGmQIYyhOYdIDwO+KP31vQxpmdEaxJBXDFxu3a3ExUqGALmbDYxI0JmKCu64Q3hGyyaQeZmDPLvdqiX6OA9jHkgrI/GJbu8NqzxNLH62+HVXm9Ghm8sXOwBKwYnaPLfjTTsJKkkc3YfVkgR2C/xxgWLCYoBZBtGn2YXxGQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlsyXlEZmCBIJHkz5PtOYxFu0YwSUun+7mcqxzIOj4o=;
 b=V1fpHnssQhPjhHsK+T4ZV2PsV6pbrnsKU8HnJoVSu3pthivvREjwTnpD2dmN2TqqE1FRHiJgWKGK2wp7u036LaH+jnO34MtgydfMhHu5q8RiwYqwiDEHk7GsIRVl4xT7bmeyGOjqWUMRAiU+kGtK24sXiVmgQaGAJ3sjcshi23T3BAZAKr8sxIvfJP9fH8hn5EkCsfjAFntAZFHgrZw2biVEgVuKESxZ4tEI3BLlwx+CAyQPPkjfH+eBaI023dUb7qHMasZgo0roSffYYzAkKMorGB1skXRjb+BIy0s9vrBxY0w897UrShO/ujehVcHgTgM+V0E36sGa5NznBc03eA==
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by PA3PR04MB11178.eurprd04.prod.outlook.com (2603:10a6:102:4ab::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.25; Fri, 14 Mar
 2025 01:28:48 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::a7c2:e2fa:8e04:40db%5]) with mapi id 15.20.8534.027; Fri, 14 Mar 2025
 01:28:48 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Vladimir Oltean <vladimir.oltean@nxp.com>
CC: Claudiu Manoil <claudiu.manoil@nxp.com>, Clark Wang
	<xiaoning.wang@nxp.com>, "andrew+netdev@lunn.ch" <andrew+netdev@lunn.ch>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "christophe.leroy@csgroup.eu"
	<christophe.leroy@csgroup.eu>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "imx@lists.linux.dev" <imx@lists.linux.dev>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
Subject: RE: [PATCH v4 net-next 00/14] Add more feautues for ENETC v4 - round
 2
Thread-Topic: [PATCH v4 net-next 00/14] Add more feautues for ENETC v4 - round
 2
Thread-Index: AQHbkkpAQng3kVTgPU+Fe/EB7aXGq7NxGTyAgADC7cA=
Date: Fri, 14 Mar 2025 01:28:48 +0000
Message-ID:
 <PAXPR04MB85101D921FD07B882E03216088D22@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20250311053830.1516523-1-wei.fang@nxp.com>
 <20250313135041.uex3gvhpbmnh4hmp@skbuf>
In-Reply-To: <20250313135041.uex3gvhpbmnh4hmp@skbuf>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|PA3PR04MB11178:EE_
x-ms-office365-filtering-correlation-id: eea1d685-b7cc-4129-8f9b-08dd6297921f
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|366016|1800799024|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?FLVSD9PuoT8anqurMFUev7wg3nZ386lp1RVKoo1nLr8virSgRY4j4nTZEzEe?=
 =?us-ascii?Q?R3aN9einLgvluLjA4lco7vB4FiIlEZs9GSt8PZtBpgs8Akv88pWvwqELsW27?=
 =?us-ascii?Q?gpg/afJhWR2r0G9zBx77AH1EpA5S1FAGYBwbgGcSfkiduLUipZ5HXSxU/nt0?=
 =?us-ascii?Q?GzU5F5qacgstyOB0quwX2LEkhtZkwi6kRIomxu90YRWcqJuMI2xDoxkwvq2D?=
 =?us-ascii?Q?DPWH4mqw69GwaBMXgYzQ1/UY3fCwJsaKj68tlvTDv5Qmg/U+DX1XX5wKhlLC?=
 =?us-ascii?Q?VfFrC3Jer2bMWvZ2q717Ob6vuUjjctdtPOIkumaaTtbFVED8JohmzHcOk9yV?=
 =?us-ascii?Q?4tLKVqHnUBdhzE8cGGyrdXNsrEAaT3zDy7dtbbWlBC4QWHUVA0OGvYfqUMfN?=
 =?us-ascii?Q?XGfOJwdkIfPC5nIALshBiumG9D5D9PVYLO2yE/OuBw86M6VWjhAYVj46HOBc?=
 =?us-ascii?Q?qIYi35WGttW1FrG8AJm70I6znpnyMg3XLkMdBmEqBr/EiicvqYSLLuIh9W8I?=
 =?us-ascii?Q?z0ViXtYy7y+LeALf3fpwtK19bKSg0rDWpyvZ3Y0EMsBkrzDWopZmp/IcL/5O?=
 =?us-ascii?Q?aN8PAW/Cp/Qti0P4aRExQw7a4QT2sy+ckW+bN05mt8JJGevFcbe83t7LP1HO?=
 =?us-ascii?Q?m/csKAgGiV6Bs8gVLZUw+ek1KQfaLH+b9Edl8T7Jy0TU90VRmtx1UDsGTdg0?=
 =?us-ascii?Q?P29Xa7WCUs5cSCi9Z5rt0MJG0Dv5ZkWrcc2DkGZU0KaKAUgScnDmYP1Hi9YH?=
 =?us-ascii?Q?pp8usz1botCMTjDkeYZHA2V1Apk+xL6xOhc5yEQitUCMoWxxTeVQVGbHKuSP?=
 =?us-ascii?Q?W9rKtlbnfn7FYPDPbR26emE/WMj33rCzfVvS/1ZAIyYL9sdQfXEyomMMC2Ee?=
 =?us-ascii?Q?8AG4q/si5M85I0xtMf0wJuAFNw5xmeH2MjIug36c7BPCdKmENdJBsQnT7kOD?=
 =?us-ascii?Q?aopPhWK8/0cIgrXRgJYV004S+lL+OIK8a8hcYk52BBNymJc6ux3fOCiKVMv0?=
 =?us-ascii?Q?K4h7ex4/dkZnebwa2bF6ctOjqsK2ylBA50Yntz8MDNsZ3xQ0Fml/bjIT3cNA?=
 =?us-ascii?Q?Ybx3B/nKcyEMpFrX0a6JWgfzqAxOt1eqjCMNd6iO+n4f/RpxdhbY1gN7p6sI?=
 =?us-ascii?Q?N9ABTD/LaM3OqkkB4Wwmer7HnG9a96AVgn30i+NWEwxIgALrXSeS2bhhO+WT?=
 =?us-ascii?Q?nJTVjtwfm1XFU3rfz+Hb/B4CpeAB3u38k24YSVUnd/vZ29LKMHIaA9zEOCbb?=
 =?us-ascii?Q?Pbf6J8N/tptGXzFaZjngz5b6TPzzd9n6C1oQ9axnzNSMohvYA350TKJK2MKZ?=
 =?us-ascii?Q?/d8YFNS2l0y0yHN/XUEMzESE7g+e5oBxg2F2hgIYQ/tQlXUlUQMvPPyq7Q/j?=
 =?us-ascii?Q?LSnh8aTR5aAiuhvlTxabxis5qz1mK3Xrr1CeP8OKrtEzqXipm9mN1mXwkWtI?=
 =?us-ascii?Q?vqUrekvDGa/fWEPWcIjDllb9J0hPeK/6?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?JYfAl7u4deaLol7phXeqTng5vD8UaV6jSLk3DQEVTSW7AJsUdtyUeDJlRFAa?=
 =?us-ascii?Q?o4Vin7g582JYdGPdk0wx1BnD/X39SkWNvWePa2VJGCTseqVY626fMMjg+y+i?=
 =?us-ascii?Q?YBv0f+dCJDo9ckEaeRi0v5vfsprhyU7UlZq0Ra568+WGYF5hVfCcbUhwAJcW?=
 =?us-ascii?Q?C5RL0nIXUQ0CsqKsKPvoNas0eHlDow/+iV7AQMvbUZtI8h3S1qomvEAWnNrN?=
 =?us-ascii?Q?Au1GHMY+IV0hPENC/haHAxtf8ucQWYLgoOv0PUI+/RMQ2KjE5+1WF1ye0ZAJ?=
 =?us-ascii?Q?3Z04Nc9dFKj7JgP7WFE2TrxSEGT+UD2ssi9ZzKq89CVvJoq3zzFCZuraUbO9?=
 =?us-ascii?Q?ro3CAV1PaK6Lw0msrRe7sRBtmv+HKfWGb3PDLKFJHYBjPmYYbm3EAJpFIrJl?=
 =?us-ascii?Q?9rxg098G0T1klQrUlN5IzMTYf6U8Qd1MI4MNhzPx9cY+TdcwZgXC2AEodY9u?=
 =?us-ascii?Q?YqiBF3/EpGEM+zjomjpn2Je5mEAG7BkXYEsz++T5loSnFzSeia4NsDMqzb1+?=
 =?us-ascii?Q?rmm+P384reeFfLtEjQSJUs+JZyCO9KuErZbQ/m+nDn9qh+0IK7PZJu9fgUZF?=
 =?us-ascii?Q?XeH4DjgjnaI6MamI/awYMwj4kHlhkhCUBlby+fNP5hTnJc8e+o1ngNRDT3Jk?=
 =?us-ascii?Q?Ff7ETOS01Ph8z9czuOgmYFYxxULJcEfyFVo9iufwPYyVkDx6Is2s7sSPlI44?=
 =?us-ascii?Q?IXr6bTB90/dmjFFT1Ea/kCBX1ZN4Yw5+hJb9wrDgrYjcJlZPQK47UY9/Q1s1?=
 =?us-ascii?Q?0ZDY8fKtLSwDzXNFRyACkObX9VaF/JQjS5xVNG/3xLFrJDlM38kKb0K/j+4l?=
 =?us-ascii?Q?GngV5+MVuJFHfjr8C3M2S+S7nowdXFWxBVfNK9ECnUyvstljBmjnonqLQ8T6?=
 =?us-ascii?Q?NrH7NwrIUXK+jB7X/T3GWBZ+0vF+Zhpxw7s9QjI1n1WArSWwWcc421yfH2yM?=
 =?us-ascii?Q?6mFMDpbb1Puvljoy0oVWIhdUA4BqgjV35LEJW+upo4Iy9OM5nXJZyYIaVOCg?=
 =?us-ascii?Q?TfUOtCZoJDzlw/LIHR5ddNUvdXw2RsgRN5yjlLsQ7DGhoeXBUc7sR7cJzhTG?=
 =?us-ascii?Q?1VG5IZMWE/AoH+Gqm0D7cAoxim2agC15vC/7h1UEJsM76z/AGJx9sLfGk2wk?=
 =?us-ascii?Q?CizYkGEkLYtjjUUZGJwkBVgv5n436f0BUAsRQdOV9liU41oBNmDrvD1bdArZ?=
 =?us-ascii?Q?VITVIkAiSUQ9hKsjxKmP1ytyXh6663fM5pJbizTYLRNEXSbdM5wNtgAYd7ei?=
 =?us-ascii?Q?eiyiEQgEIzlKUGPbk+UKnL8951iI2Db9YOHdz5YFCezu0UGqGt9A1mZxavGB?=
 =?us-ascii?Q?WT6zGmRlghKAvnxQUaOSw40igarlEIE69OaIodIzo+dinysfQgMd0GljkI6K?=
 =?us-ascii?Q?k+ueTvR/zatPU189B9wL3pcxQRJ7KI//yGGA6HVzG41HHgTaVJmuZEKGpyde?=
 =?us-ascii?Q?boBGowUruTfh2dhB/pyHTiz/2DEObEjmPMSlYYcKp4mQTZjrbohuYB0LF87V?=
 =?us-ascii?Q?ztT6lw/Qf9y3qwHYBG2IxZKLbq4xMS4vBFMW7+QdSJ7RlGAPKDEak5GRE3Qy?=
 =?us-ascii?Q?faqfHew7C4hPlzdo2U4=3D?=
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
X-MS-Exchange-CrossTenant-Network-Message-Id: eea1d685-b7cc-4129-8f9b-08dd6297921f
X-MS-Exchange-CrossTenant-originalarrivaltime: 14 Mar 2025 01:28:48.7083
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: p8iTf4VROLielJmJ/KnFjKEq4Mzvzzb2uwHibM7muJ6EsyiyHBtyABclC5OwfjOp+JR63cCRpcZVkc7tUlTsoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA3PR04MB11178

> On Tue, Mar 11, 2025 at 01:38:16PM +0800, Wei Fang wrote:
> > This patch set adds the following features.
> > 1. Compared with ENETC v1, the formats of tables and command BD of ENET=
C
> > v4 have changed significantly, and the two are not compatible. Therefor=
e,
> > in order to support the NETC Table Management Protocol (NTMP) v2.0, we
> > introduced the netc-lib driver and added support for MAC address filter
> > table and RSS table.
> > 2. Add MAC filter and VLAN filter support for i.MX95 ENETC PF.
> > 3. Add RSS support for i.MX95 ENETC PF.
> > 4. Add loopback support for i.MX95 ENETC PF.
>=20
> Can you please fix the "feautues" typo in the cover letter title? It
> will get used for the merge commit.

Yes, sure, thanks for pointing this typo.


Return-Path: <netdev+bounces-125224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F03896C548
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 19:22:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A396C1F290F5
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 17:22:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4949D3D0AD;
	Wed,  4 Sep 2024 17:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="IS3KhL0S"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2067.outbound.protection.outlook.com [40.107.220.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1D41E1A27;
	Wed,  4 Sep 2024 17:19:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725470394; cv=fail; b=ptIzUuuNLa7ZjfeCRfRYTWu4HFMxZWoN2DKk8Z1GvCvXRemdk80Y94d5QLoagpI/pnUN88MHsQBbak/gmFW0cWZeQ5z+zBuLEDfmec3Di3Fnfs55PKQXYCu18iZ22vmVlPO8uL+HbBYS6vfnA5CLcIa6yZYug8JTodPtljkoN7s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725470394; c=relaxed/simple;
	bh=lzNlb/MCur5TW2RTBVuhjpQbOQIvezxEPO56Ea7MKLc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nkU3R7KOxkAgR8G2RCXJZaikTDGsiG4OL5Bi0QMjECeIZINn3asX6JdTOpD3ktD2/xFOQ4IcOyJqTvJal4JMoQ4GZYgf7s/Aqk470b/X8iLItIG8alQl+mtjGjX7AUT0lrc7Q9kvpFoV0GYnbCEknzoIfoDv8J9lPDPbVP/AHDU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=IS3KhL0S; arc=fail smtp.client-ip=40.107.220.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fNn+4pY2UKoUO4pqTT66MJFF6rgZgnJyGa0qEzcJk2UvjyQf1etClhrUhdhvMGYhpLlJZ2x1IkxedaycD4qJcov7DNJu63zBMTugBxfXLx1riq8a10S1RY5ui33q7QqshXOnP6DR6dmX9iYv485X+UollLB/jYD+wys60isY7TQspjuRdJscOafsBh0B5wZfjaEJYmAO86q1rBbzfPA/nLnH+QhULF5O2NTdPPp8Jd14vr5Q9Dka9c276/yNWr+gFWoWacY1NpgqFhaACRlTOT3O76qQ5AtcbOA5n2LAbzoc4pyhWBqOZP1wQiO5LYpYi+02Iuscwkvm1Rfle8k/nA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QaKsQimKARFSNcQe7p/zF6EHFyqBhkOK8IgAaTIoXzA=;
 b=bUF+soYlH1ecjMoAlXHIl7H0q/CT/8i19BR33iJgdvM8yX9jrWAebgKlJFz4/PaFyTKx6fppzRBEDbGX84r7TMC4pOtQ9JUPDCWGoqoZAuyfznZolpbpdL4epkExF8PIiCSp+ET+0B/G8gtNNVKjvwBt7s0mARurpgoqJF0RJtQt6NpGBWiDf33TdwT0MG0WFXOW4U1XnR7t/uRBxHekj5tLZkqS4UVBU3jRl++LY3y5/8l6/Eo6fX+Uds0QDXUElja9ydKQ3d240ozyIyZZHoPTxBQs/Ao0PZxC/QSvSB43nubDCnwNnQ5NkNohaX/Ybu0PEwrYmCvSONLAwpeDxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QaKsQimKARFSNcQe7p/zF6EHFyqBhkOK8IgAaTIoXzA=;
 b=IS3KhL0S/y0zzpVNPBSL/dG5L5KmhXzu+mtV8pfrqvaWTNixrCLTolvXlxAp46p7jWkmgrRF2p4SUbED7ty0ymhNkpcF1MOmMv5Ek8YU9eJmDw45pw+5HCCEQt3lwCUuIOZ7YUHZjpLoxWXhb3XQJwCdUojiAQb77Ul8gChtMig=
Received: from MN0PR12MB5953.namprd12.prod.outlook.com (2603:10b6:208:37c::15)
 by CY5PR12MB6456.namprd12.prod.outlook.com (2603:10b6:930:34::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Wed, 4 Sep
 2024 17:19:49 +0000
Received: from MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c]) by MN0PR12MB5953.namprd12.prod.outlook.com
 ([fe80::6798:13c6:d7ba:e01c%5]) with mapi id 15.20.7918.024; Wed, 4 Sep 2024
 17:19:48 +0000
From: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>
To: Sean Anderson <sean.anderson@linux.dev>, "David S . Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, "netdev@vger.kernel.org"
	<netdev@vger.kernel.org>
CC: "Simek, Michal" <michal.simek@amd.com>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, Ariane Keller
	<ariane.keller@tik.ee.ethz.ch>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Andy
 Chiu <andy.chiu@sifive.com>
Subject: RE: [PATCH net] net: xilinx: axienet: Fix IRQ coalescing packet count
 overflow
Thread-Topic: [PATCH net] net: xilinx: axienet: Fix IRQ coalescing packet
 count overflow
Thread-Index: AQHa/itD5/rKF0Kmhkyj3WY/NO0ji7JH4Aeg
Date: Wed, 4 Sep 2024 17:19:48 +0000
Message-ID:
 <MN0PR12MB595374F39CB6F68958004A9DB79C2@MN0PR12MB5953.namprd12.prod.outlook.com>
References: <20240903180059.4134461-1-sean.anderson@linux.dev>
In-Reply-To: <20240903180059.4134461-1-sean.anderson@linux.dev>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: MN0PR12MB5953:EE_|CY5PR12MB6456:EE_
x-ms-office365-filtering-correlation-id: 07044735-9af6-4441-19b7-08dccd05c7bf
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230040|1800799024|366016|376014|7416014|38070700018;
x-microsoft-antispam-message-info:
 =?us-ascii?Q?by7CbQF/jk2KftCbevzQ1vrPMdmBc+m95jrTQRapdnZtIJ3sozaLPUb93gVl?=
 =?us-ascii?Q?YL0LvddWOzvP6rKI6H4o9DycmsMINUYJxtpeLAiqRuM8ytvw5TQZGO6G1K6P?=
 =?us-ascii?Q?Ci/LYNvbI2HOfFTLb8IvoOqke2ly87AFjhgTrFFUAUw3DGR/as/Uygf4ATjE?=
 =?us-ascii?Q?HIqWX/bJKFq/vvhgRBdfhwL63i8kqkK7ZbzTdFqK6+3OaMrXzHAqDu0TLPxf?=
 =?us-ascii?Q?FwojKfvkgINMn1jokOf+yx0jStEAqRuaPWldEO8NtD3Y/IrJElNhRAgKkTK3?=
 =?us-ascii?Q?r7ewwmR/tqnS9eaDsATz7z5Y+HQJE2TeNrifdqLJF4bLj6PSOfgFIE8glPIH?=
 =?us-ascii?Q?Wxa8GQG1wSVPVWGEkiJx2lhfrX4rnf731fDGouhm8LcyqCT45epHDd6XZADf?=
 =?us-ascii?Q?ZD3/gtooteWzplX4eVXyet1xIzufVD9ZXXrM4KPbGiLdSqdTKurYG1xtLGKn?=
 =?us-ascii?Q?/09H2zYKXK0OfYsHPcao+AB0GvKMqqbRXKVxFfHEV5ujq574kUAOVrRMdGzA?=
 =?us-ascii?Q?hXWFm5XuJHtwIlZWnKAwyo3YLDvcEOS3OC5Hone+cRPf+vcr1Fc+1LYc2uvd?=
 =?us-ascii?Q?4s+DddCG0jwj/VSJ+UTV8hyEdZx1YDc1I3upGIBDWI+3G3UQl0LlA8Oe3D3I?=
 =?us-ascii?Q?zBgJiQRVJkTXA0feXqVbvph27DyFDoJuI7Ad2/s6tHZWdaWGciIJjxoO3+bP?=
 =?us-ascii?Q?OVNqUcfNAWIhVJGxv6/j5xSpp2n/suFwA8Htz3Wnnf6vOzBq2qLN3QRB9AQJ?=
 =?us-ascii?Q?CX0m7p49HvmBi9rkbMBuoE6Tle070QHJO0Q4wuUV70CjAfo8gDasWrV11EF0?=
 =?us-ascii?Q?5AcNcURY02OHdx6LPCnDqX/mHPybdmaLxH1uZkj6rfsXWvtuJbjL76qkvkij?=
 =?us-ascii?Q?3TQpTvw8N4zgKLrOHcw2YmOFxp9DsBSR89FEgWNzqUlnnsQUEmwTNpQgpCZo?=
 =?us-ascii?Q?HBWuYlhheMapFPRgWPIuKiOLxp6d6ebkmwH91k8JQBV+cRpZkykKTxAq8T7F?=
 =?us-ascii?Q?JieB1nB/7IPZJykJ+LM1apmKWrDLdOl1xcLnQYFserUMwkxdTVNE0Ge4dbfJ?=
 =?us-ascii?Q?uiXkpChXjpc2LwIsPCBXis6P2606XwIKsOlsN7JGZHGDVIxDpTcdO1QDY/xV?=
 =?us-ascii?Q?FjHmAmEMpGvWfs51P/mulKNWWQZF6hkQZ2uJNgXZriYpz2WtwvzNzg+XsfPE?=
 =?us-ascii?Q?/ztVoGVUl3+zWOTdKrAjTNpUOGN1OudxoAtBQGB5foWTFHeHlnwLBQ9Nntz7?=
 =?us-ascii?Q?m23b+il7cH+NjtEz6r2wjPVu5DjZtmSjp0oR1ez0SFQWKGHBz+N4C/D31Zhs?=
 =?us-ascii?Q?yINmrjWCo2LEQLcipTzJzujedXQJ/ZIPhrAK+uZ3r+bBq1siaxH+VCyXIUoq?=
 =?us-ascii?Q?6x1gXpa8UfBK+0Cpo54gHffmhBgDK0qeFTlI77c9DbsJLFWQdw=3D=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR12MB5953.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014)(7416014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?us-ascii?Q?KOCg8OC+Zu+V+rSDP3OfhRaA5SPbXqffEiNOhTZIy681o4JAKs2NPelW6lLQ?=
 =?us-ascii?Q?42TTn6LodXcDHZdaSE/R/yl4EoHsXT4v946ttJ4bjCYVZuE9L7EAZIPH6/BL?=
 =?us-ascii?Q?jH7MQbTzAmY8zi+KPD7m2tJRnrMwj01AXwJTNhjTJywmc++wYCdNP0stKIdo?=
 =?us-ascii?Q?IwyM41WLyGgGZOa1KdNEcpsymIt/7P1gutOM0UMo1b1Rt+ypz1y+kmaP2Op3?=
 =?us-ascii?Q?nidhLN+ZMUE44na/9m4t8VmQHJkf5twL6U9uAPqRTux3mFmLePHC49AyXpwR?=
 =?us-ascii?Q?de/KIP89adZ6BYxGoLl3zf8+hL6ArMargFTUQFaXIfbl99gRh1DiRTOT27pe?=
 =?us-ascii?Q?BlbKYbYShv5NCRblHDdD6m77hBGoQtD4Rl6w7ZGEo+By7nf/EGtlmS71NpQb?=
 =?us-ascii?Q?pqv5msHyMkGvuQIkhpS5q7PIzq8zKU0B66jDD2KuzQt27xQ/DkPgQ3PmR5zt?=
 =?us-ascii?Q?NdKUGy/EtbFrcuuWeaE/vXfbsZmWMn4ZJ5hp1oboEhFlMlJBcPcySaSW2lrI?=
 =?us-ascii?Q?GSEfr/m5ob0O5aoMMRwRsUoiS2lKzdse8f1jDVD8Wrv2L84IvVG8NBMIzU+v?=
 =?us-ascii?Q?CKzmtnv8TbePPV6TNCirOdf/Tn7iNni06EYGL5PUClcdmcohX0bshQ+unsUF?=
 =?us-ascii?Q?zrKGJgAxLgpv0ejyZ7+c9mherkgqzJLAxXKJ/fYn+W6fD5zPJsBtvz2lH88/?=
 =?us-ascii?Q?0hN7NqNHe4OmFHN7BkHEHMf9lJMcDvKmvV2pYV1vZW4mr9QjQVHs9CiHFHGW?=
 =?us-ascii?Q?tnu+LL7Lxe7hbH6qxEeEpPdHuqlTTshysRZD4RDhOwVpgFAPE8GUAuR77vUz?=
 =?us-ascii?Q?0kiSgX6N6R8b4DYbeqMpW/LcTa/sZYeeJ5uirIa/+0QV6roAhT8DLN4eABc8?=
 =?us-ascii?Q?fnv7BdqomaufjqrjjeY8B8k45nIqbIy6CHOPwpkltxfY04f00JfU7sPF2KCW?=
 =?us-ascii?Q?zf3EUkU9EsvdNbOBHUTCK3VIezo1vlkk/+/C/+niaUMA5QrUDImUdJXb8b3u?=
 =?us-ascii?Q?ziDR7inPy84KC5QY4E2vKi1k0iiFW/HvCz6B5HP0hhID9JFcwaA0Uz9/Wl0B?=
 =?us-ascii?Q?XBl1QkZ7xX5JZXPBXrmSNLn4OrWagkAHt2oL8SRbwp5IV1wh8CaONQIOvyGo?=
 =?us-ascii?Q?XpLBTFAln6bQzgiRKJzlWD1H9iTNsePIcszD6n588kQUDZTUKX30j7sBtKK6?=
 =?us-ascii?Q?Y4rbPPu+pUjtw1bd38/5hFOLEvg90eRKz5O8jOHa1b3tdGly98yB+KtTKnFo?=
 =?us-ascii?Q?NTZN1sXy6DqqTo9fMYSIWK4kH7PlvcFac6bMFfbOSEifVfpnnCyCo2mx0eFk?=
 =?us-ascii?Q?rigB0GWpwHr3B3XcNFJWFmq0IC88RdlI0KOZfb8IYxWYXdJ+YGYHH6R1Ft2X?=
 =?us-ascii?Q?5eZhp6xpOaCqDKsZ6TUEqlwf8VWJkTvgnsjK0ixcogg4kw26TyFnqZEGN0RN?=
 =?us-ascii?Q?6R92k15GEoEXDFvBPlvYLV9WZirK6MBiPAKcOXthi/beGQGQPT/75gcy2AcF?=
 =?us-ascii?Q?WrJCUtHENbH4p/hbCbhpuBYtqQiK3BoT5xKerxzQFzhkbhxVW7WvdhtcoU7F?=
 =?us-ascii?Q?KhKt3/oCwCFix9g7L2I=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MN0PR12MB5953.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 07044735-9af6-4441-19b7-08dccd05c7bf
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Sep 2024 17:19:48.9030
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: n1t+bdeADbAQ7eZ7Xd5Q0mtlJNQ/fFTzlB38peXOGw/A737rxmdDs2zhPcZRRQeH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6456

> -----Original Message-----
> From: Sean Anderson <sean.anderson@linux.dev>
> Sent: Tuesday, September 3, 2024 11:31 PM
> To: Pandey, Radhey Shyam <radhey.shyam.pandey@amd.com>; David S .
> Miller <davem@davemloft.net>; Eric Dumazet <edumazet@google.com>;
> Jakub Kicinski <kuba@kernel.org>; Paolo Abeni <pabeni@redhat.com>;
> netdev@vger.kernel.org
> Cc: Simek, Michal <michal.simek@amd.com>; linux-arm-
> kernel@lists.infradead.org; Ariane Keller <ariane.keller@tik.ee.ethz.ch>;
> linux-kernel@vger.kernel.org; Daniel Borkmann <daniel@iogearbox.net>;
> Andy Chiu <andy.chiu@sifive.com>; Sean Anderson
> <sean.anderson@linux.dev>
> Subject: [PATCH net] net: xilinx: axienet: Fix IRQ coalescing packet coun=
t
> overflow
>=20
> If coalesce_count is greater than 255 it will not fit in the register and
> will overflow. Clamp it to 255 for more-predictable results.
>=20
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>
> Fixes: 8a3b7a252dca ("drivers/net/ethernet/xilinx: added Xilinx AXI Ether=
net
> driver")
> ---
>=20
>  drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> index 9aeb7b9f3ae4..5f27fc1c4375 100644
> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
> @@ -252,7 +252,8 @@ static u32 axienet_usec_to_timer(struct axienet_local
> *lp, u32 coalesce_usec)
>  static void axienet_dma_start(struct axienet_local *lp)
>  {
>  	/* Start updating the Rx channel control register */
> -	lp->rx_dma_cr =3D (lp->coalesce_count_rx <<
> XAXIDMA_COALESCE_SHIFT) |
> +	lp->rx_dma_cr =3D (min(lp->coalesce_count_rx, 255) <<
> +			 XAXIDMA_COALESCE_SHIFT) |
>  			XAXIDMA_IRQ_IOC_MASK |

Instead of every time clamping coalesce_count_rx on read I think better=20
to do it place where it set in axienet_ethtools_set_coalesce()? It would
also represent the coalesce count state that is reported by get_coalesce()
and same is being used in programming.


> XAXIDMA_IRQ_ERROR_MASK;
>  	/* Only set interrupt delay timer if not generating an interrupt on
>  	 * the first RX packet. Otherwise leave at 0 to disable delay interrupt=
.
> @@ -264,7 +265,8 @@ static void axienet_dma_start(struct axienet_local
> *lp)
>  	axienet_dma_out32(lp, XAXIDMA_RX_CR_OFFSET, lp->rx_dma_cr);
>=20
>  	/* Start updating the Tx channel control register */
> -	lp->tx_dma_cr =3D (lp->coalesce_count_tx <<
> XAXIDMA_COALESCE_SHIFT) |
> +	lp->tx_dma_cr =3D (min(lp->coalesce_count_tx, 255) <<
> +			 XAXIDMA_COALESCE_SHIFT) |
>  			XAXIDMA_IRQ_IOC_MASK |
> XAXIDMA_IRQ_ERROR_MASK;
>  	/* Only set interrupt delay timer if not generating an interrupt on
>  	 * the first TX packet. Otherwise leave at 0 to disable delay interrupt=
.
> --
> 2.35.1.1320.gc452695387.dirty



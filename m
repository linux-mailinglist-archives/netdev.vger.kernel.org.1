Return-Path: <netdev+bounces-96027-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B678C40AA
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 14:25:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 046AD1C22C79
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 12:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8197A14F133;
	Mon, 13 May 2024 12:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="frN0szYk"
X-Original-To: netdev@vger.kernel.org
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2047.outbound.protection.outlook.com [40.107.21.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BA8B14F12E;
	Mon, 13 May 2024 12:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715603099; cv=fail; b=UHP7MyBR1LICwiAIhcrBCmGvHg2EBcR6WJ6xMequnsgM2ZTDZKApJpMZxwtDbB5BdcIYEJFJMVyfEsKLBIUQJnlNzoaEIpvPWqS/SSvWMd+bQt10PafiKCZk6FbgoxGs6TV1Z1j4DNT/02VRG8WuPV0oSJUctPFEXi6KeKZrbig=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715603099; c=relaxed/simple;
	bh=ay9f4t7N4PQ58t/7erElnWry+IUpmPBRZhAFXPWxw90=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AMx6C+GjAOPs91KuGQmbKkWroQO83XBK9fi7NxTfUHrOt71wzBfjyex0+7H2smugz/moiWedMtvLcI99mVPOHSTYV2Xk3h6cFyObBfRSldWpjVkY6Ubm3OCmmDD0QYsJe68QWzsk1LvNjHheCnphdn8poomR+7Yu/DZ/qy5VrBU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=frN0szYk; arc=fail smtp.client-ip=40.107.21.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FCB2UJEDhZ7zmx3k0W/v89vk4p7nv7Ok3+BOOd+4ZxfWzc63H9wK3TpsCEKQlwC6c7nUSh181P+kMhj2V/BS+d3g0Gl79b49H+nRxA5TykY1Iyg1aIcLBIozZxZmeLGBZn+fbGcA6BLBEXBISqSfkSte37phqd8xFC2UxXS3uuuXD+KAavUyH37Cvu7rFtJHZs2GGMsruXWrcE60vMmVyZmHqlp9FNauLrmgqY9wuRczUoxmLHsBFB9Y+09dpMbb6GtExWV6wENhgNJCQJ2kepm9NmBuC/gcra9fPJ9o7YLISDWz1qROe2hyZZsd868OgJfZJjsLtcEWLSAb5Ba4og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ay9f4t7N4PQ58t/7erElnWry+IUpmPBRZhAFXPWxw90=;
 b=FiX+GlLyW/ZIqSO9JwBNHHGyiBxZse1QDfcxoqUrKuCEBdkcQi3QDa7NkzZ4R9WhOlWrr2ffEO80Ck8lmaxsTrlZETVXl+dy6Qc5t8brEkYMsd2II6vnr3OYPXQyWo51chDAcuLVa+P96Wc/vGsEGug2uUu3bPGfL73XIuYuourzQnhEDa6xpNs8FbPgZAA22oY+WyDbYUPIZJ9s7FxT3E/e8rRoOisnm1WCBf4xeCQBx9wBB3OABb9pkIA+9CEwTT/26AECrStOMWT57riLGyhWiMbyYVXPohigJuORAi06rDYOivY67uLpNoNHEOfFGZnLjRaxSQXI8YsQ2zOoGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ay9f4t7N4PQ58t/7erElnWry+IUpmPBRZhAFXPWxw90=;
 b=frN0szYkn5J39VNo84exkhLxOIlGqeTOHcVwCL2Hio+E01VTXF+iGbgN3Z+oF3Tcwg1dS6YoGMZC1Yzk7o8xEGlF1bncDslCoUCKUHBjci7mxfc/XKgRP6vkfFZ/2+iOszmPuRoG3ReQFE40RFRJp73UAsy/2my3Bq3IFDUx4U0=
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com (2603:10a6:102:211::7)
 by AM0PR04MB6771.eurprd04.prod.outlook.com (2603:10a6:208:18d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.55; Mon, 13 May
 2024 12:24:49 +0000
Received: from PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::baed:1f6d:59b4:957]) by PAXPR04MB8510.eurprd04.prod.outlook.com
 ([fe80::baed:1f6d:59b4:957%5]) with mapi id 15.20.7544.052; Mon, 13 May 2024
 12:24:49 +0000
From: Wei Fang <wei.fang@nxp.com>
To: Hariprasad Kelam <hkelam@marvell.com>, "davem@davemloft.net"
	<davem@davemloft.net>, "edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
	Shenwei Wang <shenwei.wang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	"richardcochran@gmail.com" <richardcochran@gmail.com>, "andrew@lunn.ch"
	<andrew@lunn.ch>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: RE: [PATCH net] net: fec: avoid lock evasion when reading pps_enable
Thread-Topic: [PATCH net] net: fec: avoid lock evasion when reading pps_enable
Thread-Index: AQHapNmrkXK8ZZdjQEWnp7p3Tpjf6LGU5dKAgAAvzyA=
Date: Mon, 13 May 2024 12:24:49 +0000
Message-ID:
 <PAXPR04MB851010A6DBA52A04DA104E1C88E22@PAXPR04MB8510.eurprd04.prod.outlook.com>
References: <20240513015127.961360-1-wei.fang@nxp.com>
 <PH0PR18MB4474D5050F6CBA0B2D4A6041DEE22@PH0PR18MB4474.namprd18.prod.outlook.com>
In-Reply-To:
 <PH0PR18MB4474D5050F6CBA0B2D4A6041DEE22@PH0PR18MB4474.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAXPR04MB8510:EE_|AM0PR04MB6771:EE_
x-ms-office365-filtering-correlation-id: 6ed486d2-481e-4874-a1f9-08dc7347af00
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam:
 BCL:0;ARA:13230031|366007|1800799015|7416005|376005|921011|38070700009;
x-microsoft-antispam-message-info:
 =?gb2312?B?b1dRS0dxMmtyMUIvbU4rb28zS2NxWFpNU1F6ZXAxcW9IYU0yY0NtZWVTREhw?=
 =?gb2312?B?L3NRRzMvaEtXU1VOWVNGU2pyYmFPMm9uUzFwdjBINW5YaWRoUzRSYkhVTHhE?=
 =?gb2312?B?N0tnSmRpMmVlaldydEhobExJa0docWhoUnk3MjdvdnRqa3RPa0x3d25Fbm9y?=
 =?gb2312?B?U2JISlNtV2NUdTZDaEhWOElZMHY5bjNuZ2hnTy9NZFFpMjRKRnFNNWZnempQ?=
 =?gb2312?B?bjZzMTNkMVQrVzlBOHdYRHFuRWN1M1FIaGNFZHd3T2ZseGlxODRNZUNESUt0?=
 =?gb2312?B?U2lWMXpndDRablBlSHlkeXp4SjhKTWZBSWRINksvYk1PeHVyN28yMW41MXhN?=
 =?gb2312?B?RXhzODlGU2FMeWxCZ0hBcVF0Vy9UQ2pSV0MrVVc4K0E1c0ZKUXVqazhmQ3hS?=
 =?gb2312?B?Nm9hQzhDOXY0NUh1aDJxSytrbFRtZ3NTU0J0NTgxUjJHbGFMY1pabGkzTjY5?=
 =?gb2312?B?dExTdFBwcEZVdGRaSitYSGtYdUlaYWcvbE1MdTFwOStna1F1MzRIYXRqcllh?=
 =?gb2312?B?UEE5NWhucThQbTRJNmhKK2IyR1J4MElHa2ExTDBzbm10di9pNGxIWkNTTUda?=
 =?gb2312?B?aFRxV2pQc1FIOGZQTEtLWTNhS1hQc3dDdW0xdE8wWkJ1RjY0NFBGNTZ1N3lv?=
 =?gb2312?B?Z1k2LzlsaitwbkJ2eEFsRFFoMWFwU0dzL0lGb0dDRDY5dDJTaVNaOElTZ1dC?=
 =?gb2312?B?VnhhcWREMjVYdHB1c21QaGNxNnpvSjRTaUYrOVhEUzdvdHdhQUc4SVpuSndi?=
 =?gb2312?B?YUc2ZDZqYmpPaTBRSDc0ODF1WGpmTUl6c0pMcTlXaXJTZkRYTVRlTDR1K3hC?=
 =?gb2312?B?TW9NZUtLQ3dMdzBKMHRybWhhY25pS2xQVWhMaVIxN2hqemhsMjlTL3Q4MERK?=
 =?gb2312?B?SEdUYnhhZHp2UXlxcjNYQVhHWHZmdEVMcG9qSlp3eFRjelhGQWF5bno4SjN5?=
 =?gb2312?B?MFArajBvSDhqc01UbU1UV2R0UkhaK1VCMXBjaWUvU2tRNDBUVWp5OGc5Tk0y?=
 =?gb2312?B?SVlwTG9TMStwQVhYdU1SR2pSR3hZZUVsT2dkODVva1lSN002cWFnYm01VnRs?=
 =?gb2312?B?cFZCeWl3eGx1U0hDU3BTeTJYQnNOYU45ZGFYN1YrcDhnT0NhZExMWFRzcHdU?=
 =?gb2312?B?by9pcUJGOVZZaDZnWXFFVmpjYUZXS3RIVWM1Q0J4U0FlbnNlbHRhZlpuNVRs?=
 =?gb2312?B?TTlFV1RFZlM1MGc4dXJQS3hubWxmZ1dXaXQwK2UzWi9xSjE3S3c0OE03bXRB?=
 =?gb2312?B?M1lYc3BINVRxNGtpbnZ5aWJ6Wm1wcGxIT3dXMHVLNVdwUGUwOU9ZTGdPMGc1?=
 =?gb2312?B?RDRyR2Nqa0o0d1NmNEsvbXIxZ205eDVjT3pta2MvUTBITVpwVG14QitlY1I0?=
 =?gb2312?B?Q1FPc0hrN0JYUm1FczRuYll0TXBBajNhYVF5czNaam5IMFFLQ3o3VDdlWUdN?=
 =?gb2312?B?ZDE2K1l2b202TDk5U0FaWXZDa3VpTnJmOFdpbHhMUGpMNmt1Q1BNUkdCQWNt?=
 =?gb2312?B?QkVhRnlQcnE5akVzQ29RKy9ubDdoY2d0cFFDUU9lK0hSdkJQQmZoUFR6ajkr?=
 =?gb2312?B?Q0R3eXU5YjhLYjBxaUVwZDNsNWltRUUrbmRXTG8xWCtLek82QWhnbXFRU3Fq?=
 =?gb2312?B?cVlPRFU1eWwrMmNNUkJyT3dzV1Nla3BLK2d6bVlJaXU4YnNlUWMxbE1ycWxy?=
 =?gb2312?B?UVNLZmRqY3h2bGFBRllOMGJyQmtROXV3MlJjeUdpUzNZVGZycE81NG9iaDNF?=
 =?gb2312?B?S1YySkN2emdMTzlrcEFzWTdpM2FhS2ptN01hdkhiQjdzSWw0MXFqM1hhS2Jq?=
 =?gb2312?Q?aowJbIiv0hRhX2NKYT3KvRwtO/3iwyzbL+WUI=3D?=
x-forefront-antispam-report:
 CIP:255.255.255.255;CTRY:;LANG:zh-cn;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB8510.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005)(921011)(38070700009);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0:
 =?gb2312?B?VEFJUS8veWZ2VTBkaGc5Q1grV2ZQeDkxaXVBSi9WbVc0RUNmWldTb3FLMFk5?=
 =?gb2312?B?ZzdWV0Y1ZlAzRGk5UnlsZjIzWEVaWWVkTnpoUDNHNllpcXEwcis3Q0NOYkM4?=
 =?gb2312?B?RlZTK0trL1VUY1U4eldBUDFJcW9hUjU3TSsyU0RmakNXQUdldFFrL3R5NS9u?=
 =?gb2312?B?NlBuTlJWWHBrT0JVTEk4Qkk4a3A2ekdmeWZVaUV1OUhHMUlQRktvbVVKbGFO?=
 =?gb2312?B?bGlDM21wQzN4dmxlYWFISWpBTnM4dCtCTStnUkVLa241TG5zQ2hOWitIbDRq?=
 =?gb2312?B?SlRtZjFRa3Nhd0NQTW5EL0lpNTBPTmE3RXR5MW5DSE43RzhmaFdXcE10QzYx?=
 =?gb2312?B?akNMZXV0cFdPZHRkU1BHRVVnK3dVdE4wMDhCa0VreW0zWkxOQ1J6V09vZWxS?=
 =?gb2312?B?L2ZEcnhmejV6VzdVbWl1a2FlRlJpTHR6L3dBalNDVWhBMHN1dU9NeW5heTZO?=
 =?gb2312?B?YzlkdlJlQzM4eVJ2QndMbUpuWnZraUpsdGtNY0I2aWdGK0luNllUWlpCaUt6?=
 =?gb2312?B?MjI3ZWFURlZXYkxFakhXWWJhNXVmZkhQOXg5a0lEdkV4Rkp6aURNUStpSVp3?=
 =?gb2312?B?UWFTeFIvVTZXSWZ4TTBqUHBCSjRWNSs2a2I3em1JZDJ4Q3B1cDNHUW83UGQy?=
 =?gb2312?B?QURjakpsZ0I4Um42MkkxQThDSGNsTlZCUFYyeWZZM3Q5SVovaG5VbjVoU29B?=
 =?gb2312?B?VDRmR2Yzc05KbEUwTEw3ZnV3RFNxdnNDR29MOGR5YWFWU1M5c0NBZkFkUlo5?=
 =?gb2312?B?ZG91TUJBdHJVdkFlTGJwRWNMa3F4MENPSlo3WllWbjlMUGgwTDdwWm9MK2sx?=
 =?gb2312?B?MmpaQzd5NHZTcXBlVzVHOFgwWDVJbEFtNXJxTUJRU2FKK2JQR2FMM0w0dFk0?=
 =?gb2312?B?KzQ4c0MrRTRxWG1PdlNKWUdWMmhpTTJkMnJiT3hNSy9LbVpyM3picWlxNGxu?=
 =?gb2312?B?eDlORXI4aEFET3dyVGRpeGd5aVZJUGxCdWNKKzR2TVl2SUo1cG5JcFVoUElj?=
 =?gb2312?B?bWdmOEZsMklpUXl2S01Mb2RPUFBBWW9BQ3kwM01NQ2IxVThSWGlnQ2xmWXAw?=
 =?gb2312?B?cGFaRGlBc0dGN0d5cUtSb0Z4S2JYMHZ4dVpFUmtaVEtyK09WU0k0QkJpWTI5?=
 =?gb2312?B?TVBZWXdVaUVLUHNQa2F5c0tscUZOa04xaTV4em80NEhBRm9nNzFaenVKK3dS?=
 =?gb2312?B?d09zbzMzNmdTMkkzcVgvZHB5SVpWQ1ZhOGd0RHk4aEJhbDB4TjlDYW43Y0VW?=
 =?gb2312?B?VU45RUFYS3dwQjh5VC9UQVJXejU0VENPeCt4cmJZbGs4ais3ZU5zTVRHcUdF?=
 =?gb2312?B?RlM5dUVIRHdPN1FaME1Uck82VXF1TFlqM1NKbmhQT1J6VUZxL2VXZ1ZMbDBu?=
 =?gb2312?B?Q01jZTQrcVJqT1R1ZnlacHA5L2RCUys4ZnNlSWttUGZrS285WlhzVVkzRGF4?=
 =?gb2312?B?TjkxNGRLT2ZFZDBsaUIwSHkvSlhMRkF5UmZrUTZheStkUkRCTWRVWFkwY05P?=
 =?gb2312?B?blRjRTArLzJOTVJBdVVJTjluMm9KMCtHcllUR21QQ095MDd4SG9uaWJJQXFp?=
 =?gb2312?B?UDBjeWdWYlZuK2M5NFlWTTRicDBveDdUdk11V3NMR1k5bThmVTJRMzg1RWJD?=
 =?gb2312?B?SXN5c0xLOW9qMGRJcS9WdzFIRWEwNmZNSE5CYU9wemtvTDRTZ25FMTlGRDBl?=
 =?gb2312?B?RS8zRzJnQ0wxV3JyTGExb2tYQVlKdVgrMmlQcnF0U0ZidDE1WXN4cUtDeUFM?=
 =?gb2312?B?V3dzZzR5OVRNSFg2czB0YVp0WWpqYzVWOXdLOVVpQVlrbHhVZnpoSDZmdWpi?=
 =?gb2312?B?QmVMTE5yRHRuczFOREFkSU42QU5vRzdrTWI0VlpxQnVuYlhBSVdRVElWZlE5?=
 =?gb2312?B?WGFWWjN0ZStmMlRBYlFsUXZJejd4M25TWUgyajNjMDc3emhNQUp1eEpTVER0?=
 =?gb2312?B?M3NBMFpnWG9tTDlBQUZzTlE0TXlvbHBwemZlV0YvVE5rTkY2eEpFbDIzcFFE?=
 =?gb2312?B?ZHk0WG13OHZ3NWlCRFBrSnNlTU9xNGpzZExJL3A0QitMSWl0R001c2tJN2xh?=
 =?gb2312?B?cVhSYk42WUpyMlpoUUpMR1NXZGFqSVJSeVovRGVsMVUydWxiRmxFNlVQN3px?=
 =?gb2312?Q?3pdY=3D?=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8510.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ed486d2-481e-4874-a1f9-08dc7347af00
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 May 2024 12:24:49.5251
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WH+os4djnRR/TVsQoHOiJwSPvcR+pOcvWGXCsp7OBGST84woCLhgIvC8cI/RnBd5JyTJ3E9/zFIWy3w0cpNR5w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6771

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBIYXJpcHJhc2FkIEtlbGFtIDxo
a2VsYW1AbWFydmVsbC5jb20+DQo+IFNlbnQ6IDIwMjTE6jXUwjEzyNUgMTc6MjcNCj4gVG86IFdl
aSBGYW5nIDx3ZWkuZmFuZ0BueHAuY29tPjsgZGF2ZW1AZGF2ZW1sb2Z0Lm5ldDsNCj4gZWR1bWF6
ZXRAZ29vZ2xlLmNvbTsga3ViYUBrZXJuZWwub3JnOyBwYWJlbmlAcmVkaGF0LmNvbTsgU2hlbndl
aQ0KPiBXYW5nIDxzaGVud2VpLndhbmdAbnhwLmNvbT47IENsYXJrIFdhbmcgPHhpYW9uaW5nLndh
bmdAbnhwLmNvbT47DQo+IHJpY2hhcmRjb2NocmFuQGdtYWlsLmNvbTsgYW5kcmV3QGx1bm4uY2g7
IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5v
cmc7IGlteEBsaXN0cy5saW51eC5kZXYNCj4gU3ViamVjdDogW1BBVENIIG5ldF0gbmV0OiBmZWM6
IGF2b2lkIGxvY2sgZXZhc2lvbiB3aGVuIHJlYWRpbmcgcHBzX2VuYWJsZQ0KPiANCj4gU2VlIGlu
bGluZSwNCj4gDQo+ID4gVGhlIGFzc2lnbm1lbnQgb2YgcHBzX2VuYWJsZSBpcyBwcm90ZWN0ZWQg
YnkgdG1yZWdfbG9jaywgYnV0IHRoZSByZWFkDQo+ID4gb3BlcmF0aW9uIG9mIHBwc19lbmFibGUg
aXMgbm90LiBTbyB0aGUgQ292ZXJpdHkgdG9vbCByZXBvcnRzIGEgbG9jaw0KPiA+IGV2YXNpb24g
d2FybmluZyB3aGljaCBtYXkgY2F1c2UgZGF0YSByYWNlIHRvIG9jY3VyIHdoZW4gcnVubmluZyBp
biBhDQo+ID4gbXVsdGl0aHJlYWQgZW52aXJvbm1lbnQuIEFsdGhvdWdoIHRoaXMgaXNzdWUgaXMg
YWxtb3N0IGltcG9zc2libGUgdG8NCj4gPiBvY2N1ciwgd2UnZCBiZXR0ZXIgZml4IGl0LCBhdCBs
ZWFzdCBpdCBzZWVtcyBtb3JlIGxvZ2ljYWxseQ0KPiA+IHJlYXNvbmFibGUsIGFuZCBpdCBhbHNv
IHByZXZlbnRzIENvdmVyaXR5IGZyb20gY29udGludWluZyB0byBpc3N1ZSB3YXJuaW5ncy4NCj4g
Pg0KPiA+IEZpeGVzOiAyNzhkMjQwNDc4OTEgKCJuZXQ6IGZlYzogcHRwOiBFbmFibGUgUFBTIG91
dHB1dCBiYXNlZCBvbiBwdHANCj4gPiBjbG9jayIpDQo+ID4gU2lnbmVkLW9mZi1ieTogV2VpIEZh
bmcgPHdlaS5mYW5nQG54cC5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L2V0aGVybmV0
L2ZyZWVzY2FsZS9mZWNfcHRwLmMgfCA4ICsrKysrLS0tDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1
IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9uZXQvZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19wdHAuYw0KPiA+IGIvZHJpdmVycy9uZXQv
ZXRoZXJuZXQvZnJlZXNjYWxlL2ZlY19wdHAuYw0KPiA+IGluZGV4IDE4MWQ5YmZiZWUyMi4uOGQz
NzI3NGEzZmIwIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvbmV0L2V0aGVybmV0L2ZyZWVzY2Fs
ZS9mZWNfcHRwLmMNCj4gPiArKysgYi9kcml2ZXJzL25ldC9ldGhlcm5ldC9mcmVlc2NhbGUvZmVj
X3B0cC5jDQo+ID4gQEAgLTEwNCwxNCArMTA0LDE2IEBAIHN0YXRpYyBpbnQgZmVjX3B0cF9lbmFi
bGVfcHBzKHN0cnVjdA0KPiA+IGZlY19lbmV0X3ByaXZhdGUgKmZlcCwgdWludCBlbmFibGUpDQo+
ID4gIAlzdHJ1Y3QgdGltZXNwZWM2NCB0czsNCj4gPiAgCXU2NCBuczsNCj4gPg0KPiA+IC0JaWYg
KGZlcC0+cHBzX2VuYWJsZSA9PSBlbmFibGUpDQo+ID4gLQkJcmV0dXJuIDA7DQo+ID4gLQ0KPiA+
ICAJZmVwLT5wcHNfY2hhbm5lbCA9IERFRkFVTFRfUFBTX0NIQU5ORUw7DQo+ID4gIAlmZXAtPnJl
bG9hZF9wZXJpb2QgPSBQUFNfT1VQVVRfUkVMT0FEX1BFUklPRDsNCj4gPg0KPiA+ICAJc3Bpbl9s
b2NrX2lycXNhdmUoJmZlcC0+dG1yZWdfbG9jaywgZmxhZ3MpOw0KPiA+DQo+ID4gKwlpZiAoZmVw
LT5wcHNfZW5hYmxlID09IGVuYWJsZSkgew0KPiANCj4gQ2FuIHdlIGF0b21pY19zZXQvZ2V0IGlu
c3RlYWQgb2Ygc3Bpbl9sb2NrIGhlcmUuDQo+IA0KSSdtIGFmcmFpZCB0aGF0IGNhbm5vdCBlbGlt
aW5hdGUgdGhlIGxvY2sgZXZhc2lvbiB3YXJuaW5nLCBiZWNhdXNlDQppdCdzIHN0aWxsIHBvc3Np
YmxlIHRoYXQgbXVsdGl0aHJlYWRzIHRha2UgdGhlIGZhbHNlIGJyYW5jaCBvZg0KImlmIChmZXAt
PnBwc19lbmFibGUgPT0gZW5hYmxlKSIgYmVmb3JlIHBwc19lbmFibGUgaXMgdXBkYXRlZC4NCg0K
DQo+IFRoYW5rcywNCj4gSGFyaXByYXNhZCBrDQo+ID4gKwkJc3Bpbl91bmxvY2tfaXJxcmVzdG9y
ZSgmZmVwLT50bXJlZ19sb2NrLCBmbGFncyk7DQo+ID4gKwkJcmV0dXJuIDA7DQo+ID4gKwl9DQo+
ID4gKw0KPiA+ICAJaWYgKGVuYWJsZSkgew0KPiA+ICAJCS8qIGNsZWFyIGNhcHR1cmUgb3Igb3V0
cHV0IGNvbXBhcmUgaW50ZXJydXB0IHN0YXR1cyBpZiBoYXZlLg0KPiA+ICAJCSAqLw0KPiA+IC0t
DQo+ID4gMi4zNC4xDQo+ID4NCg0K


Return-Path: <netdev+bounces-217202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2ED50B37BBD
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 09:31:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B40D7C19AE
	for <lists+netdev@lfdr.de>; Wed, 27 Aug 2025 07:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 967BE317712;
	Wed, 27 Aug 2025 07:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b="CySMD543"
X-Original-To: netdev@vger.kernel.org
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013006.outbound.protection.outlook.com [52.101.83.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62E201B425C;
	Wed, 27 Aug 2025 07:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.6
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756279889; cv=fail; b=HiAMyHh9uEuWazVBBR1vOJGOdqbLFTfTl2DCPzKO8M5pevIf71yToK2jZNX4tdzuk2WDmpJd4J3DNDtQavmHq7Pg3aLyJG0yiohHOp4v+t1GFI4M0JOGjO+G6QT3KeDHUC8BH1dFgwji+SAYZqWw7rtOoJlyQFZs9OvnwBQs9gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756279889; c=relaxed/simple;
	bh=6N/EkzZZKzIGwTTxki9KjZc50i2hBuhYLPR2smmJX9I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ciYFBdhQxzf4acnZCS9Pq0OtFmMfz0MlFgYUqD6uY33Cswoh0xviaMLuuftod5QrQ8Eg3wAkneeE/9gAgFl5Q16OkELML8/yGWenQJRQkTI3bkyWknHR4KJ580tConfdKk9b/pSWTKFgDSUYL067Y1F+K3XhfgcbXY+/mFKLd20=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (2048-bit key) header.d=nxp.com header.i=@nxp.com header.b=CySMD543; arc=fail smtp.client-ip=52.101.83.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hpOdRhedbaH4Ym7cct3CPZFV3sT0AyIBztJNiv6pegMR+vU/HIPN/mc218+35UdY72bcs5H9dhQUTAN0Co4NoKN7Mgio/OzMlkH/uEMGYqmDgqVoAsBn9lyJ6qF8Mm4bhRolPC8f0ennJ2GqikpGqpzwjXNgEEV0bC5UWnrkNHLOLf2MgQ17hHKT91tvUX0dBc8pfOclvJrW224VPMUdFg7NJRn3vWFAy+UN/5gWL0jPi7y2+JoUepcG+WtDcNC3JoXgExFO8tkdI4SAlMNUy+Qb5wyCG9Y8oDerpJW7BHe9b6Ea5VN2PmRdueANlFHoHSVYn5W/4FPIcSfhQ36omw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3S0/sKaDI1Ye7t7MB5HMIUnOu0GXR2Gk6HPJ5wYolGU=;
 b=gKAjLmkgP0A96hkiUkxEMdoyIdgA0PQB0xkRG9qy8HxHZxx0h8XX3eP3jdbYTX4EErtVEJBrMDhyckmF9m4JMCVittJJ1LMaf5NRlpu72NDKgI0wPf4+MBbbqTnfWGta/DH5glua4l2GsUsNcOgsebNqJvn+BdPuvtuivNHWCFrfTZTqUB7r8uC6xRzVCF9TIlDRtZC65fKtcHXQHF/VoyNtXLLWzz5b8Rah+U2hMmTV2mOPngOZuohWY04ALiLOw+ZlUoaVgBWFsPC7oEAcAiDlXMUfPTqu+jnb5ir+C+JYm3YWJQbI9UrYVkWNCqPg3EyEv5JYthWFM4rrzL0nNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3S0/sKaDI1Ye7t7MB5HMIUnOu0GXR2Gk6HPJ5wYolGU=;
 b=CySMD5434r2rwV8WLl75YkHUP9faDXJjlSLe3PvgUOuw8J9J6IAud4vqgigng3gpuAGVel1TsQxb1/V/zNT5tbmLk5KRov9PxEUzY2O6wMCR3iojiZwTNwuvVXmIZVo/BywHNp44y3QybpSoWfvruWLm50ltevuYl9OL4VTe+4W446ODh+RB6l72XWJQyUZf/W1s1PsRgxxR3ShKXGGu69gDYX1SSnMUcAxYtljwObDxvPUP3hTqMrZsZm2zWRFaSXuVteFRmp9OFc1fUhkWIB5R/G0L1vVDpsoOZ8mEI2YSOLWMzjxSwy/bm3Yow7JfpCY+7N/G2H5NubxQuyGDYA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com (2603:10a6:20b:24b::14)
 by PA4PR04MB7661.eurprd04.prod.outlook.com (2603:10a6:102:e3::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.10; Wed, 27 Aug
 2025 07:31:23 +0000
Received: from AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2]) by AM8PR04MB7779.eurprd04.prod.outlook.com
 ([fe80::7417:d17f:8d97:44d2%7]) with mapi id 15.20.9073.010; Wed, 27 Aug 2025
 07:31:23 +0000
Date: Wed, 27 Aug 2025 10:31:20 +0300
From: Vladimir Oltean <vladimir.oltean@nxp.com>
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: "Russell King (Oracle)" <linux@armlinux.org.uk>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Aquantia PHY in OCSGMII mode?
Message-ID: <20250827073120.6i4wbuimecdplpha@skbuf>
References: <aJCvOHDUv8iVNXkb@FUE-ALEWI-WINX>
 <20250804134115.cf4vzzopf5yvglxk@skbuf>
 <aJDH56uXX9UVMZOf@FUE-ALEWI-WINX>
 <20250804160037.bqfb2cmwfay42zka@skbuf>
 <20250804160234.dp3mgvtigo3txxvc@skbuf>
 <aJG5/d8OgVPsXmvx@FUE-ALEWI-WINX>
 <20250805102056.qg3rbgr7gxjsl3jd@skbuf>
 <aJH8n0zheqB8tWzb@FUE-ALEWI-WINX>
 <20250806145856.kyxognjnm4fnh4m6@skbuf>
 <aK6eSEOGhKAcPzBq@FUE-ALEWI-WINX>
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aK6eSEOGhKAcPzBq@FUE-ALEWI-WINX>
X-ClientProxiedBy: VI1PR07CA0300.eurprd07.prod.outlook.com
 (2603:10a6:800:130::28) To AM8PR04MB7779.eurprd04.prod.outlook.com
 (2603:10a6:20b:24b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM8PR04MB7779:EE_|PA4PR04MB7661:EE_
X-MS-Office365-Filtering-Correlation-Id: 850ca494-9e1f-4e27-77cf-08dde53bb980
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|19092799006|376014|366016|7416014|1800799024|10070799003;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?RUxmeC9PZS9STUhYWTAyb3ZHUEVWeXg0ZkdIMEZ5eUx5RHVINWswWEgvUmZu?=
 =?utf-8?B?T0thdEpQZWNoSm1zUmtXZWtIWjZvTTRzOWwrUmlyeTVDSytMZmw2bmN0clMr?=
 =?utf-8?B?TUNFWTVQSDVBS25WL3BzVXpXWUJ4bW1CMmFNVXJsOUhwSDBxZG9VNlpueXNS?=
 =?utf-8?B?aVRpdFVUQ2RkRnh3VTJabG9RSGdNQ053ZlVpVkxnTnBRa2hEaWZrelZPYlJr?=
 =?utf-8?B?TlduREU5VVFORytqTUgzVnRJVXVQVDRKeFlHditPQy9VVkwxR0xpR3U0THN1?=
 =?utf-8?B?cFNJUzMyUGo1MlJ2Q3pHOWNEYUt4WEpNM2RrWGlETFJ1WnZBU1hLK1ZONWQ5?=
 =?utf-8?B?WlE2Ky9nY0c2YkFFd0RpTXNSeFB6OVRJWmo0RFdWMVJaVk42SUpoS0NUMTZt?=
 =?utf-8?B?WnZTc3lScTBxbnVVL01KYVlrRWJTWkptVWl6TGNibktnT2wvN0dPSUZQOTFE?=
 =?utf-8?B?azR6MUwrcVhGbWI3UjRoTFZvWG1CYkJSaCs1eURtU0FiVUZzdmx1K05hekIz?=
 =?utf-8?B?RkhGMUJOQXdSYTkzMVJlZXNHTFdvL3JqMVlrQWdpMmpObHgrR015R1R2eCs1?=
 =?utf-8?B?djhwR2lIZXQrT3VzVXlpaDRRNlIvVnYycElpa3l3UFgya0NhK1JJSjVJOGYr?=
 =?utf-8?B?NDJja1pxR0ZMcWdOT0lKZS9JNVpmYkRwS3lxSWFSZE5LVDhyQytoY2ZWRGNv?=
 =?utf-8?B?SUd6MEE2MzVMdFlYZnhidVFUQ1dBVUxWNWhRK25rS3NxbStSczU4SlplRy9h?=
 =?utf-8?B?cE11dFRWdHNtTUMzVC9OMUErL0NOR2F6NFhzbFdFbStqRnpuN3p6VFhDelBm?=
 =?utf-8?B?S3VHdDN2c0ZjdEorTUlHeUd2TlNLMDQxRlhYT1M5ZFpGNWVIblBNUVJCMWxy?=
 =?utf-8?B?MTRHMjhJL1Q3aStrK2Z0OXNWLzViSDRFMUxYbWxvbGhYMlI2b09rMjVoV0da?=
 =?utf-8?B?UTVpeXMxNjZVaXlFL2tBekRrcVlqYVlkUmEvbGtBVVd0MnY4VWxmYkdzYXJm?=
 =?utf-8?B?WGI0NzdSV1lqRnhHRXhEMTFPUTkydllxS2NoVXdUODZoNFpldTE2V2V0SU5R?=
 =?utf-8?B?V0x3TW5SSlh6dUhuUCtSaGRVRXZ4SnpmR2Z4Slk3YWFtRHhlWW9peTNyUkcz?=
 =?utf-8?B?b1hUdU5PUFJIL2RlR3R6TXZSaGcrMzRoc2RXWWNFaDJRckVDZnpKaUJPRXhF?=
 =?utf-8?B?QjMxemJxRE1DdWF4Mjk1ZG9MZWFEbUk2RnRFNkk0cUUrSnBLcVFvR1lnRzQ5?=
 =?utf-8?B?Z2VWeGNzdVlkUUhhMnBlVmsrTndQRWZjU1dHUUxRTE5vMmxOcnB5SitDcjlU?=
 =?utf-8?B?VXpxQ3hRL1hXbjlHaEhJTDBlUy9KeGlZVXZxYUk2ditzTFJqVW4wSTlTZTJC?=
 =?utf-8?B?clFWNW5CSEJmNEZDWmRTMS9NUjZOa1ZtdFRKZnY0cGo2UFJRZW9tbFNWTGRY?=
 =?utf-8?B?WG9Sajl1aXFjQit3L2Naa1JKUXFwT2gyMkcweHVXOTlBYTVzbGdrRFowSlhY?=
 =?utf-8?B?dTVKeVJzZXJWeGdOMWp4ODhZQWNiUmJWWTJhbi9vRDJybFc2QWV3L2N1NXor?=
 =?utf-8?B?djBaU1AzRVFnTHN5L0UwKzZ4akswOS80aWJHZ29lWEJodjZxcElLUmJHa1pF?=
 =?utf-8?B?UmMrTGNqYU53THpiN0tObkFqcjkwa05DQ3kzYlJFTm1McEhFUWgzVy9XSVZ5?=
 =?utf-8?B?QUxVZ1Frd2tKeEdYVkdlNks1dTFvRVEzeERKbkgzQlZXYm1QMENOMVlkY2lL?=
 =?utf-8?B?RTNTdHplS09UbUtKTnZ6N0ZHNXBQQnNPanp4YzBYcThMWlJaMWh4dFdsQmRT?=
 =?utf-8?B?ZFdpTFd6bDdLeVhSUEwzL3AzanhNb3l5YlR6UU5lVnVpbDNMTXNoVkUxZzRO?=
 =?utf-8?B?U0twZEFPWWZEN0pXS3hNejVPU3F4MDR6cEprSDNZSWhtYm9Kenp5ZHdsQ0dB?=
 =?utf-8?Q?ctOMPXf88Mg=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM8PR04MB7779.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(19092799006)(376014)(366016)(7416014)(1800799024)(10070799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZUJscjIvbnRGbDhLT3ZsS04yRzFhdlIwNUc2SGRLczlyaHdXMnBTZHV3b0w2?=
 =?utf-8?B?K2VCQjhlQXFrQ3ptSWVVZEFMODdVL2Z1TVI1QVJKdk4xQ1FDMnY5SzVuaFUv?=
 =?utf-8?B?ZThpZ3JVc05tVTBxRkVoVkxMS0M5WFNyU3RvTjFzOWNiSlBFeWYwRlplOTZC?=
 =?utf-8?B?Y2tYbndQQkwvUHdLK1lQamFjNERQNklNWjFLL1FsMUtjM3phTzQyWDFZNHB2?=
 =?utf-8?B?L08rYStYMTVFSjFVazV3TXMvSWRMTHZBbkx2dFlhVUdOY01GZWJuZVhiRFhB?=
 =?utf-8?B?RENVYWZ0R2dwK283TUdOcWdBWTFrNExCK3hlQ2h4dmRjcGtSbis0WEdsNHI2?=
 =?utf-8?B?OGwvSUk3UlpMeFljbW9FZnVuaUdYT1BtVU0yOGkrNTFnRDI1RmpUdXRKT3VY?=
 =?utf-8?B?OUk1bzhGem50OUVpTXpYOVZSUDZRaUtaUW9BSUtiRzRyNEJnY1V5dXB0MVla?=
 =?utf-8?B?WExQRWN5Uy9KVFJqK2lEWGJjVXV6VzhKaUJFdUFZNVBTeEtsT0x4YWlBMVUr?=
 =?utf-8?B?blAwQkY2bkxMNXBaeU9KM3pDWlZldkkwRmdNckNvWG44VThES3MvbmVXSENt?=
 =?utf-8?B?d0JnWHBnaTNxMGIvSU85M3krZW9xc2lXeVpOU3Z0dFdCYzVQZVgwbmEyUFhj?=
 =?utf-8?B?ZlVCenpQRVF4NHFFSEhjYWRQNjlFM0gxUHdrWE1ZUWY1eVJQWW1sK0M5NmxM?=
 =?utf-8?B?SUlyRkNtQ0FOY0hpS1N4WVljZSsxekg3RjJaTVlKL2R0aDUvOWJJWXVuRUc1?=
 =?utf-8?B?YkpDY0RtYW56VnBuZDVjZG1IWVBKVnMyTkFyLy9VaVNyNWg4ZHgrTEhJc0dL?=
 =?utf-8?B?Q3ZtamdVL3ZkbDl5YzZpbG43TEdnRmpWUExwSTJoZ1FLMHJ4UDVWeUFHV1hF?=
 =?utf-8?B?MFJOaDVBV1VhVEwwSGNqRFk0ZHY2b3VPdWxsaUFlMjE5c3lHdnM5cFJXVmpl?=
 =?utf-8?B?UVpJUmphSXV4c3l1cldoYTVaQm9ZbFduSjZwRExLTlc0OWVyeVNITzFMQkVk?=
 =?utf-8?B?eHZGTWRGcy9SRGxQZzJwNXF0ZUhJNFhKck5tUWNhZnpQSytXY2tUaGN4anRC?=
 =?utf-8?B?VWtZNHR2SElCUmJ6dHlwQjJBSmhPY1R0M1RvRFA3cFBwZDZMQWFIMGxSWVFp?=
 =?utf-8?B?ekpJWXpNZEdpQmx5ZDU2ZE1FSHgwdjRGUlFLTjJTcHJxdTlJMWFqcXBYMEll?=
 =?utf-8?B?UWlVbWtpS3pyOXV2WlNMc0dTYjJkVjVwUHZndzF5T2JhNHA4RFVNa1o0Sm9N?=
 =?utf-8?B?aFBxNzU2NDBQMFc0YzhWb1dDQUtLT2pwMzdqRW4vTWNoQzhwSmlYOEc2RUph?=
 =?utf-8?B?dVpGQVJYZHVkK045NVpoSmVDRkd6ZG96amoxVGpKc2dMSWxHclNFNndRelBQ?=
 =?utf-8?B?c2RlRkw5bE5IZllDc0hsbG5EWDNPaWZOcUNCMHlOcy9vbDRXUjVUT3dxVlh3?=
 =?utf-8?B?YWNQZlJ0SUpjYXVVVG5ZV0RtKzAraWNKSTBjZFpRVTdnN1hwUkpQVGFpYy9M?=
 =?utf-8?B?Vy9wZDNOTGdJd1NTWndOQjBIbkMwTVI2V1NDRE9MZjJmYWlnTnVBWnlJNTlr?=
 =?utf-8?B?Yy9zUEVSYlR3allYYUJ3K1ZNL0hjRStsQVVicVVPd2VXYkU0RDBZaHZ6VXpo?=
 =?utf-8?B?dHpobDRBcEdmWWZsTkxwWE41eUNFU1phUHUybzlrMXk5K0hDOEFESmdOV2Iw?=
 =?utf-8?B?bXRxVnM3UDF6dzRFaS9NMTIzY25wOVR5U2lubkxMcXNDRlBSeTRQVytZUWxQ?=
 =?utf-8?B?SGVUdFBhWlovNHZTQnZNOUk5L0FUSmVZVGtIMVc2aFljUmJTaCtlQkhyY3Z3?=
 =?utf-8?B?SzBrK283TlFscFRlQ1ZQUytiVk1jVk9Ud0xYaEtETEUrVFNMVUd2alVoSE5C?=
 =?utf-8?B?a21qMWZTS2Z0cjhDM3gzeE9qbWE2T0hNek9JSnVNMG1JQ0ZHdHZxUnBLZkJM?=
 =?utf-8?B?VVFmWHBDOXN2ditrWGpjY29HbFJmOTBQcEF0cWhqNWhheVovTmpxYXBFR1FS?=
 =?utf-8?B?bWZTWU1tQ0JFNThUSGdtZWJMRXRaWWYxY0xLYTdJWlkvZ21YdEV1MUdSNkVZ?=
 =?utf-8?B?elNWT2FmUHlsZkpkSnVyL3dZNFZIcnFKLzg4TXJmWUt6Zi9oUjluR1FLVnNR?=
 =?utf-8?B?MWhqdHlvMGJENU5JbW9yanQwQUJpUE1OYk5IVXJ4dGMzWWxmb1ZnRUpHWDNK?=
 =?utf-8?B?bmhLbndrNmNjcktFRXFuQUtObDB6RS82dTFKZW9wdmV2WDFTTElZbWh6Y3Ru?=
 =?utf-8?B?cFIydHVLNCttcGhBcWJDVndXSjZRPT0=?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 850ca494-9e1f-4e27-77cf-08dde53bb980
X-MS-Exchange-CrossTenant-AuthSource: AM8PR04MB7779.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 07:31:23.6148
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yebN5g7kpqxX3rpcT4bu87WJWM02Yz1eKcBEoekpDN3TW3ggjA8OzzE8xV6xygmF1K+i+TJ5efFPWZ77RTC9sA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7661

Hi Alexander,

On Wed, Aug 27, 2025 at 07:57:28AM +0200, Alexander Wilhelm wrote:
> Hi Vladimir,
> 
> One of our hardware engineers has looked into the issue with the 100M link and
> found the following: the Aquantia AQR115 always uses 2500BASE-X (GMII) on the
> host side. For both 1G and 100M operation, it enables pause rate adaptation.
> However, our MAC only applies rate adaptation for 1G links. For 100M, it uses a
> 10x symbol replication instead.
> 
> We’re exploring a workaround where the MAC is configured to believe it’s
> operating at 1G, so it continues using pause rate adaptation, since flow control

Why at 1G and not at 2.5G?

> is handled by the PHY. Given your deep expertise with Freescale MACs, I’d really
> value your opinion on whether this approach makes sense or if you’ve seen
> similar configurations before.
> 
> Best regards
> Alexander Wilhelm

To be crystal clear, are you talking about the T1023 FMan mEMAC as being
the one which at 100M uses 10x symbol replication? Because the AQR115
PHY also contains a MAC block inside - this is what provides the MACsec
and rate adaptation functionality.

And if so, I don't know _how_ can that be - in mainline there is no code
that would reconfigure the SerDes lane from 2500base-x to SGMII. These
use different baud rates, so the lane would need to be moved to a
different PLL which provides the required clock net. Or are you using a
different kernel code base where this logic exists?

Also, I don't understand _why_ would the FMan mEMAC change its protocol
from 2500base-x to SGMII. It certainly doesn't do that by itself.
Rate adaptation is handled by phylink (phylink_link_up() sets rx_pause
unconditionally to true when in RATE_MATCH_PAUSE mode), and the MAC
should be kept in the same configuration for different media-side speeds.

Could you print phy_modes(state->interface) in memac_mac_config(), as
well as phy_modes(interface), speed, duplex, tx_pause, rx_pause in
memac_link_up()? This is to confirm that the mEMAC configuration is
identical when the PHY links at 1G and 100M.


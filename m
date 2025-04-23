Return-Path: <netdev+bounces-185110-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 720C6A988D7
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 13:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A313916E295
	for <lists+netdev@lfdr.de>; Wed, 23 Apr 2025 11:48:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45EF01EDA35;
	Wed, 23 Apr 2025 11:48:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="LGhFRbdP"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2065.outbound.protection.outlook.com [40.107.223.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF0CFC08
	for <netdev@vger.kernel.org>; Wed, 23 Apr 2025 11:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745408890; cv=fail; b=tLVB+K593TpIzN+fHYLBaReCzX4rDTv3qNI1oAr6MHJ7mP4wtgtA2R5LEAxLVFExM2w37q0Iwg87NN1fk5QqLBeA2xUvtECXFWqY4V1nWmlv2HKdhQ+yRQ8VV/YyG6aei03UF+J3c+7bHLsRjdQIGGUkrKktKzDh1wztI521lYc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745408890; c=relaxed/simple;
	bh=yjfJEAfg2FCFgCXUCse9NDbQO8PW2EQCqUgvE8ic3Bk=;
	h=Message-ID:Date:Subject:From:To:Cc:References:In-Reply-To:
	 Content-Type:MIME-Version; b=AFfmv6dMFxxeAGdCcRE0VSAGsfDJbIdHfX2XKxqSAfKLB2DHTqYepIXal6h32GV1RFBapeaOdSRcNEfsvSOGf2TIRjsXWgRBrhypICnA0vTDJpSE+NV2aAeaSGANZcPiijha1zIsOQUIcsJy7txjku6YJhvW4znb9CYk1UmNY7k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=LGhFRbdP; arc=fail smtp.client-ip=40.107.223.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g5HxN/IYSPGSoLmiY37W69/WTqqFQk59tVT/1zq1oMa80tNhxDd+Wt0eW8nRi2SgmWfscsJ/rh1XWtTlK9edQ/y8ZxV0+F3DdhMLYQ2h6QZO3dLYzPRm2GLuUEmfS7+y75myEaWklnWucIoHvzIMXHRd5INuC3IclytZmIwWm84v2f46mgtzdRxSRHUFuT1+Z5TNKtsqOU3GWaHcebYVnVcMKhestDTUr14ZjiaLZM4urYpVIux+14+p7pwD2laU3FlsEFmfXwRYS0h5QvNBNL7xhHsGUQtgyz/t7pw38iak0Q7U4ON3k1K/2v+mz1zI4kTGVc7ik1D4NjsXABZK3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYPtB2iPKqLv1s2UZcghgatvFWA0Z19iXxgyPDeze/A=;
 b=CTC0Wa7wBQr5R2d0ototuMIpIr0gdRazQqf8VjvvfN7knrEBOosBRHXyPrpjViLtmsn2PNKhUWL7EpBJJOBwGp9+V7zI2OirrsCcOY5O3/oPGqoMoZjFpf7YEI3rjeIylgdm5VJAt5jegVN2w24obzFl/CqKtHzxXgkUnOMTHHlitjGU5LJXE66Jv6ZfDPSJLo+ar7Wu6l4C0/T8KXFsuP9VTXbgk9LaZuQ5BzOEDCHSyHhbeOLMKkDRAedY/gLtcWzCelD6xeGi4S6hKzsfxHfGPrTrChMDIGHxwlT0NqlFFYoAhAZ+Z0A0Zx1C1Yhg7E6xwu6ow0RfqySAIqRthg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYPtB2iPKqLv1s2UZcghgatvFWA0Z19iXxgyPDeze/A=;
 b=LGhFRbdPGlOOYvVy1whzBt9EAUC3J6VGW7MKm4K3OYDFbIjnPWf5hydfs3T9f7gKnUr2hay/i/+e6VaT+Z/hb78mlaXmcHVlAIiXd6TFfEP12QtZ0pmOLpB7yMcjUHWUc7FmC2hlbxOIemDr5KOsrim6/OoptPOoeaasKF4COk3/SuevFtduFIOvjrNcYMtEH6v/fOhDP+ahCaz03cJAsMrAf+CPemCuH+kLwajvwKVirNUHgfeO2k+7rsxuKAI437yUujrR3dF3+xpENe0ISy1JaVkkL1D+OfSJNmfbpWlhcCxLvTGuipFYfBEBXUvZM4SeujXovCz+XW09PpPN3A==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2847.namprd12.prod.outlook.com (2603:10b6:805:76::10)
 by BY5PR12MB4081.namprd12.prod.outlook.com (2603:10b6:a03:20e::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.23; Wed, 23 Apr
 2025 11:48:04 +0000
Received: from SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b]) by SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b%2]) with mapi id 15.20.8678.021; Wed, 23 Apr 2025
 11:48:04 +0000
Message-ID: <5ca349f4-dabe-48d4-8c52-1b02c7650104@nvidia.com>
Date: Wed, 23 Apr 2025 14:47:57 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net 2/3] net: Fix dev_net(dev) race in
 unregister_netdevice_notifier_dev_net().
From: Yael Chemla <ychemla@nvidia.com>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <6ce063ee-85cc-4930-839a-36b3155c9820@nvidia.com>
 <20250401220735.94909-1-kuniyu@amazon.com>
 <615fdc6d-0c8b-4f09-a03e-996410bd0a65@nvidia.com>
Content-Language: en-US
In-Reply-To: <615fdc6d-0c8b-4f09-a03e-996410bd0a65@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: TLZP290CA0001.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::14) To SN6PR12MB2847.namprd12.prod.outlook.com
 (2603:10b6:805:76::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2847:EE_|BY5PR12MB4081:EE_
X-MS-Office365-Filtering-Correlation-Id: df64fd2a-a4be-4454-0d62-08dd825cb4c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?VG9FYnVYbWhCZTlWMks5TmR4RGk3VEVkcEJmSkZ3T2J3YnkvZXhVM0pLcDMz?=
 =?utf-8?B?aXB3cUJQbFlxWUdFWUhxd2ZUZFJGd3I3S29lQVZpSVN5VjRrMThCVzRZUjRl?=
 =?utf-8?B?VklTR3VhQnI0TUJZK0FVbFg0WkN3U2RJMUgzMlhkR1hRMkdlejZyc0l1djlJ?=
 =?utf-8?B?NWh1MUNEb0RNRTZFMWJIUU5qMG1Ldnp2TjlmakpUYUpqQzlRY0I5NTl2Vm5l?=
 =?utf-8?B?MEJoc2c1bTZCNTJFakhvcHovNHRUTE5idmVuMFl0MUNLZ21QM0hrbWN3c0sz?=
 =?utf-8?B?TTBZM3FuOFNzN2Fiek1IRDZvTVpZYm5VejZGWGZiUWd2ZnJoTFNQWk5IWTNT?=
 =?utf-8?B?SUMzNkhLTzBIbVlBbWQ0OEQ1bEllT0x2NXJoVkpGd1ZtaHlLa0d4OTQvM25a?=
 =?utf-8?B?eEQwNFBpZnFlRmVuYTMvZzJrRFQxcWZxV0YvTFZzSjRQUGZnNm5ZV1R2R20z?=
 =?utf-8?B?RCtHQ3M1TkhzMnJFK0VIdHp1M1JkdnMzcWVMOWQ4aHh5dHRiaStyV3ltM3Zt?=
 =?utf-8?B?THFTM2RnVm00M2NyZ3dWdkVaUFZEdmRiTFZ4K1FpcEEzS2c3SitwYkREZVpM?=
 =?utf-8?B?K2N4NzJGais0V091KzN2ZThpclU5cUUzVnk4bTZHZ0U3Z0hWb052bldSUFhN?=
 =?utf-8?B?Um12NnU0WkxpVVNrZ2RYeEZqbzJLbjExazVSOHpjdG43d1pmZVlYbWM2Nlli?=
 =?utf-8?B?V3lMdHdPMllOUm9Yc2MyY1dUWEdSK3lIcFJMdWFScXp2ZTZKaVNFVlhRTjlY?=
 =?utf-8?B?NFBiUk5BNjh5TGJVL1pWTzBQenptMkJYSmdoM0M4RHpPN3VSd1VlT1hSRjNO?=
 =?utf-8?B?TUVHVnpQY2EvQWRJc1VLNmtjQnhxWndnRW1XalV4NnhLVCs0WU9seUttbnZO?=
 =?utf-8?B?eEJPQWVXNEtHKzl5SUhGQWkrbEFKTStYZWJDOGQ4YXVQRXc0WDVkMm4rUlhE?=
 =?utf-8?B?OEMyNFJra3E2VEdmYzA4Z2craUdnRE12aTl0TmI3UzNDZEZiOGc5Ry9tRE1T?=
 =?utf-8?B?MjNNTGNrSlZYVkNjak9yQ0xLdTBhUkE1a3ppckY4WjFGSVoxRGJ0L1JqYUhL?=
 =?utf-8?B?MGY1emdoZTBNbEUyOTBhQjlqbWpHbXpMRzV2T3dBVDlrMWpRalVSVnhvSFNP?=
 =?utf-8?B?VkhSeXo3TEM3dE1ublVhRHlZcVE3d0Zva1I5OHZJT3kwYmtBVGhLSHUzc1Ix?=
 =?utf-8?B?VUJPTXdvU0JOY2tZbFRnT3hWRHozOEI1d2I1MTlTYjIwbWJrR0U4bjlmUmpi?=
 =?utf-8?B?L0ZtOEZDQ3hzeXhoZFRocm1Ya0FjY0pVWm9hOE10UnpmOHNSRExiM2xGdldU?=
 =?utf-8?B?VkZSQXMvMC9IMEEvdVRLUlF1aHZ3SGR2SzJVcU9LSFNiTkVXd01IQU9hVHZu?=
 =?utf-8?B?dGdhZW1vY0h2TG1zY2NQc1IwZmxhTkNqdEl1MUd2TUxPTHU5d3hLUlVPemlN?=
 =?utf-8?B?UDg0aVhTMTdsSDJEaWpQOVREZFlLRE5RQTE4L2piK2dveWJ0OGhaVm1wRmNU?=
 =?utf-8?B?MDg2UHpoRkcwQ3NYWXdISVR1RjM5MGpEZGwrR0ZseFR2NnROTEdFQ3R3NDlx?=
 =?utf-8?B?UTZmaCs3NHlmNU9HZ04xc1JpQ1pzREpncU93L1lrYXBySUhIMGtablJDVHc3?=
 =?utf-8?B?SU5IN1ZHNW1zSDVkcWlacCsvbjB1Yk9qb3NDK1lqT3l5UU1ybGxkbDdiYWhy?=
 =?utf-8?B?NHVRZTlaY1AyYTcyZm8ybnJ5Zm5xNEhmTUdSNkE1ellyZlRSOVU4T3djTW5Q?=
 =?utf-8?B?VDl3V2FuNjZHdk5wZTZHT2RMS3VxNE53dEduVzFNdllFVVJPRkN0N2NjU005?=
 =?utf-8?B?cXNJaE0wMXJPc0krZS9jK1N0RGFaR25EOTNOeXFkbHZYWHBWVXcxdllEV3li?=
 =?utf-8?B?K2hWM3RxTkVBbkdqTkhuMUNKVUk5YnBkeEZOeGNQQ2ZpZlVGREpQNzY4NGNk?=
 =?utf-8?Q?Shx/o1fxRuY=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2847.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?cXF0NFhOTWUrU3I3TVYwb01yZksrYmxXbzJRQmQxME9IVDF6a2U4MHBldnIw?=
 =?utf-8?B?OTBZS2Zaay8zUGkvS1BzYit6ZWhnT1ZPUGJiVTNWYzB0RGZVZjFHRnRTSmc0?=
 =?utf-8?B?RVJQU2dNOWJLZzlpZFppWGE4TUFXTVgyNzdZUWRtVGhpTklVZ2FwOE9hMUc1?=
 =?utf-8?B?T0FSMlkveHM4WUJMbjFrbi9ZbHBkL2RQYkJZdElqRUFUaUljcU01QVZDSkkr?=
 =?utf-8?B?djZJMU9lYm9EY0VTeWJaNm5abWhrSDdvWjE5UzFIZStJMzg4T1Qxajh2OFpR?=
 =?utf-8?B?eUVNWXJzb0J0VUFMVXZzcmQ2T3RLdzZhUEZpQSttS3QrQWFGY2xkSjlzdTAv?=
 =?utf-8?B?QnFWM2dRVUl6UHFRaUpsWXVkVzcxaUU4bVRIMzBLaTM4WDlib2R4RmVFcWNS?=
 =?utf-8?B?WTFpV3ZEMzR1bzhWaU5pcUU2TGZ1dExodnBwbTczZm1GTzVJbE1sV1FtN1pH?=
 =?utf-8?B?Uk9QRkFYNFN5c1dRRjJUK0tWS01BWU92U29BeERjbE13TzNWb1ZzbWprRHRO?=
 =?utf-8?B?b2ltUnhZelI5dHJla1c3NTk5cnMvVndkMDcrNmZSTGpBcHF6T1gvaklibW1E?=
 =?utf-8?B?MGxRd1JveUhiSTlhN2hHQkhKZFpaU0pnMDA0MHU4MTdtUFlac3V4MW03RXIz?=
 =?utf-8?B?ajNjYTVnWDA3K0hpdGkwbHFEQ3BkOGxla0JhSGVtN2dtWXdoLzRTZWw1NXlU?=
 =?utf-8?B?bUZWZlVPM3JLOGNDOHhVck9pTGI1L05SYzRCY003N2F2cGUvMzlFNXhlaFg5?=
 =?utf-8?B?Qnp2Lzc1UWNOTmozVGVzbGJGS0pzNUp2ak80V0FpUTRGclo2RC9FRGlFbHBy?=
 =?utf-8?B?ajlDSUtOaXdZeXJVMTNldEdRYitLM2VmcmE5LzBoZ3FlRzFXL1hhaTRBTzBw?=
 =?utf-8?B?RXA0UVBwYmdrQisxTVZWL3hCT1NwYWs5WlJOSmo2dmM4emVVTFJsMkJaaTRj?=
 =?utf-8?B?bmJhQzhsUzN1MTBlWDkzYUh5d0hHZG43eC9ITnFTNDh2MU1HREJYUWdJUFEy?=
 =?utf-8?B?cysrVWxYV29KeTVIRHVrb0FwSEtVM2ZVYStFUnpoeW1EVXoyeWVHN2ttdlUr?=
 =?utf-8?B?bFluU3IzNnlQTm10WDgrM0dTVjVaMVVVNklwRlJ3YTM4czFxUFZSbTQvMTBx?=
 =?utf-8?B?Nnhja2lQeVNjbG1aZVkwWklvQmZiT0NRMjdmZk95UnlJV3BnTk5iemloZmlj?=
 =?utf-8?B?a1RSSVNpaGxMWlZSSkVMbGx0Rk1oNCtXenhlbzBRRlN2VU5GMm1TS01qOElw?=
 =?utf-8?B?bVlrUTdtd1FYWXhVM1ZDREtVaXc2YkdITkMzOEV3dHJONTdKZ3phTXRoV0d1?=
 =?utf-8?B?TitmelJPOE4zU1dib3dEbDd4TzRNWTc4L3FidWZxMHJHRnRJbWNQRHQ2ckdz?=
 =?utf-8?B?b3Ewc0tPQmlJaElwb1hqZjYwakpqTEFHOEE1M1lTY21uUTdzNlJiM0o0R2Rl?=
 =?utf-8?B?Tkd2QWo2S1N2WU40RGEwVk1NVTZHajlyWUF3Ujhab3JoSEc1SFhQekw0K21j?=
 =?utf-8?B?MGNMeE5kTDdiWU9hU1FVSXdlM1R2UXNVTlJxWUNOekUrN041dnBuajNySGw2?=
 =?utf-8?B?cUNISHdaT3BNQlhERUFwTDNLcTAzUmtOcWRCbncxczZGSjk4S1Evc3NZaGVI?=
 =?utf-8?B?dWNSRlVTS0xEM2QzWDlmTFh6eUZ4THMyOVg5dEpaVjBJM1BjUktNNC9mSEZH?=
 =?utf-8?B?ZG9KNE0zRFBNdzZtUGlocUhmZWwvQXhCbzNLN2JEeUJNVFZuV1NxMDB2UTdL?=
 =?utf-8?B?QmFFdXhEaDFkSDlRV0EwY054ODFnK093OUNFVzZNY1Z2bFJHTUJqczJKRXpj?=
 =?utf-8?B?YlltL2diS3NpVmU3SmJsa3BIczZlWU9udXRvVFMvQXBTVFpIdXpWbE1YaWtV?=
 =?utf-8?B?YllUQXBLdjFnaEt3SGw2ZXZ2djN1aHM2aEpzeWNyUFFUQUUwNURwMVhmSDBt?=
 =?utf-8?B?dXUzTk5hcHRSSmdrcDVzS3dOOTROTjNVWEZTUktiTmpHeDZoSEE4WlNadVlp?=
 =?utf-8?B?K3h3MjVaTUJrT2V6MFlrRGlYVCs1K2t5WVVOd2RjR1YyV1ZhZXZnOGN0YkQ3?=
 =?utf-8?B?R2tEZ2NrWWlZbkF1cVNDZ3l2SkdQZFVwTHJ1STJyaHdvb3BLazNUeXdGeHVl?=
 =?utf-8?Q?7BSBV2GAHZsiTV5GH8uShu2kE?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: df64fd2a-a4be-4454-0d62-08dd825cb4c6
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2847.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2025 11:48:04.6309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m93MpHgnJTa5DYFCAXZb2JUTu7fkJvGCsEI3256vPtmBQ4kyBimJSSMzUg3gztxgQvZBBtLE/KA12Rot658Seg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4081

On 06/04/2025 18:37, Yael Chemla wrote:
> On 02/04/2025 0:58, Kuniyuki Iwashima wrote:
>> Hi Yael,
>>
>> Thanks for testing!
>>
>> From: Yael Chemla <ychemla@nvidia.com>
>> Date: Tue, 1 Apr 2025 23:49:42 +0300
>>> Hi Kuniyuki,
>>> Sorry for the delay (I was OOO). I tested your patch, and while the race
>>> occurs much less frequently, it still happens—see the warnings and call
>>> traces below.
>>> Additionally, in some cases, the test which reproduce the race hang.
>>> Debugging shows that we're stuck in an endless loop inside
>>> rtnl_net_dev_lock because the passive refcount is already zero, causing
>>> net_passive_inc_not_zero to return false, thus it go to "again" and this
>>> repeats without ending.
>>> I suspect, as you mentioned before, that in such cases, the passive
>>> refcount was decreased from cleanup_net.
>>
>> This sounds weird.
>>
>> We assumed vif will be moved to init_net, then the infinite loop
>> should never happen.
>>
>> So the assumption was wrong and vif belonged to the dead netns and
>> was not moved to init_net ... ??
>>
>> Even if dev_change_net_namespace() fails, it leads to BUG().
>>
> 
> Hi Kuniyuki,
> In failure scenarios, we observe that cleanup_net is invoked, followed
> by net_passive_dec, which reduces the passive refcount to zero. These
> are called before the call to unregister_netdevice_notifier_dev_net.
> 
> During the test, dev_change_net_namespace is called once, but it
> operates on different net_device poiner than the one passed to final
> call of unregister_netdevice_notifier_dev_net, a call which enter
> infinite loop (with net->passive=0 and net->ns.count=0, inside
> rtnl_net_dev_lock, as explained in previous mail).
> 
> Do you need additional debug information, perhaps specific details
> regarding reassigning the netns to init_net? Please let me know how I
> can help further.
> 

Hi Kuniyuki,
any updates on this?
thanks,
Yael

>>>
>>>
>>> warnings and call traces:
>>>
>>> refcount_t: addition on 0; use-after-free.
>>
>> I guess this is from the old log or the test patch was not applied
>> because _inc_not_zero() will trigger REFCOUNT_ADD_NOT_ZERO_OVF and
>> then the message will be
>>
>>   refcount_t: saturated; leaking memory
>>
>> , see __refcount_add_not_zero() and refcount_warn_saturate().
>>
> 
> you are right it's a mistake, i was unable to reproduce another failure
> with call trace info. Test either succeeds or hang (infinite loop).
> 
>>
>>> WARNING: CPU: 4 PID: 27219 at lib/refcount.c:25 refcount_warn_saturate
>>> (/usr/work/linux/lib/refcount.c:25 (discriminator 1))
> 
> 



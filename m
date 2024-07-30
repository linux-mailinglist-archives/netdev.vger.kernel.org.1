Return-Path: <netdev+bounces-114086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 70726940E7E
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 12:00:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E675B1F245E6
	for <lists+netdev@lfdr.de>; Tue, 30 Jul 2024 10:00:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15A28195F3A;
	Tue, 30 Jul 2024 10:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SCpKJIiG"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2046.outbound.protection.outlook.com [40.107.244.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60D39195FCE;
	Tue, 30 Jul 2024 10:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.244.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722333610; cv=fail; b=OcCUxCSNpx22w0LfEcHMEgTdIiO45SaF3PkjAug+HLXOSQCIhwxdKJzHdrKAzSgiRL21TB/Kz4kuWpDAfpr4R/mDPFvzq7Jgx+Aaa1VCTLarXYW1rQOn+mpSUMPUPXNwemm4JLO1Cra/pSVrDVRoJtrCVDWVdUPrJgKSjcWPjE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722333610; c=relaxed/simple;
	bh=TpaDJWGTJ145Ogxn0LBCCRjwOMHKj6VN+qpldVaup8k=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=bSG7FwnK9y7vdm/qiL8UaruY7bAMCRoX81fBn4qwrfNqUnhOvyje+rCha8/CVHwvcuMaQ2sffbvL+wHLNKxdwO969tQly+tFYwwdWWfttULBuahjQtA0WQMtfmcX047SFm6YumeAQiyZCoNmCcff0g6PKfUsZEEEj1OyEz1RC58=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SCpKJIiG; arc=fail smtp.client-ip=40.107.244.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jm2UO7ZWR8UzMDvZqas/xqZH9J4USB8llNJfswDK+AHDznLnpEPFmxSUNVoN0e1/AldkuwSsWcdRTwb9LJEdz3uTBKuM3SYWqAjdP1WI5zAwHJHKsNBdEz4mDavf5+uLJGadR0SUAS5QIxdSGwcbffyZTiinjCEKFmgdDLAYhjFAhHpbGiqkgcAqFsnPYUggfbwofqZ23YLiFWcTDChgX4PstpraAHKHIZTtqFBP2BlmEu1zw3MPNC7kjeUGPU0AE3ihiJDXaRvkqheEFCjR87GegjlIjsO81UXeG4T2SQZqBH24Kd4xJLHd8J45A4UfIV6XiYW5I0DBc9QUMvEYoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LDkY9ptTTcli1ftmOwGTczzkE12YdVWbTqqAJUekk6Q=;
 b=X2XlIIXyhBTotyE0OKEgYlmZHksP9dLMm0WNJFGr7EO9e4k3RKbC7d0EE44iClzCpicqy/gxg66Fblaq2jrX3pCtKV4ZhUDB72bWlGLKwyxplKUPX2h1aGO9g1yCURfEntkH00rYmY9qikIVCqSLpeB9oh8nbz6UPYTbqy0cPdgR+dj7n2mXuXG4UIGGCd44lr9dpWqbM7d13SLz/Y9sjF7lmfbsuj/kWsV7YoEGZ0RoV901g+3UvjQsIvqFrWvUvexkRFlTEU26aMqA9MffnNhig8dOSlS6r3qS86FVZsNVwBATDqZaKqgb40lK2qpEnhlbCxob/VI+qD9TzTCy0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LDkY9ptTTcli1ftmOwGTczzkE12YdVWbTqqAJUekk6Q=;
 b=SCpKJIiGnHVbl7vIfZ6OJPEmBcSu+rp9Ub7K4T9xmqPO1SYHUDwMfzhzeZMDSAul7JdZYbky4EWslUPkRJZts40G54ADxpd+0WOjPnpvz+b68vuvY6WuYLE19YRhpYa9R7hYqVaAIQecOvEtudQjcC5Or/tlW3oaovcyI8O+O6Lm2v5rIjIYNzk6LAyTtWgy5d8WyfihkIsV60b/+liYMFDSDDCTmzeT3uYx7s3WRbJHH8dxAI/wpByH9h4y3BfivyP8/aYSTSQinZpZxZuemAAQFBfUMkhMLkkF8AWp+YCL/4Ujh7gfVM7vBL3Hxy1b5xP0yrXVflVHzo6SYSUTDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM8PR12MB5447.namprd12.prod.outlook.com (2603:10b6:8:36::7) by
 DS0PR12MB8456.namprd12.prod.outlook.com (2603:10b6:8:161::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7807.28; Tue, 30 Jul 2024 10:00:04 +0000
Received: from DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b]) by DM8PR12MB5447.namprd12.prod.outlook.com
 ([fe80::5f8:82ee:7da9:219b%3]) with mapi id 15.20.7807.026; Tue, 30 Jul 2024
 10:00:04 +0000
Message-ID: <8ac00a45-ac61-41b4-9f74-d18157b8b6bf@nvidia.com>
Date: Tue, 30 Jul 2024 10:59:59 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next v3 2/4] net: phy: aquantia: wait for FW
 reset before checking the vendor ID
To: Bartosz Golaszewski <brgl@bgdev.pl>, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S . Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Brad Griffis <bgriffis@nvidia.com>
References: <20240708075023.14893-1-brgl@bgdev.pl>
 <20240708075023.14893-3-brgl@bgdev.pl>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20240708075023.14893-3-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0005.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2ad::17) To DM8PR12MB5447.namprd12.prod.outlook.com
 (2603:10b6:8:36::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM8PR12MB5447:EE_|DS0PR12MB8456:EE_
X-MS-Office365-Filtering-Correlation-Id: 16004a4e-9ae8-4219-df50-08dcb07e6235
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?UHo4MUlBTWVQZ21Hd0YxSDFEMzB1K2xITmJnU3BOc1FuU0JPSGRkcUgxSU9U?=
 =?utf-8?B?WkpPQm80N3NkRFZmQ3hSTmRPYmx1b0Z4M3VjdWNKSFlISVpWMFZoK3JTVzY0?=
 =?utf-8?B?ZFU1VytVcUV3QmVPcDlXUk9BR2ZGQVdBbk43bGthSnlsQzZlV1gxQ3JLNlNm?=
 =?utf-8?B?MkxyMXIrNFlMbnZ1d3lERlJiandrUkIyam5NKytJYWI4ek1oZnAyREVVSEI1?=
 =?utf-8?B?a09yMHkwcG0yNzNGZmRFNCs2TkZHVjBuQnRJNWJBU01lamd4cCtjUlZPZnFV?=
 =?utf-8?B?RTZXdVNCbnU0ME9uRHlNQ1Yrejh4UVBKN1FYSUcyRmhUWS9yRjRZN2h4SmFO?=
 =?utf-8?B?ZVBZQ0V5MTdDL0dabU5IMXJmeG1OTEhuRFJBLzJLQ24yUXg1dmlpRE5SS0h6?=
 =?utf-8?B?TnZ3V3NSWlBWdmQ4OW93amdEM0x3M1p4RFJwRUQ0ZSthYnd6RmppcnB3RUI3?=
 =?utf-8?B?bCtJZUE0bVNzMWU5VnZnV3lZTWplZ1Ara0IzTWNXeDNLekRHQ2htRndvd3hQ?=
 =?utf-8?B?MngrazB1b0hVN0EyYklyWlVSNE01dUhHY1pJNnNFa0lzaklYL3E5di9TUVI2?=
 =?utf-8?B?aXphZHZJTWxPKzIwdDFlQUxqSTVXbVd4NGF2NklYcXZGR0pvNEdvaXpUdXF6?=
 =?utf-8?B?R0tkcWlHcHhvUGN2MUV5dUFVYS9ZakdpTy9iVWhUK05lRFFBcTM1YUkvTzVl?=
 =?utf-8?B?OUFFdzJBQzB1VUc0d3VzSmYxWGVVZVJqN3loOWpOY3BhVFJMKzZlZEVMaW9Y?=
 =?utf-8?B?YjNIZXRXVUllOCs3SktnNWQ5RlVNa1BBWkJtWU9xby9nbzNhUVZpOFZNcWpR?=
 =?utf-8?B?cnhzcFM0dUhudzF2WklFaDZQZ0hWZktDQ05DMWlzRWNRRjZkZmtQZnJQc01u?=
 =?utf-8?B?V1hUR1lMbzQ1THIvd01GdExwb0NCQjhWY3hyc2hYT2k2T2JnTDZ3bjExdnVP?=
 =?utf-8?B?WFZCY0l0K3JNZy83am1IVElMQlQ4Ty9EYTlLcXlWb29kWkFYQzFML01lZGky?=
 =?utf-8?B?WlFxbTBUbDVYbWZJZCttdC9VYzJZcjMrVU94dXRYdldIajB2U2E1bmFhNEtE?=
 =?utf-8?B?TmdMNXVpRTYraWZTTHgvbjdVM3JKMVdpblZnWW9tazRpdTNLSS9qeXJ6dVBO?=
 =?utf-8?B?Qlp4K0kxNGh6YzlhbXplWDZQektGcit4Qi9OdzdYWFFJS0psWktEaWRkOU1X?=
 =?utf-8?B?M3lTRWlTVWxScEdHcVNLS2I0bGpMNWxGUnl2cGNYU0FMLzhaTFE1cG9lamFV?=
 =?utf-8?B?V3gzWnVjUkZoZmw1b292THRwU1BJTFErZ1BMRkJLUDN5Unh1a3VIZGhUaHFz?=
 =?utf-8?B?a093VXEwMjFLWlAydzZPUGtuZkx0djRIa1NFWUdvMFhCS3lKMkdJbytrSDlL?=
 =?utf-8?B?UHNaUnhTUnhQVml6dlhLcFJJR3VucnZKUldhTzFOdG1TS1d4dnBNems0bWJB?=
 =?utf-8?B?ekIzaEFlMk9pUkt2SGpzK3I2bHY1bFRIWTJFUG8rTVhDQXRFdXcxNXZkZXpt?=
 =?utf-8?B?VENHTnEvcWVhZTcvNjlhYlV0SEJTRzd5YlVJZHh1ckV0UTRIaWxjTnNPbnR0?=
 =?utf-8?B?Rkh4RTNLTDgrc3poRW41QlJtc28xNTQra05GeW16Tllybzk3L1BLQno1SHlk?=
 =?utf-8?B?TllDUCtMbkh1Yi9Sb3pqSXNZYjlrRVBvZnpQcVJoajZrWkJBbW1EVmJJRWFl?=
 =?utf-8?B?bXhwTEFqU094SHlCanp1V0NFYnF3QVk2MkNPN0N4WnovY3RFditYRjVhQTc1?=
 =?utf-8?B?aEFQdjdXN2hkNWpNRG4zRFdIQ05acXdOVjYyT1VkdkdjUFBEMG5ZUlV2dlZX?=
 =?utf-8?B?UjM1V3NTQ3RSd20zN0Z3UT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR12MB5447.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?eEE2WkJYSWUyNXlNcEE5YzM4cWNrQjljbjRDQjA5RFZCWmZzemk2aThtNDJ3?=
 =?utf-8?B?SkRPR3pVdWtyTzFuL0lZZGY4SE5VRUJOYkM3MWY1RzZYaC9ZM1A1Mlgvei9S?=
 =?utf-8?B?dnQvQVZQcHpMZERqR2dza3Btblc2V05zdWJCRDFFK0Y1alJiS0xOd0xJSkRa?=
 =?utf-8?B?UUFxMzlNVDBoK2wrVTdPSnZjVnRYU2xjZW5rbldQcEllNkRWKzN0UTJPQmVK?=
 =?utf-8?B?MHlwNDM3TmgyanR5MlBZc0Yxd3R1eVVxdnc3c1JjbXFEdFQ1V2RYQkx6Q3Yv?=
 =?utf-8?B?K1dLUW5hbm9FckcvamNqNXVZcEhOTUttVzdDTHlWNTdzU3p1U1BmSkh2Szhj?=
 =?utf-8?B?UzJycWtPdTBCVUpGc3FsNk9HcXBQS21zdmVlcXpyb1JvZnJaNEpVanVUWFE5?=
 =?utf-8?B?M2hQR0g0OGxPdXhWMVpKMkN2aVJYSzM1b3lHZi9zVnFjS2NRR2grM1FFMUZW?=
 =?utf-8?B?UmZNRXJNcUF6T1doTXNJN2JkQmpjQlZYbkRuRjZIVEFTeWF3SWtHSFpyMVc3?=
 =?utf-8?B?d1k4eE9xK3FnRithVkNoK3JzZUJscVhlOExSSTJoSUExeEVtYWh2VFhhUmJn?=
 =?utf-8?B?VU1tOS9sUVRnakdLbVdaSHY2akd1MW5VcThJdzk0dFVVRHJBVFBnMXFPWHF1?=
 =?utf-8?B?VXBjK2xoaGxUTjhHbkZmOXRtYXd6TmVIMXl3Tit3eWtBT3Jqb2M2SFQwTnFX?=
 =?utf-8?B?WmVEa2NDeFh6OWl5UUEwQ3dDTkpsUXBNV3h3czFsNUZGSkNBWXZESVV3Wjdr?=
 =?utf-8?B?MjEvYjF4djRGaGVYOFZYUlpPMDVhakhxTTRIckRTSFhwQVArc1diMy9NSWVF?=
 =?utf-8?B?cUFWbGE2ZHNPd0svaG9FU3VWSFdhZS8yRnoyaDg1emUyQ0x4UFcxOU84SlpN?=
 =?utf-8?B?YmFjd2FzOXk4Z3VWTEtNTi81NnpraE8zUU4wZkRLWXcxN0dYR0dSTndLZHhi?=
 =?utf-8?B?VENYbGZwRGdWR2VaZm8yelBPcGZFRHFaSXBTSEdvTVNiZWtZNzAwVVlMTHhr?=
 =?utf-8?B?eVVPT0I1SWRmOEQxaFBWVWFOb1ZnNUtWcWxXVDExK3Z1cXBJZDlNeWUvODV4?=
 =?utf-8?B?V2tjMW5LT1R1bjhOOTdYejUvV0ZnQzNCWFVTYVpQeGpOVlhBOVhuaXBDSEJW?=
 =?utf-8?B?d29EdVpxcTluQXZFb3ZMZW41ODRPUzZvQjhtTmdwNVFUTC9oYmlJU29CdjZt?=
 =?utf-8?B?ZDl0anFOUlpGN0JuT0txL3BkMzlnSmlkem8weElDakd2Y21mZG9KRWp6UlZE?=
 =?utf-8?B?SXVWTk92ZXdQdUd6SmJ4V0EzdTR0UTBHUnl5UWw0WVFIV2EvUXBNdTJyWndG?=
 =?utf-8?B?a3F1YTZWeHF0eXhPUWgzYmkwYS9qa3dBUGdlRXh4aER5cHdmZkFNbWJpektq?=
 =?utf-8?B?MnlmS0doVy9hUFlJNC90WlgySm1kYXcwTnBVQkhXS3QvR0I0ZWFnUjR0RDM1?=
 =?utf-8?B?QjRIMnpzR1h5cGQvUVBnbDBicEQxTW1wZktWZTEwbFFMNFRBUkZtcVFWMmdH?=
 =?utf-8?B?Vm1JWEkvUCt3ZGFkaTFVN2N6VnlZRnFMTHhBSjArY0x1enlrVVhPRVhqeEVU?=
 =?utf-8?B?Z1N5NFcxb2ZuY3U3RkszcVhMeTEvb3F3MVlieGl5bHpGWWFwU2N0Rmx6UWRp?=
 =?utf-8?B?L2ZBanpQeWhnVG94K1FKa0UwVUNoa2RjU1dxZk1GK2V6ajc1bzJWRklLZldR?=
 =?utf-8?B?UjdwOVFVandRMUwzVk43YzEwK1VwM0hORkhkbENzRXE2Y3g4T1IxT2tkNkhx?=
 =?utf-8?B?bGNwdkFEUWQwZ1krKzR1Z01zMy9LNERtNkdqdzJhYW5DdlQ4MnN5Mko3V1B1?=
 =?utf-8?B?MGFJZFd6aVdVdDdFRnFQRy9NUlFrNmZhSXRxYjZPY05tRVMyQlFyVWg5SHc3?=
 =?utf-8?B?bFhJdklhSmdmc3E1U0ZXbUlUMFVLMjg3SDltbEpNb2lMZERXaHZxYmVzRGtY?=
 =?utf-8?B?ZmlPSzJMd1hVRmNoZDRLSWxxYmtZTkxybThOdGFzRDFFWEVBVVQ2SHcrbnhH?=
 =?utf-8?B?VmQ1NlB1K0RmbVBaSHdCKzV3YmpCMnNSdnNVOXFMSVlLWmJOc0dyYUN1V0I3?=
 =?utf-8?B?TmRrdU45UGJqd3k3SHJYdnVSdjBNNXBOY0N2VVhnbTFrK2FrSVUzYlJHMnY4?=
 =?utf-8?Q?Gx7Uea8jgaKr4AvXYfTiTzh+i?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 16004a4e-9ae8-4219-df50-08dcb07e6235
X-MS-Exchange-CrossTenant-AuthSource: DM8PR12MB5447.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2024 10:00:04.1776
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ivsYrS16eABFbmwYVpIFBpu8ZYKfQLllcQUCbvCun4pnxrvcIVQdnPkogKBinVhapZImZrRAXg/jsFSjNszUrQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8456

Hi Bartosz,

On 08/07/2024 08:50, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Checking the firmware register before it complete the boot process makes
> no sense, it will report 0 even if FW is available from internal memory.
> Always wait for FW to boot before continuing or we'll unnecessarily try
> to load it from nvmem/filesystem and fail.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/net/phy/aquantia/aquantia_firmware.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c b/drivers/net/phy/aquantia/aquantia_firmware.c
> index 0c9640ef153b..524627a36c6f 100644
> --- a/drivers/net/phy/aquantia/aquantia_firmware.c
> +++ b/drivers/net/phy/aquantia/aquantia_firmware.c
> @@ -353,6 +353,10 @@ int aqr_firmware_load(struct phy_device *phydev)
>   {
>   	int ret;
>   
> +	ret = aqr_wait_reset_complete(phydev);
> +	if (ret)
> +		return ret;
> +
>   	/* Check if the firmware is not already loaded by pooling
>   	 * the current version returned by the PHY. If 0 is returned,
>   	 * no firmware is loaded.


Although this fixed another issue we were seeing with this driver, we 
have been reviewing this change and have a question about it.

According to the description for the function aqr_wait_reset_complete() 
this function is intended to give the device time to load firmware and 
check there is a valid firmware ID.

If a valid firmware ID (non-zero) is detected, then 
aqr_wait_reset_complete() will return 0 (because 
phy_read_mmd_poll_timeout() returns 0 on success and -ETIMEDOUT upon a 
timeout).

If it times out, then it would appear that with the above code we don't 
attempt to load the firmware by any other means?

Hence, I was wondering if we want this ...

diff --git a/drivers/net/phy/aquantia/aquantia_firmware.c 
b/drivers/net/phy/aquantia/aquantia_firmware.c
index 524627a36c6f..a167f42ae36b 100644
--- a/drivers/net/phy/aquantia/aquantia_firmware.c
+++ b/drivers/net/phy/aquantia/aquantia_firmware.c
@@ -353,16 +353,12 @@ int aqr_firmware_load(struct phy_device *phydev)
  {
         int ret;

-       ret = aqr_wait_reset_complete(phydev);
-       if (ret)
-               return ret;
-
-       /* Check if the firmware is not already loaded by pooling
+       /* Check if the firmware is not already loaded by polling
          * the current version returned by the PHY. If 0 is returned,
-        * no firmware is loaded.
+        * firmware is loaded.
          */
-       ret = phy_read_mmd(phydev, MDIO_MMD_VEND1, VEND1_GLOBAL_FW_ID);
-       if (ret > 0)
+       ret = aqr_wait_reset_complete(phydev);
+       if (!ret)
                 goto exit;

         ret = aqr_firmware_load_nvmem(phydev);


Our Aquantia PHY has a SPI-NOR and so we don't to test the other 
firmware loading cases.

Jon

-- 
nvpublic


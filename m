Return-Path: <netdev+bounces-196018-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ABDDAD3297
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 11:49:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 803743A95E1
	for <lists+netdev@lfdr.de>; Tue, 10 Jun 2025 09:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EA0A28C01E;
	Tue, 10 Jun 2025 09:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="SKc2xBAi"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2064.outbound.protection.outlook.com [40.107.94.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 738FF28C019;
	Tue, 10 Jun 2025 09:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749548672; cv=fail; b=eKVoqwtdkVA5zQ4PPJynbJDen7QktcJm9lFCMWglIpRD1G95HOv5N8Pwy2KX/5+d/hBRpeivY6Jb6rqsU09aqM3gTP5RS7sJmZaRKTQQlhCbe7+uERf7JoEmqx9tanXAdcC5c83YU8HURTzzVR3DPdZ/WOXJZx7oQXzxGc/AcIA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749548672; c=relaxed/simple;
	bh=a1zckwee8BO1dcf/qrGRaEANs8mq3PE9OfJkvpR/j8Q=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=WY4HVqKlrMc7b1gFyNodwLBKsPp5lVt5pizUX9K2LT/EyVU5uSK/zIZ781MlDENSlf3vntY8Bi1uwBulCutcz3kTd+P1db3UyrcrYJa0d3MVT6+sZwLU2bU0K05au/0s3DUmmZwkxGnL1ZNgLqq6V+7Y0cILwa9c/jRCos6uyyI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=SKc2xBAi; arc=fail smtp.client-ip=40.107.94.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=eq7Hh2ML720OfQ0us3Yi5A5YkVOu7Qfg/OvzEqSSp6it+V98bQfd/999gFgFeIiM+lvHoFBG25yiJZjd8b/rnZEaJPbZonzO35X2yAshbGQRf8J6oUz17/vS4VGtYn7+JZY/mUXMnB7mTdyG56lWHL0Jc0pxH6yZQYj/9MQWKkuWqzylXQHlENDDUa33zJDjFPRWYQlVeKDUOgil1LAiNqIUPbaZnemYWHMDGuV/f9Sl9bTxeH3mQXVAnJKpYgUL2NLnUOMjiN4JmIRTadMFDDHV+Olpx/Po4vEdrdRkK/uRFfYnXD9DDMlpN8lYUbYmo5KtV7+ON+ASsl9pnXT6Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCth0qxQjG5LLAPDQjJOw7OWRl+sTNqJ6FE38nhgrpI=;
 b=oRmFaNV6caZQbVhro7aeOpkjUwWH85/LSuyZDAWGWT4ti1ACG1JZWnl93J8ZpqhaoLgI1ow5EQE8BZQrVyck7rKNE71D/Hh+3QLOJJpjnLyY1bfQsMPPhZ8olTHjcIS0zR4Luw4yKbjFfbP/NtAnVAywCgDMy/ZQjzaRgBFH5J01KgPtQs2fuUyTO2pl3wCH5tJMpSvhFG7IkI2NLZTkf5OlsxWlAre/QVCE/oXFNMa4k6z2xVBJRJOfhVXavtO7MDHUcOcgOrwfu+gIy5Qz3jGA3Y3toIy0QAJDIBDS187Yz3d/7GD4wBgUB203cO9UtMm/SqFW2ebVAF2QpDnC8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCth0qxQjG5LLAPDQjJOw7OWRl+sTNqJ6FE38nhgrpI=;
 b=SKc2xBAiBWql8YkBOykTkYPf+0hHg36eJFD6hwCHBsoqh2oWCzWwO8RfMRjerysf2G+YtSZt7lS0ww8bNkFfDz9YvflILZTPfg07spMK0etfvnEA5r+S3J8o6vujCVWOHtQ82+l3C6tAydYE9TKg5e4qildPLUSm0kixBCpW/gLlxzQ9bMjj8mTzD1z5duAIAVz1ucIg9yrNZjeKZCdUzR2RQnegiA4Fja+U9WkkO727ogql4LHlXDB+qaf9fuMNPBxwUQq+zF/NCzuhreHjSCbrdsTWoDFSBj/vDm+qKtWnbhgYgUX5MHS0G5QYUa2Zf+jqjpONV4tmaYOiNiKbCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com (2603:10b6:a03:4d0::11)
 by DM4PR12MB6568.namprd12.prod.outlook.com (2603:10b6:8:8f::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.39; Tue, 10 Jun
 2025 09:44:27 +0000
Received: from SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9]) by SJ2PR12MB8784.namprd12.prod.outlook.com
 ([fe80::1660:3173:eef6:6cd9%3]) with mapi id 15.20.8792.036; Tue, 10 Jun 2025
 09:44:27 +0000
Message-ID: <baaa083b-9a69-460f-ab35-2a7cb3246ffd@nvidia.com>
Date: Tue, 10 Jun 2025 10:44:21 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: phy: realtek: Add support for WOL magic
 packet on RTL8211F
To: daniel.braunwarth@kuka.com, Andrew Lunn <andrew@lunn.ch>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250429-realtek_wol-v2-1-8f84def1ef2c@kuka.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <20250429-realtek_wol-v2-1-8f84def1ef2c@kuka.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO2P265CA0361.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:a3::13) To SJ2PR12MB8784.namprd12.prod.outlook.com
 (2603:10b6:a03:4d0::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB8784:EE_|DM4PR12MB6568:EE_
X-MS-Office365-Filtering-Correlation-Id: 50dc75da-8ff3-4f1d-97be-08dda8036417
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|376014|10070799003|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?eVZPM2RucXhZaVJ5WGtzamlFT2FRdHowN0c3c1VJU3V0Q3lCNUdLcExsMWcy?=
 =?utf-8?B?NTJTZnFGYVQrL1ZEVXhKSVozaXQ5SUpCRnc1R0dWVHAxMlZUSlRjekpWRmZY?=
 =?utf-8?B?RUM3bW1aaWVYTzh4RlZ1MnIzUU92akpzNm1ZcStRSTVaUHdUWSs4QWp3YTZ5?=
 =?utf-8?B?UzVkWGtUalNVeitTR3k1MmQyT0lFN0kycEpaS0V3b0JWbmJtdjBFY09hejdD?=
 =?utf-8?B?VjFUQUNWL21zN1BXNE1sNmF2TUNMdmxoVTNvN1BaWVdqOWttZzVQeTgzZFdp?=
 =?utf-8?B?VEpMeExuaTlkOTN6cVYwNWhkVkxwQkJpRUZ5QVo4amdPQitEeStGMnNkUnEv?=
 =?utf-8?B?TTJwZHhBQWRMMzNaVk9RZUJIQnFaWkVUTzY5ZldoOEw2K2ZCTkZXbFA0NWtL?=
 =?utf-8?B?dFVmQW1odjh6dXdBRTBSVE9BWENPQ2QrcFZFOWxBSjRsTmNCY1FieXRKV0hV?=
 =?utf-8?B?blVFcmkrRTIzR0hyZFkvL1JLZ1FMN3R6eldjSGt6Z2J0aFY1MVdCTkN2aVZS?=
 =?utf-8?B?SE1EbndxcmEzTFJIV0g4dUY0M1VURTNwSXEzNnFBWndiUDRYVHJYYU1vcWJD?=
 =?utf-8?B?UDRqMXAvSEFjcUVRakp6R2FDdTNZWExqdk1ITFJseXN1dE93YmlBRlFFaWZp?=
 =?utf-8?B?b25Wd0xOMEFRQUQ5bDFhU3dQcFY5NmFoOTlEcHhEZm9EakFIODZhbDFTN1gx?=
 =?utf-8?B?NDFNV1Mya2t6Z3d3cTVRQUllNkY3WndzRlltR3E4ZXFrVk9zR2sxeE5CaWxs?=
 =?utf-8?B?Y2s5KzRIU0JlS2UzdWVTcHRYWXhseTByVFlHVzg1cXZ4NUdNTld6R09xclho?=
 =?utf-8?B?QW1aenNTNWZVYktGWlZqMVRnRHNUZWNORFFTYnp2YXZ6T2t6UC9Xd0I1dGZh?=
 =?utf-8?B?Z1V0di9PMFpPNnV6VUlVaE9mdUc1V1VGL1ZreGFCTStIUmVWTjVOR2RsMmtz?=
 =?utf-8?B?YlFBNU9xeVJYM0tGcWl6MXRWWjV0aFJyT3llOXBIdUlnbUlOeWNvZEY4TjZC?=
 =?utf-8?B?dmt2Y2JuRW5JQ3FaWUFRL043UjZ0bWFrRnI5NmtFeDJWdGk3TDFkcytpa2k0?=
 =?utf-8?B?NVErYVBYMmlCR2FOMDQ4NmFIanczQ2s0RkRnWGR5WnoyWjhlODBiSlNWN1hB?=
 =?utf-8?B?cnRhc1FNbVk4MnVLaGZ0Ny9ldGNHOFdLTUNCamtXd2k3dGU4ajMwU2lqV2xU?=
 =?utf-8?B?VVFITzhQWjNndjhuVWRWWlZic1hQNERBVjdVZnVHSE1scEVPS2F2R3A0SkIx?=
 =?utf-8?B?SkVzK1MzL1cwdG9ZbU45TS9QK3Y0SSs5OHFPck9CV1VRK2w0ZHRFWEpuOTl5?=
 =?utf-8?B?QkhueFlzcm9lbkRHQ01XdERTWkY1Um1xN0kxbHBHN2FQTGsyS1FSMGYzbWll?=
 =?utf-8?B?dnkwcU81MTlnbDFkalRFYkNaWGp3M3MzSDBYQmUrNyt0UkhZeEtXdWVjS1Bh?=
 =?utf-8?B?T3Z5MGNtc1Nsb05wclE5VFB3MGRxWmIvTDZBZHlxQW9uYm44bldZZW82OXlU?=
 =?utf-8?B?eXFuNGRkQTVMNElCeHVjZTZ0Y0ZKaVBBZWQxM2hwYitvV25hNkhyWWpNRjNM?=
 =?utf-8?B?OEhFWkJwbGYvN0JNWkQvelRNQUtTZ3lxRkU1ejQ4bzdlQzB3NUZVMDErUWlO?=
 =?utf-8?B?UzRicHFwaC82bEE0S1JIbmwrbFd1SDJ6bThJeXZ6Yy9WbFd4MldzWXhJWUJF?=
 =?utf-8?B?MGl3cWVMK3l1SjFKRk16YytaVjFXZE1hSytXWlJxcnpwSC96N2pZQ3NTdG9p?=
 =?utf-8?B?N3A3bmNycTNGL1U3b2k4Y2hpZU1TOUhiYWRLSkJBQnY4RDBKR1RoVGlNN1hN?=
 =?utf-8?B?QUdaL29zcFF5SG56R0NxTXcxMlc5QnZOeGJGSzFlS1JJcm9nRnNQSklOY2Fm?=
 =?utf-8?B?b0UzdytDZ3UwR0hyNkVHV0NPaEZRUDc2SElSMnE1bFk5WmZvMkpnd05TOXpy?=
 =?utf-8?Q?feDod3bBK6A=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB8784.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(376014)(10070799003)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?NVdQRVRSTU9qUHQyR29ZaHh1d24wZ0lFVE1SRFJ0VHhBcDNpSGE1em5ldUhs?=
 =?utf-8?B?SmdtejFzeHJWVzRlaUFYWXE4WXN4WDdkMEZOajVuYkhPbnUyZEhWMmp2cVk0?=
 =?utf-8?B?QlN6d1R5UlV1M2J4MWZwbjZCQlFnd1FEQkVPOS9LYjFTWGV0RjNBMllScFBC?=
 =?utf-8?B?K3c2Zy8wZ3o2T0JwbEJxdVcvM0JCVzRXNHpyYkxmSG5qNW5GbFBoOG1VTXNy?=
 =?utf-8?B?RDRsS1hIblJlZ2k4MG0yMjJvN0w1WW5vL0VwTWJiM3ExNW1XSVkyQ3NXSVFX?=
 =?utf-8?B?aHFEM2JSbFoyajB1aE94NVFKa0ZabTB1NlNpSXNaalg4V3NUcFdIU0JCYUR1?=
 =?utf-8?B?WXY0SmpzQXpLUm8yZkduSjAxZHZNWTVDVUErVGpWUkV5QUZIMWttYVVvTDFM?=
 =?utf-8?B?eXVXMEd4czkvbkJXaUx4NEd4SWora3hwbGxRakZQZzk1bVJGNllub1pjdGxt?=
 =?utf-8?B?T3dRUWV2clF5U1hLZGErSlpXNTl2NjQ2aGRTeXl0aUNaRFAwNTUzVzNkcnA4?=
 =?utf-8?B?cmdjZU9SbG84SWdCRzhlREJIRnlQY3UzU3hoZUJzWjF5Q1ZSVjVNNkwzY3BK?=
 =?utf-8?B?YUQ1MFBtNHZ5Rk9ydVJmeU9FQkV5YytodG1MNHlWakwvc0J3c2tHOXdmbFUx?=
 =?utf-8?B?YkwrRSttMUduMG5CRSt2MFlsaXNwdU1zcW1DVmszVkNpSmw4K1lreTI2L1d1?=
 =?utf-8?B?WXhiVkRFTGtibEo0R2lXN1FaSUJJdFFuemZDWFhoUEQ2ckNxRWZzWCtITzJO?=
 =?utf-8?B?TU9KNkVkTkRQeGIzQkQ1eUVBMFpiRGtKdUYvdFNVV2tpTzdOYnBFVGFYMHA0?=
 =?utf-8?B?N29YaXQ4aWFSWDVCZjNrMUw3cUtCcGFLYW8wcEllckhJalg4YXltcU5sQ2po?=
 =?utf-8?B?aUlNQXBRSllETjFhNURhdFMrV1h1UXhKNGt3Y3pRRXBHQ1dVM2FGZkZyRXpm?=
 =?utf-8?B?VGRrQVJ2NFpuZXB2ajNqWG1QK2szNysycEJPakFRenk2M2hEak02bWNRSCtP?=
 =?utf-8?B?c05reDhJa2VMVEpnYnVtd0JXMFk4VzBzeGZJY3JubjdFbjBGa1B5dmxyMWJZ?=
 =?utf-8?B?STlBYmRBT0VLNUEwMFhMTXVabTJlVkNjc2dJM1NuOEZ6TjVGblJxL0NHWEZr?=
 =?utf-8?B?Z1Y3YnRJOUE5M2hqV01WbW5QZlZMZDVaUTR6czB0WW9BcUY2L05YcmJsdjNM?=
 =?utf-8?B?c1hFTThpSkJiUmwwKzJJQklrc0wvQzFOT2ZsZ0VEOW9Hc3RYVHFvbHhMNjlH?=
 =?utf-8?B?S3U4S0V5Z2k4Wk1ySjEwVkhpTktJaU1UcWNSSnpUczdhL3k2U1RxWnZxOHF0?=
 =?utf-8?B?TVR3K0lhb3V0clF2N3NERGZGclNpeEptWi8xS3c4WTNpRUFiWng0ZkFDajg3?=
 =?utf-8?B?NWZpSnpwdmVOSnhoVXZGQ1JNazQ1OU1NRmY0NTVpMjZZaU5wdEQwY3ZoU2oz?=
 =?utf-8?B?cHV6cDJ1d05BOTlqZ3I3ZlV4eTBIT1FTazFpajhySEp4aGxqdC95YUhrNVlz?=
 =?utf-8?B?bDJVQUl0QnRSS1oraGpTWE1NMEFTYzlyYjY3STl3Tk5CWmx1RUhxYWdoc3Nu?=
 =?utf-8?B?ZDN1OEYxQkFOblZYZm1XU0JZL1pNcWFuZDFFcUVrR2d0b3FQNU5YUStpRGNt?=
 =?utf-8?B?eUhYT3RYMmwwV1paaXlIdnJRa0ZPZmVPVGpOaFUzN0F2UnNycTdjU0hyaXJp?=
 =?utf-8?B?N2x5aThlZlpyWHRTN2ZPZnc0R0ZBMWJsWEZxbXhoYk1SZWpVQmpxTzFhQ244?=
 =?utf-8?B?c2JwMGN1M0QyS3hJM2hBRlJIVzRCSzRhNUVrS1VxcmJFZ09qTTRySEdoaXdp?=
 =?utf-8?B?dFl5OHc0bmZmOGdXdW5Ma2MrMUZDSWJ4bWRJR1h2SWZlS1RXTkRIdmhvQ2ZP?=
 =?utf-8?B?NElKNFVXK3A5VDhBV25WakwxM2lDaDZ4ajJCc1UwOStWeSs1M1pjUzN4aW1i?=
 =?utf-8?B?bUk2SVNhS0t2UEtjS2xBVks0dEtLcmJXOVkrWFEyVk1rTlBXV2hhTG5uZGNT?=
 =?utf-8?B?UXRUa3hEbFhra3FOdWgzN0c5TnBzcjlkQ1puVFNud0dUdm1IQlhObVFBemVn?=
 =?utf-8?B?TjgvakRDZzFwWU40RmpXUEpUckswU1BwTG1UUVFZUXdxTTdSa1RjQmtlZ3Rs?=
 =?utf-8?B?SjF2eHQzYVJDRXF1aWxyZ29lWjFMRWdHaDgzaWZndStjTTVxakVjSkdSZHJn?=
 =?utf-8?Q?F4zJv31WV4vJEeY7ujV9VYJ+nisDxzGMSDjZwdnTAFXA?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 50dc75da-8ff3-4f1d-97be-08dda8036417
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB8784.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jun 2025 09:44:27.6672
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bc6jYlg/BtjC9alcQF54nzwtv1rZPaQ7BWf9CS/AjK8XTJpUy809HatsEpQy4VAhXxdQ2214TGxixY789ypPxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6568

Hi Daniel,

On 29/04/2025 12:33, Daniel Braunwarth via B4 Relay wrote:
> From: Daniel Braunwarth <daniel.braunwarth@kuka.com>
> 
> The RTL8211F supports multiple WOL modes. This patch adds support for
> magic packets.
> 
> The PHY notifies the system via the INTB/PMEB pin when a WOL event
> occurs.
> 
> Signed-off-by: Daniel Braunwarth <daniel.braunwarth@kuka.com>
> ---
> Changes in v2:
> - Read current WOL configuration from PHY
> - Replace magic numbers with defines
> - Link to v1: https://lore.kernel.org/r/20250428-realtek_wol-v1-1-15de3139d488@kuka.com
> ---
>   drivers/net/phy/realtek/realtek_main.c | 69 ++++++++++++++++++++++++++++++++++
>   1 file changed, 69 insertions(+)
> 
> diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
> index 893c824796715a905bab99646a474c3bea95ec11..05c4f4d394a5ff32b43dd51f0bff08f437ad0494 100644
> --- a/drivers/net/phy/realtek/realtek_main.c
> +++ b/drivers/net/phy/realtek/realtek_main.c
> @@ -10,6 +10,7 @@
>   #include <linux/bitops.h>
>   #include <linux/of.h>
>   #include <linux/phy.h>
> +#include <linux/netdevice.h>
>   #include <linux/module.h>
>   #include <linux/delay.h>
>   #include <linux/clk.h>
> @@ -38,6 +39,24 @@
>   
>   #define RTL8211F_INSR				0x1d
>   
> +/* RTL8211F WOL interrupt configuration */
> +#define RTL8211F_INTBCR_PAGE			0xd40
> +#define RTL8211F_INTBCR				0x16
> +#define RTL8211F_INTBCR_INTB_PMEB		BIT(5)
> +
> +/* RTL8211F WOL settings */
> +#define RTL8211F_WOL_SETTINGS_PAGE		0xd8a
> +#define RTL8211F_WOL_SETTINGS_EVENTS		16
> +#define RTL8211F_WOL_EVENT_MAGIC		BIT(12)
> +#define RTL8211F_WOL_SETTINGS_STATUS		17
> +#define RTL8211F_WOL_STATUS_RESET		(BIT(15) | 0x1fff)
> +
> +/* RTL8211F Unique phyiscal and multicast address (WOL) */
> +#define RTL8211F_PHYSICAL_ADDR_PAGE		0xd8c
> +#define RTL8211F_PHYSICAL_ADDR_WORD0		16
> +#define RTL8211F_PHYSICAL_ADDR_WORD1		17
> +#define RTL8211F_PHYSICAL_ADDR_WORD2		18
> +
>   #define RTL8211F_LEDCR				0x10
>   #define RTL8211F_LEDCR_MODE			BIT(15)
>   #define RTL8211F_LEDCR_ACT_TXRX			BIT(4)
> @@ -123,6 +142,7 @@ struct rtl821x_priv {
>   	u16 phycr2;
>   	bool has_phycr2;
>   	struct clk *clk;
> +	u32 saved_wolopts;
>   };
>   
>   static int rtl821x_read_page(struct phy_device *phydev)
> @@ -354,6 +374,53 @@ static irqreturn_t rtl8211f_handle_interrupt(struct phy_device *phydev)
>   	return IRQ_HANDLED;
>   }
>   
> +static void rtl8211f_get_wol(struct phy_device *dev, struct ethtool_wolinfo *wol)
> +{
> +	wol->supported = WAKE_MAGIC;
> +	if (phy_read_paged(dev, RTL8211F_WOL_SETTINGS_PAGE, RTL8211F_WOL_SETTINGS_EVENTS)
> +	    & RTL8211F_WOL_EVENT_MAGIC)

Given that phy_read_paged() can return an error, should we not check the 
value return is greater than 0 before ANDing with RTL8211F_WOL_EVENT_MAGIC?

Thanks
Jon

-- 
nvpublic



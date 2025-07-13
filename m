Return-Path: <netdev+bounces-206426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D7DCB03157
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 16:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0EC23AB6CE
	for <lists+netdev@lfdr.de>; Sun, 13 Jul 2025 14:05:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 729141F03D8;
	Sun, 13 Jul 2025 14:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="a3lvkuWY"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2079.outbound.protection.outlook.com [40.107.237.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF4987261E
	for <netdev@vger.kernel.org>; Sun, 13 Jul 2025 14:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752415529; cv=fail; b=PNANtMXuXRefpHQT8c37dM9KxAP1KIOSWJLBx3PM4nCevepr0bnPMEdq0ROQ2YVd/7oDVUeFjM9THCj16j9qE0X0xD6fGpNegQaQhhn92PIxOM6bTexduRZ6EFcbGHZJtJPGY5o5fj7nQCc+9quwhcGSQ7w8FiFrnZkOLQvWU5k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752415529; c=relaxed/simple;
	bh=UsrcKIv0ixGQXdu2W0X9YBiA0Rrl/WBK1h8FFQyGp8s=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=i0ITXmeNJh1G7MmwCcvOv1ExkBQq6lufJpJ5YsjrqNH8x5yALePlOKdQZkVrfRsM0Vqzc9u9PwsVJ2UTSi6gdlD7Wv4d0jl1viAvyU/73N7oLVK7DkLLbB1/t2bsEXk4JK2y4RqUM4iwJxlfP39aMUM8Rt0uupCobxRuXAXyJWQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=a3lvkuWY; arc=fail smtp.client-ip=40.107.237.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SHYuA9bWOo/HShu4wsFbkTTN2Gm5MnXIpshyy5bdh0UZ54WJM/OaLhFi77abBLatthVOA3H5TGNWlxi/HMbidMSQNb3QSI+xON59BkJQVVepVwQseqHko+mddAVMaRPnNYwa9otIqrulH0ugPijaYC3q3HWe32dkJqsiqJ16z3KY7QfwT5XEMkCZ7EAul2Vu6lZQp6nxiQqd/cs13sZGlGhqS5Rq1+TdAUIrVyLZ7+9XgZORmFKFrFHxBeOhBl1d75qOKkmWN3F/3ES0v4oezjfinsbXESNgdrk5PCbT0GgKDIpYdXq85G/WVLk1+SKc8VQF2/s1BwcaDVerVbHHCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4M5iaCLOAWB2/YfqFLrrifB6mFgAst8U5XAwiqpbABw=;
 b=FkmCTqziTFk0Ng7dXgsEMry09Y1LtBRoZBPIa/KOlok1OBb+yT3P1SIPus0NM35WH2mC9A8MGBdVs80r4kBMIwZbYaIWtkYehdsKR7VaYsN8KONhuawyITD1nrbDg0sUDgrdQg8zbGG5i75hngKwqcfQ8HCpO6Rr3Xg1JHohci+zO6+W+L4xs72l+0jECbuqEIFQ1Hq/JQp+z+O41N/epnWDrgzQC9e4f6ZKB98O3cn5xo/gDOFxJd/gONAHWES0xJjws1ZNJpfNWsFpg58YPWbyn4xhTHmZDmT67QJXZSr4IiI/9MrnB0q6WoTjEfeb5Ip8vqkuV6ivzmhFBj2rSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4M5iaCLOAWB2/YfqFLrrifB6mFgAst8U5XAwiqpbABw=;
 b=a3lvkuWYhF67Dc6hV69oY0ZENNoISD+SKUz9zMM1jSozAkrViitED3jAMtx1XFm0WbwGYzr15m0KMnU4kKb51c6mzKfGvIUcsFjOG9HBBj0l/NYL9Ky983HvMHnRZwJHtq4tqI7/JnogZalYpzq4x0Euc9KoOq8WKq7LOuFw88vblGhWeXvKR0sYascsh8KPfBb7gAMDHHWi2qg1PSNCUSHDXMLWew8q/EzG6n9/vjJpaSbJTx80fPTkKG/IeYLjqHXSFGN6TLNFp411NO37G7Nz8ga26tpkWFEgWGX2OA94r1gFhC4XMzLC8rqKJLm5aW5dR4B4vQAjJz5i0qDGSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by CH2PR12MB4152.namprd12.prod.outlook.com (2603:10b6:610:a7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.28; Sun, 13 Jul
 2025 14:05:24 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%4]) with mapi id 15.20.8922.023; Sun, 13 Jul 2025
 14:05:18 +0000
Message-ID: <5d8d0616-9cd0-4bf6-b571-e88e4364b35a@nvidia.com>
Date: Sun, 13 Jul 2025 17:05:12 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/11] selftests: drv-net: rss_api: test
 input-xfrm and hash fields
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, kory.maincent@bootlin.com, maxime.chevallier@bootlin.com,
 sdf@fomichev.me, ecree.xilinx@gmail.com
References: <20250711015303.3688717-1-kuba@kernel.org>
 <20250711015303.3688717-12-kuba@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250711015303.3688717-12-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: TLZP290CA0003.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:9::17) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|CH2PR12MB4152:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f07d967-5a6b-42ff-d419-08ddc2164c5b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|366016|7053199007;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?TUhhOGRkd2pxVHUrbGRQeTB3ZVBuTUhsbmZUdCtwdGw0bWtYZjdLcVB0T25Z?=
 =?utf-8?B?VG42N1U0U2MxK3pKWXp1SU1hREs5K09lMHUrU1R1eGt0ZlpyN09XVUFmR1Rp?=
 =?utf-8?B?aVBWWVU2RlA0clhHTWlLV3VXc2xFM2wrSE5FRWcxMS9WNHFaMGM2akJpNE5j?=
 =?utf-8?B?M0lxemFta2sydmkzeG83V2hsMzM4eDlKU2FUQ05mcE9yYTBLbEp5ck1BZkxs?=
 =?utf-8?B?NWVZS051MVh2bFlRWW1aMGRNUEpBdVdBQlJuUFNPQWc0RGJoQXUrNXV5NHhL?=
 =?utf-8?B?bGV4TENldVphV1RCQlNDN3l6Y3FJQTZBUjRCZkd4SXZDd01MNmZIVnNpc1pR?=
 =?utf-8?B?WUdSWklxMEo1bmhob0t5U295Y0M3bDVYMGk1bzhncUkxSTVVWXFPVlBKUE9V?=
 =?utf-8?B?MUdSOUluTE1nNXZtTFVna0xQangyVC9SL05WaFZUT3dWZXhXck11S2NjMjA2?=
 =?utf-8?B?ZUVkeUVuYzltdllwNjR6anRxeEtycDR3bHk1TmdnT2FBS0R2Q1dlZStQaWtx?=
 =?utf-8?B?TTliMFA5RFVHQzMrdC83ZFkyK3NTNE1mS3UvSnQ0ekx2RTNUM0p2dlpOY09t?=
 =?utf-8?B?Q1N1OFFER0JjRGc4b1UyM1RDbGxKOXBVNTNFcUZoNHo1dnB1TU5YampnUnpm?=
 =?utf-8?B?RWJGeERtTXJmZjZhSXZVZ3pOZ1Y1eU5lcWUvU1VNOCttaGpCSXZKQ1Zpellq?=
 =?utf-8?B?V1BxUU15alZWKzZiQjhNMVNRZ2JvS0I4RXZTWTZCS2x3Y2xVdzRCTHh2Uk1r?=
 =?utf-8?B?N1o4OWtaWUpFYVJmVHJWUjlQck5NUFErc0hLQW5yT1ZBZXJHaW1ORDhyS3Vs?=
 =?utf-8?B?WVVMZVpRQkRmVXl4ZzZwaytIYU5pRVhKYkxjVEthWDJzVWZTa25yaEg5UzVi?=
 =?utf-8?B?S21nUHNTSFJSTXc1ZnY2a2ViMnhrSFp2ai9pckRlZGYyeWpwWlRZTWNhK0t4?=
 =?utf-8?B?SzZvUlkzUWV5Ky9Wd090Q2g5Q0NPZjEyY1llR3dyU1JaY1oxOWtNRC9uVVRG?=
 =?utf-8?B?ZFRFMFdiZzlzekxZYmNIckNUdGZ3cVduT2dQYURsYkNQQ0J6VHEwT1dxdlBv?=
 =?utf-8?B?VjZPaTVWOHZwbDY3RHg5VzlzcithZTVnZE5HVVNJY245aWcrMFByRmQ0R3R4?=
 =?utf-8?B?SkRubTlpTGxIUXBpTnhnMU1za3FaNnZZdTZYWmRjdzVXNXFicy9SWVZmRkNv?=
 =?utf-8?B?bktpV203N1NBQnFkaURYVDNSRHArWk1iSHpPRXVmZldGMy9kcTBhM1hWNVZq?=
 =?utf-8?B?ZXJXU3J3bTVDazBiWnZiQzVzd1A3dWZQWXpyM0NzdFZKSzFqMDNxYVFEMS9J?=
 =?utf-8?B?SnRGa3RpNUwyS1RpS2RrQWtxQkl2ODl4dEtRaHh3RFprd0RWS1ZVM21aREcz?=
 =?utf-8?B?VWpncERUZVZPTFkzYk1nU3Mvb1M4dExzVzFMR3pMRHR2eXZHenc2c1BLUEtC?=
 =?utf-8?B?TmlBUTV2Q0lkNVd5L0RKcy82U0M0Ty8wZXAvanQvYm9kbW45MUZVU0JvMnBz?=
 =?utf-8?B?M0c3cjVVVFc1OTVmUkt6UHM1M3NYcytGT3VmQVlJSGJPdFl2RFJVM0Fwa0Ri?=
 =?utf-8?B?WXpySm94bVdYajRFdE5DdTAzRzVOZXVUeFVzNWlraTd6UXRObk5iclhJL0x6?=
 =?utf-8?B?R25IYjRBWHNIVUl4R2VNMWxLOVZiblFrbUwveHRYbU5HajdzZ2JIWGkrV2o5?=
 =?utf-8?B?UlRVS0hJT0w4YkdneVBCVk9Ea3FvY002RjVUaG53RHlVSGNoQ2xyK2MvRTJN?=
 =?utf-8?B?Q3NFTnQ5a3NWdTFXZHl5RVU1OGxydVFNbW9pOVFCZy8wWTVZVzhIK3YvK0hq?=
 =?utf-8?B?dUxwTHM5eUo2WjBveUpVbXlIK2JWMklZUWJGbHZsNnJWb2x0d0l4Qmd5U0RB?=
 =?utf-8?B?OGw5a1NEME5HUkJmMldZRVZxN0cybzlUSDcvTkFUaXlFSEhLUnBqK2FxSTQ2?=
 =?utf-8?Q?anraU2CSnN0=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(366016)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?U3g1U0U3d1NLN01pMU5GMjJNL1FVaDVOcUdjVElZVzF0S1hLMHFJNUpZVy8v?=
 =?utf-8?B?WHJKRUxVMWdnZ3ZzV0xxZ2pmS0E2di9hSVJWbXZvVFJGVG9IQzZpYk50YWZu?=
 =?utf-8?B?UVVscWZvMVpYd3Z2czNncVNFVk9GRWZPS1duT0dnN0VMeEE3OHhrL1V2eUJU?=
 =?utf-8?B?b1lLN001dHlkZWpEamk5L01VREFuR080cGozeUIxcU5KWloxYlR3b2M1d0t0?=
 =?utf-8?B?Q1UvWk45ZFRxb2tsQm9ya05uZVhDWXhXNnR3eC9nLzJERk9ZRE9KOHkvVng4?=
 =?utf-8?B?Z005RGpzUkp1WEM4aEUwN016RCtkR3JkY2Vubi90d2lvQXZobVZBTjgzMk9D?=
 =?utf-8?B?VnFTbnBnRThVS1k2RVA3WTBpdjlrMUZvNjd1QVI2VGtxVUxMQTJ0OWtLTis3?=
 =?utf-8?B?N1g3Q0Nab0hwOTQ1Q1NrbjFQV1hPQm1RdkN6SXR2T2RJQWV5NEw0UThzbWVi?=
 =?utf-8?B?OHFYVjNlUlhUaUlQVTNNTExWbmxFeFdvQkRrQ2ZDMmRpeHFocjgvOTFSQksr?=
 =?utf-8?B?M1F2SkVLc3htdTlFT3NwSEJoOUVkaTA1NUxJN3dldHFURlN2UHBxTlhpaUZC?=
 =?utf-8?B?UThQb0JlaTc4KytQNVFyV01nUW14b0V0WGtSekp3MFplQnBkNmhEaWhkQXJm?=
 =?utf-8?B?WUpxSGNPUEk3L1M1WlgwNWJvY0JKczJCU2dvbHhyN3J2aUFqSENaYlE5MEdQ?=
 =?utf-8?B?ZHpNWnMyMlRPaTZ0Ump0M0JWcVBaem5WSlNBQTdoKzUxaHkzdXJlMEtLSFg5?=
 =?utf-8?B?NjQ3ZFRwM3RPOGpKMHpoaDA2SXpUUk5nQXFMRkFRa0F3ZjM1UUlmdUx0a3F3?=
 =?utf-8?B?ZDZSN3JTZWppd08vcG9vR1hoZkxKT2s1UGxvS1pKc3hRYndtK2xNTWExMUFv?=
 =?utf-8?B?RGVGVVlhTExlb3IzbU85LzRaMUNvM1VuTldUTU1HTjdtMHY4V1hsS3JMKzBj?=
 =?utf-8?B?NGxwUFZ0bHpRRUZBVVdheVUvelhPMU9FVXdoZVlXb0RaYXllZW9pQXRmNWlv?=
 =?utf-8?B?M2hrSjM0ZGk5ekt4MDR4Um1uVVJ2UXY3V0Y5elV5T2kzSWladW9BQzVGT2R3?=
 =?utf-8?B?SWdTQ0l5RHRwcStCWGhrbkMvYTEwcnJEdTFnaVZZa2pkanBHbnU4b3M1TElz?=
 =?utf-8?B?UGJDVEllUURPcFhQZTdyODh0UW5paFVFOEZrVGJaWnhyNnhxa2d3MkQ3Rm5T?=
 =?utf-8?B?NFFYbW8vU24ySUlNTFI5Wjc2djFYdEd1RTd5eHhVc01rd3pkZXc5alBDN3A5?=
 =?utf-8?B?MjhYY2pHbWc1TlQzTEVpdDFKNmhOOEtMSGdDQ3dJcXV0Qk5IMjRmbHQwNEtt?=
 =?utf-8?B?ZjIwYktCZzdlc1BMK2tEYTd1bVNpNCtwSzU4Q1E1SUJVUHgyWU5TK1BVYWpE?=
 =?utf-8?B?b2VBZlF1UFl4WEs1SkFhbVQyc2dKR3E2NGE0bDZ4YzRQMHNya0JyeVJvQzNU?=
 =?utf-8?B?YURWQ0plbWl5L3k2QnN2NnJ5b3Z3bllmaVF3YTdlRllzaU9pWENIazNWeHNk?=
 =?utf-8?B?RCsyRDQvWWJsR24vY00rdVQ0UjRiL3puekVDQXRESGxmdjJxVUJ2ZU13dkJ6?=
 =?utf-8?B?NkE5Yk0vdzd5WWRJZjRvQkpXcG9ldU56V0VqWDdCbTFiTkxtYVJIR2kwY3RW?=
 =?utf-8?B?RjFLR2xCRVgvaHdwK1RxZlVQMHBpalRkYSt1RG5FckNzL1pLRXN2QzJoZE1h?=
 =?utf-8?B?S2ZTOU9CR0VWUVFVZk9lTEJDOW04MFhzMmcwTEt2VnlPSEcraHgweSszaGE0?=
 =?utf-8?B?OTBZM3R3M1MxRXg5NzB5K1BHQXovaG1vNmhCUGdyd29UZzlVZGpBVUpJS05Q?=
 =?utf-8?B?VFJpOVc0bzdweDNpT1l5WXYwME5CNUlkcnU1bHBocHRoRmpoTzYxSlp1cEZY?=
 =?utf-8?B?R1VjT3RjTmk4VlpvUTJHSHdsQ1IydmNaM25hVmVGU2lvUmIwMmFoNnhIYWFp?=
 =?utf-8?B?S1JVUEg5b3VTdFJ1Y1FlY0RQNVBWZW1TdHlTeE1nS24xbUpVcEprL0lmYjU5?=
 =?utf-8?B?T2dydHJvNXBqZS94RFg1cXRXK1JGVWFnV2JBNERnVjdtU0g1R1pNVjNjOXo4?=
 =?utf-8?B?ajBXdnMrVW5Xd01jSWJkN2NhMjlQV1owdVphYzNOMWlOUDZGdGMrRXJZN21X?=
 =?utf-8?Q?vDQyr77iVmnchz/dqvQBU5fe5?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f07d967-5a6b-42ff-d419-08ddc2164c5b
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2025 14:05:18.5247
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a0QnFFUpgORehQu0T9FqtcGLRyZfgcUN41SWPvRaUcevaCaIl8D6hH5iWx2h8p+b
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4152

On 11/07/2025 4:53, Jakub Kicinski wrote:
> Test configuring input-xfrm and hash fields with all the limitations.
> Tested on mlx5 (CX6):
> 
>   # ./ksft-net-drv/drivers/net/hw/rss_api.py
>   TAP version 13
>   1..10
>   ok 1 rss_api.test_rxfh_nl_set_fail
>   ok 2 rss_api.test_rxfh_nl_set_indir
>   ok 3 rss_api.test_rxfh_nl_set_indir_ctx
>   ok 4 rss_api.test_rxfh_indir_ntf
>   ok 5 rss_api.test_rxfh_indir_ctx_ntf
>   ok 6 rss_api.test_rxfh_nl_set_key
>   ok 7 rss_api.test_rxfh_fields
>   ok 8 rss_api.test_rxfh_fields_set
>   ok 9 rss_api.test_rxfh_fields_set_xfrm
>   ok 10 rss_api.test_rxfh_fields_ntf
>   # Totals: pass:10 fail:0 xfail:0 xpass:0 skip:0 error:0
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

Hmm, I'm running on the same device and getting:

TAP version 13
1..10
ok 1 rss_api.test_rxfh_nl_set_fail
ok 2 rss_api.test_rxfh_nl_set_indir
ok 3 rss_api.test_rxfh_nl_set_indir_ctx
ok 4 rss_api.test_rxfh_indir_ntf
ok 5 rss_api.test_rxfh_indir_ctx_ntf
ok 6 rss_api.test_rxfh_nl_set_key
ok 7 rss_api.test_rxfh_fields
# Exception while handling defer / cleanup (callback 1 of 1)!
# Defer Exception| Traceback (most recent call last):
# Defer Exception|   File
"/root/devel/linux/tools/testing/selftests/net/lib/py/ksft.py", line
154, in ksft_flush_defer
# Defer Exception|     entry.exec_only()
# Defer Exception|   File
"/root/devel/linux/tools/testing/selftests/net/lib/py/utils.py", line
157, in exec_only
# Defer Exception|     self.func(*self.args, **self.kwargs)
# Defer Exception|   File
"/root/devel/linux/tools/net/ynl/pyynl/lib/ynl.py", line 1106, in _op
# Defer Exception|     return self._ops(ops)[0]
# Defer Exception|            ^^^^^^^^^^^^^^
# Defer Exception|   File
"/root/devel/linux/tools/net/ynl/pyynl/lib/ynl.py", line 1062, in _ops
# Defer Exception|     raise NlError(nl_msg)
# Defer Exception| net.ynl.pyynl.lib.ynl.NlError: Netlink error: Invalid
argument
# Defer Exception| nl_len = 84 (68) nl_flags = 0x300 nl_type = 2
# Defer Exception| 	error: -22
# Defer Exception| 	extack: {'msg': 'hash field config is not
symmetric', 'bad-attr': '.input-xfrm'}
not ok 8 rss_api.test_rxfh_fields_set
ok 9 rss_api.test_rxfh_fields_set_xfrm # SKIP no input-xfrm supported
ok 10 rss_api.test_rxfh_fields_ntf
# Totals: pass:8 fail:1 xfail:0 xpass:0 skip:1 error:0

Also, after the test runs I see inconsistency in the rxfh values:

$ cli.py --family ethtool --dump rss-get
                'tcp4': {'ip-src', 'ip-dst', 'l4-b-0-1', 'l4-b-2-3'},

$ ethtool -n eth2 rx-flow-hash tcp4
TCP over IPV4 flows use these fields for computing Hash flow key:
IP SA


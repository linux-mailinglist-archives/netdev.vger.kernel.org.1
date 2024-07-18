Return-Path: <netdev+bounces-112071-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5D20934D1C
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 14:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BD90F1C21A8E
	for <lists+netdev@lfdr.de>; Thu, 18 Jul 2024 12:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AB8F137905;
	Thu, 18 Jul 2024 12:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="WRRo5522"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2062.outbound.protection.outlook.com [40.107.220.62])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DCF027448;
	Thu, 18 Jul 2024 12:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.220.62
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721305410; cv=fail; b=F6Ky7MwSv8suGTQFnBFufrYdTdjeobK4sbvY4G20bu0XJrdOPRB2sblnGTAvsgZxN1hDuWBjPfZNFMp/HgKI0TtnTHHuVnetGBFxxkHayMDD6207AZLPQ2iRw10/tL7ounjM7ncmFJi31zk0FumBbayvAndpi/H17hiMBijGLhA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721305410; c=relaxed/simple;
	bh=ljkIBnU3+B2jkGCgXAK3DrlplL9JfF0SPVxB7mTIKPM=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=H60wqQM8OcS/6FCgecbOk5p0XOM4cVs9d+1ZRSMcIvC7t6UaxoTJjt1u0Q5awXB/YN5oRS34ypc/g7cpmAU9RUtL9jvhSQYoNlg9Ip/NI431tvsTmrO38nV/mWBBHBdHdz/eP1jv+bJEWMUpijmwjtCqgIY558yWkSKcr1YuCe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=WRRo5522; arc=fail smtp.client-ip=40.107.220.62
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FFYM2lcv8vEZjW5bNSU7xLeUDaeO2PIxZGBEfSZ9gxBPIXyiW61D4xABJQmR4CUlGu4Et2w4ky3l8TOsb2e1qbEv2Myz2+aWTDh3qQWTXldkgtHeSB3Va8kU6rAZQFvRnwidUurkaHORGuNp+AbVsKkm9khxecdBnsoXIyuWGdmqE32XwOEYaZs0ehR3aoyOg+ItCfjUY2nMjsnI5jItdWHGyMC6fE2OeNbj5GSO/1WKCw6ufFvfQZsDatb+c05WD55qDjocEeSwcHhfQOlTfhh2VoQm1EnTENBUg+8+MP9dDYj+iQI39wSu1O6Zd5gVQJpzRXudpah3Hb7s2ftSZA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QjV96QruWOZdqPLMW5giSkQAZV2qWPg6CQ4LbH1KWQE=;
 b=VA7FhLNW8QSv42lDgFym5KPVULarBdXR6qFNA3h/g4f3IPCp8cPAYxVRlrCNTAvFLJ17cnll+9yIV1MoD37da5jAOkEkBBseBGNoGU/HZb7QhPwPIACk4JyYpw7uAiLrJQcf4JplQPM8szN7jNOrfy/k0FkKMrPQW3I3ay8VOxXsqQEkXk6PZTySSrdUxSmbobp7TqfH44KTQwRXHeWYRcyRNNz88kNixmqpMDcLMde4QVHv6lDMKWSYLcscBFNrLyowLL1P6keGw3E3EKYZBOabw6omV+n44WCUy9fPdFT9+9a83enJND6vMEOAnt1gWXsMJiy+1yBfUS/uGM2XCg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QjV96QruWOZdqPLMW5giSkQAZV2qWPg6CQ4LbH1KWQE=;
 b=WRRo55227siJMmZ7nKJG3ko4Gbo9Qn9fVHHWAHFWidJreVGysO2H47eFcmR7we5shQgqvUMhoMb3A/XT1CUK3Lvfff2O78c6PIUgunM5U1XKN0C14l1gOMuroQI4HufLy8lFDBxheFnN2Y8ARUaLlMAmDvD7BbQkpb16mvJghaK3jDPlSNqlMTLgLixgvO6MtRj6KkL9ZHQFEwiuLEg6l8dJLhowWTizu7R2ddU1LWbPDWDeuJYDvNZO6Utrwv/eD7HQh9v/JcAomREcSnzFaeliS/8HLf0je0elvXtj3OwpqiXiVquS4F5zgfBt0QW5qmwxzACWzVJ0BIqnNzXTsA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 CY8PR12MB7633.namprd12.prod.outlook.com (2603:10b6:930:9c::19) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7784.16; Thu, 18 Jul 2024 12:23:25 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%6]) with mapi id 15.20.7784.017; Thu, 18 Jul 2024
 12:23:25 +0000
Message-ID: <7c0140be-4325-4005-9068-7e0fc5ff344d@nvidia.com>
Date: Thu, 18 Jul 2024 13:23:19 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next v3 3/4] net: phy: aquantia: wait for the
 GLOBAL_CFG to start returning real values
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
 <20240708075023.14893-4-brgl@bgdev.pl>
Content-Language: en-US
From: Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20240708075023.14893-4-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0668.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:316::14) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|CY8PR12MB7633:EE_
X-MS-Office365-Filtering-Correlation-Id: 0388d46f-cacc-4793-d63b-08dca7246bc3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?djBIK29kQ3VEUWozdkJSWHgvR2dBSGZDTzYrY3hqaHZROEp6UTYzMDRwR3JZ?=
 =?utf-8?B?KzZ5OHliTHNXcTVhV1RtTGJaRm4zUzRFMURaMlZNRUVsbGJSSmR0TGppRUZq?=
 =?utf-8?B?N1hSSXRJdytzakNZUGRZVUV0ajQwQVBOcnB3R3JYSlM4elVyUVFkOWR2aExF?=
 =?utf-8?B?eTVxWGM5aDVwdWh0Mjg0THAyVnJMVW95WHg0VlhNQmtNVjh5ZDhLQVF0aWtt?=
 =?utf-8?B?YkI4Z0ZUSXVPRGNBajlYTkd4RkRnb1BDYVNDalRQSnJOYStDQzJ6ZGRMTmtm?=
 =?utf-8?B?U0xmUTZVaEFVYmhPUXBzVW15SU1EeVhaMm51dHFQN2pvNEdORlk0MytHTHVO?=
 =?utf-8?B?MkpyeGtNMVRvVUlMTkkzVVZXU0RNQnRxdHRvTEpUcUVxQTNkMkN1UWdTaEpn?=
 =?utf-8?B?VjFqOXE3RklpZVY3NjdqV05jTnFhaDJ6Y3lXM2VhaDBOTGhTWHljZ0JhMDVL?=
 =?utf-8?B?TmtaNmhJUmR0YTNrak52czFPUXhvWGdlbHFzclBZQ1c5OGFIWU1EN3dpTzV1?=
 =?utf-8?B?cTl2SUZMZkJoY2U5NVgwMWtRZ2FFcDBWcGtsWVo5RFRtbXlhQjVWSlF5YlRZ?=
 =?utf-8?B?cDh0UlFXS2cwNXVxNUZveDB0aWRrWDQ1Qk9XaEpyWFp4cDNTZG5xTzBJTnNI?=
 =?utf-8?B?U3FWYjVEUzRZTndzVEpnNUVlVms3WGc4akU2OVovRmVmNE9ENFcyK0d3dUNL?=
 =?utf-8?B?RzZpejlZdXIva21tcUl3WHdXS01PL0kzbXZsSGZNZTF6TWV1aUhDV1Q3eEZs?=
 =?utf-8?B?TUpsazdpd1diejZwNUViMEZpWEhNdW02WGtoaUMyRXc4UFpkMXdlSmNVN0cr?=
 =?utf-8?B?QzQ5VmNNTEtPdUxYdEUwdzJSNlZOQUh6N1pTaTJkbFJiVUN1RFJrakYxbGZi?=
 =?utf-8?B?TzhaTy9HSERYSzRITXcrRVpkNlVJeHozdDM4TEpnYm0zblhvZHlmakFVR3A5?=
 =?utf-8?B?Y0ZTSlJ0OGFDQy8rMm9EN2k5eVJ2SHBNeWRvb2tpMVVMWndJbzRwZGRTVXdI?=
 =?utf-8?B?M0lINm9YZXB6dTRNUEFhTU8vaHBFdi9OZGRjS2VBYlZwTHFNMnVINGNMM1Rx?=
 =?utf-8?B?SkJ3YzFBeDgwYWJEa0VOTVYwYW0wTkMrYzRMVWlnZmIvOWFvMnoySDl3azZq?=
 =?utf-8?B?VHVseXd0K0lCVGJmd1VTdmpLSjcyTDZEM0o5Zkh3Mk5DVGhWWXE3dktrWTIr?=
 =?utf-8?B?MHg1UTlmR3Iyd24wa2s0L05jTzFCRHZUVFVsd3lxNkN1UmtaZ2ROc1gydTNM?=
 =?utf-8?B?QlRmdzFsMmR5cG1PbEUvbG51bGlUOEZNRkllSUc0OUhxM011b2YwaHFaY05R?=
 =?utf-8?B?L3VOQ3dSNnV5dExiaGVzeXpBV1FJY3h2UXFqbGc2OElDSnNVNHhCeVVvUWNG?=
 =?utf-8?B?SENudTR1KzdUM0N4RGlzSHgwS0hCY1p5bnZ6emJOSnIrbFJNd3hNWnR1UVNl?=
 =?utf-8?B?S1l6SWQ1clBBWFYyRTQzbHkxYktTQXdFK2M3ZW16RGgxby9RSXErYTVZMnZG?=
 =?utf-8?B?SXlJN1J5UDhMZ29yYW8zYmNmQzg5eGN0OEkrS1NhWDRZeW9wMFFrZW4yY0Vi?=
 =?utf-8?B?dmVWY3FJWm0rSTN5eFhpa0RuMEQ0QkdZbEdwRFJmMDY0Y3lLaE9HOER6MFdL?=
 =?utf-8?B?KzgwTHJKbGhrR0pDQUs2dURRYUlubTRzVVNyWjZnUHBYdjNDNUptb2pJT0Js?=
 =?utf-8?B?RmVJcFdzdkVZakF2eFNYSHhGdEZXL2loeWRNWkZNNXZERGlJTDRkWXZWK0tP?=
 =?utf-8?B?REVLbXd6b2xZVlo3a1hKTGt3bDVOcWc2ODJ4aHMza1hsL0RaU0dTek9uY3pM?=
 =?utf-8?B?WWdQYmVtaTNOdUg5dTFsdz09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WnQ4emVOSEhJeGhSNnFzaUJyMlg4Vi8yU09lZkJMNGVTdCtEeG1UQkl5YXVv?=
 =?utf-8?B?S0x6V3F5QWp5NzRvaTJoekFuY01yakprTzdCT1ZWTXhBUFdTOEQ4L2IydW92?=
 =?utf-8?B?OVJVSGZoMWNGTGhjOHJDMnd6UHFRQ1hhb3I4K3J3c0hNZ2lsYUNCL0U5MXhw?=
 =?utf-8?B?NHg2QmE4MEdwWUVDZlVpQlB5Tlh3MnhwdzB4VUFhc1lPYkhEaG5VSVdXV2tW?=
 =?utf-8?B?UnhjdTNFQ3JpZE1UTGlOc3Vxb20zZFVkUFFxRlR5VzJ5ZFJHMlNjYVZEM0NY?=
 =?utf-8?B?d3BIdlI1L0hDdDV4dnEwSlcyS0R4RjVMbWMvdVY5OXI4dkdNOTY2OEJIQjcr?=
 =?utf-8?B?b2REdUxKdjA3b1c5WmkvTmtPUHZmMnk0QzZjZ3VEa09TcE9ObDBqSjdlUkY4?=
 =?utf-8?B?WVVNclRXVmFYM1dJOWtNWmRGS2VxMitlS3NiSlNnRGVNNkV0aEVIYkVzTGpj?=
 =?utf-8?B?TUdYd2dudFZsYkJKRGlRUnZlZG1iTEl6V3dsS3didVFud1dFLzFCdFczc0hT?=
 =?utf-8?B?K1pLRHBaenhGNU5pcmZqSEVjcEptMlFnL1ptVGkzd3ZPa1Y1cDZiOHJHdXpl?=
 =?utf-8?B?eUJJdERIM0RkaWV5eHpDV2RudnZqNHgyL3JZWnVUSTJvZUtLRHZrY3Z4RUFl?=
 =?utf-8?B?UlBENXZLUHd2TndjK1NDMjN0L08wV0V2Smh5aUx2TlB6bFVNTHlHdm13NTBM?=
 =?utf-8?B?V0lYaFN1UStMM0xJQ3pmZ3ZSUEpwc2VHNHZLWHFOOFc4K0padWYrVWpHU0s0?=
 =?utf-8?B?dFVIcE5JRXJBN250T3FWK0V3UHVkWExGbUJmelo4ZEJod0hUUFV1SVpvVmZI?=
 =?utf-8?B?WnFqbnVSRkd5QjBvRTZJUis1eHp6NjlOZllSM0t6ZlJ4TENRazJZRy84WUJN?=
 =?utf-8?B?N2hnT2VuZG5BNTYvc2VqTERoWW43eFRTSkZGdW50VitGQ0Y3WElsN2FQT1FY?=
 =?utf-8?B?V0M2S1JlaGFJRGlWOEh6OFVYSEs1b2FDNzk2ajQvc0VuamtUL1htOTZmZC9p?=
 =?utf-8?B?V3Bla3pHQ3VOZVVBVjB5d2szWGlYeVN1QzVVYWxoSDZCRmM0Z1pnTmxiSzZp?=
 =?utf-8?B?UU9UcElFcUpKQjNObHhubFBhM1FwQ2wyTHVCM0ViUWJTSVpCSXJpeW11amk5?=
 =?utf-8?B?UjR2U05wVmhacE1sZHM3cnlNOTlMaTdSSkVrMXNjTHZ6U0NvVVNkbGt0bmEz?=
 =?utf-8?B?U0JTR3c0SVpoUUFFWkN3NHBYQkNqRnR6VFlFaTZBRDJUdEpHNXF0dzF6WjRz?=
 =?utf-8?B?ODRuNWFXdGwvYk5VRU5PT254WEV4enJxWVJSa3RKRzlMbGRMdjNDZzZGT0Mz?=
 =?utf-8?B?OE9hQ1dKaTFIVDNVVGZlZVVxTGhzbnBYKzZtaGd0MFNwQkNzVFJpVEJkQXZY?=
 =?utf-8?B?WlllRXE4REIrNUcyaTQvR1lqTDF2ZExENHB0a2hwYlF2MmdnN1lHMXFvdzBr?=
 =?utf-8?B?WUh2ZlhQbkhJNk92N3BYZHMrbXVDVUVueDZTSGgyVVkwd2JqYmZZZWpyelFv?=
 =?utf-8?B?eXlYUGNJNXNUbkFHbExYOXdzSHNldEx4ZFRSaWkxM1d4anZNdjlQRzRkUmxy?=
 =?utf-8?B?UFF6Vy9mOGdNRDkycGRvdy9HTFdkdGkweUdsVEhIUjdpT3lyWDdwK0JsWmpK?=
 =?utf-8?B?bUg3SU5jUFRVZUU2U1RUT0xCbVd4cnpVSmxoby9teWIra2FxZW9GdGlUUHBB?=
 =?utf-8?B?UFhqTmFURlRHVUJ2MzRiNldNWXpVZmJmQlk1YzV4OUs3Q245eFh3OWVNQ3hz?=
 =?utf-8?B?b2YxZ2R2eER3MC9JM2xXVGRIbUxLRmowUFFRNWZzRmg1NlJTVkJVU2lJa0k5?=
 =?utf-8?B?aEpxTG9wNVo4bStWci9mK2lLTVI0aGFpcXJCbzVFaVRxUWUvWGVxc2sxZGsy?=
 =?utf-8?B?M0pJRXY0ajJEKy9tZXhBTHJJMm1xUzYrSjlJdEtaYVBTMDQ4dml6MVNONjcw?=
 =?utf-8?B?Qzc3R3ErNmdVTFRMY3gyL2x6Unh2SXIrc1NvUElGZi93OUpFTkk3NG91WC9E?=
 =?utf-8?B?MG5BOGRvSTh1MjdlZXcyNmlpQ3BDZzMrZTFKUFpieElhcGtwTGk3eXVsU3N3?=
 =?utf-8?B?Ulp3Zi9aRGl5dUczTjlOd2gvR0VjSjg0OWwrRjlCZTZ6TE9uS2dXR21ZdUc0?=
 =?utf-8?Q?I1BObhObLOxdDS5ynN4yGmwET?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0388d46f-cacc-4793-d63b-08dca7246bc3
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2024 12:23:25.0815
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: K5bRZAZrmANugULwiUsdM9+wMWmzc69kIiRB61pIU53wYVD6CfTcEOYWUMfWVy/6wZJ8vxyEaCatb1MScCdSPw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7633

Hi Bartosz,

On 08/07/2024 08:50, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> When the PHY is first coming up (or resuming from suspend), it's
> possible that although the FW status shows as running, we still see
> zeroes in the GLOBAL_CFG set of registers and cannot determine available
> modes. Since all models support 10M, add a poll and wait the config to
> become available.
> 
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/net/phy/aquantia/aquantia_main.c | 8 +++++++-
>   1 file changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
> index 974795bd0860..2c8ba2725a91 100644
> --- a/drivers/net/phy/aquantia/aquantia_main.c
> +++ b/drivers/net/phy/aquantia/aquantia_main.c
> @@ -652,7 +652,13 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
>   	unsigned long *possible = phydev->possible_interfaces;
>   	unsigned int serdes_mode, rate_adapt;
>   	phy_interface_t interface;
> -	int i, val;
> +	int i, val, ret;
> +
> +	ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
> +					VEND1_GLOBAL_CFG_10M, val, val != 0,
> +					1000, 100000, false);
> +	if (ret)
> +		return ret;
>   
>   	/* Walk the media-speed configuration registers to determine which
>   	 * host-side serdes modes may be used by the PHY depending on the


With the current -next and mainline we are seeing the following issue on
our Tegra234 Jetson AGX Orin platform ...

  Aquantia AQR113C stmmac-0:00: aqr107_fill_interface_modes failed: -110
  tegra-mgbe 6800000.ethernet eth0: __stmmac_open: Cannot attach to PHY (error: -110)


We have tracked it down to this change and looks like our PHY does not
support 10M ...

$ ethtool eth0
Settings for eth0:
         Supported ports: [  ]
         Supported link modes:   100baseT/Full
                                 1000baseT/Full
                                 10000baseT/Full
                                 1000baseKX/Full
                                 10000baseKX4/Full
                                 10000baseKR/Full
                                 2500baseT/Full
                                 5000baseT/Full

The following fixes this for this platform ...

diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index d12e35374231..0b2db486d8bd 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -656,7 +656,7 @@ static int aqr107_fill_interface_modes(struct phy_device *phydev)
         int i, val, ret;
  
         ret = phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
-                                       VEND1_GLOBAL_CFG_10M, val, val != 0,
+                                       VEND1_GLOBAL_CFG_100M, val, val != 0,
                                         1000, 100000, false);
         if (ret)
                 return ret;


However, I am not sure if this is guaranteed to work for all?

On a related note, we had also found an issue with this PHY where
the PHY reset is not working quite correctly. What we see is that
when polling for the firmware ID in aqr107_wait_reset_complete()
is that value in the firware ID registers transitions from 0 to
0xffff and then to the firmware ID. We have been testing the
following change to fix this ...

diff --git a/drivers/net/phy/aquantia/aquantia.h b/drivers/net/phy/aquantia/aquantia.h
index 2465345081f8..278e3b167c58 100644
--- a/drivers/net/phy/aquantia/aquantia.h
+++ b/drivers/net/phy/aquantia/aquantia.h
@@ -20,6 +20,7 @@
  #define VEND1_GLOBAL_FW_ID                     0x0020
  #define VEND1_GLOBAL_FW_ID_MAJOR               GENMASK(15, 8)
  #define VEND1_GLOBAL_FW_ID_MINOR               GENMASK(7, 0)
+#define VEND1_GLOBAL_FW_ID_MASK                        GENMASK(15, 0)
  
  #define VEND1_GLOBAL_MAILBOX_INTERFACE1                        0x0200
  #define VEND1_GLOBAL_MAILBOX_INTERFACE1_EXECUTE                BIT(15)
diff --git a/drivers/net/phy/aquantia/aquantia_main.c b/drivers/net/phy/aquantia/aquantia_main.c
index 0b2db486d8bd..5023fd70050d 100644
--- a/drivers/net/phy/aquantia/aquantia_main.c
+++ b/drivers/net/phy/aquantia/aquantia_main.c
@@ -447,7 +447,9 @@ int aqr_wait_reset_complete(struct phy_device *phydev)
         int val;
  
         return phy_read_mmd_poll_timeout(phydev, MDIO_MMD_VEND1,
-                                        VEND1_GLOBAL_FW_ID, val, val != 0,
+                                        VEND1_GLOBAL_FW_ID, val,
+                                        ((val & VEND1_GLOBAL_FW_ID_MASK) != 0 &&
+                                        (val & VEND1_GLOBAL_FW_ID_MASK) != VEND1_GLOBAL_FW_ID_MASK),
                                          20000, 2000000, false);
  }

I have not tried the resume use-case, but curious if this may
also help here?

Cheers
Jon

-- 
nvpublic


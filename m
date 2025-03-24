Return-Path: <netdev+bounces-177100-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C67A6DD84
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 15:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46F921890248
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 14:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A689425FA39;
	Mon, 24 Mar 2025 14:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Js4TLbXw"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2084.outbound.protection.outlook.com [40.107.102.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05F6E2628C
	for <netdev@vger.kernel.org>; Mon, 24 Mar 2025 14:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.102.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742828183; cv=fail; b=Z7Yr0mcToLLEfM7vmhwu9K7iBsednxGuD2nZ+PPVOvesMDdsQi1T/yWa3byLG+gGMbUAcoakZX1F5IU7YCgfkU/gVGF7B0HYDCxwudwzyxmGevBdnfZVDQvsDe2Qhj5ojTUCr0I0zb5oYlboZZLPd3L1ggV5gF+WCLu3iUKHkBo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742828183; c=relaxed/simple;
	bh=ICuLKZdtb06Expfw9+k5zwyah9Md8Q1g3SuKTH1PQxQ=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=gybR8Zdz8sXwWt/qk38kvqXg5nJ5GCBU3CawpOYN8XJL3Xt7Qg0UW4zZzwm8O3eNv/40M51QOY98Ighea4cLHinKHrh16XWLwDO5OeUhnJ/jQl6ox1iCGNBhVUnU/8dUC4m1Oaf7BNoquUckqn7mMoSW6+AGyZdtuD2nKyZ+324=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Js4TLbXw; arc=fail smtp.client-ip=40.107.102.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oqK66nFUy0DzDBcevwtXqG1mV+CGS+q0CaOibpB3cXVPLJ5BbnL57ZT3h86KAeWHn9yYqc6O68Joa5rJdzpXZ98JQerJfYHed07Vubia7DTgj87ZBUOi64Zrv7VeQW7W4JyS+S0Y7j8zs+l+rdO9a1Mg3QmSBVrJHdF7ClfgHzFggKYrjXyuJs13VhmM+xh98TiwvtWw8qwrVtdUlOmigJh3NiuhMpd2x/m3wBe2x5ulhj0mQ9jVUV0uaETYYYlpqAsDcxAs8ek2g2FPNY6WvjS+IA+ZLHP5FaJ/L+tYr4rMHFVz5YRddlI/kJY3Tm9RNaZyG80M1BgU6oy+HUhBtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6HKEYyE7zh8O8xji+ErycOOnniia1y25ZtDrMc+ZHuA=;
 b=VO8c+/+W0p14boAuaZq7U+rInuJM80RkaOpmrbQSBckLi5vK22QmUhf5eRmLWryW6Dc1C5SOukHXonhh5UdyOBsb6eg9/J1Kfgc+qRrUUDthMDZOM521HyybcNiVzc8m0HskkzeYdkxXlkRaaHgoSwRLlIdtaQ4zCTmmfnMseSPk/u3gO7ZkZyYroH0LabPk9uKg5kdAw5ByRNhU3L3EHwNG3iyqm8NNxno23cK+mEKO69O2Fj68SoCPlCT5UrKoE0yCudDqsHY1CQrAosuwlwMzN0prMjG+eGNBvv0G3lXdMvstO0Rxjqmn0W5yYkjm6G0apWdq6PsqD4mfIT4FDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6HKEYyE7zh8O8xji+ErycOOnniia1y25ZtDrMc+ZHuA=;
 b=Js4TLbXwSRHzggystm7TMCY6agNzBe0sfMvSrvuNM4PRVB/22q9r0rmtu2dtF5YRPR2DB2C17pSvmkaLWrIzBgQEW2CcHTvKzn5kRg965p/UQndrwiGOOYIwS0UaU0cYhFp6OwwmRSn24Mbm7R5gmT37PdROEyms1/0xoTP+8YYR6+oe65X/PRUISv3UkI+MYaWmUhN8fqtcd0r9UAHDX3C1kpZ37CVBQv+sD6Zz+2QAoPu84UScaICk6rvgvjwdpt167R5+YbygHUaFHwxvSZzU+JCqO0785yhoCb4mGsOLaH3RzstjBhcHXuymtfRk5+SRv3X+tv5cAez7DgEKDg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CH3PR12MB7500.namprd12.prod.outlook.com (2603:10b6:610:148::17)
 by DS7PR12MB6311.namprd12.prod.outlook.com (2603:10b6:8:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.42; Mon, 24 Mar
 2025 14:56:19 +0000
Received: from CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2]) by CH3PR12MB7500.namprd12.prod.outlook.com
 ([fe80::7470:5626:d269:2bf2%6]) with mapi id 15.20.8534.040; Mon, 24 Mar 2025
 14:56:19 +0000
Message-ID: <a22eec93-c029-4dd9-8355-9a2e01f64f22@nvidia.com>
Date: Mon, 24 Mar 2025 16:56:13 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] ethtool: Block setting of symmetric RSS when
 non-symmetric rx-flow-hash is requested
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 netdev@vger.kernel.org, Simon Horman <horms@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Tariq Toukan <tariqt@nvidia.com>
References: <20250310072329.222123-1-gal@nvidia.com>
 <f7a63428-5b2e-47fe-a108-cdf93f732ea2@redhat.com>
 <9461675d-3385-4948-83a5-de34e0605b10@nvidia.com>
 <9af06d0b-8b3b-4353-8cc7-65ec50bf4edb@redhat.com>
 <eb3badef-2603-4bab-8d7a-c3a90c28dc64@nvidia.com>
 <20250324073509.6571ade3@kernel.org>
Content-Language: en-US
From: Gal Pressman <gal@nvidia.com>
In-Reply-To: <20250324073509.6571ade3@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR5P281CA0045.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f3::12) To CH3PR12MB7500.namprd12.prod.outlook.com
 (2603:10b6:610:148::17)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PR12MB7500:EE_|DS7PR12MB6311:EE_
X-MS-Office365-Filtering-Correlation-Id: addfddc8-409f-4f48-9c93-08dd6ae408ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|376014;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?WGx1NUdCdVBRSFd3LzQvQVhhRkpjSTFoUXh1RXhTL0lRSWNVOXNoUjRXc1NQ?=
 =?utf-8?B?QlNUbytJeVpxdGFWd0hUazJqaTFnRzdTR0NMdGpBaDdOSlZIdWVUOUM4WU9x?=
 =?utf-8?B?YWlUeFlraVJ6c3VyUExjUWFZN1dBdTAySWxicXZZaW5XMTVFUWN4ajJTZFR6?=
 =?utf-8?B?bis0dG9qc0ZTQ25mLy9uWVpGaFp5SFI5TEdXUVQ5aUY1SlRDU09xSmdkd0hy?=
 =?utf-8?B?Z3JXK2UwenRQc2hUMjBCSGdDY0lXWG1rYWZ6NTdTODNwOGxRRWk2MzBwbytL?=
 =?utf-8?B?M0dPMklndGZ3TTJzZVl4L085L3dKZkI3dnNMWTRCUzZOaUVDV2JIOThwT3BG?=
 =?utf-8?B?Y3h4U0JmQThqeitJUHVZTmpRdE1IblRnWHVmVHNTaFZCWTVxdXY0aDdGR1J4?=
 =?utf-8?B?WTgxc3ZsTjdtUEhqUmxpN25SZWFKOFB5ekdWRFVaV29Nek9jRCtlb1RTNGJC?=
 =?utf-8?B?dFliSnVNcTdHOU5OYm5IR29RV3RIZHZqQjRDa3JHOTFGOVJXdm0vOGpYbmlG?=
 =?utf-8?B?SkhjVVZQeG5SckRFbXBGRXFNSDlHNkNxWmpnYlppWGxHYS83S1FKc1dQaUow?=
 =?utf-8?B?STNicGtCdWZyTGpGbkMzaUovRkd0L1BXN1dOSkZOTEZybE1hWWdOd0xUalRx?=
 =?utf-8?B?azVJZzl0dXZObVViamNPS2FOMDRIVzhJNDZuNFNtLzFReWdmQVJyRW01NUw1?=
 =?utf-8?B?Z0VEZitORW5wbXlXREQ0UjRLZjdxOVNhVW1IdWNFaUhTUlI0T2xZYlpZT2Vq?=
 =?utf-8?B?dUZldFhiRyt4d3BwQXRjK0R6UTUzMmRqTU1ERGxmcTl2dkJBbk9wU1R5TEpZ?=
 =?utf-8?B?aTFwNmtjbS9LRy9HM3hPTkdFbTN4VitqVE0wLzRJUUVxM01ROWZoS0pQRVpL?=
 =?utf-8?B?S1FOb1hwZVFCNmlMK0VaN3hjVjBQa05OUFpnaU84MDJKYmZQdzRQY0U5K0Z2?=
 =?utf-8?B?Qy9xYVo1Y0pmbjZpQXpmY0xmVDNSWEU2UFZVeEMvNG1sOFNyWUszUXBGVFh6?=
 =?utf-8?B?MlZZeGpwRUZKZ2s1aVBDRmlaNkdVOWpmcHNrWWVaNWczSy9vUVp1eWxnRjF1?=
 =?utf-8?B?cHFFNXhUcGx4WHZQWHRTSmhKRUsyY3VmaDZUNzVKN01wUGRaVVVpWFc5ckpT?=
 =?utf-8?B?V1NlT0xVQ0VtYTIycE0xcm1kMzV4N3YxcFZHVEg2NmpCME41VndxZ1BuM1BV?=
 =?utf-8?B?aUdZc3RMWE5UejN1c3RPbWE1cWtNL1AwSFFlcnloaWlKQWFBUDdmenJvYkl4?=
 =?utf-8?B?U2dhdWRsWGxRUEl1MzR4bGlQK2hpdm93OFNtTmNoYWZuTEdBajJ6Y1lWb0xF?=
 =?utf-8?B?bHFmUXY3eGduTkJUeGxXcElSeHoyRFpLK0VJS0M3TjdUNm83Wm9WQnFVSmtH?=
 =?utf-8?B?eFpEV0dhNHFGem42UVo3R29HMm5WT2ozbHl4ZnQ1M2pwSHhiTVByejVDZ1gr?=
 =?utf-8?B?V3U1R1lnYVFiK2JrR3JldWNpa1V4akpwdDdLMjhkdEt2KytVWlFIZnlQSjJS?=
 =?utf-8?B?TzRKZFBKcXRlVkM4dUlWN0xWN0QrZHVDMFZ3dldPRnd2VmpiR0NRTDBPSkFj?=
 =?utf-8?B?bWoxRFh6aUhpcVNjNGVZMDZ2OTVieU9DeUdwdzcyMEkydjNVOVpzbTRGZHI1?=
 =?utf-8?B?aTE5OE5QTzlBeVBpaStSeWVlc2Rxc0dqems4VGNtV2VGVHBYK25sY0E1bzJ0?=
 =?utf-8?B?ZmVGK1NoeTFGb3FOYk1oNkJXd2NCVnRCdnlXMGtaZVp1V3VqZWJBWlBkUVps?=
 =?utf-8?B?c09GZlZJcVk2N2NQVFhIaUN2c2VidWVXNEpqTG1OKzk1Yjh3WmlIMzJVamk4?=
 =?utf-8?B?OHNiRkdZOUdadWwzTzRJajI3cEFZUFM1OFJjSUcyQnJqdlA5WmY2Z3RlbUpD?=
 =?utf-8?Q?V66BgZPmEBXoz?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH3PR12MB7500.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MTNBUkxLUzllSGFmd0NvRng4MU1kSHJ4OTFreWRyUE1mQkNhZGNrZjc3SHNk?=
 =?utf-8?B?ZXB5UEY4UERJZE9jakFZVmhic05nY2JXUk5kbFNLWmtJa09PazVES3c4MHpE?=
 =?utf-8?B?YlljdEF1NjNoN091K1RMbmlYRGQ4dFBXbitjZWl4ejJCeXNvem9CeUZrUEsv?=
 =?utf-8?B?QjVDTktOc1pBQW4vT1daUjJpMjJMVDJaS0xqVDJVWGlRcGg3d2xCSllEczd3?=
 =?utf-8?B?dmFZbUlzbExYckZZR0VCN2xja3Nrd1pzczFnYUJNQTFraFF1R1B4L0xhM0J4?=
 =?utf-8?B?UWdqMGtjMzN2SHdiai95LzkvcVJxYTk0UzNhTndDNFh6Uy81Uk5xc1I4Ri8x?=
 =?utf-8?B?N2c1KzkrejhSQWRRNGpwaUViOUhtSks4QlhOeEhYYXVuaFZ1Z0lCNEtuVm82?=
 =?utf-8?B?Y1FzY1YzdHlWaE9HOXZWUHZrS3lvT1V1ZDFER0EydjNrV2trellrQ1k4RWVa?=
 =?utf-8?B?ZEFkK2xLNnBlM1ZvZDI4U0c1Njl1bUsyWlNldXFOelAxSlRwcWQ2Y2p3YTIz?=
 =?utf-8?B?RUpqNHlKakMzZ3RqNi9QeEFHZUJuRld4QkZCclFDTXorcVNtQnpWTnpoeE5x?=
 =?utf-8?B?Ulo5bzN1bm9TME8zVkFZTEd1QjZOYk91THAycXI4Sm1HZFNET21RMS9zcHVP?=
 =?utf-8?B?OXptRlFveTVoK0c5cklqdjNaeHAwOGY0NWVxTEZQTXBxZnNSN0hMbjNMZmJT?=
 =?utf-8?B?WWVSaUkwWFZOdjRHM01WbSs1Zm1YU1NtODgyTElKTUlqZitaeWlrWGxROVho?=
 =?utf-8?B?aGVIOWdBakRFd1YwMFpUUElQc0tMTWRkUFpzakZXUEZFcGd5YzhJSFJxZEFC?=
 =?utf-8?B?cm1xc3NjNU0rdDUxbmpjOVY5T1d5ODJFWnBCRWdFT1VuZms5YWlRaC9UTVdH?=
 =?utf-8?B?eFRGQzgyVFZTRnNzajF1b2Q1MkNjek03MVcxN1JhWUsybWFDQXlVb2s1N0tx?=
 =?utf-8?B?MDlxR2tWN2NRTDNoam1SL1dEc2Q5SzM5NHc2MkdDazVjRnFwWnZUR0w3bWMz?=
 =?utf-8?B?R21COHM2Vi8wakRkVjNMM1JpaERBRjN3MDdlMXJpYk1JbE4wWmdGNlJydGkw?=
 =?utf-8?B?cGR4cWJ1bCtQYkhOa3FGKzZhYjUwY3E3alJyZnpIeWVQdzlEemIzTVgxZmN5?=
 =?utf-8?B?ODlEdE00VzR4TGRBdXB4MGQyVXhoVklOdUtMUkRPNkZlVm1QQnhzd1BUaGZ3?=
 =?utf-8?B?SlI5UFBXUUdOc0xPNURQNm5wRHlMQ2pra25qTHErL0pob3JMWjVhUlU2RUdX?=
 =?utf-8?B?bm5yazVDZ01zSlZvZU1qUWpwZ2FTR1NMQlp4enVwWUxDK2wvRXhvajdhOTVp?=
 =?utf-8?B?cjllTHJzY0kvSmFpZk1ibHdMNGM2bGVZTHhpSEt4UFUyaGtnMlp5aTdKTjlw?=
 =?utf-8?B?cGJtbStnZzlnZTB2QmVHWlh5ajZETW53b0pVb251ZkhRUjdTMXFXNHRHaUJS?=
 =?utf-8?B?M2kwSjcxK1E0SGdwZjJRclc1K1FTbWwzUVNTQ0ltVlNtSFZkZ0RIUUQwbDcr?=
 =?utf-8?B?ejhpUFJJZWsxa280SkRqNzZ0S094ZWlrOERrcnNUemJMUWp3Z0JwTTRKWFRm?=
 =?utf-8?B?WTZoUzlzZEdTeElLUFlxVTRPcTJTbWc5YlpPM0hMMkUramVtTE5DV0dycCtE?=
 =?utf-8?B?bk5ySFo2cFgwTWkrVW1WMFF4MXIxb2Z4cktLS1g4eFVwQ2liVEwxdi8wMi9P?=
 =?utf-8?B?WTMrMGExdkJ2MGRnU0g4SGI1RFVvdVAwelN5em9xRzU0ZzVMVkd1TWxDTHYr?=
 =?utf-8?B?ZzNLWXIvQ2J6QzBxdjZpMllvQ2QrWWlWdXQzclpsUUsyUXAxMityTDM1WGww?=
 =?utf-8?B?ZUJ2c01YQnZkQXpmdlNpeXllMU9LWG12M0gyejFVU3djRnJjbTRwckRSa0dS?=
 =?utf-8?B?RU1KODdDU2c2WUVpTUxGa3FRd005SXJRTUQrcUQ1MFpWQVdGeWxLZDR0NmVZ?=
 =?utf-8?B?ZDdxdFJqL3Zwdk1KWGZzTTFJcWFoNEhreVM0WVFmYXFMajNvVXhQZVBxd1Vp?=
 =?utf-8?B?WjJNckZMaGZ6bkROQm5nU3NLR0VhQmtRdjBXcWVCSmE5MncvdnZsNkhNUm4v?=
 =?utf-8?B?cTVjTG82UGxoNVRsTmFWS25oaG52MkNVRTlzb1J2OC9UQkVNOWNMMXBiUkh3?=
 =?utf-8?Q?DFSOomVLhh7KKmoANHC3EpJi9?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: addfddc8-409f-4f48-9c93-08dd6ae408ce
X-MS-Exchange-CrossTenant-AuthSource: CH3PR12MB7500.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2025 14:56:19.2286
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I28DUG1en5B/n0eCMPlXz24XSRKW/rjapKEPz1zBwpKGOvb2hhXSEXkQAcpFSlpJ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6311

On 24/03/2025 16:35, Jakub Kicinski wrote:
> On Tue, 18 Mar 2025 11:00:10 +0200 Gal Pressman wrote:
>>> I guess something alike the following could be quite common or at least
>>> possible:
>>>
>>> #ifdef AH_V4_FLOW
>>>
>>> // kernel support AH flow, implement user-space side
>>>
>>> #else
>>>
>>> // fail on any AH-flow related code path
>>>
>>> #endif  
>>
>> Right, thanks Paolo!
> 
> I don't see a v2, so commenting here.
> 
> I believe that we have had this conversation in BPF context in the past.
> BPF likes to have things in enums because enums are preserved in debug
> info / BTF and defines (obviously) aren't. So we converted a bunch of
> things in uAPI to enums in the past for BPF's benefit. While Paolo's
> concern is correct (and I believe I voiced similar concerns myself),
> in practice we have never encountered any issues.
> 
> No strong preference from my side, but FWIW I think there's significant
> precedent for such conversions.
> 
> One nit if you decide to keep the enum, Gal, please keep the comments
> aligned.

I do prefer to keep the enum, will address the alignment.

Thanks for the review.


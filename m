Return-Path: <netdev+bounces-112185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C45E2937521
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 10:39:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 480EE1F21738
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 08:39:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79FDC77F1B;
	Fri, 19 Jul 2024 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="VCPFeQm7"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2088.outbound.protection.outlook.com [40.107.243.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEC836F2F0;
	Fri, 19 Jul 2024 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721378356; cv=fail; b=TB7uCLwHTLaooXRvWWAWFX5vTABHwWm6wAJ7va7Go660LjO62qjfxbYmkqUIuxbvgz0NH6/mX19uG0VKJYb0SXiQwjeNav4udB/6UqAHpz6F9vy2iS5reIeuIvzDUnHc8HaZs3/D+zZjik4TR6evGnNvi0Pdkfb7GjRC+a+Y2nw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721378356; c=relaxed/simple;
	bh=DN5p6pKX5rbyqWJzhvwPyX/top1X8WTZcXPKPLuJSMg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Wvor+5KKQhCuFH9eXQSI611W/P12xDwhebKvLBHbfMCo3gwrxdlpXbSPHds4vJAHb28NwybmZIYQg2W7lDyXumDs1hV6rNMvmz7Bge7k2SkVZ3BIcYjAOPs57hcxPKR8fK4gCKufq8eKwBpRAjs77+j7BSAo1iZSwo0pnYeJSZU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=VCPFeQm7; arc=fail smtp.client-ip=40.107.243.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZYD6n0yBiccwFwITgaVzk8zjLBuyXAjyk5ZLyGsH7AQ9/mFtwnkfOJY1WiW8wXohkkepJOHJjuEa31T/UFXaSYC60XngjsAS9A80xOwE5VclgEQ+eihTF0M//RfWOuzWb141V5QL+bfF0ZY5mMRIzy7wUeaWRMN1gdAe6ODU305iynsrOg2Yly0AloSBQp3WFw7Xum2bnDYJOhCabyd7UAYiXkFn2w2JB+3NE2AGrLcDH2AhttzZRHPFfjNyd3YdyDiXaQLxusUprcDmPIShmsNcw86Bi/JrFoti9ty5g+QLptqiJIufUdtnPUcrHJqjowWrwKdU8UBGr/MQY4V5Sw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AwrJaviWQnkpvSVLE0gtkb71/mGELwScM445uHQXmwM=;
 b=YKY9ZMd6syxJDlP5Tl739YUOtYXN76pEO8lNhCztT0nhsvnyBT7N6rGdtfdOe64h6Xc0V2xFom5a/ylAweZA8NY3KlFy2R1UU3DapGbB15qKDAAsri4JlqHPaT+YhYEsrLuERitRf0AiUmB8/2sEJqmDfGuGzRRadl+WGxpdwNmXs2b+j5VcLnkr+HE/+Jl5d2Y0LryOyZh8iRzEmxbMD/jLeW+MS4q8B5qHUJ02xDROTFO+IMbiZlr4elUBy4sJ6ZRbNOp5lyMcnxAPgfg4BAbhY9iMK0NR703wo8IhR260FlxtPLOdhXHJFP2FEmpX6341AmTHhpS7M1GZhBzwhA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AwrJaviWQnkpvSVLE0gtkb71/mGELwScM445uHQXmwM=;
 b=VCPFeQm78MDAAeuEOFZH0AWbXgU8eGLv/axVAVrHB0bkm0tIcHgccLpZeTIES9+AApAvwedU7RCwu0fmHVvIhUjslyMvHExw/2tT5nG125sMhTwtPdgqbRjEKlWPDJiHqwzwMhFIZN3XQZVPEi79718UQt/ljr/+VPPRE9xIEo5LqjupYiV8WxSH65horzGXvIWjSvgs5GWmgf+R9XZTr+5GBlMMpJl+RU7eIpjWqg73dL6HbWmFrauTEyYgu0DlEBg/gJt7cH/axs9mzhMFAM5IgjCTUdOupoRIurJNy1YlqUI7H9N3DEThrz5G4FkAprdIrOxSPYJJIHqta+0zBw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 IA1PR12MB6306.namprd12.prod.outlook.com (2603:10b6:208:3e6::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7784.14; Fri, 19 Jul
 2024 08:39:11 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::ae68:3461:c09b:e6e3%6]) with mapi id 15.20.7784.017; Fri, 19 Jul 2024
 08:39:11 +0000
Message-ID: <60d64371-ec39-409e-9c0d-e838aa878577@nvidia.com>
Date: Fri, 19 Jul 2024 09:39:05 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [RESEND PATCH net-next v3 3/4] net: phy: aquantia: wait for the
 GLOBAL_CFG to start returning real values
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Russell King <linux@armlinux.org.uk>, "David S . Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>,
 Brad Griffis <bgriffis@nvidia.com>
References: <20240708075023.14893-1-brgl@bgdev.pl>
 <20240708075023.14893-4-brgl@bgdev.pl>
 <7c0140be-4325-4005-9068-7e0fc5ff344d@nvidia.com>
 <CAMRc=McF93F6YsQ+eT9oOe+c=2ZCQ3rBdj+-3Ruy8iO1B-syjw@mail.gmail.com>
 <CAMRc=Mc=8Sa76TOZujMMZcaF2Dc8OL_HKo=gXuj-YALaH4zKHg@mail.gmail.com>
 <6e12f5a5-8007-4ddc-a5ad-be556656af71@nvidia.com>
 <CAMRc=MdvsKeYEEvf2w3RxPiR=yLFXDwesiQ75JHTU-YEpkF-ZA@mail.gmail.com>
 <874f68e3-a5f4-4771-9d40-59d2efbf2693@nvidia.com>
 <CAMRc=MeKdg-MnO_kNkgpwbuSgL0mfAw8HveGFKFwUeNd6379bQ@mail.gmail.com>
 <5e432afa-5a00-46bd-b722-4bf8f875fc39@nvidia.com>
 <CAMRc=McCa3qUL5Mjxn2TVUeJzqaBaDCx52z8i7hfO=tfYFGgWA@mail.gmail.com>
From: Jon Hunter <jonathanh@nvidia.com>
Content-Language: en-US
In-Reply-To: <CAMRc=McCa3qUL5Mjxn2TVUeJzqaBaDCx52z8i7hfO=tfYFGgWA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P265CA0194.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:318::9) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR12MB5444:EE_|IA1PR12MB6306:EE_
X-MS-Office365-Filtering-Correlation-Id: f9338c7c-b696-4620-5c78-08dca7ce4343
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|7416014|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cmo5VDYyMzFLSTNxUlRSQVFXZlRGMjNBTnBhRHJRR3dZMkFTVy9SeUhSNWU0?=
 =?utf-8?B?NE4wSWVudUN1YW5DZy9kS2o2MlZrSnltenQ4ZEY2QlFGQ1RqaHRGdTNHNlc1?=
 =?utf-8?B?N2tpcjdMcTYxN1NMRUVzNjRzRnVQbUIvUk0rVFFrRFZaam9SSEhnUVZveS9w?=
 =?utf-8?B?NTdQTnlyL1V5Y2hZaWJON2k4M3l2ck52YW5pQ1ZsKzRtQW84M3lldmJMWmFP?=
 =?utf-8?B?cXN0RDUrdE5WZG5rVGQydG1ieS9tbmlaYUZEbkp2RVcrc0dRNVlrRG5rZmx3?=
 =?utf-8?B?dG5LRG9DUXlxa1FBNGhJNVB1emMwZ2IxMFpkRGhXWE14cXl1TUFOd3RYdndj?=
 =?utf-8?B?MnF5L2RUSXJMNnhwSFVmVWpTTHQ5WHdtV1kwRkZ4SC9rdFptNjZyeW5BT0wz?=
 =?utf-8?B?LzV0RWwxVkhsMCtCcmdsUW1xRWVIMUd6VUh4KzBpNGpWSkJHbkorOFdDb0xG?=
 =?utf-8?B?MGNxWVMvZjNCdVV4TUdtWWliRCs1UllSNUMzc01qcHRjclJzejEwV2I5Z1Rn?=
 =?utf-8?B?a3RSYVVrTkZWZy8xNnlnRnAwdGhIdkEwTURLUkx2OHByT3h3clFHYzVycnhn?=
 =?utf-8?B?UVdRVlpVcmZRUElQa2pmN25pMWlDYk5QUXNxekF5YXp5bEhJRSsrUVFSdURF?=
 =?utf-8?B?RmZ5SXBDSFJxRnM3M1JlM1VyRWtHMjZtSDUwY3phbzVGOGEvMUhkVGtwa2xk?=
 =?utf-8?B?bEdvZGNMb1FTdklEWTJPSjhqako0d0RWV08vb1h1M0JIMkRURFZsUTRPRzJy?=
 =?utf-8?B?RXdIU05DdS9iNi94OUIxdC90bXRiWW9VTlBRZEE3aFFrWEVYMEFLRHNZNTRP?=
 =?utf-8?B?cDFWN3NCQWJKQVdHTUlUKzJzNUs1N1RaZUxIWmdoRHMwZ3FsV09tcmV2T3U3?=
 =?utf-8?B?VWxzZldXcnJIN2I5RnNTQm0wZDVUV2VzRysvY1YzY1JkNkpKbGFEK24yUlM4?=
 =?utf-8?B?dDFrZkZxZGZrNGdHREdkSERJWDQwRTRycmtpbGVYTjZyMldueXBOZXVHanNN?=
 =?utf-8?B?TE9Ud0x2M2pHNkF5RC9PWkpnUkJMMnc4TUhucDBoWHhYZXdDRVovem1pSCtX?=
 =?utf-8?B?Z1BEdVpUd3ZPeTIvRHJ4dFVrNFFxbzZrdERPM242aTVzNXJuQjVTU1QwSFEx?=
 =?utf-8?B?eW5hcjZ1OEs3NDhYbDVkRDdYWC9Qc2NvY0pqbXB3YnlEeVFhc2xVUlFTRUha?=
 =?utf-8?B?VFMycFQ1WDVJYUcxbG5GZ3QycDJ5ZjFFM2c0alhnMUUxNFZhS2RORk4zdERT?=
 =?utf-8?B?YTF5YVdOZVlBY0tPY0ZtbndwUUJrYXAzMWZkRHF4VEMrWWYrRURUdDVKczlO?=
 =?utf-8?B?eVl6YjhXUW44WlR4K3NWSWE0YWVCVldQZnFEWmRYblJSQ1VsYTJqT0tDYkJ6?=
 =?utf-8?B?MytzYlhKYklsdkJOMmhRMDJrRjVVR2Z5VkdoL0N6S2Z5Vld6aG44cWRtR3dY?=
 =?utf-8?B?MzdSbFB0cCtCK3lrYWZCM1FoeldZRFBCNzZiNmlSa0JHNEFsMllZaWlUZS9V?=
 =?utf-8?B?bkdKTjhVYlVpREgyS3RZS3NPeXdoY3p4UGt4YWdjWDAyRitzdmFlVXg2YjZS?=
 =?utf-8?B?djduUUxYNEFoaFM3NEthUEpyc3dFbUxFSWtkcFh0RnlSTnp0dEZaMmpEWGFa?=
 =?utf-8?B?eUdQNGhWZWN6SnpPUTRvTjZyVHR6WWszRHYyajdKWTUzazl6RVpzS3NSS3Fa?=
 =?utf-8?B?QXBadk4xWEtEZ2lEc1RMczNnaC9qMUZwR0I2NmI1a2JSYnVELzVjcE5Bdk53?=
 =?utf-8?B?SHR4cE1rVkUvdFd6RXNxZk9Ed3d0cFpuUktYUFhmUTlMRFJ6aVYyZTRINGNz?=
 =?utf-8?B?OGV4VUo2OURyU0hNQWhjUT09?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(7416014)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?ZVVhdkt4Um02VEFzdFo1VjlHUkhRdTZKMFpRSnNoSk1aSW5XVWVtUU96d0xv?=
 =?utf-8?B?RlUySmNZbFd6cThqWWlwVjFQcHVqZ0VJamZadDJ1WHNpVVJMUXFSUXpBT05a?=
 =?utf-8?B?Z0FPa2xtcDkrUlJJNlBPOEhaWkF4SkdHOEFVRG1acW1Qa3AraWdnNlBTSkFT?=
 =?utf-8?B?aWZJOVVZR1lQMi9PZzlEdGZsbkZodDZZQWt2Z1BMVXdnWVpyT0JlbU0xZHUx?=
 =?utf-8?B?cW93VThNVHgwdytic2c5ZFNLblRleXZ5U0NtaG5pZEI0dm5YZHp5eVdFTkRO?=
 =?utf-8?B?QU1kVEFXZ3JnbCswemVTRnRzc1FoZGlCS2xkRHo5MlF5MGtVK0dGTU5oSzlh?=
 =?utf-8?B?SUZzc0dVT1NNRHZrQlF1d2toejMyQm10ZE5vR0ozU0EvS2dIMnVJWlJwRFF4?=
 =?utf-8?B?U2hubm5tZEFGQVFjdkJIL0lTUWVtLzZsaXMwQkhMVG9pZHgrak1oL2FWakx6?=
 =?utf-8?B?LzQrcFlrSTlWZ2pJRVFWaDJxT0ZsRkthcDdUNWVISGo0QU13WThRUEdtcFpW?=
 =?utf-8?B?c05RVjNnZW1jVTFNSDd3cmlJWlhIbW5BaXRaZmFNS2REaFQxZzczV2VSVzdt?=
 =?utf-8?B?YjlCdzVVaHNMcGZsRnhLbStXS24wTnZQbkQwK05TWGhabjB0eUpwQUdoamZB?=
 =?utf-8?B?NXZxbWxTdXpWTDdvbUt4WTZGUDhna3RCUU56c3UvUHFzSDYvM281Vk9TbmNu?=
 =?utf-8?B?WGR2UUJiVVRLWWFPMnU0SWVqTmc5VlBHckpFd0ZncjV6SEY2bTRBOEhlNWxW?=
 =?utf-8?B?aXhiMDlqTVRQY3VyNjI0OGlpRms5Qmg3L1NJV25WNmtZYktCbUhuaE1zZ01F?=
 =?utf-8?B?anhVNlo1MEdncFhhaElmeXk1THdBQU44SXIzWW8vWTMzbmFzb3kwSWYwNlFO?=
 =?utf-8?B?V1hqeDdQQ0tLUENBcWQ0Z1cwNVVkL0RIY0l4ckdBS3pHakdOTlplbjZ5M2lj?=
 =?utf-8?B?UVora3JjWXB3TXhjNU9rL2lMa0J5VVZGV3hCTWJkU1hoZHZzbUU0ZlZOb2Y3?=
 =?utf-8?B?ZkVwYWNoc1AvNk1zdVVLVFRtdHRSSkhQZ3JaZncrSzFjQ0lkaWhKZHdiVnpL?=
 =?utf-8?B?bGt2ZS9JbjlyTm9FbEx5OGRSb1JzSnZZcWYrbEtJR3JHOThmNTlUK1ZNamh1?=
 =?utf-8?B?bCtVK2xxb3NtdlpSVWNUNkxTbFYrYkZqS1JMYkFkZjR3aG9ER2ErQUtMUkFZ?=
 =?utf-8?B?TlJaRU44V1kxak9kSGdWN01TWm5VUnVOTUZRTnVzMlh6QzFSZU4zeko1cWhu?=
 =?utf-8?B?WkRVUXQ0M0lsNGJ0SVV6OGptTndYaUJna1l2bXhJSXg0cXZJZlFHWW5yOCta?=
 =?utf-8?B?T08vcWxjai9kdGZERGVCbGRDVnVTcGQ1SWdaWGtYOTB6WWU1OWNiRjRSU1cv?=
 =?utf-8?B?dkE0bFB0eTVldXJTMG9WZFpCL05Xa29ZUk1lYUhMTEI5c2tMSDVqV21uZ2lJ?=
 =?utf-8?B?cUdEaHBKMXZHZ21vcUxSa2ExLzJkVVlsOTdYcndrckh1S3U1NWdXajg0ajVt?=
 =?utf-8?B?aExncUswcHdqK1g5UHV6UGgyZ1BJOXVVRHhvMlVFUVpMTGdRQWNseUlKOEtz?=
 =?utf-8?B?UXdKTmIwSWVURmlIZzNCb2FZZ1p2cnVockZ2YXJKTzRzbkZZdTU2ZXdvT2s1?=
 =?utf-8?B?bkw5QzhFZFlaenJFNFJGY0N5ckZLMTU1bThjK1hsQWQ2ek1UejJIWUFuNGl4?=
 =?utf-8?B?STZsUU5QeG83UUFOZkNGTVBtRDdZS3RjNWh2V1Z2bUoyaERnMlEwaGZVbm9n?=
 =?utf-8?B?bHRBd2RnQXl0QnhkczlvMEltQ2ppeUNBN3dDdTN3QWR1Y3UvdnlQZlRub2M4?=
 =?utf-8?B?VGxJUzIxb0wwNFdFWlNKWFNvVDhib3k3cVpZUXVZZ21RQW1YSDN6K0NvL2Zu?=
 =?utf-8?B?NU9MdmVFazhTL0dwbVk2angyemlMekxTbXpPN2NOSEZzSnZiczh2NUE1bWFi?=
 =?utf-8?B?R2Rjc1dFekNpTnpiaW9UYThXUmczUWNaUHA0R3ZtWDFQTGUrUE1ZWlhWbFk0?=
 =?utf-8?B?STZLalB3cnFibUM0b3dmSDRJbDJqdDdzczJ1UUh2bXc1TnpBNGxocWMvZTht?=
 =?utf-8?B?S25yeGZId01vMlNwVjB4SGtncS81L1FIUVBXTC81S0xLUERxSUJJOGVGZnRB?=
 =?utf-8?B?Q2N4b1dUNmlLL0xpYWdwNzRVQ3FFV0VEMDZBVXlJcFUxdFNjUFJwSE12TnJH?=
 =?utf-8?Q?QAL9M9BnKLBBnCx4O1N8iQTMS2rkP0ElPBqRGPnkXshg?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f9338c7c-b696-4620-5c78-08dca7ce4343
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jul 2024 08:39:11.6780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RA0LgRfuMxms2VDCBUClwxQSyMGI+hDYqFrDQKGhBk126O9yoUI3cvekA7O4u8/8KKxu2aYS5pMANQJNoIvIug==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6306


On 18/07/2024 20:05, Bartosz Golaszewski wrote:
> On Thu, Jul 18, 2024 at 7:42 PM Jon Hunter <jonathanh@nvidia.com> wrote:
>>
>>
>> On 18/07/2024 15:59, Bartosz Golaszewski wrote:
>>
>> ...
>>
>>>>>>> TBH I only observed the issue on AQR115C. I don't have any other model
>>>>>>> to test with. Is it fine to fix it by implementing
>>>>>>> aqr115_fill_interface_modes() that would first wait for this register
>>>>>>> to return non-0 and then call aqr107_fill_interface_modes()?
>>>>>>
>>>>>> I am doing a bit more testing. We have seen a few issues with this PHY
>>>>>> driver and so I am wondering if we also need something similar for the
>>>>>> AQR113C variant too.
>>>>>>
>>>>>> Interestingly, the product brief for these PHYs [0] do show that both
>>>>>> the AQR113C and AQR115C both support 10M. So I wonder if it is our
>>>>>> ethernet controller that is not supporting 10M? I will check on this too.
>>>>>>
>>>>>
>>>>> Oh you have an 113c? I didn't get this. Yeah, weird, all docs say it
>>>>> should support 10M. In fact all AQR PHYs should hence my initial
>>>>> change.
>>>>
>>>>
>>>> Yes we have an AQR113C. I agree it should support this, but for whatever
>>>> reason this is not advertised. I do see that 10M is advertised as
>>>> supported by the network ...
>>>>
>>>>     Link partner advertised link modes:  10baseT/Half 10baseT/Full
>>>>                                          100baseT/Half 100baseT/Full
>>>>                                          1000baseT/Full
>>>>
>>>> My PC that is on the same network supports 10M, but just not this Tegra
>>>> device. I am checking to see if this is expected for this device.
>>>>
>>>
>>> I sent a patch for you to test. I think that even if it doesn't fully
>>> fix the issue you're observing, it's worth picking it up as it reduces
>>> the impact of the workaround I introduced.
>>
>>
>> Thanks! I will test this tonight.
>>
>>> I'll be off next week so I'm sending it quickly with the hope it will be useful.
>>
>>
>> OK thanks for letting me know.
>>
>> Another thought I had, which is also quite timely, is that I have
>> recently been testing a patch [0] as I found that this actually resolves
>> an issue where we occasionally see our device fail to get an IP address.
>>
>> This was sent out over a year ago and sadly we failed to follow up :-(
>>
>> Russell was concerned if this would make the function that was being
>> changed fail if it did not have the link (if I am understanding the
>> comments correctly). However, looking at the code now, I see that the
>> aqr107_read_status() function checks if '!phydev->link' before we poll
>> the TX ready status, and so I am wondering if this change is OK? From my
>> testing it does work. I would be interested to know if this may also
>> resolve your issue?
>>
>> With this change [0] I have been able to do 500 boots on our board and
>> verify that the ethernet controller is able to get an IP address every
>> time. Without this change it would fail to get an IP address anywhere
>> from 1-100 boots typically.
>>
>> I will test your patch in the same way, but I am wondering if both are
>> trying to address the same sort of issue?
>>
> 
> The patch you linked does not fix the suspend/resume either. :(


Thanks for testing! I have verified that the patch you sent resolves the 
issue introduced by this patch for Tegra. And likewise this patch does 
not resolve the long-standing issue (not related to this change) that we 
have been observing.

Cheers
Jon

-- 
nvpublic


Return-Path: <netdev+bounces-183047-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AA5D1A8ABF2
	for <lists+netdev@lfdr.de>; Wed, 16 Apr 2025 01:15:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 003CC19038D0
	for <lists+netdev@lfdr.de>; Tue, 15 Apr 2025 23:15:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C80D2798E6;
	Tue, 15 Apr 2025 23:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wXNT9bzp"
X-Original-To: netdev@vger.kernel.org
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2055.outbound.protection.outlook.com [40.107.95.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3B51990A7;
	Tue, 15 Apr 2025 23:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744758937; cv=fail; b=R6JiavyE7E+D47QIrwTMkoWe6QVPAy13WGBdztZwAl85GgclqSKW6BUjheA4/NA/I9Lvk7gIYyxFf1fk4/pg/Zm9iYg3FM1aHwNkJGuP0P8PeeQZ7msg139a/3HchFfHw2xrfMU5aCfIoT+u27RnGqEfKdrVZD6C6sBopBeI1/8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744758937; c=relaxed/simple;
	bh=tKs2MySduCDX6ymW8kwuLEGHOCq9C2FpgLTEdI7U6fI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=JM5AkRMIl8ONd+EhbcBkUvrnHm6P1kOvHoJsmERfhOKnmCEjtE4eoukk8Sarsktefy910hVIrgTf8SuxAMbvuc+3AhI8H0YGw/QhpWRk9RG+qzsvTAir9uBsZ6cF82d3PyxtdTohdXr7Kd1hWJIOy2s21a988MWn5VpYG31hRnY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wXNT9bzp; arc=fail smtp.client-ip=40.107.95.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YpjCR9PPZXK7FE/7w3ACfPIpwncuMLpL9Rbxe9ShVayLaMGvcW+7c8OCZIKVZPPHo5oo9IWRgL994gCwfgu4b4OfQWsfdKX2gAhUQwTXcS4LAYpVWaalfX54zLy/pxM48TNDo85nLqOVZmFYGyZieXCK5K0jKrrq8JsA0MigiZJF6BpWyw94B23Z120abipT0dQiRti12HT82Uevb9yplFPW668VgKIhLwNGrB+cSuifplfIXWuYuPRDk4I5jkWU0bpEKuWaxKZPSYW++av+/RNNdDBxiICX0zfyhXd9SCeqxxoxcJ2nT3pteKnxEvZZ7x4eRYUwqTDDKoOQO3UY0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6Qf/OyK9wRrSQ/+3PlYmEYINT+xKGIVjkWnHEObk40M=;
 b=QUcXZR8AgJ/N6nvd7ti9CNi89qQpdELm0tsPacmL1HWPpyT6EtoKNfP0Cq3eQsASxNaEVfTSXEaEqMd8zK/3VZMbhdEucSM+a0lGEsJeVTv92oZmkctIQo66tAG7EazhICjks2qbPLTBki5yDC+uhaMJfRvmIkBGNaVLdKwVgkcIdMwefjFvs4ltnT4RguvJLemowRUaz7ywwmCjas11LPqjlRlfcXfb40HgXRts55vX5DWahn/JVHEtoi4AJxfD2SQdKKNsULnRqZ9e2mfnKv3zz5l4MoYq10GsOarjg+NOUrR2ZarVkGBEjz/AnaDMSAZ6t2VoBJyAOycAIDK2Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6Qf/OyK9wRrSQ/+3PlYmEYINT+xKGIVjkWnHEObk40M=;
 b=wXNT9bzpf5xQdUkEZ8OqA3rz3joybrj5+51faznQ/CqgyLRqzymVzVWb8/UC64E61riuMdxj7h3sxaG1K/bNNsWmBO02YJx7jMiRMoMlvdWblwgjsX5FI9Fm0jc+4p+/7/cfnxNzCVammntGrHrO6zlssXC4bpDJsysa+C60+9A=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DS0PR12MB6583.namprd12.prod.outlook.com (2603:10b6:8:d1::12) by
 IA0PR12MB8422.namprd12.prod.outlook.com (2603:10b6:208:3de::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8632.34; Tue, 15 Apr 2025 23:15:31 +0000
Received: from DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb]) by DS0PR12MB6583.namprd12.prod.outlook.com
 ([fe80::c8a9:4b0d:e1c7:aecb%5]) with mapi id 15.20.8632.035; Tue, 15 Apr 2025
 23:15:29 +0000
Message-ID: <9f9688da-04b2-477f-a7fe-17c4e21cb8d1@amd.com>
Date: Tue, 15 Apr 2025 16:15:27 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net 2/5] pds_core: remove extra name description
To: Jakub Kicinski <kuba@kernel.org>
Cc: andrew+netdev@lunn.ch, brett.creeley@amd.com, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, michal.swiatkowski@linux.intel.com,
 horms@kernel.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
References: <20250411003209.44053-1-shannon.nelson@amd.com>
 <20250411003209.44053-3-shannon.nelson@amd.com>
 <20250414173610.5dc3be9d@kernel.org>
Content-Language: en-US
From: "Nelson, Shannon" <shannon.nelson@amd.com>
In-Reply-To: <20250414173610.5dc3be9d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR03CA0007.namprd03.prod.outlook.com
 (2603:10b6:a03:1e0::17) To DS0PR12MB6583.namprd12.prod.outlook.com
 (2603:10b6:8:d1::12)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR12MB6583:EE_|IA0PR12MB8422:EE_
X-MS-Office365-Filtering-Correlation-Id: 4788916d-50f1-44b8-9b01-08dd7c736948
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?T2tSYUErczRoYWIyUk1EalhKWFFWa1A3L0R6V0U3d0lXaG9FRVZObnlnNE9y?=
 =?utf-8?B?elVPREh3djFVeE9RQUtCTHg1dFN0T0UyRkhrK1JjNlJHc0ppWWlUY2wwYzlD?=
 =?utf-8?B?aC9wdzA0MjZSNUQ1ak5udDdkenUydDVkcTd3aDRJRnVYWU1SY0xMcmpJR2xN?=
 =?utf-8?B?M0V2YzdYNmE2R0JTMC9kZ1FXVFRWV3BFWkRMTUlTNzFOTWpCV1NzYUY3cCt6?=
 =?utf-8?B?b0lZOXp2Z1A4d0JWNnpGQ2JsRFhLWDM2MUErekVxVURHUlV2aFlOUXg3N2Fz?=
 =?utf-8?B?NWc5S3JydUhQR0Z4QzBaWklmTDN1RDNObllFOWRrNktiSFc3elE4TkZ6VnQy?=
 =?utf-8?B?KzB2ZFY2V013RG5TMmlvSkI2TTFOZUdnbnB1K25vbTljWFBGbnVoaDdqbUxY?=
 =?utf-8?B?a1FxMWlEU0hRNmVYV3JoN0ZWTU5BL1VMVnludVZCb2hWUDRmZC9Md1BnN3Vy?=
 =?utf-8?B?dEFmRVNVRFl0M3hhR2hwaTh6ejFZSWlKZCtOOGdkRFU3aVRGajdsRzh4S3ZV?=
 =?utf-8?B?OHB1WW0xTzEyRnd3OUpUY0dIeDV5Y2M2MXpzSnh0N05GWXJ4WkJDaUY0TUJZ?=
 =?utf-8?B?RHJVcWdHaHNNdUEwSk9CcGJCNVlEWk9kcmU1U1BhZlhiUjhNd0VHaW5meldm?=
 =?utf-8?B?MlUxZmxHUGNDNUphOFU4bEdsYnRqWGVyMnUzK2dFWGp2OW5RUmdRWU93bnJk?=
 =?utf-8?B?NVVhVlNXN2FMWEh3dTZhQk9ocjB0bkNvQ3dMdS9VK0ZqRGtpNXNEUzZkcEpx?=
 =?utf-8?B?cnlhblhuMWltK2w1aUt2TVQwTzNFcHVwTGltZ29MWldYNGtvODFsam5NeHhu?=
 =?utf-8?B?UUo0VjRnMkpZMzIrUUVXUWk1Mm9pNHBYcythZXlyMWkwYXJiM1VRdUVnNFVG?=
 =?utf-8?B?ZDJzTy9zYXFJRkdZMDh6blpVU3FQcTh1dk5rakdMQ01jRFZPckVDWlhoemN3?=
 =?utf-8?B?aHVLMmR0aVdNWDQ2ZzlzaFVwK3ZiSWVnK2JaMW9LN0x3Rk41R2dmUE1OYTlG?=
 =?utf-8?B?ZGFwbjZlZ1RlVC9RdmhyRVZUUzB5ZW52VlRwYTBIdHo2U0RxSnFOOS9tMW4r?=
 =?utf-8?B?dDJxZ2l6emZzY0JXSUgyYjRtZHNqTFZ6MXBUenRuN1V5L0wwdlpUK2RUNXAy?=
 =?utf-8?B?T3RtRGo1bzY0N0YrOGYyelZNM1lYMHZKeHhkUkRpUEk0bDJXRW1Lc1VyVk5X?=
 =?utf-8?B?bE5RaFZtYk5mMGw4QnhlQVZmdTlJWjJEeWljbDQvRWVFa2VJMndidDlEQWt3?=
 =?utf-8?B?eDZMdjFWMGdhZ3U4ZFBzUG9uaDNTQWx4MkxtQ1ZGZnhsNUN6Tkx4b05MSmxj?=
 =?utf-8?B?R3JtS1BUTHlCRDZkVVE2bDhWN3I0Z2ZwZ0ViNmJINWNvbWx5dEcyWEpUb1M2?=
 =?utf-8?B?Y1d3S2NJNktiZTlpZGQ5ZG5iWUx6cWFJakd1Nkp5b1phdHBXRDJGNXBxczFS?=
 =?utf-8?B?SlJpand6TmwwRTU3SkY2YnBMQU1RVG5DVyt3aHBMK3RCVGdNYTNackR3bFdh?=
 =?utf-8?B?dFhUYTRYS3gyNFYrZVlnTzh0Ky9MZHBOYUFBVzdORDFXMEJXM2NYbVFxK3Rh?=
 =?utf-8?B?cW5sK01BQ3hHcEE4cjhmSHYwUnp1cktZK2ZTdDFLY2FocnVpQXhGdEc4TUFw?=
 =?utf-8?B?NkZPekIxUnlVanpmcUR1dVJSTEFyRTV2RU5WZmNGVHBKaC9oYmQyaDlFR0xN?=
 =?utf-8?B?VVoyL0JaTGJWSkU3VnBtZ0xoQlNSdFAvSkFTdjFTUWJsamowVVc1UzhUVGcv?=
 =?utf-8?B?QUh3cXF4d1YvTkh2d2M0Q1hNNnJCcTFjemlHK28xcjN6MTNlMWRZQzVmWkM1?=
 =?utf-8?B?YW9VQ2IvZzRiWXNoM2JzTVdxZVhTMUdpcC9JVHVhZW1VZkszMVBudU5Id3Rs?=
 =?utf-8?B?MFZNeEdMZXh5dUhNVEdWbkRiZXNaRzhMOWRiYWJpWk5WelI5LzdSRSs3dVFa?=
 =?utf-8?Q?SXw8cA8dV8Y=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR12MB6583.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Z2d0ZnZ6OFFzS1hKUG1oZVh1YUFLL21XV0l2QkJSZjYzUm51Q2hoOG5qYmVL?=
 =?utf-8?B?V2lYVklaS2RFQmc4OTZoQ2FMdXFDYk1aTEQxeWg0eWpYRmZ3MEJMWmo5TnUv?=
 =?utf-8?B?UEVnQ1QxQm01S01mb3VJNDNWTk1NQjJuZjBMRnlUckU3U2ljZTB1R0tsSHl6?=
 =?utf-8?B?SlhrcDUxUWU5U1prbkRQcmxwbE4rb1prSGFLN0NOaWhmY0VRWDZTRk1qZGRk?=
 =?utf-8?B?L2ZSaDVXVGU0V0lKbXoyZ1FsVVNsZWJhQVlGT1d0bDBDbTlCQm0xRXFVU2Vw?=
 =?utf-8?B?ZFUybENmdUFpc1Zsbjg4dlFLUDlyckVQVnNvdHhYeS9TRjFYcndtQ0ZHRUxT?=
 =?utf-8?B?Z1ZpRFNNOEN2RGt6SmdzU1RXN0hzenlDejBJZUpOeDVxREhRYTB0MEZTY0t2?=
 =?utf-8?B?aG8vTlFmVVQ5TVZ3TTRkVXpHVHdldnV0NnNjQ0w0VHcxeW42RkVOcjR0NU00?=
 =?utf-8?B?VWc3VTd0ZVFidGhUZ01HMEh3VDJPTVNpVGVRZ00vaEF3RWYrK2k5Z0hHUTlJ?=
 =?utf-8?B?VHQ1ZmxQUlFhRkRZQTlCb0RHeDdyMGdGUE9yTGhaeWdmMFhWZEtGYy9zc0Ez?=
 =?utf-8?B?ang1eXhwVHJNUzdJbkdHYXI1OUpEcnl3aDZaazFwbHZzODdQbGlhUFFVUWpS?=
 =?utf-8?B?ZkFORGwrTGYwRFRDdHFiQkZrQ3pmV25QRUNETFhFTm1SS1g1Y1JMOWIvQTF6?=
 =?utf-8?B?Yngzd2JUS1F6cG04R0NzNmF3UG5OMy9DR0ltdlVRTjRCNjNCOVAweVZITUlN?=
 =?utf-8?B?bVNVLytEUXVGZzhKc2ZrWndIaXNncU1WTHFEZEVyUTVPY0MxUTRQbXhZaGN1?=
 =?utf-8?B?ZGZPUlBUWVMrQWw1dkdUUnJreisvdm5QclRnNnJVZHh4RjA0dnBHaE4rNk9K?=
 =?utf-8?B?QWJzSE5WREs4ZUxObWJpeFNLRFBwb0gxT0ljOUJ4TVlIYzR0TzdTK2xpZ2xE?=
 =?utf-8?B?WEhDNC95RWJtbjk5UWVSTFZtak41UUxKa1JrS2krckMzdnN4UU94RjMyQXU1?=
 =?utf-8?B?RHlpNXdwNmtxbk5UMXZsMUpPZWlUQlhLL1JKYjJEaHpueC83dWtmOG44MW9M?=
 =?utf-8?B?Z1hJTzEyNzlvalNXWEdmS1Y1cWE2ZjhlZ2dVQ01tMXQ3R1lwT1hpWmhWRDM2?=
 =?utf-8?B?OHpKV3FSdU1jY3diTUhKUjl3dWI3UkVNVzlmbW54WTRQbFVadzZGamNCRVd2?=
 =?utf-8?B?eHVOYWZoYmFiNGNwRkJDQi96eGpPME0rN2xNRm8xanlBK0V6akF1c0xjYVVp?=
 =?utf-8?B?QmRKdng2STBGSlVXNE94VjhFcGpsSTF0VGNTNzVRS0JYckgydXp3QUZqbzli?=
 =?utf-8?B?cUpDY3o2bXczbWU4ZC9wUDRQWUxFRk1kUzhwUzNQTVhDZEdxODlCSFJLTVpS?=
 =?utf-8?B?WFFjMysyQktsMHB6dzJHOFpUaitURkhlSHZ2cDhVQytzVVZlRTRMNldoQmRY?=
 =?utf-8?B?MVgyK2RXMk5mU1J4TEEwbkd3aVF5ckp4TGRvSFQvTXAySW1VRXVCbEt0bTV4?=
 =?utf-8?B?Y0xkNjV1QU5TUElDN1pCNG1KMnppdjhGWXZHclJ3YjFvbkVkMU83WDQySTBX?=
 =?utf-8?B?dC9NcndyR0cyRkdWZzJZTDRTYVVvd3BxSnNjSzdyVnZyZG42ejhLOGMyNzV1?=
 =?utf-8?B?dGljMDdSeExBMldXSWg1UWFiTGs5SEdyY0prWXV0YVhwY3NTUXRwY1hWOERF?=
 =?utf-8?B?aXlwV245dzROS2l4ZEthRjM2SkZ4dThTWmkxSjNPeGdjcHVvKzc0NzB5Sy9x?=
 =?utf-8?B?NUJqbFIyclZXTHlDa3VMM3VlampxTG5hVFZwcjk4QjVUTlFwdmZmdUNvSWtk?=
 =?utf-8?B?TFBjVkkxUityeXN2M1FwZDdTZmRpenAxa2toTy9WdGswRWcvZXpGWEd6WGhJ?=
 =?utf-8?B?alIvczNvQ0JvemNlQkZOZ1RjcllaY2pFYldJRkpSRGlrdEc3THU4RnBzb0hH?=
 =?utf-8?B?U3Z4RXZwVzIxajhvd3dXT3c4bjM1VGZuMWJ5dUcxRHBTMzM0Mml1MUJ0Z05T?=
 =?utf-8?B?ZmFGWUovbE1MNno3VUhzRmhVTHgyVC9UckpPbnI0bGJFcGkycTZzU2dhMXUv?=
 =?utf-8?B?RklBQ0pwWk5GZjA4OEpaQnF2YlpwaEVlZldRVXlTbk5kVFR4TmsvSFcrdXI0?=
 =?utf-8?Q?6FM6I44KEXj2xTSZICD/Mx1gN?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4788916d-50f1-44b8-9b01-08dd7c736948
X-MS-Exchange-CrossTenant-AuthSource: DS0PR12MB6583.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 23:15:28.8547
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cTVDmShHEb4P23Q6U0vIk/tF4+c0QVaWl/av4HgREJM2AeHqRzvAhXJ8CPAd/pPaPDESoGhtwL4D8AQuSFu/Vg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8422

On 4/14/2025 5:36 PM, Jakub Kicinski wrote:
> 
> On Thu, 10 Apr 2025 17:32:06 -0700 Shannon Nelson wrote:
>> Fix the kernel-doc complaint
>> include/linux/pds/pds_adminq.h:481: warning: Excess struct member 'name' description in 'pds_core_lif_getattr_comp'
>>
>> Fixes: 45d76f492938 ("pds_core: set up device and adminq")
> 
> How is this a bug fix? The warnings are only generated on W=1 builds.
> Please be more considerate of folks maintaining stable trees. There's
> no need to waste their time with patches like this.

I'll drop it out and repost.

Thanks,
sln



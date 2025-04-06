Return-Path: <netdev+bounces-179470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA06CA7CEBF
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 17:38:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF83188CA1B
	for <lists+netdev@lfdr.de>; Sun,  6 Apr 2025 15:38:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55A8220686;
	Sun,  6 Apr 2025 15:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Tq6xkQr+"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2067.outbound.protection.outlook.com [40.107.223.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED90F4A24
	for <netdev@vger.kernel.org>; Sun,  6 Apr 2025 15:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.223.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743953879; cv=fail; b=g+m5b9i1zhWR5Xc/dARjmQSaUL/dsAv4Z6RTfGKUPUp0p4DE/dzmSxy1irb3GvdroN59rW3LML9YinhbnS3ZBY5y4X86q5cL6Y26SmoiC2XwqlzCzDkHtwKApAsSjhZHGRwF3AcbojvHOZQAYjvsl8APsbyeJH67vzcdlP5YojA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743953879; c=relaxed/simple;
	bh=FY/pCx36jxv25Me6/xybk+ESRrJmHo/9QPpxadd0G2w=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=XtJSqdgjBoC8feTSRQgaDKAY9D/2NdA3TAyzHJsbEtfyE9ioZCz0fuM4W21iy/m3N90JIbbQjQt8PATzUaZPQ6mBFZuujhretmfHsgu0lV9QoC/KqCKpMMD8bS2A34IrdAjNxGgSFj+F6E2dHUo+qtQKBALc0FOE7/gJuYDevNI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Tq6xkQr+; arc=fail smtp.client-ip=40.107.223.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=k7mBny+n0rudseSteNZR0nTmf9hDjP1jcccjzgAzr9cQogtdvC9pzUSSgmIZA98JEQ0LAw8OecAt5GeDv6SQ9EXv4hu2qpbuEdL94T6XFJUAgOl72X26dzCaz5BkqkmkqgZLQldBiTeTQdwmi+HG6XhjVA2P8HZO5cDBSukRxR5YNFESg7Ci+F9CzOiiTlAehBjkdgyyq8awhNGx9x/dlqc+HGbhurECVHuqjO3mf5jU5V0xQCPO7iS/MDasFjLJ9Frw23OGVGCBKKOHHPHuV2tYd1zFWHFwZxhphAlGkbFdEsWfI2fkm0p7nUA1NQxd5eZykmdMCFYKM4yxD7NytQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVmss72mVOcbrAi96ezm1eLfZSLqY4YjjeOgh8lkE4g=;
 b=v+Gma9bQed8IiYDqyULcUzNHI+vF1Yle62sTZCVynH+vxppevd/uyzQmSVPRnfFc0Dt1aEK4MiwdgEh5KMvnladYf4QAgU4/QZZLrdsAEo3/2x3kCY5yWZyfjERrcjPWYvEUas//gcTC2tQ6m6B8LgV7U9GocU8/ZBQ9/7ywxTROH9wfwQi25h+DvmDqCODLilBIJ2NsLA4Rr87ong3xKSkk+AlYnEMup627SGzEdJM7N3FWP7YnN16+ILO09KG2li8eWhZEBSz1Oy2ONPkvvrCWY50LA0eTYNz/r3WxopXUYpdwQZEqvcO1eNzu/iWjWGjIms4ENGnu5ZjCBA0rwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVmss72mVOcbrAi96ezm1eLfZSLqY4YjjeOgh8lkE4g=;
 b=Tq6xkQr+W3PDJQeueZ/KZgWAWOat7jyccGwS6msGVoA1BblsA66NlA16+ltUvI3mmTk5WDWA+ufxyC9z2hO7GGkNodrejkZIPP6jv1NpkmG4RuxL0ciOwi155KlldkK5FGGAbwLQYFZQRmJ9wO2IRU5tlSC5BjzCFuwSfY2/aN0luqmPDXNM8S9QBT1E3cRw+7SRkoZHr7HlF42YP0+ILlpst18pcimUB3TU3yfStYqr8nts/HrHHQM7IM2J40pZMoG7PdrLXeUIIfzmrC+y+MLG073K/bKxx37iwQSgeqNcsUoK02jSlhT0iCTW6srUXpepyGgoQN1ZMAA/pW+5NA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from SN6PR12MB2847.namprd12.prod.outlook.com (2603:10b6:805:76::10)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.29; Sun, 6 Apr
 2025 15:37:54 +0000
Received: from SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b]) by SN6PR12MB2847.namprd12.prod.outlook.com
 ([fe80::1b1e:e01d:667:9d6b%2]) with mapi id 15.20.8583.043; Sun, 6 Apr 2025
 15:37:54 +0000
Message-ID: <615fdc6d-0c8b-4f09-a03e-996410bd0a65@nvidia.com>
Date: Sun, 6 Apr 2025 18:37:49 +0300
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net 2/3] net: Fix dev_net(dev) race in
 unregister_netdevice_notifier_dev_net().
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: davem@davemloft.net, edumazet@google.com, horms@kernel.org,
 kuba@kernel.org, kuni1840@gmail.com, netdev@vger.kernel.org,
 pabeni@redhat.com
References: <6ce063ee-85cc-4930-839a-36b3155c9820@nvidia.com>
 <20250401220735.94909-1-kuniyu@amazon.com>
Content-Language: en-US
From: Yael Chemla <ychemla@nvidia.com>
In-Reply-To: <20250401220735.94909-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: LO4P123CA0506.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:272::19) To SN6PR12MB2847.namprd12.prod.outlook.com
 (2603:10b6:805:76::10)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR12MB2847:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: fa805a08-466e-4a84-da2c-08dd7520ff9c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024;
X-Microsoft-Antispam-Message-Info:
	=?utf-8?B?cWhlUXppTG4wYTgwWEh0T2dDUnFadXB2RUZhdjF5dnBzNGR6ZXFtakMyam5Y?=
 =?utf-8?B?RWd6OCtLV2EveERnRE5xRjBUeHVGSzhwZjcrMlRiRFFzb3RSdk45YmYvYnNU?=
 =?utf-8?B?aFV2em9FQW5UMStPQjBsRTRxQ0U3L0hvakxEdEcyaGJ6RjQraG0yVXRNM0RL?=
 =?utf-8?B?Lzl2Ylc3VUZ6UjEzOU15djdBL2VMUkV2WkhkaDQvNkhJNC9OSEZCRCtaUWJv?=
 =?utf-8?B?MkdjZjdud1NwQ0s1aW5jd1p0aXUwVC95bnZYUDk4RkYwSFcwcWZnZlJIRHdw?=
 =?utf-8?B?TEdxZEFZcFdYK0hpM2pzcDVEYnFkVk1kWUlSbDBwazdWOUFyMm5pcERPb1ZN?=
 =?utf-8?B?ZVM5YVRPYmF4MXh3UjRpay9oUTFFT1lYVG10dnl2YUU5VHJiTVJkSi9ldVl5?=
 =?utf-8?B?Q2FsTGlGTWtqNzRUUStRb1hRR012aXBGSWI1R0lZUUR6Rm51ZWVVSlV6NXlQ?=
 =?utf-8?B?UDZTK2czZGllM1VzL2lBZzc5WUJmcktjc2s5VzA2WjNZN3gwb1QycHAyY1JC?=
 =?utf-8?B?U2lwVjJvU0ZaeEJMYWVXZHhjUytYb1pDR2dFd3NXd05PTGYrVnJNT1RITUNh?=
 =?utf-8?B?T2NOQ0lPV3ZqMFY5a1pENGw5V25wSi8zYmIyU0s2cmRJTWs0TmgwY3ZjVWpU?=
 =?utf-8?B?ZGRPdm5zUDQrWklWMjlQK0lCZGdHWmthUE9ta25qTkx2WFVHdGF0aWZiY3hw?=
 =?utf-8?B?RVF1bkFEZklZRU1jblpLZjY5SFRuMXdsUGxsaHN4QWJSYUVvSzBjRGIrT1ox?=
 =?utf-8?B?enRvdmZPSU0wVTA5NkZIVThBTUZBbHdpbFRqVCtOV2RuWW04WklyeUdva3No?=
 =?utf-8?B?Ti9EYVpRRjNHcnU1MnFhWTdyQkR2MkpmdEVGYU9tQkxibjlYRGhHVmdlcFlS?=
 =?utf-8?B?Vi9MWE01dmxFVmZRbE5TTU9YT3A5YXZOditLVVBadGZWQTUxUC91amFpU2tG?=
 =?utf-8?B?V3NxYnpMYzJuaDJ0YlZuaGRicmlJaDBIUndCWEt1M3A4bUxIZEs4MHhuVC9N?=
 =?utf-8?B?NDJRYW9HZzZNam13VUUwMUpUWWpWcDIyTFo3STBBdFF0K09md0loNTFjQk9q?=
 =?utf-8?B?a2VJV1hSVUxTck9vMGcvMitBSEVPTUZvQTlTSlNyYjJ2ZllVc1ZZVXhEZ1lI?=
 =?utf-8?B?aXJPZXkzVkc4R2RJVm1hMGtzVTZSVVpnbk9iWE42cmZQbTdybTVmdWpOZlVH?=
 =?utf-8?B?RVNya3IvRElwd21OKzBFclZyK1Erakk5Zm84R1g2RXZmM3hEYkJma2p2Z3NS?=
 =?utf-8?B?QVU3bTladUNLNGxneXRJeHFja3hpVDc0UU5GTEs2djJGNzczdVlNdkZBOWdB?=
 =?utf-8?B?WDBYMDBpdVNaM00wbjBsNXowNU03ZmFFVisxaGorenhrTkhQd2lHbTZrVE5U?=
 =?utf-8?B?TVE5S253WCtyTlRyRlRBK2RPaGsrVXZnSDBWWVZyckp1MDd1RDdXY096NTk3?=
 =?utf-8?B?Wk84czQxZDFrQXVmSnR1T3lwQnVvbDJQcjZIRmFRSDJLeG5UbVphRWZEODdn?=
 =?utf-8?B?bVVKVWlSdTVtVHhrQ3RaSDBUTU1FV0dYSnNTMmdSbDBlOWFCSEw5R2tKRmFl?=
 =?utf-8?B?NUYxNk5UWk1YbGpZUHpEb2hEcmplVUtjRUtlRFZnSURQUHdvNVNSaDNjbGlZ?=
 =?utf-8?B?bUkwcys5UTNpZTBSTWhPVkJ2bVBldVkvUHJhdWNRMWxZQjk5U1U1Z05DOFVy?=
 =?utf-8?B?Z0NTelRqVHplNnhZaERzNlRQVXFYNHk5T1RLWGcrVmNpb3U1bVU5Kzlqb1hs?=
 =?utf-8?B?T05ucVVwNFFhdnoxTE5zWDFlT24wSlNlWFduOHZ2aXZlRndURTJGc3hQSEVi?=
 =?utf-8?B?ZnkzYVpVaDJsWkdVa1FiWVg5MXlTZkhYYTJVWE9iN05mdE8yWFhVbGswbjd6?=
 =?utf-8?Q?u1vDeRfLIAJ4n?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR12MB2847.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MkNGaWIyUVROcVk4bzd4cWNXcFllL1RjNUYvNHIrSkNRYklqdXNDd3JiYWQ0?=
 =?utf-8?B?YlJiUXJ0NDNSZ2pSWVRVaUdNV2NnUUR4dmVWcG9GaXAyU3BCT0srL0FneTVm?=
 =?utf-8?B?Zng1S2g2OEhEVlU3M21pN3NudTR6WDlMT3Q5dXdqcUpFRjhUa2tJYzVNMnlM?=
 =?utf-8?B?SWV2cGF3VUgwbVg5cTRLSmJqaFZGb2FxR05OTVEzRGZZNVlEaXlBWGRXK1d5?=
 =?utf-8?B?dFdyMDZPNkd5V0RzTE1EdVlEUnR2K0k2R0tFTVBNK29UbmNtU3RRQVRVSUJU?=
 =?utf-8?B?bXJZWmMrcFk3NkRHMldlTkN2V2pITUY0SEtzR3U2YlFKaW5hUUNBajFybmM4?=
 =?utf-8?B?T01MWHh4MXRVUTJTQ0J1V2ZrRFpMOGhtUTh3UmFYcWI3VDlJVTJBQU5Pek1F?=
 =?utf-8?B?VGlsS3ltUWllSHpyQ3dEUGFSS1VoVjFNcklYYUViVlNJM3Z4LzdYQmZUQnFV?=
 =?utf-8?B?NnNyYk51QW9NRG5EcXdvdytqVk55cmhQK3JYN0lvdVNjRHlRN09kc1dqM2pY?=
 =?utf-8?B?QnJhWWlPKzUzNHFSeTV2RmFnZzh2bjZwRnZLbWVGamxodlhjZUV3OTNhOURX?=
 =?utf-8?B?ci85WWxKcGhYVjBSb3JZTVdlM3hXTGRIZ1huK2NrU1ZHRzhNcW13MkhRNVNF?=
 =?utf-8?B?aUQvc0I3Zk9EYk02c1UyNkZaYjZpTlQyRkNWMi8zUXhjSFpBYkJDSVZFeHNj?=
 =?utf-8?B?WXpsTjNyUnRYZi8zK2VmNExRZTd5bWdPVW4xYmo2VnJ1RVh2U0JCUklyTk0r?=
 =?utf-8?B?ZjlHNTBOeHhTaTV6YUt6RWdxSzJpS3BCUEF5YTdmaGpkUEtqQjR0ek8vNjUw?=
 =?utf-8?B?MGFQeDgvYWMyM0pza3dNU2ttOFc1WXJkVTIrNVhYZTdhMmN0Vm9wdGN2elNn?=
 =?utf-8?B?eVlvQXdJQjdFSjcrOUIyMHRNc0YxOHpRa3Q4K25kUFJTaXorQ2VZTHpQU0lB?=
 =?utf-8?B?NzZGZFYzdjBQV0tVMGdndldISHVKelk0QStDbmRNM3l2dnpOZGNyai9Mdno0?=
 =?utf-8?B?d202WUtMejJaUDdNUGFUQjVCdlpGaUptc0Exa2xlOGpkTDEzV3JVMTgydmhm?=
 =?utf-8?B?WWZUMFp0SXlpZWNOOEEzS2hRUTBEYnNMdklQdlkrM3RaeWxZenc5bEg5KzFn?=
 =?utf-8?B?RWE5VEVtTXJZL1JOVEdmdjJDUUp6MFdrejFQcHR5dGNEUW16bWl6QU5rTXk4?=
 =?utf-8?B?cG5TcVpkZnIwdnJHY0EzU1JJWEtEb29RUS9aLzBkQ0t2M0c4OWdrS1NmMEhl?=
 =?utf-8?B?NVNUUHVsWkxnMzhiZ0ZudEFGQktpYXpuYzhySmQyb1pLS0NQMUFBT1F3RTR6?=
 =?utf-8?B?enVpaTg3MXV1dzFvOWVHR0JsaDJwa2pZUWJiRjRIQ3loOStyUitCd0JxNEVl?=
 =?utf-8?B?WDZLa1hGcUhVY0lFRGcxZkdoYm5iS3pzYkhlL2w5ck45cVI5VnNvbFg3RU1j?=
 =?utf-8?B?N29KaTdocGpuMTZoZzloWUQvWStEM1F5QTVibVM4bmVzanZmaElZbm9zaTFX?=
 =?utf-8?B?bzFNeThJRytVaFR2ZmlrQXpCZnhYcFBUbUR3ckFRMEVZWTFBakJZcStLSTdM?=
 =?utf-8?B?WnpHNjEyZ3VDZlFUOVpaTzYzTmpQT2NKbHFZck55ZC8xR1VnaXJ2QUJDekNr?=
 =?utf-8?B?cFZHZUxubXlMUFBhYTh0R1VXaXBvL2JtSXE4MVVmeUZFZzlqcm9TTlZXeklx?=
 =?utf-8?B?QkZvemZIVEQ2Y0ZUcHlQTm50Ny9aSlQyUzg0UkMzM1ZOd1p6b3RMMVE0OExu?=
 =?utf-8?B?aGJnKzJ2am9YS0dVMXFWS0RyTkpicWRjWXZlQXBYL0g0aWF3MWRSMHhveWFV?=
 =?utf-8?B?bVRQMGlrZWNGNVp5MlpQL2NWT1J3V0pJcUhoOW9wKzI2WmNxc3N2Sjk0UDJJ?=
 =?utf-8?B?RE95dTBJS014dkFKTndtVWwrenVGSXdvTlB4V1hVbHhYV0ZXOTVVMDBkWU84?=
 =?utf-8?B?YWhWL3B4cjdTc2VEUXBERlIycjB2ZlFNSXZUazgySExaK3R4czhjYlozTytI?=
 =?utf-8?B?WGJMNzFuZzBiZis4dkhqQ1lndkwzMzRzUEdQWUpzYW1XbnRiME96ODJiOTJV?=
 =?utf-8?B?RkdMME1ZL3o2NEVXMTdlSTZsSm1NeUZpOWJrL2djK2JWTjlxcFRTT2p4ZkRI?=
 =?utf-8?Q?8KfkN996u/nFKsNcl+PwXxL12?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa805a08-466e-4a84-da2c-08dd7520ff9c
X-MS-Exchange-CrossTenant-AuthSource: SN6PR12MB2847.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Apr 2025 15:37:54.6413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: IiBxRDgfkw7YnsqEOFw8gCLaxDwh/IlxPPOzgaKXx9KRxEA/9filZ323rDNNR67NZONTn6cS9u5HKWeIW1xWKA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617

On 02/04/2025 0:58, Kuniyuki Iwashima wrote:
> Hi Yael,
> 
> Thanks for testing!
> 
> From: Yael Chemla <ychemla@nvidia.com>
> Date: Tue, 1 Apr 2025 23:49:42 +0300
>> Hi Kuniyuki,
>> Sorry for the delay (I was OOO). I tested your patch, and while the race
>> occurs much less frequently, it still happens—see the warnings and call
>> traces below.
>> Additionally, in some cases, the test which reproduce the race hang.
>> Debugging shows that we're stuck in an endless loop inside
>> rtnl_net_dev_lock because the passive refcount is already zero, causing
>> net_passive_inc_not_zero to return false, thus it go to "again" and this
>> repeats without ending.
>> I suspect, as you mentioned before, that in such cases, the passive
>> refcount was decreased from cleanup_net.
> 
> This sounds weird.
> 
> We assumed vif will be moved to init_net, then the infinite loop
> should never happen.
> 
> So the assumption was wrong and vif belonged to the dead netns and
> was not moved to init_net ... ??
> 
> Even if dev_change_net_namespace() fails, it leads to BUG().
> 

Hi Kuniyuki,
In failure scenarios, we observe that cleanup_net is invoked, followed
by net_passive_dec, which reduces the passive refcount to zero. These
are called before the call to unregister_netdevice_notifier_dev_net.

During the test, dev_change_net_namespace is called once, but it
operates on different net_device poiner than the one passed to final
call of unregister_netdevice_notifier_dev_net, a call which enter
infinite loop (with net->passive=0 and net->ns.count=0, inside
rtnl_net_dev_lock, as explained in previous mail).

Do you need additional debug information, perhaps specific details
regarding reassigning the netns to init_net? Please let me know how I
can help further.

>>
>>
>> warnings and call traces:
>>
>> refcount_t: addition on 0; use-after-free.
> 
> I guess this is from the old log or the test patch was not applied
> because _inc_not_zero() will trigger REFCOUNT_ADD_NOT_ZERO_OVF and
> then the message will be
> 
>   refcount_t: saturated; leaking memory
> 
> , see __refcount_add_not_zero() and refcount_warn_saturate().
> 

you are right it's a mistake, i was unable to reproduce another failure
with call trace info. Test either succeeds or hang (infinite loop).

> 
>> WARNING: CPU: 4 PID: 27219 at lib/refcount.c:25 refcount_warn_saturate
>> (/usr/work/linux/lib/refcount.c:25 (discriminator 1))



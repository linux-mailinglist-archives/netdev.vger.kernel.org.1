Return-Path: <netdev+bounces-77725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E0A872BBF
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 01:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D50A31F217B6
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 00:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A2A2647;
	Wed,  6 Mar 2024 00:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="krBkHQS3"
X-Original-To: netdev@vger.kernel.org
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2049.outbound.protection.outlook.com [40.107.94.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B76173
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709684877; cv=fail; b=HxXX4IkUuq+fv5reFQYzDNY+5SKEXZCJrBXg0T2vdl9pnhL1aMdEz7lDdrkfrK/JIes006cy+iYUr4P/0s9zQy7jmif53iaYlMkGiCzluzFgCw3YXUSAJpGpuC90YIh+ezkYO3z/GW6tCnSN+4E9Lts80HV55c/5E5dF4OUihw8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709684877; c=relaxed/simple;
	bh=+/GzYYCpwuZhXLmmQTx1/kL1ktSPL+uIEFW2QgGLMGg=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=SJl8ohk7+Nvcvh9HfiS9FW4RjQZfy2HRSA6jJdkBt4HSFrUO7m1HCHpnAcP9g/NbwovkIC+qdNBhjzfFwCFnGx6LXvNt34+b0bRjMQKYOx14rqoRTd8Jxdq9faF/g9mHk4uIlWYWPmDX/6byOMTu2Dizy0IREagfVUs4Sn6msi8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=krBkHQS3; arc=fail smtp.client-ip=40.107.94.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=l5jnD56fBRG33ElHyJ3rrTuGuA2iU/wlmH0OaYPChL65PfFp5Ikm20X8Yq5/4e8ZQNIBBU+ChkAorrSWSFCVd4WeSfLcISukUYcBfdIVPX56GbacaQzz/Xnub5wGWQmRGSgG5uizKSGh6FvW4wW8X79NTMx+JF6I/qepK7liF0Ttp3sNdGv8AbdW6LbrrqlD7GCoptrJtFheMwPDZPh8xMe+YihoTBFrE68DZc2HUvaRLmWTi3nJz+5QSP/mZCDxzb6JOOXrR9FEf7qLTkL48hVLrgrdADB88mt743Eo2ilJA0MP8tSLlGXY814QuMB4QOZg8QnPJC8mHTq2nefPrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=icD/KkMxplHJoaPIiNZEKgg/d0+ehYIBeITe7xlT99s=;
 b=dmLKcN+ba0ERCudwoHNoOXv+ofr3d2HSZKLSOqEJLCp+fD/24h/cDeErpyAXl80Km/jXv+FvxDcuSno7PzqG9BatOS+zSGVwWyAKC+0Zkho61vtbgteDDApzoB3AiRDf9y6dDrBCijYrWrSr7wj7UjI745t1oyYnFt9X4aUg/0u5muuXlyrS4vTWLrUVpyuA3veupajyiQV5T9NZMWeCykYhoEdTff96mLGWOSSsolCb1ifdIf7e2UtsWO+r27QTJ9OJE+c1wvfzDRgrKL80tsfImxR3rw4sYVVBrCpbdDpF8nCPc4YRKm9udRTL5wELLGkiKe8jHK33zYUILDx3lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=icD/KkMxplHJoaPIiNZEKgg/d0+ehYIBeITe7xlT99s=;
 b=krBkHQS3MUcT/1hF2K2BikuayzbgSC+gGpHIIbjAcH/2GbITL1StcU/Y5HieSf8bSdsj4w0Np25mAQ3/gfnVePPY7HjvyZMjraZNHkpSRHehLAC9/83eUeibnDtMVcMuZD2tyhuOhd7+Ojj+qz4dKsj/cjbiynQFAkwauAOq1YFZncJO6olshiKMonG1nXXeLMWCQM1OKW51IarIUUOL6MKkYM8iGORI/AE11zOjDYpNKhqR0O12WgKf2H4zqAxlfTplsY0atZ1LD5SWnwN3Squkt5lwx4cGKZ4EuJkkZvOeQMaVEvgljT4Sotq1cwB7rr51s+RzwS/NuFWVHBlZFw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from PH8PR12MB7110.namprd12.prod.outlook.com (2603:10b6:510:22e::11)
 by CY8PR12MB8337.namprd12.prod.outlook.com (2603:10b6:930:7d::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Wed, 6 Mar
 2024 00:27:52 +0000
Received: from PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c]) by PH8PR12MB7110.namprd12.prod.outlook.com
 ([fe80::b610:d12a:cca7:703c%4]) with mapi id 15.20.7339.035; Wed, 6 Mar 2024
 00:27:52 +0000
Message-ID: <49a53cb9-e04d-4afa-86e8-15b975741e4d@nvidia.com>
Date: Tue, 5 Mar 2024 16:27:50 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 net-next 1/2] devlink: Add shared descriptor
 eswitch attr
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
Cc: netdev@vger.kernel.org, jiri@nvidia.com, bodong@nvidia.com,
 tariqt@nvidia.com, yossiku@nvidia.com
References: <20240301011119.3267-1-witu@nvidia.com>
 <20240304203758.2fd0f6be@kernel.org>
From: William Tu <witu@nvidia.com>
In-Reply-To: <20240304203758.2fd0f6be@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0245.namprd03.prod.outlook.com
 (2603:10b6:303:b4::10) To PH8PR12MB7110.namprd12.prod.outlook.com
 (2603:10b6:510:22e::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR12MB7110:EE_|CY8PR12MB8337:EE_
X-MS-Office365-Filtering-Correlation-Id: 091ac28a-d5f6-4434-3431-08dc3d74429c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	SeiEADaL5CsQSX1sgshLrbPlcatHnsGEkw1O0stHyjy4ggFdeTx7Qsx/yq+1UFTvGEiBomFdK9ojsBXHquRCKeYMgzLFOHc4VdPPc/8WPgYIKiaf3MLsSTr3M1WdLJ9Xt1e5PvO5mgX0Xfxgm3Ij49MQRgkw6WQUvdmiDTNtN7ISf/jL/D2Lm+ZuHEH8ithVMYSjA9vv6+9qVAS887s9nCBCal6gxAEokUJ5ftTrUGrqxH4Cen4OVeoIGmADWLy7Fy14nHubpECG86lI1HAWQUCLxRZ38kG4gWk/MGcqJ7+AEf77LGnVXLNho1YbujQ6j/btbUcFwAb6yUdrV2YwHRFbotbJCQ6m1ouzzaSHtdChapqLYKdh7/JFfGQkwNHUWyepcHn0auUqE/OuSTdNuS6JPExnUvYVEv7qeP9DEyePW1JUPxHPic+q2yzaZrlu688yKqUGfJ9C8r9G4PQp9yZvbD1Pli8cgP+joHrWamTi6eWi0gQeKgiA+uQKxiCbPHJ4GMBhs54EnR6MwdiEm2IlTOJ74yLnvMCIE8I/bUfDykdZJSUEqgUv19lxSGHrZ7cXNYjj883ysxdi07UpiSZ+vlSZRKlHY7c3KynfZa1PKGyO6jijoiNwYQqbMsJxLLy/J9QuR01Y6/LUDXbCuObF/FH/68dcGOttlaKbdN0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR12MB7110.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?WGl5a09hWTI2Vm1tdkNJYk5qZEwzQjdvVmtYRXU2MFY5cFBuSWQ1S1FzOHVz?=
 =?utf-8?B?c0hXYTlnVDVYVDlSVkRHSlZONUQrVFkwa2FEWjdtUEJGTnpPS2N3U0hKdmto?=
 =?utf-8?B?bHlDaWpzdlJOU09ZWmJvVzFIU2hFSVFPSFlSK0VSTXpFd3UrcE16VE9zdjhE?=
 =?utf-8?B?RmlmeFR3dW4wY2E4dnIzblVJaENWc2puWTFYbDZwU2h5TGljMXNLSmlXR3k0?=
 =?utf-8?B?SUZMYWtXeVR4TVBxaklqTHBIVWRON1dkWHAxTkZ6Y2V3Uk9PdXVDYjBtcjlE?=
 =?utf-8?B?RFcxNWU4WGJDU3pQTGp0WWkrbW91OERRVCtEcVAxY2d2cW9kN0k5WFNnamxP?=
 =?utf-8?B?R1BZU2szVzVXSGNwSmJoc3JZVEtDbzJoVldLL3VsNFNkd0tWdko0cGQ0aHJO?=
 =?utf-8?B?aGVCYVRDaWFVcGh5cmVBK3RyMS9qOHVlcy9HdklMS3ZkeEd4UzErL2FPMEQr?=
 =?utf-8?B?S3FtZVN3Vk9FWE1sbGhzajVuMmxBcC91clhuSnA0NzQ0UHN0UXA3aVFtOE56?=
 =?utf-8?B?d3VpWnQrR21vdnBucFZROGtNUk9zVnk3Y2lxeHlGNHhhUlpsdmtqZk0vSUU1?=
 =?utf-8?B?RFZzNzhZNzYxeEZJODhPb0hvVXpkN3VpYnd2QkJSUDNqT1YrV01ReWJGa0xk?=
 =?utf-8?B?VXR4YmMrUXB1ZmdHY1cvb2x4ZGR4bWNrOGp4U2hsQUxyYnUyUzIwOEt3OWpy?=
 =?utf-8?B?RXNPTk9HNnhuRnJZODR2V2hsdnlGNUVUVFdhaHdsWWc5ZVBLQ3MwaTZvK0dp?=
 =?utf-8?B?RkEzSHU4a3FXRkYxczYxZkZaRGtEUzVtcFVweXNkZFFUS0hsYld5d0NDRDIx?=
 =?utf-8?B?TDcyYlJZRmRGakhrV0tpNEVDUXFxN1dCRFkwbHhQR2FvMkpQMzBSZmRzQ2kz?=
 =?utf-8?B?KzN5MW40enhkN1Q4blowSUlEclFnZEwrMUJnTXpSbFVRYnlpdzY3WFJrKy9O?=
 =?utf-8?B?K0dGZGo4UEJqMmNrZ1h4Yng2SFhNd3d6TVlpQ0NMMHptT0d1UWJ1SlI0U29j?=
 =?utf-8?B?TVhGc3crOUtLeG42c3g5eDNUNFFVbnRmZVc4SkR5ek1PVG9UeDZYLzMyRTJ0?=
 =?utf-8?B?MWYzcmtGc1NKcEdBY1V0U1hHTmttS2hqajdna0VlZ0Nuamo0ZGlVSWJLMHM4?=
 =?utf-8?B?YnNSc05vdDV4TUxwQS96a0l0Q3Nyb2RwOVFsdmhqVTkweDhzbit1UHFnR3Br?=
 =?utf-8?B?czhxRVl2Y1BCTGlnVUtjTExRVUluWDJJWWtQN1Z0ZjJoaHZ4UkRwalBHQksr?=
 =?utf-8?B?M1Q1dWE5d3lqL1Z5TmpMbWR0SUFCamU4WEM4NEhTR1pvc3hUeEJROHBaaitm?=
 =?utf-8?B?RGxEQ1hVRDkzak13VWhOd1hSU0dqL1RCMHloZHRUalF6RHdOcVd6bUk1YlVr?=
 =?utf-8?B?TWxsMjc4N2g5RWVLL2hGK2hBM1E0OE45ZDgzM3FKTGlQTmtQeGxGaEpWNlQz?=
 =?utf-8?B?SHJuN2JObnVzSUgrb3ZrcGwyUWwxVnNIblBaZmw3UVpGSldvb3V1TjM0aXpM?=
 =?utf-8?B?WEtGdVc2c01xTzhYdkpmckFXNTBmbGhqUFpOdUw5cGdsSjcxYlpiSFlvbTRE?=
 =?utf-8?B?SGREby9NdmQwY01BQzIyMTllYUNyS0Z1Q0ZVS3dUSWROakJsNEZkb1k3akJ6?=
 =?utf-8?B?bE5SeHE0TmVncFpCWnFrTXBiSDc3ZFBzOXBtZllibVVjU2J3Vnptd0hVTjdM?=
 =?utf-8?B?R0dJZjlHOG5SZkhQeHRWeXhIVHpCc2pEWkllKy9VUFZPMG9qS0pzK3VuR3B3?=
 =?utf-8?B?S2ZtSmoydXdINTFvVm9OK250VEkxblpHNFNEYnlPMzdBZXlTT3hSTFE2UlJu?=
 =?utf-8?B?Tk9CUy8wVG5EQnliY3NQMkNSbkNjdG5MNnRaUGFBY1h2SUd3ZGVjYXVMYUti?=
 =?utf-8?B?d29xZjdaM0NxRUxyOEJwVDdCNGR5cUFiMWRGM2FGTWFhNC9qTlFHMjRlb3RD?=
 =?utf-8?B?RXVxU3RBcWt1b3R5S2tza0U0eEdpZFhVZ1FLb1hXMjBmZnJTcTU3Z2NDYVlB?=
 =?utf-8?B?MXVZMHAzZXloTmNnQUkyY2gxTENCSFRXZDlVV1hBUVowdURacng0L0JFQTQ1?=
 =?utf-8?B?TENLR1V1T0Z3bEsyRllQcHRhanA4M1EvUUxicFBrbTlxMnZMZ1M3VWE5Rm80?=
 =?utf-8?Q?HZmRj5TR+JFq+jJR9tfLVzlNO?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 091ac28a-d5f6-4434-3431-08dc3d74429c
X-MS-Exchange-CrossTenant-AuthSource: PH8PR12MB7110.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Mar 2024 00:27:52.4441
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ajep+qIXh5m3AT4S5m23htPoTQg/BguHodbIp6G+2daHGeNiOyLBe093kf22kTYH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB8337



On 3/4/24 8:37 PM, Jakub Kicinski wrote:
> External email: Use caution opening links or attachments
>
>
> On Fri, 1 Mar 2024 03:11:18 +0200 William Tu wrote:
>> Add two eswitch attrs: shrdesc_mode and shrdesc_count.
>>
>> 1. shrdesc_mode: to enable a sharing memory buffer for
>> representor's rx buffer,
> Let's narrow down the terminology. "Shared memory buffer"
> and "shared memory pool" and "shrdesc" all refer to the same
> thing. Let's stick to shared pool?
ok, will use share pool.
>> and 2. shrdesc_count: to control the
>> number of buffers in this shared memory pool.
> _default_ number of buffers in shared pool used by representors?
>
> If/when the API to configure shared pools becomes real it will
> presumably take precedence over this default?
yes, if that's the case.
>> When using switchdev mode, the representor ports handles the slow path
>> traffic, the traffic that can't be offloaded will be redirected to the
>> representor port for processing. Memory consumption of the representor
>> port's rx buffer can grow to several GB when scaling to 1k VFs reps.
>> For example, in mlx5 driver, each RQ, with a typical 1K descriptors,
>> consumes 3MB of DMA memory for packet buffer in WQEs, and with four
>> channels, it consumes 4 * 3MB * 1024 = 12GB of memory. And since rep
>> ports are for slow path traffic, most of these rx DMA memory are idle.
>>
>> Add shrdesc_mode configuration, allowing multiple representors
>> to share a rx memory buffer pool. When enabled, individual representor
>> doesn't need to allocate its dedicated rx buffer, but just pointing
>> its rq to the memory pool. This could make the memory being better
>> utilized. The shrdesc_count represents the number of rx ring
>> entries, e.g., same meaning as ethtool -g, that's shared across other
>> representors. Users adjust it based on how many reps, total system
>> memory, or performance expectation.
> Can we use bytes as the unit? Like the page pool. Descriptors don't
> mean much to the user.
But how about the unit size? do we assume unit size = 1 page?
so page pool has
order: 2^order pages on allocation
pool_size: size of ptr_ring

How about we assume that order is 0, and let user set pool_size (number 
of page-size entries).
>
>> The two params are also useful for other vendors such as Intel ICE
>> drivers and Broadcom's driver, which also have representor ports for
>> slow path traffic.
>>
>> An example use case:
>> $ devlink dev eswitch show pci/0000:08:00.0
>>    pci/0000:08:00.0: mode legacy inline-mode none encap-mode basic \
>>    shrdesc-mode none shrdesc-count 0
>> $ devlink dev eswitch set pci/0000:08:00.0 mode switchdev \
>>    shrdesc-mode basic shrdesc-count 1024
>> $ devlink dev eswitch show pci/0000:08:00.0
>>    pci/0000:08:00.0: mode switchdev inline-mode none encap-mode basic \
>>    shrdesc-mode basic shrdesc-count 1024
>>
>> Note that new configurations are set at legacy mode, and enabled at
>> switchdev mode.
>>   Documentation/netlink/specs/devlink.yaml | 17 ++++++++++
>>   include/net/devlink.h                    |  8 +++++
>>   include/uapi/linux/devlink.h             |  7 ++++
>>   net/devlink/dev.c                        | 43 ++++++++++++++++++++++++
>>   net/devlink/netlink_gen.c                |  6 ++--
>>   5 files changed, 79 insertions(+), 2 deletions(-)
> ENODOCS
will add docs in next version, thanks.
>> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
>> index cf6eaa0da821..58f31d99b8b3 100644
>> --- a/Documentation/netlink/specs/devlink.yaml
>> +++ b/Documentation/netlink/specs/devlink.yaml
>> @@ -119,6 +119,14 @@ definitions:
>>           name: none
>>         -
>>           name: basic
>> +  -
>> +    type: enum
>> +    name: eswitch-shrdesc-mode
>> +    entries:
>> +      -
>> +        name: none
>> +      -
>> +        name: basic
> Do we need this knob?
> Can we not assume that shared-pool-count == 0 means disabled?
do you mean assume or not assume?

I guess you mean assume, so use "shared-pool-count == 0" to indicate 
disable?
That will also work so we only need to introduce 1 attribute.
> We can always add the knob later if needed, right now it's
> just on / off with some less direct names.
>
>>     -
>>       type: enum
>>       name: dpipe-header-id
>> @@ -429,6 +437,13 @@ attribute-sets:
>>           name: eswitch-encap-mode
>>           type: u8
>>           enum: eswitch-encap-mode
>> +      -
>> +        name: eswitch-shrdesc-mode
>> +        type: u8
> u32, netlink rounds sizes up to 4B, anyway
ok, thanks!

>
>> +        enum: eswitch-shrdesc-mode
>> +      -
>> +        name: eswitch-shrdesc-count
>> +        type: u32
>>         -
>>           name: resource-list
>>           type: nest



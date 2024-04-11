Return-Path: <netdev+bounces-87070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 20A958A1878
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 17:20:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89E2F1F266CA
	for <lists+netdev@lfdr.de>; Thu, 11 Apr 2024 15:20:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1745110788;
	Thu, 11 Apr 2024 15:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KoegzZkf"
X-Original-To: netdev@vger.kernel.org
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2078.outbound.protection.outlook.com [40.107.243.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C95CF9C3
	for <netdev@vger.kernel.org>; Thu, 11 Apr 2024 15:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848753; cv=fail; b=N5a0vquINbjXb16cLMvuNSzf//J5BHbySfE+6L66u5yZvc5RXKOF5UUWsK6HwlMWcFHCHK4QC48KEi3Hx4QjQK/0PetGbb9URPF3nkiX4LtwFt8Hvw5lfGXrCs4FBq//TAe0hrE1NLsJx+nplaeIz4z66T3KsbjrhxX2ECX8XQQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848753; c=relaxed/simple;
	bh=c2iaVU3dBX5ZjGV/44dpDvHUFdA0RKi9k8yykTRecxk=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=G3SA7po72DKEnegCHVK6jKFajczyDyfNl1aiD65Uxw/zJVEJwp7BzP7DbXsvnPujHubFLlpDyl02K4hZQKyULntqJEHEDtcWx0zXveMwk8Ops0EUo3nVfiQ9JtAb2brRfHTnXkO1JfoQ0fIM9VwHE6gVyfE0j5s5qMrs1GLvFGo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KoegzZkf; arc=fail smtp.client-ip=40.107.243.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nz+GEtcwILwM4P4Sz3wE7juPZfy7KFYXORwvcyhabG94swKyEB4tmgDBuJr9/UVDhMLhvmPobMd5Xxa4WDAO5SnfSZRT7ZBOna7tcuQY144msJ+bAbltlrGckLlbp4Qk9cUvbw0ZJegTwm2I6Gew3iTb1vcgV7Gzr1f46eiA9rb6YTq9+vsUFlas2e7JcUrec/7hYKThcR67WBBtkGJ6Uvfyvg57FsFCT43n+LmhH/t67ph6jXKdYb6zNUAX5VRV6ZK64FpmZCeoNJZxa/5zkClzt4VXDeN5c8L1nkZoVwohWBLi+QL76vnlRp3c16BMwPlMKmG83DGOpgSC7RObVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQbJqTvL12DktRXacqDaLkdBnII3D4XyRcqjIA92xo0=;
 b=HdTBe4AnkfEWVoUUauyWEpuClAb7QYdUtzqeipMyp+2OVEqvAdu83p3YIFfUlCeT7YVSxrtevpODcSbH81EZ6pGoLbGeh9sdGjv8Xd4l+Sp8V/UZbi7aYXZWcAj2BOZg9Ty/Ixk8wc2pRNJh8gGdsuqA7zzFvcvnZ9HrvdnPNtwaqQbsTz2DQC5bI8hIOazv1/ErVbLHR4uMhI3aq3mcs5iF88Ngzk+xQX/+iUBiRbwyXPy/xUVPQfm0YrtaBJywDUSApkynRjAzprXCpwBSp2eGV+jp9t5jbSw9oD31yaPcKatngkxvB77gmqwlmvp/TGjTPrkR0nwqQ0GJExGyIg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQbJqTvL12DktRXacqDaLkdBnII3D4XyRcqjIA92xo0=;
 b=KoegzZkfHyN4876XeUlR5Zgls/KRRZSqBOLo/Bn6wh+ERlsWENOfismR5ECylgc1txTTkisr1HWAQKMMf9mXe2qWlH+/SDk5odARRWSzu04knrpOT+zl5t2C0bNLcO5lHYjGmD4BrhfEXkyuky1ev8K61P8PkfjTmjVii7t9qJ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SA3PR12MB7975.namprd12.prod.outlook.com (2603:10b6:806:320::11)
 by CH2PR12MB4261.namprd12.prod.outlook.com (2603:10b6:610:a9::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Thu, 11 Apr
 2024 15:19:06 +0000
Received: from SA3PR12MB7975.namprd12.prod.outlook.com
 ([fe80::9291:f4ca:ef21:c217]) by SA3PR12MB7975.namprd12.prod.outlook.com
 ([fe80::9291:f4ca:ef21:c217%5]) with mapi id 15.20.7409.042; Thu, 11 Apr 2024
 15:19:06 +0000
Message-ID: <b0c8d0a2-d6e5-4138-96c0-e9dbbc1c8b20@amd.com>
Date: Thu, 11 Apr 2024 08:19:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 2/4] ethtool: provide customized dim profile
 management
To: Heng Qi <hengqi@linux.alibaba.com>, netdev@vger.kernel.org,
 virtualization@lists.linux.dev
Cc: Jakub Kicinski <kuba@kernel.org>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Paolo Abeni <pabeni@redhat.com>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Ratheesh Kannoth <rkannoth@marvell.com>,
 Alexander Lobakin <aleksander.lobakin@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <1712844751-53514-1-git-send-email-hengqi@linux.alibaba.com>
 <1712844751-53514-3-git-send-email-hengqi@linux.alibaba.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <1712844751-53514-3-git-send-email-hengqi@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0173.namprd03.prod.outlook.com
 (2603:10b6:a03:338::28) To SA3PR12MB7975.namprd12.prod.outlook.com
 (2603:10b6:806:320::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA3PR12MB7975:EE_|CH2PR12MB4261:EE_
X-MS-Office365-Filtering-Correlation-Id: e237d41d-6206-4e83-0289-08dc5a3aba37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zsRTLBBo+4ximzj2bzw4sEaNVu8AzPw34+B98wluy0+Z9JLHoFA0zcOjwHdbT8vnHJQP4zJMOn5v9eFYDkee3X/5smYOX8uw/zidXdEvC2LxfLOjqFApNU4Z4WUsWFyQs8CkJqCsjTvIe8vMNxfTSf9/Dnqve6hhhmxdKiVFUecVn5RpzBsEvF3/iKom9gVAFLA/RIGs1rDNU6MrQU0e2kUPArkGTpksHuvrdmfljstjYJl7wePz9QVlAyGNKABufPoKgUteZubuf+Az69cO/pjS0zmj76c+D80GnovKWRiahOPntE2ixmEzzS4ltJPTxKo3axfKGuSf6xNPS/FDlPG2+EqLZtBeY8EJ1aBcxp0SGgUYb+NDcjaOW/nsrVTMvGphmDa4BgdovR6YpeyXkhYoMKCc/K3jtJc7e5V00RrHBYWwZrbvz4YpkEhYVfYwVnfIU7YHKyWFQyfaRcejcScFopTJDHv8IPW+N2Y/ZhUmDmgiGI930InD+yY2X6xgxn8GPGUPDc6yzBNb1Om9NYeOOVSvj3dZrRZns7/Jt9UXCAXtSZqeJMy4OdPwZoAwMW8+UR48+4XT+j9q/kzbYWbUEjvdlZP8bFkYpnN+ypeO8E6Fj7l8rlJx/+3e0fcyHhfcKOH1nUL/QG6ZxS/3Vv2nNuhP7DT+kGW5GBgl4To=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA3PR12MB7975.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OWRtWGhrMGFyeXF2RmVrWGtmWWdqaGFtOFZkUWZXSG1WOHNtQ2d0Wk42b3NO?=
 =?utf-8?B?QTlPMTJtaXFmTnVSVmlrNitkK2UvUVVhZU1jTXUzSWVhWUQrNG91VVhVSDZr?=
 =?utf-8?B?TnVsM3p1QVUxNGswbHA5c0FmTW1ORGVEbGlISzlXNUtiUzZkaEdIcFA1SFB4?=
 =?utf-8?B?cHZuNElLeHR2RjV5ODNOa3A3Y3lNTEhtU2VGQjRSTFFwUHpiWi83cU90STBI?=
 =?utf-8?B?MjdBbDExYlMwc2M4c2FKQmZoS3IwR3RtclZncUpCamppYzNRUVA0QzNvSENw?=
 =?utf-8?B?YWhBUDF5OE9Ga1hZQ1RGSCtwak9kd1RBSHV6U1hickQ4NG1uZEc1TkJNeW4v?=
 =?utf-8?B?OUQvQXQ3aFhYWTM5dFp2dW03cjA3U0prTEZsUDlwajgvYlNwV1RuYVlMeVBq?=
 =?utf-8?B?WGRUTVdyQnVJNzZ1TkF5KzE1T1k2UlQrR05WczhEOEU4NVNjMXdrNUc1bzFt?=
 =?utf-8?B?NXFhaGo4bkhQbVhuTmgxVHJ5RzRWWVhFaWxkbGU1STJLK242RHVPeDdJem9G?=
 =?utf-8?B?cytrRXFtYWVRd2tTd3A5N2dEd3dQMHcyYWQxSGZWSmZpNkdIYmZwMk1BZmR6?=
 =?utf-8?B?aE90QzBkeGhQeG9kalJ4aDhVSzBNMVVDODc4aXdkSXYxempsajYxSkdIbnJG?=
 =?utf-8?B?UjVpSjRIdEFtcXBZSjVKcEtWRExKc1BVNE9JTkV1NExYdWJ6MHFHQWNGbmpr?=
 =?utf-8?B?WUVuaTlmblQ0WWdaaWFwVHAxajdoOUxJUkhrbWI4TmNoSjlHZHBabUVBVkVU?=
 =?utf-8?B?OG5xUURWY3lydnRWT29ycmtlK2dJY0ZHVXRhdkEyTkJrdklxcmpWbkZnVnc4?=
 =?utf-8?B?bmk1b0xVeUpCVUxMVml2L0Q1MFY5R2FTWWhEM2tPTVpYS21sV0dYQldzSys4?=
 =?utf-8?B?bEdzUWhLeVNJNWRmRVZhL0ZSTlhLaFVLYjRudk10OVNGR1dMZHNGeExiSXE0?=
 =?utf-8?B?c3FhT2VVVzkvNnUwd2IrMHh2cm4xMWx1N1N4Q3R1Tk1TUm96SDRrMkNwMHdC?=
 =?utf-8?B?R0V6TElURHJ1T09Zb2xVSTVpbzBiaTR1S0M2SUg4S0V0OUtVUnZvbG9VN2kr?=
 =?utf-8?B?NlY1NjFaN1h1MUJTcGJOT3BsVloyWTNncFNEb1lWVlp4WFhyQVlxUmVOWkxN?=
 =?utf-8?B?MDVlUjBuNnNqNTh3anNnUjB1djdQL3J1Ym9zcHBONDFIUjV3alNEWXNmdnk0?=
 =?utf-8?B?ZXFYS2laczArT1FOSzZoRzhPQklSbDMvM0IwVGNScC9UZWhWejlsV3hZSGw4?=
 =?utf-8?B?Ni9xODVjRU1GcHUwcmFHRDk3b0NIZDVCSS83QzBGZmxTcTdXelltd28xenBK?=
 =?utf-8?B?MFNueE5JU3QzRWg3VU00c1pIMGd0SkFNTjh1Z1MrT3l2bEFpM3pxNWJwbWdN?=
 =?utf-8?B?Qm5pc1ZHSkx0YnVWU3BjR0dBRHFsUk9OMTAvbWxPN3FCMWY5NEJOK0ZjYXBJ?=
 =?utf-8?B?UkcvdlJzVUNaayszeFlkU3BicjhaRVg3OHVOdE84RzNCOE56L0Q1MFBvazYz?=
 =?utf-8?B?SnN2cUo0UzJlWDRvOWppNXE4ZDQ5T011TWhKZVgxamR0SWRiRWRIRUpPdUMy?=
 =?utf-8?B?aXdqaEtCRDQ0Z0J0L2FRZm9ISERna3FTc0VQRHQ4UzNodnFwdU1kY2h5TTV3?=
 =?utf-8?B?aDl4U1JsNXNtVzVETmpidWRNWUFIRmJxZ1NCZmxuTmhWWFNqZUt0eFZyK0Vv?=
 =?utf-8?B?aVg3bHVDSDZ1QXBkOU1qVSt1R0lpangxYzlSSjVHZU5HLzlKY25LZ3liOG5l?=
 =?utf-8?B?d3VhZk12bmlXUHJlVmlmMG1aV2QrSFFzaXVPazhQc1ZMYjJCeitQM0I1RW1P?=
 =?utf-8?B?aTdvMFEzbzYxai9OSDNvS0MyQVJhZDdMZ3JJcWhRSVZZZjZib21PMmxwT3Fo?=
 =?utf-8?B?Y0JDS2NWOUFobGI4Q0xqa2FRNUtEaGsxOWlwQm0xU2ZRZDNLZSt3eHB2MnZz?=
 =?utf-8?B?V2ZZSnhTdmMwOHN2ZDhQUjNqclpGSXZia1c5ekFod2hzVWx2MzB3eDZkTDRu?=
 =?utf-8?B?YS84b0FTeVBGMTN3MGlUYUtISzlMUG94Uno0TXJTNlJsM0laWjIrMzVBZU5l?=
 =?utf-8?B?WFA4aS9JYUhXZW5oa1EvTzdwajZlcEJKZ1llYjg2Qyt2WnY4TUh2bkhNRXY4?=
 =?utf-8?Q?bGxT3O79arbXnpprVi6y92Kqj?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e237d41d-6206-4e83-0289-08dc5a3aba37
X-MS-Exchange-CrossTenant-AuthSource: SA3PR12MB7975.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2024 15:19:06.0298
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: h+RhFf+pvtXNN0iyV0/WG/nTX9yrSqqdhJPN03rr6V0V+os77mc+l4nOQcpvaVsQZ1vQ46TO6zM9j3jMUazzIQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4261



On 4/11/2024 7:12 AM, Heng Qi wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
> 
> 
> The NetDIM library, currently leveraged by an array of NICs, delivers
> excellent acceleration benefits. Nevertheless, NICs vary significantly
> in their dim profile list prerequisites.
> 
> Specifically, virtio-net backends may present diverse sw or hw device
> implementation, making a one-size-fits-all parameter list impractical.
> On Alibaba Cloud, the virtio DPU's performance under the default DIM
> profile falls short of expectations, partly due to a mismatch in
> parameter configuration.
> 
> I also noticed that ice/idpf/ena and other NICs have customized
> profilelist or placed some restrictions on dim capabilities.
> 
> Motivated by this, I tried adding new params for "ethtool -C" that provides
> a per-device control to modify and access a device's interrupt parameters.
> 
> Usage
> ========
> 1. Query the currently customized list of the device
> 
> $ ethtool -c ethx
> ...
> rx-eqe-profile:
> {.usec =   1, .pkts = 256, .comps =   0,},
> {.usec =   8, .pkts = 256, .comps =   0,},
> {.usec =  64, .pkts = 256, .comps =   0,},
> {.usec = 128, .pkts = 256, .comps =   0,},
> {.usec = 256, .pkts = 256, .comps =   0,}
> rx-cqe-profile:   n/a
> tx-eqe-profile:   n/a
> tx-cqe-profile:   n/a
> 
> 2. Tune
> $ ethtool -C ethx rx-eqe-profile 1,1,0_2,2,0_3,3,0_4,4,0_5,5,0
> $ ethtool -c ethx
> ...
> rx-eqe-profile:
> {.usec =   1, .pkts =   1, .comps =   0,},
> {.usec =   2, .pkts =   2, .comps =   0,},
> {.usec =   3, .pkts =   3, .comps =   0,},
> {.usec =   4, .pkts =   4, .comps =   0,},
> {.usec =   5, .pkts =   5, .comps =   0,}
> rx-cqe-profile:   n/a
> tx-eqe-profile:   n/a
> tx-cqe-profile:   n/a
> 
> 3. Hint
> If the device does not support some type of customized dim
> profiles, the corresponding "n/a" will display.

What if the user specifies a *-eqe-profile and *-cqe-profile for rx 
and/or tx? Is that supported? If so, which one is the active profile?

Maybe I missed this, but it doesn't seem like the output from "ethtool 
-c ethX" shows the active profile it just dumps the profile configurations.

Thanks,

Brett

[snip]


Return-Path: <netdev+bounces-53953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA07805648
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 14:45:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7444A1F21549
	for <lists+netdev@lfdr.de>; Tue,  5 Dec 2023 13:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46BC5D912;
	Tue,  5 Dec 2023 13:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="erBBtOS5"
X-Original-To: netdev@vger.kernel.org
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (mail-dm6nam04on2078.outbound.protection.outlook.com [40.107.102.78])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 705F8BA
	for <netdev@vger.kernel.org>; Tue,  5 Dec 2023 05:45:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzQVQAjTFjAItseX9qg7js5KM0b6tl57cBrwhtEWlsjhdH4Wxsl10xZOfGgnSjHzpmAMPI/nb8EEQABHQkzVwaflk/yRwu7Twfb3w3mFnziwt8XlgQk2Z+sYUPsJV3YXCCXA4Tffxf7+EVtQMrHlneBy63DRP5k2CpB+ZzvtDhJMDhlVbJTDgCGES7KdvoBClJwAUJBTd/anPhBMhr1YkbkHgYlAKDH8zfQEe5HmhsrrdjJiq+lvfK4uP4Ue6Rk+BhDK5q+3SBu7TwMXn6DKCuDzSXQyY5qUdhY+5/BZC28mOU/Mi0Rz+OO2sHEK0nJlt2HnMmEL/DOpKCeDDBSU+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MkpsLxiI2LU5b0wH7BWBJxmnnlemMKslxXWB9ycI6co=;
 b=kgkpx9BTjr3SF55YEx/Axh9JIVsgAJc3WaWLaM9fp79c9UICD+JJgty96Q+NouEUomNhm//8/j5Ns5pm+dbPvzJnle4AxGD4SGRaHi+KkX53dlfdjJLX9wPBtrxKFmqm+vb9wA/7DVb7lZU+DvicsWO5SLosvEgu1GHer3dqY81+YZkF2fmo7mIlsI7FTyDJbOBwzTiHRJnsqVp8zvd2lfrjut72hNlUbdDouNH3kBscmUZqeJOvqJK5ZhnV/E43IgKzI8anRxjrwrgXw5VMx6CpQ82LLZGAxNkLQaS20ifZ7k2r60nHpYx9zcC2N6ZUUlphXK5UYJnEF4P+7K/csg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MkpsLxiI2LU5b0wH7BWBJxmnnlemMKslxXWB9ycI6co=;
 b=erBBtOS5jdnPdNF6GMDZ81sQucKBX0wqtwrIjM1pVJKyHwHQpjk8rKeFUQSL20k/fMmgP1os6gpUwDUGf6aIeq/7sa5Fq5sHV2+cho7+xhAQY5l/bsyvEj9JqTlvF38axQOMud1n7vlhC51AuASzO73zbAZ585Jl3M839NVZm1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM6PR12MB4283.namprd12.prod.outlook.com (2603:10b6:5:211::21)
 by DS7PR12MB6093.namprd12.prod.outlook.com (2603:10b6:8:9e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.34; Tue, 5 Dec
 2023 13:45:38 +0000
Received: from DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::23e8:2f3b:86ac:ba34]) by DM6PR12MB4283.namprd12.prod.outlook.com
 ([fe80::23e8:2f3b:86ac:ba34%3]) with mapi id 15.20.7046.034; Tue, 5 Dec 2023
 13:45:37 +0000
Message-ID: <35c146ed-769c-4534-8354-77eb775b0a1a@amd.com>
Date: Tue, 5 Dec 2023 13:45:32 +0000
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] sfc: Implement ndo_hwtstamp_(get|set)
Content-Language: en-US
To: Paolo Abeni <pabeni@redhat.com>, Vladimir Oltean <olteanv@gmail.com>,
 Jakub Kicinski <kuba@kernel.org>
Cc: Alex Austin <alex.austin@amd.com>, netdev@vger.kernel.org,
 linux-net-drivers@amd.com, ecree.xilinx@gmail.com, habetsm.xilinx@gmail.com,
 davem@davemloft.net, edumazet@google.com, richardcochran@gmail.com,
 lorenzo@kernel.org, memxor@gmail.com, alardam@gmail.com, bhelgaas@google.com
References: <20231130135826.19018-1-alex.austin@amd.com>
 <20231130135826.19018-2-alex.austin@amd.com>
 <20231201192531.2d35fb39@kernel.org>
 <ca89ea1b-eaa5-4429-b99c-cf0e40c248db@amd.com>
 <20231204110035.js5zq4z6h4yfhgz5@skbuf> <20231204101705.1f063d03@kernel.org>
 <20231204184532.jukt3qvk7iqv6y4k@skbuf>
 <1f1c04902562c58736862ce24316f5bc85757bcb.camel@redhat.com>
From: "Austin, Alex (DCCG)" <alexaust@amd.com>
In-Reply-To: <1f1c04902562c58736862ce24316f5bc85757bcb.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P123CA0053.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:152::22) To DM6PR12MB4283.namprd12.prod.outlook.com
 (2603:10b6:5:211::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB4283:EE_|DS7PR12MB6093:EE_
X-MS-Office365-Filtering-Correlation-Id: 122e9803-1767-4462-04f1-08dbf598768c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	qQpbT53wwDp0+MaHshHjNytHDqjYg1RtZMEawcj5OzsXTOocPZrV085ozaPLp1dDFY+hwkzS02gQDfUARyGgnzP1HfGw1Csa1xRxL3Idiufe37kkHS21bRQiUiQaikm9vM6v9WySR8sFMEZ86znSJresHaTeABDIegLfwdj6eLkLCEF+r5oYQjX539TPipEgwFx9W8HgnYFg3JYZoCJMOnoKISNNYlSE+/4DmVBqkSJUcUp8dgcTpQziJt2lhX4lar2Zg/kB2Ww5PerJv/uDKeEjPNMXPO7A5akQKR3FhX5l2GIJH6dJ/8FuZ2sLYGiTWoqzcOMr8t9dska/NJVuQi17uwwboavNu0Y/4w7f/0uS3J4vh3+zTTYWUUPMQAVn/7ZVQHzra0CoK6U4DWYYOBVGaVtXf2Yab/XtCV4JyV2LNKh2Ohe+sXh/B5f4zt0aGKmDUS/GZRvUO1sChkO+Q/pUxQ9gFG0kuM/DbOkK/FY+GoU44qYWv+dsTeoLbm8Tf1PMiwgpqeHF8QZAQXfTLgdG5F6cRyRBMPHtZKtmamm/pC4GaKHminDySox0K+PQziVXn+9uyX2t1NIwWF8sGYtbwCo3ac0CzHdT7OJ3/SZuHhAecFG6w1BlmwQzvk8103F8TDIAR1Q3NowTMNNppJAzSorGool1ZGR43f9AiDm7EASb1Ff/jMUzC3TzuZBc
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB4283.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(376002)(396003)(366004)(346002)(230173577357003)(230273577357003)(230922051799003)(186009)(64100799003)(1800799012)(451199024)(7416002)(31696002)(2906002)(110136005)(316002)(66556008)(66476007)(66946007)(8676002)(41300700001)(36756003)(4326008)(8936002)(31686004)(5660300002)(38100700002)(6486002)(83380400001)(478600001)(26005)(6666004)(2616005)(6512007)(53546011)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?OTNXTFkra0NQUE5QVk1pTXZZdkhrcDlVMDQ1SDl0emNlZnQ4a1hrVk9PbUNq?=
 =?utf-8?B?TEdJSHhoNEpPcUd5MlJlVW4zNk5NdytXdDdmdFJvN1ZpSy9oblJlOER2VGxN?=
 =?utf-8?B?bjlmdnljMFVBdWY2OE9mTU4rdHZLdUZ4eTluMEtaZE5lV2Y3N3VoV21aUVVi?=
 =?utf-8?B?STJBa3dtdndaZm1QOWlFOGJhdjFQQTdxVEd0VkxSeGdnMFdiQ3RkQStxQThr?=
 =?utf-8?B?Y2xWMjF3cHlUNzFPN1dwZzdteEZyVXhGYnNNdHZ2SFZYQUxDZy8xQ0RqS1VO?=
 =?utf-8?B?RFkwYjBpWFV5Z2IyVERoUmFINDBtS0tDenlNR3FwNGFqbXUwaGljYjR4aGp4?=
 =?utf-8?B?YUJsTTJVRGIyS1ZRR1BodmFUQmNnVWwxU1dNQU5SeFZyZ3FWSXcyeDJGTWlv?=
 =?utf-8?B?b0tSWmh0YVdXMFJXNmhCdldybjlueWFqTzd4MURwN014elVWMWNvR0c3dUJh?=
 =?utf-8?B?V2xZYnB6RW9zRVdqRWh2dUZyR21MSG9NMStlM0hWQ2hHT25ZazhLbE1PWDl6?=
 =?utf-8?B?aDVnTURDeE03K0Mva1JvSW5EUGI1TWxYVkhrSWNkK0pKaWpYYVhSaDVpQllK?=
 =?utf-8?B?cU1ndk9ybTRHaUc0SVJicTFOcVJlSXhRL3ErUmhhNENFM1FDOWRmNkJEbkd3?=
 =?utf-8?B?KzNtVTl3d3Q3U0FYQVlDbFFuNW5oaVJGR0VDQnBWd3crWVlJKzNrTnp1TUN6?=
 =?utf-8?B?MDcyck5kdTV4alZ6aWJ4VUNZWUZCUnRyMTNVeGlBQTE2ejh1b2lDd0drZEl3?=
 =?utf-8?B?dzhFRUpNVmdka3J5YWFmR1FUOWZhQWVDdzhZOUp0QlRVeENOSGphQlpzbkIv?=
 =?utf-8?B?b2lrbHpqL1pRSHlqY0dDaVg5QmR5TjAzdXR0c0U3NHlaRURrREpFeW9rRTRZ?=
 =?utf-8?B?QlpBMUZMWGRhb1EzaEpOSmdsc2ZsOHFiYkhUT3VJU0FsaDJWQVNGZ0Zka092?=
 =?utf-8?B?RW9lNnlFclNQNmVvOWh4SEFvSEF2cVkvM2xZa1c4WXZ4bG5laW5kT0M1YnVp?=
 =?utf-8?B?bVhhRytFSTlhSm1TOVYyY1Y1U3NaWTVqclkvWFJ1emp5bFYvVjk2UW9Xc281?=
 =?utf-8?B?TnVlTWZzbDdROS9pSnBaVGdneXovOWxRNG9BVnJpTGZ6S3hONG1qUUsxYXZ1?=
 =?utf-8?B?eUlJZmthQUlPNlB5ZFZJaVBMSUFwZElCOGl4V2dJWkxUVkRDOTlSM3NXSzlj?=
 =?utf-8?B?cTZOQlk2c2NqUjlIejdLL3lKSGxvMEYzOWlhUnhrbGpLcFpyV3NaUm9DWmFw?=
 =?utf-8?B?WkJ3YTFIRGhPcmFFTURwdms5dkoycjBwTEdFU2gzRmErQnFYVDVlY1I2SUo5?=
 =?utf-8?B?Q09mNENCVkdiU0MvblA0eVRSSC81UklUdzlkMFdKMmVxVElkNzBMWlJDcy9N?=
 =?utf-8?B?RkpVM3puUVFMb0RxMWhjVjdkRFdIY1huNVhCUktYaHhaT1VMdE9xTzVkbXQv?=
 =?utf-8?B?ckVNRFByckhzTnBRUmdpb1BkZzc2NTkxSldsekQ3ZDZ0enhrQnhJNjJibWEr?=
 =?utf-8?B?SnB0WTNHY2lHY2RwT2NKMkw2MmxXUjJ2ZCtNY2IreGFoRXFjMWt5QlRrZ1RI?=
 =?utf-8?B?QjBQaU9USUhib0Jma01pRkoyWGpLbHhoNzhKRXpXZmU5b0NlYWlJM2ZOR0di?=
 =?utf-8?B?U2lza0pMNE9kaGR4ck9YL1pzTmpHTW8zTld0YjNMZ0s2aTcvYXFiRTR6cVRa?=
 =?utf-8?B?S0JWTE5YUHFBNDJuKy91QW55cW1pakIycXlBTXRyeVJHQWhEdWlwNnFzdDlR?=
 =?utf-8?B?RVdIN2NvKzFDYUMzQmR2aEc0RXhJOEk2aE93R2d4QmFGdjA4ck95NHRkdHYw?=
 =?utf-8?B?VjBOcERnSDlwMkc5R05vOTBuM09YcUZVYktQa2hQMXdoblBtVHJEU0RYSE0x?=
 =?utf-8?B?NjV0b0VoajZiTlN4RVByZHp2QlROOU5hbEVoclRwdlBPK3ZGblRiZ2kyRjJV?=
 =?utf-8?B?djUrZS9mVWh3WkF3cDBiV0ZOTUw4cFp4QlhmdURMSnNzVWlqbE96ZDZ4MVhE?=
 =?utf-8?B?VUVibzRXMGJaQWpXeitCNVdHMWlMeGNrMVpEM1dPdHZPREFsc3RyMDRNYkpM?=
 =?utf-8?B?M0QwWktPbzV4d0s2cUY2eXIwaGloNnlvR3RRNE00bjhGOVIySXFiNXdURVQ4?=
 =?utf-8?Q?R8AU+/STqpi+iKsqz2wq2WH9c?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 122e9803-1767-4462-04f1-08dbf598768c
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB4283.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Dec 2023 13:45:37.8599
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Vgao6mKDwS/zNh8wuwGGzJXLf5zd3T6n5tBoLqTjeD9q0WTKdFvIx7+1icSD8yuBDNxkU5BSwfuWWnsnByqcFw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6093

Based on comments above, my preference is to keep these patches as they are.

Thanks,

Alex

On 05/12/2023 08:52, Paolo Abeni wrote:
> Caution: This message originated from an External Source. Use proper caution when opening attachments, clicking links, or responding.
>
>
> On Mon, 2023-12-04 at 20:45 +0200, Vladimir Oltean wrote:
>> On Mon, Dec 04, 2023 at 10:17:05AM -0800, Jakub Kicinski wrote:
>>> On Mon, 4 Dec 2023 13:00:35 +0200 Vladimir Oltean wrote:
>>>> If I may intervene. The "request state" will ultimately go away once all
>>>> drivers are converted. I know it's more fragile and not all fields are
>>>> valid, but I think I would like drivers to store the kernel_ variant of
>>>> the structure, because more stuff will be added to the kernel_ variant
>>>> in the future (the hwtstamp provider + qualifier), and doing this from
>>>> the beginning will avoid reworking them again.
>>> Okay, you know the direction of this work better, so:
>>>
>>> pw-bot: under-review
>> I mean your observation is in principle fair. If drivers save the struct
>> kernel_hwtstamp_config in the set() method and give it back in the get()
>> method (this is very widespread BTW), it's reasonable to question what
>> happens with the temporary fields, ifr and copied_to_user. Won't we
>> corrupt the teporary fields of the kernel_hwtstamp_config structure from
>> the set() with the previous ones from the get()?
>>
>> The answer, I think, is that we do, but in a safe way. Because we implement
>> ndo_hwtstamp_set(), the copied_to_user that we save is false (aka "the
>> driver implementation didn't call copy_to_user()"). And when we give
>> this structure back in ndo_hwtstamp_get(), we overwrite false with false,
>> and a good ifr pointer with a bad one.
>>
>> But the only reason we transport the ifr along with the
>> kernel_hwtstamp_config is for generic_hwtstamp_ioctl_lower() to work,
>> aka a new API upper driver on top of an old API real driver. Which is
>> not the case here, and no one looks at the stale ifr pointer.
>>
>> It's a lot to think about to make sure that something bad won't happen,
>> I agree. I still don't believe it will break in subtle ways, but nonetheless
>> I do recognize the tradeoff. One approach is more straightforward
>> code-wise but more subtle behavior-wise, and the other is the opposite.
> I tried to dig into the relevant code as far as I can, and I tend to
> agree with Vladimir: the current approach looks reasonably safe, and
> forward looking.
>
> I think any eventual bugs (I could not find any) would be pre-existent
> to this patch, rooted in dev_ioctl.c and to be addressed there.
>
> I think this patches should go in the current form.
>
> Cheers,
>
> Paolo
>


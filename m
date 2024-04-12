Return-Path: <netdev+bounces-87455-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C868A3289
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 17:34:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 477332814A3
	for <lists+netdev@lfdr.de>; Fri, 12 Apr 2024 15:34:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C481482E0;
	Fri, 12 Apr 2024 15:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="uCQVAmOE"
X-Original-To: netdev@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2054.outbound.protection.outlook.com [40.107.236.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A80824AD
	for <netdev@vger.kernel.org>; Fri, 12 Apr 2024 15:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712936048; cv=fail; b=UXbIvLgD1/rnMvPydPELu+f94GKHFErMFXMAhqIA2SA+IZSANY/xn8JbeastFbpBObbqHep3elf2A3RFnZA/FyN+9u6QwHCQIQoVX6XQuZ6uLiKxYcgKpx40zoZN3Qah2GZKYE8zPvSGUibsjKGUVBSbeuEyD7S8atlsv6U74fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712936048; c=relaxed/simple;
	bh=xJp5fHukFXMc1rLuWbG+RPvXsCxiTHQzk5urYoMlRCI=;
	h=Message-ID:Date:Subject:To:Cc:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=dy6VdGcWT/d041fpnmjGJgvLE4/yY9g9qSiJ1HbCDxXmUbpQtgXRkpN1H+gCY32SxF6XLs+0i427zun9CJPPGlcL4TtR9aBzU19WWVGyidiVWcjsLwPwaWusnKt4JcIwPKPJpi5jngwW2bcGQD5Aw0uSxpCuLNJ0NwipxPgS47o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=uCQVAmOE; arc=fail smtp.client-ip=40.107.236.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KNchE7D9MSsnQ2cTE/XT3JBYC7IlkBJWPO3RBK2rqYPa7JIf8cyozaLEvKe3rJyESLgb0rULvrHqCWE20v5iiJzw3FfLZnsqqeHqjPNZT8b0CkqG17LeULuX2hI7yAf6Ef/di89Q1T7kqaFlGOc0481tlDHooiT+3kJxgK4kMlmCwI7n5Y66VqQ7XJnFINBedicZrgOf3snKrc2Gepi/0ZEobbXUVQAilJr30Je1EX4gZaA6VELOWFvvvGzRUPmzkoeDHLll2aPm/UR1v5TSvLys5ZcdGcRwG/778vm9M9mMQIU0loAC6fdAZBColfajedMIKxTW4O+xrTJ5lhXT0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zdkWNgT+NAPgYamXVyI8NQwnI569cSF+0CwTC+Mu1nM=;
 b=Y2pExjU+C/s+C3wdn7+PVkALhlJ9tc2cfzr6Q7X9C1feJqM1ebkWVNFoQAZGs0E5HbaryfV8U4Jr8K34IO2rxppd761d5C2NZ7Pdgk2X8dV5QTZx+FseMTniQL1ElD9QyAmmjjEC2DP+EHte2w6xbV3wRC6gaom9LHzy9VLTe8msCSeXGz4Klci+oRDCyneyIKF4dGiDpnHBA0wIQ+0k8h4Dpdzz/yKqsFMxd6GzijzO6/hEw4XBwc+LTHo2jdv7P239IqDoA9UMorL/Z7gB0sA37aa3OiQH0y+Q48UPyZvVhFIXIYAsiAZTuA2s07bjcvI2m97J9jGQbRau/jS4Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zdkWNgT+NAPgYamXVyI8NQwnI569cSF+0CwTC+Mu1nM=;
 b=uCQVAmOEjrttNVEW47uQwto9bQ3NT/kTDT98b2PqyMMDOdL6yt8vZ2f+uJFsx7i2NGSldTCnF/5jw1bGKja8+m3TtQP2aC5jMart/Uyi+eukgMrLLXIJ8KqGiAe+xd+c3F2PzewOyH8TWHfzb1EJ9zfdQjIZdgmN2zBiPI0PTAo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from SJ2PR12MB7992.namprd12.prod.outlook.com (2603:10b6:a03:4c3::9)
 by DS7PR12MB6309.namprd12.prod.outlook.com (2603:10b6:8:96::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Fri, 12 Apr
 2024 15:34:02 +0000
Received: from SJ2PR12MB7992.namprd12.prod.outlook.com
 ([fe80::e19c:6cc5:23c0:8d54]) by SJ2PR12MB7992.namprd12.prod.outlook.com
 ([fe80::e19c:6cc5:23c0:8d54%6]) with mapi id 15.20.7409.053; Fri, 12 Apr 2024
 15:34:00 +0000
Message-ID: <c62052c7-a67c-40de-b100-e4469f219383@amd.com>
Date: Fri, 12 Apr 2024 08:33:56 -0700
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
 <b0c8d0a2-d6e5-4138-96c0-e9dbbc1c8b20@amd.com>
 <99bc7a22-6fa4-49e1-b98b-4b6a46f1b9b8@linux.alibaba.com>
Content-Language: en-US
From: Brett Creeley <bcreeley@amd.com>
In-Reply-To: <99bc7a22-6fa4-49e1-b98b-4b6a46f1b9b8@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: PH0P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:510:d3::32) To SJ2PR12MB7992.namprd12.prod.outlook.com
 (2603:10b6:a03:4c3::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR12MB7992:EE_|DS7PR12MB6309:EE_
X-MS-Office365-Filtering-Correlation-Id: a028acf2-922c-4cc1-8cc0-08dc5b05f986
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	iRsNE1qZS2OyNxX8aG1S1nasUyfInT2krpcCidJF2pYJE+pYcat/oUcJ31RBcfgcEQqnz5aSSkTDK7wMwL7bldesjgOZWk7FjPgMS3Ya9BJV6rmk4ZIjWvzdzZsdPf9xyhLENHD4gTcnQ7/W+mpJqmmBxD49nUC161vqsvxA+SXl9XZRGgQjM2znbK+i0pkqZQjQMpU84yZfu1cPHk3qFhkpIYcdlV5p4R11lxEEysTgR+n+C21tGxoaWJyQLCLgFDJgbahr/q4bsBDVenpU7xZLTBw/+lRge4iEIfeU5ePazJ1K8lT1HCB4no4owdgz/wfGZPrpofmVECg/ougmq+tVK78U59wLWyKpTN9JR3RMfCwVTorWZjlokqjR6rIzewAok8cFeLP4dr+Ex30jZcMWPmMuTXK62swebUBUDA8mX7Ap13cHpc/P1SJMjezsCMz3cfdwaDQ2/ipI0K7UBaZ7eDJ7Qc5fY6MaP7hj8XvymafI+QAOXk+13AGRtwAMe+5y+KQt4sMnQwSymVix/cMza2NDa/XJn3w0H3ACCZ11iZaU+dMXllOvIlfvYp4GxvsRAZ3XlUlSaXADAgfLd1la9OcsBP2zjJ/aMNy/oPN3o/kEDFgHPNs2JmesOzt0KNro+VPuTIJG3Y2D1wTVgKI2YdA3ZSep9X/+xeLWkB4=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR12MB7992.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(7416005)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?Yi9MS3BOR1VkV2JGM1l0MFZtTlR6ZlRGWUlxaThkYUE5WGhkRFlqOTBFZCtG?=
 =?utf-8?B?QXlJai82M3NXdmxac3ZsY3dBZmJGUHdaYXVOOGtiQ0QzTXppUis1OTFvYXF5?=
 =?utf-8?B?dVNmcnpNMkJ4MVRxUXRwYzJqRXBwWmcxM1d6ZHBzY2NlYTNvMEhJOGZYOHF4?=
 =?utf-8?B?RzdmV2tRbzhDemdEZkpaSkx5OFVEQVlubVViRzNvYyt6NzhjK0JQdm9aT0k5?=
 =?utf-8?B?UCt4UGxMQzN5SEFtVlQxS1d2bDJGbkkrTTB1ZnpPczV5UWFkNjZ4OURIWXU1?=
 =?utf-8?B?aTdMRGNMSmZtZFdpUHo5ZEduMEhEL29RTTJhb3VNVWFSWUlEL3Y4RVhtOEM1?=
 =?utf-8?B?YmdONGkwSXAyVDgwdDN6UnFiNVRoL1NXQ0J0dXVZVkx4endPcXBEdGFFK1F2?=
 =?utf-8?B?b1kyYTFYYTA3bnBwd1ZxTDR4cmtFVWVDMFZ6QXNiSzNGNDB5bWlZY3A2MWsx?=
 =?utf-8?B?eEFjeWtFVytkQ2ovbkkzL3BCZ1J2U0liTVJUb09pb3hzUCs5T29tTTVDVVNX?=
 =?utf-8?B?a1kvUlArUkNvcncya0Jxb1pDVGl3c1p0dHlUdUZRRGtLYVU0c1lwSnNVRjRI?=
 =?utf-8?B?QVA5Q1pQc0lUTjM4NUxIZDhYaGNPVThPVzhldzBCSFdQZGh5bkpOTHY4SGl0?=
 =?utf-8?B?UDdvU0doeTlBMlNsdnkraEE5d1U3UXFQVldwdEdIUFlmREVicURuM1YwVE0r?=
 =?utf-8?B?Rk5SMDBobW9RUjdmZ1lGR0J6Q2Q1RXZPbWJkK21ETHE5dGR2bGd6UndLcDVx?=
 =?utf-8?B?N0t5alpUL0prTEJ3RjNUd0NNRG5qU1ZtVmtzOUJ4Kyt1Wk14NUhuN3k3b3Qy?=
 =?utf-8?B?MWg3WmJkZEUxQ2hKQ3dSUk9URHNwQnhscVRYMklXZlc2RjMrMVpJSEJUZW1Y?=
 =?utf-8?B?YnZUdEU0eUUyNFFmNkdHVE9VaXhHb0JpTFM1Y2RlenRUcEsvWHBTMlRSQ2E0?=
 =?utf-8?B?azY0K0lTcGN2SlQyMUNKMGpyZzhZT2hWUFovUlFSRGk4N3hjSmR5REVweFBq?=
 =?utf-8?B?TmM1bzZHM0dTdXg5Vm5TQ1NjN1Z6QXFUSnFJOU5nZkQ1dnRmMTVhczF2anlZ?=
 =?utf-8?B?YVc2d1kzYm1sNDh5eUxsYTFSRVFvYkhJZDRKNGxiQkpHMGhJNkFhREF1a3E0?=
 =?utf-8?B?UTU1dE1oOGhQTWlPeXhKQ25UOEVyT3U1WVVlZ3B3YjhSbEVnL0Foc2JnQXl2?=
 =?utf-8?B?Uys5NW5vN0o5ZytPOHgreFBITndxRHJOOWUyN2NscjdjVzVGL0pBbTZ0N1Y3?=
 =?utf-8?B?K3VFZk5UTkViVzRwYU1qN1c1cVlyelc5dllyZGdJS2JuM2YyYTN2YmZiZ2c0?=
 =?utf-8?B?MzU0NWtOREIwMWFUdWkvdkM1UExYSGhwZUlQQkVqem9jMTg5T2lHQ2Z3K3NI?=
 =?utf-8?B?UkN6S2x1ZVdLWlkyb2tNQ0xhT2huNWpDOERXd2RCY1hMT3ZBclJkUmwzZ3Zo?=
 =?utf-8?B?UktVbzdKNFpEaEp2c1BaMzNONGpzc2Q0U1RXeU93L0JBR3BkU09oNi9TNWJV?=
 =?utf-8?B?bEpzbUpBRjdEQ0kxWjNNZmwzd0RwZjJkUjlHb1BaOU9OWXNXSmFnQ2pEcXlz?=
 =?utf-8?B?a3RRMGRJd3FTTXhaMUIzMWVTNmM5Mm5zSG1EZTRVZGgzU1U0MkhHUkgvaWpr?=
 =?utf-8?B?d1h6VlJiU01HSHBVa0xYT3VlV29jcjFYZnk0anBXRHdINXgrR2RvclhpRHRt?=
 =?utf-8?B?QzFQMi9zL2lkWGhuTFJwTGtFdnBSOG9RNTVPQkc2Wk9YdVBORHpUL3IvZGpn?=
 =?utf-8?B?b2RQbktzZG9oS3N3K01kdmFQWkZ2VlZ4RmZGTHRvbFdSNWdrek9RdW5URUx5?=
 =?utf-8?B?enhYWEZXeDdSYlRnUjZRemRyamNseGpiVGh0cW5YMlByREpiN05mV3pvZHVJ?=
 =?utf-8?B?dFNrWmQ0YUUzd2pFanRvTko0K0wzMTI2M2orSUJxZ3NNZ29WUUhYMmVMWm5x?=
 =?utf-8?B?c3NaS0UwNjIxdWRvMytoTTJwU1FxQTlNMDY3cjF2bVdDTWI5RGRIZ0NhWC95?=
 =?utf-8?B?dkMzcDAxanIrTkNBUVVieG1tVDNUcHhvVjdBQkcxcTI0YWVWcXdubVQxNnhl?=
 =?utf-8?B?aHptY3ZneExqTDZaczNzYlpDWnBBejFBSTE2RUJxOGNMT0x2SzF2MSsxbDNz?=
 =?utf-8?Q?THi8Xs975JaLzzh+5bolDbCsp?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a028acf2-922c-4cc1-8cc0-08dc5b05f986
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR12MB7992.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Apr 2024 15:34:00.0779
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 26U5eFdbli9DSEo+WBX8LasW7d3Lh6BeCYl7/r02ouSIQB/nmo8Q4e92LXB2AgGKL9HNy4kYUel+TPnzDHG3Pw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6309



On 4/11/2024 7:07 PM, Heng Qi wrote:
> Caution: This message originated from an External Source. Use proper 
> caution when opening attachments, clicking links, or responding.
> 
> 
> 在 2024/4/11 下午11:19, Brett Creeley 写道:
>>
>>
>> On 4/11/2024 7:12 AM, Heng Qi wrote:
>>> Caution: This message originated from an External Source. Use proper
>>> caution when opening attachments, clicking links, or responding.
>>>
>>>
>>> The NetDIM library, currently leveraged by an array of NICs, delivers
>>> excellent acceleration benefits. Nevertheless, NICs vary significantly
>>> in their dim profile list prerequisites.
>>>
>>> Specifically, virtio-net backends may present diverse sw or hw device
>>> implementation, making a one-size-fits-all parameter list impractical.
>>> On Alibaba Cloud, the virtio DPU's performance under the default DIM
>>> profile falls short of expectations, partly due to a mismatch in
>>> parameter configuration.
>>>
>>> I also noticed that ice/idpf/ena and other NICs have customized
>>> profilelist or placed some restrictions on dim capabilities.
>>>
>>> Motivated by this, I tried adding new params for "ethtool -C" that
>>> provides
>>> a per-device control to modify and access a device's interrupt
>>> parameters.
>>>
>>> Usage
>>> ========
>>> 1. Query the currently customized list of the device
>>>
>>> $ ethtool -c ethx
>>> ...
>>> rx-eqe-profile:
>>> {.usec =   1, .pkts = 256, .comps =   0,},
>>> {.usec =   8, .pkts = 256, .comps =   0,},
>>> {.usec =  64, .pkts = 256, .comps =   0,},
>>> {.usec = 128, .pkts = 256, .comps =   0,},
>>> {.usec = 256, .pkts = 256, .comps =   0,}
>>> rx-cqe-profile:   n/a
>>> tx-eqe-profile:   n/a
>>> tx-cqe-profile:   n/a
>>>
>>> 2. Tune
>>> $ ethtool -C ethx rx-eqe-profile 1,1,0_2,2,0_3,3,0_4,4,0_5,5,0
>>> $ ethtool -c ethx
>>> ...
>>> rx-eqe-profile:
>>> {.usec =   1, .pkts =   1, .comps =   0,},
>>> {.usec =   2, .pkts =   2, .comps =   0,},
>>> {.usec =   3, .pkts =   3, .comps =   0,},
>>> {.usec =   4, .pkts =   4, .comps =   0,},
>>> {.usec =   5, .pkts =   5, .comps =   0,}
>>> rx-cqe-profile:   n/a
>>> tx-eqe-profile:   n/a
>>> tx-cqe-profile:   n/a
>>>
>>> 3. Hint
>>> If the device does not support some type of customized dim
>>> profiles, the corresponding "n/a" will display.
>>
>> What if the user specifies a *-eqe-profile and *-cqe-profile for rx
>> and/or tx? Is that supported? If so, which one is the active profile?
> 
> 
> I think you mean GET? GET currently does not support any parameters, the
> working profile will be displayed.

Yeah, I meant the GET operation. As long as the currently in-use/working 
profile is displayed that makes sense.

> 
>>
>> Maybe I missed this, but it doesn't seem like the output from "ethtool
>> -c ethX" shows the active profile it just dumps the profile
>> configurations.
> 
> Now it is required that dev->priv_flags is set to one of
> IFF_PROFILE_{USEC, PKTS, COMPS} (which means that the
> driver supports configurable profiles) before the profile can be queried
> or do you want to query without this restriction?

No, just as I mentioned above it seems okay.

> 
> Thanks!
> 
>>
>> Thanks,
>>
>> Brett
>>
>> [snip]
> 


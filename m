Return-Path: <netdev+bounces-73724-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0655A85E054
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 15:54:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90A761F25257
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 14:54:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB6D7F7F0;
	Wed, 21 Feb 2024 14:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZUVyoVDh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA5079DD7
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 14:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527278; cv=fail; b=WgXP7sSItXVo6rRZVuPtUgsgGFvGwOtOr6qBHV0WdjiSoOAdJxwODefuHvvpjRLn/N61vUn7HI3GQEmbM9Vsmbdx1tbckj6NIDNAdlas+z/8jh8Y+NpFw7wsGwQn+hVlZ7dmkfOR9Ue9L5G9dPstFFKBngLzFtlRyGl8fDfVfAw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527278; c=relaxed/simple;
	bh=euqfZ9rofFB1ZEU3o3N8q/uCYWJd3hkNRLrzyUCmo1k=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rC7dCC0QY2m8N9HTtCXaG9OYtcGZkN1WHc2QAUGCw9JVW083U6UVAoQur5Zl2D9milhjFKivy85g3/dT2hs207PEQbV4CAQK3GNpuR6SdV5KnUU2GUKolGseeH1jjZnEc2pBmd98nNCBGmP+DhO65OmI7txBW/HbJCB3hySgaBc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZUVyoVDh; arc=fail smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708527276; x=1740063276;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=euqfZ9rofFB1ZEU3o3N8q/uCYWJd3hkNRLrzyUCmo1k=;
  b=ZUVyoVDhBZ1cG2TancgawbNL29mRNjw9lJOFdXiw2HX9BuvYqf3VRqjA
   qmdtLu5FNZsb2lMOSU6Bvl+pUPRgiDXpHfwfAAlm723xgguK+jsXa8Iix
   XlsENJ1rnkk0omqTj40NAp6Swxxg/8HLZUTG30Bbs72CswBESxlYLs186
   k6M+ASHKzipYgwwSdghrkt9kE5o/OHxrB89pecKut+F2L+gCKfzTlLcO2
   0B6yTbbTVu4SiSaOba5PjVKm9pCZKmfcY0b9LbiBiZIDkIsx7C9HETWR1
   Qee5A9sGGU3AZNY2utAgvNIx5Qv6C8cUAGFz8PGRt7oc78nPWPazptItz
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2574278"
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="2574278"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Feb 2024 06:54:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,175,1705392000"; 
   d="scan'208";a="42633481"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 21 Feb 2024 06:54:34 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 06:54:34 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 21 Feb 2024 06:54:34 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 21 Feb 2024 06:54:33 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 06:54:31 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gYi8twH0sEFNDA0AqnhfjzUnitFCQ9QSlxj/lBVHDLUJXXbjxQMiMf12LggfDTNvFf/GrMRhC/ortjuIcrgjFmM9ZdFStI5bIxHXzohrnEstPlSe3bEYQsa2AzTDTHMXzNljatV+HJjvJCtzNvHToFxUBn9/lU453kS0afzweZ8PeNp/L5DhQpL5ZPc8rUmf41kjpRtLfkGBRv1/IwgiuGM5R4LJtgWZQ89icp36ekIsA0ujLAqHDEg3GsV4gWPX7rAH6ob9ijAvnLtyBqxHxnK3JC5ya9oBbIJ7HWAsvcLhgmuUQtkbxl3353ieX6oaLy3r5JF6hFPG8Pg5KddWVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyS7kEE29FUvvt3kjfqt6HrEyJMPZjf/A5jVwiY8kRk=;
 b=myCQH6WZcl+lCNGwP16pr0PexSFV0DlbOVGpLRshWn37r4J+xHgGrzRcCxrodTS9N31a0WRPQPiiRvlZleDeNlpMWu/ATUznCS+bnRhygVMlC+IoH7sgyy8qYNYV7MpuHzq35ujtLzvakhXMxySkmL82MVdLUFXo76cDea7cFnQrMzdLdAHIDw5cxiYlbMtqhRmamEKhV8xE4KZN/7eqHfKROnlvPEuULQnie35Ano/Tw+85Q2QzTwOhy8jjioXWoObqF4Z8qCnsTIXb9krss3OJmNtO2etYi0i4aGi6IHtyIfj/YeweN7Bx8NjKVN3JBdFpaar0eP/uiF976NplwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by LV2PR11MB6024.namprd11.prod.outlook.com (2603:10b6:408:17a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.21; Wed, 21 Feb
 2024 14:54:21 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::13c8:bbc8:40bd:128b]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::13c8:bbc8:40bd:128b%7]) with mapi id 15.20.7292.036; Wed, 21 Feb 2024
 14:54:21 +0000
Message-ID: <cbd0173c-8d32-4e08-abaf-073db12729ab@intel.com>
Date: Wed, 21 Feb 2024 07:54:13 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH ethtool v2] ethtool: add support for RSS input
 transformation
Content-Language: en-US
To: <mkubecek@suse.cz>, Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <alexander.duyck@gmail.com>,
	<willemdebruijn.kernel@gmail.com>, <gal@nvidia.com>,
	<jesse.brandeburg@intel.com>, <anthony.l.nguyen@intel.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
	<pabeni@redhat.com>, <andrew@lunn.ch>, Aleksandr Loktionov
	<aleksandr.loktionov@intel.com>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>
References: <20240202202520.70162-1-ahmed.zaki@intel.com>
 <20240202183326.160f0678@kernel.org>
From: Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <20240202183326.160f0678@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DUZPR01CA0230.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b4::7) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|LV2PR11MB6024:EE_
X-MS-Office365-Filtering-Correlation-Id: 4316d5a3-fe2f-4295-e76b-08dc32ecfc77
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9/HxIInnMNVyfBCcTS1EcmhSaAvboA233944rfiWxq75BZ5X14JHTWs+fnhvKQeeOuzn0Du3AVZ5qKGxY15aDhcOmL+nWhcHGkDzRI3v1Ib1dEyk8v/3r3l8BeI3h4up5j1RpeI3vgtugJJNvEXlAX/SiGrg4yP1oHkSMSlj+5voIxgRoQzGPQxub8G0NARZCdzLuz6Wdkta7nTSSpoPsATvnsHLRPDZiKe6BIRcfDTI7+rO4wj9X67/wki7E/h/Gx4bV6XjQRbA4XrQYJpiEhA8ZugaBzk91wWq9Dg4/x1IxrbRqMctZsFYZ/20164HQkqn7xkwOKEoDm6VCtN9G+T6IYFzNa4+9CGK+YhYTjD399nBdHbttUEA0YctUYfEI1CvIshEHGSuP4A1IkV4Uw3yff9dbUDzdznZtzlvfLtH/hTJzPd4p97LbqR/D5excvRATRBBkzKofG/q/8lU8yoFKhTfkpPn8sRBvcYBciLyeMiiA2Xx1Vk6qwf7JK4nOQfa0Ci3P2Es9pZnmvmDWg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?a3VZS3AxS1hjMWRsRzdIWW1KWXgzclRJZDhxUmhEaWxCQXNQS3pvUzJpdDFB?=
 =?utf-8?B?aGs2d1pjaGJqQUZOYXJDY2Y1S3JQZlBxMnRqb2M3aHpIQU1GLzdHT1paNzZE?=
 =?utf-8?B?ajNMU0ZmZnhFaVNyYkEyNXVsMGEwTTdWd25wOW9JQm8zYUdPajJRZnQ5Zmli?=
 =?utf-8?B?Qnhka0tiblNmaEx5di9mUE1UeXNMN3FhRFBBV2RSUm5IVkJYS0VkTHlwRDdt?=
 =?utf-8?B?R2Z6U1JTTFcwaUNwenRka21KZlM5Z2pJOW9sU2VOT3pNTHhqTzJYVFkxN3Fs?=
 =?utf-8?B?SHpHZXJWNUtzZ0tSYnRMbFNtU2UxL0xpTDRnQ0R3T21EUlpjc3I1UVdpUitZ?=
 =?utf-8?B?VGR6T1h5RnhlZGdDR2M2dHhweUYxTXJhOFNnTnZDSXNHYnlEUzc1Z21EYlF4?=
 =?utf-8?B?ZFppQ2dubnhQMTIrZUJrbm1LdFY2NkhwVDRwK2l6Y3ZEUW1qaTZJRVNtNVBy?=
 =?utf-8?B?M3dsZ094OHg4TG9TRUt4eVRiSXFXNnZZN0ZOejRnM3h5c2RwUEVVclNEYm9I?=
 =?utf-8?B?UXcyMXlGRVJtRGVpbDFFclhsanNXbU5xVWExTHByL1Z2NEZJOCtSeTN6V3Fa?=
 =?utf-8?B?d2JPREJzNXgxUUYvNVg5QjhzMzVReFpJaDdrclFmSVhFMDhsYXkrNTRmYjRB?=
 =?utf-8?B?RmMzT1E1VVQ5TVFGeE8xMW9rQTZYNHRyQmlXdURGZG8xUXFoRmlvZjhYTEp1?=
 =?utf-8?B?RGswZ0pNZjZEd2c5TGJtQVg0d0YwWjRxdkFtWnFJZ2Z0OGhjb2ZBQzZzWTZR?=
 =?utf-8?B?RllVUmFBL3BRMFpieVFQVXN0Ykp1RDB0MUd6ZzNxdGJsaGh1dDN0Wm5oYlQx?=
 =?utf-8?B?Mzk2cWZzMWhDa0s1bUU0NnBqTGlpSTVSMWkwUUg3VjYvVXJ4NERKT3dhbVNh?=
 =?utf-8?B?dkQ2NHpjc0Y0VzNPTzEzc2lmc3M0STgxZG9pd3c2TmVJMEFmVHBTQjZRV2F1?=
 =?utf-8?B?M3d3WFQxMkp6T09TMGpCM1dTUjl1YTBqaUQ2OGlFakJIb3YxZUdWclE0Z2JF?=
 =?utf-8?B?ZGNmOFpOdUkwbnUxMFd5bTI5Yi84WFZrWWFiSkIzVmhxU3UzR2srQ0dFTnRX?=
 =?utf-8?B?VXNMZFFlQW95djlpT0JIYk5NN0tNQk8xLzBhTnpwcXl3QytNZk5Gc1JrcVhJ?=
 =?utf-8?B?YW9JU01BM1p2eTFoNk1BMGtENDdDVFd1b1ZJWWd2QjhZVGlrS2h5UDFBSEhS?=
 =?utf-8?B?eERYN0kwdys1c0c2dzhPZ3luR3dTK2VCMTBzU0M1Y2QzQkJxMUZORlUwY3Fz?=
 =?utf-8?B?UmplWVNFYkVxM3Y2SE95UGlVaElSN3dXTzhLamlLTDRJTDhVc2xuK1J5NnMz?=
 =?utf-8?B?RXAyL1d3dlRROXhERG5ITGM5RWVTekVrc2pUTWxyM2xBZlRxbG9EUEpmUkFE?=
 =?utf-8?B?OVphYVpEdUdkVEc5cy9CSWdUQVVENllpa2tsVlJ4Y0N3ZzRCL2JUbDlMcXNt?=
 =?utf-8?B?NlIzS0VwY1J3TmphdURRNTBkU1ptRUlSM3hEb0hvZElwaklmNVcxdlkvM0FD?=
 =?utf-8?B?Q1ZUZTlQUDlZUno0QiszRW5HcnZ4VFB1MFEwaU16YWlVdS9wS29kTlBEeHFP?=
 =?utf-8?B?dDQxYjlnVUlSTExncFFxOGd2Wlo4aXdPUlRrSDBkbzZ6ejBOeVJKRlRPTmpN?=
 =?utf-8?B?U3AwWitwRVNPQlJQWExTMHhPZUtiSkdLVnEzRGsydTRaUmNoZ0hlOWNGK08w?=
 =?utf-8?B?VXV3TVkzVEMyNmpxam13dk96cC81U2k2dFowT3JCZkVBUWc4bmQ1Y1BCcjJH?=
 =?utf-8?B?Q3JmRWNVMkEvL3RJajg0YTI2R2M3UnlUL29aWldwUTV5ZHFLbjV2eStlVWJ3?=
 =?utf-8?B?cTJVOS9lVEMzZkhkaFcvcEhja1JBU1hnbFlqaXBFcDhBZG0ydHhDbldoZHBZ?=
 =?utf-8?B?aXdhd0kybjlHU2FKOFhrblh4cHp4Ky85aXhTZ3NpRWFIT25tM0pCYUw4NS9y?=
 =?utf-8?B?NXljZDQvUnAyWmQ0Y3JkQ1NGeDhQcE91WDl5V2RpNVdSNW1lTUEvZ3lybUJC?=
 =?utf-8?B?UVdHeG1lK1hTUEZnaTRlNlBiT0E3UUpHaHBtM1I3dU5pcUw5MzlrZ1RPSExi?=
 =?utf-8?B?R2JIcXdzcXJQRWNieGx4Z1pDcE4vdjlTeHdnYXFsY2ZJN2N1UUpCek9vQkQw?=
 =?utf-8?B?TG40MHRyMHl6bE1iUTh5YVdIM2dicHgrYkl3cU5qdk9vcW8rd0ljSGtyVWFj?=
 =?utf-8?B?Tmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4316d5a3-fe2f-4295-e76b-08dc32ecfc77
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Feb 2024 14:54:21.1687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: WULjLl49p0t32R9neH0t0QR/vyegeohPoTVKWDl0rISvbHz6LCifkY/f+7sNN5YdCwiFpE1Z0u+zk8IsPFNlJA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6024
X-OriginatorOrg: intel.com



On 2024-02-02 7:33 p.m., Jakub Kicinski wrote:
> On Fri,  2 Feb 2024 13:25:20 -0700 Ahmed Zaki wrote:
>> Add support for RSS input transformation [1]. Currently, only symmetric-xor
>> is supported. The user can set the RSS input transformation via:
>>
>>      # ethtool -X <dev> xfrm symmetric-xor
>>
>> and sets it off (default) by:
>>
>>      # ethtool -X <dev> xfrm none
>>
>> The status of the transformation is reported by a new section at the end
>> of "ethtool -x":
>>
>>      # ethtool -x <dev>
>>        .
>>        .
>>        .
>>        .
>>        RSS hash function:
>>            toeplitz: on
>>            xor: off
>>            crc32: off
>>        RSS input transformation:
>>            symmetric-xor: on
>>
>> Link: https://lore.kernel.org/netdev/20231213003321.605376-1-ahmed.zaki@intel.com/
>> Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
>> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>> Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
> 
> Acked-by: Jakub Kicinski <kuba@kernel.org>
> 
> Thanks!

I am not sure what is the status with this. patchwork is showing it as 
archived.

We are close to the end of the release cycle and I am worried there 
might be last minute requests.

Thanks.


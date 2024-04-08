Return-Path: <netdev+bounces-85682-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 568FB89BD98
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 12:53:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8D3D1B22552
	for <lists+netdev@lfdr.de>; Mon,  8 Apr 2024 10:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AA560260;
	Mon,  8 Apr 2024 10:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZDlkjqVh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D380E5EE8D
	for <netdev@vger.kernel.org>; Mon,  8 Apr 2024 10:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712573586; cv=fail; b=iq27shfHJEXTNdbClQg7OeQsq57Gnr3yjPe59mcgYLUI2mm2ZRktFarKE8OkzGY2zqxNS9CFURlyMuExE0xmu+XHEP33WCMf2zetoygQJlv8aT39rcCi1V3QUHSZUAA4F18GOAW7W43eXR04uIswezv5sY3bDQlqqHmfMBVtoBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712573586; c=relaxed/simple;
	bh=XULjBHKmQtq+4zzdQr01BvJu9ndyw2VD/e8CD4nLTn8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rTRt0Bfp+UMsSAAoFsbYpmYnzpceNdoRHgUl80TJuvRM+OqQ7k67c6P9YOUG1VYpFMcL6aRtpNnqiEn4vymKy2f8lHkvgBCWg5SVxQau6ePTewIkXB46aPI4/PpiD1JgauhymS0EpICU4ql7zoFauyzflRamo5/FJkw9mhY3pCs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZDlkjqVh; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712573571; x=1744109571;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=XULjBHKmQtq+4zzdQr01BvJu9ndyw2VD/e8CD4nLTn8=;
  b=ZDlkjqVhkJm3SxeCN52CXKOpDY482/yjAyojrZ4BTTJUIGx+mTqYP+Qc
   0WtyT6RHdlHJAzai3Lbh9vsNW2VNyxL8jc/v2BeqY0Y0AkNAQEufWrDFZ
   v/5ehu9CFxWUYhblHAp7F+o9qfzsc5UkBARcg8dM1evqWYVVfM/lPyh+V
   eI4gihQMhcxQ5IICfAVvT5Q04QjHHyrB2WyxTvbXJofyRmDivyLBD02A0
   /s41MLudr01qxUhL+VoQ1/u2m8mi8fq/4da2TXKNi35IqY0C4NNtMG13l
   0AUmvF+0kt2dNiKggI9Ve6aFwhy2i5Gvz7k5AopxJloKBseoa8hw5qg80
   g==;
X-CSE-ConnectionGUID: Q/5TDYhvTI2lscOMpusFXQ==
X-CSE-MsgGUID: +easXw//TSGl0AsRcy1EDA==
X-IronPort-AV: E=McAfee;i="6600,9927,11037"; a="8422764"
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="8422764"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2024 03:52:43 -0700
X-CSE-ConnectionGUID: qTj64FnATmeFBb1HfSqXVw==
X-CSE-MsgGUID: 9NsOFhYoTcmHptdQwHnTOA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,186,1708416000"; 
   d="scan'208";a="20286080"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 08 Apr 2024 03:52:43 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 8 Apr 2024 03:52:42 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 8 Apr 2024 03:52:42 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.40) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Apr 2024 03:52:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jIHZDO9vKnpJuZ5LloXDQIfEkxcohFhbferWOt5UpOcvQjy1NpJpQ8F1rt36GSu45irB5ZbeXs6Uun4Wxr0hI/DtXaKlYFYn04an9na0AM2vbxjLwKxflPlzwwLqH8r2AZtNOyKLYk8+AMaTmfly/Vs5TezlXuCz7LtP6OuVjs6lKULtz43+fHyqCNnSvcJ7vVT0oEfQaMhw2DbCWKtin/+ezqIPEsbWNTaVSUZmoKd/u3YXZC3omqrGXq+bkg3wlqrh/mvInAOaFQUPJoyyCWDjnp5cbKNO64tE+xL0K6l61Di8l/WoG/N8wlcPw4RDJTlgs2bsjXk2ABPoKlxnqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3A7mwuRWRCJUn9jQtI1LQftSsipkfp6+kThFbIparaM=;
 b=BaMSCakQ2sEPKKIr7lJ4eTVRPsu1NDg/qaLM0ER7F54Tn8v9po1FGj1/fZTDTAjOJgoGXqEggD+tNRtiISMeSTL0EE4NESVYfnmLZULqEE48HushkQWCq2l1qVvkCA+G8JjWCvHGt3weDebOTn46kIjGRRNX0eEHLSDnWWeE20sTQf9Tk9DgUUw66e2TrlOui4UepY8jWyh7/6Vk1QOIgXm87XRDVaTv2sdZMc27xTGrN0YPfYzhVpCyWbc0M2vMWWhW90BbJEY9KxkmOFixcSBHyQfhz7kSbfW2tmAMhf4bDMm4pMVGrBrj3TkUeHRiMnQ7I6nJOIDFewACbVpNpg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from DS0PR11MB8718.namprd11.prod.outlook.com (2603:10b6:8:1b9::20)
 by DS0PR11MB8050.namprd11.prod.outlook.com (2603:10b6:8:117::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.32; Mon, 8 Apr
 2024 10:52:40 +0000
Received: from DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9]) by DS0PR11MB8718.namprd11.prod.outlook.com
 ([fe80::654c:d66a:ec8e:45e9%6]) with mapi id 15.20.7452.019; Mon, 8 Apr 2024
 10:52:40 +0000
Message-ID: <2bcb7a6c-27b6-4929-ac9c-c6eba3b804b1@intel.com>
Date: Mon, 8 Apr 2024 12:50:48 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next v2] pfcp: avoid copy warning by simplifing code
To: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
CC: Simon Horman <horms@kernel.org>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<netdev@vger.kernel.org>, <nex.sw.ncis.osdt.itp.upstreaming@intel.com>, "Arnd
 Bergmann" <arnd@arndb.de>
References: <20240405063605.649744-1-michal.swiatkowski@linux.intel.com>
 <20240408081829.GC26556@kernel.org> <ZhPLEuZQ0T7mQHHT@mev-dev>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
Content-Language: en-US
In-Reply-To: <ZhPLEuZQ0T7mQHHT@mev-dev>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DB8P191CA0002.EURP191.PROD.OUTLOOK.COM
 (2603:10a6:10:130::12) To DS0PR11MB8718.namprd11.prod.outlook.com
 (2603:10b6:8:1b9::20)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS0PR11MB8718:EE_|DS0PR11MB8050:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: zCQVb9fTspXSoRqRU5hmkyvIzyKQKRDbdp8NpUjh9OEu9jZi1HS8xiDizM+CkbeaARL+sk6ozAV6g/SiDwW1WWm0q/tPCZB4rfX5R3TLKpC8slF20K6KDewumui4osAb9P45Juab2UVcYFnmbzHpqU8nRaCNkiy5ftLGUFn7/Sc9azOE2vGHablxjP85VAdwZWy+KcHAM5JOFzP+LV/tn0qX/7GyB+ovHmo2iwZTy51EZHr87DjLp1DySskXj2VZH83nBKwJSiepcQC7Q71eKRpSwzMpcJH3UBwQAa89zFVDaOO69RUDhRhpM2Xa7HAd49Aydbyk4IpWuLGkGUF9ginkZjPQSWSeEx8eMHvUQPpA3llIKHGBjTjh58sPXzS7dt9xblQcUrul3T6xBLIuIm8yA1W+HbrgpJnYFmYIJi1aeaN7MMDkJfCH9j8Ar3SmFXgsq9YU3eU3ZCKrj/VL01+ZGatwDVdY42pRdYUR6y1YeNUlIa4q0Mn0HwHT2kLnMJojm5aWVjJLpvXLsOx+R+EMuCEBOAfbzkMT3v17uhNzUunaqDf2jgKgBhDA/YwLuMujLs93Ssfs5Uot8gB2GEC5UuJHnTguuLloKLbcnsE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS0PR11MB8718.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZllrdENqTUdBSXBxdjlIb25MTGQ3Z3lPUzFYc3JRRXNoRkhxTXdOMlFvQnhh?=
 =?utf-8?B?b2lSbHJnTHVkbjNaWEVtUW53dWxVZmNyUEQva0Q1c0RoZ2JtUzFOaGZ5SytS?=
 =?utf-8?B?YjdCMHVFSGtHdDdsSTVtN0ZDQWdEb1ErbFpyR2VoMnNoNHhOTzRQQVhtMXY5?=
 =?utf-8?B?WDBtRnh5TG1TQzBsYWFiZ3BEaWp0MmprZVhNRm93eHc4cytjL0dGWHA5dlVZ?=
 =?utf-8?B?SzEzNlk2bXE3eVdmT0hjbWtpN1BpcWVUSkx3M1NTNVVMV3QzWjhsWjd4anBn?=
 =?utf-8?B?amRlNi9VYW8yMEF2NlZXMVhxMkQ0eWZobHQvZjFiM1ptUXNDR1IyaytncmFq?=
 =?utf-8?B?Uk5RaUNFWTFDV1YzYlB5SlppNVdVTUMvNU5KeTIwWGZFeUpqb2l4Y2hvZGVl?=
 =?utf-8?B?ak9PVFNDZm9IWEJ1N3FlVFFOc0hMM1R2NXNWbDFId1dtWThzUTZWTFVWZ1dV?=
 =?utf-8?B?WHcranFjRHZ4VllWYmpKMXZrbVAyV1ZPK2M5c0N6ZFBQUTRCRGhkMUoyZHRj?=
 =?utf-8?B?bWtmS1FvV05tQXk2ZENmWVl0eVZPWnR1UGM4a0YzbVVpM0J0bTdpY1F6Mm9I?=
 =?utf-8?B?bDI3QnZ2aDJsNUE1UWo2WGpUUGVFd2VkRnpnOHhpOVFma3lVSHBIeTFZcVo0?=
 =?utf-8?B?bmxkYStHMHdTM0xMZ1BXelc5UHkwSmUwVGkrRmxla1Y4VVF4K1UxN2UrZU5N?=
 =?utf-8?B?OVIzenBOYlh3bWc0dWtYK3Vhd2gwVVFUaytrWjNuYkM4WHVmK0RFN2lQeUts?=
 =?utf-8?B?MDh4ODd4R2JUVUszeXI0YzRKb2R6VWprcTVMQUVmay9hblVNb1dYT0tyeEtY?=
 =?utf-8?B?WFVzZUJkV2ozTXAxMVlraDZjYkNNbHdYV1Q0aWZVTDkxWTdIeE12aHFHK0p2?=
 =?utf-8?B?RlM4Q0xGbHlBaVRiUXVJa3RpUnQ3cXplYm82NjJ5aVIweElKYVdpeXlUSWJw?=
 =?utf-8?B?WWVGMU12d0VzUit1WnFEVjEzWVVFbG5GMUcrVVMwZHVnbjkxRm5KLzdiYzg3?=
 =?utf-8?B?ZjFKRVNnZ2F3UWZmYTNyeDNDVjBrM2Nndll3QkhWSVFHZnZCc3hPdEVsM3BS?=
 =?utf-8?B?QVhNM2kvRzRqYXVUVDB0YXdwb2YybUcrMVExcW9tMTRSWEhPZFZwdG1idXlt?=
 =?utf-8?B?M2hzQVIxRGJBNFE0UmtJczlPWGVxd2R2RldVQXFFdGNmOUt4VFdObmZQU1Vt?=
 =?utf-8?B?YXhsUUJpV29sZkRLMllmNHdESmxNenM3U1JzVXljYUgzUzBJR1pYblhteEpO?=
 =?utf-8?B?aVVNK1dUNkI3ZWx0UDNzYUNKMzc0SitkTXJxQnFDc01ZWCtrcDY5U2dsTmtQ?=
 =?utf-8?B?bnEvdUpJdFZNTS9OWW1jOHBjOWI4eTBkb0VmakpjdEpQWjNIMWJGekptN2VS?=
 =?utf-8?B?S1hwUXRHdkhCTGlJUXdJTFdzeklRb2REdkJqZmtkMW1DVGNGQ0ZNVlcwZ3dr?=
 =?utf-8?B?THlKTkh4SnNaTExqcnZLWjJDK05DbTU3ZDh2M2d0Tkk3bHJWVFhycGo5K2xN?=
 =?utf-8?B?VVhya3lWeDdTa1U5Lzd3MDRNb3Bra3p4b1lUVGRMMTlRQlh4T2c3bVJtSmgy?=
 =?utf-8?B?UDUvWlFYWEcxd3B3MFlyemRDR0dIc1FUTjg5S3NQVU00end4WXdXQkZLbXVH?=
 =?utf-8?B?ZHFpdWtkQXB5ZFFab2c4WHZiTXpKaHFnZ0dGcTFIR2ZheDBFRHR0VU0yREMx?=
 =?utf-8?B?aTlSakZXWXVEaFptVCt1M1IzUXllemtkMFVXMUpUM293aEpaWVpFMjliWitC?=
 =?utf-8?B?cjlOeWlHRDRvdTdqQkZwbTEweFlOYmZQZkhQb3drZWxSbWhld1pXVE1RSWxt?=
 =?utf-8?B?MHZxMStBd0RxeE9qNVVCYVFsNDRNYi9LN1lLa3JzTUJWQUcrQm51VUMxNUN0?=
 =?utf-8?B?MmdMc2hXZnhQZzdsU3NoZCtuMHhVK3p4QXBOTzJ6d1pCVHQ5Q0tGdHU2Y0t2?=
 =?utf-8?B?NUM1dStkUDJuSW9HR1lhanNKaTlNSHBBcW5xSS83ZzMzZEVDRXVmRGRic0RJ?=
 =?utf-8?B?QjFxcXM3T1RWbHBqUUNOd3Z4TVFRTnFrc3hJQ2R4Q3BIY3Q4cStxbkkzK3Nw?=
 =?utf-8?B?ZlZGN2g0MGp6bCs0bzRXLytES0RnQWJWd1hCajBLK1pxTFdXYmFuTFozWUNF?=
 =?utf-8?B?MXhLS0plY0VTSm40OEtYc3ErbVRDdkxYajRxZ1VxSGVlclIzeFdJSkczYWsx?=
 =?utf-8?B?dGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2bf394da-9c4e-411f-b932-08dc57ba0295
X-MS-Exchange-CrossTenant-AuthSource: DS0PR11MB8718.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2024 10:52:39.9550
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: biGM6CItOR4JXii/3K3lrHAN8VweIlLZVoer3DLl8Cd35znH3R8jUNYXHua50WOi4esnLWq05MInbD60bIuUSRciQzDl5lgmfikgd1ar7f8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8050
X-OriginatorOrg: intel.com

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Date: Mon, 8 Apr 2024 12:46:42 +0200

> On Mon, Apr 08, 2024 at 09:18:29AM +0100, Simon Horman wrote:
>> On Fri, Apr 05, 2024 at 08:36:05AM +0200, Michal Swiatkowski wrote:
>>> >From Arnd comments:
>>> "The memcpy() in the ip_tunnel_info_opts_set() causes
>>> a string.h fortification warning, with at least gcc-13:
>>>
>>>     In function 'fortify_memcpy_chk',
>>>         inlined from 'ip_tunnel_info_opts_set' at include/net/ip_tunnels.h:619:3,
>>>         inlined from 'pfcp_encap_recv' at drivers/net/pfcp.c:84:2:
>>>     include/linux/fortify-string.h:553:25: error: call to '__write_overflow_field' declared with attribute warning: detected write beyond size of field (1st parameter); maybe use struct_group()? [-Werror=attribute-warning]
>>>       553 |                         __write_overflow_field(p_size_field, size);"
>>>
>>> It is a false-positivie caused by ambiguity of the union.
>>>
>>> However, as Arnd noticed, copying here is unescessary. The code can be
>>> simplified to avoid calling ip_tunnel_info_opts_set(), which is doing
>>> copying, setting flags and options_len.
>>>
>>> Set correct flags and options_len directly on tun_info.
>>>
>>> Fixes: 6dd514f48110 ("pfcp: always set pfcp metadata")
>>> Reported-by: Arnd Bergmann <arnd@arndb.de>
>>> Closes: https://lore.kernel.org/netdev/701f8f93-f5fb-408b-822a-37a1d5c424ba@app.fastmail.com/
>>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>>> Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>
>> I agree that it's nice to avoid a copy.
>> But I do wonder where else this pattern may exist.
>> And if it might be worth introducing a helper for it.
> 
> Right, the same is done in vxlan, ip_gre and ip6_gre at least. I will
> send v3 with helper.

Dave applied v2 already, so send this helper as a general improvement
w/o "Fixes:" :D

> 
> Thanks,
> Michal
> 
>>
>> Regardless, this looks good to me.
>>
>> Reviewed-by: Simon Horman <horms@kernel.org>
>>
>> ...

Thanks,
Olek


Return-Path: <netdev+bounces-59185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90656819B7E
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 10:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E89591F2656D
	for <lists+netdev@lfdr.de>; Wed, 20 Dec 2023 09:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D653D1EA8A;
	Wed, 20 Dec 2023 09:36:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="OE5l4T6a"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482491F5FA
	for <netdev@vger.kernel.org>; Wed, 20 Dec 2023 09:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703064992; x=1734600992;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6IGooLX0+CA8dh9P18/cndv6p3Mf27isV+FiZU5z6cA=;
  b=OE5l4T6aoth06VAXztKejHwnIRCenKVqCWRK1RIsyP0oJY9U4mzR4o6q
   y7aBjZZgNOz/DY+siKQbwYCoW7pu0lp1j5D0YLB5oN1WP2DCTaSab5656
   e6re9pgZBrRXSgRojfM4ZIZRP61Q6hDGuxT7YAX7iTDC3IpltBvDhvxhL
   Xj0lSb/zfjNwtUFabrkSychM/WA15tNTItX8uSZ3uyywEO1/MKLiqmRmN
   pMjvUwaz1IYf2Jn8pWIIWl7wWMUwUzpP5/+ghfIDcmyIzP2UwlhLd6pAg
   D3vEzCzHO2p/p+bFyN+cQ6nzO+dyepuHQWnOjTRZfAd3D6R0znEeDYVu1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="9250710"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="9250710"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Dec 2023 01:36:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10929"; a="1023415595"
X-IronPort-AV: E=Sophos;i="6.04,291,1695711600"; 
   d="scan'208";a="1023415595"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Dec 2023 01:36:11 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 20 Dec 2023 01:36:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 20 Dec 2023 01:36:10 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 20 Dec 2023 01:36:08 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A9dUkIhkFDUUPz4ykMm73sOciBZaD//74CGNL59Pm6gCAyTlqjgO1UGSUbb2ayGVxtVtHtQxOkNVBqr52dM2Yxa1ybElfccTW3ae2G1YUEfbZu7t2YdhJX3l+evO5qHr1u9pQr/dMCD0Q19i6/7i1TrRKSLwB/u7outchp2ZTxwl1GORILkthAQa9ytTeWmkb8d2GvnNjAqjEigtqkoTpjb59Ra/YToaZe8lxkVJS6P2QoLPIbAIdf+ug53/syenBCVoTC8kVzRzSh+MUhsUl0kaQYuQJhlI36/kjWMdfNHYg7B6GYlHJsdEjcaMvcicUiWp5Yo3+3wMLrjt8JUDQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ubY+al8h69agBYun3qvcJepX8QhzkJqHkXxzDHbS1ZM=;
 b=ZAgfyxgz1Rm4zT0qDCh2XiWZp7CG46XBBfz1dQ1kCnwGliMrlRIB/WuP4pO4254m+c7VXi582mSgtjVrRcWJCWEV8C+y3ceWDeSMhehtPZIBRvvRHM7z+S1TbjBcXGnQvY6lgbhV4bNvwT5HD/a75vyog+A+Fg80ZLq34THrKFUUxag1NEcSM+yL21IdWThj1nWOKQzNcbzztAkmJ1sJrZkQFyGQsOxOhVGlTZPwlcTorR9h3Z24UHnq9TR+BNWv8uEPj66vPiHs+Ml8cWDiY81VMxn8kSBGbzrewyHnYfKEaZdxt//jGqNogkjABEAx4ZMTW4115lsgcAw2Ry9J6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by DS7PR11MB5989.namprd11.prod.outlook.com (2603:10b6:8:70::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Wed, 20 Dec
 2023 09:36:06 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7113.016; Wed, 20 Dec 2023
 09:36:06 +0000
Message-ID: <756f09cf-0573-8391-fa90-0e74678d2aff@intel.com>
Date: Wed, 20 Dec 2023 10:35:57 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next 00/15][pull request] intel: use bitfield
 operations
To: "Nelson, Shannon" <shannon.nelson@amd.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>
CC: <jesse.brandeburg@intel.com>
References: <20231218194833.3397815-1-anthony.l.nguyen@intel.com>
 <e45bb504-df59-4f6b-af0f-da7d27ba9ed0@amd.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <e45bb504-df59-4f6b-af0f-da7d27ba9ed0@amd.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0171.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a0::7) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|DS7PR11MB5989:EE_
X-MS-Office365-Filtering-Correlation-Id: ceb56e23-7242-4a5c-1d0a-08dc013f16f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZGIWyQIe+92zBYMHWI+ojwoFqM8IEXpZlBZ0DNP/iGPRscaPzB6dzL8nB7U2kPvzUF/LOXeirywMNfqRHtwIQPoetVl9keHec3FvcIR9Y2GcNUGQxS4IkBZe4z+iRRqKuuEnCLGsU1BLB3LqtR2lWwjJ4Af4JULVe71cF44FElS+kgx2NrdQw7xbI0C1/dKYfLHty0QfMRx2BDEly057oVxwmPTYQw0wtHZlF6UPt0/k++SJb+5x+SC/VGM0Ic+GIOBloTwBLZ0aBrT+XgxeIwrAGMqXw/Xg+it7tuKU+G32UQiZ8DZ+oUoOazaY3Ed+EMINJ37E7h+nVzTc+TffuAUF14sNXEXcly4piqCu7y+jET9scNR39dBzdN4mnH90SN52oFlpZ5NEurWOdnz661n6EnqCKldrRqX9S3rDgCok1DFLz+UdfwVpUd0W3SA5ch+iv1dzlQVkpSO2nk35sNTJUFjVc6eFl2kxpyhfUNPUprSGmySlOtXwH55wqnea9pMMmbbgOOvMbZsJPRY6XRJ4ZfNgenORMuOwGm+4ZcJvUhrIk96IzRrYw2WMCK0VdHe+pVHd94u5z95KxRgxtlGoO48B/PuqNT37EpF4Jyi8OQWd/mumEe81kH5I6Uk+bXF6sZNzSN9t7GeSH0uRWrJQRKvdc/U3228iaS99xOg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(376002)(396003)(136003)(346002)(230922051799003)(1800799012)(451199024)(64100799003)(186009)(31686004)(4326008)(26005)(53546011)(83380400001)(5660300002)(6512007)(6506007)(66476007)(8676002)(8936002)(110136005)(66556008)(66946007)(6486002)(107886003)(2616005)(478600001)(316002)(38100700002)(36756003)(6666004)(82960400001)(2906002)(86362001)(41300700001)(31696002)(21314003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dFFrNUJ2ZGxiY1R4VEsxcnpaYzQzcXo1N2FFcm82dElUd2Jsa0hnY2ZnckZo?=
 =?utf-8?B?eThDWld6c2M4d1RPK01hVElaMHJWUG9jNWwwQmlNUzNwU2JkN0pvUEVRa1Rr?=
 =?utf-8?B?bmlJRGQyY1VoeHZUNnRkMzFESkZFaFVpcDMyTS9QNGpldjhLeThOTmhtak9I?=
 =?utf-8?B?REhBSWxwQjQwb2hHdmphWTFPVXZxYkxmVnE1SXVhRXl2Q2xyTXcvNEd4dzNS?=
 =?utf-8?B?amJIZzdGL05TeXB1dWZYMU9KVHdkUmVORGd3WVFGWHBZQjZvaFNSQmhRTkFK?=
 =?utf-8?B?akY5R3NwQnVkSW9BVnU5TzZVMHVWVmhHSUFRMEl4Z3kzb3ZWNEtmb2RlRzZq?=
 =?utf-8?B?QmFwRzM4RWlyeStCZDlpT1lTNDI3VXBwYjN1K3V3WHVwaTJwRDVOcG9ZZlJs?=
 =?utf-8?B?U2F0cE9WVjF2Ti9sRlkrVVY1Vk05Vkoxd0xSNk1jdzdkSy95NnZNZmZJbDln?=
 =?utf-8?B?TXE2dG9PTU00Z3IybEVzT091ZFZJUjJrZ1cvdE9yemNTcXdxeVJrV3hRQWkv?=
 =?utf-8?B?dVpaMHJjbklUSEtPc05VNm93QUF1cVhiWFdCWG5vUXdYaExLMkR3VUlxOVVN?=
 =?utf-8?B?UytkZXVlb1lKbk1YbzMvWjhzaDRwOWd2b29lSHFwbU0yb1gxVEFYT1lyWGhk?=
 =?utf-8?B?YTFOL2VOZTRseVRNd3hIbGpkNDJaZ3Q0ZE4vcGhSSFliRCszaHFsaFZEV3Z6?=
 =?utf-8?B?RGZpOHVDRDdyUURHdkRjZC91OHhtT3oxTklieFI3MjlPT0tLOWYxTEF4Qkt2?=
 =?utf-8?B?UXFtcnJucW9YK2t2dWFjMnEwZ0x0cE1HRWNJVHpyV2IxS2FZTkZTOUFRVUxo?=
 =?utf-8?B?S2lXQ1d2Vkh2Q3grOVh6ajdLano5SDBYM2hkMXFCMEpQakZLVmFpSEFLRXVD?=
 =?utf-8?B?dHBPQXYzYzRITXh2ZWhzaUhyWjc5RXNjNWVubXNDWWI2c2tNL1Q0eWRISmZS?=
 =?utf-8?B?bVZ0b2FoVEVNQk1VSTRSTS9NUkZhMmV1YkI5VU1kYnFmVnlIZjN5RVlUOWNL?=
 =?utf-8?B?dU43SmxUVjhSWm1HMXAxaTVxdmlFa0dkOUZsMTVDTkFGaTF1NzVERGtpS0JQ?=
 =?utf-8?B?NGJMK2VjRzl3bHltQVp3Vnp0SHdEVlFsOUF1emFLbTQvdCtTbGJqQzlkbmY0?=
 =?utf-8?B?OFdkSnNGNmhHVldQdXJ0Yzh6SWN5WXBxOHFpNk5XKzQwL1NxR0l6ZmFJNS92?=
 =?utf-8?B?SFp4L05HTDE4OFRtT2c5ZEJ6QUNJVjh0MEI2eVo4YlhvL3lNRStHZUt4bXd6?=
 =?utf-8?B?VVNFcEtCeGozUVUrcFBjTitFTVJXN0VlL1ZEc0hxWFJGUHJoMHVSd25YcnRR?=
 =?utf-8?B?U2NWdmR6MGoxU1BBUFM0MXRnVTFuQTNBbGswMHAwQ2xHVHQ2Rng2aFVXazVY?=
 =?utf-8?B?ZVhVWnVFa2JWUkwyZ1JyZjBGT00zQzRhTHd2bXlxUVg1L0dVMnZsTWFBTHZi?=
 =?utf-8?B?WFU3U1E4eUdQQzVyL1I3NVE3SUFndzJvemhQZUFlcjlmeThKNWgxTWpXZFVZ?=
 =?utf-8?B?clJrQWo0REx4YWJtblllR1gzUlQvR0pxU1R4RFF3a0tWa1ZJVGlDQUdyU2NN?=
 =?utf-8?B?VmZyUkhuWGlCcCs3and6ZytHbVdPeGtMcC9lb0hKcjNKT2xJZTIwZ1Z3Y1Fv?=
 =?utf-8?B?UDUxdkNnVlB4ZGFaT24wMDhraG5oV244OFlZM0hYQklURmU0WXdZR2hJUjZa?=
 =?utf-8?B?bHg4U29NK2NOb1FkNW5aSWRzbHVqSDdJbytUVmI0eTNSc2VnNjJJUldsaUFV?=
 =?utf-8?B?N0NUNzZCTEpQa3VmV1F0dzVldDFPZENsMzEzVXozSUZ0QXowclkvVnRiYTcv?=
 =?utf-8?B?bnE2aUFlZ2xxNXB5UkZPR2w5V1pZSlZQTFU5SHB5ZzFNNEZPQ3VSRlZpNmIr?=
 =?utf-8?B?MGJkRUtPclc4UEUxb1N4b3JUS3hGV2cyL3JGdVQ3RTZKajVrTE4yMFR4emlI?=
 =?utf-8?B?NEQ3WFhML1BIdVA0eFU5bWU2QWlKcjlKUFRER0ljMGkrUkJPNnBGa1R4KzJZ?=
 =?utf-8?B?NXRSQUxYL0lEN24vcjI4V1V3K3AvNVhrMEJyc0hmWUk1OEtPQWpEV3l2SVQ1?=
 =?utf-8?B?U1lRNVpZSlpMU0hldlA4VzBtTFJWL2dzOWFnOFZjMHNackl6ZDRRM0RpSU0x?=
 =?utf-8?B?cTVZK1kzRTRzMHBwbVVaeG02d3k5ZFEvWTB4enVmNzcwbUpieXhtN3FGQU5t?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ceb56e23-7242-4a5c-1d0a-08dc013f16f8
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Dec 2023 09:36:06.3258
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6T3O1aGL/oPnkNF+YWatHmbJEjtUvxSBubNexamk4EOB9ypvPTkyFT9PlswLSXz+3dDnmcNEz5WUrzBJtxKVfJ3sp7hNKG3zvjjEDJvQYm0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR11MB5989
X-OriginatorOrg: intel.com

On 12/20/23 02:10, Nelson, Shannon wrote:
> On 12/18/2023 11:48 AM, Tony Nguyen wrote:
>>
>> Jesse Brandeburg says:
>>
>> After repeatedly getting review comments on new patches, and sporadic
>> patches to fix parts of our drivers, we should just convert the Intel 
>> code
>> to use FIELD_PREP() and FIELD_GET().  It's then "common" in the code and
>> hopefully future change-sets will see the context and do-the-right-thing.
>>
>> This conversion was done with a coccinelle script which is mentioned 
>> in the
>> commit messages. Generally there were only a couple conversions that were
>> "undone" after the automatic changes because they tried to convert a
>> non-contiguous mask.
>>
>> Patch 1 is required at the beginning of this series to fix a "forever"
>> issue in the e1000e driver that fails the compilation test after 
>> conversion
>> because the shift / mask was out of range.
>>
>> The second patch just adds all the new #includes in one go.
>>
>> The patch titled: "ice: fix pre-shifted bit usage" is needed to allow the
>> use of the FIELD_* macros and fix up the unexpected "shifts included"
>> defines found while creating this series.
>>
>> The rest are the conversion to use FIELD_PREP()/FIELD_GET(), and the
>> occasional leXX_{get,set,encode}_bits() call, as suggested by Alex.
>>
>> The following are changes since commit 
>> 610a689d2a57af3e21993cb6d8c3e5f839a8c89e:
>>    Merge branch 'rtnl-rcu'
>> and are available in the git repository at:
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE
> 
> 
> Thanks for doing these - this certainly makes it significantly less mind 
> numbing to read all those bitfield things.
> 
> Is there any plan to remove all those xxx_S and xxx_SHIFT defines now? I 
> expect not, but I thought I'd ask.

There are any unused now or 'it just asks for refactor'? :)




Return-Path: <netdev+bounces-17291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BF975118A
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 21:53:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FA472819D3
	for <lists+netdev@lfdr.de>; Wed, 12 Jul 2023 19:53:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1A1D2417C;
	Wed, 12 Jul 2023 19:53:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38D224177
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 19:53:43 +0000 (UTC)
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5A4B1FDB
	for <netdev@vger.kernel.org>; Wed, 12 Jul 2023 12:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689191622; x=1720727622;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MhWtdnUdyZRue5+jXdY3hJbFSM91Cdol4AJJgJHD0qk=;
  b=UYTo1pCg5X9X5rIPOIOkrG1FtspiQZdyXQ4hr/dp4zm0Gs9rWUl4vSW0
   VBvy94D2w5ckgdkefiGf/2cYX3RnyawV4MlSI53z+D2AQJ7QOm5wWL3SD
   1bZR1iz8z+Oaw/CWuPE5jN1baJ71GmbYsY/3NVdh2pKq1ar6aIUsB9lto
   Eh8YT4WV9YdOSGWpeLzlnx/fshmr1h3y7Y0Pmz5OGqkxLNJ2eKckEY95v
   YL27XZ/QSwRAiXXXCvRlzjGhOl1zoVQIuOSxIpWD4noz5vmtEk83qW9Qz
   SX/lO2TjrRLRtZLGXwHob3eBB/co5SkyzJIVBJGF2Dc+7wLTNNUUGMs4W
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="363856922"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="363856922"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2023 12:53:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10769"; a="811713104"
X-IronPort-AV: E=Sophos;i="6.01,200,1684825200"; 
   d="scan'208";a="811713104"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by FMSMGA003.fm.intel.com with ESMTP; 12 Jul 2023 12:53:40 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 12:53:39 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 12 Jul 2023 12:53:39 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 12 Jul 2023 12:53:39 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 12 Jul 2023 12:53:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VrN1iLD/cvbCCMpk4HfUt4PVUDyjRUx/9pwVC41yCgni1oicDZmE1lItcUk0dnsN+lUV29R+bOf+fWLJoQgPrzPAQsjRqJoF3CST00rc4WHTEun9TypbZXAbGpCWHhoDp2XwMeDXoR5SYx2z5hD9Lp0NDm0HGnukRt5IOuWqJgivqeI7nvsVKkTAemhiLLLsRNBBrbQ/HqN/MdhsC6A3h4uz5x1vdEQk3661qA7TEyoDRfrxBcskhCsIjl9v3EUuPf+S+NTb5j4VPCC4ahCG709xK8nZ1+XXJyYWvsEiv4CXXOmfOIbsX9q0rSwr06afnt2uMR8CQcRNxCFA5+nfqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=38MyVo2fGECGdpdKgKUHU4tnilLWPhuG4E2TORig9zY=;
 b=K81wg8FGPMGt3tVWR71L9Yv+RoFtxc8FuLtKkUnHxTqcn+6488lgCiYysw/aJZWuMZ4ybkYo2EQsT2R5H6C7nY30cbvYG+e3EuzLc1PLUccz9jy4FZl1RkLKAIgZM+KypaNTJdMS9Eoqj68YOa+s/nOoOklVTYd9wUjWQX3YPy+m7RA5mVNUJNrr+14F//IeumOXKSS5VZM58DAoFh4IFxDEXEl+5M9oLpjQwXS1Hsc52il33UYHgz78iPBWfaDXymWTrEKMKD8raYCKDf431YAH9OmnvUHkc275VMfoYIAIvh9MXYc33/4fo/UgPdnIou/Qgz82782qpOFohkCmTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by CH3PR11MB8343.namprd11.prod.outlook.com (2603:10b6:610:180::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6565.26; Wed, 12 Jul
 2023 19:53:37 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::dbf8:215:24b8:e011]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::dbf8:215:24b8:e011%5]) with mapi id 15.20.6565.034; Wed, 12 Jul 2023
 19:53:37 +0000
Message-ID: <fefa92f9-7981-c705-529b-992d712c413c@intel.com>
Date: Wed, 12 Jul 2023 12:53:34 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next/RFC PATCH v1 2/4] net: Add support for associating napi
 with queue[s]
Content-Language: en-US
To: Simon Horman <simon.horman@corigine.com>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <168564116688.7284.6877238631049679250.stgit@anambiarhost.jf.intel.com>
 <168564135094.7284.9691772825401908320.stgit@anambiarhost.jf.intel.com>
 <ZHoN2ci/QbBIT7qj@corigine.com>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <ZHoN2ci/QbBIT7qj@corigine.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0002.namprd03.prod.outlook.com
 (2603:10b6:303:8f::7) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|CH3PR11MB8343:EE_
X-MS-Office365-Filtering-Correlation-Id: 4bf269bf-a1c4-4a24-3b90-08db8311aec8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MPzANu12Z8W11VJwa1ZmjJei54A2IZpzftmxeaWk5Bq7qm0pD2nIqNvrPsLW6XgQ6CUG07RJbdGUzsERcLAc0JAqhPEXsZ8/8U7Sm3ZPaL9EolBExEQ9bd13Q83p06VOWOqH23tbkBFFjNmpKLfbCiGQJiq7PWvKNSCyhv2JqMUjWyuSTKT1TtlosWGcLZVk0oH3x9b+LjqdIZX5OB9z0gwm9oTC8eyqaylIArVR//G5Sw6MJPMVfq4To77hgQRBQUyJBw8VzmVL5F5vv7EQMjdogRsPLLNFSm6+vxdkWkyDwvJ9JPpCCib6ObM5QI5HDvDqDHYF3r0iR2dEntVhygfmjRDfHNH9EiV8RzOds6by1Q4EW/TqOWq5I80Leodveu8VIEtwmdSRjZnjcojPl2VwNOtyqnGU2aGqDLrifvA80o4c7fqWLY1iurlGDzYgUe83hAFa1vFkEQk1tKc1IpJmHG2Y35V/DtU1n0/I3HN3xCZ/fxIPvPDXTsT39z1qNBsu4+tOO0+BlBFcCIDvUDhxHKV+LgGeaZuyQNgLTYAQCHkl+pPc5wtd0S/C8GiSEWNmcTH9IAN/pgxKbirGApocd+2Mm6hWHpMpFe34sfayEcT+pQ12VNVw4cIuR2iCZ8Tl9JLVXnKc3c4RXV7VOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(136003)(39860400002)(346002)(376002)(396003)(366004)(451199021)(4326008)(66476007)(6916009)(66946007)(66556008)(31696002)(186003)(86362001)(2616005)(26005)(53546011)(6506007)(82960400001)(107886003)(38100700002)(478600001)(36756003)(6666004)(6486002)(41300700001)(31686004)(8676002)(8936002)(5660300002)(6512007)(316002)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?RUdyZDNYRERXN3M3QkNUMEN0TFJ1Yituc0Y4SEk3WXFhVWk2WXZxZUJxRE5l?=
 =?utf-8?B?ZXVwT1dPbkQrbG1zeUlBd0lIN0RMNnNnRlhzY1lBVnFHM21HblVvdi9SVHVj?=
 =?utf-8?B?N0NZV0N4VlJXTkN6TS92U1JLZC90WVVPaG9iemlpelZQcHNhZ2ZSTlgzZkRv?=
 =?utf-8?B?NnFUMTlZWkVJZXRlK3RDZ1UzdnpaMk04bTVacVZQZnlMWWoxdHB6djIxUVNa?=
 =?utf-8?B?R2NvRm8wMVZxaXIrWG85OVRGZ1NQbU1jdktXQS9pRjB1M3VoNmJSVkJEMnFR?=
 =?utf-8?B?U29pMXNoaWRpc29WeXNGVi82QXl2cmoxWU9Uc2J5RmREL2plQXlCazBSRlM3?=
 =?utf-8?B?TVdOdTZhU0pjb0NKSnFMS05nVXB6Q2dNcVVOczEzNURuR3RwejAvNzdaSFJU?=
 =?utf-8?B?bWJGM2R2YVV1Ui9hd2J5WFFTV01iSDQ2OTFaY2tuYW9GeVFjTlNtMkZGbXM2?=
 =?utf-8?B?N1BoTkxudFFnTUU3YkFhbC90OGkvWnpuSEtIbitZaysyaTFHb25mNnorUko2?=
 =?utf-8?B?OVN2UDFCVzBMQTNhMnZBWllqVE85ZDhQb1dhWjVzd3U4NFY4aGZhdlpLNThY?=
 =?utf-8?B?ak5KaHNYVkxBREdqbGtSc0p0R1BEWGJROW5xejlLVGlDeDVGMkV2U21lN0RQ?=
 =?utf-8?B?Tk5WczRjeUhqbW11MXdnTkRFTXJLZmhhcnZxYkpkN3JyeUN5Yk5IeWdKelVm?=
 =?utf-8?B?VnorZ3Q3V0JpN0I0ekFPVFdzZDhyWUxSLzdpdkFVOWZ4QzRjeHl1Zis5Mkww?=
 =?utf-8?B?cVVFSnJDc0JObmtOZzYyZ1VoODNEQWVXWDZHa0hsSzNjOUI1WHlPcEpXWXlY?=
 =?utf-8?B?ZWVjMHJGUVRHaVFTMytuV05uWGhGOUJMQkFXTS9BQmd2M1ZmMzJIa0Zob1pa?=
 =?utf-8?B?RDMrc0U3ZlEwT3I0SEJmZjNwdW1rWWJ5a25CTFdZeFpLMUEwL0FtQkFWV2VQ?=
 =?utf-8?B?VnFYNjFYRTlOUWIxNXpObkdvcHM1RjZPU3Z1OGEvR2NpOVFTUzVZSTNqUlla?=
 =?utf-8?B?djlPT0c4bXZGVHY1cWdPcnNRWVUwaThOS3RvejRqMWhEOEtYejEvMG1IV2Nw?=
 =?utf-8?B?YTRZMTN6aFBSSk9XdzdycTB0bnZmZzJQTFYyVXJFOTl2dnJLL2NCaHYxWjJx?=
 =?utf-8?B?Wkx1YXNzTlJySXlhSmg2bFAvRG16Qnk4ajVvd2JMMjZSMXJ2aFgxUm5GZTBN?=
 =?utf-8?B?YmNpaG8vWjRxelpaMlFrRlBGM08xK2p6ZlVzTE5sUEc1VU4wMWlSL2wvcTBm?=
 =?utf-8?B?WWtkMVZ2c1Mrcnl2YTk5dGdGYUoyNUNycW0vYjhiS2p0SG1tenNSNU9LdGlh?=
 =?utf-8?B?SEhjbkVldjJJM21raDlMUWZVSC93b1R0WWFhUDNkR2N2dFIrbnBSb2VZZWhZ?=
 =?utf-8?B?NVQ2OXExbzdsVktpRmE3R2hDWUdFZXZIbThMYkMzSngveGl2Umx4NjBtT1pQ?=
 =?utf-8?B?R045dGE2ZFpJNEg5ZmlRTG9YUUhLZzMzMHEvMGh0d2YxYkpXTmR3VFhEK1k0?=
 =?utf-8?B?Z1Z6dzVRd2FxSldOS0lPNE9FbGw4TDgxWFRHek0vZ0ZKakZ0KzFlaDl6WlY5?=
 =?utf-8?B?LzAxTU5uNzM0eithMkVCZ3NDMStlWnRVZFJ1ZEhxL1NzdUJmUGN2VGhwYjhO?=
 =?utf-8?B?YllpeWFTU2RDZ0NNSGhrQmJYcGNNUkRJV1I4bGlRek81NURQcW1qdkszT3dq?=
 =?utf-8?B?bGxmM0NBcFk4WGxQVTRJa2tTUGtPT0NwVXRrbHdsOGNEamM0ZEpkbGJDWXBX?=
 =?utf-8?B?OENrYWJZQ3doZTk2TXhaNUcrcVdJbXdmNFhBR2prSWVxZzAxYkhzTVZYWUNZ?=
 =?utf-8?B?NDJWeVNjWlFPd2xzMkNXbGF6QVZDb2ZPZEZ1Z2hEZFVyYkdhUnpIK2VOZ0Zj?=
 =?utf-8?B?NFh3ZkNYa1I4dUNBY0VwNXowaUJVMzlxRVBXSHRYdTBZa3ZhM0hBRVNtOTBG?=
 =?utf-8?B?MnU1SmxRRHVvRTdYbFJaVldiaTZwVXk0b1BZR1dIcnJiNFB6UWN1TmtWMHdu?=
 =?utf-8?B?VTZjSTJmN0k0QkZLOWErY2lnYk1sNnlRcVJadHI2SUhPT0NOeldoUS83ZVVS?=
 =?utf-8?B?WkJ1SDNJMVAzSHdZVHJPc3BYUkZuSjVtVTNvN1RWQnkxaE45U3prOWsrTlZY?=
 =?utf-8?B?Z3JOeFBiL1pSWFVzd0xwVTlzWkd4UWJ2Q3hjWUZlUWYyT2dLeGJhYUhQdG13?=
 =?utf-8?B?T3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4bf269bf-a1c4-4a24-3b90-08db8311aec8
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jul 2023 19:53:37.4575
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LrR1MSKZNv7efwuZS2tJWFTO/hHSpD5eMUHxboYodsl2lmzAGv4aHbBJBNDMAUh/Xu6s5hSBMKWymSnMQvP89NKsotsbBQYK6o/MwSdh+Jk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8343
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/2/2023 8:42 AM, Simon Horman wrote:
> On Thu, Jun 01, 2023 at 10:42:30AM -0700, Amritha Nambiar wrote:
>> After the napi context is initialized, map the napi instance
>> with the queue/queue-set on the corresponding irq line.
>>
>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> 
> Hi Amritha,
> 
> some minor feedback from my side.
> 
> ...
> 
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index 9ee8eb3ef223..ba712119ec85 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -6366,6 +6366,40 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
>>   }
>>   EXPORT_SYMBOL(dev_set_threaded);
>>   
>> +/**
>> + * netif_napi_add_queue - Associate queue with the napi
>> + * @napi: NAPI context
>> + * @queue_index: Index of queue
>> + * @napi_container_type: queue type as RX or TX
> 
> s/@napi_container_type:/@type:/
> 

Will fix.

>> + *
>> + * Add queue with its corresponding napi context
>> + */
>> +int netif_napi_add_queue(struct napi_struct *napi, u16 queue_index,
>> +			 enum napi_container_type type)
>> +{
>> +	struct napi_queue *napi_queue;
>> +
>> +	napi_queue = kzalloc(sizeof(*napi_queue), GFP_KERNEL);
>> +	if (!napi_queue)
>> +		return -ENOMEM;
>> +
>> +	napi_queue->queue_index = queue_index;
>> +
>> +	switch (type) {
>> +	case NAPI_RX_CONTAINER:
>> +		list_add_rcu(&napi_queue->q_list, &napi->napi_rxq_list);
>> +		break;
>> +	case NAPI_TX_CONTAINER:
>> +		list_add_rcu(&napi_queue->q_list, &napi->napi_txq_list);
>> +		break;
>> +	default:
> 
> Perhaps napi_queue is leaked here.
> 

My bad. Will fix in the next version.

>> +		return -EINVAL;
>> +	}
>> +
>> +	return 0;
>> +}
>> +EXPORT_SYMBOL(netif_napi_add_queue);
>> +
>>   void netif_napi_add_weight(struct net_device *dev, struct napi_struct *napi,
>>   			   int (*poll)(struct napi_struct *, int), int weight)
>>   {
>>
>>


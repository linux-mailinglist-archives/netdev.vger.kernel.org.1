Return-Path: <netdev+bounces-22975-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD78376A461
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 00:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0870128144C
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 22:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9D8E1DDF7;
	Mon, 31 Jul 2023 22:57:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2E8A6AAB
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 22:57:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0C51BD8
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 15:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690844231; x=1722380231;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Mxwxh5UCgmylRC15i/XwOOYOIQLkj5giaUliRfTMXrA=;
  b=TuSbnAno4yJCqMxdK1c+9lhrx3EXUOIxx6GEe8pDBhPPwDAiViONC9Jf
   z/SPEhhgpNHM3lekdvp1BgAcn8dB6TYMa4qMG85F81sZZMbHY/V6w3b1Q
   wWpVNAWtY3FN1GX7o+pXlyOGjRfsZ4oNDfu//TfWjAMs/TFMKAZHWDnnw
   tJeR0ESKKJm9gcRx3LuWD9+Dp+eqjLQt9gTT17q1EAh16XUchzJ1pV1/g
   NVInf+vg1SmwkL6SsYWSuTlClsgyE269BJ7PTfu6tVpT+Cf1ozyyShec4
   XUontx9tUVNZow0WCePcfOTg2/GOX3abgdHxNamkdZEOHxzV/7zP6KgHl
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="349442689"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="349442689"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 15:57:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="1059152040"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="1059152040"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga005.fm.intel.com with ESMTP; 31 Jul 2023 15:57:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 15:57:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 15:57:10 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 15:57:10 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.49) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 15:57:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PPKemnZd5/3WGkRuejQe46uu3i2046uAyBVQ0UVvguw35OeewGhEPlp4bKQsQ6LFXaqYsbEZ71IdZhLOnD/HmhFhUEuDVMVfgBpBLm41hNTBje2JriRRI4rwc7hXSbzZ79IUszvyF08NzCBECoN/NzgdBSiue8EM2eJrzcXCtgFjcdfB4twmAkYzGwHkKrK01NGmTQUq5D1qa8x2fCzM787aUzjuoYdjQeA5uGODWDpVoYHrHL1XHL0qX/d+a8gbINJou/bK9ph9puoz3mhCMcamnIYF8z9duZ3qvgE3cfjPpRGsTH2KRcjrKND3zJIqwsScQbIgqob0tc3bf4SY/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r3EX5MxB8+4foRnIeyAufwkzjAHPEa9bdH8+Nr2np+o=;
 b=jxCWjDIscURceBSj7c6mDrZPe3FePv17x+CXheGWAVb+oEfUDIN5ukddst4FEvBbNgllQU6ltjeNlI5BS/PLljRr7zkptyqP+/kjv5o2upDH/+O8q066xaZbmM1LB7AeI6HC9hs4rvdJ6oYxOcJkzsJWov+Nh1CYOccvgwNm3x9A3XfBcqfW1ONu4t2cmZznVVHVpCIiomJAlM7kOornOCGZb1MLKPDeoOOT/aHDg9T1jzNPpmAFMIqLrTsXzSlelTRNU4/aWPxm5bTMyfUWaXl6huP/uQicpvwJJ4ZmzaH5tkRUTmsGvMSDSkLe7rewU9nY5v/6zcYblkshLnx5AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by PH0PR11MB7613.namprd11.prod.outlook.com (2603:10b6:510:285::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 22:57:08 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 22:57:08 +0000
Message-ID: <7a790841-35fc-d649-7659-e0792edabe2e@intel.com>
Date: Mon, 31 Jul 2023 15:57:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next PATCH v1 1/9] net: Introduce new fields for napi and
 queue associations
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
 <169059161688.3736.18170697577939556255.stgit@anambiarhost.jf.intel.com>
 <ZMaZbSvFSKrhOXhV@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <ZMaZbSvFSKrhOXhV@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0008.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::13) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|PH0PR11MB7613:EE_
X-MS-Office365-Filtering-Correlation-Id: aa650004-78ce-4683-8a07-08db921976b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7hgJsGx3GVQdCVndRY1Gn3NKaoMZzxGWzBM/UkxKERS3ubCcr1Ml2PnZOhjj8jR5P0k/ahKJosagfQMxZvPguY1zJkDwMarVNjp7tEFnERLVNvlrjU3B8NxNJsNB3jD6ZIT2s/sZ7gLEDfGWtWiXpOt/JcpTfppDQAt3gLi7R4rkhmGJ4YQdbBn5wMwNfagTUumtQTYspn65qvG21mMUVqWUNGcn0bFtFJclABJ+6aB9thDXo3Ekq6vrDD6Cc7P29Npvvi2GOcD7QDZc20VpZV4b9mvS2QjMcjK98/89fcfzFsLdFj7srKoB9xjuGqWZrbDbLVqaOJcNkHbj1OXxLUpgND8KhNO+JyTcTzzVXa2QnwarPBmZoYrm98HxuB+h2JJyTgsvy9ERsEDyqj1R3xBJgMqc/yRrizjmJUNGS6BZZck0JgZsHQCAJNo3JvDhsIE4DrgYNwW5hc3SgJs3I3BGk70B2EIGVuVpTJArwVSR+YlBjlhCwLx5a8Camoejk75Oi/yT4JRxdoV+KA1NTirclWLipkhJbuErQVMfbHXRSOa5d/b5m98yGgqGULqmdakGj/Nopw5jlzWhZpiAaPFY4zBTgVIZQsd4Dydr80sFUSp/dU2fqoS75FqoiH9u0ScUkizSmaEtP1T2jdzP6g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(39860400002)(346002)(396003)(376002)(136003)(451199021)(6512007)(6486002)(36756003)(2616005)(53546011)(6506007)(26005)(107886003)(186003)(66946007)(66556008)(82960400001)(41300700001)(38100700002)(31696002)(86362001)(66476007)(316002)(5660300002)(6916009)(4326008)(8676002)(8936002)(31686004)(2906002)(6666004)(478600001)(4744005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Uml5bmdIUjcxRmRZVEhmT0lqcWdDbG4zZGJJMUd6aTVTUWg0cXgvWmx6V3Ft?=
 =?utf-8?B?dkVXTG9ONU0xbEhqS0dDL0NvajZRQzViM0RNdkg1L0h5UmFpOFhYUVFXWnhP?=
 =?utf-8?B?RWZmc1A5UHRPdkUxVjgyZ0pyL3orTVlGZ2p3NkpVNXF0TWt3Ykk4STBuamR0?=
 =?utf-8?B?QzNyb1VnOGpYMWVwS0VxRjZlUGFLT25NQzNaQlh0Qy9oTFd1aEVXdnJIaitq?=
 =?utf-8?B?M0h1Tzd5NE9UNk11R1Y0V3NZeDJSVWxKWXluNFA2UWZyY3dncWRseVZuOWNO?=
 =?utf-8?B?M2ZxY1crTVFSNHFXV0U4ZURwZ3lvTitEdmx1eVVpMnJZVUd1c1NOOVArb3px?=
 =?utf-8?B?YVc4L0VzUDFMd3ovTkZ6bDR6UEsyNEk4Wm1aVHM2MHJPVldFYURBREpBYVo5?=
 =?utf-8?B?ekdrMTBuTlNZa25SbVNTUHJqTS9SWXJmUEVLRGdxdlRldEkrUTVQSC9QZ2s0?=
 =?utf-8?B?UndUN1E4OFJFSnR0WitRT3p6TDZGTjhuYTZGd04wTk9iV1o4dVBkV1c2QkxN?=
 =?utf-8?B?UHliNko3eWl6dGdWYVlvb3E5aWU3bWF3UVNDTlBha0JpYzFxSmpxTndsZ2ZO?=
 =?utf-8?B?UVBsQWpTODlqN0xWUm00RVQ5L2FsUjdWUkFmRkpZVmFzNU1sRlFnR1ZZcmxk?=
 =?utf-8?B?enRZRGtKR3p1NTFvYjhEM0xUWTg0NzFuQmdHM1NiaG9ISFV6UVBnbzNoRUgy?=
 =?utf-8?B?MTkrd1puR1lJdHhXUDZRTlNrWUN5ZjZEL2hxcVVib2xEZ2d3SmxZZEhFSnpI?=
 =?utf-8?B?UERwWTdPdlhTbE81cjZTWmJ0QzRZc0g4UUo3V0JPa244czZUMjMvNTBIMGEr?=
 =?utf-8?B?MW82UnF6VU9QSWNuWk1nS01CMElWNWF3QVcyeVdEcW9PNzVaeGRSalBZTmlG?=
 =?utf-8?B?QXlCZXZ0VTdOSW5lSE1GbmxKeWlZbm00UGo1a0tnK1B3L0wrbFIzdFlhUG1X?=
 =?utf-8?B?dW5RS3U1RmFCZmt6OXphcCtvaFNMTVpja3NXbG50bGhaNlNzT3g1SlZ4Nzhk?=
 =?utf-8?B?NkhPWXVGM3hva2lqRkU4NkpYWkMybDBIaGM4ZC8xQzQ3RHpURGQ1RTZWR01J?=
 =?utf-8?B?MzN1UmFWbXU0RDNCZHJVUUc1c3Z6SmhkRm03TkI5dXFBVzduVWo0SENERHRO?=
 =?utf-8?B?Z2lYb3VrNkxmdFZXT1pKVFBibUY3M2I0VEV4TVVQTS8rVXU2RGwzOVZwZnFj?=
 =?utf-8?B?OVhCTDZkNmhPWGN6Y21aUVo1U3dxSUdoZTNmRmtxdnoraE5YdXRKM2tMcS85?=
 =?utf-8?B?c3lDZTRqWS93c2Jrb0Rmczd6NHZlaWl1ZkVoektvVlFyMWY4STlweFMzelVw?=
 =?utf-8?B?SFhzS3pXelJiTXB1TW1Pc1JWc3pOYXpqTEJTYTNWLy96WWs0OXNFUHdJWjNX?=
 =?utf-8?B?eHF0RTViaWRub2haQlNnbG1XZGFiczhTWFdBMWpSeElnVU5rSk1LeUNMT2Ju?=
 =?utf-8?B?Q2pzbFV1aTUvQkdabFRmbkw0QkwwRFJoTk5OQlM3cms3bXd1dE82dXBldGh5?=
 =?utf-8?B?QVU2NEpHQWFVRit2N1lHUW43TGMrbmZrYUlEMDBvRGxUc0Fvc0VEcVBnZXlB?=
 =?utf-8?B?OU12bm1hZFJGZXBkZzR5Z1hQTWJ3R3hsQk1wWGVKcXZ4NngydUZzOXJEZUZK?=
 =?utf-8?B?M3Qza3dPMzNoODErTnhoYmVaTnRlOHpDdzhmdWFEWW1TbU9sblVuY25oL2VT?=
 =?utf-8?B?NU5jNTlHaGhZek1vS3ZTbUJYSk9lempXeHlkS0FOSytRdWlucC9aZWtJRzBJ?=
 =?utf-8?B?RW5OQ3lTTEt1VWJZTVZHV2s0V3pyZEl3VHRSNkFKdXRNSXM1eU96eVBRUE5D?=
 =?utf-8?B?d2JITzdMWmxKaVRJZ2tFUk5uamtpL1dSMnovcERYZFlIU2hLa2VnSDVGWmlI?=
 =?utf-8?B?S3RjOXIveTRQMXhVSUpkNWNNK0ZNWDZpZ25CWXNidlNDWDJ6S3NtRzJGZG54?=
 =?utf-8?B?V282QVVIbjZXTnU3SS9SS3hLbVErRjJNNmN0RzVUY0V5S0dDNENPOU5CVy85?=
 =?utf-8?B?SkJBSG9jV0NQYnlFMEpZNkRQRG9vZ0doakJtWVYraHZOWlhmT2Z2SXdyZE52?=
 =?utf-8?B?czg0NzI0NkY3dUZtYk54ZHVVbjVLTUpBZ0tDNGRwcXVpQ1NLL3NZTDV5NzVK?=
 =?utf-8?B?cHl5NE83MjI4YTJ2VnkyU2lROG1yUVBiYUlnbkpqWXdUWGZUNzJUNXJLc0hD?=
 =?utf-8?B?bUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: aa650004-78ce-4683-8a07-08db921976b2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 22:57:07.2989
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RY60O/gbBjeM9wwk3/LAqbzh4cOQK5yV9MV/d6uICic1jlxeWfL7dkJgyf49gP24Sow+JYuljOdIZ22FEX+8mM8lLUz+sXnbVdOGamgIULo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB7613
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/30/2023 10:10 AM, Simon Horman wrote:
> On Fri, Jul 28, 2023 at 05:46:56PM -0700, Amritha Nambiar wrote:
> 
> ...
> 
>> diff --git a/net/core/dev.c b/net/core/dev.c
>> index b58674774a57..875023ab614c 100644
>> --- a/net/core/dev.c
>> +++ b/net/core/dev.c
>> @@ -6389,6 +6389,42 @@ int dev_set_threaded(struct net_device *dev, bool threaded)
>>   }
>>   EXPORT_SYMBOL(dev_set_threaded);
>>   
>> +/**
>> + * netif_napi_add_queue - Associate queue with the napi
>> + * @napi: NAPI context
>> + * @queue_index: Index of queue
>> + * @queue_type: queue type as RX or TX
> 
> Hi Arithma,
> 
> a minor nit from my side: @queue_type -> @type

Will fix in the next version. Thanks.

> 
>> + *
>> + * Add queue with its corresponding napi context
>> + */
>> +int netif_napi_add_queue(struct napi_struct *napi, unsigned int queue_index,
>> +			 enum queue_type type)
>> +{
> 
> ...
> 


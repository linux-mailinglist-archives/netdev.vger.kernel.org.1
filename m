Return-Path: <netdev+bounces-30144-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1A7C786356
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 00:23:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D15231C20D48
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 22:23:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BABB200B8;
	Wed, 23 Aug 2023 22:23:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F69FBE7
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 22:23:53 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFE0310E4
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 15:23:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692829425; x=1724365425;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8J6NIgA/Hz2Aq6C39Rs8quFhuCC8BI14bvBU+ITueEc=;
  b=UDLudshsg18uWP2QkRtFcWBI+vCjMc8jVazVggvqlQbqYN+WLfg1i0w9
   daGCQ3WQKd/jEkH7pdkkJ3K4Ofuskjwmx1Zk8CRt2XKH8Br+9Pq+Bsgcz
   J9ABwUeKKkBWP8j6zRLKJcISZkclT0ttkcmlV0YfUtMQRg/3OY8FuL5HS
   kLJoR/BjQZLW7sb5cuVoDnWL5HyVOwJzG/hYXt7tEKYRIqX3Z6r9yI12/
   ByDvDgNZKGYoMerxlISJRs1fMKIM8FOWH/AS7exb6PSiRY6VK3wVbwFLt
   JaD4DVcHONVVUk0yDNLfKh7ZJJXPut/meuhjgzCk+Jl0AS1ZzVlWRcS7n
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="378039197"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="378039197"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 15:23:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="686629423"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="686629423"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 23 Aug 2023 15:23:45 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 15:23:44 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 15:23:44 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 15:23:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 15:23:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PGsn7AOXbpPzUna8kk8x5o0pajbquZ8dAxjKbO91s/1Q5agLQR6RN/Ka1HfzWXoQHFHDoFc2nywVEYrPckJgP0V7E4LUljaOvsLj3D25xESHiWNYwkRp8MTzt9RPnAHrcwpJTu3sWki5CvjlqXFnjPKGpbE63UpxNSpdDPZ1oXQhfsLoI2OCnw26qzjtJXBFwtqPYoHE5NeqfG0yzluoM3UK3lMRzsWrvIHQbPnUhSuptRm2iAI8NhhtklDtmAa4xPRsNPVqbBBbL9lNraIumN9ebXEVdaowhDuvi0GVdl5o+a8gamp/sFRB62tTj8s2wEbU9pZ+VJp/CBtT9l9sKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gRPCvve/nIpDsJ62L0J8g3NJgnctNtIchOZBQvNJ/NY=;
 b=T6HQFhZlKV4h2ePaVVWmWUPDAYm3j2RKehikaIdz1Zp+RML1hWH/m7V3U6E+4ZiCPGF2A6qmshX1w1uHWlcDAfGen0w9BdRmbnkP0LsrpTcnJRO4NqEQPa36BqoFi2I6HBGqnfYUAr+VjyuDFrJhzVUUSOs7QorUDBgniTWioLGIIHauoZk/qYUoz/KmGcV6Oo6odvTglxnyoL62GhBUde6wmF1Sp5y+TxOS7zhjz2QuuOqp7n7WDKHP3+wbFzyrNZpd6WzHgXPer7HvxRhWxVmsBvIJO/fLRAOpElwzln58+pLZY5OdBLxsJHewvO121q7SYmAPEEZ0Fa+X1RVgrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by SA1PR11MB6990.namprd11.prod.outlook.com (2603:10b6:806:2b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 22:23:41 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::a184:2cd6:51a5:448f]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::a184:2cd6:51a5:448f%7]) with mapi id 15.20.6699.025; Wed, 23 Aug 2023
 22:23:41 +0000
Message-ID: <c1707845-af5b-7967-514a-102818afc6da@intel.com>
Date: Wed, 23 Aug 2023 15:23:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v3 2/5] ice: configure FW logging
To: Leon Romanovsky <leon@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, <jacob.e.keller@intel.com>,
	<horms@kernel.org>, Pucha Himasekhar Reddy
	<himasekharx.reddy.pucha@intel.com>
References: <20230815165750.2789609-1-anthony.l.nguyen@intel.com>
 <20230815165750.2789609-3-anthony.l.nguyen@intel.com>
 <20230815183854.GU22185@unreal>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <20230815183854.GU22185@unreal>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR07CA0031.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::44) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|SA1PR11MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 3293a065-e0f2-46da-dbe5-08dba4279ada
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: mw7om+8PPZBKr4xWFCQ8Q/fDp/6v2ReFmKE1lCAinrD+SZVHYbfzzA9x8SIU3ow4IcfAsoW679IuX5pxIaFGbkiHebz2LQGEaFSu2/PbRY/Xjbz2/NF7srbKaVQtwUYDTZtoMowKIN9blWjYUv3x1o2WBvpAzxIM2yNQUDZ1gOgsMKB+juV3HSn90UimZ/5HtkADXk6nGjxYuKQqTAvAw0DdoeDLeof1RfwzdamzFdqBQ+5yu6ZRnN1eCalDLk3uaiS1DKMUtYpHQc62kkVfSHAfbw5CoYMegnMSaU75wFGHFJ2mU0xSHp0yxxpu8ND/0EtygV4xjrwZG8R4mEF0MoeY6INuZblEicPKsGmOwadJaEcuH58uzDcNjJxLGG4dCNNheTKdxKNEDf9/TPm+zk5DuKI2sx1/9yH1VIiNACJuu1hziGWDNZiXA+S2SCCkEBsu9uvMkd9COOhc0thrKdQysxRCY/ox2WuEsjFYh+3m3xyhu6NFQ7O8eBY+aWBQiU59+PCeYXYXENjpWER3nK8LqLBxJXPaEvEw9LtAnmzVPc6ky7ZhbGyy0A5nFpqFA7ka2pKM3VwYgpe+f70yd5lM/vYfV5GuHU18M6dqiQ2oPouEIrwB/3HV1rsabWMc7PvqOiuuLKI89i6OIzItFQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(1800799009)(186009)(451199024)(6666004)(53546011)(2616005)(6486002)(6506007)(107886003)(6512007)(86362001)(66556008)(31696002)(5660300002)(4326008)(2906002)(110136005)(38100700002)(82960400001)(6636002)(8676002)(66946007)(8936002)(66476007)(36756003)(41300700001)(316002)(478600001)(83380400001)(31686004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ekEyY051a09oSkhSb2NIQ2lwdzRMZXI1NXFjUi90aWtqQWMvSVhBbzcyR1ZT?=
 =?utf-8?B?K3dBWFVFd3hGQlF5VzJzVUEzeFF0MUQwelJjamxvMTRiSXhsOW8wUjU1TCsx?=
 =?utf-8?B?TGxFR1hKaXhWaWJyMzZabThTckltUjErODFyK1NrZmdkTzlyVFpCNCs0bkIv?=
 =?utf-8?B?VlY4RDNlclhUT1VPOWtQMXF6djJkV3NWS3lvZEMxN3B1WnYra0tkdkJYb2Fv?=
 =?utf-8?B?djQreGVZdTVhQ0x1L1ZRRmxnQUNseTdYK3kzdWIwV0dkVnJLZUh3ZW9rOEpa?=
 =?utf-8?B?cGU2T243ZDRheDJiODdFbE0zTyt3ZFp0S21NWWlidWNSaCtYcHNQaFIxdjk1?=
 =?utf-8?B?blFzVGRGSEpZMno3SldHRUNleXJZb0JCM1dQNVFQanFBdVdKQUtDenpXMDBR?=
 =?utf-8?B?VWR5OXNkNE5hWG5kN011Q3hWQjMxQVFCZE9GYW9leXAxY0NIb2ZmZDFRLzJy?=
 =?utf-8?B?MzltbzB4SG5VSHplVE9MS1k4d2FPNVlRS3RFUjNQY1pvZVZZQ3FpV0ZpYnRi?=
 =?utf-8?B?KzF4dkszcEZKVG5pcFJLOHEyTjJzTklTQ0pHWUxLNEtCZ21QajlKelNyTCt5?=
 =?utf-8?B?MGZSeXYxV20xdGZwOXc2Y0dDbHlmUGVvZVJCYTZwMGE3aCtQNVp1YVF1bUI5?=
 =?utf-8?B?c2I2WEhkOTViekk5YlRhQzhxcUZKSi9JTkhNUHVBenpra0JhdGxBSDRkM2pv?=
 =?utf-8?B?WWNFU0dDRWo3cmRDTkpCNjEyOVhONmp2Y0x0OEUvM3huclM1aStYTTFaak82?=
 =?utf-8?B?UmI1TXdkNjFORkdjcjRSMkRiMGlGNzc0K1ZKcVJGeWIzZ1NrWWIybktlMEU4?=
 =?utf-8?B?dDdQZzZKbE0zaUpGd05meU9WN29md2g5aXFibnpHelVZQVpvVTJrVTF1aUlx?=
 =?utf-8?B?Q2VmOTd5eTNkQnhwRFhramdWaWFUSTR3UG91Z1ZtWlZVVDVMQUdUamhINUdi?=
 =?utf-8?B?WWlZd1h6UGllTzc2MEpyNGJHSFdvWDRHcDYyM2RVMjhXUTdJU1creE1LbTFj?=
 =?utf-8?B?eDI5d1NKM3gwUHhrQlZWaXlMVXdEY21SZzFVSGpmemlQRW5DOTB3SUtnQlBj?=
 =?utf-8?B?Zm5CNkh2L0FXMmN4Q0E4S2RuRVltQXVBeUhJclJKQkF0QjM2NXBPa2UyVnFX?=
 =?utf-8?B?Ukl5Q05CZDI5aUpETzNPejcvbURNM1hHRGw4NGdRNUJla04xTUlyVUJoeFY1?=
 =?utf-8?B?OFcwbFk3SG51ekdXTExkdlhGYy9Kd01ldXE2ODV6K2ZiNEk5bnk1aXlYTVBW?=
 =?utf-8?B?dG96c2tta2QyUHN1K3NLUDQxWTVsYnROSEZBVjBHMHFUbGNrQnAzNjB4OGIz?=
 =?utf-8?B?L3JIa1o1ZExYRlBIbzZtbDI0bStKUnc0UWRnYlN0aEwyQmdzYTg5T1lBWDRr?=
 =?utf-8?B?Q3orcm92bml6Vzh2ODhhWjhvaXBWRXhNTlBESzBPYlhDMHNRekRlM0dRK3Iy?=
 =?utf-8?B?VkdDU3ZYZU9TdWRZRUt6SUhCeHkrTXBDNmNaVmt0RElXMVlGa0dld2hRSWRU?=
 =?utf-8?B?Sk54b0RkUkhlN2RHbEtUdlZBY2VsTUlRVnhET0VzSHZPMnMzSFJ1T1Nzck9G?=
 =?utf-8?B?UTltcVludk12SzAxNjIvaFdRS242OElMT1FtVVpyNjhIdlNFcGZWWE1QbEpt?=
 =?utf-8?B?dTROVzZzdzJMOTRBWE5BSXhTRkJNb3IyRytYRUxEeG11Z3ZJU2hVem9QTVJX?=
 =?utf-8?B?Qy9hbmlIY0V3Q2NIWjNvTkRsTm1BdG81b1pqenRGaTRyRmM5UGNETzVtb0N4?=
 =?utf-8?B?SEUzajI4MDRyeHEzdzlPdFg1ems5M24ySXVDSS8zV1ZIQ1BxcDdsUHpwaWE4?=
 =?utf-8?B?RC84Tzl3MEVZbk1lNStKVnh1elAwZ2FmV3pQRlRwOGhTZXZnUU0xRkljekNG?=
 =?utf-8?B?Q3lIZDdUTG9GbnEyT3QrQkZ3V09zNUVpcUczTEZaZEFsbEtwQ3B2QnpQRUpK?=
 =?utf-8?B?ZEllUVVtMEpCM0RBcDlDTThSa3dxaHIrNGdWbjVUZ2dLQWF2NENjSm1ERThD?=
 =?utf-8?B?eUl5YjZ4QUlxbFB1Y3F6bk12d0tRNlF6SG5COGxNZ1FYYjZ5TDcrMFNJSUVx?=
 =?utf-8?B?UTd0T2dHTmJYUmZOTHhJUmp5cHFLcmM5RHZqa0FJTFlTR0Zzd1R3cElqdHZF?=
 =?utf-8?B?N2FWUTdUNkd4TmkxRXRHRHBYSnU0L2x1S3FxT2RxT3AzVlJ6VEpiTXhUVHpn?=
 =?utf-8?B?OFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3293a065-e0f2-46da-dbe5-08dba4279ada
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 22:23:41.3685
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iPQA/ztSXjNsHbALcC8Hlh5cU6GMzFaFylUkRMP+8IZADyQjAXnxruM0XKNNhT31ICVjJSE9CzguGX1Vxf10GwOBekl4irPQ9R6eTTbx00A=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6990
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/15/2023 11:38 AM, Leon Romanovsky wrote:
> On Tue, Aug 15, 2023 at 09:57:47AM -0700, Tony Nguyen wrote:
>> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>>
>> Users want the ability to debug FW issues by retrieving the
>> FW logs from the E8xx devices. Use debugfs to allow the user to
>> read/write the FW log configuration by adding a 'fwlog/modules' file.
>> Reading the file will show either the currently running configuration or
>> the next configuration (if the user has changed the configuration).
>> Writing to the file will update the configuration, but NOT enable the
>> configuration (that is a separate command).
>>
>> To see the status of FW logging then read the 'fwlog/modules' file like
>> this:
>>
>> cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>>
>> To change the configuration of FW logging then write to the 'fwlog/modules'
>> file like this:
>>
>> echo DCB NORMAL > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>>
>> The format to change the configuration is
>>
>> echo <fwlog_module> <fwlog_level> > /sys/kernel/debug/ice/<pci device
> 
> This line is truncated, it is not clear where you are writing.

Fixed

> And more general question, a long time ago, netdev had a policy of
> not-allowing writing to debugfs, was it changed?
> 
>>
>> where
>>
>> * fwlog_level is a name as described below. Each level includes the
>>    messages from the previous/lower level
>>
>>        * NONE
>>        *	ERROR
>>        *	WARNING
>>        *	NORMAL
>>        *	VERBOSE
>>
>> * fwlog_event is a name that represents the module to receive events for.
>>    The module names are
>>
>>        *	GENERAL
>>        *	CTRL
>>        *	LINK
>>        *	LINK_TOPO
>>        *	DNL
>>        *	I2C
>>        *	SDP
>>        *	MDIO
>>        *	ADMINQ
>>        *	HDMA
>>        *	LLDP
>>        *	DCBX
>>        *	DCB
>>        *	XLR
>>        *	NVM
>>        *	AUTH
>>        *	VPD
>>        *	IOSF
>>        *	PARSER
>>        *	SW
>>        *	SCHEDULER
>>        *	TXQ
>>        *	RSVD
>>        *	POST
>>        *	WATCHDOG
>>        *	TASK_DISPATCH
>>        *	MNG
>>        *	SYNCE
>>        *	HEALTH
>>        *	TSDRV
>>        *	PFREG
>>        *	MDLVER
>>        *	ALL
>>
>> The name ALL is special and specifies setting all of the modules to the
>> specified fwlog_level.
>>
>> If the NVM supports FW logging then the file 'fwlog' will be created
>> under the PCI device ID for the ice driver. If the file does not exist
>> then either the NVM doesn't support FW logging or debugfs is not enabled
>> on the system.
>>
>> In addition to configuring the modules, the user can also configure the
>> number of log messages (resolution) to include in a single Admin Receive
>> Queue (ARQ) event.The range is 1-128 (1 means push every log message, 128
>> means push only when the max AQ command buffer is full). The suggested
>> value is 10.
>>
>> To see/change the resolution the user can read/write the
>> 'fwlog/resolution' file. An example changing the value to 50 is
>>
>> echo 50 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/resolution
>>
>> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>> Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>   drivers/net/ethernet/intel/ice/Makefile       |   4 +-
>>   drivers/net/ethernet/intel/ice/ice.h          |  18 +
>>   .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  80 ++++
>>   drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
>>   drivers/net/ethernet/intel/ice/ice_debugfs.c  | 450 ++++++++++++++++++
>>   drivers/net/ethernet/intel/ice/ice_fwlog.c    | 231 +++++++++
>>   drivers/net/ethernet/intel/ice/ice_fwlog.h    |  55 +++
>>   drivers/net/ethernet/intel/ice/ice_main.c     |  21 +
>>   drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
>>   9 files changed, 867 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/net/ethernet/intel/ice/ice_debugfs.c
>>   create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
>>   create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h
>>
>> diff --git a/drivers/net/ethernet/intel/ice/Makefile b/drivers/net/ethernet/intel/ice/Makefile
>> index 960277d78e09..d43a59e5f8ee 100644
>> --- a/drivers/net/ethernet/intel/ice/Makefile
>> +++ b/drivers/net/ethernet/intel/ice/Makefile
>> @@ -34,7 +34,8 @@ ice-y := ice_main.o	\
>>   	 ice_lag.o	\
>>   	 ice_ethtool.o  \
>>   	 ice_repr.o	\
>> -	 ice_tc_lib.o
>> +	 ice_tc_lib.o	\
>> +	 ice_fwlog.o
>>   ice-$(CONFIG_PCI_IOV) +=	\
>>   	ice_sriov.o		\
>>   	ice_virtchnl.o		\
>> @@ -49,3 +50,4 @@ ice-$(CONFIG_RFS_ACCEL) += ice_arfs.o
>>   ice-$(CONFIG_XDP_SOCKETS) += ice_xsk.o
>>   ice-$(CONFIG_ICE_SWITCHDEV) += ice_eswitch.o ice_eswitch_br.o
>>   ice-$(CONFIG_GNSS) += ice_gnss.o
>> +ice-$(CONFIG_DEBUG_FS) += ice_debugfs.o
>> diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
>> index 5ac0ad12f9f1..e6dd9f6f9eee 100644
>> --- a/drivers/net/ethernet/intel/ice/ice.h
>> +++ b/drivers/net/ethernet/intel/ice/ice.h
>> @@ -556,6 +556,8 @@ struct ice_pf {
>>   	struct ice_vsi_stats **vsi_stats;
>>   	struct ice_sw *first_sw;	/* first switch created by firmware */
>>   	u16 eswitch_mode;		/* current mode of eswitch */
>> +	struct dentry *ice_debugfs_pf;
>> +	struct dentry *ice_debugfs_pf_fwlog;
>>   	struct ice_vfs vfs;
>>   	DECLARE_BITMAP(features, ICE_F_MAX);
>>   	DECLARE_BITMAP(state, ICE_STATE_NBITS);
>> @@ -861,6 +863,22 @@ static inline bool ice_is_adq_active(struct ice_pf *pf)
>>   	return false;
>>   }
>>   
>> +#ifdef CONFIG_DEBUG_FS
> 
> There is no need in this CONFIG_DEBUG_FS and code should be written
> without debugfs stubs.
> 

Fixed

>> +void ice_debugfs_fwlog_init(struct ice_pf *pf);
>> +void ice_debugfs_init(void);
>> +void ice_debugfs_exit(void);
>> +void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module);
>> +#else
>> +static inline void ice_debugfs_fwlog_init(struct ice_pf *pf) { }
>> +static inline void ice_debugfs_init(void) { }
>> +static inline void ice_debugfs_exit(void) { }
>> +static void
>> +ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int module)
>> +{
>> +	return -EOPNOTSUPP;
>> +}
>> +#endif /* CONFIG_DEBUG_FS */
> 
> Thanks



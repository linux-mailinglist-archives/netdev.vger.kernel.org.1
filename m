Return-Path: <netdev+bounces-27395-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31EE077BCE9
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 17:25:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF3E42810EC
	for <lists+netdev@lfdr.de>; Mon, 14 Aug 2023 15:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B539C2D3;
	Mon, 14 Aug 2023 15:24:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 791A5C2C6
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 15:24:51 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A0D10CC
	for <netdev@vger.kernel.org>; Mon, 14 Aug 2023 08:24:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692026690; x=1723562690;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=h9PRaB3DCTD/TdYRIwP8V7Rhi+9kUQsUN31DwYSoBxE=;
  b=kWL7dmEK21gwkO5jBedqd+jynhuSFhHShNMrifHd/ptG9z4jK1FESP/S
   OxLkMXLR/v7Nk2OAaSRcorEdmyoF4K4Im/YSl2D4v8BJ5jh1q7KdXEr7a
   r1gzEGlDidqqygoUX5fbktEtuOV7/W1uJygfiYDyLNM9/xVbmWgGODqsY
   6mjbIMAs6V02DhsFAXrh/cRSe5z9JlYw2JIwltAxgRuRcpxgagE/xpEQH
   jT+923kL27ZqYoE3qqHVTCi+PVdKfeIh3RtaMTNKCTNv/PKK/gduh1bsG
   mhDMJjyg5yib16cOAZ5TCEAwnBvMhnnDGko5n2zHgmceXaEdJDHWv1E9o
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="403047182"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="403047182"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 08:24:50 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="727038351"
X-IronPort-AV: E=Sophos;i="6.01,173,1684825200"; 
   d="scan'208";a="727038351"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga007.jf.intel.com with ESMTP; 14 Aug 2023 08:24:48 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 14 Aug 2023 08:24:48 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 14 Aug 2023 08:24:48 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.45) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 14 Aug 2023 08:24:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F6OTkQmqLcyZV/a0sMi1PCuX+8i63IjMiRRuDvAWxr0noL/qdLa0xSJrwuCqlM5/iZbKN10hbHwE7y57amGeyDUR0iweTHAWYlnELX9A7Oz9zy5uOCjplQXaIVPNrnP9j0yDNmYE/nxl5Q/CP4FPbeXVHC/Zt6XDbYq5FljG6LZvjEjfUWn7FEx6EXD5VAUNxFxW1hQh6r54rNwFNovG+CHEf8KMAi2McaYzyQ0fHCjpcKsCAArZIgzeI+WDdZrw9+m+QMgybrF8YBgiIENdPVSHP5I89mdMq8Avjwb8yaOTI+3ClQlC+G9BAyq6bH4Zroqi6eIJim1SWbz0m8KeVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Qb92FGJzFSYvPHayau6RP8qNr85k6mOM+Yls6OcDA70=;
 b=a854iPVehQZpFe60S4I9O0BlbOh0NyjfGVUxZrkPW9RxctMUPUGpdWrbQCXdAC1UFcpvYKRTgdPGeeg/tRhTDvpWSQxm2d88VcACT+ATygKqHn4Drowx9CKCm1rFasdb4hdW8L0a9I2FZZJluR5QIovbn+83GaLt8pePP+5vumru8HA2GCuwLXIxyuAZb4rKKs96BDEXOlPkRu0FcljMmH1CboLQuYYMbAfZGUHXQeq0dB7ofXBAOMeiYQ2bKf4b5e/f4mZm8XS3+Pp767TNmTHjUZW1bNTYFBgD8APK9iPryJWu73FJWrYKb65n27nV0Pl2n15Z5XbCR+bRJ9XMDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by CYYPR11MB8405.namprd11.prod.outlook.com (2603:10b6:930:c6::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.19; Mon, 14 Aug
 2023 15:24:43 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::a184:2cd6:51a5:448f]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::a184:2cd6:51a5:448f%7]) with mapi id 15.20.6678.025; Mon, 14 Aug 2023
 15:24:43 +0000
Message-ID: <d1a39dd8-035d-8c1b-c2c2-b7ca28c95fae@intel.com>
Date: Mon, 14 Aug 2023 08:24:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next v2 2/5] ice: configure FW logging
To: Simon Horman <horms@kernel.org>, Tony Nguyen <anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, <jacob.e.keller@intel.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
References: <20230810170109.1963832-1-anthony.l.nguyen@intel.com>
 <20230810170109.1963832-3-anthony.l.nguyen@intel.com>
 <ZNYH705yA5qGxnvJ@vergenet.net>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <ZNYH705yA5qGxnvJ@vergenet.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0022.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::35) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|CYYPR11MB8405:EE_
X-MS-Office365-Filtering-Correlation-Id: 56683c5a-2581-43ad-0579-08db9cda9587
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9WlMe+tN1lPLbFTrBtRoqbTxkJD4c3819u3bjY3WwTprN3bCsPQwsKxOu9gx1mu6o59tylgbJgLOZ5qEYPbHYEYeOntGvbq3lFBxUDqTLnET6pWgNt8qoLS5qa7olzNkHPrATNSK42iTnEOdmlHIUK6lA5ZF+NMX1DGysutgj9ejUqpQ3fgo9Pmr96d2Ib0v/d7qgB3SEoxKKrizg9onuuupVjjbtGhZjmrWElRmj6ZgLE8Uqe/rHklc29QPqJEVyRs2tD6YdF2cpX0puLG7mERHE6sIIKrmXJ7JNdl71HRxvs9g6KIXpEyHTy8VaK3GSyvRUsnJ5Fc2jekCVV0L6vufyarvCTmX/fKQ0ceQBXbezDgbvpF8YtIzbvl+JfRzByarRfl4yai1Md1QsxoYWAMx+rWDZwpqSAIMD9knKwNIqErqsFD7roCjg2msQ2H/w3fPHxXxLRYpNcTVewu4DzbQGV99ejfhGuDV2GZ+TktAESzlzbhwCOIIzB7VmmO/419mBYZ/QcOCSOTTtZUwaGAfAHCMlvIJ4NsTWKcJ0vj81Uvg2eIAtR6/9kQ1cPmmbmtunbGOWxD1CBtZrrWo6e/p/hMAYFj38vjmPM9O8L3Oxs2B0SOoPRycpBTFMEjn860BiJOOK8wepPrkJ4jGuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(376002)(346002)(39860400002)(396003)(186006)(451199021)(1800799006)(6506007)(6512007)(4326008)(107886003)(41300700001)(2616005)(6486002)(82960400001)(6636002)(53546011)(66556008)(316002)(66476007)(5660300002)(66946007)(110136005)(26005)(38100700002)(478600001)(31696002)(83380400001)(36756003)(2906002)(8676002)(8936002)(31686004)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UndhMFlsVlJnMGl6Vmlzekt0S2Y0K2NMRkVTNkN6bGhXWHByY2I5YWRBdHYw?=
 =?utf-8?B?R2h3aEdNTk4weDJGRDNSZDU0bUlzY1hsRGtsTllLT3RHMko4cGJYcFUzWjZy?=
 =?utf-8?B?V2lqb0ZIYmIwR1ozalM5V3QvMXl4bVBobHZHTFZKMTU5U1habWlPeXVpbk9l?=
 =?utf-8?B?ZlJVYlFGQnJMNGxEcWpmQ3BPZDdmcWEvOGJlOGc1RHdVcUtBU1NCaHZKMmJF?=
 =?utf-8?B?dkxSaFZJSGNUdm1hQ1lncmpici92Vm1PSkEra09GQmtkMU1lMFNZbnkwMFdY?=
 =?utf-8?B?bzNSUG9lcXpkM09Nak5XVGtJaXFsQ1VGbEVmR2c0ZDZQRWFuMU40SDFJTFc4?=
 =?utf-8?B?M2I0QXRoTnBQc0ZTb2Nia3RXZjkzSzRTTVN2THJiL3dIaFRxN21QN3FBRk1n?=
 =?utf-8?B?Wm5QWXBrSy81TzVoMWZxNXhuNFd1RTQ1RmtQNTJOTk9Nc3prSm01aTdNTTgz?=
 =?utf-8?B?ZkhZbVcwbm1qaDdmbkZrS1ZhQzFNOUZ3bitaZEN3dUo1UWZGQnRkMXhDa09T?=
 =?utf-8?B?OENjWGkvb3htNEVpUVJnTjNDWUdrMDBaRTlYWHU1eUJBcTVNL2syUE1GdkVz?=
 =?utf-8?B?cmJxY2JvTVdJMUpLVGozbTNUYVNXaXlBUlpMSmdiemxCTlgzdnIyMCszWTFW?=
 =?utf-8?B?QTVDTUVyaHZQckc3bGtHNzIzbjEvaU0vSGdWSVRYNCtWVDVwSHh5OS9uMnls?=
 =?utf-8?B?YzQyVm13VGFLRXdCbnB5MHNrQlAzOUR2WkRIdEN0TjV2UkIwR3Y0N2s5bEZO?=
 =?utf-8?B?NVY1TmhxY2c0MGtwS3AzM252c2tpbUQzbFFpYTlHZWhCSUIrTElrTFEvMk9C?=
 =?utf-8?B?TXBZQWVXTVRURXQ5YWhHQzJDNHdYSDgxR3k4Y3pINFRZdGFSY09qOVI3WFJz?=
 =?utf-8?B?RXhsYlU5c09vQlpTRTF6cmUrWWpzdEZtMXRTOTJaM0FiTTlNTGVLVElQd3Z3?=
 =?utf-8?B?aUZ2dGN4Mmx3OEVSclBpZFNCM1Z4b2I4dEZwSHRncUdxYWxhc2FrR3pjbmVQ?=
 =?utf-8?B?S0cydGtraEgxZUlxMGJoVEVxd01NYTc5UGhhKzZxdURwcDRrSHpER1FjTzJu?=
 =?utf-8?B?amswVmZjdStua0pRTjZ5VlRKVTdrZEI0VGU2dXBVay9PTDFMREdMVzZvd2dG?=
 =?utf-8?B?Ni8wclhaY3Y1NXVxajVtQ0ZnbnNQZFFpNENTdkFhdFI3M2xPajUxR3FKQWtv?=
 =?utf-8?B?VHIzdnphYmRtVFhsSWw3dmFnQmVEblZpM0pFMWM3emxsL3lBdkZOWFI4d29h?=
 =?utf-8?B?dlc4UDhBS0NZV25jTUphYXd0V09FRVZGR1dwUGtKN2VhYkpBaGxIM2loeUM4?=
 =?utf-8?B?OW5LbTRVcTRrV1pjenl0QUltcHJndFJ4Ty8zbFg2MlBMck5PeENoNXRUR2po?=
 =?utf-8?B?ZDgvMVR2S0lYRElHTnM2cFNHT2RGMjVaWkVXd0dzMkI2NWsvdTR1b2dxOXUv?=
 =?utf-8?B?WGcwcHlrUUsvSlYxQ2p6K1BNb2JBaHdnckI0dXQ5MUo2QkpTaC93VkxPbU1J?=
 =?utf-8?B?MzJYd0hVdDl0VVJkemdldTB1OG40bWhScmIyTnVWZWdqUmdNb3FWb3FqcDM2?=
 =?utf-8?B?MTdwdENnSlM5UTIzWHZKWkJMWjhtRXkydEx1N21za2tFTTQ1KzdPT2pQSWxa?=
 =?utf-8?B?Ri94NWZWQk8xdlVVMjFNNnhveDl6UWRuK0NBQ2dTREhMdVo0RkV0MGFjWTJR?=
 =?utf-8?B?cXcwUThJK0tpdU9KaWZLU0FzVTFneU5wRHhDZ3FhQ3E0YlRMRFB2bEhEOTF6?=
 =?utf-8?B?WTl5QTF0QTFacCtUNk55UTNqQUZ1azFvZ0xXSVhIdS9WaEhmQ0VveXdVV0xz?=
 =?utf-8?B?aG0zK290MU1laEMwaFRXaVhFZENzL0JKLzA5SEhNQXh6ZVNUZ0o5T3FaSitz?=
 =?utf-8?B?Y25GeHhsd2tiUzNzV245c002WWVyS0t3YVFjVHM2NldwUjJmMnFJdjlDb3dT?=
 =?utf-8?B?ZVNiV0pFVVdtVU9pblpiNm9MdDlCeGNZdUY4OXlxeXpSVWQ1NHRlcWZYSXRE?=
 =?utf-8?B?RGNKSXBBNENkTGttNVJnOU80Wm5uWlk3VUpicCszN3hsaWhkdjFKRUNQODJQ?=
 =?utf-8?B?M1NkWEhLTlQvZkRyem16NnYyUW5mcHlPWXltMmttOWZvUW8zUndvQ1hZb0xW?=
 =?utf-8?B?cGdrc0JkNFh0RllhT3A0dFh6SzFRZjBZYWZOdzFjaXlxdWthSHY0d1h3WFFq?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 56683c5a-2581-43ad-0579-08db9cda9587
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2023 15:24:43.0627
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VtykgiIAZox+ymaf30VKKIHcNZ743Yw1OAITfhbWsJKlLzHA7s00tZXKZlGJDwE1+FY0Cf0v8r8B3dAY7QKGSCkVy3edpvBCn5eo0mCBGLs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR11MB8405
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/11/2023 3:05 AM, Simon Horman wrote:
> On Thu, Aug 10, 2023 at 10:01:06AM -0700, Tony Nguyen wrote:
>> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>>
>> Users want the ability to debug FW issues by retrieving the
>> FW logs from the E8xx devices. Use debugfs to allow the user to
>> read/write the FW log configuration by adding a 'fwlog/modules' file.
>> Reading the file will show either the currently running configuration or
>> the next configuration (if the user has changed the configuration).
>> Writing to the file will update the configuration, but NOT enable the
>> configuration (that is a separate command).
> 
> ...
> 
>> @@ -5635,10 +5653,14 @@ static int __init ice_module_init(void)
>>   		goto err_dest_wq;
>>   	}
>>   
>> +	ice_debugfs_init();
>> +
>>   	status = pci_register_driver(&ice_driver);
>>   	if (status) {
>>   		pr_err("failed to register PCI driver, err %d\n", status);
>>   		goto err_dest_lag_wq;
>> +		destroy_workqueue(ice_wq);
>> +		ice_debugfs_exit();
> 
> Hi Paul and Tony,
> 
> this new code seems to be unreachable.
> Should it go before the goto statement?
> 

Good catch! This has been fixed in Tony's tree

Paul

>>   	}
>>   
>>   	return 0;
> 
> ...



Return-Path: <netdev+bounces-30145-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A0D2786357
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 00:25:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2D6C02813A3
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 22:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E346F200BA;
	Wed, 23 Aug 2023 22:25:11 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE94DFBE7
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 22:25:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE62810C4;
	Wed, 23 Aug 2023 15:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692829509; x=1724365509;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rBHmLm+VrHCX6fl7IOnxTfCOB5RIZ1f6KnBvcLh4m5Y=;
  b=Ygle0JLXdQdSGX6DBDUIOKL7wQKSDZdDCK+BnTsa4HBPlYv4UyFZgArp
   0au//edbOLEkDuf/ewihdn9XX8CAFKwCkW0SiASnL98IbSh2n+zoitrm/
   9v6I7+afnPKQDk7UbAo83vwhLvyc04Ik3HSYSbuChndujCrWjF1ylb2bG
   5FkIfSp6KyPSfS3D42tOP3nLMypE0ap6UowYGZlZ3DUHy5lugtuCV/aft
   X2Nm/VeRKqXeST6UuX9S0M8zJpUyTS5+ss0VtU3geH0KHXF04TL5dmRpg
   /czajqOdlnEqyYuYl9AAsWaunAleLlDj4vMhrlhVZGPD8hick1Ct6C51S
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="371697540"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="371697540"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 15:25:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="826894319"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="826894319"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP; 23 Aug 2023 15:25:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 15:25:08 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 15:25:07 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 15:25:07 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 15:25:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AArgsN6nhz9Gm8jZxq4dL+bgXElUlM8L0Be0th08la3sV2He4Ch6+5LIQLTT0snHgXblac9lRJPk30XIbYpV7CoKKAYpYfZUINMjMM//RIyZKQKqZSuTjY3+7v/VfL3+feBLVlpODKki9DTv4lUqsQJeGT9bwHZ5bCdW8QwlZAGXonhQf7WrnSFWW1fX1Zm7F2yY7Q31TIdkQijz5ww5iaBY6Gdv4/kLSUpi5fECjGdyRt8gK+RDIgnjYq1vP72FOGO3BRvfgHISX8G+mcpyiBx66hyqpG62gvT/ZiDBV/XtGn5LBgeF6qlN8WXNB5LKbYfSlhByxs1D46aWf0wG9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w6x/gtk8Ze616cqSGK90Oi4nHCGGyO+BIdguw03+Fl4=;
 b=HXxuLU7858OnIN8eCYhn+im2uN7RgqiN0SQGIjXa8IJFflorHwpeqI3NfHuryh/RGE94c3BOz4GuZQsj5SfjMO5CdGSfBrxkXi3YbUWMybSjkboYTyetL9VxQ8Q1eJzMc3fCLuM12ucwmvp+Vk12NE8Lr7/qgL5asZHyVkbFmiefj9orGKIMlFfg6a9KfCKkgEvo7bnyo9vGFDWUfRypyZeH1rSNUHDHFJQWyVBP/hL4NE8Hd6fbVwCryP8BRWgJigmVkGPEW2/Ke0bYl4y6OibcESxjCySOU+cErjZrNvQDgP7pAkft45j1N1hXBVX1d3rQG/WrUOJ9iiYgGj232Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by SA1PR11MB6990.namprd11.prod.outlook.com (2603:10b6:806:2b9::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 22:25:05 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::a184:2cd6:51a5:448f]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::a184:2cd6:51a5:448f%7]) with mapi id 15.20.6699.025; Wed, 23 Aug 2023
 22:25:05 +0000
Message-ID: <1e3bf80b-7b8f-418d-3d2d-26dfe2556c75@intel.com>
Date: Wed, 23 Aug 2023 15:25:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v3 5/5] ice: add documentation for FW logging
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, <davem@davemloft.net>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <edumazet@google.com>, <netdev@vger.kernel.org>
CC: <jacob.e.keller@intel.com>, <horms@kernel.org>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>
References: <20230815165750.2789609-1-anthony.l.nguyen@intel.com>
 <20230815165750.2789609-6-anthony.l.nguyen@intel.com>
 <ae2b7002-1230-95a1-33e8-91b1898a33ad@infradead.org>
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <ae2b7002-1230-95a1-33e8-91b1898a33ad@infradead.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0149.namprd13.prod.outlook.com
 (2603:10b6:a03:2c6::34) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|SA1PR11MB6990:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c23849b-7f05-4765-e677-08dba427ccca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: e6SLqkkZ98gV5O2Og90wEU1nFN3TUDTe4CnqzU+jJMsp0loBQOdrdgPa1f825R/HZSHG60j0i/5rfR+Q4rdY3ujUEMH0rhStqrtcx/BcDHPW8+grYxrApAS+jgjgUJ/3Rx++IJ5gUgGRbF388aGibp4wQQm3Mgk+12DEZXG1lmMXaX9N5pnNHfuhFL05k+TtIBHFs+MHBZE6u95JUxxpxo35ECAMdusYqShOd9Zjp4A75BR0zDxAKdm8NbhVgpjp9kQjllXbJqwroolOKhsoKWAplbIvpgXrDVl5PACWwnwyOooFRjIfmZAMvEK8aO9q0oWzodjMm3DLaSR1B1hqzHRKWN8Zj3D7NY8ridmHiES6ygZutGhwt6dZIdsfmjoVY3fwlw3ekcN8zMb0A+XHrr1RK6Ftzqg1pf1FR4GThVC572OoeKH75Q7uQFLzGD41+5i8nlC5zFJ140RJ5w2wLfLpfC+rDrAG4RkyVjP+gDXFl4i9D9/SvtLDUrzdv9RkmWJhUMeBbC4DeACtgOAg2zZzqJsmyWs7mzf5kdUv027tqXDRzAEtS7Ixamwt4A+gE5b0ShhAiPbgflgvZUnnQbM/uv6QULdwxz0DhfRCApJO8KDZv++SBcNNH4JfbwMa9p7/ihuFqr4tZ9dGa6evZQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(366004)(136003)(396003)(346002)(1800799009)(186009)(451199024)(6666004)(53546011)(2616005)(6486002)(6506007)(6512007)(86362001)(66556008)(31696002)(5660300002)(4326008)(2906002)(110136005)(38100700002)(82960400001)(8676002)(66946007)(8936002)(66476007)(36756003)(41300700001)(316002)(478600001)(83380400001)(31686004)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjZoanBwNjJ3YVJkdTRYeDRaRnBBbitzdHdmK3JNallLeWJpYUVDU0djcWJy?=
 =?utf-8?B?LzVvNFVROVp5L05CM2tSalZjV0lsdDhjcUNHOElvcnFoODA4Zm1RbHh0UGNn?=
 =?utf-8?B?TmJMRWM5R3pUdlhPUUVOYjQwSnlCcjUwbW9uY0V5TmFETjJLY3lobnNlVTlY?=
 =?utf-8?B?ZkNCcmk4L2REZmY0Z2ovc2NBa1pEVFllZnFGWXBMK0RtaVNZSDU1WkFSaU1m?=
 =?utf-8?B?REdVcmRFZDNERUZLYS8yMGZDd0hjV2VkYmhwbXJiM3Q2Yk9Ob3UrZ3BLTS9j?=
 =?utf-8?B?SHdSL3RRb05FKzl6bGQ5UmxxOWowQXJHT2pCbHpqcUppQmVLazlndXdZNnRp?=
 =?utf-8?B?ZUZpVElFMUtqaWZReGZFUWptWlY0QkJ2QU1sZ0h2elRSOGVTQkFWaXV4cVZC?=
 =?utf-8?B?ZHNUV3JVaEltRmdKZDkrYndsV1EwWFhtWTlVUkhMNW82aHlOblpybGNENlRX?=
 =?utf-8?B?TFZKbi92UndqbXNTQm5vNEpvYlJ3RjYwNUYxbTZCaklRMHVrWVlWMnRlWUpI?=
 =?utf-8?B?OTNRVkQzWjc3ZHExVlM1NWJDUkhGaGZUNmpZb25STU12QnoveENneHpiTy9i?=
 =?utf-8?B?ZlVHVDg1blRiaVpmU21sL0RtYUNmdkx0cHorK2NnTEp0SEJzU3hRakhtdFRN?=
 =?utf-8?B?bFdtMWsxSW1FdnVSQWordExrd0JBWjVqcVJiWW9OVTREd2NYV0J6S0FsZEEz?=
 =?utf-8?B?WklianZXV0srSWNZRTgwN1BENTBiWDkzL2JLTDl3VWFnYXBuOG12WXpJMkkr?=
 =?utf-8?B?RHcweVllMlo2YWdkb0dJZ1NjMUV0SlJLMUJKNzV6ZTIzVjZKVUUxczR3UnNI?=
 =?utf-8?B?Z2Q4eWIxYUo2L2FoL09NVzZ3V2Y3VGtYaHJMK0RDVy9LN1I1YnFsM2tNVUlW?=
 =?utf-8?B?SXUxL2JNdGFPRnZ4ZHZ6UkVNOGtHeXI1c3ZmbVY2K0ZBTFRZN1FTUTc5VnVO?=
 =?utf-8?B?Mk50ZERpeERlRy9MSzBCOXM0TVVYTVoybHRkNkZaME0vbS9rblI4REhyWURq?=
 =?utf-8?B?Nkhyb3VWaTJnbURuc0lWNzEyT0xzNlFRekk2QjE4dzRoUVFQaWUyK2xLZUNT?=
 =?utf-8?B?MGFhL3FVUjRDNVEvTlB1RHBqcURkdGNqTjFjOEg2MDJvaExiVTJEenJ2Umps?=
 =?utf-8?B?dDlGckVUY2pjVHh2NEpkM0hzdHViU2lUUC9xN0NibEVEbURuUFo0Q2xDWTYy?=
 =?utf-8?B?YkZHbkdNNE9DdFVNUlVINXNHMGlKa0JuNG1TTVNzZFpvRUUwS3lHS0VFaXpq?=
 =?utf-8?B?Y3RUYTJHbEg3SDdIWUVXVi9pREo5ZlFubDROSDZ4Mms2UE8xSDFiZCsxWUhR?=
 =?utf-8?B?OFp2bjBobU9hTWpXdzhJSEp4YVhPUXlvUVFuU2hJaXZ0YmNiTVZ5L1R6L3J3?=
 =?utf-8?B?cDJrcERzVHVCUHNrc2FNbjRzQlRRemU0cmxSUnUrNDM2aVZLVElYMFFYeVgr?=
 =?utf-8?B?ZUNBbGZSa1UybFZIb0V0Y29odHBoMDh0YURXUWE0cmpDVGR2OHZaZm83QURL?=
 =?utf-8?B?Yk1RWUIrM2hTbElJTkdkWFR1Szd5TFozNkNqUzYwcXV3Z1NsOHNBYTJma0J5?=
 =?utf-8?B?VWdKdnViUWNZZ2lGa3pqaUM5M0twb053V2JvaVpSbndFRElIczdEVUVzeUQ3?=
 =?utf-8?B?aEhYN0tyaWxicW51S2s0dGZITTVPdzJGelZKTDlqMFdhaDhoWE56RGVjS3l2?=
 =?utf-8?B?Q3JVY3BxRDI1a0ZWMFRNWG9KYWRJK01yR1k1c0czWnVtZG9ua0Q2TUlOQmt1?=
 =?utf-8?B?blUwTUpQTS9oSm02OUl6cXJDT0J0YlhWczgvemlMMStBVFVYTE1ZcjNBTzdT?=
 =?utf-8?B?ZkNPMzRXNWsybmhrUmhmZjVKOVNITFZ6RXhoM3Q3U2xpR2NNMW9GQW5xMVJE?=
 =?utf-8?B?eDFYSU5UMjI4eitTazl6aGV1ei9OWFJxOVNRYTIvYVQ4cGxGTnV2cWtLcnNk?=
 =?utf-8?B?b1l4aGhxT09iN3Y4TzhaUzhERENkamhWZEJzQjFETFJTRk5xUWViYmQ1L1dV?=
 =?utf-8?B?eU5lQ3phZ1hYTW9WUHdkN2RYQzdQQWNhaktoenlMQmF0RG9Ub0FlZ2xCcVZP?=
 =?utf-8?B?M05mSjVsakduNy9aU3hNRCtvVldnNTlTTkhWdS9hYmdlRHJORTA1RExWRXFm?=
 =?utf-8?B?UUZ1U21pbklrU2FoKzc0eTh6MGNvS1JPcXdvcjJaUHpHdUM3aXBSaWV5aUNl?=
 =?utf-8?B?bFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c23849b-7f05-4765-e677-08dba427ccca
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 22:25:05.1023
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: G6incwSDO4S6TOfHKAhS9dLYIcV8WwjtBkeb4RxlluRmGlqOkkSO9mwfDMzNq4KLI/M+IxZcfKHFdx9yEYSXOD2eH1BnXEY9zIViGPfQ2GY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6990
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/16/2023 3:43 PM, Randy Dunlap wrote:
> 
> 
> On 8/15/23 09:57, Tony Nguyen wrote:
>> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>>
>> Add documentation for FW logging in
>> Documentation/networking/device-drivers/ethernet/intel/ice.rst
>>
>> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>   .../device_drivers/ethernet/intel/ice.rst     | 117 ++++++++++++++++++
>>   1 file changed, 117 insertions(+)
>>
>> diff --git a/Documentation/networking/device_drivers/ethernet/intel/ice.rst b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
>> index e4d065c55ea8..3ddef911faaa 100644
>> --- a/Documentation/networking/device_drivers/ethernet/intel/ice.rst
>> +++ b/Documentation/networking/device_drivers/ethernet/intel/ice.rst
>> @@ -895,6 +895,123 @@ driver writes raw bytes by the GNSS object to the receiver through i2c. Please
>>   refer to the hardware GNSS module documentation for configuration details.
>>   
>>   
>> +Firmware (FW) logging
>> +---------------------
>> +The driver supports FW logging via the debugfs interface on PF 0 only. In order
>> +for FW logging to work, the NVM must support it. The 'fwlog' file will only get
>> +created in the ice debugfs directory if the NVM supports FW logging.
>> +
>> +Module configuration
>> +~~~~~~~~~~~~~~~~~~~~
>> +To see the status of FW logging then read the 'fwlog/modules' file like this::
> 
>                       of FW logging, read
> 

Fixed

>> +
>> +  # cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>> +
>> +To configure FW logging then write to the 'fwlog/modules' file like this::
> 
>                  FW logging, write to
> 

Fixed

>> +
>> +  # echo <fwlog_event> <fwlog_level> > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>> +
>> +where
>> +
>> +* fwlog_level is a name as described below. Each level includes the
>> +  messages from the previous/lower level
>> +
>> +      * NONE
> 
> Should NONE be aligned with the entries below?
> Ah, they are aligned in the source file, but NONE uses a space after the '*'
> while the others use a TAB after the '*'.
> 

Good catch, fixed

>> +      *	ERROR
>> +      *	WARNING
>> +      *	NORMAL
>> +      *	VERBOSE
>> +
>> +* fwlog_event is a name that represents the module to receive events for. The
>> +  module names are
>> +
>> +      *	GENERAL
>> +      *	CTRL
>> +      *	LINK
>> +      *	LINK_TOPO
>> +      *	DNL
>> +      *	I2C
>> +      *	SDP
>> +      *	MDIO
>> +      *	ADMINQ
>> +      *	HDMA
>> +      *	LLDP
>> +      *	DCBX
>> +      *	DCB
>> +      *	XLR
>> +      *	NVM
>> +      *	AUTH
>> +      *	VPD
>> +      *	IOSF
>> +      *	PARSER
>> +      *	SW
>> +      *	SCHEDULER
>> +      *	TXQ
>> +      *	RSVD
>> +      *	POST
>> +      *	WATCHDOG
>> +      *	TASK_DISPATCH
>> +      *	MNG
>> +      *	SYNCE
>> +      *	HEALTH
>> +      *	TSDRV
>> +      *	PFREG
>> +      *	MDLVER
>> +      *	ALL
>> +
>> +The name ALL is special and specifies setting all of the modules to the
>> +specified fwlog_level.
>> +
>> +Example usage to configure the modules::
>> +
>> +  # echo LINK VERBOSE > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>> +
>> +Enabling FW log
>> +~~~~~~~~~~~~~~~
>> +Once the desired modules are configured the user will enable the logging. To do
> 
>                                             the user enables logging. To do
> 

Fixed

>> +this the user can write a 1 (enable) or 0 (disable) to 'fwlog/enable'. An
>> +example is::
>> +
>> +  # echo 1 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/enable
>> +
>> +Retrieving FW log data
>> +~~~~~~~~~~~~~~~~~~~~~~
>> +The FW log data can be retrieved by reading from 'fwlog/data'. The user can
>> +write to 'fwlog/data' to clear the data. The data can only be cleared when FW
>> +logging is disabled. The FW log data is a binary file that is sent to Intel and
>> +used to help debug user issues.
>> +
>> +An example to read the data is::
>> +
>> +  # cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/data > fwlog.bin
>> +
>> +An example to clear the data is::
>> +
>> +  # echo 0 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/data
>> +
>> +Changing how often the log events are sent to the driver
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +The driver receives FW log data from the Admin Receive Queue (ARQ). The
>> +frequency that the FW sends the ARQ events can be configured by writing to
>> +'fwlog/resolution'. The range is 1-128 (1 means push every log message, 128
>> +means push only when the max AQ command buffer is full). The suggested value is
>> +10. The user can see what the value is configured to by reading
>> +'fwlog/resolution'. An example to set the value is::
>> +
>> +  # echo 50 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/resolution
>> +
>> +Configuring the number of buffers used to store FW log data
>> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> +The driver stores FW log data in a ring within the driver. The default size of
>> +the ring is 256 4K buffers. Some use cases may require more or less data so
>> +the user can change the number of buffers that are allocated for FW log data.
>> +To change the number of buffers write to 'fwlog/nr_buffs'. The value must be a
>> +power of two and between the values 64-512. FW logging must be disabled to
> 
> or
> The value must be one of: 64, 128, 256, or 512.
> 

Changed

>> +change the value. An example of changing the value is::
>> +
>> +  # echo 128 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/nr_buffs
>> +
>> +
>>   Performance Optimization
>>   ========================
>>   Driver defaults are meant to fit a wide variety of workloads, but if further



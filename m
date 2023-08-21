Return-Path: <netdev+bounces-29480-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6578C783630
	for <lists+netdev@lfdr.de>; Tue, 22 Aug 2023 01:21:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DAD7280F7C
	for <lists+netdev@lfdr.de>; Mon, 21 Aug 2023 23:21:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509811ADE0;
	Mon, 21 Aug 2023 23:21:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3136C749D
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 23:21:04 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B75132
	for <netdev@vger.kernel.org>; Mon, 21 Aug 2023 16:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692660063; x=1724196063;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Vr6c1PschaZVgnxskalQ+DvBW74z3ll8SrYJRxSLkE8=;
  b=SEelkk17yeco/gO3BqAFnUSomzA/rBW/WJWSVpyHm7dpwV/fCxou5uE+
   kF3o2gGRK1rBXsssj+7GzqM3wJ+8n+J5ErcZ9lvnwrWJC87B1Z0SqXxXa
   yAlRVYPzr/jfDo+MAWW0/9k60w72BZzoKMWB+tzxazKG7zAqsYzNsH88+
   bcU5F8UtQEBnoqM7TKctDIHmaxPYMknowcMa/KGX+eiQIh+S1QC8JsBL7
   1a1zWknBxrBFoGPF3vL11T7SVn90+hh+lvd3mh9+w+pI3rXEN4Ys/BYbV
   tvaH1UpzDnZCm+gqTKS3Nb3M+OD8072fi0pR1R0gIv2gzYs0hnw0PxZy9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="353299218"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="353299218"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2023 16:21:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="826110130"
X-IronPort-AV: E=Sophos;i="6.01,191,1684825200"; 
   d="scan'208";a="826110130"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by FMSMGA003.fm.intel.com with ESMTP; 21 Aug 2023 16:21:02 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 16:21:02 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 21 Aug 2023 16:21:02 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 21 Aug 2023 16:21:02 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.103)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 21 Aug 2023 16:21:01 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcPkZkJChAW6xaMhJQUeor5GBOlXhsml4sd+IB8NTGlOhUlLoO8PuuzYKMuNBZXktDaJN99MWTYVCVVkbW58gYXfVMXVyzxu6hO4tdDAdHRvBEVw3VjuQLxX3U3+9IWKZ3VWXkTnX1uoJVQo96JKevowyRr2bwSm0zcvI1wzRUp0tsMXd5+YGptsrr6ANW9Ribh7EcaJPUwNsnQFmWqhu2comx0/AAIig5kCknlRWhHCURHS8HLzsc75ypnBRqQnYHJmix1aGEfBL4xmukhZnaRof+GJoED5HuoYjOisUbEw0Tqa4yjJg4rIFPwKZfd90F7KcKJZIW+u4HcjxNX3eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k21Y4U/hCI0uGPu/VSMe+8OaBaQKk3unPDZn3IayJTM=;
 b=UR9pPYqB+2Nae6NRDcuf9HzKHB6EFgtxk+HJNOx3/rMCrWhi4TTkJLHB1CB+3IFVE32r2MMWbs4DKTmDDRyoZG9y5LrOLjj8Rs3uI7s57ftXIp7v+OS2Ra5at47Q8ZQ71UzrV+HebiIHywPzOexoY+UVOWowmVyGUIaGiftF2wP0TWMebX0u0tegBQqZCUoM/YJMZdNpn1mQt3HCgWnTFi/nm++FqBNaCaPr8Lo9OFskoTQuMJHy6c5wYG7SjbNOIpYyAbC3pM5aTgT/UfM28PULoW9oxSH4dTlOntNf64R/VIOsNEEXFBM6Jrj01poBaV5tmBaZj1HboKUdjCPDNg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5636.namprd11.prod.outlook.com (2603:10b6:5:357::21)
 by CY5PR11MB6185.namprd11.prod.outlook.com (2603:10b6:930:27::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.24; Mon, 21 Aug
 2023 23:20:58 +0000
Received: from CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::a184:2cd6:51a5:448f]) by CO6PR11MB5636.namprd11.prod.outlook.com
 ([fe80::a184:2cd6:51a5:448f%7]) with mapi id 15.20.6699.022; Mon, 21 Aug 2023
 23:20:58 +0000
Message-ID: <16fbb0fe-0578-4058-5106-76dbf2a6458e@intel.com>
Date: Mon, 21 Aug 2023 16:20:56 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net-next v3 2/5] ice: configure FW logging
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, Leon Romanovsky
	<leon@kernel.org>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, <jacob.e.keller@intel.com>, <horms@kernel.org>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
References: <20230815165750.2789609-1-anthony.l.nguyen@intel.com>
 <20230815165750.2789609-3-anthony.l.nguyen@intel.com>
 <20230815183854.GU22185@unreal>
 <c865cde7-fe13-c158-673a-a0acd200b667@intel.com>
 <20230818111049.GY22185@unreal>
 <87b9788b-bcad-509a-50ef-bf86de2f5c03@intel.com>
Content-Language: en-US
From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
In-Reply-To: <87b9788b-bcad-509a-50ef-bf86de2f5c03@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: BY3PR04CA0011.namprd04.prod.outlook.com
 (2603:10b6:a03:217::16) To CO6PR11MB5636.namprd11.prod.outlook.com
 (2603:10b6:5:357::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5636:EE_|CY5PR11MB6185:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d6bd948-2170-44b0-e404-08dba29d46b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 33JoLEWqun5ZXfdn8vXjK+gVQvcp8ddiTcnAZpQUWGwP6klTZZ3LvPc8i5lb6jcSyFRFg/FClYHuDIsG0FbNrZHlPMzXUPdbNE7e0vgHtJJ9d+21Cq2M3feVfNyXibnQWpFbGOlOi6JvlomazD+/oVu5fWj3xbVgkyhS7kIYDJAM4/HRJ27jeTz/JZgbKi9fjPWv1qKoyXym3aC0fFj6XfCJOk1oVCIGW+l3P4Ejko1QgKdH1NGQwSlZoRPfsvS5qmb2RRDx0Rk33gSLHTRGTUadn+8H3NAmdThXZGwwbvIkp9UyNKBmh+51ShD6O79Ve9mIEFuC99O7nJ+zz1PdtwMck8wgXEPX0Y+TUxnp7EiSGxQPjbe5XqOUZ7AUIDRD7JPq94x5OfWwsNFN73XPYMLjJA8DMdNYr4bH85jb7oiRX2NflfHKU8BSx2ugKsHkWoa8Bf0fq2/LDEAVmUgeQvnLdUFqSZXFAVqSSMYlk+UPKiu7xgmdB/7tK9gFd8PRJ8OZaTN/zrDU0kKDGd8nqoXOwh8iS6jaqMMpO/V4Q5bXgqdbHLhrA6dxSGe0XVD4IMCLhbBql9TNGcly0kPG7pB6NdMdRCJy4d9lCNcqHhtUhCnPRm3Fp4q6WepfKsy7PVv9SjExblriSXQtuEsLtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5636.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(136003)(346002)(39860400002)(366004)(186009)(1800799009)(451199024)(54906003)(66476007)(66556008)(316002)(6512007)(66946007)(66899024)(82960400001)(110136005)(8676002)(8936002)(2616005)(107886003)(4326008)(36756003)(41300700001)(478600001)(38100700002)(53546011)(6506007)(6486002)(83380400001)(2906002)(86362001)(31686004)(31696002)(5660300002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cmRJV2h5c244d1pObUVabzhKQmRmd2V3YlZOZTk3Qkk1K01pYmVudk1jek1l?=
 =?utf-8?B?K1A0cEJ1Mkl0SmQ3N0h0dy9nb1FwdHN3d0FIWE1TRHRRUU5QNzhQN3FBRGIy?=
 =?utf-8?B?ZUY2WnM4N1diQndMZkVRajhpdUllTk5BRjJDc2tPZnVBcVhma3pZRTA2VTht?=
 =?utf-8?B?bWlPYWo5UU56anhiQ053N0YvekRjYUdhQ3QxbTFFc3MvN1NFTC9JcjJjMy8v?=
 =?utf-8?B?d3BLd2RjWlJhL1dtZjhsQjVRU2x4a2VIcXJVOXd2S3RrM3pWRFV2QnQ0ZDd1?=
 =?utf-8?B?WFpkWlFKNlE4b3daWVR4ZzhWQTd1UTJieEttL1RYaXVBOGU5ZytnL3l4RFVK?=
 =?utf-8?B?dDF6TkNpaGZGRzl6dDFza0QxeXBKdHhSekxvT0h2R1U0ZDRqS2VkY3Z0ZVd5?=
 =?utf-8?B?b05idVNsUllBMi9XeUtGekNKNnlzS3V3UDRuZDFEN1MrV3IvcVdSQUFueDli?=
 =?utf-8?B?dWdKTkIwZTNOV3ZNaXlwU2dZcVdJcnY4L0JacFN5UEtvMjlUUEhWaWd0R2FQ?=
 =?utf-8?B?RDBVU2NpZ2NoNVpLR3ZjbnRwbkVQRW9EVXYyZnh2L0tXK0hDN0E1MnRwY05h?=
 =?utf-8?B?a1B2YmZKWkVwWS92eEZmbXQxSElJc05jNVQ2aXJkdDVEbFg5aGxuMGVSMVdW?=
 =?utf-8?B?R0drVXgrOHE3NGtLKzExVktpbTVNL3Z3MTNmNUp0Z3duaDEyY3dZTEsvbmxs?=
 =?utf-8?B?UjFUU05RcjZUeHFhdXozcHNiNkhFb1o5OVc4c21odXd2UytmRTZIOVd1TmN4?=
 =?utf-8?B?bzFaM1c4TEFQWnBNMUhKd0ozb3hvT0FyOXB3YUV4eG5EazB6U09nckxxdThk?=
 =?utf-8?B?U3phR2Q4LzdrRlErWmZjZ3B6L2t3QUdnMm4rUnhkdDYvb3dEejBDaDB0UEI5?=
 =?utf-8?B?Zm16VXUxRUJ2V0dUb3BiRTQ4bHNhRVA4dVQ4RTM4Ulk1UnRnMTN2WXczOWYv?=
 =?utf-8?B?bmdaVTRyWnJvV2MyWXp3OFp3WWtvM295dSt2OFRweE1OdEcwbHIySm1xbHJU?=
 =?utf-8?B?VnVzM1Z3NGw0MWVGTW51bEd2Z1Iwc3d2Vk5Ba0FkTjZZMElXT0ZkL1Jyd2tv?=
 =?utf-8?B?eFB4MGJzdnVEeUlvTzM2Y3ptNEZHWEdXYkpBaVBlcWpvaC9XUDNwcFowbk9w?=
 =?utf-8?B?UDNuNjVEYytxTzVLWkJJdGtmSG9GemFSZlNrbW9SdE1iNmFNMUNXd2tLeEhS?=
 =?utf-8?B?WXI3cy9YVmh3Zlc5d1lZemtWYUxrb1pwbG9yVExkTkYvanhqYWZRY3ZxMURF?=
 =?utf-8?B?bzd3S0NjU1NWTWY4VXlCR1RkTzBrODVnS1BmdW9mbkEySmtTNzZJTTYxemQv?=
 =?utf-8?B?ZTFoMk5aMUUzS0trQXVETlVlNTJ2ZTNjMVo5WnlkTzBJTjVkWW9sV3BHYUQv?=
 =?utf-8?B?MmRaYUh4YmZPeFp4SVZlYVlVa0hCRWY4WXZYdjVyMGY4WUZvdVlpN0JJck9I?=
 =?utf-8?B?MkRvUEdkSTI2QUd2dVphZENkVW51TW4rNHNGcndQaGVDZzFNeHNmUW02Und4?=
 =?utf-8?B?aVEveEtHV2p0cHpFRFh3OTVkRk1LU2dnMWhHdU9ZZXFmSHVscVFxMXBvY2Rt?=
 =?utf-8?B?Skdrczhidkd1UFV6T3d3SE9tbm1ZWEJpaGRTbUVrN1Y2czZsUk5TTDVQNjRo?=
 =?utf-8?B?d0JJdmdWZ0VCSWV6eUJsSldXcFFkZ1ZhWFRGUHN6ZVNSMVJRZ2lQQ3ZoWkJo?=
 =?utf-8?B?bEo2S2NhcnRHRGxWK2ttS29UVjM4Rm4yRWVwckUvRHJTbzV3UHRWdHlhd0lT?=
 =?utf-8?B?eUtxdWN5bjUyTE5BZmlNUG4yRUQwWS9wT1BjZjhkdVpiUnJqOFBnU0VEcGJG?=
 =?utf-8?B?Q0cwdnFZMEoybkZDSkNmekRQQTAvMHJCVGd5T2ZvT1BFbCtjemJxY3dsRysx?=
 =?utf-8?B?UE00RTgrT1dTa3pBY08wcXo0c1kraEFSV1c0S2lsWFNROWR4ZXV4U3dPWEh3?=
 =?utf-8?B?SmtqZWFCcFZiOTU5ektZNWo2Nkp0N1FOWWtWOVpGUVl6K3FUNlhzRC9ZTWFE?=
 =?utf-8?B?OEhiN3U1VDdCc3FaV09ySjlkR3orQ2tPZWRsci9yL3ZpaVpxaGcyU0RpNkRj?=
 =?utf-8?B?ZDVHVmcwV092emQ2Ky91YnU4OHRwZXczTmU3cXExUzg1WFVsQmE1bm95Rm1I?=
 =?utf-8?B?R2J0a2RLSG5TbER6WndQQjZ6Z2djRk1KR1NxSE1hMWNCbU1Vc0RjOHl2cEJT?=
 =?utf-8?B?MWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d6bd948-2170-44b0-e404-08dba29d46b0
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5636.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2023 23:20:58.4216
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YR/t3B9Ih4P6FQ8eB19ibXD2TvUNhifQd7z48shE73ExPd48j6Pj1GBxu3cKgdDlIIKsIOy22LLHBdTHvEhPYk6nhrj5bkeIrnjeBHj3vm4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6185
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/18/2023 5:31 AM, Przemek Kitszel wrote:
> On 8/18/23 13:10, Leon Romanovsky wrote:
>> On Thu, Aug 17, 2023 at 02:25:34PM -0700, Paul M Stillwell Jr wrote:
>>> On 8/15/2023 11:38 AM, Leon Romanovsky wrote:
>>>> On Tue, Aug 15, 2023 at 09:57:47AM -0700, Tony Nguyen wrote:
>>>>> From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>>>>>
>>>>> Users want the ability to debug FW issues by retrieving the
>>>>> FW logs from the E8xx devices. Use debugfs to allow the user to
>>>>> read/write the FW log configuration by adding a 'fwlog/modules' file.
>>>>> Reading the file will show either the currently running 
>>>>> configuration or
>>>>> the next configuration (if the user has changed the configuration).
>>>>> Writing to the file will update the configuration, but NOT enable the
>>>>> configuration (that is a separate command).
>>>>>
>>>>> To see the status of FW logging then read the 'fwlog/modules' file 
>>>>> like
>>>>> this:
>>>>>
>>>>> cat /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>>>>>
>>>>> To change the configuration of FW logging then write to the 
>>>>> 'fwlog/modules'
>>>>> file like this:
>>>>>
>>>>> echo DCB NORMAL > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/modules
>>>>>
>>>>> The format to change the configuration is
>>>>>
>>>>> echo <fwlog_module> <fwlog_level> > /sys/kernel/debug/ice/<pci device
>>>>
>>>> This line is truncated, it is not clear where you are writing.
>>>
>>> Good catch, I don't know how I missed this... Will fix
>>>
>>>> And more general question, a long time ago, netdev had a policy of
>>>> not-allowing writing to debugfs, was it changed?
>>>>
>>>
>>> I had this same thought and it seems like there were 2 concerns in 
>>> the past
>>
>> Maybe, I'm not enough time in netdev world to know the history.
>>
>>>
>>> 1. Having a single file that was read/write with lots of commands going
>>> through it
>>> 2. Having code in the driver to parse the text from the commands that 
>>> was
>>> error/security prone
>>>
>>> We have addressed this in 2 ways:
>>> 1. Split the commands into multiple files that have a single purpose
>>> 2. Use kernel parsing functions for anything where we *have* to pass 
>>> text to
>>> decode
>>>
>>>>>
>>>>> where
>>>>>
>>>>> * fwlog_level is a name as described below. Each level includes the
>>>>>     messages from the previous/lower level
>>>>>
>>>>>         * NONE
>>>>>         *    ERROR
>>>>>         *    WARNING
>>>>>         *    NORMAL
>>>>>         *    VERBOSE
>>>>>
>>>>> * fwlog_event is a name that represents the module to receive 
>>>>> events for.
>>>>>     The module names are
>>>>>
>>>>>         *    GENERAL
>>>>>         *    CTRL
>>>>>         *    LINK
>>>>>         *    LINK_TOPO
>>>>>         *    DNL
>>>>>         *    I2C
>>>>>         *    SDP
>>>>>         *    MDIO
>>>>>         *    ADMINQ
>>>>>         *    HDMA
>>>>>         *    LLDP
>>>>>         *    DCBX
>>>>>         *    DCB
>>>>>         *    XLR
>>>>>         *    NVM
>>>>>         *    AUTH
>>>>>         *    VPD
>>>>>         *    IOSF
>>>>>         *    PARSER
>>>>>         *    SW
>>>>>         *    SCHEDULER
>>>>>         *    TXQ
>>>>>         *    RSVD
>>>>>         *    POST
>>>>>         *    WATCHDOG
>>>>>         *    TASK_DISPATCH
>>>>>         *    MNG
>>>>>         *    SYNCE
>>>>>         *    HEALTH
>>>>>         *    TSDRV
>>>>>         *    PFREG
>>>>>         *    MDLVER
>>>>>         *    ALL
>>>>>
>>>>> The name ALL is special and specifies setting all of the modules to 
>>>>> the
>>>>> specified fwlog_level.
>>>>>
>>>>> If the NVM supports FW logging then the file 'fwlog' will be created
>>>>> under the PCI device ID for the ice driver. If the file does not exist
>>>>> then either the NVM doesn't support FW logging or debugfs is not 
>>>>> enabled
>>>>> on the system.
>>>>>
>>>>> In addition to configuring the modules, the user can also configure 
>>>>> the
>>>>> number of log messages (resolution) to include in a single Admin 
>>>>> Receive
>>>>> Queue (ARQ) event.The range is 1-128 (1 means push every log 
>>>>> message, 128
>>>>> means push only when the max AQ command buffer is full). The suggested
>>>>> value is 10.
>>>>>
>>>>> To see/change the resolution the user can read/write the
>>>>> 'fwlog/resolution' file. An example changing the value to 50 is
>>>>>
>>>>> echo 50 > /sys/kernel/debug/ice/0000\:18\:00.0/fwlog/resolution
>>>>>
>>>>> Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
>>>>> Tested-by: Pucha Himasekhar Reddy 
>>>>> <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
>>>>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>>>> ---
>>>>>    drivers/net/ethernet/intel/ice/Makefile       |   4 +-
>>>>>    drivers/net/ethernet/intel/ice/ice.h          |  18 +
>>>>>    .../net/ethernet/intel/ice/ice_adminq_cmd.h   |  80 ++++
>>>>>    drivers/net/ethernet/intel/ice/ice_common.c   |   5 +
>>>>>    drivers/net/ethernet/intel/ice/ice_debugfs.c  | 450 
>>>>> ++++++++++++++++++
>>>>>    drivers/net/ethernet/intel/ice/ice_fwlog.c    | 231 +++++++++
>>>>>    drivers/net/ethernet/intel/ice/ice_fwlog.h    |  55 +++
>>>>>    drivers/net/ethernet/intel/ice/ice_main.c     |  21 +
>>>>>    drivers/net/ethernet/intel/ice/ice_type.h     |   4 +
>>>>>    9 files changed, 867 insertions(+), 1 deletion(-)
>>>>>    create mode 100644 drivers/net/ethernet/intel/ice/ice_debugfs.c
>>>>>    create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.c
>>>>>    create mode 100644 drivers/net/ethernet/intel/ice/ice_fwlog.h
>>>>>
>>>>> diff --git a/drivers/net/ethernet/intel/ice/Makefile 
>>>>> b/drivers/net/ethernet/intel/ice/Makefile
>>>>> index 960277d78e09..d43a59e5f8ee 100644
>>>>> --- a/drivers/net/ethernet/intel/ice/Makefile
>>>>> +++ b/drivers/net/ethernet/intel/ice/Makefile
>>>>> @@ -34,7 +34,8 @@ ice-y := ice_main.o    \
>>>>>         ice_lag.o    \
>>>>>         ice_ethtool.o  \
>>>>>         ice_repr.o    \
>>>>> -     ice_tc_lib.o
>>>>> +     ice_tc_lib.o    \
>>>>> +     ice_fwlog.o
>>>>>    ice-$(CONFIG_PCI_IOV) +=    \
>>>>>        ice_sriov.o        \
>>>>>        ice_virtchnl.o        \
>>>>> @@ -49,3 +50,4 @@ ice-$(CONFIG_RFS_ACCEL) += ice_arfs.o
>>>>>    ice-$(CONFIG_XDP_SOCKETS) += ice_xsk.o
>>>>>    ice-$(CONFIG_ICE_SWITCHDEV) += ice_eswitch.o ice_eswitch_br.o
>>>>>    ice-$(CONFIG_GNSS) += ice_gnss.o
>>>>> +ice-$(CONFIG_DEBUG_FS) += ice_debugfs.o
>>>>> diff --git a/drivers/net/ethernet/intel/ice/ice.h 
>>>>> b/drivers/net/ethernet/intel/ice/ice.h
>>>>> index 5ac0ad12f9f1..e6dd9f6f9eee 100644
>>>>> --- a/drivers/net/ethernet/intel/ice/ice.h
>>>>> +++ b/drivers/net/ethernet/intel/ice/ice.h
>>>>> @@ -556,6 +556,8 @@ struct ice_pf {
>>>>>        struct ice_vsi_stats **vsi_stats;
>>>>>        struct ice_sw *first_sw;    /* first switch created by 
>>>>> firmware */
>>>>>        u16 eswitch_mode;        /* current mode of eswitch */
>>>>> +    struct dentry *ice_debugfs_pf;
>>>>> +    struct dentry *ice_debugfs_pf_fwlog;
>>>>>        struct ice_vfs vfs;
>>>>>        DECLARE_BITMAP(features, ICE_F_MAX);
>>>>>        DECLARE_BITMAP(state, ICE_STATE_NBITS);
>>>>> @@ -861,6 +863,22 @@ static inline bool ice_is_adq_active(struct 
>>>>> ice_pf *pf)
>>>>>        return false;
>>>>>    }
>>>>> +#ifdef CONFIG_DEBUG_FS
>>>>
>>>> There is no need in this CONFIG_DEBUG_FS and code should be written
>>>> without debugfs stubs.
>>>>
>>>
>>> I don't understand this comment... If the kernel is configured *without*
>>> debugfs, won't the kernel fail to compile due to missing functions if we
>>> don't do this?
>>
>> It will work fine, see include/linux/debugfs.h.
> 
> Nice, as-is impl of ice_debugfs_fwlog_init() would just fail on first 
> debugfs API call.
> 

I've thought about this some more and I am confused what to do. In the 
Makefile there is a bit that removes ice_debugfs.o if CONFIG_DEBUG_FS is 
not set. This would result in the stubs being needed (since the 
functions are called from ice_fwlog.c). In this case the code would not 
compile (since the functions would be missing). Should I remove the code 
from the Makefile that deals with ice_debugfs.o (which doesn't make 
sense since then there will be code in the driver that doesn't get used) 
or do I leave the stubs in?

>>
>>>
>>>>> +void ice_debugfs_fwlog_init(struct ice_pf *pf);
>>>>> +void ice_debugfs_init(void);
>>>>> +void ice_debugfs_exit(void);
>>>>> +void ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, 
>>>>> int module);
>>>>> +#else
>>>>> +static inline void ice_debugfs_fwlog_init(struct ice_pf *pf) { }
>>>>> +static inline void ice_debugfs_init(void) { }
>>>>> +static inline void ice_debugfs_exit(void) { }
>>>>> +static void
>>>>> +ice_pf_fwlog_update_module(struct ice_pf *pf, int log_level, int 
>>>>> module)
>>>>> +{
>>>>> +    return -EOPNOTSUPP;
>>>>> +}
>>>>> +#endif /* CONFIG_DEBUG_FS */
>>>>
>>>> Thanks
>>>
>>
> 



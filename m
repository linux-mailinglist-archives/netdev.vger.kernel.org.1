Return-Path: <netdev+bounces-26689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 78177778979
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 11:11:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 717411C20EB0
	for <lists+netdev@lfdr.de>; Fri, 11 Aug 2023 09:11:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1584C5673;
	Fri, 11 Aug 2023 09:11:12 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 021631869
	for <netdev@vger.kernel.org>; Fri, 11 Aug 2023 09:11:10 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D38C0211C;
	Fri, 11 Aug 2023 02:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691745069; x=1723281069;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=sUEXQU1ToGt2hYl4HjWwck6XB9F3TIWG2jtM5348ijs=;
  b=hpyA4udrCzzvRfEsvJoA+UjULL/I4Tso3f4VwCWdZmchr1qVuYolNKd6
   NY6nsqIJwZBBG7l6eDYlIh0hqGPpk+4o9CXDBJJTv6pRW6Ah7e5QMMoWz
   Y5B4MTfuFFY8CdxowXTiIlx+bZ7XW5AI2n+/igkDikEN/Zna8n9IkE996
   caX0irSlBDCaVGUOYMgBrVsfbfnlXSkll0O3kBw+rHJDAmqb1yT/tCXz+
   54ggFnXSsMGtzMcVPNdelcCdHrHU6HLU9r0oLyJjn2ozxAXT/b8jdoPwJ
   Wry7LNbLqMkQiOV86fCOz4IHjVWhzvIItXj55ayiaatfJzC2O7Zqq0amB
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="437974048"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="437974048"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2023 02:11:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="682478617"
X-IronPort-AV: E=Sophos;i="6.01,165,1684825200"; 
   d="scan'208";a="682478617"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP; 11 Aug 2023 02:11:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 11 Aug 2023 02:11:08 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 11 Aug 2023 02:11:08 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 11 Aug 2023 02:11:07 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G2B7rddI/9ER0F1Gc6PZBwFdaaeEySQWh5fY7csw97HL2vWUQT7MzqTI8x0n3btklTDZZYWSNO+ipWqwsqVpszXG6GhcQZ2UNEP6kf/v1GUvWLeuWLejzBjebIT+NoCdO0YaBH6sIGbhBnSDR23My4DOK46WZpwkkk2ejPZa4ArwPy2bGVUw3UfmkSbMbNEutkJoNEPXBeDBxiNdIeOHHm/QELxW8mLjtYjsMWpQjAoOYdO4JsVUYn116cb/1qhvBLMROLyC30ZCiyrrzEtTj+I9V7oglGe1olv+Svso/vwWX2BpezREz9tCFPVgvymtCtLDLlW3gQRVwDNFBXSeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4KT945BSMWheRpnZk/QMi6ykLfFBKQUTXh9fCWesLUo=;
 b=F+LvQGAuhkY8EswvHOo1scyfY+nHwxcHfx2QokiztYKZoMQwWvU0z4ASzqnCiWzBIx73kptNc5o+QWjPKKT6thvR8b2wQ58QlDIF7dYtISEvQJqqOxdlaTS5gtNtlesjCogdzPjy3fDSOh8FF5cV+yP5zAbI8bUYvNbjONnwp9Ve5jyACso/xeXTVGqPO7gpMSLWkoMOfM//bSfiXz2fbC4brbliFLqCB4HUBkP/3lkJGwEVWYlmbMpLqQ8MVDOHD2llPSaNSWIE9tofs3Afr1JgIQbzNhfAIzFlqFnkrbjZ8H45S72Iejq7aB6CHC1DdCUk8/8YkvmfYe5NC4gGZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by MN0PR11MB6012.namprd11.prod.outlook.com (2603:10b6:208:373::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Fri, 11 Aug
 2023 09:11:05 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::aa6e:f274:83d0:a0d2]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::aa6e:f274:83d0:a0d2%3]) with mapi id 15.20.6652.029; Fri, 11 Aug 2023
 09:11:05 +0000
Message-ID: <12cda14d-a360-f4b0-14f1-11d74f3262f9@intel.com>
Date: Fri, 11 Aug 2023 11:10:56 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next v1 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
To: Kees Cook <keescook@chromium.org>
CC: <netdev@vger.kernel.org>, Jacob Keller <jacob.e.keller@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, Alexander Lobakin
	<aleksander.lobakin@intel.com>, <linux-hardening@vger.kernel.org>, Steven Zou
	<steven.zou@intel.com>
References: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
 <20230810103509.163225-2-przemyslaw.kitszel@intel.com>
 <202308101131.D8DEE055@keescook>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <202308101131.D8DEE055@keescook>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0002.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::12) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|MN0PR11MB6012:EE_
X-MS-Office365-Filtering-Correlation-Id: 72a30a73-8109-4887-4dfa-08db9a4ae455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 7lcg3z1ynHufB2KQqK5YU+7OFsT5jUcpdGHMuvC5HhURxvzFiA63KvdBmbF/Vgd9WDvPVjG9SbdqY/cMVQrvR/L4P4p/skNEwaBXLWEnWxUmWaDCdiefDMPInKcgmcyNMekBIDVj9Chuplg4UVJKin4371Objtc6DAQLIGhk4OzXsLCO9TKUDSLB+fXqoUDVBc4GHxSSUcdC3WiPgwfYy+5Jsh1OmzeX5vMAEHiTZuz+Uh0pAlX68XIHf9q5lqwUi8WH1Bk+VOecJ2862CETIsJiyvnB8t8Gbj9z34+qHnoPSC9QN08s+joHnmBrus/zT9zMVuP48Pv66HUxTqkMKSETBnpO0+92rHRYVJbWURw7E7WaCHdoVeRexTNswIaOLjgYlsb6Xa9mLbp2/4Hj4P6c0dqh2SZKoYxyzTiEZkg2hOrLUXE4gybhQRAWyssmJ8v27T1FIGT/ZlPcVJP+lhvZVfcHq0pa5KJJn5MKa4DSFOtvcBapZiZiicGMyi0qn8FXum/QMWUA4L3rWcPCvcdF1jS4PMUpqsz8gXMYb+cCfDBYXNQYsvf3HXBqWErkkvYXeXMXOtlXL5Pm1TpOgsK2T2zW5rS+ut9spRzYzGwcEHGLJN9eJ+j6RWG35tn4PnvjNgvz3Gztbpfl2Q0UaQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(366004)(39860400002)(346002)(376002)(136003)(451199021)(1800799006)(186006)(2616005)(5660300002)(107886003)(2906002)(36756003)(83380400001)(41300700001)(8676002)(8936002)(26005)(6506007)(53546011)(86362001)(54906003)(31696002)(6666004)(38100700002)(82960400001)(6486002)(478600001)(31686004)(6512007)(66556008)(66946007)(66476007)(316002)(6916009)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?d2RTRnNUbks0NVRVUnd1TXZyTWFqSE9HSllWdXdDWmR6c01vNG5FUnpHcFI4?=
 =?utf-8?B?R3RwczFJcjFha2tWRXIxRjdkbHRoRHlLMzI5VzJZVHpBOGFxU1J6dks4VGZY?=
 =?utf-8?B?VjVXV2RWaDh4UUlXbW1iOXN2TVBob202ck94RUdOQjJUUjV0bFkxK29XS0xM?=
 =?utf-8?B?MWhkR3ZCcE54a054RzNPb0c3Z3MwTkZDalAxUVk4VTJ3dUdkWGU1aTVqejNx?=
 =?utf-8?B?SGpDTlFXNzRLL2xoWDdxOUI0L3pNVjJ4SC9oeGxSQ2NYeWdhcjFVSzhFZlNZ?=
 =?utf-8?B?KzFJYk9hbmhWZ0lFOW90S09wemN3eW1SWU90elR1aGtDNTdXcjhtRGU4K3Q1?=
 =?utf-8?B?dW40TC9BMU9DZHZVQVBGNEdUODFXemNNV1RCV0o2ZUp5TkJDM3hURWp6VUFM?=
 =?utf-8?B?QlBIWFN6YnA5bGNmM1dYeVpiYXNsWFM0THpETUdIT0VwbklmS1Q5Y2lGamFD?=
 =?utf-8?B?Mmd5bkdSK3ZzSUxFcXIvY0lRcW53emh0QW96TDJZM05wZXZnQlY2OU5ually?=
 =?utf-8?B?ZUV1OUJUV0hVWWFNQXZGZ1ZBL2pPTVFKT2IxY0ZRaTlNeFNZOHBaOVdvY1ky?=
 =?utf-8?B?OXJvdGxNZWhiNmVYVVpwWDJic1lWNGkxdU5MaGZXSTFCTTRzWDNudkVFTk1T?=
 =?utf-8?B?WnlDbjJZZjhYcStCK0VSQlZ5ZFRCcnFsdlN2TmxJdis4S05jUEVQeGF6eWpQ?=
 =?utf-8?B?K1VzWE1CRTNvcitBb0d1dUpYTTY3UjBCYVZIcXdpTzJ6RFlPS1A3OW16bVdE?=
 =?utf-8?B?YW9YaUJ4R0pOUC9KZFpVMTdXa1BMeVpQcS9vdXhXMnpZT1g5OEc2Y3U5Y29u?=
 =?utf-8?B?WjlRVHlNdXpDQXMvekVZaEdLYWdQaXczUVpjNllmS09LeklqUXhIbFlmbDZ4?=
 =?utf-8?B?d2hPOStwMDBxcElWUmc1Mk9uZitFWVI2VXdjM3hSNEp0NUR1WjdxQmhMRk9Y?=
 =?utf-8?B?N2ljT0FYblRoNWdERjJqL3JBWUpBaTZDSmdNaERXVmtUdEl5T1ZZMExXRGpE?=
 =?utf-8?B?SjhUTmZleVEyVk5pUC93cmUxL0ZJRXVwZi80dG94Z3RxVkpWM2hoeEQ2NDdV?=
 =?utf-8?B?SFJkSktTeTFDMG5QVUJPZjB0Z0pTeFQrREtDQ25jZ01oOFpCSFJKUFVTNVk2?=
 =?utf-8?B?MnZuWldSTGFKenZGUk9ha2xHVFRPNStxUk9nLzJ6WUxNQTdxcDRjVk5JUnk3?=
 =?utf-8?B?QnlhcE1MT0xlcEZFdDdrUXoxK0k4R3ZDNlROMGhOYkFQc0pDa2dYZmhRcWFl?=
 =?utf-8?B?S2RUeUlNazg3RVFON2pVcnhBTGdOMjA0RE40bTRKajJYUTNNSTQzMkJQaGhR?=
 =?utf-8?B?d0x3Z3M0SWFwdWo0ZTkza3AyaUpVcDU0cWhCNGI5SWVRalJnYWNsRmF5QUI4?=
 =?utf-8?B?RUZWSExaSGpPY0xQUTh1RUkrN1lOajcrZ0xGVlV4bDhrdVlzTi9MNk1ZTEFk?=
 =?utf-8?B?WGI1WGovVE12NmtDR1Y0VTNSdS9tS0E0YVJIZStVc01WWStQQTVBSHRSS1pW?=
 =?utf-8?B?MmhzeTlmYjBqUW9Qa29kNDREYUJmdFRBVnZRRXo1NE5yWklyRCtjVDErelVM?=
 =?utf-8?B?L3ZNUHhPVDExVERmUy9BYmNEQVpGSmZYUGgrNktveG1Semd2cjY2OGZXYTlL?=
 =?utf-8?B?WmdBLzgxdHpKRkQ0cldCb2kydk9KUEJrQ3gydTFpUWJaMG95dFVIQzlwZnNh?=
 =?utf-8?B?bzJybUdLYTR0SmRpSHRiNkJRWlBiV2NpZUg0SG9iRDZwbmZiSThoVXhOZGsv?=
 =?utf-8?B?Z1A1Q2dmaytBSU85dW9yVFJBU0FjQ2d0ZjZNWE83Qnc4YlMrOFZ1UmdkU3Bl?=
 =?utf-8?B?bTQxYUtwUnJ0THdmMmVYLzhFaDk3Y3BzS21lMlNVcWl5WGRzVXFkdHYrVFAv?=
 =?utf-8?B?TjlZMVRzaDBvaGY5ZWJSWkNBQ0RsTEZIdS9zdU5mSCtzeGJMblo3eFY1MWRS?=
 =?utf-8?B?QzNVSmFYeDdMKzcyc2c2cmJ4aEpWdjUvSWNIT0NpVXBJQUp1MmswbUI5RlR3?=
 =?utf-8?B?d0haNlB4eXlEZjY5MG13Q09yV2pTT294M0xSS0lISXZPNXNpcWNjb0VWL2NT?=
 =?utf-8?B?bS8wNUdDaU82b3hNVElmdkd4c1VKQlp6OWRCbmtqSHc3WTdJOXB5eTNxUmNT?=
 =?utf-8?B?NW4yUzhRZ3BnQjlnMnYra3hZclQwNS9UcTFrMDA5ZVZWYndHdUREVDRZTzFF?=
 =?utf-8?Q?rjbWuE7gyTUFwgQ6ra98az4=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 72a30a73-8109-4887-4dfa-08db9a4ae455
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Aug 2023 09:11:05.4916
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W6xoBOgWuNZUShy6aqS4aquzo5cBed9f+TQ6OR47SiAaWG6Q7tP+0261sq1npZ9X63F6+46in4UORH2zhCogs71Q2arjOWsJTgifOUaW69E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR11MB6012
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/10/23 20:46, Kees Cook wrote:
> On Thu, Aug 10, 2023 at 06:35:03AM -0400, Przemek Kitszel wrote:
>> Add DEFINE_FLEX() macro for on-stack allocations of structs with
>> flexible array member.
>>
>> Add also const_flex_size() macro, that reads size of structs
>> allocated by DEFINE_FLEX().
>>
>> Using underlying array for on-stack storage lets us to declare
>> known-at-compile-time structures without kzalloc().
>>
>> Actual usage for ice driver is in following patches of the series.
>>
>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> ---
>> v1: change macro name; add macro for size read;
>>      accept struct type instead of ptr to it; change alignment;
>> ---
>>   include/linux/overflow.h | 27 +++++++++++++++++++++++++++
>>   1 file changed, 27 insertions(+)
>>
>> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
>> index f9b60313eaea..21a4410799eb 100644
>> --- a/include/linux/overflow.h
>> +++ b/include/linux/overflow.h
>> @@ -309,4 +309,31 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>>   #define struct_size_t(type, member, count)					\
>>   	struct_size((type *)NULL, member, count)
>>   
>> +/**
>> + * DEFINE_FLEX() - Define a zeroed, on-stack, instance of @type structure with
>> + * a trailing flexible array member.
>> + *
>> + * @type: structure type name, including "struct" keyword.
>> + * @name: Name for a variable to define.
>> + * @member: Name of the array member.
>> + * @count: Number of elements in the array; must be compile-time const.
>> + */
>> +#define DEFINE_FLEX(type, name, member, count)					\
>> +	union {									\
>> +		u8 bytes[struct_size_t(type, member, count)];			\
>> +		type obj;							\
>> +	} name##_u __aligned(_Alignof(type)) = {};				\
>> +	type *name = (type *)&name##_u
> 
> We'll need another macro when __counted_by is needed, but yes, if all of
> these structs use non-native endian counters, we can't require it in the
> base macro. (i.e. not now -- this is fine as-is.)
> 
>> +
>> +/**
>> + * const_flex_size() - Get size of on-stack instance of structure with
>> + * a trailing flexible array member.
>> + *
>> + * @name: Name of the variable, the one defined by DEFINE_FLEX() macro above.
>> + *
>> + * Get size of @name, which is equivalent to struct_size(name, array, count),
>> + * but does not require (repeating) last two arguments.
>> + */
>> +#define const_flex_size(name)	__builtin_object_size(name, 1)
> 
> Naming is hard. ;) I don't like "const" here (it's not a storage
> class). But more importantly, this calculation ("how big is this thing
> actually?") gets used a lot in the fortify routines, so I'd prefer
> exposing those macros (from fortify-string.h):
> 
> 
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
> index c88488715a39..4b788fa0c576 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -352,6 +352,18 @@ struct ftrace_likely_data {
>   # define __realloc_size(x, ...)
>   #endif
>   
> +/*
> + * When the size of an allocated object is needed, use the best available
> + * mechanism to find it. (For cases where sizeof() cannot be used.)
> + */
> +#if __has_builtin(__builtin_dynamic_object_size)
> +#define __struct_size(p)	__builtin_dynamic_object_size(p, 0)
> +#define __member_size(p)	__builtin_dynamic_object_size(p, 1)
> +#else
> +#define __struct_size(p)	__builtin_object_size(p, 0)
> +#define __member_size(p)	__builtin_object_size(p, 1)
> +#endif
> +
>   #ifndef asm_volatile_goto
>   #define asm_volatile_goto(x...) asm goto(x)
>   #endif
> diff --git a/include/linux/fortify-string.h b/include/linux/fortify-string.h
> index da51a83b2829..1e7711185ec6 100644
> --- a/include/linux/fortify-string.h
> +++ b/include/linux/fortify-string.h
> @@ -93,13 +93,9 @@ extern char *__underlying_strncpy(char *p, const char *q, __kernel_size_t size)
>   #if __has_builtin(__builtin_dynamic_object_size)
>   #define POS			__pass_dynamic_object_size(1)
>   #define POS0			__pass_dynamic_object_size(0)
> -#define __struct_size(p)	__builtin_dynamic_object_size(p, 0)
> -#define __member_size(p)	__builtin_dynamic_object_size(p, 1)
>   #else
>   #define POS			__pass_object_size(1)
>   #define POS0			__pass_object_size(0)
> -#define __struct_size(p)	__builtin_object_size(p, 0)
> -#define __member_size(p)	__builtin_object_size(p, 1)
>   #endif
>   
>   #define __compiletime_lessthan(bounds, length)	(	\
> 
> 
> And the way DEFINE_FLEX is built, __struct_size() and __member_size()
> will give the same result (which is what I was concerned about for
> FORTIFY_SOURCE's use of __member_size not "seeing" the flexible array
> members).
> 
> In this case, I think using __struct_size() in place of const_flex_size()
> in the patch series is the way to go.
> 

Thanks! I was a bit too afraid to move it out of fortify-string.h, I 
guess whole family have to go together (to keep related code close to 
each other)?



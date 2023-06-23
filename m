Return-Path: <netdev+bounces-13423-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6830973B8AD
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 15:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 17C67281750
	for <lists+netdev@lfdr.de>; Fri, 23 Jun 2023 13:21:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E820E883C;
	Fri, 23 Jun 2023 13:21:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFF588BE0
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 13:21:49 +0000 (UTC)
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A4DD2
	for <netdev@vger.kernel.org>; Fri, 23 Jun 2023 06:21:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687526507; x=1719062507;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=bDbx6ftrXMpbhCoicu4l8OiKvpNQ1LCaF1WmM8c2/FE=;
  b=h4VABOvXqo1E6cNwThsQZySiV4i94mjDeoMFhRLQUwi8QrTT1rSxIllc
   U5Pq/7dGLIHR6Zn4+VQ29AvljILHSxFRd/n3pmURja9Eg7a7IUm6WckQs
   UnKbzE4sE2VAznaOzY0s/HAGytWZ2Dwa9tTsiAFaADX3vle77oAcXOsO6
   oweCZgKE2QAaZuoCcPW+C0UmV/hED8FR6KLCbKHZOz1SO0nhp4/4HR2YV
   AhTR4ihRz+nq5fUN1AhA7qiHPi2PQa9WFWHs/Qp2+j0WDxZulU/bzacZi
   XV8RBVsuFAOruJm81bSelr+zZt5P4dz3XvFuvozy5niQUbW0//7koDVgk
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="424446018"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="424446018"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2023 06:21:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10750"; a="961960222"
X-IronPort-AV: E=Sophos;i="6.01,152,1684825200"; 
   d="scan'208";a="961960222"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga006.fm.intel.com with ESMTP; 23 Jun 2023 06:21:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Fri, 23 Jun 2023 06:21:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 23 Jun 2023 06:21:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 23 Jun 2023 06:21:45 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Fri, 23 Jun 2023 06:21:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fb/ezbvwq3dzp9UlNcWTgI8vcXua2h8s5ZiKvUmCj6V7ccLQGklJG8ggdyAA+JZBGd86xgHg5jKfGw43VOTta9mpU5KF31DOhLuhjMLwtTv40qkLwBqVpf5ZJysxJn9Ep2mF/Dc1Vn7E0LunNURF5pw/HLznjzAncAlKliikYW8lXJ/4mOsY6mFLjVOf0s2Wq9v/B0gtC7yrM07kZeXsfudSwdl0m+TCeqImW+ILTI6Gd7dhm5rlLHr7WtVtzLYJYME+b1XtF6YBzrktmfdxfbyn+Dvcl3DhNX55s0s0ctFtdNzvGC/jD5Nd7RNJ3Ye/E7cOJw0m5yPhYiazu8GS/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3MQ5zuyYnTm+uD+RtwfTchLGXtEWv1pJBjhVCbijeJc=;
 b=N1Aie6x72JphET8YtQu6Zw87lT2KG6DBowJyS8rf/pvIlr0KEDhxWx58P5ntc1UvNN9+GIkdne9UVoxLX8QmCKBsJUp3VyEli5pOWVPRMwkBtKKMs5puKf6drs9pbZ7jt6DpKrtS5ItbEdl3ApSRY7NVZQzIf53D5khUww4oSmQkzdKkv7yvoS3BCBlFLWYAy90Po9Qf32AzQR0pqc1tp5YR0MTSFSc5+JWtMjhLkkwhmsp9Jezi3F4wI4LlS8AntIqt+KErCVA75qJE1sVl3v3YVtCtA0dVQppQqca9TyYnBb+VFZ4oDWeDgLMXdqVNoFCzbd05/BjXPcbNR2lGOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CY8PR11MB7084.namprd11.prod.outlook.com (2603:10b6:930:50::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6521.21; Fri, 23 Jun
 2023 13:21:42 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::87ad:6b1:f9f4:9299]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::87ad:6b1:f9f4:9299%5]) with mapi id 15.20.6521.024; Fri, 23 Jun 2023
 13:21:42 +0000
Message-ID: <4278f944-57fe-6382-132d-728fa8c8f582@intel.com>
Date: Fri, 23 Jun 2023 15:21:30 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next 4/6] ice: remove null checks before devm_kfree()
 calls
Content-Language: en-US
To: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>, Michal Swiatkowski
	<michal.swiatkowski@linux.intel.com>, Michal Wilczynski
	<michal.wilczynski@intel.com>, Simon Horman <simon.horman@corigine.com>,
	Arpana Arland <arpanax.arland@intel.com>
References: <20230622183601.2406499-1-anthony.l.nguyen@intel.com>
 <20230622183601.2406499-5-anthony.l.nguyen@intel.com>
 <ZJVyiOwdVQ6btr53@boxer> <ffe3bbdf-eb26-5223-c1ed-1bdbaf577d84@intel.com>
 <ZJV+dUvm4Mg1QNeR@boxer>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <ZJV+dUvm4Mg1QNeR@boxer>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MR1P264CA0121.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:501:50::9) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CY8PR11MB7084:EE_
X-MS-Office365-Filtering-Correlation-Id: d9fad0c2-4380-49c3-3b01-08db73ecc844
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X+2fNCRwSrnPZ/ep1yLrvaotl6+M6UltZDv1IQS6dXpOByf9lUly+tqg5S6IOfLB9MO93OM7nP9NRdwzxQnJOesroL0eFcpaSQLe3CplA+wystndpwYnWZO53e/WkXwzOPXpkDT7pu8+pM6TxC4O5p/+8i6LlS9SLkH6f0N10twYos1Nn9isIL3SW2LytJ0eXwVDWhCQXLtzTU4vxKnVyPm3Mz5bZSyp3g7aqCXS/lT+Q3u0Gwhz9nWf22M3LNpgXcrzRT5gYt/UN5C6dbDaOMdG9314Q4pXg4Yyi8VRBVoH3Jmw2H/jL6XGgZo/K2C7PEAYrQXUND1jvUMNHfqCryP14Fq0mV1QIl/xJaNiDXMY8lFU22rVTTleWk2dpnVSbJnNM2RRGiImXyZmRWmiy4Rl4xTQHAFQdkeI3D0V7c5M8v6bEfMXUSlKoNyxuOMZ2YALCp0qEU2YKYNJpetIXDjZUS0f4/LiggkGbLLapARvVtCIN3QWxHa/0IVt7tmENWQR9ImiTDrVO8F5/3/mbN55DDoP1Nbwj3fbQ74WjoOskWNtAv9a/gGXeZLU89sXdwXD7tS0FK33622LQWefra0hJjDSU+S+Gk685w0wM9RHGv/9+4OpsVLG5GrePjM7Bts76qjlmDOx16sU/BAFnzShtuzK+6oAHQelX4tGqt8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(376002)(39860400002)(396003)(366004)(136003)(346002)(451199021)(54906003)(66899021)(82960400001)(38100700002)(478600001)(6666004)(966005)(6486002)(2906002)(5660300002)(6636002)(4326008)(316002)(66556008)(66476007)(66946007)(8676002)(8936002)(2616005)(41300700001)(37006003)(83380400001)(6512007)(53546011)(186003)(6506007)(26005)(31686004)(6862004)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cGtRbGlPWUF5bXRKWWJ4MnNESStoQS9OcGdpZ2dUVVAraWoyM0xnaTRjZ3BR?=
 =?utf-8?B?aFF3VTJCMTB3cVVkbjFmL2NqMmdYaStrcGUvaFdvN0N2MnJCTjlPUmswek1a?=
 =?utf-8?B?dXZjR0tPVll5cWQ4WnJWYlZJRUpIblZRT2lOQXd6aGJzOXZLYUtSREs3M2dj?=
 =?utf-8?B?MTQ5OCtTM2dzWUkrMmJZaXNrRklaQkFSRWxNTXdHdDYveVRJUmFIRS82MjhL?=
 =?utf-8?B?WHpUNlE4ajljL1c1ZmNSamdEVTc5b01uUjlhTVBodHJ2K2tCbGlPb3gvaW1L?=
 =?utf-8?B?TkpmdE4wcHdvZVUrb1ZseWlhWFY2Zmt5a240cGpBQ05mZ09aNlY5cHRZeWx5?=
 =?utf-8?B?a1BTV2ttRCs1YUROYnMzQTNNZmY2WjQ4Q0w1WFlNdGZ0dGtXcVhpcElMaUJh?=
 =?utf-8?B?MEJzOWVIdFI0c3NuYWZtYUg5RGZRK3FoM0NPbU9pRWdRVEUyL0xETW5NUXY4?=
 =?utf-8?B?U0Z0TzhhSzlLUHFpazVidnFLcDFzNitnQ0JYT0kxSVBrYVhqRHg4VE5ZRWhZ?=
 =?utf-8?B?N1ZIUWMzTk80VklpejRRaFlqT05kR1BhWk0zOVlUSEVVVVVoMFlvakw4NnVx?=
 =?utf-8?B?K0oyVVNaYkJGNHFDRE93V1NWSTBZY0JIUVo2MjBybEdvOWdza2pyem5mN05l?=
 =?utf-8?B?QVJ3MVhiSkU3cUpnSkhTR1RlQWlGUFREVVovdGxSYmdicGJMc3dOTGtSMHJo?=
 =?utf-8?B?c1E2cmRsSlo3Tnc4WCtOdlc4dFQ3VUZzV01MMmk0VkRjRmEwVWlkcnVLZkFB?=
 =?utf-8?B?QkV3NWxKV1RodElCTkE5aDRUcS9GaWpUZm1hN2p5aG5SN2Z4R1hrMnZMeVcy?=
 =?utf-8?B?VG41MGYwdEQ1a2p3VlpDZlhoMmErQms3ck5FbmxpT082WGpMK1RaeFI5dTNr?=
 =?utf-8?B?dkEwOW04bitsb045RGprcytBaUxHWUxkOEJlOWIvK2ZGVlJnMFE5dS9uL1dS?=
 =?utf-8?B?WDB0VFNNTE5oUXg2Vmw4cTJTZzVkdEcwdkU0cUhUL3FKK2NUY3prRlhtcXQ5?=
 =?utf-8?B?ZFRTWFlFLzlobU5tWUlwYk9iM3dmSlNBc3BFZjV6akQ4TE9DR1liM1FhTXVR?=
 =?utf-8?B?WlFFaGxBeE9uQXlKWmtPRUlEa3RwTlZGZEQzTjFFRTRHQW5uZVBXeW9VRXVt?=
 =?utf-8?B?a3NId0FoSFBBQW0zTkNIeDRjR2FzME9GaXpLZFJkRmJxTXJVR0xPVnlrQXpi?=
 =?utf-8?B?VENJVjBhYVRVQllmd2IzSVdWalFLU0o3TjVFeVlkNVR1VnIvbHNkOHhkU3JB?=
 =?utf-8?B?enNqbkhnMHFnQkVNOHlWUFpNdnhLVXVVZ0VMNXRLbjBvQ29OTlc4TjJjVVN2?=
 =?utf-8?B?RkgwMGE2VjJSS1lFUG13QTVJWUZqSU5GTGxacEE4UmNiczZYUXFxU3QydDRH?=
 =?utf-8?B?YjlPM3ZPc05GQXlOYVB2WHZsN2JYS3luL2NnNkl0MGVRYno3eTZaUm00ZjVM?=
 =?utf-8?B?eWhJVHZLUDNOOUFDWEQvNmVsRzJBVkFiRlM0dFpYR1ZIeTdUTW5uZXRsaFVu?=
 =?utf-8?B?WkoxWE5rR29QSGEwc2FNWFV0Z1ZZRTEyK0NNZ1NCS3l1S0sxQ2FuUFd6ZDc1?=
 =?utf-8?B?THNTQnAvOFFQR2xON0IxTkx3UXE2M2NtaEFLNzNxN2xWWHNxYityRSs4SVoz?=
 =?utf-8?B?WXM3NU52Qy9xMnUyOG1iWk9adWRIR3NMVDE4dEFyVzlzY3A4eVJsTTd1UGc1?=
 =?utf-8?B?THAxZkhUYmltVVBKWkVRREZBODAxZmc4T3FMckdIL3BVUThlcytMdVlrTzlL?=
 =?utf-8?B?M2JMRzFEdWVBNy9CQVZsMEdsSkQvUjlWKzRiM00wZFY4NzU0bkt6OGZmT2NW?=
 =?utf-8?B?N1NNZkhWVlN4STE0R1UvTmYxMEUwR01WRFJjc3pUL0xob0JsMmVxb29DZG5M?=
 =?utf-8?B?QkQ4RWNhZU1Td1cyKzZGOEpUTVA3MHh5YmROcVp5L1FJSWYvMXZBWnBkclZT?=
 =?utf-8?B?NkJkc0lleWdWcVF1UW9FdUdDTU1tbitvd3c1c3l5ZkZ6NDYvRjJBb08wN0xO?=
 =?utf-8?B?Q1dlMkNDTjNPYTh6dkZRWU1SM0Z0cmNsYnpxK21JNWJ4WVJCa1BNOHJEajRB?=
 =?utf-8?B?a1pneWhTQTk5citNYXZqd0orZjlWVWZ3YkNnbFZlMnNTYzBieGtCQ3ZxWUJT?=
 =?utf-8?B?Z2s1aGw1TUJoNjlBdUg5WVMxZUNwdUsrLzcwOU03aHdwem8vb0hXSEw1UWZr?=
 =?utf-8?B?Q2c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d9fad0c2-4380-49c3-3b01-08db73ecc844
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2023 13:21:41.6229
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OEnvJm/gbqnt23dbAb6Vbb+wrOWbCSu5mv+MrE7FNOXAcwZTtoL3uxA2O9v2bDaUxT25Qn/NECbKjYp+LbpWKzbjOQwHoZrIuMe6qrHpIrM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB7084
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 6/23/23 13:13, Maciej Fijalkowski wrote:
> On Fri, Jun 23, 2023 at 12:44:29PM +0200, Przemek Kitszel wrote:
>> On 6/23/23 12:23, Maciej Fijalkowski wrote:
>>> On Thu, Jun 22, 2023 at 11:35:59AM -0700, Tony Nguyen wrote:
>>>> From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>>>
>>>> We all know they are redundant.
>>>
>>> Przemek,
>>>
>>> Ok, they are redundant, but could you also audit the driver if these devm_
>>> allocations could become a plain kzalloc/kfree calls?
>>
>> Olek was also motivating such audit :)
>>
>> I have some cases collected with intention to send in bulk for next window,
>> list is not exhaustive though.
> 
> When rev-by count tag would be considered too much? I have a mixed
> feelings about providing yet another one, however...
> 
>>
>>>
>>>>
>>>> Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
>>>> Reviewed-by: Michal Wilczynski <michal.wilczynski@intel.com>
>>>> Reviewed-by: Simon Horman <simon.horman@corigine.com>
>>>> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>>>> Tested-by: Arpana Arland <arpanax.arland@intel.com> (A Contingent worker at Intel)
>>>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>>>> ---
>>>>    drivers/net/ethernet/intel/ice/ice_common.c   |  6 +--
>>>>    drivers/net/ethernet/intel/ice/ice_controlq.c |  3 +-
>>>>    drivers/net/ethernet/intel/ice/ice_flow.c     | 23 ++--------
>>>>    drivers/net/ethernet/intel/ice/ice_lib.c      | 42 +++++++------------
>>>>    drivers/net/ethernet/intel/ice/ice_sched.c    | 11 ++---
>>>>    drivers/net/ethernet/intel/ice/ice_switch.c   | 19 +++------
>>>>    6 files changed, 29 insertions(+), 75 deletions(-)
>>>>
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
>>>> index eb2dc0983776..6acb40f3c202 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_common.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_common.c
>>>> @@ -814,8 +814,7 @@ static void ice_cleanup_fltr_mgmt_struct(struct ice_hw *hw)
>>>>    				devm_kfree(ice_hw_to_dev(hw), lst_itr);
>>>>    			}
>>>>    		}
>>>> -		if (recps[i].root_buf)
>>>> -			devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
>>>> +		devm_kfree(ice_hw_to_dev(hw), recps[i].root_buf);
>>>>    	}
>>>>    	ice_rm_all_sw_replay_rule_info(hw);
>>>>    	devm_kfree(ice_hw_to_dev(hw), sw->recp_list);
>>>> @@ -1011,8 +1010,7 @@ static int ice_cfg_fw_log(struct ice_hw *hw, bool enable)
>>>>    	}
>>>>    out:
>>>> -	if (data)
>>>> -		devm_kfree(ice_hw_to_dev(hw), data);
>>>> +	devm_kfree(ice_hw_to_dev(hw), data);
>>>>    	return status;
>>>>    }
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_controlq.c b/drivers/net/ethernet/intel/ice/ice_controlq.c
>>>> index 385fd88831db..e7d2474c431c 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_controlq.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_controlq.c
>>>> @@ -339,8 +339,7 @@ do {									\
>>>>    		}							\
>>>>    	}								\
>>>>    	/* free the buffer info list */					\
>>>> -	if ((qi)->ring.cmd_buf)						\
>>>> -		devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);	\
>>>> +	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.cmd_buf);		\
>>>>    	/* free DMA head */						\
>>>>    	devm_kfree(ice_hw_to_dev(hw), (qi)->ring.dma_head);		\
>>>>    } while (0)
>>>> diff --git a/drivers/net/ethernet/intel/ice/ice_flow.c b/drivers/net/ethernet/intel/ice/ice_flow.c
>>>> index ef103e47a8dc..85cca572c22a 100644
>>>> --- a/drivers/net/ethernet/intel/ice/ice_flow.c
>>>> +++ b/drivers/net/ethernet/intel/ice/ice_flow.c
>>>> @@ -1303,23 +1303,6 @@ ice_flow_find_prof_id(struct ice_hw *hw, enum ice_block blk, u64 prof_id)
>>>>    	return NULL;
>>>>    }
>>>> -/**
>>>> - * ice_dealloc_flow_entry - Deallocate flow entry memory
>>>> - * @hw: pointer to the HW struct
>>>> - * @entry: flow entry to be removed
>>>> - */
>>>> -static void
>>>> -ice_dealloc_flow_entry(struct ice_hw *hw, struct ice_flow_entry *entry)
>>>> -{
>>>> -	if (!entry)
>>>> -		return;
>>>> -
>>>> -	if (entry->entry)
> 
> ...would you be able to point me to the chunk of code that actually sets
> ice_flow_entry::entry? because from a quick glance I can't seem to find
> it.

Simon was asking very similar question [1],
albeit "where is the *check* for entry not being null?" (not set),
and it is just above the default three lines of context provided by git
(pasted below for your convenience, [3])

To answer, "where it's set?", see ice_flow_add_entry(), [2].

[1] https://lore.kernel.org/netdev/ZHb5AIgL5SzBa5FA@corigine.com/
[2] 
https://elixir.bootlin.com/linux/v6.4-rc7/source/drivers/net/ethernet/intel/ice/ice_flow.c#L1632

--

BTW, is there any option to add some of patch generation options (like, 
context size, anchored lines, etc), that there are my disposal locally, 
but in a way, that it would not be lost after patch is applied to one 
tree (Tony's) and then send again (here)?
(My assumption is that Tony is (re)generating patches from git (opposed 
to copy-pasting+decorating of what he has received from me).



> 
>>>> -		devm_kfree(ice_hw_to_dev(hw), entry->entry);
>>>> -
>>>> -	devm_kfree(ice_hw_to_dev(hw), entry);
>>>> -}
>>>> -
>>>>    /**
>>>>     * ice_flow_rem_entry_sync - Remove a flow entry
>>>>     * @hw: pointer to the HW struct
>>>> @@ -1335,7 +1318,8 @@ ice_flow_rem_entry_sync(struct ice_hw *hw, enum ice_block __always_unused blk,

[3] More context would include following:

          if (!entry)
                  return -EINVAL;

>>>>    	list_del(&entry->l_entry);
>>>> -	ice_dealloc_flow_entry(hw, entry);
>>>> +	devm_kfree(ice_hw_to_dev(hw), entry->entry);
>>>> +	devm_kfree(ice_hw_to_dev(hw), entry);
>>>>    	return 0;
>>>>    }
>>>> @@ -1662,8 +1646,7 @@ ice_flow_add_entry(struct ice_hw *hw, enum ice_block blk, u64 prof_id,
>>>>    out:
>>>>    	if (status && e) {
>>>> -		if (e->entry)
>>>> -			devm_kfree(ice_hw_to_dev(hw), e->entry);
>>>> +		devm_kfree(ice_hw_to_dev(hw), e->entry);
>>>>    		devm_kfree(ice_hw_to_dev(hw), e);
>>>>    	}
> 
> (...)



Return-Path: <netdev+bounces-22988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 848B176A4FF
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 01:48:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 42D762815E3
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64AF71EA8A;
	Mon, 31 Jul 2023 23:48:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520EF1DDC1
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:48:42 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CC8910EB
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 16:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690847320; x=1722383320;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5v9GRyDg6nb7W0EFG5SOTTdVaRH09vd8K5jiwHVa0O4=;
  b=dzc7GF/WzsxhN+KAKA4c4CyY4M27eeLv1QlZ0rQC9lfX6kwvvC8/Yoeh
   K/BlQy0LipcSKPWAd+1kkTUf4BRJ5bWgPOF8SJB6+onVbPklRmrjjMtd1
   oTNn67UpMENfHnJlLm20PBvvuqTrq8xMmjGraxugWmG4zEi3WErX2vXjm
   KV2wC+SJBp6z/DciEr8CBo6LhVLFTnRp+Mclzlg6DBTEsaBiCbTKfGBzY
   EyQp7f1rzqTF9Q9ayIqoJUW4LPJF1kz4Dv48IhL2HnwrzkpQSd4F4FwXB
   HHypI7LqSjJtagNVrKNXx9S4cMHh0qv8yCueHMehh7bJMnyCOpnAv3urR
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="400104984"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="400104984"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 16:48:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="842485297"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="842485297"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga002.fm.intel.com with ESMTP; 31 Jul 2023 16:48:39 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 16:48:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 16:48:39 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 16:48:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lMUSb8YMhx/phEKjBUuge7GuJImXJh/LjTWifGYqbGAKUrNNb1mcuzKuHm+lqk8XsxBxfTIAE8DS9EymUmrm71ceVtFyHyUi1A0o1eQDo3LwLeebYz7dsx2mjRPYoV5AOLUzCy8q0KEQWdEk0XdiF4DCwCXxSSlimVXKAHsWLsjU4fYHuppYIonowFtSNy+D+zcqbYdFyibDhRlUwNxdYEEm/j9QwvRqgtY8uCPZsG0Ud+ZH+4+ffInhZahHceN63rRWM1gftrq/VabfONrHKPWVrL7vrD4ugHlqtzSAVVYXJbtK17lAK9fsJ8eg0Kdxd1nNS85jN5hrtqQKsleQdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4oDgXhZ8Us5ewIGXRa2gdVi8GgwcjeJET9qOiT4qqRc=;
 b=R6pCu7TUq2EvsZ8IjhQc4ZVD1tUCv3LHcKHCdmqO8pvxWOy4vsYNxKlMgKeXSOTCgLjxD6Sk8F64JAh7j3S+8M4ei1aew6HcLomljPyjcso+XDlKyxwNKT/Nw+1lDQoMKu3Wd3thQ58JOMXlpCwum+bhIbSdGj8GfIOWisA9d7tbXVJEvPKG5zP7SjusDwu7EGpVW/Oa9+8Qak2KQFX84Kb7AgIga79J9+lwizmXUQUEi5RG71wiuvkhwwGOcLrbwI7f+h3/3w5DolMbDn0EYyuU7C7qzslb6SjkqLiAUIJcx/rWNAfjEp34nQOVJuVRLNKpB/604304LobhRsgjEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by IA0PR11MB7355.namprd11.prod.outlook.com (2603:10b6:208:433::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.42; Mon, 31 Jul
 2023 23:48:32 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 23:48:31 +0000
Message-ID: <32e32635-ca75-99b8-2285-1d87a29b6d89@intel.com>
Date: Mon, 31 Jul 2023 16:48:27 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next/RFC PATCH v1 1/4] net: Introduce new napi fields for
 rx/tx queues
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <168564116688.7284.6877238631049679250.stgit@anambiarhost.jf.intel.com>
 <168564134580.7284.16867711571036004706.stgit@anambiarhost.jf.intel.com>
 <20230602230635.773b8f87@kernel.org>
 <717fbdd6-9ef7-3ad6-0c29-d0f3798ced8e@intel.com>
 <20230712141442.44989fa7@kernel.org>
 <4c659729-32dc-491e-d712-2aa1bb99d26f@intel.com>
 <20230712165326.71c3a8ad@kernel.org> <20230728145908.2d94c01f@kernel.org>
 <44c5024a-d533-0ae4-355a-c568b67b1964@intel.com>
 <20230728160925.3a080631@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230728160925.3a080631@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0066.namprd03.prod.outlook.com
 (2603:10b6:303:b6::11) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|IA0PR11MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 2dda2383-13fd-41ea-0037-08db9220a547
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hxLJy/dXP4gx9nxgDkoLB3YavufA5OaBnZQG8dR8QMi1yT0ffbQB12bskxUrE7oBNy9yHHIrq+0kYCDi9H1irryM5O9vCdxFw+RQeKu3+aYk7W5vgiPfg5TXKd5uQCcuuT6hAO3LoG/fXawbSOndmrsl9fshiNRyVd+HW8EsPH8PssNt3xvtfLfUwy+MO0t7vjeAg8/Cs4AFZud5RMNgENOImC4dZwWERBG2fndN77XXCy+WJ7QRG5NfUG1dTUQHrstQUCt71LSl1tTNHXZfCrtT0CvF95ZuP0TGtAqDZfecU2sQhHcvIOLcCg9hCYMQ7MXv/LubFoo+j/clxzsjTFAKxblmbOcXkAia8ObYxlPmL58PDLA/Vi8AnCdBws/aJ+154JTLeRUr6dCrFkeEuN0ocdYqu/P4NGUuNxz0ho54jIw7m5MbNIJmBGmxhuddUT6YV5TxWLuwUNVzrGDoo0TDUutzw1IwfvS/rEl+o7AO6w0JDoPU3PFRaWomJztMlGDpTvdXaJN6YMdffcb0pq9kR9u5tTXC35E9SCe97R94J9mT39+RoyrGDIIymRHuwttPEOoAO3gfdCzGMRWa+6EPeCYdSVasfn/sbzW5XsbD+t/xZE1ZPQoCxQ/8BDiN1UeqMGgKoUCDF1AJWg1J6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(366004)(39860400002)(376002)(136003)(396003)(451199021)(6512007)(6486002)(36756003)(2616005)(53546011)(6506007)(26005)(83380400001)(107886003)(186003)(66946007)(66556008)(82960400001)(41300700001)(38100700002)(31696002)(86362001)(66476007)(316002)(5660300002)(6916009)(4326008)(8676002)(8936002)(31686004)(2906002)(6666004)(478600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SnZmRlFZckY1SnF3ODVRVk5JOVNIWGlNQWg4cmxBMmx5RTI3Wm5jbGVrd0gz?=
 =?utf-8?B?ODlpZGlrNjAxS2FXcVVZQkVYNTFvbUZZOG4yV091alRtMXJZa24zZ3dpdkdq?=
 =?utf-8?B?aVIweVhrVlhtVFBiOWQyQ0MwUDZEWWtMRFBDZkhBZjA1L2grZG9qZ0xETitq?=
 =?utf-8?B?YWpESVBwTW1zWkN4eWJUUWNvTkQwYnZZSDBqTW9KVW1oc1RIQStzMTNiS0lC?=
 =?utf-8?B?YW5xbVhPektwZXFwYkM3MnNpcEg3NFIvQ1dvQWNQMDEyRVZLd1J2QVp1U1Bv?=
 =?utf-8?B?dTJ3NTFoUGY4RTNCR1MvRGRUTjhaaDMvaDdFVkxQWHpLVVhWNGFaVVpQY3pn?=
 =?utf-8?B?VnA1c2dCNTJZWVRzdkJxeXk4eGdKcGU0WXZGQkRsK1N0R0pqMTFLZk9FVkZS?=
 =?utf-8?B?ZDJYVmhRQlhtNU56Z3dZZE1lK05oT2VkL2FqSmFoMzVaUXBCTFlMT1l1MUI4?=
 =?utf-8?B?ZzZnbUZSc1MwUUdjWkNjWU1sVHBLMldDeVRGakFKakdVMXcyNmJIYkRtVTc2?=
 =?utf-8?B?Myt4K21NYjhSak8wcjBaVlFwR1hnR2tpMnB4dEl1NE0yTWtrM3Q4ZFN3OGlp?=
 =?utf-8?B?S0l6VVVoKzc3YlR3WGtXblJuN2xUSnZnWjRWQVV6L29HL2VSd3BQbUtMc1J4?=
 =?utf-8?B?STE4d2xraHFydVo1bHVHM3FJb2lqRGJ0NStyOXNEZjRUK1ZlMFlBQWFabnhl?=
 =?utf-8?B?YTM0U21wanZlZlkxc1JNVGd1L0ZXY09yVVJvLzZHOXB6V3IvQUxDWTc5dENN?=
 =?utf-8?B?QThJMlBQRkh5MGZFZEYvd2UxV2pCYUdud002TmN4TEpBRFRFM2xQRHpQY3B4?=
 =?utf-8?B?eGkvK2VyRXB2dUhaclVCei9TZERJakN2QWROTmhiNGFrdlhLc1JFblVFaWRa?=
 =?utf-8?B?MWNZYUtVYmVMNEZTaTVNY1lVZ1FIVTgrVzVBc0pIWXFEck1nblZUR2FZNmFH?=
 =?utf-8?B?UVNDNjk5ZE00cVJ1SzdRWHJ1d2Z2Y3hzSzllQjBBdjVpWlhUNG1xNWhnQVhX?=
 =?utf-8?B?Z2xEWTJ5MUsxay9yeVBKdXpzMU1UeVd1dEpFdXJ6RFZOSS9xS2J1RytDOEgz?=
 =?utf-8?B?c0FiWE82YmRIWHZkWGFYc0RxWlBQdmVUSWxzT3JzV1hBazgrSTJGN00xRTdK?=
 =?utf-8?B?bERSOTJzZFNPVm5pU1JTdGxzb0lTelZTLzBxT1VnT1FsNkhieTMvM0ZrODhX?=
 =?utf-8?B?TzN2eS9mUnJjSTM2TnV1L3ZyRm9CTWl4VUNFNlI4U0xxQmFoYTRIdVVWQ2dJ?=
 =?utf-8?B?WmtTOFZVNlJqVHIrdEFIbzQ0ZThicU9TWHE4ZDg2eEVXK2tUWElqUW9oRWht?=
 =?utf-8?B?SFVML3cxeHZSZXJlaTR6b0xyNTg4c3E2a1hkc3gzSlBBNHFISlh1bFNhUUJt?=
 =?utf-8?B?b2VMVnQrampvaUVWYjlWT1dWUkNaa0F1VVZpanJSMXlTbXIwQmczOWgxcWlQ?=
 =?utf-8?B?RklNbjhFY0dNOWtPWDRmL2RkSzBITDdReTRLL3ZFVEE2L0J6cHFGYnplOEhi?=
 =?utf-8?B?U09lK01zdmlxLytkb093U3d5SDVXWXpYS0RqMmpCMHVjdTQ3RDZtRDZYbDJK?=
 =?utf-8?B?OXZwUXZnSWRrNWQ3amtKNEJBbWp6NXNIV0w2cFFGM0kvTUV2VjgzMUExclor?=
 =?utf-8?B?WVYwKzJ5S2pQY21ZTG1jMkRLY1NGWmFCRDZLSU5VL3RjVGswelp4MlFBdUhT?=
 =?utf-8?B?VXdlTEsyNGE2S1JFN3p3MjB2ZUV1djV2eEMxWDBqWGw5by9UUmN5TVE3UFYx?=
 =?utf-8?B?UlFPV1kvcUlYbFpUQXRySWZzemJlNUdaSmkyaEp0eTdkZ1pDc2FjYjI3dkpp?=
 =?utf-8?B?aDBPcFJZeWhYRVhScHU2UG1RM0NBVG9iWWFXc1Z3TGtJalBGbUhJUjdRMWZt?=
 =?utf-8?B?NXovT1dYZTQrMHZyR2hPVzR2bnNKNW9SQXFwZERHcG00d2NFbjBRZjlIbk85?=
 =?utf-8?B?M0lCQnZDbzlKNGNpMFMyaDMrT1d0TVNwT2pFN2VlWGJtajBwQXU3QlBqQWdE?=
 =?utf-8?B?Znh5Skg1cWZIKzFKcFJ2c0J1RHd1U0VlN2xNcjRwc1E5citSOEFybEx4NlRM?=
 =?utf-8?B?WEhzVmRWR1UvRjFNQk0zcUl2L21uai9RRnBMZlYrSnpLcHM3UE94aVZXWjlh?=
 =?utf-8?B?Yk9NbEVpVXZES1ZoVElJSUM1ZWhwLzZNakpjUVZOdzdCYlpkN0NsUlJPNGhJ?=
 =?utf-8?B?dmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2dda2383-13fd-41ea-0037-08db9220a547
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 23:48:31.4307
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: N5MNcdJWgtUee0ryJnta2axojY7iRt3OcSX7ktTZGUE7TSGbsa3zrTIC88deaw5QTQNvH8BTIq6hCq1uYkCOk1w0KigBoM4nIfmWHOiyuQg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7355
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/28/2023 4:09 PM, Jakub Kicinski wrote:
> On Fri, 28 Jul 2023 15:37:14 -0700 Nambiar, Amritha wrote:
>> Hi Jakub, I have the next version of patches ready (I'll send that in a
>> bit). I suggest if you could take a look at it and let me know your
>> thoughts and then we can proceed from there.
> 
> Great, looking forward.
> 
>> About dumping queues and NAPIs separately, are you thinking about having
>> both per-NAPI and per-queue instances, or do you think only one will
>> suffice. The plan was to follow this work with a 'set-napi' series,
>> something like,
>> set-napi <napi_id> queues <q_id1, q_id2, ...>
>> to configure the queue[s] that are to be serviced by the napi instance.
>>
>> In this case, dumping the NAPIs would be beneficial especially when
>> there are multiple queues on the NAPI.
>>
>> WRT per-queue, are there a set of parameters that needs to exposed
>> besides what's already handled by ethtool...
> 
> Not much at this point, maybe memory model. Maybe stats if we want to
> put stats in the same command. But the fact that sysfs has a bunch of
> per queue attributes makes me think that sooner or later we'll want
> queue as a full object in netlink. And starting out that way makes
> the whole API cleaner, at least in my opinion.
> 
> If we have another object which wants to refer to queues (e.g. page
> pool) it's easier to express the topology when it's clear what is an
> object and what's just an attribute.
> 
>> Also, to configure a queue
>> on a NAPI, set-queue <qid> <napi_id>, the existing NAPIs would have to
>> be looked up from the queue parameters dumped.
> 
> The look up should not be much of a problem.
> 
> And don't you think that:
> 
>    set-queue queue 1 napi-id 101
>    set-queue queue 2 napi-id 101
> 
> is more natural than:
> 
>    set-napi napi-id 101 queues [1, 2]
> 
> Especially in presence of conflicts. If user tries:
> 
>    set-napi napi-id 101 queues [1, 2]
>    set-napi napi-id 102 queues [1, 2]
> 
> Do both napis now serve those queues? May seem obvious to us, but
> "philosophically" why does setting an attribute of object 102 change
> attributes of object 101?
> 

Right, I see the point. In presence of conflicts when the 
napi<->queue[s] mappings are updated, set-napi will impact other 
NAPI-IDs, while set-queue would limit the change to just the queue that 
is requested.

In both the cases, the underlying work remains the same:
1. Remove the queue from the existing napi instance it is associated with.
2. Driver updates queue[s]<->vector mapping and associates with new napi
instance.
3. Report the impacted napi/queue back to the stack.

The 'napi-get' command would list all the napis and the updated
queue[s] list.

Now, in usecases where a single poller is set to service multiple queues 
(say 8), with set-napi this can be done with a single command, while 
with set-queue this will result in 8 different requests to the driver. 
This is the trade-off I see if we go with set-queue.

> If we ever gain the ability to create queues it will be:
> 
>    create-queue napi-id xyz
> 
> which also matches set-queue more nicely than napi base API.


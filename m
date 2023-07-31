Return-Path: <netdev+bounces-22977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1114F76A466
	for <lists+netdev@lfdr.de>; Tue,  1 Aug 2023 01:00:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 332361C20D95
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 23:00:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3D321E51A;
	Mon, 31 Jul 2023 23:00:24 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69A42F3B
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 23:00:24 +0000 (UTC)
Received: from mgamail.intel.com (unknown [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2166E4E
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 16:00:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690844422; x=1722380422;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=/ef79gREvGZzv9wLj7p5wm37o7nfePIG1ZqyKjqA4n8=;
  b=TTffdXZJxV5KPH3tieVXctPn0vhn32dIPFpCR67Nqor8QFHqSi/LN0Os
   WKuHhlvKgBOeCGACpi4kUxJS6hl8RH4sg7OkD2Wcxfh5Xu9Dkq/egHjZs
   MH5XzatwEpUDqIQ8kUppseZ9JOgp2OS9WZ7AWu1EbK35egSgazyS7wQ9u
   AgB5pEteggkgv1Z1JKRlnNpCUw6VeylGnWxp2Uu7iABmHgDDqocZ+5hwd
   K8M+XqhoclaaTjINqcugu9NSGSz9yCujwsmmuV6Ufjf+OjIVXNePj5N7w
   da0qhsO3yAX2E8BP2h1Ri7ltvoJYLXrdnnHb/MKY4E/09JuDU26zmnSZp
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="372765809"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="372765809"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 16:00:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="678475363"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="678475363"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 31 Jul 2023 16:00:10 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 16:00:10 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 16:00:09 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 16:00:09 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 16:00:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WeqUNLtJj2BsodqoDQ7UdzbT5HzlKqkMjvQUUu/lvV3qyKUHQXzwqh0/Ah9Em1C/inK8BVHRg0veuhezmsk7V5DQryBPwrTAhQXSietx55CknuZ+mIOitf1ozmjv7YdTfLkLqGE/8GnS0h4N2zikb8lMgv5plcgsz0nVBJWDjNlwNemETzLP/k8HQAxowLO5hmtln9iR4fo7KP0w2OgKl8gWn3JZoULdkW+T5W5vOyLp3oUkpmQwNeyWJjlQeaT6nx/jFCs0D9YUXQETIe6q+0FINRZMLvsHlh0bpYCh+UKHq/hYifrq5YD7GvZVuM/J+MyVCGPqFhNSDQOGebiYmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=93qrutyHyzsNH41mZLCtdlYry7kqXh/DejczvRmp0To=;
 b=hSMq9MpDxKinstuBUvnBpnwIoCCTDv2XPR13O3VMLfStXGzeet46A0Knzn0LNswP/Be8WvNwaOpC5SXInq5sMH9AHZfueRfAaYeXqwjOXW2y18byM113zlB+C7OcASCesUzkAbb/9bvfz+y9mpnsu6F7ficEsVJMGJotYnr37qPC9OfnwSeaG46zhQayD/7pSAQNjDeQpCLL4nW0jo4uzeLb0EoyNErPyQ0D3aNSbkGg+MBbcEb8RXwfvHWM1gvW5X/BkndUdSAjOgWQ8/VCu4iDDEompyoIlmAGjIWgP8aI5mhZb1+ELvVTT1aNMCbRy9zI1QqatsWiRkgVzTv2zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM3PR11MB8670.namprd11.prod.outlook.com (2603:10b6:0:3d::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6631.42; Mon, 31 Jul 2023 23:00:08 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f%6]) with mapi id 15.20.6631.043; Mon, 31 Jul 2023
 23:00:08 +0000
Message-ID: <577e7669-2750-cf08-4382-db865a1c57c1@intel.com>
Date: Mon, 31 Jul 2023 16:00:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next PATCH v1 5/9] netdev-genl: Add netlink framework
 functions for napi
Content-Language: en-US
To: Simon Horman <horms@kernel.org>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <169059098829.3736.381753570945338022.stgit@anambiarhost.jf.intel.com>
 <169059163779.3736.7602272507688648566.stgit@anambiarhost.jf.intel.com>
 <ZMaaztfofIy7g9Qx@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <ZMaaztfofIy7g9Qx@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0163.namprd03.prod.outlook.com
 (2603:10b6:303:8d::18) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM3PR11MB8670:EE_
X-MS-Office365-Filtering-Correlation-Id: 1cd3eaa3-8533-42aa-f7ce-08db9219e2d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uyxYmVQGdpkbvYBeuxTHOBXiJ1NIDSuX8I6HYR2DpnXIw73UQ5UMZ99fTGRDe6qLhIPdPlaYWDSnSn0aTXi5bW4cJlgVoVWFuZrClZ0cGJTQPY2xz5W9xbk+716qr03GbVSJ53iXb5Obxm/beamm4AFL5j9HAUE0fd7lhvI0R5PpyzdMjhWi2Ty3pcG3VBAsDwRVuateQUJ+t2UV61i8SL5C08E44NOqe5uX6TjtjuaXw+UycM0PURlapvO/bxxEmRAQzo2pSCTBMnRFEDaUlOjG4ggN4q3jlB5ZPOTSeSlPi9HU51G83TyLCKD2/nNA4xFZDtyAAt0nuEw/P3+B9QY4ooTBgYjPEL4pcPPGEpYJr95Ut/FwTRNT9Bh0iwPC74LIrT+dVehwVsFilUhAcIeUzLlBVSbqRVep4Vo5+eZ0gQkl7xMxBrxh+ZpAOgTywK8srKRAHALXmSstbKGgTR6jXW1tWUFRyW2KMOkEPwcpsM0/TNl5dSVihGu8IXKG1dGKVjLxSvhzA6ghF+42ica15Rl3+XBucmMdZ0VtQyATlOMXaFUYHlsyoFv3eqxvThaR0KMXceU+LuEgwWXogQoZG+bfErw1wVcU0ILnfvoVNbVIgm5naP9uBMNVostPf3ZQsX5Fa7vftrsOepgxeg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(38100700002)(86362001)(66476007)(31696002)(8676002)(8936002)(31686004)(5660300002)(316002)(4326008)(6916009)(66556008)(66946007)(82960400001)(41300700001)(478600001)(2906002)(6666004)(36756003)(6512007)(6486002)(107886003)(6506007)(26005)(83380400001)(186003)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aXllSmc5L2VzeXBwMmhCQWpWUXM3MXg5QytHVzU3ampNaEJNSE1mOXlrNmVF?=
 =?utf-8?B?WDJzTGJUOWlqSEt3Ykt6MVlzbEV6c3VIWTRzTjgrSmxUWlFObEdKR1J0QjZZ?=
 =?utf-8?B?b3g4LysyNG5hUDZqTjluVTVyVUVuU2hSRm5tRlIvektWSVlzdytuY0JUSDlm?=
 =?utf-8?B?WWZabTl6Ny9oYzNJRytCRnRWaEhNTUJ3S2RNclkrc3ZWT1ZvMGVRM3JINkVp?=
 =?utf-8?B?bGgrTjdYN1MrRGtPeGpiRFl2YkRDc3B6aE81ay9IWEhCVm9ES0MvalBETyt4?=
 =?utf-8?B?aFYwNmtvTzZyb2p0MGdvOXUySkdkRFRlOTVndkVvamJtcnBnMEtITmQ2YlNQ?=
 =?utf-8?B?UzNWNGNkRGo0UlFsYkozK3VxR29nTnp3NHR4Y21ZUWYraXpoOGJtaUN5OFZ4?=
 =?utf-8?B?UC82eU1LMlJPUWJOc29TTnFUWitzMnNXZUJ2M0FCWkF2QXZtaC9OcWcyeUpV?=
 =?utf-8?B?QSs0OVplQktMVzRXSUdHZkRvUk92ZlplSjNYUWZKa3A5akN5VmhMNkI2WDJG?=
 =?utf-8?B?b1F6djViTGN2LzhJSG1RdmFURitQeC9sWXQyNXVnU1ZDZlMxVDhOWE4xVWlo?=
 =?utf-8?B?MnhlMk1tWlpzbjNxNzdjYlVrWllQQ1dEUWY3TnB5Qnd1dHl0UmJabFRWV3Vz?=
 =?utf-8?B?dFRMajJuckZsMlJzS1l4Zjd1cHpyZjRWQTZqTEt4YmljN3pMTDdHZ2s2RHZt?=
 =?utf-8?B?MGh1S3V1MkM5RHNuR2dKSDVTQ2liUnFBNlhNYWMyQnlaLzh6bFFoV0gyZ3R2?=
 =?utf-8?B?RjFHaVJ3L2FWekZIQnRsTGpDNmFJSnJPVTR2NkhCSTNlSzdENmFpaEI5T2I5?=
 =?utf-8?B?YUVoRHV5RzI1TW0wV2FodEZVNFg4blR6NE5hMTlPdUE3UThaMnpJOW9vYVdD?=
 =?utf-8?B?dDB5eTZKQ3RacE13NmlaSWk5dUFONHVZZGl3anpEWnBKdlU5a0g3VVdOVmlT?=
 =?utf-8?B?RXNVaUpVRWQ2RHVWYllZY2crTVNaWVBpSWNINGtySVhNNVM1R3pjT1huQnRL?=
 =?utf-8?B?dVJnRnRaWklaSDNrRVBLRXRqME1Xd1AybWRmRkZHdVRsU015K2E1YVcrSTBw?=
 =?utf-8?B?MXg4QmU2Ymo4cUgzWDlhdE1hWThyQklXb2hlMW81L3NrUGQ0ZXZabG10REM2?=
 =?utf-8?B?QVkwOFVPV2hZYTVLVndQNVN2UENKMjh3NVMwYkNkeFpwUE5zVkVTRHJmLzBI?=
 =?utf-8?B?NEp4aGN0MkEvenlCY1hROUVtYWVJQnBJNjhqYXM5ZlZYUFU5aHBiZ3NxWms5?=
 =?utf-8?B?Ry9rZi9HZno4b3d2ZzAwQk52bkkybFgrMFB0RTRDcU9vMmZSQkJZNytKazlZ?=
 =?utf-8?B?TkFJelU0NGVueUVKOXJtOG5KT05QcUlPZnBRMTNKNXZScG5yVmp4STBENUFK?=
 =?utf-8?B?d0xKWDlJUVN6dG9wZVJ6eHgxQ2J4cUlaSnZBczZ4RG9pUVA4cStDNHppU2VH?=
 =?utf-8?B?NnE1SFVBVHN0Umw0OFVhcmIzb1psSUlGZ0tVWDFLc0tnaDdZOXdWWjBnK251?=
 =?utf-8?B?NTZoUzNPOHBiZ0RCYjFBNDFtWGtURVljOTJPMUNrbVp5VHVOZlRpRGpYUXFS?=
 =?utf-8?B?WDlyWHdhU2dRL3Yxc3lqSVIrS2V3UVdyNTc3eVpsaFV1YlBnWVAvUktsUzQr?=
 =?utf-8?B?S0EzOHg5eUNGWGdaZ1lCczQzWERiNWU3azRQc1VYZW1UcXFqMkZGeVdZWFdB?=
 =?utf-8?B?QkhsUFZCdHFxbHJrbWdRYk83SFBiSHd1S1psakNVam1NeENKMGZaZjYrMElU?=
 =?utf-8?B?ZjVjOG03UG5kWFhHNFlUNmIwVHZOZkxSNGpxTFh2MzBNV3dTSmhuMFFaMkhC?=
 =?utf-8?B?cWV0NnRueGsyaGJKQlc0NkJyQWUvcCtVRTBtZjVQWElLZ2FmTEdXNWtNNmZv?=
 =?utf-8?B?YVlYaERZT2dnV2NxMXo2QWdrN1g1WTAxVjZSVDFlUnFwSWw0RlpDN3VQU1Ex?=
 =?utf-8?B?Vm9JMTdXMHZzMlhrS0FPUjM3bmlaN25icVpieitvQzhzclp3eW12VHR6OGhs?=
 =?utf-8?B?ZWtRa0c3cEdPY2J3SlArKzlIS2FhYmdEQ01oSkFIZXRlSWxZa1YrTC9CdW5K?=
 =?utf-8?B?TldVUEx6ZUVEeXl3SVlNNEdwYnIyOW85dCt2eGQ5QWhhelVLK1BObW5TVTNJ?=
 =?utf-8?B?WHFvOVc4OTg4aG1iNktEZGFtSmpSSGoxa21hT0E0ZCtKdUlybUxoMW5Pdyta?=
 =?utf-8?B?dWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cd3eaa3-8533-42aa-f7ce-08db9219e2d0
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 23:00:08.2121
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HJGuCO04Fz84/nQue0IQR3bUZeAxHvVQiBNOdw6QZ1cOh586dN3WR65Z2eQDEeyEyShX6ORmhCaL/fgazMo9uaO9ath0gmhjIJT79ZYZNMY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM3PR11MB8670
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 7/30/2023 10:15 AM, Simon Horman wrote:
> On Fri, Jul 28, 2023 at 05:47:17PM -0700, Amritha Nambiar wrote:
>> Implement the netdev netlink framework functions for
>> napi support. The netdev structure tracks all the napi
>> instances and napi fields. The napi instances and associated
>> queue[s] can be retrieved this way.
>>
>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
>> ---
>>   net/core/netdev-genl.c |  253 ++++++++++++++++++++++++++++++++++++++++++++++++
>>   1 file changed, 251 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/core/netdev-genl.c b/net/core/netdev-genl.c
> 
> ...
> 
>>   int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct netdev_nl_dump_ctx *ctx = netdev_dump_ctx(cb);
>> +	struct net *net = sock_net(skb->sk);
>> +	struct net_device *netdev;
>> +	int idx = 0, s_idx, n_idx;
>> +	int h, s_h;
>> +	int err;
>> +
>> +	s_h = ctx->dev_entry_hash;
>> +	s_idx = ctx->dev_entry_idx;
>> +	n_idx = ctx->napi_idx;
>> +
>> +	rtnl_lock();
>> +
>> +	for (h = s_h; h < NETDEV_HASHENTRIES; h++, s_idx = 0) {
>> +		struct hlist_head *head;
>> +
>> +		idx = 0;
>> +		head = &net->dev_index_head[h];
>> +		hlist_for_each_entry(netdev, head, index_hlist) {
>> +			if (idx < s_idx)
>> +				goto cont;
>> +			err = netdev_nl_napi_dump_entry(netdev, skb, cb, &n_idx);
>> +			if (err == -EMSGSIZE)
>> +				goto out;
>> +			n_idx = 0;
>> +			if (err < 0)
>> +				break;
>> +cont:
>> +			idx++;
>> +		}
>> +	}
>> +
>> +	rtnl_unlock();
>> +
>> +	return err;
> 
> Hi Amritha,
> 
> I'm unsure if this can happen, but if loop iteration occurs zero times
> above in such a way that netdev_nl_napi_dump_entry() isn't called, then err
> will be uninitialised here.
> 
> This is also the case in netdev_nl_dev_get_dumpit
> (both before and after this patch.
> 
> As flagged by Smatch.
> 

Will fix the initialization in the next version.

>> +
>> +out:
>> +	rtnl_unlock();
>> +
>> +	ctx->dev_entry_idx = idx;
>> +	ctx->dev_entry_hash = h;
>> +	ctx->napi_idx = n_idx;
>> +	cb->seq = net->dev_base_seq;
>> +
>> +	return skb->len;
>>   }
> 
> ...


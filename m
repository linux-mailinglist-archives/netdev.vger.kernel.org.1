Return-Path: <netdev+bounces-30164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D1979786420
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 01:53:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFC911C20CF5
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 23:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494DF200DA;
	Wed, 23 Aug 2023 23:53:53 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384261F17F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:53:52 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1F010E3
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 16:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692834832; x=1724370832;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=TtyMp7UogLShPkdSODLusHB5PzZExGRBxTaSPbGg3GA=;
  b=cBdoxWFvcwn0sU0/ut3lHoseA2BcpjWRmF4hUBcdvVk0g7nVtRag6hcU
   dds8AeW4ckHV+APHKDNhsDqW9NjT5gi1Z5A3SktTTJt3D6e5uT7AKBTtZ
   ROJa9sGXjwbn5MJ+eqcZzBqi7PywVT4/bRnqKyE7LTPBrEhqrRffLGeo1
   3qYTd2Aw8oLmRKbHCOzpkr9zKd+Sbpnd2xGQkshB9plBkaHWR5Me/3fAG
   BD61pKQg5z7crhVATTkqrXqpSP4dpUd5A1vqXH3GyUWTTVkF1gjlKWkL5
   Upxne1T+VxMQ6wbolvRQbwTs/FQu6neVTdrYWz4oyRr7qwyWsbskiaaGD
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="378053948"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="378053948"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 16:53:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="713761195"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="713761195"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 23 Aug 2023 16:53:51 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 16:53:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 16:53:51 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 16:53:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=OVQmRqr8jD9VRz+idmiSz+jImijcXE6E8HEa5h3IzbowIys1SFFkmrWbNRTjtTyZ9rJo3+C1i6qY0cmeQy0KjutKzYm9J9GxwFnb6CDjkBbb4EkbhdOyrd3tvc5YT89wo1aaPXmC7B+2XmITbXbSGhPBaoTY+e6fnrk9awfK46TzcYvv3hkkAHuGl24JKclp9gR9QD8VTQqNNRbJFxn+xgPZmyUubxA1wuC9Dk3IBCPfrUfMNhxSei60kj9+W5jnRcUHEhvffDnXXO305s+/ks1etTKw5CWR+TclfAzLhHzt7D0kIKDuJ13a2kMFOMfZ37amWjJqW7RdGNRd3QXsRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kR3GAX16PxV1gfkQQWMIRQ6F+bSEWKbn0tEM0mfOZQ8=;
 b=DhkN8wlnyYu2tiIPSfH1bM0HA5cPyq/QoYhD6JoLQUzjlE/s96ky1e0ypQEgRmD1M3RKiplFNygrspE0duiaihHbEujHMVDDaRQq3xILd4Nr6PGsmdIv22ttmQ3MbyFCNg35VbHRl078Gu1bnVW2eXKTcWbfKRxcQmsBsibB7xzTaCPvdIsPfsd3XzwM7S8cNxl+0ZstdkQW9IBXJeSIStDAGYSU3L6VZ1nvntBM3wPHkq+nlKJKhMxsDHPOYhEvG03anP+Ly6pNOU9dL3H5y2xw8Xc49IvLv2FdOAvJO//7BlnjzKBjQqkbpS1u5zKevyg9Elu/jjib9kLyzkY4HQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by SA0PR11MB7159.namprd11.prod.outlook.com (2603:10b6:806:24b::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Wed, 23 Aug
 2023 23:53:43 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f%6]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 23:53:43 +0000
Message-ID: <0712fad6-bebd-4c9b-9ab7-46c0aa0ea02a@intel.com>
Date: Wed, 23 Aug 2023 16:53:39 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v2 5/9] netdev-genl: Add netlink framework
 functions for napi
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
 <169266033666.10199.3744908214828788701.stgit@anambiarhost.jf.intel.com>
 <20230822175111.78d4fe32@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230822175111.78d4fe32@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0320.namprd03.prod.outlook.com
 (2603:10b6:303:dd::25) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|SA0PR11MB7159:EE_
X-MS-Office365-Filtering-Correlation-Id: 1de20871-360a-44bc-b89b-08dba4342ede
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xnIe9szMBPoedQsVLZTcfJizONhTs4Pl24MtV2bbJWdBtfCZemUqyO1Rk3cwjCNrAX3mPuM5IRcnxclZwptY/SQquUdCqPB1l0k6rNnvbKNW1HEw/khPbBqTpNYijUJROQZAise2JFed7NC3CS0wuv38DtOTm5oe6/+IxaT1MlN+4q9TgPStmdwrnurvZON6psLqy3jSUt3mkEmVv1gfOXSsKuoNaqSbsfVjUcbS6jszUrexklPc/S4T3F5iCOcdcEQZdgvX4lJsMavASZ2AShMvCyTEspt3K5lHz2Jj7qy+dZkyK5fktxBp9k2ifa8rIW5bn9kHnIoJNvmm5Gwfevz9OnKqTAQFCnMoWUhlCh93yHbEZSzMBeXk1uMdE4ELdS8vLeWYRcD/RynXmfFbdlnsFBewOrrlmAEDUx/5QDebDru3+GHSL0SxoK4gHHeaCjz6AAGZcz7IpMUxb5ZWuJtxJpZamIg0xukOHlTz4dOgu9MkCgffuGOuoWwG6QFnvlIXqIJbNv4+QQxuw7IpG4RFxIPEqI6k6ERImhS47Y7ArIHLFaf/DSQzMw+hy54GMtTsBthiO6fy8LyAmhJli/Y/P8/TY9UDglX0oISd2RVk7MSc0XRYS4qRA2ZxEnDgEtDZx0IjFBaG8YNIjXsi2Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(39860400002)(376002)(366004)(346002)(186009)(1800799009)(451199024)(66476007)(6916009)(66946007)(6512007)(316002)(66556008)(82960400001)(8676002)(8936002)(107886003)(2616005)(4326008)(36756003)(41300700001)(478600001)(6666004)(38100700002)(6506007)(53546011)(6486002)(83380400001)(2906002)(31686004)(31696002)(86362001)(5660300002)(26005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MnphTDhRSi8xd3NXbkpTd2lwd2lDWGdZaUREMkhGTlQrTUJoM091U21DN2lI?=
 =?utf-8?B?Mm1Gdk5ra056Z2hNVHR6cEZYemUxeUxhUVQ4MG9UaEdYRVlSd09semZ1bWpY?=
 =?utf-8?B?aE1JbFVaVFJUOVJWWkZNazB3N05sZUt3OXNxUWlaTVErU0gxZDExTHRSZ0I3?=
 =?utf-8?B?RVcrTlNPKzFQSXQ2VHplei9iN0szYVlKQTlsMXNlbmh0MWJERm1oNnYzaFp4?=
 =?utf-8?B?TkxkSU9tT2drNXZTckxQL1pTa2RRSFMrVEdLV20vc2FXdjh1TmpCTGk2UEkx?=
 =?utf-8?B?WTFOV0NCVmk3YWtiNnhGSzExY2dTdktRWEQ1Vm1UOW50aDFabjlHTHEvSVB0?=
 =?utf-8?B?c1J4ZWoxVFY2bGU0aFRha0ptbEE3Z3NqNDcyZzFMcEM0blBrWlBxUEM5MytN?=
 =?utf-8?B?clBXNnQ4UExWeVFMQU1iNGMxYWszUHpBa0ZaV3RjMWsxKzNKZFdSeWRINEcr?=
 =?utf-8?B?S1RnRzMrRU5qTGdLRk10QjZIb3RZSXV3ZGEzOUMzS3lpVUNKeHNsT0lmc1Bl?=
 =?utf-8?B?UzlRbm8xMWN3TzFPbGE4c1p4Sm9lUE9JdmhvZDAwb0FtOCtwcHErYklzN2dF?=
 =?utf-8?B?aG0yZXVUd240blAyMDhFY1IvNUpOWjJnZE4vZDlRUENUNVBqbGM0elhYRWxJ?=
 =?utf-8?B?dUZWVTlRdllyZVJvQm8wOEZ4bUk2UTQ4K2FhNlNnM0JuRzZySWMzRmVWUUFw?=
 =?utf-8?B?WWNiblIyYXBqYzRMREwzdGllQjFpZ0NlVVJNbHV1b3IrbUZBNnNvb1BlTGVp?=
 =?utf-8?B?cDl1QzZJeVRPYWVXUERQU3NLUE1Ia3Y1aEdsaG9DU0lQVytpNnR2SXp1OEU1?=
 =?utf-8?B?K2xjUlFuQnBaR2F1ckVETEZibHl3SUpPR3pkQWNaMnZLZTMrMFlna04vcFVN?=
 =?utf-8?B?bVRwTXJrcTNUNSt5RjN6czV4U1pyRmF5dTJIMk1oY2xETnQxYngrVWpVMTll?=
 =?utf-8?B?ZnJpVk9WQ0I5VGd5dVpZTDJablpmTHFRYlZJcFRnWFdWZmgyWFNaYzIyYzhv?=
 =?utf-8?B?YUJRS1dFUDZHd1Rjb21jV3Z6S2dMamZXZmd4dWc5WjI1VStHQldOSFFMNkxT?=
 =?utf-8?B?dnRUNUNrTGxlVFFkd2w5YllyZVBtY1hJWXc5T291VVFyWXRCTG5zd3FjK1g2?=
 =?utf-8?B?ZW05TUwwWU4vWWZhUWNVekFUT1g4T1dxTWNyTGRyVlJ5aGMzQU52ejZ0KzhG?=
 =?utf-8?B?Vkdob0VURTF5TG1TK3Azc3BPU0JtdkttZ0dndUhxSHYrU1lVQ0h6NCtwTDZC?=
 =?utf-8?B?SDUyVkZXUDdTV2J5SWtiazhybFljQzhrdVlFMTV0Vk1UWGV6YUdabkVkcFNY?=
 =?utf-8?B?ZmlWcFFuODRxSk5RamJCUk5qNTd4SGQ3VjNmR3dZZFBxaDRkdGhGKzhiMlRx?=
 =?utf-8?B?eHFlbVdjV2tUOFVnVzVNWjVucDhUcWdIUFh3WklSL3VLUVFObmFYeFlpR0o1?=
 =?utf-8?B?RW9GenFTeXpFWjBobFJRSnVHWkhubjZSYXdJY1V2d0ZpOUlLL2QxRzZvMGFP?=
 =?utf-8?B?cXBKS0ozUmk4K1VSdE5DK0gxdWxLTGVOa2ZaRDVFb1h6anFDZXBUNEJHWXFX?=
 =?utf-8?B?eEl3eE5MeVV0bm9NNFJlUmJJa1dsODRHb2N4Ris2QStyZW9tN3g4Q0hMMHZJ?=
 =?utf-8?B?d2M3ZCtkTXcrY1ozblpYMXNpN0FOVitLb3QxUFlqT3Rja0lkUDlTbjRHV1NS?=
 =?utf-8?B?enpOaFlvNG8xUDhwT0dnV29KQ2NKc3lKbmRnTmVFUEFoVldEZVBnR0s0M1pZ?=
 =?utf-8?B?RkJTYXowaHo4QlNYSXp0Zkc0cUxhcmVvaU54NFVMcnA5bHVQMCt5VEZTNS81?=
 =?utf-8?B?dUxseDlRMmU0ZFQ5ZTVsTlpyR2Y4NUw5VE1WNHJxS01FY2VYYVhmeEdFYTJ4?=
 =?utf-8?B?T2V4anIwOHM5aTFVMW1CcnpFTnlIeU1MVGc5UjZQaEhaeE5naTRtRXBWRGJO?=
 =?utf-8?B?K2tHb2dPNWRjbXI3ZGVIQ0hPeTdwOXJHU2RVZHk4SFBzekZSWWlvbmI5UDE4?=
 =?utf-8?B?eTVuZXpIZ2NubldaNFljbmlsM0txTXk5UXJSMzIrUUVlZU5Fekx3SE1sdjdJ?=
 =?utf-8?B?K1gxSytqRXdFMFpyUUlYWCtiZHhuRW8xa3U5RHgvRUgvNW1adnlJZWFkdE44?=
 =?utf-8?B?YU0yQ1lsSnJ4anczcnhaZ1VuMS93UU5NTFJtWjFrN0VrK01maUt0TUNIYkZZ?=
 =?utf-8?B?REE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1de20871-360a-44bc-b89b-08dba4342ede
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 23:53:43.6866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: H7ypvMkDF1AfhBmAz+6+m81JYGTjcy0Me4Nm9P8wiRvVB2Q5zgdNQjuOtQJ741d05d5oOCC39hqEmHLRwcVoFn5AzFmADTBIsCpQLxyCgmE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB7159
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/22/2023 5:51 PM, Jakub Kicinski wrote:
> On Mon, 21 Aug 2023 16:25:36 -0700 Amritha Nambiar wrote:
>> Implement the netdev netlink framework functions for
>> napi support. The netdev structure tracks all the napi
>> instances and napi fields. The napi instances and associated
>> queue[s] can be retrieved this way.
>>
>> Signed-off-by: Amritha Nambiar <amritha.nambiar@intel.com>
> 
>> @@ -119,14 +134,158 @@ int netdev_nl_dev_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>>   	return skb->len;
>>   }
>>   
>> +static int
>> +netdev_nl_napi_fill_one(struct sk_buff *rsp, struct napi_struct *napi,
>> +			const struct genl_info *info)
>> +{
>> +	struct netdev_rx_queue *rx_queue, *rxq;
>> +	struct netdev_queue *tx_queue, *txq;
>> +	unsigned int rx_qid, tx_qid;
>> +	void *hdr;
>> +
>> +	if (!napi->dev)
>> +		return -EINVAL;
> 
> WARN_ON_ONCE()? If this can be assumed not to happen.

Okay. Will fix in v3.

> 
>> +	hdr = genlmsg_iput(rsp, info);
>> +	if (!hdr)
>> +		return -EMSGSIZE;
>> +
>> +	if (nla_put_u32(rsp, NETDEV_A_NAPI_NAPI_ID, napi->napi_id))
> 
> napi_id can be zero.

Will fix in v3.

> 
>> +		goto nla_put_failure;
>> +
>> +	if (nla_put_u32(rsp, NETDEV_A_NAPI_IFINDEX, napi->dev->ifindex))
>> +		goto nla_put_failure;
> 
>>   int netdev_nl_napi_get_doit(struct sk_buff *skb, struct genl_info *info)
>>   {
>> -	return -EOPNOTSUPP;
>> +	struct net_device *netdev;
>> +	struct sk_buff *rsp;
>> +	u32 napi_id;
>> +	int err;
>> +
>> +	if (GENL_REQ_ATTR_CHECK(info, NETDEV_A_NAPI_NAPI_ID))
>> +		return -EINVAL;
>> +
>> +	napi_id = nla_get_u32(info->attrs[NETDEV_A_NAPI_NAPI_ID]);
>> +
>> +	rsp = genlmsg_new(GENLMSG_DEFAULT_SIZE, GFP_KERNEL);
>> +	if (!rsp)
>> +		return -ENOMEM;
>> +
>> +	rtnl_lock();
>> +
>> +	netdev = dev_get_by_napi_id(napi_id);
> 
> Why lookup the dev and not the NAPI?

Agree. Will fix in v3.

> 
>> +	if (netdev)
>> +		err  = netdev_nl_napi_fill(netdev, rsp, info, napi_id);
>> +	else
>> +		err = -ENODEV;
>> +
>> +	rtnl_unlock();
>> +
>> +	if (err)
>> +		goto err_free_msg;
>> +
>> +	return genlmsg_reply(rsp, info);
>> +
>> +err_free_msg:
>> +	nlmsg_free(rsp);
>> +	return err;
>> +}
>> +
>> +static int
>> +netdev_nl_napi_dump_one(struct net_device *netdev, struct sk_buff *rsp,
>> +			const struct genl_info *info, int *start)
>> +{
>> +	struct napi_struct *napi, *n;
>> +	int err = 0;
>> +	int i = 0;
>> +
>> +	list_for_each_entry_safe(napi, n, &netdev->napi_list, dev_list) {
> 
> Why _safe()? I think you need _rcu() instead?

Agree. This is called within rtnl_lock. Will fix.

> 
>> +		if (i < *start) {
>> +			i++;
>> +			continue;
>> +		}
>> +		err = netdev_nl_napi_fill_one(rsp, napi, info);
>> +		if (err)
>> +			break;
>> +		*start = ++i;
> 
> Why count them instead of relying on the IDs?

Makes sense. Will fix.

> 
>>   int netdev_nl_napi_get_dumpit(struct sk_buff *skb, struct netlink_callback *cb)
>>   {
>> -	return -EOPNOTSUPP;
>> +	const struct genl_dumpit_info *info = genl_dumpit_info(cb);
> 
> You can get genl_info_dump(cb) here, you don't use the genl_dumpit_info
> AFAICT, only info->info.

Will fix in v3.



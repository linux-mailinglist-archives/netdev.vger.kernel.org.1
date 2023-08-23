Return-Path: <netdev+bounces-30165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E74BA786429
	for <lists+netdev@lfdr.de>; Thu, 24 Aug 2023 01:57:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5E482281378
	for <lists+netdev@lfdr.de>; Wed, 23 Aug 2023 23:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32BF0200DE;
	Wed, 23 Aug 2023 23:57:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2116E1F17F
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 23:57:12 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 160A410E4
	for <netdev@vger.kernel.org>; Wed, 23 Aug 2023 16:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692835032; x=1724371032;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=WA23h/1IhKPorYRDOCdol0qmBYiadxtYsrpHFKYSLrc=;
  b=HRJnx52E8SAXxBD9Nplhep+eg+3snnFFYtI3Xko6DwB2gz30Q841CMNC
   1j06g/LmGlq6hEICbf3gTI052kkD4yLSegiV7M+p6ykEMwetN0YobG+PB
   rym2WPwmyNVppArzzgl1Rrz4k+MXt305MrSk3Uir8gmHRxV5iS9vvqbfW
   KW5xy/mDRDpd1h8hfbwa9iT+LNAY8mK14KCpIYJeUw17G3IWHHw44+iXO
   HuIdbEW299sOArRF7pDhYn1VuGb5h4I7sFqQo1mcV7C3ZmDABU7hdcF7Q
   gpo5SsHhg8qx0bh4U+jMZIdMHAcBGATMZ9BRn0cI1TX6l/s/bvonHzJi+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="359288187"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="359288187"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2023 16:57:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10811"; a="686653955"
X-IronPort-AV: E=Sophos;i="6.01,195,1684825200"; 
   d="scan'208";a="686653955"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP; 23 Aug 2023 16:57:11 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 23 Aug 2023 16:57:11 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 23 Aug 2023 16:57:11 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 23 Aug 2023 16:57:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eu3a5IpPqKIDDHfPF/e8imeBqVxZDXtVVp0NEZJb6Zv08h0/UeL1NVittGfBQUzrqSydF39mnWGcnh8rT0WNH68mG8NVsak2fH4+DKLJvbHjf1+UmeC7hDM+l2whLCJChU12SWqUTwaD94p0aSDUrUA/OjvdDN25n9vsxOX/1aYMnfHiGNpbxN7l0rZIgsj+Bpiwywupl4KBKS5Zg9T9+y8KhI44Z2yY0ZVvQ9ndna7QLiw2l3w/VWftVsiJD8rKyRN/qQo7VO9jksKS4V3fL2Oir0sBXzH14frKb0K0LFkOrxe2xkZd3aNpE0gExZrXCgzlitt9xBsBm+8ZQ1HFfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eh6ZDA+hdioZvjQXbjYhF6idLni1Zl/K1TtWsubA/pI=;
 b=OUzIY9Do5+6fWQxnKjKaQX/zViUwl4H12xLWyaLykQE73gnyXIbg8KDtkfA2E5W827UuTeaXrCiXRSuPrNhwNG9SioZy6+v+7+4GVa7VPTXEHO1n8JNo5+u44ZE9HAMZfBn46S9PPrfvWzON9ysEmYWMfbPnwAxIqh7oupnmDsKR1Jgie6B2hj8TtqhvXRgYm5u9a0uRsQfV5HzE7itBlVs6viR2lwjqun4sm1QDe2aHQaijrtYXZkQ9yf+LMSAryfZZYoekpHtbSS3os7ENqo4NpNJqFHh8ABlvd7QvvXgHWqNu2QlDcnDz7NpbZze8yrfSraaWmSrIlDc1sZev8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by SA1PR11MB6847.namprd11.prod.outlook.com (2603:10b6:806:29e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.25; Wed, 23 Aug
 2023 23:57:07 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::12e4:637d:955d:a5f%6]) with mapi id 15.20.6699.026; Wed, 23 Aug 2023
 23:57:07 +0000
Message-ID: <55913edd-4bea-4056-8fd8-75e5bb97f6c6@intel.com>
Date: Wed, 23 Aug 2023 16:57:03 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v2 4/9] net: Move kernel helpers for queue index
 outside sysfs
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <netdev@vger.kernel.org>, <davem@davemloft.net>,
	<sridhar.samudrala@intel.com>
References: <169266003844.10199.10450480941022607696.stgit@anambiarhost.jf.intel.com>
 <169266033119.10199.3382453499474113876.stgit@anambiarhost.jf.intel.com>
 <20230822174022.6fa412ac@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20230822174022.6fa412ac@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW3PR06CA0013.namprd06.prod.outlook.com
 (2603:10b6:303:2a::18) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|SA1PR11MB6847:EE_
X-MS-Office365-Filtering-Correlation-Id: d097e385-6a83-4443-f760-08dba434a804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9egVogEV7o/ZL9RX30xHLqKMgXUY7A60BPQcUBbISN99fCgtxLWGSleWtnZVkT8BeXPFkkAwqyipRZ8JXRfJnxTDayeDC/p2gYZRBp9zIEBKUlqjib0m0J8WAR7cGYG2Cul6juKyXK2zss/nU7r3uwfsy/Sp0Em1UGPyo6ICW8jrqxAK0THp5L3JfDIgBfZLohqTgBPVdQXrq/mxxopj6BzVmHuGdnFJWd/F39UrwMcqYWuDVeremo+zfk6nTroPIQfNJg53Osuc0CmY14XQcBaLz1QqxKEDpb/Mq74gbgM5NCp64dPEdZo80teftoLbEeq/GHETBsuf/FgjaakNHWuKo75bqyGkGWbbFnoYVQb/0TtAEPPRdG+Jb0w4+KIChvChsnGfxU7hla9JlukB3Fb/g+emBWt/P0/dow2t4QMiYtl8LAiCAD687pcJFfSQEl5F9O264n+xt9Ni8kzAwLxFNc+EBWXQgmd0aQZ2USWxxNMAJKXM5zp+Uk106k4oV4r0Pw/tGzbtpmn3U1Mmrx9BJwuglL5iGqg9mKBpIpbvqT67V1s+9ZzyRkJHR9Ml4u1fN+Oy5Q3Z0cW7FUr4oON8dOrIP4wzhr6GIIbj9WX1hMFLisDlSdOGrxrSMTlfo0pKWvs7V1Hqev6IHb1UuQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(346002)(136003)(376002)(39860400002)(366004)(451199024)(186009)(1800799009)(31686004)(6666004)(6486002)(478600001)(38100700002)(26005)(4744005)(2906002)(53546011)(6506007)(107886003)(2616005)(6512007)(8936002)(316002)(31696002)(82960400001)(6916009)(86362001)(36756003)(5660300002)(8676002)(66946007)(66476007)(41300700001)(66556008)(4326008)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YTl1REhsR1QzRjNVSmFRR1JUbjltaEpZVzZzcXZMN2xkNDNLVzlPcVpnY1Z6?=
 =?utf-8?B?Z3V3ckdjMmdRdWhuMHhNN3A2aTlXZEhSY3hIaTNDMXVXRUh1ZmlMdjVRQUFF?=
 =?utf-8?B?WnZkRFFuRWJzWmxUTllMOTE2QUs1dC94bjdRTTBNTWM0TUVteExmTGExb2sr?=
 =?utf-8?B?dlVTbHQ1aDVnQ3ZVRVptRTZidlZlVWRhdzhpczYwcWpZclRZZCtjK0ZjMmtj?=
 =?utf-8?B?NldMb25IZHJ2MXR5a0VtY1Y3RnkrTk9pcW9uUW40UWE4TklDMEFLc3V2bE4r?=
 =?utf-8?B?Z2lsRE1WZWZiKzVUYTJKY0lBc2N3Q0pjYkRRMHpQM2ZqSTVvVE1ORTdjdXM0?=
 =?utf-8?B?c3pNOXYvSDRlS0NCM0wydy9hNi85c2xSWXA4MmY0UFBzTHM3Z0xrRW1lajFQ?=
 =?utf-8?B?U2pPRDhST2hLa1RJSU45RStyYTZTVjIzeDAzOTNmNWlSdmU3M0xGU0ZDbTYw?=
 =?utf-8?B?NHRyQWFUdzhSNDhFQThPREo3OS82NDBRak5JdllVVTZ4elhZMW42MU9uVEFR?=
 =?utf-8?B?eWdwSEJNc1JoTk1nNVRsYXNvbUMxVytiWnVjNmVydUxndVA1a2I3enFaOWNs?=
 =?utf-8?B?QUxTdENSbjdiVVR6T2FsOHNSTE9xaXpvMHd4aDRxWHVaQjUzUnJ1dWhpWUp5?=
 =?utf-8?B?WHN3Q3UyZjZMV1BEcjZMVUtqOGZwQmZDODR5WW4xM2lQeVo1L1JRM3dxdjBC?=
 =?utf-8?B?eUE3R3d0aWxvRjgrT2ljOFRVWE9qZitMWFMyc0p5QnVwdXNoNGhhV1VUeExH?=
 =?utf-8?B?Q2xqRGw4dE5FeEhsU1UreWsydnFPTjVwanQ5MkM2UEpodWV6R09wVCs1eDJJ?=
 =?utf-8?B?MHJ0ZWpGdWJ2djNjZUYyRm11aWtyWmhLNEpPSjFKc2x1RDBORXRLQUN0em5C?=
 =?utf-8?B?OWtmNXV2bUYzTGtZWVpCZTZUalpPQWgvQncwWVlIak1jQkFaNTBQNUFSMTRz?=
 =?utf-8?B?bVF2RHY5TFNYc2RXUTZYQ0xFWktBRWlWR05vODU0eW01K2tQaG1sZnIxOFht?=
 =?utf-8?B?dm9rbU12RWhCZGVhVzVoaytmSmVNd1A5STFTWHg1bWpjRVVaY1FVRVpRZVJ3?=
 =?utf-8?B?dEg5Uy9lZkpTMEwzOC9NSTB5bVA0R0tVQTYyRmFYbEc4RkJ5UW5acHQxYnMw?=
 =?utf-8?B?eExYSUcvSWlxZUN5TmZJV2N1Z0FreGpGSDMzZ3gzbzc4di9WbDJUMWJNaHlx?=
 =?utf-8?B?bTdCMWtwUTdlVGFJcUEwVHVpazVqZ3RMOUFMQS9qM015YmR5dVk0dmRHUFR5?=
 =?utf-8?B?em9ybDhGdk1XMHN4dkk0UVp0QUNJT3lnVG01U1ZkcHF2cTJHL3hiK2tlclZi?=
 =?utf-8?B?M255aDd6ME1aNDcvZi9IV3QxSWxuQkRabTYzM1ppaFNJY05nb3NnZ3BWaHJu?=
 =?utf-8?B?TWJXNnpHNDVTZms3Z0NvVXNEa1dQcDJleHFnaHhVWEdkTjdJMFVCWVVWbGFC?=
 =?utf-8?B?cGt0MEk5L2RVWEVRWlJNRmExeGZlcHc0N1RzMmxSeVlDakhQejZXeXR6NmJQ?=
 =?utf-8?B?d2haVmtFRHhPVUNiSzhWalZRV21wS0tlQmpaNnpERmFXd0QzdDloTjdkSmE1?=
 =?utf-8?B?bHdrd1NGcUFkSWtRc1F4YUlwTERMcktmSzRLVk82WHFXaVhxOWpYOFBkT1g4?=
 =?utf-8?B?dWRmTW9DWVJHdXI2YUNCZEc3TTVVejJFYmk3TVRyTnJvMlB1NlViTFZLRGJp?=
 =?utf-8?B?cjVmcWdQMENITkpYMHdqWURRZ29NUm5jb1ZWSEh5MWlwejVpL2xzY25YT1JY?=
 =?utf-8?B?Z3hxOE83Q0pTaktwUGt4RVVmdS91QTJOK21nSUt2R0xMdjJ6MjhQM1JmS2J6?=
 =?utf-8?B?YllGQThFdjA1U0JYZmN4Q2ttSDJJVDQ1a0pQbm40U09xVHYvNXExUXM4clRJ?=
 =?utf-8?B?M3ptWnh2MjJIQjlwVUFHbm8yaHd4Qmd1QlBtVWcwbnFRMC92MFdGUFdxcDFj?=
 =?utf-8?B?cTlvcGhLQTVtSXVWRElNQkExSFR0L0NSNm5GZWZqVit6L2lHV1ZDTFIwbncx?=
 =?utf-8?B?ZXFkZ2dMc0k3RXk4TzhLOGJheVNXRGpZTTh3VFhzQlkxQUFpWi9IMlB0T1ZQ?=
 =?utf-8?B?THlCcEp4ektqMGFXbFVrYU9tQ0hKbVlBZm9PV0xvQ0VMWmJrQklXalhDOW9m?=
 =?utf-8?B?Qk02cGkyUkFvQk00SUtrOFd1V2hFTEFoOFlzM0w0SCtLRmtrSmZjUGZmMVBU?=
 =?utf-8?B?TWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d097e385-6a83-4443-f760-08dba434a804
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2023 23:57:07.2437
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1LJiPTRMMtOA2ND07sc7JQ/mlc+t1z7twHh7vwGcv1Lgnc81hy+rA2XoldGv6cnJ/qVBAClYTztKJ5JWbezJuy5dsk6MMYZBIgdQFQJBvgQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6847
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/22/2023 5:40 PM, Jakub Kicinski wrote:
> On Mon, 21 Aug 2023 16:25:31 -0700 Amritha Nambiar wrote:
>> +static inline
>> +unsigned int get_netdev_queue_index(struct netdev_queue *queue)
>> +{
>> +	struct net_device *dev = queue->dev;
>> +	unsigned int i;
>> +
>> +	i = queue - dev->_tx;
>> +	DEBUG_NET_WARN_ON_ONCE(i >= dev->num_tx_queues);
>> +
>> +	return i;
>> +}
> 
> If this is needed let's move it to a new header -
> include/net/netdev_tx_queue.h ?
> 

Okay, I'll submit a separate patch to move struct netdev_queue out of 
netdevice.h to a new header before this.

>>   static inline struct netdev_queue *skb_get_tx_queue(const struct net_device *dev,
>>   						    const struct sk_buff *skb)
>>   {
>> diff --git a/include/net/netdev_rx_queue.h b/include/net/netdev_rx_queue.h
>> index 66bda0dfe71c..ac58fa7c2532 100644
>> --- a/include/net/netdev_rx_queue.h
>> +++ b/include/net/netdev_rx_queue.h


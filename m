Return-Path: <netdev+bounces-51678-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8867C7FBA28
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 13:31:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AB8341C2132D
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 12:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0401019460;
	Tue, 28 Nov 2023 12:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y2KVf6vk"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4733D59
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 04:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701174667; x=1732710667;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CHU/aD8nmmqxHGjrmo0LCiinfm4DNuz+yCMrJNHJwIQ=;
  b=Y2KVf6vkMH2f9vkXAqfXQ88bVyOywhltnwRSjySkTwbZQbmozuDyMYiq
   pQmCH2SELZ0UpU651nQ0ZcrdbHKMNrf5h74xGA3MYuHwmyI4Jr7zJmjaD
   43AxW9OYy2qM+16yrYwfvZqdmHUpA4ic19y3qVkdfH13qZD2an070As6w
   bNMWJ7D0S5R2UApYbLKHX+elsfq0HyW82RWP1OFhRXZxtYQOAyejMdRPL
   l7idUavHrwEtwKq/Yig3x/fo0cO7zG4TjOPso2QzHOiFQVxZLPT+btTaA
   4rOKUVhAwNfgebazK/sZC6RuIk4yibngaWJt8oECE3e+xOCe20OYWNRQ3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="392663426"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="392663426"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Nov 2023 04:31:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10907"; a="761913956"
X-IronPort-AV: E=Sophos;i="6.04,233,1695711600"; 
   d="scan'208";a="761913956"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga007.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Nov 2023 04:31:06 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Tue, 28 Nov 2023 04:31:06 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Tue, 28 Nov 2023 04:31:06 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Tue, 28 Nov 2023 04:31:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=i5/HSbAc5szcI6S0E72b0au+cVIwdrre1oNVkPswI/FWDJpkCp57y5CT46hSz+qFFHXXX+/7p2OeyuTRp0UaKF0VotJPIenyxRbCRnMmTsiG47+HvyV9yCAsB9zueKB3lJNLMTs6oQxogsb7TsO/zp/pm3wIc3HhaGNo3UZP/3EG32ztE3UA76zhrqKakgQBLHyHxRPTyWpGl42/by/+7M/CqOGPKrkpLave1C8v+TOCQSxQIFvyWGWfSMXLHthjrDI5fg8HPK/VkodKwatmmLXoTfXs1FARbb0P425GEnxnXd4i+e3gRdyqCzmdpBdziuxP0dCy3p5NIc4bpjr2kQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zxrsVyWgyFeov7OlwddgmrISTBsijzPEMTQwlAFL3zA=;
 b=iuKTw76aCB4m1k/5FZyyoyQ5BVlQJZnpE0r4Xyz6ylSUHzMkCprzzNn4YrKgmyH9KsHqek70N+sYGtb9PVW1qSX5b2JW1/S3g6ggF8e7D4f/Nhvd1g4nlQAlvmkB+aN5Q7GNc8F7uQQb/j1DCqq0AZ4oOnTPE3yoJBydi+q9i0X/1jxDb5a+aPtFmjjgIWTvr5O97/y/7c1gDFYx/UtWDYJFZA4bgB8esGJ1dVMz4JTHVhLWo9CcPV+UvIP+ZHcvoTr+JidRleyUe7pAzibQMyogx8eef0+uwo/tehCg/YPJ0s4Tx/a7UxMratgbsPufd/oVN5mfFH21/fgmXiDN8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CY8PR11MB6939.namprd11.prod.outlook.com (2603:10b6:930:59::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Tue, 28 Nov
 2023 12:31:01 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7025.022; Tue, 28 Nov 2023
 12:31:01 +0000
Message-ID: <3b586f05-a136-fae2-fd8d-410e61fc8211@intel.com>
Date: Tue, 28 Nov 2023 13:30:51 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [patch net-next v4 5/9] genetlink: introduce per-sock family
 private pointer storage
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, <kuba@kernel.org>, <pabeni@redhat.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <jacob.e.keller@intel.com>,
	<jhs@mojatatu.com>, <johannes@sipsolutions.net>,
	<andriy.shevchenko@linux.intel.com>, <amritha.nambiar@intel.com>,
	<sdf@google.com>, <horms@kernel.org>, <netdev@vger.kernel.org>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-6-jiri@resnulli.us>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231123181546.521488-6-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0015.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::25)
 To BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CY8PR11MB6939:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c626bf8-d3ca-4dac-e82b-08dbf00de141
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ZLlAkHbjLXKUyUqEN9a92DvFZ+jYrC0DkuEDn0AXvagCKujBAuKvYc4K0RcE/9QktRgY2lRmFCFeZxfudw7WOa0pxZJmivCUJbNc8U3VYrWfXRsYzKG61nIMi7kY000G2RWbSws4v6n3jDIdOx8+UA9K4eV4t/ujyDTSKdv1dRh4SxQYwMk0nVDbN/4Xs1YJEtyib8pkJd4rU9eIsS/MYXinhf9k3JHTRtJsZ/EOGPD+6VBUenlG/3gSrD5p195CYxJCRLHLodj+d9SmYXAyDZ00PBg48kknXSYMyDYmMFTJ0Kx1287EbuIcwwjLiiwZHebkIeei/zfFW47SZn8g7RJZ2BPFdSNK57ntGGaQroNfqvELs7dOofankm8/Obv7HIWHLb2gACej+zCrS431inx+BfOIebkhIs9nc/Wx6FMdcYc9+bafdpM06C5RVvU6IezwegG78kT5fiG9va2WNMtvIwVUIZn+zbrFtRS/JThZWlBnV88VKR+e6Hhw0I2UCKWj1T0YMwKiNzI1vxL4gyNfoPk1Czi9+Fe1b2U0pA8WTMwe9e6d0DRn64rV8hYSy/rD4o9jzVEqjkl3KzeHH7idL6vvhfoxubFefmPoa3Eb3xC0CVAo/rGU3zjf6WQRp/6AMnU8tJ19BohBbYANkQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(396003)(346002)(366004)(136003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(26005)(6666004)(66556008)(6486002)(6506007)(53546011)(2616005)(6512007)(83380400001)(41300700001)(5660300002)(4326008)(8676002)(966005)(8936002)(478600001)(2906002)(316002)(7416002)(36756003)(66946007)(82960400001)(86362001)(38100700002)(66476007)(31686004)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZU1ydXNkUmd4N0pwN3VBdFdyeE9sZmNnRlp0QzAwUXp3OEk5Z2pHeFcxME5U?=
 =?utf-8?B?ZnZvYmNlVUNORDJWOEdtaVBrZndDOTdMV2xHSldabDZFSm14dDczd1BsUFF2?=
 =?utf-8?B?ZTdZRkppY0s3eG90eTRWZ2lSaHRQd3RQZ2NITEVuYWs4c3U3QmV2TGpZQUdT?=
 =?utf-8?B?cVNkeXpkR2hSZkFmS2JYZ1cvUDE2NkpCb0gzWS9PK2tlSFJNcXR3Q01rQWd1?=
 =?utf-8?B?ek9sRzIyZDY1YU9WOFRiWEg3dGhkUFYrZ3RXUXpDNG1Ga2xCOUtJdFBhUGM3?=
 =?utf-8?B?aWxXU2xlRS9Zb2p0Uks2T24vYnNpMGk2SVEvOHB1MUFEUng5Ym52aDVzZXRX?=
 =?utf-8?B?UEp0ZEE3TUg0eUUxNThvbzhNNU43dDg0czhVTHJEK0k0WSszbS96U3poWTRU?=
 =?utf-8?B?c1FqUDdoMlRJQi9ORkt5akRmdXloQUtxUG9peXdwSi9ncno5SHQvVUhsSkpS?=
 =?utf-8?B?RFN1cWF0dm1ISy8zMWFXV0RTbmVLbDBpQ2VtMm5GQVV6c2p1TmlkNnFMcEh0?=
 =?utf-8?B?b1JRQ0NDeHExSCtLNmRJeXpaT2VLSFlCYTNETkFSQzRKZWJzYXJFSHdTQ0o1?=
 =?utf-8?B?MCswRWF1c1o5YitSc1JqMVhsZWxWMEhZSG9KUFJHWERKbEdQN1JLTm1NcTBU?=
 =?utf-8?B?VmJ0SXZjdDl3N3VWL093SWtnNWZvMzgxL2tzRk8vQ0J0TmU2dk5seW1CM0Ir?=
 =?utf-8?B?NlZKNWJXVDFPeXQwcjVMbHF1NDAraWhIdVdMd1hhQTV5a01VT0crUFhXSTFw?=
 =?utf-8?B?eVpLemxqbVFlNmVZNXQ4MlJFK3p5Q2JyTlhvcFBxelBlakQ0c3JEWVN5L3ZH?=
 =?utf-8?B?a3dGVExLODBHQ0tTUHJaa01EanZ0OGkyUnQ3N0xHcEVFL0h2eE1LMXhKbGFr?=
 =?utf-8?B?Vk9TRFZ1ZlBRdCtOYVc4a0R6dG5HUWc1cWdUNlhVNUZjd2JYRmpFMitadEpo?=
 =?utf-8?B?Vys2NUVzb1YrelVOVmNPNFlYcXRmdElob2Q4d0pTRG5yOEl5TnBUSFloais3?=
 =?utf-8?B?bGgxZUhzTldvanRMd2FyUTRhQXJyQnlzNnZaNXZpUmxqMm1yRGY1Ym5FUzdn?=
 =?utf-8?B?MVExZkdwYWNTb3BtbVo5MTM1WU1XdFhaem9kelFGTlY4c2RmbEJhejZweFk4?=
 =?utf-8?B?MXNaMHdIblh6OGJWd3ZBQ0pUaVhsOHdTSVNaVUY1V0p6ajhMMFBrTXBLN3g5?=
 =?utf-8?B?UGw2bndzU3h5aWpOSzNhbjBpYzEzVzZqK1VWamZRYzVwaTJNNkUxOEIvN3hs?=
 =?utf-8?B?bHdpVEU5ZWZOWGNSd3pySUFJSDhtdmNrdHovNXhFRkhVcExjN3ZETE9MMEFs?=
 =?utf-8?B?RG5FUlJ1bmtoQzJUQmdWcWxFS3hCaWgwQjMvNlRDaStKSnppV2NzMTdybnoz?=
 =?utf-8?B?enhOajZQZUlZSXRBUFJRbWhLbWhPSjBNVXBWS2RTSVp6Z1FYVnlQZEZWbDR6?=
 =?utf-8?B?azdZZkFyUFFMTk9wT2FSY1lnNUd6NmdJejBQdEpJQUI5V05JSlgzZnNmMUh3?=
 =?utf-8?B?MFJidE90NzhXSmRrTW1PaE9BQmJIa0pKazlEbmF2K2JOUktpUjJkZXRoUk51?=
 =?utf-8?B?SDZlRWFVMVMwUGlPVTRVM041R1FuVVNZTUJpdGlINDZyQjkyUU1zNUliS21U?=
 =?utf-8?B?NjlyS04xNVRiZ3ZuKzRsMHgvNDVLSlNzUVNmUGltUDFjb2ZhWjM2dXJ3YmI4?=
 =?utf-8?B?dW5XV2JwY2FNQlI1WnhGZ0NvSDBpM2ZIeTRZQU45eklid2VBWTN1anNjUnBT?=
 =?utf-8?B?MTlNZ2JUekd5aktTK2hTYkJWRUlCMlozdFp6REJiYzZNQTlnSlRIaDREWEQz?=
 =?utf-8?B?NDhvOC9OOU5mNVdaSzZ5ZndLWnc4VWJ2QmsweEdaOTA2azNzMnVOSDliaVh5?=
 =?utf-8?B?MmZvTU43UXI4Z2toR1htUUI3dnB1a2dMS0hMM2grTjJyR2JmaEtlY1ZzL1Jl?=
 =?utf-8?B?SjU2bmVTM1BiK0JRTjBQaWM1Zkd1NVZGYnhZR3Znak9LVGFaWWh3M2FTUndD?=
 =?utf-8?B?UGpyazBsU2REbURQbi9aV0RkWU1uY25EaVU1V1hsUnN6aWp4azhvbzJPc09E?=
 =?utf-8?B?bmVWdzIzS3Z6czNjeUxlTUFkTFhGTUc5bnlkWGNlRTQ4bmU1RmNaVjJRNDVQ?=
 =?utf-8?B?b2lEVStSS3c4cVJoQnNRUjRhb0ZoQXdWNTdHNVNoV0ZHcEdteGF0T1dnYU8w?=
 =?utf-8?Q?frmLfQjCG6GYe5TUvb2iW7U=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c626bf8-d3ca-4dac-e82b-08dbf00de141
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Nov 2023 12:31:01.8588
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E2Gj+rmw4TOOdJFoddxt7RMwdy8fVIl4iz9uGSn/h52xJDA6UGu2FXo94IvlhIvmaJpSr7+PeeplVrQGRuMpq3ZRBUe6XioknGD+MGKBDBg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR11MB6939
X-OriginatorOrg: intel.com

On 11/23/23 19:15, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Introduce a priv pointer into struct netlink_sock. Use it to store a per
> socket xarray that contains family->id indexed priv pointer storage.
> Note I used xarray instead of suggested linked list as it is more
> convenient, without need to have a container struct that would
> contain struct list_head item.
> 
> Introduce genl_sk_priv_store() to store the priv pointer.
> Introduce genl_sk_priv_get() to obtain the priv pointer under RCU
> read lock.
> 
> Assume that kfree() is good for free of privs for now, as the only user
> introduced by the follow-up patch (devlink) will use kzalloc() for the
> allocation of the memory of the stored pointer. If later on
> this needs to be made custom, a callback is going to be needed.
> Until then (if ever), do this in a simple way.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v3->v4:
> - new patch
> ---
>   include/net/genetlink.h  |  3 ++
>   net/netlink/af_netlink.h |  1 +
>   net/netlink/genetlink.c  | 98 ++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 102 insertions(+)
> 
> diff --git a/include/net/genetlink.h b/include/net/genetlink.h
> index e18a4c0d69ee..66c1e50415e0 100644
> --- a/include/net/genetlink.h
> +++ b/include/net/genetlink.h
> @@ -300,6 +300,9 @@ int genl_register_family(struct genl_family *family);
>   int genl_unregister_family(const struct genl_family *family);
>   void genl_notify(const struct genl_family *family, struct sk_buff *skb,
>   		 struct genl_info *info, u32 group, gfp_t flags);
> +void *genl_sk_priv_get(struct sock *sk, struct genl_family *family);
> +void *genl_sk_priv_store(struct sock *sk, struct genl_family *family,
> +			 void *priv);
>   
>   void *genlmsg_put(struct sk_buff *skb, u32 portid, u32 seq,
>   		  const struct genl_family *family, int flags, u8 cmd);
> diff --git a/net/netlink/af_netlink.h b/net/netlink/af_netlink.h
> index 2145979b9986..5d96135a4cf3 100644
> --- a/net/netlink/af_netlink.h
> +++ b/net/netlink/af_netlink.h
> @@ -51,6 +51,7 @@ struct netlink_sock {
>   	struct rhash_head	node;
>   	struct rcu_head		rcu;
>   	struct work_struct	work;
> +	void __rcu		*priv;
>   };
>   
>   static inline struct netlink_sock *nlk_sk(struct sock *sk)
> diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
> index 92ef5ed2e7b0..aae5e63fa50b 100644
> --- a/net/netlink/genetlink.c
> +++ b/net/netlink/genetlink.c
> @@ -21,6 +21,7 @@
>   #include <linux/idr.h>
>   #include <net/sock.h>
>   #include <net/genetlink.h>
> +#include "af_netlink.h"
>   
>   static DEFINE_MUTEX(genl_mutex); /* serialization of message processing */
>   static DECLARE_RWSEM(cb_lock);
> @@ -1699,12 +1700,109 @@ static int genl_bind(struct net *net, int group)
>   	return ret;
>   }
>   
> +struct genl_sk_ctx {
> +	struct xarray family_privs;
> +};
> +
> +static struct genl_sk_ctx *genl_sk_ctx_alloc(void)
> +{
> +	struct genl_sk_ctx *ctx;
> +
> +	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
> +	if (!ctx)
> +		return NULL;
> +	xa_init_flags(&ctx->family_privs, XA_FLAGS_ALLOC);
> +	return ctx;
> +}
> +
> +static void genl_sk_ctx_free(struct genl_sk_ctx *ctx)
> +{
> +	unsigned long family_id;
> +	void *priv;
> +
> +	xa_for_each(&ctx->family_privs, family_id, priv) {
> +		xa_erase(&ctx->family_privs, family_id);
> +		kfree(priv);
> +	}
> +	xa_destroy(&ctx->family_privs);
> +	kfree(ctx);
> +}
> +
> +/**
> + * genl_sk_priv_get - Get per-socket private pointer for family
> + *
> + * @sk: socket
> + * @family: family
> + *
> + * Lookup a private pointer stored per-socket by a specified
> + * Generic netlink family.
> + *
> + * Caller should make sure this is called in RCU read locked section.
> + *
> + * Returns: valid pointer on success, otherwise NULL.

since you are going to post next revision,

kernel-doc requires "Return:" section (singular form)
https://docs.kernel.org/doc-guide/kernel-doc.html#function-documentation

for new code we should strive to fulfil the requirement
(or piss-off someone powerful enough to change the requirement ;))



[snip]


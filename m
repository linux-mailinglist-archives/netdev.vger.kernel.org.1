Return-Path: <netdev+bounces-43164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4A27D19ED
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 02:33:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9159D1C21020
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 00:33:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3069190;
	Sat, 21 Oct 2023 00:33:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RxnpD/vz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 984557EF
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 00:33:11 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C441D6F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 17:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697848384; x=1729384384;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=EJCz4M5/KalF6AU8ahYDWRjkGAfhDCxa5Efyy2t5qZA=;
  b=RxnpD/vzzXVxXo+N01iboFDhvLemlHIHw3AXx1z0DJ5I9NbSIZD3nqVy
   MOKIWzWX+0csDPfXTt5GHHMJBGzSy7gcd1ibAjtpCXIBxYzerdRfmsHb6
   bBIR1uy/Xs8Cxr9TfsvyC+pR/Yu+QUcby45GWQi6NWq5wOUt32AfksCjE
   46dSMP2VIC3yPvjR+qMMcEfCgm/fImUaP2WuyhNB08KKGcx+ouU9ZB/Hh
   gXkfkVVzi5tkMk6F0+oJ72Uq3GGRjc/KvNtOlKJDnlahGlTjR4wUPKB62
   XQkN0JU2oY6hF9CizmVn9F/rzjnyx8e6qIlgx2+jztJdh1ZdDI7jyGwWZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="385488173"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="385488173"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 17:33:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="1088894861"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="1088894861"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 17:33:03 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 17:33:02 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 17:32:56 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 17:32:56 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 17:32:50 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gJIBwOYb7oCfWEtBbCcrqFUHC9wMVw1WIdXDoQTUA5+w7PhcbyaAa45op8buctIIQY5psxvLJa4a9SRyuspGRfPv/ULQqVhIZFGjpAhri5p/imG5+c9VyXnRzGudHya5/jeciF7Z4FCx5JbdXoJVDNUpqJczP22wM0aftfvfFK7EeYEwr22Sy+YHNu2zbaE2LTeaB44iemM1IUbpqSCGG5PxaOOyZZ9+xl+PKR5wrjcjbjTEdmJFzUNooO3JDWwBhV84EHIiQ5eH58/PdwBX54/kgin9yxuZcteC6iiFtc1v/JOnOZTdWwHccikB5gQWVea+weZq+a/0IHpsyeaeNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=y559ICuXpPFcz8jAOjKKP4+IulZmKHFTSF0fQ0gQMK4=;
 b=M3XhJIZuJTzaywEnOO0pMzinqoNDcc+6jcq1eWQ/IJ1IiwTUd71T8iHasW+3pRkKesCTFunvbi6pfoKqorlHUyv5X7/NW0AdCe846MQLnn0T5aCoaXe3QZJNLnjJSLcYgQYnEB8l1G84o16d2QbYb7jHo81Du756YlwxVqsFZEmVaWoEUs0QR2IwNR/fB3R6AF5IeQUJmqOTYPlJsOx2EG2vHg3VUgPejOnYwedQipNRVBQEsWEEfQgJaWBpbbCh/7ZtlMoWQnZrBTf8V9PBgJ7N6C/pR4228j/UiLqLFNjtl1s/pMFd3pvOHTVSFq9VuNoUH4fj2Gx6F4pFnzB+Cg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DM4PR11MB6480.namprd11.prod.outlook.com (2603:10b6:8:8d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sat, 21 Oct
 2023 00:32:47 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.6907.025; Sat, 21 Oct 2023
 00:32:47 +0000
Message-ID: <04424752-1339-4deb-a85e-78c1fcf46312@intel.com>
Date: Fri, 20 Oct 2023 17:32:42 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] tools: ynl-gen: change spacing around
 __attribute__
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<jiri@resnulli.us>, <donald.hunter@gmail.com>, <chuck.lever@oracle.com>,
	<sdf@google.com>
References: <20231020221827.3436697-1-kuba@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231020221827.3436697-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0148.namprd04.prod.outlook.com
 (2603:10b6:303:84::33) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DM4PR11MB6480:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e783cf8-a0e4-4d0f-abc1-08dbd1cd3f34
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfoIaoV6p5oTmjFnlS1TMIUsDUj/zdj+kGWWkcCF7UP64eN4tEjTb91RCX/obFe35/SSIVXsMHfNxx0OS0Jiqi5h5kfp9C6ANq4qdqtn+dRPmJPkt/ACIiAkaYX1CsJ7zWnmTIFKG/frZ3zRxmtEmpxO7F32rZ99pr4F3heN94hQm8PbnlSD1lKe1Kq63iqiZtFlkV638p49jMfdceOHG7fFcVgd31zZGFklzHZ+j5lUiOrnUcDLz+AWYBWVWkXydraZ/1l4k6kvbFz57PPOqvcwcfCI9VBMutbQM6C+Sikm/UuGEYhe28bQIF7wT4vXYFj9OMV5La9yDVbFeAE7UPVIZKy8PAr48m6j30nPKLLFl2mAfNRSiHfc1u/OqaZykkZhhJkTukDsKKUM23v40u5yy66jwAa5MFXgtyfJIUNgv0spz/LkC1bMcdAxcbvY/pm2XiszAXiS+wfm4uHhatv6+L5BHuKh7wWrrEDPjtdKFTLYxLKZNQjOrcQzCrGewtmdhGD9GTnGP8t++YmgXLydlOdUpEM6pbn5vfzdtXpQHcXpLF+8cyjpqHhKmObDfC+Wn04YSRmuuyj/8krNXfVvKunfZza8XMQz3E15m4XR3QdCuTjykQ2AAeeU3gJ75L2IdfEe78gLx6ozDmArTw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(39860400002)(376002)(136003)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(5660300002)(31696002)(83380400001)(66946007)(66556008)(6486002)(66476007)(966005)(316002)(478600001)(82960400001)(86362001)(36756003)(8676002)(30864003)(8936002)(4326008)(41300700001)(6666004)(38100700002)(6512007)(53546011)(2906002)(2616005)(6506007)(26005)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Sk94QUJIdWM2cFhQQkZRcHFvYmdrV1FueTA2V083WTZQVjhvNm05clJzNFMv?=
 =?utf-8?B?UGNZWk5YZTI1Z2FjNHN4UjViS1h6RWlXSVJxRk1nZXpMTlBzSUYvMDV6OGpJ?=
 =?utf-8?B?TnhkUWllU2dNRSs0V1RNUFdPaHhKcWpMYTFBZzBiYmpxdUhrTFoyT2lXMFRP?=
 =?utf-8?B?TjVPWEp2ZCtXZXVKOFcyKzJkZlN4Tm9pZHdsMVI5QlFodHRlMzlxRTNqckxz?=
 =?utf-8?B?ZFZjMU5xTnBlZDdiTjJSQnZ6dzM4bHJyNTAwQ05PSWY1b1dodWc4K2VYbStT?=
 =?utf-8?B?aTFDSDl4RFBISTlmd3hEVmpJb0Yrall5QlppSURuQ3dKNGpWZ1VPdFVsdUlV?=
 =?utf-8?B?RnZkcUl6ZkZ1Y3dTM01PM0lZNU5uc0VyK1BzZFlrMTVvUzJRemFwTzdXKzR6?=
 =?utf-8?B?N0JiQkVid093L1RUQkQrdFd3NGRxZ3FLSXphOVN3Skd6ZEYvRmlpeVk3eUJz?=
 =?utf-8?B?Y0NKUndlWGdQcFJDSmNSWHBjYVZhWFJWWGo3M2E5NHZwU3ZITGZ5N2pFUkVK?=
 =?utf-8?B?cVR5anZ1NHgzbG1VMEJBYUwrVVBQZ3BCL0M4OENvVDRqdksyWU1EWWJiM2p6?=
 =?utf-8?B?NDZrbjlIS2RGRUhiQVlGTUF6bDRvd1RvSU14Ky9Jc2Y3bEs0QlVjNk9oRUdv?=
 =?utf-8?B?Z0JVSU5iZWhBNmkzWUpFdXViTkQ4NTYzUVJ3eS81d0xSZVRDZ1hPbTJELzIy?=
 =?utf-8?B?Vlcvek91TXJrMWlRQmY0dGh2V0tYVU1reFc4T1R6TlJvUGJuN0cwcFlsRTlu?=
 =?utf-8?B?NlFzcy9MUVRwZ0EzTVJ4SVVTMU4wUU5Kd2ltNFE3cVJjR25BdytYUmg5NWRz?=
 =?utf-8?B?aXRHd2hJMFdiZ0xiOEQ2VnRYU1hXRUR2UEk1L29rTG8wSFZXNDJDOWpHY1lt?=
 =?utf-8?B?R1IxczlHeTZRaWhUTCtDYW1QbFFldThiN0hQdnpZeWRmbERVV0RrbExQU1pM?=
 =?utf-8?B?ZTlJRjFRSlJyNEJkWWRqYWNXNU5hdHZxYVZSM0ZJQ05SbUIvejU4YVhTeTNQ?=
 =?utf-8?B?aVJycFBPME5ObVZSOFQzYUFjUDJZeVBOVjRBYkxzRnhFMDhBa2gvTmVEVGY3?=
 =?utf-8?B?LzRsTG5sL2FKY2pxeFlCZlRQS0piNGFGOWNYRUZMUWdDbThISXEwT3pLTmJW?=
 =?utf-8?B?U3Q1Z2EwZW9mdEVpZ2toQnJpS2tZdXBoOXVMZGhRR0Z6ZVNDaUlvbTg5cGxQ?=
 =?utf-8?B?QjB2bjNjS3ZLVlg1Y25RQXJsRnhubStDR2x3bklqb3NacWZGTnJQMWpuTmo1?=
 =?utf-8?B?TXVTbDI2SU4zMVJuM3piZ2hOdU5jalAzVTVlb0xGS0owWlpObnQydlhYODNt?=
 =?utf-8?B?TnVPMURTOC93SVZoaklrSURESkdNc1BuRk5ZSzBFdWh2d0pVdUlxbXN3MXFs?=
 =?utf-8?B?Rzk3VW1IallEc3BBUUdYRStaMk1zM2l4am5JZ25CeWZRYWJiemR3RXZSK0NB?=
 =?utf-8?B?OWNtQTNhVXdtazBQRDJ6dGd4RjQvRk0xWjM5c0dVNzloL1hTNWFSUjU3SnRE?=
 =?utf-8?B?Ui9YaWlTYmxTT3ArR2VNNFlDNmVNT0tnWWJEOW9WMkFEWlBvVUZuWDRXdWtr?=
 =?utf-8?B?QklWVXVseE9CekhuUlJGNndQbnVYS2lXb0tpVFVVVXFrVkE2dnFhd1Ivc2tB?=
 =?utf-8?B?ZGQ4WkswbS9GTjB4TFhWV0FoNWZaZ0lCalQ4MExhdXZkbTZneEJiUUFGYjln?=
 =?utf-8?B?OGxRRHJ0MnNBQTMyRGhJTFcxcmRvVVgwTDJUT0E4Z0x6MTZRc2cyazV4OFk4?=
 =?utf-8?B?cVJYVmJpbW0xVStmMDVVZkFHcUhxc3JCVzRuNU9EN2NVTC9IV25aM2hkb0pt?=
 =?utf-8?B?NWxsWndDVGpMZVJwT05nV1cxYnNSNTRwN2ozdkg5YTBqZjRSWmJ2VENMa0VK?=
 =?utf-8?B?VDJ1Q2tMSHVrdUN4OFFXU3RDa2RVbDIzTXdWb091dVk0N0xKWjlHNWZXenh6?=
 =?utf-8?B?Ujkzd1JTRmNsaXhqZk1YUVg4SWp6VFIvZmR3T2YzM0hjMjhSVU5uZlVvZkRh?=
 =?utf-8?B?bFRKcmNiS1VsK2FUcW1zU3JQRFdrQ0Npd2NaM0ZuT2JxcmVlemswa1VFQjRG?=
 =?utf-8?B?RnlKOFZvTHlvOW1QZHpZdm5jTEg5QUNqY2VmbEhZTWNUemNhK1QzdEFNSlh3?=
 =?utf-8?B?MXNhSTBSVHM2K0ZaaldhQk9vblFsMFhkd3d6cForaEIvTkcrUUl1SzNaaXc3?=
 =?utf-8?B?RFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e783cf8-a0e4-4d0f-abc1-08dbd1cd3f34
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 00:32:47.1798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kpm08YyKY9CTX6a45ZyWL7brIRCATB7oUwKu4ByT8Ju6mHfgoVlSA2nVAW7UC2JLczXfbGHKsTOv5FmcJv16/GQwHXmdB8l0IemxMsyXoVI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6480
X-OriginatorOrg: intel.com

On 10/20/2023 3:18 PM, Jakub Kicinski wrote:
> checkpatch gets confused and treats __attribute__ as a function call.
> It complains about white space before "(":
> 
> WARNING:SPACING: space prohibited between function name and open parenthesis '('
> +	struct netdev_queue_get_rsp obj __attribute__ ((aligned (8)));
> 
> No spaces wins in the kernel:
> 
>    $ git grep 'attribute__((.*aligned(' | wc -l
>    480
>    $ git grep 'attribute__ ((.*aligned (' | wc -l
>    110
>    $ git grep 'attribute__ ((.*aligned(' | wc -l
>    94
>    $ git grep 'attribute__((.*aligned (' | wc -l
>    63
> 
> So, whatever, change the codegen.
> 
> Note that checkpatch also thinks we should use __aligned(),
> but this is user space code.
> 
> Link: https://lore.kernel.org/all/202310190900.9Dzgkbev-lkp@intel.com/
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: amritha.nambiar@intel.com
> CC: jiri@resnulli.us
> CC: donald.hunter@gmail.com
> CC: chuck.lever@oracle.com
> CC: sdf@google.com
> ---

Reviewed-by: Amritha Nambiar <amritha.nambiar@intel.com>

>   tools/net/ynl/generated/devlink-user.h   | 32 ++++-----
>   tools/net/ynl/generated/ethtool-user.h   | 82 ++++++++++++------------
>   tools/net/ynl/generated/fou-user.h       |  2 +-
>   tools/net/ynl/generated/handshake-user.h |  2 +-
>   tools/net/ynl/generated/netdev-user.h    |  4 +-
>   tools/net/ynl/lib/ynl.h                  |  4 +-
>   tools/net/ynl/ynl-gen-c.py               |  2 +-
>   7 files changed, 64 insertions(+), 64 deletions(-)
> 
> diff --git a/tools/net/ynl/generated/devlink-user.h b/tools/net/ynl/generated/devlink-user.h
> index 4b686d147613..f5656bc28db4 100644
> --- a/tools/net/ynl/generated/devlink-user.h
> +++ b/tools/net/ynl/generated/devlink-user.h
> @@ -134,7 +134,7 @@ devlink_get(struct ynl_sock *ys, struct devlink_get_req *req);
>   /* DEVLINK_CMD_GET - dump */
>   struct devlink_get_list {
>   	struct devlink_get_list *next;
> -	struct devlink_get_rsp obj __attribute__ ((aligned (8)));
> +	struct devlink_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void devlink_get_list_free(struct devlink_get_list *rsp);
> @@ -262,7 +262,7 @@ struct devlink_port_get_rsp_dump {
>   
>   struct devlink_port_get_rsp_list {
>   	struct devlink_port_get_rsp_list *next;
> -	struct devlink_port_get_rsp_dump obj __attribute__ ((aligned (8)));
> +	struct devlink_port_get_rsp_dump obj __attribute__((aligned(8)));
>   };
>   
>   void devlink_port_get_rsp_list_free(struct devlink_port_get_rsp_list *rsp);
> @@ -379,7 +379,7 @@ devlink_sb_get_req_dump_set_dev_name(struct devlink_sb_get_req_dump *req,
>   
>   struct devlink_sb_get_list {
>   	struct devlink_sb_get_list *next;
> -	struct devlink_sb_get_rsp obj __attribute__ ((aligned (8)));
> +	struct devlink_sb_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void devlink_sb_get_list_free(struct devlink_sb_get_list *rsp);
> @@ -509,7 +509,7 @@ devlink_sb_pool_get_req_dump_set_dev_name(struct devlink_sb_pool_get_req_dump *r
>   
>   struct devlink_sb_pool_get_list {
>   	struct devlink_sb_pool_get_list *next;
> -	struct devlink_sb_pool_get_rsp obj __attribute__ ((aligned (8)));
> +	struct devlink_sb_pool_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void devlink_sb_pool_get_list_free(struct devlink_sb_pool_get_list *rsp);
> @@ -654,7 +654,7 @@ devlink_sb_port_pool_get_req_dump_set_dev_name(struct devlink_sb_port_pool_get_r
>   
>   struct devlink_sb_port_pool_get_list {
>   	struct devlink_sb_port_pool_get_list *next;
> -	struct devlink_sb_port_pool_get_rsp obj __attribute__ ((aligned (8)));
> +	struct devlink_sb_port_pool_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void
> @@ -811,7 +811,7 @@ devlink_sb_tc_pool_bind_get_req_dump_set_dev_name(struct devlink_sb_tc_pool_bind
>   
>   struct devlink_sb_tc_pool_bind_get_list {
>   	struct devlink_sb_tc_pool_bind_get_list *next;
> -	struct devlink_sb_tc_pool_bind_get_rsp obj __attribute__ ((aligned (8)));
> +	struct devlink_sb_tc_pool_bind_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void
> @@ -933,7 +933,7 @@ devlink_param_get_req_dump_set_dev_name(struct devlink_param_get_req_dump *req,
>   
>   struct devlink_param_get_list {
>   	struct devlink_param_get_list *next;
> -	struct devlink_param_get_rsp obj __attribute__ ((aligned (8)));
> +	struct devlink_param_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void devlink_param_get_list_free(struct devlink_param_get_list *rsp);
> @@ -1065,7 +1065,7 @@ devlink_region_get_req_dump_set_dev_name(struct devlink_region_get_req_dump *req
>   
>   struct devlink_region_get_list {
>   	struct devlink_region_get_list *next;
> -	struct devlink_region_get_rsp obj __attribute__ ((aligned (8)));
> +	struct devlink_region_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void devlink_region_get_list_free(struct devlink_region_get_list *rsp);
> @@ -1144,7 +1144,7 @@ devlink_info_get(struct ynl_sock *ys, struct devlink_info_get_req *req);
>   /* DEVLINK_CMD_INFO_GET - dump */
>   struct devlink_info_get_list {
>   	struct devlink_info_get_list *next;
> -	struct devlink_info_get_rsp obj __attribute__ ((aligned (8)));
> +	struct devlink_info_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void devlink_info_get_list_free(struct devlink_info_get_list *rsp);
> @@ -1288,7 +1288,7 @@ devlink_health_reporter_get_req_dump_set_port_index(struct devlink_health_report
>   
>   struct devlink_health_reporter_get_list {
>   	struct devlink_health_reporter_get_list *next;
> -	struct devlink_health_reporter_get_rsp obj __attribute__ ((aligned (8)));
> +	struct devlink_health_reporter_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void
> @@ -1410,7 +1410,7 @@ devlink_trap_get_req_dump_set_dev_name(struct devlink_trap_get_req_dump *req,
>   
>   struct devlink_trap_get_list {
>   	struct devlink_trap_get_list *next;
> -	struct devlink_trap_get_rsp obj __attribute__ ((aligned (8)));
> +	struct devlink_trap_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void devlink_trap_get_list_free(struct devlink_trap_get_list *rsp);
> @@ -1534,7 +1534,7 @@ devlink_trap_group_get_req_dump_set_dev_name(struct devlink_trap_group_get_req_d
>   
>   struct devlink_trap_group_get_list {
>   	struct devlink_trap_group_get_list *next;
> -	struct devlink_trap_group_get_rsp obj __attribute__ ((aligned (8)));
> +	struct devlink_trap_group_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void devlink_trap_group_get_list_free(struct devlink_trap_group_get_list *rsp);
> @@ -1657,7 +1657,7 @@ devlink_trap_policer_get_req_dump_set_dev_name(struct devlink_trap_policer_get_r
>   
>   struct devlink_trap_policer_get_list {
>   	struct devlink_trap_policer_get_list *next;
> -	struct devlink_trap_policer_get_rsp obj __attribute__ ((aligned (8)));
> +	struct devlink_trap_policer_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void
> @@ -1790,7 +1790,7 @@ devlink_rate_get_req_dump_set_dev_name(struct devlink_rate_get_req_dump *req,
>   
>   struct devlink_rate_get_list {
>   	struct devlink_rate_get_list *next;
> -	struct devlink_rate_get_rsp obj __attribute__ ((aligned (8)));
> +	struct devlink_rate_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void devlink_rate_get_list_free(struct devlink_rate_get_list *rsp);
> @@ -1910,7 +1910,7 @@ devlink_linecard_get_req_dump_set_dev_name(struct devlink_linecard_get_req_dump
>   
>   struct devlink_linecard_get_list {
>   	struct devlink_linecard_get_list *next;
> -	struct devlink_linecard_get_rsp obj __attribute__ ((aligned (8)));
> +	struct devlink_linecard_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void devlink_linecard_get_list_free(struct devlink_linecard_get_list *rsp);
> @@ -1981,7 +1981,7 @@ devlink_selftests_get(struct ynl_sock *ys,
>   /* DEVLINK_CMD_SELFTESTS_GET - dump */
>   struct devlink_selftests_get_list {
>   	struct devlink_selftests_get_list *next;
> -	struct devlink_selftests_get_rsp obj __attribute__ ((aligned (8)));
> +	struct devlink_selftests_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void devlink_selftests_get_list_free(struct devlink_selftests_get_list *rsp);
> diff --git a/tools/net/ynl/generated/ethtool-user.h b/tools/net/ynl/generated/ethtool-user.h
> index ddc1a5209992..ca0ec5fd7798 100644
> --- a/tools/net/ynl/generated/ethtool-user.h
> +++ b/tools/net/ynl/generated/ethtool-user.h
> @@ -347,7 +347,7 @@ ethtool_strset_get_req_dump_set_counts_only(struct ethtool_strset_get_req_dump *
>   
>   struct ethtool_strset_get_list {
>   	struct ethtool_strset_get_list *next;
> -	struct ethtool_strset_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_strset_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_strset_get_list_free(struct ethtool_strset_get_list *rsp);
> @@ -472,7 +472,7 @@ ethtool_linkinfo_get_req_dump_set_header_flags(struct ethtool_linkinfo_get_req_d
>   
>   struct ethtool_linkinfo_get_list {
>   	struct ethtool_linkinfo_get_list *next;
> -	struct ethtool_linkinfo_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_linkinfo_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_linkinfo_get_list_free(struct ethtool_linkinfo_get_list *rsp);
> @@ -487,7 +487,7 @@ struct ethtool_linkinfo_get_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_linkinfo_get_ntf *ntf);
> -	struct ethtool_linkinfo_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_linkinfo_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_linkinfo_get_ntf_free(struct ethtool_linkinfo_get_ntf *rsp);
> @@ -712,7 +712,7 @@ ethtool_linkmodes_get_req_dump_set_header_flags(struct ethtool_linkmodes_get_req
>   
>   struct ethtool_linkmodes_get_list {
>   	struct ethtool_linkmodes_get_list *next;
> -	struct ethtool_linkmodes_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_linkmodes_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_linkmodes_get_list_free(struct ethtool_linkmodes_get_list *rsp);
> @@ -727,7 +727,7 @@ struct ethtool_linkmodes_get_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_linkmodes_get_ntf *ntf);
> -	struct ethtool_linkmodes_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_linkmodes_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_linkmodes_get_ntf_free(struct ethtool_linkmodes_get_ntf *rsp);
> @@ -1014,7 +1014,7 @@ ethtool_linkstate_get_req_dump_set_header_flags(struct ethtool_linkstate_get_req
>   
>   struct ethtool_linkstate_get_list {
>   	struct ethtool_linkstate_get_list *next;
> -	struct ethtool_linkstate_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_linkstate_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_linkstate_get_list_free(struct ethtool_linkstate_get_list *rsp);
> @@ -1129,7 +1129,7 @@ ethtool_debug_get_req_dump_set_header_flags(struct ethtool_debug_get_req_dump *r
>   
>   struct ethtool_debug_get_list {
>   	struct ethtool_debug_get_list *next;
> -	struct ethtool_debug_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_debug_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_debug_get_list_free(struct ethtool_debug_get_list *rsp);
> @@ -1144,7 +1144,7 @@ struct ethtool_debug_get_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_debug_get_ntf *ntf);
> -	struct ethtool_debug_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_debug_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_debug_get_ntf_free(struct ethtool_debug_get_ntf *rsp);
> @@ -1330,7 +1330,7 @@ ethtool_wol_get_req_dump_set_header_flags(struct ethtool_wol_get_req_dump *req,
>   
>   struct ethtool_wol_get_list {
>   	struct ethtool_wol_get_list *next;
> -	struct ethtool_wol_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_wol_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_wol_get_list_free(struct ethtool_wol_get_list *rsp);
> @@ -1344,7 +1344,7 @@ struct ethtool_wol_get_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_wol_get_ntf *ntf);
> -	struct ethtool_wol_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_wol_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_wol_get_ntf_free(struct ethtool_wol_get_ntf *rsp);
> @@ -1546,7 +1546,7 @@ ethtool_features_get_req_dump_set_header_flags(struct ethtool_features_get_req_d
>   
>   struct ethtool_features_get_list {
>   	struct ethtool_features_get_list *next;
> -	struct ethtool_features_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_features_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_features_get_list_free(struct ethtool_features_get_list *rsp);
> @@ -1561,7 +1561,7 @@ struct ethtool_features_get_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_features_get_ntf *ntf);
> -	struct ethtool_features_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_features_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_features_get_ntf_free(struct ethtool_features_get_ntf *rsp);
> @@ -1843,7 +1843,7 @@ ethtool_privflags_get_req_dump_set_header_flags(struct ethtool_privflags_get_req
>   
>   struct ethtool_privflags_get_list {
>   	struct ethtool_privflags_get_list *next;
> -	struct ethtool_privflags_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_privflags_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_privflags_get_list_free(struct ethtool_privflags_get_list *rsp);
> @@ -1858,7 +1858,7 @@ struct ethtool_privflags_get_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_privflags_get_ntf *ntf);
> -	struct ethtool_privflags_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_privflags_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_privflags_get_ntf_free(struct ethtool_privflags_get_ntf *rsp);
> @@ -2072,7 +2072,7 @@ ethtool_rings_get_req_dump_set_header_flags(struct ethtool_rings_get_req_dump *r
>   
>   struct ethtool_rings_get_list {
>   	struct ethtool_rings_get_list *next;
> -	struct ethtool_rings_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_rings_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_rings_get_list_free(struct ethtool_rings_get_list *rsp);
> @@ -2087,7 +2087,7 @@ struct ethtool_rings_get_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_rings_get_ntf *ntf);
> -	struct ethtool_rings_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_rings_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_rings_get_ntf_free(struct ethtool_rings_get_ntf *rsp);
> @@ -2395,7 +2395,7 @@ ethtool_channels_get_req_dump_set_header_flags(struct ethtool_channels_get_req_d
>   
>   struct ethtool_channels_get_list {
>   	struct ethtool_channels_get_list *next;
> -	struct ethtool_channels_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_channels_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_channels_get_list_free(struct ethtool_channels_get_list *rsp);
> @@ -2410,7 +2410,7 @@ struct ethtool_channels_get_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_channels_get_ntf *ntf);
> -	struct ethtool_channels_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_channels_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_channels_get_ntf_free(struct ethtool_channels_get_ntf *rsp);
> @@ -2697,7 +2697,7 @@ ethtool_coalesce_get_req_dump_set_header_flags(struct ethtool_coalesce_get_req_d
>   
>   struct ethtool_coalesce_get_list {
>   	struct ethtool_coalesce_get_list *next;
> -	struct ethtool_coalesce_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_coalesce_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_coalesce_get_list_free(struct ethtool_coalesce_get_list *rsp);
> @@ -2712,7 +2712,7 @@ struct ethtool_coalesce_get_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_coalesce_get_ntf *ntf);
> -	struct ethtool_coalesce_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_coalesce_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_coalesce_get_ntf_free(struct ethtool_coalesce_get_ntf *rsp);
> @@ -3124,7 +3124,7 @@ ethtool_pause_get_req_dump_set_header_flags(struct ethtool_pause_get_req_dump *r
>   
>   struct ethtool_pause_get_list {
>   	struct ethtool_pause_get_list *next;
> -	struct ethtool_pause_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_pause_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_pause_get_list_free(struct ethtool_pause_get_list *rsp);
> @@ -3139,7 +3139,7 @@ struct ethtool_pause_get_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_pause_get_ntf *ntf);
> -	struct ethtool_pause_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_pause_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_pause_get_ntf_free(struct ethtool_pause_get_ntf *rsp);
> @@ -3360,7 +3360,7 @@ ethtool_eee_get_req_dump_set_header_flags(struct ethtool_eee_get_req_dump *req,
>   
>   struct ethtool_eee_get_list {
>   	struct ethtool_eee_get_list *next;
> -	struct ethtool_eee_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_eee_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_eee_get_list_free(struct ethtool_eee_get_list *rsp);
> @@ -3374,7 +3374,7 @@ struct ethtool_eee_get_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_eee_get_ntf *ntf);
> -	struct ethtool_eee_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_eee_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_eee_get_ntf_free(struct ethtool_eee_get_ntf *rsp);
> @@ -3623,7 +3623,7 @@ ethtool_tsinfo_get_req_dump_set_header_flags(struct ethtool_tsinfo_get_req_dump
>   
>   struct ethtool_tsinfo_get_list {
>   	struct ethtool_tsinfo_get_list *next;
> -	struct ethtool_tsinfo_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_tsinfo_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_tsinfo_get_list_free(struct ethtool_tsinfo_get_list *rsp);
> @@ -3842,7 +3842,7 @@ ethtool_tunnel_info_get_req_dump_set_header_flags(struct ethtool_tunnel_info_get
>   
>   struct ethtool_tunnel_info_get_list {
>   	struct ethtool_tunnel_info_get_list *next;
> -	struct ethtool_tunnel_info_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_tunnel_info_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void
> @@ -3964,7 +3964,7 @@ ethtool_fec_get_req_dump_set_header_flags(struct ethtool_fec_get_req_dump *req,
>   
>   struct ethtool_fec_get_list {
>   	struct ethtool_fec_get_list *next;
> -	struct ethtool_fec_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_fec_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_fec_get_list_free(struct ethtool_fec_get_list *rsp);
> @@ -3978,7 +3978,7 @@ struct ethtool_fec_get_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_fec_get_ntf *ntf);
> -	struct ethtool_fec_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_fec_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_fec_get_ntf_free(struct ethtool_fec_get_ntf *rsp);
> @@ -4221,7 +4221,7 @@ ethtool_module_eeprom_get_req_dump_set_header_flags(struct ethtool_module_eeprom
>   
>   struct ethtool_module_eeprom_get_list {
>   	struct ethtool_module_eeprom_get_list *next;
> -	struct ethtool_module_eeprom_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_module_eeprom_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void
> @@ -4340,7 +4340,7 @@ ethtool_phc_vclocks_get_req_dump_set_header_flags(struct ethtool_phc_vclocks_get
>   
>   struct ethtool_phc_vclocks_get_list {
>   	struct ethtool_phc_vclocks_get_list *next;
> -	struct ethtool_phc_vclocks_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_phc_vclocks_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void
> @@ -4458,7 +4458,7 @@ ethtool_module_get_req_dump_set_header_flags(struct ethtool_module_get_req_dump
>   
>   struct ethtool_module_get_list {
>   	struct ethtool_module_get_list *next;
> -	struct ethtool_module_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_module_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_module_get_list_free(struct ethtool_module_get_list *rsp);
> @@ -4473,7 +4473,7 @@ struct ethtool_module_get_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_module_get_ntf *ntf);
> -	struct ethtool_module_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_module_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_module_get_ntf_free(struct ethtool_module_get_ntf *rsp);
> @@ -4654,7 +4654,7 @@ ethtool_pse_get_req_dump_set_header_flags(struct ethtool_pse_get_req_dump *req,
>   
>   struct ethtool_pse_get_list {
>   	struct ethtool_pse_get_list *next;
> -	struct ethtool_pse_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_pse_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_pse_get_list_free(struct ethtool_pse_get_list *rsp);
> @@ -4849,7 +4849,7 @@ ethtool_rss_get_req_dump_set_header_flags(struct ethtool_rss_get_req_dump *req,
>   
>   struct ethtool_rss_get_list {
>   	struct ethtool_rss_get_list *next;
> -	struct ethtool_rss_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_rss_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_rss_get_list_free(struct ethtool_rss_get_list *rsp);
> @@ -4979,7 +4979,7 @@ ethtool_plca_get_cfg_req_dump_set_header_flags(struct ethtool_plca_get_cfg_req_d
>   
>   struct ethtool_plca_get_cfg_list {
>   	struct ethtool_plca_get_cfg_list *next;
> -	struct ethtool_plca_get_cfg_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_plca_get_cfg_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_plca_get_cfg_list_free(struct ethtool_plca_get_cfg_list *rsp);
> @@ -4994,7 +4994,7 @@ struct ethtool_plca_get_cfg_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_plca_get_cfg_ntf *ntf);
> -	struct ethtool_plca_get_cfg_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_plca_get_cfg_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_plca_get_cfg_ntf_free(struct ethtool_plca_get_cfg_ntf *rsp);
> @@ -5244,7 +5244,7 @@ ethtool_plca_get_status_req_dump_set_header_flags(struct ethtool_plca_get_status
>   
>   struct ethtool_plca_get_status_list {
>   	struct ethtool_plca_get_status_list *next;
> -	struct ethtool_plca_get_status_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_plca_get_status_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void
> @@ -5376,7 +5376,7 @@ ethtool_mm_get_req_dump_set_header_flags(struct ethtool_mm_get_req_dump *req,
>   
>   struct ethtool_mm_get_list {
>   	struct ethtool_mm_get_list *next;
> -	struct ethtool_mm_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_mm_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_mm_get_list_free(struct ethtool_mm_get_list *rsp);
> @@ -5390,7 +5390,7 @@ struct ethtool_mm_get_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_mm_get_ntf *ntf);
> -	struct ethtool_mm_get_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_mm_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_mm_get_ntf_free(struct ethtool_mm_get_ntf *rsp);
> @@ -5504,7 +5504,7 @@ struct ethtool_cable_test_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_cable_test_ntf *ntf);
> -	struct ethtool_cable_test_ntf_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_cable_test_ntf_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_cable_test_ntf_free(struct ethtool_cable_test_ntf *rsp);
> @@ -5527,7 +5527,7 @@ struct ethtool_cable_test_tdr_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ethtool_cable_test_tdr_ntf *ntf);
> -	struct ethtool_cable_test_tdr_ntf_rsp obj __attribute__ ((aligned (8)));
> +	struct ethtool_cable_test_tdr_ntf_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void ethtool_cable_test_tdr_ntf_free(struct ethtool_cable_test_tdr_ntf *rsp);
> diff --git a/tools/net/ynl/generated/fou-user.h b/tools/net/ynl/generated/fou-user.h
> index a8f860892540..fd566716ddd6 100644
> --- a/tools/net/ynl/generated/fou-user.h
> +++ b/tools/net/ynl/generated/fou-user.h
> @@ -333,7 +333,7 @@ struct fou_get_rsp *fou_get(struct ynl_sock *ys, struct fou_get_req *req);
>   /* FOU_CMD_GET - dump */
>   struct fou_get_list {
>   	struct fou_get_list *next;
> -	struct fou_get_rsp obj __attribute__ ((aligned (8)));
> +	struct fou_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void fou_get_list_free(struct fou_get_list *rsp);
> diff --git a/tools/net/ynl/generated/handshake-user.h b/tools/net/ynl/generated/handshake-user.h
> index 2b34acc608de..bce537d8b8cc 100644
> --- a/tools/net/ynl/generated/handshake-user.h
> +++ b/tools/net/ynl/generated/handshake-user.h
> @@ -90,7 +90,7 @@ struct handshake_accept_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct handshake_accept_ntf *ntf);
> -	struct handshake_accept_rsp obj __attribute__ ((aligned (8)));
> +	struct handshake_accept_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void handshake_accept_ntf_free(struct handshake_accept_ntf *rsp);
> diff --git a/tools/net/ynl/generated/netdev-user.h b/tools/net/ynl/generated/netdev-user.h
> index b4351ff34595..4fafac879df3 100644
> --- a/tools/net/ynl/generated/netdev-user.h
> +++ b/tools/net/ynl/generated/netdev-user.h
> @@ -69,7 +69,7 @@ netdev_dev_get(struct ynl_sock *ys, struct netdev_dev_get_req *req);
>   /* NETDEV_CMD_DEV_GET - dump */
>   struct netdev_dev_get_list {
>   	struct netdev_dev_get_list *next;
> -	struct netdev_dev_get_rsp obj __attribute__ ((aligned (8)));
> +	struct netdev_dev_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void netdev_dev_get_list_free(struct netdev_dev_get_list *rsp);
> @@ -82,7 +82,7 @@ struct netdev_dev_get_ntf {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct netdev_dev_get_ntf *ntf);
> -	struct netdev_dev_get_rsp obj __attribute__ ((aligned (8)));
> +	struct netdev_dev_get_rsp obj __attribute__((aligned(8)));
>   };
>   
>   void netdev_dev_get_ntf_free(struct netdev_dev_get_ntf *rsp);
> diff --git a/tools/net/ynl/lib/ynl.h b/tools/net/ynl/lib/ynl.h
> index 87b4dad832f0..cfefacb839f4 100644
> --- a/tools/net/ynl/lib/ynl.h
> +++ b/tools/net/ynl/lib/ynl.h
> @@ -157,7 +157,7 @@ struct ynl_parse_arg {
>   
>   struct ynl_dump_list_type {
>   	struct ynl_dump_list_type *next;
> -	unsigned char data[] __attribute__ ((aligned (8)));
> +	unsigned char data[] __attribute__((aligned(8)));
>   };
>   extern struct ynl_dump_list_type *YNL_LIST_END;
>   
> @@ -187,7 +187,7 @@ struct ynl_ntf_base_type {
>   	__u8 cmd;
>   	struct ynl_ntf_base_type *next;
>   	void (*free)(struct ynl_ntf_base_type *ntf);
> -	unsigned char data[] __attribute__ ((aligned (8)));
> +	unsigned char data[] __attribute__((aligned(8)));
>   };
>   
>   extern mnl_cb_t ynl_cb_array[NLMSG_MIN_TYPE];
> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> index a9e8898c9386..1d8b56f071b9 100755
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -1872,7 +1872,7 @@ _C_KW = {
>           ri.cw.p('__u8 cmd;')
>           ri.cw.p('struct ynl_ntf_base_type *next;')
>           ri.cw.p(f"void (*free)({type_name(ri, 'reply')} *ntf);")
> -    ri.cw.p(f"{type_name(ri, 'reply', deref=True)} obj __attribute__ ((aligned (8)));")
> +    ri.cw.p(f"{type_name(ri, 'reply', deref=True)} obj __attribute__((aligned(8)));")
>       ri.cw.block_end(line=';')
>       ri.cw.nl()
>       print_free_prototype(ri, 'reply')


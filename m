Return-Path: <netdev+bounces-51291-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DE10C7F9F90
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 13:30:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8FC1228114B
	for <lists+netdev@lfdr.de>; Mon, 27 Nov 2023 12:30:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5654A15EB6;
	Mon, 27 Nov 2023 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ETG81fO7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D7F13A
	for <netdev@vger.kernel.org>; Mon, 27 Nov 2023 04:30:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701088229; x=1732624229;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D940WQYb3/BFu1HPo8QXkrqY6Ed5QkphxLlv8L+hEoc=;
  b=ETG81fO7kJ5Z+Oj+HdUVOzEyN1VdSDsCd70Dg0AYg6Z41Bf7AtLFI8co
   ScD1Tu1u9i8UeQ3Zi2wFTpFKM0LCSWeRRtzc++ZW5EL5iuQ5BH450t/ju
   V0DGHX0B+DzCVYm2yR5kM32lTVOll7qqLk96NSnYNpgAPzJeM7Sv01qbI
   5Wr0nUoP+d2/JkwoLOOOeGjRAFBtoxhE0MtyvuP1eT9ivfcd5In2c1MGj
   xGZm2g1P+C7iuUkdK7wRxBVIjV4mZ6hT/DMfdv8jwP8IHQPLElm+QnXIg
   I+AUif/C+WpAIZEcQOt757zBTh93QNPVAJWTkIC/OkO2TOSGzT8Lo2M40
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="459183833"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="459183833"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 04:30:29 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="834311841"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="834311841"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 27 Nov 2023 04:30:28 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 04:30:28 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Mon, 27 Nov 2023 04:30:27 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Mon, 27 Nov 2023 04:30:27 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Mon, 27 Nov 2023 04:30:27 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KyRhr6ylP/+26S+Ezlca1XD3siJUTKMnj2A+bvcsjY6gE4pT4rUw5HckSkpj3LT0IA/YEDqd/gHYm1YkveMVixYRxM1q+ds6WDQHUoOjk66okkNRsL3F8eN202nmyMsqhdEfUTG/YIpMvA+VhN/KnpSSn4AfMOOTHRYtX4HVeeVkQrCVCQDkMPM7yHYHXvPVZt0d9JkwY/69UFojdYRC3BDqBD3x9CuTD0ujrA+qt2jbOg3NEq44rICxLxDg3tVS68Gu2NXgAGaFr+p5QIKi3yoWZ4sAcb8iF/LUE2sU0brECEty0r3Hug8D01d+ng4CqnOMNSE0wVuXM2/uARuaqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fHCc4jcg57MO4ud58mQg/1hOvHYqGqp8c+uH66PqimI=;
 b=X3JRye5xrF5Ni06gcT3QKl9RcoTAq1adXr7qFlFneoxZRPXZ0rj37VsjLWUGrYeMzJPPNnwn227TluujP4axhhSUB0G2UnyhZh1bIxA+Y8R2nDxHWo4bkiTZq/Ix6EUexZJkNvdZCeP4/8G1qK5LCN6SQAoafrCFaDZpS//HPDmDnZ2gHiEovd/KYmcWeqokLH05i1OjmW+AyUDT/+8XAsy+2fVGVjd3k3guUXDcsfgQDxiqT3fWFqWTzw/trIvcGLzOvm4GbuPe4GG4RpxpYsl3nxzOiH4mq8nIZabqUPFbK6VvuVtsFhts+uptq1Pw2tVAJ2z3+SHuBwSobDvBkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by DM4PR11MB8157.namprd11.prod.outlook.com (2603:10b6:8:187::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.29; Mon, 27 Nov
 2023 12:30:17 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::5112:5e76:3f72:38f7%5]) with mapi id 15.20.7025.022; Mon, 27 Nov 2023
 12:30:16 +0000
Message-ID: <98ece061-f21d-bc21-815a-19f34584f268@intel.com>
Date: Mon, 27 Nov 2023 13:30:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [patch net-next v4 8/9] devlink: add a command to set
 notification filter and use it for multicasts
Content-Language: en-US
To: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <jacob.e.keller@intel.com>, <jhs@mojatatu.com>,
	<johannes@sipsolutions.net>, <andriy.shevchenko@linux.intel.com>,
	<amritha.nambiar@intel.com>, <sdf@google.com>, <horms@kernel.org>
References: <20231123181546.521488-1-jiri@resnulli.us>
 <20231123181546.521488-9-jiri@resnulli.us>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231123181546.521488-9-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0102.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cb::9) To DM6PR11MB3674.namprd11.prod.outlook.com
 (2603:10b6:5:13d::11)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|DM4PR11MB8157:EE_
X-MS-Office365-Filtering-Correlation-Id: 33851daf-82d7-4c82-0427-08dbef449a88
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pePiay75I16ZAA6C8K4AiHk0rJm9/flXE5d+MJK2ZPWKK0XzSv8JDmbiPbcc+uky+iJ8s9Nd3iaA5SwWXw7Sys2XhqSoJZg211PjsFm+N7BKBqsCj3ful8GKPY89Iy4hPVjPzIvC1MtaC9W3kemEw9COjBkKw/VJEAhUttz4OnFXRqwuMfAmYGiRU1pDMkyxRcAKXMQt5At8QMV/wZ8W/0LZ2Y5GqTkUvrPkaGjMDuPnZG6GbT30DDdcEopxoY1hO341zVuoWT1zjCttsDdYf4FGgP+rR3BvYHrRDXBattTqW6Fswv3/gECNhTZ11sVh4SY+d5n/s3klpOimJYj78awZytbF8K6d45F9hqfAWSvPgF4f1G18H32x9Ny0WIjjfnbb1ZMkhEJpF6hUriAba6j/Xs37zxJnhbdQ4Q1aN4F3w76PozNANCCQwMVGIeSG7f6bRzYSrhBbpMQJtJrUSLj2NnwfZ6P3ajxuxosukVfcl1iyrOmVvQTmqrRSTuph2V/6ENuJdRPfZ/BDBDkGo1RAb9p6Nz4PMq2KfHJhv4VE5eXgdG+R1A55t0hAevwWIFIwUix89qEoZrJD2RLabqU6EBuQvLc6LXLGA2yuNeTwt0erWeKy+sHcYkrdVHCpL01MHjdHWuuckzWM7wMhKA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(396003)(366004)(376002)(230922051799003)(451199024)(1800799012)(186009)(64100799003)(83380400001)(38100700002)(31686004)(82960400001)(6512007)(53546011)(6506007)(6666004)(4326008)(8936002)(66946007)(66556008)(6486002)(316002)(66476007)(15650500001)(5660300002)(31696002)(8676002)(7416002)(478600001)(86362001)(41300700001)(2906002)(36756003)(26005)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WVBtdldjWW9Qc1JwLzgvTmwzNnZWR2djNXpWYmJjY0VDRVlNeWtLY1U1ZHd6?=
 =?utf-8?B?N2NpTHNVQkp5T3Y4UzY5eVUwMEFueFNDVll4Z3lPeGpyNE42YkdFVVM4Rjk5?=
 =?utf-8?B?WlBaalZ5OUhabXQyRXF1cnNkUHA2SDNVcW0rVVhXTUNOR2l5VHo0S2xDZ3Iw?=
 =?utf-8?B?RkpEVS9zenFGQ0p2MkxVSnErK3RsVEdTaDB5dFFDR2kwcnNya1V3ak83QUhF?=
 =?utf-8?B?N3U1NmdFRUYvTUp4UjJBNDdOcEh4U2J2aU5vUUxpbWM5WXhuZC8zbnhLNjhj?=
 =?utf-8?B?Q2Y4UmtzV2Z4NXRmOWM5NzZFeGtjQldHVlhOM3ZFNWJMQkZlKzZLMEJ0VkNm?=
 =?utf-8?B?d09YNEVKeFBhbXZwM3kzZWMxZVVxam9HS0dpK3hxYXF4UDA5ei8vQWpCaXIw?=
 =?utf-8?B?RDZxbi9jcFVGR3JxbVM2OEZWdzdMK1hVc3V5a2lNVFhwdTdMU2p2Umw1VzZM?=
 =?utf-8?B?L0RZaE9CcmFaaU1lTk4xMkZYTUZLL3BhdUJTTUNrZnd5RUNYS2lVK1B4aE4r?=
 =?utf-8?B?TGUwdmg0M2w3SU5LcjJXTGhRYVdqMUdPMS9YbXM0ZExuM0I2VGdsdXQxaUE3?=
 =?utf-8?B?SUdhYVZZell6WFBMVjBvT21TYnE2VE80Si9RRUkzVDJmYy9CMHB1dUt2ZUtO?=
 =?utf-8?B?d0ttcnRmUk95dkNWY3lLYVlacHp0OG9xK0szOS81TFZaR3JMZVVBOCtXYmZE?=
 =?utf-8?B?aTNqaUkxWHNLYXl2aTRYc1VPbmVsM0M1VmwvdjFXanZTOFZTTzErRE5wWjNE?=
 =?utf-8?B?NUwxelN1Qmg5SFJndXJqa0FYdXdPYUJBSnZjVGdseFh5M2tpdHN5WGpyV0Fj?=
 =?utf-8?B?b1MvckQ4Vm9taDdoOGVuSkVHR3pESzI2aDlrSEtSZm5nL0RMeDNYWUFBa1Fj?=
 =?utf-8?B?bDRwMDE1bkFRb2JTZmZrL3VaaHRNL2xNTXJBeng0cVJrUVphMER0TS9IYVNy?=
 =?utf-8?B?MjZtQlZFVk5tdXRzQVpCb05JOG5UYXRJeUE0R0dUc0xVUS8rMjlPeHM5aHZP?=
 =?utf-8?B?TjFYaDU4d2ZNTkpTMjc2eGhlR1E1dFJZdFBDQk5SaUtENlBtODlEQXNIcjI5?=
 =?utf-8?B?K25lWE5rQjFEYVJxb3hhSGd2R1lJVXdob0VPd2ZJSUREZmM1SEJuNmw5RFB4?=
 =?utf-8?B?VmZIQUxPU2xVNE9kakx0d1NpTWFtMWVKTjA0L3dhOXFWTWlSV01NSUY2RFM1?=
 =?utf-8?B?aitWdXVacXpQdTlHbmMvNW9SK2dwZXRkSnFLaEZwTTFyZTdNZXlkQ2JnNEd2?=
 =?utf-8?B?VjJscVdoWTNXNFhjTDNKRGRISFBFZzV2NHN6NC9uektQTmhDMXhURlpqeVJv?=
 =?utf-8?B?QkQ4aU5tSEwzWituRVdFeE1jOHI5TXZpcmZxZWtoQ2dzQkpVajAxc2VORk9a?=
 =?utf-8?B?d2RYZmZCOEpmallFbjY4R2FQSnphRUxpQjV6QVcrSlhvRWNERVhJdjFpUk9k?=
 =?utf-8?B?YTBjZ21tMFJjeHMzODIrVGhDUlJUSjI5YUxzbVlVMmZrUkN2L0w4aDRUYnVD?=
 =?utf-8?B?enF3SEFpNHRHWDBCWEJuSDV3TkN5TzR0cW0rK1ptYkhHUXVYdjJMVzhUd2hh?=
 =?utf-8?B?NkFETGowU1o1dlYyZU1iRUQ5UXQ0ZjBIUHdrZDVyVDBPbW9ZNzIvdkVGcWZU?=
 =?utf-8?B?TENaeVdhTE01U1QrL205akI3QmtWekwxMkRpMzVDOUwwOFJXb3c0aDdJaVdJ?=
 =?utf-8?B?MUEwOVdTUW0yczBvWmZyWnc4R3NGRzBROCtrMG1BbmNhZVRJMHcvcGlNVlk0?=
 =?utf-8?B?T2pxVWJwOVJzWXdEWTNIQUhUYWZET3V0R2o4V1dKYWgyTFVYeXhsc2RwSUJL?=
 =?utf-8?B?NlpaRGtRUHZuZmI2VGhVdTRLRFFrR0hkN2QyQnh2ZVFETUJKY3dpMXJ2eFk2?=
 =?utf-8?B?WXdHL25ORXBIbkFtcjRKMnd2bCtQejBsZzdIaG1MRTZVY1FsbGwzend4NTBk?=
 =?utf-8?B?M2ZRcFdtdExqQXA0LzQrblJsK2xxSEowZmtEbWdvUEYvYmJ5eVYrZCtaT3Jm?=
 =?utf-8?B?MEZycy8ySXh6djhLazJqZEJuT1VqQXJHUFYrWlp1c0hCYVB4UVNtYjlNb0Zs?=
 =?utf-8?B?RFBmM2k1NGVEMTB4SjltVTBTNC9DeVQ0YTRTVlFRWGt1QWlGNVNsaDR4cnlW?=
 =?utf-8?B?bzM2MzRmZS9hcFp5eGw4VmR3RXY3bnZNaTh1Z25tMjVwTnQ2NEExQWlCeG9p?=
 =?utf-8?B?cEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 33851daf-82d7-4c82-0427-08dbef449a88
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3674.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2023 12:30:15.0465
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uBgV3k3noI9ph2mF77iUdwizPRi58nEuQqlsXBRhgiO69UWVfwSl444XXEgIP8k/IunpLklc4BxbyMlLvtX7fdOI//8Ffezs840sRkLITTk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8157
X-OriginatorOrg: intel.com

On 11/23/23 19:15, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Currently the user listening on a socket for devlink notifications
> gets always all messages for all existing instances, even if he is
> interested only in one of those. That may cause unnecessary overhead
> on setups with thousands of instances present.
> 
> User is currently able to narrow down the devlink objects replies
> to dump commands by specifying select attributes.
> 
> Allow similar approach for notifications. Introduce a new devlink
> NOTIFY_FILTER_SET which the user passes the select attributes. Store
> these per-socket and use them for filtering messages
> during multicast send.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v3->v4:
> - rebased on top of genl_sk_priv_*() introduction
> ---
>   Documentation/netlink/specs/devlink.yaml | 10 ++++
>   include/uapi/linux/devlink.h             |  2 +
>   net/devlink/devl_internal.h              | 34 ++++++++++-
>   net/devlink/netlink.c                    | 73 ++++++++++++++++++++++++
>   net/devlink/netlink_gen.c                | 15 ++++-
>   net/devlink/netlink_gen.h                |  4 +-
>   tools/net/ynl/generated/devlink-user.c   | 31 ++++++++++
>   tools/net/ynl/generated/devlink-user.h   | 47 +++++++++++++++
>   8 files changed, 212 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/netlink/specs/devlink.yaml b/Documentation/netlink/specs/devlink.yaml
> index 43067e1f63aa..6bad1d3454b7 100644
> --- a/Documentation/netlink/specs/devlink.yaml
> +++ b/Documentation/netlink/specs/devlink.yaml
> @@ -2055,3 +2055,13 @@ operations:
>               - bus-name
>               - dev-name
>               - selftests
> +
> +    -
> +      name: notify-filter-set
> +      doc: Set notification messages socket filter.
> +      attribute-set: devlink
> +      do:
> +        request:
> +          attributes:
> +            - bus-name
> +            - dev-name
> diff --git a/include/uapi/linux/devlink.h b/include/uapi/linux/devlink.h
> index b3c8383d342d..130cae0d3e20 100644
> --- a/include/uapi/linux/devlink.h
> +++ b/include/uapi/linux/devlink.h
> @@ -139,6 +139,8 @@ enum devlink_command {
>   	DEVLINK_CMD_SELFTESTS_GET,	/* can dump */
>   	DEVLINK_CMD_SELFTESTS_RUN,
>   
> +	DEVLINK_CMD_NOTIFY_FILTER_SET,
> +
>   	/* add new commands above here */
>   	__DEVLINK_CMD_MAX,
>   	DEVLINK_CMD_MAX = __DEVLINK_CMD_MAX - 1
> diff --git a/net/devlink/devl_internal.h b/net/devlink/devl_internal.h
> index 84dc9628d3f2..82e0fb3bbebf 100644
> --- a/net/devlink/devl_internal.h
> +++ b/net/devlink/devl_internal.h
> @@ -191,11 +191,41 @@ static inline bool devlink_nl_notify_need(struct devlink *devlink)
>   				  DEVLINK_MCGRP_CONFIG);
>   }
>   
> +struct devlink_obj_desc {
> +	struct rcu_head rcu;
> +	const char *bus_name;
> +	const char *dev_name;
> +	long data[];

could you please remove that data pointer?,
you are not using desc as flex pointer as of now

> +};
> +
> +static inline void devlink_nl_obj_desc_init(struct devlink_obj_desc *desc,

given next patch of the series with port index, you could rename this
function to devlink_nl_obj_desc_names_set(), and move 0-init outside.

> +					    struct devlink *devlink)
> +{
> +	memset(desc, 0, sizeof(*desc));
> +	desc->bus_name = devlink->dev->bus->name;
> +	desc->dev_name = dev_name(devlink->dev);
> +}
> +
> +int devlink_nl_notify_filter(struct sock *dsk, struct sk_buff *skb, void *data);
> +
> +static inline void devlink_nl_notify_send_desc(struct devlink *devlink,
> +					       struct sk_buff *msg,
> +					       struct devlink_obj_desc *desc)
> +{
> +	genlmsg_multicast_netns_filtered(&devlink_nl_family,
> +					 devlink_net(devlink),
> +					 msg, 0, DEVLINK_MCGRP_CONFIG,
> +					 GFP_KERNEL,
> +					 devlink_nl_notify_filter, desc);
> +}
> +
>   static inline void devlink_nl_notify_send(struct devlink *devlink,
>   					  struct sk_buff *msg)
>   {
> -	genlmsg_multicast_netns(&devlink_nl_family, devlink_net(devlink),
> -				msg, 0, DEVLINK_MCGRP_CONFIG, GFP_KERNEL);
> +	struct devlink_obj_desc desc;

`= {};` would wipe out the need for memset().

> +
> +	devlink_nl_obj_desc_init(&desc, devlink);
> +	devlink_nl_notify_send_desc(devlink, msg, &desc);
>   }
>   
>   /* Notify */

[snip]


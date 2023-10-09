Return-Path: <netdev+bounces-39187-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A086F7BE47A
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 17:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55435281D88
	for <lists+netdev@lfdr.de>; Mon,  9 Oct 2023 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFC7436B03;
	Mon,  9 Oct 2023 15:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TaVZxugq"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04D973714E
	for <netdev@vger.kernel.org>; Mon,  9 Oct 2023 15:17:57 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A54E1;
	Mon,  9 Oct 2023 08:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696864675; x=1728400675;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QUZLJvwlja3NsR6reMtYNWgLvdCgtp7dcEVBttATPTM=;
  b=TaVZxugqfEqJi5OUSKq9OikZwyuO65P+zg5zdA1MGHqXiF616srT6xpt
   5Mx2jfqAEh/3IL0QMmJK2nYxbT1AbPjaE1Mk27aoBseZdn/JgyiVrYOL9
   4XRzqCgpTaIHuKLLvFS4+VNMcpckqv2vOG9bhMNSKK9sluBeAhHVUATK7
   sGx0A5uLxaVgm0/LhUQVAaCqiy9gfJfjgNxWbfZngwChU/e1JwvaorSyo
   OMLm87vvM57A3K+h4g32J5K+tarvScPC8SvbFyevCQN6wvjYd2Eiuoeuu
   cixrN77PaT+xZWfludzMdtd2sikVvS2dsdPf87azeCj3j54JVBNVTMvFl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="364455882"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="364455882"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2023 08:17:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="702949470"
X-IronPort-AV: E=Sophos;i="6.03,210,1694761200"; 
   d="scan'208";a="702949470"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Oct 2023 08:17:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 9 Oct 2023 08:17:53 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 9 Oct 2023 08:17:53 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 9 Oct 2023 08:17:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bGWQfpNJM5ycVuWTzRdntImWDBCo0604PL9Aksqf+4780Zbs/UdqRKWGeFgBWJUzBpeW60kwb3x6+XcCOdlB7YkSFKoyN+TLQXRYdbHL8yiAmINRQu6p9OvSyBqx4QAqG6rlaRkknlU+bZaCn8Spjsgn4tvBQCyvmwTupasIk7k4XKBbcmZmYwN2TLHVLVVLkqbkAuPcd/Hya6v32ml6mxYXnnDvN8wPXubC6N+yLJUGSpf7b6xW56RHCpe6JNwJNAeBk6btQ0S34L1rIqzD1xPU4wP08r4sfDSTnDu9BwCuQ01p8UDgf7xS6elSUUq/oqh17kkwkORdEixAjBsIXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7T7QZKMWnSIC/S43cR/NUYOXypKdlzb6FMSC35H75pQ=;
 b=APbnSg1NtArnUuAj3fRjJqV8zRwyv2MlTM6FUVnfQA62QxBnLSBvfoDKrkVDpCAr1fnFlCV6OWpK9v5hk04qewWV7DtkfHQuclr+F8jOg19RWD/ZMzIH54A7TFuFM8FJm16kO85L2PrIt7hijBokJyrIPuW5k9dvWynM6RsspjfB4nI2R6mc/BJs589IUxrM1GBVZFC/TbA4/IUuQRwlgYD8sAxPXdBc5RUFllupPWuwNX6xHp7I+bnHaJQQJti/vQZW5jsy2yRuo1cLNw8rpmay2qqVx2YGYvdWR4n3oAbvJlCx+kEXXK9gfqYdPa72pvmaKPvjF8zr6U1EdZwmFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by SA2PR11MB5066.namprd11.prod.outlook.com (2603:10b6:806:110::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.41; Mon, 9 Oct
 2023 15:17:50 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::b598:4b13:38aa:893e]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::b598:4b13:38aa:893e%6]) with mapi id 15.20.6838.040; Mon, 9 Oct 2023
 15:17:50 +0000
Message-ID: <95370ca0-c60a-ad91-aa22-60a1d9376461@intel.com>
Date: Mon, 9 Oct 2023 08:17:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH net-next 1/2] igb: Fix an end of loop test
Content-Language: en-US
To: Dan Carpenter <dan.carpenter@linaro.org>, Jinjie Ruan
	<ruanjinjie@huawei.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Jacob Keller
	<jacob.e.keller@intel.com>, Simon Horman <horms@kernel.org>,
	<intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<kernel-janitors@vger.kernel.org>
References: <4d61f086-c7b4-4762-b025-0ba5df08968b@moroto.mountain>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <4d61f086-c7b4-4762-b025-0ba5df08968b@moroto.mountain>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0028.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::33) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|SA2PR11MB5066:EE_
X-MS-Office365-Filtering-Correlation-Id: f939b372-9c8a-4545-7b31-08dbc8dae703
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sy1M8XQ9Buyz5Dj6UapzJjAjr9ysl8cCt57L7PIjfwpeiG97YybWpVIe/MM0rauE2KP//PQbfoETfZOqMBQSntbOIkU7IqFQx2DgNnnneRjXQhMF0bkaYRunKTDFhAQ2OxE3DhV3Ji7AQ+GLdEOkIjvZu/KKPKXB5/jwr/h47d/FaU4Y0RUU/h/v0g8B8gXQLiKGd/qJWoOeBoVFzuh4E6z6pXtsvJ/eZSHfEr4NutqKtPfM7Lfu6HCg9x5dWeiS0nskf7f8b8Ftyg8+s9O76E3yoxolMXPrUW7d4bSe6rh0ttK1sk8T0tOoNrty/uf6CjgNQiHHUsCBDL0fYrHqDUNAdpe7PGfGB+RwtTZIvG+wUeo9gkFI+5Z36QfaAUasCoKcx9q/kUJXITCtiXB83EhAlV8Jo//RqJNByRDdaGXLJmvDPp6kGqyIN6qi1wsciiIaL8fSTw5v7TUM6uj8G3UeGtBu8RicJJJeF6tGKFjUnlCKgtJJq4Ajt+hP7QRttfo2UZnxfY0SpKhHKpBOzPYkZ/3ZqZp925ARrs0/KXRiFWilua+1X6/XaYVO8d44+kBcD53wLcf6MFaaeclLwpdbCOIUKkmQ4Ia19oJFJl4RRGRxhPAFyWIe4zNnydLgEeVIrPIXmAkIUZaRyKQJ0A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(346002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(6486002)(53546011)(6506007)(6512007)(478600001)(26005)(316002)(54906003)(7416002)(41300700001)(4744005)(2906002)(110136005)(66476007)(66946007)(66556008)(8936002)(5660300002)(8676002)(4326008)(36756003)(44832011)(82960400001)(38100700002)(86362001)(31696002)(2616005)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXNpNUlpa1BOMEpNcUVtcjZ6VExIMHBram9uQ0hxdHo5Y1hMbVJaQzNmSFRM?=
 =?utf-8?B?ZGRxY0tjbWJReGIxZzluUWZJUlBRc2dhVHBnbXNsR0ZaMDhpaGhIK0daVDhD?=
 =?utf-8?B?U2U1b1QzVnR6M0hCYTlzeUQxeTA0bG5FZmhXZXpWME9kYVh1K3JrcjdvZE53?=
 =?utf-8?B?dTY0d2k2ay9Mc1NYR2RKa2xzT1lFWEpUSW9kVG4wbTU4YTNXVnNlaENIem1q?=
 =?utf-8?B?ancyaWY0cnBBaUgwSUhsa1k1SEpxb0FIZlZZN0hKdHkxWnljV2cyVzEzcG8y?=
 =?utf-8?B?bUxERFhIQ3Q3cW1HckdHSS9Ecmc0SzE1R1V4eGR4dHJLenpEbnpWRWMvQW1n?=
 =?utf-8?B?aUtvVjUzNzFuMFJETUMzZlRWTTFNT0lnTTZEYm80cG9GNitZc3MrdDdkdlA4?=
 =?utf-8?B?UnR4TkRVcE5odnl3b0QxeUh1NkF0UndVcjQ2cUplSGVRNi9SVWpUQXlmT3k5?=
 =?utf-8?B?UkdsSVpPc212eFR6U2UvYVQwWkNYbGRRMG5ocStOODhZRWxhK1ZiWnlEY0NW?=
 =?utf-8?B?aDFPZUNoVVhLU1ZmZFV2VGQvNGNnNStONmF3Q1F4QmxxZWQxOTArYSs2THht?=
 =?utf-8?B?a1NadFd0YWpyVUJJRVJrZUIxLytyelYrdXdsMnZOc3h0V21vdTdkWTBkUWE4?=
 =?utf-8?B?Q1BUN2J6eC9GSXB2SnQraHdMbzRCcEtIeisvV1pMb1J5bWk0L0l6UHV4Rzgx?=
 =?utf-8?B?N0xIdFg3L2o5bVZtaU9kTVJRYTFHNDJkSDZiSEZEZG92RUlZbjkxSndzUDFw?=
 =?utf-8?B?amppbGZjMHJRVmlyNGRHN3l5Z2ZQZHdRMkc0Mzd2WnVhekZRaTVoY2lsaGxI?=
 =?utf-8?B?QTZPTWl6a0ptWnZEWWl5Q2VJWnlEQU9jL0tqWm55R0tsUmduWXM2K1EzRUVx?=
 =?utf-8?B?K2w3TW9MMmdxME5lVWRXTzNlWG9RT0gxUG5lQWkyQUl2Rk05NEtKMkxnbWR0?=
 =?utf-8?B?ZXRwUnJpOTZ1Ly9xekVrNDN0eWdvUUpZTDRsYVR4YVhmdUJZVnVvTzY5ckVs?=
 =?utf-8?B?SGY4R0xaeC9ZZ0JSK2J5RUU1bXJuVkpuVDJmaVY0SXk2cThFU1IxL2ZmOS8z?=
 =?utf-8?B?S2NZU1UyU29nS0pQS1QxMUlRK0tyd29pZVJ0N0ltQ3owM1B5ejFKUFFrMXc0?=
 =?utf-8?B?cUxFU2h3b21MRjFvSlVjT0NyQVJHc3V2azlPRDRCZUozTzV4YjI2TnU2TG5o?=
 =?utf-8?B?SHNMdStocDlXeUdNRXlvNnVDenJWVHhkT2Y2dzlNUUczZDNZc2tiTlJQM0Z1?=
 =?utf-8?B?TjM3VlN2OXBNM1hMNU96dTFndmJyNVZKOTFsV0wzTFR6SEI2UUNpRFA3c3cw?=
 =?utf-8?B?eFZFRmJGNS9qcTJ0c1pBVHZhZ3pacVNkRXphcExKcjRPS1ZTN24xdHVBNmtw?=
 =?utf-8?B?em5ySGhVNS9qS0RtMHdkL3dQdmp2ckZXUjl2SWp4am5VNW5XTkxoU3lqRkd1?=
 =?utf-8?B?WHBPQ3hxMXp4UGcyRG13Q0ZrSEJ3T1g3NjFlRVMyajl2TFc0ZHk1NElnQUIx?=
 =?utf-8?B?Vk9uV1l0VEFEcHpJcCt4ZWl4UmY0RjdkaGhWcmd0NVB1YVppbXROaWlPT0RQ?=
 =?utf-8?B?RkkxRzVQaGJkZUQ0N25YODhRckk0QzlNajRUU1YzZXkrSUNpaTVsMzNFVnBy?=
 =?utf-8?B?YnBDM0NlKzkvUzUrMndWcTJFWDVjZUdieXEwT1VDdlA3UjVIQVVFUFVHZ25i?=
 =?utf-8?B?L0tUM2t1OWxMSUVqcGhLWkNHZFVFSXV0YVlORkZXbEhaeWt4d3NiSUxtbTZM?=
 =?utf-8?B?cUdRaFBRSEdPSEJYb1RGbk1pdEROSDdjaVRCWUt4SWYyVEkyYUdOTDZCRFAx?=
 =?utf-8?B?bi9ONjJFSk5DRy9JMG1JdjZpVVpaRjlZYnhJWGVnckxnK0lzdER3cHlJMTJi?=
 =?utf-8?B?MG1IZlBtRHh6ZkNhaHBFT2FIWXB5R0FVL2VvNVRpL0phbHYyRmt3Yld2Ti80?=
 =?utf-8?B?TVZJZDQ0b0NYczVVVEQ5ZjF6bmtuSzg3UUpRclNKZnpUcklYNGJ1RGo1MVhP?=
 =?utf-8?B?THRHa1FWMjd2QTVQNThneDBYcmNXTDB5YXlWbHUzUXF5WVRaWjllV1dzcnB4?=
 =?utf-8?B?ZGI1dVQwQ0p6VmkwSnVpeC9aRWx5UG1KbXpHa0lpQ0xVM2lYdjZ0MGFacUd5?=
 =?utf-8?B?VE5MYmlOQXlnSENLMU5BeUhTN3VwRmY2dzl5SGZGVVNZM0s4ZmJkdVUyVitx?=
 =?utf-8?B?MXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f939b372-9c8a-4545-7b31-08dbc8dae703
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2023 15:17:50.8323
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8wlTggDUXJZblSKoaLny5U+gTJxhCYBxg8gSSSUyN1i3bLckr9S/Z7113d0isJwazhCzHGuMV5tDHV4yA1L1KUADaw84WisAEZsgVISwVuw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB5066
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/5/2023 6:57 AM, Dan Carpenter wrote:
> When we exit a list_for_each_entry() without hitting a break statement,
> the list iterator isn't NULL, it just point to an offset off the
> list_head.  In that situation, it wouldn't be too surprising for
> entry->free to be true and we end up corrupting memory.
> 
> The way to test for these is to just set a flag.
> 
> Fixes: c1fec890458a ("ethernet/intel: Use list_for_each_entry() helper")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>




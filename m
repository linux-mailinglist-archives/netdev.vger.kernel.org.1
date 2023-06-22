Return-Path: <netdev+bounces-13062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5816273A119
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 14:43:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8031C210A3
	for <lists+netdev@lfdr.de>; Thu, 22 Jun 2023 12:43:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00CCD1E527;
	Thu, 22 Jun 2023 12:43:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD5263AAA0
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 12:43:07 +0000 (UTC)
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E3919AF
	for <netdev@vger.kernel.org>; Thu, 22 Jun 2023 05:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687437786; x=1718973786;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q/42kVgw+/oWdl9LKaCECphNT9Jz7/iF2aBBuyd0Ii0=;
  b=TBwGJWEzbraFi0dEORvZVK3oB1qz4E5LfxTy7T3c8Xcwava+JbmfhdjD
   +Iid28m3pZv7Jxsax+iJ7igRAW/6TeFelnZLtBqMACm9HUnkvZN6IjY6b
   LeQjlFsrRIeQo0szID0Rg4SpEcR3NwHoTy7c/DrpSAlY+pU5snUZL/VAf
   56a1iwyxL/8bRSoRtxhWzM7TkXl2B2YOrYlILWAqM5CttOBShm8u1Vx9G
   3RsK+gUBQTmSa4wrzx5cYzQX4TFfqc+VIaqjxxpVC8LQcWdWzGh3VwsoV
   ++zVsH2Xs9h2Vrlmb7hfAxyX5eaTeEprAo8aL/hjgB2kMJX5cl/8Yk+8G
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="446850992"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="446850992"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 05:43:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10748"; a="692244657"
X-IronPort-AV: E=Sophos;i="6.00,263,1681196400"; 
   d="scan'208";a="692244657"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga006.jf.intel.com with ESMTP; 22 Jun 2023 05:43:05 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23; Thu, 22 Jun 2023 05:43:04 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.23 via Frontend Transport; Thu, 22 Jun 2023 05:43:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.170)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.23; Thu, 22 Jun 2023 05:43:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HAG5Vd37pNxezCMuQBe9Ed2dc/OCD58NAVTAj9/YkCQwF4bTNZ10gLK9b63G9YLgBsKoNSfQrj/Kvnc5bNL1Z1iclTM/b9LfuTRWqXujpTwZLxUzDuuVv1+YplJ7rBL1u3fv0K7T0JUvQS/LOMQVSvXLQRbTUEiCgJSfh51iJ+5t7Cp47VfRoTnczx/NkR6ktuI06+fEcabdKZHHjuc7pwGshk/7hYG+ob1AfFEgReYouVLLOMcvlJc3ERPXLACAKXw1v+HnkKx193nxragJhoyM9TDSuW5PgULTB7I+QXQ1v4OC6RFoJhLT6njkWTOkQlyq60PQdGL6pSUPAFBe1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lCQ2dqByvThSfqxv4TQ3ouyH3YvyVDR7fom2l6eznRU=;
 b=Vkz4Inwh3CVF5P435cdVzEzpFUNCI3NJpCywYrR6vMXX0Kl7fJm3/YeizBv0TmSCeCN6H1+vky2iqLefhLvcpr45sXJemI1TD2Zl41P/kxCID4kK6obdQZbEAFRP9VQ4gbMeroxsJHc8NoL84+16lqkzyIOJ8uax+N0MuMyjdjjcykxarb/oNoVaDyx9cVzD5gtTzUvOEoyJf90Ty55tj4oBL2UvZJ62Y/1UMT49Eq4gD5U7Rv8idG9iwB8OUOOL/pEM7hAB2YtFrPCP+Y+UJLZkfgICUfnXnyKl3iMtX1RA8ekrTA+g+RkbgF8JzPX9vONbkp0R4CbEkMF0BiDlgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4451.namprd11.prod.outlook.com (2603:10b6:a03:1cb::30)
 by MW4PR11MB6864.namprd11.prod.outlook.com (2603:10b6:303:21b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6500.37; Thu, 22 Jun
 2023 12:43:02 +0000
Received: from BY5PR11MB4451.namprd11.prod.outlook.com
 ([fe80::c5b8:6699:99fa:fbeb]) by BY5PR11MB4451.namprd11.prod.outlook.com
 ([fe80::c5b8:6699:99fa:fbeb%5]) with mapi id 15.20.6521.024; Thu, 22 Jun 2023
 12:43:02 +0000
Message-ID: <a5ab1ef6-1bc1-3e98-7f8b-5c5a3678ca8b@intel.com>
Date: Thu, 22 Jun 2023 14:42:53 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH net-next] net: fix net device address assign type
To: Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <intel-wired-lan@lists.osuosl.org>,
	<przemyslaw.kitszel@intel.com>, <michal.swiatkowski@linux.intel.com>,
	<pmenzel@molgen.mpg.de>, <kuba@kernel.org>, <maciej.fijalkowski@intel.com>,
	<anthony.l.nguyen@intel.com>, <simon.horman@corigine.com>,
	<aleksander.lobakin@intel.com>, <gal@nvidia.com>
References: <20230621132106.991342-1-piotrx.gardocki@intel.com>
 <ZJQE4ieud5Mf8iGi@nanopsycho>
Content-Language: en-US
From: Piotr Gardocki <piotrx.gardocki@intel.com>
In-Reply-To: <ZJQE4ieud5Mf8iGi@nanopsycho>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BE1P281CA0194.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:b10:8d::19) To BY5PR11MB4451.namprd11.prod.outlook.com
 (2603:10b6:a03:1cb::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4451:EE_|MW4PR11MB6864:EE_
X-MS-Office365-Filtering-Correlation-Id: df5ab746-dfde-4d01-e03a-08db731e376c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X0675c/fHUMfQ1nWMjR4iFKzHDCYH0/5OIkKc/3on09LQUkm5AUEVm1GXb/pfvI8lNRrvXlk0jMxSpmNiBeE3N6veBWujyBi8wAHuS0Z2OdkMHVpSSD22Bibhgpor4XPCtISnDUtphXfMiNSAcE8M/UgJTL9Xf+sz7S2IjcgyfS+9zIM2qUv2z+3Rs+8wG0gMUBQplLCR1msbDzTPInt42Z6aslyZGQZ/hpHICO+la1zhUNrgAUigqd8HgenTb2Ju39cAS41DNp+qu8P1vOAEZ6aR2/4ZGnCl24vOWjKNtJ7bd5d2jG8RA24Gqd1Z3uUELW+/siaUQZ3XBPLZJPyGMSxTTNgWBLFFkwZ3WDuvTKFuxuRlCX1TDeuqNyBoi0UNRSpCKEGYA9wF9X0iHRQHxLjDK3uBU6lNpg5AaEsKTVDhLi8PWx7GuS6zlQjdXGGGkMvWIkayfz56EZL6uFdyN+iXXUVGAVYAoDQc/Gvjec2IYqfV+AnWQ6f+BOC3Lxsufphcc7pYmtY5Qy9xDrCU8jFE7woFE4QB10phSFdTR9u14LQLLs8qc0LEWuSbJiMAHyImqJxC7W0OlHeFl9piDbGNQxcNJ+wsnkYC3y9+dy7HHfxcZyweeugD8pvLPftI1FyYjmzRwjzUfpk5S8Lsw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(396003)(39860400002)(376002)(346002)(451199021)(8676002)(66556008)(8936002)(66476007)(5660300002)(66946007)(4326008)(316002)(186003)(26005)(6486002)(6666004)(41300700001)(478600001)(36756003)(53546011)(38100700002)(6512007)(6916009)(6506007)(86362001)(31696002)(83380400001)(2906002)(31686004)(4744005)(2616005)(82960400001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?T2NOcW1paTRGWVdsSWR5L21CMFpYc2w0WlVDd2V5ekRBRHZRL0pjYmJCS0FT?=
 =?utf-8?B?WU1nTzRlK3FXSTVnN2ptS3Z4QWRqT050RkQrajFUR3BWM1FaUFFKRTdKNlNt?=
 =?utf-8?B?MDVFNjZEb2NsR3BXNEE5RW9CbkJrQUxrckZrMXJ1MjlpT3FpMllVMVZCbFlJ?=
 =?utf-8?B?YlZnYlY3TllJUnRHeWF6N2sxU3VuMWJTVVNnQXBjRkRuR3diS21Lc1FHK0ps?=
 =?utf-8?B?U3I1WE1HbU1xbFhibFFjaStya0t0Q1liU0MrcDhFaXl6b3A3dWo4YUwxMkNK?=
 =?utf-8?B?cW9HVFVsSW9GdGNzbUpCTlZNUVVkc3BXZDB4TzE3VGZFeHJYYzlaZkZBSWJF?=
 =?utf-8?B?TkJ2RXVPelZic0pmMzh0Q05CaTJ5VVJlUmYrR3NNWHNsRTZXSGdSRWk4TkY3?=
 =?utf-8?B?WTBYaUFhNW9sbllXaVVhWFRCVmZYVitMVmNnM1psM2c0cmJoWWJrbnRBUkdT?=
 =?utf-8?B?elRqYTFuRkNvUFQxWFphc283emVUZU14ZlcyN0dKZFByT2FuN2pMazdvR3BW?=
 =?utf-8?B?d1FMM3BudmJFNk9LaDEwWlhkTHpiU1J2Z01oZThSSFk4TGFRcS83c1RpNUpX?=
 =?utf-8?B?blk2K0pHeGZFZHgxTHdBWEt3UllPdkpNRHZqNHVrVkpQaW01UkxvTnNhTTJN?=
 =?utf-8?B?MlBmR1dBUFdHV3ZtWmRDMmF3SGJHamxpeHhSenZSZSt0UnVFSGcxZm5wNVU3?=
 =?utf-8?B?K3JySXYwaG5YMk83dEtXeG5lU2hWTk1TVmxjd3J1QWhrSE9nMzF1TVpwN1oz?=
 =?utf-8?B?UXlmWjkxMjJpNmdLekVBNWg1eVVGZFV5ZGFRK0RGVGVnYk5wYldjeHRJZVA4?=
 =?utf-8?B?b1pUQVhHNzRKNW14QWY2TnJGaTF4Q3JnQUJkZVh6QjJlT0VSZ0tlNXczUkxB?=
 =?utf-8?B?WDN5TXNsa3dWZG51RHFtNW9NQkZqUE0xSUdKRmxCRFVZeFRZY1FNcXVZbnB3?=
 =?utf-8?B?Ui9aZlJQeEhPeEI3REM0SnVCZmhUZFcxTVYzekFkMU9NT0hUUjZPOUtkSXA2?=
 =?utf-8?B?c1pQajkrZ2xDNmhyYUdsWDdodFNBbnZhN3Facm9BTWRBY0NIb0xZb0swOU1T?=
 =?utf-8?B?SUZDM2J5Ukt3SkhIR3phb1pBdDN2Q1RLRzcrSlVMUy9lb1ErM3RmbWYrSDRp?=
 =?utf-8?B?K1BrYmJEWTdaS051YUY3N0FiVzFZamdJSlZDbnJlTHU3MzZLVmV4RjBWZ1Ev?=
 =?utf-8?B?T2NGeUp3SCtxVi9YQ05CZ3VNYWJCTy9WODkzNTM3eXRWTTlaSW9uKzduejQ5?=
 =?utf-8?B?UElKdXFDSEJyT3hPdVNYQ0Y5VnRLRUVjUy9BOTBENWhDdnFSYVRidFdYNnpZ?=
 =?utf-8?B?dTM4N0J2WUE0NW1hS1hIMG5JdFFVbCsrRi80Wk0xaEJMcktwTHRIS05PY0wy?=
 =?utf-8?B?Z0hudklWc2JZU01ML0k1dWk3REZCWkZ0NUdzSWtFUW9HNkFDaXh2b0djNkZo?=
 =?utf-8?B?MENDRXY1cEZXUEFWS2ZZOTZON1JCbEs3KysrTzNQK2JWSWZiWVNZZTBCNm9P?=
 =?utf-8?B?RkpxTG5yOHlHTThkUStmT0loem1sVGdEQ002MFprK0M1T05ZMVJKZmpTWGNs?=
 =?utf-8?B?TnAyOFpzSE5WcjhheWRVS0xMQmxvWmZKNjd0WC92TWRrRlFtRjFGWGNWN2lE?=
 =?utf-8?B?MFFoK3YvSXFIQ1dtckdGNEdYKzlxY3lidExGeE5CM3JlVkJpVFdZKzZFdEpl?=
 =?utf-8?B?Skd0TDdNMmxPNnYwbEUvc3h2OVRKeEtFSGNuYlBwWktIeURvQU9BUUlFUkpC?=
 =?utf-8?B?bU0rNjFRazQvWGJDclo0ZTM4UnlYdTZTd2FHb2NGbXM3UzJONkZnTm9nOUF2?=
 =?utf-8?B?Z1lFS2ZGMGo5Y2dISituK1NjSE5QVjRQWUhGQUZJVkNJY2laRHlVOFpXbEdF?=
 =?utf-8?B?bGlITW4zeEIrY0o4YXFQUW54Yk5ZaXVYOFMxb21XRk55Z3RueHA5aWppb2lE?=
 =?utf-8?B?WlRBVjh4RnVPMXQwQWRyRnEwNk9YNVNEOUg4WkpYSHFJb1JCZkFxaUFQOHlO?=
 =?utf-8?B?WTFFaDI5OW9sSmV6eWxYVnBjbWdrdUwwc2E4dTFNL3lzbE5LbC93alJyaEhV?=
 =?utf-8?B?d1RySlZOUTNqVjFTbFJJSFhGY2dqQkljUDZub3N0aCszc3VDNThSODFHSjJ1?=
 =?utf-8?B?cnZTanF5OElXQkhoeThWamFjdGdFbEI2RCtWUU1nQnQ4Z3haandSMVZEOXdw?=
 =?utf-8?B?UkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: df5ab746-dfde-4d01-e03a-08db731e376c
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2023 12:43:02.2772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FgGghnVgwdA2JWmqvB91+TOfZsj356nlPHePc/gD5AMovKpceGSduQadD9nXEwd5zXE8wPrIK8FvpIA1Q8dgwT7JI6XHSRYkF/x0w7unJEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6864
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 22.06.2023 10:22, Jiri Pirko wrote:
> Wed, Jun 21, 2023 at 03:21:06PM CEST, piotrx.gardocki@intel.com wrote:
>> Commit ad72c4a06acc introduced optimization to return from function
> 
> Out of curiosity, what impact does this optimization have? Is it worth
> it to have such optimization at all? Wouldn't simple revert of the fixes
> commit do the trick? If not, see below.

Thanks for review. My main goal originally was to skip call to ndo_set_mac_address.
The benefit of this depends on how given driver handles such request. Some drivers
notify their hardware about the "change", iavf for example sends a request to PF
driver (and awaits for response). i40e and ice already had this check (I removed
them in previous patch set) and we wanted to also introduce it in iavf. But it
was suggested to move this check to core to have benefit for all drivers.


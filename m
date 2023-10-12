Return-Path: <netdev+bounces-40483-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C40A7C7844
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 22:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A86611C20E75
	for <lists+netdev@lfdr.de>; Thu, 12 Oct 2023 20:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9783D98F;
	Thu, 12 Oct 2023 20:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PZf2K5Xp"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DA0B36AF1
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 20:58:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75EA5A9
	for <netdev@vger.kernel.org>; Thu, 12 Oct 2023 13:58:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697144336; x=1728680336;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5Jr0Gj3SGr9VzHHtvlAXdUrqFfGYEeSLPwTgqtRweVg=;
  b=PZf2K5XpeRrEeYT934OC6FuA9gGgToWb0XEmhjwsmivLUUcV1W64/mTX
   8z1vcVYQxzfMeHuR6jqWouO0+VIYM1X4Ook3eYSmgVQaQCJqawThmdcf3
   VolmOfocRtuwc1hZcN92orxRG08Nv/jFT8gGsDLXL0hNuz1bywhjpJjc5
   XaojindOhWhUSm3SKzWfr/hqXSzjQ8poo3By5GI6QqbYW+TkT2u6QYImj
   3GgYIS4bIuMbQH/D9+2ipPipYJc1oMq9mGcxyZ8617k8TZI1K1CLPZv+R
   /QlROClX7/FtVWbB3uWJPIQDggYGLcfG0LN2co5wZdUB6GUqVPor0VOBD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="370108661"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="370108661"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Oct 2023 13:58:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10861"; a="704332720"
X-IronPort-AV: E=Sophos;i="6.03,219,1694761200"; 
   d="scan'208";a="704332720"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 12 Oct 2023 13:58:55 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 12 Oct 2023 13:58:54 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 12 Oct 2023 13:58:54 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 12 Oct 2023 13:58:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D/QZJtw4CNd1OKhFmHh+bEqBHHW9QtQ1IAssM2zYwidbF8UQngmZlhzvHLezx3lkLwmEakFZqDqq87uBPJHPJdEyznwUCmhcHozpYHdB5nORF/X85s2nsxt9y1sX9nO0hOfRq2jlz14f+iMplpKcOPwfGQP26yvYi47o/DSbFWRLS4seuWxZmZnHOdrHFenmX3GHE0dmAF2fcYEN2uZMA3Go5zo3/nALOV+zrVf4Id6mIX5fjNaksDtDr0wEQut8tgPOza+burUjWJn8mYHWyFFNEVBYskMg3/KuGuCmUtr1b6Yq/UvgrJezoRrsq50ZMXiUBQ/oLTRz0IbFRQRBqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3EbNXFzgcusypWXccSTTCORpK5eFOENlZ4HRc8dy3TI=;
 b=AYE7erDVcqYFHGm2mtZylLYlAvwP72l6+xmAx0+KS6Uo5UqWcso0xaewAetqhETVwUhzxUCTWgFf0yJRBe6GLxRj9D8LZjNreIEkpBrDGiZEycG5acbqvPoIc6tAoBQv2pWRglBxUSay5YYJfkCWiaU6GEGYlmTe8IwRYjEHbqfSKOsRbP6/pBfMvnf1M97b3b2tquQ6qdQF1RBInVhqBngo+F80RJwX2rRzu3IYwq8B8o5Mcd2dMT1Kk5+iCMOwKImas6elRfBG+wp+oAtk6se2nyv0buZ24qqQx0TzOyTC2G/P6azdOnBZI43W1Sx8R4XwiqCnXGbqmYgzZrCqyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SA1PR11MB6687.namprd11.prod.outlook.com (2603:10b6:806:25a::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Thu, 12 Oct
 2023 20:58:52 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6863.043; Thu, 12 Oct 2023
 20:58:52 +0000
Message-ID: <a78361eb-7f8b-4ff8-8043-0fe14b740f95@intel.com>
Date: Thu, 12 Oct 2023 13:58:50 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next 01/10] genetlink: don't merge dumpit split op for
 different cmds into single iter
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, Jiri Pirko <jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <johannes@sipsolutions.net>
References: <20231010110828.200709-1-jiri@resnulli.us>
 <20231010110828.200709-2-jiri@resnulli.us>
 <20231010114845.019c0f78@kernel.org> <ZSY7+b5qQhKgzXo5@nanopsycho>
 <ZSaGiSKL5/ocFYOE@nanopsycho> <20231011094702.06ace023@kernel.org>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231011094702.06ace023@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0094.namprd03.prod.outlook.com
 (2603:10b6:303:b7::9) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SA1PR11MB6687:EE_
X-MS-Office365-Filtering-Correlation-Id: 01efe0ca-1977-47dc-d069-08dbcb660a7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YZtRh56j6N7IfRAjqgg1063P+0huaIImtiQxuMNOmd8C5YfQbekVj2L+s3cSMxKlnFb+RrbC0PnMhFeEEqCHHZ7taiIfyBQbUtf8uYg5WQ5jrkAJg0XCnY4zs8CWneQgfwPNxxsldoOAQscGC0ODuUrRZg3E5S/WX5aLIJqkQwsq17pjoz+cnT8k2O+4kev0PNQ8zL0TbwQ7XGUYIBWBxyY6mzTXcgOqSI4rPQSTfSpfEq9MB+wUThIZDHuvYfR4CFLhjOfJH4D0WpjvP8huCYDHD1Pn62GIwqiLTboiJbTa+3aQ2Pu9wql3rNqLxL7g1nOiUAk/6goEYarlI84Km1lS6362dUO+Ub7jW1IITwD2yLsb5/RHMQVDJNmBsw+kiUhPcCVQimH6tnPa/iDEkRNXVTvvjJubKosr5YRS34auGl1Sd0fd0gJZK4rNP6o1q88NhuuWhJF8Q/Ky107uscaKF7NPH2hqDpD3y0umlDJz34xu8fLQAttv/Eeq7LeRIRAnKnuwimWoX7dcx9BJqaqZeXFR/t0Aqyke+lzT379nzEEPJFoCT1ovA8FuIH9opae/UgaU8LykSbz/ZoJPDgPr89i52rhBAe74LDUZFA0P7uubU/5PSJHwsSofrCwC2A6+K+Eqh6hH9jq//6ugww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(376002)(136003)(396003)(366004)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(2616005)(26005)(6512007)(6506007)(53546011)(82960400001)(86362001)(38100700002)(31696002)(36756003)(316002)(110136005)(66476007)(66946007)(66556008)(2906002)(8936002)(31686004)(8676002)(41300700001)(5660300002)(4326008)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZCtNUGZ2cXpMOTdqS0hhUHAvSmp2a21SQ2VCa2JBTzFVOHEzNEhuanhHT1lr?=
 =?utf-8?B?WnRlTlgzVWJIbkJCKzkzZTBVZzVBUUJBMlc1VWI0YUtNdmtya1hFVDZiY2w0?=
 =?utf-8?B?WU5JV2ZqczBCNUo4b2VSQk4vMXY4Vi9CbnVzU2J1SUs4LzlpMVd2em1IUFQr?=
 =?utf-8?B?bm5TTWZPTzZDR0lacGt4dGU3ZEpSb0VTQkxVTThwa3Y3WHZ0dm1keUtiZkcv?=
 =?utf-8?B?cUo3M0RpYzl5cUY1c3grd3RuZko4eTRtZDI5TGVmYlpUSmlCM1BGYTBHN3Vz?=
 =?utf-8?B?U013MXRnQVhHR3ZZK1VQbnlRVEhmR0prWXg1UmdTVThBdk1DWCsrUjI1Uy8w?=
 =?utf-8?B?WnZ0UzYrWjFMRHduZFkwYWlHZlBieGFFUng1NUFNdkczM0p6bS94SVJQL1Rv?=
 =?utf-8?B?VGpwc1JDcXBHaWZwM3NRNXlpNjJSd1o5TGRyVnlGM1Q3SXpTd0RIZG5RRk8r?=
 =?utf-8?B?UFVzekZNQ0F4MXlYTFBvOThSelgyRWVEKzhDTDBqazhhSnpYUHpwYW1IaFQ1?=
 =?utf-8?B?RHpCaG5aaUZucHVrays2dVd3dnhjK1FWaFlOenkycmVwckxBUTZMTko4OXI3?=
 =?utf-8?B?S0VjQ0RINW5HMVhXNENxUklFWldUUE8xenZ5cStiZFd1bkN1TVBDcXZCcGs0?=
 =?utf-8?B?eUxKbGFMaUREaHEzSGlYNmJLMWJvOWwwYk5aakgyVmJxaWNvWjBqaTBGUGhX?=
 =?utf-8?B?UVNqTml0Y2ppNVVDRWlFSjhIamdBd296alVGcjVBRDZZRzNwUXhlU2ZjK0I1?=
 =?utf-8?B?UHRmMkV6WmNyOWJUb05XZC8xZnQyUjltNmpaejJYS1N1VStjb0I5OG94aG5j?=
 =?utf-8?B?YWFiK3BOcFJjeSszOCtzcTMvb1RhaWo4OUxHZjg4ZkZ6UXNyYU1CbGowSFAz?=
 =?utf-8?B?NGxoRFZzR3Z3WUdYbHdJWWI0dklISTlTTncxNml0cmlGMG5kaXJkMWJYZXRV?=
 =?utf-8?B?SEx1ZzhzYXUybldqUGwzVGYyQ242S3VXc1FsNzZ2Umt4NGZraUlpQUZFa1c1?=
 =?utf-8?B?STFMZTFENWxTNjJwdW1rTGQxZEtSYXJBc0VIWS9JY3BldzJVaHdQYWg3TEsz?=
 =?utf-8?B?WkpkN0g5N2FnSUxjbVBXbVVuL1Q4anVwVXNrc04xUEpzYmRjZU9uQmpWeSty?=
 =?utf-8?B?SGQrWXkwOVpGQzRkcFRWSTlaTGdTQWdLM0YwK0ZVQ043ZlZ5YVV5VzByWkVq?=
 =?utf-8?B?aFEwaXV4OHZJMDRONlFQRVpVQWMrNWwzUENmWWY1bmtUZ1M1UlAwNEs1cTRL?=
 =?utf-8?B?MmZud0JBRi9ORmFydVgxRXBuZGdqSGFENGZ4YUlSTkExSi8zZ1U1eDh0cThK?=
 =?utf-8?B?cDQrbzBrZjdwZmtUMnlGMTZoUFl3Zk85T05qS3BDeHFSbHlyQVpzS2xFV2lQ?=
 =?utf-8?B?azMvd2FVYndOSGR6ZlNWcTI2RG8yS05YVDZma0JSNEVhV2Vsbmg1NGxxVXU2?=
 =?utf-8?B?Um90SFJNWk0rTkZaNEVqQ29DeEo1ajJpRUFHSmw0Q2dtdDlGekhXaGxxN3VS?=
 =?utf-8?B?QTZUV3NyaUw5NlZQMjJhM1RKME1KbXUvZTlvZG9hcDZ5bkRSZE83b054RUJC?=
 =?utf-8?B?OUlmL1RMWVNWeWFWYitYaUZrQ2krMlNucEdWdk1rZHBVYVNtRkNYcWd3QXpa?=
 =?utf-8?B?M09QMEZlZnF6alhFcDFxcTduVU5sTnR0c0FJaHR4YWQ4REdPek1TMi83MVpu?=
 =?utf-8?B?TDUrUDg3enZEWjBuN08wMlB0T1VzSE83TEVIWG9UbXlJNTVUaHFHeUdxZ1VZ?=
 =?utf-8?B?d25sd0NJNGhJTkMzdVVCc1BQdFF2SjVDWG52Zmg2VGlycEkzUWZiZk5ITXNH?=
 =?utf-8?B?T2dpOHI3ejFBVmw5WlRLSVhFVGh3N3RRRkdJdjlvNWZzTjBrVDc0aHBuVlJ3?=
 =?utf-8?B?SjBVRGlGVW42OWxLU2tjV1R1S0VkcUJoZG52NFNFKzVYWW5XSFhwOGU4enBm?=
 =?utf-8?B?blVmMWR1ckZkdzZEOWJMYUF1b2NFKzV6YUNTS213elRqdTN3a2R2SWs4K0xr?=
 =?utf-8?B?MDdCN3oxZzFyRXlUN3lSbTlka2dpNWw5U0VBMlVLNjdBbzR2NmRldTZwb2hm?=
 =?utf-8?B?UHJMVWovNUovMkwyVnpxdTROMWNoRUwyb1ZpaXIrRVp4aDBxb0J4UldBSGZZ?=
 =?utf-8?B?NjZnK2F2NXBpNlNzS0UvR2svaFllNGUwR3dVSHZWSE9VaGFJUW1SRUdzMXF1?=
 =?utf-8?B?RUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 01efe0ca-1977-47dc-d069-08dbcb660a7b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2023 20:58:52.6806
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1KDVXesWpqT7uAzDBBx8IqoPkjrASynb8JFxsbbzg1MfT31zIKW4righTAhcW3GvcQM4msSVOBfjJrNO8MSv4kFuAqAAK4i+Bfocs59YfIw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6687
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 10/11/2023 9:47 AM, Jakub Kicinski wrote:
> On Wed, 11 Oct 2023 13:27:05 +0200 Jiri Pirko wrote:
>>> Yeah, we need fixes semantics written down somewhere.
>>> I can do it, sure.  
>>
>> I found 2 mentions that relate to netdev regarging Fixes:
>>
>> Quoting Documentation/process/submitting-patches.rst:
>> If your patch fixes a bug in a specific commit, e.g. you found an issue using
>> ``git bisect``, please use the 'Fixes:' tag with the first 12 characters of
>> the SHA-1 ID, and the one line summary. 
>>
>> Quoting Documentation/process/maintainer-netdev.rst:
>>  - for fixes the ``Fixes:`` tag is required, regardless of the tree
>>
>> This patch fixes a bug, sure, bug is not hit by existing code, but still
>> it is present.
>>
>> Why it is wrong to put "Fixes" in this case?
>> Could you please document this?
> 
> I think you're asking me to document what a bug is because the existing
> doc clearly says Fixes is for bugs. If the code does not misbehave,
> there is no bug.
> 

Well this code misbehaves if given the right input. We just don't give
it that input today. I would have called that a bug too. But from a
strict sense of "can you make this fail on a current kernel" the answer
is no, since no families exist which have this requirement until after
this series.


Return-Path: <netdev+bounces-37087-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AF927B391E
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 19:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3D567283E59
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 17:46:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB05066669;
	Fri, 29 Sep 2023 17:46:31 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7D666665
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 17:46:29 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FF1519F
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 10:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696009588; x=1727545588;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=0MlTiKyMQU8h8+oevzvcfxTKmKurGldpqijjxSXG6rw=;
  b=W+97cXKeM+Y7Vd30vFb1bd0ityDHy7hc5L/8GSh5SXoOs9cY2K+L2gcK
   lWMwrgjS9lLxrDMpcWHS8G0VQmX+kKXbVqrlx34oxdaxNTBKZ9DKAp3Af
   nbW42xe2ZTuE5phY6cA/W+1GrmxyebQQFJN+dWAkDqIl4TgxEfh7Qk2Ji
   WtdFrfSKH/WUBGe0C5wvz9lMaXnZWAQeKBiIs1TKcpkd8+yyShbmXE1YP
   7GDLvGM36rS3DEs2cnhjAw+b8eEZe4zYbmU7p3OSLBINNenL5J8x2VKxf
   BQLO0cE95f2eiXNISH11x1VSSzsLxNoG7ZjdPyfa2fR3yuEI34S9xfjLA
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="413245576"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="413245576"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 10:29:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="889889"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 10:28:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 10:29:27 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 10:29:27 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 10:29:27 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.175)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 10:29:27 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=StEc2FzKAJ4N4kWz8KEM7/zdLeZYIMXBwzT2zylPFFCnhMn/nRh9jrWgPwABRx20fBar8vAayzVLlxP/+2wMi+wEOubHYkc5eBLa7AguBiL18Uufo2wzFGkav2/2HuCXzgVtqUaDeUSeYqXzNvLpcqDKbgZt8vzO0YaNUJu0vI1s6YmZhx3Dcw7Y5CNt3qT881vNixGDqKNZ12rsMlAYjhROUWlSjK5uqP2SI/fUkDsPghhVTp4nAAhZ5iLlHQWrc+4r059kqrZFOigOUirXb0htFkwX8MnOHn3XKmbyufBwMRtqdpCJb31upSa8/+v808u3EwJQdNLgQ8c3R+nLrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9LNr/zEfUkSsbRCZsgzS+jMqOhqFlSXFpkLpV5+t3fY=;
 b=BVyjrxl9MyJnrOf6iGfTxcCcUUkywJ8rgNLsy0vlclwNA3P1ScAshSVXrohGE5HgwyqOjYazOLJrSjB7/qTcfd9cnDBds2JBam6Tv/vh2VOdZsiG1tt/K+OdBFUSZRIgc8N95aID2DaRXG3sDNUN9pgTI036+ZDMzEGAk1zv3ac3+NhNnAfqYlTt6UjR3tBl/WkrAauQX8fclFGg6flE1rJMX9rXZcbDxHGFvj9A/M0JGzP9KELyqlQSGmkCE/G9rN+/5PXymcPsHQglrpUGW04AoaShYrHvfJJ3XX9HgtB4ywOjFalJxJ2nXqlbS4VmHyNmKvzUPYgQpID+urkS5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DM4PR11MB8177.namprd11.prod.outlook.com (2603:10b6:8:17e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 17:29:25 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 17:29:25 +0000
Message-ID: <ff64d1f2-cef5-20a9-c263-3e0e562d411a@intel.com>
Date: Fri, 29 Sep 2023 10:29:22 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH net] ibmveth: Remove condition to recompute TCP header
 checksum.
Content-Language: en-US
To: Nick Child <nnac123@linux.ibm.com>, <netdev@vger.kernel.org>
CC: <dwilder@us.ibm.com>, <wilder@us.ibm.com>, <pradeeps@linux.vnet.ibm.com>,
	<nick.child@ibm.com>
References: <20230926214251.58503-1-nnac123@linux.ibm.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230926214251.58503-1-nnac123@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0291.namprd04.prod.outlook.com
 (2603:10b6:303:89::26) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DM4PR11MB8177:EE_
X-MS-Office365-Filtering-Correlation-Id: 64467b6c-b3ea-4def-3448-08dbc111a03b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: NTe/6CAcMntXtHFShwbjgg2H73mn2Rp682ctE7Gdxe2xCCoNX0hwsD3S9gZ5LIqC21pYiVp4xkQN+aGFitjbKYPrM+QevkqwqteArJNhH86lIZUuXN3VAZVHZVuantdlD6MdMIdNc6B+2+JOyDAbxgDJXPPhgiq3xdx2qOisr6cddduFaAD7J6smfCFQpWrl/t95g5KgYxrisU7Lb8zMLgKws1yvGSS5zMIgOty8YQGomUp2fwuE07TR0RmDnrsnovUi2OBtQP96Vu3PPnStyc59JlDKd+iRXujaIb57HtlBqXvmFeYAV5201OAU3UC9RkP6ch1+7iOVYLM2HcuX6unLymbwuy1xIohZEcuEraaRWeTpv6H5NTs92Evn1eWnZkLtl2izL7AbkX70E0Z5bZ2tLybu7OAYBkQ8lJNIGBHJGzVTjcrIsgVfqx5cjPpx/CZL5WZ2yD4AgUeA3sVhaUDY7gkna9iIipzyS45VE3RsCWxyhHV6eXyQzedlwRnspqtu0xl8RyZN8xZBg33ZbWW2Ahd2YI+U9MjC3k6z31xbpmqbaswhK+81alNFQcZJOTzHIUvWXs4KmB4pUcJ4efmLchQDpI11T2TDfNjorYpwRw3SO1muKqjmpnhV5ECIzjCWv7Q9YkfGD9KOQxm40w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(376002)(346002)(39860400002)(366004)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(316002)(86362001)(2906002)(36756003)(31696002)(41300700001)(8936002)(8676002)(4326008)(5660300002)(6512007)(82960400001)(53546011)(2616005)(26005)(6506007)(38100700002)(478600001)(6486002)(83380400001)(31686004)(6666004)(66556008)(66476007)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V1JPNlVyZTdQSzhMSUxBV2JCVGtQdnBCYkwxc3hia01VS1hRdExWMUlPR2cy?=
 =?utf-8?B?bTY5RnhpZ0IvRmNhajRJZkJ0Tmc4Z1dwQmhSc1lHUWJkekl2N0xGZWlCV0hV?=
 =?utf-8?B?YmJnOENpYXRqckVBNENCcGxJTXJaMnFSUXQvN3FRTTdzT2ZUSjlyN1ZuOUY1?=
 =?utf-8?B?UlZKUFduOVdrbkQ3STNEM3lvRFlXcEw0a1UyTjF3VVJDak44QkNlWWNDK2xv?=
 =?utf-8?B?SGkxK01zZkpHelBCUHZmTXRSNitYT0ZhU0UzRTI3Q29wb0VjMmQwNDkyRm9V?=
 =?utf-8?B?aThzeFVtUFRTMlVrWGN5M0ZsbE1zZ3VHTHNJMk5MUjZWb2R3d2ppN01aMVFs?=
 =?utf-8?B?ZFhKek5vN2Mrb2RVN25mekRkZlNLRndGYnpBOGdaV3JUM1FKakF0WnBwNUZK?=
 =?utf-8?B?ZmkxYnY0WkdMS3dBY0NON0kybGJwSjdFOGVsZkU2YkxEekw2NFRlZXFwRVQr?=
 =?utf-8?B?b1NXcE1WZFlmaUxIcm10aXc3TGMyUWVqMGtTa21panAvTGVXbC9INnZkWUFt?=
 =?utf-8?B?bjYrZGZzc1BSaHc3MXY0VEp6YWZRR2gwb0RZMHBmd2Q0czJkU1dMalVjcW1Y?=
 =?utf-8?B?R1cwdkVOcFNkUm9PbXViR3NPZ1AvcmVIeW9Td0ZrOFN0WnBmNUVvYWdacGxh?=
 =?utf-8?B?dG1mT3IwTnhUQVgydCs2eHE1ZmluWWhZc2hpQ2JUVjFzd1RTNzc3TXozN0F6?=
 =?utf-8?B?aFB6dWI1WTljVHBIaXI1TUxUZzBLMGFySkpWSldnc3I3QllFbjVRa3d0dU1z?=
 =?utf-8?B?R2xRY1FHa3hsbXlIVWVDNlFaZGdzZUVkdDMwQ3FXb0RQakVsenEvZU5SVjgz?=
 =?utf-8?B?YXppMDRxWnNWc1U1Z0hnL1lEUmlvZ0x1d2NUK1YwM203N2JtMllHQXU1Ym5m?=
 =?utf-8?B?and2cW0xT2QrSlFPUU1tRmVwcDgweFl2TUZFMTFtZGR2ZFpWNjhGUFNXbmFW?=
 =?utf-8?B?L3hkam91b1FhS2k2c2JHenpON3hVeXRUVFpUeXkyOHNWUnlXa0hDU25NVnla?=
 =?utf-8?B?VFFwR1ZEbGhSU2c2UEwycExNTHpMRXdRZU5Ea1VoK1U3UTRtRDZQc29iTnk1?=
 =?utf-8?B?UlF3U2grSnh3YXV3WVlxWEZodmZDWDRZcXZkWWpXQS9jNGx1RnB3UGpta1Ja?=
 =?utf-8?B?YXZjWnRCSDdJSHB6emk1YzdPUExWY1IxVi9oSFIzYSt1cVNyWUt4d3g2YTBF?=
 =?utf-8?B?WG04Wk1ic2FDZE8rOE1wZFJ5WGJVYlo0N3dPZnFFOTZZdjV5Y2R6OEpUWUJO?=
 =?utf-8?B?cXRhRVdkd0FSUmpjamNjeWxCeG9oSG9nQ0dHWlNQTUhneVRQUExFaTd0TzVC?=
 =?utf-8?B?UnQyUUcxeE1VU25PTkkyWHQrdm1nbzJ4Ty9ydml5a3ZpQ1NHUUdRS0NtalZa?=
 =?utf-8?B?UjFuRFdBNVBLZmZ4b0lpYjlma0Yva0toQUFxZ2FEaDF0Yk5Mb1pnWDgxWHRw?=
 =?utf-8?B?aUppYzR4UnJqRStSaTNhNGVZTWFaZUtMUURTM09aOGMwVjhHWGEzMzIwNllw?=
 =?utf-8?B?aGdNRXl6MGZvSzAweHlOVEJqeS8yNnJiTDVHYy9qWFg5djZ1c3lkTmZjejBT?=
 =?utf-8?B?ajVoNjV0QXdvRWIzNHdQRFdWWFQrTitudEpYMlgrcFBrKzRuTDREd2FDK1pV?=
 =?utf-8?B?RHNRT3NHMlYrWnRTbDlFNU1yc2FXOVpJS3dHdS9nYjN6UUxkTTExaXNBSFZi?=
 =?utf-8?B?cDBPbDYvc2JESjB0dE1tTEQ0YVRCMk52dXpkYUtPNlp1MjFrdHdCVTA1NEwx?=
 =?utf-8?B?dEtjS2RWc1Rtc0JHRFRadzVpTXlQcDZlS2VwYXcyaDVRTGJKdm9JMTk5QjlF?=
 =?utf-8?B?ODd5UnhzZ2xUeTVwSFFxMkJ4Rk5Ld2lNelZsRHd1WG9VdmNrbW9WZGJIY2dT?=
 =?utf-8?B?NGt2OFNTZ3ZYRWdkMGg1bUFjWHIzem1EVFJ3WUNsS3oranhOQlJUNWpoVkJv?=
 =?utf-8?B?NmNLU2IxZm9wTHZ4ZGhFUldLeHB6K0o3Vmt5T09CeWorUGtMSUlBbFlzNjZq?=
 =?utf-8?B?bzFvWGFEQllYVVRON2VZcGZEYlN0RnNEckdKVURQYlVOVElGdFRjN2orVk41?=
 =?utf-8?B?b004MEJIYzdPTVI3TGJqQTc2OUdPY0V1Q21Id0E1KzJUbEFpNFczZ2FoSWtY?=
 =?utf-8?B?eUk5UGlPS2xMZmhxRnhUb2t0UlpLaHdETnZkZHMza3FNdkFMMkxWdksza3Fq?=
 =?utf-8?B?YlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 64467b6c-b3ea-4def-3448-08dbc111a03b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 17:29:25.1066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QEMIn3pSsrPOLACUvOf9AH4IVvF2sCMaO0vPU9mU7mqt2j+XxGgfbWYsYCzpfNxYv5bDQn9oliT3c5hSlOU7ZUSfDCuqwnOyh5Iw608MYCY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB8177
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/26/2023 2:42 PM, Nick Child wrote:
> From: David Wilder <dwilder@us.ibm.com>
> 
> In some OVS environments the TCP pseudo header checksum may need to be
> recomputed. Currently this is only done when the interface instance is
> configured for "Trunk Mode". We found the issue also occurs in some
> Kubernetes environments, these environments do not use "Trunk Mode",
> therefor the condition is removed.
> 
> Performance tests with this change show only a fractional decrease in
> throughput (< 0.2%).
> 
> Fixes: 7525de2516fb ("ibmveth: Set CHECKSUM_PARTIAL if NULL TCP CSUM.")
> Signed-off-by: David Wilder <dwilder@us.ibm.com>
> Reviewed-by: Nick Child <nnac123@linux.ibm.com>
> ---
> Hello, I (Nick Child) am submitting on behalf of the
> author (David Wilder) since he is having patch submission issues.
> Apologies for any inconvenience.
> 

I think you're supposed to add your own Signed-off-by when sending
patches on behalf of another author, but its clear who the author is
with the From line, and you called it out here too. Thanks! Just a note
for future submissions on behalf of others. From
Documentation/process/submitting-patches.rst:


> Any further SoBs (Signed-off-by:'s) following the author's SoB are from
> people handling and transporting the patch, but were not involved in its
> development. SoB chains should reflect the **real** route a patch took
> as it was propagated to the maintainers and ultimately to Linus, with
> the first SoB entry signalling primary authorship of a single author.
>> When to use Acked-by:, Cc:, and Co-developed-by:
> ------------------------------------------------
> 
> The Signed-off-by: tag indicates that the signer was involved in the
> development of the patch, or that he/she was in the patch's delivery path.
> 

I don't think this should require a resend, but its good to note for the
future :)

Patch looks good. I assume there isn't a different "fast" check that can
be done to determine if we need the recomputation, and it doesn't hit
the performance too badly. The simplification and ensuring that no one
else hits this error in the future is worth the slight cost I think.
Correctness comes before speed.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

> 
>  drivers/net/ethernet/ibm/ibmveth.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
> index 113fcb3e353e..748ee25cee8d 100644
> --- a/drivers/net/ethernet/ibm/ibmveth.c
> +++ b/drivers/net/ethernet/ibm/ibmveth.c
> @@ -1303,24 +1303,23 @@ static void ibmveth_rx_csum_helper(struct sk_buff *skb,
>  	 * the user space for finding a flow. During this process, OVS computes
>  	 * checksum on the first packet when CHECKSUM_PARTIAL flag is set.
>  	 *
> -	 * So, re-compute TCP pseudo header checksum when configured for
> -	 * trunk mode.
> +	 * So, re-compute TCP pseudo header checksum.
>  	 */
> +
>  	if (iph_proto == IPPROTO_TCP) {
>  		struct tcphdr *tcph = (struct tcphdr *)(skb->data + iphlen);
> +
>  		if (tcph->check == 0x0000) {
>  			/* Recompute TCP pseudo header checksum  */
> -			if (adapter->is_active_trunk) {
> -				tcphdrlen = skb->len - iphlen;
> -				if (skb_proto == ETH_P_IP)
> -					tcph->check =
> -					 ~csum_tcpudp_magic(iph->saddr,
> -					iph->daddr, tcphdrlen, iph_proto, 0);
> -				else if (skb_proto == ETH_P_IPV6)
> -					tcph->check =
> -					 ~csum_ipv6_magic(&iph6->saddr,
> -					&iph6->daddr, tcphdrlen, iph_proto, 0);
> -			}
> +			tcphdrlen = skb->len - iphlen;
> +			if (skb_proto == ETH_P_IP)
> +				tcph->check =
> +				 ~csum_tcpudp_magic(iph->saddr,
> +				iph->daddr, tcphdrlen, iph_proto, 0);
> +			else if (skb_proto == ETH_P_IPV6)
> +				tcph->check =
> +				 ~csum_ipv6_magic(&iph6->saddr,
> +				&iph6->daddr, tcphdrlen, iph_proto, 0);
>  			/* Setup SKB fields for checksum offload */
>  			skb_partial_csum_set(skb, iphlen,
>  					     offsetof(struct tcphdr, check));


Return-Path: <netdev+bounces-57747-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B76DC814060
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 04:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CD731F20CD4
	for <lists+netdev@lfdr.de>; Fri, 15 Dec 2023 03:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D7F10F8;
	Fri, 15 Dec 2023 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mJL9gHR3"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD00F1879
	for <netdev@vger.kernel.org>; Fri, 15 Dec 2023 03:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702609544; x=1734145544;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=tYOcLCEnvHESi9p0xHGMg7Sf+AbRSsPloy4xnkGY+KM=;
  b=mJL9gHR3JcAKQNBBQsz3LKLRYxp5YitiAWk75A6nwEBbaetgcyowDkt9
   d67uNl4p8m0rjO9T8zl3m0u3hPOtUyh5bdKAGjlSvFKJbOFoz2lrXb2qt
   RY6SUTETypNucdthBvAtrvm07AKUQAbK6FQR4kDofr1dZMPnGT+rQIASA
   4WUuHc8TQLhtgBL16ZCYP1o3QzOB5e2pOM8yUlAdYaJGwRVLNvozLvdxF
   DeTwVH5UtQSh/gl0V4QTbRAwjODu3wcWrC5ZXVxG+C3kT9wglTSYE+tg7
   FmmLeFAMtiYPCQyYsYtwcOVFn1xC0AJZ3xvU9pRdqAth8Wp/ng6O7QetO
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="385641369"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="385641369"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Dec 2023 19:05:44 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10924"; a="1105972209"
X-IronPort-AV: E=Sophos;i="6.04,277,1695711600"; 
   d="scan'208";a="1105972209"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Dec 2023 19:05:44 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 19:05:43 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 14 Dec 2023 19:05:43 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Thu, 14 Dec 2023 19:05:43 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 14 Dec 2023 19:05:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=P73AG62cCoVc+s8lKVJRA6gTh0U1qGvnuTHiCaWA3DA7pUY/3rUGOl6DvaG6uqRonx0MgX5YPhIuNaorr6RLNMirV5kb/sxdEaLsDaNg0GSgdpKBPnwG1Nv2u8Wtv3ZpvSlLDJW/Ug2mfEd3F2hYqamZ4dUNWgsfsPPxCC2GQmD3YRD8VlCIzBhyFO2gNnaSopf0Ay0qcEDZfoMzW3FV/ARImJ/xqcH5tJJTwI4lT1X8O8f4x+WxXTIxqYex/QAj+6J8X67C9t3bHqzyF+60Y+t9/llxhCXIxYtursTnIKQB/llgUEso4JzzhNSXcKtPCJpRgl0levbDQJAkH09N9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xNczWbBurenkWHeF9MPSVOPT+6fxhHBCoBPPKj8M6AM=;
 b=cdXPKWqo1CTk/kgB5QfG3nBe9cgyGsY+XuDZiJb88AHcuXCUcha62fLjjOc4D3n2AIz593mCTP4HX8Bi4KfkG1hmX16af2K2b6RLpbD1apXgR4+72Rlx8BHP5yb1HtfvXD1McRR3pVTRtWJ75y+DwRXtV1FV7ZAot0LO9TWf/nMQbg5Q5DPJ6FwfsmJJ26/d0zYbUEuBkUs3nOhPUSrvB7SodNfXlTiJQJw0K2eCEZrpUvsh/NdvMFQESQpFsaZnar5s1P4fTeKCj/4+0u7O8BEVJFoZAOi+pZyMfSNmz4/VBv8GzhE5//EUii901ev8/otQb94SGDeYomCckMQOBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CO1PR11MB5156.namprd11.prod.outlook.com (2603:10b6:303:94::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.31; Fri, 15 Dec
 2023 03:05:39 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7091.030; Fri, 15 Dec 2023
 03:05:39 +0000
Message-ID: <b214f133-fec6-4814-b77e-86d03ed8756d@intel.com>
Date: Thu, 14 Dec 2023 19:05:30 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next v7 5/9] genetlink: introduce per-sock family
 private storage
To: Jiri Pirko <jiri@resnulli.us>, <netdev@vger.kernel.org>
CC: <kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <jhs@mojatatu.com>, <johannes@sipsolutions.net>,
	<andriy.shevchenko@linux.intel.com>, <amritha.nambiar@intel.com>,
	<sdf@google.com>, <horms@kernel.org>, <przemyslaw.kitszel@intel.com>
References: <20231214181549.1270696-1-jiri@resnulli.us>
 <20231214181549.1270696-6-jiri@resnulli.us>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231214181549.1270696-6-jiri@resnulli.us>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:303:b9::8) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CO1PR11MB5156:EE_
X-MS-Office365-Filtering-Correlation-Id: d29fd9d4-a0d1-4f04-1881-08dbfd1ab751
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oxucglweaaY5aQ4VbfpZJTMF4ZQ5ggNbgIYJGAHbrSDmsJJBdlk1nsJXrOiDlAGgct/RSE9v65F8Bl4zvfa1P4nfmn1DVjxdVxSfjMA1/fkMj6QOG8/XIRVHkis5I3EyVH+m0OYW+Jvsz+h6CtcX3+2EWx8Ic3AUiN+nbfUkxzt5diG8bodPXAV0F6uWP5YwfMhvzkFVtXauyw+P09hJfevJ3HXFNskMMSyTOX2SGH6YG5eyitXEtxGV+VNI8yANC0orSeo3cbV4/G2+B2vcmhumqw6vn+uIoe1w/m8RXsrnyMXWgrOpFAmUYWbzVt/SB9KyQ43moG1GOL2wgMERgvwuaQoQhNCZZ0IpL3oJ75sNh1Rd0xyw/b8fWh1IUt0mExweNyNX/NpSwqtvrIfwVHLFrPv15aIRUhTEVz86OChAdTGVvM9HFpLjRPFdPzVJivNyOudRWWciU26qkHfp9o7L4iByTdPeY9sA51jwlj2MfUyZyyizdF8sNpcdwCg1I2YcfNAp6nnNKQU+qlj7kMlTsouYX1GP1eiIbMSQZbYKdORiHUuG2bxbllX92wsX0/T6T20PyjC9+UZ5Gbdp2QsJnpHJ3yHFCNOIA1oFrBK9uIzmmTlNIY0HAW13k2R7YVXegGrZGmLLQc0xrbSuyw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(136003)(346002)(376002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(4326008)(8936002)(8676002)(2906002)(4744005)(7416002)(5660300002)(478600001)(6506007)(6512007)(6666004)(53546011)(66476007)(66556008)(66946007)(316002)(6486002)(41300700001)(38100700002)(31686004)(31696002)(86362001)(36756003)(82960400001)(2616005)(26005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N212cXJQclNhd09GNXdsc2h0L3pzUTRrZHZFNkg4UUpBTWc4RnhQU2FkN25Y?=
 =?utf-8?B?THVYRkhHUUFkbHhYRUJkSjAwcTJxVDZXTTZ1OEhNK25Xb1JBdmZVempJZFox?=
 =?utf-8?B?MWJ5VmRiRERjd1lZYzdDMHJkT3dIZFVBL3ZWTDdkekQvQ1Y1YncxbWdVRngy?=
 =?utf-8?B?Z0hpeWQyV1A4ZWMvc1Z1SnJlYlkzRmhhMVhwSmNBckpxKzJYeUErNFE1bUxI?=
 =?utf-8?B?dWNtRCtwTWlwakdhdGtMckFIOERjSWxHRWlEN3VweVNwenpPN0M5ZFhXdXdr?=
 =?utf-8?B?bHRzejBoZWNhRUFIeEdPRVh3MllKazFGTnpQbU94M1RDYS9CSHd3TnZRbGQx?=
 =?utf-8?B?T2l4bnpFU084MXNTTkVMZEEvU0F2bEkxaC9BcU5WRkhocjdoZm5TM3J4RFEr?=
 =?utf-8?B?VGhUZ1JVUVBvY0RYMU5BenZYQmdzOG1pdEtVWWJveC83Z3d6S1FpSXlnaVZo?=
 =?utf-8?B?Vmd4TjkvTEhKRUxNYThCZWdoYnVHKzNMMEdSQVppNjAzZ2pjSCt5TDY1ckdm?=
 =?utf-8?B?eTE4aUJXYm9HOExNOWc0OGMxYy8xSGZsM05FUVVnUXFpcjFqcnNDcWNkVUtK?=
 =?utf-8?B?WStTbUpGSXZYcWFPV1VZNVZWTTAxUDU2UVJISEdoWk93YitIbUU5VUNZdFRV?=
 =?utf-8?B?Q3p5aDNVTjRTQjMxamkwVlU1NkZPMG1vTEdiaHliS1J3MnJrUGYzVVhsQ1FJ?=
 =?utf-8?B?WjdmYVlWSHAzK1V1NXArMFJVYmQxcy9VRFQ4TXBudzh0UHlmelo1M1VtSjJp?=
 =?utf-8?B?OXgzWGZMNlh6SmVGWUFpOTZnVzd4Z3Z0L2tlR1d0aSticThJQVpxdXVZQlpZ?=
 =?utf-8?B?QVYxTklLT05lODQ2RFYzRFM1bk1Vajc4QTd5SVZaY21kY2VaaEJPR0dSQXpS?=
 =?utf-8?B?QzZyMnF5QWNrVWdNU0xudUlRcjNsTlhaL3ZFZWxWTWFtT040ZFdkazhScWdo?=
 =?utf-8?B?eGpDenBzY3V5Ui9DdEZwZXVCL3dTNTBHWVZhSDdCNndBL2M4RGtwc2l6a09t?=
 =?utf-8?B?bGZtZW9lTjRWam45NXdDSFdwRjZNbGQ2OUd3ZCtZL2ZHZHh2ajBwOVFzeHRk?=
 =?utf-8?B?U3lqV2ZTOFJJSW9YV3Mvb2IvdHFDWUZMTlpRTjZnQ0NIQ3llMDdmQlpRbGhL?=
 =?utf-8?B?MzFQOTgwbjg2RVVvMTdER2xENWRXck90SlF3dEdNdmRqVUxnWlQ2OTRMQVBr?=
 =?utf-8?B?TkRURGwwZ3ZsRUtWT3VTK2QxdHdlSENNRXJudDdFdU4zNENySmFQWDcxN2la?=
 =?utf-8?B?UzB1eHNUSmJUS3FPV1o4NUExMW9zSVo1SnhOSWFBRDY0Q3YyYUN4OG1idmVs?=
 =?utf-8?B?ZFRBTHZlcU4wYTlNdkR0czhCVGZQSnhWRHRjdmF0amQ1NmdYdkFDay9UblNE?=
 =?utf-8?B?M0dJbG95blp3Wko2d1pDb3hUMUhLeWVJVTIzVXVRN3I0ZEJwczJSdzE5NUpo?=
 =?utf-8?B?UWNFK2d6c3pQeFN0SVVQc2djcElVQ1BCRFFmaFkvY2VjeHBtU2ExeWNiUmJk?=
 =?utf-8?B?RzJlVlpIWG0zd2xVYnpLSkpIRVovREU3bTNBMkUwRXBLQ1FLVUtVblVPTkJS?=
 =?utf-8?B?eWxkTDlHTDNZZEgxOUdUYW1KckxFVDd2N05sMVNrazFCK3c3U21mQy9JYndw?=
 =?utf-8?B?NXR3T2NPNGtHbnZnTnQveStkdUcvUTFoTG5xUElseERFQlFCYkx3cStSQ0VF?=
 =?utf-8?B?aXFYUEZBeThUdmtGY01jd3N2OEpFL25FYUhFWk9RM2ppUk5XaDhmd29sN1pa?=
 =?utf-8?B?VmdLeU5jN0UyT1VXTWZ3MDE5ZnhBRW1DbDBkdDJJTzNYM3VDTS9JWXdHbGpW?=
 =?utf-8?B?WlZ6cjdlakxaeVpZNFRVYlNINlUxQ2VRNnhpODBiQVRUb1JjOXFxOWdaL3Fs?=
 =?utf-8?B?dDJJdmhqNVBNVHloVXdscVJrZHhpL2wyNkIvRU9kb0dXTmhEaklMY0l2SWtI?=
 =?utf-8?B?Si9QemxqNzBQSUpwVGc3WTZnbEpkY3ZnYnk1YWdScVhLeTBkM0s5ZnNGWm9i?=
 =?utf-8?B?Ti9RSkdyemJoNHhheE9BTkV3V3RzYURBTEwrU2JMN3NlOTJ6Mm8yeDYvVXJs?=
 =?utf-8?B?ZG9NYm1ocCtxdG1mYTRoWGRJT0QvWFM4Tk9vQXRIalRBZjlQTDZ4enh0emJl?=
 =?utf-8?B?RTYxcWpvU1E1OWluQmtUWndrWHlNcWxnYmEvUUpCcEs3OS81TFQ0V1dEeCsz?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d29fd9d4-a0d1-4f04-1881-08dbfd1ab751
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 03:05:39.1753
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pz/Ji3DY+H2tU5hTMR1a4vNJu7T43qjlPMYUilGaDLOb2+0hc6aeYLwWdff08re15eToyn3Rd6PpFKN/ALmHoQIP8aqdZcoaplRQCoW6UKI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5156
X-OriginatorOrg: intel.com



On 12/14/2023 10:15 AM, Jiri Pirko wrote:
> From: Jiri Pirko <jiri@nvidia.com>
> 
> Introduce an xarray for Generic netlink family to store per-socket
> private. Initialize this xarray only if family uses per-socket privs.
> 
> Introduce genl_sk_priv_get() to get the socket priv pointer for a family
> and initialize it in case it does not exist.
> Introduce __genl_sk_priv_get() to obtain socket priv pointer for a
> family under RCU read lock.
> 
> Allow family to specify the priv size, init() and destroy() callbacks.
> 
> Signed-off-by: Jiri Pirko <jiri@nvidia.com>
> ---
> v6->v7:
> - converted family->sock_priv_list to family->sock_privs xarray
>   and use it to store the per-socket privs, use sock pointer as
>   an xarrar index. This made the code much simpler


Yea this version is a lot simpler and seems like it should prevent the
races.

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>

Thanks,
Jake


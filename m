Return-Path: <netdev+bounces-71849-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D737855570
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 23:00:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E811C234B7
	for <lists+netdev@lfdr.de>; Wed, 14 Feb 2024 22:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D36ED13B7BB;
	Wed, 14 Feb 2024 21:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="KzsYrrwu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38EE313EFFE
	for <netdev@vger.kernel.org>; Wed, 14 Feb 2024 21:59:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707947973; cv=fail; b=jTMWlRTo9Fgif/jNH1A4+9FyehZ7mjK+rpof4j2//XXCL90zqwhWuZVEisjwe2MCpERxpPIJQKAbg/KAT0mtf273mDooDzlRWZeLng08900JSysVf0pimZAr1HQ7xCrU4AHYnK282zJM5kSbGVf2Mn8aID88+u+dUP6ZKxS5gOg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707947973; c=relaxed/simple;
	bh=Q7I6LfJO8WYXu8NIJ1MyV7x9OFijZMHuUgUCyaX6Y/E=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=cU+EKYcEAGI3BOUIKqs8qapKsAGXr+CLi1UemVAS1sff5KkitfxUdovMiLu4TKPohJbrOceba9ioHA5xeyRaAddTQidlm1mRPpkDhV5ZdGYBiQcqF570opNmvmft8jbaXrp5jcyBo+ZEy5L2QMHkve/LaxcAoyHETZg4JwzecUw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=KzsYrrwu; arc=fail smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707947972; x=1739483972;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Q7I6LfJO8WYXu8NIJ1MyV7x9OFijZMHuUgUCyaX6Y/E=;
  b=KzsYrrwunyWXo/ZRnxay5sic746M+TxFnT/Te1JuboLauRiWa/MXj4HV
   FOhRqrX07mIS+jKP5g3MmylIXCX5IZRnsKsn6TIcIHmPMSmJmxARduoRh
   owlWQX9WrkrrBhFI0rOh34Qf4x+1b9kDhVSKHWf902ztk4e9jrhM/ZOn5
   SYpfDeQAuHZWy7yF8GxFk3V/KxOtGHUKqg7edUtFgWiz2EUlXRjmLCFHb
   fijLd8WlC6yDUeDPJ6Jn+7C5A0jMdxYvjG/x1OdiQ8pcAzDHVpB5sMhwr
   L1eMGg0N7yL0G/rzfKcN4huABZdLq3cTLasLjIJpI7gA+5zMnpbwviM+W
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="13113306"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="13113306"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 13:59:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3254534"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 13:59:31 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 13:59:30 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 13:59:30 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.40) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 13:59:29 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KVHCB9rQWz9FYPuDNAuKL9h4z0Blm5t6h5ddjN68arJe6r/9SU7cbpXXmoOoiWPSFoXT5PrGOT9tcafpzkv0OPhUQ15UHKJXkREWNzIK++kXsHlsck4hEcK544T6c2GSPQJnoi6i6mN5vXnsAJUemXa4AWGvKikLd1LkndFBVxbhu0ZfjZDczNodcbuO1JNDPZOtgnDHpTxJch9z6vDd2wmpYGP240mEdMY0GnqDPHICkmlk1kD14J1Y6oDAca4jdc5f/Wa5MGCw97nwIHYc0bRbiwl+HWKmjt+hObVLkddyfwetQtgM5oPGxYAreDkComA2ggQ3DdfloyM9R0RUsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=42eW0Oq2UDhrbFsXLOiIOAsN7i6GF7Zc7RNS0BSL2vs=;
 b=Qvp4sWfuJpGYKxbWxRuAaV3hYMb7uSsGm74Onv9RwqtYVhC+NRxR1Nl+vwJTy90Sc5HBN2I/KbbwDQgluJOGo3TkCZ++63scfR1xlqZ95SoN0RS4Y7hEBFXDMBdjglpmo3lt7+ZidyfnwtueaMD4TZUqOY54wy1Y2vCywUN0pMnoUpje/fj7kkdhD+9blziMuFOaayZYCSjbQXG0G1ja+0qSbVorbKnY2IC0HtXoYtuKFr9INIbEEZQ7/IVEUscXQBEHXoJsSJNY3r14RrigfMZpOXUZvx5NFvASIeUVEyP55qxlyWBxH3USYJ/zypBKPXCtTOLviyr1Y0Lm7rVQkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SJ2PR11MB8402.namprd11.prod.outlook.com (2603:10b6:a03:545::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 21:59:28 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::4069:eb50:16b6:a80d%4]) with mapi id 15.20.7292.026; Wed, 14 Feb 2024
 21:59:28 +0000
Message-ID: <3e36177b-6289-441e-8060-ea62bc3db681@intel.com>
Date: Wed, 14 Feb 2024 13:59:26 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 3/9] ionic: use dma range APIs
Content-Language: en-US
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>
CC: <brett.creeley@amd.com>, <drivers@pensando.io>
References: <20240214175909.68802-1-shannon.nelson@amd.com>
 <20240214175909.68802-4-shannon.nelson@amd.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240214175909.68802-4-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0023.namprd02.prod.outlook.com
 (2603:10b6:303:16d::16) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SJ2PR11MB8402:EE_
X-MS-Office365-Filtering-Correlation-Id: ba8e2afc-4cfa-4342-8261-08dc2da8372c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hH2poExkmmOyIW04MnarrpDoAETdGvYfwGwp90WS4ZYeYsEwioqIgBjOxxnrOjABQy+cxG2hgezJz7Jf8y4MqPxx5SlzMdKK5GOvjljjYLd3xEWb+TLlXMXxtSAuMvi+EGLktVdDb8UfMfT/Ucbc4ovMM8Xvy64ANhsOdQy8jh18jiH6cMnHbofPp3bo8xMjfM6JHN07iq1YIwVUcUP4JedmW3Iqumvu8XnskcwxSrN73ODGXdd4ybZhvjsoU4ul2JmkCGJsmUUsm7CJ7obbP7Gtpf2HhSj688hCP8YrDumRzgr4TwvLj1GVCp2xaGLtGZN0N0qJW8dLCMxBzYI7kbnazcFLgnFjN3/8JHAvJQRUwcNJSeHW5/1kGjyNP4opVkfmD0s8KD96LrDabgtHoXQJnOY8wvt3ZGF7I2C1K8hVlDFSncYb+5uDzBEoEt1g91f8t5uMoPGwu6dvYmrgzPJnTfzkm2IlAx8fZfaUZGQrtrbXTPMyVcFi/EAVL9TPoA1mru8x7ngDuhHgJbSeaagDVoq/ZAXNXX515NhJ8u0TvRID5hTSBFu+jXL5Ax5P
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(376002)(346002)(39860400002)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(4744005)(31686004)(2906002)(478600001)(53546011)(6486002)(4326008)(6506007)(6512007)(66556008)(8676002)(5660300002)(8936002)(26005)(66946007)(66476007)(36756003)(2616005)(41300700001)(82960400001)(38100700002)(31696002)(316002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDF2ZUtCN1ErWTd5SldtMVpoRFBhL1lteWFhTmF6TnZtMG92c0hUU0d6dHd3?=
 =?utf-8?B?TEpRc2hhd2s1TGZlbWZmSEh3bkgzdlJRb0ozbTFXd0lOWE9tdkkvem5Dc1lr?=
 =?utf-8?B?TWUrZEdwRDJJRzJpaGpHQU1LdXU4eU1jR2NERHhub0ViZEZuZTJQNjhFNzFk?=
 =?utf-8?B?OUVPdEhEd2VFWEhMMjFTSlhBV1RTaUtOS2RDallHbXNVTXpoSFd4SEVWVFVK?=
 =?utf-8?B?L3ByajlpeDc0akVzZG9YRk5tUlpxZVpOTllzVG9NOXVNSUx1SGpUeEFUdHMy?=
 =?utf-8?B?Z3JCUzE2S2NBTjM4c2IvN1hZd0JVTEo1djhBV3dXcVhOajBUYWlKQ1ZlbW9i?=
 =?utf-8?B?NTlEN3lhMW5FazlsS0h6TERPdzFUblBsLzMyU0NBaURHZkZJTEY2dFJkeHd2?=
 =?utf-8?B?TmRvSFJWdm1Ga1dnblUwQ0x2S2kyckh6ajFCQWZsUnRMVWdHcm5jR2w0YWhR?=
 =?utf-8?B?TG9GVnlpa0Fpa3lieERPY0NhK0RZOCs0dGxGQ09OSW5nUEdicFdQNE9VSnl1?=
 =?utf-8?B?bnR4aXQrZHRuNnZaZjNla1NqY0VOM20vRHNlTkhCc2FrTEdqWll6ZEQybXNi?=
 =?utf-8?B?SjVTcDB2NWhCNTEvVDRIUTQ1OTkxTlBXY2pvNWplRTJtWUJOWVBDYStpQk1M?=
 =?utf-8?B?WFZ5QUNIMkVxdi9aT0xoNHRnUGZBeEthcEdONGp4Q2VER2NvZ0dKeG5UWFVa?=
 =?utf-8?B?NFMwUEtQdW5WNzdLeUVsMVJ5MjRSUVVQakxSeGZhYitZZVRLZFpmMEdTdkR6?=
 =?utf-8?B?SzFPTkxHdXg4M1dSNStnZmQxVk03SEdLenU0N3hPbEZDaGF3WE12MU80K2ZI?=
 =?utf-8?B?ZURYVytQbkJNc1VPWmVSeUdJTVVuMzVvZDJGWU1ST3cxNjVsL2FJSzZZT2Fl?=
 =?utf-8?B?NjZiR3Z5ZW4xK2UzazVYR2szRVJ1NTdkWGhXOC9zVTB2MGlkU3lYV1hZQjBC?=
 =?utf-8?B?S01hQjVaOGFRQlhyQXNseEw2K1ZjdnFvbVpSSzdoUUtSVW1UeGZkVlRiYXIz?=
 =?utf-8?B?eE1jMVc5RUYrbzgvSGI5cDcvbjlxemNFcGRnOU9ONlFCTUhjSC9kSDBVMGRH?=
 =?utf-8?B?RkpLSkszZHU2dndiazZGa04wNWdUUW8ralpWbXozWC8xb2gzYkpjUFM3V1U5?=
 =?utf-8?B?akhjbklzUWt3K09nQTBqa29VVVBkbmdmaisyMVBMNm9Wc1NDYU5nODYvZlRD?=
 =?utf-8?B?Q3pwZkFaV2gwd3M5SFhxQVVYMFk5MDNNMnQzT1FmU0xoZ3VITEpIZFlSZlB3?=
 =?utf-8?B?ZTdNSE1PMVJ2QTdtWjJTSDhFSWgvZ1ZUZTFZRzNNdXNBU1hZdlZ1SGpPK0Y2?=
 =?utf-8?B?RDZlQ0E3UjFhUlBydGZicElvdFExemhNbDdTaWkwYkUxalRId3p2elJHeW9G?=
 =?utf-8?B?THR5SXhaYlBFYzlYRUZiSU1qSVRPWVhtZ0F3aXNPWWRNY3FrSFVhb09ZVlFS?=
 =?utf-8?B?L3l0ZEVrd2VMMEhYUHoyckZQbWVuN1VrQTZTeXZNT2RWZnJYVHJJR0YydEhw?=
 =?utf-8?B?STdlSUNwc29QSXBXRUh4aCsycDNSOVZMUU9yaFhPWlZidkVqVVNZWFhlS3ZG?=
 =?utf-8?B?ZnhneldIay83YzJkSVQrUnVBKy9VY29VMW9RZGc0Y1E5bzIydTBGSFVqS2ti?=
 =?utf-8?B?YzZaV05RNUpTRDNkVlBzRlZLZS8vSWxuRlRuODdaZlFCSnFzODBURm1TYW5K?=
 =?utf-8?B?MWs4ZXVESU14VmFlWmtBMkcxWmxUbU8zZzRJTG1oaXRYaTA0NEpVbWRPckE4?=
 =?utf-8?B?bENhY2gwbE9mYW5iTUZwM25Gc2ppVnVGbkNjMWJjYXJyODlTRXRSRS9KVmEr?=
 =?utf-8?B?azR0T3BjYVgzVlVGWTVxQU0xTzA5ZHBKYTdEcUZvOTE2NWc3TGVQM2doSmpk?=
 =?utf-8?B?OWxjZXlvREFvUm9XZjMxajI3eHVJSlVjbU1XWDgyTXBUN0FoZElDTEpOS2R4?=
 =?utf-8?B?bGZLMjF3ZVpiend4eTB4WWl3allWU2tOWXl0M2NJK2RXUnppelFFc2dxeXp5?=
 =?utf-8?B?a05uOXMvalhRdWlkZ3hYcHFHUGo2akdDeWlQdUFnalJNTUxpM21LbEdTaE9l?=
 =?utf-8?B?L3lpTEpPOUppQ1ZkUkd0YTVDbzhpQ1hFd1JxcEVKL2V2UWg1NjAwMVA4NEFr?=
 =?utf-8?B?M1d2dHRrVmN5aW5nbTdFSWR4M215ekpWZmZmaVFGQWFLRFBHVHdNRVJFRFZW?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ba8e2afc-4cfa-4342-8261-08dc2da8372c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 21:59:28.3905
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Or0FUL+OWr6j5mP9u5B+XbqoRMb29dVUTG5CbG9ThWDtBPjmBV0tMQDC3igTeJrFA+xw0qMqm/4iStAZy1Q/SbCqzvNt1izrr14EGEOtx8E=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8402
X-OriginatorOrg: intel.com



On 2/14/2024 9:59 AM, Shannon Nelson wrote:
> Convert Rx datapath handling to use the DMA range APIs
> in preparation for adding XDP handling.
> 
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> Reviewed-by: Brett Creeley <brett.creeley@amd.com>
> ---


Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


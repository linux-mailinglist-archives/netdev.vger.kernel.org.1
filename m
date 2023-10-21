Return-Path: <netdev+bounces-43165-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B7A7D19F6
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 02:38:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05B2DB214A1
	for <lists+netdev@lfdr.de>; Sat, 21 Oct 2023 00:38:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2BD190;
	Sat, 21 Oct 2023 00:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GjyYqtf8"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0003F7EA
	for <netdev@vger.kernel.org>; Sat, 21 Oct 2023 00:38:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CBDD6E
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 17:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697848676; x=1729384676;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Qshe3uJp8NYOHwnf7NRkgKooznuTbrWFpLZ8pSVNKt8=;
  b=GjyYqtf8E0vHhWdF5PEVvc4ibRK9Q3eN9xCwHi4ViJH7j6M7Wz3NDLR7
   8YtRf78F+5UoJXrmx1GoN8FPLlU8fjMyW41fu1pG2vOoBhnNqiImXht8d
   0bzpobeSjNBm9q7qN8pHFITCfyxlTGQ9YBBCZNMesZSvXToW/14Rkmdeg
   FwhHPwChBqYjIC67Uli/udFoAm5hnP6bAfqW7To5UwvOmG/4o4AXpqsjd
   Cq87Y/gdDmb09G6tQkMhdY/wOQN+kLb1cp/Kl+7ymMWtUTSSN1Pk9N24Z
   BBH4Qx++cnaIXjGe4sko0tYMDDp9R4RdS2sUEl3fOHQqSagjJBBOxkvu2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="453075231"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="453075231"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 17:37:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="848246588"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="848246588"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 17:37:55 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 17:37:54 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 17:37:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 17:37:54 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Sb/v22rznC6V06R3tWrje5FTpkq3b6N17fhM/rxKtLGh0aZdbPZmDLgCtb4l657VW7V6IM7iAQ9rf92yfB9DnGZwIoSuHjl7IInrXc5NU2p2cJxuVzf3+0oCUYw5TjTRZoZLkTARSj8wpqYbgYrvzEamxd5Nvz2XBKQk8OgX7Ts/agysIsXaKAVcXQy+/A84ewk0RQomN1uEuOxQY0h9YEw9ATY1q1BK1BclVADRbiDI0IeoKDiIOmSgKiN6gw/leffME3CVZ6wkY1LAjl1IAqWqZERKZKLLC1bGkaMdFaXYNgEHCs9NHGbSBqA1HZxu+Lfr4Xpe0YJZhnBusKi1kA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g0wGe00QLYiksFQTI5U75gbmU3UNrclNdFy61z2ubXA=;
 b=ndGNd8P6SUm2A7F0d4mC3YKV7QA3ddEIK88IaBP6WC4sVa1+nTZ4t+rf3cBD98sY2Xu6BiKqDDpnqZpSwcfeyOd+RjtDjUllEEBMwUwyWAy9nCj3kdeWv4RSxisDk9HmoukZ7HGzqOEnl3y/mK2xosKtybkpSDP//Zz1AWG5NBWRvoOb5gFeq0j1rgmnMPzHfJ9SKhFypZ1Uhnl1ZaguZmRJngVtlCKTEcph0c/7/AcZ4+2CADM25APwGywFsMK7mgcSv2tBw5B3Hftt0h/pHe+4WfatlsHVpPscL6MZa1txjbmqkOcvnis1Cz6T24lJqgkNhm44My3Kk3ejG2QtOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by MW4PR11MB7152.namprd11.prod.outlook.com (2603:10b6:303:222::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Sat, 21 Oct
 2023 00:37:51 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.6907.025; Sat, 21 Oct 2023
 00:37:50 +0000
Message-ID: <bdd45dde-18ce-4dec-815e-04959912332d@intel.com>
Date: Fri, 20 Oct 2023 17:37:46 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v5 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, <oe-kbuild-all@lists.linux.dev>
CC: kernel test robot <lkp@intel.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>
References: <169767396671.6692.9945461089943525792.stgit@anambiarhost.jf.intel.com>
 <202310190900.9Dzgkbev-lkp@intel.com>
 <b499663e-1982-4043-9242-39a661009c71@intel.com>
 <20231020150557.00af950d@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231020150557.00af950d@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0108.namprd03.prod.outlook.com
 (2603:10b6:303:b7::23) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|MW4PR11MB7152:EE_
X-MS-Office365-Filtering-Correlation-Id: 026f86cd-c72f-48b9-34de-08dbd1cdf44a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcdoxesvcxA8RjRT8FrENRjpnHEN+0WtSTL4s8g17CGGpAuOVwzPtFtr1mjl6Jc72Cb6Oam5u3PsP00rqQOFk1vbV0Oyi4D9v04izzOueyN6z5vBFm8Js1kEhYBaUJlqDAG+iUkEi2ee5N4QFBuUoVbucphIdGkYsUVFkn7Ixbp3qJInwn5TPWynv4YCDqFOMzntfafEqqNg1lzZg8m3NCpyrCqAWZKXWlt2hD9FHlk+as6N5NpNTYSHUSEkcwmcbtuRzwNZGl19K9mWevMN+0TotHsiaZAA8UQaoH2BsmHwbDoPNFqRvl4mH+qDP/wvdDzMqZmPZENexj4xifE/6gK+obBs930JCWDVAx+Oeyl8itJrpAodcG527bVypCgiZM0r/f6kfXOouffUZor7aNTdkWtsVkhH5gpzIcIxoXao4mRBeLepAgaKTRYOvwETN07VqiK5IqoD4bNzq4H3/VyBgCP/RDzHPaNYaXwfmm6uVfYCu/Qq0bGln/dVLqcrCF+srAhArIBHmlpr8ysTdfh1EiAMCPq1Mxem/NJVEUtWtW/uaVP0e2QereeQXHD0pP01lvlKsJoXxd4L9Hf0EKJ2jBGeJp0WtlWni/10HTmup5X9AV2mRdp5hlP4alGgAsrfATej/Qc/0opFrK9xIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(346002)(396003)(136003)(376002)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(41300700001)(8936002)(5660300002)(4326008)(31686004)(8676002)(66946007)(6512007)(53546011)(2616005)(66556008)(66476007)(316002)(6666004)(6506007)(26005)(6486002)(478600001)(83380400001)(2906002)(38100700002)(82960400001)(31696002)(86362001)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?QlQwcGs3UGlhSllZbkExWnc2Smk2NDhJMDU1RDQ3N1ZJQWd5MUlVY2pBUTkx?=
 =?utf-8?B?QXA3T1liSStISjMzcEMvMmYyZXhia1MyNkN4QVRZcTFtM0JYN0xPSm1ic0Zh?=
 =?utf-8?B?SnlYWjFRQ3VWRWJJcFBNVTMvMm9FR2w0WkRNblpjTHhpR0dwSS9vVk9vTENH?=
 =?utf-8?B?SlVJU29ja2ZaNnRlcDJOcXNVRFBTL2xISURXMUM4RGRtekRXVUpxbHd3bEhT?=
 =?utf-8?B?YVRCa3dCdkpiWENBOENUK0JNSkJrRTdSbnhzbGpvSFFYWWhtUFdKK2o0Q3g3?=
 =?utf-8?B?UzYvSXpPVk8wOGIyZUEzYktFZjhaZDhsRUw2Y0dtdHlidkJsMEE4bTdYcVQ0?=
 =?utf-8?B?Q1JLMUptaUxvOE82czdqZWVDQmVzd01LU3E5TmlzMENKYU91UnhGRnZKYXVj?=
 =?utf-8?B?YlhFOXcya0toaGtrTm4zRXBRbmluSFZGWFdlK1pKYXpvRDllK2NxTzMrUTQ4?=
 =?utf-8?B?RSsyOTNnUEdJMXk4OFZpdVNlZGhQaUZ5Z2QweGVIaVdXdUZhRUh1cVRNTmYw?=
 =?utf-8?B?RGpkR3VGaXVIQmU2ZzlzWnd4RURJYlRBdnRlZG15WGZGaXdUTStDaGVnMXVh?=
 =?utf-8?B?ZWFTcUlaYldNaDFodjhUbWlobzNMRjljMzNaRSs2dDB4SVpJQVlRd1hZR2pQ?=
 =?utf-8?B?cllzaG43Z05ybkFVVjYzM3JPUmpQSDFHQnFReGFLTVd3eE9RQkhqdEx2NlV5?=
 =?utf-8?B?eTlqdENDa1V3c3cwV2FReE5ibjluNmFWRTFIcUN6MXAyRU04UGRtQTJJNTBB?=
 =?utf-8?B?UllEWTRENnY2VVp5Sk1HWEliRUlzaW9iS1E3SFFQbmVsWmhrMEVvWEtPSC83?=
 =?utf-8?B?Y2dSUXFycWkzNGpXSEJVOUUyc2xKbk5EVDFsYlk3VDAweUJ3dU0ySThESXNE?=
 =?utf-8?B?YllPbURJR2NEUkpiUUo4Zlc2QnVxQ2RBNGtnL1F6UFJTWnBQdzgzaTJ6K3RL?=
 =?utf-8?B?WmpPaFk2MXhhVDNsNEN5Zmo5QU0yTFIwa3Q2dTUxK0JQQzEvZCsyc3VoWkY2?=
 =?utf-8?B?SVhlV2N3MndSSnEwaUdIeXZRME8vWGpOVGVzZlc2ek5NM1B5TS9GWTVKeUYv?=
 =?utf-8?B?Mk9Kdm9SL0ppQWh2V1BkMUwyOFNCSnpKbUFpdzl6WmpsWFpyc3prSUE0SDA5?=
 =?utf-8?B?eVdRUWxwQWVTVmNFOFR5Z2d1ZTduNFl1R3g1dmIyS29KWnJHZmp6OUw1UEtK?=
 =?utf-8?B?Wmt0cWU5TGsxRHBBM09Ca2hHODBaalBBOS80aHlhUzJYU01FdXAyaDFVMGsr?=
 =?utf-8?B?dENXZDZyQUJqRENmVW9mU1BGVU5tZU5XV253WmhZN29sNk91V1l0WndGYmNQ?=
 =?utf-8?B?ZjR1eTN6QXU0TjlFQS8wUHJwRWptbisvRitLVWE0UVBZMXA1YnpQcHE4amxV?=
 =?utf-8?B?akVDT1BrVEFNeHRDMlN6elV5ZTlxb1hVYXNOb2xrc2sxVit0Ky9GS0R2eW5S?=
 =?utf-8?B?Rjl6NkZ6YkFuWHlaSHdMb0ZSWWcwaTUxRzNuYUI1czBpVFZwNTlxQnRVNUg2?=
 =?utf-8?B?NEd4QndpMWY2ZFFCbUVWd3VKMlpzYVBTY2ZhWlpMZ2lPSi9pSit1VEpqaEp1?=
 =?utf-8?B?Vzh1bzdCb3hFR2ZCUVU1NDVrSXJuNHA0V2VacEpLTXNIa0g5Y0hacHJ0clNG?=
 =?utf-8?B?RG9PUmk3RHQyT3cyeWVlMHc0dGxZRHZzaEU4ZGdKT2ZuSm5pWTVHSklqZ1hj?=
 =?utf-8?B?eE44bjRQeFBjQ1lHdHhtSDRiZzNvUGZaazNoMmIxQUpLajVhdWpFblU1Vkxy?=
 =?utf-8?B?d1htb1BrSHNCOWxLTCtCaGgyT0hSM2pUR2t0Mll0dmljdFBvNlkyT0xWR0tK?=
 =?utf-8?B?c2xXQ2hQQTREUXdZczBZQldHVjJ4OEEzMUdHYUdhdmxCL21saEpGNXBuR0Rx?=
 =?utf-8?B?eHhWaXZJZUZSZVU5MVNrMnBTMWw5QWNTUkMzby96YmhINXpKTkRwM2l4VUFu?=
 =?utf-8?B?c2lobTZnYUlnaHJjUktGcXNiZTFmL2ErNS9adFhZZ3krSkFHQ1FlZ1NPeUVi?=
 =?utf-8?B?eGkremp1MkdqWlhOU1ErVTZZektKSE00a3FUeExEKzYrWkV1Ym9PbS9aRlo1?=
 =?utf-8?B?U0JSUFYvTm9BbCtkc2FvVnpQdzM1K1I5UEhhUWR1NENYWU1KTVpZZ1Y2SnBu?=
 =?utf-8?B?RkpGMmc3bXFHcFFWcmJtaTljUi93T082YjJ1MnJRVE1OR2g4Uk9WUjBPZTFY?=
 =?utf-8?B?dUE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 026f86cd-c72f-48b9-34de-08dbd1cdf44a
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 00:37:50.1580
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Rw6quTJyzv1xMvhI1Q2oisMRfxdtZluNfCXLbzr+7Tt83AMajNGcVDcmcvw2GhS7fh4GMowjN4VFodgztArFkbEg6Q8QLMa3oW2r4QCaNtY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB7152
X-OriginatorOrg: intel.com

On 10/20/2023 3:05 PM, Jakub Kicinski wrote:
> On Fri, 20 Oct 2023 13:26:38 -0700 Nambiar, Amritha wrote:
>>> WARNING:SPACING: space prohibited between function name and open parenthesis '('
>>> #547: FILE: tools/net/ynl/generated/netdev-user.h:181:
>>> +	struct netdev_queue_get_rsp obj __attribute__ ((aligned (8)));
>>
>> Looks like the series is in "Changes Requested" state following these
>> warnings. Is there any recommendation for warnings on generated code? I
>> see similar issues on existing code in the generated file.
> 
> Yes, ignore this one. I'll post a change to the codegen.
> The warning on patch 3 is legit, right?
> 

Thanks for the fix to codegen.
Yes, the warning on patch 3 is legit. I'll fix it up in the next version 
together with addressing other review feedback on this v5 series.

> kernel test bot folks, please be careful with the checkpatch warnings.
> Some of them are bogus. TBH I'm not sure how much value running
> checkpatch in the bot adds. It's really trivial to run for the
> maintainers when applying patches.
> 


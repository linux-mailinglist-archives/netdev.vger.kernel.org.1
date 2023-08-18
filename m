Return-Path: <netdev+bounces-28761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C7827808C5
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 11:39:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB969282348
	for <lists+netdev@lfdr.de>; Fri, 18 Aug 2023 09:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8638618004;
	Fri, 18 Aug 2023 09:39:21 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E1EA168B7
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 09:39:21 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7437C12B
	for <netdev@vger.kernel.org>; Fri, 18 Aug 2023 02:38:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692351532; x=1723887532;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=snMPWWZxj682bq/eFn1RVxSx9ZouIsjvrIS+2+wX/E0=;
  b=dsFfD3z5V1N48nmw2kxGIySZmWrtI8Hm3GUFKt5cuualHTWlN7eWOJ/2
   U5+rJqSbXphYmlAQO0JqfNJO+jgLLrHdEcIDew7DbPfcS5oamRr8dbarP
   pS9O67DaFHCH4gMBDelstPdzmj/zk2c3x5ELMuWNxZLiUIsHc6tD48wAQ
   flSWJyMzL26NRNZvOmcRuRzcSjbu8/lJNg9p9dXOsKrJmJdRpBByrTSuq
   hZDtAUeakhhmAwnsE0xwQM0c6kWnR+YB2RhBoR8IUvwvRbmutUEK2ASTc
   TDYnSYB5yXnHcGVPgkOjih3DSjD7Brja2se4W3PQPnjhpayZLdDNFDgTO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="375838829"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="375838829"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 02:38:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="1065674363"
X-IronPort-AV: E=Sophos;i="6.01,182,1684825200"; 
   d="scan'208";a="1065674363"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP; 18 Aug 2023 02:38:49 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 18 Aug 2023 02:38:49 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 18 Aug 2023 02:38:49 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.44) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 18 Aug 2023 02:38:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZyISGhQ7o8ZM3DSLh9BlFim3dlFLVVBm9sDcV7jCixBF0XxRFJTdMDVSPSudjenfO9AIqV0uGvW4EF87l0W1QvNIe9MtPBSM4W/xBc5e1PK5ZFRgYRQCi+ZDpSE/Vo7EtxOpFbnluShKm6N77FYNXZ+keYdHFrHhCNdvh2MZy3vaJQb/e5udQRv+nMY4kQ/X0+IGTlagf/SE2LC/Da915iiZ15dsTMBNV2UjIoBEisnqYjEneYdvlUcpQDuF/D+pGZv7IYVyl5rup78Gy8+svs5LMamvPtZTo/MowDw4IOHSn5Chbf2I7G/l64JGq+jeG6Hof+V0V5cZPwA2UH5rHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=brxwVNMteS9yWnW/45e59Imu3s5rRKR9b68NdRD+i7M=;
 b=cJ21hmDqjlQVxzjhjRrvrCbfcS0NeHH+Vi9SLUUW/PSMtm2ZpzxRl+HLcCJanD8K1SFF0pd9Cp4bHesJUvcrSkOCOMq4r8q6n0nOw8QlVA18RpVLQk84vZvgzHi1PbZLJU0WfU+9FYHl8Iq6rGF0F4B25Vhu1rnsMvTOZOaEhUNHN+gMEGfNxM5eqaiHJb23Cf7hJSdskDfsYECMgHJ0IQeBBKM6+l7mlKU+Bxj0vDkz5L5em4sWmx4lDMdb3ZunUheoC7dIUdk7PMwIf7K6oGQdIDHn5OqMk/WtY4SvOH6qdB21FjUbyOxNQAqwfX7BDnyToOdifboG4m83W7R5Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BY5PR11MB4451.namprd11.prod.outlook.com (2603:10b6:a03:1cb::30)
 by SN7PR11MB7994.namprd11.prod.outlook.com (2603:10b6:806:2e6::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.20; Fri, 18 Aug
 2023 09:38:42 +0000
Received: from BY5PR11MB4451.namprd11.prod.outlook.com
 ([fe80::2688:72bb:8000:c1f]) by BY5PR11MB4451.namprd11.prod.outlook.com
 ([fe80::2688:72bb:8000:c1f%3]) with mapi id 15.20.6678.031; Fri, 18 Aug 2023
 09:38:42 +0000
Message-ID: <88e9588e-705a-9592-8f25-31a85c40a793@intel.com>
Date: Fri, 18 Aug 2023 11:38:35 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH net 1/2] iavf: fix FDIR rule fields masks validation
To: Leon Romanovsky <leon@kernel.org>, Tony Nguyen
	<anthony.l.nguyen@intel.com>
CC: <davem@davemloft.net>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<edumazet@google.com>, <netdev@vger.kernel.org>, Rafal Romanowski
	<rafal.romanowski@intel.com>
References: <20230816193308.1307535-1-anthony.l.nguyen@intel.com>
 <20230816193308.1307535-2-anthony.l.nguyen@intel.com>
 <20230817112738.GH22185@unreal>
Content-Language: en-US
From: Piotr Gardocki <piotrx.gardocki@intel.com>
In-Reply-To: <20230817112738.GH22185@unreal>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0180.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9f::9) To BY5PR11MB4451.namprd11.prod.outlook.com
 (2603:10b6:a03:1cb::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR11MB4451:EE_|SN7PR11MB7994:EE_
X-MS-Office365-Filtering-Correlation-Id: fbedc448-7c9e-4894-4ddc-08db9fcee8d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ne7ZNBad6Uhj5EO37+ISOO0VAbUsHuCVevv2Fi0woV69nXCNzMD9IG1sn7m+zUCRnz3b8di4uyKDqEPDA1m4Fa96KcYxXjNe+RLjfDQbGX7Cx4iaNUXkGnYcD7JYdilx/sl+MAB6qOpMlDqgDIc1I1ZDP4sK71kqrh4Rdx7xaF1fDyu4rGu7g8jxJGFwXn5jezOpfEokt6NUYH8ldcnnVgBUZENQx7gBmrowd4wqve7s8/xh3tqAz3GInS8lnPLCVFOpFA/jInIQ2g9mwArfZYBmrXOQYS2NHY+oHAF/qqLB0LemQaZu8VFs0vUN8P+civ4mVrZvXwwDpUbpj0/sQlMVXazFmcwzTRbQWYwqHuljVolkNMOwGotdonNtt7Fv7xbRXUJPNc1OBRqI8uLHDQ0HSFilAEZpezqmGu1zWW18RSJ2snsglX0p2VUP1pspfF/pl8xWwfN2GR1VqY+YxUynkQIz/Ws64+oGPiXsxEcP4hm0KCgnNEor+KauZyGv6VhVRX9ea4LU2uUr/h7JM0Y0Lu9xqc+XPKG68x6NY5DC7l8xdZ5KkqC14TATnZya72kkL/s1FkYTN1t8zmiiBPHFGOk3RmrfspN8t+G/u76mkJc4eTi6SVVTUcuXEHSgsp1kGMnuoOectnPcr6oKZw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR11MB4451.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(39860400002)(366004)(376002)(396003)(186009)(1800799009)(451199024)(6666004)(6486002)(6506007)(38100700002)(6512007)(53546011)(82960400001)(86362001)(31696002)(107886003)(26005)(83380400001)(36756003)(2616005)(2906002)(66946007)(66476007)(66556008)(316002)(6636002)(41300700001)(110136005)(5660300002)(31686004)(8676002)(4326008)(8936002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dmJwcEJTWlZVWDFWcVhxM201TTVHZVVPMTlqL01HVVkrRWQ4eVU4R3NmQ1N5?=
 =?utf-8?B?a0RDRXBBNklJTFJIZnFaME9OQW96Tkh1ckdNN2orVzNFNlVhcTRxdlJqVFAv?=
 =?utf-8?B?bnNkUHdaSThOVkh6NGY5WHppNXo2dGZjYkV5d0p2bnJUc3lKZEF0NW9yNnZr?=
 =?utf-8?B?R0R3cjNmSjlGUEFCS0c2ZTJKMEtMSml2a3lYcnpjTmowUWJXOVc3WUlwSjdi?=
 =?utf-8?B?TUt6aGxKZktDY0greForc2w0VXlOdGM5WE5WQ2lyYlBlRUY1SHdQbFlwVkJn?=
 =?utf-8?B?TFRFQll3eU5SczV3YTlRazY5N2RXdThFdnNjSWRjKzUrcVc5bzdERHJRb3Nv?=
 =?utf-8?B?Rjc3S1I2dllSc29NVFJlbTJ2c1VKYkIxNEJ0bTNOTzFsWGhyNXVQYUQ5T09o?=
 =?utf-8?B?YTMzRFFsdkxENHAwUDZ1SFV0MnRacU9DUzV2c2V3ODVWMDd3SVAxMzNoL2Ey?=
 =?utf-8?B?V1ltakN3dEM5YmxGT1JXbURuU0t3QnRxaFVZKzE1VGE2M3NhTXVGSFk5RHd4?=
 =?utf-8?B?czdsdXdNVFhnS1IxTUVOZDUvNGdhRnkyUkplbi8yb3NNb3RsbHk1U2craXZQ?=
 =?utf-8?B?Yks1M1VaRHk1Zno4d2l6b0RCQlpKNHB3bUMzZ0FNSU1iNEExUERnRE56U1FD?=
 =?utf-8?B?aDl1TnpQUWdKdnhBZ1Z5SkU3NjYyZVBLdCtiR3NpUngvZWsrcThLbjB0V2t0?=
 =?utf-8?B?ZEY3Z2dZM2NFU3BCU3o0Ui9aNHpxTDBBQVA2cGR6YTRqL0RPYzlTM2xQTG94?=
 =?utf-8?B?bzZIcUdFd25VeXJCdDkyOGRBSHVJR216dEVmT21wdWRlbkF1WG9ic0VFL2I0?=
 =?utf-8?B?aHRYYU14bUdST3F5bTFnVm9ycTFkaExlYnVTSnMzeGduckRMMEtHM0NLbWQ2?=
 =?utf-8?B?ZVJhd1ltT0g1d1FZNkx0QVRjZ2pmQURRbmlpQ3g5WWsvam9ZbnhhT2xYeW55?=
 =?utf-8?B?WXlOa2RVbFZoRnd1NHJmckNLZlhkMkI3cHJ0SS9xM3FvT0RHNjVWam9hS3lH?=
 =?utf-8?B?ZHBDekpxdXpuWDk1WkFMZTRKazR2OFhBNS9BM1hGTFNpdTlsYzBremgxUC93?=
 =?utf-8?B?T0JaMHJKUXY3N0pxSmxvdzNlWXQrVk9qRk56cG9YcnpHYkMzNzdERm50d3pF?=
 =?utf-8?B?K3c4NlgyQWJZeEw1QjZvNUIxYkRCYmpvVXdHbGorRXdNcjltdUlMUXhvYVY2?=
 =?utf-8?B?QU85MEpvUmhMV0EyVXVPcG5QdFlXYTVhZTJ2T21WVDUrSk9OK1c4YXlXcmdH?=
 =?utf-8?B?YURqQXV0dy8wWGk4RmxGTTVmTFJkeXZrUmJOTFJQaGhCNXU3OWpwZWRrbjUr?=
 =?utf-8?B?VUZ4Zi92NDE4QnhYREtpamZwQXYwYm5pWUI0UHp1Nkw4OW11M3VTQVBuK2o2?=
 =?utf-8?B?Y1ZFK1E5bndPa2wvZUplQ2tUT2JyNE1hcHFITGNiV3FmNlJzZG5EZW5xRUN6?=
 =?utf-8?B?ZDI2eGhGcDMrSFN5bXQ3NWxnODExTXhZUVBEVEJ5ZjRBR1k2RG1mVXlBTkRJ?=
 =?utf-8?B?dFFZRmw0cXNmV1JtZFBvdkpwMUlsQmNCeEcrb1hreWVENm5RMS9EcTg0WHpw?=
 =?utf-8?B?QTRTV3BwS01oMnRSQjArdmdKTG9LdUYrTkN0ZnczMytRMkdZdUlYajNCa0Nl?=
 =?utf-8?B?SE1LenpwdVhvUHBEM25DMlRkMTVJc1piV2ZmN0R5aUhBQTBJYXBmV1lhL3Fa?=
 =?utf-8?B?b2lXVDB6NlFuNnFKR1E3UEthVjA4aTl6Z0IzRE9XVjhES3YrbWNPN1JKd2xL?=
 =?utf-8?B?N0ZoSXlnbStISUdBZElwUjhnWW42Wk9pWjdlUytCMzRoYThDOUwvbXZHQ3Bx?=
 =?utf-8?B?T25vNUR6WVdwV1hLUFFmSXY0bThsblAyNHFKNnZPYU1uTC94RWRRemNvQ2hD?=
 =?utf-8?B?bWFnZkZNcEh6ZmpSYyt3bnR5eGV3Nkc4emRGT1pjbERDYjVEVGZLeSs2cG9z?=
 =?utf-8?B?V3F0bUxnZERnUjRhdkwramJ3UkRGUHVFNlhFT3Q5WnRDNG5saTRIMHdLK0s3?=
 =?utf-8?B?aElsdEsrRDlpdVNtMW0zQ2N5OEdRanVjOUVuRFJPZ0E2UG5XbEhmeEYwbDky?=
 =?utf-8?B?eEp1Vk4zVnRLL3I3ZXBTZFJRakladUgrT0pKS0U3YzBocXZwNmdNQVBKMWE0?=
 =?utf-8?B?UjN2aU1mMHJTSXNjT1pEWktpN3V4VC9JdVhXNW9ZRDdmOWw4OENieStZa2xx?=
 =?utf-8?B?a0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fbedc448-7c9e-4894-4ddc-08db9fcee8d3
X-MS-Exchange-CrossTenant-AuthSource: BY5PR11MB4451.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Aug 2023 09:38:42.4127
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vKvRrvXTCeRMqcbsbtqvKAyWvYP79GIOQo8KLbLNZdKzKzgM8gO0zCwpN0NgayUNzgUTO0v8qeDFsDxzODUGMoTi0UMnEyIRqipdRt43xcE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7994
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 17.08.2023 13:27, Leon Romanovsky wrote:
> On Wed, Aug 16, 2023 at 12:33:07PM -0700, Tony Nguyen wrote:
>> From: Piotr Gardocki <piotrx.gardocki@intel.com>
>>
>> Return an error if a field's mask is neither full nor empty. When a mask
>> is only partial the field is not being used for rule programming but it
>> gives a wrong impression it is used. Fix by returning an error on any
>> partial mask to make it clear they are not supported.
>> The ip_ver assignment is moved earlier in code to allow using it in
>> iavf_validate_fdir_fltr_masks.
>>
>> Fixes: 527691bf0682 ("iavf: Support IPv4 Flow Director filters")
>> Fixes: e90cbc257a6f ("iavf: Support IPv6 Flow Director filters")
>> Signed-off-by: Piotr Gardocki <piotrx.gardocki@intel.com>
>> Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
>> ---
>>  .../net/ethernet/intel/iavf/iavf_ethtool.c    | 10 +++
>>  drivers/net/ethernet/intel/iavf/iavf_fdir.c   | 77 ++++++++++++++++++-
>>  drivers/net/ethernet/intel/iavf/iavf_fdir.h   |  2 +
>>  3 files changed, 85 insertions(+), 4 deletions(-)
> 
> <...>
> 
>> +static const struct in6_addr ipv6_addr_zero_mask = {
>> +	.in6_u = {
>> +		.u6_addr8 = {
>> +			0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0,
>> +		}
>> +	}
>> +};
>> +
> 
> Static variables are zeroed by default, there is no need in direct assignment of 0s.

Thanks for comment, I will change that to:
static const struct in6_addr ipv6_addr_zero_mask;

> 
> Thanks,
> Reviewed-by: Leon Romanovsky <leonro@nvidia.com>


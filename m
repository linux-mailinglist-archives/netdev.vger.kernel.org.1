Return-Path: <netdev+bounces-43070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC0F7D146C
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 18:54:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0FE92824FF
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 16:54:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CADAA1EA77;
	Fri, 20 Oct 2023 16:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hGbfGWXK"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 308B61EA64
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 16:54:34 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A5318F
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 09:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697820873; x=1729356873;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=li9uqBZB5qlVulj3jVFlbFGun7HTN9Su3IWRU0uieKI=;
  b=hGbfGWXKLgbJpyebO/JB0VGpreYnj0dGSI1VJv4PgRxdVOGokYStmLXl
   5lesg2YGfgduloOqbi/ACZJaUaBqSu+3JKzciFUpvSURhcWRBIVbOgHWl
   Ft558PK2X9iNRGw0ypSzvCpVM4hyzoHVLM8lCYNRUH2nAonCvczJKyEdR
   8sYU9d5e0BBaANHiAyu1D/vww+hOBHT6+t7rcSIJZALZhagYWTbItSF7/
   BivjB65RZSJWP6ocMCMTSqfN60RoFn5Lsjwq5bL3JWKoy/NLERGCeUdrE
   RaBx5jhu9Yquo73sTSHsAPSj1SVYnMWY58XwxhzeOPy0Jhjl4pyse4tzj
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="472756857"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="472756857"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 09:54:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="1088799769"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="1088799769"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 09:54:33 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 09:54:32 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 09:54:32 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 09:54:32 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 09:54:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GeA3Q7IRtqxu5z7Yuxedyl6xKLt2rkj/8+oiKrws5jbLRk5XxT8vclZFpNwHEOR8TkFnDhYRhWC/Gjk13LaO0a+AQZCquqoXu9feFjv1qdf+5qQQcIidRm2IttnGBjqkZVij8xvD1k2Jxi5XJXRKMw5/Oig+sdYV8XzOwLDNvudvzUrHXR1WWHevotr2F/8km4145t10g206f9aEDa6iFzUJLBT1t+NtL80yxxJKph2KtfPnq23GdRdUIJT2LtVTYttI/waj5ESlvrgJ6dhc8mOFodWJB/c3Vocn2tpZHMHir2V6MlWPqD/5aTiiUUpqPhUOlD+bvC9vZiTkI61RTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TW4NiRApuez3t8qcplL0YSTtt5gH/m8czP1FvoehGkU=;
 b=jmDCMCirc++KnhFn5ry5YyOSO0hCED9+OcSA2HV6imSFeKcxJTHcGePx+2qvNLjyw/IeUVvDGizjRYBhSZFJ7tM0iZ1lEbJDvwLBUiaG3/RqBWKcXCnb6ZEgp9FKraazWNgpGwCE6szKsYfEhcsQTH4HIt7YGRlIkcmiowrQbSGZO91kVh/iIOVEibb8Ok1TSmUqlN0+ObyHiAAXk1IO7y8hHZzCG8icCm4ZxK3FD6C1NeqTezOkqj2V0YZQVwEUgsy+Xjq9VlgamCmy2H6m7qIjCot7kUmsEPw8QrU3Jn8O55i+yfWPMbyURZ3Nsy1Don3A3Wbhpiyn70RdME0p6g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by MW4PR11MB6811.namprd11.prod.outlook.com (2603:10b6:303:208::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 16:54:30 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::db8e:c076:1c95:fb66]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::db8e:c076:1c95:fb66%4]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 16:54:30 +0000
Message-ID: <f48526f8-4e7c-ed94-ff18-eeaf475097ef@intel.com>
Date: Fri, 20 Oct 2023 09:54:28 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next v5 0/6] ice: Add basic E830 support
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
	<andrew@lunn.ch>, <horms@kernel.org>, <anthony.l.nguyen@intel.com>, "Pawel
 Chmielewski" <pawel.chmielewski@intel.com>
References: <20231018231643.2356-1-paul.greenwalt@intel.com>
 <20231019174900.29d93b3d@kernel.org>
From: "Greenwalt, Paul" <paul.greenwalt@intel.com>
In-Reply-To: <20231019174900.29d93b3d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0167.namprd04.prod.outlook.com
 (2603:10b6:303:85::22) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5140:EE_|MW4PR11MB6811:EE_
X-MS-Office365-Filtering-Correlation-Id: a2c58f2f-23e5-4d19-012b-08dbd18d3a31
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 6mfIQOAZ51VIw9Uh1/D6u+qYo4h6cM2Ar2k6yc7BpnR4U+oa0nqMe8S7ZtEitS8u7h6xBzAdbity58yy6ttSfCi4bVY+5kL5O/PTrff0YprUk3xNgFZ6LbV+yT/Vx5MRJkxG1FYJ6jApxCxnfFfNm2z8/qywb/Mwl00CpQzlNpVO9CCjgQ8bSW5sDODJloxW0swXtKvnaS0sJFRyZvWWHckNUMu27tow3movWXtmmVrhbJ8ltIX0xTC7eJyXJUZ/kqNL4o3sOzY/vkPxyMl7kRYDtGXn+4ObZ0G7mGfh6/YjRmOYyP0Tj6CNxhO6Ue3mZAqnkGPkZxz4ml2c4TUeSvR3zRMnKnMN5iTwCsG/suEojK4mmHgy5N9aOMT6zANDiafSUGmV+gxDOAt9bZ3oUtz00bBDlnmSt+VdOsUFz+at16rG5whlqkvm3LTxn6mBYKvIlzB25b1UgXOiAOJLCXZQhA5JR6UTwgdWxjIT6tt5taQ20bRjpSaKi3hZZcpPLv9ljRZ1RNsVC3YzbQWCp4Q6OTr/uKiCre+M8a6ud6j5TUfB9UtjxGlFTetMUeVszcL/vuCsWUJjxcF8Vv/SOQSNim8VOfoq+XBDyHb+60ayOfHC5KRKFlhFlOl/k8lh4vG0RXMxYfWljoEp/6zJcA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(396003)(366004)(136003)(346002)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(36756003)(2906002)(26005)(107886003)(4326008)(8936002)(31696002)(86362001)(8676002)(38100700002)(2616005)(82960400001)(83380400001)(4744005)(6512007)(53546011)(6506007)(6916009)(5660300002)(316002)(478600001)(6486002)(66946007)(66476007)(66556008)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UnowTU1VUlFyRTBkY29RSllhZ0FpWTNtTVR3cmF0TUNOdGdGRXh4Rmd0RkFv?=
 =?utf-8?B?MlpqL0U4Yld6RDR5eERFUnhIRWZjakk3TEMwWFRORWpGSWppQkVYbVo2MkZh?=
 =?utf-8?B?bHV1QmxMNnlsZVRMdkg1Ym1BZlcvMjJ3RzhaU1lmWGNtZGMvblFiNGtGZ3g3?=
 =?utf-8?B?R0hYYmpIdDBDWnF0eVF5QnAvaTNuS3l5N05XRTVZUGRieFdEeFZuZkpJUG1C?=
 =?utf-8?B?aUlib1h0dWRRTEVEbk9BbElQMXpaSWVKTmNNWWprYyt0SkIzUTdabEQ5M1dl?=
 =?utf-8?B?ZmNJb3dDcmUyRDhoa1pQenIwOHBtQXl5ZXN0am82WCtMVkt1eDZNaVpyQjQv?=
 =?utf-8?B?QUFRSW9LQXZTejhJUC9zUk0xSnZWYkNzWXpLekNzRWtBV3pEaGd3eGZWWE9J?=
 =?utf-8?B?YXhQMjJTNzBiOXNOOXlod3hrSy85MWhXODRsWHJjdTlMTTZLVk9GRi9YYmFB?=
 =?utf-8?B?N0RGNFRDODREOWdmVlBLL3V2SWRCSkxDSjRCRlc1S1IxOUZYaTE0d1FENUM3?=
 =?utf-8?B?QXJQUmZYSjlWWE4rOFJkWnZJTEJCVTZHSVJkTlAwTXN1UWpzS0NaRnZ2dmR6?=
 =?utf-8?B?aFF3SlFrZkl4ekIzM3RmUzN5NmYwWlRaYXVUTm52N3dmakpPM2ZoSUJFQ0sw?=
 =?utf-8?B?aTl2UVJBMGNLVVVXYWxUeE1uNEdZZkd2OGNPZ2s2dGZYcmlvNWNPbHFidm5M?=
 =?utf-8?B?UXZoQ0R5QUZQbU9ON05PamViQllJdUNRUXZGK1EvTGZDYXBLaVhSdVRCWU5z?=
 =?utf-8?B?ejY2c1hUNEFmSXAyeFhDS29FN0YzVFRlUld5SGh5MEs4bUNQMUdGNFhqaTlD?=
 =?utf-8?B?TkxLMHNRWkZ6SFEwOEVTcElJN3lWNE9OdlVSMEdIV0dmQVVUZXlKRnNqR3pJ?=
 =?utf-8?B?UU9Lb1lhREdDUk00UEtyNTQrZWxoOVJOanVGQ3lJcG16L3o3ZFQ2V3lLK3VP?=
 =?utf-8?B?UHFrd25hOHZscTZWUXRweHByT3dyNVdtaVM4eVFZUzdnT2NSWjYxZjlxV2xX?=
 =?utf-8?B?ajNyRXpJSEdqY2tNQi9ENWNZS1NNZTBGZ2RPV1ZCU2pVWlJYR1JGK051bGZz?=
 =?utf-8?B?Y2hST2thUlA1NnlWZlBvdVppSFhsVFBJN25UeVBkQ0owbUtNaGptS00wNDZm?=
 =?utf-8?B?VjFMV28xVDBoUVlBRU1sTDJKa0VKbVduQXV2RmpvcC9Ed3EyTWljTzhHRElZ?=
 =?utf-8?B?Y3dNcEcybzhaMEpGRndtaWRYeTI1VFpPeE5XNEorY3V2VkR5ZVdXZUJUdFRZ?=
 =?utf-8?B?V0JFcGFNZVJudmJIdGxJS0gvdEpaUkJUNC9CbGlCOEt5cjIxbnFvZGhHUk85?=
 =?utf-8?B?NlpUMDcrQTRFWGRocklkYUk2aVhaemhkRlFNaFpLczB3ZXRxRFpmTjA5VmN4?=
 =?utf-8?B?ck1WNU5icUZaZDgzWThzL1pDeXZhK2V2K2ZVRDI1WDNCVmRRVmpsaDUrTzRM?=
 =?utf-8?B?ZWljTWJNUzlpb00zRHd6TGpPdHRqYlM2V0ZscHo0eGxLK2J5aUhvbk40NnVT?=
 =?utf-8?B?Z0o3UzA3bHZydWtlcWhLcTR6UmNLbkFCME55dHdCR0xhUEFKSmtweDlod2RL?=
 =?utf-8?B?SStiT0pYczhCdU1WclN2VUN3WElFTWhGaklVM1RIdDBZdGpxUnI1Mkl3TVk2?=
 =?utf-8?B?R09FMFFDVG1Hb05ycTdIc1MrTVNDRWZjVm5HaHM4N0VzYWppYXJVV25ML0Nj?=
 =?utf-8?B?OUtvNWtIb1BuRXByWXVoMFFPeUgxZTB0VHF1RFRpVFNHOUk1TVhWZDVyYTJW?=
 =?utf-8?B?MXl0NEF5c1ZlcEx5UjRIdjQwOGxIUVdKSXp6eTNBTEwrbE8vL3RFMFlqOXJm?=
 =?utf-8?B?cHlSNEJoaWtIU2JmWTQrVGt3WktsRmVLekN4YzNGd3NUKzczdzdnbWZmaFRr?=
 =?utf-8?B?TXB6NTNPVnZUQ3h3djNhNDMybGJOQ1BkUzhwUllsUTlGRXh1Z296b3ZhS05X?=
 =?utf-8?B?QWFkbE5rZGdUaVlBOXM3VkVOdWZuTUovYjJwRG4vOFljNVJNM2NvT254RFdV?=
 =?utf-8?B?eEFteHBqb2t4d2xkdFN6SlYyNFo3dUdGZW1QS2wyaGRDWWhwd3R0VFRVMHZH?=
 =?utf-8?B?cWNzbHhmb0hJWHBHUlB1eFRQem5kK3J3R2c5ZHFobzY4QXdXUk9FOHEzaDd1?=
 =?utf-8?B?K1RQeEcxYjFISVBTd0g5ZElLaGw5Z2ZOM0dzSlVTT1l2Q3hHMlljK1N4ZjEx?=
 =?utf-8?B?Vmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a2c58f2f-23e5-4d19-012b-08dbd18d3a31
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 16:54:30.1641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QmnREGVqBd9OYHZk/90AVHvQQBZYDwCba07q0OpK9jXVTdebhVoSvdgHc8siz5XWLi/0c5TKz779h9hc5ujL5njB27Rp8Gxz/Z4YR4jVfbg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6811
X-OriginatorOrg: intel.com



On 10/19/2023 5:49 PM, Jakub Kicinski wrote:
> On Wed, 18 Oct 2023 19:16:37 -0400 Paul Greenwalt wrote:
>> This is an initial patchset adding the basic support for E830. E830 is
>> the 200G ethernet controller family that is a follow on to the E810 100G
>> family. The series adds new devices IDs, a new MAC type, several registers
>> and a support for new link speeds. As the new devices use another version
>> of ice_aqc_get_link_status_data admin command, the driver should use
>> different buffer length for this AQ command when loaded on E830.
> 
> Please make sure to mark purely Intel driver patch sets as iwl-next
> rather than net-next.

Sorry about the mistake and I'll make sure to avoid that in the future.
Thanks


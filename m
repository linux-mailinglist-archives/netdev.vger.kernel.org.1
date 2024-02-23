Return-Path: <netdev+bounces-74566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 01D75861E27
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 21:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 57C70B2283E
	for <lists+netdev@lfdr.de>; Fri, 23 Feb 2024 20:52:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3655B1448E1;
	Fri, 23 Feb 2024 20:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="L67Bdrl0"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F79E143C7B
	for <netdev@vger.kernel.org>; Fri, 23 Feb 2024 20:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708721523; cv=fail; b=pPGPlVujfgC8XoZGCxxfB1syM5SPJs8vLPdhiSVUtWmVa6+Dr917kOmR4dkBusVBByevmdeB5vjYWozsR930R8/a9hm6/YeT16t78ol6p8MIzcmeOexI/cjdl0Yh8XLehbea8vTDMIhE/wqhQgADt9buozRkIZJrY/g3ZG3QuiQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708721523; c=relaxed/simple;
	bh=I3vWW4EhbqR0tmOf+QCdwC8Z0gyCIVxHypHKiQDwUZU=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=YUHqR9Quyl2EsyXIMIRmfySAlAUM4JC+PzuWCeylzAwGBqKI9W0wPL8YDYxhx/vALYAY9qAnD7llSGRp3SDFHNhzTappcFPegth8C9Qq3mIfoYT+O6cXWgQ7UcmmdItpMHFyS2jckN5Ge5KC+5hD8uUykAbaJb3QFYE6WNP7rWE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=L67Bdrl0; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708721521; x=1740257521;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=I3vWW4EhbqR0tmOf+QCdwC8Z0gyCIVxHypHKiQDwUZU=;
  b=L67Bdrl02efgY2GUZBvW9gSXuxmVfrLkR7JDcYQDkzOOAI+xwWLKT2P9
   xqplZK6IljX25za7+7Xc8rARleM7I+AHqomEJlMEjcqy2NtKxysjjfhet
   Skx+4sYp6JKXg82ghhfMUaUCOOwVz1EvMmf12HAxt8qI3Kp0tgDaD3yFz
   Q0+ZoyyAtWA4ZIJaKBQjYpTAieXRlwUPJY//8sYsjrELNCeFdYTjj9rTI
   x2RcYMM7sNw9CvE0Rn2Co5/cQB2A4WY+JukHCBvFNmR3OTnzGARrTTmVW
   KTd3N/1FkhF96s0VlCqvmyMdQE+nLHqo/PN+aTBzn3GXGNyTrt6G0Fzkc
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10993"; a="20603906"
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="20603906"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2024 12:51:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,180,1705392000"; 
   d="scan'208";a="5907841"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 23 Feb 2024 12:51:59 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 12:51:58 -0800
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 23 Feb 2024 12:51:57 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 23 Feb 2024 12:51:57 -0800
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 23 Feb 2024 12:51:57 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Kd4lQdLsgjkO2sJ2cW6m2S9C5coWBR0mXk5kvG8ieOmLdSQcqcFumY5LJJJMUYPbm9kN16VMm67vPxklg7W9Aiq4w7iFyPBTpL2dlzSsSF47kl96vGOuwRzGZRLkCfVreV0VzNwQOZn8NrA3c1ObdAohqi5siASV+OV3DfpV3S95ebq0GF4L8iMkn1crvmC9zkIN27NWADwh9lGnLvXdwnmGoV6DBjB5fNgO5C+PXTBNM5awnCg6rWoN8Aq5SsNd3gIwlBnDkP9dZYDJY+eBetx0DDqQiHu9KR/IuH/OwtITKEJ2s00OC21GUtfOXnwF4SDSiP19ru+NaLQcTCWLrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yae5paWiA8dObe5YE+1p5h6T1onfXeIC/F46eTCMUt4=;
 b=l+L/2EdP5p8hslCVxHE+7gxJZynj7YFagcnsK3pBYPT+q7fcXTgTpuUppphsdWLnT1kyG2LoNIY9uDROPmXRN0QPWnkg9xU+EgsNIhMrzF87v9BlXR0A6VLSVvoT7YPwfpa5WWb+xf6bgFGlHe3EbQ3Ts9pBaA0Ke6KZP9X9EnFFJx8KbMT90hrWv1psInPQAGvPMuyoFpN++OH/OuO3MgpKRJJkQd0WoRGyJK0+Joe9pr1WbTweotJJD7RUeFbBZjukjfzzj9+4w/cwTZgvvghXfzt4ZVq5tI+g2C2j2ijs505pP6mBUHTIB+cbypo5H/tyLfR/9hFCjpbqpmE2Vg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by PH0PR11MB4888.namprd11.prod.outlook.com (2603:10b6:510:32::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.10; Fri, 23 Feb
 2024 20:51:55 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::4c76:f31a:2174:d509%5]) with mapi id 15.20.7339.009; Fri, 23 Feb 2024
 20:51:55 +0000
Message-ID: <de03710a-8409-49c6-bc62-c49e8291cb73@intel.com>
Date: Fri, 23 Feb 2024 12:51:51 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC net-next 1/3] netdev: add per-queue statistics
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <netdev@vger.kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <danielj@nvidia.com>, <mst@redhat.com>,
	<michael.chan@broadcom.com>
References: <20240222223629.158254-1-kuba@kernel.org>
 <20240222223629.158254-2-kuba@kernel.org>
 <e6699bcd-e550-4282-85b4-ecf030ccdc2e@intel.com>
 <20240222174407.5949cf90@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20240222174407.5949cf90@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0228.namprd03.prod.outlook.com
 (2603:10b6:303:b9::23) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|PH0PR11MB4888:EE_
X-MS-Office365-Filtering-Correlation-Id: e7a1efd7-e197-440f-eb91-08dc34b144dd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wabXXtpj/O+6NoRDHFFZpIGf44xpLM6ruCLGWUDVzsAPN5N15QE/V8wEWYPDCIN9jPHmkJytwPwR0Z4bCqdLEp5s/Pc+LMcgSfMq5KQH530Loyj0Uth8pzzn6e4nH2ghjNotlAWvVo0xT29ZWlJYiaXm4pP1hy3jNN472kFdFEZLT8lclFzeUMzC/MwUlmuHaMF1wtMjDHUWNXRuLgWfU8Zkm0HNLLUwMwbpHCY6GW9pEsLUHT2Nx10cWNzq0677eUjC7WX55Ywmz4L9o1Gj6k5CGb5vVZ2dO28icSJUqpiSE4eluTmfEKQNBZA+uVdOfEVkXLeDPWmlPZXl7L5lHXJtOXs5LWLWbCZrgI726RnLvrkAoo+QeoqjW9zeI0cOlWYk6DJT0NfCC9QJxSSUJlx1sSfoyU2vtEC0TYLWx1uRnhhRghfovpHXwIM2p8Mqg1yr7WfRPuJ4d1v7nWk3qG6a3DhwfddDHclfRC0spe/GiJgoowq/aHvyXXDFVzOhCV3PS+pghxITdqC+PgUiX0xMSmsSRMr8LRtgxV3gY0A=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDdUWkVsT0xZRWZYZE5HNzdOMEVCRUFMVWhOK1A4Q096M2Nsb05qTGo0blZC?=
 =?utf-8?B?emFRckkzWmxIejFKUnFmOU42bmtvK29oYjVoalRLWkN1WHdKYTdKRVNzTkxB?=
 =?utf-8?B?QUpjSzRwY1B3SHV5RWZrQWxSR0l2UzVpa2tlb3doSGNPTnRxK21nbTduekky?=
 =?utf-8?B?UzdXUTJXdlpVZHdVY3I4N0d5Z1FaR0lCTTB0c3YyYzBGT3NEZUJvcGg3YUtG?=
 =?utf-8?B?WHcySHVkQVEwSXdjcHRLQlVYU1YvR3VsbDBsc3Z6MHJ2T1hYZWZ5MUl0VEhG?=
 =?utf-8?B?U3hhR1ROZWkwMjUrdXJ5TUViRHAxVUNtSXRJNTJkOVJzZWUzdVV6VXc2aTd2?=
 =?utf-8?B?SDlJSkh6cW8wT2RrRVVZN2hub2liTjVMSDZYZmJWZGdpWHp2cnRzSWdwbjFj?=
 =?utf-8?B?K2tLRnltQ2I5STdWL3VLSEVYM0ZBb09OZjUySmVQVEs1QUhkVWNQTG9wT0pS?=
 =?utf-8?B?RlI5VlJsNC83bEdzbm4rcndSRjJPVGJ1enhMUlBwUENDQ2s4RE9CZGlmYWF5?=
 =?utf-8?B?V1I0eEVPUDVBdld0RjdEWDcwaHNZNmZrNnE4OVlqb1Z1MlF2cFZoVkU0VEUz?=
 =?utf-8?B?dS9QQ0ZpUHhJNzVtd0FCcUFjelJvMTAzWXE1ZHRWY3ZVVzRMRHFtd2NCcHdE?=
 =?utf-8?B?c1NrT0RNWDREL2w0T0NBWGl0U1dQWjNzZ3kxN1JLNkZSc0FhSG90bEpsSFhT?=
 =?utf-8?B?YlVRRmJZTVBPRkVwRFUzY05jbExTNU9WM1VDaVl6RkRhQ2hMUXBxQUl6OXlG?=
 =?utf-8?B?b051YUF2b2tjOTZ1akMxMzBmSm5ySlBkM0M2QVpzMllLQzZjQmk0aWlaRkx1?=
 =?utf-8?B?Vnp5M3pxTXlPN1NDZnZ3aWVjd2k3YkpKclNlQUpsdzllODBWWUR4QXdwZEpn?=
 =?utf-8?B?NmZqWm1EOUlDMWdLdndYZG9rLzVXaFFrM2oyVHVWdVNOWHhSRjgwaDdlSHV6?=
 =?utf-8?B?d1NycnBGbmpmUjByQWRMUFF4WExHNFpXVTNybCtTRzBnSFdFbTMwVkw5NHAw?=
 =?utf-8?B?U1VBbEdVQUlkeUwyWVAzb1FVM1lhRURxQmVxaWdxYTczS1JCWnNFQm9vNVZj?=
 =?utf-8?B?TU9ZbVc1QXI1YUdQY09rd0hLQnpicXZhTWt6ZzZuY2czQjR5YlZPS09wUWpq?=
 =?utf-8?B?Y0J5cFliTjlYZ1RwdENPNmJPWlE4d05OQXAwZEN3MFo3WDlVa3p4M1c2dVRZ?=
 =?utf-8?B?K1hQQTdaNTNFQkV2TE5uTmEzb0RFa3R6K2FvT3dwRVpIWHBYYzhMTXUrQVpJ?=
 =?utf-8?B?STQwcTdyKzBCZ2JuMDNpUkdwdElabTRvRDZBQWZMMDdjTEJzc2dvUFVuZld3?=
 =?utf-8?B?aXhsM1ZMbEhkb2RkVU11QkFBNEw3TlBWL3VjT05TbDJSN2FZTFkwSW1kWGNQ?=
 =?utf-8?B?YWJuR3F5WFl5azRZdDY1WE1UNFdNT1dvZHRkVUZnNHo2eWJKT3pIL1VXUGlw?=
 =?utf-8?B?L2Z6QWh1ak9SVytHMGdGOHZuZGtQQ2svZ3A3WEFReERDN3kvRnI3bUFqbFRZ?=
 =?utf-8?B?azlFRTJieGMyYmxjWHhSUGRxNFRIZVk4REhzQXlWSExhaXV4L0Zlci83a016?=
 =?utf-8?B?cnhlVkhxV0NhNk9hZFhBTS8vT2YwaHNJT3FlczVzNzNXQWZVV0hKYkZLWGdR?=
 =?utf-8?B?bmtlalBpUnBRYnlna2Z5Q2NIUXZKYTltdkFhc2Rlb1JDUHhybkFud3ViOXY1?=
 =?utf-8?B?dXRDQmlyWTFFUWJQNzU1TGtydkxSaS9ESlZlUUl6RG9zTGtWaUZvYXRlRHpn?=
 =?utf-8?B?cTBrMmdwcDZ3bmIxdDk0NjNmc2JNSWtQVUJ3MWVFTTFZT0laM0ZIZ0Q1azA3?=
 =?utf-8?B?L05FSEJCKytNNkx2R1R2Z3BjcWRFYzc3dzJaMXcvbW5nQjFwRHE0WGhPd2wy?=
 =?utf-8?B?N1ZvVkU3emNEaUZDNDRCWkxPQUZHWFlqNG5Pb0F3RC9qVDRsaUVXMUVrdWpy?=
 =?utf-8?B?cUQ2anZFZDFXbU94SDFyOXFVcHRZdTd3aURKNS9SK29VbUwwU0c5cC9IWUk4?=
 =?utf-8?B?c0hsN0Q5YnlqT2tpZ1NSUkw3ZWpwS20vZHBXVHlLVFBJN0FKMVN4d1FhR1BG?=
 =?utf-8?B?a2xiVjBPbDkvalI1UDlqcGtNVERlYlpQVWtTRE5Wem1BeVdMRWFRTzVtTWE4?=
 =?utf-8?B?WndBYnd2NHo2N0hoYURvcktSenYvVTRqSXlEWDFUZXVpV0t3anoyT3FOQ2N6?=
 =?utf-8?B?bXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e7a1efd7-e197-440f-eb91-08dc34b144dd
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2024 20:51:55.0797
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qBGxuf6NyTWAS+Qh5yC/Sw5ZuefV0FP8fr5/7qCLfz5ue+mvtxtPLxUKaSbI868WJZxhNRpvAv01j4wVBc4hMKIhKmFKIIxi6GWFsemUeKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4888
X-OriginatorOrg: intel.com

On 2/22/2024 5:44 PM, Jakub Kicinski wrote:
> On Thu, 22 Feb 2024 16:29:08 -0800 Nambiar, Amritha wrote:
>> Thanks, this almost has all the bits to also lookup stats for a single
>> queue with --do stats-get with a queue id and type.
> 
> We could without the projection. The projection (BTW not a great name,
> couldn't come up with a better one.. split? dis-aggregation? view?
> un-grouping?) "splits" a single object (netdev stats) across components
> (queues). I was wondering if at some point we may add another
> projection, splitting a queue. And then a queue+id+projection would
> actually have to return multiple objects. So maybe it's more consistent
> to just not support do at all for this op, and only support dump?
> 

So I understand splitting a netdev object into component queues, but do 
you have anything in mind WRT to splitting a queue, what could be the 
components for a queue object?
Agree that we can avoid the 'do' support if there are multiple 
possibilities for the projection/scope/view.
"scope" or "view" LGTM.

> We can support filtered dump on ifindex + queue id + type, and expect
> it to return one object for now.
> 
Sounds good if we are doing away with the 'do' support.

> Not 100% sure so I went with the "keep it simple, we can add more later"
> approach.
> 


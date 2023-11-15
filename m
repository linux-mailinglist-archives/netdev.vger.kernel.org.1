Return-Path: <netdev+bounces-48194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 415C87ED1EA
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 21:20:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 55DA11C20432
	for <lists+netdev@lfdr.de>; Wed, 15 Nov 2023 20:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDF43DB98;
	Wed, 15 Nov 2023 20:20:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NYxqlwpX"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 431A619B
	for <netdev@vger.kernel.org>; Wed, 15 Nov 2023 12:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700079651; x=1731615651;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=M1oK4q4w3XNkhVJ7D5hEaE0EXMkJZDTDr+xC6yrFqbU=;
  b=NYxqlwpXK622vTBR/EPWj2rP7KUtbNhH0YSl+Sc7UGNUQMHpnRz9eAhf
   3unB11bTXNKW7LKbF417qQGKDCgy5jPTk58UeyqSfl+8TTtBwpt1yAO9T
   O0nHoM/7l7zJTffEpvCqN0LnFP2yY0ZgShqYb2ma3psO7eN7DGsTTWh53
   Q6hVfTJc2pAeUNjHwkKlP8SoctJSKmaLSkLLj0WX1vPGg+5drwRdQbkHf
   lJbHVES6dHjXDy5mbQjoW23O/VU5w/0QgsOoREqRpdNXYr4X1DbUWD1kF
   kzB5qNsTyA4vjOVOpTkUXO/1PkgZsbmh9aiWJR3B3XnV0l4ML8Iza0lRe
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="375988945"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="375988945"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 12:20:48 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="938597957"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="938597957"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 12:20:48 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 12:20:47 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 12:20:47 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 12:20:47 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 12:20:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fS2efHLcP2Y0tI68A3xTPrgNUl8RzaZQFcG/dOjvuhPaLbECXyigsEVFGYSPun5mT1m6zKMdAoyscG3rJMSbmpDJfqVXr6VWjVsfjEjWmuYsK3BwmjMUk8dddLaAvFMGPGZrsZB0CTM69KkoEu2rHU9J0eMPBlyt88TaW/pgqSj/0voaxeTAH1MQAsNGXcEJjCAWUzycFq67UbGWz9nWpGEhouQuhKdXlwx29pqR8bwVD8im1qPbkeoI1Zixxdk7kA8J+1nvOa7v33rBuitQMCaY5dDy3xk1IjAh0LV1jpd4CxsWS1zE5CT7r/I9eld5JAQC1HyGEpltsU36x4Gs1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hTaeg8TdfgzrBQt63KHTUWTlHM6XaR0oiP+SK4PCGKI=;
 b=Nz2lpGMn247rnHdaHzs4KZX70mAOoOQw+UkHOsWplQ3oenTMW+VyYER43Kyk/YaC8aBxLsByrab3hka9A3OhuH0tXoGoWINo6DRn2AzYiZSLMOKlk8MgmMaGF8b6/Dsvn7fJet3SJE/pC+KSZIZ+C2W+EEC8me2glOZjQNCsRiNXBlrzOT652GTSMHqqycK5+tzHwX550Omx2CKDTitX2muxyQxxyi1KF/wuE9bjQdsVUiZexVMj1Tm+lbyC/09N+V6INY0bL0fi2aA7yTzEhpKZ/rDcjmxydrUWngU61ig4uV6o1/gvoCDvTvw92D9w+UaxgKFZHrqbmz9EBdQA8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by LV2PR11MB6046.namprd11.prod.outlook.com (2603:10b6:408:17a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.31; Wed, 15 Nov
 2023 20:20:37 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::dbee:4787:6eeb:57f5%4]) with mapi id 15.20.7002.018; Wed, 15 Nov 2023
 20:20:37 +0000
Message-ID: <c7651635-d823-4a4e-be46-9d20c87b3eeb@intel.com>
Date: Wed, 15 Nov 2023 12:20:33 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [patch net-next 6/8] genetlink: introduce helpers to do filtered
 multicast
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Jiri Pirko
	<jiri@resnulli.us>
CC: <netdev@vger.kernel.org>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <jhs@mojatatu.com>,
	<johannes@sipsolutions.net>, <amritha.nambiar@intel.com>, <sdf@google.com>
References: <20231115141724.411507-1-jiri@resnulli.us>
 <20231115141724.411507-7-jiri@resnulli.us>
 <ZVTbccC0VhT4CetU@smile.fi.intel.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <ZVTbccC0VhT4CetU@smile.fi.intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR05CA0028.namprd05.prod.outlook.com
 (2603:10b6:a03:33b::33) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|LV2PR11MB6046:EE_
X-MS-Office365-Filtering-Correlation-Id: 82b93ea8-5475-4bb9-e8c9-08dbe618547c
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OKFg8C91FA0GjL9UfowPffdrHDEi7ZltHjBwTPMdbkXbfseBJLNO2Yik9WY+Lph8A3CKFGnjD3VDraadLLJBmBbu1+14oz8b/OJRmamABGqlXMlK3qpHDP6Rbi04DuLgIZ7keuhnQadRtLHP/E2lTtZF7OOStX9+TXb4ZyfB/MxYbPSsLG4PEZnQl3vAVrmeSB4dYKA8Wi4012Yg97cot+mKxnGOx53VwWij4wQk7B8eCuhVB0VXu1TAdKh6EOIJzampPVcpU246AUnJUP0A2wsUrZEYyNscsfLBUp8Af8gM+v5HHTjNgfap8eBFZVKkZkQwymWxL+3R68jl6h8IdzOapjOdLJKN13nChlC0VByNjk7ZxjYk7g4/h09k9rYC/77ooVTfDltpsuX+5qrHZ4w8fpStiED/UrXjURi3khf7hYObSfWeeiP0uyDydVkKiP+b4ggG+jtilTNFhEBnt210+rYUCEAyqN1IJBtFrCum7LApaNQ4HBJghhHw5HUoILFudFtsTHEmLQTYi2oxQooindeKLd2KrUscfdc+FRvoVYbDk/jdo3C2r1AndHQdO4/WK37puhSunPI0Br3dOEIg7NxxvxA68n0yGG4T3kPbF1r7lNNJw361tWEStJEBTcMuL46KYAzMs8yUJD1UpQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(136003)(346002)(376002)(366004)(396003)(230922051799003)(451199024)(1800799009)(186009)(64100799003)(41300700001)(2906002)(4744005)(7416002)(31696002)(5660300002)(86362001)(31686004)(4326008)(8936002)(8676002)(110136005)(36756003)(316002)(66556008)(66946007)(478600001)(6486002)(66476007)(6666004)(26005)(38100700002)(82960400001)(6506007)(53546011)(2616005)(6512007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?M3oxREtET0k4b2pxbExvVjhHTlFYYW1yYUUrb3pnclo2dFM5S0Z3NmVLNGZH?=
 =?utf-8?B?ejhPUUZYamF5ZlFnRjdVWUlUZHJ2M1pvdW5ZbEpBeWtFYWc2aWV1dDArK2VL?=
 =?utf-8?B?RXF2dmRZWTZxQWFpQXhhWGJ2RnVjUitWUHpKR1huUVROdFlTdGJlZ0J3Yklj?=
 =?utf-8?B?Z01qNWlXbVZObklSZS81VVpERU1WTEJWeUtOclU0Yk0wRDhiYlY1M3h6WE9R?=
 =?utf-8?B?ZENIcU91REdWYnhERC8wMk01WlFSUnduYStGa1gzYURNWGx1T0NwNEhyVXV1?=
 =?utf-8?B?R3k1L2pJc1g1MjdsTmN1Zks5YlJEdkh1c2l3eDBESHRWYnBVT296bk05Um9D?=
 =?utf-8?B?cEVwMUdzZ2V5R1Q2eWd4SXJrcjQ1bjk2R0M4bFc5bkZ2NVhmTFRtZEFHcVQz?=
 =?utf-8?B?UGt0NUxOZ1ZwMGMyWTRzTmhob2JUTkROQm5hOVJEeVFGaERUNTJnZ3pXSEN5?=
 =?utf-8?B?MzlDRjJDRkZwUmJhS2RnZkp5dUgwTVowcHBJUm0rZ29WSHh0MVJQLzdGWE9F?=
 =?utf-8?B?TFB4b2R4TEZWYW43Rkx1UmFKek5lc2h4TW44d0p4VG8yUDl1dFhlcEIwN2dN?=
 =?utf-8?B?RGJocGNXSlZNbHNWZzJ1RWs0UGdpZEhNK3hBaEJwckZjanc2L1N4TmduQ3d1?=
 =?utf-8?B?WTVtams2SmRvV09adTRFMGxTSTVYaDJRRWpmTEZJUE4yTHpoTkVaR2wzTlhw?=
 =?utf-8?B?eXB2RWhqNytmeXFaT3p1SW1ZVEtaT1YxNUJvK1lWWmd3MDkyNk5PbU9xckF3?=
 =?utf-8?B?NGs2a2M2WVJHWXpEZllsWERCMGptZm42YVlQYm5NdTZZVU5VbVhoc2JVZjJI?=
 =?utf-8?B?VnRqTGJXdEJvR2pHT2pGclVCZ3RvUk5XMzR3QlBlSm5BUVJRVDVMb0tNS3Jx?=
 =?utf-8?B?dVNrM2dLbGdSeS8xcVR5emxsdWc3RjkzNTlJTldqaElCbUhLd0FFaXF5elBs?=
 =?utf-8?B?UGcyd2tLL2g1QUQ5dUVUVHh2TDNLNWFqRTJkT2x1ZFBvNmVtS1A1THZCKzBI?=
 =?utf-8?B?YXdiOWdxQkpEdWNjZlAyQ3BPd1hlb0Jqc2lrbG5GcGNXczZhTnIxd2M1RUxT?=
 =?utf-8?B?b3pFZUU5SE9sMXdRU0ZyTXlrV2g3K1NmUWswRDNpRmpyWGtlSFNHSnc3dGdE?=
 =?utf-8?B?NHEwQmpiNjY0SzFIVkpLUVdndHd1aW92RXFldm5tVTY2eWRyM09IaTgxWjUr?=
 =?utf-8?B?a2tFaVJ1OU9jZi9DanREcEc3dVdZVWN3Q3ZHLytUWmRXMHFOYzBJRG4xTVhI?=
 =?utf-8?B?MjIrVS9scHdNU0NnclE5SGhQSkc2MlJaeEdPWVBSSFZDRHZINzJyZjIwMUZx?=
 =?utf-8?B?cG81Njh5TnhpVklabzZ3dEFSelBiSEN0WW9IYXcrUEdzcEFneStHZVY2MVZF?=
 =?utf-8?B?TTVJRWlMWDRCSmowc0ZvOUdOUXQ0Y3YxUFRTazlHN1FtaEs3TWpwakdLTDdS?=
 =?utf-8?B?L1hFOVlIMld4QllqV1dXRmRKNTJBYUNFZXdxQm94MTJiYmFpc3lubDRVOUxI?=
 =?utf-8?B?SlFKZW5nT1NrTUFXUGdKQ0lMbGlXQy9aMnlWZkhhZDFFNDB1b2lPZVVvYzFN?=
 =?utf-8?B?NUhnNlB0S0s2dFlVRGxqWVVKTjVzNExsdzVmam1wRVIyN3Fmc1ZFK1Rhdkhy?=
 =?utf-8?B?MWhaK1QwQ0twbnhDSW1VbGc2TW9qWU1tVWlTaEo2OHh3aE5JQWordFlkWkhu?=
 =?utf-8?B?NGExTWFZSGV2VUVKY2hDbCtlK2t3VWNkZ2MrUXlUVnU0SCtjRjZqVnhhN00z?=
 =?utf-8?B?UkRJTWlUejNmcElnNmVWSGlKSDlIL1drSXJqaUpzNjZrZkxselJrZCtFb0Z3?=
 =?utf-8?B?UHFMc3dlTFNXNEhDaEJGN3hPUC8zYkg1dDVDWTFMQTZiUFptMEVXakZKRTg3?=
 =?utf-8?B?dFY2b2FjRmsxWXR4akxvUjNxaU5nMDh1SnIwc1RxclhqclRFQ1J2Qm9mL2or?=
 =?utf-8?B?TWZ1S29wckxUSEdYNWVtRjRlZm1tS0FhQkVWU2RyOWxnaUxFUXVqSjU0dkVS?=
 =?utf-8?B?VlJmNXRwL21FRXpscWNWZUhIU01ycCt4Q0hNdlhFcm1sS3VuUnNJQ1loVkM0?=
 =?utf-8?B?Y1ZWTWFwSVFqWitQYXdxc1k1M3c2WWtZNHUvUGw4RUMxZkgxWU5IbDhHRGht?=
 =?utf-8?B?VDdVN0NaQ3ZZSVJvUmovRzg0V2VjdURHQkNHMjJnVkx2ODlxUDQzaXdFR3di?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b93ea8-5475-4bb9-e8c9-08dbe618547c
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 20:20:37.5676
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qM/Tj4ueVgXgjcC/qUZV9Py4wcycmX3KRS5KYKaBng2UrUtYTXw0fAOGrXdIWdNDfVbRKER8TTU74hszd/wzOq/mt943NSS4CzbCRTEmpug=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6046
X-OriginatorOrg: intel.com



On 11/15/2023 6:53 AM, Andy Shevchenko wrote:
> On Wed, Nov 15, 2023 at 03:17:22PM +0100, Jiri Pirko wrote:
>> +				 int (*filter)(struct sock *dsk,
>> +					       struct sk_buff *skb,
>> +					       void *data),
> 
> Since it occurs more than once, perhaps
> 
> typedef int (*genlmsg_filter_fn)(struct sock *, struct sk_buff *, void *);
> 
> ?
> 

I agree with having a typedef here.

Thanks,
Jake


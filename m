Return-Path: <netdev+bounces-23847-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 02DEE76DDBB
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 03:56:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D759B1C21018
	for <lists+netdev@lfdr.de>; Thu,  3 Aug 2023 01:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7308D1FBC;
	Thu,  3 Aug 2023 01:56:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F8667F
	for <netdev@vger.kernel.org>; Thu,  3 Aug 2023 01:56:49 +0000 (UTC)
Received: from mgamail.intel.com (unknown [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E77F64214
	for <netdev@vger.kernel.org>; Wed,  2 Aug 2023 18:56:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691027802; x=1722563802;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=CnAfasoMCykrjO5Dy4CfNL5E3MMmW5XrocqkOwfrsjk=;
  b=PVOjeY6LkOsbPJR4jCm59Wu58vnaxoTQuGjLrUnFM2nkj+T6lmDew1NK
   4KPO3Rbq4k99NhkzLEWJVtDf2vbh4nQ20Y7mRZwXUv9l23YXaE2hOfqm7
   Z1WjIEe5LqO9ZRFVtffPXyxO8XvMSJneSumI3u90TwAnmE7lCE4KIWiB1
   YoSuzCfkUHv+qH8Lxo2F+V+vz5e2TDTWmAdL7JqZZbnPBNaNT3XrppRGw
   KnEoidmlJlk4jF89xt+bAhge0VxfuwI/I9q2kpcpt0YS+4f5d+JmIV86Q
   6dGIFdd6HwGRR4b0z9n6tfU+CBQEX6zOtjIYhA8z7DMJ03OOR1xHYFC2R
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="369751120"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="369751120"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2023 18:56:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="706375484"
X-IronPort-AV: E=Sophos;i="6.01,250,1684825200"; 
   d="scan'208";a="706375484"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga006.jf.intel.com with ESMTP; 02 Aug 2023 18:56:26 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:56:25 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 2 Aug 2023 18:56:25 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 2 Aug 2023 18:56:25 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.170)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 2 Aug 2023 18:56:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XamWU9C5rdwx+6EdEli762qmkgjh0EiOFc1gX/Y3Cb97a3KmFe4fD8NapZSohQDUJC1pA8NOdC4V/kqHB1XF8+5Y5iof2FCB8ifjql1QU9ZOp7w0ICfSN1jZggXZmTigwFiLhDTtrB3PUT0em4ic8aE/okwW4kbPXShUFgvA+QPoR67hIf2cve5S7uUUSRrYd3Te0cydwpByjo3RSjWW/h4R2/FYiaIZhwBiOkLuikCzOZL3G58FU7J4jcdyKCgzd88hwOxygA7sX8z6rh/6LSuY8TUHCRuACoyALqs3mFfS22d6ooXzVjWN8Vxl95d0sK8n1zmTEFDfFImdJTjcfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pvSn2Iq0u5S4qs8uauigg31pxcHcdEFhMDmc3b/aV9s=;
 b=HFm+38lLqYMd6U/OWHGhTOYGXRraLDUPL52OgR79Ep7diygu/NsOMvqbdejeaeyW2dQ3aGMUi1LULVZt/oQk3kknTBP44gy5kuKgSZ/jp2PtTxePQjmo04Tyarufl6BrA0V43QQj1a0piZ/E3UdNiU46A/NNMHQ/jDQbdcilNI5Pw5kvIUZC1ECHurbpUVOUaRwme3mxnZ6etXlkfsdwnFewN0hrPYSfqnzPO7JCRLXUTzwobGbCCQqZEOmgfBD3+3IjKyu243lj2gTqLTjwKca4e8xY6dKzYYRyiE+1QMAUug3UeT/jl0tMnXGVLT05a0H6TbP1PueUM7yorWtspA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by SJ0PR11MB5136.namprd11.prod.outlook.com (2603:10b6:a03:2d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.19; Thu, 3 Aug
 2023 01:56:22 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda%3]) with mapi id 15.20.6631.046; Thu, 3 Aug 2023
 01:56:22 +0000
Message-ID: <55d763ec-fbaa-79dc-192e-c4c696a8a7de@intel.com>
Date: Wed, 2 Aug 2023 18:56:20 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH net-next 1/4] gve: Control path for DQO-QPL
Content-Language: en-US
To: Rushil Gupta <rushilg@google.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <willemb@google.com>,
	<edumazet@google.com>, <pabeni@redhat.com>
CC: Praveen Kaligineedi <pkaligineedi@google.com>, Bailey Forrest
	<bcf@google.com>
References: <20230802213338.2391025-1-rushilg@google.com>
 <20230802213338.2391025-2-rushilg@google.com>
From: Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20230802213338.2391025-2-rushilg@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P223CA0002.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::7) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|SJ0PR11MB5136:EE_
X-MS-Office365-Filtering-Correlation-Id: 8c4ba23a-ca5e-4184-0521-08db93c4d67e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 76JvTc4rQ3usIHhIUkosu9EejBj6St5+48pQRoZsydEVuEdPfhmHF69Nm4aBhVfKCKTru2HetY/8kIJ3Ty7CILgNkRwiMIvb53/s7ZJgyWLjnygFrVbs3VChMPYyRlg1rggySyGcUF9tm4Tzfd+ll6ayXxq9fxJltoe0TMfns1/hSeVg6tdFbqo09onhSl0L7f+LyLBv+EReAnGVaQ4dd9cSGfNTnWErcfnlqw578+Na1l3JBjvYKCC0bL2AkieaU96qa8KxiRrg4rk5b/rQoQN7uRnpokCtHTTBS/Ag+ZdqpZzRO46m/6K3ZlGQkfYCf+hg7QFffl3y9Tmf9VMCXXqvgMuFzLtn0KssCxzwz9RAuR75XZQqZfFRSjYLJm4lH+kSG+DfZmVlI+gCyDaeENqDfurKQ+nN47a2ts2T4S+p/sCb3+1BroCLQXnHZcwRp9sqOsKQVLPdPsgnQ9Zt42IefhS5xD2cJoby4MYlpMB60mHjyWQDRAPGUf2hEBeDkOK9kHQJU+modi4CcTZkwSZUY6H+VY6yAR/EtXJ4kJxYwbypD/BDELGTV7uVKZcEAGuTVnhB+e1D/l4YbkFE4xK6U3VcbzByvvfV8/R3Uvi/gKdZ0li6JEQs7aq5iuwQTdaD9aIcUpNPKuVqdafQjw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(136003)(39860400002)(346002)(376002)(396003)(451199021)(44832011)(4326008)(66556008)(66476007)(66946007)(38100700002)(2616005)(186003)(82960400001)(53546011)(2906002)(6506007)(26005)(83380400001)(54906003)(31696002)(478600001)(86362001)(36756003)(6512007)(6486002)(30864003)(41300700001)(8676002)(8936002)(5660300002)(31686004)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eWZkNTUxMHM1WHltOTBwQ3RCNVNXUDIzSGZlZHdnOGk0d3RsSDNiK1RaNXly?=
 =?utf-8?B?cmQxQW1vNGVPdDBFSlFqV2wrQUQvOUk3dUFPTkExRUhjVkN6Q3NBb3RKZzVz?=
 =?utf-8?B?UXZvRm5vRXpRVE1IMnUrSVdpWFg4dDh3RStsMk1aK0JtdkFtcmUza2t6c0xl?=
 =?utf-8?B?L0dybHZ1R2NTYmE4WUtJRm5QdkNrQzlxOE1hZ1ZTRkh2d2tSdjhUV1dqaENF?=
 =?utf-8?B?YlVJQkwzTFdnTDV4bEI1alA5NzZPZFB1b2NTc0JrVlhNN3RzOVVtMWtINDc2?=
 =?utf-8?B?YU9YQmNNVTVJRDNHNnpDbkMzd1M1L3BDVXRkY2NLVkY5Vm5aekIvTTYrOHdl?=
 =?utf-8?B?Zng0R2h5VzdvUm5hM2FLcjJCcEpDN2pNRVczbFRoVVFGYUxkdlV1a2c5aEJL?=
 =?utf-8?B?MDA1cDRtUUZlNzVudG5sUDZsaDArTjUzUWVvSmo3cHBmRTlpcmNkanFDbnJy?=
 =?utf-8?B?anJMU21GU0R4NlIzZ29WeGUrR0dtWjd3QUJxRmZFR0Z0Ulg3WjI2bjJvN1h1?=
 =?utf-8?B?Q3BHeVNOdGV3cVRQUEZ2Y0U2MUhHbVRYbnRNRHU4YjNTdUI3L2xyY3ZNTlI2?=
 =?utf-8?B?dTRJRElKQkxrMGNpWCtFM3hQTjlxUHZHbm1XaldWREVQeE1admIxVXBKNVFz?=
 =?utf-8?B?eVhaZDViRTRWSUtTaGF5WWhxMGdNdG9LeDlvK1g4a3hQS2V0T2twVXRkLzFt?=
 =?utf-8?B?TkRLcVFMS0llajNGbHlhVDdDeG00MjJld0Nlb1hvdWFuN2dackhJOHpGRnkw?=
 =?utf-8?B?RlJEcXlFRHZSVmpzNGpRL2JoOURtSXhQZG8reW9zZG5lMTZDb2gveWJoZGpn?=
 =?utf-8?B?K3JOdjJxUVBxaU12bUpLL2RReEg4ajAyUC9Ud3N6Q1EwTFpDdStuNVh5MFpq?=
 =?utf-8?B?c1llTFYzMm91Vmc2NC9NSkZISkxDQnkrTWtXbnVEZmFralNxNyt2UkJ1LzlU?=
 =?utf-8?B?enBHY04vYnM3MlIyKzVwSXZ6bFNSVGMxNEVaV1IzNUNZOU1UOHFEVHUzZXdr?=
 =?utf-8?B?UnFlNERwdTgvODN5UWR5ZFVwc00yQ0pSSVlnTy9SWjVDOVJlM3FBUkVsQ1g3?=
 =?utf-8?B?d0NUZUtLSS9FWHhBZ2NJMUtSVXVQYll4cGtuNERRRk40T0d6UkhMbkdDaVdB?=
 =?utf-8?B?V2x3REpLODhMWnRZL2Q4WDRLVVNqK1Z0MzduTW1scG9abjVNd05tMk9LL1VQ?=
 =?utf-8?B?bWhkZTZsOUFyUEZLd1kwQ3dQMnpoV2E1elRHbGlLSWkrbHRWMGZiODc1SDY0?=
 =?utf-8?B?UXk3TnpITm9OVmkvbnkzMzAyckdIMlR0U24xaTJxTytRMHMvMkYzT3V4eTRQ?=
 =?utf-8?B?THoxTGRwWkluUFNyU3IrSWJPSmxJNFI0bVduTUlYcENUZ1dKemZpOTFvUmtZ?=
 =?utf-8?B?UFRIN0lRYnpXMXR6bGFCYTRaYTYza2V6aGUvMVZOTjRrYUZibUdGNG5oSHdm?=
 =?utf-8?B?S1A1WXhLeGtJVjlOMG5Ha3pXcXJHbU5UMEhXNmJBc0RWb0lvcEoyQjZteFJG?=
 =?utf-8?B?ZHU0YkQ1N1NMN25PcC9wWUhndURJbkQwTHA2dWlUazIzeUZUa1hhRHlhd21w?=
 =?utf-8?B?bjdwN1pLNTRaZXJFcUJTQ0ZYM0NibDIvdXVvYlE0TldFMVhTMElkSFpkaTlH?=
 =?utf-8?B?RjZ4ZU1ZekhaZC9nZXdzeFVNZFdtS0hjTmRsdDR2NFVKWnNnS25QNXdQY3pM?=
 =?utf-8?B?TXk5SXV6WHhrN2hkOC83K1hCbk50NTlheWhKaGJZT0UrVXZ0Y3lVNWVlZ2JK?=
 =?utf-8?B?c0tqczhXSVVpNGRXM1RmNjhUT0ZCRUhSZGJoM1RCYUxnSG52dlFoUGh0VjBi?=
 =?utf-8?B?OHJQNUdHMDUzOXliNEh3SHVvM1BDZzEwdnAzYVptaXpvOUV0S0NHcUxwT0Y2?=
 =?utf-8?B?UWg1dDRubU9MMHZmaEVYL2ZZSDRpdnM5cEpLYXJBbGRrZExNWWRWUmxkL3JC?=
 =?utf-8?B?U3lCdXJmT0ZweGlQSXc0WjBwYVhMMzE3M2F5YkNwaDNOajNVTlo0bmtlUlll?=
 =?utf-8?B?WWtjVGdPVjRZZ2I4bTBGcHdIM3E5TElIUFN1ckZrNmxjVHdTT05DWkdSLzBj?=
 =?utf-8?B?c0MzWm0zQTMvVXN0UkpBK252elAyQzJlMkJqZWE4aGFibklTM0YyMVF0RE91?=
 =?utf-8?B?VHNqSDNFSEtuQTMxU094MWdDWGdJdnBwWWV4SWYrakdVb3J6QW12Q3dVSFhz?=
 =?utf-8?B?bmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8c4ba23a-ca5e-4184-0521-08db93c4d67e
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2023 01:56:22.6099
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /CFiqdTnUKG0Med2PzHE53PHDhyOtCvUbBPAVEgDpAca8v486iH4LhIxOmRk1t9gU5B8KA3+bIFymxkI/ZuhNoa6tyremV/nx8nj5etSc4k=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5136
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 8/2/2023 2:33 PM, Rushil Gupta wrote:
> Add checks, abi-changes and device options to support
> QPL mode for DQO in addition to GQI. Also, use
> pages-per-qpl supplied by device-option to control the
> size of the "queue-page-list".

That is some serious acronym soup there, maybe expand your acronyms upon
first use in the commit message? how are we to know what you mean?


> 
> Signed-off-by: Rushil Gupta <rushilg@google.com>
> Reviewed-by: Willem de Bruijn <willemb@google.com>
> Signed-off-by: Praveen Kaligineedi <pkaligineedi@google.com>
> Signed-off-by: Bailey Forrest <bcf@google.com>
> ---
>  drivers/net/ethernet/google/gve/gve.h        | 20 ++++-
>  drivers/net/ethernet/google/gve/gve_adminq.c | 93 +++++++++++++++++---
>  drivers/net/ethernet/google/gve/gve_adminq.h | 10 +++
>  drivers/net/ethernet/google/gve/gve_main.c   | 20 +++--
>  4 files changed, 123 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/ethernet/google/gve/gve.h b/drivers/net/ethernet/google/gve/gve.h
> index 4b425bf71ede..517a63b60cb9 100644
> --- a/drivers/net/ethernet/google/gve/gve.h
> +++ b/drivers/net/ethernet/google/gve/gve.h
> @@ -51,6 +51,12 @@
>  
>  #define GVE_GQ_TX_MIN_PKT_DESC_BYTES 182
>  
> +#define DQO_QPL_DEFAULT_TX_PAGES 512
> +#define DQO_QPL_DEFAULT_RX_PAGES 2048
> +
> +/* Maximum TSO size supported on DQO */
> +#define GVE_DQO_TX_MAX	0x3FFFF
> +
>  /* Each slot in the desc ring has a 1:1 mapping to a slot in the data ring */
>  struct gve_rx_desc_queue {
>  	struct gve_rx_desc *desc_ring; /* the descriptor ring */
> @@ -531,6 +537,7 @@ enum gve_queue_format {
>  	GVE_GQI_RDA_FORMAT		= 0x1,
>  	GVE_GQI_QPL_FORMAT		= 0x2,
>  	GVE_DQO_RDA_FORMAT		= 0x3,
> +	GVE_DQO_QPL_FORMAT		= 0x4,
>  };
>  
>  struct gve_priv {
> @@ -550,7 +557,8 @@ struct gve_priv {
>  	u16 num_event_counters;
>  	u16 tx_desc_cnt; /* num desc per ring */
>  	u16 rx_desc_cnt; /* num desc per ring */
> -	u16 tx_pages_per_qpl; /* tx buffer length */
> +	u16 tx_pages_per_qpl; /* Suggested number of pages per qpl for TX queues by NIC */
> +	u16 rx_pages_per_qpl; /* Suggested number of pages per qpl for RX queues by NIC */
>  	u16 rx_data_slot_cnt; /* rx buffer length */
>  	u64 max_registered_pages;
>  	u64 num_registered_pages; /* num pages registered with NIC */
> @@ -808,11 +816,17 @@ static inline u32 gve_rx_idx_to_ntfy(struct gve_priv *priv, u32 queue_idx)
>  	return (priv->num_ntfy_blks / 2) + queue_idx;
>  }
>  
> +static inline bool gve_is_qpl(struct gve_priv *priv)
> +{
> +	return priv->queue_format == GVE_GQI_QPL_FORMAT ||
> +		priv->queue_format == GVE_DQO_QPL_FORMAT;
> +}
> +
>  /* Returns the number of tx queue page lists
>   */
>  static inline u32 gve_num_tx_qpls(struct gve_priv *priv)
>  {
> -	if (priv->queue_format != GVE_GQI_QPL_FORMAT)
> +	if (!gve_is_qpl(priv))
>  		return 0;
>  
>  	return priv->tx_cfg.num_queues + priv->num_xdp_queues;
> @@ -832,7 +846,7 @@ static inline u32 gve_num_xdp_qpls(struct gve_priv *priv)
>   */
>  static inline u32 gve_num_rx_qpls(struct gve_priv *priv)
>  {
> -	if (priv->queue_format != GVE_GQI_QPL_FORMAT)
> +	if (!gve_is_qpl(priv))
>  		return 0;
>  
>  	return priv->rx_cfg.num_queues;
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.c b/drivers/net/ethernet/google/gve/gve_adminq.c
> index 252974202a3f..a16e7cf21911 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.c
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.c
> @@ -39,7 +39,8 @@ void gve_parse_device_option(struct gve_priv *priv,
>  			     struct gve_device_option_gqi_rda **dev_op_gqi_rda,
>  			     struct gve_device_option_gqi_qpl **dev_op_gqi_qpl,
>  			     struct gve_device_option_dqo_rda **dev_op_dqo_rda,
> -			     struct gve_device_option_jumbo_frames **dev_op_jumbo_frames)
> +			     struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
> +			     struct gve_device_option_dqo_qpl **dev_op_dqo_qpl)
>  {
>  	u32 req_feat_mask = be32_to_cpu(option->required_features_mask);
>  	u16 option_length = be16_to_cpu(option->option_length);
> @@ -112,6 +113,22 @@ void gve_parse_device_option(struct gve_priv *priv,
>  		}
>  		*dev_op_dqo_rda = (void *)(option + 1);
>  		break;
> +	case GVE_DEV_OPT_ID_DQO_QPL:
> +		if (option_length < sizeof(**dev_op_dqo_qpl) ||
> +		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL) {
> +			dev_warn(&priv->pdev->dev, GVE_DEVICE_OPTION_ERROR_FMT,
> +				 "DQO QPL", (int)sizeof(**dev_op_dqo_qpl),
> +				 GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL,
> +				 option_length, req_feat_mask);
> +			break;
> +		}
> +
> +		if (option_length > sizeof(**dev_op_dqo_qpl)) {
> +			dev_warn(&priv->pdev->dev,
> +				 GVE_DEVICE_OPTION_TOO_BIG_FMT, "DQO QPL");
> +		}
> +		*dev_op_dqo_qpl = (void *)(option + 1);
> +		break;
>  	case GVE_DEV_OPT_ID_JUMBO_FRAMES:
>  		if (option_length < sizeof(**dev_op_jumbo_frames) ||
>  		    req_feat_mask != GVE_DEV_OPT_REQ_FEAT_MASK_JUMBO_FRAMES) {
> @@ -146,7 +163,8 @@ gve_process_device_options(struct gve_priv *priv,
>  			   struct gve_device_option_gqi_rda **dev_op_gqi_rda,
>  			   struct gve_device_option_gqi_qpl **dev_op_gqi_qpl,
>  			   struct gve_device_option_dqo_rda **dev_op_dqo_rda,
> -			   struct gve_device_option_jumbo_frames **dev_op_jumbo_frames)
> +			   struct gve_device_option_jumbo_frames **dev_op_jumbo_frames,
> +			   struct gve_device_option_dqo_qpl **dev_op_dqo_qpl)
>  {
>  	const int num_options = be16_to_cpu(descriptor->num_device_options);
>  	struct gve_device_option *dev_opt;
> @@ -166,7 +184,8 @@ gve_process_device_options(struct gve_priv *priv,
>  
>  		gve_parse_device_option(priv, descriptor, dev_opt,
>  					dev_op_gqi_rda, dev_op_gqi_qpl,
> -					dev_op_dqo_rda, dev_op_jumbo_frames);
> +					dev_op_dqo_rda, dev_op_jumbo_frames,
> +					dev_op_dqo_qpl);
>  		dev_opt = next_opt;
>  	}
>  
> @@ -505,12 +524,24 @@ static int gve_adminq_create_tx_queue(struct gve_priv *priv, u32 queue_index)
>  
>  		cmd.create_tx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
>  	} else {
> +		u16 comp_ring_size = 0;
> +		u32 qpl_id = 0;

these stack initializers are useless, you unconditionally overwrite both
values below.

> +
> +		if (priv->queue_format == GVE_DQO_RDA_FORMAT) {
> +			qpl_id = GVE_RAW_ADDRESSING_QPL_ID;
> +			comp_ring_size =
> +				priv->options_dqo_rda.tx_comp_ring_entries;
> +		} else {
> +			qpl_id = tx->dqo.qpl->id;
> +			comp_ring_size = priv->tx_desc_cnt;
> +		}
> +		cmd.create_tx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
>  		cmd.create_tx_queue.tx_ring_size =
>  			cpu_to_be16(priv->tx_desc_cnt);
>  		cmd.create_tx_queue.tx_comp_ring_addr =
>  			cpu_to_be64(tx->complq_bus_dqo);
>  		cmd.create_tx_queue.tx_comp_ring_size =
> -			cpu_to_be16(priv->options_dqo_rda.tx_comp_ring_entries);
> +			cpu_to_be16(comp_ring_size);
>  	}
>  
>  	return gve_adminq_issue_cmd(priv, &cmd);
> @@ -555,6 +586,18 @@ static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
>  		cmd.create_rx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
>  		cmd.create_rx_queue.packet_buffer_size = cpu_to_be16(rx->packet_buffer_size);
>  	} else {
> +		u16 rx_buff_ring_entries = 0;
> +		u32 qpl_id = 0;

same here

> +
> +		if (priv->queue_format == GVE_DQO_RDA_FORMAT) {
> +			qpl_id = GVE_RAW_ADDRESSING_QPL_ID;
> +			rx_buff_ring_entries =
> +				priv->options_dqo_rda.rx_buff_ring_entries;
> +		} else {
> +			qpl_id = rx->dqo.qpl->id;
> +			rx_buff_ring_entries = priv->rx_desc_cnt;
> +		}
> +		cmd.create_rx_queue.queue_page_list_id = cpu_to_be32(qpl_id);
>  		cmd.create_rx_queue.rx_ring_size =
>  			cpu_to_be16(priv->rx_desc_cnt);
>  		cmd.create_rx_queue.rx_desc_ring_addr =
> @@ -564,7 +607,7 @@ static int gve_adminq_create_rx_queue(struct gve_priv *priv, u32 queue_index)
>  		cmd.create_rx_queue.packet_buffer_size =
>  			cpu_to_be16(priv->data_buffer_size_dqo);
>  		cmd.create_rx_queue.rx_buff_ring_size =
> -			cpu_to_be16(priv->options_dqo_rda.rx_buff_ring_entries);
> +			cpu_to_be16(rx_buff_ring_entries);
>  		cmd.create_rx_queue.enable_rsc =
>  			!!(priv->dev->features & NETIF_F_LRO);
>  	}
> @@ -675,9 +718,13 @@ gve_set_desc_cnt_dqo(struct gve_priv *priv,
>  		     const struct gve_device_option_dqo_rda *dev_op_dqo_rda)
>  {
>  	priv->tx_desc_cnt = be16_to_cpu(descriptor->tx_queue_entries);
> +	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
> +
> +	if (priv->queue_format == GVE_DQO_QPL_FORMAT)
> +		return 0;
> +
>  	priv->options_dqo_rda.tx_comp_ring_entries =
>  		be16_to_cpu(dev_op_dqo_rda->tx_comp_ring_entries);
> -	priv->rx_desc_cnt = be16_to_cpu(descriptor->rx_queue_entries);
>  	priv->options_dqo_rda.rx_buff_ring_entries =
>  		be16_to_cpu(dev_op_dqo_rda->rx_buff_ring_entries);
>  
> @@ -687,7 +734,9 @@ gve_set_desc_cnt_dqo(struct gve_priv *priv,
>  static void gve_enable_supported_features(struct gve_priv *priv,
>  					  u32 supported_features_mask,
>  					  const struct gve_device_option_jumbo_frames
> -						  *dev_op_jumbo_frames)
> +					  *dev_op_jumbo_frames,
> +					  const struct gve_device_option_dqo_qpl
> +					  *dev_op_dqo_qpl)
>  {
>  	/* Before control reaches this point, the page-size-capped max MTU from
>  	 * the gve_device_descriptor field has already been stored in
> @@ -699,6 +748,20 @@ static void gve_enable_supported_features(struct gve_priv *priv,
>  			 "JUMBO FRAMES device option enabled.\n");
>  		priv->dev->max_mtu = be16_to_cpu(dev_op_jumbo_frames->max_mtu);
>  	}
> +
> +	/* Override pages for qpl for DQO-QPL */
> +	if (dev_op_dqo_qpl) {
> +		dev_info(&priv->pdev->dev,
> +			 "DQO QPL device option enabled.\n");

How does this message benefit the user?

> +		priv->tx_pages_per_qpl =
> +			be16_to_cpu(dev_op_dqo_qpl->tx_pages_per_qpl);
> +		priv->rx_pages_per_qpl =
> +			be16_to_cpu(dev_op_dqo_qpl->rx_pages_per_qpl);
> +		if (priv->tx_pages_per_qpl == 0)
> +			priv->tx_pages_per_qpl = DQO_QPL_DEFAULT_TX_PAGES;
> +		if (priv->rx_pages_per_qpl == 0)
> +			priv->rx_pages_per_qpl = DQO_QPL_DEFAULT_RX_PAGES;
> +	}
>  }
>  
>  int gve_adminq_describe_device(struct gve_priv *priv)
> @@ -707,6 +770,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
>  	struct gve_device_option_gqi_rda *dev_op_gqi_rda = NULL;
>  	struct gve_device_option_gqi_qpl *dev_op_gqi_qpl = NULL;
>  	struct gve_device_option_dqo_rda *dev_op_dqo_rda = NULL;
> +	struct gve_device_option_dqo_qpl *dev_op_dqo_qpl = NULL;
>  	struct gve_device_descriptor *descriptor;
>  	u32 supported_features_mask = 0;
>  	union gve_adminq_command cmd;
> @@ -733,13 +797,14 @@ int gve_adminq_describe_device(struct gve_priv *priv)
>  
>  	err = gve_process_device_options(priv, descriptor, &dev_op_gqi_rda,
>  					 &dev_op_gqi_qpl, &dev_op_dqo_rda,
> -					 &dev_op_jumbo_frames);
> +					 &dev_op_jumbo_frames,
> +					 &dev_op_dqo_qpl);
>  	if (err)
>  		goto free_device_descriptor;
>  
>  	/* If the GQI_RAW_ADDRESSING option is not enabled and the queue format
>  	 * is not set to GqiRda, choose the queue format in a priority order:
> -	 * DqoRda, GqiRda, GqiQpl. Use GqiQpl as default.
> +	 * DqoRda, DqoQpl, GqiRda, GqiQpl. Use GqiQpl as default.
>  	 */
>  	if (dev_op_dqo_rda) {
>  		priv->queue_format = GVE_DQO_RDA_FORMAT;
> @@ -747,7 +812,13 @@ int gve_adminq_describe_device(struct gve_priv *priv)
>  			 "Driver is running with DQO RDA queue format.\n");
>  		supported_features_mask =
>  			be32_to_cpu(dev_op_dqo_rda->supported_features_mask);
> -	} else if (dev_op_gqi_rda) {
> +	} else if (dev_op_dqo_qpl) {
> +		priv->queue_format = GVE_DQO_QPL_FORMAT;
> +		dev_info(&priv->pdev->dev,
> +			 "Driver is running with DQO QPL queue format.\n");

I feel like at best these should have been dev_dbg, or at worst just
removed. Messages should always add value for the user if they're printed.

> +		supported_features_mask =
> +			be32_to_cpu(dev_op_dqo_qpl->supported_features_mask);
> +	}  else if (dev_op_gqi_rda) {
>  		priv->queue_format = GVE_GQI_RDA_FORMAT;
>  		dev_info(&priv->pdev->dev,
>  			 "Driver is running with GQI RDA queue format.\n");
> @@ -798,7 +869,7 @@ int gve_adminq_describe_device(struct gve_priv *priv)
>  	priv->default_num_queues = be16_to_cpu(descriptor->default_num_queues);
>  
>  	gve_enable_supported_features(priv, supported_features_mask,
> -				      dev_op_jumbo_frames);
> +				      dev_op_jumbo_frames, dev_op_dqo_qpl);
>  
>  free_device_descriptor:
>  	dma_free_coherent(&priv->pdev->dev, PAGE_SIZE, descriptor,
> diff --git a/drivers/net/ethernet/google/gve/gve_adminq.h b/drivers/net/ethernet/google/gve/gve_adminq.h
> index f894beb3deaf..38a22279e863 100644
> --- a/drivers/net/ethernet/google/gve/gve_adminq.h
> +++ b/drivers/net/ethernet/google/gve/gve_adminq.h
> @@ -109,6 +109,14 @@ struct gve_device_option_dqo_rda {
>  
>  static_assert(sizeof(struct gve_device_option_dqo_rda) == 8);
>  
> +struct gve_device_option_dqo_qpl {
> +	__be32 supported_features_mask;
> +	__be16 tx_pages_per_qpl;
> +	__be16 rx_pages_per_qpl;
> +};
> +
> +static_assert(sizeof(struct gve_device_option_dqo_qpl) == 8);
> +
>  struct gve_device_option_jumbo_frames {
>  	__be32 supported_features_mask;
>  	__be16 max_mtu;
> @@ -130,6 +138,7 @@ enum gve_dev_opt_id {
>  	GVE_DEV_OPT_ID_GQI_RDA = 0x2,
>  	GVE_DEV_OPT_ID_GQI_QPL = 0x3,
>  	GVE_DEV_OPT_ID_DQO_RDA = 0x4,
> +	GVE_DEV_OPT_ID_DQO_QPL = 0x7,
>  	GVE_DEV_OPT_ID_JUMBO_FRAMES = 0x8,
>  };
>  
> @@ -139,6 +148,7 @@ enum gve_dev_opt_req_feat_mask {
>  	GVE_DEV_OPT_REQ_FEAT_MASK_GQI_QPL = 0x0,
>  	GVE_DEV_OPT_REQ_FEAT_MASK_DQO_RDA = 0x0,
>  	GVE_DEV_OPT_REQ_FEAT_MASK_JUMBO_FRAMES = 0x0,
> +	GVE_DEV_OPT_REQ_FEAT_MASK_DQO_QPL = 0x0,


Maybe this makes sense to others, but an enum full of defines where all
values are zero? Why are we even writing code?

>  };
>  
>  enum gve_sup_feature_mask {
> diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
> index e6f1711d9be0..b40fafe1460a 100644
> --- a/drivers/net/ethernet/google/gve/gve_main.c
> +++ b/drivers/net/ethernet/google/gve/gve_main.c
> @@ -31,7 +31,6 @@
>  
>  // Minimum amount of time between queue kicks in msec (10 seconds)
>  #define MIN_TX_TIMEOUT_GAP (1000 * 10)
> -#define DQO_TX_MAX	0x3FFFF
>  
>  char gve_driver_name[] = "gve";
>  const char gve_version_str[] = GVE_VERSION;
> @@ -494,7 +493,7 @@ static int gve_setup_device_resources(struct gve_priv *priv)
>  		goto abort_with_stats_report;
>  	}
>  
> -	if (priv->queue_format == GVE_DQO_RDA_FORMAT) {
> +	if (!gve_is_gqi(priv)) {
>  		priv->ptype_lut_dqo = kvzalloc(sizeof(*priv->ptype_lut_dqo),
>  					       GFP_KERNEL);
>  		if (!priv->ptype_lut_dqo) {
> @@ -1085,9 +1084,10 @@ static int gve_alloc_qpls(struct gve_priv *priv)
>  	int max_queues = priv->tx_cfg.max_queues + priv->rx_cfg.max_queues;
>  	int start_id;
>  	int i, j;
> +	int page_count;

RCT please

>  	int err;
>  
> -	if (priv->queue_format != GVE_GQI_QPL_FORMAT)
> +	if (!gve_is_qpl(priv))
>  		return 0;
>  
>  	priv->qpls = kvcalloc(max_queues, sizeof(*priv->qpls), GFP_KERNEL);
> @@ -1095,17 +1095,25 @@ static int gve_alloc_qpls(struct gve_priv *priv)
>  		return -ENOMEM;
>  
>  	start_id = gve_tx_start_qpl_id(priv);
> +	page_count = priv->tx_pages_per_qpl;
>  	for (i = start_id; i < start_id + gve_num_tx_qpls(priv); i++) {
>  		err = gve_alloc_queue_page_list(priv, i,
> -						priv->tx_pages_per_qpl);
> +						page_count);
>  		if (err)
>  			goto free_qpls;
>  	}
>  
>  	start_id = gve_rx_start_qpl_id(priv);
> +
> +	/* For GQI_QPL number of pages allocated have 1:1 relationship with
> +	 * number of descriptors. For DQO, number of pages required are
> +	 * more than descriptors (because of out of order completions).
> +	 */
> +	page_count = priv->queue_format == GVE_GQI_QPL_FORMAT ?
> +		priv->rx_data_slot_cnt : priv->rx_pages_per_qpl;
>  	for (i = start_id; i < start_id + gve_num_rx_qpls(priv); i++) {
>  		err = gve_alloc_queue_page_list(priv, i,
> -						priv->rx_data_slot_cnt);
> +						page_count);
>  		if (err)
>  			goto free_qpls;
>  	}
> @@ -2051,7 +2059,7 @@ static int gve_init_priv(struct gve_priv *priv, bool skip_describe_device)
>  
>  	/* Big TCP is only supported on DQ*/
>  	if (!gve_is_gqi(priv))
> -		netif_set_tso_max_size(priv->dev, DQO_TX_MAX);
> +		netif_set_tso_max_size(priv->dev, GVE_DQO_TX_MAX);
>  
>  	priv->num_registered_pages = 0;
>  	priv->rx_copybreak = GVE_DEFAULT_RX_COPYBREAK;



Return-Path: <netdev+bounces-37117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D02787B3B10
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 22:14:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 5AFD628286D
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:14:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82ACC66DFD;
	Fri, 29 Sep 2023 20:14:37 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A4EAFBF4
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 20:14:36 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70C041B4
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 13:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696018473; x=1727554473;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=38Iklh/cr7gCaFocFdUGNEPTKt78qTDNmCGH79W20/4=;
  b=O1j3PhMYL56K3kxF36lNcc9TG9MvmmD7ETHyPhBeeZUEuAanFeW1JRhd
   mHctE3tWh6Ieh9poLSnLU7yRm/ZXqy6PdnHHPgbH4iD1GyvNlYvXlhBJF
   lc3dLc8gmNEx6MxvByyHcsRzrXZd32Lv1N3S1bC5OOplTpWNVohtYk8e2
   2XOIW4gf82ND1iUAoLgndoQgtPxcri/MrXEsYtml2aR8Ly3W61WTTBEUn
   wtFXACc+or54vlhkxy5aAXWoyPo8wt2KHLILEBsgcMZwYOvQNnzI3HmAF
   ExUEqxbLP3w1vS6ntGig/hg+41TuBuZEwohAXxXIrLjgc7y8AUrN8jmUu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="381237940"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="381237940"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 11:18:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="785167355"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="785167355"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 11:18:01 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 11:18:00 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 11:18:00 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 11:18:00 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.102)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 11:18:00 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HG81mZOpq1r5Yw2AIrdXrsqiIo7wq9vHLnhZy+9DuQxtW85lSkAeBJzoUVHE0EDNDRdLWLXivwp1Pdoj+W05jsQGlcx6LKgW+F0XRXRl02I45douLmeES+GCUnyPqSSX04V3E6M7puqF6LxfhHbrIZ/s7SYPEWSjcBS+jthJRJfEknqTKEetZmLDvdLmXeQu6Afz9nCIIy+gKymkFQI0C1LGV+RdV5W/CGw6PIKcgS+fsv+yjpTiguYd0KMkaR6uHu0gWPaBmfuR6Ivj1vDFJce547cuirGHqLQMpnzuV/84/4zREKHGG8jUzD10tFyfe3ZHabk8dEwmOqxaVJKCfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0D+9/grUj2A5X+bMoW9ACPJAofNTit9reWcsB/bLgaI=;
 b=e52RifPgdV9gKzNLd24KInrJKHUp9WLj8uTMzvZ2T/y6iadz/U3VgZr9Pd3YJPf4Id5bwbedZw/6kE+iTTftHkKO22rhGskYEPCJkCY9X34tftRMoEPu0Q6YoghuKToL8vlAONNdtj/nixxFeVOB7cb5nnzkOvGvdsGxctvHPkvh+ROP9PlvKCrWkcnTQi+sSwZA7V9bOUC/7iOORq9BrfRF0064xd225OKK6/ky+YD3qoDQ6jqPtsjQpjIwdZxzTd4YA3zMsrr9lZtuCW0MEGQWwE770LzJ05ptnLOiXHPlPIGo0k1SjiBqRTJSLoaswnuWqwKFi3O9fPMrMOxRRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB8214.namprd11.prod.outlook.com (2603:10b6:610:18e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 18:17:57 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 18:17:57 +0000
Message-ID: <781cf46c-bbcc-5223-76b8-176c7bf5836d@intel.com>
Date: Fri, 29 Sep 2023 11:17:53 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 net-next 2/7] net: ethtool: attach an XArray of custom
 RSS contexts to a netdevice
Content-Language: en-US
To: <edward.cree@amd.com>, <linux-net-drivers@amd.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>
CC: Edward Cree <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
	<habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
	<jdamato@fastly.com>, <andrew@lunn.ch>, <mw@semihalf.com>,
	<linux@armlinux.org.uk>, <sgoutham@marvell.com>, <gakula@marvell.com>,
	<sbhatta@marvell.com>, <hkelam@marvell.com>, <saeedm@nvidia.com>,
	<leon@kernel.org>
References: <cover.1695838185.git.ecree.xilinx@gmail.com>
 <4a41069859105d8c669fe26171248aad7f88d1e9.1695838185.git.ecree.xilinx@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <4a41069859105d8c669fe26171248aad7f88d1e9.1695838185.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0023.namprd21.prod.outlook.com
 (2603:10b6:302:1::36) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB8214:EE_
X-MS-Office365-Filtering-Correlation-Id: b6d818d2-4665-4dca-0163-08dbc11867f9
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: wDegEfRGcTWOJ+gy7kvmfmcagQfh1+qOz/GP5C9311ul5zql9A6sKw+MPP2D1UEyvso8LYNrstKEzYsFFqTnUrCw6OmniuMlKE4B2pDXoe1JY7Cd+Bc0MAhROKvt7emKTDbwJkom10vFvJ5KSnYX8EaET3MB+BzjixbpQyUmOyKKvVpYUMt7VwuMb78EVldS/57ysTZokI+U5XACCtVaREy6wrOHVrSseZrAQhUodjN27GicnGfOT3eCwjg7Py9HYQ3/jFWVq5/iZJJsNKWPPxp61K7kXUcdap3JQnJ9yZa4OBTL0FneT3N1wSe9xCHxOMZ9ttYUmFomDoTfFTIRE/K7xIO/1AY0TVOYB9ZaxwB0zES9gRz7N0DnnuwKZAhIPFp51u+YudjF4c+KfFL1tw+eBiV5PySSeIJyBVBp6qhm9iPWigF6PYDApKRvCjyNu0I/++zoQyP5DM4slFOPm7rpW6es8RM5ce39qab0jG9ADi9K84iyfeML/NG9H9NUhSgS6xuQgojV9i6k5IKBgiWjjMM1p8lz06Fry6LuLx+HqUfQgwZpQ35rEZor5ecu+6Ur1C/MHhwySKZXcQEKAxaV9bSvlb07LQyySojH7KNCd4HAzm9E7cHvBUmwWg7qnhOYnCIhlILPo4W1PqI57A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(136003)(366004)(346002)(376002)(39860400002)(230922051799003)(186009)(64100799003)(1800799009)(451199024)(7416002)(2906002)(5660300002)(31686004)(8936002)(4326008)(8676002)(26005)(36756003)(41300700001)(2616005)(66946007)(66556008)(66476007)(316002)(82960400001)(6506007)(6666004)(83380400001)(478600001)(6486002)(53546011)(38100700002)(31696002)(6512007)(86362001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?clNkWHlQRWxmRjBDcGhBUXY1Rm5yNnZjdTk1cnh1aTI4WTBWQTRaeEFJS3V4?=
 =?utf-8?B?RGtpNGE1bVlwcTdGd25YTXQxUHZFVnVJVW9nZzVxRS9yWHMrRkhQQklCTmVD?=
 =?utf-8?B?ZS8ycUlwSUFydm54Zk5JZjN0WjVvVmgwYi9ERXgrc3FUUmcxdVVRY2xqZTVw?=
 =?utf-8?B?cEdqZHJBeXpxKzVMeXkxQ1c0SG1aTnFOSWFXeVpLek5CdHUzZldicjRnd2Fa?=
 =?utf-8?B?NHlMY1JTN0tzdVVyUTBtL3ZOLzBnaG1XUysyMDlIRkV2VnI2NnhCOWc3dGhO?=
 =?utf-8?B?OVl4S3J3Y2dvTzhRNUJua1ZRTkVaMmRrc3hYTTlrLzRXRENhTGJlQ25sNGdx?=
 =?utf-8?B?ZzFHYVh5UXBqTnlqOEZjdEdjYzBtbHhqMlZoblYxeE5Eb3Y5YTEybU1FQjVR?=
 =?utf-8?B?eGZEbXhHYWVKMUxBSU8rZjdOYVc0dVJjeW5oZzEzMXk1SG8yMXRYSXBYVi9U?=
 =?utf-8?B?YTZLeFA2a1dzbTJ5WHlFRzJ2VjJiRXRabjFmVDFBNERNUThwbmxmL1hnRWhL?=
 =?utf-8?B?MUdIVmtrK0k4Z24xYlNRbXgxMlE2U3haSFNtbE5EUmtWTUVMREVybzN3aE1D?=
 =?utf-8?B?UzZGR2VjVjAwUGJvQW5OeEZWbDg1Q2E3OVZEdjZmWDRMQ3VHMjRZUEh2aGNZ?=
 =?utf-8?B?dFVVb2diaFVjWUYwZUc4bWpmTnlSaXRydmRKcW1tWjZnQ1VhSDVCVkFTNTVK?=
 =?utf-8?B?R2NOV3E1QlNMSytYNXkzQi9xRFByMjR0SGdtcnhlRitJbzdob2diNmxqUy9j?=
 =?utf-8?B?STQ5THEvNG4vRnlFaWxwSnBiaHFBYWZFUE90bkF0RHo0SElGa0dlT3U0Sjdt?=
 =?utf-8?B?YWg0WkVtcTdicGhPNlJjVWNQRWtkV0N2a0J0UEdhU1NVMUJtZVVNVUtkRWNh?=
 =?utf-8?B?WEF0eE9vMm95SDNtYXNBK2lDN2hlQXlHNUhabExicWpGNUdzZGFHQ28yQWVD?=
 =?utf-8?B?Q3RVeENzWHY5dFE5ZXZsbk1NZ1ZZZzYvbURPL0p0WGlJSitQUnJoZFcrVWtO?=
 =?utf-8?B?SU9nSGxERjY1Rzc3SnZOKzNVcXA0ek4rTHJ5YlNoZVVlL3I3enlsYWVSQkE1?=
 =?utf-8?B?NnhiRnZVN2lLTDlpcTNpYVFCazJqNnBqNjFkc1lPZXlPdUE4cVM5b2Zhc1hk?=
 =?utf-8?B?MHAvcUQwNWJueTFIaThjTmVmMHd4bjRrMXJJTmhPbXRFYXlnNVdJaTFVbkFx?=
 =?utf-8?B?WUgxallCelFnSU9uTWMxQm5xd0pXU0FGcm5LZ3JhZ3lVTk5yRVc2ZmRjeS9E?=
 =?utf-8?B?L2FxOTJNeSt1WFMxRjFwdHc3UkZENEJkVVNLS2hHYTBQU0tYVzJUZFFnaVdK?=
 =?utf-8?B?VVl5VVZsaHJYWTBKT1ppNC82YS9lVUZUb1FwYmVzcDhOc0cvVUV4a1c0L2Fl?=
 =?utf-8?B?dEtzSU4zdTdzclB2MFcvYi9XNE1vMjdIUC9iVHpWdTMrSWp5WFkwYWw1TGFW?=
 =?utf-8?B?VVUvN2VXa3A2YjM1VktNK1IvL1hKRDZSZ2JTMTRYa2FDb0RLQ1hKSW1QYW5G?=
 =?utf-8?B?Y2dxZ3V3b3loaDRFamZPM2NJZ1JtZVYwTlBhbG5wS1JPcjlRQTZmNitQcW9U?=
 =?utf-8?B?SUVFWVhYM2gxSHkrSjVVMnA2SlV5UU80SGdQaUMySm5FaFBmaisySmVxQ2Qy?=
 =?utf-8?B?b1I4Z0FXVTdSTElKU21TL3YxR3pyaUhjMWxKT2NQRHY5Y09oQzcwY3ZLOS92?=
 =?utf-8?B?bmMxN1pDL0k4TzFpTUVxQkYyNDk0RXQwV0JJeHY2TUh6cXNZVTMzZi9mZWow?=
 =?utf-8?B?SUdxaTFFWFdFQlBxa2RtWnVQWGhIN3g3bkhuZ0dZQVFyLzVsYnRzOS9YakY4?=
 =?utf-8?B?U2dXaXA2U3preFFBTzU4Z2pob0ZQd1pLZXUzZERYbm9VWXRMcTJJTTMrc1cv?=
 =?utf-8?B?dmNMd05jWXgzUlo3Yk5mbjZ6ZzhWNnNaSmhNZWhHQ1EyQ0pkT0FsNzdoYVNa?=
 =?utf-8?B?bzBNdEJKV3EvcFhqWUxQQ2EydEE2SXgyMzVmZnRNZVI3Skg2WXpPVXRqdEcz?=
 =?utf-8?B?bEJOUWk1RVVwcmxWYmJoOWp4RXJ2YnNKTHBHL3dDdyt6eCtudVFIam9VU3Iy?=
 =?utf-8?B?Vys1c2pCdCs1TzBBOTF4ekt2OXN0dWNBa0V4WkpGa0FhM1BzcFZvZk5xa2da?=
 =?utf-8?B?cnNqVmJiVEE2YkxEQzNIaEJ4YTRiL1hYQ296dlBJTnhjdWxPdGNCbWptWGds?=
 =?utf-8?B?Y3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b6d818d2-4665-4dca-0163-08dbc11867f9
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:17:57.2022
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dYyg+9aTCpa5C6QittGhrbJxv1zs1xC4PGWAlcT9LUg3iIHrdH7WJPx4FKzkms0d2ZRmrMiNDrhEdaOVqeT/GmspJVxuxH4OHHybfCXf7cs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB8214
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
	autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/27/2023 11:13 AM, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Each context stores the RXFH settings (indir, key, and hfunc) as well
>  as optionally some driver private data.
> Delete any still-existing contexts at netdev unregister time.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---
>  include/linux/ethtool.h | 43 ++++++++++++++++++++++++++++++++++++++++-
>  net/core/dev.c          | 25 ++++++++++++++++++++++++
>  2 files changed, 67 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 8aeefc0b4e10..bb11cb2f477d 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -157,6 +157,43 @@ static inline u32 ethtool_rxfh_indir_default(u32 index, u32 n_rx_rings)
>  	return index % n_rx_rings;
>  }
>  
> +/**
> + * struct ethtool_rxfh_context - a custom RSS context configuration
> + * @indir_size: Number of u32 entries in indirection table
> + * @key_size: Size of hash key, in bytes
> + * @hfunc: RSS hash function identifier.  One of the %ETH_RSS_HASH_*
> + * @priv_size: Size of driver private data, in bytes
> + * @indir_no_change: indir was not specified at create time
> + * @key_no_change: hkey was not specified at create time
> + */
> +struct ethtool_rxfh_context {
> +	u32 indir_size;
> +	u32 key_size;
> +	u8 hfunc;
> +	u16 priv_size;
> +	u8 indir_no_change:1;
> +	u8 key_no_change:1;
> +	/* private: driver private data, indirection table, and hash key are
> +	 * stored sequentially in @data area.  Use below helpers to access.
> +	 */
> +	u8 data[] __aligned(sizeof(void *));
> +};

Is it not feasible to use container_of to get to private data for the
drivers? I guess this change in particular doesn't actually include any
users yet...


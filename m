Return-Path: <netdev+bounces-37122-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A2B97B3B2A
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 22:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 0B3ED282FED
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B66376726A;
	Fri, 29 Sep 2023 20:18:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BBD66DF5
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 20:18:38 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A5CB4
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 13:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696018716; x=1727554716;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=27WPnhJspo7wBlh1NlI1ekS6YybOTJQXcXmJmxy5sUA=;
  b=az2Q6275lL49DXK5C4TRbf2SbMed9Er8inPf6HNnpTMrtBwvgPcDEQoy
   VFKqDRYi7YAsCP+iJb0/HJEtefOvzBbFb2Tr53ArAigXmCVw1VWpA3CXL
   qojIuI89ckM3AS6IpIMXUoQ0z529gDAVzuNUV+hNdnSiWzmLwjlhRn9L5
   IUKFoDXx8eHnoTCVCNJm+szNzDk9SQauHoobVp810zpElG51QQJJPdzvS
   zLBMtjHOjVGIubGG9DWDKzImu4AwZ2m4wZee/10rVPGzdRLuaLES/HmZj
   LjzS43fwiAZc3NCs/U8iAlUUYi9E32s2FTKqWfL7jRsPNqYa3Yb1BAbAU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="372711367"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="372711367"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 11:25:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="1081012567"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="1081012567"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 11:24:59 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 11:24:53 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 11:24:53 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 11:24:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 11:24:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4cnICQjcj2MDd9o9jIWBanAQcbIGwsxyyZ51UHnewFre1smHUe3esxNR26pLE+hwnSlmW4Klw/hIUUsrD3jzZN06oacTTB9yBErkpUzuBx2snTYa9EnZJpyzERqMpILtEM5teRn1PMkfPf5mR8N6amWckZhvwERb8GNK1QtKPW8WHAlKVkgJ8TQx5tlY2xeV1xiv/T+RJBSy1JVcVM8zsUmOd8VfCMJiyP2J0WETFrvXVspu+P4rQp0NeVNFmNr5tS4oHH/8f/F9Qi115NhiIoANr5ydIaLb77nGWcGI8vmIFxdFrowJK5I9T5Gtndzjcyg0DYchR+FqykQHDWS+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ukr482w6LBtZkXG5BJxeR/BJq2fKmrOqQKEgF/dT/hE=;
 b=Br6ixkh5njaCattKUcIftVyFSe/gOYOFjiLM4IEHnrqxxI7b4osTfXDGa6f9sI013raZIDxFXOxbb+AoVYMJn3OILqUHs0krLy76p4Ea1t5gjQjlFEtv0FPxUT7lHtvkypsJJs5Lq+jN+jx2tfGHIyKqg7ZkuN7JjFhGaRqPV7CvfFWPUNoqAEzf66yg9Jtu0glvhm2ldsQRK86qu8dIcS13TFpzxzgbB3jiLpn9w5kmVPkmBztbfUpfFnAoqM6DxGBHi9k87Zbkt3PH+ozNSgh43dTB2AIy/ZY3ex4pvI4NicGLajijcBIIJWUk44fUt3fQcFyIQnphUIHpRxeZEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6196.namprd11.prod.outlook.com (2603:10b6:208:3e8::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.26; Fri, 29 Sep
 2023 18:24:50 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 18:24:50 +0000
Message-ID: <779c0e84-df80-adb1-f4a6-0c8e6c4036ab@intel.com>
Date: Fri, 29 Sep 2023 11:24:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 net-next 5/7] net: ethtool: add an extack parameter to
 new rxfh_context APIs
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
 <63183b19786e2a97dfe55ed31313ede1a50427fc.1695838185.git.ecree.xilinx@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <63183b19786e2a97dfe55ed31313ede1a50427fc.1695838185.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0023.namprd03.prod.outlook.com
 (2603:10b6:303:8f::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6196:EE_
X-MS-Office365-Filtering-Correlation-Id: 540ea9df-33f6-4c9b-2b4d-08dbc1195e6b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: shgO2m11VxgbqEuRn2dCowdomT1zoJeA9Vp99VJVtdhxg/q1tHaLu/j6rbgBKOILUw4bobbl4GCcGA2nLNkRULApgT2ja7cnANBqEMeL3dvWPpBQFATlTy3bbHNFkBuzWKWPAJDnUAvkR3OXLcsZtn9efyv5lZYGdM8A19GFqL6o50sJ4GwDeQkUuaMVJ4lIDpy9IqrbPTFItpnu268Zax8S/m2dv56wLFoej5Ooix4JDhIU0hyazFysGmWfKU/3hseaP5+Jeip+/YIK5dbBkF2Emo4zwWLDXoFoDmtl6LkZUdhxUbGbV4qqC6A+3pOoyiY9k/R1lBsjcG3KLYmf/DF0CCA0xBEr1fjd3LGOtssJmEBRuQwILG3eSb0qZ7CGjmIdI3NMRs952nM6yc2qtO80qhkv3BaQ2sK2FBHZzd+VtDj0qfovhH4pEinNeSwroGcdRsi1r2rlCKULJA7s7nbPx/c228bBIVLfCeS9x9kWdNYYehLnPQ4UR0+97bXZ13efOYtddmF7OH7EdmeVWYMapxafT3b3UmFbG3gik9ZMM2i+koyYiMBKsye0IA6vK7g+4IJImInoFizfXBP//wEfjfUCMiyBhPtIyHgQWZkaM4OglimhNQko1L+pV4iZG2IXvXMEJnR4cMZQENK9zw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(346002)(366004)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(316002)(66946007)(66556008)(66476007)(6512007)(8676002)(4326008)(8936002)(41300700001)(26005)(36756003)(2616005)(83380400001)(478600001)(6486002)(6666004)(82960400001)(86362001)(31696002)(38100700002)(53546011)(6506007)(2906002)(7416002)(31686004)(5660300002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?YXVwMHRGUWVjZUIrUG5xald1L3VFY2pkZmxlbHd5SzFBUFdhWkYyWVBjVGJE?=
 =?utf-8?B?NTBxdnk4TEt5UTdrSWRZeDlsS09kTmlUSG10VmVsN29NaTQ1d0pqTzVnTXor?=
 =?utf-8?B?cHI0M2ZDNWM0alpWTG1Xd1RYWktXT1lEcG9scGdZN3BUQXMvQSs1T2NlRGd5?=
 =?utf-8?B?K0krY1BhRm1NWTNaZFVMeFpSQVAzQlREMUN4V3VXMFpLQ1NoRWVhWE9STmhr?=
 =?utf-8?B?eVpPR3lCa01qTkM5cGNuN3kvazMvRDZISm83MmdYaEsrVkx4SW0zUklqSWFE?=
 =?utf-8?B?eStmSGdMc1FkVDM2OFhvaVNJVDEzM0VqWFVteGRKdk9KbTZQUkRYNHkxNVFm?=
 =?utf-8?B?ck5aS29kdUgxdnlTbjBHTnNDT3djZE1IdElBQTNnWjQrRUNCUlNkWlFTbnB4?=
 =?utf-8?B?bUZGdDVTUklXWTl1UkVMbHhnaFRsL1IySDJMQ29TRUtsMkJKMWRIQWw4NjV1?=
 =?utf-8?B?bFNtZ1lzanBiSHpRRXo3cE4zdmVCb2hKNDUydU5ycmdrTnRwWXVybzhhQUtw?=
 =?utf-8?B?a0lpeEZuYlpGOFV5cUMxUStoVzBkQk5BTmtObzRXYlVNN0VzUk9YR1haTXFE?=
 =?utf-8?B?T0ZGbGdtRkZsam85eWJjNVBWaE82N0ZoTk10MEFpQU1NMXhoUG5kL2lNNXA3?=
 =?utf-8?B?VE9nT1NvVXkrUEtjMnAwR1UwWVVQbHdRazRPNzlteDlBeXRQMUxnR3M4Q2du?=
 =?utf-8?B?a0VSYzNDN004VHhJQWtKZ3dqSlp2SzRsT3BJMFhnUnFMQUFjdlFHL2xqWlR0?=
 =?utf-8?B?Y3FFUW1iMUF5UDdvYnI3d1lOaGdWWkg4WjM4RTg3VFN0WW1OcTErbjJqMG8w?=
 =?utf-8?B?R1BVVVAzaEh4YmY2ZHczQy9qN0lkdlVmalpjcm1idnRqNWVRVkw0SEw0WkR3?=
 =?utf-8?B?amp6aFBjZFhRUjlUamN4ZDJWQ3RxbXNQNnI4WDg0dithcmJ4NndnMkczbysx?=
 =?utf-8?B?RHZDZ2pEVG5PWEtGUWRhbXY2cXdEcFdrRWJDVFREVEE1WjNRN0dhQVpXOGw0?=
 =?utf-8?B?RXJuMlc3RERVbXZNMmt0VTJmWi9FQjF6Q01Wa1ZiRVNWSnl0YmRkRFl0VTNM?=
 =?utf-8?B?MVFLUCtDa0RMWXlqOXA2WXN4Nmd2Lzc5eTViclFjWkZ4T1F3UUp6ZXJtMlpk?=
 =?utf-8?B?eUNSVHM3SkNTSjk0SzNJQXNySzNCbjB0NVJYd1FISlJUQkFTa09FKzltcDdo?=
 =?utf-8?B?TlNXNzkrY0tZQzBUeTZINHdDWm1hN2lLT25vUWhFVlhrVlY1eHpNQW1HeWdJ?=
 =?utf-8?B?Z1M5eEZGSnIzaEh5dDZFWldvLzJRZHBuQjBuRXlIbG9pRjFuNnZQV3Q0VStP?=
 =?utf-8?B?Q2Q3emFNQjJOcHFISWZ1S1VjdVUyZHJ5RDBEdnd3UVB6VEZYWVN2cTM3enpT?=
 =?utf-8?B?d2l5MC9NSGZMbjhlUzNvQWI2U2pVWTYxUlQ1cGZUc1lZRUQwaDNqMStUWDJK?=
 =?utf-8?B?ekJXeVQvK00vdXBUYXRKYXh5M3hVc2krd3Z5STlnZC9nTEVJczgwbnB4SVV3?=
 =?utf-8?B?eDlDeWxkOThvL0gwWFBaejc4ZUQ0S3ZTb1NUcjlZMStsYzE3bEl5UVhjZVBZ?=
 =?utf-8?B?dWVZQjNBUW9QeEtvWk5uMWoyRlVuVlp4OWswTVpiOUZsdmZxaGg5NmIzOGYx?=
 =?utf-8?B?KzhtY1laUVhzQWx5ZXBzdCs5TjVrcmJZMWFQcUJuWi9GYnY0ZUt0cnF0MmVh?=
 =?utf-8?B?aVQ5SFllZkkxOFBYSXoxSVFlL0pCZWhPeXk5VU5TZVQzd2VTU2I0Z0g4ZVNJ?=
 =?utf-8?B?a1pTMitpcHNPSWxoOE5jdGU2WG9DTkQrNWc0WnZUT0JpNzZheFZNRjNrTkNu?=
 =?utf-8?B?a1NqQ1M4Rk1TRmltZ1FLdDUrQnVRRUF6SVk3cGcrTWJUSFFnVGJWOCtHUml2?=
 =?utf-8?B?Rk4xQnJCd0h2TlJIUjZKUWhYT2orYk04bzFTSXZUM2p4blI1THAxSXNudWVh?=
 =?utf-8?B?KzUvaHF3RGZIdDREUHVrbVNQYWU2ZjZvMDJwUzBEU2M0Snd3dEpQN1czQzdH?=
 =?utf-8?B?NnMrM21tNm9WQU5KRUR4TGR1S0ZrK3BreW4wQVBPOEJOSml6OFJsK2EzOTJG?=
 =?utf-8?B?U2djRXFDS041eVlWRVp6UGwvZVkrUXY0bkdIMGU2U28xNnprdDlXZDgvT0Fx?=
 =?utf-8?B?Y3ZlY0hYRG9xL2xnMEhvNkNOaGg3QTBEcVdoNEM0N2xZbUY0LzdCdXRsN0tZ?=
 =?utf-8?B?TFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 540ea9df-33f6-4c9b-2b4d-08dbc1195e6b
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:24:50.6679
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aYiTA/NXSFJkHSXiB8r/N6pQ6cDC5TJCA9vl/rwGGBCoJdzaSB3ViO2Vjz6lKwOYqFx+7v8z6+TRggHJne5VrkgYLGWocWngxm9z8JygECM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6196
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net



On 9/27/2023 11:13 AM, edward.cree@amd.com wrote:
> From: Edward Cree <ecree.xilinx@gmail.com>
> 
> Currently passed as NULL, but will allow drivers to report back errors
>  when ethnl support for these ops is added.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>
> ---

Why not just squash this into the version that introduces the ops?

I guess this calls it out a bit better?

Thanks,
Jake

>  include/linux/ethtool.h | 9 ++++++---
>  net/core/dev.c          | 3 ++-
>  net/ethtool/ioctl.c     | 9 ++++++---
>  3 files changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 975fda7218f8..c8963bde9289 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -927,14 +927,17 @@ struct ethtool_ops {
>  	int	(*create_rxfh_context)(struct net_device *,
>  				       struct ethtool_rxfh_context *ctx,
>  				       const u32 *indir, const u8 *key,
> -				       const u8 hfunc, u32 rss_context);
> +				       const u8 hfunc, u32 rss_context,
> +				       struct netlink_ext_ack *extack);
>  	int	(*modify_rxfh_context)(struct net_device *,
>  				       struct ethtool_rxfh_context *ctx,
>  				       const u32 *indir, const u8 *key,
> -				       const u8 hfunc, u32 rss_context);
> +				       const u8 hfunc, u32 rss_context,
> +				       struct netlink_ext_ack *extack);
>  	int	(*remove_rxfh_context)(struct net_device *,
>  				       struct ethtool_rxfh_context *ctx,
> -				       u32 rss_context);
> +				       u32 rss_context,
> +				       struct netlink_ext_ack *extack);
>  	int	(*set_rxfh_context)(struct net_device *, const u32 *indir,
>  				    const u8 *key, const u8 hfunc,
>  				    u32 *rss_context, bool delete);
> diff --git a/net/core/dev.c b/net/core/dev.c
> index 637218adca22..69579d9cd7ba 100644
> --- a/net/core/dev.c
> +++ b/net/core/dev.c
> @@ -10892,7 +10892,8 @@ static void netdev_rss_contexts_free(struct net_device *dev)
>  			xa_erase(&dev->ethtool->rss_ctx, context);
>  			if (dev->ethtool_ops->create_rxfh_context)
>  				dev->ethtool_ops->remove_rxfh_context(dev, ctx,
> -								      context);
> +								      context,
> +								      NULL);
>  			else
>  				dev->ethtool_ops->set_rxfh_context(dev, indir,
>  								   key,
> diff --git a/net/ethtool/ioctl.c b/net/ethtool/ioctl.c
> index c23d2bd3cd2a..3920ddee3ee2 100644
> --- a/net/ethtool/ioctl.c
> +++ b/net/ethtool/ioctl.c
> @@ -1381,14 +1381,17 @@ static noinline_for_stack int ethtool_set_rxfh(struct net_device *dev,
>  			if (create)
>  				ret = ops->create_rxfh_context(dev, ctx, indir,
>  							       hkey, rxfh.hfunc,
> -							       rxfh.rss_context);
> +							       rxfh.rss_context,
> +							       NULL);
>  			else if (delete)
>  				ret = ops->remove_rxfh_context(dev, ctx,
> -							       rxfh.rss_context);
> +							       rxfh.rss_context,
> +							       NULL);
>  			else
>  				ret = ops->modify_rxfh_context(dev, ctx, indir,
>  							       hkey, rxfh.hfunc,
> -							       rxfh.rss_context);
> +							       rxfh.rss_context,
> +							       NULL);
>  		} else {
>  			ret = ops->set_rxfh_context(dev, indir, hkey,
>  						    rxfh.hfunc,
> 


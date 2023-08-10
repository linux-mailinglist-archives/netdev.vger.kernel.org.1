Return-Path: <netdev+bounces-26463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 74BDC777E3D
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 18:28:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A630D1C21620
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 16:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ABCA20FA1;
	Thu, 10 Aug 2023 16:28:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D57B1E1D2
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 16:28:13 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57CB2268C;
	Thu, 10 Aug 2023 09:28:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691684892; x=1723220892;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9WnzScs2Yya1qA/YS1phSn2oZTEx8ljdWNRgzRL40hw=;
  b=SZswTpYplcMAfyR3axRrT2fVti/dT5xg0rdGTcj3xXHsL1xkD+mUc1Bj
   tAANtpvt7+0owg9lg30HW3pEdiWVcFUlqjGDkwXlVpQRXO2KICnlME7b+
   MO/YwFniup9y5LVeUGXtsfXfXk2j8C8Tuj0agF5KeDdp/lCyEAbEO1lfn
   wzDkVDkTGoFvMwgUsuG+VPX+GFXXR1B6wYRWDLpb65+2ExzlxhQOAlLqW
   We6/0paSJDPT5TQpRjEgfNKG3c0tKFKIUaXks8pMF8C5yg9jsu8rgGLMi
   2kTddKvv3eoHDfYzXT2pD88Bm2zWVM0pRSDXJSkdPTuZ40BkCCMTrMpEa
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="374222476"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="374222476"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 09:25:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="822306310"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="822306310"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2023 09:25:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 10 Aug 2023 09:25:45 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 10 Aug 2023 09:25:45 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.171)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 10 Aug 2023 09:25:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mQKxbKtQOH8QuXV/26ruj3GMhqdj1oAt37LRnsyj7kw4cxVDlGHd6NYo5TdBChDwds94/NLTYxL1v/aNVqGGwd3gPZXITmHhO/Oz8pUYA4UiEDKiUKOwq1QPII+xZUq/wy07DdKQ20XukJSggYhVMa/8lGTMK5ycjLJ0k7T+2Tr8SZ9ihGM0bV+sBzJc94NdK65+19ZHIDOLAOyD8V3L9yu3m5k8kr6auIOHbL02a3K9pZNDFpF4xdj1Q8jxqq7e3xbT79vAt1cSVvGIuY4RaSIY4mYAScKwIByYZ7uYRfP1b4rpQTr7IckQqtqUE5EzwUo5V6BdS/iyZLx6IivGsA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/TiJ7uYJcniw1X4vrl8UDU+z2Sy11fPKJe6FecOGm9Y=;
 b=kFHSlKDefr8FKg3LDJZD0KgJR1WmwfT+6PcwuGmlEG6qyjRzMINjjLP1NAm0tbqdNn878uqE4GHw/rzTsCl0IAPSL+sQY01VkLwpZaIhS7kgqxmOMQtA5XbHPWEbouNJZfGS3S0Ka6TMteHc7rUa5cslO/0M9ROWrK3ZjUMJv/8u1s6gzE68wLaKxfzwhl87rdQt2zYhMKhtryVz+LN1cwtVdwNwupDXUnA3GF3N/Lr9dsNm7GASjYTBtMwlThVLEuamZEo0IMuO0Y4XdbvJEHflyiUefi1coJlX+MVvDJm+FHtbEOpMp05c+jf4dBBBddkD2bH+ohzT3J9tARYa2A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from DM6PR11MB3625.namprd11.prod.outlook.com (2603:10b6:5:13a::21)
 by PH0PR11MB5109.namprd11.prod.outlook.com (2603:10b6:510:3e::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 16:25:43 +0000
Received: from DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a]) by DM6PR11MB3625.namprd11.prod.outlook.com
 ([fe80::44ff:6a5:9aa4:124a%7]) with mapi id 15.20.6652.028; Thu, 10 Aug 2023
 16:25:43 +0000
Message-ID: <e6565705-4867-c07f-5cc7-4e9155b5a4e9@intel.com>
Date: Thu, 10 Aug 2023 18:24:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH net-next v1 1/7] overflow: add DEFINE_FLEX() for on-stack
 allocs
Content-Language: en-US
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>
CC: Kees Cook <keescook@chromium.org>, <netdev@vger.kernel.org>, Jacob Keller
	<jacob.e.keller@intel.com>, <intel-wired-lan@lists.osuosl.org>,
	<linux-hardening@vger.kernel.org>, Steven Zou <steven.zou@intel.com>
References: <20230810103509.163225-1-przemyslaw.kitszel@intel.com>
 <20230810103509.163225-2-przemyslaw.kitszel@intel.com>
From: Alexander Lobakin <aleksander.lobakin@intel.com>
In-Reply-To: <20230810103509.163225-2-przemyslaw.kitszel@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR2P281CA0052.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:93::15) To DM6PR11MB3625.namprd11.prod.outlook.com
 (2603:10b6:5:13a::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR11MB3625:EE_|PH0PR11MB5109:EE_
X-MS-Office365-Filtering-Correlation-Id: d1bdb7e2-3313-4487-72fa-08db99be715d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I8aa4OwKJjI347dv55cweBx3cpllgjrcSWVWO87Ka/LrKKOPQWJzp/OX9IDMthBC+LkAbTRO0+6KN0Z/4lcCNUb+ayP6FPQwtDXlkpldHjJ2rKbkVl8gV2mheU7LSQiNrJFrDTmCF/4zhw0GIgCNh3TWzvR0QzrPgl8BAO+dmDd7L0v98yuhR5odWPVMe+KD86vf0RaFdMpSPPcV4QDWw9I3+dRXhycskLFXHTB1iz6armFzaRuhQrDfg0/UxS/ubo3khiMv5lvQvGaIlY46hX+vQaLy0VkXL4mA8l3BcX6tkPayOBIBQliCZdM5lpT3F3oWKWisMh5rV6SloeUm5Ympq7Bgr6dzp9zoBmC7+V7OIR5qt1LCyL2Q3t8dfapXjf9xBd1JPDOu5j3qcepvdAxNyn0B3LZPM16k4HJN1qzSivOp/oAV2T8qIbH0eBp3BkhTx4PWND7VRxXFa5gE2joLesriM0O5zNTrZr/MJRscsZWGU6lWc08vQPhV7HyWIpyX45DRt8UacZr043TPYweAcV/Axh7qrDINK6SNjbAmjgfRkjCI5zlHQMrLM0isTxdS8jg/zVQx23SRyhhAgigt6Ha73R0U2ecx1ptaFpv6f9gq1xTULxp/zPf14JOTkUKDUKOkCNyllddhDiAN0g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR11MB3625.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(346002)(39860400002)(1800799006)(451199021)(186006)(82960400001)(36756003)(38100700002)(31696002)(86362001)(31686004)(8676002)(107886003)(8936002)(6486002)(5660300002)(6512007)(6862004)(6506007)(2616005)(316002)(66476007)(66946007)(66556008)(478600001)(37006003)(4326008)(54906003)(41300700001)(2906002)(6636002)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?R1BzVnJHSjNmV1o2SDBiNnRoSWI2dE4rMGpXRDkyRmJRTUlNaGxOL2dudnE1?=
 =?utf-8?B?emtjWHF5VHJRV3ZFRnZHSVJhbTJCL2VvME53cG5PVTN2RitLcThKVm5UVy9L?=
 =?utf-8?B?YWNJRnZWR1hxTFh2bUZsbmd6YkUrVCs1ejZVV1JRZW8wbWZocVJsR1pqQk4z?=
 =?utf-8?B?RVFLMmw2czU2a3AzVGd1eTluOEgrVGlNQkpEZ3VVeW4ybEcySkZIQmNyYjdi?=
 =?utf-8?B?THY4cFhhWTIvVStMaXdjZ0VKNldKS1BEU0hBamlvTFcyckIxNlFJeFVlY2Vv?=
 =?utf-8?B?OXhlM2Y2SEFNaTB3YnBRZlFVYm9rY2VObk5VNllzVnNJYk9nZk5iL1liMmRJ?=
 =?utf-8?B?TWRud2RTdEs0eGNNMnVpaTRKRThqNjE0T1ZXZVUwejJudVZKNmFwak9EeGlY?=
 =?utf-8?B?Zk10UkpxeElybFRLY2Npdk1EbVhxemF1N0lhMVhEQk15NCtJKzY1djBSdDZl?=
 =?utf-8?B?b3dta0FNdE9VVk5lcEMyd3N4Rzh2V2VJSC9ZOUNIYmVjZ0RPaVJTeHgvU3Rp?=
 =?utf-8?B?VTE4Q0pSNW9kK0JWejNBaHh3ckdneW0zeHlhK2ZZTVRMZU5veWJndFhVbzZI?=
 =?utf-8?B?LzNPbC8rL1NtUVNRSm8vUlduV0hUY21wM0kwZWtzTnlTYTkwV3VWVHhvbHkv?=
 =?utf-8?B?Uy9ZM0xpRE9YdXRKTlFUdzFSR09nSHBpUFpmcmRhMmR5NUxlSVZBTE9FK21U?=
 =?utf-8?B?cGVzQmdnY01KM1ByUk94RzZDVXBxaWxnQVFlL0xuNW9RUzJTdkVFbHpaQWM0?=
 =?utf-8?B?RjRDMmgya2l5RW5sejVRY1RrZ3dMZTk1cXpEOGxON2QwNlRKdVRiZy9pQjVK?=
 =?utf-8?B?SDhsMXBGdXVEY3c3bUh5Z3ZpNzhjV2tKd3dWMXdwczFSbHNVdEJYcWovN0Yz?=
 =?utf-8?B?SS9rVXhGbXVyZzFQKzgyRkdUVUcyK0VYSE1UMVArczZtcFFOamgzV0xreUlk?=
 =?utf-8?B?WGQ0SWRuM1B0eitNMkI1ZWprSFJnMXl6NGk4cVlUYUtzWUlPS25GcWkvQXZm?=
 =?utf-8?B?Um51TXBub2dyVXJtaGF0TDgrYUQyVWxnK2d6UlJuVzkxSkY2ZUtzUUJPZkVC?=
 =?utf-8?B?Wll4bzBNOUlVK2hoNTBrVlBENUJwbXU4M1JXNnQ3cUt0bFpGbnJGci92OVlO?=
 =?utf-8?B?K2NVbVRjQTJTRU5OYU00cDZPNHh4RDYxb3NiNUFnWWRnUVJoYkNmdFlzZVUv?=
 =?utf-8?B?WS8zVkl4MWtkT1FuYWpWRHRTWTRzaks2R2gyL1hnVXdrVjlTK1djMjFnNm5x?=
 =?utf-8?B?Z2d5MnRVYW9GK0FOZlkzMUtZSkRxQmY5YmJTRmNOa2MxN0xjTFhwK015NUYv?=
 =?utf-8?B?bDcydGJlcVZhZnlrRERObEhGdEgxUkVnWXdINGVUWGZJTDFwaHlHc2RBd24w?=
 =?utf-8?B?b1YzR1pvNlp1cFdwN3pFa0pqZFJCWmZrZzhrK3NSUTdWaXJSanEyaXhBSmlk?=
 =?utf-8?B?SkZNcXRLSG1CRGxsclR3MkgzczJVWnpiZzhnV2I5Nkw3SEJwbTRWNUlrU29K?=
 =?utf-8?B?bUhTY1R4dmpYUy9iTkxvSzNuOFBibzBiMm1xc05OalhoSEpvNzNFYTJaK0V2?=
 =?utf-8?B?dHNaOVcvTDlheTVjYUpxNURjaTRXeTdJZEEwcFRDVVlBaEVONmxUSHFkYTZU?=
 =?utf-8?B?bHp1WGhSNnZsazdyRGdpWFJ5bGZrODdCaUYyMzNJT1Q0czZOQzdOcUtiU0t1?=
 =?utf-8?B?K1Zqc2dNK2s5MDJZVTdaYmxkYk1pMTd2TG11VG1oZ1JrQU5lSDQxUFBGMXB0?=
 =?utf-8?B?V3RadVJ3Si9EMWVDem9QSnJhZE9CeXNyYXJVbUovQW1CU3NVaWFlUFFLQzRY?=
 =?utf-8?B?c2RPWGFFU0VWQ1l4R2ZmZVk1MlhIY0hVVzNTcVErbzRoTXA5UGhOSVYwSTlm?=
 =?utf-8?B?ZXNMeks5ZjJPeVhRb3FFOSs3ZWh4dWMrZGg5czZmQ0NCckhtZE5hVDY3S2py?=
 =?utf-8?B?YlYwbi85aUhqVzNzWGVoSHpzNDVrMlBuVVE0dnN6c2ZNNndyWTc5NFBxd3JP?=
 =?utf-8?B?SU1RWS9NQWh4UE92T0llQ0VBenBSN2JFWSsyTm1CQ2JpVUlOZm92V3Q0dzA2?=
 =?utf-8?B?cWlXMDU0Qm5ZdzFKTGN0TWpDWnkvbW9GNDVOcXBKSXByOGdzVmg1QWdpUWZS?=
 =?utf-8?B?d2wvNUsyeXd0eEsyQVJvWll2MWM4a3dCdXQwRTVKZUpmVDM0cWJybmpsVS9P?=
 =?utf-8?B?YWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: d1bdb7e2-3313-4487-72fa-08db99be715d
X-MS-Exchange-CrossTenant-AuthSource: DM6PR11MB3625.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 16:25:43.1073
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8W7Ju/KSTqL2adr3hYFuY8rdUzB58eEYnWaa9EY6CMvAZKcTKU1T+h3tOWclTt3ahUzIPC2slRwHpcwoJR1urndPd03e7J56jE0fRUDWpo4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5109
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
	SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Date: Thu, 10 Aug 2023 06:35:03 -0400

> Add DEFINE_FLEX() macro for on-stack allocations of structs with
> flexible array member.
> 
> Add also const_flex_size() macro, that reads size of structs
> allocated by DEFINE_FLEX().
> 
> Using underlying array for on-stack storage lets us to declare
> known-at-compile-time structures without kzalloc().
> 
> Actual usage for ice driver is in following patches of the series.
> 
> Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
> ---
> v1: change macro name; add macro for size read;
>     accept struct type instead of ptr to it; change alignment;
> ---
>  include/linux/overflow.h | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/include/linux/overflow.h b/include/linux/overflow.h
> index f9b60313eaea..21a4410799eb 100644
> --- a/include/linux/overflow.h
> +++ b/include/linux/overflow.h
> @@ -309,4 +309,31 @@ static inline size_t __must_check size_sub(size_t minuend, size_t subtrahend)
>  #define struct_size_t(type, member, count)					\
>  	struct_size((type *)NULL, member, count)
>  
> +/**
> + * DEFINE_FLEX() - Define a zeroed, on-stack, instance of @type structure with
> + * a trailing flexible array member.
> + *
> + * @type: structure type name, including "struct" keyword.
> + * @name: Name for a variable to define.
> + * @member: Name of the array member.
> + * @count: Number of elements in the array; must be compile-time const.
> + */
> +#define DEFINE_FLEX(type, name, member, count)					\
> +	union {									\
> +		u8 bytes[struct_size_t(type, member, count)];			\
> +		type obj;							\
> +	} name##_u __aligned(_Alignof(type)) = {};				\

Hmm. Should we always zero it? The onstack variables are not zeroed
automatically.
I realize the onstack structures declared via this macro can't be
initialized on the same line via = { }, but OTOH memset() with const len
and for onstack structs usually gets expanded into static initialization.
The main reason why I'm asking is that sometimes we don't need zeroing
at all, for example for small structures when we then manually set all
the fields either way. I don't think hiding static initialization inside
the macro is a good move.

> +	type *name = (type *)&name##_u
> +
> +/**
> + * const_flex_size() - Get size of on-stack instance of structure with
> + * a trailing flexible array member.
> + *
> + * @name: Name of the variable, the one defined by DEFINE_FLEX() macro above.
> + *
> + * Get size of @name, which is equivalent to struct_size(name, array, count),
> + * but does not require (repeating) last two arguments.
> + */
> +#define const_flex_size(name)	__builtin_object_size(name, 1)
> +
>  #endif /* __LINUX_OVERFLOW_H */

Thanks,
Olek


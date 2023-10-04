Return-Path: <netdev+bounces-37926-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 98B167B7D8A
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 12:51:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id 3214428102D
	for <lists+netdev@lfdr.de>; Wed,  4 Oct 2023 10:50:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6929111AC;
	Wed,  4 Oct 2023 10:50:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E291101FB
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 10:50:56 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A688AF
	for <netdev@vger.kernel.org>; Wed,  4 Oct 2023 03:50:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696416655; x=1727952655;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KGbKJLrGNNvgIwDDAHuhGfCLNf+HY0Z7r+REN/5pIyE=;
  b=VqM+3glbUWxbPP5dQ67f7U8TkHzu1dF9jXHYvzqhgasmJi9/vw6k0ok3
   Bu0DrwsL13HjiBfbcdLF5Sci/ZCICSCdKUBN0xhBrbid+2Cscll0E/peU
   b9bM4CG5mn4Am9LuXzPHvIpBOdlyQmTXrjaM1Z8FeqKqPDKDo+UWcWkO0
   ByWHnIOnHB53e4QoUnL55/J10rR3Q4jVbHfeUhfI4hIZ47ryyjCXBhNSH
   AhKysRcWVANxq1AIAgp4CxmPmMRAUVbVnamTcgDB6tLl3rysYAsbKhGw1
   GvJS6a1gu8JAU7wRCEGyoh3BQRLaRF+ehoyxYxGNjHmPGvcuYNyLPt/oT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="383035943"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="383035943"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Oct 2023 03:50:54 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="875049569"
X-IronPort-AV: E=Sophos;i="6.03,199,1694761200"; 
   d="scan'208";a="875049569"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga004.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 04 Oct 2023 03:50:53 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 4 Oct 2023 03:50:53 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 4 Oct 2023 03:50:53 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.48) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 4 Oct 2023 03:50:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NqPtIR9DX6WtkXvq7MtHa6qjsNOrOxHbyRawDy4a6YVVHxKJPNRxa0Mxz2sIxQ0YEapuLFCXUMncbUK+K9LKY4PGtzKw+7/aUYjXuMZaEcWB0HXNXu0Ga/j5a2/O+4YVRoXuzL+oH9h0nsHurpuMsY5dLIvs//DyQkcigIOuRPL09NYkApm3komrP4XMoMmVn9g7sseZtDkF6cA9MKEAoRmBvb4zL5ltyp7fc5wlch9qoiLkYk4KeP4ltYMyLPDUzV0sc09/ZlJiPgbpZ9ZrPpaEu+VeimDbnqtGiaZY81ebu4KJVnaxSfuZYR3U3NpW/9x+dhkMMC7SE94yOcSPzg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cn3FxubYSmw64Z37TpEeGHCcep2gBIozIK+jn44pMMo=;
 b=L19UFkPRV4nbna24+wVYcs+Z1s56pgCgseT9mp9iXo7Q3BlU412sCoX+JUr44NRVoYwpVQlXBjzh8WxUDR52oL0Yse3NxmqQ4i+Pab2UuY1Tcmq+fM8a3LuppcxkytbuoaTHSLmeisVpFk3sTzu28OylApPbSY8Cu8nPb0wcBTGqH7nSnryUKzcs5XC/UHA0wD1uYDgMxy0nwwXCxkyxAvdHjaUjB7y07a413aGovnWtlk+CkTtM15Ys8oF/FgdHwLjTMlnSGHHEgp3ldrCkYd9cOMbdmS9rwSkBjxoyu4I08ZQvfLSEGg5nA+i0DFEfQN62GNTgxb3uBWEg4ZMs5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by DS0PR11MB8000.namprd11.prod.outlook.com (2603:10b6:8:128::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.35; Wed, 4 Oct
 2023 10:50:51 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6838.028; Wed, 4 Oct 2023
 10:50:51 +0000
Message-ID: <07c52946-fac0-4e32-bd9d-883d05997f93@intel.com>
Date: Wed, 4 Oct 2023 12:50:42 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next] tools: ynl-gen: use uapi header name for the
 header guard
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	Chuck Lever <chuck.lever@oracle.com>
References: <20231003225735.2659459-1-kuba@kernel.org>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231003225735.2659459-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR0P281CA0094.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a9::14) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|DS0PR11MB8000:EE_
X-MS-Office365-Filtering-Correlation-Id: 2116f524-b84c-4f72-961c-08dbc4c7c691
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8e9hZe2fZORCDIx+zbt0DnTZJPE4fwybozPVHr+1XESbhEgI4K9Q63Oyci3qnUKgtR919N5db2MwtQIo0UB8eW+1w3l7+wYhVLL/lwjm0QDVGgiwtxfvo5syl7lOldq0oNJn+xY4MIwjW8k+2s8Yla3Ht9AS0+z9UMy5wKuXPCC9He8FOuzo0dSI1dUdcJjggwNYM4Wd1/SuQM5WL6zfzHhYDAB9IB0W8UosuCu+xM7Xy/ayw0nsNCTXxe34CHGLgIgR8gG9lwWQ6pNeh4E6VCst8C1I9pATzlTLxjEgviC+yS+dYr1sSIbFt80kcSltCIjImveXqtyQG7HYRidh+HtxbcWVBfHug2DpUYXaDosjaD2E1kNgL27Z/dSfybFEDcxlFpLkIGII0ESsWMsgSDtRYl4NGSmCnTLaBGfFumZ7ZGkc1LfDDAxSnySi9l82K48Emvr3csqchf2pf+tft1RL4mpBXwUZAXRvRi32CkE4upJAWEvgnAS8biaT0xn3ywqlxDvHriHQ0+n2bK9HMBMTfAC/k4T8UzZJgCaAfipfEpawYX6uT+B09WqHXp79drhYrJVnipYLguEdYkpUpsnFeTnOu1lz4MGcfgGoqK8mIF6c2kS2dwVfCld/G0U5W7YMI8yAFUkGlgkejNAQQw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(31686004)(6512007)(53546011)(6666004)(6506007)(478600001)(6486002)(38100700002)(86362001)(31696002)(82960400001)(2906002)(316002)(83380400001)(26005)(2616005)(36756003)(66556008)(66476007)(66946007)(5660300002)(4326008)(8936002)(8676002)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dk9iVXBMbHJvdWsvNGlZOEQ4QUovRkx6UzM2dys3bVNlMFUrcXdhdTVXUkdm?=
 =?utf-8?B?RSs3QmU4YTRTb3VvT0loR1UyVHJrNlBkV3RWRldBcnFlOHY0T0hOYXp1bTVI?=
 =?utf-8?B?cU1kT0plNTFnNkZZZi9IdnFEcE5ONURBa0FvWkZSNUM1eU9ZWEhFalFSK1B3?=
 =?utf-8?B?b00za0pISXNIaTlQTkRCdElDdzJrNndlMHp5eUhYYlhsMVE4ejlaTFBLQzVh?=
 =?utf-8?B?VmYwYkM2YmUzMmU2U29NNlVNRThKZ2VLYlJlNGxYdmRZMU9FNFFtamZXSUlF?=
 =?utf-8?B?OForNk5Oa2FXeURvQ0tEOVJjWjV4YzNzZUdqYjd2aEgxVzlIakl6bW9vaHI3?=
 =?utf-8?B?Nmt1bmpGRFhjZjZpZEptdlhiVENOMWhjZ1dGOVgzd3lRWnRwTksvaHRmSmlH?=
 =?utf-8?B?blBLVHpQaWF4SWJRUXVXV0NRZnZYamFpK05ieHdxMlExdmYraVBBdHBwVE1n?=
 =?utf-8?B?TEgrQXVvTGhKR21DTjgvWTZqcDVtd3gxYk5YK003OWtNRFhFbUFtQmI2cXpt?=
 =?utf-8?B?dlV5OXUyc05ybW5pNlQyaE1QK1owZE9GWG5vTHlLTUxNR3o3UWVWeklKRUJh?=
 =?utf-8?B?Vnd4M0lZWGFRQ1dMVXZnZ2k1Ym9iMUl4YnJaTVR6OXNVL3BNM29IaFh0eUpK?=
 =?utf-8?B?b29XUlN0VjRxK3hKTmhMSWllTnMweGhyNm9rUEx3Z1duWHhsSGxoUndiMjI0?=
 =?utf-8?B?Skl5cXphNXMyY1k4RE1pOUFxb2dCRlI3OWJCK05PeFIvR2pvU1JYcmJPUlJL?=
 =?utf-8?B?WlZlK1VkR3hBbWhkU25YTU9ZUG5HejRpRU9qdFAwa25OMmdzYXBCK05vSyt3?=
 =?utf-8?B?VSt5bXBmNkY1Z0xsMkh1RWRNa0xLMk5iZi92d3V0N2REV2NwQkJWV2VGdnl0?=
 =?utf-8?B?c1YvLzlKSlhUNFgxZEZVSGE4RG03a2dDa0w5L1F2WDR2N2paNkJJUEYxemxG?=
 =?utf-8?B?UXgxNnBYZFBhc1RCNmVzNk5QSi92eDNZblBZK2hZc0ZtTUtLMGYyajJKbGlS?=
 =?utf-8?B?ZSswRFUzajBaTGFaN2Fsa1F1ZUhtYkpmcnp1em5UWFdUUjR6L2U2dDlkRlVJ?=
 =?utf-8?B?bW9SL0I3R2ZlL28yMEpzd2IzeWdkekd3ckQ5N25GUW5zUjcxVG9Ib3FOa21O?=
 =?utf-8?B?YnowajlxTTZ6K2VPV3pIUEZXVkNwQWtWN3JDSERSSDdjOS9qZW54UllmRkV2?=
 =?utf-8?B?cWtvQWFnaUx6VTBYajl0Wms2SS9NR01xcm4yeEo4b3V1YjlrTjR6NG1mU25m?=
 =?utf-8?B?ckwxRzE0WnJ6UEpxWnltdmtpaUR0Q3VSdTdzcGYrdEJ3cmQ3cHhFNys3a1J2?=
 =?utf-8?B?S1YvdGN1QXhFTHZVbFZUenpXWEZic3hiaXFTVHlZQWM1T1VWMS9DSGJReGp0?=
 =?utf-8?B?ZW1GdElKRE9HWWovZkMrYkFDWjNReS9ZR3JTd012R3lDcXA1VWlkRmVpeUQw?=
 =?utf-8?B?U1RXM1A5V0tHWHZKMkNKUkt5VUtPL3BTbnFWcWpaSmxjc09yWnhrclh1eWV3?=
 =?utf-8?B?Rk5mRmRyZlcvRlRZYWRnb0tNZStzSkphZUZ4WGRiZnM2QW5IcFNoaFdoWVNE?=
 =?utf-8?B?T0NNYXNwZGZMREYxRUxFN1hsdXdRczhFN1g3dXpzZVdlZmZyM0QxdnhGc216?=
 =?utf-8?B?ejdOVnNWSXJrZVE5aUxmT2pFNmM3WTM2dlQ3Qi9UbW9pUUJkL0xjSyt1bzJI?=
 =?utf-8?B?NTFPQmI3TG9WUEpsMHhhZklIVC9iU0drbW9iWlF4MDgrQnZremxxdHBySnc4?=
 =?utf-8?B?MS9seHN1RE42UG01eHFxOHEzRVZNem5SZE1kN1ZIRzRqMEVFQWk5amtmMDM1?=
 =?utf-8?B?dkZZb3haTFJjcFlsS0NuQTA5WkpLbURsaHN4MUM2SEVabGFESnZNS2t2VjQ0?=
 =?utf-8?B?TVFGODB6ZUx2SUJIQmFJK1FrWXZSMmlwMndLNmJRaThHdVN1N3Vqd1BBQ3ZP?=
 =?utf-8?B?RUJPL1pxRTNJTm5UZUVUMHNVSkNKcHpwY0hWbXowNWdodS9iN3QrN1Jod05W?=
 =?utf-8?B?VjI3eHAxWTN2bzJCRkgwbTdobDJ6SnZwejdtNk5YYnlUaFhrMGpDM0FkRzZK?=
 =?utf-8?B?aldrWHFtYVMzRW4rNGlQT2pJaWwyU2I3dEQvdVc0ME1Id0tYSTlpQlpDOVZ1?=
 =?utf-8?B?UHhhWHhsS0h1U1VsVTBiZENJOEczSjVZbGFnUFBSdS9Ncms5aUovUnlnOGRB?=
 =?utf-8?Q?K1AW7Ekvl0+NXJI3Jh4wWms=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2116f524-b84c-4f72-961c-08dbc4c7c691
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2023 10:50:51.4278
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XdZANNdlAsO6jsH6/jNL54hoD0ZvzoYXOWpLkLTEkHjkYB4AyM2RBfdwjf0M3V20RmFMPnzXUp3dUHDEnNuncGPgIAhF19EbRN1y6SMuhIg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8000
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

On 10/4/23 00:57, Jakub Kicinski wrote:
> Chuck points out that we should use the uapi-header property
> when generating the guard. Otherwise we may generate the same
> guard as another file in the tree.
> 
> Tested-by: Chuck Lever <chuck.lever@oracle.com>
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
>   tools/net/ynl/ynl-gen-c.py | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/net/ynl/ynl-gen-c.py b/tools/net/ynl/ynl-gen-c.py
> index 897af958cee8..168fe612b029 100755
> --- a/tools/net/ynl/ynl-gen-c.py
> +++ b/tools/net/ynl/ynl-gen-c.py
> @@ -805,6 +805,10 @@ from lib import SpecFamily, SpecAttrSet, SpecAttr, SpecOperation, SpecEnumSet, S
>               self.uapi_header = self.yaml['uapi-header']
>           else:
>               self.uapi_header = f"linux/{self.name}.h"
> +        if self.uapi_header.startswith("linux/") and self.uapi_header.endswith('.h'):
> +            self.uapi_header_name = self.uapi_header[6:-2]
> +        else:
> +            self.uapi_header_name = self.name
>   
>       def resolve(self):
>           self.resolve_up(super())
> @@ -2124,7 +2128,7 @@ _C_KW = {
>   
>   
>   def render_uapi(family, cw):
> -    hdr_prot = f"_UAPI_LINUX_{family.name.upper()}_H"
> +    hdr_prot = f"_UAPI_LINUX_{c_upper(family.uapi_header_name)}_H"
>       cw.p('#ifndef ' + hdr_prot)
>       cw.p('#define ' + hdr_prot)
>       cw.nl()

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>



Return-Path: <netdev+bounces-37119-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 35BC47B3B26
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 22:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sv.mirrors.kernel.org (Postfix) with ESMTP id DBC55282EF2
	for <lists+netdev@lfdr.de>; Fri, 29 Sep 2023 20:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC91867266;
	Fri, 29 Sep 2023 20:17:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5457867263
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 20:17:32 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05599B4
	for <netdev@vger.kernel.org>; Fri, 29 Sep 2023 13:17:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696018650; x=1727554650;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KzRQHh5iJIKQKTAOpR55FssBPcmvQf+8OMrubnNjNhE=;
  b=Ehx4NiP/qdhVkh2EakVsBBcauzjw3/TMbXfqcxzuOTibtnXFnBcVv5GY
   NYrCxSdRJW7rnkk/QoEnDEYfAIAIQYCFP6Kk+mQs/Lfp1pZSzMnTr/pMu
   aGIdP+IEQmwuWzAOl6CmPZS9IfKNWr2hSTmdtuOtaX2oEUzI8A0Hk0jDH
   ysz5XqapQsS9O3kQsPfQsnp4RxP0bQULhTyER4NUJ5JnJsr+8x9ltrkPL
   6BKIPUDQ5nPPpZR4HKWoW63LGmH4RYvo4Z3+OF0iCeXrvxPF81FMJk4v9
   rmAWo0RRK6dgUz5aNVFkpKLqKlR8e7Bxx2UKR4nuVoiYyUe6LYUYItprD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="381239708"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="381239708"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 11:28:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="785169152"
X-IronPort-AV: E=Sophos;i="6.03,188,1694761200"; 
   d="scan'208";a="785169152"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Sep 2023 11:28:01 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 11:28:00 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 29 Sep 2023 11:28:00 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 29 Sep 2023 11:28:00 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 29 Sep 2023 11:27:59 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KGh7+/k0crw68tYA0eNbzjuAot3LoQK9AJpAK9SREBwFNkoqvxH1be3WVr4SGyEeztvBCOqVIc8+gW0zVpwiieEFV4158iPw67C8IAp/ZMfSVE6Nit6dffjjDZGRulUoTr/6fXBbxMA0WKBt5Mt5TD5ugitqmQqCDtbkzJSyBTPQ6UER8cbZYc3qyWaV7Zkxm8NJdl/g/fndqQZZA8RJAH2veoS1zjZkJFp2GsuM+xXA0g/amwHREuyTDCtxdGkEgSjH3onp8RRMybgX7Qnz3iLKKcoddQIVgW299lNom/M9jQVdjtkBkiqbO1l5V6aMqMTTpd1DpEN4BOLYVVmcNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Hp8aK1ejhlQ0YHRgsDtxQfG4YAjIysCn6NC0w/9xdLI=;
 b=niiAKTyggrid2JpEG9SGFXxnb3/9pfsWKooQ9sRoxHtDSeaW4jI8TVRwuUMj7pLeQhSRnaPfkbff1ANyfxrYRBZ2jaXd8NDjuAWt4SVIvjSU2BatcsB9QL9MhdNLSL8G9yQHTRlxuSYaeK0CXryDTl0QBVKuO2XefAG6FIGnF7S/nHuq1CxkDKRaO11BLNDz4sVeOEuMqwJd+WDBAHT6DMxZgCWjUbpcxyrRXr7GCdwp/c7UeVdRFDq93Rb9DcTC025o0dtwqF65vHlpCSKdYw1mqQa5+H2GPLOZ4se3FoTz21mKtd2iu6kS/Q0hRjjeiogLqljElyCZyxrE4pw9Fw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA0PR11MB8398.namprd11.prod.outlook.com (2603:10b6:208:487::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.28; Fri, 29 Sep
 2023 18:27:57 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%5]) with mapi id 15.20.6838.024; Fri, 29 Sep 2023
 18:27:57 +0000
Message-ID: <067db690-b92b-7005-fa9a-4559b7d6de8d@intel.com>
Date: Fri, 29 Sep 2023 11:27:55 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH v4 net-next 7/7] sfc: use new rxfh_context API
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
 <e4f1a70b649ade2fc03c41b3ee05803b2ee92975.1695838185.git.ecree.xilinx@gmail.com>
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <e4f1a70b649ade2fc03c41b3ee05803b2ee92975.1695838185.git.ecree.xilinx@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::25) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA0PR11MB8398:EE_
X-MS-Office365-Filtering-Correlation-Id: 34c01499-a5e2-4462-3285-08dbc119cd8d
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0J7JBgacYD173arnfscHdpc/9+xhez1Tljeqvkj42QMUf4hByqIKua2kfFj3F5kYhetHnPpF9RvrI++n/LSRUoVCLI8GHuhLKgq3IuEPmvlmX2WjsRX3F5vG2IHGUBe74MaesJ6kH9U4PFtCMIEcU5WrjVlFQK+f0a69NOVfZPJfHJZ3a9vaAKDh7juneNTX/J6ix0bxKMueuhG809uP0ZmOwYkRUfWcnzvs1vJzRFCwzArusHPp9dcrnTLmuyMKApwz7TpqDwhGiNZK22IK9MsogwBohQq+5Amc4DlbzsuVtxGu6wjyWb0mStyHd5pzct5xfpBIdkcBVYL1vdhwPvf1yRs+QukW5UyJ8mgt1FuwQ+2fJV25tkS6l+Ni4h6KvkM+VS4CKHVzWAe2ARCWrNK/kamg94W6dzb4PYINs/ctwwM/NQgNWrpCGEnSWpFHptbVGjatjypdb8YgojxbUgbc/B7P+prFrUw13brmVSpxGInEgmNhT9urNqmGCcJc1qPAjPJuStaPaVUr28w122AZo/H6+xwzaVYt1uEEbFokcfeQQUEXmm9pKQq9J5fzowWX1pYhtz9UAemVNZ8ZFHa53TLiZ9X8Y9KGit2xgIzAGHALfEaNQRWSnW/uRo7R42mjlOvfuYAE53Ufwa/GNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(376002)(346002)(39860400002)(396003)(366004)(230922051799003)(451199024)(186009)(64100799003)(1800799009)(31686004)(83380400001)(7416002)(4744005)(6486002)(26005)(8936002)(86362001)(31696002)(5660300002)(8676002)(4326008)(36756003)(478600001)(66946007)(38100700002)(2906002)(41300700001)(66476007)(316002)(66556008)(6506007)(82960400001)(53546011)(2616005)(6512007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NFJ1Q0Y2cE0rS0JUZGF6SkJWQi9jdkRPRzZZd1ZEdEYweWlMbm5peWJWUjZh?=
 =?utf-8?B?OVlxeTYrWFdJY25QUXpaNVBrUjhMS3RCbUxtZjJ5aGpyaUhHYVAvNEtMV0lj?=
 =?utf-8?B?cDExMFIrQU00MEIzWlRONlY2VlZIUE5MZlhlUWlQMkw4ZEtkSmdGc3ZXMGE3?=
 =?utf-8?B?Q2NqT1ZSS09VSkF0UTRLUW5xSjE4SC9oTGt6U3JzYjdLcGcrcnp2WFRaUXZF?=
 =?utf-8?B?aXFmTWI3V2tCQnlnZ0VvME4xL2NuVnVHVWcrY2ZiMXQ5TU5odnhOdVRuWFZL?=
 =?utf-8?B?K0ZMZVZLVnVrSXpPRXhaakVtSkVaSCtkaDJ6aFBWYTdjdkVDbndZd3NURHdw?=
 =?utf-8?B?Q2FGbUxiRjNhT3A4Q3hCbXVhdmIzb3RMNURhY2kvck1vWm9QNDc4UmV3MUNy?=
 =?utf-8?B?Yk1DZ0d2Uk5jMG1HdW56bjhZeXJjaXVLeEY1VDlJZU9BM0wxWU9SMTY5ekwv?=
 =?utf-8?B?ZENEdlk4K1l2WmV6MGJwZmdnWVg2MUZsNnA3SCtyQWRNTnlPdWtudDhIV2Fy?=
 =?utf-8?B?REthUVhDTzE1Y0Q2NjZhckxXYlhEMUU2ekZOd05aczUrVkNpSW9sSGZkOW5t?=
 =?utf-8?B?WkJEeDNHTE9UUEdXdVRSVi9oeVVjbGRZekc1SzFQNDh6aEtvQWtJclBrK2lZ?=
 =?utf-8?B?dkM1aWN0ckc0ZDlQUmx3VXhVd0VsUkFDbVpMeVBqTSsybTJaWWV0cWhONlJ5?=
 =?utf-8?B?Y3lEUGZWK0VoYko5Qk1pRzUvRGZMNThOVXIvT0VKNmUzaWdnTUl3Zk1oTm1p?=
 =?utf-8?B?aVo2bzN3VEZvTUdQRTFhbVFqMGVYbDF2VElhdmFxVTNGUVp2NEI3dENVS3M4?=
 =?utf-8?B?RGlYTnI4NmRvQkRGbTUyQVBVWVBWeEFhUGJEaXVsTVUxUVpPV1hWVkNWWWh2?=
 =?utf-8?B?YkxTMmtkcmVmR00zaUxNYkNZaGZxMEJiT1ZyMzV6eUY1SUhzczhwM0l2ZDRk?=
 =?utf-8?B?S2xiYVlCbmJBQ2ZCWXJEaHJRU3dTZ1lWVmw5T1c3cmI5ckNpbllNalJzU2Ir?=
 =?utf-8?B?MHBBeUF4K0wvSy9uQ0hTaTk3V0tyYVpBcytZMXFkZGY4Tm0zc0xobmliTnBE?=
 =?utf-8?B?L3haYXRaQVdYZ3UvSXg1K2hERUVXRDR0cXRzRE9vSk1iTTg4Y2lFWHNMVDU4?=
 =?utf-8?B?eXo0NDNtL0JXWDYwbmsxZGpWRWtCd3JzSnJPTWpqU3JXMTNTOUViUGdEd0V4?=
 =?utf-8?B?RG1LQVgrOHhkbXdGdm5CeEJOblBJQSsyYVVTU2FWVG0vT3JmVmJMVElQM3Jr?=
 =?utf-8?B?NjFwRGhGWVIyaDZwazV6WFZuTWVJSERuYy9pbTNHZ1dUQWNWOCtKK3VOclhL?=
 =?utf-8?B?RmZNc05FZmNYRUpLZ1BmNllTRit0ZDVVK0VKdk52QmRSWWs3Y3NyY2hSSitX?=
 =?utf-8?B?WVBORHdvYXBNVXRvOGM1MzJ5L3I3akk4YklTYVhvOE8wNGp5SmVXWDFvb3JR?=
 =?utf-8?B?aGVOc3dsUVA1UDdxVFg0d21mTStpL2lOZU14MXlGai93QUJXdXMxbWdYSDEv?=
 =?utf-8?B?T3o0dkJTZ21EcFlTcUJsc1Z5Q1Z2UlhTc09VWGNxVmlrVEVFRkxmMVNBYVpx?=
 =?utf-8?B?Z3VuN3VtVlBUaEQ5RTZMVTY3SERoMUErMnROODNYMG5JWFZjdEhNV0RKZHU4?=
 =?utf-8?B?NEdTQ1ltOVI0T0U3SzNSeDdXMmUrbFp5ZEpia0lQU3B0dGFWYkJ0bU9zSzk1?=
 =?utf-8?B?TkRFWG1NaDVxTDZiVGZrLzV3cWZYSVJpZjBKdWc3dmdwN2RuaGJIM3VnOWlH?=
 =?utf-8?B?cThxT1JHYlJBWVRYcWQyYklhUVFtdVFsc0Nnd0paMmhkMmdUOTJyb2l0T1U0?=
 =?utf-8?B?YVYwVy9OS2VMWCtHaGJhVXRNUndNOFMrRW1pMUlFVHU5WEdZRGJxc2s2MG9l?=
 =?utf-8?B?cVRZaVpFd1d6NHNBaGFoT3ZRemJZdTN4N0dCSkcrSjF2aVFUeDJSR09YZzB0?=
 =?utf-8?B?bEplQmhiV3RFN3V3a0JIVWlzTlorV0JqRGZPNjNKbmVUOUxGMitIYVNhb2pO?=
 =?utf-8?B?RzB0c000V0FqK0lZVzBxWkdOUlFWdTBmckZmRG9oaHZIbXgwWTROL0oyWkhn?=
 =?utf-8?B?MThmOUd5ZHNKYWUwWGEvTG1BeVRwc1pBZUVFa2VGR2hxYWo0bGRTVnFOWVE1?=
 =?utf-8?B?NGlMcWhPbjdBU0Y5dUtiN2ljMFBWRXplTFh5a2M3WEU3aGh0WFZJVnBra0N4?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 34c01499-a5e2-4462-3285-08dbc119cd8d
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2023 18:27:57.1066
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bF1cqne/60AoVl/sFTC9fSSmTfl7EemI+/UpUvkgooa7sTEht9QSFM5P51/+JpMYAg7qgK24w+cAINCq5aTpCExd03WapR2q9aSeDUA8sm8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB8398
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
> The core is now responsible for allocating IDs and a memory region for
>  us to store our state (struct efx_rss_context_priv), so we no longer
>  need efx_alloc_rss_context_entry() and friends.
> Since the contexts are now maintained by the core, use the core's lock
>  (net_dev->ethtool->rss_lock), rather than our own mutex (efx->rss_lock),
>  to serialise access against changes; and remove the now-unused
>  efx->rss_lock from struct efx_nic.
> 
> Signed-off-by: Edward Cree <ecree.xilinx@gmail.com>

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


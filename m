Return-Path: <netdev+bounces-50316-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 03BF37F55AF
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 01:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AAD35281590
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 00:57:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE4D399;
	Thu, 23 Nov 2023 00:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="h3JhBoJi"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4061112
	for <netdev@vger.kernel.org>; Wed, 22 Nov 2023 16:57:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700701033; x=1732237033;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=94BdxZt24pEmdq5kgtILSlh7+9EO8wN2gCbpwkLB++o=;
  b=h3JhBoJi5Zxa/XE/gb9DSM+DWo9HXOQQDMBsmKiieZba9KRvn3re3j3q
   0/gswwo0AuIUWrjO0uQPVbfFqR/Xbckg2ihYtFMZzrcs8OXQFaWN9rRrp
   zbUoBVjjtHZoHDEfw5bO1BXLS+plnUBWdPlGrCl/aXckO/LDkK46H5NJq
   KgMcjNwTGV3Wp5LGPrUC07X6vOwV9udvr8fbKHP6pbkwoS1uBSYmhVEJx
   3jlvzyQI1+84828CM+2h3P7uDMw3qYvocECfuZauulB/EIHuMUfxdugRE
   o9j81dDwm4FsNrQc3N8N2Egw/JDLEMCQxxsGX6R/vE0CcTHEV6XHJ075r
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="396083218"
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="396083218"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 16:57:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,220,1695711600"; 
   d="scan'208";a="15162368"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Nov 2023 16:57:13 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 16:57:12 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 22 Nov 2023 16:57:11 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 22 Nov 2023 16:57:11 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 22 Nov 2023 16:57:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkcrJ4eiaTPS8sWPKMTrXFj/TImNP45hHiP2azLSWtxBwFieEdAELZ3JvTYPjaoAB9g7s+kVLWTKZ4h07AkoGtw0pGFYCSBBPRWnJw+/YURUnRo228/jgxkrhJwELDSBE+eQw3d7tXAxFyifdHGL43/yFUKyo20pCyZFZ5i/y8yBRv9YHWJlKbIGYOEZiI0Dqwztzd05xZw9iA7mJBIBIPkr0dWV/DPFDuDlIG0IpoT73ysjJGxj0WBbXVb3nocEwy+H2Fb/rv9W/1kS7dWwkFav0rEhpAJM0xh3+MXZAUNZzxxOYsj2tsKLEmOqgBOyAbA71JXTDT0sK3+vYs9s1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hKRMc/DC/Nz2OanULXXjpXGkqVYFmkMKvJraCkAMOD0=;
 b=Nye3HVVjA8CF9FzYu05Q7ICzyJcOBo8kqAwCN26LayH1poE3CPWdKTfE6BsdDfcPWVb2/IYYLqHh9SL/E7E8Gr9W9ElcX+04dJIBpx9LOIAIFEq37kxC1Vl19staMOOCDRCZLqxYCWlPlStn72MIk3p+lNZJVS+s1ddifqatf1Lk5sy1S88CA/R4s8t+Wg9vbyWWt7bZJjONL2CDPb7WnEQ/ttIoZ20JKf4NXSvzjpdDTk1KeX0Xv2DYOWUAm8MwM/H2S+9BcrkrVsThDlv+QHQMsSRbDTMVWytX1amHIEtwnZ0+H8XmFxWiZiwoOuT+llkDgV7Tsa11VAUeUTMJRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by DS0PR11MB7802.namprd11.prod.outlook.com (2603:10b6:8:de::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.28; Thu, 23 Nov
 2023 00:57:09 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.7025.017; Thu, 23 Nov 2023
 00:57:02 +0000
Message-ID: <a442e981-21bf-4006-9f0e-704fb2a1592f@intel.com>
Date: Wed, 22 Nov 2023 16:56:58 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v8 02/10] net: Add queue and napi association
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: Willem de Bruijn <willemb@google.com>, <netdev@vger.kernel.org>,
	<pabeni@redhat.com>, <sridhar.samudrala@intel.com>
References: <170018355327.3767.5169918029687620348.stgit@anambiarhost.jf.intel.com>
 <170018380870.3767.15478317180336448511.stgit@anambiarhost.jf.intel.com>
 <20231120155436.32ae11c6@kernel.org>
 <68d2b08c-27ae-498e-9ce9-09e88796cd35@intel.com>
 <20231121142207.18ed9f6a@kernel.org>
 <d696c18b-c129-41c1-8a8a-f9273da1f215@intel.com>
 <20231121171500.0068a5bb@kernel.org>
 <8658a9a4-d900-4e87-86a0-78478fa08271@intel.com>
 <20231122140043.00045c80@kernel.org>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <20231122140043.00045c80@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0275.namprd03.prod.outlook.com
 (2603:10b6:303:b5::10) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|DS0PR11MB7802:EE_
X-MS-Office365-Filtering-Correlation-Id: 41acf9c0-96bd-4b5d-b6fd-08dbebbf19f2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: xtxWtviHRNYToF/SYk1jjWPh54txk+C0Ha9qlGAlyOIdcq2V42l+3u3RZSvLky2g6AGw5eeMs0ZJFAdiIktnu7SB649PjkdMHKmcE1WLU1N5/SSl2grIAi4uyiCjjpXljvkcUJYETZWW3sjSe+br5//C5ojA0XYZ27MPhNO8FB2LIrAonapQmuwVPw508jcjdTWdTPn6Vq3HROwgKg9dNiruSMRCHrSalRViEQx6wx2afmV6A//OAOAAh3leqVELpmoLxFUSNWWh/7RnebAVsMUtjF8ybINrH+l/kF+yp2pdp3V3+5gLDuseb0TWuEER5Wi0ZfHK+i4XmZ+2qQut/h9ylen4ZTNw+SUFgFBcvmOArn7PZD6z8VBnSA96DMJPZM3sWB/l+7b3ZHW+zmm2cSnUcFd/z+N+0Y35hOC9rHlWh0sHe1OwDtkb0zqZpATZhXwWGfUiqNujfhG/Zi5YScGmCBjANfryJmkGv53MR42im8ruPWL3NTblVmsFKmfefzHIgBMbQzSKcnV9F/Vq+kbb9l9LahYiTsHonGWmiLi9S31wx9uRS6jOfY3OjlJ2f5I4uGc6Q9vSLmddCpFp9c+UnqLw++LloqqetHbljFr09Udk4lrZQNILx44YGl7aag5toXInrui/BWuidZcH5w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(396003)(366004)(136003)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(53546011)(6506007)(6512007)(36756003)(83380400001)(26005)(5660300002)(2906002)(38100700002)(86362001)(82960400001)(41300700001)(31696002)(8676002)(4326008)(2616005)(107886003)(8936002)(6486002)(6666004)(478600001)(31686004)(6916009)(66476007)(316002)(66556008)(66946007)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L0hIUWptK1c1WXYvY2kyTGFjd1VXaHJLODlPQm9yRWwrV3dNZ2FJM0hOT1hP?=
 =?utf-8?B?YVVTajVLUnlJTDAzSGpRbWhhb3pVN0dvb3FHZEZHaTNqM0FDTkNBRzNPUTQ4?=
 =?utf-8?B?Nno1RDNLdXdlSVZNdmxMem1xNmlZNEhLVFNzQVk5cEJ5RjJzTnpOUTJFdHlz?=
 =?utf-8?B?RkZaY0RqZkpsZ3hXaDdhOUppR21LNFZDOHY4Mko1YTdoYkdXVG5WVEF6MVIv?=
 =?utf-8?B?N1R1UFZOaGJEMVBSSERScElJbHJpS1E4dlF0MVNNYm9FNzN1NEtMeVAvd1hS?=
 =?utf-8?B?M2xmZ05CZnowdDJKVk5vVjZSZGVXOEdNaS94NWNBaUh2SC9icDBGcFJpeWc3?=
 =?utf-8?B?S1BFT0pTMjVyYS8wc0Nvcm0relI3NnRHNWdNYlhWQXQvUWkxcmQ2dms1Skh5?=
 =?utf-8?B?VlQwTjQvcU0yZTNzOHMvL2ZOb2xUOFJXTGFDQ3VGejEvRGdQODU3b0NhMTFY?=
 =?utf-8?B?bnRjUStZbmVWVEdWdzZhWldBVHp0aWpnRWttUGtTdFBQTjNCSHFhYjFzYkJx?=
 =?utf-8?B?SDc1dVpUd1FYWnEzeTBLNDNtU1YvcFZCZHFyczZQdU1meGN3K2poeGtQa3BO?=
 =?utf-8?B?RlorOW1FZnluZXJONmk5anlUbEpLcHVxTWllYUFBeFh2OEZHTDJQYjNiUTdF?=
 =?utf-8?B?STl6UEcyMjBHZXBTRVBjUlhjT2d3VnFBMHJsSk5EbXNpM3MyeHRjcjVRSzVB?=
 =?utf-8?B?SytTMXVpV2ViNWtsYU4wL01SdERRL1kvUERRV0tLQ2VjMlNZZys4VHIvcUZR?=
 =?utf-8?B?YytGKzcyTE9xZkJ2M25UWXBxcENZcXZTS0x6RVQ2Ly8vMG1qV3hyaVhKZmw4?=
 =?utf-8?B?UUw3aFlYcC92UkgyY1RwcUFFL1lSalcyaUdyQVFZc3hvTHc3dDg2NDM4QUFu?=
 =?utf-8?B?UTNpOG5wbHB6bWhQYWVDT3FJeHJHQVVnazgwbkZwZ1RYa2VETFRKaDNkMlFo?=
 =?utf-8?B?UjNWWEo3NzBncjVSeWt3QnZscGcrL3lTMkJBdkg4UG5EZU9xUmpHRThNam9U?=
 =?utf-8?B?Qi8wYlh3TVROaEN0ZnFsTzY0bmoxYXhqSWdacFdVOUJZbEtkL2RVM3lsVFV5?=
 =?utf-8?B?by9LMU0zYWNIQkVld0t1eFpnay9uOGpST3hFa3FKRmJ4aGVIVkhRdkErSkky?=
 =?utf-8?B?RTJMNGFlK0h3cmlOQVZMZnJCUHg5aW1tS2JXcFBwQ3VxQnAvRTFZSjZzK1Q0?=
 =?utf-8?B?NFA4b29keTJYYTlLZmtwL2ZxU2hnWVRiZmhVOGEvb3lwMnpyMDRtZUF6N2tP?=
 =?utf-8?B?bWV1STRpZmVEdUx0blhUdmpUUURBSGEraURjdC80TzdsQkJ4dEtNTm5ISTVi?=
 =?utf-8?B?bmNyZ3hnZURsN0x5WXUwM3RGNzluYzZuY1pJRFAwdUpNT1B0R0ZjVVV1WmtM?=
 =?utf-8?B?MnFCVHpKOXJIVmwxL1NHYWFsdTJhNldISVZjZGxGRS9sT2g1Tk1HUGtUcGpX?=
 =?utf-8?B?TW40cHpkbUphTDNFYTJRbnVXcGtFVXhkNWNoTDdOUCtTcWozNVFUWjJFd0tp?=
 =?utf-8?B?MXZiV2p6Ukdkd1l2UklpMFcyejllcjhsNC8xTk4xMkpIakdQSExYNEk3dWl5?=
 =?utf-8?B?dzluV0wzWjZzL1F1SUJrUmtRUXZXL0x4ZWdEZFEvblovcTd5eGdTODMyRlgz?=
 =?utf-8?B?bmNiVDdaTUFTTXlBdGNLbFRwWCtacXhBb0l2bmk0WkN6U29adTlrY3Z0ZSs1?=
 =?utf-8?B?b29hb1kva3Y2aTJpQVJtU2NFaWZoRlN1SGJkQ1pSN1dDaitibEl3T3A4Q0hG?=
 =?utf-8?B?Q1AyekwxNUJpRXlVbFNKUVV4dk8yVEZDNzNnQ2o2dTZYQVk4bTBjdmVpZFMz?=
 =?utf-8?B?ZXVscWsvdEUxT1dtZDhDRE51TjVyRUFocXRMYXJ0WWo1d1VTRWNvQXk2Uk9C?=
 =?utf-8?B?L0JWMVdKTFE3WEpYMHhnZmN0UmNYY3ltOUNtTmc3WTYrT0xIUVAxZHJpSTl3?=
 =?utf-8?B?MFZoTTl1V0tKMWFwTjM4NFVuWVZTdHJyYUVQUGgwYXNWQ05KckJ3TTVPWTZD?=
 =?utf-8?B?K01VSEJMT2JJQ3h4Q1ZEYVpFMTBYVGExOHdQYkRvTFAyVXlpUkw1MEdleHBl?=
 =?utf-8?B?Lzl2bG5lSW1YSERlTDhLMXhBUFZKUVZGR3lRM1FQWlkraHFtbXBMUERtRE9r?=
 =?utf-8?B?anBFSUdmam51dVlBMW1ZMVhKd0FPTUNsL2FlbnpDcCtZTnhMcFVGTDBMMTlZ?=
 =?utf-8?B?SWc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 41acf9c0-96bd-4b5d-b6fd-08dbebbf19f2
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2023 00:57:01.9495
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AtLGm7KQGvzKpHjrsaRrgrBTY49e+Z6I1BlkNASJRll9kHk9wF05+rf2szpBoT+QXA2rj0BB7nMol5Dvsn9HUSL5VJTbiwEze6fM509vAoY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7802
X-OriginatorOrg: intel.com

On 11/22/2023 2:00 PM, Jakub Kicinski wrote:
> On Wed, 22 Nov 2023 13:28:19 -0800 Nambiar, Amritha wrote:
>> Trying to understand this distinction bit more:
>> So, netdev-genl queue-get shows state of queue objects as reported from
>> the netdev level. Now, unless there's the queue-set command changing the
>> configuration, the state of queue-objects would match the hardware
>> configurations.
>> When the user changes the configuration with a queue-set command:
>> - queue-get would report the new updates (as obtained from the netdev).
>> - The updates would not be reflected in the hardware till a reset is
>> issued. At this point, ethtool or others would report the older
>> configuration (before reset).
>> - After reset, the state of queue objects from queue-get would match the
>> actual hardware configuration.
>>
>> I agree, an explicit "reset" user-command would be great. This way all
>> the set operations for the netdev objects (queue, NAPI, page pool etc.)
>> would stay at the netdev level without needing ndo_op for each, and then
>> the "reset" command can trigger the ndo callback and actuate the
>> hardware changes.
> 
> How the changes are applied is a separate topic. I was only talking
> about the fact that if the settings are controllable both at the device
> level and queue level - the queue state is a result of combining device
> settings with queue settings.

Okay, makes sense. Will fix in v9 and skip listing queues and NAPIs of 
devices which are DOWN.


Return-Path: <netdev+bounces-77598-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B85FB8723EE
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:18:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AA46DB21A0E
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:18:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67F271272CB;
	Tue,  5 Mar 2024 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yqb7wOM7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5CD85C7B
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709655491; cv=fail; b=EsiDmSjqDNEOMvX6c85MVY8svp1sHjRcZSzOzFYyBd/cv9SqlZY03BS/BaBVornXkGjItgI8rpWtwUw9ZysxF86ZByaNoXR5FDlmANn3dn0D1nKMdRjuVWvNmx7UxNI9+WNNkQezaelDwa6S3pggyynDFulh0MZcsVryoujaCXk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709655491; c=relaxed/simple;
	bh=7IwQ/XJJ+EfdeMSx6F5D2j15561kRf6DwiUaO/Z+bGE=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=rN8TZXc/qQDXERr7DSQSfJx/psRNHuNi7mQWnLJ9et3Pxm5L3XpmOdEhR0JiOztGJLdcSJrjhU3cubjgspnSL+H0YCf1VORG9yLUH3pJX0NbgaDULUYYDbPBx0pCD+NOH6VHvPlrwKpLJWnZtLovzBLxACNSEAG1Me4xnyx4c8M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yqb7wOM7; arc=fail smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709655489; x=1741191489;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=7IwQ/XJJ+EfdeMSx6F5D2j15561kRf6DwiUaO/Z+bGE=;
  b=Yqb7wOM7z0NaJGbDxNO3nJNI3PbznSlBGq5LLpE6KRFMnmkhlR8cPvUA
   kYyxt6yFauNkhKM66wBegdqCZ5b6tlugIjcT+9KFBMe4UNcdej9kKZLqq
   LtIf790vQDrkCpgqep40THAf+wayfYDsRiRlhFBXY7BqxY+3hgsHam/E+
   q9lVpRgx3B9WV7QSPRM7KFohZI2NCZL+ikV+/Oy3eDXU82lQClWzsbJU+
   LHeAC0tQCeOIXOGCfPkd55UZ6hTe+B0o65oa4o2r81M/2fNpnPF3vz3mq
   iIENpuAF9pAA9H7NJL+aBCyhyYWNRC9dWqJiN7hC28H7C0DjPvgxKnbEs
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11003"; a="7161183"
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="7161183"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 08:18:08 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,205,1705392000"; 
   d="scan'208";a="9532812"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa008.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Mar 2024 08:18:08 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 08:18:08 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 5 Mar 2024 08:18:07 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 5 Mar 2024 08:18:07 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 5 Mar 2024 08:18:07 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MrIzF1alTgX/LKBO91fBI0Ej/HuxIblZRl5txTTzLLjUAVRkq5sPTh9zJ+d9gw+N7Txto1RfrhjxzswTUcBgE3ISay95aoWCn1I7M0JuH3diMrN/pNROOhEiTSwZgJW95qDY9NYKjy4SIOnDCPaDuT2XBhMGLtQTDqm7JOsOspx34fu1DX5HqABxEwXjH9xdv/In39C+EuEjNauWIF+MZY8zN5qdnrzP7AykjMS61uOwRiGsE90ma9DW5+kD7K+jg0VBwmASgNtLpHSMmUUQiVQJtWMKnPYsIMonCJGn5RcCF+ANE5ufoFJklamoxE2RHWaVzSC0+S23xUmPNBkcjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZV7IonMS+L1WEimJZp41oBERQK+/jWpTG6o0zFD/uLk=;
 b=mqFVrW2lFgwNNUeKHQCZSzlvq2/pgwa/6r7cGHIDgakjLMZ3MndhLGL8w2Z2QHu9a46OzgtMIe3NwexJpWqYshE5bm3FAf8r9srZuaWSEP+BJD97vv5QAKxpLTx570JVp6CSIF1k0iO1WtrxjYriBROFbPe9V6e+jiDGoyKjsavRmT81SAQ4aPk2rFplmPtGqJZ8hwOB+dAPc9YOb5hTP/9WCydMAs+BxWI4OXIhx3Rf/p59qXddjwIxJnQ1Y6ZdmTBxJn7jjh+/Ee/vHE863noAYIC2xFiZTQ+bxk8+tBbgj8fx0HKo4hQxNEqc18orEW0TFP3+vk8CNtj0e9qDZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by DM4PR11MB6552.namprd11.prod.outlook.com (2603:10b6:8:8f::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7362.23; Tue, 5 Mar 2024 16:18:04 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7362.019; Tue, 5 Mar 2024
 16:18:04 +0000
Message-ID: <98ab73e1-c643-f352-b2bb-c3e5ed68a743@intel.com>
Date: Tue, 5 Mar 2024 08:18:01 -0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next v2 0/4][pull request] Intel Wired LAN Driver
 Updates 2024-02-28 (ixgbe, igc, igb, e1000e, e100)
To: Jakub Kicinski <kuba@kernel.org>
CC: <davem@davemloft.net>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
References: <20240301184806.2634508-1-anthony.l.nguyen@intel.com>
 <20240304205234.7f3809f1@kernel.org>
Content-Language: en-US
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240304205234.7f3809f1@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0312.namprd03.prod.outlook.com
 (2603:10b6:303:dd::17) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|DM4PR11MB6552:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff345bf-9c98-4ae2-c377-08dc3d2fd5d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AHwQejy9PKL7Waj6Y1wbivLDjL+OdbCCnVrpKJXjZTlMI9B4khX3NggJWnQOL6wTdbpfblbSoQUOFz7/W+v/74lCJap81VOCzpvRyYnw6nCip8tVQlyrBbrm1ZT4Ecfm6rKNFeyW1tkss6oeVN5oF0kQSJCcVojosy8CgJpA1EulKJK9x7b7nEfHlpotvTIpr9EucuB7Q7o6whObGv/fx6nWvfhMCouQEyqQGcDrMFUqq+czqLOYlKhu6dZ0bSpG7rfej7lmlzj2qPbNQX1vG6zIhYrVuV3F63oY4Jx0QGnHZOHMfR7vmgvRr4fHGGVU40l1O5lXAqiPqJRiakkX4NByf062Mal4M3emtwr0OAS4J9IvFYZf/nVzhVti10zasiaecokGilCdxozICpOCUuvv8PDfaAI29eLwKo95ErFhLc3zdMW+mT9WpVzezAZuZaWj2gdFPpdQVe1afmVmcwo4Wn5tSa1aTyq1dfxobjV8v+UMllYOMtjUWUU6hQkek4LYYzdbd0Vs+q05Cj2mMoexT4NjzgKDPZRTtFcwyitn/ZJ6hoSuozM3lbC8KE+/sSJf4crh2vmmzE+oqWtq58kN/yehq7HFO2Z5uoEbFLCycuBD7HKvzUr43BP360u+VI7pNk/mOYZZBeQmwG1UXiQUCLDiFYN0ijOysIDLEVc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V3psSWt4OTNRMmdkcXpOdVZiYUM4dWx1dzVld3JObTZsd3B1Ylo5TVNvTXhh?=
 =?utf-8?B?U29wSkt0ZzZHUFlxbzBtdEgrM0JvRGJhWkozUERJblc4alVOSzg2NG5rakJ0?=
 =?utf-8?B?U241a0x4cnZnczVqR2MwVXkrWGN2cHNKTkFYRGo0K3Urbm05T3Q3dkJUMzBW?=
 =?utf-8?B?R3RWMHBMb3NOUktYRnc4UzVUU0drMWtrZmdadkZ5ZFVVSmZOeGMvd3o0NUxr?=
 =?utf-8?B?cHE0VGVyVDZiaFprQlZLRE1qbnV3dTVDUEloWkRTbXdqWmNrQmhuZ2gvNGg2?=
 =?utf-8?B?bkxLanpQaWdldVUxUU1FVCtjMUFFbi9kV0tNR2hJYVQ5M21qSXMxQk1qQWRq?=
 =?utf-8?B?aU94b1ZQVm5MZVh1aUpRS2FjYURHNkxHMVFBMTVqSmlzTWRRTk1kcTdhN3Z1?=
 =?utf-8?B?NjZxR252cnpRVkw4Z3RxMG1EamNIN0FzZEZYbUk2SGhILy9YSWcxVVAxcG5T?=
 =?utf-8?B?VnZldXp5Z2xkTTJ6L0RXZmNubjl4NlpOYVh3SXNrZXRVS045YjNQUXBnWG8r?=
 =?utf-8?B?UCsrNXhqTGUxMlVkOGxyNlp2OWVIMlhZckQwRktWc0Z4THlVR2I5OHRCVDgy?=
 =?utf-8?B?czJocG53MU4xK1MyKyttQmFvNmdmbzZRQXlGL2FJMlFnT3Q2WHF3RjA1TjFy?=
 =?utf-8?B?M3NzemFMZVNrMTlKSk1uaTBSQVUxVHYzZUIrYWhvN3dtNjlWdC9MUHRMUzlZ?=
 =?utf-8?B?NjU2SUVJTk9KcG5jN3hPVGUwNUJkT21YUXVUb2ZaZ3d1N3MzajZ1bUQ3alhr?=
 =?utf-8?B?S1lJWENlS2JVT3RDN1NGSXZEbFkrNjFhVkVRV3Yvc29qUUxDMkYyWWQrcHhj?=
 =?utf-8?B?bmk3RGt3QkJIeEVmZVA0RDhxcVUyVEp4TzFBZXEyNmF4a1lwYjY5aTFDWndX?=
 =?utf-8?B?VGV2eWVla0tjc2MrSXpqckhCQlNlK0kwdFlwN2lad1lQWUhhU3pjRW4zNXFh?=
 =?utf-8?B?QzJVSWoxZUNxNDdOdnBxWEZWL1hnSEJDSllpNnRVYTFZY1MzblFNOHAvazMx?=
 =?utf-8?B?TDRDNEhTOWpFZHFSazFxbzlmZGZDYUplU204K1kvbFFxZzJlZ0pMYzZFdzRU?=
 =?utf-8?B?RzNhWEdUdHZIWE54SGwwZXovaTZuaDJOaGRUV3VVVlhVZHBORDBTOXhoM3pL?=
 =?utf-8?B?Z1o0eVl6b2xXd0I2UnNsRnZtZCtQU0VNYmwxdE9TQ29iUWs5VFloWnBkY3p5?=
 =?utf-8?B?d1RIeHJTMVJCWUZrcUpMVUpzNnJPUUxLbFFuVGpYaU1hNTMyYnJXMk5uamJP?=
 =?utf-8?B?Zk5EZnZJZlc3K2dJMHZ2cmRRa083cXdhaEJmWE5BZ0t5dkVYM1lwQXRVWnJx?=
 =?utf-8?B?Ui9iaEtGMGJjUy9PVHpQMTY2M24xNnZ2amxLekxFRUsvNjFyTFE2aXFUNXRH?=
 =?utf-8?B?Zi9yQm9mRHVlUm8xWlNDRGpEUG91ZDZZNVliRUpNMFUwWUFRQnZzTXA1VWdl?=
 =?utf-8?B?LzJUaEhMMnVmWEU0UmtrbDVjM1RraFhiaUJnL1YrSTFlWlVxNDdMRHZ2Uk4w?=
 =?utf-8?B?RCtCQm1lZUJLNFFoRThYZU5LVVl5UkFwVC9LMDNmWk5XZk5nLy9IYWRaSVBq?=
 =?utf-8?B?TzJEeUZUYzlVZ0VrYVlBWkhSQzgybC9LN0g2K0UvVFdNZ2JQU1g1RmFvVXN3?=
 =?utf-8?B?U1E0S1kwbk5pa3pyWEdNNFhwMWVPKy9sVXBwZm5tQTBWaGI0YitodGpQUzhU?=
 =?utf-8?B?ZGVUTWlOem00TmsrWXFoUEJzQ0U4N3JhTzlSb3hSSTFPZzQ1aXdIK09LVjVJ?=
 =?utf-8?B?WWpRekg2ZEZ6aW9QT3hDaVJNR3NUQ0hPWEVGcDNmdG9oR0w1VXcvRHJVdDVO?=
 =?utf-8?B?RTIwR0dkbUFBcXYzMWR6T25xbGNBazFaMzhrTVZwVXZILzNCM1JqL1J6VFpW?=
 =?utf-8?B?YjJ3eTFOUDg5MUlQVmxWWjVkdnZpcmhkQ1FKVmlTUTBvSmc0WmFEMjhuSTAv?=
 =?utf-8?B?K2tncG1SdXZKTklHSHdwQVBISGlVaXZpNW5CcWs3WlNNWFJXNzRHNmR3S1Mx?=
 =?utf-8?B?NXRISnVkOTI5VlZvcHlGUHcwUVVFdlRlbEhDSlp5MzJURmVYTUhZN0JtdzJQ?=
 =?utf-8?B?Z0hZV25HRjBNaldmNHYxZUtsYmNlMjNmb2N0SnVoK2NOUVJOWU5MSndaTldM?=
 =?utf-8?B?RXZaZVdGSlRQN08yUkRDK0VjRzZ5UmxmemdnMUlqUTcrUDhzZGpXUnJUczFq?=
 =?utf-8?B?VXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff345bf-9c98-4ae2-c377-08dc3d2fd5d3
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Mar 2024 16:18:04.2748
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1MBMQ2HPu7ali78/LX2M1qSuUHVWOI7jtAAMNilpLMHsHEurUWmjWBBAxCYLswAIp66IuTcq76D6aKFSgefGjDB0jhvcfv3tHEbgacufgEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6552
X-OriginatorOrg: intel.com



On 3/4/2024 8:52 PM, Jakub Kicinski wrote:
> On Fri,  1 Mar 2024 10:48:01 -0800 Tony Nguyen wrote:
>>    git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 1GbE
> 
> Branch is empty, applying form the list.

Thanks Jakub. On quick browse I'm not seeing anything obviously wrong 
but I'll look into it more to try and prevent this in the future.

Thanks,
Tony


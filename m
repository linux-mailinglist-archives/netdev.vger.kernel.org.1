Return-Path: <netdev+bounces-42704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C397CFEA4
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 17:48:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9A651C20D4F
	for <lists+netdev@lfdr.de>; Thu, 19 Oct 2023 15:48:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 55C38315AE;
	Thu, 19 Oct 2023 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Igeq/pus"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAD530FB0
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 15:47:58 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1397124
	for <netdev@vger.kernel.org>; Thu, 19 Oct 2023 08:47:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697730476; x=1729266476;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=gfP/iTQ6rphMmppoGcCiQW7XvEV/+CTyMnIb5DtW9o4=;
  b=Igeq/pusdL2/8VhyPOafzKq0xO+P8rX6ME4x7UrKEzzHq9BuA/pKKVAc
   Nv8xXsGLb/TvH+pMdczlJkXsLqlR06D6Ygmae2undk2V3in5b/ogsCvZ/
   e4udo5P9n/fI8H80wg+nyRlcg0rCRCJudDfYOuejfjBBwM9dAjX9UIzua
   ayT7r5rgX3GzPH0dpBXBTB++PfD+dzYPFO+Mf3Du+xAYdhCUuT6/64fiy
   Cn+Xx9iJUyUmO17fuO7Cd0xmcXBb0EACY4TGBQ9JBc4Uge7S8elTOjqJP
   mrIRHe51aAMfJob1hwg59Tl0dsPr2MmysSyFa/An/q/tpgZHHMfrQqIdG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="390173814"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="390173814"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2023 08:47:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10868"; a="900788719"
X-IronPort-AV: E=Sophos;i="6.03,237,1694761200"; 
   d="scan'208";a="900788719"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 19 Oct 2023 08:45:43 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 08:47:49 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 19 Oct 2023 08:47:48 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 19 Oct 2023 08:47:48 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 19 Oct 2023 08:47:47 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J/eeq46t8VUSwUrEEYoB8bhDCuRz0G+tl5YkCZtMhDqOSHNZCKPzJB9FULTAMDUDjlykblBoM1W7phY0EQ6PvhDaB4gadbXLtr/nx20AHvQohvcX85HswF3Ihf0MaUoOSbbxDBipuAN2f3P3050CPh1bEqVSzcKuYuxbIou5Y5ls8e/RTFe7V8zBI1/d3uSwIDqm+QrUCNjzxRBDhmFq0fBMyP4p/1LB70m8aFnkW7QmNDL6D2EZ4fq567ybLiNY23TlBMXRP/UGc4tU7B99C4o27TdcUDj7LSFVKPwTOWH9f5/zNQUWiuvY0ChKjZwWBRooExvnRugXNXHH+3AGdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNxRWJ6J8qWMMGROg1u3Qk5CzQAtYkQ4FvCX3Z5ryco=;
 b=P/0xMh8y4gXAdnsBtKqxcLFCrPlpNvl113r7uvcB4H6OigcQgzDAC30SPniimKH2Poe6twYu0VQluQD75Q3kHN3HBrnZ0rnjWN1ik7cVqh3XL4+7Lv4/huhXkA2HT0Gj3CZPHCduK6jDJvHBRyADuRdbk3UoHk9lgg7PdtGXvJdBF0htBUZEkErzdgbefynlBFNu8AQmLJHDkBa3TIDkrOua5QevpnLe4xPepNoMcezNfbjalwpneFFS/Y8Hb6d0bbposCbNEg1o2wGMzh4+5uGK69w99Pq9c5YskoAmh3xey5jj4Miz0TdsjjnMCwhg+Azxi7O0vCdsVwVN5fb8Rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5140.namprd11.prod.outlook.com (2603:10b6:303:9e::21)
 by CH0PR11MB5707.namprd11.prod.outlook.com (2603:10b6:610:110::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.24; Thu, 19 Oct
 2023 15:47:44 +0000
Received: from CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::db8e:c076:1c95:fb66]) by CO1PR11MB5140.namprd11.prod.outlook.com
 ([fe80::db8e:c076:1c95:fb66%4]) with mapi id 15.20.6907.025; Thu, 19 Oct 2023
 15:47:43 +0000
Message-ID: <412e63a7-278e-369d-1ed4-9d930770d9e0@intel.com>
Date: Thu, 19 Oct 2023 08:47:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH net-next] ethtool: untangle the linkmode and ethtool
 headers
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>, <davem@davemloft.net>
CC: <netdev@vger.kernel.org>, <edumazet@google.com>, <pabeni@redhat.com>,
	<andrew@lunn.ch>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<vladimir.oltean@nxp.com>, <gal@nvidia.com>
References: <20231019152815.2840783-1-kuba@kernel.org>
From: "Greenwalt, Paul" <paul.greenwalt@intel.com>
In-Reply-To: <20231019152815.2840783-1-kuba@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0058.namprd04.prod.outlook.com
 (2603:10b6:303:6a::33) To CO1PR11MB5140.namprd11.prod.outlook.com
 (2603:10b6:303:9e::21)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5140:EE_|CH0PR11MB5707:EE_
X-MS-Office365-Filtering-Correlation-Id: 73a60629-7e2b-4fd7-52c8-08dbd0babb62
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SL0z+6b6loWacDn4lOSOJYmUBeVytcHalL/U5AiMO6mCaJuvXwROokX7IEsURlodJTvhqY3zLrr0WwWvwuIdFRk9l28vLKKYNY3LvmFuI2N5gaI2WYnjkslklBzhl9jQu/nYoeSF/K8Pr8mLpDmlU8JlCGNxRqSPGaaS9xJuRYolMlgX+boQG5690edYoyNT3IaYSdYzzRxEW0IuK7yBHjmwdFppjLfcUhJCsC+R0+H9j87OK63zJ1lEC6sRuzJdgun9urna3ae23b60b1n5fxt7haQn9cp6w9+eXmdTa8SRlxiOluUQIoyt9E+abdQ+A8S9wGlN0LDz4b87DFtbgcY5FDn2kpe6T6D7DwdrJ/RWs6dG6A80hyH821U80uYS3dL9S5ErMidhPzgW+r9qJnl5Btj70ltkV9LwCEZn8EmIkFO6TN56LtNUNkAibFbhrsCqAdXxxKmvAEZvnlbc8CXxuALuU9ixMIsfInMz1yp419rAj8IgQUMw1ZWd0/gRRA/yqNYzoddwJIMvRjxwfmd6N4nqWGvsm4E1skBKMFV0yMglQg1KfolDQCayvl0EKjMAI8dCusZmyBZ+p9fBh3V2dHfVMhIKHfRhilAu6puDMFnePxazUoRQpnxohJ1bEgfNTOZDJDdiYaHMmeI3cQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5140.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(366004)(39860400002)(230922051799003)(186009)(1800799009)(64100799003)(451199024)(82960400001)(26005)(31686004)(38100700002)(83380400001)(5660300002)(66946007)(7416002)(8676002)(4326008)(8936002)(66476007)(316002)(86362001)(2906002)(66556008)(6486002)(53546011)(6506007)(478600001)(31696002)(6512007)(41300700001)(2616005)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bkFURjZBT3JEeWhLNzZkMGw0azN5Z1BUYzJpL3E1bVRVMHNoeGVLTzBadVZv?=
 =?utf-8?B?Y0hjdjlnNjc0SlpBN1cwNS9oZTAvVzNmSjk3V2djMFk4Q1hSeUVXWmRkajl5?=
 =?utf-8?B?K0FBa2xTNkJ1bXhXdlYxdElVRHJUQjNHaEtFQzQ1NXpXdlNYZW8rcVpjcTlo?=
 =?utf-8?B?WjdUODFzcU5xSy9KbHMzQTlDWmFjQzBTbFpVaUt1NmhLNzFJQm5IMkdhcGRB?=
 =?utf-8?B?b09sd1RPclFJVXRTQ3ZYMkhzc1JEMFlIK0IzTnZNNXdwR3YxdmFLa0IycGh6?=
 =?utf-8?B?MVExNXhoVHpkMlhxYzNzcUJvRVM5dGEvSUEyYjk5WWs1eDhjbXA2ZjV1VTBQ?=
 =?utf-8?B?ZDh0Ni9nTVJOUG5HWmVlWlNjS3VUTEpsQ25UTit0VCtWWHZtc3luV0RJWVJh?=
 =?utf-8?B?cVpLbG9zNkc0bVo0QTlxN2R1REdOaFBBNFVtckJ2L1duNGpQeWN3aVRFcDBp?=
 =?utf-8?B?UGdsZHJmZ1MyYXM2ckZkVzZrTm43ZnF3MjZyN2ZvMVdlUmZHb1RNUHBmOVlM?=
 =?utf-8?B?Wm8wa01oTU1lMkVMMU0zSzNjS1NJeTdRbkJsWUlWQnJxVTN6UzdZUTB1YlJN?=
 =?utf-8?B?eXpDSy9CMjMxNnhqclcrZmxCbGQwWmRZaWY3eldCWk1TWFMxUTVLZUN1NHNO?=
 =?utf-8?B?cWhXbjg3dlpUWDBkbzh4VkY2QjRWOCtaL2RaMWFyK3UxL2QzTzRIRFlkR1ZW?=
 =?utf-8?B?NktzakhudjUyZnNDT3k3WHdjQVBYYmVDcWlZV1ZzSmRBazhJY21BSjlvVENZ?=
 =?utf-8?B?MVF0cEY3US9hNjBPOEloQktPZWJpNWNEMHVpM3ZVekQzMTlVb2ZkRE1nU2hT?=
 =?utf-8?B?YmlqZVlESWRvSXhiWFAvT0lkVVRPMXhIK1FOR3NTb1lpWkJLejNGZVRSbEFi?=
 =?utf-8?B?V0RJcnJ5cmJyRlBJREhsWHB3d1Mzd0Ewa1JKQlhBRlREU09iNFlacTJVaEEw?=
 =?utf-8?B?amNjaDdHQTFSazh1YzVGS0V1THNhMkduNGdZbUVDNmZoRVUxNWRrNGdQVFY3?=
 =?utf-8?B?VXFKYVRuMGVQZjFRRFk5TW5KZ2J6TCtERjN6UDlHM0RhcTQzd090NCtyeTNh?=
 =?utf-8?B?blMzaDVSWm5iWXh1N2FHU1dlSkptL1hoRytDOWVRWXJtTnVEKzBYc3hyUWhp?=
 =?utf-8?B?TVVKb0RTUGhlekxVV244NC85MldiemZRTHFIaC84T3IxR3NhTWl3NTRKYnBK?=
 =?utf-8?B?WUtabzZvY0V1bDVJdXlUeHY3bVlmQVRMcUwwTklNRGc4OCsrcTNvN2grV24v?=
 =?utf-8?B?SkwxTk1Oa2o3S3VaeU1vVTVWRjY2Z1Q2ZkxMVmY0L1lhWmVSNGtZc1RYUFJ6?=
 =?utf-8?B?NVh5MjRRRmEwV1hsdTc1alVXVmVKVjhQYUdBbm9lL2Y5Z1gxUnZuaE5RU3c2?=
 =?utf-8?B?V1JCTEE1NitYY1NPOGV4aEk2cjB5U3VDMUtraG9nUnpVU2hGUHBSZXZOT0tG?=
 =?utf-8?B?NmNRbjFJOXhJQ2VqUW9yWlczdjNQdzRldXRiZFFWbVJRRUJaQTdkR3NDa0Qw?=
 =?utf-8?B?Nnd5YzVWSkh4RHplVUFyTGlTSCtmb0JZSkxua29BR3dJcithSHNoTVFLV2c2?=
 =?utf-8?B?NmZ2bGgzODdFVjkwYnB2SGNuRkE3TGM1bkYwWFZ3UEViQmxJSktLZWZxTDlP?=
 =?utf-8?B?NTlBUVpMK2RhUHlKaTA5SEZGcW5kSzYxamFrRHVpVXV2SndVYzZQQURpaFVm?=
 =?utf-8?B?K0NoVlc5UW9ITDZuK0xZdk42OUNXVmNWODFsNUlpMkt3eHoyTDdtSVVYU20z?=
 =?utf-8?B?Wnd6WVNEL3JZTkNhaUx6YSsvREhrSWs5UDlZZFhJZDJrQ2tYT2R1R2JkRkg3?=
 =?utf-8?B?M0ExNXhmMlc5ZkROOWpnU2g3WVRabHREb0ZLRHdGT3JRS3pyS3ptaTcyclgv?=
 =?utf-8?B?bm1iMXc0VTNYYjFPUXgzZDYvSjBFenVweGRuWSt3Uk5TQVRpbzBPMHpNeXFn?=
 =?utf-8?B?VjJzRlR0Q3p1WFdpVGVOMTZNaHpmRTB4QVA0M0pVU1VLdTJOTndCV2VCVEE5?=
 =?utf-8?B?dnc4K0FiclJrQk1ZVXVDZVJPaGxJV3lUZ2IzVDNpcU9vVmJSQXdpK0tCR1Nv?=
 =?utf-8?B?UlZYK05nQks2RFN0anZqSytxSDVxV1NCL1FlMHFrZzRiTzE3UlFMUW5McHJz?=
 =?utf-8?B?Skk3QTdEUjk0NUNEbngxQmdMeDNWbEk3QVBJUUw4aUMvTnc1U1FKZ2ExYTgz?=
 =?utf-8?B?cnc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73a60629-7e2b-4fd7-52c8-08dbd0babb62
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5140.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2023 15:47:43.0912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1w3z+d5CrMkWgAA9AS155XVx0iNU5Y4TOsmEELw1XHTIhhMRekHLPtTL2HdwNAUQIPJsVed4AnVHaIClQEDtQuste552MBp4OElO5XSn8wk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5707
X-OriginatorOrg: intel.com



On 10/19/2023 8:28 AM, Jakub Kicinski wrote:
> Commit 26c5334d344d ("ethtool: Add forced speed to supported link
> modes maps") added a dependency between ethtool.h and linkmode.h.
> The dependency in the opposite direction already exists so the
> new code was inserted in an awkward place.
> 
> The reason for ethtool.h to include linkmode.h, is that
> ethtool_forced_speed_maps_init() is a static inline helper.
> That's not really necessary.
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>
> ---
> CC: andrew@lunn.ch
> CC: paul.greenwalt@intel.com
> CC: hkallweit1@gmail.com
> CC: linux@armlinux.org.uk
> CC: vladimir.oltean@nxp.com
> CC: gal@nvidia.com
> ---

Thanks Jakub, this is better.

Reviewed-by: Paul Greenwalt <paul.greenwalt@intel.com>

>  include/linux/ethtool.h  | 22 ++--------------------
>  include/linux/linkmode.h | 29 ++++++++++++++---------------
>  net/ethtool/common.c     | 21 +++++++++++++++++++++
>  3 files changed, 37 insertions(+), 35 deletions(-)
> 
> diff --git a/include/linux/ethtool.h b/include/linux/ethtool.h
> index 8e91e8b8a693..226a36ed5aa1 100644
> --- a/include/linux/ethtool.h
> +++ b/include/linux/ethtool.h
> @@ -13,7 +13,6 @@
>  #ifndef _LINUX_ETHTOOL_H
>  #define _LINUX_ETHTOOL_H
>  
> -#include <linux/linkmode.h>
>  #include <linux/bitmap.h>
>  #include <linux/compat.h>
>  #include <linux/if_ether.h>
> @@ -1070,23 +1069,6 @@ struct ethtool_forced_speed_map {
>  	.arr_size	= ARRAY_SIZE(prefix##_##value),			\
>  }
>  
> -/**
> - * ethtool_forced_speed_maps_init
> - * @maps: Pointer to an array of Ethtool forced speed map
> - * @size: Array size
> - *
> - * Initialize an array of Ethtool forced speed map to Ethtool link modes. This
> - * should be called during driver module init.
> - */
> -static inline void
> -ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size)
> -{
> -	for (u32 i = 0; i < size; i++) {
> -		struct ethtool_forced_speed_map *map = &maps[i];
> -
> -		linkmode_set_bit_array(map->cap_arr, map->arr_size, map->caps);
> -		map->cap_arr = NULL;
> -		map->arr_size = 0;
> -	}
> -}
> +void
> +ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size);
>  #endif /* _LINUX_ETHTOOL_H */
> diff --git a/include/linux/linkmode.h b/include/linux/linkmode.h
> index cd38f89553e6..7303b4bc2ce0 100644
> --- a/include/linux/linkmode.h
> +++ b/include/linux/linkmode.h
> @@ -2,21 +2,6 @@
>  #define __LINKMODE_H
>  
>  #include <linux/bitmap.h>
> -
> -static inline void linkmode_set_bit(int nr, volatile unsigned long *addr)
> -{
> -	__set_bit(nr, addr);
> -}
> -
> -static inline void linkmode_set_bit_array(const int *array, int array_size,
> -					  unsigned long *addr)
> -{
> -	int i;
> -
> -	for (i = 0; i < array_size; i++)
> -		linkmode_set_bit(array[i], addr);
> -}
> -
>  #include <linux/ethtool.h>
>  #include <uapi/linux/ethtool.h>
>  
> @@ -53,6 +38,11 @@ static inline int linkmode_andnot(unsigned long *dst, const unsigned long *src1,
>  	return bitmap_andnot(dst, src1, src2,  __ETHTOOL_LINK_MODE_MASK_NBITS);
>  }
>  
> +static inline void linkmode_set_bit(int nr, volatile unsigned long *addr)
> +{
> +	__set_bit(nr, addr);
> +}
> +
>  static inline void linkmode_clear_bit(int nr, volatile unsigned long *addr)
>  {
>  	__clear_bit(nr, addr);
> @@ -72,6 +62,15 @@ static inline int linkmode_test_bit(int nr, const volatile unsigned long *addr)
>  	return test_bit(nr, addr);
>  }
>  
> +static inline void linkmode_set_bit_array(const int *array, int array_size,
> +					  unsigned long *addr)
> +{
> +	int i;
> +
> +	for (i = 0; i < array_size; i++)
> +		linkmode_set_bit(array[i], addr);
> +}
> +
>  static inline int linkmode_equal(const unsigned long *src1,
>  				 const unsigned long *src2)
>  {
> diff --git a/net/ethtool/common.c b/net/ethtool/common.c
> index f5598c5f50de..b4419fb6df6a 100644
> --- a/net/ethtool/common.c
> +++ b/net/ethtool/common.c
> @@ -685,3 +685,24 @@ ethtool_params_from_link_mode(struct ethtool_link_ksettings *link_ksettings,
>  	link_ksettings->base.duplex = link_info->duplex;
>  }
>  EXPORT_SYMBOL_GPL(ethtool_params_from_link_mode);
> +
> +/**
> + * ethtool_forced_speed_maps_init
> + * @maps: Pointer to an array of Ethtool forced speed map
> + * @size: Array size
> + *
> + * Initialize an array of Ethtool forced speed map to Ethtool link modes. This
> + * should be called during driver module init.
> + */
> +void
> +ethtool_forced_speed_maps_init(struct ethtool_forced_speed_map *maps, u32 size)
> +{
> +	for (u32 i = 0; i < size; i++) {
> +		struct ethtool_forced_speed_map *map = &maps[i];
> +
> +		linkmode_set_bit_array(map->cap_arr, map->arr_size, map->caps);
> +		map->cap_arr = NULL;
> +		map->arr_size = 0;
> +	}
> +}
> +EXPORT_SYMBOL_GPL(ethtool_forced_speed_maps_init);


Return-Path: <netdev+bounces-43108-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2D4E7D16EF
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 22:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 373F81C20F9C
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 20:26:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A155C249EE;
	Fri, 20 Oct 2023 20:26:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="F3B7mtz2"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C487249EA
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 20:26:48 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA8FA1A4
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 13:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697833607; x=1729369607;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=6Q4I3pwABEXWwZwWIMNNy2hecpy4faE6GDxIIK9gBW4=;
  b=F3B7mtz29E+NKtZWhJyNrQu8TOhQzniXq+mEkWD+QH32QKIDDFpL1gF/
   KF4JsgYJ8Q41rw2gax0zx/qXrxYlU4nhmQUVCZAX6EsjNy8J4DT2nZQNa
   zVDQ3HNl9W9LkaNqgaa5nTvnnyp7Ke5ss3Wzmh/+U14nvwLZiTOTWgnf/
   eCr4GGDLOPy/u+l4LbCSHEt62afY80zCM7hSw8sJZvBg5hlRnGQ9DHQ0V
   aenpjX/ZzcSROmvWC+iIpCPGF5YPyQdHNsp1Y0OvhYoxymi4UXAWeHhB/
   7fObHJNVbG13Yi4P8sQyFt+15GV+s2/dtFt+k8/HLGw1uS4asbITXt26J
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="383779486"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="383779486"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Oct 2023 13:26:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10869"; a="786889538"
X-IronPort-AV: E=Sophos;i="6.03,239,1694761200"; 
   d="scan'208";a="786889538"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Oct 2023 13:26:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 13:26:46 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Fri, 20 Oct 2023 13:26:46 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Fri, 20 Oct 2023 13:26:46 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Fri, 20 Oct 2023 13:26:46 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CQOTgYKJ04J20COCpVpn+FvVWm3sY/tenZbvEG6Rojb/lL3roAgdCh+k1/S0msnD20JEktWEDfwCFj6g9pXpwWvY3TMj2wMPR3c+vtRQkcJlGzarU5qWn6Z5GpvJxH0U03T4IVb+rD0GUi7ob0xwgThAaSeroWe4GMADnBqeVAywT0DZ/BgACE3QYBRZRGDFx2jRHfKKkDxavhBrqIEANoDlQehSKri3vd7dIrkTOctU9g1h6MmHmTvb6ayi/JeYLRptmnJjnS0z7t4/g/SofX56Pd/0cytqY/amo4T33vGEzyRpfXde2hbcrQBKPngmAJqJq67Y3xsleajG3Z/OfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5IE03chxrAwaD40Vd9UKeZXOnu7i71IPKzf9Smq+B78=;
 b=BZpH2XWEfZlSILEY39IPci5pL91ftnJMRNm6vRrbE9dMKBqgZ8M3MuaIYMW5RJT+txbu5NKvT6YUgW7ljR5mi/NUjvFA8oxTrKScjogwyJDO0x890z0ElBcgLuXvOSNJzz2jo0OIBsoGo0PYX6z2/eH43TLZaMczg9mJKeY+iKNGbqyUrM8tSfFA5SdIKq4Kzj9goB46iic57cLa6PoQI+ITeIVGJZYwtbgZy0G2hwSrJLOXHniNo0M7/DyEbJ1y0JoPn20h/saNZ1/xb0Qw8GhCZylY9Sg8nSzwnLQs+s4mqI1NpZ/WGKy+BPo6Kj3HXAE/WBw5/X2+kbgJDLrDFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from IA1PR11MB7869.namprd11.prod.outlook.com (2603:10b6:208:3f6::7)
 by SA3PR11MB7486.namprd11.prod.outlook.com (2603:10b6:806:314::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 20:26:42 +0000
Received: from IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962]) by IA1PR11MB7869.namprd11.prod.outlook.com
 ([fe80::7ace:90c8:4593:f962%7]) with mapi id 15.20.6907.025; Fri, 20 Oct 2023
 20:26:42 +0000
Message-ID: <b499663e-1982-4043-9242-39a661009c71@intel.com>
Date: Fri, 20 Oct 2023 13:26:38 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [net-next PATCH v5 01/10] netdev-genl: spec: Extend netdev
 netlink spec in YAML for queue
Content-Language: en-US
To: kernel test robot <lkp@intel.com>, <netdev@vger.kernel.org>,
	<kuba@kernel.org>, <pabeni@redhat.com>
CC: <oe-kbuild-all@lists.linux.dev>
References: <169767396671.6692.9945461089943525792.stgit@anambiarhost.jf.intel.com>
 <202310190900.9Dzgkbev-lkp@intel.com>
From: "Nambiar, Amritha" <amritha.nambiar@intel.com>
In-Reply-To: <202310190900.9Dzgkbev-lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0260.namprd04.prod.outlook.com
 (2603:10b6:303:88::25) To IA1PR11MB7869.namprd11.prod.outlook.com
 (2603:10b6:208:3f6::7)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA1PR11MB7869:EE_|SA3PR11MB7486:EE_
X-MS-Office365-Filtering-Correlation-Id: 6667257b-b29d-4c8b-0868-08dbd1aadeda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: bACEl9KziIrxu+xZPnnZZVLOI0AZlirUFEtNxM8GPL7rSrnNzcP/t20tBaLiz2GgnmDofZtu8OS0EBQRc7rIppeV7AnM6r75hPqo3RtWyGEARUYzDVUdVGMAXdhVz6g4zJp2EIIZbwYZXscJ81XAY6nTG5NkQKSlIFiRPMq78yjCHB9rflwDFqpGi7mgXVAiKagi0oorLiEEBreGgxid9fSdZadwzkKOma40Fp2a3baZnmOE95RqhKv9NqL5PH1bUmYXT4HECMF0uBkHe8K286dBY1V9GypCclm5dDjKqWL87DUzec3OMffpI8AhR4TJaRtuPl9cbIYXM13gRfJoiNSm6l4bEXBBmZJHrvqYTpz9TSrsi+DJx9hwDnAyH9W5TQ0Rftcd5s5NaScDvn/S6riZA5Nv+hHR6t55qZh2+xjK1T7g4MIhgJ/fa6Yng9GS7B1KLQaHjsbMLKEi6zJ6onGR/IKI/PQmN+sl1U5hXH+K7oPyvk1QsPQ1+0nbNkToGHYheGr9nLiJteScnKukWfmUGtvvLz+lppdSqE7IFHyhriTfby8NI7zjDp/sM33PyaedB7Wpczqo07JbcGt7wqJ3qkeuCNy01qAjft4C8FvdBr+5Tsyh4yg2+9U580psLYh/FhLZLIs8uYBJxzzbpKq5+UPSrUI2EJcPDLMlwY1GaAwM+GObi+42OuP5Kbs0
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:IA1PR11MB7869.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(39860400002)(346002)(136003)(230922051799003)(1800799009)(186009)(64100799003)(451199024)(31686004)(6666004)(8936002)(4326008)(8676002)(41300700001)(83380400001)(6506007)(26005)(6512007)(53546011)(2906002)(38100700002)(2616005)(5660300002)(66476007)(86362001)(31696002)(36756003)(66946007)(966005)(66556008)(6486002)(82960400001)(478600001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TFQ2SUpmSG1idWlPZnlIdUp6VWpFM1FYQ2FHRjIySjhLaXVPY1hzMC9xY08w?=
 =?utf-8?B?YWRmL0gxdHNvY0RrS05ya29ldlJpbjkxWnVreEZmRERrR0ZDSzJuOTFoV3pu?=
 =?utf-8?B?K1NpbDVWeWFlSCtteUUxM3VqSjRqRVBrYU9OUTNWdUhPRnBjK1I3cE1SQjky?=
 =?utf-8?B?czFNcmw1Q2d6ZHJDUExnQmV6a0RtQ041Qk9oWnFoNDlGUUN6SUV1QWRnMFRv?=
 =?utf-8?B?bXlBbjluOEhEcnpWWjc2R2ZtcFNKWGFtYW1kYXpvdlg2MlBYcjB2aWdVRTNv?=
 =?utf-8?B?TFpmVDZZWVR3Qmx5NkpMVUFGYTJSdmtpNk92NHRwZUZBMFBmWUVaMkhmVHhG?=
 =?utf-8?B?NHhiYWhPK1BHTTZRVkJaVitOWk1vVnd3Q1NCRDFKdEg0d2R2WnhUUVRDQVBh?=
 =?utf-8?B?SmVIak5nZ1lacnp1dzdBMkIyc05zcUlRWnc2R0R2bVdQaWI0eHFDMXkvRXVX?=
 =?utf-8?B?MVBweGxmb1JLOTkzVXBCenRtRnBNZzQ3dC9WbXRFMGZpdnJJRXhxREgydUlE?=
 =?utf-8?B?MlI1S3d2dXJHTU5hRG5OUHM1QUcvN0I5UElSOUFvM0FZL1BMQkNHYkdFRURV?=
 =?utf-8?B?cjhjSmEydkEzaU04V0tvYkZmcTFoeHNmaFZiaGM0SHRsVmhjK09rNHVHQXRB?=
 =?utf-8?B?bzNtTFZiUFByNmI4RFo2UmVQWTk3NGdEQ2xId3FBd0dPMUVXSFlsTER0Nkcv?=
 =?utf-8?B?MnlmTEZpaDdCcVRTMTZ2aFFxcUUxQmhsWUgrREhYZnc4UytDRTRKVWRmOVU0?=
 =?utf-8?B?UVA3RmtlTDNsRHYvdVFCS1hIQnEvNnRhL1ptNjRSa21iS1JNZzBwUWs1LzVX?=
 =?utf-8?B?OGVKMVVwbHpGRlh6cDQ3M3dzc3YwOHlEWnBxcDhqc0MwSEdJNncxZk5YTnlU?=
 =?utf-8?B?cXFEang4ZUwxLzdYVjJ4WVYwT1R3NDg2cC9JUE4vdzM1RTRTMXVndmljR1VS?=
 =?utf-8?B?aG5TZzBNdTVlY3hoOXNLMHRtMThhODJNY0toWTlHZEljV01DMjFENnRyR3RC?=
 =?utf-8?B?TkY3cXRmd0tLVmxZUUUyOHlPZytmOHlvVzcrRnFVTFl3cG1HM3JWTlBPNXFH?=
 =?utf-8?B?aVFDK2Z6SEpqTXBUc1lLSlZTWktUQ0lLODJiYWk5c254N2xITExudkhQQ0Q1?=
 =?utf-8?B?YWZQNks2MGk5TmFoMitYOWlqQ3FYUmJnbUk5Q0dETnVyR1VxVWJkKzdDYmlk?=
 =?utf-8?B?NHpjVElpaWdKU0c3ZzgzOUdJdmF6QmhSZFg0elZtR2FZR0d6eDg3ZE03Vll6?=
 =?utf-8?B?NjhyVENyQ0wxN0wxZGxYSnhTbGRpMXFPdHBIblZ5dEJuZ25nYmNuMExPK2Iv?=
 =?utf-8?B?WE8zb3Y5enRpSXdrWXBGdWp5N2VKcm9vclRkQk9kUDdvYjErRVpjQTk3ejU2?=
 =?utf-8?B?Tmc5eFZ2bmt0dTRna2hBK2Yyd0QyVWh4SytuRnZjZVQ4UTduZjZYZnZwb3lP?=
 =?utf-8?B?cHVTR1o3bjM2anpXdEtrY1lsMyt0WXk1dm5qNVNVQjJzZGdsdFdVZXRiaEgw?=
 =?utf-8?B?YW9TYkNvVVc1cTZqQ0wrdTE1U2VGTTE1L09jajRicnhmOUw5U0hkU3BoK2I0?=
 =?utf-8?B?TWpzbFpTWWdRRXllaHBvZ2RzQjRDOFpYcThKUTdoRjlEc24vYnVBSG9qR1ph?=
 =?utf-8?B?NGttdllzcEdOY0FkZERDa1lPaE9sRU5BQWFUajJreC9sY1R3ZUhXaHROY2V0?=
 =?utf-8?B?b0I1UUxnUnM1RDlEQ1FSb2gwWDdFOXpNd3NWb1d1aUtoK3NKVWRJN3dYTUFP?=
 =?utf-8?B?WjZiSVBzenBobEtUbU0rS0ducGo4TGxwbmVKc1BweVVhcWkrRjg1UVJxSjZM?=
 =?utf-8?B?VUQyZ3hDZTFha3dFbDhZWHhFOUZGU0tsbE1jeWt2bGlSeXJ0SmV3WkFMSkI0?=
 =?utf-8?B?M2VaSm42MFVNVnhMQTRBaktkMDNXd2szRmdxcFBVVE9TS2lURlRuWFBNblN6?=
 =?utf-8?B?Kyt4bXR2ZUhmbEt3Qm9ibm1XK242NHZXblNlOGZxNVJiaDVobmpkWEIyVVl4?=
 =?utf-8?B?a2dyVTVTckxaSVYxdHJhVkI0bzVtMkVWcFJYcUtvMjBSOVVxN0Y3L0NSN2Iw?=
 =?utf-8?B?L29neXI2YllyQTljNStBRkkwc25oK1JxMURwTWprdkEwWmhJR290bDNYNzF5?=
 =?utf-8?B?T3A2a2FIcmJUT2FuZ0NaTmIwcG9qMFBNSFd5R2s3cmhuUnZkVDloYWtmU1NS?=
 =?utf-8?B?YVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6667257b-b29d-4c8b-0868-08dbd1aadeda
X-MS-Exchange-CrossTenant-AuthSource: IA1PR11MB7869.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 20:26:41.8189
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+ZBSS/MURISDZXzFGt6YVvrDUEaKbin4vMfHit/OYouqsKHWJs72B9hTOeqwWXhdDO6yhqFpXvH0s0kgsdm+sTPZegUd1xVCaYi4BPeM34=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB7486
X-OriginatorOrg: intel.com

On 10/18/2023 7:12 PM, kernel test robot wrote:
> Hi Amritha,
> 
> kernel test robot noticed the following build warnings:
> 
> [auto build test WARNING on net-next/main]
> 
> url:    https://github.com/intel-lab-lkp/linux/commits/Amritha-Nambiar/netdev-genl-spec-Extend-netdev-netlink-spec-in-YAML-for-queue/20231019-082941
> base:   net-next/main
> patch link:    https://lore.kernel.org/r/169767396671.6692.9945461089943525792.stgit%40anambiarhost.jf.intel.com
> patch subject: [net-next PATCH v5 01/10] netdev-genl: spec: Extend netdev netlink spec in YAML for queue
> reproduce: (https://download.01.org/0day-ci/archive/20231019/202310190900.9Dzgkbev-lkp@intel.com/reproduce)
> 
> If you fix the issue in a separate patch/commit (i.e. not just a new version of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202310190900.9Dzgkbev-lkp@intel.com/
> 
> # many are suggestions rather than must-fix
> 
> WARNING:SPACING: space prohibited between function name and open parenthesis '('
> #547: FILE: tools/net/ynl/generated/netdev-user.h:181:
> +	struct netdev_queue_get_rsp obj __attribute__ ((aligned (8)));
> 

Looks like the series is in "Changes Requested" state following these 
warnings. Is there any recommendation for warnings on generated code? I 
see similar issues on existing code in the generated file.


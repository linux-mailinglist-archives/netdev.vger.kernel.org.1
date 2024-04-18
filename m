Return-Path: <netdev+bounces-88910-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 29D808A8FCD
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 02:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D26D1C211AD
	for <lists+netdev@lfdr.de>; Thu, 18 Apr 2024 00:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47BD019A;
	Thu, 18 Apr 2024 00:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gJ6Q3QU+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F17A181
	for <netdev@vger.kernel.org>; Thu, 18 Apr 2024 00:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713398866; cv=fail; b=WFj1IcZlxUpcl59x7QLbn8e+ysf+2YyYurA6ZPGN/mutOA8RuoDuG+mAldJ6pA6h0EqgMWjdWm6JbrfsShxpTdllRI5YUn/n1w1zC//fPTG533O8oqzRC0FEEORIqGcHRgaHHvESo6Wq5SoKuFGK1qlMvTm/qn486VbwD78u46o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713398866; c=relaxed/simple;
	bh=QV+1OnlFJobOifkTDURo48Byh4eueQPkmxjlKYtJPDI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=DGg1C7b9f7jKdtqYoQVZqKMNqELN8B6D641prfT51J8ad+3daSJurZXLd7H69i0/c5N1OHc6KzUE13Le3P+iZJbKd1c5dCbXgI3qLSmpJp5C+g4DS0X+pCv3bOhyKalTqNtmmkDXZHf9ykbmQTo6saQcpfhXkp8T4YKvD1pgmMM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gJ6Q3QU+; arc=fail smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713398865; x=1744934865;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QV+1OnlFJobOifkTDURo48Byh4eueQPkmxjlKYtJPDI=;
  b=gJ6Q3QU+YhI+O9IBL8hIG2lut7Uplw4iK5Q1cKJ5dYNiGPvtb6Edj6UC
   3s0A28I8pjHGnd7hS+oRDxAnqGVlmVm9Ma5h6itBiS3bp/1O/d2A6L+ZV
   MH+yGE+jOUndV1XiNCMuehtN0EKSrsoMfdRvatmPFhNuK+1275xieZ3Di
   ab+xnGNhJ88yzCBAIMBIaCaCTnTgAjBaBTiV0MyCw2O7F1UvDuzpziT8H
   /FWHHNODpgI+ChFnLkiq4gVEKHl/gseS/9zpR7dY/O8eoUVtjDiLRCDg6
   Kx0Kugh+XysYvim4hPMw+5COv6+01CKE4nnCO0wJo20c8lrt3ZW3Lz9/o
   g==;
X-CSE-ConnectionGUID: A8bOd2ccRAqAy/Km1u+Www==
X-CSE-MsgGUID: b7ZQ35XwRzK6fBNDZFddhQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11047"; a="26379493"
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="26379493"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 17:07:44 -0700
X-CSE-ConnectionGUID: WU5iA7DTSWK/M5e3I2FC+A==
X-CSE-MsgGUID: o7MKialuS6Ov73Ct37J8dw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,210,1708416000"; 
   d="scan'208";a="22834545"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Apr 2024 17:07:43 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 17 Apr 2024 17:07:42 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 17 Apr 2024 17:07:42 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.168)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 17:07:42 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LDNGv8w5m1rXcaG0miqdmywSC16sL+KZz0zCdgGnt2AV1wcoXn3ZTgjMQMcgNg5TOdFjSIxwaafRRgvFRTs6fQ6w09aLoxyU4QZRL427bA/r5Grpj0ZedbtntTtLJVl6PwjDx9C6Lbj5V3+thZgQhsSH+AeGBJUsWrgAhqoj7Dt2aKFlCVU1Fdww9Az8tzkViaesMUuoz2lvbeQVVTAOJNMkLmQe8nrvMalSE9FiOr/Wgxg/CLeZtn2nzswdJoYAVCKFnMawF8RTeR9hKPuRxxsaVrD2RyMLi0aPi/weY+YcZC0Ht28Y/wnn8WkZ+Pyo4YHo1y6d3m3TS3Kn2gWEuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=18Sux2s3Jgcq7OCdQYzj9xK65vqtCKG20fEkOfOLegs=;
 b=GHsdHFgF0SABE5UZtH4U9Kt16Ogzz2VxqcF1/HKv+Q4fOau67PzK6uF9MGVv/8Nl/CN/KLZtJIIGw1iPW9THH5V5PKfrl6IdTfO6wqaNxrHaJktHLfXrIcCmjiTargKW1rEq6OPz63BLGm9/tehDLcJn+hsAR8r8Xk6uF0WCNB4tv6kdyKhI6NJ8dNc3/jgiYl89fah768SQOAslSXYiRLogSmmnFeGOM9NFQQ5ElM7TkQmHpiUSIzv8K5O2DPoFm23OOyH1DWqt2VLRaMbuxnWs5Uw9UWSwEaJlhZv7q32Sw3VtRVThe7NUPnRpoKrEA3t0yqiOOCL4CLUzGhT3iA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by SN7PR11MB7668.namprd11.prod.outlook.com (2603:10b6:806:341::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.31; Thu, 18 Apr
 2024 00:07:40 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7472.025; Thu, 18 Apr 2024
 00:07:40 +0000
Message-ID: <2378caa5-9b1b-ca89-ca74-e9da91774e87@intel.com>
Date: Wed, 17 Apr 2024 17:07:37 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [Intel-wired-lan] [PATCH iwl-next v2 1/5] ixgbe: Add support for
 E610 FW Admin Command Interface
Content-Language: en-US
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>, Jesse Brandeburg
	<jesse.brandeburg@intel.com>
CC: <vinicius.gomes@intel.com>, <netdev@vger.kernel.org>, Jedrzej Jagielski
	<jedrzej.jagielski@intel.com>, Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	<horms@kernel.org>, Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
References: <20240415103435.6674-1-piotr.kwapulinski@intel.com>
 <20240415103435.6674-2-piotr.kwapulinski@intel.com>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240415103435.6674-2-piotr.kwapulinski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR05CA0019.namprd05.prod.outlook.com
 (2603:10b6:a03:c0::32) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|SN7PR11MB7668:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fb48c35-74c6-470a-935a-08dc5f3b8ff7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FfsQEH9de3XEwXqW7iJeOExn2sH3YFmfr1ETwR8GJrRZj6g5gsbYNboSCKv0xcCgMCwRiSB6j85scXhb6FDIpXddoLScAUUerEYmq6PwsJnMGudnAjY3FSfbC/fkfFtp6Ke9ohEW9DFH9yY6jEpp3sunO/b0qUwkJtjDE2Q0b7rVs7z9oUUhdS0Bq18mvLwOJ28wc3Svj+Z8P6a2wZ2oWwiiNokb8nT2ozILkBuYrfpQbdLdT6nTzBDA3RkLHQ0FnNctW3+u+gYxusB9XfBQUIJbNZsda1nIEan0iWKvgQ/eXcxOMLrX/qXWuGG1oWBR9O9EDtH6iInYU3N7gtCfjZfsbl/q/YdhuqVSDbGdCHVTiJKvzhl4r+RBgFTO9ZxbDimrwpRlilYtYztM7gMRgwFOiD29osxJbiQpE1/7wMfVbAbsSLGQdHTxPacLNtLe/ucjOmwOMPW/y7lj3cb5Q89eqGHl55CiIc7GN341rxXaqb8IeiwUSlQYbZQXzTgfNdbsaLFa15ufVPlqPaSBST/FqVJ453C2S3a2RBHjZzNqUwqIn6507V66l2QwaDOE2AFgAbVSMg6T4j2RCVjEqdLMw2ulW8xdlwuIsuahmWLFRAi03VdnfTzJOjx/oCtiXb/Efh4hUZyZXsytC6KkIU1Mvh/xrkmjqe4geUvlmpk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(1800799015)(366007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Y0xJT0tPcGhLbGMvbXVrZURCZ0YydTVjaGd4V3BFZ0ViZUZWN2NsYk93Rm5X?=
 =?utf-8?B?cndvWXl4ZHFwbkkvUk5GaHUwVUtJZHhqMkpjU1c2ajBXblE5MEhwRU1XbmMw?=
 =?utf-8?B?N2ZHVkxWblAvQU1ZOStBd1BKVHB4NkhKeXFJZVJVVkE1RmlOVmlLTTdIMHhr?=
 =?utf-8?B?MGthcGQxQWtjcXlqa25wVUxKY0dPWG1lYXlLcitrbHBqZ01ZSWZJY0g2cklx?=
 =?utf-8?B?eVNmTzNlWjlMeEJVa0xJaTU4bVZNVmxBaUViZmthcVhPb25TODdtNjJTN1Jt?=
 =?utf-8?B?bC9UNDErb1hpaUJFQ2V5QXVsRUs4V01kenRXdUNHbGZ3RHBXNmlTRUZKY25m?=
 =?utf-8?B?aHBNMm5jamYySWloZ05NaG5vSmd5b0JBWVYwV05LR3BKNUg2dVdjVkJXRjR1?=
 =?utf-8?B?NlBuZWVnVGhBK1ZHTENPbXFZMlBoVS96QTJkbmlJdXNkTnQ1U1dHNndMZG5M?=
 =?utf-8?B?YWQ2MllvUU91Rm1XVGtKT0RBREN4R2w4b2xLNDVNek9XeXJ0VVNuQlFOclNz?=
 =?utf-8?B?TXNsRURIOUt5SjRUamUzZU1DaEUzRnh4K04zc1JFQ1l3WFRybGwxUm5Ka3B4?=
 =?utf-8?B?TllEYXRmU2c0WFRlREkxM3g3Sk9waS9OdWp2VTgvREx3ZWVJV1dHMXpSQXo3?=
 =?utf-8?B?TzN6dWl2bGFMako2ekV1R3FEZWdFdnhNOVF1bjZqMkNuSmR1UVVHWWFLM3dj?=
 =?utf-8?B?UFoxcjd5TWxtV0Y4TkFseGZjSkY2cm9zQklrbnpwTUcwelVQVUl6MGxRZHVy?=
 =?utf-8?B?d0NtaTdvOVJ0ckdFQW1IMWpuZldmU2VpaU5CbitDV0xlMVYvRTNENjQxZkxE?=
 =?utf-8?B?bnZLWjY2b1BnL3V3WUY3ZFIrZjdZT2pPR09KSkQrZi9ZdUlDSWRDcHc1MWJD?=
 =?utf-8?B?a1F0eXdCd0w4SG54bnFQTFZHM3NFRWxYV0pyQXZ2cnlWNXFpYzg5dlJ5VWNF?=
 =?utf-8?B?TFM5Z1hEMTFhNW1GOHZwRTRXZlZ2Q283N0R4a2ZiVk9MYzNOK08xMzZmN3VT?=
 =?utf-8?B?anFIT0VmVlRPYXp0VjQzMktoMDZqZWJiT1dYeTgrYUE0QXltNiszQWRFWi9R?=
 =?utf-8?B?T1V4Q2JFWG04SGt5K1ZBRkU4VWRmaTlyQU1DTmE2bHRYWFB4K3FKMVF6Tm45?=
 =?utf-8?B?cGlwMkpTSU1Sb3ZrL01WRlhjcXJROHZUV2xpRlVoQnZhcENiVmtpbE9acURz?=
 =?utf-8?B?Zm9Xc3g3NS9zQzBIUVVwRHhsSDhYdmV3Z3J5cXJwemdLeFMya0dEMUJkbFlW?=
 =?utf-8?B?b2NwWUpqWkRYRUpDYUNvOEpTaW5IK1dHSTllQmd6Uk91eVFZK3FDZk9MKzgz?=
 =?utf-8?B?dVpnRmZxV1Q4ZENjcVY3Z2N3VU9MN0wwTEtEZERBbGhrRmpyVHJYdDJRWDNz?=
 =?utf-8?B?bDNweURFQ3lLOEhEU0NZV1dzVDJoUXJSNWJjRDBSYVFjWTlxanBRRFJBQ3dz?=
 =?utf-8?B?U1B2N1ZnUkRsVjVBbHFPbEZJSExOR0ZiYmdRNlN2UmxYUFBHZFJMay9sMXhj?=
 =?utf-8?B?T0NYUW1Qc3ZMUFRxMkt5WnZjZG5GbjdiaFVsbjhXQXdIRHV6ZHBMMUV2bnlu?=
 =?utf-8?B?SmpVYmdkWmVtSFZXaWZEc2JtTzArU2hTdTB6TDNjRDlnTXJDQ1hYTjc4cUsv?=
 =?utf-8?B?TlArUDdsMVQ3VmtqN1l2ekFsWVhpVk1vWGpQa0ZKOGFQR2FQK3lvZGx6MlMy?=
 =?utf-8?B?SHhmSkFqVTNyYi9wVFl2TGRRMkswQVNFZGRpdXc0VzVHdEpPN3FVZmF2ZkJD?=
 =?utf-8?B?bFk2cktkZU4rMjBLVVlVcjRrZjRBdWQ3S2ZJak9VZ1I4K2lINmhVRUlaTXkv?=
 =?utf-8?B?N2VDaGtMQ0ozckM4cWx6bzR6V09WNGZmdVRXUklKb1dqSjhVT2J2aHpwQVBM?=
 =?utf-8?B?bERQL0dRWGt6RVN0QjczaDNXTzBFZWFKY1lSTHVwdGZMNlVGaHNHQTlVclUw?=
 =?utf-8?B?OUtEUnBPWUt0MERUeTRhRWVIN2xoQTArNHpsZy9GWGlwbUlwb25mZ3RLOGZz?=
 =?utf-8?B?VnBXOUdYN2R4UHUrWFlyYURUVjBSSUtjdWtSUXlyczV0czdrazhQSER3Ni9w?=
 =?utf-8?B?V3VhZ2dCeGxQWUlSSWNhNEZxNEsyNVFSdFozNUtDaVBCcCt0NFEraGYyM0Z6?=
 =?utf-8?B?b2ZRYW1ET01IYWpibWYxUHRneHRkRGM3ZXRvK2V3V0pOck5ZZDFUVUZRTCs3?=
 =?utf-8?B?S1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fb48c35-74c6-470a-935a-08dc5f3b8ff7
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Apr 2024 00:07:40.4502
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ogF4n+9Kuocnud8X+7CYEwQMFZ99rymDD0I31V0EHdl3G4Anuy/9WEUd1kbTxKGhCtmp0dKpFINXy4myA72cSByEdywDl6u9JQ0wA9owUOE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7668
X-OriginatorOrg: intel.com



On 4/15/2024 3:34 AM, Piotr Kwapulinski wrote:
...

> +++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_e610.c
> @@ -0,0 +1,492 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/* Copyright(c) 1999 - 2024 Intel Corporation. */
> +

+Jesse

I believe the copyright on new files should be year of the file, not 
backdated to the driver's date?

Thanks,
Tony


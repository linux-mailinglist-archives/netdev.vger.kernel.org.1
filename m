Return-Path: <netdev+bounces-99485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA868D506C
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 19:04:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E7C01C2090E
	for <lists+netdev@lfdr.de>; Thu, 30 May 2024 17:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34E0A3D579;
	Thu, 30 May 2024 17:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nUSDSpUO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E75E335A7
	for <netdev@vger.kernel.org>; Thu, 30 May 2024 17:04:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717088656; cv=fail; b=G3lJgqDU6OiclF6P0pFpm+yVz+1PiZ9xTFdKjUb+TLxXEK4bhEd9ifUQ878vJZ5WKjmL/69Y8xraWZNSvGsrBJYLanWfN00sAaGYADIdejLE8l5JYIsjG2fcJbDcuSjv+ROKnbKr0MCu/50xNVCmesRaNH/Juj1EnmOef038A88=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717088656; c=relaxed/simple;
	bh=xm1ETeDNeA92n7Hjbt66GSFhxl0vuMiCSWgu/udc6m8=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=MhqlXiJLCfwhzorKEnk3/roaQlWI0iGn0P1//1U8dU9QTSqiBNY2rjDFLUzQcyrBFEJDIvEtRkg9XGOM/0TcWEp5waYLfOGTEYB1r6/NJwVT914IUp3y7fBJsOm78fWYBm3xOnryCGUyTWF4leymI7tHmgjXzQQu5HeFy+QBPLo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nUSDSpUO; arc=fail smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1717088654; x=1748624654;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xm1ETeDNeA92n7Hjbt66GSFhxl0vuMiCSWgu/udc6m8=;
  b=nUSDSpUO9fsnlW3bj/ErKIQiu+MS3Y8Efa26N++/bFBRgJrO5uy9gJpU
   F9jxrZqB68x59beyVLODoUuTlodhdC7OWWijgoqst0HueioKO37ORts/v
   vDxGIolmMFH5hh8Niq3PvwKbvF8kgOZ/T9JYeSFcTEK21c8aOMFa9THHq
   g9igBwZAANk6wis8s1zOG06bvr0M3yh/U2se2ctdDyhNo5EKPyo5pJ22f
   D9m5nEqngfwNx83VErEnHaQD3fSBNdlhHaK94L6FicxvmsdhhIueyX2VC
   YtqMCZXbpw53FQBiz0UE7NpolcrD08hFv5CQBsnCoZSJG8bgCT30NFYKj
   Q==;
X-CSE-ConnectionGUID: mG6DGzzGQ/KR8ZzMqMjjqQ==
X-CSE-MsgGUID: q08UpgUjR8eVgn/UZBHMrw==
X-IronPort-AV: E=McAfee;i="6600,9927,11088"; a="13721136"
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="13721136"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 May 2024 10:04:14 -0700
X-CSE-ConnectionGUID: v4kcr3L0Rf+arsTkhj49Og==
X-CSE-MsgGUID: uL/UVsapRVWaXd1tK3p9Kg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,202,1712646000"; 
   d="scan'208";a="35814679"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 May 2024 10:04:14 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 10:04:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 30 May 2024 10:04:13 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 30 May 2024 10:04:13 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 30 May 2024 10:04:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cnjpxo3OjjDgXIoo/ptuAWJu+Z8PsZRkAlNjkqFdacrtkeToYBtDHiyuy4mpqGp1xs3/kWGLQGdw23aU4/ZGMneuMyyA+y4CQeXOrVgeIq6GixAqlDvMHTVPvFsCKLMI/JPDtm5jCHOxbYyzpFvqwPiYDUeSMkDCyBLgpVkoOjL39oS1hd3D0gOa5cj8TNDEvD9uqZ67rmbr4ngMlQ/ZkSonD3QJEBuLpdtpsj6rPNdc6gCJKnAbTpFgh8qKdIxtXuI5Nb07ZIGR2KTxyi9oxoRv39wCWGCRrblrngk97pQUZrznQSJ56HIGY+0NX5jcGOXLi5GhFx4OpUQv71bJLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=agwupS+z+eHUbL4ZfV6pnAYGafsWHA8246xmLg5GDoI=;
 b=V2KZRZO2dRg0wWxuHAZjflhAjCkCY/vMJDb+SjFRpjavvph5f5KijSgRTubFZEJGTP1BBM+99mpmZ+yn1j4IAgILu11YnUq/GZg0G2Jtptpp440vRuQLzOf+irx3LzvL17FTxXcqmFi6B8nLEw2DNCvYmSswGFRpdwehp9PEiuKSPY788thtVp8q/M7nxBELndXGvKJo93jebEvNhCgenFJOxAm1l6IYzGJRjMiY1bZxxa9SA0d0DtG33wB4rQNynShqW3naIbx4z1KS+yHm9OVg3RojZAGQz2Knue2xCNRbJAb0xSnPWBdDT8mO7mcwgYr1YxXWPOkiukkcl2YsOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by PH7PR11MB6977.namprd11.prod.outlook.com (2603:10b6:510:205::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7633.21; Thu, 30 May
 2024 17:04:03 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.7633.018; Thu, 30 May 2024
 17:04:03 +0000
Message-ID: <17e68480-fc41-4174-b956-048c63c61819@intel.com>
Date: Thu, 30 May 2024 10:04:02 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 0/8] Intel Wired LAN Driver Updates 2024-05-28
 (e1000e, i40e, ice)
To: Jakub Kicinski <kuba@kernel.org>
CC: <patchwork-bot+netdevbpf@kernel.org>, <davem@davemloft.net>,
	<netdev@vger.kernel.org>, <hui.wang@canonical.com>,
	<vitaly.lifshits@intel.com>, <naamax.meir@linux.intel.com>,
	<horms@kernel.org>, <pmenzel@molgen.mpg.de>, <anthony.l.nguyen@intel.com>,
	<rui.zhang@intel.com>, <thinhtr@linux.ibm.com>, <rob.thomas@ibm.com>,
	<himasekharx.reddy.pucha@intel.com>, <michal.kubiak@intel.com>,
	<wojciech.drewek@intel.com>, <george.kuruvinakunnel@intel.com>,
	<maciej.fijalkowski@intel.com>, <paul.greenwalt@intel.com>,
	<michal.swiatkowski@linux.intel.com>, <brett.creeley@amd.com>,
	<przemyslaw.kitszel@intel.com>, <david.m.ertman@intel.com>,
	<lukasz.czapnik@intel.com>
References: <20240528-net-2024-05-28-intel-net-fixes-v1-0-dc8593d2bbc6@intel.com>
 <171703443223.3291.12445701745355637351.git-patchwork-notify@kernel.org>
 <caedbadd-1840-423c-9417-b9a2c17cf955@intel.com>
 <20240530095808.7d8c8923@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240530095808.7d8c8923@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0382.namprd04.prod.outlook.com
 (2603:10b6:303:81::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|PH7PR11MB6977:EE_
X-MS-Office365-Filtering-Correlation-Id: 8229b9e2-32ba-49c5-19f7-08dc80ca8243
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|1800799015|376005|7416005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RkJWZXZranBmY2FWNDFVa3lpc2NVMklEVHkvWGpQTzZ3VGtmK2pqemY2NHVu?=
 =?utf-8?B?K09pTGNXK3VBaDM3M0pCWFRmcWdtQlpUUE5hb2FWVHdONWZNOWl6VkZzemZL?=
 =?utf-8?B?bEFYMkF4QjVSS2FsUzFueHBTWE9VL0tjV2ZEenIySVd3UVYrcHE4L1dHSTla?=
 =?utf-8?B?OE14aHB1MjVPbVB4LzJ3d0FzWkw1M2RHY1AydkN6MVJqWURQOG1iYWgvUDRG?=
 =?utf-8?B?WnVkYzVvQk4wc003ZFhJQ0xOZXBFRldrSmt1ZmV0eFpiSnk2NXdDOXozU3lN?=
 =?utf-8?B?MUQyWUZuSjVFeVVsUnFlMC9UTThkUXo5M2VQVlVLQnpObEY4OTN6dGE4bUNZ?=
 =?utf-8?B?Z0xzVG9hcG9VM2VPSHJlZjdMNmpIVGlIY3dYS05vL3pUODJsWHJ4MENjT1M2?=
 =?utf-8?B?QVg2ZW54UWU0SXRGVnJWVnQ0MHgzUnd0dkR5bVkzQ0RnOCtpbFhodXNwcXdI?=
 =?utf-8?B?SjVCNnhEZzhQMk1ZdjE4TE45a0VCTXpPclUvYko1OGVqdGpPSVA1cjJZRUpZ?=
 =?utf-8?B?TithQXYyT0FLR2V0NW1nZzBCTVVsNjhXNjJXNDluVVh5ajIwZkNpS05Sd0Jp?=
 =?utf-8?B?MnBvSjJiMEgrQXNhSUVjV3dCNlFWcjBwMWJGczk4bUVGNU82bGdLSlpRQkFL?=
 =?utf-8?B?S0o0VjU3MmRieHg0bFo2QW5VL2FyTU0wWjRNZERUdTNOb2ZLb3JCUDhMUURZ?=
 =?utf-8?B?SzBrUHFOMjF0cEFDc0RJaStFZzFmaENzZ0t2c3hrV1g5U0M5K2NHaTNmWFZj?=
 =?utf-8?B?eWdGZmtqSFQ3YXVXenE2ZU9NclpTKzBISWRnbHA5ZHNrdTRuRGFFNllvd2R0?=
 =?utf-8?B?dHJOR25HbXZoMk00RXhlVDBmWDBwN2NDMmU0bE1EV29yTjBSY2EzalNqcHhm?=
 =?utf-8?B?VjNZM3dQRGQwRVJKSkJzTCtReGsyV09IYjF5cU5PUk5NT2ZHSSt5Wk9zbjFt?=
 =?utf-8?B?eXljSkZjV3J1cUVKQmNzTzNGM1dKZWUwcmd5Z0VOcXFIQ2xZZURqMmUzSld1?=
 =?utf-8?B?VU5QTTRQcFBhK29yTE5MSFJCUHNuUUcvV1JXSytKcHB1N251MVNxNlNrRkFX?=
 =?utf-8?B?NzEzemJrdHJWam1abXZlZDFRclJ2SjlGTFN4YS9hd1hJcmw2a2svdEVOTGhz?=
 =?utf-8?B?SmNjRkNWcXFTOGtPYUkrc1Q1VWVLbXVxaXBQT3V2K1JtcWJlSnVNYnJQeitr?=
 =?utf-8?B?LzJkRTcwUkQ1amZ5UXNLeUdLRDVKRGtPMS9LWW5HNW5Bd1ZkVTMwa3Fxb2ti?=
 =?utf-8?B?alQxakV0SnppWnBTWXhpMjZGT2drREEzbkRlZ3JnVklTSnR4MUNhOUJKbFFZ?=
 =?utf-8?B?MkIvQzR5RGM4bjQ4YUJDNFRkVlNZcFZxZithUXVUcmFIYWV5WVFEbzcwdlUx?=
 =?utf-8?B?Si9tZ01haWZzMHZjaTZuZUxQWHhhSzE4T005TDRTODNKclF1MUtxWU1EVUJX?=
 =?utf-8?B?Z2E5NnZSM3UvOCtQUEIxSEg3eUdaSDQ2dm15TlBSODBhMzlmaU1pOFBET09y?=
 =?utf-8?B?Y1M4SG9DTmt3KzNiYVY5cHJ0b3l3NXR6TlJ3N21CUFQ3ejBuRVYyMi9la0xm?=
 =?utf-8?B?d3h6V1ZyTFBMQkxiVlVvWG1PeGp2clYzNi92SlI2cXRackhWTFBnV3AzRENW?=
 =?utf-8?B?dGp2R0daSk9tNGFnQ3hXV1Z3VUExMUV5RmltNU1laWNGMHpnSi8yS242ckR1?=
 =?utf-8?B?MTVQZ2cyZFArQkJES080a3R5MHRUaUVGRVExK2dTNW0vYUd3K0VWRTZRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005)(7416005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VjZOYkRIdW01ZmpFS3Q2TTBKNlAzK281bmliTEwxeVFPYkRDYzMwWFRRaFZV?=
 =?utf-8?B?WXBidnVEZElnazZSZ3NIZTd2SGE5SjhqcHdQWGpPOGVrbUp6RDRrQ3ZsQTI2?=
 =?utf-8?B?cmJkc0xlSW5ONHUySytYa3FVTSt4VnJYTXBRelBxbmNnZHZnaDRJRldZWWZs?=
 =?utf-8?B?K1dJZ3FFV1luNFJIM1liNGRuTjMvV0RNRHlDc1RwZjF4SDVxTnVWdnJWMGhM?=
 =?utf-8?B?dnlxVHVWVXFFcStERU9sVGtIdklrbyt2MUpsVU1vUFZxcVNsRGVWRDhDLzMr?=
 =?utf-8?B?MUt5T2RYdTVaRWhjUEo0MVJDMkJpWWtURURkWDBRc1ZIaHR5MFhLYnFvWE5L?=
 =?utf-8?B?MU5qU3pHQWxTQ3dPWE56cFowOUZDRUZwMGdLTTFXTlQvVEF2UTZjbkNiQnU4?=
 =?utf-8?B?Mk9manIwM0Z0d3hYWDJFNFZ5UHdHQ1Q3dStFN3M5eThDdnVCZ2JwTnB0NzFs?=
 =?utf-8?B?M1lybVJlRlZmNjhHemdGajhYdHhzRzhPUXUxNVErbGprN0Zjd3lwN3RkN2lP?=
 =?utf-8?B?ODVSUyt2NFN6akpVZ043MkcwWUErc1FrMVZPYUk1dXRDUkVxVEZOZkMwOUl5?=
 =?utf-8?B?ZUZ3SkVHbis1WlRaWktiQTVScEdqb3ovZU14YVF4dnRaUERHL0FLYStNM1lq?=
 =?utf-8?B?ZmNEc2tTbnFsRmRqcXB0QjRDcUN5WTI2cWZLNWJjN3I2Wk5HT2V2blRneWda?=
 =?utf-8?B?YVF4KzNPNzV2Skd4ZjBqdTdJY01rOUNKOTBteG0rKzJpMlBXTWpaTTUvQi81?=
 =?utf-8?B?M3ovVFY3WElzTzlRcXhJKzhFL0RJeU5Ub3JQYTFwaDBZOVFzUGorcHpRb09S?=
 =?utf-8?B?Y21mZ09NZkpTUEZYTGZzYzZiYmdYM1RxZ0Z3ejh0SjdzZHVxcllITVA1ODNs?=
 =?utf-8?B?Z01Kek14TzJJcmtkWHlYMThLNVJoNGQ0WVFtOTBQNDNPdFNaOUtQd294TCtM?=
 =?utf-8?B?K2VBTjZUc29uemhwRy9oRWQzZXVvNzNETWF5ejdBUVZqMEFCdVczMzJFVmp3?=
 =?utf-8?B?bk5GKzdWTmlKZ0pUeHMvdjhXanRFa1N2aklKUXJLbGFYbHRXSmZvSG9wbGdJ?=
 =?utf-8?B?MWR5NEx5ZDZ0QTBtdkVpcFl0VXVzUUZBVnBKZ2tTMjdWb3FydXhqRUtMLzFC?=
 =?utf-8?B?WVorUHNLREhQZzRtNThNMzFhdlA3R043Q2RidXBBSHZSSVppOXJ5OHdPcGJR?=
 =?utf-8?B?anVCemdsdmgrSHc3L09ZS1phc1N2NUhKUC9WOTQ0UGJnc3gwb3JyYnNLS3BG?=
 =?utf-8?B?eU9XYitBYXVPdXJVb0hFOURzZDFqL3ZQRW9FcFBLWGo2NTRNSVJ1c0RKcFN3?=
 =?utf-8?B?K09WaVFkR3BkTHRCZWozUTJNYUhMZ1pQbHFqbndMNng2RmxQbk02SDhtUyt2?=
 =?utf-8?B?ZndUd1drQjh0dzA0Sy94dHlhc3NqeGhpZDJFRmorMjBRc0hYWFpqaEp2UjlF?=
 =?utf-8?B?WDQrVUVza2FxMk1WWGFPaGYxZjc4TkNWTXVReVI3ZHNtZjBkV1dib0hmRW9X?=
 =?utf-8?B?YjRnZVoyemxhbS8yK2Fhc3Vuck5sK2g2QkRBRjA2Q0JYSEpHVkdFb3dOOWRH?=
 =?utf-8?B?ZW93WWdKaWwzM01LdG8xb0xabUY5ek43Ykoza1VQL1FFcmxvUW9DZUN4M1lP?=
 =?utf-8?B?L2oraWxvUFoyLzRZVi9KeWNYTkRkbHE2QTRkMWRKeG1kQWQ1WVNaelNEZzhU?=
 =?utf-8?B?dEtqV0NZQTRSbXRiK1dNazBMWGhjY21PVHozMm1scmpPcy9SSURQZ2p3QnBR?=
 =?utf-8?B?aExjd3RRSmp1NjRsMjBZZkpweVFISm5NY0VGVUhhTEdZcTNwYVdHMmttZE0r?=
 =?utf-8?B?TlJRLzVzRWFaK3hUYUlnaGdKTWoyWTlRRFNxa2xTbG1LbXBzS3dBOGt6V2th?=
 =?utf-8?B?NGw5YXlmUFhzQXVzeUZqUWZHb0c4WXNyam41UzFaaTc0WGRiTTRyYUJ0M3NT?=
 =?utf-8?B?cDhkTlJZa3hQOXFNbkNicU1VVStRdmpabnBvZEN0dG5LNjZzT3htRFNOS1Bv?=
 =?utf-8?B?RDZrUGppUGxRdjNmb2VENWZXVjJjZitsV1pXaW51T3hpNWpDdDFybm1vcWFE?=
 =?utf-8?B?MjFyc0VySnRETEhoVnlOM251bEtQZEE5NHJBVVlXQkpVUEhQc0Qxa0dhWTZH?=
 =?utf-8?B?UGNXZ1M3S242SDhxVnhjd2hqS0FrdG1qZjA0M3o1SFZYUkt0ZVBubWhnM2Rw?=
 =?utf-8?B?a1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8229b9e2-32ba-49c5-19f7-08dc80ca8243
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2024 17:04:03.8215
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FlqggPeY7phMQhXD0gSh/tLuBagktCVvzmfOHBCH8B6Jbd09O6hUflaqa5s9p260dcaOgU9CXdToti0q5MuB0fPuAMYhJnFjM5GzmwdZXhY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB6977
X-OriginatorOrg: intel.com



On 5/30/2024 9:58 AM, Jakub Kicinski wrote:
> On Thu, 30 May 2024 09:45:29 -0700 Jacob Keller wrote:
>>>   - [net,7/8] ice: fix reads from NVM Shadow RAM on E830 and E825-C devices
>>>     (no matching commit)  
>>
>> I saw this one didn't get applied either, but don't see any comment on
>> the list regarding if you have any objections or questions.
> 
> I wasn't 100% sure there's no dependency on 6, better safe than sorry?
> :)

Sure. I can include it in the next batch of fixes. I think we just got a
few more through testing yesterday.

Thanks,
Jake


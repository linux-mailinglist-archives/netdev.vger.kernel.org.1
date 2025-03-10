Return-Path: <netdev+bounces-173680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF290A5A626
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 22:28:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F32B3A5D12
	for <lists+netdev@lfdr.de>; Mon, 10 Mar 2025 21:27:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE0991DEFD9;
	Mon, 10 Mar 2025 21:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="M2dQ7fjn"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1917A1C1AD4;
	Mon, 10 Mar 2025 21:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741642080; cv=fail; b=WSaH9FHYrRSkkGio9O2wMjqp8rO/NkxTKl2E/vM6GtJJmtKPgYkhGvbCPleYmoB80L+UqQ2O6nPQu71hkvZiEQssxqiC8O9pz90WPRVuztDsSrqJI/OpbQ7K3nFb+b9D/btIt2VtjxRK8lPoJW/NmWysoBVAf8abK0Cy9sQluNk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741642080; c=relaxed/simple;
	bh=IcIxLatFsxzKGMg7EXsspK5t2aqIAgNgI32fYvvVFK0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=A1Xmc5o15gRnC4xXkwNc98Wqp+t8vujwIP7FU+YTdSfqIXmoKyP5YIycdeSOyhWZWtRT1PXGps2qohq26Bs1NJkcygPhvlUfdhz9bh47UQdoZKrOBmhCZanlcsg3ciioa8bxjfdpnX+Pl3y9s6cllX1LWzVEc/SHCz+fxNn1Z2c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=M2dQ7fjn; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741642079; x=1773178079;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=IcIxLatFsxzKGMg7EXsspK5t2aqIAgNgI32fYvvVFK0=;
  b=M2dQ7fjniJNXJ54CTWosdUov5bxEhEopIVlEZ4n1DYkykSKeIpYRfFch
   k6UjLg2zYsK6MZ75bchtSr6+wtMtZwbL8TJSuUZBdP28mqSezN3Cy8O5F
   N0v2o9FkOqHJ6rd7dknAY6Z9D/DwyfMb0YCJeCrpoCymYiojrllfWUkjJ
   FGUKyd0hPDaiNCls93YsSz2uwS8vcZa5ACQkY9nm6eg5UkJnbeoQs5ADg
   s8nCXlcmdPLZTzh/7bZtWG/Un31S8ibct0D0wjLveU+ZCRUCyaubBEWMH
   Vt7+f6Of1KbaKFSsyZjHxcm3voZBaRGcWxIt3b8mFsbbknoe2lhZ5zn8O
   w==;
X-CSE-ConnectionGUID: teSIigZ2ScqfDIyRC9rTHQ==
X-CSE-MsgGUID: ymG3JYekRqG0WFlh7t8H0Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11369"; a="54034050"
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="54034050"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 14:27:58 -0700
X-CSE-ConnectionGUID: rcYgEvMZSESFSGjKmfpIaw==
X-CSE-MsgGUID: AD4yVOp7RJ66EYK8y5r6jg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,237,1736841600"; 
   d="scan'208";a="150905173"
Received: from orsmsx901.amr.corp.intel.com ([10.22.229.23])
  by orviesa002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2025 14:27:58 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.1544.14; Mon, 10 Mar 2025 14:27:57 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Mon, 10 Mar 2025 14:27:57 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Mon, 10 Mar 2025 14:27:57 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x57M5g/YgAnqrKZZwcONW/pVV6E2vnhNaqynTR6CMwhQpGT3SiuSK2pSnjO/XEMmU1Ew4OLv7pJzstv35Cjc3oKA2m/MfhWstwPW9mc/9f76m8ZAwVMwNOpCWHbaMIu6z4PCtCA/5WrOjT/d7MOysSuzuERjU4y8wHRTLG05Rf1RXnctwfF5C/GhvwyhicO/UuMJwIx+dlMS3SEAu/Jd8+m7i+gYV+QPeys5upMLElzFbpk16GreFEtbaBWfJKZNot3Gk0yeAu4Jxr5EP9NYW93Z9fDZ1CD+TIS3C/KQ8LaG/u4ZRS9XjmHYGbg2D699ENiI/OWRYop6Gv7Aq8ojtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tVEV1lqJEsMpJJKVcKEYLw4sg1QQt9W/EX5nbnK3+cE=;
 b=l/W52QwwTfgb8pBhoH/3b2vKpIVYvKCn3sj26FRWyF/GeyYA2O+sn7yfhdpIAc0CTrGLdRNIvsBLQa8aqLifROL90kSApvy2psSfs3NToG3pEb3VlPLVA/DVMuEMzfnF9KoKGVgDbaijGfG0VowMS40Pm5FgKX0KLHG+w26ugMCvInntosBjF9REqC6OTZsnTLOxG5jQr2BHH8C9Bm8Vo8AG5przl13a+/cmJgZD+VXPd+PoRIPAmYeC2HJ9kdNA0N+OzIUSxYaSIWAJps0HqG4qh0cn3IyHVUb7QN5mxNDL1Imo3o+9ibvK+gwSOVz+JgLyvYb2ehf4FWQ7HrFuUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB6423.namprd11.prod.outlook.com (2603:10b6:8:c5::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.27; Mon, 10 Mar
 2025 21:27:55 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%4]) with mapi id 15.20.8511.026; Mon, 10 Mar 2025
 21:27:55 +0000
Message-ID: <412a7fee-daec-496d-990a-642f2787d5cc@intel.com>
Date: Mon, 10 Mar 2025 14:27:53 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: Plan to validate supported flags in PTP core (Was: Re: [PATCH net
 v2 0/2] Fixes for perout configuration in IEP driver)
To: Jakub Kicinski <kuba@kernel.org>
CC: Meghana Malladi <m-malladi@ti.com>, Richard Cochran
	<richardcochran@gmail.com>, <lokeshvutla@ti.com>, <vigneshr@ti.com>,
	<javier.carrasco.cruz@gmail.com>, <diogo.ivo@siemens.com>,
	<horms@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<davem@davemloft.net>, <andrew+netdev@lunn.ch>,
	<linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <srk@ti.com>, Roger Quadros
	<rogerq@kernel.org>, <danishanwar@ti.com>
References: <20250219062701.995955-1-m-malladi@ti.com>
 <415f755d-18a6-4c81-a1a7-b75d54a5886a@intel.com>
 <20250220172410.025b96d6@kernel.org>
 <a7e434a5-b5f6-4736-98e4-e671f88d1873@intel.com>
 <f7072ca6-47a7-4278-be5d-7cbd240fcd35@intel.com>
 <20250310172541.30896e20@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250310172541.30896e20@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0168.namprd04.prod.outlook.com
 (2603:10b6:303:85::23) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB6423:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f35f645-ad45-4f0e-2f1d-08dd601a6bd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|7416014|366016|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?bU5HcW1MMjBVRS82dVpwODFXcDU4aWcyRDRwVkpIbncyMk5rZnRheFkwY2Fa?=
 =?utf-8?B?NnBjQVlBc3czRHFENEJ0TG9nSXYyZHgzMXRHREQ4blE4NlR4NllpVVk5L3pJ?=
 =?utf-8?B?anBta1hMUTZyWjJwcFpaVW1RUjFQSWErd3BoaERMdUZZWkNhbEtXQWZwYjcw?=
 =?utf-8?B?NWdSemhlKzVNZHIvMi9OdWdEaFIyR2pTa1JNT2ZneE1tUjBrVHBhTjFZMnhN?=
 =?utf-8?B?TXRqaWJXTVBkOGM3SWFtVTJaVThYVmNxWUQ5b1lQV2ZEa0xJLzFRSlJ2dWNn?=
 =?utf-8?B?dGRwNnVOalRzYk1seVlRSUR3NkN3d0Rhb0hHNnNNYTh5N3pEZytRNmxvZDBS?=
 =?utf-8?B?bno5SjR3NzRuL0hGZDNCMFNzTW5IN2s3cENDanViTmVqa1BGbkJ2Tzl5cDYz?=
 =?utf-8?B?MGh6Y2dKVHVXZTBQUnFHcDU1blkyV215bmV5Q2pYQVk5cldCdU9QWE9Mb2No?=
 =?utf-8?B?VVl1N2hlZEg2V0ZYNmZ3YXVYc2p0cnBRY0tJRHF4QU5yN1BJMi83YXpGSk9L?=
 =?utf-8?B?a1M0Sk5QdkZYSU8yVTVDckdiSVlFcG9PMm12aTNiUExzSkNDTUxtMXFBZnRa?=
 =?utf-8?B?YndaeVEyY3lOODhrVWJHTWk2dm1OUzVPWXRyb0tOY0lHQ05JYXdyVGt2aUVF?=
 =?utf-8?B?Tit3SG1tRmlTbytrNDh1RmU5MTZuNHE0SS9mdHR2UWtkQWtTT0JtcHFhMzNE?=
 =?utf-8?B?UmgxOWNna3lzbmFUampuMjR6cGFKaDlaSS9aeU5aTkFGMythUW9BM2dTYzhS?=
 =?utf-8?B?VjcxbE84cDNXYWJWWnl1MURUMGorNFVTNjZYRmZ0TW00akJ0OGs2cGFGRVlz?=
 =?utf-8?B?b0pmUE5HM1daQnJrZkhFcUk2a0RhQzZ1YmRPcUJvZmpwbWlNL1NYdkc0YmJ6?=
 =?utf-8?B?SmdTUE1pc29nZXpRR0YvdU9xbUVGOTU1RStwQWdQN1VQaEJIZHpEbE1QSVdl?=
 =?utf-8?B?dFd0YkJQcjBmYWtBUXFmK2d6T0I5b2pjRnB1STVYR3R6ejc0anRGMFZvbG5F?=
 =?utf-8?B?MXJGZ1h0MUhmdGJUR3E4eGZxbjVHdHRzWGJRTVo2VnB6RU14cmlIWEtIYUJy?=
 =?utf-8?B?VnNXVWc1aXpGU1oybWg1cExYdStqcVE1U1VmUWlMeGlMbHoxajZyZHZlTW9p?=
 =?utf-8?B?RmlYUkhvVkEvQThseWprZnVuaEZ2cy9uVTl6aUwrUzlYTG5YemFMRk1zT0di?=
 =?utf-8?B?WTVQZzQzeFNGVVZtUVhkc1BXY0FDMzlvcFpWRUVZekw3Umk5bkpGd1BwME9Y?=
 =?utf-8?B?UitZRXlpSjhpSzhOT0c5UHRmNDcvNW1DTTRZTEIwTTNuMXhnS3hDak94MjNU?=
 =?utf-8?B?cEhSMnZIa2Y1RXA3dWlscnVlNFYzMmphbDNtcW0xdWcvM0U1aWlTZ05TeDh6?=
 =?utf-8?B?VDloYm5yNkhNOHliZ3pLS2M0OElwMHpMY0d2bUNCeGd2Vm5TTDNHZVU1YkMz?=
 =?utf-8?B?VzRaOUlHTE9YVDJ2Y1NaT3B6aUdiZVNwS21lRTVoMm5HTWRzOWVLRmRsbmJq?=
 =?utf-8?B?eXNoK2dyL0VNWkpvTCtQMUlERlpIOWdWRUVLWnRvQXZqZGZqSHVUNXl6WGsy?=
 =?utf-8?B?YVZZV01iZ0pNeStyaW5aRnRSY2k0SWN3NllvUFEwbzJ4dGxxMUY1MUYwQmVn?=
 =?utf-8?B?Wm4wSHRlWktwZmZwVVhoS2NDUDRZdE9IdXV5QUU2MEZ5RUFtWERHQkRmMTJ6?=
 =?utf-8?B?RSsyWTNFdWpIams3NFVRNkZYZG5RNTJVem1hbnIrVkRWRFRPU28xRXBxd2lS?=
 =?utf-8?B?MTJnbUQvS1ZEdmsvdDM5Vk1KMjVsdWtZQzlIZkxTS3lpUWwyd0ZGR0VKMllT?=
 =?utf-8?B?MlJ4UyszU21PRC9OUGw5aGRYd3B3S2puWU1STy9xRUgvL1B3Q3lTbmh6Y3Q5?=
 =?utf-8?Q?O6KovxX1sVb3/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(366016)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SDhvUEt6N1JiUWl3d2R1N3JnMUZoNGNCRGNuSFdmNUwwS0piNlZTMFpha3lv?=
 =?utf-8?B?Rjk4RnhFN09BKzY3UGJZQVBhRkgxb2J4QURZWEROV00wRlVsZTlaMjhhQW90?=
 =?utf-8?B?cGEwejZyRjNZcmtnZ1pqc2hab25vVy9YK2RRZThrZWtiRER4ZFBjcjRSa0xF?=
 =?utf-8?B?TjF4RGNpZlAwdmVpSVkvcGNCbEJqRmxlaUx6TUFSMnExNldaY1poSGwxS1FT?=
 =?utf-8?B?Vk9BVnBiNzR2Uk9vVG5zcS9rRWhFK3hwUTRKQmFhSE1rbVhsYi8xc1YxdnVr?=
 =?utf-8?B?MmlNMDRuR2NYS295QllKSnZOK2pWWEZodUo0d3FXRHhqL0xoOTZSYWFScFha?=
 =?utf-8?B?Qy9kc1FOcHdjZHdpbHdXR2xWVGNXRTlZNzJxbDZqc3pUOWw4ZzE4bkJ0cFZK?=
 =?utf-8?B?WEtmWnlrRnl0eWhKYVUrZFNvUEMyT2dXWXZHbzlWQUtGZ2orQzJXc1oxQ202?=
 =?utf-8?B?YWc4cjBFYUZwUjZKZmhhaStMdE9xaHhjSXFjYXdhMkJCK2xta29JbHFqa1R0?=
 =?utf-8?B?Uzh3MUJueUx5L0dHaUdvcHJjVWl6M1kzeTBjTS96S05sUDFTMVZWMmNzeXpD?=
 =?utf-8?B?Wk9KK2JXNnBxZkZzV2V5ZnJlV0YvZlVjOUQrSGVtcTZhVnlsRDA0b3BDZUZU?=
 =?utf-8?B?OTFSZEt1SkQ0b1hySUJQYi9tbEw1eXgvMUY3TWsrNmtEVVcrUjBOdW5GN25l?=
 =?utf-8?B?UnhQbi9uYkE4WVhKR21YdW5vcFhJVk9QMUsrNEpRS2w3aG5Kd3hhUStrZDF6?=
 =?utf-8?B?K2tQSkxyQXpMaml2MUVGU2NOSDNYWGJnNDR3NEdkdDF1VURBOGpMVzR3Vit4?=
 =?utf-8?B?R2RwTmtWQVpROVdON1lIRWNMRDcxYldmcUk3a05EdVJWWFFrSXB3M2hVVGxV?=
 =?utf-8?B?QXpQdkdNZngvUmpQNTJ0SzBMdUd6OUFBZmxScS9hbjFKKytDVGNSRm5lclMv?=
 =?utf-8?B?N2Ntdy9rVmdiZDJ3UEI1anFzVlRSVllmeHUyMXdqcmZPVXRNRzM2OTZ1STJM?=
 =?utf-8?B?Q3J6ejUvMTVoYWFsYWMwRXFucjBRRHBBeFYvdDFrSWpudUVtcXF1K3FwQkJs?=
 =?utf-8?B?SGtDaHBYYkV2QXNhUXh1emlFWlYrRzJLZ2VlOTYyV2dYdTkyYWR1RFhwOUhv?=
 =?utf-8?B?QjE5NjJ6MExtbFpEM1JEM2hmNDR4S1NNOUF6b1FqNlU2Ym5NNzJkSE1uajRl?=
 =?utf-8?B?RWVTUVFpaG1kM09KYUdPVTZKMmRzSE9peWltYWVqcVBVK201bDdwaXFJU1BO?=
 =?utf-8?B?d3RtZkhPNUpsUkxaR1FZTGJkdWk3QSsxQ1lkR25RZ0R0TUVFMm03YSsvK042?=
 =?utf-8?B?SlpOejlZNGcxWWhmdVRQV3ZqUStZQnJyV2FEbUt2enV6NnM1b215TjRqdTYy?=
 =?utf-8?B?STF5empEdjBQODZsU2hQMUsySFlOLzR2ekd1Mk1JOGx3N3RNNDhJdVBpeHFC?=
 =?utf-8?B?WGdPSUhnWmlHeEFKWTlQa1hjVzBZZ3hsNEJEdjlFblFCMWFvWGhHN2ZQdmZY?=
 =?utf-8?B?VktSeTJNbGg5Y2dISlNKenppNFMvUmZYU1UyY0tjdXpPMkdacGltOFM1aGR3?=
 =?utf-8?B?REMzTVJ2ZmN0czduUkFxaHIvWURlenpNNlJRblhJSmFxay9rbTQwLzlENHd5?=
 =?utf-8?B?akZyTGhwMlZKZXVveGwyQU5YSkRmSkp2NEtBaThBb0ZwMGVaL2RwVUltK2I3?=
 =?utf-8?B?aGNlbXd2QUc5K0F3U0VNeU5VazVxUXJiWElXMWVoVE1XTWpHNmYvLzNSVmpj?=
 =?utf-8?B?RE1DeDdiN2NPRHUvWTVUeGZWMGFJNlYvUjdLZjFjWHMybjRGTzc1T2dWZ2lC?=
 =?utf-8?B?YnNTZmdBeHB0eHptNVloSThZYURpREFxb0pVU3VoZ0Nzd1NJU2JhYUNYU2Rp?=
 =?utf-8?B?WFJsdHMvMU82T2toYWFudHVsRkcxNHBmS1RpZHlNWnNQcjRZd0cyRHhkckNQ?=
 =?utf-8?B?NWljZ2VhYlBtdy9xaktpbW4wOVM1Z1d0UkNxL044Y280Z3M5Y0dvV3U4aE56?=
 =?utf-8?B?cUpZZ0ZzTTU1ZnNkNW04c0ZiR1B2QUduRFNzWWYzV0dxYUhhRURLZ1VGK3Ry?=
 =?utf-8?B?WGdJWFhFeWo5MEFCN2Jub2x2Nm5pcmdzam9hQlJ2QUQ2NEFWY05kMk1TRC9l?=
 =?utf-8?B?ZUxTQmJJWkt1RTFzcWtpazB5akZuLzZhdmo2eFB1cVBXU1h4cU00cmNVa1l5?=
 =?utf-8?B?OXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f35f645-ad45-4f0e-2f1d-08dd601a6bd3
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Mar 2025 21:27:55.2641
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7JKg7nLgLCj4EpEVsx4pexixB0/azU5+0KsqCIokHgirwQ3OAEONHQDeK8M8xepg7I5bsAUw0au+cpSW6FXMblAbfxmY51AXmIb8oSXnnKw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB6423
X-OriginatorOrg: intel.com



On 3/10/2025 9:25 AM, Jakub Kicinski wrote:
> On Fri, 7 Mar 2025 15:48:27 -0800 Jacob Keller wrote:
>> Would a series with individual patches for the 3 special cases + one
>> patch to handle all the drivers that have no explicit flag check be
>> acceptable? Or should I do individual patches for each driver and just
>> break the series up? Or are we ok with just fixing this in next with the
>> .supported_extts_flags change?
> 
> A mass rejection of unsupported settings feels like a net-next material
> in general. Handling the more complex cases individually and the rest in
> a big patch makes sense.

Alright. I think the three cases with drivers that check flags but do so
incorrectly are worth going to net. I'll send that series shortly, and
will follow up with the next series that introduces the supported flags
knobs afterwards.

Thanks,
Jake


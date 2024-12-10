Return-Path: <netdev+bounces-150839-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B46E89EBB65
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 22:00:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4976E284320
	for <lists+netdev@lfdr.de>; Tue, 10 Dec 2024 21:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED352236E7;
	Tue, 10 Dec 2024 21:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MZi8SCcr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B8622FACF
	for <netdev@vger.kernel.org>; Tue, 10 Dec 2024 21:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733864413; cv=fail; b=Wwi1Jypn7Uw6g79LA1zGsRgg6Y2rzUQJaiFkV//Ub6sKHPZ7T/vd/YR+YLIZIN0YxKLMacpK36ZZvVFf2yGpVwfdVByFuUb6fKQoB2ghMwQNI1tLHletJ72Uxfc7Ao7GY0AHdnezEVH10cOPz44GUzF3FN1BqH+Y/qIhea7cEaM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733864413; c=relaxed/simple;
	bh=KtrZAuzPKc/TLWM7bAJr3mjxLo3Uz58XfGwAA/QhisI=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=s0kB7CpNHIJjneBOFRtiy9NqEwW7vH0fSAohd2uCPFOgdKMv58XQVibhhL3KnrUE5VVtqzYzEKuotpYMOFoXwjOTBvxpI7ophc9p7B+NJYI0qXVflhSpr+Raafp+JWMv9mWXycE7AuA8r4l16TrcifWlLkzqH0M6SwHsIjrMpuE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MZi8SCcr; arc=fail smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1733864411; x=1765400411;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=KtrZAuzPKc/TLWM7bAJr3mjxLo3Uz58XfGwAA/QhisI=;
  b=MZi8SCcrB53VS4uBwcaLlZGfKG5DrZswkGLIsBx1Mh9iWgmCE1pc508S
   9t8O2bEMRM2nAkn3Yj+WTvO7Th7n5OaMO2gMWRQlI1BbLQvVzY4rkVPSB
   zxLHZgEPeZNyx3BXIbh6cK+NnoSgSYmofe7NU/byaPecdcCOuKg1TgvDn
   bJMXDZyDxH9d3AnMviyAalO1ZHZNEBuMyBDUegn8Cafi3SYcACS8AUg1G
   PZ9ZNAcwGv329vfkxOFmj7BMnM8uwpn6BdzfI/B20VDzm8/LgSLVyHc3v
   cDnUq8vhy7MI1RCOmVzEzM1tBp6+NDOYNcbYX1iZjaOBcNdPRIFBVmI7G
   w==;
X-CSE-ConnectionGUID: 4AabBbzESUGW+CU0md1jJg==
X-CSE-MsgGUID: 1N7KaEAjS26eB7z6BjLEcQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11282"; a="38010464"
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="38010464"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Dec 2024 13:00:08 -0800
X-CSE-ConnectionGUID: PnKOWSJnRkKYz5RbwbVxlw==
X-CSE-MsgGUID: iS2Jy2sqQ6myvtPn9dgwDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,223,1728975600"; 
   d="scan'208";a="132933766"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Dec 2024 13:00:05 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Tue, 10 Dec 2024 13:00:04 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Tue, 10 Dec 2024 13:00:04 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 10 Dec 2024 13:00:03 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bLJHT6tijESTmdBbkCKcYi1YOU/NB3ykpYUyweW1NL5iMCOuG4CCtimYX2/Ek5gLpGPjzpR+sD35Q1qRbdT0KX1K4aOcP+iKkOCjalAc/6Xt/oq83E9k2Ng/EXOA44zLxudCcIvBaJ6S/ZBgmDI1j3My19Pgfu8CPHIzJnRxLkqU/+Osbz+Elq5Hr8IgAPUwOBygaGEmn856GrGmwxCWIal549DZdWD2G0VRBMbKGCO4r+NJyy85ZAtSWGGG1uTb6ZiILzUK+pvltJU/lqR/dnlsCwizAgcBa31wzgeLJn6N11r1o/3xhgnCMnRQQ1969tYJBYkf7I1A0uSLyQt3VA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gMxlK7dvqcD3wUJ1zKGLn9kp+DE6/MqmxfkVegYzsuQ=;
 b=Qj8bRgx02gn0D98kCE3vb6OyBwFW3KygaBvhMgrQDgrvlRn50cC5gAr+dx6qqrObJpr5KMiEz1UTYiKzGoXSnYG/g6ud7gazDWIuWsfGw0CDaFE5+U/PMVVPNuZG1cDnnmhD7EEZaJ4uZq58ihVQ145Uc3MhtVx7a3DHGdKUi/JZWNCLkhs/7Hl4+AGdmIYcsH4LM4Ji3XcGMgaRgfdu12u2UL7EcXhK5LW6IXuiYX5Bx4RU3aMcCRsfuW/IrFqk03iP+RyIJWFojM0W1KYH91WfwC5opV8ujw3L6wyFVcVOoXUr22Z93N/FNCBT0TkCtWbiDKHIkq3A9cHt0FzqrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5095.namprd11.prod.outlook.com (2603:10b6:510:3b::14)
 by DS0PR11MB7407.namprd11.prod.outlook.com (2603:10b6:8:135::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8230.12; Tue, 10 Dec
 2024 20:59:33 +0000
Received: from PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189]) by PH0PR11MB5095.namprd11.prod.outlook.com
 ([fe80::215b:e85e:1973:8189%3]) with mapi id 15.20.8230.016; Tue, 10 Dec 2024
 20:59:33 +0000
Message-ID: <564b9d98-4d64-40ab-a523-4487712430dd@intel.com>
Date: Tue, 10 Dec 2024 12:59:31 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net 1/3] ionic: Fix netdev notifier unregister on failure
To: Shannon Nelson <shannon.nelson@amd.com>, <netdev@vger.kernel.org>,
	<davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>
CC: <brett.creeley@amd.com>
References: <20241210174828.69525-1-shannon.nelson@amd.com>
 <20241210174828.69525-2-shannon.nelson@amd.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20241210174828.69525-2-shannon.nelson@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0213.namprd03.prod.outlook.com
 (2603:10b6:303:b9::8) To PH0PR11MB5095.namprd11.prod.outlook.com
 (2603:10b6:510:3b::14)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5095:EE_|DS0PR11MB7407:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f4a72ab-f6e5-4d7b-afce-08dd195d8c63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?RFM5Vm1mamFUNHkxQkhQcHFudlpDSHVtRFBJVFc3S212dGR2MzJ4YzM4cTdx?=
 =?utf-8?B?YjJSb0d2SGlSekt2emtxRDVvMDB4dGpDZWpXYXR6c1pKWXE3bkJpdG1mRWgr?=
 =?utf-8?B?eXNyK1FDeDFWZkh4dFhkeUZoRytwZG1hU0ozYXA5WWM2WlpIcFNzSVdNdytR?=
 =?utf-8?B?Uy9PUzhVSFZUOGtKMElWVVhVWVo1K0U1bUhZZDNMK1Mvc2N3Q1VVNTlLY1JP?=
 =?utf-8?B?SzhQalNBMWJ3VlBKRS8xZHRUV3FydTFjRlZLSW5FVDJ1U3hlaHlxNXorK3lp?=
 =?utf-8?B?Y3YyS2tYVUFncG5QalNWZzlRTUs4Zmt0RHE0MlVSVkNIUzlTUHlJSlljbVo3?=
 =?utf-8?B?YkZzcUdyZkZPcGFZVG1kenFpRU5tSGgxWEthZ01oMFpWNFJRMk15QjZybzk2?=
 =?utf-8?B?UCtLd1VOVUNuUlJkOExTYnh5Q2FBVUQzV0ZTWXM4clV0ODJNN00zakJWMkhF?=
 =?utf-8?B?YzZES2VNa2o0M2NOWnlzb09rOHRHaXdldDJuejI2MjlMS0xhMmRGSExocTNT?=
 =?utf-8?B?bm1LM2thc0FESTRiV1E3MmoybE1vZG51SlJhaVlqdWRLcE95Y2M0RW5wN3kz?=
 =?utf-8?B?dTNBRUp1RXYvOW5FTUd1Mm5QZm54QUVQTE9Od2FHQ245b01XSGJteGo4bVRF?=
 =?utf-8?B?c0d6Wk84c3pzcnhCZUlXY1k0ekd6TTh1RUdBWEJ3R09jdU9OYTVuNEVLZnFC?=
 =?utf-8?B?Uk82OWpkbkdHMXNvRjQ3Ry9nUjFLUUVnZTJNMS9MM2N1SnBWanV1STFmemI2?=
 =?utf-8?B?REVWNnc2amdBQWRSZExPQW9Fa0xka3kxTWxvcDRaczJtN3dWK29KUDIyenNF?=
 =?utf-8?B?eklvOW50OEJZQVdWa2g2K0hUdWFpS1F3VWtyRDA5R216OVFNWTlTSzhIU2xo?=
 =?utf-8?B?U1B0WWxGVVp5MmV1UGFzS1hXZVIrb3lBNjh4bXR6MFhqOWgzdjh6MW8rMVIw?=
 =?utf-8?B?MWErTk9PakNmS2lmTzRuMXZNb0ZmYUdqRHVOcjRPRFZQdU1PTm9CMjl0bEtR?=
 =?utf-8?B?dlUyYUF2VXd6aGk5ZG5PUjdzYnByNzhGcFgzUHdoOUtPeGlYMXpIZ3dwOWpx?=
 =?utf-8?B?OWEwSmRVaDFQWmVDblhWeld0MmpNQjVBRkkrNGhlNVVkVU0reEJSakRXb0Nh?=
 =?utf-8?B?MWhvdW5rQ1I4V2tCbWVwNitydmwzQjU5MjNCMUNnSnpBNVZvZThIU01PNjVs?=
 =?utf-8?B?WUZPN0UyaVd5WnozZEo4UkFuWlptT1daSVU1NDl5cE14NzBBdmxrYStINjcr?=
 =?utf-8?B?N0VlNlJmTXBiajA0OFNLK3FlaHNkdENhNzZuakFyVlBTaE9XS2NWdjhaeVIy?=
 =?utf-8?B?RmJiVFZqQ1ZoTU9XTWJPYkU2aklqT1l0OHlKSVd5OG9xNFFpeWNQcFJoRXN4?=
 =?utf-8?B?SGY4TEJtaW9BNUZQbENrKzVuMldDTDVQWlpKOEtlMWdIOHVFdDN0cVZrTGd3?=
 =?utf-8?B?a2xQYkRvV0hUbm5VTU56Njd6SVNLc0NwTDE5RDhCM3Q5b0dtRnd5UEc5QmVW?=
 =?utf-8?B?M1JRRitDcDBHUVlBbjhFc1J1NEFqYkpyRmRpZWg5RFpFWEl0YzgwMnRPVjdV?=
 =?utf-8?B?Wk54OGxIbUV3TnhERmwySGFBcUlOQ09aTzZFNGRlZ2ZIUHcrT2EvQUM4bWpk?=
 =?utf-8?B?Ly96UEV3dnFCcDlxK1kwQlNPVDZMS0dOZElSaWZObDVDU1FhaU5IdW80bUd0?=
 =?utf-8?B?UEMxenVMbTFYRzdHVWlrL0k0VVJvRFE3SjRiekZYWXRzOE9tdldGTXUvMXRV?=
 =?utf-8?B?UHNZMjFRczRsNFdOTmlTQ0VFSGsrSE5PTWI0MTV3aCsvT2ZoWWpLcm51QWFy?=
 =?utf-8?B?a1QvcHRTQ09ZSkNyL0s5dz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5095.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aDdzK0tnTkNCK001UzZkelQvRGpwUzk2K0JyTStUNFdhbGFBajZGTGQ5d1da?=
 =?utf-8?B?aGlCZXJJTkdtNU5wSWFNSm5lRUdyUUlwOW1HRUd3QjFGSmZhcmVxOFlkbFhW?=
 =?utf-8?B?MU94UEhUSzZYQzhxUnk1RHdoU2RCWnpEbThFY2dvUUNidWtjYkQ5eGViNHJn?=
 =?utf-8?B?S0lOMlRWQ01XeUdCUnV6b0MzcWtnK1FaVU0vSU56c2s0SGtlMFRGb20xdVlN?=
 =?utf-8?B?TnYzb0RobVY1RjV1cGNLL2tmWFhpOXhZNDhicGdxaHJmQXJWN0l2WSt3OFU0?=
 =?utf-8?B?M0VnemY1bWc3K1FxdkIwVVpPdENmK2tqUFNpZmVQNktud2hpeVlHK1dybTU4?=
 =?utf-8?B?eG5nL0Njc3h6bmd4ZVZyTTJ0RWp5NXFqNDFSZTZjRnQ3bFZnbTN2UnZ3VDcv?=
 =?utf-8?B?TUxqb1NrcVl4cHJaQ3VyeG9EYjI0VkM3SlhZZEczWiszZmVWRThDSjgvUlVi?=
 =?utf-8?B?T3hxTkhac2pvM0JRVW9lSFhqYitTbTFpOUYwL3lCVW53ZmdldFhxTE5Mc0Ju?=
 =?utf-8?B?aXp5NVJxVkgwaHMxbnBqWnVMVVltdCtuL045YWRtYWJqOURvTHlkWDBnd2Ri?=
 =?utf-8?B?MlNUK203a2hRaXNlcURkYlNPZ1NGVzR5UEc4V1pkSTJuNFRTU3ZOY21aZUFJ?=
 =?utf-8?B?dlE2UlpMNi83RXFjNCtnMHltcXlSZ1lubStrUWswYWlpTkhGVGxNK0FEVGtT?=
 =?utf-8?B?L1o4c2VvMXJBY25hY2JIQkpzYmNmK2xhTVJoVTFYQXhkWlYwUUVDUGNpSits?=
 =?utf-8?B?clJDU1dQcldqek9td2NxMnBHeTBFT3JiMVhyZkRRaFYyOEZETkw0OTR2Y3VH?=
 =?utf-8?B?MHBXTDQvLzQ3YzQrcFZROHo3RlFZTjRlc2hxWWZYdGRxc1Q2M1V5MS9pcDNh?=
 =?utf-8?B?U3o3TzFYRnhNYkJhWW9sck45QVUxaU9CNG9JTkR5MHZSblpEamV5WEIyYjZW?=
 =?utf-8?B?Wk5raURvZ2ZVcVdvT2F0Yzc3VVlHczk4MkQva01wcU9yVWxQN3RONTI1eHUz?=
 =?utf-8?B?LzZ6NTAwVkFOekhGOGFBeGtRNXRzMEU3b1Vhc3NmOFpYQjBxdUhnR3dJc2I5?=
 =?utf-8?B?d3RLWkoxRHM3bzl2QlpoMlhGVEpiMUlQUm9NeE5BZFR1R28yMHJiZ1E1b1J0?=
 =?utf-8?B?aEtMRzhNWVhvd1Q1RnNlYVBWOGRFVGFRWnlWbDFkanF6N1Bxakk2TFA4MytQ?=
 =?utf-8?B?SjVhWnBHYnNCZ2ZUUGdFTHhkazNKdThrb0JEQWo1UmJIL3RlZ2V2VW5FbUhw?=
 =?utf-8?B?S2Y0YysrMU9EcHFoeFRIcjQ2S3VTcFFRYmZLM3RQcXAzVjcxdkhKWGUwRWk5?=
 =?utf-8?B?R2ZUUHcwcDlyK2kxeGphV04rQXkwdGpVOEpaY0c2WTM3QzBmVExNSzU2bXNU?=
 =?utf-8?B?eWNHaTV3RU5LOXlvbXJsYkJ6UUFHTzBaM2VlbkJPRTdmUFJTUUJMNGp1S2dG?=
 =?utf-8?B?QmZWL3JhSCtjd3YxNVZZUHZZbDFyeWxsTloya2RZK1JwTzJxT1F2UmJuSzVO?=
 =?utf-8?B?MXd6STlPdzZlcnJxSTVydVpwVjFSMFc1K1d1Q0ZrakN4R1pLNWtoWEtQUTBw?=
 =?utf-8?B?UFROc0kvVU9jOVVGd1VKQmtabUp5STFOKzFrelF5WnJnaFRhSDBXVUcxRndo?=
 =?utf-8?B?VnBhUWtmODZFeDYzNk5XbHlLM1lKYjZrYXhKOWlXT3pqUC9sMFRrZFlZMGI4?=
 =?utf-8?B?MXdoamF5aittNnd6Nll4OEh2YlpNd29GUXZhWGRDRE45dThMRkFQa3BwcmlO?=
 =?utf-8?B?WUhmVHZUSG5JU0hlVlM5RTY5WGl3a05Ma3Y3OGpuRmp6cE5seVluVGRUbkFO?=
 =?utf-8?B?VTZ4dEJzeXMxOXN6N285VkJENjRFQnE5ZGhaNndVMnhNbnpRQ3NFLzBoTGli?=
 =?utf-8?B?ZjhnbFNyQmtnYlhhUzN6SUZ5bWhxcGNzWnFmQTN5TytVaGRaeW1nVFY3VXNZ?=
 =?utf-8?B?RWhLQUZZSW1JZGh4cWc0c0lmY25HMWpsL1hGMWJMSEYzczNtYmZDOGtSMzF6?=
 =?utf-8?B?a2NRMDRTeTRBMjduWTlVWHV1L3RtdEFCL1NibnZPMzhYT1F4UkRyVnZoZkxY?=
 =?utf-8?B?SmpaQlZobWY4WWY3bEloTCt2alo1c2JoQmV6bmd4ZlM5VWlXQmpEamlNMXRs?=
 =?utf-8?B?cnpEUEx1RGRFaE1LOG5MeUhaazZkTTYza0I4aWVtUlhyMnFQNDNQZmNOU3JX?=
 =?utf-8?B?NEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f4a72ab-f6e5-4d7b-afce-08dd195d8c63
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5095.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2024 20:59:33.6094
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3RozhpW7BAhyiXlOM4HhB8VoNn5A6M5gVe9f3R4eBxWs87XHfYyzjzZXnv/Orn7v30iR+GoprjOZV+HbycrXXhnkelzOvsbGRZjEC7mJlxI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7407
X-OriginatorOrg: intel.com



On 12/10/2024 9:48 AM, Shannon Nelson wrote:
> From: Brett Creeley <brett.creeley@amd.com>
> 
> If register_netdev() fails, then the driver leaks the netdev notifier.
> Fix this by calling ionic_lif_unregister() on register_netdev()
> failure. This will also call ionic_lif_unregister_phc() if it has
> already been registered.
> 
> While at it, remove the empty and unused nb_work and associated
> ionic_lif_notify_work() function.
> 
> Fixes: 30b87ab4c0b3 ("ionic: remove lif list concept")
> Signed-off-by: Brett Creeley <brett.creeley@amd.com>
> Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
> ---

I'm not certain about the inclusion of cleanup to drop unused code in
the same commit as an obvious fix. However, the changes as a whole seem
ok to me:

With or without splitting:

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


>  drivers/net/ethernet/pensando/ionic/ionic.h     |  1 -
>  drivers/net/ethernet/pensando/ionic/ionic_lif.c | 11 ++---------
>  2 files changed, 2 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic.h b/drivers/net/ethernet/pensando/ionic/ionic.h
> index 1c61390677f7..faaf96af506d 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic.h
> +++ b/drivers/net/ethernet/pensando/ionic/ionic.h
> @@ -59,7 +59,6 @@ struct ionic {
>  	DECLARE_BITMAP(intrs, IONIC_INTR_CTRL_REGS_MAX);
>  	cpumask_var_t *affinity_masks;
>  	struct delayed_work doorbell_check_dwork;
> -	struct work_struct nb_work;
>  	struct notifier_block nb;
>  	struct rw_semaphore vf_op_lock;	/* lock for VF operations */
>  	struct ionic_vf *vfs;
> diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> index 40496587b2b3..bfa24c659d84 100644
> --- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> +++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
> @@ -3804,10 +3804,6 @@ int ionic_lif_init(struct ionic_lif *lif)
>  	return err;
>  }
>  
> -static void ionic_lif_notify_work(struct work_struct *ws)
> -{
> -}
> -
>  static void ionic_lif_set_netdev_info(struct ionic_lif *lif)
>  {
>  	struct ionic_admin_ctx ctx = {
> @@ -3858,8 +3854,6 @@ int ionic_lif_register(struct ionic_lif *lif)
>  
>  	ionic_lif_register_phc(lif);
>  
> -	INIT_WORK(&lif->ionic->nb_work, ionic_lif_notify_work);
> -
>  	lif->ionic->nb.notifier_call = ionic_lif_notify;
>  
>  	err = register_netdevice_notifier(&lif->ionic->nb);
> @@ -3869,8 +3863,8 @@ int ionic_lif_register(struct ionic_lif *lif)
>  	/* only register LIF0 for now */
>  	err = register_netdev(lif->netdev);
>  	if (err) {
> -		dev_err(lif->ionic->dev, "Cannot register net device, aborting\n");
> -		ionic_lif_unregister_phc(lif);
> +		dev_err(lif->ionic->dev, "Cannot register net device: %d, aborting\n", err);
> +		ionic_lif_unregister(lif);
>  		return err;
>  	}
>  
> @@ -3885,7 +3879,6 @@ void ionic_lif_unregister(struct ionic_lif *lif)
>  {
>  	if (lif->ionic->nb.notifier_call) {
>  		unregister_netdevice_notifier(&lif->ionic->nb);
> -		cancel_work_sync(&lif->ionic->nb_work);
>  		lif->ionic->nb.notifier_call = NULL;
>  	}
>  



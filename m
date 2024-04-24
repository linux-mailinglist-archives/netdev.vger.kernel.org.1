Return-Path: <netdev+bounces-90834-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA9A8B05EA
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 11:21:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28A9E282361
	for <lists+netdev@lfdr.de>; Wed, 24 Apr 2024 09:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FF8158D83;
	Wed, 24 Apr 2024 09:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="EB9DOHMD"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 991FC158A24
	for <netdev@vger.kernel.org>; Wed, 24 Apr 2024 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713950467; cv=fail; b=LfXHwzF2irX7HS4nssHSPxJTifGD20fKjrT7tsBhbXMnURo5lwGddt47QEQ6RNlDActkYTgg+DXGThDEPUKRrfBv68nuRLVABIsc0jVa+MQRmb9nsy/3ZvlOihQ72iza8YQT5/kcNUpJ/qtrDKNmthwda9aZba76gdHGly8ou90=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713950467; c=relaxed/simple;
	bh=ywpa7skMEz+qkZTUdo8sCspdASrdeXfOGDE9Al3BmpM=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=uz66V3kTjZkRr+DDM3nqifM7kGuDIuMwRvUENrFibVNbBEbWj0qpASa8sRMgeLsueHKGWcX/dwbbrO9PlQWq6fUnOV4EwZQHIyBpaXcHG7e25CLelKCEyQFsLw1QXE8L27Ni5sv3G0Ibq18pZvLX3RZKaVLKWWiRmzYVim1wZA4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=EB9DOHMD; arc=fail smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1713950466; x=1745486466;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ywpa7skMEz+qkZTUdo8sCspdASrdeXfOGDE9Al3BmpM=;
  b=EB9DOHMDcr3j0lucaa6LTvADxd147UstBEa2xrIEY6fbLhkZYj3+hKM6
   HUr31QqNPFQn0JeuKcarWdvdGLOaCfFS6RdkbUNbJDqbvtCucDCnBmFF0
   kMLTSWgrLvA/PIWuSS6P15aR9czoyuIGGWzCkY3FFhBXO47pOyYvX4r80
   EceU6v/h+u+1rIYXDr6nj90i0zMp6Qw4K+YXuiVyBLY0jQKWvuxU9ozvY
   nOtDhxSsgFklezgfR0WS54pLd/S+Kg6Rj0lVkUVZirk+eiUL5M2KznNwd
   9cpOGqhQvrxGlmWJs8lWcGREctGj2FhwsKfKd+hxBogZQS8GklPuIN/+f
   Q==;
X-CSE-ConnectionGUID: 1aCWYiXxQ8mfP3T6UFO4BA==
X-CSE-MsgGUID: TfBIDTkDQZWodQMI9lRr4g==
X-IronPort-AV: E=McAfee;i="6600,9927,11053"; a="20120666"
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="20120666"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2024 02:21:05 -0700
X-CSE-ConnectionGUID: AUHGoZvkQoCSJd7PHaEbrQ==
X-CSE-MsgGUID: Bz99GJjGTUuv4KcVjKRHqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,225,1708416000"; 
   d="scan'208";a="62121321"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Apr 2024 02:21:05 -0700
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 24 Apr 2024 02:21:04 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 24 Apr 2024 02:21:04 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 24 Apr 2024 02:21:04 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=b9kjDp6C/CS5kvL/J+YR2zs2guubvrH4GBoRny9Ju7xjieIK327jvMSurVBZEtjqFIR3IQ3OF6khd9HedoBRc4Ap+5R4eOn+RedOXWpBLwN9k2WIEHxotMVJvOmLAN82CCuiraTEQH4O+FZf4i9tdUpSc2EoVB6V9Xid57RGANBAlj/oMeshXhOvPdgNErISP0YpHrKh3+n+hFjCTfXyUTbw6llZE4EWnL52gmNQ8MMpR/jkwHRdgNIeifqK1LwMPq6phHXpCPll7ojeidr2h0EGDqflc2dxkEaLflMpuuTXCtw6/fhhTV3FI8jCHr4UXzVaSLwPPjBqmU5/WfJDgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wO+NPpX9DIXPmh86a0FkA9ygxaTwWV86Mla/iLBo63A=;
 b=AMDNGZV0Djp42MLCM6vrRfRnjbtyDIPbFYbaukmUT5SF0bZlpyVkpxFtNXGJMhPPaX1sHmZwuX9cH0APy1+agNOryNw6+jut2xI/UvWeGkhE5VOC5IP4sYA9UqVZulI/LithGpVIxETLhaOZiYSbaZwEK7CdvOG3FrQcGVkzBq+5QsYMhfVKukyxy/7x740NUBoWb4FPXf7xGzpwF3G7+PaWEc2QzsyaQUDDDQI/SofUXoSBs3Cbr0NwPUAyEFpfiqjboEbHXsmsrGWWi3JNHrldNB5vZYUCqbdXSm4vYXxANqrM6byjbWkKhleVemaB8jzHcJc2ie+oBk+BGcRHKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CH0PR11MB8086.namprd11.prod.outlook.com (2603:10b6:610:190::8)
 by SA2PR11MB4858.namprd11.prod.outlook.com (2603:10b6:806:f9::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 09:20:57 +0000
Received: from CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3]) by CH0PR11MB8086.namprd11.prod.outlook.com
 ([fe80::984b:141d:2923:8ae3%5]) with mapi id 15.20.7519.020; Wed, 24 Apr 2024
 09:20:57 +0000
Message-ID: <fa6e7d19-e18a-4146-983b-63642c2bf8c0@intel.com>
Date: Wed, 24 Apr 2024 11:20:49 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/6] devlink: extend devlink_param *set pointer
To: Alexander Lobakin <aleksander.lobakin@intel.com>, Jiri Pirko
	<jiri@nvidia.com>, Mateusz Polchlopek <mateusz.polchlopek@intel.com>
CC: Tony Nguyen <anthony.l.nguyen@intel.com>, <davem@davemloft.net>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <edumazet@google.com>,
	<netdev@vger.kernel.org>
References: <20240422203913.225151-1-anthony.l.nguyen@intel.com>
 <20240422203913.225151-2-anthony.l.nguyen@intel.com>
 <cdd3d9d7-1b21-4dc2-be21-ef137682b1ea@intel.com>
Content-Language: en-US
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <cdd3d9d7-1b21-4dc2-be21-ef137682b1ea@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0006.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::11) To CH0PR11MB8086.namprd11.prod.outlook.com
 (2603:10b6:610:190::8)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH0PR11MB8086:EE_|SA2PR11MB4858:EE_
X-MS-Office365-Filtering-Correlation-Id: 022c6248-3c8e-49c5-ed2d-08dc643fd931
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|1800799015|366007|376005;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?UlVFSUwrcWhOdGphQVplNDZ2NHFKcEFUcGhCUHFLK2RkRzZXdzBYbVBuZTg1?=
 =?utf-8?B?V2lvUlhVckZUVjNIK0J5dVM4RlZPdGhnQ3ZYNzBpZW45blMrOW5VbUhVZUpO?=
 =?utf-8?B?a3lDZkM2SkxSM0xCcUpXMHpxMUV2Q3NySk5ORlBJdSsrOTl6cTFMUU5GbzhP?=
 =?utf-8?B?V1A4SGNIY2MwZVJHd3ZaYXlXL0phTWFtdzBJMXBnUDY3SEVkRTA5SmhGN3pm?=
 =?utf-8?B?aFA4NFZ2cEhQN014LzVka3gvcWxyZ1pHZEMxUWZRNk1IUmNjcU1lLzAwdUVY?=
 =?utf-8?B?WWJPV0xDMmpHYkVmU21VV1d2SlR2WExzUVZXTjZobkVhdWtsb1RxSW1ZWmlr?=
 =?utf-8?B?TllKRjRPWngxNkcxemRJSUxiVW1sSS9lclMrUTRqWlIwQTZndXRDSTJXcEg0?=
 =?utf-8?B?N05xdStUbllRQTFlNVhLZW1RMDQ0ZitCK013RlNFSWgrZEM0ak5EclZWdHQr?=
 =?utf-8?B?eUprRkFzQmU4REphd1FrdGoySlR5V3VXK1pIWnVXY3puL0FjL2lvRHFiMkth?=
 =?utf-8?B?R2JvNlQzTFI0UVNjTmV1czhGVTEzNlZEKzBYTkcxcjlTdGFvZmRBRWJ3N0ky?=
 =?utf-8?B?U29KdExpdDlxWTB6Ty8ydVFnOEtRUWkxT21YdVBwcm0rZ3FyeVRoSXlCNUI4?=
 =?utf-8?B?dVMwVHp3YmxPTDRBcE5uWWVKSVllVmlJd0R2UnZ4RUwwajdlNGVsdjVDNlFB?=
 =?utf-8?B?THY5a25kTTNkMHlaQjVEWXVTQUxtM09wSmxuMjU1RmcxU0xnWHdvUW9BQmgv?=
 =?utf-8?B?YmVlU3VpSzA0N0liVDhRenpOZENGZGJadkh3eHJMRTBGWEE5bURUeUJ6QjJL?=
 =?utf-8?B?VVhBbDFwTHNiWWlZY3V2VlZhbm5SS2poOVYzcW84bTg1clRtZGxENVRHTENO?=
 =?utf-8?B?d0VTbDZXNk5GKzBZVStQVTRza0V2d29uZk9CR2FPV0lTK3p1VTlJdlg0c3hj?=
 =?utf-8?B?cWh1bzgyY2x0UHlBSHRXZFBtSVdjcWJjM1Q3Q0xZZTVKei9TZ1JsRkRKcytK?=
 =?utf-8?B?WGI4VXZFNTA2T2Z6YjZGQllTMlJIQUtJMmFPOVM0VVRQN01DblJ3bDhnR2tk?=
 =?utf-8?B?am00a3BOY2V0OVdFWTNNemNyK2JlUlRJcnZ6TG83RHllUXlUM0pFcjNIdUR6?=
 =?utf-8?B?d21HMTFBOVZrU1FTNVBydWNybW5RR0pMS1l5akZaNWowRlM4QzllY2E0eEtE?=
 =?utf-8?B?dEpTT0ppWEhncTRjM1AvTG5vdnNJVWU4SzJqd05mRnFIc3R0RUpnWU9hZERo?=
 =?utf-8?B?RFJjRzRTUmlJMnJpbEZNa3pzbWZQUHRjUndwcC9BQk9Ga1k3dTZUbktUM0h1?=
 =?utf-8?B?bWhSeldMRWZmWEFjVVlUeXNXcHNJWTM5bDZzOGhwWXZvVlA4ckRWN1RuZCtF?=
 =?utf-8?B?dnJwR0tIYWxNN3pCemhiR1ZCL3FjMitlcWpRVTd2dW9VMzZtNEMvMFhjYW9T?=
 =?utf-8?B?eHJ1UVJISkFYemM0SUR4NFp0TXVzK0VvU3RNQW5kSy9pR2VGT3dGUTNEQ09y?=
 =?utf-8?B?UmJaSGtBbi9uYjd2dmU1WXVQV1ZacFBRb2c5akl0VFozZ0xQbzdJM1FiRzN6?=
 =?utf-8?B?YlhNNjNmdnNJMmZTaklCZzhSeVRtbnB0WUFMMVBXQkZPL3Y3MWZWeTVIakhZ?=
 =?utf-8?B?NkhUZmhGNWhsN0krY2tHZWhBVHZUeWVPWk1rUVcvVDBMY0pGWlpEb1RwQWxC?=
 =?utf-8?B?T0cvZkpMUU5tN0hrNkRvb044WWRnemx3SVdJU2pqdW1qekVIZm1vYVlRPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CH0PR11MB8086.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(366007)(376005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bC9CMzhCQnYyem15c25kL1ZOSXdiUHd4bTF2WjViY2N2ZDEyWFhiVHM2Q3RV?=
 =?utf-8?B?V2c5a1pibGU5bWpHM2h5VktBckhCK2wveVFidlg5YTlnN2lUaTFwMjlzcG9V?=
 =?utf-8?B?aGpzQ0VFTjlsRGxzc1RGTEN3ZzVOd2RieHBtY0xUbXF3WHhmdmNxdHZES2FN?=
 =?utf-8?B?WWZINTFEMk1SUzRqYkdzajFkdzlVVGdNS0l0SlJYb1NpUGNYMjk3eUp3TGU5?=
 =?utf-8?B?dzJLWEp5bThUazVYTktLRWZ4c2Q3aitJeE5vMUhWUndLeUNnUG5aQmluZEln?=
 =?utf-8?B?d1hLUUxybGJ0ZUZoNUZBUGRaRXNIY01uZEJHYXMrY1BIdnNzYVpoeCtSOG9w?=
 =?utf-8?B?RUNsT3VMNEpvNExsTld1SUszRUxadXllUjE5QVhHQ29OeldZOHd2NWc5cU9F?=
 =?utf-8?B?MWl5YUx5elNHWEZURHozNTBvM0FLSnJLVkdZUGR4NmVBTXV5NWpkU3JSMThJ?=
 =?utf-8?B?cmV6NHBsY3RjaEpxajdVQmhWSkgyd1U5ckZzYWpVQ0U1VmVHZW9iQ0x1VmRi?=
 =?utf-8?B?dHZIYVA0RG9oWU8xQWk3eS9iaTUyM2dnUEgzNFh1VWZCT0VIQ2JmSk5GZWNZ?=
 =?utf-8?B?TGFoemcwbHo4bWc0ODF3NXdvdXhKbTIyRVB2dHNWSVhXTXdTb1ErcnJTN1JN?=
 =?utf-8?B?OXBtaHEyZ2VoaXo4RzFYc0FLV2RURU42eXFXOGVLWWFISnRaK0M5eVFJUzI1?=
 =?utf-8?B?bjgvcisrN1dHcHhLNzQ4SzJJbU9heWxZL0NPOXoyUmtsNm9la1FFRUwxMmRG?=
 =?utf-8?B?d01wME8xa3ZQNTFOdzRweXh5MFdpVjFRWkI2RVE1Q1FDd3dQZWRwZUhQYjZ3?=
 =?utf-8?B?di9BUVB5Vmp3dFJzYUpKandNY2Y3dElwbHQ0U05UL2xzcFJYVzkzNUVvakVM?=
 =?utf-8?B?SFlyVzF5clJUR3dwRHRGWE1ScS83VW9zdVRPMGx0MFJvRkhiY0svODNYeTdV?=
 =?utf-8?B?TElPL3dMbERNK0hNVjgyb0gxWE5GKzhOUG95S3V6OGNaRmVDa2lOZkJHVjVZ?=
 =?utf-8?B?cmg5dVB4TytRdTYxeEUxUDFxekl1WG51M0FuOXR1dWtqVFZCZ1c4U3hGNkNB?=
 =?utf-8?B?eDhuWXZqZ2E3b3A5QVBybzBDYWZxRjM2YVU1cmlEWjdBM1ZGV0NLTjZja0hK?=
 =?utf-8?B?MEdGTjNtRmZmSGloV0xaaHhWZEFacEErZmpieFVzN1o3RnowWVc2L0JxUGdU?=
 =?utf-8?B?dXh2cy9sbEpWRzh2TDNWSE04bDlhUVNRU01Qb21ZRm1LdG1lNWRjQlF0Wm9j?=
 =?utf-8?B?blo3ZXkwUkx0bDgyTUgwcExIUUVaMDZpbFJrKzdJYkRtdWo0SzBDL0R5anp2?=
 =?utf-8?B?dklUTUxGZXRlVktibytUR3FSdFM5S25iNHhEMUwwTmJNK2hSVnpJeFVhY2FM?=
 =?utf-8?B?d0VGU0lORDMxcVV6TEl2VXZ4ZVVDeUxpY2t6L0NrZmsxc29uMFUxV2h5TVFV?=
 =?utf-8?B?RXc2cFNZQldZTmNITEp2c1NFS0o1ekJleHBjaE5ZOXVFc0tiVXI3NzhLbzc5?=
 =?utf-8?B?UmVWOU8yMXJZMzRoTWNTZlpycGJPQURBalRTNjJ3ZytXcjhGbGU3WDM4U2I1?=
 =?utf-8?B?R0VmOHhZMzcxUzlTNmdScU9IRXBJTDBjZzNUL3EvOFM1NzRrL1UvUHBzS3pv?=
 =?utf-8?B?dHJnSHNXQ2RwaDk1QTRyNEVOU0hpb0xBWUZiUnVyVEJWeG9tNnYyTklWbkF1?=
 =?utf-8?B?eW9XdnlhLzF0WjVUdUlaOXZDUVlXRXZSQUdrRW9YQ2R2em8vMmx3eTB5NndN?=
 =?utf-8?B?RURBN20reDROcG9RL0pvNlVOZHFLZU5XeTMwRGpnTlhVQjRNblVGMkw2dUls?=
 =?utf-8?B?T0QyU2w0dWI4M1NScCtSQjIwZm5NYnBJb3BIZk40OTZoWXdUMm44azBmclFa?=
 =?utf-8?B?dnI1OEhRaU5kQ3dlczUzQVpNdEl2NVIzZmVBLzlpK1BTcHZKMTQ3QlJrZUU3?=
 =?utf-8?B?Z0EwM3l4aUMycUdDb0VhSEE1bE9NeUFkQjh3RGM0djRReG91enl0Q1FaZk96?=
 =?utf-8?B?b3hBYnI5MU5GUE1wM2djTnMzQXkvZmtIYkpqeDA0ZmxoTFl0Q3hZODA1aG5h?=
 =?utf-8?B?VS9qMFdzKytFdWlRMW5OR2NudG95TnVlTzEvRjFPeS9UT1phdVVBTnRCVkdo?=
 =?utf-8?B?aDViZUxzUmlobWFqU2wzVjVHM3paK21tQlVOQnk4NzJFdUo4RGFQWVZLb04w?=
 =?utf-8?B?Q0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 022c6248-3c8e-49c5-ed2d-08dc643fd931
X-MS-Exchange-CrossTenant-AuthSource: CH0PR11MB8086.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 09:20:57.0665
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VOQij+vmEgocZmk/JT3x9OPa6Zw/rRuxCj5r22DfxG5vJkfCPdK6G/l3TmMm8kYmieD188+hLSlfdjjkWPThVaoBCXUqjC57x13gnKX4SjA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4858
X-OriginatorOrg: intel.com

On 4/24/24 11:05, Alexander Lobakin wrote:
> From: Tony Nguyen <anthony.l.nguyen@intel.com>
> Date: Mon, 22 Apr 2024 13:39:06 -0700
> 
>> From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>>
>> Extend devlink_param *set function pointer to take extack as a param.
>> Sometimes it is needed to pass information to the end user from set
>> function. It is more proper to use for that netlink instead of passing
>> message to dmesg.
>>
>> Reviewed-by: Jiri Pirko <jiri@nvidia.com>
>> Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
>> Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
>> Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
> 
> [...]
> 
>> diff --git a/include/net/devlink.h b/include/net/devlink.h
>> index d31769a116ce..35eb0f884386 100644
>> --- a/include/net/devlink.h
>> +++ b/include/net/devlink.h
>> @@ -483,7 +483,8 @@ struct devlink_param {
>>   	int (*get)(struct devlink *devlink, u32 id,
>>   		   struct devlink_param_gset_ctx *ctx);
>>   	int (*set)(struct devlink *devlink, u32 id,
>> -		   struct devlink_param_gset_ctx *ctx);
>> +		   struct devlink_param_gset_ctx *ctx,
>> +		   struct netlink_ext_ack *extack);
> 
> Sorry for the late comment. Can't we embed extack to
> devlink_param_gset_ctx instead? It would take much less lines.

But then we will want to remove the extack param from .validate() too:

> 
>>   	int (*validate)(struct devlink *devlink, u32 id,
>>   			union devlink_param_value val,
>>   			struct netlink_ext_ack *extack);

right there.
This would amount to roughly the same scope for changes, but would spare
us yet another round when someone would like to extend .get(), so I like
this idea.

>> diff --git a/include/net/dsa.h b/include/net/dsa.h
>> index 7edfd8de8882..a6ef7e4c503f 100644
>> --- a/include/net/dsa.h
>> +++ b/include/net/dsa.h
>> @@ -1258,7 +1258,8 @@ struct dsa_switch_ops {
>>   int dsa_devlink_param_get(struct devlink *dl, u32 id,
>>   			  struct devlink_param_gset_ctx *ctx);
>>   int dsa_devlink_param_set(struct devlink *dl, u32 id,
>> -			  struct devlink_param_gset_ctx *ctx);
>> +			  struct devlink_param_gset_ctx *ctx,
>> +			  struct netlink_ext_ack *extack);
>>   int dsa_devlink_params_register(struct dsa_switch *ds,
>>   				const struct devlink_param *params,
>>   				size_t params_count);
>> diff --git a/net/devlink/param.c b/net/devlink/param.c
>> index 22bc3b500518..dcf0d1ccebba 100644
>> --- a/net/devlink/param.c
>> +++ b/net/devlink/param.c
>> @@ -158,11 +158,12 @@ static int devlink_param_get(struct devlink *devlink,
>>   
>>   static int devlink_param_set(struct devlink *devlink,
>>   			     const struct devlink_param *param,
>> -			     struct devlink_param_gset_ctx *ctx)
>> +			     struct devlink_param_gset_ctx *ctx,
>> +			     struct netlink_ext_ack *extack)
>>   {
>>   	if (!param->set)
>>   		return -EOPNOTSUPP;
>> -	return param->set(devlink, param->id, ctx);
>> +	return param->set(devlink, param->id, ctx, extack);
>>   }
>>   
>>   static int
>> @@ -571,7 +572,7 @@ static int __devlink_nl_cmd_param_set_doit(struct devlink *devlink,
>>   			return -EOPNOTSUPP;
>>   		ctx.val = value;
>>   		ctx.cmode = cmode;
>> -		err = devlink_param_set(devlink, param, &ctx);
>> +		err = devlink_param_set(devlink, param, &ctx, info->extack);
>>   		if (err)
>>   			return err;
>>   	}
>> diff --git a/net/dsa/devlink.c b/net/dsa/devlink.c
>> index 431bf52290a1..0aac887d0098 100644
>> --- a/net/dsa/devlink.c
>> +++ b/net/dsa/devlink.c
>> @@ -194,7 +194,8 @@ int dsa_devlink_param_get(struct devlink *dl, u32 id,
>>   EXPORT_SYMBOL_GPL(dsa_devlink_param_get);
>>   
>>   int dsa_devlink_param_set(struct devlink *dl, u32 id,
>> -			  struct devlink_param_gset_ctx *ctx)
>> +			  struct devlink_param_gset_ctx *ctx,
>> +			  struct netlink_ext_ack *extack)
>>   {
>>   	struct dsa_switch *ds = dsa_devlink_to_ds(dl);
> 
> Thanks,
> Olek



Return-Path: <netdev+bounces-94159-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C2B638BE773
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 17:31:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 521CD1F236A9
	for <lists+netdev@lfdr.de>; Tue,  7 May 2024 15:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC9821635BA;
	Tue,  7 May 2024 15:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LXo4ps7T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A09B014EC79;
	Tue,  7 May 2024 15:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715095890; cv=fail; b=m7VYuyeZtkyFkVZxwmiATu5N1JyIuh1EqPeCtk0P98NIjINgKdQR7Hvx39W6YiTO5OxihXk1bTv3N30x0Nxs9K4FQcG7K4YJq/PxZMoIKQLuNclbJJX2XFUTm5qj+8r2OejaIGEb8VCCG0oHjuCGTGQnwPdTbjn7zUJTeP6NA9k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715095890; c=relaxed/simple;
	bh=zB6olPkdmg92CMy2B3uE8AFVFvFhWnzu6Yth3VdgmAA=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=K4LDmLyhsU4CF4z7wKfHRQVoU7o9Fy+WfdHEgXaQjILf4DDQlGPWAp9qvRW5l+XNqTijJrEHM1kqv310OprDooe5Cwn/aa49DkT5J+8lhk9ySgCzvnXOf2PRyeOPKUvk2At9j77lB35nMAP1/rk6lIBJD90I30b89m3juePlcJ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LXo4ps7T; arc=fail smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715095889; x=1746631889;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=zB6olPkdmg92CMy2B3uE8AFVFvFhWnzu6Yth3VdgmAA=;
  b=LXo4ps7TOngr6D0jF90NbnA1IJTosFhREyujkO0n5vzyvV2kfFDLWi8F
   dcsJA703wnV9mjur72jBnBWfQNFDxCnlmN5okfChTbAaLsK5wpxdFqify
   Nysyn++YY3rVdF/WQqgtVpH/wN9Sx+Yj7qHC1yYVfO8EntYwahHA9BNgC
   M2+amhABeeav5XJJbeLE95ELRs/I/Ll7B7YB3F5vy3t6IwloxUeF0uyKO
   aVq/jMZ6NeJVQTP7gHfRLf7ghWZml+UTO8AvLIPnZaZQxRdDuAKWAHVZL
   N9v5WXoXdYUS3mp2zEmiIiwTxsp9WnGxu9aldkme4b3bPobHJLsrkww4u
   Q==;
X-CSE-ConnectionGUID: BUR+R0eHScGewULx59SJIQ==
X-CSE-MsgGUID: Uk884HxzTY+qYgiyHqf4Lw==
X-IronPort-AV: E=McAfee;i="6600,9927,11066"; a="14709462"
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="14709462"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 May 2024 08:31:28 -0700
X-CSE-ConnectionGUID: HHbcYi3ySDOrhZ9Zzkweng==
X-CSE-MsgGUID: 3dIy7tmbRhOLp5ipYrxuow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,142,1712646000"; 
   d="scan'208";a="59731537"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 07 May 2024 08:31:27 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 08:31:27 -0700
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 7 May 2024 08:31:16 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 7 May 2024 08:31:16 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 7 May 2024 08:31:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m7pjn8u7OHaKF0mZQH8P+qgPj9/0PmaL5Sn8m5cuwf7i/46BRaUe5Vb31onSRYml/vjDMSSFoqdJ5kjA7Xz46PugCiDPR1Lo0GZvsklyqaJdIctx7Z2A6Gd0Y1VlFN1qTcgy4RjJwPmL00WHjBK2Gq9F6orIOCCNeFRnDpvWoyQ0EAg/h3M4xCnXCf4oX96+JmgjjeSrk8yKCoPMqGABrUQoluZHowtyn45BnXQuhBdIou2VRA3k8O9Key3I7I5oJij0GbFEtIfPa0ZrtDT54hKteWGw5QojDg7Wm7SMBtPHOn+FccYVEvhk4hZ3Y3tpE6zadKWxDWKgP00w0U/zyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A+q5rozzL/XPImsXWaVi8qlS1vpjGoXxAq7vnxhCYew=;
 b=ENV4u1t3aF4H9Yd69OpOiH+y7kojuzLUL1dM015L00WGwHj16SLOryOgefjNsAQz4RgtFASdLo6Bp2UNTP7lFM3knjaQzEIpVjAT/ijEvFvyWEXSu1VI+cPLbUkfwbDK837cZW3ud9Kb9bFadhMOpnIXSDAO0D+w0kHN4RIvtoSXxP9cOIiiaaW8SYY7lNLvHe2F1euSVCyRbVOkKSeSfT2+KYw9ex6vcL+6vYmn6m34rSetj+yWwn5ItzNyziQxH41zYuwD+8PA7qigskuwaKYqPHxCJF8NkzJGilYN9GD0Q5iQh6eJYL5Szq1KkGGozaQ75JFuf1WivWxeUxLaxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN6PR11MB8102.namprd11.prod.outlook.com (2603:10b6:208:46d::9)
 by CO1PR11MB5203.namprd11.prod.outlook.com (2603:10b6:303:98::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7544.42; Tue, 7 May
 2024 15:31:05 +0000
Received: from MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb]) by MN6PR11MB8102.namprd11.prod.outlook.com
 ([fe80::bfb:c63:7490:93eb%3]) with mapi id 15.20.7544.041; Tue, 7 May 2024
 15:31:05 +0000
Message-ID: <615c756f-0f0d-4cc8-be5c-70806bd9843d@intel.com>
Date: Tue, 7 May 2024 17:30:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] netdevice: define and allocate &net_device
 _properly_
Content-Language: en-US
To: Alexander Lobakin <aleksander.lobakin@intel.com>, "David S. Miller"
	<davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
CC: Kees Cook <keescook@chromium.org>, "Gustavo A. R. Silva"
	<gustavoars@kernel.org>, Simon Horman <horms@kernel.org>,
	<nex.sw.ncis.osdt.itp.upstreaming@intel.com>,
	<linux-hardening@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
References: <20240507123937.15364-1-aleksander.lobakin@intel.com>
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20240507123937.15364-1-aleksander.lobakin@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P220CA0010.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::15) To MN6PR11MB8102.namprd11.prod.outlook.com
 (2603:10b6:208:46d::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN6PR11MB8102:EE_|CO1PR11MB5203:EE_
X-MS-Office365-Filtering-Correlation-Id: e3045e7f-8fb2-431f-1e63-08dc6eaab5ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230031|366007|376005|7416005|1800799015;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?djJXZk9UZjNIR1hmTU9vclJ5aXNvZVZEL2JSczBhNE5BT0VaMFQwU0V2bUtR?=
 =?utf-8?B?ckpNamJYOHZlRFdLRnlaY0tza09yVm01Q2o2MGwrdzFXaStvK3IreDJyNFVv?=
 =?utf-8?B?NWorQVp0QUFmdUJKZ0hrVkJNcDk3TXhLOHAzc2h5WGRnNkxsbWo0NkZtN1dw?=
 =?utf-8?B?Q05zVU9NbC9OSXpBdUJCL3pkN0UrRXZSdm9PNHVDc1p6V21xR0NRTUdrVVBU?=
 =?utf-8?B?RXRNWTZpSzE2c0FMM0h4TG9ZOFdScVE2QzYyVWxvd2hBWmJxQXpzTEdmdERC?=
 =?utf-8?B?aFhFRGZ4RTV4SThBcU8wZFp1RFAvVTU1MC9ZWHdqM3d4SkQzQjAxRmdvSmti?=
 =?utf-8?B?Smw1ZnBsOU5sTzF1THJITjhJL3RkczRmb3BSYWdDVG9uYVVHUEFLRnNPR0U5?=
 =?utf-8?B?TTFDdlJPaDVCakdCY2ZaL3lnMXRsQXQvaStaYi9CZjQ5TmEzYjVxSzVpWUFT?=
 =?utf-8?B?RC9KRHF5ZURtVjhNQ3FZY1NtbS9JY2Q1dHg2TGZLSkMxeU14VTl4M0pOZlM4?=
 =?utf-8?B?MWZvR2lWUjEzTG56RnFMYnBwdFZUeWFuOXNqSUxnVGpaNWp2NEpubjViQlcr?=
 =?utf-8?B?NmZQc0Eyc2xGTFo2bkpkOE9OQWE3b3NGOGhIUUZYZ3dVdW8vQUQzUzJGclFR?=
 =?utf-8?B?Qi9mdTZxZDg5WmcwK0FPWjVhZVZ4R3Nzc1RoOGRoUlVpckMzZkhzSTBGeVVs?=
 =?utf-8?B?NmFjSm1PbHBQWnZLZndYL1lweXRjanlsM2UzUDVSSktYVFZZcDhVMktwN1I3?=
 =?utf-8?B?STl2YlBUTHdUOFBGcVFxNG9RTVBobG9KQ3B2aHNEV1ZwOFkvS1ZkaFF1dDcv?=
 =?utf-8?B?Z3Y2dm9meE5zZTZ4MlEyWVF0b29zbVNiQ29YZFZnc3VRN1FaM3ZLcW1LTG43?=
 =?utf-8?B?UFlhaFJzdi8yTFlYVi94K0dVWm1KczllaEJFTWJsZHFvRW15TDE3MHk1Vm1l?=
 =?utf-8?B?aXI2a1ZzUGZjbzVSQUtJTDJTRmFZd3E5aU5oOHdaSUE1VzA1dVhqMHVjMGpT?=
 =?utf-8?B?ZHBGYlR2S09VazRXOFFyODI3Qk5GZFBmdjF4RlhuYVoza21hK2R4TG5CMGZP?=
 =?utf-8?B?ajVGbDZRSG5JQXFHKytIZm5hYU5MMG1LcCtMQ0V0SFJvQjFoWkJTVUw4c2lT?=
 =?utf-8?B?MDFnREVyRnRpZ2ZTa1ByQThyenE3TUpzT0VsUkpTdDRqbnN4ZG9OUDdCcnBa?=
 =?utf-8?B?S1dDMkl3NUNsUjVIcm5pTThjOE5mNHBpZXRQY0dBbEhDMmlFUTMwYmJUZ3Y4?=
 =?utf-8?B?d21YekpOaUp6UjE3WEJCU1FPcXlTTml4cG5oVzE3bk5rSVp5OTdCNklsYmE0?=
 =?utf-8?B?dmMrZEsvT01la2tJdy9GMTdLOE5RNUx2UDhBWm9JWTB0WUN0cjJWNmViV1Rv?=
 =?utf-8?B?S1hBQmw5RW5UbHdtTkJiQWl4SjgyaWVrTUtuVDZoY3FIb0Y4bFF5Znp0UTdC?=
 =?utf-8?B?T1dUZFNFMlJSa25hakcwRE5NU3JOaVdEdDl6T0t1MnZ6ZGNSNzhLUStBT1Yv?=
 =?utf-8?B?ZWJKSVJ4ajhLT1cxeVYxSi9FQjdXaGt3MDNJRlUrYlZlT3lqdGNiWnBrZEcr?=
 =?utf-8?B?L2NlYlgyY0UzUU94VXhuc3RxaDNrUUxmK0Q5UVBab21vZTdQTlNES0RJdUhj?=
 =?utf-8?B?UE5lQkhtQko1RGJQQmpkMnF1a2p6Wld6b2xvbVF2Zmw2WkNhSDBNUEN4UE5H?=
 =?utf-8?B?aHkwa0xrdDNIOTQzcXRwQU92Sjl5MlNBVHpSdDIyaitRbmdkejRZWWRBPT0=?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN6PR11MB8102.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SkFYVHJMblo1cW1sNlcyUXMrUXJCd0hINjhXeUEzUlpPRVNlakRNeGNoams0?=
 =?utf-8?B?L2wrNVVNdjhWZi8vQWJsVHE5b2tJbkMzd3lVUzNhVHhRMTU5c3cvVS9oRHBj?=
 =?utf-8?B?YzhVV3pKK29JVU5YWTFmd0ZKN2dndjhRclFxbEJZUWZvOGlCdFY1TXZpYmxz?=
 =?utf-8?B?bDFyMkRHdXVSb0JqVytTSGpiNGFpN2RjTTlZczJpeEw1WUNka0VGV1VZSlhY?=
 =?utf-8?B?R1BjZWkyTUFUbW9sU2ZKbVRVZWorVlVrM255R2VBMjJBZzYrNkQyN3BEV3Uy?=
 =?utf-8?B?WTlaUlpnbmVncURHR0VyZHR3d0diRFFtVWRrZTdkNDdXeC9mdDJHQWNyT1JL?=
 =?utf-8?B?by9xcUxGNUtnbWRwdGtwVEgrd21VNWJ2a3lhK1ZjRDI3T3FyVmhiUmN6dVlZ?=
 =?utf-8?B?OGFFdlR6ZW5lL1V4ZDdDMXNlZjJhYjJkQ3R6K2RUQmU5cUprdU5FNWpDd2VN?=
 =?utf-8?B?YXR3dWFFM1poUGdRT25tMlE3MFlJOENVMHFkZlcvZU1jTElDYkduOU1sNGVR?=
 =?utf-8?B?NUorRXh1VUltMkhta2FqQ25jNVJpS0ljMnR6emhNb1ZqWTZkdnl3RExNaVV4?=
 =?utf-8?B?ZkY0L0QrVHUxYkMzOUJZeVozSEoxcDlQUVA1MWZGaVAvcms1MDBsMUR5R1gw?=
 =?utf-8?B?dXNqQ2FyVVN0dTAxOFBRbHc5a1c2cXc5UExIQkVDWVBFbDJSbDhjYzVLMXlB?=
 =?utf-8?B?SXBSQkJtUDI2ME91RTV4VWJ3NTU0WEdKc0ZQTWpLVWg3OXR1RENjeVVmRjdi?=
 =?utf-8?B?eXZVNXFSMDdmUmppaVZ5M2VZMTdsK0R0UmJkS1hWMlA1dUxOaVhTNWxYZ2Mr?=
 =?utf-8?B?ZTRrdXZEckFjNXRQNngwbE8yWWtJa2VLMDRKZFozb0lGaTR0OXJhSEM5M3Bo?=
 =?utf-8?B?S01aRzRqZzNGYUJScUJiS21NYlRaU2FXOHRUUnNpS2ZBSENseUVEbGNZOVc0?=
 =?utf-8?B?OUNGcG1XbTM2aWprdXVEUjlpeC9jVnMxQTdIWENoTHpBZWFWTEl4RWJneEVi?=
 =?utf-8?B?VGdMclZnQUdGUU9RV2VlQVBjaWVTRXFGQ1ExdWV3SGJYN2FaeXFrS2x2d0Vy?=
 =?utf-8?B?Y1dFY3BvbDRUdFhwbFRQWC96MFJxZHoxWklYUkxZYkhvRkhGZytqK0Q0MkFn?=
 =?utf-8?B?L0dra3FocEcwTnRPOEZ5R1p1bW5uVWRaSU5tNFZ2VXdqM3pMS0NDQTRDblpo?=
 =?utf-8?B?YlowMklsSmFHYzQwaEdVbUx0S3F4L3lPNkkxQ2lnMFkxWGNQcjZwNmxNSDVi?=
 =?utf-8?B?SFRkUG8wallaZ1YzUWwrMVBTaUJCem5HeVlNdXV1OUZpUUYvSDNOdGE2NEdL?=
 =?utf-8?B?TXd6QUJPcUZSS2ZVVTlsS01UQnVGNzV4WHgzWG5VK3UvNmIzZUxwdStzVXA4?=
 =?utf-8?B?L3NkbHRBQk55aWFFQmZxS3dGQ1pYYmIyeVQ3d1BsZldvR3ZJWUYya2dDbmZH?=
 =?utf-8?B?VmlMVGJqdWlNTWNWSDFwT090UWNNN1doaUVUUWZWbVNReDBEbW9mVXh0ZlJT?=
 =?utf-8?B?elJyL2JxT2w1ZkI0Q1RvQVJLc1lyOHBEdjU5cWdVS0R5cTJvMTFNeXBCK2pT?=
 =?utf-8?B?Qlk5Yk80Wmw4a01wVWRvcXJhRTc5SHlGbng4Qml2NjlOWUZhUU9LT3h0SDFs?=
 =?utf-8?B?aEMzU2NKeUF1MG1sZEFXdTd1b2VkUFZzZ1ZkWlVwQkhFQW54ZG1xbXdRbGxD?=
 =?utf-8?B?MkVXRWdoeXJHb2ptRGRNL1dmcWpZeU5Rak9ROEFTMmZ2d0Q0ZXNtdmkyaFJU?=
 =?utf-8?B?U3FmNW00TUs2Wkd0dmZWV2dNbjNVZlNVU0FBd0twU0Exd0g1VGhpUUtScVg4?=
 =?utf-8?B?YmNPVzI2M2s5L1hUelZzL0JHdXhyZ3RJQ3BsMXhNZzgrVXRNMDROUFc2TGVH?=
 =?utf-8?B?aFg4VWRHNG4yaDZHbitkOVVSTU95cTkwbzFIdERjU2g2c3dzS1orRFQwNWpm?=
 =?utf-8?B?elFUNkxvak45TEZrZGdIRkZGWFRGUWJDeDY1VDhWN3RPWnBzT0V4NnVUUkth?=
 =?utf-8?B?QUpqL25YV0svRVp6b2dKc21SZHZZL3Vxd0trNnh3eVZvVDVzdWpFKzhhZ2FC?=
 =?utf-8?B?dzJZRFF4eUFtak1FcElwOTRNMEFyRVUxZzFpcTJpeGl5a296RG40TDFJb1dK?=
 =?utf-8?B?WHZNUkhFbEpSdHZMcFRacjUwTGRwb2hveFlDdEZFY29qV0Q3eVlCQkJXaEpn?=
 =?utf-8?B?Ync9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3045e7f-8fb2-431f-1e63-08dc6eaab5ed
X-MS-Exchange-CrossTenant-AuthSource: MN6PR11MB8102.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 May 2024 15:31:05.6988
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Ngv3piF5IXzTZg+tTya3cXR5Infh+F674demqHgoIBYii5OoWrLCGE543J5ZbqZyqicwnVEsvtvKUZ9PaksqxCUVIN9Ccurl1gFDW8rw9b0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR11MB5203
X-OriginatorOrg: intel.com

On 5/7/24 14:39, Alexander Lobakin wrote:
> In fact, this structure contains a flexible array at the end, but
> historically its size, alignment etc., is calculated manually.
> There are several instances of the structure embedded into other
> structures, but also there's ongoing effort to remove them and we
> could in the meantime declare &net_device properly.
> Declare the array explicitly, use struct_size() and store the array
> size inside the structure, so that __counted_by() can be applied.
> Don't use PTR_ALIGN(), as SLUB itself tries its best to ensure the
> allocated buffer is aligned to what the user expects.
> Also, change its alignment from %NETDEV_ALIGN to the cacheline size
> as per several suggestions on the netdev ML.
> 
> bloat-o-meter for vmlinux:
> 
> free_netdev                                  445     440      -5
> netdev_freemem                                24       -     -24
> alloc_netdev_mqs                            1481    1450     -31
> 
> On x86_64 with several NICs of different vendors, I was never able to
> get a &net_device pointer not aligned to the cacheline size after the
> change.
> 
> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> ---
>   include/linux/netdevice.h | 12 +++++++-----
>   net/core/dev.c            | 31 +++++++------------------------
>   net/core/net-sysfs.c      |  2 +-
>   3 files changed, 15 insertions(+), 30 deletions(-)
> 

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>


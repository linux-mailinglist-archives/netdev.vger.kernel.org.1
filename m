Return-Path: <netdev+bounces-187161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF161AA5618
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 22:49:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 15F95172395
	for <lists+netdev@lfdr.de>; Wed, 30 Apr 2025 20:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3546527467D;
	Wed, 30 Apr 2025 20:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Pvzry8D7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D901DE891;
	Wed, 30 Apr 2025 20:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746046175; cv=fail; b=Q9zS8X0xrc97qW0B5JD8pCg57qJwVKfz2sj2/98b4Wax7TNoIott6/ATS1R96W3TDOZlaE4oPR2f5fylbLBHNAUZHJmAnltftRIGZp2W+fW0TBQwWYdz1jpnivj+pIPeloJRIFP/+SmhkC8oyFpwcllcyO9O5/nGcpfH1Cp29i8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746046175; c=relaxed/simple;
	bh=yVrDBsKfz39NO9eQj6hEfmFLXddl1NCdAnSR/NoF9Bw=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=QQuyHPbzpnAhtORSMx+sBWbA1c0sZIcBpuTvlRJyO/RVIzgKN64ehStAXouXAruMvwsad8MIj8R+MoDErTDVnFuka9qd9fAY4zYpOQ5LraHoDcpvSm3jFhoutAyFVo3i4JVVWZv1/o6iQWUElVkOW72coi1O+LKknSsFwWwvA6E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Pvzry8D7; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1746046174; x=1777582174;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yVrDBsKfz39NO9eQj6hEfmFLXddl1NCdAnSR/NoF9Bw=;
  b=Pvzry8D7VD+acFZb1z85Hpb0huN/rjsw6vsim9YDe1dfhGYRU8UQUZzc
   tnrXTxZFGPyBz/lgOfHC1JtUZy5FPwRBwuNOYFpl3CPFpNhvwIQFpFiUJ
   /HAvap6q+nm3uTrSZIwNrzkQYGT2s7EyMwqwfAqzXPYcFG0PuXsIXIg1U
   PM8qxRSbeT62BWsgpsbVmLk717RJpEzfmMMCjCj53xg8vlm+OFEDOWeDd
   9Nhvd2rGW+OGIbHQ66xNl5jbKQzesoZsZTG7kL70jz3FLGOmVjd+6+vZH
   2/vci3a+SnczIg4Ye/zFlKkLks5UMfe12TTaitGJht7aRhttafPaJIOjC
   A==;
X-CSE-ConnectionGUID: wb/r0FlLT/2fQjsM/++u+Q==
X-CSE-MsgGUID: VMYSb9+fSYSA1ilBK6bwdg==
X-IronPort-AV: E=McAfee;i="6700,10204,11419"; a="59101782"
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="59101782"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 13:49:33 -0700
X-CSE-ConnectionGUID: ACjdUbPzTruPXzOVkig8Fg==
X-CSE-MsgGUID: NBw3rRnbR/CgdzjjoEOAxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,252,1739865600"; 
   d="scan'208";a="157463595"
Received: from orsmsx902.amr.corp.intel.com ([10.22.229.24])
  by fmviesa002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Apr 2025 13:49:32 -0700
Received: from ORSMSX901.amr.corp.intel.com (10.22.229.23) by
 ORSMSX902.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Wed, 30 Apr 2025 13:49:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 ORSMSX901.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14 via Frontend Transport; Wed, 30 Apr 2025 13:49:31 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 30 Apr 2025 13:49:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H8B8e5DC0AvPPJP2HVUYcqHaUA5mv2Jh54TDlzCCGCnOZ3VlSIbJ4se9gPWa5ucZPUPYK4S/lQbWJS4cnxUX960JrqR/mW/nVpomn41FYvfayXikIQeJmlQrUvc1nh9KsYjwmhzVoy3gdOZ0rVn+DgesmcPMNIPs6Vm9W5528TZdVubL3y90vLAqGzxZnD1+Y8S3edsTXSgCVOtKQgk7dbvBcQu0DfcsQfg3LKyyFuj1tzOaNpMUmDM6Qlh4jjaTE1kyA/I1HMuaG9ClJ1spon/bOrg0ZdRfUAcHy4fPAi/SSPF+Te3LesKgsKEPq2ZJAKMVR0ZH3dSQOi+AgwlM/A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YrFtRMDwsFmREWQtTx9ciodlv+YLN1k6HueRFtq1pHk=;
 b=yYWOOELJC94CHaOFY14B0qjPiPSnRW2xQbV5KSIrnHJg58q5AZQs6FGv1ASe+rdhzid1K31zC9M5d71TvmErYEyp5BWiDuf/CKVSj2RQootcEqhl6UT3h8mXdeopeounAAMhfq73HsRw1NHkkkrovowOJEBJ6eQtxjL/gi8wiP0XxuwqPkPg1vI+ydA+M2gW1UdduPpXf6wfn9lwsAl/R2i0UIfD9G9SL9AcqONyyumK899LN6ZXHfz+BDcJIFuFce+bM8FRpapQk/kY3SNDEtMOqcD8IGqYkR8VNCDxSBY0Qn0zNOaRLXQ9JW5Bkc80srKkjgRRo4jxI6duftJOSw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by DS0PR11MB8161.namprd11.prod.outlook.com (2603:10b6:8:164::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.34; Wed, 30 Apr
 2025 20:49:09 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8699.019; Wed, 30 Apr 2025
 20:49:09 +0000
Message-ID: <66490186-3b38-44ca-b163-d53f623a3deb@intel.com>
Date: Wed, 30 Apr 2025 13:49:08 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 net] net: lan743x: Fix memleak issue when GSO enabled
To: Thangaraj Samynathan <thangaraj.s@microchip.com>, <netdev@vger.kernel.org>
CC: <bryan.whitehead@microchip.com>, <UNGLinuxDriver@microchip.com>,
	<andrew+netdev@lunn.ch>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
References: <20250429052527.10031-1-thangaraj.s@microchip.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250429052527.10031-1-thangaraj.s@microchip.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR02CA0008.namprd02.prod.outlook.com
 (2603:10b6:303:16d::27) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|DS0PR11MB8161:EE_
X-MS-Office365-Filtering-Correlation-Id: 4ab3caea-99c4-4a86-b716-08dd882874cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|7416014|376014|1800799024|7053199007;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?Yk5jRGRtUE9tNi9pYmh2dlI1cG5qSDY2NG5pRlc0OUdpUmt4aG5nWUl0bGZn?=
 =?utf-8?B?cEpmZ1lSYUpNZ0pqZzFuTWkyazA3MlhEWFF4Qit6RzNJTkM2djhsVko4YUow?=
 =?utf-8?B?MXVkVlFBZVBSMyt3TDVuTURzYlNaWHJRaE9BSFViZmJyTENlY1hYeDFFUTdq?=
 =?utf-8?B?VnRlODFZTlAxTjVlTE5hTUxHV3ArbjB6RHNvUjZLZnZpR1M1K3hsa0RSenlF?=
 =?utf-8?B?RkE2WFpNSXNwT1FhRi9TYXp0TmRrbklreDMrdW9zZWFoZ3E0VWRxbmV1ZWFL?=
 =?utf-8?B?bVFLZVRxKzhxRXdnRlZVNjRxY0hVTHJPRXFGM1JiVFdnUk42REVLVStQOUkz?=
 =?utf-8?B?MTdLSkZOV2h6RXorSElkaWVWdnJaYlp3QUNzbkZlSktSZkdaUnVyN21wR0hl?=
 =?utf-8?B?bWZzeW5xbjV1bEhFV2ZIeThUb2hHRFZFNzd2VlJQdXh1Nk15bG5xUkw4TytL?=
 =?utf-8?B?bVpEaXh4T1ZrRHY2a3NLSmNDL2dZOXUyQlQ1Njh3MitabVNSOWU1Yk8zaEV1?=
 =?utf-8?B?WnJ1ZzRUY1FhTFIrQ0xpVG9NMjl1OEJWYzU5TGhKRVR5NXRUQjJpdUFHL2VF?=
 =?utf-8?B?amh1L0UyMUQxbkI2cUt1SzBQRWNYOWpocm1JckdLRlVzQnFyUi9kY1ZvQ0Nq?=
 =?utf-8?B?T3hZSUhzK21FUlkwNGxRT2xZTkpMckhkWXNxbFBrUUhJQmViM1QxaURXUi9F?=
 =?utf-8?B?QnBDb09YZDNhK1p0Z3lZbm1yNDdXZC9uTjdjWnNoUFgwdlZiL3BtekJUYXJS?=
 =?utf-8?B?UHpBaGxYSnB3bFhQblR3ZW0rUFBzbDhWdEo0akpCZ2pLQmIwOGdWYzFoKzNQ?=
 =?utf-8?B?bkZHZGdXMUoyVUwvelJGTG9SSWkwZGI2THdhL04zTVUrYXVjc05kbGdnd1Bh?=
 =?utf-8?B?cGlxTnN1WlNzYWM0MHM2dE16QUh5UnBNa0oxM1lSSUNQZU84czdsQkd5Um5o?=
 =?utf-8?B?VDF0UW1iSkxWRk9CT0RYZjdhU2M5Mk4zejNYbmpXeS9ScTVkS3o4cDlWdnpK?=
 =?utf-8?B?amxHM1FqNUcxREdNY3AxMFgydzRhcldKYU11K1JFaGFzekxCNHAyQTFZL3Bt?=
 =?utf-8?B?OFhuRlkvQXJpcEllZEdPbWRudmQzRE9ORjBJWVgwSXpFNzZWS1IwQy9lT2li?=
 =?utf-8?B?OWtWaEY1QjA0RWNoMVdsZFl2UXR3R1c1RHdqWXl5cE1XaEVPT0FHUjFkaXJG?=
 =?utf-8?B?ZUxYVzFFalRQNXpVUVJlZWR6U1Z6WDhNRmNiMUpUUFZtWEJyQkl5Z0l6ZmZs?=
 =?utf-8?B?WEdZbW92b1ZVUEVscVFCTnBmYnJjemFQdTVuUUNqNkVNYkpCREJldDMwMmpm?=
 =?utf-8?B?N1oxSG5Ya2gzaTVwNUk3VUl5Zm5jZUZWNnpoYnBVYXRpakdMRGovMExOZG1Q?=
 =?utf-8?B?UWJyWHFRYUFjUjgzR2U3Q0krbjJ5TjliQnUyNHFtOFFIemQ1cmp1QXd6aExz?=
 =?utf-8?B?UkJsUFBWdVovM043bnVjTGdsUGk5SG1Kc1dUZHJsU3F1bCtIN3JDK0JFTzF2?=
 =?utf-8?B?QWlmWFl4NWlqUGdlVHBNejN4SW9iN0ZkN1hERW1KZTNmdWlCNmF4OFdYb05w?=
 =?utf-8?B?ZzBjYTNDUzluT3F0aC81RStvY25pV2hRcVF6VVhNbVI4cGMremNOV1RCbXhX?=
 =?utf-8?B?ajJRWi9XSGx3M1pSdDFkeFhTQk9YM2duWDVjTTd6Y2ZqT25iT0prOUUwRUho?=
 =?utf-8?B?TTR4Mm1sQUxaaEIyOG52eE1mVGt3RmxVZjJMVGpDRFNnQ1NENE91d3BpVnlZ?=
 =?utf-8?B?OFFCYTNHc1AyRW1zcUdUVHE0SWp3V0FVVmhna2l5ZTM1ZnpBSTFTMHEzL1hH?=
 =?utf-8?B?Zm1RVEVsTEp5NnlTRkRjM05mTmdqWFRXZ041VTZTR2tCYnNncE5NWllaN2tL?=
 =?utf-8?B?eVVOSEZSTG5pTkY5UDZVSDBGS0toWkpwVUNqS1dhMEMwZFV3ZXVRenZOVEUy?=
 =?utf-8?Q?Jj0fwINxIRg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(376014)(1800799024)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dHJnUGZIUkw0Q01zZVY2U0tOOFFCZTZ1VXk5VTVxZkhpS1U1ZlJJaVFTSE9Q?=
 =?utf-8?B?VlBKMHpQNy9sdXdEbEVHcTJBSTJkWDM5WWVTTE1iT0VWNFhsOGw1YmQ1TWlt?=
 =?utf-8?B?UTB4Wkd1VTFFd2Nhcm9KdWgzYlg1WDBLTlFhWTZvSlJodlJtTmZ5bzllbCtG?=
 =?utf-8?B?M3YyRnAvMGdHTXdFTU5tTkpEU3ZaM2FTY3hIWXRNYy9mcjdQbGJBT0p2Tk8z?=
 =?utf-8?B?TFdEUTh5YzcyaTZ0cnV3cVVibmt3NTdweFFDb1M3Rkd4eXFEcEFZT1VnMENC?=
 =?utf-8?B?c0FjcUF3U0R1NGNqV1lYMVErQU15dXZpczFLbGtyY3l0OGNsMXJyNHVMc3Zh?=
 =?utf-8?B?OXp0L0NlaXF2Q3hyU29PT25EWXM5ZmlHSW5zUTh1a3RNWmRESFZtSHVMZmZC?=
 =?utf-8?B?b0F3aVJYM0hPTHNNdVptd20xdW9RMC9ZMHl4anh4M3VEbEppWW91WEM3eFRM?=
 =?utf-8?B?eWw2cDRlNlVkTkhJK1JsVDhPOHRhdEtQVDZSV1dTOThsd1BreHBNZERlaVl5?=
 =?utf-8?B?R1B6S3hQdWxabGRScW1xQnRsaThQMXd2RmY1ZG11MGx1YTdlUVZvdDhhSXE0?=
 =?utf-8?B?UXBSWDkyMkFnVEVvT1NxMGlIcUQ5WFIvOEJkMjJUUWE4dTBPZnFvRGJJUVRv?=
 =?utf-8?B?cWVRMnhYbHVYcmhSRTJHYkd6d2VmTEFYS1phVU8xVkYwTjBhQ3hoeWRqM3pY?=
 =?utf-8?B?bWNBeExiTTE3djhNSm5NUXl1K2pzNGRhWE0zMnRuTCtGVVRnM25Rd0w5RFVF?=
 =?utf-8?B?YXl1aXFVbTF0b0xRZHZuRDVkNVF6d1hpK2lHbFJTeVRJalFBOE1LNFAyNjcw?=
 =?utf-8?B?Z2xIeDc2d29zNkRCZ3VyRjJ5NzBSREk4WW1RTXAwajNpeUpXemNmTzk3Uno0?=
 =?utf-8?B?d0RoNnQySHRxMzF4VVRoRGdleE5DNFJockRTU2NvTTg2SGU4Um9hSU42WGp5?=
 =?utf-8?B?UFExMll2SXdoemN3K29XVnk0N1lMUnI3UFJ1VE5rQXdReTVrS01FM3ZUVE9L?=
 =?utf-8?B?N05sR2hMUllqbUk2OHU3L0tFSjFTSExVb3ZtMklzT3VvVkVvTzJwcHo0M25L?=
 =?utf-8?B?R2ZodVpzcGRJWHRFMnpKVDd0NGN3akF3MllvcmFLZ0Y4bzZjU1pQSk1FdEU5?=
 =?utf-8?B?Vlh4VHdZNnkxYm44M0FZWjl3U1RHMTlES2tlY2k0MXB0dnBPN2UrV090Vkpi?=
 =?utf-8?B?UUQvQUZDMTFoQVY0eUs0bmcrRkhXMlBjZVI4Qkdjazd2UHpJUk1oanYzZmNz?=
 =?utf-8?B?NWhWV3hIeENBQUtVQit4REVsd2YxRzcyQXhlTldnY280eS81cG5QbXdIQyto?=
 =?utf-8?B?cmQxc0M5aUFqdnRhdlc4ek45V2Y2WXlBODVIZ0lRTWgveUgySjZoQldzdU1q?=
 =?utf-8?B?TDFGSU1ZNzBDSWJhWWVzVDgrUENIVm94KzQ1Qmw3cDB0MURTMElUOWFzSWJI?=
 =?utf-8?B?TzVNOVc2aEtvTGlCOUV1L1FFcFpUSW1EL2xzTTJ0YjE0V1NDTFlVaGkvOFR4?=
 =?utf-8?B?NzZrbUI1MkdKL0pHU0tybWN3eXhKZXpLN1g5YUJ4K1NRcm5kK2JYRmFMNStK?=
 =?utf-8?B?aGowdTdZLzRqd3I1cVpQRzVSMDNvMVhScElmc0p1M0Z5R1FETGU2T2x1K1JV?=
 =?utf-8?B?ZTljRGtkR2xaMXQ0WGF0ekVNZjJFdytTT0pQMXBNWXZmKzFLbFZ5UC85ZENP?=
 =?utf-8?B?cng3V3RsUjhTd000NnAvV0FvVlBZNTNCRlhkOUpScFlRQUpUOGVESmsyU1F0?=
 =?utf-8?B?bGsyL1E5RlBQcXJ1OGtvRHhtZHJUUW9tMitVZWhrWm54THR1ZjhCa0JPTlpp?=
 =?utf-8?B?dStPYUNqQ3VYRys4WHpqSU5UWjh1c1p1ZC84ZjVnQ2NkTUw4VmREaTBhWStQ?=
 =?utf-8?B?cERlcGVGWGxpZlNwclhTYzNrbEgvUnMzNkxVM0JPeCtweU5TWncxNHpyVnFY?=
 =?utf-8?B?a05HbUN4ZjB3MFE2L1U5TmVPSzhmQmRDb1pVZXZDYzdwaFpCRkZpNDV6bk1i?=
 =?utf-8?B?bkJyS2V2K0JDczhTUW13MVZNRHNmWHJ0S25rd2F2dkkzTVJuQTd6T2NnNWdo?=
 =?utf-8?B?RW85eUJFYkhqUHJCVnJNYjMvMTUwd3JKYnhCalpvNElacnd1MFNyckYwQjBt?=
 =?utf-8?B?TjZEM0lQSjdmZzlDNG5lR1ZrNTFGc1FXNkNQUUF3M0haR25Xek9ZcUxIRUd1?=
 =?utf-8?B?WGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4ab3caea-99c4-4a86-b716-08dd882874cf
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 20:49:09.7493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OFxc6bcxCDnHiKnvl+5mDQjdlZNw4jGRxwAKb6IFEpLVLGKM7JPR9tX3DNSyK7ncnkRXlynKTwyYIXXfHSJ11G0AF5IWXuatFNF7V3FQAkg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB8161
X-OriginatorOrg: intel.com



On 4/28/2025 10:25 PM, Thangaraj Samynathan wrote:
> Always map the `skb` to the LS descriptor. Previously skb was
> mapped to EXT descriptor when the number of fragments is zero with
> GSO enabled. Mapping the skb to EXT descriptor prevents it from
> being freed, leading to a memory leak
> 
> Fixes: 23f0703c125b ("lan743x: Add main source files for new lan743x driver")
> Signed-off-by: Thangaraj Samynathan <thangaraj.s@microchip.com>
> ---
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>


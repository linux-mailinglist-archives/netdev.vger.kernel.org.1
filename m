Return-Path: <netdev+bounces-163325-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25BDAA29EC6
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 03:27:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6DB383A7FC4
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 02:27:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0F9136358;
	Thu,  6 Feb 2025 02:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="N5Ai1+Wo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 729DD126C16
	for <netdev@vger.kernel.org>; Thu,  6 Feb 2025 02:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738808868; cv=fail; b=L1KvWqLcUgOnVeCb5qLCJXXz/4l/7nHhhddSkjezUNcrd89KHEzL9Ap9g3txBT1zrhyElo87iHTE8AB0tGOHR9TiPYfRiXW5/2pfzV/ndEAQvWle9/yncgjTsS7r01LqlqZoElp5+SB5qhQKH6+Mj0jwnaTrCsId9fLGnFXGxo0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738808868; c=relaxed/simple;
	bh=1szrXoXvU8LbDYyResGi0YvmHPWIoHtwKv1w/MN/qjg=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=Rgafu955+KFF4djZQ7UtfJncaB+TwxFLvVjNfrloCqtZlPhT+UJFz1V49NG0gMfBWlHK5aNGqbssRr0pTg1PHmb830KQX93CE9h/fvoGjvDiKZ84c6NSWdbpZZHD+o7MVThrSRF2/d7i+Vqd1WuIYCU+I5UCWAgB5zsSkKERom4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=N5Ai1+Wo; arc=fail smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738808866; x=1770344866;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1szrXoXvU8LbDYyResGi0YvmHPWIoHtwKv1w/MN/qjg=;
  b=N5Ai1+WoLpBlWsh/Sb1GAwsstTK4T86aQ6QusuQQk1l7ZroD+ccxuk4j
   vvZWWX3so1bmIURTxi/XEO9aopa8qHH7SGQfWyjqKkWBygpkibENRNafq
   fnI07K1CCj1KNL6ksMCmO+ZQhy3n9ptf+5yIYGH4B5KfvGG7JsMhngCfR
   xi8YBkqoBHNY+KFKfLGnYqX5ku0TyGYT4fkSJzNkhvw1/S0nXgUteX2O8
   Fft6snxgR1dzscFnN4fIv2a/JHUgYm1m74JtrC/w49f1fGzz73+/X0FZ+
   B96yVOHvbb0g2zVitxoTsbFs8ryGVHJFA9hnC02eiCePowBeASe+2Bl4k
   w==;
X-CSE-ConnectionGUID: L4Y7tLmYQK+kCeCnLLdPOQ==
X-CSE-MsgGUID: gnVvVCSiRxOekttqGrf7bw==
X-IronPort-AV: E=McAfee;i="6700,10204,11314"; a="39514673"
X-IronPort-AV: E=Sophos;i="6.12,310,1728975600"; 
   d="scan'208";a="39514673"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2025 18:27:45 -0800
X-CSE-ConnectionGUID: iWuIMiVmSauqzz5ymtJfyg==
X-CSE-MsgGUID: HmeopHrwTyCtzHjIEP1gOg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,224,1728975600"; 
   d="scan'208";a="134313523"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2025 18:27:45 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44; Wed, 5 Feb 2025 18:27:44 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.44 via Frontend Transport; Wed, 5 Feb 2025 18:27:44 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.44; Wed, 5 Feb 2025 18:27:44 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GWVE3V1q7GcDQaNuC6C3yQ7lQBGDiVzK27WSUJhJhVnikS5LDUr0iJhP/QYUnr1BRRhyDwvosXtNqKllohKLlCfpKkhnUgQbbaqcUWPVfFSUAJH0iqt5DbeZGZZgah3DzVvAw+dgjcAgMBG/zExQ32cbZZH6hANJ1CfxsHiQJGLUVA2EO0AXbYUmG+NdFqzNfPD11dDF89GB0Cbn/Vti+QasceM0SNXzVovDvLKYqLHwWRCPxW7+0qC1p+0TCYcgHAFZwgnMFdqrEP1IuTHiJkURUWVLcfJmhqf7eUI1eEbMlX6EecK+obI60D1Nyi8faxcB+31laQzWQbHReMW8jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FQLKqAeHvkxIzHhz0Q0dMTpDJcsham1T/f7pMoM4oGc=;
 b=XREMw+U9EcGio5XId0tPsbr5oIvGHgWH8lsCXCQk83jY2Am/DU1KVmMs/CEcqOwYkhI5ZwQ2y2EFAuH9Zlf/kY9sOgwml01GomjvVls3bv9xHXUjtL97AfAanR7oKmUVoQy363x+iut7gm8Rdh5mXIkxBHMG9fmWuTFhh0AEKGH7uLlTzxDPgu284EJFRxi0qSImuiTP2tBXorFKhBcXYOi7QSZPGey9D1peKs5z6VpjDzMVWKfefVjsYOmhOD75vwjqhclu4gxUkkGJFJkCj2oYjaHnYVsC+XJvRsVUfVH/FHQnlDI+BzL/FyqqkGn9ie4H0RKuE335KDIWHpkHNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by SN7PR11MB7567.namprd11.prod.outlook.com (2603:10b6:806:328::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8398.24; Thu, 6 Feb
 2025 02:27:42 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%5]) with mapi id 15.20.8398.021; Thu, 6 Feb 2025
 02:27:42 +0000
Message-ID: <a376e87b-fbd8-4f07-9ab2-80a479782699@intel.com>
Date: Wed, 5 Feb 2025 18:27:40 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: iAVF circular lock dependency due to netdev_lock
To: Jakub Kicinski <kuba@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <81562543-5ea1-4994-9503-90b5ff19b094@intel.com>
 <20250205172325.5f7c8969@kernel.org>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20250205172325.5f7c8969@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR13CA0074.namprd13.prod.outlook.com
 (2603:10b6:a03:2c4::19) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|SN7PR11MB7567:EE_
X-MS-Office365-Filtering-Correlation-Id: abbda6f6-92b8-4e55-a264-08dd4655d552
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|376014|1800799024;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?QVlTQzBjSUd4STlNMElxekYxUmtrQ3VrdExNbmR3clJKTUZ0NGxEY29tZ3pE?=
 =?utf-8?B?RVJ5MEM1OTh2eGFhWlVzYzJ3Y0VzQm9UZ2JzRmRyRkpMUWNraU9JaHpvazFl?=
 =?utf-8?B?QnNzNjY3LzNVdDRNbm9vK3VDTVJPMXAyRlF3eW0ydmxPSlkzNjNKaU1wcXJY?=
 =?utf-8?B?eGhmQVd2dk5sNTdRVkJTdG5TZVAwV1AwdDZGcWl2V1NHckordDIxYUd0c3g2?=
 =?utf-8?B?d2s5czJkSmtJdVZROXlBNzMrVXd4RGN3T0FXc1c0Y1Bvbk5JcmdhMkl2bUV3?=
 =?utf-8?B?UG12MUJzd2xRYUJwWVF6bHNGalQwSDRpa1BCTC9nYkRuMGtjY0x6Wjh2dkg4?=
 =?utf-8?B?a2ZBQnhyY2lZS2dpbDN2bmFZYU1DSndhNkFzaWVhcjNoMURCRVV4YUVYSjBn?=
 =?utf-8?B?OGlVVTVLZXYrenV1S0dYZjlRNWM4N2xtckczRG1LVU5tU3ZhTTg0NWxhV2cw?=
 =?utf-8?B?UlU4NExUQjkrY0k2a3lwQXlHeUViWjV3RUQzeUgxWVJ4aEtGZFYxT1cvUDd1?=
 =?utf-8?B?NEdHU2xmamZVSDN4RkxLV3pOWWRNMHgxN1BHUlNmSzBJcWpYMmVYWHNtNGRs?=
 =?utf-8?B?c2t0QVlBRnRqSmpXOXkxdnNHY0oyYm9vZkFxMXpPdHBVZ0dEOW8xcDdJQXNE?=
 =?utf-8?B?M0lwcHBNanBnK2d1NUJ5eEJjenZUNkJrd0h1NzhGK3Nlb1dMN2diU1BZSzRF?=
 =?utf-8?B?VWNzeGJqemlxU204Ui9yWTBVc0YzMUwyVmxGa0V5eUxYK3lQRmhQdTVsVG1B?=
 =?utf-8?B?MW9qWjE2QXBFQm55cUNQTkMyaG5JZ3NDSllwY0NhaVZzNG1FQnV2eE83SXpQ?=
 =?utf-8?B?UFpFajU0bDFvMHk4UXlyQTI2SndLZUhobENpajFDUHJlNkxPako3ckUxYVFY?=
 =?utf-8?B?aGVsckdnZW9lQ3d1a2FKdnVsT3BmR2JhLy9jNGdNOXdTdXhrakZuM2xtL2k1?=
 =?utf-8?B?Vkp4MVNBWWFzZzM0dFBRcmxsMWtQMXlaVzVyVC9vQkduaW00bGdsamVQZ24z?=
 =?utf-8?B?S3pOYXJJaEVVTkUyMXJlQ0poN0JxcHA5R241UWJKWnI3RTFBM0xTN2txSUJh?=
 =?utf-8?B?Y3dCcUEweWMwdVkxSTFRWHo4QmxyZFo0YjJ3VFd1MXFINXZsU2krMWpmaXRO?=
 =?utf-8?B?eGJkT1pJWlVXUVZlbEZpSVAvNFAzSng4bjMrZVN0MkRlQXVsRE8ra1pWbXdn?=
 =?utf-8?B?Z3VCS0VTSUJ1OTZYUHdqU2tUTTdMTlgzZ2FFUG4zd3hmSnZpUVlnMllqSjRh?=
 =?utf-8?B?SVBMVWlOdnk3cHIrQnpkbjNIUnVXTTRaWXNOOTErdEs0Y29NNTBEYVZvSVo0?=
 =?utf-8?B?bUc1ekt2ajg5b281a0FmRUlST3V6ZVkyczFad0hhTDk4SFB0YTZTK2gxdUdn?=
 =?utf-8?B?enY3TkZXNXE4VVNPVm9xREdZcDBPRmRuM0htMThoczVtNFlrVEhYQnV5Sk9h?=
 =?utf-8?B?WEVDcW9LakZRS1ZsUU1UV3BwT1R5aEEya2tudWRjU3JYTEpNTFZVbEFmempv?=
 =?utf-8?B?Vmh6T3FzZ3RxZzBFTjd6dmY0U0VmNXRCdzJZUFUvV3dIc0puNXp5U3ZWZ2sy?=
 =?utf-8?B?UUJFbVhQcFpja24vMEdSV2RBZGZmdzJYRVl6RzY5Q2xZd0JUMHdHd3lack1j?=
 =?utf-8?B?Ni83YlJaK09ZZFpXcC9PVkdlZlFYVGg4TmsrVkZ2S0tmVzBzNk15Nlh2V2RT?=
 =?utf-8?B?Tnk0SlQrd1JtNk9yNHJwTlNDVWJhcDNCcG1QVEtWSTZHVkFTUEtBSkRJcWFh?=
 =?utf-8?B?WHFWbHVZb1VrejhwVUxPSUtvTzZHVzlaVXBmTzdyTjhFV1duekx1YUY4Tk82?=
 =?utf-8?B?dEkwSEJ6dkdYTmhyR2IyckxOVzY2bExFM2NudGJMdi9ZMVlUbE91VE1OakZt?=
 =?utf-8?Q?zcibvk4hGbKRR?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(376014)(1800799024);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VFd6R21XOU4xRWlJdGpUQkZXK3ZLRXljS1A5UlFuRHd4YVdnbXIzbHpLSDdG?=
 =?utf-8?B?Qkd6cC9Rb0Zsd2RyN1dxZmNrMGw0ZFpOd29JbndHN09ITXBxMXZka0VZeGc2?=
 =?utf-8?B?VFFPSEUwOEN6MU1JY0R5SFllUFFJbXFXSTljQk1zdUhyOVBzNEtVZEdtUW5i?=
 =?utf-8?B?SDc1U0hBVGRQQWRBeXBIV25pd20yMDZ4aXFmOHE1NjRpemVVakx2VUZncHZm?=
 =?utf-8?B?VVFQZGVmbVlVeDBSK2ZSOFVSS05oK25wSnJKSWd5NU1laHpFVFVUdFM4M0Q1?=
 =?utf-8?B?djlDL0dNN3ZNRGtSbWhvWjdzdVRJVWRIR2FoOEg0SzNRK3NxQkVLaFZCSk1m?=
 =?utf-8?B?UXFJUEFHUVdmbzNCNE9tc2lWakFiSStuTU1RU0tqZnFWM1ovQXNla3ZkNnBm?=
 =?utf-8?B?OVNBRSt2ekI5Vmp5d0wvYmlDMjhuaUk0SWJxV0RGUUNQOHFSeVBROXg0YWov?=
 =?utf-8?B?UFphRWdFUzZVaFpHWCtYVzFDTTJSZTNZWG9TSkQvMGtrd3ZESjlLYkZKTUh6?=
 =?utf-8?B?SlRkSEs3UmFXN3hwVmFIZFZORHFxRmc4TWdvZlFsbFk5WEdhbmdIcHVJa3h3?=
 =?utf-8?B?K0xiRitqMUNibTNOQUE1OUNoZzhxY1FOUk5oRXpnbUdQTGxxZ0ZrbHluOE9q?=
 =?utf-8?B?U2JoUUJmSlBUdXVGakszRVVvTTYwdHgvU1BPV3hNVStTQkYwN0taWVZpSnp0?=
 =?utf-8?B?NVFXUlhwWTVjUDZoYllUMFdYR2J2bGN5Wm5XQUZUZzFJWExjdXVyOUZ6MjhT?=
 =?utf-8?B?TVd3Vzk4MzdwWVVpUU5VRjBxZTBWZzMydGhSalBFVjBQS3VKSVRkT1VRd0VK?=
 =?utf-8?B?K05vdEk2QUE2bXFORGhiOUwrTTNoSThLWGxuVS9mWEFQY2FaLzdjdm91U2Fv?=
 =?utf-8?B?RzhGRU5oUXhIbzJzaE9VME9VMXBIZG4zclRPbFpuT2d5d0ViSGxNUWk2dEo1?=
 =?utf-8?B?M3hmY0doRnhmK0F0Um9RK3ptVlU3NXRHSTY0eGFXNzdtZlJ2NkptcFd2M2RD?=
 =?utf-8?B?VUk3ZkVYdDRIcFRsbnNFUnNkYWFxYy80UGZUbFUvb0tlclNIbEZ1Nk9sa0FT?=
 =?utf-8?B?MjBFOXNUMW12cjFFcFhadzdCbjJ3bG5YMlV5ZXZLMjg1R3lORWdiRXYrVHpW?=
 =?utf-8?B?WCtlQ0FodFl4UENZMWM3MUpWbDRzcXdZVEF3dHdNYW1HeXpFWFBFUCthVUtB?=
 =?utf-8?B?L3JvWFBUdnpwWVJEZ0JscDRDT25LdkcrWWFVUVlGcUdjZlZRcERVQ1NTaHJY?=
 =?utf-8?B?Nyt3UHgvUlhMa1BVbnFUVEdCcFNJdTdnVG56MzB0ckVBUlF5d2Z2SUtGblN5?=
 =?utf-8?B?NHpqbzgvV0xGa2VPb0p2Tnk0MjlqNDBMclJqV3M0RldvU09UR3RIWVJDeGJR?=
 =?utf-8?B?bWs0ME5vOURkNGtXd2lnem5JSjNtSEtab293dGpHUGRhMW85ZTVUcXFCdEEr?=
 =?utf-8?B?UzBaZW5acHNDREZMSWwxTHIvd2VidnNUS1k1SzdDOTgvditTOUN3S2p4QVQv?=
 =?utf-8?B?M2NyTm05aitkeHFnNU9NWWJGT3lwdjl0ZDJkRnF5a0R3dk55VEJiTDR6VzRY?=
 =?utf-8?B?eDJSMzNCUUxhRnVWRmRiVTJJb0VQWjRhNkM2aktEcEgzM3lYdW55bDBEdThH?=
 =?utf-8?B?bmdTellUc2E4Q3NJY3Nvelk3VkhKZE9aNjhEY3JYYVpSQ1laaEZkc1Y2eVlx?=
 =?utf-8?B?SGRlUUN2RjZOU29RMU5uVWdMeHM3TGV1VzljNlRoR1ZibGlOTCtHYVUyd1dx?=
 =?utf-8?B?SEdJUC85ZVRTR1NFV25Rd3FhcThVbDMyUFJONG4zWlNOOUZVNzE3aXBDZFRw?=
 =?utf-8?B?bm5YQ1hrd255SmVjeStvUmIzVHNVOEw2SllQNlRtSnlrSTcrdEVGQlgxeG1s?=
 =?utf-8?B?M2tDTTg1VlpCa3o2U2tyRjFyODNXSzAzU3dOZnJyZXBrQ2dRMFJYSE1SNllM?=
 =?utf-8?B?RGJTQ1dyYmhIK2h4V2ZXUTlvQ3FMSjlOeVpKSDI3dnRPcEx2dUg3T1RQMzJT?=
 =?utf-8?B?eVBoM3FOYnAzQVFNUG4yRjYxcnRESjVUQk9TTnl1VmFHK3p2TlRGWVdmVkxo?=
 =?utf-8?B?dit6eU9HK0V5QU1paEg5eUxCYnJndkVOSDE4eHlrUGNTUDlTM2dKOHRQRVpq?=
 =?utf-8?B?RWRHZDhMM1ROT1lBaXB5M2hRVlRwSmV0UFFFcHppWERDYmcvU1FhQm9Da2tN?=
 =?utf-8?B?NFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: abbda6f6-92b8-4e55-a264-08dd4655d552
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2025 02:27:42.4060
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lh9KGYFt5W3+4ni+WoSDLPlpNSqQd4kNtXd+Z2S6BPaAzF+f7floGdYqWvWjmYGafVOX8bton134RUJrIK5MEyl0+oA3b+rMP59js3N+ijw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7567
X-OriginatorOrg: intel.com



On 2/5/2025 5:23 PM, Jakub Kicinski wrote:
> On Wed, 5 Feb 2025 15:20:07 -0800 Jacob Keller wrote:
>> This happens because the driver takes netdev_lock prior to acquiring its
>> own adapter->crit_lock, but then it calls register_netdevice under the
>> crit_lock. Since commit 5fda3f35349b ("net: make netdev_lock() protect
>> netdev->reg_state"), the register_netdevice() function now acquires
>> netdev_lock as part of its flow.
>>
>> I can fix this by refactoring iavf to only take netdev_lock after
>> acquiring its own crit_lock.. but that smells funny. It seems like a
>> future change could require to take netdev_lock before calling into the
>> driver routines somehow, making that ordering problematic.
>>
>> I'm not sure how else to fix this... I briefly considered just removing
>> crit_lock and relying solely on netdev_lock for synchronization, but
>> that doesn't work because of the register_netdevice() taking the lock.
>>
>> I guess I could do some funky stuff with unlocking but that seems ugly
>> as well...
>>
>> I'm not sure what we should do to fix this.
> 
> Not sure either, the locking in this driver is quite odd. Do you know
> why it's registering the netdev from a workqueue, and what the entry
> points to the driver are?
> 

Yes, the locking in iAVF has been problematic for years :(

We register the netdevice from a work queue because we are waiting on
messages from the PF over virtchnl. I don't fully understand the
motivation behind the way the initialization was moved into a work
queue, but this appears to be the historical reasoning from examining
commit logs.

> Normally before the netdev is registered it can't get called, so all 
> the locking is moot. But IDK if we need to protect from some FW
> interactions, maybe?

We had a lot of issues with locking and pain getting to the state we are
in today. I think part of the challenge is that the VF is communicating
asynchronously over virtchnl queue messages to the PF for setup.

Its a mess :( I could re-order the locks so we go "RTNL -> crit_lock ->
netdev_lock" but that will only work as long as no flow from the kernel
does something like "RTNL -> netdev_lock -> <driver callback that takes
crit lock>" which seems unlikely :(

Its a mess and I don't quite know how to dig out of it.


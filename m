Return-Path: <netdev+bounces-122944-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A69039633D2
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 23:28:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C9DFD1C214B5
	for <lists+netdev@lfdr.de>; Wed, 28 Aug 2024 21:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDFD1AC433;
	Wed, 28 Aug 2024 21:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZLrEepA7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E9B1AAE0D;
	Wed, 28 Aug 2024 21:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724880506; cv=fail; b=YSWYzyCkQ/RqAC9bvwpeBBxoFRuwWWuyNuHw8YiyeM8C37ewngG6ZqeXOXAxTn4EIefiQ/2QfArFL6XMKDfFFKBAhEfd72NoutcJj4vCgKt6Rz7UlHN6xmNOtjLdRe9+SiXiLJ7V0flRVY3AFv/HnwQcmHSlw1KUGNDlR2cHSVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724880506; c=relaxed/simple;
	bh=1iG+nAKIpcmsFAU1caqpiyURpsilqqZ+aQ9JSAmVPqs=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=m30Y1Izrvb0iNJl1Vqjr3NYHOVaWtPEPsFqSU7KQvgCW3e+Gn/sKlPw9mBzzUfeWaTlMt1NhWKidZJR/+uBGH3Kc8mTWfajbmQELJGvKw44nMDGSEiLn8HCugxjHp+whG9nYH7V0bkzLJvJ8Qcc7Q7b6rb88woBGP1YQ4ptlBhc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZLrEepA7; arc=fail smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724880504; x=1756416504;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=1iG+nAKIpcmsFAU1caqpiyURpsilqqZ+aQ9JSAmVPqs=;
  b=ZLrEepA7Azv5PwtBbHbX3zriW1JQIPOak9fB6yZoDH5G9MjCcZ3OV6a4
   i58eA7FPo4+ozwmyQPs6FahB06F15cUM0umM/oFgwaguXLuEFykEM2aYK
   NcANLKu3zg49J1E53dR3/GNgKbJv+fHUZtzgv9L9nmjDgAdI5ki9ykHL1
   yD28ChyhWLNY1gzMvkokGl0op26e0J74MPf4F+HBMpGeJBbWXQzVCVkm/
   FyxHYf6wkR45AVwUx08QGfOmvrvj2DIJc5JjPeW6Q83QYrOyloceJPdm6
   8088Sp9J1dIHaIamNYfmmDUIG3jruj+xtHmWxNHJTkNLCFAf5S3x+eRka
   g==;
X-CSE-ConnectionGUID: ncv7lq0VQqSY0IywvTiUeQ==
X-CSE-MsgGUID: hdyPZmNVTeae517enLM/Aw==
X-IronPort-AV: E=McAfee;i="6700,10204,11178"; a="23247440"
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="23247440"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2024 14:28:24 -0700
X-CSE-ConnectionGUID: 1HO/oa5HRCSWFn/gynAxHw==
X-CSE-MsgGUID: Vw7oG/KOSNm9xUKoDXLXqQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,183,1719903600"; 
   d="scan'208";a="94088042"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Aug 2024 14:28:24 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 28 Aug 2024 14:28:23 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Wed, 28 Aug 2024 14:28:23 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.173)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 28 Aug 2024 14:28:23 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KRxENHQO2mO2qhqC72zOJOm4K1OhtdDVUelfwJ9I+cyD+kNZsIkCq/fCgVDX1jn32SugnDM9NWmVoYV+Pu2n8suVEaPiL5rGs1jIWmhRjzid7Rv/CEb4YUxGbD7IOLUxCvuKU7zFtYivryvAktZIcCttw4CStlaxq38jC2PH5xkJBLN5PG1/Xs1fH4li2A6H0uGK0JIK4S5gBOSDty5A3dA/c77A6wt+XecDF6SLBzfEHhRV+c68hGREkVRznH2EBmB6nP520qiGpvcA2fAklubX2ffwN9mlPvuPrixpfayrdUi8qE+SkMLOwPoyWkOK1LxAAmcEtoeRJyaRcSUV0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7H7/oBQ8yjTWWki6bZqhlkjIVl48eWm3gl9/RC4UxIY=;
 b=lbs21QESo+Iuyv4Dejgm2G6N3X/w9OJ3MrIy2fq4FcJQMxruQXRnU0SjUSYNK3hCGTCWVT+hw6+n6v7e5HoAtBksb7DFdZKucfd8G6499JuWy9vKSl0BgQu9Z0Qq6fHh3KWv2ut1QqnFKxOzIj5Jkm4I/wzrz52g9VbJo5zMX5BXB4LBiCaMHSKqkgg6bmLriS3VhAdsH8RVQDin/IvLrFANUHpd4mLrRYFCfWTz+U/UVNiLwylV7zzEB8Q49QgB+wUdN1y9nADzFo6q3oVPXRzNqR4G2LPGdS5Nt1utGMiJH4aLTlQMWnWC/uC9UKMZQ+UNgGud5h+G6pg2M+I8Og==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by MW5PR11MB5785.namprd11.prod.outlook.com (2603:10b6:303:197::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7897.25; Wed, 28 Aug
 2024 21:28:16 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::7de8:e1b1:a3b:b8a8%2]) with mapi id 15.20.7897.021; Wed, 28 Aug 2024
 21:28:16 +0000
Message-ID: <d28b51be-4efb-4479-bb26-7f58c8251182@intel.com>
Date: Wed, 28 Aug 2024 14:28:14 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [Intel-wired-lan] [[PATCH v2 iwl-next] v2 1/4] idpf: address an
 rtnl lock splat in tx timeout recovery path
To: Manoj Vishwanathan <manojvishy@google.com>, Tony Nguyen
	<anthony.l.nguyen@intel.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, David Decotigny <decot@google.com>,
	<linux-kernel@vger.kernel.org>, <google-lan-reviews@googlegroups.com>
References: <20240826181032.3042222-1-manojvishy@google.com>
 <20240826181032.3042222-2-manojvishy@google.com>
Content-Language: en-US
From: Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20240826181032.3042222-2-manojvishy@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0353.namprd04.prod.outlook.com
 (2603:10b6:303:8a::28) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|MW5PR11MB5785:EE_
X-MS-Office365-Filtering-Correlation-Id: 24465e79-6dc9-49f6-574e-08dcc7a8549f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?a0F4UkhoUHFWNDJjNVNPdjhSRUFYODBiVitYNHBTSW5iZmo2MitLbFMyRVVa?=
 =?utf-8?B?L0dMbDFpNW0xMWVCK1VuTjZZblVFY2JBMDRJdzlyZ0k2WG0yTGV6cDNSeVcr?=
 =?utf-8?B?anh1RDdXem04dmtWNzRiS3ZZSnZ6ZTJzRkQzUkx2VE9FcjZkMkVvQlVGVzVl?=
 =?utf-8?B?OXppNjA4WWY0Vmp0bFp2a3VpdWg4WnpER3hlbm1BMVc0ZGxSb3lYcEVDU29l?=
 =?utf-8?B?NHZsMGwvZXFKbDZOSzY1TDBaRXBON0FqYmdEUFkrVXhLK2FrVG1ydEs1N1FY?=
 =?utf-8?B?U1FBQWFYdm5nQW0yd1M2cXNFV3c2VUg2UkFlVEtoN3YyY09oLzNXZ0xyYU94?=
 =?utf-8?B?T3ZUNDZHY0hpaXErZEpJQjBnRjkrSjdUeUVQREcycDVJNlJ4cDNBNHczbDd0?=
 =?utf-8?B?OU9iWHE0czFPaGg4ZU95TWNwUGtERVkyaFAvSGxRS0RQUEYyWUZZREgxOW5P?=
 =?utf-8?B?cVM3V3Axd09WeEplZFNIOEwwblBIZVArblZUd1RHRENlMU5FZHJhWFppRDhu?=
 =?utf-8?B?Wm9oRWtPbFNtem1LMElUbnA5ZWpubFU1L1YrRVhRS1pIcXpCTjIxVXhXMTlo?=
 =?utf-8?B?cUp4UE5CN1VtYTV1bE5MdzVZT01KeDBsVVlHZEhQVWFnOUJ1SHVVYm5NWjlS?=
 =?utf-8?B?VThEZFdsbERBK29OMTVWWVY0ZmpUNm4zZ3N3ckRBZnhPdG1Sa1ppODBTY0xK?=
 =?utf-8?B?ZEhpZ3J2MDdZeW50WXovdm1YTTN6RmJoRkhXQWgyRTFEVXNCMEpCVU5xb1lM?=
 =?utf-8?B?NnB5S29yUmcrUkJuNXVPUnRVTGpDVUVWdFJSWkpkSXNUQ3RZYm1yQTFGdkRi?=
 =?utf-8?B?d01MemJvT0krOU1DUktybTBxWGdzRnlPRzRnYUFRc211UW1DTEdkWlo4SzhM?=
 =?utf-8?B?cnZXclArY3lxaWw0VmhhczlEckZ2MEhHWVZVQUVyd3RtNFA4eEFLKzl0T0tI?=
 =?utf-8?B?dXRPNTBrVUFvamRaRFhKOEd3L1RMTnovcXdRK3pvZGQ0THlOeEszR0hZdFJS?=
 =?utf-8?B?cGVjc3gxR0tlemtqemR0TGoxUDdqZ2pjaW90YkppMTB3U0JwRC9LRFlDVEx5?=
 =?utf-8?B?a2dWdEk4dktaQ3FyYkdEb1czSjJoMk4yaVFseVYyd1VKSGJGbmhzSHJLdTFV?=
 =?utf-8?B?aUUrWnllNUFVZThscjRGY1lJWTJhVGhyRCtwbnZ0YkQyV1FwcHhJWHhKblpY?=
 =?utf-8?B?VDZDMmZwZHY2c0E0TVpMZGw5NVY5Zi9UQnIwSGgwenFJMUt0N212L1hueDRU?=
 =?utf-8?B?R2wyd3FSNEpWUFNPYm5XQTRvd0JnU2xGb3hkZHFNUjRJdmh6WGw1bWVvWkpt?=
 =?utf-8?B?U0F5ZWJ0SktzTG5LQnZWbEE1OW5NUDdvRnlJSkxUTUFWaEdLbmVBTjkwM1M5?=
 =?utf-8?B?UlMzcFZuZUpIaTdpeFFLK1psWkgxa0hYb2lFdmxnTnlibXVXM1VPZFQwVy81?=
 =?utf-8?B?cUtQQmVNY1BBbmtnQk1xQmdvSFdMaGRWdkxzL3V1SC8xaU5kckZjNGluTFVj?=
 =?utf-8?B?MGdlTGtsemdtNmI2dkRLaWtQaDB0ekM0dWp4akIzZDRzeUxObS9rZDNaNEk5?=
 =?utf-8?B?R0tFQjM0NU9yQ2RvODY3VmxiMGtXcXNmYThqMytSQnVrSHRyTGZLYklhMkVU?=
 =?utf-8?B?SzJUcUY5Qm5wWHZqVkZUenRoSlhXWTN4ZTFLMXRRcytLTTMzZW85bEdDbytT?=
 =?utf-8?B?MnNPQU5nOEljWHJXM3BvVUFjbVBTdEVMOE1aeEtZNHFsVnQyN1FZdnJUa3A0?=
 =?utf-8?B?V0h3Q2F3Nm9RZmoyNGpzR3lUbmkrV3J1dGw0RGxYSjVXUWRQZk5aQmRNMkNa?=
 =?utf-8?B?YVp1UzAxbTFSWms2d0VrZz09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UVZqdzcwK1MrTHRNRTQ3K0prSTVDVzBZSUN2SXRJRGZmcWw0d2hLbHdLbVBm?=
 =?utf-8?B?b0FadXpzK2p6UmRTTmVMZWtWY1BXampKYUcvODJnNXU2NmNnNVhVTjZqVGU5?=
 =?utf-8?B?RlhGM2J3c0JqNUtxSHlHVmQ3MlVaaUh3RkI1Q3pKM2VrV3orekhSa2hiS1la?=
 =?utf-8?B?TzZhbndBMjZLRVhRSDlxUVNYOFJqNDZDSnBwbEJEci9MekJvYUZTWmMvdGI1?=
 =?utf-8?B?Z2h5dld2YlMrait3a0FpVWtDYnJDK1d1TWdXUnBpdnRpRXlQRlN5UHlra1Bp?=
 =?utf-8?B?a1hPVFAxazNvbStxVlhFTFRFa29PQnI5M3J6YlJReVI1eVlhVGYwanpadGFx?=
 =?utf-8?B?cDlwdFljaVVLOWFjRlJHQjlWdWdBMUx3ai9HMUo5cEpaYzJkUnpJWld0UnlW?=
 =?utf-8?B?UldMazFPcTVHUGNiaTZjWTZkTVpTYWVzckplUGdDUW5aNUdBa3NuclFYYVJn?=
 =?utf-8?B?NFd4ZWcreWR2SEdrMkhqN1JUeDRiMVZjV2dNVmsxaHRvWVRiZ3NWL2ZBUjF4?=
 =?utf-8?B?UEo3N1pUZ2dyTDBSK0MyOUJoZUtFa1FaOTRVYnFZNUlXazZTTGFrOHEwWCtx?=
 =?utf-8?B?ZDdqcXQ5c3hOZkRmSDB0dzhnK3QxR2NxLy9CNmdrVmFJeitjOGhtUC8vcTZs?=
 =?utf-8?B?SjdDZWpNL3JGTjdFQ2liTFRGa0tLc3Q0SmFzSitqYUZrUm5Fc1Nyb0RBS1do?=
 =?utf-8?B?RzQzKzl5ajRoY2dlcS9wZkgxUm9KWCtXWldFNjVRUHFNQ0FGdFJFVUZCNno5?=
 =?utf-8?B?bnRmdUpKQVlyVEowRDg5c0ZPREE2ODFlVWp2blZPbEk3cFhEd1JITElBRWUx?=
 =?utf-8?B?TUNodHZuWUh5WDlHUkhIelhZUk0ybTFQQmJPQ2k1QlFwYjIyU3VqN0dIT3dk?=
 =?utf-8?B?Uk5EUVFiNmtkdjhEVnlWKzRkWjBvd1p5cklXdkJlb3Z2bk0zbWhleFRYb0I2?=
 =?utf-8?B?UG9WQk5xOHYzaHF4bGlXNWlWL0RWUDRzanRHaHl6Z0FuSWJVRmZmZkt5WFZZ?=
 =?utf-8?B?bUNLSzYrTnRkQ3IxYTllMHpCVThGdmpLS2oxcW1EcXRhMlZCOUs1eGNsVjVw?=
 =?utf-8?B?eXpSaU9UN1JZQ3QrVWxlbExaLzJxTlNXUUxQNGE1MXVpSVp3QVVBaWF5LzZH?=
 =?utf-8?B?aUlMcjhRMk02cFp1dHVsbHV0cjhzaWQ5RnBWdzRTUnJ3aTEzd1A3UkhHbTg1?=
 =?utf-8?B?ZVlEaDNFZm5OaVp4anp2d1VTRTFqYVlwRldOZHBOcjlNbVNBVW1nbjZVSzRX?=
 =?utf-8?B?Uno0K21IOEV5NGUwbDhJOFVYbm9DaXo0RGU3LzJIK2VzOTYzWnNJRjlkdE1O?=
 =?utf-8?B?UkZ4QnVOYzFKZmJmM0NoenUxaUwvNHBNUFhBL1ZQYkI1L3FCL3pHMkNNdW5K?=
 =?utf-8?B?V0NpbXc2SThqamNoQ043RGlUZkNsc2NUbGlJang1N0U2clRKbXpTaG1QbFFG?=
 =?utf-8?B?azNmb1NaTTJON0REMVdhd3FlNUM1UWVVeU5DUVRndjFaN1Z2VE1RbmdlSmlI?=
 =?utf-8?B?blVBSmk0d1RtS05mMnpaZmR5NVJ6Y3hrVThjeTFjMEJPSHVIaHgyU2t6cXhr?=
 =?utf-8?B?akdJdjdmTlNoMGhsVDhFV3c0UVJ2dG5LeDVhTlUwZmYyTzJaRExQNE1aVDRl?=
 =?utf-8?B?OC9iei91bCt4SDZzZnhxKy90M1FQdTN2UzhXamdaN2lITHM4cmVDYUFLOUpK?=
 =?utf-8?B?T1BSZnpnbHBkTnVya1RNSDV2NVpKZGdMMjlYYXF2dzFyTUJwd0FhTmpYOHRE?=
 =?utf-8?B?ZndaZHVoM1ZJSnZ4d0srMlV0aEdia0pEQ1ZudnZKOGFsSWhLckJmZzlDcXZB?=
 =?utf-8?B?NXdIamw5R21wb1d2aDMyaTAyTGxseUVVR2hCNW8zK0I2NmtOSXdxL0dRbkxH?=
 =?utf-8?B?aXlid2RmTjcyWUdUamE4MENJcSsycmYwdTE4eUJwMGtvc1VsR0dRcGhScStw?=
 =?utf-8?B?VDd4dUw1U0RkTmlianpaSzRDeFZIUldqQXM2bW02cnJpK3NldVhhcTM4cHQv?=
 =?utf-8?B?SE5kVG1LRHZsRThQdTNjOGx3KzJuc0ZxMkhBTUorbjRRb2dlS2c5T000eWdw?=
 =?utf-8?B?aWNjYlNka0s5WDcvQ1c1WVptSnBVbk1MSE1iUGwrZGJIdHZBYVBleTM0R2t2?=
 =?utf-8?B?NmlTZzRwRzBBYXA3N2UweTg3RVVyR0hUMUJQaGgwY3EzdExidjhtcWFmTlN6?=
 =?utf-8?B?aFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 24465e79-6dc9-49f6-574e-08dcc7a8549f
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Aug 2024 21:28:16.8981
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9xoGapZVGgLuLFYtbBn9X41Tmp/1pTW5fJ4iBVysLU5GiNEddvJyMEPSojlVQu6LY9djTgYBjmz18c3ldtW+VLRUVoTZFQcSHODw7qQI6+4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR11MB5785
X-OriginatorOrg: intel.com



On 8/26/2024 11:10 AM, Manoj Vishwanathan wrote:
> From: David Decotigny <decot@google.com>
> 
> Adopt the same pattern as in other places in the code to take the rtnl
> lock during hard resets.
> Tested the patch by injecting tx timeout in IDPF , observe that idpf
> recovers and IDPF comes back reachable
> 
> Without this patch causes there is a splat:
> [  270.145214] WARNING: CPU:  PID:  at net/sched/sch_generic.c:534 dev_watchdog
> 
> Fixes: d4d5587182664 (idpf: initialize interrupts and enable vport)
> Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
> ---
>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 14 +++++++++++++-
>  1 file changed, 13 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> index af2879f03b8d..806a8b6ea5c5 100644
> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
> @@ -4326,6 +4326,7 @@ int idpf_vport_intr_alloc(struct idpf_vport *vport)
>   */
>  int idpf_vport_intr_init(struct idpf_vport *vport)
>  {
> +	bool hr_reset_in_prog;
>  	char *int_name;
>  	int err;
>  
> @@ -4334,8 +4335,19 @@ int idpf_vport_intr_init(struct idpf_vport *vport)
>  		return err;
>  
>  	idpf_vport_intr_map_vector_to_qs(vport);
> +	/** 
> +	 * If we're in normal up path, the stack already takes the
> +	 * rtnl_lock for us, however, if we're doing up as a part of a
> +	 * hard reset, we'll need to take the lock ourself before
> +	 * touching the netdev.
> +	 */
> +	hr_reset_in_prog = test_bit(IDPF_HR_RESET_IN_PROG,
> +					vport->adapter->flags);
> +	if (hr_reset_in_prog)
> +		rtnl_lock();
>  	idpf_vport_intr_napi_add_all(vport);
> -
> +	if (hr_reset_in_prog)
> +		rtnl_unlock();

This feels a little fragile. Why not pass the reset in progress as a
flag from the caller? Surely the caller knows whether this is happening
due to an interface up or due to a reset?


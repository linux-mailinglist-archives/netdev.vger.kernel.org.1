Return-Path: <netdev+bounces-86751-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16F5C8A027B
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 23:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C0D212833C0
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 21:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA626184107;
	Wed, 10 Apr 2024 21:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VJhNODqL"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F04CC1836F7
	for <netdev@vger.kernel.org>; Wed, 10 Apr 2024 21:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.19
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712786233; cv=fail; b=FSh4bJT1oEhWdEmSLcWnbpgyXUxCfOnsKlVxo899fbot/2plju1K/oom7VGhRf07aDtO3cZuT9XQuNot56m8tj3uHdTZT7SdlFxzguE9u93Om0cC78zxx+he6V0aQnfe3q7KNxBqFvYYI+IWnCiTJaYIUrPnGq92fU2f2SynGuI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712786233; c=relaxed/simple;
	bh=xdAxZlGVAVhOosRM+hXsXPUecnR61bQSO1nJuifjdD0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=LM4mfLDEIqkDc28dPZh1lf9gabQ5GdMWQxFUKHt7Ea3MswtzPGNDRPsSjZOlEYRIxqpBrxfaRcFvFGvIb+wXacziO2J8SYEoHh6ACuMpKlckBkvsupVMqPvMKKuPu0y8rbXE78+6oykHB7rDRig8JeeWE8+O87kCF4egRgDiH7E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VJhNODqL; arc=fail smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712786232; x=1744322232;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=xdAxZlGVAVhOosRM+hXsXPUecnR61bQSO1nJuifjdD0=;
  b=VJhNODqLFXpNVOGidbWREGkxcPkwESG3gV4tvn8S3tutfUQUAbFlYqxe
   b+LnWemdSbrGelbQ4uSrygablaWEpEZtemXO3vPW+ab+lnDdmFlEHYbdq
   qjAZFC/9OhUSta82trRvj+Du0TSCF7RYrcmCAizzbnUx8hcjS/6aZhK3R
   Nx+TNe0P3QvNc7Kj8//TyZX/Y+urIEQRClA7UEEjvUsNqZvkd4jMpTwyY
   QsElUJ8azpWVIGxY130IAMV2l398wu7rWkN+V3c82e7Lr0v4S3m1XFSuX
   jepDOguFfZpouQJDrJ9AlDJqPkgCUkOjH2GsYS95QfIrtk6xsVUHHLaa1
   w==;
X-CSE-ConnectionGUID: DG7d/gasS8iFRypvL1NSTw==
X-CSE-MsgGUID: eLjfmfqvRbuZpY8ViZOoFA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="8052849"
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="8052849"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Apr 2024 14:57:12 -0700
X-CSE-ConnectionGUID: uVQch2mzSlak1IFmnZBgZA==
X-CSE-MsgGUID: s3r9GCHbT9y1rcgIVITIxw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,191,1708416000"; 
   d="scan'208";a="25169795"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 10 Apr 2024 14:57:11 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 14:57:10 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 10 Apr 2024 14:57:10 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 10 Apr 2024 14:57:10 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 10 Apr 2024 14:57:09 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bEkWS5XRqTQ5cEc6Ky3PJJYFeAR2/+SPUAP+mWpnSVs+5wpkmaMNOGX1Kiq9bEkC7x6FFg1vIy/eD7yOUmP2O19PgFeks36zumIS+/RdNwJdVqVGedXu0y2CViKMgsCB8up6kK81PJECbYVx5KL1XfLxm3X2ZNurDlZ7KmYkLOe7dVONPEaezDfDzQjft8cbFZeo0heBD4RbhZ0tqT9ldXqhRCABq+3UJG7WRMk0u2mFskEMKb2GDIZ9mBOTJdWA/zmVtgzy0CzONiCllCGfQS34wM7VKhn9y6PaHdrBA3HrfUM2Bh12qtDEls6i+yeSFxsoZ3WYmUmfXi0X4Uftfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kgdoCXjwAjHXTvmGdRnP++nfDLuDyDed6/hh2WtJZN0=;
 b=WbTqxYiunOaOg3cyx03AsW70oJq94IFdEegiTOh1RzYy/rVjkqVNsJh7KLgB1wBnDdU4UZB93yIVgSGUfDdvN/XB3zKpgoNHCb+FctaDIZse/d0ngIxX7kacZgVX6g/6bhQrlGTOPLSj88fm7V5QOEuisvcausK2YxpSW+8C0Ck1KLGyqHXJ65kyBtsiv6r8NfmnD/hIWUgwR3aEkQYjZY/U7HLwzYj8zcE5qsJKkhmP22/sYf67rLCRwndXb0NuzlrFFAt3ffYuRFsGCc/pksOv2GaXB0DLPk3auF0vGXle+jd2Z/2Az5M4RuDd+L+f0/lwGdHUGty4uLi8Z4brVw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by IA0PR11MB7379.namprd11.prod.outlook.com (2603:10b6:208:431::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 21:57:08 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::9c80:a200:48a2:b308%4]) with mapi id 15.20.7452.019; Wed, 10 Apr 2024
 21:57:08 +0000
Message-ID: <3fc5b573-cfcb-4ea4-4bf2-554acf1a7ebf@intel.com>
Date: Wed, 10 Apr 2024 14:57:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v7 iwl-next 00/12] Introduce ETH56G PHY model for E825C
 products
Content-Language: en-US
To: Karol Kolacinski <karol.kolacinski@intel.com>,
	<intel-wired-lan@lists.osuosl.org>
CC: <netdev@vger.kernel.org>, <jesse.brandeburg@intel.com>
References: <20240408111814.404583-14-karol.kolacinski@intel.com>
From: Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <20240408111814.404583-14-karol.kolacinski@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0357.namprd04.prod.outlook.com
 (2603:10b6:303:8a::32) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|IA0PR11MB7379:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ++Bg1mEryVtvL12ehmpiQo7tQ6+XEGoYbYLl5ezM5BH9CyGSYJIrAbGenErekQmRGLKyq+tIrBVnpiqhMVdf0NSH1JNq9LdoNNHZXJgGzP777pvucVbeh6qPjkFZPQU4iBksynN/yTpMcGjbIW1CWku8q4tx+eyfMdsIZ5nkTLU+VULAej1sU7Nknyj1tFEUYVRPIT4s6m4LXRkUfpCh2L5sraIXlgI4GveAOXH2pNEV4HaVPimTSyTn9QaNYkz2dhHeoNWEgxcXDhamvtV7K4zRawMwJhgJIVBzC0dZIGkoSW4fxVVO9XTnLmFwqbWKB3mCnQxseovZF5axhBbr8joEc6MblYUQRZi202tGitC8neS4ud8jFTCl2KV/2N14yx0Yg+3BofHVxuhop5v+Nk3N4Mj9OFHOiYLMfMBke3mKLjr0YIvZ6a5eZQfq3fH7JXQg98mT4ir5oGmAnRH1Bm7i8jGXrxOW48jZC+DC64pqBwtzg5O+vw0t+pMSdSuX57rlRVCAepOg8gFFX/YSFH3I3SVD8G5R0PQzFDSACaw1v9KpWsTqOqgAy770hHqZJIEaEnySWnr40FMbYoezYXKh9lk+4AUJJIsD/crvYLCVqI+gq/sH+HrfYqVTCYukBqs9H8U7cEnLu84ywoLBiw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(1800799015)(376005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WFlZS3JXTVJKeXFoY3JMd0ZrclFiU2NrNmdRRzdqcmNMczQ0YmlZalVMb2lJ?=
 =?utf-8?B?aHYwT3N3ZUl6blBvcVZneHQyaGx6NnpaQXI0MGVqeStablZpQUVueDNpV3BJ?=
 =?utf-8?B?bUp2ektHTmRtRzRlaFhGcGVrWkZqZnAxVzF4dzYzYTFCU2tzRVpyV0tma2p4?=
 =?utf-8?B?Zzd2YjNpNEpRUnhPWUJXTWpzbHdUNlk4M242cVA3T1UycVR0WVI0cUxIWXFG?=
 =?utf-8?B?U3Y4WGtSQmIxWFhuck9KL0dSRXlBWTRoMHNScjkwRHR2L3hhZVJFRmpKRDRO?=
 =?utf-8?B?R1V5bzU1bkFnQzVBWk5yKzA0WFdzZkE4YW4yMG5OQWtjNWVnajA0b2RVOTlr?=
 =?utf-8?B?NnVFMEVreHVvcE1Ma2dsUDZtWWdGc3Y0RzZFbjRONGdLLzJSLzZiMC85QVVJ?=
 =?utf-8?B?OGhjV1hFSzdrYXBXSVpIM2JvNm92R1V2N0J0clI0S3IvOUhuQml4cUxscTB3?=
 =?utf-8?B?NUgvMFY5cllnOG1HUmJLMzBMeEc4SmMrTjJlaU1VQzNvSEtjMjJjK0tVaTRy?=
 =?utf-8?B?WkhpdmxLWmJnZGIxY2NaRS9GbkdEYTRXQ1J0MU0yWWt2QWVXUTNybGlmcm9M?=
 =?utf-8?B?aTUrV081Zm9wKzZEcjMzclpVdnJUS052akRQbjBlZnl4d3Q0K0QrUzR1azlM?=
 =?utf-8?B?MHkrZlJvL2VNU2ZuZWlUMVh6elRXdTBQMVVUekROMmo4QVVuc2wvcGp5eWdE?=
 =?utf-8?B?VDlWT0EwOEtiSzg5SDlBMk5naDI5emU0Smd0cGo0S3hRTWc2L1JUSDN0eldm?=
 =?utf-8?B?a3RTTzc2T0VNVXNoL29ZU2NNTXpTa1JvbXo3NnJZS2VNSmx0Y0Y2MGowdXBl?=
 =?utf-8?B?UHRYZHdTUVRKZHFxVTdyM0ExOVJRSFk0VkdXam9MMkVyMUNxRlhvLy9qZEJp?=
 =?utf-8?B?UnVna2lRa1p3L1VELzh3ZDRGNnlRL1FvZVZZTmppUzVXT0IxbEl2U2ppMXEv?=
 =?utf-8?B?SmozdUNuKzV2YWVoZVBGbXg4U0Q3b016WmdhTU03YUI5V3VhRjdUQmFGWko3?=
 =?utf-8?B?YUZLYzlOT0pyTTFXWE9TWkJUdW9XeEw4QkJzbXlZOTFmMUhmVk1wVllLY1dR?=
 =?utf-8?B?RGI0K3FkNkxpU0hJdkVpdnY4U0N1UmpUY2czMmNGZmRMME9UQVpBUlNlaTQx?=
 =?utf-8?B?Z2hFSjVscU93VnNVdEJXZForNGtQRWNjQVk0UU5hRTNXL1NwK1k4MU5LRW0v?=
 =?utf-8?B?NGNWR3hLUXlrYTRtUy84enJHOVFOdkRaZThGa0RZRXJBTW9rTy8vNUxBaFVU?=
 =?utf-8?B?ZVovRW1MZEIwRkduUW9nUTJJSTBuajZXSlhRK3U1OXFWNWEyYWtvWVpYc2hx?=
 =?utf-8?B?U2F3R29wN0VFd0tRellQNVJTdDhIckY5WUJyQlZvK0E1N0FKMXZyVlYvZVA3?=
 =?utf-8?B?OHE3MXoyUDdJRUZacE1wNUgvcU1pbjlTN3ZoT3FLUFBabU1DdFlQcnFlb2ZR?=
 =?utf-8?B?cW1uOTQ2VEwzY1hyVHRRbkhYci9GeXFMN0N6cUQvZks1RGtBenRzRitFWW8w?=
 =?utf-8?B?ZldQUU1QT0JTQ3JVaWJtclRzMUpyZ3RoMTZtTUlMTEtaL3Yybmp5WEJ1T0I5?=
 =?utf-8?B?dTNWRHNxS0ZuN0w0RFdWcktZbVF0N0liTzh6NDMrand6dkQzTkN5cHZQRzZ5?=
 =?utf-8?B?VGtBcGxPbVZJbHQybC80L2V3UjAvRHU4dHpRWW1RR3BaMytIM2NhVktKUTlx?=
 =?utf-8?B?aC92RTZEMlR5OUE2NWZmc28yY3RnTiszbS81aWlZSHpDVjZ4NjY3ZjRTZitX?=
 =?utf-8?B?eS9PRlNWcE5hczA1NElSeWt5bVNuc0tQVWtleFhLaUEwSVlFMWN3TC9vOG1y?=
 =?utf-8?B?aWRoeCsxVWdUOUVmdFlyQ3JHdnVPTVJ6aXo0TmdrOEhFSThITkl0WW03czNl?=
 =?utf-8?B?anBjbG5XdWc0RTQ0cis3QWlSUXJQWGxPcFFWR0dwZklBS3B3VU5iQzdQR0Mz?=
 =?utf-8?B?Z29HSFF2MENjRTc0QS9URVNieXcwVExWK0ZoVzdraGtTN2tvQkEwSFhiQTdU?=
 =?utf-8?B?UlpFSDN1Z0RWMGdxbkpzQ1E0L0NzZ3FJa2hwS29vVUlORGVTY1cremFjcnRk?=
 =?utf-8?B?cmNka0t1dzBQVW94WnVFL1BObE5YQzF6Tm9EVEtaajRsOVFyVWlnbUdlUVEr?=
 =?utf-8?B?NjhrUmcwWWhReWhYaGdsUjNvYWIyeWVaTm9ScytWS3F1cHYya0ZiZmV0SXdr?=
 =?utf-8?B?Smc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: acd4af70-b515-4fc6-f7e0-08dc59a92a99
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 21:57:08.0428
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W4tuWnlC8fi5BMuTrSN5z4yd+zxYXIq0iGsMsmPCLDozha3j8IbxgFAf6pqYHNFG+8J8A/F6n78aDU1yStcKVQYBj/3ZAQuKorbw5DjaOBY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7379
X-OriginatorOrg: intel.com

On 4/8/2024 4:07 AM, Karol Kolacinski wrote:
> E825C products have a different PHY model than E822, E823 and E810 products.
> This PHY is ETH56G and its support is necessary to have functional PTP stack
> for E825C products.

Some of the latter patches in this series don't compile on 32bit.

Thanks,
Tony

> Grzegorz Nitka (2):
>    ice: Add NAC Topology device capability parser
>    ice: Adjust PTP init for 2x50G E825C devices
> 
> Jacob Keller (2):
>    ice: Introduce helper to get tmr_cmd_reg values
>    ice: Introduce ice_get_base_incval() helper
> 
> Karol Kolacinski (4):
>    ice: Introduce ice_ptp_hw struct
>    ice: Add PHY OFFSET_READY register clearing
>    ice: Change CGU regs struct to anonymous
>    ice: Support 2XNAC configuration using auxbus
> 
> Michal Michalik (1):
>    ice: Add support for E825-C TS PLL handling
> 
> Sergey Temerkhanov (3):
>    ice: Implement Tx interrupt enablement functions
>    ice: Move CGU block
>    ice: Introduce ETH56G PHY model for E825C products
> 
> V5 -> V6: Changes in:
>            - ice: Move CGU block
> 
> V5 -> V6: Changes in:
>            - ice: Implement Tx interrupt enablement functions
>            - ice: Move CGU block
> 
> V4 -> V5: Changes in:
>            - ice: Introduce ice_ptp_hw struct
>            - ice: Introduce helper to get tmr_cmd_reg values
>            - ice: Introduce ice_get_base_incval() helper
>            - ice: Introduce ETH56G PHY model for E825C products
>            - ice: Add support for E825-C TS PLL handling
>            - ice: Adjust PTP init for 2x50G E825C devices
> 
> V1 -> V4: Changes in:
>            - ice: Introduce ETH56G PHY model for E825C products
> 
>   drivers/net/ethernet/intel/ice/ice.h          |   23 +-
>   .../net/ethernet/intel/ice/ice_adminq_cmd.h   |    1 +
>   drivers/net/ethernet/intel/ice/ice_cgu_regs.h |   77 +-
>   drivers/net/ethernet/intel/ice/ice_common.c   |   58 +-
>   drivers/net/ethernet/intel/ice/ice_common.h   |    2 +
>   .../net/ethernet/intel/ice/ice_hw_autogen.h   |    4 +
>   drivers/net/ethernet/intel/ice/ice_ptp.c      |  265 +-
>   drivers/net/ethernet/intel/ice/ice_ptp.h      |    1 +
>   .../net/ethernet/intel/ice/ice_ptp_consts.h   |  402 ++
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 3594 +++++++++++++----
>   drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  290 +-
>   drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   10 +-
>   drivers/net/ethernet/intel/ice/ice_type.h     |   60 +-
>   13 files changed, 3873 insertions(+), 914 deletions(-)
> 
> 
> base-commit: c6f2492cda380a8bce00f61c3a4272401fbb9043


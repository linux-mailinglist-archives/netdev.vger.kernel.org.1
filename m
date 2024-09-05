Return-Path: <netdev+bounces-125405-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A943396D017
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:07:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3567B1F21D5E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 07:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 612B4192B82;
	Thu,  5 Sep 2024 07:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="R2Q7TNuE"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA60C192583
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 07:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725520055; cv=fail; b=CHx4PyOnSNbOUCM1VQ55QMZcOjQA96i8Ac8bSJjdnmz4iiXAjAkU5Ow/1plFg2pC84wZWcdoO2UHevRxFKJu25zmIB5WuTessIXco04SLhRdySUHpvCpyym2qkn0Kuzlyrtl6h34gt+Gq1PLYQ1YuPiimN82HrQaqNM5ZQhSFRc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725520055; c=relaxed/simple;
	bh=biVeRsUvcxTjjOtTY0GC2zVE5uAi/QuVm9ZIT37imXM=;
	h=Subject:To:CC:References:From:Message-ID:Date:In-Reply-To:
	 Content-Type:MIME-Version; b=TJCpv/DeM5ahLwrxrFHFSwePsQ1xzYXsABeb+hblzCAZcpPTizltKJvES2442msOWa4uyrGdZCk/PAeY/qKYGVApXclFVSDlVT00UXs9ykJZaEuaWHzliV7ncsd9SCyRVGMnf8cJgJCrL+gLslALJk8aDg1d+rxtgBwhkw4kxe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=R2Q7TNuE; arc=fail smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1725520054; x=1757056054;
  h=subject:to:cc:references:from:message-id:date:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=biVeRsUvcxTjjOtTY0GC2zVE5uAi/QuVm9ZIT37imXM=;
  b=R2Q7TNuEKjp5MeFNzkcedgYaH+NzYSzwyVVm0Y1XVZvmJnOelC6As+jm
   Xts+cnkTJEvhube9W//Myf0YxS/CnrJ19VULfqS/5SZtN7yHri6VXwTL+
   zy6R3hLk72x0zbE8NhdeO+uysgLQXv44Fvm+EAiSLrc3+sxAtbFP6Xyxt
   aGAzAgt9O08FHcycWgdS9cAadBfRXiKE8fi1P3GDrDBT9rTSCalCFJamU
   TA66vx/qokTEjrIL1A+qDvdrwJCFA9TdnuhMJQIilPlmOJ1sRVdpU9rcX
   oeKYVe8T2632vS0d8sVd8sU6napZZVKLXwk9x3Y/9VcTcndsd07UO2FVy
   w==;
X-CSE-ConnectionGUID: NqKotbg/TN6MkzME/Ws1yA==
X-CSE-MsgGUID: 0pC0T/2iSD2goT/GcJNAsw==
X-IronPort-AV: E=McAfee;i="6700,10204,11185"; a="34820823"
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="34820823"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 00:07:22 -0700
X-CSE-ConnectionGUID: xjxguFjbSYW6dvuIFpnGvA==
X-CSE-MsgGUID: eBLa1wBjQimliU3ppHdL7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,204,1719903600"; 
   d="scan'208";a="102984136"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Sep 2024 00:07:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 00:07:21 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Thu, 5 Sep 2024 00:07:20 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39 via Frontend Transport; Thu, 5 Sep 2024 00:07:20 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Sep 2024 00:07:20 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jDau/nSHBB/xjXyUNOq+zpsP3hSP42Jib1bCoIoZy6bAylW+7EqF21RF28U2msqFdRK747DBKGu/IGzqO14LcEquDHd3zMSqLvTlT/G5qwHwN+d32lwtcC+BFto0HEosSqmUO749Wy9+4DQDjRjPB/SYzNpxQt+05OW6232XBAVZh6x6CPdTvxjhkLbwurHq4azpW2UrBbqYlbgjs0s/Yzz4cbNKJh/7TTMmZHBVvA5t0GJyLfwiRMkx5cvTWSXi6En1qB0OrqmhcdShF66bjXUAJdQXkJYvu7lq2Bv7tbLBUqF/9g9g+j0wf+dNuGNqgP3jJEv9dgtvo/fmf3hMHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rJHlI/NVLaSNBfYdmV3c8IU647vwWId/iBhfFLcqShA=;
 b=j6BlrAkJh2bbroloM5N6eAAxjTckOhKScOVSPmC0sfevoAmTNa9h8f0Sr0gpnTLgHErvzMYm9rp76uUrO2ePfpbTL8/jRHSosZj7etYZeoHLwH8g76ZO5VYOSzGLlmVNSyHst5uvNydah5DWKGbOHewrz5n9qmFD3fypNADUrKi9nDsIlt382Bwzkr93hI5seEtyqlVXOSfGfEWDDg5ijmiKsyq9o8sco5WjBzF2ba4sQ358+vU5yU3+TT6UnHl9ZKKL8aP1rXYQV5Iu8WL2tOlQ3xvMIIAe3Rgt4oaepoOODFFVKVOQKNNbm2rqK1My1Ye7yqLUH7tE7Dsk+C5wOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH0PR11MB5949.namprd11.prod.outlook.com (2603:10b6:510:144::6)
 by SN7PR11MB6773.namprd11.prod.outlook.com (2603:10b6:806:266::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7918.28; Thu, 5 Sep
 2024 07:07:18 +0000
Received: from PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861]) by PH0PR11MB5949.namprd11.prod.outlook.com
 ([fe80::1c5d:e556:f779:e861%3]) with mapi id 15.20.7918.024; Thu, 5 Sep 2024
 07:07:18 +0000
Subject: Re: [PATCH net-next 3/6] igc: Add Energy Efficient Ethernet ability
To: Jakub Kicinski <kuba@kernel.org>, "Nguyen, Anthony L"
	<anthony.l.nguyen@intel.com>
CC: "davem@davemloft.net" <davem@davemloft.net>, "pabeni@redhat.com"
	<pabeni@redhat.com>, "edumazet@google.com" <edumazet@google.com>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>, "Neftin, Sasha"
	<sasha.neftin@intel.com>, "Ruinskiy, Dima" <dima.ruinskiy@intel.com>, "Dahan,
 AvigailX" <avigailx.dahan@intel.com>
References: <20240830210451.2375215-1-anthony.l.nguyen@intel.com>
 <20240830210451.2375215-4-anthony.l.nguyen@intel.com>
 <20240903124942.14021b0a@kernel.org>
From: "Lifshits, Vitaly" <vitaly.lifshits@intel.com>
Message-ID: <e56bee7c-8751-8eb3-9dd2-a7cfa54756a5@intel.com>
Date: Thu, 5 Sep 2024 10:07:11 +0300
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
In-Reply-To: <20240903124942.14021b0a@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-ClientProxiedBy: TL2P290CA0004.ISRP290.PROD.OUTLOOK.COM
 (2603:1096:950:2::13) To PH0PR11MB5949.namprd11.prod.outlook.com
 (2603:10b6:510:144::6)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR11MB5949:EE_|SN7PR11MB6773:EE_
X-MS-Office365-Filtering-Correlation-Id: b32c0f9b-cbbb-45cc-16e0-08dccd7960ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|376014|366016;
X-Microsoft-Antispam-Message-Info: =?utf-8?B?SjMwWjVlUXVTTjFqc0RzSXhzVVp5aUJ4VHdpUnFydzZJRDc2Y0hSNmluVVVv?=
 =?utf-8?B?WU5hZ2ppNXNUdmFYVzFweEMydkhYNEhtVDJhSlJteXRyVTdtNk5oRWc4UWtP?=
 =?utf-8?B?Q0h1U0xyNFV0bG5iV1B3Sjd1dUZBenBNUzFCa2pmQUFrV2ZWaXAwVlBRT3Q2?=
 =?utf-8?B?RXh5WnV5NUZ2NFlnajlHWFJJaGJ3b0dnajdYYzhlQ3UvdXBYcUVlcmFkQjA3?=
 =?utf-8?B?WnRsMnB6akpLdDFNTFZCL0xiV0hGOVJYNmRLUWVySGtNQVhweTI4K2xTYXFy?=
 =?utf-8?B?QlZIY1pPeVlWamxiM0lrUXhCVjNPdU9sTlpUNFJUS1dDc3p1bkJnbnBXOU12?=
 =?utf-8?B?UWRnejZ2cWQ5N2FoUktQMFAxWmVmL2creXpodFh4ckFjc3E0QU5qdk52ZTcr?=
 =?utf-8?B?aGh2TDN6N3NZeEVPVlFkQTRHV01QK1dpdFNXc2xlMllwSFB0WUdUb1NjdUhj?=
 =?utf-8?B?dFE0c1FGQkFjaU1UejJWNXkrYWE4L0JkbEdPZVUraXJBZHl1VDdaWlRzQURq?=
 =?utf-8?B?cXdSdCtkZzZpQlRiY0dlVGNhYk5UR1RjZnFRYmxhaGtTT2M1Sm53L2lDZmMz?=
 =?utf-8?B?V25ZdEtqMlQwMDZtVldISk9qT2ZUSjRmWUxuVzhXLzB6aC9jT29jMkw5VDl0?=
 =?utf-8?B?emcwYWorQmhhWm1OQ1lJbWRuS3FxNGpUSjhIOFNBOEVDUE1STmZSVDlFWVFz?=
 =?utf-8?B?RXdZVVROUlFHN2tLc1dhcE9XeHl2d2hoUVpRYUw0dEFNTERqeHBmQTFUN2tp?=
 =?utf-8?B?MWloWTNYVHNlZHlOd2RnMHN1cUpOSjJrRy91YUF3dmR2L3M5TmhQZ1hydnM4?=
 =?utf-8?B?cU1NaHlvZGxtM3NOcVYzNlJ5TG9zYklkaUZGWTVvYjBmdXZmTVZrMnZRclcw?=
 =?utf-8?B?TjRhM3YzQ0cycUtvaVFYY2lPZU02dDFaOWFLSVdJVERIR294NlFHTU9ERkJO?=
 =?utf-8?B?cklFVUFBODlFTFNCVDNXV0FLRU1HRlUvenI2UUY3L3FjREhaK0ozTXUwOHRt?=
 =?utf-8?B?NFBxK2UraTc3WUhHMTZlam9TTzRDRjZwU0pJQVNtSUJXSDlzUFprR21xbjhY?=
 =?utf-8?B?SklFV0xsZ3RaOGhiK1Z1eXlSVWdRMkRsN0hPQ05wRjJ0NENESngwSnJzaUFW?=
 =?utf-8?B?Z2RLdVRVZWd4SUNCQmd2K3JzazIzdDFLM2FJeGphbVlqL3lKYTRsZUFiNVNC?=
 =?utf-8?B?UHdaRXZLaWNTRHNFclB1cFdQb3RqMXBtSUJ5b2JrSzl5bGl1eWZSWDhZUWpL?=
 =?utf-8?B?QUhqejlyOUUwMERTdmlWd3RYWDlyaEsrMVg1REVlMlE2NFNldU52enhxTlhp?=
 =?utf-8?B?M3U1d082ajRzdEhuaDd0Wjl3c2gvZ2x1blB0dC9jeWdFeTZlY3JLZFkwbjVD?=
 =?utf-8?B?azZ5LzJNUXlhdlRHbkdyVTU0UndsTEZVOTFjUWIwU0IvNHlsSjI3alFSN1VS?=
 =?utf-8?B?NG9CUWR3SVRNdHU1aU90NWR3T1hvYTczMG9qS0tzWUVFTmk4MnF6b3M3R21r?=
 =?utf-8?B?Y0E2alZBMDMxNVRsN216VytsNXU4VVJNaG45aGM2NjAwTytJcFBIWTJFbUVR?=
 =?utf-8?B?S0ZnSUk4UE1GNXAyQkszVzJPTUQ2TzRQbGlyOUVmWHlBbVo3akY2N1JGWk50?=
 =?utf-8?B?ekt2S3VQVU1CKzd2cjlxbFpzM1lUa3Nkc0YyVjRXaWFQTlFqWk45ZmcyUHRy?=
 =?utf-8?B?aTFXWG40NmZrS3hYRFhHWGlFOW5oVlpXa3UramhkM1Y0cFhyOE5uZUxzZ1di?=
 =?utf-8?B?dVVhY28vMitiVmJ1ejI4Uml2NXNZaEZCWnByaEpibldvSzRhcExDWm51TFRr?=
 =?utf-8?B?UloreUJpb1JSMUtMNnc2UT09?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR11MB5949.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(376014)(366016);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NmxrdW0rN2dqK0NEcE1vV2RDakJlQ2RLU09SMEU4R1Fabk9SQnhUcXoyakJD?=
 =?utf-8?B?QXpHV08yK0M5K2d4SkUyUnk0VjJ6dU1zd0UwcHpleUFFeHBubzYyVVpMNWFV?=
 =?utf-8?B?TGl2ZXkwckpGQlh6VkxXamNXL0VBSUlndVpJSzAzUFdmOEQrN1FKVGJ4Qm5W?=
 =?utf-8?B?NmhLWHlUODdiZkxsZVNURElYcFE1VFc4aHllYWV4cUFDdGhGQUVQRUUrc3JE?=
 =?utf-8?B?WjFEUVlBYk00MFJmenJFOTJ3eEM5RDBja1RnT1BWZlk0SVpvenRGUGFFMXNR?=
 =?utf-8?B?aThDdTFtN0NvUFowYlBwM2tuY1QvZE1aRjZHVzA4YWtiSVFrTlBuMU8ycHBU?=
 =?utf-8?B?b0oxL2M2aFlibzQwTVJMdjNKWUtYMWM4T0JPU1BYbmsxbzlGcnE2YjU5NFRK?=
 =?utf-8?B?RzAwOEx1Tm8vV0dUeXpjeVl1dVF6Y1JONHhpWFprT3dwSHNUcnNtYkM3ZG4y?=
 =?utf-8?B?b1JJNmlTU0NqS3hTa1VWZUYwRVAwVXVsdHVySFo2S0JHODBmaWttSldDSDRF?=
 =?utf-8?B?YWRtSTl2ZUZCR1MwVGdMaDdqblZwWFVBNnN1dUFFQ28rRjMwK3ZCb2p2SmdL?=
 =?utf-8?B?NnFHTGRCNDRFM1I2YzlzRjUwK1VRSDY2YXlDU20xSFhzREh1LzhQc0dSa2VC?=
 =?utf-8?B?MktPR3d4Y3FCa3VjWU11RnFmcXEzR1gvWElzMXJpNVUvRjRTOHhZbjJ4UVZT?=
 =?utf-8?B?T1dCZTRabFBrSmpoTUtTb2VEQ092TlpGa1VZc1RNVEYwbzVqN1lhdktmZy9F?=
 =?utf-8?B?Wk9WOGkxSVBSVU4zNzVVQWMwMmQyRkVGaFEyYlJvaXp3M1VLNDZTS3pUd3U1?=
 =?utf-8?B?MGo3bG5vTDhVSEEwQllOVXJIK2tqNk10UVc5dXdJNGcvcUc0WTdBVGdkZUZD?=
 =?utf-8?B?VEpqSE9ZV3ppSit2VHJKRWR2TWtkOTRjM0dIV1RIL3ZhTytUN0V3K3MrSUs4?=
 =?utf-8?B?ekVxdHZMbnViSUZLd2EvTHlxb1N0MStXZis1UkxXS0E4eFZhOXFPOFF6YlFm?=
 =?utf-8?B?SlllVkRQTzRSdFVYN29meHJPd3FoNjRBSnYzYmxYdWNyM1g0cUYvUlljS3Nm?=
 =?utf-8?B?a2FmZHJuL1VZWFJjNXo3eUxUejZzdzB5TFB2ckhRVFVFcXd0VUdHUHUyamwx?=
 =?utf-8?B?T1F0YTlnNE1LeGFkWEs1Z21ud0hqaHFvaGhLaEFsRmdjZnVBZlcrM2dXYVF0?=
 =?utf-8?B?QjV6VzZnMmpIVkFSTVlySUZmWTdqbEk0VWd2UnlLRlFjUWlocUNMTm1wT08z?=
 =?utf-8?B?YkswckkvMkFISWV5WEovTUZiTVUvWXZrRkxBTjN5RklMT0ZSLy84ek13d1VV?=
 =?utf-8?B?TGVvTFZnZWtLZmV4bXRxb2RUb2xTYzY5Tk9DSk5kWEVNWjBMYno5Q21JL3dX?=
 =?utf-8?B?aDJ1b3VpMUlZdTV2ZEwwdG5Va2NGK1ZVUVhNS1FoV294WXcvdjQ3Qi9MQTR1?=
 =?utf-8?B?TTJSQXpNWEZjOGxQc0cxdUxMTVRPMDFzT1BHL1BaUnpvWU1XWGZTb2VEUHhm?=
 =?utf-8?B?dkFHRzh4SStHR3dNbERZUGN6WHNzOVhXczE4bHJqSG5CMnRYb2JRRVpmYlMv?=
 =?utf-8?B?dFNvYU1iVDBXd2t2RXkvN2FhTEp4UGdzNG1tL0x3akFRSDR5aVpuNk5UeGd2?=
 =?utf-8?B?b3FDR1duZ1Zza2p0cGN0ZE0zSElkNnZMRk9IYjZtVjZ3ZjdRYnZyV1dWZU10?=
 =?utf-8?B?SDBGdXpYSzl4UGpwRVYzT2FidzRsNFpJZ2Vqcmk3NzNvc1pPNm4wNXdxcW01?=
 =?utf-8?B?M1lEOENObVV0RWc5NHRDOGZZb2IxcmFCYVN2bU44SmlidDd2VHFybkdJa2V6?=
 =?utf-8?B?MzV3NXNHTmJMekFLN3ZrMW9VRFV4MnlzQTVGeWlBRno4Y0ZhQjhET01KdjYx?=
 =?utf-8?B?KzBjMkxoM0ZIU2FVOHBGUlpnUjBhTTlnR3dBVFJDL0IzTmNZMUpwYkxmWnVt?=
 =?utf-8?B?RGg4Vjd5dVVRaGhQRmhyaUlxUkNrMDE5dGp1SGRrL090OEpXZUwydkV5bm5P?=
 =?utf-8?B?M25ZN1hGSVk3OXZHazZuZ1BGUnNEbTFPNHkzb2dmblU2TGxlRnNZS29kRDN4?=
 =?utf-8?B?Ny95TlhoYVFETEQ4Ykc3a21hQSt4MGZaVlJ4aGx4VjB3a3lZb3BaSkROTVFM?=
 =?utf-8?B?TG5yNkVrNW43NW1qd0N1R3VpUGRXdmZIN21Rb3RZL0d2RkNCS2lnQncxMEpU?=
 =?utf-8?B?V3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b32c0f9b-cbbb-45cc-16e0-08dccd7960ec
X-MS-Exchange-CrossTenant-AuthSource: PH0PR11MB5949.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Sep 2024 07:07:18.1816
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cCNrFUec6E5EOrb7dkMJPHnbfL7Teh297gfSUG/JEfFJTYanqU8wZ8QZEXV8IlzINAPKNoF97yMwkblKhji52BS6L4gK1fYOrA+g28iJbTw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6773
X-OriginatorOrg: intel.com


On 9/3/2024 10:49 PM, Jakub Kicinski wrote:
> On Fri, 30 Aug 2024 14:04:45 -0700 Tony Nguyen wrote:
>> Example:
>> ethtool --show-eee <device>
> You're only adding get support or am I misreading?
I am answering on Sasha's behalf, yes you are correct, he only added get 
support.

